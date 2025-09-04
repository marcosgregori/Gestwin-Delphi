
unit cx_ldp1;

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
  dxScrollbarAnnotations;

type
  TCxLdp1Form = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewLoteFabricacion: TcxGridDBColumn;
    QueryLoteFabricacion: TWideStringField;
    QueryCodigoAlmacen: TWideStringField;
    QueryUbicacion: TWideStringField;
    QueryEntradas: TBCDField;
    QueryExistencias: TBCDField;
    TableViewCodigoAlmacen: TcxGridDBColumn;
    TableViewUbicacion: TcxGridDBColumn;
    TableViewEntradas: TcxGridDBColumn;
    TableViewExistencias: TcxGridDBColumn;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    QueryExistenciasVirtuales: TBCDField;
    TableViewExistenciasVirtuales: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryAfterOpen(DataSet: TDataSet);
  private
    CodigoAlmacen : String;
    FechaInicial : TDate;

  public
    class var CodigoArticulo : String;
    class var OnUserSelection : TDataEditEvent;
    class var SeccionComercial : TSeccionComercial;
  end;

var  CxLdp1Form : TCxLdp1Form = nil;

var  OnUserSelection : TSimpleEvent;

procedure ConsultaLotesProductos1( Edit             : TcxCustomEdit;
                                   CodigoArticulo   : String;
                                   UserSelection    : TDataEditEvent = nil;
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
     dm_sto;

{$R *.dfm}

procedure ConsultaLotesProductos1( Edit             : TcxCustomEdit;
                                   CodigoArticulo   : String;
                                   UserSelection    : TDataEditEvent = nil;
                                   SeccionComercial : TSeccionComercial = scVentas );
begin
     TCxLdp1Form.CodigoArticulo := CodigoArticulo;
     TCxLdp1Form.OnUserSelection := UserSelection;
     TCxLdp1Form.SeccionComercial := SeccionComercial;
     CreateQueryForm( TCxLdp1Form, CxLdp1Form, Edit, qgsNormal );
end;

procedure TCxLdp1Form.FormCreate(Sender: TObject);
begin
     QueryPanel.OnDataSelected := OnUserSelection;

     SetColumnsDecimals( [ TableViewEntradas, TableViewExistencias, TableViewExistenciasVirtuales ], DataModule00.DmEmpresaFields.Ventas_DecCantidad.Value );
     {
     FechaInicial := IncYear( ApplicationContainer.TodayDate, -1 );
     If   not DataModule00.DmEmpresaFields.Stock_MultiAlmacen.Value or ( CodigoAlmacen<>'' )
     then With Almacen do
            If   Obten( CodigoAlmacen, False )
            then If   DmAlmacenFields.RoturaStock.Value
                 then FechaInicial := DmAlmacenFields.FechaRotura.Value;
     }
     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
     Query.SetParamValues( [ ApplicationContainer.Ejercicio, CodigoArticulo ] );
end;

procedure TCxLdp1Form.QueryAfterOpen(DataSet: TDataSet);
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

procedure TCxLdp1Form.QueryCalcFields(DataSet: TDataSet);

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                     False, QueryCodigoClaseA.Value, QueryCodigoClaseB.Value, QueryCodigoClaseC.Value,
                                                     False, QueryLoteFabricacion.Value,
                                                     False, QueryCodigoAlmacen.Value,
                                                     True, '',
                                                     False,
                                                     ApplicationContainer.Ejercicio,
                                                     0,
                                                     ApplicationContainer.NroMesFinal );

     QueryEntradas.Value := ExistenciasArticulo.SumaExistencias.Entradas;
     QueryExistencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;
     QueryExistenciasVirtuales.Value := ExistenciasArticulo.SumaExistencias.PendienteRecibir +
                                        ExistenciasArticulo.SumaExistencias.Saldo -
                                        ExistenciasArticulo.SumaExistencias.PendienteServir;
end;

//  Accept := QueryExistencias.Value>0.0;

procedure TCxLdp1Form.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     {
     If   ( Column=TableViewExistencias ) and ( TableViewExistencias.Visible )
     then TableView.DataController.RefreshExternalData;
     }
end;

end.
