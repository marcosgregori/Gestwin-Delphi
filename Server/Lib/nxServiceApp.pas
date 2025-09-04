
{$I ..\Lib\nxsrDefine.inc}

{just add the following code BEFORE Application.Initialize in the dpr file

 if snxServiceApp.CheckApplicationService('ServiceName', 'ServiceDisplayName', TaMainFormClass) then
   exit;

 commandline:
   exename /INSTALL          - installs the service
   exename /UNINSTALL        - un-installs the service
   exename /INTERACTIVE      - starts the app as normal application instead of an nt service
   exename /DEBUG            - (only if entered in service manager params box!!) waits for a debugger
                             - to connect to the service before creating the mainform }
unit nxServiceApp;

{.$define WriteLog}

interface

uses
  ActiveX, // must be above Variants!!!
  ComObj,
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Messages,
  Dialogs,
  registry,
  WinSvc,
  SysUtils,
  Classes,
  nxllTypes,
  nxllFastFillChar,
  nxllMemoryManager,
  WindowsServiceManager,
  Controls,
  Forms,
  ShellAPI,
  BaseServerContainer;

const
  csUSERNAME = 'USERNAME';
  csPASSWORD = 'PASSWORD';
  csRUNAS    = 'RUNAS';

  csLOGGING  = 'LOGFILE';

  csSERVICENAME = 'SERVICENAME';
  csDISPLAYNAME = 'DISPLAYNAME';
  csDESCRIPTION = 'DESCRIPTION';

  csHELP        = 'HELP';
  csINSTALL     = 'INSTALL';
  csUNINSTALL   = 'UNINSTALL';
  csSTART       = 'START';
  csNOSTART     = 'NOSTART';
  csSTOP        = 'STOP';
  csSILENT      = 'SILENT';
  csINTERACTIVE = 'INTERACTIVE';
  csWRITECONFIG = 'WRITECONFIG';
  csRESET       = 'RESET';
  csDEBUG       = 'DEBUG';

  // v3.01
  csLOCALSYSTEM = 'LOCALSYSTEM';
  csALLOWSYSTEM = 'ALLOWSYSTEM';

  csADDUSER    = 'ADDUSER';
  csREMOVEUSER = 'REMOVEUSER';

  csADDGROUP    = 'ADDGROUP';
  csREMOVEGROUP = 'REMOVEGROUP';

  csSETPRIVILEGES    = 'SETPRIVILEGES';
  csREMOVEPRIVILEGES = 'REMOVEPRIVILEGES';

  csSETFULLACCESS      = 'SETFULLACCESS';
  csLOCALSYSTEMACCOUNT = 'LOCALSYSTEMACCOUNT';

  csNOICON = 'NOICON';

  dfServiceName : String = 'GestwinRPCServerV11';
  dfServiceDisplayName : String = 'Gestwin - Servidor de aplicaciones';
  dfServiceDescription : String = 'Ofrece servicios de base de datos y de conectividad a las aplicaciones cliente de GESTWIN.';

type
  TWindowsService = class;
  TWindowsServiceApp = class;
  TDataModuleClass = class of TDataModule;

  { is fired after the mainform is shown }
  TStartupNotifyEvent = procedure(aServiceApp: TWindowsServiceApp);

  TWindowsServiceApp = class(TObject)
  protected
    fLogging: boolean;
    WasInstalled: boolean;
    saStarted: Boolean;
    saOnAfterStartup: TStartupNotifyEvent;
    saService: TWindowsService;

    class function GetKnownParams: string;
  public

    { this function checks if the application was started with an '/INTERACTIVE' parameter
      if yes, the app is started as a normal application, else as service
      if there's a '/DEBUG' parameter entered in the service manager control box,
      this function waits for a debugger to attach to the service before creating
      the mainform (has no effect in interactiv mode)
      The Commandline parameters ServiceName and DisplayName can be used to
      override AName and aTitle for installing multiple instances of a service.
    }
    function CheckService(const AName: string; const aTitle: string; aHidden: Boolean = False; aAllowSystem: Boolean = False): Boolean;

    { gives access to the TService }
    property Service: TWindowsService read saService;

    { is called after the mainform is shown }
    property OnAfterStartup: TStartupNotifyEvent
      read saOnAfterStartup
      write saOnAfterStartup;
    property KnownParams: string
      read GetKnownParams;
  end;

  TWindowsService = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
  private
    svcEndSession: Boolean; // true if windows has sent a WM_QUERYENDSESSION message

    function GetWndHook(var Message: TMessage): Boolean;
  protected
    fLogging                    : boolean;
    svcServiceApp               : TWindowsServiceApp;
    svcHidden                   : Boolean;
    svcDoReportStatus           : Boolean;
    svcReportStatusThreadHandle : THandle;
    svcReportStatusLastTime     : TDateTime;

    svcServerContainerClass: TBaseServerContainerModuleClass;
    svcServerContainerModule : TBaseServerContainerModule;

    { called from the service controller when the service should be stopped }
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);

    { called from the service controller when the service should be shut }
    procedure ServiceShutdown( Sender : TService );

    { called from the service controller when the service should start }
    procedure ServiceStart( Sender : TService; var Started : Boolean );

    { main loop of the service controller thread; is just a dummy that waits
      for the service to shutdown/stop }
    procedure ServiceExecute(Sender: TService);

    { is called when the /DEBUG param is entered in the Service Manager's parameters
      edit box. }
    procedure DoServiceDebugLoop;

    { the CloseQuery eventhandler attached to the MainForm; it minimizes the form
      and denies the user to close the app }
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure ServiceStillBusy;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetServiceController: TServiceController; override;

    property ServerContainerModule : TBaseServerContainerModule read svcServerContainerModule;
    property ServerContainerClass : TBaseServerContainerModuleClass read svcServerContainerClass;

    { access to the calling TnxServiceApp }
    property ServiceApp : TWindowsServiceApp read svcServiceApp write svcServiceApp;
  end;

function CheckApplicationService: Boolean;
function StartWindowsServiceManager : Boolean;
procedure InstallApplicationService( StartService : Boolean = True );
function IsServiceRunning : Boolean;

function nxOpenService(const aServiceName: string; QueryOnly: Boolean = false): SC_HANDLE;

function nxIsServiceStarting(const aServiceName: string): Boolean;
function nxIsServiceRunning(const aServiceName: string ): Boolean;
function nxStartService(const aServiceName: string): Boolean;
function nxGetServiceDisplayName(const aServiceName: string): string;
function nxStopService(const aServiceName: string): Boolean;
function nxIsService(const aServiceName: string): Boolean;
{ Returns a boolean indicating whether or not user has admin
  privileges. (Call only then running under NT.) }
function nxRunningAsService: Boolean;

{ singleton that should be used to start an app as service }
function snxServiceApp: TWindowsServiceApp;


var
  nxStartedAsService: Boolean = False;
  ServerContainerClass : TBaseServerContainerModuleClass;

type
  WELL_KNOWN_SID_TYPE = (
    WinNullSid,
    WinWorldSid,
    WinLocalSid,
    WinCreatorOwnerSid,
    WinCreatorGroupSid,
    WinCreatorOwnerServerSid,
    WinCreatorGroupServerSid,
    WinNtAuthoritySid,
    WinDialupSid,
    WinNetworkSid,
    WinBatchSid,
    WinInteractiveSid,
    WinServiceSid,
    WinAnonymousSid,
    WinProxySid,
    WinEnterpriseControllersSid,
    WinSelfSid,
    WinAuthenticatedUserSid,
    WinRestrictedCodeSid,
    WinTerminalServerSid,
    WinRemoteLogonIdSid,
    WinLogonIdsSid,
    WinLocalSystemSid,
    WinLocalServiceSid,
    WinNetworkServiceSid,
    WinBuiltinDomainSid,
    WinBuiltinAdministratorsSid,
    WinBuiltinUsersSid,
    WinBuiltinGuestsSid,
    WinBuiltinPowerUsersSid,
    WinBuiltinAccountOperatorsSid,
    WinBuiltinSystemOperatorsSid,
    WinBuiltinPrintOperatorsSid,
    WinBuiltinBackupOperatorsSid,
    WinBuiltinReplicatorSid,
    WinBuiltinPreWindows2000CompatibleAccessSid,
    WinBuiltinRemoteDesktopUsersSid,
    WinBuiltinNetworkConfigurationOperatorsSid,
    WinAccountAdministratorSid,
    WinAccountGuestSid,
    WinAccountKrbtgtSid,
    WinAccountDomainAdminsSid,
    WinAccountDomainUsersSid,
    WinAccountDomainGuestsSid,
    WinAccountComputersSid,
    WinAccountControllersSid,
    WinAccountCertAdminsSid,
    WinAccountSchemaAdminsSid,
    WinAccountEnterpriseAdminsSid,
    WinAccountPolicyAdminsSid,
    WinAccountRasAndIasServersSid,
    WinNTLMAuthenticationSid,
    WinDigestAuthenticationSid,
    WinSChannelAuthenticationSid,
    WinThisOrganizationSid,
    WinOtherOrganizationSid,
    WinBuiltinIncomingForestTrustBuildersSid,
    WinBuiltinPerfMonitoringUsersSid,
    WinBuiltinPerfLoggingUsersSid,
    WinBuiltinAuthorizationAccessSid,
    WinBuiltinTerminalServerLicenseServersSid
  );
  TWellKnownSidType = WELL_KNOWN_SID_TYPE;

function CreateWellKnownSid(WellKnownSidType: TnxNativeUInt; DomainSid: PSID;
  pSid: PSID; var cbSid: DWORD): BOOL; stdcall;

function CheckTokenMembership(TokenHandle: THANDLE; SidToCheck: PSID; var IsMember: BOOL): BOOL; stdcall;
procedure Check(aResult: DWORD; const aSource: string);

var  nxService : TWindowsService;

implementation

{%CLASSGROUP 'VCL.Types.TVCLObject'}

{$R *.dfm}

uses
  System.UITypes,
  AppManager,
  nxllPlatformInterface,
  nxllUtils,
  nxllException,
  nxexeConst,
  nxllUserManagement,
  nxpvServiceInstallForm;

var
  csServiceLogFilename: string;

resourcestring
    rsTheAccountHasToBeInTheFormDomainUserAccount = 'La cuenta tiene que tener el formato "Dominio\cuentaDeUsuario".';
    rsPleaseNoteThatTheAccountNeedsTheLogonAsServiceRightsAssigned = 'También es necesario que tenga asignado el derecho "Iniciar sesión como un servicio".';
    rsLookInTheGettingStartedGuideOrManualForMoreInformation = 'Consulte el manual de primeros pasos para obtener más información.';
    rsUserAccountForService = 'Cuenta de usuario para el servicio';
    rsDoYouWantToStartTheServiceNow = '¿Desea iniciar el servicio ahora?';
    rsTheServiceHasBeenStarted = 'El servicio ha sido iniciado.';
    rsThereIsNoSuchService = 'El servicio no existe.';
    rsTheServiceIsRunningDoYouWantToStopItNow = 'El servicio se está ejecutando. ¿Quiere detenerlo ahora?';
    rsTheServiceHasBeenStopped = 'El servicio ha sido detenido';
    rsHelpText1 =
'/HELP, /?'#13#10+
'    muestra la ayuda'#13#10+
'/INTERACTIVE'#13#10+
'    inicia el servidor en modo interactivo. Siempre es preferible iniciarlo como un servicio'#13#10+
'/INSTALL'#13#10+
'    instala el servicio'#13#10+
'/LOCALSYSTEMACCOUNT'#13#10+
'    Cuando se usa en combinación con /INSTALL el servidor se instalará como una '#13#10+
'    cuenta LOCAL DE SISTEMA. Por favor, tenga en cuenta las implicaciones de seguridad y acceso '#13#10+
'    de ejecutar un servidor on capacidades de "scripting" como un usuario de SISTEMA.'#13#10+
'/UNINSTALL'#13#10+
'    des-instala el servicio'#13#10+
'/START'#13#10+
'    inicia el servicio'#13#10+
'/STOP'#13#10+
'    Si no se usa con /INTERACTIVE, detiene el servicio del servidor.'#13#10+
'    Si se usa con /INTERACTIVE, la instancia del servidor se detendrá automáticamente, '#13#10+
'    después de un /RESET o /WRITECONFIG.'#13#10+
'/NOSTART'#13#10+
'    no preguntar para iniciar el servicio'#13#10+
'/SILENT'#13#10+
'    sin dialogos'#13#10+
'/SERVICENAME:nombre'#13#10+
'    nombre del servicio'#13#10+
'/DISPLAYNAME:nombre'#13#10+
'    muestra el nombre del servicio'#13#10+
'/DESCRIPTION:descripción'#13#10+
'    descripción del servicio'#13#10+
'/USERNAME:dominio\usuario'#13#10+
'    cuenta de usuario de la forma Dominio\NombreDeUsuario para el servicio. Si no se especifica el dominio '#13#10+
'    se asume el punto ''.'' (maquina local).'#13#10+
'/PASSWORD:palabra de paso'#13#10+
'    palabra de paso de la cuenta del servicio'#13#10+
'/LOGFILE:nombre del fichero'#13#10+
'    nombre del fichero de registro opcional'#13#10+
'/DEBUG'#13#10+
'    se inicia una espera de 15 segundos para que un debugger se enlace al servicio'#13#10+
'/ALLOWSYSTEM'#13#10+
'    permite al servicio ejecutarse como una cuenta del sistema. Necesita ser especificado durante '#13#10+
'    la instalación del servicio.'#13#10+
'/ADDUSER'#13#10+
'    añade una nuevo usuario de Windows. El nombre de usuario y palabra de paso deben especificarse usando '#13#10+
'    los parámetros /Username y /Password. Si el usuario ya existe y la palabra de paso es '#13#10+
'    incorrecta, se proceduce un error, si la palabra de paso coincide la operación se asumirá como '#13#10+
'    correcta. ¡Solo está disponible en la máquina local!'#13#10+
'/REMOVEUSER'#13#10+
'    suprime un usuario de Windows. El nombre del usuario se tiene que especificar mediante el parámetro '#13#10+
'    /Username. La supresión es irreversible.  ¡Solo está disponible en la máquina local!'#13#10+
'/ADDGROUP:group'#13#10+
'    añade un usuario de Windows a un grupo de usuarios. El nombre del usuario se tiene que especificar mediante el parámetro '#13#10+
'    /Username. La supresión es irreversible. ¡Solo está disponible en la máquina local!'#13#10+
'/REMOVEGROUP:group'#13#10+
'    quita un usuario de Windows de un grupo de usuarios. El nombre del usuario se tiene que especificar mediante el parámetro '#13#10+
'    /Username. La supresión es irreversible. ¡Solo está disponible en la máquina local!'#13#10+
'/SETPRIVILEGES:privileges'#13#10+
'    concede privilegios a un usuario de Windows. El nombre del usuario se tiene que especificar mediante el parámetro '#13#10+
'    /Username. Los privilegios se especifican como una lista separada por comas. Para obtener una lista '#13#10+
'    de los privilegios aceptados consulte la tabla inferior. ¡Solo está disponible en la máquina local!'#13#10+
'/REMOVEPRIVILEGES'#13#10+
'    revoca priviegios a un usuario de Windows. El nombre del usuario se tiene que especificar mediante el parámetro '#13#10+
'    /Username. Los privilegios se especifican como una lista separada por comas. Para obtener una lista '#13#10+
'    de los privilegios aceptados consulte la tabla inferior. ¡Solo está disponible en la máquina local!'#13#10;

//resource string length limitation
  rsHelpText2 =
'/SETFULLACCESS:paths'#13#10+
'    Añade derechos totales de acceso a una relación de ficheros/carpetas a un usuario de Windows. '#13#10+
'    Se tiene que indicar el nombre del usuario mediante el parámetro /Username. Los paths son una lista '#13#10+
'    de nombres de ficheros/carpetas. Si un path es una carpeta todas las sub-carpetas y ficheros heredan el '#13#10+
'    acceso total. Asegúrese de situar la lista de paths entre "" si hay espacios en los nombres.'#13#10+
'    ¡Solo disponible en la máquina local! El servicio del servidor se garantiza automáticamente '#13#10+
'    a sí mismo derechos de acceso totales a los directorios de configuración y sistema del servicio.'#13#10+
'/RESET'#13#10+
'    Fuerza al servidor a reiniciar su configuración desde el fichero gdbserver.init '#13#10+
'    localizado en la misma carpeta que el ejecutable. El fichero gdbserver.init tiene el '#13#10+
'    mismo formato que el fichero gdbworksettings y también se carga cuando no se encuentra un fichero de '#13#10+
'    parámetros de trabajo (por ejemplo, en el primer inicio). Si no existe el fichero  gdbserver.init, /RESET '#13#10+
'    activa todos los modulos de el servidor y fija los valores por defecto. '#13#10+
'    Nota: solo funciona en modo /INTERACTIVE. En este modo, /STOP puede ser usado para detenr el servidor '#13#10+
'    despés de la inicialización (pe, para inicializar la configuración antes de iniciar el servicio). '#13#10+
'/WRITECONFIG:pathynombredefichero'#13#10+
'    Instruye al servidor para guardar su configuración en el fichero indicado. El formato es '#13#10+
'    el mismo que el del fichero gddbworksettings. '#13#10+
'    Nota: solo funciona en modo /INTERACTIVE. En este modo, /STOP se puede usar para detener el servidor '#13#10+
'    después de grabar el fichero en el disco. ';


function CreateWellKnownSid; external advapi32 name 'CreateWellKnownSid';

function CheckTokenMembership; external advapi32 name 'CheckTokenMembership';

procedure Check(aResult: DWORD; const aSource: string);
begin
  if aResult <> 0 then begin
    SetLastError(aResult);
    nxRaiseLastOSError(false, 'nxServiceApp / ' + aSource);
  end;
end;

function CurrentUserIsLocalSystem : boolean;
var
  hAccessToken: tHandle;
  ptgGroups: pTokenGroups;
  ptgUser: PSIDAndAttributes;
  dwInfoBufferSize: DWORD;
  psidLocalSystem: PSID;
  blnResult: boolean; // return flag
  IsMember : LongBool;

const
  SECURITY_NT_AUTHORITY: SID_IDENTIFIER_AUTHORITY =
  (Value: (0, 0, 0, 0, 0, 5)); // ntifs
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
  DOMAIN_ALIAS_RID_USERS: DWORD = $00000221;
  DOMAIN_ALIAS_RID_GUESTS: DWORD = $00000222;
  DOMAIN_ALIAS_RID_POWER_: DWORD = $00000223;
  SECURITY_SERVICE_RID: DWORD = $00000006;
  SID_REVISION                    = 1; // Current revision level
  SID_MAX_SUB_AUTHORITIES         = 15;
  SID_RECOMMENDED_SUB_AUTHORITIES = 1; // Will change to around 6 in a future release.
type
  SID = record
    Revision: Byte;
    SubAuthorityCount: Byte;
    IdentifierAuthority: SID_IDENTIFIER_AUTHORITY;
    SubAuthority: array [0..SID_MAX_SUB_AUTHORITIES] of DWORD;
  end;
const
  SECURITY_MAX_SID_SIZE = SizeOf(SID) - SizeOf(DWORD) + (SID_MAX_SUB_AUTHORITIES * SizeOf(DWORD));
begin
  Result := False;
  ImpersonateSelf (SecurityImpersonation);
  blnResult := OpenThreadToken(GetCurrentThread, TOKEN_QUERY,
    True, hAccessToken);
  if (not blnResult) then begin

    if GetLastError = ERROR_NO_TOKEN then
      blnResult := OpenProcessToken(GetCurrentProcess,
        TOKEN_QUERY, hAccessToken);
  end;

  ptgUser := nil;
  ptgGroups := nil;
  psidLocalSystem := nil;
  if (blnResult) then try
    // First check for local system. For this we first get the length of the
    // current User information
    if GetTokenInformation(hAccessToken, TokenUser, nil, 0, dwInfoBufferSize) then
        Check(GetLastError, 'get dwInfoBufferSize');

    // Allocate the necessary memory and get the User information
    GetMem(ptgUser, dwInfoBufferSize);
    if not GetTokenInformation(hAccessToken, TokenUser,
      ptgUser, dwInfoBufferSize,
      dwInfoBufferSize) then
        Check(GetLastError, 'GetTokenInformation');

    dwInfoBufferSize := SECURITY_MAX_SID_SIZE;
    psidLocalSystem := nxGetMemLow(dwInfoBufferSize);
    if not CreateWellKnownSid(TnxNativeUInt(WinLocalSystemSid), nil, psidLocalSystem, dwInfoBufferSize) then
      Check(GetLastError, 'CreateWellKnownSid');

    if not CheckTokenMembership(hAccessToken, psidLocalSystem, IsMember) then
      Check(GetLastError, 'CheckTokenMembership');

    // running as local system!
    Result := IsMember;

  finally
    //FreeSid is only for SIDs allocated using AllocateAndInitializeSid!
    CloseHandle(hAccessToken);
    if Assigned(ptgUser) then
      FreeMem(ptgUser);
    if Assigned(ptgGroups) then
      FreeMem(ptgGroups);
    if Assigned(psidLocalSystem) then
      FreeMem(psidLocalSystem);
  end;

end;

function CheckApplicationService : Boolean;
begin
     Result := snxServiceApp.CheckService( dfServiceName, dfServiceDisplayName, True, True );
end;

function IsServiceRunning : Boolean;
begin
     Result := nxIsServiceRunning( dfServiceName );
end;

function StartWindowsServiceManager : Boolean;
begin
     Result := False;
     If   snxServiceApp<>nil
     then begin
           nxStartedAsService := True;
           WindowsServiceManager.ServiceApplication.Initialize;
           WindowsServiceManager.ServiceApplication.Title := dfServiceName;
           WindowsServiceManager.ServiceApplication.CreateForm( TWindowsService, nxService );
           snxServiceApp.saService := nxService;

           { make sure service never shows journalform }
           nxShowJournalFrm := nil;
           Result := True;
           end;
end;

procedure InstallApplicationService;
begin

      nxService.ServiceStartName := csLOCALSYSTEM;
      nxService.Password := '';

      // make sure we've full access to the setup directory

      AddPrivilege( csLOCALSYSTEM, 'SeServiceLogonRight' );

      nxService.ServiceApp := snxServiceApp;
      nxService.DisplayName := dfServiceDisplayName;
      nxService.Name := dfServiceName;

      WindowsServiceManager.ServiceApplication.RegisterServices( True, True ); // Instala el servicio

      If   nxIsService( dfServiceName )
      then If   StartService
           then try
                  // nxStopService( lServiceName );
                  nxStartService( dfServiceName );
                except on E : exception do
                  MessageDlg( 'Error ejecutando el servicio :' + e.Message, TMsgDlgType.mtError, [ TMsgDlgBtn.mbok ], 0 );
                  end;
end;


{===TnxServiceApp==============================================================}

function TWindowsServiceApp.CheckService( const AName                 : String;
                                          const ATitle                : String;
                                                AHidden               : Boolean = False;
                                                AAllowSystem          : Boolean = False ) : Boolean;
var  lDisplayName : String;
     lServiceName : String;
     IsLocalSystem : Boolean;
     lUserName,
     lPassWord : String;
     CommandLine : String;
     i : Integer;
     lPrivileges : String;
     lRPrivileges : String;
     lGroup : String;
     lRGroup : String;
     aList : TSTringlist;
     lPaths : String;
     DidSomething : Boolean;
     ldescription : String;
     ServiceInstallForm : TfrmServiceInstall;

begin

  // F:\Desktop\Gestwin\GServer.exe /ServiceName:GestwinRPCServerV11

  Result := False;

  If   Win32Platform<>VER_PLATFORM_WIN32_NT
  then Exit;

  if   ( ParamCount=0 ) or ( nxFindCmdLineSwitch( csINTERACTIVE ) )
  then Exit;

  nxFindCmdLineParam(csLogging, csServiceLogFilename);
  fLogging := csServiceLogFilename <> '';

  nxFindCmdLineParam(csDisplayName, lDisplayName);
  if lDisplayName = '' then
    lDisplayName := aTitle;
  nxFindCmdLineParam(csServiceName, lServiceName);
  if lServiceName = '' then
    lServiceName := AName;
  nxFindCmdLineParam(csUSERNAME, lUserName);
  nxFindCmdLineParam(csPASSWORD, lPassword);
  nxFindCmdLineParam(csSETPRIVILEGES, lPrivileges);
  nxFindCmdLineParam(csREMOVEPRIVILEGES, lRPrivileges);
  nxFindCmdLineParam(csADDGROUP, lGroup);
  nxFindCmdLineParam(csREMOVEGROUP, lRGroup);
  nxFindCmdLineParam(csSETFULLACCESS, lPaths);

  if (not nxFindCmdLineSwitch(csINSTALL)) and
    (not nxFindCmdLineSwitch(csSTART)) and
    (not nxFindCmdLineSwitch(csADDUSER)) and
    (not nxFindCmdLineSwitch(csREMOVEUSER)) and
    (lGroup='') and
    (lRGroup='') and
    (lPrivileges='') and
    (lRPrivileges='') and
    (lPaths='') and
    (not nxFindCmdLineSwitch(csSTOP)) and
    (not nxFindCmdLineSwitch(csUNINSTALL)) then begin
    if not nxIsServiceStarting(lServiceName) then
      Exit;

    if nxFindCmdLineSwitch(csALLOWSYSTEM) or (nxFindCmdLineSwitch(csLOCALSYSTEMACCOUNT)) then
      aAllowSystem:=true;

    // LogMessage('comprueba LocalSystem');
    if (not aAllowSystem) and CurrentUserIsLocalSystem then begin
      // LogMessage('no puede iniciarse como LocalSystem');
      Result := True;
      Exit;
      end;
    end;

  // LogMessage('inicia el servicio');
  Result := True;

  StartWindowsServiceManager;

  try
    // LogMessage('comprueba la linea de comandos');

    DidSomething := False;
    if nxFindCmdLineSwitch(csADDUSER) then begin
      // LogMessage('Añade usuario');
      Check(AddUserAccount(lUserName, lPassword, '.'), 'AddUserAccount');
      DidSomething := True;
    end;

    if nxFindCmdLineSwitch(csREMOVEUSER) then begin
      // LogMessage('Suprime usuario');
      Check(DeleteUserAccount(lUserName, '.'), 'DeleteUserAccount');
      DidSomething := True;
    end;

    if lGroup <> '' then begin
      // LogMessage('Añade usuario a grupo');
      Check(AddToLocalGroup(lUserName, lGroup, '.'), 'AddToLocalGroup');
      DidSomething := True;
    end;

    if lRGroup<>'' then begin
      // LogMessage('Quita usuario de grupo');
      Check(RemoveFromLocalGroup(lUserName, lRGroup, '.'), 'RemoveFromLocalGroup');
      DidSomething := True;
    end;

    if lPrivileges<>'' then begin
      // LogMessage('Asigna privilegios de usuario');
      aList:=TStringList.Create;
      aList.Text:=StringReplace(lPrivileges, ',', #13, [rfReplaceAll]);
      for I := 0 to aList.Count - 1 do
        Check(AddPrivilege(lUserName, trim(alist[i])), 'AddPrivilege');
      DidSomething := True;
    end;

    if lRPrivileges<>'' then begin
      // LogMessage('Revoca privilegios de usuario');
      aList:=TStringList.Create;
      aList.Text:=StringReplace(lRPrivileges, ',', #13, [rfReplaceAll]);
      for I := 0 to aList.Count - 1 do
        Check(RemovePrivilege(lUserName, trim(alist[i])), 'RemovePrivilege');
      DidSomething := True;
    end;

    if lPaths<>'' then begin
      // LogMessage('Fija derechos de acceso');
      aList:=TStringList.Create;
      aList.Text:=StringReplace(lPaths, ',', #13, [rfReplaceAll]);
      for I := 0 to aList.Count - 1 do
        Check(SetAccessRights(trim(alist[i]), lUserName, GENERIC_ALL), 'SetAccessRights');
      DidSomething := True;
    end;

    if DidSomething and not (
        nxFindCmdLineSwitch(csINSTALL) or
        nxFindCmdLineSwitch(csUNINSTALL) or
        nxFindCmdLineSwitch(csSTART) or
        nxFindCmdLineSwitch(csSTOP)
      ) then
        Exit;

    IsLocalSystem:=false;
    if nxFindCmdLineSwitch(csINSTALL) then begin
      // LogMessage('Instala servicio');
      { 10.02.2021 : Siempre LOCALSYSTEMACCOUNT
      if nxFindCmdLineSwitch(csLOCALSYSTEMACCOUNT) then
      begin
      }
        IsLocalSystem := True;
        lUserName := csLOCALSYSTEM;
        lPassword := '';
      {
      end;
      }
      if (Trim(lUserName) = '') or (not SameText(lUserName, csLOCALSYSTEM) and (Trim(lPassword) = '')) then
       If   not nxFindCmdLineSwitch( csSILENT )
        then begin
             Application.CreateForm( TfrmServiceInstall, ServiceInstallForm );
             Application.Run;  // No ha tenido oportunidad de iniciarse antes
             Exit;
             end;

      if not SameText(csLOCALSYSTEM, lUserName) then
        if pos('\', lUserName) < 1 then
          lUserName := '.\' + lUserName;
      Service.ServiceStartName := lUserName;
      Service.Password := lPassword;

      // make sure we've full access to the setup directory
      AddPrivilege(lUserName, 'SeServiceLogonRight');
      if not IsLocalSystem then
        Check(SetAccessRights(nxAppHomeDirectory(nxAppDataSubdirVista), lUserName, Generic_ALL), 'SetAccessRights(AppHomeDirectory)');

      // LogMessage('Instalación de servicio hecha');
    end;

    if nxFindCmdLineSwitch(csUNINSTALL) then begin
      // LogMessage('Des-instala servicio');
      if nxIsServiceRunning(lServiceName) then
        if (nxFindCmdLineSwitch(csSILENT) or
          (MessageDlg(rsTheServiceIsRunningDoYouWantToStopItNow, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes)) then  //..
          nxStopService(lServiceName);
    end;

    Service.svcServiceApp := Self;
    Service.svcHidden := aHidden;
    Service.DisplayName := lDisplayName;
    Service.Name := nxMakeValidIdent(lServiceName, ['A'..'Z', 'a'..'z', '0'..'9']);
    Service.svcServerContainerClass := ServerContainerClass;
    
    // LogMessage('ejecuta servicio');
    if not nxFindCmdLineSwitch(csINSTALL) and nxFindCmdLineSwitch(csSTART) then begin
      if not nxIsService(lServiceName) then
      begin
        MessageDlg(rsThereIsNoSuchService, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbok], 0);
        exit;
      end;

      if not nxStartService(lServiceName) then
        if not nxFindCmdLineSwitch(csSILENT) then
          RaiseLastOSError;

      if not nxFindCmdLineSwitch(csSILENT) then
        MessageDlg(rsTheServiceHasBeenStarted, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbok], 0);
    end
    else
      if nxFindCmdLineSwitch(csSTOP) then begin
        if not nxStopService(lServiceName) then
          if not nxFindCmdLineSwitch(csSILENT) then
            RaiseLastOSError;
        if not nxFindCmdLineSwitch(csSILENT) then
          MessageDlg(rsTheServiceHasBeenStopped, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbok], 0);
      end
      else begin
        WasInstalled := false;
        WindowsServiceManager.ServiceApplication.Run;
      end;
  except
    on E: Exception do begin
      if not nxFindCmdLineSwitch(csSILENT) and not nxFindCmdLineSwitch(csRUNAS) then begin
        if E is EOSError then
          with EOSError(E) do
            if ErrorCode = 5 then
              if nxOSIsWindowsVistaOrBetter then begin
                CommandLine := '/'+csRUNAS+' "/' + csUSERNAME + ':' + lUserName + '" "/' + csPASSWORD + ':' + lPassword + '" ';
                for i := 1 to ParamCount do
                  CommandLine := CommandLine + '"' + ParamStr(i) + '" ';
                ShellExecute(0, 'runas', PChar(ParamStr(0)), PChar(CommandLine), PChar(GetCurrentDir), CmdShow);
                Exit;
              end;
        if E is EnxBaseException then
          with EnxBaseException(E) do
            if OSError = 5 then
              if nxOSIsWindowsVistaOrBetter then begin
                CommandLine := '/'+csRUNAS+' "/' + csUSERNAME + ':' + lUserName + '" "/' + csPASSWORD + ':' + lPassword + '" ';
                for i := 1 to ParamCount do
                  CommandLine := CommandLine + '"' + ParamStr(i) + '" ';
                ShellExecute(0, 'runas', PChar(ParamStr(0)), PChar(CommandLine), PChar(GetCurrentDir), CmdShow);
                Exit;
              end;
        ShowException(E, ExceptAddr);
      end;
      Exit;
    end;
  end;

  if WasInstalled and nxIsService(lServiceName) then
    if nxFindCmdLineSwitch(csINSTALL) then
      if not nxFindCmdLineSwitch(csNOSTART) then
        if nxFindCmdLineSwitch(csSTART) { or
          ((not nxFindCmdLineSwitch(csSILENT) and
          (MessageDlg.ShowMessageForm( ntQuestion, rsDoYouWantToStartTheServiceNow ) = mrYes))) }
          then try
          nxStartService(lServiceName);
        except
          on e: exception do
            MessageDlg('Error ejecutando el servicio :' + e.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbok], 0);
        end;
end;
{==============================================================================}

{===ServiceController==========================================================}

procedure ServiceController(CtrlCode: DWORD); stdcall;
begin
  nxService.Controller(CtrlCode);
end;
{==============================================================================}

{===TnxService=================================================================}

procedure TWindowsService.CloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     CanClose := True;
end;
{------------------------------------------------------------------------------}
constructor TWindowsService.Create(aOwner: TComponent);
begin
     inherited;

     _ServiceStillBusy := ServiceStillBusy;
     WaitHint := 30000;

     fLogging := csServiceLogFilename <> '';
     svcEndSession := False;

     OnStop := ServiceStop;
     OnShutDown := ServiceShutdown;
     OnStart := ServiceStart;
     OnExecute := ServiceExecute;
end;
{------------------------------------------------------------------------------}

destructor TWindowsService.Destroy;
begin
  _ServiceStillBusy := nil;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TWindowsService.DoServiceDebugLoop;

var AForm: TForm;
begin
     AForm := TForm.CreateNew( nil );
     AForm.Caption := 'Esperando al debugger ...';
     AForm.show;
     Sleep( 15000 );
     AForm.Free;
end;
{------------------------------------------------------------------------------}

function TWindowsService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;
{------------------------------------------------------------------------------}

function TWindowsService.GetWndHook(var Message: TMessage): Boolean;
begin
  { windows has asked for the form to close as it is closing down }
  if Message.Msg = WM_QUERYENDSESSION then begin
    //!!!OutputDebugString('WM_QUERYENDSESSION');
    svcEndSession := True;
    Result := False;
  end else
    Result := True;
end;
{------------------------------------------------------------------------------}

procedure TWindowsService.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (aComponent = svcServerContainerModule) then
    svcServerContainerModule := nil;
end;
{------------------------------------------------------------------------------}
procedure TWindowsService.ServiceExecute(Sender: TService);
begin
     try
       While ServercontainerModule<>nil do
         begin
         ServiceThread.ProcessRequests( False );
         Sleep( 10 );
         end;
     except on E: Exception do
      LogMessage( E.Message );
      end
end;
{------------------------------------------------------------------------------}

procedure TWindowsService.ServiceShutdown( Sender : TService );

var  Stopped: Boolean;

begin
     ServiceStop( Sender, Stopped );
end;
{------------------------------------------------------------------------------}

procedure TWindowsService.ServiceStart(     Sender  : TService;
                                        var Started : Boolean);

var  Instance : TComponent;

begin
     svcDoReportStatus := True;
     svcReportStatusThreadHandle := GetCurrentThread;
     try

       svcServiceApp.saStarted := True;
       If    nxFindCmdLineSwitch( csDEBUG )
       then DoServiceDebugLoop;  // Activar para debugging del servicio

       Instance := TComponent( svcServerContainerClass.NewInstance );
       Instance.Create( Application );
       svcServerContainerModule := TBaseServerContainerModule( Instance );

       svcServerContainerModule.Setup( True );

       If   Assigned( svcServiceApp.OnAfterStartup )
       then svcServiceApp.OnAfterStartup( svcServiceApp );

       // LogMessage('Servicio iniciado', EVENTLOG_INFORMATION_TYPE);

     finally
       svcDoReportStatus := False;
       end;
end;
{------------------------------------------------------------------------------}

procedure TWindowsService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
     svcDoReportStatus := True;
     svcReportStatusThreadHandle := GetCurrentThread;
     try
       // LogMessage( 'Parando' );
       Stopped := True;
       FreeAndNil( svcServerContainerModule );
       // Application.Terminate;
       // LogMessage( 'Parado' );
       // LogMessage('Servicio detenido', EVENTLOG_INFORMATION_TYPE);
     finally
       svcDoReportStatus := False;
       end;
end;
{------------------------------------------------------------------------------}


class function TWindowsServiceApp.GetKnownParams: string;
begin
     Result := rsHelpText1 + rsHelpText2;
end;
{==============================================================================}

{==============================================================================}

function nxIsService(const aServiceName: string): Boolean;
var
  ServiceHandle: SC_HANDLE;
begin
  Result := True;
  try
    ServiceHandle := nxOpenService(aServiceName, True);
    if ServiceHandle = 0 then
      Result := False
    else
      CloseServiceHandle(ServiceHandle);
  except
    result := false;
    halt;
  end;
end;
{------------------------------------------------------------------------------}

function nxIsServiceRunning(const aServiceName: string): Boolean;
var
  ServiceHandle: SC_HANDLE;
  Status: TServiceStatus;
begin
  Result := False;
  ServiceHandle := nxOpenService(aServiceName, True);
  if ServiceHandle = 0 then
    Exit;
  try
    QueryServiceStatus(ServiceHandle, Status);
    Result := (Status.dwCurrentState = SERVICE_RUNNING);
  finally
    CloseServiceHandle(ServiceHandle);
  end;
end;
{------------------------------------------------------------------------------}

function nxIsServiceStarting(const aServiceName: string): Boolean;
begin
  result := nxRunningAsService;
end;
{------------------------------------------------------------------------------}

function nxOpenService(const aServiceName: string; QueryOnly: boolean = false): SC_HANDLE;
var
  ServiceManager: THandle;
begin
  if QueryOnly then
    ServiceManager := OpenSCManager(nil, nil,
      SC_MANAGER_CONNECT)
  else
    ServiceManager := OpenSCManager(nil, nil,
      SC_MANAGER_ALL_ACCESS);
  if ServiceManager = 0 then
    Result := 0
  else try
    if QueryOnly then
      Result := WinSvc.OpenService(ServiceManager,
        PChar(aServiceName), SERVICE_QUERY_STATUS)
    else
      Result := WinSvc.OpenService(ServiceManager,
        PChar(aServiceName), SERVICE_ALL_ACCESS);
  finally
    CloseServiceHandle(ServiceManager);
  end;
end;
{------------------------------------------------------------------------------}

function nxStartService(const aServiceName: string): Boolean;
var
  anError: Cardinal;
  ServiceHandle: SC_HANDLE;
  Args: PChar;
begin
  Result := False;
  ServiceHandle := nxOpenService(aServiceName);
  if ServiceHandle = 0 then
    Exit;
  try
    Args := nil; //..
    if not StartService(ServiceHandle, 0, Args ) then begin
      anError := GetLastError;
      raise Exception.Create(SysErrorMessage(anError));
    end;
    result := true;
  finally
    CloseServiceHandle(ServiceHandle);
  end;
end;
{------------------------------------------------------------------------------}
function nxGetServiceDisplayName(const aServiceName: string): string;
var
//  anError: Cardinal;
  ServiceHandle: SC_HANDLE;
//  Args: PChar;
  sConfig: Pointer;
  pConfig: PQueryServiceConfig;
  sNeeded: Cardinal;
begin
  Result := aServiceName;
  ServiceHandle := nxOpenService(aServiceName);
  if ServiceHandle = 0 then
    Exit;
  sConfig:=nil;
  try
    if QueryServiceConfig(ServiceHandle,sConfig,0,sNeeded) <> TRUE then
    begin
      if GetLastError = ERROR_INSUFFICIENT_BUFFER then
      begin
        //Get the memory required by using the Bytes needed var
        GetMem(sConfig,sNeeded);
        try
          if QueryServiceConfig(ServiceHandle,sConfig,sNeeded,sNeeded) then
          begin
          //Play with Config Info here
            pConfig := sConfig;
            result:= pConfig.lpDisplayName;
          end;
        finally
          freeMem(sConfig);
        end;
      end;
    end;
  finally
    CloseServiceHandle(ServiceHandle);
  end;
end;
{------------------------------------------------------------------------------}

function nxStopService(const aServiceName: string): Boolean;
var
  ServiceHandle: SC_HANDLE;
  Status: TServiceStatus;
begin
  Result := False;
  ServiceHandle := nxOpenService(aServiceName);
  if ServiceHandle = 0 then
    Exit;
  try
    result := ControlService(ServiceHandle, SERVICE_CONTROL_STOP, Status);
  finally
    CloseServiceHandle(ServiceHandle);
  end;
end;
{==============================================================================}

{==============================================================================}
var  _Service : TWindowsServiceApp;

function snxServiceApp: TWindowsServiceApp;
begin
  Result := _Service;
end;
{==============================================================================}

procedure TWindowsService.ServiceStillBusy;
begin
  if svcDoReportStatus and
    (svcReportStatusThreadHandle = GetCurrentThread) and
    (svcReportStatusLastTime < Now - 2/SecsPerDay) then begin
    svcReportStatusLastTime := Now;
    ReportStatus;
  end;
end;

procedure TWindowsService.ServiceAfterInstall(Sender: TService);

var  APath: string;
     AName: String;
     lDescription,
     lDisplayName : string;

begin
     snxServiceApp.WasInstalled := True;
     With TRegistry.Create( KEY_READ or KEY_WRITE ) do
       try
       RootKey := HKEY_LOCAL_MACHINE;
       If    OpenKey( 'SYSTEM\CurrentControlSet\Services\' + Sender.Name, True )
       then begin
            APath:=ReadString( 'ImagePath' ) + ' /ServiceName:' + Sender.Name;
            If   nxFindCmdLineParam( 'CONFIG', AName )
            then APath := APath + ' "/CONFIG:' + AName + '"';

            nxFindCmdLineParam( csDISPLAYNAME, lDisplayName );
            If   lDisplayName=''
            then lDisplayName := dfServiceDisplayName;
            WriteString( 'DisplayName', lDisplayName );

            nxFindCmdLineParam( csDESCRIPTION, ldescription );
            If   lDescription=''
            then lDescription := dfServiceDescription;
            WriteString( 'Description', lDescription );

            If   nxFindCmdLineSwitch( csALLOWSYSTEM ) or
                 nxFindCmdLineSwitch( csLOCALSYSTEMACCOUNT )
            then APath := APath + ' /' + csALLOWSYSTEM; //  + ' /DEBUG';   //*** DEBUG

            WriteString( 'ImagePath', APath );
            end;
       finally
         Free;
         end;
end;

function nxRunningAsService: Boolean;
var
  hAccessToken: tHandle;
  ptgGroups: pTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  int: integer; // counter
  blnResult: boolean; // return flag
const
  SECURITY_NT_AUTHORITY: SID_IDENTIFIER_AUTHORITY =
  (Value: (0, 0, 0, 0, 0, 5)); // ntifs
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
  DOMAIN_ALIAS_RID_USERS: DWORD = $00000221;
  DOMAIN_ALIAS_RID_GUESTS: DWORD = $00000222;
  DOMAIN_ALIAS_RID_POWER_: DWORD = $00000223;
  SECURITY_SERVICE_RID: DWORD = $00000006;
begin
  Result := False;
  ImpersonateSelf (SecurityImpersonation);
  blnResult := OpenThreadToken(GetCurrentThread, TOKEN_QUERY,
    True, hAccessToken);
  if (not blnResult) then begin

    if GetLastError = ERROR_NO_TOKEN then
      blnResult := OpenProcessToken(GetCurrentProcess,
        TOKEN_QUERY, hAccessToken);
  end;

  ptgGroups := nil;
  if (blnResult) then try
    if CurrentUserIsLocalSystem then begin
      // running as local system!
      result := true;
      exit;
    end;

    // we are not running as localsystem, thus we need to the check if we're
    // running as a service under a user account.
    // this can be checked by testing if we have a SECURITY_SERVICE_RID
    // in one of our current group SIDs
    GetMem(ptgGroups, 100);
    blnResult := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, 100, dwInfoBufferSize);
    if (not blnResult) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
    begin
      FreeMem(ptgGroups);
      GetMem(ptgGroups, dwInfoBufferSize);
      blnResult := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, dwInfoBufferSize, dwInfoBufferSize);
    end;

    if not blnResult then
      Check(GetLastError, 'GetTokenInformation Groups');

    if (blnResult) then begin
      if not AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 1,
        SECURITY_SERVICE_RID,
        0, 0, 0, 0, 0, 0, 0,
        psidAdministrators) then
        Check(GetLastError, 'AllocateAndInitializeSid');
      try
        {$R-}
        for int := 0 to ptgGroups.GroupCount - 1 do

          if EqualSid(psidAdministrators,
            ptgGroups.Groups[int].Sid) then begin
            Result := True;
            Break;
          end;
        {$R+}
      finally
        FreeSid(psidAdministrators);
      end;
    end;

  finally
    CloseHandle(hAccessToken);
    if ptgGroups <> nil then
      FreeMem(ptgGroups);
  end;
end;

initialization
    _Service := TWindowsServiceApp.Create;
finalization
    nxFreeAndNil( _Service );
end.

