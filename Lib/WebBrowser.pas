
{$IMPORTEDDATA ON}

unit WebBrowser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ToolWin, ComCtrls, StdCtrls, ExtCtrls, AppForms,
  SHDocVw, OleCtrls, dxSkinsCore, dxSkinsdxBarPainter, dxBar, cxClasses,
  dxSkinsDefaultPainters;

type
  TWebForm = class(TgxForm)
    WebBrowser: TWebBrowser;
    BarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    CloseButton: TdxBarLargeButton;
    GoBackwardButton: TdxBarLargeButton;
    GoForwardButton: TdxBarLargeButton;
    RefreshButton: TdxBarLargeButton;
    StopButton: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    procedure FormDestroy(Sender: TObject);
    procedure GoBackwardButtonClick(Sender: TObject);
    procedure GoForwardBtnClick(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WebBrowserCommandStateChange(ASender: TObject;
      Command: Integer; Enable: WordBool);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowserDownloadBegin(Sender: TObject);
    procedure WebBrowserDownloadComplete(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
  private

    FBrowserReady : THandle;

  protected
  class var WindowCaption : String;

  public
   procedure CheckCompatibilityMode;

   property BrowserReady : THandle read FBrowserReady;
  end;

var WebForm: TWebForm = nil;
    HelpForm: TWebForm = nil;

procedure ShowWebPage( Page : String = ''; Title : String = ''; StandAlone : Boolean = False );
procedure ShowHelpPage( Page : String = ''; StandAlone : Boolean = False  );

implementation

{$R *.dfm}

uses   Registry,
       ComObj,
       AppContainer,
       LibUtils,

       
       AppManager,

       b_msg,
       b_pro;

resourceString
       RsMsg1   = 'Para poder acceder al soporte o a las ayudas de GESTWIN necesita tener instalado Internet Explorer 4.0 o posterior.';
       RsMsg2   = 'Instalelo y reintente la operación.';
       RsMsg3   = 'Ayuda';
       RsMsg4   = 'Web se soporte';

procedure CreateWebForm( var AWebForm   : TWebForm;
                             ACaption   : String;
                             APage      : String = '';
                             StandAlone : Boolean = False );
begin

     If   APage=''
     then APage := WebSoporte;

     If   Assigned( AWebForm )
     then AWebForm.BringToFront
     else try
            TWebForm.WindowCaption := ACaption;
            AWebForm := TWebForm.Create( Application.MainForm );
            If   StandAlone
            then AWebForm.FormStyle := fsNormal;
            AWebForm.Visible := True;   // No usar Show. No es virtual y no se puede redefinir en TgxForm
          except
            ShowNotification( ntInformation, RsMsg1, RsMsg2 );
            end;

     If   Assigned( AWebForm ) and ( APage<>'' )
     then AWebForm.WebBrowser.Navigate( APage );
end;

procedure ShowWebPage( Page       : String = '';
                       Title      : String = '';
                       StandAlone : Boolean = False );
begin
     CreateWebForm( WebForm, Title, Page, StandAlone );
     ApplicationContainer.WebFormActive := Assigned( WebForm );
end;

procedure ShowHelpPage( Page       : String = '';
                        StandAlone : Boolean = False );
begin
     CreateWebForm( HelpForm, RsMsg3, Page, StandAlone );
     ApplicationContainer.HelpFormActive := Assigned( HelpForm );
end;

// TWebForm

procedure TWebForm.GoBackwardButtonClick(Sender: TObject);
begin
     WebBrowser.GoBack;
end;

procedure TWebForm.GoForwardBtnClick(Sender: TObject);
begin
     WebBrowser.GoForward;
end;

procedure TWebForm.RefreshButtonClick(Sender: TObject);
begin
     WebBrowser.Refresh;
end;

procedure TWebForm.StopButtonClick(Sender: TObject);
begin
     WebBrowser.Stop;
end;

procedure TWebForm.WebBrowserCommandStateChange(ASender: TObject; Command: Integer; Enable: WordBool);
begin
     case Command of
       // CSC_UPDATECOMMANDS  : ;
       CSC_NAVIGATEFORWARD : GoForwardButton.Enabled  := Enable;
       CSC_NAVIGATEBACK    : GoBackwardButton.Enabled := Enable;
       end;
end;

procedure TWebForm.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
     SetEvent( FBrowserReady );
end;

procedure TWebForm.WebBrowserDownloadBegin(Sender: TObject);
begin
     StopButton.Enabled := True;
end;

procedure TWebForm.WebBrowserDownloadComplete(Sender: TObject);
begin
     StopButton.Enabled := False;
end;

procedure TWebForm.CloseButtonClick(Sender: TObject);
begin
     Release;
end;

procedure InitializeWebForm;
begin
     If   Assigned( Application.MainForm )
     then ApplicationContainer.OnShowWebForm := ShowWebPage;
end;

procedure TWebForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     If   Key=VK_ESCAPE
     then Release;
end;

procedure TWebForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
end;

procedure TWebForm.FormCreate(Sender: TObject);
begin
     FormType := fmBackground;
     Caption := WindowCaption;
end;

procedure TWebForm.FormDestroy(Sender: TObject);
begin
     If   WebForm=Self
     then begin
          ApplicationContainer.WebFormActive := False;
          WebForm := nil;
          end
     else If   HelpForm=Self
          then begin
               ApplicationContainer.HelpFormActive := False;
               HelpForm := nil;
               end;
end;

procedure TWebForm.CheckCompatibilityMode;

var  Reg: TRegistry;

begin
     Reg := TRegistry.Create;
     try
       // Reg.RootKey := HKEY_LOCAL_MACHINE;
       Reg.RootKey := HKEY_CURRENT_USER;
       Reg.Access := KEY_WRITE;
       If   Reg.OpenKey( 'Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\', True )
       then try
              If   not Reg.KeyExists( 'gd.exe')
              then Reg.WriteInteger( 'gd.exe', 11001 );
            finally
              Reg.CloseKey;
              end;
     finally
       Reg.Free;
       end;
end;

initialization
     AddProcedure( imStartup, 0, InitializeWebForm );

end.
