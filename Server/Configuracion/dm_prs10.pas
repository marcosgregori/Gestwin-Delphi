
unit dm_prs10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LibUtils,
  DB,
  Nxdb,
  DataManager,
  ServerDataModule,
  SessionIntf,

  Gdm10Fields;

type
    TProcesos10Service = class( TSessionModule, IProcesos10Service )

    protected

    procedure AssignSession( const SessionID : Integer ); override;
    procedure Dispose; override;

    end;

  TProcesos10Module = class(TServerDataModule)
    procedure ServerDataModuleDestroy(Sender: TObject);
    procedure ServerDataModuleCreate(Sender: TObject);
  private


  public


  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses DateUtils,
     nxrbTypes,
     nxrdClass,
     AppManager,
     EnterpriseData,

     Gdm00Fields,
     SessionData;

{$R *.DFM}

var Procesos10Control : InxClassFactoryControl;

procedure TProcesos10Module.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm10.Procesos10Module( True );
end;

procedure TProcesos10Module.ServerDataModuleCreate(Sender: TObject);
begin
     //..
end;

{ TProcesos10Service }

procedure TProcesos10Service.AssignSession(const SessionID: Integer);
begin
     FSessionData := GetSessionData( SessionID );
end;

procedure TProcesos10Service.Dispose;
begin
     If   SessionData.Dm10.EfectoCobrarModule<>nil
     then SessionData.Dm10.EfectoCobrarModule.Free;
end;

initialization
    TnxClassFactory.RegisterClass( CLSID_Procesos10Service, TProcesos10Service, Procesos10Control );

end.
