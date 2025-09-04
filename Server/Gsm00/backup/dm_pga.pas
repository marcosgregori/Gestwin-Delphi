
unit dm_pga;

interface

uses
  Windows, Messages, SysUtils, Classes,

  nxllTransport,
  nxptBasePooledTransport,
  nxllSimpleSession,
  nxllComponent,
  nxllPluginBase,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginClient,

  DataManager,
  ServerDataModule,
  DB,
  nxdb,
  Spring,

  Xml.Win.msxmldom,
  Xml.xmldom,
  XMLIntf,
  XMLDoc,

  Gim00Fields;

const    ctGlobal            = 0;
         ctEmpresa           = 1;
         ctUsuario           = 2;
         ctParametrosVentana = 3;
         ctBackup            = 4;
         ctCamposConsulta    = 5;

         //* 13.11.2000 Añadidos nuevos tipos de registro para almacenar
         //             parámetros varios

         //* 19.06.2002 Añadido albaranes externos
         //* 18.01.2005 Añadida la relación de ficheros de preventa

         ctRelFichExp       = 100;     // Relacion de ficheros exportados la última vez
         ctImpAlbExternos   = 101;     // Configuración del proceso de importación de albaranes externos (otras aplicaciones)
         ctRelFichPreventa  = 102;     // Relacion de ficheros que se exportan en preventa
         ctSeguridad        = 103 ;    // Configuración de seguridad : certificados y firma digital

         ParamBlobFieldName = 'Data';

         FiltroParamName    = '@Filtro';

type

  TTipoRegistroConfiguracion = ctGlobal..ctRelFichPreventa;

  TModuloOpcional    = ( moFacturaElectronica = 1,
                         moTrazabilidad = 2,
                         moPartidasPresupuestarias = 3,
                         moEnvases = 4,
                         moExportacion = 5 );

 TModulosOpcionales = set of TModuloOpcional;

 TObtenParametrosEvent = procedure of object;

  TConfiguracionModule = class(TServerDataModule)
    DmConfiguracionTable: TnxeTable;
    DmConfiguracionTableAplicacion: TSmallintField;
    DmConfiguracionTableTipo: TSmallintField;
    DmConfiguracionTableCodigo: TWideStringField;
    DmConfiguracionTableData: TBlobField;
    DmFicherosTable: TnxeTable;
    XMLDocument: TXMLDocument;
    procedure ServerDataModuleDestroy(Sender: TObject);
  private

    FOnObtenParametros : Event<TObtenParametrosEvent>;

  public

    ParametrosGlbRec : TParametrosGlbRec;
    ParametrosUsrRec : TParametrosUsrRec;

    procedure Update;
    procedure ObtenParametrosLocales;

    procedure ObtenParametros( Tipo : SmallInt; Codigo : String; var ParametrosRec : TParametrosRec );
    procedure GuardaParametros( Tipo : SmallInt; Codigo : String; var ParametrosRec : TParametrosRec );

    procedure ActualizaParametros;

    property OnObtenParametros : Event<TObtenParametrosEvent> read FOnObtenParametros write FOnObtenParametros;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Variants,
       Math,

       LibUtils,

       AppManager,
       SessionData,

       nxreRemoteServerEngine,

       MainData;

procedure TConfiguracionModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm00.ConfiguracionModule := nil;
end;

procedure TConfiguracionModule.Update;
begin
     ActualizaParametros;
     ObtenParametrosLocales;
end;

procedure TConfiguracionModule.ActualizaParametros;

var   DmFicherosFields : TFicherosFields;

begin

     With DmConfiguracionTable, ParametrosGlbRec do
       begin

       If   FindKey( [ SessionDataModule.ProgramNumber, 0, '' ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) )
       else FillChar( ParametrosGlbRec, sizeOf( ParametrosGlbRec ), #0 );

       SQLTimeOut := TiempoEsperaSQL;                     // Están en DataManager
       RemoteDataCompression := CompresionDatosRemotos;   // ..
       end;

end;

procedure TConfiguracionModule.ObtenParametrosLocales;
begin
     With DmConfiguracionTable do
       begin

       If   FindKey( [ SessionDataModule.ProgramNumber, ctGlobal, '' ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosGlbRec, SizeOf( ParametrosGlbRec ) )
       else FillChar( ParametrosGlbRec, SizeOf( ParametrosGlbRec ), #0 );

       FillChar( ParametrosUsrRec, SizeOf( ParametrosUsrRec ), #0 );
       end;

     //* Si un módulo desea que se actualicen sus parámetros cuando se obtienen los locales debe añadir un evento a OnObtenParametros

     FOnObtenParametros.Invoke;

end;

procedure TConfiguracionModule.ObtenParametros(     Tipo            : SmallInt;
                                                    Codigo          : String;
                                                var ParametrosRec   : TParametrosRec );
begin
     With DmConfiguracionTable do
       If   FindKey( [ SessionDataModule.ProgramNumber, Tipo, Codigo ] )
       then ReadMemoBuffer( DmConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) )
       else FillChar( ParametrosRec, SizeOf( ParametrosRec ), #0 );
end;

procedure TConfiguracionModule.GuardaParametros(     Tipo            : SmallInt;
                                                     Codigo          : String;
                                                 var ParametrosRec   : TParametrosRec );
begin
     With DmConfiguracionTable do
       begin

       If   FindKey( [ SessionDataModule.ProgramNumber, Tipo, Codigo ] )
       then Edit
       else begin
            Append;
            DmConfiguracionTableAplicacion.Value := SessionDataModule.ProgramNumber;
            DmConfiguracionTableTipo.Value := Tipo;
            DmConfiguracionTableCodigo.Value := Codigo;
            end;

       WriteMemoBuffer( DmConfiguracionTableData, ParametrosRec, SizeOf( ParametrosRec ) );
       Post;
       end;

end;

end.


