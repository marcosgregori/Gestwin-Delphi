unit a_mco;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics, Generics.Collections, Vcl.ImgList,

     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar, cxIntegerEdit, System.ImageList,
    cxCurrencyEdit, dxmdaset, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
    dxSkinscxPCPainter, cxRichEdit, cxGroupBox, cxLookAndFeels, cxLabel, cxScrollBox, cxNavigator,
    cxImageList, dxBar, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
    LibUtils,
    AppContainer,
    AppForms,
    GridTableViewController,
    Spring,

    Gim00Fields,
    Gim10Fields,
    Gim30Fields,

    ParametrosFacturacionIntf,

    f_sto,

    dmi_mov,
    dmi_sto,

    dm_mov,
    dm_fdc,
    dm_lma,
    dm_sto, dxScrollbarAnnotations, cxSplitter, dxUIAClasses;

type
  TMntMcoForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    BottomPanel: TGridTableViewPanel;
    TopPanel: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    LineaMovimientoDataSource: TDataSource;
    LineaMovimientoTable: TnxeTable;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPrecioDivisa: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewTara: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    ProveedorCtrl: TcxDBTextEdit;
    LockRangeButton: TgxLockRangeButton;
    TableViewManager: TGridTableViewController;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewRecibido: TcxGridDBColumn;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataRecibido: TBooleanField;
    LineaMovimientoTableEjercicio: TSmallintField;
    LineaMovimientoTableNroOperacion: TIntegerField;
    LineaMovimientoTableNroLinea: TSmallintField;
    LineaMovimientoTableFecha: TDateField;
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
    LineaMovimientoTableCantidadProcesada: TBCDField;
    LineaMovimientoTablePrecioDivisa: TBCDField;
    LineaMovimientoTableRecargo: TBCDField;
    LineaMovimientoTablePuntoVerde: TBCDField;
    LineaMovimientoTableDescuento: TBCDField;
    LineaMovimientoTableNroCajas: TBCDField;
    LineaMovimientoTableLargo: TBCDField;
    LineaMovimientoTableAncho: TBCDField;
    LineaMovimientoTableAlto: TBCDField;
    LineaMovimientoTableNoCalcularMargen: TBooleanField;
    LineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTableImporteNeto: TBCDField;
    LineaMovimientoTableImporteDescuento: TBCDField;
    LineaMovimientoTableImporteBruto: TBCDField;
    Panel1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    RecibidoPanel: TgxScrollBoxPanel;
    PortesCtrl: TcxDBCurrencyEdit;
    PortesPanel: TgxScrollBoxPanel;
    RecibidoCtrl: TcxDBCheckBox;
    NoFacturarPanel: TgxScrollBoxPanel;
    NoFacturarCtrl: TcxDBCheckBox;
    BottomScrollBox: TcxScrollBox;
    RevisadoPanel: TgxScrollBoxPanel;
    RevisadoCtrl: TcxDBCheckBox;
    GridViewDocumentoOrigen: TcxGridDBColumn;
    LineaMovimientoTableTieneRegistroOrigen: TBooleanField;
    GridViewNroRegistro: TcxGridDBColumn;
    GridViewNroRegistroOrigen: TcxGridDBColumn;
    RelacionAlbaranesTable: TnxeTable;
    GridViewUbicacion: TcxGridDBColumn;
    ButtonContainerPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    FacturarButton: TgBitBtn;
    ExportarButton: TgBitBtn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    LineaMovimientoTableAsignacionOrigen: TSmallintField;
    GridViewAnotacion: TcxGridDBColumn;
    LineaMovimientoTableNroPagina: TSmallintField;
    LineaMovimientoTableNroRegistro: TUnsignedAutoIncField;
    TituloDocumentoLabel: TcxLabel;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    SeparadorSerieLabel: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    TopScrollBox: TcxScrollBox;
    FechaAplicacionPanel: TgxScrollBoxPanel;
    FechaAplicacionCtrl: TcxDBDateEdit;
    FechaAplicacionCaptionLabel: TcxLabel;
    CentroCostePanel: TgxScrollBoxPanel;
    CentroCosteCtrl: TcxDBTextEdit;
    Label4: TcxLabel;
    Label12: TcxLabel;
    LineaMovimientoTableBultos: TBCDField;
    GridViewBultos: TcxGridDBColumn;
    RegistroAuxiliarPanel: TgxScrollBoxPanel;
    RegistroAuxiliarCtrl: TcxDBTextEdit;
    Label14: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    LineaMovimientoTableTipoLinea: TWideStringField;
    GridViewTipoLinea: TcxGridDBColumn;
    LineaMovimientoTableCantidadAjustada: TBCDField;
    LineaMovimientoTableOferta: TBooleanField;
    LineaMovimientoTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoTableCuotaIVA: TBCDField;
    LineaMovimientoTableCuotaRE: TBCDField;
    LineaMovimientoTablePrecioIVA: TBCDField;
    LineaMovimientoTableImporteTotal: TBCDField;
    GridViewCodigoTipoIVA: TcxGridDBColumn;
    LineaMovimientoAuxTable: TnxeTable;
    OperarioPanel: TgxScrollBoxPanel;
    CodigoOperarioCtrl: TcxDBTextEdit;
    NombreOperarioLabel: TcxLabel;
    cxLabel2: TcxLabel;
    LineaMovimientoTablePrecio: TFloatField;
    GridViewPeso: TcxGridDBColumn;
    LineaMovimientoTablePeso: TBCDField;
    LineaMovimientoTableTara: TBCDField;
    GridViewCuotaIVA: TcxGridDBColumn;
    GridViewCuotaRE: TcxGridDBColumn;
    GridViewImporteTotal: TcxGridDBColumn;
    OrigenLabel: TcxLabel;
    LineaMovimientoTablePesoEnvase: TBCDField;
    GridViewPesoEnvase: TcxGridDBColumn;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTableParametros: TWordField;
    GridViewProcesada: TcxGridDBColumn;
    LineaMovimientoTableFechaAplicacion: TDateField;
    GridViewFechaAplicacion: TcxGridDBColumn;
    BarManager: TdxBarManager;
    RejillaPopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    FichaMovimientosArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    VincularPedidoItem: TdxBarButton;
    SuprimirVinculosItem: TdxBarButton;
    DarPorRecibidaItem: TdxBarButton;
    ActualizarRelacionesItem: TdxBarButton;
    CopiarAnotacionItem: TdxBarButton;
    MostrarAnotacionesItem: TdxBarButton;
    LineasDocumentoItem: TdxBarButton;
    FacturaCompraItem: TdxBarButton;
    DocumentoOrigenItem: TdxBarButton;
    FillPanel: TcxGroupBox;
    CantidadTotalPanel: TcxGroupBox;
    CantidadLabel: TcxLabel;
    FooterPanelCantidad: TcxLabel;
    RecibidoTotalPanel: TcxGroupBox;
    FooterPanelRecibido: TcxLabel;
    RecibidoLabel: TcxLabel;
    PesoTotalPanel: TcxGroupBox;
    FooterPanelPeso: TcxLabel;
    PesoLabel: TcxLabel;
    TotalesPanel: TcxGroupBox;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    FooterPanelImporte: TcxLabel;
    FooterPanelIVAIncluido: TcxLabel;
    AnotacionButton: TgBitBtn;
    BrowseMovimientoTable: TnxeTable;
    LineaMovimientoTableFechaCaducidad: TDateField;
    GridViewFechaCaducidad: TcxGridDBColumn;
    EnviarButton: TgBitBtn;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    GridViewCampoLibre1: TcxGridDBColumn;
    GridViewCampoLibre2: TcxGridDBColumn;
    GridViewCampoLibre3: TcxGridDBColumn;
    GridViewCampoLibre4: TcxGridDBColumn;
    AvisoButton: TgBitBtn;
    LineaMovimientoTableTieneDocumentosAsociados: TBooleanField;
    GridViewTieneDocumentosAsociados: TcxGridDBColumn;
    AsignarAlmacenButton: TgBitBtn;
    DataPanelSplitter: TcxSplitter;
    cxGroupBox1: TcxGroupBox;
    ImportarButton: TgBitBtn;
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
    PreciosButton: TgBitBtn;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    GridViewCampoLibre5: TcxGridDBColumn;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    GridViewEjercicioOrigen: TcxGridDBColumn;
    GridViewNroOperacionOrigen: TcxGridDBColumn;
    LineaMovimientoTableSerieOrigen: TWideStringField;
    LineaMovimientoTableNroDocumentoOrigen: TLongWordField;
    GridViewSerieOrigen: TcxGridDBColumn;
    GridViewNroDocumentoOrigen: TcxGridDBColumn;
    LineaMovimientoTableContribucionRAP: TBCDField;
    CaptionsPanel: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportFormRequest;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure LineaMovimientoTableAfterEdit(DataSet: TDataSet);
    procedure GridViewAfterSummary(ASender: TcxDataSummary);
    procedure GridViewFooterSummaryItems( ASender : TcxDataSummaryItems; Arguments : TcxSummaryEventArguments;
      var OutArguments : TcxSummaryEventOutArguments );
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
    procedure MovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewFocusedItemChanged(Sender: TcxCustomGridTableView;APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure GridViewCodigoAlmacenPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure importarButtonClick(Sender: TObject);
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
    procedure RejillaPopupMenuPopup(Sender: TObject);
    procedure LineaMovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormManagerShowForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure MovimientoTableBeforeScroll(DataSet: TDataSet);
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
    procedure TrazaItemClick(Sender: TObject);
    procedure FichaMovimientosArticuloItemClick(Sender: TObject);
    procedure EditarDocItemClick(Sender: TObject);
    procedure GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
    procedure ExportarButtonClick(Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
    procedure GridViewDimensionPropertiesValuePosted(Sender: TObject);
    procedure GridViewNroCajasPropertiesValuePosted(Sender: TObject);
    procedure GridViewCantidadPropertiesValuePosted(Sender: TObject);
    procedure GridViewPrecioDivisaPropertiesValuePosted(Sender: TObject);
    procedure FormManagerLabelsRequest;
    procedure FormManagerPreparedForm;
    procedure LineaMovimientoTableAfterPost(DataSet: TDataSet);
    procedure NoFacturarCtrlPropertiesChange(Sender: TObject);
    procedure GridViewCodigoClasePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure RecibidoCtrlPropertiesValuePosted(Sender: TObject);
    function MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
    function MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure MovimientoTableBeforeInsert(DataSet: TDataSet);
    procedure KeyPanelEnter(Sender: TObject);
    procedure FormManagerFocusedAreaChanged;
    procedure FacturaCompraItemClick(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure GridViewCantidadPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure GridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure GridViewPrecioPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure FormManagerUpdateButtonsState;
    procedure LineaMovimientoTableBeforeEdit(DataSet: TDataSet);
    procedure TableViewManagerDelete(Sender: TObject);
    procedure DarPorRecibidaItemClick(Sender: TObject);
    function TableViewManagerCanDeleteRow: Boolean;
    procedure LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
    procedure RegistroAuxiliarCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure RegistroAuxiliarCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewTipoLineaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewUpdatePropertiesValuePosted(Sender: TObject);
    procedure LineasDocumentoItemClick(Sender: TObject);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    procedure FormManagerSetupToolBar(Enable: Boolean);
    procedure CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewRecibidoPropertiesValuePosted(Sender: TObject);
    procedure ActualizarRelacionesItemClick(Sender: TObject);
    procedure GridViewImporteGetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure LineaMovimientoTableCalcFields(DataSet: TDataSet);
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    procedure PortesCtrlPropertiesValuePosted(Sender: TObject);
    procedure VincularPedidoItemClick(Sender: TObject);
    procedure SuprimirVinculosItemClick(Sender: TObject);
    procedure MovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure CopiarAnotacionItemClick(Sender: TObject);
    procedure DocumentoOrigenItemClick(Sender: TObject);
    procedure GridViewPesoEnvasePropertiesValuePosted(Sender: TObject);
    procedure MovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure MovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure GridViewPrecioDivisaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FechaAplicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    function TableViewManagerCanInsertRow: Boolean;
    procedure GridViewRecibidoGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure GridViewImporteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure GridViewImporteTotalGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure GridViewPrecioDivisaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    function TableViewManagerCanShiftRow: Boolean;
    procedure TableViewManagerRowShift(ShiftOperation: TShiftOperation);
    function FormManagerGetAccessLevel: SmallInt;
    procedure LineaMovimientoTableRecordChanged(DataSet: TDataSet);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure AvisoButtonClick(Sender: TObject);
    procedure ProveedorCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    function TableViewManagerCanShowDocument: Boolean;
    procedure AsignarAlmacenButtonClick(Sender: TObject);
    procedure PreciosButtonClick(Sender: TObject);
    procedure GridViewPuntoVerdePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
  private

    FLineaMovimientoFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;
    ClaseFields,
    EnvaseFields : TClaseFields;
    ProveedorFields : TProveedorFields;
    DsDivisaFields : TDivisaFields;

    StockFrame : TStockFrame;
    TipoMovimientoEdicion : TTipoMovimiento;

    FMostrarNroDocumentoOrigen,
    FActualizandoCamposCalculadosLinea,
    DesglosarLinea,
    DandoLineaPorRecibida,
    ShowFocusedRowHighlited : Boolean;
    ExistenciasArticulo : IExistenciasArticulo;
    DatosLineaModificables : Boolean;

    FCamposOpcionalesVisibles,
    FCamposLibresVisibles : SmallInt;

    FOnMuestraDocumentoOrigen,
    FBeforePostMovimiento,
    FBeforeDeleteMovimiento : Event<TMovimientoDatasetEvent>;

    function GetLineaMovimientoFields : TLineaMovimientoFields;
    procedure ActualizaCamposCalculadosLinea;
    procedure CompruebaEstadoLineaPedido;
    procedure GridViewAutoEditChanged;
    procedure MuestraTotales;
    procedure DoOnCreaFactura;
    procedure DoOnExportaDocumento;
    function DoShowDocument : Boolean;
    procedure DoOnCloseRelacionDocumentos;
    procedure DoOnAsignaAlmacen( CodigoAlmacen : String );
    procedure ActualizaVisibilidadAviso(Visible: Boolean);
    procedure MostrarAviso;
    procedure SetMostrarNroDocumentoOrigen( const Value : Boolean );

  public

    MovimientoFields : TMovimientoFields;
    LineaMovimientoAuxFields : TLineaMovimientoFields;

    ImporteBruto,
    DtoArticulo,
    ImporteNeto,

    PesoTotal,
    CantidadTotal,
    CantidadProcesadaTotal,
    ImporteNetoTotal,
    ImporteTotal : Decimal;

    CodigoDivisa : String;
    TipoDeCambio : Double;

    CalcularIVA,
    RecibidoAnterior,
    FijarClases,
    ExisteEnvase : Boolean;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    TasasArray : TTasasArray;
    ParametrosFacturacion : TParametrosFacturacion;

    UltimoTipoMovimientoImportado,
    UltimoTipoMovimientoExportado : TTipoMovimiento;

    TipoMovimientoDestino : TTipoMovimiento;
    CodigoPropietarioDestino,
    SerieDestino : String;
    NroDocumentoDestino : LongInt;
    DocumentoAutomatico,
    TodasLasLineas : Boolean;

    procedure ObtenExistencias;
    procedure ActualizaEstado;
    procedure ActualizaEstadoLineas;
    procedure ActualizaSituacionPedido;
    procedure ActualizaRelaciones( Forzar : Boolean = False );
    procedure ActualizaValorCantidad( Value : Decimal );
    procedure ActualizaValorCantidadyEnvases( NroCajas : Double );
    procedure ActualizaTara;
    procedure DoOnCopyCurrentRecord;
    procedure DoSeleccionaDocumento;
    procedure DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False; LineArray : TLongIntArray = nil );
    procedure DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False; LineArray : TLongIntArray = nil );
    
    procedure ImportaDatosCapturador( DataPath : String );
    procedure HighliteRow( RowIndex : LongInt );
    procedure SetButtonVisible( Button : TgBitBtn; Value : Boolean );

    property MostrarNroDocumentoOrigen : Boolean read FMostrarNroDocumentoOrigen write SetMostrarNroDocumentoOrigen;
    property LineaMovimientoFields : TLineaMovimientoFields read GetLineaMovimientoFields;

    property OnMuestraDocumentoOrigen : Event<TMovimientoDatasetEvent> read FOnMuestraDocumentoOrigen write FOnMuestraDocumentoOrigen;
    property BeforePostMovimiento : Event<TMovimientoDatasetEvent> read FBeforePostMovimiento write FBeforePostMovimiento;
    property BeforeDeleteMovimiento : Event<TMovimientoDatasetEvent> read FBeforeDeleteMovimiento write FBeforeDeleteMovimiento;

  end;

var  MntMcoForm : array[ tmOferta..tmCompra ] of TMntMcoForm = ( nil, nil, nil );

     TipoMovimientoCreado : TTipoMovimiento;

function MntMovimientosCompra( Values : array of const ) : TMntMcoForm;
procedure ActualizaMovimientosCompra( TipoMovimiento : TTipoMovimientoCompra );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,

       MovimientoIntf,
       Gdm30Frm,

       dmi_iva,

       dm_pga,
       dm_usr,
       dm_cls,
       dm_art,
       dm_pro,
       dm_alm,
       dm_cdi,
       dm_tca,
       dm_cco,
       dm_iva,
       dm_ubi,
       dm_rap,
       dm_tlm,
       dm_ope,
       dm_reg,
       dm_rdm,

       b_msg,
       bx_not,
       b_cdc,
       b_sdc,
       b_mco,
       b_mve,
       b_fda,
       b_trz,
       b_edc,
       b_rld,
       b_spe,
       b_fdc,
       b_avs,
       b_rdm,
       b_aal,
       b_cpa,

       a_art,
       a_cco,
       a_pro,
       a_cls,
       a_alm,
       a_fdc,
       a_ubi,
       a_mve,
       a_mov,
       a_rap,
       a_tlm,
       a_ope,
       a_tca,

       e_mov,

       cx_mco,
       cx_pro,
       cx_art,
       cx_alm,
       cx_cco,
       cx_ubi,
       cx_rap,
       cx_tlm,
       cx_ope,

       r_mov;

resourceString

   //..
   RsMsg4  = 'No procede de ningún otro documento';
   RsMsg5  = 'El registro origen de esta línea ya no existe.';
   RsMsg6  = 'Se suprime la referencia al documento origen en la línea actual.';
   RsMsg7  = 'Las cantidades, en las ofertas, deben ser positivas.';
   RsMsg9  = ' pendientes de un proveedor';
   RsMsg10 = 'Este albaran consta como facturado pero no existe la factura a la que pertenece.';
   RsMsg11 = 'Ejecute una reconstrucción de resultados para verificar las relaciones entre los documentos y corregir cualquier error.';
   RsMsg12 = 'No puede modificar la estructura de albaranes facturados.';
   RsMsg13 = 'Pulse sobre el botón para acceder directamente al mantenimiento del documento origen.';
   RsMsg14 = 'Utilice el botón derecho del ratón para acceder al menú de opciones de la línea.';
   RsMsg15 = 'No existen cantidades pendientes de recibir en este pedido.';
   RsMsg16 = 'No puede cambiar el estado de un pedido cuyos artículos han sido incluidos por completo en albaranes de compra.' + #13 +
             'Si aún así desea editarlo, localice una línea de un albaran de entrada de este pedido y suprímala o modifique la cantidad de entrada.';
   RsMsg17 = 'Pulse <F11> para convertir el precio con I.V.A. incluído introducido manualmente, en su correspondiente precio base.';
   RsMsg18 = 'El importe de la EcoTasa no puede ser superior al precio del artículo.';
   RsMsg20 = '&Documentos cuyo origen es %s';

   RsMsg21 = '¿Está seguro de que desea suprimir todos los vinculos con pedidos?';
   RsMsg22 = 'Este proceso elimina las relaciones que puedan tener las líneas del albarán con pedidos existentes.'#13'Una vez realizado se puede volver a vincular el documento con cualquier otro pedido.';

   RsMsg34 = 'En este artículo es obligatorio indicar el envase.';   

   RsMsg38 = 'No se pueden modificar o suprimir líneas que ya han sido parcial o totalmente recibidas.';
   RsMsg39 = 'Si desea editar esta línea localice el/los albaran/es a los que ha sido exportada y suprima las referencias a la misma.';
   RsMsg40 = 'No se puede modificar esta columna.';
   RsMsg41 = 'El código del artículo y las clases no pueden modificarse cuando la línea se ha importado desde otro documento.';

   RsMsg44 = '¿Está seguro de que desea actualizar las relaciones del documento?';
   RsMsg45 = 'Cuando se actualiza un documento se vuelven a comprobar las relaciones del mismo, como los tipos de I.V.A. de las líneas, recalculando los importes si es necesario.'#13 +
             'Por defecto los documentos conservan los datos impositivos originales aunque se modifique la ficha de los artículos incluídos en él, para que no se produzcan alteraciones en los importes.' ;

function MntMovimientosCompra( Values : array of const ) : TMntMcoForm;
begin
     TipoMovimientoCreado := Values[ 0 ].VInteger;  // Siempre hay que pasar el tipo (como mínimo)
     CreateEditForm( TMntMcoForm, MntMcoForm[ TipoMovimientoCreado ], Values, TGds30Frm.ComprasSection );
     Result := MntMcoForm[ TipoMovimientoCreado ];
end;

procedure ActualizaMovimientosCompra( TipoMovimiento : TTipoMovimientoCompra );
begin
     If   Assigned( MntMcoForm[ TipoMovimiento ] )
     then With MntMcoForm[ TipoMovimiento ] do
            begin
            // BringToFront;
            MovimientoTable.Refresh;
            end;
end;

procedure TMntMcoForm.FormManagerInitializeForm;

var   TextoNroDocumento,
      TextoFechaAplicacion : String;
      I : SmallInt;

procedure SetupCamposLibres( CamposLibres : Array of TcxCustomEdit );

var   I : SmallInt;
      Visible : Boolean;
      CampoLibreCtrl : TcxCustomEdit;
begin
     CamposLibresScrollBox.Visible := False;
     If   DataModule00.DmEmpresaFields.Compras_CamposLibres.Value
     then begin
          I := 1;
          FCamposLibresVisibles := 0;
          With DataModule00.DmEmpresaFields do
            For CampoLibreCtrl in CamposLibres do
              begin
              Visible := ( TipoMovimientoEdicion in [ tmPedidoCompra, tmCompra ] ) and
                         ( Compras_CamposLibres.Value ) and
                         ( Compras_CampoLibre[ I ].Value<>'' );
              SetupPanelableCtrl( CampoLibreCtrl, Visible );
              If   Visible
              then begin
                   TcxLabel( CampoLibreCtrl.CaptionLabel ).Caption := Compras_CampoLibre[ I ].Value;
                   CampoLibreCtrl.Properties.Required := Compras_CampoLibreObligatorio[ I ].Value;
                   Inc( FCamposLibresVisibles );
                   end;
              Inc( I );
              end;
          CamposLibresScrollBox.Visible := FCamposLibresVisibles>0;
          end
     else CamposLibresScrollBox.VertScrollBar.Range := 0;
end;

begin

     ID := idMntMcoForm;

     Caption := Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, True, True );
     With TituloDocumentoLabel do
       begin
       // Font.Name := Fuente;
       Caption := Movimiento.TextoTituloMovimiento( TipoMovimientoEdicion );
       end;

     case TipoMovimientoEdicion of
       tmOferta       : begin
                        TextoNroDocumento := 'Nº oferta';
                        TextoFechaAplicacion := 'Fecha de cancelac.';
                        HelpKeyword := 'a_ofr';
                        // TituloDocumentoLabel.Style.TextColor := clIconRed;
                        end;
       tmPedidoCompra : begin
                        TextoNroDocumento := 'Nº pedido';
                        TextoFechaAplicacion := 'Fecha de recepción';
                        HelpKeyword := 'a_pdc';
                        // TituloDocumentoLabel.Style.TextColor := clIconOrange;
                        end;
       tmCompra       : begin
                        TextoNroDocumento := 'Serie - Nº albarán';
                        TextoFechaAplicacion := '';
                        HelpKeyword := 'a_adc';
                        FechaAplicacionCtrl.Enabled := False;
                        // TituloDocumentoLabel.Style.TextColor := clIconGreen;
                        end;
       end;

     SetBarItemsVisible( [ TrazaItem ], DataModule00.Trazabilidad );
     SetButtonVisible( EnviarButton, ( TipoMovimientoEdicion=tmPedidoCompra ) and ApplicationContainer.IsModuleActive( [ 119 ] ) );

     NroDocumentoCaptionLabel.Caption := TextoNroDocumento;
     FechaAplicacionCaptionLabel.Caption := TextoFechaAplicacion;
     RegistroAuxiliarLabel.Caption := NombreAuxiliarProveedor( True, False );

     With DataModule00.DmEmpresaFields do
       begin

       If   TipoMovimientoEdicion=tmCompra
       then begin
            SerieCtrl.Left := 0;
            SerieCtrl.Visible := True;
            SeparadorSerieLabel.Left := 10;
            SeparadorSerieLabel.Visible := True;
            end;

       FCamposOpcionalesVisibles := 0;

       SetupPanelableCtrl( RegistroAuxiliarCtrl, Proveedor_RegAuxiliar.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( CentroCosteCtrl, ( TipoMovimientoEdicion=tmCompra ) and Contable_CtrosCoste.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( FechaAplicacionCtrl, ( TipoMovimientoEdicion in [ tmOferta, tmPedidoCompra ] ) and not Compras_FechaRecepcionPorLinea.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( CodigoOperarioCtrl, ( TipoMovimientoEdicion=tmCompra ) and Compras_Operarios.Value, FCamposOpcionalesVisibles );

       SetEditControlDecimals( PortesCtrl );

       SetupCamposLibres( [ CampoLibre1Ctrl, CampoLibre2Ctrl, CampoLibre3Ctrl, CampoLibre4Ctrl, CampoLibre5Ctrl ] );

       end;

     SetupPanelableCtrl( RevisadoCtrl, TipoMovimientoEdicion=tmOferta );
     SetupPanelableCtrl( RecibidoCtrl, TipoMovimientoEdicion=tmPedidoCompra );
     SetupPanelableCtrl( NoFacturarCtrl, TipoMovimientoEdicion=tmCompra );
     SetupPanelableCtrl( PortesCtrl, TipoMovimientoEdicion=tmCompra );

     GridViewRecibido.Visible := TipoMovimientoEdicion=tmPedidoCompra;
     RecibidoLabel.Visible := GridViewRecibido.Visible;
     RecibidoTotalPanel.Visible := GridViewRecibido.Visible;

     FacturarButton.Visible := TipoMovimientoEdicion=tmCompra;

     If   not FacturarButton.Visible
     then With ButtonContainerPanel do
            begin
            Width := Width - ( FacturarButton.Width - FacturarButton.Margins.Left );
            Left := ( Self.Width div 2 ) - ( Width div 2 );
            end;

     PesoLabel.Visible := DataModule00.DmEmpresaFields.Articulo_Bultos.Value; // Incluye peso y volumen
     PesototalPanel.Visible := PesoLabel.Visible;

     // -------

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoAuxFields := TLineaMovimientoFields.Create( LineaMovimientoAuxTable );
     ArticuloFields := TArticuloFields.Create( Self );
     ClaseFields := TClaseFields.Create( Self );
     EnvaseFields := TClaseFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       GridViewFechaAplicacion.Visible := ( TipoMovimientoEdicion=tmPedidoCompra ) and Compras_FechaRecepcionPorLinea.Value;
       GridViewNumeroSerie.Visible := ( TipoMovimientoEdicion=tmCompra ) and Compras_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := ( TipoMovimientoEdicion=tmCompra ) and Stock_LotesProductos.Value;
       GridViewFechaCaducidad.Visible := ( TipoMovimientoEdicion=tmCompra ) and DataModule00.Trazabilidad and Compras_FechaCaducidad.Value;
       GridViewTipoLinea.Visible:= Stock_TiposLineaMovimiento.Value;
       GridViewCodigoAlmacen.Visible:= Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewPrecioDivisa.Visible := Compras_Divisas.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
	     GridViewBultos.Visible :=  Articulo_Bultos.Value and Compras_EditarBultosAlbaran.Value;
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewLargo.Visible := Compras_Cantidades.Value>0;
       GridViewAncho.Visible := Compras_Cantidades.Value>0;
       GridViewAlto.Visible := Compras_Cantidades.Value>1;

       If   GridViewFechaAplicacion.Visible
       then GridViewFechaAplicacion.Properties.Required := True;

       Movimiento.SetupCamposLibresLineaCompras( GridView, [ GridViewCampoLibre1, GridViewCampoLibre2,GridViewCampoLibre3, GridViewCampoLibre4, GridViewCampoLibre5 ] );

       If   ( TipoMovimientoEdicion=tmCompra ) and ( Articulo_Envase.Value<>0 ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
       then begin

            With GridViewRecibido do
              begin
              Index := GridViewBultos.Index + 1;  // Detrás de los bultos / contenedores
              Visible := True;
              Caption := 'Cant. bruta';
              Options.Editing := True;
              Options.Focusing := True;
              Styles.Content := nil;               // Para desactivar el color de campo fijo
              end;

            GridViewTara.Visible := True;
            GridViewPesoEnvase.Visible := DataModule00.DmEmpresaFields.Articulo_PermitirModificarPeso.Value;

            GridViewCantidad.HeaderHint := 'Cantidad neta';
            end;

       GridViewTieneDocumentosAsociados.Visible := ( TipoMovimientoEdicion=tmPedidoCompra) and Movimiento.ModuloHojasDePedido;
       If   GridViewTieneDocumentosAsociados.Visible
       then begin
            TableViewManager.OnShowDocument := DoShowDocument;
            AsignarAlmacenButton.Visible := True;
            end;

       SetColumnsDecimals( [ GridViewCantidad, GridViewPesoEnvase, GridViewTara, GridViewRecibido, GridViewCampoLibre4 ], Compras_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewPuntoVerde ], Compras_DecPrecio.Value );  
       SetColumnDecimals( GridViewDescuento, Compras_DecDto.Value );
       SetColumnDecimals( GridViewImporte );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Compras_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Compras_DecCajas.Value );
       SetColumnDecimals( GridViewBultos, 0 );

       // Sumatorios

       SetFooterSummaryItemsDecimals( GridView, [ 0, 1 ], Compras_DecCantidad.Value );
       SetFooterSummaryItemDecimals( GridView, 2, 3 );
       SetFooterSummaryItemsDecimals( GridView, [ 3, 4 ] );

       If   not ValueIsEmpty( Compras_NombreCajas.Value )
       then If   Compras_Cantidades.Value=2
            then GridViewAlto.Caption := DataModule00.DmEmpresaFields.Compras_NombreCajas.Value
            else GridViewNroCajas.Caption := DataModule00.DmEmpresaFields.Compras_NombreCajas.Value;

       If   GridViewBultos.Visible and ( Compras_NombreBultos.Value<>'' )
       then GridViewBultos.Caption := Compras_NombreBultos.Value;
	   
       end;

     If   TipoMovimientoEdicion<>tmCompra
     then FormManager.OnLabelsRequest := nil;
     
     SetBarItemsVisible( [ FacturaCompraItem ], TipoMovimientoEdicion=tmCompra );

     Grid.ShowHint := True;
     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesCompras );

     RejillaPopupMenu.Images := ApplicationForms.ControlsImageList;

     BrowseMovimientoTable.SetRange( [ TipoMovimientoEdicion, ApplicationContainer.FirstDayOfYearDate ], [ TipoMovimientoEdicion, ApplicationContainer.LastDayOfYearDate ] );
     MovimientoTable.SetDefaultRangeValues( [ TipoMovimientoEdicion, ApplicationContainer.Ejercicio ], [ TipoMovimientoEdicion, ApplicationContainer.Ejercicio ] );

     SetFieldRange( MovimientoFields.NroDocumento );

end;

function TMntMcoForm.DoShowDocument: Boolean;
begin
     EditarRelacionDocumentos( LineaMovimientoFields.NroRegistroOrigen.Value, DoOnCloseRelacionDocumentos );
end;

procedure TMntMcoForm.DoOnCloseRelacionDocumentos;
begin
     TableViewManager.RefreshGrid;
end;

procedure TMntMcoForm.FormManagerLabelsRequest;
begin
     With MovimientoFields do
       EtiquetasArticulosDesdeMovimientos( TipoMovimientoEdicion, Serie.Value, NroDocumento.Value, Propietario.Value );
end;

function TMntMcoForm.GetLineaMovimientoFields : TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoFields ) and LineaMovimientoTable.Active
     then FLineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     Result := FLineaMovimientoFields;
end;

procedure TMntMcoForm.ObtenExistencias;
begin
     ObtenyMuestraExistencias( GridView,
                               TableViewManager,
                               LineaMovimientoFields,
                               ExistenciasArticulo,
                               '',
                               StockFrame );
end;

procedure TMntMcoForm.NoFacturarCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TMntMcoForm.NroPedidoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosCompra( TipoMovimientoEdicion, sdTodos, Propietario, Sender, qgsLinked );
end;

procedure TMntMcoForm.GridExit(Sender: TObject);
begin
     ObtenExistencias;  // Para ocultar el panel
end;

procedure TMntMcoForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntMcoForm.GridViewCantidadPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   MovimientoTable.CanEditRecord
     then If   ( TipoMovimientoEdicion=tmOferta ) and ( VarToDecimal( DisplayValue )<0.0 )
          then begin
               Error := True;
               ErrorText := RsMsg7;
               end
          else If   LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoCompra
               then Movimiento.CompruebaCantidadPendientePedido( DisplayValue, LineaMovimientoFields, ErrorText, Error  );;
end;

procedure TMntMcoForm.GridViewCantidadPropertiesValuePosted(Sender: TObject);
begin

     //* 17.09.2011  Cantidad es una columna bastante especial, que se intenta validar siempre. Sin embargo, cuando
     //              el registro está bloqueado hay que tenerlo en cuenta para no intentar modificar los valores del registro

     If   MovimientoTable.CanEditRecord
     then With GridViewCantidad do
            If   Editing
            then begin

                  If   ValueIsEmpty( EditValue )
                  then Movimiento.LimpiaImportesLinea( LineaMovimientoFields )
                  else ActualizaRelaciones;

                  ActualizaCamposCalculadosLinea;
                  end;
end;

procedure TMntMcoForm.GridViewCellClick(     Sender        : TcxCustomGridTableView;
                                             ACellViewInfo : TcxGridTableDataCellViewInfo;
                                             AButton       : TMouseButton;
                                             AShift        : TShiftState;
                                         var AHandled      : Boolean );
begin
     If   ( ACellViewInfo.Item.Index=GridViewDocumentoOrigen.Index ) and VarToBoolean( ACellViewInfo.Item.EditValue )
     then begin
          MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
          AHandled := True;
          end
     else If   ( ACellViewInfo.Item.Index=GridViewTieneDocumentosAsociados.Index ) and VarToBoolean( ACellViewInfo.Item.EditValue )
          then begin
               DoShowDocument;
               AHandled := True;
               end;
end;

procedure TMntMcoForm.GridViewCellDblClick(     Sender        : TcxCustomGridTableView;
                                                ACellViewInfo : TcxGridTableDataCellViewInfo;
                                                AButton       : TMouseButton;
                                                AShift        : TShiftState;
                                            var AHandled      : Boolean);
begin
    If   ACellViewInfo.Item=GridViewAnotacion
    then begin
         AHandled := True;
         FormManagerNoteRequest;
         end;
end;

procedure TMntMcoForm.ActualizaRelaciones( Forzar : Boolean = False );
begin
     //* Modificado para que no se alteren las relaciones cuando la línea proviene de otro documento
     If   not ( ( LineaMovimientoTable.State=dsEdit ) and not ValueIsEmpty( LineaMovimientoFields.NroRegistroOrigen.Value ) ) or Forzar
     then Movimiento.ActualizaRelacionesLineaEntrada( MovimientoFields, LineaMovimientoFields, ArticuloFields );
end;

procedure TMntMcoForm.ActualizarRelacionesItemClick( Sender : TObject );
begin
     If   ShowNotification( ntQuestionWarning, RsMsg44, RsMsg45 )=mrYes
     then begin
          Movimiento.RecalculaMovimiento( MovimientoFields );
          MovimientoTable.Refresh;
          end;
end;

procedure TMntMcoForm.GridViewCodigoAlmacenPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntMcoForm.GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
begin
     Almacen.SetDefault( Sender, scCompras, ArticuloFields );
end;

procedure TMntMcoForm.GridViewCodigoAlmacenPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaAlmacenes( Sender, qgsNormal, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
end;

procedure TMntMcoForm.GridViewCodigoAlmacenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scCompras, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
begin
     LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );
end;

procedure TMntMcoForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntMcoForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scCompras, False, Sender );
end;

procedure TMntMcoForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodArticulo : String;

begin
     With GridViewCodigoArticulo do
       If   Editing and not ValueIsEmpty( DisplayValue )
       then begin
            CodArticulo := VarToStr( DisplayValue );
            Articulo.CodigoBarras( CodArticulo, CodClaseA, CodClaseB, CodClaseC, FijarClases, ArticuloFields );
            DisplayValue := Articulo.ReferenciaProveedor( MovimientoFields.Propietario.Value, CodArticulo, False );

            //* 08.11.2010  Dejo introducir códigos de hasta 20 caracteres para la referencia del proveedor, pero debe existir el código interno de -como máximo- 13 caracteres.

            end;
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields, False );
     If   not Error
     then FacturaCompras.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, ProveedorFields, TiposIVAFields );
end;

procedure TMntMcoForm.GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
begin
     With GridViewCodigoArticulo do
       If   Editing 
       then With LineaMovimientoFields do
              try

                LineaMovimientoTable.DisableControls;

                If   FijarClases
                then begin
                     CodigoClaseA.Value := CodClaseA;
                     CodigoClaseB.Value := CodClaseB;
                     CodigoClaseC.Value := CodClaseC;
                     end;

                NumeroSerie.Value := '';
                LoteFabricacion.Value := '';
                Descripcion.Value := ArticuloFields.Descripcion.Value;
                CodigoAlmacen.Value := Almacen.AlmacenPorDefecto( scCompras, ArticuloFields );
                Ubicacion.Value := Almacen.UbicacionPorDefecto( CodigoAlmacen.Value, ArticuloFields );
                
                If   DataModule00.DmEmpresaFields.Compras_Cantidades.Value>0
                then begin
                     Largo.Value := ArticuloFields.Largo.Value;
                     Ancho.Value := ArticuloFields.Ancho.Value;
                     end;

                If   DataModule00.DmEmpresaFields.Compras_Cantidades.Value>1
                then Alto.Value := ArticuloFields.Alto.Value;

                Precio.Value := 0.0;
                Descuento.Value := 0.0;

                If   Cantidad.Value<>0.0
                then ActualizaRelaciones( { Forzar } True );

                ActualizaCamposCalculadosLinea;

                ObtenExistencias;

              finally
                LineaMovimientoTable.EnableControls;
                GridView.DataController.UpdateData;
                end;

     FijarClases := False;
end;

procedure TMntMcoForm.GridViewCodigoClasePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Column : TcxGridColumn;

begin

     With TableViewManager do
       If   ValidatingTableView
       then Column := ValidatingColumn
       else Column := GridView.Controller.FocusedColumn;

     If   Assigned( Column )
     then begin
          Clase.Valida( TNroClase( Column.Tag ), False, Sender, DisplayValue, ErrorText, Error, ClaseFields );
          If   DataModule00.DmEmpresaFields.Articulo_Envase.Value=Column.Tag   // La clase que acabamos de validar es el envase
          then If   ArticuloFields.ConEnvase.Value and ValueIsEmpty( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg171, RsMsg34 );
                    end
               else begin
                    EnvaseFields.Update( ClaseFields.Dataset );
                    ExisteEnvase := not Error and not ValueIsEmpty( DisplayValue );             
                    If   Column.Editing
                    then ActualizaValorCantidadyEnvases( LineaMovimientoFields.NroCajas.Value );
                    end;
          end;
end;

procedure TMntMcoForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntMcoForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   ShowFocusedRowHighlited and AViewInfo.GridRecord.Focused
     then ACanvas.Brush.Color := clRowHighlight
     else If   not AViewInfo.Selected and AViewInfo.Item.Options.Editing
          then With AViewInfo.GridRecord do
                 If   VarToBoolean( Values[ GridViewProcesada.Index ] )
                 then ACanvas.Brush.Color := cl3DLight;
end;

procedure TMntMcoForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaClases( TNroClase( GridView.Controller.FocusedColumn.Tag ), CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, '', Sender );
end;

procedure TMntMcoForm.GridViewAfterSummary(ASender: TcxDataSummary);
begin
     With ASender, DataModule00.DmEmpresaFields  do
       If   LineaMovimientoTable.Active
       then begin

            CantidadTotal := VarToDecimal( FooterSummaryValues[ 0 ] );
            CantidadProcesadaTotal := VarToDecimal( FooterSummaryValues[ 1 ] );
            PesoTotal := VarToDecimal( FooterSummaryValues[ 2 ] );
            ImporteTotal := VarToDecimal( FooterSummaryValues[ 3 ] );

            MuestraTotales;
            end;

     Movimiento.InicializaValoresImpositivos( TasasArray );
end;

procedure TMntMcoForm.MuestraTotales;

var  SumaTasas : TTasaRecord;
     CuotaIVAPortes,
     TotalIVAIncluido : Decimal;

begin
     If   Assigned( ProveedorFields.Factura_ModeloIVA )
     then With DataModule00.DmEmpresaFields do
            begin

            FacturaCompras.AcumulaValoresImpositivos( TasasArray, MovimientoFields.Fecha.Value, ProveedorFields.Factura_ModeloIVA.Value, CalcularIVA, SumaTasas );

            ImporteNetoTotal := SumaTasas.BaseImponible;

            FooterPanelCantidad.Caption := StrFormat( CantidadTotal, Compras_DecCantidad.Value );
            FooterPanelRecibido.Caption := StrFormat( CantidadProcesadaTotal, Compras_DecCantidad.Value );
            FooterPanelPeso.Caption := StrFormat( PesoTotal );
            FooterPanelImporte.Caption := StrFormat(  ImporteNetoTotal, DecimalesMoneda );

            If   ProveedorFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ]
            then CuotaIVAPortes := 0.0
            else FacturaCompras.ObtenCuotaPortes( MovimientoFields.Portes.Value, MovimientoFields.Fecha.Value, ProveedorFields.Factura_ModeloIVA.Value, CuotaIVAPortes );

            TotalIVAIncluido := SumaTasas.Importe + MovimientoFields.Portes.Value + CuotaIVAPortes;

            FooterPanelIVAIncluido.Caption := StrFormat( TotalIVAIncluido, DecimalesMoneda );
            end;
end;

procedure TMntMcoForm.GridViewUpdatePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMcoForm.GridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   TabKey and not ShiftKey and GridView.DataController.IsEditing
     then If   AFocusedItem=GridViewDescripcion
          then begin
               If   GridViewDescripcion.EditValue<>''
               then With GridView.Controller do
                      FocusedColumnIndex := FocusedColumnIndex + 1;
               end
          else If   ( APrevFocusedItem=GridViewNroCajas ) and DataModule00.Envases and not ExisteEnvase
               then GridView.Controller.FocusedColumnIndex := GridViewCantidad.VisibleIndex
               else If   ( APrevFocusedItem=GridViewCantidad ) and ValueIsEmpty( GridViewCantidad.EditValue )
                    then GridView.Controller.GoToNext( True );

end;

procedure TMntMcoForm.CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperarios( [ '' { Todos }, Sender.EditingValue ] );
end;

procedure TMntMcoForm.CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender );
end;

procedure TMntMcoForm.CodigoOperarioCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                            var DisplayValue : Variant;
                                                            var ErrorText    : TCaption;
                                                            var Error        : Boolean );
begin
     Operario.Valida( '', Sender, DisplayValue, ErrorText, Error);
end;

procedure TMntMcoForm.CompruebaEstadoLineaPedido;
begin
     If   ( TipoMovimientoEdicion=tmPedidoCompra ) and
          ( ( LineaMovimientoFields.CantidadProcesada.Value<>0.0 ) or LineaMovimientoFields.Procesada.Value ) and
          not DandoLineaPorRecibida
     then begin
          ShowHintMsg( RsMsg38, RsMsg39 );
          Abort;
          end;
end;

procedure TMntMcoForm.PreciosButtonClick(Sender: TObject);
begin
     With MovimientoFields do
        CambioPreciosAlbaranesCompra( Ejercicio.Value, NroOperacion.Value );
end;

procedure TMntMcoForm.CopiarAnotacionItemClick(Sender: TObject);
begin
     LineaMovimientoTable.Edit;
     LineaMovimientoFields.Anotacion.Value := ArticuloFields.Anotacion.Value;
     LineaMovimientoTable.Post;
end;

procedure TMntMcoForm.GridViewFocusedRecordChanged( Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     If   MovimientoTable.Editing
     then begin
          ObtenExistencias;
          ActualizaEstadoLineas;
          GridViewAutoEditChanged;
          end;
end;

procedure TMntMcoForm.GridViewAutoEditChanged;

var  FocusedRecord : TcxCustomGridRecord;
     ExisteDocumentoOrigen,
     Dlm : Boolean;

begin

     FocusedRecord := GridView.Controller.FocusedRecord;
     If   Assigned( FocusedRecord )
     then begin

          ExisteDocumentoOrigen := not ValueIsEmpty( FocusedRecord.Values[ GridViewNroRegistroOrigen.Index ] );

          // TableViewManager.DocumentActive := ExisteDocumentoOrigen;

          // Las columnas se pueden editar mientras el registro no esté bloqueado o si es un pedido y la línea no ha sido aún parcial o totalmente servida servida

          Dlm := MovimientoDataSource.AutoEdit or ( ( TipoMovimientoEdicion=tmPedidoCompra ) and ( MovimientoFields.Situacion.Value=epParcialmenteProcesado ) and ( FocusedRecord.Values[ GridViewRecibido.Index ]=0.0 ) and not ( VarToBoolean( FocusedRecord.Values[ GridViewProcesada.Index ] ) ) );

          If   Dlm<>DatosLineaModificables
          then begin
               DatosLineaModificables := Dlm;
               SetColumnsEditingOption( GridView, DatosLineaModificables );
               end;

          // El lote y el número se serie se pueden modificar siempre

          GridViewLoteFabricacion.Properties.ReadOnly := False;
          GridViewNumeroSerie.Properties.ReadOnly := False;

          // El código del artículo no se pueden modificar si la línea proviene de otro documento
          // Las clases tampoco deberían modificarse pero, por imperativo clientelar, he tenido que dejar que se puedan modificar en algunos casos

          GridViewCodigoArticulo.Properties.ReadOnly := not DatosLineaModificables or ExisteDocumentoOrigen;

          end
     else If   not DatosLineaModificables  // Aqui confío en que la primera vez que se ejecuta esta función, FocusedRecord no está asignado, de forma que se inicializa el estado de la variable
          then begin
               DatosLineaModificables := True;
               SetColumnsEditingOption( GridView, True );
               end;

end;

procedure TMntMcoForm.GridViewImporteGetCellHint(       Sender           : TcxCustomGridTableItem;
                                                        ARecord          : TcxCustomGridRecord;
                                                        ACellViewInfo    : TcxGridTableDataCellViewInfo;
                                                  const AMousePos        : TPoint;
                                                  var   AHintText        : TCaption;
                                                  var   AIsHintMultiLine : Boolean;
                                                  var   AHintTextRect    : TRect );
var  CodigoTipoIVA : SmallInt;

begin
     If   VarToDecimal( ARecord.Values[ GridViewCantidad.Index ] )<>0.0
     then begin
          CodigoTipoIVA := ARecord.Values[ GridViewCodigoTipoIVA.Index ];
          Tasa.TipoIVA( MovimientoFields.Fecha.Value, CodigoTipoIVA, TiposIVAFields );
          AHintText := 'I.V.A. = ' + StrFormat( TiposIVAFields.IVASoportado.Value, 1 ) + '%';
          AIsHintMultiLine := False;
          AHintTextRect.Top := AHintTextRect.Top + ACellViewInfo.Height;
          end;
end;

procedure TMntMcoForm.GridViewImporteGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                         ARecord : TcxCustomGridRecord;
                                                     var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporte.Index ] ), DecimalesMoneda, True );
end;

procedure TMntMcoForm.GridViewImporteTotalGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporteTotal.Index ] ), DecimalesMoneda, True );
end;

procedure TMntMcoForm.GridViewInitEdit(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
     ObtenExistencias;

     // Estos mensajes son solo para que el usuario sepa el motivo por el que no se pueden editar

     If   ( TipoMovimientoEdicion=tmPedidoCompra ) and
          ( ( LineaMovimientoFields.CantidadProcesada.Value<>0.0 ) or LineaMovimientoFields.Procesada.Value )
     then ShowHintMsg( RsMsg38, RsMsg39 )
     else If   ( AItem=GridViewCodigoArticulo ) or
               ( AItem=GridViewCodigoClaseA ) or
               ( AItem=GridViewCodigoClaseB ) or
               ( AItem=GridViewCodigoClaseC )
          then If   Assigned( AItem.Properties ) and AItem.Properties.ReadOnly
               then ShowHintMsg( RsMsg40, RsMsg41 );
end;

procedure TMntMcoForm.ActualizaValorCantidad( Value : Decimal );
begin
     GridViewCantidad.EditValue := Value;
     LineaMovimientoFields.Cantidad.Value := Value;
     ActualizaRelaciones;
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMcoForm.ActualizaValorCantidadyEnvases( NroCajas : Double );

var  Cantidad : Double;

begin
     If   NroCajas<>0.0
     then try
     
            LineaMovimientoTable.DisableControls;

            With DataModule00.DmEmpresaFields do
              begin

              If   ( Articulo_Envase.Value<>0 ) and
                   ExisteEnvase and
                   ( EnvaseFields.Capacidad.Value<>0.0 )
              then Cantidad := NroCajas * EnvaseFields.Capacidad.Value
              else Cantidad := NroCajas * ArticuloFields.UnidadesPorCaja.Value;

              If   ( Articulo_Envase.Value<>0 ) and ExisteEnvase and ( EnvaseFields.Peso.Value<>0.0 )
              then LineaMovimientoTablePesoEnvase.Value := EnvaseFields.Peso.Value
              else LineaMovimientoTablePesoEnvase.Value := 0.0;

              end;

            ActualizaValorCantidad( Cantidad );

          finally
            LineaMovimientoTable.EnableControls;
            end;
end;

procedure TMntMcoForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
end;

procedure TMntMcoForm.AsignarAlmacenButtonClick(Sender: TObject);
begin
     AsignacionAlmacen( DoOnAsignaAlmacen );
end;

procedure TMntMcoForm.DoOnAsignaAlmacen( CodigoAlmacen : String );
begin
     With LineaMovimientoTable do
       begin
       DisableControls;
       try
         First;
         While not Eof do
           begin
           Edit;
           LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacen;
           Post;
           Next;
           end;
       finally
         EnableControls;
         TableViewManager.RefreshGrid;
         end;
       end;
end;

procedure TMntMcoForm.MostrarAviso;
begin
     ShowWarning( ProveedorFields.Aviso );
end;

procedure TMntMcoForm.AvisoButtonClick(Sender: TObject);
begin
     MostrarAviso;
end;

procedure TMntMcoForm.LineasDocumentoItemClick(Sender: TObject);
begin
     With MovimientoFields do
       RelacionLineasDocumento( TipoMovimientoEdicion, Ejercicio.Value, NroOperacion.Value, Serie.Value, NroDocumento.Value );
end;

procedure TMntMcoForm.GridViewNroCajasPropertiesValuePosted(Sender: TObject);
begin
     With GridViewNroCajas do
       If   Editing
       then ActualizaValorCantidadyEnvases( EditValue );
end;

procedure TMntMcoForm.GridViewPesoEnvasePropertiesValuePosted(Sender: TObject);
begin
     ActualizaTara;
end;

procedure TMntMcoForm.GridViewPrecioDivisaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposCambio( MovimientoFields.Fecha.Value );
end;

procedure TMntMcoForm.GridViewPrecioDivisaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoCambio.Valida( CodigoDivisa, MovimientoFields.Fecha.Value, TipoDeCambio, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.GridViewPrecioDivisaPropertiesValuePosted(Sender: TObject);
begin
     With GridViewPrecioDivisa do
       If   Editing and ( LineaMovimientoFields.PrecioDivisa.Value<>0.0 )
       then begin
            LineaMovimientoFields.Precio.Value := LineaMovimientoFields.PrecioDivisa.Value * TipoDeCambio;
            ActualizaCamposCalculadosLinea;
            end;
end;

procedure TMntMcoForm.GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg17;
end;

procedure TMntMcoForm.GridViewPrecioPropertiesExtendedFunction(Sender: TcxCustomEdit);

var  Precio : Double;

begin
     If   Sender.DoEditing
     then With ArticuloFields do
            begin
            Movimiento.ObtenPrecioCompraBase( TiposIVAFields, VarAsType( Sender.EditingValue, varDouble ), Precio );
            With Sender do
              begin
              PostEditValue( RedondeaExt( Precio, DataModule00.DmEmpresaFields.Compras_DecPrecio.Value ) );
              SelectAll;
              end;
            end;
end;

procedure TMntMcoForm.GridViewPuntoVerdePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Value := VarToDecimal( DisplayValue );
     If   Value>LineaMovimientoFields.Precio.Value
     then begin
          Error := True;
          ErrorText := RsMsg18;
          end;
end;

procedure TMntMcoForm.GridViewRecibidoGetDataText(     Sender       : TcxCustomGridTableItem;
                                                       ARecordIndex : Integer;
                                                   var AText        : String );

var  CantidadRecibida : Decimal;

begin
     With GridView.DataController do
       If   VarToBoolean( Values[ ARecordIndex, GridViewProcesada.Index ] )
       then CantidadRecibida := VarToDecimal( Values[ ARecordIndex, GridViewCantidad.Index ] )
       else CantidadRecibida := VarToDecimal( Values[ ARecordIndex, GridViewRecibido.Index ] );
     AText := StrFormat( CantidadRecibida, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value, True );
end;

procedure TMntMcoForm.GridViewRecibidoPropertiesValuePosted(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       If   ( TipoMovimientoEdicion=tmCompra ) and
            ( Articulo_Envase.Value<>0 ) and
            ( Articulo_TipoEnvase.Value=tenReutilizable )
       then If   EnvaseFields.Initialized
            then If   EnvaseFields.Peso.Value<>0.0
                 then begin
                      LineaMovimientoTablePesoEnvase.Value := EnvaseFields.Peso.Value;
                      ActualizaTara;
                      end;                 
end;

procedure TMntMcoForm.ActualizaTara;
begin
     LineaMovimientoFields.Tara.Value := LineaMovimientoTableNroCajas.Value * LineaMovimientoTablePesoEnvase.Value;
     ActualizaValorCantidad( LineaMovimientoTableCantidadProcesada.Value - LineaMovimientoFields.Tara.Value );
end;

procedure TMntMcoForm.GridViewDimensionPropertiesValuePosted(Sender: TObject);
begin
     With GridView.Controller.FocusedColumn do
        If   Editing
        then With LineaMovimientoFields do
               ActualizaValorCantidad( Movimiento.CalculoEspecial( scCompras, Largo.Value, Ancho.Value, Alto.Value ) );
end;

procedure TMntMcoForm.GridViewFooterSummaryItems(     ASender      : TcxDataSummaryItems;
                                                      Arguments    : TcxSummaryEventArguments;
                                                  var OutArguments : TcxSummaryEventOutArguments );

var  TipoDeIVA : SmallInt;
     Cp : Decimal;

begin
     If   Arguments.SummaryItem.Index=1
     then With GridView.DataController, Arguments do
            begin

            If   VarToBoolean( GetValue( RecordIndex, GridViewProcesada.Index ) )
            then Cp := VarToDecimal( GetValue( RecordIndex, GridViewCantidad.Index ) )
            else Cp := VarToDecimal( GetValue( RecordIndex, GridViewRecibido.Index ) );

            OutArguments.SummaryValue := OutArguments.SummaryValue + Cp;
            end
     else If   Assigned( ArticuloFields ) and ( Arguments.SummaryItem.Index=4 )  // CuotaIVA
          then With GridView.DataController, Arguments do
                 begin
                 TipoDeIVA := VarToSmallInt( GetValue( RecordIndex, GridViewCodigoTipoIVA.Index ) );
                 If   TipoDeIVA in [ 0..NroMaximoTiposTasas ]
                 then begin
                      DecAdd( TasasArray[ TipoDeIVA ].BaseImponible, VarToDecimal( GetValue( RecordIndex, GridViewImporte.Index ) ) );
                      DecAdd( TasasArray[ TipoDeIVA ].CuotaIVA, VarToDecimal( GetValue( RecordIndex, GridViewCuotaIVA.Index ) ) );
                      DecAdd( TasasArray[ TipoDeIVA ].Importe, VarToDecimal( GetValue( RecordIndex, GridViewImporteTotal.Index ) ) );
                      end;
                 end;

end;

procedure TMntMcoForm.GridViewTipoLineaPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntTiposLineaMovimiento( [ Sender.EditingValue ] );
end;

procedure TMntMcoForm.GridViewTipoLineaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposLineaMovimiento( Sender );
end;

procedure TMntMcoForm.GridViewTipoLineaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoLineaMovimiento.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.GridViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       MntUbicaciones( [ CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntMcoForm.GridViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( LineaMovimientoFields.CodigoAlmacen.Value, ubNormal, Sender );
end;

procedure TMntMcoForm.GridViewUbicacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( LineaMovimientoFields.CodigoAlmacen.Value, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.ImportarButtonClick(Sender: TObject);

var  TiposMovimientoOrigen : TTiposMovimiento;

begin
     MovimientoTable.Update;
     case TipoMovimientoEdicion of
       tmPedidoCompra : TiposMovimientoOrigen := [ tmOferta, tmPedidoVenta, tmCapturador ];
       tmCompra       : TiposMovimientoOrigen := [ tmOferta, tmPedidoCompra, tmPedidoVenta, tmCapturador ];
     end;
     SeleccionaDocumento( MovimientoFields.Propietario.Value, DoSeleccionaDocumento, TipoMovimientoEdicion, TiposMovimientoOrigen );
end;

procedure TMntMcoForm.KeyPanelEnter(Sender: TObject);
begin
     ActualizaEstado;
end;

procedure TMntMcoForm.DoSeleccionaDocumento;

	

begin
     With BoxSdcForm do
       begin
       UltimoTipoMovimientoImportado := DataTipoMovimiento.Value;
       case DataTipoMovimiento.Value of
         tmOferta,
         tmPedidoCompra,
         tmCompra :
           SeleccionaLineasDocumentoCompra( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, TipoMovimientoEdicion, DoOnLineasImportadas );
         tmPedidoventa :
           
           SeleccionaLineasDocumentoVenta( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, TipoMovimientoEdicion, DoOnLineasImportadas );

         tmCapturador :
           ImportaDatosCapturador( FicheroDatosBox.Caption );
         end;
       end;
end;


procedure TMntMcoForm.ImportaDatosCapturador( DataPath : String );
begin
     try
       Movimiento.ImportaDatosCapturador( MovimientoFields,
                                          LineaMovimientoFields,
                                          DataPath,
                                          DataModule00.DmEmpresaFields.Compras_AlmacenDefec.Value );
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

procedure TMntMcoForm.DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields;
                                            CopiarDatosCabecera, 
                                            NoVincularDocumentos   : Boolean; 
                                            LineArray              : TLongIntArray );
var  I : SmallInt;

begin

     Movimiento.InsertaLineasDocumento( MovimientoOrigenFields, MovimientoFields, LineArray );
     
     If   CopiarDatosCabecera
     then begin
          MovimientoFields.RegistroAuxiliar.Value := MovimientoOrigenFields.RegistroAuxiliar.Value;
          MovimientoFields.CentroCoste.Value := MovimientoOrigenFields.CentroCoste.Value;
          MovimientoFields.CodigoOperario.Value := MovimientoOrigenFields.CodigoOperario.Value;
          For I := 1 to 5 do
            MovimientoFields.CampoLibre[ I ].Value := MovimientoOrigenFields.CampoLibre[ I ].Value;
          FormManager.ValidateDataArea( faData );
          end;
          
     GridView.DataController.UpdateItems( False );
     GridView.DataController.GotoLast;
     Grid.SetFocus;
     
end;

procedure TMntMcoForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
end;

procedure TMntMcoForm.ExportarButtonClick(Sender: TObject);

var  TiposMovimientoDestino : TTiposMovimiento;
     CodigoPropietario : String;

begin

     CodigoPropietario := MovimientoFields.Propietario.Value;

     FormManager.CheckDetailRecords;
     case TipoMovimientoEdicion of
       tmOferta       : TiposMovimientoDestino := [ tmPedidoCompra, tmCompra ];
       tmPedidoCompra : TiposMovimientoDestino := [ tmCompra, tmPedidoVenta ];
       tmCompra       : begin
                        TiposMovimientoDestino := [ tmVenta ];
                        CodigoPropietario := '';
                        end;
     end;

     ExportaDocumentoCompra( CodigoPropietario,
                             TiposMovimientoDestino,
                             TipoMovimientoEdicion,
                             MovimientoFields,
                             DoOnExportaDocumento );
                             
end;

procedure TMntMcoForm.DoOnExportaDocumento;
begin

     TipoMovimientoDestino :=  BoxEdcForm.DataTipoMovimiento.Value;
     CodigoPropietarioDestino :=  BoxEdcForm.DataPropietario.Value;
     SerieDestino := BoxEdcForm.DataSerie.Value;
     NroDocumentoDestino := BoxEdcForm.DataNroDocumento.Value;
     DocumentoAutomatico := BoxEdcForm.DataDocumentoAutomatico.Value;
     TodasLasLineas := BoxEdcForm.DataTodasLasLineas.Value;
                                                       
     If   TodasLasLineas
     then DoOnLineasExportadas( MovimientoFields  )
     else SeleccionaLineasDocumentoCompra( TipoMovimientoEdicion,
                                           MovimientoFields.Ejercicio.Value,
                                           MovimientoFields.NroOperacion.Value,
                                           TipoMovimientoDestino,
                                           DoOnLineasExportadas );
                                     
end;

procedure TMntMcoForm.DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields; 
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
                                                       False,
                                                       DocumentoAutomatico );
     If   Assigned( MovimientoDestino )
     then With MovimientoDestino do
            If   VarToInteger( TipoMovimiento ) in [ tmPresupuesto, tmPedidoventa, tmVenta ]
            then MntMovimientosVenta( [ TipoMovimiento, Ejercicio, Serie, NroDocumento] )
            else MntMovimientosCompra( [ TipoMovimiento, Ejercicio, Propietario, Serie, NroDocumento ] );
     
     If   TipoMovimientoEdicion=tmPedidoCompra
     then GridView.DataController.UpdateItems( False );  // Actualizando las cantidades recibidas en la rejilla
          
end;

procedure TMntMcoForm.CentroCosteCtrlPropertiesEditRequest( Sender: TcxCustomEdit );
begin
     MntCentrosCoste( [ Sender.EditValue ] );
end;

procedure TMntMcoForm.CentroCosteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit );
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntMcoForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.FormManagerReportFormRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( True, TipoMovimientoEdicion, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value );
end;

procedure TMntMcoForm.FormManagerNoteRequest;
begin
     If   GridView.IsControlFocused
     then MntAnotacion( LineaMovimientoFields.Anotacion, RsAnotacionLinea )
     else MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
     FormManagerUpdateButtonsState;
end;

procedure TMntMcoForm.FormManagerPreparedForm;
begin
     With LineaMovimientoFields do
       begin
       SetFieldRange( NroPagina, 0 );
       SetFieldRange( NroLinea );
       end;

     With DataModule00 do
       If   Usuario.OpcionUsuario( DmUsuarioFields.Compras_MostrarStock, DmEmpresaFields.Compras_VerStock )
       then If   not Assigned( StockFrame )
            then begin
                 StockFrame := CreaPanelStock( scCompras, TopPanel, GridView );
                 TopPanel.Constraints.MinHeight := ScaledToCurrent( 90 );
                 end;

     If   FCamposOpcionalesVisibles>0
     then TopScrollBox.VertScrollBar.Range := FCamposOpcionalesVisibles * RegistroAuxiliarPanel.Height;

     If   FCamposLibresVisibles>0
     then CamposLibresScrollBox.VertScrollBar.Range := FCamposLibresVisibles * CLScrollBoxPanel1.Height;

end;

procedure TMntMcoForm.FormManagerQueryGridRequest;
begin
     With MovimientoFields do
       ConsultaMovimientosCompra( TipoMovimientoEdicion, sdTodos, Propietario, NroDocumentoCtrl, qgsDetached );
end;

procedure TMntMcoForm.FormManagerReportRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( False, TipoMovimientoEdicion, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value );
end;

procedure TMntMcoForm.FormManagerSetupToolBar(Enable: Boolean);
begin
     If   Enable
     then With ApplicationContainer do
            NoteButton.Enabled := NoteButton.Enabled or FormManager.DataAreaFocused;
end;

procedure TMntMcoForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TMntMcoForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( MovimientoFields )
     then begin
          If   not MovimientoTable.UpdatingProcess
          then begin
               AnotacionButton.Visible := MovimientoFields.Anotacion.Value<>'';
               AnotacionButton.Enabled := MovimientoTable.Editing;
               end;
          ImportarButton.Enabled := ( TipoMovimientoEdicion in [ tmPedidoCompra, tmCompra ] ) and MovimientoTable.Editing;
          PreciosButton.Enabled := ( TipoMovimientoEdicion=tmCompra ) and MovimientoTable.Editing;
          FacturarButton.Enabled := ( TipoMovimientoEdicion=tmCompra ) and ( MovimientoTable.State=dsEdit ) and not MovimientoFields.NoFacturar.Value and ( LineaMovimientoTable.RecordCount>0 );
          ExportarButton.Enabled := FormManager.DataAreaFocused and ( MovimientoTable.State in [ dsBrowse, dsEdit ] );
          DeleteButton.Enabled := DeleteButton.Enabled and not MovimientoFields.Facturado.Value;
          EnviarButton.Enabled := ( MovimientoTable.State=dsEdit ) and not MovimientoFields.Suministrado.Value;
          end;
end;

procedure TMntMcoForm.LineaMovimientoTableAfterEdit(DataSet: TDataSet);
begin
     If   GridView.Controller.IsEditing
     then begin
          ExisteEnvase := Movimiento.ObtenEnvaseLinea( LineaMovimientoFields, EnvaseFields );
          ObtenExistencias;
          end;
end;

procedure TMntMcoForm.LineaMovimientoTableBeforeEdit(DataSet: TDataSet);
begin
     ExisteEnvase := False;
     CompruebaEstadoLineaPedido;
end;

procedure TMntMcoForm.LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
begin

     // Si el cursor está situado sobre una columna no editable (ReadOnly) al iniciarse la edición el estado persiste

     If   GridView.Controller.EditingController.InsertingRecord
     then begin
          SetColumnsEditingOption( GridView, True );
          ExisteEnvase := False;
          EnvaseFields.Clear;
          end;
end;

procedure TMntMcoForm.LineaMovimientoTableBeforePost(DataSet: TDataSet);
begin
      // Las devoluciones deben trazarse?
      If   not LineaMovimientoTable.ControlsDisabled
      then begin
           ActualizaCamposCalculadosLinea;
           DesglosarLinea := ListaMateriales.RequiereDesglose( MovimientoFields, LineaMovimientoFields, ArticuloFields );
           end;
end;

procedure TMntMcoForm.LineaMovimientoTableCalcFields(DataSet: TDataSet);
begin
     LineaMovimientoTableTieneRegistroOrigen.Value := not ValueIsEmpty( LineaMovimientoTableNroRegistroOrigen.Value );

     If   FMostrarNroDocumentoOrigen and LineaMovimientoTableTieneRegistroOrigen.Value
     then If   Movimiento.ObtenRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, True )
          then begin
               LineaMovimientoTableSerieOrigen.Value := Movimiento.DmMovimientoFields.Serie.Value;
               LineaMovimientoTableNroDocumentoOrigen.Value := Movimiento.DmMovimientoFields.NroDocumento.Value;
               end;

     If   Movimiento.ModuloHojasDePedido and ( LineaMovimientoTableNroRegistroOrigen.Value<>0 )
     then LineaMovimientoTableTieneDocumentosAsociados.Value := RelacionDocumentos.TieneDocumentos( LineaMovimientoTableNroRegistroOrigen.Value );
end;

procedure TMntMcoForm.LineaMovimientoTableAfterPost(DataSet: TDataSet);
begin
     If   DesglosarLinea
     then begin
          DesglosarLinea := False;
          ListaMateriales.AplicarDesglose( MovimientoFields, LineaMovimientoFields );
          GridView.DataController.UpdateItems( False );
          GridView.Controller.FocusFirstAvailableItem;
          end;
end;

procedure TMntMcoForm.LineaMovimientoTableNewRecord(DataSet: TDataSet);
begin
     With LineaMovimientoFields do
       begin
       Fecha.Value := MovimientoFields.Fecha.Value;

       If   DataModule00.DmEmpresaFields.Compras_FechaRecepcionPorLinea.Value
       then FechaAplicacion.Value := ApplicationContainer.TodayDate
       else FechaAplicacion.Value := MovimientoFields.FechaAplicacion.Value;

       UIDArticulo.AsGUID := Articulo.Identificador;
       end;
end;

procedure TMntMcoForm.LineaMovimientoTableRecordChanged(DataSet: TDataSet);
begin
     If   LineaMovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atArticulo ] );
end;

procedure TMntMcoForm.LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeLineaMovimiento( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntMcoForm.LineaMovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaLineaMovimiento( MovimientoFields, LineaMovimientoFields, TipoMovimientoEdicion=tmCompra );
end;

procedure TMntMcoForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento
       KeyValues[ 0 ] := TipoMovimientoEdicion;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Proveedor
       KeyValues[ 3 ] := UnAssigned;
       KeyValues[ 4 ] := UnAssigned;
       end;
end;

procedure TMntMcoForm.FacturaCompraItemClick(Sender: TObject);
begin
     With MovimientoFields do
       If   FacturaCompras.Obten( EjercicioFactura.Value, PropietarioFactura.Value, SerieFactura.Value )
       then begin
            FormManager.SelectFirstKeyControl;
            MntFacturasCompra( [ EjercicioFactura.Value, PropietarioFactura.Value, SerieFactura.Value ] );
            end
       else ShowNotification( ntStop, RsMsg10, RsMsg11 );
end;

procedure TMntMcoForm.FacturarButtonClick(Sender: TObject);
begin
     CreaFacturaCompra( ProveedorCtrl, DoOnCreaFactura );
end;

procedure TMntMcoForm.DoOnCreaFactura;

var  ParametrosFacturacion : IParametrosFacturacion;

begin

     // OkButton.SetFocus;

     FormManager.PostCurrentRecord;

     try

       ParametrosFacturacion := TParametrosFacturacion.Create;

       With ParametrosFacturacion do
         begin

         TipoSeleccion := tsDocumento;   // Solo el albaran actual
         Serie := BoxFdcForm.DataSerieNroFactura.Value;
         PropietarioInicial := MovimientoFields.Propietario.Value;
         PropietarioFinal := PropietarioInicial;
         UnaSolaFactura := True;
         SerieInicial := MovimientoFields.Serie.Value;
         SerieFinal := SerieInicial;
         NroDocumentoInicial := MovimientoFields.NroDocumento.Value;
         NroDocumentoFinal := NroDocumentoInicial;
         FechaFacturacion := ApplicationContainer.TodayDate;
         end;

       FacturaCompras.GeneraFacturas( ParametrosFacturacion );

     finally
       FormManager.SelectFirstKeyControl;
       MovimientoTable.Refresh;
       end;

     With MovimientoFields do
       If   SerieFactura.Value<>''  // Solo si se ha conseguido generar la factura
       then MntFacturasCompra( [ EjercicioFactura.Value, PropietarioFactura.Value, SerieFactura.Value ] );

end;

procedure TMntMcoForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, False );
end;

procedure TMntMcoForm.FechaAplicacionCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
begin
     If   ValidateYear( DisplayValue, ErrorText, Error, False, True )
     then ValidateDateRange( drGreaterOrEqual, MovimientoFields.Fecha.Value, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntMcoForm.FichaMovimientosArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value, LineaMovimientoFields.Fecha.Value ] );
end;

function TMntMcoForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := False;
     With MovimientoFields do
       begin
       LineaMovimientoAuxTable.IndexFieldNames := 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen';
       Result := LineaMovimientoAuxTable.FindKey( [ TipoMovimientoEdicion, Ejercicio.Value, NroOperacion.Value ] );
       SetBarItemsVisible( [ LineasDocumentoItem ], Result );
       If   TipoMovimientoEdicion=tmCompra       
       then Result := Result or MovimientoFields.Facturado.Value or ( MovimientoFields.NroOperacionOrigen.Value<>0 );
       end;
end;

procedure TMntMcoForm.FormManagerAutoEditChanged(var Value: Boolean);
begin
     LineaMovimientoDataSource.AutoEdit := True;

     // El cambio de Value solo afecta a las rejillas, los DataSources se actualizan antes de la llamada al evento

     Value := Value or ( ( TipoMovimientoEdicion=tmPedidoCompra ) and ( MovimientoFields.Situacion.Value=epParcialmenteProcesado ) );

     GridViewAutoEditChanged;
end;

function TMntMcoForm.FormManagerCopyCurrentRecord: Boolean;
begin
     With MovimientoFields do
       CopiaDocumentoCompras( TipoMovimiento.Value, Propietario.Value, DoOnCopyCurrentRecord );
     Result := False;
end;

procedure TMntMcoForm.FormManagerFocusedAreaChanged;
begin
     ActualizaEstado;
end;

function TMntMcoForm.FormManagerGetAccessLevel: SmallInt;
begin
     //  Ajuste del tipo de documento

     TipoMovimientoEdicion := FormValues[ 0 ];    // Se ejecuta antes que FormManagerInitializeForm
     
     With DataModule00.DmUsuarioFields do
       case TipoMovimientoEdicion of
         tmOferta :
           Result := CheckAccessLevel( [ acCOMovimientos.Value, acCOOfertas.Value ] );
         tmPedidoCompra :
           Result := CheckAccessLevel( [ acCOMovimientos.Value, acCOPedidos.Value ] );
         tmCompra :
           Result := CheckAccessLevel( [ acCOMovimientos.Value, acCOAlbaranes.Value ] );
         end;
end;

procedure TMntMcoForm.DarPorRecibidaItemClick(Sender: TObject);

var  CantidadRegularizada : Decimal;

begin
     If   MovimientoTable.Editing
     then try
            try
              CantidadRegularizada := Movimiento.DarLineaPorProcesada( MovimientoFields, LineaMovimientoFields );
            finally
             DecAdd( CantidadProcesadaTotal, CantidadRegularizada );
             MovimientoTable.PostAndEdit;
           end;
       except
         FormManager.SelectFirstKeyControl;
         raise;
         end;
end;

procedure TMntMcoForm.DocumentoOrigenItemClick(Sender: TObject);
begin
     FOnMuestraDocumentoOrigen.Invoke( MovimientoFields );
end;

procedure TMntMcoForm.DoOnCopyCurrentRecord;

var  NroOperacionDestino : LongInt;

begin
     With BoxCdcForm do
       begin
       NroOperacionDestino := Movimiento.CopiaMovimiento( MovimientoFields.Ejercicio.Value,
                                                          MovimientoFields.NroOperacion.Value,
                                                          TipoMovimientoEdicion,
                                                          DataCodigoProveedor.Value,
                                                          DataSerie.Value,
                                                          False,
                                                          '',
                                                          { AsignarUbicaciones } False,
                                                          { InvertirCantidades } False,
                                                          { BorrarMovimientoOrigen } DataSuprimir.Value,
                                                          { ActualizarPrecios } DataActualizarPrecios.Value,
                                                          DataNroDocumento.Value );
       If   NroOperacionDestino>0
       then begin

            If   LockRangeButton.Down and
                 ( DataCodigoProveedor.Value<>MovimientoFields.Propietario.Value )
            then LockRangeButton.Unlock;

            If   Movimiento.ObtenMovimiento( ApplicationContainer.Ejercicio, NroOperacionDestino )
            then begin
                 MovimientoTable.GotoCurrent( Movimiento.DmMovimientoTable );
                 Self.FormManager.SelectFirstKeyControl;
                 end;
            end;
       end;
end;

procedure TMntMcoForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesCompras, BoolToStr( MostrarAnotacionesItem.Down, True ) );
end;

procedure TMntMcoForm.MovimientoTableBeforeDelete( DataSet : TDataSet );
begin
     BeforeDeleteMovimiento.Invoke( MovimientoFields );
end;

procedure TMntMcoForm.MovimientoTableBeforeInsert(DataSet: TDataSet);
begin
     If   MovimientoTable.State=dsSetKey
     then Movimiento.CompruebaNroDocumento( FormManager, MovimientoFields );
end;

procedure TMntMcoForm.MovimientoTableBeforePost(DataSet: TDataSet);
begin
     SetFieldValueIfEmpty( MovimientoFields.Serie, '' );

     ActualizaSituacionPedido;

     BeforePostMovimiento.Invoke( MovimientoFields );

end;

procedure TMntMcoForm.ActualizaSituacionPedido;
begin
     With MovimientoFields do
       If   TipoMovimiento.Value=tmPedidoCompra
       then If   DataRecibido.Value
            then Situacion.Value := epProcesado
            else If   CantidadProcesadaTotal=0.0
                 then Situacion.Value := epPendiente
                 else If   CantidadTotal>CantidadProcesadaTotal
                      then Situacion.Value := epParcialmenteProcesado
                      else Situacion.Value := epProcesado;
end;

procedure TMntMcoForm.MovimientoTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

function TMntMcoForm.MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     If   Assigned( MovimientoFields )
     then Result := EjercicioActual( MovimientoFields.Fecha.Value ) and
                    not ( ( TipoMovimientoEdicion=tmPedidoCompra ) and ( MovimientoFields.Situacion.Value=epProcesado ) ) and
                    not ( ( TipoMovimientoEdicion=tmCompra ) and MovimientoFields.Facturado.Value ) and
                    not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value
     else Result := True;
end;

function TMntMcoForm.MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Movimiento.ProximoDocumento( MovimientoFields );
end;

procedure TMntMcoForm.MovimientoTableNewRecord(DataSet: TDataSet);
begin
     With MovimientoFields do
       begin
       NroOperacion.Value := Movimiento.ProximaOperacion;
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaAplicacion.Value := ApplicationContainer.TodayDate;  // Fecha de recepcion
       Revisado.Value := False;
       end;

     DataRecibido.Value := False;
end;

procedure TMntMcoForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );
     Movimiento.OrigenDocumento( MovimientoFields, OrigenLabel );

     Data.Edit;
     DataRecibido.Value := MovimientoFields.Situacion.Value=epProcesado;
     RecibidoAnterior := DataRecibido.Value;
     
     // En este caso el campo que muestra la alerta está en el área de clave
     
     If   not FormManager.FocusingDataPanel and ( MovimientoTable.State=dsBrowse )
     then ApplicationContainer.HideAlerts( [ atProveedor ] );
end;

procedure TMntMcoForm.MovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeMovimiento( MovimientoFields );
end;

procedure TMntMcoForm.MovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaMovimiento( MovimientoFields );
end;

procedure TMntMcoForm.MovimientoTableSetKey(DataSet: TDataSet);
begin

     MovimientoFields.TipoMovimiento.Value := TipoMovimientoEdicion;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   TipoMovimientoEdicion in [ tmOferta, tmPedidoCompra ]
     then MovimientoFields.Serie.Value := '';

     With Data do
       begin
       Edit;
       ClearFields;
       end;
end;

procedure TMntMcoForm.ActualizaCamposCalculadosLinea;
begin
     If   not FActualizandoCamposCalculadosLinea
     then try
            FActualizandoCamposCalculadosLinea := True;
            Movimiento.ActualizaCamposCalculadosLineaCompra( MovimientoFields, LineaMovimientoFields, ProveedorFields, ArticuloFields, TiposIVAFields );
            GridView.DataController.UpdateData;  // Solo se actualiza el registro actual
          finally
            FActualizandoCamposCalculadosLinea := False;
            end;
end;

procedure TMntMcoForm.ActualizaEstado;
begin
     FormManagerUpdateButtonsState;
end;

procedure TMntMcoForm.ActualizaEstadoLineas;
begin
     ShowFocusedRowHighlited := False;
     TableViewManager.Update;
end;

procedure TMntMcoForm.MovimientoTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and not MovimientoTable.ControlsDisabled
     then begin
          LineaMovimientoDataSource.Enabled := MovimientoTable.State<>dsSetKey;
          If   LineaMovimientoDataSource.Enabled
          then ActualizaEstado;
          Movimiento.RetiraDocumento( MovimientoFields );
          end;

     ActualizaVisibilidadAviso( AvisoButton.Visible );

     AsignarAlmacenButton.Enabled := MovimientoTable.State=dsEdit;
end;

procedure TMntMcoForm.ActualizaVisibilidadAviso( Visible : Boolean );
begin
     If   not MovimientoTable.UpdatingProcess
     then AvisoButton.Visible := Visible and ( MovimientoTable.State in [ dsBrowse, dsEdit ] );
end;

procedure TMntMcoForm.RejillaPopupMenuPopup(Sender: TObject);

var  TieneLineas,
     LineaSeleccionada : Boolean;

begin

     If   MovimientoTable.State=dsInsert
     then Abort;

     LineaMovimientoTable.Cancel;

     With LineaMovimientoFields do
       begin
       If   ValueIsEmpty( NroRegistroOrigen.Value ) or not ( TipoMovimientoOrigen.Value in [ tmInventario..tmMaximoUsuario ] )
       then begin
            EditarDocItem.Caption := RsMsg4;
            EditarDocItem.Enabled := False;
            end
       else begin
            EditarDocItem.Enabled := True;
            EditarDocItem.Caption := Format( 'Editar %s origen', [ Movimiento.TextoTipoMovimiento( TipoMovimientoOrigen.Value, False ) ] );
            end;

       TieneLineas := GridView.DataController.RecordCount>0;
       LineaSeleccionada := TieneLineas and Assigned( GridView.Controller.FocusedRow );

       FichaMovimientosArticuloItem.Enabled := LineaSeleccionada and ( CodigoArticulo.Value<>ArticuloManual );
       FichaArticuloItem.Enabled := LineaSeleccionada and ( CodigoArticulo.Value<>ArticuloManual );
       TrazaItem.Enabled := LineaSeleccionada;

       SetBarItemsVisible( [ VincularPedidoItem, SuprimirVinculosItem ], TieneLineas and ( TipoMovimientoEdicion=tmCompra ) );
       SetBarItemsVisible( [ DarPorRecibidaItem ], ( TipoMovimientoEdicion=tmPedidoCompra ) and not DataRecibido.Value );
       SetBarItemsVisible( [ ActualizarRelacionesItem ], TieneLIneas and ( MovimientoTable.State=dsEdit ) );

       CopiarAnotacionItem.Enabled := LineaSeleccionada;

       If   Procesada.Value
       then DarPorRecibidaItem.Caption := 'NO dar por recibida la línea'
       else DarPorRecibidaItem.Caption := 'Dar por recibida la línea';
       DarPorRecibidaItem.Enabled := LineaSeleccionada and ( Cantidad.Value>CantidadProcesada.Value );

       MostrarAnotacionesItem.Down:= GridView.Preview.Visible;

       end;
end;

procedure TMntMcoForm.PortesCtrlPropertiesValuePosted(Sender: TObject);
begin
     GridView.DataController.Summary.Recalculate;
end;

procedure TMntMcoForm.ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntMcoForm.ProveedorCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     MostrarAviso;
end;

procedure TMntMcoForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntMcoForm.SetButtonVisible( Button : TgBitBtn; Value : Boolean );
begin
     Button.Visible := Value;
     If   not Value
     then ButtonContainerPanel.Width := ButtonContainerPanel.Width - ( Button.Width + Button.Margins.Left ); // Solo les pongo margen por la izquierda
end;

procedure TMntMcoForm.SetMostrarNroDocumentoOrigen( const Value : Boolean );
begin
     FMostrarNroDocumentoOrigen := Value;
     GridViewSerieOrigen.Visible := Value;
     GridViewNroDocumentoOrigen.Visible := Value;
end;

procedure TMntMcoForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     AvisoButton.Visible := False;
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, ProveedorFields, False );
     If   not Error
     then begin
          CalcularIVA := ( ProveedorFields.Factura_ModeloIVA.Value<>mipExento ) and not ( ProveedorFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] );
          If   GridViewPrecioDivisa.Visible
          then begin
               GridViewPrecioDivisa.Caption := RsPrecioDivisa;
               CodigoDivisa := ProveedorFields.CodigoDivisa.Value;
               If   not ValueIsEmpty( CodigoDivisa )
               then If   Divisa.Obten( CodigoDivisa, DsDivisaFields, True )
                    then begin
                         GridViewPrecioDivisa.Caption := Format( RsPrecioDivisaCodigo, [ DsDivisaFields.Codigo.Value ] );
                         SetColumnDecimals( GridViewPrecioDivisa, Decimales( DsDivisaFields.PrecisionRedondeo.Value ) );
                         end;
               end;
          ActualizaVisibilidadAviso( ProveedorFields.MostrarAviso.Value and ( ProveedorFields.Aviso.Value<>'' ) );
          end;
end;

procedure TMntMcoForm.RecibidoCtrlPropertiesValuePosted(Sender: TObject);

var  Recibido : Boolean;
     EstadoPedido : TEstadoPedido;

begin
     EstadoPedido := Movimiento.EstadoPedido( MovimientoFields );
     If   not DataRecibido.Value and ( EstadoPedido.Situacion=epProcesado ) and not EstadoPedido.Procesada
     then begin
          ShowNotification( ntWarning, RsMsg15, RsMsg16 );
          DataRecibido.Value := True;
          end
     else try
            Recibido := DataRecibido.Value;
            MovimientoTable.Browse;  // Se necesita editar el registro en el servidor
            CantidadProcesadaTotal := Movimiento.CambiaSituacionPedido( MovimientoFields.NroOperacion.Value, Recibido );
          finally
            FormManager.SelectFirstKeyControl;
            end;
end;

procedure TMntMcoForm.RegistroAuxiliarCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAuxiliarProveedores( [ MovimientoFields.Propietario.Value, Sender.EditingValue ] );
end;

procedure TMntMcoForm.RegistroAuxiliarCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarProveedores( Sender, ProveedorCtrl.EditValue );
end;

procedure TMntMcoForm.RegistroAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarProveedor.Valida( MovimientoFields.Propietario.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMcoForm.RelacionesPopupMenuPopup(Sender: TObject);
begin
     With MovimientoFields do
       LineasDocumentoItem.Caption := Format( RsMsg20, [ IfThen( TipoMovimientoEdicion=tmOferta, 'esta ', 'este ' ) + Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, False ) ] );
     SetBarItemsVisible( [ FacturaCompraItem ], ( TipoMovimientoEdicion=tmCompra ) and MovimientoFields.Facturado.Value );
     SetBarItemsVisible( [ DocumentoOrigenItem ], MovimientoFields.NroOperacionOrigen.Value<>0 );
end;

procedure TMntMcoForm.SuprimirVinculosItemClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg21, RsMsg22 )=mrYes
     then If   Movimiento.SuprimeVinculosConPedidos( MovimientoFields.NroOperacion.Value, LineaMovimientoFields.NroPagina.Value )
          then MovimientoTable.Refresh;
end;

function TMntMcoForm.TableViewManagerCanDeleteRow: Boolean;
begin
     Result := ( MovimientoTable.State=dsEdit ) and
               not ( ( TipoMovimientoEdicion=tmCompra ) and MovimientoFields.Facturado.Value ) and
               not ( ( TipoMovimientoEdicion=tmPedidoCompra ) and ( ( MovimientoFields.Situacion.Value=epProcesado ) or ( LineaMovimientoFields.CantidadProcesada.Value<>0.0 ) or LineaMovimientoFields.Procesada.Value ) ) and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntMcoForm.TableViewManagerCanInsertRow: Boolean;
begin
     Result := ( MovimientoTable.State=dsEdit ) and
               not ( ( TipoMovimientoEdicion=tmCompra ) and MovimientoFields.Facturado.Value ) and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntMcoForm.TableViewManagerCanShiftRow: Boolean;
begin
     Result := not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

function TMntMcoForm.TableViewManagerCanShowDocument: Boolean;
begin
     Result := GridView.DataController.FocusedRowIndex<>-1;
end;

procedure TMntMcoForm.TableViewManagerDelete(Sender: TObject);
begin
     CompruebaEstadoLineaPedido;
end;

procedure TMntMcoForm.TableViewManagerRowShift(ShiftOperation: TShiftOperation);

var  HaciaArriba,
     HastaElFinal : Boolean;

begin
     HaciaArriba := ( ShiftOperation=soFirst ) or ( ShiftOperation= soPrior );
     HastaElFinal := ( ShiftOperation= soFirst ) or ( ShiftOperation=soLast );
     With LineaMovimientoFields do
       Movimiento.DesplazaLineaMovimiento( Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value, HaciaArriba, HastaElFinal );
end;

procedure TMntMcoForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( MovimientoFields.TipoMovimiento.Value,
                               MovimientoFields.NroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

procedure TMntMcoForm.VincularPedidoItemClick(Sender: TObject);
begin
     VincularAPedido( MovimientoFields, LineaMovimientoFields );
end;

end.


