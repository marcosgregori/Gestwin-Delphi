
unit dm_sto;

interface

uses
  Windows, Messages, SysUtils, Controls, Classes, Graphics, Forms, Dialogs, cxEdit, cxDBEdit,

  LibUtils,
  AppForms,
  DB,
  nxdb,
  cxGridTableView,
  DataManager,
  Spring,

  Gim10Fields,
  Gim30Fields,

  MovimientoIntf,
  LineaMovimientoIntf,

  dmi_mov,
  dmi_sto,

  dm_cls;

type

  TActualizaMovimientoEvent = procedure ( MovimientoFields      : TMovimientoFields;
                                          LineaMovimientoFields : TLineaMovimientoFields;
                                          Descontar             : Boolean = False;
                                          CantidadOperacion     : Decimal = 0.0 ) of object;

  TObtenExistenciasRecipienteEvent = function( Propietario : String; TipoRecipiente : TTipoRecipiente; CodigoEnvase : String ) : Decimal of object;

  {
  TSumaExistencias = record
    PendienteRecibir,
    PendienteServir : Decimal;
    MovimientoMes : array[ 0..12, 0..1 ] of Decimal;
    Entradas,
    Salidas,
    Saldo : Decimal;
    end;

  TDatosArticulo = record
    CodigoArticulo,
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC,
    LoteFabricacion,
    CodigoAlmacen,
    CodigoUbicacion : String;

    FechaUltCompra,
    FechaUltVenta,
    FechaUltEntrada,
    FechaUltEntradaCoste,
    FechaUltSalida : TDateTime;
    UnidadesPrecioVenta : Integer;
    Coste,
    CosteMedio,
    CosteUltEntrada,
    PrecioUltSalida,
    PrecioUltCompra,
    PrecioUltVenta : Decimal;
    SumaExistencias : TSumaExistencias;
    end;
  }

  TStockAlmacenModule = class(TDataModule)
    DmStockTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmSerieFacturacionTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmTarifaComprasTable: TnxeTable;
    DmAlmacenTable: TnxeTable;
    DmConsumoComprasTable: TnxeTable;
    DmConsumoVentasTable: TnxeTable;
    DmTipoMovAlmacenTable: TnxeTable;
    DmArticuloTable: TnxeTable;
    DmTarifaVentasTable: TnxeTable;
    DmExistenciasArticuloTable: TnxeTable;
    procedure StockDataModuleCreate(Sender: TObject);
    procedure StockModuleDestroy(Sender: TObject);

  private

    // FCodigoArticulo : String;
    FCodigoClaseAInicial,
    FCodigoClaseAFinal,
    FCodigoClaseBInicial,
    FCodigoClaseBFinal,
    FCodigoClaseCInicial,
    FCodigoClaseCFinal,
    FLoteFabricacionInicial,
    FLoteFabricacionFinal,
    FCodigoAlmacenInicial,
    FCodigoAlmacenFinal,
    FCodigoUbicacionInicial,
    FCodigoUbicacionFinal : String;
    FTodosLosLotes,
    FTodosLosAlmacenes,
    FTodasLasUbicaciones : Boolean;

    FEjercicio,
    FMesInicial,
    FMesFinal : SmallInt;
    FObtenCoste : Boolean;

    NroMes : SmallInt;

    CodigoAlmacenSeleccionado : String;
    CodigoUbicacionSeleccionado : String;
    CodigoLoteSeleccionado : String;
    Existencias,
    CantidadMinimaActual,
    ExistenciasValidasAlmacen    : Decimal;

    FOnObtenExistenciasRecipiente : Event<TObtenExistenciasRecipienteEvent>;

    StockAlmacenService : IStockAlmacenService;
    
    procedure FijaRango( Todos : Boolean; Valor : String; var ValorInicial : String; var ValorFinal : String );
    function RangoValido( Valor, ValorInicial, ValorFinal : String ) : Boolean;

  public

    DmArticuloFields : TArticuloFields;
    DmStockFields : TStockFields;
    DmTipoMovAlmacenFields : TTipoMovAlmacenFields;
    DmMovimientoFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmSerieFacturacionFields : TSerieFacturacionFields;
    DmTarifaComprasFields : TTarifaComprasFields;
    DmTarifaVentasFields : TTarifaVentasFields;
    DmExistenciasArticuloFields : TExistenciasArticuloFields;
    DmAlmacenFields : TAlmacenFields;
    DmConsumoComprasFields : TConsumoComprasFields;
    DmConsumoVentasFields : TConsumoVentasFields;

    DmStockAnteriorFields : TStockFields;  // Un registro persistente

    procedure AcumulaExistencias( DmStockFields   : TStockFields;
                                  SumaExistencias : IExistencias;
                                  MesInicial,
                                  MesFinal        : SmallInt );

    function ObtenStock( CodigoArticulo      : String;
                         TodasLasClases      : Boolean;
                         CodigoClaseA,
                         CodigoClaseB,
                         CodigoClaseC        : String;
                         TodosLosLotes       : Boolean;
                         LoteFabricacion     : String;
                         TodosLosAlmacenes   : Boolean;
                         CodigoAlmacen       : String;
                         TodasLasUbicaciones : Boolean;
                         CodigoUbicacion     : String;
                         ObtenCoste          : Boolean;
                         Ejercicio           : SmallInt;
                         MesInicial,
                         MesFinal            : Byte ) : IExistenciasArticulo;

    function ObtenStockReports( CodigoArticulo      : String;
                                TodasLasClases      : Boolean;
                                CodigoClaseA,
                                CodigoClaseB,
                                CodigoClaseC        : String;
                                TodosLosLotes       : Boolean;
                                LoteFabricacion     : String;
                                TodosLosAlmacenes   : Boolean;
                                CodigoAlmacen       : String;
                                TodasLasUbicaciones : Boolean;
                                CodigoUbicacion     : String;
                                ObtenCoste          : Boolean;
                                Ejercicio           : Integer;
                                MesInicial,
                                MesFinal            : Byte ) : Decimal;

    function ObtenStockFecha( CodigoArticulo      : String;
                              TodasLasClases      : Boolean;
                              CodigoClaseA,
                              CodigoClaseB,
                              CodigoClaseC        : String;
                              TodosLosLotes       : Boolean;
                              LoteFabricacion     : String;
                              TodosLosAlmacenes   : Boolean;
                              CodigoAlmacen       : String;
                              TodasLasUbicaciones : Boolean;
                              CodigoUbicacion     : String;
                              FechaStock          : TDateTime;
                              NroOperacion        : LongInt;
                              NroPagina,
                              NroLinea            : SmallInt   ) : IExistenciasArticulo;

    procedure ActualizaStock( MovimientoFields      : TMovimientoFields;
                              LineaMovimientoFields : TLineaMovimientoFields;
                              Descontar             : Boolean = False;
                              CantidadOperacion     : Decimal  = 0.0 ); overload;

    function AsignaAlmacenYLoteSalida(     CodigoArticulo    : String;
                                           CodigoClaseA,
                                           CodigoClaseB,
                                           CodigoClaseC      : String;
                                       var Cantidad          : Decimal;
                                       var LoteFabricacion   : String;
                                       var CodigoAlmacen     : String;
                                       var CodigoUbicacion   : String ) : Boolean;

    {
    procedure ActualizaConsumoCompras( TipoConsumo          : Integer;
                                       CodigoProveedor      : String;
                                       CodigoArticulo       : String;
                                       CodigoClaseA,
                                       CodigoClaseB,
                                       CodigoClaseC         : String;
                                       Fecha                : TDateTime;
                                       Unidades,
                                       Importe              : Decimal );

    procedure ActualizaConsumoVentas( TipoConsumo         : Integer;
                                      CodigoCliente       : String;
                                      CodigoArticulo      : String;
                                      CodigoClaseA,
                                      CodigoClaseB,
                                      CodigoClaseC        : String;
                                      Fecha               : TDateTime;
                                      Unidades,
                                      Importe             : Decimal );
    }

    function ObtenCostePeriodo ( CodigoArticulo      : String;
                                 CodigoClaseA,
                                 CodigoClaseB,
                                 CodigoClaseC        : String;
                                 TodosLosLotes       : Boolean;
                                 LoteFabricacion     : String;
                                 TodosLosAlmacenes   : Boolean;
                                 CodigoAlmacen       : String;
                                 TodasLasUbicaciones : Boolean;
                                 CodigoUbicacion     : String;
                                 Ejercicio           : Integer;
                                 MesInicial,
                                 MesFinal            : Byte ) : Decimal;

    function ObtenCosteFecha( CodigoArticulo      : String;
                              TodasLasClases      : Boolean;
                              CodigoClaseA,
                              CodigoClaseB,
                              CodigoClaseC        : String;
                              TodosLosLotes       : Boolean;
                              LoteFabricacion     : String;
                              TodosLosAlmacenes   : Boolean;
                              CodigoAlmacen       : String;
                              TodasLasUbicaciones : Boolean;
                              CodigoUbicacion     : String;
                              Fecha               : TDate ) : Decimal;

    function ListadoExistencias( TodosLosAlmacenes  : Boolean;
                                 CodigoAlmacenUnico : String;
                                 MesInicial,
                                 MesFinal           : SmallInt;
                                 Seleccion          : SmallInt;  // 0 = Articulo, 1 = Familia
                                 CodigoInicial,
                                 CodigoFinal        : String;
                                 ArticulosAIncluir  : SmallInt;
                                 TipoMovimiento     : SmallInt;
                                 Valorar            : Boolean;
                                 PrecioValoracion   : SmallInt;
                                 DesglosarLotes     : Boolean ) : String;

    procedure CompruebaSalida(     DisplayValue           : Variant;
                                   GridViewCantidad       : TcxGridColumn;
                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                   ArticuloFields         : TArticuloFields;
                                   SerieFacturacionFields : TSerieFacturacionFields;
                                   ExistenciasArticulo    : IExistenciasArticulo;
                                   CodigoTarifa           : String;
                               var ErrorText              : TCaption;
                               var Error                  : Boolean );

    function StockEnvases( Propietario    : String;
                           TipoRecipiente : TTipoRecipiente;
                           CodigoEnvase   : String ) : Decimal;

    property OnObtenExistenciasRecipiente : Event<TObtenExistenciasRecipienteEvent> read FOnObtenExistenciasRecipiente write FOnObtenExistenciasRecipiente;
   
  end;

var StockAlmacenModule: TStockAlmacenModule = nil;

function StockAlmacen : TStockAlmacenModule;

const tcFamilia   = 1;   // tipos de registro de consumo
      tcArticulo  = 2;

resourcestring
      RsMsg1    = 'La cabecera de la operación nº %d no existe.';
      RsMsg2    = 'Regenere sus ficheros. Si así no consigue solucionar el problema, avise a su soporte técnico.';
      RsMsg3    = 'No hay existencias suficientes.';
      RsMsg4    = 'En este momento hay %.*f unidades en almacén del artículo %s.';
      RsMsg5    = 'Las existencias de este artículo quedarán bajo mínimos.';
      RsMsg6    = 'En el almacén quedarán %.*f unidades y el stock mínimo es de %.*f unidades.';
      RsMsg7    = 'Cantidad insuficiente.';
      RsMsg8    = 'La tarifa de este cliente no permite salidas de este artículo por debajo de %.*f unidades.';
      RsMsg9    = 'Las condiciones de este artículo no permiten salidas por debajo de %.*f unidades.';
      
      srTodos   = '<Todos>';

implementation

{$R *.DFM}

uses  Variants,
      ProcID,

      nxdbBase,
      nxllBde,
      cxCurrencyEdit,
      DateUtils,
      AppManager,
      AppContainer,
      EnterpriseDataAccess,
      NexusRpcData,
      frxNXRTTI,

      Gdm00Dm,
      Gim00Fields,

      dm_mov,
      dm_art,
      dm_tma,

      b_msg;

function StockAlmacen : TStockAlmacenModule;
begin
     CreateDataModule( TStockAlmacenModule, StockAlmacenModule );
     Result := StockAlmacenModule;
end;

procedure TStockAlmacenModule.FijaRango(     Todos        : Boolean;
                                             Valor        : String;
                                         var ValorInicial : String;
                                         var ValorFinal   : String );
begin
     If   Todos
     then begin
          ValorInicial := '';
          ValorFinal := HighStrCode;
          end
     else begin
          ValorInicial := Valor;
          ValorFinal := Valor;
          end;
end;

function TStockAlmacenModule.RangoValido( Valor, ValorInicial, ValorFinal : String ) : Boolean;
begin
     Result := ( Valor>=ValorInicial ) and ( Valor<=ValorFinal );
end;

function TStockAlmacenModule.ObtenStock( CodigoArticulo      : String;
                                         TodasLasClases      : Boolean;
                                         CodigoClaseA,
                                         CodigoClaseB,
                                         CodigoClaseC        : String;
                                         TodosLosLotes       : Boolean;
                                         LoteFabricacion     : String;
                                         TodosLosAlmacenes   : Boolean;
                                         CodigoAlmacen       : String;
                                         TodasLasUbicaciones : Boolean;
                                         CodigoUbicacion     : String;
                                         ObtenCoste          : Boolean;
                                         Ejercicio           : SmallInt;
                                         MesInicial,
                                         MesFinal            : Byte ) : IExistenciasArticulo;
begin
     Result := StockAlmacenService.ObtenStock( CodigoArticulo,
                                               TodasLasClases,
                                               CodigoClaseA,
                                               CodigoClaseB,
                                               CodigoClaseC,
                                               TodosLosLotes,
                                               LoteFabricacion,
                                               TodosLosAlmacenes,
                                               CodigoAlmacen,
                                               TodasLasUbicaciones,
                                               CodigoUbicacion,
                                               ObtenCoste,
                                               Ejercicio,
                                               MesInicial,
                                               MesFinal );
end;

function TStockAlmacenModule.ObtenStockReports( CodigoArticulo      : String;
                                                TodasLasClases      : Boolean;
                                                CodigoClaseA,
                                                CodigoClaseB,
                                                CodigoClaseC        : String;
                                                TodosLosLotes       : Boolean;
                                                LoteFabricacion     : String;
                                                TodosLosAlmacenes   : Boolean;
                                                CodigoAlmacen       : String;
                                                TodasLasUbicaciones : Boolean;
                                                CodigoUbicacion     : String;
                                                ObtenCoste          : Boolean;
                                                Ejercicio           : Integer;
                                                MesInicial,
                                                MesFinal            : Byte ) : Decimal;

var  ExistenciasArticulo : IExistenciasArticulo;

begin
     Result := 0.0;
     ExistenciasArticulo := StockAlmacenService.ObtenStock( CodigoArticulo,
                                                            TodasLasClases,
                                                            CodigoClaseA,
                                                            CodigoClaseB,
                                                            CodigoClaseC,
                                                            TodosLosLotes,
                                                            LoteFabricacion,
                                                            TodosLosAlmacenes,
                                                            CodigoAlmacen,
                                                            TodasLasUbicaciones,
                                                            CodigoUbicacion,
                                                            ObtenCoste,
                                                            Ejercicio,
                                                            MesInicial,
                                                            MesFinal );
     If   Assigned( ExistenciasArticulo )
     then Result := ExistenciasArticulo.SumaExistencias.Saldo;
end;

function TStockAlmacenModule.ObtenStockFecha( CodigoArticulo      : String;
                                              TodasLasClases      : Boolean;
                                              CodigoClaseA,
                                              CodigoClaseB,
                                              CodigoClaseC        : String;
                                              TodosLosLotes       : Boolean;
                                              LoteFabricacion     : String;
                                              TodosLosAlmacenes   : Boolean;
                                              CodigoAlmacen       : String;
                                              TodasLasUbicaciones : Boolean;
                                              CodigoUbicacion     : String;
                                              FechaStock          : TDateTime;
                                              NroOperacion        : LongInt;
                                              NroPagina,
                                              NroLinea            : SmallInt   ) : IExistenciasArticulo;
begin
     Result := StockAlmacenService.ObtenStockFecha( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones,CodigoUbicacion, FechaStock, NroOperacion, NroPagina, NroLinea );
end;

function TStockAlmacenModule.ObtenCostePeriodo ( CodigoArticulo      : String;
                                                 CodigoClaseA,
                                                 CodigoClaseB,
                                                 CodigoClaseC        : String;
                                                 TodosLosLotes       : Boolean;
                                                 LoteFabricacion     : String;
                                                 TodosLosAlmacenes   : Boolean;
                                                 CodigoAlmacen       : String;
                                                 TodasLasUbicaciones : Boolean;
                                                 CodigoUbicacion     : String;
                                                 Ejercicio           : Integer;
                                                 MesInicial,
                                                 MesFinal            : Byte ) : Decimal;
begin
     Result := StockAlmacenService.ObtenCostePeriodo ( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen,TodasLasUbicaciones, CodigoUbicacion, Ejercicio, MesInicial, MesFinal );
end;

function TStockAlmacenModule.ObtenCosteFecha( CodigoArticulo      : String;
                                              TodasLasClases      : Boolean;
                                              CodigoClaseA,
                                              CodigoClaseB,
                                              CodigoClaseC        : String;
                                              TodosLosLotes       : Boolean;
                                              LoteFabricacion     : String;
                                              TodosLosAlmacenes   : Boolean;
                                              CodigoAlmacen       : String;
                                              TodasLasUbicaciones : Boolean;
                                              CodigoUbicacion     : String;
                                              Fecha               : TDate ) : Decimal;
begin
     Result := StockAlmacenService.ObtenCosteFecha( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, Fecha );
end;

function TStockAlmacenModule.ListadoExistencias( TodosLosAlmacenes  : Boolean;
                                                 CodigoAlmacenUnico : String;
                                                 MesInicial,
                                                 MesFinal           : SmallInt;
                                                 Seleccion          : SmallInt;  // 0 = Articulo, 1 = Familia
                                                 CodigoInicial,
                                                 CodigoFinal        : String;
                                                 ArticulosAIncluir  : SmallInt;
                                                 TipoMovimiento     : SmallInt;
                                                 Valorar            : Boolean;
                                                 PrecioValoracion   : SmallInt;
                                                 DesglosarLotes     : Boolean ) : String;
begin
     Result := StockAlmacenService.ListadoExistencias( TodosLosAlmacenes, CodigoAlmacenUnico, MesInicial, MesFinal, Seleccion, CodigoInicial, CodigoFinal, ArticulosAIncluir, TipoMovimiento, Valorar, PrecioValoracion, DesglosarLotes );
end;

procedure TStockAlmacenModule.AcumulaExistencias( DmStockFields   : TStockFields;
                                                  SumaExistencias : IExistencias;
                                                  MesInicial,
                                                  MesFinal        : SmallInt );

procedure AcumulaMes;
begin
     With SumaExistencias do
       begin
       MovimientosEntradaMes[ NroMes ] := MovimientosEntradaMes[ NroMes ] + DmStockFields.MovimientoMes[ NroMes, 0 ].Value;
       MovimientosSalidaMes[ NroMes ] := MovimientosSalidaMes[ NroMes ] + DmStockFields.MovimientoMes[ NroMes, 1 ].Value;
       Entradas := Entradas + DmStockFields.MovimientoMes[ NroMes, 0 ].Value;
       Salidas := Salidas +  DmStockFields.MovimientoMes[ NroMes, 1 ].Value;
       end;
end;

begin
     NroMes := MesInicial;

     If   ( MesFinal>12 ) and ( MesInicial<>MesFinal )
     then MesFinal := ApplicationContainer.NroMesFinal;

     If   MesInicial<MesFinal
     then repeat
            AcumulaMes;
            Inc( NroMes );
            If   ApplicationContainer.NroMesInicial<>1
            then begin
                 If   NroMes=13
                 then NroMes := 1
                 else If   NroMes=1
                      then NroMes := ApplicationContainer.NroMesInicial;
                 end;

          until NroMes=MesFinal;

     AcumulaMes;

     With SumaExistencias do
       begin

       PendienteRecibir := PendienteRecibir + DmStockFields.PendienteRecibir[ 0 ].Value + DmStockFields.PendienteRecibir[ 1 ].Value;
       PendienteServir := PendienteServir + DmStockFields.PendienteServir[ 0 ].Value  + DmStockFields.PendienteServir[ 1 ].Value;

       Saldo := Entradas - Salidas;
       end;
end;

procedure TStockAlmacenModule.StockDataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_StockAlmacenService, IStockAlmacenService, StockAlmacenService );

     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmStockFields := TStockFields.Create( DmStockTable );
     DmTipoMovAlmacenFields := TTipoMovAlmacenFields.Create( DmTipoMovAlmacenTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( DmSerieFacturacionTable );
     DmTarifaComprasFields := TTarifaComprasFields.Create( DmTarifaComprasTable );
     DmTarifaVentasFields := TTarifaVentasFields.Create( DmTarifaVentasTable );
     DmExistenciasArticuloFields := TExistenciasArticuloFields.Create( DmExistenciasArticuloTable );
     DmAlmacenFields := TAlmacenFields.Create( DmAlmacenTable );
     DmConsumoComprasFields := TConsumoComprasFields.Create( DmConsumoComprasTable );
     DmConsumoVentasFields := TConsumoVentasFields.Create( DmConsumoVentasTable );

     DmStockAnteriorFields := TStockFields.Create( DmStockTable, True );

     CostePeriodoEvent := ObtenCostePeriodo;
     CosteFechaEvent := ObtenCosteFecha;
     ExistenciasEvent := ObtenStockReports;

     ExecComponentProcedures( idStockModule, imOnCreateComponent );

end;

procedure TStockAlmacenModule.StockModuleDestroy( Sender: TObject );
begin
     StockAlmacenModule := nil;
     CostePeriodoEvent := nil;
     ExistenciasEvent := nil;
end;

procedure TStockAlmacenModule.ActualizaStock( MovimientoFields       : TMovimientoFields;
                                              LineaMovimientoFields  : TLineaMovimientoFields;
                                              Descontar              : Boolean = False;
                                              CantidadOperacion      : Decimal  = 0.0 );
begin
     StockAlmacenService.ActualizaStock( DmStockTable.GetRemoteCursorID,
                                         DmTarifaComprasTable.GetRemoteCursorID,

                                         MovimientoFields.TipoMovimiento.Value,
                                         MovimientoFields.Serie.Value,
                                         MovimientoFields.Propietario.Value,
                                         TLineaMovimiento.FromDataset( LineaMovimientoFields, False {ReadBlobs} ),  // Las anotaciones no son necesarias
                                         Descontar,
                                         CantidadOperacion );
end;

function TStockAlmacenModule.AsignaAlmacenYLoteSalida(     CodigoArticulo    : String;
                                                           CodigoClaseA,
                                                           CodigoClaseB,
                                                           CodigoClaseC      : String;
                                                       var Cantidad          : Decimal;
                                                       var LoteFabricacion   : String;
                                                       var CodigoAlmacen     : String;
                                                       var CodigoUbicacion   : String ) : Boolean;

var  Existencias : IExistencias;

begin

     Result := False;
     FMesInicial := 0;
     FMesFinal := 12;
     CodigoAlmacenSeleccionado := '';
     CodigoUbicacionSeleccionado := '';
     CodigoLoteSeleccionado := '';
     CantidadMinimaActual := 0.0;

     Existencias := TExistencias.Create;

     With DmStockTable do
       try

         IndexFieldNames := 'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;LoteFabricacion;Ubicacion;CodigoAlmacen';

         SetRange( [ ApplicationContainer.Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, '',         '',         ''         ],
                   [ ApplicationContainer.Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, HighStrCode, HighStrCode, HighStrCode ] );
         First;
         While not Eof do
           begin

           Existencias.Clear;
           AcumulaExistencias( DmStockFields, Existencias, FMesInicial, FMesFinal );

           // Estoy buscando el menor StockAlmacen del lote más viejo ( código de lote menor ).

           If   not ValueIsEmpty( DmStockFields.LoteFabricacion.Value ) and ( Existencias.Saldo>0.0 )
           then If   ( CantidadMinimaActual=0.0 ) or ( Existencias.Saldo<CantidadMinimaActual )
                then begin
                     CodigoAlmacenSeleccionado := DmStockFields.CodigoAlmacen.Value;
                     CodigoUbicacionSeleccionado := DmStockFields.Ubicacion.Value;
                     CodigoLoteSeleccionado := DmStockFields.LoteFabricacion.Value;
                     CantidadMinimaActual := Existencias.Saldo;
                     end;
           Next;
           end;

       finally
         CancelRange;
         end;

     If   CantidadMinimaActual=0.0
     then begin
          LoteFabricacion := '';
          CodigoAlmacen := '';
          CodigoUbicacion := '';
          Cantidad := 0.0;
          end
     else begin
          LoteFabricacion := CodigoLoteSeleccionado;
          CodigoAlmacen := CodigoAlmacenSeleccionado;
          CodigoUbicacion := CodigoUbicacionSeleccionado;
          Cantidad := CantidadMinimaActual;
          Result := True;
          end;
end;

// Para poder utilizar esta función se ha tenido que obtener el StockAlmacen del artículo
// en cuestión con anterioridad

procedure TStockAlmacenModule.CompruebaSalida(     DisplayValue           : Variant;
                                                   GridViewCantidad       : TcxGridColumn;
                                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                                   ArticuloFields         : TArticuloFields;
                                                   SerieFacturacionFields : TSerieFacturacionFields;
                                                   ExistenciasArticulo    : IExistenciasArticulo;
                                                   CodigoTarifa           : String;
                                               var ErrorText              : TCaption;
                                               var Error                  : Boolean );

var  Cantidad,
     CantidadAnterior,
     Existencias,
     RestoExistencias : Decimal;
     Decimales : SmallInt;

begin
     If   not ArticuloFields.NoAfectarStock.Value  and
          SerieFacturacionFields.Afectar_Stock.Value and
          Assigned( ExistenciasArticulo )
     then begin

          Cantidad := VarToDecimal( DisplayValue );
          CantidadAnterior := -VarToDecimal( LineaMovimientoFields.Cantidad.OldValue );        

          If   Cantidad>0.0 
          then begin

               If   GridViewCantidad.Properties is TcxCurrencyEditProperties
               then Decimales := TcxCurrencyEditProperties( GridViewCantidad.Properties ).DecimalPlaces
               else Decimales := DecimalesMoneda;
                    
               If   ( LineaMovimientoFields.CodigoArticulo.Value=LineaMovimientoFields.CodigoArticulo.OldValue ) and
                    ( LineaMovimientoFields.CodigoClaseA.Value=LineaMovimientoFields.CodigoClaseA.OldValue ) and
                    ( LineaMovimientoFields.CodigoClaseB.Value=LineaMovimientoFields.CodigoClaseB.OldValue ) and
                    ( LineaMovimientoFields.CodigoClaseC.Value=LineaMovimientoFields.CodigoClaseC.OldValue ) and
                    ( LineaMovimientoFields.LoteFabricacion.Value=LineaMovimientoFields.LoteFabricacion.OldValue ) and
                    ( LineaMovimientoFields.CodigoAlmacen.Value=LineaMovimientoFields.CodigoAlmacen.OldValue ) and
                    ( LineaMovimientoFields.Ubicacion.Value=LineaMovimientoFields.Ubicacion.OldValue )
               then begin
                    Existencias := ExistenciasArticulo.SumaExistencias.Saldo + CantidadAnterior;
                    RestoExistencias := Existencias - Cantidad;
                    end
               else begin
                    Existencias := ExistenciasArticulo.SumaExistencias.Saldo;
                    RestoExistencias := Existencias;
                    end;

               If   DataModule00.DmEmpresaFields.Stock_AvisoStock.Value and ( Existencias<Cantidad )
               then If   DataModule00.DmEmpresaFields.Stock_ImpSalidasSinStock.Value
                    then begin
                         Error := True;
                         ErrorText := JoinMessage( RsMsg3, Format( RsMsg4, [ Decimales, Existencias, ExistenciasArticulo.CodigoArticulo ] ) );
                         end
                    else ShowHintMsg( RsMsg3, Format( RsMsg4, [ Decimales, Existencias, ExistenciasArticulo.CodigoArticulo ] ), nil, ntInformation );

               If   not Error
               then begin

                    If   DataModule00.DmEmpresaFields.Stock_AvisoBajoMinimos.Value and GridViewCantidad.Editing
                    then begin

                         var StockMinimo := ArticuloFields.Stock_Minimo.Value;

                         // Articulo_StockMinMaxPorAlmacen

                         If   DataModule00.DmEmpresaFields.Articulo_StockMinMaxPorAlmacen.Value
                         then If   DmExistenciasArticuloTable.FindKey( [ ArticuloFields.Codigo.Value, LineaMovimientoFields.CodigoAlmacen.Value ] )
                              then StockMinimo := DmExistenciasArticuloFields.StockMinimo.Value;

                         If   ( StockMinimo<>0.0 ) and ( RestoExistencias<StockMinimo )
                         then ShowHintMsg( RsMsg5, Format( RsMsg6, [ Decimales, RestoExistencias, Decimales, StockMinimo ] ) );

                         end;

                    If   not Error
                    then begin

                         If   DataModule00.DmEmpresaFields.Cliente_TarCantidadMinima.Value
                         then If   DmTarifaVentasTable.FindKey( [ rtvTarifaArticulo, CodigoTarifa, LineaMovimientoFields.CodigoArticulo.Value ] )
                              then If   Cantidad<DmTarifaVentasFields.CantidadMinima.Value
                                   then begin
                                        Error := True;
                                        ErrorText := JoinMessage( RsMsg7, Format( RsMsg8, [ Decimales, DmTarifaVentasFields.CantidadMinima.Value ] ) );
                                        end;

                         If   not Error
                         then If   Cantidad<ArticuloFields.CantidadMinimaVenta.Value
                              then begin
                                   Error := True;
                                   ErrorText := JoinMessage( RsMsg7, Format( RsMsg9, [ Decimales, ArticuloFields.CantidadMinimaVenta.Value ] ) );
                                   end;

                         end;

                    end;

               end;

          end;
end;

function TStockAlmacenModule.StockEnvases( Propietario    : String;
                                           TipoRecipiente : TTipoRecipiente;
                                           CodigoEnvase   : String ) : Decimal;
begin
     If   FOnObtenExistenciasRecipiente.CanInvoke
     then Result := FOnObtenExistenciasRecipiente.Invoke( Propietario, TipoRecipiente, CodigoEnvase )
     else Result := 0.0;
end;

procedure Initialize;
begin
     If   not UpdatingDictionaries and ( CodigoUsuarioActual<>'' )
     then StockAlmacen;
end;

initialization

   // Este procedimiento me sirve para inicializar el modulo de Stocks de forma diferida y desde la unidad 'frxNXRTTI',
   // la cual no puede tener acceso directo a éste módulo

   AddProcedure( imProcedure, pidCreateStockModule, Initialize );

end.
