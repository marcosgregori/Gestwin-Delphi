{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cfg105;

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
     CLSID_Configuracion105Service : TGuid = '{0730CAD4-4410-411B-B929-22D846C05421}';

type

    IConfiguracion105Service = interface( ISessionModule )
      ['{B7558A4C-D70F-40AC-A738-C81439E4ED8B}']

        procedure Inicializa;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IConfiguracion105Service ) );

end.


