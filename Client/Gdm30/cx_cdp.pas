
unit cx_cdp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, DataManager, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxGroupBox, cxNavigator,

  EnterpriseDataAccess, dxDateRanges, dxScrollbarAnnotations;

type
  TcxCdpForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroRegistro: TSmallintField;
    QueryDescripcion: TWideStringField;
    TableViewNroRegistro: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
  private
  protected
  end;

var  CxCdpForm : TcxCdpForm = nil;

procedure ConsultaCambioPrecios( Edit   : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaCambioPrecios( Edit   : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxCdpForm, cxCdpForm, Edit, InitialState );
end;

end.
