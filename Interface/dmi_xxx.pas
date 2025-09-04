unit dmi_xxx;

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
     CLSID_xxxService : TGuid = '{990359DC-F933-4869-ADB7-52C8B8872664}';

type

    IxxxService = interface( ISessionModule )
     ['{91BC4FDC-DA0E-45B7-9C62-611EC2283F7D}']

      procedure EjecutaProceso( Parametro : Boolean );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IxxxService ) );

end.


