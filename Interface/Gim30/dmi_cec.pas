{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cec;

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

     SessionIntf;

const
     CLSID_CierreComercialService : TGuid = '{990359DC-F933-4869-ADB7-52C8B8872664}';

type

    TPrecioValoracion = ( pvCosteMedio = 0, pvUltimoCoste = 1, pvCoste = 2, pvPrecioCompra = 3 );

    ICierreComercialService = interface( ISessionModule )
     ['{91BC4FDC-DA0E-45B7-9C62-611EC2283F7D}']

      procedure EjecutaProceso( NoGenerarMovimientos : Boolean; PrecioValoracion : TPrecioValoracion; FechaInventario : TDate );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( ICierreComercialService ) );

end.


