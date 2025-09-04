
unit ct_emp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, Menus, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, DataManager, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxLabel, TouchQueryForm;

type
  TCtEmpForm = class(TgxForm)
    queryPanel: TTouchQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    TableViewNombre: TcxGridDBColumn;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    BottomPanel: TcxGroupBox;
    cxLabel1: TcxLabel;
  private
  public
  end;

var  CtEmpForm : TCtEmpForm = nil;

procedure ConsultaEmpresas( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaEmpresas( Edit         : TcxCustomEdit;
                            InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateTouchQueryForm( TctEmpForm, ctEmpForm, Edit, qgsLinked );
end;

end.
