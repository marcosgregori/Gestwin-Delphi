
unit cx_pai;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinscxPCPainter, DataManager, QueryForm, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TcxPaiForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
  private
  public
  end;

var  cxPaiForm : TcxPaiForm = nil;

procedure consultaPaises( Edit         : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure consultaPaises( Edit         : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxPaiForm, cxPaiForm, Edit, InitialState );
end;

end.
