
unit cx_tde;

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
  TcxTdeForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewTipo: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    QueryCodigo: TSmallintField;
    QueryDescripcion: TWideStringField;
  private
  protected
  end;

var  cxTdeForm : TcxTdeForm = nil;

procedure ConsultaTiposEnvase( Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTiposEnvase( Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTdeForm, CxTdeForm, Edit, InitialState );
end;

end.
