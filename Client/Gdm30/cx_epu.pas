
unit cx_epu;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppManager,
  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  dxCore, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb,

  Gim30Fields, cxCurrencyEdit, DataManager, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TCxEpuForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryUbicacion: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryCantidad: TBCDField;
    TableViewUbicacion: TcxGridDBColumn;
    TableViewCantidad: TcxGridDBColumn;
    TableViewLoteFabricacion: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryLoteFabricacion: TWideStringField;
    QueryEjercicio: TSmallintField;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryCodigoAlmacen: TWideStringField;
    QueryFechaUltEntrada: TDateField;
    QueryFechaUltSalida: TDateField;
    QueryCosteUltEntrada: TBCDField;
    QueryCoste_Medio: TBCDField;
    QueryPrecioUltSalida: TBCDField;
    QueryPendiente_Recibir0: TBCDField;
    QueryPendiente_Recibir: TBCDField;
    QueryPendiente_Servir0: TBCDField;
    QueryPendiente_Servir: TBCDField;
    QueryReservado: TBCDField;
    QueryApertura_Entradas: TBCDField;
    QueryApertura_Salidas: TBCDField;
    QueryEnero_Entradas: TBCDField;
    QueryEnero_Salidas: TBCDField;
    QueryFebrero_Entradas: TBCDField;
    QueryFebrero_Salidas: TBCDField;
    QueryMarzo_Entradas: TBCDField;
    QueryMarzo_Salidas: TBCDField;
    QueryAbril_Entradas: TBCDField;
    QueryAbril_Salidas: TBCDField;
    QueryMayo_Entradas: TBCDField;
    QueryMayo_Salidas: TBCDField;
    QueryJunio_Entradas: TBCDField;
    QueryJunio_Salidas: TBCDField;
    QueryJulio_Entradas: TBCDField;
    QueryJulio_Salidas: TBCDField;
    QueryAgosto_Entradas: TBCDField;
    QueryAgosto_Salidas: TBCDField;
    QuerySeptiembre_Entradas: TBCDField;
    QuerySeptiembre_Salidas: TBCDField;
    QueryOctubre_Entradas: TBCDField;
    QueryOctubre_Salidas: TBCDField;
    QueryNoviembre_Entradas: TBCDField;
    QueryNoviembre_Salidas: TBCDField;
    QueryDiciembre_Entradas: TBCDField;
    QueryDiciembre_Salidas: TBCDField;
    QueryUbicacionDeCarga: TBooleanField;
    TableViewUbicacionDeCarga: TcxGridDBColumn;
    QueryExistenciasVirtuales: TBCDField;
    TableViewExistenciasVirtuales: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    FStockFields : TStockFields;
  protected
    class var
    OnUserSelection : TDataEditEvent;
    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC,
    LoteFabricacion,
    CodigoAlmacen : String;

  function StockFields : TStockFields;
  end;

var  CxEpuForm : TCxEpuForm = nil;

procedure ConsultaExistenciasUbicacion( CodigoArticulo,
                                        CodigoClaseA,
                                        CodigoClaseB,
                                        CodigoClaseC,
                                        LoteFabricacion,
                                        CodigoAlmacen   : String;
                                        Edit            : TcxCustomEdit;
                                        UserSelection   : TDataEditEvent = nil );

implementation

uses  Graphics,
      LibUtils,

      Gdm00Dm,
      Gim00Fields,

      dmi_sto,

      dm_sto;

{$R *.dfm}

procedure ConsultaExistenciasUbicacion( CodigoArticulo,
                                        CodigoClaseA,
                                        CodigoClaseB,
                                        CodigoClaseC,
                                        LoteFabricacion,
                                        CodigoAlmacen   : String;
                                        Edit            : TcxCustomEdit;
                                        UserSelection   : TDataEditEvent = nil  );
begin
     TcxEpuForm.CodigoArticulo := CodigoArticulo;
     TcxEpuForm.CodigoClaseA := CodigoClaseA;
     TcxEpuForm.CodigoClaseB := CodigoClaseB;
     TcxEpuForm.CodigoClaseC := CodigoClaseC;
     TcxEpuForm.LoteFabricacion:= LoteFabricacion;
     TcxEpuForm.CodigoAlmacen := CodigoAlmacen;
     TcxEpuForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxEpuForm, CxEpuForm, Edit );
end;

procedure TCxEpuForm.FormCreate(Sender: TObject);

var  SQLText : String;

begin
     With DataModule00.DmEmpresaFields do
       begin
       TableViewLoteFabricacion.Visible := Stock_LotesProductos.Value and ( LoteFabricacion='' );
       SetColumnsDecimals( [ TableViewCantidad, TableViewExistenciasVirtuales ], Ventas_DecCantidad.Value );
       end;

     //* 19.10.2011 Si no se especifica lote de fabricación y los lotes están activados, permito seleccionar una ubicación y lote, que luego debe actualizarse en el documento destino

     If   LoteFabricacion=''
     then QueryPanel.OnDataSelected := OnUserSelection;

     SQLText := SQLVarsFormat( 'SELECT Stock.*, Ubicacion.Descripcion, Ubicacion.UbicacionDeCarga ' +
                               'FROM   Stock, Ubicacion ' +
                               'WHERE  Stock.Ejercicio=? AND ' +
                               '       Stock.CodigoArticulo=? AND ' +
                               '       Stock.CodigoClaseA=? AND ' +
                               '       Stock.CodigoClaseB=? AND ' +
                               '       Stock.CodigoClaseC=? AND ' +
                               '       Stock.CodigoAlmacen=? AND ' +
                               '       Stock.Ubicacion<>'''' ',
                               [ ApplicationContainer.Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CodigoAlmacen ] );

     If   LoteFabricacion<>''
     then StrAdd( SQLText, SQLVarsFormat( ' AND LoteFabricacion=?', [ LoteFabricacion ] ) );

     StrAdd( SQLText, ' AND Stock.CodigoAlmacen=Ubicacion.CodigoAlmacen AND Stock.Ubicacion=Ubicacion.Codigo ' );

     StrAdd( SQLText, ' ORDER BY Stock.Ubicacion ' );

     Query.SQL.Text := SQLText;
end;

function TCxEpuForm.StockFields : TStockFields;
begin
     If   not Assigned( FStockFields )
     then FStockFields := TStockFields.Create( Query );
     Result := FStockFields;
end;

procedure TCxEpuForm.TableViewCustomDrawCell(      Sender: TcxCustomGridTableView;
                                                   ACanvas: TcxCanvas;
                                                   AViewInfo: TcxGridTableDataCellViewInfo;
                                               var ADone: Boolean);
begin
     If   not AViewInfo.Selected
     then If   VarToBoolean( AViewInfo.GridRecord.Values[ TableViewUbicacionDeCarga.Index ] )
          then ACanvas.Font.Color := clGray;
end;

procedure TCxEpuForm.QueryAfterOpen(DataSet: TDataSet);
begin
     With TableView.DataController do
       begin
       DataModeController.GridMode := False;
       Filter.Root.AddItem( TableViewCantidad, foNotEqual, 0.0, '' );
       Filter.Active := True;
       TableViewCantidad.SortOrder := soDescending;
       GotoFirst;
       end;
end;

procedure TCxEpuForm.QueryCalcFields(DataSet: TDataSet);

var SumaExistencias : IExistencias;

begin
     SumaExistencias := TExistencias.Create;
     StockAlmacen.AcumulaExistencias( StockFields, SumaExistencias, 0, 12 );
     QueryCantidad.Value := SumaExistencias.Saldo;
     QueryExistenciasVirtuales.Value := SumaExistencias.Saldo + SumaExistencias.PendienteRecibir - SumaExistencias.PendienteServir;
end;

end.
