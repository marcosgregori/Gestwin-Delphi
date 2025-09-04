unit a_tck;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics, Generics.Collections,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, cxMaskEdit, cxDropDownEdit, cxCalendar, cxGroupBox, cxLookAndFeels, cxLabel,
    cxCurrencyEdit, dxmdaset, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
    cxScrollBox, cxNavigator, cxIntegerEdit, cxRichEdit, dxBar, dxDateRanges,
    cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

    AppContainer,
    LibUtils,
    AppManager,
    ReportManager,
    DataManager,
    AppForms,
    GridTableViewController,
    Spring,
    CPort,

    Gim10Fields,
    Gim30Fields,

    f_sto,
    f_rdc,

    dmi_iva,
    dmi_mov,
    dmi_sto,

    dm_mov,
    dm_fdv,
    dm_lma,
    dm_sto, dxUIAClasses, cxSplitter;

type

  TComandosVisor = ( cvReset, cvClear, cvTopLine, cvBottomLine );

  TMntTckForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    ButtonContainerPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    BottomPanel: TGridTableViewPanel;
    TopPanel: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidadAjustada: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    ImportarButton: TgBitBtn;
    Panel1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    CentroCostePanel: TgxScrollBoxPanel;
    CentroCosteCtrl: TcxDBTextEdit;
    GridViewDocumentoOrigen: TcxGridDBColumn;
    GridViewNroRegistro: TcxGridDBColumn;
    GridViewNroRegistroOrigen: TcxGridDBColumn;
    FacturarButton: TgBitBtn;
    GridViewUbicacion: TcxGridDBColumn;
    ClienteCtrl: TcxDBTextEdit;
    LockRangeButton: TgxLockRangeButton;
    ConsumosButton: TgBitBtn;
    FacturaDirectaButton: TgBitBtn;
    GridViewRecargo: TcxGridDBColumn;
    TopScrollBox: TcxScrollBox;
    GrupoClientePanel: TgxScrollBoxPanel;
    GrupoClienteCtrl: TcxDBTextEdit;
    VendedorPanel: TgxScrollBoxPanel;
    VendedorCtrl: TcxDBTextEdit;
    RegistroAuxiliarPanel: TgxScrollBoxPanel;
    RegistroAuxiliarCtrl: TcxDBTextEdit;
    TransportistaPanel: TgxScrollBoxPanel;
    TransportistaCtrl: TcxDBTextEdit;
    LineaMovimientoAuxTable: TnxeTable;
    ExportarButton: TgBitBtn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    VisorPanel: TcxGroupBox;
    ImprimirButton: TgBitBtn;
    EntregaACuentaCtrl: TcxDBCurrencyEdit;
    EntregaCtrl: TcxDBCurrencyEdit;
    FormaCobroCtrl: TcxDBTextEdit;
    GridViewPrecioIVA: TcxGridDBColumn;
    NoFacturarCtrl: TcxDBCheckBox;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    GridViewAnotacion: TcxGridDBColumn;
    GridViewImporteTotal: TcxGridDBColumn;
    TituloDocumentoLabel: TcxLabel;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    Label2: TcxLabel;
    Label18: TcxLabel;
    Label6: TcxLabel;
    Label13: TcxLabel;
    Label11: TcxLabel;
    CaptionTotalIVAIncluidoLabel: TcxLabel;
    TotalIVAIncluidoLabel: TcxLabel;
    CaptionDevolucionRestoLabel: TcxLabel;
    DevolucionRestoLabel: TcxLabel;
    CaptionEntregaEfectivoLabel: TcxLabel;
    EntregaEfectivoLabel: TcxLabel;
    Label3: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label14: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label4: TcxLabel;
    Label12: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    GrupoLineaMovimientoTable: TnxeTable;
    GrupoLineaMovimientoTableEjercicio: TSmallintField;
    GrupoLineaMovimientoTableNroOperacion: TIntegerField;
    GrupoLineaMovimientoTableNroPagina: TSmallintField;
    GrupoLineaMovimientoTableCodigoGrupo: TWideStringField;
    GrupoLineaMovimientoTableDescripcion: TWideStringField;
    GrupoLineaMovimientoTableAnotacion: TWideMemoField;
    GrupoLineaDataSource: TDataSource;
    LineaMovimientoTable: TnxeTable;
    LineaMovimientoDataSource: TDataSource;
    LineaMovimientoTableTieneRegistroOrigen: TBooleanField;
    LineaMovimientoTableEjercicio: TSmallintField;
    LineaMovimientoTableNroOperacion: TIntegerField;
    LineaMovimientoTableNroPagina: TSmallintField;
    LineaMovimientoTableNroLinea: TSmallintField;
    LineaMovimientoTableFecha: TDateField;
    LineaMovimientoTableNroRegistro: TUnsignedAutoIncField;
    LineaMovimientoTableAsignacionOrigen: TSmallintField;
    LineaMovimientoTableTipoMovimientoOrigen: TSmallintField;
    LineaMovimientoTableEjercicioOrigen: TSmallintField;
    LineaMovimientoTableNroOperacionOrigen: TIntegerField;
    LineaMovimientoTableNroRegistroOrigen: TIntegerField;
    LineaMovimientoTableUIDArticulo: TGuidField;
    LineaMovimientoTableCodigoArticulo: TWideStringField;
    LineaMovimientoTableCodigoClaseA: TWideStringField;
    LineaMovimientoTableCodigoClaseB: TWideStringField;
    LineaMovimientoTableCodigoClaseC: TWideStringField;
    LineaMovimientoTableLoteFabricacion: TWideStringField;
    LineaMovimientoTableNumeroSerie: TWideStringField;
    LineaMovimientoTableDescripcion: TWideStringField;
    LineaMovimientoTableCodigoAlmacen: TWideStringField;
    LineaMovimientoTableUbicacion: TWideStringField;
    LineaMovimientoTableCantidad: TBCDField;
    LineaMovimientoTableCantidadAjustada: TBCDField;
    LineaMovimientoTableCantidadProcesada: TBCDField;
    LineaMovimientoTablePrecioDivisa: TBCDField;
    LineaMovimientoTableRecargo: TBCDField;
    LineaMovimientoTablePuntoVerde: TBCDField;
    LineaMovimientoTableDescuento: TBCDField;
    LineaMovimientoTableNroCajas: TBCDField;
    LineaMovimientoTableLargo: TBCDField;
    LineaMovimientoTableAncho: TBCDField;
    LineaMovimientoTableAlto: TBCDField;
    LineaMovimientoTableBultos: TBCDField;
    LineaMovimientoTableNoCalcularMargen: TBooleanField;
    LineaMovimientoTableTipoLinea: TWideStringField;
    LineaMovimientoTableOferta: TBooleanField;
    LineaMovimientoTableTara: TBCDField;
    LineaMovimientoTablePeso: TBCDField;
    LineaMovimientoTableImporteBruto: TBCDField;
    LineaMovimientoTableImporteDescuento: TBCDField;
    LineaMovimientoTableImporteNeto: TBCDField;
    LineaMovimientoTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoTableCuotaIVA: TBCDField;
    LineaMovimientoTableCuotaRE: TBCDField;
    LineaMovimientoTablePrecioIVA: TBCDField;
    LineaMovimientoTableImporteTotal: TBCDField;
    LineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTablePrecio: TFloatField;
    GridViewCodigoTipoIVA: TcxGridDBColumn;
    GridViewCuotaIVA: TcxGridDBColumn;
    GridViewCuotaRE: TcxGridDBColumn;
    FirmarButton: TgBitBtn;
    FirmadoLabel: TcxLabel;
    LineaMovimientoTablePesoEnvase: TBCDField;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableFechaAplicacion: TDateField;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    RelacionMovimientoItem: TdxBarButton;
    ActualizarRelacionesItem: TdxBarButton;
    MostrarAnotacionesItem: TdxBarButton;
    FacturaVentaItem: TdxBarButton;
    EntregasACuentaPedidosLabel: TcxLabel;
    CamposLibresScrollBox: TcxScrollBox;
    CLScrollBoxPanel5: TgxScrollBoxPanel;
    CampoLibre5Ctrl: TcxDBTextEdit;
    CLLabel5: TcxLabel;
    CLScrollBoxPanel4: TgxScrollBoxPanel;
    CampoLibre4Ctrl: TcxDBTextEdit;
    CLLabel4: TcxLabel;
    CLScrollBoxPanel3: TgxScrollBoxPanel;
    CampoLibre3Ctrl: TcxDBTextEdit;
    CLLabel3: TcxLabel;
    CLScrollBoxPanel1: TgxScrollBoxPanel;
    CampoLibre1Ctrl: TcxDBTextEdit;
    CLLabel1: TcxLabel;
    CLScrollBoxPanel2: TgxScrollBoxPanel;
    CampoLibre2Ctrl: TcxDBTextEdit;
    CLLabel2: TcxLabel;
    ComPort: TComPort;
    cxGroupBox1: TcxGroupBox;
    AvisoButton: TgBitBtn;
    AnotacionButton: TgBitBtn;
    LineaMovimientoTableFechaCaducidad: TDateField;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    LineaMovimientoTableContribucionRAP: TBCDField;
    AnuladoLabel: TcxLabel;
    DataPanelSplitter: TcxSplitter;
    CantidadTotalPanel: TcxGroupBox;
    CantidadLabel: TcxLabel;
    FooterPanelCantidad: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportFormRequest;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure LineaMovimientoTableAfterEdit(DataSet: TDataSet);
    procedure GridViewAfterSummary(ASender: TcxDataSummary);
    procedure MovimientoTableAfterEdit(DataSet: TDataSet);
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure LineaMovimientoTableCalcFields(DataSet: TDataSet);
    procedure MovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewFocusedItemChanged(Sender: TcxCustomGridTableView;APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure GridViewCodigoAlmacenPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ImportarButtonClick(Sender: TObject);
    procedure MovimientoTableBeforePost(DataSet: TDataSet);
    procedure MovimientoTableRecordChanged(DataSet: TDataSet);
    procedure MovimientoTableUpdateState(DataSet: TDataSet);
    procedure LineaMovimientoTableBeforePost(DataSet: TDataSet);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure CentroCosteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CentroCosteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PopupMenuPopup(Sender: TObject);
    procedure LineaMovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormManagerShowForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure MovimientoTableBeforeScroll(DataSet: TDataSet);
    procedure GridViewFooterSummaryItems(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure GridViewInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure GridExit(Sender: TObject);
    procedure FacturarButtonClick(Sender: TObject);
    procedure GridViewUbicacionPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure EditarDocItemClick(Sender: TObject);
    procedure ClienteCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure ClienteCtrlPropertiesValuePosted(Sender: TObject);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RegistroAuxiliarCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TransportistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ConsumosButtonClick(Sender: TObject);
    procedure LineaMovimientoTableAfterClose(DataSet: TDataSet);
    procedure GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
    procedure ExportarButtonClick(Sender: TObject);
    procedure GridViewNumeroSeriePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure FormManagerInsertRecRequest;
    procedure GridViewCantidadAjustadaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadAjustadaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
    procedure GridViewDimensionPropertiesValuePosted(Sender: TObject);
    procedure GridViewNroCajasPropertiesValuePosted(Sender: TObject);
    procedure GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
    procedure GridViewPrecioPropertiesValuePosted(Sender: TObject);
    procedure FacturaDirectaButtonClick(Sender: TObject);
    procedure FormManagerLabelsRequest;
    procedure GridViewPrecioIVAPropertiesValuePosted(
      Sender: TObject);
    procedure GridViewInitEditValue(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var AValue: TcxEditValue);
    procedure GridViewCantidadAjustadaPropertiesEnter(Sender: TcxCustomEdit);
    procedure LineaMovimientoTableAfterPost(DataSet: TDataSet);
    procedure BottomPanelEnter(Sender: TObject);
    procedure MovimientoTableAfterCancel(DataSet: TDataSet);
    procedure MovimientoTableAfterInsert(DataSet: TDataSet);
    procedure TopPanelEnter(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure KeyPanelEnter(Sender: TObject);
    function MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
    function FormManagerGetAccessLevel: Smallint;
    procedure MovimientoTableOpenRecord(DataSet: TDataSet);
    procedure GridViewLoteFabricacionPropertiesValuePosted(
      Sender: TObject);
    procedure GridViewLoteFabricacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewPrecioPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure DataPanelEnter(Sender: TObject);
    procedure FormManagerFocusedAreaChanged;
    procedure GridViewCodigoClaseAPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigoClaseBPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigoClaseCPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerPreparedForm;
    procedure FacturaVentaItemClick(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure GridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadAjustadaPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    function MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure GridViewPrecioIVAPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewPrecioPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure LineaMovimientoTableAfterOpen(DataSet: TDataSet);
    function MovimientoTableCheckDetailDatasets(Dataset: TDataSet;
      Posting: Boolean): Boolean;
    procedure FormManagerDeleteEmptyHeader(DataSet: TDataSet);
    procedure EntregaCtrlPropertiesValuePosted(Sender: TObject);
    procedure EntregaACuentaCtrlPropertiesValuePosted(Sender: TObject);
    procedure MovimientoTableGetRecord(DataSet: TDataSet);
    procedure GrupoLineaMovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
    procedure GridViewUpdatePropertiesValuePosted(Sender: TObject);
    procedure GrupoLineaMovimientoTableAfterClose(DataSet: TDataSet);
    procedure GridViewImporteTotalGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure ActualizarRelacionesItemClick(Sender: TObject);
    procedure FirmarButtonClick(Sender: TObject);
    procedure FormManagerDestroyForm;
    procedure MovimientoTableRemotePost(DataSet: TDataSet);
    procedure MovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
    function TableViewManagerCanAlterRow: Boolean;
    procedure GridViewImporteTotalGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure LineaMovimientoTableAfterDelete(DataSet: TDataSet);
    procedure MovimientoTableAfterPost(DataSet: TDataSet);
    procedure RelacionMovimientoItemClick(Sender: TObject);
    function TableViewManagerCanShiftRow: Boolean;
    procedure TableViewManagerRowShift(ShiftOperation: TShiftOperation);
    procedure LineaMovimientoTableRecordChanged(DataSet: TDataSet);
    procedure GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
    procedure ComPortException(Sender: TObject;
      TComException: TComExceptions; ComportMessage: string;
      WinError: Int64; WinMessage: string);
    procedure AvisoButtonClick(Sender: TObject);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure FormManagerUpdateButtonsState;
    procedure FormManagerShowCantEditMessage;
    procedure TableViewManagerBeforeValidateTableView(Sender: TObject);
  private

    StockFrame : TStockFrame;
    RiesgoFrame : TRiesgoFrame;

    TotalIVAIncluido,
    Devolucion,
    Resto : Decimal;

    DesglosarLinea,
    ExisteModuloPreventa,
    FTabletFirmaConectado,
    ShowFocusedRowHighlited,
    FActualizandoCamposCalculadosLinea,
    FReajustandoPrecioBase : Boolean;

    ExistenciasArticulo : IExistenciasArticulo;

    BandasVisibles : SmallInt;

    PreciosConIVAIncluido : Boolean;

    FOnDesconectaTabletFirma : Event<TSimpleEvent>;
    FOnCapturaFirma : Event<TFirmaMovimientoEvent>;
	
    TipoMovimientoDestino : TTipoMovimiento;
    CodigoPropietarioDestino,
    SerieDestino : String;
    NroDocumentoDestino : LongInt;
    SoloCantidadesPendientes,
    DocumentoAutomatico : Boolean;

    FCodigoPaisIVA : String;

    FCamposOpcionalesVisibles,
    FCamposLibresVisibles : SmallInt;

	   procedure FijaSeriePorDefecto;
    procedure ActualizaCantidad;
    procedure DoOnTarifaConsumoSelected( Target : TcxCustomEdit = nil );
    procedure DoOnNumeroSerieSelected( Target : TcxCustomEdit = nil );
    procedure DoAplicaTarifa( Target : TcxCustomEdit = nil );
    procedure DoOnLoteProductoSelected( Target : TcxCustomEdit = nil );

    function GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    function GetLineaMovimientoFields : TLineaMovimientoFields;
    procedure SetTabletFirmaConectado( const Value : Boolean );

    procedure GridViewAutoEditChanged;
    procedure ActualizaReferencias;
    procedure ActualizaCamposCalculadosLinea;
    procedure ActualizaEntregasACuentaPedidos;
    procedure ActualizaDevolucion( Entrega, Efectivo : Decimal; MuestraVisor : Boolean = True );
    procedure ActualizaVisibilidadAviso( Visible : Boolean );
    procedure ObtenCliente( Codigo : String );
    procedure MostrarAviso;
    procedure ImportaDatosCapturador( DataPath : String );
    // procedure ImportaDatosBascula;
    procedure ImprimeVisor( Comando : TComandosVisor; Texto : String );
    procedure MuestraNuevaVentaVisor;
    procedure MuestraFinVentaVisor;
    procedure AbreCajon;
    procedure MuestraLineaVisor;
    procedure MuestraTotalesVisor;
    procedure MuestraDevolucionVisor( Entrega : Decimal );
    procedure DoOnExportaDocumento;
    procedure DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera, NoVincularDocumentos  : Boolean; LineArray : TLongIntArray );


  public

    MovimientoFields : TMovimientoFields;
    FGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    FLineaMovimientoFields,
    LineaMovimientoAuxFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;

    CantidadTotal,
    ImporteNetoTotal,
    ImporteNetoAnterior,
    // ImporteTotal,

    EntregasACuenta : Decimal;

    CalcularIVA,
    LoteAsignado,
    FijarClases : Boolean;
    AjustandoCantidad : Boolean;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    SerieActual,
    PropietarioActual : String;
    TasasArray : TTasasArray;

    UltimoTipoMovimientoImportado,
    UltimoTipoMovimientoExportado : TTipoMovimiento;

    PuertoVisorConectado : Boolean;

    procedure ObtenExistencias;
    procedure MuestraRiesgo;
    procedure ReajustaPrecioBase;
    procedure ActualizaRelaciones;
    procedure ActualizaValorCantidad( Value : Decimal );
    function  ObtenUltimoNroLinea : SmallInt;

    procedure DoOnCopyCurrentRecord;
    procedure DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera, NoVincularDocumentos : Boolean; LineArray : TLongIntArray );
    procedure DoSeleccionaDocumentoImportar;
    procedure DoInsertaLineasConsumo( LineList : TList<Integer> );
    procedure DoOnExistenciasSelected( Target : TcxCustomEdit = nil );

    procedure HighliteRow( RowIndex : LongInt );

    property LineaMovimientoFields : TLineaMovimientoFields read GetLineaMovimientoFields;
    property GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields read GetGrupoLineaMovimientoFields;
    property TabletFirmaConectado : Boolean read FTabletFirmaConectado write SetTabletFirmaConectado;

    property OnCapturaFirma : Event<TFirmaMovimientoEvent> read FOnCapturaFirma write FOnCapturaFirma;
    property OnDesconectaTabletFirma : Event<TSimpleEvent> read FOnDesconectaTabletFirma write FOnDesconectaTabletFirma;
  end;

var  MntTckForm : TMntTckForm = nil;

function MntTickets( Values : array of const ) : TMntTckForm;
procedure ActualizaTickets;

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       Printers,
       Math,

       frxPrintDialog,

       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gim00Fields,

       Gdm00Dm,
       Gdm30Dm,

       ParametrosFacturacionIntf,
       MovimientoIntf,

       dm_pga,
       dm_usr,
       dm_ine,
       dm_cls,
       dm_art,
       dm_cli,
       dm_alm,
       dm_tca,
       dm_cco,
       dm_iva,
       dm_ubi,
       dm_sdf,
       dm_gdc,
       dm_tra,
       dm_ven,
       dm_fco,
       dm_rac,
       dm_rcl,
       dm_reg,

       b_msg,
       bx_not,
       b_avs,
       b_cdv,
       b_sdv,
       b_mco,
       b_mve,
       b_trz,
       b_fda,
       b_chc,
       b_edv,

       a_art,
       a_cco,
       a_cli,
       a_cls,
       a_alm,
       a_fdv,
       a_ubi,
       a_sdf,
       a_ven,
       a_gdc,
       a_tra,
       a_fco,
       a_rac,
       a_chc,
       a_mco,
       a_mov,
       a_mve,

       cx_mve,
       cx_cli,
       cx_art,
       cx_alm,
       cx_cco,
       cx_ubi,
       cx_sdf,
       cx_tra,
       cx_gdc,
       cx_ven,
       cx_fco,
       cx_rac,
       cx_nds,
       cx_tcv,
       cx_ldp1,
       cx_ldp2,
       cx_tdv,
       cx_epu,

       e_mov,
       r_mov;

resourceString

   RsMsg1  = 'Mantenimiento de %s';
   RsMsg4  = 'No procede de ningún otro documento';
   RsMsg5  = 'El registro origen de esta línea ya no existe.';
   RsMsg6  = 'Se suprime la referencia al documento origen en la línea actual.';
   RsMsg7  = '&Albaranes de venta que incluyen este %s';
   RsMsg9  = ' pendientes de un cliente';
   RsMsg10 = 'Este ticket consta como facturado pero no existe la factura a la que pertenece.';
   RsMsg11 = 'Cuando guarde el registro se quitará la marca de facturación.';
   RsMsg12 = 'No puede modificar la estructura de albaranes facturados.';
   RsMsg13 = 'Pulse sobre el botón del documento para acceder directamente al mantenimiento del documento origen.';
   RsMsg14 = 'Utilice el botón derecho del ratón para acceder al menú de opciones de la línea.';
   RsMsg15 = 'No hay ninguna cantidad pendiente de servir.';
   RsMsg16 = 'No se ha creado ningún albarán de salida de material.';
   RsMsg17 = 'Ha ocurrido un error durante la creación del albarán. No ha podido ser creado.';
   RsMsg18 = 'Este número de albarán no es correlativo.';
   RsMsg19 = '¿Confirma que desea utilizarlo?';
   RsMsg20 = 'No puede realizar modificaciones en los registros de venta.';
   RsMsg21 = 'Nuevo ticket : <F12> vacío, <Shift>+<F12> de clientes varios.';
   RsMsg22 = 'Nuevo ticket : <F12> de clientes varios, <Shift>+<F12> vacío.';
   RsMsg23 = 'ENTREGA   ';
   RsMsg24 = 'DEVOLUCION';
   RsMsg25 = '    GESTWIN TPV     ';
   RsMsg26 = 'TOTAL     ';
   RsMsg27 = 'No se ha podido guardar el código de %s en el documento.';
   RsMsg28 = 'El valor no se ha podido guardar porque el registro ha sido dado de baja o el fichero ha sido alterado.';
   RsMsg29 = '      GRACIAS       ';
   RsMsg30 = '   POR SU COMPRA    ';
   RsMsg31 = 'No tiene activadas las tarifas.';
   RsMsg32 = 'Acceda al mantenimiento de ''Configuración de Empresas'' y, en la pestaña |Cliente|, active las ''Tarifas por código de tarifa''';
   RsMsg33 = 'Este artículo está en oferta (desde el %s hasta el %s)';
   RsMsg34 = 'El precio y descuento mostrados son los de la oferta fijada en su ficha.';

   RsMsg37 = 'El precio con I.V.A. incluido calculado difiere del introducido manualmente.';
   RsMsg38 = 'Pulse <F11> para convertir el precio con I.V.A. incluído introducido manualmente, en su correspondiente precio base.';

   RsMsg41 = 'Devolución';
   RsMsg42 = 'Resto';
   RsMsg43 = 'Entrega';
   RsMsg44 = 'Efectivo';
   RsMsg45 = 'Impresión de tickets de venta';
   RsMsg46 = 'No se puede modificar esta columna.';
   RsMsg47 = 'El código del artículo y las clases no pueden modificarse cuando la línea se ha importado desde otro documento.';
   RsMsg48 = '¿Confirma que desea cambiar el propietario del documento?';
   RsMsg49 = 'Cuando se modifica el propietario de un documento que ya contiene líneas hay que reajustarlo para tener en cuenta los posibles cambios.';
   RsMsg50 = ''#13'Modifique el precio con I.V.A. includo de la ficha del artículo para incluya en precio válido.';
   RsMsg51 = '¿Está seguro de que desea actualizar las relaciones del documento?';
   RsMsg52 = 'Cuando se actualiza un documento se vuelven a comprobar las relaciones del mismo, como los tipos de I.V.A. de las líneas, recalculando los importes si es necesario.'#13 +
             'Por defecto los documentos conservan los datos impositivos originales aunque se modifique la ficha de los artículos incluídos en él, para que no se produzcan alteraciones en los importes.' ;
   RsMsg53 = 'No se ha podido abrir el puerto %s.';
   RsMsg54 = 'Revise la configuración de su visor.';
   RsMsg55 = 'Se ha producido un error al enviar información al puerto COM.';

   // Parámetros del registro

   ncrMostrarAnotacionesTickets  = 'MostrarAnotacionesTickets';

var   DefaultScrollBoxPanelHeight : SmallInt = 27;
      MaxVisibleBands : SmallInt = 4;
      TopPanelMinHeight : SmallInt = 60;

function MntTickets( Values : array of const ) : TMntTckForm;
begin
     CreateEditForm( TMntTckForm, MntTckForm, Values );  // No incluyo la sección porque se necesitaría importar Gdm20Frm, y ésta unidad es necesario que esté en Gdm30
     Result := MntTckForm;                               // y no en Gdm20 para poder incluirla en Gdm205
end;

procedure ActualizaTickets;
begin
     If   Assigned( MntTckForm )
     then With MntTckForm do
            begin
            BringToFront;
            MovimientoTable.Refresh;
            end;
end;

procedure TMntTckForm.FormManagerInitializeForm;

var  TextoNroDocumento,
     TextoFechaAplicacion : String;
     I : SmallInt;
     CampoLibreCtrlArray : Array of TcxCustomEdit;

procedure SetButtonVisible( Button : TgBitBtn; Value : Boolean );
begin
     Button.Visible := Value;
     If   not Value
     then ButtonContainerPanel.Width := ButtonContainerPanel.Width - ( Button.Width + Button.Margins.Left ); // Solo les pongo margen por la izquierda
end;

procedure SetupCamposLibres( CamposLibres : Array of TcxCustomEdit );

var  I : SmallInt;
     Visible : Boolean;
     CampoLibreCtrl : TcxCustomEdit;

begin
     CamposLibresScrollBox.Visible := False;
     If   DataModule00.DmEmpresaFields.Ventas_CamposLibres.Value
     then begin
          I := 1;
          FCamposLibresVisibles := 0;
          For CampoLibreCtrl in CamposLibres do
            begin
            Visible := DataModule00.DmEmpresaFields.Ventas_CampoLibre[ I ].Value<>'';
            SetupPanelableCtrl( CampoLibreCtrl, Visible );
            If   Visible
            then begin
                 TcxLabel( CampoLibreCtrl.CaptionLabel ).Caption := DataModule00.DmEmpresaFields.Ventas_CampoLibre[ I ].Value;
                 CampoLibreCtrl.Properties.Required := DataModule00.DmEmpresaFields.Ventas_CampoLibreObligatorio[ I ].Value;
                 Inc( FCamposLibresVisibles );
                 end;
            Inc( I );
            end;
          CamposLibresScrollBox.Visible := FCamposLibresVisibles>0;
          end
     else CamposLibresScrollBox.VertScrollBar.Range := 0;
end;

begin

     ID := idMntTckForm;

     {
     If   Assigned( ApplicationContainer.AppSkinPainter )
     then With ApplicationContainer.AppSkinPainter do
            TituloDocumentoLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( True );


     SetDefaultFont( CaptionEntregaEfectivoLabel, 3 );
     SetDefaultFont( EntregaEfectivoLabel, 3 );
     SetDefaultFont( CaptionTotalIVAIncluidoLabel, 3 );
     SetDefaultFont( TotalIVAIncluidoLabel, 3 );
     SetDefaultFont( CaptionDevolucionRestoLabel, 3 );
     SetDefaultFont( DevolucionRestoLabel, 3 );
     }

     FCamposOpcionalesVisibles := 0;

     With DataModule00.DmEmpresaFields do
       begin
       SetupPanelableCtrl( CentroCosteCtrl, Contable_CtrosCoste.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( RegistroAuxiliarCtrl, Cliente_RegAuxiliar.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( CentroCosteCtrl, Contable_CtrosCoste.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( GrupoClienteCtrl, Cliente_GruposFac.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( VendedorCtrl, not Vendedor_ComPorCli.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( TransportistaCtrl, Ventas_Transportista.Value, FCamposOpcionalesVisibles );

       SetEditControlsDecimals( [ EntregaCtrl, EntregaACuentaCtrl ] );

       SetupCamposLibres( [ CampoLibre1Ctrl, CampoLibre2Ctrl, CampoLibre3Ctrl, CampoLibre4Ctrl, CampoLibre5Ctrl ] );

       end;

     // -------

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoAuxFields := TLineaMovimientoFields.Create( LineaMovimientoAuxTable );

     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     With DataModule00 do
       begin
       If   Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarStock, DmEmpresaFields.Ventas_VerStock )
       then begin
            StockFrame := CreaPanelStock( scVentas, TopPanel, GridView );
            TopPanelMinHeight := ScaledToCurrent( StockFrame.Height + 4 );
            end;
       If   Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRiesgoAlbaranes, DmEmpresaFields.Ventas_RiesgoAlbaran )
       then begin
            RiesgoFrame := CreaRiesgoFrame( TopPanel );
            var RiesgoPanelHeight := ScaledToCurrent( RiesgoFrame.Height + 4 );
            If   TopPanelMinHeight<RiesgoPanelHeight
            then TopPanelMinHeight := RiesgoPanelHeight;
            end;
       end;

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       PreciosConIVAIncluido := Articulo_PreciosIVA.Value;

       GridViewNumeroSerie.Visible := Ventas_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       // El mantenimiento de tickets no soporta divisas
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewLargo.Visible := Ventas_Cantidades.Value>0;
       GridViewAncho.Visible := Ventas_Cantidades.Value>0;
       GridViewAlto.Visible := Ventas_Cantidades.Value>1;
       GridViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnDecimals( GridViewCantidadAjustada, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewPuntoVerde ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewRecargo, Ventas_DecRecargo.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       SetColumnsDecimals( [ GridViewPrecioIVA, GridViewImporteTotal ] );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Ventas_DecCajas.Value );

       // Sumatorios

       SetFooterSummaryItemDecimals( GridView, 0, Ventas_DecCantidad.Value );
       SetFooterSummaryItemsDecimals( GridView, [ 1, 2, 3 ] );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then GridViewAlto.Caption := Ventas_NombreCajas.Value
            else GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       If   DataModule00.PreciosEditables
       then begin
            GridViewPrecio.Options.Editing := not PreciosConIVAIncluido;
            GridViewPrecioIVA.Options.Editing := PreciosConIVAIncluido;
            end
       else begin
            GridViewPrecio.Options.Editing := False;
            GridViewPrecioIVA.Options.Editing := False;
            end;

       GridViewPrecioIVA.Options.Focusing := GridViewPrecioIVA.Options.Editing;
       GridViewPrecio.Options.Focusing := GridViewPrecio.Options.Editing;

       If   not DataModule00.DescuentosEditables
       then begin
            GridViewRecargo.Options.Editing := False;
            GridViewDescuento.Options.Editing := False;
            end;

       FormaCobroCtrl.Enabled := Ventas_PagosPedido.Value;
       end;

     If   ParametrosTPVRec.InsAutAlbaranes=0
     then NroDocumentoCtrl.Hint := RsMsg21
     else NroDocumentoCtrl.Hint := RsMsg22;

     RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True, False );

     // Contando las bandas visibles

     If   Screen.Height<768
     then MaxVisibleBands := 2;

     BandasVisibles := Max( GetScrollBoxPanelCount( TopScrollBox ), GetScrollBoxPanelCount( CamposLibresScrollBox ) );

     SetButtonVisible( FirmarButton, Configuracion.ModuloOpcionalActivado( moTabletaFirma ) );

     {
     CaptionEntregaEfectivoLabel.Style.Font.Name := Fuente;
     EntregaEfectivoLabel.Style.Font.Name := Fuente;
     CaptionDevolucionRestoLabel.Style.Font.Name := Fuente;
     DevolucionRestoLabel.Style.Font.Name := Fuente;
     }

     TableViewManager.CheckFixedColumnsStyle;

     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesTickets );

     Grid.ShowHint := True;

     MovimientoTable.SetDefaultRangeValues( [ tmVenta, ApplicationContainer.Ejercicio ], [ tmVenta, ApplicationContainer.Ejercicio ] );
     SetFieldRange( MovimientoFields.NroDocumento );

     ExisteModuloPreventa := ApplicationContainer.IsModuleActive( [ 60 ] );
     SerieActual := #0;
     PropietarioActual := #0;
     PuertoVisorConectado := False;

     If   ParametrosTPVRec.UsarVisor
     then begin
          try
            ComPort.Port := 'COM' + StrInt( ParametrosTPVRec.PuertoCOMVisor );
            ComPort.Open;
            PuertoVisorConectado := ComPort.Connected;
          except
            ShowNotification( ntWarning, Format( RsMsg53, [ ComPort.Port ] ), RsMsg54 );
            end;
          ImprimeVisor( cvReset, '' );
          end;
end;

procedure TMntTckForm.FormManagerDestroyForm;
begin
     FOnDesconectaTabletFirma.Invoke;
     try
       ComPort.Close;
     except
       end;
end;

procedure TMntTckForm.FormManagerInsertRecRequest;
begin
     If   ( ShiftKey and ( ParametrosTPVRec.InsAutAlbaranes=0 ) ) or ( not ShiftKey and ( ParametrosTPVRec.InsAutAlbaranes=1 ) )
     then begin
          FormManager.InsertNewAutoIncrementRecord;
          ClienteCtrl.PostEditValue( '00000' );  // Clientes varios
          FechaCtrl.PostEditValue( ApplicationContainer.TodayDate );
          Grid.SetFocus;
          end
     else FormManager.InsertNewAutoIncrementRecord;
end;

procedure TMntTckForm.FormManagerLabelsRequest;
begin
     With MovimientoFields do
       EtiquetasArticulosDesdeMovimientos( tmVenta, Serie.Value, NroDocumento.Value, Propietario.Value );
end;

procedure TMntTckForm.ObtenExistencias;
begin
     ObtenyMuestraExistencias( GridView,
                               TableViewManager,
                               LineaMovimientoFields,
                               ExistenciasArticulo,
                               MovimientoFields.Propietario.Value,
                               StockFrame );
end;

procedure TMntTckForm.MuestraRiesgo;
begin
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaContenido( ClienteFields );
end;

procedure TMntTckForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( tmVenta, sdTodos, Serie, Sender, qgsLinked );
end;

procedure TMntTckForm.GridEnter(Sender: TObject);
begin
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( False );
end;

procedure TMntTckForm.GridExit(Sender: TObject);
begin
     ObtenExistencias;  // Para ocultar el panel
end;

procedure TMntTckForm.SetTabletFirmaConectado( const Value : Boolean );
begin
     FTabletFirmaConectado := Value;
     FirmarButton.Enabled := Value;
end;

procedure TMntTckForm.GridViewDimensionPropertiesValuePosted(Sender: TObject);
begin
     With GridView.Controller.FocusedColumn do
        If   Editing
        then With LineaMovimientoFields do
               ActualizaValorCantidad( Movimiento.CalculoEspecial( scVentas, Largo.Value, Ancho.Value, Alto.Value ) );
end;

procedure TMntTckForm.GridViewCantidadAjustadaPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   LineaMovimientoTable.State=dsInsert
     then With GridViewCantidadAjustada do
            If   Editing and ValueIsEmpty( EditValue )
            then If   LineaMovimientoFields.TipoMovimientoOrigen.Value<>tmConsumos
                 then EditValue := 1.0
                 else If   Movimiento.DmConsumosClienteTable.FindKey( [ MovimientoFields.Propietario.Value, LineaMovimientoFields.NroRegistroOrigen.Value ] )
                      then EditValue := Movimiento.DmConsumosClienteFields.Cantidad.Value;
end;

procedure TMntTckForm.GridViewCantidadAjustadaPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     // Esta ampliación sólo se aplica cuando existen tan solo clases A y B

     If        DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and
          not  DataModule00.DmEmpresaFields.articulo_ExisteClase[ tcClaseC ].Value
     then If   LineaMovimientoTable.State=dsInsert
            then With LineaMovimientoFields do
                   CodigoClaseB.Value := Clase.ProximoCodigo( tcClaseB, CodigoClaseB.Value );
end;

procedure TMntTckForm.GridViewCantidadAjustadaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Cliente_TarConsumo.Value
     then With LineaMovimientoFields do
            ConsultaTarifaCantidadVentas( Sender,
                                          MovimientoFields.Propietario.Value,
                                          CodigoArticulo.Value,
                                          CodigoClaseA.Value,
                                          CodigoClaseB.Value,
                                          CodigoClaseC.Value,
                                          DoOnTarifaConsumoSelected );
end;

procedure TMntTckForm.GridViewCantidadAjustadaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not AjustandoCantidad
     then If   not ValueIsEmpty( LineaMovimientoFields.CodigoArticulo.Value ) and
               ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual )
          then If   not TableViewManager.ValidatingTableViewAfterEdit and
                    LineaMovimientoTable.Editing and
                    ( Assigned( Sender ) and not Sender.IsEditValidated )
               then StockAlmacen.CompruebaSalida( DisplayValue, GridViewCantidadAjustada, LineaMovimientoFields, ArticuloFields, SerieFacturacionFields, ExistenciasArticulo, ClienteFields.Factura_Tarifa.Value, ErrorText, Error );
end;

procedure TMntTckForm.GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
begin

     If   not AjustandoCantidad
     then try
            AjustandoCantidad := True;
            ActualizaCantidad;
            With GridViewCantidadAjustada do
               If   Editing
               then begin

                     If   ValueIsEmpty( EditValue )
                     then Movimiento.LimpiaImportesLinea( LineaMovimientoFields )

                     //* Modificado para que no se alteren las relaciones cuando la línea proviene de otro documento

                     else If   not ( ( LineaMovimientoTable.State=dsEdit ) and not ValueIsEmpty( LineaMovimientoFields.NroRegistroOrigen.Value ) )
                          then ActualizaRelaciones;

                     ActualizaCamposCalculadosLinea;
                     ReajustaPrecioBase;
                     end;

            finally
              AjustandoCantidad := False;
              end;
end;

procedure TMntTckForm.ActualizaEntregasACuentaPedidos;
begin
     EntregasACuenta := Movimiento.EntregasACuentaPedidosOrigen( MovimientoFields  );
     EntregasACuentaPedidosLabel.Caption := StrFormat( EntregasACuenta );
end;

procedure TMntTckForm.DoOnTarifaConsumoSelected( Target : TcxCustomEdit = nil );
begin
     With CxTcvForm do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableCantidadAjustada.Value := QueryCantidadMinima.Value;
       With LineaMovimientoFields do
         begin
         Precio.Value := QueryPrecio.Value;
         Descuento.Value := QueryDescuento.Value;
         end;
       end;
end;

procedure TMntTckForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntTckForm.GridViewCellClick(     Sender        : TcxCustomGridTableView;
                                             ACellViewInfo : TcxGridTableDataCellViewInfo;
                                             AButton       : TMouseButton;
                                             AShift        : TShiftState;
                                         var AHandled      : Boolean );

var  TipoMovimientoOrigen : TTipoMovimiento;

begin
     If   ( ACellViewInfo.Item.Index=GridViewDocumentoOrigen.Index ) and VarToBoolean( ACellViewInfo.Item.EditValue )
     then begin
          TipoMovimientoOrigen := LineaMovimientoFields.TipoMovimientoOrigen.Value;
          If   TipoMovimientoOrigen in [ tmConsumos, { tmBascula, } tmCapturador ]
          then begin
               case TipoMovimientoOrigen of
                 tmConsumos : MuestraLineaConsumo( MovimientoFields.Propietario.Value,  LineaMovimientoFields.NroRegistroOrigen.Value );
                 end;
               end
          else MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
          end;
end;

procedure TMntTckForm.GridViewCellDblClick(     Sender        : TcxCustomGridTableView;
                                                ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                AButton       : TMouseButton;
                                                AShift        : TShiftState;
                                            var AHandled      : Boolean);
begin
    If   ACellViewInfo.Item=GridViewAnotacion
    then begin
         FormManagerNoteRequest;
         AHandled := True;
         end;
end;

procedure TMntTckForm.ActualizaRelaciones;
begin
     Movimiento.ActualizaRelacionesLineaSalida( MovimientoFields, LineaMovimientoFields, ArticuloFields );
     If   LineaMovimientoFields.Oferta.Value
     then With ArticuloFields do
            ShowHintMsg( Format( RsMsg33, [ StrFormatDate( OfertaFechaInicial.Value, dfDefault2 ), StrFormatDate( OfertaFechaFinal.Value, dfDefault2 ) ] ), RsMsg34 );
end;

procedure TMntTckForm.ActualizarRelacionesItemClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg51, RsMsg52 )=mrYes
     then begin
          Movimiento.RecalculaMovimiento( MovimientoFields );
          MovimientoTable.Refresh;
          end;
end;

procedure TMntTckForm.GridViewCodigoAlmacenPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
begin
     Almacen.SetDefault( Sender, scVentas, ArticuloFields );
end;

procedure TMntTckForm.GridViewCodigoAlmacenPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaAlmacenes( Sender, qgsNormal, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
end;

procedure TMntTckForm.GridViewCodigoAlmacenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
begin
     LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );
end;

procedure TMntTckForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.GridViewCodigoArticuloPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     // Esta ampliación sólo se aplica cuando existen clase A y B

     If        DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and
          not  DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseC ].Value
     then With LineaMovimientoAuxTable do
            If   ( LineaMovimientoTable.State=dsInsert ) and
                 ( LineaMovimientoFields.NroLinea.Value<>1 )
            then begin
                 IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                 With LineaMovimientoFields do
                   If   FindKey( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value - 1 ] )
                   then begin
                        CodigoArticulo.Value := LineaMovimientoAuxFields.CodigoArticulo.Value;
                        CodigoClaseA.Value := LineaMovimientoAuxFields.CodigoClaseA.Value;
                        CodigoClaseB.Value := Clase.ProximoCodigo( tcClaseB, LineaMovimientoAuxFields.CodigoClaseB.Value );
                        Descripcion.Value := LineaMovimientoAuxFields.Descripcion.Value;
                        CodigoAlmacen.Value := LineaMovimientoAuxFields.CodigoAlmacen.Value;
                        Cantidad.Value := LineaMovimientoAuxFields.Cantidad.Value;
                        Precio.Value := LineaMovimientoAuxFields.Precio.Value;
                        Descuento.Value := LineaMovimientoAuxFields.Descuento.Value;
                        GridView.Controller.FocusedColumn := GridViewCantidadAjustada;
                        end;
                 end;
end;
procedure TMntTckForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntTckForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodArticulo : String;

begin
     With GridViewCodigoArticulo do
       If   Editing and not ValueIsEmpty( DisplayValue )
       then begin
            CodArticulo := VarToStr( DisplayValue );
            If   Articulo.CodigoBarras( CodArticulo, CodClaseA, CodClaseB, CodClaseC, FijarClases, ArticuloFields )
            then DisplayValue := CodArticulo;
            end;
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
     If   not Error
     then FacturaVentas.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );
end;

procedure TMntTckForm.GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);

var  PrecioBase : Double;

begin

      With GridViewCodigoArticulo do
       If   Editing
       then begin
	        
			         try

              LineaMovimientoTable.DisableControls;

              If   FijarClases
              then begin
                   LineaMovimientoFields.CodigoClaseA.Value := CodClaseA;
                   LineaMovimientoFields.CodigoClaseB.Value := CodClaseB;
                   LineaMovimientoFields.CodigoClaseC.Value := CodClaseC;
                   end;

              LineaMovimientoFields.NumeroSerie.Value := '';
              LineaMovimientoFields.LoteFabricacion.Value := '';
              LineaMovimientoFields.Descripcion.Value := ArticuloFields.Descripcion.Value;
              LineaMovimientoFields.CodigoAlmacen.Value := Almacen.AlmacenPorDefecto( scVentas, ArticuloFields );
              LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );

              If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value
              then ActualizaValorCantidad( LineaMovimientoFields.NroCajas.Value * ArticuloFields.UnidadesPorCaja.Value );

              If   DataModule00.DmEmpresaFields.Ventas_Cantidades.Value>0
              then begin
                   LineaMovimientoFields.Largo.Value := ArticuloFields.Largo.Value;
                   LineaMovimientoFields.Ancho.Value := ArticuloFields.Ancho.Value;
                   end;

              If   DataModule00.DmEmpresaFields.Ventas_Cantidades.Value>1
              then LineaMovimientoFields.Alto.Value := ArticuloFields.Alto.Value;

              LineaMovimientoFields.CantidadAjustada.Value := 1.0;
              LineaMovimientoFields.Cantidad.Value := -1.0;  // ActualizaCantidad;
            
              Movimiento.LimpiaImportesLinea( LineaMovimientoFields );

              If   LineaMovimientoFields.Cantidad.Value<>0.0
              then ActualizaRelaciones;

              // Verifico el precio con I.V.A. incluido por si el que hay en la ficha no es válido

              If   PreciosConIVAIncluido and
                   ( LineaMovimientoFields.Precio.Value<>0.0 )
              then Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                                    LineaMovimientoFields.Cantidad.Value,
                                                    LineaMovimientoFields.PrecioIVA.Value,
                                                    PrecioBase,
                                                    ClienteFields.Factura_ModeloIVA.Value=micConRE );

              ActualizaCamposCalculadosLinea;

           finally
              LineaMovimientoTable.EnableControls;
              GridView.DataController.UpdateData;
              end;

            ObtenExistencias;
            end;

     FijarClases := False;

end;

procedure TMntTckForm.GridViewCodigoClaseAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseA, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GridViewCodigoClaseBPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseB, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GridViewCodigoClaseCPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Clase.Valida( tcClaseC, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntTckForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   ShowFocusedRowHighlited and AViewInfo.GridRecord.Focused
     then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntTckForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaClases( TNroClase( GridView.Controller.FocusedColumn.Tag ), CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MovimientoFields.Propietario.Value, Sender );
end;

procedure TMntTckForm.ActualizaReferencias;
begin

     // Debido a que el sumatorio de la rejilla es un evento que ocurre antes de que se puedan validar
     // los valores de la cabecera me veo obligado a utilizar esta función de actualización de referencias ....

     If   Assigned( ClienteFields ) and
          not ValueIsEmpty( MovimientoFields.Propietario.Value ) and
          ( ( SerieActual<>MovimientoFields.Serie.Value ) or ( PropietarioActual<>MovimientoFields.Propietario.Value ) )
     then begin

          If   SerieActual<>MovimientoFields.Serie.Value
          then SerieFacturacion.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields, False );
          SerieActual := MovimientoFields.Serie.Value;

          ObtenCliente( MovimientoFields.Propietario.Value );

          CalcularIVA := not ( ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or SerieFacturacionFields.ExentoIVA.Value );
          end;
end;

procedure TMntTckForm.ActualizaDevolucion( Entrega,
                                           Efectivo     : Decimal;
                                           MuestraVisor : Boolean = True );
begin

     Devolucion := 0.0;
     Resto := 0.0;

     CaptionEntregaEfectivoLabel.Visible := ( Entrega<>0.0 ) or ( Efectivo<>0.0 );
     EntregaEfectivoLabel.Visible := CaptionEntregaEfectivoLabel.Visible;
     CaptionDevolucionRestoLabel.Visible := CaptionEntregaEfectivoLabel.Visible;
     DevolucionRestoLabel.Visible := CaptionEntregaEfectivoLabel.Visible;

     If   Entrega<>0.0
     then begin
          Devolucion := Entrega - TotalIVAIncluido;
          CaptionEntregaEfectivoLabel.Caption := RsMsg43;  // Entrega
          EntregaEfectivoLabel.Caption := StrFormat( Entrega, DecimalesMoneda );
          CaptionDevolucionRestoLabel.Caption := RsMsg41;  // Devolución
          CaptionDevolucionRestoLabel.Style.TextColor:= clYellow;
          DevolucionRestoLabel.Style.TextColor:= clYellow;
          DevolucionRestoLabel.Caption := StrFormat( Devolucion, DecimalesMoneda );
          If   MuestraVisor
          then MuestraDevolucionVisor( Entrega );
          end
     else If   Efectivo<>0.0
          then begin
               Resto := TotalIVAIncluido - Efectivo;
               CaptionEntregaEfectivoLabel.Caption := RsMsg44;  // Efectivo
               EntregaEfectivoLabel.Caption := StrFormat( Efectivo, DecimalesMoneda );
               CaptionDevolucionRestoLabel.Caption := RsMsg42;  // Resto
               CaptionDevolucionRestoLabel.Style.TextColor:= $008080FF;
               DevolucionRestoLabel.Style.TextColor:= $008080FF;
               DevolucionRestoLabel.Caption := StrFormat( Resto, DecimalesMoneda );

               end;
end;

procedure TMntTckForm.ReajustaPrecioBase;

var   PrecioBase : Double;
      Cantidad,
      ImporteIVAIncluido : Decimal;

begin
     If   not FReajustandoPrecioBase
     then try
            FReajustandoPrecioBase := True;
            If   PreciosConIVAIncluido
            then begin
                 Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                                  LineaMovimientoFields.Cantidad.Value,
                                                  GridViewPrecioIVA.EditValue,
                                                  PrecioBase,
                                                  ClienteFields.Factura_ModeloIVA.Value=micConRE );
                 GridViewPrecio.EditValue := PrecioBase;
                 ActualizaCamposCalculadosLinea;
                 end;
         finally
           FReajustandoPrecioBase := False;
           end;
end;

procedure TMntTckForm.ActualizaCamposCalculadosLinea;
begin
     If   not FActualizandoCamposCalculadosLinea
     then try
            FActualizandoCamposCalculadosLinea := True;
            Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );
            GridView.DataController.UpdateData;
          finally
            FActualizandoCamposCalculadosLinea := False;
            end;
end;

procedure TMntTckForm.BottomPanelEnter(Sender: TObject);
begin
     MuestraTotalesVisor;
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( True, MovimientoTable.Inserting );
end;

procedure TMntTckForm.GridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   GridView.DataController.IsEditing and TabKey and not ShiftKey
     then If   AFocusedItem=GridViewDescripcion
          then begin
               If   GridViewDescripcion.EditValue<>''
               then With GridView.Controller do
                      FocusedColumnIndex := FocusedColumnIndex + 1;
               end
          else If   ( APrevFocusedItem=GridViewCantidadAjustada ) and ValueIsEmpty( GridViewCantidadAjustada.EditValue )
               then GridView.Controller.GoToNext( True );

end;

procedure TMntTckForm.GridViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                    APrevFocusedRecord,
                                                    AFocusedRecord                : TcxCustomGridRecord;
                                                    ANewItemRecordFocusingChanged : Boolean );
begin
     If   MovimientoTable.Editing
     then begin
          ObtenExistencias;
          FormManagerUpdateButtonsState;
          GridViewAutoEditChanged;
          end;
end;

procedure TMntTckForm.GridViewAutoEditChanged;

var  FocusedRecord : TcxCustomGridRecord;
     ExisteDocumentoOrigen,
     DatosModificables : Boolean;

begin
     FocusedRecord := GridView.Controller.FocusedRecord;
     If   Assigned( FocusedRecord )
     then begin

          ExisteDocumentoOrigen := not ValueIsEmpty( FocusedRecord.Values[ GridViewNroRegistroOrigen.Index ] );

          // TableViewManager.DocumentActive := ExisteDocumentoOrigen;

          DatosModificables := MovimientoDataSource.AutoEdit;

          SetColumnsEditingOption( GridView, DatosModificables );

          // Las columnas clave no se pueden modificar si la línea proviene de otro documento

          If   DatosModificables
          then begin
               GridViewCodigoArticulo.Properties.ReadOnly := ExisteDocumentoOrigen;
               GridViewCodigoClaseA.Properties.ReadOnly := ExisteDocumentoOrigen;
               GridViewCodigoClaseB.Properties.ReadOnly := ExisteDocumentoOrigen;
               GridViewCodigoClaseC.Properties.ReadOnly := ExisteDocumentoOrigen;
               end;

          // El lote y el número se serie se pueden modificar siempre

          GridViewLoteFabricacion.Properties.ReadOnly := False;
          GridViewNumeroSerie.Properties.ReadOnly := False;

          end
     else SetColumnsEditingOption( GridView, True );

end;

procedure TMntTckForm.GridViewImporteTotalGetCellHint(       Sender           : TcxCustomGridTableItem;
                                                             ARecord          : TcxCustomGridRecord;
                                                             ACellViewInfo    : TcxGridTableDataCellViewInfo;
                                                       const AMousePos        : TPoint;
                                                       var   AHintText        : TCaption;
                                                       var   AIsHintMultiLine : Boolean;
                                                       var   AHintTextRect    : TRect );

var  CodigoTipoIVA : SmallInt;
     HintText : String;

begin
     If   VarToDecimal( ARecord.Values[ GridViewCantidadAjustada.Index ] )<>0.0
     then begin
          CodigoTipoIVA := ARecord.Values[ GridViewCodigoTipoIVA.Index ];
          Tasa.TipoIVA( MovimientoFields.Fecha.Value, FCodigoPaisIVA, CodigoTipoIVA, TiposIVAFields );

          HintText :=  'I.V.A. = ' + StrFormat( TiposIVAFields.IVARepercutido.Value, 1 ) + '%';
          If  ClienteFields.Factura_ModeloIVA.Value=micConRE
          then StrAdd( HintText, ', R.E. = ' + StrFormat( TiposIVAFields.RERepercutido.Value, 1 ) + '%' );

          AHintText := HintText;
          AIsHintMultiLine := False;
          AHintTextRect.Top := AHintTextRect.Top + ACellViewInfo.Height;
          end;
end;

procedure TMntTckForm.GridViewImporteTotalGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporteTotal.Index ] ), DecimalesMoneda, True );
end;

procedure TMntTckForm.GridViewInitEdit(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
     ObtenExistencias;

     If   LineaMovimientoTable.State<>dsInsert    // El usuario está modificando la línea
     then MuestraLineaVisor;

     // Estos mensajes son solo para que el usuario sepa el motivo por el que no se pueden editar

     If   AItem.Properties.ReadOnly
     then If   ( AItem=GridViewCodigoArticulo ) or
               ( AItem=GridViewCodigoClaseA ) or
               ( AItem=GridViewCodigoClaseB ) or
               ( AItem=GridViewCodigoClaseC )
          then ShowHintMsg( RsMsg46, RsMsg47 );

end;

procedure TMntTckForm.GridViewInitEditValue(     Sender : TcxCustomGridTableView;
                                                 AItem  : TcxCustomGridTableItem;
                                                 AEdit  : TcxCustomEdit;
                                             var AValue : TcxEditValue );
begin
     If   AItem=GridViewPrecioIVA
     then AValue := GridView.DataController.Values[ GridView.DataController.EditingRecordIndex, GridViewPrecioIVA.Index ];
end;

procedure TMntTckForm.GridViewLoteFabricacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value or
          DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value
     then ConsultaLotesProductos2( Sender, GridViewCodigoArticulo.EditValue, MovimientoFields.Fecha.Value, DoOnLoteProductoSelected )
     else ConsultaLotesProductos1( Sender, GridViewCodigoArticulo.EditValue );
end;

procedure TMntTckForm.GridViewLoteFabricacionPropertiesValuePosted(Sender: TObject);
begin
     LoteAsignado := False;
end;

procedure TMntTckForm.ActualizaValorCantidad( Value : Decimal );
begin
     GridViewCantidadAjustada.EditValue := Value;
     LineaMovimientoFields.Cantidad.Value := -Value;
     ActualizaCamposCalculadosLinea;
     ActualizaRelaciones;
end;

procedure TMntTckForm.AvisoButtonClick(Sender: TObject);
begin
     MostrarAviso;
end;

procedure TMntTckForm.MostrarAviso;
begin
     ShowWarning( ClienteFields.Aviso );
end;

procedure TMntTckForm.GridViewAfterSummary(ASender: TcxDataSummary);

var  SumaTasas : TTasaRecord;

begin

     If   Assigned( MovimientoFields ) and
          Assigned( ClienteFields ) and ClienteFields.Initialized
     then With ASender, DataModule00.DmEmpresaFields  do
            begin

            ActualizaReferencias;

            CantidadTotal := VarToDecimal( FooterSummaryValues[ 0 ] );
            // ImporteTotal := VarToDecimal( FooterSummaryValues[ 1 ] );

            FacturaVentas.AcumulaValoresImpositivos( TasasArray, MovimientoFields.Fecha.Value, ClienteFields.Factura_ModeloIVA.Value, CalcularIVA, SumaTasas );

            ImporteNetoTotal := SumaTasas.BaseImponible;
            TotalIVAIncluido := SumaTasas.Importe;

            If   PreciosConIVAIncluido
            then TotalIVAIncluido := SumaTasas.Importe
            else TotalIVAIncluido := Redondea( SumaTasas.BaseImponible ) +
                                     Redondea( SumaTasas.BaseNoSujetaDto ) +
                                     Redondea( SumaTasas.CuotaIVA ) +
                                     Redondea( SumaTasas.CuotaRE );
            
            TotalIVAIncluidoLabel.Caption := StrFormat( SumaTasas.Importe, DecimalesMoneda );
            FooterPanelCantidad.Caption := StrFormat( CantidadTotal, Ventas_DecCantidad.Value, False );
            ActualizaDevolucion( MovimientoFields.EntregaEfectivo.Value,MovimientoFields.EntregaACuenta.Value, False );
            end;

     Movimiento.InicializaValoresImpositivos( TasasArray );
end;
procedure TMntTckForm.GridViewNroCajasPropertiesValuePosted(Sender: TObject);
begin
     With GridViewNroCajas do
       If   Editing
       then ActualizaValorCantidad( EditValue * ArticuloFields.UnidadesPorCaja.Value );
end;

procedure TMntTckForm.GridViewNumeroSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaNumerosSerie( Sender, GridViewCodigoArticulo.EditValue, DoOnNumeroSerieSelected );
end;

procedure TMntTckForm.DoOnNumeroSerieSelected( Target : TcxCustomEdit = nil );
begin
     With CxNdsForm do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableUIDArticulo.Value := QueryUIDArticulo.Value;
       end;
end;

procedure TMntTckForm.GridViewPrecioIVAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Precio : Double;

begin
     If   Assigned( Sender ) and Sender.Editing and Sender.ModifiedAfterEnter
     then Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                           LineaMovimientoFields.Cantidad.Value,
                                           Sender.EditingValue,
                                           Precio,
                                           ClienteFields.Factura_ModeloIVA.Value=micConRE );
end;

procedure TMntTckForm.GridViewPrecioIVAPropertiesValuePosted(Sender: TObject);
begin
     If   GridViewPrecioIVA.Editing
     then ReajustaPrecioBase;
end;

procedure TMntTckForm.GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg38;
end;

procedure TMntTckForm.GridViewPrecioPropertiesExtendedFunction(Sender: TcxCustomEdit);

var  Precio : Double;

begin
     If   Sender.DoEditing
     then With ArticuloFields do
            try
               FReajustandoPrecioBase := True;
               Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                                LineaMovimientoFields.Cantidad.Value,
                                                Sender.EditingValue,
                                                Precio,
                                                ClienteFields.Factura_ModeloIVA.Value=micConRE );
               With Sender do
                 begin
                 PostEditValue( RedondeaExt( Precio, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value ) );
                 SelectAll;
                 end;
            finally
               FReajustandoPrecioBase := False;
            end;
end;

procedure TMntTckForm.GridViewPrecioPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value
     then ConsultaTarifasVenta( Sender, LineaMovimientoFields.CodigoArticulo.Value, DoAplicaTarifa )
     else ShowHintMsg( RsMsg31, RsMsg32, Sender );
end;

procedure TMntTckForm.GridViewPrecioPropertiesValuePosted(Sender: TObject);
begin
     With GridViewPrecio do
       If   not FReajustandoPrecioBase and Editing
       then ReajustaPrecioBase;  // Y también se recalcula precioIVA
     ActualizaCamposCalculadosLinea;
end;

procedure TMntTckForm.GridViewUpdatePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntTckForm.DataPanelEnter(Sender: TObject);
begin
     If   Assigned( RiesgoFrame )
     then begin
          RiesgoFrame.ActualizaEstado( True, MovimientoTable.Inserting );
          MuestraRiesgo;
          end;
end;

procedure TMntTckForm.DoAplicaTarifa( Target : TcxCustomEdit = nil );
begin
     LineaMovimientoTable.Edit;

     With CxTdvForm do
       begin
       If   QueryPrecio.Value<>0.0
       then LineaMovimientoTablePrecio.Value := QueryPrecio.Value;
       If   QueryRecargo.Value<>0.0
       then LineaMovimientoTableRecargo.Value := QueryRecargo.Value;
       If   QueryDescuento.Value<>0.0
       then LineaMovimientoTableDescuento.Value := QueryDescuento.Value;
       end;

end;

procedure TMntTckForm.DoOnLoteProductoSelected( Target : TcxCustomEdit = nil );
begin
     With CxLdp2Form do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableUIDArticulo.Value := QueryUIDArticulo.Value;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       LineaMovimientoTableTipoMovimientoOrigen.Value := QueryTipoMovimiento.Value;
       LineaMovimientoTableEjercicioOrigen.Value := QueryEjercicio.Value;
       LineaMovimientoTableNroOperacionOrigen.Value := QueryNroOperacion.Value;
       LineaMovimientoTableNroRegistroOrigen.Value := QueryNroRegistro.Value;
       LoteAsignado := True;
       end;
end;

procedure TMntTckForm.GridViewFooterSummaryItems(     ASender      : TcxDataSummaryItems;
                                                      Arguments    : TcxSummaryEventArguments;
                                                  var OutArguments : TcxSummaryEventOutArguments );

var  CodigoArticulo : String;
     TipoDeIVA : SmallInt;

begin
     If   Assigned( ArticuloFields ) and ( Arguments.SummaryItem.Index=2 )
     then With GridView.DataController, Arguments do
            begin
            TipoDeIVA := VarToSmallInt( GetValue( RecordIndex, GridViewCodigoTipoIVA.Index ) );
            DecAdd( TasasArray[ TipoDeIVA ].BaseImponible, VarToDecimal( GetValue( RecordIndex, GridViewImporte.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].CuotaIVA, VarToDecimal( GetValue( RecordIndex, GridViewCuotaIVA.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].CuotaRE, VarToDecimal( GetValue( RecordIndex, GridViewCuotaRE.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].Importe, VarToDecimal( GetValue( RecordIndex, GridViewImporteTotal.Index ) ) );
            end;
end;

procedure TMntTckForm.GridViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       MntUbicaciones( [ CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntTckForm.GridViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       If   ShiftKey
       then ConsultaUbicaciones( CodigoAlmacen.Value, ubNormal, Sender )
       else ConsultaExistenciasUbicacion( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LoteFabricacion.Value, CodigoAlmacen.Value, Sender, DoOnExistenciasSelected );
end;

procedure TMntTckForm.DoOnExistenciasSelected( Target : TcxCustomEdit = nil );
begin
     With CxEpuForm do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       LineaMovimientoTableUbicacion.Value := QueryUbicacion.Value;
       end;
end;

procedure TMntTckForm.GridViewUbicacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( LineaMovimientoFields.CodigoAlmacen.Value, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GrupoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposCliente( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TMntTckForm.GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.GrupoLineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FGrupoLineaMovimientoFields );
end;

procedure TMntTckForm.GrupoLineaMovimientoTableBeforeDelete( DataSet : TDataSet );
begin
     // DeleteMasterRecord solo borra los registros del primer DetailDataset (en este caso las páginas)
     // Si existen DetailDatasets de nivel inferior se tienen que suprimir a mano

     LineaMovimientoTable.DeleteRecords;
end;

procedure TMntTckForm.ImportarButtonClick(Sender: TObject);
begin
     MovimientoTable.Update;
     ImportaDocumentoVenta( MovimientoFields.Propietario.Value, DoSeleccionaDocumentoImportar, tmVenta, [ tmPresupuesto, tmPedidoVenta, tmCompra, tmCapturador{ , tmBascula } ], UltimoTipoMovimientoImportado );
end;

procedure TMntTckForm.ImprimirButtonClick(Sender: TObject);
begin

     ImprimirButton.SetFocus;

     FormManager.PostCurrentRecord;

     try

     With Movimiento do
       begin
       LimpiaParametrosInforme;
       With ParametrosInforme do
         begin
         Titulo := RsMsg45;
         TipoMovimientoListado := tmVenta;
         TipoMovimiento := tmVenta;
         SeleccionNroDocumento := True;
         Serie := MovimientoFields.Serie.Value;
         NroDocumentoInicial := MovimientoFields.NroDocumento.Value;
         NroDocumentoFinal := MovimientoFields.NroDocumento.Value;
         Valorar := True;
         MostrarDescuentos := True;
         Formato := SerieFacturacion.ObtenFormatoDefecto( impAlbaranesVenta, Serie );
         CopiaPropietario := True;
         DirectamenteAImpresora := True;
         Impreso := True;
         end;
       InformeMovimientos;
       end;

     If   PrnToPrinter
     then FormManager.SelectFirstKeyControl;

     finally
       FormManager.SelectFirstKeyControl;
       MovimientoTable.Cancel;
       end;

end;

procedure TMntTckForm.KeyPanelEnter(Sender: TObject);
begin
     FormManagerUpdateButtonsState;
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( False );
end;

procedure TMntTckForm.DoSeleccionaDocumentoImportar;
begin
     With BoxSdvForm do
       begin
       UltimoTipoMovimientoImportado := DataTipoMovimiento.Value;
       case DataTipoMovimiento.Value of

         tmPedidoCompra,
         tmCompra : 
           SeleccionaLineasDocumentoCompra( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, tmVenta, DoOnLineasImportadas );

         tmPresupuesto,
         tmPedidoventa,
         tmVenta : 
           SeleccionaLineasDocumentoVenta( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, tmVenta, DoOnLineasImportadas );

         tmCapturador :
           ImportaDatosCapturador( FicheroDatosBox.Caption );

         {
         tmBascula :
           ImportaDatosBascula;
         }

         end;
       end;
end;

procedure TMntTckForm.DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields; 
                                            CopiarDatosCabecera, 
                                            NoVincularDocumentos   : Boolean; 
                                            LineArray              : TLongIntArray );

var I : SmallInt;

begin

      Movimiento.InsertaLineasDocumento( MovimientoOrigenFields, MovimientoFields, LineArray, False, NoVincularDocumentos );
                   
     If   CopiarDatosCabecera
     then begin
          MovimientoFields.GrupoFacturacion.Value := MovimientoOrigenFields.GrupoFacturacion.Value;
          MovimientoFields.RegistroAuxiliar.Value := MovimientoOrigenFields.RegistroAuxiliar.Value;
          MovimientoFields.CodigoVendedor.Value := MovimientoOrigenFields.CodigoVendedor.Value;
          MovimientoFields.CentroCoste.Value := MovimientoOrigenFields.CentroCoste.Value;
          MovimientoFields.CodigoTransportista.Value := MovimientoOrigenFields.CodigoTransportista.Value;
          MovimientoFields.CodigoFormaCobro.Value := MovimientoOrigenFields.CodigoFormaCobro.Value;
          For I := 1 to 5 do
            MovimientoFields.CampoLibre[ I ].Value := MovimientoOrigenFields.CampoLibre[ I ].Value;
          MovimientoFields.Anotacion.Value := MovimientoOrigenFields.Anotacion.Value;
          end;
		  
     GridView.DataController.UpdateItems( False );
     FormManager.ValidateDataArea( faData );
     ActualizaEntregasACuentaPedidos;
     GridView.DataController.GotoLast;
     Grid.SetFocus;
end;

procedure TMntTckForm.ImportaDatosCapturador( DataPath : String );
begin
     try
       Movimiento.ImportaDatosCapturador( MovimientoFields,
                                          LineaMovimientoFields,
                                          Datapath,
                                          DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value );
     finally
       GridView.DataController.UpdateItems( False );
       Grid.SetFocus;
       With LineaMovimientoTable do
         begin
         EnableControls;
         Last;
         end;

       end;
end;

{
procedure TMntTckForm.ImportaDatosBascula;
begin
     try
       Movimiento.ImportaDatosBascula( MovimientoFields, LineaMovimientoFields, DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value, ClienteFields.Factura_Tarifa.Value );
     finally
       MovimientoTable.Refresh;
       end;
end;
}

procedure TMntTckForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
end;

procedure TMntTckForm.EntregaACuentaCtrlPropertiesValuePosted( Sender: TObject);
begin
     If   MovimientoFields.EntregaACuenta.Value<>0.0
     then MovimientoFields.EntregaEfectivo.Value := 0.0;
     ActualizaDevolucion( MovimientoFields.EntregaEfectivo.Value, MovimientoFields.EntregaACuenta.Value );
end;

procedure TMntTckForm.EntregaCtrlPropertiesValuePosted(Sender: TObject);
begin
     If   MovimientoFields.EntregaEfectivo.Value<>0.0
     then MovimientoFields.EntregaACuenta.Value := 0.0;
     ActualizaDevolucion( MovimientoFields.EntregaEfectivo.Value, MovimientoFields.EntregaACuenta.Value );
end;

procedure TMntTckForm.ExportarButtonClick(Sender: TObject);
begin

     FormManager.CheckDetailRecords;

     ExportaDocumentoVenta( MovimientoFields.Serie.Value,
                            MovimientoFields.Propietario.Value,
                            [ tmPedidoCompra ],
                            tmVenta,
                            MovimientoFields,
                            DoOnExportaDocumento );
end;

procedure TMntTckForm.DoOnExportaDocumento;
begin

     TipoMovimientoDestino :=  BoxEdvForm.DataTipoMovimiento.Value;
     CodigoPropietarioDestino :=  BoxEdvForm.DataPropietario.Value;
     SerieDestino := BoxEdvForm.DataSerie.Value;
     NroDocumentoDestino := BoxEdvForm.DataNroDocumento.Value;
     SoloCantidadesPendientes :=  BoxEdvForm.DataSoloCantidadesPendientes.Value;
     DocumentoAutomatico := BoxEdvForm.DataDocumentoAutomatico.Value;
                                                       
     SeleccionaLineasDocumentoVenta( tmVenta,
                                     MovimientoFields.Ejercicio.Value,
                                     MovimientoFields.NroOperacion.Value,
                                     TipoMovimientoDestino,
                                     DoOnLineasExportadas );
end;

procedure TMntTckForm.DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields; 
                                            CopiarDatosCabecera, 
                                            NoVincularDocumentos   : Boolean; 
                                            LineArray              : TLongIntArray );

var  MovimientoDestino : IMovimiento;
                                            
begin

     MovimientoTable.Cancel;   // Me aseguro de que esté desbloqueado
     
     MovimientoDestino := Movimiento.ExportaDocumento( MovimientoOrigenFields,
                                                       TipoMovimientoDestino,
                                                       CodigoPropietarioDestino,
                                                       SerieDestino,
                                                       NroDocumentoDestino,
                                                       LineArray,
                                                       SoloCantidadesPendientes,
                                                       DocumentoAutomatico );
     If   Assigned( MovimientoDestino )
     then With MovimientoDestino do
            If   VarToInteger( TipoMovimiento ) in [ tmPresupuesto, tmPedidoventa, tmVenta ]
            then MntMovimientosVenta( [ TipoMovimiento, Ejercicio, Serie, NroDocumento] )
            else MntMovimientosCompra( [ TipoMovimiento, Ejercicio, Propietario, Serie, NroDocumento ] );
end;


procedure TMntTckForm.CentroCosteCtrlPropertiesEditRequest( Sender: TcxCustomEdit );
begin
     MntCentrosCoste( [ Sender.EditValue ] );
end;

procedure TMntTckForm.CentroCosteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit );
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntTckForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.ObtenCliente( Codigo : String );
begin
     If   PropietarioActual<>MovimientoFields.Propietario.Value
     then begin
          PropietarioActual := MovimientoFields.Propietario.Value;
          Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
          FCodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields );
          end;
end;

function TMntTckForm.ObtenUltimoNroLinea : SmallInt;
begin
     With LineaMovimientoTable do
       begin
       Last;
       If   ValueIsEmpty( LineaMovimientoFields.NroLinea.Value )
       then Result := 1
       else Result := LineaMovimientoFields.NroLinea.Value + 1;
       end;
end;

procedure  TMntTckForm.DoInsertaLineasConsumo( LineList : TList<Integer> );
begin
     Movimiento.InsertaLineasConsumo( MovimientoFields, LineaMovimientoFields, ClienteFields, SerieFacturacionFields, LineList );
     GridView.DataController.UpdateItems( False );
     Grid.SetFocus;
end;

procedure TMntTckForm.FormManagerReportFormRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( True, tmVenta, Ejercicio.Value, '', Serie.Value, NroDocumento.Value );
end;

procedure TMntTckForm.FormManagerNoteRequest;
begin
     If   GridView.IsControlFocused
     then MntAnotacion( LineaMovimientoFields.Anotacion, RsAnotacionLinea )
     else MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
     FormManagerUpdateButtonsState;
end;

procedure TMntTckForm.FormManagerPreparedForm;
begin

     With DataModule00 do
       begin

       If   Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarStock, DmEmpresaFields.Ventas_VerStock )
       then If   not Assigned( StockFrame )
            then StockFrame := CreaPanelStock( scVentas, TopPanel, GridView );

       If  ( Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRiesgoAlbaranes, DmEmpresaFields.Ventas_RiesgoAlbaran ) )
       then If   not Assigned( RiesgoFrame )
            then RiesgoFrame := CreaRiesgoFrame( TopPanel );

       If   FCamposOpcionalesVisibles>0
       then TopScrollBox.VertScrollBar.Range := FCamposOpcionalesVisibles * RegistroAuxiliarPanel.Height;

       If   FCamposLibresVisibles>0
       then CamposLibresScrollBox.VertScrollBar.Range := FCamposLibresVisibles * CLScrollBoxPanel1.Height;

       end;

end;

procedure TMntTckForm.FormManagerReportRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( False, tmVenta, Ejercicio.Value, '', Serie.Value, NroDocumento.Value );
end;

procedure TMntTckForm.FormManagerShowCantEditMessage;
begin
     Movimiento.MuestraMotivoBloqueo( MovimientoFields );
end;

procedure TMntTckForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TMntTckForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( MovimientoFields )
     then begin
          If   not MovimientoTable.UpdatingProcess
          then begin
               AnotacionButton.Visible := MovimientoFields.Anotacion.Value<>'';
               AnotacionButton.Enabled := MovimientoTable.Editing;
               end;

          ConsumosButton.Enabled := ExisteModuloPreventa and ( MovimientoTable.State in [ dsEdit, dsInsert ] );
          ImportarButton.Enabled := MovimientoTable.Editing and not MovimientoFields.Anulado.Value;
          ExportarButton.Enabled := FormManager.DataAreaFocused and ( MovimientoTable.State in [ dsBrowse, dsEdit ] ) and not MovimientoFields.Anulado.Value;

          var Facturable := ( MovimientoTable.State=dsEdit ) and not MovimientoFields.NoFacturar.Value and not MovimientoFields.Anulado.Value;
          FacturarButton.Enabled := Facturable;
          FacturaDirectaButton.Enabled := Facturable;

          FirmarButton.Enabled := FTabletFirmaConectado and ( MovimientoTable.State=dsEdit );
          ShowFocusedRowHighlited := False;
          end;

end;

function TMntTckForm.GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
begin
     If   not Assigned( FGrupoLineaMovimientoFields )
     then FGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     Result := FGrupoLineaMovimientoFields;
end;

function TMntTckForm.GetLineaMovimientoFields : TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoFields )
     then FLineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     Result := FLineaMovimientoFields;
end;

procedure TMntTckForm.LineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FLineaMovimientoFields );
end;

procedure TMntTckForm.LineaMovimientoTableAfterDelete(DataSet: TDataSet);
begin
     If   LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoVenta
     then If   not MovimientoTable.DeletingMasterRecord
          then ActualizaMovimientosVenta( LineaMovimientoFields.TipoMovimientoOrigen.Value );
end;

procedure TMntTckForm.LineaMovimientoTableAfterEdit(DataSet: TDataSet);
begin
     ObtenExistencias;
     LoteAsignado := False;
end;

procedure TMntTckForm.LineaMovimientoTableAfterOpen(DataSet: TDataSet);

var Index : SmallInt;

begin
     SetFieldRange( LineaMovimientoFields.NroLinea );
     ActualizaReferencias;
end;

procedure TMntTckForm.LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
begin
     // Si el cursor está situado sobre una columna no editable (ReadOnly) al iniciarse la edición el estado persiste

     SetColumnsEditingOption( GridView, True );
end;

procedure TMntTckForm.ActualizaCantidad;
begin
     LineaMovimientoFields.Cantidad.Value := -LineaMovimientoTableCantidadAjustada.Value;
end;

procedure TMntTckForm.LineaMovimientoTableBeforePost(DataSet: TDataSet);
begin
     If   not LineaMovimientoTable.ControlsDisabled
     then begin
          LineaMovimientoFields.Cantidad.Value := -LineaMovimientoTableCantidadAjustada.Value;
          ActualizaCamposCalculadosLinea;
          If   not LoteAsignado
          then Movimiento.AsignaOrigenPorLoteySerie( LineaMovimientoFields );
          DesglosarLinea := ListaMateriales.RequiereDesglose( MovimientoFields, LineaMovimientoFields, ArticuloFields );
          MuestraLineaVisor;
          end;
end;

procedure TMntTckForm.LineaMovimientoTableAfterPost(DataSet: TDataSet);
begin
     If   DesglosarLinea
     then begin
          DesglosarLinea := False;
          ListaMateriales.AplicarDesglose( MovimientoFields, LineaMovimientoFields );
          GridView.DataController.UpdateItems( False );
          GridView.Controller.FocusFirstAvailableItem;
          end;
end;

procedure TMntTckForm.LineaMovimientoTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( LineaMovimientoFields )
     then LineaMovimientoTableTieneRegistroOrigen.Value := not ValueIsEmpty( LineaMovimientoFields.NroRegistroOrigen.Value );
end;

procedure TMntTckForm.LineaMovimientoTableNewRecord(DataSet: TDataSet);
begin
     With LineaMovimientoFields do
       begin
       Ejercicio.Value := MovimientoFields.Ejercicio.Value;
       NroOperacion.Value := MovimientoFields.NroOperacion.Value;
       NroPagina.Value := 0;  // No hay paginación en los tickets
       Fecha.Value := MovimientoFields.Fecha.Value;
       UIDArticulo.AsGUID := Articulo.Identificador;
       end;
end;

procedure TMntTckForm.LineaMovimientoTableRecordChanged(DataSet: TDataSet);
begin
     If   LineaMovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atArticulo ] );
end;

procedure TMntTckForm.LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeLineaMovimiento( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntTckForm.LineaMovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaLineaMovimiento( MovimientoFields, LineaMovimientoFields, True );
end;

procedure TMntTckForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Serie;NroDocumento
       KeyValues[ 0 ] := tmVenta;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned;
       end;
end;

procedure TMntTckForm.FacturaDirectaButtonClick(Sender: TObject);

var  ParametrosFacturacion : IParametrosFacturacion;

begin

     OkButton.SetFocus;

     FormManager.PostCurrentRecord;

     try

       ParametrosFacturacion := TParametrosFacturacion.Create;

       With ParametrosFacturacion do
         begin
         TipoSeleccion := tsDocumento;   // sólo el albaran actual
         Serie := MovimientoFields.Serie.Value;
         NroDocumento := MovimientoFields.NroDocumento.Value;
         FechaFacturacion := ApplicationContainer.TodayDate;
         CopiaPropietario := True;
         end;

       With FacturaVentas, ParametrosFacturacion do
         begin
         ParametrosFacturacion := GeneraFacturas( ParametrosFacturacion );
         Formato := SerieFacturacion.ObtenFormatoDefecto( impFacturasVenta, Serie );
         ImprimeFacturas( ParametrosFacturacion );
         end;

     finally
       FormManager.SelectFirstKeyControl;
       MovimientoTable.Refresh;
       end;

end;

procedure TMntTckForm.FacturarButtonClick(Sender: TObject);

var  ParametrosFacturacion : IParametrosFacturacion;

begin

     OkButton.SetFocus;

     FormManager.PostCurrentRecord;

     try

       ParametrosFacturacion := TParametrosFacturacion.Create;

       With ParametrosFacturacion do
         begin
         TipoSeleccion := tsDocumento;   // Solo el albaran actual
         Serie := MovimientoFields.Serie.Value;
         NroDocumento := MovimientoFields.NroDocumento.Value;
         FechaFacturacion := ApplicationContainer.TodayDate;
         end;

       FacturaVentas.GeneraFacturas( ParametrosFacturacion );

     finally
       FormManager.SelectFirstKeyControl;
       MovimientoTable.Refresh;
       end;

     With MovimientoFields do
       If   NroFactura.Value<>0  // Solo si se ha conseguido generar la factura
       then MntFacturasVenta( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] );

end;

procedure TMntTckForm.FacturaVentaItemClick(Sender: TObject);
begin
     With MovimientoFields do
       If   FacturaVentas.Obten( EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value )
       then begin
            // FormManager.SelectFirstKeyControl;
            MntFacturasVenta( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] );
            end
       else ShowNotification( ntStop, RsMsg10, RsMsg11 );
end;

procedure TMntTckForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntTckForm.RelacionMovimientoItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntTckForm.FirmarButtonClick(Sender: TObject);
begin
     FormManager.CheckDetailRecords;
     FOnCapturaFirma.Invoke( FormManager,
                             MovimientoFields.Firma,
                             ClienteFields.Nombre.Value,
                             'Ticket nº ' + IntToStr( MovimientoFields.NroDocumento.Value ) + ' de fecha ' + StrFormatDate( MovimientoFields.Fecha.Value ) );
end;

procedure TMntTckForm.FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntTckForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

function TMntTckForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := MovimientoFields.Facturado.Value;
end;

function TMntTckForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaDocumentoVentas( tmVenta, MovimientoFields.Serie.Value, DoOnCopyCurrentRecord );
     Result := False;
end;

procedure TMntTckForm.FormManagerDeleteEmptyHeader(DataSet: TDataSet);
begin

     // Como se inserta automáticamente una página vacía al crear la cabecera, hay que borrarla explícitamente
     // En los tickets me aseguro, además, de que solo se borre la página 0, no sea que el usuario esté editando
     // un albarán creado desde la gestión comercial que tenga más páginas no visibles desde aquí

     With GrupoLineaMovimientoTable do
       begin
       Cancel;
       First;
       If   not Eof and ( GrupoLineaMovimientoTableNroPagina.Value=0 )
       then Delete;
       end;
end;

procedure TMntTckForm.FormManagerFocusedAreaChanged;
begin
     FormManagerUpdateButtonsState;
end;

function TMntTckForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCACaja.Value;
end;

procedure TMntTckForm.DoOnCopyCurrentRecord;

var  NroOperacionDestino : LongInt;

begin
     With BoxCdvForm do
       begin

       NroOperacionDestino := Movimiento.CopiaMovimiento( MovimientoFields.Ejercicio.Value,
                                                          MovimientoFields.NroOPeracion.Value,
                                                          tmVenta,
                                                          MovimientoFields.Propietario.Value,   // El mismo que el del movimiento original
                                                          DataSerie.Value,
                                                          False,
                                                          '',
                                                          { AsignarUbicaciones } False,
                                                          { InvertirCantidades } False,
                                                          { BorrarMovimientoOrigen } DataSuprimir.Value,
                                                          { ActualizarPrecios } DataActualizarPrecios.Value );
       If   NroOperacionDestino>0
       then begin
            If   Movimiento.ObtenMovimiento( ApplicationContainer.Ejercicio, NroOperacionDestino )
            then begin
                 MovimientoTable.GotoCurrent( Movimiento.DmMovimientoTable );
                 ActualizaReferencias;
                 Self.FormManager.SelectFirstKeyControl;
                 end;
            end;

       end;
end;

procedure TMntTckForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesTickets, BoolToStr( MostrarAnotacionesItem.Down, True ) );
end;

procedure TMntTckForm.MovimientoTableAfterCancel(DataSet: TDataSet);
begin
     MuestraNuevaVentaVisor;
end;

procedure TMntTckForm.MovimientoTableAfterEdit(DataSet: TDataSet);
begin

     If   MovimientoFields.IVAIncluido.Value<>PreciosConIVAIncluido
     then MovimientoFields.IVAIncluido.Value := PreciosConIVAIncluido;

     If   not ( MovimientoTable.UpdatingProcess ) and ( DataModule00.DmUsuarioFields.acCACaja.Value=3 )  // No puede realizar modificaciones
     then begin
          ShowNotification( ntStop, RsMsg20, '' );
          Abort;
          end;

     MuestraNuevaVentaVisor;

end;

procedure TMntTckForm.MovimientoTableAfterInsert(DataSet: TDataSet);
begin
     FCodigoPaisIVA := CodigoEspaña;
     MuestraNuevaVentaVisor;
end;

procedure TMntTckForm.MovimientoTableAfterPost(DataSet: TDataSet);
begin
     GrupoLineaMovimientoTable.Refresh;
end;

procedure TMntTckForm.MovimientoTableBeforePost(DataSet: TDataSet);
begin
     If   MovimientoTable.State=dsEdit
     then MuestraFinVentaVisor;
end;

procedure TMntTckForm.MovimientoTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

function TMntTckForm.MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := EjercicioActual( MovimientoFields.Fecha.Value ) and
               not MovimientoFields.Anulado.Value and
               not MovimientoFields.Facturado.Value and
               not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

function TMntTckForm.MovimientoTableCheckDetailDatasets(Dataset: TDataSet; Posting: Boolean): Boolean;
begin

     // Aquí es especialmente importante la comprobación porque pueden existir albaranes creados desde el mantenimiento de la gestión comercial
     // con la paginación activada y en el que no existe la página 0

     Result := Movimiento.ExistenLineas( MovimientoFields );
end;

function TMntTckForm.MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Movimiento.ProximoDocumento( MovimientoFields );
end;

procedure TMntTckForm.MovimientoTableGetRecord(DataSet: TDataSet);
begin
     // Cuando existe una serie por defecto y no hay ningún movimiento de esa serie, hay que fijarla de nuevo

     If   MovimientoFields.Serie.IsNull
     then begin
          MovimientoTable.SetKey;
          FijaSeriePorDefecto;
          end;

     ActualizaEntregasACuentaPedidos;
end;

procedure TMntTckForm.MovimientoTableNewRecord(DataSet: TDataSet);
begin

     If   DataModule00.DmEmpresaFields.Ventas_CompCorrDoc.Value
     then With MovimientoFields do
            If   NroDocumento.Value>Movimiento.ProximoDocumento( MovimientoFields, False )
            then If   ShowNotification( ntQuestionWarning, RsMsg18, RsMsg19 )<>mrYes
                 then Abort;

     With MovimientoFields do
       begin
       NroOperacion.Value := Movimiento.ProximaOperacion;
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaAplicacion.Value := ApplicationContainer.TodayDate;  // Fecha de recepcion
       IVAIncluido.Value := PreciosConIVAIncluido;
       Revisado.Value := False;
       CentroCoste.Value := SerieFacturacionFields.CentroCoste.Value;
       end;

     ClienteFields.Clear;
end;

procedure TMntTckForm.MovimientoTableOpenRecord(DataSet: TDataSet);
begin
     ImporteNetoAnterior := ImporteNetoTotal;
end;

procedure TMntTckForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );
     FirmadoLabel.Visible := MovimientoFields.Firma.BlobSize>0;
     AnuladoLabel.Visible := MovimientoFields.Anulado.Value;

     If   MovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atCliente ] );
end;

procedure TMntTckForm.MovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeMovimiento( MovimientoFields );
end;

procedure TMntTckForm.MovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaMovimiento( MovimientoFields );
end;

procedure TMntTckForm.FijaSeriePorDefecto;
begin
     SerieFacturacion.FijaSeriePorDefecto( MovimientoFields.Serie );
     If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
     then LockRangeButton.Enabled := False;
end;

procedure TMntTckForm.MovimientoTableSetKey(DataSet: TDataSet);
begin
     MovimientoFields.TipoMovimiento.Value := tmVenta;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   LockRangeButton.SettingDefaultRange
     then FijaSeriePorDefecto;
end;

procedure TMntTckForm.MovimientoTableUpdateState(DataSet: TDataSet);

var  EnableDatasets : Boolean;

begin
     If   FormManager.FormInitialized and not MovimientoTable.ControlsDisabled
     then begin
          EnableDatasets := MovimientoTable.State<>dsSetKey;
          GrupoLineaDataSource.Enabled := EnableDatasets;
          LineaMovimientoDataSource.Enabled := EnableDatasets;
          FormManagerUpdateButtonsState;
          Movimiento.RetiraDocumento( MovimientoFields );
          end;
     ActualizaVisibilidadAviso( AvisoButton.Visible );
end;

procedure TMntTckForm.ActualizaVisibilidadAviso( Visible : Boolean );
begin
     If   not MovimientoTable.UpdatingProcess
     then AvisoButton.Visible := Visible and ( MovimientoTable.State in [ dsBrowse, dsEdit ] );
end;

procedure TMntTckForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
end;

procedure TMntTckForm.PopupMenuPopup(Sender: TObject);

var  TieneLineas,
     LineaSeleccionada : Boolean;

begin
     If   MovimientoTable.State=dsInsert
     then Abort;

     TieneLineas := GridView.DataController.RecordCount>0;
     LineaSeleccionada := TieneLineas and Assigned( GridView.Controller.FocusedRow );

     With LineaMovimientoFields do
       begin
       If   ValueIsEmpty( NroRegistroOrigen.Value )
       then begin
            EditarDocItem.Caption := RsMsg4;
            EditarDocItem.Enabled := False;
            end
       else begin
            EditarDocItem.Enabled := True;
            EditarDocItem.Caption := Format( 'Editar %s origen', [ Movimiento.TextoTipoMovimiento( TipoMovimientoOrigen.Value, False ) ] );
            end;

       FichaArticuloItem.Enabled := LineaSeleccionada  and ( CodigoArticulo.Value<>ArticuloManual );
       SetBarItemVisible( ActualizarRelacionesItem, TieneLineas and ( MovimientoTable.State=dsEdit ) );
       MostrarAnotacionesItem.Down := GridView.Preview.Visible;
       end;
end;

procedure TMntTckForm.RegistroAuxiliarCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAuxiliarClientes( [ MovimientoFields.Propietario.Value, Sender.EditingValue ] );
end;

procedure TMntTckForm.RegistroAuxiliarCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, ClienteCtrl.EditValue );
end;

procedure TMntTckForm.RegistroAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( MovimientoFields.Propietario.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntTckForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
end;

procedure TMntTckForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.ClienteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Assigned( ClienteFields )
     then MuestraRiesgo;
end;

procedure TMntTckForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntTckForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     AvisoButton.Visible := False;
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, ClienteFields );
     If   not Error
     then begin
          If   Sender.Editing and ( DisplayValue<>MovimientoFields.Propietario.Value ) and ( LineaMovimientoTable.RecordCount<>0 )
          then If   ShowNotification( ntQuestionWarning, RsMsg48, RsMsg49 )<>mrYes
               then Error := True;
          ActualizaVisibilidadAviso( ClienteFields.MostrarAviso.Value );
          end;
end;

procedure TMntTckForm.ClienteCtrlPropertiesValuePosted(Sender: TObject);

var  CodigoVendedor : String;

begin
     With ClienteCtrl do
       If   Editing
       then begin

            ObtenCliente( MovimientoFields.Propietario.Value );

            With DataModule00.DmEmpresaFields do
              begin

              If   Cliente_GruposFac.Value
              then try
                     GrupoClienteCtrl.PostEditValue( ClienteFields.Factura_Agrupacion.Value );
                   except
                     ShowNotification( ntStop, Format( RsMsg27, [ 'grupo de cliente' ] ), RsMsg28 );
                     end;

              If   Ventas_PagosPedido.Value
              then try
                     FormaCobroCtrl.PostEditValue( ClienteFields.Cobro_FormaCobro.Value );
                   except
                     ShowNotification( ntStop, Format( RsMsg27, [ 'forma de cobro' ] ), RsMsg28 );
                     end;

              try
                If   ClienteFields.Vendedor.Value=''
                then CodigoVendedor := DataModule00.DmUsuarioFields.Ventas_VendedorDefecto.Value
                else CodigoVendedor := ClienteFields.Vendedor.Value;
                VendedorCtrl.PostEditValue( CodigoVendedor );
              except
                ShowNotification( ntStop, Format( RsMsg27, [ 'vendedor' ] ), RsMsg28 );
                end;

              If   Ventas_Transportista.Value
              then try
                     TransportistaCtrl.PostEditValue( ClienteFields.Envios_Transportista.Value );
                   except
                     ShowNotification( ntStop, Format( RsMsg27, [ 'transportista' ] ), RsMsg28 );
                     end;

              end;

            With RelacionesCliente do
              begin
              CompruebaCredito( ClienteFields );
              CompruebaRiesgo( ClienteFields );
              end;

            // Al cambiar el cliente han podido cambiar las referencias (el calculo del IVA sobre todo)

            Movimiento.RecalculaMovimiento( MovimientoFields );

            GridView.DataController.UpdateItems( False );
            end;

end;

procedure TMntTckForm.ComPortException( Sender         : TObject;
                                        TComException  : TComExceptions;
                                        ComportMessage : string;
                                        WinError       : Int64;
                                        WinMessage     : string );
begin
     If   not ( csDestroying in ComponentState )
     then Abort;
end;

procedure TMntTckForm.ConsumosButtonClick(Sender: TObject);
begin
     MovimientoTable.Update;
     With MovimientoFields do
       SeleccionaConsumosCliente( Propietario.Value, DoInsertaLineasConsumo );
end;

procedure TMntTckForm.TableViewManagerBeforeValidateTableView(Sender: TObject);
begin
     ObtenExistencias;
end;

function TMntTckForm.TableViewManagerCanAlterRow: Boolean;
begin
     Result := not MovimientoFields.Facturado.Value and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntTckForm.TableViewManagerCanShiftRow: Boolean;
begin
     Result := not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

procedure TMntTckForm.TableViewManagerRowShift(ShiftOperation: TShiftOperation);

var  HaciaArriba,
     HastaElFinal : Boolean;

begin
     HaciaArriba := ( ShiftOperation=soFirst ) or ( ShiftOperation= soPrior );
     HastaElFinal := ( ShiftOperation= soFirst ) or ( ShiftOperation=soLast );
     With LineaMovimientoFields do
       Movimiento.DesplazaLineaMovimiento( Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value, HaciaArriba, HastaElFinal );
end;

procedure TMntTckForm.TopPanelEnter(Sender: TObject);
begin
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( True, MovimientoTable.Inserting );
end;

procedure TMntTckForm.TransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TMntTckForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntTckForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntTckForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntTckForm.MuestraNuevaVentaVisor;

function PadText( StrText : string ) : string;

var  Pad   : SmallInt;
     st    : string;

begin
     Pad := ( 20 - length( StrText ) ) div 2;
     If   Pad>0
     then Result := StrConst( Pad ) + StrText
     else Result := StrText;
end;

begin
     If   PuertoVisorConectado
     then begin
          ImprimeVisor( cvClear, '' );
          With ParametrosTPVRec do
            begin
            ImprimeVisor( cvTopLine, PadText( TextoVisor1 ) );
            ImprimeVisor( cvBottomLine, PadText( TextoVisor2 ) );
            end;
          end;
end;

procedure TMntTckForm.MuestraFinVentaVisor;
begin
     If   PuertoVisorConectado
     then begin
          ImprimeVisor( cvClear, '' );
          With ParametrosTPVRec do
            begin
            ImprimeVisor( cvTopLine, RsMsg29 );
            ImprimeVisor( cvBottomLine, RsMsg30 );
            end;
          end;
end;

procedure TMntTckForm.AbreCajon;

var   ComFile : TextFile;

begin
     With ParametrosTPVRec do
       If   PuertoCOMCajon<>0
       then begin
            AssignFile( ComFile, 'COM' + strInt( PuertoCOMCajon ) );
            Rewrite( ComFile );
            If   IoResult=0
            then begin
                 case ModeloCajon of
                   0 : Write( ComFile, '0000000000' );
                   1 : ;
                   end;
                 CloseFile( ComFile );
                 end;
            end;
end;

procedure TMntTckForm.MuestraLineaVisor;
begin
     If   PuertoVisorConectado
     then With LineaMovimientoFields do
            If   ValueIsEmpty( CodigoArticulo.Value )  // Una línea vacía indica que se ha finalizado la introducción
            then MuestraTotalesVisor
            else begin
                 ImprimeVisor( cvTopLine, RightPad( Copy( Descripcion.Value, 1, 15 ), 15 ) +
                                          LeftPad( StrFormat( -Cantidad.Value, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value ), 5, ' ' ) );
                 ImprimeVisor( cvBottomLine, LeftPad( 'x ' + StrFormat( PrecioIVA.Value, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value ), 10, ' ' ) +
                                             LeftPad( StrFormat( ImporteTotal.Value, DecimalesMoneda ), 10, ' ' ) );
                 end;
end;

procedure TMntTckForm.MuestraTotalesVisor;
begin
     If   PuertoVisorConectado
     then begin
          ImprimeVisor( cvClear, '' );
          ImprimeVisor( cvTopLine, RsMsg26 + LeftPad( StrFormat( TotalIVAIncluido, DecimalesMoneda ), 10, ' ' ) );
          end;
end;

procedure TMntTckForm.MuestraDevolucionVisor( Entrega : Decimal );

var  StrImporteDev : string;

begin
     If   PuertoVisorConectado
     then begin
          ImprimeVisor( cvClear, '' );
          ImprimeVisor( cvTopLine, RsMsg23 + LeftPad( StrFormat( Entrega { MovimientoFields.EntregaEfectivo.Value}, DecimalesMoneda ), 10, ' ' ) );
          If   Devolucion<0.0
          then StrImporteDev := ''
          else StrImporteDev := LeftPad( StrFormat( Devolucion, DecimalesMoneda ), 10, ' ' );
          ImprimeVisor( cvBottomLine, RsMsg24 + StrImporteDev );
          end;
end;

procedure TMntTckForm.ImprimeVisor( Comando : TComandosVisor;
                                    Texto   : String );

var   Spi : SmallInt;

begin


     If   not PuertoVisorConectado
     then Exit;

     // Visores standard de 2x20

     try

       If   ParametrosTPVRec.PuertoCOMVisor<>0
       then begin

            If   ParametrosTPVRec.InicializarPuerto and ( Comando=cvReset )
            then With Printer do
                   begin
                   Spi := PrinterIndex;
                   try
                     PrinterIndex := Printers.IndexOf( ParametrosTPVRec.ImpresoraVisor );
                     BeginDoc;
                     NewPage;
                     EndDoc;
                   finally
                     PrinterIndex := Spi;
                     end;
                   end;

            case Comando of
              cvReset :
                begin
                case ParametrosTPVRec.ModeloVisor of
                  0 : ;
                  1 : ComPort.WriteStr( #31 );  // Reset
                  2 : ;
                  3 : begin
                      ComPort.WriteStr( #$1B + #$52 + #$07 );   // Charset Español
                      ComPort.WriteStr( #$1B + #$40 );
                      end;
                  4 : ComPort.WriteStr( #$1B + #$49 + #$16 );
                  end;
                ComPort.WriteStr( rsMsg25 );
                end;

              cvClear :
                case ParametrosTPVRec.ModeloVisor of
                  0 : ComPort.WriteStr( #27 + '=' + #2 );
                  1 : begin
                      ComPort.WriteStr( #17 );
                      ComPort.WriteStr( #16 + #0  + StrConst( 20 ) );
                      ComPort.WriteStr( #16 + #20 + StrConst( 20 ) );
                      end;
                  2 : ComPort.WriteStr( #$0C );
                  3 : ComPort.WriteStr( #$0C );
                  4 : ComPort.WriteStr( #$0E );
                  end;

              cvTopLine :
                case ParametrosTPVRec.ModeloVisor of
                  0 : ComPort.WriteStr( #27 + 'U' + Texto );
                  1 : ComPort.WriteStr( #16 + #0 + Texto );
                  2 : ComPort.WriteStr( #$0E + Texto );
                  3 : ComPort.WriteStr( #$0B + Texto );
                  4 : ComPort.WriteStr( #$0C + Texto );
                  end;

              cvBottomLine :
                case ParametrosTPVRec.ModeloVisor of
                  0 : ComPort.WriteStr( #27 + 'D' + Texto );
                  1 : ComPort.WriteStr( #16 + #20 + Texto );
                  2 : ComPort.WriteStr( #$0F + Texto );
                  3 : ComPort.WriteStr( #$0B + #$0A + Texto );
                  4 : ComPort.WriteStr( #$0C + #$11 + #$0A + Texto );
                  end;
              end;
            end;

     except
       ShowNotification( ntWarning, RsMsg55 );
       try
         Comport.Close;
       except
         end;
       // Utilizo una variable externa porque la mayoría de las veces se produce un error al intentar cerrar el puerto
       // y la variable ComPort.Connected sigue activa
       PuertoVisorConectado := False;
       end;
end;

end.

