
unit cx_cdi;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinscxPCPainter, QueryForm, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, DataManager, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TcxCdiForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
  private
  public
  end;

var  CxCdiForm : TcxCdiForm = nil;

procedure ConsultaCodigosDivisa( Edit         : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaCodigosDivisa( Edit         : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal  );
begin
     CreateQueryForm( TcxCdiForm, CxCdiForm, Edit, InitialState );
end;

end.
