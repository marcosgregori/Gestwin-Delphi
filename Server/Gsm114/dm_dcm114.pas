
unit dm_dcm114;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gim10Fields,
  Gim30Fields,
  Gim114Fields,

  dmi_dcm114;

type

    TDocumentoControlMercanciasService = class( TSessionModule, IDocumentoControlMercanciasService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    public

    function ProximoNroOperacion : LongInt;
    end;

  TDocumentoControlMercanciasModule = class(TServerDataModule)
    DmDocumentoControlMercanciasAuxTable: TnxeTable;
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);

  private

    DmDocumentoControlMercanciasAuxFields  : TDocumentoControlMercanciasFields;

    function ExisteNroOperacion( ValorActual : LongInt ) : Boolean;

  public

    function ProximoNroOperacion : LongInt;
    end;


implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,

     nxrbTypes,
     nxrdClass,
     nxsdDataDictionaryStrings,

     AppManager,
     EnterpriseData,

     Gim00Fields,

     SessionData,

     dmi_cnd,

     dm_cnd,

     Gsm114Dm;

{$R *.DFM}

procedure TDocumentoControlMercanciasModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmDocumentoControlMercanciasAuxFields := TDocumentoControlMercanciasFields.Create( DmDocumentoControlMercanciasAuxTable );
end;

procedure TDocumentoControlMercanciasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm114.DocumentoControlMercanciasModule := nil;
end;

function TDocumentoControlMercanciasModule.ExisteNroOperacion( ValorActual : LongInt ) : Boolean;
begin
     Result := DmDocumentoControlMercanciasAuxTable.FindKey( [ SessioNDataModule.Ejercicio, ValorActual ] );
end;

function TDocumentoControlMercanciasModule.ProximoNroOperacion : LongInt;

var  ValorActual : LongInt;
     RecordFound : Boolean;

begin

     ValorActual := 0;

     With DmDocumentoControlMercanciasAuxTable do
       begin

       RecordFound := FindEqualLast( [ SessionDataModule.Ejercicio ] );
       If   RecordFound
       then ValorActual := DmDocumentoControlMercanciasAuxFields.NroOperacion.Value + 1
       else ValorActual := 2;

       ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ExisteNroOperacion, cnControlMercancias, SessionDataModule.Ejercicio, '', ValorActual, 2 );

       CompruebaValorMaximo( ValorActual );
       end;

     Result := ValorActual;
end;

{ TDocumentoControlMercanciasService }

procedure TDocumentoControlMercanciasService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TDocumentoControlMercanciasService.ProximoNroOperacion: LongInt;
begin
     Result := SessionDataModule.Dm114.DocumentoControlMercanciasModule.ProximoNroOperacion;
end;

var DocumentoControlMercancias114Control : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_DocumentoControlMercanciasService, TDocumentoControlMercanciasService, DocumentoControlMercancias114Control );

end.
