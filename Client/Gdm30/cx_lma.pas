
unit cx_lma;

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
  TcxLmaForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryNroLinea: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var  CxLmaForm : TCxLmaForm = nil;

procedure ConsultaListasMateriales( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  dm_cls;

procedure ConsultaListasMateriales( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TCxLmaForm, CxLmaForm, Edit, InitialState );
end;

procedure TcxLmaForm.FormCreate( Sender : TObject );
begin
     Clase.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
end;

end.
