
unit cx_mat;

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
  TCxMatForm = class(TgxForm)
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
  private
  public
  end;

var  CxMatForm : TCxMatForm = nil;

procedure ConsultaMaquinasTipo( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaMaquinasTipo( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxMatForm, CxMatForm, Edit, InitialState );
end;

end.
