{##############################################################################}
{# NexusDB: nxsdServerEngine.pas 4.7516                                      #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: base server engine classes                                        #}
{##############################################################################}

{$I nxDefine.inc}

{ Base server engine classes. }
unit nxsdServerEngine;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  nxllBde,
  Classes,
  SysUtils,
  Contnrs,
  Math,
  {$IFDEF SessionStatsDebug}
  DateUtils,
  StrUtils,
  nxExeConst,
  {$ENDIF SessionStatsDebug}
  nxllFastFillChar,
  nxllMemoryManager,
  nxllTypes,
  nxllException,
  nxllStreams,
  nxllSync,
  nxllList,
  nxllComponent,
  nxllRegisterableEngine,
  nxllSessionNotifications,
  nxsdTypes,
  nxsdConst,
  nxsdDataDictionary,
  nxsdTableMapperDescriptorBase,
  nxsdFilterDescriptorBase,
  nxsdFilterEngineBase,
  nxsdFilterEngineCallback;

resourcestring
  rsFailedPermanent = 'This session has been marked as permanently failed';
  rsProcessingCancelled = 'Processing cancelled';
  rsProcessingCancelledSuccess = 'Processing cancelled. Operation may have partially or fully succeeded';
  rsRequestNestedTransactionsNotSupported = 'RequestNestedTransactions is not supported by %s';

const
  { Alias Type - Name. }
  nxatAliasName = 'Name';
  { Alias Type - Path. }
  nxatAliasPath = 'Path';

  nxcl_FailedTimeout = 60000;

  CLSID_AbstractServerObject : TGUID = '{762A2DA1-44B8-447A-8CCA-74EBEAA4E9F1}';

type
  TnxAbstractCursorOption = (
    acoChainedRecordGetUsesWriteLock,
    acoFailClientFilterFast,
    acoFilterActionFollowedByFirst, //applies Activate, Deactivate, Remove, and Add if aActivate = True
    acoFilterActionFollowedBySync,  //applies Activate, Deactivate, Remove, and Add if aActivate = True
    acoFlipOrder,
    acoLockReleaseFollowedByRecordGet,
    acoPreCacheMarkedBlobs,
    acoRangeResetFollowedBySync,
    acoRangeSetFollowedByRecordGetNext,
    acoRangeSetFollowedBySetToBegin,
    acoRecNoSetFollowedBySync,
    acoRecordDeleteFollowedBySync,
    acoRecordGetFollowedByGetBookmark,
    acoRecordGetForKeyFollowedByRecordGet,
    acoRecordInsertFollowedByRecordGet,
    acoRecordModifyFollowedBySync,
    acoSetToBeginFollowedByRecordGetNext,
    acoSetToBookmarkFollowedByNothing,
    acoSetToBookmarkFollowedByRecordGet,
    acoSetToBookmarkFollowedByRecordGetNext,
    acoSetToBookmarkFollowedByRecordGetPrior,
    acoSetToBookmarkFollowedBySync,
    acoSetToCursorFollowedBySyncExact,
    acoSetToEndFollowedByRecordGetPrior,
    acoSetToKeyFollowedBySync,
    acoSkipReadingBlobDataForBatch
  );

  TnxAbstractCursorOptions = set of TnxAbstractCursorOption;

  TnxAbstractCursorCapability = (
    accCancelBlobs,
    accCaching
  );

  TnxAbstractCursorCapabilities = set of TnxAbstractCursorCapability;

const
  acoSetToBookmarkFollowedByRecordGets = [
    acoSetToBookmarkFollowedByNothing,
    acoSetToBookmarkFollowedBySync,
    acoSetToBookmarkFollowedByRecordGet,
    acoSetToBookmarkFollowedByRecordGetNext,
    acoSetToBookmarkFollowedByRecordGetPrior,
    acoChainedRecordGetUsesWriteLock
  ];

  acoSetToBookmarkFollowedByRecordGetForEdit = [
    acoSetToBookmarkFollowedByRecordGet,
    acoChainedRecordGetUsesWriteLock
  ];

type
  TnxCursorOpenOption = ( // only add at the end, sent over the network
    cooRequestMultipartRecordGet,
    cooRecordGetFollowedByGetBookmark,
    cooFlipOrder,
    cooNoClientCache
  );

  TnxCursorOpenOptions = set of TnxCursorOpenOption;

function nxCursorOpenOptionsToString(aOptions: TnxCursorOpenOptions): string;

type
  InxAbstractServerObject41100 = interface(InxInvokable)
    ['{65C25198-5DDF-4807-9196-6A76BBFE6768}']
    function GetEncodedExceptionData(aIncludeChildren: Boolean): string;
  end;

  { A Database Alias descriptor. }
  TnxAliasDescriptor = class(TnxObject)
    { Alias name}
    adAlias : string;
    { Directory path for database. }
    adPath  : string;
  end;

  { A Table descriptor. }
  TnxTableDescriptor = class(TnxObject)
    { Table Name. }
    tdTableName : string;
    { File extension. }
    tdExt       : string;
    { File Size. }
    tdSize      : TnxInt64;
    { Not used currently. }
    tdTimeStamp : TnxWord32;
  end;

  TnxBaseServerEngine = class;
  TnxBaseEngineMonitor = class;

  { class definition for Server Extenders }
  TnxBaseEngineExtenderClass = class of TnxBaseEngineExtender;

  TnxBaseEngineExtender = class;

  TnxAbstractSession = class;
  TnxAbstractDatabase = class;
  TnxAbstractTransContext = class;
  TnxAbstractCursor = class;
  TnxAbstractStatement = class;

  { Class definition for Server Objects. }
  TnxAbstractServerObjectClass = class of TnxAbstractServerObject;

  { The base class for all server dependent objects. }
  TnxAbstractServerObject = class(TnxLifetimeTrackedPersistent, InxAbstractServerObject41100)
  protected {private}
    asoDestroying    : LongBool;
    asoDestroyFlag   : PLongBool;
    asoSession       : TnxAbstractSession;

    function asoGetRemoteID: TnxBaseID; virtual;
    function asoGetIsRemote: Boolean; virtual;

    function asoGetRemoteThreadPriority: TnxThreadPriority; virtual;
    procedure asoSetRemoteThreadPriority(const Value: TnxThreadPriority); virtual;

    function asoGetMinVersion: Integer; virtual;

    {=== remoting integration ===}
    function asoCreateInstance(const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; virtual;
  protected
    {---InxExceptionData---}
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    {---InxAbstractServerObject41100---}
    function GetEncodedExceptionData(aIncludeChildren: Boolean): string;

    function asoGetServerEngine: TnxBaseServerEngine; virtual;
  public
    function asoConvertException(aException : Exception)
                                            : TnxResult; virtual;
  public
    constructor Create(aSession : TnxAbstractSession);
    {$IFDEF CPU64}
    class function NewInstance: TObject; override;
    {$ENDIF}
    procedure FreeInstance; override;

    { see TObject.BeforeDestruction. }
    procedure BeforeDestruction; override;

    { Reintroduction of the Free method }
    procedure Free;

    { called just before the destructor is called to allow for removal of
      dependencies between components. }
    procedure PrepareDestroy; virtual;

    class function LookupByID(aSessionID : TnxSessionID;
                              aBaseID    : TnxBaseID;
                          out aBase      )
                                         : TnxResult; virtual;

    function Close: TnxResult; virtual;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; virtual;

    { RemoteThreadPriority is the thread priority send to the server in case
      the object is living on a remote machine. }
    property RemoteThreadPriority: TnxThreadPriority
      read asoGetRemoteThreadPriority
      write asoSetRemoteThreadPriority;

    { The session owning this server object (if any) or nil. }
    property Session: TnxAbstractSession
      read asoSession;

    property RemoteID: TnxBaseID
      read asoGetRemoteID;

    property IsRemote: Boolean
      read asoGetIsRemote;

    property MinVersion: Integer
      read asoGetMinVersion;

    property Destroying: LongBool
      read asoDestroying;
  end;

  { Action types for Engine based actions. These types are fired and passed on
    to Extenders. }
  TnxEngineAction = (
    {-- general --}
    eaCreate,                       {        | After }
    eaDestroy,                      { Before |       }

    eaChildCreate,                  {        | After | Child: TnxExtendableServerObject }
    eaChildDestroy,                 { Before |       | Child: TnxExtendableServerObject }

    {-- session --}
    eaAliasAdd,                     { Before | After | Alias, Path : string; Enforce: Boolean }
    eaAliasDelete,                  { Before | After | Alias : string }
    eaAliasModify,                  { Before | After | Alias, NewName, NewPath : string; Enforce: Boolean }
    eaAliasGetList,                 { Before | After | List : TObjectList }
    eaAliasGetPath,                 { Before | After | Alias : string Path : PString}
    eaCloseInactiveFolders,         { Before | After }
    eaCloseInactiveTables,          { Before | After }
    eaBuildPasswords,               {        | After | Alias, Table: UnicodeString; aPasswords: PnxUnicodeStrings }

    {-- engine --}
    eaGetRegisteredClassList,       { Before | After | ClassListType : TnxClassListType
                                                       List          : TStrings}
    {-- database --}
    eaTransactionStart,             { Before | After | FailSafe, SnapShot : Boolean}
    eaTransactionCommit,            { Before | After }
    eaTransactionRollback,          {-Before | After }

    eaTableBuild,                   { Before | After | OverWrite  : Boolean
                                                       TableName  : string
                                                       Dictionary : TnxDataDictionary;
                                                       TableScope : PnxTableScope}
    eaTablePack,                    { Before |       | TableName  : string
                                              optional TableScope : PnxTableScope}
    eaTableBackup,                  { Before |       | TableName  : string
                                                       TargetDB   : TnxAbstractDatabase }
    eaTableRebuildIndex,            { Before |       | TableName  : string
                                                       IndexID    : Integer
                                              optional TableScope : PnxTableScope}
    eaTableRestructure,             { Before |       | TableName  : string
                                                       Dictionary : TnxDataDictionary
                                                       FieldMap   : TStrings
                                              optional TableScope : PnxTableScope}
    eaTableAddField,                { Before |       | TableName  : string
                                                       FieldDesc  : TnxFieldDescriptor
                                              optional TableScope : PnxTableScope}
    eaTableAddIndex,                { Before |       | TableName  : string
                                                       IndexDesc  : TnxIndexDescriptor
                                                       IsNewDefault: Boolean
                                              optional TableScope : PnxTableScope}
    eaTableDropIndex,               { Before |       | TableName  : string
                                                       IndexName  : string
                                                       IndexID    : Integer
                                              optional TableScope : PnxTableScope}
    eaTableRename,                  { Before | After | OldName    : string
                                                       NewName    : string
                                              optional TableScope : PnxTableScope}
    eaTableRecover,                 { Before |       | TableName  : string}
    eaTableVerifyChecksum,          { Before | After | TableName  : string
                                                       Raw        : PBoolean
                                                       ForceRecheck: PBoolean}
    eaTableDelete,                  { Before | After | TableName  : string
                                              optional TableScope : PnxTableScope}
    eaTableEmpty,                   { Before | After | TableName  : string
                                              optional TableScope : PnxTableScope}
    eaTableExists,                  { Before | After | TableName  : string
                                                       Exists     : PBoolean}
    eaTableGetDictionary,           { Before | After | TableName  : string
                                                       Dictionary : TnxDataDictionary}
    eaTableGetList,                 { Before | After | List       : TStrings}
    eaGetChangedTables,             { Before | After | Tables     : TStrings}

    {-- table --}
    eaOpenFile,                     {        | After | BaseFile   : TnxBaseFile }
    eaOpenFiles,                    {        | After }

    {-- cursor --}
    eaRecordGet,                    {        | After | LockType    : TnxLockType
                                                       Data        : PnxRecord
                                                       RefNr       : TnxRefNr -> only valid server side}
    eaRecordInsert,                 { Before | After | LockType    : TnxLockType
                                                       Data        : PnxRecord
                                                       RefNr       : TnxRefNr -> only valid after & server side}
    eaRecordModify,                 { Before | After | NewData     : PnxRecord
                                                       OldData     : PnxRecord -> nil@client side
                                                       ReleaseLock : Boolean
                                                       RefNr       : TnxRefNr -> only valid server side}
    eaRecordDelete,                 { Before | After | OldData     : PnxRecord
                                                       RefNr       : TnxRefNr -> only valid before & server side}

    {-- cursor - fulltext --}

    eaRecordFulltextUpdate,         { Before |       | MainIndexNo  : Integer;
                                                       Token        : ^TnxWideString
                                                       RefNr        : TnxRefNr
                                                       Location     : TnxWord32
                                                       Added        : Boolean}

    {-- statement --}
    eaStatementPrepare,             { Before | After | StatementType : TnxStatementType
                                                       QueryText     : WideString
                                                       Stream        : TStream}

    eaStatementExec,                { Before | After | Cursor        : PnxAbstractCursor
                                                       OpenMode      : TnxOpenMode
                                                       Stream        : TStream}

    eaStatementSetParams,           { Before | After | Params        : PnxSqlParamList (const!)
                                                       Stream        : TStream}

    eaStatementGetParams,           { Before | After | Params        : PnxSqlParamList (const!)
                                                       Stream        : TStream}

    {-- replication support --}
    eaReplicatedFileInit            {        | After | BaseFile   : TnxBaseFile }
  );
  { Set of Engine Actions }
  TnxEngineActions = set of TnxEngineAction;

  TnxEngineNotify = function(aAction : TnxEngineAction;
                             aBefore : Boolean;
                       const aArgs   : array of const)
                                     : TnxResult of object;

  { The base class for Server objects that can be extended with an Extender. }
  TnxExtendableServerObject = class(TnxAbstractServerObject)
  private
    function esoGetIgnoreSecurity: Boolean;
  protected {private}
    esoParent           : TnxExtendableServerObject;
    esoExtendersLock    : TnxPadlock;
    esoExtendersHead    : TnxBaseEngineExtender;
    esoExtendersTail    : TnxBaseEngineExtender;
    esoExtendersActions : TnxEngineActions;

    esoOptions          : TStringList;

    esoIgnoreSecurity   : Integer;

    esoDelayInformMonitors : Boolean;
  protected
    {---InxExceptionData---}
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    function asoGetServerEngine: TnxBaseServerEngine; override;

    function esoInformMonitors: Boolean; virtual;
    function esoDelayedInformMonitors: TnxResult;
    function esoNotifyAfterCreate: TnxResult;

    {=== options ===}
    function esoGetOptions: TStringList;
    function esoGetOptionsParent: TnxExtendableServerObject; virtual;

//DOM-IGNORE-BEGIN
  public
    function esoOptionClear(const aName  : string)
                                         : TnxResult; virtual;
    function esoOptionSet(const aName  : string;
                          const aValue : string)
                                       : TnxResult; virtual;

    procedure esoOptionChanged(const aName  : string;
                               const aValue : string); virtual;
//DOM-IGNORE-END
  protected

    function esoOptionGet(const aName  : string;
                            out aValue : string)
                                       : TnxResult; virtual;
    function esoOptionGetParent(const aName  : string;
                                  out aValue : string)
                                             : TnxResult; virtual;
//DOM-IGNORE-BEGIN
  public
    function esoOptionGetEffective(const aName  : string;
                                     out aValue : string)
                                                : TnxResult; virtual;
//DOM-IGNORE-END
  protected
    function esoOptionList(aList : TStrings)
                                 : TnxResult; virtual;
    function esoOptionListParent(aList : TStrings)
                                       : TnxResult; virtual;
    function esoOptionListEffective(aList : TStrings)
                                          : TnxResult; virtual;

    function esoOptionListMerge(aOwnList    : TStrings;
                                aParentList : TStrings)
                                            : TnxResult; virtual;

    {=== remoting integration ===}
    function esoCreateInstance(const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; virtual;
  public
    { constructor. }
    constructor Create(aParent: TnxExtendableServerObject);
    { destructor. }
    destructor Destroy; override;

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    procedure PrepareDestroy; override;

    procedure BeginIgnoreSecurity;
    procedure EndIgnoreSecurity;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    {=== options ===}
    { Removes an Option from the named option list }
    function OptionClear(const aName  : string)
                                      : TnxResult; virtual;
    { Sets an Option in named option list to a certain value.}
    function OptionSet(const aName  : string;
                       const aValue : string)
                                    : TnxResult; virtual;

    { Returns the value of an Option in named option list of *this* object only. }
    function OptionGet(const aName  : string;
                         out aValue : string)
                                    : TnxResult; virtual;

    { Returns the value of an Option in named option by walking the parent
      hierarchy until a value is found. }
    function OptionGetEffective(const aName  : string;
                                  out aValue : string)
                                             : TnxResult; virtual;

    { Returns all options as value list (name=value) of this object. }
    function OptionList(aList : TStrings)
                              : TnxResult; virtual;

    { Returns all options as value list (name=value) of the whole parent
      hierarchy. }
    function OptionListEffective(aList : TStrings)
                                       : TnxResult; virtual;

    { This function is called to notify all Monitors attached to the
      owning Server Engine of an Action.
      Parameters:
        aAction - The action that is going to be executed or was executed.
        aBefore - This Parameter is true if the Action is going to be executed.
        aArgs - a number of Arguments passed in and/or out of the function
    }
    function NotifyExtenders(aAction : TnxEngineAction;
                             aBefore : Boolean;
                       const aArgs   : array of const)
                                     : TnxResult; virtual;

    function GetNotifyFor(aAction: TnxEngineAction): TnxEngineNotify;

    { returns the first Extender of a certain class type of the registered
      Extender list }
    function GetExtenderOfType(aExtenderClass : TnxBaseEngineExtenderClass)
                                              : TnxBaseEngineExtender;

    property IgnoreSecurity: Boolean
      read esoGetIgnoreSecurity;
  end;

  { The base class for extendable objects that require a locked named options list. }
  TnxLockedOptionsExtendableServerObject = class(TnxExtendableServerObject)
  protected {private}
    loesoOptionsLock: TnxPadlock;
  protected
    {=== options ===}
  public
//DOM-IGNORE-BEGIN
    function esoOptionClear(const aName  : string)
                                         : TnxResult; override;
    function esoOptionSet(const aName  : string;
                          const aValue : string)
                                       : TnxResult; override;
//DOM-IGNORE-END
  protected
    function esoOptionGet(const aName  : string;
                            out aValue : string)
                                       : TnxResult; override;
    function esoOptionList(aList : TStrings)
                                 : TnxResult; override;
  public
    { destructor. }
    destructor Destroy; override;
  end;

  { An instance of a descendant of this class is created for every task
    executed and on the server. It will be freed once the task is finished. }
  TnxAbstractTaskInfo = class(TnxExtendableServerObject)
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  public { public comes before protected to fix problem with BCB }
    { constructor. }
    constructor Create(aSession : TnxAbstractSession);
    { destructor. }
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    { This function returns the current status a server task.
      Parameters:
        aCompleted - is set to true if the task is completed
        aStatus - is set to the task status
    }
    function GetStatus(out aCompleted : Boolean;
                       out aStatus    : TnxTaskStatus)
                                      : TnxResult; virtual; abstract;

    { Call this method to cancel a Task. This method only triggers
      the cancel, the tasks may still be active until it reaches a
      safe state. The client-side taskinfo object should not be freed
      until the aCompleted parameter of GetStatus returns True,
      indicating task has ended.
    }
    function Cancel: TnxResult; virtual; abstract;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

  protected {private}
    atiSessionPrev : TnxAbstractTaskInfo;
    atiSessionNext : TnxAbstractTaskInfo;
  protected
    procedure atiAddToSession;
    procedure atiRemoveFromSession;
  end;

  InxRemoteTaskInfoCreator = interface(InxInterface)
    ['{17B64C3F-3929-498A-B0FB-7982F7D6BC6E}']
    function CreateRemoteTaskInfo(const aTaskID : TnxTaskID)
                                                : TnxAbstractTaskInfo;
  end;

  InxSimpleLock = interface
    ['{D2727E91-E0DC-4558-B857-2FC0EDE88ED9}']

    { Increases the lock count. }
    procedure Lock;
    { Decreases the lock count. }
    procedure Unlock(var aResult: TnxResult);
    { Internally used to coordinate long running operations and lost connections
      at the transport level... stopping e.g. running SQL statements after a few
      sec max if the connection is lost. }
    procedure Failed(aPermanent, aWait : Boolean);

    procedure SetFailedCleanupDone;
    function IsFailedPermanent: Boolean;

    function LastLocked: TnxWord64;
  end;

  TnxSessionStatsCounter = (
    sscCalls,
    sscStatements,
    sscTime,
    sscCycles,
    sscBlocksRead,
    sscBlocksWritten,
    sscTransCommit,
    sscTransRollback,
    sscTransNestedCommit,
    sscTransNestedRollback,
    sscTransDeadlock,
    sscTransCorrupted
  );

  TnxSessionStatsCounters = array[TnxSessionStatsCounter] of Int64;

  TnxSessionStats = class(TnxObject)
  protected {private}
    assLock              : TnxPadlock;
    assNext              : TnxSessionStats;
    assSessionNumber     : Integer;

    assStarted           : TDateTime;
    assClosed            : TDateTime;

    assUserName          : string;
    assConnectedFrom     : string;
    assHeartbeatInterval : TnxWord32;
    assClientInfo        : string;

    assCurrentThread     : THandle;

    assEnterTime         : Int64;
    assEnterThreadCycle  : UInt64;

    assCounters          : TnxSessionStatsCounters;

    assExtClosed         : TDateTime;
    assExtCounters       : TnxSessionStatsCounters;

    procedure assUpdateFromThread(aKeepCounting: Boolean);
    {$IFDEF SessionStatsDebug}
    procedure DumpDebugToFile;
    {$ENDIF SessionStatsDebug}
  protected
    procedure Enter; virtual;
    procedure Leave; virtual;
    procedure Close; virtual;
  public
    constructor Create(const aUserName, aConnectedFrom: string; aHeartbeatInterval: TnxWord32);

    class function Current: TnxSessionStats;
    class function Head: TnxSessionStats;

    class procedure Count(aCounter: TnxSessionStatsCounter; aCount: Int64 = 1);

    class procedure SetClientInfo(const aClientInfo: string);

    function Update: TnxSessionStatsCounters;

    property Next: TnxSessionStats
      read assNext;

    property SessionNumber: Integer
      read assSessionNumber;

    property Started: TDateTime
      read assStarted;
    property Closed: TDateTime
      read assExtClosed;

    property UserName: string
      read assUserName;
    property ConnectedFrom: string
      read assConnectedFrom;

    property HeartbeatInterval : TnxWord32
      read assHeartbeatInterval;
    property ClientInfo : string
      read assClientInfo;
  end;

  { A 100% thread safe lock used for counter based NexusDB locks. }
  TnxSimpleLock = class(TnxInterfacedObject, InxSimpleLock)
  protected
    slStats             : TnxSessionStats;

    slLockingThread     : Integer;
    slLockCount         : Integer;

    slFailedSpinlock    : Integer;
    slFailedFlag        : PnxBoolean;
    slFailedOrg         : TnxBoolean;
    slFailed            : TnxBoolean;
    slFailedPermanent   : TnxBoolean;

    slFailedCleanup     : TNotifyEvent;
    slFailedCleanedup   : Boolean;
    slFailedCleanupDone : THandle;

    slLastLocked        : TnxWord64;
  public
    slExceptionHookInfo : TnxExceptionHookInfo;
    { Constructor.
      Parameter:
        aFailedCleanup - an Event that is called if the lock can't be cleaned up
          due to a failed Lock attempt.
    }
    constructor Create(aFailedCleanup: TNotifyEvent; aStats: TnxSessionStats);
    { destructor. }
    destructor Destroy; override;

    { Increases the lock count. }
    procedure Lock;
    { Decreases the lock count. }
    procedure Unlock(var aResult: TnxResult);
    { Internally used to coordinate long running operations and lost connections
      at the transport level... stopping e.g. running SQL statements after a few
      sec max if the connection is lost. }
    procedure Failed(aPermanent, aWait : Boolean);

    procedure SetFailedCleanupDone;
    function IsFailedPermanent: Boolean;

    function LastLocked: TnxWord64;
  end;

  { The base class for all server classes that support timeout. }
  TnxAbstractTimeoutObject = class(TnxExtendableServerObject)
  protected {private}
    atoTimeoutBatchPrev : TnxAbstractTimeoutObject;
    atoTimeoutBatchNext : TnxAbstractTimeoutObject;
    atoLock             : InxSimpleLock;

    atoTimeout          : TnxWord32;

    procedure atoSetTimeout(aTimeout: TnxWord32); virtual;
  protected
    function atoAddToTimeoutBatch(aATO: TnxAbstractTimeoutObject): Boolean; virtual;

    procedure atoAddSelfToTimeoutBatch;
    procedure atoRemoveSelfFromTimeoutBatch;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  public
    { constructor. }
    constructor Create(aParent  : TnxExtendableServerObject;
                       aTimeout : TnxWord32);

    destructor Destroy; override;

    { Removes an Option from the named option list }
    function OptionClear(const aName  : string)
                                      : TnxResult; override;
    { Sets an Option in named option list to a certain value.}
    function OptionSet(const aName  : string;
                       const aValue : string)
                                    : TnxResult; override;

    { Returns the value of an Option in named option list of *this* object only. }
    function OptionGet(const aName  : string;
                         out aValue : string)
                                    : TnxResult; override;

    { Returns the value of an Option in named option by walking the parent
      hierarchy until a value is found. }
    function OptionGetEffective(const aName  : string;
                                  out aValue : string)
                                             : TnxResult; override;

    { Returns all options as value list (name=value) of this object. }
    function OptionList(aList : TStrings)
                              : TnxResult; override;

    { Returns all options as value list (name=value) of the whole parent
      hierarchy. }
    function OptionListEffective(aList : TStrings)
                                       : TnxResult; override;

    function Close: TnxResult; override;

    function LastLocked: TnxWord64;

    function BeginTimeoutBatch: Integer; virtual;
    function EndTimeoutBatch: Integer; virtual;

    { Property to read/write the timeout in msec for the object. }
    property Timeout: TnxWord32
      read atoTimeout
      write atoSetTimeout;
  end;

  TnxAbstractSessionDatabaseOpen = function (out aDatabase     : TnxAbstractDatabase;
                                           const aAliasType    : string;
                                           const aAlias        : string;
                                                 aTransContext : TnxAbstractTransContext;
                                                 aOpenMode     : TnxOpenMode;
                                                 aShareMode    : TnxShareMode;
                                                 aTimeout      : TnxWord32)
                                                               : TnxResult of object;

  { Class of TnxAbstractSession. }
  TnxAbstractSessionClass = class of TnxAbstractSession;
  { The abstract declaration of a Server Session. All actual
    session implementations MUST be descendent from this class.
    This is the server side version of TnxSession.              }
  TnxAbstractSession = class(TnxAbstractTimeoutObject, InxSessionNotifications)
  protected {private}
    asLock                 : TnxSimpleLock;

    asSessionNotifications : TnxSessionNotifications;

    asCleanedUp            : Boolean;
    asServerEngine         : TnxBaseServerEngine;

    asServerEnginePrev     : TnxAbstractSession;
    asServerEngineNext     : TnxAbstractSession;

    asDatabasesPadlock     : TnxPadlock;
    asDatabasesHead        : TnxAbstractDatabase;
    asDatabasesTail        : TnxAbstractDatabase;

    asTransContextsPadlock : TnxPadlock;
    asTransContextsHead    : TnxAbstractTransContext;
    asTransContextsTail    : TnxAbstractTransContext;

    asTaskInfosPadlock     : TnxPadlock;
    asTaskInfosHead        : TnxAbstractTaskInfo;
    asTaskInfosTail        : TnxAbstractTaskInfo;

    asTimeoutBatchPadlock  : TnxPadlock;
    asTimeoutBatchHead     : TnxAbstractTimeoutObject;
    asTimeoutBatchTail     : TnxAbstractTimeoutObject;

    asConnectedSince       : TDateTime;
    asLockedIncDone        : Boolean;

    asUserName             : UnicodeString;
    asPassword             : UnicodeString;
    asAuthenticated        : Boolean;
    asMustBeAuthenticated  : Boolean;

    asConnectedFrom        : string;

    function asGetClientVersion: Integer; virtual;
    function asGetServerVersion: Integer; virtual;

    function asGetClientDefaultLocale: TnxLocaleDescriptor; virtual;

    function asoGetMinVersion: Integer; override;

    function asGetSessionNotifications: InxSessionNotifications;
  protected
    procedure asTimeoutBatchClear;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  protected
    function asoGetServerEngine: TnxBaseServerEngine; override;

    procedure asAddToServerEngine;
    procedure asRemoveFromServerEngine; virtual;

    procedure asFailed(aPermanent, aWait : Boolean); virtual;
    procedure asCleanup(aSender: TObject); virtual;

    function asCreateStats: TnxSessionStats;
    function asDoCreateStats: TnxSessionStats; virtual;
  public
    { Constructor

      Parameters
      aServerEngine :  the server engine that owns the session
      aTimeout :       the timeout in msec for the session
      aUserName :      the user name used to logon to the server
      aPassword :      the password used to logon to the server  }
    constructor Create(aServerEngine  : TnxBaseServerEngine;
                       aTimeout       : TnxWord32;
                 const aUserName      : UnicodeString;
                 const aPassword      : UnicodeString;
                 const aConnectedFrom : string);
    { destructor. }
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    { Removes any failed locks and marks the session as failed. }
    procedure Failed(aPermanent : Boolean);

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    { This is the class function that returns the object with a certain ID.
      Parameters:
        aSessionID - the ID to look for
        aSession - a var that will hold the class if found
    }
    class function LookupByID(aSessionID : TnxSessionID;
                          out aSession   )
                                         : TnxResult; reintroduce; overload; virtual;

    { Sets an Option in named option list to a certain value.}
    function OptionSet(const aName  : string;
                       const aValue : string)
                                    : TnxResult; override;

    {-- alias managment --}

    { This function implements the addition of a new Alias to the session.
      Parameters:
        aAlias - the name of the Alias.
        aPath - the directory the Alias points to. The format is specific to the
          actual implementation
    }
    function AliasAdd(const aAlias   : string;
                      const aPath    : string;
                            aEnforce : Boolean)
                                     : TnxResult; virtual; abstract;
    { This function implements the removal of an Alias from the session.
      Parameters:
        aAlias - the name of the Alias to be removed.
    }
    function AliasDelete(const aAlias : string)
                                      : TnxResult; virtual; abstract;
    { This function implements the modification of a an Alias. The function
      supports modifying name and/or path of the Alias.
      Parameters:
        aAlias - the name of the Alias.
        aNewName - a new name for the alias.
        aPath - the directory the Alias points to. The format is specific to the
          actual implementation
    }
    function AliasModify(const aAlias   : string;
                         const aNewName : string;
                         const aNewPath : string;
                               aEnforce : Boolean)
                                        : TnxResult; virtual; abstract;

    { This function needs to return the List of Aliases as a list
      \of TnxAliasDescriptor objects.
      
      Parameters
      aList :  The list that will be filled with descriptors.     }
    function AliasGetList(aList : TObjectList)
                                : TnxResult; virtual; abstract;
    { This function returns the Path of a directory. The format of
      aPath is specific to the actual implementation, in the
      default implementation it is a directory.

      Parameters
      aAlias :  the name of the alias
      aPath :   the variable that will be set to the path.         }
    function AliasGetPath(const aAlias : string;
                            out aPath  : string)
                                       : TnxResult; virtual; abstract;

    {-- password management --}

    { Adds a password to the Session internal password list. }
    function PasswordAdd(const aPassword : UnicodeString)
                                         : TnxResult; virtual; abstract;
    { Removes a password from the Session internal password list. }
    function PasswordRemove(const aPassword : UnicodeString)
                                            : TnxResult; virtual; abstract;
    { Clears the password list. }
    function PasswordRemoveAll: TnxResult; virtual; abstract;

    {-- table/folder managment --}

    { This function uncaches and closes all unused folders/directories. }
    function CloseInactiveFolders : TnxResult; virtual; abstract;
    { This function uncaches and closes all unused tables. }
    function CloseInactiveTables : TnxResult; virtual; abstract;

    {-- database managment --}

    { This function will open a alias/database and return the
      TnxAbstractDatabase object created it for it.

      Parameters
      aDatabase :    the variable to receive the resulting instance.
      aAliasType :   the type of the alias. Currently nxatAliasName
                     and nxatAliasPath
      aAlias :       the name of the alias to open
      aTransContext: the transaction context this database belongs to. If this is nil the database creates it's own transaction context.
      aOpenMode :    the mode the database should be opened in
      aShareMode :   Share mode for opening the database
      aTimeout :     the timeout in msec for the database            }
    function DatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                        const aAliasType    : string;
                        const aAlias        : string;
                              aTransContext : TnxAbstractTransContext;
                              aOpenMode     : TnxOpenMode;
                              aShareMode    : TnxShareMode;
                              aTimeout      : TnxWord32)
                                            : TnxResult; virtual; abstract;
    function DatabaseCacheOpen(out aDatabase     : TnxAbstractDatabase;
                             const aAliasType    : string;
                             const aAlias        : string;
                                   aTransContext : TnxAbstractTransContext;
                                   aOpenMode     : TnxOpenMode;
                                   aShareMode    : TnxShareMode;
                                   aTimeout      : TnxWord32)
                                                 : TnxResult; virtual;

    {-- table stream access shortcut --}

    function TableStreamRead(const aAliasName  : string;
                             const aTableName  : string;
                             const aPassword   : UnicodeString;
                             const aStreamName : string;
                                   aStream     : TStream)
                                               : TnxResult; virtual;

    function TableStreamWrite(const aAliasName  : string;
                              const aTableName  : string;
                              const aPassword   : UnicodeString;
                              const aStreamName : string;
                                    aStream     : TStream)
                                                : TnxResult; virtual;

    {-- table information --}
    { TableExists checks if a table exists.
      Parameters:
        aAliasName :       the name of the alias to open
        aTableName: the table name to check
        aExists: the var to be filled with the result.
    }
    function TableExists(const aAliasName   : string;
                         const aTableName   : string;
                         const aPassword    : UnicodeString;
                           out aExists      : Boolean;
                               aAllowSystem : Boolean = False)
                                            : TnxResult; virtual;

    {-- transaction context managment --}

    { This function will create a transaction context and return the
      TnxAbstractTransContext object created it for it. The transaction context
      can then be passed into DatabaseOpen.

      Parameters
      aTransContext :    the variable to receive the resulting instance.
      aTimeout :     the timeout in msec for the transaction context }
    function TransContextCreate(out aTransContext : TnxAbstractTransContext;
                                    aTimeout      : TnxWord32)
                                                  : TnxResult; virtual; abstract;

    {-- engine managment --}

    { This function returns a list of registered engines of the requested type. }
    function GetRegisteredClassList(const aClassListType : TnxClassListType;
                                          aList          : TStrings)
                                                         : TnxResult; virtual; abstract;

    {-- misc --}
    procedure GetUserInfo(aStrings: TStrings); virtual;

    { This property returns the server engine the session is attached to. }
    property ServerEngine: TnxBaseServerEngine
      read asServerEngine;

    { This property returns the version of the client that opened the session.}
    property ClientVersion: Integer
      read asGetClientVersion;

    { Returns the locale that the client wishes to use for string comparisons
      where no explicit locale is defined. NIL if no default is specified by
      the client.}
    property ClientDefaultLocale: TnxLocaleDescriptor
      read asGetClientDefaultLocale;


    { This property returns the version of the server that runs the session.}
    property ServerVersion: Integer
      read asGetServerVersion;

    { This property returns the user name used to logon the
      session. }
    property UserName: UnicodeString
      read asUserName;

    { This property returns the password used to logon the session. }
    property Password: UnicodeString
      read asPassword;

    { This property returns the connection information for the session. }
    property ConnectedFrom: string
      read asConnectedFrom;

    { This property returns true, it the session was logged on
      successfully with User Name and Password. }
    property Authenticated: Boolean
      read asAuthenticated;

    { This property returns true, it the session must be
      authenticated, even if seoSecure is not set. }
    property MustBeAuthenticated: Boolean
      read asMustBeAuthenticated;

    { This property returns true, it the session has failed and has been cleaned
      up. It no longer owns any databases. }
    property CleanedUp : Boolean
      read asCleanedUp;

    property SessionNotifications  : InxSessionNotifications
      read asGetSessionNotifications
      implements InxSessionNotifications;
  end;

  { The state of the currently executed Statement }
  TnxStatementExecDirectPhase = (
    { Allocating resources }
    sedAlloc,
    { Preparing }
    sedPrepare,
    { Setting Parameters }
    sedSetParams,
    { Executing }
    sedExec,
    { Getting Parameters }
    sedGetParams,
    { Destroying }
    sedFree
  );

  { Scope of a table }
  TnxTableScope = (
    { Persistent Table }
    tsPersistent,
    { Global Temporary Table }
    tsTempGlobal,
    { Database based Temporary Table }
    tsTempDatabase,
    { Unnamed Table - not visible to clients }
    tsTempUnnamed
  );
  PnxTableScope = ^TnxTableScope;

  { Abstract Prototype for MappingMethods }
  TnxMappingMethod = function(const aSource;
                                var aTarget)
                                           : TnxResult of object;

  { The base class for transaction contexts, both TnxAbstractTransContext and
    TnxAbstractDatabase derive from this class. }
  TnxBaseTransContext = class(TnxAbstractTimeoutObject)
  public
    {-- transaction management --}
    { StartTransaction tries to start a transaction. If it fails an exception is triggered.
      Parameters:
        aFailsafe: if true it must be handled as fail safe.
        aSnapshot: if true it is handled as a SnapshotTransaction
    }
    function TransactionStart(aFailSafe   : Boolean;
                              aSnapShot   : Boolean)
                                          : TnxResult; virtual; abstract;
    { Start a transaction if an exclusive lock can be granted on all specified cursors.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aFailsafe: if true it must be handled as fail safe.
        aSnapshot: if true it is handled as a SnapshotTransaction
        aCursors: the cursors that should be part of the transaction
    }
    function TransactionStartWith(aFailSafe   : Boolean;
                                  aSnapShot   : Boolean;
                            const aCursors    : array of TnxAbstractCursor)
                                              : TnxResult; virtual; abstract;

    { Requires an active transaction, attempts to gain a shared or exclusive lock
      on all specified cursors.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aExclusive : Requests exclusive locks if true, otherwise shared locks are requested.
        aCursors   : The cursors that should be part of the transaction.
    }
    function TransactionInclude(aExclusive : Boolean;
                          const aCursors   : array of TnxAbstractCursor)
                                           : TnxResult; virtual; abstract;

    { This method commits a pending transaction (level). If an
      error occurs (e.g. deadlock detected or transaction level has
      been marked as corrupted) the transaction is <B>not</B>
      automatically rolled back.                                    }
    function TransactionCommit : TnxResult; virtual; abstract;
    { Rollback rolls (as the name says) back a pending transaction (level). All
      changes since the last StartTransaction (or equivalent) call are lost.
    }
    function TransactionRollback : TnxResult; virtual; abstract;
    { This method marks the transaction (level) as corrupted and
      thus preventing it from ever being committed.              }
    function TransactionCorrupted : TnxResult; virtual; abstract;

    { This method returns the nesting level of the current transaction. }
    function TransactionGetLevel(out aTransLevel : Integer)
                                                 : TnxResult; virtual; abstract;

    { This method returns the nesting level of the current transaction. }
    function TransactionGetInfo(out aTransInfo   : TnxTransactionInfo;
                                    aAllowCached : Boolean = True)
                                                 : TnxResult; virtual; abstract;
  end;

  InxDatabaseCursorSource = interface(InxInterface)
    ['{E46D44BF-AE7D-435D-9420-CE1922DB3819}']

    function CursorOpen(const aTableName : string)
                                         : TnxAbstractCursor;
  end;

  InxDatabaseCursorSourceControl = interface(InxInterface)
    ['{3DBBA72D-F8D2-4AF9-9400-2EE56AD499DF}']

    function Unregister: TnxResult;
  end;

  { The abstract declaration of a Server Database. All actual
    database implementations MUST be descendent from this class.
    This is the server side version of TnxDatabase.              }
  TnxAbstractDatabase = class(TnxBaseTransContext)
  protected {private}
    adSessionPrev       : TnxAbstractDatabase;
    adSessionNext       : TnxAbstractDatabase;

    adTransContext      : TnxAbstractTransContext;
    adOwnedTransContext : TnxAbstractTransContext;

    adTransContextPrev  : TnxAbstractDatabase;
    adTransContextNext  : TnxAbstractDatabase;

    adCursorsPadlock    : TnxPadlock;
    adCursorsHead       : TnxAbstractCursor;
    adCursorsTail       : TnxAbstractCursor;
    adCursorAutoFree    : Boolean;

    adStatementsPadlock : TnxPadlock;
    adStatementsHead    : TnxAbstractStatement;
    adStatementsTail    : TnxAbstractStatement;

    adLockedIncDone     : Boolean;

    function adGetExplicitAllowSystem: Boolean; virtual;
    function adGetIsCache: Boolean; virtual;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  protected
    procedure atoSetTimeout(aTimeout: TnxWord32); override;

    procedure adAddToSession;
    procedure adRemoveFromSession;

    procedure adAddToTransContext;
    procedure adRemoveFromTransContext;
    procedure adTransContextDestroying;

    {=== options ===}
    function esoGetOptionsParent: TnxExtendableServerObject; override;
  public
    { constructor
      Parameters:
        aSession - the session object the database belongs to
        aTransContext - the transaction context this database belongs to. If no transaction context is passed in a new one will be created.
        aTimeout - the timeout for this database in msec
    }
    constructor Create(aSession      : TnxAbstractSession;
                       aTransContext : TnxAbstractTransContext;
                       aTimeout      : TnxWord32);
    { destructor. }
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    {-- caching --}

    function SetCacheDatabase(aCacheDatabase : TnxAbstractDatabase)
                                             : TnxResult; virtual;

    property IsCache: Boolean
      read adGetIsCache;

    {-- cursor source --}

    function RegisterCursorSource(aSource  : InxDatabaseCursorSource;
                              out aControl : InxDatabaseCursorSourceControl)
                                           : TnxResult; virtual;

    {-- table managmenet --}

    { This function creates a new table.
      Parameters:
        aOverWrite:
          if true, an existing table is overwritten if it is not in use
        aTableName:
          the name of the new table
        aDictionary:
          the dictionary that defines the table and index structure
    }
    function TableBuild(aOverWrite   : Boolean;
                  const aTableName   : string;
                  const aPassword    : UnicodeString;
                        aDictionary  : TnxDataDictionary;
                        aTableScope  : TnxTableScope;
                        aAllowSystem : Boolean = False)
                                     : TnxResult; virtual; abstract;

    { This method starts an asynchronous packing of the table. For this purpose a new
      identical table is created and the records are copied over from the
      old one.
      Parameters:
        aName: table name
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
    }
    function TablePack(const aTableName : string;
                       const aPassword  : UnicodeString;
                         out aTaskInfo  : TnxAbstractTaskInfo)
                                        : TnxResult; virtual; abstract;
    { This method starts an asynchronous backup of the table. For this purpose a new
      table with identical fields is created and the records are copied over from the
      old one. The original data dictionary is added as a tablestream.
      Parameters:
        aName: table name
        aTargetDatabase: The database where the new table with identical name is created
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
    }
    function TableBackup(const aTableName      : string;
                         const aPassword       : UnicodeString;
                               aTargetDatabase : TnxAbstractDataBase;
                           out aTaskInfo       : TnxAbstractTaskInfo)
                                               : TnxResult; virtual; abstract;
    { ReIndexTable starts an asynchronous re indexing of a certain
      index of a table.

      Parameters
      aName :       table name
      aIndexName :  the name of the index
      aIndexID :    the id of the index in the index descriptor list.
      aTaskInfo :   Task information instance; use TaskInfo.GetStatus
                    to find out the status of the operation.          }
    function TableRebuildIndex(const aTableName : string;
                               const aPassword  : UnicodeString;
                               const aIndexName : string;
                                     aIndexID   : Integer;
                                 out aTaskInfo  : TnxAbstractTaskInfo)
                                                : TnxResult; virtual; abstract;
    { With this method you can start an asynchronous restructure of a given table.
      Parameters:
        aTableName: table name
        aDictionary: new dictionary of the table
        aFieldMap: defines how fields are mapped from the old to the new structure
        aAllowSystem: set to true to allow restructure of system table
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
    }
    function TableRestructure(const aTableName   : string;
                              const aPassword    : UnicodeString;
                                    aDictionary  : TnxDataDictionary;
                                    aMapperDesc  : TnxBaseTableMapperDescriptor;
                              const aAllowSystem : Boolean;
                                out aTaskInfo    : TnxAbstractTaskInfo)
                                                 : TnxResult; virtual; abstract;

    { With TableAddField you can add a new field without restructure. May fail.
      Parameters:
        aTableName: table name
        aFieldDesc: a full field descriptor for the new field
    }
    function TableAddField(const aTableName  : string;
                           const aPassword   : UnicodeString;
                                 aFieldDesc  : TnxFieldDescriptor)
                                             : TnxResult; virtual; abstract;

    { With TableAddIndex you can create a new index.
      Parameters:
        aTableName: table name
        aIndexDesc: a full index descriptor for the new index
    }
    function TableAddIndex(const aTableName  : string;
                           const aPassword   : UnicodeString;
                                 aIndexDesc  : TnxIndexDescriptor;
                                 aNewDefault : Boolean)
                                             : TnxResult; virtual; abstract;
    { This function deletes an index.
      Parameters:
        aTableName: the name of the table that holds the index to be deleted.
        aIndexName: the name of the index to be deleted
        aIndexID: the id in the list of index descriptors of the index to be deleted.
    }
    function TableDropIndex(const aTableName  : string;
                            const aPassword   : UnicodeString;
                            const aIndexName  : string;
                                  aIndexID    : Integer)
                                              : TnxResult; virtual; abstract;

    { This function renames a table from aOldName to aNewName, it the
      table is not in use.
    }
    function TableRename(const aOldName  : string;
                         const aNewName  : string;
                         const aPassword : UnicodeString)
                                         : TnxResult; virtual; abstract;
    { This function walks all the blocks in the table on disk, and
      copies healthy records to aTableName_recovered, and
      copies bad records to aTableName_Failed. }
    function TableRecover(const aTableName : string;
                          const aPassword  : UnicodeString;
                            out aTaskInfo  : TnxAbstractTaskInfo)
                                           : TnxResult; virtual; abstract;
    { This function walks all the blocks in the table on disk, and
      verifies the whole table checksum in the header (if the table
      is encrypted using an encryption engine which supports whole
      table checksums). }
    function TableVerifyChecksum(const aTableName    : string;
                                 const aPassword     : UnicodeString;
                                       aRaw          : Boolean;
                                       aForceRecheck : Boolean;
                                   out aTaskInfo     : TnxAbstractTaskInfo)
                                                     : TnxResult; virtual; abstract;
    { This function deletes the table with the given aTableName. }
    function TableDelete(const aTableName : string;
                         const aPassword  : UnicodeString)
                                          : TnxResult; virtual; abstract;
    { This function deletes all records from the table with the
      given aTableName.                                         }
    function TableEmpty(const aTableName : string;
                        const aPassword  : UnicodeString)
                                         : TnxResult; virtual; abstract;
    { This function changes the password of the table with the
      given aTableName.                                         }
    function TableChangePassword(const aTableName   : string;
                                 const aOldPassword : UnicodeString;
                                 const aNewPassword : UnicodeString)
                                                    : TnxResult; virtual; abstract;

    {-- table information --}
    { TableExists checks if a table exists.
      Parameters:
        aTableName: the table name to check
        aExists: the var to be filled with the result.
    }
    function TableExists(const aTableName   : string;
                         const aPassword    : UnicodeString;
                           out aExists      : Boolean;
                               aAllowSystem : Boolean = False)
                                            : TnxResult; virtual; abstract;
    { With TableGetDictionary you can fill a TnxDataDictionary
      instance with the information about an existing table.

      Parameters
      aTableName :   the name of the source table
      aDictionary :  the instance of TnxDataDictionary that should be
                     filled with the information.                     }
    function TableGetDictionary(const aTableName  : string;
                                const aPassword   : UnicodeString;
                                      aDictionary : TnxDataDictionary)
                                                  : TnxResult; virtual; abstract;
    { TableGetList fills the given aList with all table names of the current
      database. }
    function TableGetList(aList : TStrings)
                                : TnxResult; virtual; abstract;

    { This function returns the next AutoInc value for the specified table. }
    function TableAutoIncGet(const aTableName  : string;
                             const aPassword   : UnicodeString;
                               out aValue      : TnxWord32)
                                               : TnxResult; virtual; abstract;

    { Returns the names of tables the have been changed since this function
      was last called. }
    function GetChangedTables(aTables : TStrings)
                                      : TnxResult; virtual; abstract;

    {-- table stream access shortcut --}
    function TableStreamRead(const aTableName  : string;
                             const aPassword   : UnicodeString;
                             const aStreamName : string;
                                   aStream     : TStream)
                                               : TnxResult; virtual;

    function TableStreamWrite(const aTableName  : string;
                              const aPassword   : UnicodeString;
                              const aStreamName : string;
                                    aStream     : TStream)
                                                : TnxResult; virtual;


    {-- transaction management --}
    { StartTransaction tries to start a transaction. If it fails an exception is triggered.
      Parameters:
        aFailsafe: if true it must be handled as fail safe.
        aSnapshot: if true it is handled as a SnapshotTransaction
    }
    function TransactionStart(aFailSafe   : Boolean;
                              aSnapShot   : Boolean)
                                          : TnxResult; override;
    { Start a transaction if an exclusive lock can be granted on all specified cursors.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aFailsafe: if true it must be handled as fail safe.
        aSnapshot: if true it is handled as a SnapshotTransaction
        aCursors: the cursors that should be part of the transaction
    }
    function TransactionStartWith(aFailSafe   : Boolean;
                                  aSnapShot   : Boolean;
                            const aCursors    : array of TnxAbstractCursor)
                                              : TnxResult; override;

    { Requires an active transaction, attempts to gain a shared or exclusive lock
      on all specified cursors.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aExclusive : Requests exclusive locks if true, otherwise shared locks are requested.
        aCursors   : The cursors that should be part of the transaction.
    }
    function TransactionInclude(aExclusive : Boolean;
                          const aCursors   : array of TnxAbstractCursor)
                                           : TnxResult; override;

    { This method commits a pending transaction (level). If an
      error occurs (e.g. deadlock detected or transaction level has
      been marked as corrupted) the transaction is <B>not</B>
      automatically rolled back.                                    }
    function TransactionCommit : TnxResult; override;
    { Rollback rolls (as the name says) back a pending transaction (level). All
      changes since the last StartTransaction (or equivalent) call are lost.
    }
    function TransactionRollback : TnxResult; override;
    { This method marks the transaction (level) as corrupted and
      thus preventing it from ever being committed.              }
    function TransactionCorrupted : TnxResult; override;

    { This method returns the nesting level of the current transaction. }
    function TransactionGetLevel(out aTransLevel : Integer)
                                                 : TnxResult; override;

    { This method returns the nesting level of the current transaction. }
    function TransactionGetInfo(out aTransInfo   : TnxTransactionInfo;
                                    aAllowCached : Boolean = True)
                                                 : TnxResult; override;
    {-- cursor --}

    { This function opens a new cursor for a table and returns an
      instance of a descendent of TnxAbstractCursor. Each table can
      have as many Cursors as wanted active at the same time
                               Parameters
      aCursor :       the returned instance
      aTransContext : transaction context for the cursor, can be nil, in which case the database is used as transaction context
      aTableName :    the name of the table the cursor should be
                      created for
      aOpenMode :     the mode you want to open the cursor for
      aShareMode :    defines how the Cursor should handle sharing
      aTimeout :      the timeout for the cursor in msec
      aDictionary :   the dictionary of the table the cursor is
                      created for                                    }
    function CursorOpen(out aCursor        : TnxAbstractCursor;
                            aTransContext  : TnxAbstractTransContext;
                      const aTableName     : string;
                      const aPassword      : UnicodeString;
                            aOpenMode      : TnxOpenMode;
                            aShareMode     : TnxShareMode;
                            aTimeout       : TnxWord32;
                            aIndexName     : string;
                            aIndexID       : Integer;
                            aAllowSystem   : Boolean = False;
                            aOpenOptions   : TnxCursorOpenOptions = [];
                            aFilterTimeout : TnxWord32 = nxDefaultFilterTimeout;
                            aMarkedBlobs   : TStrings = nil)
                                           : TnxResult; virtual; abstract;
    function CursorCacheOpen(out aCursor        : TnxAbstractCursor;
                                 aTransContext  : TnxAbstractTransContext;
                           const aTableName     : string;
                           const aPassword      : UnicodeString;
                                 aOpenMode      : TnxOpenMode;
                                 aShareMode     : TnxShareMode;
                                 aTimeout       : TnxWord32;
                                 aIndexName     : string;
                                 aIndexID       : Integer;
                                 aAllowSystem   : Boolean = False;
                                 aOpenOptions   : TnxCursorOpenOptions = [];
                                 aFilterTimeout : TnxWord32 = nxDefaultFilterTimeout)
                                                : TnxResult; virtual;
    {
      This function creates a new instance of a SQL statement. It
      does NOT execute the query! Paremeters: aStatement: the
      returned statement instance aTimeout: the timeout for the new
      statement in msec                                             }
    function StatementAlloc(out aStatement : TnxAbstractStatement;
                                aTimeout   : TnxWord32)
                                           : TnxResult; virtual; abstract;

    {
      This function creates and exexutes a given SQL query or stored procedure
      and returns a cursor to the result set.

      Parameters:
        aTimeout - Timeout in ms
        aStatementType - indicates if this is a stored procedure or standard query
        aQueryText - the SQL query
        aPrepareStream - data returned by the prepare phase
        aParams - the list of parameter defintions used for preparing and executing
        aSetParamsStream - data returned by the setparams phase
        aCursor - the new cursor returned
        aOpenMode - the open mode for the cursor
        aExecStream - data returned by the exec phase
        aGetParamsStream - out-parameter stream
        aPhase - returns the phase the query is in
    }
    function StatementExecDirect(aTimeout         : TnxWord32;
                                 aStatementType   : TnxStatementType;
                           const aQueryText       : WideString;
                                 aPrepareStream   : TStream;

                           const aParams          : TnxSqlParamList;
                                 aSetParamsStream : TStream;

                             out aCursor          : TnxAbstractCursor;
                                 aOpenMode        : TnxOpenMode;
                                 aExecStream      : TStream;

                                 aGetParamsStream : TStream;

                             out aPhase           : TnxStatementExecDirectPhase)
                                                  : TnxResult; virtual; abstract;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    {-- info --}

    {This function returns the free space of the device the database is stored
     on. Result is in bytes. }
    function GetFreespace(out aFreeSpace : TnxInt64)
                                         : TnxResult; virtual; abstract;

    { \Returns the (file) path of the current database. }
    function GetPath(out aPath : string)
                               : TnxResult; virtual; abstract;
    { \Returns the (file) path of the current database. }
    function GetAlias(out aAlias : string)
                                 : TnxResult; virtual; abstract;

    { This property returns the transaction context the database is linked to. }
    property TransContext: TnxAbstractTransContext
      read adTransContext;
    property ExplicitAllowSystem: boolean
      read adGetExplicitAllowSystem;
  end;

  { The abstract declaration of a Server transaction context. All actual
    transaction context implementations MUST be descendent from this class.
    This is the server side version of TnxTransContext.              }
  TnxAbstractTransContext = class(TnxBaseTransContext)
  protected {private}
    atcFailed            : Boolean;
    atcLockedIncDone     : Boolean;

    atcSessionPrev       : TnxAbstractTransContext;
    atcSessionNext       : TnxAbstractTransContext;

    atcDatabasesPadlock  : TnxPadlock;
    atcDatabasesHead     : TnxAbstractDatabase;
    atcDatabasesTail     : TnxAbstractDatabase;
    atcCursorsPadlock    : TnxPadlock;
    atcCursorsHead       : TnxAbstractCursor;
    atcCursorsTail       : TnxAbstractCursor;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    procedure atcAddToSession;
    procedure atcRemoveFromSession;

    procedure atcForceRollback; virtual;
  public
    { constructor
      Parameters:
        aSession - the session object the transaction context belongs to
        aTimeout - the timeout for this TransContext in msec
    }
    constructor Create(aSession : TnxAbstractSession;
                       aTimeout : TnxWord32);
    { destructor. }
    destructor Destroy; override;

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    procedure PrepareDestroy; override;

    {-- internal --}
    procedure Failed; virtual;

    {-- caching --}
    function SetCacheTransContext(aCacheTransContext : TnxBaseTransContext;
                                  aAutoFree          : Boolean)
                                                     : TnxResult; virtual;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    {-- info --}

    { Returns the previous TransContext in the list of contexts for *this* session. }
    property SessionPrev : TnxAbstractTransContext
      read atcSessionPrev;
    { Returns the next TransContext in the list of contexts for *this* session. }
    property SessionNext : TnxAbstractTransContext
      read atcSessionNext;
  end;

  TnxPosnOnRec = (
    porFalse,
    porTrue,
    porTry
  );

  TnxFilterAction = (
    faActivate,
    faDeactivate,
    faRemove
  );

  { Used internally to address the different key buffers. }
  PnxDataSetKeyBuffer = ^TnxDataSetKeyBuffer;
  PPnxDataSetKeyBuffer = ^PnxDataSetKeyBuffer;
  { Used internally to address the different key buffers. }
  TnxDataSetKeyBuffer = record
    { \internal use only. }
    kbFieldCount: Integer;
    { \internal use only. }
    kbPartialLen: Integer;
    { \internal use only. }
    kbModified  : Boolean;
    { \internal use only. }
    kbExclusive : Boolean;
    { \internal use only. }
    kbDirectKey : Boolean;
    { \internal use only. }
    kbPadding   : Boolean;
    { \followed by a key or record buffer depending on the value of kbDirectKey }
    kbBuffer    : TnxNullType;
  end;
  TnxDataSetKeyBufferArray = array of PnxDataSetKeyBuffer;

  TnxBatchStreamAccess = class;

  TnxAbstractCursorState = (
   acsAutoFreeDatabase,
   acsLockedIncDone,
   acsIsCacheable,
   acsIsCache
  );

  TnxAbstractCursorStates = set of TnxAbstractCursorState;

  TnxAbstractRemoteCursor = class;
  TnxAbstractServerCursor = class;

  TnxRecordDiffBlobBatch = record
    rdbbRequest : PnxBlobBatchRequest;
    rdbbReply   : PnxBlobBatchReply;
  end;

  TnxRecordDiff = record
    rdDiff: PnxRecordBuffer;
    rdFull: PnxRecordBuffer;
    rdBlobBatch: TnxRecordDiffBlobBatch;
  end;
  PnxRecordDiff = ^TnxRecordDiff;

  TnxCancelServerFilterEvent = function: Boolean of object;

  { The abstract declaration of a Server cursor. All actual
    cursor implementations must be descended from this class.
    This is the server side version of TnxCursor.              }
  TnxAbstractCursor = class(TnxAbstractTimeoutObject, InxFieldsSource, InxFieldsAccess)
  protected {private}
    acDatabase             : TnxAbstractDatabase;
    acDatabasePrev         : TnxAbstractCursor;
    acDatabaseNext         : TnxAbstractCursor;

    acTransContext         : TnxAbstractTransContext;
    acTransContextPrev     : TnxAbstractCursor;
    acTransContextNext     : TnxAbstractCursor;

    acFieldsDescriptor     : TnxFieldsDescriptor;

    acCacheableInfo        : PnxCacheableInfo;
    acSFI                  : PnxSpecialFieldsInfo;
    acDCI                  : PnxDiffCompressorInfo;

    acMarkedBlobs          : TnxMarkedBlobsByBlobIdx;

    acRecordLength         : TnxWord32;

    acReadOrgOverride      : Integer;

    acOptions              : TnxAbstractCursorOptions;
    acCapabilities         : TnxAbstractCursorCapabilities;
    acStates               : TnxAbstractCursorStates;

    acOnCancelServerFilter : TnxCancelServerFilterEvent;

    function ac_GetDictionary: TnxDataDictionary; virtual; abstract;
    function acGetTableDescriptor: TnxBaseTableDescriptor; virtual; abstract;
    function acGetFieldsDescriptor: TnxFieldsDescriptor;
    function acGetFullName: string; virtual; abstract;
    function acGetAliasName: string; virtual;
    function acGetIsCache: Boolean;
    function acGetDCI: PnxDiffCompressorInfo; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function acGetCurrentTransContext: TnxBaseTransContext;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    procedure acAddToDatabase;
    procedure acRemoveFromDatabase;

    procedure acAddToTransContext;
    procedure acRemoveFromTransContext;
    procedure acTransContextDestroying; virtual;

    function acCancelServerFilter: Boolean;
  public
    { InxFieldsSource }
    property FieldsDescriptor: TnxFieldsDescriptor
      read acGetFieldsDescriptor;

    function GetFieldForFilterRedirect(aField    : Integer;
                                       aName     : PAnsiChar;
                                       aData     : PnxRecordBuffer;
                                   out aType     : TnxWord16;
                                   out aSize     : TnxWord16;
                                   out aIsNull   : Boolean;
                                   out aValue    : PnxFieldBuffer;
                                   out aCodePage : TnxWord16)
                                                 : Boolean;
    function GetFieldFromNameRedirect(const aFieldName : string) : Integer;
    function GetFieldCountRedirect: Integer;
    function GetFieldDescriptorRedirect(aIndex: Integer): InxFieldDescriptor;
    function GetFieldsOffsetRedirect: integer;

    function InxFieldsSource.GetFieldForFilter = GetFieldForFilterRedirect;
    function InxFieldsSource.GetFieldFromName = GetFieldFromNameRedirect;
    function InxFieldsSource.GetFieldCount = GetFieldCountRedirect;
    function InxFieldsSource.GetFieldDescriptor = GetFieldDescriptorRedirect;
    function InxFieldsSource.GetFieldsOffset = GetFieldsOffsetRedirect;

    function InxFieldsAccess.GetFieldForFilter = GetFieldForFilterRedirect;
    function InxFieldsAccess.GetFieldFromName = GetFieldFromNameRedirect;
    function InxFieldsAccess.GetFieldCount = GetFieldCountRedirect;
    function InxFieldsAccess.GetFieldDescriptor = GetFieldDescriptorRedirect;
    function InxFieldsAccess.GetFieldsOffset = GetFieldsOffsetRedirect;

    function GetFieldAsVariantSelf(aBuffer : PnxRecordBuffer;
                                   aField  : Integer)
                                           : OleVariant;

    procedure SetFieldAsVariantSelf(aBuffer : PnxRecordBuffer;
                                    aField  : Integer;
                              const aValue  : OleVariant); virtual;

    function BlobsSupportedSelf: Boolean;
    function GetCursorSelf: TObject;

    function InxFieldsSource.GetFieldAsVariant = GetFieldAsVariantSelf;
    function InxFieldsSource.BlobsSupported = BlobsSupportedSelf;
    function InxFieldsSource.GetCursor = GetCursorSelf;

    procedure InxFieldsAccess.SetFieldAsVariant = SetFieldAsVariantSelf;
    function InxFieldsAccess.GetFieldAsVariant = GetFieldAsVariantSelf;
    function InxFieldsAccess.BlobsSupported = BlobsSupportedSelf;
    function InxFieldsAccess.GetCursor = GetCursorSelf;

    function BeginReadOrgOverride: Integer;
    function EndReadOrgOverride: Integer;

    property SFI: PnxSpecialFieldsInfo
      read acSFI;

    property DCI: PnxDiffCompressorInfo
      read acGetDCI;

    property CurrentTransContext: TnxBaseTransContext
      read acGetCurrentTransContext;
  protected
    {-- blob managment --}
    function acSnapshotRequiredForBlobRead(const aRecID   : TnxRecID;
                                                 aFieldNo : TnxInt32;
                                                 aBlobNr  : TnxBlobNr;
                                                 aReadOrg : Boolean)
                                                          : Boolean; virtual;

    function acTransactionStartForBlobReadSnapshoted: TnxResult; virtual;
    function acTransactionRollbackForBlobReadSnapshoted: TnxResult; virtual;

    procedure acSetupDescriptorDependentFields; virtual;
  public
    IsResultSet      : Boolean;
    IsUnnamed        : Boolean;

    { Constructor
      Parameters:
        aDatabase - the database object the cursor belongs to.
        aTimeout - the timeout for this cursor in msec.
    }
    constructor Create(aDatabase    : TnxAbstractDatabase;
                       aTransContext : TnxAbstractTransContext;
                       aTimeout     : TnxWord32);
    { destructor. }
    destructor Destroy; override;

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    function AddCursorOption(aOption: TnxAbstractCursorOption): Boolean;
    function RemoveCursorOption(aOption: TnxAbstractCursorOption): Boolean;

    function AddCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
    function RemoveCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;

    function HasAnyCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
    function HasAllCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;

    function SavePath: TnxResult; virtual;
    function RestorePath: TnxResult; virtual;

    { This function can be called from an extender to request that the cursor
      uses nested transactions for all operations. By default this is not supported. }
    procedure RequestNestedTransactions; virtual;

    { helper functions for record buffer management }
    function RecordBufferAlloc: PnxRecordBuffer; virtual;
    procedure RecordBufferFree(aBuffer: PnxRecordBuffer); virtual;
    procedure RecordBufferClear(aBuffer: PnxRecordBuffer); virtual;

    function acGetRecID(aBuffer: PnxRecordBuffer): TnxRecID;

    { * - transaction context - *
      This function sets the transaction context for the cursor, can be nil,
      in which case the cursor is using it's database as it's transaction context. }
    function TransContextSet(aTransContext : TnxAbstractTransContext)
                                           : TnxResult; virtual; abstract;

    { * - navigation - *
      This function sets the cursor position to the begin of the
      dataset. This is not the first record but before it!       }
    function SetToBegin : TnxResult; virtual; abstract;
    { This function synchronizes the position with the given aCursor. Please note
      that the two cursor have to point to the same dataset. }
    function SetToCursor(aCursor : TnxAbstractCursor)
                                 : TnxResult; virtual; abstract;
    { This function sets the cursor position to the end of the dataset. This
      is NOT the last record but after it! }
    function SetToEnd : TnxResult; virtual; abstract;
    { This function sets the cursor position before the first record that meets
      the filter criteria in aFilter. }
    function SetToFilter(aFilter    : TnxBaseFilterDescriptor;
                         aKeyFilter : TnxBaseFilterDescriptor;
                         aForward   : TnxBoolean)
                                    : TnxResult; virtual; abstract;

    {-- bookmarks --}
    function sbcGetBookmarkSize(out aSize : TnxWord32)
                                          : TnxResult; virtual; abstract;

    { This function creates a new bookmark
      Paremeters:
        aBookmark - a buffer to receive the Bookmark data
        aSize - the size of the given buffer }
    function GetBookmark(aBookmark : PnxBookmarkBuffer;
                         aSize     : TnxWord32)
                                   : TnxResult; virtual; abstract;

    { This function creates a new bookmark. Only supported by cache tables.
      The RefNr in the bookmark will refer to the RefNr of the original table,
      not the cache table.
      Paremeters:
        aBookmark - a buffer to receive the Bookmark data
        aSize - the size of the given buffer }
    function GetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32)
                                        : TnxResult; virtual;
    { This function compares two bookmarks.
      Parameters:
        aBookmark1 - first Bookmark
        aBookmark2 - second Bookmark
        aSize - the size of the bookmarks
        aCompResult - the var that will receive the result
    }
    function CompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                              aBookmark2  : PnxBookmarkBuffer;
                              aSize       : TnxWord32;
                          out aCompResult : TnxValueRelationship)
                                          : TnxResult; virtual; abstract;
    { This function will position the cursor on the given bookmark
      Parameters:
        aBookmark - the data of the bookmark
        aSize - size of the bookmark data
    }
    function SetToBookmark(aBookmark : PnxBookmarkBuffer;
                           aSize     : TnxWord32)
                                     : TnxResult; virtual; abstract;
    function SetToCacheBookmark(aBookmark : PnxBookmarkBuffer;
                                aSize     : TnxWord32)
                                          : TnxResult; virtual;

    { Return a given bookmark as Variant
      Parameters:
        aBookmark - the data of the bookmark
        aSize - size of the bookmark data
        aVariant - the new variant value returned
    }
    function BookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                               aSize     : TnxWord32;
                           out aVariant  : Variant)
                                         : TnxResult; virtual; abstract;

    function BookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                aSize     : TnxWord32)
                                          : TnxResult; virtual;

    function BookmarkClear(aBookmark : PnxBookmarkBuffer;
                           aSize     : TnxWord32)
                                     : TnxResult; virtual;

    {-- recno support --}

    { Returns DBIERR_NONE if RecNo is supported. }
    function RecNoSupported: TnxResult; virtual; abstract;

    {

      \Returns the RecNo (Position) of the current record according
      to the current Index, Range and Filter(s). (using
      filters/indices is not recommended if that table (subset)
      contains more than a few data pages of records!).             }
    function RecNoGet(out aRecNo     : TnxWord32;
                          aFlipOrder : Boolean)
                                     : TnxResult; virtual; abstract;

    {  Sets the current position according to the RecNo }
    function RecNoSet(aRecNo     : TnxWord32;
                      aFlipOrder : Boolean)
                                 : TnxResult; virtual; abstract;

    {-- record retrival --}

    { RecordGet returns a pointer to the current record buffer. It
      needs to be able to acquire the given lock type for this
      function to be successful.                                   }
    function RecordGet(aLockType : TnxLockType;
                       aData     : PnxRecordBuffer)
                                 : TnxResult; virtual; abstract;
    { RecordGet moves to the next valid (in regards of ranges and
      filters) record returns a pointer to the then current record
      buffer. It needs to be able to acquire the given lock type
      for this function to be successful.                          }
    function RecordGetNext(aLockType : TnxLockType;
                           aData     : PnxRecordBuffer)
                                     : TnxResult; virtual; abstract;
    { RecordGet moves to the prior valid (in regards of ranges and
      filters) record returns a pointer to the then current record
      buffer. It needs to be able to acquire the given lock type
      for this function to be successful.                          }
    function RecordGetPrior(aLockType : TnxLockType;
                            aData     : PnxRecordBuffer)
                                      : TnxResult; virtual; abstract;

    {-- record manipulation --}

    { RecordInsert creates a new record and returns a pointer to
      the then current record buffer. It needs to be able to
      acquire the given lock type for this function to be
      successful.                                                }
    function RecordInsert(aLockType : TnxLockType;
                          aData     : PnxRecordBuffer;
                          aAutoInc  : PnxInt64 = nil)
                                    : TnxResult; virtual; abstract;

    { RecordInsert sets the record buffer to the given data. The record must
      have a proper lock acquired for this function to succeed. If aReleaseLock
      is true all locks on the current record are released. }
    function RecordModify(aData        : PnxRecordBuffer;
                          aReleaseLock : Boolean;
                          aDataDiff    : PnxRecordDiff = nil)
                                       : TnxResult; virtual; abstract;
    { RecordDelete deletes the current record and returns a copy of the latest
      record buffer in the optionally passed aData. It needs to be able to
      acquire a write lock on the record for this function to be
      successful. Take note that any blob references inside that record buffer
      will be invalid and inaccesible by the time the function returns. }
    function RecordDelete(aData : PnxRecordBuffer;
                          aLSN  : TnxLSN = 0)
                                : TnxResult; virtual; abstract;

    {-- record locks --}

    { RecordIsLocked returns the current record lock state for a certain lock type.
      Parameters:
        aLockType - the type of lock you want to check.
        aLockPresent - the state of the given lock type
    }
    function RecordIsLocked(aLockType    : TnxLockType;
                        out aLockPresent : TnxLockPresent)
                                         : TnxResult; virtual; abstract;
    { This function releases the last lock or alternatively all
      locks in the record.
    }
    function RecordLockRelease(aAllLocks    : Boolean;
                               aCancelBlobs : Boolean)
                                            : TnxResult; virtual; abstract;

    {-- autoinc --}
    { This function returns the next AutoInc value for the current table. }
    function AutoIncGet(out aValue       : TnxWord32;
                            aAllowCached : Boolean = False)
                                         : TnxResult; virtual; abstract;
    { This function sets the next AutoInc value for the current table. }
    function AutoIncSet(aValue : TnxWord32)
                               : TnxResult; virtual; abstract;

    {-- filters --}

    { FilterAddExpression creates a new Filter instance for the
      given aExpression and returns its in aFilterID.           }
    function FilterAddExpression(aExpression : pCANExpr;
                             out aFilterID   : TnxFilterID;
                                 aActivated  : Boolean)
                                             : TnxResult; virtual;
    { Adds a new callback function to the filter valuation list. }
    function FilterAddCallback(aCookie   : Pointer;
                               aCallback : TnxFilterCallback;
                           out aFilterID : TnxFilterID;
                               aActivated: Boolean)
                                         : TnxResult; virtual;
    { Adds a new filter to the filter evaluation list. }
    function FilterAddCustom(aFilter   : TnxBaseFilterDescriptor;
                         out aFilterID : TnxFilterID;
                             aActivated: Boolean)
                                       : TnxResult; virtual; abstract;
    { Replaces a filter. aFilterID is filter to be dropped on entry
      and new filter on exit. If aFilterID is 0 on entry, all existing
      filters are dropped. If the filter couldn't be dropped and aIgnoreDropError
      is not set, the function returns with an error and aFilterID remains
      unchanged }
    function FilterReplaceCustom(aFilter          : TnxBaseFilterDescriptor;
                             var aFilterID        : TnxFilterID;
                                 aActivated       : Boolean;
                                 aIgnoreDropError : Boolean)
                                                  : TnxResult; virtual; abstract;

    { This function sets the timeout for the filter evaluation in msec. }
    function FilterSetTimeout(aTimeout : TnxWord32)
                                       : TnxResult; virtual; abstract;

    { This function sets the given Filter to active. }
    function FilterActivate(aFilterID : TnxFilterID)
                                      : TnxResult; virtual; abstract;
    { This function sets the given Filter to inactive. }
    function FilterDeactivate(aFilterID : TnxFilterID)
                                        : TnxResult; virtual; abstract;

    { This function removes the given Filter from the internal list. }
    function FilterRemove(aFilterID : TnxFilterID)
                                    : TnxResult; virtual; abstract;

    function HasActiveLocalFilter: Boolean; virtual;
    procedure FilterBeginTimeout; virtual;
    function FilterMatchesBuffer(aBuffer : PnxRecordBuffer)
                                         : Boolean; virtual;

    {-- index support --}

    { SwitchToIndex activates the given index. It aPosOnRec it
      repositions the cursor to the record active before changing
      the index, otherwise it jumps to the first record.

      Parameters
      aIndexName :  the name of the index
      aIndexId :    the id of the index in the dictionary
      aPosnOnRec :  if true it keeps the current record active    }
    function SwitchToIndex(const aIndexName : string;
                                 aIndexID   : Integer;
                                 aPosnOnRec : TnxPosnOnRec)
                                            : TnxResult; virtual; abstract;
    { This function returns the id of the current index. }
    function GetIndexID(out aIndexID : Integer)
                                     : TnxResult; virtual; abstract;

    { SetToKey positions the cursor relative to a specific key, The cursor is always
      positioned on a crack. For skaEqualLast, skaSmallerEqual and skaSmaller it's
      the crack after the matching key, otherwise the crack before.

      Parameters:
      aSearchAction : defines the relationship between the passed in key and
                      the key the cursor is positioned on.
      aFieldCount   : number of fields to be compared. 0 = all fields
      aPartialLen   : number of characters yo compare for the last field. 0 = no partial compare
      aDirectKey    : True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData      : The data according to the format defined by aDirectKey.
    }
    function SetToKey(aSearchAction : TnxSearchKeyAction;
                      aFieldCount   : Integer;
                      aPartialLen   : Integer;
                      aDirectKey    : Boolean;
                      aKeyData      : PnxKeyOrRecordBuffer)
                                    : TnxResult; overload; virtual; abstract;

    function SetToKey(aSearchAction : TnxSearchKeyAction;
                      aFieldCount   : Integer;
                      aPartialLen   : Integer;
                      aKeyData      : PnxKeyBuffer)
                                    : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function SetToKey(aSearchAction : TnxSearchKeyAction;
                      aFieldCount   : Integer;
                      aPartialLen   : Integer;
                      aKeyData      : PnxRecordBuffer)
                                    : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    { RecordGetForKey positions the cursor on the first/last record that matches
      the passed in key and returns the record.

      Parameters:
      aFieldCount   : number of fields to be compared. 0 = all fields
      aPartialLen   : number of characters to compare for the last field. 0 = no partial compare
      aDirectKey    : True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData      : The data according to the format defined by aDirectKey.
      aData         : used to return the record once it has been found. can be nil.
      aMatchFirst   : matches the first (True) or lsat (False) record that matches the key.
      aFirstCall    : must be true on the first call. If the function returns DBIERR_NX_FILTERTIMEOUT
                      keep calling the function with the same parameters and aFirstCall set to false till
                      another result is returned.
    }
    function RecordGetForKey(aFieldCount : Integer;
                             aPartialLen : Integer;
                             aDirectKey  : Boolean;
                             aKeyData    : PnxKeyOrRecordBuffer;
                             aData       : PnxRecordBuffer;
                             aMatchFirst : Boolean;
                             aFirstCall  : Boolean)
                                         : TnxResult; overload; virtual; abstract;

    function RecordGetForKey(aFieldCount : Integer;
                             aPartialLen : Integer;
                             aKeyData    : PnxRecordBuffer;
                             aData       : PnxRecordBuffer;
                             aMatchFirst : Boolean;
                             aFirstCall  : Boolean)
                                         : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function RecordGetForKey(aFieldCount : Integer;
                             aPartialLen : Integer;
                             aKeyData    : PnxKeyBuffer;
                             aData       : PnxRecordBuffer;
                             aMatchFirst : Boolean;
                             aFirstCall  : Boolean)
                                         : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}


    { For each key in aKeys, RecordGetForKeyBatch positions the cursor on the
      first/last record that matches that key and returns either that record
      or an error code in aStream. The format of aStream is identical to the
      stream returned by RecordGetForKeyBatch.

      Parameters:
      aCutoffSize : The function will stop after the size of the stream exceeds this size.
      aOptions    : The options to use for filling the stream, such as including BLOB or bookmark data.
      aStream     : The stream that receives the data.
      aKeys       : The array of keys to search for.
      aMatchFirst : Matches the first (True) or last (False) record if there are
                    multiple with the same key.
      aFirstCall  : Must be True on the first call. If the function returns
                    DBIERR_NX_FILTERTIMEOUT, keep calling the function with the same
                    parameters and aFirstCall set to False until another result is returned. }
    function RecordGetForKeyBatch(aCutoffSize : Integer;
                                  aOptions    : TnxRecordGetBatchExOptions;
                              var aAccess     : TnxBatchStreamAccess;
                            const aKeys       : TnxDatasetKeyBufferArray;
                                  aMatchFirst : Boolean;
                                  aFirstCall  : Boolean)
                                              : TnxResult; virtual; abstract;

    { This function cancels the active range. }
    function RangeReset : TnxResult; virtual; abstract;

    { Sets a range on the current cursor

      Parameters:
      aFieldCount1   : For start of the range, number of fields to be compared. 0 = all fields
      aPartialLen1   : For start of the range, number of characters yo compare for the last field. 0 = no partial compare
      aDirectKey1    : For start of the range, True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData1      : For start of the range, The data according to the format defined by aDirectKey1.
      aKeyIncl1      : For start of the range, does the range include the key or starts after the key?
      aFieldCount2   : For end of the range, number of fields to be compared. 0 = all fields
      aPartialLen2   : For end of the range, number of characters yo compare for the last field. 0 = no partial compare
      aDirectKey2    : For end of the range, True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData2      : For end of the range, The data according to the format defined by aDirectKey2.
      aKeyIncl2      : For end of the range, does the range include the key or starts after the key?
    }
    function RangeSet(aFieldCount1 : Integer;
                      aPartialLen1 : Integer;
                      aDirectKey1  : Boolean;
                      aKeyData1    : PnxKeyOrRecordBuffer;
                      aKeyIncl1    : Boolean;
                      aFieldCount2 : Integer;
                      aPartialLen2 : Integer;
                      aDirectKey2  : Boolean;
                      aKeyData2    : PnxKeyOrRecordBuffer;
                      aKeyIncl2    : Boolean)
                                   : TnxResult; overload; virtual; abstract;

    function RangeSet(aFieldCount1 : Integer;
                      aPartialLen1 : Integer;
                      aKeyData1    : PnxRecordBuffer;
                      aKeyIncl1    : Boolean;
                      aFieldCount2 : Integer;
                      aPartialLen2 : Integer;
                      aKeyData2    : PnxRecordBuffer;
                      aKeyIncl2    : Boolean)
                                   : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function RangeSet(aFieldCount1 : Integer;
                      aPartialLen1 : Integer;
                      aKeyData1    : PnxKeyBuffer;
                      aKeyIncl1    : Boolean;
                      aFieldCount2 : Integer;
                      aPartialLen2 : Integer;
                      aKeyData2    : PnxKeyBuffer;
                      aKeyIncl2    : Boolean)
                                   : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function RangeSet(aFieldCount1 : Integer;
                      aPartialLen1 : Integer;
                      aKeyData1    : PnxKeyBuffer;
                      aKeyIncl1    : Boolean;
                      aFieldCount2 : Integer;
                      aPartialLen2 : Integer;
                      aKeyData2    : PnxRecordBuffer;
                      aKeyIncl2    : Boolean)
                                   : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function RangeSet(aFieldCount1 : Integer;
                      aPartialLen1 : Integer;
                      aKeyData1    : PnxRecordBuffer;
                      aKeyIncl1    : Boolean;
                      aFieldCount2 : Integer;
                      aPartialLen2 : Integer;
                      aKeyData2    : PnxKeyBuffer;
                      aKeyIncl2    : Boolean)
                                   : TnxResult; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    { CompareKeys compares 2 keys.

      Parameters:
      aFieldCount   : number of fields to be compared. 0 = all fields
      aPartialLen   : number of characters yo compare for the last field. 0 = no partial compare
      aDirectKey1   : True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData1     : The data according to the format defined by aDirectKey1.
      aDirectKey2   : True = passed in data is directly a key, False = passed in data is a record and the key is extracted.
      aKeyData2     : The data according to the format defined by aDirectKey2.
      aResult       : returns the result of the comparison.
    }
    function CompareKeys(aFieldCount : Integer;
                         aPartialLen : Integer;
                         aDirectKey1 : Boolean;
                         aKeyData1   : PnxKeyOrRecordBuffer;
                         aDirectKey2 : Boolean;
                         aKeyData2   : PnxKeyOrRecordBuffer;
                     out aResult     : TnxValueRelationship)
                                     : TnxResult; virtual; abstract;

    function BuildKey(aRecord       : PnxRecordBuffer;
                      aKey          : PnxKeyBuffer;
                      aIgnoreFilter : Boolean)
                                    : TnxResult; virtual;

    function KeyToRecord(aKey    : PnxKeyBuffer;
                         aRecord : PnxRecordBuffer)
                                 : TnxResult; virtual;

    {-- key filters --}

    { KeyFilterAddExpression creates a new KeyFilter instance for the
      given aExpression and returns its in aKeyFilterID.           }
    function KeyFilterAddExpression(aExpression  : pCANExpr;
                                out aKeyFilterID : TnxKeyFilterID;
                                    aActivated   : Boolean)
                                                 : TnxResult; virtual;
    { Adds a new callback function to the filter valuation list. }
    function KeyFilterAddCallback(aCookie      : Pointer;
                                  aCallback    : TnxFilterCallback;
                              out aKeyFilterID : TnxKeyFilterID;
                                  aActivated   : Boolean)
                                               : TnxResult; virtual;
    { Adds a new filter to the filter evaluation list. }
    function KeyFilterAddCustom(aKeyFilter   : TnxBaseFilterDescriptor;
                            out aKeyFilterID : TnxKeyFilterID;
                                aActivated   : Boolean)
                                             : TnxResult; virtual; abstract;

    { Replaces a filter. aKeyFilterID is filter to be dropped on entry
      and new filter on exit. If aKeyFilterID is 0 on entry, all existing
      filters are dropped. If the filter couldn't be dropped and aIgnoreDropError
      is not set, the function returns with an error and aKeyFilterID remains
      unchanged }
    function KeyFilterReplaceCustom(aKeyFilter       : TnxBaseFilterDescriptor;
                                var aKeyFilterID     : TnxKeyFilterID;
                                    aActivated       : Boolean;
                                    aIgnoreDropError : Boolean)
                                                     : TnxResult; virtual; abstract;

    { This function sets the given KeyFilter to active. }
    function KeyFilterActivate(aKeyFilterID : TnxKeyFilterID)
                                            : TnxResult; virtual; abstract;
    { This function sets the given KeyFilter to inactive. }
    function KeyFilterDeactivate(aKeyFilterID : TnxKeyFilterID)
                                              : TnxResult; virtual; abstract;

    { This function removes the given KeyFilter from the internal list. }
    function KeyFilterRemove(aKeyFilterID : TnxKeyFilterID)
                                          : TnxResult; virtual; abstract;

    {-- batch operations --}

    { Returns a batch of record data in the given stream.

      Parameters:
      aCutoffSize : The function will stop after the size of the stream exceeds this size.
      aOptions    : The options to use for filling the stream, such as including BLOB or bookmark data.
      aStream     : The stream that receives the data.
      aMaxRecords : The maximum number of records to return. Defaults to -1 (no limit).
      aForward    : Specifies the direction of the cursor. If True, the cursor will be moved forward,
                    otherwise it will be moved backward.}
    function RecordGetBatch(aCutoffSize : Integer;
                            aOptions    : TnxRecordGetBatchExOptions;
                        var aAccess     : TnxBatchStreamAccess;
                            aMaxRecords : Integer = -1;
                            aForward    : Boolean = True)
                                        : TnxResult; virtual; abstract;
    { This function adds the data in a aStream as new records.
      Please note that the size of aStream must be a multiple of
      the record size.                                           }
    function RecordInsertBatch(aStream : TnxCustomMemoryStream)
                                       : TnxResult; virtual; abstract;
    { This function copies *all* visible (in regards of ranges and
      filters) records to the cursor given in aDestCursor.
      aMaxTransSize specifies the maximum number of dirty
      transaction bytes before the transaction is committed.       }
    function CopyRecords(aDestCursor   : TnxAbstractCursor;
                         aBlobCopyMode : TnxBlobCopyMode;
                         aMaxTransSize : Integer)
                                       : TnxResult; virtual; abstract;

    { This function copies *all* visible (in regards of ranges and
      filters) records to the cursor given in aDestCursor.
      aMaxTransSize specifies the maximum number of dirty
      transaction bytes before the transaction is committed.
      aCheckValFields determines wether a check is done for
      required fields having a value.                              }
    function CopyRecordsEx(aDestCursor     : TnxAbstractCursor;
                           aBlobCopyMode   : TnxBlobCopyMode;
                           aMaxTransSize   : Integer;
                           aCheckValFields : Boolean)
                                           : TnxResult; virtual; abstract;
    { This function deletes *all* visible (in regards of ranges and
      filters) records.                                             }
    function DeleteRecords : TnxResult; virtual; abstract;

    {-- blob managment --}

    function BlobsCancel(const aRefNr : TnxRefNr)
                                      : TnxResult; virtual; abstract;

    function BlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                var aReply   : TnxBlobBatchReply)
                                             : TnxResult; virtual;

    function BlobBatchApply(aData    : PnxRecordBuffer;
                      const aRequest : TnxBlobBatchRequest;
                      const aReply   : TnxBlobBatchReply)
                                     : TnxResult; virtual;

    function BlobBatchEntryApply(aData    : PnxRecordBuffer;
                           const aRecID   : TnxRecID;
                           const aRequest : TnxBlobBatchRequestEntry;
                           const aReply   : TnxBlobBatchReplyEntry)
                                          : TnxResult; virtual;

    { This function creates a new blob and returns the new blob
      reference number in aBlobNr. This number is unique for any
      blob and is needed to access the blob.                     }
    function BlobCreate(const aRecID   : TnxRecID;
                              aFieldNo : TnxInt32;
                          out aBlobNr  : TnxBlobNr)
                                       : TnxResult; virtual; abstract;
    { This creates a new FileBlob and returns the new blob
      reference number in aBlobNr. This number is unique for any
      blob and is needed to access the blob.                     }
    function BlobCreateFile(const aRecID    : TnxRecID;
                                  aFieldNo  : TnxInt32;
                            const aFileName : string;
                              out aBlobNr   : TnxBlobNr)
                                            : TnxResult; virtual; abstract;

    { This function deletes the blob with the given aBlobNr. }
    function BlobDelete(const aRecID   : TnxRecID;
                              aFieldNo : TnxInt32;
                        const aBlobNr  : TnxBlobNr)
                                       : TnxResult; virtual; abstract;

    { This function frees all temporary buffers for this blob. }
    function BlobFree(const aRecID   : TnxRecID;
                            aFieldNo : TnxInt32;
                      const aBlobNr  : TnxBlobNr)
                                     : TnxResult; virtual; abstract;

    { This function reads data from a blob.
      Parameters:
        aBlobNr - the blob reference number
        aOffset - a offset in bytes where to start to read
        aLen - the number of bytes to read
        aBlob - the buffer to receive the data
        aBytesRead - the number of bytes returned
        aReadOrg - for a record in edit mode which hasn't been
                   posted yet, reads the blob as it existed when
                   the record was locked
    }
    function BlobRead(const aRecID     : TnxRecID;
                            aFieldNo   : TnxInt32;
                      const aBlobNr    : TnxBlobNr;
                            aOffset    : TnxWord32;
                            aLen       : TnxWord32;
                            aStream    : TStream;
                            aReadOrg   : Boolean;
                            aNewBlobNr : PnxNewBlobNr)
                                       : TnxResult; virtual;
    function sbcBlobRead(const aRecID     : TnxRecID;
                               aFieldNo   : TnxInt32;
                         const aBlobNr    : TnxBlobNr;
                               aOffset    : TnxWord32;
                               aLen       : TnxWord32;
                               aStream    : TStream;
                               aReadOrg   : Boolean;
                               aNewBlobNr : PnxNewBlobNr)
                                          : TnxResult; virtual; abstract;

    { This function reads data from a blob.
      It can start/stop a snapshot transaction to ensure multiple calls
      to read a blob in chunks will produce a consisten result.

      Parameters:
        aBlobNr - the blob reference number
        aOffset - a offset in bytes where to start to read
        aLen - the number of bytes to read
        aBlob - the buffer to receive the data
        aBytesRead - the number of bytes returned
        aReadOrg - for a record in edit mode which hasn't been
                   posted yet, reads the blob as it existed when
                   the record was locked
        aSnapshot - can be used to request a snapshot transaction by
                    setting to brssRequestStart. The returned value indicates
                    the current state of any snapshot transaction.
                    If multiple calls are made to BlobReadSnapshoted the
                    returned value needs to be passed (usually unchanged) to
                    future calls. A started snapshot transaction is automatically
                    closed (rolled back) once an attempt is made to read beyond
                    the end of the blob. It's also possible to explicitly request
                    that a snapshot transaction is closed at the end of the current
                    call by setting the value to brssRequestClose. Warning: this
                    does not verify that a snapshot transaction has actually been
                    started and simply calls TransactionRollback, only set this
                    if the current value was brssStarted.
                    if the value of aSnapshot is still brssStarted after the last
                    call to BlobReadSnapshoted, it is the clients responsibility
                    to Rollback that snapshot transaction.
        aBlobLen - optional pointer that will recieve the total length of the blob
    }
    function BlobReadSnapshoted(const aRecID     : TnxRecID;
                                      aFieldNo   : TnxInt32;
                                const aBlobNr    : TnxBlobNr;
                                      aOffset    : TnxWord32;
                                      aLen       : TnxWord32;
                                      aStream    : TStream;
                                      aReadOrg   : Boolean;
                                  var aSnapshot  : TnxBlobReadSnapshotState;
                                      aBlobLen   : PnxWord32;
                                      aNewBlobNr : PnxNewBlobNr)
                                                 : TnxResult; virtual;
    function sbcBlobReadSnapshoted(const aRecID     : TnxRecID;
                                         aFieldNo   : TnxInt32;
                                   const aBlobNr    : TnxBlobNr;
                                         aOffset    : TnxWord32;
                                         aLen       : TnxWord32;
                                         aStream    : TStream;
                                         aReadOrg   : Boolean;
                                         aBlobLen   : PnxWord32;
                                         aNewBlobNr : PnxNewBlobNr)
                                                    : TnxResult; virtual;

    { This function writes data to a blob.
      Parameters:
        aBlobNr - the blob reference number
        aOffset - a offset in bytes where to start to write
        aLen - the number of bytes to write
        aBlob - the data to write
    }
    function BlobWrite(const aRecID   : TnxRecID;
                             aFieldNo : TnxInt32;
                       const aBlobNr  : TnxBlobNr;
                             aOffset  : TnxWord32;
                             aLen     : TnxWord32;
                       const aBlob    )
                                      : TnxResult; virtual; abstract;

    function BlobReplace(const aRecID   : TnxRecID;
                               aFieldNo : TnxInt32;
                         var   aBlobNr  : TnxBlobNr;
                               aLen     : TnxWord32;
                         const aBlob    )
                                        : TnxResult; virtual;

    { This function truncates the given blob at aBlobLength bytes. }
    function BlobTruncate(const aRecID      : TnxRecID;
                                aFieldNo    : TnxInt32;
                          const aBlobNr     : TnxBlobNr;
                                aBlobLength : TnxWord32)
                                            : TnxResult; virtual; abstract;
    { This function returns the length of the blob in aLengt as bytes. }
    function BlobGetLength(const aRecID     : TnxRecID;
                                 aFieldNo   : TnxInt32;
                           const aBlobNr    : TnxBlobNr;
                             out aLength    : TnxWord32;
                                 aReadOrg   : Boolean;
                                 aNewBlobNr : PnxNewBlobNr)
                                            : TnxResult; virtual;
    function sbcBlobGetLength(const aRecID     : TnxRecID;
                                    aFieldNo   : TnxInt32;
                              const aBlobNr    : TnxBlobNr;
                                out aLength    : TnxWord32;
                                    aReadOrg   : Boolean;
                                    aNewBlobNr : PnxNewBlobNr)
                                               : TnxResult; virtual; abstract;

    { Checks if the given Blob Buffer was modified
      Parameters:
        aFieldNo - of the field in FieldsDescriptor
        aBlobNr - the blob reference number
        aModified - will be set to true if the blob has changed
    }
    function BlobModified(const aRecID    : TnxRecID;
                                aFieldNo  : TnxInt32;
                          const aBlobNr   : TnxBlobNr;
                            out aModified : Boolean)
                                          : TnxResult; virtual; abstract;

    function BlobAddToCache(const aRecID   : TnxRecID;
                                  aFieldNo : TnxInt32;
                            const aBlobNr  : TnxBlobNr;
                                  aLen     : TnxWord32;
                            const aBlob    )
                                           : TnxResult; virtual;

    function BlobsSetMarked(const aMarkedBlobs : TnxMarkedBlobsByBlobIdx)
                                               : TnxResult; virtual;

    {-- table streams --}

    { This function returns the names of all streams stored with the table. }
    function TableStreamGetList(aStreams : TStrings)
                                         : TnxResult; virtual; abstract;

    { This function rewrites the WHOLE stream with the given name. }
    function TableStreamWrite(const aName   : string;
                                    aStream : TStream)
                                            : TnxResult; virtual; abstract;
    { This function reads the WHOLE stream with the given name into aStream. }
    function TableStreamRead(const aName   : string;
                                   aStream : TStream)
                                           : TnxResult; virtual; abstract;
    { This function deletes the table stream with the given aName. }
    function TableStreamDelete(const aName : string)
                                           : TnxResult; virtual; abstract;

    {-- table locks --}

    { TableIsLocked returns the current table lock state for a
      certain lock type.

      Parameters
      aLockType :     the type of lock you want to check.
      aLockPresent :  the state of the given lock type         }
    function TableIsLocked(aLockType    : TnxLockType;
                       out aLockPresent : TnxLockPresent)
                                        : TnxResult; virtual; abstract;
    { This function will try to acquire a table lock with the given aLockType. }
    function TableLockAcquire(aLockType : TnxLockType)
                                        : TnxResult; virtual; abstract;
    { This function will release an acquired lock with the given aLockType
      or alternatively (if aAllLocks is true) all locks on the table. }
    function TableLockRelease(aLockType : TnxLockType;
                              aAllLocks : Boolean)
                                        : TnxResult; virtual; abstract;

    {-- misc --}

    { This function clones the current cursor and returns a new instance
      in aNewCursor. The new cursor can be opened with a different mode by
      specifying the aOpenMode accordingly. }   
    function Duplicate(aOpenMode  : TnxOpenMode;
                   out aNewCursor : TnxAbstractCursor)
                                  : TnxResult; virtual; abstract;

    { This function changes the password of the table. It fails if the table
      doesn't us an encryption engine. }
    function ChangePassword(const aNewPassword : UnicodeString)
                                               : TnxResult; virtual; abstract;

    {-- information --}

    { GetRecordCount returns the number of currently "visible" records. It
      obeys set ranges and filters. }
    function GetRecordCount(out aRecCount : TnxWord32;
                                aEstimate : Boolean = False)
                                          : TnxResult; virtual; abstract;
    { This function is an asynchronous version of GetRecordCount. }
    function GetRecordCountAsync(out aTaskInfo : TnxAbstractTaskInfo)
                                               : TnxResult; virtual; abstract;

    { GetRecordCountEx returns the number of records or keys based on the value
      of aOption. }
    function GetRecordCountEx(aOption   : TnxRecordCountOption;
                          out aRecCount : TnxWord32;
                              aEstimate : Boolean = False)
                                        : TnxResult; virtual; abstract;
    { This function is an asynchronous version of GetRecordCountEx. }
    function GetRecordCountExAsync(aOption   : TnxRecordCountOption;
                               out aTaskInfo : TnxAbstractTaskInfo)
                                             : TnxResult; virtual; abstract;

    {=== TnxNextLSNDefaultValueEngine support ===}
    function GetNextLSN(var aLSN: TnxLSN): Boolean; virtual;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;
    {=== record buffer caching ===}
    { Extracts the cache reference number and LSN from a record buffer and sets
      them in the given TnxRecordCacheInfo instance. If the record buffer is
      empty or contains invalid cache info, aCacheInfo will be cleared.

      Parameters:
        aData - Pointer to the record buffer from which to extract the cache info.
        aCacheInfo - Output parameter that will hold the extracted cache info.

      Returns:
        DBIERR_NONE if the cache info was extracted successfully, or an error code
        if the record buffer is empty or contains invalid cache info. }
    function ExtractCacheInfo(aData      : PnxRecordBuffer;
                          out aCacheInfo : TnxRecordCacheInfo)
                                         : TnxResult;

    { Generates a list of BlobNrs for the provided record buffer. In the case of
      a cache cursor, the list only includes cached blobs. On entry, aBlobCount
      gives the available size of aBlobNrs, and on exit, it gives the number of
      filled items.

      Parameters:
        aData - Pointer to the record buffer for which to generate the list of BlobNrs.
        aMarkedOnly - limits returned blobs to marked blobs
        aBlobCount - Input/output parameter. On entry, it holds the available size
                     of aBlobNrs. On exit, it holds the number of filled items.
        aBlobNrs - Pointer to an array that will store the BlobNrs.

      Returns:
        DBIERR_NONE if the list of BlobNrs was generated successfully, or an error
        code if the record buffer is empty or contains invalid blob info. }
    function GetBlobs(aData       : PnxRecordBuffer;
                      aMarkedOnly : Boolean;
                  var aBlobCount  : TnxWord16;
                      aBlobNrs    : PnxBlobNr)
                                  : TnxResult; overload; virtual;

    function GetBlobs(aData       : PnxRecordBuffer;
                      aMarkedOnly : Boolean;
                  var aBlobNrs    : TnxBlobNrs)
                                  : TnxResult; overload;

    { Determines whether the table contains a record with the given LSN or
      reference number. If aLSN is non-zero, the function will look up the record
      by LSN. If aRefNr is non-zero, the function will look up the record by
      reference number. If both aLSN and aRefNr are non-zero, the function will
      look up the record by LSN and validate that the reference number matches,
      otherwise whichever was zero value will be filled in if the record was found.

      Parameters:
        aLSN - The LSN of the record to look up. Will be set if record was found
               but zero was passed.
        aRefNr - The reference number of the record to look up. Will be set if
                 record was found but zero was passed.

      Returns:
        DBIERR_NONE if the record exists and aLSN and aRefNr match (if both are
        non-zero), DBIERR_KEYORRECDELETED if the record exists but aLSN or aRefNr
        don't match, DBIERR_RECNOTFOUND if the record doesn't exist, or an error
        code if the function encounters an error. }
    function ContainsLSNRefNr(var aLSN   : TnxLSN;
                              var aRefNr : TnxRefNr)
                                         : TnxResult; virtual;

    { Determines whether the table contains a record with the same LSN and
      reference number as the given TnxRecordCacheInfo instance.

      Parameters:
        aCacheInfo - The cache info to look up.

      Returns:
        DBIERR_NONE if the record exists and has the same LSN and reference number
        as the given TnxRecordCacheInfo, DBIERR_NOCURRREC if aCacheInfo is empty,
        or an error code if the function encounters an error. }
    function ContainsCacheInfo(const aCacheInfo : TnxRecordCacheInfo)
                                                : TnxResult;

    { Retrieves a list of records that were deleted from the table after the
      specified LSN. The records are returned as TnxRecordCacheInfo instances.

      Parameters:
        aFromLSN - The LSN after which to retrieve deleted records.
        aCacheInfos - Output parameter that will hold the list of deleted records.
        aMaxCount - The maximum number of records to retrieve (defaults to
                    High(Integer)).
        aCurrentLSN - If non-nil, the current LSN of the table will be set in the
                      pointed-to variable.

      Returns:
        DBIERR_NONE if the deleted records were retrieved successfully, or an
        error code if the function encounters an error. }
    function GetDeletedRecords(aFromLSN    : TnxLSN;
                           out aCacheInfos : TnxRecordCacheInfos;
                               aMaxCount   : Integer = High(Integer);
                               aCurrentLSN : PnxLSN = nil)
                                           : TnxResult; virtual;


    {=== batch stream helper ===}
    function CreateBatchStreamAccess(aStream  : TnxMemoryStream;
                                     aOptions : TnxRecordGetBatchExOptions)
                                              : TnxBatchStreamAccess;

    function ClientOnlyCacheBegin: TnxResult; virtual;
    function ClientOnlyCacheEnd: TnxResult; virtual;

    { This property returns the data dictionary for this cursor. }
    property _Dictionary: TnxDataDictionary
      read ac_GetDictionary;

    { Returns the TableDescriptor instance in the data dictionary associated
      with the cursor. }
    property TableDescriptor: TnxBaseTableDescriptor
      read acGetTableDescriptor;

    { Returns the full table name in relation to master and sub tables. }
    property FullName: string
      read acGetFullName;

    { Server side only - Returns the alias name of the containing database. }
    property AliasName: string
      read acGetAliasName;

    { This property returns the database the cursor is linked to. }
    property Database: TnxAbstractDatabase
      read acDatabase;

    { Returns the previous cursor in the list of cursor of the current database. }
    property DatabasePrev : TnxAbstractCursor
      read acDatabasePrev;

    { Returns the next cursor in the list of cursor of the current database. }
    property DatabaseNext : TnxAbstractCursor
      read acDatabaseNext;

    { This property returns the transaction context the cursor is linked to. }
    property TransContext: TnxAbstractTransContext
      read acTransContext;

    { Returns the previous cursor in the list of cursor of the current transaction context. }
    property TransContextPrev : TnxAbstractCursor
      read acTransContextPrev;

    { Returns the next cursor in the list of cursor of the current transaction context. }
    property TransContextNext : TnxAbstractCursor
      read acTransContextNext;

    property CursorOptions : TnxAbstractCursorOptions
      read acOptions
      write acOptions;

    property Capabilities : TnxAbstractCursorCapabilities
      read acCapabilities;

    property IsCache: Boolean
      read acGetIsCache;

    property OnCancelServerFilter : TnxCancelServerFilterEvent
      read acOnCancelServerFilter
      write acOnCancelServerFilter;
  end;
  TnxAbstractCursors = array of TnxAbstractCursor;

  TnxAbstractRemoteCursor = class(TnxAbstractCursor)
  public
    function rcCacheBlob(const aRecID     : TnxRecID;
                               aFieldNo   : TnxInt32;
                         const aBlobNr    : TnxBlobNr;
                               aNewBlobNr : PnxNewBlobNr)
                                          : TnxResult; virtual; abstract;
  end;

  TnxAbstractServerBaseTable = class(TnxLockedOptionsExtendableServerObject)
  public
    asbtClientOnlyCacheCount: Integer;
  end;

  TnxAbstractServerCursor = class(TnxAbstractCursor)
  protected
    function ascGetAbstractBaseTable: TnxAbstractServerBaseTable; virtual; abstract;
  public
    ascRemoteCursor: TnxAbstractRemoteCursor;

    function ascBlobRequestCache(const aRecID     : TnxRecID;
                                       aFieldNo   : TnxInt32;
                                 const aBlobNr    : TnxBlobNr)
                                                  : TnxResult;

    function ascGetBlobCacheInfos(const aRecID : TnxRecID;
                                    out aBCIs  : TnxBlobCacheInfos)
                                               : TnxResult; virtual; abstract;
    function ascSetBlobCacheFlushed(const aRecID     : TnxRecID;
                                          aFieldNo   : TnxInt32;
                                    const aBlobNr    : TnxBlobNr;
                                          aNewBlobNr : PnxBlobNr = nil)
                                                     : TnxResult; virtual; abstract;

    property AbstractBaseTable: TnxAbstractServerBaseTable
      read ascGetAbstractBaseTable;
  end;

  TnxBatchStreamHeader = packed record
    bshInnerError : TnxResult;
    bshCount      : Integer;
    bshStart      : TnxNullType;
  end;
  PnxBatchStreamHeader = ^TnxBatchStreamHeader;

  TnxBatchBlobOffset = packed record
    bboOffset  : TnxWord32;
    bboFieldNo : TnxWord16;
  end;
  PnxBatchBlobOffset = ^TnxBatchBlobOffset;

  TnxBatchBlobOffsets = array[TnxWord16] of TnxBatchBlobOffset;
  PnxBatchBlobOffsets = ^TnxBatchBlobOffsets;

  TnxBatchStreamEntry = record
    bseBatchAccess : TnxBatchStreamAccess;
    bseStreamBase  : PnxByteArray;
    bseEntryBase   : PnxByteArray;
    bseRecord      : PnxRecordBuffer;
    bseBookmark    : PnxBookmarkBuffer;
    bseCacheInfo   : PnxIndexedRecordCacheInfo;
    bseBlobOffsets : PnxBatchBlobOffsets;
    bseSize        : TnxWord32;
    bseResult      : TnxResult;
  end;
  PnxBatchStreamEntry = ^TnxBatchStreamEntry;
  TnxBatchStreamEntries = array of TnxBatchStreamEntry;

  TnxBatchBlobAccess = record
    bbaBase      : PnxByteArray;
    bbaBlobData  : PnxByteArray;
    bbaBlobNr    : TnxBlobNr;
    bbaOffset    : TnxWord32;
    bbaSize      : TnxWord32;
    bbaResult    : TnxResult;
    bbaFieldNo   : TnxWord16;
    bbaInCache   : Boolean;
  end;

  TnxBatchBlobAccesses = array of TnxBatchBlobAccess;

  TnxBatchStreamAccess = class(TnxObject)
  protected {private}
    bsaStream             : TnxMemoryStream;

    bsaHeader             : PnxBatchStreamHeader;

    bsaStart              : PnxByteArray;
    bsaEnd                : TnxNativeUInt;

    bsaCurrentEntry       : PnxByteArray;
    bsaCurrentIndex       : Integer;

    bsaCheckFilter        : Boolean;

    bsaCurrentStreamEntry : PnxBatchStreamEntry;

    function  bsaParseEntry(aBasePtr : PnxByteArray;
                        var aEntry   : TnxBatchStreamEntry)
                                     : PnxByteArray;

    function GetCount: Integer;
    function GetInnerError: TnxResult;

    function GetMemory: Pointer;
    function GetSize: TnxMemSize;
    procedure SetInnerError(const Value: TnxResult);

    function bsaIsSameBlobs(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                      const aBlobAccesses : TnxBatchBlobAccesses)
                                          : Boolean;
    procedure bsaProcessBlobsForCacheInfo(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                                    const aBlobAccesses : TnxBatchBlobAccesses;
                                      var aEntry        : TnxBatchStreamEntry);
    procedure bsaProcessBlobsForRecord(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                                 const aBlobAccesses : TnxBatchBlobAccesses;
                                   var aEntry        : TnxBatchStreamEntry);

    procedure bsaAfterClear; virtual;

    constructor Create(aCursor  : TnxAbstractCursor;
                       aStream  : TnxMemoryStream;
                       aOptions : TnxRecordGetBatchExOptions); virtual;
  public
    bsaCursor       : TnxAbstractCursor;
    bsaMarkedBlobs  : TnxMarkedBlobsByBlobIdx;

    bsaRecordLength : TnxWord32;
    bsaBookmarkSize : TnxWord32;

    bsaInvalidCount : PnxInt32;
    bsaInvalidInfos : PnxRecordCacheInfo;

    bsaOptions      : TnxRecordGetBatchExOptions;

    destructor Destroy; override;

    class function Current: TnxBatchStreamAccess; {$IFDEF SUPPORTS_STATIC}static;{$ENDIF} {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    procedure Clear(aKeepError: Boolean = False);

    function Reset(aApplyClientFilter: Boolean = False): Boolean;
    function Next(var aEntry: TnxBatchStreamEntry; aPos: PInteger = nil; aTotalPos: PInteger = nil): Boolean; overload;
    function Next(aEntry: PnxBatchStreamEntry; aPos: PInteger = nil; aTotalPos: PInteger = nil): Boolean; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    function CheckCacheValidSeq(const aCacheInfos : TnxRecordCacheInfos;
                                      aBlobInfos  : PnxRecordCacheInfoBlobInfo)
                                                  : Boolean;

    function CheckCacheValid(aCacheInfosCount : Integer;
                             aCacheInfos      : PnxRecordCacheInfo;
                             aBlobInfos       : PnxRecordCacheInfoBlobInfo)
                                              : Boolean;

    function OverwriteEntry(var aTarget         : TnxBatchStreamEntry;
                          const aSource         : TnxBatchStreamEntry;
                            out aBlobs          : TnxBatchBlobAccesses;
                                aRemoveBlobData : Boolean)
                                                : Boolean;

    procedure CheckEntryForCachedBlobs(var aEntry          : TnxBatchStreamEntry;
                                           aCache          : TnxAbstractCursor;
                                       out aBlobs          : TnxBatchBlobAccesses);

    function GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                                 aFieldNo    : Integer;
                             out aBlobAccess : TnxBatchBlobAccess)
                                             : Boolean; overload;

    function GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                                 aBlobOffset : PnxBatchBlobOffset;
                             out aBlobAccess : TnxBatchBlobAccess)
                                             : Boolean; overload;

    function GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                             var aBlobAccess : TnxBatchBlobAccess) //bbaBase must be set already
                                             : Boolean; overload;

    function GetBlobAccesses(const aEntry        : TnxBatchStreamEntry;
                               var aBlobAccesses : TnxBatchBlobAccesses;
                                   aEmbeddedOnly : Boolean = False)
                                                 : Boolean;

    procedure FixupBlobs(aOrgOptions: TnxRecordGetBatchExOptions);

    property Stream: TnxMemoryStream read bsaStream;
    property Memory: Pointer read GetMemory;
    property Size: TnxMemSize read GetSize;

    property Count: Integer read GetCount;
    property InnerError: TnxResult read GetInnerError write SetInnerError;

    property CurrentStreamEntry : PnxBatchStreamEntry read bsaCurrentStreamEntry;
    property Cursor: TnxAbstractCursor read bsaCursor;
  end;
  PnxBatchStreamAccess = ^TnxBatchStreamAccess;

  TnxBatchStreamAccessClass = class of TnxBatchStreamAccess;

(*$HPPEMIT 'namespace Nxsdserverengine'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'class DELPHICLASS TnxAbstractCursor;'*)
(*$HPPEMIT '}'*)

  { The abstract declaration of a server statement. All actual
    statement implementations MUST be descendent from this class.
    This is the server side version of TnxQuery.                  }
  TnxAbstractStatement = class(TnxAbstractTimeoutObject)
  protected {private}
    asDatabase       : TnxAbstractDatabase;

    asDatabasePrev   : TnxAbstractStatement;
    asDatabaseNext   : TnxAbstractStatement;

    asLockedIncDone  : Boolean;
    asExecDirect     : Boolean;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    procedure asAddToDatabase;
    procedure asRemoveFromDatabase;
  public
    { constructor
      Paremeters:
        aDatabase - the database instance the statement is linked to
        aTimeout - the timeout of the statement in msec }
    constructor Create(aDatabase : TnxAbstractDatabase;
                       aTimeout  : TnxWord32);
    { destructor. }
    destructor Destroy; override;

    { see TObject.AfterConstruction }
    procedure AfterConstruction; override;
    { see TObject.BeforeConstruction }
    procedure BeforeDestruction; override;

    { This method prepares the sql query. It does NOT execute the query.
      Parameters:
        aQueryText - the SQL query to be executed
        aStream - a stream instance that will be filled with result/reply
    }
    function Prepare(aStatementType : TnxStatementType;
               const aQueryText     : WideString;
                     aStream        : TStream)
                                    : TnxResult; virtual; abstract;

    { This method execute the query and returns a cursor for it.

      Parameters
      aCursor :    the resulting cursor
      aOpenMode :  the mode you want the cursor to be opened
      aStream :    a stream instance that will be filled with
                   \result/reply                                 }
    function Exec(out aCursor   : TnxAbstractCursor;
                      aOpenMode : TnxOpenMode;
                      aStream   : TStream)
                                : TnxResult; virtual; abstract;

    { With SetParams the parameters of the query will be set.
      Parameters:
        aParams - the list of parameters
        aStream - a stream instance that will be filled with result/reply.
    }
    function SetParams(const aParams : TnxSqlParamList;
                             aStream : TStream)
                                     : TnxResult; virtual; abstract;

    { Returns the given Parameters as stream. }
    function GetParams(const aParams : TnxSqlParamList;
                             aStream : TStream)
                                     : TnxResult; virtual; abstract;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    { This property returns the database the statement is linked to. }
    property Database: TnxAbstractDatabase
      read asDatabase;
  end;

  { This is the base for all Server Engine implementations in
    NexusDB. All actual server engines are descendent from this
    class. Please note that a server engine does not do a lot of
    stuff on its own. It's a mainly a center point that holds
    together all engines and their instances of server objects.  }
  TnxBaseServerEngine = class(TnxStateComponent)
  protected {private}
    bseSessionsPadlock   : TnxPadlock;
    bseSessionsHead      : TnxAbstractSession;
    bseSessionsTail      : TnxAbstractSession;

    bseMonitors          : TnxListPortal;

    bseSessionCount      : Integer;
    bseDatabaseCount     : Integer;
    bseTransContextCount : Integer;
    bseCursorCount       : Integer;
    bseStatementCount    : Integer;
  protected
    procedure nxcAddDependent(aComponent : TnxComponent); override;
    procedure nxcRemoveDependent(aComponent : TnxComponent); override;

    procedure scInitializing; override;
    procedure scStopping; override;

    function scShowUpTime: Boolean; override;

    function bseConvertException(aException : Exception;
                                 aSource    : TnxAbstractServerObject)
                                            : TnxResult; virtual;
    function bseGetExceptionClass: EnxExceptionClass; virtual; abstract;
    procedure bseInformMonitorsCreated(aExtendableObject : TnxExtendableServerObject); virtual;
    procedure bseInformMonitorsDestroyed(aExtendableObject : TnxExtendableServerObject); virtual;

    function bseGetServerGuid: TnxGuid; virtual; abstract;
    function bseGetServerName: string; virtual; abstract;

    function bseCreateInstanceFor(aSession     : TnxAbstractSession;
                            const aName        : string;
                            const aClassID     : TnxGuid;
                            const aOuter       : InxInterface;
                            const aInterfaceID : TnxGuid;
                              out aInterface   )
                                               : HRESULT; virtual;

    procedure bseInactive; virtual;
    function bseGetKeepSessionStats: Boolean; virtual;

    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  public
    { constructor. }
    constructor Create(aOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    function IsSecureServer: Boolean; virtual;

    { This function opens creates a new session.
      Parameters:
        aSession - the returned instance of a TnxAbstractSession descendant
        aUserName - the user name used to authenticate the session if
          security is enabled. A security monitor needs to be attached for
          this to work.
        aPassword - the password used to authenticate the session if
          security is enabled
        aTimeout: the timeout for the newly created session in msec
    }
    function SessionOpen(out aSession       : TnxAbstractSession;
                       const aUserName      : UnicodeString;
                       const aPassword      : UnicodeString;
                       const aConnectedFrom : string;
                             aTimeout       : TnxWord32)
                                            : TnxResult; virtual;

    { This function opens creates a new session. It additionally passes the
      Client Version. This function can be used to support older clients on
      a newer version on the server.
      Parameters:
        aSession - the returned instance of a TnxAbstractSession descendant
        aUserName - the user name used to authenticate the session if
          security is enabled. A security monitor needs to be attached for
          this to work.
        aPassword - the password used to authenticate the session if
          security is enabled
        aTimeout: the timeout for the newly created session in msec
        aClientVersion: the version of the NexusDB core on the client side
    }
    function SessionOpenEx(out aSession       : TnxAbstractSession;
                         const aUserName      : UnicodeString;
                         const aPassword      : UnicodeString;
                         const aConnectedFrom : string;
                               aTimeout       : TnxWord32;
                               aClientVersion : Integer)
                                              : TnxResult; virtual; abstract;

    { This function returns the captions for the statistics page on the server
      gui. }
    procedure GetStatsCaptions(const aList: TStrings); override;
    { This function returns the values for the statistics page on the server
      gui. }
    procedure GetStatsValues(const aList: TStrings); override;
    { This function resets all statistical values. }
    procedure ClearStats; override;

    { SessionCount returns the number of open session in this server engine }
    property SessionCount: Integer
      read bseSessionCount;

    { DatabaseCount returns the number of open databases in this
      server engine.                                             }
    property DatabaseCount: Integer
      read bseDatabaseCount;

    { TransContextCount returns the number of transaction contexts in this
      server engine.                                             }
    property TransContextCount: Integer
      read bseTransContextCount;

    { CursorCount returns the number of open cursors in this server engine }
    property CursorCount: Integer
      read bseCursorCount;

    { StatementCount returns the number of open (SQL) statements in
      this server engine.                                           }
    property StatementCount: Integer
      read bseStatementCount;

     { Returns a unique ID for this server. }
    property ServerGuid: TnxGuid
      read bseGetServerGuid;

    property ServerName: string
      read bseGetServerName;
  end;

  { This is the base for all Extenders used in NexusDB. An
    extender gets notified about actions in the database core and
    can change or extend the default behavior. It is generally
    always created from a TnxBaseEngineMonitor.                   }
  TnxBaseEngineExtender = class(TnxLifetimeTrackedPersistent)
  protected {private}
    beeMonitor              : TnxBaseEngineMonitor;
    beeMonitorNext          : TnxBaseEngineExtender;
    beeMonitorPrev          : TnxBaseEngineExtender;

    beeExtendableObject     : TnxExtendableServerObject;
    beeExtendableObjectNext : TnxBaseEngineExtender;
    beeExtendableObjectPrev : TnxBaseEngineExtender;

    beeActions              : TnxEngineActions;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    procedure beeAddToMonitor;
    procedure beeRemoveFromMonitor;

    procedure beeAddToExtendableObject;
    procedure beeRemoveFromExtendableObject;

    function beeCreateInstance(const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; virtual;
  public
    { constructor
      Parameters:
        aMonitor - the Monitor that creates the Extender
        aExtendableObject - the object the Extender extends.
    }
    constructor Create(aMonitor          : TnxBaseEngineMonitor;
                       aExtendableObject : TnxExtendableServerObject);
    { destructor. }
    destructor Destroy; override;

    { This function is called for all actions executed in the extended
      server object ExtendableObject.
      Parameters:
        aAction: the type of action executed
        aBefore: if this is true then the server engine is just about to
          execute the given action, otherwise it was just executed.
          aArgs: the parameters used for the given action type.
    }
    function Notify(aAction : TnxEngineAction;
                    aBefore : Boolean;
              const aArgs   : array of const)
                            : TnxResult; virtual; abstract;

    { called just before the destructor is called to allow for removal of
      dependencies between components. }
    procedure PrepareDestroy; virtual;

    { This property returns the Monitor the extender was created from. }
    property Monitor: TnxBaseEngineMonitor
      read beeMonitor;

    { This property returns the server object the extender extends. }
    property ExtendableObject: TnxExtendableServerObject
      read beeExtendableObject;
  end;

  { This is the base engine monitor. An engine monitor is responsible for
    creating and freeing engine extenders. A monitor is notified about every
    creation and destruction of a server object. }
  TnxBaseEngineMonitor = class(TnxStateComponent)
  protected {private}
    bemServerEngine : TnxBaseServerEngine;

    bemExtendersLock : TnxPadlock;
    bemExtendersHead : TnxBaseEngineExtender;
    bemExtendersTail : TnxBaseEngineExtender;
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    procedure scDependentStateChange(aSender   : TnxStateComponent;
                                     aBefore   : Boolean;
                                     aOldState : TnxState;
                                     aNewState : TnxState); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure scStopping; override;

    procedure bemSetServerEngine(aEngine : TnxBaseServerEngine); virtual;

    procedure ServerEngineStarting; virtual;
    procedure ServerEngineStopped; virtual;
  public
    { constructor. }
    constructor Create(aOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { This method is called every time a server object is created
      within the linked Server engine. Override this function to
      create an Extender or manipulate the initial settings of a
      server object.

      Parameters
      aExtendableObject :  This is the pointer to the object that was
                           just created.                              }
    procedure ExtendableObjectCreated(aExtendableObject : TnxExtendableServerObject); virtual;
    { This method is called every time a server object is destroyed
      within the linked Server engine. 

      Parameters
      aExtendableObject :  This is the pointer to the object that was
                           just created.                              }
    procedure ExtendableObjectDestroyed(aExtendableObject : TnxExtendableServerObject); virtual;
  published
    { This property links the Monitor to a server engine. }
    property ServerEngine: TnxBaseServerEngine
      read bemServerEngine
      write bemSetServerEngine;
  end;

  InxLoggedInUser31000 = interface(InxInvokable)
    ['{6BF2AC76-CB7F-4051-B770-73AF46CA627F}']

    function GetUserName       : UnicodeString;
    function GetIsUser         : Boolean;
    function GetIsAdmin        : Boolean;
    function GetHasReadAccess  : Boolean;
    function GetHasWriteAccess : Boolean;

    procedure ChangePassword(aPassword: UnicodeString);

    property UserName: UnicodeString
      read GetUserName;
    property IsUser: Boolean
      read GetIsUser;
    property IsAdmin: Boolean
      read GetIsAdmin;
    property HasReadAccess: Boolean
      read GetHasReadAccess;
    property HasWriteAccess: Boolean
      read GetHasWriteAccess;
  end;

  InxLoggedInUser46000 = interface(InxLoggedInUser31000)
    ['{27CDD9D4-3661-403A-96B3-5703333412E5}']
    function AliasesWithAccessRights: TnxUnicodeStrings;
    function AliasesWithTableAccessRights: TnxUnicodeStrings;
    function TablesWithAccessRights(const aAlias: UnicodeString): TnxUnicodeStrings;

    function GetHasReadAccess2(const aAlias, aTable: UnicodeString): Boolean;
    function GetHasWriteAccess2(const aAlias, aTable: UnicodeString): Boolean;
    function GetHasAdminAccess2(const aAlias, aTable: UnicodeString): Boolean;
  end;

  InxLoggedInUser = InxLoggedInUser46000;

  InxBaseEnumerator = interface(InxInterface)
    ['{DE128325-BC3B-44F4-B789-087B6F33C17B}']
    procedure Reset;
    function MoveNext: Boolean;
  end;

  InxUserEnumerator = interface(InxBaseEnumerator)
    ['{ABD4007B-1013-4383-A34D-F82EFFBE6EDA}']
    function GetUserID: Variant{string -> GUID};
    function GetUserName: Variant{UnicodeString};
    function GetDisabled: Variant{Boolean};
    function GetReadAccess: Variant{Boolean};
    function GetWriteAccess: Variant{Boolean};
    function GetIsAdmin: Variant{Boolean};
  end;

  InxUserTablePasswordsEnumerator = interface(InxBaseEnumerator)
    ['{C51A6F79-8ACA-4D4B-BCB4-1F55321ADD2F}']
    function GetUserID: Variant{string -> GUID};
    function GetAliasName: Variant{UnicodeString};
    function GetTableName: Variant{UnicodeString};
  end;

  InxUserAccessEnumerator = interface(InxBaseEnumerator)
    ['{FAD37A96-1AC0-4C08-8DD1-0824CE1DE977}']
    function GetUserID: Variant{string -> GUID};
    function GetAliasName: Variant{UnicodeString};
    function GetTableName: Variant{UnicodeString};
    function GetReadAccess: Variant{Boolean};
    function GetWriteAccess: Variant{Boolean};
    function GetAdminAccess: Variant{Boolean};
  end;

  InxLoggedInUserInProcessOnly = interface(InxLoggedInUser)
    ['{E721F80A-1B64-4AE6-9EEB-B194C66C29A9}']
    function GetUserEnumerator: InxUserEnumerator;
    function GetUserTablePasswordsEnumerator: InxUserTablePasswordsEnumerator;
    function GetUserAccessEnumerator: InxUserAccessEnumerator;
  end;

  InxModifyUser31000 = interface(InxInvokable)
    ['{36B7586D-FE19-4F89-B658-8DC3B616DEFA}']
    procedure AddTablePassword(const aAlias, aTable, aPassword: UnicodeString);
    procedure RemoveTablePassword(const aAlias, aTable, aPassword: UnicodeString);
    procedure RemoveAllTablePasswords;

    function GetIsAdmin: Boolean;
    //procedure SetIsAdmin(aValue: Boolean);

    function GetHasReadAccess: Boolean;
    procedure SetHasReadAccess(aValue: Boolean);

    function GetHasWriteAccess: Boolean;
    procedure SetHasWriteAccess(aValue: Boolean);

    property IsAdmin: Boolean
      read GetIsAdmin{
      write SetIsAdmin};
    property HasReadAccess: Boolean
      read GetHasReadAccess
      write SetHasReadAccess;
    property HasWriteAccess: Boolean
      read GetHasWriteAccess
      write SetHasWriteAccess;
  end;

  InxModifyUser46000 = interface(InxModifyUser31000)
    ['{95756A05-E8F6-4E36-8DC8-DA35698617AB}']
    procedure SetTableAccess(const aAlias, aTable: UnicodeString; aReadAccess, aWriteAccess, aAdminAccess: Boolean);
    procedure RemoveTableAccess(const aAlias, aTable: UnicodeString);
    procedure RemoveAllTableAccess;
  end;

  InxLoggedInAdministrator31000 = interface(InxInvokable)
    ['{D8E30E37-4A36-4979-A7A7-9B3DFB1849C4}']
    function UserList: TnxUnicodeStrings;
    function AdminList: TnxUnicodeStrings;

    function UserExists(const aUserName : UnicodeString)
                                        : Boolean;

    procedure AddUser(const aUserName    : UnicodeString;
                      const aPassword    : UnicodeString;
                            aAsAdmin     : Boolean;
                            aReadAccess  : Boolean;
                            aWriteAccess : Boolean);
    procedure RemoveUser(const aUserName : UnicodeString);
    function ModifyUser(const aUserName : UnicodeString)
                                        : InxModifyUser31000;

    procedure GrantAdminKey(const aUserName: UnicodeString);
    procedure RevokeAdminKey(const aUserName: UnicodeString);

    procedure SetUserDisabled(const aUserName : UnicodeString;
                                    aDisabled : Boolean);
    procedure SetUserPassword(const aUserName : UnicodeString;
                              const aPassword : UnicodeString);
  end;

  InxAbstractSecurityMonitorComponentInfo31000 = interface(InxInvokable)
    ['{1A809D8E-B96D-4680-925C-401D9734AB2D}']

    function LogIn(const aUserName : UnicodeString;
                   const aPassword : UnicodeString)
                                   : InxLoggedInUser31000;
  end;

  TnxAbstractSecurityMonitor = class;

  TnxAbstractSecurityMonitorComponentInfo = class(TnxStateComponentInfo, InxAbstractSecurityMonitorComponentInfo31000)
  protected
    {--- InxAbstractSecurityMonitorComponentInfo31000 ---}
    function LogIn(const aUserName : UnicodeString;
                   const aPassword : UnicodeString)
                                   : InxLoggedInUser31000;

    constructor Create(aAbstractSecurityMonitor: TnxAbstractSecurityMonitor);
  end;

  EnxAbstractSecurityMonitorException = class(EnxStateComponentException);

  { This is the base for all security monitors used in NexusDB. }
  TnxAbstractSecurityMonitor = class(TnxBaseEngineMonitor)
  protected
    aseMaxSessionCount: integer;
    aseAlwaysLoginAdmins: boolean;

    function nxcCreateComponentInfo: InxInterface; override;
    class function nxcExceptionClass: EnxComponentExceptionClass; override;
  public
    { This function returns true if there is an Admin user with the
      given aUserName and aPassword.                                }
    function IsAdmin(const aUserName, aPassword: UnicodeString): Boolean; virtual; abstract;
    { This function returns true if there is an User user with the
      given aUserName and aPassword.                                }
    function IsUser(const aUserName, aPassword: UnicodeString): Boolean; virtual; abstract;
    { HasUSers returns true if there are any users defined. }
    function HasUsers: Boolean; virtual; abstract;
    { HasAdmins returns true if there are any users defined. }
    function HasAdmins: Boolean; virtual; abstract;
    { Returns a InxLoggedInUser for the specified UserName and Password,
      check InxLoggedInUser.IsUser to verify that the username and password
      could be authenticated. }
    function LogIn(const aUserName : UnicodeString;
                   const aPassword : UnicodeString)
                                   : InxLoggedInUser31000; virtual; abstract;
    { returns always true, cause the User Interface for a Security Monitor
      should always be visible. }
    function UIStateVisible:Boolean; override;
  published
    // Sets the maximum number of users that can be logged in at any given time.
    property MaxSessionCount: integer
      read aseMaxSessionCount
      write aseMaxSessionCount;
    // If this is set to true admins can always log in, even though MaxSessionCount is reached.
    property AlwaysLoginAdmins: boolean
      read aseAlwaysLoginAdmins
      write aseAlwaysLoginAdmins;
  end;

  InxSecurityExtender31000 = interface(InxInvokable)
    ['{13666417-78F9-48A0-9B10-0694185F91AA}']

    function GetSecurityMonitor: InxAbstractSecurityMonitorComponentInfo31000;
    function GetLoggedInUser: InxLoggedInUser31000;

    property SecurityMonitor: InxAbstractSecurityMonitorComponentInfo31000
      read GetSecurityMonitor;
    property LoggedInUser: InxLoggedInUser31000
      read GetLoggedInUser;
  end;

const
  CLSID_SecurityExtender : TGUID = '{AB65C05B-90BA-44BC-8D73-09132DE3D55B}';

const
  CLSID_AbstractDatabase : TGUID = '{5C00AAC9-F6CE-4ECB-BE82-FBED01C2CCE6}';

type
  InxAbstractDatabase31000 = interface(InxInvokable)
    ['{41BDEED6-5BC3-4599-9212-15DEDBCD55C0}']

    function GetTablesNeedingPack: TnxUnicodeStrings;
  end;

  TnxSqlAbstractTaskInfo = class(TnxAbstractTaskInfo)
  public
    procedure Execute; virtual; abstract;
  end;

  TnxSqlAbstractCursor = class;

  TnxSqlAbstractDatabase = class(TnxAbstractDatabase)
  protected
    sadLastAutoInc      : TnxWord32;

    sdOpenMode         : TnxOpenMode;
    sdShareMode        : TnxShareMode;

    function sadGetAlias: UnicodeString; virtual;
  public
    {for testing only}
    sadMasterDatabase : TnxSqlAbstractDatabase;
    {-- table managmenet --}
    function sdTableRebuildIndex(const aTableName : string;
                                 const aPassword  : UnicodeString;
                                 const aIndexName : string;
                                       aIndexID   : Integer;
                                   out aTaskInfo  : TnxAbstractTaskInfo)
                                                  : TnxResult; virtual; abstract;

    function sdTableRestructure(const aTableName   : string;
                                const aPassword    : UnicodeString;
                                      aDictionary  : TnxDataDictionary;
                                      aMapperDesc  : TnxBaseTableMapperDescriptor;
                                  out aTaskInfo    : TnxAbstractTaskInfo)
                                                   : TnxResult; virtual; abstract;

    function sadCreateResultSet(aDictionary : TnxDataDictionary;
                                aTimeout    : TnxWord32)
                                            : TnxSqlAbstractCursor; virtual; abstract;

    function sdIterateDictionaries(aIterator    : TnxDictionaryIterator;
                                   aAllowSystem : Boolean;
                                   aIgnoreError : Boolean;
                                   aCookie      : Pointer)
                                                : TnxIteratorResult; virtual; abstract;

    procedure sadLockTables; virtual; abstract;
    procedure sadUnlockTables; virtual; abstract;

    property Alias: UnicodeString
      read sadGetAlias;

    property LastAutoInc: TnxWord32
      read sadLastAutoInc
      write sadLastAutoInc;

    property OpenMode: TnxOpenMode
      read sdOpenMode;

    property ShareMode: TnxShareMode
      read sdShareMode;
  end;

  InxRequestCloseHandler = interface(InxInterface)
    ['{B1155737-8151-4804-AB73-E5E3CA280B0D}']
    procedure RequestClose(Sender: TObject);
  end;

  InxRequestCloseHandlerEvent = interface(InxRequestCloseHandler)
    ['{AF7BF7A2-EAF3-49C7-B830-D91407F715C5}']
    procedure Disconnect;
  end;

  TnxSqlAbstractCursor = class(TnxAbstractServerCursor)
  protected
    sbcOnRequestCloseLock : TnxPadlock;
    sbcOnRequestClose     : InxRequestCloseHandler;
  public
    function sacIsWrapper: Boolean; virtual;
    procedure sbcMarkReadonly; virtual; abstract;
    function sbcGetRootName: string; virtual; abstract;
    function sbcGetPosition: TnxIndexPathPosition; virtual; abstract;
    procedure sbcSetOnRequestClose(aHandler : InxRequestCloseHandler); virtual;
    function sbcGetOnRequestClose: InxRequestCloseHandler;

    {-- index support --}
    function sbcSwitchToIndex(const aIndexName : string;
                                    aIndexID   : Integer;
                                    aPosnOnRec : TnxPosnOnRec)
                                               : TnxResult; virtual; abstract;

    function sbcGetIndexID(out aIndexID : Integer)
                                        : TnxResult; virtual; abstract;
    procedure sbcRangeReset; virtual; abstract;
    function sbcRangeSet(aFieldCount1 : Integer;
                         aPartialLen1 : Integer;
                         aDirectKey1  : Boolean;
                         aKeyData1    : PnxKeyOrRecordBuffer;
                         aKeyIncl1    : Boolean;
                         aFieldCount2 : Integer;
                         aPartialLen2 : Integer;
                         aDirectKey2  : Boolean;
                         aKeyData2    : PnxKeyOrRecordBuffer;
                         aKeyIncl2    : Boolean)
                                      : TnxResult; virtual; abstract;

    {-- navigation --}
    procedure sbcSetToBegin; virtual; abstract;
    procedure sbcSetToEnd; virtual; abstract;

    {-- batch operations --}
    function sbcRecordGetBatch(aCutoffSize : Integer;
                               aOptions    : TnxRecordGetBatchExOptions;
                           var aAccess     : TnxBatchStreamAccess;
                               aMaxRecords : Integer = -1;
                               aForward    : Boolean = True)
                                           : TnxResult; virtual; abstract;

    function sbcRecordInsertBatch(aStream : TnxCustomMemoryStream)
                                          : TnxResult; virtual; abstract;

    function sbcCopyRecords(aDestCursor     : TnxAbstractCursor;
                            aBlobCopyMode   : TnxBlobCopyMode;
                            aMaxTransSize   : Integer;
                            aCheckValFields : Boolean)
                                            : TnxResult; virtual; abstract;
    function sbcDeleteRecords : TnxResult; virtual; abstract;

    {-- blob managment --}
    function sbcBlobCreateLink(const aRecID       : TnxRecID;
                                     aFieldNo     : TnxInt32;
                               const aTableName   : string;
                               const aTableBlobNr : TnxBlobNr;
                                 out aBlobNr      : TnxBlobNr)
                                                  : TnxResult; virtual; abstract;
    function sbcBlobDelete(const aRecID   : TnxRecID;
                                 aFieldNo : TnxInt32;
                           const aBlobNr  : TnxBlobNr)
                                          : TnxResult; virtual; abstract;
    function sbcBlobTruncate(const aRecID      : TnxRecID;
                                   aFieldNo    : TnxInt32;
                             const aBlobNr     : TnxBlobNr;
                                   aBlobLength : TnxWord32)
                                               : TnxResult; virtual; abstract;
    function sbcBlobWrite(const aRecID      : TnxRecID;
                                aFieldNo : TnxInt32;
                          const aBlobNr  : TnxBlobNr;
                                aOffset  : TnxWord32;
                                aLen     : TnxWord32;
                          const aBlob    )
                                         : TnxResult; virtual; abstract;
    function sbcBlobReplace(const aRecID      : TnxRecID;
                                  aFieldNo : TnxInt32;
                              var aBlobNr  : TnxBlobNr;
                                  aLen     : TnxWord32;
                            const aBlob    )
                                           : TnxResult; virtual; abstract;
    function sbcBlobIsLink(const aRecID      : TnxRecID;
                                 aFieldNo        : TnxInt32;
                                 aBlobNr         : TnxBlobNr;
                             out aSrcTableName   : string;
                             out aSrcTableBlobNr : TnxBlobNr)
                                                 : Boolean; virtual; abstract;

    {-- record retrival --}
    function sbcRecordGet(aLockType : TnxLockType;
                          aData     : PnxRecordBuffer)
                                    : TnxResult; virtual; abstract;
    function sbcRecordGetNext(aLockType : TnxLockType;
                              aData     : PnxRecordBuffer)
                                        : TnxResult; virtual; abstract;
    function sbcRecordGetPrior(aLockType : TnxLockType;
                               aData     : PnxRecordBuffer)
                                         : TnxResult; virtual; abstract;

    {-- record manipulation --}
    function sbcRecordInsert(aLockType      : TnxLockType;
                             aInsertOptions : TnxInsertOptions;
                             aData          : PnxRecordBuffer;
                             aAutoInc       : PnxInt64 = nil)
                                            : TnxResult; virtual; abstract;
    function sbcRecordModify(aData        : PnxRecordBuffer;
                             aReleaseLock : Boolean;
                             aDataDiff    : PnxRecordDiff = nil)
                                          : TnxResult; virtual; abstract;
    function sbcRecordDelete(aData : PnxRecordBuffer;
                             aLSN  : TnxLSN = 0)
                                   : TnxResult; virtual; abstract;

    {-- autoinc --}
    function sbcAutoIncGet: TnxWord32; virtual; abstract;

    {-- information --}
    function sbcGetRecordCount(aOption   : TnxRecordCountOption;
                           out aRecCount : TnxWord32;
                               aEstimate : Boolean = False)
                                         : TnxResult; virtual; abstract;

    {-- misc --}
    function sbcChangePassword(const aNewPassword : UnicodeString)
                                                  : TnxResult; virtual; abstract;
    function sbcDuplicate(aOpenMode    : TnxOpenMode;
                      out aNewCursorID : TnxAbstractCursor;
                          aForceWrite  : Boolean = False)
                                       : TnxResult; virtual; abstract;

    {-- sql engine support --}
    procedure sbcIterate(aData         : PPnxRecordBuffer;
                         aKeyIterator  : TnxKeyIterator;
                         aRecIterator  : TnxRecordIterator;
                         aBackward     : Boolean;
                         aCookie       : Pointer;
                         aKeepPosition : Boolean = False;
                         aResult       : PnxResult = nil;
                         aLongFilter   : Boolean = True); virtual; abstract;

    function sacHasKey(aIndex: Integer; aValue: Variant): Boolean; virtual; abstract;
    function sacGetOpenMode: TnxOpenMode; virtual;
    function sacGetRefNr: TnxRefNr; virtual; abstract;
    procedure sacSetRefNr(const aRefNr: TnxRefNr); virtual; abstract;
    procedure sacSetDefault(aRecordBuffer : PnxRecordBuffer; aIndex: Integer); virtual; abstract;
    procedure sacSetDefaultsInsert(aRecordBuffer : PnxRecordBuffer); virtual; abstract;
    function sacGetRecordByID(const aRefNr        : TnxRefNr;
                                    aRecordBuffer : PnxRecordBuffer)
                                                  : TnxResult; virtual; abstract;
  public
    sbcUseNestedTransaction : Boolean;
    destructor Destroy; override;

    property OpenMode: TnxOpenMode
      read sacGetOpenMode;

    property RootName: string
      read sbcGetRootName;

    property Position : TnxIndexPathPosition
      read sbcGetPosition;

    property OnRequestClose : InxRequestCloseHandler
      read sbcGetOnRequestClose
      write sbcSetOnRequestClose;
  end;

const
  TnxEngineActionStrings      : array[TnxEngineAction] of string = (
    'Create',
    'Destroy',
    'ChildCreate',
    'ChildDestroy',
    'AliasAdd',
    'AliasDelete',
    'AliasModify',
    'AliasGetList',
    'AliasGetPath',
    'CloseInactiveFolders',
    'CloseInactiveTables',
    'BuildPasswords',
    'RegisteredEngines',
    'TransactionStart',
    'TransactionCommit',
    'TransactionRollback',
    'TableBuild',
    'TablePack',
    'TableBackup',
    'TableRebuildIndex',
    'TableRestructure',
    'TableAddField',
    'TableAddIndex',
    'TableDropIndex',
    'TableRename',
    'TableRecover',
    'TableVerifyChecksum',
    'TableDelete',
    'TableEmpty',
    'TableExists',
    'TableGetDictionary',
    'TableGetList',
    'GetChangedTables',
    'OpenFile',
    'OpenFiles',
    'RecordGet',
    'RecordInsert',
    'RecordModify',
    'RecordDelete',
    'RecordFulltextUpdate',
    'StatementPrepare',
    'StatementExec',
    'StatementSetParams',
    'StatementGetParams',
    'ReplicatedFileInit');

  TnxBeforeAfterString        : array[boolean] of string =
    ('After', 'Before');

function nxRequestCloseHandlerEvent(aEvent: TNotifyEvent): InxRequestCloseHandlerEvent;

// internal use only
procedure _DoNothingStub;
// internal use only
function _DoNothingStub2: PnxBoolean;
// internal use only
procedure _DoNothingStub3(aTimeout : TnxWord32; aForce: Boolean = False);

var
  // callback function called when a locktimeout occurs
  nxSetTimeout: procedure(aTimeout : TnxWord32; aForce: Boolean = False) = _DoNothingStub3;
  // callback function called when a locktimeout occurs
  nxLockTimeout   : procedure = _DoNothingStub;
  // callback function called when a unlocktimeout occurs
  nxUnlockTimeout : procedure = _DoNothingStub;
  // callback function called to get failure specific flags
  nxGetFailedFlag : function : PnxBoolean = _DoNothingStub2;


// returns true if the given aTableName is a global temp table
function nxTableNameIsTempGlobal(const aTableName: string): Boolean;
// returns true if the given aTableName is a database specific temp table
function nxTableNameIsTempDatabase(const aTableName: string): Boolean;
// returns true if the given aTableName is a temp statement
function nxTableNameIsTempStatement(const aTableName: string): Boolean;
// returns true if the given aTableName is not persistent
function nxTableNameIsInMem(const aTableName: string): Boolean;


// returns 0 if the given aTableName is a valid name for a root table
function nxCheckValidRootTableName(const aTableName      : string;
                                         aEmptyAsUnknown : Boolean;
                                         aAllowSystem    : Boolean = False)
                                                         : TnxResult;
// returns 0 if the given aTableName is a valid name for a sub table
function nxCheckValidRelativeTableName(const aTableName: string): TnxResult;
// returns true if the given aTableName is a valid name for a table
function nxCheckValidTableName(const aTableName      : string;
                                     aEmptyAsUnknown : Boolean;
                                     aAllowSystem    : Boolean = False)
                                                     : TnxResult;

// returns 0 if the given aAliasName is valid
function nxCheckValidAliasName(const aAliasName      : string;
                                     aEmptyAsUnknown : Boolean)
                                                     : TnxResult;
// returns 0 if the given aAliasName is valid
function nxCheckValidStoredProcName(const aStoredProcName : string;
                                          aEmptyAsUnknown : Boolean)
                                                          : TnxResult;

type
  TnxFeature = (
    nxfDictionaryCaching,
    nxfClientMessageReduction,
    nxfCacheAutoInc,
    nxfRecordCaching,
    nxfDelaySetToBookmark, //only active together with CMR
    nxfAllowLocalFilterForRecordGetBatch
  );

  TnxFeatures = set of TnxFeature;

const
  nxfCMR = nxfClientMessageReduction;

var
  nxFeatures : TnxFeatures = [
    nxfDictionaryCaching,
    nxfClientMessageReduction,
    nxfCacheAutoInc,
    nxfRecordCaching,
    nxfDelaySetToBookmark
  ];

procedure nxEnableFeature(aFeature: TnxFeature); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
procedure nxEnableFeatures(aFeatures: TnxFeatures); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
procedure nxDisableFeature(aFeature: TnxFeature); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
procedure nxDisableFeatures(aFeatures: TnxFeatures); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

var
  BatchStreamAccessClass: TnxBatchStreamAccessClass = TnxBatchStreamAccess;

threadvar
  _CurrentBatchStreamAccess: TnxBatchStreamAccess;

implementation

uses
  TypInfo,
  nxllLockedFuncs,
  nxllConst,
  nxllConvertException,
  nxllUtils,
  nxllBdeStrings,
  nxllWideString,
  nxsdDataDictionaryRefInt,
  Variants,
  nxsdNativeVariantConverter,
  nxsdFilterEngineSimpleExpression;

{$IFNDEF DCC25OrLater}
function GetTickCount64: UInt64; stdcall; external kernel32 name 'GetTickCount64';
{$ENDIF}

type
  TQueryThreadCycleTime = function(ThreadHandle: THandle; var CycleTime: UInt64): Boolean; stdcall;

var
  _QueryThreadCycleTime: TQueryThreadCycleTime;
  {$IFDEF SessionStatsDebug}
  StartSessionStatsTime: TDateTime;
  {$ENDIF SessionStatsDebug}

function EmulateQueryThreadCycleTime(ThreadHandle: THandle; var CycleTime: UInt64): Boolean; stdcall;
var
  lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: TFileTime;
begin
  Result := GetThreadTimes(ThreadHandle, lpCreationTime, lpExitTime, lpKernelTime, lpUserTime);
  if Result then
    CycleTime := UInt64(lpKernelTime) + UInt64(lpUserTime);
end;

procedure LoadQueryThreadCycleTime;
var
  kernel32 : THandle;
begin
  kernel32 := GetModuleHandle('kernel32');
  if kernel32 <> 0 then begin
    Pointer(@_QueryThreadCycleTime) :=
      GetProcAddress(kernel32, 'QueryThreadCycleTime');
  end;

  if not Assigned(_QueryThreadCycleTime) then
    _QueryThreadCycleTime := EmulateQueryThreadCycleTime;
end;

{===nxTableNameIsTempGlobal======================================================}
function nxTableNameIsTempGlobal(const aTableName: string): Boolean;
begin
  Result := (Length(aTableName) > 2)
        and (aTableName[1]='<')
        and (aTableName[Length(aTableName)]='>');

  if not Result then
    Result := (Length(aTableName) > 3)
          and (aTableName[1]='#')
          and (aTableName[2]='#')
          and (aTableName[3]='#')
          and (aTableName[4]<>'#');
end;
{==============================================================================}



{===nxTableNameIsTempDatabase==================================================}
function nxTableNameIsTempDatabase(const aTableName: string): Boolean;
begin
  Result := (Length(aTableName) > 2)
        and (aTableName[1]='#')
        and (aTableName[2]='#')
        and (aTableName[3]<>'#');
end;
{==============================================================================}



{===nxTableNameIsTempStatement==================================================}
function nxTableNameIsTempStatement(const aTableName: string): Boolean;
begin
  Result := (Length(aTableName) > 1)
        and (aTableName[1]='#')
        and (aTableName[2]<>'#');
end;
{==============================================================================}



{===nxTableNameIsInMem=========================================================}
function nxTableNameIsInMem(const aTableName: string): Boolean;
begin
  Result := (Length(aTableName) > 2)
        and (aTableName[1]='<')
        and (aTableName[Length(aTableName)]='>');

  if not Result then
    Result := (Length(aTableName) > 1)
          and (aTableName[1]='#');
end;
{==============================================================================}




{==============================================================================}
function nxCheckValidRootTableName(const aTableName      : string;
                                         aEmptyAsUnknown : Boolean;
                                         aAllowSystem    : Boolean)
                                                         : TnxResult;
var
  RootName  : string;
  ChildName : string;
begin
  nxStrSplit(aTableName, [':'], RootName, ChildName);
  if ChildName <> '' then
    Result :=
      EnxBaseException.nxSetMessage(DBIERR_INVALIDTABLENAME,
        nxcOrgMessageMarker + ' Child name separators ":" are not allowed.')
  else begin
    if (Length(aTableName) > 2) and
      (aTableName[1]='<') and (aTableName[Length(aTableName)]='>') then
      Result := nxCheckValidIdent(Copy(aTableName, 2, Length(aTableName) - 2),
        DBIERR_INVALIDTABLENAME, False, aAllowSystem)
    else
      Result := nxCheckValidIdent(aTableName, DBIERR_INVALIDTABLENAME, False, aAllowSystem);
  end;

  if (Result <> DBIERR_NONE) and aEmptyAsUnknown and (aTableName = '') then
    Result := DBIERR_NOSUCHTABLE;
end;
{------------------------------------------------------------------------------}
function nxCheckValidRelativeTableName(const aTableName: string): TnxResult;
var
  RootName  : string;
  ChildName : string;
begin
  nxStrSplit(aTableName, [':'], RootName, ChildName);

  if (RootName = '.') or (RootName = '..') then
    Result := DBIERR_NONE
  else
    Result := nxCheckValidIdent(RootName, DBIERR_INVALIDTABLENAME, False);

  if (Result = DBIERR_NONE) and (ChildName <> '') then
    Result := nxCheckValidRelativeTableName(ChildName);
end;
{------------------------------------------------------------------------------}
function nxCheckValidTableName(const aTableName      : string;
                                     aEmptyAsUnknown : Boolean;
                                     aAllowSystem    : Boolean)
                                                     : TnxResult;
var
  RootName  : string;
  ChildName : string;
begin
  nxStrSplit(aTableName, [':'], RootName, ChildName);
  Result := nxCheckValidRootTableName(RootName, False, aAllowSystem);
  if (Result = DBIERR_NONE) and (ChildName <> '') then
    Result := nxCheckValidRelativeTableName(ChildName);

  if (Result <> DBIERR_NONE) and aEmptyAsUnknown and (aTableName = '') then
    Result := DBIERR_NOSUCHTABLE;
end;
{==============================================================================}



{==============================================================================}
function nxCheckValidAliasName(const aAliasName      : string;
                                     aEmptyAsUnknown : Boolean)
                                                     : TnxResult;
begin
  Result := nxCheckValidIdent(aAliasName, DBIERR_INVALIDALIASNAME, False);
  if (Result <> DBIERR_NONE) and aEmptyAsUnknown and (aAliasName = '') then
    Result := DBIERR_UNKNOWNDB;
end;
{==============================================================================}



{==============================================================================}
function nxCheckValidStoredProcName(const aStoredProcName : string;
                                          aEmptyAsUnknown : Boolean)
                                                          : TnxResult;
begin
  Result := nxCheckValidIdent(aStoredProcName, DBIERR_INVALIDNAME, False);
  if (Result <> DBIERR_NONE) and aEmptyAsUnknown and (aStoredProcName = '') then
    Result := DBIERR_OBJNOTFOUND;
end;
{==============================================================================}



{==============================================================================}
procedure _DoNothingStub;
begin
end;
{==============================================================================}
function _DoNothingStub2: PnxBoolean;
begin
  Result := nil;
end;
{==============================================================================}
procedure _DoNothingStub3(aTimeout : TnxWord32; aForce: Boolean = False);
begin
end;
{==============================================================================}

{$IFDEF NX_LITE}
{$I Lite\nxLite10.inc}
{$ENDIF}

{===TnxAbstractServerObject====================================================}
function TnxAbstractServerObject.asoConvertException(aException : Exception)
                                                                : TnxResult;
begin
  Result := asoGetServerEngine.bseConvertException(aException, Self);
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoCreateInstance(const aClassID     : TnxGuid;
                                                   const aOuter       : InxInterface;
                                                   const aInterfaceID : TnxGuid;
                                                     out aInterface   )
                                                                      : HRESULT;
begin
  if nxSameGuid(aClassID, CLSID_AbstractServerObject) then
    if Supports(Self, aInterfaceID, aInterface) then
      Result := S_OK
    else
      Result := E_NOINTERFACE
  else
    Result := E_NOINTERFACE;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoGetIsRemote: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoGetMinVersion: Integer;
begin
  if Assigned(asoSession) then
    Result := asoSession.MinVersion
  else
    Result := nxGetCurrentThreadNxVersion;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoGetRemoteID: TnxBaseID;
begin
  Assert(TnxNativeUInt(Self) < TnxNativeUInt(High(TnxBaseID)));
  Result := TnxBaseID(Self);
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoGetRemoteThreadPriority: TnxThreadPriority;
begin
  Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.asoGetServerEngine: TnxBaseServerEngine;
begin
  Result := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.asoSetRemoteThreadPriority(const Value: TnxThreadPriority);
begin
  {nothing}
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  inherited;
  PrepareDestroy;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BeginReadOrgOverride: Integer;
begin
  Inc(acReadOrgOverride);
  Result := acReadOrgOverride;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.Close: TnxResult;
var
  ServerEngine : TnxBaseServerEngine;
begin
  Result := DBIERR_NONE;
  if not Assigned(Self) then
    Exit;

  if not asoDestroying then begin
    ServerEngine := asoGetServerEngine;
    try
      Free;
    except
      on E: Exception do
        Result := ServerEngine.bseConvertException(E, nil);
    end;
  end else
    Result := DBIERR_REENTERED;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractServerObject.Create(aSession: TnxAbstractSession);
begin
  asoSession := aSession;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.CreateInstanceFor(const aName        : string;
                                                   const aClassID     : TnxGuid;
                                                   const aOuter       : InxInterface;
                                                   const aInterfaceID : TnxGuid;
                                                     out aInterface   )
                                                                      : HRESULT;
var
  Session      : TnxAbstractSession;
  ServerEngine : TnxBaseServerEngine;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<Self>') then begin
    if SameText(Right, '<Self>') then
      Result := asoCreateInstance(aClassID, aOuter, aInterfaceID, aInterface)
    else
      Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  end else begin
    Session := asoSession;
    if not Assigned(Session) and (Self is TnxAbstractSession) then
      Session := TnxAbstractSession(Self);

    if SameText(Left, '<Session>') then begin
      if Assigned(Session) then
        Result := Session.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
      else
        Result := E_NOINTERFACE;
    end else begin
      ServerEngine := asoGetServerEngine;
      if Assigned(ServerEngine) then
        Result := ServerEngine.bseCreateInstanceFor(Session, aName, aClassID, aOuter, aInterfaceID, aInterface)
      else
        Result := E_NOINTERFACE;
    end;

  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.EndReadOrgOverride: Integer;
begin
  Dec(acReadOrgOverride);
  Result := acReadOrgOverride;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.Free;
begin
  if Assigned(Self) and not asoDestroying then
    inherited Free;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.FreeInstance;
begin
  asoSession := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxAbstractServerObject.GetEncodedExceptionData(aIncludeChildren: Boolean): string;
var
  Container : InxExceptionDataContainer;
  TheArray  : TnxDynObjectArray;
begin
  SetLength(TheArray, 1);
  TheArray[0] := asoGetServerEngine;
  Container := nxCreateExceptionDataContainer('ExceptionData', Self, TheArray);
  GetExceptionData(Container, aIncludeChildren);
  Result := Container.Encode(nxGetCurrentThreadNxMinVersion);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Destroying', asoDestroying);
end;
{------------------------------------------------------------------------------}
class function TnxAbstractServerObject.LookupByID(aSessionID : TnxSessionID;
                                                  aBaseID    : TnxBaseID;
                                              out aBase      )
                                                             : TnxResult;
{$IFNDEF FPC}
var
  InstanceClass : TClass;
{$ENDIF}
begin
  Result := DBIERR_INVALIDHNDL;
  TnxAbstractServerObject(aBase) := nil;

  try
    if not IsBadReadPtr(Pointer(aBaseID), InstanceSize) and
{$IFNDEF FPC}
      nxIsClassInstance(Pointer(aBaseID), InstanceClass) and
      InstanceClass.InheritsFrom(Self) and
{$ELSE}
      TObject(aBaseID).InheritsFrom(Self) and
{$ENDIF}
      not TnxAbstractServerObject(aBaseID).asoDestroying then begin

      TnxAbstractServerObject(aBase) := TnxAbstractServerObject(aBaseID);
      if TnxAbstractServerObject(aBase).asoSession = TnxAbstractSession(aSessionID) then
        Result := DBIERR_NONE
      else
        TnxAbstractServerObject(aBase) := nil;

    end;
  except
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF CPU64}
class function TnxAbstractServerObject.NewInstance: TObject;
begin
  Result := InitInstance(nxGetMemLow(InstanceSize));
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxAbstractServerObject.PrepareDestroy;
begin
  { can be overriden }
end;
{==============================================================================}



{===TnxExtendableServerObject==================================================}
procedure TnxExtendableServerObject.AfterConstruction;
var
  Result : TnxResult;
begin
  inherited;
  if not esoDelayInformMonitors then begin
    Result := esoNotifyAfterCreate;
    if Result <> DBIERR_NONE then
      raise asoGetServerEngine.bseGetExceptionClass.nxCreate(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.asoGetServerEngine: TnxBaseServerEngine;
begin
  if Assigned(esoParent) then
    Result := esoParent.asoGetServerEngine
  else
    Result := inherited asoGetServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  NotifyExtenders(eaDestroy, True, []);
  if Assigned(esoParent) then
    esoParent.NotifyExtenders(eaChildDestroy, True, [Self]);

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.BeginIgnoreSecurity;
begin
  Inc(esoIgnoreSecurity);
end;
{------------------------------------------------------------------------------}
constructor TnxExtendableServerObject.Create(aParent: TnxExtendableServerObject);
var
  Session : TnxAbstractSession;
begin
  esoParent := aParent;
  if esoInformMonitors then
    asoGetServerEngine.bseInformMonitorsCreated(Self);

  if aParent is TnxAbstractSession then
    Session := TnxAbstractSession(aParent)
  else if Assigned(aParent) then
    Session := aParent.Session
  else
    Session := nil;

  inherited Create(Session);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.CreateInstanceFor(const aName        : string;
                                                     const aClassID     : TnxGuid;
                                                     const aOuter       : InxInterface;
                                                     const aInterfaceID : TnxGuid;
                                                       out aInterface   )
                                                                        : HRESULT;
begin
  if SameText(aName, '<Extenders>') then
    Result := esoCreateInstance(aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface);
end;
{------------------------------------------------------------------------------}
destructor TnxExtendableServerObject.Destroy;
begin
  if Assigned(esoExtendersLock) then begin
    esoExtendersLock.Lock;
    try
      while Assigned(esoExtendersHead) do
        esoExtendersHead.Free;
    finally
      esoExtendersLock.Unlock;
    end;
    nxFreeAndNil(esoExtendersLock);
  end;

  if asoGetServerEngine<>nil then
    asoGetServerEngine.bseInformMonitorsDestroyed(Self);

  inherited;

  nxFreeAndNil(esoOptions);
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.EndIgnoreSecurity;
begin
  Dec(esoIgnoreSecurity);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoCreateInstance(const aClassID     : TnxGuid;
                                                     const aOuter       : InxInterface;
                                                     const aInterfaceID : TnxGuid;
                                                       out aInterface   )
                                                                        : HRESULT;
var
  Extender : TnxBaseEngineExtender;
begin
  Result := E_NOINTERFACE;

  if not Assigned(esoExtendersLock) then
    Exit;
  if not Assigned(esoExtendersHead) then
    Exit;

  esoExtendersLock.Lock;
  try
    Extender := esoExtendersHead;
    while Assigned(Extender) do begin
      Result := Extender.beeCreateInstance(aClassID, aOuter, aInterfaceID, aInterface);
      if Result = S_OK then
        Exit;
      Extender := Extender.beeExtendableObjectNext;
    end;
  finally
    esoExtendersLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoDelayedInformMonitors: TnxResult;
begin
  if esoDelayInformMonitors then begin
    esoDelayInformMonitors := False;
    if esoInformMonitors then
      asoGetServerEngine.bseInformMonitorsCreated(Self);
    Result := esoNotifyAfterCreate;
  end else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoGetIgnoreSecurity: Boolean;
begin
  Result := (esoIgnoreSecurity > 0) or (Assigned(esoParent) and esoParent.IgnoreSecurity);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoGetOptions: TStringList;
begin
  Result := esoOptions;
  if not Assigned(Result) then begin
    Result := TStringList.Create;
    esoOptions := Result;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoGetOptionsParent: TnxExtendableServerObject;
begin
  Result := esoParent;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoInformMonitors: Boolean;
begin
  Result := not esoDelayInformMonitors;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoNotifyAfterCreate: TnxResult;
begin
  if Assigned(esoParent) then
    Result := esoParent.NotifyExtenders(eaChildCreate, False, [Self])
  else
    Result := DBIERR_NONE;
  if Result = DBIERR_NONE then
    Result := NotifyExtenders(eaCreate, False, []);
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.esoOptionChanged(const aName  : string;
                                                     const aValue : string);
begin
  { can be overriden }
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionClear(const aName: string): TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_OBJNOTFOUND;
  if Assigned(esoOptions) then with esoOptions do begin
    i := IndexOfName(aName);
    if i >=0 then begin
      Delete(i);
      if Count = 0 then
        nxFreeAndNil(esoOptions);
      esoOptionChanged(aName, '');
      Result := DBIERR_NONE;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionGet(const aName  : string;
                                                  out aValue : string)
                                                             : TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_OBJNOTFOUND;
  if Assigned(esoOptions) then with esoOptions do begin
    i := IndexOfName(aName);
    if i >=0 then begin
      aValue := Values[Names[i]];
      Result := DBIERR_NONE;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionGetEffective(const aName  : string;
                                                           out aValue : string)
                                                                      : TnxResult;
begin
  Result := esoOptionGet(aName, aValue);
  if Result = DBIERR_OBJNOTFOUND then
    Result := esoOptionGetParent(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionGetParent(const aName  : string;
                                                        out aValue : string)
                                                                   : TnxResult;
var
  Parent : TnxExtendableServerObject;
begin
  Result := DBIERR_OBJNOTFOUND;
  Parent := esoGetOptionsParent;
  if Assigned(Parent) then
    Result := Parent.esoOptionGetEffective(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionList(aList: TStrings): TnxResult;
begin
  Result := DBIERR_NONE;
  aList.BeginUpdate;
  try
    aList.Clear;
    if Assigned(esoOptions) then
      aList.AddStrings(esoOptions);
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionListEffective(aList : TStrings)
                                                                : TnxResult;
var
  ParentList: TStringList;
begin
  aList.BeginUpdate;
  try
    aList.Clear;
    Result := esoOptionList(aList);

    if Result = DBIERR_NONE then begin
      ParentList := TStringList.Create;
      try
        Result := esoOptionListParent(ParentList);
        if Result = DBIERR_NONE then
          Result := esoOptionListMerge(aList, ParentList);
      finally
        nxFreeAndNil(ParentList);
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionListMerge(aOwnList    : TStrings;
                                                      aParentList : TStrings)
                                                                  : TnxResult;
var
  i    : Integer;
  Name : string;
begin
  Result := DBIERR_NONE;
  for i := 0 to Pred(aParentList.Count) do begin
    Name := aParentList.Names[i];
    if aOwnList.IndexOfName(Name) < 0 then
      aOwnList.Values[Name] := aParentList.Values[aParentList.Names[i]];
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionListParent(aList : TStrings)
                                                             : TnxResult;
var
  Parent : TnxExtendableServerObject;
begin
  Result := DBIERR_NONE;
  Parent := esoGetOptionsParent;
  if Assigned(Parent) then
    Result := Parent.esoOptionList(aList);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.esoOptionSet(const aName  : string;
                                                const aValue : string)
                                                             : TnxResult;
begin
  esoGetOptions.Values[aName] := aValue;
  esoOptionChanged(aName, aValue);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  NeedLock : Boolean;
begin
  inherited;
  if Assigned(esoOptions) then begin
    NeedLock := Self is TnxLockedOptionsExtendableServerObject;
    if NeedLock then
      TnxPadlock.CreateAndLock(TnxLockedOptionsExtendableServerObject(Self).loesoOptionsLock);
    try
      if Assigned(esoOptions) then
        aContainer.AddValue('Options', esoOptions);
    finally
      if NeedLock then
        TnxLockedOptionsExtendableServerObject(Self).loesoOptionsLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.GetExtenderOfType(aExtenderClass : TnxBaseEngineExtenderClass)
                                                                    : TnxBaseEngineExtender;
begin
  Result := nil;
  if not Assigned(esoExtendersLock) then
    Exit;
  if not Assigned(esoExtendersHead) then
    Exit;

  esoExtendersLock.Lock;
  try
    Result := esoExtendersHead;
    while Assigned(Result) do begin
      if Result is aExtenderClass then
        Exit;
      Result := Result.beeExtendableObjectNext;
    end;
  finally
    esoExtendersLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.GetNotifyFor(aAction: TnxEngineAction): TnxEngineNotify;
var
  Extender : TnxBaseEngineExtender;
begin
  Result := nil;
  if not (aAction in esoExtendersActions) then
    Exit;
  if not Assigned(esoExtendersLock) then
    Exit;
  if not Assigned(esoExtendersHead) then
    Exit;

  esoExtendersLock.Lock;
  try
    Extender := esoExtendersHead;
    while Assigned(Extender) do begin
      if aAction in Extender.beeActions then begin
        if Assigned(Result) then begin
          { more than one extender for that action... }
          Result := NotifyExtenders;
          Exit;
        end;
        Result := Extender.Notify;
      end;
      Extender := Extender.beeExtendableObjectNext;
    end;
  finally
    esoExtendersLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.NotifyExtenders(aAction : TnxEngineAction;
                                                   aBefore : Boolean;
                                             const aArgs   : array of const)
                                                           : TnxResult;
var
  Extender : TnxBaseEngineExtender;
begin
  Result := DBIERR_NONE;
  if not (aAction in esoExtendersActions) then
    Exit;
  if not Assigned(esoExtendersLock) then
    Exit;
  if not Assigned(esoExtendersHead) then
    Exit;

  try
    esoExtendersLock.Lock;
    try
      Extender := esoExtendersHead;
      while Assigned(Extender) do begin
        try
          if aAction in Extender.beeActions then
            Result := Extender.Notify(aAction, aBefore, aArgs);
        except
          on E : Exception do
            Result := Self.asoConvertException(E);
        end;
        if Result <> DBIERR_NONE then
          break;
        Extender := Extender.beeExtendableObjectNext;
      end;
    finally
      esoExtendersLock.Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionClear(const aName : string)
                                                           : TnxResult;
begin
  Result := esoOptionClear(aName);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionGet(const aName  : string;
                                               out aValue : string)
                                                          : TnxResult;
begin
  Result := esoOptionGet(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionGetEffective(const aName  : string;
                                                        out aValue : string)
                                                                   : TnxResult;
begin
  Result := esoOptionGetEffective(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionList(aList : TStrings)
                                                    : TnxResult;
begin
  Result := esoOptionList(aList);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionListEffective(aList : TStrings)
                                                             : TnxResult;
begin
  Result := esoOptionListEffective(aList);
end;
{------------------------------------------------------------------------------}
function TnxExtendableServerObject.OptionSet(const aName  : string;
                                             const aValue : string)
                                                          : TnxResult;
begin
  Result := esoOptionSet(aName, aValue);
end;
{------------------------------------------------------------------------------}
procedure TnxExtendableServerObject.PrepareDestroy;
var
  Extender : TnxBaseEngineExtender;
begin
  inherited;

  if Assigned(esoExtendersLock) and Assigned(esoExtendersHead) then try
    esoExtendersLock.Lock;
    try
      Extender := esoExtendersHead;
      while Assigned(Extender) do begin
        try
          Extender.PrepareDestroy;
        except
          on E : Exception do
            Self.asoConvertException(E);
        end;
        Extender := Extender.beeExtendableObjectNext;
      end;
    finally
      esoExtendersLock.Unlock;
    end;
  except
    on E : Exception do
      Self.asoConvertException(E);
  end;
end;
{==============================================================================}



{===TnxLockedOptionsExtendableServerObject=====================================}
destructor TnxLockedOptionsExtendableServerObject.Destroy;
begin
  inherited;
  nxFreeAndNil(loesoOptionsLock);
end;
{------------------------------------------------------------------------------}
function TnxLockedOptionsExtendableServerObject.esoOptionClear(const aName : string)
                                                                           : TnxResult;
begin
  TnxPadlock.CreateAndLock(loesoOptionsLock);
  try
    Result := inherited esoOptionClear(aName);
  finally
    loesoOptionsLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxLockedOptionsExtendableServerObject.esoOptionGet(const aName  : string;
                                                               out aValue : string)
                                                                          : TnxResult;
begin
  TnxPadlock.CreateAndLock(loesoOptionsLock);
  try
    Result := inherited esoOptionGet(aName, aValue);
  finally
    loesoOptionsLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxLockedOptionsExtendableServerObject.esoOptionList(aList : TStrings)
                                                                    : TnxResult;
begin
  TnxPadlock.CreateAndLock(loesoOptionsLock);
  try
    Result := inherited esoOptionList(aList);
  finally
    loesoOptionsLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxLockedOptionsExtendableServerObject.esoOptionSet(const aName  : string;
                                                             const aValue : string)
                                                                          : TnxResult;
begin
  TnxPadlock.CreateAndLock(loesoOptionsLock);
  try
    Result := inherited esoOptionSet(aName, aValue);
  finally
    loesoOptionsLock.Unlock;
  end;
end;
{==============================================================================}



{===TnxAbstractTaskInfo========================================================}
procedure TnxAbstractTaskInfo.atiAddToSession;
begin
  asoSession.asTaskInfosPadlock.Lock;
  try
    atiSessionPrev := asoSession.asTaskInfosTail;
    asoSession.asTaskInfosTail := Self;
    if Assigned(atiSessionPrev) then
      atiSessionPrev.atiSessionNext:=Self;
    if not Assigned(asoSession.asTaskInfosHead) then
      asoSession.asTaskInfosHead := Self;
  finally
    asoSession.asTaskInfosPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTaskInfo.atiRemoveFromSession;
begin
  asoSession.asTaskInfosPadlock.Lock;
  try
    if Assigned(atiSessionNext) then
      atiSessionNext.atiSessionPrev := atiSessionPrev
    else
      if asoSession.asTaskInfosTail = Self then
        asoSession.asTaskInfosTail := atiSessionPrev;

    if Assigned(atiSessionPrev) then
      atiSessionPrev.atiSessionNext := atiSessionNext
    else
      if asoSession.asTaskInfosHead = Self then
        asoSession.asTaskInfosHead := atiSessionNext;

    atiSessionNext := nil;
    atiSessionPrev := nil;
  finally
    asoSession.asTaskInfosPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractTaskInfo.Create(aSession: TnxAbstractSession);
begin
  inherited Create(aSession);
  atiAddToSession;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTaskInfo.CreateInstanceFor(const aName        : string;
                                               const aClassID     : TnxGuid;
                                               const aOuter       : InxInterface;
                                               const aInterfaceID : TnxGuid;
                                                 out aInterface   )
                                                                  : HRESULT;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<TaskInfo>') then
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractTaskInfo.Destroy;
begin
  atiRemoveFromSession;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTaskInfo.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Session', asoSession);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTaskInfo.PrepareDestroy;
begin
  Cancel;
  inherited;
end;
{==============================================================================}



{==============================================================================}
constructor TnxSimpleLock.Create(aFailedCleanup: TNotifyEvent; aStats: TnxSessionStats);
begin
  slStats := aStats;
  slFailedCleanupDone := CreateEvent(nil, True, False, nil);

  slFailedCleanup := aFailedCleanup;
  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxSimpleLock.Destroy;
begin
  if Assigned(slStats) then begin
    slStats.Close;
    slStats := nil;
  end;

  Assert(slLockingThread = 0);
  inherited;
  nxCloseEventAndSetAndNull(slFailedCleanupDone);
end;
{------------------------------------------------------------------------------}
procedure TnxSimpleLock.Failed(aPermanent, aWait : Boolean);
begin
  if aPermanent then
    slFailedPermanent := True;

  if not slFailed or (slFailedPermanent and not slFailedCleanedup) then begin
    while LockedCompareExchange(slFailedSpinlock, 1, 0) <> 0 do
      Sleep(1);

    slFailed := True;
    if Assigned(slFailedFlag) then
      slFailedFlag^ := slFailed;

    if slFailedPermanent then
      if (not slFailedCleanedup) and (slLockCount = 0) then begin
        slFailedCleanedup := True;
        if Assigned(slFailedCleanup) then try
          slFailedCleanup(Self);
        except end;
      end;

    if LockedCompareExchange(slFailedSpinlock, 0, 1) <> 1 then
      raise EnxBaseException.nxCreate(DBIERR_REENTERED);
  end;

  if aPermanent and aWait then
    WaitForSingleObject(slFailedCleanupDone, nxcl_FailedTimeout);
end;
{------------------------------------------------------------------------------}
function TnxSimpleLock.IsFailedPermanent: Boolean;
begin
  Result := slFailedPermanent;
end;
{------------------------------------------------------------------------------}
function TnxSimpleLock.LastLocked: TnxWord64;
begin
  if slLockCount > 0 then
    Result := GetTickCount64
  else
    Result := slLastLocked;
end;

procedure TnxSimpleLock.Lock;

  procedure RaiseReentered;
  begin
    nxSetExceptionHookInfo(@slExceptionHookInfo);
    try
      raise EnxBaseException.nxCreate(DBIERR_REENTERED);
    finally
      nxSetExceptionHookInfo(nil);
    end;
  end;

var
  ThreadID    : Integer;
  OldThreadID : Integer;
begin
  if _FatalException then
    raise EnxBaseException.nxCreate(DBIERR_NX_CORRUPTTRANS, @rsFatalError);

  if slFailedPermanent then
    raise EnxBaseException.nxCreate(DBIERR_INVALIDHNDL, @rsFailedPermanent);

  if slFailed then begin
    slFailed := False;
    raise EnxBaseException.nxCreate(DBIERR_NX_GeneralTimeout, @rsProcessingCancelled);
  end;

  ThreadID := Integer(GetCurrentThreadId);

  OldThreadID := LockedCompareExchange(slLockingThread, Integer(GetCurrentThreadId), 0);

  if OldThreadID = ThreadID then
    Assert(slLockCount > 0)
  else if OldThreadID = 0 then
    Assert(slLockCount = 0)
  else
    RaiseReentered;

  LockedInc(slLockCount);

  if slLockCount = 1 then begin

    while LockedCompareExchange(slFailedSpinlock, 1, 0) <> 0 do
      Sleep(1);

    slFailedFlag := nxGetFailedFlag;
    if Assigned(slFailedFlag) then begin
      slFailedOrg := slFailedFlag^;
      slFailedFlag^ := slFailed;
    end;

    if LockedCompareExchange(slFailedSpinlock, 0, 1) <> 1 then
      raise EnxBaseException.nxCreate(DBIERR_REENTERED);

    if slFailedPermanent then
      raise EnxBaseException.nxCreate(DBIERR_INVALIDHNDL, @rsFailedPermanent);

    if slFailed then begin
      slFailed := False;
      raise EnxBaseException.nxCreate(DBIERR_NX_GeneralTimeout, @rsProcessingCancelled);
    end;

    if Assigned(slStats) then
      slStats.Enter;
  end;

  nxSetExceptionHookInfo(@slExceptionHookInfo);
end;
{------------------------------------------------------------------------------}
procedure TnxSimpleLock.SetFailedCleanupDone;
begin
  SetEvent(slFailedCleanupDone);
end;
{------------------------------------------------------------------------------}
procedure TnxSimpleLock.Unlock(var aResult: TnxResult);

  procedure RaiseReentered;
  begin
    nxSetExceptionHookInfo(@slExceptionHookInfo);
    try
      raise EnxBaseException.nxCreate(DBIERR_REENTERED);
    finally
      nxSetExceptionHookInfo(nil);
    end;
  end;

var
  ThreadID: Integer;
begin
  ThreadID := Integer(GetCurrentThreadId);

  if LockedCompareExchange(slLockingThread, ThreadID, ThreadID) <> ThreadID then
    RaiseReentered;

  LockedDec(slLockCount);

  if slLockCount = 0 then begin

    if Assigned(slStats) then
      slStats.Leave;

    while LockedCompareExchange(slFailedSpinlock, 1, 0) <> 0 do
      Sleep(1);

    if Assigned(slFailedFlag) then
      slFailedFlag^ := slFailedOrg;
    slFailedFlag := nil;

    if not slFailedPermanent then begin
      if slFailed then begin
        slFailed := False;
        if aResult = DBIERR_NONE then
          aResult := EnxBaseException.nxSetMessage(DBIERR_NX_GeneralTimeout, @rsProcessingCancelledSuccess);
      end;
    end else if not slFailedCleanedup then begin
      slFailedCleanedup := True;
      if Assigned(slFailedCleanup) then try
        slFailedCleanup(Self);
      except end;
    end;

    if LockedCompareExchange(slFailedSpinlock, 0, 1) <> 1 then
      RaiseReentered;

    slLastLocked := GetTickCount64;

    if LockedCompareExchange(slLockingThread, 0, ThreadID) <> ThreadID then
      RaiseReentered;

    nxSetExceptionHookInfo(nil);
  end;
end;
{==============================================================================}



{===TnxAbstractTimeoutObject===================================================}
procedure TnxAbstractTimeoutObject.atoAddSelfToTimeoutBatch;
var
  lSession: TnxAbstractSession;
begin
  if Self is TnxAbstractSession then
    lSession := TnxAbstractSession(Self)
  else
    lSession := asoSession;

  if Assigned(lSession) then begin
    if Assigned(lSession.asTimeoutBatchPadlock) then
      lSession.asTimeoutBatchPadlock.Lock;
    try
      if Assigned(atoTimeoutBatchPrev) or
         Assigned(atoTimeoutBatchNext) or
         (lSession.asTimeoutBatchHead = Self)
      then
        Exit;

      atoTimeoutBatchPrev := lSession.asTimeoutBatchTail;
      atoTimeoutBatchNext := nil;

      if Assigned(lSession.asTimeoutBatchTail) then
        lSession.asTimeoutBatchTail.atoTimeoutBatchNext := Self
      else
        lSession.asTimeoutBatchHead := Self;

      lSession.asTimeoutBatchTail := Self;
    finally
      if Assigned(lSession.asTimeoutBatchPadlock) then
        lSession.asTimeoutBatchPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.atoAddToTimeoutBatch(aATO : TnxAbstractTimeoutObject)
                                                            : Boolean;
begin
  if Assigned(asoSession) then
    Result := asoSession.atoAddToTimeoutBatch(aATO)
  else
    Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTimeoutObject.atoRemoveSelfFromTimeoutBatch;
var
  lSession: TnxAbstractSession;
begin
  if Self is TnxAbstractSession then
    lSession := TnxAbstractSession(Self)
  else
    lSession := asoSession;

  if Assigned(lSession) then begin
    if Assigned(lSession.asTimeoutBatchPadlock) then
      lSession.asTimeoutBatchPadlock.Lock;
    try
      if Assigned(atoTimeoutBatchPrev) then
        atoTimeoutBatchPrev.atoTimeoutBatchNext := atoTimeoutBatchNext
      else
        lSession.asTimeoutBatchHead := atoTimeoutBatchNext;

      if Assigned(atoTimeoutBatchNext) then
        atoTimeoutBatchNext.atoTimeoutBatchPrev := atoTimeoutBatchPrev
      else
        lSession.asTimeoutBatchTail := atoTimeoutBatchPrev;

      atoTimeoutBatchPrev := nil;
      atoTimeoutBatchNext := nil;
    finally
      if Assigned(lSession.asTimeoutBatchPadlock) then
        lSession.asTimeoutBatchPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTimeoutObject.atoSetTimeout(aTimeout: TnxWord32);
begin
  atoTimeout := aTimeout;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.BeginTimeoutBatch: Integer;
begin
  if Assigned(asoSession) then
    Result := asoSession.BeginTimeoutBatch
  else
    Result := -1;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.Close: TnxResult;
var
  ServerEngine : TnxBaseServerEngine;
  Lock         : InxSimpleLock;
begin
  Result := DBIERR_NONE;
  if not Assigned(Self) then
    Exit;

  if not asoDestroying then begin
    Lock := atoLock;
    if Assigned(Lock) then
      if Lock.IsFailedPermanent then
        Lock := nil;
    if Assigned(Lock) then
      Lock.Lock;
    try
      ServerEngine := asoGetServerEngine;
      try
        if (Self is TnxAbstractSession) and Assigned(Lock) then begin
          Lock.Failed(True, False);
          Lock.Unlock(Result);
          Lock := nil;
          Result := DBIERR_NONE;
        end;
        Free;
      except
        on E: Exception do
          Result := ServerEngine.bseConvertException(E, nil);
      end;
    finally
      if Assigned(Lock) then
        Lock.Unlock(Result);
    end;
  end else
    Result := DBIERR_REENTERED;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractTimeoutObject.Create(aParent  : TnxExtendableServerObject;
                                            aTimeout : TnxWord32);
begin
  inherited Create(aParent);
  atoTimeout := aTimeout;
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractTimeoutObject.Destroy;
begin
  atoRemoveSelfFromTimeoutBatch;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.EndTimeoutBatch: Integer;
begin
  if Assigned(asoSession) then
    Result := asoSession.EndTimeoutBatch
  else
    Result := -1;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTimeoutObject.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Timeout', atoTimeout);
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.LastLocked: TnxWord64;
begin
  if Assigned(atoLock) then
    Result := atoLock.LastLocked
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionClear(const aName : string)
                                                          : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionClear(aName);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionGet(const aName  : string;
                                              out aValue : string)
                                                         : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionGet(aName, aValue);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionGetEffective(const aName  : string;
                                                       out aValue : string)
                                                                  : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionGetEffective(aName, aValue);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionList(aList : TStrings)
                                                   : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionList(aList);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionListEffective(aList : TStrings)
                                                            : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionListEffective(aList);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTimeoutObject.OptionSet(const aName  : string;
                                            const aValue : string)
                                                         : TnxResult;
begin
  atoLock.Lock;
  try
    Result := inherited OptionSet(aName, aValue);
    if aName = '_CurrentClientInfo' then
      TnxSessionStats.SetClientInfo(esoGetOptions.Values['_CurrentClientInfo']);
  finally
    atoLock.Unlock(Result);
  end;
end;
{==============================================================================}



{===TnxAbstractSession=========================================================}
procedure TnxAbstractSession.AfterConstruction;
begin
  inherited;
  LockedInc(asoGetServerEngine.bseSessionCount);
  asLockedIncDone := True;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.asAddToServerEngine;
begin
  asServerEngine.bseSessionsPadlock.Lock;
  try
    asServerEnginePrev := asServerEngine.bseSessionsTail;
    asServerEngine.bseSessionsTail := Self;
    if Assigned(asServerEnginePrev) then
      asServerEnginePrev.asServerEngineNext:=Self;
    if not Assigned(asServerEngine.bseSessionsHead) then
      asServerEngine.bseSessionsHead := Self;
  finally
    asServerEngine.bseSessionsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.asCleanup(aSender: TObject);
var
  Counter      : Integer;
  TaskInfo     : TnxAbstractTaskInfo;
  TransContext : TnxAbstractTransContext;
  Database     : TnxAbstractDatabase;
begin
  Counter := 0;
  while Assigned(asTaskInfosHead) and (Counter < 20) do begin
    if Counter > 0 then
      Sleep(100);
    asTaskInfosPadlock.Lock;
    try
      TaskInfo := asTaskInfosHead;
      while Assigned(TaskInfo) do begin
        TaskInfo.PrepareDestroy;
        TaskInfo := TaskInfo.atiSessionNext;
      end;
    finally
      asTaskInfosPadlock.Unlock;
    end;
    Sleep(1);
    Inc(Counter);
  end;

  asDatabasesPadlock.Lock;
  try
    Database := asDatabasesHead;
    while Assigned(Database) do begin
      Database.PrepareDestroy;
      Database := Database.adSessionNext;
    end;
  finally
    asDatabasesPadlock.Unlock;
  end;

  asTransContextsPadlock.Lock;
  try
    TransContext := asTransContextsHead;
    while Assigned(TransContext) do begin
      TransContext.PrepareDestroy;
      TransContext := TransContext.atcSessionNext;
    end;
  finally
    asTransContextsPadlock.Unlock;
  end;

  asTaskInfosPadlock.Lock;
  try
    while Assigned(asTaskInfosTail) do
      asTaskInfosTail.Free;
  finally
    asTaskInfosPadlock.Unlock;
  end;

  asDatabasesPadlock.Lock;
  try
    while Assigned(asDatabasesTail) do
      asDatabasesTail.Free;
  finally
    asDatabasesPadlock.Unlock;
  end;

  asTransContextsPadlock.Lock;
  try
    while Assigned(asTransContextsTail) do
      asTransContextsTail.Free;
  finally
    asTransContextsPadlock.Unlock;
  end;

  asCleanedUp := True;
  atoLock.SetFailedCleanupDone;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asCreateStats: TnxSessionStats;
begin
  if asServerEngine.bseGetKeepSessionStats then
    Result := asDoCreateStats
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asDoCreateStats: TnxSessionStats;
var
  HI : TnxWord32;
begin
  HI := nxGetCurrentThreadHeartbeatInterval;
  Result := TnxSessionStats.Create(asUserName, asConnectedFrom, HI);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.asFailed(aPermanent, aWait : Boolean);
begin
  if Assigned(atoLock) then
    atoLock.Failed(aPermanent, aWait);
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asGetClientDefaultLocale: TnxLocaleDescriptor;
begin
  Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asGetClientVersion: Integer;
begin
  Result := nxVersionNumber;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asGetServerVersion: Integer;
begin
  Result := nxVersionNumber;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asGetSessionNotifications: InxSessionNotifications;
var
  SessionNotifications: TnxSessionNotifications;
begin
  if not Assigned(asSessionNotifications) then begin
    SessionNotifications := TnxSessionNotifications.Create(Self);
    if LockedCompareExchange(asSessionNotifications, SessionNotifications, nil) <> nil then
      nxFreeAndNil(SessionNotifications);
    Result := asSessionNotifications;
  end else
    Result := asSessionNotifications;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asoGetMinVersion: Integer;
begin
  Result := nxMinI32(asGetClientVersion, asGetServerVersion);
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.asoGetServerEngine: TnxBaseServerEngine;
begin
  Result := asServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.asRemoveFromServerEngine;
begin
  if Assigned(asServerEngine) then begin
    asServerEngine.bseSessionsPadlock.Lock;
    try
      if Assigned(asServerEngineNext) then
        asServerEngineNext.asServerEnginePrev := asServerEnginePrev
      else
        if asServerEngine.bseSessionsTail = Self then
          asServerEngine.bseSessionsTail := asServerEnginePrev;

      if Assigned(asServerEnginePrev) then
        asServerEnginePrev.asServerEngineNext := asServerEngineNext
      else
        if asServerEngine.bseSessionsHead = Self then
          asServerEngine.bseSessionsHead := asServerEngineNext;

      asServerEngineNext := nil;
      asServerEnginePrev := nil;

      if not Assigned(asServerEngine.bseSessionsHead) then
        asServerEngine.bseInactive;
    finally
      asServerEngine.bseSessionsPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.asTimeoutBatchClear;
var
  lCurrent, lNext: TnxAbstractTimeoutObject;
begin
  if Assigned(asTimeoutBatchPadlock) then
    asTimeoutBatchPadlock.Lock;
  try
    lCurrent := asTimeoutBatchHead;
    while Assigned(lCurrent) do begin
      lNext := lCurrent.atoTimeoutBatchNext;
      lCurrent.atoTimeoutBatchPrev := nil;
      lCurrent.atoTimeoutBatchNext := nil;
      lCurrent := lNext;
    end;
    asTimeoutBatchHead := nil;
    asTimeoutBatchTail := nil;
  finally
    if Assigned(asTimeoutBatchPadlock) then
      asTimeoutBatchPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if asLockedIncDone then
    LockedDec(asoGetServerEngine.bseSessionCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractSession.Create(aServerEngine  : TnxBaseServerEngine;
                                      aTimeout       : TnxWord32;
                                const aUserName      : UnicodeString;
                                const aPassword      : UnicodeString;
                                const aConnectedFrom : string);
begin
  asServerEngine := aServerEngine;
  asConnectedSince := Now;
  asUserName := aUserName;
  asPassword := aPassword;
  asConnectedFrom := aConnectedFrom;

  asLock := TnxSimpleLock.Create(asCleanup, asCreateStats);
  asLock.slExceptionHookInfo.ehiUserName := aUserName;
  asLock.slExceptionHookInfo.ehiConnectedFrom := aConnectedFrom;
  asLock.slExceptionHookInfo.ehiSessionID := Int64(TnxNativeUInt(Self));
  atoLock := asLock;

  asDatabasesPadlock := TnxPadlock.Create(True);
  asTransContextsPadlock := TnxPadlock.Create(True);
  asTaskInfosPadlock := TnxPadlock.Create(True);
  asTimeoutBatchPadlock := TnxPadlock.Create(True);
  asAddToServerEngine;
  inherited Create(nil, aTimeOut);
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.DatabaseCacheOpen(out aDatabase     : TnxAbstractDatabase;
                                            const aAliasType    : string;
                                            const aAlias        : string;
                                                  aTransContext : TnxAbstractTransContext;
                                                  aOpenMode     : TnxOpenMode;
                                                  aShareMode    : TnxShareMode;
                                                  aTimeout      : TnxWord32)
                                                                : TnxResult;
begin
  Result := nxpNotSupported('DatabaseCacheOpen');
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractSession.Destroy;
begin
  if Assigned(asSessionNotifications) then
    asSessionNotifications.Disconnected;

  asRemoveFromServerEngine;

  nxFreeAndNil(asTransContextsPadlock);
  nxFreeAndNil(asDatabasesPadlock);
  nxFreeAndNil(asTaskInfosPadlock);

  inherited;

  nxFreeAndNil(asSessionNotifications);
  nxFreeAndNil(asTimeoutBatchPadlock);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.Failed(aPermanent : Boolean);
begin
  if Assigned(Self) and not asoDestroying then
    asFailed(aPermanent, False);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i           : Integer;
  db          : TnxAbstractDatabase;
  dbContainer : InxExceptionDataContainer;
  tc          : TnxAbstractTransContext;
  tcContainer : InxExceptionDataContainer;
  ti          : TnxAbstractTaskInfo;
  tiContainer : InxExceptionDataContainer;
begin
  inherited;
  aContainer.AddValue('ServerEngine', asServerEngine);
  aContainer.AddValue('UserName', asUserName);
  aContainer.AddValue('Authenticated', asAuthenticated);
  aContainer.AddValue('ConnectedFrom', asConnectedFrom);
  aContainer.AddValue('CleanedUp', asCleanedUp);
  if aIncludeChildren then begin
    dbContainer := aContainer.AddContainer('Databases');
    asDatabasesPadlock.Lock;
    try
      db := asDatabasesHead;
      if Assigned(db) then begin
        i := 0;
        while Assigned(db) do begin
          dbContainer.AddValue('[' + IntToStr(i) + ']', db, True);
          Inc(i);
          db := db.adSessionNext;
        end;
      end;
    finally
      asDatabasesPadlock.Unlock;
    end;

    tcContainer := aContainer.AddContainer('TransContexts');
    asTransContextsPadlock.Lock;
    try
      tc := asTransContextsHead;
      if Assigned(tc) then begin
        i := 0;
        while Assigned(tc) do begin
          tcContainer.AddValue('[' + IntToStr(i) + ']', tc, True);
          Inc(i);
          tc := tc.atcSessionNext;
        end;
      end;
    finally
      asTransContextsPadlock.Unlock;
    end;

    tiContainer := aContainer.AddContainer('TaskInfos');
    asTaskInfosPadlock.Lock;
    try
      ti := asTaskInfosHead;
      if Assigned(ti) then begin
        i := 0;
        while Assigned(ti) do begin
          tiContainer.AddValue('[' + IntToStr(i) + ']', ti, True);
          Inc(i);
          ti := ti.atiSessionNext;
        end;
      end;
    finally
      asTaskInfosPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractSession.GetUserInfo(aStrings: TStrings);
const
  AuthenticatedText : array[Boolean] of string =
    ('no autentificado', 'autentificado');      //..
var
  s: string;
begin
   s := DateTimeToStr(asConnectedSince);
   aStrings.Add(
     nxeCustomInfo('Session.ID', IntToStr(Int64(TnxSessionID(Self)))) +
     ' Conexión : ' + s + nxeCustomInfo('Session.ConnectedSince', s));

  if UserName <> '' then
    aStrings.Add(' Usuario : ' + Username + ' [' + AuthenticatedText[ asAuthenticated ]+']' +
      nxeCustomInfo('Session.UserName', Username) +
      nxeCustomInfo('Session.Authenticated', IntToStr(Ord(asAuthenticated))))
  else
    aStrings.Add(' usuario anónimo ' + nxeCustomInfo( 'Session.UserName', '') );

  if asConnectedFrom <> '' then
    aStrings.Add(' Desde : ' + asConnectedFrom + nxeCustomInfo( 'Session.ConnectedFrom', asConnectedFrom ) );
end;
{------------------------------------------------------------------------------}
class function TnxAbstractSession.LookupByID(aSessionID : TnxSessionID;
                                         out aSession   )
                                                        : TnxResult;
begin
  Result := LookupByID(0, aSessionID, aSession);
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.OptionSet(const aName, aValue: string): TnxResult;
begin
  Result := inherited OptionSet(aName, aValue);
  asLock.slExceptionHookInfo.ehiClient := esoGetOptions.Values['_CurrentClientInfo'];
end;

{------------------------------------------------------------------------------}
procedure TnxAbstractSession.PrepareDestroy;
begin
  asFailed(True, True);
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.TableExists(const aAliasName   : string;
                                        const aTableName   : string;
                                        const aPassword    : UnicodeString;
                                          out aExists      : Boolean;
                                              aAllowSystem : Boolean = False)
                                                           : TnxResult;
var
  Database: TnxAbstractDatabase;
begin
  aExists := False;
  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := DatabaseOpen(Database, nxatAliasName, aAliasName, nil, omReadOnly, smShared, atoTimeout);
      if Result = DBIERR_NONE then try
        Result := Database.TableExists(aTableName, aPassword, aExists, aAllowSystem or Database.ExplicitAllowSystem);
      finally
        Database.Free;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.TableStreamRead(const aAliasName  : string;
                                            const aTableName  : string;
                                            const aPassword   : UnicodeString;
                                            const aStreamName : string;
                                                  aStream     : TStream)
                                                              : TnxResult;
var
  Database: TnxAbstractDatabase;
begin
  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := DatabaseOpen(Database, nxatAliasName, aAliasName, nil, omReadOnly, smShared, atoTimeout);
      if Result = DBIERR_NONE then try
        Result := Database.TableStreamRead(aTableName, aPassword, aStreamName, aStream);
      finally
        Database.Free;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSession.TableStreamWrite(const aAliasName  : string;
                                             const aTableName  : string;
                                             const aPassword   : UnicodeString;
                                             const aStreamName : string;
                                                   aStream     : TStream)
                                                               : TnxResult;
var
  Database: TnxAbstractDatabase;
begin
  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := DatabaseOpen(Database, nxatAliasName, aAliasName, nil, omReadWrite, smShared, atoTimeout);
      if Result = DBIERR_NONE then try
        Result := Database.TableStreamWrite(aTableName, aPassword, aStreamName, aStream);
      finally
        Database.Free;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{==============================================================================}



{===TnxAbstractDatabase========================================================}
procedure TnxAbstractDatabase.adAddToSession;
begin
  asoSession.asDatabasesPadlock.Lock;
  try
    adSessionPrev := asoSession.asDatabasesTail;
    asoSession.asDatabasesTail := Self;
    if Assigned(adSessionPrev) then
      adSessionPrev.adSessionNext:=Self;
    if not Assigned(asoSession.asDatabasesHead) then
      asoSession.asDatabasesHead := Self;
  finally
    asoSession.asDatabasesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.adAddToTransContext;
begin
  adTransContext.atcDatabasesPadlock.Lock;
  try
    adTransContextPrev := adTransContext.atcDatabasesTail;
    adTransContext.atcDatabasesTail := Self;
    if Assigned(adTransContextPrev) then
      adTransContextPrev.adTransContextNext:=Self;
    if not Assigned(adTransContext.atcDatabasesHead) then
      adTransContext.atcDatabasesHead := Self;
  finally
    adTransContext.atcDatabasesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.adGetExplicitAllowSystem: Boolean;
var
  lValue: string;
begin
  OptionGet('ALLOWSYSTEMTABLEACCESS', lValue);
  Result := lValue = '1';
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.adGetIsCache: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.adRemoveFromSession;
begin
  asoSession.asDatabasesPadlock.Lock;
  try
    if Assigned(adSessionNext) then
      adSessionNext.adSessionPrev := adSessionPrev
    else
      if asoSession.asDatabasesTail = Self then
        asoSession.asDatabasesTail := adSessionPrev;

    if Assigned(adSessionPrev) then
      adSessionPrev.adSessionNext := adSessionNext
    else
      if asoSession.asDatabasesHead = Self then
        asoSession.asDatabasesHead := adSessionNext;

    adSessionNext := nil;
    adSessionPrev := nil;
  finally
    asoSession.asDatabasesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.adRemoveFromTransContext;
begin
  adTransContext.atcDatabasesPadlock.Lock;
  try
    if Assigned(adTransContextNext) then
      adTransContextNext.adTransContextPrev := adTransContextPrev
    else
      if adTransContext.atcDatabasesTail = Self then
        adTransContext.atcDatabasesTail := adTransContextPrev;

    if Assigned(adTransContextPrev) then
      adTransContextPrev.adTransContextNext := adTransContextNext
    else
      if adTransContext.atcDatabasesHead = Self then
        adTransContext.atcDatabasesHead := adTransContextNext;

    adTransContextNext := nil;
    adTransContextPrev := nil;
  finally
    adTransContext.atcDatabasesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.adTransContextDestroying;
begin
  if Assigned(adTransContext) then begin
    adRemoveFromTransContext;
    asoSession.TransContextCreate(adOwnedTransContext, atoTimeout);
    adTransContext := adOwnedTransContext;
    adAddToTransContext;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.AfterConstruction;
begin
  inherited;
  LockedInc(asoGetServerEngine.bseDatabaseCount);
  adLockedIncDone := True;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.atoSetTimeout(aTimeout: TnxWord32);
begin
  inherited;
  if Assigned(adOwnedTransContext) then
    adOwnedTransContext.atoSetTimeout(aTimeout);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if adLockedIncDone then
    LockedDec(asoGetServerEngine.bseDatabaseCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractDatabase.Create(aSession      : TnxAbstractSession;
                                       aTransContext : TnxAbstractTransContext;
                                       aTimeout      : TnxWord32);
begin
  atoLock := aSession.atoLock;

  adCursorsPadlock := TnxPadlock.Create(True);
  adStatementsPadlock := TnxPadlock.Create(True);

  asoSession := aSession;
  adAddToSession;

  if not Assigned(aTransContext) then begin
    asoSession.TransContextCreate(adOwnedTransContext, aTimeout);
    aTransContext := adOwnedTransContext;
  end;

  adTransContext := aTransContext;
  adAddToTransContext;

  inherited Create(aSession, aTimeout);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.CreateInstanceFor(const aName        : string;
                                               const aClassID     : TnxGuid;
                                               const aOuter       : InxInterface;
                                               const aInterfaceID : TnxGuid;
                                                 out aInterface   )
                                                                  : HRESULT;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<Database>') then begin
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  end else if SameText(aName, '<TransContext>') then
    Result := adTransContext.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.CursorCacheOpen(out aCursor        : TnxAbstractCursor;
                                                 aTransContext  : TnxAbstractTransContext;
                                           const aTableName     : string;
                                           const aPassword      : UnicodeString;
                                                 aOpenMode      : TnxOpenMode;
                                                 aShareMode     : TnxShareMode;
                                                 aTimeout       : TnxWord32;
                                                 aIndexName     : string;
                                                 aIndexID       : Integer;
                                                 aAllowSystem   : Boolean = False;
                                                 aOpenOptions   : TnxCursorOpenOptions = [];
                                                 aFilterTimeout : TnxWord32 = nxDefaultFilterTimeout)
                                                                : TnxResult;
begin
  Result := nxpNotSupported('CursorCacheOpen');
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractDatabase.Destroy;

begin
  adRemoveFromTransContext;
  adRemoveFromSession;

  adStatementsPadlock.Lock;
  try
    while Assigned(adStatementsHead) do
      adStatementsHead.Free;
  finally
    adStatementsPadlock.Unlock;
  end;

  adCursorsPadlock.Lock;
  try
    while Assigned(adCursorsHead) do
      adCursorsHead.Free;
  finally
    adCursorsPadlock.Unlock;
  end;

  nxFreeAndNil(adOwnedTransContext);
  nxFreeAndNil(adCursorsPadlock);
  nxFreeAndNil(adStatementsPadlock);

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.esoGetOptionsParent: TnxExtendableServerObject;
begin
  Result := adTransContext;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i           : Integer;
  cu          : TnxAbstractCursor;
  cuContainer : InxExceptionDataContainer;
  st          : TnxAbstractStatement;
  stContainer : InxExceptionDataContainer;
begin
  inherited;
  aContainer.AddValue('TransContext', adTransContext);
  if aIncludeChildren then begin
    cuContainer := aContainer.AddContainer('Cursors');
    adCursorsPadlock.Lock;
    try
      cu := adCursorsHead;
      if Assigned(cu) then begin
        i := 0;
        while Assigned(cu) do begin
          cuContainer.AddValue('[' + IntToStr(i) + ']', cu, True);
          Inc(i);
          cu := cu.acDatabaseNext;
        end;
      end;
    finally
      adCursorsPadlock.Unlock;
    end;

    stContainer := aContainer.AddContainer('Statements');
    adStatementsPadlock.Lock;
    try
      st := adStatementsHead;
      if Assigned(st) then begin
        i := 0;
        while Assigned(st) do begin
          stContainer.AddValue('[' + IntToStr(i) + ']', st, True);
          Inc(i);
          st := st.asDatabaseNext;
        end;
      end;
    finally
      adStatementsPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractDatabase.PrepareDestroy;
var
  Cursor    : TnxAbstractCursor;
  Statement : TnxAbstractStatement;
begin
  inherited;

  if Assigned(adOwnedTransContext) then
    adOwnedTransContext.PrepareDestroy;

  adCursorsPadlock.Lock;
  try
    Cursor := adCursorsHead;
    while Assigned(Cursor) do begin
      Cursor.PrepareDestroy;
      Cursor := Cursor.acDatabaseNext;
    end;
  finally
    adCursorsPadlock.Unlock;
  end;

  adStatementsPadlock.Lock;
  try
    Statement := adStatementsHead;
    while Assigned(Statement) do begin
      Statement.PrepareDestroy;
      Statement := Statement.asDatabaseNext;
    end;
  finally
    adStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.RegisterCursorSource(aSource  : InxDatabaseCursorSource;
                                              out aControl : InxDatabaseCursorSourceControl)
                                                           : TnxResult;
begin
  Result := nxpNotSupported('RegisterCursorSource');
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.SetCacheDatabase(aCacheDatabase : TnxAbstractDatabase)
                                                             : TnxResult;
begin
  Result := nxpNotSupported('SetCacheDatabase');
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TableStreamRead(const aTableName  : string;
                                             const aPassword   : UnicodeString;
                                             const aStreamName : string;
                                                   aStream     : TStream)
                                                               : TnxResult;
var
  Cursor: TnxAbstractCursor;
begin
  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := CursorOpen(Cursor, nil, aTableName, aPassword, omReadOnly, smShared, atoTimeout, '', -1, adGetExplicitAllowSystem);
      if Result = DBIERR_NONE then try
        Result := Cursor.TableStreamRead(aStreamName, aStream);
      finally
        Cursor.Free;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TableStreamWrite(const aTableName  : string;
                                              const aPassword   : UnicodeString;
                                              const aStreamName : string;
                                                    aStream     : TStream)
                                                                : TnxResult;
var
  Cursor: TnxAbstractCursor;
begin
  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := CursorOpen(Cursor, nil, aTableName, aPassword, omReadWrite, smShared, atoTimeout, '', -1, adGetExplicitAllowSystem);
      if Result = DBIERR_NONE then try
        Result := Cursor.TableStreamWrite(aStreamName, aStream);
      finally
        Cursor.Free;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionCommit: TnxResult;
begin
  Result := adTransContext.TransactionCommit;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionCorrupted: TnxResult;
begin
  Result := adTransContext.TransactionCorrupted;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionGetInfo(out aTransInfo   : TnxTransactionInfo;
                                                    aAllowCached : Boolean = True)
                                                                 : TnxResult;
begin
  Result := adTransContext.TransactionGetInfo(aTransInfo, aAllowCached);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionGetLevel(out aTransLevel : Integer)
                                                                 : TnxResult;
begin
  Result := adTransContext.TransactionGetLevel(aTransLevel);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionInclude(aExclusive : Boolean;
                                          const aCursors   : array of TnxAbstractCursor)
                                                           : TnxResult;
begin
  Result := adTransContext.TransactionInclude(aExclusive, aCursors);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionRollback: TnxResult;
begin
  Result := adTransContext.TransactionRollback;
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionStart(aFailSafe : Boolean;
                                              aSnapShot : Boolean)
                                                        : TnxResult;
begin
  Result := adTransContext.TransactionStart(aFailSafe, aSnapShot);
end;
{------------------------------------------------------------------------------}
function TnxAbstractDatabase.TransactionStartWith(aFailSafe : Boolean;
                                                  aSnapShot : Boolean;
                                            const aCursors  : array of TnxAbstractCursor)
                                                            : TnxResult;
begin
  Result := adTransContext.TransactionStartWith(aFailSafe, aSnapShot, aCursors);
end;
{==============================================================================}



{===TnxAbstractTransContext====================================================}
procedure TnxAbstractTransContext.AfterConstruction;
begin
  inherited;
  LockedInc(asoGetServerEngine.bseTransContextCount);
  atcLockedIncDone := True;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.atcAddToSession;
begin
  asoSession.asTransContextsPadlock.Lock;
  try
    atcSessionPrev := asoSession.asTransContextsTail;
    asoSession.asTransContextsTail := Self;
    if Assigned(atcSessionPrev) then
      atcSessionPrev.atcSessionNext:=Self;
    if not Assigned(asoSession.asTransContextsHead) then
      asoSession.asTransContextsHead := Self;
  finally
    asoSession.asTransContextsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.atcForceRollback;
begin
  {can be overridden...}
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.atcRemoveFromSession;
begin
  asoSession.asTransContextsPadlock.Lock;
  try
    if Assigned(atcSessionNext) then
      atcSessionNext.atcSessionPrev := atcSessionPrev
    else
      if asoSession.asTransContextsTail = Self then
        asoSession.asTransContextsTail := atcSessionPrev;

    if Assigned(atcSessionPrev) then
      atcSessionPrev.atcSessionNext := atcSessionNext
    else
      if asoSession.asTransContextsHead = Self then
        asoSession.asTransContextsHead := atcSessionNext;

    atcSessionNext := nil;
    atcSessionPrev := nil;
  finally
    asoSession.asTransContextsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if atcLockedIncDone then
    LockedDec(asoGetServerEngine.bseTransContextCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractTransContext.Create(aSession : TnxAbstractSession;
                                           aTimeout : TnxWord32);
begin
  atoLock := aSession.atoLock;

  atcDatabasesPadlock := TnxPadlock.Create(True);
  atcCursorsPadlock := TnxPadlock.Create(True);

  asoSession := aSession;
  atcAddToSession;
  inherited Create(aSession, aTimeout);
end;
{------------------------------------------------------------------------------}
function TnxAbstractTransContext.CreateInstanceFor(const aName        : string;
                                                   const aClassID     : TnxGuid;
                                                   const aOuter       : InxInterface;
                                                   const aInterfaceID : TnxGuid;
                                                     out aInterface   )
                                                                      : HRESULT;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<TransContext>') then
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractTransContext.Destroy;
begin
  atcForceRollback;

  atcRemoveFromSession;

  if Assigned(atcDatabasesPadlock) then begin
  atcDatabasesPadlock.Lock;
  try
    while Assigned(atcDatabasesHead) do
      atcDatabasesHead.adTransContextDestroying;
  finally
    atcDatabasesPadlock.Unlock;
  end;

  nxFreeAndNil(atcDatabasesPadlock);
  end;
  if Assigned(atcCursorsPadlock) then begin
    atcCursorsPadlock.Lock;
    try
      while Assigned(atcCursorsHead) do
        atcCursorsHead.acTransContextDestroying;
    finally
      atcCursorsPadlock.Unlock;
    end;
    nxFreeAndNil(atcCursorsPadlock);
  end;

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.Failed;
begin
  atcFailed := True;
  atcForceRollback;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i           : Integer;
  db          : TnxAbstractDatabase;
  dbContainer : InxExceptionDataContainer;
begin
  inherited;
  aContainer.AddValue('Session', Session);
  atcDatabasesPadlock.Lock;
  try
    aContainer.AddValue('AttachedDatabases', DoubleLinkedListCountStrings[Assigned(atcDatabasesHead), atcDatabasesHead = atcDatabasesTail]);
    if aIncludeChildren then begin
      db := atcDatabasesHead;
      dbContainer := aContainer.AddContainer('Databases');
      if Assigned(db) then begin
        i := 0;
        while Assigned(db) do begin
          dbContainer.AddValue('[' + IntToStr(i) + ']', db, True);
          Inc(i);
          db := db.adTransContextNext;
        end;
      end;
    end;
  finally
    atcDatabasesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractTransContext.PrepareDestroy;
begin
  inherited;
  Failed;
end;
{------------------------------------------------------------------------------}
function TnxAbstractTransContext.SetCacheTransContext(aCacheTransContext : TnxBaseTransContext;
                                                      aAutoFree          : Boolean)
                                                                         : TnxResult;
begin
  Result := nxpNotSupported('SetCacheTransContext');
end;
{==============================================================================}



{===TnxAbstractCursor==========================================================}
procedure TnxAbstractCursor.acAddToDatabase;
begin
  acDatabase.adCursorsPadlock.Lock;
  try
    acDatabasePrev := acDatabase.adCursorsTail;
    acDatabase.adCursorsTail := Self;
    if Assigned(acDatabasePrev) then
      acDatabasePrev.acDatabaseNext:=Self;
    if not Assigned(acDatabase.adCursorsHead) then
      acDatabase.adCursorsHead := Self;
  finally
    acDatabase.adCursorsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.acAddToTransContext;
begin
  if not Assigned(acTransContext) then
    Exit;

  acTransContext.atcCursorsPadlock.Lock;
  try
    acTransContextPrev := acTransContext.atcCursorsTail;
    acTransContext.atcCursorsTail := Self;
    if Assigned(acTransContextPrev) then
      acTransContextPrev.acTransContextNext:=Self;
    if not Assigned(acTransContext.atcCursorsHead) then
      acTransContext.atcCursorsHead := Self;
  finally
    acTransContext.atcCursorsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acCancelServerFilter: Boolean;
begin
  Result := Assigned(acOnCancelServerFilter) and acOnCancelServerFilter();
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetAliasName: string;
begin
  Result := '';
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetCurrentTransContext: TnxBaseTransContext;
begin
  Result := acTransContext;
  if not Assigned(Result) and Assigned(acDatabase) then begin
    Result := acDatabase.TransContext;
    if not Assigned(Result) then
      Result := acDatabase;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetDCI: PnxDiffCompressorInfo;
begin
  acFieldsDescriptor.GetDiffCompressionInfo(acDCI);
  Result := acDCI;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetFieldsDescriptor: TnxFieldsDescriptor;
begin
  Result := TableDescriptor.FieldsDescriptor;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetIsCache: Boolean;
begin
  Result := acsIsCache in acStates;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acGetRecID(aBuffer: PnxRecordBuffer): TnxRecID;
begin
  if Assigned(aBuffer) then with acSFI^ do begin
    if sfiOffsets[sftRefNr] >= 0 then
      Result.ridRefNr := PnxRefNr(@aBuffer[sfiOffsets[sftRefNr]])^
    else
      Result.ridRefNr := 0;

    if sfiOffsets[sftInsertLSN] >= 0 then
      Result.ridInsertLSN := PnxLSN(@aBuffer[sfiOffsets[sftInsertLSN]])^
    else
      Result.ridInsertLSN := 0;
  end else
    Result := ridNull;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.acRemoveFromDatabase;
begin
  if assigned(acDatabase) then begin
    acDatabase.adCursorsPadlock.Lock;
    try
      if Assigned(acDatabaseNext) then
        acDatabaseNext.acDatabasePrev := acDatabasePrev
      else
        if acDatabase.adCursorsTail = Self then
          acDatabase.adCursorsTail := acDatabasePrev;

      if Assigned(acDatabasePrev) then
        acDatabasePrev.acDatabaseNext := acDatabaseNext
      else
        if acDatabase.adCursorsHead = Self then
          acDatabase.adCursorsHead := acDatabaseNext;

      acDatabaseNext := nil;
      acDatabasePrev := nil;

      if not Assigned(acDatabase.adCursorsHead) and not acDatabase.asoDestroying and acDatabase.adCursorAutoFree then
        Include(acStates, acsAutoFreeDatabase);
    finally
      acDatabase.adCursorsPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.acRemoveFromTransContext;
begin
  if not Assigned(acTransContext) then
    Exit;

  acTransContext.atcCursorsPadlock.Lock;
  try
    if Assigned(acTransContextNext) then
      acTransContextNext.acTransContextPrev := acTransContextPrev
    else
      if acTransContext.atcCursorsTail = Self then
        acTransContext.atcCursorsTail := acTransContextPrev;
    if Assigned(acTransContextPrev) then
      acTransContextPrev.acTransContextNext := acTransContextNext
    else
      if acTransContext.atcCursorsHead = Self then
        acTransContext.atcCursorsHead := acTransContextNext;
    acTransContextNext := nil;
    acTransContextPrev := nil;
  finally
    acTransContext.atcCursorsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.acSetupDescriptorDependentFields;
begin
  acFieldsDescriptor := TableDescriptor.FieldsDescriptor;
  with acFieldsDescriptor do begin
    acRecordLength := RecordLength;
    GetSpecialFieldsInfo(acSFI);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acSnapshotRequiredForBlobRead(const aRecID   : TnxRecID;
                                                               aFieldNo : TnxInt32;
                                                               aBlobNr  : TnxBlobNr;
                                                               aReadOrg : Boolean)
                                                                        : Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acTransactionRollbackForBlobReadSnapshoted: TnxResult;
begin
  Result := Database.TransactionRollback;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.acTransactionStartForBlobReadSnapshoted: TnxResult;
begin
  Result := Database.TransactionStart(False, True);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.acTransContextDestroying;
begin
  if Assigned(acTransContext) then begin
    acRemoveFromTransContext;
    acTransContext := nil;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.AddCursorOption(aOption: TnxAbstractCursorOption): Boolean;
begin
  Result := not (aOption in acOptions);
  if Result then
    Include(acOptions, aOption);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.AddCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
begin
  Result := (aOptions * acOptions) <> aOptions;
  if Result then
    acOptions := acOptions + aOptions;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.AfterConstruction;
begin
  inherited;
  LockedInc(asoGetServerEngine.bseCursorCount);
  Include(acStates, acsLockedIncDone);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.BeforeDestruction;
begin
  asoDestroying := True;
  if acsLockedIncDone in acStates then
    LockedDec(asoGetServerEngine.bseCursorCount);
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobAddToCache(const aRecID   : TnxRecID;
                                                aFieldNo : TnxInt32;
                                          const aBlobNr  : TnxBlobNr;
                                                aLen     : TnxWord32;
                                          const aBlob    )
                                                         : TnxResult;
begin
  Result := nxpNotSupported('BlobAddToCache');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobBatchApply(aData    : PnxRecordBuffer;
                                    const aRequest : TnxBlobBatchRequest;
                                    const aReply   : TnxBlobBatchReply)
                                                   : TnxResult;
var
  lEntryIdx : Integer;
  AnyError  : TnxResult;
begin
  AnyError := DBIERR_NONE;
  Result := DBIERR_NONE;
  with acFieldsDescriptor, aRequest, aReply do
    for lEntryIdx := 0 to Pred(bbrpCount) do begin
      Result := BlobBatchEntryApply(aData, bbrqRecID,
        bbrqEntries[lEntryIdx], bbrpEntries[lEntryIdx]);
      if Result <> DBIERR_NONE then
        AnyError := Result;
    end;
  if (Result = DBIERR_NONE) and
     (AnyError <> DBIERR_NONE)
  then
    Result := AnyError;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobBatchEntryApply(aData    : PnxRecordBuffer;
                                         const aRecID   : TnxRecID;
                                         const aRequest : TnxBlobBatchRequestEntry;
                                         const aReply   : TnxBlobBatchReplyEntry)
                                                        : TnxResult;
begin
  Result := DBIERR_NONE;
  if Assigned(aData) then with acFieldsDescriptor, aRequest, aReply do
    if bbrpeBlobNr = 0 then
      SetRecordField(bbrqeFieldNo, aData, nil)
    else
      SetRecordField(bbrqeFieldNo, aData, @bbrpeBlobNr);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                              var aReply   : TnxBlobBatchReply)
                                                           : TnxResult;
begin
  Result := nxpNotSupported('BlobBatchProcess');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobGetLength(const aRecID     : TnxRecID;
                                               aFieldNo   : TnxInt32;
                                         const aBlobNr    : TnxBlobNr;
                                           out aLength    : TnxWord32;
                                               aReadOrg   : Boolean;
                                               aNewBlobNr : PnxNewBlobNr)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcBlobGetLength(aRecID, aFieldNo, aBlobNr, aLength, aReadOrg, aNewBlobNr);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobRead(const aRecID     : TnxRecID;
                                          aFieldNo   : TnxInt32;
                                    const aBlobNr    : TnxBlobNr;
                                          aOffset    : TnxWord32;
                                          aLen       : TnxWord32;
                                          aStream    : TStream;
                                          aReadOrg   : Boolean;
                                          aNewBlobNr : PnxNewBlobNr)
                                                     : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcBlobRead(aRecID, aFieldNo, aBlobNr, aOffset, aLen, aStream, aReadOrg, aNewBlobNr);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobReadSnapshoted(const aRecID     : TnxRecID;
                                                    aFieldNo   : TnxInt32;
                                              const aBlobNr    : TnxBlobNr;
                                                    aOffset    : TnxWord32;
                                                    aLen       : TnxWord32;
                                                    aStream    : TStream;
                                                    aReadOrg   : Boolean;
                                                var aSnapshot  : TnxBlobReadSnapshotState;
                                                    aBlobLen   : PnxWord32;
                                                    aNewBlobNr : PnxNewBlobNr)
                                                               : TnxResult;
var
  Error         : TnxResult;
  OrgSnapshot   : TnxBlobReadSnapshotState;
  StartPosition : Int64;
  lBlobLen      : TnxWord32;
  BytesRead     : TnxWord32;
begin
  if aSnapshot in [brssFailedToStart, brssFailedToClose, brssClosed] then begin
    Result := DBIERR_INVALIDPARAM;
    Exit;
  end;

  Result := DBIERR_NONE;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      OrgSnapshot := aSnapshot;
      if aSnapshot = brssRequestStart then begin
        if not acSnapshotRequiredForBlobRead(aRecID, aFieldNo, aBlobNr, aReadOrg) then
          aSnapshot := brssUnneccesary;
        if aSnapshot = brssRequestStart then begin
          Result := acTransactionStartForBlobReadSnapshoted;
          if Result <> DBIERR_NONE then begin
            aSnapshot := brssFailedToStart;
            Exit;
          end;
          aSnapshot := brssStarted;
        end;
      end;

      StartPosition := aStream.Position;

      if not Assigned(aBlobLen) then begin
        lBlobLen := 0;
        aBlobLen := @lBlobLen;
      end;

      Result := sbcBlobReadSnapshoted(aRecID, aFieldNo, aBlobNr, aOffset, aLen,
        aStream, aReadOrg, aBlobLen, aNewBlobNr);

      BytesRead := aStream.Position - StartPosition;

      if (aSnapshot = brssRequestClose) or
         (
           (aSnapshot = brssStarted) and
           (
             (BytesRead < aLen) or
             (aOffset + BytesRead = aBlobLen^)
           )
         )
      then begin
        Error := acTransactionRollbackForBlobReadSnapshoted;
        if Error <> DBIERR_NONE then begin
          Result := Error;
          aSnapshot := brssFailedToClose;
          Exit;
        end;
        if OrgSnapshot = brssRequestStart then
          aSnapshot := brssUnneccesary
        else
          aSnapshot := brssClosed;
      end;

    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobReplace(const aRecID   : TnxRecID;
                                             aFieldNo : TnxInt32;
                                         var aBlobNr  : TnxBlobNr;
                                             aLen     : TnxWord32;
                                       const aBlob    )
                                                      : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  nxLockTimeout;
  try
    try
      Result := DBIERR_NONE;
      if aLen = 0 then begin
        if aBlobNr <> 0 then
          Result := BlobTruncate(aRecID, aFieldNo, aBlobNr, 0);
      end else begin
        if aBlobNr = 0 then
          Result := BlobCreate(aRecID, aFieldNo, aBlobNr)
        else
          Result := BlobTruncate(aRecID, aFieldNo, aBlobNr, 0);
        if Result = DBIERR_NONE then
          Result := BlobWrite(aRecID, aFieldNo, aBlobNr, 0, aLen, aBlob);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    nxUnlockTimeout;
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobsSetMarked(const aMarkedBlobs : TnxMarkedBlobsByBlobIdx)
                                                             : TnxResult;
var
  lExpectedLength : Integer;
  lIndex          : Integer;
begin
  lExpectedLength := Length(acSFI.sfiBlobFields);
  if lExpectedLength > 0 then
    lExpectedLength := Succ(Pred(lExpectedLength) div 32);
  if not Assigned(aMarkedBlobs) or
     (Length(aMarkedBlobs) >= lExpectedLength)
  then begin
    acMarkedBlobs := aMarkedBlobs;
    Result := DBIERR_NONE;
    for lIndex := Low(acMarkedBlobs) to High(acMarkedBlobs) do
      if acMarkedBlobs[lIndex] <> 0 then
        Exit;
    acMarkedBlobs := nil;
  end else
    Result := DBIERR_INVALIDPARAM;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BlobsSupportedSelf: Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                              aSize     : TnxWord32)
                                                        : TnxResult;
begin
  Result := nxpNotSupported('BookmarkCheckLocal');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BookmarkClear(aBookmark : PnxBookmarkBuffer;
                                              aSize     : TnxWord32)
                                                        : TnxResult;
begin
  Result := nxpNotSupported('BookmarkClear');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.BuildKey(aRecord       : PnxRecordBuffer;
                                    aKey          : PnxKeyBuffer;
                                    aIgnoreFilter : Boolean)
                                                  : TnxResult;
begin
  Result := nxpNotSupported('BuildKey');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.ClientOnlyCacheBegin: TnxResult;
begin
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.ClientOnlyCacheEnd: TnxResult;
begin
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.ContainsCacheInfo(const aCacheInfo : TnxRecordCacheInfo)
                                                              : TnxResult;
begin
  if rciIsEmpty(aCacheInfo) then
    Result := DBIERR_NOCURRREC
  else with PnxRecordCacheInfo(@aCacheInfo)^ do
    Result := ContainsLSNRefNr(rciModifyLSN, rciRefNr);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.ContainsLSNRefNr(var aLSN   : TnxLSN;
                                            var aRefNr : TnxRefNr)
                                                       : TnxResult;
begin
  if (aLSN = 0) and (aRefNr = 0) then
    Result := DBIERR_NOCURRREC
  else
    Result := nxpNotSupported('ContainsLSNRefNr');
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractCursor.Create(aDatabase : TnxAbstractDatabase;
                                     aTransContext : TnxAbstractTransContext;
                                     aTimeout  : TnxWord32);
begin
  atoLock := aDatabase.atoLock;

  acDatabase := aDatabase;
  acTransContext := aTransContext;
  acAddToDatabase;
  acAddToTransContext;
  inherited Create(aDatabase, aTimeout);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.CreateBatchStreamAccess(aStream  : TnxMemoryStream;
                                                   aOptions : TnxRecordGetBatchExOptions)
                                                            : TnxBatchStreamAccess;
begin
  Result := BatchStreamAccessClass.Create(Self, aStream, aOptions);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.CreateInstanceFor(const aName        : string;
                                             const aClassID     : TnxGuid;
                                             const aOuter       : InxInterface;
                                             const aInterfaceID : TnxGuid;
                                               out aInterface   )
                                                                : HRESULT;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<Cursor>') then
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else if SameText(Left, '<Database>') then
    Result := acDatabase.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractCursor.Destroy;
begin
  acTransContextDestroying;
  acRemoveFromDatabase;
  inherited Destroy;
  if (acsAutoFreeDatabase in acStates) and
     Assigned(acDatabase) and
     not acDatabase.asoDestroying
  then
    acDatabase.Free;

  ciFree(acCacheableInfo);
  sfiFree(acSFI);
  dciFree(acDCI);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.ExtractCacheInfo(aData      : PnxRecordBuffer;
                                        out aCacheInfo : TnxRecordCacheInfo)
                                                       : TnxResult;
begin
  if acsIsCacheable in acStates then begin
    Result := DBIERR_NOCURRREC;
    if Assigned(aData) then with FieldsDescriptor, aCacheInfo, acCacheableInfo^, ciSFI^ do begin
      rciModifyLSN := PnxLSN(@aData[sfiOffsets[sftModifyLSN]])^;
      if rciModifyLSN <> 0 then begin
        rciRefNr := PnxRefNr(@aData[sfiOffsets[sftRefNr]])^;
        if rciRefNr <> 0 then
          Result := DBIERR_NONE;
      end;
    end;
  end else begin
    rciClear(aCacheInfo);
    Result := DBIERR_NOTSUPPORTED;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.FilterAddCallback(aCookie   : Pointer;
                                             aCallback : TnxFilterCallback;
                                         out aFilterID : TnxFilterID;
                                             aActivated: Boolean)
                                                       : TnxResult;
var
  Filter: TnxBaseFilterDescriptor;
begin
  Filter := TnxCallbackFilterDescriptor.Create(aCookie, aCallback);
  try
    Result := FilterAddCustom(Filter, aFilterID, aActivated);
  finally
    nxFreeAndNil(Filter);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.FilterAddExpression(aExpression : pCANExpr;
                                           out aFilterID   : TnxFilterID;
                                               aActivated  : Boolean)
                                                           : TnxResult;
var
  Filter: TnxBaseFilterDescriptor;
begin
  Filter := TnxSimpleExpressionFilterDescriptor.Create(aExpression, nxGetThreadCodePage);
  try
    Result := FilterAddCustom(Filter, aFilterID, aActivated);
  finally
    nxFreeAndNil(Filter);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.FilterBeginTimeout;
begin
  { can be overriden }
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.FilterMatchesBuffer(aBuffer: PnxRecordBuffer): Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetBlobs(aData       : PnxRecordBuffer;
                                    aMarkedOnly : Boolean;
                                var aBlobNrs    : TnxBlobNrs)
                                                : TnxResult;
var
  lBlobCount: TnxWord16;
begin
  aBlobNrs := nil;
  if aMarkedOnly and not Assigned(acMarkedBlobs) then
    Result := DBIERR_NONE
  else begin
    lBlobCount := Length(acSFI.sfiBlobFields);
    if lBlobCount = 0 then
      Result := DBIERR_NONE
    else begin
      SetLength(aBlobNrs, lBlobCount);
      Result := GetBlobs(aData, aMarkedOnly, lBlobCount, @aBlobNrs[0]);
      if Result <> DBIERR_NONE then
        aBlobNrs := nil
      else
        SetLength(aBlobNrs, lBlobCount);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetBlobs(aData       : PnxRecordBuffer;
                                    aMarkedOnly : Boolean;
                                var aBlobCount  : TnxWord16;
                                    aBlobNrs    : PnxBlobNr)
                                                : TnxResult;
var
  lMaxBlobCount : TnxWord16;
  lBlobCount    : TnxWord16;
  lBlobIdx      : Integer;
  lBlobFldIdx   : Integer;
  lBlobNr       : PnxBlobNr;
begin
  lMaxBlobCount := aBlobCount;
  aBlobCount := 0;
  Result := DBIERR_NONE;
  if aMarkedOnly and not Assigned(acMarkedBlobs) then
    {nothing to do}
  else begin
    lBlobCount := Length(acSFI.sfiBlobFields);
    if lBlobCount = 0 then
      {nothing to do}
    else
      if not Assigned(aData) then
        Result := DBIERR_INVALIDPARAM
      else with FieldsDescriptor, acSFI^ do
        for lBlobIdx := Low(sfiBlobFields) to High(sfiBlobFields) do
          if not aMarkedOnly or
             nxIsBitSet(Pointer(acMarkedBlobs), lBlobIdx)
          then begin
            lBlobFldIdx := sfiBlobFields[lBlobIdx];
            lBlobNr := GetRecordFieldForFilter(lBlobFldIdx, aData);
            if Assigned(lBlobNr) and (lBlobNr^ <> 0) then
              if (aBlobCount = lMaxBlobCount) or not Assigned(aBlobNrs) then begin
                Result := DBIERR_OUTOFRANGE;
                Exit;
              end else begin
                aBlobNrs^ := lBlobNr^;
                Inc(aBlobNrs);
                Inc(aBlobCount);
              end;
          end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                            aSize     : TnxWord32)
                                                      : TnxResult;
begin
  Result := nxpNotSupported('GetBookmarkCache');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetCursorSelf: TObject;
begin
  Result := Self;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetDeletedRecords(aFromLSN    : TnxLSN;
                                         out aCacheInfos : TnxRecordCacheInfos;
                                             aMaxCount   : Integer = High(Integer);
                                             aCurrentLSN : PnxLSN = nil)
                                                         : TnxResult;
begin
  aCacheInfos := nil;
  if Assigned(aCurrentLSN) then
    aCurrentLSN^ := 0;
  Result := nxpNotSupported('GetDeletedRecords');
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Database', acDatabase);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldAsVariantSelf(aBuffer : PnxRecordBuffer;
                                                 aField  : Integer)
                                                         : OleVariant;
var
  BlobNr : PnxBlobNr;
  RecID  : TnxRecID;
  Error  : TnxResult;
  Len    : TnxWord32;
  VPtr   : PByte;
  ws     : WideString;
  Stream : TnxAnsiStringStream;
begin
  nxLockTimeout;
  try
    ws := '';
    with FieldsDescriptor, FieldDescriptor[aField] do begin
      if fdType in [nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo] then begin
        BlobNr := GetRecordFieldForFilter(aField, aBuffer);
        if Assigned(BlobNr) then begin
          RecID := acGetRecID(aBuffer);
          Error := BlobGetLength(RecID, aField, BlobNr^, Len, False, nil);
          if Error = DBIERR_NONE then
            if Len = 0 then
              Result := Null
            else begin
              if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
                if fdType = nxtBlobWideMemo then begin
                  SetLength(ws, Len div 2);
                  with TnxStaticMemoryStream.Create(@ws[1], Len) do try
                    Error := BlobRead(RecID, aField, BlobNr^, 0, Len, TheStream, False, nil);
                  finally
                    Free;
                  end;
                end else begin
                  Stream := TnxAnsiStringStream.Create(StringOfChar(AnsiChar(#0), Len));
                  try
                    Stream.Position := 0;
                    Error := BlobRead(RecID, aField, BlobNr^, 0, Len, Stream, False, nil);
                    if Error = DBIERR_NONE then
                      ws := nxStringToDelphiWideString(Stream.DataString, UsedStorageCodePage);
                  finally
                    Stream.Free;
                  end;
                end;
                Result := ws;
              end else begin
                Result := VarArrayCreate([0, Pred(Len)], VarByte);
                VPtr := VarArrayLock(Result);
                try
                  with TnxStaticMemoryStream.Create(VPtr, Len) do try
                    Error := BlobRead(RecID, aField, BlobNr^, 0, Len, TheStream, False, nil);
                  finally
                    Free;
                  end;
                finally
                  VarArrayUnlock(Result);
                end;
              end;
            end;
          nxCheck(Error);
        end else
          Result := Null;
      end else
        Result := BufferAsVariant[GetRecordFieldForFilter(aField, aBuffer)];
    end;
  finally
    nxUnlockTimeout;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldCountRedirect: Integer;
begin
  Result := FieldsDescriptor.FieldCount;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldDescriptorRedirect(aIndex : Integer)
                                                             : InxFieldDescriptor;
begin
  Result := FieldsDescriptor.FieldDescriptor[aIndex];
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldForFilterRedirect(aField    : Integer;
                                                     aName     : PAnsiChar;
                                                     aData     : PnxRecordBuffer;
                                                 out aType     : TnxWord16;
                                                 out aSize     : TnxWord16;
                                                 out aIsNull   : Boolean;
                                                 out aValue    : PnxFieldBuffer;
                                                 out aCodePage : TnxWord16)
                                                               : Boolean;
begin
  Result := FieldsDescriptor.GetFieldForFilter(aField, aName, aData, aType,
    aSize, aIsNull, aValue, aCodePage);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldFromNameRedirect(const aFieldName : string)
                                                                     : Integer;
begin
  Result := FieldsDescriptor.GetFieldFromName(aFieldName);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetFieldsOffsetRedirect: integer;
begin
  Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.GetNextLSN(var aLSN: TnxLSN): Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.HasActiveLocalFilter: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.HasAllCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
begin
  Result := (aOptions * acOptions) = aOptions;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.HasAnyCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
begin
  Result := (aOptions * acOptions) <> [];
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.KeyFilterAddCallback(aCookie      : Pointer;
                                                aCallback    : TnxFilterCallback;
                                            out aKeyFilterID : TnxKeyFilterID;
                                                aActivated   : Boolean)
                                                             : TnxResult;
var
  Filter: TnxBaseFilterDescriptor;
begin
  Filter := TnxCallbackFilterDescriptor.Create(aCookie, aCallback);
  try
    Result := KeyFilterAddCustom(Filter, aKeyFilterID, aActivated);
  finally
    nxFreeAndNil(Filter);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.KeyFilterAddExpression(aExpression  : pCANExpr;
                                              out aKeyFilterID : TnxKeyFilterID;
                                                  aActivated   : Boolean)
                                                               : TnxResult;
var
  Filter: TnxBaseFilterDescriptor;
begin
  Filter := TnxSimpleExpressionFilterDescriptor.Create(aExpression, nxGetThreadCodePage);
  try
    Result := KeyFilterAddCustom(Filter, aKeyFilterID, aActivated);
  finally
    nxFreeAndNil(Filter);
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.KeyToRecord(aKey    : PnxKeyBuffer;
                                       aRecord : PnxRecordBuffer)
                                               : TnxResult;
begin
  Result := nxpNotSupported('KeyToRecord');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RangeSet(aFieldCount1 : Integer;
                                    aPartialLen1 : Integer;
                                    aKeyData1    : PnxKeyBuffer;
                                    aKeyIncl1    : Boolean;
                                    aFieldCount2 : Integer;
                                    aPartialLen2 : Integer;
                                    aKeyData2    : PnxKeyBuffer;
                                    aKeyIncl2    : Boolean)
                                                 : TnxResult;
begin
  Result := RangeSet(aFieldCount1, aPartialLen1, True, Pointer(aKeyData1), aKeyIncl1,
                     aFieldCount2, aPartialLen2, True, Pointer(aKeyData2), aKeyIncl2)
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RangeSet(aFieldCount1 : Integer;
                                    aPartialLen1 : Integer;
                                    aKeyData1    : PnxRecordBuffer;
                                    aKeyIncl1    : Boolean;
                                    aFieldCount2 : Integer;
                                    aPartialLen2 : Integer;
                                    aKeyData2    : PnxRecordBuffer;
                                    aKeyIncl2    : Boolean)
                                                 : TnxResult;
begin
  Result := RangeSet(aFieldCount1, aPartialLen1, False, Pointer(aKeyData1), aKeyIncl1,
                     aFieldCount2, aPartialLen2, False, Pointer(aKeyData2), aKeyIncl2)
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RangeSet(aFieldCount1 : Integer;
                                    aPartialLen1 : Integer;
                                    aKeyData1    : PnxRecordBuffer;
                                    aKeyIncl1    : Boolean;
                                    aFieldCount2 : Integer;
                                    aPartialLen2 : Integer;
                                    aKeyData2    : PnxKeyBuffer;
                                    aKeyIncl2    : Boolean)
                                                 : TnxResult;
begin
  Result := RangeSet(aFieldCount1, aPartialLen1, False, Pointer(aKeyData1), aKeyIncl1,
                     aFieldCount2, aPartialLen2,  True, Pointer(aKeyData2), aKeyIncl2)
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RangeSet(aFieldCount1 : Integer;
                                    aPartialLen1 : Integer;
                                    aKeyData1    : PnxKeyBuffer;
                                    aKeyIncl1    : Boolean;
                                    aFieldCount2 : Integer;
                                    aPartialLen2 : Integer;
                                    aKeyData2    : PnxRecordBuffer;
                                    aKeyIncl2    : Boolean)
                                                 : TnxResult;
begin
  Result := RangeSet(aFieldCount1, aPartialLen1,  True, Pointer(aKeyData1), aKeyIncl1,
                     aFieldCount2, aPartialLen2, False, Pointer(aKeyData2), aKeyIncl2)
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RecordBufferAlloc: PnxRecordBuffer;
begin
  Result := nxGetMem(TableDescriptor.FieldsDescriptor.RecordLength + SizeOf(Pointer));
  RecordBufferClear(Result);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.RecordBufferClear(aBuffer: PnxRecordBuffer);
begin
  if Assigned(aBuffer) then
    TableDescriptor.FieldsDescriptor.InitRecord(aBuffer);
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.RecordBufferFree(aBuffer: PnxRecordBuffer);
begin
  nxFreeMemDirect(aBuffer);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RecordGetForKey(aFieldCount : Integer;
                                           aPartialLen : Integer;
                                           aKeyData    : PnxKeyBuffer;
                                           aData       : PnxRecordBuffer;
                                           aMatchFirst : Boolean;
                                           aFirstCall  : Boolean)
                                                       : TnxResult;
begin
  Result := RecordGetForKey(aFieldCount, aPartialLen, True,
    PnxKeyOrRecordBuffer(aKeyData), aData, aMatchFirst, aFirstCall);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RecordGetForKey(aFieldCount : Integer;
                                           aPartialLen : Integer;
                                           aKeyData    : PnxRecordBuffer;
                                           aData       : PnxRecordBuffer;
                                           aMatchFirst : Boolean;
                                           aFirstCall  : Boolean)
                                                       : TnxResult;
begin
  Result := RecordGetForKey(aFieldCount, aPartialLen, False,
    PnxKeyOrRecordBuffer(aKeyData), aData, aMatchFirst, aFirstCall);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RemoveCursorOption(aOption: TnxAbstractCursorOption): Boolean;
begin
  Result := aOption in acOptions;
  if Result then
    Exclude(acOptions, aOption);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RemoveCursorOptions(aOptions: TnxAbstractCursorOptions): Boolean;
begin
  Result := (aOptions * acOptions) <> [];
  if Result then
    acOptions := acOptions - aOptions;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.RequestNestedTransactions;
begin
  raise asoGetServerEngine.bseGetExceptionClass.nxCreate(DBIERR_NOTSUPPORTED, @rsRequestNestedTransactionsNotSupported, [ClassName]);
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.RestorePath: TnxResult;
begin
  Result := nxpNotSupported('RestorePath');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.SavePath: TnxResult;
begin
  Result := nxpNotSupported('SavePath');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.sbcBlobReadSnapshoted(const aRecID     : TnxRecID;
                                                       aFieldNo   : TnxInt32;
                                                 const aBlobNr    : TnxBlobNr;
                                                       aOffset    : TnxWord32;
                                                       aLen       : TnxWord32;
                                                       aStream    : TStream;
                                                       aReadOrg   : Boolean;
                                                       aBlobLen   : PnxWord32;
                                                       aNewBlobNr : PnxNewBlobNr)
                                                                  : TnxResult;
var
  lBlobNr : TnxBlobNr;
begin
  lBlobNr := aBlobNr;
  Result := DBIERR_NONE;
  if Assigned(aBlobLen) then repeat
    if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
      nbnBlobNr := lBlobNr;
      nbnSet := False;
    end;
    Result := sbcBlobGetLength(aRecID, aFieldNo, lBlobNr, aBlobLen^, aReadOrg, aNewBlobNr);
    if (Result = DBIERR_BLOBMODIFIED) and
       Assigned(aNewBlobNr) and
       aNewBlobNr.nbnSet and
       (aNewBlobNr.nbnBlobNr <> lBlobNr)
    then begin
      lBlobNr := aNewBlobNr.nbnBlobNr;
      Continue;
    end;
    if Assigned(aNewBlobNr) then with aNewBlobNr^ do
      if nbnSet then
        lBlobNr := nbnBlobNr;
    Break;
  until False;

  if Result = DBIERR_NONE then repeat
    if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
      nbnBlobNr := lBlobNr;
      nbnSet := False;
    end;
    Result := sbcBlobRead(aRecID, aFieldNo, aBlobNr, aOffset, aLen, aStream, aReadOrg, aNewBlobNr);
    if (Result = DBIERR_BLOBMODIFIED) and
       Assigned(aNewBlobNr) and
       aNewBlobNr.nbnSet and
       (aNewBlobNr.nbnBlobNr <> lBlobNr)
    then begin
      lBlobNr := aNewBlobNr.nbnBlobNr;
      Continue;
    end;
    if Assigned(aNewBlobNr) then with aNewBlobNr^ do
      if nbnSet then
        lBlobNr := nbnBlobNr;
    Break;
  until False;

  if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
    nbnBlobNr := lBlobNr;
    nbnSet := lBlobNr <> aBlobNr;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractCursor.SetFieldAsVariantSelf(aBuffer : PnxRecordBuffer;
                                                  aField  : Integer;
                                            const aValue  : OleVariant);
var
  BlobNr : PnxBlobNr;
  RecID  : TnxRecID;

  Len    : TnxWord32;
  VPtr   : PByte;

  ws     : WideString;
  Bytes  : TnxBytes;
begin
  Bytes := nil;
  ws := '';
  with FieldsDescriptor, FieldDescriptor[aField] do begin
    if fdType in [nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo] then begin
      BlobNr := GetRecordFieldForFilter(aField, aBuffer);

      VPtr := nil;
      Len := 0;
      if not nxVarIsEmpty(aValue) then begin
        if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
          ws := aValue;
          if Length(ws) > 0 then begin
            if fdType = nxtBlobWideMemo then begin
              VPtr := @ws[1];
              Len := Length(ws) * SizeOf(WideChar);
            end else begin
              Bytes := nxDelphiWideStringToBytes(ws, UsedStorageCodePage);
              VPtr := @Bytes[0];
              Len := Length(Bytes);
            end;
          end;
        end else begin
          Bytes := aValue;
          if Length(Bytes) > 0 then begin
            VPtr := @Bytes[0];
            Len := Length(Bytes);
          end;
        end;
      end;

      RecID  := acGetRecID(aBuffer);

      if not Assigned(VPtr) then begin
        if not Assigned(BlobNr) then
          Exit;
        nxCheck(BlobDelete(RecID, aField, BlobNr^));
        PnxInt64(@aBuffer[fdOffset])^ := 0;
        SetRecordFieldNull(aField, aBuffer, True);
      end else begin
        if not Assigned(BlobNr) then begin
          BlobNr := PnxBlobNr(@aBuffer[fdOffset]);
          BlobNr^ := 0;
          nxCheck(BlobCreate(RecID, aField, BlobNr^));
          SetRecordFieldNull(aField, aBuffer, False);
        end;
        nxCheck(BlobWrite(RecID, aField, BlobNr^, 0, Len, VPtr^));
        nxCheck(BlobTruncate(RecID, aField, BlobNr^, Len));
      end;
    end else
      FieldByIndexAsVariant[aBuffer, aField] := aValue;
  end;
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.SetToCacheBookmark(aBookmark : PnxBookmarkBuffer;
                                              aSize     : TnxWord32)
                                                        : TnxResult;
begin
  Result := nxpNotSupported('SetToCacheBookmark');
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.SetToKey(aSearchAction : TnxSearchKeyAction;
                                    aFieldCount   : Integer;
                                    aPartialLen   : Integer;
                                    aKeyData      : PnxRecordBuffer)
                                                  : TnxResult;
begin
  Result := SetToKey(aSearchAction, aFieldCount, aPartialLen, False, PnxKeyOrRecordBuffer(aKeyData));
end;
{------------------------------------------------------------------------------}
function TnxAbstractCursor.SetToKey(aSearchAction : TnxSearchKeyAction;
                                    aFieldCount   : Integer;
                                    aPartialLen   : Integer;
                                    aKeyData      : PnxKeyBuffer)
                                                  : TnxResult;
begin
  Result := SetToKey(aSearchAction, aFieldCount, aPartialLen, True, PnxKeyOrRecordBuffer(aKeyData));
end;
{==============================================================================}



{===TnxAbstractServerCursor====================================================}
function TnxAbstractServerCursor.ascBlobRequestCache(const aRecID     : TnxRecID;
                                                           aFieldNo   : TnxInt32;
                                                     const aBlobNr    : TnxBlobNr)
                                                                      : TnxResult;
begin
  if Assigned(ascRemoteCursor) then
    Result := ascRemoteCursor.rcCacheBlob(aRecID, aFieldNo, aBlobNr, nil)
  else
    Result := DBIERR_NOTSUPPORTED;
end;
{==============================================================================}



{===TnxBatchStreamAccess=======================================================}
procedure TnxBatchStreamAccess.bsaAfterClear;
begin
  {can be overridden}
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.bsaIsSameBlobs(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                                       const aBlobAccesses : TnxBatchBlobAccesses)
                                                           : Boolean;
var
  lIdx: Integer;
begin
  Result := Assigned(aBlobInfo) = Assigned(aBlobAccesses);
  if Result and Assigned(aBlobInfo) then
    Result := aBlobInfo.rcibiCount = Length(aBlobAccesses);
  if Result then
    for lIdx := Low(aBlobAccesses) to High(aBlobAccesses) do
      if aBlobAccesses[lIdx].bbaBlobNr <> aBlobInfo.rcibiBlobNrs[lIdx] then begin
        Result := False;
        Exit;
      end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.bsaParseEntry(aBasePtr : PnxByteArray;
                                        var aEntry   : TnxBatchStreamEntry)
                                                     : PnxByteArray;
var
  Remaining   : Integer;
  HasResult   : Boolean;
begin
  FillChar(aEntry, SizeOf(aEntry), 0);
  with aEntry do begin
    bseBatchAccess := Self;
    bseStreamBase := bsaStart;
    bseEntryBase := aBasePtr;

    bseSize := PnxWord32(aBasePtr)^;
    HasResult := bseSize and $80000000 <> 0;
    bseSize := bseSize and (not $80000000);
    aBasePtr := @aBasePtr[SizeOf(TnxWord32)];
    Remaining := bseSize;

    Result := @aBasePtr[bseSize];
    if TnxNativeUInt(Result) >= bsaEnd then
      Result := nil;

    if HasResult then begin
      bseResult := PnxResult(aBasePtr)^;
      aBasePtr := @aBasePtr[SizeOf(TnxResult)];
      Dec(Remaining, SizeOf(TnxResult));
    end else
      bseResult := DBIERR_NONE;

    if bseResult = DBIERR_NX_CACHE_VALID then begin
      bseRecord := nil;
      bseBookmark := nil;
      if Remaining >= SizeOf(PnxRecordCacheInfo) then
      bseCacheInfo := Pointer(aBasePtr);
      if gboBlobs in bsaOptions then begin
        bseBlobOffsets := Pointer(@PnxByteArray(bseCacheInfo)[SizeOf(bseCacheInfo^)]);
        if bseBlobOffsets[0].bboOffset = 0 then
          bseBlobOffsets := nil;
        end;
    end else if bseResult = DBIERR_NONE then begin
      bseCacheInfo := nil;
      bseRecord := PnxRecordBuffer(aBasePtr);
      if gboBookmarks in bsaOptions then begin
        aBasePtr := @aBasePtr[bsaRecordLength];
        bseBookmark := PnxBookmarkBuffer(aBasePtr);
      end else
        bseBookmark := nil;
    end;
  end;
end;
{------------------------------------------------------------------------------}
type
  TnxBlobNrSortedList = class(TnxSortedList)
  protected
    function slCompare(a, b : Pointer) : TnxValueRelationship; override;
  end;

function TnxBlobNrSortedList.slCompare(a, b : Pointer) : TnxValueRelationship;
begin
  Result := nxCmpI64Ptr(PnxInt64(a), PnxInt64(b));
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.bsaProcessBlobsForCacheInfo(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                                                     const aBlobAccesses : TnxBatchBlobAccesses;
                                                       var aEntry        : TnxBatchStreamEntry);
var
  lAccessIdx         : Integer;
  lBlobInfoIdx       : Integer;
begin
  with aEntry do begin
    bseBlobOffsets := Pointer(@PnxByteArray(bseCacheInfo)[SizeOf(bseCacheInfo^)]);

    Assert(
      { given the size of the minimum set of required fields for a cachable
        table, this should never fail, even for tables with only
        blob fields and with all of them being filledm and no bookmarks in use }
      Int64(bsaRecordLength + bsaBookmarkSize) -
      Int64(SizeOf(TnxResult) + SizeOf(bseCacheInfo^)) >=
      Int64((Length(aBlobAccesses) * SizeOf(TnxBatchBlobOffset)) + SizeOf(TnxBlobNr))
    );

    if not Assigned(aBlobInfo) or
       (aBlobInfo.rcibiCount = 0)
    then begin
      { we keep all the Blobs }
      for lAccessIdx := Low(aBlobAccesses) to High(aBlobAccesses) do
        with bseBlobOffsets[lAccessIdx], aBlobAccesses[lAccessIdx] do begin
          bboFieldNo := bbaFieldNo;
          bboOffset := bbaOffset;
        end;
    end else begin
      { we have to check what blobs are already present on the client,
        zero their contents, and keep the others }
      with TnxBlobNrSortedList.Create(aBlobInfo.rcibiCount) do try
        SuspendSorting;
        try
          for lBlobInfoIdx := 0 to Pred(aBlobInfo.rcibiCount) do
            Add(@aBlobInfo.rcibiBlobNrs[lBlobInfoIdx]);
        finally
          ResumeSorting;
        end;

        for lAccessIdx := Low(aBlobAccesses) to High(aBlobAccesses) do
          with bseBlobOffsets[lAccessIdx], aBlobAccesses[lAccessIdx] do begin
            { we keep information about all blob offsets, even the ones
              the client already has, to make it easy for the client to just
              fill in the information }
            bboFieldNo := bbaFieldNo;
            bboOffset := bbaOffset;
            if IndexOf(@bbaBlobNr) >= 0 then begin
              { the client has this blob already, we can zero it }
              Assert(Assigned(bbaBase));
              if bbaSize > SizeOf(TnxResult) then begin
                { no sense touching smaller blobs }
                Assert(Assigned(bbaBlobData));
                FillChar(bbaBlobData^, bbaSize, 0);
                PnxResult(bbaBlobData)^ := DBIERR_NX_CACHE_VALID;
                PnxWord32(bbaBase)^ := PnxWord32(bbaBase)^ or $80000000;
              end;
            end;
          end;
      finally
        Free;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.bsaProcessBlobsForRecord(aBlobInfo     : PnxRecordCacheInfoBlobInfo;
                                                  const aBlobAccesses : TnxBatchBlobAccesses;
                                                    var aEntry        : TnxBatchStreamEntry);
var
  lAccessIdx         : Integer;
  lBlobInfoIdx       : Integer;
begin
  with aEntry, TnxBlobNrSortedList.Create(aBlobInfo.rcibiCount) do try
    SuspendSorting;
    try
      for lBlobInfoIdx := 0 to Pred(aBlobInfo.rcibiCount) do
        Add(@aBlobInfo.rcibiBlobNrs[lBlobInfoIdx]);
    finally
      ResumeSorting;
    end;

    for lAccessIdx := Low(aBlobAccesses) to High(aBlobAccesses) do
      with aBlobAccesses[lAccessIdx] do
        if IndexOf(@bbaBlobNr) >= 0 then begin
          { the client has this blob already, we can zero it }
          Assert(Assigned(bbaBase));
          if bbaSize > SizeOf(TnxResult) then begin
            { no sense touching smaller blobs }
            Assert(Assigned(bbaBlobData));
            FillChar(bbaBlobData^, bbaSize, 0);
            PnxResult(bbaBlobData)^ := DBIERR_NX_CACHE_VALID;
            PnxWord32(bbaBase)^ := PnxWord32(bbaBase)^ or $80000000;
          end;
        end;
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
type
  TnxCacheInfoSortedList = class(TnxSortedList)
  protected
    function slCompare(a, b : Pointer) : TnxValueRelationship; override;
  end;

function TnxCacheInfoSortedList.slCompare(a, b : Pointer) : TnxValueRelationship;
begin
  Result := nxCmpI64(
    PnxRecordCacheInfo(a).rciRefNr,
    PnxRecordCacheInfo(b).rciRefNr
  );
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.CheckCacheValid(aCacheInfosCount : Integer;
                                              aCacheInfos      : PnxRecordCacheInfo;
                                              aBlobInfos       : PnxRecordCacheInfoBlobInfo)
                                                               : Boolean;
var
  lBlobAccesses      : TnxBatchBlobAccesses;

var
  lEntry             : TnxBatchStreamEntry;



var
  lCacheInfo         : TnxRecordCacheInfo;
  lCacheInfoIdx      : Integer;
  lIndexedCacheInfos : TnxIndexedRecordCacheInfoAndBlobInfos;
  lIndexedCacheInfo  : PnxIndexedRecordCacheInfoAndBlobInfo;
  lList              : TnxCacheInfoSortedList;
  lUsedCacheInfos    : PnxByteArray;

  lOldSize           : TnxMemSize;
  lInvalidCount      : PnxInt32;
  lInvalidInfos      : PnxRecordCacheInfo;

  lBlobsDifferent    : Boolean;
begin
  if not (gboBlobs in bsaOptions) then
    aBlobInfos := nil;

  Result := GetCount = aCacheInfosCount;
  Reset;
  { first try it sequentially }
  lEntry.bseResult := DBIERR_NA;
  lCacheInfoIdx := 0;
  while (aCacheInfosCount > 0) and Next(lEntry) do begin
    with lEntry do
      if (bseResult = DBIERR_NONE) and
         Assigned(bseRecord) and
         (bseSize >= SizeOf(TnxRecordCacheInfo) + SizeOf(TnxResult) + SizeOf(Integer)) and
         (bsaCursor.ExtractCacheInfo(bseRecord, lCacheInfo) = DBIERR_NONE) and
         rciIsSame(lCacheInfo, aCacheInfos)
      then begin
        lBlobsDifferent := False;
        if (gboBlobs in bsaOptions) and
           GetBlobAccesses(lEntry, lBlobAccesses, True)
        then begin
          { there is at least one blob in the record,
            we need to check that the clien has all the blobs }
          if not bsaIsSameBlobs(aBlobInfos, lBlobAccesses) then begin
            { There is at least some difference }
            Result := False;
            lBlobsDifferent := True;
          end;
        end;

        if lBlobsDifferent then
          { can only zero the record and bookmark and will have to check the
            blobs individually later }
          FillChar(bseRecord^, bsaRecordLength + bsaBookmarkSize, 0)
        else
          FillChar(bseRecord^, bseSize, 0);

        PnxResult(bseRecord)^ := DBIERR_NX_CACHE_VALID;
        bseCacheInfo := Pointer(@bseRecord[SizeOf(TnxResult)]);
        bseRecord := nil;
        bseBookmark := nil;
        PnxRecordCacheInfo(bseCacheInfo)^ := aCacheInfos^;
        bseCacheInfo.irciIndex := lCacheInfoIdx;
        PnxWord32(bseEntryBase)^ := bseSize or $80000000;

        if lBlobsDifferent then
          bsaProcessBlobsForCacheInfo(aBlobInfos, lBlobAccesses, lEntry);
      end else begin
        { hit a non-matching entry, need to switch to random access for the remaining ones }
        Result := False;
        Break;
      end;
    Dec(aCacheInfosCount);
    Inc(aCacheInfos);
    Inc(lCacheInfoIdx);
    rcibiNext(aBlobInfos);
    lEntry.bseResult := DBIERR_NA;
  end;

  if (aCacheInfosCount > 0) and (lEntry.bseResult <> DBIERR_NA) then begin
    Result := False;

    while (lEntry.bseResult <> DBIERR_NONE) or
          not Assigned(lEntry.bseRecord) or
          (lEntry.bseSize < SizeOf(TnxRecordCacheInfo) + SizeOf(TnxResult) + SizeOf(Integer))
    do if not Next(lEntry) then
      Exit;

    { there is at least one more valid record, we need to build an index
      of cache infos by refnr }
    SetLength(lIndexedCacheInfos, aCacheInfosCount);
    lList := TnxCacheInfoSortedList.Create(aCacheInfosCount);
    nxGetZeroMem(lUsedCacheInfos, ((aCacheInfosCount + 63) shr 4)shl 1);
    try
      lList.SuspendSorting;
      try
        while aCacheInfosCount > 0 do begin
          lIndexedCacheInfo := @lIndexedCacheInfos[Pred(aCacheInfosCount)];
          PnxRecordCacheInfo(@lIndexedCacheInfo.irciabiIndexedRecordCacheInfo)^ := aCacheInfos^;
          lIndexedCacheInfo.irciabiIndexedRecordCacheInfo.irciIndex := lCacheInfoIdx;
          lIndexedCacheInfo.irciabiBlobInfo := aBlobInfos;
          lList.Add(lIndexedCacheInfo);
          Dec(aCacheInfosCount);
          Inc(aCacheInfos);
          Inc(lCacheInfoIdx);
          rcibiNext(aBlobInfos);
        end;
      finally
        lList.ResumeSorting;
      end;

      repeat
        with lEntry do
          if (bseResult = DBIERR_NONE) and
             Assigned(bseRecord) and
             (bseSize >= SizeOf(TnxRecordCacheInfo) + SizeOf(TnxResult) + SizeOf(Integer)) and
             (bsaCursor.ExtractCacheInfo(bseRecord, lCacheInfo) = DBIERR_NONE)
          then if lList.Find(@lCacheInfo, lCacheInfoIdx) then
            if rciIsSame(lCacheInfo, PnxIndexedRecordCacheInfo(lList[lCacheInfoIdx])) then begin

              lBlobsDifferent := False;
              if (gboBlobs in bsaOptions) and
                 GetBlobAccesses(lEntry, lBlobAccesses)
              then begin
                aBlobInfos := PnxIndexedRecordCacheInfoAndBlobInfo(lList[lCacheInfoIdx]).irciabiBlobInfo;
                { there is at least one blob in the record,
                  we need to check that the clien has all the blobs }
                if not bsaIsSameBlobs(aBlobInfos, lBlobAccesses) then
                  { There is at least some difference }
                  lBlobsDifferent := True;
              end;

              if lBlobsDifferent then
                { can only zero the record and bookmark and will have to check the
                  blobs individually later }
                FillChar(bseRecord^, bsaRecordLength + bsaBookmarkSize, 0)
              else
                FillChar(bseRecord^, bseSize, 0);

              PnxResult(bseRecord)^ := DBIERR_NX_CACHE_VALID;
              bseCacheInfo := Pointer(@bseRecord[SizeOf(TnxResult)]);
              bseRecord := nil;
              bseBookmark := nil;
              PnxIndexedRecordCacheInfo(bseCacheInfo)^ := PnxIndexedRecordCacheInfo(lList[lCacheInfoIdx])^;
              PnxWord32(bseEntryBase)^ := bseSize or $80000000;
              nxSetBit(lUsedCacheInfos, lCacheInfoIdx);

              if lBlobsDifferent then
                bsaProcessBlobsForCacheInfo(aBlobInfos, lBlobAccesses, lEntry);
            end else begin
              if (gboBlobs in bsaOptions) and
                 GetBlobAccesses(lEntry, lBlobAccesses)
              then begin
                aBlobInfos := PnxIndexedRecordCacheInfoAndBlobInfo(lList[lCacheInfoIdx]).irciabiBlobInfo;
                if Assigned(aBlobInfos) and
                   (aBlobInfos.rcibiCount > 0)
                then
                  bsaProcessBlobsForRecord(aBlobInfos, lBlobAccesses, lEntry);
              end;
            end;
      until not Next(lEntry);

      lOldSize := bsaStream.Size;
      bsaStream.Size := lOldSize + SizeOf(lInvalidCount^) + (lList.Count * SizeOf(lInvalidInfos^));
      lInvalidCount := @bsaStream.ByteArray[lOldSize];
      lInvalidInfos := @bsaStream.ByteArray[lOldSize + SizeOf(lInvalidCount^)];
      lInvalidCount^ := 0;

      for lCacheInfoIdx := 0 to Pred(lList.Count) do
        if not nxIsBitSet(lUsedCacheInfos, lCacheInfoIdx) then begin
          lIndexedCacheInfo := lList[lCacheInfoIdx];
          with lIndexedCacheInfo^, irciabiIndexedRecordCacheInfo do
          case bsaCursor.ContainsLSNRefNr(irciModifyLSN, irciRefNr) of
            DBIERR_KEYORRECDELETED, DBIERR_RECNOTFOUND: begin
              lInvalidInfos^ := PnxRecordCacheInfo(@irciabiIndexedRecordCacheInfo)^;
              Inc(lInvalidInfos);
              Inc(lInvalidCount^);
            end;
          end;
        end;

      if lInvalidCount^ = 0 then
        bsaStream.Size := lOldSize
      else
        bsaStream.Size := lOldSize + SizeOf(lInvalidCount^) + (lInvalidCount^ * SizeOf(lInvalidInfos^));
    finally
      lList.Free;
      nxFreeMem(lUsedCacheInfos);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.CheckCacheValidSeq(const aCacheInfos : TnxRecordCacheInfos;
                                                       aBlobInfos  : PnxRecordCacheInfoBlobInfo)
                                                                   : Boolean;
var
  lEntry             : TnxBatchStreamEntry;
  lCacheInfo         : TnxRecordCacheInfo;
  CacheInfoIdx       : Integer;

  lOldSize           : TnxMemSize;
  lInvalidCount      : PnxInt32;
  lInvalidInfos      : PnxRecordCacheInfo;

  procedure lAddInvalid;
  begin
    if rciIsValid(aCacheInfos[CacheInfoIdx]) then
      case bsaCursor.ContainsCacheInfo(aCacheInfos[CacheInfoIdx]) of
        DBIERR_KEYORRECDELETED, DBIERR_RECNOTFOUND: begin

          if not Assigned(lInvalidCount) then begin
            bsaStream.Size := lOldSize + SizeOf(lInvalidCount^) + ((Length(aCacheInfos) - CacheInfoIdx) * SizeOf(lInvalidInfos^));
            lInvalidCount := @bsaStream.ByteArray[lOldSize];
            lInvalidInfos := @bsaStream.ByteArray[lOldSize + SizeOf(lInvalidCount^)];
            lInvalidCount^ := 0;
          end;

          lInvalidInfos^ := aCacheInfos[CacheInfoIdx];
          Inc(lInvalidCount^);

        end;
      end;
  end;

var
  lBlobsDifferent : Boolean;
  lBlobAccesses   : TnxBatchBlobAccesses;
begin
  if not (gboBlobs in bsaOptions) then
    aBlobInfos := nil;

  lInvalidCount := nil;
  lInvalidInfos := nil;

  Result := GetCount = Length(aCacheInfos);
  Reset;
  lOldSize := bsaStream.Size;
  CacheInfoIdx := 0;
  while (CacheInfoIdx <= High(aCacheInfos)) and Next(lEntry) do begin
    with lEntry do
      if (bseResult = DBIERR_NONE) and
         Assigned(bseRecord) and
         (bseSize >= SizeOf(TnxRecordCacheInfo) + SizeOf(TnxResult)) and
         (bsaCursor.ExtractCacheInfo(bseRecord, lCacheInfo) = DBIERR_NONE) and
         (lCacheInfo.rciRefNr = aCacheInfos[CacheInfoIdx].rciRefNr)
      then begin
        if rciIsSame(lCacheInfo, aCacheInfos[CacheInfoIdx]) then begin
          lBlobsDifferent := False;
          if (gboBlobs in bsaOptions) and
             GetBlobAccesses(lEntry, lBlobAccesses, True)
          then begin
            { there is at least one blob in the record,
              we need to check that the client has all the blobs }
            if not bsaIsSameBlobs(aBlobInfos, lBlobAccesses) then begin
              { There is at least some difference }
              Result := False;
              lBlobsDifferent := True;
            end;
          end;

          if lBlobsDifferent then
            { can only zero the record and bookmark and will have to check the
              blobs individually later }
            FillChar(bseRecord^, bsaRecordLength + bsaBookmarkSize, 0)
          else
            FillChar(bseRecord^, bseSize, 0);

          PnxResult(bseRecord)^ := DBIERR_NX_CACHE_VALID;
          bseCacheInfo := Pointer(@bseRecord[SizeOf(TnxResult)]);
          bseRecord := nil;
          bseBookmark := nil;
          PnxRecordCacheInfo(bseCacheInfo)^ := lCacheInfo;
          PnxWord32(bseEntryBase)^ := bseSize or $80000000;

          if lBlobsDifferent then
            bsaProcessBlobsForCacheInfo(aBlobInfos, lBlobAccesses, lEntry);
        end else begin
          { RefNr matches, but LSN doesn't, need to return the full record, but
            may be able to skip some blobs}
          Result := False;
          if (gboBlobs in bsaOptions) and
             GetBlobAccesses(lEntry, lBlobAccesses) and
             Assigned(aBlobInfos) and
             (aBlobInfos.rcibiCount > 0)
          then
            bsaProcessBlobsForRecord(aBlobInfos, lBlobAccesses, lEntry);
        end;
      end else begin
        if (bseResult <> DBIERR_NONE) and
           not rciIsValid(aCacheInfos[CacheInfoIdx])
        then begin
          { both didn't have a record, that's ok }
        end else begin
          { there is at least one difference between this stream and the cache infos }
          Result := False;
          lAddInvalid;
        end;
      end;
    Inc(CacheInfoIdx);
    rcibiNext(aBlobInfos);
  end;

  while (CacheInfoIdx <= High(aCacheInfos)) do begin
    Result := False;
    lAddInvalid;
    Inc(CacheInfoIdx);
  end;

  if Assigned(lInvalidCount) then
    if lInvalidCount^ = 0 then
      bsaStream.Size := lOldSize
    else
      bsaStream.Size := lOldSize + SizeOf(lInvalidCount^) + (lInvalidCount^ * SizeOf(lInvalidInfos^));
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.CheckEntryForCachedBlobs(var aEntry          : TnxBatchStreamEntry;
                                                            aCache          : TnxAbstractCursor;
                                                        out aBlobs          : TnxBatchBlobAccesses);
var
  lAccessIdx  : Integer;
  lRecID      : TnxRecID;
  lResult     : TnxResult;
  lBlobLength : TnxWord32;
begin
  aBlobs := nil;

  with aEntry, bsaCursor, acFieldsDescriptor do
    if Assigned(bseRecord) and
       (gboBlobs in bsaOptions) and
       aEntry.bseBatchAccess.GetBlobAccesses(aEntry, aBlobs) and
       Assigned(aBlobs)
    then begin
      lRecID := acGetRecID(bseRecord);
      for lAccessIdx := Low(aBlobs) to High(aBlobs) do
        with aBlobs[lAccessIdx] do
          if bbaResult <> DBIERR_NONE then begin
            lResult := aCache.BlobGetLength(lRecID, bbaFieldNo, bbaBlobNr, lBlobLength, False, nil);
            if lResult = DBIERR_NONE then
              if lBlobLength = bbaSize then begin
                bbaBlobData := @bbaBase[SizeOf(TnxWord32)];
                with TnxStaticMemoryStream.Create(bbaBlobData, bbaSize) do try
                  lResult := aCache.BlobRead(lRecID, bbaFieldNo, bbaBlobNr, 0, lBlobLength, TheStream, False, nil);
                  if lResult = DBIERR_NONE then
                    if Position <> bbaSize then
                      lResult := DBIERR_BLOBERR;
                finally
                  Free;
                end;
                if lResult = DBIERR_NONE then begin
                  PnxWord32(bbaBase)^ := bbaSize;
                  bbaResult := DBIERR_NONE;
                  bbaInCache := True;
                end else begin
                  PnxResult(bbaBlobData)^ := bbaResult;
                  bbaBlobData := nil;
                end;
              end;
            Assert(bbaResult = DBIERR_NONE);
          end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.Clear(aKeepError: Boolean);
begin
  if Assigned(Self) then begin
    if aKeepError and
       (bsaStream.Size >= SizeOf(TnxResult)) and
       (PnxBatchStreamHeader(bsaStream.Memory).bshInnerError <> DBIERR_NONE)
    then begin
      bsaStream.Size := SizeOf(TnxBatchStreamHeader);
      PnxBatchStreamHeader(bsaStream.Memory).bshCount := 0;
    end else
      bsaStream.Size := 0;
    bsaAfterClear;
    Reset;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxBatchStreamAccess.Create(aCursor  : TnxAbstractCursor;
                                        aStream  : TnxMemoryStream;
                                        aOptions : TnxRecordGetBatchExOptions);
begin
  inherited Create;
  try
    bsaCursor := aCursor;

    if Assigned(aStream) then
      bsaStream := aStream
    else
      bsaStream := TnxMemoryStream.Create;
    bsaOptions := aOptions;

    if gboBlobs in bsaOptions then
      if not Assigned(bsaCursor.acSFI.sfiBlobFields) then
        Exclude(bsaOptions, gboBlobs);
    if not (gboBlobs in bsaOptions) then
      Exclude(bsaOptions, gboBlobNrs);

    if [gboBlobs, gboBlobsOnlyMarked] * aOptions = [gboBlobs, gboBlobsOnlyMarked] then
      bsaMarkedBlobs := Copy(bsaCursor.acMarkedBlobs);

    bsaRecordLength := bsaCursor.FieldsDescriptor.RecordLength;
    if gboBookmarks in bsaOptions then
      bsaCursor.sbcGetBookmarkSize(bsaBookmarkSize)
    else
      bsaBookmarkSize := 0;
  except
    //don't take ownership of aStream if the constructor failed
    if Assigned(aStream) then
      bsaStream := nil;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxBatchStreamAccess.Current: TnxBatchStreamAccess;
begin
  Result := _CurrentBatchStreamAccess;
end;
{------------------------------------------------------------------------------}
destructor TnxBatchStreamAccess.Destroy;
begin
  nxFreeAndNil(bsaStream);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.FixupBlobs(aOrgOptions: TnxRecordGetBatchExOptions);
var
  lEntry     : TnxBatchStreamEntry;
  lAccesses  : TnxBatchBlobAccesses;
  lAccessIdx : Integer;
begin
  if (gboBlobs in bsaOptions) and not (gboBlobs in aOrgOptions) then begin
    if Reset then
      while Next(lEntry) do with lEntry, bsaCursor, acFieldsDescriptor do
        if Assigned(bseRecord) and
           GetBlobAccesses(lEntry, lAccesses)
        then for lAccessIdx := Low(lAccesses) to High(lAccesses) do
          with lAccesses[lAccessIdx] do
            if bbaOffset <> 0 then
              SetRecordField(bbaFieldNo, bseRecord, @bbaBlobNr);
    bsaOptions := bsaOptions - [gboBlobs, gboBlobNrs, gboBlobsOnlyMarked];
  end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                                                  aFieldNo    : Integer;
                                              out aBlobAccess : TnxBatchBlobAccess)
                                                              : Boolean;
var
  lBlobValue : PnxInt64;
begin
  Result := False;
  FillChar(aBlobAccess, SizeOf(aBlobAccess), 0);
  with aEntry, aBlobAccess do begin
    bbaFieldNo   := aFieldNo;

    if not Assigned(bseRecord) then begin
      bbaResult := bseResult;
      if bbaResult = DBIERR_NONE then
        bbaResult := DBIERR_NOCURRREC;
      Exit;
    end;

    with bsaCursor.acFieldsDescriptor, FieldDescriptor[aFieldNo] do begin

      if not (fdType in nxcBlobTypes) then begin
        bbaResult := DBIERR_NOTABLOB;
        Exit;
      end;

      lBlobValue := GetRecordFieldForFilter(aFieldNo, bseRecord);
      if Assigned(lBlobValue) and (lBlobValue^ <> 0) then begin
        Result := True;
        if (gboBlobs in bsaOptions) and
           (
             not (gboBlobsOnlyMarked in bsaOptions) or
             (
               (fdBlobIndex >= 0) and
               Assigned(bsaMarkedBlobs) and
               nxIsBitSet(@bsaMarkedBlobs[0], fdBlobIndex)
             )
           )
        then begin
          bbaOffset := lBlobValue^;
          Result := GetBlobAccess(aEntry, aBlobAccess);
        end else
          bbaBlobNr := lBlobValue^;
      end;

    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                                                  aBlobOffset : PnxBatchBlobOffset;
                                              out aBlobAccess : TnxBatchBlobAccess)
                                                              : Boolean;
begin
  Result := False;
  FillChar(aBlobAccess, SizeOf(aBlobAccess), 0);
  if Assigned(aBlobOffset) then with aBlobAccess, aBlobOffset^ do
    if bboOffset <> 0 then begin
      bbaOffset := bboOffset;
      bbaFieldNo := bboFieldNo;
      Result := GetBlobAccess(aEntry, aBlobAccess);
    end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetBlobAccess(const aEntry      : TnxBatchStreamEntry;
                                              var aBlobAccess : TnxBatchBlobAccess)
                                                              : Boolean;
var
  lHasResult : Boolean;
begin
  with aEntry, aBlobAccess do begin
    Result := aBlobAccess.bbaOffset <> 0;
    if Result then begin
      bbaBase := @bseStreamBase[bbaOffset];
      bbaSize := PnxWord32(bbaBase)^;
      lHasResult := bbaSize and $80000000 <> 0;
      bbaSize := bbaSize and not $80000000;

      if lHasResult then begin
        if bbaSize >= SizeOf(TnxResult) then
          bbaResult := PnxResult(@bseStreamBase[bbaOffset + SizeOf(TnxWord32)])^
        else
          bbaResult := DBIERR_NX_UNKNOWN;
      end else
        bbaBlobData := @bseStreamBase[bbaOffset + SizeOf(TnxWord32)];

      if gboBlobNrs in bsaOptions then
        bbaBlobNr := PnxBlobNr(@bseStreamBase[bbaOffset + SizeOf(TnxWord32) + bbaSize])^;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetBlobAccesses(const aEntry        : TnxBatchStreamEntry;
                                                var aBlobAccesses : TnxBatchBlobAccesses;
                                                    aEmbeddedOnly : Boolean = False)
                                                                  : Boolean;
var
  lBlobIdx     : Integer;
  lAccessIndex : Integer;
  lBlobOffset  : PnxBatchBlobOffset;
begin
  lAccessIndex := 0;

  with bsaCursor.acSFI^, aEntry do begin

    aBlobAccesses := nil;
    SetLength(aBlobAccesses, Length(sfiBlobFields));

    if Assigned(bseRecord) then begin

      for lBlobIdx := Low(sfiBlobFields) to High(sfiBlobFields) do
        if GetBlobAccess(aEntry, sfiBlobFields[lBlobIdx], aBlobAccesses[lAccessIndex]) then
          if not aEmbeddedOnly or
             (Assigned(aBlobAccesses[lAccessIndex].bbaBlobData))
          then
            Inc(lAccessIndex);

    end else if Assigned(bseBlobOffsets) then begin

      lBlobOffset := @bseBlobOffsets[0];
      lBlobIdx := 0;
      while (lBlobIdx < Length(aBlobAccesses)) and
            (lBlobOffset.bboOffset <> 0)
      do begin
        if GetBlobAccess(aEntry, lBlobOffset, aBlobAccesses[lAccessIndex]) then
          Inc(lAccessIndex);
        Inc(lBlobOffset);
        Inc(lBlobIdx);
      end;

    end;

  end;

  SetLength(aBlobAccesses, lAccessIndex);
  Result := lAccessIndex > 0;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetCount: Integer;
begin
  Result := bsaHeader.bshCount
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetInnerError: TnxResult;
begin
  Result := bsaHeader.bshInnerError;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetMemory: Pointer;
begin
  if Assigned(Self) then
    Result := bsaStream.Memory
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.GetSize: TnxMemSize;
begin
  if Assigned(Self) then
    Result := bsaStream.Size
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.Next(var aEntry: TnxBatchStreamEntry; aPos: PInteger = nil; aTotalPos: PInteger = nil): Boolean;
var
  lCurrentBatchStreamAccess: PnxBatchStreamAccess;
  lPrevBatchStreamAccess: TnxBatchStreamAccess;
  lPrevStreamEntry : PnxBatchStreamEntry;
begin
  lCurrentBatchStreamAccess := @_CurrentBatchStreamAccess;

  lPrevBatchStreamAccess := lCurrentBatchStreamAccess^;
  lPrevStreamEntry := bsaCurrentStreamEntry;
  try
    lCurrentBatchStreamAccess^ := Self;
    bsaCurrentStreamEntry := @aEntry;
    repeat
      Result := Assigned(Self) and Assigned(bsaCurrentEntry);
      if Result then begin
        bsaCurrentEntry := bsaParseEntry(bsaCurrentEntry, aEntry);
        Inc(bsaCurrentIndex);
        if Assigned(aPos) then
          Inc(aPos^);
        if Assigned(aTotalPos) then
          Inc(aTotalPos^);
        if bsaCurrentIndex = Pred(bsaHeader.bshCount) then begin
          if Assigned(bsaCurrentEntry) and (TnxNativeUInt(bsaCurrentEntry) + SizeOf(bsaInvalidCount^) < bsaEnd) then begin
            bsaInvalidCount := Pointer(bsaCurrentEntry);
            if TnxNativeUInt(bsaCurrentEntry) + TnxNativeUInt(SizeOf(bsaInvalidCount^) + (bsaInvalidCount^ * SizeOf(TnxRecordCacheInfo))) <= bsaEnd then
              bsaInvalidInfos := @PnxByteArray(bsaInvalidCount)[SizeOf(bsaInvalidCount^)]
            else begin
              bsaInvalidCount := nil;
              bsaInvalidInfos := nil;
            end;
          end;
          bsaCurrentEntry := nil;
        end;
      end;
    until not Result or
          not bsaCheckFilter or
          Assigned(aEntry.bseRecord) and bsaCursor.FilterMatchesBuffer(aEntry.bseRecord);

    if not Result then
      FillChar(aEntry, SizeOf(aEntry), 0);
  finally
    lCurrentBatchStreamAccess^ := lPrevBatchStreamAccess;
    bsaCurrentStreamEntry := lPrevStreamEntry;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.Next(aEntry: PnxBatchStreamEntry; aPos, aTotalPos: PInteger): Boolean;
begin
  Result := Next(aEntry^, aPos, aTotalPos);
end;
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.OverwriteEntry(var aTarget         : TnxBatchStreamEntry;
                                           const aSource         : TnxBatchStreamEntry;
                                             out aBlobs          : TnxBatchBlobAccesses;
                                                 aRemoveBlobData : Boolean)
                                                                 : Boolean;
var
  lSourceBlobAccess   : TnxBatchBlobAccess;
  lMoveSize           : TnxWord32;
  lAccessIdx          : Integer;

  CacheOffset         : TnxMemSize;
  ReplyOffset         : TnxMemSize;

  BlobIdx             : Integer;
  BlobFldIdx          : Integer;
  IsNull              : Boolean;
  BlobOffset          : TnxInt64;

  lAccesses           : TnxBatchBlobAccesses;
begin
  Assert(aTarget.bseStreamBase = bsaStream.Memory);
  Result := False;
  aBlobs := nil;

  with aTarget, bsaCursor, acFieldsDescriptor, acSFI^ do begin
    if Assigned(aTarget.bseBlobOffsets) or aRemoveBlobData then begin
      Assert(gboBlobs in bsaOptions);
      if Assigned(aTarget.bseBlobOffsets) then
        aTarget.bseBatchAccess.GetBlobAccesses(aTarget, aBlobs);
      lMoveSize := bsaRecordLength + bsaBookmarkSize;
    end else
      lMoveSize := aSource.bseSize;

    Assert(bseSize >= lMoveSize);
    Move(
      aSource.bseEntryBase[SizeOf(TnxWord32)],
      bseEntryBase[SizeOf(TnxWord32)],
      lMoveSize
    );

    bseCacheInfo := nil;
    bseRecord := @bseEntryBase[SizeOf(TnxWord32)];
    if PnxWord32(aSource.bseEntryBase)^ and $80000000 <> 0 then begin
      PnxWord32(bseEntryBase)^ := bseSize or $80000000;
      bseResult := PnxResult(bseRecord)^;
      bseRecord := @bseRecord[SizeOf(TnxResult)];
    end else begin
      PnxWord32(bseEntryBase)^ := bseSize;
      bseResult := DBIERR_NONE;
    end;
    if (gboBookmarks in bsaOptions) and Assigned(aSource.bseBookmark) then
      bseBookmark := @bseRecord[bsaRecordLength]
    else
      bseBookmark := nil;

    if gboBlobs in bsaOptions then begin
      if aRemoveBlobData then begin
        { we need to use the blob information from the source to fix up the
          blob numbers in the target }
        if Assigned(aSource.bseRecord) and
           aSource.bseBatchAccess.GetBlobAccesses(aSource, lAccesses)
        then for lAccessIdx := Low(lAccesses) to High(lAccesses) do
          with lAccesses[lAccessIdx] do
            if bbaOffset <> 0 then
              SetRecordField(bbaFieldNo, bseRecord, @bbaBlobNr);
      end else if Assigned(aBlobs) then begin
        for lAccessIdx := Low(aBlobs) to High(aBlobs) do
          with aBlobs[lAccessIdx] do
            if not (gboBlobsOnlyMarked in bsaOptions) or
               (
                 Assigned(bsaMarkedBlobs) and
                 nxIsBitSet(Pointer(bsaMarkedBlobs), sfiFieldsToBlobFields[bbaFieldNo])
               )
            then begin
              if bbaResult <> DBIERR_NONE then begin
                aSource.bseBatchAccess.GetBlobAccess(aSource, bbaFieldNo, lSourceBlobAccess);
                if (lSourceBlobAccess.bbaResult = DBIERR_NONE) and Assigned(lSourceBlobAccess.bbaBlobData) then begin
                  Assert(bbaSize = lSourceBlobAccess.bbaSize);
                  Assert(bbaBlobNr = lSourceBlobAccess.bbaBlobNr);
                  bbaBlobData := @bbaBase[SizeOf(TnxWord32)];
                  Move(lSourceBlobAccess.bbaBlobData^, bbaBlobData^, lSourceBlobAccess.bbaSize);
                  PnxWord32(bbaBase)^ := bbaSize;
                  bbaResult := DBIERR_NONE;
                  bbaInCache := True;
                end;
              end;
              Assert(bbaResult = DBIERR_NONE);
              BlobOffset := bbaOffset;
              SetRecordField(bbaFieldNo, bseRecord, @BlobOffset);
            end;
      end else begin
        CacheOffset := TnxMemSize(aSource.bseEntryBase) - TnxMemSize(aSource.bseStreamBase);
        ReplyOffset := TnxMemSize(bseEntryBase) - TnxMemSize(bseStreamBase);
        if CacheOffset <> ReplyOffset then with bsaCursor, acSFI^ do begin
          {we need to rewrite the blob offsets}
          ReplyOffset := ReplyOffset - CacheOffset;
          for BlobIdx := Low(sfiBlobFields) to High(sfiBlobFields) do
            if not (gboBlobsOnlyMarked in bsaOptions) or
               (
                 Assigned(bsaMarkedBlobs) and
                 nxIsBitSet(Pointer(bsaMarkedBlobs), BlobIdx)
               )
            then begin
              BlobFldIdx := sfiBlobFields[BlobIdx];
              acFieldsDescriptor.GetRecordField(BlobFldIdx, bseRecord, IsNull, @BlobOffset);
              if not IsNull then begin
                BlobOffset := BlobOffset + ReplyOffset;
                acFieldsDescriptor.SetRecordField(BlobFldIdx, bseRecord, @BlobOffset);
              end;
            end;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
const
  _EmptyHeader : TnxBatchStreamHeader = ();
{------------------------------------------------------------------------------}
function TnxBatchStreamAccess.Reset(aApplyClientFilter: Boolean): Boolean;
begin
  if not Assigned(Self) then
    Result := False
  else if bsaStream.Size >= SizeOf(TnxBatchStreamHeader) then begin
    bsaHeader := bsaStream.Memory;
    bsaStart := bsaStream.Memory;
    bsaEnd := TnxNativeUInt(@bsaStart[bsaStream.Size]);
    bsaCurrentEntry := @bsaHeader.bshStart;
    bsaCurrentIndex := -1;
    bsaInvalidCount := nil;
    bsaInvalidInfos := nil;
    Result := bsaHeader.bshCount > 0;
    if not Result then begin
      if bsaStream.Size > SizeOf(TnxBatchStreamHeader) + SizeOf(TnxInt32) then begin
        bsaInvalidCount := Pointer(bsaCurrentEntry);
        if bsaStream.Size < SizeOf(TnxBatchStreamHeader) + SizeOf(TnxInt32) + (bsaInvalidCount^ * SizeOf(TnxRecordCacheInfo)) then
          bsaInvalidCount := nil
        else
          bsaInvalidInfos := @bsaStart[SizeOf(TnxBatchStreamHeader) + SizeOf(TnxInt32)];
      end;
      bsaCurrentEntry := nil;
    end;
  end else begin
    bsaHeader := @_EmptyHeader;
    bsaStart := nil;
    bsaEnd := 0;
    bsaCurrentEntry := nil;
    bsaCurrentIndex := -1;
    bsaInvalidCount := nil;
    bsaInvalidInfos := nil;
    Result := False;
  end;
  bsaCheckFilter := Result and aApplyClientFilter and bsaCursor.IsRemote and bsaCursor.HasActiveLocalFilter;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchStreamAccess.SetInnerError(const Value: TnxResult);
begin
  if Stream.Size >= SizeOf(TnxBatchStreamHeader) then
    bsaHeader.bshInnerError := Value;
end;
{==============================================================================}



{===TnxAbstractStatement=======================================================}
procedure TnxAbstractStatement.AfterConstruction;
begin
  inherited;
  LockedInc(asoGetServerEngine.bseStatementCount);
  asLockedIncDone := True;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractStatement.asAddToDatabase;
begin
  asDatabase.adStatementsPadlock.Lock;
  try
    asDatabasePrev := asDatabase.adStatementsTail;
    asDatabase.adStatementsTail := Self;
    if Assigned(asDatabasePrev) then
      asDatabasePrev.asDatabaseNext:=Self;
    if not Assigned(asDatabase.adStatementsHead) then
      asDatabase.adStatementsHead := Self;
  finally
    asDatabase.adStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractStatement.asRemoveFromDatabase;
begin
  asDatabase.adStatementsPadlock.Lock;
  try
    if Assigned(asDatabaseNext) then
      asDatabaseNext.asDatabasePrev := asDatabasePrev
    else
      if asDatabase.adStatementsTail = Self then
        asDatabase.adStatementsTail := asDatabasePrev;

    if Assigned(asDatabasePrev) then
      asDatabasePrev.asDatabaseNext := asDatabaseNext
    else
      if asDatabase.adStatementsHead = Self then
        asDatabase.adStatementsHead := asDatabaseNext;

    asDatabaseNext := nil;
    asDatabasePrev := nil;
  finally
    asDatabase.adStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractStatement.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if asLockedIncDone then
    LockedDec(asoGetServerEngine.bseStatementCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxAbstractStatement.Create(aDatabase : TnxAbstractDatabase;
                                        aTimeout  : TnxWord32);
begin
  atoLock := aDatabase.atoLock;

  asDatabase := aDatabase;
  asAddToDatabase;
  inherited Create(aDatabase, aTimeout);
end;
{------------------------------------------------------------------------------}
function TnxAbstractStatement.CreateInstanceFor(const aName        : string;
                                                const aClassID     : TnxGuid;
                                                const aOuter       : InxInterface;
                                                const aInterfaceID : TnxGuid;
                                                  out aInterface   )
                                                                   : HRESULT;
var
  Left, Right: string;
begin
  nxStrSplit(aName, ['.'], Left, Right);
  if Right = '' then
    Right := '<Self>';
  if SameText(Left, '<Statement>') then
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else if SameText(Left, '<Database>') then
    Result := asDatabase.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxAbstractStatement.Destroy;
begin
  asRemoveFromDatabase;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxAbstractStatement.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Database', asDatabase);
end;
{==============================================================================}



{===TnxBaseServerEngine========================================================}
function TnxBaseServerEngine.bseConvertException(aException : Exception;
                                                 aSource    : TnxAbstractServerObject)
                                                            : TnxResult;
begin
  if Assigned(aSource) then
    Result := ConvertException(aException, lcEventLog, aSource, aSource.MinVersion)
  else
    Result := ConvertException(aException, lcEventLog, nil, nxVersionNumber);
end;
{------------------------------------------------------------------------------}
function TnxBaseServerEngine.bseCreateInstanceFor(aSession     : TnxAbstractSession;
                                            const aName        : string;
                                            const aClassID     : TnxGuid;
                                            const aOuter       : InxInterface;
                                            const aInterfaceID : TnxGuid;
                                              out aInterface   )
                                                               : HRESULT;
var
  i         : Integer;
  Component : TnxComponent;
begin
  if SameText(aName, '<ServerEngine>') then
    Result := nxcCreateInstance(aSession, aClassID, aOuter, aInterfaceID, aInterface)
  else begin
    Result := E_NOINTERFACE;

    with IterateDependents do try
      for i := 0 to Pred(Count) do begin
        Component := TObject(Items[i]) as TnxComponent;
        if (aName = '') or SameText(aName, Component.Name) then
          Result := Component.nxcCreateInstance(aSession, aClassID, aOuter, aInterfaceID, aInterface);
        if Succeeded(Result) then
          Break;
      end;
    finally
      Free;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseServerEngine.bseGetKeepSessionStats: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.bseInactive;
begin
  {can be overriden}
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.bseInformMonitorsCreated(aExtendableObject: TnxExtendableServerObject);
var
  Idx: Integer;
begin
  with bseMonitors, BeginRead do try
    for Idx := 0 to Pred(Count) do
      with TnxBaseEngineMonitor(Items[Idx]) do
        if State >= nxsStarted then
          ExtendableObjectCreated(aExtendableObject);
  finally
    EndRead;
  end
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.bseInformMonitorsDestroyed(aExtendableObject: TnxExtendableServerObject);
var
  Idx: Integer;
begin
  with bseMonitors, BeginRead do try
    for Idx := 0 to Pred(Count) do
      with TnxBaseEngineMonitor(Items[Idx]) do
        if State >= nxsStarted then
          ExtendableObjectDestroyed(aExtendableObject);
  finally
    EndRead;
  end
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.ClearStats;
begin
  inherited;

end;
{------------------------------------------------------------------------------}
constructor TnxBaseServerEngine.Create(aOwner: TComponent);
begin
  bseMonitors := TnxListPortal.Create(TnxSortedList.Create);
  bseSessionsPadlock := TnxPadlock.Create(True);
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseServerEngine.Destroy;
begin
  inherited;

  nxFreeAndNil(bseSessionsPadlock);
  nxFreeAndNil(bseMonitors);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i            : Integer;
  ses          : TnxAbstractSession;
  sesContainer : InxExceptionDataContainer;
begin
  inherited;
  if aIncludeChildren then begin
    sesContainer := aContainer.AddContainer('Sessions');
    bseSessionsPadlock.Lock;
    try
      ses := bseSessionsHead;
      if Assigned(ses) then begin
        i := 0;
        while Assigned(ses) do begin
          sesContainer.AddValue('[' + IntToStr(i) + ']', ses, True);
          Inc(i);
          ses := ses.asServerEngineNext;
        end;
      end;
    finally
      bseSessionsPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.GetStatsCaptions(const aList: TStrings);
begin
  inherited;
  with aList do begin
    Add('Sessions');
    Add('Databases');
    Add('Transaction Contexts');
    Add('Cursors');
    Add('Statements');
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.GetStatsValues(const aList: TStrings);
begin
  inherited;
  with aList do begin
    Add(nxIntToStr(SessionCount));
    Add(nxIntToStr(DatabaseCount));
    Add(nxIntToStr(TransContextCount));
    Add(nxIntToStr(CursorCount));
    Add(nxIntToStr(StatementCount));
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseServerEngine.IsSecureServer: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.nxcAddDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxBaseEngineMonitor then
    bseMonitors.Add(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.nxcRemoveDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxBaseEngineMonitor then
    bseMonitors.Remove(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.scInitializing;
begin
  inherited;
  {$IFDEF NX_LITE}
  {$I Lite\nxLite11.inc}
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxBaseServerEngine.scShowUpTime: Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerEngine.scStopping;
begin
  inherited;
  bseSessionsPadlock.Lock;
  try
    while Assigned(bseSessionsTail) do
      bseSessionsTail.Free;
  finally
    bseSessionsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseServerEngine.SessionOpen(out aSession       : TnxAbstractSession;
                                       const aUserName      : UnicodeString;
                                       const aPassword      : UnicodeString;
                                       const aConnectedFrom : string;
                                             aTimeout       : TnxWord32)
                                                            : TnxResult;
begin
  Result := SessionOpenEx
    (aSession, aUserName, aPassword, aConnectedFrom, aTimeout, nxVersionNumber);
end;
{==============================================================================}



{==============================================================================}
procedure TnxBaseEngineExtender.beeAddToExtendableObject;
begin
  with beeExtendableObject do begin
    TnxPadlock.CreateAndLock(esoExtendersLock);
    try
      beeExtendableObjectPrev := esoExtendersTail;
      esoExtendersTail := Self;
      if Assigned(beeExtendableObjectPrev) then
        beeExtendableObjectPrev.beeExtendableObjectNext:=Self;
      if not Assigned(esoExtendersHead) then
        esoExtendersHead := Self;
      esoExtendersActions := esoExtendersActions + beeActions;
    finally
      esoExtendersLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineExtender.beeAddToMonitor;
begin
  if Assigned(beeMonitor) then begin
    beeMonitor.bemExtendersLock.Lock;
    try
      beeMonitorPrev := beeMonitor.bemExtendersTail;
      beeMonitor.bemExtendersTail := Self;
      if Assigned(beeMonitorPrev) then
        beeMonitorPrev.beeMonitorNext:=Self;
      if not Assigned(beeMonitor.bemExtendersHead) then
        beeMonitor.bemExtendersHead := Self;
    finally
      beeMonitor.bemExtendersLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseEngineExtender.beeCreateInstance(const aClassID     : TnxGuid;
                                                 const aOuter       : InxInterface;
                                                 const aInterfaceID : TnxGuid;
                                                   out aInterface   )
                                                                    : HRESULT;
begin
  Result := E_NOINTERFACE;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineExtender.beeRemoveFromExtendableObject;
begin
  if Assigned (beeExtendableObject) then with beeExtendableObject do begin
    TnxPadlock.CreateAndLock(esoExtendersLock);
    try
      if Assigned(beeExtendableObjectNext) then
        beeExtendableObjectNext.beeExtendableObjectPrev := beeExtendableObjectPrev
      else
        if esoExtendersTail = Self then
          esoExtendersTail := beeExtendableObjectPrev;

      if Assigned(beeExtendableObjectPrev) then
        beeExtendableObjectPrev.beeExtendableObjectNext := beeExtendableObjectNext
      else
        if esoExtendersHead = Self then
          esoExtendersHead := beeExtendableObjectNext;

      beeExtendableObjectNext := nil;
      beeExtendableObjectPrev := nil;
    finally
      esoExtendersLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineExtender.beeRemoveFromMonitor;
begin
  if Assigned(beeMonitor) then begin
    beeMonitor.bemExtendersLock.Lock;
    try
      if Assigned(beeMonitorNext) then
        beeMonitorNext.beeMonitorPrev := beeMonitorPrev
      else
        if beeMonitor.bemExtendersTail = Self then
          beeMonitor.bemExtendersTail := beeMonitorPrev;

      if Assigned(beeMonitorPrev) then
        beeMonitorPrev.beeMonitorNext := beeMonitorNext
      else
        if beeMonitor.bemExtendersHead = Self then
          beeMonitor.bemExtendersHead := beeMonitorNext;

      beeMonitorNext := nil;
      beeMonitorPrev := nil;
    finally
      beeMonitor.bemExtendersLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxBaseEngineExtender.Create(aMonitor          : TnxBaseEngineMonitor;
                                         aExtendableObject : TnxExtendableServerObject);
begin
  if beeActions = [] then
    beeActions := [Low(TnxEngineAction)..High(TnxEngineAction)] - [eaRecordFulltextUpdate];
  beeMonitor := aMonitor;
  beeExtendableObject := aExtendableObject;
  beeAddToMonitor;
  beeAddToExtendableObject;
  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseEngineExtender.Destroy;
begin
  inherited;
  beeRemoveFromExtendableObject;
  beeRemoveFromMonitor;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineExtender.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Monitor', beeMonitor);
  aContainer.AddValue('ExtendableObject', beeExtendableObject);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineExtender.PrepareDestroy;
begin
  { can be overridden }
end;
{==============================================================================}



{==============================================================================}
procedure TnxBaseEngineMonitor.bemSetServerEngine(aEngine : TnxBaseServerEngine);
begin
  if aEngine <> bemServerEngine then begin
    scCheckInactive;

    nxcRemoveDependingOn(bemServerEngine);
    bemServerEngine := aEngine;
    nxcAddDependingOn(bemServerEngine);
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxBaseEngineMonitor.Create(aOwner: TComponent);
begin
  bemExtendersLock := TnxPadlock.Create(True);
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseEngineMonitor.Destroy;
begin
  inherited;
  nxFreeAndNil(bemExtendersLock);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.ExtendableObjectCreated(aExtendableObject : TnxExtendableServerObject);
begin
  {can be overridden}
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.ExtendableObjectDestroyed(aExtendableObject: TnxExtendableServerObject);
begin
  {can be overridden}
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.nxcNotification(aSender    : TnxComponent;
                                               aOperation : TnxNotifyOp;
                                               aParam     : Pointer);
begin
  inherited;
  if (aSender = bemServerEngine) and (aOperation = nxn_Destroy) then
    bemServerEngine := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.scDependentStateChange(aSender   : TnxStateComponent;
                                                      aBefore   : Boolean;
                                                      aOldState : TnxState;
                                                      aNewState : TnxState);
begin
  if (aSender = bemServerEngine) and  (nxStateTransitionDiagram[aOldState, aNewState] = nxstStopping ) and not aBefore then
    ServerEngineStopped;

  inherited;

  if (aSender = bemServerEngine) and  (nxStateTransitionDiagram[aOldState, aNewState] = nxstStarting ) and aBefore then
    ServerEngineStarting;
end;
{------------------------------------------------------------------------------}
function TnxBaseEngineMonitor.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result := (aComponent = bemServerEngine) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.scStopping;
begin
  inherited;

  bemExtendersLock.Lock;
  try
    while Assigned(bemExtendersHead) do
      bemExtendersHead.Free;
  finally
    bemExtendersLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.ServerEngineStarting;
begin
  {can be overriden}
end;
{------------------------------------------------------------------------------}
procedure TnxBaseEngineMonitor.ServerEngineStopped;
begin
  {can be overriden}
end;
{==============================================================================}



{===TnxAbstractSecurityMonitor=================================================}
function TnxAbstractSecurityMonitor.nxcCreateComponentInfo: InxInterface;
begin
  Result := TnxAbstractSecurityMonitorComponentInfo.Create(Self);
end;
{------------------------------------------------------------------------------}
class function TnxAbstractSecurityMonitor.nxcExceptionClass: EnxComponentExceptionClass;
begin
  Result := EnxAbstractSecurityMonitorException;
end;
{------------------------------------------------------------------------------}
function TnxAbstractSecurityMonitor.UiStateVisible: Boolean;
begin
  Result := False;
end;
{==============================================================================}



{===TnxAbstractSecurityMonitorComponentInfo====================================}
constructor TnxAbstractSecurityMonitorComponentInfo.Create(aAbstractSecurityMonitor: TnxAbstractSecurityMonitor);
begin
  inherited Create(aAbstractSecurityMonitor);
end;
{------------------------------------------------------------------------------}
function TnxAbstractSecurityMonitorComponentInfo.LogIn(const aUserName : UnicodeString;
                                                       const aPassword : UnicodeString)
                                                                       : InxLoggedInUser31000;
begin
  Result := TnxAbstractSecurityMonitor(ciComponent).LogIn(aUserName, aPassword);
end;
{==============================================================================}



{===TnxSqlAbstractDatabase=====================================================}
function TnxSqlAbstractDatabase.sadGetAlias: UnicodeString;
begin
  Result := '';
end;
{==============================================================================}



{===TnxSqlAbstractCursor=======================================================}
destructor TnxSqlAbstractCursor.Destroy;
var
  Lock: TnxPadlock;
begin
  if Assigned(sbcOnRequestCloseLock) then begin
    sbcOnRequestCloseLock.Lock;
    try
      sbcOnRequestClose := nil;
    finally
      Lock := sbcOnRequestCloseLock;
      sbcOnRequestCloseLock := nil;
      Lock.Unlock;
      nxFreeAndNil(Lock);
    end;
  end;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSqlAbstractCursor.sacGetOpenMode: TnxOpenMode;
begin
  Result := omReadOnly;
end;
{------------------------------------------------------------------------------}
function TnxSqlAbstractCursor.sacIsWrapper: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxSqlAbstractCursor.sbcGetOnRequestClose: InxRequestCloseHandler;
begin
  if Assigned(sbcOnRequestCloseLock) and not asoDestroying then begin
    sbcOnRequestCloseLock.Lock;
    try
      Result := sbcOnRequestClose;
    finally
      sbcOnRequestCloseLock.Unlock;
    end;
  end else
    Result := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlAbstractCursor.sbcSetOnRequestClose(aHandler: InxRequestCloseHandler);
begin
  if asoDestroying then
    Exit;
  TnxPadlock.CreateAndLock(sbcOnRequestCloseLock, True);
  try
    sbcOnRequestClose := aHandler;
  finally
    sbcOnRequestCloseLock.Unlock;
  end;
end;
{==============================================================================}


{===TnxRequestCloseHandlerEvent================================================}
type
  TnxRequestCloseHandlerEvent = class(TnxInterfacedObject, InxRequestCloseHandler, InxRequestCloseHandlerEvent)
  protected {private}
    rcheEvent        : TNotifyEvent;
    rcheDisconnected : Boolean;
  protected
    {--- InxRequestCloseHandler ---}
    procedure RequestClose(Sender: TObject);
    {--- InxRequestCloseHandlerEvent ---}
    procedure Disconnect;
  public
    constructor Create(aEvent: TNotifyEvent);
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
constructor TnxRequestCloseHandlerEvent.Create(aEvent: TNotifyEvent);
begin
  rcheEvent := aEvent;
  if not Assigned(rcheEvent) then
    rcheDisconnected := True;

end;
{------------------------------------------------------------------------------}
procedure TnxRequestCloseHandlerEvent.Disconnect;
begin
  rcheDisconnected := True;
end;
{------------------------------------------------------------------------------}
procedure TnxRequestCloseHandlerEvent.RequestClose(Sender: TObject);
begin
  if not rcheDisconnected then
    rcheEvent(Sender);
end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function nxRequestCloseHandlerEvent(aEvent: TNotifyEvent): InxRequestCloseHandlerEvent;
begin
  Result := TnxRequestCloseHandlerEvent.Create(aEvent);
end;
{------------------------------------------------------------------------------}



{===TnxSessionStats====================================================}
threadvar
  _SessionStatsCurrent    : TnxSessionStats;
var
  _SessionStatsHeadLock   : TnxPadlock;
  _SessionStatsHead       : TnxSessionStats;
  _SessionStatsNextNumber : Integer;
  _CounterFrequencey      : Int64;
  {$IFDEF SessionStatsDebug}
  //minutes since server start
  _LastTimeDumpDebugToFile: Integer;
  {$ENDIF SessionStatsDebug}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxSessionStats.assUpdateFromThread(aKeepCounting: Boolean);
var
  ExitTime        : Int64;
  ExitThreadCycle : UInt64;

  IntervalTime        : Int64;
  IntervalThreadCycle : Int64;
begin
  _QueryThreadCycleTime(assCurrentThread, ExitThreadCycle);
  QueryPerformanceCounter(ExitTime);

  IntervalTime := ExitTime - assEnterTime;
  IntervalThreadCycle := ExitThreadCycle - assEnterThreadCycle;

  assCounters[sscTime] := assCounters[sscTime] + IntervalTime;
  assCounters[sscCycles] := assCounters[sscCycles] + IntervalThreadCycle;

  if aKeepCounting then begin
    assEnterTime := ExitTime;
    assEnterThreadCycle := ExitThreadCycle
  end else begin
    assEnterTime := 0;
    assEnterThreadCycle := 0;
  end;
end;

procedure TnxSessionStats.Close;
begin
  if _SessionStatsCurrent = Self then
    _SessionStatsCurrent := nil;

  if assClosed <> 0 then
    Exit;

  assLock.Lock;
  try
    if assCurrentThread <> 0 then
      Leave;

    assClosed := Now;

    nxCloseHandleAndNull(assCurrentThread);
  finally
    assLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
class procedure TnxSessionStats.Count(aCounter: TnxSessionStatsCounter; aCount: Int64 = 1);
var
  Stats: TnxSessionStats;
begin
  Stats := _SessionStatsCurrent;
  if Assigned(Stats) then begin
    Stats.assLock.Lock;
    try
      Inc(Stats.assCounters[aCounter], aCount);
    finally
      Stats.assLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxSessionStats.Create(const aUserName, aConnectedFrom: string; aHeartbeatInterval: TnxWord32);
begin
  assLock := TnxPadlock.Create(True);
  assStarted := Now;
  assUserName := aUserName;
  assConnectedFrom := aConnectedFrom;
  assHeartbeatInterval := aHeartbeatInterval;
  inherited Create;
  _SessionStatsHeadLock.Lock;
  try
    assNext := _SessionStatsHead;
    assSessionNumber := _SessionStatsNextNumber;
    Inc(_SessionStatsNextNumber);
    _SessionStatsHead := Self;

    {$IFDEF SessionStatsDebug}
    var OldMins := _LastTimeDumpDebugToFile;
    var NewMins := MinutesBetween(Now, StartSessionStatsTime);
    if (OldMins {+ 1} < NewMins) and
       (LockedCompareExchange(_LastTimeDumpDebugToFile, OldMins + 1, OldMins) = OldMins) then begin
      DumpDebugToFile;
    end;
    {$ENDIF SessionStatsDebug}

  finally
    _SessionStatsHeadLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSessionStats.Current: TnxSessionStats;
begin
  Result := _SessionStatsCurrent;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionStats.Enter;
begin
  if assClosed <> 0 then
    Exit;

  assLock.Lock;
  try
    Assert(assCurrentThread = 0);
    if not DuplicateHandle(GetCurrentProcess, GetCurrentThread, GetCurrentProcess, @assCurrentThread, 0, False, DUPLICATE_SAME_ACCESS) then
      RaiseLastOSError;

    _QueryThreadCycleTime(assCurrentThread, assEnterThreadCycle);
    QueryPerformanceCounter(assEnterTime);

    Inc(assCounters[sscCalls]);

    _SessionStatsCurrent := Self;
  finally
    assLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
class function TnxSessionStats.Head: TnxSessionStats;
begin
  _SessionStatsHeadLock.Lock;
  try
    Result := _SessionStatsHead;
  finally
    _SessionStatsHeadLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF SessionStatsDebug}
procedure TnxSessionStats.DumpDebugToFile;
var
  Stat    : TnxSessionStats;
  FS      : TFileStream;
  SS      : TStringStream;
  Counter : TnxSessionStatsCounter;
begin
  try
    FS := TFileStream.Create(
      ChangeFileExt(
    {$IFDEF NX_EXCEPTION_LOG_IN_APP_FOLDER}
        ParamStr(0)
    {$ELSE}
        nxAppHomeDirectory(nxAppDataSubdirVista) + ExtractFileName(ParamStr(0))
    {$ENDIF}
        , '') + 'SessionStats.Log', fmCreate or fmShareDenyWrite);
    SS := TStringStream.Create('', TEncoding.UTF8);
    SS.WriteString(
      'NUMBER,STARTED,CLOSED,USERNAME,CONNECTED_FROM,HEARTBEAT_INTERVAL,CLIENT_INFO,' +
      'EXECUTED_CALLS,' +
      'EXECUTED_QUERIES,' +
      'EXECUTED_FOR_MSEC,' +
      'EXECUTED_FOR_CYCLES,' +
      'BLOCKS_READ,' +
      'BLOCKS_WRITTEN,' +
      'TRANSACTIONS_COMMIT,' +
      'TRANSACTIONS_ROLLBACK,' +
      'TRANSACTIONS_NESTED_COMMIT,' +
      'TRANSACTIONS_NESTED_ROLLBACK,' +
      'TRANSACTIONS_DEADLOCK,' +
      'TRANSACTIONS_CORRUPTED' + #13#10);

    Stat := TnxSessionStats.Head;
    while Assigned(Stat) and
         (Stat.assStarted >= Now - OneHour * 8) do begin

      Stat.Update;

      var s : string :=
        Stat.assSessionNumber.ToString + ', ' +
        FormatDatetime('yyyy-mm-dd hh:nn:ss.zzz', Stat.assStarted) + ', ' +
        IfThen(Stat.assClosed > StartSessionStatsTime,
               FormatDatetime('yyyy-mm-dd hh:nn:ss.zzz', Stat.assClosed),
               '') + ', ' +
        Stat.assUserName + ', ' +
        Stat.ConnectedFrom + ', ' +
        Stat.assHeartbeatInterval.ToString + ', ' +
        Stat.assClientInfo + ', ';

      for Counter := Low(Counter) to High(Counter) do
        s := s + Stat.assCounters[Counter].ToString + IfThen(Counter = High(Counter), '', ', ');
      s := s + #13#10;
      SS.WriteString(s);

     Stat := Stat.Next;
    end;

    SS.Position := 0;
    FS.CopyFrom(SS);
    FS.Free;
    SS.Free;

  except
    //ignore, do not prevent session from starting
  end
end;
{$ENDIF SessionStatsDebug}
{------------------------------------------------------------------------------}
procedure TnxSessionStats.Leave;
begin
  if _SessionStatsCurrent = Self then
    _SessionStatsCurrent := nil;

  if assClosed <> 0 then
    Exit;

  assLock.Lock;
  try
    assUpdateFromThread(False);
    nxCloseHandleAndNull(assCurrentThread);
  finally
    assLock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
class procedure TnxSessionStats.SetClientInfo(const aClientInfo: string);
var
  Stats: TnxSessionStats;
begin
  Stats := _SessionStatsCurrent;
  if Assigned(Stats) then begin
    Stats.assLock.Lock;
    try
      Stats.assClientInfo := aClientInfo;
    finally
      Stats.assLock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSessionStats.Update: TnxSessionStatsCounters;
begin
  assLock.Lock;
  try
    if assCurrentThread <> 0 then
      assUpdateFromThread(True);

    assExtClosed := assClosed;
    Result := assCounters;
    Result[sscTime] := Trunc(Result[sscTime] / (_CounterFrequencey/1000));
  finally
    assLock.Unlock;
  end;
end;
{==============================================================================}



{==============================================================================}
function nxCursorOpenOptionsToString(aOptions: TnxCursorOpenOptions): string;
var
  Option: TnxCursorOpenOption;
begin
  Result := '';
  for Option := Low(Option) to High(Option) do
    if Option in aOptions then begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + GetEnumName(TypeInfo(TnxCursorOpenOption), Ord(Option));
    end;
end;
{==============================================================================}


{==============================================================================}
procedure nxEnableFeature(aFeature: TnxFeature);
begin
  Include(nxFeatures, aFeature);
end;
{------------------------------------------------------------------------------}
procedure nxEnableFeatures(aFeatures: TnxFeatures);
begin
  nxFeatures := nxFeatures + aFeatures;
end;
{------------------------------------------------------------------------------}
procedure nxDisableFeature(aFeature: TnxFeature);
begin
  Exclude(nxFeatures, aFeature);
end;
{------------------------------------------------------------------------------}
procedure nxDisableFeatures(aFeatures: TnxFeatures);
begin
  nxFeatures := nxFeatures - aFeatures;
end;
{==============================================================================}


initialization
  QueryPerformanceFrequency(_CounterFrequencey);
  _SessionStatsHeadLock := TnxPadlock.Create(True);
  LoadQueryThreadCycleTime;
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  {$IFDEF SessionStatsDebug}
  _LastTimeDumpDebugToFile := 0;
  StartSessionStatsTime := Now;
  {$ENDIF SessionStatsDebug}
finalization
  nxFreeAndNil(_SessionStatsHeadLock);
end.
