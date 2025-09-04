
unit a_fdv;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, graphics,
  Classes, ExtCtrls, Forms, Tabs, ComCtrls,

  Libutils,
  AppContainer,
  Menus,
  cxLookAndFeelPainters,
  cxButtons,
  DataManager,
  Spring,
  cxPC, cxControls, DB, nxdb,

  cxContainer, cxEdit, cxLabel, cxDBLabel,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, cxCurrencyEdit,
  cxTextEdit, cxMemo, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCheckBox, cxSpinEdit, cxRichEdit, cxDBRichEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxmdaset, cxGroupBox, cxLookAndFeels,
  cxPCdxBarPopupMenu, cxScrollBox, cxNavigator, cxIntegerEdit,
  dxBarBuiltInMenu, cxIndexedComboBox, dxBar, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxSplitter, dxScrollbarAnnotations, dxGDIPlusClasses, cxImage, dxUIAClasses,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  AppForms,
  GridTableViewController,

  dm_mov,

  f_not;

type
  TMntFdvForm = class(TgxForm)
    ButtonsPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    NroFacturaCtrl: TcxDBIntegerEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    recibosButton: TgBitBtn;
    FacturaVentasTable: TnxeTable;
    FacturaVentasDataSource: TDataSource;
    EfectosQuery: TnxeQuery;
    EfectosDataSource: TDataSource;
    DataScrollBox: TcxScrollBox;
    PageControl: TcxPageControl;
    TabSheet2: TcxTabSheet;
    TabSheet1: TcxTabSheet;
    TopPanel: TcxGroupBox;
    EfectosPanel: TcxGroupBox;
    Panel1: TcxGroupBox;
    EfectosGrid: TcxGrid;
    EfectosGridView: TcxGridDBTableView;
    EfectosGridViewNroEfecto: TcxGridDBColumn;
    EfectosGridViewFechaVencimiento: TcxGridDBColumn;
    EfectosGridViewImporte: TcxGridDBColumn;
    EfectosGridViewFechaEmision: TcxGridDBColumn;
    EfectosGridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    AlbaranesPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    LineasAlbaranQuery: TnxeQuery;
    LineasAlbaranDataSource: TDataSource;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewUbicacion: TcxGridDBColumn;
    GridViewPrecioDivisa: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewRecargo: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    Panel5: TcxGroupBox;
    Forma_CobroCtrl: TcxDBTextEdit;
    DescuentoESCtrl: TcxDBCurrencyEdit;
    DescuentoPPCtrl: TcxDBCurrencyEdit;
    RecargoFinancieroCtrl: TcxDBCurrencyEdit;
    TotalACuentaCtrl: TcxDBCurrencyEdit;
    Panel6: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    FechaValorCtrl: TcxDBDateEdit;
    DesglosarAlbaranesCtrl: TcxCheckBox;
    EfectoCobrarTable: TnxeTable;
    EfectosGridViewFechaCobro: TcxGridDBColumn;
    EfectosGridViewImporteCobrado: TcxGridDBColumn;
    EfectosQueryNroEfecto: TSmallintField;
    EfectosQueryFechaVencimiento: TDateField;
    EfectosQueryImporte: TBCDField;
    EfectosQueryEmitido: TBooleanField;
    EfectosQueryFechaEmision: TDateField;
    EfectosQueryFechaCobro: TDateField;
    EfectosQueryImporteCobrado: TBCDField;
    EfectosQueryImpagado: TBooleanField;
    EfectosGridViewImpagado: TcxGridDBColumn;
    EfectoTable: TnxeTable;
    Panel7: TcxGroupBox;
    FiscalTS: TcxTabSheet;
    RetencionesPanel: TcxGroupBox;
    VendedorPanel: TcxGroupBox;
    TipoComisionCtrl: TcxDBCurrencyEdit;
    Codigo_VendedorCtrl: TcxDBTextEdit;
    Label2: TcxLabel;
    EstadoLabel: TcxLabel;
    TituloDocumentoLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Label25: TcxLabel;
    Label4: TcxLabel;
    Label26: TcxLabel;
    Label27: TcxLabel;
    Label36: TcxLabel;
    Label31: TcxLabel;
    Label37: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    Label24: TcxLabel;
    Label28: TcxLabel;
    descTipoRetencionLabel: TcxLabel;
    capTipoLabel: TcxLabel;
    ComisionCaptionLabel: TcxLabel;
    PorcentajeComisionLabel: TcxLabel;
    VendedorCaptionLabel: TcxLabel;
    Label22: TcxLabel;
    Label29: TcxLabel;
    ImporteEfectosLabel: TcxLabel;
    ImportePendienteLabel: TcxLabel;
    Label3: TcxLabel;
    DescClienteLabel: TcxLabel;
    GridViewNroDocumento: TcxGridDBColumn;
    GridViewNroPagina: TcxGridDBColumn;
    GridViewEjercicio: TcxGridDBColumn;
    LineasAlbaranQueryEjercicio: TSmallintField;
    LineasAlbaranQuerySerie: TWideStringField;
    LineasAlbaranQueryNroDocumento: TIntegerField;
    LineasAlbaranQueryFecha: TDateField;
    LineasAlbaranQueryEntregaACuenta: TBCDField;
    LineasAlbaranQueryNroPagina: TSmallintField;
    LineasAlbaranQueryCodigoArticulo: TWideStringField;
    LineasAlbaranQueryCodigoClaseA: TWideStringField;
    LineasAlbaranQueryCodigoClaseB: TWideStringField;
    pp: TWideStringField;
    LineasAlbaranQueryLoteFabricacion: TWideStringField;
    LineasAlbaranQueryNumeroSerie: TWideStringField;
    LineasAlbaranQueryDescripcion: TWideStringField;
    LineasAlbaranQueryCodigoAlmacen: TWideStringField;
    LineasAlbaranQueryUbicacion: TWideStringField;
    LineasAlbaranQueryCantidad: TBCDField;
    p: TBCDField;
    LineasAlbaranQueryRecargo: TBCDField;
    LineasAlbaranQueryPuntoVerde: TBCDField;
    LineasAlbaranQueryDescuento: TBCDField;
    LineasAlbaranQueryNroCajas: TBCDField;
    LineasAlbaranQueryLargo: TBCDField;
    LineasAlbaranQueryAncho: TBCDField;
    LineasAlbaranQueryAlto: TBCDField;
    LineasAlbaranQueryImporteNeto: TBCDField;
    LineasAlbaranQueryCodigoGrupo: TWideStringField;
    LineasAlbaranQueryDescripcionGrupo: TWideStringField;
    LineasAlbaranQueryNroRegistro: TLongWordField;
    LineasAlbaranQueryPrecio: TFloatField;
    LineasAlbaranQueryCabeceraPagina: TStringField;
    GridViewCabeceraPagina: TcxGridDBColumn;
    LineasAlbaranQueryAnotacion: TWideMemoField;
    GridViewAnotacion: TcxGridDBColumn;
    LineasAlbaranQueryNroOperacion: TIntegerField;
    LineasAlbaranQueryUIDArticulo: TGuidField;
    AdministracionesPublicasBox: TcxGroupBox;
    cxLabel3: TcxLabel;
    OrganismoPublicoCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    NumeroExpedienteCtrl: TcxDBTextEdit;
    cxTabSheet1: TcxTabSheet;
    AnnotationFrame1: TAnnotationFrame;
    cxLabel4: TcxLabel;
    NumeroContratoCtrl: TcxDBTextEdit;
    FacturaDataSource: TDataSource;
    FacturaTable: TnxeTable;
    DetalleDatosFiscalesPC: TcxPageControl;
    FacturaRectificadaTS: TcxTabSheet;
    cxGroupBox3: TcxGroupBox;
    EjercicioFraRectificadaCtrl: TcxDBSpinEdit;
    SerieFraRectificadaCtrl: TcxDBTextEdit;
    NroFacturaRectificadaCtrl: TcxDBIntegerEdit;
    cxLabel7: TcxLabel;
    Label17: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    FechaFraRectificadaBox: TcxLabel;
    RazonMetodoBox: TcxGroupBox;
    RazonCtrl: TcxDBSpinEdit;
    MetodoCtrl: TcxDBSpinEdit;
    Label19: TcxLabel;
    Label20: TcxLabel;
    DescMetodoLabel: TcxLabel;
    Label21: TcxLabel;
    DatosInmuebleTS: TcxTabSheet;
    SituacionInmuebleCtrl: TcxDBIndexedComboBox;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    ReferenciaCatastralCtrl: TcxDBTextEdit;
    ExencionTS: TcxTabSheet;
    cxLabel12: TcxLabel;
    CausaExencionCtrl: TcxDBIndexedComboBox;
    AsientoResumenTS: TcxTabSheet;
    cxLabel13: TcxLabel;
    NroFacturaFinalCtrl: TcxDBIntegerEdit;
    LineasAlbaranQueryCuotaIVA: TBCDField;
    GridViewCuotaIVA: TcxGridDBColumn;
    TotalFacturaBox: TcxLabel;
    DtoComercialBox: TcxLabel;
    DtoPPBox: TcxLabel;
    ImporteRecFinancieroBox: TcxLabel;
    NetoFacturaBox: TcxLabel;
    CuotaIVABox: TcxLabel;
    CuotaREBox: TcxLabel;
    ImportePuntoVerdeBox: TcxLabel;
    PortesBox: TcxLabel;
    NetoArticulosBox: TcxLabel;
    ImporteDeudaBox: TcxLabel;
    ImporteEfectosBox: TcxLabel;
    ImportePendienteBox: TcxLabel;
    ImporteComisionBox: TcxLabel;
    BaseCalculoRetencionBox: TcxLabel;
    TipoRetencionBox: TcxLabel;
    ImporteRetencionBox: TcxLabel;
    Label32: TcxLabel;
    dxBarManager1: TdxBarManager;
    EfectosPopupMenu: TdxBarPopupMenu;
    PopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    EditarEfectoItem: TdxBarButton;
    FichaMovimientosArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    MostrarAnotacionesItem: TdxBarButton;
    RegistroIVAItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    ClienteItem: TdxBarButton;
    ServicioPrestadoTemporalmenteCtrl: TcxDBCheckBox;
    PeriodoFacturacionLabel: TcxLabel;
    InicioPeriodoFacturacionCtrl: TcxDBDateEdit;
    FinPeriodoLabel: TcxLabel;
    FinPeriodoFacturacionCtrl: TcxDBDateEdit;
    CodigoClienteBox: TcxLabel;
    HayBasesExentasPanel: TcxGroupBox;
    cxImage1: TcxImage;
    InformacionFiscalBox: TcxGroupBox;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    InversionSujetoPasivoCtrl: TcxDBCheckBox;
    TipoFacturaCtrl: TcxDBIndexedComboBox;
    RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox;
    cxLabel14: TcxLabel;
    OrganoProponenteCtrl: TcxDBTextEdit;
    ReferenciaOperacionCtrl: TcxDBTextEdit;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    SubvencionesBox: TcxGroupBox;
    FacturaSubvencionadaCtrl: TcxDBCheckBox;
    cxLabel17: TcxLabel;
    ImporteSubvencionCtrl: TcxDBCurrencyEdit;
    TotalesPanel: TcxGroupBox;
    EditarAlbaranItem: TdxBarButton;
    AnuladaLabel: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    SeparadorSerieLabel: TcxLabel;
    LockRangeButton: TgxLockRangeButton;
    RecalcularFacturaItem: TdxBarButton;
    procedure ClienteItemClick(Sender: TObject);
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerActivateForm;
    procedure FormManagerReportFormRequest;
    procedure recibosButtonClick(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure AsientoItemClick(Sender: TObject);
    procedure RegistroIVAItemClick(Sender: TObject);
    procedure Forma_CobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure Forma_CobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure Forma_CobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FacturaVentasTableRecordChanged(DataSet: TDataSet);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure Codigo_VendedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure Codigo_VendedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Codigo_VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FacturaVentasTableUpdateState(DataSet: TDataSet);
    procedure FacturaVentasTableSetKey(DataSet: TDataSet);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure EfectosGridExit(Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaValorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectosGridViewFechaVencimientoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FormManagerLabelsRequest;
    procedure SerieCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FacturaCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridTableViewControllerDelete(Sender: TObject);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure GridTableViewController1UserSelection(Sender: TObject; var AHandled : Boolean);
    procedure LineasAlbaranQueryAfterOpen(DataSet: TDataSet);
    procedure LineasAlbaranQueryAfterClose(DataSet: TDataSet);
    function FacturaVentasTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure DesglosarAlbaranesCtrlPropertiesChange(Sender: TObject);
    procedure TipoComisionCtrlPropertiesValuePosted(Sender: TObject);
    procedure Codigo_VendedorCtrlPropertiesValuePosted(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FacturaVentasTableAfterDelete(DataSet: TDataSet);
    procedure EfectosQueryBeforeOpen(DataSet: TDataSet);
    procedure FormManagerPreparedForm;
    procedure EfectosQueryCalcFields(DataSet: TDataSet);
    procedure EfectosGridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure EditarEfectoItemClick(Sender: TObject);
    procedure EfectosGridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure RectificativaCtrlPropertiesChange(Sender: TObject);
    procedure SerieFraRectificadaCtrlPropertiesChange(Sender: TObject);
    procedure RazonCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EjercicioFraRectificadaCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure RazonCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MetodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure NroFacturaRectificadaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure NroFacturaRectificadaCtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure MemDataSourceDataChange(Sender: TObject; Field: TField);
    procedure FormManagerUpdateButtonsState;
    procedure FacturaVentasTableNewRecord(DataSet: TDataSet);
    procedure GridViewNroDocumentoGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure LineasAlbaranQueryCalcFields(DataSet: TDataSet);
    procedure GridViewCabeceraPaginaGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure PopupMenuPopup(Sender: TObject);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure FichaMovimientosArticuloItemClick(Sender: TObject);
    procedure TrazaItemClick(Sender: TObject);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure OrganismoPublicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure OrganismoPublicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OrganismoPublicoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FacturaTableNewRecord(DataSet: TDataSet);
    function FacturaTableSetLinkRange(DataSet: TDataSet) : SmallInt;
    procedure FacturaVentasTableAfterEdit(DataSet: TDataSet);
    procedure FacturaVentasTableAfterInsert(DataSet: TDataSet);
    procedure FacturaVentasTableBeforeDelete(DataSet: TDataSet);
    procedure TipoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure SerieFraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieFraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure RegimenOTrascendenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure Forma_CobroCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridViewImporteGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure GridViewTcxGridDBDataControllerTcxDataSummarySummaryGroups0SummaryItems1GetText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure ServicioPrestadoTemporalmenteCtrlPropertiesChange(Sender: TObject);
    procedure ServicioPrestadoTemporalmenteCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure FacturaVentasTableGetRecord(DataSet: TDataSet);
    procedure OrganoProponenteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure OrganoProponenteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure OrganoProponenteCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FacturaSubvencionadaCtrlPropertiesChange(Sender: TObject);
    procedure EditarAlbaranItemClick(Sender: TObject);
    function FormManagerDeleteButton: Boolean;
    procedure FormManagerShowCantEditMessage;
    procedure MetodoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure RecalcularFacturaItemClick(Sender: TObject);
  private
    LineaMovimientoFields : TLineaMovimientoFields;
    FRecalculandoFactura : Boolean;

    FOnMuestraTicket : Event<TMuestraMovimientoEvent>;
    FCaptionNroPagina : String;
    FUpdatingMemData : Boolean;

    FEstadoPresentacion : TEstadoPresentacionVerifactu;
    FEstadoRegistro : TEstadoRegistroVerifactu;

    procedure FijaSeriePorDefecto;
    procedure EditarEfectoCobrar;
    procedure DoOnFraRectificativaSelected( Target : TcxCustomEdit = nil );
    procedure SetFacturaKeyFields;
    procedure UpdatePageControlState;
    procedure MuestraAlbaranLinea;

  public

    FacturaVentasFields,
    FacturaRectificadaFields : TFacturaVentasFields;
    ClienteFields : TClienteFields;
    EfectoFields : TEfectoFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    RemesaFields : TRemesaFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    AsientoFields : TAsientoFields;
    FacturaFields : TFacturaFields;
    FormaCobroFields : TFormaCobroFields;
    DivisaFields : TDivisaFields;

    ImporteDeuda,
    ImporteComision : Decimal;

    procedure DoSeleccionAlbaranes;
    procedure Recalculo;
    procedure ActualizaDatosFactura;
    procedure MuestraDatosFactura;
    procedure ActualizaRejilla;

    property OnMuestraTicket : Event<TMuestraMovimientoEvent> read FOnMuestraTicket write FOnMuestraTicket;
  end;

var MntFdvForm : TMntFdvForm = nil;

procedure MntFacturasVenta( Values : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       cxDateUtils,
       dxCalendarUtils,


       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm10Dm,
       Gdm30Dm,

       Gdm30Frm,

       dmi_pga,
       dmi_iva,
       dmi_mov,

       ParametrosFacturacionIntf,

       b_msg,
       bx_not,

       dmi_ast,
       dmi_fac,

       dm_reg,
       dm_ast,
       dm_fac,
       dm_pga,
       dm_art,
       dm_cli,
       dm_tma,
       dm_fdv,
       dm_fco,
       dm_sdf,
       dm_iva,
       dm_ven,
       dm_cdi,
       dm_ecc,
       dm_rem,
       dm_gdo,
       dm_orp,
       dm_rpf,
       dm_rdr,

       a_cli,
       a_art,
       a_fco,
       a_sdf,
       a_mov,
       a_mve,
       a_ret,
       a_ven,
       a_ast,
       a_fvi,
       a_ecc,
       a_orp,

       b_fda,
       b_sav,
       b_trz,

       e_fdv,

       cx_art,
       cx_cli,
       cx_fco,
       cx_sdf,
       cx_ret,
       cx_ven,
       cx_fdv,
       cx_rrf,
       cx_mrf,
       cx_orp,

       r_fdv,
       i_dco;

resourceString
    RsMsg1  = 'Para poder recalcular la factura es necesario que especifique una forma de cobro válida.';
    RsMsg2  = 'La factura, y los albaranes incluidos en ella, han sido recalculados correctamente.';
    RsMsg3  = 'No se ha podido recuperar la factura nº %s %d.';
    RsMsg4  = 'Contabilizada. Asiento nº %d';
    RsMsg5  = '¡Consta como contabilizada pero no existe el asiento contable!';
    RsMsg6  = 'Este número de factura no es correlativo.';
    RsMsg7  = '¿Confirma que desea utilizarlo?';
    RsMsg8  = 'La fecha de vencimiento debe ser igual o superior a la de la factura.';
    RsMsg9  = '¿Esta seguro de que desea suprimir este efecto?';
    RsMsg10 = 'Recuerde que puede regenerar la lista de efectos modificando la forma de cobro de la factura.';
    RsMsg11 = 'Contabilizada. (Sin asiento)';
    RsMsg12 = 'Utilice el botón derecho del ratón para acceder al menú de opciones o haga doble <click> sobre la línea para editar el efecto.';
    RsMsg17 = 'La factura no pertenece al mismo propietario.';
    RsMsg18 = 'No existe ninguna factura con esta serie y número en el ejercicio indicado.';
    RsMsg19 = 'No puede utilizar la factura actual como factura rectificada.';
    RsMsg22 = 'Esta factura debe ser de tipo rectificativa.';
    RsMsg23 = 'La serie actual está asignada a facturas rectificativas. Utilícela solo para este tipo de documentos.';
    RsMsg24 = 'No puede suprimir facturas que ya han sido presentadas (Veri*factu).';

    RsMsg25 = 'Esta factura no puede ser editada.';
    RsMsg26 = 'Ya ha sido contabilizada.' ;
    RsMsg27 = 'Ya ha sido presentada%s.' ;
    // RsMsg28 = #13'Puede, sin embargo, anularla usando la ventana de presentación de Veri*factu.'#13;
    RsMsg29 = 'No pertenece al ejercicio activo.' ;

procedure MntFacturasVenta( Values : array of const );
begin
     CreateEditForm( TMntFdvForm, MntFdvForm, Values, TGds30Frm.VentasSection );
end;

procedure TMntFdvForm.FormManagerInitializeForm;
begin
     ID := idMntFdvForm;

     // TituloDocumentoLabel.Style.TextColor := clIconBlue;

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );

     FacturaRectificadaFields := TFacturaVentasFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     RemesaFields := TRemesaFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     AsientoFields := TAsientoFields.Create( Self );
     FormaCobroFields := TFormaCobroFields.Create( Self );
     DivisaFields := TDivisaFields.Create( Self );

     FacturaVentasTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
     SetFieldRange( FacturaVentasFields.NroFactura );

     SetBarItemVisible( AsientoItem, ApplicationContainer.IsModuleActive( [ 10 ] ) );
     EjercicioFraRectificadaCtrl.Properties.Required := DataModule00.FacturaElectronica;

     PinupAdjustableControl( PageControl, 322 );

     SetEditControlsDecimals( [ DescuentoESCtrl, DescuentoPPCtrl, RecargoFinancieroCtrl, TipoComisionCtrl ], 2 );
     SetEditControlDecimals( TotalACuentaCtrl );
     SetColumnsDecimals( [ EfectosGridViewImporte, EfectosGridViewImporteCobrado ] );

     Codigo_VendedorCtrl.Enabled := DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value;
     TipoComisionCtrl.Enabled := DataModule00.DmEmpresaFields.Vendedor_ComPorCli.Value;

     With DataModule00.DmEmpresaFields do
       begin

       GridViewNumeroSerie.Visible := Ventas_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewPrecioDivisa.Visible := Ventas_Divisas.Value;
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewLargo.Visible := Ventas_Cantidades.Value>0;
       GridViewAncho.Visible := Ventas_Cantidades.Value>0;
       GridViewAlto.Visible := Ventas_Cantidades.Value>1;
       GridViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnDecimals( GridViewCantidad, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewRecargo, GridViewPuntoVerde ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewRecargo, Ventas_DecRecargo.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       SetColumnDecimals( GridViewImporte );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Ventas_DecCajas.Value );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then GridViewAlto.Caption := Ventas_NombreCajas.Value
            else GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       If   DataModule00.PartidasPresupuestarias
       then begin
            GridViewCabeceraPagina.GroupIndex := 2;
            FCaptionNroPagina := GrupoDocumento.ObtenCabeceraGrupos;
            end;

       end;

     With FacturaVentasTable, FacturaVentasFields do
       begin
       SetBCDFieldsDecimals( [ NetoFactura, Portes, ImportePuntoVerde,  ImporteDtoES,
                               ImporteDtoPP, ImporteRecFinanciero, CuotaIVA, CuotaRE,
                               TotalFactura, Comision, TotalACuenta, BaseCalculoRetencion,
                               ImporteRetencion, ImporteSubvencion ] );
       TipoRetencion.DisplayFormat := '#';
       end;

     ShowGroupBox( RazonMetodoBox, DataModule00.FacturaElectronica );
     ShowGroupBox( AdministracionesPublicasBox, DataModule00.FacturaElectronica );
     ShowGroupBox( SubvencionesBox, DataModule00.DmEmpresaFields.Ventas_GestionSubvenciones.Value );

     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesVentas );

end;

procedure TMntFdvForm.FormManagerLabelsRequest;
begin
     With FacturaVentasFields do
       ImpresionEtiquetasFacturasVenta( Serie.Value, NroFactura.Value, NroFactura.Value );
end;

procedure TMntFdvForm.FormManagerPreparedForm;
begin
     EfectosQuery.Open;
     DesglosarAlbaranesCtrl.Checked := True;
     UpdatePageControlState;
end;

procedure TMntFdvForm.FormManagerQueryGridRequest;
begin
     ConsultaFacturasVenta( FacturaVentasFields.Serie, NroFacturaCtrl, qgsDetached );
end;

procedure TMntFdvForm.FormManagerReportRequest;
begin
     With FacturaVentasFields do
       ImpresionFacturasVenta( Ejercicio.Value, Serie.Value, NroFactura.Value, NroFactura.Value );
end;

procedure TMntFdvForm.FormManagerShowCantEditMessage;

var Msg,
    DescMsg : String;

begin
     Msg := RsMsg25;

     If   FacturaVentasFields.Traspasada.Value
     then DescMsg := RsMsg26
     else If   not EjercicioActual( FacturaVentasFields.Fecha.Value )
          then DescMsg := RsMsg29
          else begin
               DescMsg := Format( RsMsg27, [ IfThen( FEstadoPresentacion=epvAnulado, ' y anulada', '' ) ] );
               {
               If   FEstadoPresentacion<>epvAnulado
               then StrAdd( DescMsg, RsMsg28 );
               }
               end;

     ShowHintMsg( Msg, DescMsg);
end;

procedure TMntFdvForm.FormManagerUpdateButtonsState;
begin
     RecibosButton.Enabled := FacturaVentasTable.State=dsBrowse;
     DeleteButton.Enabled := DeleteButton.Enabled and not FacturaVentasFields.Traspasada.Value;
end;

procedure TMntFdvForm.GridTableViewController1UserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MuestraAlbaranLinea;
end;

procedure TMntFdvForm.MuestraAlbaranLinea;
begin
     If  ( ProgramNumber=pnTPV ) and FOnMuestraTicket.CanInvoke
     then FOnMuestraTicket.Invoke( tmVenta, LineasAlbaranQueryEjercicio.Value, LineasAlbaranQuerySerie.Value, LineasAlbaranQueryNroDocumento.Value )
     else MntMovimientosPorNroRegistro( LineasAlbaranQueryNroRegistro.Value );
end;

procedure TMntFdvForm.FacturaCtrlPropertiesValuePosted(Sender: TObject);
begin
     With Sender as TcxCustomEdit do
       If   Editing
       then ActualizaDatosFactura;
end;

procedure TMntFdvForm.FacturaSubvencionadaCtrlPropertiesChange(Sender: TObject);
begin
     ImporteSubvencionCtrl.Enabled := FacturaSubvencionadaCtrl.Checked;
end;

procedure TMntFdvForm.FacturaTableNewRecord(DataSet: TDataSet);
begin
     SetFacturaKeyFields;

     Factura.CompletaRegistroFacturaExpedida( ClienteFields.CodigoProvincia.Value,
                                              ClienteFields.CodigoPais.Value,
                                              { Rectificativa } SerieFacturacionFields.FacturasRectificativas.Value,
                                              { Simplificada } False,
                                              { VentasOnline } False,
                                              FacturaFields );

end;

function TMntFdvForm.FacturaTableSetLinkRange(DataSet: TDataSet) : SmallInt;
begin
     SetFacturaKeyFields;
     Result := 5;
end;

procedure TMntFdvForm.SetFacturaKeyFields;
begin
     If   Assigned( FacturaFields )
     then With FacturaFields do
            begin
            Tipo.Value := tfFacturaVentas;
            Ejercicio.Value := FacturaVentasFields.Ejercicio.Value;
            Propietario.Value := '';
            SerieFactura.Value := FacturaVentasFields.Serie.Value;
            NroRegistro.Value := FacturaVentasFields.NroFactura.Value;
            end;
end;

procedure TMntFdvForm.OrganismoPublicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOrganismoPublico( [ topUnidadTramitadora, Sender.EditValue ] );
end;

procedure TMntFdvForm.OrganismoPublicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( topUnidadTramitadora, Sender );
end;

procedure TMntFdvForm.OrganismoPublicoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     OrganismoPublico.Valida( topUnidadTramitadora, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFdvForm.OrganoProponenteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOrganismoPublico( [ topOrganoProponente, Sender.EditValue ] );
end;

procedure TMntFdvForm.OrganoProponenteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( topOrganoProponente, Sender );
end;

procedure TMntFdvForm.OrganoProponenteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then OrganismoPublico.Valida( topOrganoProponente, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFdvForm.DesglosarAlbaranesCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TMntFdvForm.DoSeleccionAlbaranes;

var   ParametrosFacturacion  : IParametrosFacturacion;

begin

     ParametrosFacturacion := TParametrosFacturacion.Create;

     With ParametrosFacturacion do
       begin

       TipoSeleccion := tsRelacion;  // relacion de albaranes
       Serie := FacturaVentasFields.Serie.Value;
       PrimerNroFactura := FacturaVentasFields.NroFactura.Value;
       FechaFacturacion := BoxSavForm.DataFechaFactura.Value;

       With FacturaVentasTable do
         begin
         ParametrosFacturacion := FacturaVentas.GeneraFacturas( ParametrosFacturacion, BoxSavForm.RelacionAlbaranesTable );
         If   ParametrosFacturacion.NroFacturaInicial<>0
         then begin
              Cancel;
              If   FindKey( [ ApplicationContainer.Ejercicio, Serie, NroFacturaInicial ] )
              then FormManager.SelectFirstDataControl;  // Fuerzo un edit
              end;
         end;

       end;
end;

procedure TMntFdvForm.EfectosQueryBeforeOpen(DataSet: TDataSet);
begin
     If   Assigned( FacturaVentasFields )
     then With FacturaVentasFields do
            If   Traspasada.Value and 
                 SerieFacturacionFields.Contabilizar.Value and 
                 ( ( SerieFacturacionFields.Empresa_Destino.Value='' ) or ( SerieFacturacionFields.Empresa_Destino.Value=CodigoEmpresaActual ) )
            then begin
                 EfectosQuery.SQL.Text := 'SELECT NroEfecto AS NroEfecto, FechaVencimiento AS FechaVencimiento, Importe ' +
                                          'FROM EfectoCobrar ' +
                                          'WHERE Ejercicio=' + IntToStr( Ejercicio.Value ) + ' AND Serie=' + QuotedStr( Serie.Value ) + ' AND NroFactura=' + IntToStr( NroFactura.Value );
                 With EfectosGridView.OptionsData do
                   begin
                   Deleting := False;
                   Editing := False;
                   end;

                 EfectosGridViewFechaCobro.Visible := True;
                 EfectosGridViewImporteCobrado.Visible := True;
                 EfectosGridViewImpagado.Visible := True;

                 EfectosGridView.OptionsView.ColumnAutoWidth := True;
                 EfectosGrid.Hint := RsMsg12;
                 EfectosGrid.ShowHint := True;
                 EfectosPopupMenu.AutoPopup := True;

                 end
            else begin
                 EfectosQuery.SQL.Text := 'SELECT NroEfecto, FechaVencimiento, Importe ' +
                                          'FROM Efecto ' +
                                          'WHERE Tipo=1 AND Ejercicio=' + IntToStr( Ejercicio.Value ) + ' AND Propietario=' + QuotedStr( CodigoCliente.Value ) + ' AND Serie=' + QuotedStr( Serie.Value ) + ' AND NroDocumento=' + IntToStr( NroFactura.Value );
                 With EfectosGridView.OptionsData do
                   begin
                   Deleting := True;
                   Editing := True;
                   end;

                 EfectosGridViewFechaCobro.Visible := False;
                 EfectosGridViewImporteCobrado.Visible := False;
                 EfectosGridViewImpagado.Visible := False;

                 EfectosGridView.OptionsView.ColumnAutoWidth := False;

                 EfectosGrid.Hint := '';
                 EfectosGrid.ShowHint := False;
                 EfectosPopupMenu.AutoPopup := False;
                 end;
end;

procedure TMntFdvForm.EfectosQueryCalcFields(DataSet: TDataSet);
begin
     If   Assigned( FacturaVentasFields )
     then With FacturaVentasFields do
            If   Traspasada.Value
            then begin
                 If   EfectoCobrarTable.FindKey( [ Ejercicio.Value, Serie.Value, NroFactura.Value, EfectosQueryNroEfecto.Value ] )
                 then begin

                      If   not ValueIsEmpty( EfectoCobrarFields.FechaEmision.Value )
                      then begin
                           EfectosQueryEmitido.Value := True;
                           EfectosQueryFechaEmision.Value := EfectoCobrarFields.FechaEmision.Value;
                           end;

                      EfectosQueryImpagado.Value := EfectoCobrarFields.Impagado.Value;

                      If   not EfectoCobrarFields.Impagado.Value
                      then If   ValueIsEmpty( EfectoCobrarFields.FechaCobro.Value )
                           then begin
                                If   EfectoCobrarFields.NroRemesa.Value<>0
                                then If   Remesa.Obten( EfectoCobrarFields.Ejercicio.Value, EfectoCobrarFields.NroRemesa.Value, RemesaFields )
                                     then If   not EfectoCobrar.EfectoPendiente( EfectoCobrarFields )
                                          then begin

                                               If   not ValueIsEmpty( RemesaFields.FechaCobro.Value )
                                               then EfectosQueryFechaCobro.Value := RemesaFields.FechaCobro.Value
                                               else If   not ValueIsEmpty( RemesaFields.FechaDescuento.Value )
                                                    then EfectosQueryFechaCobro.Value := RemesaFields.FechaDescuento.Value;

                                               EfectosQueryImporteCobrado.Value := EfectosQueryImporte.Value;
                                               end;
                                end
                           else begin
                                EfectosQueryFechaCobro.Value := EfectoCobrarFields.FechaCobro.Value;
                                EfectosQueryImporteCobrado.Value := EfectoCobrarFields.ImporteCobrado.Value;
                                end;
                      end;
                 end
            else If   EfectoTable.FindKey( [ Ejercicio.Value, scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, EfectosQueryNroEfecto.Value ] )
                 then If   EfectoFields.Emitido.Value
                      then begin
                           EfectosQueryEmitido.Value := True;
                           EfectosQueryFechaEmision.Value := EfectoFields.FechaEmision.Value;
                           end;
end;

procedure TMntFdvForm.EjercicioFraRectificadaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EjercicioFraRectificadaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := ApplicationContainer.Ejercicio;
end;

procedure TMntFdvForm.NroFacturaRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( nil, Sender, qgsNormal, DoOnFraRectificativaSelected );
end;

procedure TMntFdvForm.DoOnFraRectificativaSelected;
begin
     With CxFdvForm do
       begin
       NroFacturaRectificadaCtrl.Clear;  // Para evitar que se valide antes de hora
       EjercicioFraRectificadaCtrl.PostEditValue( QueryEjercicio.Value );
       SerieFraRectificadaCtrl.PostEditValue( QuerySerie.Value );
       NroFacturaRectificadaCtrl.PostEditValue( QueryNroFactura.Value );
       end;
end;

procedure TMntFdvForm.PopupMenuPopup(Sender: TObject);

var  LineaSeleccionada : Boolean;

begin
     With LineaMovimientoFields do
       begin
       LineaSeleccionada := Assigned( GridView.Controller.FocusedRow );
       EditarAlbaranItem.Enabled := LineaSeleccionada;
       FichaMovimientosArticuloItem.Enabled := LineaSeleccionada and ( CodigoArticulo.Value<>ArticuloManual );
       FichaArticuloItem.Enabled := LineaSeleccionada and ( CodigoArticulo.Value<>ArticuloManual );
       TrazaItem.Enabled := LineaSeleccionada;
       MostrarAnotacionesItem.Down := GridView.Preview.Visible;
       end;
end;

procedure TMntFdvForm.Forma_CobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntFdvForm.Forma_CobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntFdvForm.Forma_CobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFdvForm.Forma_CobroCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   Assigned( FormaCobroFields ) and
          not ValueIsEmpty( Forma_CobroCtrl.EditValue )  // A pesar de ser Required puede darse el caso
     then begin

          FormaCobro.Obten( Forma_CobroCtrl.EditValue, FormaCobroFields, True );

          DescuentoPPCtrl.Enabled := FormaCobroFields.DescuentoPP.Value;
          RecargoFinancieroCtrl.Enabled := FormaCobroFields.RecargoFinanciero.Value;

          With Forma_CobroCtrl do
            If   Editing
            then begin

                 With FacturaVentasFields.DescuentoPP do
                   If   FormaCobroFields.DescuentoPP.Value
                   then begin
                        If   ClienteFields.Factura_DtoPP.Value=0.0
                        then Value := FormaCobroFields.TipoDescuentoPP.Value
                        else Value := ClienteFields.Factura_DtoPP.Value;
                        end
                   else Value  := 0.0;


                 With FacturaVentasFields.RecargoFinanciero do
                   If   FormaCobroFields.RecargoFinanciero.Value
                   then begin
                        If   ClienteFields.Factura_RecFinanc.Value=0.0
                        then Value := FormaCobroFields.TipoRecargoFinanc.Value
                        else Value := ClienteFields.Factura_RecFinanc.Value;
                        end
                   else Value  := 0.0;

                   ActualizaDatosFactura;

                   If   TabKey
                   then SelectNextFormControl( Forma_CobroCtrl, not ShiftKey );

                   end;

          end;
end;

procedure TMntFdvForm.FormManagerActivateForm;

var   CancelEdit : Boolean;

begin
     CancelEdit := False;
     If   Assigned( BoxSavForm )
     then CancelEdit := BoxSavForm.ModalResult<>mrOk
     else CancelEdit := FacturaVentasTable.State=dsInsert;
     If   CancelEdit
     then With FacturaVentasTable do
            begin
            Cancel;
            Last;
            end;
     If   Assigned( BoxSavForm )
     then BoxSavForm.Release;
end;

function TMntFdvForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     If   Assigned( FacturaVentasFields )
     then begin
          RegistroIVAItem.Enabled := FacturaVentasFields.Traspasada.Value;
          AsientoItem.Enabled := FacturaVentasFields.Traspasada.Value;
          end;
     Result := True; // Aun queda la opción de la ficha del cliente
end;

function TMntFdvForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   FEstadoPresentacion<>epvPendiente
     then begin
          ShowNotification( ntStop, RsMsg24 );
          Abort;
          end;
end;

procedure TMntFdvForm.RazonCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRazonesRectificacion( Sender );
end;

procedure TMntFdvForm.RazonCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     RazonCtrl.Description := Tasa.TextoRazonRectificacion( VarToSmallInt( DisplayValue ) );
end;

procedure TMntFdvForm.RecalcularFacturaItemClick(Sender: TObject);
begin
      With FacturaVentasFields do
        If   ReconstruccionResultados.RecalculaFactura( CodigoCliente.Value, Serie.Value, NroFactura.Value )
        then begin
             FacturaVentasTable.ReloadRecord;
             ShowNotification( ntInformation, RsMsg2 );
             end
        else ShowNotification( ntError, Format( RsMsg3, [ Serie.Value, NroFactura.Value ] ) );
end;

procedure TMntFdvForm.Recalculo;
begin
     If   not FRecalculandoFactura
     then try
            FRecalculandoFactura := True;
            If   not ValueIsEmpty( FacturaVentasFields.CodigoFormaCobro.Value )
            then begin
                 FacturaVentas.RecalculaFactura( FacturaVentasFields, True );
                 FacturaVentasTable.RefreshAndEdit;
                 end;
          finally
            FRecalculandoFactura := False;
            end;
end;

procedure TMntFdvForm.Codigo_VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntFdvForm.Codigo_VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntFdvForm.Codigo_VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     With Codigo_VendedorCtrl do
       begin
       If   ValueIsEmpty( DisplayValue )
       then Description := ''
       else Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
       TipoComisionCtrl.Enabled := not ValueIsEmpty( DisplayValue );
       If   Editing
       then begin
            If   ValueIsEmpty( DisplayValue )
            then TipoComisionCtrl.Clear;
            ResetTab;
            end;
       end;
end;

procedure TMntFdvForm.Codigo_VendedorCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaDatosFactura;
end;

procedure TMntFdvForm.ActualizaDatosFactura;
begin
     Recalculo;
     MuestraDatosFactura;
end;

procedure TMntFdvForm.MemDataSourceDataChange(Sender: TObject;Field: TField);
begin
     With FacturaVentasTable do
       If   ( State=dsEdit ) and not FUpdatingMemData
       then Modified := True;
end;

procedure TMntFdvForm.MetodoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMetodosRectificacion( Sender );
end;

procedure TMntFdvForm.MetodoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     MetodoCtrl.Description := Tasa.TextoMetodoRectificacion( VarToSmallInt( DisplayValue ) );
end;

procedure TMntFdvForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesVentas, BoolToStr( MostrarAnotacionesItem.Down, True ) );
end;

procedure TMntFdvForm.MuestraDatosFactura;

var  ImporteNetoFactura,
     ImporteEfectos,
     ImportePendiente : Decimal;

begin

     With FacturaVentasFields do
       begin

       CodigoClienteBox.Caption := CodigoCliente.Value;
       NetoArticulosBox.Caption := StrFormat( NetoFactura.Value, DecimalesMoneda, True );
       PortesBox.Caption := StrFormat( Portes.Value, DecimalesMoneda, True );
       ImportePuntoVerdeBox.Caption := StrFormat( ImportePuntoVerde.Value, DecimalesMoneda, True );
       DtoComercialBox.Caption := StrFormat( -ImporteDtoES.Value, DecimalesMoneda, True );
       DtoPPBox.Caption := StrFormat( -ImporteDtoPP.Value, DecimalesMoneda, True );
       ImporteRecFinancieroBox.Caption := StrFormat( ImporteRecFinanciero.Value, DecimalesMoneda, True );

       ImporteDeuda := TotalFactura.Value - TotalACuenta.Value;
       ImporteNetoFactura := NetoFactura.Value - DescuentosClientes.Value + Portes.Value + ImporteRecFinanciero.Value;

       NetoFacturaBox.Caption := StrFormat( ImporteNetoFactura );
       CuotaIVABox.Caption := StrFormat( CuotaIVA.Value );
       CuotaREBox.Caption := StrFormat( CuotaRE.Value );
       TotalFacturaBox.Caption := StrFormat( TotalFactura.Value );

       // Otra información

       BaseCalculoRetencionBox.Caption := StrFormat( BaseCalculoRetencion.Value, DecimalesMoneda, True );
       If   ValueIsEmpty( TipoRetencion.Value )
       then TipoRetencionBox.Caption := ''
       else TipoRetencionBox.Caption := StrInt( TipoRetencion.Value ) + ' ';
       ImporteRetencionBox.Caption := StrFormat( ImporteRetencion.Value, DecimalesMoneda, True );
       ImporteComisionBox.Caption := StrFormat( Comision.Value, DecimalesMoneda, True );

       ImporteDeudaBox.Caption := StrFormat( ImporteDeuda, DecimalesMoneda, True );

       ImportePendienteBox.Visible := Traspasada.Value;
       If   Traspasada.Value
       then begin
            Factura.ImportePendienteFacturaEmitida( Ejercicio.Value, Serie.Value, NroFactura.Value, ImporteEfectos, ImportePendiente );
            // Si hay gastos que hacen que el importe cobrado supere al de la factura, no deben aparecer como un importe negativo
            If   ImportePendiente<0.0
            then ImportePendiente := 0.0;
            ImporteEfectosBox.Caption := StrFormat( ImporteEfectos, DecimalesMoneda, True );
            ImportePendienteBox.Caption := StrFormat( ImportePendiente, DecimalesMoneda, True );
            end;

       end;
end;

procedure TMntFdvForm.EfectosGridExit(Sender: TObject);
begin
     EfectosQuery.Cancel;
end;

procedure TMntFdvForm.EfectosGridViewCustomDrawCell(      Sender    : TcxCustomGridTableView;
                                                          ACanvas   : TcxCanvas;
                                                          AViewInfo : TcxGridTableDataCellViewInfo;
                                                      var ADone     : Boolean );
begin
     If   not ( AViewInfo.Selected )
     then If   VarToBoolean( AViewInfo.GridRecord.Values[ EfectosGridViewImpagado.Index ] )
          then ACanvas.Brush.Color := clLightRed;
end;

procedure TMntFdvForm.EfectosGridViewDataControllerSummaryAfterSummary( ASender: TcxDataSummary );
begin
     If   Assigned( FacturaVentasFields )
     then If   not FacturaVentasFields.Traspasada.Value
          then With ASender, ImporteEfectosBox do
                 If   ValueIsEmpty( FooterSummaryValues[ 0 ], varDouble )
                 then Caption := ''
                 else Caption := StrFormat( FooterSummaryValues[ 0 ], DecimalesMoneda );
end;

procedure TMntFdvForm.EfectosGridViewFechaVencimientoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Date : TDateTime;

begin
     If   TextToDateEx( DisplayValue, Date )
     then If   YearOf( Date )<YearOf( FacturaVentasFields.Fecha.Value )
          then begin
               Error := True;
               ErrorText := RsMsg8;
               end
end;

procedure TMntFdvForm.GridTableViewControllerDelete(Sender: TObject);

var NroEfecto : SmallInt;

begin
     If   ShowNotification( ntQuestionWarning, RsMsg9, RsMsg10 )=mrYes
     then begin
          EfectosGridView.DataController.DeleteFocused;
          With EfectosQuery do
            try
              DisableControls;
              NroEfecto := 1;
              First;
              While not Eof do
                begin
                Edit;
                EfectosQueryNroEfecto.Value := NroEfecto;
                Post;
                Inc( NroEfecto );
                Next;
                end;
            finally
              EnableControls;
              end;
          end;
     Abort;
end;

procedure TMntFdvForm.EditarAlbaranItemClick(Sender: TObject);
begin
     MuestraAlbaranLinea;
end;

procedure TMntFdvForm.EditarEfectoCobrar;
begin
     With FacturaVentasFields do
       If   Traspasada.Value
       then MntEfectosCobrar( [  Ejercicio.Value, Serie.Value, NroFactura.Value, EfectosQueryNroEfecto.Value ] );
end;

procedure TMntFdvForm.EditarEfectoItemClick(Sender: TObject);
begin
     EditarEfectoCobrar;
end;

procedure TMntFdvForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     EditarEfectoCobrar;
end;

procedure TMntFdvForm.GridViewCabeceraPaginaGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                                ARecord : TcxCustomGridRecord;
                                                            var AText   : string);
begin
     AText := ARecord.Values[ GridViewCabeceraPagina.Index ];
end;

procedure TMntFdvForm.GridViewImporteGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporte.Index ] ), DecimalesMoneda, True );
end;

procedure TMntFdvForm.GridViewNroDocumentoGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : string );
begin
     AText := Format( 'Albarán nº : %s', [ IntToStr( ARecord.Values[ GridViewNroDocumento.Index ] ) ] );
end;

procedure TMntFdvForm.GridViewTcxGridDBDataControllerTcxDataSummarySummaryGroups0SummaryItems1GetText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
     AText := 'Importe neto : ' + StrFormat( VarToDecimal( AValue ), DecimalesMoneda, True );
end;

procedure TMntFdvForm.LineasAlbaranQueryAfterClose(DataSet: TDataSet);
begin
     LineaMovimientoFields := nil;
end;

procedure TMntFdvForm.LineasAlbaranQueryAfterOpen(DataSet: TDataSet);
begin
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineasAlbaranQuery );
     If   Assigned( FacturaVentasFields )
     then If   LineaMovimientoFields.Ejercicio.Value=FacturaVentasFields.Ejercicio.Value
          then GridViewEjercicio.GroupIndex := -1
          else GridViewEjercicio.GroupIndex := 0;
end;

procedure TMntFdvForm.LineasAlbaranQueryCalcFields(DataSet: TDataSet);

var  CaptionText : String;

begin
     If   LineasAlbaranQueryCodigoGrupo.Value<>''
     then CaptionText := LineasAlbaranQueryCodigoGrupo.Value + ', '
     else CaptionText := '';
     LineasAlbaranQueryCabeceraPagina.Value :=  CaptionText + LineasAlbaranQueryDescripcionGrupo.Value;
end;

procedure TMntFdvForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With FacturaVentasTable do
       begin
       // KeyValues : Ejercicio;Serie;NroFactura
       KeyValues[ 0 ] := UnAssigned;
       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Serie
       KeyValues[ 2 ] := UnAssigned; // NroFactura
       end;
end;

procedure TMntFdvForm.FormManagerReportFormRequest;
begin
     With FacturaVentasFields do
       ImpresionFacturasVenta( Ejercicio.Value, Serie.Value, NroFactura.Value, NroFactura.Value, { Impreso } True );
end;

procedure TMntFdvForm.FacturaVentasTableAfterDelete(DataSet: TDataSet);
begin
     ActualizaMovimientosVenta( tmVenta );
end;

procedure TMntFdvForm.FacturaVentasTableAfterEdit(DataSet: TDataSet);
begin
     With FacturaTable do
       If   FacturaFields.Ejercicio.IsNull
       then begin
            Append;
            PostAndEdit;
            end;
end;

procedure TMntFdvForm.FacturaVentasTableAfterInsert(DataSet: TDataSet);
begin
     FacturaTable.Append;
end;

procedure TMntFdvForm.FacturaVentasTableBeforeDelete(DataSet: TDataSet);
begin
     FacturaVentas.SuprimeRelaciones( FacturaVentasFields, { SuprimeRegistroFactura } False ); // El registro de la factura (FacturaTable) lo suprime el proceso de edición
end;

function TMntFdvForm.FacturaVentasTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     If   Assigned( FacturaVentasFields )
     then With FacturaVentasFields do
            Result := not Traspasada.Value and EjercicioActual( Fecha.Value ) and ( FEstadoPresentacion=epvPendiente )
     else Result := True;
end;

procedure TMntFdvForm.FacturaVentasTableGetRecord(DataSet: TDataSet);
begin
     If   FacturaVentasFields.Serie.IsNull
     then begin
          FacturaVentasTable.SetKey;
          FijaSeriePorDefecto;
          end;

     If   EntornoVerifactu
     then RegistroPresentacion.ObtenEstadoPresentacionVerifactu( FacturaVentasFields.Serie.Value,
                                                                 FacturaVentasFields.NroFactura.Value,
                                                                 FEstadoPresentacion,
                                                                 FEstadoRegistro )
     else FEstadoPresentacion := epvPendiente

end;

procedure TMntFdvForm.FacturaVentasTableNewRecord(DataSet: TDataSet);
begin
     If   DataModule00.DmEmpresaFields.Ventas_CompCorrDoc.Value
     then With FacturaVentasFields do
            If   NroFactura.Value>FacturaVentas.ProximoNroFactura( Serie.Value, False )
            then If   ShowNotification( ntQuestionWarning, RsMsg6, RsMsg7 )<>mrYes
                 then Abort;

     SeleccionaAlbaranesVenta( FacturaVentasFields.Serie.Value, DoSeleccionAlbaranes );
end;

procedure TMntFdvForm.NroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasVenta( FacturaVentasFields.Serie, Sender, qgsLinked );
end;

procedure TMntFdvForm.NroFacturaRectificadaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ejercicio : SmallInt;
     Serie : String;
     NroFactura : LongInt;

begin
     If   Assigned( FacturaFields ) and
          SerieFacturacionFields.FacturasRectificativas.Value and
          ( EjercicioFraRectificadaCtrl.Editing or SerieFraRectificadaCtrl.Editing or NroFacturaRectificadaCtrl.Editing )
     then begin

          FechaFraRectificadaBox.Caption := '';

          Ejercicio := FacturaFields.EjercicioFraRectificada.Value;
          Serie := FacturaFields.SerieFraRectificada.Value;
          NroFactura := FacturaFields.NroFacturaRectificada.Value;

          If   Sender=EjercicioFraRectificadaCtrl
          then Ejercicio :=  VarToSmallInt( DisplayValue )
          else If   Sender=SerieFraRectificadaCtrl
               then Serie := VarToStr( DisplayValue )
               else NroFactura := VarToInteger( DisplayValue );

            If   ValueIsEmpty( NroFactura )
            then begin
                 If   NroFacturaRectificadaCtrl.Editing
                 then FacturaFields.SerieFactura.Clear;
                 end
            else begin
                 Error := False;
                 If    ( Ejercicio=FacturaVentasFields.Ejercicio.Value ) and
                       ( Serie=FacturaVentasFields.Serie.Value ) and
                       ( NroFactura=FacturaVentasFields.NroFactura.Value )
                 then begin
                      Error := True;
                      ErrorText := RsMsg19;
                      end
                 else If   FacturaVentas.Obten( Ejercicio, Serie, NroFactura, FacturaRectificadaFields )
                      then begin
                           If   FacturaVentas.DmFacturaVentasFields.CodigoCliente.Value<>FacturaVentasFields.CodigoCliente.Value
                           then begin
                                Error := True;
                                ErrorText := RsMsg17;
                                end
                           else begin
                                FechaFraRectificadaBox.Caption := StrFormatDate( FacturaVEntas.DmFacturaVentasFields.Fecha.Value, dfDefault2 );
                                EjercicioFraRectificadaCtrl.IsEditValidated := True;
                                SerieFraRectificadaCtrl.IsEditValidated := True;
                                NroFacturaRectificadaCtrl.IsEditValidated := True;
                                end;
                           end
                      else begin
                           Error := True;
                           ErrorText := RsMsg18;
                           end
                 end;
          end;
end;

procedure TMntFdvForm.RecibosButtonClick(Sender: TObject);
begin
     With FacturaVentasFields do
       ImpresionDocumentosCobro( Ejercicio.Value, Serie.Value, NroFactura.Value );
end;

procedure TMntFdvForm.FacturaVentasTableRecordChanged(DataSet: TDataSet);

var  CodigoDivisa : String;

begin

     try
       FUpdatingMemData := True;

       If   ( csDestroying in ComponentState ) or FacturaVentasTable.ControlsDisabled
       then Exit;

       EstadoLabel.Style.Font.Color := clNavy;
       AnuladaLabel.Visible := FacturaVentasFields.Anulada.Value;

       If   not SerieCtrl.IsEditValidated
       then SerieFacturacion.Obten( FacturaVentasFields.Serie.Value, SerieFacturacionFields );

       Cliente.Obten( FacturaVentasFields.CodigoCliente.Value, '', ClienteFields );

       DescClienteLabel.Caption := ClienteFields.Nombre.Value;

       If   GridViewPrecioDivisa.Visible
       then begin
            GridViewPrecioDivisa.Caption := RsPrecioDivisa;
            CodigoDivisa := ClienteFields.CodigoDivisa.Value;
            If   not ValueIsEmpty( CodigoDivisa )
            then If   Divisa.Obten( CodigoDivisa, DivisaFields, True )
                 then begin
                      GridViewPrecioDivisa.Caption := Format( RsPrecioDivisaCodigo, [ DivisaFields.Codigo.Value ] );
                      SetColumnDecimals( GridViewPrecioDivisa, Decimales( DivisaFields.PrecisionRedondeo.Value ) );
                      end;
            end;

       With FacturaVentasFields do
         begin

         var TextoEstado := '';

         If   Traspasada.Value
         then If   Asiento.ObtenDocumento( taFraEmitida, Ejercicio.Value, ClienteFields.Subcuenta.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura, AsientoFields )
              then TextoEstado := Format( RsMsg4, [ AsientoFields.NroAsiento.Value ] )
              else If   SerieFacturacionFields.Contabilizar.Value
                   then begin
                        TextoEstado := RsMsg5;
                        EstadoLabel.Style.Font.Color := clRed;
                        end
                   else TextoEstado := RsMsg11;

         If   FEstadoPresentacion<>epvPendiente
         then If   FEstadoRegistro=ervAceptadoConErrores
              then begin
                   StrAdd( TextoEstado, ' (Presentada y aceptada con errores)' );
                   EstadoLabel.Style.Font.Color := clIconOrange;
                   end
              else StrAdd( TextoEstado, ' (Presentada)' );

         EstadoLabel.Caption := TextoEstado;

         If   not SerieCtrl.IsEditValidated
         then UpdatePageControlState;

         end;

       ActualizaRejilla;

       MuestraDatosFactura;

       DescTipoRetencionLabel.Caption := Tasa.DescripcionRetencion( FacturaVentasFields.Fecha.Value, FacturaVentasFields.TipoRetencion.Value );


     finally
       FUpdatingMemData := False;
     end;
end;

procedure TMntFdvForm.ActualizaRejilla;
begin
     With GridView.ViewData do
        If   DesglosarAlbaranesCtrl.Checked
        then Expand( True )
        else Collapse( True );
end;

procedure TMntFdvForm.FacturaVentasTableSetKey(DataSet: TDataSet);
begin
     FacturaVentasFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   LockRangeButton.SettingDefaultRange
     then FijaSeriePorDefecto;

     MuestraDatosFactura;
end;

procedure TMntFdvForm.FacturaVentasTableUpdateState(DataSet: TDataSet);
begin
     EfectosDataSource.Enabled := FacturaVentasTable.State<>dsSetKey;
     LineasAlbaranDataSource.Enabled := not ( FacturaVentasTable.State in [ dsSetKey, dsInsert ] );
     FacturaVentas.RetiraNroFactura( FacturaVentasFields );
end;

procedure TMntFdvForm.FechaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
     Tasa.CompruebaCambioTipoImpositivo( siRepercutido, DisplayValue, FacturaVentasFields.Fecha.Value, ErrorText, Error );
end;

procedure TMntFdvForm.FechaValorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, False, True );
end;

procedure TMntFdvForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntFdvForm.FichaMovimientosArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntFdvForm.FijaSeriePorDefecto;
begin
     SerieFacturacion.FijaSeriePorDefecto( FacturaVentasFields.Serie );
     If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
     then LockRangeButton.Enabled := False;
end;

function TMntFdvForm.FormManagerGetAccessLevel: Smallint;
begin
     If   ProgramNumber=pnTPV
     then Result := DataModule00.DmUsuarioFields.acCACaja.Value
     else Result := acConAcceso;
end;

procedure TMntFdvForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( FacturaVentasFields.Anotacion );
end;

procedure TMntFdvForm.AsientoItemClick(Sender: TObject);
begin
     With FacturaVentasFields do
       If   Traspasada.Value
       then With Asiento do
              If   Asiento.ObtenDocumento( taFraEmitida, Ejercicio.Value, ClienteFields.Subcuenta.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura, AsientoFields )
              then MntAsientos( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
end;

procedure TMntFdvForm.RectificativaCtrlPropertiesChange(Sender: TObject);
begin
     {
     With EjercicioFraRectificadaCtrl do
       begin
       Enabled := RectificativaCtrl.Checked;
       If   not Enabled
       then ClearAndPost;
       end;

     With SerieFraRectificadaCtrl do
       begin
       Enabled := RectificativaCtrl.Checked;
       If   not Enabled
       then ClearAndPost;
       end;

     With NroFacturaRectificadaCtrl do
       begin
       Enabled := RectificativaCtrl.Checked;
       If   not Enabled
       then ClearAndPost;
       end;
     }
end;

procedure TMntFdvForm.RegimenOTrascendenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   RegimenOTrascendenciaCtrl.Editing
     then UpdatePageControlState;
end;

procedure TMntFdvForm.RegistroIVAItemClick(Sender: TObject);
begin
     With FacturaVentasFields do
       If   Traspasada.Value
       then MntFacturasEmitidas( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] );
end;

procedure TMntFdvForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
    SetBarItemVisible( RecalcularFacturaItem, FEstadoRegistro=ervAceptadoConErrores );
end;

procedure TMntFdvForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntFdvForm.SerieCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     // SerieFacturacion.SetDefault( SerieCtrl );
end;

procedure TMntFdvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntFdvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error and SerieCtrl.Editing
     then UpdatePageControlState;
end;

procedure TMntFdvForm.SerieFraRectificadaCtrlPropertiesChange(Sender: TObject);
begin
     If   SerieFraRectificadaCtrl.Editing
     then FacturaFields.NroFacturaRectificada.Clear;
end;

procedure TMntFdvForm.SerieFraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntFdvForm.SerieFraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
end;

procedure TMntFdvForm.ServicioPrestadoTemporalmenteCtrlPropertiesChange(Sender: TObject);
begin
     InicioPeriodoFacturacionCtrl.Enabled := ServicioPrestadoTemporalmenteCtrl.Checked;
     FinPeriodoFacturacionCtrl.Enabled := ServicioPrestadoTemporalmenteCtrl.Checked;          
end;

procedure TMntFdvForm.ServicioPrestadoTemporalmenteCtrlPropertiesValuePosted(Sender: TObject);

var  Year, Month, Day : Word;
     
begin
     If   FacturaVentasFields.ServicioPrestadoTemporalmente.Value and
          FacturaVentasFields.InicioPeriodoFacturacion.IsNull
     then begin
          If   DayOf( FacturaVentasFields.Fecha.Value )=DaysInMonth( FacturaVentasFields.Fecha.Value )
          then begin
               DecodeDate( FacturaVentasFields.Fecha.Value, Year, Month, Day );
               FacturaVentasFields.InicioPeriodoFacturacion.Value := EncodeDate( Year, Month, 1 );
               end
          else FacturaVentasFields.InicioPeriodoFacturacion.Value := IncMonth( FacturaVentasFields.Fecha.Value, -1 );
          FacturaVentasFields.FinPeriodoFacturacion.Value := FacturaVentasFields.Fecha.Value;
          end;
end;

procedure TMntFdvForm.TipoComisionCtrlPropertiesValuePosted(Sender: TObject);
begin
     ActualizaDatosFactura;
end;

procedure TMntFdvForm.TipoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   SerieFacturacionFields.FacturasRectificativas.Value and
          not ( TipoFacturaCtrl.ItemIndex in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ] )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg22, RsMsg23 );
          end
     else If   TipoFacturaCtrl.Editing
          then UpdatePageControlState;
end;

procedure TMntFdvForm.UpdatePageControlState;

var  FacturaRectificativa,
     FacturaArrendamiento,
     Exportacion,
     AsientoResumen,
     MostrarInformacionFiscal : Boolean;

procedure SetupTabSheet( TabSheet : TcxTabSheet; Visible : Boolean );
begin
     TabSheet.TabVisible := Visible;
     TabSheet.Enabled := Visible;
     If   Visible
     then DetalleDatosFiscalesPC.ActivePage := TabSheet;
end;

begin
     If   FormManager.FormPrepared
     then begin

          FacturaRectificativa := TipoFacturaCtrl.ItemIndex in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ];       // Facturas rectificativas
          AsientoResumen := TipoFacturaCtrl.ItemIndex=tfeResumen;                                                              // Asiento resumen de facturas
          FacturaArrendamiento := RegimenOTrascendenciaCtrl.ItemIndex in [ rteArrendamientoSinRetencion, rteArrendamiento ];   // Alquileres sin retención
          Exportacion := RegimenOTrascendenciaCtrl.ItemIndex=rteExportacion;                                                   // Exportación

          MostrarInformacionFiscal := ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or FacturaRectificativa or FacturaArrendamiento or Exportacion or AsientoResumen or SerieFacturacionFields.FacturasRectificativas.Value;

          SetupTabSheet( ExencionTS, Exportacion or ( ClienteFields.Factura_ModeloIVA.Value=micExento ) );
          SetupTabSheet( DatosInmuebleTS, FacturaArrendamiento );
          SetupTabSheet( FacturaRectificadaTS, FacturaRectificativa );
          SetupTabSheet( AsientoResumenTS, AsientoResumen);

          DetalleDatosFiscalesPC.Visible := MostrarInformacionFiscal;  // Si no se desactiva se intentará validar

          end;
end;

procedure TMntFdvForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( tmVenta,
                               LineasAlbaranQueryNroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

procedure TMntFdvForm.ClienteItemClick(Sender: TObject);
begin
     MntClientes( [ FacturaVentasFields.CodigoCliente.Value ] );
end;

end.

