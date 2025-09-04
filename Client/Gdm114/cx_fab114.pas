
unit cx_fab114;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinscxPCPainter,
  DataManager, QueryForm, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxFab114Form = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
  private
  public
  end;

var  CxFab114Form : TCxFab114Form = nil;

procedure ConsultaFabricas( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaFabricas( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxFab114Form, CxFab114Form, Edit, InitialState );
end;

end.
