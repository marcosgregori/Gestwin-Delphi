
unit dm_xxx;

interface

uses
  Windows, Messages, SysUtils, Classes,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf;

type

    TxxxService = class( TSessionModule, IxxxService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;
    procedure Dispose; override;

    public

    procedure EjecutaProceso( Parametro : Boolean  );
    end;

  TxxxModule = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private

  public

    procedure EjecutaProceso( Parametro : Boolean );
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

     Asiento,

     dmi_mov,

     dm_mov,
     dm_sto;

{$R *.DFM}

procedure TxxxModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.xxxModule( True );
end;

procedure TxxxModule.ServerDataModuleCreate(Sender: TObject);
begin
     //...
end;

{ TxxxService }

procedure TxxxService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

procedure TxxxService.EjecutaProceso( Parametro : Boolean );
begin
     SessionDataModule.Dm30.xxxModule.EjecutaProceso( Parametro );
end;

procedure TxxxService.Dispose;
begin
     SessionDataModule.Dm30.FreexxxModule;
end;

procedure TxxxModule.EjecutaProceso( Parametro : Boolean );

begin

end;

var xxxControl : InxClassFactoryControl;

initialization
    TnxClassFactory.RegisterClass( CLSID_xxxService, TxxxService, xxxControl );

end.
