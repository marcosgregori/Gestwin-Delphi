{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rda;

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
     CLSID_RenumeracionAsientosService : TGuid = '{E45312DB-4A81-42E5-9B48-B18BAFE6903D}';

type

  IRenumeracionAsientosService = interface( ISessionModule )
    ['{7BB26F2C-8A24-4EEC-A108-040C08879CBD}']

    procedure EjecutaProceso( PrimerNumeroAsiento : LongInt );
    end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IRenumeracionAsientosService ) );

end.


