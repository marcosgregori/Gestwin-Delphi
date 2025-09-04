
{$I nxsrDefine.inc}

unit nxFileServiceSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine;

type
  TnxFileServiceSettings=class(TnxStateComponent)
  private

    FPort : Integer;
    FInternalAddresses : String;
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
    property InternalAddresses : String read FInternalAddresses write FInternalAddresses;

    property ServerEngine: TnxBaseServerEngine read fServerEngine write SetServerEngine;

  end;

implementation

uses Math,

     nxdmServer,
     BaseServerContainer;

{ TnxFileServiceSettings }

constructor TnxFileServiceSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'Ficheros';
     Tag := Ord( rcService );
end;

procedure TnxFileServiceSettings.GetConfigSettings(aSettings: TnxBaseSettings);
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

      With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'InternalAddresses';
       SettingType := nxstString;
       PropertyName := 'InternalAddresses';
       EnforceValues := False;
       ValueList := '';
       end;
end;

procedure TnxFileServiceSettings.LoadConfig( AConfig : TnxBaseComponentConfiguration );
begin
     Port := AConfig.GetValue( 'Port', Port );
     InternalAddresses := AConfig.GetValue( 'InternalAddresses', InternalAddresses );
     Active := AConfig.GetValue( 'Active', False );
end;

procedure TnxFileServiceSettings.LoadSettingsFromStream(aReader: TnxReader);
begin
     inherited;
     With AReader do
       try
         FPort := ReadInteger;
         FInternalAddresses := ReadString;
       except
         end;
end;

procedure TnxFileServiceSettings.SaveConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue( 'Port', Port );
     AConfig.SetValue( 'InternalAddresses', InternalAddresses );
end;

procedure TnxFileServiceSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteInteger( FPort );
       WriteString( FInternalAddresses );
       end;
end;

function TnxFileServiceSettings.scGetActive: Boolean;
begin
     Result := BaseServerContainerModule.FileTransportEnabled;
end;

procedure TnxFileServiceSettings.scSetActive(const AActive: Boolean);
begin
     If   not ( csDestroying in ComponentState )
     then begin
          BaseServerContainerModule.EnableFileTransport( AActive );
          // El componente no es en realidad un TnxStateComponent, y hay que asignar el estado manualmente
          If   Active
          then State := nxsStarted
          else State := nxsStopped;
          end;
end;

procedure TnxFileServiceSettings.SetServerEngine( const Value: TnxBaseServerEngine );
begin
     nxcRemoveDependingOn( FServerEngine );
     FServerEngine := Value;
     nxcAddDependingOn( fServerEngine );
     If   Assigned( fServerEngine )
     then Name := FServerEngine.Name +'_' + 'FileServiceSettings'
     else Name := '';
end;

end.
