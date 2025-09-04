{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_cri116;

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
     CLSID_Cristaleria116Service : TGuid = '{413FE478-D38C-4838-BE16-8CBA1CC479AB}';

type

    ICristaleria116Service = interface( ISessionModule )
      ['{2AA562C2-E633-45D6-A2B9-B7255CAD831E}']

      procedure Inicializa;

      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( ICristaleria116Service ) );

end.


