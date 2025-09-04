
unit dm_sto;

interface

uses
  Windows, Messages, SysUtils, System.Classes,

  DB,
  nxsdTypes,
  nxdb,

  Spring,

  LibUtils,
  DataManager,
  ServerDataModule,
  SessionIntf,
  SqlSet,

  Gim10Fields,
  Gim30Fields,

  MovimientoIntf,
  LineaMovimientoIntf,

  dmi_mov,
  dmi_sto;

type

  TActualizaMovimientoEvent = procedure ( TipoMovimiento        : TTipoMovimiento;
                                          Serie,
                                          Propietario           : String;
                                          LineaMovimientoFields : TLineaMovimientoFields;
                                          Descontar             : Boolean = False;
                                          CantidadOperacion     : Decimal = 0.0 ) of object;

  TStockAlmacenService = class( TSessionModule, IStockAlmacenService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaStock( StockCursorID,
                              TarifaComprasCursorID : TnxCursorID;

                              TipoMovimiento        : TTipoMovimiento;
                              Serie,
                              Propietario           : String;
                              LineaMovimiento       : ILineaMovimiento;
                              Descontar             : Boolean = False;
                              CantidadOperacion     : Decimal  = 0.0 );

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
                         Ejercicio,
                         MesInicial,
                         MesFinal            : SmallInt ) : IExistenciasArticulo;

    function ObtenStockFecha ( CodigoArticulo      : String;
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
                               NroLinea            : SmallInt  ) : IExistenciasArticulo;

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
                                 Ejercicio,
                                 MesInicial,
                                 MesFinal            : SmallInt ) : Decimal;

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
    end;

  TStockAlmacenModule = class(TServerDataModule)
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
    DmStockAuxTable: TnxeTable;
    DmArticuloListadoTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    DmMovimientoAuxTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);

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

    FOnActualizaStock : Event<TActualizaMovimientoEvent>;

    procedure AcumulaExistencias( DmStockFields   : TStockFields;
                                  SumaExistencias : TExistencias;
                                  MesInicial,
                                  MesFinal        : SmallInt );

    procedure GetStockFields( Ejercicio       : SmallInt;
                              CodigoArticulo  : String;
                              CodigoClaseA,
                              CodigoClaseB,
                              CodigoClaseC    : String;
                              LoteFabricacion : String;
                              Ubicacion       : String;
                              CodigoAlmacen   : String );

    procedure FijaRango( Todos : Boolean; Valor : String; var ValorInicial : String; var ValorFinal : String );
    function RangoValido( Valor, ValorInicial, ValorFinal : String ) : Boolean;

  public

    DmArticuloFields,
    DmArticuloListadoFields : TArticuloFields;
    DmStockFields,
    DmStockAuxFields : TStockFields;
    DmTipoMovAlmacenFields : TTipoMovAlmacenFields;
    DmMovimientoFields,
    DmMovimientoAuxFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoAuxFields : TLineaMovimientoFields;
    DmSerieFacturacionFields : TSerieFacturacionFields;
    DmTarifaComprasFields : TTarifaComprasFields;
    DmAlmacenFields : TAlmacenFields;
    DmConsumoComprasFields : TConsumoComprasFields;
    DmConsumoVentasFields : TConsumoVentasFields;

    DmStockAnteriorFields : TStockFields;  // Un registro persistente

    // ExistenciasArticulo : TExistenciasArticulo;

    SumaExistenciasActual,
    SumaExistenciasDia : TExistencias;

    procedure ActualizaStock( StockCursorID,
                              TarifaComprasCursorID : TnxCursorID;

                              TipoMovimiento        : TTipoMovimiento;
                              Serie,
                              Propietario           : String;
                              LineaMovimiento       : ILineaMovimiento;
                              Descontar             : Boolean = False;
                              CantidadOperacion     : Decimal  = 0.0 ); overload;

    procedure ActualizaStock( MovimientoFields      : TMovimientoFields;
                              LineaMovimientoFields : TLineaMovimientoFields;
                              Descontar             : Boolean = False;
                              CantidadOperacion     : Decimal  = 0.0 ); overload;

    procedure ActualizaStock( TipoMovimiento        : TTipoMovimiento;
                              Serie,
                              Propietario           : String;
                              LineaMovimientoFields : TLineaMovimientoFields;
                              Descontar             : Boolean = False;
                              CantidadOperacion     : Decimal  = 0.0;
                              NoUsarTransacciones   : Boolean = False ); overload;

    // NoUsarTransacciones solo existe para poder utilizar la llamada a la función directamente desde el cliente usando la función IStockAlmacenService.ActualizaStock
    // No debe usarse desde GServer porque las transacciones anidadas se respetan correctamente

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
                         Ejercicio,
                         MesInicial,
                         MesFinal            : SmallInt ) : IExistenciasArticulo; overload;

    function ObtenStock( ArticuloFields      : TArticuloFields;
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
                         Ejercicio,
                         MesInicial,
                         MesFinal            : SmallInt ) : IExistenciasArticulo; overload;


    function ObtenStockFecha ( CodigoArticulo      : String;
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
                               NroLinea            : SmallInt  ) : IExistenciasArticulo;

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
                                 Ejercicio,
                                 MesInicial,
                                 MesFinal            : SmallInt ) : Decimal;

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

    procedure ActualizaConsumoCompras( TipoConsumo          : Integer;
                                       CodigoProveedor      : String;
                                       CodigoArticulo       : String;
                                       CodigoClaseA,
                                       CodigoClaseB,
                                       CodigoClaseC         : String;
                                       Fecha                : TDateTime;
                                       Unidades,
                                       Importe,
                                       ImporteDescuentos    : Decimal );

    procedure ActualizaConsumoVentas( TipoConsumo         : Integer;
                                      CodigoCliente       : String;
                                      CodigoArticulo      : String;
                                      CodigoClaseA,
                                      CodigoClaseB,
                                      CodigoClaseC        : String;
                                      Fecha               : TDateTime;
                                      Unidades,
                                      Importe,
                                      ImporteDescuentos   : Decimal );

    // Listados

    function ListadoExistencias(      TodosLosAlmacenes  : Boolean;
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

    property OnActualizaStock : Event<TActualizaMovimientoEvent> read FOnActualizaStock write FOnActualizaStock;

    end;

resourcestring
      RsMsg1    = 'La cabecera de la operación nº %d no existe.';
      RsMsg2    = 'Regenere sus ficheros. Si así no consigue solucionar el problema, avise a su soporte técnico.';
      RsMsg3    = 'No hay existencias suficientes.';
      RsMsg4    = 'En este momento hay %.*f unidades en almacén.';
      RsMsg5    = 'Las existencias de este artículo quedarán bajo mínimos.';
      RsMsg6    = 'En el almacén quedarán %.*f unidades y el stock mínimo es de %.*f unidades.';

      srTodos   = '<Todos>';

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}

uses  Variants,

      nxdbBase,
      nxllBde,
      nxrdClass,
      nxrbTypes,
      nxsrServerEngine,
      nxdmServer,

      AppManager,
      DateUtils,
      BaseSessionData,
      SessionData,

      Gsm00Dm,

      dmi_art,

      dm_art,
      dm_tma,
      dm_mov;

procedure TStockAlmacenModule.GetStockFields( Ejercicio       : SmallInt;
                                              CodigoArticulo  : String;
                                              CodigoClaseA,
                                              CodigoClaseB,
                                              CodigoClaseC    : String;
                                              LoteFabricacion : String;
                                              Ubicacion       : String;
                                              CodigoAlmacen   : String );

var  Index : SmallInt;

begin

     With DmStockTable do
       begin
       If   not FindKey( [ Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion, Ubicacion, CodigoAlmacen ] )
       then begin
            Append;
            DmStockFields.Ejercicio.Value := Ejercicio;
            DmStockFields.CodigoArticulo.Value := CodigoArticulo;
            DmStockFields.CodigoClaseA.Value := CodigoClaseA;
            DmStockFields.CodigoClaseB.Value := CodigoClaseB;
            DmStockFields.CodigoClaseC.Value := CodigoClaseC;
            DmStockFields.Ubicacion.Value := Ubicacion;
            DmStockFields.LoteFabricacion.Value := LoteFabricacion;
            DmStockFields.CodigoAlmacen.Value := CodigoAlmacen;

            For Index := 0 to 1 do
              begin
              DmStockFields.PendienteRecibir[ Index ].Value := 0.0;
              DmStockFields.PendienteServir[ Index ].Value := 0.0;
              end;

            For Index := 0 to 12 do
              begin
              DmStockFields.MovimientoMes[ Index, 0 ].Value := 0.0;
              DmStockFields.MovimientoMes[ Index, 1 ].Value := 0.0;
              end;
            Post;
            end;

       Edit;
       end;
end;

procedure TStockAlmacenModule.AcumulaExistencias( DmStockFields   : TStockFields;
                                                  SumaExistencias : TExistencias;
                                                  MesInicial,
                                                  MesFinal        : SmallInt );

procedure AcumulaMes;
begin
     With SumaExistencias do
       begin
       MovimientosEntradaMes[ NroMes ] := MovimientosEntradaMes[ NroMes ] + DmStockFields.MovimientoMes[ NroMes, 0 ].Value;
       MovimientosSalidaMes[ NroMes ] := MovimientosSalidaMes[ NroMes ] +  DmStockFields.MovimientoMes[ NroMes, 1 ].Value;
       Entradas := Entradas +  DmStockFields.MovimientoMes[ NroMes, 0 ].Value;
       Salidas := Salidas + DmStockFields.MovimientoMes[ NroMes, 1 ].Value;
       end;
end;

begin
     NroMes := MesInicial;

     If   ( MesFinal>12 ) and ( MesInicial<>MesFinal )
     then MesFinal := SessionDataModule.NroMesFinal;

     If   MesInicial<MesFinal
     then repeat
            AcumulaMes;
            Inc( NroMes );
            If   SessionDataModule.NroMesInicial<>1
            then begin
                 If   NroMes=13
                 then NroMes := 1
                 else If   NroMes=1
                      then NroMes := SessionDataModule.NroMesInicial;
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

procedure TStockAlmacenModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmArticuloFields := TArticuloFields.Create( DmArticuloTable );
     DmArticuloListadoFields := TArticuloFields.Create( DmArticuloListadoTable );
     DmStockFields := TStockFields.Create( DmStockTable );
     DmStockAuxFields := TStockFields.Create( DmStockAuxTable );
     DmTipoMovAlmacenFields := TTipoMovAlmacenFields.Create( DmTipoMovAlmacenTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoAuxFields := TLineaMovimientoFields.Create( DmLineaMovimientoAuxTable );
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( DmSerieFacturacionTable );
     DmTarifaComprasFields := TTarifaComprasFields.Create( DmTarifaComprasTable );
     DmAlmacenFields := TAlmacenFields.Create( DmAlmacenTable );
     DmConsumoComprasFields := TConsumoComprasFields.Create( DmConsumoComprasTable );
     DmConsumoVentasFields := TConsumoVentasFields.Create( DmConsumoVentasTable );

     DmStockAnteriorFields := TStockFields.Create( DmStockTable, True );

     //** CostePeriodoEvent := CostePeriodo;

     //** ExecOnCreateComponentProcedures( idStockModule );

     DmStockTable.Timeout := LockWaitTimeout;
     DmStockAuxTable.Timeout := LockWaitTimeout;
     DmConsumoComprasTable.Timeout := LockWaitTimeout;
     DmConsumoVentasTable.Timeout := LockWaitTimeout;

end;

procedure TStockAlmacenModule.ServerDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.StockAlmacenModule := nil
end;

{ Esta versión de acceso remoto a ActualizaStock permite ser llamada incluso dentro de una transacción en el
  lado cliente. Para ello se pasa el identificador de las tablas que se están utilizando en el cliente
  para que se puedan usar esos cursores en lugar de los creados en la sesión del servidor }

procedure TStockAlmacenModule.ActualizaStock( StockCursorID,
                                              TarifaComprasCursorID : TnxCursorID;

                                              TipoMovimiento        : TTipoMovimiento;
                                              Serie,
                                              Propietario           : String;
                                              LineaMovimiento       : ILineaMovimiento;
                                              Descontar             : Boolean = False;
                                              CantidadOperacion     : Decimal = 0.0 );

var  StockCursor,
     TarifaComprasCursor : TnxServerTableCursor;

begin

     DmStockTable.AssignAbstractCursor( StockCursorID );
     DmTarifaComprasTable.AssignAbstractCursor( TarifaComprasCursorID );

     try
       LineaMovimiento.ToDataset( DmLineaMovimientoFields, { ReadBlobls } False  );  // Si se leen los Blobs se produce un conflicto de bloqueo con la transacción del cliente
       ActualizaStock( TipoMovimiento, Serie, Propietario, DmLineaMovimientoFields, Descontar, CantidadOperacion, { NoUsarTransacciones } True );
     finally
       DmLineaMovimientoFields.DatasetCancel;

       DmTarifaComprasTable.RestoreAbstractCursor;
       DmStockTable.RestoreAbstractCursor;

     end;

end;

{ Tablas que pueden resultar afectadas en ActualizaStock (transacciones)

    DmTarifaComprasTable
    DmStockTable

}

procedure TStockAlmacenModule.ActualizaStock( MovimientoFields      : TMovimientoFields;
                                              LineaMovimientoFields : TLineaMovimientoFields;
                                              Descontar             : Boolean = False;
                                              CantidadOperacion     : Decimal = 0.0 );
begin
     With MovimientoFields do
       ActualizaStock( TipoMovimiento.Value, Serie.Value, Propietario.Value, LineaMovimientoFields, Descontar, CantidadOperacion );
end;

procedure TStockAlmacenModule.ActualizaStock( TipoMovimiento        : TTipoMovimiento;
                                              Serie,
                                              Propietario           : String;
                                              LineaMovimientoFields : TLineaMovimientoFields;
                                              Descontar             : Boolean = False;
                                              CantidadOperacion     : Decimal = 0.0;
                                              NoUsarTransacciones   : Boolean = False );
var NroPeriodo : SmallInt;
    CodigoArticulo : String;
    CodigoClaseA,
    CodigoClaseB,
    CodigoClaseC : String;
    LoteFabricacion : String;
    CodigoAlmacen : String;
    Ubicacion : String;
    Cantidad,
    Recargo,
    Descuento : Decimal;
    Precio : Double;
    Fecha,
    FechaCaducidadLote : TDate;
    UIDArticuloLote : TGuid;
    AfectarACostes : Boolean;
    ExistenciasArticulo : IExistenciasArticulo;
    TransactionTag : TTransactionTag;

procedure Procesa;

var   PrecioNeto : Double;
      Entrada : Boolean;

procedure ActualizaPrecioCompra;
begin
     If   SessionDataModule.EmpresaFields.Compras_ActTarifas.Value
     then With DmTarifaComprasTable do
            If   not ValueIsEmpty( Propietario )
            then try
                   If   not FindKey( [ rtcProveedorArticulo, Propietario, CodigoArticulo ] )
                   then begin
                        Append;
                        DmTarifaComprasFields.CodigoProveedor.Value := Propietario;
                        DmTarifaComprasFields.CodigoArticulo.Value  := CodigoArticulo;
                        DmTarifaComprasFields.Precio.Value := Precio;
                        DmTarifaComprasFields.Descuento.Value := Descuento;
                        end
                   else begin
                        Edit;
                        DmTarifaComprasFields.Precio.Value := Precio;
                        DmTarifaComprasFields.Descuento.Value := Descuento;
                        end;
                   Post;
                 except
                   Cancel;
                   raise;
                   end;
end;

procedure ActualizaCosteMedio;

var   CantidadLinea : Decimal;

begin

     If   Descontar
     then CantidadLinea := -CantidadOperacion
     else CantidadLinea := CantidadOperacion;

     With ExistenciasArticulo.SumaExistencias do
       If   ( Entradas<0.0 ) or
            ( ( Entradas>0.0 ) and ( DmStockFields.Coste_Medio.Value=0.0 ) )  // Por ejemplo, se han hecho devoluciones de ventas sin que existiera una entrada anterior para calcular el coste
       then DmStockFields.Coste_Medio.Value := PrecioNeto
       else If   ( Entradas + CantidadLinea )<>0.0
            then DmStockFields.Coste_Medio.Value := ( ( Entradas * DmStockFields.Coste_Medio.Value ) + ( CantidadLinea * PrecioNeto ) ) / ( Entradas + CantidadLinea );
end;

begin

     // IMPORTANTE : NoUsarTransacciones es especial y solo se utiliza desde IStockAlmacenService.ActualizaStock

     If   not NoUsarTransacciones
     then TransactionTag := SessionDataModule.StartTransactionWith( [ DmStockTable, DmTarifaComprasTable ] );

     try

       With DmStockTable do
         begin

         GetStockFields( SessionDataModule.Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion, Ubicacion, CodigoAlmacen );

         try

           ExistenciasArticulo := TExistenciasArticulo.Create;

           AcumulaExistencias( DmStockFields, ExistenciasArticulo.SumaExistencias, 0, 12 );

           With DmStockFields do
             case TipoMovimiento of

                   //* 31.03.2009 Me limito a evitar que las cantidades pendientes puedan ser negativas. Este tipo de situaciones
                   //             se pueden dar -por ejemplo- si los datos de ejercicios anteriores son incorrectos y se reconstruyen los resultados.

                   tmPedidoCompra     : begin

                                        If   Descontar
                                        then CantidadOperacion := -CantidadOperacion;

                                        If   SessionDataModule.EjercicioFecha( Fecha )=SessionDataModule.Ejercicio
                                        then begin
                                             PendienteRecibir[ 1 ].Value := PendienteRecibir[ 1 ].Value + CantidadOperacion;
                                             If   PendienteRecibir[ 1 ].Value<0.0
                                             then PendienteRecibir[ 1 ].Value := 0.0;
                                             end
                                        else If   SessionDataModule.EjercicioFecha( Fecha )=SessionDataModule.Ejercicio - 1
                                             then begin
                                                  PendienteRecibir[ 0 ].Value := PendienteRecibir[ 0 ].Value + CantidadOperacion;
                                                  If   PendienteRecibir[ 0 ].Value<0.0
                                                  then PendienteRecibir[ 0 ].Value := 0.0;
                                                  end;
                                        end;

                   tmPedidoVenta      : begin

                                        If   Descontar
                                        then CantidadOperacion := -CantidadOperacion;

                                        If   SessionDataModule.EjercicioFecha( Fecha )=SessionDataModule.Ejercicio
                                        then begin
                                             PendienteServir[ 1 ].Value :=  PendienteServir[ 1 ].Value + CantidadOperacion;
                                             If   PendienteServir[ 1 ].Value<0.0
                                             then PendienteServir[ 1 ].Value := 0.0;
                                             end
                                        else If   SessionDataModule.EjercicioFecha( Fecha )=SessionDataModule.Ejercicio - 1
                                             then begin
                                                  PendienteServir[ 0 ].Value := PendienteServir[ 0 ].Value + CantidadOperacion;
                                                  If   PendienteServir[ 0 ].Value<0.0
                                                  then PendienteServir[ 0 ].Value := 0.0;
                                                  end;

                                        end;

                   else                 begin

                                        If   TipoMovimiento=tmInventario
                                        then NroPeriodo := 0
                                        else NroPeriodo := MonthOf( Fecha );

                                        PrecioNeto := Precio - ( ( ( Precio + Recargo ) * Descuento ) / 100.0 );

                                        If   ( CantidadOperacion>0.0 ) and not( TipoMovimiento in [ tmSalida, tmVenta ] )
                                        then begin

                                             If   DmArticuloFields.NoAfectarCoste.Value
                                             then AfectarACostes := False
                                             else begin
                                                  AfectarACostes := True;
                                                  If   TipoMovimiento>tmUltimoPredefinido
                                                  then If   DmTipoMovAlmacenTable.FindKey( [ TipoMovimiento ] )
                                                       then AfectarACostes := not DmTipoMovAlmacenFields.NoAfectarCoste.Value;
                                                  end;

                                             //* 18.12.2008 Añadido el tipo de movimiento para que refleje tan solo las compras realizadas
                                             //* 16.01.2009 Añadidos los campos PrecioUltCompra y FechaUltCompra para diferenciarlos claramente de las entradas

                                             If   Descontar
                                             then begin

                                                  //* 01.06.2023 Habría que buscar la última entrada para poder reponer los valores de PrecioUltCompra,
                                                  //             FechaUltCompra y FechaUltEntrada. Pero el coste es muy alto. Mejor una reconstrucción?

                                                  {
                                                  If   AfectarACostes and ( FechaUltCompra.Value<=Fecha ) and ( TipoMovimiento=tmCompra )
                                                  then With DmLineaMovimientoTable do
                                                         try

                                                           IndexFieldNames := 'CodigoAlmacen;Ubicacion;CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';

                                                           SetRange( [ CodigoAlmacen.Value, Ubicacion.Value, CodigoArticulo.Value, Fecha, 1, 0, 1 ],
                                                                     [ CodigoAlmacen.Value, Ubicacion.Value, CodigoArticulo.Value, Fecha, MaxLongint, 0, MaxSmallInt ] );

                                                           Last;
                                                           While not Bof do
                                                             begin

                                                                If   ( DmLineaMovimientoFields.Fecha.Value<=Fecha ) and
                                                                     ( DmLineaMovimientoFields.NroOperacion.Value<=LineaMovimientoFields.NroOperacion.Value ) and
                                                                     ( DmLineaMovimientoFields.NroPagina.Value<=LineaMovimientoFields.NroPagina.Value ) and
                                                                     ( DmLineaMovimientoFields.NroLinea.Value<LineaMovimientoFields.NroLinea.Value )
                                                                If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
                                                                then If   DmMovimientofields.TipoMovimiento.Value in [ tmCompra, tmEntrada ]
                                                                     then begin

                                                                          end;

                                                                end;

                                                             Prior;
                                                             end;

                                                         finally
                                                           CancelRange;
                                                         end;
                                                  }

                                                  end
                                             else begin

                                                  If   ( FechaUltCompra.Value<=Fecha ) and ( TipoMovimiento=tmCompra )
                                                  then begin
                                                       If   AfectarACostes
                                                       then ActualizaPrecioCompra;
                                                       FechaUltCompra.Value := Fecha;
                                                       PrecioUltCompra.Value := PrecioNeto;
                                                       end;

                                                  If   FechaUltEntrada.Value<=Fecha
                                                  then FechaUltEntrada.Value := Fecha;

                                                  If   ( FechaUltEntradaCoste.Value<=Fecha ) and AfectarACostes
                                                  then begin
                                                       CosteUltEntrada.Value := PrecioNeto;
                                                       FechaUltEntradaCoste.Value := Fecha;
                                                       end;

                                                  FechaCaducidad.Value := FechaCaducidadLote;
                                                  UIDArticulo.AsGuid  := UIDArticuloLote;
                                                  end;

                                             If   AfectarACostes
                                             then ActualizaCosteMedio;

                                             end

                                             //* 18.12.2008 Añadido el tipo de movimiento para que refleje tan solo las ventas realizadas
                                             //* 16.01.2009 Añadidos los campos PrecioUltVenta y FechaUltVenta para diferenciarlos claramente de las salidas

                                        else If   not Descontar
                                             then begin
                                                  If   ( FechaUltVenta.Value<=Fecha ) and ( TipoMovimiento=tmVenta )
                                                  then begin
                                                       PrecioUltVenta.Value := PrecioNeto;
                                                       FechaUltVenta.Value := Fecha;
                                                       end;
                                                  If   FechaUltSalida.Value<=Fecha
                                                  then begin
                                                       PrecioUltSalida.Value := PrecioNeto;
                                                       FechaUltSalida.Value  := Fecha;
                                                       end;
                                                  end;

                                        If   not ( DmAlmacenFields.RoturaStock.Value and ( Fecha<DmAlmacenFields.FechaRotura.Value ) )
                                        then If   CantidadOperacion>0.0
                                             then begin
                                                  If   Descontar
                                                  then CantidadOperacion := -CantidadOperacion;
                                                  MovimientoMes[ NroPeriodo, 0 ].Value := MovimientoMes[ NroPeriodo, 0 ].Value + CantidadOperacion;
                                                  end
                                             else begin
                                                  CantidadOperacion := Abs( CantidadOperacion );
                                                  If   Descontar
                                                  then CantidadOperacion := -CantidadOperacion;
                                                  MovimientoMes[ NroPeriodo, 1 ].Value := MovimientoMes[ NroPeriodo, 1 ].Value + CantidadOperacion;
                                                  end;

                                        end;
                   end;

           Post;

         finally
           Cancel;
           end;

         end;

       If   not NoUsarTransacciones
       then TransactionTag.Commit;

     except
       If   not NoUsarTransacciones
       then TransactionTag.Rollback;
       raise;
       end;

end;

begin

      If   TipoMovimiento in [ tmOferta, tmPresupuesto ]
      then Exit;

      Fecha := LineaMovimientoFields.Fecha.Value;

      CodigoArticulo := VarToStr( LineaMovimientoFields.CodigoArticulo.Value );
      CodigoClaseA := VarToStr( LineaMovimientoFields.CodigoClaseA.Value );
      CodigoClaseB := VarToStr( LineaMovimientoFields.CodigoClaseB.Value );
      CodigoClaseC := VarToStr( LineaMovimientoFields.CodigoClaseC.Value );

      LoteFabricacion := VarToStr( LineaMovimientoFields.LoteFabricacion.Value );
      FechaCaducidadLote := LineaMovimientoFields.FechaCaducidad.Value;
      UIDArticuloLote := LineaMovimientoFields.UIDArticulo.AsGuid;
      CodigoAlmacen := VarToStr( LineaMovimientoFields.CodigoAlmacen.Value );
      Ubicacion := VarToStr( LineaMovimientoFields.Ubicacion.Value );
      Precio := VarToDouble( LineaMovimientoFields.Precio.Value );
      Recargo := VarToDecimal( LineaMovimientoFields.Recargo.Value );
      Descuento := VarToDecimal( LineaMovimientoFields.Descuento.Value );

     // Esto me permite utilizar una CantidadOperacion distinta a la de la línea

     If   CantidadOperacion=0.0
     then CantidadOperacion := LineaMovimientoFields.Cantidad.Value;

     If   ( CodigoArticulo<>ArticuloManual ) and
          ( CantidadOperacion<>0.0 )
     then begin

          If   TipoMovimiento=tmVenta
          then If   DmSerieFacturacionTable.FindKey( [ Serie ] )
               then If   not DmSerieFacturacionFields.Afectar_Stock.Value
                    then Exit;

          If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
          then If   not DmArticuloFields.NoAfectarStock.Value
               then begin
                    DmAlmacenTable.FindKey( [ CodigoAlmacen ] );
                    Procesa;
                    FOnActualizaStock.Invoke( TipoMovimiento, Serie, Propietario, LineaMovimientoFields, Descontar, CantidadOperacion );
                    end;

          end

     // LLamo al evento de actualización de existencias en todos los casos.
     // Los envases, por ejemplo, no requieren de código de artículo ni cantidad en la línea.

     else FOnActualizaStock.Invoke( TipoMovimiento, Serie, Propietario, LineaMovimientoFields, Descontar, CantidadOperacion );

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
     Result := ( AnsiCompareStr( Valor, ValorInicial )>=0 ) and ( AnsiCompareStr( Valor, ValorFinal )<=0 );
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
                                         Ejercicio,
                                         MesInicial,
                                         MesFinal            : SmallInt ) : IExistenciasArticulo;
begin
     DmArticuloTable.FindKey( [ CodigoArticulo ] );  // Si no se encuentra el artículo la función ObtenStock devuelve un IExistenciasArticulo vacío (no nulo)
     Result := ObtenStock( DmArticuloFields,
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

function TStockAlmacenModule.ObtenStock( ArticuloFields      : TArticuloFields;
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
                                         Ejercicio,
                                         MesInicial,
                                         MesFinal            : SmallInt ) : IExistenciasArticulo;

var   CodigoArticulo,
      CodigoArticuloActual : String;
      CodigoClaseAActual,
      CodigoClaseBActual,
      CodigoClaseCActual  : String;
      CodigoAlmacenActual : String;

      CosteAlmacen,
      CosteMedioAlmacen,
      ExistenciasValidasAlmacen : Decimal;

      ExistenciasArticulo : IExistenciasArticulo;

function ObtenPrecioFicha : Decimal;
begin
     Result := ArticuloFields.Precio_Compra.Value - ( ( ArticuloFields.Precio_Compra.Value * ArticuloFields.Dto_Compra.Value ) / 100.0 );
end;

procedure CalculaCoste;

var   SumaExistenciasRegistro : TExistencias;
      CosteRegistro,
      CosteMedioRegistro : Decimal;

begin

     If   FObtenCoste
     then begin

          With DmStockFields do
            begin
            If   Coste_Medio.Value<>0.0
            then CosteRegistro := Coste_Medio.Value
            else If   CosteUltEntrada.Value<>0.0
                 then CosteRegistro := CosteUltEntrada.Value
                 else CosteRegistro := ObtenPrecioFicha;
            CosteMedioRegistro := Coste_Medio.Value;
            end;

          SumaExistenciasRegistro :=  TExistencias.Create;

          try

            AcumulaExistencias( DmStockFields, SumaExistenciasRegistro, FMesInicial, FMesFinal );

            //* 15.09.2000 He sacado el calculo del mejor coste disponible de la condición Saldo>0.0 para
            //             que haya al menos un valor por defecto aunque no hayan Existencias

            If   CosteAlmacen=0.0
            then CosteAlmacen := CosteRegistro;

            If   SumaExistenciasRegistro.Saldo>0.0
            then begin

                 If   CosteMedioAlmacen=0.0
                 then CosteMedioAlmacen := CosteMedioRegistro
                 else If   ( ExistenciasValidasAlmacen + SumaExistenciasRegistro.Saldo )<>0.0
                      then If   CosteMedioRegistro<>0.0
                           then CosteMedioAlmacen := ( ( ExistenciasValidasAlmacen * CosteMedioAlmacen ) + ( SumaExistenciasRegistro.Saldo * CosteMedioRegistro ) ) /
                                                       ( ExistenciasValidasAlmacen + SumaExistenciasRegistro.Saldo );

                 If   CosteAlmacen=0.0
                 then CosteAlmacen := CosteRegistro
                 else If   ( ExistenciasValidasAlmacen + SumaExistenciasRegistro.Saldo )<>0.0
                      then If   CosteRegistro<>0.0
                           then CosteAlmacen := ( ( ExistenciasValidasAlmacen * CosteAlmacen ) + ( SumaExistenciasRegistro.Saldo * CosteRegistro ) ) /
                                                  ( ExistenciasValidasAlmacen + SumaExistenciasRegistro.Saldo );

                 DecAdd( ExistenciasValidasAlmacen, SumaExistenciasRegistro.Saldo );
                 end;

            finally
              SumaExistenciasRegistro.Free;
              end;

          end;

end;

procedure InicializaAlmacen;
begin
     CodigoArticuloActual := DmStockFields.CodigoArticulo.Value;
     CodigoClaseAActual := DmStockFields.CodigoClaseA.Value;
     CodigoClaseBActual := DmStockFields.CodigoClaseB.Value;
     CodigoClaseCActual := DmStockFields.CodigoClaseC.Value;
     CodigoAlmacenActual := DmStockFields.CodigoAlmacen.Value;

     ExistenciasValidasAlmacen := 0.0;
     CosteAlmacen := 0.0;
     CosteMedioAlmacen := 0.0;
end;

procedure FijaCoste;
begin

     //* 15.09.2000 He sacado el calculo del mejor Coste disponible de la condición Saldo>0.0 para
     //             que haya al menos un valor por defecto aunque no hayan Existencias

     If   ( ExistenciasArticulo.Coste=0.0 ) and ( ExistenciasArticulo.SumaExistencias.Saldo=0.0 )
     then ExistenciasArticulo.Coste := CosteAlmacen;

     If   ( ExistenciasValidasAlmacen<>0.0 ) and
          ( ( ExistenciasArticulo.SumaExistencias.Saldo + ExistenciasValidasAlmacen )<>0.0 )
     then begin

          If   ( ExistenciasArticulo.CosteMedio=0.0 ) or ( ExistenciasArticulo.SumaExistencias.Saldo<=0.0 )
          then ExistenciasArticulo.CosteMedio := CosteMedioAlmacen
          else If   CosteMedioAlmacen<>0.0
               then ExistenciasArticulo.CosteMedio :=  ( ( ExistenciasArticulo.SumaExistencias.Saldo * ExistenciasArticulo.CosteMedio ) + ( ExistenciasValidasAlmacen * CosteMedioAlmacen ) ) /
                                                         ( ExistenciasArticulo.SumaExistencias.Saldo + ExistenciasValidasAlmacen );

          If   ( ExistenciasArticulo.Coste=0.0 ) or ( ExistenciasArticulo.SumaExistencias.Saldo<=0.0 )
          then ExistenciasArticulo.Coste := CosteAlmacen
          else If   CosteAlmacen<>0.0
               then ExistenciasArticulo.Coste := ( ( ExistenciasArticulo.SumaExistencias.Saldo * ExistenciasArticulo.Coste ) + ( ExistenciasValidasAlmacen * CosteAlmacen ) ) /
                                                   ( ExistenciasArticulo.SumaExistencias.Saldo + ExistenciasValidasAlmacen );

          end;

end;

procedure CompruebaCambioAlmacen;
begin
     If   ( CodigoArticuloActual<>DmStockFields.CodigoArticulo.Value ) or
          ( CodigoClaseAActual<>DmStockFields.CodigoClaseA.Value ) or
          ( CodigoClaseBActual<>DmStockFields.CodigoClaseB.Value ) or
          ( CodigoClaseCActual<>DmStockFields.CodigoClaseC.Value ) or
          ( CodigoAlmacenActual<>DmStockFields.CodigoAlmacen.Value )
     then begin
          FijaCoste;
          InicializaAlmacen;
          end;
end;

begin

     ExistenciasArticulo :=  TExistenciasArticulo.Create;
     CodigoArticulo := ArticuloFields.Codigo.Value;

     If   ( CodigoArticulo<>'' ) and
          ( CodigoArticulo<>ArticuloManual )
     then begin

          ExistenciasArticulo.CodigoArticulo := CodigoArticulo;
          ExistenciasArticulo.CodigoClaseA := CodigoClaseA;
          ExistenciasArticulo.CodigoClaseB := CodigoClaseB;
          ExistenciasArticulo.CodigoClaseC := CodigoClaseC;
          ExistenciasArticulo.LoteFabricacion := LoteFabricacion;
          ExistenciasArticulo.CodigoAlmacen := CodigoAlmacen;
          ExistenciasArticulo.CodigoUbicacion := CodigoUbicacion;

          FTodosLosLotes := TodosLosLotes;
          FTodosLosAlmacenes := TodosLosAlmacenes;
          FTodasLasUbicaciones := TodasLasUbicaciones;
          FObtenCoste := ObtenCoste;
          FEjercicio := Ejercicio;
          FMesInicial := MesInicial;
          FMesFinal := MesFinal;

          FijaRango( TodasLasClases and ( CodigoClaseA='' ), CodigoClaseA, FCodigoClaseAInicial, FCodigoClaseAFinal );
          FijaRango( TodasLasClases and ( CodigoClaseB='' ), CodigoClaseB, FCodigoClaseBInicial, FCodigoClaseBFinal );
          FijaRango( TodasLasClases and ( CodigoClaseC='' ), CodigoClaseC, FCodigoClaseCInicial, FCodigoClaseCFinal );

          FijaRango( TodosLosLotes { or not SessionDataModule.EmpresaFields.Stock_LotesProductos.Value },
                     LoteFabricacion,
                     FLoteFabricacionInicial,
                     FLoteFabricacionFinal );

          FijaRango( TodosLosAlmacenes { or not SessionDataModule.EmpresaFields.Stock_MultiAlmacen.Value },
                     CodigoAlmacen,
                     FCodigoAlmacenInicial,
                     FCodigoAlmacenFinal );

          FijaRango( TodasLasUbicaciones { or not SessionDataModule.EmpresaFields.Stock_Ubicaciones.Value },
                     CodigoUbicacion,
                     FCodigoUbicacionInicial,
                     FCodigoUbicacionFinal );

          // Las cantidades pendientes de servir y recibir incluyen las del ejercicio pasado

          With DmStockTable do
            try

              SetRange( [ FEjercicio, CodigoArticulo, FCodigoClaseAInicial, FCodigoClaseBInicial, FCodigoClaseCInicial, FLoteFabricacionInicial, FCodigoUbicacionInicial, FCodigoAlmacenInicial ],
                        [ FEjercicio, CodigoArticulo, FCodigoClaseAFinal, FCodigoClaseBFinal, FCodigoClaseCFinal, FLoteFabricacionFinal, FCodigoUbicacionFinal, FCodigoAlmacenFinal ] );

              First;
              If   not Eof
              then begin

                   InicializaAlmacen;

                   While not Eof do
                     begin

                     CalculaCoste;

                     If   ExistenciasArticulo.FechaUltCompra<DmStockFields.FechaUltCompra.Value
                     then begin
                          ExistenciasArticulo.FechaUltCompra := DmStockFields.FechaUltCompra.Value;
                          ExistenciasArticulo.PrecioUltCompra := DmStockFields.PrecioUltCompra.Value;
                          end;

                     If   ExistenciasArticulo.FechaUltEntrada<DmStockFields.FechaUltEntrada.Value
                     then ExistenciasArticulo.FechaUltEntrada := DmStockFields.FechaUltEntrada.Value;

                     If   ExistenciasArticulo.FechaUltEntradaCoste<DmStockFields.FechaUltEntradaCoste.Value
                     then begin
                          ExistenciasArticulo.FechaUltEntradaCoste := DmStockFields.FechaUltEntradaCoste.Value;
                          ExistenciasArticulo.CosteUltEntrada := DmStockFields.CosteUltEntrada.Value;
                          end;

                     If   ExistenciasArticulo.FechaUltVenta<DmStockFields.FechaUltVenta.Value
                     then begin
                          ExistenciasArticulo.FechaUltVenta := DmStockFields.FechaUltVenta.Value;
                          ExistenciasArticulo.PrecioUltVenta := DmStockFields.PrecioUltVenta.Value;
                          end;

                     If   ExistenciasArticulo.FechaUltSalida<DmStockFields.FechaUltSalida.Value
                     then begin
                          ExistenciasArticulo.FechaUltSalida := DmStockFields.FechaUltSalida.Value;
                          ExistenciasArticulo.PrecioUltSalida := DmStockFields.PrecioUltSalida.Value;
                          end;

                     DmStockAnteriorFields.Update;

                     Next;

                     If   Eof
                     then FijaCoste
                     else CompruebaCambioAlmacen;

                     AcumulaExistencias( DmStockAnteriorFields, ExistenciasArticulo.SumaExistencias, FMesInicial, FMesFinal );

                     end;

                   end
              else begin
                   ExistenciasArticulo.Coste := ObtenPrecioFicha;
                   ExistenciasArticulo.CosteMedio := ExistenciasArticulo.Coste;
                   end;

            finally
              CancelRange;
              end;

          end;

     Result := ExistenciasArticulo;

end;

procedure TStockAlmacenModule.ActualizaConsumoCompras( TipoConsumo       : Integer;
                                                       CodigoProveedor   : String;
                                                       CodigoArticulo    : String;
                                                       CodigoClaseA,
                                                       CodigoClaseB,
                                                       CodigoClaseC      : String;
                                                       Fecha             : TDateTime;
                                                       Unidades,
                                                       Importe,
                                                       ImporteDescuentos : Decimal );

var  Ejercicio,
     NroMes,
     Index : SmallInt;

begin
     With DmConsumoComprasTable do
       try

         Ejercicio := SessionDataModule.EjercicioFecha( Fecha );

         If   not FindKey( [ TipoConsumo, Ejercicio, CodigoProveedor, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] )
         then begin
              Append;
              DmConsumoComprasFields.Tipo.Value := TipoConsumo;
              DmConsumoComprasFields.Ejercicio.Value := Ejercicio;
              DmConsumoComprasFields.Proveedor.Value := CodigoProveedor;
              DmConsumoComprasFields.FamiliaArticulo.Value := CodigoArticulo;
              DmConsumoComprasFields.CodigoClaseA.Value := CodigoClaseA;
              DmConsumoComprasFields.CodigoClaseB.Value := CodigoClaseB;
              DmConsumoComprasFields.CodigoClaseC.Value := CodigoClaseC;

              For Index := 1 to 12 do
                begin
                DmConsumoComprasFields.Unidades[ Index ].Value := 0.0;
                DmConsumoComprasFields.Importe[ Index ].Value := 0.0;
                DmConsumoComprasFields.ImporteDescuentos[ Index ].Value := 0.0;
                end;

              end
         else Edit;

         NroMes := MonthOf( Fecha );

         DmConsumoComprasFields.Unidades[ NroMes ].Value := DmConsumoComprasFields.Unidades[ NroMes ].Value + Unidades;
         DmConsumoComprasFields.Importe[ NroMes ].Value := DmConsumoComprasFields.Importe[ NroMes ].Value + Importe;
         DmConsumoComprasFields.ImporteDescuentos[ NroMes ].Value := DmConsumoComprasFields.ImporteDescuentos[ NroMes ].Value + ImporteDescuentos;

         Post;

       except
         Cancel;
         raise;
         end;
end;

function TStockAlmacenModule.ObtenStockFecha ( CodigoArticulo      : String;
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
                                               NroLinea            : SmallInt  ) : IExistenciasArticulo;

var   MesInicial,
      MesFinal : SmallInt;
      CodigoAlmacenActual : String;
      NroOperacionActual : LongInt;
      AfectarStock : Boolean;
      Eos : Boolean;
      ExistenciasArticulo : IExistenciasArticulo;

begin

     ExistenciasArticulo :=  TExistenciasArticulo.Create;   // Para poder devolver un valor vacío

     If   DmArticuloTable.FindKey( [ CodigoArticulo ] )
     then If   not DmArticuloFields.NoAfectarStock.Value
          then begin

               CodigoArticulo := DmArticuloFields.Codigo.Value;
               MesInicial := 0;

               MesFinal := MonthOf( FechaStock );
               If   SessionDataModule.NroMesInicial=MesFinal
               then MesFinal := 0
               else If   ( MesFinal=1 ) and ( SessionDataModule.NroMesInicial<>1 )    // En los ejercicios partidos, cuendo es Enero, el mes anterior es Diciembre, no Apertura
                    then MesFinal := 12
                    else MesFinal := MesFinal - 1;

               ExistenciasArticulo := ObtenStock( DmArticuloFields,
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
                                                  False,
                                                  SessionDataModule.EjercicioFecha( FechaStock ),
                                                  MesInicial,
                                                  MesFinal );

               With DmLineaMovimientoTable do
                 try

                   // Las variables con los rangos ya se han fijado en Stock

                   If   TodosLosAlmacenes
                   then begin
                        IndexFieldNames := 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';
                        SetRange( [ CodigoArticulo, EncodeDate( YearOf( FechaStock ), MonthOf( FechaStock ), 1 ), 1, 0, 1 ],
                                  [ CodigoArticulo, FechaStock, MaxLongint, MaxSmallInt, MaxSmallInt ] );
                        end
                   else begin
                        IndexFieldNames := 'CodigoAlmacen;Ubicacion;CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';
                        SetRange( [ FCodigoAlmacenInicial, FCodigoUbicacionInicial, CodigoArticulo, EncodeDate( YearOf( FechaStock ), MonthOf( FechaStock ), 1 ), 1, 0, 1 ],
                                  [ FCodigoAlmacenFinal, FCodigoUbicacionFinal, CodigoArticulo, FechaStock, MaxLongint, MaxSmallInt, MaxSmallInt ] );

                        end;

                   // El StockAlmacen incluye los movimientos del día hasta la operación indicada (si<>0)

                   NroOperacionActual := 0;
                   CodigoAlmacenActual := '';
                   Eos := False;

                   First;
                   While not Eof and not Eos do
                     begin

                     If   NroOperacionActual<>DmLineaMovimientoFields.NroOperacion.Value
                     then begin

                          // Modificado el calculo de la variable AfectarStock para que las series sin StockAlmacen solo sean las de albaranes ventas

                          AfectarStock := True;
                          If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
                          then If   DmMovimientoFields.TipoMovimiento.Value in [ tmInventario, tmOferta, tmPedidoCompra, tmPresupuesto, tmPedidoVenta ]
                               then AfectarStock := False
                               else If   DmMovimientoFields.TipoMovimiento.Value=tmVenta
                                    then If   DmSerieFacturacionTable.FindKey( [ DmMovimientoFields.Serie.Value ] )
                                         then AfectarStock := DmSerieFacturacionFields.Afectar_Stock.Value;

                          NroOperacionActual := DmLineaMovimientoFields.NroOperacion.Value;
                          end;

                     If   AfectarStock
                     then begin

                          If   CodigoAlmacenActual<>DmLineaMovimientoFields.CodigoAlmacen.Value
                          then begin
                               DmAlmacenTable.FindKey( [ DmLineaMovimientoFields.CodigoAlmacen.Value ] );
                               CodigoAlmacenActual := DmLineaMovimientoFields.CodigoAlmacen.Value;
                               end;

                          If   not ( DmAlmacenFields.RoturaStock.Value and ( DmLineaMovimientoFields.Fecha.Value<DmAlmacenFields.FechaRotura.Value ) )
                          then If   RangoValido( DmLineaMovimientoFields.CodigoClaseA.Value, FCodigoClaseAInicial, FCodigoClaseAFinal ) and
                                    RangoValido( DmLineaMovimientoFields.CodigoClaseB.Value, FCodigoClaseBInicial, FCodigoClaseBFinal ) and
                                    RangoValido( DmLineaMovimientoFields.CodigoClaseC.Value, FCodigoClaseCInicial, FCodigoClaseCFinal ) and
                                    RangoValido( DmLineaMovimientoFields.LoteFabricacion.Value, FLoteFabricacionInicial, FLoteFabricacionFinal ) and
                                    RangoValido( DmLineaMovimientoFields.CodigoAlmacen.Value, FCodigoAlmacenInicial, FCodigoAlmacenFinal ) and
                                    RangoValido( DmLineaMovimientoFields.Ubicacion.Value, FCodigoUbicacionInicial, FCodigoUbicacionFinal )
                               then begin

                                    With ExistenciasArticulo do
                                      If   DmLineaMovimientoFields.Cantidad.Value>0.0
                                      then SumaExistencias.Entradas := SumaExistencias.Entradas + DmLineaMovimientoFields.Cantidad.Value
                                      else SumaExistencias.Salidas  := SumaExistencias.Salidas  + Abs( DmLineaMovimientoFields.Cantidad.Value );

                                    end;

                          end;

                     If   ( DmLineaMovimientoFields.Fecha.Value=FechaStock ) and
                          ( NroOperacion=DmLineaMovimientoFields.NroOperacion.Value )  and
                          ( NroPagina=DmLineaMovimientoFields.NroPagina.Value ) and
                          ( NroLinea=DmLineaMovimientoFields.NroLinea.Value )
                     then Eos := True
                     else Next;
                     end;

                 finally
                   CancelRange;
                   end;


               With ExistenciasArticulo.SumaExistencias do
                 Saldo := Entradas - Salidas;

               end;

     Result := ExistenciasArticulo;

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
                                                 Ejercicio,
                                                 MesInicial,
                                                 MesFinal            : SmallInt ) : Decimal;
begin
     Result  := ObtenStock( CodigoArticulo,
                            False,
                            CodigoClaseA,
                            CodigoClaseB,
                            CodigoClaseC,
                            TodosLosLotes,
                            LoteFabricacion,
                            TodosLosAlmacenes,
                            CodigoAlmacen,
                            TodasLasUbicaciones,
                            CodigoUbicacion,
                            True,
                            Ejercicio,
                            MesInicial,
                            MesFinal ).Coste;
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

var  CosteMedio,
     Entradas : Decimal;

begin
     CosteMedio := 0.0;
     Entradas := 0.0;

     FijaRango( TodasLasClases and ( CodigoClaseA='' ), CodigoClaseA, FCodigoClaseAInicial, FCodigoClaseAFinal );
     FijaRango( TodasLasClases and ( CodigoClaseB='' ), CodigoClaseB, FCodigoClaseBInicial, FCodigoClaseBFinal );
     FijaRango( TodasLasClases and ( CodigoClaseC='' ), CodigoClaseC, FCodigoClaseCInicial, FCodigoClaseCFinal );

     FijaRango( TodosLosLotes, LoteFabricacion, FLoteFabricacionInicial, FLoteFabricacionFinal );
     FijaRango( TodosLosAlmacenes, CodigoAlmacen, FCodigoAlmacenInicial, FCodigoAlmacenFinal );
     FijaRango( TodasLasUbicaciones, CodigoUbicacion, FCodigoUbicacionInicial, FCodigoUbicacionFinal );

     With DmLineaMovimientoAuxTable do
       begin
       IndexFieldNames := 'CodigoArticulo;LoteFabricacion;Fecha';
       DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';
       try
         SetRange( [ CodigoArticulo, '', SessionDataModule.PrimerDiaEjercicio ], [ CodigoArticulo, HighStrCode, Fecha ] );
         First;
         While not Eof do
           begin

           If   RangoValido( DmLineaMovimientoAuxFields.CodigoClaseA.Value, FCodigoClaseAInicial, FCodigoClaseAFinal ) and
                RangoValido( DmLineaMovimientoAuxFields.CodigoClaseB.Value, FCodigoClaseBInicial, FCodigoClaseBFinal ) and
                RangoValido( DmLineaMovimientoAuxFields.CodigoClaseC.Value, FCodigoClaseCInicial, FCodigoClaseCFinal ) and
                RangoValido( DmLineaMovimientoAuxFields.LoteFabricacion.Value, FLoteFabricacionInicial, FLoteFabricacionFinal ) and
                RangoValido( DmLineaMovimientoAuxFields.CodigoAlmacen.Value, FCodigoAlmacenInicial, FCodigoAlmacenFinal ) and
                RangoValido( DmLineaMovimientoAuxFields.Ubicacion.Value, FCodigoUbicacionInicial, FCodigoUbicacionFinal )
           then With DmLineaMovimientoAuxFields do
                  If   DmMovimientoAuxTable.Findkey( [ Ejercicio.Value, NroOperacion.Value ] )
                  then If   DmMovimientoAuxFields.TipoMovimiento.Value in [ tmInventario, tmEntrada, tmFabricacion, tmRegularizacion, tmDespiece, tmCompra ]
                       then If   Cantidad.Value>0.0
                            then begin
                                 var PrecioNeto := Precio.Value - ( ( ( Precio.Value + Recargo.Value ) * Descuento.Value ) / 100.0 );  // Precio neto
                                 var CantidadLinea := Cantidad.Value;
                                 CosteMedio := ( ( Entradas * CosteMedio ) + ( CantidadLinea * PrecioNeto ) ) / ( Entradas + CantidadLinea );
                                 DecAdd( Entradas, CantidadLinea );
                                 end;

           Next;
           end;

       finally
         CancelRange;
         end;
       end;

     Result := CosteMedio;
end;

procedure TStockAlmacenModule.ActualizaConsumoVentas( TipoConsumo       : Integer;
                                                      CodigoCliente     : String;
                                                      CodigoArticulo    : String;
                                                      CodigoClaseA,
                                                      CodigoClaseB,
                                                      CodigoClaseC      : String;
                                                      Fecha             : TDateTime;
                                                      Unidades,
                                                      Importe,
                                                      ImporteDescuentos : Decimal );

var  Ejercicio,
     NroMes,
     Index : SmallInt;

begin
     With DmConsumoVentasTable do
       try

         Ejercicio := SessionDataModule.EjercicioFecha( Fecha );
         If   not FindKey( [ TipoConsumo, Ejercicio, CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC ] )
         then begin
              Append;
              DmConsumoVentasFields.Tipo.Value := TipoConsumo;
              DmConsumoVentasFields.Ejercicio.Value := Ejercicio;
              DmConsumoVentasFields.Cliente.Value := CodigoCliente;
              DmConsumoVentasFields.FamiliaArticulo.Value := CodigoArticulo;
              DmConsumoVentasFields.CodigoClaseA.Value := CodigoClaseA;
              DmConsumoVentasFields.CodigoClaseB.Value := CodigoClaseB;
              DmConsumoVentasFields.CodigoClaseC.Value := CodigoClaseC;
              For Index := 1 to 12 do
                begin
                DmConsumoVentasFields.Unidades[ Index ].Value := 0.0;
                DmConsumoVentasFields.Importe[ Index ].Value := 0.0;
                DmConsumoVentasFields.ImporteDescuentos[ Index ].Value := 0.0;
                end;
              end
         else Edit;

         NroMes := MonthOf( Fecha );

         DmConsumoVentasFields.Unidades[ NroMes ].Value := DmConsumoVentasFields.Unidades[ NroMes ].Value + Unidades;
         DmConsumoVentasFields.Importe[ NroMes ].Value := DmConsumoVentasFields.Importe[ NroMes ].Value + Importe;
         DmConsumoVentasFields.ImporteDescuentos[ NroMes ].Value := DmConsumoVentasFields.ImporteDescuentos[ NroMes ].Value + ImporteDescuentos;

         Post;

       except
         Cancel;
         raise;
         end;
end;

// Un listado que se genera en el servidor

function TStockAlmacenModule.ListadoExistencias(      TodosLosAlmacenes  : Boolean;
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

var   CodigoAlmacenInicial,
      CodigoAlmacenFinal,
      CodigoActual,
      CodigoRegistro : String;
      FechaInicial,
      FechaFinal : TDateTime;
      Existencias : Decimal;
      ExistenciasArticulo : IExistenciasArticulo;

      ReportExistenciasTable : TnxeTable;
      ReportExistenciasFields : TReportExistenciasFields;

      CurrentRecordCount : LongInt;

procedure InsertaRegistro( CodigoArticulo  : String;
                           CodigoClaseA,
                           CodigoClaseB,
                           CodigoClaseC    : String;
                           LoteFabricacion : String;
                           CodigoAlmacen   : String );
begin

     //* 13.12.2000 Añadida la exclusión de artículos obsoletos
     //* 09.01.2007 Añadida la exclusión de artículos que no afectan a stock

     If   not DmArticuloListadoFields.Obsoleto.Value and not DmArticuloListadoFields.NoAfectarStock.Value
     then begin

          ReportExistenciasTable.Append;

          ReportExistenciasFields.CodigoArticulo.Value := CodigoArticulo;
          ReportExistenciasFields.Descripcion.Value := DmArticuloListadoFields.Descripcion.value;

          If   Seleccion=1
          then begin
               ReportExistenciasFields.CodigoFamilia.Value := DmArticuloListadoFields.Familia.Value;
               ReportExistenciasFields.DescripcionFamilia.Value := SessionDataModule.Dm30.FamiliaModule.Descripcion( DmArticuloListadoFields.Familia.Value );
               end;

          ReportExistenciasFields.CodigoClaseA.Value := CodigoClaseA;
          ReportExistenciasFields.CodigoClaseB.Value := CodigoClaseB;
          ReportExistenciasFields.CodigoClaseC.Value := CodigoClaseC;
          ReportExistenciasFields.LoteFabricacion.Value := LoteFabricacion;
          ReportExistenciasFields.CodigoAlmacen.Value := CodigoAlmacen;
          ReportExistenciasFields.Entradas.Value := ExistenciasArticulo.SumaExistencias.Entradas;
          ReportExistenciasFields.Salidas.Value := ExistenciasArticulo.SumaExistencias.Salidas;
          ReportExistenciasFields.Existencias.Value := ExistenciasArticulo.SumaExistencias.Saldo;

          If   Valorar
          then case PrecioValoracion of
                 0 : ReportExistenciasFields.Coste.Value := DmArticuloListadoFields.Precio_Compra.Value;
                 1 : ReportExistenciasFields.Coste.Value := ExistenciasArticulo.CosteUltEntrada;
                 2 : ReportExistenciasFields.Coste.Value := ExistenciasArticulo.CosteMedio;
                 3 : ReportExistenciasFields.Coste.Value := ExistenciasArticulo.Coste;
                 end;

          ReportExistenciasFields.PendienteRecibir.Value := ExistenciasArticulo.SumaExistencias.PendienteRecibir;
          ReportExistenciasFields.PendienteServir.Value := ExistenciasArticulo.SumaExistencias.PendienteServir;

          ReportExistenciasTable.Post;
          end;
end;

procedure InsertaRegistroStock( SinMovimientos : Boolean = False );

var   Incluir : Boolean;
      CodigoAlmacen,
      CodigoLote : String;

begin

     // StockFields, StockAlmacen

     If   TodosLosAlmacenes
     then CodigoAlmacen := ''
     else CodigoAlmacen := DmStockAuxFields.CodigoAlmacen.Value;

     If   DesglosarLotes
     then CodigoLote := DmStockAuxFields.LoteFabricacion.Value
     else CodigoLote := '';

     If   SinMovimientos
     then ExistenciasArticulo := TExistenciasArticulo.Create   // Un registro vacío
     else ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( DmStockAuxFields.CodigoArticulo.Value,
                                                                                       False,
                                                                                       DmStockAuxFields.CodigoClaseA.Value,
                                                                                       DmStockAuxFields.CodigoClaseB.Value,
                                                                                       DmStockAuxFields.CodigoClaseC.Value,
                                                                                       not DesglosarLotes,
                                                                                       CodigoLote,
                                                                                       TodosLosAlmacenes,
                                                                                       CodigoAlmacen,
                                                                                       True,
                                                                                       '',
                                                                                       Valorar,
                                                                                       SessionDataModule.Ejercicio,
                                                                                       MesInicial,
                                                                                       MesFinal );

     Existencias := ExistenciasArticulo.SumaExistencias.Saldo;

     case ArticulosAIncluir of
       0 : Incluir := Existencias>0.0;
       1 : Incluir := Existencias=0.0;
       2 : Incluir := Existencias<0.0;
       3 : Incluir := ( Existencias>0.0 ) or ( Existencias<0.0 );
       4 : Incluir := ( ExistenciasArticulo.SumaExistencias.Entradas=0.0 );
       5 : Incluir := ( ExistenciasArticulo.SumaExistencias.Salidas=0.0 );
       6 : Incluir := ( ExistenciasArticulo.SumaExistencias.Entradas=0.0 ) and ( ExistenciasArticulo.SumaExistencias.Salidas=0.0 );
       7 : Incluir := ( ExistenciasArticulo.SumaExistencias.Entradas<>0.0 ) or ( ExistenciasArticulo.SumaExistencias.Salidas<>0.0 );
       8 : ;
       9 : Incluir := True;
       end;

     If   Incluir
     then If   SinMovimientos
          then InsertaRegistro( DmArticuloListadoFields.Codigo.Value, '', '', '', '', '' )
          else InsertaRegistro( DmStockAuxFields.CodigoArticulo.Value,
                                DmStockAuxFields.CodigoClaseA.Value,
                                DmStockAuxFields.CodigoClaseB.Value,
                                DmStockAuxFields.CodigoClaseC.Value,
                                DmStockAuxFields.LoteFabricacion.Value,
                                CodigoAlmacen );

end;

procedure InsertaRegistroArticulo;
begin
     With DmArticuloListadoFields do
       begin
       ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenMOdule.ObtenStock( Codigo.Value,
                                                                                    True,
                                                                                    '',
                                                                                    '',
                                                                                    '',
                                                                                    True,
                                                                                    '',
                                                                                    TodosLosAlmacenes,
                                                                                    CodigoAlmacenUnico,
                                                                                    True,
                                                                                    '',
                                                                                    Valorar,
                                                                                    SessionDataModule.Ejercicio,
                                                                                    MesInicial,
                                                                                    MesFinal );
       InsertaRegistro( Codigo.Value, '', '', '', '', '' );
       end;
end;

begin

     ReportExistenciasTable := TnxeTable.Create( Self );
     ReportExistenciasTable.TableName := 'ReportExistencias';

     Result := SessionDataModule.CreateTemporalSQLTable( ReportExistenciasTable, SessionDataModule.Dm30.GetSQL( 'Existencias' ), ttTemporal );
     ReportExistenciasFields := TReportExistenciasFields.Create( ReportExistenciasTable );

     With DmArticuloListadoTable do
       begin

       If   TodosLosAlmacenes
       then begin
            CodigoAlmacenInicial := '';
            CodigoAlmacenFinal := HighStrCode;
            end
       else begin
            CodigoAlmacenInicial := CodigoAlmacenUnico;
            CodigoAlmacenFinal := CodigoAlmacenUnico;
            end;

       var MesInicialListado := MesInicial;
       If   MesInicialListado=0
       then MesInicialListado := 1;
       FechaInicial := EncodeDate( SessionDataModule.Ejercicio, MesInicialListado, 1 );

       var MesFinalListado := MesFinal;
       If   MesFinalListado=0
       then MesFinalListado := 1;
              FechaFinal := EncodeDate( SessionDataModule.Ejercicio, MesFinalListado, DaysInAMonth( SessionDataModule.Ejercicio, MesFinalListado ) );

       try

         case Seleccion of
           0 : begin
               IndexFieldNames := 'Codigo';
               SetRange( [ CodigoInicial ], [ CodigoFinal ] );
               end;
           1 : begin
               IndexFieldNames := 'Familia;Codigo';
               SetRange( [ CodigoInicial, '' ], [ CodigoFinal, HighStrCode ] );
               end;
           end;

         var RecCount := DmArticuloListadoTable.RecordCount;
         SessionDataModule.StartProgress( False, RecCount );
         CurrentRecordCount := 0;
         var Hundreds := RecCount div 100;

         First;
         while not Eof do
           begin

           If   ArticulosAIncluir=8   // Artículos sin movimientos del tipo ...
           then begin
                If   not SessionDataModule.Dm30.MovimientoModule.ExisteMovimientoArticulo( TipoMovimiento, DmArticuloListadoFields.Codigo.Value, FechaInicial, FechaFinal )
                then InsertaRegistroArticulo;
                end
           else With DmStockAuxTable do
                  begin

                  SetRange( [ SessionDataModule.Ejercicio, DmArticuloListadoFields.Codigo.Value, '', '', '', '', '', CodigoAlmacenInicial ],
                            [ SessionDataModule.Ejercicio, DmArticuloListadoFields.Codigo.Value, HighStrCode, HighStrCode, HighStrCode, HighStrCode, HighStrCode, CodigoAlmacenFinal   ] );

                  First;
                  If   Eof
                  then InsertaRegistroStock( True )
                  else While not Eof do
                         begin

                         With DmStockAuxFields do
                           begin

                           CodigoRegistro := CodigoArticulo.Value + CodigoClaseA.Value + CodigoClaseB.Value + CodigoClaseC.Value;
                           If   DesglosarLotes
                           then StrAdd( CodigoRegistro, LoteFabricacion.Value );
                           If   not TodosLosAlmacenes
                           then StrAdd( CodigoRegistro, CodigoAlmacen.Value );

                           If   CodigoActual<>CodigoRegistro
                           then begin
                                CodigoActual := CodigoRegistro;
                                InsertaRegistroStock;
                                end;

                             end;

                         Next;
                         end;

                  end;

           Inc( CurrentRecordCount );

           If   ( Hundreds<>0 ) and ( CurrentRecordCount mod Hundreds=0 )
           then SessionDataModule.SendProgress( 'ReportExistencias', ( CurrentRecordCount * 100 ) div RecordCount );

           Next;
           end;

       finally
         SessionDataModule.EndProgress;
         CancelRange; // DmArticuloListadoTable
         IndexFieldNames := 'Codigo';
         end;

       end;
end;

{ TStockAlmacenService }

procedure TStockAlmacenService.ActualizaStock( StockCursorID,
                                               TarifaComprasCursorID : TnxCursorID;

                                               TipoMovimiento        : TTipoMovimiento;
                                               Serie,
                                               Propietario           : String;
                                               LineaMovimiento       : ILineaMovimiento;
                                               Descontar             : Boolean = False;
                                               CantidadOperacion     : Decimal  = 0.0 );
begin
     SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( StockCursorID, TarifaComprasCursorID, TipoMovimiento, Serie, Propietario, LineaMovimiento, Descontar, CantidadOperacion );
end;

procedure TStockAlmacenService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TStockAlmacenService.ObtenCostePeriodo( CodigoArticulo,
                                                 CodigoClaseA,
                                                 CodigoClaseB,
                                                 CodigoClaseC        : String;
                                                 TodosLosLotes       : Boolean;
                                                 LoteFabricacion     : String;
                                                 TodosLosAlmacenes   : Boolean;
                                                 CodigoAlmacen       : String;
                                                 TodasLasUbicaciones : Boolean;
                                                 CodigoUbicacion     : String;
                                                 Ejercicio,
                                                 MesInicial,
                                                 MesFinal            : SmallInt ) : Decimal;
begin
     Result := SessionDataModule.Dm30.StockAlmacenModule.ObtenCostePeriodo( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, Ejercicio, MesInicial, MesFinal );
end;

function TStockAlmacenService.ListadoExistencias( TodosLosAlmacenes  : Boolean;
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
     Result := SessionDataModule.Dm30.StockAlmacenModule.ListadoExistencias( TodosLosAlmacenes, CodigoAlmacenUnico, MesInicial, MesFinal, Seleccion, CodigoInicial, CodigoFinal, ArticulosAIncluir, TipoMovimiento, Valorar, PrecioValoracion, DesglosarLotes );
end;

function TStockAlmacenService.ObtenStock( CodigoArticulo      : String;
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
                                          Ejercicio,
                                          MesInicial,
                                          MesFinal            : SmallInt ) : IExistenciasArticulo;
begin
     Result := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, ObtenCoste, Ejercicio, MesInicial, MesFinal );
end;

function TStockAlmacenService.ObtenStockFecha ( CodigoArticulo      : String;
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
                                                NroLinea            : SmallInt  ) : IExistenciasArticulo;
begin
     Result := SessionDataModule.Dm30.StockAlmacenModule.ObtenStockFecha( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, FechaStock, NroOperacion, NroPagina, NroLinea );
end;

function TStockAlmacenService.ObtenCosteFecha( CodigoArticulo      : String;
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
     Result := SessionDataModule.Dm30.StockAlmacenModule.ObtenCosteFecha( CodigoArticulo, TodasLasClases, CodigoClaseA, CodigoClaseB, CodigoClaseC, TodosLosLotes, LoteFabricacion, TodosLosAlmacenes, CodigoAlmacen, TodasLasUbicaciones, CodigoUbicacion, Fecha );
end;


var StockAlmacenControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_StockAlmacenService, TStockAlmacenService, StockAlmacenControl );

end.

