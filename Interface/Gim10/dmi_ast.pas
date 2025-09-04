{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ast;

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

     AsientoIntf,
     ApunteIntf;

const

     CLSID_AsientoService : TnxGuid = '{7ABAABE3-7B71-4E7B-9C21-193D498E6CF5}';

     // Tipos de asiento

     taApertura          = 1;
     taOrdinario         = 2;
     taRegularizacion    = 3;
     taCierre            = 4;
     taFraEmitida        = 5;
     taFraRecibida       = 6;
     taCobro             = 7;
     taPago              = 8;
     taDescuento         = 9;
     taCancelacion       = 10;
     taCobroRemesa       = 11;
     taAmortizacion      = 12;
     taCancelacionEfecto = 13;
     taImpagado          = 14;
     taPagoRemesa        = 15;
     taMovimientoCaja    = 16;
     taCartera           = 17;
     taAceptacion        = 18;
     taRegularizacionIVA = 19;

     // Tipos de apunte

     tapManual           = 0;
     tapCuotaIVA         = 1;
     tapRetencion        = 2;
     tapTraspasoIVA      = 3;

type

    TTipoAsiento = taApertura..taAceptacion;

    TOnCompletaActualizacionAsiento = reference to procedure ( AsientoFields : TAsientoFields );
    TOnCompletaActualizacionApunte = reference to procedure ( ApunteFields : TApunteFields );
    TOnCompletaSupresionApunte = reference to procedure ( ApunteFields : TApunteFields );

    IAsientoService = interface( ISessionModule )
      ['{DF5F1CB8-F208-438B-ABBD-EE764F550445}']

      function ExisteAsientoContador( NroAsiento : LongInt ) : Boolean;
      function ProximoNroAsiento : LongInt;
      function ProximoNroRegistro( TipoDocumento : SmallInt; ResetCounter : Boolean = False ) : LongInt;
      function ObtenImportesFactura( Ejercicio : SmallInt; NroAsiento : LongInt; var BaseImponible, CuotaIVA, CuotaRE, ImporteTotal : Decimal ) : Boolean;
      function ImporteCobrosEfectivo( Subcuenta : String; FechaInicial, FechaFinal : TDateTime; Cargos  : Boolean ) : Decimal;

      function ExistenApuntesTraspasoIVA( Ejercicio : SmallInt = 0 ) : Boolean;

      procedure ActualizaAsiento( Asiento : IAsiento );
      procedure SuprimeAsiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt ); overload;

      function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; PreservaCabecera : Boolean ) : Boolean; overload;
      function SuprimeAsiento( Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : SmallInt; FechaDocumento : TDate; SubcuentaPropietario : String; Serie : String; NroDocumento : LongInt; NroEfecto : SmallInt;  PreservaCabecera : Boolean = False ) : Boolean; overload;

      function CopiaAsiento( Ejercicio  : SmallInt; NroAsiento : LongInt; Fecha : TDate ) : Boolean;

      procedure ActualizaApunte( TipoAsiento : TTipoAsiento; Apunte : IApunte );
      procedure SuprimeApunte( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt; TipoAsiento : TTipoAsiento; NroApunte : SmallInt );

      procedure ActualizaFactura( Asiento            : IAsiento;
                                  ConceptoFactura    : String;
                                  SubcuentaRetencion : String;
                                  TipoRetencion      : SmallInt;
                                  BaseRetencion,
                                  ImporteRetencion   : Decimal );

      procedure SuprimeFacturaEmitida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );
      procedure SuprimeFacturaRecibida( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroAsiento : LongInt );

      procedure ActualizaApunteFactura( Asiento : IAsiento; Apunte  : IApunte );

      procedure SuprimeApunteFactura( Asiento : IAsiento; Apunte : IApunte );
     
      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IAsientoService ) );

end.



