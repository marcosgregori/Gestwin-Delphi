
unit cx_cnw;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxCnwForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    QueryTelefono: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    TableViewTelefono: TcxGridDBColumn;
  private
  public
  end;

var  CxCnwForm : TCxCnwForm = nil;

procedure ConsultaContactosWeb( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaContactosWeb( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxCnwForm, CxCnwForm, Edit, InitialState );
end;

end.
