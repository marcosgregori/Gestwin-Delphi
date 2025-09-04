
unit ct_usr;

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

  TouchQueryForm, cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxLabel;

type
  TctUsrForm = class(TgxForm)
    QueryPanel: TTouchQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    cxGridDBTableViewNombre: TcxGridDBColumn;
    BottomPanel: TcxGroupBox;
    cxLabel1: TcxLabel;
  private
  public
  end;

var  ctUsrForm : TctUsrForm = nil;

procedure ConsultaUsuarios( Edit    : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal ); overload;

implementation

{$R *.dfm}

procedure ConsultaUsuarios( Edit   : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateTouchQueryForm( TctUsrForm, ctUsrForm, Edit, qgsLinked );
end;

end.
