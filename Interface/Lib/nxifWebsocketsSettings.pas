unit nxifWebsocketsSettings;

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
     CLSID_WebsocketsSettingsService : TGuid = '{D49B80A0-8A9C-41A2-A021-963076ECE493}';

type

    IWebsocketsSettingsService = interface( IStateComponentService )
      ['{143B94A8-2AAF-44DD-8BDD-065C70689D72}']

      function GetPort: integer;
      procedure SetPort(const Value: integer);

      property Port: integer read GetPort write SetPort;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IWebsocketsSettingsService ) );

end.


