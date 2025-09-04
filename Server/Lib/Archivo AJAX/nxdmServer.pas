
{$I ..\Lib\nxsrDefine.inc}

{$UNDEF RemoteCommands}
{$UNDEF ASPNet}
{$UNDEF PortalGateway}
{$UNDEF DemoWebServer}
{$UNDEF UseDirectHTTP}

unit nxdmServer;

interface

uses
  SysUtils,
  Classes,
  Inifiles,
  VCL.Types,
  TypInfo,
  Contnrs,
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Variants,

  nxExeConst,

  nxllMemoryManager,
  nxllComponent,
  nxllUtils,
  nxlgEventLog,
  nxllPluginBase,
  nxllTransport,

  nxsdServerEngine,
  nxchCommandHandler,

  nxsrSqlEngineBase,
  nxsrServerEngine,
  nxsrSecurityMonitor,
//  nxsrSecurityMonitorNew,
  nxsqlEngine,
  nxSqlFunctionOrganizer,

  nxptBasePooledTransport,
  nxllZipCompressor,
  nxllRleCompressor,
  nxtnNamedPipeTransport,
  nxtwWinsockTransport,
  nxtmSharedMemoryTransport,
  {$ifndef StarterEdition}
  {$ifdef UDF_Scripts}
  nxsqlFunctionsScript,
  {$endif}
  {$ifdef UDF_NET}
  nxsqlFunctionsNET,
  {$endif}
  {$endif}

  {$ifdef PortalGateway}
  nxRTCServer,
  {$endif}

  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginServer,
  nxsiServerInfoPluginCommandHandler,

{$IFDEF DCC14OrLater}
  nxrmAllDefaults,
  nxmrServer,
{$ENDIF}

  nxseAllEngines,

{$IFDEF NX_SECURE_STD_AESCCM}
  nxsscEncryptionEngineAesCcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_STD_XTSAES}
  nxssxEncryptionEngineXtsAesComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESCBCMAC}
  nxspEncryptionEngineAesCbcMacComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESCCM}
  nxspEncryptionEngineAesCcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESGCM}
  nxspEncryptionEngineAesGcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_SHACALCBCHMAC}
  nxspEncryptionEngineShacalCbcHmacComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_XCBAES}
  nxspEncryptionEngineXcbAesComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_DH}
  nxspBaseDHSecuredTransport,
{$IFDEF NX_SECURE_PRO_DH2048_AES}
  nxspDH2048withAESSecuredTransport,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_DH8192_AES}
  nxspDH8192withAESSecuredTransport,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_DH8192_SHACAL}
  nxspDH8192withShacalSecuredTransport,
{$ENDIF}
{$ENDIF}

{$IFDEF UseReplicationMonitor}
  nxReplicationMonitor,
{$ENDIF}

  nxBaseServerComp,
  nxServerSettings,
  nxAndroidServiceSettings,
  nxFileServiceSettings,
  nxAJAXServiceSettings,
  nxWebsocketsServiceSettings,
  {$ifdef UseSummary}
  nxServerSummary,
  {$endif}
  nxServerManager,
  nxtsBaseSecuredTransport,
  {$ifndef StarterEdition}
  {$ifdef UseDirectHTTP}
  nxptTCPRequestTransport,
  {$endif}
  {$endif}
  {$ifndef CommandLineServer}
  nxsdSimpleMonitor, nxrpCommandHandler, nxrpBase, nxrpServer,
  nxConfigSettingsDB,
  {$endif}
  {$ifdef RemoteAdministration}
  nxsrRemoteAdministration,
  {$endif}
  {$ifndef StarterEdition}
  {$ifdef WebApplications}
  nxsrWebApplication,
  {$endif}
  {$ifdef DemoWebServer}
  nxsrDemoWebServer,
  {$endif}

  {$ifdef RemoteCommands}
  nxrcRemoteCommandsPluginCommandHandler,
  nxrcRemoteCommandsPluginServer,
  nxrcRopsScriptCommand,
  {$endif}
  {$ifdef ASPNet}
  nxsrHost,
  nxsrHostedApplication,
  nxsrHostedASPApp,
  {$endif}
  {$endif}
  nxtsBlowfishRC4SecuredTransport,
  nxSqlTriggerExtender,
  nxsrAuditMonitor;

type

  TRootCategory = ( rcDatabase = 0, rcServices = 1, rcStatistics = 2, rcRoot = 3 );

  TdmServerClass = class of TdmServer;

  TdmServer = class(TDataModule)
    Server: TnxServerManager;
    ServerEngine: TnxServerEngine;
    SqlEngine: TnxSqlEngine;
    ServerCommandHandler: TnxServerCommandHandler;
    TCPIPv4Transport: TnxWinsockTransport;
    NamedPipeTransport: TnxNamedPipeTransport;
    EventLog: TnxEventLog;
    SecurityMonitor: TnxSecurityMonitor;
    ServerInfoPluginCommandHandler: TnxServerInfoPluginCommandHandler;
    ServerInfoPlugin: TnxServerInfoPlugin;
    SecuredCommandHandler: TnxSecuredCommandHandler;
    RemotingServer: TnxRemotingServer;
    RemotingCommandHandler: TnxRemotingCommandHandler;
    SimpleMonitor: TnxSimpleMonitor;
    procedure tiRetryTransportsTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure SqlEngineStateChanged(Sender: TObject);
    procedure EventLogSettingsLoaded(Sender: TObject);
    procedure ServerEngineStateChanged(Sender: TObject);
  {$IFDEF UseReplicationMonitor}
  published
    nxTransactionReplicationMonitor : TnxTransactionReplicationMonitor;
  {$ENDIF}
  public
    dmSqlTriggerMonitor      : TnxSqlTriggerMonitor;

    dmAuditMonitor           : TnxAuditMonitor;

    {$ifndef CommandLineServer}
    tiRetryTransports  : TTimer;
    {$endif}

    {$ifdef RemoteAdministration}
    RemoteAdmin              : TnxRemoteAdmin;
    {$endif}

{$ifndef StarterEdition}
    {$ifdef DemoWebServer}
    DemoWebServer            : TnxDemoWebServer;
    {$endif}

    {$ifdef RemoteCommands}
    RemoteCommandsHandler    : TnxRemoteCommandsPluginCommandHandler;
    RemoteCommands           : TnxServerRemoteCommandsPlugin;
    {$endif}
{$endif}

    {$ifdef PortalGateway}
    GwCommandHandler         : TnxRTCPluginCommandHandler;
    {$endif}

    {$ifdef FullServerUI}
    ServerSettings            : TnxServerSettings;
    {$endif}

    AndroidServiceSettings    : TnxAndroidServiceSettings;
    FileServiceSettings       : TnxFileServiceSettings;
    WebsocketsServiceSettings : TnxWebsocketsServiceSettings;
    AJAXServiceSettings       : TnxAJAXServiceSettings;

{$ifndef StarterEdition}
    {$ifdef WebApplications}
    webApplications          : TnxsrWebApplications;
    {$endif}
    {$ifdef ASPNet}
    aspApplications          : TnxsrHostedASPApplications;
    netApplications          : TnxsrHostedNetApplications;
    {$endif}
{$endif}

    RetryCount               : Integer;
    RetryTCPIPv4Transport    : Boolean;
    RetryNamedPipeTransport  : Boolean;

    procedure ServerSettingChanged(Sender: TObject);

    {
    function InitFromFile(const aFileName: string): Boolean;

    // does NOT save users!
    procedure SaveInitFile(const aFileName: string);
    }
    class procedure RegisterClassRef; virtual;

    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

function dmServer: TdmServer;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

var
  _dmServer : TdmServer;
  _dmServerClassRef : TdmServerClass;

function dmServer: TdmServer;
begin
  if not Assigned(_dmServer) then begin
    SetCurrentDir(ExtractFilePath(paramstr(0)));
    _dmServer := _dmServerClassRef.Create(nil);
  end;
  Result := _dmServer;
end;

constructor TdmServer.Create(aOwner: TComponent);
{$ifdef UseSummary}
var
  ServerSummary : TnxServerSummary;
  {$endif}
{$IFDEF NX_SECURE_PRO_DH}
  procedure CreateSecuredTransport(aClass      : TnxDHSecuredTransportClass;
                             const aDisplayName: string);
  var
    lSecuredTransport: TnxBaseDHSecuredTransport;
    lSecuredCommandHandler: TnxSecuredCommandHandler;
  begin
    lSecuredTransport := aClass.Create(Self);
    lSecuredTransport.Name := Copy(aClass.ClassName,2,MaxInt);
    lSecuredTransport.DisplayName := aDisplayName + ' Secured Transport';
    lSecuredTransport.DisplayCategory := 'Transports,Secured';
    lSecuredTransport.EventLog := EventLog;
    lSecuredTransport.CommandHandler := ServerCommandHandler;
    lSecuredTransport.Mode := nxtmListen;
    lSecuredCommandHandler := TnxSecuredCommandHandler.Create(Self);
    lSecuredCommandHandler.Name := 'nxSecuredCommandHandler' + lSecuredTransport.Name;
    lSecuredCommandHandler.SecuredTransport := lSecuredTransport;
    lSecuredCommandHandler.EventLog := EventLog;

    With TnxWinsockTransport.Create(Self) do
      begin
      Name := 'nxWinsockTransport' + lSecuredTransport.Name;
      CommandHandler := lSecuredCommandHandler;
      DisplayName := 'Winsock Transport (' + aDisplayName + ')';
      DisplayCategory := 'Transports,Secured,' + aDisplayName + ' Secured Transport';
      Eventlog := Self.EventLog;
      Port := lSecuredTransport.DefaultTransportPort;
      Mode := nxtmListen;
      end;

    With TnxNamedPipeTransport.Create( Self ) do
      begin
      Name := 'nxNamedPipeTransport' + lSecuredTransport.Name;
      CommandHandler := lSecuredCommandHandler;
      DisplayName := 'Named Pipe Transport (' + aDisplayName + ')';
      DisplayCategory := 'Transports,Secured,' + aDisplayName + ' Secured Transport';
      Eventlog := Self.EventLog;
      Port := lSecuredTransport.DefaultTransportPort;
      Mode := nxtmListen;
    end;
  end;
{$ENDIF}
begin

  inherited;
  {$IFDEF UseReplicationMonitor}
  TnxTransactionReplicationMonitor.Create(Self).Name := 'nxTransactionReplicationMonitor';
  nxTransactionReplicationMonitor.ServerEngine := ServerEngine;
  {$ENDIF}
  {$IFDEF NX_SECURE_PRO_DH2048_AES}
  CreateSecuredTransport(TnxDiffieHellman2048WithAesGcmSecuredTransport,'DH-2048/Aes-128-Gcm');
  CreateSecuredTransport(TnxDiffieHellman2048WithAesCcmSecuredTransport,'DH-2048/Aes-128-Ccm');
  {$ENDIF}
  {$IFDEF NX_SECURE_PRO_DH8192_AES}
  CreateSecuredTransport(TnxDiffieHellman8192WithAesGcmSecuredTransport,'DH-8192/Aes-256-Gcm');
  CreateSecuredTransport(TnxDiffieHellman8192WithAesCcmSecuredTransport,'DH-8192/Aes-256-Ccm');
  {$ENDIF}
  {$IFDEF NX_SECURE_PRO_DH8192_SHACAL}
  CreateSecuredTransport(TnxDiffieHellman8192WithShaCalSecuredTransport,'DH-8192/Shacal-256');
  {$ENDIF}

  {$ifdef RemoteAdministration}
  RemoteAdmin:=TnxRemoteAdmin.Create(self);
  RemoteAdmin.ServerEngine:=Server.ServerEngine;
  {$endif}

  dmSqlTriggerMonitor:=nil;
  dmSqlTriggerMonitor:=TnxSqlTriggerMonitor.Create(nil);
  dmSqlTriggerMonitor.SQLEngine:=SQLEngine;
  dmSqlTriggerMonitor.ServerEngine:=ServerEngine;
  dmSqlTriggerMonitor.EventLog:=EventLog;
  dmSqlTriggerMonitor.DisplayCategory:='SQL Engine';
  dmSqlTriggerMonitor.DisplayName:='SQL Triggers';

  dmAuditMonitor := TnxAuditMonitor.Create(nil);
  dmAuditMonitor.ServerEngine := ServerEngine;
  dmAuditMonitor.EventLog := EventLog;

//  TnxSecurityMonitorNew.Create(Self).ServerEngine := ServerEngine;

{$ifndef StarterEdition}
  {$ifdef DemoWebServer}
  DemoWebServer:=TnxDemoWebServer.Create(self);
  DemoWebServer.ServerEngine:=Server.ServerEngine;
  {$endif}

  {$ifdef WebApplications}
  webApplications := TnxsrWebApplications.Create(self);
  webApplications.ServerEngine:=Server.ServerEngine;
  {$endif}

  {$ifdef ASPNet}
  aspApplications := TnxsrHostedASPApplications.Create(self);
  aspApplications.ServerEngine:=Server.ServerEngine;

  netApplications := TnxsrHostedNetApplications.Create(self);
  netApplications.ServerEngine:=Server.ServerEngine;
  {$endif}

  {$ifdef RemoteCommands}
  RemoteCommands:=TnxServerRemoteCommandsPlugin.Create(Self);
  RemoteCommands.Name:='RemoteCommands';
  RemoteCommands.DisplayName:='Remote Commands Plugin';
  RemoteCommands.EventLog:=EventLog;

  RemoteCommandsHandler:=TnxRemoteCommandsPluginCommandHandler.Create(Self);
  RemoteCommandsHandler.CommandHandler:=ServerCommandHandler;
  RemoteCommandsHandler.EventLog:=EventLog;
  RemoteCommandsHandler.PluginEngine:=RemoteCommands;

  RemoteCommands.Active:=true;
  {$endif}
{$endif}

  sServerFunctionsHub.LoadFromStorage(nil);

  {$ifdef FullServerUI}
  ServerSettings := TnxServerSettings.Create(Self);
  ServerSettings.ServerEngine := Server.ServerEngine;
  ServerSettings.OnChanged := ServerSettingChanged;
  {$endif}

  { AndroidService }

  AndroidServiceSettings := TnxAndroidServiceSettings.Create(Self);
  AndroidServiceSettings.ServerEngine := Server.ServerEngine;
  AndroidServiceSettings.OnChanged := ServerSettingChanged;

  { FileService }

  FileServiceSettings := TnxFileServiceSettings.Create(Self);
  FileServiceSettings.ServerEngine := Server.ServerEngine;
  FileServiceSettings.OnChanged := ServerSettingChanged;

  { WebsocketsService }

  WebsocketsServiceSettings := TnxWebsocketsServiceSettings.Create(Self);
  WebsocketsServiceSettings.ServerEngine := Server.ServerEngine;
  WebsocketsServiceSettings.OnChanged := ServerSettingChanged;

  { AJAXService }

  AJAXServiceSettings := TnxAJAXServiceSettings.Create(Self);
  AJAXServiceSettings.ServerEngine := Server.ServerEngine;
  AJAXServiceSettings.OnChanged := ServerSettingChanged;

  {$ifdef PortalGateway}
  GwCommandHandler:=TnxRTCPluginCommandHandler.Create(nil);
  GwCommandHandler.Mode:=tgmDLL;
  GwCommandHandler.CommandHandler:=ServerCommandHandler;
  GwCommandHandler.Name:='nxPortalGateway';
  {$endif}

  sServerFunctionsHub.ServerEngine:=Server.ServerEngine;

{$ifndef StarterEdition}
  {$ifdef UseDirectHTTP}
  { TCP Direct support }
  {$WARNINGS OFF}
  with TnxptTCPRequestTransport.Create(self) do
  {$WARNINGS ON}
  begin
    ServerEngine := Server.ServerEngine;
    Name:='nxDirectTCPProtocol';
  end;
  {$endif}
{$endif}

  {$ifdef UseSummary}
  ServerSummary := TnxServerSummary.Create(Self);
  ServerSummary.ServerEngine := Server.ServerEngine;
  {$endif}

  {$IFDEF DEBUGAPP}
  With NamedPipeTransport do
    begin
    HeartBeatInterval := 600000;
    TimeOut := 600000;
    WatchDogInterval := 600000;
    end;
  {$ENDIF}
end;

procedure TdmServer.DataModuleCreate(Sender: TObject);
begin
     {$IFNDEF CommandLineServer}
     tiRetryTransports := TTimer.Create( Self );
     tiRetryTransports.Enabled := False;
     tiRetryTransports.Interval := 10000;
     tiRetryTransports.OnTimer := tiRetryTransportsTimer;
     {$ENDIF}
end;

destructor TdmServer.Destroy;
begin
  nxFreeAndNil(dmSqlTriggerMonitor);
  nxFreeAndNil(dmAuditMonitor);
  {$ifdef RemoteAdministration}
  RemoteAdmin.Free;
  {$endif}
{$ifndef StarterEdition}
  {$ifdef DemoWebServer}
  DemoWebServer.Free;
  {$endif}
  {$ifdef RemoteCommands}
  RemoteCommandsHandler.free;
  RemoteCommands.free;
  {$endif}
{$endif}
  sServerFunctionsHub.SaveToStorage(nil);

  if _dmServer = Self then
    _dmServer := nil;
  inherited;
end;

procedure TdmServer.EventLogSettingsLoaded(Sender: TObject);
begin
  if EventLog.FileName = '' then
    EventLog.FileName :=
      ChangeFileExt(
    {$IFDEF NX_EXCEPTION_LOG_IN_APP_FOLDER}
        ParamStr(0)
    {$ELSE}
        nxAppHomeDirectory(nxAppDataSubdirVista) + ExtractFileName(ParamStr(0))
    {$ENDIF}
        , '') + 'Event.log';
end;

class procedure TdmServer.RegisterClassRef;
begin
  _dmServerClassRef := Self;
end;

procedure TdmServer.ServerEngineStateChanged(Sender: TObject);
begin
{$IFNDEF StarterEdition}
  if (ServerEngine.State = nxsStarted) and (dmAuditMonitor.State = nxsInactive) then
    dmAuditMonitor.Active := True;
{$ENDIF}
end;

procedure TdmServer.ServerSettingChanged(Sender: TObject);
begin
  {$ifdef FullServerUI}
  Server.AutoSaveConfig := ServerSettings.AutosaveConfig;
  {$endif}
end;


procedure TdmServer.SqlEngineStateChanged(Sender: TObject);
begin
     If   SqlEngine.State=nxsStarted
     then dmSqlTriggerMonitor.Active := True;
end;

procedure TdmServer.tiRetryTransportsTimer(Sender: TObject);
begin

     If   RetryTCPIPv4Transport
     then If   not TCPIPv4Transport.Active
          then try
                 TCPIPv4Transport.Enabled := True;
                 TCPIPv4Transport.State := nxsInactive;
                 TCPIPv4Transport.Active := True;
                 RetryTCPIPv4Transport := False;
               except
                 TCPIPv4Transport.Enabled := True;
                 TCPIPv4Transport.State := nxsInactive;
                 end;

     If   RetryNamedPipeTransport
     then If   not NamedPipeTransport.Active
          then try
                 NamedPipeTransport.Enabled := True;
                 NamedPipeTransport.State := nxsInactive;
                 NamedPipeTransport.Active := True;
                 RetryNamedPipeTransport := False;
               except
                 NamedPipeTransport.Enabled := True;
                 NamedPipeTransport.State:=nxsInactive;
                 end;

     Inc( RetryCount );

     {$ifndef CommandLineServer}
     If   RetryCount>=6
     then tiRetryTransports.Enabled := False;
     {$endif}

end;

initialization
  If   not Assigned( _dmServerClassRef )
  then TdmServer.RegisterClassRef;

finalization
  nxFreeAndNil( _dmServer );

end.


