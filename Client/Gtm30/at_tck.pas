unit at_tck;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics, Generics.Collections,
     Menus, cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog,
    dxScrollbarAnnotations, nxdb, cxMaskEdit, cxDropDownEdit, cxCalendar,
    cxGroupBox, cxLookAndFeels, cxLabel,
    cxCurrencyEdit, dxmdaset, cxSpinEdit, dxSkinsCore,
    dxSkinsDefaultPainters, dxSkinscxPCPainter, cxButtonEdit, cxDisplayButtonEdit,
    cxScrollBox, cxNavigator, cxIntegerEdit, cxRichEdit, dxBar, dxDateRanges,

    AppContainer,
    LibUtils,
    AppManager,
    ReportManager,
    DataManager,
    AppForms,
    GridTableViewController,
    Spring,

    Gim10Fields,
    Gim30Fields,

    dmi_mov,
    dmi_sto,

    dm_mov,
    dm_fdv,
    dm_lma,
    dm_sto, dxUIAClasses;

type

  TComandosVisor = ( cvReset, cvClear, cvTopLine, cvBottomLine );

  TMntTckTouchForm = class(TgxForm)
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
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidadAjustada: TcxGridDBColumn;
    LineaMovimientoAuxTable: TnxeTable;
    GridViewPrecioIVA: TcxGridDBColumn;
    GridViewImporteTotal: TcxGridDBColumn;
    TituloDocumentoLabel: TcxLabel;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    CaptionTotalIVAIncluidoLabel: TcxLabel;
    TotalIVAIncluidoLabel: TcxLabel;
    Label3: TcxLabel;
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
    LineaMovimientoTablePesoEnvase: TBCDField;
    LineaMovimientoTableProcesada: TBooleanField;
    LineaMovimientoTableParametros: TWordField;
    LineaMovimientoTableFechaAplicacion: TDateField;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    DeleteButton: TgBitBtn;
    ImprimirButton: TgBitBtn;
    GridViewCodigoTipoIVA: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    CantidadLabel: TcxLabel;
    NroDocumentoCtrl: TcxDBDisplayButtonEdit;
    GridViewImporteNeto: TcxGridDBColumn;
    GridViewCuotaIVA: TcxGridDBColumn;
    GridViewCuotaRE: TcxGridDBColumn;
    gBitBtn1: TgBitBtn;
    CantidadPanel: TcxGroupBox;
    MasButton: TgBitBtn;
    MenosButton: TgBitBtn;
    LineaMovimientoTableFechaCaducidad: TDateField;
    LineaMovimientoTableCampoLibre1: TWideStringField;
    LineaMovimientoTableCampoLibre2: TWideStringField;
    LineaMovimientoTableCampoLibre3: TDateField;
    LineaMovimientoTableCampoLibre4: TBCDField;
    LineaMovimientoTableImporteRecargo: TBCDField;
    LineaMovimientoTablePorcentajeRecargo: TBCDField;
    LineaMovimientoTableCampoLibre5: TWideStringField;
    LineaMovimientoTableContribucionRAP: TBCDField;
    procedure FormManagerInitializeForm;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure GridViewAfterSummary(ASender: TcxDataSummary);
    procedure MovimientoTableAfterEdit(DataSet: TDataSet);
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure LineaMovimientoTableCalcFields(DataSet: TDataSet);
    procedure MovimientoTableNewRecord(DataSet: TDataSet);
    procedure GridViewFocusedItemChanged(Sender: TcxCustomGridTableView;APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure MovimientoTableRecordChanged(DataSet: TDataSet);
    procedure MovimientoTableUpdateState(DataSet: TDataSet);
    procedure LineaMovimientoTableBeforePost(DataSet: TDataSet);
    procedure FechaCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure LineaMovimientoTableNewRecord(DataSet: TDataSet);
    procedure FormManagerShowForm;
    procedure MovimientoTableBeforeScroll(DataSet: TDataSet);
    procedure GridViewFooterSummaryItems(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure LineaMovimientoTableAfterClose(DataSet: TDataSet);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure GridViewCantidadAjustadaPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);
    procedure GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
    procedure FacturaDirectaButtonClick(Sender: TObject);
    procedure GridViewPrecioIVAPropertiesValuePosted(
      Sender: TObject);
    procedure GridViewInitEditValue(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit;
      var AValue: TcxEditValue);
    procedure GridViewCantidadAjustadaPropertiesEnter(Sender: TcxCustomEdit);
    function MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
    function FormManagerGetAccessLevel: Smallint;
    procedure MovimientoTableOpenRecord(DataSet: TDataSet);
    function FormManagerActivateRelatedDocsButton: Boolean;
    function MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
    procedure GridViewPrecioIVAPropertiesValidate(
      Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
    procedure LineaMovimientoTableAfterOpen(DataSet: TDataSet);
    function MovimientoTableCheckDetailDatasets(Dataset: TDataSet;
      Posting: Boolean): Boolean;
    procedure FormManagerDeleteEmptyHeader(DataSet: TDataSet);
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
    procedure MovimientoTableRemotePost(DataSet: TDataSet);
    procedure MovimientoTableRemoteDelete(DataSet: TDataSet);
    procedure LineaMovimientoTableRemotePost(DataSet: TDataSet);
    procedure LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
    function TableViewManagerCanAlterRow: Boolean;
    procedure GridViewImporteTotalGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure MovimientoTableAfterPost(DataSet: TDataSet);
    function TableViewManagerCanShiftRow: Boolean;
    procedure TableViewManagerRowShift(ShiftOperation: TShiftOperation);
    procedure LineaMovimientoTableRecordChanged(DataSet: TDataSet);
    procedure MovimientoTableGetRecord(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure InsertaLineaClick(Sender: TObject);
    procedure BorraLineaClick(Sender: TObject);
  private

    TotalIVAIncluido : Decimal;

    ShowFocusedRowHighlited,
    FReajustandoPrecioBase : Boolean;

    ExistenciasArticulo : IExistenciasArticulo;
    PreciosConIVAIncluido : Boolean;

    function GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    function GetLineaMovimientoFields : TLineaMovimientoFields;

    procedure ActualizaCantidad;
    procedure ActualizaReferencias;
    procedure ActualizaCamposCalculadosLinea;

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
    ImporteNetoAnterior : Decimal;

    CalcularIVA : Boolean;
    AjustandoCantidad : Boolean;

    SerieActual,
    PropietarioActual : String;
    TasasArray : TTasasArray;

    procedure ActualizaRelaciones;
    procedure ActualizaValorCantidad( Value : Decimal );
    procedure ReajustaPrecioBase;
    function  ObtenUltimoNroLinea : SmallInt;

    procedure HighliteRow( RowIndex : LongInt );

    property LineaMovimientoFields : TLineaMovimientoFields read GetLineaMovimientoFields;
    property GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields read GetGrupoLineaMovimientoFields;

  end;

var  MntTckTouchForm : TMntTckTouchForm = nil;

const   idMntTckTouchForm = 9001;  // Temporal

procedure MntTickets;
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

       dmi_iva,

       Gdm00Dm,
       Gdm30Dm,

       ParametrosFacturacionIntf,
       MovimientoIntf,

       dm_pga,
       dm_ine,
       dm_usr,
       dm_art,
       dm_cli,
       dm_tca,
       dm_iva,
       dm_alm,
       dm_sdf,

       dm_reg,

       b_msg,

       // cb_art,

       ct_mve,
       ct_art;

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
   RsMsg50 =  #13'Modifique el precio con I.V.A. includo de la ficha del artículo para incluya en precio válido.';
   RsMsg51 = '¿Está seguro de que desea actualizar las relaciones del documento?';
   RsMsg52 = 'Cuando se actualiza un documento se vuelven a comprobar las relaciones del mismo, como los tipos de I.V.A. de las líneas, recalculando los importes si es necesario.'#13'' +
             'Por defecto los documentos conservan los datos impositivos originales aunque se modifique la ficha de los artículos incluídos en él, para que no se produzcan alteraciones en los importes.' ;


procedure MntTickets;
begin
     CreateEditForm( TMntTckTouchForm, MntTckTouchForm );
end;

procedure ActualizaTickets;
begin
     If   Assigned( MntTckTouchForm )
     then With MntTckTouchForm do
            begin
            BringToFront;
            MovimientoTable.Refresh;
            end;
end;

procedure TMntTckTouchForm.FormManagerInitializeForm;

var  TextoNroDocumento,
     TextoFechaAplicacion : String;
     I : SmallInt;
     CampoLibreCtrlArray : Array of TcxCustomEdit;

begin

     ID := idMntTckTouchForm;

     If   Assigned( ApplicationContainer.AppSkinPainter )
     then With ApplicationContainer.AppSkinPainter do
            TituloDocumentoLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( True );

     // -------

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     LineaMovimientoAuxFields := TLineaMovimientoFields.Create( LineaMovimientoAuxTable );

     ArticuloFields := TArticuloFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     SerieFacturacionFields := TSerieFacturacionFields.Create( Self );

     With DataModule00.DmEmpresaFields do
       begin

       PreciosConIVAIncluido := True; // Articulo_PreciosIVA.Value;

       SetColumnDecimals( GridViewCantidadAjustada, Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecioIVA, GridViewImporteTotal ] );

       // Sumatorios

       SetFooterSummaryItemDecimals( GridView, 0, Ventas_DecCantidad.Value );
       SetFooterSummaryItemsDecimals( GridView, [ 1, 2, 3 ] );

       GridViewPrecioIVA.Options.Editing := False;

       GridViewPrecioIVA.Options.Focusing := GridViewPrecioIVA.Options.Editing;
       end;

     Grid.ShowHint := True;

     MovimientoTable.SetDefaultRangeValues( [ tmVenta, ApplicationContainer.Ejercicio ], [ tmVenta, ApplicationContainer.Ejercicio ] );
     SetFieldRange( MovimientoFields.NroDocumento );

     SerieActual := #0;
     PropietarioActual := #0;

end;

{
procedure TMntTckTouchForm.FormManagerInsertRecRequest;
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
}

procedure TMntTckTouchForm.NroDocumentoCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( tmVenta, Serie.Value, '', sdTodos, Sender, qgsLinked );
end;

procedure TMntTckTouchForm.NroDocumentoCtrlPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     NroDocumentoCtrl.Description := DisplayValue;
end;

procedure TMntTckTouchForm.GridViewCantidadAjustadaPropertiesEnter(Sender: TcxCustomEdit);
begin
     If   LineaMovimientoTable.State=dsInsert
     then With GridViewCantidadAjustada do
            If   Editing and ValueIsEmpty( EditValue )
            then If   LineaMovimientoFields.TipoMovimientoOrigen.Value<>tmConsumos
                 then EditValue := 1.0
                 else If   Movimiento.DmConsumosClienteTable.FindKey( [ MovimientoFields.Propietario.Value, LineaMovimientoFields.NroRegistroOrigen.Value ] )
                      then EditValue := Movimiento.DmConsumosClienteFields.Cantidad.Value;
end;

procedure TMntTckTouchForm.GridViewCantidadAjustadaPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     If   not AjustandoCantidad
     then If   not ValueIsEmpty( LineaMovimientoFields.CodigoArticulo.Value ) and
               ( LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual )
          then If   LineaMovimientoTable.Editing and
                    ( Assigned( Sender ) and not Sender.IsEditValidated )
               then StockAlmacen.CompruebaSalida( DisplayValue, GridViewCantidadAjustada, LineaMovimientoFields, ArticuloFields, SerieFacturacionFields, ExistenciasArticulo, ClienteFields.Factura_Tarifa.Value, ErrorText, Error );
end;

procedure TMntTckTouchForm.GridViewCantidadAjustadaPropertiesValuePosted(Sender: TObject);
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

procedure TMntTckTouchForm.HighliteRow( RowIndex : LongInt );
begin
     GridView.Controller.FocusedRowIndex := RowIndex;
     ShowFocusedRowHighlited := True;
end;

procedure TMntTckTouchForm.ActualizaRelaciones;
begin
     Movimiento.ActualizaRelacionesLineaSalida( MovimientoFields, LineaMovimientoFields, ArticuloFields );
     If   LineaMovimientoFields.Oferta.Value
     then With ArticuloFields do
            ShowHintMsg( Format( RsMsg33, [ StrFormatDate( OfertaFechaInicial.Value, dfDefault2 ), StrFormatDate( OfertaFechaFinal.Value, dfDefault2 ) ] ), RsMsg34 );
end;

procedure TMntTckTouchForm.ActualizarRelacionesItemClick(Sender: TObject);
begin
     If   ShowNotification( ntQuestionWarning, RsMsg51, RsMsg52 )=mrYes
     then begin
          Movimiento.RecalculaMovimiento( MovimientoFields );
          MovimientoTable.Refresh;
          end;
end;

procedure TMntTckTouchForm.GridViewCodigoArticuloPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
     If   not Error
     then FacturaVentas.ObtenTipoIVAArticulo( MovimientoFields.Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );
end;

procedure TMntTckTouchForm.GridViewCodigoArticuloPropertiesValuePosted(Sender: TObject);

var  PrecioBase : Double;

begin

      With GridViewCodigoArticulo do
       If   Editing
       then begin
	        
			         try

              LineaMovimientoTable.DisableControls;

              LineaMovimientoFields.NumeroSerie.Value := '';
              LineaMovimientoFields.LoteFabricacion.Value := '';
              LineaMovimientoFields.Descripcion.Value := ArticuloFields.Descripcion.Value;
              LineaMovimientoFields.CodigoAlmacen.Value := Almacen.AlmacenPorDefecto( scVentas, ArticuloFields );
              LineaMovimientoFields.Ubicacion.Value := Almacen.UbicacionPorDefecto( LineaMovimientoFields.CodigoAlmacen.Value, ArticuloFields );

              If   DataModule00.DmEmpresaFields.Articulo_Cajas.Value
              then ActualizaValorCantidad( LineaMovimientoFields.NroCajas.Value * ArticuloFields.UnidadesPorCaja.Value );

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
              end;

            GridView.DataController.UpdateData;

            end;

end;

procedure TMntTckTouchForm.ActualizaReferencias;
begin

     // Debido a que el sumatorio de la rejilla es un evento que ocurre antes de que se puedan validar
     // los valores de la cabecera me veo obligado a utilizar esta función de actualización de referencias ....

     If   Assigned( ClienteFields ) and
          not ValueIsEmpty( MovimientoFields.Propietario.Value ) and
          ( ( SerieActual<>MovimientoFields.Serie.Value ) or ( PropietarioActual<>MovimientoFields.Propietario.Value ) )
     then begin

          If   SerieActual<>MovimientoFields.Serie.Value
          then SerieFacturacion.Obten( MovimientoFields.Serie.Value, SerieFacturacionFields, False );

          If   PropietarioActual<>MovimientoFields.Propietario.Value
          then Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );

          SerieActual := MovimientoFields.Serie.Value;
          PropietarioActual := MovimientoFields.Propietario.Value;

          CalcularIVA := not ( ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or SerieFacturacionFields.ExentoIVA.Value );
          end;
end;

procedure TMntTckTouchForm.ReajustaPrecioBase;

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
                 LineaMovimientoFields.Precio.Value := PrecioBase; // GridViewPrecio.EditValue := PrecioBase;
                 ActualizaCamposCalculadosLinea;
                 end;
         finally
           FReajustandoPrecioBase := False;
           end;
end;

procedure TMntTckTouchForm.ActualizaCamposCalculadosLinea;
begin
     Movimiento.ActualizaCamposCalculadosLineaVenta( MovimientoFields,
                                                     LineaMovimientoFields,
                                                     ClienteFields,
                                                     ArticuloFields,
                                                     SerieFacturacionFields,
                                                     TiposIVAFields,
                                                     PreciosConIVAIncluido );
end;

procedure TMntTckTouchForm.GridViewFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
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

procedure TMntTckTouchForm.GridViewImporteTotalGetCellHint(       Sender           : TcxCustomGridTableItem;
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
          Tasa.TipoIVA( MovimientoFields.Fecha.Value, CodigoTipoIVA, TiposIVAFields );

          HintText :=  'I.V.A. = ' + StrFormat( TiposIVAFields.IVARepercutido.Value, 1 ) + '%';
          If  ClienteFields.Factura_ModeloIVA.Value=micConRE
          then StrAdd( HintText, ', R.E. = ' + StrFormat( TiposIVAFields.RERepercutido.Value, 1 ) + '%' );

          AHintText := HintText;
          AIsHintMultiLine := False;
          AHintTextRect.Top := AHintTextRect.Top + ACellViewInfo.Height;
          end;
end;

procedure TMntTckTouchForm.GridViewImporteTotalGetDisplayText(     Sender  : TcxCustomGridTableItem;
                                                              ARecord : TcxCustomGridRecord;
                                                          var AText   : String );
begin
     AText := StrFormat( VarToDecimal( ARecord.Values[ GridViewImporteTotal.Index ] ), DecimalesMoneda, True );
end;

procedure TMntTckTouchForm.GridViewInitEditValue(     Sender : TcxCustomGridTableView;
                                                 AItem  : TcxCustomGridTableItem;
                                                 AEdit  : TcxCustomEdit;
                                             var AValue : TcxEditValue );
begin
     If   AItem=GridViewPrecioIVA
     then AValue := GridView.DataController.Values[ GridView.DataController.EditingRecordIndex, GridViewPrecioIVA.Index ];
end;

procedure TMntTckTouchForm.ActualizaValorCantidad( Value : Decimal );
begin
     GridViewCantidadAjustada.EditValue := Value;
     LineaMovimientoFields.Cantidad.Value := -Value;
     ActualizaCamposCalculadosLinea;
     ActualizaRelaciones;
end;
procedure TMntTckTouchForm.BorraLineaClick(Sender: TObject);
begin
     //..
end;

procedure TMntTckTouchForm.GridViewAfterSummary(ASender: TcxDataSummary);

var  SumaTasas : TTasaRecord;

begin

     If   Assigned( MovimientoFields ) and
          Assigned( ClienteFields ) and ClienteFields.Initialized
     then With ASender, DataModule00.DmEmpresaFields  do
            begin

            ActualizaReferencias;

            CantidadTotal := VarToDecimal( FooterSummaryValues[ 0 ] );

            FacturaVentas.AcumulaValoresImpositivos( TasasArray, MovimientoFields.Fecha.Value, ClienteFields.Factura_ModeloIVA.Value, CalcularIVA, SumaTasas );

            ImporteNetoTotal := SumaTasas.BaseImponible;
            TotalIVAIncluido := SumaTasas.Importe;

            If   PreciosConIVAIncluido
            then TotalIVAIncluido := SumaTasas.Importe
            else TotalIVAIncluido := Redondea( SumaTasas.BaseImponible ) +
                                     // Redondea( SumaTasas.ImporteEcoTasas ) +
                                     Redondea( SumaTasas.CuotaIVA ) +
                                     Redondea( SumaTasas.CuotaRE );
            
            TotalIVAIncluidoLabel.Caption := StrFormat( TotalIVAIncluido, DecimalesMoneda );
            CantidadLabel.Caption := StrFormat( CantidadTotal, Ventas_DecCantidad.Value );

            end;

     Movimiento.InicializaValoresImpositivos( TasasArray );
end;

procedure TMntTckTouchForm.GridViewPrecioIVAPropertiesValidate( Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

var  Precio : Double;

begin
     If   Assigned( Sender ) and Sender.Editing and Sender.ModifiedAfterEnter
     then Movimiento.ObtenPrecioVentaBase( TiposIVAFields,
                                           LineaMovimientoFields.Cantidad.Value,
                                           Sender.EditingValue,
                                           Precio,
                                           ClienteFields.Factura_ModeloIVA.Value=micConRE );
end;

procedure TMntTckTouchForm.GridViewPrecioIVAPropertiesValuePosted(Sender: TObject);
begin
     If   GridViewPrecioIVA.Editing
     then ReajustaPrecioBase;
end;

procedure TMntTckTouchForm.GridViewUpdatePropertiesValuePosted(Sender: TObject);
begin
     ActualizaCamposCalculadosLinea;
end;

procedure TMntTckTouchForm.GridViewFooterSummaryItems(     ASender      : TcxDataSummaryItems;
                                                      Arguments    : TcxSummaryEventArguments;
                                                  var OutArguments : TcxSummaryEventOutArguments );

var  CodigoArticulo : String;
     TipoDeIVA : SmallInt;

begin
     If   Assigned( ArticuloFields ) and ( Arguments.SummaryItem.Index=2 )
     then With GridView.DataController, Arguments do
            begin
            TipoDeIVA := VarToSmallInt( GetValue( RecordIndex, GridViewCodigoTipoIVA.Index ) );
            DecAdd( TasasArray[ TipoDeIVA ].BaseImponible, VarToDecimal( GetValue( RecordIndex, GridViewImporteNeto.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].CuotaIVA, VarToDecimal( GetValue( RecordIndex, GridViewCuotaIVA.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].CuotaRE, VarToDecimal( GetValue( RecordIndex, GridViewCuotaRE.Index ) ) );
            DecAdd( TasasArray[ TipoDeIVA ].Importe, VarToDecimal( GetValue( RecordIndex, GridViewImporteTotal.Index ) ) );
            end;
end;

procedure TMntTckTouchForm.GrupoLineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FGrupoLineaMovimientoFields );
end;

procedure TMntTckTouchForm.GrupoLineaMovimientoTableBeforeDelete( DataSet : TDataSet );
begin
     // DeleteMasterRecord solo borra los registros del primer DetailDataset (en este caso las páginas)
     // Si existen DetailDatasets de nivel inferior se tienen que suprimir a mano

     LineaMovimientoTable.DeleteRecords;
end;

procedure TMntTckTouchForm.ImprimirButtonClick(Sender: TObject);
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

function TMntTckTouchForm.ObtenUltimoNroLinea : SmallInt;
begin
     With LineaMovimientoTable do
       begin
       Last;
       If   ValueIsEmpty( LineaMovimientoFields.NroLinea.Value )
       then Result := 1
       else Result := LineaMovimientoFields.NroLinea.Value + 1;
       end;
end;

procedure TMntTckTouchForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

function TMntTckTouchForm.GetGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
begin
     If   not Assigned( FGrupoLineaMovimientoFields )
     then FGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( GrupoLineaMovimientoTable );
     Result := FGrupoLineaMovimientoFields;
end;

function TMntTckTouchForm.GetLineaMovimientoFields : TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoFields )
     then FLineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );
     Result := FLineaMovimientoFields;
end;

procedure TMntTckTouchForm.LineaMovimientoTableAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FLineaMovimientoFields );
end;

procedure TMntTckTouchForm.LineaMovimientoTableAfterOpen(DataSet: TDataSet);

var Index : SmallInt;

begin
     SetFieldRange( LineaMovimientoFields.NroLinea );
     ActualizaReferencias;
end;

procedure TMntTckTouchForm.LineaMovimientoTableBeforeInsert(DataSet: TDataSet);
begin
     // Si el cursor está situado sobre una columna no editable (ReadOnly) al iniciarse la edición el estado persiste

     SetColumnsEditingOption( GridView, True );
end;

procedure TMntTckTouchForm.ActualizaCantidad;
begin
     LineaMovimientoFields.Cantidad.Value := -LineaMovimientoTableCantidadAjustada.Value;
end;

procedure TMntTckTouchForm.LineaMovimientoTableBeforePost(DataSet: TDataSet);
begin
     If   not LineaMovimientoTable.ControlsDisabled
     then begin
          LineaMovimientoFields.Cantidad.Value := -LineaMovimientoTableCantidadAjustada.Value;
          ActualizaCamposCalculadosLinea;
          end;
end;

procedure TMntTckTouchForm.LineaMovimientoTableCalcFields(DataSet: TDataSet);
begin
     If   Assigned( LineaMovimientoFields )
     then LineaMovimientoTableTieneRegistroOrigen.Value := not ValueIsEmpty( LineaMovimientoFields.NroRegistroOrigen.Value );
end;

procedure TMntTckTouchForm.LineaMovimientoTableNewRecord(DataSet: TDataSet);
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

procedure TMntTckTouchForm.LineaMovimientoTableRecordChanged(DataSet: TDataSet);
begin
     If   LineaMovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atArticulo ] );
end;

procedure TMntTckTouchForm.LineaMovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeLineaMovimiento( MovimientoFields, LineaMovimientoFields );
end;

procedure TMntTckTouchForm.LineaMovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaLineaMovimiento( MovimientoFields, LineaMovimientoFields, True );
end;

procedure TMntTckTouchForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Serie;NroDocumento
       KeyValues[ 0 ] := tmVenta;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned;
       end;
end;

procedure TMntTckTouchForm.FacturaDirectaButtonClick(Sender: TObject);

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

procedure TMntTckTouchForm.FechaCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     ValidateYear( DisplayValue, ErrorText, Error );
end;

function TMntTckTouchForm.FormManagerActivateRelatedDocsButton: Boolean;
begin
     Result := MovimientoFields.Facturado.Value;
end;

procedure TMntTckTouchForm.FormManagerDeleteEmptyHeader(DataSet: TDataSet);
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

function TMntTckTouchForm.FormManagerGetAccessLevel: Smallint;
begin
     Result := DataModule00.DmUsuarioFields.acCACaja.Value;
end;

procedure TMntTckTouchForm.MovimientoTableAfterEdit(DataSet: TDataSet);
begin
     If   not ( MovimientoTable.UpdatingProcess ) and ( DataModule00.DmUsuarioFields.acCACaja.Value=3 )  // No puede realizar modificaciones
     then begin
          ShowNotification( ntStop, RsMsg20, '' );
          Abort;
          end;
end;

procedure TMntTckTouchForm.MovimientoTableAfterPost(DataSet: TDataSet);
begin
     GrupoLineaMovimientoTable.Refresh;
end;

procedure TMntTckTouchForm.MovimientoTableBeforeScroll(DataSet: TDataSet);
begin
     ShowFocusedRowHighlited := False;
end;

function TMntTckTouchForm.MovimientoTableCanEditRecord(Dataset: TDataSet): Boolean;
begin
     Result := EjercicioActual( MovimientoFields.Fecha.Value ) and
               not MovimientoFields.Facturado.Value and
               not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

function TMntTckTouchForm.MovimientoTableCheckDetailDatasets(Dataset: TDataSet; Posting: Boolean): Boolean;
begin

     // Aquí es especialmente importante la comprobación porque pueden existir albaranes creados desde el mantenimiento de la gestión comercial
     // con la paginación activada y en el que no existe la página 0

     Result := Movimiento.ExistenLineas( MovimientoFields );
end;

function TMntTckTouchForm.MovimientoTableGetAutoIncValue(Dataset: TDataSet): Integer;
begin
     Result := Movimiento.ProximoDocumento( MovimientoFields );
end;

procedure TMntTckTouchForm.MovimientoTableGetRecord(DataSet: TDataSet);
begin
      Cliente.Obten( MovimientoFields.Propietario.Value, '', ClienteFields );
end;

procedure TMntTckTouchForm.MovimientoTableNewRecord(DataSet: TDataSet);
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
       Revisado.Value := False;
       CentroCoste.Value := SerieFacturacionFields.CentroCoste.Value;
       end;

     ClienteFields.Clear;
end;

procedure TMntTckTouchForm.MovimientoTableOpenRecord(DataSet: TDataSet);
begin
     ImporteNetoAnterior := ImporteNetoTotal;
end;

procedure TMntTckTouchForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );
     If   MovimientoTable.State=dsBrowse
     then ApplicationContainer.HideAlerts( [ atCliente ] );
end;

procedure TMntTckTouchForm.MovimientoTableRemoteDelete(DataSet: TDataSet);
begin
     Movimiento.SuprimeMovimiento( MovimientoFields );
end;

procedure TMntTckTouchForm.MovimientoTableRemotePost(DataSet: TDataSet);
begin
     Movimiento.ActualizaMovimiento( MovimientoFields );
end;

procedure TMntTckTouchForm.MovimientoTableSetKey(DataSet: TDataSet);
begin
     MovimientoFields.TipoMovimiento.Value := tmVenta;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;
end;

procedure TMntTckTouchForm.MovimientoTableUpdateState(DataSet: TDataSet);

var  EnableDatasets : Boolean;

begin
     If   FormManager.FormInitialized and not MovimientoTable.ControlsDisabled
     then begin
          EnableDatasets := MovimientoTable.State<>dsSetKey;
          GrupoLineaDataSource.Enabled := EnableDatasets;
          LineaMovimientoDataSource.Enabled := EnableDatasets;
          Movimiento.RetiraDocumento( MovimientoFields );
          end;
end;

function TMntTckTouchForm.TableViewManagerCanAlterRow: Boolean;
begin
     If   not ValueIsEmpty( MovimientoFields.NroOperacion.Value )
     then If   not MovimientoTable.Editing
          then FormManager.SelectFirstDataControl;

     Result := not ValueIsEmpty( MovimientoFields.NroOperacion.Value ) and
               MovimientoFields.Facturado.Value and
               not ( DataModule00.DmUsuarioFields.NoModificarDocumentos.Value and ( MovimientoTable.State=dsBrowse ) );
end;

function TMntTckTouchForm.TableViewManagerCanShiftRow: Boolean;
begin
     Result := not DataModule00.DmUsuarioFields.NoModificarDocumentos.Value;
end;

procedure TMntTckTouchForm.InsertaLineaClick(Sender: TObject);
begin
     ConsultaArticulos;
end;

procedure TMntTckTouchForm.TableViewManagerRowShift(ShiftOperation: TShiftOperation);

var  HaciaArriba,
     HastaElFinal : Boolean;

begin
     HaciaArriba := ( ShiftOperation=soFirst ) or ( ShiftOperation= soPrior );
     HastaElFinal := ( ShiftOperation= soFirst ) or ( ShiftOperation=soLast );
     With LineaMovimientoFields do
       Movimiento.DesplazaLineaMovimiento( Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value, HaciaArriba, HastaElFinal );
end;

procedure SetupUnit;
begin
     ApplicationContainer.OnBegin := MntTickets;
end;

initialization
   AddProcedure( imStartUp, 0, SetupUnit );

end.

