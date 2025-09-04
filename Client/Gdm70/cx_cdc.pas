
unit cx_cdc;

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
  TcxCdcForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    TableViewTipo: TcxGridDBColumn;
    QueryCodigo: TSmallintField;
    QueryDescripcion: TWideStringField;
    QueryTipo: TSmallintField;
  private
  public
  end;

var  cxCdcForm : TcxCdcForm = nil;

procedure ConsultaCodigosCoste( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses EnterpriseDataAccess;

procedure ConsultaCodigosCoste( Edit   : TcxCustomEdit;
                                InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxCdcForm, cxCdcForm, Edit, InitialState );
end;

end.
