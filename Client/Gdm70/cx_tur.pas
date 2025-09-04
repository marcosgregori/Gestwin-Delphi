
unit cx_tur;

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
  TcxTurForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroTurno: TSmallintField;
    QueryDescripcion: TWideStringField;
    TableViewNroTurno: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
  private
  protected
  end;

var  CxTurForm : TcxTurForm = nil;

procedure ConsultaTurnos( Edit   : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTurnos( Edit   : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTurForm, CxTurForm, Edit, InitialState );
end;

end.
