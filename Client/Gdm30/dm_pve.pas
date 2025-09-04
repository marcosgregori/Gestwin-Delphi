
unit dm_pve;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  AppContainer,

  AppForms,
  
  Gim10Fields,
  Gim30Fields,

  DataManager,
  DB,
  nxdb, 

  LibUtils,
  
  dmi_pve;

type
  TPreventaModule = class(TDataModule)
    ExpClienteTable: TnxeTable;
    ExpConsumosClienteTable: TnxeTable;
    ExpRutaTable: TnxeTable;
    ExpLineaRutaTable: TnxeTable;
    ExpEfectoCobrarTable: TnxeTable;
    ExpEquipoMovilTable: TnxeTable;
    ImpMovimientoTable: TnxeTable;
    ImpLineaMovimientoTable: TnxeTable;
    ImpFacturaVentasTable: TnxeTable;
    ExpVendedorTable: TnxeTable;
    ImpEfectoCobrarTable: TnxeTable;
    ImpEfectoTable: TnxeTable;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private

    FEquipoMovilActual : String;
    FFechaDescarga : TDate;
    FDirectorioExportacion,
    FDirectorioDirectoExportacion,
    FDirectorioServidor,
    FDirectorioRemotoFTP : String;

    PreventaService : IPreventaService;
    
  public

    ExpClienteFields : TClienteFields;
    ExpConsumosClienteFields : TConsumosClienteFields;
    ExpRutaFields : TRutaFields;
    ExpLineaRutaFields : TLineaRutaFields;
    ExpEfectoCobrarFields : TEfectoCobrarFields;
    ExpEquipoMovilFields : TEquipoMovilFields;
    ExpVendedorFields : TVendedorFields;

    ImpMovimientoFields : TMovimientoFields;
    ImpLineaMovimientoFields : TLineaMovimientoFields;
    ImpFacturaVentasFields : TFacturaVentasFields;
    ImpEfectoFields : TEfectoFields;
    ImpEfectoCobrarFields : TEfectoCobrarFields;

    procedure FijaDirectorioTrabajo( CodigoEquipoMovil : String = ''; Fecha : TDateTime= 0 );

    procedure AbreFicherosExportacion;
    procedure CierraFicherosExportacion( Correct : Boolean = True );

    procedure AbreFicherosImportacion;
    procedure CierraFicherosImportacion;

    procedure InsertaRegistro( Key : array of const; DestinoTable, OrigenTable : TnxeTable );

    procedure GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );

    property EquipoMovilActual : String read FEquipoMovilActual;
    property FechaDescarga : Tdate read FFechaDescarga;

    // Estos dos directorios se utilizan como repositorio intermedio en la copia de los datos iniciales desde el servidor (b_drc - Descarga de rutas y ficheros)

    property DirectorioExportacion : String read FDirectorioExportacion;
    property DirectorioDirectoExportacion : String read FDirectorioDirectoExportacion;

    property DirectorioRemotoFTP : String read FDirectorioRemotoFTP write FDirectorioRemotoFTP;
    property DirectorioServidor : String read FDirectorioServidor write FDirectorioServidor;
  end;

var
  PreventaModule: TPreventaModule = nil;


function Preventa : TPreventaModule;

resourceString
       RsCodigoEquipoMovil = 'Codigo equipo movil';
       RsNombreEquipoMovil = 'Nombre equipo movil';
       RsFechaDescarga = 'Fecha de descarga';

implementation

uses Files,
     
     AppManager,

     DataAccess,
     EnterpriseDataAccess,
     SessionDataAccess,
     NexusRpcData,

     cxEdit,
     nxsdConst,

     dm_pga,
     dm_iex;

{$R *.DFM}

resourceString
     RsMsg1  = 'No se han descargado los datos desde el equipo principal.';
     RsMsg2  = 'Utilice la ventana de descarga para obtener los datos de trabajo.';

function Preventa : TPreventaModule;
begin
     CreateDataModule( TPreventaModule, PreventaModule );
     Result := PreventaModule;
end;

procedure TPreventaModule.DataModuleCreate(Sender: TObject);
begin
     NexusRpc.CreateRemoteInstance( CLSID_PreventaService, IPreventaService, PreventaService );
end;

procedure TPreventaModule.DataModuleDestroy(Sender: TObject);
begin
     PreventaModule := nil;
end;

procedure TPreventaModule.AbreFicherosExportacion;

var  Index : SmallInt;

procedure TableOpen( Table : TnxeTable );
begin
     With Table do
       begin
       Close;  // Por si acaso
       Database.DeleteTable( TableName, '' );
       Open;
       end;
end;

begin
     SessionDataModule.ExportsDatabase.Open;

     TableOpen( ExpEquipoMovilTable );
     TableOpen( ExpClienteTable );
     TableOpen( ExpConsumosClienteTable );
     TableOpen( ExpRutaTable );
     TableOpen( ExpLineaRutaTable );
     TableOpen( ExpEfectoCobrarTable );
     TableOpen( ExpVendedorTable );

     ExpEquipoMovilFields := TEquipoMovilFields.Create( ExpEquipoMovilTable );
     ExpClienteFields := TClienteFields.Create( ExpClienteTable );
     ExpConsumosClienteFields := TConsumosClienteFields.Create( ExpConsumosClienteTable );
     ExpRutaFields := TRutaFields.Create( ExpRutaTable );
     ExpLineaRutaFields := TLineaRutaFields.Create( ExpLineaRutaTable );
     ExpEfectoCobrarFields := TEfectoCobrarFields.Create( ExpEfectoCobrarTable );
     ExpVendedorFields := TVendedorFields.Create( ExpVendedorTable );

end;

procedure TPreventaModule.CierraFicherosExportacion( Correct : Boolean = True );

var   Index  : SmallInt;

procedure CopyTable( Table : TnxeTable );

var  CompressedTableName,
     SourceFileName,
     ExportFileName  : String;

begin
     With Table do
       begin
       Close;

       // Copia los ficheros al directorio de preventa donde quedarán listos para ser recogidos desde
       // el equipo móvil

       If   Correct
       then begin

            // Copio el fichero al directorio de exportación

            SourceFileName := AddPathDelim( Database.Path ) + TableName  + '.nx1';
            ExportFileName := AddPathDelim( FDirectorioDirectoExportacion ) + TableName + '.nx1';

            CopyFile( SourceFileName, ExportFileName );

            // CompressedTableName := ExportImport.CompressFile( ExportFileName );

            // Se copian también en el repositorio, si existe

            With Configuracion.ParametrosGlbRec do
              If   ( ( HostFTP<>'' ) and AccesoFTP ) or ( FDirectorioServidor<>'' )
              then begin
                   If   AccesoFTP
                   then ExportImport.FTPPutFile( ExportFileName, AddPathDelim( Preventa.DirectorioRemotoFTP, '/' ) + TableName + '.nx1' )  // Ya no se comprimen
                   else CopyFile( ExportFileName, AddPathDelim( FDirectorioServidor ) + TableName + '.nx1' );
                   end;
            end;

       end;
end;

begin

     ExpClienteFields.Free;
     ExpConsumosClienteFields.Free;
     ExpRutaFields.Free;
     ExpLineaRutaFields.Free;
     ExpEfectoCobrarFields.Free;
     ExpEquipoMovilFields.Free;
     ExpVendedorFields.Free;

     ExpEquipoMovilTable.Close;
     ExpClienteTable.Close;
     ExpConsumosClienteTable.Close;
     ExpRutaTable.Close;
     ExpLineaRutaTable.Close;
     ExpEfectoCobrarTable.Close;
     ExpVendedorTable.Close;

     SessionDataModule.ExportsDatabase.Session.CloseInactiveTables;

     CopyTable( ExpEquipoMovilTable );
     CopyTable( ExpClienteTable );
     CopyTable( ExpConsumosClienteTable );
     CopyTable( ExpRutaTable );
     CopyTable( ExpLineaRutaTable );
     CopyTable( ExpEfectoCobrarTable );
     CopyTable( ExpVendedorTable );

end;

procedure TPreventaModule.AbreFicherosImportacion;

var   Index : SmallInt;

procedure TableOpen( Table : TnxeTable );
begin
     With Table do
       begin
       Close;  // Por si acaso

       // Ajustando las NLS

       DataAccessModule.PackTable( Database, TableName );

       Open;
       end;
end;

begin

     SessionDataModule.ImportsDatabase.Open;

     TableOpen( ImpMovimientoTable );
     TableOpen( ImpLineaMovimientoTable );
     TableOpen( ImpFacturaVentasTable );
     TableOpen( ImpEfectoTable );
     TableOpen( ImpEfectoCobrarTable );

     ImpMovimientoFields := TMovimientoFields.Create( ImpMovimientoTable );
     ImpLineaMovimientoFields := TLineaMovimientoFields.Create( ImpLineaMovimientoTable );
     ImpFacturaVentasFields := TFacturaVentasFields.Create( ImpFacturaVentasTable );
     ImpEfectoFields := TEfectoFields.Create( ImpEfectoTable );
     ImpEfectoCobrarFields := TEfectoCobrarFields.Create( ImpEfectoCobrarTable );
end;

procedure TPreventaModule.CierraFicherosImportacion;

var   Index  : SmallInt;

procedure TableClose( Table : TnxeTable );
begin
     With Table do
       begin
       Close;
       // La tabla que borro es la temporal en el directorio de importación
       Database.DeleteTable( TableName, '' );
       end;
end;

begin

     ImpMovimientoFields.Free;
     ImpLineaMovimientoFields.Free;
     ImpFacturaVentasFields.Free;
     ImpEfectoFields.Free;
     ImpEfectoCobrarFields.Free;

     TableClose( ImpMovimientoTable );
     TableClose( ImpLineaMovimientoTable );
     TableClose( ImpFacturaVentasTable );
     TableClose( ImpEfectoTable );
     TableClose( ImpEfectoCobrarTable );

     SessionDataModule.ImportsDatabase.Session.CloseInactiveTables;
end;

procedure TPreventaModule.FijaDirectorioTrabajo( CodigoEquipoMovil : String = '';
                                                 Fecha             : TDateTime = 0 );

var  Path,
     SubdirectorioEquipoMovil : String;

begin

     FEquipoMovilActual := CodigoEquipoMovil;
     FFechaDescarga := Fecha;

     SubdirectorioEquipoMovil := '\em_' + FEquipoMovilActual;

     // Aplicacion principal

     Path := 'exports\preventa\data_' + CodigoEmpresaActual;
     FDirectorioDirectoExportacion := AddPathDelim( ApplicationPath ) + Path;
     FDirectorioExportacion := AddPathDelim( ApplicationDataPath ) + Path;
     If   CodigoEquipoMovil<>''
     then begin
          StrAdd(  FDirectorioDirectoExportacion, SubdirectorioEquipoMovil );
          StrAdd(  FDirectorioExportacion, SubdirectorioEquipoMovil );
          end;

     // Módulo de preventa

     If   Configuracion.ParametrosGlbRec.PathServidorDatos=''
     then FDirectorioServidor := ApplicationPath
     else FDirectorioServidor := Configuracion.ParametrosGlbRec.PathServidorDatos;
     FDirectorioServidor := AddPathDelim( FDirectorioServidor ) + 'preventa\data_' + CodigoEmpresaActual;

     If   CodigoEquipoMovil<>''
     then StrAdd(  FDirectorioServidor, SubdirectorioEquipoMovil );

     If   Fecha<>0
     then StrAdd(  FDirectorioServidor, '\' + FormatDateTime( 'yyyy-mm-dd', Fecha ) );

     FDirectorioRemotoFTP := 'preventa/data_' + CodigoEmpresaActual;
     If   CodigoEquipoMovil<>''
     then StrAdd( FDirectorioRemotoFTP, '/em_' + FEquipoMovilActual );

     If   Fecha<>0
     then StrAdd(  FDirectorioRemotoFTP, '/' + FormatDateTime( 'yyyy-mm-dd', Fecha ) );

     With Configuracion.ParametrosGlbRec do
       If   ( HostFTP<>'' ) and AccesoFTP
       then ExportImport.FTPCreateDirPath( FDirectorioRemotoFTP )
       else { If   PathServidorDatos<>''
            then } CreateDirPath( FDirectorioServidor );

     CreateDirPath( FDirectorioDirectoExportacion );

end;

procedure TPreventaModule.InsertaRegistro( Key           : array of const;
                                           DestinoTable,
                                           OrigenTable   : TnxeTable );
begin

     If   High( Key )>-1
     then If   DestinoTable.FindKey( Key )
          then Exit;

     With DestinoTable do
       begin
       Append;
       CopyFields( OrigenTable );
       Post;
       end;
end;

procedure TPreventaModule.GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );
begin
     PreventaService.GeneraConsumos( ClienteInicial, ClienteFinal, FechaInicial, FechaFinal, UltimoPrecioDefecto, UltimoDescuentoDefecto, Maximo, CantidadMinima, Ordenacion );
end;

end.                                  

