
unit cx_tvp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, DataManager, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TcxTvpForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryTipo: TSmallintField;
    QueryDescripcion: TWideStringField;
    TableViewTipo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
  private
  protected
    class var
    ExcluirComprasVentas : Boolean;
  end;

var  cxTvpForm : TcxTvpForm = nil;

procedure ConsultaTiposVentasPeriodicas( Edit                 : TcxCustomEdit;
                                         ExcluirComprasVentas : Boolean = False;
                                         InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTiposVentasPeriodicas( Edit                 : TcxCustomEdit;
                                         ExcluirComprasVentas : Boolean = False;
                                         InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTvpForm, cxTvpForm, Edit, InitialState);
end;

end.
