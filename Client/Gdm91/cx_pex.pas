
unit cx_pex;

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
  TCxPexForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
  private
  public
  end;

var  CxPexForm : TCxPexForm = nil;

procedure ConsultaProveedoresExternos( Edit   : TcxCustomEdit;
                                       InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaProveedoresExternos( Edit   : TcxCustomEdit;
                                       InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxPexForm, cxPexForm, Edit, InitialState );
end;

end.
