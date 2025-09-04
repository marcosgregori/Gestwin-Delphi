unit ServerConfigData;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IniFiles,
  ZipForge,

  VCL.Types,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.Objects,
  VCL.ExtCtrls,
  VCL.Platform.Win,
  VCL.StdCtrls,
  VCL.Header,
  VCL.Graphics,

  kbmMWGlobal,
  kbmMWFileClient,
  kbmMWCustomTransport,
  kbmMWClient,
  kbmMWTCPIPIndyClientTransport,
  kbmMWZipStdTransStream,
  kbmMWNexusDBClientTransport,
  kbmMWClientDataset,
  kbmMWCustomConnectionPool,
  kbmMemTable,
  kbmMWStreamFormat,
  kbmMWBinaryStreamFormat,

  nxsdTypes,
  nxllTypes,
  nxllComponent,
  nxllPluginBase,
  nxrpBase,
  nxrpClient,
  nxllTransport,
  nxptBasePooledTransport,
  nxtwWinsockTransport,
  nxllSessionNotifications,
  nxllSimpleSession,
  nxDB,
  nxlgEventLog,
  nxlgEventLogDispatcher,
  nxtnNamedPipeTransport,

  LibUtils,

  AppManager,

  SessionIntf,

  nxsdServerEngine,
  nxsrServerEngine,
  nxConfigSettingsDB,
  nxBaseServerComp,
  nxServerManager,
  nxsiServerInfoPluginBase,
  nxsiServerInfoPluginServer,


  nxServerSettings,
  nxRPCServicesSettings,
  nxFileServiceSettings;

type

  TRootCategory = ( rcDatabase = 0, rcService = 1, rcStatistics = 2, rcRoot = 3 );

  TServerConfigDataModule = class( TDataModule )
    ServerManager: TnxServerManager;
    ServerEngine: TnxServerEngine;
    TCPIPv4Transport: TnxWinsockTransport;
    NamedPipeTransport: TnxNamedPipeTransport;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

  public

    FConfigFileName : String;

    ServerSettings : TnxServerSettings;
    RPCServicesSettings : TnxRPCServicesSettings;
    FileServiceSettings : TnxFileServiceSettings;

    procedure LoadSettings;
    procedure SaveSettings;

  end;

  TnxSimpleSessionHelper = class Helper for TnxSimpleSession
    function GetSessionID : TnxSessionID;
    end;

function ServerConfig : TServerConfigDataModule;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  nxseAllEngines,
      nxpsiMessagePumpInterceptor,

      Files,
      DateUtils,
      Variants,

      MessageDialog,
      ProcessDialog;

{$R *.dfm}


var    ServerConfigDataModule: TServerConfigDataModule = nil;
       ServerFileName : String = 'GServer';

function ServerConfig : TServerConfigDataModule;
begin
     If   not Assigned( ServerConfigDataModule )
     then ServerConfigDataModule := TServerConfigDataModule.Create( Application );
     Result := ServerConfigDataModule;
end;

{ TnxSimpleSessionHelper }

function TnxSimpleSessionHelper.GetSessionID: TnxSessionID;
begin
     Result := ssSessionID;
end;

{
procedure CreateRemoteInstance( const AClassID     : TnxGuid;
                                const AOuter       : InxInterface;
                                const AInterfaceID : TnxGuid;
                                out   AInterface );
begin
     If   Rpc.RemotingClient.CreateInstance( AClassID, AOuter, AInterfaceID, AInterface )<>S_OK
     then begin
          ShowNotification( ntError, RsMsg1, RsMsg2 );
          PrgExit( False, True );
          Abort;
          end;
end;

}

procedure TServerConfigDataModule.DataModuleCreate(Sender: TObject);
begin


     ServerSettings := TnxServerSettings.Create(Self);
     ServerSettings.ServerEngine := ServerEngine;
     // ServerSettings.OnChanged := ServerSettingChanged;

     { RPCServices }

     RPCServicesSettings := TnxRPCServicesSettings.Create(Self);
     RPCServicesSettings.DisplayCategory := 'Servicios';
     RPCServicesSettings.ServerEngine := ServerEngine;
     // RPCServicesSettings.OnChanged := ServerSettingChanged;

     { FileService }

     FileServiceSettings := TnxFileServiceSettings.Create(Self);
     FileServiceSettings.DisplayCategory := 'Servicios';
     FileServiceSettings.ServerEngine := ServerEngine;
     // FileServiceSettings.OnChanged := ServerSettingChanged;

     FConfigFileName := ChangeFileExt( ExcludeTrailingBackslash( ApplicationPath ) + '\' + ServerFileName, '.settings' );
end;

procedure TServerConfigDataModule.DataModuleDestroy(Sender: TObject);
begin
     ServerConfigDataModule := nil;
end;

procedure TServerConfigDataModule.LoadSettings;
begin
     ServerManager.LoadSettings( FConfigFileName );
end;

procedure TServerConfigDataModule.SaveSettings;
begin
     ServerManager.SaveSettings( FConfigFileName );
end;

end.

