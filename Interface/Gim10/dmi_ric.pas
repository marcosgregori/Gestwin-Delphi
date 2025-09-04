{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ric;

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
     CLSID_RegularizacionIVAService : TGuid = '{281B9659-2DC6-4177-95D0-46FD75A51575}';

type

  IRegularizacionIVAService = interface( ISessionModule )
    ['{9A7AEBFF-5669-431F-861D-17F66F9C24A1}']

    procedure EjecutaProceso( Fecha : TDate );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IRegularizacionIVAService ) );

end.


