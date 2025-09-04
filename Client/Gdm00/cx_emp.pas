
unit cx_emp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, Menus, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, DataManager, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxEmpForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
  private
  public
  end;

var  CxEmpForm : TCxEmpForm = nil;

procedure ConsultaEmpresas( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaEmpresas( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxEmpForm, cxEmpForm, Edit, InitialState );
end;

end.

