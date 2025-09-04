
unit cx_lmp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, DataManager,
  dxDateRanges, dxScrollbarAnnotations;

type
  TCxLmpForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewCodigoClaseA: TcxGridDBColumn;
    TableViewCodigoClaseB: TcxGridDBColumn;
    TableViewCodigoClaseC: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClaseA: TWideStringField;
    QueryCodigoClaseB: TWideStringField;
    QueryCodigoClaseC: TWideStringField;
    QueryArticulo_Descripcion: TWideStringField;
    QueryProceso: TSmallintField;
    QueryCodigoOperacion: TWideStringField;
    QueryOperacion_Descripcion: TWideStringField;
    TableViewProceso: TcxGridDBColumn;
    TableViewCodigoOperacion: TcxGridDBColumn;
    TableViewOperacion_Descripcion: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
  class var
    OnUserSelection : TDataEditEvent;
  public
  end;

var  CxLmpForm : TCxLmpForm = nil;

procedure ConsultaRelacionMateriales( Edit          : TcxCustomEdit;
                                      InitialState  : TQueryGridInitialState = qgsNormal;
                                      UserSelection : TDataEditEvent = nil );

implementation

{$R *.dfm}

uses  dm_clp;

procedure ConsultaRelacionMateriales( Edit          : TcxCustomEdit;
                                      InitialState  : TQueryGridInitialState = qgsNormal;
                                      UserSelection : TDataEditEvent = nil );
begin
     TCxLmpForm.OnUserSelection := UserSelection;
     CreateQueryForm( TcxLmpForm, CxLmpForm, Edit, InitialState );
end;

procedure TCxLmpForm.FormCreate(Sender: TObject);
begin
     ClaseProduccion.SetupGridColumns( TableViewCodigoClaseA, TableViewCodigoClaseB, TableViewCodigoClaseC, 4 );
     QueryPanel.OnDataSelected := OnUserSelection;
end;

end.
