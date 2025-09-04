
unit b_crt;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, dxUIAClasses;

type

  TBoxCrtForm = class(TgxForm)
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

var  BoxCrtForm: TBoxCrtForm = nil;

procedure CopiaArticulo( OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

procedure CopiaArticulo( OnSelected : TSimpleEvent );
begin
     TBoxCrtForm.OnSelected := OnSelected;
     CreateEditForm( TBoxCrtForm, BoxCrtForm, [] );
end;

procedure TBoxCrtForm.FormManagerOkButton;
begin
     If   Assigned( OnSelected )
     then OnSelected;
end;

end.
