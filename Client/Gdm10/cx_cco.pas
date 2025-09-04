
unit cx_cco;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, QueryForm, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxCcoForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
  private
  public
  end;

var  cxCcoForm : TcxCcoForm = nil;

procedure ConsultaCentrosCoste( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess;

procedure ConsultaCentrosCoste( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxCcoForm, cxCcoForm, Edit, InitialState );
end;

end.
