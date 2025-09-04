
unit b_ccr;

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

  TBoxCcrForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    dataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    Label2: TcxLabel;
    LabelCtrl6: TcxLabel;
    LabelCtrl1: TcxLabel;
    LabelCtrl5: TcxLabel;
    UsuarioCtrl: TcxDBTextEdit;
    EmpresaCtrl: TcxDBTextEdit;
    DataCodigoEmpresa: TStringField;
    DataCodigoUsuario: TStringField;
    procedure FormManagerOkButton;
    procedure EmpresaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
  private
  protected
  class var
    OnSelected : TSimpleEvent;
  public
  end;

var  BoxCcrForm: TBoxCcrForm = nil;

procedure CopiaConfiguracionCorreo( OnSelected : TSimpleEvent );

implementation

{$R *.DFM}

uses  dm_emp,
      dm_usr,

      a_emp,
      a_usr,

      cx_emp,
      cx_usr;

procedure CopiaConfiguracionCorreo( OnSelected : TSimpleEvent );
begin
     TBoxCcrForm.OnSelected := OnSelected;
     CreateEditForm( TBoxCcrForm, BoxCcrForm, [] );
end;

procedure TBoxCcrForm.EmpresaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEmpresas( [ Sender.EditingValue ] );
end;

procedure TBoxCcrForm.EmpresaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEmpresas( Sender );
end;

procedure TBoxCcrForm.EmpresaCtrlPropertiesValidate( Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     With Sender do
       If   DisplayValue=''
       then Description := RsgCualquiera
       else Empresa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxCcrForm.FormManagerOkButton;
begin
     If   Assigned( OnSelected )
     then OnSelected;
end;

procedure TBoxCcrForm.UsuarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUsuarios( [ Sender.EditingValue ] );
end;

procedure TBoxCcrForm.UsuarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUsuarios( Sender );
end;

procedure TBoxCcrForm.UsuarioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With Sender do
       If   DisplayValue=''
       then Description := RsgCualquiera
       else Usuario.Valida( Sender, DisplayValue, ErrorText, Error );
end;

end.
