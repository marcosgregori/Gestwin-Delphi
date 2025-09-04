
unit cx_plg;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, Menus, QueryForm,

  dm_plg, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinscxPCPainter, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  DataManager, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxPlgForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroOperacion: TIntegerField;
    QueryDescripcion: TWideStringField;
    TableViewNroOperacion: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryTipo: TSmallintField;
    QueryNroRegistro: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  protected
    class var
    Tipo : TTipoPlantillaGrafico;
  end;

var  CxPlgForm : TCxPlgForm = nil;

procedure ConsultaPlantillasGrafico( Edit   : TcxCustomEdit;
                                     Tipo   : TTipoPlantillaGrafico;
                                     InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

procedure ConsultaPlantillasGrafico( Edit   : TcxCustomEdit;
                                     Tipo   : TTipoPlantillaGrafico;
                                     InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxPlgForm.Tipo := Tipo;
     CreateQueryForm( TCxPlgForm, CxPlgForm, Edit, InitialState );
end;

procedure TCxPlgForm.FormCreate(Sender: TObject);
begin
     Query.Params[ 0 ].Value := Tipo;
end;

end.
