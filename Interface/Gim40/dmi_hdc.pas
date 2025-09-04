{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_hdc;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf,

     Gim30Fields,
     Gim40Fields,

     HojaCargaIntf,
     LineaHojaCargaIntf,
     LineaMovimientoIntf;

const
     CLSID_HojaCargaService : TGuid = '{511DF7F4-1A06-4ABC-ACA1-43FAA9603AAE}';

type

    TPrecioValoracion = ( pvCosteMedio = 0, pvUltimoCoste = 1, pvCoste = 2, pvPrecioCompra = 3 );

    IHojaCargaService = interface( ISessionModule )
     ['{6A2E805B-AAB3-4049-9A97-D14A473C4DA0}']

      procedure Inicializa;
      function ObtenCantidadCargada( NroRegistro : LongInt ) : Decimal;
      function ProximoNroHoja( Ejercicio : SmallInt = 0 ) : LongInt;
      procedure GenerarAlbaranes( Ejercicio : SmallInt; NroHoja : LongInt; SerieAlbaran : String = ''; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
      procedure ReubicarArticulos( Ejercicio : SmallInt; NroHoja: LongInt; AlmacenDestino : String; UbicacionDestino : String; FechaInicial : TDateTime = 0; FechaFinal : TDateTime = 0 );
      function RevisaVinculos( Ejercicio : SmallInt; NroHoja : LongInt ) : Boolean;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IHojaCargaService ) );

end.



