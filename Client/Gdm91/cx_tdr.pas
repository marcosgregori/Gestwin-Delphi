
unit cx_tdr;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinscxPCPainter, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations;

type
  TCxTdrForm = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryNroRegistro: TIntegerField;
    QueryAplicacion: TSmallintField;
    QueryCodigoGestion: TWideStringField;
    QueryNombre: TWideStringField;
    QueryDomicilio: TWideStringField;
    QueryLocalidad: TWideStringField;
    QueryTextoAplicacion: TWideStringField;
    TableViewNroRegistro: TcxGridDBColumn;
    TableViewTextoAplicacion: TcxGridDBColumn;
    TableViewCodigoGestion: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    TableViewDomicilio: TcxGridDBColumn;
    TableViewLocalidad: TcxGridDBColumn;
    procedure QueryCalcFields(DataSet: TDataSet);
  private
  public
  end;

var  CxTdrForm : TCxTdrForm = nil;

procedure ConsultaTarjetasRegistro( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  EnterpriseDataAccess;

procedure ConsultaTarjetasRegistro( Edit   : TcxCustomEdit;
                                    InitialState : TQueryGridInitialState = qgsNormal );
begin
     CreateQueryForm( TcxTdrForm, CxTdrForm, Edit, InitialState );
end;

procedure TCxTdrForm.QueryCalcFields(DataSet: TDataSet);

const TextoAplicacion : array[ 0..6 ] of string = ( '<Reservado>',
                                                    'Gestión contable',
                                                    'Terminal punto de venta (TPV)',
                                                    'Gestión contable, financiera y comercial',
                                                    'Aprovisionamiento y carga',
                                                    'Gestión financiera y comercial',
                                                    'Preventa' );

begin
     If   QueryAplicacion.Value in [ 0..6 ]
     then QueryTextoAplicacion.Value := TextoAplicacion[ QueryAplicacion.Value ];
end;

end.
