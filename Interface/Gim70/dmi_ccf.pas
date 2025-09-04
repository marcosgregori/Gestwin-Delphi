{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_ccf;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim30Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf;

const
     CLSID_CierreCicloFabricacionService : TGuid = '{8F10D5CD-2B6D-4FDB-AE5E-AE713CCFC6A9}';

type

    ICierreCicloFabricacionService = interface( ISessionModule )
      ['{4BF3DD5E-CBFA-4435-96A9-02D5FFADBF16}']

      procedure Realizar( FechaInicial, FechaFinal : TDate; ProcesarAltasPorFabricacion, GenerarAlbaranesDeSalida : Boolean );

      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( ICierreCicloFabricacionService ) );

end.


