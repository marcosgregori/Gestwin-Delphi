unit nxifAndroidSettings;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     nxwsBaseWebServer,

     nxifStateComponent;

const
     CLSID_AndroidSettingsService : TGuid = '{947CA60C-FF09-42DF-9D90-91A2495C2773}';

type

    IAndroidSettingsService = interface( IStateComponentService )
      ['{1ECC842D-9B4B-4C64-8A68-1DE3C7F2222A}']

      function GetPort: integer;
      procedure SetPort(const Value: integer);

      property Port: integer read GetPort write SetPort;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IAndroidSettingsService ) );

end.


