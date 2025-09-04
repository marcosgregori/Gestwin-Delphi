{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ecc;

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

     EfectoCobrarIntf,
     RemesaIntf;

const
     CLSID_EfectoCobrarService : TGuid = '{62C0BB7E-C76E-4D8C-AAA2-69AAF6C9AF1D}';

type

  IEfectoCobrarService = interface( ISessionModule )
    ['{1209105C-7C67-4105-B2D7-D4160010BC55}']

    procedure ActualizaEfectoCobrar( EfectoCobrar : IEfectoCobrar );
    procedure SuprimeEfectoCobrar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaAnotacionCobro( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeAnotacionCobro( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaAnotacionImpagado( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeAnotacionImpagado( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    procedure ActualizaCancelacion( EfectoCobrar: IEfectoCobrar );
    procedure SuprimeCancelacion( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt );

    function  EfectoPendiente( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt; IncluirEfectosRemesados : Boolean = True ) : Boolean;
    function  FechaCobro( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; NroEfecto : SmallInt ) : TDate;
    function  CompruebaEfectos( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; SuprimirEfectos : Boolean = False ) : Boolean;
    function  GeneraEfectos( NroAsiento : LongInt; SubcuentaCliente, CodigoFormaCobro : String; Importe : Decimal ) : Boolean;
    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IEfectoCobrarService ) );

end.


