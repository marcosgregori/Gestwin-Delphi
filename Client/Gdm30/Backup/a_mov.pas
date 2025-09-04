unit a_mov;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics,

     Libutils,
     AppContainer,
     Spring,

     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar,
    cxCurrencyEdit, dxmdaset,

    cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
    dxSkinscxPCPainter, cxRichEdit, cxGroupBox, cxLookAndFeels, cxLabel,
    cxNavigator, cxIntegerEdit, dxBar, dxDateRanges, dxScrollbarAnnotations,

    Gim10Fields,
    Gim30Fields,

    AppForms,
    GridTableViewController,

    f_sto,
    f_rdc,

    dmi_mov,
    dmi_sto,

    dm_mov,
    dm_fdv,
    dm_lma,
    dm_sto, dxUIAClasses;

type

  TImportarDatosFunction = procedure ( MovimientoFiels : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields ) of object;
  TMovimientoEvent = procedure( MovimientoFiels : TMovimientoFields ) of object;

  TMntMovForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    TopPanel: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    LineaMovimientoDataSource: TDataSource;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    GridViewPrecio: TcxGridDBColumn;
    GridViewDescuento: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    GridViewLargo: TcxGridDBColumn;
    GridViewAncho: TcxGridDBColumn;
    GridViewAlto: TcxGridDBColumn;
    GridViewImporte: TcxGridDBColumn;
    TableViewManager: TGridTableViewController;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewUbicacion: TcxGridDBColumn;
    NroOperacionCtrl: TcxDBIntegerEdit;
    TipoMovimientoCtrl: TcxDBSpinEdit;
    DescripcionCtrl: TcxDBTextEdit;
    GridViewRecargo: TcxGridDBColumn;
    GridViewPuntoVerde: TcxGridDBColumn;
    ImportarButton: TgBitBtn;
    GridViewNumeroSerie: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    GridViewNroRegistro: TcxGridDBColumn;    
    GridViewAnotacion: TcxGridDBColumn;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    Label3: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    Label1: TcxLabel;
    GridViewTipoLinea: TcxGridDBColumn;
    OperarioPanel: TcxGroupBox;
    CodigoOperarioCtrl: TcxDBTextEdit;
    NombreOperarioLabel: TcxLabel;
    cxLabel2: TcxLabel;
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
    LineaMovimientoTablePrecio: TFloatField;
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
    OrigenLabel: TcxLabel;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTablePesoEnvase: TBCDField;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableFechaAplicacion: TDateField;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    MostrarAnotacionesItem: TdxBarButton;
    DocumentoItem: TdxBarButton;
    cxGroupBox1: TcxGroupBox;
    LineaMovimientoTableFechaCaducidad: TDateField;
    GridViewFechaCaducidad: TcxGridDBColumn;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    GridViewCampoLibre1: TcxGridDBColumn;
    GridViewCampoLibre2: TcxGridDBColumn;
    GridViewCampoLibre3: TcxGridDBColumn;
    GridViewCampoLibre4: TcxGridDBColumn;
    AnotacionButton: TgBitBtn;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    procedure FormManagerInitializeForm;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    function FormManagerCopyCurrentRecord: Boolean;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure LineaMovimientoTableAfterEdit(DataSet: TDataSet);
    procedure MovimientoTableAfterEdit(DataSet: TDataSet);
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
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
    procedure PopupMenuPopup(Sender: TObject);
    procedure LineaMovimientoTableNewRecord(DataSet: TDataSet);
    procedure FormManagerShowForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure MovimientoTableBeforeScroll(DataSet: TDataSet);
    procedure GridViewInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure GridExit(Sender: TObject);
    procedure GridViewUbicacionPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TrazaItemClick(Sender: TObject);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure EditarDocItemClick(Sender: TObject);
    procedure GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TipoMovimientoCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure LineaMovimientoTableAfterPost(DataSet: TDataSet);
    procedure GridViewCodigoClaseAPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCantidadPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure MovimientoTableBeforeInsert(DataSet: TDataSet);
    procedure GridViewNroCajasPropertiesValuePosted(Sender: TObject);
    procedure GridViewDimensionPropertiesValuePosted(Sender: TObject);
    procedure GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
    function FormManagerGetAccessLevel: Smallint;
    procedure RelationsPopupMenuPopup(Sender: TObject);
    procedure DocumentoItemClick(Sender: TObject);
    function MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure GridViewLoteFabricacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewLoteFabricacionPropertiesValuePosted(
      Sender: TObject);
    procedure MostrarAnotacionesItemClick(Sender: TObject);
    procedure GridViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormManagerUpdateButtonsState;
    procedure GridViewTipoLineaPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewTipoLineaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCantidadPropertiesValuePosted(Sender: TObject);
    procedure GridViewPrecioPropertiesValuePosted(Sender: TObject);
    procedure GridViewPuntoVerdePropertiesValuePosted(Sender: TObject);
    procedure GridViewRecargoPropertiesValuePosted(Sender: TObject);
    procedure GridViewDescuentoPropertiesValuePosted(Sender: TObject);
    procedure CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoOperarioCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure MovimientoTableBeforeDelete(DataSet: TDataSet);
    procedure FormManagerAutoEditChanged(var Value: Boolean);
    procedure LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableRemotePost(DataSet: TDataSet);
    procedure MovimientoTableRemotePost(DataSet: TDataSet);
    procedure MovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure GridViewImporteGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: string);
    function TableViewManagerCanUpdateRow: Boolean;
    function TableViewManagerCanShiftRow: Boolean;
    procedure TableViewManagerRowShift(ShiftOperation: TShiftOperation);
    procedure GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
    procedure FormManagerReportFormRequest;
    procedure FormManagerLabelsRequest;
    procedure FormManagerQueryGridRequest;
    procedure MovimientoTableGetRecord(DataSet: TDataSet);
    procedure AnotacionButtonClick(Sender: TObject);
  private
    StockFrame : TStockFrame;
    DesglosarLinea,
    ShowFocusedRowHighlited : Boolean;
    FOnImportarDatos : Event<TImportarDatosFunction>;
    FBeforeDeleteMovimiento : Event<TMovimientoEvent>;
    ExistenciasArticulo : IExistenciasArticulo;
    EsMovimientoVenta : Variant; // Un boolean nulleable

    procedure ActualizaCamposCalculadosLinea;
    procedure AbreDocumentoCompraVenta;

  public

    MovimientoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;
    TiposIVAFields : TTiposIVAFields;
    ProveedorFields : TProveedorFields;

    SerieFacturacion_Contabilizar : Boolean;
    SerieFacturacion_CentroCoste : String;

    ImporteBruto,
    DtoArticulo,
    ImporteNeto,

    CantidadTotal,
    ImporteTotal : Decimal;

    CodigoDivisa : String;

    LoteAsignado,
    ServidoAnterior,
    AjustandoCantidad,
    FijarClases : Boolean;

    CodClaseA,
    CodClaseB,
    CodClaseC : String;

    UltimoTipoMovimientoImportado : TTipoMovimiento;

    procedure ObtenExistencias;
    procedure ActualizaEstado;
    procedure ActualizaRelaciones;
    procedure ActualizaValorCantidad( Value : Decimal );
    function  ObtenUltimoNroLinea : SmallInt;
    procedure DoOnCopyCurrentRecord;
    procedure DoSeleccionaDocumento;
    procedure DoOnLoteProductoSelected( Target : TcxCustomEdit = nil );
    procedure DoOnExistenciasSelected( Target : TcxCustomEdit = nil );
    procedure HighliteRow( RowIndex : LongInt );

    property OnImportarDatos : Event<TImportarDatosFunction> read FOnImportarDatos write FOnImportarDatos;
    property BeforeDeleteMovimiento : Event<TMovimientoEvent> read FBeforeDeleteMovimiento write FBeforeDeleteMovimiento;
  end;

var  MntMovForm : TMntMovForm = nil;

function MntMovimientosAlmacen( Values : array of const ) : TMntMovForm;
procedure MntMovimientosPorNroRegistro( NroRegistroLinea : LongInt; LineaMovimientoFields : TLineaMovimientoFields = nil );

implementation

{$R *.DFM}

uses   Math,
       Variants,
       SysUtils,

       AppManager,
       EnterpriseDataAccess,

       Gdm00Dm,
       Gim00Fields,
       Gdm30Frm,

       dm_usr,
       dm_cls,
       dm_art,
       dm_cli,
       dm_pro,
       dm_alm,
       dm_ubi,
       dm_tma,
       dm_sdf,
       dm_rcl,
       dm_fdc,
       dm_tlm,
       dm_ope,

       b_msg,
       bx_not,
       b_trz,
       b_fda,
       b_cma,
       b_sdv,

       a_tma,
       a_art,
       a_cli,
       a_cls,
       a_alm,
       a_ubi,
       a_sdf,
       a_mco,
       a_mve,
       a_tlm,
       a_ope,

       cx_tma,
       cx_mov,
       cx_cli,
       cx_art,
       cx_alm,
       cx_ubi,
       cx_epu,
       cx_sdf,
       cx_ldp1,
       cx_ldp2,
       cx_tlm,
       cx_ope,

       e_mov,
       r_mov;

resourceString

   RsMsg1  = 'Para editar movimientos de compra o venta utilice los mantenimientos de albaranes de compra y venta.';
   RsMsg2  = 'Tiene restringido el acceso a este tipo de documento.';
   RsMsg3  = 'Nº documento : ';
   RsMsg4  = 'Para crear este tipo de movimientos utilice los mantenimientos especializados';
   RsMsg5  = 'Las ofertas, presupuestos, pedidos y albaranes deben crearse y editarse utilizando los mantenimientos correspondientes.';
   RsMsg6  = 'No se ha podido localizar el movimiento asociado a este número de registro.';
   RsMsg7  = 'Se va ha suprimir la referencia al mismo en el documento origen.';
   RsMsg8  = 'Desde este punto no puede suprimirse la referencia en el documento origen.'#13'Localice la línea desde el mantenimiento correspondiente e intente localizar la línea del documento origen.';
   RsMsg9  = 'No procede de ningún otro documento.';
   RsMsg10 = 'No se pueden modificar las líneas de los movimientos de reubicación.';
   RsMsg11 = 'Los movimientos de reubicación se generan de forma automática desde las hojas de carga y solo pueden ser suprimidos en su totalidad.';
   RsMsg12 = 'En este artículo es obligatorio indicar el envase.';

function MntMovimientosAlmacen( Values : array of const ) : TMntMovForm;
begin
     CreateEditForm( TMntMovForm, MntMovForm, Values, TGds30Frm.AlmacenSection );
     Result := MntMovForm;
end;

procedure MntMovimientosPorNroRegistro( NroRegistroLinea      : LongInt;
                                        LineaMovimientoFields : TLineaMovimientoFields = nil );

var  MntOrigenMcoForm : TMntMcoForm;
     MntOrigenMveForm : TMntMveForm;
     MntOrigenMovForm : TMntMovForm;
     RecordIndex : Integer;

begin
     With Movimiento do
       If   ObtenRegistro( NroRegistroLinea, True )
       then begin
            With DmMovimientoFields do
               case TipoMovimiento.Value of
                 tmOferta,
                 tmPedidoCompra,
                 tmCompra         : begin
                                    MntOrigenMcoForm := MntMovimientosCompra( [ TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value ] );
                                    If   Assigned( MntOrigenMcoForm )
                                    then With MntOrigenMcoForm do
                                           begin
                                           RecordIndex := FindRecordIndexByColumnValue( GridViewNroRegistro, NroRegistroLinea );
                                           If   RecordIndex>=0
                                           then HighliteRow( RecordIndex );
                                           end;
                                    end;
                 tmPresupuesto,
                 tmPedidoVenta,
                 tmVenta          : begin
                                    MntOrigenMveForm := MntMovimientosVenta( [ TipoMovimiento.Value, Ejercicio.Value, Serie.Value, NroDocumento.Value ] );
                                    If   Assigned( MntOrigenMveForm )
                                    then With MntOrigenMveForm do
                                           begin
                                           If   DmLineaMovimientoFields.NroPagina.Value<>0
                                           then GrupoLineaMovimientoTable.FindKey( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, DmLineaMovimientoFields.NroPagina.Value ] );
                                           RecordIndex := FindRecordIndexByColumnValue( GridViewNroRegistro, NroRegistroLinea );
                                           If   RecordIndex>=0
                                           then HighliteRow( RecordIndex );
                                           end;
                                    end;

                 else               begin
                                    MntOrigenMovForm := MntMovimientosAlmacen( [ Ejercicio.Value, NroOperacion.Value ] );
                                    If   Assigned( MntOrigenMovForm )
                                    then With MntOrigenMovForm do
                                           begin
                                           RecordIndex := FindRecordIndexByColumnValue( GridViewNroRegistro, NroRegistroLinea );
                                           If   RecordIndex>=0
                                           then HighliteRow( RecordIndex );
                                           end;
                                    end;
                end;
            end
       else begin
            If   Assigned( LineaMovimientoFields )
            then begin
                 ShowNotification( ntWarning, RsMsg6, RsMsg7 );
                 With LineaMovimientoFields do
                   begin
                   DataSet.Edit;
                   TipoMovimientoOrigen.Clear;
                   EjercicioOrigen.Clear;
                   NroOperacionOrigen.Clear;
                   NroRegistroOrigen.Clear;
                   DataSet.Post;
                   end;
                 end
            else ShowNotification( ntWarning, RsMsg6, RsMsg8 );
            Abort;
            end;

end;

procedure TMntMovForm.FormManagerInitializeForm;

var  DecimalesPrecio : SmallInt;

begin

     ID := idMntMovForm;

     EsMovimientoVenta := Null;  // Si no se asigna un Null es UnAssigned por defecto y no es comparable

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     
     SetupPanelableCtrl( CodigoOperarioCtrl, DataModule00.DmEmpresaFields.Stock_Operarios.Value );
     
     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin
       
       GridViewNumeroSerie.Visible := Ventas_NrosSerie.Value;
       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       GridViewTipoLinea.Visible:= Stock_TiposLineaMovimiento.Value;
       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewLargo.Visible := Ventas_Cantidades.Value>0;
       GridViewAncho.Visible := Ventas_Cantidades.Value>0;
       GridViewAlto.Visible := Ventas_Cantidades.Value>1;

       SetColumnDecimals( GridViewCantidad, Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
       DecimalesPrecio := Max( Compras_DecPrecio.Value, Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewPrecio, Max( Compras_DecPrecio.Value, Ventas_DecPrecio.Value ) );
       SetColumnDecimals( GridViewDescuento, Max( Compras_DecDto.Value, Ventas_DecDto.Value ) );
       SetColumnDecimals( GridViewImporte );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
       SetColumnDecimals( GridViewNroCajas, Max( Compras_DecCajas.Value, Ventas_DecCajas.Value ) );

       SetFooterSummaryItemDecimals( GridView, 0, Ventas_DecCantidad.Value );
       SetFooterSummaryItemDecimals( GridView, 1 );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then GridViewAlto.Caption := Ventas_NombreCajas.Value
            else GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       If   Usuario.OpcionUsuario( DataModule00.DmUsuarioFields.Ventas_MostrarStock, Ventas_VerStock ) 
       then StockFrame := CreaPanelStock( scCompras, TopPanel, GridView );
       
       end;

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          GridViewPrecio.Visible := False;
          GridViewDescuento.Visible:= False;
          GridViewImporte.Visible := False;
          end;

     Grid.ShowHint := True;

     MovimientoTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio ], [ ApplicationContainer.Ejercicio ] );
     SetFieldsRange( [ MovimientoFields.NroOperacion, LineaMovimientoFields.NroLinea ] );

end;

procedure TMntMovForm.FormManagerLabelsRequest;
begin
     With MovimientoFields do
       EtiquetasArticulosDesdeMovimientos( TipoMovimiento.Value, '', NroOperacion.Value, '' );
end;

procedure TMntMovForm.ObtenExistencias;
begin
     ObtenyMuestraExistencias( GridView, LineaMovimientoFields, ExistenciasArticulo, '', StockFrame );
end;

procedure TMntMovForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
      ConsultaMovimientos( Sender, qgsLinked );
end;

procedure TMntMovForm.GridExit(Sender: TObject);
begin
     ObtenExistencias;  // Para ocultar el panel
end;

procedure TMntMovForm.GridViewCantidadPropertiesValidate(     Sender       : TcxCustomEdit;
                                                          var DisplayValue : Variant;
                                                          var ErrorText    : TCaption;
                                                          var Error        : Boolean );
begin
     // No se hace ninguna comprobación de stocks de las salidas. Ya veremos que ocurre.
end;

procedure TMntMovForm.GridViewCantidadPropertiesValuePosted(Sender: TObject);
begin
     If   not AjustandoCantidad
     then try
            AjustandoCantidad := True;
            If   ValueIsEmpty( GridViewCantidad.EditValue )
            then Movimiento.LimpiaImportesLinea( LineaMovimientoFields )
            else ActualizaRelaciones;
            ActualizaCamposCalculadosLinea;
          finally
            AjustandoCantidad := False;
            end;
end;

procedure TMntMovForm.GridViewCellDblClick(     Sender        : TcxCustomGridTableView;
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

procedure TMntMovForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntMovForm.ActualizaValorCantidad( Value : Decimal );
begin
     GridViewCantidad.EditValue := Value;
     LineaMovimientoFields.Cantidad.Value := GridViewCantidad.EditValue;
     ActualizaCamposCalculadosLinea;
     ActualizaRelaciones;
end;

procedure TMntMovForm.AnotacionButtonClick(Sender: TObject);
begin
     MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
end;

procedure TMntMovForm.CodigoOperarioCtrlPropertiesEditRequest(Sender: TcxCustomEdit);

var  CodigoPropietario : String;

begin
     If   MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]
     then CodigoPropietario := MovimientoFields.Propietario.Value
     else CodigoPropietario := '';
     MntOperarios( [ CodigoPropietario, Sender.EditingValue ] );
end;

procedure TMntMovForm.CodigoOperarioCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaOperarios( Sender );
end;

procedure TMntMovForm.CodigoOperarioCtrlPropertiesValidate(     Sender       : TcxCustomEdit;
                                                            var DisplayValue : Variant;
                                                            var ErrorText    : TCaption;
                                                            var Error        : Boolean );
var  CodigoPropietario : String;

begin
     If   MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]
     then CodigoPropietario := MovimientoFields.Propietario.Value
     else CodigoPropietario := '';
     Operario.Valida( CodigoPropietario, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMovForm.ActualizaRelaciones;
begin
     If   LineaMovimientoTable.Editing
     then Movimiento.ActualizaRelacionesLineaEntrada( MovimientoFields, LineaMovimientoFields, ArticuloFields );
end;

procedure TMntMovForm.GridViewCodigoAlmacenPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntMovForm.GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
begin
     Almacen.SetDefault( Sender, scAmbas, ArticuloFields );
end;

procedure TMntMovForm.GridViewCodigoAlmacenPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaAlmacenes( Sender, qgsNormal, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
end;

procedure TMntMovForm.GridViewCodigoAlmacenPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMovForm.GridViewCodigoAlmacenPropertiesValuePosted(Sender: TObject);
begin
     LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );
end;

procedure TMntMovForm.GridViewCodigoArticuloPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TMntMovForm.GridViewCodigoArticuloPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scVentas, False, Sender );
end;

procedure TMntMovForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

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
     then FacturaCompras.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, nil, TiposIVAFields );
end;

procedure TMntMovForm.GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
begin
     With GridViewCodigoArticulo do
       If   Editing
       then With LineaMovimientoFields do
              If   LineaMovimientoTable.Editing
              then begin

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
                     CodigoAlmacen.Value := Almacen.AlmacenPorDefecto( scAmbas, ArticuloFields );
                     Ubicacion.Value := Almacen.UbicacionPorDefecto( CodigoAlmacen.Value, ArticuloFields );

                     If   DataModule00.DmEmpresaFields.Ventas_Cantidades.Value>0
                     then begin
                          Largo.Value := ArticuloFields.Largo.Value;
                          Ancho.Value := ArticuloFields.Ancho.Value;
                          end;

                     If   DataModule00.DmEmpresaFields.Ventas_Cantidades.Value>1
                     then Alto.Value := ArticuloFields.Alto.Value;

                     Movimiento.LimpiaImportesLinea( LineaMovimientoFields );

                     If   Cantidad.Value<>0.0
                     then ActualizaRelaciones;

                     ActualizaCamposCalculadosLinea;

                   finally
                     LineaMovimientoTable.EnableControls;
                     GridView.DataController.UpdateData;
                     end;

                   ObtenExistencias;
                   end;

     FijarClases := False;
end;

procedure TMntMovForm.GridViewCodigoClaseAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Column : TcxGridColumn;

begin
     With TableViewManager do
       If   ValidatingTableView
       then Column := ValidatingColumn
       else Column := GridView.Controller.FocusedColumn;

     If   Assigned( Column )
     then begin
          Clase.Valida( TNroClase( Column.Tag ), False, Sender, DisplayValue, ErrorText, Error );
          If   DataModule00.DmEmpresaFields.Articulo_Envase.Value=Column.Tag   // La clase que acabamos de validar es el envase
          then If   ArticuloFields.ConEnvase.Value and ValueIsEmpty( DisplayValue )
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsgMsg171, RsMsg12 );
                    end;
          end;
end;

procedure TMntMovForm.GridViewCodigoClasePropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntClases( [ TNroClase( GridView.Controller.FocusedColumn.Tag ), Sender.EditingValue ] );
end;

procedure TMntMovForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   ShowFocusedRowHighlited and AViewInfo.GridRecord.Focused
     then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntMovForm.GridViewCodigoClasePropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       ConsultaClases( TNroClase( GridView.Controller.FocusedColumn.Tag ), CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, '', Sender );
end;

procedure TMntMovForm.GridViewDescuentoPropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMovForm.GridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
begin
     If   GridView.DataController.IsEditing and TabKey and not ShiftKey
     then If   AFocusedItem=GridViewDescripcion
          then begin
               With GridView.Controller do
                      FocusedColumnIndex := FocusedColumnIndex + 1;
               end
          else If   ( APrevFocusedItem=GridViewCantidad ) and ValueIsEmpty( GridViewCantidad.EditValue )
               then GridView.Controller.GoToNext( True );

end;

procedure TMntMovForm.GridViewFocusedRecordChanged( Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     FormManagerUpdateButtonsState;
     ObtenExistencias;
     ActualizaEstado;
end;

procedure TMntMovForm.GridViewImporteGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                         ARecord : TcxCustomGridRecord;
                                                     var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporte.Index ] ), DecimalesMoneda, True );
end;

procedure TMntMovForm.GridViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(       Sender    : TcxDataSummaryItem;
                                                                                               const AValue    : Variant;
                                                                                                     AIsFooter : Boolean;
                                                                                               var   AText     : String );
begin
     AText := StrFormat( VarToDecimal( AValue ) );
end;

procedure TMntMovForm.GridViewInitEdit(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
begin
     ObtenExistencias;
     If   LineaMovimientoTable.State<>dsInsert
     then begin

          // Estos mensajes son solo para que el usuario sepa el motivo por el que no se pueden editar

          If   MovimientoFields.TipoMovimiento.Value=tmReubicacionCarga
          then ShowHintMsg( RsMsg10, RsMsg11 )

          end;
end;

procedure TMntMovForm.GridViewLoteFabricacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     If  DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value or
         DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value
     then ConsultaLotesProductos2( Sender, GridViewCodigoArticulo.EditValue, MovimientoFields.Fecha.Value, DoOnLoteProductoSelected )
     else ConsultaLotesProductos1( Sender, GridViewCodigoArticulo.EditValue );
end;

procedure TMntMovForm.DoOnLoteProductoSelected;
begin

     // Al final se asigna la fec ha de caducidad en todos los tipo de movimiento. En el peor de los casos basta con borrar el valor si no interesa.

     With CxLdp2Form do
       begin
       LineaMovimientoTable.Edit;

       LineaMovimientoTableCodigoClaseA.Value := QueryCodigoClaseA.Value;
       LineaMovimientoTableCodigoClaseB.Value := QueryCodigoClaseB.Value;
       LineaMovimientoTableCodigoClaseC.Value := QueryCodigoClaseC.Value;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       LineaMovimientoTableUIDArticulo.Value := QueryUIDArticulo.Value;

       If   QueryFechaCaducidad.AsFloat<>0
       then LineaMovimientoTableFechaCaducidad.Value := QueryFechaCaducidad.Value;

       LineaMovimientoTableTipoMovimientoOrigen.Value := QueryTipoMovimiento.Value;
       LineaMovimientoTableEjercicioOrigen.Value := QueryEjercicio.Value;
       LineaMovimientoTableNroOperacionOrigen.Value := QueryNroOperacion.Value;
       LineaMovimientoTableNroRegistroOrigen.Value := QueryNroRegistro.Value;
       
       TableViewManager.ValidateTableView;
       LoteAsignado := True;
       end;

end;

procedure TMntMovForm.GridViewLoteFabricacionPropertiesValuePosted(Sender: TObject);
begin
     LoteAsignado := False;
end;

procedure TMntMovForm.GridViewDimensionPropertiesValuePosted(Sender: TObject);
begin
     With GridView.Controller.FocusedColumn do
        If   Editing
        then With LineaMovimientoFields do
               ActualizaValorCantidad( Movimiento.CalculoEspecial( scCompras, Largo.Value, Ancho.Value, Alto.Value ) );
end;

procedure TMntMovForm.GridViewNroCajasPropertiesValuePosted(Sender: TObject);
begin
     With GridViewNroCajas do
       If   Editing and ( GridViewCodigoArticulo.EditValue<>ArticuloNulo )
       then ActualizaValorCantidad( EditValue * ArticuloFields.UnidadesPorCaja.Value );
end;

procedure TMntMovForm.GridViewPrecioPropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMovForm.GridViewPuntoVerdePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMovForm.GridViewRecargoPropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntMovForm.GridViewTipoLineaPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposLineaMovimiento( [ Sender.EditingValue ] );
end;

procedure TMntMovForm.GridViewTipoLineaPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposLineaMovimiento( Sender );
end;

procedure TMntMovForm.GridViewTipoLineaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     TipoLineaMovimiento.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMovForm.GridViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       MntUbicaciones( [ CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntMovForm.GridViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       If   ShiftKey
       then ConsultaUbicaciones( CodigoAlmacen.Value, ubNormal, Sender )
       else ConsultaExistenciasUbicacion( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LoteFabricacion.Value, CodigoAlmacen.Value, Sender, DoOnExistenciasSelected );
end;

procedure TMntMovForm.DoOnExistenciasSelected( Target : TcxCustomEdit = nil );
begin
     With CxEpuForm do
       begin
       LineaMovimientoTable.Edit;
       LineaMovimientoTableLoteFabricacion.Value := QueryLoteFabricacion.Value;
       // Esto es para que se valide, porque las ubicaciones pueden ser ubicaciones de carga, que no son válidas en este contexto
       QueryPanel.TargetControl.PostEditValue( QueryUbicacion.Value );
       end;
end;

procedure TMntMovForm.GridViewUbicacionPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Ubicacion.Valida( LineaMovimientoFields.CodigoAlmacen.Value, False, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntMovForm.ImportarButtonClick(Sender: TObject);

var  TipoMovimiento : TTipoMovimiento;
     Propietario : String;

begin
     FormManager.ValidateDataArea( faData, True );
     MovimientoTable.Update;
     If   FOnImportarDatos.CanInvoke
     then FOnImportarDatos.Invoke( MovimientoFields, LineaMovimientoFields )
     else ImportaDocumentoVenta( MovimientoFields.Propietario.Value, DoSeleccionaDocumento, MovimientoFields.TipoMovimiento.Value, [ tmCapturador ], UltimoTipoMovimientoImportado );
end;

procedure TMntMovForm.DoSeleccionaDocumento;
begin
     UltimoTipoMovimientoImportado := BoxSdvForm.DataTipoMovimiento.Value;
     try
       Movimiento.ImportaDatosCapturador( MovimientoFields,
                                          LineaMovimientoFields,
                                          BoxSdvForm.FicheroDatosBox.Caption,
                                          DataModule00.DmEmpresaFields.Ventas_AlmacenDefec.Value );
     finally
       LineaMovimientoTable.Last;
       GridView.DataController.UpdateItems( False );
       Grid.SetFocus;
       end;
end;

procedure TMntMovForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value, LineaMovimientoFields );
end;

function TMntMovForm.ObtenUltimoNroLinea : SmallInt;
begin
     With LineaMovimientoTable do
       begin
       Last;
       If   ValueIsEmpty( LineaMovimientoFields.NroLinea.Value )
       then Result := 1
       else Result := LineaMovimientoFields.NroLinea.Value + 1;
       end;
end;

procedure TMntMovForm.FormManagerNoteRequest;
begin
     If   GridView.IsControlFocused
     then MntAnotacion( LineaMovimientoFields.Anotacion, RsAnotacionLinea )
     else MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
     FormManagerUpdateButtonsState;
end;

procedure TMntMovForm.FormManagerQueryGridRequest;
begin
     ConsultaMovimientos( NroOperacionCtrl, qgsDetached );
end;

procedure TMntMovForm.FormManagerReportFormRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( True, tmNoDefinido, Ejercicio.Value, '', '', MovimientoFields.NroOperacion.Value );
end;

procedure TMntMovForm.FormManagerReportRequest;
begin
     With MovimientoFields do
       ImpresionMovimientos( False, tmNoDefinido, Ejercicio.Value, '', '', MovimientoFields.NroOperacion.Value );
end;

procedure TMntMovForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TMntMovForm.FormManagerUpdateButtonsState;
begin
     If   Assigned( MovimientoFields )
     then begin
          If   not MovimientoTable.UpdatingProcess
          then begin
               AnotacionButton.Visible := MovimientoFields.Anotacion.Value<>'';
               AnotacionButton.Enabled := MovimientoTable.Editing;
               end;
          ImportarButton.Enabled := MovimientoTable.Editing;
          end;
end;

procedure TMntMovForm.LineaMovimientoTableAfterEdit(DataSet: TDataSet);
begin
     ObtenExistencias;
     LoteAsignado := False;
end;

procedure TMntMovForm.LineaMovimientoTableBeforePost(DataSet: TDataSet);
begin
     If   not LineaMovimientoTable.ControlsDisabled
     then begin
          ActualizaCamposCalculadosLinea;
 	        If   not LoteAsignado and ( LineaMovimientoFields.Cantidad.Value<0.0 )
          then Movimiento.AsignaOrigenPorLoteySerie( LineaMovimientoFields );
          DesglosarLinea := ListaMateriales.RequiereDesglose( MovimientoFields, LineaMovimientoFields, ArticuloFields );
          end;
end;

procedure TMntMovForm.LineaMovimientoTableAfterPost(DataSet: TDataSet);
begin
     If   DesglosarLinea
     then begin
          DesglosarLinea := False;
          ListaMateriales.AplicarDesglose( MovimientoFields, LineaMovimientoFields );
          GridView.DataController.UpdateItems( False );
          GridView.Controller.FocusFirstAvailableItem;
          end;
end;
procedure TMntMovForm.LineaMovimientoTableNewRecord(DataSet: TDataSet);
begin
     With LineaMovimientoFields do
       begin
       NroPagina.Value := 0;
       Fecha.Value := MovimientoFields.Fecha.Value;
       UIDArticulo.AsGUID := Articulo.Identificador;
       end;
end;

procedure TMntMovForm.LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeLineaMovimiento( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntMovForm.LineaMovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaLineaMovimiento( MovimientoFields, LineaMovimientoFields, False );
end;

procedure TMntMovForm.ActualizaCamposCalculadosLinea;
begin
     FacturaCompras.CalculaImportes( LineaMovimientoFields, ArticuloFields )
end;

procedure TMntMovForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : Ejercicio;NroOperacion
       KeyValues[ 0 ] := ApplicationContainer.Ejercicio;
       KeyValues[ 1 ] := UnAssigned;
       end;
end;

procedure TMntMovForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntMovForm.FichaArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

function TMntMovForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmVenta ];
end;

procedure TMntMovForm.FormManagerAutoEditChanged(var Value: Boolean);
begin
     {
     LineaMovimientoDataSource.AutoEdit := True;
     If   MovimientoFields.TipoMovimiento.Value=tmReubicacionCarga
     then begin
          Value := False;
          SetColumnsEditingOption( GridView, Value );
          end;
     }
end;

function TMntMovForm.FormManagerCopyCurrentRecord: Boolean;
begin
     SeleccionaCopiaMovimiento( MovimientoFields.TipoMovimiento.Value, DoOnCopyCurrentRecord );
     Result := False;
end;

function TMntMovForm.FormManagerGetAccessLevel: Smallint;
begin
     { //*  19.01.2009 Por lo visto, no es muy apreciado por los usuarios
     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then Result := Ord( alReadOnly )
     else Result := Ord( alAllowed );
     }
     Result := Ord( alAllowed );
end;

procedure TMntMovForm.DocumentoItemClick(Sender: TObject);
begin
     AbreDocumentoCompraVenta;
end;

procedure TMntMovForm.DoOnCopyCurrentRecord;

var  NroOperacionDestino : LongInt;

begin
     With BoxCmaForm do
        begin

        NroOperacionDestino := Movimiento.CopiaMovimiento( MovimientoFields.Ejercicio.Value,
                                                           MovimientoFields.NroOperacion.Value,
                                                           DataTipoMovimiento.Value,
                                                           '',     // Solo movimientos de almacén, que no tienen serie ni propietario
                                                           '',
                                                           True,
                                                           DataAlmacen.Value,
                                                           { AsignarUbicaciones } DataAsignarUbicaciones.Value,
                                                           { InvertirCantidades } DataInvertirCantidades.Value,
                                                           { BorrarMovimientoOrigen } DataBorrarMovimiento.Value,
                                                           { ActualizarPrecios } DataActualizarPrecios.Value );
        If   NroOperacionDestino>0
        then If   Movimiento.ObtenMovimiento( ApplicationContainer.Ejercicio, NroOperacionDestino )
             then begin
                  MovimientoTable.GotoCurrent( Movimiento.DmMovimientoTable );
                  Self.FormManager.SelectFirstKeyControl;
                  end;
            end;
end;

procedure TMntMovForm.MostrarAnotacionesItemClick(Sender: TObject);
begin
     GridView.Preview.Visible := MostrarAnotacionesItem.Down;
end;

procedure TMntMovForm.MovimientoTableAfterEdit(DataSet: TDataSet);
begin
     If   not MovimientoTable.UpdatingProcess
     then CompruebaEjercicio( MovimientoFields.Fecha.Value );
end;

procedure TMntMovForm.AbreDocumentoCompraVenta;
begin
     try
       Enabled := False;
       With MovimientoFields do
         If   TipoMovimiento.Value in [ tmOferta..tmVenta ]
         then begin
              MovimientoTable.Cancel;
              If   ( TipoMovimiento.Value in [ tmOferta..tmCompra ] ) and DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
              then ShowNotification( ntStop, RsMsg2, '' )
              else case TipoMovimiento.Value of
                     tmOferta..tmCompra     : MntMovimientosCompra( [ TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value ] );
                     tmPresupuesto..tmVenta : MntMovimientosVenta(  [ TipoMovimiento.Value, Ejercicio.Value, Serie.Value, NroDocumento.Value ] );
                     end;
              Abort;
              end;
     finally
       Enabled := True;
       end;
end;

procedure TMntMovForm.MovimientoTableBeforeDelete(DataSet: TDataSet);
begin
     FBeforeDeleteMovimiento.Invoke( MovimientoFields );
end;

procedure TMntMovForm.MovimientoTableBeforeInsert(DataSet: TDataSet);
begin
     If   MovimientoTable.State=dsSetKey
     then Movimiento.CompruebaNroDocumento( FormManager, MovimientoFields );
end;

procedure TMntMovForm.MovimientoTableBeforePost(DataSet: TDataSet);
begin
     SetFieldValueIfEmpty( MovimientoFields.Serie, '' );
end;

procedure TMntMovForm.MovimientoTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

function TMntMovForm.MovimientoTableCanEditRecord( Dataset : TDataSet ): Boolean;
begin
     Result := not ( MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmVenta ] ) and
               not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

procedure TMntMovForm.MovimientoTableGetRecord(DataSet: TDataSet);

var  EsMovimientoVentaActual : Boolean;

begin
     If   DataModule00.DmEmpresaFields.Compras_CamposLibresLineas.Value or
          DataModule00.DmEmpresaFields.Ventas_CamposLibresLineas.Value
     then begin
          EsMovimientoVentaActual := MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ];
          If   EsMovimientoVentaActual<>EsMovimientoVenta
          then begin
               EsMovimientoVenta := EsMovimientoVentaActual;
               If   EsMovimientoVenta
               then Movimiento.SetupCamposLibresLineaVentas( GridView, [ GridViewCampoLibre1, GridViewCampoLibre2, GridViewCampoLibre3, GridViewCampoLibre4 ] )
               else Movimiento.SetupCamposLibresLineaCompras( GridView, [ GridViewCampoLibre1, GridViewCampoLibre2, GridViewCampoLibre3, GridViewCampoLibre4 ] );
               end;
          end;
end;

procedure TMntMovForm.MovimientoTableNewRecord(DataSet: TDataSet);
begin
     With MovimientoFields do
       begin
       Fecha.Value := ApplicationContainer.TodayDate;
       FechaAplicacion.Value := ApplicationContainer.TodayDate;  // Fecha de recepcion
       end;
end;

procedure TMntMovForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.OrigenDocumento( MovimientoFields, OrigenLabel );

     With MovimientoFields do
       If   ValueIsEmpty( NroDocumento.Value )
       then EstadoLabel.Caption := ''
       else EstadoLabel.Caption := RsMsg3 + Serie.Value + ' ' + IntToStr( NroDocumento.Value );

end;

procedure TMntMovForm.MovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeMovimiento( MovimientoFields );
end;

procedure TMntMovForm.MovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaMovimiento( MovimientoFields );
end;

procedure TMntMovForm.MovimientoTableSetKey(DataSet: TDataSet);
begin
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntMovForm.ActualizaEstado;
begin
     ShowFocusedRowHighlited := False;
end;

procedure TMntMovForm.MovimientoTableUpdateState(DataSet: TDataSet);
begin
     If   FormManager.FormInitialized and not MovimientoTable.ControlsDisabled
     then begin
          LineaMovimientoDataSource.Enabled := MovimientoTable.State<>dsSetKey;
          ActualizaEstado;
          Movimiento.RetiraDocumento( MovimientoFields );
          end;
end;

procedure TMntMovForm.PopupMenuPopup(Sender: TObject);
begin
     With LineaMovimientoFields do
       begin
       If   ValueIsEmpty( NroRegistroOrigen.Value ) or not ( TipoMovimientoOrigen.Value in [ tmInventario..tmMaximoUsuario ] )
       then begin
            EditarDocItem.Enabled := False;
            If   MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra, tmPresupuesto, tmPedidoVenta, tmVenta ]
            then EditarDocItem.Caption := RsMsg4
            else EditarDocItem.Caption := RsMsg9;
            end
       else begin
            EditarDocItem.Enabled := True;
            EditarDocItem.Caption := Format( 'Editar %s origen', [ Movimiento.TextoTipoMovimiento( TipoMovimientoOrigen.Value, False ) ] );
            end;
       FichaArticuloItem.Enabled := CodigoArticulo.Value<>ArticuloNulo;
       MostrarAnotacionesItem.Down := GridView.Preview.Visible;
       end;
end;

procedure TMntMovForm.RelationsPopupMenuPopup(Sender: TObject);
begin
     DocumentoItem.Caption := Movimiento.TextoTipoMovimiento( MovimientoFields.TipoMovimiento.Value, False, True );
end;

function TMntMovForm.TableViewManagerCanShiftRow: Boolean;
begin
     Result := not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

function TMntMovForm.TableViewManagerCanUpdateRow: Boolean;
begin
     Result := ( MovimientoTable.State=dsEdit ) and
               not ( MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmVenta ] ) and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value );
end;

procedure TMntMovForm.TableViewManagerRowShift(ShiftOperation: TShiftOperation);

var  HaciaArriba,
     HastaElFinal : Boolean;

begin
     HaciaArriba := ( ShiftOperation=soFirst ) or ( ShiftOperation= soPrior );
     HastaElFinal := ( ShiftOperation= soFirst ) or ( ShiftOperation=soLast );
     With LineaMovimientoFields do
       Movimiento.DesplazaLineaMovimiento( Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value, HaciaArriba, HastaElFinal );
end;

procedure TMntMovForm.TipoMovimientoCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTiposMovimientoAlmacen( [ Sender.EditingValue ] );
end;

procedure TMntMovForm.TipoMovimientoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTiposMovimientoAlmacen( Sender );
end;

procedure TMntMovForm.TipoMovimientoCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin

     TipoMovAlmacen.Valida( Sender, DisplayValue, ErrorText, Error );

     If   not Error
     then begin

          var TipoMovimiento := VarToInteger( DisplayValue );

          GridViewFechaCaducidad.Visible := DataModule00.Trazabilidad  and
                                            ( ( ( TipoMovimiento in [ tmInventario, tmRegularizacion, tmEntrada, tmCompra, tmFabricacion ] ) and DataModule00.DmEmpresaFields.Compras_FechaCaducidad.Value ) or
                                              ( ( TipoMovimiento in [ tmSalida, tmVenta ] ) and DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value ) );

          If   TipoMovimientoCtrl.Editing
          then If   TipoMovimiento in [ tmReubicacionCarga, tmOferta..tmRecuperado ]
               then begin
                    Error := True;
                    ErrorText := JoinMessage( RsMsg4, RsMsg5 );
                    end;

          end;
end;

procedure TMntMovForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( MovimientoFields.TipoMovimiento.Value,
                               MovimientoFields.NroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

end.



