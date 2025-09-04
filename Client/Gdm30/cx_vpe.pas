
unit cx_vpe;

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
  TCxVpeForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryNroFicha: TIntegerField;
    QueryCodigoCliente: TWideStringField;
    QueryNombre: TWideStringField;
    cxGridDBTableViewNroFicha: TcxGridDBColumn;
    cxGridDBTableViewCodigoCliente: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
  private
  public
  end;

var  CxVpeForm : TCxVpeForm = nil;

procedure ConsultaVentasPeriodicas( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaVentasPeriodicas( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxVpeForm, CxVpeForm, Edit, InitialState );
end;

end.
