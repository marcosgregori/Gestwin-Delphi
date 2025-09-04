
unit cx_usr;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinscxPCPainter,
  DataManager, cxLookAndFeels, cxLookAndFeelPainters,

  QueryForm, cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxUsrForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    cxGridDBTableViewCodigo: TcxGridDBColumn;
    cxGridDBTableViewNombre: TcxGridDBColumn;
  private
  public
  end;

var  cxUsrForm : TcxUsrForm = nil;

procedure ConsultaUsuarios( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal ); overload;

implementation

{$R *.dfm}

procedure ConsultaUsuarios( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxUsrForm, cxUsrForm, Edit, InitialState );
end;

end.
