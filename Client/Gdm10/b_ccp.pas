
unit b_ccp;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox,

  AppManager;

type

  TBoxCcpForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    DataCodigo: TWideStringField;
    Label2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    procedure FormManagerOkButton;
  private
  protected
  class var
    OnSelected : TSimpleEvent;
  public
  end;

var  BoxCcpForm: TBoxCcpForm = nil;

procedure CopiaClienteProveedor( OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

procedure CopiaClienteProveedor( OnSelected : TSimpleEvent );
begin
     TBoxCcpForm.OnSelected := OnSelected;
     CreateEditForm( TBoxCcpForm, BoxCcpForm, [] );
end;

procedure TBoxCcpForm.FormManagerOkButton;
begin
     If   Assigned( OnSelected )
     then OnSelected;
end;

end.
