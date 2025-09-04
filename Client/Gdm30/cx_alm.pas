
unit cx_alm;

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
  cxContainer, cxGroupBox, cxNavigator, cxLabel,

  Gim30Fields, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TcxAlmForm = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    QueryCodigo: TWideStringField;
    TableViewCodigo: TcxGridDBColumn;
    TableViewNombre: TcxGridDBColumn;
    QueryNombre: TWideStringField;
    QueryExistencias: TBCDField;
    QueryExistenciasVirtuales: TBCDField;
    TableViewExistencias: TcxGridDBColumn;
    TableViewExistenciasVirtuales: TcxGridDBColumn;
    QueryPendienteRecibir: TBCDField;
    QueryPendienteServir: TBCDField;
    TableViewPendienteRecibir: TcxGridDBColumn;
    TableViewPendienteServir: TcxGridDBColumn;
    CaptionPanel: TcxGroupBox;
    cxLabel1: TcxLabel;
    CodigoArticuloPanel: TcxLabel;
    CodigoClaseAPanel: TcxLabel;
    CodigoClaseBPanel: TcxLabel;
    CodigoClaseCPanel: TcxLabel;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelSQLSetup;
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
  private
    FObtenerStock : Boolean;
    procedure UpdateParams;
  protected
  class var
    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC    : String;
  public
  end;

var  cxAlmForm : TcxAlmForm = nil;

procedure ConsultaAlmacenes( Edit            : TcxCustomEdit;
                             InitialState : TQueryGridInitialState = qgsNormal;
                             CodigoArticulo  : String = '';
                             CodigoClaseA    : String = '';
                             CodigoClaseB    : String = '';
                             CodigoClaseC    : String = '' );

implementation

uses   Gdm00Dm,

       dmi_sto,

       dm_art,
       dm_cls,
       dm_sto;

{$R *.dfm}


procedure ConsultaAlmacenes( Edit            : TcxCustomEdit;
                             InitialState    : TQueryGridInitialState = qgsNormal;
                             CodigoArticulo  : String = '';
                             CodigoClaseA    : String = '';
                             CodigoClaseB    : String = '';
                             CodigoClaseC    : String = '' );
begin
     TcxAlmForm.CodigoArticulo := CodigoArticulo;
     TcxAlmForm.CodigoClaseA := CodigoClaseA;
     TcxAlmForm.CodigoClaseB := CodigoClaseB;
     TcxAlmForm.CodigoClaseC := CodigoClaseC;

     CreateQueryForm( TcxAlmForm, cxAlmForm, Edit, InitialState );
end;

procedure TcxAlmForm.QueryCalcFields(DataSet: TDataSet);

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     If   FObtenerStock
     then begin
          ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                          True,
                                                          CodigoClaseA,
                                                          CodigoClaseB,
                                                          CodigoClaseC,
                                                          True,
                                                          '',
                                                          False,
                                                          QueryCodigo.Value,
                                                          True,
                                                          '',
                                                          False,
                                                          ApplicationContainer.Ejercicio,
                                                          0,
                                                          ApplicationContainer.NroMesFinal );

          If   Assigned( ExistenciasArticulo )
          then With ExistenciasArticulo.SumaExistencias do
                 begin
                 QueryPendienteServir.Value := PendienteServir;
                 QueryPendienteRecibir.Value := PendienteRecibir;
                 QueryExistenciasVirtuales.Value := PendienteRecibir + Saldo - PendienteServir;
                 QueryExistencias.Value := Saldo;
                 end;

          end;

end;

procedure TcxAlmForm.QueryPanelColumVisibilityChanged( Column : TcxGridDBColumn);
begin
     If   ( Column=TableViewPendienteRecibir) or
          ( Column=TableViewPendienteServir ) or
          ( Column=TableViewExistencias ) or
          ( Column=TableViewExistenciasVirtuales )
     then begin
          UpdateParams;
          TableView.DataController.RefreshExternalData;
          end;
end;

procedure TcxAlmForm.UpdateParams;
begin

     // Si no se pasa el código del artículo no se pueden mostrar las columnas de existencias

     If   ( CodigoArticulo='' ) or
          ( CodigoArticulo=ArticuloManual )
     then begin
          TableViewPendienteRecibir.Visible := False;
          TableViewPendienteServir.Visible := False;
          TableViewExistencias.Visible := False;
          TableViewExistenciasVirtuales.Visible := False;
          end
     else FObtenerStock := TableViewPendienteRecibir.Visible or
                           TableViewPendienteServir.Visible or
                           TableViewExistencias.Visible or
                           TableViewExistenciasVirtuales.Visible;

     If   FObtenerStock
     then begin
          CodigoArticuloPanel.Caption := CodigoArticulo;
          CodigoClaseAPanel.Caption := CodigoClaseA;
          CodigoClaseBPanel.Caption := CodigoClaseB;
          CodigoClaseCPanel.Caption := CodigoClaseC;
          With DataModule00.DmEmpresaFields do
            begin
            CodigoClaseAPanel.Visible := Articulo_ExisteClase[ tcClaseA ].Value;
            CodigoClaseBPanel.Visible := Articulo_ExisteClase[ tcClaseB ].Value;
            CodigoClaseCPanel.Visible := Articulo_ExisteClase[ tcClaseC ].Value;
            end;
          end;

     CaptionPanel.Visible := FObtenerStock;

end;

procedure TcxAlmForm.QueryPanelSQLSetup;
begin
     UpdateParams;
end;

end.
