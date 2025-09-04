
unit b_cdd;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, AppForms, StdCtrls, Buttons,
  Mask, ComCtrls, Menus, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxLookAndFeels, cxControls, cxContainer, cxEdit, dxSkinsCore, cxLabel,
  cxGroupBox, dxSkinsDefaultPainters, Data.DB, nxdb, dxUIAClasses,

  AppContainer,
  DataManager,

  Gim30Fields;


type
    TBoxCddForm = class(TgxForm)
    dataPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    ButtonPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ArticuloTable: TnxeTable;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    private
      FFileList : TStringList;

      ArticuloFields : TArticuloFields;
      
    public
      procedure doProcess;
    end;

var  BoxCddForm : TBoxCddForm = nil;

procedure CargaDatos;


implementation

uses   LibUtils,
       Variants,

       SBUtils,
       SBJSON,

       AppManager,
       Files,
       DataAccess,
       EnterpriseDataAccess,
       NexusRpcData,
       nxsdConst,

       Gdm60Frm,

       a_pg60,

       dmi_pga,

       dm_pve,
       dm_rde,
       dm_iex,
       dm_pga,

       b_msg,
       b_pro,
       f_prg;

{$R *.DFM}

resourceString
       RsMsg1   = 'Los datos se han cargado perfectamente.';
       RsMsg2   = 'Compruebe que el contenido de los mismos es el correcto y podrá iniciar el proceso de preventa.';
       RsMsg3   = 'Los datos no han podido ser descargados.';
       RsMsg4   = 'Compruebe que la ruta al servidor y el código del equipo móvil son los correctos y que los datos han sido generados en el equipo principal.';
       RsMsg5   = 'Obteniendo datos desde : %s.';
       RsMsg7   = 'No parece que se hayan descargado los datos de este equipo móvil en el principal.';
       RsMsg8   = 'Se ha producido un error al intentar descargar y descomprimir el fichero %s.';
       RsMsg9   = 'Ajustando el NLS de las tablas importadas.';

procedure CargaDatos;
begin
     CompruebaParametros;
     CloseAllDataModules;

     // Aunque los módulos se destruyen también en el servidor al cerrarlos en el cliente hay algunos que
     // se crean directemente en el servidor y también se tienen que cerrar, por si hay algún fichero abierto.

     NexusRpc.FreeAllSessionDataModules;

     DataAccessModule.CloseInactiveMainSessionResources;
     CreateEditForm( TBoxCddForm, BoxCddForm, TGds60Frm.PreventaSection, True );
end;

procedure TBoxCddForm.FormManagerInitializeForm;
begin
     ArticuloFields := TArticuloFields.Create( ArticuloTable );
end;

procedure TBoxCddForm.FormManagerOkButton;
begin
     CreateProcessForm( DoProcess, Caption );
end;

procedure TBoxCddForm.DoProcess;

const ListaFicheros : array[ 0..3 ] of String = ( 'Movimiento.nx1',
                                                  'LineaMovimiento.nx1',
                                                  'Efecto.nx1',
                                                  'FacturaVentas.nx1' );

var   Index : SmallInt;
      FileName,
      FilePath,
      FileExt,
      LocalFilePath : String;
      Error : Boolean;

      I : Integer;
      Codigo,
      Descripcion,
      Familia : String;
      PrecioVenta : Double;
      UnidadesPorCaja,
      DtoVenta : Decimal;
      Anotacion : String;
      
procedure DescargaDatosFTP;

var  Index : SmallInt;
     FileList : TStringList;

begin
     With ExportImport do
       begin

       FileList := TStringList.Create;

       try

         FTPClient.GetList( FileList, Preventa.DirectorioRemotoFTP, { ADetails } False );

         If   FileList.Count=0
         then begin
              ProcessFrame.AddMsg( ntError, RsMsg7 );
              ProcessFrame.Error := True;
              Exit;
              end
         else For Index := 0 to FileList.Count - 1 do
                begin
                // FileName := FileList.Strings[ Index ];
                FilePath := FileList.Strings[ Index ]; // Preventa.DirectorioRemotoFTP + '/' + FileName;
                FileName := ExtractFileNameDelim( FilePath, '/' );
                FileExt := ExtractFileExt( FileName );
                If   FileExt='.nx1'
                then begin
                     ProcessFrame.AddMsg( ntInformation, Copy( FileName, 1, Length( FileName ) - 4 ) );
                     FTPGetFile( FilePath, AddPathDelim( EnterpriseDataModule.UserDatabase.Path ) + FileName );
                     FFileList.Add( ExtractSubString ( FileName, '.' ) );
                     end;
                end;


       finally
         FileList.Free;
         end;

       end;
end;

procedure DescargaDatosServidor;

var  FileInfo : TSearchRec;

begin
     try

       try

         If   SysUtils.FindFirst( AddPathDelim( Preventa.DirectorioServidor ) + '*.nx1', faArchive, FileInfo )=0
         then repeat

                If   ( ( FileInfo.Attr and faDirectory )=0 ) and ( FileInfo.Size>0 )
                then begin
                     CopyFile( AddPathDelim( Preventa.DirectorioServidor ) + FileInfo.Name, AddPathDelim( EnterpriseDataModule.UserDatabase.Path ) + FileInfo.Name );
                     // ExportImport.DeCompressFile( AddPathDelim( EnterpriseDataModule.UserDatabase.Path ) + FileInfo.Name );
                     FFileList.Add( ExtractSubString ( FileInfo.Name, '.' ) );
                     end;

              until SysUtils.FindNext( FileInfo )<>0;

       finally
         SysUtils.FindClose( FileInfo );
         end;

     except
       ProcessFrame.AddMsg( ntError, Format( RsMsg8, [ FileInfo.Name ] ) );
       Error := True;
       raise;
       end;
end;

begin
     With ProcessFrame, Configuracion.ParametrosGlbRec do
       try

         Error := False;
         FFileList := TStringList.Create;

         try

           If   AccesoFTP
           then begin

                AddMsg( ntHeader, Self.Caption );

                With ExportImport, FTPClient do
                  try

                    FTPInit;

                    Preventa.FijaDirectorioTrabajo;  // De momento, para poder comprobar si existe el fichero Articulo.nx1

                    AddMsg( ntInformation, Format( RsMsg5, [ Preventa.DirectorioRemotoFTP ] ) );

                    If   not ExportImport.FTPFileExists( AddPathDelim( Preventa.DirectorioRemotoFTP, '/' ) + 'Articulo.nx1' )
                    then begin
                         AddMsg( ntError, RsMsg7 );
                         Error := True;
                         end
                    else begin
                         Preventa.FijaDirectorioTrabajo( ParametrosPreventaRec.CodigoEquipoMovil );
                         DescargaDatosFTP;  // Datos de éste equipo móvil

                         Preventa.FijaDirectorioTrabajo;
                         DescargaDatosFTP;  // Datos comunes
                         end;

                 finally
                   Close;
                   end;

                end
           else begin

                Preventa.FijaDirectorioTrabajo; 

                AddMsg( ntHeader, Self.Caption );
                AddMsg( ntInformation, Format( RsMsg5, [ Preventa.DirectorioServidor ] ) );

                If   not FileExists( AddPathDelim( Preventa.DirectorioServidor ) + 'Articulo.nx1' )
                then begin
                     AddMsg( ntError, RsMsg7 );
                     Error := True;
                     end
                else begin
                     Preventa.FijaDirectorioTrabajo( ParametrosPreventaRec.CodigoEquipoMovil );
                     DescargaDatosServidor;

                     Preventa.FijaDirectorioTrabajo;  // Directorio de datos comunes
                     DescargaDatosServidor;
                     end;

                end;

           If   Error
           then Abort
           else begin

                AddMsg( ntInformation, RsMsg9 );

                // Ajusto los NLS de los ficheros importados

                With FFileList do
                  For Index := 0 to Count - 1 do
                    DataAccessModule.PackTable( EnterpriseDataModule.UserDatabase, Strings[ Index ] );
                
                // Ahora ya puedo suprimir los ficheros de movimientos viejos,
                // pero solo si se trata de la aplicación de preventa independiente, y no si
                // está incluida como un módulo (suprimiría los ficheros de trabajo)
                // o no se desea que se supriman

                If   ( ProgramNumber=pnPreventa ) and not ParametrosPreventaRec.MantenerDocumentos
                then begin
                     For Index := 0 to 3 do
                       EraseFile( AddPathDelim( EnterpriseDataModule.UserDatabase.Path ) + ListaFicheros[ Index ] );
                     RegistroExportacion.SuprimeRegistros;
                     end;

                AddMsg( ntInformation, RsMsg1 );
                AddMsg( ntInformation, RsMsg2 );

                end;

         finally
           FFileList.Free;
           end;

       except on E : Exception do begin
                                  If   not( E is EAbort )
                                  then AddMsg( ntError, Trim( E.Message ) );
                                  AddMsg( ntError, RsMsg3 );
                                  AddMsg( ntError, RsMsg4 );
                                  raise;
                                  end;
          end;

end;

end.
