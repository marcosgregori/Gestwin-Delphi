unit dm_emp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, cxEdit,
  AppContainer,

  AppForms,
  DataAccess,
  DB,
  nxdb,
  DataManager,

  Gim00Fields;


type
  TEmpresaModule = class(TDataModule)
    DmEmpresaTable: TnxeTable;
    DmFicherosTable: TnxeTable;
    procedure EmpresaModuleDestroy(Sender: TObject);
    procedure EmpresaModuleCreate(Sender: TObject);
  private

    DmEmpresaFields  : TEmpresaFields;

    procedure DoUpdateRemoteFiles;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean; EmpresaFields : TEmpresaFields = nil; IsInfoControl : Boolean = False ); overload;
    function  Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( Codigo : String; EmpresaFields : TEmpresaFields = nil ) : Boolean;

    function  CompruebaDirectorio( CodigoEmpresa : String = '' ) : Boolean;
    procedure SuprimeReferencias( CodigoEmpresa : String );
    procedure InicializaRegistroEmpresa(EmpresaFields: TEmpresaFields; SoloDatosPlanificador : Boolean = False );

    procedure ActualizaFicherosRemotos;
    procedure CompruebaFicherosRemotos;
  end;

var  EmpresaModule: TEmpresaModule = nil;


function  Empresa : TEmpresaModule;

resourceString

     RsMsg1   = 'Copia de ficheros remotos';
     RsMsg2   = 'Ficheros :';
     RsMsg3   = 'El fichero [%s] no ha podido ser copiado porque esta siendo utilizado por otro usuario.';
     RsMsg4   = 'Asegúrese de que ningún usuario utiliza el fichero y reintente el proceso.';
     RsMsg5   = 'El fichero [%s] no existe en su localización remota. Se conservará la copia local del mismo.';
     RsMsg6   = 'No está definida la localización remota de los ficheros.';
     RsMsg7   = 'El path remoto a los datos se fija en la ventana ''Localización de los ficheros de datos''.'#13'Debe indicar el camino completo a los datos remotos y éste no debe coincidir con la localización local de los mismos.';
     RsMsg8   = 'Actualización de ficheros remotos.';
     RsMsg9   = '¿Desea actualizar los ficheros remotos de la Empresa?';
     RsMsg10  = 'Esta Empresa utiliza ficheros que se copian desde una ubicacion alternativa.'#13'Si no desea actualizar ahora esos ficheros, puede trabajar con la copia existente, que es la última que utilizó.';

     RsMsgPGC1 = '¿Esta seguro de que desea actualizar la contabilidad de esta Empresa al PGC 2008?';
     RsMsgPGC2 = 'El proceso de actualización es irreversible.'#13'Es aconsejable que haga copias de seguridad de sus datos antes de realizarlo.';
     RsMsgPGC3 = 'MUY IMPORTANTE : antes de realizar el proceso de adaptación debe asegurarse de que dispone de una versión actualizada de GESTWIN. Utilice el programa de ''''Actualización en línea'''' para comprobarlo.';

implementation

uses FileCtrl,
     Files,
     LibUtils,

     AppManager,
     EnterpriseDataAccess,
     ReportManager,

     Gdm00Dm,

     b_msg,
     b_pro,
     b_cda,

     dm_pai,
     dm_cnd,

     f_prg;

{$R *.dfm}

function Empresa : TEmpresaModule;
begin
     CreateDataModule( TEmpresaModule, EmpresaModule );
     Result := EmpresaModule;
end;

procedure TEmpresaModule.EmpresaModuleDestroy(Sender: TObject);
begin
     EmpresaModule := nil;
end;

procedure TEmpresaModule.Valida(     EditControl    : TcxCustomEdit;
                                 var DisplayValue  : Variant;
                                 var ErrorText     : TCaption;
                                 var Error         : Boolean;
                                     EmpresaFields : TEmpresaFields = nil;
                                     IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmEmpresaTable, [ DisplayValue ], DisplayValue, ErrorText, Error, EmpresaFields, 'Nombre', IsInfoControl );
end;

function  TEmpresaModule.Obten( Codigo        : String;
                                EmpresaFields : TEmpresaFields = nil ) : Boolean;
begin
     Result := DmEmpresaTable.FindKey( [ Codigo ] );
     If   Assigned( EmpresaFields )
     then EmpresaFields.Update( DmEmpresaTable );
end;

function TEmpresaModule.Descripcion( Codigo : String; NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmEmpresaTable, [ Codigo ], Result, NotificaSiNoExiste );
end;

procedure TEmpresaModule.EmpresaModuleCreate(Sender: TObject);
begin
     DmEmpresaFields := TEmpresaFields.Create( DmEmpresaTable );
end;

function TEmpresaModule.CompruebaDirectorio( CodigoEmpresa : String = '' ) : Boolean;

function MakeDir( NewDir : String ) : Boolean;
begin
     {$I-}
     If   SysUtils.DirectoryExists( NewDir )
     then Result := True
     else begin
          MkDir( NewDir );
          Result := IOResult=0;
          end;
     {$I+}
end;

begin

     // Solo se puede crear el subdirectorio de la Empresa si está situado en el directorio principal de
     // la aplicación.

     With DataModule00.Dictionary do
       Result := MakeDir( ApplicationPath + 'data_' + CodigoEmpresa ) and
                 MakeDir( GetUserReportsRootPath + 'reports_' + CodigoEmpresa );
end;

procedure TEmpresaModule.SuprimeReferencias( CodigoEmpresa : String );
begin
     With DataAccessModule do
       try
         ExecQuery( 'DELETE FROM Configuracion WHERE Codigo=' + QuotedStr( CodigoEmpresa ) + ' OR Codigo LIKE ' + QuotedStr( CodigoEmpresa + '.%' ) );
         ExecQuery( 'DELETE FROM Contadores WHERE CodigoEmpresa=' + QuotedStr( CodigoEmpresa ) );
         ExecQuery( 'DELETE FROM DiarioProcesos WHERE CodigoEmpresa=' + QuotedStr( CodigoEmpresa ) );
         ExecQuery( 'DELETE FROM Ficheros WHERE CodigoEmpresa=' + QuotedStr( CodigoEmpresa ) );
         ExecQuery( 'DELETE FROM InformeExterno WHERE Empresa=' + QuotedStr( CodigoEmpresa ) );
       except
         // Es solo una limpieza preventiva. No vale la pena mostrar ningun mensaje de error.
         end;
end;

procedure TEmpresaModule.CompruebaFicherosRemotos;
begin
     With DataModule00.DmEmpresaFields do
       If   ComprobarDatosRemotos.Value
       then If   ShowNotification( ntQuestionWarning, RsMsg9, RsMsg10 )=mrYes
            then ActualizaFicherosRemotos;
end;

procedure TEmpresaModule.ActualizaFicherosRemotos;
begin
     With DataModule00.DmEmpresaFields do
       If   ( RemoteDataPath.Value='' ) or ( DataPath.Value=RemoteDataPath.Value )
       then ShowNotification( ntStop, RsMsg6, RsMsg7 )
       else begin
            CompruebaAccesoLocal;
            CreateProcessForm( DoUpdateRemoteFiles, RsMsg8 );
            end;
end;

procedure TEmpresaModule.DoUpdateRemoteFiles;

var  TableIndex : SmallInt;
     FileName,
     LocalFileName,
     RemoteFileName : string;
     TableNames : TStrings;
     FicherosFields : TFicherosFields;

begin

     try

       ProcessFrame.AddMsg( ntInformation, RsMsg2 );

       With DmFicherosTable do
         begin

         Open;
         FicherosFields := TFicherosFields.Create( DmFicherosTable );
         TableNames := TStringList.Create;

         try

           GetTableNames( TableNames );

           With TableNames do
               For TableIndex := TableNames.Count - 1 downto 0 do
                 begin
                 FileName := Strings[ TableIndex ];
                 If   FindKey( [ CodigoEmpresaActual, FileName ] )
                 then If   FicherosFields.Localizacion.Value=1   // Actualización remota
                      then begin

                           ProcessFrame.CheckCanceled;

                           RemoteFileName := AddPathDelim( EnterpriseDataModule.UserRemoteDataPath ) + FileName + '.nx1';
                           LocalFileName := AddPathDelim( EnterpriseDataModule.UserDataPath ) + FileName + '.nx1';

                           ProcessFrame.AddRecordMsg( RemoteFileName + #13 + FileName );
                           Application.ProcessMessages;

                           If   FileExists( RemoteFileName )
                           then begin
                                If   IsFileAccesible( RemoteFileName )
                                then try
                                       CopyFile( RemoteFileName, LocalFileName );
                                       ProcessFrame.AddMsg( ntInformation, FileName );
                                     except
                                       end
                                else begin
                                     ProcessFrame.AddMsg( ntError, Format( RsMsg3, [ RemoteFileName ] ) );
                                     ProcessFrame.AddMsg( ntError, RsMsg4 );
                                     Abort;
                                     end;
                                end
                           else ProcessFrame.AddMsg( ntWarning, Format( RsMsg5, [ RemoteFileName ] ) );

                           end;
                 end;

         finally
           TableNames.Free;
           Close;
           end;
         end;

     except on E : Exception do ShowException( E, Self );
       end;

end;

procedure TEmpresaModule.InicializaRegistroEmpresa( EmpresaFields         : TEmpresaFields;
                                                    SoloDatosPlanificador : Boolean = False );
begin
     With EmpresaFields do
       begin

       If   not SoloDatosPlanificador
       then begin
            CodigoPais.Value := CodigoEspaña;
            Contable_MesInicial.Value := 1;

            Stock_AltasFabric.Value := True;

            Compras_DecPrecio.Value := DecimalesMoneda;
            Compras_Cantidades.Value := 0;
            Compras_Calculo.Value := 0;

            Ventas_DecPrecio.Value := DecimalesMoneda;
            Ventas_DecRecargo.Value := DecimalesMoneda;
            Ventas_Cantidades.Value := 0;
            Ventas_Calculo.Value := 0;
            Ventas_PreAutoVenta.Value := 0;
            end;

       If   InicioJornadaLaboral.Value=0
       then InicioJornadaLaboral.Value := EncodeTime( 9, 0, 0, 0 );
       If   FinJornadaLaboral.Value=0
       then FinJornadaLaboral.Value := EncodeTime( 20, 0, 0, 0 );
       If   DiasLaborables.Value=0
       then DiasLaborables.Value := 31;  // Se guarda como bits activos o inactivos dentro de un integer (Lunes a Domingo)
       end;
end;

end.
