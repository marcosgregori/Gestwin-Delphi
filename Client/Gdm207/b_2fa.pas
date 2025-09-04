
unit b_2fa;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxRadioGroup;

type

  TBox2faForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    º: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    DataCodigoActivacion: TIntegerField;
    CodigoCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure gFormShow(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
  private
  protected
  public
  class var
    CodigoActivacion : String;
  end;

var  Box2faForm: TBox2faForm = nil;

function SolicitaCodigoActivacion : TModalResult;

implementation

{$R *.DFM}

uses  SysUtils;

function SolicitaCodigoActivacion : TModalResult;

var Box2faForm : TBox2faForm;

begin
     Result := mrNone;
     TBox2faForm.CodigoActivacion := '';
     Box2faForm := TBox2faForm.Create( Application.MainForm );
     With Box2faForm do
       try
         Result := ShowModal;
       finally
         Free;
         end;
end;

procedure TBox2faForm.CloseButtonClick(Sender: TObject);
begin
     ModalResult := mrCancel;
end;

procedure TBox2faForm.FormManagerInitializeForm;
begin
     //
end;

procedure TBox2faForm.FormManagerOkButton;
begin
     //
end;

procedure TBox2faForm.gFormShow(Sender: TObject);
begin
     //
end;

procedure TBox2faForm.OkButtonClick(Sender: TObject);
begin
     CodigoActivacion := IntToStr( DataCodigoActivacion.Value );
     ModalResult := mrOk;
end;

end.
