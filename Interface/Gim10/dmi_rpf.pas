{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_rpf;

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
     CLSID_RegistroPresentacionService : TGuid = '{432CC281-ED47-4FEC-AFFF-7D29AC56B885}';

type

    IRegistroPresentacionService = interface( ISessionModule )
      ['{1688CBC3-F649-465B-96FB-4ECEF972C2ED}']

      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IRegistroPresentacionService ) );

end.


