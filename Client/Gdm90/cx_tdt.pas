
unit cx_tdt;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxTdtForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    GridDBTableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryUrgente: TBooleanField;
    GridDBTableViewCodigo: TcxGridDBColumn;
    GridDBTableViewDescripcion: TcxGridDBColumn;
    GridDBTableViewUrgente: TcxGridDBColumn;
  private
  public
  end;

var  CxTdtForm : TCxTdtForm = nil;

procedure ConsultaTiposTarea( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaTiposTarea( Edit   : TcxCustomEdit;
                              InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTdtForm, CxTdtForm, Edit, InitialState );
end;

end.
