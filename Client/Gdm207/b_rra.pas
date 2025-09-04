
unit b_rra;

interface

uses AppForms, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Grids, Graphics,

     AppManager,
     AppContainer,
     Menus, cxLookAndFeelPainters, cxButtons, cxControls,
     cxContainer, cxEdit, cxTextEdit, cxDBEdit, DB, dxmdaset, DataManager,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, cxLabel,
  cxGroupBox, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxRadioGroup,
  cxCheckBox, cxCustomListBox, cxCheckListBox, cxDBCheckListBox;

type

  TBoxRraForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Data: TgxMemData;
    DataSource: TDataSource;
    Label2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    DataProceso: TSmallintField;
    ProcesoCtrl: TcxDBRadioGroup;
    cxLabel2: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    TodosCtrl: TcxDBCheckBox;
    DataTodos: TBooleanField;
    DataArticulos: TBooleanField;
    DataClientes: TBooleanField;
    DataExistencias: TBooleanField;
    ArticulosCtrl: TcxDBCheckBox;
    ExistenciasCtrl: TcxDBCheckBox;
    ClientesCtrl: TcxDBCheckBox;
    ClasesCtrl: TcxDBCheckBox;
    DataClases: TBooleanField;
    procedure FormManagerOkButton;
    procedure FormManagerInitializeForm;
    procedure TodosCtrlPropertiesChange(Sender: TObject);
    procedure ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
  private
    procedure ActualizaEstadoControles;
  protected
  class var
    OnSelected : TSimpleEvent;
  public
  end;

var  BoxRraForm: TBoxRraForm = nil;

procedure ModificaRegistroActualizacion;

implementation

{$R *.DFM}

uses   dm_rea207;

resourceString
    RsMsg1 = 'El proceso se ha realizado correctamente';

procedure ModificaRegistroActualizacion;
begin
     CreateEditForm( TBoxRraForm, BoxRraForm, [] );
end;

procedure TBoxRraForm.FormManagerInitializeForm;
begin
     DataProceso.Value := 0;
end;

procedure TBoxRraForm.FormManagerOkButton;
begin

     If   DataTodos.Value
     then RegistroActualizacionTienda.InvalidaRegistros( rgaGlobal, { Suprimir } DataProceso.Value=1 )
     else begin

          If   DataClases.Value
          then RegistroActualizacionTienda.InvalidaRegistros( rgaClase, { Suprimir } False );

          If   DataArticulos.Value
          then begin
               RegistroActualizacionTienda.InvalidaRegistros( rgaArticulo, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaVarianteArticulo, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaTarifaCliente, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaTarifaFamilia, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaStock, { Suprimir } DataProceso.Value=1 );
               end;

          If   DataClientes.Value
          then begin
               RegistroActualizacionTienda.InvalidaRegistros( rgaCliente, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaTarifaCliente, { Suprimir } DataProceso.Value=1 );
               RegistroActualizacionTienda.InvalidaRegistros( rgaTarifaFamilia, { Suprimir } DataProceso.Value=1 );
               end;

          If   DataExistencias.Value
          then RegistroActualizacionTienda.InvalidaRegistros( rgaStock, { Suprimir } DataProceso.Value=1 );

          end;

     ShowNotification( ntInformation, RsMsg1 );

end;

procedure TBoxRraForm.ProcesoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

procedure TBoxRraForm.TodosCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstadoControles;
end;

procedure TBoxRraForm.ActualizaEstadoControles;
begin
     ClasesCtrl.Enabled := ( ProcesoCtrl.ItemIndex=0 ) and not TodosCtrl.Checked;
     ArticulosCtrl.Enabled := not TodosCtrl.Checked;
     ExistenciasCtrl.Enabled := not TodosCtrl.Checked;
     ClientesCtrl.Enabled := not TodosCtrl.Checked;
end;

end.
