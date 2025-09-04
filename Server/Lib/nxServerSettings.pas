
{$I nxsrDefine.inc}

unit nxServerSettings;

interface

uses
  Classes, nxllStreams, nxllComponent, nxsdServerEngine,

  Spring;

type
  TnxServerSettings=class(TnxComponent)
  private
    fBringUpServerOnStart: Boolean;
    fResetsStatsOnActivate: Boolean;
    fMinimizeOnStart: Boolean;
    fServerEngine: TnxBaseServerEngine;
    fAutoSaveConfig: Boolean;
    fOnChanged: Event< TNotifyEvent >;
    fCloseServerFromTrayOnly: Boolean;
    fHiddenUIPages: String;
    FNotifyExceptions,
    FBackupWeekend,
    FBackupData,
    FRebuildData : Boolean;
    FFromName,
    FFromAddress : String;
    FBackupTime,
    FRebuildTime : TTime;
    FBackupPath : String;
    FAdministrationPort : SmallInt;

    procedure SetServerEngine(const value: TnxBaseServerEngine);
    procedure SetAutoSaveConfig(const value: Boolean);
    procedure SetBackupData( const value : Boolean );

  public
    constructor Create(aOwner: TComponent); override;
    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;

    procedure GetConfigSettings(ASettings: TnxBaseSettings); override;
    procedure LoadConfig(AConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(AConfig: TnxBaseComponentConfiguration); override;
  published
    property OnChanged: Event<TNotifyEvent> read FOnChanged write FOnChanged;
    property AutosaveConfig: Boolean read fAutoSaveConfig write SetAutoSaveConfig;
    property MinimizeOnStart: Boolean read fMinimizeOnStart write fMinimizeOnStart;
    property BringUpServerOnStart: Boolean read fBringUpServerOnStart write fBringUpServerOnStart;
    property ResetsStatsOnActivate: Boolean read fResetsStatsOnActivate write fResetsStatsOnActivate;
    property CloseServerFromTrayOnly: Boolean read fCloseServerFromTrayOnly write fCloseServerFromTrayOnly;
    property ServerEngine: TnxBaseServerEngine read fServerEngine write SetServerEngine;
    property HiddenUIPages: String read fHiddenUIPages write fHiddenUIPages;
    property NotifyExceptions : Boolean read FNotifyExceptions write FNotifyExceptions;
    property FromName : String read FFromName write FFromName;
    property FromAddress : String read FFromAddress write FFromAddress;
    property BackupData : Boolean read FBackupData write SetBackupData;
    property BackupWeekend : Boolean read FBackupWeekend write FBackupWeekend;
    property BackupTime : TTime read FBackupTime write FBackupTime;
    property BackupPath : String read FBackupPath write FBackupPath;
    property RebuildData : Boolean read FRebuildData write FRebuildData;
    property RebuildTime : TTime read FRebuildTime write FRebuildTime;
    property AdministrationPort : SmallInt read FAdministrationPort write FAdministrationPort;

  end;

implementation

uses System.SysUtils,
     Math,
     nxdmServer;

{ TnxServerSettings }

constructor TnxServerSettings.Create(aOwner: TComponent);
begin
     inherited;
     DisplayName := 'Interfaz de usuario';
     Tag := Ord( rcRoot );
     FAutoSaveConfig := True;
end;

procedure TnxServerSettings.GetConfigSettings(ASettings: TnxBaseSettings);
begin
     inherited;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='BringUpServerOnStart';
       DefaultValue:=true;
       SettingType:=nxstBoolean;
       PropertyName:='BringUpServerOnStart';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='ServerWin.Top';
       DefaultValue:=true;
       SettingType:=nxstInteger;
       PropertyName:='';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='ServerWin.Left';
       DefaultValue:=true;
       SettingType:=nxstInteger;
       PropertyName:='';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='ServerWin.Width';
       DefaultValue:=true;
       SettingType:=nxstInteger;
       PropertyName:='';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='ServerWin.Height';
       DefaultValue:=true;
       SettingType:=nxstInteger;
       PropertyName:='';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='MinimizeOnStart';
       DefaultValue:=false;
       SettingType:=nxstBoolean;
       PropertyName:='MinimizeOnStart';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='ResetsStatsOnActivate';
       DefaultValue:=false;
       SettingType:=nxstBoolean;
       PropertyName:='ResetsStatsOnActivate';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='AutoSaveConfig';
       DefaultValue:=true;
       SettingType:=nxstBoolean;
       PropertyName:='AutoSaveConfig';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='CloseServerFromTrayOnly';
       DefaultValue:=false;
       SettingType:=nxstBoolean;
       PropertyName:='CloseServerFromTrayOnly';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name:='HiddenUIPages';
       DefaultValue:=true;
       SettingType:=nxstBoolean;
       PropertyName:='HiddenUIPages';
       EnforceValues:=false;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name := 'Notifications.Enabled';
       DefaultValue := True;
       SettingType := nxstBoolean;
       PropertyName := 'Notifications.Enabled';
       EnforceValues := False;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name := 'Notifications.FromName';
       SettingType := nxstString;
       PropertyName := 'Notifications.FromName';
       EnforceValues := False;
       ValueList:='';
       end;

     With ASettings.AddSetting(TnxBaseSetting.Create) do
       begin
       Name := 'Notifications.FromAddress';
       SettingType := nxstString;
       PropertyName := 'Notifications.FromAddress';
       EnforceValues := False;
       ValueList:='';
       end;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'Backup.Enabled';
       DefaultValue := True;
       SettingType := nxstBoolean;
       PropertyName := 'Backup.Enabled';
       EnforceValues := False;
       ValueList:='';
       end;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'Backup.Time';
       DefaultValue := True;
       SettingType := nxstString;
       PropertyName := 'Backup.Time';
       EnforceValues := False;
       ValueList:='';
       end;

     With ASettings.AddSetting( TnxBaseSetting.Create ) do
       begin
       Name := 'Backup.Path';
       DefaultValue := True;
       SettingType := nxstString;
       PropertyName := 'Backup.Path';
       EnforceValues := False;
       ValueList:='';
       end;
end;

procedure TnxServerSettings.LoadConfig( AConfig: TnxBaseComponentConfiguration);
begin
     inherited;
     BringUpServerOnStart:=AConfig.GetValue( 'BringUpServerOnStart', BringUpServerOnStart );
     MinimizeOnStart:=AConfig.GetValue( 'MinimizeOnStart', MinimizeOnStart );
     ResetsStatsOnActivate:=AConfig.GetValue( 'ResetsStatsOnActivate', ResetsStatsOnActivate );
     AutoSaveConfig:=AConfig.GetValue( 'AutoSaveConfig', AutoSaveConfig );
     CloseServerFromTrayOnly:=AConfig.GetValue( 'CloseServerFromTrayOnly', CloseServerFromTrayOnly );
     HiddenUIPages:=AConfig.GetValue( 'HiddenUIPages', HiddenUIPages );
     NotifyExceptions := AConfig.GetValue( 'Notifications.Enabled', NotifyExceptions );
     FromName := AConfig.GetValue( 'Notifications.FromName', FromName );
     FromAddress := AConfig.GetValue( 'Notifications.FromAddress', FromAddress );
     BackupData := AConfig.GetValue( 'Backup.Enabled', BackupData );
     BackupWeekend:= AConfig.GetValue( 'Backup.Weekend', BackupWeekend );
     BackupTime := AConfig.GetValue( 'Backup.Time', BackupTime );
     BackupPath := AConfig.GetValue( 'Backup.Path', BackupPath );
     RebuildData := AConfig.GetValue( 'Rebuild.Enabled', RebuildData );
     RebuildTime := AConfig.GetValue( 'Rebuild.Time', RebuildTime );
     AdministrationPort := AConfig.GetValue( 'AdministrationPort', AdministrationPort );

end;

procedure TnxServerSettings.LoadSettingsFromStream(aReader: TnxReader);

var  Version : Integer;

begin
     inherited;
     With aReader do
       try
         Version := ReadInteger;
         fBringUpServerOnStart:=ReadBoolean;
         fMinimizeOnStart:=ReadBoolean;
         fResetsStatsOnActivate:=ReadBoolean;
         AutoSaveConfig:=ReadBoolean;
         fCloseServerFromTrayOnly:=ReadBoolean;
         fHiddenUIPages:=ReadString;
         NotifyExceptions := ReadBoolean;
         FromName := ReadString;
         FromAddress := ReadString;
         BackupData := ReadBoolean;
         BackupWeekend:= ReadBoolean;
         BackupTime := StrToTimeDef( ReadString, EncodeTime( 3, 0, 0, 0 ) );
         BackupPath := ReadString;
         RebuildData := ReadBoolean;
         RebuildTime := StrToTimeDef( ReadString, EncodeTime( 3, 0, 0, 0 ) );
         AdministrationPort := ReadInteger;
       except
         end;
end;

procedure TnxServerSettings.SaveConfig( AConfig: TnxBaseComponentConfiguration );
begin
     inherited;
     AConfig.SetValue('BringUpServerOnStart', BringUpServerOnStart);
     AConfig.SetValue('MinimizeOnStart', MinimizeOnStart);
     AConfig.SetValue('ResetsStatsOnActivate', ResetsStatsOnActivate);
     AConfig.SetValue('AutoSaveConfig', AutoSaveConfig);
     AConfig.SetValue('CloseServerFromTrayOnly', CloseServerFromTrayOnly);
     AConfig.SetValue('HiddenUIPages', HiddenUIPages);
     AConfig.SetValue('Notifications.Enabled', NotifyExceptions);
     AConfig.SetValue('Notifications.FromName', FromName );
     AConfig.SetValue('Notifications.FromAddress', FromAddress );
     AConfig.SetValue('Backup.Enabled', BackupData );
     AConfig.SetValue('Backup.Weekend', BackupWeekend );
     AConfig.SetValue('Backup.Time', BackupTime );
     AConfig.SetValue('Backup.Path', BackupPath );
     AConfig.SetValue('Rebuild.Enabled', RebuildData );
     AConfig.SetValue('Rebuild.Time', RebuildTime );
     AConfig.SetValue('AdministrationPort', AdministrationPort );
end;

procedure TnxServerSettings.SaveSettingsToStream(aWriter: TnxWriter);
begin
     inherited;
     With AWriter do
       begin
       WriteInteger(3);
       WriteBoolean(fBringUpServerOnStart);
       WriteBoolean(fMinimizeOnStart);
       WriteBoolean(fResetsStatsOnActivate);
       WriteBoolean(fAutoSaveConfig);
       WriteBoolean(fCloseServerFromTrayOnly);
       WriteString(fHiddenUIPages);
       WriteBoolean(NotifyExceptions);
       WriteString(FromName);
       WriteString(FromAddress);
       WriteBoolean(BackupData);
       WriteBoolean(BackupWeekend);
       WriteString(TimeToStr(BackupTime));
       WriteString(BackupPath);
       WriteBoolean(RebuildData);
       WriteString(TimeToStr(RebuildTime));
       WriteInteger(AdministrationPort);
       end;
end;

procedure TnxServerSettings.SetAutoSaveConfig(const Value: Boolean);
begin
  fAutoSaveConfig := Value;
  FOnChanged.Invoke( Self );
end;

procedure TnxServerSettings.SetBackupData(const Value: Boolean);
begin
     FBackupData := Value;
     FOnChanged.Invoke( Self );
end;

procedure TnxServerSettings.SetServerEngine( const Value : TnxBaseServerEngine );
begin
  nxcRemoveDependingOn(fServerEngine);
  fServerEngine := Value;
  nxcAddDependingOn(fServerEngine);
  if Assigned(fServerEngine) then
    Name:=fServerEngine.Name+'_'+'ServerSettings'
  else
    Name:='';
end;

end.
