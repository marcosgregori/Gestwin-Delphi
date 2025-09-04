unit nxifServerSettings;

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

     nxifBaseSettings;

const
     CLSID_ServerSettingsService : TGuid = '{CB9901E4-BACE-4530-B6BA-AA205E207B0F}';

type

    IServerSettingsService = interface( IBaseSettingsService )
      ['{023F948F-1ED9-41A0-A173-C532D4F187B9}']

      function GetAutoSaveConfig: Boolean;
      function GetBringUpServerOnStart: Boolean;
      function GetCloseServerFromTrayOnly: Boolean;
      function GetFromAddress: String;
      function GetFromName: String;
      function GetHiddenUIPages: String;
      function GetMinimizeOnStart: Boolean;
      function GetNotifyExceptions: Boolean;
      function GetResetsStatsOnActivate: Boolean;
      procedure SetAutoSaveConfig(const Value: Boolean);
      procedure SetBringUpServerOnStart(const Value: Boolean);
      procedure SetCloseServerFromTrayOnly(const Value: Boolean);
      procedure SetFromAddress(const Value: String);
      procedure SetFromName(const Value: String);
      procedure SetHiddenUIPages(const Value: String);
      procedure SetMinimizeOnStart(const Value: Boolean);
      procedure SetNotifyExceptions(const Value: Boolean);
      procedure SetResetsStatsOnActivate(const Value: Boolean);

      property AutosaveConfig: Boolean read GetAutoSaveConfig write SetAutoSaveConfig;
      property MinimizeOnStart: Boolean read GetMinimizeOnStart write SetMinimizeOnStart;
      property BringUpServerOnStart: Boolean read GetBringUpServerOnStart write SetBringUpServerOnStart;
      property ResetsStatsOnActivate: Boolean read GetResetsStatsOnActivate write SetResetsStatsOnActivate;
      property CloseServerFromTrayOnly: Boolean read GetCloseServerFromTrayOnly write SetCloseServerFromTrayOnly;
      property HiddenUIPages: String read GetHiddenUIPages write SetHiddenUIPages;
      property NotifyExceptions : Boolean read GetNotifyExceptions write SetNotifyExceptions;
      property FromName : String read GetFromName write SetFromName;
      property FromAddress : String read GetFromAddress write SetFromAddress;
      end;

implementation


initialization
    nxInvokeRegistry.RegisterInterface( TypeInfo( IServerSettingsService ) );

end.


