unit a_art;

interface

uses Forms, ComCtrls, StdCtrls, Buttons, Mask,
  Controls, Classes, ExtCtrls, sysUtils, Graphics, Grids,
  Menus,

  cxLookAndFeelPainters, cxButtons, DB,nxdb,
  DataManager, cxCurrencyEdit, cxDBEdit, cxMaskEdit, cxSpinEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCheckBox, cxImage,
  cxDropDownEdit, cxCalendar, cxMemo,
  cxPC, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  nxllComponent, cxRichEdit, cxDBRichEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox, cxLookAndFeels,
  f_not, cxLabel, cxPCdxBarPopupMenu, cxNavigator, dxBarBuiltInMenu,
  cxCheckGroup, cxDBCheckGroup, cxScrollBox, cxSplitter, dxDateRanges,
  dxBar, dxToggleSwitch, dxDBToggleSwitch,  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxTokenEdit, dxDBTokenEdit, cxGeometry, dxFramedControl, dxPanel, dxUIAClasses,

  Gim10Fields,
  Gim30Fields,

  LibUtils,
  AppContainer,
  AppManager,
  AppForms,
  GridTableViewController,
  Spring,

  dm_sto;

type

  TMntArtForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    CodigoCtrl: TcxDBTextEdit;
    ArticuloTable: TnxeTable;
    Panel5: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    datEconButton: TgBitBtn;
    ArticuloDataSource: TDataSource;
    MovimientosButton: TgBitBtn;
    RejillaButton: TgBitBtn;
    DataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    DatosGeneralesTabSheet: TcxTabSheet;
    FamiliaCtrl: TcxDBTextEdit;
    TipoIVACtrl: TcxDBSpinEdit;
    NoAplicarTipoFijoCtrl: TcxDBCheckBox;
    NoAplicarRetencionCtrl: TcxDBCheckBox;
    CodigoBarrasCtrl: TcxDBTextEdit;
    ImagenCtrl: TcxDBImage;
    FijarMedidasCtrl: TcxDBCheckBox;
    preciosTabSheet: TcxTabSheet;
    AlmacenTabSheet: TcxTabSheet;
    TabSheet3: TcxTabSheet;
    AmpliacionTabSheet: TcxTabSheet;
    TarifaVentasTabSheet: TcxTabSheet;
    FabricacionTabSheet: TcxTabSheet;
    Panel2: TcxGroupBox;
    DescripcionCtrl: TcxDBTextEdit;
    AvisosTabSheet: TcxTabSheet;
    AnotacionesFrame: TAnnotationFrame;
    Panel1: TcxGroupBox;
    MostrarAvisoCtrl: TcxDBCheckBox;
    AnnotationFrame1: TAnnotationFrame;
    codigoCtrlCaption: TcxLabel;
    Label25: TcxLabel;
    descFamiliaLabel: TcxLabel;
    DescTipoIVALabel: TcxLabel;
    Label15: TcxLabel;
    Label19: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    Precio_CompraCtrl: TcxDBCurrencyEdit;
    Dto_CompraCtrl: TcxDBCurrencyEdit;
    CodigoProveedorCtrl: TcxDBTextEdit;
    Label31: TcxLabel;
    Label32: TcxLabel;
    Label33: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    Precio_VentaCtrl: TcxDBCurrencyEdit;
    Dto_VentaCtrl: TcxDBCurrencyEdit;
    ComisionCtrl: TcxDBCurrencyEdit;
    PrecioVentaIVACtrl: TcxCurrencyEdit;
    Recargo_VentaCtrl: TcxDBCurrencyEdit;
    MargenComercialCtrl: TcxDBCurrencyEdit;
    PuntoVerdeCtrl: TcxDBCurrencyEdit;
    OfertaCtrl: TcxDBCheckBox;
    Label1: TcxLabel;
    Label2: TcxLabel;
    Label4: TcxLabel;
    Label5: TcxLabel;
    Label8: TcxLabel;
    Label20: TcxLabel;
    recargoLabel: TcxLabel;
    Label27: TcxLabel;
    Label28: TcxLabel;
    Label14: TcxLabel;
    ParametrosOfertaGroupBox: TcxGroupBox;
    OfertaFechaInicialCtrl: TcxDBDateEdit;
    OfertaFechaFinalCtrl: TcxDBDateEdit;
    OfertaPrecioVentaCtrl: TcxDBCurrencyEdit;
    OfertaPrecioVentaIVACtrl: TcxCurrencyEdit;
    OfertaDescuentoCtrl: TcxDBCurrencyEdit;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label29: TcxLabel;
    Label34: TcxLabel;
    Label35: TcxLabel;
    Label36: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    LargoCtrl: TcxDBCurrencyEdit;
    AnchoCtrl: TcxDBCurrencyEdit;
    AltoCtrl: TcxDBCurrencyEdit;
    Label22: TcxLabel;
    Label23: TcxLabel;
    Label24: TcxLabel;
    cxGroupBox5: TcxGroupBox;
    cxGroupBox6: TcxGroupBox;
    CampoLibre15Ctrl: TcxDBMemo;
    campo1Label: TcxLabel;
    cxGroupBox7: TcxGroupBox;
    CampoLibre16Ctrl: TcxDBMemo;
    campo2Label: TcxLabel;
    cxGroupBox8: TcxGroupBox;
    CampoLibre3Ctrl: TcxDBTextEdit;
    campo3Label: TcxLabel;
    cxGroupBox9: TcxGroupBox;
    CampoLibre4Ctrl: TcxDBTextEdit;
    campo4Label: TcxLabel;
    cxGroupBox10: TcxGroupBox;
    CampoLibre5Ctrl: TcxDBCurrencyEdit;
    Campo5Label: TcxLabel;
    cxGroupBox11: TcxGroupBox;
    CampoLibre6Ctrl: TcxDBCurrencyEdit;
    Campo6Label: TcxLabel;
    cxGroupBox12: TcxGroupBox;
    CampoLibre7Ctrl: TcxDBCurrencyEdit;
    Campo7Label: TcxLabel;
    cxGroupBox13: TcxGroupBox;
    CampoLibre8Ctrl: TcxDBCurrencyEdit;
    Campo8Label: TcxLabel;
    cxGroupBox14: TcxGroupBox;
    CampoLibre9Ctrl: TcxDBCheckBox;
    cxGroupBox15: TcxGroupBox;
    CampoLibre10Ctrl: TcxDBSpinEdit;
    cxLabel1: TcxLabel;
    cxGroupBox16: TcxGroupBox;
    CampoLibre11Ctrl: TcxDBSpinEdit;
    cxLabel2: TcxLabel;
    CampoLibre12Ctrl: TcxDBSpinEdit;
    cxLabel3: TcxLabel;
    TarifaComprasTabSheet: TcxTabSheet;
    GridTableViewController2: TGridTableViewController;
    TarifaComprasGrid: TcxGrid;
    TarifaComprasTableView: TcxGridDBTableView;
    TarifaComprasGridLevel: TcxGridLevel;
    TarifaComprasDataSource: TDataSource;
    TarifaComprasCachedDataSet: TnxeCachedDataSet;
    TarifaComprasQuery: TnxeQuery;
    TarifaComprasTable: TnxeTable;
    TarifaComprasCachedDataSetCodigo: TWideStringField;
    TarifaComprasCachedDataSetNombre: TWideStringField;
    TarifaComprasCachedDataSetTipo: TSmallintField;
    TarifaComprasCachedDataSetCodigoProveedor: TWideStringField;
    TarifaComprasCachedDataSetCodigoArticulo: TWideStringField;
    TarifaComprasCachedDataSetReferencia: TWideStringField;
    TarifaComprasCachedDataSetDescuento: TBCDField;
    TarifaComprasTableViewCodigo: TcxGridDBColumn;
    TarifaComprasTableViewNombre: TcxGridDBColumn;
    TarifaComprasTableViewReferencia: TcxGridDBColumn;
    TarifaComprasTableViewPrecio: TcxGridDBColumn;
    TarifaComprasTableViewDescuento: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    FechaAltaCtrl: TcxDBDateEdit;
    TarifaComprasCachedDataSetPrecio: TFloatField;
    cxLabel5: TcxLabel;
    UnidadesPrecioCompraCtrl: TcxDBSpinEdit;
    cxLabel6: TcxLabel;
    UnidadesPrecioVentaCtrl: TcxDBSpinEdit;
    FabricacionGroupBox: TcxGroupBox;
    ParametrosGroupBox: TcxGroupBox;
    ParametrosCtrl: TcxDBCheckGroup;
    TiendaVirtualTabSheet: TcxTabSheet;
    CalcularPreciosCtrl: TcxDBCheckBox;
    cxGroupBox3: TcxGroupBox;
    CampoLibre13Ctrl: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    cxGroupBox17: TcxGroupBox;
    CampoLibre14Ctrl: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    cxLabel14: TcxLabel;
    CantidadMinimaVentaCtrl: TcxDBCurrencyEdit;
    StockMaximoMinimoPanel: TcxGroupBox;
    cxGroupBox21: TcxGroupBox;
    cxGroupBox22: TcxGroupBox;
    UbicacionCtrl: TcxDBTextEdit;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    Label43: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label13: TcxLabel;
    Stock_MinimoCtrl: TcxDBCurrencyEdit;
    Stock_MaximoCtrl: TcxDBCurrencyEdit;
    Label39: TcxLabel;
    Label40: TcxLabel;
    UnidadesPorCajaCtrl: TcxDBCurrencyEdit;
    KilosCtrl: TcxDBCurrencyEdit;
    VolumenCtrl: TcxDBCurrencyEdit;
    ObsoletoCtrl: TcxDBCheckBox;
    NoAfectarStockCtrl: TcxDBCheckBox;
    BultosCtrl: TcxDBCurrencyEdit;
    Label42: TcxLabel;
    capBultosLabel: TcxLabel;
    s1Label: TcxLabel;
    s2Label: TcxLabel;
    NoAfectarCosteCtrl: TcxDBCheckBox;
    ExistenciasArticuloPanel: TcxGroupBox;
    Label41: TcxLabel;
    ExistenciasArticuloGrid: TcxGrid;
    ExistenciasArticuloTableView: TcxGridDBTableView;
    ExistenciasArticuloGridLevel: TcxGridLevel;
    cxLabel15: TcxLabel;
    ExistenciasArticuloTableViewCodigoAlmacen: TcxGridDBColumn;
    ExistenciasArticuloTableViewStockMinimo: TcxGridDBColumn;
    ExistenciasArticuloTableViewStockMaximo: TcxGridDBColumn;
    ExistenciasArticuloTableViewNombre: TcxGridDBColumn;
    ExistenciasArticuloQuery: TnxeQuery;
    ExistenciasArticuloCachedDataSet: TnxeCachedDataSet;
    ExistenciasArticuloDataSource: TDataSource;
    ExistenciasArticuloCachedDataSetCodigoAlmacen: TWideStringField;
    ExistenciasArticuloCachedDataSetNombreAlmacen: TWideStringField;
    ExistenciasArticuloCachedDataSetStockMinimo: TBCDField;
    ExistenciasArticuloCachedDataSetStockMaximo: TBCDField;
    ExistenciasArticuloTable: TnxeTable;
    GridTableViewController3: TGridTableViewController;
    cxGroupBox20: TcxGroupBox;
    cxScrollBox1: TcxScrollBox;
    RelacionesTabSheet: TcxTabSheet;
    cxSplitter1: TcxSplitter;
    ArticuloConEnvaseCtrl: TcxDBCheckBox;
    ExistenciasArticuloCachedDataSetUbicacion: TWideStringField;
    ExistenciasArticuloTableViewUbicacion: TcxGridDBColumn;
    BarManager: TdxBarManager;
    ListadoUbicacionesStocksItem: TdxBarButton;
    ReportFormsPopupMenu: TdxBarPopupMenu;
    ListaoArticulosItem: TdxBarButton;
    Label26: TcxLabel;
    MostrarProveedoresConDatosCtrl: TcxCheckBox;
    cxGroupBox27: TcxGroupBox;
    cxGroupBox28: TcxGroupBox;
    StyleRepository: TcxStyleRepository;
    SelectionStyle: TcxStyle;
    PaisesIVAButton: TgBitBtn;
    cxGroupBox31: TcxGroupBox;
    cxGroupBox32: TcxGroupBox;
    CampoLibre1Ctrl: TcxDBTextEdit;
    cxLabel16: TcxLabel;
    cxGroupBox33: TcxGroupBox;
    CampoLibre2Ctrl: TcxDBTextEdit;
    cxLabel17: TcxLabel;
    cxLabel11: TcxLabel;
    DocumentosExternosCtrl: TcxDBTextEdit;
    ExaminarButton: TgBitBtn;
    DocumentosExternosButton: TgBitBtn;
    cxSplitter2: TcxSplitter;
    ArticuloPeligrosoCtrl: TcxDBCheckBox;
    UnidadesPorPalletCtrl: TcxDBCurrencyEdit;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: SmallInt;
    procedure FormManagerLabelsRequest;
    procedure datEconButtonClick(Sender: TObject);
    procedure ArticuloTableBeforeDelete(DataSet: TDataSet);
    procedure ArticuloTableNewRecord(DataSet: TDataSet);
    procedure FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure TipoIVACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure TipoIVACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure PrecioVentaIVACtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure CodigoBarrasCtrlPropertiesExtendedFunction(
      Sender: TcxCustomEdit);
    procedure NoAfectarStockCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoBarrasCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure CodigoBarrasCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FijarMedidasCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure OfertaPrecioVentaIVACtrlPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure Precio_VentaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Precio_CompraEditValueChanged(Sender: TObject);
    procedure ArticuloTableBeforePost(DataSet: TDataSet);
    procedure MovimientosButtonClick(Sender: TObject);
    procedure OfertaCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure RejillaButtonClick(Sender: TObject);
    procedure FormManagerAfterValidateDataArea(FieldArea: TFieldArea;
      var ErrorText : TCaption; var ErrorResult : Boolean; 
      NotifyError, UpdateData: Boolean; out InvalidCustomEdit : TcxCustomEdit);
    procedure MargenComercialCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TarifaComprasCachedDataSetBeforePost(DataSet: TDataSet);
    procedure TarifaComprasQueryAfterOpen(DataSet: TDataSet);
    procedure PageControlChange(Sender: TObject);
    function FormManagerCopyCurrentRecord: Boolean;
    procedure ArticuloTableAfterEdit(DataSet: TDataSet);
    procedure NombreImagenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure ExistenciasArticuloQueryAfterOpen(DataSet: TDataSet);
    procedure ExistenciasArticuloCachedDataSetBeforePost(DataSet: TDataSet);
    procedure ExistenciasArticuloTableViewUbicacionPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure ExistenciasArticuloTableViewUbicacionPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure ExistenciasArticuloTableViewUbicacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure ListadoUbicacionesStocksItemClick(Sender: TObject);
    procedure ListaoArticulosItemClick(Sender: TObject);
    procedure TarifaComprasQueryBeforeOpen(DataSet: TDataSet);
    procedure MostrarProveedoresConDatosCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure ArticuloTableGetRecord(DataSet: TDataSet);
    procedure FormManagerInsertRecRequest;
    procedure PaisesIVAButtonClick(Sender: TObject);
    procedure FormManagerUpdateButtonsState;
    procedure ExaminarButtonClick(Sender: TObject);
    procedure DocumentosExternosButtonClick(Sender: TObject);

  private

    ExisteTarifaVenta : Boolean;

    FOnPageChanged : Event<TWrapperEvent>;
    FOnArticuloBeforePost : Event<TDataSetNotifyEvent>;
    FOnTarifaVentasBeforePost : Event<TDataSetNotifyEvent>;
    FOnActualizaEstadoComponentes : Event<TSimpleEvent>;

    procedure ActualizaPreciosCalculados;
    procedure ActualizaEstadoComponentes;
    procedure DoOnCopiaRegistro;

  public

    ArticuloFields : TArticuloFields;
    ExistenciasArticuloFields : TExistenciasArticuloFields;
    TarifaComprasFields : TTarifaComprasFields;
    DsTiposIVAFields : TTiposIVAFields;

    property OnArticuloBeforePost : Event<TDataSetNotifyEvent> read FOnArticuloBeforePost write FOnArticuloBeforePost;
    property OnPageChanged : Event<TWrapperEvent> read FOnPageChanged write FOnPageChanged;
    property OnActualizaEstadoComponentes : Event<TSimpleEvent> read FOnActualizaEstadoComponentes write FOnActualizaEstadoComponentes;
    property OnTarifaVentasBeforePost : Event<TDataSetNotifyEvent> read FOnTarifaVentasBeforePost write FOnTarifaVentasBeforePost;
  end;

var
  MntArtForm: TMntArtForm = nil;

procedure MntArticulos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   WinAPI.Windows,

       Variants,
       EnterpriseDataAccess,
       Files,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,
       Gdm30Frm,

       dmi_pga,
       dmi_iva,
       dmi_cnd,
       dmi_mov,
       dmi_sto,

       dm_reg,
       dm_iva,
       dm_art,
       dm_cls,
       dm_fam,
       dm_pro,
       dm_alm,
       dm_ubi,
       dm_lma,
       dm_cdt,
       dm_pga,
       dm_mov,
       dm_cnd,
       dm_fdv,

       b_msg,
       b_fda,

       a_iva,
       a_fam,
       a_pro,
       a_alm,
       a_ubi,
       a_cdb,
       a_tip,

       b_crt,
       b_dir,

       cx_art,
       cx_fam,
       cx_iva,
       cx_pro,
       cx_alm,
       cx_ubi,
       cx_cdb,

       c_art,

       l_art,
       l_uda,
       e_art,
       d_art;

resourceString
  RsMsg1  = 'Artículo con movimientos, no puede ser dado de baja.';
  RsMsg2  = 'Si desea suprimirlo quite todas las referencias al mismo en listas de materiales, pedidos, albaranes y movimientos de almacén.';
  RsMsg3  = 'El precio de referencia (sin I.V.A. incluido) calculado no es capaz de generar el precio con I.V.A. incluido introducido.';
  RsMsg4  = 'Deberá asignar un precio final con I.V.A. incluído diferente.';
  RsMsg5  = 'Ha modificado la forma en que este artículo afecta a las existencias y hay movimientos del mismo.';
  RsMsg6  = 'Recuerde que debe reconstruir los resultados si quiere que los movimientos existentes reflejen la nueva situación del artículo.';
  RsMsg7  = 'El valor del margen no puede ser igual o superior a 100.0.';
  RsMsg8  = 'Sus margenes se calculan sobre el precio de venta y, por lo tanto, no pueden superar el valor del 100%.'#13'Puede indicar que los márgenes se calculen sobre el precio de compra activando la opción correspondiente en [B]Configuración de la aplicación[/B].';
  RsMsg9  = 'El tamaño interno de la imagen es muy grande.';
  RsMsg10 = 'La imagen tiene un tamaño de %d KB.'#13'Tenga en cuenta que esta información se guarda en el registro del artículo y su manejo puede enlentecer las operaciones con el mismo.';
  RsMsg11 = 'Ya existe un artículo de código %s.';
  RsMsg12 = 'Utilice una plantilla para generar códigos de artículo automáticos';
  RsMsg13 = 'El caracter # sirve de comodín para la generación de números correlativos dentro del código del artículo.'#13'Por ejemplo si introduce ABC####-EF, se generarán los códigos ABC0000-EF, ABC0001-EF, etc..';
  //..
  RsMsg16 = 'Debe indicar el directorio de los documentos externos en la ficha del artículo.';
  

const
  BigImageSize = 32768;

procedure MntArticulos( KeyValues : array of const );
begin
     Articulo;     // Creando los ficheros
     CodigoTarifa;
     CreateEditForm( TMntArtForm, mntArtForm, KeyValues, TGds30Frm.AlmacenSection );
end;

procedure TMntArtForm.FormManagerInitializeForm;

procedure ActivaCamposLibres( Controles : array of TcxCustomEdit );

var  Index  : SmallInt;
     CustomEdit : TcxCustomEdit;

begin
     With DataModule00.DmEmpresaFields do
       For Index := 0 to High( Controles ) do
         begin
         CustomEdit := Controles[ Index ];
         With CustomEdit do
           begin
           Enabled := not ValueIsEmpty( Articulo_CampoLibre[ Index + 1 ].Value );
           SetupPanelableCtrl( Controles[ Index ], Enabled );
           If   Enabled
           then begin
                If   CustomEdit is TcxDBCheckBox
                then TcxDBCheckBox( CustomEdit ).Caption := Articulo_CampoLibre[ Index + 1 ].Value
                else CaptionLabel.EditValue := Articulo_CampoLibre[ Index + 1 ].Value;
                Properties.Required := Articulo_CampoLibOblig[ Index + 1 ].Value;
                end;
           end;
         end;
end;

begin

     ID := idMntArtForm;

     ArticuloFields := TArticuloFields.Create( ArticuloTable );
     ExistenciasArticuloFields := TExistenciasArticuloFields.Create( ExistenciasArticuloTable );
     TarifaComprasFields := TTarifaComprasFields.Create( TarifaComprasTable );

     DsTiposIVAFields := TTiposIVAFields.Create( Self );

     PinupAdjustableControl( PageControl, 345 );

     AmpliacionTabSheet.TabVisible := DataModule00.DmEmpresaFields.Articulo_CamposLibres.Value;
     TarifaComprasTabSheet.TabVisible := not DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value;
     TarifaVentasTabSheet.TabVisible := DataModule00.DmEmpresaFields.Cliente_TarCodigo.Value;
     FabricacionTabSheet.TabVisible := ApplicationContainer.IsModuleActive( [ 70, 101, 103, 105, 116 ] );
     TiendaVirtualTabSheet.TabVisible := DataModule00.TiendaVirtual;
     RelacionesTabSheet.TabVisible := DataModule00.DmEmpresaFields.Articulo_ArticulosRelacionados.Value;

     ArticuloConEnvaseCtrl.Visible := DataModule00.DmEmpresaFields.Articulo_Envase.Value<>0;
     ArticuloPeligrosoCtrl.Visible := ArticuloConEnvaseCtrl.Visible;

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          Label31.Visible := False;
          precio_CompraCtrl.Visible := False;
          Label32.Visible := False;
          Dto_CompraCtrl.Visible := False;
          Label33.Visible := False;
          end;

     DatEconButton.Enabled := DataModule00.DmUsuarioFields.acRE.Value=1;

     With DataModule00.DmEmpresaFields do
       begin

       PaisesIVAButton.Visible := Contable_VentasOnlineIntracomunitarias.Value;

       SetEditcontrolsDecimals( [ LargoCtrl, AnchoCtrl, AltoCtrl, Stock_MinimoCtrl, Stock_MaximoCtrl, UnidadesPorCajaCtrl, UnidadesPorPalletCtrl ], Ventas_DecCantidad.Value );
       SetEditcontrolsDecimals( [ ComisionCtrl, MargenComercialCtrl ], 2 );
       SetEditcontrolsDecimals( [ CampoLibre5Ctrl, CampoLibre6Ctrl, CampoLibre7Ctrl, CampoLibre8Ctrl ], 4 );
       SetEditcontrolsDecimals( [ BultosCtrl, KilosCtrl, VolumenCtrl ], 4 );

       SetEditcontrolDecimals( Precio_CompraCtrl, Compras_DecPrecio.Value );
       SetEditcontrolDecimals( Dto_CompraCtrl, Compras_DecDto.Value );

       SetEditcontrolsDecimals( [ Precio_VentaCtrl, PuntoVerdeCtrl, OfertaPrecioVentaCtrl ], Ventas_DecPrecio.Value );
       SetEditcontrolsDecimals( [ Dto_VentaCtrl, OfertaDescuentoCtrl ], Ventas_DecDto.Value );
       SetEditcontrolDecimals( Recargo_VentaCtrl, Ventas_DecRecargo.Value );
       SetEditcontrolsDecimals( [ PrecioVentaIVACtrl, OfertaPrecioVentaIVACtrl ] );
       SetEditcontrolDecimals( CantidadMinimaVentaCtrl, Ventas_DecCantidad.Value );
       
       FijarMedidasCtrl.Enabled := ( Ventas_Cantidades.Value>0 ) or Articulo_EditarMedidas.Value;
       UnidadesPorCajaCtrl.Enabled := Articulo_Cajas.Value;
       PuntoVerdeCtrl.Enabled := Articulo_PuntoVerde.Value;
       Recargo_VentaCtrl.Enabled := Ventas_Recargos.Value;

       UnidadesPrecioCompraCtrl.Enabled := Articulo_UnidadesPorPrecio.Value;
       Precio_VentaCtrl.Enabled := not Articulo_PreciosIVA.Value;
       PrecioVentaIVACtrl.Enabled := Articulo_PreciosIVA.Value;
       UnidadesPrecioVentaCtrl.Enabled := Articulo_UnidadesPorPrecio.Value;
       NoAplicarRetencionCtrl.Enabled := Contable_Retenciones.Value;
       CodigoAlmacenCtrl.Enabled := Stock_MultiAlmacen.Value;
       UnidadesPorPalletCtrl.Enabled := Articulo_Pallets.Value;
       BultosCtrl.Enabled := Articulo_Bultos.Value;
       KilosCtrl.Enabled := Articulo_Bultos.Value;
       VolumenCtrl.Enabled := Articulo_Bultos.Value;

       If   not ValueIsEmpty( Ventas_NombreRecargos.Value )
       then RecargoLabel.Caption := Ventas_NombreRecargos.Value;

       If   Articulo_CamposLibres.Value
       then ActivaCamposLibres( [ CampoLibre1Ctrl, CampoLibre2Ctrl, CampoLibre3Ctrl,
                                  CampoLibre4Ctrl, CampoLibre5Ctrl, CampoLibre6Ctrl,
                                  CampoLibre7Ctrl, CampoLibre8Ctrl, CampoLibre9Ctrl,
                                  CampoLibre10Ctrl, CampoLibre11Ctrl, CampoLibre12Ctrl,
                                  CampoLibre13Ctrl, CampoLibre14Ctrl, CampoLibre15Ctrl,
                                  CampoLibre16Ctrl ] );

       // Almacen

       ExistenciasArticuloPanel.Visible := Articulo_StockMinMaxPorAlmacen.Value;

       SetColumnsDecimals( [ ExistenciasArticuloTableViewStockMinimo, ExistenciasArticuloTableViewStockMaximo ], Ventas_DecCantidad.Value );
     
       // Tarifas de compras

       SetColumnDecimals( TarifaComprasTableViewPrecio, Compras_DecPrecio.Value );
       SetColumnDecimals( TarifaComprasTableViewDescuento, Compras_DecDto.Value );

       PageControlChange( nil );

       end;

end;

procedure TMntArtForm.FormManagerInsertRecRequest;
begin
     var Plantilla := CodigoCtrl.EditingValue;
     If   Pos( '#', Plantilla )=0
     then ShowNotification( ntInformation, RsMsg12, RsMsg13 )
     else FormManager.InsertNewAutoIncrementRecord;
end;

procedure TMntArtForm.ArticuloTableAfterEdit(DataSet: TDataSet);
begin

     // Para actualizar los registros ya existentes que no tengan asignada la fecha de alta

     With ArticuloFields.FechaAlta do
       If   ValueIsEmpty( Value )
       then Value := ApplicationContainer.TodayDate;
end;

procedure TMntArtForm.ArticuloTableBeforeDelete(DataSet: TDataSet);

var ExistenciasArticulo : IExistenciasArticulo;

begin
     ExistenciasArticulo := StockAlmacen.ObtenStock( ArticuloFields.Codigo.Value, False, '', '', '', True, '', True, '', True, '', False, ApplicationContainer.Ejercicio, 0, ApplicationContainer.NroMesFinal );

     With ExistenciasArticulo.SumaExistencias do
       If   ( PendienteRecibir<>0.0 ) or
            ( PendienteServir<>0.0 ) or
            ( Entradas<>0.0 ) or
            ( Salidas<>0.0 ) or
            ListaMateriales.EsComponente( ArticuloFields.Codigo.Value )
       then begin
            ShowNotification( ntStop, RsMsg1, RsMsg2 );
            Abort;
            end;

     Articulo.SuprimeReferencias( ArticuloFields.Codigo.Value );

end;

procedure TMntArtForm.ArticuloTableBeforePost(DataSet: TDataSet);

var  ImageSize : Integer;

begin

     With ArticuloFields do
       If   Descripcion.IsNull
       then Descripcion.Value := '';

     FOnArticuloBeforePost.Invoke( Dataset );

     {
     ImageSize := ArticuloTableImagen.BlobSize;
     If   ImageSize>BigImageSize
     then ShowNotification( ntWarning, RsMsg9, Format( RsMsg10, [ ImageSize div 1024 ] ) );
     }

     ApplicationContainer.ProcessRecordChangesLog( ArticuloTable, frdArticulo );

end;

procedure TMntArtForm.ArticuloTableGetRecord(DataSet: TDataSet);
begin

     TarifaComprasQuery.RefreshQuery( { OnlyIfActive } True );
     ExistenciasArticuloQuery.RefreshQuery( { OnlyIfActive } True );

     ActualizaEstadoComponentes;
end;

procedure TMntArtForm.ActualizaEstadoComponentes;
begin
     OnActualizaEstadoComponentes.Invoke;
end;

procedure TMntArtForm.ActualizaPreciosCalculados;
begin
     If   Assigned( ArticuloFields.Precio_Venta ) and
          Assigned( DsTiposIVAFields.IVARepercutido )
     then begin
          PrecioVentaIVACtrl.EditValue := Redondea( ArticuloFields.Precio_Venta.Value + ( ArticuloFields.Precio_Venta.Value * DsTiposIVAFields.IVARepercutido.Value / 100.0 ) );
          OfertaPrecioVentaIVACtrl.EditValue := Redondea( ArticuloFields.OfertaPrecioVenta.Value + ( ArticuloFields.OfertaPrecioVenta.Value * DsTiposIVAFields.IVARepercutido.Value / 100.0 ) );
          end;
end;

procedure TMntArtForm.ArticuloTableNewRecord(DataSet: TDataSet);
begin
     With ArticuloFields do
       begin
       FechaAlta.Value := ApplicationContainer.TodayDate;
       TipoIVA.Value := 1;
       UnidadesPorCaja.Value := 1.0;
       UnidadesPorPallet.Value := 1.0;
       UnidadesPrecioCompra.Value := 1;
       UnidadesPrecioVenta.Value := 1;

       CodigoBarras.Value := Codigo.Value;

       NoAfectarStock.Value := False;
       NoCalcularMargen.Value := False;
       FijarMedidas.Value := False;
       NoAplicarTipoFijo.Value := False;
       NoAplicarRetencion.Value := False;

       EsListaMateriales.Value := False;
       Obsoleto.Value := False;
       Desglosar.Value := False;
       CalcularPrecios.Value := False;
       CampoLibre9.Value := False;
       Oferta.Value := False;
       MostrarAviso.Value := False;

       Tienda_NombreImagen.Value := ValidFileName( Codigo.Value );
       end;

end;

procedure TMntArtForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TMntArtForm.CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   ValueIsEmpty( DisplayValue )
     then CodigoAlmacenCtrl.Description := RsAlmacenGenerico
     else Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtForm.CodigoBarrasCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntCodigosBarras( [ Sender.EditingValue ] );
end;

procedure TMntArtForm.CodigoBarrasCtrlPropertiesExtendedFunction(Sender: TcxCustomEdit);

var  ValorActual : Integer;

begin
     If   ( ( CodigoBarrasCtrl.EditingValue='' ) or ShiftKey )
     then begin
          If   ShiftKey
          then begin
               ValorActual := StrToIntDef( Copy( CodigoBarrasCtrl.EditingValue, 1, 5 ), 0 );
               SysUtils.Beep;
               end
          else ValorActual := 0;
          ArticuloFields.CodigoBarras.Value := StrIntPadded( Contadores.Incrementa( cnCodigoBarras, 0, 'EAN5', ValorActual, 1, 99999 ), 5 );
          end
     else ArticuloFields.CodigoBarras.Value := Articulo.CompruebaEAN13( VarToStr( CodigoBarrasCtrl.EditingValue ), CodigoBarrasCtrl );
     CodigoBarrasCtrl.SelectAll;
end;

procedure TMntArtForm.CodigoBarrasCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaCodigosBarras( ArticuloFields.Codigo.Value, Sender );
end;

procedure TMntArtForm.CodigoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, True, Sender, qgsLinked );
end;

procedure TMntArtForm.CodigoProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntArtForm.CodigoProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntArtForm.CodigoProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtForm.OfertaCtrlPropertiesEditValueChanged(Sender: TObject);

var  Oferta : Boolean;

begin
     Oferta := VarToBoolean( OfertaCtrl.EditValue );

     OfertaFechaInicialCtrl.Enabled := Oferta;
     OfertaFechaFinalCtrl.Enabled := Oferta;
     OfertaPrecioVentaCtrl.Enabled := Oferta;
     OfertaPrecioVentaIVACtrl.Enabled := Oferta and DataModule00.DmEmpresaFields.Articulo_PreciosIVA.Value;
     OfertaDescuentoCtrl.Enabled := Oferta;

end;

procedure TMntArtForm.OfertaPrecioVentaIVACtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  PrecioVenta : Double;

begin
     If   Sender.Editing and Sender.ModifiedAfterEnter
     then begin
          FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields, DsTiposIVAFields );
          Movimiento.ObtenPrecioVentaBase( DsTiposIVAFields,
                                           1,
                                           VarAsType( DisplayValue, varDouble ),
                                           PrecioVenta,
                                           False );
          ArticuloFields.OfertaPrecioVenta.Value := PrecioVenta
          end;
end;

procedure TMntArtForm.FormManagerReportRequest;
begin
     If   DataModule00.DmEmpresaFields.Articulo_StockMinMaxPorAlmacen.Value
     then ShowButtonMenu( ReportFormsPopupMenu, ApplicationContainer.ReportButton )
     else ListadoArticulos;
end;

procedure TMntArtForm.FormManagerUpdateButtonsState;
begin
     PaisesIVAButton.Enabled := ArticuloTable.Editing;
end;

procedure TMntArtForm.ListadoUbicacionesStocksItemClick(Sender: TObject);
begin
     ListadoUbicacionArticulos;
end;

procedure TMntArtForm.ListaoArticulosItemClick(Sender: TObject);
begin
     ListadoArticulos;
end;

procedure TMntArtForm.MargenComercialCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   ( VarToDecimal( DisplayValue )>=100.0 ) and not DataModule00.DmEmpresaFields.Articulo_MargenSobrePrecioCompra.Value
     then begin
          Error := True;
          ErrorText := JoinMessage( RsMsg7, RsMsg8 );
          end;
end;

procedure TMntArtForm.MostrarProveedoresConDatosCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     TarifaComprasQuery.RefreshQuery( { OnlyIfActive } True );
end;

procedure TMntArtForm.MovimientosButtonClick(Sender: TObject);
begin
     FichaArticulos( [ ArticuloFields.Codigo.Value ] );
end;

procedure TMntArtForm.NoAfectarStockCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CodigoAlmacenCtrl.Enabled := not NoAfectarStockCtrl.Checked;
     UbicacionCtrl.Enabled := not NoAfectarStockCtrl.Checked and DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value;
     Stock_MinimoCtrl.Enabled := not NoAfectarStockCtrl.Checked;
     Stock_MaximoCtrl.Enabled := not NoAfectarStockCtrl.Checked;
     If   NoAfectarStockCtrl.Editing and ( ArticuloTable.State=dsEdit ) and Movimiento.ExisteMovimientoArticulo( tmNoDefinido, ArticuloFields.Codigo.Value, ApplicationContainer.FirstDayOfYearDate, ApplicationContainer.LastDayOfYearDate )
     then ShowNotification( ntWarning, RsMsg5, rsMsg6 );
end;

procedure TMntArtForm.NombreImagenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     {
     If   NombreImagenCtrl.Editing and not FileExists( AddPathDelim( TiendaVirtualModule.DirectorioImagenes, DisplayValue )
     then begin
          Error := true;
          ErrorText := RsMsg13;
          end;
     }
end;

procedure TMntArtForm.TarifaComprasQueryAfterOpen(DataSet: TDataSet);
begin
     With TarifaComprasCachedDataset do
       begin
       Close;
       Open;
       end;
end;

procedure TMntArtForm.TarifaComprasQueryBeforeOpen(DataSet: TDataSet);
begin
     // :TodosLosProveedores
     TarifaComprasQuery.Params[ 1 ].Value := not MostrarProveedoresConDatosCtrl.Checked;
end;

procedure TMntArtForm.TarifaComprasCachedDataSetBeforePost(DataSet: TDataSet);

var  ExisteTarifaArticulo : Boolean;

begin
     With TarifaComprasTable, TarifaComprasFields do
       begin

       ExisteTarifaArticulo := FindKey( [ rtcProveedorArticulo, ArticuloFields.Codigo.Value,  TarifaComprasCachedDatasetCodigo.Value ] );

       If   ( TarifaComprasCachedDatasetReferencia.Value='' ) and
            ( TarifaComprasCachedDatasetPrecio.Value=0.0 ) and
            ( TarifaComprasCachedDatasetDescuento.Value=0.0 )
       then begin
            If   ExisteTarifaArticulo
            then TarifaComprasTable.Delete;
            end
       else begin

            If   not ExisteTarifaArticulo
            then begin
                 Append;
                 Tipo.Value := rtcProveedorArticulo;
                 CodigoProveedor.Value := TarifaComprasCachedDatasetCodigo.Value;
                 CodigoArticulo.Value := ArticuloFields.Codigo.Value;
                 end
            else Edit;

            Referencia.Value := TarifaComprasCachedDatasetReferencia.Value;
            Precio.Value := TarifaComprasCachedDatasetPrecio.Value;
            Descuento .Value := TarifaComprasCachedDatasetDescuento.Value;

            Post;
            end;

       end;
end;



procedure TMntArtForm.PageControlChange(Sender: TObject);
begin

     // Se trata de que solo estén activadas las rejillas de las tablas cuando son visibles sus pestañas
     // para evitar tráfico y carga inútil

     TarifaComprasQuery.Active := PageControl.ActivePage=TarifaComprasTabSheet;
     TarifaComprasDataSource.Enabled := TarifaComprasQuery.Active;

     ExistenciasArticuloQuery.Active := DataModule00.DmEmpresaFields.Articulo_StockMinMaxPorAlmacen.Value and ( PageControl.ActivePage=AlmacenTabSheet );
     ExistenciasArticuloDataSource.Enabled := ExistenciasArticuloQuery.Active;

     FOnPageChanged.Invoke( PageControl.ActivePage );

end;

procedure TMntArtForm.PaisesIVAButtonClick(Sender: TObject);
begin
     MntTiposIVAArticuloPais( [ ArticuloFields.Codigo.Value ] );
end;

procedure TMntArtForm.PrecioVentaIVACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  PrecioVenta : Double;
     PrecioVentaIVA : Decimal;

begin
     If   Sender.Editing and Sender.ModifiedAfterEnter
     then If   not ValueIsEmpty( DisplayValue )
          then begin
               FacturaVentas.ObtenTipoIVAArticulo( ApplicationContainer.TodayDate, ArticuloFields, DsTiposIVAFields );
               Movimiento.ObtenPrecioVentaBase( DsTiposIVAFields, 1, VarAsType( DisplayValue, varDouble ), PrecioVenta, False );
               ArticuloFields.Precio_Venta.Value := PrecioVenta
               end
          else ArticuloFields.Precio_Venta.Value := 0.0;
end;

procedure TMntArtForm.Precio_CompraEditValueChanged(Sender: TObject);

var  PrecioCompra : Decimal;

begin
     If   TcxCustomEdit( Sender ).Editing  // Lo llamo desde varios sitios
     then If   ArticuloFields.MargenComercial.Value<>0.0
          then begin
               ArticuloFields.Precio_Venta.Value := Articulo.CalculaPrecioSobreMargenCompra( ArticuloFields.Precio_Compra.Value,
                                                                                             ArticuloFields.Dto_Compra.Value,
                                                                                             ArticuloFields.MargenComercial.Value );
               ActualizaPreciosCalculados;
               end;
end;

procedure TMntArtForm.Precio_VentaCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   Precio_VentaCtrl.Editing
     then ActualizaPreciosCalculados;
end;

procedure TMntArtForm.RejillaButtonClick(Sender: TObject);
begin
     SeleccionRejillaEdicionArticulos;
end;

procedure TMntArtForm.FamiliaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFamilias( [ Sender.EditingValue ] );
end;

procedure TMntArtForm.FamiliaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFamilias( Sender );
end;

procedure TMntArtForm.FamiliaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Familia.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntArtForm.FijarMedidasCtrlPropertiesEditValueChanged(Sender: TObject);

var  FijarMedidas : Boolean;

begin
     With FijarMedidasCtrl, DataModule00.DmEmpresaFields do
       begin
       FijarMedidas := VarToBoolean( EditValue );
       LargoCtrl.Enabled := FijarMedidas and ( ( Ventas_Cantidades.Value>0 ) or ( Compras_Cantidades.Value>0 ) or Articulo_EditarMedidas.Value );
       AnchoCtrl.Enabled := FijarMedidas and ( ( Ventas_Cantidades.Value>0 ) or ( Compras_Cantidades.Value>0 ) or Articulo_EditarMedidas.Value );
       AltoCtrl.Enabled := FijarMedidas and ( ( Ventas_Cantidades.Value>1 ) or ( Compras_Cantidades.Value>1 ) or Articulo_EditarMedidas.Value );
       end;
end;

procedure TMntArtForm.FormManagerAfterValidateDataArea(FieldArea: TFieldArea; var ErrorText : TCaption; var ErrorResult : Boolean; NotifyError, UpdateData: Boolean;out InvalidCustomEdit : TcxCustomEdit);
begin                                                                                                                               
     ActualizaPreciosCalculados;
end;

function TMntArtForm.FormManagerCopyCurrentRecord: Boolean;
begin
     CopiaArticulo( DoOnCopiaRegistro );
     Result := False;
end;

procedure TMntArtForm.DocumentosExternosButtonClick(Sender: TObject);
begin
     If   ArticuloFields.DocumentosExternos.Value=''
     then ShowNotification( ntWarning, RsMsg16 )
     else OpenFolder( ArticuloFields.DocumentosExternos.Value );
end;

procedure TMntArtForm.DoOnCopiaRegistro;
begin
     With ArticuloTable do
       begin
       If   FindKey( [ ArticuloFields.Codigo.Value ] )
       then begin
            If   not Articulo.Existe( BoxCrtForm.DataCodigo.Value )
            then CloneRecord( [ BoxCrtForm.DataCodigo.Value ] )
            else ShowNotification( ntStop, Format( RsMsg11, [ BoxCrtForm.DataCodigo.Value ] ), '' );
            end
       else ShowNotification( ntStop, RsgMsg430, '' );
       Cancel;
       end;
end;

procedure TMntArtForm.ExaminarButtonClick(Sender: TObject);
begin
     SelectDirectory( ArticuloFields.DocumentosExternos );
end;

procedure TMntArtForm.ExistenciasArticuloCachedDataSetBeforePost(DataSet: TDataSet);
begin
     With ExistenciasArticuloTable, ExistenciasArticuloFields do
       begin

       If   not FindKey( [ ArticuloFields.Codigo.Value, ExistenciasArticuloCachedDatasetCodigoAlmacen.Value ] )
       then begin
            Append;
            CodigoArticulo.Value := ArticuloFields.Codigo.Value;
            CodigoAlmacen.Value := ExistenciasArticuloCachedDatasetCodigoAlmacen.Value;            
            end
       else Edit;

       Ubicacion.Value := ExistenciasArticuloCachedDatasetUbicacion.Value;
       StockMinimo.Value := ExistenciasArticuloCachedDatasetStockMinimo.Value;
       StockMaximo.Value := ExistenciasArticuloCachedDatasetStockMaximo.Value;            
              
       ApplicationContainer.ProcessRecordChangesLog( ExistenciasArticuloCachedDataset, frdExistenciasArticulo, ExistenciasArticuloTable );

       Post;
       end;
end;

procedure TMntArtForm.ExistenciasArticuloQueryAfterOpen(DataSet: TDataSet);
begin
     With ExistenciasArticuloCachedDataset do
       begin
       Close;
       Open;
       end;
end;

procedure TMntArtForm.ExistenciasArticuloTableViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntUbicaciones( [ ExistenciasArticuloCachedDataSetCodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntArtForm.ExistenciasArticuloTableViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaUbicaciones( ExistenciasArticuloCachedDataSetCodigoAlmacen.Value, ubTodas, Sender );
end;

procedure TMntArtForm.ExistenciasArticuloTableViewUbicacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not ValueIsEmpty( DisplayValue )
     then Ubicacion.Valida( ExistenciasArticuloCachedDataSetCodigoAlmacen.Value, True, Sender, DisplayValue, ErrorText, Error );
end;

function TMntArtForm.FormManagerGetAccessLevel: SmallInt;
begin
     With dataModule00.DmUsuarioFields do
       If   ProgramNumber=pnTPV
       then Result := acCAFicheros.Value
       else Result := checkAccessLevel( [ acALFicheros.Value, acALArticulos.Value ] );
end;

procedure TMntArtForm.FormManagerLabelsRequest;
begin
     EtiquetasArticulos( ArticuloFields.Codigo.Value );
end;

procedure TMntArtForm.datEconButtonClick(Sender: TObject);
begin
     ArticuloTable.Cancel;
     DatosEconomicosArticulos( [ ArticuloFields.Codigo.Value ] );
end;

procedure TMntArtForm.TipoIVACtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposIVA( True );
end;

procedure TMntArtForm.TipoIVACtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposIVA( Sender, siAmbos, ApplicationContainer.TodayDate );
end;

procedure TMntArtForm.TipoIVACtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Tasa.ValidaTasa( Sender, DisplayValue, ErrorText, Error, siAmbos, ApplicationContainer.TodayDate, '', DsTiposIVAFields );
end;

procedure TMntArtForm.UbicacionCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value
     then MntUbicaciones( [ ArticuloFields.CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntArtForm.UbicacionCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If   DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value
     then ConsultaUbicaciones( ArticuloFields.CodigoAlmacen.Value, ubNormal, Sender );
end;

procedure TMntArtForm.UbicacionCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     If   DataModule00.DmEmpresaFields.Stock_Ubicaciones.Value
     then Ubicacion.Valida( ArticuloFields.CodigoAlmacen.Value, False, Sender, DisplayValue, ErrorText, Error );
end;

end.

