
{$I nxsrDefine.inc}

unit nxWebServerServiceSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine;

type
  TnxWebServerServiceSettings=class(TnxStateComponent)

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

{ TnxWebServerServiceSettings }

constructor TnxWebServerServiceSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'Servidor Web';
     Tag := Ord( rcService );
end;

procedure TnxWebServerServiceSettings.GetConfigSettings(aSettings: TnxBaseSettings);
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

procedure TnxWebServerServiceSettings.LoadConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     Port := AConfig.GetValue( 'Port', Port );
     Active := AConfig.GetValue( 'Active', False );
end;

procedure TnxWebServerServiceSettings.LoadSettingsFromStream(aReader: TnxReader);
begin
     inherited;
     With AReader do
       try
         FPort := ReadInteger;
       except
         end;
end;

procedure TnxWebServerServiceSettings.SaveConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue( 'Port', Port );
end;

procedure TnxWebServerServiceSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteInteger( FPort );
       end;
end;

function TnxWebServerServiceSettings.scGetActive: Boolean;
begin
     Result := BaseServerContainerModule.WebServerTransportEnabled;
end;

procedure TnxWebServerServiceSettings.scSetActive(const aActive: Boolean);
begin
     If   not ( csDestroying in ComponentState )
     then begin
          BaseServerContainerModule.EnableWebServerTransport( aActive );
          // El componente no es en realidad un TnxStateComponent, y hay que asignar el estado manualmente
          If   Active
          then State := nxsStarted
          else State := nxsStopped;
          end;
end;

procedure TnxWebServerServiceSettings.SetServerEngine( const Value: TnxBaseServerEngine );
begin
     nxcRemoveDependingOn(fServerEngine);
     FServerEngine := Value;
     nxcAddDependingOn( fServerEngine );
     If   Assigned( fServerEngine )
     then Name := FServerEngine.Name +'_' + 'WebServerServiceSettings'
     else Name := '';
end;

end.
