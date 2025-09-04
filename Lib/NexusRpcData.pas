unit NexusRpcData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls,

  IniFiles,
  ZipForge,

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

  SessionIntf,

  DataManager,
  AppManager;

type
  TRpcProcessType = ( ptUpdate, ptDownload );

  TNexusRpcDataModule = class( TDataModule, INotificationCallback, IProgressCallBack )
    RemotingClient: TnxRemotingClient;
    RemoteSimpleSession: TnxSimpleSession;
    WinsockTransport: TnxWinsockTransport;
    NamedPipeTransport: TnxNamedPipeTransport;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

  private

    FClientID : String;
    FServerStarted,
    FServerServiceInstalled : Boolean;
    FSessionService : ISessionService;

    FOnStartProgress : TOnStartProgress;
    FOnProgress : TOnProgress;
    FOnEndProgress : TOnEndProgress;

    FInRemoteTransaction : Boolean;

    function SendNotification( NotificationType: TNotificationType; Caption: String = ''; Description : String = '' ) : Boolean;

    procedure StartProgress( MarqueeMode : Boolean = False; MaxValue : Integer = 100 );
    function SendProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
    procedure EndProgress;

    procedure NetIdleEvent(aSender: TObject; AWaitEvent: THandle);

  public

    RemoteDir,
    VersionDir,
    LocalDir,
    BackupDir,

    CurrentDir,

    RemotePath,
    LocalPath,
    UpdatePath : String;

    FileSize,
    CurrentDownloadSize,        // El tamaño descargado hasta ahora
    TotalDownloadSize : Int64;  // El tamaño de todos los ficheros a descargar

    DataProgressBar : TProgressBar;
    DataLabel : TLabel;

    Cancelled : Boolean;
    RpcProcessType : TRpcProcessType;
    ProxyInfoFile : TMemIniFile;

    FileName : WideString;
    Operation : TZFProcessOperation;
    Error : Boolean;
    CodigoError : Integer;
    MensajeError : String;

    FConfigFileName : String;

    procedure InitSessionService;
    procedure Setup( ARpcProcessType : TRpcProcessType; ALabel : TLabel; AProgressBar : TProgressBar; ReadConfigFile  : Boolean = True );
    function TransportAccesible: Boolean;
    procedure StartServer;
    procedure StopServer;

    procedure CreateRemoteInstance( const AClassID : TnxGuid; const AInterfaceID : TnxGuid; out AInterface );

    function AccesoUsuario( CodigoUsuario : String; AccesoInicial  : Boolean; PalabraDePaso, CodigoEmpresa : String; Fecha : TDate ) : Boolean;

    procedure GetDatabaseInfo( CodigoEmpresa : String; out MajorVersion : Word; out MinorVersion : Word; out Release : Word; out Build : Word; out LastUpdate : TDateTime; out Options : String );
    function InitializeDatabase( CodigoEmpresa : String ) : Boolean;
    function RecoverDatabase( CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
    procedure EraseEnterpriseDatabase( CodigoEmpresa : String );
    procedure UpdateDatabase( CodigoEmpresa : String = '' );
    function BackupDatabaseTables( UserDatabase : Boolean; BackupDatabasePath : String; TableNames : String ) : Boolean;
    procedure RegisterOptionDataModule( OptionalDataModule : TModuloOpcional );

    procedure FreeAllSessionDataModules;
    procedure FreeSessionService;

    function EnterpriseRequest( FunctionName : String; const Args : array of Variant ) : Variant;
    function GetApplicationPath : String;
    function GetRootDataPath : String;
    function GetTemporalDataPath : String;
    function SessionCount( CodigoEmpresa : String = '' ) : SmallInt;
    function CheckKey(       RemoteCursorID : TnxCursorID;
                       const Key             : TVariantArray;
                       const DescFieldNames  : TStringArray;
                       out   DescFieldValues : TVariantArray ) : Boolean;

    property ClientID : String read FClientID;
    property ServerStarted : Boolean read FServerStarted;

    property SessionService : ISessionService read FSessionService;

    property OnStartProgress : TOnStartProgress read FOnStartProgress write FOnStartProgress;
    property OnProgress : TOnProgress read FOnProgress write FOnProgress;
    property OnEndProgress : TOnEndProgress read FOnEndProgress write FOnEndProgress;

  end;

  TnxSimpleSessionHelper = class Helper for TnxSimpleSession
    function GetSessionID : TnxSessionID;
    end;

const  DefaultBlockSize = 16384;

function NexusRpc : TNexusRpcDataModule;

const   MainServiceName = 'MainService';
        EnterpriseServiceName = 'EnterpriseService';

{ NOTA : No utilizar FastZLib como compresor. No está correctamente implementado }

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  System.Threading,

      nxpsiMessagePumpInterceptor,
      WindowsServiceManager,

      Files,
      DateUtils,
      Variants,

      AppContainer,
      DataAccess,
      SessionDataAccess,

      b_spr,

      f_prg;

{$R *.dfm}

const  ProxySectionName = 'Proxy';

var    NexusRpcDataModule: TNexusRpcDataModule = nil;
       ServerFileName : String = 'GServer';

resourceString
       RsMsg1 = 'No se ha podido conectar con el servidor de la aplicación.';
       RsMsg2 = 'Si el servidor está en una localización remota compruebe su conexión de red y que el cortafuegos o antivirus no estén bloqueando algún puerto.';
       RsMsg3 = 'Se ha producido un error al iniciar la sesión en el servidor.';
       RsMsg4 = 'La versión de la aplicación cliente no coincide con la del servidor.';
       RsMsg5 = 'En este momento el acceso al servidor está bloqueado por un proceso de regeneración o inicialización.</br>Espere a que el proceso finalice.';
       RsMsg6 = 'Compruebe que los servicios del servidor estén funcionando y que la versión coincida con la de la aplicación.';
       RsMsg7 = 'Esta versión local de Gestwin solo admite la versión de 32 bits del servidor.';
       RsMsg8 = 'No se ha podido instalar el servicio del servidor de la aplicación (GServer).';
       RsMsg9 = 'Reinicie el sistema operativo y reintente el proceso. Si el error persiste, recurra a su soporte técnico.';

function NexusRpc : TNexusRpcDataModule;
begin
     If   not Assigned( NexusRpcDataModule )
     then NexusRpcDataModule := TNexusRpcDataModule.Create( Application );
     Result := NexusRpcDataModule;
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

procedure TNexusRpcDataModule.DataModuleCreate(Sender: TObject);

const DebugTimeout = 600000;   // Milésimas de segundo

begin

     RpcProcessType := ptUpdate;  // por defecto

     {$IFDEF DEBUG}
     With NamedPipeTransport do
       begin
       LostConnectionTimeout := DebugTimeout;
       HeartBeatInterval := DebugTimeout;
       WatchdogInterval := DebugTimeout;
       TimeOut := DebugTimeout;
       end;
     RemoteSimpleSession.TimeOut := DebugTimeout;
     RemotingClient.Timeout := DebugTimeout;
     {$ENDIF}

     // Hago esta asignación porque cuando es necesaria una actualización de la base de datos de la aplicación
     // se puede invocar de nuevo a la función antes del retorno de la misma

     NexusRpcDataModule := Self;

     If   DataAccessTransport=dtWinsock
     then begin
          WinsockTransport.Port := PuertoWinsock;
          If   ApplicationServerName<>''
          then WinsockTransport.ServerName := ApplicationServerName;
          RemoteSimpleSession.Transport := WinsockTransport;
          end
     else begin
          NamedPipeTransport.Port := PuertoLocal;
          If   ApplicationServerName<>''
          then NamedPipeTransport.ServerName := ApplicationServerName;
          RemoteSimpleSession.Transport := NamedPipeTransport;
          end;

     StartServer;

     RemotingClient.Active := True;

     InitSessionService;

end;

procedure TNexusRpcDataModule.InitSessionService;

var  Guid : TGuid;
     DescriptionError,
     ComputerName,
     UserName : String;
     UpgradeNeeded,
     Is64BitsServer : Boolean;
     HR : System.HResult;
     SessionModule : ISessionModule;

begin

     try
       HR := RemotingClient.CreateInstance( CLSID_SessionService, nil, ISessionService, FSessionService );
       If   HR=S_OK
       then begin
            If   Supports( InxInvokable( FSessionService ), ISessionModule, SessionModule )
            then SessionModule.AssignSession( ServerSessionDataModuleID );
            end
       else Abort;
     except
       InitializationError := True;
       ShowNotification( ntError, RsMsg1, RsMsg2 );
       PrgExit( False, True );
       Abort;
       end;

     If   Assigned( FSessionService )
     then begin

          CreateGuid( Guid );

          FClientID := Guid.ToString;

          TnxBasePooledTransport.SetNetIdle( NetIdleEvent, INFINITE, QS_SENDMESSAGE );

          DescriptionError := '';

          try

            GetComputerAndUserName( ComputerName, UserName );

            ServerSessionDataModuleID := FSessionService.InitializeSession( ProgramNumber,
                                                                            ApplicationDataPath,
                                                                            FixedRemotePath,
                                                                            ComputerName,
                                                                            UserName,
                                                                            GetAppComparableVersion,
                                                                            UpgradeNeeded,
                                                                            Is64BitsServer );

            If   ServerSessionDataModuleID<0  // Un error de inicialización de la sesión
            then begin
                 case ServerSessionDataModuleID of
                   SE_VersionMismatch  : DescriptionError := RsMsg4;
                   SE_ServerLocked     : DescriptionError := RsMsg5;
                   end;
                 Abort;
                 end;

            FSessionService.NotificationCallback := nxWrapMessagePump( Self ) as INotificationCallback;
            FSessionService.ProgressCallBack := nxWrapMessagePump( Self ) as IProgressCallBack;

            If   UpgradeNeeded
            then RequestDatabaseUpdate( '' );  // La base de datos de la aplicación

            SessionDataModule;

          except
            If   DescriptionError=''
            then DescriptionError := RsMsg6;
            ShowNotification( ntExceptionError, RsMsg3, DescriptionError );
            InitializationError := True;
            PrgExit( False, True );
            Abort;
            end;

          end;
end;

procedure TNexusRpcDataModule.FreeSessionService;
begin
     FSessionService := nil;
end;

procedure TNexusRpcDataModule.DataModuleDestroy(Sender: TObject);
begin

      // Es importante suprimir el SessionDataModule antes de finalizar la sesión para que la base de datos temporal
      // esté cerrada y se pueda suprimir el directorio temporal de la sesión en el servidor.

     FreeSessionDataModule;

     If   Assigned( FSessionService )
     then begin
          FSessionService.NotificationCallback := nil;
          FSessionService.ProgressCallBack := nil;
          end;

     FSessionService := nil;   // Aquí se destruye el servicio (IInterface), por lo que no es necesario finalizarlo de ninguna otra manera
     NexusRpcDataModule := nil;
end;

procedure TNexusRpcDataModule.StartProgress(MarqueeMode: Boolean; MaxValue: Integer);
begin
     If   Assigned( FOnStartProgress )
     then FOnStartProgress( MarqueeMode, MaxValue );
end;

procedure TNexusRpcDataModule.StartServer;

var   ProcessInformation : TProcessInformation;
      ServerWndHandle : hWnd;
      RetryCount : SmallInt;
      ServerFileName,
      CommandLine : String;

begin

     If   not FServerStarted
     then try

            //* 23.02.2004  Añadida la comprobación de conexión con Terminal Server
            //              En este tipo de conexiones el servidor ya debe estar funcionando,
            //              bien como un servicio (preferible) o desde una sesión cualquiera.

            //* 12.12.2004  Comprobación de la existencia de un servidor local antes de arrancarlo
            //* 11.02.2011  Añadida la comprobación del ApplicationServerName con TS para permitir conexiones locales
            //* 05.01.2021  Ahora GServer es siempre un servicio. Si no está instalado, se instala y si está instalado pero no arrancado, se arranca

            FServerStarted := TransportAccesible;
            If   ( DataAccessMode=dmLocal ) and not FServerStarted
            then begin

                 If   Sp64BitsServer
                 then ServerFileName := 'GServer64.exe'
                 else ServerFileName := 'GServer.exe';

                 ServerWndHandle := Windows.FindWindow( ServerClassName, nil );
                 If   ServerWndHandle=0        // No está arrancado, pero no sabemos aún si el servicio está instalado
                 then begin

                      {$IFDEF ONLYSERVICESERVER}
                      FServerServiceInstalled := WSMIsService( DefaultServiceName );
                      If   not FServerServiceInstalled
                      then begin               // Antes que nada, instalamos el servicio de forma silenciosa en la cuenta local del sistema
                           If   RunProcess( Application.Handle, ApplicationPath + ServerFileName, '/install /silent /localsystemaccount', { RunAsAdmin } True  )
                           then Delay( 1000 )  // Por si le cuesta
                           else begin
                                ShowNotification( ntExceptionError, RsMsg8, RsMsg9 );
                                Abort;
                                end;
                           end;

                      If   RunProcess( Application.Handle, ApplicationPath + ServerFileName, '/start /silent', { RunAsAdmin } True  )
                      then begin
                           RetryCount := 0;
                           repeat
                             Delay( 500 );
                             Inc( RetryCount );
                             FServerStarted := TransportAccesible;
                           until FServerStarted or ( RetryCount>20 );
                           end
                      else ShowNotification( ntExceptionError, RsMsg1, RsMsg2 );
					                 {$ELSE}

                      CommandLine := ServerFileName + ' /interactive';
                      If   ProcessExecute( ProcessInformation, CommandLine, ApplicationPath, SW_SHOWMINIMIZED )
                      then begin
                           RetryCount := 0;
                           repeat
                             Delay( 500 );
                             Inc( RetryCount );
                             FServerStarted := TransportAccesible;
                           until FServerStarted or ( RetryCount>10 );
                           end
                      else ShowNotification( ntExceptionError, RsMsg1, RsMsg2 );
					                 {$ENDIF}
                      end
                 else FServerStarted := True;
                 end;

           except
             end;

     If   not FServerStarted
     then begin
          ShowNotification( ntError, RsMsg3, RsMsg6 );
          Abort;
          end;

     // Rpc.Connect;

end;

function TNexusRpcDataModule.TransportAccesible : Boolean;

var Transport : TnxBasePooledTransport;

begin
     Result := False;
     try

       If   DataAccessTransport=dtWinsock
       then Transport := WinsockTransport
       else Transport := NamedPipeTransport;

       Transport.Active := True;
       Result := Transport.Active;

     except
       end;

end;

procedure TNexusRpcDataModule.StopServer;

var   ServerWndHandle : hWnd;

begin
     ServerWndHandle := Windows.FindWindow( ServerClassname, nil );
     If   ServerWndHandle<>0
     then SendMessage( ServerWndHandle, WM_CLOSE, 0, 0 );
end;

procedure TNexusRpcDataModule.CreateRemoteInstance( const AClassID     : TnxGuid;
                                                    const AInterfaceID : TnxGuid;
                                                    out   AInterface  );

var  HR : System.HResult;
     SessionModule : ISessionModule;

begin
     try
       HR := RemotingClient.CreateInstance( AClassID, nil, AInterfaceID, AInterface );
       If   HR=S_OK
       then begin
            If   Supports( InxInvokable( AInterface ), ISessionModule, SessionModule )
            then SessionModule.AssignSession( ServerSessionDataModuleID );
            end
       else Abort;
     except
       InitializationError := True;
       ShowNotification( ntError, RsMsg1, RsMsg2 );
       PrgExit( False, True );
       Abort;
       end;
end;

// SessionService

function TNexusRpcDataModule.GetApplicationPath : String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetApplicationPath
     else Result := ApplicationPath;
end;

function TNexusRpcDataModule.GetRootDataPath : String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetRootDataPath
     else Result := ApplicationDataDirectory;
end;

function TNexusRpcDataModule.GetTemporalDataPath: String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetTemporalDataPath
     else Result := TemporalDataPath;
end;

function TNexusRpcDataModule.InitializeDatabase( CodigoEmpresa : String ) : Boolean;
begin
     Result := SessionService.InitializeDatabase( CodigoEmpresa );
end;

function TNexusRpcDataModule.RecoverDatabase( CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
begin
     Result := SessionService.RecoverDatabase( CodigoEmpresa, RecoverTableList );
end;

procedure TNexusRpcDataModule.GetDatabaseInfo(     CodigoEmpresa : String;
                                               out MajorVersion,
                                                   MinorVersion,
                                                   Release,
                                                   Build        : Word;
                                               out LastUpdate   : TDateTime;
                                               out Options      : String );
begin
     SessionService.GetDatabaseInfo( CodigoEmpresa, MajorVersion, MinorVersion, Release, Build, LastUpdate, Options );
end;

function TNexusRpcDataModule.AccesoUsuario( CodigoUsuario    : String;
                                            AccesoInicial    : Boolean;
                                            PalabraDePaso,
                                            CodigoEmpresa    : String;
                                            Fecha            : TDate ) : Boolean;
begin
     Result := False;
     If   Assigned( FSessionService )
     then begin
          Result := FSessionService.AccesoUsuario( CodigoUsuario, AccesoInicial, PalabraDePaso, CodigoEmpresa, Fecha, MensajeError );
          If   not Result
          then begin
               If   MensajeError<>''
               then ShowNotification( ntStop, MensajeError );
               Abort;
               end;
          end;
end;

procedure TNexusRpcDataModule.EndProgress;
begin
     If   Assigned( FOnEndProgress )
     then FOnEndProgress;
end;

function TNexusRpcDataModule.EnterpriseRequest(       FunctionName : String;
                                                const Args         : array of Variant ) : Variant;
begin
     {** Pendiente
     If   IDSesion<>-1
     then begin
          Client.StateID := IDSesion;
          Result := CLient.Request( EnterpriseServiceName, '', FunctionName, Args );
          end
     else begin
          ShowNotification( ntError, RsMsg1 );
          Abort;
          end;
     }
end;

procedure TNexusRpcDataModule.EraseEnterpriseDatabase( CodigoEmpresa : String );
begin
     SessionService.EraseEnterpriseDatabase( CodigoEmpresa );
end;

procedure TNexusRpcDataModule.RegisterOptionDataModule( OptionalDataModule : TModuloOpcional );
begin
     SessionService.RegisterOptionDataModule( OptionalDataModule );
end;


function TNexusRpcDataModule.SendNotification( NotificationType : TNotificationType;
                                               Caption          : String = '';
                                               Description      : String = '' ) : Boolean;
begin

     Result := False; // Devolver True para indicar que se desea cancelar cualquier proceso en curso, excepto en el ntCheckSession

     case NotificationType of

       ntUpdateDatabase :
         RequestDatabaseUpdate( Caption );   // En Caption va el código de la Empresa que necesita una actualización, o está vacío si debe actualizarse la base de datos de la aplicación

       ntInitializeDatabase :
         RequestDatabaseInitialize;

       ntStartSubprocess :
         If   not Assigned( ProcessFrame ) and // Las ventanas de subprocesos solo se crean si no hay una de proceso abierta
              not UpdatingDictionaries         // o estamos actualizando la base de datos
         then begin
              CreateSubProcessForm;
              SubProcessForm.HeaderLabel.Caption := Caption;
              end;

       ntEndSubprocess :
         DestroySubprocessForm;

       ntProcessCanceled :
         If   Assigned( ProcessFrame )
         then Result := ProcessFrame.Canceled or ProcessFrame.Error;

       ntCloseSession :
         PrgExit( False, True, True );     // Se fuerza el cierre de la aplicación

       ntInformation..ntHeaderInformation :
         If   Assigned( ProcessFrame )
         then begin
              If   NotificationType=ntRecord
              then ProcessFrame.AddRecordMsg( Caption )
              else begin
                   ProcessFrame.AddMsg( NotificationType, Caption );
                   If   Description<>''
                   then ProcessFrame.AddMsg( NotificationType, Description );
                   end;
              Result := ProcessFrame.Canceled;
              end
         else If   NotificationType=ntExceptionError
              then ShowNotification( NotificationType, Caption, Description )
              else If   ( NotificationType in [ ntWarning, ntError, ntStop ] )
                   then PostNotification( NotificationType, Caption, Description )
                   else If   ( NotificationType in [ ntQuestion, ntQuestionWarning, ntAcceptCancel ] ) // and not DatabaseUpdateRequested
                        then Result := ShowNotification( NotificationType, Caption, Description ) in [ mrYes, mrOk ]
                        else If   Assigned( SubProcessForm )
                             then SubProcessForm.ProcessLabel.Caption := Caption + #13 + Description;

        ntCheckSession :
          Result := True;

       end;
     Application.ProcessMessages;
end;

function TNexusRpcDataModule.SendProgress( ObjectName : String; Percent1, Percent2  : SmallInt ) : Boolean;
begin
     Result := False;
     If   Assigned( FOnProgress )
     then Result := FOnProgress( ObjectName, Percent1, Percent2  );
end;

procedure TNexusRpcDataModule.Setup( ARpcProcessType : TRpcProcessType;
                                     ALabel          : TLabel;
                                     AProgressBar    : TProgressBar;
                                     ReadConfigFile  : Boolean = True );

var  BetaVersionText : String;

begin

     If   ReadConfigFile
     then ReadIniFile;

     VersionDir := 'gd_' + StrInt( ProgramVersion ) + '.' + StrInt( ProgramRelease );

     If   BetaVersion
     then BetaVersionText := '_beta'
     else BetaVersionText := '';

     RpcProcessType := ARpcProcessType;
     case RpcProcessType of
       ptUpdate :
         begin
         RemoteDir := AddPathDelim( 'updates' + BetaVersionText );
         LocalDir := AddPathDelim( ApplicationPath + 'updates' + BetaVersionText );
         BackupDir := AddPathDelim( ( AddPathDelim( ApplicationPath + 'updates' + BetaVersionText ) + 'backup' ) );
         CreateDirPath( BackupDir );
         end;

       ptDownload :
         begin
         RemoteDir := AddPathDelim( 'downloads' + BetaVersionText );
         LocalDir := AddPathDelim( ApplicationDataDirectory + 'downloads' + BetaVersionText );
         BackupDir := AddPathDelim( AddPathDelim( ApplicationDataDirectory + 'downloads' + BetaVersionText ) + 'backup' );
         CreateDirPath( LocalDir + VersionDir );
         CreateDirPath( BackupDir );
         end;

       end;

     DataProgressBar := AProgressBar;
     DataLabel := ALabel;
     Cancelled  := False;

     If   Assigned( DataProgressBar )
     then begin
          With DataProgressBar do
            begin
            Min := 0;
            Max := 100;
            end;
          end;
     If   Assigned( DataLabel )
     then Datalabel.Caption := '';
     Application.ProcessMessages;

end;

procedure TNexusRpcDataModule.UpdateDatabase( CodigoEmpresa  : String );
begin
     SessionService.UpdateDatabase( CodigoEmpresa );
end;

function TNexusRpcDataModule.BackupDatabaseTables(UserDatabase: Boolean; BackupDatabasePath, TableNames: String): Boolean;
begin
     Result := SessionService.BackupDatabaseTables( UserDatabase, BackupDatabasePath, TableNames );
end;

function TNexusRpcDataModule.SessionCount( CodigoEmpresa : String = '' ) : SmallInt;
begin
     Result := SessionService.SessionCount( CodigoEmpresa );
end;

procedure TNexusRpcDataModule.FreeAllSessionDataModules;
begin
     SessionService.FreeAllSessionDataModules;
end;

function TNexusRpcDataModule.CheckKey(       RemoteCursorID  : TnxCursorID;
                              const Key             : TVariantArray;
                              const DescFieldNames  : TStringArray;
                              out   DescFieldValues : TVariantArray ) : Boolean;
begin
     Result := SessionService.CheckKey( RemoteCursorID, Key, DescFieldNames, DescFieldValues );
end;

procedure TNexusRpcDataModule.NetIdleEvent(aSender: TObject; AWaitEvent: THandle);

var   Msg: TMsg;
const PM_QS_SENDMESSAGE = QS_SENDMESSAGE shl 16;

begin
     { queremos procesar solo llamadas de sendmessage en espera, nada más }
     PeekMessage( Msg, 0, 0, 0, PM_NOREMOVE or PM_NOYIELD or PM_QS_SENDMESSAGE );
end;

end.

