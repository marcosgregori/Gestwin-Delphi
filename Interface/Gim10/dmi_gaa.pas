{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_gaa;

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
     CLSID_GeneracionAmortizacionesService : TGuid = '{CAF00CA9-98F8-4D3B-A407-B3942C01824E}';

type

  TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

  IGeneracionAmortizacionesService = interface( ISessionModule )
    ['{80567C6E-8ADB-4048-8EFC-9004259091F6}']

    procedure EjecutaProceso( FechaAmortizacion : TDate );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IGeneracionAmortizacionesService ) );

end.


