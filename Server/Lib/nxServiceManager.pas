
{$I ..\Lib\nxsrDefine.inc}

unit nxServiceManager;

{.$define WriteLog}

interface

uses
  ActiveX, // must be above Variants!!!
  ComObj,
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Messages,
  registry,
  WinSvc,
  SysUtils,
  Classes,
  nxllTypes,
  nxllFastFillChar,
  nxllMemoryManager,
  WindowsServiceManager,
  VCL.Controls,
  VCL.Forms,
  ShellAPI;

const

  dfServiceName : String = 'GestwinRPCServerV11';
  dfServiceDisplayName : String = 'Gestwin - Servidor de aplicaciones';
  dfServiceDescription : String = 'Ofrece servicios de base de datos y de conectividad a las aplicaciones cliente de GESTWIN.';

function OpenWindowsService( QueryOnly : Boolean = False ) : SC_HANDLE;

function IsWindowsServiceRunning : Boolean;
function StartWindowsService : Boolean;
function GetWindowsServiceDisplayName : String;
function StopWindowsService : Boolean;
function IsWindowsService : Boolean;
procedure UninstallWindowsService;

implementation

{%CLASSGROUP 'VCL.Types.TVCLObject'}

uses
  System.UITypes,
  VCL.Dialogs,
  MessageDialog,
  AppManager,
  nxllPlatformInterface,
  nxllUtils,
  nxllException,
  nxexeConst,
  nxllUserManagement;

var
  csServiceLogFilename: String;

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

function IsWindowsService : Boolean;

var  ServiceHandle: SC_HANDLE;

begin
     Result := True;
     try
       ServiceHandle := OpenWindowsService( True );
       If   ServiceHandle = 0
       then Result := False
       else CloseServiceHandle( ServiceHandle );
     except
       Result := False;
       Halt;
       end;
end;


function IsWindowsServiceRunning : Boolean;

var  ServiceHandle : SC_HANDLE;
     Status : TServiceStatus;

begin
     Result := False;
     ServiceHandle := OpenWindowsService( True );
     If   ServiceHandle = 0
     then Exit;
     try
       QueryServiceStatus( ServiceHandle, Status );
       Result := ( Status.dwCurrentState=SERVICE_RUNNING );
     finally
       CloseServiceHandle( ServiceHandle );
       end;
end;

function OpenWindowsService( QueryOnly : Boolean = False ) : SC_HANDLE;

var   ServiceManager: THandle;
const AccessArray : Array [ 0..1, 0..1 ] of Cardinal = ( ( SC_MANAGER_ALL_ACCESS, SERVICE_ALL_ACCESS ), ( SC_MANAGER_CONNECT, SERVICE_QUERY_STATUS ) );

begin
     ServiceManager := OpenSCManager( nil, nil, AccessArray[ Ord( QueryOnly ), 0 ] );
     If   ServiceManager=0
     then Result := 0
     else try
            Result := WinSvc.OpenService( ServiceManager, PChar( dfServiceName ), AccessArray[ Ord( QueryOnly ), 1 ] )
          finally
            CloseServiceHandle( ServiceManager );
            end;
end;

function StartWindowsService : Boolean;

var  ServiceHandle : SC_HANDLE;
     Args : PChar;

begin
     Result := False;
     ServiceHandle := OpenWindowsService;
     If   ServiceHandle=0
     then Exit;
     try
       Args := nil;
       If   not WinSvc.StartService( ServiceHandle, 0, Args )
       then RaiseLastOSError;
       Result := true;
     finally
       CloseServiceHandle( ServiceHandle );
       end;
end;

procedure UninstallWindowsService;

var ServiceHandle,
    Svc : SC_HANDLE;

begin
    ServiceHandle := OpenWindowsService;
    If   ServiceHandle=0
    then Exit;
    Svc := WinSvc.OpenService( ServiceHandle, PChar( dfServiceName ), SERVICE_ALL_ACCESS);
    If   Svc=0
    then RaiseLastOSError;
    try
      If   not DeleteService( Svc )
      then RaiseLastOSError;
    finally
      CloseServiceHandle( Svc );
      end;

end;

function GetWindowsServiceDisplayName : String;

var  ServiceHandle : SC_HANDLE;
     SConfig : Pointer;
     PConfig : PQueryServiceConfig;
     SNeeded : Cardinal;

begin
     Result := dfServiceName;
     ServiceHandle := OpenWindowsService;
     If   ServiceHandle=0
     then Exit;
     SConfig:=nil;
     try
       If   not QueryServiceConfig( ServiceHandle, SConfig, 0, SNeeded )
       then begin
            If   GetLastError=ERROR_INSUFFICIENT_BUFFER
            then begin
                 // Get the memory required by using the Bytes needed var
                 GetMem( SConfig, SNeeded );
                 try
                   If   QueryServiceConfig( ServiceHandle, SConfig, SNeeded, SNeeded )
                   then begin
                        // Play with Config Info here
                        PConfig := SConfig;
                        Result:= PConfig.lpDisplayName;
                        end;
                 finally
                   FreeMem( SConfig );
                   end;
                 end;
            end;
     finally
       CloseServiceHandle( ServiceHandle );
       end;

end;

function StopWindowsService : Boolean;

var  ServiceHandle : SC_HANDLE;
     Status : TServiceStatus;

begin
     Result := False;
     ServiceHandle := OpenWindowsService;
     If   ServiceHandle=0
     then Exit;
     try
       Result := ControlService( ServiceHandle, SERVICE_CONTROL_STOP, Status );
     finally
       CloseServiceHandle( ServiceHandle );
       end;

end;

end.

