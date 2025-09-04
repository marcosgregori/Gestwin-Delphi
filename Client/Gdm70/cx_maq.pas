
unit cx_maq;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxMaqForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryCodigoMaquinaTipo: TWideStringField;
    TableViewCodigoMaquinaTipo: TcxGridDBColumn;
  private
  public
  end;

var  CxMaqForm : TCxMaqForm = nil;

procedure ConsultaMaquinas( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaMaquinas( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxMaqForm, CxMaqForm, Edit, InitialState );
end;

end.
