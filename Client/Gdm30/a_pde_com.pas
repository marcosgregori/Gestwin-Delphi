
unit a_pde_com;

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

  nxdb,

  AppContainer,
  DataManager,

  Gdm00Dm,
  Gim00Fields, AppForms, GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxHeader;

type
  TBoxPdeComForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    ComprasTS: TcxTabSheet;
    Compras_DecCantidadCtrl: TcxDBSpinEdit;
    Compras_DecPrecioCtrl: TcxDBSpinEdit;
    Compras_DecDtoCtrl: TcxDBSpinEdit;
    Compras_DecCajasCtrl: TcxDBSpinEdit;
    Compras_EmitirFrasCtrl: TcxDBCheckBox;
    Compras_NombreCajasCtrl: TcxDBTextEdit;
    Compras_CalculoCtrl: TcxDBIndexedComboBox;
    Compras_CantidadesCtrl: TcxDBIndexedComboBox;
    Compras_VerStockCtrl: TcxDBCheckBox;
    Compras_ActTarifasCtrl: TcxDBCheckBox;
    Compras_NrosSerieCtrl: TcxDBCheckBox;
    Compras_DivisasCtrl: TcxDBCheckBox;
    Compras_AlmacenDefecCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    Compras_UtilizarPrecioOfertasCtrl: TcxDBCheckBox;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    nombreCajasComprasLabel: TcxLabel;
    metodoCalculoLabel: TcxLabel;
    Label32: TcxLabel;
    Label40: TcxLabel;
    Label41: TcxLabel;
    Label48: TcxLabel;
    Compras_CamposLibresCtrl: TcxDBCheckBox;
    CamposLibresComprasGroupBox: TcxGroupBox;
    Compras_CampoLibre1Ctrl: TcxDBTextEdit;
    Compras_CampoLibre2Ctrl: TcxDBTextEdit;
    Compras_CampoLibreObligatorio1Ctrl: TcxDBCheckBox;
    Compras_CampoLibreObligatorio2Ctrl: TcxDBCheckBox;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    Compras_OperariosCtrl: TcxDBCheckBox;
    Compras_FechaRecepcionPorLineaCtrl: TcxDBCheckBox;
    Compras_CampoLibre3Ctrl: TcxDBTextEdit;
    Compras_CampoLibre4Ctrl: TcxDBTextEdit;
    Compras_CampoLibreObligatorio3Ctrl: TcxDBCheckBox;
    Compras_CampoLibreObligatorio4Ctrl: TcxDBCheckBox;
    cxLabel56: TcxLabel;
    cxLabel57: TcxLabel;
    Compras_CampoLibre5Ctrl: TcxDBTextEdit;
    Compras_CampoLibreObligatorio5Cltr: TcxDBCheckBox;
    cxLabel60: TcxLabel;
    Compras_FechaCaducidadCtrl: TcxDBCheckBox;
    cxLabel54: TcxLabel;
    CamposLibresLineasComprasGroupBox: TcxGroupBox;
    Compras_CampoLibreLineas1Ctrl: TcxDBTextEdit;
    Compras_CampoLibreLineas2Ctrl: TcxDBTextEdit;
    Compras_CampoLibreLineasOblig1Ctrl: TcxDBCheckBox;
    Compras_CampoLibreLineasOblig2Ctrl: TcxDBCheckBox;
    cxLabel75: TcxLabel;
    cxLabel76: TcxLabel;
    Compras_CampoLibreLineas3Ctrl: TcxDBTextEdit;
    Compras_CampoLibreLineas4Ctrl: TcxDBTextEdit;
    Compras_CampoLibreLineasOblig3Ctrl: TcxDBCheckBox;
    Compras_CampoLibreLineasOblig4Ctrl: TcxDBCheckBox;
    cxLabel77: TcxLabel;
    cxLabel78: TcxLabel;
    cxHeader3: TcxHeader;
    Compras_CampoLibreLineasPos1Ctrl: TcxDBSpinEdit;
    Compras_CampoLibreLineasPos2Ctrl: TcxDBSpinEdit;
    Compras_CampoLibreLineasPos3Ctrl: TcxDBSpinEdit;
    Compras_CampoLibreLineasPos4Ctrl: TcxDBSpinEdit;
    cxLabel79: TcxLabel;
    cxLabel80: TcxLabel;
    cxLabel81: TcxLabel;
    cxLabel82: TcxLabel;
    Compras_CamposLibresLineasCtrl: TcxDBCheckBox;
    cxHeader4: TcxHeader;
    CamposLibresTS: TcxTabSheet;
    cxLabel1: TcxLabel;
    cxLabel4: TcxLabel;
    Compras_CampoLibreLineasPos5Ctrl: TcxDBSpinEdit;
    Compras_CampoLibreLineasOblig5Ctrl: TcxDBCheckBox;
    cxLabel7: TcxLabel;
    Compras_CampoLibreLineas5Ctrl: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    cxTabSheet1: TcxTabSheet;
    Compras_EditarBultosAlbaranCtrl: TcxDBCheckBox;
    cxLabel8: TcxLabel;
    Compras_NombreBultosCtrl: TcxDBTextEdit;
    procedure AlmacenCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure AlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure AlmacenCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Contable_DivisasCtrlPropertiesChange(Sender: TObject);
    procedure Compras_NombreCajasCtrlEnter(Sender: TObject);
    procedure Compras_CantidadesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure EmpresaTableBeforeOpen(DataSet: TDataSet);
    procedure Compras_CamposLibresLineasCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Compras_CamposLibresCtrlPropertiesEditValueChanged(
      Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    Trazabilidad,
    PartidasPresupuestarias,
    Envases,
    Exportacion : Boolean;
    function GetEmpresaFields : TEmpresaFields;
    procedure ActualizaEnvases;
  protected
    class procedure ConfiguracionCompras( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeComForm: TBoxPdeComForm = nil;

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

resourceString
       RsMsg1  = 'Nombre [%s]';
       RsMsg4  = 'Cajas';
       RsMsg5  = 'Alto';

class procedure TBoxPdeComForm.ConfiguracionCompras( Sender : TObject);
begin
     CreateEditForm( TBoxPdeComForm, BoxPdeComForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeComForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;

     Compras_FechaCaducidadCtrl.Enabled := Trazabilidad and EmpresaFields.Stock_LotesProductos.Value;
end;

function TBoxPdeComForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeComForm.Contable_DivisasCtrlPropertiesChange(Sender: TObject);
begin
     With Compras_DivisasCtrl do
       begin
       Enabled := EmpresaFields.Contable_Divisas.Value;
       If   not Enabled
       then Checked := False;
       end;
end;

procedure TBoxPdeComForm.EmpresaTableBeforeOpen(DataSet: TDataSet);
begin
     Trazabilidad := Configuracion.ModuloOpcionalActivado( moTrazabilidad );
     PartidasPresupuestarias := Configuracion.ModuloOpcionalActivado( moPartidasPresupuestarias );
     Envases := Configuracion.ModuloOpcionalActivado( moEnvases );
     Exportacion := Configuracion.ModuloOpcionalActivado( moExportacion );
end;

procedure TBoxPdeComForm.FormManagerOkButton;
begin
     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeComForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure TBoxPdeComForm.ActualizaEnvases;
begin

end;

procedure TBoxPdeComForm.AlmacenCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBoxPdeComForm.AlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxPdeComForm.AlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, Errortext, Error );
end;

procedure TBoxPdeComForm.Compras_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SetGroupBoxControlsEnabled( CamposLibresComprasGroupBox, Compras_CamposLibresCtrl.Checked, True );
end;

procedure TBoxPdeComForm.Compras_CamposLibresLineasCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SetGroupBoxControlsEnabled( CamposLibresLineasComprasGroupBox, Compras_CamposLibresLineasCtrl.Checked, True );
end;

procedure TBoxPdeComForm.Compras_CantidadesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With Compras_CantidadesCtrl do
       begin
       case ItemIndex of
         0  :  NombreCajasComprasLabel.Caption := Format( RsMsg1, [ RsMsg4 ] );
         1  :  NombreCajasComprasLabel.Caption := Format( RsMsg1, [ ''     ] );
         2  :  NombreCajasComprasLabel.Caption := Format( RsMsg1, [ RsMsg5 ] );
         end;
       Compras_NombreCajasCtrl.Enabled := EmpresaFields.Articulo_Cajas.Value and ( ItemIndex<>1 );
       Compras_CalculoCtrl.ItemIndex := 0;
       Compras_CalculoCtrl.Enabled := ItemIndex<>0;
       end;
end;

procedure TBoxPdeComForm.Compras_NombreCajasCtrlEnter(Sender: TObject);
begin
     If   Compras_NombreCajasCtrl.EditingValue=''
     then If   Compras_CantidadesCtrl.ItemIndex=2
          then EmpresaFields.Compras_NombreCajas.Value := RsMsg5
          else EmpresaFields.Compras_NombreCajas.Value := RsMsg4;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnComercial, pnContableComercial ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionComprasItem.Visible := ivAlways;
                 ConfiguracionComprasItem.OnClick := TBoxPdeComForm.ConfiguracionCompras;
                 end;
end;

initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

