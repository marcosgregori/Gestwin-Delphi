unit a_cli;

interface

uses

  Forms, ComCtrls, StdCtrls, Buttons, Mask, Vcl.Dialogs,
  Controls, Classes, ExtCtrls, sysUtils,

  Menus, Spring, cxLookAndFeelPainters,
  cxButtons, DB, nxdb, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxPC, cxCheckBox,
  cxGraphics, cxMemo, cxCurrencyEdit, cxSpinEdit, cxIndexedComboBox,

  cxRichEdit, cxDBRichEdit, cxLabel, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxLookAndFeels, f_not,
  cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSplitter,
  cxScrollBox, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu, dxBar,
  dxDateRanges, dxScrollbarAnnotations, cxButtonEdit,

  AppForms,
  AppContainer,
  DataManager,
  GridTableViewController,

  Gim00Fields,
  Gim10Fields, dxUIAClasses;

type
  TMntCliForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    DataPanel: TgxEditPanel;
    ButtonsContainerPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ClienteTable: TnxeTable;
    ClienteDataSource: TDataSource;
    PageControl: TcxPageControl;
    DatosGeneralesTabSheet: TcxTabSheet;
    GeneralTopPanel: TcxGroupBox;
    GeneralBottomPanel: TcxGroupBox;
    SubcuentaCtrl: TcxDBTextEdit;
    Factura_MonedaCtrl: TcxDBIndexedComboBox;
    CodigoDivisaCtrl: TcxDBTextEdit;
    FechaAltaCtrl: TcxDBDateEdit;    
    NombreCtrl: TcxDBTextEdit;
    DomicilioCtrl: TcxDBTextEdit;
    LocalidadCtrl: TcxDBTextEdit;
    TelefonoCtrl: TcxDBTextEdit;
    FaxCtrl: TcxDBTextEdit;
    NIFCtrl: TcxDBTextEdit;
    PaisCtrl: TcxDBTextEdit;
    CodigoProvinciaCtrl: TcxDBTextEdit;
    CodigoPostalCtrl: TcxDBTextEdit;
    EMailCtrl: TcxDBTextEdit;
    EnviosTabSheet: TcxTabSheet;
    FacturacionTabSheet: TcxTabSheet;
    ModeloImpositivoPanel: TcxGroupBox;
    Factura_ModeloIVACtrl: TcxDBIndexedComboBox;
    Factura_TipoFijoIVACtrl: TcxDBSpinEdit;
    Factura_TipoRetCtrl: TcxDBSpinEdit;
    CobrosTabSheet: TcxTabSheet;
    Cobro_NombreCtrl: TcxDBTextEdit;
    Cobro_DomicilioCtrl: TcxDBTextEdit;
    Cobro_LocalidadCtrl: TcxDBTextEdit;
    Cobro_CodigoPostalCtrl: TcxDBTextEdit;
    Cobro_FormaCobroCtrl: TcxDBTextEdit;
    Cobro_EntidadCtrl: TcxDBTextEdit;
    Cobro_SucursalCtrl: TcxDBTextEdit;
    Cobro_CodigoProvCtrl: TcxDBTextEdit;
    Cobro_MesNoCobroCtrl: TcxDBIndexedComboBox;
    Cobro_DiaCobro1Ctrl: TcxDBSpinEdit;
    Cobro_DiaCobro2Ctrl: TcxDBSpinEdit;
    TabSheet5: TcxTabSheet;
    AvisosTabSheet: TcxTabSheet;
    Panel1: TcxGroupBox;
    BloqueadoCtrl: TcxDBCheckBox;
    MostrarAvisoCtrl: TcxDBCheckBox;
    AnnotationFrame1: TAnnotationFrame;
    codigoCtrlCaption: TcxLabel;
    Label27: TcxLabel;
    DescSubcuentaLabel: TcxLabel;
    Label25: TcxLabel;
    capCodigoDivisaLabel: TcxLabel;
    DescCodigoDivisaLabel: TcxLabel;
    Label42: TcxLabel;
    Label19: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    DescPaisLabel: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    NIFLabel: TcxLabel;
    ProvinciaCaptionLabel: TcxLabel;
    DescCPLabel: TcxLabel;
    Label13: TcxLabel;
    capTipoFijoLabel: TcxLabel;
    DescTipoFijoLabel: TcxLabel;
    capRetencionLabel: TcxLabel;
    DescRetencionLabel: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label18: TcxLabel;
    CobrosProvinciaCaptionLabel: TcxLabel;
    DescCPCobroLabel: TcxLabel;
    Label21: TcxLabel;
    DescFormaCobroLabel: TcxLabel;
    Label26: TcxLabel;
    Label28: TcxLabel;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    ObsoletoCtrl: TcxDBCheckBox;
    ContactosTabSheet: TcxTabSheet;
    DireccionContactoTable: TnxeTable;
    DireccionContactoData: TDataSource;
    DireccionContactoTableTipo: TSmallintField;
    DireccionContactoTableCodigo: TWideStringField;
    DireccionContactoTableNroRegistro: TSmallintField;
    DireccionContactoTableNombre: TWideStringField;
    DireccionContactoTableCargo: TWideStringField;
    DireccionContactoTableFijo: TWideStringField;
    DireccionContactoTableMovil: TWideStringField;
    DireccionContactoTableFax: TWideStringField;
    DireccionContactoTableCorreo: TWideStringField;
    ContactosGroupBox: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewNombre: TcxGridDBColumn;
    GridViewFijo: TcxGridDBColumn;
    GridViewMovil: TcxGridDBColumn;
    GridViewFax: TcxGridDBColumn;
    GridViewCorreo: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    cxGroupBox2: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxLabel2: TcxLabel;
    TAnnotationFrame1: TAnnotationFrame;
    cxSplitter1: TcxSplitter;
    DescNIF: TcxLabel;
    EnviarCorreoBtn: TgBitBtn;
    MandatoPanel: TcxGroupBox;
    IBANPanel: TcxGroupBox;
    CCCPanel: TcxGroupBox;
    Cobro_CodigoEntidadCtrl: TcxDBTextEdit;
    Cobro_CodigoSucursalCtrl: TcxDBTextEdit;
    Cobro_CuentaCtrl: TcxDBTextEdit;
    Cobro_DCCtrl: TcxDBTextEdit;
    Label29: TcxLabel;
    cxLabel3: TcxLabel;
    Cobro_CodigoINEPlazaCtrl: TcxDBTextEdit;
    Cobro_CtaEntidadCtrl: TcxDBTextEdit;
    Cobro_RiesgoLimiteCtrl: TcxDBCurrencyEdit;
    Label32: TcxLabel;
    Label33: TcxLabel;
    DescCanalLabel: TcxLabel;
    Label3: TcxLabel;
    Cobro_ReferenciaMandatoCtrl: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    Cobro_FechaMandatoCtrl: TcxDBDateEdit;
    cxLabel6: TcxLabel;
    Cobro_CicloMandatoCtrl: TcxDBIndexedComboBox;
    Cobro_IBANCtrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxLabel9: TcxLabel;
    Cobro_BICCtrl: TcxDBTextEdit;
    DCIBANCtrl: TcxTextEdit;
    TiendaVirtualCtrl: TcxDBCheckBox;
    TipoIdentificacionCtrl: TcxDBIndexedComboBox;
    DireccionContactoTableTipoDocumento: TSmallintField;
    GridViewTipoDocumento: TcxGridDBColumn;
    ReportFormsPopupMenu: TdxBarPopupMenu;
    BarManager: TdxBarManager;
    ImpresionMandatosItem: TdxBarButton;
    GeneralScrollBox: TcxScrollBox;
    EnviosScrollBox: TcxScrollBox;
    cxScrollBox1: TcxScrollBox;
    GridViewCargo: TcxGridDBColumn;
    DocumentosExternosButton: TgBitBtn;
    cxLabel8: TcxLabel;
    DocumentosExternosCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    TiendaVirtualPanel: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure PageControlChange(Sender: TObject);
    function FormManagerCopyCurrentRecord: Boolean;
    procedure ClienteTableBeforeDelete(DataSet: TDataSet);
    procedure ClienteTableNewRecord(DataSet: TDataSet);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CuentaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_TipoRetCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoRetCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoRetCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_CtaEntidadCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_FormaCobroCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_FormaCobroCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_DiaCobro1CtrlPropertiesChange(Sender: TObject);
    procedure Cobro_DiaCobro1CtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_CodigoINEPlazaCtrlPropertiesValidate(
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
    procedure CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure Cobro_CodigoPostalCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_CodigoPostalCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_CodigoPostalCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_CCCPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Cobro_DCCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Factura_TipoFijoIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Factura_ModeloIVACtrlPropertiesEditValueChange(
      Sender: TObject);
    procedure Factura_ModeloIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure NIFCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_MonedaCtrlPropertiesChange(Sender: TObject);
    procedure ClienteTableBeforePost(DataSet: TDataSet);
    procedure EMailCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Factura_MonedaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ClienteTableAfterEdit(DataSet: TDataSet);
    procedure SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FechaAltaCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Cobro_CtaEntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure Cobro_CodigoEntidadCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SubcuentaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ClienteTableUpdateState(DataSet: TDataSet);
    procedure DireccionContactoTableNewRecord(DataSet: TDataSet);
    procedure GridViewCorreoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EnviarCorreoBtnClick(Sender: TObject);
    procedure Cobro_CodigoEntidadCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_CodigoEntidadCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Cobro_FechaMandatoCtrlPropertiesValuePosted(Sender: TObject);
    procedure Cobro_FechaMandatoCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerReportFormRequest;
    procedure ImpresionMandatosItemClick(Sender: TObject);
    procedure Cobro_ReferenciaMandatoCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure Cobro_IBANCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Cobro_CodigoEntidadCtrlPropertiesValuePosted(Sender: TObject);
    procedure TiendaVirtualCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ClienteTableGetRecord(DataSet: TDataSet);
    procedure CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Cobro_CodigoProvCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure DocumentosExternosButtonClick(Sender: TObject);
    procedure ExaminarButtonClick(Sender: TObject);
    procedure DocumentosExternosCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure DireccionContactoTableApplyMasterRange(DataSet: TDataSet);
    procedure ClienteTableBeforeCancel(DataSet: TDataSet);
    procedure PaisCtrlPropertiesValuePosted(Sender: TObject);

  private

    FClienteFields,
    ClienteNIFFields : TClienteFields;

    DsPaisFields : TPaisFields;

    FOnClienteBeforePost : Event<TDataSetNotifyEvent>;

    ClienteIntracomunitario : Boolean;

    // Referencia los componentes de f_cli, si existen

    FEnvios_CodigoProvCtrl : TcxDBTextEdit;
    FEnvios_CodigoPostalCtrl : TcxDBTextEdit;

    function GetClienteFields : TClienteFields;
    procedure DoOnEntidadSelected( Target : TcxCustomEdit = nil );
  public

    procedure CompruebaDirecciones;
    procedure DoOnCopiaRegistro;

    property ClienteFields : TClienteFields read GetClienteFields;
    property Envios_CodigoProvCtrl : TcxDBTextEdit write FEnvios_CodigoProvCtrl;
    property Envios_CodigoPostalCtrl : TcxDBTextEdit write FEnvios_CodigoPostalCtrl;
    property OnClienteBeforePost : Event<TDataSetNotifyEvent> read FOnClienteBeforePost write FOnClienteBeforePost;
  end;

var MntCliForm: TMntCliForm = nil;

procedure MntClientes( KeyValues : array of const );
procedure MntClientesPorSubcuenta( CodigoCuenta : String );

implementation

{$R *.DFM}

uses   Windows,
       ShellAPI,
       Files,
       LibUtils,

       AppManager,
       Variants,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Frm,

       dmi_pga,
       dmi_iva,

       dm_ddc,
       dm_iva,
       dm_pai,
       dm_fco,
       dm_prv,
       dm_cdi,
       dm_sal,
       dm_cli,
       dm_pga,
       dm_enf,
       dm_ecc,
       dm_dco,

       dm_ban,

       b_msg,
       b_ccp,
       b_dir,
       dm_sub,
       dm_cop,

       a_iva,
       a_ret,
       a_sub,
       a_pai,
       a_prv,
       a_fco,
       a_cdi,
       a_cop,
       a_enf,

       // b_dir,
       bx_not,

       cx_cli,
       cx_iva,
       cx_ret,
       cx_sub,
       cx_pai,
       cx_prv,
       cx_cop,
       cx_fco,
       cx_cdi,
       cx_enf,

       l_cld,

       i_man;

resourceString
  RsMsg1  = 'La longitud del código I.N.E. es incorrecta.';
  RsMsg2  = 'Este código puede ser de 9 dígitos (con el formato PPMMMCCSS) o de 7 dígitos (sin código de provincia).';
  RsMsg3  = 'Si utiliza un código I.N.E. de 7 dígitos debe completar el codigo postal de la dirección de cobro.';
  RsMsg4  = 'Ya existe un cliente de código %s.';
  RsMsg5  = 'No existe ninguna ficha de cliente cuya subcuenta sea la %s.';
  RsMsg7  = 'Si cambia la subcuenta asignada a un cliente se perderá la relación con sus documentos contables (facturas, efectos a pagar, etc.. ).';
  RsMsg8  = '¿Esta seguro de que desea modificar la subcuenta?';
  RsMsg9  = 'El código IBAN no es correcto';
  RsMsg10 = 'El pais del código IBAN no es correcto|Compruebe el código IBAN o modifique el pais del cliente.';
  RsMsg11 = 'Ya existe un cliente con este N.I.F.';
  RsMsg12 = 'Se le ha asignado a %s, %s';
  RsMsg13 = 'Debe indicar el directorio de los documentos externos en la ficha del cliente.';
  //..
  RsMsg15 = 'Solo puede asignar este modelo impositivo a clientes intracomunitarios.';

procedure MntClientes( KeyValues : array of const );
begin
     CreateEditForm( TMntCliForm, MntCliForm, KeyValues, TGds10Frm.LibrosIVASection );
end;

procedure MntClientesPorSubcuenta( CodigoCuenta : String );

var  ClienteFields : TClienteFields;

begin
     try
       ClienteFields := TClienteFields.Create( nil );
       If   Cliente.ObtenPorSubcuenta( CodigoCuenta, ClienteFields )
       then MntClientes( [ ClienteFields.Codigo.Value ] )
       else ShowHintMsg( Format( RsMsg5, [ CodigoCuenta ] ), '' );
     finally
       ClienteFields.Free;
       end;
end;

procedure TMntCliForm.FormManagerInitializeForm;
begin

     ID := idMntCliForm;

     ClienteNIFFields := TClienteFields.Create( Self );

     DsPaisFields := TPaisFields.Create( Self );

     PinupAdjustableControl( PageControl, 325 );

     Factura_TipoRetCtrl.Enabled := DataModule00.DmEmpresaFields.Contable_Retenciones.Value;

     SetEditControlsDecimals( [ Cobro_RiesgoLimiteCtrl ] );

     // AnotacionCtrl.Properties.PlainText := ApplicationContainer.PlainTextAnotations;
     // AvisoCtrl.Properties.PlainText := ApplicationContainer.PlainTextAnotations;

     SetupPanelableCtrl( TiendaVirtualCtrl, DataModule00.TiendaVirtual );

     If   DataModule00.DmEmpresaFields.Contable_VentasOnlineIntracomunitarias.Value
     then Factura_ModeloIVACtrl.Properties.Items.Add( TextoModeloImpositivoCliente[ micVentasOnline  ] );

end;

procedure TMntCliForm.ClienteTableAfterEdit(DataSet: TDataSet);
begin
     With ClienteFields.FechaAlta do
       If   ValueIsEmpty( Value )
       then Value := ApplicationContainer.TodayDate;
end;

procedure TMntCliForm.ClienteTableBeforeCancel(DataSet: TDataSet);
begin
     If   ClienteTable.State=dsInsert
     then DireccionContactoTable.DeleteRecords;
end;

procedure TMntCliForm.ClienteTableBeforeDelete(DataSet: TDataSet);
begin
     Cliente.SuprimeReferencias( ClienteFields );
end;

procedure TMntCliForm.ClienteTableBeforePost(DataSet: TDataSet);
begin
     CompruebaDirecciones;
     FOnClienteBeforePost.Invoke( Dataset );
     ApplicationContainer.ProcessRecordChangesLog( ClienteTable, frdCliente );
end;

procedure TMntCliForm.ClienteTableGetRecord(DataSet: TDataSet);
begin
     {
     If  not DireccionContactoTable.Active
     then DireccionContactoTable.Open;
     If   Assigned( ClienteFields )
     then DireccionContactoTable.SetRange( [ Ord( tdcCliente ), ClienteFields.Codigo.Value ] );
     }
end;

procedure TMntCliForm.ClienteTableNewRecord(DataSet: TDataSet);
begin

     With ClienteFields do
       begin
       FechaAlta.Value := ApplicationContainer.TodayDate;
       CodigoPais.Value := CodigoEspaña;
       Factura_Moneda.Value := 0;
       Factura_ModeloIVA.Value := micSinRE;
       Factura_NroCopias.Value := 1;
       Factura_NroCopiasAlbaran.Value := 1;
       Cobro_MesNoCobro.Value := 0;
       end;

end;

procedure TMntCliForm.ClienteTableUpdateState(DataSet: TDataSet);
begin
     ObsoletoCtrl.Enabled := ClienteTable.State<>dsInsert;
     // Grid.Enabled := ClienteTable.State<>dsInsert;
end;

procedure TMntCliForm.Cobro_CodigoEntidadCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntEntidadesFinancieras( [ Sender.EditingValue, ClienteFields.Cobro_CodigoSucursal.Value ] );
end;

procedure TMntCliForm.Cobro_CodigoEntidadCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaEntidadesFinancieras( Sender, qgsNormal, DoOnEntidadSelected );
end;

procedure TMntCliForm.DoOnEntidadSelected;
begin
     With CxEnfForm do
       begin
       ClienteFields.Cobro_CodigoEntidad.Value := QueryCodigo.Value;
       ClienteFields.Cobro_CodigoSucursal.Value := QuerySucursal.Value;
       end;
end;

procedure TMntCliForm.Cobro_CodigoEntidadCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     EntidadFinanciera.Valida( Sender, DisplayValue, ErrorText, Error );
     DCIBANCtrl.EditValue := '';
     If   not Error
     then EntidadFinanciera.CompletaValidacion( DisplayValue, Cobro_CodigoEntidadCtrl, Cobro_CodigoSucursalCtrl, Cobro_CuentaCtrl, Cobro_DCCtrl );
end;

procedure TMntCliForm.Cobro_CodigoEntidadCtrlPropertiesValuePosted(Sender: TObject);
begin
     With ClienteFields do
       begin
       Cobro_CodigoSucursal.Clear;
       Cobro_DC.Clear;
       Cobro_Cuenta.Clear;
       end;
end;

procedure TMntCliForm.Cobro_CodigoINEPlazaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   Lc  : smallInt;
      INEStr : String;

begin
     With Cobro_CodigoINEPlazaCtrl do
       If   not ValueIsEmpty( DisplayValue )
       then begin
            INEStr := DisplayValue;
            Lc := System.Length( INEStr );
            If   ( Lc<>7 ) and ( Lc<>9 )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg1, RsMsg2 );
                 end
            else If   ( Lc=7 ) and ValueIsEmpty( ClienteFields.Cobro_CodigoProv.Value )
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg1, RsMsg3 );
                      end;
            end;
end;

procedure TMntCliForm.Cobro_CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ClienteFields do
       MntCodigosPostales( [ CodigoPais.Value, Cobro_CodigoProv.Value, Sender.EditingValue ] );
end;

procedure TMntCliForm.Cobro_CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With ClienteFields do
       ConsultaCodigosPostales( CodigoPais.Value, Cobro_CodigoProv.Value, Sender );
end;

procedure TMntCliForm.Cobro_CodigoPostalCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ClienteFields.CodigoPais.Value, ClienteFields.Cobro_CodigoProv.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.Cobro_CodigoProvCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Cobro_CodigoProvCtrl.Editing
     then Cobro_CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TMntCliForm.Cobro_CtaEntidadCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With Cobro_CtaEntidadCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '572';
end;

procedure TMntCliForm.Cobro_CtaEntidadCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.Cobro_DCCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     Banco.GeneraDC( ClienteFields.Cobro_CodigoEntidad.Value, Cobro_CodigoSucursalCtrl, Cobro_DCCtrl, Cobro_CuentaCtrl );
end;

procedure TMntCliForm.Cobro_CCCPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Banco.ValidaDC( DCIBANCtrl, Cobro_CodigoEntidadCtrl, Cobro_CodigoSucursalCtrl, Cobro_DCCtrl, Cobro_CuentaCtrl, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.Cobro_DiaCobro1CtrlPropertiesChange(Sender: TObject);
begin
     Cobro_DiaCobro2Ctrl.Enabled:= not ValueIsEmpty( Cobro_DiaCobro1Ctrl.Value );
end;

procedure TMntCliForm.Cobro_DiaCobro1CtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   Cobro_DiaCobro1Ctrl.Editing and ValueIsEmpty( DisplayValue, varSmallInt )
     then ClienteFields.Cobro_DiaCobro2.Value := 0;
end;

procedure TMntCliForm.Cobro_FechaMandatoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cobro_ReferenciaMandatoCtrl.Properties.Required := not ValueIsEmpty( DisplayValue );
     Cobro_ReferenciaMandatoCtrl.IsEditValidated := False;
end;

procedure TMntCliForm.Cobro_FechaMandatoCtrlPropertiesValuePosted(Sender: TObject);
begin
     ClienteFields.Cobro_CicloMandato.Value := cmPrimero;
end;

procedure TMntCliForm.Cobro_FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntCliForm.Cobro_FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntCliForm.Cobro_FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.Cobro_IBANCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                        var DisplayValue : Variant;
                                                        var ErrorText    : TCaption;
                                                        var Error        : Boolean );

var  IBAN : String;

begin
     //.. No compruebo el código del país porque las Empresas pueden tener cuentas en paises distintos al suyo
     IBAN := VarToStr( DisplayValue );
     If   IBAN<>''
     then If   not CompruebaDCIBAN( IBAN )
          then begin
               Error := True;
               ErrorText := RsMsg9;
               end;
end;

procedure TMntCliForm.Cobro_ReferenciaMandatoCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     With ClienteFields do
       Cobro_ReferenciaMandato.Value := Subcuenta.Value + '-' + StrFormatDate( Now );
     Cobro_ReferenciaMandatoCtrl.SelectAll;
end;

procedure TMntCliForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender, qgsLinked, True );
end;

procedure TMntCliForm.CodigoDivisaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosDivisa( [ Sender.EditingValue ] );
end;

procedure TMntCliForm.CodigoDivisaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosDivisa( Sender );
end;

procedure TMntCliForm.CodigoDivisaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Divisa.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.CodigoPostalCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With ClienteFields do
       MntCodigosPostales( [ CodigoPais.Value, CodigoProvincia.Value, Sender.EditingValue ] );
end;

procedure TMntCliForm.CodigoPostalCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With ClienteFields do
       ConsultaCodigosPostales( CodigoPais.Value, CodigoProvincia.Value, Sender );
end;

procedure TMntCliForm.CodigoPostalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CodigoPostal.Valida( ClienteFields.CodigoPais.Value, ClienteFields.CodigoProvincia.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.CodigoProvinciaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProvincias( [ ClienteFields.CodigoPais.Value, Sender.EditingValue ] );
end;

procedure TMntCliForm.CodigoProvinciaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   CodigoProvinciaCtrl.Editing
     then CodigoPostalCtrl.PostEditValue( '' );
end;

procedure TMntCliForm.CodigoProvinciaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProvincias( ClienteFields.CodigoPais.Value, Sender );
end;

procedure TMntCliForm.CodigoProvinciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Provincia.Valida( ClienteFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.FormManagerReportFormRequest;
begin
     ShowButtonMenu( ReportFormsPopupMenu, ApplicationContainer.FormReportButton );
end;

procedure TMntCliForm.FormManagerReportRequest;
begin
     ListadoClientesDeudores;
end;

procedure TMntCliForm.NIFCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Pais.ValidaNIF( ClienteFields.CodigoPais.Value, Sender, DisplayValue, ErrorText, Error );
     If   not Error and
          NIFCtrl.Editing and
          ( DisplayValue<>'' )
     then If   Cliente.ObtenPorNIF( DisplayValue, ClienteNIFFields ) and
               ( ClienteNIFFields.Codigo.Value<>ClienteFields.Codigo.Value )
          then ShowHintMsg( RsMsg11, Format( RsMsg12, [ ClienteNIFFields.Codigo.Value, ClienteNIFFields.Nombre.Value ] ) );
end;

function TMntCliForm.FormManagerGetAccessLevel: smallint;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV  
       then Result := acCAFicheros.Value
       else Result := CheckAccessLevel( [ acVEFicheros.Value, acVEClientes.Value ] );
end;

procedure TMntCliForm.CompruebaDirecciones;
begin
     If   ClienteTable.State=dsInsert
     then With ClienteFields do
            begin
            SetFieldValueIfEmpty( Envios_Nombre, Nombre.Value );
            SetFieldValueIfEmpty( Envios_Domicilio, Domicilio.Value );
            SetFieldValueIfEmpty( Envios_Localidad, Localidad.Value );
            SetFieldValueIfEmpty( Envios_CodigoProv, CodigoProvincia.Value );
            SetFieldValueIfEmpty( Envios_CodigoPostal, CodigoPostal.Value );
            SetFieldValueIfEmpty( Cobro_Nombre, Nombre.Value );
            SetFieldValueIfEmpty( Cobro_Domicilio, Domicilio.Value );
            SetFieldValueIfEmpty( Cobro_Localidad, Localidad.Value );
            SetFieldValueIfEmpty( Cobro_CodigoProv, CodigoProvincia.Value );
            SetFieldValueIfEmpty( Cobro_CodigoPostal, CodigoPostal.Value );
            end;
end;

function TMntCliForm.GetClienteFields : TClienteFields;
begin
     If   not Assigned( FClienteFields )
     then FClienteFields := TClienteFields.Create( ClienteTable );
     Result := FClienteFields;
end;

procedure TMntCliForm.GridViewCorreoPropertiesValidate(     Sender       : TcxCustomEdit;
                                                        var DisplayValue : Variant;
                                                        var ErrorText    : TCaption;
                                                        var Error        : Boolean );
begin
     DireccionCorreo.CompruebaEMail( DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.ImpresionMandatosItemClick(Sender: TObject);
begin
     ImpresionMandatos( ClienteFields.Codigo.Value );
end;

procedure TMntCliForm.PageControlChange(Sender: TObject);
begin
     If   PageControl.ActivePageIndex in [ 1, 3 ]
     then CompruebaDirecciones;
end;

procedure TMntCliForm.PaisCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntPaises( [ Sender.EditingValue ] );
end;

procedure TMntCliForm.PaisCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PaisCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := CodigoEspaña;
end;

procedure TMntCliForm.PaisCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaPaises( Sender );
end;

procedure TMntCliForm.PaisCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ClienteIntracomunitario := False;
     Pais.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error
     then begin
          Var CodigoPais := VarToStr( DisplayValue );

          CodigoPostal.SetupCPControl( CodigoPais,
                                       [ CodigoProvinciaCtrl, Cobro_CodigoProvCtrl, FEnvios_CodigoProvCtrl ],
                                       [ CodigoPostalCtrl, Cobro_CodigoPostalCtrl, FEnvios_CodigoPostalCtrl ] );

          var Español := CodigoPais=CodigoEspaña;
          TipoIdentificacionCtrl.Visible := not Español;
          If   Español
          then NIFLabel.Caption := 'N.I.F.'
          else NIFLabel.Caption := 'Doc. identificación';
          SetupPanelableCtrl( Cobro_CodigoEntidadCtrl, Español );
          SetupPanelableCtrl( Cobro_IBANCtrl, not Español );
          ClienteIntracomunitario := Pais.PaisFields.Intracomunitario.Value and not Español;
          If   ( ClienteFields.Factura_ModeloIVA.Value=micVentasOnline ) and not ClienteIntracomunitario
          then ClienteFields.Factura_ModeloIVA.Value := micSinRe;
          end;
end;

procedure TMntCliForm.PaisCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   ClienteFields.CodigoPais.Value<>CodigoEspaña
     then ClienteFields.Factura_ModeloIVA.Value := micExento;
end;

procedure TMntCliForm.SubcuentaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With SubcuentaCtrl do
       If   EditModified and Editing
       then If   ClienteTable.State=dsEdit
            then If   ShowNotification( ntQuestionWarning, RsMsg7, RsMsg8 )<>mrYes
                 then begin
                      With ClienteFields.Subcuenta do
                        Value := OldValue;
                      Refresh;
                      end;
end;

procedure TMntCliForm.SubcuentaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With SubcuentaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '4300' + ClienteFields.Codigo.Value;
end;

procedure TMntCliForm.TiendaVirtualCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     EMailCtrl.Properties.Required := TiendaVirtualCtrl.Checked;
end;

procedure TMntCliForm.CuentaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntCliForm.CuentaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender );
end;

procedure TMntCliForm.CuentaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With SubcuentaCtrl do
       If   EditModified and Editing
       then If   ( ClienteTable.State=dsInsert ) and not ValueIsEmpty( DisplayValue )
            then Cuenta.InsertaSubcuenta( DisplayValue, ClienteFields.Nombre.Value );
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.FechaAltaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FechaAltaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := ApplicationContainer.TodayDate;
end;

procedure TMntCliForm.Factura_ModeloIVACtrlPropertiesEditValueChange(Sender: TObject);
begin
     If   Factura_ModeloIVACtrl.Editing
     then With ClienteFields.Factura_TipoFijoIVA do
            If   ClienteFields.Factura_ModeloIVA.Value=micTipoFijo
            then begin
                 If   ValueIsEmpty( Value )
                 then Value := 1;
                 end
            else Value := 0;
end;

procedure TMntCliForm.Factura_ModeloIVACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Factura_TipoFijoIVACtrl.Enabled := Factura_ModeloIVACtrl.ItemIndex=micTipoFijo;
     If   ( Factura_ModeloIVACtrl.IsFocused ) and
          ( Factura_ModeloIVACtrl.ItemIndex=micVentasOnline ) and not ClienteIntracomunitario
     then begin
          ShowNotification( ntStop, RsMsg15 );
          Factura_ModeloIVACtrl.ItemIndex := micSinRe;
          end;
end;

procedure TMntCliForm.Factura_MonedaCtrlPropertiesChange(Sender: TObject);
begin
     If   Factura_MonedaCtrl.Editing
     then If   ClienteFields.Factura_Moneda.Value=0
          then ClienteFields.CodigoDivisa.Clear;
end;

procedure TMntCliForm.Factura_MonedaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With DataModule00.DmEmpresaFields do
       CodigoDivisaCtrl.Enabled := ( Contable_Divisas.Value or Ventas_Divisas.Value ) and ( Factura_MonedaCtrl.ItemIndex=1 );
end;

procedure TMntCliForm.Factura_TipoFijoIVACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntCliForm.Factura_TipoFijoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siRepercutido, ApplicationContainer.TodayDate, Cliente.ObtenCodigoPaisIVA( ClienteFields ) );
end;

procedure TMntCliForm.Factura_TipoFijoIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siRepercutido, ApplicationContainer.TodayDate, Cliente.ObtenCodigoPaisIVA( ClienteFields ) );
end;

procedure TMntCliForm.Factura_TipoRetCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRetenciones( True );
end;

procedure TMntCliForm.Factura_TipoRetCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( ApplicationContainer.TodayDate, Sender );
end;

procedure TMntCliForm.Factura_TipoRetCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( ApplicationContainer.TodayDate, Sender, DisplayValue, ErrorText, Error );
end;

function TMntCliForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaClienteProveedor( DoOnCopiaRegistro );
     Result := False;
end;

procedure TMntCliForm.DireccionContactoTableApplyMasterRange(DataSet: TDataSet);
begin
     If   DireccionContactoTable.Active
     then DireccionContactoTable.SetRange( [ Ord( tdpCliente ), ClienteFields.Codigo.Value ] );
end;

procedure TMntCliForm.DireccionContactoTableNewRecord(DataSet: TDataSet);
begin
     DireccionContactoTableTipo.Value := Ord( tdpCliente );  // Direcciones de clientes
     DireccionContactoTableCodigo.Value := CLienteFields.Codigo.Value;
end;

procedure TMntCliForm.DocumentosExternosButtonClick(Sender: TObject);
begin
     If   ClienteFields.DocumentosExternos.Value=''
     then ShowNotification( ntWarning, RsMsg13 )
     else OpenFolder( ClienteFields.DocumentosExternos.Value );
end;

procedure TMntCliForm.DocumentosExternosCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With DocumentosExternosCtrl do
       If   not ValueIsEmpty( DisplayValue )
       then If   not DirectoryExists( DisplayValue )
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsgMsg394, RsgMsg395 );
                 end;
end;

procedure TMntCliForm.DoOnCopiaRegistro;
begin
     With ClienteTable do
       begin
       If   FindKey( [ ClienteFields.Codigo.Value ] )
       then begin
            If   not Cliente.Obten( BoxCcpForm.DataCodigo.Value )
            then CloneRecord( [ BoxCcpForm.DataCodigo.Value ] )
            else ShowNotification( ntStop, Format( RsMsg4, [ boxCcpForm.DataCodigo.Value ] ), '' );
            end
       else ShowNotification( ntStop, rsgMsg430, '' );
       Cancel;
       end;
end;

procedure TMntCliForm.EMailCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   EMailCtrl.Editing
     then If   ValueIsEmpty( DisplayValue )
          then ClienteFields.Factura_EnviarPorCorreo.Value := False
          else DireccionCorreo.CompruebaEMail( DisplayValue, ErrorText, Error );
end;

procedure TMntCliForm.EnviarCorreoBtnClick(Sender: TObject);
begin
     DireccionCorreo.Redacta( ClienteFields.EMail.Value );
end;

procedure TMntCliForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( ClienteFields.DocumentosExternos );
end;

end.



