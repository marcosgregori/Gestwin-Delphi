unit a_hdc;

interface

uses StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics, Generics.Collections,

     LibUtils,
     AppContainer,

     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar,
    cxCurrencyEdit, dxmdaset, cxSpinEdit, cxCalc, dxSkinsCore, dxSkinsDefaultPainters,
    dxSkinscxPCPainter, cxLookAndFeels, cxGroupBox, cxLabel,
    cxNavigator, dxBar, dxDateRanges,

    Gim10Fields,
    Gim30Fields,
    Gim40Fields,

    Gdm40Dm,

    AppForms,
    GridTableViewController,

    f_sto,
    f_rdc,

    dm_mov,
    dm_fdv,
    dm_lma, dxScrollbarAnnotations, dxUIAClasses;

type
  TMntHdcForm = class(TgxForm)
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
    HojaCargaTable: TnxeTable;
    HojaCargaDataSource: TDataSource;
    LineaHojaCargaTable: TnxeTable;
    LineaHojaCargaDataSource: TDataSource;
    TableViewManager: TGridTableViewController;
    NroOperacionCtrl: TcxDBSpinEdit;
    TransportistaCtrl: TcxDBTextEdit;
    LineaHojaCargaTableCodigoCliente: TWideStringField;
    LineaHojaCargaTableCodigoArticulo: TWideStringField;
    LineaHojaCargaTableCodigoClaseA: TWideStringField;
    LineaHojaCargaTableCodigoClaseB: TWideStringField;
    LineaHojaCargaTableCodigoClaseC: TWideStringField;
    LineaHojaCargaTableLoteFabricacion: TWideStringField;
    LineaHojaCargaTableDescripcion: TWideStringField;
    LineaHojaCargaTableCantidad: TBCDField;
    LineaHojaCargaTableServido: TBCDField;
    NoProcesarCtrl: TcxDBCheckBox;
    GridViewEjercicioOrigen: TcxGridDBColumn;
    GridViewNroDocumentoOrigen: TcxGridDBColumn;
    GridViewCodigoCliente: TcxGridDBColumn;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCodigoAlmacen: TcxGridDBColumn;
    GridViewCargado: TcxGridDBColumn;
    GridViewLoteFabricacion: TcxGridDBColumn;
    LineaHojaCargaTablePendiente: TBCDField;
    GridViewPendiente: TcxGridDBColumn;
    ImportarButton: TgBitBtn;
    LineaHojaCargaTableNroDocumentoOrigen: TIntegerField;
    MovimientoOrigenTable: TnxeTable;
    LineaMovimientoTable: TnxeTable;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    Label3: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    TituloDocumentoLabel: TcxLabel;
    ReubicarButton: TgBitBtn;
    LineaHojaCargaTableNroDocumentoDestino: TIntegerField;
    LineaHojaCargaTableSerieDocumentoDestino: TWideStringField;
    GridViewNroDocumentoDestino: TcxGridDBColumn;
    GridViewSerieDocumentoDestino: TcxGridDBColumn;
    MovimientoDestinoTable: TnxeTable;
    LineaHojaCargaTableEjercicio: TSmallintField;
    LineaHojaCargaTableNroHoja: TIntegerField;
    LineaHojaCargaTableNroLinea: TSmallintField;
    LineaHojaCargaTableEjercicioOrigen: TSmallintField;
    LineaHojaCargaTableNroOperacionOrigen: TIntegerField;
    LineaHojaCargaTableNroRegistroOrigen: TIntegerField;
    LineaHojaCargaTableCodigoAlmacen: TWideStringField;
    LineaHojaCargaTableCargado: TBCDField;
    LineaHojaCargaTableNroOperacionDestino: TIntegerField;
    LineaHojaCargaTableNroRegistroDestino: TIntegerField;
    LineaHojaCargaTableAnotacion: TWideMemoField;
    LineaHojaCargaTableEjercicioDestino: TSmallintField;
    LineaHojaCargaTableSerieDocumentoOrigen: TWideStringField;
    GridViewSerieDocumentoOrigen: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
    LineaHojaCargaTableUbicacion: TWideStringField;
    GridViewUbicacion: TcxGridDBColumn;
    LineaHojaCargaTableExisteDocumentoDestino: TBooleanField;
    GridViewExisteDocumentoDestino: TcxGridDBColumn;
    LineaHojaCargaTableExisteDocumentoOrigen: TBooleanField;
    GridViewExisteDocumentoOrigen: TcxGridDBColumn;
    GridViewNroCajas: TcxGridDBColumn;
    LineaHojaCargaTableNroCajas: TBCDField;
    AlbaranesButton: TgBitBtn;
    LineaHojaCargaTableCabeceraCliente: TStringField;
    GridViewCabeceraCliente: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    RelacionesPopupMenu: TdxBarPopupMenu;
    FichaArticuloItem: TdxBarButton;
    FichaMovimientosItem: TdxBarButton;
    EditarDocumentoOrigenItem: TdxBarButton;
    EditarDocumentoDestinoItem: TdxBarButton;
    ReubicacionItem: TdxBarButton;
    procedure FormManagerInitializeForm;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure HojaCargaTableSetKey(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure LineaHojaCargaTableCalcFields(DataSet: TDataSet);
    procedure GridViewDescripcionPropertiesAnnotationRequest(Sender: TcxCustomEdit);
    procedure HojaCargaTableNewRecord(DataSet: TDataSet);
    procedure GridViewCodigoAlmacenPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewCodigoAlmacenPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure HojaCargaTableRecordChanged(DataSet: TDataSet);
    procedure HojaCargaTableUpdateState(DataSet: TDataSet);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure PopupMenuPopup(Sender: TObject);
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure HojaCargaTableBeforeScroll(DataSet: TDataSet);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure LineaHojaCargaTableAfterOpen(DataSet: TDataSet);
    procedure LineaHojaCargaTableAfterClose(DataSet: TDataSet);
    procedure GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure TransportistaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure ImportarButtonClick(Sender: TObject);
    procedure LineaHojaCargaTableBeforeOpen(DataSet: TDataSet);
    procedure EditarDocumentoOrigenItemClick(Sender: TObject);
    procedure EditarDocumentoDestinoItemClick(Sender: TObject);
    procedure ExportarButtonClick(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    function HojaCargaTableGetAutoIncValue(Dataset: TDataSet): Integer;
    function HojaCargaTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure FormManagerFocusedAreaChanged;
    procedure FormManagerReportFormRequest;
    procedure GridViewUbicacionPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure GridViewUbicacionPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure TableViewManagerDelete(Sender: TObject);
    procedure GridViewNroCajasPropertiesValuePosted(Sender: TObject);
    procedure GridViewCargadoPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    function TableViewManagerCanInsertRow: Boolean;
    procedure TableViewManagerInsert(Sender: TObject);
    procedure ReubicarButtonClick(Sender: TObject);
    function FormManagerActivateRelatedDocsButton: Boolean;
    procedure ReubicacionItemClick(Sender: TObject);
    procedure GridViewSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure GridViewCodigoClienteGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure HojaCargaTableGetRecord(DataSet: TDataSet);
    procedure HojaCargaTableBeforePost(DataSet: TDataSet);
    procedure GridViewCustomDrawFooterCell(Sender: TcxGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo;
      var ADone: Boolean);
    procedure FichaMovimientosItemClick(Sender: TObject);
  private
    StockFrame : TStockFrame;
    ShowFocusedRowHighlited : Boolean;
    CantidadCargadaTotal,
    PesoTotal : Decimal;
    procedure DoOnProcessFinished;
    procedure ImportaDocumento;

  protected

  public

    HojaCargaFields : THojaCargaFields;
    LineaHojaCargaFields : TLineaHojaCargaFields;
    ArticuloFields : TArticuloFields;
    MovimientoOrigenFields,
    MovimientoDestinoFields : TMovimientoFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    CantidadTotal : Decimal;

    ExisteUnDocumentoDestinoNoValido : Boolean;

    procedure ActualizaEstado;
    function  ObtenUltimoNroLinea : SmallInt;
    procedure HighliteRow( RowIndex : LongInt );
    procedure DoImportaDocumento;
    procedure DoFilterRecord( LineaMovimientoOrigenFields : TLineaMovimientoFields; var Accept : Boolean );
    procedure DoCalcFields( LineaMovimientoOrigenFields : TLineaMovimientoFields );
    procedure DoInsertaLineasDocumentoOrigen( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera, NoVincularDocumentos  : Boolean; LineArray : TLongIntArray );
  end;

var  MntHdcForm : TMntHdcForm = nil;

function MntHojasCarga( Values : array of const ) : TMntHdcForm;

implementation

{$R *.DFM}

uses   Types,
       Variants,
       Windows,
       SysUtils,
       AppManager,
       EnterpriseDataAccess,

       cxGridCommon,

       Gdm00Dm,
       Gdm40Frm,

       dmi_mov,

       dm_sto,
       dm_cls,
       dm_art,
       dm_alm,
       dm_ubi,
       dm_tra,
       dm_cli,
       dm_sdf,
       dm_rcl,
       dm_hdc,

       bx_not,
       b_fda,
       b_cma,
       b_sdv,
       b_mve,
       b_gas,
       b_gmr,

       a_pde4,

       a_tra,
       a_art,
       a_cli,
       a_cls,
       a_alm,
       a_ubi,
       a_sdf,
       a_mco,
       a_mve,
       a_mov,

       cx_hdc,
       cx_cls1,
       cx_art,
       cx_alm,
       cx_ubi,
       cx_epu,
       cx_tra,
       cx_sdf,

       l_hdc,
       i_hdc;

resourceString

   RsMsg1 = 'Procesada (generados albaranes de salida).';
   RsMsg2 = 'Existen datos no actualizados.';
   RsMsg3 = 'Al menos un albarán generado a partir de ésta hoja de carga ha sido suprimido.'#13'¿Desea rejustar el estado de las líneas de la hoja carga?';
   RsMsg4 = '¿Desea generar los albaranes de salida?';
   RsMsg5 = 'Confirme que desea generar los albaranes de salida de esta hoja de carga.';
   RsMsg6 = 'Nº pedido';
   RsMsg7 = 'Nº albarán';
   RsMsg8 = 'Este valor es necesario. Debe indicar alguna cantidad cargada.';
   RsMsg9 = 'Reubicada (Operacion nº %d) ';

function MntHojasCarga( Values : array of const ) : TMntHdcForm;
begin
     CreateEditForm( TMntHdcForm, MntHdcForm, Values, Gds40Frm.PrevisionSection );
     Result := MntHdcForm;
end;

function TMntHdcForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := HojaCargaFields.NroOperacionReubicacion.Value<>0;
end;

procedure TMntHdcForm.FormManagerFocusedAreaChanged;
begin
     If   ( HojaCargaTable.State=dsBrowse ) and FormManager.DataAreaFocused
     then If   ( HojaCargaFields.Procesado.Value ) and ExisteUnDocumentoDestinoNoValido
          then If   ShowNotification( ntQuestionWarning, RsMsg2, RsMsg3 )=mrYes
               then begin
                    HojaCarga.RevisaVinculos( LineaHojaCargaFields );
                    If   Assigned( MntHdcForm )
                    then MntHdcForm.HojaCargaTable.Refresh;
                    ExisteUnDocumentoDestinoNoValido := False;
                    end;
end;

procedure TMntHdcForm.FormManagerInitializeForm;
begin

     HojaCargaFields := THojaCargaFields.Create( HojaCargaTable );

     With DataModule00.DmEmpresaFields do
       If   Ventas_VerStock.Value
       then StockFrame := CreaPanelStock( scVentas, TopPanel, GridView );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       GridViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewSerieDocumentoDestino.Visible := PedidoEnOrigen;
       GridViewNroDocumentoDestino.Visible := PedidoEnOrigen;
       GridViewExisteDocumentoDestino.Visible := PedidoEnOrigen;

       If   PedidoEnOrigen
       then GridViewNroDocumentoOrigen.Caption := RsMsg6
       else GridViewNroDocumentoOrigen.Caption := RsMsg7;

       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewCantidad.Visible := not PedidoEnOrigen;
       GridViewPendiente.Visible := PedidoEnOrigen;

       SetColumnsDecimals( [ GridViewCantidad, GridViewPendiente, GridViewCargado ], Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Ventas_DecCajas.Value );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       SetFooterSummaryItemDecimals( GridView, 0, Ventas_DecCantidad.Value );

       // Si no hay que mostrar el peso, oculto el sumatorio

       If   not DataModule00.DmEmpresaFields.Articulo_Bultos.Value
       then GridView.DataController.Summary.FooterSummaryItems[ 1 ].Free;

       end;

     SetBarItemVisible( EditarDocumentoDestinoItem, PedidoEnOrigen );

     Grid.ShowHint := True;

     HojaCargaTable.SetDefaultRangeValues( [ ApplicationContainer.Ejercicio - 1 ], [ ApplicationContainer.Ejercicio ] );
     SetFieldRange( HojaCargaFields.NroHoja );

end;

procedure TMntHdcForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
      ConsultaHojasCarga( Sender, qgsLinked );
end;

procedure TMntHdcForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntHdcForm.GridEnter(Sender: TObject);
begin
     If   ( HojaCargaTable.State=dsEdit ) and
          ( LineaHojaCargaTable.RecordCount=0 )
     then ImportarButton.Click;
end;

procedure TMntHdcForm.GridViewCargadoPropertiesValidate(      Sender       : TcxCustomEdit;
                                                          var DisplayValue : Variant;
                                                          var ErrorText    : TCaption;
                                                          var Error        : Boolean );

var  Cargado : Decimal;

begin

     // Utilizo la comprobación directa y no fijo el campo como Required para evitar que se asigne a esta columna el FirstColumnRequired

     Cargado := VarToDecimal( DisplayValue );
     If   Cargado<=0.0
     then begin
          Error := True;
          ErrorText := RsMsg8;
          end;
end;

procedure TMntHdcForm.GridViewCellClick(     Sender        : TcxCustomGridTableView;
                                             ACellViewInfo : TcxGridTableDataCellViewInfo;
                                             AButton       : TMouseButton;
                                             AShift        : TShiftState;
                                         var AHandled      : Boolean );

var  TipoMovimientoOrigen : TTipoMovimiento;

begin
     If   ( ACellViewInfo.Item.Index=GridViewExisteDocumentoOrigen.Index ) and ( ACellViewInfo.Item.EditValue )
     then MntMovimientosPorNroRegistro( LineaHojaCargaFields.NroRegistroOrigen.Value )
     else If   ( ACellViewInfo.Item.Index=GridViewExisteDocumentoDestino.Index ) and ( ACellViewInfo.Item.EditValue )
          then begin
               MntMovimientosPorNroRegistro( LineaHojaCargaFields.NroRegistroDestino.Value );
               AHandled := True;
               end;
end;

procedure TMntHdcForm.GridViewCodigoAlmacenPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntAlmacenes( [ Sender.EditingValue ] );
end;

procedure TMntHdcForm.GridViewCodigoAlmacenPropertiesEnter(Sender: TcxCustomEdit);
begin
     Almacen.SetDefault( Sender, scVentas, ArticuloFields );
end;

procedure TMntHdcForm.GridViewCodigoAlmacenPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TMntHdcForm.GridViewCodigoAlmacenPropertiesValidate(     Sender       : TcxCustomEdit;
                                                               var DisplayValue : Variant;
                                                               var ErrorText    : TCaption;
                                                               var Error        : Boolean );
begin
     Almacen.Valida( scVentas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TMntHdcForm.GridViewCodigoClienteGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                               ARecord : TcxCustomGridRecord;
                                                           var AText   : string );
begin
     AText := GridView.DataController.Values[ ARecord.RecordIndex, GridViewCabeceraCliente.Index ];
end;

procedure TMntHdcForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   ShowFocusedRowHighlited and ( AViewInfo.RecordViewInfo.Index=GridView.Controller.FocusedRowIndex )
     then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TMntHdcForm.GridViewCustomDrawFooterCell(     Sender    : TcxGridTableView;
                                                        ACanvas   : TcxCanvas;
                                                        AViewInfo : TcxGridColumnHeaderViewInfo;
                                                    var ADone     : Boolean );
var  ARec : TRect;
     ATextToDraw : String;

begin
     If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value and
          ( AViewInfo.Column=GridViewDescripcion )
     then begin
          {
          ARec := AViewInfo.TextAreaBounds;
          ATextToDRaw := 'Peso total = ' + StrFormat( PesoTotal, 2 );
          SetBkMode( ACanvas.Canvas.Handle, TRANSPARENT);
          ACanvas.DrawText( ATextToDraw, ARec, DT_RIGHT );
          ADone := True;
          }
          AViewInfo.AlignmentHorz := taRightJustify;
          AViewInfo.Text := 'Peso total = ' + StrFormat( PesoTotal, 2 );
          end;
end;

procedure TMntHdcForm.GridViewSummary(     ASender      : TcxDataSummaryItems;
                                           Arguments    : TcxSummaryEventArguments;
                                       var OutArguments : TcxSummaryEventOutArguments );
var  CodigoArticulo : String;

begin
     If   Assigned( ArticuloFields ) and
          DataModule00.DmEmpresaFields.Articulo_Bultos.Value and
          ( Arguments.SummaryItem.Index=0 )
     then With GridView.DataController, Arguments do
            begin
            If   Arguments.RecordIndex=0
            then PesoTotal := 0.0;
            CodigoArticulo := VarToStr( GetValue( RecordIndex, GridViewCodigoArticulo.Index ) );
            Articulo.Obten( CodigoArticulo, ArticuloFields );
            DecAdd( PesoTotal, ArticuloFields.Kilos.Value * VarToDecimal( GetValue( RecordIndex, GridViewCargado.Index ) ) );
            end;
end;

procedure TMntHdcForm.GridViewDescripcionPropertiesAnnotationRequest(Sender: TcxCustomEdit);
begin
     MntAnotacion( LineaHojaCargaFields.Anotacion, RsAnotacionLinea );
end;

procedure TMntHdcForm.GridViewFocusedRecordChanged( Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     ActualizaEstado;
end;

procedure TMntHdcForm.GridViewNroCajasPropertiesValuePosted(Sender: TObject);
begin
     With GridViewNroCajas do
       If   Editing
       then LineaHojaCargaFields.Cargado.Value := EditValue * ArticuloFields.UnidadesPorCaja.Value;
end;

procedure TMntHdcForm.GridViewUbicacionPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       MntUbicaciones( [ CodigoAlmacen.Value, Sender.EditingValue ] );
end;

procedure TMntHdcForm.GridViewUbicacionPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With LineaMovimientoFields do
       If   ShiftKey
       then ConsultaUbicaciones( CodigoAlmacen.Value, ubNormal, Sender )
       else ConsultaExistenciasUbicacion( CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, LoteFabricacion.Value, CodigoAlmacen.Value, Sender );
end;

procedure TMntHdcForm.GridViewUbicacionPropertiesValidate(     Sender       : TcxCustomEdit;
                                                           var DisplayValue : Variant;
                                                           var ErrorText    : TCaption;
                                                           var Error        : Boolean );
begin
     Ubicacion.Valida( LineaMovimientoFields.CodigoAlmacen.Value, False, Sender, DisplayValue, ErrorText, Error );
end;

function TMntHdcForm.ObtenUltimoNroLinea : SmallInt;
begin
     With LineaHojaCargaTable do
       begin
       Last;
       If   ValueIsEmpty( LineaHojaCargaFields.NroLinea.Value )
       then Result := 1
       else Result := LineaHojaCargaFields.NroLinea.Value + 1;
       end;
end;

function TMntHdcForm.TableViewManagerCanInsertRow: Boolean;
begin
     Result := True;
end;

procedure TMntHdcForm.TableViewManagerDelete(Sender: TObject);
begin
     // Solo para que se muestre el botón de supresión siempre
end;

procedure TMntHdcForm.TableViewManagerInsert(Sender: TObject);
begin
     ImportaDocumento;
     Abort; // Para evitar que la inserción de la línea se haga efectiva
end;

procedure TMntHdcForm.FormManagerNoteRequest;
begin
     MntAnotacion( HojaCargaFields.Anotacion, RsAnotacionDocumento );
end;

procedure TMntHdcForm.FormManagerReportFormRequest;
begin
     ImpresoHojasCarga( HojaCargaFields.NroHoja.Value );
end;

procedure TMntHdcForm.FormManagerReportRequest;
begin
     ListadoHojasCarga( HojaCargaFields.NroHoja.Value );
end;

procedure TMntHdcForm.LineaHojaCargaTableAfterOpen(DataSet: TDataSet);
begin
     LineaHojaCargaFields := TLineaHojaCargaFields.Create( LineaHojaCargaTable );
     SetFieldsRange( [ LineaHojaCargaFields.NroLinea ] );
end;

procedure TMntHdcForm.LineaHojaCargaTableBeforeOpen(DataSet: TDataSet);
begin

     MovimientoOrigenTable.Open;
     MovimientoDestinoTable.Open;
     LineaMovimientoTable.Open;

     MovimientoOrigenFields := TMovimientoFields.Create( MovimientoOrigenTable );
     MovimientoDestinoFields := TMovimientoFields.Create( MovimientoDestinoTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     // La primer vez lo necesito ya mismo para el evento OnCalcFields

     If   not Assigned( ArticuloFields )
     then ArticuloFields := TArticuloFields.Create( Self );
end;

procedure TMntHdcForm.LineaHojaCargaTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( LineaHojaCargaFields );
end;

procedure TMntHdcForm.LineaHojaCargaTableCalcFields(DataSet: TDataSet);

var  MovimientoOrigenValido,
     MovimientoDestinoValido : Boolean;

begin
     If   Assigned( ArticuloFields ) and
          Assigned( MovimientoOrigenFields ) and
          Assigned( MovimientoDestinoFields ) and
          Assigned( LineaMovimientoFields )
     then If   LineaMovimientoTable.FindKey( [ LineaHojaCargaTableNroRegistroOrigen.Value ] )
          then With LineaMovimientoFields do
                 begin

                 If   LineaHojaCargaTableNroOperacionOrigen.Value<>0
                 then begin
                      MovimientoOrigenValido := MovimientoOrigenTable.FindKey( [ LineaHojaCargaTableEjercicioOrigen.Value, LineaHojaCargaTableNroOperacionOrigen.Value ] );
                      If   MovimientoOrigenValido
                      then begin
                           LineaHojaCargaTableExisteDocumentoOrigen.Value := True;
                           LineaHojaCargaTableSerieDocumentoOrigen.Value := MovimientoOrigenFields.Serie.Value;
                           LineaHojaCargaTableNroDocumentoOrigen.Value := MovimientoOrigenFields.NroDocumento.Value;
                           LineaHojaCargaTableCodigoCliente.Value := MovimientoOrigenFields.Propietario.Value;
                           end;
                      end;

                 LineaHojaCargaTableCodigoArticulo.Value := CodigoArticulo.Value;
                 LineaHojaCargaTableCodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                 LineaHojaCargaTableCodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                 LineaHojaCargaTableCodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;
                 LineaHojaCargaTableLoteFabricacion.Value := LineaMovimientoFields.LoteFabricacion.Value;
                 LineaHojaCargaTableDescripcion.Value := LineaMovimientoFields.Descripcion.Value;

                 Articulo.Obten( LineaHojaCargaTableCodigoArticulo.Value, ArticuloFields );

                 LineaHojaCargaTableCabeceraCliente.Value := Format( 'Cliente : %s, %s', [ LineaHojaCargaTableCodigoCliente.Value, Cliente.Descripcion( LineaHojaCargaTableCodigoCliente.Value ) ] );

                 If   PedidoEnOrigen
                 then LineaHojaCargaTableCantidad.Value := LineaMovimientoFields.Cantidad.Value
                 else LineaHojaCargaTableCantidad.Value := -LineaMovimientoFields.Cantidad.Value;

                 LineaHojaCargaTableServido.Value := LineaMovimientoFields.CantidadProcesada.Value;
                 LineaHojaCargaTablePendiente.Value := LineaHojaCargaTableCantidad.Value - LineaHojaCargaTableServido.Value;

                 If   LineaHojaCargaTableNroOperacionDestino.Value<>0
                 then begin
                      MovimientoDestinoValido := MovimientoDestinoTable.FindKey( [ LineaHojaCargaTableEjercicioDestino.Value, LineaHojaCargaTableNroOperacionDestino.Value ] );
                      If   not MovimientoDestinoValido
                      then ExisteUnDocumentoDestinoNoValido := True;
                      If   MovimientoDestinoValido
                      then begin
                           LineaHojaCargaTableExisteDocumentoDestino.Value := True;
                           LineaHojaCargaTableSerieDocumentoDestino.Value := MovimientoDestinoFields.Serie.Value;
                           LineaHojaCargaTableNroDocumentoDestino.Value := MovimientoDestinoFields.NroDocumento.Value;
                           end;
                      end;

                 end;
end;

procedure TMntHdcForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With HojaCargaTable do
       begin
       // KeyValues : Ejercicio;NroHoja
       KeyValues[ 0 ] := ApplicationContainer.Ejercicio;
       KeyValues[ 1 ] := UnAssigned;
       end;
end;

procedure TMntHdcForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

procedure TMntHdcForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaHojaCargaTableCodigoArticulo.Value ] );
end;

procedure TMntHdcForm.FichaMovimientosItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaHojaCargaTableCodigoArticulo.Value ] );
end;

procedure TMntHdcForm.HojaCargaTableBeforePost(DataSet: TDataSet);
begin
     HojaCarga.CompruebaMovimientoReubicacion( HojaCargaFields );
end;

procedure TMntHdcForm.HojaCargaTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
     ExisteUnDocumentoDestinoNoValido := False;
end;

function TMntHdcForm.HojaCargaTableCanEditRecord( Dataset : TDataSet ) : Boolean;
begin
     Result := not HojaCargaFields.Procesado.Value;
end;

function TMntHdcForm.HojaCargaTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := HojaCarga.ProximoNroHoja;
end;

procedure TMntHdcForm.HojaCargaTableGetRecord(DataSet: TDataSet);
begin
     GridView.ViewData.Expand( True );
end;

procedure TMntHdcForm.HojaCargaTableNewRecord(DataSet: TDataSet);
begin
     With HojaCargaFields do
       begin
       Fecha.Value := ApplicationContainer.TodayDate;
       NoProcesar.Value := False;
       Procesado.Value := False;
       end;
end;

procedure TMntHdcForm.HojaCargaTableRecordChanged(DataSet: TDataSet);

var  Msg : String;

begin
     Msg := '';
     If   ( HojaCargaFields.Ejercicio.Value<>0 ) and ( HojaCargaFields.Ejercicio.Value<>ApplicationContainer.Ejercicio )
     then Msg := Format( 'Ejercicio %d. ', [ HojaCargaFields.Ejercicio.Value ] );
     If   HojaCargaFields.NroOperacionReubicacion.Value<>0
     then Msg := Msg + Format( RsMsg9, [ HojaCargaFields.NroOperacionReubicacion.Value ] );
     If   HojaCargaFields.Procesado.Value
     then Msg := Msg + RsMsg1;
     EstadoLabel.Caption := Msg;
end;

procedure TMntHdcForm.HojaCargaTableSetKey(DataSet: TDataSet);
begin
     HojaCargaFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntHdcForm.ActualizaEstado;
begin
     ShowFocusedRowHighlited := False;
     If   Assigned( TableViewManager.DeleteButton )
     then TableViewManager.DeleteButton.Enabled := Grid.IsFocused and not LineaHojaCargaTableExisteDocumentoDestino.Value;
end;

procedure TMntHdcForm.HojaCargaTableUpdateState(DataSet: TDataSet);

var  BotonActivo : Boolean;

begin

     // El proceso de reubicación no puede realizarse si ya se han generado los albaranes de salida, porque en la reubicación se
     // modifican las ubicaciones de la misma hoja de carga.

     LineaHojaCargaDataSource.Enabled := HojaCargaTable.State<>dsSetKey;
     BotonActivo := FormManager.DataAreaFocused and ( HojaCargaTable.State in [ dsBrowse, dsEdit ] );
     ReubicarButton.Enabled := BotonActivo  and ( HojaCargaFields.NroOperacionReubicacion.Value=0 ) and not HojaCargaFields.Procesado.Value;
     AlbaranesButton.Enabled := BotonActivo and not HojaCargaFields.Procesado.Value;
     ImportarButton.Enabled := ReubicarButton.Enabled;

     ActualizaEstado;

end;

procedure TMntHdcForm.ImportarButtonClick(Sender: TObject);
begin
     ImportaDocumento;
end;

procedure TMntHdcForm.ImportaDocumento;

var  TipoMovimiento : TTipoMovimiento;

begin
     HojaCargaTable.Update;
     If   PedidoEnOrigen
     then TipoMovimiento := tmPedidoVenta
     else TipoMovimiento := tmVenta;
     ImportaDocumentoVenta( '', DoImportaDocumento, tmHojaCarga, [ TipoMovimiento ] );
end;

procedure TMntHdcForm.DoImportaDocumento;
begin
     With BoxSdvForm do
       SeleccionaLineasDocumentoVenta( DataTipoMovimiento.Value,
                                       DataEjercicio.Value,
                                       DataNroOperacion.Value,
                                       tmHojaCarga,
                                       DoInsertaLineasDocumentoOrigen,
                                       DoFilterRecord,
                                       DoCalcFields,
                                       False );
end;

procedure TMntHdcForm.DoFilterRecord(     LineaMovimientoOrigenFields : TLineaMovimientoFields;
                                      var Accept                      : Boolean );

var  CantidadCargadaLinea : Decimal;

begin
     With LineaMovimientoOrigenFields do
       begin
       CantidadCargadaLinea := HojaCarga.ObtenCantidadCargada( NroRegistro.Value );
       If   PedidoEnOrigen
       then Accept :=  not Procesada.Value and ( CantidadCargadaLinea<( Cantidad.Value - CantidadProcesada.Value ) )
       else Accept :=  CantidadCargadaLinea<Cantidad.Value;
       end;
end;

procedure TMntHdcForm.DoCalcFields( LineaMovimientoOrigenFields : TLineaMovimientoFields );
begin
     With BoxMveForm do
       begin
       LineaMovimientoOrigenTableCantidadCargada.Value := HojaCarga.ObtenCantidadCargada( LineaMovimientoOrigenTableNroRegistro.Value );
       LinesViewCantidadCargada.Visible := True;
       end;
end;

procedure TMntHdcForm.DoInsertaLineasDocumentoOrigen( MovimientoOrigenFields : TMovimientoFields; 
                                                      CopiarDatosCabecera, 
                                                      NoVincularDocumentos   : Boolean; 
                                                      LineArray              : TLongIntArray );

var   NroOperacion,
      NroRegistroLinea : LongInt;
      UltimoNroLinea : SmallInt;
      EjercicioDocumentoOrigen,
      Index : SmallInt;
      CantidadCargada,
      CantidadACargar : Decimal;

begin

     With BoxMveForm do
       try

         LineaHojaCargaTable.DisableControls;

         UltimoNroLinea := ObtenUltimoNroLinea;

         With LineaMovimientoOrigenFields.Table do
           begin
           DisableControls;
           MasterSource := nil;
           IndexFieldNames := 'NroRegistro';
           end;

         With LineList do
           For Index := 0 to Count - 1 do
             begin
             NroRegistroLinea := LongInt( Items[ Index ] );
             If   LineaMovimientoOrigenTable.FindKey( [ NroRegistroLinea ] )
             then HojaCarga.InsertaLinea( HojaCargaFields, LineaMovimientoOrigenFields, UltimoNroLinea );
             end;

       finally

         Self.Grid.SetFocus;
         With LineaHojaCargaTable do
           begin
           EnableControls;
           Refresh;
           Last;
           end;

         GridView.ViewData.Expand( True );

         ActualizaMovimientosVenta( MovimientoOrigenFields.TipoMovimiento.Value );
         end;

end;

procedure TMntHdcForm.EditarDocumentoDestinoItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaHojaCargaFields.NroRegistroDestino.Value );
end;

procedure TMntHdcForm.EditarDocumentoOrigenItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaHojaCargaFields.NroRegistroOrigen.Value );
end;

procedure TMntHdcForm.ExportarButtonClick(Sender: TObject);
begin
     HojaCargaTable.Refresh;
     GeneracionAlbaranesSalida( HojaCargaFields.Ejercicio.Value, HojaCargaFields.NroHoja.Value, DoOnProcessFinished );
end;

procedure TMntHdcForm.DoOnProcessFinished;
begin
     HojaCargaTable.Refresh;
     GridView.DataController.UpdateItems( False );
end;

procedure TMntHdcForm.PopupMenuPopup(Sender: TObject);
begin
     FichaArticuloItem.Enabled := LineahojaCargaTableCodigoArticulo.Value<>ArticuloManual;
     EditarDocumentoOrigenItem.Enabled := LineaHojaCargaTableExisteDocumentoOrigen.Value;
     If   PedidoEnOrigen
     then EditarDocumentoDestinoItem.Enabled := LineaHojaCargaTableExisteDocumentoDestino.Value;
end;

procedure TMntHdcForm.ReubicacionItemClick(Sender: TObject);
begin
     With HojaCargaFields do
        MntMovimientosAlmacen( [ EjercicioReubicacion.Value, NroOperacionReubicacion.Value ] );
end;

procedure TMntHdcForm.ReubicarButtonClick(Sender: TObject);
begin
     HojaCargaTable.Refresh;
     GeneracionMovimientosReubicacion( HojaCargaFields.Ejercicio.Value, HojaCargaFields.NroHoja.Value, DoOnProcessFinished );
end;

procedure TMntHdcForm.TransportistaCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntTransportistas( [ Sender.EditingValue ] );
end;

procedure TMntHdcForm.TransportistaCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaTransportistas( Sender );
end;

procedure TMntHdcForm.TransportistaCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Transportista.Valida( Sender, Displayvalue, ErrorText, Error );
end;

end.

