
unit cx_edi;

interface

uses Forms,
     AppForms,
     Classes,
     Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, dxSkinsCore,
  dxSkinscxPCPainter, QueryForm, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TcxEdiForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewDescripcion: TcxGridDBColumn;
  private
  public
  end;

var  cxEdiForm : TcxEdiForm = nil;

procedure ConsultaElementosInmovilizado( Edit         : TcxCustomEdit;
                                         InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess;

procedure ConsultaElementosInmovilizado( Edit         : TcxCustomEdit;
                                         InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxEdiForm, cxEdiForm, Edit, InitialState );
end;

end.
