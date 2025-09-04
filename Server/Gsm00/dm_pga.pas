
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

  Gim00Fields,

  dmi_pga;


type

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
       try

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

       except
         Cancel;
         raise;
         end;

end;

end.


