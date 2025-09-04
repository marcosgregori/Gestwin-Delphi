
unit cx_gdo;

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
  TcxGdoForm = class(TgxForm)
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

var  cxGdoForm : TcxGdoForm = nil;

procedure ConsultaGruposDocumento( Edit   : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaGruposDocumento( Edit   : TcxCustomEdit;
                                   InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxGdoForm, cxGdoForm, Edit, InitialState);
end;

end.
