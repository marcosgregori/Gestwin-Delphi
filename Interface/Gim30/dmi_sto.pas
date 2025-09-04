{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_sto;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf,

     dmi_mov,

     MovimientoIntf,
     LineaMovimientoIntf;

const
     CLSID_Existencias : TGuid = '{AC50B8D7-C179-43A1-BE38-B10C9FC0A817}';
     CLSID_ExistenciasArticulo : TGuid = '{5491B7BF-6B39-406F-9CA5-7EB9BCF404D0}';
     CLSID_StockAlmacenService : TGuid = '{685DA9D8-0D09-48D8-86D9-9BA0E168BAD9}';

type

    IExistencias =  interface( InxInvokable )
    ['{40139276-FB2F-4F9D-A701-56532DDFB957}']

    function GetEntradas: Decimal;
    function GetMovimientosEntradaMes(Index: SmallInt): Decimal;
    function GetMovimientosSalidaMes(Index: SmallInt): Decimal;
    function GetPendienteRecibir: Decimal;
    function GetPendienteServir: Decimal;
    function GetSaldo: Decimal;
    function GetSalidas: Decimal;
    procedure SetEntradas(const Value: Decimal);
    procedure SetMovimientosEntradaMes(Index: SmallInt; const Value: Decimal);
    procedure SetMovimientosSalidaMes(Index: SmallInt; const Value: Decimal);
    procedure SetPendienteRecibir(const Value: Decimal);
    procedure SetPendienteServir(const Value: Decimal);
    procedure SetSaldo(const Value: Decimal);
    procedure SetSalidas(const Value: Decimal);

    procedure Clear;
    procedure Add( Existencias : IExistencias );

    property PendienteRecibir : Decimal read GetPendienteRecibir write SetPendienteRecibir;
    property PendienteServir : Decimal read GetPendienteServir write SetPendienteServir;
    property MovimientosEntradaMes[ Index : SmallInt ] : Decimal read GetMovimientosEntradaMes write SetMovimientosEntradaMes;
    property MovimientosSalidaMes[ Index : SmallInt ] : Decimal read GetMovimientosSalidaMes write SetMovimientosSalidaMes;
    property Entradas : Decimal read GetEntradas write SetEntradas;
    property Salidas : Decimal read GetSalidas write SetSalidas;
    property Saldo : Decimal read GetSaldo write SetSaldo;
  end;

  TExistencias = class(TnxClass, InxRemoteableClass, IExistencias)
  private

    FCodigoArticulo,
    FCodigoClaseA,
    FCodigoClaseB,
    FCodigoClaseC,
    FLoteFabricacion,
    FCodigoAlmacen,
    FCodigoUbicacion : String;

    FFechaCaducidad : TDateTime;
    FUIDArticulo : TGuid;
    FFechaUltCompra,
    FFechaUltVenta,
    FFechaUltEntrada,
    FFechaUltEntradaCoste,
    FFechaUltSalida : TDateTime;
    FCoste,
    FCosteMedio,
    FCosteUltEntrada,
    FPrecioUltSalida,
    FPrecioUltCompra,
    FPrecioUltVenta : Decimal;

    FPendienteRecibir,
    FPendienteServir : Decimal;
    FMovimientosEntradaMes : array[ 0..12 ] of Decimal;
    FMovimientosSalidaMes : array[ 0..12 ] of Decimal;
    FEntradas,
    FSalidas,
    FSaldo : Decimal;

    function GetEntradas: Decimal;
    function GetMovimientosEntradaMes(Index: SmallInt): Decimal;
    function GetMovimientosSalidaMes(Index: SmallInt): Decimal;
    function GetPendienteRecibir: Decimal;
    function GetPendienteServir: Decimal;
    function GetSaldo: Decimal;
    function GetSalidas: Decimal;
    procedure SetEntradas(const Value: Decimal);
    procedure SetMovimientosEntradaMes(Index: SmallInt; const Value: Decimal);
    procedure SetMovimientosSalidaMes(Index: SmallInt; const Value: Decimal);
    procedure SetPendienteRecibir(const Value: Decimal);
    procedure SetPendienteServir(const Value: Decimal);
    procedure SetSaldo(const Value: Decimal);
    procedure SetSalidas(const Value: Decimal);

  public

    constructor Create;

    function GetClassID: TnxGuid;
    function LoadFromReader(AReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;

    procedure Clear;
    procedure Add( Existencias : IExistencias );

    property PendienteRecibir : Decimal read GetPendienteRecibir write SetPendienteRecibir;
    property PendienteServir : Decimal read GetPendienteServir write SetPendienteServir;
    property MovimientosEntradaMes[ Index : SmallInt ] : Decimal read GetMovimientosEntradaMes write SetMovimientosEntradaMes;
    property MovimientosSalidaMes[ Index : SmallInt ] : Decimal read GetMovimientosSalidaMes write SetMovimientosSalidaMes;
    property Entradas : Decimal read GetEntradas write SetEntradas;
    property Salidas : Decimal read GetSalidas write SetSalidas;
    property Saldo : Decimal read GetSaldo write SetSaldo;
  end;

  IExistenciasArticulo = interface( InxInvokable )
    ['{FC1284F2-D85E-4F1A-9B0E-BE6378941E8A}']

    function GetCodigoAlmacen: String;
    function GetCodigoArticulo: String;
    function GetCodigoClaseA: String;
    function GetCodigoClaseB: String;
    function GetCodigoClaseC: String;
    function GetCodigoUbicacion: String;
    function GetCoste: Decimal;
    function GetCosteMedio: Decimal;
    function GetFechaUltCompra: TDateTime;
    function GetCosteUltEntrada: Decimal;
    function GetFechaCaducidad: TDateTime;
    function GetUIDArticulo: TGuid;
    function GetFechaUltEntrada: TDateTime;
    function GetFechaUltEntradaCoste: TDateTime;
    function GetFechaUltSalida: TDateTime;
    function GetFechaUltVenta: TDateTime;
    function GetLoteFabricacion: String;
    function GetPrecioUltCompra: Decimal;
    function GetPrecioUltSalida: Decimal;
    function GetPrecioUltVenta: Decimal;
    function GetSumaExistencias: TExistencias;
    function GetUnidadesPrecioVenta: Integer;
    procedure SetCodigoAlmacen(const Value: String);
    procedure SetCodigoArticulo(const Value: String);
    procedure SetCodigoClaseA(const Value: String);
    procedure SetCodigoClaseB(const Value: String);
    procedure SetCodigoClaseC(const Value: String);
    procedure SetCodigoUbicacion(const Value: String);
    procedure SetCoste(const Value: Decimal);
    procedure SetCosteMedio(const Value: Decimal);
    procedure SetFechaUltCompra(const Value: TDateTime);
    procedure SetCosteUltEntrada(const Value: Decimal);
    procedure SetFechaCaducidad(const Value: TDateTime);
    procedure SetUIDArticulo(const Value: TGuid);
    procedure SetFechaUltEntrada(const Value: TDateTime);
    procedure SetFechaUltEntradaCoste(const Value: TDateTime);
    procedure SetFechaUltSalida(const Value: TDateTime);
    procedure SetFechaUltVenta(const Value: TDateTime);
    procedure SetLoteFabricacion(const Value: String);
    procedure SetPrecioUltCompra(const Value: Decimal);
    procedure SetPrecioUltSalida(const Value: Decimal);
    procedure SetPrecioUltVenta(const Value: Decimal);
    procedure SetSumaExistencias(const Value: TExistencias);
    procedure SetUnidadesPrecioVenta(const Value: Integer);

    procedure Clear;

    property CodigoArticulo : String read GetCodigoArticulo write SetCodigoArticulo;
    property CodigoClaseA : String read GetCodigoClaseA write SetCodigoClaseA;
    property CodigoClaseB : String read GetCodigoClaseB write SetCodigoClaseB;
    property CodigoClaseC : String read GetCodigoClaseC write SetCodigoClaseC;
    property LoteFabricacion : String read GetLoteFabricacion write SetLoteFabricacion;
    property CodigoAlmacen : String read GetCodigoAlmacen write SetCodigoAlmacen;
    property CodigoUbicacion : String read GetCodigoUbicacion write SetCodigoUbicacion;

    property FechaCaducidad : TDateTime read GetFechaCaducidad write SetFechaCaducidad;
    property UIDArticulo : TGuid read GetUIDArticulo write SetUIDArticulo;
    property FechaUltCompra : TDateTime read GetFechaUltCompra write SetFechaUltCompra;
    property FechaUltVenta : TDateTime read GetFechaUltVenta write SetFechaUltVenta;
    property FechaUltEntrada : TDateTime read GetFechaUltEntrada write SetFechaUltEntrada;
    property FechaUltEntradaCoste : TDateTime read GetFechaUltEntradaCoste write SetFechaUltEntradaCoste;
    property FechaUltSalida : TDateTime read GetFechaUltSalida write SetFechaUltSalida;

    property UnidadesPrecioVenta : Integer read GetUnidadesPrecioVenta write SetUnidadesPrecioVenta;

    property Coste : Decimal read GetCoste write SetCoste;
    property CosteMedio : Decimal read GetCosteMedio write SetCosteMedio;
    property CosteUltEntrada : Decimal read GetCosteUltEntrada write SetCosteUltEntrada;
    property PrecioUltSalida : Decimal read GetPrecioUltSalida write SetPrecioUltSalida;
    property PrecioUltCompra : Decimal read GetPrecioUltCompra write SetPrecioUltCompra;
    property PrecioUltVenta : Decimal read GetPrecioUltVenta write SetPrecioUltVenta;

    property SumaExistencias : TExistencias read GetSumaExistencias Write SetSumaExistencias;

    end;

  TExistenciasArticulo = class(TnxClass, InxRemoteableClass, IExistenciasArticulo )
  private

    FCodigoArticulo,
    FCodigoClaseA,
    FCodigoClaseB,
    FCodigoClaseC,
    FLoteFabricacion,
    FCodigoAlmacen,
    FCodigoUbicacion : String;

    FFechaCaducidad : TDateTime;
    FUIDArticulo : TGuid;
    FFechaUltCompra,
    FFechaUltVenta,
    FFechaUltEntrada,
    FFechaUltEntradaCoste,
    FFechaUltSalida : TDateTime;
    FUnidadesPrecioVenta : Integer;
    FCoste,
    FCosteMedio,
    FCosteUltEntrada,
    FPrecioUltSalida,
    FPrecioUltCompra,
    FPrecioUltVenta : Decimal;

    FSumaExistencias : TExistencias;

    function GetCodigoAlmacen: String;
    function GetCodigoArticulo: String;
    function GetCodigoClaseA: String;
    function GetCodigoClaseB: String;
    function GetCodigoClaseC: String;
    function GetCodigoUbicacion: String;
    function GetCoste: Decimal;
    function GetCosteMedio: Decimal;
    function GetCosteUltEntrada: Decimal;
    function GetFechaCaducidad: TDateTime;
    function GetUIDArticulo: TGuid;
    function GetFechaUltCompra: TDateTime;
    function GetFechaUltEntrada: TDateTime;
    function GetFechaUltEntradaCoste: TDateTime;
    function GetFechaUltSalida: TDateTime;
    function GetFechaUltVenta: TDateTime;
    function GetLoteFabricacion: String;
    function GetPrecioUltCompra: Decimal;
    function GetPrecioUltSalida: Decimal;
    function GetPrecioUltVenta: Decimal;
    function GetSumaExistencias: TExistencias;
    function GetUnidadesPrecioVenta: Integer;
    procedure SetCodigoAlmacen(const Value: String);
    procedure SetCodigoArticulo(const Value: String);
    procedure SetCodigoClaseA(const Value: String);
    procedure SetCodigoClaseB(const Value: String);
    procedure SetCodigoClaseC(const Value: String);
    procedure SetCodigoUbicacion(const Value: String);
    procedure SetCoste(const Value: Decimal);
    procedure SetCosteMedio(const Value: Decimal);
    procedure SetCosteUltEntrada(const Value: Decimal);
    procedure SetFechaCaducidad(const Value: TDateTime);
    procedure SetUIDArticulo(const Value: TGuid);
    procedure SetFechaUltCompra(const Value: TDateTime);
    procedure SetFechaUltEntrada(const Value: TDateTime);
    procedure SetFechaUltEntradaCoste(const Value: TDateTime);
    procedure SetFechaUltSalida(const Value: TDateTime);
    procedure SetFechaUltVenta(const Value: TDateTime);
    procedure SetLoteFabricacion(const Value: String);
    procedure SetPrecioUltCompra(const Value: Decimal);
    procedure SetPrecioUltSalida(const Value: Decimal);
    procedure SetPrecioUltVenta(const Value: Decimal);
    procedure SetSumaExistencias(const Value: TExistencias);
    procedure SetUnidadesPrecioVenta(const Value: Integer);

  public

    constructor Create;
    destructor Destroy; override;

    procedure Clear;

    function GetClassID: TnxGuid;
    function LoadFromReader(AReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;

    property CodigoArticulo : String read GetCodigoArticulo write SetCodigoArticulo;
    property CodigoClaseA : String read GetCodigoClaseA write SetCodigoClaseA;
    property CodigoClaseB : String read GetCodigoClaseB write SetCodigoClaseB;
    property CodigoClaseC : String read GetCodigoClaseC write SetCodigoClaseC;
    property LoteFabricacion : String read GetLoteFabricacion write SetLoteFabricacion;
    property CodigoAlmacen : String read GetCodigoAlmacen write SetCodigoAlmacen;
    property CodigoUbicacion : String read GetCodigoUbicacion write SetCodigoUbicacion;

    property FechaCaducidad : TDateTime read GetFechaCaducidad write SetFechaCaducidad;
    property UIDArticulo : TGuid read GetUIDArticulo write SetUIDArticulo;
    property FechaUltCompra : TDateTime read GetFechaUltCompra write SetFechaUltCompra;
    property FechaUltVenta : TDateTime read GetFechaUltVenta write SetFechaUltVenta;
    property FechaUltEntrada : TDateTime read GetFechaUltEntrada write SetFechaUltEntrada;
    property FechaUltEntradaCoste : TDateTime read GetFechaUltEntradaCoste write SetFechaUltEntradaCoste;
    property FechaUltSalida : TDateTime read GetFechaUltSalida write SetFechaUltSalida;

    property UnidadesPrecioVenta : Integer read GetUnidadesPrecioVenta write SetUnidadesPrecioVenta;

    property Coste : Decimal read GetCoste write SetCoste;
    property CosteMedio : Decimal read GetCosteMedio write SetCosteMedio;
    property CosteUltEntrada : Decimal read GetCosteUltEntrada write SetCosteUltEntrada;
    property PrecioUltSalida : Decimal read GetPrecioUltSalida write SetPrecioUltSalida;
    property PrecioUltCompra : Decimal read GetPrecioUltCompra write SetPrecioUltCompra;
    property PrecioUltVenta : Decimal read GetPrecioUltVenta write SetPrecioUltVenta;

    property SumaExistencias : TExistencias read GetSumaExistencias Write SetSumaExistencias;

    end;

  IStockAlmacenService = interface( ISessionModule )
    ['{CBE91267-0CAE-45AB-9ECF-2E0B73896AD4}']

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
                                 Ejercicio           : SmallInt;
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

implementation

uses  Variants;

{ TExistencias }

function TExistencias.GetClassID: TnxGuid;
begin
     Result := CLSID_Existencias;
end;

function TExistencias.GetEntradas: Decimal;
begin
     Result := FEntradas;
end;

function TExistencias.GetMovimientosEntradaMes( Index : SmallInt ) : Decimal;
begin
     Result := FMovimientosEntradaMes[ Index ];
end;

function TExistencias.GetMovimientosSalidaMes(Index: SmallInt): Decimal;
begin
     Result := FMovimientosSalidaMes[ Index ];
end;

function TExistencias.GetPendienteRecibir: Decimal;
begin
     Result := FPendienteRecibir;
end;

function TExistencias.GetPendienteServir: Decimal;
begin
     Result := FPendienteServir;
end;

function TExistencias.GetSaldo: Decimal;
begin
     Result := FSaldo;
end;

function TExistencias.GetSalidas: Decimal;
begin
     Result := FSalidas;
end;

procedure TExistencias.Clear;

var  I : SmallInt;

begin
     FPendienteRecibir := 0.0;
     FPendienteServir := 0.0;
     For I := 0 to 12 do
       begin
       FMovimientosEntradaMes[ I ] := 0.0;
       FMovimientosSalidaMes[ I ] := 0.0;
       end;
     FEntradas := 0.0;
     FSalidas := 0.0;
     FSaldo := 0.0;
end;

constructor TExistencias.Create;
begin
     inherited Create( @CLSID_Existencias, nil, nil, False);
end;

procedure TExistencias.Add( Existencias : IExistencias );

var  I : SmallInt;

begin
     FPendienteRecibir := FPendienteRecibir + Existencias.PendienteRecibir;
     FPendienteServir := FPendienteServir + Existencias.PendienteServir;
     For I := 0 to 12 do
       begin
       FMovimientosEntradaMes[ I ] := FMovimientosEntradaMes[ I ] + Existencias.MovimientosEntradaMes[ I ];
       FMovimientosSalidaMes[ I ] := FMovimientosSalidaMes[ I ] + Existencias.MovimientosSalidaMes[ I ];
       end;
     FEntradas := FEntradas + Existencias.Entradas;
     FSalidas := FSalidas + Existencias.Salidas;
     FSaldo := FSaldo + Existencias.Saldo;
end;

function TExistencias.LoadFromReader( AReader : InxReader ) : HRESULT;

var  I : SmallInt;

begin
     With AReader do
       begin
       FPendienteRecibir := ReadCurrency;
       FPendienteServir := ReadCurrency;
       For I := 0 to 12 do
         begin
         FMovimientosEntradaMes[ I ] := ReadCurrency;
         FMovimientosSalidaMes[ I ] := ReadCurrency;
         end;
       FEntradas := ReadCurrency;
       FSalidas := ReadCurrency;
       FSaldo := ReadCurrency;
       end;
end;

function TExistencias.SaveToWriter( AWriter : InxWriter) : HRESULT;


var  I : SmallInt;

begin
     With AWriter do
       begin
       WriteCurrency( FPendienteRecibir );
       WriteCurrency( FPendienteServir );
       For I := 0 to 12 do
         begin
         WriteCurrency( FMovimientosEntradaMes[ I ] );
         WriteCurrency( FMovimientosSalidaMes[ I ] );
         end;
       WriteCurrency( FEntradas );
       WriteCurrency( FSalidas );
       WriteCurrency( FSaldo );
       end;
end;

procedure TExistencias.SetEntradas(const Value: Decimal);
begin
     FEntradas := Value;
end;

procedure TExistencias.SetMovimientosEntradaMes( Index : SmallInt; const Value : Decimal );
begin
     FMovimientosEntradaMes[ Index ] := Value;
end;

procedure TExistencias.SetMovimientosSalidaMes( Index : SmallInt; const Value : Decimal );
begin
     FMovimientosSalidaMes[ Index ] := Value;
end;

procedure TExistencias.SetPendienteRecibir(const Value: Decimal);
begin
     FPendienteRecibir := Value;
end;

procedure TExistencias.SetPendienteServir(const Value: Decimal);
begin
     FPendienteServir := Value;
end;

procedure TExistencias.SetSaldo(const Value: Decimal);
begin
     FSaldo := Value;
end;

procedure TExistencias.SetSalidas(const Value: Decimal);
begin
     FSalidas := Value;
end;

{ TExistenciasArticulo }

procedure TExistenciasArticulo.Clear;
begin
     FCodigoArticulo := '';
     FCodigoClaseA := '';
     FCodigoClaseB := '';
     FCodigoClaseC := '';
     FLoteFabricacion := '';
     FCodigoAlmacen := '';
     FCodigoUbicacion := '';

     FFechaCaducidad := 0;
     FUIDArticulo := TGuid.Empty;
     FFechaUltCompra := 0;
     FFechaUltVenta := 0;
     FFechaUltEntrada := 0;
     FFechaUltEntradaCoste := 0;
     FFechaUltSalida := 0;

     FUnidadesPrecioVenta := 0;

     FCoste := 0.0;
     FCosteMedio := 0.0;
     FCosteUltEntrada := 0.0;
     FPrecioUltSalida := 0.0;
     FPrecioUltCompra := 0.0;
     FPrecioUltVenta := 0.0;

     FSumaExistencias.Clear;
end;

constructor TExistenciasArticulo.Create;
begin
     inherited Create( @CLSID_ExistenciasArticulo, nil, nil, False);
     FSumaExistencias := TExistencias.Create;
end;

destructor TExistenciasArticulo.Destroy;
begin
     FreeAndNil( FSumaExistencias );
     inherited;
end;

function TExistenciasArticulo.GetClassID: TnxGuid;
begin
     Result := CLSID_ExistenciasArticulo;
end;

function TExistenciasArticulo.GetCodigoAlmacen: String;
begin
     Result := FCodigoAlmacen;
end;

function TExistenciasArticulo.GetCodigoArticulo: String;
begin
     Result := FCodigoArticulo;
end;

function TExistenciasArticulo.GetCodigoClaseA: String;
begin
     Result := FCodigoClaseA;
end;

function TExistenciasArticulo.GetCodigoClaseB: String;
begin
     Result := FCodigoClaseB;
end;

function TExistenciasArticulo.GetCodigoClaseC: String;
begin
     Result := FCodigoClaseC;
end;

function TExistenciasArticulo.GetCodigoUbicacion: String;
begin
     Result := FCodigoUbicacion;
end;

function TExistenciasArticulo.GetCoste: Decimal;
begin
     Result := FCoste;
end;

function TExistenciasArticulo.GetCosteMedio: Decimal;
begin
     Result := FCosteMedio;
end;

function TExistenciasArticulo.GetCosteUltEntrada: Decimal;
begin
     Result := FCosteUltEntrada;
end;

function TExistenciasArticulo.GetFechaUltCompra: TDateTime;
begin
     Result := FFechaUltCompra;
end;

function TExistenciasArticulo.GetFechaCaducidad: TDateTime;
begin
     Result := FFechaCaducidad;
end;

function TExistenciasArticulo.GetUIDArticulo: TGuid;
begin
     Result := FUIDArticulo;
end;

function TExistenciasArticulo.GetFechaUltEntrada: TDateTime;
begin
     Result := FFechaUltEntrada;
end;

function TExistenciasArticulo.GetFechaUltEntradaCoste: TDateTime;
begin
     Result := FFechaUltEntradaCoste
end;

function TExistenciasArticulo.GetFechaUltSalida: TDateTime;
begin
     Result := FFechaUltSalida;
end;

function TExistenciasArticulo.GetFechaUltVenta: TDateTime;
begin
     Result := FFechaUltVenta;
end;

function TExistenciasArticulo.GetLoteFabricacion: String;
begin
     Result := FLoteFabricacion;
end;

function TExistenciasArticulo.GetPrecioUltCompra: Decimal;
begin
     Result := FPrecioUltCompra;
end;

function TExistenciasArticulo.GetPrecioUltSalida: Decimal;
begin
     Result := FPrecioUltSalida;
end;

function TExistenciasArticulo.GetPrecioUltVenta: Decimal;
begin
     Result := FPrecioUltVenta;
end;

function TExistenciasArticulo.GetSumaExistencias: TExistencias;
begin
     Result := FSumaExistencias;
end;

function TExistenciasArticulo.GetUnidadesPrecioVenta: Integer;
begin
     Result := FUnidadesPrecioVenta;
end;

function TExistenciasArticulo.LoadFromReader(AReader: InxReader): HRESULT;
begin
     With AReader do
       begin

       FCodigoArticulo := ReadString;
       FCodigoClaseA := ReadString;
       FCodigoClaseB := ReadString;
       FCodigoClaseC := ReadString;
       FLoteFabricacion := ReadString;
       FCodigoAlmacen := ReadString;
       FCodigoUbicacion := ReadString;

       FFechaCaducidad := ReadDate;
       FUIDArticulo := ReadGuid;
       FFechaUltCompra := ReadDate;
       FFechaUltVenta := ReadDate;
       FFechaUltEntrada := ReadDate;
       FFechaUltEntradaCoste := ReadDate;
       FFechaUltSalida := ReadDate;

       FUnidadesPrecioVenta := ReadInteger;

       FCoste := ReadCurrency;
       FCosteMedio := ReadCurrency;
       FCosteUltEntrada := ReadCurrency;
       FPrecioUltSalida := ReadCurrency;
       FPrecioUltCompra := ReadCurrency;
       FPrecioUltVenta := ReadCurrency;

       If   not Assigned( FSumaExistencias )
       then FSumaExistencias := TExistencias.Create;

       FSumaExistencias.LoadFromReader( AReader );
       end;
     Result := S_OK;
end;

function TExistenciasArticulo.SaveToWriter(AWriter: InxWriter): HRESULT;
begin
     With AWriter do
       begin

       WriteString( FCodigoArticulo );
       WriteString( FCodigoClaseA );
       WriteString( FCodigoClaseB );
       WriteString( FCodigoClaseC );
       WriteString( FLoteFabricacion );
       WriteString( FCodigoAlmacen );
       WriteString( FCodigoUbicacion );

       WriteDate( FFechaCaducidad );
       WriteGuid( FUIDArticulo );
       WriteDate( FFechaUltCompra );
       WriteDate( FFechaUltVenta );
       WriteDate( FFechaUltEntrada );
       WriteDate( FFechaUltEntradaCoste );
       WriteDate( FFechaUltSalida );

       WriteInteger( FUnidadesPrecioVenta );

       WriteCurrency( FCoste );
       WriteCurrency( FCosteMedio );
       WriteCurrency( FCosteUltEntrada );
       WriteCurrency( FPrecioUltSalida );
       WriteCurrency( FPrecioUltCompra );
       WriteCurrency( FPrecioUltVenta );

       FSumaExistencias.SaveToWriter( AWriter );
       end;
     Result := S_OK;
end;

procedure TExistenciasArticulo.SetCodigoAlmacen(const Value: String);
begin
     FCodigoAlmacen := Value;
end;

procedure TExistenciasArticulo.SetCodigoArticulo(const Value: String);
begin
     FCodigoArticulo := Value;
end;

procedure TExistenciasArticulo.SetCodigoClaseA(const Value: String);
begin
     FCodigoClaseA := Value;
end;

procedure TExistenciasArticulo.SetCodigoClaseB(const Value: String);
begin
     FCodigoClaseB := Value;
end;

procedure TExistenciasArticulo.SetCodigoClaseC(const Value: String);
begin
     FCodigoClaseC := Value;
end;

procedure TExistenciasArticulo.SetCodigoUbicacion(const Value: String);
begin
     FCodigoUbicacion := Value;
end;

procedure TExistenciasArticulo.SetCoste(const Value: Decimal);
begin
     FCoste := Value;
end;

procedure TExistenciasArticulo.SetCosteMedio(const Value: Decimal);
begin
     FCosteMedio := Value;
end;

procedure TExistenciasArticulo.SetCosteUltEntrada(const Value: Decimal);
begin
     FCosteUltEntrada := Value;
end;

procedure TExistenciasArticulo.SetFechaUltCompra(const Value: TDateTime);
begin
     FFechaUltCompra := Value;
end;

procedure TExistenciasArticulo.SetFechaCaducidad(const Value: TDateTime);
begin
     FFechaCaducidad := Value;
end;

procedure TExistenciasArticulo.SetUIDArticulo(const Value: TGuid );
begin
     FUIDArticulo := Value;
end;

procedure TExistenciasArticulo.SetFechaUltEntrada(const Value: TDateTime);
begin
     FFechaUltEntrada := Value;
end;

procedure TExistenciasArticulo.SetFechaUltEntradaCoste(const Value: TDateTime);
begin
     FFechaUltEntradaCoste := Value;
end;

procedure TExistenciasArticulo.SetFechaUltSalida(const Value: TDateTime);
begin
     FFechaUltSalida := Value;
end;

procedure TExistenciasArticulo.SetFechaUltVenta(const Value: TDateTime);
begin
     FFechaUltVenta := Value;
end;

procedure TExistenciasArticulo.SetLoteFabricacion(const Value: String);
begin
     FLoteFabricacion := Value;
end;

procedure TExistenciasArticulo.SetPrecioUltCompra(const Value: Decimal);
begin
     FPrecioUltCompra := Value;
end;

procedure TExistenciasArticulo.SetPrecioUltSalida(const Value: Decimal);
begin
     FPrecioUltSalida := Value;
end;

procedure TExistenciasArticulo.SetPrecioUltVenta(const Value: Decimal);
begin
     FPrecioUltVenta := Value;
end;

procedure TExistenciasArticulo.SetSumaExistencias(const Value: TExistencias);
begin
     FSumaExistencias := Value;
end;

procedure TExistenciasArticulo.SetUnidadesPrecioVenta(const Value: Integer);
begin
     FUnidadesPrecioVenta := Value;
end;

var ExistenciasControl,
    ExistenciasArticuloControl : InxClassFactoryControl;

initialization

     nxInvokeRegistry.RegisterInterface( TypeInfo( IExistencias ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( IExistenciasArticulo ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( IStockAlmacenService ) );

     TnxClassFactory.RegisterClass( CLSID_Existencias, TExistencias, ExistenciasControl );
     TnxClassFactory.RegisterClass( CLSID_ExistenciasArticulo, TExistenciasArticulo, ExistenciasArticuloControl );
end.


