unit nxifBaseSettings;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,

     nxllComponent,
     nxllTypes,
     nxllStreams,
     nxivTypes,
     nxrdClass,
     nxrbTypes;

type
    IBaseSettingsService = interface( InxInvokable )

      function GetDisplayName: String;
      procedure SetDisplayName(const Value: String);
      function GetVersion : String;
      procedure SetVersion( const Value: String );

      procedure Refresh;
      procedure DoApply;

      property Version : String read GetVersion write SetVersion;
      property DisplayName : String read GetDisplayName write SetDisplayName;

      end;

implementation


initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IBaseSettingsService ) );

end.




