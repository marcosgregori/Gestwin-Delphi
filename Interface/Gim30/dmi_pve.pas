{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_pve;

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
     CLSID_PreventaService : TGuid = '{6A5C92B6-F2D4-4365-A990-399526587343}';

type

  TTipoProcesoCierre = ( tpcCierreApertura, tpcApertura, tpcTraspaso );

  IPreventaService = interface( ISessionModule )
    ['{8CAEAF14-F293-45B8-95B9-6BA4D180D005}']

    procedure GeneraConsumos( ClienteInicial, ClienteFinal : String; FechaInicial, FechaFinal : TDate; UltimoPrecioDefecto, UltimoDescuentoDefecto : Boolean; Maximo : SmallInt; CantidadMinima : Decimal; Ordenacion : SmallInt );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IPreventaService ) );

end.


