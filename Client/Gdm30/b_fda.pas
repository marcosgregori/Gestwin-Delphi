
unit b_fda;

interface

uses Forms, StdCtrls, Buttons, Mask, Controls, Classes,
  ExtCtrls, Menus,

  cxLookAndFeelPainters,cxButtons, DB, dxmdaset, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxGroupBox, cxRadioGroup, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxMaskEdit, cxDropDownEdit, cxCalendar, nxdb,
  cxCurrencyEdit, cxCheckBox, Gim30Fields, cxSpinEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxLookAndFeels, cxLabel, cxNavigator, dxBar, dxDateRanges,

  AppContainer,
  DataManager,
  AppForms,
  SqlSet,
  GridTableViewController,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TMovimientoQueryFields = class( TMovimientoFields )
    NroOperacion : TIntegerField;
    TipoMovimiento : TSmallIntField;
    DescripcionMovimiento : TWideStringField;
    end;

  TBrwFdaForm = class(TgxForm)
    FormManager: TgxFormManager;
    keyPanel: TgxEditPanel;
    DataPanel: TgxEditPanel;
    FechaInicialCtrl: TcxDBDateEdit;
    FechaFinalCtrl: TcxDBDateEdit;
    Timer: TTimer;
    gGridFooter1: TGridTableViewPanel;
    Data: TgxMemData;
    DataCodigoArticulo: TWideStringField;
    DataSeleccionAlmacen: TSmallintField;
    DataCodigoAlmacen: TWideStringField;
    DataSource: TDataSource;
    DataFechaInicial: TDateField;
    DataFechaFinal: TDateField;
    SeleccionAlmacenCtrl: TcxDBRadioGroup;
    CodigoArticuloCtrl: TcxDBTextEdit;
    CodigoAlmacenCtrl: TcxDBTextEdit;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    MovimientoQuery: TnxeQuery;
    MovimientoDataSource: TDataSource;
    DataAgrupar: TBooleanField;
    AgruparCtrl: TcxDBCheckBox;
    SQLSet: TgxSQLSet;
    TableViewManager: TGridTableViewController;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewLoteFabricacion: TcxGridDBColumn;
    TableViewNumeroSerie: TcxGridDBColumn;
    TableViewCodigoAlmacen: TcxGridDBColumn;
    TableViewUbicacion: TcxGridDBColumn;
    TableViewPrecio: TcxGridDBColumn;
    TableViewDescuento: TcxGridDBColumn;
    TableViewAnotacion: TcxGridDBColumn;
    TableViewTipoMovimiento: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroDocumento: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    FiltroButton: TgBitBtn;
    TableViewDescripcionTipoMovimiento: TcxGridDBColumn;
    TableViewEntradas: TcxGridDBColumn;
    TableViewSalidas: TcxGridDBColumn;
    DataFiltroActivo: TBooleanField;
    FiltroActivoCtrl: TcxDBCheckBox;
    DataTodosLosMovimientos: TBooleanField;
    FiltroPanel: TcxGroupBox;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    Label3: TcxLabel;
    Label1: TcxLabel;
    codigoCtrlCaption: TcxLabel;
    DescArticuloLabel: TcxLabel;
    Label6: TcxLabel;
    Label4: TcxLabel;
    AgruparLabel: TcxLabel;
    Label2: TcxLabel;
    Label7: TcxLabel;
    Label8: TcxLabel;
    Label9: TcxLabel;
    Label10: TcxLabel;
    Label11: TcxLabel;
    Label12: TcxLabel;
    TipoMovimientoLabel: TcxLabel;
    PropietarioLabel: TcxLabel;
    ClasesLabel: TcxLabel;
    LoteLabel: TcxLabel;
    MovimientoQueryEjercicio: TSmallintField;
    MovimientoQueryNroOperacion: TIntegerField;
    MovimientoQueryFecha: TDateField;
    MovimientoQueryTipoMovimiento: TSmallintField;
    MovimientoQuerySerie: TWideStringField;
    MovimientoQueryNroDocumento: TIntegerField;
    MovimientoQueryPropietario: TWideStringField;
    MovimientoQueryDescripcionTipoMovimiento: TWideStringField;
    MovimientoQueryEntradas: TBCDField;
    MovimientoQuerySalidas: TBCDField;
    MovimientoQueryNombre: TWideStringField;
    MovimientoQueryNroRegistro: TLongWordField;
    MovimientoQueryNroPagina: TSmallintField;
    MovimientoQueryNroLinea: TSmallintField;
    MovimientoQueryCodigoArticulo: TWideStringField;
    MovimientoQueryCodigoClaseA: TWideStringField;
    MovimientoQueryCodigoClaseB: TWideStringField;
    MovimientoQueryCodigoClaseC: TWideStringField;
    MovimientoQueryNumeroSerie: TWideStringField;
    MovimientoQueryLoteFabricacion: TWideStringField;
    MovimientoQueryCodigoAlmacen: TWideStringField;
    MovimientoQueryUbicacion: TWideStringField;
    MovimientoQueryPrecio: TFloatField;
    MovimientoQueryDescuento: TBCDField;
    MovimientoQueryUIDArticulo: TGuidField;
    ButtonsPanel: TgxEditPanel;
    Panel3: TcxGroupBox;
    OkButton: TgBitBtn;
    CloseButton: TgBitBtn;
    ExistenciasBox: TcxLabel;
    SumasSalidasBox: TcxLabel;
    SumasEntradasBox: TcxLabel;
    MovimientoQueryDescripcionMovimiento: TWideStringField;
    dxBarManager1: TdxBarManager;
    PopupMenu: TdxBarPopupMenu;
    EditarDocItem: TdxBarButton;
    FichaArticuloItem: TdxBarButton;
    TrazaItem: TdxBarButton;
    MovimientoQueryFechaCaducidad: TDateField;
    TableViewFechaCaducidad: TcxGridDBColumn;
    NoAfectaStocksLabel: TcxLabel;
    TotalesPanel: TcxGroupBox;
    procedure ResetDataArea;
    procedure TimerTimer(Sender: TObject);
    procedure FormManagerReportRequest;
    function FormManagerGetAccessLevel: Smallint;
    procedure CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure SeleccionAlmacenCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
    procedure CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit;
      var DisplayValue: TcxEditValue; var ErrorText: TCaption;
      var Error: Boolean);
    procedure TableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormManagerInitializeForm;
    procedure AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure FiltroButtonClick(Sender: TObject);
    procedure KeyCtrlPropertiesEditValueChanged(
      Sender: TObject);
    procedure FormManagerShowForm;
    procedure TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
    procedure CodigoArticuloCtrlPropertiesEditRequest(
      Sender: TcxCustomEdit);
    procedure FiltroActivoCtrlPropertiesEditValueChanged(Sender: TObject);
    procedure EditarDocItemClick(Sender: TObject);
    procedure FichaArticuloItemClick(Sender: TObject);
    procedure TrazaItemClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure MovimientoQueryCalcFields(DataSet: TDataSet);
  private

  public

    FTipoMovimiento : SmallInt;
    FCodigoClaseA,
    FCodigoClaseB,
    FCodigoClaseC : String;
    FLoteFabricacion : String;
    FCodigoPropietario : String;

    FDescripcionTipoMovimiento,
    FNombrePropietario : String;
    FDecimalesCantidad : SmallInt;

    MovimientoFields : TMovimientoQueryFields;
    LineaMovimientoFields : TLineaMovimientoFields;
    ArticuloFields : TArticuloFields;

    procedure ResetTimer( EnabledIt : Boolean );
    procedure SeleccionMovimiento;
    procedure ActualizaPanelFiltro;
  end;

var  BrwFdaForm: TBrwFdaForm = nil;

procedure FichaArticulos( KeyValues : array of const );

implementation

{$R *.DFM}

uses   Math,
       SysUtils,
       DateUtils,
       LibUtils,
       EnterpriseDataAccess,
       AppManager,

       Gdm00Dm,
       Gim00Fields,

       dmi_mov,
       dmi_sto,

       dm_pga,
       dm_art,
       dm_alm,
       dm_sto,
       dm_mov,
       dm_tma,
       dm_pro,
       dm_cli,
       dm_cls,

       a_art,
       a_mco,
       a_mve,
       a_mov,

       b_ffa,
       b_trz,
       b_msg,
       
       cx_art,
       cx_alm,

       l_fda;

resourceString
     RsMsg1  = '<Todos los artículos>';
     RsMsg2  = '¿Está seguro de que desea esta relación de movimientos?';
     RsMsg3  = 'Ha solicitado una relación de [B]todos los artículos[/B], el periodo es de más de 6 meses y su fichero de movimientos de almacén contiene muchos registros.'#13'El proceso podría tarder bastante tiempo en realizase.';

procedure FichaArticulos( KeyValues : array of const );
begin
     CreateEditForm( TBrwFdaForm, BrwFdaForm, KeyValues );
end;

procedure TBrwFdaForm.ResetDataArea;

var  LineasManuales : Boolean;
     SQLSeleccionLineas,
     SQLSeleccionCabecera,
     SQLString : String;

procedure AddSeleccionCabecera( Valor : String );
begin
     If   SQLSeleccionCabecera=''
     then StrAdd( SQLSeleccionCabecera, ' ' )
     else StrAdd( SQLSeleccionCabecera, ' AND ' );
     StrAdd( SQLSeleccionCabecera, Valor );
end;

procedure AddSeleccionLineas( Valor : String );
begin
     // La sección de seleccion de lineas ya tiene un filtro definido por defecto
     StrAdd( SQLSeleccionLineas, ' AND ' + Valor );
end;

begin

     With FormManager do
       begin

       If   DataAreaFocused
       then begin

            //** 14.02.2010  Una precaución bastante lógica

            If   ( DataCodigoArticulo.Value='' ) and
                 ( MonthsBetween( DataFechaFinal.Value, DataFechaInicial.Value )>6 ) and
                 ( Movimiento.ObtenNroRegistros>10000 )
            then If   ShowNotification( ntQuestionWarning, RsMsg2, RsMsg3 )<>mrYes
                 then begin
                      SelectFirstKeyControl;
                      Exit;
                      end;

            LineasManuales := DataCodigoArticulo.Value=ArticuloManual;
            TableViewDescripcion.Visible := LineasManuales;
            TableViewNombre.Visible := not LineasManuales;

            SQLString := SQLSet.GetSQLText;

            SQLSeleccionLineas := '';
            SQLSeleccionCabecera := '';

            If   DataCodigoArticulo.Value<>''
            then AddSeleccionLineas( 'CodigoArticulo=' + QuotedStr( DataCodigoArticulo.Value ) );

            If   DataSeleccionAlmacen.Value=1
            then AddSeleccionLineas( 'CodigoAlmacen=' + QuotedStr( DataCodigoAlmacen.Value ) );

            If   DataFiltroActivo.Value
            then begin

                 If   FTipoMovimiento<>0
                 then AddSeleccionCabecera( 'Movimiento.TipoMovimiento=' + IntToStr( FTipoMovimiento ) );

                 If   FCodigoPropietario<>''
                 then AddSeleccionCabecera( 'Movimiento.Propietario=' + QuotedStr( FCodigoPropietario ) );

                 If   FCodigoClaseA<>''
                 then AddSeleccionLineas( 'LineaMovimiento.CodigoClaseA=' + QuotedStr( FCodigoClaseA ) );

                 If   FCodigoClaseB<>''
                 then AddSeleccionLineas( 'LineaMovimiento.CodigoClaseB=' + QuotedStr( FCodigoClaseB ) );

                 If   FCodigoClaseC<>''
                 then AddSeleccionLineas( 'LineaMovimiento.CodigoClaseC=' + QuotedStr( FCodigoClaseC ) );

                 If   FLoteFabricacion<>''
                 then AddSeleccionLineas( 'LineaMovimiento.LoteFabricacion=' + QuotedStr( FLoteFabricacion ) );

                 end
            else AddSeleccionCabecera( 'Movimiento.TipoMovimiento NOT IN ( 10, 11, 13, 14, 16, 17, 18 )' );

            If   SQLSeleccionCabecera<>''
            then SQLSeleccionCabecera := ' WHERE ' + SQLSeleccionCabecera;

            SetSQLVar( SQLString, 'CondicionLinea', SQLSeleccionLineas );
            SetSQLVar( SQLString, 'CondicionCabecera', SQLSeleccionCabecera );
            SetSQLVar( SQLString, 'FechaInicial', DataFechaInicial );
            SetSQLVar( SQLString, 'FechaFinal', DataFechaFinal );

            With MovimientoQuery do
              begin
              Close;
              SQL.Text := SQLString;
              Open;
              end;

            MovimientoFields := TMovimientoQueryFields.Create( MovimientoQuery );
            LineaMovimientoFields := TLineaMovimientoFields.Create( MovimientoQuery );
            end;

       TableViewCodigoArticulo.Visible := DataCodigoArticulo.Value='';
       TableViewCodigoAlmacen.Visible := DataSeleccionAlmacen.Value=0;

       MovimientoDataSource.Enabled := DataAreaFocused;
       ResetTimer( DataAreaFocused );
       end;
       
end;

procedure TBrwFdaForm.CodigoAlmacenCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaAlmacenes( Sender );
end;

procedure TBrwFdaForm.CodigoAlmacenCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue;var ErrorText: TCaption; var Error: Boolean);
begin
     Almacen.Valida( scAmbas, Sender, DisplayValue, ErrorText, Error );
end;

procedure TBrwFdaForm.SeleccionMovimiento;
begin
     case MovimientoQueryTipoMovimiento.Value of
       tmOferta..tmCompra     : MntMovimientosCompra( [ MovimientoQueryTipoMovimiento.Value,
                                                        MovimientoQueryEjercicio.Value,
                                                        MovimientoQueryPropietario.Value,
                                                        MovimientoQuerySerie.Value,
                                                        MovimientoQueryNroDocumento.Value ] );
       tmPresupuesto..tmVenta : MntMovimientosVenta( [ MovimientoQueryTipoMovimiento.Value,
                                                       MovimientoQueryEjercicio.Value,
                                                       MovimientoQuerySerie.Value,
                                                       MovimientoQueryNroDocumento.Value ] );
       else                     MntMovimientosAlmacen( [ MovimientoQueryEjercicio.Value,
                                                         MovimientoQueryNroOperacion.Value ] );
       end;
end;

procedure TBrwFdaForm.TableViewFocusedRecordChanged( Sender                        : TcxCustomGridTableView;
                                                     APrevFocusedRecord,
                                                     AFocusedRecord                : TcxCustomGridRecord;
                                                     ANewItemRecordFocusingChanged : Boolean );
begin
     ResetTimer( True );
end;

procedure TBrwFdaForm.TableViewManagerUserSelection(Sender: TObject; var AHandled : Boolean);
begin
     MntMovimientosPorNroRegistro( MovimientoQueryNroRegistro.Value );
     // SeleccionMovimiento;
end;

procedure TBrwFdaForm.TimerTimer(Sender: TObject);

var  TodosLosLotes : Boolean;
     LoteFabricacion : String;
     ExistenciasArticulo : IExistenciasArticulo;

begin

     Timer.Enabled := False;

     With StockAlmacen do
       If   not ValueIsEmpty( MovimientoQueryCodigoArticulo.Value )
       then begin

            //* 05.06.2008  He quitado el lote para que se muestren las existencias solo por almacén y ubicación
            //* 09.11.2009  Añadidas las existencias por lote cuando el filtro está activado y el campo lote conteniene algún valor
            //* 03.05.2010  Diferenciando claramente cuando se desean obtener las existencias de un solo lote o de todos 
    
            If   DataFiltroActivo.Value and ( FLoteFabricacion<>'' )
            then begin
                 TodosLosLotes := False;
                 LoteFabricacion := MovimientoQueryLoteFabricacion.Value;
                 end
            else begin
                 TodosLosLotes := True;
                 LoteFabricacion := '';
                 end;

            ExistenciasArticulo := StockAlmacen.ObtenStockFecha ( MovimientoQueryCodigoArticulo.Value,
                                                                  False,
                                                                  MovimientoQueryCodigoClaseA.Value,
                                                                  MovimientoQueryCodigoClaseB.Value,
                                                                  MovimientoQueryCodigoClaseC.Value,
                                                                  TodosLosLotes,
                                                                  LoteFabricacion,
                                                                  DataSeleccionAlmacen.Value=0,
                                                                  MovimientoQueryCodigoAlmacen.Value,
                                                                  False,
                                                                  MovimientoQueryUbicacion.Value,
                                                                  MovimientoQueryFecha.Value,
                                                                  MovimientoQueryNroOperacion.Value,
                                                                  MovimientoQueryNroPagina.Value,
                                                                  MovimientoQueryNroLinea.Value );

            With ExistenciasArticulo.SumaExistencias do
              begin
              SumasEntradasBox.Caption := StrFormat( Entradas, DataModule00.DmEmpresaFields.Compras_DecCantidad.Value );
              SumasSalidasBox.Caption := StrFormat( Salidas, DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
              ExistenciasBox.Caption := StrFormat( Saldo, FDecimalesCantidad );
              end;

            end;
end;

procedure TBrwFdaForm.TrazaItemClick(Sender: TObject);
begin
     With LineaMovimientoFields do
       MuestraTrazadoArticulo( MovimientoFields.TipoMovimiento.Value,
                               MovimientoFields.NroOperacion.Value,
                               CodigoArticulo.Value,
                               UIDArticulo.AsGuid );
end;

procedure TBrwFdaForm.ResetTimer( EnabledIt : Boolean );
begin
     SumasEntradasBox.Caption := '';
     SumasSalidasBox.Caption := '';
     ExistenciasBox.Caption := '';

     Timer.Enabled  := False;
     If   EnabledIt
     then Timer.Enabled := True;
end;

procedure TBrwFdaForm.SeleccionAlmacenCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     CodigoAlmacenCtrl.Enabled := DataSeleccionAlmacen.Value=1;
     KeyCtrlPropertiesEditValueChanged(nil);
end;

procedure TBrwFdaForm.KeyCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     DataFiltroActivo.Value := False;
end;

procedure TBrwFdaForm.MovimientoQueryCalcFields(DataSet: TDataSet);
begin
     If   MovimientoQueryTipoMovimiento.Value in [ tmOferta..tmCompra ]
     then MovimientoQueryNombre.Value := Proveedor.Descripcion( MovimientoQueryPropietario.Value, False )
     else If   MovimientoQueryTipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
          then MovimientoQueryNombre.Value := Cliente.Descripcion( MovimientoQueryPropietario.Value, False )
          else MovimientoQueryNombre.Value := MovimientoQueryDescripcionMovimiento.Value;
end;

procedure TBrwFdaForm.CodigoArticuloCtrlPropertiesEditRequest(Sender: TcxCustomEdit);
begin
     MntArticulos( [ Sender.EditingValue ] );
end;

procedure TBrwFdaForm.CodigoArticuloCtrlPropertiesQueryRequest(Sender: TcxCustomEdit);
begin
     ConsultaArticulos( scAmbas, False, Sender );
end;

procedure TBrwFdaForm.CodigoArticuloCtrlPropertiesValidate(Sender: TcxCustomEdit; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
     NoAfectaStocksLabel.Visible := False;
     If   ValueIsEmpty( DisplayValue )
     then CodigoArticuloCtrl.Description := RsMsg1
     else begin
          Articulo.Valida( Sender, DisplayValue, ErrorText, Error, ArticuloFields );
          NoAfectaStocksLabel.Visible := not Error and ( ArticuloFields.NoAfectarStock.Value );
          end;
end;

procedure TBrwFdaForm.EditarDocItemClick(Sender: TObject);
begin
     MntMovimientosPorNroRegistro( MovimientoQueryNroRegistro.Value );
end;

procedure TBrwFdaForm.FichaArticuloItemClick(Sender: TObject);
begin
     MntArticulos( [ LineaMovimientoFields.CodigoArticulo.Value ] );
end;

procedure TBrwFdaForm.FiltroActivoCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     ActualizaPanelFiltro;
     FiltroPanel.Visible := FiltroActivoCtrl.Checked;
end;

procedure TBrwFdaForm.ActualizaPanelFiltro;
begin
     If   FTipoMovimiento=0
     then TipoMovimientoLabel.Caption := ''
     else TipoMovimientoLabel.Caption := StrInt( FTipoMovimiento, True ) +  ' , ';
     If   FDescripcionTipoMovimiento<>''
     then TipoMovimientoLabel.Caption := TipoMovimientoLabel.Caption + FDescripcionTipoMovimiento;

     If   FCodigoPropietario=''
     then PropietarioLabel.Caption := ''
     else PropietarioLabel.Caption := FCodigoPropietario + ' , ';
     If   FNombrePropietario<>''
     then PropietarioLabel.Caption := PropietarioLabel.Caption + FNombrePropietario;

     ClasesLabel.Caption := FCodigoClaseA;
     If   FCodigoClaseB<>''
     then ClasesLabel.Caption := ClasesLabel.Caption + ',' + FCodigoClaseB;
     If   FCodigoClaseC<>''
     then ClasesLabel.Caption := ClasesLabel.Caption + ',' + FCodigoClaseC;

     LoteLabel.Caption := FLoteFabricacion;
end;

procedure TBrwFdaForm.FiltroButtonClick(Sender: TObject);
begin
     FiltroFichaArticulo;
end;

procedure TBrwFdaForm.FormManagerReportRequest;
begin
     ListadoFichasArticulos;
end;

procedure TBrwFdaForm.FormManagerShowForm;
begin

     // Situar aqui la inicialización de los campos permite actualizarlos cuando se llama a la
     // ventana y ésta ya existe

     DataSeleccionAlmacen.Value := 0;

     If   High( FormValues )>=0
     then DataCodigoArticulo.Value := FormValues[ 0 ];

     If   High( FormValues )=1
     then DataFechaInicial.Value := FormValues[ 1 ]
     else DataFechaInicial.Value := ApplicationContainer.Today30DaysAgoDate;

     DataFechaFinal.Value := ApplicationContainer.TodayDate;
end;

procedure TBrwFdaForm.AgruparCtrlPropertiesEditValueChanged(Sender: TObject);
begin
     With TableView do
       begin
       OptionsCustomize.GroupBySorting := AgruparCtrl.Checked;
       AgruparLabel.Visible := AgruparCtrl.Checked;
       If   AgruparCtrl.Checked
       then begin
            try
              Screen.Cursor := crHourglass;
              TableView.DataController.Groups.ChangeGrouping( TableView.Controller.FocusedColumnIndex, 0 );
              TableView.Styles.ContentEven := nil;
            finally
              Screen.Cursor := crDefault;
              end;
            end
       else TableView.Styles.ContentEven := ApplicationContainer.QueryContentEvenStyle;
       end;
end;

procedure TBrwFdaForm.PopupMenuPopup(Sender: TObject);
begin
     If   TableView.Controller.SelectedRecordCount=0
     then Abort;
end;

function TBrwFdaForm.FormManagerGetAccessLevel: Smallint;
begin
     With DataModule00.DmUsuarioFields do
       Result := CheckAccessLevel( [ AcAL.Value, AcALFicheros.Value ] );
end;

procedure TBrwFdaForm.FormManagerInitializeForm;
begin

     ArticuloFields := TArticuloFields.Create( Self );

     SeleccionAlmacenCtrl.Enabled := DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value;

     With DataModule00.DmEmpresaFields do
       begin

       TableViewNumeroSerie.Visible := Compras_NrosSerie.Value or Ventas_NrosSerie.Value;
       If   TableViewNumeroSerie.Visible
       then Width := Width + 30;
       TableViewLoteFabricacion.Visible := Stock_LotesProductos.Value;
       TableViewCodigoAlmacen.Visible := Stock_MultiAlmacen.Value;
       TableViewUbicacion.Visible := Stock_Ubicaciones.Value;
       TableViewFechaCaducidad.Visible := DataModule00.Trazabilidad and ( Compras_FechaCaducidad.Value or Ventas_FechaCaducidad.Value );

       FDecimalesCantidad := Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value );

       SetColumnDecimals( TableViewEntradas, Compras_DecCantidad.Value );
       SetColumnDecimals( TableViewSalidas, Ventas_DecCantidad.Value );
       SetColumnDecimals( TableViewPrecio, Max( Compras_DecPrecio.Value, Ventas_DecPrecio.Value ) );
       SetColumnDecimals( TableViewDescuento, Max( Compras_DecDto.Value, Ventas_DecDto.Value ) );

       Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

       end;

     If   DataModule00.DmUsuarioFields.Compras_OcultarPrecios.Value
     then begin
          TableViewPrecio.Visible := False;
          TableViewDescuento.Visible := False;
          end;

     TipoMovAlmacen;  // Solo estoy cargando el módulo para que se actualicen si es necesario

end;

end.




