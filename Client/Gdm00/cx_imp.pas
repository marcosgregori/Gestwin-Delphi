
unit cx_imp;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  DataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb, QueryForm,

  dm_ine, dxSkinsCore, dxSkinscxPCPainter, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, dxSkinsDefaultPainters, cxGroupBox,
  DataManager, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TCxImpForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    dataSource: TDataSource;
    Grid: TcxGrid;
    GridDBTableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryTipoDocumento: TSmallintField;
    QueryNroRegistro: TSmallintField;
    QueryDescripcion: TWideStringField;
    QueryFichero: TWideStringField;
    QueryImpresora: TWideStringField;
    QueryPagina: TWideStringField;
    GridDBTableViewNroRegistro: TcxGridDBColumn;
    GridDBTableViewDescripcion: TcxGridDBColumn;
    GridDBTableViewImpresora: TcxGridDBColumn;
    GridDBTableViewPagina: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  protected
     class var
     ModeloImpreso : TModeloImpreso;
  end;

var  CxImpForm : TCxImpForm = nil;

procedure ConsultaImpresos( ModeloImpreso : TModeloImpreso;
                            Edit          : TcxCustomEdit;
                            InitialState  : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  AppManager;

procedure ConsultaImpresos( ModeloImpreso : TModeloImpreso;
                            Edit          : TcxCustomEdit;
                            InitialState  : TQueryGridInitialState = qgsNormal );
begin
     TCxImpForm.ModeloImpreso := ModeloImpreso;
     createQueryForm( TCxImpForm, CxImpForm, Edit, InitialState );
end;

procedure TCxImpForm.FormCreate(Sender: TObject);
begin
     With Query do
       begin
       Params[ 0 ].Value := ModeloImpreso;
       Params[ 1 ].Value := ApplicationContainer.CurrentSection.SetupSection;
       Params[ 2 ].Value := CodigoEmpresaActual;
       end;
end;

end.
