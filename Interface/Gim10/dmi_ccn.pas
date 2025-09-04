{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ccn;

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
     CLSID_CierreContableService : TGuid = '{685FEC71-249A-4CF0-9401-47902EB08280}';

type

    TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

    ICierreContableService = interface( ISessionModule )
      ['{2ADD2878-51BC-4C60-A488-0D074591872A}']

      procedure EjecutaProceso( TipoProceso: TTipoProcesoCierre; FechaCierre, FechaApertura: TDate );
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( ICierreContableService ) );

end.


