
unit cx_ban;

interface

uses Forms, AppForms, Classes, Controls,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, cxCurrencyEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxBanForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QuerySubcuenta: TWideStringField;
    QueryNombre: TWideStringField;
    QueryLocalidad: TWideStringField;
    cxGridDBTableViewSubcuenta: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    cxGridDBTableViewLocalidad: TcxGridDBColumn;
    QueryDomicilio: TWideStringField;
    QueryRiesgo: TBCDField;
    QueryDiasCancelacion: TSmallintField;
    cxGridDBTableViewDomicilio: TcxGridDBColumn;
    cxGridDBTableViewRiesgo: TcxGridDBColumn;
    cxGridDBTableViewDiasCancelacion: TcxGridDBColumn;
    procedure QueryPanelUserSelection;
  private
  public
  end;

var  CxBanForm : TCxBanForm = nil;

procedure ConsultaBancos( Edit         : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );

implementation

uses  a_ban;

{$R *.dfm}

procedure ConsultaBancos( Edit         : TcxCustomEdit;
                          InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxBanForm, cxBanForm, Edit, InitialState );
end;

procedure TcxBanForm.QueryPanelUserSelection;
begin
     MntBancos( [ QuerySubcuenta.Value ] );
end;

end.
