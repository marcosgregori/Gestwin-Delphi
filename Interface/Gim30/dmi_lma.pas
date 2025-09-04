{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_lma;

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

     MovimientoIntf,
     LineaMovimientoIntf;

const
     CLSID_ListaMaterialesService : TGuid = '{706A646E-A335-4E0D-9921-7EC7C6769E26}';

type

  IListaMaterialesService = interface( ISessionModule )
    ['{089B82FC-48E4-4D6B-915A-01C4B73D772D}']

    procedure AplicarDesglose( Movimiento      : IMovimiento;
                               LineaMovimiento : ILineaMovimiento );
    end;

implementation

var Control : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IListaMaterialesService ) );

end.


