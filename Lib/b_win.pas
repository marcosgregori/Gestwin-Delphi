
unit b_win;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,

  Menus,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxImage,
  dxGDIPlusClasses, AppForms, cxLabel, cxButtons, AppContainer, cxGroupBox,
  cxGeometry, dxFramedControl, dxPanel, dxUIAClasses, dxFormattedLabel;

type
  TInfoForm = class(TgxForm)
    Image3: TcxImage;
    gBitBtn1: TgBitBtn;
    CopyRightLabel: TcxLabel;
    cxGroupBox1: TdxPanel;
    cxGroupBox2: TdxPanel;
    Label4: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Image2: TcxImage;
    cxGroupBox3: TdxPanel;
    Shape4: TShape;
    AppNameLabel: TcxLabel;
    Image1: TcxImage;
    Shape1: TShape;
    DeclaracionLinkLabel: TdxFormattedLabel;
    procedure okButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gBitBtn1Click(Sender: TObject);
  private
    procedure createParams( var Params : TCreateParams ); override;
  public

  end;

var  InfoForm : TInfoForm = nil;

implementation

{$R *.dfm}

uses   DateUtils,

       AppManager;

resourceString
     RsMsg1 = '© 1989-%d WinStation, S.L.';

procedure TInfoForm.OkButtonClick(Sender: TObject);
begin
     Release;
end;

procedure TInfoForm.CreateParams( var Params : TCreateParams );
begin
  inherited CreateParams( Params );
  With Params do
    Style := WS_POPUP or WS_BORDER;
end;

procedure TInfoForm.FormShow(Sender: TObject);
begin
     AppNameLabel.Caption := AppShortName;
     CopyRightLabel.Caption := Format( RsMsg1, [ YearOf( Now ) ] );
end;

procedure TInfoForm.gBitBtn1Click(Sender: TObject);
begin
     Application.Terminate;
end;

end.
