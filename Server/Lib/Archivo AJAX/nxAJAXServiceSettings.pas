
{$I nxsrDefine.inc}

unit nxAJAXServiceSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine;

type
  TnxAJAXServiceSettings=class(TnxComponent)
  private
    FServiceEnabled : Boolean;
    FPort : Integer;
    FInternalAddresses : String;
    FServerEngine : TnxBaseServerEngine;
    FOnChanged : TNotifyEvent;

    procedure SetServerEngine(const Value: TnxBaseServerEngine);
  public
    constructor Create(aOwner: TComponent); override;
    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;

    procedure GetConfigSettings(aSettings: TnxBaseSettings); override;
    procedure LoadConfig(AConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(AConfig: TnxBaseComponentConfiguration); override;

  published

    property OnChanged: TNotifyEvent read FOnChanged write fOnChanged;

    property ServiceEnabled : Boolean read FServiceEnabled write FServiceEnabled;
    property Port : Integer read FPort write FPort;
    property InternalAddresses : String read FInternalAddresses write FInternalAddresses;

    property ServerEngine: TnxBaseServerEngine read fServerEngine write SetServerEngine;

  end;

implementation

uses Math,

     nxdmServer;

{ TnxAJAXServiceSettings }

constructor TnxAJAXServiceSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'AJAX';
     Tag := Ord( rcServices );
end;

procedure TnxAJAXServiceSettings.GetConfigSettings(aSettings: TnxBaseSettings);
begin
     inherited;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'AJAXService.Enabled';
       DefaultValue := False;
       SettingType := nxstBoolean;
       PropertyName := '';
       EnforceValues := False;
       ValueList := '';
       end;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'AJAXService.Port';
       DefaultValue := True;
       SettingType := nxstInteger;
       PropertyName := '';
       EnforceValues := False;
       ValueList := '';
       end;

      With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'AJAXService.InternalAddresses';
       DefaultValue := True;
       SettingType := nxstString;
       PropertyName := '';
       EnforceValues := False;
       ValueList := '';
       end;
end;

procedure TnxAJAXServiceSettings.LoadConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     ServiceEnabled := AConfig.GetValue( 'AJAXService.Enabled', ServiceEnabled );
     Port := AConfig.GetValue( 'AJAXService.Port', Port );
     InternalAddresses := AConfig.GetValue( 'AJAXService.InternalAddresses', InternalAddresses );
end;

procedure TnxAJAXServiceSettings.LoadSettingsFromStream(aReader: TnxReader);
begin
     inherited;
     With AReader do
       try
         FServiceEnabled := ReadBoolean;
         FPort := ReadInteger;
         FInternalAddresses := ReadString;
       except
         end;
end;

procedure TnxAJAXServiceSettings.SaveConfig( AConfig : TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue( 'AJAXService.Enabled', ServiceEnabled );
     AConfig.SetValue( 'AJAXService.Port', Port );
     AConfig.SetValue( 'AJAXService.InternalAddresses', InternalAddresses );
end;

procedure TnxAJAXServiceSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteBoolean( FServiceEnabled );
       WriteInteger( FPort );
       WriteString( FInternalAddresses );
       end;
end;

procedure TnxAJAXServiceSettings.SetServerEngine( const Value: TnxBaseServerEngine );
begin
     nxcRemoveDependingOn(fServerEngine);
     FServerEngine := Value;
     nxcAddDependingOn( fServerEngine );
     If   Assigned( fServerEngine )
     then Name := FServerEngine.Name +'_' + 'AJAXServiceSettings'
     else Name := '';
end;

end.
