
unit a_pde_alm;

interface

uses

  Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, ComCtrls, Menus, DB,

  cxLookAndFeelPainters, cxButtons, cxTextEdit, cxDBEdit, cxContainer, cxEdit, cxCheckBox, cxPC, cxControls,
  cxGraphics, cxMaskEdit, cxDropDownEdit,cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxLookAndFeels, cxGroupBox, cxLabel, cxPCdxBarPopupMenu, cxSpinEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, dxmdaset, cxNavigator, dxBarBuiltInMenu, cxScrollBox, dxDateRanges,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxHeader, dxUIAClasses,

  nxDB,

  AppContainer,
  AppForms,
  DataManager,

  Gdm00Dm,
  Gim00Fields;

type
  TBoxPdeAlmForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    AlmacenTS: TcxTabSheet;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    Stock_LotesProductosCtrl: TcxDBCheckBox;
    Stock_TrazabilidadPorLotesCtrl: TcxDBCheckBox;
    Stock_IncluirPrecioComponentesCtrl: TcxDBCheckBox;
    Label45: TcxLabel;
    Stock_MultiAlmacenCtrl: TcxDBCheckBox;
    Stock_AltasFabricCtrl: TcxDBCheckBox;
    Stock_UbicacionesCtrl: TcxDBCheckBox;
    Stock_AlmacenDefectoCtrl: TcxDBTextEdit;
    Stock_AvisoCtrl: TcxDBCheckBox;
    Stock_ImpedirSSECtrl: TcxDBCheckBox;
    Stock_AvisoBajoMinimosCtrl: TcxDBCheckBox;
    Stock_ImpedirPendienteEnExcesoCtrl: TcxDBCheckBox;
    Label38: TcxLabel;
    Label39: TcxLabel;
    Ventas_TransportistaCtrl: TcxDBCheckBox;
    cxLabel4: TcxLabel;
    Stock_TiposLineaMovimientoCtrl: TcxDBCheckBox;
    Stock_OperariosCtrl: TcxDBCheckBox;
    LotesTS: TcxTabSheet;
    ListasMaterialesTS: TcxTabSheet;
    Stock_CosteEntradaPorLoteCtrl: TcxDBCheckBox;
    ReconstruirPeriodicamenteCtrl: TcxDBCheckBox;
    cxLabel1: TcxLabel;
    procedure Stock_AvisoCtrlPropertiesChange(Sender: TObject);
    procedure Stock_MultiAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Stock_LotesProductosCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EmpresaTableBeforeOpen(DataSet: TDataSet);
    procedure Stock_AlmacenDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Stock_AlmacenDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Stock_AlmacenDefectoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
  private
    FEmpresaFields : TEmpresaFields;
    Trazabilidad : Boolean;
    function GetEmpresaFields : TEmpresaFields;
  protected
    class procedure ConfiguracionAlmacen( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeAlmForm: TBoxPdeAlmForm = nil;

implementation

{$R *.DFM}

uses   SysUtils,
       DateUtils,
       LibUtils,

       dxBar,

       AppManager,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Frm,
       Gim30Fields,

       dmi_pga,

       dm_emp,
       dm_pga,
       dm_alm,
       dm_sdf,
       dm_cls,
       dm_reg,
       dm_iva,

       b_upd,
       b_msg,
       b_dir,

       a_alm,
       a_sdf,
       // a_eqm,

       cx_emp,
       cx_sdf,
       cx_alm;
       // cx_eqm;

class procedure TBoxPdeAlmForm.ConfiguracionAlmacen( Sender : TObject);
begin
     CreateEditForm( TBoxPdeAlmForm, BoxPdeAlmForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeAlmForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;
end;

function TBoxPdeAlmForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeAlmForm.EmpresaTableBeforeOpen(DataSet: TDataSet);
begin
     Trazabilidad := Configuracion.ModuloOpcionalActivado( moTrazabilidad );
end;

procedure TBoxPdeAlmForm.FormManagerOkButton;
begin
     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeAlmForm.Stock_AlmacenDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBoxPdeAlmForm.Stock_AlmacenDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxPdeAlmForm.Stock_AlmacenDefectoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, Errortext, Error );
end;

procedure TBoxPdeAlmForm.Stock_AvisoCtrlPropertiesChange(Sender: TObject);
begin
     Stock_ImpedirSSECtrl.Enabled := Stock_AvisoCtrl.Checked;
end;

procedure TBoxPdeAlmForm.Stock_MultiAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With Stock_UbicacionesCtrl do
       begin
       Enabled:= Stock_MultiAlmacenCtrl.Checked;
       If   not Enabled and EmpresaTable.Editing
       then EmpresaFields.Stock_Ubicaciones.Value := False;
       end;

     With Stock_AlmacenDefectoCtrl do
       begin
       Enabled:= Stock_MultiAlmacenCtrl.Checked;
       If   not Enabled and EmpresaTable.Editing
       then EmpresaFields.Stock_MultiAlmacen.Clear;
       end;
end;

procedure TBoxPdeAlmForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure TBoxPdeAlmForm.Stock_LotesProductosCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not Stock_LotesProductosCtrl.Checked
     then begin
          Stock_TrazabilidadPorLotesCtrl.Checked := False;
          Stock_CosteEntradaPorLoteCtrl.Checked := False;
          end;
     Stock_TrazabilidadPorLotesCtrl.Enabled := Stock_LotesProductosCtrl.Checked and Trazabilidad;
     Stock_CosteEntradaPorLoteCtrl.Enabled := Stock_LotesProductosCtrl.Checked;

end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnTPV, pnComercial, pnContableComercial, pnPrevision, pnPreventa, pnProduccion ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionAlmacenItem.Visible := ivAlways;
                 ConfiguracionAlmacenItem.OnClick := TBoxPdeAlmForm.ConfiguracionAlmacen;
                 end;
end;

initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

