
unit cx_nav114;

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
  TCxNav114Form = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    QueryNombre: TWideStringField;
  private
  public
  end;

var  CxNav114Form : TCxNav114Form = nil;

procedure ConsultaNavieras( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaNavieras( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxNav114Form, CxNav114Form, Edit, InitialState );
end;

end.
