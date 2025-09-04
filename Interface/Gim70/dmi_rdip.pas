{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rdip;

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
     CLSID_ReconstruccionDatosInternosService : TGuid = '{1D194194-726C-46AC-96E7-BA5D79E65E0A}';

type

    IReconstruccionDatosInternosService = interface( ISessionModule )
      ['{D7216645-F77B-4512-8D2E-4E88B244A0D6}']

      procedure Reconstruccion;
      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IReconstruccionDatosInternosService ) );

end.


