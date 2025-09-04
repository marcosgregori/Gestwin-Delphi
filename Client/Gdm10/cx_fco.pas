
unit cx_fco;

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
  TcxFcoForm = class(TgxForm)
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
    QueryPlazos: TSmallintField;
    QueryPrimerVencimiento: TSmallintField;
    QueryIntervalo: TSmallintField;
    QueryDiaCobro1: TSmallintField;
    QueryDiaCobro2: TSmallintField;
    QueryCanalPreferente: TWideStringField;
    cxGridDBTableViewPlazos: TcxGridDBColumn;
    cxGridDBTableViewPrimerVencimiento: TcxGridDBColumn;
    cxGridDBTableViewIntervalo: TcxGridDBColumn;
    cxGridDBTableViewDiaCobro1: TcxGridDBColumn;
    cxGridDBTableViewDiaCobro2: TcxGridDBColumn;
    cxGridDBTableViewCanalPreferente: TcxGridDBColumn;
  private
  public
  end;

var  cxFcoForm : TcxFcoForm = nil;

procedure ConsultaFormasCobro( Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaFormasCobro( Edit   : TcxCustomEdit;
                               InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxFcoForm, cxFcoForm, Edit, InitialState );
end;

end.
