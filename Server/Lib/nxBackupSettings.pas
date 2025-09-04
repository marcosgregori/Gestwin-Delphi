
{$I nxsrDefine.inc}

unit nxBackupSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine;

type
  TnxBackupSettings=class(TnxStateComponent)
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

{ TnxBackupSettings }

constructor TnxBackupSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'Copias de seguridad';
     Tag := Ord( rcServer );
end;

procedure TnxBackupSettings.GetConfigSettings(aSettings: TnxBaseSettings);
begin
     inherited;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'Puerto';
       DefaultValue := 81;
       SettingType := nxstInteger;
       PropertyName := 'Port';
       EnforceValues := False;
       ValueList := '';
       end;
end;

procedure TnxBackupSettings.LoadConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     Port := AConfig.GetValue( 'Port', Port );
     Active := AConfig.GetValue( 'Active', False );
end;

procedure TnxBackupSettings.LoadSettingsFromStream(aReader: TnxReader);
begin
     inherited;
     With AReader do
       try
         FPort := ReadInteger;
       except
         end;
end;

procedure TnxBackupSettings.SaveConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue( 'Port', Port );
end;

procedure TnxBackupSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteInteger( FPort );
       end;
end;

function TnxBackupSettings.scGetActive: Boolean;
begin
     Result := BaseServerContainerModule.BackupEnabled;
end;

procedure TnxBackupSettings.scSetActive(const aActive: Boolean);
begin
     If   not ( csDestroying in ComponentState )
     then begin
          BaseServerContainerModule.EnableBackup( AActive );
          // El componente no es en realidad un TnxStateComponent, y hay que asignar el estado manualmente
          If   Active
          then State := nxsStarted
          else State := nxsStopped;
          end;
end;

procedure TnxBackupSettings.SetServerEngine( const Value: TnxBaseServerEngine );
begin
     nxcRemoveDependingOn(fServerEngine);
     FServerEngine := Value;
     nxcAddDependingOn( fServerEngine );
     If   Assigned( fServerEngine )
     then Name := FServerEngine.Name +'_' + 'BackupSettings'
     else Name := '';
end;

end.
