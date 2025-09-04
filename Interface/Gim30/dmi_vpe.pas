{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_vpe;

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

     SessionIntf;

const
     CLSID_VentasPeriodicasService : TGuid = '{E39094BE-8491-4772-9B89-BAEB1BC1E1AD}';

type

  IVentasPeriodicasService = interface( ISessionModule )
    ['{72732268-0DCD-400B-B1C3-17E7EB682000}']

    procedure GeneraVentasPeriodicas( Tipo : SmallInt; Serie, CodigoClienteInicial, CodigoClienteFinal : String; Fecha : TDate );
    end;

implementation

var Control : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IVentasPeriodicasService ) );

end.


