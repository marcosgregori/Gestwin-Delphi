
unit cx_orp;

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
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TCxOrpForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryNombre: TWideStringField;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    QueryCodigo: TWideStringField;
    QueryTipo: TSmallintField;
    procedure FormCreate(Sender: TObject);
  private
  protected
  class var Tipo : SmallInt;
  public
  end;

var  CxOrpForm : TCxOrpForm = nil;

procedure ConsultaOrganismosPublicos( Tipo   : SmallInt;
                                      Edit   : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses   EnterpriseDataAccess,

       dm_orp;

const  DescripcionTipo : Array[ 0..2 ] of String = ( 'oficinas contables', 'órganos gestores', 'unidades tramitadoras' );

procedure ConsultaOrganismosPublicos( Tipo   : SmallInt;
                                      Edit   : TcxCustomEdit;
                                      InitialState : TQueryGridInitialState = qgsNormal );
begin
     TCxOrpForm.Tipo := Tipo;
     CreateQueryForm( TCxOrpForm, CxOrpForm, Edit, InitialState );
end;

procedure TCxOrpForm.FormCreate(Sender: TObject);
begin
      Query.Params[ 0 ].Value := Tipo;
      If   Tipo in [ 0..2 ]
      then Caption := 'Consulta de ' + DescripcionTipo[ Tipo ];
end;

end.
