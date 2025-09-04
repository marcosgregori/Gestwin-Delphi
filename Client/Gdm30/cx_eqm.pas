
unit cx_eqm;

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
  TcxEqmForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
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

var  cxEqmForm : TcxEqmForm = nil;

procedure ConsultaEquiposMoviles( Edit   : TcxCustomEdit;
                                  InitialState : TQueryGridInitialState = qgsNormal ); 

implementation

{$R *.dfm}

procedure ConsultaEquiposMoviles( Edit   : TcxCustomEdit;
                                  InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxEqmForm, cxEqmForm, Edit, InitialState );
end;

end.
