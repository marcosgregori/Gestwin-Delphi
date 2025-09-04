
{$r ServerIcons.res}

unit Server;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ShellAPI,
  Menus,
  ExtCtrls;

const
  NXM_BASE                    = WM_USER + $1000;

  NXM_TI_CALLBACK             = NXM_BASE + 1;
  NXM_CONFIG                  = NXM_BASE + 2;
  NXM_INSTALL                 = NXM_BASE + 3;
  NXM_START                   = NXM_BASE + 4;
  NXM_STOP                    = NXM_BASE + 5;
  NXM_UNINSTALL               = NXM_BASE + 6;

type
  TServiceStatus = (ssUninitialized, ssStopped, ssStarted, ssNone);

  TServerForm = class(TForm)
    mnuTray: TPopupMenu;
    mniConfig: TMenuItem;
    N2: TMenuItem;
    mniExit: TMenuItem;
    tmrUpdate: TTimer;
    pnlStatus: TPanel;
    mniInstall: TMenuItem;
    mniStart: TMenuItem;
    mniStop: TMenuItem;
    N1: TMenuItem;
    tmrPopup: TTimer;
    N4: TMenuItem;
    mniServerName: TMenuItem;
    mniUninstall: TMenuItem;
    N7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniConfigClick(Sender: TObject);
    procedure mniInstallClick(Sender: TObject);
    procedure mniStartClick(Sender: TObject);
    procedure mniStopClick(Sender: TObject);
    procedure tmrPopupTimer(Sender: TObject);
    procedure mniUninstallClick(Sender: TObject);
    procedure mniStopServiceAndExitClick(Sender: TObject);
  private
    RunningAsService : Boolean;
    MSG_TaskbarRestart: integer;
    ServiceName: string;
    ServiceStatus: TServiceStatus;
    PopupPoint: TPoint;
    LastDoubleClick: TDateTime;
    ProgramStart: TDateTime;
    NotInstalledOnStart: Boolean;
    ServerActive : Boolean;

    procedure DisableAll;
    procedure HandleConfig(var Msg: TMessage); message NXM_CONFIG;
    procedure HandleInstall(var Msg: TMessage); message NXM_INSTALL;
    procedure HandleStart(var Msg: TMessage); message NXM_START;
    procedure HandleStop(var Msg: TMessage); message NXM_STOP;
    procedure HandleUninstall(var Msg: TMessage); message NXM_UNINSTALL;
    function AllowStop: Boolean;
  public

    tiNotifyData: TNotifyIconData;

    procedure tiCallBack(var Msg: TMessage); message NXM_TI_CALLBACK;
    function tiGetIconHandle: hIcon;
    procedure tiInitNotifyData;

    procedure WndProc(var Message: TMessage); override;

  end;

var ServerForm : TServerForm = nil;

implementation

{$R *.dfm}

uses
  Registry,
  {$IFDEF DCC16OrLater}
  UITypes,
  {$ENDIF}
  nxllMemoryManager,
  nxllUtils,
  nxexeConst,
  nxllFastFillChar,
  nxllConst,
  nxServiceApp,
  nxdmServer,

  WindowsServiceManager,
  ServerContainer,
  AppManager;

resourcestring
  cnxBrowserError = 'No se ha podido iniciar el navegador Web. Asegúrese de que está correctamente configurado en su sistema.';

{ TfrmServiceTrayIcon }

procedure TServerForm.DisableAll;
begin
     tmrUpdate.Enabled := False;
     mniInstall.Enabled := False;
     mniUninstall.Enabled := False;
     mniStart.Enabled := False;
     mniStop.Enabled := False;
end;

procedure TServerForm.FormCreate(Sender: TObject);

var  Reg : TRegistry;
     TheKey : string;

begin
     LastDoubleClick := Now;
     NotInstalledOnStart := True;
     ProgramStart := Now;
     ServiceName := DefaultServiceName;
     MSG_TaskbarRestart:=RegisterWindowMessage( 'TaskbarCreated' );
     tmrUpdateTimer( Sender );
     tiInitNotifyData;
     Shell_NotifyIcon( NIM_ADD, @tiNotifyData );
end;

procedure TServerForm.FormDestroy(Sender: TObject);
begin
     Shell_NotifyIcon(NIM_DELETE, @tiNotifyData);
end;

procedure TServerForm.HandleConfig( var Msg : TMessage );

var  Port : SmallInt;
     AFilename : string;
     AFile: TextFile;

begin
     DisableAll;
     try

       Port := dmServer.AdminWebServerServiceSettings.Port;
       If   Port=0
       then Port := 10088;

       If   ShellExecute( Handle, 'open', PChar('http://localhost:' + IntToStr( Port ) ), '', '', SW_SHOW )<= 32
       then ShowMessage( cnxBrowserError );

     finally
       tmrUpdate.Enabled := True;
       ServiceStatus := ssUninitialized;
       tmrUpdateTimer( Self );
     end;
end;


function RunAsAdmin(hWnd: HWND; filename: string; Parameters: string; Directory: string): Boolean;

var Sei : TShellExecuteInfo;

begin
    ZeroMemory(@Sei, SizeOf(Sei));
    Sei.cbSize := SizeOf(TShellExecuteInfo);
    Sei.Wnd := hwnd;
    Sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
    Sei.lpVerb := PChar('runas');
    Sei.lpFile := PChar(Filename); // PAnsiChar;
    If   Directory<>''
    then Sei.lpDirectory := PChar(Directory); // PAnsiChar;
    If   Parameters<>''
    then Sei.lpParameters := PChar(parameters); // PAnsiChar;
    Sei.nShow := SW_SHOWNORMAL; //Integer;

    Result := ShellExecuteEx( @Sei );
end;

procedure TServerForm.HandleInstall(var Msg: TMessage);

var ProgramFile: string;
    Params: string;
    DisplayName: String;

begin
     DisableAll;
     try
       ProgramFile := ParamStr( 0 );

       Params := '"/SERVICENAME:' + ServiceName + '" /INSTALL /LOCALSYSTEMACCOUNT';

       If   nxFindCmdLineParam( csDISPLAYNAME, DisplayName )
       then Params := Params + ' "/DISPLAYNAME:' + DisplayName + '"';

       RunAsAdmin( Handle, ProgramFile, Params, ExtractFilePath( ProgramFile ) );

     finally
       tmrUpdate.Enabled := True;
       ServiceStatus := ssUninitialized;
       tmrUpdateTimer(Self);
     end;
end;

procedure TServerForm.HandleStart( var Msg : TMessage );

var  ProgramFile: string;
     Params: string;

begin
     DisableAll;
     try
       ProgramFile := ParamStr(0);
       Params := '"/SERVICENAME:' + ServiceName + '" /START';
       ShellExecute( Handle, 'open', PChar( ProgramFile ), PChar( Params ), PChar( ExtractFilePath( ProgramFile ) ), SW_SHOW );
     finally
       tmrUpdate.Enabled := True;
       ServiceStatus := ssUninitialized;
       tmrUpdateTimer( Self );
     end;
end;

procedure TServerForm.HandleStop( var Msg : TMessage );

var  ProgramFile: string;
     Params: string;

begin
     DisableAll;
     try
       ProgramFile := ParamStr(0);
       Params := '"/SERVICENAME:' + ServiceName + '" /STOP';
       ShellExecute( Handle, 'open', PChar( ProgramFile ), PChar( Params ), PChar( ExtractFilePath( ProgramFile ) ), SW_SHOW );
     finally
       tmrUpdate.Enabled := True;
       ServiceStatus := ssUninitialized;
       tmrUpdateTimer(Self);
     end;
end;

procedure TServerForm.HandleUninstall(var Msg: TMessage);
var
  ProgramFile: string;
  Params: string;
begin
  DisableAll;
  try
    ProgramFile := ParamStr(0);
    Params := '"/SERVICENAME:'+ServiceName+'" /UNINSTALL "';
    ShellExecute( Handle, 'open', PChar(ProgramFile), PChar(Params), PChar(ExtractFilePath(ProgramFile)), SW_SHOW );
  finally
    tmrUpdate.Enabled := True;
    ServiceStatus := ssUninitialized;
    tmrUpdateTimer(Self);
  end;
end;

procedure TServerForm.mniConfigClick(Sender: TObject);
begin
  PostMessage(Handle, NXM_CONFIG, 0, 0);
end;

procedure TServerForm.mniExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TServerForm.mniInstallClick(Sender: TObject);
begin
     PostMessage(Handle, NXM_INSTALL, 0, 0);
end;

procedure TServerForm.mniStartClick(Sender: TObject);
begin
     PostMessage(Handle, NXM_START, 0, 0);
end;

function TServerForm.AllowStop : Boolean;
begin
     Result := MessageDlg( 'Detener el servicio de Gestwin desconectará a todos los usuarios y desactivará las aplicaciones que dependen de él.'#13'¿Continuar con la detención?', mtWarning, [mbOK, mbCancel], 0) = mrOK;
end;

procedure TServerForm.mniStopClick(Sender: TObject);
begin
     If   AllowStop
     then begin
          PostMessage( Handle, NXM_STOP, 0, 0 );
          Application.Terminate;
          end;
end;

procedure TServerForm.mniStopServiceAndExitClick(Sender: TObject);
begin
     If   AllowStop
     then begin
          PostMessage(Handle, NXM_STOP, 0, 0);
          Application.Terminate;
          end;
end;

procedure TServerForm.mniUninstallClick(Sender: TObject);
begin
     PostMessage(Handle, NXM_UNINSTALL, 0, 0);
end;

procedure TServerForm.tiCallBack(var Msg: TMessage);
begin
     with Msg do begin
       case LParam of
         WM_RBUTTONUP :
           begin
           GetCursorPos(PopupPoint);
           tmrPopup.Enabled := True;
           end;

         WM_LBUTTONUP:
           begin
           tmrPopup.Enabled := False;
           PostMessage(Handle, NXM_CONFIG, 0, 0);
           LastDoubleClick := Now;
           end;

         WM_LBUTTONDBLCLK:
           begin
           LastDoubleClick := Now;
           tmrPopup.Enabled := False;
           {
           If   not ServerActive
           then If   RunningAsService
                then
           }
           end;

       end;
     end;
end;

function TServerForm.tiGetIconHandle: hIcon;
begin
     Result:=0;

     ServerActive := False;

     If   RunningAsService
     then ServerActive := ServiceStatus=ssStarted
     else ServerActive := dmServer.Server.IsServerActive;

     If   ServerActive
     then Result := LoadIcon( HInstance, 'XICON_ACTIVE' )
     else Result := LoadIcon( HInstance, 'XICON_INACTIVE' );
end;

procedure TServerForm.tiInitNotifyData;
var
  Tip                         : string;
begin
  nxFillChar(tiNotifyData, SizeOf(tiNotifyData), 0);
  with tiNotifyData do begin
    cbSize := system.SizeOf(tiNotifyData);
    Wnd := Handle;
    uId := 1;
    uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;

    Tip := RsGestwin + ' ' + GetAppVersionString;
    StrLCopy( szTip, @Tip[1], Pred( System.SizeOf( szTip ) ) );

    uCallBackMessage := NXM_TI_CALLBACK;
    hIcon := tiGetIconHandle;
    Shell_NotifyIcon( NIM_MODIFY, @tiNotifyData )
  end;
  Caption := RsGestwin + ' ' + GetAppVersionString;
end;

procedure TServerForm.tmrPopupTimer(Sender: TObject);
begin
     tmrPopup.Enabled := False;
     SetForegroundWindow(Handle);
     mnuTray.Popup( PopupPoint.X, PopupPoint.Y );
     PostMessage( Handle, WM_NULL, 0, 0 );
end;

procedure TServerForm.tmrUpdateTimer(Sender: TObject);

var  NewServiceStatus : TServiceStatus;

begin
     RunningAsService := nxIsService( ServiceName );
     If   RunningAsService
     then If   nxIsServiceRunning(ServiceName)
          then NewServiceStatus := ssStarted
          else NewServiceStatus := ssStopped
     else NewServiceStatus := ssNone;

     If   ServiceStatus<>NewServiceStatus
     then begin
          ServiceStatus := NewServiceStatus;
          case ServiceStatus of
            ssNone: begin
              pnlStatus.Color := clRed;
              pnlStatus.Caption := 'Servicio no instalado';
              mniInstall.Visible := True;
              mniInstall.Enabled := True;
              mniInstall.Default := True;
              mniUninstall.Visible := False;
              mniUninstall.Enabled := False;
              mniStart.Visible := False;
              mniStart.Enabled := False;
              mniStop.Visible := False;
              mniStop.Enabled := False;
            end;
            ssStopped: begin
              pnlStatus.Color := clYellow;
              pnlStatus.Caption := 'Parado';
              mniInstall.Visible := False;
              mniInstall.Enabled := False;
              mniUninstall.Visible := True;
              mniUninstall.Enabled := True;
              mniStart.Visible := True;
              mniStart.Enabled := True;
              mniStart.Default := True;
              mniStop.Visible := True;
              mniStop.Enabled := False;
              NotInstalledOnStart := False;
            end;
            ssStarted: begin
              pnlStatus.Color := clGreen;
              pnlStatus.Caption := 'Iniciado';
              mniConfig.Default := True;
              mniInstall.Visible := False;
              mniInstall.Enabled := False;
              mniUninstall.Visible := False;
              mniUninstall.Enabled := False;
              mniStart.Visible := True;
              mniStart.Enabled := False;
              mniStop.Visible := True;
              mniStop.Enabled := True;
              NotInstalledOnStart := False;
            end;
          end;

     var ServerNameCaption := 'Servidor GESTWIN';
     If   RunningAsService
     then ServerNameCaption := ServerNameCaption + ' (Servicio)';
     mniServerName.Caption := ServerNameCaption;

     tiInitNotifyData;

  end;

  {
  if NotInstalledOnStart and (Now - ProgramStart > 1/24/60/20) then begin
    NotInstalledOnStart := False;
    if MessageDlg('El servicio no está instalado. ¿Desea instalar el servicio ahora?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      PostMessage(Handle, NXM_INSTALL, 0, 0);
  end;
  }
end;

procedure TServerForm.WndProc(var Message: TMessage);
begin
  inherited;
  if Message.Msg=Cardinal(MSG_TaskbarRestart) then begin
    tiInitNotifyData;
    Shell_NotifyIcon(NIM_ADD, @tiNotifyData);
  end;
end;

end.

