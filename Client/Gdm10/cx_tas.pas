
unit cx_tas;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
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
  TcxTasForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroRegistro: TSmallintField;
    QueryDescripcion: TWideStringField;
    TableViewNroRegistro: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  class var ExcluirPredefinidos : Boolean;
  public
  end;

var  cxTasForm : TcxTasForm = nil;

procedure ConsultaTiposAsiento( Edit                : TcxCustomEdit;
                                ExcluirPredefinidos : Boolean = False;
                                InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  LibUtils;

procedure ConsultaTiposAsiento( Edit                : TcxCustomEdit;
                                ExcluirPredefinidos : Boolean = False;
                                InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxTasForm.ExcluirPredefinidos := ExcluirPredefinidos;
     CreateQueryForm( TcxTasForm, cxTasForm, Edit, InitialState );
end;

procedure TcxTasForm.FormCreate(Sender: TObject);

var   SQLText : String;

begin
     SQlText := Query.SQL.Text;
     If   ExcluirPredefinidos
     then StrAdd( SQLText, ' WHERE NroRegistro>20 ' );
     StrAdd( SQLText, ' ORDER BY NroRegistro' );
     Query.SQL.Text := SQLText;
end;

end.
