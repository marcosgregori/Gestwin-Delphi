unit KbmRpcData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls,

  IniFiles,
  ZipForge,

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

  SBX509,

  LibUtils,

  SessionIntf,

  DataManager,
  AppManager, SBSocket, SBSimpleSSL, SBHTTPSClient, SBRESTClient;

type
  TRpcProcessType = ( ptUpdate, ptDownload );

  TKbmRpcDataModule = class(TDataModule )
    Client: TkbmMWSimpleClient;
    ClientTransport: TkbmMWTCPIPIndyClientTransport;
    FileClient: TkbmMWFileClient;
    NexusDBClientTransport: TkbmMWNexusDBClientTransport;
    ClientConnectionPool: TkbmMWClientConnectionPool;
    EnterprisePooledSession: TkbmMWPooledSession;
    MainPooledSession: TkbmMWPooledSession;
    BinaryStreamFormat: TkbmMWBinaryStreamFormat;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure FileClientProgress(Sender: TObject; Pct: Integer;
      Receiving: Boolean; var Terminate: Boolean);
    procedure RESTClientError(Sender: TObject; ErrorCode: Integer; Fatal,
      Remote: Boolean);
    procedure RESTClientCertificateValidate(Sender: TObject;
      X509Certificate: TElX509Certificate;
      var Validity: TSBCertificateValidity;
      var Reason: TSBCertificateValidityReason);
  private

    FClientID : String;
    FServerStarted : Boolean;
    FSessionService : ISessionService;

    FOnStartProgress : TOnStartProgress;
    FOnProgress : TOnProgress;
    FOnEndProgress : TOnEndProgress;

    FErrorCode : Integer;
    FErrorMessage : String;

    FInRemoteTransaction : Boolean;

    function SendSessionNotification( NotificationType: TNotificationType; Caption: String = ''; Description : String = '' ) : Boolean;

    procedure StartSessionProgress( MarqueeMode : Boolean = False; MaxValue : Integer = 100 );
    function SendSessionProgress( ObjectName : String; Percent1, Percent2 : SmallInt ) : Boolean;
    procedure EndSessionProgress;

    function ExpandRemoteFileName( AFileName : String ) : String;
    procedure CreateRemoteDirPath(DirPath: String);
    procedure NetIdleEvent(aSender: TObject; AWaitEvent: THandle);
    procedure DelayedPost;

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

    procedure Setup( ARpcProcessType : TRpcProcessType; ALabel : TLabel; AProgressBar : TProgressBar; ReadConfigFile  : Boolean = True );
    procedure Connect( AUserName : String = '';
                       APassword : String = '';
                       AHost     : String = '';
                       APort     : SmallInt = 0 );

    procedure Disconnect;

    // ..

    function TransportAccesible: Boolean;
    procedure StartServer;
    procedure StopServer;

    function CreateRemoteInstance( const AClassID : TnxGuid; const AInterfaceID : TnxGuid; out AInterface ) : HResult;

    function AccesoUsuario( CodigoUsuario : String; AccesoInicial  : Boolean; PalabraDePaso, CodigoEmpresa : String; Fecha : TDate ) : Boolean;
    {
    procedure StartTransaction( Notify : Boolean = False );
    procedure Commit;
    procedure Rollback;
    // procedure ResetTransactions;
    }

    procedure GetDatabaseInfo( CodigoEmpresa : String; out MajorVersion : Word; out MinorVersion : Word; out Release : Word; out Build : Word; out LastUpdate : TDateTime; out Options : String );
    function InitializeDatabase( CodigoEmpresa : String ) : Boolean;
    function RecoverDatabase( CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
    procedure EraseEnterpriseDatabase( CodigoEmpresa : String );
    procedure UpdateDatabase( CodigoEmpresa : String = '' );
    function BackupDatabaseTables( UserDatabase : Boolean; BackupDatabasePath : String; TableNames : String ) : Boolean;

    procedure FreeAllSessionDataModules;

    // EnterpriseService

    function EnterpriseRequest( FunctionName : String; const Args : array of Variant ) : Variant;

    // FileService

    function  FixCurrentDir( aDir : String; Uploading : Boolean = False ) : Boolean;

    function  GetFile( AFileName : String ) : Int64;
    procedure PutFile( AFileName : String );

    {
    procedure ReadProxySettings;
    procedure WriteProxySettings;
    }

    function GetApplicationPath : String;
    function GetRootDataPath : String;
    function GetTemporalDataPath : String;
    function GetRemoteFileStamp( AFileName : String ) : String;
    function RemoteFileExists( AFileName : String ) : Boolean;
    function RemoteFileSize(AFileName: String; Expand : Boolean = True ): LongInt;
    procedure LockRead(Value: Boolean);

    function GetFileVersion( FilePath : String; IncludeBuild : Boolean = True ) : LongWord;

    procedure RegisterInstallation;

    function SessionCount( CodigoEmpresa : String = '' ) : SmallInt;
    function CheckKey(       RemoteCursorID : TnxCursorID;
                       const Key             : TVariantArray;
                       const DescFieldNames  : TStringArray;
                       out   DescFieldValues : TVariantArray ) : Boolean;

    property ClientID : String read FClientID;
    property ServerStarted : Boolean read FServerStarted;
    property SessionService : ISessionService read FSessionService;

    // REST

    property ErrorCode : Integer read FErrorCode write FErrorCode;
    property ErrorMessage : String read FErrorMessage write FErrorMessage;

    //

    property OnStartProgress : TOnStartProgress read FOnStartProgress write FOnStartProgress;
    property OnProgress : TOnProgress read FOnProgress write FOnProgress;
    property OnEndProgress : TOnEndProgress read FOnEndProgress write FOnEndProgress;

  end;

  TnxSimpleSessionHelper = class Helper for TnxSimpleSession
    function GetSessionID : TnxSessionID;
    end;

const  DefaultBlockSize = 16384;

function Rpc : TKbmRpcDataModule;
// procedure CreateRemoteInstance( const AClassID : TnxGuid; const AOuter : InxInterface; const AInterfaceID : TnxGuid; out AInterface );

const   MainServiceName = 'MainService';
        EnterpriseServiceName = 'EnterpriseService';

{ NOTA : No utilizar FastZLib como compresor. No está correctamente implementado }

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  System.Threading,

      nxpsiMessagePumpInterceptor,

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

var    RpcModule: TRpcModule = nil;

resourceString
       RsMsg1 = 'No se ha podido conectar con el servidor de la aplicación.';
       RsMsg2 = 'Si el servidor está en una localización remota compruebe su conexión de red y que el cortafuegos o antivirus no estén bloqueando algún puerto.';
       RsMsg3 = 'Se ha producido un error al iniciar la sesión en el servidor.';
       RsMsg4 = 'La versión de la aplicación cliente no coincide con la del servidor.';
       RsMsg5 = 'En este momento el acceso al servidor está bloqueado por un proceso de regeneración o inicialización.</br>Espere a que el proceso finalice.';
       RsMsg6 = 'Compruebe que los servicios del servidor estén funcionando y que la versión coincida con la de la aplicación.';
       RsMsg7 = 'Esta versión de Gestwin solo admite la versión de 32 bits del servidor.';
       
function Rpc : TRpcModule;
begin
     If   not Assigned( RpcModule )
     then RpcModule := TRpcModule.Create( Application );
     Result := RpcModule;
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

procedure TKbmRpcDataModule.DataModuleCreate(Sender: TObject);

const DebugTimeout = 600000;   // Milésimas de segundo

var  Guid : TGuid;
     DescriptionError : String;
     UpgradeNeeded,
     Is64BitsServer : Boolean;

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

     RpcModule := Self;

     If   DataAccessTransport=dtWinsock
     then begin

          WinsockTransport.Port := PuertoWinsock;
          WinsockTransport.ServerName := ApplicationServerName;

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

     CreateRemoteInstance( CLSID_SessionService, ISessionService, FSessionService );
     If   Assigned( FSessionService )
     then begin

          CreateGuid( Guid );

          FClientID := Guid.ToString;

          TnxBasePooledTransport.SetNetIdle( NetIdleEvent, INFINITE, QS_SENDMESSAGE );

          DescriptionError := '';

          try

            ServerSessionDataModuleID := FSessionService.InitializeSession( ProgramNumber,
                                                                            ApplicationDataPath,
                                                                            FixedRemotePath,
                                                                            GetComputerName,
                                                                            GetAppComparableVersion,
                                                                            UpgradeNeeded,
                                                                            Is64BitsServer );

            {
            If   Is64BitsServer and not Sp64BitsServer
            then begin
                 DescriptionError := RsMsg7;
                 Abort;
                 end;
            }

            If   ServerSessionDataModuleID<0  // Un error de inicialización de la sesión
            then begin
                 case ServerSessionDataModuleID of
                   SE_VersionMismatch : DescriptionError := RsMsg4;
                   SE_ServerLocked    : DescriptionError := RsMsg5;
                   end;
                 Abort;
                 end;

            FSessionService.NotificationCallback := nxWrapMessagePump( Self ) as ISessionNotificationCallback;
            FSessionService.ProgressCallBack := nxWrapMessagePump( Self ) as ISessionProgressCallBack;

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

procedure TKbmRpcDataModule.DataModuleDestroy(Sender: TObject);
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
     RpcModule := nil;
end;

procedure TKbmRpcDataModule.StartSessionProgress(MarqueeMode: Boolean; MaxValue: Integer);
begin
     If   Assigned( FOnStartProgress )
     then FOnStartProgress( MarqueeMode, MaxValue );
end;

procedure TKbmRpcDataModule.StartServer;

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

            FServerStarted := TransportAccesible;
            If   ( DataAccessMode=dmLocal ) and not FServerStarted
            then begin
                 ServerWndHandle := FindWindow( ServerClassName, nil );
                 If   ServerWndHandle=0
                 then begin
                      If   Sp64BitsServer
                      then ServerFileName := 'GServer64.exe'
                      else ServerFileName := 'GServer.exe';
                      CommandLine := ServerFileName + ' /interactive';
                      If   ProcessExecute( ProcessInformation, CommandLine, ApplicationPath, SW_SHOWMINIMIZED )
                      then begin
                           RetryCount := 0;
                           repeat
                             Delay( 500 );
                             Inc( RetryCount );
                             FServerStarted := TransportAccesible;
                           until FServerStarted or ( RetryCount>10 );
                           {  No consigo que funcione
                           If   FServerStarted
                           then TTask.Run( procedure begin DelayedPost; end );
                           }
                           end
                      else ShowNotification( ntExceptionError, RsMsg1, RsMsg2 );
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

procedure TKbmRpcDataModule.DelayedPost;
begin
     Sleep( 2000 );
     If   Assigned( Application.MainForm )
     then Application.MainForm.SetFocusedControl( Application.MainForm );
end;

function TKbmRpcDataModule.TransportAccesible : Boolean;

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

procedure TKbmRpcDataModule.StopServer;

var   ServerWndHandle : hWnd;

begin
     ServerWndHandle := FindWindow( ServerClassname, nil );
     If   ServerWndHandle<>0
     then SendMessage( ServerWndHandle, WM_CLOSE, 0, 0 );
end;

{
procedure TRpcModule.Commit;
begin
     If   FInRemoteTransaction
     then begin
          SessionService.Commit;
          FInRemoteTransaction := False;
          end;
end;
}

procedure TKbmRpcDataModule.Connect( AUserName : String;
                              APassword : String;
                              AHost     : String;
                              APort     : SmallInt );

var  TimeOut : Integer;

begin

     // El Username y Password son solo para el FileService

     If   AUserName=''
     then AUserName := 'gwuser';
     If   APassword=''
     then APassword := 'gdA2076_b2';

     If   AHost=''
     then AHost := 'localhost';
     If   APort=0
     then APort := 80;

     {$IFDEF DEBUG}
     TimeOut := 100; // Aquí en segundos
     {$ELSE}
     TimeOut := 10;
     {$ENDIF}

     With ClientTransport do
       begin
       ConnectTimeout := TimeOut;
       RequestTimeOut := TimeOut * 2;
       Host := AHost;
       Port := APort;
       end;

     With FileClient do
       begin
       UserName := AUserName;
       Password := APassword;
       BlockSize := DefaultBlockSize;
       //Connect;  {TODO : Activar el servicio de ficheros en el servidor y aquí}
       end;

end;

procedure TKbmRpcDataModule.Disconnect;
begin
     FileClient.Disconnect;
end;

function TKbmRpcDataModule.CreateRemoteInstance( const AClassID     : TnxGuid;
                                          const AInterfaceID : TnxGuid;
                                            out AInterface  ) : HResult;

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
       ShowNotification( ntError, RsMsg1, RsMsg2 );
       PrgExit( False, True );
       Abort;
       end;
end;

function TKbmRpcDataModule.ExpandRemoteFileName( AFileName : String ) : String;
begin
     Result := AddPathDelim( RemoteDir + VersionDir ) + CurrentDir + AFileName;
end;

function TKbmRpcDataModule.RemoteFileExists( AFileName  : String ) : Boolean;
begin
     Result := RemoteFileSize( AFilename )>0;
end;

function TKbmRpcDataModule.RemoteFileSize( AFileName  : String;
                                    Expand     : Boolean = True ) : LongInt;
begin
     If   Expand
     then AFileName := ExpandRemoteFileName( AFileName );
     try
        With FileClient do
          Result := Request( FileService, '', 'GetFileSize', [ AFileName ] );
     except
       Result := 0;
     end;
end;

procedure TKbmRpcDataModule.RESTClientCertificateValidate(     Sender          : TObject;
                                                        X509Certificate : TElX509Certificate;
                                                    var Validity        : TSBCertificateValidity;
                                                    var Reason          : TSBCertificateValidityReason );
begin
     Validity := TSBCertificateValidity.cvOk;
end;

procedure TKbmRpcDataModule.RESTClientError(Sender: TObject; ErrorCode: Integer; Fatal, Remote: Boolean);
begin
     FErrorCode := ErrorCode;
     FErrorMessage := '';
end;

{
procedure TRpcModule.Rollback;
begin
     If   FInRemoteTransaction
     then begin
          SessionService.Rollback;
          FInRemoteTransaction := False;
          end;
end;

procedure TRpcModule.ResetTransactions;
begin
     SessionService.ResetTransactions;
end;
}

function TKbmRpcDataModule.GetRemoteFileStamp( AFileName  : String ) : String;

var  TargetFile : String;
     FileStatus : TkbmMWFileStatus;

begin
     TargetFile := ExpandRemoteFileName( AFileName );
     Result := LowestStrDate;
     try
       With FileClient do
          Result := Request( FileService, '', 'GetFileStamp', [ TargetFile ] );
     except
       end;
end;

function TKbmRpcDataModule.GetApplicationPath : String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetApplicationPath
     else Result := ApplicationPath;
end;

function TKbmRpcDataModule.GetRootDataPath : String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetRootDataPath
     else Result := ApplicationDataDirectory;
end;

function TKbmRpcDataModule.GetTemporalDataPath: String;
begin
     If   Assigned( SessionService )
     then Result := SessionService.GetTemporalDataPath
     else Result := TemporalDataPath;
end;

function TKbmRpcDataModule.InitializeDatabase( CodigoEmpresa : String ) : Boolean;
begin
     Result := SessionService.InitializeDatabase( CodigoEmpresa );
end;

function TKbmRpcDataModule.RecoverDatabase( CodigoEmpresa : String; RecoverTableList : TStringArray ) : Boolean;
begin
     Result := SessionService.RecoverDatabase( CodigoEmpresa, RecoverTableList );
end;

procedure TKbmRpcDataModule.GetDatabaseInfo(     CodigoEmpresa : String;
                                      out MajorVersion,
                                          MinorVersion,
                                          Release,
                                          Build        : Word;
                                      out LastUpdate   : TDateTime;
                                      out Options      : String );
begin
     SessionService.GetDatabaseInfo( CodigoEmpresa, MajorVersion, MinorVersion, Release, Build, LastUpdate, Options );
end;

// El path es desde el directorio remoto raiz

function TKbmRpcDataModule.GetFile( AFileName : String ) : Int64;

var  SourceFile,
     TargetFile : String;
     RetryCount : SmallInt;
     Done : Boolean;

begin

     CurrentDir := AddPathDelim( CurrentDir );
     SourceFile := AddPathDelim( RemoteDir + VersionDir ) + CurrentDir + AFileName;
     TargetFile := AddPathDelim( LocalDir + VersionDir ) + CurrentDir + AFileName;

     Result := 0;
     RetryCount := 0;

     repeat
        Done := FileClient.GetFile( TargetFile, SourceFile );
        If   not Done
        then begin
             Delay( 500 );
             Inc( RetryCount );
             end;
     until Done or ( RetryCount=10 );

     If   Done
     then Result := GetFileSize( TargetFile );

     If   Assigned( DataProgressBar )
     then DataProgressBar.Position := 0;

end;

procedure TKbmRpcDataModule.PutFile( AFileName   : String );

var  OriginalSourceFile,
     SourceFile,
     TargetFile : String;

begin

     CurrentDir := AddPathDelim( CurrentDir );
     SourceFile := AddPathDelim( LocalDir + VersionDir ) + CurrentDir + AFileName;
     TargetFile := AddPathDelim( RemoteDir + VersionDir ) + CurrentDir + AFileName;

     If   RpcProcessType=ptUpdate
     then begin
          OriginalSourceFile := AddPathDelim( ApplicationPath ) + CurrentDir + AFileName;
          CopyFile( OriginalSourceFile, SourceFile );
          end;

     FileSize := GetFileSize( SourceFile );
     FileClient.PutFile( SourceFile, TargetFile );

     If   Assigned( DataProgressBar )
     then DataProgressBar.Position := 0;

end;

procedure TKbmRpcDataModule.RegisterInstallation;
begin
     With FileCLient, ProtectionRec do
       Request( FileService, '', 'Install', [ SerialNumber, ActivationKey, RegNumber, ProgramNumber, ProgramVersion, ProgramRelease, ServerConnections ] );
end;

function TKbmRpcDataModule.AccesoUsuario( CodigoUsuario    : String;
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

{
procedure TRpcModule.CierraSesion;
begin
     If   IDSesion<>-1
     then begin
          Session. CierraSesion( IDsesion );
          IDSesion := -1;
          end;
end;
}

procedure TKbmRpcDataModule.EndSessionProgress;
begin
     If   Assigned( FOnEndProgress )
     then FOnEndProgress;
end;

function TKbmRpcDataModule.EnterpriseRequest(       FunctionName : String;
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

procedure TKbmRpcDataModule.EraseEnterpriseDatabase( CodigoEmpresa : String );
begin
     SessionService.EraseEnterpriseDatabase( CodigoEmpresa );
end;

procedure TKbmRpcDataModule.LockRead( Value : Boolean );
begin
     With FileCLient, ProtectionRec do
       Request( FileService, '', 'LockRead', [ Value ] );
end;

function TKbmRpcDataModule.SendSessionNotification( NotificationType : TNotificationType;
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

       ntInformation..ntHeader :
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

function TKbmRpcDataModule.SendSessionProgress( ObjectName : String; Percent1, Percent2  : SmallInt ) : Boolean;
begin
     Result := False;
     If   Assigned( FOnProgress )
     then Result := FOnProgress( ObjectName, Percent1, Percent2  );
end;

procedure TKbmRpcDataModule.Setup( ARpcProcessType : TRpcProcessType;
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

{
procedure TRpcModule.StartTransaction(Notify: Boolean);
begin
     SessionService.StartTransaction( Notify );
     FInRemoteTransaction := True;
end;
}

procedure TKbmRpcDataModule.UpdateDatabase( CodigoEmpresa  : String );
begin
     SessionService.UpdateDatabase( CodigoEmpresa );
end;

function TKbmRpcDataModule.BackupDatabaseTables(UserDatabase: Boolean; BackupDatabasePath, TableNames: String): Boolean;
begin
     Result := SessionService.BackupDatabaseTables( UserDatabase, BackupDatabasePath, TableNames );
end;

function TKbmRpcDataModule.GetFileVersion( FilePath     : String;
                                    IncludeBuild : Boolean = True ) : LongWord;
begin
     With FileClient do
       Result := Request( FileService, '', 'GetFileVersion', [ FilePath, IncludeBuild ] );
end;

function TKbmRpcDataModule.SessionCount( CodigoEmpresa : String = '' ) : SmallInt;
begin
     Result := SessionService.SessionCount( CodigoEmpresa );
end;

procedure TKbmRpcDataModule.CreateRemoteDirPath( DirPath : String );
begin
     With FileClient do
       Request( FileService, '', 'CreateDirPath', [ DirPath ] );
end;

procedure TKbmRpcDataModule.FileClientProgress(     Sender    : TObject;
                                             Pct       : Integer;
                                             Receiving : Boolean;
                                         var Terminate : Boolean);

begin

     If   Assigned( DataProgressBar )
     then If   TotalDownloadSize=0
          then DataProgressBar.Position := Pct
          else begin
               Pct := Trunc( CurrentDownloadSize + ( ( FileSize * Pct ) / 100.0 ) );
               DataProgressBar.Position := Pct;
               end;

     If   Assigned( DataLabel )
     then DataLabel.Caption := Format( 'Descargando ... %d %%', [ Pct ] );

     Application.ProcessMessages;

     If   Cancelled
     then Terminate := True;

end;

function TKbmRpcDataModule.FixCurrentDir( ADir      : String;
                                   Uploading : Boolean = False ) : Boolean;

begin

     Result := False;
     CurrentDir := AddPathDelim( ADir );

     case RpcProcessType of
       ptUpdate   : begin
                    RemotePath := AddPathDelim( ( AddPathDelim( RemoteDir + VersionDir ) + CurrentDir ) );
                    LocalPath := AddPathDelim( ApplicationPath + CurrentDir );
                    UpdatePath := AddPathDelim( LocalDir + VersionDir ) + CurrentDir;
                    CreateDirPath( UpdatePath );
                    end;
       ptDownload : begin
                    RemotePath := AddPathDelim( ( AddPathDelim( RemoteDir + VersionDir ) + CurrentDir ) );
                    LocalPath := AddPathDelim( LocalDir + VersionDir );
                    end;
       end;

     If   Uploading
     then begin
          If   not DirectoryExists( LocalPath )
          then Exit;
          // Me aseguro de que exista el directorio de actualización
          CreateRemoteDirPath( RemotePath );
          end;

     Result := True;

end;

procedure TKbmRpcDataModule.FreeAllSessionDataModules;
begin
     SessionService.FreeAllSessionDataModules;
end;

function TKbmRpcDataModule.CheckKey(       RemoteCursorID  : TnxCursorID;
                              const Key             : TVariantArray;
                              const DescFieldNames  : TStringArray;
                              out   DescFieldValues : TVariantArray ) : Boolean;
begin
     Result := SessionService.CheckKey( RemoteCursorID, Key, DescFieldNames, DescFieldValues );
end;

procedure TKbmRpcDataModule.NetIdleEvent(aSender: TObject; AWaitEvent: THandle);

var   Msg: TMsg;
const PM_QS_SENDMESSAGE = QS_SENDMESSAGE shl 16;

begin
     { queremos procesar solo llamadas de sendmessage en espera, nada más }
     PeekMessage( Msg, 0, 0, 0, PM_NOREMOVE or PM_NOYIELD or PM_QS_SENDMESSAGE );
end;

end.

