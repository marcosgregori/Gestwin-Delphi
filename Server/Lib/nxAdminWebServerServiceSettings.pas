
{$I nxsrDefine.inc}

unit nxAdminWebServerServiceSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine;

type
  TnxAdminWebServerServiceSettings=class(TnxStateComponent)
  private
    FPort : Integer;
    FServerEngine : TnxBaseServerEngine;
    FOnChanged : TNotifyEvent;

    procedure SetServerEngine(const Value: TnxBaseServerEngine);

  protected
    function scGetActive: Boolean; override;
    procedure scSetActive(const aActive: Boolean); override;

  public
    constructor Create(aOwner: TComponent); override;
    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;

    procedure GetConfigSettings(aSettings: TnxBaseSettings); override;
    procedure LoadConfig(AConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(AConfig: TnxBaseComponentConfiguration); override;

  published

    property OnChanged: TNotifyEvent read FOnChanged write fOnChanged;

    property Port : Integer read FPort write FPort;

    property ServerEngine: TnxBaseServerEngine read fServerEngine write SetServerEngine;

  end;

implementation

uses Math,

     nxdmServer,
     BaseServerContainer;

{ TnxAdminWebServerServiceSettings }

constructor TnxAdminWebServerServiceSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'Administrador Web del servidor';
     Tag := Ord( rcService );
end;

procedure TnxAdminWebServerServiceSettings.GetConfigSettings(aSettings: TnxBaseSettings);
begin
     inherited;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'Port';
       DefaultValue := True;
       SettingType := nxstInteger;
       PropertyName := 'Port';
       EnforceValues := False;
       ValueList := '';
       end;
end;

procedure TnxAdminWebServerServiceSettings.LoadConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     Port := AConfig.GetValue( 'Port', Port );
     Active := AConfig.GetValue( 'Active', False );
end;

procedure TnxAdminWebServerServiceSettings.LoadSettingsFromStream(aReader: TnxReader);
begin
     inherited;
     With AReader do
       try
         FPort := ReadInteger;
       except
         end;
end;

procedure TnxAdminWebServerServiceSettings.SaveConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue( 'Port', Port );
end;

procedure TnxAdminWebServerServiceSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteInteger( FPort );
       end;
end;

function TnxAdminWebServerServiceSettings.scGetActive: Boolean;
begin
     Result := BaseServerContainerModule.AdminWebServerTransportEnabled;
end;

procedure TnxAdminWebServerServiceSettings.scSetActive(const aActive: Boolean);
begin
     If   not ( csDestroying in ComponentState )
     then begin
          BaseServerContainerModule.EnableAdminWebServerTransport( aActive );
          // El componente no es en realidad un TnxStateComponent, y hay que asignar el estado manualmente
          If   Active
          then State := nxsStarted
          else State := nxsStopped;
          end;
end;

procedure TnxAdminWebServerServiceSettings.SetServerEngine( const Value: TnxBaseServerEngine );
begin
     nxcRemoveDependingOn(fServerEngine);
     FServerEngine := Value;
     nxcAddDependingOn( fServerEngine );
     If   Assigned( fServerEngine )
     then Name := FServerEngine.Name +'_' + 'AdminWebServerServiceSettings'
     else Name := '';
end;

end.
