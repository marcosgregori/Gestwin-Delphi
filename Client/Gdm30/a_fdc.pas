unit a_fdc;

interface

uses Grids, StdCtrls, Buttons, Mask, Controls, graphics,
  Classes, ExtCtrls, Forms, Tabs, ComCtrls,
  Menus,
  cxLookAndFeelPainters,
  cxButtons, cxPC, cxControls, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, cxCurrencyEdit, cxContainer, cxEdit, cxTextEdit, nxdb, DB,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxLabel, cxDBLabel, cxCheckBox, cxMemo, cxRichEdit, cxDBRichEdit,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxGroupBox,
  cxLookAndFeels, f_not, cxPCdxBarPopupMenu, cxNavigator, cxIndexedComboBox,
  cxIntegerEdit, dxBarBuiltInMenu, cxSpinEdit, dxBar, dxDateRanges,

  AppContainer,
  DataManager,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  AppForms,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMntFdcForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    SerieNroFacturaCtrl: TcxDBTextEdit;
    dataPanel: TgxEditPanel;
    PageControl: TcxPageControl;
    TabSheet1: TcxTabSheet;
    TabSheet2: TcxTabSheet;
    ProveedorCtrl: TcxDBTextEdit;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    DocPagoButton: TgBitBtn;
    FacturaComprasTable: TnxeTable;
    FacturaComprasDataSource: TDataSource;
    EfectosQuery: TnxeQuery;
    EfectosDataSource: TDataSource;
    LockRangeButton: TgxLockRangeButton;
    LineasAlbaranQuery: TnxeQuery;
    LineasAlbaranQueryCabeceraDocumento: TWideStringField;
    LineasAlbaranQueryEjercicio: TSmallintField;
    LineasAlbaranQueryNroOperacion: TIntegerField;
    LineasAlbaranQueryNroDocumento: TIntegerField;
    LineasAlbaranQueryNroLinea: TSmallintField;
    LineasAlbaranQueryFecha: TDateField;
    LineasAlbaranQueryNroRegistro: TLongWordField;
    LineasAlbaranQueryAsignacionOrigen: TSmallintField;
    LineasAlbaranQueryTipoMovimientoOrigen: TSmallintField;
    LineasAlbaranQueryEjercicioOrigen: TSmallintField;
    LineasAlbaranQueryNroOperacionOrigen: TIntegerField;
    LineasAlbaranQueryNroRegistroOrigen: TIntegerField;
    LineasAlbaranQueryUIDArticulo: TGuidField;
    LineasAlbaranQueryCodigoArticulo: TWideStringField;
    LineasAlbaranQueryCodigoClaseA: TWideStringField;
    LineasAlbaranQueryCodigoClaseB: TWideStringField;
    LineasAlbaranQueryCodigoClaseC: TWideStringField;
    LineasAlbaranQueryLoteFabricacion: TWideStringField;
    LineasAlbaranQueryNumeroSerie: TWideStringField;
    LineasAlbaranQueryDescripcion: TWideStringField;
    LineasAlbaranQueryCodigoAlmacen: TWideStringField;
    LineasAlbaranQueryUbicacion: TWideStringField;
    LineasAlbaranQueryCantidad: TBCDField;
    LineasAlbaranQueryCantidadProcesada: TBCDField;
    LineasAlbaranQueryPrecioDivisa: TBCDField;
    LineasAlbaranQueryRecargo: TBCDField;
    LineasAlbaranQueryPuntoVerde: TBCDField;
    LineasAlbaranQueryDescuento: TBCDField;
    LineasAlbaranQueryNroCajas: TBCDField;
    LineasAlbaranQueryLargo: TBCDField;
    LineasAlbaranQueryAncho: TBCDField;
    LineasAlbaranQueryAlto: TBCDField;
    LineasAlbaranQueryNoCalcularMargen: TBooleanField;
    LineasAlbaranQueryAnotacion: TWideMemoField;
    LineasAlbaranDataSource: TDataSource;
    AlbaranesPanel: TcxGroupBox;
    GridTableViewController1: TGridTableViewController;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridViewNroDocumento: TcxGridDBColumn;
    GridViewFecha: TcxGridDBColumn;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewUbicacion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPrecioDivisa: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewRecargo: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    GridLevel: TcxGridLevel;
    Panel1: TcxGroupBox;
    Panel6: TcxGroupBox;
    FormaPagoCtrl: TcxDBTextEdit;
    DescuentoESCtrl: TcxDBCurrencyEdit;
    DescuentoPPCtrl: TcxDBCurrencyEdit;
    RecargoFinancieroCtrl: TcxDBCurrencyEdit;
    CuotaIVACtrl: TcxDBCurrencyEdit;
    Panel7: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    FechaRecepcionCtrl: TcxDBDateEdit;
    DesglosarAlbaranesCtrl: TcxCheckBox;
    EfectoPagarTable: TnxeTable;
    EfectoTable: TnxeTable;
    EfectosQueryNroEfecto: TSmallintField;
    EfectosQueryFechaVencimiento: TDateField;
    EfectosQueryImporte: TBCDField;
    EfectosQueryFechaEmision: TDateField;
    EfectosQueryFechaPago: TDateField;
    EfectosQueryImportePagado: TBCDField;
    Label2: TcxLabel;
    EstadoLabel: TcxLabel;
    Label3: TcxLabel;
    Label40: TcxLabel;
    TituloDocumentoLabel: TcxLabel;
    Label5: TcxLabel;
    Label6: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    Label25: TcxLabel;
    Label4: TcxLabel;
    Label27: TcxLabel;
    Label36: TcxLabel;
    Label13: TcxLabel;
    Label14: TcxLabel;
    Label15: TcxLabel;
    GridViewEjercicio: TcxGridDBColumn;
    LineasAlbaranQueryImporteNeto: TBCDField;
    LineasAlbaranQueryNroPagina: TSmallintField;
    LineasAlbaranQueryPrecio: TFloatField;
    cxLabel1: TcxLabel;
    LineasAlbaranQueryImporteTotal: TBCDField;
    GridViewAnotacion: TcxGridDBColumn;
    cxGroupBox1: TcxGroupBox;
    Label24: TcxLabel;
    Label28: TcxLabel;
    descTipoRetencionLabel: TcxLabel;
    capTipoLabel: TcxLabel;
    cxGroupBox2: TcxGroupBox;
    ImportePendienteLabel: TcxLabel;
    ImporteEfectosLabel: TcxLabel;
    Panel5: TcxGroupBox;
    EfectosGrid: TcxGrid;
    EfectosGridView: TcxGridDBTableView;
    EfectosGridViewNroEfecto: TcxGridDBColumn;
    EfectosGridViewFechaVencimiento: TcxGridDBColumn;
    EfectosGridViewImporte: TcxGridDBColumn;
    EfectosGridViewFechaEmision: TcxGridDBColumn;
    EfectosGridViewFechaPago: TcxGridDBColumn;
    EfectosGridViewImportePagado: TcxGridDBColumn;
    EfectosGridLevel: TcxGridLevel;
    GridTableViewController: TGridTableViewController;
    cxTabSheet1: TcxTabSheet;
    FacturaTable: TnxeTable;
    FacturaDataSource: TDataSource;
    OrigenLabel: TcxLabel;
    DatosFiscalesTS: TcxTabSheet;
    DetalleDatosFiscalesPanel: TcxGroupBox;
    EjercicioFraRectificadaCtrl: TcxDBSpinEdit;
    SerieFraRectificadaCtrl: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    FechaFraRectificadaBox: TcxLabel;
    AnnotationFrame1: TAnnotationFrame;
    LineasAlbaranQuerySerie: TWideStringField;
    DtoComercialBox: TcxLabel;
    DtoPPBox: TcxLabel;
    ImporteRecFinancieroBox: TcxLabel;
    NetoFacturaBox: TcxLabel;
    TotalFacturaBox: TcxLabel;
    PortesBox: TcxLabel;
    NetoArticulosBox: TcxLabel;
    BaseCalculoRetencionBox: TcxLabel;
    TipoRetencionBox: TcxLabel;
    ImporteRetencionBox: TcxLabel;
    ImportePendienteBox: TcxLabel;
    ImporteEfectosBox: TcxLabel;
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
    BloqueoPagosPanel: TcxGroupBox;
    Pago_BloqueadoCtrl: TcxDBCheckBox;
    Pago_MotivoBloqueoCtrl: TcxDBRichEdit;
    MotivoLabel: TcxLabel;
    BloquearPagoItem: TdxBarButton;
    cxGroupBox5: TcxGroupBox;
    cxLabel2: TcxLabel;
    NroRegistroCtrl: TcxDBSpinEdit;
    BrowseFacturaComprasTable: TnxeTable;
    InformacionFiscalBox: TcxGroupBox;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    InversionSujetoPasivoCtrl: TcxCheckBox;
    cxLabel15: TcxLabel;
    TipoFacturaCtrl: TcxDBIndexedComboBox;
    RegimenOTrascendenciaCtrl: TcxDBIndexedComboBox;
    TotalesPanel: TcxGroupBox;
    EditarAlbaranItem: TdxBarButton;
    CaptionsPanel: TcxGroupBox;
    procedure FormManagerInitializeForm;
    procedure FormManagerReportRequest;
    procedure FormManagerActivateForm;
    procedure FormManagerReportFormRequest;
    procedure DocPagoButtonClick(Sender: TObject);
    procedure RegistroIVAItemClick(Sender: TObject);
    procedure AsientoItemClick(Sender: TObject);
    procedure FacturaComprasTableBeforeDelete(DataSet: TDataSet);
    procedure FacturaComprasTableUpdateState(DataSet: TDataSet);
    procedure FacturaComprasTableSetKey(DataSet: TDataSet);
    procedure FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormaPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieNroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FacturaComprasTableRecordChanged(DataSet: TDataSet);
    procedure ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure EfectosGridExit(Sender: TObject);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FechaRecepcionCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EfectosGridViewFechaVencimientoPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure FacturaCtrlPropertiesValuePosted(Sender: TObject);
    procedure FormaPagoCtrlPropertiesValuePosted(Sender: TObject);
    procedure GridTableViewControllerDelete(Sender: TObject);
    procedure AnotacionButtonClick(Sender: TObject);
    function FacturaComprasTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure LineasAlbaranQueryAfterClose(DataSet: TDataSet);
    procedure LineasAlbaranQueryAfterOpen(DataSet: TDataSet);
    procedure GridTableViewController1UserSelection(Sender: TObject; var AHandled : Boolean);
    procedure DesglosarAlbaranesCtrlPropertiesChange(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure FacturaComprasTableAfterDelete(DataSet: TDataSet);
    procedure EfectosQueryBeforeOpen(DataSet: TDataSet);
    procedure FormManagerPreparedForm;
    procedure EfectosQueryCalcFields(DataSet: TDataSet);
    procedure GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure EditarEfectoItemClick(Sender: TObject);
    procedure EfectosGridViewDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure FormManagerUpdateButtonsState;
    procedure FacturaComprasTableNewRecord(DataSet: TDataSet);
    procedure GridViewNroDocumentoGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure PopupMenuPopup(Sender: TObject);
    procedure FichaMovimientosArticuloItemClick(Sender: TObject);
    procedure TrazaItemClick(Sender: TObject);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure FacturaComprasTableAfterEdit(DataSet: TDataSet);
    procedure FacturaComprasTableAfterInsert(DataSet: TDataSet);
    procedure FacturaTableNewRecord(DataSet: TDataSet);
    function FacturaTableSetLinkRange(DataSet: TDataSet) : SmallInt;
    procedure TipoFacturaRegimenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure FacturaRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure FacturaRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure RegimenOTrascendenciaCtrlPropertiesChange(Sender: TObject);
    procedure InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure BloquearPagoItemClick(Sender: TObject);
    procedure FormManagerQueryGridRequest;
    procedure SerieNroFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoFacturaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure EditarAlbaranItemClick(Sender: TObject);
    procedure FormManagerShowCantEditMessage;
  private

    LineaMovimientoFields : TLineaMovimientoFields;
    FormaPagoFields : TFormaPagoFields;

    FCambiandoOrigen,
    FRecalculandoFactura : Boolean;

    procedure EditarEfectoPagar;
    procedure ObtenProveedor;
    procedure SetFacturaKeyFields;
    procedure UpdatePageControlState;
    procedure DoOnSelectFacturaRectificada( Target : TcxCustomEdit = nil );

  public

    AsientoFields : TAsientoFields;
    EfectoFields : TEfectoFields;
    EfectoPagarFields : TEfectoPagarFields;
    FacturaComprasFields,
    FacturaRectificadaFields  : TFacturaComprasFields;
    FacturaFields : TFacturaFields;
    ProveedorFields : TProveedorFields;
    RemesaPagoFields : TRemesaPagoFields;
    PaisFields : TPaisFields;
    DsDivisaFields : TDivisaFields;

    procedure DoSeleccionAlbaranes;
    procedure Recalculo;
    procedure ActualizaDatosFactura;
    procedure MuestraDatosFactura;
    procedure ActualizaRejilla;
  end;

var  MntFdcForm: TMntFdcForm = nil;

procedure MntFacturasCompra( Values : array of const );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       cxDateUtils,
       dxCalendarUtils,
       LibUtils,
       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Frm,

       dmi_iva,
       dmi_mov,
       dmi_fac,

       ParametrosFacturacionIntf,

       dmi_ast,

       b_msg,
       bx_not,

       dm_reg,
       dm_pai,
       dm_pga,
       dm_art,
       dm_pro,
       dm_tma,
       dm_fdc,
       dm_mov,
       dm_fpa,
       dm_sdf,
       dm_iva,
       dm_ast,
       dm_cdi,
       dm_ecp,
       dm_fac,
       dm_rdp,

       a_pro,
       a_art,
       a_fpa,
       a_mov,
       a_mco,
       a_ret,
       a_ast,
       a_fcg,
       a_ecp,

       b_sac,
       b_trz,
       b_fda,
       b_bpf,

       cx_art,
       cx_pro,
       cx_fpa,
       cx_ret,
       cx_fdc,

       i_fdc,
       l_fdc,
       i_dpa;

resourceString
    RsMsg1  = 'Para poder recalcular la factura es necesario que especifique una forma de pago válida.';
    RsMsg2  = 'Esta factura ya ha sido contabilizada.';
    RsMsg3  = 'Si desea editarla tiene que recuperarla mediante la opción correspondiente de [Procesos].';
    RsMsg4  = 'Contabilizada. Asiento nº %d';
    RsMsg5  = '¡Consta como contabilizada pero no existe el asiento contable!';
    RsMsg6  = 'La fecha de vencimiento debe ser igual o superior a la de la factura.';
    RsMsg7  = 'El régimen o trascendencia es incompatible con el origen de la factura.';
    RsMsg8  = 'Asigne un valor distinto.';
    RsMsg9  = '¿Esta seguro de que desea suprimir este efecto?';
    RsMsg10 = 'Recuerde que puede regenerar la lista de efectos modificando la forma de pago de la factura.';
    RsMsg11 = 'No puede utilizar la factura actual como factura rectificada.';
    RsMsg12 = 'No existe ninguna factura con esta serie y número en el ejercicio indicado.';
    RsMsg13 = '¿Está seguro de que desea cambiar el origen de la factura?';
    RsMsg14 = 'Si es así se tendrán que recalcular las cuotas de I.V.A. de los albaranes que incluye.';

    RsMsg23 = 'Debe completar, al menos, uno de los dos campos de la serie-número de la factura.';

    RsMsg25 = 'Esta factura no puede ser editada.';
    RsMsg26 = 'Ya ha sido contabilizada.' ;
    RsMsg27 = 'No pertenece al ejercicio activo.' ;


procedure MntFacturasCompra( Values : array of const );
begin
     CreateEditForm( TMntFdcForm, MntFdcForm, Values, TGds30Frm.ComprasSection );
end;

procedure TMntFdcForm.FormManagerInitializeForm;
begin

     // TituloDocumentoLabel.Style.TextColor := clIconBlue;

     FacturaComprasFields := TFacturaComprasFields.Create( FacturaComprasTable );
     FacturaFields := TFacturaFields.Create( FacturaTable );
     EfectoFields := TEfectoFields.Create( EfectoTable );
     EfectoPagarFields := TEfectoPagarFields.Create( EfectoPagarTable );

     PaisFields := TPaisFields.Create( Self );
     FacturaRectificadaFields := TFacturaComprasFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     RemesaPagoFields := TRemesaPagoFields.Create( Self );
     AsientoFields := TAsientoFields.Create( Self );
     FormaPagoFields := TFormaPagoFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );

     SetBarItemVisible( AsientoItem, ApplicationContainer.IsModuleActive( [ 10 ] ) );

     SetEditControlsDecimals( [ DescuentoESCtrl, DescuentoPPCtrl, RecargoFinancieroCtrl ], 2 );
     SetEditControlDecimals( CuotaIVACtrl );

     SetColumnsDecimals( [ EfectosGridViewImporte, EfectosGridViewImportePagado ] );

     With FacturaComprasTable, FacturaComprasFields do
       begin
       SetBCDFieldsDecimals( [ NetoFactura, Portes, ImportePuntoVerde, ImporteDtoES, ImporteDtoPP,
                               ImporteRecFinanciero, CuotaIVA, TotalFactura, BaseCalculoRetencion,
                               ImporteRetencion ] );

       TipoRetencion.DisplayFormat := '#';
       end;

     // SerieNroFactura forma parte de la clave principal y, por lo tanto, se le aplica un valor por defecto en la inicialización si ValidChars = []

     FacturaComprasFields.SerieNroFactura.ValidChars := SerieNroFacturaCharSet;

     With DataModule00.DmEmpresaFields do
       begin

       GridViewNumeroSerie.Visible := Ventas_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       GridViewCodigoAlmacen.Visible:= Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewPrecioDivisa.Visible := Compras_Divisas.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewPuntoVerde.Visible := Articulo_PuntoVerde.Value;
       GridViewLargo.Visible := Compras_Cantidades.Value>0;
       GridViewAncho.Visible := Compras_Cantidades.Value>0;
       GridViewAlto.Visible := Compras_Cantidades.Value>1;

       SetColumnDecimals( GridViewCantidad, Compras_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewPuntoVerde ], Compras_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Compras_DecDto.Value );
       SetColumnDecimals( GridViewImporte );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Compras_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Compras_DecCajas.Value );

       If   not ValueIsEmpty( DataModule00.DmEmpresaFields.Compras_NombreCajas.Value )
       then If   Compras_Cantidades.Value=2
            then GridViewAlto.Caption := DataModule00.DmEmpresaFields.Compras_NombreCajas.Value
            else GridViewNroCajas.Caption := DataModule00.DmEmpresaFields.Compras_NombreCajas.Value;

       NroRegistroCtrl.Enabled := Contable_NroRegistro.Value;
       
       end;

     BrowseFacturaComprasTable.SetRange( [ ApplicationContainer.FirstDayOfYearDate ], [ ApplicationContainer.LastDayOfYearDate ] );
     FacturaComprasTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );

     SetFieldRange( FacturaFields.NroFacturaRectificada, 0 );

     GridView.Preview.Visible := Registro.ValorUsuarioActivo( ncrMostrarAnotacionesCompras );

     BloqueoPagosPanel.Visible := ApplicationContainer.IsModuleActive( [ 118 ] ) and DataModule00.UserIsACreditManager;
     SetBarItemsVisible( [ BloquearPagoItem ], BloqueoPagosPanel.Visible );

end;

procedure TMntFdcForm.FormManagerPreparedForm;
begin
     EfectosQuery.Open;
     DesglosarAlbaranesCtrl.Checked := True;
end;

procedure TMntFdcForm.FormManagerQueryGridRequest;
begin
     ConsultaFacturasCompra( FacturaComprasFields.Proveedor, SerieNroFacturaCtrl, qgsDetached );
end;

procedure TMntFdcForm.FormManagerReportRequest;
begin
     ListadoFacturasCompra;
end;

procedure TMntFdcForm.FormManagerShowCantEditMessage;

var Msg,
    DescMsg : String;

begin
     Msg := RsMsg25;
     If   FacturaComprasFields.Traspasada.Value
     then DescMsg := RsMsg26
     else If   not EjercicioActual( FacturaComprasFields.Fecha.Value )
          then DescMsg := RsMsg27;
     ShowHintMsg( Msg, DescMsg);
end;

procedure TMntFdcForm.FormManagerUpdateButtonsState;
begin
     DocPagoButton.Enabled := FacturaComprasTable.State=dsBrowse;
     DeleteButton.Enabled := DeleteButton.Enabled and not FacturaComprasFields.Traspasada.Value;
end;

procedure TMntFdcForm.GridTableViewController1UserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MntMovimientosPorNroRegistro( LineasAlbaranQueryNroRegistro.Value );
end;

procedure TMntFdcForm.DoSeleccionAlbaranes;

var   ParametrosFacturacion  : IParametrosFacturacion;

begin

     ParametrosFacturacion := TParametrosFacturacion.Create;

     With ParametrosFacturacion do
       begin

       TipoSeleccion := tsRelacion;

       CodigoPropietario := FacturaComprasFields.Proveedor.Value;
       Serie := FacturaComprasFields.SerieNroFactura.Value;
       UnaSolaFactura := True;
       FechaFacturacion := BoxSacForm.DataFechaFactura.Value;

       With FacturaComprasTable do
         begin
         ParametrosFacturacion := FacturaCompras.GeneraFacturas( ParametrosFacturacion, BoxSacForm.RelacionAlbaranesTable );
         Cancel;
         If   FindKey( [ ApplicationContainer.Ejercicio, CodigoPropietario, Serie ] )
         then FormManager.SelectFirstDataControl;  // Fuerzo un edit
         end;

       end;
end;

procedure TMntFdcForm.BloquearPagoItemClick(Sender: TObject);
begin
     With FacturaComprasFields do
       BloqueoPagosFacturaCompra( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value );
end;

procedure TMntFdcForm.EditarAlbaranItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineasAlbaranQueryNroRegistro.Value );
end;

procedure TMntFdcForm.EditarEfectoItemClick(Sender: TObject);
begin
     EditarEfectoPagar;
end;

procedure TMntFdcForm.EfectosQueryBeforeOpen(DataSet: TDataSet);
begin
     If   Assigned( FacturaComprasFields )
     then With FacturaComprasFields do
            begin
            ObtenProveedor;
            If   Traspasada.Value
            then begin
                 EfectosQuery.SQL.Text := 'SELECT NroEfecto, FechaVencimiento, Importe ' +
                                          'FROM EfectoPagar ' +
                                          'WHERE Ejercicio=' + IntToStr( Ejercicio.Value ) +
                                          ' AND SubcuentaProveedor=' + QuotedStr( ProveedorFields.Subcuenta.Value ) +
                                          ' AND Serie=' + QuotedStr( SerieNroFactura.Value ) +
                                          ' AND NroFactura=0';
                 With EfectosGridView.OptionsData do
                   begin
                   Deleting := False;
                   Editing := False;
                   end;

                 EfectosGridViewFechaPago.Visible := True;
                 EfectosGridViewImportePagado.Visible := True;

                 EfectosGridView.OptionsView.ColumnAutoWidth := True;

                 EfectosGrid.ShowHint := True;
                 EfectosPopupMenu.AutoPopup := True;

                 end
            else begin
                 EfectosQuery.SQL.Text := 'SELECT NroEfecto, FechaVencimiento, Importe ' +
                                          'FROM Efecto ' +
                                          'WHERE Tipo=0 AND Ejercicio=' + IntToStr( Ejercicio.Value ) +
                                          ' AND Propietario=' + QuotedStr( Proveedor.Value ) +
                                          ' AND Serie=' + QuotedStr( SerieNroFactura.Value ) +
                                          ' AND NroDocumento=0';
                 With EfectosGridView.OptionsData do
                   begin
                   Deleting := True;
                   Editing := True;
                   end;

                 EfectosGridViewFechaPago.Visible := False;
                 EfectosGridViewImportePagado.Visible := False;

                 EfectosGridView.OptionsView.ColumnAutoWidth := False;

                 EfectosGrid.ShowHint := False;
                 EfectosPopupMenu.AutoPopup := False;

                 end;

            end;
end;

procedure TMntFdcForm.EfectosQueryCalcFields(DataSet: TDataSet);
begin
     If   Assigned( FacturaComprasFields )
     then With FacturaComprasFields do
            If   Traspasada.Value
            then begin
                 If   EfectoPagarTable.FindKey( [ Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, 0, EfectosQueryNroEfecto.Value ] )
                 then begin

                      If   not ValueIsEmpty( EfectoPagarFields.FechaEmision.Value )
                      then EfectosQueryFechaEmision.Value := EfectoPagarFields.FechaEmision.Value;

                      If   ValueIsEmpty( EfectoPagarFields.FechaPago.Value )
                      then begin
                           If   EfectoPagarFields.NroRemesa.Value<>0
                           then If   RemesaPago.Obten( EfectoPagarFields.Ejercicio.Value, EfectoPagarFields.NroRemesa.Value, RemesaPagoFields )
                                then If   not EfectoPagar.EfectoPendiente( EfectoPagarFields )
                                     then begin
                                          If   not ValueIsEmpty( RemesaPagoFields.FechaPago.Value )
                                          then EfectosQueryFechaPago.Value := RemesaPagoFields.FechaPago.Value;
                                          EfectosQueryImportePagado.Value := EfectosQueryImporte.Value;
                                          end;
                           end
                      else begin
                           EfectosQueryFechaPago.Value := EfectoPagarFields.FechaPago.Value;
                           EfectosQueryImportePagado.Value := EfectosQueryImporte.Value;
                           end;

                      end;
                 end
            else If   EfectoTable.FindKey( [ Ejercicio.Value, scCompras, Proveedor.Value, SerieNroFactura.Value, 0, EfectosQueryNroEfecto.Value ] )
                 then If   EfectoFields.Emitido.Value
                      then EfectosQueryFechaEmision.Value := EfectoFields.FechaEmision.Value;

end;

procedure TMntFdcForm.FacturaComprasTableAfterDelete(DataSet: TDataSet);
begin
     ActualizaMovimientosCompra( tmCompra );
end;

procedure TMntFdcForm.FacturaComprasTableAfterEdit(DataSet: TDataSet);
begin
     With FacturaTable do
       If   FacturaFields.Ejercicio.IsNull
       then begin
            Append;
            PostAndEdit;
            end;
end;

procedure TMntFdcForm.FacturaComprasTableAfterInsert(DataSet: TDataSet);
begin
     FacturaTable.Append;
end;

procedure TMntFdcForm.FacturaComprasTableBeforeDelete(DataSet: TDataSet);
begin
     FacturaCompras.SuprimeRelaciones( FacturaComprasFields, False );
end;

function TMntFdcForm.FacturaComprasTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     If   Assigned( FacturaComprasFields )
     then With FacturaComprasFields do
            Result := not Traspasada.Value and EjercicioActual( FechaRecepcion.Value )
     else Result := True;
end;

procedure TMntFdcForm.FacturaComprasTableNewRecord(DataSet: TDataSet);
begin
     With FacturaComprasFields do
       SeleccionaAlbaranesCompra( Proveedor.Value, SerieNroFactura.Value, DoSeleccionAlbaranes );
end;

procedure TMntFdcForm.ObtenProveedor;
begin
     Proveedor.Obten( FacturaComprasFields.Proveedor.Value, '', ProveedorFields );
end;

procedure TMntFdcForm.FacturaComprasTableRecordChanged(DataSet: TDataSet);
begin
     If   ( csDestroying in ComponentState ) or FacturaComprasTable.ControlsDisabled
     then Exit;

     EstadoLabel.Style.Font.Color := clNavy;

     ObtenProveedor;

     With FacturaComprasFields do
       begin
       If   Traspasada.Value
       then begin
            If   Asiento.ObtenDocumento( taFraRecibida, Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, 0, NroEfectoRegistroFactura, AsientoFields )
            then EstadoLabel.Caption := Format( RsMsg4, [ AsientoFields.NroAsiento.Value ] )
            else begin
                 EstadoLabel.Caption := RsMsg5;
                 EstadoLabel.Style.Font.color := clRed;
                 end;
            end
       else EstadoLabel.Caption := '';

       OrigenLabel.Caption := FacturaCompras.TextoOrigen( FacturaComprasFields.Origen.Value );
       RegimenOTrascendenciaCtrl.Enabled := FacturaComprasFields.Origen.Value<>ofrIntracomunitaria;

       InversionSujetoPasivoCtrl.Enabled := FacturaComprasFields.Origen.Value<>ofrIntracomunitaria;
       InversionSujetoPasivoCtrl.Checked := FacturaComprasFields.Origen.Value=ofrInversionSP;

       ActualizaRejilla;
       MuestraDatosFactura;
       DescTipoRetencionLabel.Caption := Tasa.DescripcionRetencion( Fecha.Value, TipoRetencion.Value );
       end;
end;

procedure TMntFdcForm.ActualizaRejilla;
begin
     With GridView.ViewData do
        If   DesglosarAlbaranesCtrl.Checked
        then Expand( True )
        else Collapse( True );
end;

procedure TMntFdcForm.FacturaComprasTableSetKey(DataSet: TDataSet);
begin
     FacturaComprasFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
     MuestraDatosFactura;
end;

procedure TMntFdcForm.FacturaComprasTableUpdateState(DataSet: TDataSet);
begin
     EfectosDataSource.Enabled := FacturaComprasTable.State<>dsSetKey;
     LineasAlbaranDataSource.Enabled := not ( FacturaComprasTable.State in [ dsSetKey, dsInsert ] );
end;

procedure TMntFdcForm.UpdatePageControlState;
begin
     SetGroupBoxControlsEnabled( DetalleDatosFiscalesPanel, TipoFacturaCtrl.ItemIndex in [ tfrRectificativa_80_1_2..tfrRectificativaSimplificada ] );  // Si no se desactiva se intentará validar
end;

procedure TMntFdcForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error, True );
     Tasa.CompruebaCambioTipoImpositivo( siSoportado, DisplayValue, FacturaComprasFields.Fecha.Value, ErrorText, Error );
end;

procedure TMntFdcForm.FacturaCtrlPropertiesValuePosted(Sender: TObject);
begin
     With Sender as TcxCustomEdit do
       If   Editing
       then ActualizaDatosFactura;
end;

procedure TMntFdcForm.FacturaTableNewRecord(DataSet: TDataSet);
begin
     SetFacturaKeyFields;

     Factura.CompletaRegistroFacturaRecibida( ProveedorFields.Subcuenta.Value,
                                              ProveedorFields.CodigoPais.Value,
                                              ProveedorFields.Factura_ModeloIVA.Value,
                                              FacturaFields );
end;

function TMntFdcForm.FacturaTableSetLinkRange(DataSet: TDataSet) : SmallInt;
begin
     SetFacturaKeyFields;
     Result := 5;
end;

procedure TMntFdcForm.SetFacturaKeyFields;
begin
     If   Assigned( FacturaFields )
     then With FacturaFields do
            begin
            Tipo.Value := tfFacturaCompras;
            Ejercicio.Value := FacturaComprasFields.Ejercicio.Value;
            Propietario.Value := FacturaComprasFields.Proveedor.Value;
            SerieFactura.Value := FacturaComprasFields.SerieNroFactura.Value;
            NroRegistro.Value := 0;
            end;
end;

procedure TMntFdcForm.FechaRecepcionCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntFdcForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntFdcForm.FichaMovimientosArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TMntFdcForm.FormaPagoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntFormasPago( [ Sender.EditingValue ] );
end;

procedure TMntFdcForm.FormaPagoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFormasPago( Sender );
end;

procedure TMntFdcForm.FormaPagoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     FormaPago.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntFdcForm.FormaPagoCtrlPropertiesValuePosted(Sender: TObject);
begin
     With FormaPago do
       If   not ValueIsEmpty( FacturaComprasFields.CodigoFormaPago.Value )
       then begin

            FormaPago.Obten( FacturaComprasFields.CodigoFormaPago.Value, FormaPagoFields, True );

            DescuentoPPCtrl.Enabled := FormaPagoFields.DescuentoPP.Value;
            RecargoFinancieroCtrl.Enabled := FormaPagoFields.RecargoFinanciero.Value;

            With FormaPagoCtrl do
              If   Editing
              then begin

                   With FacturaComprasFields.DescuentoPP do
                     If   FormaPagoFields.DescuentoPP.Value
                     then begin
                          If   ProveedorFields.Factura_DtoPP.Value=0.0
                          then Value := FormaPagoFields.TipoDescuentoPP.Value
                          else Value := ProveedorFields.Factura_DtoPP.Value;
                          end
                     else Value  := 0.0;


                   With FacturaComprasFields.RecargoFinanciero do
                     If   FormaPagoFields.RecargoFinanciero.Value
                     then begin
                          If   ProveedorFields.Factura_RecFinanc.Value=0.0
                          then Value := FormaPagoFields.TipoRecargoFinanc.Value
                          else Value := ProveedorFields.Factura_RecFinanc.Value;
                          end
                     else Value  := 0.0;

                     ActualizaDatosFactura;

                     If   TabKey
                     then SelectNextFormControl( FormaPagoCtrl, not ShiftKey );
                     end;

            end;
end;

procedure TMntFdcForm.FormManagerActivateForm;

var   CancelEdit : Boolean;

begin
     CancelEdit := False;
     If   Assigned( BoxSacForm )
     then CancelEdit := BoxSacForm.ModalResult<>mrOk
     else CancelEdit := FacturaComprasTable.State=dsInsert;
     If   CancelEdit
     then With FacturaComprasTable do
            begin
            Cancel;
            Last;
            end;
     If   Assigned( BoxSacForm )
     then BoxSacForm.Release;
end;

function TMntFdcForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := FacturaComprasFields.Traspasada.Value;
end;

procedure TMntFdcForm.FacturaRectificadaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Ejercicio : SmallInt;
     Propietario,
     Serie : String;

begin
     If   Assigned( FacturaFields ) and
          ( EjercicioFraRectificadaCtrl.Editing or SerieFraRectificadaCtrl.Editing )
     then begin

          FechaFraRectificadaBox.Caption := '';

          Propietario := FacturaComprasFields.Proveedor.Value;
          Ejercicio := FacturaFields.EjercicioFraRectificada.Value;
          Serie := FacturaFields.SerieFraRectificada.Value;

          If   Sender=EjercicioFraRectificadaCtrl
          then Ejercicio :=  VarToSmallInt( DisplayValue )
          else If   Sender=SerieFraRectificadaCtrl
               then Serie := VarToStr( DisplayValue );

          If   Serie=''
          then Exit;

          Error := False;
          If   ( Ejercicio=FacturaComprasFields.Ejercicio.Value ) and
               ( Serie=FacturaComprasFields.SerieNroFactura.Value )
          then begin
               Error := True;
               ErrorText := RsMsg11;
               end
          else If   FacturaCompras.Obten( Ejercicio, Propietario, Serie, FacturaRectificadaFields )
               then begin
                    FechaFraRectificadaBox.Caption := StrFormatDate( FacturaRectificadaFields.Fecha.Value, dfDefault2 );
                    EjercicioFraRectificadaCtrl.IsEditValidated := True;
                    SerieFraRectificadaCtrl.IsEditValidated := True;
                    end
               else begin
                    Error := True;
                    ErrorText := RsMsg12;
                    end;
          end;

end;

procedure TMntFdcForm.Pago_BloqueadoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     Pago_MotivoBloqueoCtrl.Enabled := Pago_BloqueadoCtrl.Checked;
end;

procedure TMntFdcForm.PopupMenuPopup(Sender: TObject);

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

procedure TMntFdcForm.ProveedorCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntProveedores( [ Sender.EditingValue ] );
end;

procedure TMntFdcForm.ProveedorCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaProveedores( Sender );
end;

procedure TMntFdcForm.ProveedorCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);

var  CodigoDivisa : String;

begin
     Proveedor.Valida( Sender, DisplayValue, ErrorText, Error, ProveedorFields );
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
end;

procedure TMntFdcForm.Recalculo;
begin
     If   not FRecalculandoFactura
     then try
            FRecalculandoFactura := True;
            If   not ValueIsEmpty( FacturaComprasFields.CodigoFormaPago.Value )
            then begin
                 FacturaCompras.RecalculaFactura( FacturaComprasFields, not CuotaIVACtrl.Editing );
                 FacturaComprasTable.RefreshAndEdit;
                 end;
          finally
            FRecalculandoFactura := False;
            end;
end;

procedure TMntFdcForm.ActualizaDatosFactura;
begin
     Recalculo;
     MuestraDatosFactura;
end;

procedure TMntFdcForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
     Registro.GuardaValorUsuario( ncrMostrarAnotacionesCompras, BoolToStr( MostrarAnotacionesItem.Down ) );
end;

procedure TMntFdcForm.MuestraDatosFactura;

var  ImporteEfectos,
     ImportePendiente : Decimal;

begin

     With FacturaComprasFields do
       begin
       NetoArticulosBox.Caption := StrFormat( NetoFactura.Value, DecimalesMoneda, True );
       PortesBox.Caption := StrFormat( Portes.Value, DecimalesMoneda, True );
       DtoComercialBox.Caption := StrFormat( -ImporteDtoES.Value, DecimalesMoneda, True );
       DtoPPBox.Caption := StrFormat( -ImporteDtoPP.Value, DecimalesMoneda, True );
       ImporteRecFinancieroBox.Caption := StrFormat( ImporteRecFinanciero.Value, DecimalesMoneda, True );

       DtoComercialBox.Caption := StrFormat( -ImporteDtoES.Value, DecimalesMoneda, True );
       DtoPPBox.Caption := StrFormat( -ImporteDtoPP.Value, DecimalesMoneda, True );

       NetoFacturaBox.Caption := StrFormat( NetoFactura.Value - DescuentoProveedores.Value + Portes.Value + ImporteRecFinanciero.Value );
       TotalFacturaBox.Caption := StrFormat( TotalFactura.Value );

       // Otra información

       BaseCalculoRetencionBox.Caption := StrFormat( BaseCalculoRetencion.Value, DecimalesMoneda, True );
       If   ValueIsEmpty( TipoRetencion.Value )
       then TipoRetencionBox.Caption := ''
       else TipoRetencionBox.Caption := StrInt( TipoRetencion.Value ) + ' ';
       ImporteRetencionBox.Caption := StrFormat( ImporteRetencion.Value, DecimalesMoneda, True );

       ImportePendienteBox.Visible := Traspasada.Value;
       If   Traspasada.Value
       then begin
            EfectoPagar.ImportePendienteFactura( Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, ImporteEfectos, ImportePendiente );
            If   ImportePendiente<0.0
            then ImportePendiente := 0.0;
            ImporteEfectosBox.Caption := StrFormat( ImporteEfectos, DecimalesMoneda, True );
            ImportePendienteBox.Caption := StrFormat( ImportePendiente, DecimalesMoneda, True );
            end;

       end;
end;

procedure TMntFdcForm.EfectosGridExit(Sender: TObject);
begin
     EfectosQuery.Cancel;
end;

procedure TMntFdcForm.EfectosGridViewDataControllerSummaryAfterSummary( ASender: TcxDataSummary );
begin
     If   Assigned( FacturaComprasFields )
     then If   not FacturaComprasFields.Traspasada.Value
          then With ASender, ImporteEfectosBox do
                 If   ValueIsEmpty( FooterSummaryValues[ 0 ], varDouble )
                 then Caption := ''
                 else Caption := StrFormat( FooterSummaryValues[ 0 ], DecimalesMoneda );
end;

procedure TMntFdcForm.EfectosGridViewFechaVencimientoPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Date : TDateTime;

begin
     If   TextToDateEx( DisplayValue, Date )
     then If   YearOf( Date )<YearOf( FacturaComprasFields.Fecha.Value )
          then begin
               Error := True;
               ErrorText := RsMsg6;
               end;
end;

procedure TMntFdcForm.GridTableViewControllerDelete(Sender: TObject);

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

procedure TMntFdcForm.EditarEfectoPagar;
begin
     With FacturaComprasFields do
       If   Traspasada.Value
       then MntEfectosPagar( [  Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, 0, EfectosQueryNroEfecto.Value ] );
end;

procedure TMntFdcForm.GridTableViewControllerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     EditarEfectoPagar;
end;

procedure TMntFdcForm.GridViewNroDocumentoGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : string );
begin
     AText := Format( 'Albarán nº : %s', [ IntToStr( ARecord.Values[ GridViewNroDocumento.Index ] ) ] );
end;

procedure TMntFdcForm.InversionSujetoPasivoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     If   not FCambiandoOrigen
     then try
            FCambiandoOrigen := True;
            If   InversionSujetoPasivoCtrl.Editing and
                 FacturaComprasTable.Editing
            then If   ShowNotification( ntQuestionWarning, RsMsg13, RsMsg14 )=mrYes
                 then begin
                      If   InversionSujetoPasivoCtrl.Checked
                      then FacturaComprasFields.Origen.Value := ofrInversionSP
                      else FacturaComprasFields.Origen.Value := ofrSujetoPasivo;
                       FacturaComprasTable.PostAndEdit;
                      With FacturaComprasFields do
                        FacturaCompras.RecalculaAlbaranesFactura( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value );
                      ActualizaDatosFactura;
                      end
                 else InversionSujetoPasivoCtrl.Checked := not InversionSujetoPasivoCtrl.Checked;
          finally
            FCambiandoOrigen := False;
            end;
end;

procedure TMntFdcForm.LineasAlbaranQueryAfterClose(DataSet: TDataSet);
begin
     LineaMovimientoFields := nil;
end;

procedure TMntFdcForm.LineasAlbaranQueryAfterOpen(DataSet: TDataSet);
begin
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineasAlbaranQuery );
     If   Assigned( FacturaComprasFields )
     then If   LineaMovimientoFields.Ejercicio.Value=FacturaComprasFields.Ejercicio.Value
          then GridViewEjercicio.GroupIndex := -1
          else GridViewEjercicio.GroupIndex := 0;
end;

procedure TMntFdcForm.LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
begin
     With FacturaComprasTable do
       begin

       // KeyValues : Ejercicio;Proveedor;SerieNroFactura

       KeyValues[ 0 ] := UnAssigned;

       If   not LockRangeButton.Down
       then KeyValues[ 1 ] := UnAssigned; // Proveedor

       KeyValues[ 2 ] := UnAssigned;
       end;
end;

procedure TMntFdcForm.FormManagerReportFormRequest;
begin
     With FacturaComprasFields do
       ImpresionFacturasCompra( Ejercicio.Value, Proveedor.Value, SerieNroFactura.Value );
end;

procedure TMntFdcForm.DesglosarAlbaranesCtrlPropertiesChange(Sender: TObject);
begin
     ActualizaRejilla;
end;

procedure TMntFdcForm.DocPagoButtonClick(Sender: TObject);
begin
     With FacturaComprasFields do
       ImpresionDocumentosPago( Proveedor.Value, SerieNroFactura.Value );
end;

procedure TMntFdcForm.RegimenOTrascendenciaCtrlPropertiesChange(Sender: TObject);
begin
     If   ( FacturaComprasTable.State=dsEdit ) and
          ( RegimenOTrascendenciaCtrl.Editing )
     then If   FacturaComprasFields.Origen.Value=ofrIntracomunitaria
          then begin
               ShowHintMsg( RsMsg7, RsMsg8 );
               Abort;
               end;
end;

procedure TMntFdcForm.RegistroIVAItemClick(Sender: TObject);
begin
     With FacturaComprasFields do
       If   Traspasada.Value
       then MntFacturasRecibidas( [ taFraRecibida, Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, 0, NroEfectoRegistroFactura ] );
end;

procedure TMntFdcForm.SerieNroFacturaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( FacturaComprasFields.Proveedor, Sender, qgsLinked );
end;

procedure TMntFdcForm.SerieNroFacturaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   SerieNroFacturaCtrl.Editing
     then DisplayValue := Factura.SerieNroFacturaValidoSII( DisplayValue );
end;

procedure TMntFdcForm.FacturaRectificadaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaFacturasCompra( FacturaComprasFields.Proveedor, Sender, qgsNormal, DoOnSelectFacturaRectificada, { LockRange } True );
end;

procedure TMntFdcForm.DoOnSelectFacturaRectificada( Target : TcxCustomEdit = nil );
begin
     FacturaFields.EjercicioFraRectificada.Value := CxFdcForm.QueryEjercicio.Value;
     FacturaFields.SerieFraRectificada.Value := CxFdcForm.QuerySerieNroFactura.Value;
end;

procedure TMntFdcForm.TipoFacturaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     UpdatePageControlState;
end;

procedure TMntFdcForm.TipoFacturaRegimenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     UpdatePageControlState;
end;

procedure TMntFdcForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( tmCompra,
                               LineasAlbaranQueryNroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

procedure TMntFdcForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( FacturaComprasFields.Anotacion );
end;

procedure TMntFdcForm.AsientoItemClick(Sender: TObject);
begin
     With FacturaComprasFields do
       If   Traspasada.Value
       then With Asiento do
              If   ObtenDocumento( taFraRecibida, Ejercicio.Value, ProveedorFields.Subcuenta.Value, SerieNroFactura.Value, 0, NroEfectoRegistroFactura, AsientoFields )
              then MntAsientos( [ AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value ] );
end;

end.

