unit Presentacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxControls, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters,
  cxLabel, cxCheckBox, StdCtrls, cxButtons, AppContainer, cxImage,
  dxGDIPlusClasses, ExtCtrls, cxTextEdit, cxHyperLinkEdit, dxUIAClasses,
  dxFormattedLabel;

type
  TPresentacionForm = class(TForm)
    CerrarButton: TgBitBtn;
    OcultarVentanaPresentacionCtrl: TcxCheckBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxImage1: TcxImage;
    Shape1: TShape;
    Shape2: TShape;
    dxFormattedLabel1: TdxFormattedLabel;
    dxFormattedLabel2: TdxFormattedLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PresentacionForm: TPresentacionForm = nil;

procedure MuestraVentanaPresentacion;

implementation

{$R *.dfm}

uses ShellAPI,
     

     Gdm00Dm,

     WebBrowser,
     dm_pga;

procedure MuestraVentanaPresentacion;
begin
     PresentacionForm := TPresentacionForm.Create( Application.MainForm );
     If   Assigned( PresentacionForm )
     then With PresentacionForm do
            try
               ShowModal;
            finally
              Free;
              end;
end;

procedure TPresentacionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     With Configuracion do
       begin
       ParametrosGlbRec.OcultarVentanaPresentacion := OcultarVentanaPresentacionCtrl.Checked;
       GuardaParametrosGlobales( ParametrosGlbRec );
       ActualizaParametros( True );
       end;
end;

end.
