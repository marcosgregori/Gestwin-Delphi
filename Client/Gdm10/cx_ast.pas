
unit cx_ast;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsDefaultPainters, QueryForm, cxContainer, cxGroupBox, cxNavigator, cxIntegerEdit, cxTextEdit,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxAstForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroAsiento: TIntegerField;
    QueryFecha: TDateField;
    QueryTipoAsiento: TSmallintField;
    QuerySerie: TWideStringField;
    QueryNroFactura: TIntegerField;
    QueryPropietario: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewNroAsiento: TcxGridDBColumn;
    TableViewFecha: TcxGridDBColumn;
    TableViewTipoAsiento: TcxGridDBColumn;
    TableViewSerie: TcxGridDBColumn;
    TableViewNroFactura: TcxGridDBColumn;
    TableViewPropietario: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryEjercicio: TSmallintField;
    QuerySerieNroFactura: TStringField;
    TableViewSerieNroFactura: TcxGridDBColumn;
    procedure queryPanelUserSelection;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure TableViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
  private
  protected
  end;

var  CxAstForm : TCxAstForm = nil;

procedure ConsultaAsientos( Edit    : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess,

     a_ast,

     dm_fac;

procedure ConsultaAsientos( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxAstForm, CxAstForm, Edit, InitialState, dsFrom30DaysAgo );
end;

procedure TCxAstForm.TableViewSerieNroFacturaGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
begin
     If   ValueIsEmpty( ARecord.Values[ TableViewNroFactura.Index ] )
     then AProperties := TableViewSerieNroFactura.Properties
     else AProperties := TableViewNroFactura.Properties;
end;

procedure TCxAstForm.QueryCalcFields(DataSet: TDataSet);
begin
     QuerySerieNroFactura.Value := Factura.TextoSerieNroFactura( QuerySerie.Value, QueryNroFactura.Value );
end;

procedure TCxAstForm.QueryPanelUserSelection;
begin
     MntAsientos( [ QueryEjercicio.Value, QueryNroAsiento.Value ] );
end;

end.

