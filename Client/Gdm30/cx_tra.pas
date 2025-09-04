
unit cx_tra;

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
  TCxTraForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryNombre: TWideStringField;
    QueryTelefono: TWideStringField;
    QueryMatricula: TWideStringField;
    QuerySemiremolque: TWideStringField;
    TableViewTelefono: TcxGridDBColumn;
    TableViewMatricula: TcxGridDBColumn;
    TableViewSemiremolque: TcxGridDBColumn;
  private
  public
  end;

var  CxTraForm : TCxTraForm = nil;

procedure ConsultaTransportistas( Edit   : TcxCustomEdit;
                                  InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTransportistas( Edit   : TcxCustomEdit;
                                  InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxTraForm, CxTraForm, Edit, InitialState );
end;

end.
