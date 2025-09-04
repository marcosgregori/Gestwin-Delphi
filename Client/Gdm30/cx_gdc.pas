
unit cx_gdc;

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
  TcxGdcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
  private
  public
  end;

var  cxGdcForm : TcxGdcForm = nil;

procedure ConsultaGruposCliente( Edit   : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaGruposCliente( Edit   : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxGdcForm, cxGdcForm, Edit, InitialState );
end;

end.
