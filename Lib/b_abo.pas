unit b_abo;

interface

uses
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  
  AppContainer,
  AppForms,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  cxGraphics,
  cxLookAndFeels, cxControls, cxContainer, cxEdit, dxSkinsCore,
  cxGroupBox, dxSkinsDefaultPainters, dxGDIPlusClasses, cxLabel, cxImage, Vcl.ComCtrls, cxListView, cxGeometry, dxFramedControl, dxPanel, cxCustomListBox, cxListBox,
  dxUIAClasses, dxFormattedLabel;

type
  TAboutForm = class(TgxForm)
    dxPanel3: TdxPanel;
    dxPanel1: TdxPanel;
    ExtensionesPanel: TdxPanel;
    Shape1: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Shape4: TShape;
    Label4: TcxLabel;
    InfoLabel: TcxLabel;
    VersionInfoLabel: TcxLabel;
    Label5: TcxLabel;
    AppImage: TcxImage;
    Image5: TcxImage;
    Image1: TcxImage;
    AppNameLabel: TcxLabel;
    SerialLabel: TcxLabel;
    demoLabel: TcxLabel;
    cxLabel1: TcxLabel;
    okButton: TgBitBtn;
    Image3: TcxImage;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label2: TcxLabel;
    CopyrightLabel: TcxLabel;
    ExtensionesCtrl: TcxListBox;
    BackgroundPanel: TdxPanel;
    DeclaracionPanel: TdxPanel;
    cxImage1: TcxImage;
    DeclaracionLinkLabel: TdxFormattedLabel;
    procedure OkButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DeclaracionLinkLabelPropertiesHyperlinkClick(Sender: TObject;
      AArgs: TdxHyperlinkClickEventArgs);
  private
  protected
    Interactive : Boolean;
  public
    constructor Create( OwnerForm : TForm; AInteractive : Boolean ); reintroduce;
    procedure ShowInfoMessage( AMessage : String = '' );
  end;

var  AboutForm : TAboutForm = nil;

implementation

{$R *.dfm}

uses  DateUtils,
      LibUtils,
      TextConvert,

      dxRichEdit.NativeApi,

      AppManager,
      WebBrowser;

resourceString
      RsMsg1 = 'Declaración responsable del sistema informático de facturación';

constructor TAboutForm.Create( OwnerForm    : TForm;
                               AInteractive : Boolean );

var FileDateTime: TDateTime;

begin

     inherited Create( OwnerForm );

     Interactive := AInteractive;

     // SetDefaultFont( AppNameLabel, 2 );

     AppNameLabel.Caption := AppShortName;
     CopyrightLabel.Caption := Format( RsCopyRight, [ YearOf( Now ) ] );

     FileAge( ApplicationPath + 'gd.exe', FileDateTime );
     VersionInfoLabel.Caption := 'Versión ' + IntToStr( YearOf( FileDateTime ) ) + '.' +  IntToStr( DateQuarter( FileDateTime ) ) + ' para WINDOWS';

     InfoLabel.Caption := GetAppInfoString + ' ' + ClientName;

     If   Interactive
     then Position := poMainFormCenter
     else Position := poScreenCenter;

    // Application.ProcessMessages;

end;

procedure TAboutForm.OkButtonClick(Sender: TObject);
begin
     // Release;
end;

procedure TAboutForm.FormDestroy(Sender: TObject);
begin
     AboutForm := nil;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
     OkButton.Visible := fsModal in FormState;
end;

procedure TAboutForm.DeclaracionLinkLabelPropertiesHyperlinkClick(Sender: TObject; AArgs: TdxHyperlinkClickEventArgs);
begin
     ShowWebPage( 'file://' + ApplicationPath + 'ServerData\Admin\declaracion_responsable.html', RsMsg1 );
     AArgs.Handled := True;
     ModalResult := mrOk;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin

     ExtensionesPanel.Visible := False;
     DeclaracionPanel.Visible := False;

     var FormHeight := ScaledTocurrent( 290 );

     If   Interactive
     then begin

          ExtensionesCtrl.Clear;

          {$IFDEF DEBUGAPP}
           ExtensionesCtrl.AddItem( 'Versión de debug.', nil );
          {$ELSE}
          For var IndiceModulo := moFacturaElectronica to moServidor64bits do
            If   ( IndiceModulo<>moReservado ) and IsOptionalModuleActive( ProtectionRec.OptionalModules, IndiceModulo )
            then ExtensionesCtrl.AddItem( NombreModuloOpcional[ IndiceModulo ], nil );
          {$ENDIF}

          DeclaracionPanel.Visible := True;
          Inc( FormHeight, DeclaracionPanel.Height );

          ExtensionesPanel.Visible := ExtensionesCtrl.Items.Count>0;
          If   ExtensionesPanel.Visible
          then Inc( FormHeight, ExtensionesPanel.Height );

          end;

     Height := FormHeight;

end;

procedure TAboutForm.ShowInfoMessage( AMessage : String = '' );
begin
     If   AMessage=''   // Toca actualizar la etiqueta de versión de evaluación
     then begin
          If   SpEvaluation
          then DemoLabel.Visible := True
          else SerialLabel.Caption := Format( RsgMsg101, [ SpRegNumber, SpServerConnections, SpSerialNumber ] );
          end
     else InfoLabel.Caption := AMessage;

     Application.ProcessMessages;
end;

initialization

end.


