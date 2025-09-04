
unit cx_tlm;

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
  TcxTlmForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryDescripcion: TWideStringField;
  private
  public
  end;

var  cxTlmForm : TcxTlmForm = nil;

procedure ConsultaTiposLineaMovimiento( Edit   : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTiposLineaMovimiento( Edit   : TcxCustomEdit;
                                        InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTlmForm, cxTlmForm, Edit, InitialState );
end;

end.
