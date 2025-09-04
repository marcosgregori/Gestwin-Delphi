
unit cx_ven;

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
  TCxVenForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
  private
  public
  end;

var  CxVenForm : TCxVenForm = nil;

procedure ConsultaVendedores( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaVendedores( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxVenForm, CxVenForm, Edit, InitialState );
end;

end.
