
unit cx_ldp2;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppManager,
  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, sqlset, cxLookAndFeels,
  cxLookAndFeelPainters, QueryForm,

  Gim30Fields, cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TCxLdp2Form = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewFecha: TcxGridDBColumn;
    TableViewLoteFabricacion: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroDocumento: TcxGridDBColumn;
    TableViewNroOperacion: TcxGridDBColumn;
    QueryLoteFabricacion: TWideStringField;
    QuerySumaCantidad: TBCDField;
    QueryNroOperacion: TIntegerField;
    QueryFecha: TDateField;
    QueryUIDArticulo: TGuidField;
    QuerySerie: TWideStringField;
    QueryNroDocumento: TIntegerField;
    TableViewSumaCantidad: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QueryTipoMovimiento: TSmallintField;
    QueryDescripcionDocumento: TWideStringField;
    TableViewDescripcionDocumento: TcxGridDBColumn;
    QueryExistencias: TBCDField;
    TableViewExistencias: TcxGridDBColumn;
    QueryNroRegistro: TLongWordField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    QueryFechaCaducidad: TDateField;
    TableViewFechaCaducidad: TcxGridDBColumn;
    QueryExistenciasVirtuales: TBCDField;
    TableViewExistenciasVirtuales: TcxGridDBColumn;
    QueryCodigoAlmacen: TWideStringField;
    TableViewCodigoAlmacen: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryAfterOpen(DataSet: TDataSet);
  private
    CodigoAlmacen : String;
    FechaInicial,
    FechaFinal : TDate;

  public
    class var
    CodigoArticulo : String;
    FechaDocumento : TDate;
    OnUserSelection : TDataEditEvent;
    SeccionComercial : TSeccionComercial;
  end;

var  CxLdp2Form : TCxLdp2Form = nil;

procedure ConsultaLotesProductos2( Edit             : TcxCustomEdit;
                                   CodigoArticulo   : String;
                                   FechaDocumento   : TDate;
                                   UserSelection    : TDataEditEvent;
                                   SeccionComercial : TSeccionComercial = scVentas );

implementation

uses LibUtils,
     DateUtils,

     Gdm00Dm,
     Gim00Fields,

     dmi_sto,

     dm_cls,
     dm_alm,
     dm_tma,
     dm_mov,
     dm_sto;

{$R *.dfm}

procedure ConsultaLotesProductos2( Edit             : TcxCustomEdit;
                                   CodigoArticulo   : String;
                                   FechaDocumento   : TDate;
                                   UserSelection    : TDataEditEvent;
                                   SeccionComercial : TSeccionComercial = scVentas );
begin
     TCxLdp2Form.CodigoArticulo := CodigoArticulo;
     TCxLdp2Form.FechaDocumento := FechaDocumento;
     TCxLdp2Form.OnUserSelection := UserSelection;
     TCxLdp2Form.SeccionComercial := SeccionComercial;
     CreateQueryForm( TCxLdp2Form, CxLdp2Form, Edit, qgsNormal );
end;

procedure TCxLdp2Form.FormCreate(Sender: TObject);
begin
     QueryPanel.OnDataSelected := OnUserSelection;

     SetColumnsDecimals( [ TableViewSumaCantidad, TableViewExistencias, TableViewExistenciasVirtuales ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );

     //** 04.02.2010  Para los que no tengan multialmacén o utilicen un almacén por defecto,
     //               se puede comprobar si tienen una rotura de stocks.

     FechaInicial := IncYear( ApplicationContainer.TodayDate, -1 );
     FechaFinal := FechaDocumento;
     CodigoAlmacen := Almacen.AlmacenPorDefecto( SeccionComercial );

     If   not DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value or ( CodigoAlmacen<>'' )
     then begin
          var AlmacenFields := Almacen.ObtenRegistro( CodigoAlmacen );
          If   Assigned( AlmacenFields )
          then If   AlmacenFields.RoturaStock.Value
               then FechaInicial := AlmacenFields.FechaRotura.Value;
          end;

     // Si ya se ha realizado el inventario inicial no es conveniente que la consulta se traslade al ejercicio anterior

     If   Movimiento.ExisteMovimientoInventario and ( FechaInicial<ApplicationContainer.FirstDayOfYearDate )
     then FechaInicial := ApplicationContainer.FirstDayOfYearDate;

     Query.SetParamValues( [ CodigoArticulo, FechaInicial, FechaFinal, CodigoArticulo ] );

     TableViewFechaCaducidad.Visible := DataModule00.Trazabilidad and
                                        ( ( SeccionComercial=scCompras ) and ( DataModule00.DmEmpresaFields.Compras_FechaCaducidad.Value ) ) or
                                        ( ( SeccionComercial=scVentas ) and ( DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value ) );
     TableViewFechaCaducidad.VisibleForCustomization := DataModule00.Trazabilidad;

     var SQLText := Query.SQL.Text;
     If   DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value
     then StrAdd( SQLText, 'Linea.FechaCaducidad' )
     else StrAdd( SQLText, 'Linea.Fecha' );
     Query.SQL.Text := SQLText;

end;

procedure TCxLdp2Form.QueryAfterOpen(DataSet: TDataSet);
begin
     If   not ShiftKey
     then With TableView.DataController do
            begin
            DataModeController.GridMode := False;
            Filter.Root.AddItem( TableViewExistencias, foGreater, 0.0, '' );
            Filter.Active := True;
            GotoFirst;
            end;
end;

procedure TCxLdp2Form.QueryCalcFields(DataSet: TDataSet);

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     QueryDescripcionDocumento.Value := TipoMovAlmacen.Descripcion( QueryTipoMovimiento.Value, False );
     ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                     False, QueryCodigoClaseA.Value, QueryCodigoClaseB.Value, QueryCodigoClaseC.Value,
                                                     False, QueryLoteFabricacion.Value,
                                                     False, QueryCodigoAlmacen.Value,
                                                     True, '',
                                                     False,
                                                     ApplicationContainer.Ejercicio,
                                                     0,
                                                     ApplicationContainer.NroMesFinal );
     QueryExistencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
     QueryExistenciasVirtuales.Value := ExistenciasArticulo.SumaExistencias.PendienteRecibir +
                                        ExistenciasArticulo.SumaExistencias.Saldo -
                                        ExistenciasArticulo.SumaExistencias.PendienteServir;
end;

procedure TCxLdp2Form.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     {
     If   ( Column=TableViewExistencias ) and ( TableViewExistencias.Visible )
     then TableView.DataController.RefreshExternalData;
     }
end;

end.
