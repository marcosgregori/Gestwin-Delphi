{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ecp;

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

     EfectoPagarIntf;

const
     CLSID_EfectoPagarService : TGuid = '{38DE11C3-12D2-4D94-A34E-178374876DD2}';

type

  IEfectoPagarService = interface( ISessionModule )
    ['{0FB06F2C-CDC0-4BBF-AAD9-FD6D2BE2A5EF}']

    procedure ActualizaEfectoPagar( EfectoPagar : IEfectoPagar );
    procedure SuprimeEfectoPagar( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura: String; NroEfecto : SmallInt );

    procedure ActualizaAnotacionPago( EfectoPagar: IEfectoPagar );
    procedure SuprimeAnotacionPago( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; NroEfecto : SmallInt );

    function GeneraEfectos( NroAsiento : LongInt; SubcuentaProveedor, CodigoFormaPago : String; Importe : Decimal ) : Boolean;
    procedure CopiaFacturaRecibida( Ejercicio : SmallInt; NroAsiento : LongInt; PropietarioDestino : String; SerieNroFacturaDestino : String; BorrarFacturaOrigen : Boolean = False );
    function  EfectoPendiente( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura: String; NroEfecto : SmallInt ) : Boolean; overload;
    function  ImportePendienteFactura( Ejercicio : SmallInt; Propietario : String; SerieNroFactura : String; var ImporteEfectos, ImportePendiente : Decimal ) : Boolean;
    function CompruebaEfectos( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String; SuprimirEfectos : Boolean = False) : Boolean;
    procedure SuprimeEfectosFactura( Ejercicio : SmallInt; SubcuentaProveedor : String; SerieNroFactura : String );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IEfectoPagarService ) );

end.


