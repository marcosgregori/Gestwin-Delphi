
unit cx_cls2;

interface

uses Forms, AppForms, Classes, Controls, Grids,

  DB,
  Buttons,
  StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, nxdb,

  dxSkinsCore, dxSkinscxPCPainter, DataManager, cxCurrencyEdit,
  cxLookAndFeels, cxLookAndFeelPainters, QueryForm, cxContainer,
  dxSkinsDefaultPainters, cxGroupBox, cxNavigator,

  AppContainer,

  dm_cls, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TCxCls2Form = class(TgxForm)
    QueryPanel: TgQueryPanel;
    Query: TnxeQuery;
    DataSource: TDataSource;
    Grid: TcxGrid;
    TableView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    TableViewClase: TcxGridDBColumn;
    TableViewDescripcion: TcxGridDBColumn;
    TableViewExistencias: TcxGridDBColumn;
    QueryCodigoArticulo: TWideStringField;
    QueryCodigoClase: TWideStringField;
    QueryDescripcion: TWideStringField;
    QueryExistencias: TBCDField;
    QueryExistenciasEnvases: TBCDField;
    TableViewExistenciasEnvases: TcxGridDBColumn;
    QueryPendienteRecibir: TBCDField;
    QueryPendienteServir: TBCDField;
    QueryExistenciasVirtuales: TBCDField;
    TableViewCodigoArticulo: TcxGridDBColumn;
    TableViewPendienteRecibir: TcxGridDBColumn;
    TableViewPendienteServir: TcxGridDBColumn;
    TableViewExistenciasVirtuales: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
    procedure QueryPanelSQLSetup;
  private

    FObtenerStock,
    FMostrarExistenciasEnvases : Boolean;

    TipoRecipiente: TTipoRecipiente;  // 0 = Envase y 1 = Contenedor

    procedure UpdateParams;

  public
    class var
    NroClase : TNroClase;
    CodigoArticulo  :String;
    CodigoClaseA  :String;
    CodigoClaseB :String;
    CodigoClaseC :String;
    Propietario :String;

  end;

var  CxCls2Form : TCxCls2Form = nil;

procedure ConsultaClases2( NroClase        : TNroClase;
                           CodigoArticulo,
                           CodigoClaseA,
                           CodigoClaseB,
                           CodigoClaseC,
                           Propietario     : String;
                           Edit            : TcxCustomEdit;
                           InitialState    : TQueryGridInitialState = qgsNormal );

implementation

{$R *.dfm}

uses Math,
     DateUtils,
     SysUtils,
     LibUtils,
     EnterpriseDataAccess,

     Gdm00Dm,

     dmi_sto,

     dm_art,
     dm_sto;

procedure ConsultaClases2( NroClase        : TNroClase;
                           CodigoArticulo,
                           CodigoClaseA,
                           CodigoClaseB,
                           CodigoClaseC,
                           Propietario     : String;
                           Edit            : TcxCustomEdit;
                           InitialState    : TQueryGridInitialState = qgsNormal );
begin
     TCxCls2Form.NroClase := NroClase;
     TCxCls2Form.CodigoArticulo := CodigoArticulo;
     TCxCls2Form.CodigoClaseA := CodigoClaseA;
     TCxCls2Form.CodigoClaseB := CodigoClaseB;
     TCxCls2Form.CodigoClaseC := CodigoClaseC;
     TCxCls2Form.Propietario := Propietario;
     CreateQueryForm( TCxCls2Form, CxCls2Form, Edit, InitialState );
end;

procedure TCxCls2Form.FormCreate(Sender: TObject);
begin

     {
     FMostrarExistenciasEnvases := True;

     With DataModule00.DmEmpresaFields do
       If   ( Articulo_Envase.Value=NroClase ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
       then TipoRecipiente := trpEnvase
       else If   ( Articulo_Contenedor.Value=NroClase ) and ( Articulo_TipoContenedor.Value=tenReutilizable )
            then TipoRecipiente := trpContenedor
            else FMostrarExistenciasEnvases := False;

     Caption := Caption + Clase.NombreClase( NroClase, True, False );
     If   FMostrarExistenciasEnvases and ( Propietario<>'' )
     then Caption := Caption + ' del cliente ' + Propietario
     else begin
          TableViewCodigoArticulo.Visible := False;
          If   CodigoArticulo<>ArticuloManual
          then Caption := Caption + ' del artículo ' + CodigoArticulo;
          end;
     Clase.SetupGridColumn( TableViewClase, NroClase, 4 );
     With DataModule00.DmEmpresaFields do
       SetColumnsDecimals( [ TableViewExistencias, TableViewExistenciasEnvases ], Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );
     }

end;

procedure TCxCls2Form.QueryCalcFields(DataSet: TDataSet);

var  RegCodigoClaseA,
     RegCodigoClaseB,
     RegCodigoClaseC : String;
     ExistenciasArticulo : IExistenciasArticulo;

begin
     If   FObtenerStock and ( CodigoArticulo<>ArticuloManual )
     then begin

          If   NroClase=tcClaseA
          then RegCodigoClaseA := QueryCodigoClase.Value
          else RegCodigoClaseA := CodigoClaseA;

          If   NroClase=tcClaseB
          then RegCodigoClaseB := QueryCodigoClase.Value
          else RegCodigoClaseB := CodigoClaseB;

          If   NroClase=tcClaseC
          then RegCodigoClaseC := QueryCodigoClase.Value
          else RegCodigoClaseC := CodigoClaseC;

          ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo,
                                                          True,
                                                          RegCodigoClaseA,
                                                          RegCodigoClaseB,
                                                          RegCodigoClaseC,
                                                          True,
                                                          '',
                                                          True,
                                                          '',
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

     If   TableViewExistenciasEnvases.Visible and StockAlmacen.OnObtenExistenciasRecipiente.CanInvoke
     then QueryExistenciasEnvases.Value := StockAlmacen.OnObtenExistenciasRecipiente.Invoke( Propietario, TipoRecipiente, QueryCodigoClase.Value );

end;

procedure TCxCls2Form.QueryPanelColumVisibilityChanged(Column: TcxGridDBColumn);
begin
     If   Query.Active and
          ( Column=TableViewPendienteRecibir) or
          ( Column=TableViewPendienteServir ) or
          ( Column=TableViewExistencias ) or
          ( Column=TableViewExistenciasVirtuales ) or
          ( Column=TableViewExistenciasEnvases )
     then begin
          UpdateParams;
          TableView.DataController.RefreshExternalData;
          end;
end;

procedure TCxCls2Form.UpdateParams;
begin

     TableViewExistenciasEnvases.VisibleForCustomization := FMostrarExistenciasEnvases;
     If   not FMostrarExistenciasEnvases
     then TableViewExistenciasEnvases.Visible := False;

     FObtenerStock := TableViewPendienteRecibir.Visible or
                      TableViewPendienteServir.Visible or
                      TableViewExistencias.Visible or
                      TableViewExistenciasEnvases.Visible or
                      TableViewExistenciasVirtuales.Visible;
end;

procedure TCxCls2Form.QueryPanelSQLSetup;

var  TextoCodigoClase,
     SelectCommand,
     OrderByCommand,
     WhereArticulo,
     WhereClases : String;

begin

     // He trasladado la configuración de las columnas desde Create porque los cambios se pierden con la configuración del usuario

     FMostrarExistenciasEnvases := True;

     With DataModule00.DmEmpresaFields do
       If   ( Articulo_Envase.Value=NroClase ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
       then TipoRecipiente := trpEnvase
       else If   ( Articulo_Contenedor.Value=NroClase ) and ( Articulo_TipoContenedor.Value=tenReutilizable )
            then TipoRecipiente := trpContenedor
            else FMostrarExistenciasEnvases := False;

     Caption := Caption + Clase.NombreClase( NroClase, True, False );
     If   FMostrarExistenciasEnvases and ( Propietario<>'' )
     then Caption := Caption + ' del cliente ' + Propietario
     else begin
          TableViewCodigoArticulo.Visible := False;
          If   CodigoArticulo<>ArticuloManual
          then Caption := Caption + ' del artículo ' + CodigoArticulo;
          end;
     Clase.SetupGridColumn( TableViewClase, NroClase, 4 );
     With DataModule00.DmEmpresaFields do
       SetColumnsDecimals( [ TableViewExistencias, TableViewExistenciasEnvases ], Max( Compras_DecCantidad.Value, Ventas_DecCantidad.Value ) );

     With Query.SQL do
       begin

       Clear;

       TextoCodigoClase := 'CodigoClase' + AnsiChar( 64 + Ord( NroClase ) );

       QueryCodigoClase.Origin := TextoCodigoClase;

       If   CodigoArticulo=ArticuloManual
       then begin
            SelectCommand := ' DISTINCT TOP 1 ' + TextoCodigoClase + ' AS CodigoClase, Clase.Descripcion, CodigoArticulo ';   // Incluyo el código porque existe el campo en el dataset
            WhereArticulo := '';
            OrderByCommand := 'CodigoClase';
            end
       else begin
            SelectCommand := ' DISTINCT CodigoArticulo, ' + TextoCodigoClase + ' AS CodigoClase, Clase.Descripcion ';
            WhereArticulo := ' CodigoArticulo=' + QuotedStr( CodigoArticulo );
            OrderByCommand := 'CodigoArticulo, CodigoClase';
            end;

       Add( 'SELECT ' + SelectCommand  +
            'FROM Stock LEFT JOIN Clase ON ( Stock.' + TextoCodigoClase + '=Clase.Codigo AND NroClase=' + IntToStr( NroClase ) + ') ' +
            'WHERE ' + WhereArticulo );

       {
       If   WhereArticulo=''
       then WhereClases := ''
       else WhereClases := ' AND ';

       If   NroClase=1
       then StrAdd( WhereClases, ' CodigoClaseA<>'''' AND CodigoClaseA IS NOT NULL ' );
       }

       If   NroClase>1
       then begin
            If   ( WhereArticulo<>'' ) and ( WhereClases='' )
            then StrAdd( WhereClases, ' AND ' );
            StrAdd( WhereClases,' CodigoClaseA=' + QuotedStr( CodigoClaseA ) ); // + ' AND CodigoClaseB<>'''' AND CodigoClaseB IS NOT NULL ' );
            end;

       If   NroClase>2
       then StrAdd( WhereClases, ' AND CodigoClaseB=' + QuotedStr( CodigoClaseB ) ); //  + ' AND CodigoClaseC<>'''' AND CodigoClaseC IS NOT NULL ' );

       Add( WhereClases );

       Add( ' AND Ejercicio BETWEEN ' + IntToStr( ApplicationContainer.Ejercicio - 1 ) + ' AND ' + IntToStr( ApplicationContainer.Ejercicio ) );
       Add( ' ORDER BY ' + OrderByCommand );

       end;

     UpdateParams;
end;

end.


