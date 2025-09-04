
unit dm_cpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,
  cxEdit,
  cxEditRepositoryItems,

  Gim30Fields;


type
  TCapturadorModule = class(TDataModule)
    DmCapturadorTable: TnxeTable;
    procedure CapturadorModuleDestroy(Sender: TObject);
    procedure CapturadorModuleCreate(Sender: TObject);

  private

    FCapturadorFields : TCapturadorFields;

    FCapturadorActual : SmallInt;
    FDirectorioExportacion,
    FDirectorioImportacion,
    FDirectorioServidor,
    FDirectorioRemotoFTP  : String;

  public

    procedure Valida( EditControl : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean; IsInfoControl : Boolean = False );
    function  Descripcion( Value : SmallInt; NotificaSiNoExiste : Boolean ) : String;
    function  Obten( Value : SmallInt ) : boolean;

    procedure CompruebaParametros;
    procedure FijaDirectorioTrabajo( NroCapturador : SmallInt = 0; Fecha : TDateTime = 0 );

    property CapturadorActual : SmallInt read FCapturadorActual;
    property DirectorioExportacion : String read FDirectorioExportacion;
    property DirectorioImportacion : String read FDirectorioImportacion;
    property DirectorioRemotoFTP : String read FDirectorioRemotoFTP;
    property DirectorioServidor : String read FDirectorioServidor write FDirectorioServidor;

    property CapturadorFields : TCapturadorFields read FCapturadorFields;

  end;

var CapturadorModule: TCapturadorModule = nil;


function  Capturador : TCapturadorModule;

implementation

uses LibUtils,
     
     AppManager,
     Files,
     Variants,
     EnterpriseDataAccess,

     Gdm00Dm,

     dm_iex,
     dm_pga,

     a_cpt;

{$R *.DFM}

resourceString
     RsMsg1 = 'No existe un capturador con este número.|Puede consultar los existentes pulsando [F4].';
     RsMsg2 = 'No existe ningún capturador.';
     RsMsg3 = 'Debe dar de alta, al menos, un capturador para poder descargar la información.';

function Capturador : TCapturadorModule;
begin
     CreateDataModule( TCapturadorModule, CapturadorModule );
     Result := CapturadorModule;
end;

procedure TCapturadorModule.CapturadorModuleDestroy(Sender: TObject);
begin
     CapturadorModule := nil;
end;

procedure TCapturadorModule.Valida(     EditControl    : TcxCustomEdit;
                                    var DisplayValue  : Variant;
                                    var ErrorText     : TCaption;
                                    var Error         : Boolean;
                                        IsInfoControl : Boolean = False );
begin
     ValidateRelationEx( EditControl, DmCapturadorTable, [ DisplayValue ], DisplayValue, ErrorText, Error, nil, RsDescripcion, IsInfoControl );
end;

function TCapturadorModule.Descripcion( Value              : SmallInt;
                                        NotificaSiNoExiste : Boolean ) : String;
begin
     GetRelationDescription( DmCapturadorTable, [ Value ], Result, NotificaSiNoExiste, RsDescripcion );
end;

function TCapturadorModule.Obten( Value : SmallInt ) : Boolean;
begin
     Result := DmCapturadorTable.FindKey( [ Value ] );
end;

procedure TCapturadorModule.CapturadorModuleCreate(Sender: TObject);
begin
     FCapturadorFields := TCapturadorFields.Create( DmCapturadorTable );
end;

procedure TCapturadorModule.FijaDirectorioTrabajo( NroCapturador : SmallInt = 0;
                                                   Fecha         : TDateTime = 0 );

var  SubdirectorioCapturador : String;

begin

     FCapturadorActual := NroCapturador;
     SubdirectorioCapturador := '\cp_' + StrIntPadded( FCapturadorActual, 2 );

     FDirectorioExportacion := AddPathDelim( ApplicationPath ) + 'exports\capturador\data_' + CodigoEmpresaActual;
     If   NroCapturador<>0
     then StrAdd( FDirectorioExportacion, SubdirectorioCapturador );
     FDirectorioExportacion := AddPathDelim( FDirectorioExportacion );

     FDirectorioImportacion := AddPathDelim( ApplicationPath ) + 'imports\capturador\data_' + CodigoEmpresaActual;
     If   NroCapturador<>0
     then StrAdd( FDirectorioImportacion, SubdirectorioCapturador );
     FDirectorioImportacion := AddPathDelim( FDirectorioImportacion );

     FDirectorioServidor := AddPathDelim( Configuracion.ParametrosGlbRec.PathServidorDatos ) + 'capturador\data_' + CodigoEmpresaActual;
     If   NroCapturador<>0
     then StrAdd( FDirectorioServidor, SubdirectorioCapturador );
     FDirectorioServidor := AddPathDelim( FDirectorioServidor );

     FDirectorioRemotoFTP := AddPathDelim( Configuracion.ParametrosGlbRec.PathServidorDatos, '/' ) + 'capturador/data_' + CodigoEmpresaActual;
     If   NroCapturador<>0
     then StrAdd( FDirectorioRemotoFTP, '/cp_' + StrIntPadded( FCapturadorActual, 2 ) );
     FDirectorioRemotoFTP := AddPathDelim( FDirectorioRemotoFTP, '/' );

     With Configuracion.ParametrosGlbRec do
       If   ( HostFTP<>'' ) and AccesoFTP
       then ExportImport.FTPCreateDirPath( FDirectorioRemotoFTP )
       else If   PathServidorDatos<>''
            then CreateDirPath( FDirectorioServidor );

     CreateDirPath( FDirectorioExportacion );
     CreateDirPath( FDirectorioImportacion );

end;

procedure TCapturadorModule.CompruebaParametros;
begin
     If   DmCapturadorTable.RecordCount=0
     then begin
          ShowNotification( ntStop, RsMsg2, RsMsg3 );
          MntCapturadores( [] );
          Abort;
          end;

     {
     With Configuracion.ParametrosGlbRec do
       If   ( AccesoFTP and ( HostFTP='' ) ) or ( not AccesoFTP and ( PathServidorDatos='' ) )
       then begin
            ShowNotification( mbStop, RsMsg8, RsMsg6 );
            MntParametrosAplicacion;
            If   Assigned( MntPgaForm )
            then With MntPgaForm do
                   PageControl.ActivePage := FTPTabSheet;
            Abort;
            end;
       }
end;

end.
