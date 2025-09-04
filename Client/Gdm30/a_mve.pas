unit a_mve;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics, Generics.Collections,

     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
     cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
     cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
     cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
     cxGridDBTableView, cxGrid,

     nxdb, cxMaskEdit, cxDropDownEdit, cxCalendar,
     cxCurrencyEdit, dxmdaset, cxSpinEdit,
     cxIndexedComboBox, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
     cxRichEdit, cxMemo, cxDBRichEdit, cxLabel, cxSplitter, cxGroupBox,
     cxLookAndFeels, f_not, cxScrollBox, cxNavigator, dxScreenTip,
     dxCustomHint, cxHint, cxIntegerEdit, Vcl.ImgList, System.ImageList,
     cxCheckComboBox, cxImageList, dxBar, dxDateRanges, dxUIAClasses,
     cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,

     LibUtils,
     AppManager,
     DataManager,
     AppContainer,
     AppForms,
     GridTableViewController,
     Spring,

     Gdm10Dm,
     Gdm30Dm,

     Gim00Fields,
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
     dm_sto;

type

  TSumasPagina = class
    public
    Cantidad,
    CantidadProcesada,
    Alto,
    Peso : Decimal;
    TasasArray : TTasasArray;
    SumaTasas : TTasaRecord;

    procedure LimpiaPagina( LimpiarValoresImpositivos : Boolean = False );
    procedure AcumulaValoresImpositivos( Fecha : TDate; ModeloIVA : SmallInt; CalcularIVA : Boolean );
    end;

  TMntMveForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    ButtonContainerPanel: TcxGroupBox;
    OkButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    BottomPanel: TcxGroupBox;
    FooterPanelImporte: TcxLabel;
    TopPanel: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    LineaMovimientoDataSource: TDataSource;
    ImportarButton: TgBitBtn;
    FooterPanelCantidad: TcxLabel;
    FooterPanelServido: TcxLabel;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataServido: TBooleanField;
    TituloDocumentoLabel: TcxLabel;
    Panel1: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    NroDocumentoCtrl: TcxDBIntegerEdit;
    FechaAplicacionCtrl: TcxDBDateEdit;
    FechaAplicacionPanel: TgxScrollBoxPanel;
    CentroCostePanel: TgxScrollBoxPanel;
    CentroCosteCtrl: TcxDBTextEdit;
    ServidoPanel: TgxScrollBoxPanel;
    ServidoCtrl: TcxDBCheckBox;
    FooterPanelIVAIncluido: TcxLabel;
    NoFacturarPanel: TgxScrollBoxPanel;
    NoFacturarCtrl: TcxDBCheckBox;
    Bottom1ScrollBox: TcxScrollBox;
    FacturarButton: TgBitBtn;
    ClienteCtrl: TcxDBTextEdit;
    LockRangeButton: TgxLockRangeButton;
    ConsumosPreciosButton: TgBitBtn;
    FacturaDirectaButton: TgBitBtn;
    TopScrollBox: TcxScrollBox;
    GrupoClientePanel: TgxScrollBoxPanel;
    GrupoClienteCtrl: TcxDBTextEdit;
    VendedorPanel: TgxScrollBoxPanel;
    VendedorCtrl: TcxDBTextEdit;
    FormaCobroPanel: TgxScrollBoxPanel;
    FormaCobroCtrl: TcxDBTextEdit;
    RegistroAuxiliarPanel: TgxScrollBoxPanel;
    RegistroAuxiliarCtrl: TcxDBTextEdit;
    TransportistaPanel: TgxScrollBoxPanel;
    TransportistaCtrl: TcxDBTextEdit;
    Bottom2ScrollBox: TcxScrollBox;
    EntregaACuentaPanel: TgxScrollBoxPanel;
    EntregaACuentaCtrl: TcxDBCurrencyEdit;
    PortesPanel: TgxScrollBoxPanel;
    PortesCtrl: TcxDBCurrencyEdit;
    ExportarButton: TgBitBtn;
    EstadoPanel: TgxScrollBoxPanel;
    EstadoCtrl: TcxDBIndexedComboBox;
    NroDocumentoPropietarioPanel: TgxScrollBoxPanel;
    NroDocumentoPropietarioCtrl: TcxDBTextEdit;
    LineaMovimientoAuxTable: TnxeTable;
    GrupoLineaMovimientoTable: TnxeTable;
    GrupoLineaDataSource: TDataSource;
    GridGroupBox: TcxGroupBox;
    Panel3: TcxGroupBox;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewUbicacion: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewCantidadAjustada: TcxGridDBColumn;
    GridViewServido: TcxGridDBColumn;
    GridViewPrecioIVA: TcxGridDBColumn;
    GridViewPrecioDivisa: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewRecargo: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridViewImporteTotal: TcxGridDBColumn;
    GridViewDocumentoOrigen: TcxGridDBColumn;
    GridViewNroRegistro: TcxGridDBColumn;
    GridViewNroRegistroOrigen: TcxGridDBColumn;
    GridViewAnotacion: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    TableViewManager: TGridTableViewController;
    PaginacionSplitter: TcxSplitter;
    GrupoLineaMovimientoTableEjercicio: TSmallintField;
    GrupoLineaMovimientoTableNroOperacion: TIntegerField;
    GrupoLineaMovimientoTableCodigoGrupo: TWideStringField;
    GrupoLineaMovimientoTableDescripcion: TWideStringField;
    GrupoLineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTable: TnxeTable;
    LineaMovimientoTableEjercicio: TSmallintField;
    LineaMovimientoTableNroOperacion: TIntegerField;
    LineaMovimientoTableNroPagina: TSmallintField;
    LineaMovimientoTableNroLinea: TSmallintField;
    LineaMovimientoTableFecha: TDateField;
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
    LineaMovimientoTableRecargo: TBCDField;
    LineaMovimientoTablePuntoVerde: TBCDField;
    LineaMovimientoTableDescuento: TBCDField;
    LineaMovimientoTableNroCajas: TBCDField;
    LineaMovimientoTableLargo: TBCDField;
    LineaMovimientoTableAncho: TBCDField;
    LineaMovimientoTableAlto: TBCDField;
    LineaMovimientoTableOferta: TBooleanField;
    LineaMovimientoTableImporteBruto: TBCDField;
    LineaMovimientoTableImporteDescuento: TBCDField;
    LineaMovimientoTableImporteNeto: TBCDField;
    LineaMovimientoTableNoCalcularMargen: TBooleanField;
    LineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoTableTieneRegistroOrigen: TBooleanField;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    SeparadorSerieLabel: TcxLabel;
    Label19: TcxLabel;
    Label18: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    FechaAplicacionCaptionLabel: TcxLabel;
    Label1: TcxLabel;
    Label5: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label11: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    RegistroAuxiliarLabel: TcxLabel;
    Label4: TcxLabel;
    Label12: TcxLabel;
    Label16: TcxLabel;
    Label17: TcxLabel;
    Label21: TcxLabel;
    PaginasPanel: TcxGroupBox;
    Panel4: TcxGroupBox;
    PaginasLabel: TcxLabel;
    PageGrid: TcxGrid;
    PageGridView: TcxGridDBTableView;
    PageGridViewGrupoDocumento: TcxGridDBColumn;
    PageGridViewDescripcion: TcxGridDBColumn;
    PageGridLevel: TcxGridLevel;
    PageGridViewManager: TGridTableViewController;
    LineaMovimientoTableCantidadCargada: TBCDField;
    GridViewCantidadCargada: TcxGridDBColumn;
    CloseButton: TgBitBtn;
    LineaMovimientoTableBultos: TBCDField;
    GridViewBultos: TcxGridDBColumn;
    LineaMovimientoTableTara: TBCDField;
    GridViewTara: TcxGridDBColumn;
    FooterPanelPeso: TcxLabel;
    PesoLabel: TcxLabel;
    CantidadLabel: TcxLabel;
    ServidoLabel: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    LineaMovimientoTablePeso: TBCDField;
    GridViewPeso: TcxGridDBColumn;
    LineaMovimientoTableTipoLinea: TWideStringField;
    GridViewTipoLinea: TcxGridDBColumn;
    LineaMovimientoTableNroRegistro: TUnsignedAutoIncField;
    LineaMovimientoTableCodigoTipoIVA: TSmallintField;
    LineaMovimientoTableCuotaIVA: TBCDField;
    LineaMovimientoTableCuotaRE: TBCDField;
    LineaMovimientoTablePrecioIVA: TBCDField;
    LineaMovimientoTableImporteTotal: TBCDField;
    GridViewCodigoTipoIVA: TcxGridDBColumn;
    GridViewNroPagina: TcxGridDBColumn;
    OperarioPanel: TgxScrollBoxPanel;
    CodigoOperarioCtrl: TcxDBTextEdit;
    NombreOperarioLabel: TcxLabel;
    OperarioLabel: TcxLabel;
    LineaMovimientoTablePrecio: TFloatField;
    LineaMovimientoTablePrecioDivisa: TBCDField;
    FormaEnvioPanel: TgxScrollBoxPanel;
    FormaEnvioCtrl: TcxDBTextEdit;
    DescFormaEnvioLabel: TcxLabel;
    CaptionFormaEnvioLabel: TcxLabel;
    GridViewCuotaIVA: TcxGridDBColumn;
    GridViewCuotaRE: TcxGridDBColumn;
    OrigenLabel: TcxLabel;
    FirmarButton: TgBitBtn;
    FirmadoLabel: TcxLabel;
    DepartamentoPanel: TgxScrollBoxPanel;
    OrganismoPublicoCtrl: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel3: TcxLabel;
    LineaMovimientoTablePesoEnvase: TBCDField;
    GridViewPesoEnvase: TcxGridDBColumn;
    GridViewParametros: TcxGridDBColumn;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableProcesada: TBooleanField;
    GridViewProcesada: TcxGridDBColumn;
    LineaMovimientoTableFechaAplicacion: TDateField;
    GridViewFechaAplicacion: TcxGridDBColumn;
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
    HojaCargaButton: TgBitBtn;
    BarManager: TdxBarManager;
    RelacionesPopupMenu: TdxBarPopupMenu;
    LineasDocumentoItem: TdxBarButton;
    FacturaVentaItem: TdxBarButton;
    DocumentoOrigenItem: TdxBarButton;
    RejillaPopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    FichaMovimientosArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    VincularPedidoItem: TdxBarButton;
    SuprimirVinculosItem: TdxBarButton;
    DarPorServidaItem: TdxBarButton;
    ActualizarRelacionesItem: TdxBarButton;
    CopiarAnotacionItem: TdxBarButton;
    MostrarAnotacionesItem: TdxBarButton;
    CantidadTotalPanel: TcxGroupBox;
    ServidoTotalPanel: TcxGroupBox;
    PesoTotalPanel: TcxGroupBox;
    TotalesPanel: TcxGroupBox;
    AnotacionButton: TgBitBtn;
    GrupoLineaMovimientoTableNroPagina: TSmallintField;
    ConsultaArticulosPopupMenu: TdxBarPopupMenu;
    ConsultaArticulosItem: TdxBarButton;
    ConsultaArticulosRelacionadosItem: TdxBarButton;
    ConsultaArticulosEquivalentesItem: TdxBarButton;
    EntregasACuentaPedidosLabel: TcxLabel;
    LineaMovimientoTableFechaCaducidad: TDateField;
    GridViewFechaCaducidad: TcxGridDBColumn;
    DocumentosGroupBox: TcxGroupBox;
    BotonesGroupBox: TcxGroupBox;
    LanzarButton: TgBitBtn;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    GridViewCampoLibre1: TcxGridDBColumn;
    GridViewCampoLibre2: TcxGridDBColumn;
    GridViewCampoLibre3: TcxGridDBColumn;
    GridViewCampoLibre4: TcxGridDBColumn;
    AvisoButton: TgBitBtn;
    OfertaPanel: TgxScrollBoxPanel;
    cxLabel7: TcxLabel;
    OpcionCtrl: TcxDBIndexedComboBox;
    LineaMovimientoTableTieneDocumentosAsociados: TBooleanField;
    GridViewTieneDocumentosAsociados: TcxGridDBColumn;
    DataPanelSplitter: TcxSplitter;
    NoPedirAlProveedorItem: TdxBarButton;
    CarpetaDocumentosButton: TgBitBtn;
    DirectorioDocumentosItem: TdxBarButton;
    DocumentosButton: TgBitBtn;
    EnviadoPanel: TgxScrollBoxPanel;
    EnviadoCtrl: TcxDBCheckBox;
    DataEnviado: TBooleanField;
    Panel2: TcxGroupBox;
    OpcionesLineaButton: TgBitBtn;
    GridViewImporteRecargo: TcxGridDBColumn;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    AltoTotalPanel: TcxGroupBox;
    FooterPanelAlto: TcxLabel;
    AltoLabel: TcxLabel;
    GridViewCampoLibre5: TcxGridDBColumn;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    DocumentosOrigenItem: TdxBarButton;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    GridViewEjercicioOrigen: TcxGridDBColumn;
    GridViewNroOperacionOrigen: TcxGridDBColumn;
    LineaMovimientoTableContribucionRAP: TBCDField;
    AnuladoLabel: TcxLabel;
    GridViewEjercicio: TcxGridDBColumn;
    GridViewNroOperacion: TcxGridDBColumn;
    GridViewNroLinea: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewAsignacionOrigen: TcxGridDBColumn;
    GridViewTipoMovimientoOrigen: TcxGridDBColumn;
    GridViewUIDArticulo: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPorcentajeRecargo: TcxGridDBColumn;
    GridViewContribucionRAP: TcxGridDBColumn;
    GridViewOferta: TcxGridDBColumn;
    GridViewImporteBruto: TcxGridDBColumn;
    GridViewImporteDescuento: TcxGridDBColumn;
    GridViewNoCalcularMargen: TcxGridDBColumn;

    procedure FormManagerInitializeForm;
    procedure FormManagerReportFormRequest;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure LineaMovimientoTableAfterEdit(DataSet: TDataSet);
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
    procedure LineaMovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableBeforePost(DataSet: TDataSet);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
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
    procedure LineasDocumentoItemClick(Sender: TObject);
    procedure ConsumosPreciosButtonClick(Sender: TObject);
    procedure LineaMovimientoTableAfterOpen(DataSet: TDataSet);
    procedure LineaMovimientoTableAfterClose(DataSet: TDataSet);
    procedure GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
    procedure ExportarButtonClick(Sender: TObject);
    procedure GridViewNumeroSeriePropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadAjustadaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadAjustadaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewDimensionPropertiesValuePosted(Sender: TObject);
    procedure GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
    procedure GridViewNroCajasPropertiesValuePosted(Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
    procedure FormManagerLabelsRequest;
    procedure GridViewLoteFabricacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewLoteFabricacionPropertiesValuePosted(
      Sender: TObject);
    procedure GridViewPrecioIVAPropertiesValuePosted(
      Sender: TObject);
    procedure LineaMovimientoTableAfterPost(DataSet: TDataSet);
    procedure FacturaDirectaButtonClick(Sender: TObject);
    procedure GridViewCodigoClasePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCantidadAjustadaPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    procedure ServidoCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridViewPrecioDivisaPropertiesValuePosted(Sender: TObject);
    function MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
    function MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure GridViewPrecioPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewPrecioPropertiesValuePosted(Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewCantidadAjustadaPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridEnter(Sender: TObject);
    procedure KeyPanelEnter(Sender: TObject);
    procedure MovimientoTableOpenRecord(DataSet: TDataSet);
    procedure DataPanelEnter(Sender: TObject);
    procedure FormManagerFocusedAreaChanged;
    procedure MovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure FormManagerPreparedForm;
    procedure FacturaVentaItemClick(Sender: TObject);
    procedure RelacionesPopupMenuPopup(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure GridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure GridViewPrecioIVAPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
        procedure GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
    procedure GridViewPrecioPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GrupoLineaMovimientoTableNewRecord(DataSet: TDataSet);
    procedure PageGridViewManagerDelete(Sender: TObject);
    procedure PageGridViewGrupoDocumentoPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure PageGridViewGrupoDocumentoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure PageGridViewGrupoDocumentoPropertiesValuePosted(
      Sender: TObject);
    procedure PageGridViewGrupoDocumentoPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure PageGridViewDescripcionPropertiesEnter(
      Sender: TcxCustomEdit);
    function MovimientoTableCheckDetailDatasets(
      Dataset: TDataSet; Posting : Boolean): Boolean;
    procedure GrupoLineaMovimientoTableAfterClose(DataSet: TDataSet);
    procedure LineaMovimientoTableBeforeEdit(DataSet: TDataSet);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure FormManagerDeleteEmptyHeader(DataSet: TDataSet);
    procedure GrupoLineaMovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure GridViewCodigoArticuloPropertiesEnter(Sender: TcxCustomEdit);
    procedure FormManagerUpdateButtonsState;
    function TableViewManagerCanDeleteRow: Boolean;
    procedure MovimientoTableGetRecord(DataSet: TDataSet);
    procedure DarPorServidaItemClick(Sender: TObject);
    procedure GridViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
    procedure GridViewServidoPropertiesValuePosted(Sender: TObject);
    procedure GridViewTipoLineaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewUpdatePropertiesValuePosted(Sender: TObject);
    procedure GridViewAfterSummary(
      ASender: TcxDataSummary);
    procedure PageGridViewManagerRowShift(ShiftOperation: TShiftOperation);
    function PageGridViewManagerRowInsert: Boolean;
    procedure FormManagerSetupToolBar(Enable: Boolean);
    procedure FormManagerCreateForm;
    procedure FormManagerDestroyForm;
    procedure CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ActualizarRelacionesItemClick(Sender: TObject);
    procedure GridViewImporteGetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure GridViewFooterSummaryItems( ASender : TcxDataSummaryItems; Arguments : TcxSummaryEventArguments;
      var OutArguments : TcxSummaryEventOutArguments );
    procedure CopiarAnotacionItemClick(Sender: TObject);
    procedure GridViewLoteFabricacionPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure GridViewLoteFabricacionPropertiesEnter(
      Sender: TcxCustomEdit);
    procedure GridViewInitEditValue(     Sender : TcxCustomGridTableView;
                                                 AItem  : TcxCustomGridTableItem;
                                                 AEdit  : TcxCustomEdit;
                                             var AValue : TcxEditValue );
    procedure FormaEnvioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaEnvioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FormaEnvioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaEnvioCtrlPropertiesValuePosted(Sender: TObject);
    procedure PortesCtrlPropertiesValuePosted(Sender: TObject);
    procedure VincularPedidoItemClick(Sender: TObject);
    procedure SuprimirVinculosItemClick(Sender: TObject);
    procedure DocumentoOrigenItemClick(Sender: TObject);
    procedure FirmarButtonClick(Sender: TObject);
    procedure OrganismoPublicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure OrganismoPublicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure OrganismoPublicoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
	 procedure GridViewPesoEnvasePropertiesValuePosted(Sender: TObject);
    function TableViewManagerCanInsertRow: Boolean;
    procedure MovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure MovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableAfterDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure GridViewPrecioDivisaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FechaAplicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewServidoGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure MovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewImporteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure GridViewImporteTotalGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure GridViewPrecioDivisaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    function TableViewManagerCanShiftRow: Boolean;
    procedure TableViewManagerRowShift(ShiftOperation: TShiftOperation);
    procedure LineaMovimientoTableRecordChanged(DataSet: TDataSet);
    procedure AnotacionButtonClick(Sender: TObject);
    procedure GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure GrupoLineaMovimientoTableAfterPost(DataSet: TDataSet);
    procedure ConsultaArticulosItemClick(Sender: TObject);
    procedure ConsultaArticulosRelacionadosItemClick(Sender: TObject);
    procedure ConsultaArticulosEquivalentesItemClick(Sender: TObject);
    procedure GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure MovimientoTableAfterEdit(DataSet: TDataSet);
    procedure AvisoButtonClick(Sender: TObject);
    procedure ClienteCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
    function TableViewManagerCanShowDocument: Boolean;
    procedure NoPedirAlProveedorItemClick(Sender: TObject);
    procedure DirectorioDocumentosItemClick(Sender: TObject);
    procedure DocumentosButtonClick(Sender: TObject);
    procedure EnviadoCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridViewCodigoClasePropertiesValuePosted(Sender: TObject);
    procedure DocumentosOrigenItemClick(Sender: TObject);
    procedure GridViewPuntoVerdePropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormManagerShowCantEditMessage;
    procedure GridViewCampoLibre1PropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TableViewManagerBeforeValidateTableView(Sender: TObject);
    procedure GridViewCodigoTipoIVAPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoTipoIVAPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoTipoIVAPropertiesValuePosted(Sender: TObject);
    procedure GridViewBultosPropertiesValuePosted(Sender: TObject);

  private

    FOnCalcFieldsLineaMovimiento,
    FOnDesconectaTabletFirma,
    FOnActualizaEstado,
    FOnMuestraTotales,
    FOnUpdateButtonsState : Event<TSimpleEvent>;
    FOnCapturaFirma : Event<TFirmaMovimientoEvent>;
    FBeforePostMovimiento,
    FBeforeDeleteMovimiento,
    FOnMuestraDocumentoOrigen : Event<TMovimientoDatasetEvent>;
	  FOnFiltroSeleccionDocumentos : Event<TFiltroLineaMovimientoDatasetEvent>;
    FSumasPagina : TList<TSumasPagina>;
    PreciosConIVAIncluido : Boolean;
    StockFrame : TStockFrame;
    RiesgoFrame : TRiesgoFrame;
    TipoMovimientoEdicion : TTipoMovimiento;
    BorrandoGrupo,
    ExisteModuloPreventa,
    ShowFocusedRowHighlited : Boolean;
    ExistenciasArticulo : IExistenciasArticulo;
    MostrarAvisoVendedor,
    DesglosarLinea,
    DatosLineaModificables,
    CalculandoValoresLinea,
    FReajustandoPrecioBase,
    FActualizandoCamposCalculadosLinea,
    FTabletFirmaConectado : Boolean;
    FDirectorioDocumentos : String;

    TipoMovimientoDestino : TTipoMovimiento;
    CodigoPropietarioDestino,
    SerieDestino : String;
    NroDocumentoDestino : LongInt;
    SoloCantidadesPendientes,
    DocumentoAutomatico,
    TodasLasLineas : Boolean;

    FCodigoPaisIVA : String;

    procedure FijaSeriePorDefecto;
    function ObtenClaveDocumentos : String;
    procedure ActualizaCantidad;
    procedure ActualizaValorCantidad( Value : Decimal );
    procedure ActualizaValorBultos( NroCajas, Cantidad : Decimal );
    procedure ActualizaValorCantidadyEnvases( NroCajas : Decimal );
    procedure ActualizaReferencias;
    procedure ActualizaContenidoRejillas;
    procedure ReajustaPrecioBase;
    procedure GridViewAutoEditChanged;

    function GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    function GetLineaMovimientoFields : TLineaMovimientoFields;
    function GetSumasPagina( Index : SmallInt ) : TSumasPagina;
    procedure SetTabletFirmaConectado( const Value : Boolean );

    procedure ActualizaCamposCalculadosLinea;
    procedure ActualizaEstadoPedido;
    procedure ActualizaEntregasACuentaPedidos;
    procedure ImportaDatosCapturador( DataPath : String );
    // procedure ImportaDatosBascula;
    procedure MuestraTotales;

    procedure DoOnSumasPaginaNotify( Sender: TObject; const Item: TSumasPagina; Action: TCollectionNotification );
    procedure DoOnTarifaConsumoSelected( Target : TcxCustomEdit = nil );
    procedure DoOnLoteProducto1Selected( Target : TcxCustomEdit = nil );
    procedure DoOnLoteProducto2Selected( Target : TcxCustomEdit = nil );
    procedure DoOnExistenciasSelected( Target : TcxCustomEdit = nil );
    procedure DoOnRegistroAuxiliarSelected( Target : TcxCustomEdit = nil );
    procedure DoOnCalculaPrecios;
    procedure DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False; LineArray : TLongIntArray = nil );
    procedure DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False; LineArray : TLongIntArray = nil );
    procedure DoAplicaTarifa( Target : TcxCustomEdit = nil );
    procedure DoOnExportaDocumento;
    function DoShowDocument : Boolean;
    procedure DoOnCloseRelacionDocumentos;

    procedure ActualizaVisibilidadAviso(Visible: Boolean);
    procedure MostrarAviso;

    procedure ObtenCliente( Codigo : String );

  public

    MovimientoFields : TMovimientoFields;
    FGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    FLineaMovimientoFields,
    LineaMovimientoAuxFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;
    ClaseFields,
    EnvaseFields : TClaseFields;
    ClienteFields : TClienteFields;
    SerieFacturacionFields : TSerieFacturacionFields;
    DsDivisaFields : TDivisaFields;

    CantidadTotal,
    CantidadProcesadaTotal,
    AltoTotal,
    PesoTotal,
    ImporteNetoAnterior,
    ImporteNetoTotal,
    ImporteIVAIncluidoTotal,
    EntregasACuenta : Decimal;

    CaptionNroPagina,
    CodigoDivisa : String;
    TipoDeCambio : Double;

    AvisoEstadoPresupuesto,
    CalcularIVA,
    LoteAsignado,
    ServidoAnterior,
    FijarClases,
    ExisteEnvase,
    AjustandoCantidad,
    DandoLineaPorServida : Boolean;

    BandasVisibles : SmallInt;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    SerieActual,
    PropietarioActual : String;

    UltimoTipoMovimientoImportado,
    UltimoTipoMovimientoExportado : TTipoMovimiento;

    FCamposOpcionalesVisibles,
    FCamposLibresVisibles : SmallInt;

    FNoActualizarTipoIVA : Boolean;

    procedure ObtenExistencias;
    procedure MuestraRiesgo;
    procedure ActualizaEstado;
    procedure ActualizaEstadoLineas;
    procedure ActualizaRelaciones( Forzar : Boolean = False );
    procedure DoOnCopyCurrentRecord;
    procedure DoSeleccionaDocumentoImportar;
    procedure DoFilterRecord( LineaMovimientoFields : TLineaMovimientoFields; var Accept : Boolean );
    procedure DoInsertaLineasConsumo( LineList : TList<Integer> );
    procedure HighliteRow( RowIndex : LongInt );
    procedure SetButtonVisible( Button : TgBitBtn; Value : Boolean );

    property GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields read GetGrupoLineaMovimientoFields;
    property LineaMovimientoFields : TLineaMovimientoFields read GetLineaMovimientoFields;
    property SumasPagina[ Index : SmallInt ] : TSumasPagina read GetSumasPagina;
    property TabletFirmaConectado : Boolean read FTabletFirmaConectado write SetTabletFirmaConectado;

    property OnCalcFieldsLineaMovimiento : Event<TSimpleEvent> read FOnCalcFieldsLineaMovimiento write FOnCalcFieldsLineaMovimiento;
    property OnMuestraTotales : Event<TSimpleEvent> read FOnMuestraTotales write FOnMuestraTotales;
    property OnUpdateButtonsState : Event<TSimpleEvent> read FOnUpdateButtonsState write FOnUpdateButtonsState;
    property OnActualizaEstado : Event<TSimpleEvent> read FOnActualizaEstado write FOnActualizaEstado;
    property OnCapturaFirma : Event<TFirmaMovimientoEvent> read FOnCapturaFirma write FOnCapturaFirma;
    property OnDesconectaTabletFirma : Event<TSimpleEvent> read FOnDesconectaTabletFirma write FOnDesconectaTabletFirma;

    property OnMuestraDocumentoOrigen : Event<TMovimientoDatasetEvent> read FOnMuestraDocumentoOrigen write FOnMuestraDocumentoOrigen;

    property BeforePostMovimiento : Event<TMovimientoDatasetEvent> read FBeforePostMovimiento write FBeforePostMovimiento;
    property BeforeDeleteMovimiento : Event<TMovimientoDatasetEvent> read FBeforeDeleteMovimiento write FBeforeDeleteMovimiento;
    property OnFiltroSeleccionDocumentos : Event<TFiltroLineaMovimientoDatasetEvent> read FOnFiltroSeleccionDocumentos write FOnFiltroSeleccionDocumentos;

  end;

var  MntMveForm : array[ tmPresupuesto..tmVenta ] of TMntMveForm = ( nil, nil, nil );
     TipoMovimientoCreado : TTipoMovimiento;

function MntMovimientosVenta( Values : array of const ) : TMntMveForm;
procedure ActualizaMovimientosVenta( TipoMovimiento : TTipoMovimientoVenta );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       Math,

       Files,
       DataAccess,
       EnterpriseDataAccess,
       SessionDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       ParametrosFacturacionIntf,
       MovimientoIntf,

       dm_pga,
       dm_usr,
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
       dm_ine,
       dm_cdi,
       dm_gdo,
       dm_tlm,
       dm_ope,
       dm_reg,
       dm_fde,
       dm_orp,
       dm_rdm,

       b_msg,
       bx_not,
       b_cdv,
       b_sdv,
       b_mco,
       b_mve,
       b_trz,
       b_rld,
       b_fda,
       b_chc,
       b_edv,
       b_cmp,
       b_spe,
       b_avs,
       b_rdm,
       b_dir,

       a_iva,
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
       a_gdo,
       a_tlm,
       a_ope,
       a_fde,
       a_orp,
       a_tca,

       e_mov,

       cx_iva,
       cx_mve,
       cx_cli,
       cx_art,
       cx_arr,
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
       cx_epu,
       cx_tdv,
       cx_gdo,
       cx_tlm,
       cx_ope,
       cx_fde,
       cx_orp,

       r_mov;

resourceString


   RsMsg2  = 'Pulse [F11] para incluir el último lote disponible.';
   RsMsg3  = 'Este grupo ya está incluido en la lista.';
   RsMsg4  = 'No procede de ningún otro documento';
   RsMsg5  = 'El registro origen de esta línea ya no existe.';
   RsMsg6  = 'Se suprime la referencia al documento origen en la línea actual.';
   RsMsg7  = '&Documentos cuyo origen es est%s %s';
   RsMsg9  = ' pendientes de un cliente';
   RsMsg10 = 'Este albaran consta como facturado pero no existe la factura a la que pertenece.';
   RsMsg11 = 'Ejecute una reconstrucción de resultados para verificar las relaciones entre los documentos y corregir cualquier error.';
   RsMsg12 = 'El importe de la EcoTasa no puede ser superior al precio del artículo.';

   RsMsg14 = 'Utilice el botón derecho del ratón para acceder al menú de opciones de la línea.';
   RsMsg15 = 'No existen cantidades pendientes de servir en este pedido.';
   RsMsg16 = 'No puede cambiar el estado de un pedido cuyos artículos han sido incluidos por completo en albaranes de venta.' + HtmlCR +
             'Si aún así desea editarlo, localice una línea de un albaran de salida de este pedido y suprímala o modifique la cantidad de salida.';
   RsMsg17 = 'Pulse [F11] para convertir el precio con I.V.A. incluído introducido manualmente, en su correspondiente precio base.';
   RsMsg18 = 'Este número de %s no es correlativo.';
   RsMsg19 = '¿Confirma que desea utilizarlo?';
   RsMsg20 = 'No se ha servido ninguna cantidad de esta línea.';
   RsMsg21 = 'Con el parámetro de regularización de las cantidades solicitadas a las servidas activado, es necesario que exista alguna cantidad servida para poder realizar el proceso.';
   RsMsg22 = '&Precios';
   RsMsg23 = 'Actualiza los precios de los artículos incluídos en el presupuesto.';
   RsMsg24 = 'No tiene activadas las tarifas.';
   RsMsg25 = 'Acceda al mantenimiento de ''Configuración de Empresas'' y, en la pestaña |Cliente|, active las ''Tarifas por código de tarifa''';
   RsMsg26 = 'No se ha podido guardar el código de %s en el documento.';
   RsMsg27 = 'El valor no se ha podido guardar porque el registro ha sido dado de baja o el fichero ha sido alterado.';
   RsMsg28 = 'Este artículo está en oferta (desde el %s hasta el %s)';
   RsMsg29 = 'El precio y descuento mostrados son los de la oferta fijada en su ficha.';
   RsMsg30 = 'Una o más líneas de este documento proviene(n) de un presupuesto.';
   RsMsg31 = 'Recuerde que debe revisar el estado del mismo (Aceptado, Pendiente o Cancelado) y ajustarlo manualmente en caso de que su estado haya cambiado.';
   RsMsg32 = '¿Esta seguro de que desea suprimir TODAS las líneas de esta página?';
   RsMsg33 = 'Tenga en cuenta que esta operación es irreversible.';
   RsMsg34 = 'En este artículo es obligatorio indicar el envase.';   
   
   RsMsg36 = 'Pulse [F11] para completar los valores de la línea utilizando las clases de artículo existentes como plantilla.';
   RsMsg37 = 'Pulse [F11] para cambiar la segunda clase de la línea por la próxima disponible.';

   RsMsg38 = 'No se pueden modificar o suprimir líneas que ya han sido parcial o totalmente servidas.';
   RsMsg39 = 'Si desea editar esta línea localice el/los albaran/es a los que ha sido exportada y suprima las referencias a la misma.';
   RsMsg40 = 'No se puede modificar esta columna.';
   RsMsg41 = 'El código del artículo y, en algunos casos las clases, no pueden modificarse cuando la línea se ha importado desde otro documento o el registro está cerrado.';

   RsMsg42 = '¿Confirma que desea cambiar el propietario del documento?';
   RsMsg43 = 'Cuando se modifica el propietario de un documento que ya contiene líneas hay que reajustarlo para tener en cuenta los posibles cambios.';
   RsMsg44 = '¿Está seguro de que desea actualizar las relaciones del documento?';
   RsMsg45 = 'Cuando se actualiza un documento se vuelven a comprobar las relaciones del mismo, como los tipos de I.V.A. de las líneas, recalculando los importes si es necesario.'#13 +
             'Por defecto los documentos conservan los datos impositivos originales aunque se modifique la ficha de los artículos incluídos en él, para que no se produzcan alteraciones en los importes.' ;

   RsMsg46 = '¿Está seguro de que desea regularizar las cantidades solicitadas e igualarlas a las servidas?';
   RsMsg47 = 'El proceso de ajuste es irreversible, porque las cantidades solicitadas originalmnete por el cliente se sustituyen por las servidas.';

   RsMsg48 = '¿Está seguro de que desea suprimir todos los vinculos con pedidos?';
   RsMsg49 = 'Este proceso elimina las relaciones que puedan tener las líneas del albarán con pedidos existentes.'#13'Una vez realizado se puede volver a vincular el documento con cualquier otro pedido.';

   RsMsg50 = 'Debe seleccionar un directorio de documentos';
   RsMsg51 = 'Debe asignar un lote usando la consulta disponible.';

   RsMsg52 = 'No existe este código de barras';
   RsMsg53 = 'El código de barras no coincide con el del artículo de la línea.';

   // Parámetros del registro

function MntMovimientosVenta( Values : array of const ) : TMntMveForm;
begin
     TipoMovimientoCreado := Values[ 0 ].VInteger;  // Siempre hay que pasar el tipo (como mínimo)
     CreateEditForm( TMntMveForm, MntMveForm[ TipoMovimientoCreado ], Values, TGds30Frm.VentasSection );
     Result := MntMveForm[ TipoMovimientoCreado ];
end;

procedure ActualizaMovimientosVenta( TipoMovimiento : TTipoMovimientoVenta );
begin
     If   Assigned( MntMveForm[ TipoMovimiento ] )
     then With MntMveForm[ TipoMovimiento ] do
            begin
            // BringToFront;
            MovimientoTable.Refresh;
            end;
end;

procedure TMntMveForm.SetButtonVisible( Button : TgBitBtn; Value : Boolean );
begin
     Button.Visible := Value;
     If   not Value
     then ButtonContainerPanel.Width := ButtonContainerPanel.Width - ( Button.Width + Button.Margins.Left ); // Solo les pongo margen por la izquierda
end;

procedure TMntMveForm.FormManagerInitializeForm;

var  TextoNroDocumento,
     TextoFechaAplicacion : String;

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

     Id := idMntMveForm;

     //  Ajuste del tipo de documento

     TipoMovimientoEdicion := FormValues[ 0 ];

     Caption := Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, True, True );
     TituloDocumentoLabel.Caption := Movimiento.TextoTituloMovimiento( TipoMovimientoEdicion );
     ShowHint := False;  // Por si acaso. Utilizo el Hint para extender el nombre del form en las funciones que gestionan el estado de la ventana (layout)
     ExisteModuloPreventa := ApplicationContainer.IsModuleActive( [ 60 ] );

     case TipoMovimientoEdicion of
       tmPresupuesto  : begin
                        TextoNroDocumento := 'Nº de presupuesto';
                        TextoFechaAplicacion := 'Válido hasta el';
                        HelpKeyword := 'a_pre';
                        ExtendedName := 'pre';
                        end;
       tmPedidoVenta  : begin
                        TextoNroDocumento := 'Nº de pedido';
                        TextoFechaAplicacion := 'Fecha de entrega';
                        HelpKeyword := 'a_pdv';
                        ExtendedName := 'pdv';
                        end;
       tmVenta        : begin
                        TextoNroDocumento := 'Nº de albarán';
                        TextoFechaAplicacion := '';
                        FechaAplicacionCtrl.Enabled := False;
                        HelpKeyword := 'a_adv';
                        ExtendedName := 'adv';
                        end;
       end;

     SetBarItemsVisible( [ TrazaItem ], DataModule00.Trazabilidad );

     NroDocumentoCaptionLabel.Caption := TextoNroDocumento;
     FechaAplicacionCaptionLabel.Caption := TextoFechaAplicacion;
     RegistroAuxiliarLabel.Caption := NombreAuxiliarCliente( True, False );

     SetButtonVisible( FacturaDirectaButton, TipoMovimientoEdicion=tmVenta );
     SetButtonVisible( FacturarButton, TipoMovimientoEdicion=tmVenta );
     SetButtonVisible( FirmarButton, Configuracion.ModuloOpcionalActivado( moTabletaFirma ) and not DataModule00.DmUsuarioFields.Ventas_DesactivarTabletaFirma.Value );
     SetButtonVisible( HojaCargaButton, ( TipoMovimientoEdicion=tmPedidoVenta ) and ApplicationContainer.IsModuleActive( [ 40, 70 ] ) );
     SetButtonVisible( LanzarButton, ( TipoMovimientoEdicion=tmPedidoVenta ) and ApplicationContainer.IsModuleActive( [ 70 ] ) );

     CenterInParent( ButtonContainerPanel );

     With DataModule00.DmEmpresaFields do
       begin

       // Antes estaban dentro de un Panel, pero siempre habían problemas con la alineación y los temas

       If   not Movimiento.SeriesEnDocumentosVenta( TipoMovimientoEdicion )
       then begin
            SerieCtrl.Visible := False;
            SeparadorSerieLabel.Visible := False;
            LockRangeButton.Visible := False;
            end;

       FCamposOpcionalesVisibles := 0;

       SetupPanelableCtrl( FechaAplicacionCtrl, ( ( TipoMovimientoEdicion=tmPresupuesto ) or ( ( TipoMovimientoEdicion=tmPedidoVenta ) and not Ventas_FechaEntregaPorLinea.Value ) ), FCamposOpcionalesVisibles );
       SetupPanelableCtrl( OrganismoPublicoCtrl, Configuracion.ModuloOpcionalActivado( moFacturaElectronica ), FCamposOpcionalesVisibles );
       SetupPanelableCtrl( RegistroAuxiliarCtrl, Cliente_RegAuxiliar.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( GrupoClienteCtrl, Cliente_GruposFac.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( TransportistaCtrl, Ventas_Transportista.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( CodigoOperarioCtrl, Ventas_Operarios.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( FormaCobroCtrl, Ventas_PagosPedido.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( VendedorCtrl, not Vendedor_ComPorCli.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( NroDocumentoPropietarioCtrl, TipoMovimientoEdicion=tmPedidoVenta, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( CentroCosteCtrl, Contable_CtrosCoste.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( FormaEnvioCtrl, Ventas_FormaEnvio.Value, FCamposOpcionalesVisibles );
       SetupPanelableCtrl( OpcionCtrl, Movimiento.ModuloHojasDePedido and ( TipoMovimientoEdicion=tmPedidoVenta ), FCamposOpcionalesVisibles );

       SetupPanelableCtrl( EstadoCtrl, TipoMovimientoEdicion=tmPresupuesto );
       SetupPanelableCtrl( ServidoCtrl, TipoMovimientoEdicion=tmPedidoVenta );
       SetupPanelableCtrl( EnviadoCtrl, ( TipoMovimientoEdicion=tmVenta ) and DataModule00.TiendaVirtual );

       SetupPanelableCtrl( NoFacturarCtrl, TipoMovimientoEdicion=tmVenta );
       SetupPanelableCtrl( EntregaACuentaCtrl, TipoMovimientoEdicion in [ tmPedidoVenta, tmVenta ] );
       SetupPanelableCtrl( PortesCtrl, ( ( TipoMovimientoEdicion=tmPresupuesto ) and Ventas_FormaEnvio.Value ) or ( TipoMovimientoEdicion in [ tmPedidoVenta, tmVenta ] ) );

       SetEditControlsDecimals( [ EntregaACuentaCtrl, PortesCtrl ] );

       SetupCamposLibres( [ CampoLibre1Ctrl, CampoLibre2Ctrl, CampoLibre3Ctrl, CampoLibre4Ctrl, CampoLibre5Ctrl ] );
       end;

     OperarioLabel.Caption := NombreOperarios( { Capital } True );
     EntregasACuentaPedidosLabel.Visible := TipoMovimientoEdicion=tmVenta;

     // Contando las bandas visibles

     GridViewServido.Visible := TipoMovimientoEdicion=tmPedidoVenta;
     ServidoLabel.Visible := GridViewServido.Visible;
     ServidoTotalPanel.Visible := GridViewServido.Visible;

     If   TipoMovimientoEdicion=tmPresupuesto
     then With ConsumosPreciosButton do
            begin
            Caption := RsMsg22;
            GlyphBitmap := gmFields;
            Hint := RsMsg23;
            end;

     ConsumosPreciosButton.Visible:= ( TipoMovimientoEdicion=tmPresupuesto ) or ( ( TipoMovimientoEdicion in [ tmPedidoVenta, tmVenta ] ) and ExisteModuloPreventa );

     PesoLabel.Visible := DataModule00.DmEmpresaFields.Articulo_Bultos.Value; // Incluye peso y volumen
     PesoTotalPanel.Visible := PesoLabel.Visible;

     // -------

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoAuxFields := TLineaMovimientoFields.Create( LineaMovimientoAuxTable );

     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ClaseFields := TClaseFields.Create( Self );
     EnvaseFields := TClaseFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       PreciosConIVAIncluido := Articulo_PreciosIVA.Value and not Ventas_DocumentosSinIVAIncluido.Value;

       GridViewFechaAplicacion.Visible := ( TipoMovimientoEdicion=tmPedidoVenta ) and Ventas_FechaEntregaPorLinea.Value;
       GridViewNumeroSerie.Visible := ( TipoMovimientoEdicion=tmVenta ) and Ventas_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value and ( ( ( TipoMovimientoEdicion=tmPedidoVenta ) and Ventas_MostrarLotesPedido.Value ) or ( TipoMovimientoEdicion=tmVenta ) );
       // GridViewLoteFabricacion.Properties.Required := Ventas_LotesObligatorios.Value;
       GridViewFechaCaducidad.Visible := ( TipoMovimientoEdicion=tmVenta ) and DataModule00.Trazabilidad and Ventas_FechaCaducidad.Value;
       GridViewTipoLinea.Visible:= Stock_TiposLineaMovimiento.Value;
       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewPrecioDivisa.Visible := Ventas_Divisas.Value;
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewBultos.Visible := Articulo_Bultos.Value and Ventas_EditarBultosAlbaran.Value;
       GridViewLargo.Visible := Ventas_Cantidades.Value>0;
       GridViewAncho.Visible := Ventas_Cantidades.Value>0;
       GridViewAlto.Visible := Ventas_Cantidades.Value>1;
       GridViewCodigoTipoIVA.Visible := Ventas_TiposIVAModificables.Value;
       GridViewPrecio.Visible := not PreciosConIVAIncluido;
       GridViewPrecioIVA.Visible := PreciosConIVAIncluido;
       GridViewRecargo.Visible := Ventas_Recargos.Value;
       GridViewImporte.Visible := not PreciosConIVAIncluido;
       GridViewImporteTotal.Visible := PreciosConIVAIncluido;

       If   GridViewFechaAplicacion.Visible
       then GridViewFechaAplicacion.Properties.Required := True;

       Movimiento.SetupCamposLibresLineaVentas( GridView, [ GridViewCampoLibre1, GridViewCampoLibre2,GridViewCampoLibre3, GridViewCampoLibre4, GridViewCampoLibre5 ] );

       // Una excepción. El campo de comprobación solo debe usarse en los pedidos.

       If   GridViewCampoLibre1.Visible and
            DataModule00.DmEmpresaFields.Ventas_CampoLibreLineasComp.Value and
            ( TipoMovimientoEdicion<>tmPedidoVenta )
       then GridViewCampoLibre1.Visible := False;

       If   ( TipoMovimientoEdicion=tmVenta ) and ( Articulo_Envase.Value<>0 ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
       then begin

            With GridViewServido do
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

            GridViewCantidadAjustada.HeaderHint := 'Cantidad neta';
            end;

       DocumentosGroupBox.Visible := ( TipoMovimientoEdicion=tmPedidoVenta ) and Movimiento.ModuloHojasDePedido;
       GridViewTieneDocumentosAsociados.Visible := DocumentosGroupBox.Visible;
       If   GridViewTieneDocumentosAsociados.Visible
       then TableViewManager.OnShowDocument := DoShowDocument;

       SetColumnsDecimals( [ GridViewCantidadAjustada, GridViewPesoEnvase, GridViewTara, GridViewCantidadCargada, GridViewServido, GridViewCampoLibre4 ], Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewPrecioDivisa, GridViewPuntoVerde ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewRecargo, Ventas_DecRecargo.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       SetColumnsDecimals( [ GridViewPrecioIVA, GridViewImporte, GridViewImporteTotal ] );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Ventas_DecCajas.Value );
       SetColumnDecimals( GridViewBultos, IfThen( Ventas_ContenedoresSonPallets.Value, Ventas_DecCantidad.Value, 0 ) );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then GridViewAlto.Caption := Ventas_NombreCajas.Value
            else GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       If   GridViewBultos.Visible and ( Ventas_NombreBultos.Value<>'' )
       then GridViewBultos.Caption := Ventas_NombreBultos.Value;

       GridViewPrecio.Options.Editing := DataModule00.PreciosEditables;
       GridViewDescuento.Options.Editing := DataModule00.DescuentosEditables;
       GridViewRecargo.Options.Editing := DataModule00.DescuentosEditables;

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then GridViewRecargo.Caption := Ventas_NombreRecargos.Value;

       If   DataModule00.PartidasPresupuestarias
       then If   Ventas_NombrePaginas.Value<>''
            then PaginasLabel.Caption := Capitaliza( Ventas_NombrePaginas.Value, True, True );  // En plural

       FNoActualizarTipoIVA := Ventas_TiposIVAModificables.Value;

       // Sumatorios

       SetFooterSummaryItemsDecimals( GridView, [ 0, 1 ] , Ventas_DecCantidad.Value );
       SetFooterSummaryItemDecimals( GridView, 2, 3 );
       SetFooterSummaryItemsDecimals( GridView, [ 3, 4, 5 ] );

       CaptionNroPagina := GrupoDocumento.ObtenCabeceraGrupos;

       end;

     If   TipoMovimientoEdicion=tmPresupuesto
     then FormManager.OnLabelsRequest := nil;

     // SetBarItemsVisible( [ LineasAlbaranItem ], TipoMovimientoEdicion in [ tmPresupuesto, tmPedidoVenta ] );
     SetBarItemsVisible( [ FacturaVentaItem ], TipoMovimientoEdicion=tmVenta );

     Grid.ShowHint := True;

     PaginasPanel.Visible := DataModule00.PartidasPresupuestarias;
     PaginacionSplitter.Visible := PaginasPanel.Visible;
     GridView.OptionsView.Footer := DataModule00.PartidasPresupuestarias;

     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesVentas );

     RejillaPopupMenu.Images := ApplicationForms.ControlsImageList;

     MovimientoTable.SetDefaultRangeValues( [ TipoMovimientoEdicion, ApplicationContainer.Ejercicio ], [ TipoMovimientoEdicion, ApplicationContainer.Ejercicio ] );
     SetFieldRange( MovimientoFields.NroDocumento );

     SerieActual := #0;
     PropietarioActual := #0;

end;

procedure TMntMveForm.FormManagerLabelsRequest;
begin
     With MovimientoFields do
       EtiquetasArticulosDesdeMovimientos( TipoMovimientoEdicion, Serie.Value, NroDocumento.Value, Propietario.Value );
end;

procedure TMntMveForm.ObtenExistencias;
begin
     ObtenyMuestraExistencias( GridView,
                               TableViewManager,
                               LineaMovimientoFields,
                               ExistenciasArticulo,
                               MovimientoFields.Propietario.Value,
                               StockFrame );
end;

procedure TMntMveForm.MuestraRiesgo;
begin
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaContenido( ClienteFields );
end;

procedure TMntMveForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( TipoMovimientoEdicion, sdTodos, Serie, Sender, qgsLinked );
end;

procedure TMntMveForm.GridEnter(Sender: TObject);
begin
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( False );
end;

procedure TMntMveForm.GridExit(Sender: TObject);
begin
     ObtenExistencias;  // Para ocultar el panel
end;

procedure TMntMveForm.GridViewCampoLibre1PropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ( TipoMovimientoEdicion=tmPedidoVenta ) and
          DataModule00.DmEmpresaFields.Ventas_CampoLibreLineasComp.Value
     then begin
          var CodArticulo := VarToStr( DisplayValue );
          If   CodArticulo<>''
          then begin
               If   Articulo.CodigoBarras( CodArticulo, CodClaseA, CodClaseB, CodClaseC, FijarClases  )
               then begin
                    If   CodArticulo<>LineaMovimientoFields.CodigoArticulo.Value
                    then begin
                         Error := True;
                         ErrorText := RsMsg53;
                         end;
                    end
               else begin
                    Error := True;
                    ErrorText := RsMsg52;
                    end;
               end;
          end;
end;

procedure TMntMveForm.GridViewCantidadAjustadaPropertiesEnter( Sender : TcxCustomEdit );
begin

     Sender.ShowHint := False;

     If        DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and
          not  DataModule00.DmEmpresaFields.articulo_ExisteClase[ tcClaseC ].Value
     then begin
          Sender.Hint := RsMsg37;
          Sender.ShowHint := True;
          end;

     With GridViewCantidadAjustada do
       If   Assigned( Sender ) and ( LineaMovimientoFields.TipoMovimientoOrigen.Value=tmConsumos ) and ValueIsEmpty( EditValue )
       then If   Movimiento.DmConsumosClienteTable.FindKey( [ MovimientoFields.Propietario.Value, LineaMovimientoFields.NroRegistroOrigen.Value ] )
            then With Sender do
                   EditValue := Movimiento.DmConsumosClienteFields.Cantidad.Value;

end;

procedure TMntMveForm.GridViewCantidadAjustadaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   LineaMovimientoTable.Editing and not AjustandoCantidad
     then If   ( TipoMovimientoEdicion=tmVenta ) and
               not ValueIsEmpty( LineaMovimientoFields.CodigoArticulo.Value ) and
               ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual )
          then If   not TableViewManager.ValidatingTableViewAfterEdit
               then begin
                    var Cantidad := VarToDecimal( DisplayValue );
                    StockAlmacen.CompruebaSalida( Cantidad, GridViewCantidadAjustada, LineaMovimientoFields, ArticuloFields, SerieFacturacionFields, ExistenciasArticulo, ClienteFields.Factura_Tarifa.Value, ErrorText, Error );
                    If   not Error and ( TipoMovimientoEdicion=tmVenta ) and ( LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoVenta )
                    then Movimiento.CompruebaCantidadPendientePedido( Cantidad, LineaMovimientoFields, ErrorText, Error  );
                    end;
end;

procedure TMntMveForm.GridViewCantidadAjustadaPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     // Esta ampliación sólo se aplica cuando existen tan solo clases A y B
     If        DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and
          not  DataModule00.DmEmpresaFields.articulo_ExisteClase[ tcClaseC ].Value
     then If   LineaMovimientoTable.State=dsInsert
            then With LineaMovimientoFields do
                   CodigoClaseB.Value := Clase.ProximoCodigo( tcClaseB, CodigoClaseB.Value );
end;

procedure TMntMveForm.GridViewCantidadAjustadaPropertiesQueryRequest(Sender: TcxCustomEdit);
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

procedure TMntMveForm.GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
begin

     If   not AjustandoCantidad
     then try
            AjustandoCantidad := True;
            ActualizaCantidad;
            With GridViewCantidadAjustada do
               If   Editing
               then begin
                     ActualizaValorBultos( LineaMovimientoFields.NroCajas.Value, EditValue );
                     If   ValueIsEmpty( EditValue ) and ( LineaMovimientoFields.NroCajas.Value=0 )  // Si se mantienen las cajas no limpio el precio
                     then Movimiento.LimpiaImportesLinea( LineaMovimientoFields )
                     else ActualizaRelaciones;
                     ActualizaCamposCalculadosLinea;
                     ReajustaPrecioBase;
                     end;

            finally
              AjustandoCantidad := False;
              end;
end;

procedure TMntMveForm.ActualizaCamposCalculadosLinea;
begin
     If   not FActualizandoCamposCalculadosLinea
     then try
            FActualizandoCamposCalculadosLinea := True;
            Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields,
                                                            LineaMovimientoFields,
                                                            ClienteFields,
                                                            ArticuloFields,
                                                            SerieFacturacionFields,
                                                            TiposIVAFields );
            GridView.DataController.UpdateData;
          finally
            FActualizandoCamposCalculadosLinea := False;
            end;
end;

procedure TMntMveForm.ActualizaEntregasACuentaPedidos;
begin
     EntregasACuenta := 0.0;
     If   TipoMovimientoEdicion=tmVenta
     then try
            EntregasACuenta := Movimiento.EntregasACuentaPedidosOrigen( MovimientoFields );
            EntregasACuentaPedidosLabel.Caption := StrFormat( EntregasACuenta );
          except
            end;
end;

procedure TMntMveForm.DoOnTarifaConsumoSelected( Target : TcxCustomEdit = nil );
begin
     With CxTcvForm do
       begin
       LineaMovimientoTable.Edit;  // Puede darse el caso, cuando se utiliza <F4> sin haber entrado en el modo edición
       LineaMovimientoTableCantidadAjustada.Value := QueryCantidadMinima.Value;
       With LineaMovimientoFields do
         begin
         Precio.Value := QueryPrecio.Value;
         Descuento.Value := QueryDescuento.Value;
         end;
       end;
end;

procedure TMntMveForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntMveForm.GridViewCellClick(     Sender        : TcxCustomGridTableView;
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
          AHandled := True;  // Esto evita cualquier proceso posterior en TcxGridTableDataCellViewInfo.MouseUp
          end
     else If   ( ACellViewInfo.Item.Index=GridViewTieneDocumentosAsociados.Index ) and VarToBoolean( ACellViewInfo.Item.EditValue )
          then begin
               DoShowDocument;
               AHandled := True;
               end;
end;

procedure TMntMveForm.GridViewCellDblClick(     Sender        : TcxCustomGridTableView;
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

procedure TMntMveForm.ActualizaRelaciones( Forzar : Boolean = False );
begin

     //* Modificado para que no se alteren las relaciones cuando la línea proviene de otro documento

     If   not ( ( LineaMovimientoTable.State=dsEdit ) and not ValueIsEmpty( LineaMovimientoFields.NroRegistroOrigen.Value ) ) or Forzar
     then begin
          Movimiento.ActualizaRelacionesLineaSalida( MovimientoFields, LineaMovimientoFields, ArticuloFields );
          If   LineaMovimientoFields.Oferta.Value
          then With ArticuloFields do
                 ShowHintMsg( Format( RsMsg28, [ StrFormatDate( OfertaFechaInicial.Value, dfDefault2 ), StrFormatDate( OfertaFechaFinal.Value, dfDefault2 ) ] ), RsMsg29 );
          end;
end;

procedure TMntMveForm.LineasDocumentoItemClick(Sender: TObject);
begin
     With MovimientoFields do
        RelacionLineasDocumento( TipoMovimientoEdicion, Ejercicio.Value, NroOperacion.Value, Serie.Value, NroDocumento.Value );
end;

procedure TMntMveForm.GridViewCodigoAlmacenPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
begin
     Almacen.SetDefault( Sender, scVentas, ArticuloFields );
end;

procedure TMntMveForm.GridViewCodigoAlmacenPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaAlmacenes( Sender, qgsNormal, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
end;

procedure TMntMveForm.GridViewCodigoAlmacenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
begin
     LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );
end;

procedure TMntMveForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.GridViewCodigoArticuloPropertiesEnter(Sender: TcxCustomEdit);
begin
     If        DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseB ].Value and
          not  DataModule00.DmEmpresaFields.Articulo_ExisteClase[ tcClaseC ].Value
     then Sender.Hint := RsMsg36
     else Sender.Hint := '';
end;

procedure TMntMveForm.GridViewCodigoArticuloPropertiesExtendedFunction(Sender: TcxCustomEdit);
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

procedure TMntMveForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Articulo_ArticulosRelacionados.Value
     then case Sender.KeyPressed of
                0 : ShowButtonMenu( ConsultaArticulosPopupMenu, ApplicationContainer.QueryButton );
            VK_F4 : ConsultaArticulos( scVentas, False, Sender );
            VK_F6 : If   Sender.ValidateEdit
                    then ConsultaArticulosRelacionados( 0, Sender );
            VK_F7 : If   Sender.ValidateEdit
                    then ConsultaArticulosRelacionados( 1, Sender );
            VK_F8 : ;
            end
     else If   Sender.KeyPressed in [ 0, VK_F4 ]     // LLegan también las F6, F7 y F8. 0 cuando se pulsa el botón de la barra superior.
          then ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntMveForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  CodArticulo : String;

begin
     With GridViewCodigoArticulo do
       If   Editing and not ValueIsEmpty( DisplayValue )
       then begin
            CodArticulo := VarToStr( DisplayValue );
            If   Articulo.CodigoBarras( CodArticulo, CodClaseA, CodClaseB, CodClaseC, FijarClases, ArticuloFields )
            then DisplayValue := CodArticulo;
            end;
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields, False );
     If   not Error
     then FacturaVentas.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );
end;

procedure TMntMveForm.GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);

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

         
              Movimiento.LimpiaImportesLinea( LineaMovimientoFields );

              If   LineaMovimientoFields.Cantidad.Value<>0.0
              then ActualizaRelaciones( { Forzar } True );

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
              GridView.DataController.UpdateData;  // El UpdateData de ActualizaCamposCalculadosLinea no se ejecuta porque los controles están desactivados
              end;

            ObtenExistencias;
            end;

     FijarClases := False;
     
end;

procedure TMntMveForm.GridViewCodigoClasePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Column : TcxGridColumn;

begin

     If   LineaMovimientoTable.Editing
     then begin

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
                         end;
               end;

          end;
end;

procedure TMntMveForm.GridViewCodigoClasePropertiesValuePosted( Sender: TObject);
begin
     If   ExisteEnvase
     then ActualizaValorCantidadyEnvases( LineaMovimientoFields.NroCajas.Value );
end;

procedure TMntMveForm.GridViewCodigoTipoIVAPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntMveForm.GridViewCodigoTipoIVAPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siRepercutido, LineaMovimientoTableFecha.Value, FCodigoPaisIVA );
end;

procedure TMntMveForm.GridViewCodigoTipoIVAPropertiesValuePosted( Sender : TObject );
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMveForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntMveForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean );
begin
     If   ShowFocusedRowHighlited and AViewInfo.GridRecord.Focused
     then ACanvas.Brush.Color := clRowHighlight
     else If   not AViewInfo.Selected // and AViewInfo.Item.Options.Editing
          then With AViewInfo.GridRecord do
                 begin
                 If   VarToBoolean( Values[ GridViewProcesada.Index ] ) or
                      ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( VarToInteger( Values[ GridViewServido.Index ] )>0.0 ) )
                 then ACanvas.Font.Color := clGray;
                 If   TipoMovimientoEdicion=tmPedidoVenta
                 then If   Movimiento.ModuloHojasDePedido
                      then begin
                           If   IsBitSet( VarToInteger( Values[ GridViewParametros.Index ] ), 0 )
                           then ACanvas.Brush.Color := clSoftYellow;

                           If   IsBitSet( VarToInteger( Values[ GridViewParametros.Index ] ), 1 )
                           then ACanvas.Brush.Color := clSoftBlue;
                           end;
                 end;
end;

procedure TMntMveForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaClases( TNroClase( GridView.Controller.FocusedColumn.Tag ), CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, MovimientoFields.Propietario.Value, Sender );
end;

procedure TMntMveForm.ActualizaReferencias;
begin

     // Debido a que el sumatorio de la rejilla es un evento que ocurre antes de que se puedan validar
     // los valores de la cabecera me veo obligado a utilizar esta función de actualización de referencias ....

     If   not ValueIsEmpty( MovimientoFields.Propietario.Value ) and
          ( ( SerieActual<>MovimientoFields.Serie.Value ) or ( PropietarioActual<>MovimientoFields.Propietario.Value ) )
     then begin

          If   SerieActual<>MovimientoFields.Serie.Value
          then SerieFacturacion.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields, False );
          SerieActual := MovimientoFields.Serie.Value;

          ObtenCliente( MovimientoFields.Propietario.Value );

          CalcularIVA := not ( ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or SerieFacturacionFields.ExentoIVA.Value );
          end;
end;

procedure TMntMveForm.ReajustaPrecioBase;

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

procedure TMntMveForm.GridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   TabKey and not ShiftKey and GridView.DataController.IsEditing
     then If   AFocusedItem=GridViewDescripcion
          then begin
               If   GridViewDescripcion.EditValue<>''
               then With GridView.Controller do
                      FocusedColumnIndex := FocusedColumnIndex + 1;
               end
          else { No recuerdo su cometido, pero interfiere
               If   ( APrevFocusedItem=GridViewNroCajas ) and
                    DataModule00.Envases and
                    not ExisteEnvase
               then GridView.Controller.FocusedColumnIndex := GridViewCantidadAjustada.VisibleIndex
               else }
                    If   ( APrevFocusedItem=GridViewCantidadAjustada ) and ValueIsEmpty( GridViewCantidadAjustada.EditValue )
                    then GridView.Controller.GoToNext( True );

end;

procedure TMntMveForm.GridViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                    APrevFocusedRecord,
                                                    AFocusedRecord                : TcxCustomGridRecord;
                                                    ANewItemRecordFocusingChanged : Boolean );
begin
     If   MovimientoTable.Editing
     then begin
          ObtenExistencias;
          ActualizaEstadoLineas;
          GridViewAutoEditChanged;
          end;
end;

procedure TMntMveForm.GridViewAutoEditChanged;

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

          Dlm := MovimientoDataSource.AutoEdit or ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( MovimientoFields.Situacion.Value=epParcialmenteProcesado ) and ( FocusedRecord.Values[ GridViewServido.Index ]=0.0 ) and not ( VarToBoolean( FocusedRecord.Values[ GridViewProcesada.Index ] ) ) );

          If   Dlm<>DatosLineaModificables
          then begin
               DatosLineaModificables := Dlm;
               SetColumnsEditingOption( GridView, DatosLineaModificables );
               end;

          // El lote y el número se serie se pueden modificar siempre, a excepción de los usuarios a los que se asigna automáticamente el lote.

          GridViewLoteFabricacion.Properties.ReadOnly := DataModule00.DmEmpresaFields.Ventas_LotesObligatorios.Value and ( DataModule00.DmUsuarioFields.AcVEProcesos.Value=0 );
          GridViewNumeroSerie.Properties.ReadOnly := False;

          // El código del artículo no se puede modificar si la línea proviene de otro documento
          // Las clases tampoco deberían modificarse pero, por imperativo clientelar, he tenido que dejar que se puedan modificar en algunos casos

          GridViewCodigoArticulo.Properties.ReadOnly := not DatosLineaModificables or ExisteDocumentoOrigen;

          end
     else If   not DatosLineaModificables
          then begin
               DatosLineaModificables := True;
               SetColumnsEditingOption( GridView, True );
               end;

end;

procedure TMntMveForm.GridViewBultosPropertiesValuePosted(Sender: TObject);
begin
     If   DataModule00.DmEmpresaFields.Ventas_ContenedoresSonPallets.Value and GridViewBultos.Editing
     then If   ( LineaMovimientoFields.Bultos.Value<>0.0 ) and
               ( ArticuloFields.UnidadesPorPallet.Value<>0.0 )
          then begin
               var Cantidad := LineaMovimientoFields.Bultos.Value * ArticuloFields.UnidadesPorPallet.Value;
               ActualizaValorCantidad( Cantidad );
               end;
end;

procedure TMntMveForm.GridViewImporteGetCellHint(       Sender           : TcxCustomGridTableItem;
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

procedure TMntMveForm.GridViewImporteGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                         ARecord : TcxCustomGridRecord;
                                                     var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporte.Index ] ), DecimalesMoneda, True );
end;

procedure TMntMveForm.GridViewImporteTotalGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporteTotal.Index ] ), DecimalesMoneda, True );
end;

procedure TMntMveForm.GridViewInitEdit(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin

     // Se llama a la función ObtenExistencias (que actualiza el contenido de StockAlmacen.SumaExistencias ) cada vez que
     // se inicializa la edición de una columna porque el valor de las existencias puede ir variando conforme se introducen
     // mas campos en la línea, como clases, lote, almacén o ubicación. Por ese mismo motivo no creo necesario mantener una copia
     // local de StockAlmacen.SumaExistencias.

     ObtenExistencias;

     If   LineaMovimientoTable.State<>dsInsert
     then begin

          // Estos mensajes son solo para que el usuario sepa el motivo por el que no se pueden editar

          If   ( TipoMovimientoEdicion=tmPedidoVenta ) and
               not DandoLineaPorServida and
               ( ( LineaMovimientoFields.CantidadProcesada.Value<>0.0 ) or LineaMovimientoFields.Procesada.Value )
          then ShowHintMsg( RsMsg38, RsMsg39 )
          else If   ( AItem=GridViewCodigoArticulo ) or
                    ( AItem=GridViewCodigoClaseA ) or
                    ( AItem=GridViewCodigoClaseB ) or
                    ( AItem=GridViewCodigoClaseC )
               then If   Assigned( AItem.Properties ) and AItem.Properties.ReadOnly
                    then ShowHintMsg( RsMsg40, RsMsg41 );

          end;
end;

procedure TMntMveForm.GridViewLoteFabricacionPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg2;
end;

procedure TMntMveForm.GridViewLoteFabricacionPropertiesExtendedFunction(Sender: TcxCustomEdit);

var  LoteFabricacion,
     CodigoAlmacen,
     CodigoUbicacion : String;

begin
     If   Movimiento.ObtenPrimerLoteConExistencias( LineaMovimientoFields.CodigoArticulo.Value, LoteFabricacion, CodigoAlmacen, CodigoUbicacion )
     then begin
          LineaMovimientoTable.Edit;
          LineaMovimientoFields.LoteFabricacion.Value := LoteFabricacion;
          LineaMovimientoFields.CodigoAlmacen.Value := CodigoAlmacen;
          LineaMovimientoFields.Ubicacion.Value := CodigoUbicacion;
          end;
end;

procedure TMntMveForm.GridViewInitEditValue(     Sender : TcxCustomGridTableView;
                                                 AItem  : TcxCustomGridTableItem;
                                                 AEdit  : TcxCustomEdit;
                                             var AValue : TcxEditValue );
begin
     If   AItem=GridViewPrecioIVA
     then AValue := GridView.DataController.Values[ GridView.DataController.EditingRecordIndex, GridViewPrecioIVA.Index ];
end;

procedure TMntMveForm.GridViewLoteFabricacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin

     // Evitando que pueda consultar los lotes si son obligatorios y es un usuario de segunda (sin acceso a procesos)
     // En un futuro se podría poner una opción adicional en accesos de usuarios, pero es poco probable que lo usen muchos clientes

     If   not ( DataModule00.DmEmpresaFields.Ventas_LotesObligatorios.Value and ( DataModule00.DmUsuarioFields.AcVEProcesos.Value=0 ) )
     then If   DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value or
               DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value
          then ConsultaLotesProductos2( Sender, GridViewCodigoArticulo.EditValue, MovimientoFields.Fecha.Value, DoOnLoteProducto2Selected )
          else ConsultaLotesProductos1( Sender, GridViewCodigoArticulo.EditValue, DoOnLoteProducto1Selected );
end;

procedure TMntMveForm.GridViewLoteFabricacionPropertiesValuePosted(Sender: TObject);
begin
     LoteAsignado := False;
end;

procedure TMntMveForm.ActualizaValorCantidad( Value : Decimal );
begin
     GridViewCantidadAjustada.EditValue := Value;
     If   TipoMovimientoEdicion=tmVenta
     then LineaMovimientoFields.Cantidad.Value := -Value
     else LineaMovimientoFields.Cantidad.Value := Value;
     ActualizaRelaciones;
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMveForm.GridViewAfterSummary(ASender: TcxDataSummary);
begin

     If   Assigned( MovimientoFields ) and
          Assigned( ClienteFields ) and ClienteFields.Initialized and
          not LineaMovimientoTable.ControlsDisabled and
          not GrupoLineaMovimientoFields.NroPagina.IsNull   // Estamos insertando un grupo de línea
     then begin

          ActualizaReferencias;

          With SumasPagina[ GrupoLineaMovimientoFields.NroPagina.Value ], ASender do
            begin

            LimpiaPagina;

            Cantidad := VarToDecimal( FooterSummaryValues[ 0 ] );
            CantidadProcesada := VarToDecimal( FooterSummaryValues[ 1 ] );
            Peso := VarToDecimal( FooterSummaryValues[ 2 ] );
            Alto := VarToDecimal( FooterSummaryValues[ 6 ] );

            FacturaVentas.AcumulaValoresImpositivos( TasasArray, MovimientoFields.Fecha.Value, ClienteFields.Factura_ModeloIVA.Value, CalcularIVA, SumaTasas );

            MuestraTotales;

            Movimiento.InicializaValoresImpositivos( TasasArray );

            end;

          end;

end;

procedure TMntMveForm.MuestraTotales;

var  NroPagina,
     Index : SmallInt;
     SumasPaginaItem : TSumasPagina;
     BaseImponibleTipo,
     ImporteEcoTasasTipo,
     CuotaIVATipo,
     CuotaRETipo,
     CuotaIVAPortes,
     CuotaREPortes,
     TotalIVAIncluido : Decimal;

begin

     CantidadTotal := 0.0;
     CantidadProcesadaTotal := 0.0;
     PesoTotal := 0.0;
     AltoTotal := 0.0;
     ImporteNetoTotal := 0.0;
     ImporteIVAIncluidoTotal := 0.0;

     If   ClienteFields.Initialized
     then begin

          // Cantidades, pesos e importes netos se acumulan por página, los valores impositivos hay que acumularlos por tipo

          For NroPagina := 0 to FSumasPagina.Count - 1 do
            begin

            SumasPaginaItem := SumasPagina[ NroPagina ];

            DecAdd( CantidadTotal, SumasPaginaItem.Cantidad );
            DecAdd( CantidadProcesadaTotal, SumasPaginaItem.CantidadProcesada );
            DecAdd( PesoTotal, SumasPaginaItem.Peso );
            DecAdd( AltoTotal, SumasPaginaItem.Alto );

            DecAdd( ImporteNetoTotal, SumasPaginaItem.SumaTasas.BaseImponible );

            If   PreciosConIVAIncluido
            then DecAdd( ImporteIVAIncluidoTotal, SumasPaginaItem.SumaTasas.Importe )
            
            end;

          If   not PreciosConIVAIncluido
          then For Index := 0 to NroMaximoTiposTasas do
                 begin

                 BaseImponibleTipo := 0.0;
                 ImporteEcoTasasTipo := 0.0;
                 CuotaIVATipo := 0.0;
                 CuotaRETipo := 0.0;
                 
                 For NroPagina := 0 to FSumasPagina.Count - 1 do
                   begin
              
                   SumasPaginaItem := SumasPagina[ NroPagina ];
          
                   DecAdd( ImporteEcoTasasTipo, SumasPaginaItem.TasasArray[ Index ].BaseNoSujetaDto );
          
                   If   SumasPaginaItem.TasasArray[ Index ].BaseImponible<>0.0
                   then begin
                         DecAdd( BaseImponibleTipo, SumasPaginaItem.TasasArray[ Index ].BaseImponible );
                         DecAdd( CuotaIVATipo, SumasPaginaItem.TasasArray[ Index ].CuotaIVA );
                         DecAdd( CuotaRETipo, SumasPaginaItem.TasasArray[ Index ].CuotaRE );
                         end;

                   end;

                 DecAdd( ImporteIVAIncluidoTotal, Redondea( BaseImponibleTipo ) + Redondea( ImporteEcoTasasTipo ) +  Redondea( CuotaIVATipo ) +  Redondea( CuotaRETipo ) );
                                                  
                 end;

          With DataModule00.DmEmpresaFields do
            begin
            
            FooterPanelCantidad.Caption := StrFormat( CantidadTotal, Ventas_DecCantidad.Value, False );
            FooterPanelServido.Caption := StrFormat( CantidadProcesadaTotal, Ventas_DecCantidad.Value );
            FooterPanelPeso.Caption := StrFormat( PesoTotal );
            FooterPanelAlto.Caption := StrFormat( AltoTotal );
            FooterPanelImporte.Caption := StrFormat( ImporteNetoTotal );

            ActualizaReferencias;

            FacturaVentas.ObtenCuotasPortes( MovimientoFields.Portes.Value, MovimientoFields.Fecha.Value, ClienteFields.Factura_ModeloIVA.Value, CuotaIVAPortes, CuotaREPortes );

            TotalIVAIncluido := ImporteIVAIncluidoTotal + MovimientoFields.Portes.Value + CuotaIVAPortes +  CuotaREPortes;

            FooterPanelIVAIncluido.Caption := StrFormat( TotalIVAIncluido );

            FOnMuestratotales.Invoke;
            end;

          end;

end;

procedure TMntMveForm.DoOnSumasPaginaNotify(       Sender : TObject;
                                             const Item   : TSumasPagina;
                                                   Action : TCollectionNotification );
begin
     If   Action=cnRemoved
     then Item.Free;
end;

function TMntMveForm.GetSumasPagina( Index : SmallInt ) : TSumasPagina;

var  PageIndex : SmallInt;

begin
     If   not Assigned( FSumasPagina )
     then FSumasPagina := TList<TSumasPagina>.Create;
     If   Index>=FSumasPagina.Count
     then For PageIndex := FSumasPagina.Count to Index do
            FSumasPagina.Add( TSumasPagina.Create );
     Result := FSumasPagina.Items[ Index ];
end;

procedure TMntMveForm.SetTabletFirmaConectado( const Value : Boolean );
begin
     FTabletFirmaConectado := Value;
     FirmarButton.Enabled := Value;
end;

procedure TMntMveForm.GridViewFooterSummaryItems(     ASender      : TcxDataSummaryItems;
                                                      Arguments    : TcxSummaryEventArguments;
                                                  var OutArguments : TcxSummaryEventOutArguments );

var  TipoDeIVA : SmallInt;
     Cp : Decimal;

begin
     If   Arguments.SummaryItem.Index=1
     then With GridView.DataController, Arguments do
            begin

            If   VarToBoolean( GetValue( RecordIndex, GridViewProcesada.Index ) )
            then Cp := VarToDecimal( GetValue( RecordIndex, GridViewCantidadAjustada.Index ) )
            else Cp := VarToDecimal( GetValue( RecordIndex, GridViewServido.Index ) );

            OutArguments.SummaryValue := OutArguments.SummaryValue + Cp;
            end
     else If   Arguments.SummaryItem.Index=4 // CuotaIVA
          then With GridView.DataController, Arguments do
                 With SumasPagina[ GrupoLineaMovimientoFields.NroPagina.Value ] do
                   try
                     TipoDeIVA := VarToSmallInt( GetValue( RecordIndex, GridViewCodigoTipoIVA.Index ) );
                     If   TipoDeIVA in [ 0..NroMaximoTiposTasas ]
                     then begin
                          DecAdd( TasasArray[ TipoDeIVA ].BaseImponible, VarToDecimal( GetValue( RecordIndex, GridViewImporte.Index ) ) );
                          DecAdd( TasasArray[ TipoDeIVA ].CuotaIVA, VarToDecimal( GetValue( RecordIndex, GridViewCuotaIVA.Index ) ) );
                          DecAdd( TasasArray[ TipoDeIVA ].CuotaRE, VarToDecimal( GetValue( RecordIndex, GridViewCuotaRE.Index ) ) );
                          DecAdd( TasasArray[ TipoDeIVA ].Importe, VarToDecimal( GetValue( RecordIndex, GridViewImporteTotal.Index ) ) );
                          end;
                   except
                     end;
end;

procedure TMntMveForm.GridViewUpdatePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMveForm.GridViewDimensionPropertiesValuePosted(Sender: TObject);
begin
     With GridView.Controller.FocusedColumn do
        If   Editing
        then With LineaMovimientoFields do
               ActualizaValorCantidad( Movimiento.CalculoEspecial( scventas, Largo.Value, Ancho.Value, Alto.Value ) );
end;

procedure TMntMveForm.GridViewNroCajasPropertiesValuePosted(Sender: TObject);
begin
     With GridViewNroCajas do
       If   Editing
       then ActualizaValorCantidadyEnvases( EditValue );
end;

procedure TMntMveForm.ActualizaValorCantidadyEnvases( NroCajas : Decimal );

var  Cantidad : Decimal;

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
             ActualizaValorBultos( NroCajas, Cantidad );

          finally
            LineaMovimientoTable.EnableControls;
            GridView.DataController.UpdateData;
            end;

end;

procedure TMntMveForm.ActualizaValorBultos( NroCajas, Cantidad : Decimal );

var  Unidades,
     NroBultos : Decimal;

begin

     // Cuando se utilizan contenedores los bultos no provienen del artículo ni dependen de las cajas o la cantidad

     If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value and
          ( DataModule00.DmEmpresaFields.Articulo_Contenedor.Value=0 ) and
          not DataModule00.DmEmpresaFields.Ventas_ContenedoresSonPallets.Value
     then begin

          If   ArticuloFields.UnidadesPorCaja.Value>1.0
          then Unidades := NroCajas
          else Unidades := Cantidad;

          // Si los bultos de la ficha son positivos son el número de bultos por unidad, si son negativos
          // indican el número de unidades que hay en un bulto

          //* 08.08.2025  Si no hay bultos en la ficha y el usuario ha introducido en la línea un valor en el campo bultos, se debe respetar.
          //              Por lo visto lo utilizaban en versiones anteriores para otros cometidos.

          If   not ( ( LineaMovimientoFields.Bultos.Value<>0.0 ) and ( ArticuloFields.Bultos.Value=0.0 ) )
          then begin
               NroBultos := 0.0;
               If   ArticuloFields.Bultos.Value>0.0
               then NroBultos := Unidades * ArticuloFields.Bultos.Value
               else If   ArticuloFields.Bultos.Value<0.0
                    then NroBultos := Unidades / Abs( ArticuloFields.Bultos.Value );
               LineaMovimientoFields.Bultos.Value := NroBultos;
               end;

          end;
end;

procedure TMntMveForm.GridViewPrecioIVAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Precio : Double;

begin
     If   Assigned( Sender ) and Sender.Editing and Sender.ModifiedAfterEnter
     then Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                           LineaMovimientoFields.Cantidad.Value,
                                           Sender.EditingValue,
                                           Precio,
                                           ClienteFields.Factura_ModeloIVA.Value=micConRE );
end;

procedure TMntMveForm.GridViewNumeroSeriePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaNumerosSerie( Sender, GridViewCodigoArticulo.EditValue, nil );
end;

procedure TMntMveForm.GridViewPesoEnvasePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMveForm.GridViewPrecioDivisaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposCambio( MovimientoFields.Fecha.Value );
end;

procedure TMntMveForm.GridViewPrecioDivisaPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoCambio.Valida( CodigoDivisa, MovimientoFields.Fecha.Value, TipoDeCambio, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.GridViewPrecioDivisaPropertiesValuePosted(Sender: TObject);
begin
     With GridViewPrecioDivisa do
       If   Editing and ( LineaMovimientoFields.PrecioDivisa.Value<>0.0 )
       then begin
            LineaMovimientoFields.Precio.Value := LineaMovimientoFields.PrecioDivisa.Value * TipoDeCambio;
            ActualizaCamposCalculadosLinea;
            end;
end;

procedure TMntMveForm.GridViewPrecioIVAPropertiesValuePosted(Sender: TObject);
begin
     If   GridViewPrecioIVA.Editing
     then ReajustaPrecioBase;
end;

procedure TMntMveForm.GridViewPrecioPropertiesEnter(Sender: TcxCustomEdit);
begin
     Sender.Hint := RsMsg17;
end;

procedure TMntMveForm.GridViewPrecioPropertiesExtendedFunction( Sender: TcxCustomEdit);

var  Precio : Double;

begin
     LineaMovimientoTable.Edit;
     If   Sender.DoEditing
     then With ArticuloFields do
            begin
            Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                             LineaMovimientoFields.Cantidad.Value,
                                             VarAsType( Sender.EditingValue, varDouble ),
                                             Precio,
                                             ClienteFields.Factura_ModeloIVA.Value=micConRE );
            With Sender do
              begin
              PostEditValue( RedondeaExt( Precio, DataModule00.DmEmpresaFields.Ventas_DecPrecio.Value ) );
              SelectAll;
              end;

            end;
end;

procedure TMntMveForm.GridViewPrecioPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value
     then ConsultaTarifasVenta( Sender, LineaMovimientoFields.CodigoArticulo.Value, DoAplicaTarifa )
     else ShowHintMsg( RsMsg24, RsMsg25, Sender );
end;

procedure TMntMveForm.GridViewPrecioPropertiesValuePosted(Sender: TObject);
begin
     If   PreciosConIVAIncluido
     then With GridViewPrecio do
            If   not FReajustandoPrecioBase and Editing
            then ReajustaPrecioBase;  // Y también se recalcula precioIVA

     ActualizaCamposCalculadosLinea;
end;

procedure TMntMveForm.GridViewPuntoVerdePropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     var Value := VarToDecimal( DisplayValue );
     If   Value>LineaMovimientoFields.Precio.Value
     then begin
          Error := True;
          ErrorText := RsMsg12;
          end;
end;

procedure TMntMveForm.GridViewServidoGetDataText(     Sender       : TcxCustomGridTableItem;
                                                      ARecordIndex : Integer;
                                                  var AText        : String);

var  CantidadServida : Decimal;

begin
     With GridView.DataController do
       If   VarToBoolean( Values[ ARecordIndex, GridViewProcesada.Index ] )
       then CantidadServida := VarToDecimal( Values[ ARecordIndex, GridViewCantidadAjustada.Index ] )
       else CantidadServida := VarToDecimal( Values[ ARecordIndex, GridViewServido.Index ] );
     AText := StrFormat( CantidadServida, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value, True );
end;

procedure TMntMveForm.GridViewServidoPropertiesValuePosted(Sender: TObject);
begin
     With DataModule00.DmEmpresaFields do
       If   ( TipoMovimientoEdicion=tmVenta ) and
            ( Articulo_Envase.Value<>0 ) and
            ( Articulo_TipoEnvase.Value=tenReutilizable )
       then If   EnvaseFields.Initialized
            then If   EnvaseFields.Peso.Value<>0.0
                 then begin
                      LineaMovimientoTablePesoEnvase.Value := EnvaseFields.Peso.Value;
                      ActualizaCamposCalculadosLinea;
                      end;
end;

procedure TMntMveForm.GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText(Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
     AText := StrFormat( VarToDecimal( AValue ), DecimalesMoneda, True );
end;

procedure TMntMveForm.GridViewTipoLineaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposLineaMovimiento( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.GridViewTipoLineaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposLineaMovimiento( Sender );
end;

procedure TMntMveForm.GridViewTipoLineaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoLineaMovimiento.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.DarPorServidaItemClick(Sender: TObject);

var  CantidadRegularizada : Decimal;

begin
     If   MovimientoTable.Editing
     then begin
          CantidadRegularizada := Movimiento.DarLineaPorProcesada( MovimientoFields, LineaMovimientoFields );
          DecAdd( CantidadProcesadaTotal, CantidadRegularizada );
          MovimientoTable.PostAndEdit;
          TableViewManager.RefreshGrid;
          end;
end;

procedure TMntMveForm.DataPanelEnter(Sender: TObject);
begin
     If   Assigned( RiesgoFrame )
     then begin
          RiesgoFrame.ActualizaEstado( True, MovimientoTable.Inserting );
          MuestraRiesgo;
          end;
end;

procedure TMntMveForm.OrganismoPublicoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOrganismoPublico( [ topUnidadTramitadora, Sender.EditValue ] );
end;

procedure TMntMveForm.OrganismoPublicoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOrganismosPublicos( topUnidadTramitadora, Sender );
end;

procedure TMntMveForm.OrganismoPublicoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean );
begin
     OrganismoPublico.Valida( topUnidadTramitadora, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.DoAplicaTarifa;
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

procedure TMntMveForm.DocumentoOrigenItemClick(Sender: TObject);
begin
     FOnMuestraDocumentoOrigen.Invoke( MovimientoFields );
end;

procedure TMntMveForm.DocumentosButtonClick(Sender: TObject);
begin
     OpenFolder( FDirectorioDocumentos );
end;

procedure TMntMveForm.DoOnLoteProducto1Selected;
begin
     With CxLdp1Form do
       begin

       LoteAsignado := True;

       LineaMovimientoTable.Edit;
       LineaMovimientoTableCodigoClaseA.Value := QueryCodigoClaseA.Value;
       LineaMovimientoTableCodigoClaseB.Value := QueryCodigoClaseB.Value;
       LineaMovimientoTableCodigoClaseC.Value := QueryCodigoClaseC.Value;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       TableViewManager.ValidateTableView;  // Se tienen que validar todos los campos modificados para actualizar los registros vinculados
       end;
end;

procedure TMntMveForm.DoOnLoteProducto2Selected;
begin
     With CxLdp2Form do
       begin

       LoteAsignado := True;

       LineaMovimientoTable.Edit;

       LineaMovimientoTableCodigoClaseA.Value := QueryCodigoClaseA.Value;
       LineaMovimientoTableCodigoClaseB.Value := QueryCodigoClaseB.Value;
       LineaMovimientoTableCodigoClaseC.Value := QueryCodigoClaseC.Value;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;

       If   TipoMovimientoEdicion=tmVenta
       then begin

            If   not QueryUIDArticulo.IsNull
            then LineaMovimientoTableUIDArticulo.Value := QueryUIDArticulo.Value;

            If   QueryFechaCaducidad.AsFloat<>0
            then LineaMovimientoTableFechaCaducidad.Value := QueryFechaCaducidad.Value;

            If   LineaMovimientoTableTipoMovimientoOrigen.Value=0
            then begin
                 LineaMovimientoTableTipoMovimientoOrigen.Value := QueryTipoMovimiento.Value;
                 LineaMovimientoTableEjercicioOrigen.Value := QueryEjercicio.Value;
                 LineaMovimientoTableNroOperacionOrigen.Value := QueryNroOperacion.Value;
                 LineaMovimientoTableNroRegistroOrigen.Value := QueryNroRegistro.Value;
                 end;

            end;

       TableViewManager.ValidateTableView;
       end;
end;

procedure TMntMveForm.GridViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       MntUbicaciones( [ CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntMveForm.GridViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       If   ShiftKey
       then ConsultaUbicaciones( CodigoAlmacen.Value, ubNormal, Sender )
       else ConsultaExistenciasUbicacion( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LoteFabricacion.Value, CodigoAlmacen.Value, Sender, DoOnExistenciasSelected );
end;

procedure TMntMveForm.DoOnExistenciasSelected;
begin
     With CxEpuForm do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       // Esto es para que se valide, porque las ubicaciones pueden ser ubicaciones de carga, que pueden no ser válidas en este contexto
       QueryPanel.TargetControl.PostEditValue( QueryUbicacion.Value );
       end;
end;

procedure TMntMveForm.GridViewUbicacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( LineaMovimientoFields.CodigoAlmacen.Value, MovimientoFields.Origen.Value=omHojaCarga, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.GrupoClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposCliente( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.GrupoClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposCliente( Sender );
end;

procedure TMntMveForm.GrupoClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     GrupoCliente.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.KeyPanelEnter(Sender: TObject);
begin
     ActualizaEstado;
     If   Assigned( RiesgoFrame )
     then RiesgoFrame.ActualizaEstado( False );
end;

procedure TMntMveForm.ImportarButtonClick(Sender: TObject);

var  TiposMovimientoOrigen : TTiposMovimiento;

begin
     MovimientoTable.Update;
     case TipoMovimientoEdicion of
       tmPresupuesto : 
         TiposMovimientoOrigen := [ tmPresupuesto, tmCapturador ];
       tmPedidoVenta :
         TiposMovimientoOrigen := [ tmPresupuesto, tmPedidoCompra, tmCompra, tmCapturador ];
       tmVenta : 
         TiposMovimientoOrigen := [ tmPresupuesto, tmPedidoVenta, tmCompra, tmCapturador {, tmBascula } ];
     end;
     ImportaDocumentoVenta( MovimientoFields.Propietario.Value, DoSeleccionaDocumentoImportar, TipoMovimientoEdicion, TiposMovimientoOrigen, UltimoTipoMovimientoImportado );
end;

procedure TMntMveForm.DoSeleccionaDocumentoImportar;
begin
     With BoxSdvForm do
       begin
       UltimoTipoMovimientoImportado := DataTipoMovimiento.Value;
       case DataTipoMovimiento.Value of

         tmPedidoCompra,
         tmCompra :
           SeleccionaLineasDocumentoCompra( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, TipoMovimientoEdicion, DoOnLineasImportadas );

         tmPresupuesto,
         tmPedidoventa,
         tmVenta :
		         SeleccionaLineasDocumentoVenta( DataTipoMovimiento.Value, DataEjercicio.Value, DataNroOperacion.Value, TipoMovimientoEdicion, DoOnLineasImportadas );

         tmCapturador :
           ImportaDatosCapturador( FicheroDatosBox.Caption );

         {
         tmBascula :
           ImportaDatosBascula;
         }

         end;
         
       end;
end;

procedure TMntMveForm.DoOnLineasImportadas( MovimientoOrigenFields : TMovimientoFields;
                                            CopiarDatosCabecera,
                                            NoVincularDocumentos   : Boolean;
                                            LineArray              : TLongIntArray );
var  I : SmallInt;

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

     ActualizaContenidoRejillas;

     FormManager.ValidateDataArea( faData );
     ActualizaEntregasACuentaPedidos;
     GridView.DataController.GotoLast;
     Grid.SetFocus;
end;

procedure TMntMveForm.ActualizaContenidoRejillas;
begin
     PageGridView.DataController.UpdateItems( False );
     GridView.DataController.UpdateItems( False );
end;

procedure TMntMveForm.ImportaDatosCapturador( DataPath : String );
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
procedure TMntMveForm.ImportaDatosBascula;
begin
     try
       Movimiento.ImportaDatosBascula( MovimientoFields, LineaMovimientoFields, DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value, ClienteFields.Factura_Tarifa.Value );
     finally
       MovimientoTable.Refresh;
       end;
end;
}

procedure TMntMveForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
end;

procedure TMntMveForm.EnviadoCtrlPropertiesValuePosted(Sender: TObject);
begin
     // Estado del albarán

     If   not MovimientoTable.Editing
     then DataEnviado.Value := not DataEnviado.Value   // Si no se puede editar tampoco cambia el estado
     else If   DataEnviado.Value
          then MovimientoFields.Situacion.Value := epaEnviado
          else MovimientoFields.Situacion.Value := epaPendiente;

end;

procedure TMntMveForm.ExportarButtonClick(Sender: TObject);

var  TiposMovimientoDestino : TTiposMovimiento;
     CodigoSerie,
     CodigoPropietario : String;

begin

     CodigoSerie := MovimientoFields.Serie.Value;
     CodigoPropietario := MovimientoFields.Propietario.Value;

     FormManager.CheckDetailRecords;

     case TipoMovimientoEdicion of
       tmPresupuesto : TiposMovimientoDestino := [ tmPedidoVenta, tmVenta ];
       tmPedidoVenta : TiposMovimientoDestino := [ tmPedidoCompra, tmVenta ];
       tmVenta       : begin
                       TiposMovimientoDestino := [ tmPedidoCompra ];
                       CodigoSerie := '';
                       CodigoPropietario := '';
                       end;
     end;

     ExportaDocumentoVenta( CodigoSerie,
                            CodigoPropietario,
                            TiposMovimientoDestino,
                            TipoMovimientoEdicion,
                            MovimientoFields,
                            DoOnExportaDocumento );
end;

procedure TMntMveForm.DoOnExportaDocumento;

var  OnFilterRecord : TFilterLineRecordEvent;

begin

     TipoMovimientoDestino :=  BoxEdvForm.DataTipoMovimiento.Value;
     CodigoPropietarioDestino :=  BoxEdvForm.DataPropietario.Value;
     SerieDestino := BoxEdvForm.DataSerie.Value;
     NroDocumentoDestino := BoxEdvForm.DataNroDocumento.Value;
     SoloCantidadesPendientes :=  BoxEdvForm.DataSoloCantidadesPendientes.Value;
     DocumentoAutomatico := BoxEdvForm.DataDocumentoAutomatico.Value;
     TodasLasLineas := BoxEdvForm.DataTodasLasLineas.Value;

     If   Movimiento.ModuloHojasDePedido and ( TipoMovimientoEdicion=tmPedidoVenta )
     then OnFilterRecord := DoFilterRecord
     else OnFilterRecord := nil;

     If   TodasLasLineas
     then DoOnLineasExportadas( MovimientoFields )
     else SeleccionaLineasDocumentoVenta( TipoMovimientoEdicion,
                                          MovimientoFields.Ejercicio.Value,
                                          MovimientoFields.NroOperacion.Value,
                                          TipoMovimientoDestino,
                                          DoOnLineasExportadas,
                                          OnFilterRecord );
end;

procedure TMntMveForm.DoFilterRecord(     LineaMovimientoFields : TLineaMovimientoFields;
                                      var Accept                : Boolean );
begin
    If   TipoMovimientoDestino=tmPedidoCompra
    then FOnFiltroSeleccionDocumentos.Invoke( LineaMovimientoFields, Accept  );
end;

procedure TMntMveForm.DoOnLineasExportadas( MovimientoOrigenFields : TMovimientoFields;
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
                                                       DocumentoAutomatico,
                                                       CopiarDatosCabecera );
     If   Assigned( MovimientoDestino )
     then With MovimientoDestino do
            If   VarToInteger( TipoMovimiento ) in [ tmPresupuesto, tmPedidoventa, tmVenta ]
            then MntMovimientosVenta( [ TipoMovimiento, Ejercicio, Serie, NroDocumento] )
            else MntMovimientosCompra( [ TipoMovimiento, Ejercicio, Propietario, Serie, NroDocumento ] );

     If   TipoMovimientoEdicion=tmPedidoVenta
     then GridView.DataController.UpdateItems( False );

end;


procedure TMntMveForm.CentroCosteCtrlPropertiesEditRequest( Sender: TcxCustomEdit );
begin
     MntCentrosCoste( [ Sender.EditValue ] );
end;

procedure TMntMveForm.CentroCosteCtrlPropertiesQueryRequest( Sender: TcxCustomEdit );
begin
     ConsultaCentrosCoste( Sender );
end;

procedure TMntMveForm.CentroCosteCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     CentroCoste.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure  TMntMveForm.DoInsertaLineasConsumo( LineList : TList<Integer> );
begin
     Movimiento.InsertaLineasConsumo( MovimientoFields, LineaMovimientoFields, ClienteFields, SerieFacturacionFields, LineList );
     GridView.DataController.UpdateItems( False );
     Grid.SetFocus;
end;

procedure TMntMveForm.FormManagerReportFormRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( True, TipoMovimientoEdicion, Ejercicio.Value, '', Serie.Value, NroDocumento.Value );
end;

procedure TMntMveForm.FormManagerNoteRequest;
begin
     If   GridView.IsControlFocused
     then MntAnotacion( LineaMovimientoFields.Anotacion, RsAnotacionLinea )
     else If   PageGridView.IsControlFocused
          then MntAnotacion( GrupoLineaMovimientoFields.Anotacion, RsAnotacionGrupo )
          else MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
     FormManagerUpdateButtonsState;
end;

procedure TMntMveForm.FormManagerPreparedForm;
begin

     With DataModule00 do
       begin

       If   Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarStock, DmEmpresaFields.Ventas_VerStock )
       then If   not Assigned( StockFrame )
            then StockFrame := CreaPanelStock( scVentas, TopPanel, GridView );

       If   ( ( TipoMovimientoEdicion=tmPedidoVenta ) and Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRiesgoPedidos, DmEmpresaFields.Ventas_RiesgoPedido ) ) or
            ( ( TipoMovimientoEdicion=tmVenta ) and Usuario.OpcionUsuario( DmUsuarioFields.Ventas_MostrarRiesgoAlbaranes, DmEmpresaFields.Ventas_RiesgoAlbaran ) )
       then If   not Assigned( RiesgoFrame )
            then RiesgoFrame := CreaRiesgoFrame( TopPanel );

       If   FCamposOpcionalesVisibles>0
       then TopScrollBox.VertScrollBar.Range := FCamposOpcionalesVisibles * FechaAplicacionPanel.Height;

       If   FCamposLibresVisibles>0
       then CamposLibresScrollBox.VertScrollBar.Range := FCamposLibresVisibles * CLScrollBoxPanel1.Height;

       end;

end;

procedure TMntMveForm.FormManagerQueryGridRequest;
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( TipoMovimientoEdicion, sdTodos, Serie, NroDocumentoCtrl, qgsDetached );
end;

procedure TMntMveForm.FormManagerReportRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( False, TipoMovimientoEdicion, Ejercicio.Value, '', Serie.Value, NroDocumento.Value );
end;

procedure TMntMveForm.FormManagerSetupToolBar(Enable: Boolean);
begin
     If   Enable
     then With ApplicationContainer do
            NoteButton.Enabled := NoteButton.Enabled or FormManager.DataAreaFocused;
end;

procedure TMntMveForm.FormManagerShowCantEditMessage;
begin
     Movimiento.MuestraMotivoBloqueo( MovimientoFields );
end;

procedure TMntMveForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TMntMveForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( MovimientoFields )
     then begin

          If   not MovimientoTable.UpdatingProcess
          then begin
               AnotacionButton.Visible := MovimientoFields.Anotacion.Value<>'';
               AnotacionButton.Enabled := MovimientoTable.Editing;
               end;

          ConsumosPreciosButton.Enabled := MovimientoTable.Editing;
          ImportarButton.Enabled := MovimientoTable.Editing and not MovimientoFields.Anulado.Value;

          If   ( TipoMovimientoEdicion=tmPedidoVenta ) and Movimiento.ModuloHojasDePedido
          then begin
               DocumentosButton.Enabled := MovimientoTable.Editing and ( FDirectorioDocumentos<>'' );
               CarpetaDocumentosButton.Enabled := MovimientoTable.Editing;
               If   FDirectorioDocumentos=''
               then DocumentosButton.Hint := RsMsg50
               else DocumentosButton.Hint := FDirectorioDocumentos;
               end;

          // No compruebo que haya alguna línea. Si se intenta facturar ya se avisará de que el documento está vacío.

          var Facturable := ( TipoMovimientoEdicion=tmVenta ) and ( MovimientoTable.State=dsEdit ) and not MovimientoFields.NoFacturar.Value and not MovimientoFields.Anulado.Value;

          ExportarButton.Enabled := FormManager.DataAreaFocused and ( MovimientoTable.State in [ dsBrowse, dsEdit ] ) and not MovimientoFields.Anulado.Value;
          FacturarButton.Enabled := Facturable;
          FacturaDirectaButton.Enabled := Facturable;

          FirmarButton.Enabled := FirmarButton.Visible and FTabletFirmaConectado and ( MovimientoTable.State=dsEdit );
          HojaCargaButton.Enabled := HojaCargaButton.Visible and ExportarButton.Enabled and ( MovimientoFields.Situacion.Value<>epProcesado );
          LanzarButton.Enabled := LanzarButton.Visible and HojaCargaButton.Enabled and ( MovimientoFields.Situacion.Value<>epProcesado );

          FOnUpdateButtonsState.Invoke;

          end;
end;

procedure TMntMveForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
end;

procedure TMntMveForm.MostrarAviso;
begin
     If   ( ClienteFields.Codigo.Value<>'' ) and ( ClienteFields.Aviso.Value<>'' )
     then ShowWarning( ClienteFields.Aviso );
end;

procedure TMntMveForm.AvisoButtonClick(Sender: TObject);
begin
     MostrarAviso;
end;

function TMntMveForm.GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
begin
     If   not Assigned( FGrupoLineaMovimientoFields )
     then FGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     Result := FGrupoLineaMovimientoFields;
end;

function TMntMveForm.GetLineaMovimientoFields : TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoFields )
     then FLineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     Result := FLineaMovimientoFields;
end;

procedure TMntMveForm.LineaMovimientoTableAfterOpen(DataSet: TDataSet);
begin
     With LineaMovimientoFields do
       begin
       SetFieldRange( NroPagina, 0 );
       SetFieldRange( NroLinea );
       end;
end;

procedure TMntMveForm.LineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FLineaMovimientoFields );
end;

procedure TMntMveForm.LineaMovimientoTableAfterDelete(DataSet: TDataSet);
begin
     If   ( MovimientoFields.TipoMovimiento.Value=tmVenta ) and ( LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoVenta )
     then begin
          If   not MovimientoTable.DeletingMasterRecord and
               not BorrandoGrupo
          then ActualizaMovimientosVenta( LineaMovimientoFields.TipoMovimientoOrigen.Value );
          end;
end;

procedure TMntMveForm.LineaMovimientoTableAfterEdit(DataSet: TDataSet);
begin
    If   GridView.Controller.IsEditing
    then begin
         ExisteEnvase := Movimiento.ObtenEnvaseLinea( LineaMovimientoFields, EnvaseFields );
         ObtenExistencias;
         LoteAsignado := False;
         end;
end;

procedure TMntMveForm.LineaMovimientoTableBeforeDelete(DataSet: TDataSet);
begin
     If   ( LineaMovimientoFields.TipoMovimientoOrigen.Value=tmPresupuesto ) and not AvisoEstadoPresupuesto
          then begin
               AvisoEstadoPresupuesto := True;
               ShowNotification( ntWarning, RsMsg30, RsMsg31 );
               end;
end;

procedure TMntMveForm.LineaMovimientoTableBeforeEdit(DataSet: TDataSet);
begin
     ExisteEnvase := False;
end;

procedure TMntMveForm.LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
begin
     // Si el cursor está situado sobre una columna no editable (ReadOnly) al iniciarse la edición el estado persiste

     If   GridView.Controller.EditingController.InsertingRecord
     then begin
          SetColumnsEditingOption( GridView, True );
          ExisteEnvase := False;
          EnvaseFields.Clear;
          end;
end;

procedure TMntMveForm.ActualizaCantidad;
begin
     With LineaMovimientoFields do
       If   TipoMovimientoEdicion=tmVenta
       then Cantidad.Value := -LineaMovimientoTableCantidadAjustada.Value
       else Cantidad.Value := LineaMovimientoTableCantidadAjustada.Value;
end;

procedure TMntMveForm.LineaMovimientoTableBeforePost(DataSet: TDataSet);

var  LoteFabricacion,
     CodigoAlmacen,
     CodigoUbicacion : String;

begin
     // Aún quedan procesos que utilizan la tabla LineaMovimientoTable para realizar inserciones, como Movimiento.InsertaLineasConsumo

     If   not LineaMovimientoTable.ControlsDisabled
     then begin

          ActualizaCantidad;
          ActualizaCamposCalculadosLinea;

          If   not LoteAsignado
          then If   DataModule00.DmEmpresaFields.Stock_LotesProductos.Value and
                    DataModule00.DmEmpresaFields.Ventas_LotesObligatorios.Value and
                    ( TipoMovimientoEdicion in [ tmPedidoVenta, tmVenta ] )
               then begin

                    // Si el usuario no tiene acceso a la sección de procesos de ventas, se considera que no puede asignar manualmente los lotes.
                    // En ese caso los lotes son siempre asignados automáticamente, para evitar errores de introducción.
                    // Este funcionamiento es muy particular y ha sido realizado a sugerencia de Sempreflora (craso error)

                    If   LineaMovimientoFields.LoteFabricacion.Value='' 
                    then begin
                         Movimiento.ObtenPrimerLoteConExistencias( LineaMovimientoFields.CodigoArticulo.Value, LoteFabricacion, CodigoAlmacen, CodigoUbicacion );
                         LineaMovimientoFields.LoteFabricacion.Value := LoteFabricacion;
                         end;
                    end
               else If   TipoMovimientoEdicion=tmVenta
                    then Movimiento.AsignaOrigenPorLoteySerie( LineaMovimientoFields );

          DesglosarLinea := ListaMateriales.RequiereDesglose( MovimientoFields, LineaMovimientoFields, ArticuloFields );

          end;

end;

procedure TMntMveForm.LineaMovimientoTableAfterPost(DataSet: TDataSet);
begin
     If   DesglosarLinea
     then begin
          DesglosarLinea := False;
          ListaMateriales.AplicarDesglose( MovimientoFields, LineaMovimientoFields );
          GridView.DataController.UpdateItems( False );
          GridView.Controller.FocusFirstAvailableItem;
          end;
end;

procedure TMntMveForm.LineaMovimientoTableCalcFields(DataSet: TDataSet);
begin
     LineaMovimientoTableTieneRegistroOrigen.Value := not ValueIsEmpty( LineaMovimientoTableNroRegistroOrigen.Value );
     If   GridViewTieneDocumentosAsociados.Visible // Movimiento.ModuloHojasDePedido
     then LineaMovimientoTableTieneDocumentosAsociados.Value := RelacionDocumentos.TieneDocumentos( LineaMovimientoTableNroRegistro.Value );
     FOnCalcFieldsLineaMovimiento.Invoke;
end;

procedure TMntMveForm.LineaMovimientoTableNewRecord(DataSet: TDataSet);
begin
     With LineaMovimientoFields do
       begin

       Ejercicio.Value := MovimientoFields.Ejercicio.Value;
       NroOperacion.Value := MovimientoFields.NroOperacion.Value;
       Fecha.Value := MovimientoFields.Fecha.Value;

       If   DataModule00.DmEmpresaFields.Ventas_FechaEntregaPorLinea.Value
       then FechaAplicacion.Value := ApplicationContainer.TodayDate
       else FechaAplicacion.Value := MovimientoFields.FechaAplicacion.Value;

       NroPagina.Value := GrupoLineaMovimientoFields.NroPagina.Value;

       UIDArticulo.AsGUID := Articulo.Identificador;

       end;
end;

procedure TMntMveForm.LineaMovimientoTableRecordChanged(DataSet: TDataSet);
begin
     If   LineaMovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atArticulo ] );
end;

procedure TMntMveForm.LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeLineaMovimiento( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntMveForm.LineaMovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaLineaMovimiento( MovimientoFields, LineaMovimientoFields, TipoMovimientoEdicion=tmVenta );
end;

procedure TMntMveForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Serie;NroDocumento
       KeyValues[ 0 ] := TipoMovimientoEdicion;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned;
       end;
end;

procedure TMntMveForm.FacturaDirectaButtonClick(Sender: TObject);

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

procedure TMntMveForm.FacturarButtonClick(Sender: TObject);

var  ParametrosFacturacion : IParametrosFacturacion;

begin

     // OkButton.SetFocus;

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

procedure TMntMveForm.FacturaVentaItemClick(Sender: TObject);
begin
     With MovimientoFields do
       If   FacturaVentas.Obten( EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value )
       then MntFacturasVenta( [ EjercicioFactura.Value, SerieFactura.Value, NroFactura.Value ] )
       else ShowNotification( ntStop, RsMsg10, RsMsg11 );
end;

procedure TMntMveForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, False );
end;

procedure TMntMveForm.FechaAplicacionCtrlPropertiesValidate( Sender : TcxCustomEdit; var DisplayValue : Variant; var ErrorText : TCaption; var Error : Boolean );
begin
     If   ValidateYear( DisplayValue, ErrorText, Error, False, True )
     then ValidateDateRange( drGreaterOrEqual, MovimientoFields.Fecha.Value, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.FichaMovimientosArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntMveForm.FirmarButtonClick(Sender: TObject);
begin
     FormManager.CheckDetailRecords;
     FOnCapturaFirma.Invoke( FormManager,
                             MovimientoFields.Firma,
                             ClienteFields.Nombre.Value,
                             Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, False, True ) +  ' nº ' + IntToStr( MovimientoFields.NroDocumento.Value ) + ' de fecha ' + StrFormatDate( MovimientoFields.Fecha.Value ) );
end;

procedure TMntMveForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntMveForm.FormaCobroCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasCobro( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.FormaCobroCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasCobro( Sender );
end;

procedure TMntMveForm.FormaCobroCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaCobro.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.FormaEnvioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasEnvio( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.FormaEnvioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasEnvio( Sender );
end;

procedure TMntMveForm.FormaEnvioCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     FormaEnvio.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.FormaEnvioCtrlPropertiesValuePosted(Sender: TObject);

var  ImportePortes : Decimal;

begin
     ImportePortes := 0.0;
     If   not ValueIsEmpty( MovimientoFields.FormaEnvio.Value ) and
          ( FormaEnvio.FormaEnvioFields.Portes.Value=Ord( TipoPortes.feDebidos ) )
     then ImportePortes := FormaEnvio.FormaEnvioFields.Importe.Value;
     PortesCtrl.PostEditValue( ImportePortes );
end;

function TMntMveForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := False;
     With MovimientoFields do
       begin
       LineaMovimientoAuxTable.IndexFieldNames := 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen';
       Result := LineaMovimientoAuxTable.FindKey( [ TipoMovimientoEdicion, Ejercicio.Value, NroOperacion.Value ] );
       SetBarItemsVisible( [ LineasDocumentoItem ], Result );  // Otros módulos pueden activar el menú, y la opción no debe aparecer
       If   TipoMovimientoEdicion=tmVenta 
       then Result := Result or MovimientoFields.Facturado.Value or ( MovimientoFields.NroOperacionOrigen.Value<>0 );
       end;
end;

procedure TMntMveForm.FormManagerAutoEditChanged( var Value : Boolean );
begin
     LineaMovimientoDataSource.AutoEdit := True;

     // El cambio de Value solo afecta a las rejillas, los DataSources se actualizan antes de la llamada al evento

     Value := Value or ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( MovimientoFields.Situacion.Value=epParcialmenteProcesado ) );

     GridViewAutoEditChanged;
end;

function TMntMveForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaDocumentoVentas( TipoMovimientoEdicion, MovimientoFields.Serie.Value, DoOnCopyCurrentRecord );
     Result := False;
end;

procedure TMntMveForm.FormManagerCreateForm;
begin
     FSumasPagina := TList<TSumasPagina>.Create;
     FSumasPagina.OnNotify := DoOnSumasPaginaNotify;
     // Desactivo las tablas de líneas hasta que se lea el primer registro válido
     GrupoLineaMovimientoTable.DisableControls;
     LineaMovimientoTable.DisableControls;
end;

procedure TMntMveForm.FormManagerDeleteEmptyHeader(DataSet: TDataSet);
begin
     // Como se inserta automáticamente una página vacía al crear la cabecera, hay que borrarla explícitamente
     // No se borra únicamente la página 0 porque se pueden insertar páginas vacías sin que existan, a su vez, líneas en ellas.

     With GrupoLineaMovimientoTable do
       begin
       Cancel;
       DeleteRecords;
       end;
end;

procedure TMntMveForm.FormManagerDestroyForm;
begin
     FSumasPagina.Free;
     FOnDesconectaTabletFirma.Invoke;
end;

procedure TMntMveForm.FormManagerFocusedAreaChanged;
begin
     ActualizaEstado;
end;

procedure TMntMveForm.DoOnCopyCurrentRecord;

var  NroOperacionDestino : LongInt;

begin
     With BoxCdvForm do
       begin
       NroOperacionDestino := Movimiento.CopiaMovimiento( MovimientoFields.Ejercicio.Value,
                                                          MovimientoFields.NroOperacion.Value,
                                                          TipoMovimientoEdicion,
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

            If   LockRangeButton.Down and
                 Movimiento.SeriesEnDocumentosVenta( TipoMovimientoEdicion ) and
                 ( DataSerie.Value<>MovimientoFields.Serie.Value )
            then LockRangeButton.Unlock;

            If   Movimiento.ObtenMovimiento( ApplicationContainer.Ejercicio, NroOperacionDestino )
            then begin
                 MovimientoTable.GotoCurrent( Movimiento.DmMovimientoTable );
                 ActualizaReferencias;
                 Self.FormManager.SelectFirstKeyControl;
                 end;

            end;
       end;
end;

procedure TMntMveForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesVentas, BoolToStr( MostrarAnotacionesItem.Down, True ) );
end;

procedure TMntMveForm.MovimientoTableAfterEdit(DataSet: TDataSet);
begin
     If   MovimientoFields.IVAIncluido.Value<>PreciosConIVAIncluido
     then MovimientoFields.IVAIncluido.Value := PreciosConIVAIncluido;
end;

procedure TMntMveForm.MovimientoTableBeforeDelete(DataSet: TDataSet);
begin
     FBeforeDeleteMovimiento.Invoke( MovimientoFields );
end;

procedure TMntMveForm.MovimientoTableNewRecord(DataSet: TDataSet);
begin

     If   DataModule00.DmEmpresaFields.Ventas_CompCorrDoc.Value
     then If   MovimientoFields.NroDocumento.Value>Movimiento.ProximoDocumento( MovimientoFields, False )
          then begin
               // Estamos en medio de un cambio de estado (los eventos de edición están bloqueados) y el contenido de los controles todavía no se ha actualizado
               // Si no se limpia se acaban mostrando los del último registro leído
               FormManager.ClearEditPanel( DataPanel );
               If   ShowNotification( ntQuestionWarning, Format( RsMsg18, [ Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, False ) ] ), RsMsg19 )<>mrYes
               then Abort;
               end;

     With MovimientoFields do
       begin
       NroOperacion.Value := Movimiento.ProximaOperacion;
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaAplicacion.Value := ApplicationContainer.TodayDate;  // Fecha de entrega
       Revisado.Value := False;
       IVAIncluido.Value := PreciosConIVAIncluido;
       CentroCoste.Value := SerieFacturacionFields.CentroCoste.Value;
       end;

     // Movimiento.CompruebaNroDocumento( FormManager, MovimientoFields );

     DataServido.Value := False;
     DataEnviado.Value := False;

     FCodigoPaisIVA := CodigoEspaña;

     FSumasPagina.Clear;

     ClienteFields.Clear;
end;

procedure TMntMveForm.ActualizaEstadoPedido;
begin
      With MovimientoFields do
        If   TipoMovimiento.Value=tmPedidoVenta
        then If   DataServido.Value
             then Situacion.Value := epProcesado
             else If   CantidadProcesadaTotal=0.0
                  then Situacion.Value := epPendiente
                  else If   CantidadTotal>CantidadProcesadaTotal
                       then Situacion.Value := epParcialmenteProcesado
                       else Situacion.Value := epProcesado;
end;

procedure TMntMveForm.ActualizarRelacionesItemClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg44, RsMsg45 )=mrYes
     then begin
          Movimiento.RecalculaMovimiento( MovimientoFields );
          MovimientoTable.Refresh;
          end;
end;

procedure TMntMveForm.MovimientoTableBeforePost(DataSet: TDataSet);
begin
     ActualizaEstadoPedido;

     FBeforePostMovimiento.Invoke( MovimientoFields );
end;

procedure TMntMveForm.MovimientoTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
     If   Assigned( FSumasPagina )
     then FSumasPagina.Clear;
end;

function TMntMveForm.MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin

     // En teoría, cuando un pedido ha sido incluido en una factura es porque se han contabilizado las entregas a cuenta anotadas en él.
     // En ese caso no debería permitir que sea modificado, aunque solo se haya entregado parcialmente.
     // Sin embargo los usuarios quieren poder añadir líneas. O sea que ...

     If   Assigned( MovimientoFields )
     then Result := EjercicioActual( MovimientoFields.Fecha.Value ) and
                    not MovimientoFields.Anulado.Value and
                    not ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( MovimientoFields.Situacion.Value=epProcesado ) ) and
                    // ( ( MovimientoFields.Situacion.Value=epProcesado ) or MovimientoFields.Facturado.Value ) ) and
                    not ( ( TipoMovimientoEdicion=tmVenta ) and MovimientoFields.Facturado.Value ) and
                    not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value
     else Result := True;

end;

function TMntMveForm.MovimientoTableCheckDetailDatasets(Dataset: TDataSet; Posting : Boolean): Boolean;
begin
     Result := Movimiento.ExistenLineas( MovimientoFields );
end;

function TMntMveForm.MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Movimiento.ProximoDocumento( MovimientoFields );
end;

procedure TMntMveForm.MovimientoTableGetRecord(DataSet: TDataSet);

var  NroPagina : SmallInt;
     Bm : TBookMark;

procedure AcumulaLinea;
begin
     With SumasPagina[ NroPagina ] do
       begin
       DecAdd( Cantidad, LineaMovimientoFields.CantidadAjustada.Value );
       If   LineaMovimientoFields.Procesada.Value
       then DecAdd( CantidadProcesada, LineaMovimientoFields.Cantidad.Value )
       else DecAdd( CantidadProcesada, LineaMovimientoFields.CantidadProcesada.Value );
       DecAdd( Alto, LineaMovimientoFields.Alto.Value );
       DecAdd( Peso, LineaMovimientoFields.Peso.Value );
       Movimiento.AcumulaValoresImpositivosLinea( LineaMovimientoFields, FCodigoPaisIVA, TasasArray, False );
       end;
end;

begin

     // Cuando existe una serie por defecto y no hay ningún movimiento de esa serie, hay que fijarla de nuevo

     If   MovimientoFields.Serie.IsNull
     then begin
          MovimientoTable.SetKey;
          FijaSeriePorDefecto;
          end;

     // Cuando no existen páginas no es necesario acumular todas las líneas porque el sumatorio del grid ya hace el trabajo

     If   DataModule00.PartidasPresupuestarias and
          GrupoLineaDataSource.Enabled
     then With GrupoLineaMovimientoTable do
            try

               ActualizaReferencias;

               If   not ControlsDisabled
               then begin
                    DisableControls;
                    LineaMovimientoTable.DisableControls;
                    end;

               GrupoLineaMovimientoTable.Open;
               LineaMovimientoTable.Open;             // Las necesito abiertas ya mismo

               Bm := GetBookMark;

               First;
               While not Eof do
                 begin

                 NroPagina := GrupoLineaMovimientoFields.NroPagina.Value;
                 SumasPagina[ NroPagina].LimpiaPagina( True );

                 With LineaMovimientoTable do
                   begin

                   With GrupoLineaMovimientoFields do
                     SetRange( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] );

                   While not Eof do
                     begin
                     AcumulaLinea;
                     Next;
                     end;

                   end;

                 SumasPagina[ NroPagina].AcumulaValoresImpositivos( MovimientoFields.Fecha.Value,
                                                                    ClienteFields.Factura_ModeloIVA.Value,
                                                                    CalcularIVA );

                 Next;
                 end;

               MuestraTotales;

            finally
              GotoBookMark( Bm );
              end;

     GrupoLineaMovimientoTable.EnableControls;
     LineaMovimientoTable.EnableControls;

     ActualizaEntregasACuentaPedidos;

     If   ( TipoMovimientoEdicion=tmPedidoVenta ) and Movimiento.ModuloHojasDePedido
     then FDirectorioDocumentos := Registro.ObtenValorString( ObtenClaveDocumentos );

end;

function TMntMveForm.ObtenClaveDocumentos : String;
begin
     Result := ncrDocumentosPedido + '.' + IntToStr( MovimientoFields.Ejercicio.Value ) + '.' + IntToStr( MovimientoFields.NroOperacion.Value );
end;

procedure TMntMveForm.MovimientoTableOpenRecord(DataSet: TDataSet);
begin
     ImporteNetoAnterior := ImporteNetoTotal;
     EntregasACuenta := 0.0;
     AvisoEstadoPresupuesto := False;
end;

procedure TMntMveForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );
     Movimiento.OrigenDocumento( MovimientoFields, OrigenLabel );

     FirmadoLabel.Visible := MovimientoFields.Firma.BlobSize>0;
     AnuladoLabel.Visible := MovimientoFields.Anulado.Value;

     Data.Edit;

     DataServido.Value := MovimientoFields.Situacion.Value=epProcesado;
     DataEnviado.Value := MovimientoFields.Situacion.Value=epaEnviado;

     ServidoAnterior := DataServido.Value;
     
     If   MovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atCliente ] );
end;

procedure TMntMveForm.MovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeMovimiento( MovimientoFields );
end;

procedure TMntMveForm.MovimientoTableRemotePost( DataSet : TDataSet );
begin
     Movimiento.ActualizaMovimiento( MovimientoFields );
end;

procedure TMntMveForm.FijaSeriePorDefecto;
begin
     SerieFacturacion.FijaSeriePorDefecto( MovimientoFields.Serie );
     If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
     then LockRangeButton.Enabled := False;
end;

procedure TMntMveForm.MovimientoTableSetKey(DataSet: TDataSet);
begin
     MovimientoFields.TipoMovimiento.Value := TipoMovimientoEdicion;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   not Movimiento.SeriesEnDocumentosVenta( TipoMovimientoEdicion )
     then MovimientoFields.Serie.Value := ''
     else If   LockRangeButton.SettingDefaultRange
          then FijaSeriePorDefecto;

     With Data do
       begin
       Open;
       Edit;
       ClearFields;
       end;
end;

procedure TMntMveForm.ActualizaEstado;
begin
     FormManagerUpdateButtonsState;
     FOnActualizaEstado.Invoke;
end;

procedure TMntMveForm.ActualizaEstadoLineas;
begin
     If   ShowFocusedRowHighlited
     then begin
          ShowFocusedRowHighlited := False;
          TableViewManager.Update;
          end;
end;

procedure TMntMveForm.MovimientoTableUpdateState(DataSet: TDataSet);

var  EnableDatasets : Boolean;

begin
     If   FormManager.FormInitialized and
          not MovimientoTable.ControlsDisabled
     then begin
          EnableDatasets := MovimientoTable.State<>dsSetKey;
          GrupoLineaDataSource.Enabled := EnableDatasets;
          LineaMovimientoDataSource.Enabled := EnableDatasets;
          { If   EnableDatasets
          then } ActualizaEstado;
          Movimiento.RetiraDocumento( MovimientoFields );
          end;
     ActualizaVisibilidadAviso( AvisoButton.Visible );
end;

procedure TMntMveForm.ActualizaVisibilidadAviso( Visible : Boolean );
begin
     If   not MovimientoTable.UpdatingProcess
     then AvisoButton.Visible := Visible and ( MovimientoTable.State in [ dsBrowse, dsEdit ] );
end;

procedure TMntMveForm.PageGridViewDescripcionPropertiesEnter( Sender: TcxCustomEdit);
begin
     With PageGridViewDescripcion do
       If   ValueIsEmpty( GrupoLineaMovimientoTableCodigoGrupo.Value ) and
            ValueIsEmpty( EditValue )
       then EditValue := Format( CaptionNroPagina + ' ', [ PageGridView.DataController.RowCount ] );
end;

procedure TMntMveForm.PageGridViewGrupoDocumentoPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntGruposDocumento( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.PageGridViewGrupoDocumentoPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaGruposDocumento( Sender );
end;

procedure TMntMveForm.PageGridViewGrupoDocumentoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var I : SmallInt;

begin
     GrupoDocumento.Valida( Sender, DisplayValue, ErrorText, Error );
     If   not Error and not ValueIsEmpty( DisplayValue )
     then begin
          I := PageGridView.DataController.FindRecordIndexByText( 0, PageGridViewGrupoDocumento.Index, DisplayValue, False, False, True );
          If   ( I>=0 ) and ( I<>PageGridView.DataController.FocusedRowIndex )
          then begin
               Error := True;
               ErrorText := RsMsg3;
               end;
          end;
end;

procedure TMntMveForm.PageGridViewGrupoDocumentoPropertiesValuePosted( Sender: TObject);
begin
      With PageGridViewGrupoDocumento do
       If   Editing
       then GrupoLineaMovimientoFields.Descripcion.Value := GrupoDocumento.GrupoDocumentoFields.Descripcion.Value;
end;

procedure TMntMveForm.PageGridViewManagerDelete(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg32, RsMsg33 )=mrYes
     then With GrupoLineaMovimientoTable do
            begin
              try

                 // De momento no puedo protegerlo con una transacción porque el borrado de líneas se realiza en el servidor
                 // y, al ser una sesión distinta, se produce un error de bloqueo
                 
                // Database.StartTransaction;
                PageGridView.DataController.DeleteFocused;  // El evento BeforeDelete de la tabla se encarga de suprimir las líneas
                // Database.Commit;
              except
                // Database.RollBack;
                raise;
                end;
            PageGridView.Controller.GoToLast( True );
            end;
     Abort;
end;

function TMntMveForm.PageGridViewManagerRowInsert: Boolean;
begin
     Movimiento.InsertaPaginaDocumento( GrupoLineaMovimientoFields );
end;

procedure TMntMveForm.PageGridViewManagerRowShift(ShiftOperation: TShiftOperation);
begin
     Movimiento.DesplazaPaginaDocumento( GrupoLineaMovimientoFields, ShiftOperation );
end;

procedure TMntMveForm.GrupoLineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FGrupoLineaMovimientoFields );
end;

procedure TMntMveForm.GrupoLineaMovimientoTableAfterPost(DataSet: TDataSet);
begin

     // Por increible que parezca no consigo reiniciar la rejilla con ningún otro método : LineaMovimientoTable.Refresh, LineaMovimientoTable.MasterChanged, GridView.DataController.RefreshExternalData, GridView.DataController.Refresh, etc..
     
     With LineaMovimientoDataSource do
       begin
       Enabled := False;
       Enabled := True;
       end;
       
end;

procedure TMntMveForm.GrupoLineaMovimientoTableBeforeDelete(DataSet: TDataSet);
begin

     // DeleteMasterRecord solo borra los registros del primer DetailDataset (en este caso las páginas)
     // Si existen DetailDatasets de nivel inferior se tienen que suprimir a mano

     LineaMovimientoTable.DeleteRecords;
end;

procedure TMntMveForm.GrupoLineaMovimientoTableNewRecord(DataSet: TDataSet);
begin
     With GrupoLineaMovimientoFields do
       begin
       Ejercicio.Value := MovimientoFields.Ejercicio.Value;
       NroOperacion.Value := MovimientoFields.NroOperacion.Value;
       end;
end;

procedure TMntMveForm.PopupMenuPopup(Sender: TObject);

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

       SetBarItemsVisible( [ VincularPedidoItem, SuprimirVinculosItem ], TieneLineas and ( TipoMovimientoEdicion=tmVenta ) and not DataModule00.DmEmpresaFields.Ventas_DocumentosPaginados.Value );

       SetBarItemsVisible( [ DarPorServidaItem ], ( TipoMovimientoEdicion=tmPedidoVenta ) and not DataServido.Value );
       SetBarItemsVisible( [ ActualizarRelacionesItem ], TieneLineas and ( MovimientoTable.State=dsEdit ) );
       SetBarItemsVisible( [ NoPedirAlProveedorItem ], Movimiento.ModuloHojasDePedido );

       CopiarAnotacionItem.Enabled := LineaSeleccionada;

       DarPorServidaItem.Down := Procesada.Value;
       DarPorServidaItem.Enabled := LineaSeleccionada and ( ( CantidadAjustada.Value>CantidadProcesada.Value ) or ( Procesada.Value and not DataModule00.DmEmpresaFields.Ventas_RegularizarPedidosServidos.Value ) );

       NoPedirAlProveedorItem.Down := IsBitSet( Parametros.Value, 1 );
       NoPedirAlProveedorItem.Enabled := LineaSeleccionada and not IsBitSet( LineaMovimientoFields.Parametros.Value, 0 ); // Si ya ha sido exportada no permito que se marque

       MostrarAnotacionesItem.Down:= GridView.Preview.Visible;

       SetBarItemsVisible( [ DocumentosOrigenItem ], LineaSeleccionada and ( TipoMovimientoEdicion=tmPedidoVenta ) and ( LineaMovimientoFields.CantidadProcesada.Value>0 ) );
       end;
end;

procedure TMntMveForm.PortesCtrlPropertiesValuePosted(Sender: TObject);
begin
     GridView.DataController.Summary.Recalculate;
end;

procedure TMntMveForm.RegistroAuxiliarCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAuxiliarClientes( [ MovimientoFields.Propietario.Value, Sender.EditingValue ] );
end;

procedure TMntMveForm.RegistroAuxiliarCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     ConsultaAuxiliarClientes( Sender, ClienteCtrl.EditValue, DoOnRegistroAuxiliarSelected );
end;

procedure TMntMveForm.DoOnRegistroAuxiliarSelected( Target : TcxCustomEdit = nil );
begin
     If   ( MovimientoFields.Propietario.Value='00000' ) and ( CxRacForm.QueryCodigoCliente.Value<>'' )
     then ClienteCtrl.PostEditValue( CxRacForm.QueryCodigoCliente.Value );
     RegistroAuxiliarCtrl.PostEditValue( CxRacForm.QueryCodigo.Value );
end;

procedure TMntMveForm.RegistroAuxiliarCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     AuxiliarCliente.Valida( MovimientoFields.Propietario.Value, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.RelacionesPopupMenuPopup(Sender: TObject);
begin    
     With MovimientoFields do
       LineasDocumentoItem.Caption := Format( RsMsg7, [ Ifthen( ( Movimiento.ModuloHojasDePedido and ( TipoMovimientoEdicion=tmPedidoventa ) ), 'a', 'e' ),
                                                        Movimiento.TextoTipoMovimiento( TipoMovimientoEdicion, False ) ] );
     SetBarItemsVisible( [ FacturaVentaItem ], ( TipoMovimientoEdicion=tmVenta ) and MovimientoFields.Facturado.Value );
     SetBarItemsVisible( [ DocumentoOrigenItem ], MovimientoFields.NroOperacionOrigen.Value<>0 );
end;

procedure TMntMveForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TMntMveForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error, SerieFacturacionFields );
end;

procedure TMntMveForm.ServidoCtrlPropertiesValuePosted(Sender: TObject);

var  Servido : Boolean;
     EstadoPedido : TEstadoPedido;

begin
     EstadoPedido := Movimiento.EstadoPedido( MovimientoFields );
     If   not DataServido.Value and ( EstadoPedido.Situacion=epProcesado ) and not EstadoPedido.Procesada
     then begin
          ShowNotification( ntWarning, RsMsg15, RsMsg16 );
          DataServido.Value := True;
          end
     else try

            Servido := DataServido.Value;

            // El dato Servido ya está cambiado cuando se hace ésta comprobación

            If   Servido and DataModule00.DmEmpresaFields.Ventas_RegularizarPedidosServidos.Value
            then If   ShowNotification( ntQuestionWarning, RsMsg46, RsMsg47 )<>mrYes
                 then begin
                      DataServido.Value := False;
                      Abort;
                      end;

            MovimientoTable.Browse;  // Se necesita editar el registro en el servidor
            CantidadProcesadaTotal := Movimiento.CambiaSituacionPedido( MovimientoFields.NroOperacion.Value, Servido );

          finally
            FormManager.SelectFirstKeyControl;
            end;
end;

procedure TMntMveForm.SuprimirVinculosItemClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg48, RsMsg49 )=mrYes
     then If   Movimiento.SuprimeVinculosConPedidos( MovimientoFields.NroOperacion.Value, LineaMovimientoFields.NroPagina.Value )
          then With MovimientoTable do
                 begin
                 Cancel;
                 ReloadRecord;
                 end;
end;

procedure TMntMveForm.ClienteCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClientes( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.ClienteCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Assigned( ClienteFields )
     then MuestraRiesgo;
end;

procedure TMntMveForm.ClienteCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);
begin
     MostrarAviso;
end;

procedure TMntMveForm.ClienteCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaClientes( Sender );
end;

procedure TMntMveForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin

     AvisoButton.Visible := False;

     Cliente.Valida( Sender, DisplayValue, ErrorText, Error, ClienteFields, False, not FormManager.ValidatingFormData );

     If   not Error
     then begin

          If   Sender.Editing and ( DisplayValue<>MovimientoFields.Propietario.Value ) and ( LineaMovimientoTable.RecordCount<>0 )
          then If   ShowNotification( ntQuestionWarning, RsMsg42, RsMsg43 )<>mrYes
               then begin
                    ClienteCtrl.PostEditValue( MovimientoFields.Propietario.Value );
                    Abort;
                    end;

          If   GridViewPrecioDivisa.Visible
          then begin
               GridViewPrecioDivisa.Caption := RsPrecioDivisa;
               CodigoDivisa := ClienteFields.CodigoDivisa.Value;
               If   not ValueIsEmpty( CodigoDivisa )
               then If   Divisa.Obten( CodigoDivisa, DsDivisaFields, True )
                    then begin
                         GridViewPrecioDivisa.Caption := Format( RsPrecioDivisaCodigo, [ DsDivisaFields.Codigo.Value ] );
                         SetColumnDecimals( GridViewPrecioDivisa, Decimales( DsDivisaFields.PrecisionRedondeo.Value ) );
                         end;
               end;

          ActualizaVisibilidadAviso( ClienteFields.MostrarAviso.Value and ( ClienteFields.Aviso.Value<>'' ) );
          end;
end;

procedure TMntMveForm.ClienteCtrlPropertiesValuePosted(Sender: TObject);

var  ErrorText : TCaption;
     ErrorResult : Boolean;

begin
     With ClienteCtrl do
       If   Editing
       then begin

            ObtenCliente( MovimientoFields.Propietario.Value );

            Movimiento.InsertaVinculosCliente( MovimientoFields, ClienteFields );

            With RelacionesCliente do
              begin
              CompruebaCredito( ClienteFields );
              CompruebaRiesgo( ClienteFields );
              end;

            FormManager.ValidateEditControls( faData, ErrorText, ErrorResult );

            // Al cambiar el cliente han podido cambiar las referencias (el calculo del IVA sobre todo)

            Movimiento.RecalculaMovimiento( MovimientoFields );

            ActualizaContenidoRejillas;

            // Esto es para que se muestre el aviso del vendedor si existe

            MostrarAvisoVendedor := True;

            end;

end;

procedure TMntMveForm.ObtenCliente( Codigo : String );
begin
     If   PropietarioActual<>MovimientoFields.Propietario.Value
     then begin
          PropietarioActual := MovimientoFields.Propietario.Value;
          Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
          FCodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields );
          end;
end;

procedure TMntMveForm.CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntOperarios( [ MovimientoFields.Propietario.Value, Sender.EditingValue ] );
end;

procedure TMntMveForm.CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender, ClienteCtrl.EditValue );
end;

procedure TMntMveForm.CodigoOperarioCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                            var DisplayValue : Variant;
                                                            var ErrorText    : TCaption;
                                                            var Error        : Boolean);
begin
     Operario.Valida( ClienteCtrl.EditValue, Sender, DisplayValue, ErrorText, Error);
end;

procedure TMntMveForm.ConsultaArticulosEquivalentesItemClick(Sender: TObject);
begin
     If   Assigned( GridView.Controller.EditingController.Edit )
     then With GridView.Controller.EditingController do
            If   Edit.ValidateEdit
            then ConsultaArticulosRelacionados( 1, Edit );
end;

procedure TMntMveForm.ConsultaArticulosItemClick(Sender: TObject);
begin
     ConsultaArticulos( scVentas, False, GridView.Controller.EditingController.Edit );
end;

procedure TMntMveForm.ConsultaArticulosRelacionadosItemClick(Sender: TObject);
begin
     If   Assigned( GridView.Controller.EditingController.Edit )
     then With GridView.Controller.EditingController do
            If   Edit.ValidateEdit
            then ConsultaArticulosRelacionados( 0, Edit );
end;

procedure TMntMveForm.ConsumosPreciosButtonClick(Sender: TObject);
begin
     MovimientoTable.Update;
     case TipoMovimientoEdicion of
       tmPresupuesto :
         CalculoPreciosVenta( DoOnCalculaPrecios );
       else
         With MovimientoFields do
           SeleccionaConsumosCliente( Propietario.Value, DoInsertaLineasConsumo );
       end;
end;

procedure TMntMveForm.CopiarAnotacionItemClick(Sender: TObject);
begin
     LineaMovimientoTable.Edit;
     LineaMovimientoFields.Anotacion.Value := ArticuloFields.Anotacion.Value;
     LineaMovimientoTable.Post;
end;

procedure TMntMveForm.DoOnCalculaPrecios;

var  CosteLinea,
     PrecioLinea  : Decimal;
     ExistenciasArticulo : IExistenciasArticulo;

procedure CambiaPreciosLineas;
begin
     With LineaMovimientoTable do
       begin
       First;
       While not Eof do
         begin

         With BoxCmpForm, LineaMovimientoFields do
           begin

           If   DataOperacion.Value=0
           then begin

                If  CodigoArticulo.Value<>ArticuloManual
                then begin
                     Edit;
                     PrecioLinea := Precio.Value;
                     Precio.Value := 0.0;    // para que se recalcule
                     Articulo.Obten( CodigoArticulo.Value, ArticuloFields );
                     Articulo.ObtenPrecioyDtoVenta( TipoMovimientoEdicion, LineaMovimientoFields, ClienteFields.Codigo.Value );
                     If   Precio.Value=0.0
                     then Cancel
                     else begin
                          Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );
                          Post;
                          end;
                     end;

                end
           else begin

                If   not NoCalcularMargen.Value and ( CodigoArticulo.Value<>ArticuloManual )
                then If   Articulo.Obten( CodigoArticulo.Value, ArticuloFields )
                     then begin
                          ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                                          False,
                                                                          CodigoClaseA.Value,
                                                                          CodigoClaseB.Value,
                                                                          CodigoClaseC.Value,
                                                                          True,
                                                                          '',
                                                                          True,
                                                                          '',
                                                                          True,
                                                                          '',
                                                                          True,
                                                                          MovimientoFields.Ejercicio.Value,
                                                                          0,
                                                                          MonthOf( Fecha.Value ) );

                          case DataPrecioBase.Value of
                            0 : CosteLinea  := ExistenciasArticulo.Coste;
                            1 : CosteLinea  := ExistenciasArticulo.CosteMedio;
                            2 : CosteLinea  := ExistenciasArticulo.CosteUltEntrada;
                            3 : begin
                                CosteLinea  := ArticuloFields.Precio_Compra.Value;
                                If   DataAplicarDescuento.Value
                                then CosteLinea := CosteLinea - ( ( CosteLinea * ArticuloFields.Dto_Compra.Value ) / 100.0 );
                                end;
                            end;

                          try
                            If   DataTipoMargen.Value=0  // Sobre el precio de compra
                            then PrecioLinea := CosteLinea + ( ( CosteLinea * DataPorcentajeMargen.Value ) / 100.0 )
                            else PrecioLinea := CosteLinea / ( 1 - ( DataPorcentajeMargen.Value / 100.0 ) );

                            Edit;
                            Precio.Value := PrecioLinea;
                            Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );
                            Post;
                          except
                            end;

                          end;
                end;
           end;

         Next;
         end;
       end;
end;

begin

     GrupoLineaMovimientoTable.DisableControls;
     LineaMovimientoTable.DisableControls;

     try
       If   not DataModule00.PartidasPresupuestarias or BoxCmpForm.DataSoloPaginaActiva.Value
       then CambiaPreciosLineas
       else With GrupoLineaMovimientoTable do
              begin
              First;
              While not Eof do
                begin
                LineaMovimientoTable.Refresh;
                CambiaPreciosLineas;
                Next;
                end;
              end;

     finally

       GrupoLineaMovimientoTable.EnableControls;
       LineaMovimientoTable.EnableControls;
       LineaMovimientoTable.Last;

       ActualizaContenidoRejillas;

       Grid.SetFocus;
       end;
end;

procedure TMntMveForm.TableViewManagerBeforeValidateTableView(Sender: TObject);
begin

     // Se puede salir de la línea directamente cambiando, por ejemplo, el almacén y pulsando cursor-abajo. En ese caso
     // no da tiempo a que se actualicen las existencias antes de validar la cantidad.

     ObtenExistencias;
end;

function TMntMveForm.TableViewManagerCanDeleteRow: Boolean;
begin
     Result := ( MovimientoTable.State=dsEdit ) and
               not ( ( TipoMovimientoEdicion=tmVenta ) and MovimientoFields.Facturado.Value ) and
               not ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( ( MovimientoFields.Situacion.Value=epProcesado ) or ( LineaMovimientoFields.CantidadProcesada.Value<>0.0 ) or LineaMovimientoFields.Procesada.Value ) ) and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntMveForm.TableViewManagerCanInsertRow: Boolean;
begin
	
	    // Los usuario quieren poder añadir líneas al pedido aunque esté parcialmente servido
	
     Result := ( MovimientoTable.State=dsEdit ) and
               not ( ( TipoMovimientoEdicion=tmVenta ) and MovimientoFields.Facturado.Value ) and
               not ( ( TipoMovimientoEdicion=tmPedidoVenta ) and ( MovimientoFields.Situacion.Value=epProcesado ) ) and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntMveForm.TableViewManagerCanShiftRow: Boolean;
begin
     Result := not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

function TMntMveForm.TableViewManagerCanShowDocument: Boolean;
begin
     Result := GridView.DataController.FocusedRowIndex<>-1;
end;

procedure TMntMveForm.TableViewManagerRowShift( ShiftOperation : TShiftOperation );

var  HaciaArriba,
     HastaElFinal : Boolean;

begin
     HaciaArriba := ( ShiftOperation=soFirst ) or ( ShiftOperation= soPrior );
     HastaElFinal := ( ShiftOperation= soFirst ) or ( ShiftOperation=soLast );
     With LineaMovimientoFields do
       Movimiento.DesplazaLineaMovimiento( Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value, HaciaArriba, HastaElFinal );
end;

function TMntMveForm.DoShowDocument: Boolean;
begin
     EditarRelacionDocumentos( LineaMovimientoFields.NroRegistro.Value, DoOnCloseRelacionDocumentos );
end;

procedure TMntMveForm.DocumentosOrigenItemClick(Sender: TObject);
begin
     RelacionLineasDocumento( LineaMovimientofields.NroRegistro.Value );
end;

procedure TMntMveForm.DirectorioDocumentosItemClick(Sender: TObject);
begin
     If   SelectDirectory( FDirectorioDocumentos )
     then Registro.GuardaValor( ObtenClaveDocumentos, FDirectorioDocumentos );
     FormManagerUpdateButtonsState;
end;

procedure TMntMveForm.NoPedirAlProveedorItemClick(Sender: TObject);
begin
     If   MovimientoTable.Editing
     then begin
          LineaMovimientoTable.Edit;
          LineaMovimientoFields.Parametros.Value := ToggleBit( LineaMovimientoFields.Parametros.Value, 1 ); // Conmutando entre 0 y 1
          LineaMovimientoTable.Post;
          TableViewManager.RefreshGrid;
          end;
end;

procedure TMntMveForm.DoOnCloseRelacionDocumentos;
begin
     TableViewManager.RefreshGrid;
end;

procedure TMntMveForm.TransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TMntMveForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( MovimientoFields.TipoMovimiento.Value,
                               MovimientoFields.NroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

procedure TMntMveForm.VendedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntVendedores( [ Sender.EditingValue ] );
end;

procedure TMntMveForm.VendedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaVendedores( Sender );
end;

procedure TMntMveForm.VendedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     VendedorCtrl.ModifiedAfterEnter := VendedorCtrl.ModifiedAfterEnter or MostrarAvisoVendedor;
     MostrarAvisoVendedor := False;
     Vendedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMveForm.VincularPedidoItemClick(Sender: TObject);
begin
     VincularAPedido( MovimientoFields, LineaMovimientoFields );
end;

{ TSumasPagina }

procedure TSumasPagina.LimpiaPagina( LimpiarValoresImpositivos : Boolean = False );
begin
     Cantidad := 0.0;
     CantidadProcesada  := 0.0;
     Alto := 0.0;
     Peso := 0.0;
     FillChar( SumaTasas, SizeOf( SumaTasas ), #0 );
     If   LimpiarValoresImpositivos
     then Movimiento.InicializaValoresImpositivos( TasasArray );
end;

procedure TSumasPagina.AcumulaValoresImpositivos( Fecha       : TDate;
                                                  ModeloIVA   : SmallInt;
                                                  CalcularIVA : Boolean );
begin

     // Acumulo las bases y cuotas por tipo impositivo (como se hace en el proceso de facturación), sin embargo está también desglosado
     // por página, por lo que en los documentos paginados podría darse algún tipo de descuadre por este desglose adicional. No lo considero importante
     // porque los acumulados por página deben considerarse tan solo informativos : no afectan a los totales reales del documento.

     FacturaVentas.AcumulaValoresImpositivos( TasasArray, Fecha, ModeloIVA, CalcularIVA, SumaTasas );
end;

end.


