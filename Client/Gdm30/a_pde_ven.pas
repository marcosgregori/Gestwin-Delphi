
unit a_pde_ven;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, cxHeader, cxRadioGroup,
  dxUIAClasses, dxGDIPlusClasses, cxImage;

type
  TBoxPdeVenForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    Panel1: TgxEditPanel;
    PageControl: TcxPageControl;
    Vendedor_ComPorCliCtrl: TcxDBCheckBox;
    VentasTS: TcxTabSheet;
    Ventas_DecCantidadCtrl: TcxDBSpinEdit;
    Ventas_DecPrecioCtrl: TcxDBSpinEdit;
    Ventas_DecDtoCtrl: TcxDBSpinEdit;
    Ventas_DecCajasCtrl: TcxDBSpinEdit;
    Ventas_PagosPedidoCtrl: TcxDBCheckBox;
    Ventas_DtoPrevioCtrl: TcxDBCheckBox;
    Ventas_VerStockCtrl: TcxDBCheckBox;
    Ventas_NombreCajasCtrl: TcxDBTextEdit;
    Ventas_CalculoCtrl: TcxDBIndexedComboBox;
    Ventas_CantidadesCtrl: TcxDBIndexedComboBox;
    Ventas_SeriesPedidoCtrl: TcxDBCheckBox;
    Ventas_NrosSerieCtrl: TcxDBCheckBox;
    Ventas_AlmacenDefecCtrl: TcxDBTextEdit;
    Ventas_SerieDefectoCtrl: TcxDBTextEdit;
    Ventas_RiesgoPedidoCtrl: TcxDBCheckBox;
    Ventas_RiesgoAlbaranCtrl: TcxDBCheckBox;
    Ventas_ContMovCajaCtrl: TcxDBCheckBox;
    Ventas_CompCorrDocCtrl: TcxDBCheckBox;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    Ventas_RecargosCtrl: TcxDBCheckBox;
    Ventas_NombreRecargoCtrl: TcxDBTextEdit;
    Ventas_DecRecargoCtrl: TcxDBSpinEdit;
    Ventas_GestionMargPresupCtrl: TcxDBCheckBox;
    EmpresaTable: TnxeTable;
    DataSource: TDataSource;
    Ventas_CamposLibresCtrl: TcxDBCheckBox;
    Ventas_PreAutoVentaCtrl: TcxDBIndexedComboBox;
    Ventas_DivisasCtrl: TcxDBCheckBox;
    Ventas_DocumentosPaginadosCtrl: TcxDBCheckBox;
    CamposLibresVentasGroupBox: TcxGroupBox;
    Ventas_CampoLibre1Ctrl: TcxDBTextEdit;
    Ventas_CampoLibre2Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreObligatorio1Ctrl: TcxDBCheckBox;
    Ventas_CampoLibreObligatorio2Ctrl: TcxDBCheckBox;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    nombreCajasVentasLabel: TcxLabel;
    Label19: TcxLabel;
    Label30: TcxLabel;
    Label36: TcxLabel;
    Label37: TcxLabel;
    Label42: TcxLabel;
    Label43: TcxLabel;
    Label56: TcxLabel;
    Label57: TcxLabel;
    Label44: TcxLabel;
    Label27: TcxLabel;
    Label28: TcxLabel;
    Ventas_NombrePaginasCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel5: TcxLabel;
    Ventas_FormaEnvioCtrl: TcxDBCheckBox;
    Ventas_RegularizarPedidosServidosCtrl: TcxDBCheckBox;
	Ventas_DocumentosSinIVAIncluidoCtrl: TcxDBCheckBox;
    Ventas_FechaEntregaPorLineaCtrl: TcxDBCheckBox;
    Ventas_CampoLibre3Ctrl: TcxDBTextEdit;
    Ventas_CampoLibre4Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreObligatorio3Ctrl: TcxDBCheckBox;
    Ventas_CampoLibreObligatorio4Ctrl: TcxDBCheckBox;
    cxLabel58: TcxLabel;
    cxLabel59: TcxLabel;
    Ventas_CampoLibre5Ctrl: TcxDBTextEdit;
    cxDBCheckBox6: TcxDBCheckBox;
    cxLabel61: TcxLabel;
    Ventas_FechaCaducidadCtrl: TcxDBCheckBox;
    Ventas_MostrarLotesPedidoCtrl: TcxDBCheckBox;
    Ventas_CamposLibresLineasCtrl: TcxDBCheckBox;
    CamposLibresLineasVentasGroupBox: TcxGroupBox;
    Ventas_CampoLibreLineas1Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreLineas2Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreLineasOblig1Ctrl: TcxDBCheckBox;
    Ventas_CampoLibreLineasOblig2Ctrl: TcxDBCheckBox;
    cxLabel67: TcxLabel;
    cxLabel68: TcxLabel;
    Ventas_CampoLibreLineas3Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreLineas4Ctrl: TcxDBTextEdit;
    Ventas_CampoLibreLineasOblig3Ctrl: TcxDBCheckBox;
    Ventas_CampoLibreLineasOblig4Ctrl: TcxDBCheckBox;
    cxLabel69: TcxLabel;
    cxLabel70: TcxLabel;
    cxHeader1: TcxHeader;
    Ventas_CampoLibreLineasPos1Ctrl: TcxDBSpinEdit;
    Ventas_CampoLibreLineasPos2Ctrl: TcxDBSpinEdit;
    Ventas_CampoLibreLineasPos3Ctrl: TcxDBSpinEdit;
    Ventas_CampoLibreLineasPos4Ctrl: TcxDBSpinEdit;
    cxHeader2: TcxHeader;
    cxLabel71: TcxLabel;
    cxLabel72: TcxLabel;
    cxLabel73: TcxLabel;
    cxLabel74: TcxLabel;
    PedidosTS: TcxTabSheet;
    AlbaranesTS: TcxTabSheet;
    CamposLibresTS: TcxTabSheet;
    cxLabel4: TcxLabel;
    cxLabel2: TcxLabel;
    Operarios: TcxTabSheet;
    cxGroupBox8: TcxGroupBox;
    Ventas_CampoOperarios1Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios2Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios3Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios4Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios5Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios6Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios7Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios8Ctrl: TcxDBTextEdit;
    Label2: TcxLabel;
    Label3: TcxLabel;
    Label20: TcxLabel;
    Label21: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label25: TcxLabel;
    Ventas_CampoOperarios9Ctrl: TcxDBTextEdit;
    Ventas_CampoOperarios10Ctrl: TcxDBTextEdit;
    cxLabel34: TcxLabel;
    cxLabel35: TcxLabel;
    cxLabel38: TcxLabel;
    cxLabel39: TcxLabel;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    Ventas_NombreOperariosCtrl: TcxDBTextEdit;
    Ventas_OperariosCtrl: TcxDBCheckBox;
    Label47: TcxLabel;
    Ventas_MostrarDireccionOperariosCtrl: TcxDBCheckBox;
    cxLabel3: TcxLabel;
    GestionSubvencionesCtrl: TcxDBCheckBox;
    cxLabel6: TcxLabel;
    Ventas_CampoLibreLineas5Ctrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    Ventas_CampoLibreLineasOblig5Ctrl: TcxDBCheckBox;
    Ventas_CampoLibreLineasPos5Ctrl: TcxDBSpinEdit;
    Ventas_LotesObligatoriosCtrl: TcxDBCheckBox;
    Image1: TcxImage;
    Ventas_EntornoPruebasVerifactuCtrl: TcxDBCheckBox;
    Ventas_CampoLibreLineasCompCtrl: TcxDBCheckBox;
    cxLabel55: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    Ventas_EditarBultosAlbaranCtrl: TcxDBCheckBox;
    cxLabel8: TcxLabel;
    Ventas_NombreBultosCtrl: TcxDBTextEdit;
    Ventas_ContenedoresSonPalletsCtrl: TcxDBCheckBox;
    procedure Ventas_RecargosCtrlPropertiesChange(Sender: TObject);
    procedure Ventas_SerieDefectoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Ventas_SerieDefectoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Ventas_SerieDefectoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Ventas_NombreCajasCtrlEnter(Sender: TObject);
    procedure Ventas_CantidadesCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerOkButton;
    procedure FormManagerDestroyForm;
    procedure Ventas_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Ventas_DocumentosPaginadosCtrlPropertiesChange(
      Sender: TObject);
    procedure BultosCtrlPropertiesChange(Sender: TObject);
    procedure EmpresaTableBeforeOpen(DataSet: TDataSet);
    procedure Articulo_PreciosIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Ventas_CamposLibresLineasCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Ventas_AlmacenDefecCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Ventas_AlmacenDefecCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Ventas_AlmacenDefecCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Cliente_RegAuxiliarCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure Ventas_EditarBultosAlbaranCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EmpresaTableBeforePost(DataSet: TDataSet);
    procedure Ventas_EntornoPruebasVerifactuCtrlPropertiesValuePosted(
      Sender: TObject);
  private
    FEmpresaFields : TEmpresaFields;
    Trazabilidad,
    PartidasPresupuestarias : Boolean;
    FCampoOperarioCtrlArray : TcxCustomEditArray;
    function GetEmpresaFields : TEmpresaFields;
  protected
    procedure ActualizaEstado;
    class procedure ConfiguracionVentas( Sender : TObject);
  public
    property EmpresaFields : TEmpresaFields read GetEmpresaFields;
  end;

var
  BoxPdeVenForm: TBoxPdeVenForm = nil;

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

       cx_emp,
       cx_sdf,
       cx_alm;
       // cx_eqm;

resourceString
       RsMsg1  = 'Nombre [%s]';
       RsMsg4  = 'Cajas';
       RsMsg5  = 'Alto';

       RsNinguno  = '<Ninguno>';

procedure TBoxPdeVenForm.Cliente_RegAuxiliarCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Ventas_NombreOperariosCtrl.Enabled := Ventas_OperariosCtrl.Checked;
     For var CustomEdit in FCampoOperarioCtrlArray do
       CustomEdit.Enabled := Ventas_OperariosCtrl.Checked;
end;

class procedure TBoxPdeVenForm.ConfiguracionVentas( Sender : TObject);
begin
     CreateEditForm( TBoxPdeVenForm, BoxPdeVenForm, Gds00Frm.ConfigurationSection, True );
end;

procedure TBoxPdeVenForm.FormManagerInitializeForm;
begin

     CloseWindowWhenFocusLost := True;

     FCampoOperarioCtrlArray := GetCustomEditCtrlArray( Self, 'Ventas_CampoOperarios', 1, 10 );

     With EmpresaTable do
       If   FindKey( [ CodigoEmpresaActual ] )
       then Edit
       else Abort;

     Ventas_DocumentosPaginadosCtrl.Enabled := PartidasPresupuestarias;
     Ventas_FechaCaducidadCtrl.Enabled := Trazabilidad and EmpresaFields.Stock_LotesProductos.Value;;
     Ventas_MostrarLotesPedidoCtrl.Enabled := EmpresaFields.Stock_LotesProductos.Value;
     Ventas_LotesObligatoriosCtrl.Enabled := EmpresaFields.Stock_LotesProductos.Value;

end;

function TBoxPdeVenForm.GetEmpresaFields : TEmpresaFields;
begin
     If   not Assigned( FEmpresaFields )
     then FEmpresaFields := TEmpresaFields.Create( EmpresaTable );
     Result := FEmpresaFields;
end;

procedure TBoxPdeVenForm.ActualizaEstado;
begin
     SetGroupBoxControlsEnabled( CamposLibresLineasVentasGroupBox, Ventas_CamposLibresLineasCtrl.Checked, True );
     Ventas_CampoLibreLineasCompCtrl.Enabled := Ventas_CamposLibresLineasCtrl.Checked  and ( Ventas_CampoLibreLineas1Ctrl.EditValue<>'' );
end;

procedure TBoxPdeVenForm.EmpresaTableBeforeOpen(DataSet: TDataSet);
begin
     Trazabilidad := Configuracion.ModuloOpcionalActivado( moTrazabilidad );
     PartidasPresupuestarias := Configuracion.ModuloOpcionalActivado( moPartidasPresupuestarias );
end;

procedure TBoxPdeVenForm.EmpresaTableBeforePost(DataSet: TDataSet);
begin
     With EmpresaFields do
     If   EmpresaFields.Ventas_ContenedoresSonPallets.Value
     then EmpresaFields.Articulo_Pallets.Value := True;
end;

procedure TBoxPdeVenForm.FormManagerOkButton;
begin
     EmpresaTable.Post;
     DataModule00.DmEmpresaTable.GotoCurrent( EmpresaTable );
     FormManager.CloseWindow := True;
     Gds00Frm.ConfigurationSection.UpdateMainMenu;
end;

procedure TBoxPdeVenForm.Ventas_AlmacenDefecCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TBoxPdeVenForm.Ventas_AlmacenDefecCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBoxPdeVenForm.Ventas_AlmacenDefecCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, Errortext, Error );
end;

procedure TBoxPdeVenForm.Ventas_CamposLibresCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     SetGroupBoxControlsEnabled( CamposLibresVentasGroupBox, Ventas_CamposLibresCtrl.Checked, True );
end;

procedure TBoxPdeVenForm.Ventas_CamposLibresLineasCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TBoxPdeVenForm.Ventas_CantidadesCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With Ventas_CantidadesCtrl do
       begin
       case ItemIndex of
         0 : NombreCajasVentasLabel.Caption := Format( RsMsg1, [ RsMsg4 ] );
         1 : NombreCajasVentasLabel.Caption := Format( RsMsg1, [ '' ] );
         2 : NombreCajasVentasLabel.Caption := Format( RsMsg1, [ RsMsg5 ] );
         end;
       Ventas_NombreCajasCtrl.Enabled := EmpresaFields.Articulo_Cajas.Value or ( ItemIndex<>1 );
       Ventas_CalculoCtrl.ItemIndex := 0;
       Ventas_CalculoCtrl.Enabled := ItemIndex<>0;
       end;
end;

procedure TBoxPdeVenForm.Ventas_DocumentosPaginadosCtrlPropertiesChange(Sender: TObject);
begin
     Ventas_NombrePaginasCtrl.Enabled := Ventas_DocumentosPaginadosCtrl.Checked;
end;

procedure TBoxPdeVenForm.Ventas_EditarBultosAlbaranCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Ventas_NombreBultosCtrl.Enabled := Ventas_EditarBultosAlbaranCtrl.Checked;
     Ventas_ContenedoresSonPalletsCtrl.Enabled := Ventas_EditarBultosAlbaranCtrl.Checked;
end;

procedure TBoxPdeVenForm.Ventas_EntornoPruebasVerifactuCtrlPropertiesValuePosted(Sender: TObject);
begin
     //
end;

procedure TBoxPdeVenForm.Ventas_NombreCajasCtrlEnter(Sender: TObject);
begin
     With Ventas_NombreCajasCtrl do
       If   EditingValue=''
       then If   Ventas_CantidadesCtrl.ItemIndex=2
            then EmpresaFields.Ventas_NombreCajas.Value := RsMsg5
            else EmpresaFields.Ventas_NombreCajas.Value := RsMsg4;
end;

procedure TBoxPdeVenForm.Ventas_RecargosCtrlPropertiesChange(Sender: TObject);
begin
     Ventas_DecRecargoCtrl.Enabled := Ventas_RecargosCtrl.Checked;
     Ventas_NombreRecargoCtrl.Enabled := Ventas_RecargosCtrl.Checked;
end;

procedure TBoxPdeVenForm.Ventas_SerieDefectoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TBoxPdeVenForm.Ventas_SerieDefectoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxPdeVenForm.Ventas_SerieDefectoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxPdeVenForm.FormManagerDestroyForm;
begin
     EmpresaTable.Cancel;
end;

procedure TBoxPdeVenForm.Articulo_PreciosIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ventas_RecargosCtrl.Enabled := not EmpresaFields.Articulo_PreciosIVA.Value;
     Ventas_DocumentosSinIVAIncluidoCtrl.Enabled := EmpresaFields.Articulo_PreciosIVA.Value;
end;

procedure TBoxPdeVenForm.BultosCtrlPropertiesChange(Sender: TObject);
begin
     Ventas_EditarBultosAlbaranCtrl.Enabled := EmpresaFields.Articulo_Bultos.Value;
end;

procedure SetupUnit;
begin
     If   ProgramNumber in [ pnDesarrollo, pnTPV, pnComercial, pnContableComercial, pnPreventa ]
     then If   Assigned( Gds00Frm )
          then With Gds00Frm do
                 begin
                 ConfiguracionVentasItem.Visible := ivAlways;
                 ConfiguracionVentasItem.OnClick := TBoxPdeVenForm.ConfiguracionVentas;
                 end;
end;


initialization

     AddProcedure( imStartUp, 0, SetupUnit );
end.

