
unit cx_rut;

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
  TCxRutForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
  private
  public
  end;

var  CxRutForm : TCxRutForm = nil;

procedure ConsultaRutas( Edit   : TcxCustomEdit;
                         InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaRutas( Edit   : TcxCustomEdit;
                         InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxRutForm, CxRutForm, Edit, InitialState );
end;

end.
