unit a_pro;

interface

uses Forms, ComCtrls, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, sysUtils,

  Variants,
  AppContainer,
  DataManager,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DB,
  nxdb,

  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, cxPC,
  cxGraphics, cxMaskEdit, cxDropDownEdit, cxIndexedComboBox, cxCheckBox,
  cxMemo, cxSpinEdit, cxCurrencyEdit,

  Gim10Fields, cxRichEdit, cxDBRichEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, f_not, cxLabel, cxGroupBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu, cxSplitter, dxDateRanges,

  AppForms,
  GridTableViewController, dxScrollbarAnnotations, dxUIAClasses;

type
  TmntProForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    DatosGeneralesTabSheet: TcxTabSheet;
    NombreCtrl: TcxDBTextEdit;
    SubcuentaCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    NIFCtrl: TcxDBTextEdit;
    EnviosTabSheet: TcxTabSheet;
    FacturacionTabSheet: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    CodigoDivisaCtrl: TcxDBTextEdit;
    ButtonsContainerPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    TabSheet5: TcxTabSheet;
    ProveedorTable: TnxeTable;
    ProveedorDataSource: TDataSource;
    Panel2: TcxGroupBox;
    Factura_ModeloIVACtrl: TcxDBIndexedComboBox;
    Factura_TipoFijoIVACtrl: TcxDBSpinEdit;
    Factura_TipoRetCtrl: TcxDBSpinEdit;
    Factura_CtaComprasCtrl: TcxDBTextEdit;
    EMailCtrl: TcxDBTextEdit;
    cxTabSheet1: TcxTabSheet;
    Panel1: TcxGroupBox;
    BloqueadoCtrl: TcxDBCheckBox;
    MostrarAvisoCtrl: TcxDBCheckBox;
    TAnnotationFrame1: TAnnotationFrame;
    AnnotationFrame1: TAnnotationFrame;
    codigoCtrlCaption: TcxLabel;
    Label19: TcxLabel;
    Label27: TcxLabel;
    DescSubcuentaLabel: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label9: TcxLabel;
    NIFLabel: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label2: TcxLabel;
    DescCPLabel: TcxLabel;
    capCodigoDivisaLabel: TcxLabel;
    DescCodigoDivisaLabel: TcxLabel;
    Label10: TcxLabel;
    Label13: TcxLabel;
    capTipoFijoLabel: TcxLabel;
    DescTipoFijoLabel: TcxLabel;
    capRetencionLabel: TcxLabel;
    DescRetencionLabel: TcxLabel;
    DesSubcuentaComprasLabel: TcxLabel;
    Label3: TcxLabel;
    DireccionContactoTable:TnxeTable;
    DireccionContactoTableTipo: TSmallintField;
    DireccionContactoTableCodigo: TWideStringField;
    DireccionContactoTableNroRegistro: TSmallintField;
    DireccionContactoTableNombre: TWideStringField;
    DireccionContactoTableCargo: TWideStringField;
    DireccionContactoTableFijo: TWideStringField;
    DireccionContactoTableMovil: TWideStringField;
    DireccionContactoTableFax: TWideStringField;
    DireccionContactoTableCorreo: TWideStringField;
    DireccionContactoData: TDataSource;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewNombre: TcxGridDBColumn;
    GridViewFijo: TcxGridDBColumn;
    GridViewMovil: TcxGridDBColumn;
    GridViewFax: TcxGridDBColumn;
    GridViewCorreo: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    cxGroupBox3: TcxGroupBox;
    cxLabel2: TcxLabel;
    DescNIF: TcxLabel;
    EnviarCorreoBtn: TgBitBtn;
    OrigenCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    RegimenEspecialCriterioCajaCtrl: TcxDBCheckBox;
    CCCPanel: TcxGroupBox;
    cxGroupBox4: TcxGroupBox;
    Pago_NombreCtrl: TcxDBTextEdit;
    Pago_DomicilioCtrl: TcxDBTextEdit;
    Pago_LocalidadCtrl: TcxDBTextEdit;
    Pago_FormaPagoCtrl: TcxDBTextEdit;
    Pago_DiaPago1Ctrl: TcxDBSpinEdit;
    Pago_DiaPago2Ctrl: TcxDBSpinEdit;
    Pago_MesNoPagoCtrl: TcxDBIndexedComboBox;
    Pago_EntidadCtrl: TcxDBTextEdit;
    Pago_SucursalCtrl: TcxDBTextEdit;
    Pago_CodigoPostalCtrl: TcxDBTextEdit;
    Pago_CodigoProvCtrl: TcxDBTextEdit;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    Label21: TcxLabel;
    DescFormaPagoLabel: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    Label26: TcxLabel;
    Label28: TcxLabel;
    Label20: TcxLabel;
    DescCPPagoLabel: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    Pago_CuentaCorrienteCtrl: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    Label29: TcxLabel;
    Pago_DCCtrl: TcxDBTextEdit;
    Pago_CodigoSucursalCtrl: TcxDBTextEdit;
    Pago_CodigoEntidadCtrl: TcxDBTextEdit;
    Pago_SubcuentaCtrl: TcxDBTextEdit;
    Label33: TcxLabel;
    DescCanalLabel: TcxLabel;
    IBANPanel: TcxGroupBox;
    Pago_IBANCtrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxLabel9: TcxLabel;
    Pago_BICCtrl: TcxDBTextEdit;
    DCIBANCtrl: TcxTextEdit;
    TipoIdentificacionCtrl: TcxDBIndexedComboBox;
    cxSplitter1: TcxSplitter;
    BloqueoPagosPanel: TcxGroupBox;
    Pago_BloqueadoCtrl: TcxDBCheckBox;
    Pago_MotivoBloqueoCtrl: TcxDBRichEdit;
    MotivoLabel: TcxLabel;
    ObsoletoCtrl: TcxDBCheckBox;
    cxLabel8: TcxLabel;
    DocumentosExternosCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DocumentosExternosButton: TgBitBtn;
    GridViewCargo: TcxGridDBColumn;
    DireccionContactoTableTipoDocumento: TSmallintField;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure ProveedorTableBeforeDelete(DataSet: TDataSet);
    procedure ProveedorTableNewRecord(DataSet: TDataSet);
    procedure ProveedorTableBeforePost(DataSet: TDataSet);
    procedure FormManagerInitializeForm;
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_ModeloIVACtrlPropertiesEditValueChange(
      Sender: TObject);
    procedure Factura_TipoFijoIVACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_TipoRetCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoRetCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SubcuentaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure OtraSubcuentaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_TipoFijoIVACtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Pago_FormaPagoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Pago_FormaPagoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Pago_FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Pago_DiaPago1CtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_ModeloIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProvinciaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_CtaComprasCtrlEnter(Sender: TObject);
    procedure Pago_DCCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Pago_CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure Envios_CodigoPostalCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Pago_CodigoPostalCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Pago_CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Envios_CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Pago_DiaPago1CtrlPropertiesChange(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure Factura_CtaComprasCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_TipoRetCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Pago_SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure SubcuentaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DireccionContactoTableNewRecord(DataSet: TDataSet);
    procedure EMailCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCorreoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EnviarCorreoBtnClick(Sender: TObject);
    procedure Pago_CodigoEntidadCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Pago_CodigoEntidadCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Pago_CodigoEntidadCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Pago_CCCPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure RegimenEspecialCriterioCajaCtrlPropertiesValuePosted(
      Sender: TObject);
    procedure RegimenEspecialCriterioCajaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Cobro_IBANCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Pago_CodigoEntidadCtrlPropertiesValuePosted(Sender: TObject);
    procedure Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Pago_CodigoProvCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DocumentosExternosCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure DocumentosExternosButtonClick(Sender: TObject);
    procedure DireccionContactoTableApplyMasterRange(DataSet: TDataSet);
    procedure ProveedorTableBeforeCancel(DataSet: TDataSet);

  private
    // Referencia los componentes de f_pro, si existe

    FEnvios_CodigoProvCtrl : TcxDBTextEdit;
    FEnvios_CodigoPostalCtrl : TcxDBTextEdit;

     procedure DoOnEntidadSelected( Target : TcxCustomEdit = nil );
  public

    ProveedorFields,
    ProveedorNIFFields : TProveedorFields;

    procedure CompruebaDirecciones;
    procedure DoOnCopiaRegistro;

    property Envios_CodigoProvCtrl : TcxDBTextEdit write FEnvios_CodigoProvCtrl;
    property Envios_CodigoPostalCtrl : TcxDBTextEdit write FEnvios_CodigoPostalCtrl;

  end;

var
  mntProForm: TmntProForm = nil;

procedure MntProveedores( keyValues : array of const );
procedure MntProveedoresPorSubcuenta( CodigoCuenta : String );

implementation

{$R *.DFM}

uses   WinAPI.Windows,
       Vcl.Clipbrd,

       Files,
       LibUtils,
       AppManager,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Frm,

       dmi_pga,
       dmi_iva,

       b_msg,
       b_dir,

       dmi_ast,
       dmi_fac,

       dm_ddc,
       dm_iva,
       dm_pga,
       dm_pai,
       dm_fpa,
       dm_prv,
       dm_cdi,
       dm_sal,
       dm_pro,
       dm_sub,
       dm_ban,
       dm_cop,
       dm_enf,
       dm_ast,
       dm_dco,

       a_iva,
       a_ret,
       a_sub,
       a_prv,
       a_fpa,
       a_pai,
       a_cdi,
       a_cop,
       a_enf,

       b_ccp,
       bx_not,

       cx_pro,
       cx_iva,
       cx_ret,
       cx_sub,
       cx_prv,
       cx_fpa,
       cx_pai,
       cx_cdi,
       cx_cop,
       cx_enf,

       l_pro;

resourceString
  RsMsg1  = 'Se han realizado movimientos con este proveedor.';
  RsMsg2  = 'Debe suprimir todas las referencias al mismo antes de darlo de baja.';
  RsMsg3  = 'Si cambia la subcuenta asignada a un proveedor se perderá la relación con sus documentos contables (facturas, efectos a pagar, etc.. ).';
  RsMsg4  = '¿Esta seguro de que desea modificar la subcuenta?';
  RsMsg5  = 'Ya existe un proveedor de código %s.';
  RsMsg6  = 'No existe ninguna ficha de proveedor cuya subcuenta sea la %s.';
  RsMsg7  = 'Ya existe un proveedor con este N.I.F.';
  RsMsg8  = 'Se le ha asignado a %s, %s';
  RsMsg9  = 'Debe introducir una dirección de correo válida.';
  RsMsg10 = 'El código IBAN no es correcto';
  RsMsg11 = 'El pais del código IBAN no es correcto|Compruebe el código IBAN o modifique el pais del proveedor.';
  //..
  RsMsg13 = 'Debe indicar el directorio de los documentos externos en la ficha del proveedor.';


procedure MntProveedores( keyValues : array of const );
begin
     CreateEditForm( TMntProForm, mntProForm, KeyValues, TGds10Frm.LibrosIVASection );
end;

procedure MntProveedoresPorSubcuenta( CodigoCuenta : String );

var  ProveedorFields : TProveedorFields;

begin
     ProveedorFields := TProveedorFields.Create( nil );
     try
       If   Proveedor.ObtenPorSubcuenta( CodigoCuenta, ProveedorFields )
       then MntProveedores( [ ProveedorFields.Codigo.Value ] )
       else ShowHintMsg( Format( RsMsg6, [ CodigoCuenta ] ), '' );
     finally
       ProveedorFields.Free;
       end;
end;

procedure TmntProForm.ProveedorTableBeforeCancel(DataSet: TDataSet);
begin
     If   ProveedorTable.State=dsInsert
     then DireccionContactoTable.DeleteRecords;
end;

procedure TmntProForm.ProveedorTableBeforeDelete(DataSet: TDataSet);
begin
     Proveedor.SuprimeReferencias( ProveedorFields );
end;

procedure TmntProForm.ProveedorTableBeforePost(DataSet: TDataSet);
begin
     CompruebaDirecciones;

     With ProveedorFields do
       If   Factura_ModeloIVA.Value<>mipNormal
       then Factura_RegimenEspecialCC.Value := False;

     ApplicationContainer.ProcessRecordChangesLog( ProveedorTable, frdProveedor );
end;

procedure TmntProForm.ProveedorTableNewRecord(DataSet: TDataSet);
begin
     With ProveedorFields do
       begin
       Factura_ModeloIVA.Value := mipNormal;
       Pago_MesNoPago.Value := 0;
       end;
end;

procedure TmntProForm.RegimenEspecialCriterioCajaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Factura_ModeloIVACtrl.Enabled := not RegimenEspecialCriterioCajaCtrl.Checked;
     OrigenCtrl.Enabled := not RegimenEspecialCriterioCajaCtrl.Checked;
end;

procedure TmntProForm.RegimenEspecialCriterioCajaCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   ProveedorFields.Factura_RegimenEspecialCC.Value
     then begin
          ProveedorFields.Factura_ModeloIVA.Value := mipNormal;
          ProveedorFields.Origen.Value := ofrSujetoPasivo;
          end;
end;

procedure TmntProForm.SubcuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TmntProForm.SubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     With SubcuentaCtrl do
       If   EditModified and Editing
       then If   ( ProveedorTable.State=dsInsert ) and not ValueIsEmpty( DisplayValue )
            then Cuenta.InsertaSubcuenta( DisplayValue, ProveedorFields.Nombre.Value );
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.FormManagerReportRequest;
begin
     ListadoProveedores;
end;

procedure TmntProForm.GridViewCorreoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     DireccionCorreo.CompruebaEMail( DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( ProveedorFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   not Error and
          NIFCtrl.Editing and
          ( DisplayValue<>'' )
     then If   Proveedor.ObtenPorNIF( DisplayValue, ProveedorNIFFields ) and
               ( ProveedorNIFFields.Codigo.Value<>ProveedorFields.Codigo.Value )
          then If   ( DataModule00.SuministroInmediatoInformacion and DataModule00.DmEmpresaFields.Contable_SII.Value )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg7, Format( RsMsg8, [ ProveedorNIFFields.Codigo.Value, ProveedorNIFFields.Nombre.Value ] ) );
                    end
               else ShowHintMsg( RsMsg7, Format( RsMsg8, [ ProveedorNIFFields.Codigo.Value, ProveedorNIFFields.Nombre.Value ] ) );
end;

function TmntProForm.FormManagerGetAccessLevel: SmallInt;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel(  [ acCOFicheros.Value, acCOProveedores.Value ] );
end;

procedure TmntProForm.FormManagerInitializeForm;
begin

     ID := idMntProForm;

     ProveedorFields := TProveedorFields.Create( ProveedorTable );

     ProveedorNIFFields := TProveedorFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin
       CodigoDivisaCtrl.Enabled := Contable_Divisas.Value or Compras_Divisas.Value;
       RegimenEspecialCriterioCajaCtrl.Enabled := not RegimenEspecialCriterioCaja.Value;
       end;

     BloqueoPagosPanel.Visible := ApplicationContainer.IsModuleActive( [ 118 ] ) and DataModule00.UserIsACreditManager;

end;

procedure TmntProForm.Cobro_IBANCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                        var DisplayValue : Variant;
                                                        var ErrorText    : TCaption;
                                                        var Error        : Boolean );
var  IBAN : String;

begin
     IBAN := VarToStr( DisplayValue );
     If   IBAN<>''
     then If   not CompruebaDCIBAN( IBAN )
          then begin
               Error := True;
               ErrorText := RsMsg10;
               end;
end;

procedure TmntProForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender, qgsLinked, True );
end;

procedure TmntProForm.CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosDivisa( [ Sender.EditingValue ] );
end;

procedure TmntProForm.CodigoDivisaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

procedure TmntProForm.CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ ProveedorFields.CodigoPais.Value, ProveedorFields.CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TmntProForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( ProveedorFields.CodigoPais.Value, ProveedorFields.CodigoProvincia.Value, Sender );
end;

procedure TmntProForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ProveedorFields.CodigoPais.Value, ProveedorFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ ProveedorFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TmntProForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TmntProForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( ProveedorFields.CodigoPais.Value, Sender );
end;

procedure TmntProForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( ProveedorFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );    
end;

procedure TMntProForm.CompruebaDirecciones;
begin
     If   ProveedorTable.State=dsInsert
     then With ProveedorFields do
            begin
            SetFieldValueIfEmpty( Envios_Nombre, Nombre.Value );
            SetFieldValueIfEmpty( Envios_domicilio, Domicilio.Value );
            SetFieldValueIfEmpty( Envios_Localidad, Localidad.Value );
            SetFieldValueIfEmpty( Envios_CodigoProv, CodigoProvincia.Value );
            SetFieldValueIfEmpty( Envios_CodigoPostal, CodigoPostal.Value );
            SetFieldValueIfEmpty( Pago_Nombre, Nombre.Value );
            SetFieldValueIfEmpty( Pago_Domicilio, Domicilio.Value );
            SetFieldValueIfEmpty( Pago_Localidad, Localidad.Value );
            SetFieldValueIfEmpty( Pago_CodigoProv, CodigoProvincia.Value );
            SetFieldValueIfEmpty( Pago_CodigoPostal, CodigoPostal.Value );
            end;
end;

procedure TmntProForm.PageControlChange(Sender: TObject);
begin
     If   PageControl.ActivePageIndex in [ 1, 3 ]
     then CompruebaDirecciones;
end;

procedure TmntProForm.Pago_CodigoEntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEntidadesFinancieras( [ Sender.EditingValue, ProveedorFields.Pago_CodigoSucursal.Value ] );
end;

procedure TmntProForm.Pago_CodigoEntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEntidadesFinancieras( Sender, qgsNormal, DoOnEntidadSelected );
end;

procedure TmntProForm.DoOnEntidadSelected;
begin
     With CxEnfForm do
       begin
       ProveedorFields.Pago_CodigoEntidad.Value := QueryCodigo.Value;
       ProveedorFields.Pago_CodigoSucursal.Value := QuerySucursal.Value;
       end;
end;

procedure TmntProForm.Pago_CodigoEntidadCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida(Sender, DisplayValue, ErrorText, Error );
     DCIBANCtrl.EditValue := '';
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Pago_CodigoEntidadCtrl, Pago_CodigoSucursalCtrl, Pago_CuentaCorrienteCtrl, Pago_DCCtrl );
end;

procedure TmntProForm.Pago_CodigoEntidadCtrlPropertiesValuePosted(Sender: TObject);
begin
     With ProveedorFields do
       begin
       Pago_CodigoSucursal.Clear;
       Pago_DC.Clear;
       Pago_CuentaCorriente.Clear;
       end;
end;

procedure TmntProForm.Pago_CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, Sender.EditingValue ] );
end;

procedure TmntProForm.Pago_CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, Sender );
end;

procedure TmntProForm.Pago_CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ProveedorFields.CodigoPais.Value, ProveedorFields.Pago_CodigoProv.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.Pago_CodigoProvCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Pago_CodigoProvCtrl.Editing
     then Pago_CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TmntProForm.Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Pago_MotivoBloqueoCtrl.Enabled := Pago_BloqueadoCtrl.Checked;
end;

procedure TmntProForm.Pago_CCCPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.ValidaDC( DCIBANCtrl, Pago_CodigoEntidadCtrl, Pago_CodigoSucursalCtrl, Pago_DCCtrl, Pago_CuentaCorrienteCtrl, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.Pago_DCCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     Banco.GeneraDC( ProveedorFields.Pago_CodigoEntidad.Value, Pago_CodigoSucursalCtrl, Pago_DCCtrl, Pago_CuentaCorrienteCtrl );
end;

procedure TmntProForm.Pago_DiaPago1CtrlPropertiesChange(Sender: TObject);
begin
     Pago_DiaPago2Ctrl.Enabled:= not ValueIsEmpty( Pago_DiaPago1Ctrl.Value );
end;

procedure TmntProForm.Pago_DiaPago1CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   Pago_DiaPago1Ctrl.Editing and ValueIsEmpty( DisplayValue, varSmallInt )
     then ProveedorFields.Pago_DiaPago2.Value := 0;
end;

procedure TmntProForm.Pago_FormaPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasPago( [ Sender.EditingValue ] );
end;

procedure TmntProForm.Pago_FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TmntProForm.Pago_FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.Pago_SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With Pago_SubcuentaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '572';
end;

procedure TmntProForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TmntProForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TmntProForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TmntProForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then begin
          Var CodigoPais := VarToStr( DisplayValue );
          CodigoPostal.SetupCPControl( CodigoPais,
                                       [ CodigoProvinciaCtrl, Pago_CodigoProvCtrl, FEnvios_CodigoProvCtrl ],
                                       [ CodigoPostalCtrl, Pago_CodigoPostalCtrl, FEnvios_CodigoPostalCtrl ] );
          var Español := CodigoPais=CodigoEspaña;
          TipoIdentificacionCtrl.Visible := not Español;
          If   Español
          then NIFLabel.Caption := 'N.I.F.'
          else NIFLabel.Caption := 'Doc. identificación';
          SetupPanelableCtrl( Pago_CodigoEntidadCtrl, Español );
          SetupPanelableCtrl( Pago_IBANCtrl, not Español );
          end;
end;

procedure TmntProForm.SubcuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TmntProForm.SubcuentaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With SubcuentaCtrl do
       If   EditModified and Editing
       then If   ProveedorTable.State=dsEdit
            then If   ShowNotification( ntQuestionWarning, RsMsg3, RsMsg4 )<>mrYes
                 then begin
                      With ProveedorFields.Codigo do
                        Value := OldValue;
                      Refresh;
                      end;
end;

procedure TmntProForm.SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '4000' + ProveedorFields.Codigo.Value;
end;

procedure TmntProForm.OtraSubcuentaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.Factura_CtaComprasCtrlEnter(Sender: TObject);
begin
     With Factura_CtaComprasCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '6';
end;

procedure TmntProForm.Factura_CtaComprasCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.Factura_ModeloIVACtrlPropertiesEditValueChange(Sender: TObject);
begin
     If   Factura_ModeloIVACtrl.Editing
     then With ProveedorFields.Factura_TipoFijoIVA do
            If   ProveedorFields.Factura_ModeloIVA.Value in [ mipTipoFijo, mipRegimenEspecial ]
            then begin
                 If   ValueIsEmpty( Value )
                 then Factura_TipoFijoIVACtrl.PostEditValue( 1 );
                 end
            else Factura_TipoFijoIVACtrl.PostEditValue( 0 );
end;

procedure TmntProForm.Factura_ModeloIVACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Factura_TipoFijoIVACtrl.Enabled := Factura_ModeloIVACtrl.ItemIndex in [ mipTipoFijo, mipRegimenEspecial ];
end;

procedure TmntProForm.Factura_TipoFijoIVACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TmntProForm.Factura_TipoFijoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siSoportado, ApplicationContainer.TodayDate );
end;

procedure TmntProForm.Factura_TipoFijoIVACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siSoportado, ApplicationContainer.TodayDate );
end;

procedure TmntProForm.Factura_TipoRetCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRetenciones( True );
end;

procedure TmntProForm.Factura_TipoRetCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( ApplicationContainer.TodayDate, Sender );
end;

procedure TmntProForm.Factura_TipoRetCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( ApplicationContainer.TodayDate, Sender, DisplayValue, ErrorText, Error );
end;

function TmntProForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaClienteProveedor( DoOnCopiaRegistro );
     Result := False;
end;

procedure TmntProForm.DireccionContactoTableApplyMasterRange(DataSet: TDataSet);
begin
     If   DireccionContactoTable.Active
     then DireccionContactoTable.SetRange( [ Ord( tdpProveedor ), ProveedorFields.Codigo.Value ] );
end;

procedure TmntProForm.DireccionContactoTableNewRecord(DataSet: TDataSet);
begin
     DireccionContactoTableTipo.Value := Ord( tdpProveedor );  // Direcciones de proveedores
     DireccionContactoTableCodigo.Value := ProveedorFields.Codigo.Value;
end;

procedure TmntProForm.DocumentosExternosButtonClick(Sender: TObject);
begin
     If   ProveedorFields.DocumentosExternos.Value=''
     then ShowNotification( ntWarning, RsMsg13 )
     else OpenFolder( ProveedorFields.DocumentosExternos.Value );
end;

procedure TmntProForm.DocumentosExternosCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With DocumentosExternosCtrl do
       If   not ValueIsEmpty( DisplayValue )
       then If   not DirectoryExists( DisplayValue )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                 end;
end;

procedure TmntProForm.DoOnCopiaRegistro;
begin
     With ProveedorTable do
       begin
       If   FindKey( [ ProveedorFields.Codigo.Value ] )
       then begin
            If   not Proveedor.Obten( BoxCcpForm.DataCodigo.Value )
            then CloneRecord( [ BoxCcpForm.DataCodigo.Value ] )
            else ShowNotification( ntStop, Format( RsMsg5, [ boxCcpForm.dataCodigo.Value ] ), '' );
            end
       else ShowNotification( ntStop, rsgMsg430, '' );
       Cancel;
       end;
end;
procedure TmntProForm.EMailCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EMailCtrl.Editing
     then If   not ValueIsEmpty( DisplayValue )
          then DireccionCorreo.CompruebaEMail( DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( ProveedorFields.EMail.Value );
end;

procedure TmntProForm.Envios_CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosPostales( [ ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender.EditingValue ] );
end;

procedure TmntProForm.Envios_CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosPostales( ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender );
end;

procedure TmntProForm.Envios_CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ProveedorFields.CodigoPais.Value, ProveedorFields.Envios_CodigoProv.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TmntProForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( ProveedorFields.DocumentosExternos );
end;

end.
