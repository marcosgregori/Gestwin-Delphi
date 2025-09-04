
unit cx_cdb;

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
  DataManager, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  dxSkinsDefaultPainters, cxContainer, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TcxCdbForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigoBarras: TWideStringField;
    QueryCodigoArticulo: TWideStringField;
    QueryClaseA: TWideStringField;
    QueryClaseB: TWideStringField;
    QueryClaseC: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigoBarras: TcxGridDBColumn;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewClaseA: TcxGridDBColumn;
    TableViewClaseB: TcxGridDBColumn;
    TableViewClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  public
    class var CodigoArticulo : String;
  end;

var  cxCdbForm : TcxCdbForm = nil;

procedure ConsultaCodigosBarras( CodigoArticulo : String;
                                 Edit           : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  SysUtils,
      LibUtils,

      dm_cls;

procedure ConsultaCodigosBarras( CodigoArticulo : String;
                                 Edit           : TcxCustomEdit;
                                 InitialState : TQueryGridInitialState = qgsNormal );
begin
     If   ShiftKey
     then CodigoArticulo := '';
     TcxCdbForm.CodigoArticulo := CodigoArticulo;
     CreateQueryForm( TcxCdbForm, cxCdbForm, Edit, InitialState );
end;

procedure TcxCdbForm.FormCreate(Sender: TObject);
begin
     Clase.SetupGridColumns( TableViewClaseA, TableViewClaseB, TableViewClaseC, 3 );

     If   CodigoArticulo<>''
     then Query.SQL.Add( ' AND CodigoArticulo=' + QuotedStr( CodigoArticulo ) );
     Query.SQL.Add( ' ORDER BY CodigoBarras' );
end;

end.
