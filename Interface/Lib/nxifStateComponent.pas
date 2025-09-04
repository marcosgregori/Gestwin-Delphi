unit nxifStateComponent;

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
     nxrbTypes,

     nxifBaseSettings;

type
    IStateChangedCallback = interface(InxInvokable)
    ['{DB2F9CDD-4766-4511-B2B6-1BDE3B5F241F}']
      procedure OnStateChanged;
    end;

    IStateComponentService = interface( IBaseSettingsService )

      function GetStateChangedCallback : IStateChangedCallback;
      procedure SetStateChangedCallback( const ACallback : IStateChangedCallback );

      function GetActive: Boolean;
      procedure SetActive(const Value: Boolean);
      function GetEnabled: Boolean;
      procedure SetEnabled(const Value: Boolean);
      function GetEventLogEnabled: Boolean;
      procedure SetEventLogEnabled(const Value: Boolean);
      procedure SetState(const Value: TnxState);

      function GetState: TnxState;
      function GetStateTransition: TnxStateTransition;

      property Active : Boolean read GetActive write SetActive;
      property Enabled: Boolean read GetEnabled write SetEnabled;
      property EventLogEnabled: Boolean read GetEventLogEnabled write SetEventLogEnabled;

      property State: TnxState read GetState write SetState;
      property StateTransition : TnxStateTransition read GetStateTransition;

      property StateChangedCallback: IStateChangedCallback read GetStateChangedCallback write SetStateChangedCallback;
      end;

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IStateChangedCallback ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( IStateComponentService ) );

end.




