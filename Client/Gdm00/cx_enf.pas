
unit cx_enf;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinscxPCPainter, DataManager, QueryForm, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator,

  AppManager, dxDateRanges, dxScrollbarAnnotations;

type
  TCxEnfForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryNombre: TWideStringField;
    QueryBIC: TWideStringField;
    TableViewBIC: TcxGridDBColumn;
    QuerySucursal: TWideStringField;
    TableViewSucursal: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
  class var OnUserSelection : TDataEditEvent;
  public
  end;

var  CxEnfForm : TCxEnfForm = nil;

procedure ConsultaEntidadesFinancieras( Edit            : TcxCustomEdit;
                                        InitialState    : TQueryGridInitialState = qgsNormal;
                                        OnUserSelection : TDataEditEvent = nil );

implementation

{$R *.dfm}

procedure ConsultaEntidadesFinancieras( Edit            : TcxCustomEdit;
                                        InitialState    : TQueryGridInitialState = qgsNormal;
                                        OnUserSelection : TDataEditEvent = nil );
begin
     TCxEnfForm.OnUserSelection := OnUserSelection;
     CreateQueryForm( TCxEnfForm, CxEnfForm, Edit, InitialState );
end;

procedure TCxEnfForm.FormCreate(Sender: TObject);
begin
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
