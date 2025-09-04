unit nxifServerEngineSettings;

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
     nxsrServerEngine,

     nxifStateComponent;

const
     CLSID_ServerEngineSettingsService : TGuid = '{EBD53654-35BF-4046-B8C5-0CC1B643C7FF}';

type

    IServerEngineSettingsService = interface( IStateComponentService )
      ['{6FEBC537-FDAB-4FE9-A01B-32B70FFF2943}']

      function GetMaxRam: Integer;
      function GetTempStoreSize: Integer;
      function GetServerName: String;
      function GetOptions: TnxServerEngineOptions;
      function GetTempStorePath: String;
      function GetJournalEngineClassName: String;

      procedure SetMaxRam(const Value: Integer);
      procedure SetTempStoreSize(const Value: Integer);
      procedure SetServerName(const Value: String);
      procedure SetOptions(const Value: TnxServerEngineOptions);
      procedure SetTempStorePath(const Value: String);
      procedure SetJournalEngineClassName(const Value: String);

      property MaxRam: Integer read GetMaxRam write SetMaxRam;
      property TempStoreSize: Integer read GetTempStoreSize write SetTempStoreSize;
      property Options: TnxServerEngineOptions read GetOptions write SetOptions;
      property TempStorePath : String read GetTempStorePath write SetTempStorePath;
      property ServerName : String read GetServerName write SetServerName;
      property JournalEngineClassName : String read GetJournalEngineClassName write SetJournalEngineClassName;
      end;

implementation


initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IServerEngineSettingsService ) );

end.


