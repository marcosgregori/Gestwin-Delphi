unit b_rmv;

interface

uses Windows, StdCtrls, Buttons, Mask, Controls,
     ExtCtrls, Classes, Forms, Graphics,Menus,
     cxLookAndFeelPainters, cxButtons, cxCheckBox, cxDBEdit,
    cxControls, cxContainer, cxEdit, cxTextEdit, cxStyles, cxCustomData,
    cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView,
    cxGridDBTableView, cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog,

    nxdb, DataManager, cxMaskEdit, cxDropDownEdit, cxCalendar,
    cxCurrencyEdit, dxmdaset, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
    cxGroupBox, cxLookAndFeels, cxLabel, cxScrollBox, cxNavigator, dxDateRanges, dxBar,

    AppContainer,
    AppForms,
    GridTableViewController,

    Gim10Fields,
    Gim30Fields,

    dmi_mov,
    dm_fdv, dxScrollbarAnnotations, dxUIAClasses;

type
  TBoxRmvForm = class(TgxForm)
    ButtonPanel: TgxEditPanel;
    FormManager: TgxFormManager;
    KeyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    bottomPanel: TcxGroupBox;
    FooterPanelCoste: TcxLabel;
    TopPanel: TcxGroupBox;
    FechaCtrl: TcxDBDateEdit;
    Grid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoTable: TnxeTable;
    MovimientoDataSource: TDataSource;
    LineaMovimientoQuery: TnxeQuery;
    LineaMovimientoDataSource: TDataSource;
    GridViewCodigoArticulo: TcxGridDBColumn;
    GridViewCodigoClaseA: TcxGridDBColumn;
    GridViewCodigoClaseB: TcxGridDBColumn;
    GridViewCodigoClaseC: TcxGridDBColumn;
    GridViewDescripcion: TcxGridDBColumn;
    GridViewCantidad: TcxGridDBColumn;
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
    GridViewServido: TcxGridDBColumn;
    Data: TgxMemData;
    MemDataSource: TDataSource;
    DataServido: TBooleanField;
    LineaMovimientoQueryEjercicio: TSmallintField;
    LineaMovimientoQueryNroOperacion: TIntegerField;
    LineaMovimientoQueryNroLinea: TSmallintField;
    LineaMovimientoQueryFecha: TDateField;
    LineaMovimientoQueryTipoMovimientoOrigen: TSmallintField;
    LineaMovimientoQueryEjercicioOrigen: TSmallintField;
    LineaMovimientoQueryNroOperacionOrigen: TIntegerField;
    LineaMovimientoQueryNroRegistroOrigen: TIntegerField;
    LineaMovimientoQueryUIDArticulo: TGuidField;
    LineaMovimientoQueryCodigoArticulo: TWideStringField;
    LineaMovimientoQueryCodigoClaseA: TWideStringField;
    LineaMovimientoQueryCodigoClaseB: TWideStringField;
    LineaMovimientoQueryCodigoClaseC: TWideStringField;
    LineaMovimientoQueryLoteFabricacion: TWideStringField;
    LineaMovimientoQueryNumeroSerie: TWideStringField;
    LineaMovimientoQueryDescripcion: TWideStringField;
    LineaMovimientoQueryCodigoAlmacen: TWideStringField;
    LineaMovimientoQueryUbicacion: TWideStringField;
    LineaMovimientoQueryCantidad: TBCDField;
    LineaMovimientoQueryCantidadProcesada: TBCDField;
    LineaMovimientoQueryRecargo: TBCDField;
    LineaMovimientoQueryPuntoVerde: TBCDField;
    LineaMovimientoQueryDescuento: TBCDField;
    LineaMovimientoQueryNroCajas: TBCDField;
    LineaMovimientoQueryLargo: TBCDField;
    LineaMovimientoQueryAncho: TBCDField;
    LineaMovimientoQueryAlto: TBCDField;
    LineaMovimientoQueryNoCalcularMargen: TBooleanField;
    LineaMovimientoQueryAnotacion: TWideMemoField;
    LineaMovimientoQueryImporteNeto: TBCDField;
    LineaMovimientoQueryImporteBruto: TBCDField;
    LineaMovimientoQueryImporteDescuento: TBCDField;
    Panel1: TcxGroupBox;
    Panel2: TcxGroupBox;
    SerieCtrl: TcxDBTextEdit;
    NroDocumentoCtrl: TcxDBTextEdit;
    Label7: TcxLabel;
    Label8: TcxLabel;
    FooterPanelMargen: TcxLabel;
    LineaMovimientoQueryRegistroOrigen: TBooleanField;
    LineaMovimientoQueryTextoMovimientoOrigen: TWideStringField;
    GridViewUbicacion: TcxGridDBColumn;
    ClienteCtrl: TcxDBTextEdit;
    LockRangeButton: TgxLockRangeButton;
    GridViewRecargo: TcxGridDBColumn;
    Bottom2ScrollBox: TcxScrollBox;
    EntregaACuentaPanel: TgxScrollBoxPanel;
    EntregaACuentaCtrl: TcxDBCurrencyEdit;
    PortesPanel: TgxScrollBoxPanel;
    PortesCtrl: TcxDBCurrencyEdit;
    LineaMovimientoAuxTable: TnxeTable;
    LineaMovimientoQueryCantidadAjustada: TBCDField;
    Bottom1ScrollBox: TcxScrollBox;
    ServidoPanel: TgxScrollBoxPanel;
    ServidoCtrl: TcxDBCheckBox;
    NoFacturarPanel: TgxScrollBoxPanel;
    NoFacturarCtrl: TcxDBCheckBox;
    RevisadoPanel: TgxScrollBoxPanel;
    RevisadoCtrl: TcxDBCheckBox;
    LineaMovimientoQueryCoste: TBCDField;
    LineaMovimientoQueryMargen: TBCDField;
    LineaMovimientoQueryMargenPorcentual: TBCDField;
    GridViewNoCalcularMargen: TcxGridDBColumn;
    GridViewCoste: TcxGridDBColumn;
    GridViewMargen: TcxGridDBColumn;
    GridViewMargenPorcentual: TcxGridDBColumn;
    FooterPanelImporteNeto: TcxLabel;
    FooterPanelMargenPorcentual: TcxLabel;
    LineaMovimientoQueryImporteNetoCalculo: TBCDField;
    GridViewImporteNetoCalculo: TcxGridDBColumn;
    LineaMovimientoQueryCosteCalculo: TBCDField;
    GridViewCosteCalculo: TcxGridDBColumn;
    LineaMovimientoQueryEsCosteReal: TBooleanField;
    GridViewEsCosteReal: TcxGridDBColumn;
    TituloDocumentoLabel: TcxLabel;
    NroDocumentoCaptionLabel: TcxLabel;
    EstadoLabel: TcxLabel;
    SeparadorSerieLabel: TcxLabel;
    Label18: TcxLabel;
    Label6: TcxLabel;
    Label3: TcxLabel;
    Label10: TcxLabel;
    Label9: TcxLabel;
    LineaMovimientoQueryNroPagina: TSmallintField;
    LineaMovimientoQueryAsignacionOrigen: TSmallintField;
    GridViewNroPagina: TcxGridDBColumn;
    LineaMovimientoQueryCabeceraPagina: TWideStringField;
    GridViewCabeceraPagina: TcxGridDBColumn;
    LineaMovimientoQueryCodigoGrupo: TWideStringField;
    LineaMovimientoQueryDescripcionGrupo: TWideStringField;
    ExpandirButton: TcxButton;
    ColapsarButton: TcxButton;
    GrupoLineaMovimientoTable: TnxeTable;
    GrupoLineaMovimientoTableEjercicio: TSmallintField;
    GrupoLineaMovimientoTableNroOperacion: TIntegerField;
    GrupoLineaMovimientoTableNroPagina: TSmallintField;
    GrupoLineaMovimientoTableCodigoGrupo: TWideStringField;
    GrupoLineaMovimientoTableDescripcion: TWideStringField;
    GrupoLineaMovimientoTableAnotacion: TWideMemoField;
    LineaMovimientoQueryBultos: TBCDField;
    GridTableViewPanelLabel1: TcxLabel;
    LineaMovimientoQueryPrecio: TFloatField;
    LineaMovimientoQueryPrecioDivisa: TBCDField;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    Fichadelartculo1: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    TotalesPanel: TcxGroupBox;
    LineaMovimientoQueryNroRegistro: TUnsignedAutoIncField;
    procedure FormManagerInitializeForm;
    procedure FormManagerNoteRequest;
    procedure FormManagerReportRequest;
    procedure LockRangeButtonLockRange(var KeyValues: TFieldValuesArray);
    procedure GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);
    procedure MovimientoTableSetKey(DataSet: TDataSet);
    procedure ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit;var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
    procedure LineaMovimientoQueryCalcFields(DataSet: TDataSet);
    procedure GridViewDescripcionPropertiesAnnotationRequest(Sender: TcxCustomEdit);
    procedure MovimientoTableRecordChanged(DataSet: TDataSet);
    procedure MovimientoTableUpdateState(DataSet: TDataSet);
    procedure PopupMenuPopup(Sender: TObject);
    procedure FormManagerShowForm;
    procedure GridViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TrazaItemClick(Sender: TObject);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure EditarDocItemClick(Sender: TObject);
    procedure SerieCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SerieCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
    procedure SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure LineaMovimientoQueryAfterOpen(DataSet: TDataSet);
    procedure LineaMovimientoQueryAfterClose(DataSet: TDataSet);
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure GridViewNoCalcularMargenGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure GridViewNroPaginaGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure ColapsarButtonClick(Sender: TObject);
    procedure ExpandirButtonClick(Sender: TObject);
    procedure MovimientoTableGetRecord(DataSet: TDataSet);
    procedure NroDocumentoCtrlPropertiesQueryRequest(
      Sender: TcxCustomEdit);
    procedure Fichadelartculo1Click(Sender: TObject);
    procedure LineaMovimientoQueryBeforeOpen(DataSet: TDataSet);
    procedure LineaMovimientoQueryBeforeClose(DataSet: TDataSet);
  private

    FLineaMovimientoFields : TLineaMovimientoFields;

    TipoMovimientoConsulta : TTipoMovimiento;
    ExisteModuloPreventa : Boolean;

    FCaptionNroPagina : String;
    FCabeceraRecordOffset : SmallInt;

    function GetLineaMovimientoFields : TLineaMovimientoFields;

  public

    MovimientoFields : TMovimientoFields;
    ConsumosClienteFields : TConsumosClienteFields;
    ArticuloFields : TArticuloFields;
    ClienteFields : TClienteFields;

    property LineaMovimientoFields : TLineaMovimientoFields read GetLineaMovimientoFields;
    end;
    
var  BoxRmvForm : array[ tmPresupuesto..tmVenta ] of TBoxRmvForm = ( nil, nil, nil );

function ConsultaRentabilidadMovimientosVenta( Values : array of const ) : TBoxRmvForm;
// procedure ActualizaMovimientosVenta( TipoMovimiento : TTipoMovimientoVenta );

implementation

{$R *.DFM}

uses   Variants,
       SysUtils,
       DateUtils,
       LibUtils,

       EnterpriseDataAccess,

       Gdm00Dm,
       Gdm30Dm,
       Gim00Fields,

       dm_mov,
       dm_sto,
       dm_cls,
       dm_art,
       dm_cli,
       dm_tca,
       dm_sdf,

       b_msg,
       bx_not,
       b_mve,
       b_trz,
       b_fda,
       b_chc,

       a_sdf,
       a_mov,
       a_art,

       cx_mve,
       cx_sdf,

       l_rmv;

resourceString

   RsMsg1  = 'Rentabilidad de las ventas por %s';
   RsMsg4  = 'No procede de ningún otro documento';
   RsMsg5  = 'El registro origen de esta línea ya no existe.';
   RsMsg6  = 'Se suprime la referencia al documento origen en la línea actual.';
   RsMsg7  = '&Albaranes de venta que incluyen este %s';
   RsMsg9  = ' pendientes de un Cliente';
   RsMsg10 = 'Este albaran consta como facturado pero no existe la factura a la que pertenece.';
   RsMsg11 = 'Cuando guarde el registro se quitará la marca de facturación.';
   //
   RsMsg13 = 'Haga click sobre el botón del documento para acceder directamente al mantenimiento del cual se importó esta línea.';
   RsMsg14 = 'Utilice el botón derecho del ratón para acceder al menú de opciones de la línea.';
   RsMsg15 = 'Marque esta casilla si desea excluir la línea del cálculo del margen.';

function ConsultaRentabilidadMovimientosVenta( Values : array of const ) : TBoxRmvForm;

var  TipoMovimiento : TTipoMovimiento;

begin
     TipoMovimiento := Values[ 0 ].VInteger;  // Siempre hay que pasar el tipo (como mínimo)
     If   High( Values )=4
     then If   Assigned( BoxRmvForm[ TipoMovimiento ] )
          then BoxRmvForm[ TipoMovimiento ].MovimientoTable.Cancel;
     CreateEditForm( TBoxRmvForm, BoxRmvForm[ TipoMovimiento ], Values );
     Result := BoxRmvForm[ TipoMovimiento ];
end;

{
procedure ActualizaMovimientosVenta( TipoMovimiento : TTipoMovimientoVenta );
begin
     If   Assigned( BoxRmvForm[ TipoMovimiento ] )
     then BoxRmvForm[ TipoMovimiento ].MovimientoTable.Cancel;
end;
}

procedure TBoxRmvForm.FormManagerInitializeForm;

var  TextoNroDocumento : String;

begin

     //  Ajuste del tipo de documento

     TipoMovimientoConsulta := FormValues[ 0 ];

     If   Assigned( ApplicationContainer.AppSkinPainter )
     then TituloDocumentoLabel.Style.TextColor := ApplicationContainer.AppSkinPainter.DefaultEditorTextColor( True );

     Caption := Format( RsMsg1, [ Movimiento.TextoTipoMovimiento( TipoMovimientoConsulta, False ) ] );
     TituloDocumentoLabel.Caption := Movimiento.TextoTituloMovimiento( TipoMovimientoConsulta );

     case TipoMovimientoConsulta of
       tmPresupuesto  : TextoNroDocumento := 'Nº de presupuesto';
       tmPedidoVenta  : TextoNroDocumento := 'Nº de pedido';
       tmVenta        : TextoNroDocumento := 'Nº de albarán';
       end;

     NroDocumentoCaptionLabel.Caption := TextoNroDocumento;

     With DataModule00.DmEmpresaFields do
       begin

       If   not Movimiento.SeriesEnDocumentosVenta( TipoMovimientoConsulta )
       then begin
            SerieCtrl.Visible := False;
            SeparadorSerieLabel.Visible := False;
            LockRangeButton.Visible := False;
            end;

       SetupPanelableCtrl( RevisadoCtrl, TipoMovimientoConsulta=tmPresupuesto );
       SetupPanelableCtrl( ServidoCtrl, TipoMovimientoConsulta=tmPedidoVenta );
       SetupPanelableCtrl( NoFacturarCtrl, TipoMovimientoConsulta=tmVenta );
       SetupPanelableCtrl( EntregaACuentaCtrl, TipoMovimientoConsulta=tmVenta );
       SetupPanelableCtrl( PortesCtrl, TipoMovimientoConsulta=tmVenta );

       SetEditControlsDecimals( [ EntregaACuentaCtrl, PortesCtrl ] );
       end;

     GridViewServido.Visible := TipoMovimientoConsulta=tmPedidoVenta;
    
     // -------

     MovimientoFields := TMovimientoFields.Create( MovimientoTable );
     ArticuloFields := TArticuloFields.Create( Articulo.DmArticuloTable, True );
     ClienteFields := TClienteFields.Create( Cliente.DmClienteTable, True );

     Clase.SetupGridColumns( GridViewCodigoClaseA, GridViewCodigoClaseB, GridViewCodigoClaseC, 4 );

     With DataModule00.DmEmpresaFields do
       begin

       GridViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       GridViewUbicacion.Visible := Stock_Ubicaciones.Value;
       GridViewNroCajas.Visible := Articulo_Cajas.Value;
       GridViewLargo.Visible := Ventas_Cantidades.Value>0;
       GridViewAncho.Visible := Ventas_Cantidades.Value>0;
       GridViewAlto.Visible := Ventas_Cantidades.Value>1;
       GridViewRecargo.Visible := Ventas_Recargos.Value;

       SetColumnsDecimals( [ GridViewCantidad, GridViewServido ], Ventas_DecCantidad.Value );
       SetColumnsDecimals( [ GridViewPrecio, GridViewRecargo ], Ventas_DecPrecio.Value );
       SetColumnDecimals( GridViewDescuento, Ventas_DecDto.Value );
       SetColumnsDecimals( [ GridViewImporte, GridViewCoste, GridViewMargen ] );
       SetColumnsDecimals( [ GridViewLargo, GridViewAncho, GridViewAlto ], Ventas_DecCantidad.Value );
       SetColumnDecimals( GridViewNroCajas, Ventas_DecCajas.Value );
       SetColumnDecimals( GridViewMargenPorcentual, 2 );

       If   not ValueIsEmpty( Ventas_NombreCajas.Value )
       then If   Ventas_Cantidades.Value=2
            then GridViewAlto.Caption := Ventas_NombreCajas.Value
            else GridViewNroCajas.Caption := Ventas_NombreCajas.Value;

       If   DataModule00.PartidasPresupuestarias
       then begin
            GridViewNroPagina.GroupIndex := 0;
            If   Ventas_NombrePaginas.Value<>''
            then FCaptionNroPagina := Capitaliza( Ventas_NombrePaginas.Value, True, False );
            Inc( FCabeceraRecordOffset );
            end
       else begin
            ExpandirButton.Visible := False;
            ColapsarButton.Visible := False;
            end;

       With GridView.DataController.Summary do
         begin
         DefaultGroupSummaryItems[ 0 ].Format := FloatDisplayFormat( DecimalesMoneda );
         DefaultGroupSummaryItems[ 1 ].Format := FloatDisplayFormat( DecimalesMoneda );
         DefaultGroupSummaryItems[ 2 ].Format := FloatDisplayFormat( DecimalesMoneda );
         DefaultGroupSummaryItems[ 3 ].Format := FloatDisplayFormat( 2 );
         end;

       end;

     Grid.ShowHint := True;

     With  LineaMovimientoQuery do
       If   TipoMovimientoConsulta=tmVenta
       then SQL.Text := StringReplace( SQL.Text, 'Cantidad ', '-Cantidad ', [ rfIgnoreCase ] );

     MovimientoTable.SetDefaultRangeValues( [ TipoMovimientoConsulta, ApplicationContainer.Ejercicio ], [ TipoMovimientoConsulta, ApplicationContainer.Ejercicio ] );
     SetFieldRange( MovimientoFields.NroDocumento );

     ExisteModuloPreventa := ApplicationContainer.IsModuleActive( [ 60 ] );

end;

function TBoxRmvForm.GetLineaMovimientoFields : TLineaMovimientoFields;
begin
     If   not Assigned( FLineaMovimientoFields )
     then FLineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoQuery );
     Result := FLineaMovimientoFields;
end;

procedure TBoxRmvForm.GridViewCustomDrawCell(     Sender    : TcxCustomGridTableView;
                                                  ACanvas   : TcxCanvas;
                                                  AViewInfo : TcxGridTableDataCellViewInfo;
                                              var ADone     : Boolean);
begin
     If   not AViewInfo.Selected
     then With AViewInfo.GridRecord do
            If   VarToBoolean( Values[ GridViewNoCalcularMargen.Index ] )
            then ACanvas.Brush.Color := clRowHighlight;
end;

procedure TBoxRmvForm.GridViewDataControllerSummaryAfterSummary(ASender: TcxDataSummary);

var   Index : SmallInt;

      ImporteNeto,
      Coste,
      Margen,
      MargenPorcentual : Decimal;

begin

     With ASender, DataModule00.DmEmpresaFields  do
       begin

       For Index := 0 to DataController.DataControllerInfo.DataGroups.Count - 1 do
         begin

         ImporteNeto := GroupSummaryValues[ Index, 0 ];
         Coste := GroupSummaryValues[ Index, 1 ];
         Margen := ImporteNeto - Coste;
         If   ImporteNeto<>0.0
         then MargenPorcentual := ( Margen * 100.0 ) / ImporteNeto
         else MargenPorcentual := 0.0;

         GroupSummaryValues[ Index, 2 ] := Margen;
         GroupSummaryValues[ Index, 3 ] := MargenPorcentual;

         end;

       ImporteNeto := VarToDecimal( FooterSummaryValues[ 0 ] );
       Coste := VarToDecimal( FooterSummaryValues[ 1 ] );
       Margen := ImporteNeto - Coste;

       FooterPanelCoste.Caption := StrFormat( Coste, DecimalesMoneda );
       FooterPanelImporteNeto.Caption := StrFormat( ImporteNeto, DecimalesMoneda );

       If   ImporteNeto<>0.0
       then MargenPorcentual := ( Margen * 100.0 ) / ImporteNeto
       else MargenPorcentual := 0.0;

       FooterPanelMargen.Caption := StrFormat( Margen, DecimalesMoneda );
       FooterPanelMargenPorcentual.Caption := StrFormat( MargenPorcentual, 2 );

       end;

end;

procedure TBoxRmvForm.GridViewDescripcionPropertiesAnnotationRequest(Sender: TcxCustomEdit);
begin
     MntAnotacion( LineaMovimientoFields.Anotacion, RsAnotacionLinea );
end;

procedure TBoxRmvForm.GridViewNoCalcularMargenGetCellHint(       Sender           : TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
                                                                 ACellViewInfo    : TcxGridTableDataCellViewInfo;
                                                           const AMousePos        : TPoint;
                                                           var   AHintText        : TCaption;
                                                           var   AIsHintMultiLine : Boolean;
                                                           var   AHintTextRect    : TRect );
begin
     AHintText := RsMsg15;
     AIsHintMultiLine := True;
     With AHintTextRect do
       begin
       Left := Left - 150;
       Top := ACellViewInfo.Bounds.Bottom + 4;
       Right := Left + 300;
       end;
end;

procedure TBoxRmvForm.GridViewNroPaginaGetDisplayText(     Sender          : TcxCustomGridTableItem;
                                                           ARecord         : TcxCustomGridRecord;
                                                       var AText           : string );
begin
     AText := GridView.DataController.Values[ ARecord.RecordIndex, GridViewCabeceraPagina.Index ];
end;

procedure TBoxRmvForm.ColapsarButtonClick(Sender: TObject);
begin
     GridView.DataController.Groups.FullCollapse;
end;

procedure TBoxRmvForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( LineaMovimientoFields.NroRegistroOrigen.Value );
end;

procedure TBoxRmvForm.ExpandirButtonClick(Sender: TObject);
begin
     GridView.DataController.Groups.FullExpand;
end;

procedure TBoxRmvForm.FormManagerNoteRequest;
begin
     MntAnotacion( MovimientoFields.Anotacion, RsAnotacionDocumento );
end;

procedure TBoxRmvForm.FormManagerReportRequest;
begin
     With MovimientoFields do
       ListadoRentabilidadVenta( TipoMovimientoConsulta, Serie.Value, NroDocumento.Value );
end;

procedure TBoxRmvForm.FormManagerShowForm;
begin
     If   Length( FormValues )=1
     then CleanFormValues;
end;

procedure TBoxRmvForm.LineaMovimientoQueryAfterOpen(DataSet: TDataSet);
begin
     SetFieldsRange( [ LineaMovimientoFields.NroLinea ] );
end;

procedure TBoxRmvForm.LineaMovimientoQueryBeforeClose(DataSet: TDataSet);
begin
     //..
end;

procedure TBoxRmvForm.LineaMovimientoQueryBeforeOpen(DataSet: TDataSet);



begin
     { Si se asigna el valor de los parámetros en el componente LineaMovimientoQuery.Params el enlace no funciona, y
       si no se asignan, los valores nulos (cuando no hay ningún documento), provocan un error al intentar comparar con NULL.
       La solución evitar que se produzca el error (con un Abort), que es silencioso (o, en un futuro, modificar el sistema de asignación para que utilice IS NULL en lugar de =NULL)
       }
     
     If   MovimientoFields.NroOperacion.Value=0
     then Abort;
     
end;

procedure TBoxRmvForm.LineaMovimientoQueryAfterClose(DataSet: TDataSet);
begin
     FreeAndNil( FLineaMovimientoFields );
end;

procedure TBoxRmvForm.LineaMovimientoQueryCalcFields(DataSet: TDataSet);

var   CantidadLinea,
      CosteUnitario,
      CosteLinea,
      MargenPorcentual,
      MargenLinea : Decimal;
      AText : String;

begin

     If   Assigned( LineaMovimientoFields )
     then try

            LineaMovimientoQueryRegistroOrigen.Value := not ValueIsEmpty( FLineaMovimientoFields.NroRegistroOrigen.Value );
            LineaMovimientoQueryTextoMovimientoOrigen.Value := Movimiento.TextoTipoMovimiento( LineaMovimientoFields.TipoMovimientoOrigen.Value, False );

            LineaMovimientoQueryEsCosteReal.Value := Movimiento.CosteMovimiento( FLineaMovimientoFields, CosteUnitario );

            With LineaMovimientoFields do
              begin

              If   GrupoLineaMovimientoTable.FindKey( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] )
              then begin
                   LineaMovimientoQueryCodigoGrupo.Value := GrupoLineaMovimientoTableCodigoGrupo.Value;
                   LineaMovimientoQueryDescripcionGrupo.Value := GrupoLineaMovimientoTableDescripcion.Value;
                   end;

              If   TipoMovimientoConsulta=tmVenta
              then CantidadLinea := -Cantidad.Value
              else CantidadLinea := Cantidad.Value;

              CosteLinea := CosteUnitario * CantidadLinea;
              MargenLinea := ImporteNeto.Value - CosteLinea;

              If   ImporteNeto.Value<>0.0
              then MargenPorcentual := ( MargenLinea * 100.0 ) / ImporteNeto.Value
              else MargenPorcentual := 0.0;

              LineaMovimientoQueryCoste.Value := CosteLinea;
              LineaMovimientoQueryMargenPorcentual.Value := MargenPorcentual;
              LineaMovimientoQueryMargen.Value := MargenLinea;

              If   LineaMovimientoQueryNoCalcularMargen.Value
              then begin
                   LineaMovimientoQueryImporteNetoCalculo.Value := 0.0;
                   LineaMovimientoQueryCosteCalculo.Value := 0.0;
                   end
              else begin
                   LineaMovimientoQueryImporteNetoCalculo.Value := ImporteNeto.Value;
                   LineaMovimientoQueryCosteCalculo.Value := CosteLinea;
                   end;

              AText := FCaptionNroPagina + ' : ';
              If   LineaMovimientoQueryCodigoGrupo.Value<>''
              then StrAdd( AText, LineaMovimientoQueryCodigoGrupo.Value + ', ' );
              StrAdd( AText, LineaMovimientoQueryDescripcionGrupo.Value );
              LineaMovimientoQueryCabeceraPagina.Value := AText;
              end;

          finally
            end;
end;

procedure TBoxRmvForm.LockRangeButtonLockRange( var KeyValues: TFieldValuesArray);
begin
     With MovimientoTable do
       begin
       // KeyValues : TipoMovimiento;Ejercicio;Serie;NroDocumento
       KeyValues[ 0 ] := TipoMovimientoConsulta;
       KeyValues[ 1 ] := ApplicationContainer.Ejercicio;
       If   not LockRangeButton.Down
       then KeyValues[ 2 ] := UnAssigned; // Serie
       KeyValues[ 3 ] := UnAssigned;
       end;
end;

procedure TBoxRmvForm.FichaArticuloItemClick(Sender: TObject);
begin
     FichaArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TBoxRmvForm.Fichadelartculo1Click(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TBoxRmvForm.MovimientoTableGetRecord(DataSet: TDataSet);
begin
     GridView.DataController.Groups.FullExpand;
end;

procedure TBoxRmvForm.MovimientoTableRecordChanged(DataSet: TDataSet);
begin
     Movimiento.EstadoDocumento( MovimientoFields, EstadoLabel );

     Data.Edit;
     DataServido.Value := MovimientoFields.Situacion.Value=epProcesado;
end;

procedure TBoxRmvForm.MovimientoTableSetKey(DataSet: TDataSet);
begin
     MovimientoFields.TipoMovimiento.Value := TipoMovimientoConsulta;
     MovimientoFields.Ejercicio.Value := ApplicationContainer.Ejercicio;

     If   not Movimiento.SeriesEnDocumentosVenta( TipoMovimientoConsulta ) // TipoMovimientoConsulta in [ tmPresupuesto, tmPedidoVenta ]
     then MovimientoFields.Serie.Value := ''
       else If   LockRangeButton.SettingDefaultRange
            then begin
                 SerieFacturacion.FijaSeriePorDefecto( MovimientoFields.Serie );
                 If   DataModule00.DmUsuarioFields.Ventas_RestringirSerie.Value
                 then LockRangeButton.Enabled := False;
                 end;

     With Data do
       begin
       Edit;
       ClearFields;
       end;
end;

procedure TBoxRmvForm.MovimientoTableUpdateState(DataSet: TDataSet);
begin
     LineaMovimientoDataSource.Enabled := MovimientoTable.State<>dsSetKey;
end;

procedure TBoxRmvForm.NroDocumentoCtrlPropertiesQueryRequest( Sender: TcxCustomEdit);
begin
     With MovimientoFields do
       ConsultaMovimientosVenta( TipoMovimientoConsulta, sdTodos, Serie, Sender, qgsLinked, '' );
end;

procedure TBoxRmvForm.PopupMenuPopup(Sender: TObject);
begin
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
       FichaArticuloItem.Enabled := CodigoArticulo.Value<>ArticuloManual;
       end;
end;

procedure TBoxRmvForm.SerieCtrlPropertiesEditRequest( Sender: TcxCustomEdit);
begin
     MntSeriesFacturacion( [ Sender.EditingValue ] );
end;

procedure TBoxRmvForm.SerieCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaSeriesFacturacion( Sender );
end;

procedure TBoxRmvForm.SerieCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     SerieFacturacion.Valida( Sender, DisplayValue, ErrorText, Error );
end;

procedure TBoxRmvForm.ClienteCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Cliente.Valida( Sender, DisplayValue, ErrorText, Error );
     ClienteFields.Update;
end;

procedure TBoxRmvForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     With LineaMovimientoQuery do
       begin
       Edit;
       With LineaMovimientoFields do
         NoCalcularMargen.Value := not NoCalcularMargen.Value;
       Post;
       end;
end;

procedure TBoxRmvForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( MovimientoFields.TipoMovimiento.Value,
                               MovimientoFields.NroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

end.

