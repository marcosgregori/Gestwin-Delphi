
{$IMPORTEDDATA ON}

unit Web;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ToolWin, ComCtrls, StdCtrls, ExtCtrls,
  SHDocVw, OleCtrls, Vcl.ImgList;

type
  TWebForm = class(TForm)
    WebBrowser: TWebBrowser;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    GoBackwardButton: TToolButton;
    GoForwardButton: TToolButton;
    ToolButton4: TToolButton;
    StopButton: TToolButton;
    ImageList1: TImageList;
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
    procedure FormDestroy(Sender: TObject);
  private

  protected
  class var WindowCaption : String;

  public

  end;

var WebForm: TWebForm = nil;
    HelpForm: TWebForm = nil;

procedure ShowWebPage( Page : String = ''; Title : String = '' );
procedure ShowHelpPage( Page : String = '' );

implementation

{$R *.dfm}

uses   Registry,
       ComObj;

resourceString
       RsMsg1   = 'Para poder acceder al soporte o a las ayudas de GESTWIN necesita tener instalado Internet Explorer 4.0 o posterior.';
       RsMsg2   = 'Instalelo y reintente la operación.';
       RsMsg3   = 'Ayuda';
       RsMsg4   = 'Web se soporte';

procedure CreateWebForm( var AWebForm : TWebForm;
                             ACaption : String;
                             APage    : String = '' );
begin
     try
       TWebForm.WindowCaption := ACaption;
       AWebForm := TWebForm.Create( Application.MainForm );
       AWebForm.Show;
     except
       // ShowNotification( mbInformation, RsMsg1, RsMsg2 );
       end;

     If   Assigned( AWebForm ) and ( APage<>'' )
     then AWebForm.WebBrowser.Navigate( APage );
end;

procedure ShowWebPage( Page  : String = '';
                       Title : String = '' );
begin
     CreateWebForm( WebForm, Title, Page );
end;

procedure ShowHelpPage( Page : String = '' );
begin
     CreateWebForm( HelpForm, RsMsg3, Page );
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
     Caption := WindowCaption;
end;


procedure TWebForm.FormDestroy(Sender: TObject);
begin
     WebForm := nil;
end;

end.
