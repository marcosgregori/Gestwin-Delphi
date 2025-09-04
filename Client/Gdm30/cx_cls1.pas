
unit cx_cls1;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  AppContainer,
  EnterpriseDataAccess,
  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb,

  dm_cls, dxSkinsCore, dxSkinscxPCPainter, DataManager, QueryForm,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  TcxCls1Form = class(TgxForm)
    queryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    QueryDescripcion: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    QueryNroClase: TSmallintField;
    QueryPeso: TBCDField;
    QueryCapacidad: TBCDField;
    QueryTipo: TSmallintField;
    QueryDisponibleTienda: TBooleanField;
    TableViewPeso: TcxGridDBColumn;
    TableViewCapacidad: TcxGridDBColumn;
    TableViewTipo: TcxGridDBColumn;
    TableViewDisponibleTienda: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
  public
    class var NroClase : TNroClase;
  end;

var  cxCls1Form : TcxCls1Form = nil;

procedure ConsultaClases1( NroClase     : TNroClase;
                           Edit         : TcxCustomEdit;
                           InitialState : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses  Gdm00Dm;

procedure ConsultaClases1( NroClase     : TNroClase;
                           Edit         : TcxCustomEdit;
                           InitialState : TQueryGridInitialState = qgsNormal );
begin
     TcxCls1Form.NroClase := NroClase;
     CreateQueryForm( TcxCls1Form, cxCls1Form, Edit, InitialState );
end;

procedure TcxCls1Form.FormCreate(Sender: TObject);
begin
     Caption := Caption + Clase.NombreClase( NroClase, True, False );

     If   ( DataModule00.Envases and
          ( DataModule00.DmEmpresaFields.Articulo_Envase.Value=NroClase ) or ( DataModule00.DmEmpresaFields.Articulo_Contenedor.Value=NroClase ) )
     then begin
          TableViewPeso.VisibleForCustomization := True;
          TableViewCapacidad.VisibleForCustomization := True;
          TableViewTipo.VisibleForCustomization := True;
          end;

     If   DataModule00.TiendaVirtual
     then TableViewDisponibleTienda.VisibleForCustomization := True;

     Query.Params[ 0 ].Value := NroClase;
end;

end.
