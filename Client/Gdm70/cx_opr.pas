
unit cx_opr;

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
  TCxOprForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    QueryCodigoOperarioTipo: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewCodigoOperarioTipo: TcxGridDBColumn;
  private
  public
  end;

var  CxOprForm : TCxOprForm = nil;

procedure ConsultaOperarios( Edit         : TcxCustomEdit;
                             InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaOperarios( Edit         : TcxCustomEdit;
                             InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxOprForm, CxOprForm, Edit, InitialState );
end;

end.
