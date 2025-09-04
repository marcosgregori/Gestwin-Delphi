
unit cx_fpa;

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
  TcxFpaForm = class(TgxForm)
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
    QueryCanalPreferente: TWideStringField;
    cxGridDBTableViewPlazos: TcxGridDBColumn;
    cxGridDBTableViewPrimerVencimiento: TcxGridDBColumn;
    cxGridDBTableViewIntervalo: TcxGridDBColumn;
    cxGridDBTableViewCanalPreferente: TcxGridDBColumn;
  private
  public
  end;

var  cxFpaForm : TcxFpaForm = nil;

procedure ConsultaFormasPago( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaFormasPago( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxFpaForm, cxFpaForm, Edit, InitialState );
end;

end.
