unit a_fvi;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes, ExtCtrls, ComCtrls, Menus,

     cxLookAndFeelPainters, cxButtons, Gim10Fields, DB, nxdb, cxCheckBox, cxDBEdit,
     cxPC, cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
     cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
     cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
     cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar,
     dxmdaset, cxCurrencyEdit, cxSpinEdit, dxSkinsCore,
     dxSkinsDefaultPainters, dxSkinscxPCPainter, cxIndexedComboBox, cxGroupBox,
     cxLookAndFeels, cxLabel, cxPCdxBarPopupMenu, cxNavigator, cxIntegerEdit,
     dxBar, cxScrollBox, cxSplitter, dxBarBuiltInMenu, dxDateRanges,
     cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

     LibUtils,
     AppContainer,
     AppForms,
     DataManager,
     GridTableViewController,

     dmi_iva, dxUIAClasses;

type
  TMntFviForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    SerieCtrl: TcxDBTextEdit;
    AsientoTable: TnxeTable;
    DataPanel: TgxEditPanel;
    NroFacturaCtrl: TcxDBIntegerEdit;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    RetencionesTabSheet: TcxTabSheet;
    CobrosTabSheet: TcxTabSheet;
    ApunteTable: TnxeTable;
    ApunteConsultaTable: TnxeTable;
    BaseRetencionCtrl: TcxDBCurrencyEdit;
    TipoRetencionCtrl: TcxDBSpinEdit;
    ImporteRetencionCtrl: TcxDBCurrencyEdit;
    EfectoCobrarTable: TnxeTable;
    SubcuentaRetencionCtrl: TcxDBTextEdit;
    Panel2: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    Panel1: TcxGroupBox;
    Panel4: TcxGroupBox;
    FormaCobroCtrl: TcxDBTextEdit;
    GenerarEfectosButton: TgBitBtn;
    AsientoDataSource: TDataSource;
    ApunteDataSource: TDataSource;
    EfectoCobrarDataSource: TDataSource;
    ApunteGrid: TcxGrid;
    ApunteGridView: TcxGridDBTableView;
    ApunteGridLevel: TcxGridLevel;
    ApunteGridViewManager: TGridTableViewController;
    EfectoCobrarGrid: TcxGrid;
    EfectoCobrarTableView: TcxGridDBTableView;
    EfectoCobrarGridLevel: TcxGridLevel;
    EfectoCobrarTableViewManager: TGridTableViewController;
    ApunteTableEjercicio: TSmallintField;
    ApunteTableNroAsiento: TIntegerField;
    ApunteTableNroApunte: TSmallintField;
    ApunteTableSubcuenta: TWideStringField;
    ApunteTableCentroCoste: TWideStringField;
    ApunteTableContrapartida: TWideStringField;
    ApunteTableConcepto: TWideStringField;
    ApunteTableTipoApunte: TSmallintField;
    ApunteTablePunteo: TBooleanField;
    ApunteTableBaseImponible: TBCDField;
    ApunteTableTipo: TSmallintField;
    ApunteTableCuotaIVA: TBCDField;
    ApunteTableCuotaRE: TBCDField;
    ApunteTableImporteTotal: TBCDField;
    ApunteGridViewSubcuenta: TcxGridDBColumn;
    ApunteGridViewBaseImponible: TcxGridDBColumn;
    ApunteGridViewTipo: TcxGridDBColumn;
    ApunteGridViewCuotaIVA: TcxGridDBColumn;
    ApunteGridViewImporteTotal: TcxGridDBColumn;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataConcepto: TWideStringField;
    DataSubcuentaRetencion: TWideStringField;
    DataBaseRetencion: TBCDField;
    DataTipoRetencion: TSmallintField;
    DataImporteRetencion: TBCDField;
    DataFormaCobro: TWideStringField;
    LockRangeButton: TgxLockRangeButton;
    ApunteTableDescripcion: TWideStringField;
    ApunteTableTipoIVA: TBCDField;
    ApunteTableFecha: TDateField;
    ApunteGridViewDescripcion: TcxGridDBColumn;
    ApunteGridViewTipoIVA: TcxGridDBColumn;
    ApunteGridViewCentroCoste: TcxGridDBColumn;
    EfectoCobrarTableViewNroEfecto: TcxGridDBColumn;
    EfectoCobrarTableViewEntidad: TcxGridDBColumn;
    EfectoCobrarTableViewFechaVencimiento: TcxGridDBColumn;
    EfectoCobrarTableViewFechaCobro: TcxGridDBColumn;
    EfectoCobrarTableViewImporte: TcxGridDBColumn;
    EfectoCobrarTableViewDescripcion: TcxGridDBColumn;
    EfectoCobrarTableDescripcion: TWideStringField;
    ApunteGridViewCuotaRE: TcxGridDBColumn;
    ApunteGridViewTipoRE: TcxGridDBColumn;
    ApunteTableTipoRE: TBCDField;
    EfectoCobrarTableViewFormaDePago: TcxGridDBColumn;
    EfectoCobrarTableViewNroRemesa: TcxGridDBColumn;
    EfectoCobrarTableViewImpagado: TcxGridDBColumn;
    ApunteTableDebe: TBCDField;
    ApunteTableHaber: TBCDField;
    MainPageControl: TcxPageControl;
    ContenidoTS: TcxTabSheet;
    ConceptoCtrl: TcxDBTextEdit;
    FechaCtrl: TcxDBDateEdit;
    NombreCtrl: TcxDBTextEdit;
    FechaDocumentoCtrl: TcxDBDateEdit;
    PropietarioCtrl: TcxDBTextEdit;
    FiscalTS: TcxTabSheet;
    codigoCtrlCaption: TcxLabel;
    Label2: TcxLabel;
    EstadoLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label8: TcxLabel;
    DescTipoRetencionLabel: TcxLabel;
    Label7: TcxLabel;
    Label16: TcxLabel;
    DescSubcuentaRetencionLabel: TcxLabel;
    DescFormaCobroLabel: TcxLabel;
    Label10: TcxLabel;
    Label23: TcxLabel;
    Label11: TcxLabel;
    Label15: TcxLabel;
    retencionTotalLabel: TcxLabel;
    Label12: TcxLabel;
    Label1: TcxLabel;
    Label3: TcxLabel;
    Label13: TcxLabel;
    Label4: TcxLabel;
    EfectoCobrarTableEjercicio: TSmallintField;
    EfectoCobrarTableSerie: TWideStringField;
    EfectoCobrarTableNroFactura: TIntegerField;
    EfectoCobrarTableNroEfecto: TSmallintField;
    EfectoCobrarTableCliente: TWideStringField;
    EfectoCobrarTableEntidad: TWideStringField;
    EfectoCobrarTableFechaVencimiento: TDateField;
    EfectoCobrarTableFechaCobro: TDateField;
    EfectoCobrarTableConcepto: TWideStringField;
    EfectoCobrarTableEjercicioRemesa: TSmallintField;
    EfectoCobrarTableNroRemesa: TIntegerField;
    EfectoCobrarTableImporte: TBCDField;
    EfectoCobrarTableImporteCobrado: TBCDField;
    EfectoCobrarTableConceptoCobro: TWideStringField;
    EfectoCobrarTableCodigoCliente: TWideStringField;
    EfectoCobrarTableVendedor: TWideStringField;
    EfectoCobrarTableGrupoFacturacion: TWideStringField;
    EfectoCobrarTableRevisado: TBooleanField;
    EfectoCobrarTableImpagado: TBooleanField;
    EfectoCobrarTableCancelado: TBooleanField;
    EfectoCobrarTableVolverAEmitir: TBooleanField;
    EfectoCobrarTableNroEfectoReemitido: TSmallintField;
    EfectoCobrarTableFechaLibramiento: TDateField;
    EfectoCobrarTableFechaEmision: TDateField;
    EfectoCobrarTableFormaDePago: TWideStringField;
    EfectoCobrarTableDiferenciaCambio: TBCDField;
    EfectoCobrarTableGenerarEfectoDiferencia: TBooleanField;
    EfectoCobrarTableSubcuentaDiferencia: TWideStringField;
    EfectoCobrarTableNroEfectoDiferencia: TSmallintField;
    EfectoCobrarTableGastosGestion: TBCDField;
    EfectoCobrarTableGastosDevolucion: TBCDField;
    EfectoCobrarTableSubcuentaGastos: TWideStringField;
    EfectoCobrarTableNroAsientoCartera: TIntegerField;
    EfectoCobrarTableNroAsientoCobro: TIntegerField;
    EfectoCobrarTableFechaCancelacion: TDateField;
    EfectoCobrarTableNroAstoCancelacion: TIntegerField;
    EfectoCobrarTableFechaImpagado: TDateField;
    EfectoCobrarTableNroAsientoImpagado: TIntegerField;
    EfectoCobrarTableAnotacion: TWideMemoField;
    ApunteTableCuentaAnalitica: TWideStringField;
    ApunteGridViewCuentaAnalitica: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    TipoFacturaCtrl: TcxDBIndexedComboBox;
    FacturaTable: TnxeTable;
    FacturaDataSource: TDataSource;
    cxLabel2: TcxLabel;
    RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox;
    FiscalPageControl: TcxPageControl;
    FacturaRectificadaTS: TcxTabSheet;
    DatosInmuebleTS: TcxTabSheet;
    cxGroupBox3: TcxGroupBox;
    EjercicioFraRectificadaCtrl: TcxDBSpinEdit;
    SerieFraRectificadaCtrl: TcxDBTextEdit;
    NroFacturaRectificadaCtrl: TcxDBIntegerEdit;
    Label9: TcxLabel;
    Label17: TcxLabel;
    Label14: TcxLabel;
    Label22: TcxLabel;
    RazonMetodoBox: TcxGroupBox;
    RazonCtrl: TcxDBSpinEdit;
    MetodoCtrl: TcxDBSpinEdit;
    Label19: TcxLabel;
    Label20: TcxLabel;
    DescMetodoLabel: TcxLabel;
    Label21: TcxLabel;
    SituacionInmuebleCtrl: TcxDBIndexedComboBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    ReferenciaCatastralCtrl: TcxDBTextEdit;
    ExencionTS: TcxTabSheet;
    cxLabel5: TcxLabel;
    CausaExencionCtrl: TcxDBIndexedComboBox;
    InversionSujetoPasivoCtrl: TcxDBCheckBox;
    DataInversionSujetoPasivo: TBooleanField;
    AsientoResumenTS: TcxTabSheet;
    cxLabel6: TcxLabel;
    NroFacturaFinalCtrl: TcxDBIntegerEdit;
    TopGroupBox: TcxScrollBox;
    MainTabControl: TcxTabControl;
    SumaBaseImponibleBox: TcxLabel;
    SumaCuotaIVABox: TcxLabel;
    SumaCuotaREBox: TcxLabel;
    SumaRetencionBox: TcxLabel;
    SumaImporteTotalBox: TcxLabel;
    BarManager: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    EditarEccItem: TdxBarButton;
    AnotacionCobroItem: TdxBarButton;
    ClienteItem: TdxBarButton;
    AsientoItem: TdxBarButton;
    cxGroupBox1: TcxGroupBox;
    cxSplitter1: TcxSplitter;
    FechaFraRectificadaBox: TcxLabel;
    ImporteNoSujetoARetencionBox: TcxLabel;
    IntracomunitariaTS: TcxTabSheet;
    cxLabel7: TcxLabel;
    ClaveOperacionIntracomunitariaCtrl: TcxDBIndexedComboBox;
    cxGroupBox2: TcxGroupBox;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    procedure FormManagerInitializeForm;
    procedure EditarEccItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure ClienteItemClick(Sender: TObject);
    procedure AsientoTableNewRecord(DataSet: TDataSet);
    procedure ApunteTableBeforePost(DataSet: TDataSet);
    procedure AsientoTableAfterDelete(DataSet: TDataSet);
    procedure ApunteTableGetRecord(DataSet: TDataSet);
    procedure AsientoTableSetKey(DataSet: TDataSet);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure ApunteTableCalcFields(DataSet: TDataSet);
    procedure ApunteGridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure SucuentaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure SubcuentaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SubcuentaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectoCobrarTableCalcFields(DataSet: TDataSet);
    procedure BaseRetencionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FacturaPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCentroCostePropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure PropietarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ApunteGridViewTipoPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewTipoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewTipoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoRetencionCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ApunteTableFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure ApunteGridViewTipoPropertiesEditValueChanged(
      Sender: TObject);
    procedure ApunteGridViewBaseImponiblePropertiesEditValueChanged(
      Sender: TObject);
    procedure ApunteGridViewCuotaIVAPropertiesEditValueChanged(
      Sender: TObject);
    procedure TipoRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure BaseRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ImporteRetencionCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ConceptoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure ApunteTableNewRecord(DataSet: TDataSet);
    procedure ApunteGridViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure PropietarioCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ApunteGridViewCuotaREPropertiesEditValueChanged(
      Sender: TObject);
    procedure ApunteGridViewCuotaREPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FechaDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure AnotacionCobroItemClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure GenerarEfectosButtonClick(Sender: TObject);
    procedure PropietarioCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerActivateForm;
    procedure ApunteGridViewSubcuentaPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure TipoRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure BaseRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValuePosted(Sender: TObject);
    function AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure AsientoTableUpdateState(DataSet: TDataSet);
    procedure FormaCobroCtrlPropertiesDefaultValue(Sender: TcxCustomEdit);
    procedure NroFacturaRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FraRectificadaValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure MetodoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RazonCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RazonCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure EjercicioFraRectificadaCtrlPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure SerieFraRectificadaCtrlPropertiesChange(Sender: TObject);
    procedure AsientoTableBeforePost(DataSet: TDataSet);
    procedure MemDataSourceDataChange(Sender: TObject; Field: TField);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure PAgeControlButtonClick(Sender: TObject);
    procedure AsientoTableBeforeCancel(DataSet: TDataSet);
    procedure ApunteGridViewCuentaAnaliticaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCuentaAnaliticaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ApunteGridViewCuentaAnaliticaPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure EfectoCobrarTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure TipoRetencionCtrlPropertiesValuePosted(Sender: TObject);
    procedure ApunteTableRemoteDelete(DataSet: TDataSet);
    procedure ApunteTableRemotePost(DataSet: TDataSet);
    procedure AsientoTableRemoteDelete(DataSet: TDataSet);
    procedure AsientoTableRemotePost(DataSet: TDataSet);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure AsientoTableAfterEdit(DataSet: TDataSet);
    procedure AsientoTableAfterInsert(DataSet: TDataSet);
    procedure TipoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FacturaTableNewRecord(DataSet: TDataSet);
    function FormManagerDeleteButton: Boolean;
    procedure RegimenOTrascendenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure SituacionInmuebleCtrlPropertiesChange(Sender: TObject);
    procedure SerieFraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure SerieFraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure NroFacturaFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ApunteGridViewDataControllerSummaryFooterSummaryItemsSummary(ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments; var OutArguments: TcxSummaryEventOutArguments);
    procedure MainTabControlChange(Sender: TObject);
    procedure MainPageControlChange(Sender: TObject);
    procedure AsientoTableGetRecord(DataSet: TDataSet);
    procedure PropietarioCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure PropietarioCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure AsientoTableBeforeScroll(DataSet: TDataSet);
    procedure ApunteTableUpdateState(DataSet: TDataSet);
    procedure AsientoTableBeforeEdit(DataSet: TDataSet);
    procedure AsientoTableBeforeDelete(DataSet: TDataSet);
    procedure MetodoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);

  private

    DataFieldValues : TFieldValuesArray;
    ActualizandoRegistro : Boolean;

    SumaBaseImponible,
    SumaCuotaIVA,
    SumaCuotaRE,
    SumaImporteTotal : Decimal;

    FacturaConBaseExentaIVA,
    RecalculaLinea,
    CambiandoOrigen,
    RecalculaCuotaIVA : Boolean;

    AsientoFacturaRectificadaFields : TAsientoFields;
    ApunteConsultaFields,
    ApunteFields : TApunteFields;
    EfectoCobrarFields : TEfectoCobrarFields;
    TiposRetencionFields,
    TiposIVAFields : TTiposIVAFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    FacturaFields : TFacturaFields;

    FEstadoPresentacion : TEstadoPresentacionSii;

    FDatosClienteDisponibles : Boolean;
    FCodigoPaisIVA,
    FCodigoClienteFactura : String;

    procedure ActualizaDatosRegistro;
    function  ActualizaTotalFactura : Decimal;
    procedure ActualizaMantenimientoAsientos;
    procedure MuestraTotalesFactura;
    procedure MuestraMantenimientoEfecto;
    procedure RecalculaImporteRetencion;
    procedure RecalculaImportesLinea( Force : Boolean = False );
    procedure GeneracionEfectos;
    procedure CompruebaGeneracionEfectos;
    procedure OnFraRectificativaSelected( Target : TcxCustomEdit = nil );
    procedure UpdatePageControlState;
    procedure FichaCliente;
    function ObtenRegistroFactura: Boolean;
    procedure ObtenDatosCliente( Codigo : String );
    function CodigoPaisIVA : String;

  public

    AsientoFields : TAsientoFields;
  end;

var  MntFviForm: TMntFviForm = nil;

procedure MntFacturasEmitidas( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       AppManager,

       EnterpriseDataAccess,

       Gim00Fields,
       Gdm00Dm,
       Gdm10Dm,
       Gdm10Frm,

       b_msg,
       bx_not,

       dmi_ast,
       dmi_fac,

       dm_pga,
       dm_pai,
       dm_sal,
       dm_iva,
       dm_sub,
       dm_ast,
       dm_fac,
       dm_fco,
       dm_ecc,
       dm_cco,
       dm_con,
       dm_cli,
       dm_sdf,
       dm_can,
       dm_rpf,

       cx_sub,
       cx_ret,
       cx_fco,
       cx_fvi,
       cx_cco,
       cx_iva,
       cx_con,
       cx_sdf,
       cx_rrf,
       cx_mrf,
       cx_can,

       a_ast,
       a_sub,
       a_ret,
       a_fco,
       a_cco,
       a_ecc,
       a_iva,
       a_con,
       a_cli,
       a_ace,
       a_sdf,
       a_can,

       l_fvi;

resourceString
        RsMsg1  = 'Asiento nº %d.';
        RsMsg2  = 'N/Fra. Nº %s %d';
        RsMsg3  = 'No puede introducir apuntes sin ningún importe.';
        RsMsg4  = 'El importe sujeto a retención no puede ser superior %s de la factura.';
        RsMsg5  = 'al importe total';
        RsMsg6  = 'a la base imponible';
        RsMsg7  = 'La suma de la base imponible y las cuotas de I.V.A. y R.E. no coincide con el importe total.';
        RsMsg8  = '¿Esta seguro de que desea SUPRIMIR %slos efectos de esta factura?';
        RsMsg9  = 'Los apuntes con tipo de I.V.A. nulo deben tener, al menos, base imponible.';
        RsMsg10 = 'Esta subcuenta no tiene asociada ninguna ficha de cliente / deudor.';
        //..
        RsMsg14 = 'Esta factura tiene efectos a cobrar asignados al cliente o deudor actual.';
        RsMsg15 = 'Antes de modificar el propietario de la factura debe suprimir todos los efectos existentes del propietario anterior.'#13'Suprima los efectos y reintente el proceso.';
        RsMsg16 = 'No se han podido generar los efectos de la factura.';
        RsMsg17 = 'La factura no pertenece al mismo propietario.';
        RsMsg18 = 'No existe ninguna factura con esta serie y número en el ejercicio indicado.';
        RsMsg19 = 'No puede utilizar la factura actual como factura rectificada.';
        RsMsg20 = 'Esta factura consta como presentada.';
        RsMsg21 = '¿Está seguro de que desea poder editarla?'#13'Si modifica el documento, los datos existentes en el registro de la Agencia Tributaria podrían diferir de los de su contabilidad.';
        RsMsg22 = 'Esta factura debe ser de tipo rectificativa.';
        RsMsg23 = 'La serie actual está asignada a facturas rectificativas. Utilícela solo para este tipo de documentos.';
        RsMsg24 = 'No puede suprimir facturas que ya han sido suministradas.';
        //..
        RsMsg27 = 'El número de la factura final tiene que ser mayor que el de la factura actual';
        RsMsg28 = 'El número de la factura actual identifica al primer número de factura del asiento resumen.';
        RsMsg29 = 'No se ha encontrado el registro de la factura de este asiento.';
        RsMsg30 = 'Edite el registro y guárdelo para generar el registro correspondiente.';
        RsMsg31 = 'Para poder consultar la ficha del cliente tiene que validar su subcuenta.';

procedure MntFacturasEmitidas( KeyValues : array of const );
begin
     CreateEditForm( TmntFviForm, mntFviForm, KeyValues, TGds10Frm.LibrosIVASection );
end;

procedure TMntFviForm.FormManagerReportRequest;
begin
     With AsientoFields do
       ListadoFacturasEmitidas( Serie.Value, NroFactura.Value );
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesDefaultValue(Sender: TcxCustomEdit);
begin
     //* 15.05.2009 El uso de <Shift>+<F2> para obtener el valor por defecto se inicia con esta entrada
     If   FDatosClienteDisponibles
     then FormaCobroCtrl.PostEditValue( ClienteFields.Cobro_FormaCobro.Value );
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With FormaCobroCtrl do
       If   ValueIsEmpty( EditValue ) and FDatosClienteDisponibles and AsientoTable.Inserting
       then begin
            CompruebaGeneracionEfectos;
            EditValue := ClienteFields.Cobro_FormaCobro.Value;
            end;
end;

procedure TMntFviForm.ObtenDatosCliente( Codigo : String );
begin
     If   not FDatosClienteDisponibles
     then begin
          FDatosClienteDisponibles := Cliente.ObtenPorSubcuenta( Codigo, ClienteFields );
          FCodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields, FDatosClienteDisponibles )
          end;
end;

function TMntFviForm.CodigoPaisIVA: String;
begin
     If   ( AsientoFields.Propietario.Value<>'' ) and
          ( FCodigoClienteFactura<>AsientoFields.Propietario.Value )
     then begin
          FCodigoClienteFactura := AsientoFields.Propietario.Value;
          ObtenDatosCliente( FCodigoClienteFactura );
          end;
     Result := FCodigoPaisIVA;
end;

procedure TMntFviForm.CompruebaGeneracionEfectos;
begin
     GenerarEfectosButton.Enabled := not ValueIsEmpty( PropietarioCtrl.EditValue ) and ( ActualizaTotalFactura<>0.0 );
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GenerarEfectosButton.Enabled := False;
     If   ValueIsEmpty( DisplayValue )
     then FormaCobroCtrl.ClearDescription
     else begin
          FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
          If   not Error
          then CompruebaGeneracionEfectos;
          end;
end;

procedure TMntFviForm.FormaCobroCtrlPropertiesValuePosted(Sender: TObject);
begin
     GeneracionEfectos;
end;

procedure TMntFviForm.FormManagerActivateForm;
begin
     If   not FormManager.Cancelling
     then EfectoCobrarTable.Refresh;
end;

function TMntFviForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := ( AsientoTable.State=dsBrowse ) and not ValueIsEmpty( AsientoFields.NroFactura.Value );
end;

function TMntFviForm.FormManagerDeleteButton: Boolean;
begin
     Result := True;
     If   FEstadoPresentacion<>erpPendiente
     then begin
          ShowNotification( ntStop, RsMsg24 );
          Abort;
          end;
end;

procedure TMntFviForm.FormManagerInitializeForm;
begin

     ID := idMntFviForm;

     AsientoFields := TAsientoFields.Create( AsientoTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
     AsientoFacturaRectificadaFields := TAsientoFields.Create( Self );
     ApunteConsultaFields := TApunteFields.Create( ApunteConsultaTable );
     ApunteFields := TApunteFields.Create( ApunteTable );
     EfectoCobrarFields := TEfectoCobrarFields.Create( EfectoCobrarTable );

     SetFieldRange( AsientoFields.NroFactura );

     TiposRetencionFields := TTiposIVAFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ClienteFields := TClienteFields.Create( Cliente.DmClienteTable, True );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     ApunteGridViewCentroCoste.Visible := DataModule00.DmEmpresaFields.Contable_CtrosCoste.Value;

     ShowGroupBox( RazonMetodoBox, DataModule00.FacturaElectronica );

     SetColumnsDecimals( [ ApunteGridViewBaseImponible, ApunteGridViewCuotaIVA, ApunteGridViewCuotaRE, ApunteGridViewImporteTotal ] );
     SetColumnDecimals( ApunteGridViewTipoIVA );
     SetColumnDecimals( ApunteGridViewTipoRE, 3 );

     SetColumnDecimals( EfectoCobrarTableViewImporte );

     SetEditControlsDecimals( [ BaseRetencionCtrl, ImporteRetencionCtrl ] );

     If   not DataModule00.DmEmpresaFields.Contable_Retenciones.Value
     then begin
          RetencionesTabSheet.TabVisible := False;
          RetencionTotalLabel.Visible := False;
          SumaRetencionBox.Visible:= False;
          end;

     FormaCobroCtrl.Properties.Required := ( ApplicationContainer.Ejercicio>=2014 ) and DataModule00.DmEmpresaFields.RegimenEspecialCriterioCaja.Value;

     {
     EjercicioFraRectificadaCtrl.Properties.Required := DataModule00.FacturaElectronica or DataModule00.Exportacion;
     NroFacturaRectificadaCtrl.Properties.Required := DataModule00.FacturaElectronica;
     }

     Data.Active := True;

     Asiento.CompruebaEjercicioCerrado( { EditarAsiento } True );

end;

procedure TMntFviForm.AnotacionCobroItemClick(Sender: TObject);
begin
     With AsientoFields do
       MntAnotacionCobroEfectos( [ Ejercicio.Value, Serie.Value, NroFactura.Value, EfectoCobrarFields.NroEfecto.Value ] );
end;

procedure TMntFviForm.ApunteGridViewBaseImponiblePropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewBaseImponible.Editing;
     RecalculaCuotaIVA := True;
end;

procedure TMntFviForm.ApunteGridViewCentroCostePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCentrosCoste( [ Sender.EditingValue ] );
end;

procedure TMntFviForm.ApunteGridViewCentroCostePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntFviForm.ApunteGridViewCentroCostePropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.ApunteGridViewCuentaAnaliticaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentaAnalitica( [ ApunteFields.CentroCoste.Value,  Sender.EditingValue ] );
end;

procedure TMntFviForm.ApunteGridViewCuentaAnaliticaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentasAnaliticas( Sender, ApunteFields.CentroCoste );
end;

procedure TMntFviForm.ApunteGridViewCuentaAnaliticaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CuentaAnalitica.Valida( ApunteFields.CentroCoste.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.ApunteGridViewCuotaIVAPropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewCuotaIVA.Editing;
end;

procedure TMntFviForm.ApunteGridViewCuotaREPropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewCuotaRE.Editing;
end;

procedure TMntFviForm.ApunteGridViewDataControllerSummaryAfterSummary( ASender: TcxDataSummary);
begin

     With ASender do
       If   VarIsNull( FooterSummaryValues[ 0 ] )
       then begin
            SumaBaseImponible := 0.0;
            SumaCuotaIVA := 0.0;
            SumaCuotaRE := 0.0;
            SumaImporteTotal := 0.0;
            end
       else begin
            SumaBaseImponible := FooterSummaryValues[ 0 ];
            SumaCuotaIVA := FooterSummaryValues[ 1 ];
            SumaCuotaRE := FooterSummaryValues[ 2 ];
            SumaImporteTotal := FooterSummaryValues[ 3 ];
            end;

     MuestraTotalesFactura;

     If   ApunteGridView.Focused
     then UpdatePageControlState;

end;

procedure TMntFviForm.ApunteGridViewDataControllerSummaryFooterSummaryItemsSummary(     ASender      : TcxDataSummaryItems;
                                                                                        Arguments    : TcxSummaryEventArguments;
                                                                                    var OutArguments : TcxSummaryEventOutArguments) ;

var  Tipo : SmallInt;
     Porcentaje : Decimal;
     CodigoSubcuenta : String;

begin
     (* Lo dejo como ejemplo, por si vuelve

     // Utilizo el evento del sumatorio para comprobar si hay alguna base exenta

     If   Arguments.SummaryItem.Index=0 // Para que no se repita cuatro veces la comprobación
     then With ApunteGridView.DataController, Arguments do
            begin
            CodigoSubcuenta := GetValue( RecordIndex, ApunteGridViewSubcuenta.Index );
            If   CodigoSubcuenta<>''
            then begin
                 Tipo := VarToInteger( GetValue( RecordIndex, ApunteGridViewTipo.Index ) );
                 Porcentaje := VarToDecimal( GetValue( RecordIndex, ApunteGridViewTipoIVA.Index ) );
                 {
                 If   ( Tipo=0 ) or ( Porcentaje=0.0 )
                 then FExistenBasesExentas := True;
                 }
                 end;
            end;
     *)
end;

procedure TMntFviForm.ApunteGridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   ApunteGridView.DataController.IsEditing
     then RecalculaImportesLinea;
end;

procedure TMntFviForm.ApunteGridViewSubcuentaPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ApunteGridViewSubcuenta do
       If   ValueIsEmpty( EditValue ) and ( ApunteTable.RecordCount=0 )
       then EditValue := '7';
end;

procedure TMntFviForm.FacturaPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFrasEmitidas( AsientoFields.Serie, Sender, qgsLinked );
end;

procedure TMntFviForm.FacturaTableNewRecord(DataSet: TDataSet);
begin

     // Los registros de factura, en la sección contable, se vinculan utilizando el número de asiento

     If   Assigned( FacturaFields ) and not AsientoFields.NroAsiento.IsNull
     then With FacturaFields do
            begin
            Tipo.Value := tfAsiento;
            Ejercicio.Value := AsientoFields.Ejercicio.Value;
            NroRegistro.Value := AsientoFields.NroAsiento.Value;
            end;

end;

procedure TMntFviForm.SituacionInmuebleCtrlPropertiesChange(Sender: TObject);
begin
     ReferenciaCatastralCtrl.Properties.Required := SituacionInmuebleCtrl.ItemIndex in [ 0, 1 ];
end;

procedure TMntFviForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.Editing
     then begin
          ValidateYear( DisplayValue, ErrorText, Error );
          If   not Error
          then Asiento.CompruebaTrimestre( DisplayValue, ErrorText, Error );
          If   not Error and ( AsientoTable.State=dsEdit )
          then Tasa.CompruebaCambioTipoImpositivo( siRepercutido, DisplayValue, AsientoFields.Fecha.Value, ErrorText, Error );
          end;
end;

procedure TMntFviForm.FechaDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [] );
end;

procedure TMntFviForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntFviForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
     If   not Error
     then UpdatePageControlState;
end;

procedure TMntFviForm.UpdatePageControlState;

var  FacturaRectificativa,
     FacturaArrendamiento,
     Exportacion,
     AsientoResumen,
     Intracomunitaria,
     MostrarInformacionFiscal : Boolean;

procedure SetupTabSheet( TabSheet : TcxTabSheet; Visible : Boolean );
begin
     TabSheet.TabVisible := Visible;
     TabSheet.Enabled := Visible;
     If   Visible
     then FiscalPageControl.ActivePage := TabSheet;
end;

begin

     If   Assigned( SerieFacturacionFields )
     then begin

          FacturaRectificativa := TipoFacturaCtrl.ItemIndex in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ];      // Facturas rectificativas
          FacturaArrendamiento := RegimenOTrascendenciaCtrl.ItemIndex in [ rteArrendamientoSinRetencion, rteArrendamiento ];  // Alquileres sin retención
          Exportacion := RegimenOTrascendenciaCtrl.ItemIndex =rteExportacion;                                                 // Exportación
          AsientoResumen := TipoFacturaCtrl.ItemIndex=tfeResumen;                                                             // Asiento resumen de facturas
          Intracomunitaria := FDatosClienteDisponibles and ( ClienteFields.CodigoPais.Value<>CodigoEspaña ) and Pais.Intracomunitario( ClienteFields.CodigoPais.Value );

          MostrarInformacionFiscal := ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or FacturaRectificativa or FacturaArrendamiento or Exportacion or AsientoResumen or SerieFacturacionFields.FacturasRectificativas.Value;
          MainTabControl.HideTabs:= not MostrarInformacionFiscal;

          SetupTabSheet( ExencionTS, Exportacion or ( ClienteFields.Factura_ModeloIVA.Value=micExento ) );
          SetupTabSheet( DatosInmuebleTS, FacturaArrendamiento );
          SetupTabSheet( AsientoResumenTS, AsientoResumen );
          SetupTabSheet( IntracomunitariaTS, Intracomunitaria );
          SetupTabSheet( FacturaRectificadaTS, FacturaRectificativa );

          FiscalTS.Enabled := MostrarInformacionFiscal;       // Si no se desactiva se intentará validar
          If   not FiscalTS.Enabled
          then MainPageControl.ActivePage := ContenidoTS;

          end;
end;

procedure TMntFviForm.SerieFraRectificadaCtrlPropertiesChange(Sender: TObject);
begin
     If   SerieFraRectificadaCtrl.Editing
     then FacturaFields.NroFacturaRectificada.Clear;
end;

procedure TMntFviForm.SerieFraRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntFviForm.SerieFraRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.SubcuentaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCuentas( [ Sender.EditingValue ] );
end;

procedure TMntFviForm.SubcuentaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.ApunteGridViewTipoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntFviForm.ApunteGridViewTipoPropertiesEditValueChanged(Sender: TObject);
begin
     RecalculaLinea := ApunteGridViewTipo.Editing;
     RecalculaCuotaIVA := True;
end;

procedure TMntFviForm.ApunteGridViewTipoPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siRepercutido, ApunteTableFecha.Value, CodigoPaisIVA );
end;

procedure TMntFviForm.ApunteGridViewTipoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siRepercutido, ApunteTableFecha.Value, CodigoPaisIVA, TiposIVAFields );

     {
     If   ValueIsEmpty( DisplayValue ) or ( not Error and ( TiposIVAFields.IVARepercutido.Value=0.0 ) )
     then FacturaConBaseExentaIVA := True;
     }

     If   Assigned( Sender ) and Sender.EditModified
     then begin

          If   FDatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value=micTipoFijo )  // Tipo fijo de I.V.A.
          then DisplayValue := ClienteFields.Factura_TipoFijoIVA.Value;

          If   ValueIsEmpty( DisplayValue )
          then If   ValueIsEmpty( ApunteTableBaseImponible.Value )
               then begin
                    Error := True;
                    ErrorText := RsMsg9;
                    end;
          end;
end;

procedure TMntFviForm.ApunteTableBeforePost(DataSet: TDataSet);

var   SumaTotal : Decimal;

begin
     If   not ( not ApunteGridView.DataController.InCheckBrowseMode and ApunteTable.ControlsDisabled )
     then With ApunteFields do
            begin

            If   Tipo.Value=0
            then ImporteTotal.Value := BaseImponible.Value
            else If   ( BaseImponible.Value=0.0 ) and
                      ( CuotaIVA.Value=0.0 ) and
                      ( CuotaRE.Value=0.0 ) and
                      ( ImporteTotal.Value<>0.0 )
                 then If   ValueIsEmpty( Tipo.Value )
                      then BaseImponible.Value := ImporteTotal.Value
                      else begin

                           Tasa.TipoIVA( Fecha.Value, CodigoPaisIVA, Tipo.Value, TiposIVAFields );

                           If   ( FDatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value<>micConRE ) )
                           then BaseImponible.Value := Redondea( ImporteTotal.Value / ( 1 + ( TiposIVAFields.IVARepercutido.Value / 100.0 ) ) )
                           else BaseImponible.Value := Redondea( ImporteTotal.Value / ( 1 + ( TiposIVAFields.IVARepercutido.Value / 100.0 ) + ( TiposIVAFields.RERepercutido.Value / 100.0 ) ) );

                           CuotaIVA.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.IVARepercutido.Value ) / 100.0 );

                           If   ( FDatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value<>micConRE ) )
                           then CuotaRE.Value := 0.0
                           else CuotaRE.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.RERepercutido.Value ) / 100.0 );

                           BaseImponible.Value := ImporteTotal.Value - CuotaIVA.Value - CuotaRE.Value;
                           end;

            {
            If   AsientoFields.Origen.Value=ofrInversionSP
            then ImporteTotal.Value := BaseImponible.Value
            else begin
                 }
                 SumaTotal := Redondea( BaseImponible.Value + CuotaIVA.Value + CuotaRE.Value );
                 If   SumaTotal<>ImporteTotal.Value
                 then begin
                      ShowNotification( ntStop, RsMsg7, '' );
                      Abort;
                      end;
                 {
                 end;
                 }

            {  //** 03.10.2017  Ahora se permite, porque Haciendo obliga a registrar en el SII las facturas de muestras y entregas a coste cero a las Empresas

            If   ImporteTotal.Value=0.0
            then begin
                 ShowNotification( ntStop, RsMsg3, '' );
                 Abort;
                 end;
            }

            Contrapartida.Value := AsientoFields.Propietario.Value;

            SetSignedValue( Debe, Haber, BaseImponible.Value, True );
            end;

end;

procedure TMntFviForm.ApunteTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( TiposIVAFields ) and ApunteDataSource.Enabled
     then begin
          If   ValueIsEmpty( ApunteTableSubcuenta.Value )
          then ApunteTableDescripcion.Clear
          else ApunteTableDescripcion.Value := Cuenta.Descripcion( ApunteTableSubcuenta.Value, True, False );
          Tasa.TipoIVA( ApunteTableFecha.Value, CodigoPaisIVA, ApunteTableTipo.Value, TiposIVAFields );
          ApunteTableTipoIVA.Value := TiposIVAFields.IVARepercutido.Value;
          If   FDatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value<>micConRE )
          then ApunteTableTipoRE.Value := 0.0
          else ApunteTableTipoRE.Value := TiposIVAFields.RERepercutido.Value;
          end;
end;

procedure TMntFviForm.ApunteTableFilterRecord( DataSet: TDataSet; var Accept: Boolean);
begin
     Accept := ( ApunteTableNroApunte.Value>1 ) and ( ApunteTableTipoApunte.Value=tapManual );
end;

procedure TMntFviForm.ApunteTableGetRecord(DataSet: TDataSet);
begin
     If   Assigned( ApunteFields )
     then With ApunteFields do
            Tasa.TipoIVA( Fecha.Value, CodigoPaisIVA, Tipo.Value, TiposIVAFields );
end;

procedure TMntFviForm.ApunteTableNewRecord( DataSet : TDataSet );
begin
     With ApunteFields do
       begin
       Ejercicio.Value := AsientoFields.Ejercicio.Value;
       NroAsiento.Value := AsientoFields.NroAsiento.Value;
       Fecha.Value := AsientoFields.Fecha.Value;
       TipoApunte.Value := tapManual;
       With Tipo do
         If   FDatosClienteDisponibles
         then case ClienteFields.Factura_ModeloIVA.Value of
                 micExento   : Value := 0;                                 // Exento de I.V.A.
                 micSinRE,
                 micConRE    : Value := Tasa.TipoIVAGlobal( Fecha.Value, CodigoPaisIVA, rgTipoIVAManual );
                 micTipoFijo : Value := ClienteFields.Factura_TipoFijoIVA.Value;
                 end
         else Value := 1;

       end;
end;

procedure TMntFviForm.ActualizaMantenimientoAsientos;
begin
     If   not AsientoTable.DeletingMasterRecord
     then With AsientoFields do
            ActualizaMntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );
end;

procedure TMntFviForm.ApunteTableRemoteDelete(DataSet: TDataSet);
begin
     Asiento.SuprimeApunteFactura( AsientoFields, ApunteFields );
     ActualizaMantenimientoAsientos;
end;

procedure TMntFviForm.ApunteTableRemotePost( DataSet : TDataSet );
begin
     Asiento.ActualizaApunteFactura( AsientoFields, ApunteFields );
     ActualizaMantenimientoAsientos;
end;

procedure TMntFviForm.ApunteTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and ApunteTable.Active
     then begin
          var ExistenApuntes := ApunteTable.RecordCount>0;
          RetencionesTabSheet.Enabled := DataModule00.DmEmpresaFields.Contable_Retenciones.Value and ExistenApuntes;
          CobrosTabSheet.Enabled := ExistenApuntes;
          end;
end;

function TMntFviForm.ActualizaTotalFactura : Decimal;
begin
     If   DataBaseRetencion.Value=0.0        // Es una factura con retención vieja
     then Result := SumaImporteTotal
     else Result := SumaImporteTotal - DataImporteRetencion.Value;

     SumaImporteTotalBox.Caption := StrFormat( Result );
end;

procedure TMntFviForm.MuestraTotalesFactura;
begin

     SumaBaseImponibleBox.Caption := StrFormat( SumaBaseImponible );
     SumaCuotaIVABox.Caption := StrFormat( SumaCuotaIVA );
     SumaCuotaREBox.Caption := StrFormat( SumaCuotaRE );
     SumaRetencionBox.Caption := StrFormat( -DataImporteRetencion.Value );

     ActualizaTotalFactura;
end;

procedure TMntFviForm.RazonCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRazonesRectificacion( Sender );
end;

procedure TMntFviForm.RecalculaImporteRetencion;
begin
     If   Assigned( TiposRetencionFields )
     then DataImporteRetencion.Value := Redondea( ( DataBaseRetencion.Value * TiposRetencionFields.Retencion.Value  ) / 100.0 );
     MuestraTotalesFactura;
end;

procedure TMntFviForm.SucuentaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCuentas( Sender, qgsNormal, True );
end;

procedure TMntFviForm.TipoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   SerieFacturacionFields.FacturasRectificativas.Value and
          not ( TipoFacturaCtrl.ItemIndex in [ tfeRectificativa80_1_2..tfeRectificativaSimplificada ] )
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg22, RsMsg23 );
          end
     else UpdatePageControlState;
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntRetenciones( True );
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesEditValueChanged(Sender: TObject);

var  ValorNulo : Boolean;

begin
     With TipoRetencionCtrl do
       begin

       ValorNulo := ValueIsEmpty( EditValue, varSmallInt );

       SubcuentaRetencionCtrl.Enabled := not ValorNulo;
       BaseRetencionCtrl.Enabled := not ValorNulo;
       ImporteRetencionCtrl.Enabled := not ValorNulo;

       If   Editing and ValorNulo
       then begin
            DataBaseRetencion.Clear;
            SubcuentaRetencionCtrl.Clear;
            DataImporteRetencion.Clear;
            end;

       end;
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With TipoRetencionCtrl do
       If   ValueIsEmpty( EditValue ) and FDatosClienteDisponibles
       then EditValue := ClienteFields.Factura_TipoRet.Value;
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaRetenciones( AsientoFields.Fecha.Value, Sender );
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaRetencion( AsientoFields.Fecha.Value, Sender, DisplayValue, ErrorText, Error, TiposRetencionFields );
end;

procedure TMntFviForm.TipoRetencionCtrlPropertiesValuePosted(Sender: TObject);

var  Subcuenta  : String;

begin

     With TipoRetencionCtrl do
       begin
     
       If   ValueIsEmpty( EditValue, varSmallInt )
       then begin
            DataBaseRetencion.Clear;
            SubcuentaRetencionCtrl.Clear;
            DataImporteRetencion.Clear;
            end
       else begin

            // Tasa.TipoRetencion( EditValue, AsientoFields.Fecha.Value, TiposRetencionFields );

            With TiposRetencionFields do
              begin

              If   CtaRetPracticada.Value=''
              then CtaRetPracticada.Value := CodigoCuentaDefecto( cpCtaRetACuenta );

              If   Desglosar.Value
              then begin
                   Subcuenta := Copy( CtaRetPracticada.Value, 1, 4 ) + Copy( AsientoFields.Propietario.Value, 5, 5 );
                   Cuenta.InsertaSubcuenta( Subcuenta, AsientoFields.Nombre.Value );
                   end
              else Subcuenta := CtaRetPracticada.Value;

              SubcuentaRetencionCtrl.PostEditValue( Subcuenta );

              end;

            If   TiposRetencionFields.SobreTotal.Value
            then DataBaseRetencion.Value := SumaImporteTotal
            else DataBaseRetencion.Value := SumaBaseImponible;

            end;

       RecalculaImporteRetencion;
       ResetTab;
       end;

end;

procedure TMntFviForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With AsientoTable do
       begin

       // KeyValues : TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto

       KeyValues[ 0 ] := taFraEmitida;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;

       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Serie

       KeyValues[ 3 ] := UnAssigned; // NroFactura
       KeyValues[ 4 ] := NroEfectoRegistroFactura;
       end;
end;

procedure TMntFviForm.GeneracionEfectos;

var Str : String;

procedure CancelaProcesoGeneracion;
begin
     With FormaCobroCtrl do
       begin
       SetFocus;
       SelectAll;
       DataBinding.SetModified;  // Esto es para provocar la validación aunque el usuario no modifique el campo
       Abort;
       end;
end;

begin
     If   GenerarEfectosButton.Enabled
     then try

            AsientoTable.Edit;

            If   ValueIsEmpty( FormaCobroCtrl.EditValue )
            then Str := ''
            else Str := 'y volver a generar ';

            If   EfectoCobrar.ExistenEfectos( AsientoFields.Serie.Value, AsientoFields.NroFactura.Value )
            then If   ShowNotification( ntQuestionWarning, Format( RsMsg8, [ Str ] ), '' )<>mrYes
                 then CancelaProcesoGeneracion;

            If   EfectoCobrar.CompruebaEfectos( AsientoFields.Ejercicio.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value )
            then begin

                 If   ValueIsEmpty( FormaCobroCtrl.EditValue )
                 then EfectoCobrar.SuprimeEfectosFactura( AsientoFields.Ejercicio.Value, AsientoFields.Serie.Value, AsientoFields.NroFactura.Value )
                 else If   not EfectoCobrar.GeneraEfectos( AsientoFields.NroAsiento.Value, AsientoFields.Propietario.Value, DataFormaCobro.Value, ActualizaTotalFactura )
                      then CancelaProcesoGeneracion;

                 EfectoCobrarTable.Refresh;
                 EfectoCobrarGrid.SetFocus;

                 end;

          except on E : Exception do
            If   E is EAbort
            then raise
            else begin
                 ShowNotification( ntStop, RsMsg16 );
                 CancelaProcesoGeneracion;
                 end;
          end;
end;

procedure TMntFviForm.MuestraMantenimientoEfecto;
begin
     With AsientoFields do
        MntEfectosCobrar( [ Ejercicio.Value, Serie.Value, NroFactura.Value, EfectoCobrarFields.NroEfecto.Value ] );
end;

procedure TMntFviForm.GenerarEfectosButtonClick(Sender: TObject);
begin
     GeneracionEfectos;
end;

procedure TMntFviForm.ImporteRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   ImporteRetencionCtrl.Editing
     then MuestraTotalesFactura;
end;

procedure TMntFviForm.InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not CambiandoOrigen and
          AsientoTable.Editing and
          ( InversionSujetoPasivoCtrl.Editing )
     then try
            CambiandoOrigen := True;
            If   InversionSujetoPasivoCtrl.Checked
            then AsientoFields.Origen.Value := ofrInversionSP
            else AsientoFields.Origen.Value := ofrSujetoPasivo;
          finally
            CambiandoOrigen := False;
            end;
end;

procedure TMntFviForm.RecalculaImportesLinea( Force : Boolean );
begin
     With ApunteFields do
       If   RecalculaLinea or CambiandoOrigen
       then begin

            If   RecalculaCuotaIVA
            then If   ValueIsEmpty( Tipo.Value )
                 then begin
                      CuotaIVA.Value := 0.0;
                      CuotaRE.Value := 0.0;
                      end
                 else begin
                      Tasa.TipoIVA( Fecha.Value, CodigoPaisIVA, Tipo.Value, TiposIVAFields );
                      CuotaIVA.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.IVARepercutido.Value ) / 100.0 );
                      If   FDatosClienteDisponibles and ( ClienteFields.Factura_ModeloIVA.Value<>micConRE )
                      then CuotaRE.Value := 0.0
                      else CuotaRE.Value := Redondea( ( BaseImponible.Value * TiposIVAFields.RERepercutido.Value  ) / 100.0 );
                      end;

            With ImporteTotal do
              Value := Redondea( BaseImponible.Value + CuotaIVA.Value + CuotaRE.Value );

            ApunteTable.Modified := True;

            RecalculaLinea := False;
            RecalculaCuotaIVA := False;
            end;
end;

procedure TMntFviForm.RegimenOTrascendenciaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     UpdatePageControlState;
end;

procedure TMntFviForm.EditarEccItemClick(Sender: TObject);
begin
     MuestraMantenimientoEfecto;
end;

procedure TMntFviForm.EfectoCobrarTableCalcFields(DataSet: TDataSet);
begin
     EfectoCobrarTableDescripcion.Value := Cuenta.Descripcion( EfectoCobrarTableEntidad.Value, True, False );
end;

procedure TMntFviForm.EfectoCobrarTableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MuestraMantenimientoEfecto;
end;

procedure TMntFviForm.EjercicioFraRectificadaCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With EjercicioFraRectificadaCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := ApplicationContainer.Ejercicio;
end;

procedure TMntFviForm.AsientoItemClick(Sender: TObject);
begin
     With AsientoFields do
       MntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );
end;

procedure TMntFviForm.AsientoTableAfterDelete(DataSet: TDataSet);
begin
     ActualizaMntAsientos( [ ApplicationContainer.Ejercicio, 0 ] );
end;

procedure TMntFviForm.AsientoTableAfterEdit(DataSet: TDataSet);
begin

     //** 27.04.2017 Antes no existía el registro de factura, por lo que debo comprobar si se ha conseguido recuperar antes de intentar editarlo

     If   ObtenRegistroFactura
     then FacturaTable.Edit
     else begin
          FacturaTable.Append;       // El registro de factura no existe, aunque el asiento ya había sido creado : hay que generar un registro sobre la marcha
          FacturaTable.PostAndEdit;
          end;

end;

function TMntFviForm.ObtenRegistroFactura : Boolean;
begin
     Result := FacturaTable.FindKey( [ tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
end;

procedure TMntFviForm.AsientoTableAfterInsert(DataSet: TDataSet);
begin

     FDatosClienteDisponibles := False;
     FCodigoPaisIVA := CodigoEspaña;

     With FacturaTable do
       begin
       Append;
       Edit;
       end;

     RetencionesTabSheet.Enabled
end;

procedure TMntFviForm.AsientoTableBeforeCancel(DataSet: TDataSet);
begin
     // Hay que recuperar los valores originales
     SetRecordFieldValues( Data, DataFieldValues );
end;

procedure TMntFviForm.AsientoTableBeforeDelete(DataSet: TDataSet);
begin
     If   FEstadoPresentacion=erpPendiente
     then RegistroPresentacion.SuprimeRegistroPresentacion( rpFacturaEmitida, '', AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
end;

procedure TMntFviForm.AsientoTableBeforeEdit(DataSet: TDataSet);
begin
     If   not AsientoTable.SettingKey and ( FEstadoPresentacion<>erpPendiente )
     then begin
          Application.ProcessMessages;
          If   ShowNotification( ntQuestionWarning, RsMsg20, RsMsg21 )<>mrYes
          then Abort;
          end;
end;

procedure TMntFviForm.AsientoTableBeforePost(DataSet: TDataSet);
begin
     FacturaTable.Post;
     If   FEstadoPresentacion<>erpPendiente
     then RegistroPresentacion.MarcaComoModificadoRegistroPresentacion( rpFacturaEmitida, '', AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
end;

procedure TMntFviForm.AsientoTableBeforeScroll(DataSet: TDataSet);
begin
     FDatosClienteDisponibles := False;
end;

function TMntFviForm.AsientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := EjercicioActual( AsientoFields.Fecha.Value );
end;

procedure TMntFviForm.AsientoTableGetRecord(DataSet: TDataSet);
begin
     If   AsientoFields.TipoAsiento.Value=taFraEmitida
     then begin
          FEstadoPresentacion := RegistroPresentacion.ObtenEstadoPresentacionSii( rpFacturaEmitida, '', AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
          ActualizaDatosRegistro;
          If   ( AsientoTable.State=dsBrowse ) and not FormManager.FocusingDataPanel and not AsientoFields.NroAsiento.IsNull
          then If   not ObtenRegistroFactura
               then ShowNotification( ntWarning, RsMsg29, RsMsg30 );
          end;
end;

procedure TMntFviForm.AsientoTableNewRecord(DataSet: TDataSet);
begin
     With AsientoFields do
       begin
       NroAsiento.Value := Asiento.ProximoNroAsiento;
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaDocumento.Value := ApplicationContainer.TodayDate;
       end;

     DataConcepto.Value := '';
     DataTipoRetencion.Value := 0;
     DataSubcuentaRetencion.Value := '';
     DataBaseRetencion.Value := 0.0;
     DataImporteRetencion.Value := 0.0;
     DataFormaCobro.Value := '';
     DataInversionSujetoPasivo.Value := AsientoFields.Origen.Value=ofrInversionSP;

end;

procedure TMntFviForm.ActualizaDatosRegistro;

var  TextoEstado : String;

begin

     If   not AsientoTable.RecordOpened    // Si ya está abierto ya se han suprimido los apuntes con información sobre el IVA y retenciones
     then try

            ActualizandoRegistro := True;

            SumaBaseImponible := 0.0;
            SumaCuotaIVA := 0.0;
            SumaCuotaRE := 0.0;
            SumaImporteTotal := 0.0;

            try

              Data.DisableControls;

              Data.Edit;
              Data.ClearFields;

              DescSubcuentaRetencionLabel.Caption := '';

              DataInversionSujetoPasivo.Value := AsientoFields.Origen.Value=ofrInversionSP;

              With ApunteConsultaTable do
                begin


                With AsientoFields do
                  SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );

                First;

                If   not Eof
                then DataConcepto.Value := ApunteConsultaFields.Concepto.Value;

                While not Eof do
                  begin

                  With ApunteConsultaFields do
                    case TipoApunte.Value of
                      tapManual    : begin
                                     DecAdd( SumaBaseImponible, BaseImponible.Value );
                                     DecAdd( SumaCuotaIVA, CuotaIVA.Value );
                                     DecAdd( SumaCuotaRE, CuotaRE.Value );
                                     DecAdd( SumaImporteTotal, ImporteTotal.Value  );
                                     end;
                      tapRetencion : begin
                                     DataSubcuentaRetencion.Value  := Subcuenta.Value;
                                     DataBaseRetencion.Value := BaseImponible.Value;
                                     DataTipoRetencion.Value := Tipo.Value;
                                     DataImporteRetencion.Value := GetSignedValue( Debe, Haber );
                                     end;
                      end;

                  Next;
                  end;

                With EfectoCobrarTable do
                  If   RecordCount=0
                  then DataFormaCobro.Clear
                  else DataFormaCobro.Value := EfectoCobrarFields.FormaDePago.Value;

                end;

              If   not SerieCtrl.IsEditValidated
              then SerieFacturacion.Obten( AsientoFields.Serie.Value, SerieFacturacionFields );

              If   ValueIsEmpty( AsientoFields.NroAsiento.Value )
              then EstadoLabel.Caption := ''
              else begin
                   TextoEstado := Format( RsMsg1, [ AsientoFields.NroAsiento.Value ] );

                   If   FEstadoPresentacion<>erpPendiente
                   then begin
                        StrAdd( TextoEstado, ' (Presentada' );
                        If   FEstadoPresentacion=erpAnulado
                        then StrAdd( TextoEstado, ' y anulada)' )
                        else StrAdd( TextoEstado, ')' );
                        end;

                   EstadoLabel.Caption := TextoEstado;
                   end;

            finally
              // Guardo los valores originales por si el usuario cancela la edición
              DataFieldValues := GetRecordFieldValues( Data );
              Data.EnableControls;
              end;

            MuestraTotalesFactura;

          finally
            ActualizandoRegistro := False;
            end;
end;

procedure TMntFviForm.AsientoTableRemoteDelete(DataSet: TDataSet);
begin
     FacturaTable.Cancel;
     Asiento.SuprimeFacturaEmitida( AsientoFields );
end;

procedure TMntFviForm.AsientoTableRemotePost(DataSet: TDataSet);
begin
     try

       Asiento.ActualizaFactura( AsientoFields,
                                 DataConcepto.Value,
                                 DataSubcuentaRetencion.Value,
                                 DataTipoRetencion.Value,
                                 DataBaseRetencion.Value,
                                 DataImporteRetencion.Value );

       If   not AsientoTable.DeletingMasterRecord
       then With AsientoFields do
              ActualizaMntAsientos( [ Ejercicio.Value, NroAsiento.Value ] );

     except on E : Exception do ShowException( E, Self );
       end;

end;

procedure TMntFviForm.AsientoTableSetKey(DataSet: TDataSet);
begin
     If   not AsientoTable.UpdatingProcess
     then begin

          With AsientoFields do
            begin
            Ejercicio.Value := ApplicationContainer.Ejercicio;
            If   Serie.IsNull
            then Serie.Value :='';
            TipoAsiento.Value := taFraEmitida;
            NroEfecto.Value := NroEfectoRegistroFactura;
            end;

          With Data do
            begin
            Edit;
            ClearFields;
            end;

          EstadoLabel.Caption := '';

          end;
end;

procedure TMntFviForm.AsientoTableUpdateState( DataSet : TDataSet );
begin
     If   FormManager.FormInitialized and not AsientoTable.ControlsDisabled
     then begin
          ApunteDataSource.Enabled := AsientoTable.State<>dsSetKey;
          EfectoCobrarDataSource.Enabled := AsientoTable.State<>dsSetKey;
          ApunteTableUpdateState( nil );
          end;
end;

procedure TMntFviForm.BaseRetencionCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   BaseRetencionCtrl.Editing
     then RecalculaImporteRetencion;
end;

procedure TMntFviForm.BaseRetencionCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With BaseRetencionCtrl do
       If   ValueIsEmpty( EditValue )
       then begin
            If   TiposRetencionFields.SobreTotal.Value
            then EditValue := SumaImporteTotal
            else EditValue := SumaBaseImponible;
            end;
end;

procedure TMntFviForm.BaseRetencionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var   ImporteMaximo : Decimal;

begin
     With BaseRetencionCtrl do
       If   Editing
       then begin
            If   TiposRetencionFields.SobreTotal.Value
            then ImporteMaximo := SumaImporteTotal + DataImporteRetencion.Value
            else ImporteMaximo := SumaBaseImponible;
            If   ( ( ImporteMaximo>0.0 ) and ( ImporteMaximo<DisplayValue ) ) or
                 ( ( ImporteMaximo<0.0 ) and ( ImporteMaximo>DisplayValue ) )
            then begin
                 Value := ImporteMaximo;
                 Error := True;
                 If   TiposRetencionFields.SobreTotal.Value
                 then ErrorText := Format( RsMsg4, [ RsMsg5 ] )
                 else ErrorText := Format( RsMsg4, [ RsMsg6 ] );
                 end;
            If   DisplayValue=0.0
            then ImporteNoSujetoARetencionBox.Caption := ''
            else ImporteNoSujetoARetencionBox.Caption := StrFormat(  ImporteMaximo - DisplayValue, DecimalesMoneda );

            end;
end;

procedure TMntFviForm.ConceptoCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntConceptosApunte( [] );
end;

procedure TMntFviForm.ConceptoCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With ConceptoCtrl do
       If   ValueIsEmpty( EditValue )
       then With AsientoFields do
              EditValue := Format( RsMsg2, [ Serie.Value, NroFactura.Value ] );
end;

procedure TMntFviForm.ConceptoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaConceptosApunte( Sender, qgsNormal, True );
end;

procedure TMntFviForm.ConceptoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   Sender.EditModified
     then ConceptoApunte.CompruebaTexto( DisplayValue, ErrorText, Error );
end;

procedure TMntFviForm.PageControlButtonClick(Sender: TObject);
begin
     MainPageControl.ActivePageIndex := TcxButton( Sender ).Tag;
end;

procedure TMntFviForm.RazonCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     RazonCtrl.Description := Tasa.TextoRazonRectificacion( VarToSmallInt( DisplayValue ) );
end;

procedure TMntFviForm.MainPageControlChange(Sender: TObject);
begin
     MainTabControl.TabIndex := MainPageControl.ActivePageIndex;
end;

procedure TMntFviForm.MainTabControlChange(Sender: TObject);
begin
     MainPageControl.ActivePageIndex := MainTabControl.TabIndex;
end;

procedure TMntFviForm.MemDataSourceDataChange(Sender: TObject;Field: TField);
begin
     With AsientoTable do
       If   not ActualizandoRegistro and ( State=dsEdit )
       then Modified := True;
end;

procedure TMntFviForm.MetodoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaMetodosRectificacion( Sender );
end;

procedure TMntFviForm.MetodoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     MetodoCtrl.Description := Tasa.TextoMetodoRectificacion( VarToSmallInt( DisplayValue ) );
end;

procedure TMntFviForm.NroFacturaFinalCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  NroFacturaFinal : LongInt;

begin
     NroFacturaFinal := VarToInteger( DisplayValue );
     If   NroFacturaFinal<=AsientoFields.NroFactura.Value
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg27, RsMsg28 );
          end;
end;

procedure TMntFviForm.NroFacturaRectificadaCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaFrasEmitidas( nil, Sender, qgsNormal, OnFraRectificativaSelected, AsientoFields.Propietario.Value );
end;

procedure TMntFviForm.FraRectificadaValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

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
                 If    ( Ejercicio=AsientoFields.Ejercicio.Value ) and
                       ( Serie=AsientoFields.Serie.Value ) and
                       ( NroFactura=AsientoFields.NroFactura.Value )
                 then begin
                      Error := True;
                      ErrorText := RsMsg19;
                      end
                 else If   Asiento.ObtenDocumento( taFraEmitida, Ejercicio, '', Serie, NroFactura, NroEfectoRegistroFactura, AsientoFacturaRectificadaFields )
                      then begin
                           If   AsientoFacturaRectificadaFields.Propietario.Value<>AsientoFields.Propietario.Value
                           then begin
                                Error := True;
                                ErrorText := RsMsg17;
                                end
                           else begin
                                FechaFraRectificadaBox.Caption := StrFormatDate( AsientoFacturaRectificadaFields.Fecha.Value, dfDefault2 );
                                EjercicioFraRectificadaCtrl.IsEditValidated := True;
                                SerieFraRectificadaCtrl.IsEditValidated := True;
                                NroFacturaRectificadaCtrl.IsEditValidated := True;
                                end;
                           end
                      else begin
                           Error := True;
                           ErrorText := RsMsg18;
                           end;
                 end;
          end;
end;

procedure TMntFviForm.OnFraRectificativaSelected;
begin
     With CxFviForm do
       begin
       NroFacturaRectificadaCtrl.Clear;  // Para evitar que se valide antes de hora
       EjercicioFraRectificadaCtrl.PostEditValue( QueryEjercicio.Value );
       SerieFraRectificadaCtrl.PostEditValue( QuerySerie.Value );
       NroFacturaRectificadaCtrl.PostEditValue( QueryNroFactura.Value );
       end;
end;

procedure TMntFviForm.PopupMenuPopup(Sender: TObject);
begin
     If   EfectoCobrartableView.Controller.SelectedRowCount=0
     then Abort;
end;

procedure TMntFviForm.PropietarioCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With PropietarioCtrl do
       If   Editing and AsientoTable.Editing
       then AsientoFields.Nombre.Value := Cuenta.Descripcion( EditValue, False, False );
end;

procedure TMntFviForm.PropietarioCtrlPropertiesEnter(Sender: TcxCustomEdit);
begin
     With PropietarioCtrl do
       If   ValueIsEmpty( EditValue )
       then EditValue := '43';
end;

procedure TMntFviForm.PropietarioCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     Fichacliente;
end;

procedure TMntFviForm.PropietarioCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FDatosClienteDisponibles := False;
     Cuenta.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and Assigned( ClienteFields )
     then begin

          ObtenDatosCliente( DisplayValue );

          If   PropietarioCtrl.Editing
          then begin

               If   ( AsientoTable.State=dsEdit ) and
                    ( AsientoFields.Propietario.Value<>VarToStr( DisplayValue ) ) and
                    EfectoCobrar.ExistenEfectos( AsientoFields.Serie.Value, AsientoFields.NroFactura.Value )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg14, RsMsg15 );
                    Exit;
                    end;

               If   FDatosClienteDisponibles and
                    ( AsientoTable.State=dsInsert ) and
                    ( ClienteFields.CodigoPais.Value<>CodigoEspaña )
               then FacturaFields.RegimenOTrascendencia.Value := 1;  // Exportación

               end;

          end;
end;

procedure TMntFviForm.PropietarioCtrlPropertiesValuePosted(Sender: TObject);

var  CodigoProvincia,
     CodigoPais : String;
     VentasOnline,
     Simplificada : Boolean;

begin

     ObtenDatosCliente( AsientoFields.Propietario.Value );

     If   FDatosClienteDisponibles and
          ( AsientoTable.Inserting or ( AsientoFields.Propietario.Value<>AsientoFields.Propietario.OldValue ) )
     then begin

          Simplificada := False;
          VentasOnline := False;

          If   FDatosClienteDisponibles
          then begin
               CodigoProvincia := ClienteFields.CodigoProvincia.Value;
               CodigoPais := ClienteFields.CodigoPais.Value;
               Simplificada := ClienteFields.NIF.Value='';
               VentasOnline := ClienteFields.Factura_ModeloIVA.Value=micVentasOnline;
               end
          else begin
               CodigoProvincia := '';
               CodigoPais := '';
               end;

          Factura.CompletaRegistroFacturaExpedida( CodigoProvincia,
                                                   CodigoPais,
                                                   SerieFacturacionFields.FacturasRectificativas.Value,
                                                   Simplificada,
                                                   VentasOnline,
                                                   FacturaFields );

          UpdatePageControlState;
          end;
end;

procedure TMntFviForm.ClienteItemClick(Sender: TObject);
begin
     FichaCliente;
end;

procedure TMntFviForm.FichaCliente;
begin
     var CodigoSubcuenta := PropietarioCtrl.EditValue;
     If   Length( CodigoSubcuenta ) =9
     then MntClientesPorSubcuenta( CodigoSubcuenta )
     else ShowHintMsg( RsMsg31 );
end;

procedure TMntFviForm.FormManagerNoteRequest;
begin
     MntAnotacion( AsientoFields.Anotacion );
end;

procedure TMntFviForm.FormManagerQueryGridRequest;
begin
     ConsultaFrasEmitidas( AsientoFields.Serie, NroFacturaCtrl, qgsDetached );
end;

procedure TMntFviForm.ApunteGridViewCuotaREPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     With ApunteGridViewCuotaRE do
        If   Editing
        then If   FDatosClienteDisponibles and not ValueIsEmpty( EditValue ) and ( ClienteFields.Factura_ModeloIVA.Value=micTipoFijo )
             then begin
                  Error := True;
                  ErrorText := JoinMessage( RsMsg9, RsMsg10 );
                  end;
end;

end.

