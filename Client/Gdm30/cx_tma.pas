
unit cx_tma;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, DataManager, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TcxTmaForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryTipo: TSmallintField;
    QueryDescripcion: TWideStringField;
    TableViewTipo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    ExcluirComprasVentas,
    ExcluirPredefinidos : Boolean;
  end;

var  cxTmaForm : TcxTmaForm = nil;

procedure ConsultaTiposMovimientoAlmacen( Edit                 : TcxCustomEdit;
                                          ExcluirComprasVentas : Boolean = False;
                                          ExcluirPredefinidos  : Boolean = False;
                                          InitialState         : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  LibUtils;

procedure ConsultaTiposMovimientoAlmacen( Edit                 : TcxCustomEdit;
                                          ExcluirComprasVentas : Boolean = False;
                                          ExcluirPredefinidos  : Boolean = False;
                                          InitialState         : TQueryGridInitialState = qgsNormal );
begin
     TcxTmaForm.ExcluirComprasVentas := ExcluirComprasVentas;
     TcxTmaForm.ExcluirPredefinidos := ExcluirPredefinidos;
     CreateQueryForm( TcxTmaForm, cxTmaForm, Edit, InitialState );
end;

procedure TcxTmaForm.FormCreate(Sender: TObject);

var  SQLText : String;

begin
     SQLText := Query.SQL.Text;
     If   ExcluirPredefinidos
     then StrAdd( SQLText, ' WHERE Tipo>=20 ' )
     else If   ExcluirComprasVentas
          then StrAdd( SQLText, ' WHERE NOT ( Tipo BETWEEN 10 AND 15 ) ' );

     StrAdd( SQLText, ' ORDER BY Tipo' );

     Query.SQL.Text := SQLText;
end;

end.
