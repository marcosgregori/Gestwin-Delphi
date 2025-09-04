
unit cx_nds;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppManager,
  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, DataManager, sqlset, dxSkinsCore,
  dxSkinscxPCPainter, cxLookAndFeels, cxLookAndFeelPainters, QueryForm,
  cxContainer, dxSkinsDefaultPainters, cxGroupBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TCxNdsForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QueryEjercicio: TSmallintField;
    QueryNroOperacion: TIntegerField;
    QueryFecha: TDateField;
    QueryNumeroSerie: TWideStringField;
    QuerySerie: TWideStringField;
    QueryNroDocumento: TIntegerField;
    cxGridDBTableViewFecha: TcxGridDBColumn;
    cxGridDBTableViewNumeroSerie: TcxGridDBColumn;
    cxGridDBTableViewSerie: TcxGridDBColumn;
    cxGridDBTableViewNroDocumento: TcxGridDBColumn;
    cxGridDBTableViewNroOperacion: TcxGridDBColumn;
    QueryUIDArticulo: TGuidField;
    SQLSet: TgxSQLSet;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    CodigoArticulo : String;
    OnUserSelection : TDataEditEvent;
  end;

var  CxNdsForm : TCxNdsForm = nil;

procedure ConsultaNumerosSerie( Edit           : TcxCustomEdit;
                                CodigoArticulo : String;
                                UserSelection  : TDataEditEvent );

implementation

{$R *.dfm}

uses  LibUtils;

procedure ConsultaNumerosSerie( Edit           : TcxCustomEdit;
                                CodigoArticulo : String;
                                UserSelection  : TDataEditEvent );
begin
     TCxNdsForm.CodigoArticulo := CodigoArticulo;
     TCxNdsForm.OnUserSelection := UserSelection;
     CreateQueryForm( TCxNdsForm, CxNdsForm, Edit );
end;

procedure TCxNdsForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       If   ShiftKey
       then SQL.Text := SQLSet.GetSQLText( 'Todos' )
       else SQL.Text := SQLSet.GetSQLText( 'Existencias' );
       Params[ 0 ].Value := CodigoArticulo;
       end;
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
