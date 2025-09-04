unit nxifRemoteAdminSettings;

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

     nxwsBaseWebServer;

const
     CLSID_RemoteAdministrationService : TGuid = '{0417E725-2DF2-4637-B0F2-BA6E1B3B779A}';

type

    IRemoteAdminSettingsService = interface( InxInvokable )
      ['{325BAB69-CFD8-4C14-961E-5EDBE70550FD}']

      function GetPort: integer;
      procedure SetPort(const Value: integer);
      function GetAuthenticationMethod: String;
      procedure SetAuthenticationMethod(const Value: String);

      procedure Authenticate(Sender: TnxBaseWebServer; aRequest: TnxHTTPRequest; const UserName, Password: UnicodeString; var Ok: boolean);

      property Port: integer read GetPort write SetPort;
      property AuthenticationMethod: String read GetAuthenticationMethod write SetAuthenticationMethod;
      end;

implementation

initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IRemoteAdminSettingsService ) );

end.


