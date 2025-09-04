unit nxifFileSettings;

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
     CLSID_FileSettingsService : TGuid = '{E4BA2E44-FCE6-4286-A025-93CC768FD94D}';

type

    IFileSettingsService = interface( IStateComponentService )
      ['{10B9E1E5-6359-4CF5-84BD-954BFB46E223}']

      function GetPort: integer;
      function GetInternalAddresses : String;

      procedure SetPort(const Value: integer);
      procedure SetInternalAddresses( const Value : String );

      property Port: integer read GetPort write SetPort;
      property InternalAddresses : String read GetInternalAddresses write SetInternalAddresses;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IFileSettingsService ) );

end.


