{##############################################################################}
{# NexusDB: nxsrServerEngine.pas 4.7516                                      #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: base server engine classes                                        #}
{##############################################################################}
{$I nxDefine.inc}
{$DEFINE NX_USE_ITERATE_FOR_RECORDGETBATCH}

unit nxsrServerEngine;

interface

uses
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Winapi.ActiveX{$ELSE}ActiveX{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Winapi.Windows{$ELSE}Windows{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Classes{$ELSE}Classes{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Contnrs{$ELSE}Contnrs{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Math{$ELSE}Math{$ENDIF},
  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  System.Threading,
  {$ENDIF}
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.SysUtils{$ELSE}SysUtils{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Types{$ELSE}Types{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.TypInfo{$ELSE}TypInfo{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Variants{$ELSE}Variants{$ENDIF},
  nxllBde,
  nxllBdeStrings,
  nxllComponent,
  nxllConst,
  nxllException,
  nxllFastMove,
  nxllList,
  nxllLockedFuncs,
  nxllMemoryManager,
  nxllStreams,
  nxllSync,
  nxllThread,
  nxllTypes,
  nxllUtils,
  nxllWideString,
  nxsdConst,
  nxsdDataDictionary,
  nxsdDataDictionaryRefInt,
  nxsdDataDictionaryDataPolicies,
  nxsdDefaultValueEngine,
  nxsdFieldMapper,
  nxsdFilterDescriptorBase,
  nxsdFilterEngineBase,
  nxsdFilterEngineCallback,
  nxsdFilterEngineHub,
  nxsdKeyEngineBase,
  nxsdKeyEngineComp,
  nxsdKeyEngineRef,
  nxsdKeyEngineToken,
  nxsdKeyEngineInt64,
  nxsdKeyEngineBlobCache,
  nxsdRecordMapperDescriptorBase,
  nxsdRecordMapperEngineBase,
  nxsdServerEngine,
  nxsdTableMapperDescriptor,
  nxsdTableMapperDescriptorBase,
  nxsdTypes,
  nxsdValidationEngine,
  nxsrAutoIncEngineBase,
  nxsrBlobEngineBase,
  nxsrBlobHandlerBase,
  nxsrBlobHandlerPassthrough,
  nxsrBufferManager,
  nxsrDataDictionary,
  nxsrEncryptionEngineBase,
  nxsrFieldMapperEngine,
  nxsrFileHandling,
  nxsrFileImplWin32,
  nxsrFulltextEngineBase,
  nxsrIndexEngineBase,
  nxsrRecordEngineBase,
  nxsrRecordMapperEngine,
  nxsrRefIntEngineBase,
  nxsrSqlEngineBase,
  nxsrStreamEngineBase,
  nxsrStrings,
  nxsrSubEngineBase,
  nxsrTableLockContainer,
  nxsrTemporaryStorageBase,
  nxsrTimeoutHandling,
  nxsrTypes;

//DOM-IGNORE-BEGIN
resourcestring
  rsTransactionIsInUse = 'The current transaction level is in use. Can''t commit or rollback';
  rsInsertDeniedDataPolicies = 'Insert operation denied by Data Policies';
  rsModifyDeniedDataPolicies = 'Modify operation denied by Data Policies';
  rsDeleteDeniedDataPolicies = 'Delete operation denied by Data Policies';
  rsInsertDeniedMaxRecords = 'Insert denied: MaxRecordCount limit reached in Data Policies';
  rsDeleteDeniedMinRecords = 'Delete denied: MinRecordCount limit would be violated in Data Policies';

// include nxseAllEngines
(*$HPPEMIT 'namespace Nxsrserverengine'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'class DELPHICLASS TnxServerBaseCursor;'*)
(*$HPPEMIT 'class DELPHICLASS TnxServerDatabase;'*)
(*$HPPEMIT '}'*)
(*$HPPEMIT '#include <nxseAllEngines.hpp>'*)
(*$HPPEMIT '#pragma link "nxseAllEngines"'*)

const
  MaxInactiveFolderCount = 16;
  MaxInactiveFolderTime = (1/24) * 16; {16 hours}
  {$NODEFINE MaxInactiveFolderTime}

  MaxInactiveTableCount = 256;
  MaxInactiveTableTime = (1/24) * 20; {20 hours}
  {$NODEFINE MaxInactiveTableTime}

  // To avoid a const Extended which causes problems when trying to use this unit for PreCompiled Headers
  (*$NODEFINE MaxInactiveFolderTime*)
  (*$NODEFINE MaxInactiveTableTime*)

const
  nxc_StartTranWithDelay : TnxWord32 = 10;
  nxc_NumBlobBytesToCopy             = nxcl_1MB;

  nxcPackBaseName                    = '$PACK';
  nxcRestBaseName                    = '$REST';

var
  nxc_ConfigFile         : string    = 'nxTrans.cfg';

type
  EnxServerEngineException = class(EnxServerException);

  TnxServerEngine = class;

  TnxServerSession = class;
  TnxServerFolder = class;
  TnxServerDatabase = class;
  TnxServerTransContext = class;
  TnxServerBaseTable = class;
  TnxServerBaseTables = array of TnxServerBaseTable;
  TnxServerRootTable = class;
  TnxServerBaseCursor = class;
  TnxServerTableCursor = class;
  TnxServerStatement = class;
  TnxServerTransactionLevelTableLink = class;

  TnxServerTaskInfo = class(TnxSqlAbstractTaskInfo)
  protected {private}
    stiThreadPriority : TThreadPriority;

    stiPadlock        : TnxPadlock;
    stiStatus         : TnxTaskStatus;
    stiCancelled      : Boolean;
    stiExecuting      : Boolean;
    stiStartEvt       : TnxEvent;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  public
    constructor Create(aSession        : TnxServerSession;
                       aTotalRecords   : TnxWord32;
                       aThreadPriority : TThreadPriority = tpNormal);
    destructor Destroy; override;

    {-- TnxAbstractTaskInfo --}
    function GetStatus(out aCompleted : Boolean;
                       out aStatus    : TnxTaskStatus)
                                      : TnxResult; override;

    function Cancel: TnxResult; override;

    {-- TnxServerTaskInfo --}
    procedure Init; virtual;

    function MakeSnapshot(aRecordsRead    : TnxWord32;
                          aRecordsWritten : TnxWord32;
                          aErrorCode      : TnxResult)
                                          : Boolean;
    procedure MarkFinished;
  end;

  TnxServerDoNothingTaskInfo = class(TnxServerTaskInfo)
  public
    {-- TnxServerTaskInfo --}
    procedure Execute; override;
  end;

  TnxServerSessionClass = class of TnxServerSession;
  TnxServerSession = class(TnxAbstractSession)
  protected {private}
    ssClientVersion              : Integer;
    ssPasswords                  : TnxUnicodeStrings;
    ssClientDefaultLocale        : TnxLocaleDescriptor;
    ssClientDefaultLocaleChecked : Boolean;
    function asGetClientVersion: Integer; override;
    function asGetClientDefaultLocale: TnxLocaleDescriptor; override;
    procedure ssInitClientDefaultLocale;
  protected
    function ssBuildPasswords(const aAlias    : UnicodeString;
                              const aTable    : UnicodeString;
                              const aPassword : UnicodeString)
                                              : TnxUnicodeStrings;

  public {protected}
    function ssDoDatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                            const aAliasType    : string;
                            const aAlias        : string;
                                  aTransContext : TnxAbstractTransContext;
                                  aOpenMode     : TnxOpenMode;
                                  aShareMode    : TnxShareMode;
                                  aTimeout      : TnxWord32;
                                  aIsCache      : Boolean)
                                                : TnxResult;

    function ssDatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                          const aAlias        : string;
                                aTransContext : TnxAbstractTransContext;
                                aFolder       : TnxServerFolder;
                                aOpenMode     : TnxOpenMode;
                                aShareMode    : TnxShareMode;
                                aIgnoreShare  : Boolean;
                                aTimeout      : TnxWord32)
                                              : TnxResult;

    {-- password management --}
    function ssPasswordAdd(const aPassword : UnicodeString)
                                           : TnxResult;
    function ssPasswordRemove(const aPassword : UnicodeString)
                                              : TnxResult;
    function ssPasswordRemoveAll: TnxResult;
  public
    constructor Create(aServerEngine  : TnxServerEngine;
                       aTimeout       : TnxWord32;
                 const aUserName      : UnicodeString;
                 const aPassword      : UnicodeString;
                 const aConnectedFrom : string;
                       aClientVersion : Integer); virtual;
    destructor Destroy; override;

    {-- alias managment --}
    function AliasAdd(const aAlias   : string;
                      const aPath    : string;
                            aEnforce : Boolean)
                                   : TnxResult; override;
    function AliasDelete(const aAlias : string)
                                      : TnxResult; override;
    function AliasModify(const aAlias   : string;
                         const aNewName : string;
                         const aNewPath : string;
                               aEnforce : Boolean)
                                        : TnxResult; override;

    function AliasGetList(aList : TObjectList)
                                : TnxResult; override;
    function AliasGetPath(const aAlias : string;
                            out aPath  : string)
                                       : TnxResult; override;

    {-- password management --}
    function PasswordAdd(const aPassword : UnicodeString)
                                         : TnxResult; override;
    function PasswordRemove(const aPassword : UnicodeString)
                                            : TnxResult; override;
    function PasswordRemoveAll: TnxResult; override;

    {-- table/folder managment --}
    function CloseInactiveFolders : TnxResult; override;
    function CloseInactiveTables : TnxResult; override;

    {-- database managment --}
    function DatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                        const aAliasType    : string;
                        const aAlias        : string;
                              aTransContext : TnxAbstractTransContext;
                              aOpenMode     : TnxOpenMode;
                              aShareMode    : TnxShareMode;
                              aTimeout      : TnxWord32)
                                            : TnxResult; override;

    function DatabaseCacheOpen(out aDatabase     : TnxAbstractDatabase;
                             const aAliasType    : string;
                             const aAlias        : string;
                                   aTransContext : TnxAbstractTransContext;
                                   aOpenMode     : TnxOpenMode;
                                   aShareMode    : TnxShareMode;
                                   aTimeout      : TnxWord32)
                                                 : TnxResult; override;

    {-- transaction context managment --}
    function TransContextCreate(out aTransContext : TnxAbstractTransContext;
                                    aTimeout      : TnxWord32)
                                                  : TnxResult; override;

    {-- engine managment --}
    { This function returns a list of registered engines of the requested type. }
    function GetRegisteredClassList(const aClassListType : TnxClassListType;
                                          aList          : TStrings)
                                                         : TnxResult; override;

    {-- internal --}
    { This function disconnects the session forcefully }
    procedure Kick;
  end;

  TnxServerTransactionMgr = class(TnxBaseTransactionMgr)
  protected {private}
    stmFolder     : TnxServerFolder;

    stmConfigFile : TnxBaseFile;
  protected
    function btmGetJournalEngineFor(aTransaction : TnxBaseTransaction)
                                                 : TnxBaseJournalEngine; override;

    function stmGetLSNForTable(const FullTableName : string)
                                                   : TnxLSN;
    function stmGetLSNFromTables: TnxLSN;

    function  stmValidConfigFile: Boolean;
    procedure stmReadConfig;
    procedure stmWriteConfig(aCloseFile : Boolean);
  public
    constructor Create(aFolder   : TnxServerFolder);
    destructor Destroy; override;
  end;

  TnxServerFolder = class(TnxLockedOptionsExtendableServerObject)
  protected {private}
    sfServerEngine     : TnxServerEngine;
    sfPath             : string;
    sfInMemOnly        : Boolean;
    sfReadOnly         : Boolean;
    sfJournalChecked   : Boolean;

    sfInMemoryCount    : Integer;

    stTransManager     : TnxServerTransactionMgr;
    sfForceFailSafe    : Boolean;

    sfDatabasesPadlock : TnxPadlock;
    sfDatabasesHead    : TnxServerDatabase;
    sfDatabasesTail    : TnxServerDatabase;

    sfTablesPadlock    : TnxPadlock;
    sfTables           : TStringList;

    {uses sfTablesPadlock}
    sfInactiveSince                   : TDateTime;
    sfInServerEngineInactiveFolders   : Boolean;
    sfServerEngineInactiveFoldersPrev : TnxServerFolder;
    sfServerEngineInactiveFoldersNext : TnxServerFolder;

    sfLockedIncDone    : Boolean;
    sfIsCache          : Boolean;

    sfStructureGeneration       : Integer;

    procedure sfUpdateIsInactive;
    procedure sfServerEngineAddToInactiveFolders;
    procedure sfServerEngineRemoveFromInactiveFolders;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    function asoGetServerEngine: TnxBaseServerEngine; override;

    procedure sfAddToServerEngine;
    procedure sfRemoveFromServerEngine;

    function sfTableBuildPrim(const aTableName  : string;
                              const aPassword   : UnicodeString;
                                    aForServer  : Boolean;
                                    aDictionary : TnxDataDictionary;
                                    aTableScope : TnxTableScope;
                                out aTable      : TnxServerRootTable)
                                                : TnxResult;
  public {protected}
    function sfIsInactive(aIgnoreKeepInMemory : Boolean;
                          aRequestClose       : Boolean)
                                              : Boolean;
    function sfCloseInactiveTables : TnxResult;

    function sfTableBuild(aOverWrite  : Boolean;
                    const aTableName  : string;
                    const aPassword   : UnicodeString;
                          aForServer  : Boolean;
                          aDictionary : TnxDataDictionary;
                          aTableScope : TnxTableScope)
                                      : TnxResult;

    function sfTableExists(const aTableName : string)
                                            : TnxResult;
    function sfTableMakeUniqueName(const aBaseName  : string;
                                     out aTableName : string)
                                                    : TnxResult;
    function sfTableGetDictionary(const aTableName : string;
                                        aPasswords : TnxUnicodeStrings;
                                        aForServer : Boolean;
                                        aDict      : TnxDataDictionary;
                                        aFileIsLink: PBoolean = nil;
                                        aPassword  : PUnicodeString = nil)
                                                   : TnxResult;
    function sfTableGetList(aList : TStrings)
                                  : TnxResult;

    function sfTableDelete(const aTableName : string;
                                 aPasswords : TnxUnicodeStrings;
                                 aForServer : Boolean)
                                            : TnxResult;
    function sfTableEmpty(const aTableName : string;
                                aPasswords : TnxUnicodeStrings;
                                aForServer : Boolean)
                                           : TnxResult;
    function sfTableRename(const aOldName   : string;
                           const aNewName   : string;
                                 aPasswords : TnxUnicodeStrings;
                                 aForServer : Boolean)
                                            : TnxResult;
  public
    constructor Create(aServerEngine : TnxServerEngine;
                 const aPath         : string;
                       aIsCache      : Boolean);
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LockTables;
    procedure UnlockTables;

    property Path : String
      read sfPath;
    property IsCache : Boolean
      read sfIsCache
      write sfIsCache;
  end;

  PnxServerTransaction = ^TnxServerTransaction;
  TnxServerTransaction = class(TnxBaseTransaction)
  protected {private}
    stTableLinks : TStringList;
  protected
    function btGetTransactionLevelClass: TnxTransactionLevelClass; override;
  public
    stForceNested : Integer;
    constructor Create(aBufferManager         : TnxBufferManager;
                       aOwningSession         : TObject;
                       aSnapshot              : Boolean;
                       aFailSafe              : Boolean;
                       aOverrideForceFailsafe : Boolean = False);
    destructor Destroy; override;

    procedure Commit; override;
    procedure Rollback; override;

    function stGetInfo: TnxTransactionInfo;
  end;

  TnxServerTransContextOwnedTransaction = class(TnxServerTransaction)
  protected {private}
    stcotTransContext : TnxServerTransContext;
  public
    constructor Create(aTransContext          : TnxServerTransContext;
                       aSnapshot              : Boolean;
                       aFailSafe              : Boolean;
                       aOverrideForceFailsafe : Boolean = False);
    destructor Destroy; override;
  end;

  TnxServerTransactionLevel = class(TnxBaseTransactionLevel)
  protected {private}
    stlTableLinksHead : TnxServerTransactionLevelTableLink;
    stlTableLinksTail : TnxServerTransactionLevelTableLink;
  protected
    procedure stlRollbackLocks;
    procedure stlRollbackEngines;
    procedure stlDeadlockDetected;

    function stlGetInfo: TnxTransactionLevelInfo;
  end;

  TnxServerTransactionLevelTableLinkState =
    (ttlsPending, ttlsPendingUpgrade, ttlsGranted, ttlsFailed);

  TnxServerTransactionLevelTableLink = class(TnxObject)
  protected {private}
    ttlReason               : TnxLockFailureReason;

    ttlTransactionAdded     : Boolean;

    ttlTransactionLevelAdded: Boolean;
    ttlTransactionLevel     : TnxServerTransactionLevel;
    ttlTransactionLevelPrev : TnxServerTransactionLevelTableLink;
    ttlTransactionLevelNext : TnxServerTransactionLevelTableLink;

    ttlTableAdded           : Boolean;
    ttlTable                : TnxServerRootTable;
    ttlTablePrev            : TnxServerTransactionLevelTableLink;
    ttlTableNext            : TnxServerTransactionLevelTableLink;
    ttlState                : TnxServerTransactionLevelTableLinkState;

    ttlExclusive            : Boolean;
    ttlSnapshot             : Boolean;

    ttlConvertFrom          : TnxServerTransactionLevelTableLink;
    ttlConvertTo            : TnxServerTransactionLevelTableLink;

    ttlEvent                : TnxEvent;

    ttlCursorsHead          : TnxServerTableCursor;
    ttlCursorsTail          : TnxServerTableCursor;
  protected
    procedure ttlUpgradeCompleted;

    procedure ttlAddToTransaction;
    procedure ttlRemoveFromTransaction;

    procedure ttlAddToTransactionLevel;
    procedure ttlRemoveFromTransactionLevel;

    procedure ttlAddToTable;
    procedure ttlRemoveFromTable;
  public
    constructor Create(aTransactionLevel : TnxServerTransactionLevel;
                       aTable            : TnxServerRootTable;
                       aExclusive        : Boolean;
                       aConvertFrom      : TnxServerTransactionLevelTableLink;
                       aReason           : TnxLockFailureReason);
    destructor Destroy; override;

    function WaitFor: TnxResult;
  end;

  TnxBlobLinkHandler = class;

  InxTableMapper = interface(InxInterface)
  ['{C3BF5477-9EEF-4BD2-B279-A0C6B4C162A3}']
    function Lock: TStringList;
    procedure Unlock;

    function Contains(const aTableName : string)
                                       : Boolean;

    function GetMappings: TStringList;

    property Mappings: TStringList
      read GetMappings;
  end;

  TnxServerDatabaseCursorSourceContainer = class(TnxInterfacedObject, InxDatabaseCursorSourceControl)
  protected {private}
    cscLock         : InxSimpleLock;

    cscDatabase     : TnxServerDatabase;
    cscDatabasePrev : TnxServerDatabaseCursorSourceContainer;
    cscDatabaseNext : TnxServerDatabaseCursorSourceContainer;

    cscSource       : InxDatabaseCursorSource;

    procedure cscAddToDatabase;
    procedure cscRemoveFromDatabase;
  public
    constructor Create(aDatabase : TnxServerDatabase;
                       aSource   : InxDatabaseCursorSource);
    destructor Destroy; override;

    procedure CursorOpen(out aCursor    : TnxAbstractCursor;
                       const aTableName : string;
                         var aResult    : TnxResult);

    {---InxDatabaseCursorSourceControl---}
    function Unregister: TnxResult;
  end;

  TnxServerDatabase = class(TnxSqlAbstractDatabase, InxAbstractDatabase31000)
  protected {private}
    sdAlias            : string;
    sdFolder           : TnxServerFolder;
    sdTables           : InxTableMapper;

    sdIsCache          : Boolean;

    sdFolderPrev       : TnxServerDatabase;
    sdFolderNext       : TnxServerDatabase;

    sdCursorSourceHead : TnxServerDatabaseCursorSourceContainer;
    sdCursorSourceTail : TnxServerDatabaseCursorSourceContainer;

    sdForceFailSafe    : Boolean;

    sdBlobLinkHandler  : TnxBlobLinkHandler;

    sdLastCheckLSN     : TnxLSN;

    sdStructureGeneration       : Integer;
    sdFolderStructureGeneration : Integer;

    function adGetIsCache: Boolean; override;
  protected
    function sadGetAlias: UnicodeString; override;

    procedure sdAddToFolder;
    procedure sdRemoveFromFolder;

    function sdGetStructureGeneration: Integer;
    procedure sdStructureGenerationInc(aIsGlobal: Boolean);

    function sdTablesNeedingPackIterator(aDictionary: TnxDataDictionary; aCookie: Pointer): TnxIteratorResult;

    {--- InxExceptionData ---}
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    {---InxAbstractDatabase31000 ---}
    function GetTablesNeedingPack: TnxUnicodeStrings;

    {=== remoting integration ===}
    function asoCreateInstance(const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;
   public {protected}
    procedure sadLockTables; override;
    procedure sadUnlockTables; override;

    function sdBuildPasswords(const aTable    : UnicodeString;
                              const aPassword : UnicodeString)
                                              : TnxUnicodeStrings;

    function sdGetTable(out aTable     : TnxServerBaseTable;
                      const aTableName : string;
                      const aPassword  : UnicodeString;
                            aForServer : Boolean;
                        out aIsReadOnly: Boolean;
                            aInternal  : Boolean;
                            aIsCache   : Boolean)
                                       : TnxResult;

    function sdIterateDictionaries(aIterator    : TnxDictionaryIterator;
                                   aAllowSystem : Boolean;
                                   aIgnoreError : Boolean;
                                   aCookie      : Pointer)
                                                : TnxIteratorResult; override;

    {-- options --}
    function esoOptionGetParent(const aName  : string;
                                  out aValue : string)
                                             : TnxResult; override;
    function esoOptionListParent(aList : TStrings)
                                       : TnxResult; override;

    {-- cursor --}
    function sdCursorOpen(out aCursor       : TnxAbstractCursor;
                              aTransContext : TnxAbstractTransContext;
                        const aTableName    : string;
                        const aPassword     : UnicodeString;
                              aForServer    : Boolean;
                              aOpenMode     : TnxOpenMode;
                              aShareMode    : TnxShareMode;
                              aIgnoreExcl   : Boolean;
                              aTimeout      : TnxWord32;
                              aIndexName    : string;
                              aIndexID      : Integer;
                              aInternal     : Boolean;
                              aIsCache      : Boolean = False)
                                            : TnxResult;

    {-- statement --}
    function sdStatementAlloc(out aStatement : TnxAbstractStatement;
                                  aTimeout   : TnxWord32)
                                             : TnxResult;
    function sdStatementExecDirect(aTimeout         : TnxWord32;
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
                                                    : TnxResult;
    {-- table managmenet --}
    function sdTableBuild(aOverWrite  : Boolean;
                    const aTableName  : string;
                    const aPassword   : UnicodeString;
                          aDictionary : TnxDataDictionary;
                          aTableScope : TnxTableScope)
                                      : TnxResult;

    function sadCreateResultSet(aDictionary : TnxDataDictionary;
                                aTimeout    : TnxWord32)
                                            : TnxSqlAbstractCursor; override;

    function sdTableRebuildIndex(const aTableName : string;
                                 const aPassword  : UnicodeString;
                                 const aIndexName : string;
                                       aIndexID   : Integer;
                                   out aTaskInfo  : TnxAbstractTaskInfo)
                                                  : TnxResult; override;

    function sdTableRestructure(const aTableName   : string;
                                const aPassword    : UnicodeString;
                                      aDictionary  : TnxDataDictionary;
                                      aMapperDesc  : TnxBaseTableMapperDescriptor;
                                  out aTaskInfo    : TnxAbstractTaskInfo)
                                                   : TnxResult; override;

    function sdTableRecover(const aTableName : string;
                            const aPassword  : UnicodeString;
                              out aTaskInfo  : TnxAbstractTaskInfo)
                                             : TnxResult;

    function sdTableVerifyChecksum(const aTableName    : string;
                                   const aPassword     : UnicodeString;
                                         aRaw          : Boolean;
                                         aForceRecheck : Boolean;
                                     out aTaskInfo     : TnxAbstractTaskInfo)
                                                       : TnxResult;

    function sdTableRename(const aOldName : string;
                           const aNewName : string;
                           const aPassword: UnicodeString)
                                          : TnxResult;
    function sdTableDelete(const aTableName : string;
                           const aPassword  : UnicodeString)
                                            : TnxResult;

    {-- table information --}
    function sdTableExists(const aTableName : string;
                           const aPassword  : UnicodeString;
                                 aForServer : Boolean)
                                            : TnxResult;

    function sdTableGetDictionary(const aTableName  : string;
                                  const aPassword   : UnicodeString;
                                        aDictionary : TnxDataDictionary)
                                                    : TnxResult;
    function sdTableGetList(aList        : TStrings;
                            aAllowSystem : Boolean)
                                         : TnxResult;

    function sdGetChangedTables(aTables : TStrings)
                                        : TnxResult;
  public
    constructor Create(aSession      : TnxServerSession;
                       aTransContext : TnxServerTransContext;
                       aAlias        : string;
                       aFolder       : TnxServerFolder;
                       aTimeout      : TnxWord32;
                       aOpenMode     : TnxOpenMode;
                       aShareMode    : TnxShareMode);

    { see TObject.BeforeDestruction. }
    procedure BeforeDestruction; override;

    destructor Destroy; override;

    {-- cursor source --}

    function RegisterCursorSource(aSource  : InxDatabaseCursorSource;
                              out aControl : InxDatabaseCursorSourceControl)
                                           : TnxResult; override;

    {-- table managmenet --}
    function TableBuild(aOverWrite   : Boolean;
                  const aTableName   : string;
                  const aPassword    : UnicodeString;
                        aDictionary  : TnxDataDictionary;
                        aTableScope  : TnxTableScope;
                        aAllowSystem : Boolean = False)
                                     : TnxResult; override;

    function TablePack(const aTableName : string;
                       const aPassword  : UnicodeString;
                         out aTaskInfo  : TnxAbstractTaskInfo)
                                        : TnxResult; override;
    function TableBackup(const aTableName      : string;
                         const aPassword       : UnicodeString;
                               aTargetDatabase : TnxAbstractDataBase;
                           out aTaskInfo       : TnxAbstractTaskInfo)
                                               : TnxResult; override;
    function TableRebuildIndex(const aTableName : string;
                               const aPassword  : UnicodeString;
                               const aIndexName : string;
                                     aIndexID   : Integer;
                                 out aTaskInfo  : TnxAbstractTaskInfo)
                                                : TnxResult; override;
    function TableRestructure(const aTableName   : string;
                              const aPassword    : UnicodeString;
                                    aDictionary  : TnxDataDictionary;
                                    aMapperDesc  : TnxBaseTableMapperDescriptor;
                              const aAllowSystem : Boolean;
                                out aTaskInfo    : TnxAbstractTaskInfo)
                                                 : TnxResult; override;
    function TableAddField(const aTableName  : string;
                           const aPassword   : UnicodeString;
                                 aFieldDesc  : TnxFieldDescriptor)
                                             : TnxResult; override;
    function TableAddIndex(const aTableName  : string;
                           const aPassword   : UnicodeString;
                                 aIndexDesc  : TnxIndexDescriptor;
                                 aNewDefault : Boolean)
                                             : TnxResult; override;
    function TableDropIndex(const aTableName  : string;
                            const aPassword   : UnicodeString;
                            const aIndexName  : string;
                                  aIndexID    : Integer)
                                              : TnxResult; override;

    function TableRename(const aOldName  : string;
                         const aNewName  : string;
                         const aPassword : UnicodeString)
                                         : TnxResult; override;

    function TableDelete(const aTableName : string;
                         const aPassword  : UnicodeString)
                                          : TnxResult; override;
    function TableEmpty(const aTableName : string;
                        const aPassword  : UnicodeString)
                                         : TnxResult; override;

    function TableChangePassword(const aTableName   : string;
                                 const aOldPassword : UnicodeString;
                                 const aNewPassword : UnicodeString)
                                                    : TnxResult; override;

    function TableRecover(const aTableName : string;
                          const aPassword  : UnicodeString;
                            out aTaskInfo  : TnxAbstractTaskInfo)
                                           : TnxResult; override;

    function TableVerifyChecksum(const aTableName    : string;
                                 const aPassword     : UnicodeString;
                                       aRaw          : Boolean;
                                       aForceRecheck : Boolean;
                                   out aTaskInfo     : TnxAbstractTaskInfo)
                                                     : TnxResult; override;

    {-- table information --}
    function TableExists(const aTableName   : string;
                         const aPassword    : UnicodeString;
                           out aExists      : Boolean;
                               aAllowSystem : Boolean)
                                            : TnxResult; override;
    function TableGetDictionary(const aTableName  : string;
                                const aPassword   : UnicodeString;
                                      aDictionary : TnxDataDictionary)
                                                  : TnxResult; override;
    function TableGetList(aList : TStrings)
                                : TnxResult; override;

    function TableAutoIncGet(const aTableName  : string;
                             const aPassword   : UnicodeString;
                               out aValue      : TnxWord32)
                                               : TnxResult; override;

    function GetChangedTables(aTables : TStrings)
                                      : TnxResult; override;
    {-- cursor --}
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
                                           : TnxResult; override;
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
                                                : TnxResult; override;
    {-- statement --}
    function StatementAlloc(out aStatement : TnxAbstractStatement;
                                aTimeout   : TnxWord32)
                                           : TnxResult; override;
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
                                                  : TnxResult; override;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    {-- info --}
    { Changed the name from GetFreeSpace to GetFreespace to avoid name clashing in BCB }
    function GetFreespace(out aFreeSpace : TnxInt64)
                                         : TnxResult; override;
    function GetPath(out aPath : string)
                               : TnxResult; override;
    function GetAlias(out aAlias : string)
                                 : TnxResult; override;

    property Alias: string
      read sdAlias;

    property Folder: TnxServerFolder
      read sdFolder;

    property StructureGeneration: Integer
      read sdGetStructureGeneration;
  end;

  TnxServerTransContext = class(TnxAbstractTransContext)
  protected {private}
    stcTransactionPadlock : TnxPadLock;
    stcTransaction        : TnxServerTransaction;
    stcForceFailSafe      : Boolean;
  public {protected}
    procedure atcForceRollback; override;

    {-- transactions --}
    function stcTransactionStart(aFailSafe              : Boolean;
                                 aSnapShot              : Boolean;
                                 aOverrideForceFailsafe : Boolean;
                                 aNoMoreNested          : Boolean;
                                 aForceNested           : Boolean;
                                 aOverrideSecurity      : Boolean)
                                                        : TnxResult;
    function stcTransactionStartWith(aFailSafe             : Boolean;
                                    aSnapShot              : Boolean;
                              const aCursors               : array of TnxAbstractCursor;
                                    aOverrideForceFailsafe : Boolean;
                                    aNoMoreNested          : Boolean;
                                    aForceNested           : Boolean;
                                    aOverrideSecurity      : Boolean)
                                                           : TnxResult;
    function stcTransactionInclude(aExclusive : Boolean;
                             const aCursors   : array of TnxAbstractCursor)
                                              : TnxResult;
    function stcTransactionCommit : TnxResult;
    function stcTransactionRollback : TnxResult;
    function stcTransactionMarkCorrupted : TnxResult;
  public
    constructor Create(aSession : TnxAbstractSession;
                       aTimeout : TnxWord32);
    destructor Destroy; override;

    procedure Failed; override;

    function TransactionStart(aFailSafe : Boolean;
                              aSnapShot : Boolean)
                                        : TnxResult; override;
    function TransactionStartWith(aFailSafe : Boolean;
                                  aSnapShot : Boolean;
                            const aCursors  : array of TnxAbstractCursor)
                                            : TnxResult; override;

    function TransactionInclude(aExclusive : Boolean;
                          const aCursors   : array of TnxAbstractCursor)
                                           : TnxResult; override;

    function TransactionCommit: TnxResult; override;
    function TransactionRollback: TnxResult; override;
    function TransactionCorrupted: TnxResult; override;

    function TransactionGetLevel(out aTransLevel : Integer)
                                                 : TnxResult; override;
    function TransactionGetInfo(out aTransInfo   : TnxTransactionInfo;
                                    aAllowCached : Boolean = True)
                                                 : TnxResult; override;
  end;
  PnxServerTransContext = ^TnxServerTransContext;

  TnxServerTableState = (
    stsLockedIncDone
  );
  TnxServerTableStates = set of TnxServerTableState;

  TnxServerBaseTable = class(TnxAbstractServerBaseTable)
  protected {private}
    sbtRoot                  : TnxServerRootTable;
    sbtParent                : TnxServerBaseTable;

    sbtChildren              : TnxServerBaseTables;
    sbtChildNames            : TStringList;

    sbtNameInScope           : string;

    sbtCursorsPadlock        : TnxPadlock;
    sbtCursorsHead           : TnxServerTableCursor;
    sbtCursorsTail           : TnxServerTableCursor;
    sbtCursorCount           : Integer;

    sbtLockIsInactive        : TnxInt32;

    {-- locks -- }
    sbtLocks                 : TnxTableLockContainer;

    {-- dictionary --}
    sbtTableDescriptor       : TnxBaseTableDescriptor;
    sbtFieldsDescriptor      : TnxFieldsDescriptor;
    sbtRecordAllocator       : TnxMemoryPool;
    sbtSFI                   : PnxSpecialFieldsInfo;

    {-- block access --}
    sbtBlockAccess           : TnxBlockAccessList;

    {-- sub-engines --}
    sbtAutoIncEngine         : TnxBaseAutoIncEngine;
    sbtRecordEngine          : TnxBaseRecordEngine;
    sbtBlobEngine            : TnxBaseBlobEngine;
    sbtIndicesEngine         : TnxBaseIndicesEngine;
    sbtInternalIndicesEngine : TnxBaseIndicesEngine;

    sbtFulltextEngine        : TnxBaseFulltextTableEngine;

    {-- data policies --}
    sbtDenyRecordOperations  : TnxRecordOperations;
    sbtMinRecordCount        : TnxWord32;
    sbtMaxRecordCount        : TnxWord32;

    sbtStates                : TnxServerTableStates;

    sbtForRecover            : Boolean;

    function sbtCurrentLSN(aTrans: TnxBaseTransaction): TnxLSN;
    function sbtGetIsCache: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  protected
    function asoGetServerEngine: TnxBaseServerEngine; override;

    function sbtIsInactive(aIgnoreKeepInMemory : Boolean;
                           aRequestClose       : Boolean;
                           aExpectedLockCount  : Integer = 0)
                                               : Boolean;

    procedure sbtInitFromDescriptor(aTableDescriptor: TnxBaseTableDescriptor);

    procedure sbtCreateBlockAccess;
    procedure sbtDestroyBlockAccess;

    procedure sbtCreateEngines(aTrans: TnxBaseTransaction);
    procedure sbtDestroyEngines;

    procedure sbtCreateChildren(aTrans: TnxBaseTransaction);
    procedure sbtDestroyChildren;

    {-- RecRev processing --}
    procedure sbtRecRevInit(aRecordBuffer    : PnxRecordBuffer);
    function sbtRecRevUpdate(aOldBuffer      : PnxRecordBuffer;
                             aNewBuffer      : PnxRecordBuffer;
                             aModifyOnInsert : Boolean = False)
                                             : TnxResult;

    {-- RefNr processing --}
    procedure sbtRefNrInit(aRecordBuffer: PnxRecordBuffer);
    function sbtRefNrUpdate(aOldBuffer      : PnxRecordBuffer;
                            aNewBuffer      : PnxRecordBuffer;
                            aRefNr          : TnxRefNr;
                            aModifyOnInsert : Boolean = False)
                                            : TnxResult;

    {-- LSN processing --}
    procedure sbtLSNInit(aCursor       : TnxAbstractCursor;
                         aRecordBuffer : PnxRecordBuffer);
    function sbtLSNUpdate(aCursor         : TnxAbstractCursor;
                          aOldBuffer      : PnxRecordBuffer;
                          aNewBuffer      : PnxRecordBuffer;
                          aModifyOnInsert : Boolean = False)
                                          : TnxResult;

    procedure sbtEnginesRollback(aTrans : TnxBaseTransaction);
    procedure sbtLocksEndTransaction(aTrans: TnxBaseTransaction);

    { stats }
    function sbtGetStats(aTrans : TnxBaseTransaction)
                                : TnxServerTableStats;
  public
    constructor Create(aParent          : TnxExtendableServerObject;
                 const aName            : string;
                       aTableDescriptor : TnxBaseTableDescriptor);
    destructor Destroy; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function GetChild(const aChildName : string;
                        out aTable     : TnxServerBaseTable)
                                       : TnxResult;

    function FullName: string; virtual;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    property Root: TnxServerRootTable
      read sbtRoot;

    property Parent: TnxServerBaseTable
      read sbtParent;

    property Name: string
      read sbtNameInScope;

    property TableDescriptor: TnxBaseTableDescriptor
      read sbtTableDescriptor;

    property RecordAllocator: TnxMemoryPool
      read sbtRecordAllocator;

    property AutoIncEngine: TnxBaseAutoIncEngine
      read sbtAutoIncEngine;

    property RecordEngine: TnxBaseRecordEngine
      read sbtRecordEngine;

    property BlobEngine: TnxBaseBlobEngine
      read sbtBlobEngine;

    property IndicesEngine: TnxBaseIndicesEngine
      read sbtIndicesEngine;

    property InternalIndicesEngine: TnxBaseIndicesEngine
      read sbtInternalIndicesEngine;

    property FulltextEngine: TnxBaseFulltextTableEngine
      read sbtFulltextEngine;

    property CurrentLSN[aTrans: TnxBaseTransaction]: TnxLSN
      read sbtCurrentLSN;

    property IsCache: Boolean
      read sbtGetIsCache;
  end;

(*$HPPEMIT 'namespace Nxsrserverengine'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'class DELPHICLASS TnxServerBaseTable;'*)
(*$HPPEMIT 'class DELPHICLASS TnxServerRecoverNode;'*)
(*$HPPEMIT '}'*)

  TnxServerRootTable = class(TnxServerBaseTable)
  protected {private}
    srtFolder                         : TnxServerFolder;
    srtForServer                      : Boolean;
    srtTableScope                     : TnxTableScope;
    srtName                           : string;
    srtOpenMode                       : TnxOpenMode;
    srtShareMode                      : TnxShareMode;

    {-- active/inactive tracking --}
    srtCursorCount                    : Integer;
    srtInactiveSince                  : TDateTime;

    srtInServerEngineInactiveTables   : Boolean;
    srtServerEngineInactiveTablesPrev : TnxServerRootTable;
    srtServerEngineInactiveTablesNext : TnxServerRootTable;

    srtInFolderInactiveTables         : Boolean;
    srtFolderInactiveTablesPrev       : TnxServerRootTable;
    srtFolderInactiveTablesNext       : TnxServerRootTable;

    {-- locks -- }
    srtCommitPadlock                 : TnxPadlock;
    srtContentPortal                 : TnxReadWritePortal;

    {-- TransactionLevel Table Link support --}
    srtTransLinksPadlock             : TnxPadlock;

    srtTransLinksPendingUpgrade      : TnxServerTransactionLevelTableLink;

    srtTransLinksPendingHead         : TnxServerTransactionLevelTableLink;
    srtTransLinksPendingTail         : TnxServerTransactionLevelTableLink;

    srtTransLinksGrantedHead         : TnxServerTransactionLevelTableLink;
    srtTransLinksGrantedTail         : TnxServerTransactionLevelTableLink;

    srtTransLinksSnapshotGrantedHead : TnxServerTransactionLevelTableLink;
    srtTransLinksSnapshotGrantedTail : TnxServerTransactionLevelTableLink;

    srtSnapshotBlockCount            : TnxInt32;

    {-- files --}
    srtFiles                         : TnxBaseFiles;
    srtMainFile                      : TnxBaseFile;
    srtFileIsLink                    : Boolean;

    {-- dictionary --}
    srtDictionary                    : TnxServerDataDict;

    {-- sub-engines --}
    srtStreamEngine                  : TnxBaseStreamEngine;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  protected
    function asoGetServerEngine: TnxBaseServerEngine; override;

    function srtIsInactive(aIgnoreKeepInMemory : Boolean;
                           aRequestClose       : Boolean;
                           aExpectedLockCount  : Integer = 0)
                                               : Boolean;

    function srtAuthenticatePassword(aPasswords : TnxUnicodeStrings)
                                                : TnxResult;

    function srtExtractPassword: UnicodeString;

    function srtChangePassword(aTrans       : TnxBaseTransaction;
                         const aNewPassword : UnicodeString)
                                            : TnxResult;
    {-- active/inactive tracking --}
    procedure srtIncCursorCount;
    procedure srtDecCursorCount;

    {-- commit processing --}
    procedure srtBeginCommit(aTransaction : TnxServerTransaction);
    procedure srtEndCommitPhase1(aTransaction : TnxServerTransaction);
    procedure srtEndCommitPhase2(aTransaction : TnxServerTransaction);

    {-- transaction locking --}
    procedure srtCheckPendingRequests;
    function srtCanGrantRequest(aLink : TnxServerTransactionLevelTableLink)
                                      : TnxCanGrantRequest;

    procedure srtSetReason(aRequestingLink  : TnxServerTransactionLevelTableLink;
                           aConflictingLink : TnxServerTransactionLevelTableLink);


    function srtBuildFiles(aTrans      : TnxBaseTransaction;
                           aPasswords  : TnxUnicodeStrings;
                           aForServer  : Boolean;
                           aDictionary : TnxDataDictionary;
                           aAttribs    : TnxFileAttributes;
                           aStore      : TnxBaseTempStorage;
                           aTableName  : string)
                                       : TnxResult;
    function srtCreateFile(aFileInx   : Integer;
                           aTrans     : TnxBaseTransaction;
                           aPasswords : TnxUnicodeStrings;
                           aForServer : Boolean;
                           aAttribs   : TnxFileAttributes;
                           aStore     : TnxBaseTempStorage)
                                      : TnxResult;

    function srtOpenFiles(aTrans      : TnxBaseTransaction;
                          aPasswords  : TnxUnicodeStrings;
                          aForServer  : Boolean;
                          aAttribs    : TnxFileAttributes;
                      out aIsReadOnly : Boolean)
                                      : TnxResult;

    procedure srtSetFileMaxID;

    function srtCloseFiles: TnxResult;
    procedure srtDeleteFiles;

    procedure srtAddToFolder;
    procedure srtRemoveFromFolder;

    procedure srtServerEngineAddToInactiveTables;
    procedure srtServerEngineRemoveFromInactiveTables;
  public
    constructor Create(aFolder    : TnxServerFolder;
                 const aName      : string;
                       aOpenMode  : TnxOpenMode;
                       aShareMode : TnxShareMode;
                       aTableScope: TnxTableScope);
    destructor Destroy; override;

    function FullName: string; override;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    property Dictionary: TnxServerDataDict
      read srtDictionary;

    property StreamEngine: TnxBaseStreamEngine
      read srtStreamEngine;

    property ExtractPassword: UnicodeString
      read srtExtractPassword;

    property TableScope : TnxTableScope
      read srtTableScope;

    property CursorCount: Integer
      read sbtCursorCount;
  end;


  TnxBlobLinkHandler = class(TnxBaseBlobLinkHandler)
  protected {private}
    blhPortal       : TnxReadWritePortal;
    blhDatabase     : TnxServerDatabase;
    blhTransContext : PnxServerTransContext;
    blhBlobCursors  : TStringList;
    blhRequestClose : InxRequestCloseHandlerEvent;

    function blhFindBlobCursor(const aTableName : string;
                               const aPassword  : UnicodeString;
                                 out aCursor    : TnxServerBaseCursor)
                                                : TnxResult;

    procedure blhCursorRequestClose(Sender: TObject);
  public
    constructor Create(aDatabase     : TnxServerDatabase;
                       aTransContext : PnxServerTransContext);
    destructor Destroy; override;

    function BlobLinkRead(const aTableName : string;
                                aBlobNr    : TnxBlobNr;
                                aOffset    : TnxWord32;
                                aLen       : TnxWord32;
                                aStream    : TStream)
                                           : TnxResult; override;
    function BlobLinkGetLength(const aTableName : string;
                                     aBlobNr    : TnxBlobNr;
                                 out aLength    : TnxWord32)
                                                : TnxResult; override;
  end;

  TnxBaseResultSetCacheHandle = class(TnxObject)
  public
    function OpenCursor : TnxServerBaseCursor; virtual; abstract;
  end;

  TnxCacheHandleNotify = procedure(aSender : TnxBaseResultSetCacheHandle) of object;

  TnxKeyFieldsSource = class(TnxInterfacedObject, InxFieldsSource)
  protected {private}
    kfsOwner: TnxServerTableCursor;
    function GetKeyEngine: InxFieldsSource;
  protected
    property KeyEngine: InxFieldsSource
      read GetKeyEngine;

    { InxFieldsSource }
    function GetFieldForFilter(aField    : Integer;
                               aName     : PAnsiChar;
                               aData     : PnxRecordBuffer;
                           out aType     : TnxWord16;
                           out aSize     : TnxWord16;
                           out aIsNull   : Boolean;
                           out aValue    : PnxFieldBuffer;
                           out aCodePage : TnxWord16)
                                         : Boolean;

    function GetFieldAsVariant(aBuffer : PnxRecordBuffer;
                               aField  : Integer)
                                       : OleVariant;
    function BlobsSupported: Boolean;

    function BeginReadOrgOverride: Integer;
    function EndReadOrgOverride: Integer;

    function GetFieldFromName(const aFieldName : string) : Integer;

    function GetFieldCount: Integer;
    function GetFieldDescriptor(aIndex: Integer): InxFieldDescriptor;

    function GetCursor: TObject;
    function GetFieldsOffset: integer;
  public
    constructor Create(aOwner: TnxServerTableCursor);
  end;

  TnxServerBaseCursor = class(TnxSqlAbstractCursor)
  protected {private}
    sbcTransContext                     : TnxServerTransContext;
    sbcTrans                            : PnxServerTransaction;

    sbcOpenMode                         : TnxOpenMode;

    sbcIsReadOnly                       : Boolean;
    sbcReadOnlyResult                   : TnxResult;
    sbcReadOnlyResultMessage            : PResStringRec;

    sbcIsWriteOnly                      : Boolean;
    sbcWriteOnlyResult                  : TnxResult;
    sbcWriteOnlyResultMessage           : PResStringRec;

    sbcLockFailureReason                : TnxLockFailureReason;

    sbcInsertOptions                    : TnxInsertOptions;

    {-- default value support --}
    sbcDefaultValueHandler              : TnxDefaultValueHandler;

    sbcDefaultValueHandlerClientCreated : Boolean;
    sbcDefaultValueHandlerClient        : TnxDefaultValueHandler;

    {-- field validation support --}
    sbcValidationsHandler               : TnxValidationsHandler;

    {-- temporary buffers --}
    sbcRecordBuffer                     : PnxRecordBuffer;
    sbcRecordBuffer2                    : PnxRecordBuffer;

    {-- buffers for blob verification --}
    //don't free: these are just assigned to buffers owned elsehwere
    sbcRecordBufferOrg                  : PnxRecordBuffer;
    sbcRecordBufferOrgRefNr             : TnxRefNr;

    sbcRecordBufferBlobVerify           : PnxRecordBuffer;

    {-- taskinfos --}
    sbcTaskInfo                         : TnxServerTaskInfo;

    {-- filter support --}
    sbcFilter                           : TnxBaseFilterEngine;
    sbcFilterTimeout                    : TnxWord32;
    sbcFilterUntil                      : TnxInt64;
    sbcFilterTimeoutLock                : Integer;
    sbcFilterTimeoutChangeLock          : Integer;

    {-- key filter support --}
    sbcKeyFilter                        : TnxBaseFilterEngine;

    {-- recover --}
    sbcForRecover                       : Boolean;

    function esoInformMonitors: Boolean; override;

    function sbcGetReadOnlyResult: TnxResult;
    function sbcGetWriteOnlyResult: TnxResult;

    //function ac_GetDictionary: TnxDataDictionary; override;
    //function acGetTableDescriptor: TnxBaseTableDescriptor; override;

//    function sbcGetPosition: TnxIndexPathPosition; virtual; abstract;
    function sbcLockError(aResult : TnxResult) : TnxResult;

    function sbcIsSystemTable: Boolean;

  public {protected}
    procedure sbcMarkReadonly; override;

    procedure sbcBeginReadOrgOverride; virtual;
    procedure sbcEndReadOrgOverride; virtual;

    procedure esoOptionChanged(const aName  : string;
                               const aValue : string); override;

    {-- stats --}
    function sbcGetStats: TnxServerTableStats; virtual;

    {-- field renaming --}
    function sbcRenameField(aFieldNo : Integer;
                      const aNewName : string)
                                     : TnxResult; virtual;

    {-- content locks --}
    function sbcBeginContentLock(aExclusive   : Boolean;
                                 aConditional : Boolean;
                                 aInternal    : Boolean = False)
                                              : TnxResult; virtual; abstract;
    procedure sbcEndContentLock; virtual; abstract;

    {-- transaction support --}
    function sbcCheckTransactionState : TnxResult; virtual;

    {-- filter support --}
    procedure sbcFilterBeginTimeout(aResult: PnxResult; aLongTimeout: Boolean = False);
    procedure sbcFilterEndTimeout;
    function  sbcFilterCheckTimeout(var aResult : TnxResult) : Boolean;

    procedure sbcRequestClose;

    {-- transaction context --}
    function sbcTransContextSet(aTransContext : TnxAbstractTransContext)
                                              : TnxResult; virtual; abstract;

    {-- navigation --}
//    procedure sbcSetToBegin; virtual; abstract;
    function sbcSetToCursor(aCursor : TnxAbstractCursor)
                                    : TnxResult; virtual; abstract;
//    procedure sbcSetToEnd; virtual; abstract;
    function sbcSetToFilter(aFilter    : TnxBaseFilterEngine;
                            aKeyFilter : TnxBaseFilterEngine;
                            aForward   : TnxBoolean)
                                       : TnxResult; virtual; abstract;
    function sbcSetToFilterRecIterator(aCookie : Pointer;
                                       aRefNr  : TnxRefNr;
                                       aRecord : PnxRecordBuffer)
                                               : TnxRecordIteratorResult;
    function sbcSetToFilterKeyIterator(aCookie : Pointer;
                                       aRefNr  : TnxRefNr;
                                       aKey    : PnxKeyBuffer)
                                               : TnxKeyIteratorResult;

    {-- bookmarks --}
    {
    function sbcGetBookmarkSize(out aSize : TnxWord32)
                                          : TnxResult; virtual; abstract;}

    function sbcGetBookmark(aBookmark : PnxBookmarkBuffer;
                            aSize     : TnxWord32)
                                      : TnxResult; virtual; abstract;
    function sbcGetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                 aSize     : TnxWord32)
                                           : TnxResult; virtual;
    function sbcCompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                                 aBookmark2  : PnxBookmarkBuffer;
                                 aSize       : TnxWord32;
                             out aCompResult : TnxValueRelationship)
                                             : TnxResult; virtual; abstract;
    function sbcSetToBookmark(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32;
                              aIsCache  : Boolean)
                                        : TnxResult; virtual; abstract;
    function sbcBookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                                  aSize     : TnxWord32;
                              out aVariant  : Variant)
                                            : TnxResult; virtual; abstract;
    function sbcBookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                   aSize     : TnxWord32)
                                             : TnxResult; virtual; abstract;
    function sbcBookmarkClear(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32)
                                        : TnxResult; virtual; abstract;

    {-- recno support --}
    function sbcRecNoGet(out aRecNo     : TnxWord32;
                             aFlipOrder : Boolean)
                                        : TnxResult; virtual; abstract;
    function sbcRecNoSet(aRecNo     : TnxWord32;
                         aFlipOrder : Boolean)
                                    : TnxResult; virtual; abstract;


    {-- record retrival --}
{    function sbcRecordGet(aLockType : TnxLockType;
                          aData     : PnxRecordBuffer)
                                    : TnxResult; virtual; abstract;
    function sbcRecordGetNext(aLockType : TnxLockType;
                              aData     : PnxRecordBuffer)
                                        : TnxResult; virtual; abstract;
    function sbcRecordGetPrior(aLockType : TnxLockType;
                               aData     : PnxRecordBuffer)
                                         : TnxResult; virtual; abstract;
 }
    {-- record manipulation --}
{    function sbcRecordInsert(aLockType      : TnxLockType;
                             aInsertOptions : TnxInsertOptions;
                             aData          : PnxRecordBuffer)
                                            : TnxResult; virtual; abstract;
    function sbcRecordModify(aData        : PnxRecordBuffer;
                             aReleaseLock : Boolean)
                                          : TnxResult; virtual; abstract;
    function sbcRecordDelete(aData : PnxRecordBuffer)
                                   : TnxResult; virtual; abstract;
}
    {-- record locks --}
    function sbcRecordIsLocked(aLockType    : TnxLockType;
                           out aLockPresent : TnxLockPresent)
                                            : TnxResult; virtual; abstract;
    function sbcRecordLockRelease(aAllLocks    : Boolean;
                                  aCancelBlobs : Boolean)
                                               : TnxResult; virtual; abstract;

    {-- autoinc --}
//    function sbcAutoIncGet: TnxWord32; virtual; abstract;
    function sbcAutoIncSet(aAutoInc : TnxWord32): TnxResult; virtual; abstract;
    procedure sbcAutoIncSetDirect(aAutoInc : TnxWord32); virtual; abstract;

    {-- filters --}
    procedure sbcDisableFilterTimeout;
    procedure sbcEnableFilterTimeout;

    procedure sbcDisableFilterTimeoutChange;
    procedure sbcEnableFilterTimeoutChange;

    procedure sbcFilterAddCustom(aFilter   : TnxBaseFilterEngine;
                             out aFilterID : TnxFilterID;
                                 aActivated: Boolean);

    {-- key filters --}
    function sbcGetKeyFieldsSource: InxFieldsSource; virtual; abstract;
    function sbcKeyFilterAddCustom(aKeyFilter   : TnxBaseFilterDescriptor;
                               out aKeyFilterID : TnxKeyFilterID;
                                   aActivated   : Boolean)
                                                : TnxResult; virtual;
    procedure sbcKeyFilterAddCustomEngine(aKeyFilter   : TnxBaseFilterEngine;
                                      out aKeyFilterID : TnxKeyFilterID;
                                          aActivated   : Boolean);
    function sbcKeyFilterDeactivate(aKeyFilterID : TnxKeyFilterID)
                                                 : TnxResult;
    {-- index support --}
{    function sbcSwitchToIndex(const aIndexName : string;
                                    aIndexID   : Integer;
                                    aPosnOnRec : Boolean)
                                               : TnxResult; virtual; abstract;}
//    function sbcGetIndexID(out aIndexID : Integer)
//                                        : TnxResult; virtual; abstract;

    function sbcSetToKey(aSearchAction : TnxSearchKeyAction;
                         aFieldCount   : Integer;
                         aPartialLen   : Integer;
                         aDirectKey    : Boolean;
                         aKeyData      : PnxKeyOrRecordBuffer)
                                       : TnxResult; virtual; abstract;

    function sbcRecordGetForKey(aFieldCount : integer;
                                aPartialLen : integer;
                                aDirectKey  : Boolean;
                                aKeyData    : PnxKeyOrRecordBuffer;
                                aData       : PnxRecordBuffer;
                                aMatchFirst : Boolean;
                                aFirstCall  : Boolean)
                                            : TnxResult; virtual; abstract;

    function sbcRecordGetForKeyBatch(aCutoffSize : Integer;
                                     aOptions    : TnxRecordGetBatchExOptions;
                                 var aAccess     : TnxBatchStreamAccess;
                               const aKeys       : TnxDataSetKeyBufferArray;
                                     aMatchFirst : Boolean;
                                     aFirstCall  : Boolean)
                                                 : TnxResult; virtual; abstract;

{    procedure sbcRangeReset; virtual; abstract;}
{    function sbcRangeSet(aFieldCount1 : Integer;
                         aPartialLen1 : Integer;
                         aDirectKey1  : Boolean;
                         aKeyData1    : PnxKeyOrRecordBuffer;
                         aKeyIncl1    : Boolean;
                         aFieldCount2 : Integer;
                         aPartialLen2 : Integer;
                         aDirectKey2  : Boolean;
                         aKeyData2    : PnxKeyOrRecordBuffer;
                         aKeyIncl2    : Boolean)
                                      : TnxResult; virtual; abstract;}

    function sbcCompareKeys(aFieldCount : Integer;
                            aPartialLen : Integer;
                            aDirectKey1 : Boolean;
                            aKeyData1   : PnxKeyOrRecordBuffer;
                            aDirectKey2 : Boolean;
                            aKeyData2   : PnxKeyOrRecordBuffer;
                        out aResult     : TnxValueRelationship)
                                        : TnxResult; virtual; abstract;

    {-- batch operations --}
    function sbcRecordGetBatch(aCutoffSize : Integer;
                               aOptions    : TnxRecordGetBatchExOptions;
                           var aAccess     : TnxBatchStreamAccess;
                               aMaxRecords : Integer = -1;
                               aForward    : Boolean = True)
                                           : TnxResult; override;

    function sbcCopyBlobsToBatchStream(var aSize       : Integer;
                                     const aOffset     : TnxWord32;
                                           aStream     : TnxMemoryStream;
                                           aAddBlobNr  : Boolean;
                                           aOnlyMarked : Boolean)
                                                       : TnxResult;

{    function sbcRecordInsertBatch(aStream : TnxCustomMemoryStream)
                                          : TnxResult; virtual; abstract;}

{    function sbcCopyRecords(aDestCursor     : TnxAbstractCursor;
                            aBlobCopyMode   : TnxBlobCopyMode;
                            aMaxTransSize   : Integer;
                            aCheckValFields : Boolean)
                                            : TnxResult; virtual; abstract;}

//  function sbcDeleteRecords : TnxResult; virtual; abstract;

    {-- blob managment --}
    function acSnapshotRequiredForBlobRead(const aRecID   : TnxRecID;
                                                 aFieldNo : TnxInt32;
                                                 aBlobNr  : TnxBlobNr;
                                                 aReadOrg : Boolean)
                                                          : Boolean; override;
    function acTransactionStartForBlobReadSnapshoted: TnxResult; override;
    function acTransactionRollbackForBlobReadSnapshoted: TnxResult; override;

    function sbcBlobsCancel(const aRefNr : TnxRefNr)
                                         : TnxResult; virtual; abstract;

    function sbcBlobCreate(const aRecID   : TnxRecID;
                                 aFieldNo : TnxInt32;
                             out aBlobNr  : TnxBlobNr)
                                          : TnxResult; virtual; abstract;
    function sbcBlobCreateFile(const aRecID    : TnxRecID;
                                     aFieldNo  : TnxInt32;
                               const aFileName : string;
                                 out aBlobNr   : TnxBlobNr)
                                               : TnxResult; virtual; abstract;
{    function sbcBlobCreateLink(aFieldNo     : TnxInt32;
                         const aTableName   : string;
                         const aTableBlobNr : TnxBlobNr;
                           out aBlobNr      : TnxBlobNr)
                                            : TnxResult; virtual; abstract;}
{    function sbcBlobDelete(aFieldNo : TnxInt32;
                     const aBlobNr  : TnxBlobNr)
                                    : TnxResult; virtual; abstract;}
    function sbcBlobFree(const aRecID   : TnxRecID;
                               aFieldNo : TnxInt32;
                         const aBlobNr  : TnxBlobNr)
                                        : TnxResult; virtual; abstract;
{    function sbcBlobRead(aFieldNo   : TnxInt32;
                   const aBlobNr    : TnxBlobNr;
                         aOffset    : TnxWord32;
                         aLen       : TnxWord32;
                         aStream    : TStream;
                         aReadOrg   : Boolean)
                                    : TnxResult; virtual; abstract;}
{    function sbcBlobWrite(aFieldNo : TnxInt32;
                    const aBlobNr  : TnxBlobNr;
                          aOffset  : TnxWord32;
                          aLen     : TnxWord32;
                    const aBlob    )
                                   : TnxResult; virtual; abstract;}
{    function sbcBlobTruncate(aFieldNo    : TnxInt32;
                       const aBlobNr     : TnxBlobNr;
                             aBlobLength : TnxWord32)
                                         : TnxResult; virtual; abstract;}
{    function sbcBlobGetLength(aFieldNo : TnxInt32;
                        const aBlobNr  : TnxBlobNr;
                          out aLength  : TnxWord32;
                              aReadOrg : Boolean)
                                       : TnxResult; virtual; abstract;}
    function sbcBlobAddToCache(const aRecID   : TnxRecID;
                                     aFieldNo : TnxInt32;
                               const aBlobNr  : TnxBlobNr;
                                     aLen     : TnxWord32;
                               const aBlob    )
                                              : TnxResult; virtual;
    function sbcBlobModified(const aRecID   : TnxRecID;
                                   aFieldNo  : TnxInt32;
                             const aBlobNr   : TnxBlobNr;
                               out aModified : Boolean)
                                             : TnxResult; virtual; abstract;

    function sbcBlobCopyPrim(aSrcCursor   : TnxServerBaseCursor;
                             aSrcFieldNo  : TnxInt32;
                       const aBlobNr      : TnxBlobNr;
                             aDestFieldNo : TnxInt32;
                         out aDestBlobNr  : TnxBlobNr;
                             aMaxLength   : TnxWord32 = High(TnxWord32))
                                          : TnxResult; virtual; abstract;
    function sbcBlobCopyContentPrim(aSrcCursor   : TnxServerBaseCursor;
                                    aSrcFieldNo  : TnxInt32;
                              const aBlobNr      : TnxBlobNr;
                                    aDestFieldNo : TnxInt32;
                              const aDestBlobNr  : TnxBlobNr;
                                    aMaxLength   : TnxWord32 = High(TnxWord32))
                                                 : TnxResult; virtual; abstract;

{    function sbcBlobIsLink(aFieldNo        : TnxInt32;
                           aBlobNr         : TnxBlobNr;
                       out aSrcTableName   : string;
                       out aSrcTableBlobNr : TnxBlobNr)
                                           : Boolean; virtual; abstract;}

    {-- table streams --}
    function sbcTableStreamGetList(aStreams  : TStrings;
                                   aInternal : Boolean)
                                             : TnxResult; virtual; abstract;
    function sbcTableStreamWrite(const aName     : string;
                                       aStream   : TStream;
                                       aInternal : Boolean)
                                                 : TnxResult; virtual; abstract;
    function sbcTableStreamRead(const aName     : string;
                                      aStream   : TStream;
                                      aInternal : Boolean)
                                                : TnxResult; virtual; abstract;
    function sbcTableStreamDelete(const aName     : string;
                                        aInternal : Boolean)
                                                  : TnxResult; virtual; abstract;

    {-- table locks --}
    function sbcTableIsLocked(aLockType : TnxLockType)
                                        : TnxLockPresent; virtual; abstract;
    function sbcTableLockAcquire(aLockType : TnxLockType)
                                           : TnxResult; virtual; abstract;
    function sbcTableLockRelease(aLockType : TnxLockType;
                                 aAllLocks : Boolean)
                                           : TnxResult; virtual; abstract;
    {-- misc --}
{    function sbcDuplicate(aOpenMode    : TnxOpenMode;
                      out aNewCursorID : TnxAbstractCursor;
                          aForceWrite  : Boolean = False)
                                       : TnxResult; virtual; abstract;}

{    function sbcChangePassword(const aNewPassword : UnicodeString)
                                                  : TnxResult; virtual; abstract;}
    function sbcExtractPassword: UnicodeString; virtual; abstract;

    {-- information --}
{    function sbcGetRecordCount(aOption   : TnxRecordCountOption;
                           out aRecCount : TnxWord32;
                               aEstimate : Boolean = False)
                                         : TnxResult; virtual; abstract;}

    {-- sql engine support --}
    function sacGetOpenMode: TnxOpenMode; override;
    procedure sacSetDefault(aRecordBuffer : PnxRecordBuffer; aIndex: Integer); override;
    procedure sacSetDefaultsInsert(aRecordBuffer : PnxRecordBuffer); override;


    {-- result set caching --}
    function sbcRegisterInResultSetCache(const aSourceCursors : array of TnxServerBaseCursor;
                                         const aOnEvict       : TnxCacheHandleNotify)
                                                              : TnxBaseResultSetCacheHandle; virtual;

    function GetActiveTrans: TnxServerTransaction;
  protected
    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  public
    property ActiveTrans: TnxServerTransaction read GetActiveTrans;

    constructor Create(aDelayInformMonitors : Boolean;
                       aDatabase            : TnxServerDatabase;
                       aTransContext        : TnxAbstractTransContext;
                       aTimeout             : TnxWord32;
                       aOpenMode            : TnxOpenMode);
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    procedure AfterConstruction; override;

    procedure RequestNestedTransactions; override;

    { helper functions for record buffer management }
    procedure RecordBufferClear(aBuffer: PnxRecordBuffer); override;

    {-- transaction context --}
    function TransContextSet(aTransContext : TnxAbstractTransContext)
                                           : TnxResult; override;

    {-- navigation --}
    function SetToBegin : TnxResult; override;
    function SetToCursor(aCursor : TnxAbstractCursor)
                                 : TnxResult; override;
    function SetToEnd : TnxResult; override;

    function SetToFilter(aFilter    : TnxBaseFilterDescriptor;
                         aKeyFilter : TnxBaseFilterDescriptor;
                         aForward   : TnxBoolean)
                                    : TnxResult; override;

    {-- bookmarks --}
    function GetBookmark(aBookmark : PnxBookmarkBuffer;
                         aSize     : TnxWord32)
                                   : TnxResult; override;
    function GetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32)
                                        : TnxResult; override;
    function CompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                              aBookmark2  : PnxBookmarkBuffer;
                              aSize       : TnxWord32;
                          out aCompResult : TnxValueRelationship)
                                          : TnxResult; override;
    function SetToBookmark(aBookmark : PnxBookmarkBuffer;
                           aSize     : TnxWord32)
                                     : TnxResult; override;
    function SetToCacheBookmark(aBookmark : PnxBookmarkBuffer;
                                aSize     : TnxWord32)
                                          : TnxResult; override;
    function BookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                               aSize     : TnxWord32;
                           out aVariant  : Variant)
                                         : TnxResult; override;
    function BookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                aSize     : TnxWord32)
                                          : TnxResult; override;
    function BookmarkClear(aBookmark : PnxBookmarkBuffer;
                           aSize     : TnxWord32)
                                     : TnxResult; override;

    {-- recno support --}
    function RecNoSupported: TnxResult; override;

    function RecNoGet(out aRecNo     : TnxWord32;
                          aFlipOrder : Boolean)
                                     : TnxResult; override;

    function RecNoSet(aRecNo     : TnxWord32;
                      aFlipOrder : Boolean)
                                 : TnxResult; override;

    {-- record retrival --}
    function RecordGet(aLockType : TnxLockType;
                       aData     : PnxRecordBuffer)
                                 : TnxResult; override;
    function RecordGetNext(aLockType : TnxLockType;
                           aData     : PnxRecordBuffer)
                                     : TnxResult; override;
    function RecordGetPrior(aLockType : TnxLockType;
                            aData     : PnxRecordBuffer)
                                      : TnxResult; override;

    {-- record manipulation --}
    function RecordInsert(aLockType : TnxLockType;
                          aData     : PnxRecordBuffer;
                          aAutoInc  : PnxInt64 = nil)
                                    : TnxResult; override;
    function RecordModify(aData        : PnxRecordBuffer;
                          aReleaseLock : Boolean;
                          aDataDiff    : PnxRecordDiff = nil)
                                       : TnxResult; override;
    function RecordDelete(aData : PnxRecordBuffer;
                          aLSN  : TnxLSN = 0)
                                : TnxResult; override;

    {-- record locks --}
    function RecordIsLocked(aLockType    : TnxLockType;
                        out aLockPresent : TnxLockPresent)
                                         : TnxResult; override;
    function RecordLockRelease(aAllLocks    : Boolean;
                               aCancelBlobs : Boolean = False )  //..
                                            : TnxResult; override;

    {-- autoinc --}
    function AutoIncGet(out aValue       : TnxWord32;
                            aAllowCached : Boolean = False)
                                         : TnxResult; override;
    function AutoIncSet(aValue : TnxWord32)
                               : TnxResult; override;

    {-- filters --}
    function FilterAddCustom(aFilter   : TnxBaseFilterDescriptor;
                         out aFilterID : TnxFilterID;
                             aActivated: Boolean)
                                       : TnxResult; override;
    function FilterReplaceCustom(aFilter          : TnxBaseFilterDescriptor;
                             var aFilterID        : TnxFilterID;
                                 aActivated       : Boolean;
                                 aIgnoreDropError : Boolean)
                                                  : TnxResult; override;

    function FilterSetTimeout(aTimeout : TnxWord32)
                                       : TnxResult; override;

    function FilterActivate(aFilterID : TnxFilterID)
                                      : TnxResult; override;
    function FilterDeactivate(aFilterID : TnxFilterID)
                                        : TnxResult; override;

    function FilterRemove(aFilterID : TnxFilterID)
                                    : TnxResult; override;

    {-- index support --}
    function SwitchToIndex(const aIndexName : string;
                                 aIndexID   : Integer;
                                 aPosnOnRec : TnxPosnOnRec)
                                            : TnxResult; override;
    function GetIndexID(out aIndexID : Integer)
                                     : TnxResult; override;
    function SetToKey(aSearchAction : TnxSearchKeyAction;
                      aFieldCount   : Integer;
                      aPartialLen   : Integer;
                      aDirectKey    : Boolean;
                      aKeyData      : PnxKeyOrRecordBuffer)
                                    : TnxResult; override;
    function RecordGetForKey(aFieldCount : integer;
                             aPartialLen : integer;
                             aDirectKey  : Boolean;
                             aKeyData    : PnxKeyOrRecordBuffer;
                             aData       : PnxRecordBuffer;
                             aMatchFirst : Boolean;
                             aFirstCall  : Boolean)
                                         : TnxResult; override;
    function RecordGetForKeyBatch(aCutoffSize : Integer;
                                  aOptions    : TnxRecordGetBatchExOptions;
                              var aAccess     : TnxBatchStreamAccess;
                            const aKeys       : TnxDataSetKeyBufferArray;
                                  aMatchFirst : Boolean;
                                  aFirstCall  : Boolean)
                                              : TnxResult; override;

    function RangeReset : TnxResult; override;
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
                                   : TnxResult; override;

    function CompareKeys(aFieldCount : Integer;
                         aPartialLen : Integer;
                         aDirectKey1 : Boolean;
                         aKeyData1   : PnxKeyOrRecordBuffer;
                         aDirectKey2 : Boolean;
                         aKeyData2   : PnxKeyOrRecordBuffer;
                     out aResult     : TnxValueRelationship)
                                     : TnxResult; override;

    {-- key filters --}
    function KeyFilterAddCustom(aKeyFilter   : TnxBaseFilterDescriptor;
                            out aKeyFilterID : TnxKeyFilterID;
                                aActivated   : Boolean)
                                             : TnxResult; override;
    function KeyFilterReplaceCustom(aKeyFilter       : TnxBaseFilterDescriptor;
                                var aKeyFilterID     : TnxKeyFilterID;
                                    aActivated       : Boolean;
                                    aIgnoreDropError : Boolean)
                                                     : TnxResult; override;

    function KeyFilterActivate(aKeyFilterID : TnxKeyFilterID)
                                            : TnxResult; override;
    function KeyFilterDeactivate(aKeyFilterID : TnxKeyFilterID)
                                              : TnxResult; override;

    function KeyFilterRemove(aKeyFilterID : TnxKeyFilterID)
                                          : TnxResult; override;

    {-- batch operations --}
    function RecordGetBatch(aCutoffSize : Integer;
                            aOptions    : TnxRecordGetBatchExOptions;
                        var aAccess     : TnxBatchStreamAccess;
                            aMaxRecords : Integer = -1;
                            aForward    : Boolean = True)
                                        : TnxResult; override;
    function RecordInsertBatch(aStream : TnxCustomMemoryStream)
                                       : TnxResult; override;

    function CopyRecords(aDestCursor   : TnxAbstractCursor;
                         aBlobCopyMode : TnxBlobCopyMode;
                         aMaxTransSize : Integer)
                                       : TnxResult; override;

    function CopyRecordsEx(aDestCursor     : TnxAbstractCursor;
                           aBlobCopyMode   : TnxBlobCopyMode;
                           aMaxTransSize   : Integer;
                           aCheckValFields : Boolean)
                                           : TnxResult; override;
    function DeleteRecords : TnxResult; override;

    {-- blob managment --}
    function BlobsCancel(const aRefNr : TnxRefNr)
                                      : TnxResult; override;

    function BlobCreate(const aRecID   : TnxRecID;
                              aFieldNo : TnxInt32;
                          out aBlobNr  : TnxBlobNr)
                                       : TnxResult; override;
    function BlobCreateFile(const aRecID   : TnxRecID;
                                  aFieldNo  : TnxInt32;
                            const aFileName : string;
                              out aBlobNr   : TnxBlobNr)
                                            : TnxResult; override;
    function BlobDelete(const aRecID   : TnxRecID;
                              aFieldNo : TnxInt32;
                        const aBlobNr  : TnxBlobNr)
                                       : TnxResult; override;
    function BlobFree(const aRecID   : TnxRecID;
                            aFieldNo : TnxInt32;
                      const aBlobNr  : TnxBlobNr)
                                     : TnxResult; override;
    function BlobWrite(const aRecID   : TnxRecID;
                             aFieldNo : TnxInt32;
                       const aBlobNr  : TnxBlobNr;
                             aOffset  : TnxWord32;
                             aLen     : TnxWord32;
                       const aBlob    )
                                      : TnxResult; override;
    function BlobReplace(const aRecID   : TnxRecID;
                               aFieldNo : TnxInt32;
                         var   aBlobNr  : TnxBlobNr;
                               aLen     : TnxWord32;
                         const aBlob    )
                                        : TnxResult; override;
    function BlobTruncate(const aRecID      : TnxRecID;
                                aFieldNo    : TnxInt32;
                          const aBlobNr     : TnxBlobNr;
                                aBlobLength : TnxWord32)
                                            : TnxResult; override;
    function BlobModified(const aRecID    : TnxRecID;
                                aFieldNo  : TnxInt32;
                          const aBlobNr   : TnxBlobNr;
                            out aModified : Boolean)
                                          : TnxResult; override;
    function BlobAddToCache(const aRecID   : TnxRecID;
                                  aFieldNo : TnxInt32;
                            const aBlobNr  : TnxBlobNr;
                                  aLen     : TnxWord32;
                            const aBlob    )
                                           : TnxResult; override;


    {-- table streams --}
    function TableStreamGetList(aStreams : TStrings)
                                         : TnxResult; override;
    function TableStreamWrite(const aName   : string;
                                    aStream : TStream)
                                            : TnxResult; override;
    function TableStreamRead(const aName   : string;
                                   aStream : TStream)
                                           : TnxResult; override;
    function TableStreamDelete(const aName : string)
                                           : TnxResult; override;

    {-- table locls --}
    function TableIsLocked(aLockType    : TnxLockType;
                       out aLockPresent : TnxLockPresent)
                                        : TnxResult; override;
    function TableLockAcquire(aLockType : TnxLockType)
                                        : TnxResult; override;
    function TableLockRelease(aLockType : TnxLockType;
                              aAllLocks : Boolean)
                                        : TnxResult; override;

    {-- misc --}
    function Duplicate(aOpenMode    : TnxOpenMode;
                   out aNewCursorID : TnxAbstractCursor)
                                    : TnxResult; override;

    function ChangePassword(const aNewPassword : UnicodeString)
                                               : TnxResult; override;

    {-- information --}
    function GetRecordCount(out aRecCount : TnxWord32;
                                aEstimate : Boolean = False)
                                          : TnxResult; override;
    function GetRecordCountAsync(out aTaskInfo : TnxAbstractTaskInfo)
                                               : TnxResult; override;


    function GetRecordCountEx(aOption   : TnxRecordCountOption;
                          out aRecCount : TnxWord32;
                              aEstimate : Boolean = False)
                                        : TnxResult; override;

    property DefaultValueHandler: TnxDefaultValueHandler
      read sbcDefaultValueHandler;

    property ValidationsHandler: TnxValidationsHandler
      read sbcValidationsHandler;

    property _Trans: PnxServerTransaction
      read sbcTrans;

    property IsSystemTable: Boolean
      read sbcIsSystemTable;
  end;

  TnxServerTableCursor = class(TnxServerBaseCursor)
  protected {private}
    stcTable                     : TnxServerBaseTable;
    stcTablePrev                 : TnxServerTableCursor;
    stcTableNext                 : TnxServerTableCursor;

    stcTransLink                 : TnxServerTransactionLevelTableLink;
    stcTransLinkPrev             : TnxServerTableCursor;
    stcTransLinkNext             : TnxServerTableCursor;

    stcShareMode                 : TnxShareMode;

    stcSelfRefNr                 : TnxRefNr;

    stcInUseCount                : Integer;

    {-- index information --}
    stcIndexEngine               : TnxBaseIndexEngine;
    stcIndexPath                 : TnxBaseIndexPath;
    stcSavePath                  : TnxBaseIndexPath;
    stcTempPath                  : TnxBaseIndexPath;

    stcSeqAccessIndexEngine      : TnxBaseIndexEngine;
    stcSeqAccessIndexPath        : TnxBaseIndexPath;

    stcLSNIndexEngine            : TnxBaseIndexEngine;
    stcLSNIndexPath              : TnxBaseIndexPath;

    stcRefNrIndexEngine          : TnxBaseIndexEngine;
    stcRefNrIndexPath            : TnxBaseIndexPath;

    stcGraveyardLSNIndexEngine   : TnxBaseIndexEngine;
    stcGraveyardLSNIndexPath     : TnxBaseIndexPath;

    stcGraveyardRefNrIndexEngine : TnxBaseIndexEngine;
    stcGraveyardRefNrIndexPath   : TnxBaseIndexPath;

    stcFulltextEngine            : TnxBaseFulltextCursorEngine;
    stcRefIntEngine              : TnxBaseRefIntegrityEngine;

    {-- temporary buffers --}
    stcKeyBuffer                 : PnxKeyBuffer;

    {-- range support --}
    stcRangeStart                : TnxRangeInfo;
    stcRangeEnd                  : TnxRangeInfo;

    {-- bloblinks --}
    stcBlobLinkHandler           : TnxBlobLinkHandler;
    stcBlobHandler               : TnxBaseBlobHandler;
    stcDeletingBlobsRecID        : TnxRecID;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;

    function ac_GetDictionary: TnxDataDictionary; override;
    function acGetTableDescriptor: TnxBaseTableDescriptor; override;
    function ascGetAbstractBaseTable: TnxAbstractServerBaseTable; override;
  public
    function stcGetCurrentLSN: TnxLSN;

    function acGetFullName: string; override;
    function acGetAliasName: string; override;
    function sbcGetRootName: string; override;

    function sbcGetPosition: TnxIndexPathPosition; override;

    procedure sbcSetOnRequestClose(aHandler : InxRequestCloseHandler); override;
  protected
    {-- options --}
    function esoOptionGetParent(const aName  : string;
                                  out aValue : string)
                                             : TnxResult; override;
    function esoOptionListParent(aList : TStrings)
                                       : TnxResult; override;
    {-- range support --}
    function stcKeyIsInRange(aKey : PnxKeyBuffer)
                                 : TnxValueRelationship;
    function stcRecordIsInRange(aRecord : PnxRecordBuffer;
                          const aRefNr  : TnxRefNr;
                            out aRel    : TnxValueRelationship)
                                        : TnxResult;

    function sbcKeyFilterMatchesRecord(aRecord : PnxRecordBuffer;
                                 const aRefNr  : TnxRefNr)
                                               : Boolean;

    procedure stcAddToTransLink;
    procedure stcRemoveFromTransLink;

    procedure stcAddToTable;
    procedure stcRemoveFromTable;

    function stcSortEnginePutIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
    function stcRecoverRecordsIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;

    function stcValidateIndexPath: TnxResult;
  public {protected}
    {-- stats --}
    function sbcGetStats: TnxServerTableStats; override;

    {-- field renaming --}
    function sbcRenameField(aFieldNo : Integer;
                      const aNewName : string)
                                     : TnxResult; override;

    {-- content locks --}
    function sbcBeginContentLock(aExclusive   : Boolean;
                                 aConditional : Boolean;
                                 aInternal    : Boolean = False)
                                              : TnxResult; override;
    procedure sbcEndContentLock; override;

    {-- transaction support --}
    function sbcCheckTransactionState : TnxResult; override;

    {-- transaction context --}
    function sbcTransContextSet(aTransContext : TnxAbstractTransContext)
                                              : TnxResult; override;

    {-- navigation --}
    procedure sbcSetToBegin; override;
    function sbcSetToCursor(aCursor : TnxAbstractCursor)
                                    : TnxResult; override;
    procedure sbcSetToEnd; override;
    function sbcSetToFilter(aFilter    : TnxBaseFilterEngine;
                            aKeyFilter : TnxBaseFilterEngine;
                            aForward   : TnxBoolean)
                                       : TnxResult; override;

    {-- bookmarks --}
    function sbcGetBookmarkSize(out aSize : TnxWord32)
                                          : TnxResult; override;
    function sbcGetBookmark(aBookmark : PnxBookmarkBuffer;
                            aSize     : TnxWord32)
                                      : TnxResult; override;
    function sbcGetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                 aSize     : TnxWord32)
                                           : TnxResult; override;
    function sbcCompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                                 aBookmark2  : PnxBookmarkBuffer;
                                 aSize       : TnxWord32;
                             out aCompResult : TnxValueRelationship)
                                             : TnxResult; override;
    function sbcSetToBookmark(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32;
                              aIsCache  : Boolean)
                                        : TnxResult; override;
    function sbcBookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                                  aSize     : TnxWord32;
                              out aVariant  : Variant)
                                            : TnxResult; override;
    function sbcBookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                   aSize     : TnxWord32)
                                             : TnxResult; override;
    function sbcBookmarkClear(aBookmark : PnxBookmarkBuffer;
                              aSize     : TnxWord32)
                                        : TnxResult; override;

    {-- recno support --}
    function sbcRecNoGet(out aRecNo     : TnxWord32;
                             aFlipOrder : Boolean)
                                        : TnxResult; override;
    function sbcRecNoSet(aRecNo     : TnxWord32;
                         aFlipOrder : Boolean)
                                    : TnxResult; override;


    {-- record retrival --}
    function sbcRecordGet(aLockType : TnxLockType;
                          aData     : PnxRecordBuffer)
                                    : TnxResult; override;
    function sbcRecordGetNext(aLockType : TnxLockType;
                              aData     : PnxRecordBuffer)
                                        : TnxResult; override;
    function sbcRecordGetPrior(aLockType : TnxLockType;
                               aData     : PnxRecordBuffer)
                                         : TnxResult; override;

    {-- record manipulation --}
    function sbcRecordInsert(aLockType      : TnxLockType;
                             aInsertOptions : TnxInsertOptions;
                             aData          : PnxRecordBuffer;
                             aAutoInc       : PnxInt64 = nil)
                                            : TnxResult; override;
    function sbcRecordModify(aData        : PnxRecordBuffer;
                             aReleaseLock : Boolean;
                             aDataDiff    : PnxRecordDiff = nil)
                                          : TnxResult; override;
    function sbcRecordDelete(aData : PnxRecordBuffer;
                             aLSN  : TnxLSN = 0)
                                   : TnxResult; override;

    {-- graveyard handling --}
    function stcRecordBury(aRefNr : TnxRefNr;
                           aData  : PnxRecordBuffer)
                                  : TnxResult;
    function stcRecordResurrect(aRefNr : TnxRefNr;
                                aData  : PnxRecordBuffer)
                                       : TnxResult;

    {-- record locks --}
    function sbcRecordIsLocked(aLockType    : TnxLockType;
                           out aLockPresent : TnxLockPresent)
                                            : TnxResult; override;
    function sbcRecordLockRelease(aAllLocks    : Boolean;
                                  aCancelBlobs : Boolean)
                                               : TnxResult; override;

    {-- autoinc --}
    function sbcAutoIncGet: TnxWord32; override;
    function sbcAutoIncSet(aAutoInc : TnxWord32): TnxResult; override;
    procedure sbcAutoIncSetDirect(aAutoInc : TnxWord32); override;

    {-- key filters --}
    function sbcGetKeyFieldsSource: InxFieldsSource; override;

    {-- index support --}
    function stcCreateBulkBuilder(out aBulkBuilder : TnxBaseBulkBuilder
                                      {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                                      ;
                                      aException   : PPointer
                                      {$ENDIF}     )
                                                   : TnxResult;

    function stcAddField(aFieldDesc    : TnxFieldDescriptor)
                                       : TnxResult;
    function stcAddIndex(aIndexDesc    : TnxIndexDescriptor;
                         aIsNewDefault : Boolean = False)
                                       : TnxResult;
    function stcDropIndex(const aIndexName : string;
                                aIndexID   : Integer)
                                           : TnxResult;

    function sbcSwitchToIndex(const aIndexName : string;
                                    aIndexID   : Integer;
                                    aPosnOnRec : TnxPosnOnRec)
                                               : TnxResult; override;
    function sbcGetIndexID(out aIndexID : Integer)
                                        : TnxResult; override;

    function sbcSetToKey(aSearchAction : TnxSearchKeyAction;
                         aFieldCount   : Integer;
                         aPartialLen   : Integer;
                         aDirectKey    : Boolean;
                         aKeyData      : PnxKeyOrRecordBuffer)
                                       : TnxResult; override;

    function sbcRecordGetForKey(aFieldCount : integer;
                                aPartialLen : integer;
                                aDirectKey  : Boolean;
                                aKeyData    : PnxKeyOrRecordBuffer;
                                aData       : PnxRecordBuffer;
                                aMatchFirst : Boolean;
                                aFirstCall  : Boolean)
                                            : TnxResult; override;
    function sbcRecordGetForKeyBatch(aCutoffSize : Integer;
                                     aOptions    : TnxRecordGetBatchExOptions;
                                 var aAccess     : TnxBatchStreamAccess;
                               const aKeys       : TnxDataSetKeyBufferArray;
                                     aMatchFirst : Boolean;
                                     aFirstCall  : Boolean)
                                                 : TnxResult; override;

    property RangeStart: TnxRangeInfo read stcRangeStart;
    procedure sbcRangeReset; override;
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
                                      : TnxResult; override;

    function sbcCompareKeys(aFieldCount : Integer;
                            aPartialLen : Integer;
                            aDirectKey1 : Boolean;
                            aKeyData1   : PnxKeyOrRecordBuffer;
                            aDirectKey2 : Boolean;
                            aKeyData2   : PnxKeyOrRecordBuffer;
                        out aResult     : TnxValueRelationship)
                                        : TnxResult; override;

    {-- batch operations --}
    function sbcRecordGetBatch(aCutoffSize : Integer;
                               aOptions    : TnxRecordGetBatchExOptions;
                           var aAccess     : TnxBatchStreamAccess;
                               aMaxRecords : Integer = -1;
                               aForward    : Boolean = True)
                                           : TnxResult; override;
    function stcRecordGetBatchIterator(aCookie : Pointer;
                                       aRefNr  : TnxRefNr;
                                       aRecord : PnxRecordBuffer)
                                               : TnxRecordIteratorResult;

    function sbcRecordInsertBatch(aStream : TnxCustomMemoryStream)
                                          : TnxResult; override;

    function sbcCopyRecords(aDestCursor     : TnxAbstractCursor;
                            aBlobCopyMode   : TnxBlobCopyMode;
                            aMaxTransSize   : Integer;
                            aCheckValFields : Boolean)
                                            : TnxResult; override;

    function sbcDeleteRecords : TnxResult; override;

    {-- blob managment --}
    function stcGetBlobLinkHandler: TnxBaseBlobLinkHandler;

    function BlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                var aReply   : TnxBlobBatchReply)
                                             : TnxResult; override;
    function stcBlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                   var aReply   : TnxBlobBatchReply)
                                                : TnxResult;
    function stcBlobBatchProcessEntry(const aRecID   : TnxRecID;
                                      const aRequest : TnxBlobBatchRequestEntry;
                                        var aReply   : TnxBlobBatchReplyEntry)
                                                     : TnxResult;

    function stcBlobVerifyRecID(const aRecID   : TnxRecID;
                                      aReadOrg : Boolean)
                                               : TnxResult;

    function stcBlobVerifyNr(const aRecID     : TnxRecID;
                                   aFieldNo   : TnxInt32;
                             const aBlobNr    : TnxBlobNr;
                                   aReadOrg   : Boolean;
                                   aNewBlobNr : PnxNewBlobNr)
                                              : TnxResult;
    function stcBlobVerifyNrInner(const aRecID     : TnxRecID;
                                        aFieldNo   : TnxInt32;
                                  const aBlobNr    : TnxBlobNr;
                                        aReadOrg   : Boolean;
                                        aNewBlobNr : PnxNewBlobNr)
                                                   : TnxResult;

    function sbcBlobsCancel(const aRefNr : TnxRefNr)
                                         : TnxResult; override;

    function sbcBlobCreate(const aRecID   : TnxRecID;
                                 aFieldNo : TnxInt32;
                             out aBlobNr  : TnxBlobNr)
                                          : TnxResult; override;
    function sbcBlobCreateFile(const aRecID    : TnxRecID;
                                     aFieldNo  : TnxInt32;
                               const aFileName : string;
                                 out aBlobNr   : TnxBlobNr)
                                               : TnxResult; override;
    function sbcBlobCreateLink(const aRecID       : TnxRecID;
                                     aFieldNo     : TnxInt32;
                               const aTableName   : string;
                               const aTableBlobNr : TnxBlobNr;
                                 out aBlobNr      : TnxBlobNr)
                                                  : TnxResult; override;
    function sbcBlobDelete(const aRecID   : TnxRecID;
                                 aFieldNo : TnxInt32;
                           const aBlobNr  : TnxBlobNr)
                                          : TnxResult; override;
    function sbcBlobFree(const aRecID   : TnxRecID;
                               aFieldNo : TnxInt32;
                         const aBlobNr  : TnxBlobNr)
                                        : TnxResult; override;
    function sbcBlobRead(const aRecID     : TnxRecID;
                               aFieldNo   : TnxInt32;
                         const aBlobNr    : TnxBlobNr;
                               aOffset    : TnxWord32;
                               aLen       : TnxWord32;
                               aStream    : TStream;
                               aReadOrg   : Boolean;
                               aNewBlobNr : PnxNewBlobNr)
                                          : TnxResult; override;
    function sbcBlobReadSnapshoted(const aRecID     : TnxRecID;
                                         aFieldNo   : TnxInt32;
                                   const aBlobNr    : TnxBlobNr;
                                         aOffset    : TnxWord32;
                                         aLen       : TnxWord32;
                                         aStream    : TStream;
                                         aReadOrg   : Boolean;
                                         aBlobLen   : PnxWord32;
                                         aNewBlobNr : PnxNewBlobNr)
                                                    : TnxResult; override;
    function sbcBlobWrite(const aRecID   : TnxRecID;
                                aFieldNo : TnxInt32;
                          const aBlobNr  : TnxBlobNr;
                                aOffset  : TnxWord32;
                                aLen     : TnxWord32;
                          const aBlob    )
                                         : TnxResult; override;
    function sbcBlobReplace(const aRecID   : TnxRecID;
                                  aFieldNo : TnxInt32;
                              var aBlobNr  : TnxBlobNr;
                                  aLen     : TnxWord32;
                            const aBlob    )
                                           : TnxResult; override;
    function sbcBlobAddToCache(const aRecID   : TnxRecID;
                                     aFieldNo : TnxInt32;
                               const aBlobNr  : TnxBlobNr;
                                     aLen     : TnxWord32;
                               const aBlob    )
                                              : TnxResult; override;
    function sbcBlobTruncate(const aRecID      : TnxRecID;
                                   aFieldNo    : TnxInt32;
                             const aBlobNr     : TnxBlobNr;
                                   aBlobLength : TnxWord32)
                                               : TnxResult; override;
    function sbcBlobGetLength(const aRecID     : TnxRecID;
                                    aFieldNo   : TnxInt32;
                              const aBlobNr    : TnxBlobNr;
                                out aLength    : TnxWord32;
                                    aReadOrg   : Boolean;
                                    aNewBlobNr : PnxNewBlobNr)
                                               : TnxResult; override;
    function sbcBlobModified(const aRecID    : TnxRecID;
                                   aFieldNo  : TnxInt32;
                             const aBlobNr   : TnxBlobNr;
                               out aModified : Boolean)
                                             : TnxResult; override;

    function sbcBlobCopyPrim(aSrcCursor   : TnxServerBaseCursor;
                             aSrcFieldNo  : TnxInt32;
                       const aBlobNr      : TnxBlobNr;
                             aDestFieldNo : TnxInt32;
                         out aDestBlobNr  : TnxBlobNr;
                             aMaxLength   : TnxWord32 = High(TnxWord32))
                                          : TnxResult; override;
    function sbcBlobCopyContentPrim(aSrcCursor   : TnxServerBaseCursor;
                                    aSrcFieldNo  : TnxInt32;
                              const aBlobNr      : TnxBlobNr;
                                    aDestFieldNo : TnxInt32;
                              const aDestBlobNr  : TnxBlobNr;
                                    aMaxLength   : TnxWord32 = High(TnxWord32))
                                                 : TnxResult; override;

    function sbcBlobIsLink(const aRecID          : TnxRecID;
                                 aFieldNo        : TnxInt32;
                                 aBlobNr         : TnxBlobNr;
                             out aSrcTableName   : string;
                             out aSrcTableBlobNr : TnxBlobNr)
                                                 : Boolean; override;

    function ascGetBlobCacheInfos(const aRecID : TnxRecID;
                                    out aBCIs  : TnxBlobCacheInfos)
                                               : TnxResult; override;

    function ascSetBlobCacheFlushed(const aRecID     : TnxRecID;
                                          aFieldNo   : TnxInt32;
                                    const aBlobNr    : TnxBlobNr;
                                          aNewBlobNr : PnxBlobNr = nil)
                                                     : TnxResult; override;

    {-- table streams --}
    function sbcTableStreamGetList(aStreams  : TStrings;
                                   aInternal : Boolean)
                                             : TnxResult; override;
    function sbcTableStreamWrite(const aName     : string;
                                       aStream   : TStream;
                                       aInternal : Boolean)
                                                 : TnxResult; override;
    function sbcTableStreamRead(const aName     : string;
                                      aStream   : TStream;
                                      aInternal : Boolean)
                                                : TnxResult; override;
    function sbcTableStreamDelete(const aName     : string;
                                        aInternal : Boolean)
                                                  : TnxResult; override;

    {-- table locks --}
    function sbcTableIsLocked(aLockType : TnxLockType)
                                        : TnxLockPresent; override;
    function sbcTableLockAcquire(aLockType : TnxLockType)
                                           : TnxResult; override;
    function sbcTableLockRelease(aLockType : TnxLockType;
                                 aAllLocks : Boolean)
                                           : TnxResult; override;
    {-- misc --}
    function sbcDuplicate(aOpenMode    : TnxOpenMode;
                      out aNewCursorID : TnxAbstractCursor;
                          aForceWrite  : Boolean = False)
                                       : TnxResult; override;

    function sbcChangePassword(const aNewPassword : UnicodeString)
                                                  : TnxResult; override;
    function sbcExtractPassword: UnicodeString; override;

    {-- information --}
    function sbcGetRecordCount(aOption   : TnxRecordCountOption;
                           out aRecCount : TnxWord32;
                               aEstimate : Boolean = False)
                                         : TnxResult; override;

    {-- sql engine support --}
    procedure sbcIterate(aData         : PPnxRecordBuffer;
                         aKeyIterator  : TnxKeyIterator;
                         aRecIterator  : TnxRecordIterator;
                         aBackward     : Boolean;
                         aCookie       : Pointer;
                         aKeepPosition : Boolean = False;
                         aResult       : PnxResult = nil;
                         aLongFilter   : Boolean = True); override;
    function stcSortRecords(aIndexDesc : TnxIndexDescriptor)
                                       : TnxResult;
    function sacHasKey(aIndex: Integer; aValue: Variant): Boolean; override;
    function sacGetRefNr: TnxRefNr; override;
    procedure sacSetRefNr(const aRefNr: TnxRefNr); override;
    function sacGetRecordByID(const aRefNr        : TnxRefNr;
                                    aRecordBuffer : PnxRecordBuffer)
                                                  : TnxResult; override;

    {-- record buffer caching --}
    function stcGetBlobs(aData       : PnxRecordBuffer;
                         aMarkedOnly : Boolean;
                     var aBlobCount  : TnxWord16;
                         aBlobNrs    : PnxBlobNr)
                                     : TnxResult;

    function stcContainsLSNRefNr(var aLSN   : TnxLSN;
                                 var aRefNr : TnxRefNr)
                                            : TnxResult;

    function stcGetDeletedRecords(aFromLSN    : TnxLSN;
                              out aCacheInfos : TnxRecordCacheInfos;
                                  aMaxCount   : Integer = High(Integer);
                                  aCurrentLSN : PnxLSN = nil)
                                              : TnxResult;
    function stcGetDeletedRecordsKeyIterator(aCookie : Pointer;
                                             aRefNr  : TnxRefNr;
                                             aKey    : PnxKeyBuffer)
                                                     : TnxKeyIteratorResult;
  public
    constructor Create(aDelayInformMonitors : Boolean;
                       aDatabase            : TnxServerDatabase;
                       aTransContext        : TnxAbstractTransContext;
                       aTable               : TnxServerBaseTable;
                       aTimeout             : TnxWord32;
                       aOpenMode            : TnxOpenMode;
                       aShareMode           : TnxShareMode;
                       aIndexName           : string;
                       aIndexID             : Integer;
                       aBlobCache           : Boolean;
                       aInternal            : Boolean);
    constructor CreateResultSet(aDatabase     : TnxServerDatabase;
                                aTransContext : TnxAbstractTransContext;
                                aDictionary   : TnxDataDictionary;
                                aTimeout      : TnxWord32);
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    function NotifyExtenders(aAction : TnxEngineAction;
                             aBefore : Boolean;
                       const aArgs   : array of const)
                                     : TnxResult; override;

    function SavePath: TnxResult; override;
    function RestorePath: TnxResult; override;

    function GetRecordCountExAsync(aOption   : TnxRecordCountOption;
                               out aTaskInfo : TnxAbstractTaskInfo)
                                             : TnxResult; override;

    {=== index support ===}

    function BuildKey(aRecord       : PnxRecordBuffer;
                      aKey          : PnxKeyBuffer;
                      aIgnoreFilter : Boolean)
                                    : TnxResult; override;

    function KeyToRecord(aKey    : PnxKeyBuffer;
                         aRecord : PnxRecordBuffer)
                                 : TnxResult; override;

    {=== TnxNextLSNDefaultValueEngine support ===}
    function GetNextLSN(var aLSN: TnxLSN): Boolean; override;

    {=== remoting integration ===}
    function CreateInstanceFor(const aName        : string;
                               const aClassID     : TnxGuid;
                               const aOuter       : InxInterface;
                               const aInterfaceID : TnxGuid;
                                 out aInterface   )
                                                  : HRESULT; override;

    {=== record buffer caching ===}
    function GetBlobs(aData       : PnxRecordBuffer;
                      aMarkedOnly : Boolean;
                  var aBlobCount  : TnxWord16;
                      aBlobNrs    : PnxBlobNr)
                                  : TnxResult; override;

    function ContainsLSNRefNr(var aLSN   : TnxLSN;
                              var aRefNr : TnxRefNr)
                                         : TnxResult; override;

    function GetDeletedRecords(aFromLSN    : TnxLSN;
                           out aCacheInfos : TnxRecordCacheInfos;
                               aMaxCount   : Integer = High(Integer);
                               aCurrentLSN : PnxLSN = nil)
                                           : TnxResult; override;


    property Table: TnxServerBaseTable
      read stcTable;

    property IndexPath: TnxBaseIndexPath
      read stcIndexPath;
  end;

  TnxServerStatement = class(TnxAbstractStatement)
  protected
    function ssPrepare(aStatementType : TnxStatementType;
                 const aQueryText     : WideString;
                       aStream        : TStream)
                                      : TnxResult; virtual; abstract;

    function ssExec(out aCursor   : TnxAbstractCursor;
                        aOpenMode : TnxOpenMode;
                        aStream   : TStream)
                                  : TnxResult; virtual; abstract;

    function ssSetParams(const aParams : TnxSqlParamList;
                               aStream : TStream)
                                       : TnxResult; virtual; abstract;

    function ssGetParams(const aParams : TnxSqlParamList;
                               aStream : TStream)
                                       : TnxResult; virtual; abstract;
  public
    constructor Create(aDatabase : TnxSqlAbstractDatabase;
                       aTimeout  : TnxWord32);

    function Prepare(aStatementType : TnxStatementType;
               const aQueryText     : WideString;
                     aStream        : TStream)
                                    : TnxResult; override;

    function Exec(out aCursor   : TnxAbstractCursor;
                      aOpenMode : TnxOpenMode;
                      aStream   : TStream)
                                : TnxResult; override;

    function SetParams(const aParams : TnxSqlParamList;
                             aStream : TStream)
                                     : TnxResult; override;

    function GetParams(const aParams : TnxSqlParamList;
                             aStream : TStream)
                                     : TnxResult; override;
  end;
//DOM-IGNORE-END

{
  The AliasHandler is responsible for all adding, changing and removing of
  Aliases. You can always get the active alias handler via the TnxServerEngine.AliasHandler
  property. While this documentation is for the abstract base class there's
  always an implementing class in place in NexusDB.
}
  TnxBaseAliasHandler = class(TnxComponent)
  public
    procedure GetConfigSettings(aSettings: TnxBaseSettings); override;
    procedure LoadConfig(aConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(aConfig: TnxBaseComponentConfiguration); override;

    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;

    // delete all Aliases
    procedure Clear; virtual; abstract;

    // Adds an alias. Returns an error if it exists already.
    function Add(const aAlias   : string;
                 const aPath    : string;
                       aEnforce : Boolean)
                                : TnxResult; virtual; abstract;
    // Deletes an alias. Returns an error if it doesn't exist.
    function Delete(const aAlias : string)
                                 : TnxResult; virtual; abstract;
    // Changes the path of an alias. Returns an error if it doesn't exist.
    function Modify(const aAlias   : string;
                    const aNewName : string;
                    const aNewPath : string;
                          aEnforce : Boolean)
                                   : TnxResult; virtual; abstract;

    // Returns a list of all registered Aliases. The objects are TnxAliasDescriptor
    // instances.
    function GetList(aList : TObjectList)
                           : TnxResult; virtual; abstract;
    // Returns the path of an alias. Returns an error if the alias doesn't exist.
    function GetPath(const aAlias : string;
                       var aPath  : string)
                                  : TnxResult; virtual; abstract;

    // Returns true if the given Alias exists.
    function IsAlias(const aAlias : string)
                                  : Boolean;
  end;

//DOM-IGNORE-BEGIN
  TnxSimpleAliasHandler = class(TnxBaseAliasHandler)
  protected {private}
    sahList : TStringList;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear; override;

    function Add(const aAlias   : string;
                 const aPath    : string;
                       aEnforce : Boolean)
                                : TnxResult; override;
    function Delete(const aAlias : string)
                                 : TnxResult; override;
    function Modify(const aAlias   : string;
                    const aNewName : string;
                    const aNewPath : string;
                          aEnforce : Boolean)
                                   : TnxResult; override;

    function GetList(aList : TObjectList)
                           : TnxResult; override;
    function GetPath(const aAlias : string;
                       var aPath  : string)
                                  : TnxResult; override;
  end;

  TnxServerEngineOption = (
    seoReadOnly,
    seoForceFailSafe,
    seoCloseInactiveFolders,
    seoCloseInactiveTables,
    seoInMemOnly,
    seoIsSecure,
    seoVerifyTableNames,
    seoCloseAllWhenInactive,
    seoKeepSessionStats);

  TnxServerEngineOptions = set of TnxServerEngineOption;
//DOM-IGNORE-END

  { The core NexusDB server engine component. This component integrates
    the full functionality of an embedded database engine. Use as the
    core of a custom standalone server, or in your app to add
    embedded database capability.
  }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxServerEngine = class(TnxBaseServerEngine)
  protected {private}
    seBufferManager       : TnxBufferManager;
    seCleanupThread       : TnxSimpleTimerThread;

    seServerGuid          : TnxGuid;

    seMaxRAM              : Integer;
    seTempStorePath       : string;
    seTempStoreSize       : Integer;

    seTableExtension      : string;

    seFoldersPadlock      : TnxPadlock;
    seFolders             : TStringList;

    {uses seFoldersPadlock}
    seInactiveTablesPadlock : TnxPadlock;
    seInactiveTablesHead    : TnxServerRootTable;
    seInactiveTablesTail    : TnxServerRootTable;
    seInactiveTablesCount   : Integer;

    seInactiveFoldersPadlock : TnxPadlock;
    seInactiveFoldersHead    : TnxServerFolder;
    seInactiveFoldersTail    : TnxServerFolder;
    seInactiveFoldersCount   : Integer;

    seAliasHandler        : TnxBaseAliasHandler;
    seSqlEngine           : TnxBaseSqlEngine;

    seServerName          : string;
    seOptions             : TnxServerEngineOptions;

    seFolderCount         : Integer;
    seTableCount          : Integer;

    seExecutingStatements : Integer;
    seExecutedStatements  : Integer;

    procedure seSetMaxRAM(const Value: Integer);
    procedure seSetTempStorePath(const Value: string);
    procedure seSetTempStoreSize(const Value: Integer);

    procedure seSetTableExtension(const Value: string);

    procedure seSetAliasHandler(const Value : TnxBaseAliasHandler);
    procedure seSetSqlEngine(const Value: TnxBaseSqlEngine);

    function seGetMaxRAM: Integer;
    function seGetTempStoreSize: Integer;
    function seGetTempStorePath: string;
    function seGetServerName: string;
    procedure seSetServerName(const Value: string);
    function seGetOptions: TnxServerEngineOptions;
    procedure seSetOptions(const Value: TnxServerEngineOptions);
  protected
    procedure SetName(const NewName: TComponentName); override;

    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure scStateChanged(aOldState, aNewState: TnxState); override;

    procedure scInitializing; override;
    procedure scDeactivating; override;
    procedure scStarting; override;
    procedure scStopping; override;

    function bseGetExceptionClass: EnxExceptionClass; override;
    function bseGetServerGuid: TnxGuid; override;
    function bseGetServerName: string; override;

    function seCreateAliasHandler: TnxBaseAliasHandler; virtual;

    function seGetSessionClass : TnxServerSessionClass; virtual;
    function seSessionOpen(out aSession       : TnxAbstractSession;
                         const aUserName      : UnicodeString;
                         const aPassword      : UnicodeString;
                         const aConnectedFrom : string;
                               aTimeout       : TnxWord32;
                               aClientVersion : Integer)
                                              : TnxResult; virtual;

    procedure seCleanupCallback(aSender: TObject);

    function bseCreateInstanceFor(aSession     : TnxAbstractSession;
                            const aName        : string;
                            const aClassID     : TnxGuid;
                            const aOuter       : InxInterface;
                            const aInterfaceID : TnxGuid;
                              out aInterface   )
                                               : HRESULT; override;

    procedure bseInactive; override;
    function bseGetKeepSessionStats: Boolean; override;
  public {protected}
    function seCloseInactiveFolders : TnxResult;
    function seCloseInactiveTables : TnxResult;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function IsSecureServer: Boolean; override;

    procedure GetConfigSettings(aSettings: TnxBaseSettings); override;
    procedure LoadConfig(aConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(aConfig: TnxBaseComponentConfiguration); override;
    function  GetDisplayOnlyValue(aValueName: string): string; override;

    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;

    { Gets statistic value captions.
    }
    procedure GetStatsCaptions(const aList: TStrings); override;
    { Gets statistic values.
    }
    procedure GetStatsValues(const aList: TStrings); override;

    { Get info on active transactions for #TRANSACTION_LOCKS
    }
    function GetTransactionInfo : TnxTransactionLockInfoArray;
    { Get info on active record locks for #RECORD_LOCKS
    }
    function GetRecordLockInfo : TnxRecordLockInfoArray;

    function SessionOpenEx(out aSession       : TnxAbstractSession;
                         const aUserName      : UnicodeString;
                         const aPassword      : UnicodeString;
                         const aConnectedFrom : string;
                               aTimeout       : TnxWord32;
                               aClientVersion : Integer)
                                              : TnxResult; override;

    property BufferManager : TnxBufferManager
      read seBufferManager;

    { The number of currently open folders.
    }
    property FolderCount: Integer
      read seFolderCount;
    { The number of currently open tables.
    }
    property TableCount: Integer
      read seTableCount;
  published
    { The maximum amount of physical RAM the serverengine will use for
      database block storage, in MB. Depending on the total amount of
      physical memory available, the -1 default value translates to:

      Physical Memory
        <= 4GB           - block storage equals half of physical memory
                          (under 32 bit, the max value is 1536)
        > 4GB, <= 10 GB  - block storage equals physical memory minus 2GB
        > 10GB           - block storage equals 80% of physical memory

      Note that for 32 bit processes, physical memory can exceed 4GB
      if the AWE extension DLL is used.
    }
    property MaxRAM: Integer
      read seGetMaxRAM
      write seSetMaxRAM
      default -1;

    { The drive and path for temporary storage. If blank, will use the
      system user path for temp files.
    }
    property TempStorePath: string
      read seGetTempStorePath
      write seSetTempStorePath;

    { The maximum amount of temporary storage the engine will allocate on disk.
      The default, -1, is calculated as the smallest of these 3 values:
      - 1/3 of available space on the chosen drive
      - 10 * physical RAM
      - 1/3 of the maximum file size of the file system
    }
    property TempStoreSize: Integer
      read seGetTempStoreSize
      write seSetTempStoreSize
      default -1;

    { The alias allows to add, change and delete aliases.
    }
    property AliasHandler: TnxBaseAliasHandler
      read seAliasHandler;

    { If SQL capability is required, add a TnxSQLEngine to your datamodule
      and point this property to it.
    }
    property SqlEngine: TnxBaseSqlEngine
      read seSqlEngine
      write seSetSqlEngine;

    { Descriptive name for your server. The name is returned as part of the
      servername when clients browse for servers.
    }
    property ServerName: string
      read seGetServerName
      write seSetServerName;

    { Various options:

        seoReadOnly - activate if no writing is required, allows for sharing databases between servers
        seoForceFailSafe - always use failsafe transactions
        seoCloseInactiveFolders - ensure folders are closed and not kept open for speed
        seoCloseInactiveTables - ensure tables are closed and not kept open for speed
        seoInMemOnly - activate to ensure that no writing to disk takes place (e.g. by SQL resultsets)
        seoIsSecure - activate to enforce use of usernames and password
        seoVerifyTableNames - activate to enforce tablename verification
        seoCloseAllWhenInactive - closes all tables and folders when session count goes to 0
        seoKeepSessionStats - keeps per session stats

    }
    property Options: TnxServerEngineOptions
      read seGetOptions
      write seSetOptions;

    { Specifies the file extension (without the leading '.' to be used for
      NexusDB tables. Default is 'nx1'.
    }
    property TableExtension: string
      read seTableExtension
      write seSetTableExtension;
  end;

//DOM-IGNORE-BEGIN
  TnxServerTaskThread = class(TnxInitThread)
  protected {private}
    sttTaskInfo: TnxServerTaskInfo;
  public
    constructor Create(aTaskInfo: TnxServerTaskInfo);

    procedure DoBeforeExecute; override;
    procedure InnerExecute; override;
  end;

  TnxServerRestructureContainer = class;

  TnxServerRestructureTaskInfo = class(TnxServerTaskInfo)
  protected {private}
    rtiContainer    : TnxServerRestructureContainer;
  public
    constructor Create(aContainer: TnxServerRestructureContainer);
    destructor Destroy; override;

    procedure Execute; override;
  end;

  TnxServerRestructureNode = class(TnxObject)
  protected {private}
    srnOwner        : TnxServerRestructureContainer;
    srnSourceCursor : TnxServerTableCursor;
    srnTargetCursor : TnxServerTableCursor;
    srnMapperDesc   : TnxBaseRecordMapperDescriptor;
    srnRecordCount  : TnxWord32;
    srnBulkBuilder  : TnxBaseBulkBuilder;

    srnBuffer       : PnxRecordBuffer;
    srnError        : TnxResult;
  protected
    TransactionStarted : Boolean;

    RecordsWritten     : TnxWord32;
    RecordsRead        : TnxWord32;

    RecordMapper       : TnxBaseRecordMapperEngine;

    function RestructureIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
  public
    constructor Create(aOwner        : TnxServerRestructureContainer;
                       aSourceCursor : TnxServerTableCursor;
                       aTargetCursor : TnxServerTableCursor;
                       aMapperDesc   : TnxBaseRecordMapperDescriptor);
    destructor Destroy; override;

    function MakeSnapshot(aRecordsRead    : TnxWord32;
                          aRecordsWritten : TnxWord32;
                          aErrorCode      : TnxResult)
                                          : Boolean;

    procedure Execute;
  end;

  TnxServerRestructureContainer = class(TnxObject)
  protected {private}
    srcOwner                 : TnxServerRestructureTaskInfo;
    srcNodes                 : TnxList;
    srcSourceDatabase        : TnxServerDatabase;
    srcTargetDatabase        : TnxServerDatabase;
    srcMapperDesc            : TnxBaseTableMapperDescriptor;
    srcPassword              : UnicodeString;
    srcSourceName            : string;
    srcTargetName            : string;

    srcSourceShareMode       : TnxShareMode;

    srcBaseRecordsRead       : TnxWord32;
    srcBaseRecordsWritten    : TnxWord32;
    srcCurrentRecordsRead    : TnxWord32;
    srcCurrentRecordsWritten : TnxWord32;
  protected
    procedure srcIterateMappers(const aName       : string;
                                      aMapperDesc : TnxBaseTableMapperDescriptor);
    procedure srcProcessMapper(const aName       : string;
                                     aMapperDesc : TnxBaseTableMapperDescriptor);
  public
    constructor Create(aSourceCursor : TnxServerTableCursor;
                       aTargetCursor : TnxServerTableCursor;
                       aMapperDesc   : TnxBaseTableMapperDescriptor);
    destructor Destroy; override;

    procedure Execute;

    function MakeSnapshot(aRecordsRead    : TnxWord32;
                          aRecordsWritten : TnxWord32;
                          aErrorCode      : TnxResult)
                                          : Boolean;

    function GetSession     : TnxServerSession;
    function GetRecordCount : TnxWord32;
  end;

  TnxBaseServerRebuildIndexTaskInfo = class(TnxServerTaskInfo)
  protected {private}
    riiDatabase : TnxServerDatabase;
    riiCursor   : TnxServerTableCursor;
    riiIndexID  : Integer;
  protected
    riiError              : TnxResult;
    riiBuffer             : PnxRecordBuffer;

    riiBulkBuilder        : TnxBaseBulkBuilder;

    riiTransactionStarted : Boolean;
    riiMaxTransSize       : Integer;

    riiRecordsRead        : TnxWord32;
    riiRecordsWritten     : TnxWord32;
    riiIndexEngine        : TnxBaseIndexEngine;
    riiKey                : PnxKeyBuffer;

    function RebuildIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
  public
    constructor Create(aCursor      : TnxServerTableCursor;
                       aIndexID     : Integer);

    procedure Execute; override;
  end;

  TnxServerRebuildIndexTaskInfo = class(TnxBaseServerRebuildIndexTaskInfo)
  public
    destructor Destroy; override;
  end;

  TnxServerGetRecCountTaskInfo = class(TnxServerTaskInfo)
  protected {private}
    rciDatabase : TnxServerDatabase;
    rciCursor   : TnxServerBaseCursor;
    rciOption   : TnxRecordCountOption;
  protected
  public
    constructor Create(aOption      : TnxRecordCountOption;
                       aRecordCount : TnxWord32;
                       aCursor      : TnxServerBaseCursor);
    destructor Destroy; override;

    procedure Execute; override;
  end;
(*
  TnxServerTableToStreamContainer = class;

  TnxServerTableToStreamTaskInfo = class(TnxServerTaskInfo);
//  protected {private}
//    rtiContainer    : TnxServerTableToStreamContainer;
//  public
//    constructor Create(aContainer: TnxServerTableToStreamContainer);
//    destructor Destroy; override;
//
//    procedure Execute; override;
//  end;

  TnxStreamMarker = (
    smString,
    smVersion,
    smTableStream,
    smTable
  );

  TnxTableToStreamStream = class(TStream)
  public
    procedure WriteBegin(aMarker: TnxStreamMarker); virtual; abstract;
    procedure WriteEnd(aMarker: TnxStreamMarker); virtual; abstract;

    procedure WriteMarker(aMarker: TnxStreamMarker); virtual; abstract;

    procedure WriteString(const aString: string); virtual; abstract;
    procedure WriteVersion(aVersion: Integer); virtual; abstract;
  end;

  TnxServerTableToStreamNode = class(TnxObject)
  protected {private}
    ttsnOwner        : TnxServerTableToStreamContainer;
    ttsnSourceCursor : TnxServerTableCursor;
    ttsnRecordCount  : TnxWord32;
  protected
  public
    constructor Create(aOwner        : TnxServerTableToStreamContainer;
                       aSourceCursor : TnxServerTableCursor);
    destructor Destroy; override;

    function MakeSnapshot(aRecordsRead    : TnxWord32;
                          aErrorCode      : TnxResult)
                                          : Boolean;

    procedure Execute(aStream: TnxTableToStreamStream);
  end;

  TnxServerTableToStreamContainer = class(TnxObject)
  protected {private}
    ttscOwner                 : TnxServerTableToStreamTaskInfo;
    ttscNodes                 : TnxList;
    ttscDatabase              : TnxServerDatabase;

    ttscBaseRecordsRead       : TnxWord32;
    ttscCurrentRecordsRead    : TnxWord32;
  public
    constructor Create(aSourceCursor : TnxServerTableCursor);
    destructor Destroy; override;

    procedure Execute(aStream: TnxTableToStreamStream);

    function MakeSnapshot(aRecordsRead    : TnxWord32;
                          aErrorCode      : TnxResult)
                                          : Boolean;

    function GetSession     : TnxServerSession;
    function GetRecordCount : TnxWord32;
  end;
*)

  TnxServerRecoverContainer = class;

  TnxServerRecoverTaskInfo = class(TnxServerTaskInfo)
  protected {private}
    rtiContainer    : TnxServerRecoverContainer;
  public
    constructor Create(aContainer: TnxServerRecoverContainer);
    destructor Destroy; override;

    procedure Execute; override;
  end;

  TnxServerRecoverNode = class(TnxObject)
  protected {private}
    srnOwner        : TnxServerRecoverContainer;
    srnSourceCursor : TnxServerTableCursor;
    srnTargetCursor : TnxServerTableCursor;
    srnFailedCursor : TnxServerTableCursor;
    srnBlobFields   : TnxList;

    srnID           : Integer;
    srnFileNumber   : Integer;
  protected
  public
    constructor Create(aOwner        : TnxServerRecoverContainer;
                       aSourceCursor : TnxServerTableCursor;
                       aTargetCursor : TnxServerTableCursor;
                       aFailedCursor : TnxServerTableCursor);
    destructor Destroy; override;

    function IterateBlock(aCookie  : Pointer;
                          aBlockNr : TnxBlockNumber;
                          aBlock   : PnxBlock)
                                   : TnxBlockIteratorResult;
  end;

  TnxServerRecoverContainer = class(TnxObject)
  protected {private}
    srcOwner                 : TnxServerRecoverTaskInfo;
    srcNodes                 : TnxList;

    srcSourceRootTable       : TnxServerRootTable;

    srcSourceDatabase        : TnxServerDatabase;
    srcTargetDatabase        : TnxServerDatabase;

    srcPassword              : UnicodeString;
    srcSourceName            : string;
    srcTargetName            : string;
    srcFailedName            : string;

    srcBaseBlocksRead        : TnxWord32;
    srcBaseBlocksWritten     : TnxWord32;
    srcCurrentBlocksRead     : TnxWord32;
    srcCurrentBlocksWritten  : TnxWord32;

    srcBlocksRead            : TnxWord32;
    srcBlocksWritten         : TnxWord32;

    srcIDMap                 : array of array of TnxServerRecoverNode;
    srcFiles                 : TnxBaseFiles;
  protected
    procedure srcIterateMappers(const aName       : string;
                                      aMapperDesc : TnxBaseTableMapperDescriptor);
    procedure srcProcessMapper(const aName       : string;
                                     aMapperDesc : TnxBaseTableMapperDescriptor);

    procedure srcBuildMap;
    procedure srcGetFiles;

    function srcBlockIterator(aCookie: Pointer; aBlockNr: TnxBlockNumber; aBlock: PnxBlock): TnxBlockIteratorResult;
  public
    constructor Create(aSourceCursor : TnxServerTableCursor;
                       aTargetCursor : TnxServerTableCursor;
                       aFailedCursor : TnxServerTableCursor);
    destructor Destroy; override;

    procedure Execute;

    function MakeSnapshot(aBlocksRead    : TnxWord32;
                          aBlocksWritten : TnxWord32;
                          aErrorCode     : TnxResult)
                                         : Boolean;

    function GetSession         : TnxServerSession;
    function GetTotalBlockCount : TnxWord32;
  end;

  TnxServerVerifyChecksumTaskInfo = class(TnxServerTaskInfo)
  protected {private}
    vctiRaw          : Boolean;
    vctiForceRecheck : Boolean;

    vctiCursor       : TnxServerTableCursor;
    vctiTable        : TnxServerRootTable;

    vctiFiles        : TnxBaseFiles;
    vctiFile         : TnxBaseFile;

    vctiError        : TnxResult;
    vctiCount        : TnxWord32;

    vctiChecksum     : TnxBytes;

    function vctiBlockIterator(aCookie  : Pointer;
                               aBlockNr : TnxBlockNumber;
                               aBlock   : PnxBlock)
                                        : TnxBlockIteratorResult;
    function vctiBlockCookieIterator(aCookie      : Pointer;
                                     aBlockNr     : TnxBlockNumber;
                                     aBlock       : PnxBlock;
                                     aBlockCookie : TnxBytes)
                                                  : TnxBlockIteratorResult;
  public
    constructor Create(aCursor: TnxServerTableCursor; aRaw, aForceRecheck: Boolean);
    destructor Destroy; override;

    procedure Execute; override;
  end;


var
  _DesigntimeActiveServerEngines: TComponentList;
//DOM-IGNORE-END

implementation

uses
  {any uses here indicates that a circular reference exists}
  nxsrBlobHandlerCaching,
  nxsrBlobHandlerCached,
  nxsrFieldMapper,
  nxsrFieldMapperEngineAutoInc,
  nxsrSortEngineBase;

resourcestring
  rsSRequiresAnAliasHandler = '%s requires an AliasHandler';
  rsAliasTypeSNotSupported = 'AliasType ''%s'' not supported';
  rsTsPersistentNotSupported = 'TableScope tsPersistent is not supported for' +
  ' in-memory database';
  rsRebuildingIsNotSupported = 'Rebuilding is not supported for this index';
  rsSIsNotSupportedByS = '%s is not supported by %s';
  rsAutoIncSetNotSupported = 'AutoIncSet is only supported for tables with a' +
  'utoinc engines';
  rsTableSNoFileChecksum = 'Table %s is not using an encryption engine that ' +
  'supports file checksums.';
  rsCurrentNLSVersionIndexDisabled = 'La versión actual del NLS difiere de la ' +
  'versión de las claves almacenadas. La tabla debe ser empaquetada para poder usar el índice';  //..
  rsContainsExtendedIndexDisabled = 'Index contains extended fields. The ' +
  'extended data type is not supported under 64bit. Table must be restructured ' +
  'to change extended fields to double fields before index can be used';
  rsTableFormatOutdated = 'Table format outdated. Table must be packed to en' +
  'able write access';
  rsCurrentNLSVersionTableReadOnly = 'Table contains one or more indices where NLS v' +
  'ersion of stored keys differs from current NLS version. Table must be pac' +
  'ked to enable write access';
  rsContainsExtendedTableReadOnly = 'Table contains one or more indices with ' +
  'extended fields. The extended data type is not supported under 64bit. Table ' +
  'must be restructured to change extended fields to double fields to enable write access';
  rsPatchPPLrequired = 'The server must be compiled with nxPatchPPL for this' +
  ' operation. Add the nxPatchPPL unit to your project''s USES clause, after any memory management units listed.';
  rsFolderAlreadyOpen = 'Folder already open with conflicting cache mode';
  rsDatabaseDoesNotSu = 'Database does not support opening of cache cursors';
  rsDatabaseDoesOnlySu = 'Database does only support opening of cache cursors';
  rsTableHasConflictin = 'Table has conflicting cache mode';
  rsTheGraveyardIsCorruptedCouldNotAdd = 'The graveyard is corrupted. Could ' +
  'not add deleted RefNr and LSN to graveyard.';
  rsTheGraveyardIsCorruptedCouldNotRemove = 'The graveyard is corrupted. Could ' +
  'not remove previously deleted RefNr and LSN from graveyard.';

{$IFDEF NX_LITE}
{$I Lite\nxLite3.inc}
{$ENDIF}

{$IFNDEF DCC25OrLater}
function GetTickCount64: UInt64; stdcall; external kernel32 name 'GetTickCount64';
{$ENDIF}

threadvar
  _ForRecover: Boolean;

{===TnxServerTaskInfo==========================================================}
function TnxServerTaskInfo.Cancel: TnxResult;
begin
  Result := DBIERR_NONE;
  try
    if stiCancelled then
      Exit;

    stiPadlock.Lock;
    try
      stiCancelled := True;
      with stiStatus do begin
        tsErrorCode := DBIERR_UPDATEABORT;
        tsErrorMessage := '';
        tsSnapshotTime := GetTickCount;
        tsFinished := True;
      end;
    finally
      stiPadlock.Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxServerTaskInfo.Create(aSession        : TnxServerSession;
                                     aTotalRecords   : TnxWord32;
                                     aThreadPriority : TThreadPriority = tpNormal);
begin
  stiThreadPriority := aThreadPriority;
  stiStartEvt := TnxEvent.Create;
  stiPadlock := TnxPadlock.Create(True);
  stiStatus.tsTotalRecs := aTotalRecords;
  stiStatus.tsStartTime := GetTickCount;
  inherited Create(aSession);
end;
{------------------------------------------------------------------------------}
destructor TnxServerTaskInfo.Destroy;
begin
  if stiExecuting then begin
    stiCancelled := True;
    while stiExecuting do
      Sleep(100);
  end;
  inherited;
  nxFreeAndNil(stiPadlock);
  nxFreeAndNil(stiStartEvt);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTaskInfo.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Cancelled', stiCancelled);
  aContainer.AddValue('Executing', stiExecuting);
end;
{------------------------------------------------------------------------------}
function TnxServerTaskInfo.GetStatus(out aCompleted : Boolean;
                                     out aStatus    : TnxTaskStatus)
                                                    : TnxResult;
begin
  Result := DBIERR_NONE;
  try
    stiPadlock.Lock;
    try
      aCompleted := stiStatus.tsFinished;
      aStatus := stiStatus;
      with aStatus do
        if (tsErrorCode <> DBIERR_NONE) then
          EnxBaseException.SetLastConvertedException(tsErrorCode, tsErrorMessage);
    finally
      stiPadlock.Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTaskInfo.Init;
begin
  {can be overriden}
end;
{------------------------------------------------------------------------------}
function TnxServerTaskInfo.MakeSnapshot(aRecordsRead    : TnxWord32;
                                        aRecordsWritten : TnxWord32;
                                        aErrorCode      : TnxResult)
                                                        : Boolean;
var
  Dividend  : TnxWord32;
  Divisor   : TnxWord32;
  LastError : TnxResult;
begin
  Result := False;
  stiPadlock.Lock;
  try
    if stiCancelled then
      Result := True
    else
      with stiStatus do begin
        tsRecsRead := aRecordsRead;
        tsRecsWritten := aRecordsWritten;
        tsErrorCode := aErrorCode;
        EnxBaseException.GetLastConvertedException(LastError, tsErrorMessage);
        if LastError <> tsErrorCode then
          tsErrorMessage := '';
        tsSnapshotTime := GetTickCount;
        if (tsRecsRead >= $1000000) then begin
          Dividend := (tsRecsRead shr 7) * 100;
          Divisor := tsTotalRecs shr 7;
        end else begin
          Dividend := tsRecsRead * 100;
          Divisor := tsTotalRecs;
        end;
        if Divisor <> 0 then
          tsPercentDone := nxMinW32(100, Dividend div Divisor)
        else
          tsPercentDone := 0;
      end;
  finally
    stiPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTaskInfo.MarkFinished;
begin
  stiPadlock.Lock;
  try
    stiStatus.tsFinished := true;
  finally
    stiPadlock.Unlock;
  end;
end;
{==============================================================================}



{===TnxServerSession===========================================================}
function TnxServerSession.AliasAdd(const aAlias   : string;
                                   const aPath    : string;
                                         aEnforce : Boolean)
                                                  : TnxResult;
begin
  Result := nxCheckValidAliasName(aAlias, False);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  try
    with TnxServerEngine(asServerEngine) do begin
      if Assigned(seAliasHandler) then begin
        Result := Self.NotifyExtenders(eaAliasAdd, True, [aAlias, aPath, aEnforce]);
        if Result = DBIERR_NONE then begin
          Result := seAliasHandler.Add(aAlias, aPath, aEnforce);
          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaAliasAdd, False, [aAlias, aPath, aEnforce]);
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasAdd']);
      seAliasHandler.nxcNotifyBroadcast(nxn_ConfigChanged, nil, ['TnxSession', 'TnxDatabase', 'TnxCursor']);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.AliasDelete(const aAlias : string)
                                                   : TnxResult;
begin
  Result := nxCheckValidAliasName(aAlias, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  try
    with TnxServerEngine(asServerEngine) do begin
      if Assigned(seAliasHandler) then begin
        Result := Self.NotifyExtenders(eaAliasDelete, True, [aAlias]);
        if Result = DBIERR_NONE then begin
          Result := seAliasHandler.Delete(aAlias);
          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaAliasDelete, False, [aAlias]);
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasDelete']);
      seAliasHandler.nxcNotifyBroadcast(nxn_ConfigChanged, nil, ['TnxSession', 'TnxDatabase', 'TnxCursor']);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.AliasGetList(aList : TObjectList)
                                             : TnxResult;
var
  i : Integer;
begin
  nxSetTimeout(atoTimeout);
  try
    with TnxServerEngine(asServerEngine) do
      if Assigned(seAliasHandler) then begin
        Result := Self.NotifyExtenders(eaAliasGetList, True, [aList]);
        if Result = DBIERR_NONE then begin
          Result := seAliasHandler.GetList(aList);

          for i := Pred(aList.Count) downto 0 do
            if nxCheckValidIdent(TnxAliasDescriptor(aList[i]).adAlias,
              DBIERR_INVALIDALIASNAME, False) <> DBIERR_NONE then begin

              aList.Delete(i);
            end;

          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaAliasGetList, False, [aList]);
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasGetList']);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.AliasGetPath(const aAlias : string;
                                         out aPath  : string)
                                                    : TnxResult;
begin
  Result := nxCheckValidAliasName(aAlias, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  try
    with TnxServerEngine(asServerEngine) do
      if Assigned(seAliasHandler) then begin
        Result := Self.NotifyExtenders(eaAliasGetPath, True, [aAlias, @aPath]);
        if Result = DBIERR_NONE then begin
          Result := seAliasHandler.GetPath(aAlias, aPath);
          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaAliasGetPath, False, [aAlias, @aPath]);
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasGetPath']);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.AliasModify(const aAlias   : string;
                                      const aNewName : string;
                                      const aNewPath : string;
                                            aEnforce : Boolean)
                                                     : TnxResult;
begin
  Result := nxCheckValidAliasName(aAlias, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  try
    with TnxServerEngine(asServerEngine) do begin
      if Assigned(seAliasHandler) then begin
        Result := Self.NotifyExtenders(eaAliasModify, True, [aAlias, aNewName, aNewPath, aEnforce]);
        if Result = DBIERR_NONE then begin
          Result := seAliasHandler.Modify(aAlias, aNewName, aNewPath, aEnforce);
          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaAliasModify, False, [aAlias, aNewName, aNewPath, aEnforce]);
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasModify']);
      seAliasHandler.nxcNotifyBroadcast(nxn_ConfigChanged, nil, ['TnxSession', 'TnxDatabase', 'TnxCursor']);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.asGetClientDefaultLocale: TnxLocaleDescriptor;
begin
  Result := ssClientDefaultLocale;
  if not Assigned(Result) and not ssClientDefaultLocaleChecked then begin
    ssClientDefaultLocaleChecked := True;
    ssInitClientDefaultLocale;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.asGetClientVersion: Integer;
begin
  Result := ssClientVersion;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.CloseInactiveFolders: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  try
    Result := Self.NotifyExtenders(eaCloseInactiveFolders, True, []);
    if Result = DBIERR_NONE then begin
      Result := TnxServerEngine(asServerEngine).seCloseInactiveFolders;
      if Result = DBIERR_NONE then
        Self.NotifyExtenders(eaCloseInactiveFolders, False, []);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.CloseInactiveTables: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  try
    Result := Self.NotifyExtenders(eaCloseInactiveTables, True, []);
    if Result = DBIERR_NONE then begin
      Result := TnxServerEngine(asServerEngine).seCloseInactiveTables;
      if Result = DBIERR_NONE then
        Self.NotifyExtenders(eaCloseInactiveTables, False, []);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxServerSession.Create(aServerEngine  : TnxServerEngine;
                                    aTimeout       : TnxWord32;
                              const aUserName      : UnicodeString;
                              const aPassword      : UnicodeString;
                              const aConnectedFrom : string;
                                    aClientVersion : Integer);
begin
  ssClientVersion := aClientVersion;
  inherited Create(aServerEngine, aTimeout, aUserName, aPassword, aConnectedFrom);
end;
{------------------------------------------------------------------------------}
function TnxServerSession.DatabaseCacheOpen(out aDatabase     : TnxAbstractDatabase;
                                          const aAliasType    : string;
                                          const aAlias        : string;
                                                aTransContext : TnxAbstractTransContext;
                                                aOpenMode     : TnxOpenMode;
                                                aShareMode    : TnxShareMode;
                                                aTimeout      : TnxWord32)
                                                              : TnxResult;
begin
  Result := ssDoDatabaseOpen(aDatabase, aAliasType, aAlias, aTransContext,
    aOpenMode, aShareMode, aTimeout, True);
end;
{------------------------------------------------------------------------------}
function TnxServerSession.DatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                                     const aAliasType    : string;
                                     const aAlias        : string;
                                           aTransContext : TnxAbstractTransContext;
                                           aOpenMode     : TnxOpenMode;
                                           aShareMode    : TnxShareMode;
                                           aTimeout      : TnxWord32)
                                                         : TnxResult;
begin
  Result := ssDoDatabaseOpen(aDatabase, aAliasType, aAlias, aTransContext,
    aOpenMode, aShareMode, aTimeout, False);
end;
{------------------------------------------------------------------------------}
destructor TnxServerSession.Destroy;
begin
  inherited;
  nxFreeAndNil(ssClientDefaultLocale);
end;
{------------------------------------------------------------------------------}
function TnxServerSession.GetRegisteredClassList(const aClassListType : TnxClassListType;
                                                       aList          : TStrings)
                                                                      : TnxResult;
var
  List : PStringList;
  idx  : Integer;
begin
  aList.Clear;
  aList.BeginUpdate;
  try
    Result := Self.NotifyExtenders(eaGetRegisteredClassList, True, [Ord(aClassListType), aList]);
    if Result = DBIERR_NONE then begin
      case aClassListType of
        setEncryptionEngines :
          TnxBaseEncryptionEngine.GetRegisteredEngines(aList, False);
        setAutoIncEngines : begin
          List := TnxBaseAutoIncEngine.GetList;
          aList.Assign(List^);
        end;
        setIndexEngines : begin
          List := TnxBaseIndexEngine.GetList;
          for idx := Pred(List^.Count) downto 0 do
            if Pos('cache', LowerCase(List^[idx])) > 0 then
              List^.Delete(idx);
          aList.Assign(List^);
        end;
        setDefaultDescriptors : begin
          List := TnxBaseDefaultValueDescriptor.GetList;
          aList.Assign(List^);
        end;
        setValidationDescriptors : begin
          List := TnxBaseFieldValidationDescriptor.GetList;
          aList.Assign(List^);
        end;
        setRecordDescriptors : begin
          List := TnxBaseRecordEngine.GetList;
          aList.Assign(List^);
        end;
        setRIActionDescriptors : begin
          List := TnxBaseActionDescriptor.GetList;
          aList.Assign(List^);
        end;
        setBlobEngines : begin
          List := TnxBaseBlobDescriptor.GetList;
          aList.Assign(List^);
        end;
        //!!! more engines coming...
      else
        Result := DBIERR_OBJNOTFOUND
      end;

      if Result = DBIERR_NONE then
        Self.NotifyExtenders(eaGetRegisteredClassList, False, [Ord(aClassListType), aList]);
    end;
  finally
    aList.EndUpdate;
  end;                                                    
end;
{------------------------------------------------------------------------------}
procedure TnxServerSession.Kick;
begin
  Failed(True);
end;
{------------------------------------------------------------------------------}
function TnxServerSession.PasswordAdd(const aPassword: UnicodeString): TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssPasswordAdd(aPassword);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.PasswordRemove(const aPassword: UnicodeString): TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssPasswordRemove(aPassword);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.PasswordRemoveAll: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssPasswordRemoveAll;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssBuildPasswords(const aAlias    : UnicodeString;
                                           const aTable    : UnicodeString;
                                           const aPassword : UnicodeString)
                                                           : TnxUnicodeStrings;
begin
  Result := Copy(ssPasswords, 0, High(Integer));
  if aPassword <> '' then
    nxAddToArray(Result, aPassword);
  NotifyExtenders(eaBuildPasswords, False, [aAlias, aTable, @Result])
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssDatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                                       const aAlias        : string;
                                             aTransContext : TnxAbstractTransContext;
                                             aFolder       : TnxServerFolder;
                                             aOpenMode     : TnxOpenMode;
                                             aShareMode    : TnxShareMode;
                                             aIgnoreShare  : Boolean;
                                             aTimeout      : TnxWord32)
                                                           : TnxResult;
var
  Database : TnxServerDatabase;
begin
  aDatabase := nil;
  try
    if aOpenMode = omWriteOnly then
      aOpenMode := omReadWrite;

    if aFolder.sfReadOnly then
      aOpenMode := omReadOnly;

    aFolder.sfDatabasesPadlock.Lock;
    try
      Result := DBIERR_NONE;

      if not aIgnoreShare then begin
        Database := aFolder.sfDatabasesHead;

        if Assigned(Database) then
          if Database.sdShareMode = smExclusive then
            Result := DBIERR_NEEDEXCLACCESS
          else
            case aShareMode of
              smExclusive:                                 {..exclusive, no sharing}
                Result := DBIERR_NEEDEXCLACCESS;
              smShared: begin                     {..allows others to Read or Write}
                if aOpenMode <> omReadOnly then
                  while Assigned(Database) do begin
                    if Database.sdShareMode = smShareRead then begin
                      Result := DBIERR_NEEDEXCLACCESS; //different error code?
                      break;
                    end;
                    Database := Database.sdFolderNext;
                  end;
              end;
              smShareRead : begin                     {..allows others to Read only}
                while Assigned(Database) do begin
                  if aOpenMode <> omReadOnly then
                    if Database.sdShareMode = smShareRead then begin
                      Result := DBIERR_NEEDEXCLACCESS; //different error code?
                      break;
                    end;
                  if Database.sdOpenMode = omReadOnly then begin
                    Result := DBIERR_NEEDEXCLACCESS; //different error code?
                    break;
                  end;
                  Database := Database.sdFolderNext;
                end;
              end;
            end;
      end;

      if Result = DBIERR_NONE then
        aDatabase := TnxServerDatabase.Create
          (Self, aTransContext as TnxServerTransContext, aAlias, aFolder, aTimeout, aOpenMode, aShareMode);
    finally
      if Assigned(aFolder) and Assigned(aFolder.sfDatabasesPadlock) then begin
        aFolder.sfUpdateIsInactive;
        aFolder.sfDatabasesPadlock.Unlock;
      end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Result <> DBIERR_NONE then
    nxFreeAndNil(aDatabase);
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssDoDatabaseOpen(out aDatabase     : TnxAbstractDatabase;
                                         const aAliasType    : string;
                                         const aAlias        : string;
                                               aTransContext : TnxAbstractTransContext;
                                               aOpenMode     : TnxOpenMode;
                                               aShareMode    : TnxShareMode;
                                               aTimeout      : TnxWord32;
                                               aIsCache      : Boolean)
                                                             : TnxResult;
var
  Folder   : TnxServerFolder;
  Path     : string;
  Alias    : string;
  Index    : Integer;
begin
  Alias := '';
  nxSetTimeout(atoTimeout);
  aDatabase := nil;
  Result := DBIERR_NONE;
  try
    with TnxServerEngine(asServerEngine) do begin
      if SameText(aAliasType, nxatAliasName) then begin

        Result := nxCheckValidAliasName(aAlias, True);
        if Result <> DBIERR_NONE then
          Exit;

        if Assigned(seAliasHandler) then begin
          Result := seAliasHandler.GetPath(aAlias, Path);
          if Result = DBIERR_NONE then
            Alias := aAlias;
        end else
          Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSRequiresAnAliasHandler, ['AliasType = ''Name'''])
      end else if SameText(aAliasType, nxatAliasPath) then begin
        Path := aAlias;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsAliasTypeSNotSupported, [aAliasType]);

      if Result = DBIERR_NONE then
        Path := Trim(Path);
        if (Length(Path) > 0) and (Path[1]<>'#') then begin
          Path := ExpandFileName(Path);
          if DirectoryExists(ExpandUNCFileName(Path)) then
            Path := ExpandUNCFileName(Path);
          if (Length(Path) > 1) and (Path[Length(Path)] <> '\') then
            Path := Path + '\';
          if not DirectoryExists(Path) then
            Result := DBIERR_INVALIDDIR;
        end;

      {$IFDEF NX_LITE}
      {$I Lite\nxLite6.inc}
      {$ENDIF}

      if Result = DBIERR_NONE then begin
        seFoldersPadlock.Lock;
        try
          if not seFolders.Find(Path, Index) then
            Folder := TnxServerFolder.Create(TnxServerEngine(asServerEngine), Path, aIsCache)
          else begin
            Folder := TnxServerFolder(seFolders.Objects[Index]);
            if Folder.IsCache <> aIsCache then
              Result := EnxBaseException.nxSetMessage(DBIERR_DIRNOACCESS, @rsFolderAlreadyOpen);
          end;

          if Result = DBIERR_NONE then
            Result := ssDatabaseOpen(aDatabase, Alias, aTransContext,
              Folder, aOpenMode, aShareMode, False, aTimeout);

        finally
          seFoldersPadlock.Unlock;
        end;
      end;
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Result <> DBIERR_NONE then
    nxFreeAndNil(aDatabase);
end;
{------------------------------------------------------------------------------}
procedure TnxServerSession.ssInitClientDefaultLocale;
var
  LocaleStr: string;
  Locale: Integer;
begin
  nxFreeAndNil(ssClientDefaultLocale);
  if esoOptionGetEffective('SQL_DEFAULT_LOCALE', LocaleStr) = DBIERR_NONE then begin
    if (LocaleStr <> '') then begin
      Locale := StrToIntDef(LocaleStr, -1);
      if Locale > 0 then try
        ssClientDefaultLocale := TnxLocaleDescriptor.Create(nil);
        ssClientDefaultLocale.IsDefaultStringLiteralLocale := True;
        ssClientDefaultLocale.Locale := Locale;
      except
        nxFreeAndNil(ssClientDefaultLocale);
        raise;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssPasswordAdd(const aPassword : UnicodeString)
                                                        : TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_NONE;
  try
    if aPassword = '' then
      Result := DBIERR_INVALIDPARAM
    else begin
      for i := Low(ssPasswords) to High(ssPasswords) do
        if ssPasswords[i] = aPassword then begin
          Result := DBIERR_NAMENOTUNIQUE;
          Exit;
        end;
      nxAddToArray(ssPasswords, aPassword);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssPasswordRemove(const aPassword : UnicodeString)
                                                           : TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_NONE;
  try
    if aPassword = '' then
      Result := DBIERR_INVALIDPARAM
    else begin
      for i := Low(ssPasswords) to High(ssPasswords) do
        if ssPasswords[i] = aPassword then begin
          nxRemoveFromArray(ssPasswords, i);
          Exit;
        end;
      Result := DBIERR_OBJNOTFOUND;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.ssPasswordRemoveAll: TnxResult;
begin
  Result := DBIERR_NONE;
  try
    ssPasswords := nil;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerSession.TransContextCreate(out aTransContext : TnxAbstractTransContext;
                                                 aTimeout      : TnxWord32)
                                                               : TnxResult;
begin
  Result := DBIERR_NONE;
  try
    aTransContext := TnxServerTransContext.Create(Self, aTimeout);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{==============================================================================}



{==============================================================================}
function TnxServerTransactionMgr.btmGetJournalEngineFor(aTransaction : TnxBaseTransaction)
                                                                     : TnxBaseJournalEngine;
begin
  if not stmFolder.sfInMemOnly and not stmFolder.sfReadOnly and
    Assigned(JournalEngineClass) then
    Result := JournalEngineClass.Create(stmFolder.sfPath + '\' +
      IntToStr(Int64(TnxNativeUInt(aTransaction))) + '.' + nxc_ExtForTrans)
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}
constructor TnxServerTransactionMgr.Create(aFolder   : TnxServerFolder);
begin
  stmFolder := aFolder;
  inherited Create(stmFolder.sfServerEngine.seBufferManager);
  stmReadConfig;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTransactionMgr.Destroy;
begin
  inherited;
  stmWriteConfig(true);
end;
{------------------------------------------------------------------------------}
function TnxServerTransactionMgr.stmGetLSNForTable(const FullTableName : string)
                                                                       : TnxLSN;
var
  FileHandle : Integer;
begin
  Result := 0;
  if not stmFolder.sfInMemOnly then begin
    FileHandle := FileOpen(FullTableName, fmOpenRead);
    if FileHandle >= 0 then try
      if (FileSeek(FileHandle, 8, 0) <> 8) or
        (FileRead(FileHandle, Result, SizeOf(Result)) <> SizeOf(Result)) then
        Result := 0;
    finally
      FileClose(FileHandle);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransactionMgr.stmGetLSNFromTables: TnxLSN;
var
  SearchRec : TSearchRec;
begin
  Result := 0;
  if not stmFolder.sfInMemOnly then begin
    if FindFirst(ExcludeTrailingPathDelimiter(stmFolder.sfPath) + '\*.' +
      stmFolder.sfServerEngine.TableExtension, faAnyFile and not faDirectory, SearchRec) = 0 then try
      repeat
        if SameText(ExtractFileExt(SearchRec.Name), '.' + stmFolder.sfServerEngine.TableExtension) then try
          Result := nxMaxI64(Result,
            stmGetLSNForTable(nxMakeFullFileName(stmFolder.sfPath, SearchRec.Name)));
        except
        end;
      until FindNext(SearchRec) <> 0
    finally
      FindClose(SearchRec);
    end;
  end;
  Inc(Result);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionMgr.stmReadConfig;
var
  Done    : Boolean;
  NextLSN : TnxLSN;
begin
  Done := False;
  if not stmFolder.sfInMemOnly then begin
    stmConfigFile := TnxBaseFile.Alloc(False,
      nxMakeFullFileName(stmFolder.sfPath, nxc_ConfigFile),  nil);

    if not stmFolder.sfReadOnly then begin
      if stmValidConfigFile then try
        stmConfigFile.OpenFile(omReadWrite, smExclusive, True, False);
        try
          stmConfigFile.ReadFileExactAt(0, SizeOf(NextLSN), NextLSN);
        except
          NextLSN := stmGetLSNFromTables;
        end;
        Done := True;
      except
      end;

      if not Done then try
        stmConfigFile.OpenFile(omReadWrite, smExclusive, True, True);
        NextLSN := stmGetLSNFromTables;
        Done := True;
      except
      end;

      if not Done then
        stmFolder.sfReadOnly := True;
    end;

    if stmFolder.sfReadOnly then begin
      Assert(not Done);

      if FileExists(stmConfigFile.fiName) then begin
        stmConfigFile.OpenFile(omReadOnly, smShareRead, True, False);

        if stmValidConfigFile then try
          stmConfigFile.ReadFileExactAt(0, SizeOf(NextLSN), NextLSN);
          Done := True;
        except
        end;

        if not Done then begin
          NextLSN := stmGetLSNFromTables;
          Done := True;
        end;

      end else begin
        NextLSN := stmGetLSNFromTables;
        Done := True;
      end;
    end;

    Assert(Done, stmConfigFile.fiName);

    stmWriteConfig(False);
  end else
    NextLSN := 1;

  btmBufferManager.NextLSN := NextLSN;
end;
{------------------------------------------------------------------------------}
function TnxServerTransactionMgr.stmValidConfigFile: Boolean;
var
  SearchRec    : TSearchRec;
  FullFileName : string;
  CfgTime      : Integer;
begin
  if not stmFolder.sfInMemOnly then begin
    FullFileName := nxMakeFullFileName(stmFolder.sfPath, nxc_ConfigFile);
    Result := FindFirst(FullFileName, faAnyFile and not faDirectory, SearchRec) = 0;
    if Result then begin
      FindClose(SearchRec);
      Result := SearchRec.Size = SizeOf(TnxLSN) ;
      if Result then begin
        CfgTime := SearchRec.Time + 1000;
        if FindFirst(ExcludeTrailingPathDelimiter(stmFolder.sfPath) + '\*.' + stmFolder.sfServerEngine.TableExtension,
          faAnyFile and not faDirectory, SearchRec) = 0 then try
          repeat
            if SameText(ExtractFileExt(SearchRec.Name), '.' + stmFolder.sfServerEngine.TableExtension) then
              if SearchRec.Time > CfgTime then begin
                Result := False;
                Break;
              end;
          until FindNext(SearchRec) <> 0;
        finally
          FindClose(SearchRec);
        end;
      end;
    end;
  end else
    Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionMgr.stmWriteConfig(aCloseFile: Boolean);
var
  NextLSN : TnxLSN;
begin
  if Assigned(stmConfigFile) and stmConfigFile.FileIsOpen then begin

    if not stmFolder.sfReadOnly and not stmFolder.sfInMemOnly then try
      NextLSN := btmBufferManager.NextLSN;
      stmConfigFile.WriteFileExactAt(0, SizeOf(NextLSN), NextLSN);
    except end;

    if aCloseFile then
      stmConfigFile.CloseFile;

  end;

  if aCloseFile then
    nxFreeAndNil(stmConfigFile);
end;
{==============================================================================}



{===TnxServerFolder============================================================}
procedure TnxServerFolder.AfterConstruction;
begin
  inherited;
  LockedInc(TnxServerEngine(asoGetServerEngine).seFolderCount);
  sfLockedIncDone := True;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.asoGetServerEngine: TnxBaseServerEngine;
begin
  Result := sfServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if sfLockedIncDone then
    LockedDec(TnxServerEngine(asoGetServerEngine).seFolderCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxServerFolder.Create(aServerEngine : TnxServerEngine;
                             const aPath         : string;
                                   aIsCache      : Boolean);
begin
  sfIsCache := aIsCache;

  sfDatabasesPadlock := TnxPadlock.Create(True);

  sfServerEngine := aServerEngine;
  sfPath := aPath;
  sfInMemOnly := seoInMemOnly in aServerEngine.Options;
  if (Length(sfPath) < 1) or (sfPath[1] = '#') then
    sfInMemOnly := True;

  sfReadOnly := not sfInMemOnly and (seoReadOnly in aServerEngine.Options);

  stTransManager := TnxServerTransactionMgr.Create(Self);
  sfForceFailSafe := seoForceFailSafe in aServerEngine.seOptions;

  sfTablesPadlock := TnxPadlock.Create(True);
  sfTables := TStringList.Create;
  sfTables.Sorted := True;
  sfTables.Duplicates := dupError;

  sfAddToServerEngine;
  inherited Create(nil);
end;
{------------------------------------------------------------------------------}
destructor TnxServerFolder.Destroy;
begin
  sfDatabasesPadlock.Lock;
  try
    sfServerEngineRemoveFromInactiveFolders;
    sfRemoveFromServerEngine;

    if Assigned(sfTablesPadlock) then begin
      sfTablesPadlock.Lock;
      try
        while sfTables.Count > 0 do try
          sfTables.Objects[Pred(sfTables.Count)].Free
        except
          on E : Exception do
            Self.asoConvertException(E); {will create a log entry...}
        end;
      finally
        sfTablesPadlock.Unlock;
      end;
    end;

    inherited;

    nxFreeAndNil(stTransManager);

  finally
    sfDatabasesPadlock.Unlock;
  end;
  nxFreeAndNil(sfDatabasesPadlock);

  nxFreeAndNil(sfTablesPadlock);
  nxFreeAndNil(sfTables);
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i           : Integer;
  db          : TnxServerDatabase;
  dbContainer : InxExceptionDataContainer;
  tb          : TnxServerRootTable;
  tbContainer : InxExceptionDataContainer;
begin
  inherited;
  aContainer.AddValue('Path', sfPath);
  aContainer.AddValue('InMemOnly', sfInMemOnly);
  aContainer.AddValue('ReadOnly', sfReadOnly);
  sfDatabasesPadlock.Lock;
  try
    aContainer.AddValue('OpenDatabases', DoubleLinkedListCountStrings[Assigned(sfDatabasesHead), sfDatabasesHead = sfDatabasesTail]);
    if aIncludeChildren then begin
      dbContainer := aContainer.AddContainer('Databases');
      db := sfDatabasesHead;
      if Assigned(db) then begin
        i := 0;
        while Assigned(db) do begin
          dbContainer.AddValue('[' + IntToStr(i) + ']', db, True);
          Inc(i);
          db := db.sdFolderNext;
        end;
      end;
    end;
  finally
    sfDatabasesPadlock.Unlock;
  end;

  sfTablesPadlock.Lock;
  try
    aContainer.AddValue('OpenTables', sfTables.Count);
    if aIncludeChildren then begin
      tbContainer := aContainer.AddContainer('Tables');
      for i := 0 to Pred(sfTables.Count) do begin
        tb := sfTables.Objects[i] as TnxServerRootTable;
        tbContainer.AddValue('[' + IntToStr(i) + ']', tb, True);
      end;
    end;
  finally
    sfTablesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.LockTables;
begin
  sfTablesPadlock.Lock;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.sfAddToServerEngine;
begin
  with sfServerEngine do begin
    seFoldersPadlock.Lock;
    try
      seFolders.AddObject(sfPath, Self);
    finally
      seFoldersPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfCloseInactiveTables: TnxResult;
var
  i         : Integer;
  ClosedAny : Boolean;
  Locked    : Boolean;
begin
  Result := DBIERR_NONE;
  try
    Locked := sfTablesPadlock.TryLock;
    if Locked then try
      repeat
        ClosedAny := False;
        i := Pred(sfTables.Count);
        while i >= 0 do begin
          with TnxServerRootTable(sfTables.Objects[i]) do begin
            LockedInc(sbtLockIsInactive);
            if srtIsInactive(False, True, 1) then try
              LockedDec(sbtLockIsInactive);
              if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                Free;
                ClosedAny := True;
              end;
            except
              on E : Exception do
                Self.asoConvertException(E); {will create a log entry...}
            end else
              LockedDec(sbtLockIsInactive);
          end;
          i := nxMinI32(Pred(i), Pred(sfTables.Count));
        end;
      until not ClosedAny;
    finally
      sfTablesPadlock.Unlock;
    end;
    if (Result = DBIERR_NONE) and not Locked  then
      Result := DBIERR_LOCKED;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfIsInactive(aIgnoreKeepInMemory : Boolean;
                                      aRequestClose       : Boolean)
                                                          : Boolean;
var
  i: Integer;
begin
  Result := not Assigned(sfDatabasesHead);
  if Result then begin
    sfTablesPadlock.Lock;
    try
      i := Pred(sfTables.Count);
      while i >= 0 do begin
        Result := TnxServerRootTable(sfTables.Objects[i]).
          srtIsInactive(aIgnoreKeepInMemory, aRequestClose);
        if not Result then
          break;

        i := nxMinI32(Pred(i), Pred(sfTables.Count));
      end;
    finally
      sfTablesPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.sfRemoveFromServerEngine;
var
  Index : Integer;
begin
  with sfServerEngine do begin
    seFoldersPadlock.Lock;
    try
      with seFolders do
        if Find(sfPath, Index) then
          Delete(Index);
    finally
      seFoldersPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.sfServerEngineAddToInactiveFolders;
begin
  with sfServerEngine do begin
    seInactiveFoldersPadlock.Lock;
    try
      if asoDestroying then
        Exit;

      if sfInServerEngineInactiveFolders then
        Exit;

      sfInactiveSince := Now;

      sfServerEngineInactiveFoldersPrev := seInactiveFoldersTail;
      seInactiveFoldersTail := Self;
      if Assigned(sfServerEngineInactiveFoldersPrev) then
        sfServerEngineInactiveFoldersPrev.sfServerEngineInactiveFoldersNext := Self;
      if not Assigned(seInactiveFoldersHead) then
        seInactiveFoldersHead := Self;

      Inc(seInactiveFoldersCount);

      sfInServerEngineInactiveFolders := True;
    finally
      seInactiveFoldersPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.sfServerEngineRemoveFromInactiveFolders;
begin
  with sfServerEngine do begin
    seInactiveFoldersPadlock.Lock;
    try
      if not sfInServerEngineInactiveFolders then
        Exit;

      if Assigned(sfServerEngineInactiveFoldersNext) then begin
        Assert(sfServerEngineInactiveFoldersNext.sfServerEngineInactiveFoldersPrev = Self);
        sfServerEngineInactiveFoldersNext.sfServerEngineInactiveFoldersPrev := sfServerEngineInactiveFoldersPrev
      end else begin
        if seInactiveFoldersTail = Self then
          seInactiveFoldersTail := sfServerEngineInactiveFoldersPrev
        else
          Assert(seInactiveFoldersTail = nil);
      end;

      if Assigned(sfServerEngineInactiveFoldersPrev) then begin
        Assert(sfServerEngineInactiveFoldersPrev.sfServerEngineInactiveFoldersNext = Self);
        sfServerEngineInactiveFoldersPrev.sfServerEngineInactiveFoldersNext := sfServerEngineInactiveFoldersNext
      end else begin
        if seInactiveFoldersHead = Self then
          seInactiveFoldersHead := sfServerEngineInactiveFoldersNext
        else
          Assert(seInactiveFoldersHead = nil)
      end;

      sfServerEngineInactiveFoldersNext := nil;
      sfServerEngineInactiveFoldersPrev := nil;

      Dec(seInactiveFoldersCount);

      sfInServerEngineInactiveFolders := False;
    finally
      seInactiveFoldersPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableBuild(aOverWrite  : Boolean;
                                const aTableName  : string;
                                const aPassword   : UnicodeString;
                                      aForServer  : Boolean;
                                      aDictionary : TnxDataDictionary;
                                      aTableScope : TnxTableScope)
                                                  : TnxResult;
var
  Index     : Integer;
  Table     : TnxServerRootTable;
begin
  Result := NotifyExtenders(eaTableBuild, True, [aOverWrite, aTableName, aDictionary, @aTableScope]);
  if Result = DBIERR_NONE then begin
    if sfReadOnly then
      Result := DBIERR_READONLYDB
    else try
      sfTablesPadlock.Lock;
      try
        if sfTables.Find(aTableName, Index) then begin
          Table := TnxServerRootTable(sfTables.Objects[Index]);

          Result := DBIERR_TABLEOPEN;
          with Table do begin
            LockedInc(sbtLockIsInactive);
            if srtIsInactive(True, True, 1) then try
              LockedDec(sbtLockIsInactive);
              if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                Free;
                Result := DBIERR_NONE;
              end;
            except
              on E : Exception do
                Self.asoConvertException(E); {will create a log entry...}
            end else
              LockedDec(sbtLockIsInactive);
          end;
          if Result <> DBIERR_NONE then
            Exit;
        end;

        if (aTableName = '') or                                    
          ((aTableScope = tsPersistent) and not nxVerifyFileName(aTableName)) then begin
          Result := DBIERR_INVALIDTABLENAME;
          Exit;
        end;

        if sfTableExists(aTableName) = DBIERR_NONE then
          if aOverWrite then begin
            if sfTableDelete(aTableName, nxNewArray(aPassword), aForServer) <> DBIERR_NONE then begin
              Result := DBIERR_TABLEREADONLY;
              Exit;
            end;
          end else begin
            Result := DBIERR_TABLEEXISTS;
            Exit;
          end;

        Result := sfTableBuildPrim
          (aTableName, aPassword, aForServer, aDictionary, aTableScope, Table);
        if Result = DBIERR_NONE then begin
          if Table.srtIsInactive(False, False) then
            nxFreeAndNil(Table);
          LockedInc(sfStructureGeneration);
        end;
      finally
        sfTablesPadlock.Unlock;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;

    if Result = DBIERR_NONE then
      NotifyExtenders(eaTableBuild, False,
        [aOverWrite, aTableName, aDictionary, @aTableScope]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableBuildPrim(const aTableName  : string;
                                          const aPassword   : UnicodeString;
                                                aForServer  : Boolean;
                                                aDictionary : TnxDataDictionary;
                                                aTableScope : TnxTableScope;
                                            out aTable      : TnxServerRootTable)
                                                            : TnxResult;
var
  Trans     : TnxServerTransaction;
  Attribs   : TnxFileAttributes;
begin
  if sfReadOnly and (aTableScope in [tsPersistent, tsTempGlobal]) then begin
    aTable := nil;
    Result := DBIERR_READONLYDB;
  end else if sfInMemOnly and (aTableScope = tsPersistent) then begin
    aTable := nil;
    Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsTsPersistentNotSupported);
  end else begin
    aTable := TnxServerRootTable.Create(Self, aTableName, omReadWrite, smExclusive, aTableScope);
    try
      Trans := TnxServerTransaction.Create(sfServerEngine.seBufferManager, nil, False, False, aTableScope <> tsPersistent);

      Attribs := [];
      if aTableScope <> tsPersistent then
        Include(Attribs, nxfaTemporary)
      else
        Include(Attribs, nxfaReplicationLog);
      if aTableScope in [tsTempGlobal, tsTempDatabase] then
        Include(Attribs, nxfaMemTable);

      try
        Result := aTable.srtBuildFiles(Trans, nxNewArray(aPassword), aForServer, aDictionary, Attribs, nil, aTableName);
        if Result = DBIERR_NONE then
          Trans.Commit;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        Trans.Rollback;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
    if Result <> DBIERR_NONE then
      nxFreeAndNil(aTable);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableDelete(const aTableName : string;
                                             aPasswords : TnxUnicodeStrings;
                                             aForServer : Boolean)
                                                        : TnxResult;
var
  Dict       : TnxDataDictionary;
  Index      : Integer;
  Table      : TnxServerRootTable;
  FullName   : string;
  i          : Integer;
  Done       : Boolean;
  FileIsLink : Boolean;
begin
  FileIsLink := False;
  Result := NotifyExtenders(eaTableDelete, True, [aTableName]);
  if Result = DBIERR_NONE then begin
    if sfReadOnly then
      Result := DBIERR_READONLYDB
    else begin
      try
        if aTableName = '' then
          Result := DBIERR_INVALIDTABLENAME
        else begin
          Dict := TnxDataDictionary.Create;
          sfTablesPadlock.Lock;
          try
            if sfTables.Find(aTableName, Index) then begin
              Table := TnxServerRootTable(sfTables.Objects[Index]);

              Result := DBIERR_TABLEOPEN;
              with Table do begin
                FileIsLink := srtFileIsLink;
                LockedInc(sbtLockIsInactive);
                if srtIsInactive(True, True, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    Done := Table.srtTableScope <> tsPersistent;
                    if not Done then
                      Dict.Assign(Table.srtDictionary);
                    nxFreeAndNil(Table);
                    Result := DBIERR_NONE;
                    if Done then
                      Exit;
                  end;
                except
                  on E : Exception do
                    Self.asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);
              end;
              if Result <> DBIERR_NONE then
                Exit;
            end else
              Result := sfTableGetDictionary(aTableName, aPasswords, aForServer, Dict, @FileIsLink);

            if FileIsLink then begin
              Result := DBIERR_TABLEREADONLY;
              Exit;
            end;

            if Result = DBIERR_NONE then begin
              for i := 0 to Pred(Dict.FilesDescriptor.FileCount) do begin
                if i = 0 then
                  FullName := nxMakeFullFileName(sfPath,
                    nxMakeFileNameExt(aTableName, sfServerEngine.seTableExtension))
                else
                  FullName := nxMakeFullFileName(sfPath,
                    nxMakeFileNameExt(aTableName, Dict.FilesDescriptor.FileDescriptor[i].Extension));
                nxDeleteFile(FullName);
              end;
            end else
              if (Result <> DBIERR_INVALIDTABLENAME) and
                 (Result <> DBIERR_NOSUCHTABLE) then begin
                nxDeleteFile(nxMakeFullFileName(sfPath,
                  nxMakeFileNameExt(aTableName, sfServerEngine.seTableExtension)));
                Result := DBIERR_NONE;
              end;
            if Result = DBIERR_NONE then
              LockedInc(sfStructureGeneration);
          finally
            sfTablesPadlock.Unlock;
            nxFreeAndNil(Dict);
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    end;

    if Result = DBIERR_NONE then
      NotifyExtenders(eaTableDelete, False, [aTableName]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableEmpty(const aTableName : string;
                                            aPasswords : TnxUnicodeStrings;
                                            aForServer : Boolean)
                                                       : TnxResult;
var
  Dict       : TnxDataDictionary;
  Scope      : TnxTableScope;
  Index      : Integer;
  Table      : TnxServerRootTable;
  Password   : UnicodeString;
  FileIsLink : Boolean;
begin
  FileIsLink := False;

  Password := '';

  if sfReadOnly then
    Result := DBIERR_READONLYDB
  else begin
    try
      if aTableName = '' then
        Result := DBIERR_INVALIDTABLENAME
      else begin
        Scope := tsPersistent;

        Dict := TnxDataDictionary.Create;
        sfTablesPadlock.Lock;
        try
          if sfTables.Find(aTableName, Index) then begin
            Table := TnxServerRootTable(sfTables.Objects[Index]);

            Result := NotifyExtenders(eaTableEmpty, True, [aTableName, @Table.srtTableScope]);
            if Result = DBIERR_NONE then begin
              Result := DBIERR_TABLEOPEN;
              with Table do begin
                LockedInc(sbtLockIsInactive);
                if srtIsInactive(True, True, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    Dict.Assign(Table.srtDictionary);
                    Password := Table.srtExtractPassword;
                    Scope := Table.srtTableScope;
                    FileIsLink := Table.srtFileIsLink;
                    nxFreeAndNil(Table);
                    Result := DBIERR_NONE;
                  end;
                except
                  on E : Exception do
                    Self.asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);
              end;
            end;
          end else begin
            Result := NotifyExtenders(eaTableEmpty, True, [aTableName, @Scope]);
            if Result = DBIERR_NONE then
              Result := sfTableGetDictionary(aTableName, aPasswords, aForServer, Dict, @FileIsLink, @Password);
          end;

          if Result = DBIERR_NONE then
            if FileIsLink then
              Result := DBIERR_TABLEREADONLY;

          if Result = DBIERR_NONE then begin
            if DataPoliciesDenyEmpty(Dict) then
              Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedDataPolicies)
            else
              Result := sfTableBuild(True, aTableName, Password, aForServer, Dict, Scope);
          end;
        finally
          sfTablesPadlock.Unlock;
          nxFreeAndNil(Dict);
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;

    if Result = DBIERR_NONE then
      NotifyExtenders(eaTableEmpty, False, [aTableName]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableExists(const aTableName : string)
                                                        : TnxResult;
var
  Index     : Integer;
  TableName : string;
begin
  Result := DBIERR_NONE;
  try
    TableName := aTableName;
    if SameText(ExtractFileExt(TableName), '.' + sfServerEngine.seTableExtension) then
      TableName := ChangeFileExt(TableName, '');

    sfTablesPadlock.Lock;
    try
      if sfTables.Find(TableName, Index) then begin
        if TnxServerRootTable(sfTables.Objects[Index]).srtTableScope > tsTempGlobal then
          Result := DBIERR_OBJNOTFOUND;
        Exit;
      end;
    finally
      sfTablesPadlock.Unlock;
    end;

    if sfInMemOnly or nxTableNameIsTempGlobal(aTableName) or nxTableNameIsTempDatabase(aTableName) or
      not FileExists(nxMakeFullFileName(sfPath,
            nxMakeFileNameExt(TableName, sfServerEngine.seTableExtension))) then
      Result := DBIERR_OBJNOTFOUND;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableGetDictionary(const aTableName : string;
                                                    aPasswords : TnxUnicodeStrings;
                                                    aForServer : Boolean;
                                                    aDict      : TnxDataDictionary;
                                                    aFileIsLink: PBoolean = nil;
                                                    aPassword  : PUnicodeString = nil)
                                                               : TnxResult;
var
  Index         : Integer;
  Table         : TnxServerRootTable;
  IsReadOnly    : Boolean;
begin
  if Assigned(aFileIsLink) then
    aFileIsLink^ := False;
  if Assigned(aPassword) then
    aPassword^ := '';

  try
    sfTablesPadlock.Lock;
    try
      if sfTables.Find(aTableName, Index) then begin
        Table := TnxServerRootTable(sfTables.Objects[Index]);
        Result := Table.srtAuthenticatePassword(aPasswords);
        if Result = DBIERR_NONE then begin
          aDict.Assign(Table.srtDictionary);
          if Assigned(aPassword) then
            aPassword^ := Table.srtExtractPassword;
          if Assigned(aFileIsLink) then
            aFileIsLink^ := Table.srtFileIsLink;
        end;
      end else if not sfInMemOnly then begin
        if not nxVerifyFileName(aTableName) then
          Result := DBIERR_INVALIDTABLENAME
        else if not FileExists(nxMakeFullFileName(sfPath,
          nxMakeFileNameExt(aTableName, sfServerEngine.seTableExtension))) then
          Result := EnxBaseException.nxSetMessage(DBIERR_NOSUCHTABLE, nxcOrgMessageMarker +
            ' Root table "' + aTableName + '" not found')
        else begin
          Table := TnxServerRootTable.Create(Self, aTableName, omReadOnly, smShareRead, tsPersistent);
          try
            Result := Table.srtOpenFiles(nil, aPasswords, aForServer, [], IsReadOnly);
            if Result = DBIERR_NONE then begin
              aDict.Assign(Table.srtDictionary);
              if Assigned(aPassword) then
                aPassword^ := Table.srtExtractPassword;
              if Assigned(aFileIsLink) then
                aFileIsLink^ := Table.srtFileIsLink;
            end;
          finally
            Table.Free;
          end;
        end;
      end else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOSUCHTABLE, nxcOrgMessageMarker +
          ' Root table "' + aTableName + '" not found');
    finally
      sfTablesPadlock.Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;

  if Result <> DBIERR_NONE then
    aDict.Clear;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableGetList(aList : TStrings)
                                              : TnxResult;
var
  SearchRec : TSearchRec;
  List      : TStringList;
  i         : Integer;
begin
  Result := DBIERR_NONE;
  try
    aList.BeginUpdate;
    try
      aList.Clear;
      List := TStringList.Create;
      try
        sfTablesPadlock.Lock;
        try
          List.AddStrings(sfTables);
          List.Sorted := True;
          List.Duplicates := dupIgnore;

          if not sfInMemOnly then
            if FindFirst(ExcludeTrailingPathDelimiter(sfPath) + '\*.' + sfServerEngine.seTableExtension, faAnyFile and not faDirectory, SearchRec) = 0 then try
              repeat
                if SameText(ExtractFileExt(SearchRec.Name), '.' + sfServerEngine.seTableExtension) then
                  List.Add(ChangeFileExt(SearchRec.Name, ''));
              until FindNext(SearchRec) <> 0
            finally
              FindClose(SearchRec);
            end;

          for i:= Pred(List.Count) downto 0 do
            if Assigned(List.Objects[i]) and
              (TnxServerRootTable(List.Objects[i]).srtTableScope > tsTempGlobal) then
              List.Delete(i);
        finally
          sfTablesPadlock.Unlock;
        end;
        aList.AddStrings(List);
      finally
        nxFreeAndNil(List);
      end;
    finally
      aList.EndUpdate;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableMakeUniqueName(const aBaseName  : string;
                                                 out aTableName : string)
                                                                : TnxResult;
var
  i: Integer;
begin
  i := 1;
  Result := DBIERR_NONE;
  try
    sfTablesPadlock.Lock;
    try
      aTableName := aBaseName;
      while sfTableExists(aTableName) = DBIERR_NONE do begin
        aTableName := aBaseName + IntToStr(i);
        Inc(i);
      end;
    finally
      sfTablesPadlock.Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerFolder.sfTableRename(const aOldName   : string;
                                       const aNewName   : string;
                                             aPasswords : TnxUnicodeStrings;
                                             aForServer : Boolean)
                                                        : TnxResult;
var
  OldTable    : TnxServerRootTable;
  NewTable    : TnxServerRootTable;

  Dict        : TnxDataDictionary;
  Index       : Integer;
  i, j        : Integer;
  OldName     : string;
  NewName     : string;
  OldFullName : string;
  NewFullName : string;
  FileIsLink  : Boolean;
begin
  FileIsLink := False;
  if sfReadOnly then
    Result := DBIERR_READONLYDB
  else begin
    try
      Dict := TnxDataDictionary.Create;
      sfTablesPadlock.Lock;
      try
        if not sfTables.Find(aOldName, Index) then
          OldTable := nil
        else begin
          OldTable := TnxServerRootTable(sfTables.Objects[Index]);
          FileIsLink := OldTable.srtFileIsLink;
        end;

        if sfTables.Find(aNewName, Index) then begin
          NewTable := TnxServerRootTable(sfTables.Objects[Index]);

          Result := DBIERR_TABLEEXISTS;
          with NewTable do begin
            LockedInc(sbtLockIsInactive);
            if srtIsInactive(False, True, 1) then try
              LockedDec(sbtLockIsInactive);
              if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                nxFreeAndNil(NewTable);
                Result := DBIERR_NONE;
              end;
            except
              on E : Exception do
                Self.asoConvertException(E); {will create a log entry...}
            end else
              LockedDec(sbtLockIsInactive);
          end;
          if Result <> DBIERR_NONE then
            Exit;
        end;

        if sfTableExists(aNewName) = DBIERR_NONE then begin
          Result := DBIERR_TABLEEXISTS;
          Exit;
        end;

        if Assigned(OldTable) then begin
          Result := NotifyExtenders(eaTableRename, True, [aOldName, aNewName, @OldTable.srtTableScope]);
          if Result = DBIERR_NONE then begin
            if OldTable.srtTableScope <> tsPersistent then begin
              OldTable.srtRemoveFromFolder;
              OldTable.srtName := aNewName;
              OldTable.sbtNameInScope := aNewName;
              OldTable.srtDictionary._BaseName := aNewName;
              OldTable.srtAddToFolder;
              Exit;
            end else begin
              Result := DBIERR_TABLEOPEN;
              with OldTable do begin
                LockedInc(sbtLockIsInactive);
                if srtIsInactive(False, True, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    Dict.Assign(OldTable.srtDictionary);
                    nxFreeAndNil(OldTable);
                    Result := DBIERR_NONE;
                  end;
                except
                  on E : Exception do
                    Self.asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);
              end;
            end;
          end;
        end else begin
          Result := NotifyExtenders(eaTableRename, True, [aOldName, aNewName]);
          if Result <> DBIERR_NONE then
            Result := sfTableGetDictionary(aOldName, aPasswords, aForServer, Dict, @FileIsLink);
        end;

        if Result <> DBIERR_NONE then
          Exit;

        if FileIsLink then begin
          Result := DBIERR_TABLEREADONLY;
          Exit;
        end;

        if not nxVerifyFileName(aNewName) then begin
          Result := DBIERR_INVALIDTABLENAME;
          Exit;
        end;

        if SameText(ExtractFileExt(aOldName), '.' + sfServerEngine.seTableExtension) then
          OldName := ChangeFileExt(aOldName, '')
        else
          OldName := aOldName;

        if SameText(ExtractFileExt(aNewName), '.' + sfServerEngine.seTableExtension) then
          NewName := ChangeFileExt(aNewName, '')
        else
          NewName := aNewName;

        for i := 0 to Pred(Dict.FilesDescriptor.FileCount) do try
          if i = 0 then begin
            OldFullName := nxMakeFullFileName(sfPath,
              nxMakeFileNameExt(OldName, sfServerEngine.seTableExtension));
            NewFullName := nxMakeFullFileName(sfPath,
              nxMakeFileNameExt(NewName, sfServerEngine.seTableExtension));
          end else with Dict.FilesDescriptor.FileDescriptor[i] do begin
            OldFullName := nxMakeFullFileName(sfPath,
              nxMakeFileNameExt(OldName, Extension));
            NewFullName := nxMakeFullFileName(sfPath,
              nxMakeFileNameExt(NewName, Extension));
          end;
          nxRenameFile(OldFullName, NewFullName);
        except
          for j := Pred(i) downto 0 do begin
            if j = 0 then begin
              OldFullName := nxMakeFullFileName(sfPath,
                nxMakeFileNameExt(OldName, sfServerEngine.seTableExtension));
              NewFullName := nxMakeFullFileName(sfPath,
                nxMakeFileNameExt(NewName, sfServerEngine.seTableExtension));
            end else with Dict.FilesDescriptor.FileDescriptor[j] do begin
              OldFullName := nxMakeFullFileName(sfPath,
                nxMakeFileNameExt(OldName, Extension));
              NewFullName := nxMakeFullFileName(sfPath,
                nxMakeFileNameExt(NewName, Extension));
            end;
            nxRenameFile(NewFullName, OldFullName);
          end;
          raise;
        end;

        if Result = DBIERR_NONE then
          LockedInc(sfStructureGeneration);
      finally
        sfTablesPadlock.Unlock;
        nxFreeAndNil(Dict);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;


    if Result = DBIERR_NONE then
      NotifyExtenders(eaTableRename, False, [aOldName, aNewName])
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.sfUpdateIsInactive;
var
  IsInactive: Boolean;
begin
  IsInactive := (not Assigned(sfDatabasesHead)) and (sfInMemoryCount = 0) and sfIsInactive(False, False);
  if IsInactive then
    sfServerEngineAddToInactiveFolders
  else
    sfServerEngineRemoveFromInactiveFolders;
end;
{------------------------------------------------------------------------------}
procedure TnxServerFolder.UnlockTables;
begin
  sfTablesPadlock.Unlock;
end;
{==============================================================================}



{===TnxServerTransaction=======================================================}
function TnxServerTransaction.btGetTransactionLevelClass: TnxTransactionLevelClass;
begin
  Result := TnxServerTransactionLevel;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransaction.Commit;
var
  Link      : TnxServerTransactionLevelTableLink;
  NextLink  : TnxServerTransactionLevelTableLink;
  Cursor    : TnxServerTableCursor;
  FlushList : TnxFlushList;
begin
  if Nested then begin
    if not btTransLevelsTail.StopNested then
      Exit;

    btBufferManager.CommitTransaction(Self, nil, False);

    with TnxServerTransactionLevel(btTransLevelsTail) do begin
      while Assigned(stlTableLinksHead) do begin
        Link := stlTableLinksHead;
        with Link do begin
          ttlRemoveFromTransactionLevel;
          ttlTransactionLevel := TnxServerTransactionLevel(tlPrev);
          ttlAddToTransactionLevel;

          if Assigned(ttlConvertFrom) and
            (ttlTransactionLevel = ttlConvertFrom.ttlTransactionLevel) then begin
            ttlConvertFrom.ttlRemoveFromTransactionLevel;
            while Assigned(ttlConvertFrom.ttlCursorsHead) do begin
              Cursor := ttlConvertFrom.ttlCursorsHead;
              Cursor.stcRemoveFromTransLink;
              Cursor.stcTransLink := Link;
              Cursor.stcAddToTransLink;
            end;
            nxFreeAndNil(ttlConvertFrom);
          end;
        end;
      end;
      TnxServerTransactionLevel(tlPrev).tlLSN := tlLSN;
    end;
  end else begin
    FlushList := TnxFlushList.Create;
    try
      Link := TnxServerTransactionLevel(btTransLevelsTail).stlTableLinksHead;

      while Assigned(Link) do begin
        NextLink := Link.ttlTransactionLevelNext;

        with Link, ttlTable do
          if ttlExclusive and (ttlState = ttlsGranted) then
            srtBeginCommit(Self)
          else begin
            srtTransLinksPadlock.Lock;
            try
              ttlRemoveFromTable;
              srtCheckPendingRequests;
            finally
              srtTransLinksPadlock.UnLock;
            end;

            Link.Free;
          end;

        Link := NextLink;
      end;

      try
        try
          btBufferManager.CommitTransaction(Self, FlushList, False);
        finally
          Link := TnxServerTransactionLevel(btTransLevelsTail).stlTableLinksHead;
          while Assigned(Link) do
            with Link, ttlTable do begin
              srtEndCommitPhase1(Self);

              srtTransLinksPadlock.Lock;
              try
                ttlRemoveFromTable;
                srtCheckPendingRequests;
              finally
                srtTransLinksPadlock.UnLock;
              end;

              Link := Link.ttlTransactionLevelNext;
            end;
        end;
        FlushList.Flush(False);
      finally
        with TnxServerTransactionLevel(btTransLevelsTail) do
          while Assigned(stlTableLinksHead) do
            with stlTableLinksHead do begin
              ttlTable.srtEndCommitPhase2(Self);
              Free;
            end;
      end;
    finally
      nxFreeAndNil(FlushList);
    end;
  end;

  btTransLevelsTail.Free;
  if not Assigned(btTransLevelsTail) then
    Free
  else
    if btWriteThroughCommit and not Nested then begin
      btWriteThroughCommit := False;
      btBufferManager.CommitTransaction(Self, nil, True);
    end;
end;
{------------------------------------------------------------------------------}
constructor TnxServerTransaction.Create(aBufferManager         : TnxBufferManager;
                                        aOwningSession         : TObject;
                                        aSnapshot              : Boolean;
                                        aFailSafe              : Boolean;
                                        aOverrideForceFailsafe : Boolean = False);
begin
//!!!
//  if not stFolder.sfInMemOnly then begin
//    if not aOverrideForceFailsafe and stFolder.sfForceFailSafe then
//      aFailSafe := True;
//
//    if aSnapshot then
//      aFailSafe := False;
//  end else
//    aFailSafe := False;

  stTableLinks := TStringList.Create;
  stTableLinks.Sorted := True;
  stTableLinks.Duplicates := dupError;

  inherited Create(aBufferManager, aOwningSession, aSnapshot, aFailSafe);
end;
{------------------------------------------------------------------------------}
destructor TnxServerTransaction.Destroy;
begin
  inherited;
  nxFreeAndNil(stTableLinks);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransaction.Rollback;
begin
  with btTransLevelsTail do
    if not StopNested then begin
      MarkCorrupted;
      Exit;
    end;

  btBufferManager.RollbackTransaction(Self);

  with TnxServerTransactionLevel(btTransLevelsTail) do
    stlRollbackLocks;

  btTransLevelsTail.Free;
  if not Assigned(btTransLevelsTail) then
    Free;
end;
{------------------------------------------------------------------------------}
function TnxServerTransaction.stGetInfo: TnxTransactionInfo;
var
  lLevel: TnxServerTransactionLevel;
begin
  with Result do begin
    tiLevel      := 0;
    tiLevels     := nil;
    if Assigned(btTransLevelsTail) then begin
      lLevel := btTransLevelsTail as TnxServerTransactionLevel;
      tiLevel := lLevel.tlGetLevel;
      SetLength(tiLevels, Succ(lLevel.tlLevel));
      while Assigned(lLevel) do with lLevel do begin
        tiLevels[tlLevel] := stlGetInfo;
        lLevel := tlPrev as TnxServerTransactionLevel;
      end;
    end;
    tiStartTime	 := btStartTime;
    tiStartLSN   := btStartLSN;
    tiLSN        := btLSN;
    tiBlockCount := btBlockCount;
    tiState      := btState;
  end;
end;
{==============================================================================}



{==============================================================================}
constructor TnxServerTransContextOwnedTransaction.Create(aTransContext          : TnxServerTransContext;
                                                         aSnapshot              : Boolean;
                                                         aFailSafe              : Boolean;
                                                         aOverrideForceFailsafe : Boolean = False);
begin
  stcotTransContext := aTransContext;

  if not aOverrideForceFailsafe and stcotTransContext.stcForceFailSafe then
    aFailSafe := True;

  with aTransContext, Session, TnxServerEngine(ServerEngine) do
    inherited Create(seBufferManager, aTransContext.Session,
      aSnapshot, aFailSafe, aOverrideForceFailsafe);
end;
{------------------------------------------------------------------------------}
destructor TnxServerTransContextOwnedTransaction.Destroy;
begin
  with stcotTransContext do begin
    stcTransactionPadLock.Lock;
    try
      if stcTransaction = Self then
        stcTransaction := nil;
    finally
      stcTransactionPadLock.UnLock;
    end;
  end;
  inherited;
end;
{==============================================================================}



{===TnxServerTransactionLevel==================================================}
procedure TnxServerTransactionLevel.stlDeadlockDetected;
var
  TransactionLevel: TnxBaseTransactionLevel;
begin
  MarkDeadlock;

  TransactionLevel := TnxServerTransaction(tlTransaction).btTransLevelsTail;
  while TransactionLevel <> Self do begin
    TnxServerTransaction(tlTransaction).btBufferManager.RollbackTransactionLevel(TransactionLevel);
    TnxServerTransactionLevel(TransactionLevel).stlRollbackLocks;
    TransactionLevel := TnxServerTransactionLevel(TransactionLevel).tlPrev;
  end;
  TnxServerTransaction(tlTransaction).btBufferManager.RollbackTransactionLevel(Self);
  stlRollbackLocks;
end;
{------------------------------------------------------------------------------}
function TnxServerTransactionLevel.stlGetInfo: TnxTransactionLevelInfo;
begin
  with Result do begin
    tliStartTime    := tlStartTime;
    tliStartLSN     := tlStartLSN;
    tliLSN          := tlLSN;
    tliLevel        := tlLevel;
    tliBlockCount   := tlBlockCount;
    tliNestingCount := tlNestingCount;
    tliState        := tlState;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevel.stlRollbackEngines;
var
  TableLink : TnxServerTransactionLevelTableLink;
begin
  TableLink := stlTableLinksHead;
  while Assigned(TableLink) do begin
    TableLink.ttlTable.sbtEnginesRollback(tlTransaction);
    TableLink := TableLink.ttlTransactionLevelNext;
  end;

  if Assigned(tlPrev) then
    TnxServerTransactionLevel(tlPrev).stlRollbackEngines;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevel.stlRollbackLocks;
var
  Cursor : TnxServerTableCursor;
begin
  while Assigned(stlTableLinksHead) do
    with stlTableLinksHead do begin
      if Assigned(ttlConvertFrom) then begin
        ttlRemoveFromTransaction;
        ttlConvertFrom.ttlAddToTransaction;

        ttlConvertFrom.ttlConvertTo := nil;
        ttlTable.srtTransLinksPadlock.Lock;
        try
          ttlRemoveFromTable;
          ttlConvertFrom.ttlAddToTable;
          ttlTable.srtCheckPendingRequests;
        finally
          ttlTable.srtTransLinksPadlock.Unlock;
        end;

        while Assigned(ttlCursorsHead) do begin
          Cursor := ttlCursorsHead;
          Cursor.stcRemoveFromTransLink;
          Cursor.stcTransLink := ttlConvertFrom;
          Cursor.stcAddToTransLink;
        end;

        ttlConvertFrom := nil;
      end else with ttlTable do begin
        srtTransLinksPadlock.Lock;
        try
          sbtEnginesRollback(tlTransaction);
          sbtLocksEndTransaction(tlTransaction);
          ttlRemoveFromTable;
          srtCheckPendingRequests;
        finally
          srtTransLinksPadlock.Unlock;
        end;
      end;
    Free;
  end;
  stlRollbackEngines;
end;
{==============================================================================}



{===TnxServerTransactionLevelTableLink=========================================}
constructor TnxServerTransactionLevelTableLink.Create(aTransactionLevel : TnxServerTransactionLevel;
                                                      aTable            : TnxServerRootTable;
                                                      aExclusive        : Boolean;
                                                      aConvertFrom      : TnxServerTransactionLevelTableLink;
                                                      aReason           : TnxLockFailureReason);
begin
  ttlReason := aReason;

  ttlTransactionLevel := aTransactionLevel;
  ttlTable := aTable;
  ttlExclusive := aExclusive;
  if (tsSnapshot in ttlTransactionLevel.tlTransaction.State) and
    (ttlTable.srtTableScope <> tsTempUnnamed) then begin
    Assert(not ttlExclusive);
    ttlState := ttlsGranted;
    ttlSnapshot := True;
    ttlAddToTransaction;
    ttlAddToTransactionLevel;
    ttlAddToTable;
  end else
    if Assigned(aConvertFrom) then begin
      Assert(aConvertFrom.ttlTable = ttlTable);
      Assert(aConvertFrom.ttlTransactionLevel.tlTransaction = ttlTransactionLevel.tlTransaction);
      Assert(aConvertFrom.ttlTransactionLevel.tlLevel <= ttlTransactionLevel.tlLevel);
      Assert(aConvertFrom.ttlConvertTo = nil);
      ttlConvertFrom := aConvertFrom;
      ttlConvertFrom.ttlConvertTo := Self;
      ttlState := ttlsPendingUpgrade;
      case ttlTable.srtCanGrantRequest(Self) of
        cgrYes: begin
          ttlState := ttlsGranted;
          ttlUpgradeCompleted;
        end;
        cgrLater:
          ttlAddToTable;
        cgrNever:
          ttlState := ttlsFailed;
      end;
    end else
      case ttlTable.srtCanGrantRequest(Self) of
        cgrYes: begin
          ttlState := ttlsGranted;
          ttlAddToTransaction;
          ttlAddToTransactionLevel;
          ttlAddToTable;
        end;
        cgrLater: begin
          ttlAddToTransaction;
          ttlAddToTransactionLevel;
          ttlAddToTable;
        end;
        cgrNever:
          ttlState := ttlsFailed;
      end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTransactionLevelTableLink.Destroy;
var
  Cursor : TnxServerTableCursor;
begin
  while Assigned(ttlCursorsHead) do begin
    Cursor := ttlCursorsHead;
    Cursor.stcRemoveFromTransLink;
    Cursor.stcTransLink := nil;
  end;

  if Assigned(ttlConvertFrom) then
    ttlConvertFrom.ttlConvertTo := nil;
  if Assigned(ttlConvertTo) then
    ttlConvertTo.ttlConvertFrom := nil;

  ttlRemoveFromTransaction;
  ttlRemoveFromTransactionLevel;
  ttlRemoveFromTable;

  inherited;

  nxFreeAndNil(ttlEvent);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlAddToTable;
begin
  Assert(not ttlTableAdded);

  ttlTable.srtTransLinksPadlock.Lock;
  try
    case ttlState of
      ttlsPending: begin
        ttlTablePrev := ttlTable.srtTransLinksPendingTail;
        ttlTable.srtTransLinksPendingTail := Self;
        if Assigned(ttlTablePrev) then
          ttlTablePrev.ttlTableNext := Self;
        if not Assigned(ttlTable.srtTransLinksPendingHead) then
          ttlTable.srtTransLinksPendingHead := Self;
      end;
      ttlsPendingUpgrade: begin
        Assert(ttlTable.srtTransLinksPendingUpgrade = nil);
        ttlTable.srtTransLinksPendingUpgrade := Self;
      end;
      ttlsGranted:
        if ttlSnapshot then begin
          ttlTablePrev := ttlTable.srtTransLinksSnapshotGrantedTail;
          ttlTable.srtTransLinksSnapshotGrantedTail := Self;
          if Assigned(ttlTablePrev) then
            ttlTablePrev.ttlTableNext:=Self;
          if not Assigned(ttlTable.srtTransLinksSnapshotGrantedHead) then
            ttlTable.srtTransLinksSnapshotGrantedHead := Self;
        end else begin
          ttlTablePrev := ttlTable.srtTransLinksGrantedTail;
          ttlTable.srtTransLinksGrantedTail := Self;
          if Assigned(ttlTablePrev) then
            ttlTablePrev.ttlTableNext:=Self;
          if not Assigned(ttlTable.srtTransLinksGrantedHead) then
            ttlTable.srtTransLinksGrantedHead := Self;
        end;
    end;
    ttlTableAdded := True;
  finally
    ttlTable.srtTransLinksPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlAddToTransaction;
begin
  Assert(not ttlTransactionAdded);
  TnxServerTransaction(ttlTransactionLevel.tlTransaction).stTableLinks.AddObject
    (ttlTable.srtFolder.sfPath + '\' + ttlTable.srtName, Self);
  ttlTransactionAdded := True;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlAddToTransactionLevel;
begin
  Assert(not ttlTransactionLevelAdded);
  Assert(ttlTransactionLevelPrev = nil);
  Assert(ttlTransactionLevelNext = nil);
  Assert(ttlTransactionLevel <> nil);
  Assert(ttlTransactionLevel.stlTableLinksHead <> Self);
  Assert(ttlTransactionLevel.stlTableLinksTail <> Self);

  ttlTransactionLevelPrev := ttlTransactionLevel.stlTableLinksTail;
  ttlTransactionLevel.stlTableLinksTail := Self;
  if Assigned(ttlTransactionLevelPrev) then
    ttlTransactionLevelPrev.ttlTransactionLevelNext:=Self;
  if not Assigned(ttlTransactionLevel.stlTableLinksHead) then
    ttlTransactionLevel.stlTableLinksHead := Self;

  ttlTransactionLevelAdded := True;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlRemoveFromTransaction;
var
  Index : Integer;
begin
  if ttlTransactionAdded then begin
    with TnxServerTransaction(ttlTransactionLevel.tlTransaction).stTableLinks do
      if Find(ttlTable.srtFolder.sfPath + '\' + ttlTable.srtName, Index) then
        if Objects[Index] = Self then
          Delete(Index);
    ttlTransactionAdded := False;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlRemoveFromTransactionLevel;
begin
  if ttlTransactionLevelAdded then begin
    if Assigned(ttlTransactionLevelNext) then
      ttlTransactionLevelNext.ttlTransactionLevelPrev := ttlTransactionLevelPrev
    else
      if ttlTransactionLevel.stlTableLinksTail = Self then
        ttlTransactionLevel.stlTableLinksTail := ttlTransactionLevelPrev;

    if Assigned(ttlTransactionLevelPrev) then
      ttlTransactionLevelPrev.ttlTransactionLevelNext := ttlTransactionLevelNext
    else
      if ttlTransactionLevel.stlTableLinksHead = Self then
        ttlTransactionLevel.stlTableLinksHead := ttlTransactionLevelNext;

    ttlTransactionLevelNext := nil;
    ttlTransactionLevelPrev := nil;

    ttlTransactionLevelAdded := False;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlRemoveFromTable;
begin
  if ttlTableAdded then with ttlTable do begin
    srtTransLinksPadlock.Lock;
    try
      case ttlState of
        ttlsPending: begin
          if Assigned(ttlTableNext) then
            ttlTableNext.ttlTablePrev := ttlTablePrev
          else
            if srtTransLinksPendingTail = Self then
              srtTransLinksPendingTail := ttlTablePrev;

          if Assigned(ttlTablePrev) then
            ttlTablePrev.ttlTableNext := ttlTableNext
          else
            if srtTransLinksPendingHead = Self then
              srtTransLinksPendingHead := ttlTableNext;

          ttlTableNext := nil;
          ttlTablePrev := nil;
        end;
        ttlsPendingUpgrade: begin
          Assert(srtTransLinksPendingUpgrade = Self);
          srtTransLinksPendingUpgrade := nil;
        end;
        ttlsGranted:
          if ttlSnapshot then begin
            if Assigned(ttlTableNext) then
              ttlTableNext.ttlTablePrev := ttlTablePrev
            else
              if srtTransLinksSnapshotGrantedTail = Self then
                srtTransLinksSnapshotGrantedTail := ttlTablePrev;

            if Assigned(ttlTablePrev) then
              ttlTablePrev.ttlTableNext := ttlTableNext
            else
              if srtTransLinksSnapshotGrantedHead = Self then
                srtTransLinksSnapshotGrantedHead := ttlTableNext;

            ttlTableNext := nil;
            ttlTablePrev := nil;
          end else begin
            if Assigned(ttlTableNext) then
              ttlTableNext.ttlTablePrev := ttlTablePrev
            else
              if srtTransLinksGrantedTail = Self then
                srtTransLinksGrantedTail := ttlTablePrev;

            if Assigned(ttlTablePrev) then
              ttlTablePrev.ttlTableNext := ttlTableNext
            else
              if srtTransLinksGrantedHead = Self then
                srtTransLinksGrantedHead := ttlTableNext;

            ttlTableNext := nil;
            ttlTablePrev := nil;
          end;
      end;
      ttlTableAdded := False;
    finally
      srtTransLinksPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransactionLevelTableLink.ttlUpgradeCompleted;
var
  Cursor: TnxServerTableCursor;
begin
  ttlConvertFrom.ttlRemoveFromTransaction;
  ttlConvertFrom.ttlRemoveFromTable;

  if ttlConvertFrom.ttlTransactionLevel = ttlTransactionLevel then begin
    ttlConvertFrom.ttlRemoveFromTransactionLevel;
    while Assigned(ttlConvertFrom.ttlCursorsHead) do begin
      Cursor := ttlConvertFrom.ttlCursorsHead;
      Cursor.stcRemoveFromTransLink;
      Cursor.stcTransLink := Self;
      Cursor.stcAddToTransLink;
    end;
    nxFreeAndNil(ttlConvertFrom);
  end;

  ttlAddToTransaction;
  ttlAddToTransactionLevel;
  ttlAddToTable;
end;
{------------------------------------------------------------------------------}
function TnxServerTransactionLevelTableLink.WaitFor: TnxResult;
var
  Timeout : Integer;
begin
  if (ttlState <> ttlsGranted) and Assigned(ttlEvent) then begin
    TimeOut := nxGetRemainingTime;
    if TimeOut > 5 then
      if ttlEvent.WaitForQuietly(TimeOut) = WAIT_OBJECT_0 then
        nxFreeAndNil(ttlEvent);
  end;

  if ttlState = ttlsGranted then
    Result := DBIERR_NONE
  else
    Result := DBIERR_LOCKTIMEOUT;
end;
{==============================================================================}



{===TnxTableMapper=============================================================}
type
  TnxTableMapper = class(TnxInterfacedObject, InxTableMapper)
  protected {private}
    tmMappings : TStringList;
    tmPadlock  : TnxPadlock;
  protected
    { InxTableMapper }
    function Lock: TStringList;
    procedure Unlock;

    function Contains(const aTableName : string)
                                       : Boolean;
    function GetMappings: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxTableMapper.Contains(const aTableName: string): Boolean;
begin
  tmPadlock.Lock;
  try
    Result := tmMappings.IndexOf(aTableName) >= 0;
  finally
    tmPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxTableMapper.Create;
begin
  inherited Create;
  tmPadlock := TnxPadlock.Create(True);
  tmMappings := TStringList.Create;
  tmMappings.Sorted := True;
  tmMappings.Duplicates := dupError;
end;
{------------------------------------------------------------------------------}
destructor TnxTableMapper.Destroy;
var
  i: Integer;
begin
  inherited;
  tmPadlock.Lock;
  try
    if Assigned(tmMappings) then
      with tmMappings do
        for i := Pred(Count) downto 0 do begin
          Objects[i].Free;
          Delete(i);
        end;
    nxFreeAndNil(tmMappings);
  finally
    tmPadlock.Unlock;
  end;
  nxFreeAndNil(tmPadlock);
end;
{------------------------------------------------------------------------------}
function TnxTableMapper.GetMappings: TStringList;
begin
  Result := tmMappings;
end;
{------------------------------------------------------------------------------}
function TnxTableMapper.Lock: TStringList;
begin
  tmPadlock.Lock;
  Result := tmMappings;
end;
{------------------------------------------------------------------------------}
procedure TnxTableMapper.Unlock;
begin
  tmPadlock.Unlock;
end;
{==============================================================================}



{===TnxServerDatabase==========================================================}
function TnxServerDatabase.adGetIsCache: Boolean;
begin
  Result := sdIsCache;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.asoCreateInstance(const aClassID     : TnxGuid;
                                             const aOuter       : InxInterface;
                                             const aInterfaceID : TnxGuid;
                                               out aInterface   )
                                                                : HRESULT;
begin
  if nxSameGuid(aClassID, CLSID_AbstractDatabase) then
    if Supports(Self, aInterfaceID, aInterface) then
      Result := S_OK
    else
      Result := E_NOINTERFACE
  else
    Result := inherited asoCreateInstance(aClassID, aOuter, aInterfaceID, aInterface);
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  //make sure any external references have been dropped
  nxDisconnectObject(Self);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxServerDatabase.Create(aSession      : TnxServerSession;
                                     aTransContext : TnxServerTransContext;
                                     aAlias        : string;
                                     aFolder       : TnxServerFolder;
                                     aTimeout      : TnxWord32;
                                     aOpenMode     : TnxOpenMode;
                                     aShareMode    : TnxShareMode);
begin
  sdLastCheckLSN :=
    TnxServerEngine(aSession.ServerEngine).seBufferManager.CurrentLSN;

  sdTables := TnxTableMapper.Create;

  sdOpenMode := aOpenMode;
  sdShareMode := aShareMode;
  sdFolder := aFolder;
  sdIsCache := sdFolder.IsCache;
  sdAlias := aAlias;
  inherited Create(aSession, aTransContext, aTimeout);
  sdBlobLinkHandler := TnxBlobLinkHandler.Create(Self, nil);
  sdAddToFolder;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.CreateInstanceFor(const aName        : string;
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
  if SameText(Left, '<Folder>') then
    Result := sdFolder.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.CursorCacheOpen(out aCursor        : TnxAbstractCursor;
                                               aTransContext  : TnxAbstractTransContext;
                                         const aTableName     : string;
                                         const aPassword      : UnicodeString;
                                               aOpenMode      : TnxOpenMode;
                                               aShareMode     : TnxShareMode;
                                               aTimeout       : TnxWord32;
                                               aIndexName     : string;
                                               aIndexID       : Integer;
                                               aAllowSystem   : Boolean;
                                               aOpenOptions   : TnxCursorOpenOptions;
                                               aFilterTimeout : TnxWord32)
                                                              : TnxResult;
  {$IFDEF NX_LITE}
var
  {$I Lite\nxLite7.inc}
  {$I Lite\nxLite8.inc}
  {$ELSE}
begin
  {$ENDIF}

  Result := nxCheckValidTableName(aTableName, True, aAllowSystem);
  if Result <> DBIERR_NONE then
    Exit;

  if not sdIsCache then begin
    Result := EnxBaseException.nxSetMessage(DBIERR_FILENOACCESS, @rsDatabaseDoesNotSu);
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdCursorOpen(aCursor, aTransContext, aTableName, aPassword, False, aOpenMode, aShareMode, False,
      aTimeout, aIndexName, aIndexID, False, True);
    if (aFilterTimeout <> nxDefaultFilterTimeout) and
       (aCursor is TnxServerBaseCursor)
    then
      TnxServerBaseCursor(aCursor).sbcFilterTimeout := aFilterTimeout;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.CursorOpen(out aCursor        : TnxAbstractCursor;
                                          aTransContext  : TnxAbstractTransContext;
                                    const aTableName     : string;
                                    const aPassword      : UnicodeString;
                                          aOpenMode      : TnxOpenMode;
                                          aShareMode     : TnxShareMode;
                                          aTimeout       : TnxWord32;
                                          aIndexName     : string;
                                          aIndexID       : Integer;
                                          aAllowSystem   : Boolean;
                                          aOpenOptions   : TnxCursorOpenOptions;
                                          aFilterTimeout : TnxWord32;
                                          aMarkedBlobs   : TStrings)
                                                         : TnxResult;
  {$IFDEF NX_LITE}
var
  {$I Lite\nxLite7.inc}
  {$I Lite\nxLite8.inc}
  {$ELSE}
begin
  {$ENDIF}

  Result := nxCheckValidTableName(aTableName, True, aAllowSystem);
  if Result <> DBIERR_NONE then
    Exit;

  if sdIsCache and not aAllowSystem then begin
    Result := EnxBaseException.nxSetMessage(DBIERR_FILENOACCESS, @rsDatabaseDoesNotSu);
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdCursorOpen(aCursor, aTransContext, aTableName, aPassword, False, aOpenMode, aShareMode, False,
      aTimeout, aIndexName, aIndexID, False);
    if (aFilterTimeout <> nxDefaultFilterTimeout) and
       (aCursor is TnxServerBaseCursor)
    then
      TnxServerBaseCursor(aCursor).sbcFilterTimeout := aFilterTimeout;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerDatabase.Destroy;
begin
  nxFreeAndNil(sdBlobLinkHandler);

  inherited;
  sdTables := nil;
  sdRemoveFromFolder;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.esoOptionGetParent(const aName  : string;
                                                out aValue : string)
                                                           : TnxResult;
begin
  Result := DBIERR_OBJNOTFOUND;
  if Assigned(sdFolder) then
    Result := sdFolder.esoOptionGetEffective(aName, aValue);
  if Result = DBIERR_OBJNOTFOUND then
    Result := inherited esoOptionGetParent(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.esoOptionListParent(aList : TStrings)
                                                     : TnxResult;
var
  ParentList: TStringList;
begin
  if Assigned(sdFolder) then begin
    Result := sdFolder.esoOptionList(aList);

    if Result = DBIERR_NONE then begin
      ParentList := TStringList.Create;
      try
        Result := inherited esoOptionListParent(ParentList);
        if Result = DBIERR_NONE then
          Result := esoOptionListMerge(aList, ParentList);
      finally
        nxFreeAndNil(ParentList);
      end;
    end;
  end else
    Result := inherited esoOptionListParent(aList);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.GetAlias(out aAlias: string): TnxResult;
begin
  aAlias := sdAlias;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.GetChangedTables(aTables: TStrings): TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdGetChangedTables(aTables);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Alias', sdAlias);
  aContainer.AddValue('Folder', sdFolder);
  aContainer.AddValue('OpenMode', GetEnumName(TypeInfo(TnxOpenMode), Ord(sdOpenMode)));
  aContainer.AddValue('ShareMode', GetEnumName(TypeInfo(TnxShareMode), Ord(sdShareMode)));
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.GetFreeSpace(out aFreeSpace : TnxInt64)
                                                       : TnxResult;
var
  FreeAvailable : Int64;
  TotalSpace    : Int64;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  aFreeSpace := 0;
  atoLock.Lock;
  try
    if GetDiskFreeSpaceEx(PChar(sdFolder.sfPath), FreeAvailable, TotalSpace, nil) then
      aFreeSpace := FreeAvailable div 1024
    else
      Result := DBIERR_OSUNKNOWN;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  atoLock.Unlock(Result);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.GetPath(out aPath: string): TnxResult;
begin
  Result := DBIERR_NONE;
  aPath := sdFolder.sfPath;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.GetTablesNeedingPack: TnxUnicodeStrings;
begin
  sdIterateDictionaries(sdTablesNeedingPackIterator, ExplicitAllowSystem, True, @Result);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.RegisterCursorSource(aSource  : InxDatabaseCursorSource;
                                            out aControl : InxDatabaseCursorSourceControl)
                                                         : TnxResult;
begin
  aControl := TnxServerDatabaseCursorSourceContainer.Create(Self, aSource);
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sadCreateResultSet(aDictionary : TnxDataDictionary;
                                              aTimeout    : TnxWord32)
                                                          : TnxSqlAbstractCursor;
begin
  Result := TnxServerTableCursor.CreateResultSet(Self, nil, aDictionary, aTimeout);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sadGetAlias: UnicodeString;
begin
  Result := sdAlias;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.sadLockTables;
begin
  Folder.LockTables;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.sadUnlockTables;
begin
  Folder.UnlockTables;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.sdAddToFolder;
begin
  with sdFolder do begin
    sfDatabasesPadlock.Lock;
    try
      sdFolderPrev := sfDatabasesTail;
      sfDatabasesTail := Self;
      if Assigned(sdFolderPrev) then
        sdFolderPrev.sdFolderNext:=Self;
      if not Assigned(sfDatabasesHead) then
        sfDatabasesHead := Self;

      if not sfJournalChecked and not sfInMemOnly and not sfReadOnly then
        if Assigned(JournalEngineClass) then begin
          JournalEngineClass.Check(sdAlias, sfPath);
          sfJournalChecked := True;
        end;
      sfUpdateIsInactive;
    finally
      sfDatabasesPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdBuildPasswords(const aTable    : UnicodeString;
                                            const aPassword : UnicodeString)
                                                            : TnxUnicodeStrings;
begin
  Result := TnxServerSession(asoSession).ssBuildPasswords(sdAlias, aTable, aPassword);
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdCursorOpen(out aCursor       : TnxAbstractCursor;
                                            aTransContext : TnxAbstractTransContext;
                                      const aTableName    : string;
                                      const aPassword     : UnicodeString;
                                            aForServer    : Boolean;
                                            aOpenMode     : TnxOpenMode;
                                            aShareMode    : TnxShareMode;
                                            aIgnoreExcl   : Boolean;
                                            aTimeout      : TnxWord32;
                                            aIndexName    : string;
                                            aIndexID      : Integer;
                                            aInternal     : Boolean;
                                            aIsCache      : Boolean = False)
                                                          : TnxResult;

var
  Table          : TnxServerBaseTable;
  Cursor         : TnxServerTableCursor;
  //Cursor2        : TnxServerTableCursor;
  TriedRelease   : Boolean;
  IsReadOnly     : Boolean;
  {$IFDEF NX_LITE}
  {$I Lite\nxLite12.inc}
  {$ENDIF}
begin
  aCursor := nil;
  try
    if aOpenMode = omWriteOnly then
      aOpenMode := omReadWrite;

    if (sdOpenMode = omReadOnly) and (aOpenMode <> omReadOnly) then
      Result := DBIERR_READONLYDB
    else with sdFolder do begin
      sfTablesPadlock.Lock;
      with sdTables, Lock do try
        IsReadOnly := False;
        Result := sdGetTable(Table, aTableName, aPassword, aForServer, IsReadOnly, aInternal, aIsCache);
        if IsReadOnly then
          aOpenMode := omReadOnly;

        if Result = DBIERR_NONE then begin
          Table.sbtCursorsPadlock.Lock;
          try
            TriedRelease := False;
            if not aIgnoreExcl then repeat
              Cursor := Table.sbtCursorsHead;
              if Assigned(Cursor) then
                if Cursor.stcShareMode = smExclusive then begin
                  Result := DBIERR_NEEDEXCLACCESS
                end else
                  case aShareMode of
                    smExclusive:                                 {..exclusive, no sharing}
                      begin
                        Result := DBIERR_NEEDEXCLACCESS;
                      end;
                    smShared: begin                     {..allows others to Read or Write}
                      if aOpenMode <> omReadOnly then
                        while Assigned(Cursor) do begin
                          case Cursor.stcShareMode of
                            smShareRead: begin
                              Result := DBIERR_NEEDEXCLACCESS; //different error code?
                              break;
                            end;
                            smShared: begin
                              if Cursor.OpenMode <> omReadOnly then
                                { optimization, if another smShare with write access has already
                                  been granted then a smShareRead can not be in the list/ }
                                break;
                            end;
                          end;
                          Cursor := Cursor.stcTableNext;
                        end;
                    end;
                    smShareRead : begin                     {..allows others to Read only}
                      while Assigned(Cursor) do begin
                        if aOpenMode <> omReadOnly then
                          if Cursor.stcShareMode = smShareRead then begin
                            Result := DBIERR_NEEDEXCLACCESS; //different error code?
                            break;
                          end;
                        if Cursor.sbcOpenMode <> omReadOnly then begin
                          Result := DBIERR_NEEDEXCLACCESS; //different error code?
                          break;
                        end;
                        Cursor := Cursor.stcTableNext;
                      end;
                    end;
                  end;
              if Result <> DBIERR_NONE then
                if not TriedRelease then begin
                  with Table.sbtRoot do begin
                    LockedInc(sbtLockIsInactive);
                    try
                      srtIsInactive(True, True, 1);
                    finally
                      LockedDec(sbtLockIsInactive);
                    end;
                  end;
                  TriedRelease := True;
                  Result := DBIERR_NONE;
                end else
                  break
              else
                break;
            until False;

            if Result = DBIERR_NONE then begin
              if (Table.sbtRoot.srtOpenMode = omReadOnly) and (aOpenMode <> omReadOnly) then
                Result := DBIERR_TABLEREADONLY;

              if Result = DBIERR_NONE then
                aCursor := TnxServerTableCursor.Create
                  (True, Self, aTransContext, Table, aTimeout, aOpenMode, aShareMode, aIndexName, aIndexID,
                    Self.Session.ClientVersion >= nxVersion20000, aInternal);
            end;
          finally
            Table.sbtCursorsPadlock.Unlock;
          end;
        end else
          sdCursorSourceHead.CursorOpen(aCursor, aTableName, Result);

  {$ifdef AllowInactiveCleanup}
        if Result <> DBIERR_NONE then
          if Assigned(Table) and
            (seoCloseInactiveTables in TnxServerEngine(asoGetServerEngine).seOptions) then begin
            if Table.sbtRoot.srtIsInactive(False, False, 0) then
              Table.sbtRoot.Free;
          end;
  {$endif}

      finally
        Unlock;
        sfTablesPadlock.Unlock;
      end;
    end;

    { don't allow opening cursors with neither read nor write access }
    if (Result = DBIERR_NONE) and Assigned(aCursor) and (aCursor is TnxServerBaseCursor) then
      with TnxServerBaseCursor(aCursor) do begin
        if sbcIsWriteOnly and sbcIsReadOnly then
          Result := DBIERR_NOTSUFFTABLERIGHTS;
        if Result = DBIERR_NONE then
          //delayed bseInformMonitorsCreated until after sfTablesPadlock.Unlock
          Result := esoDelayedInformMonitors;
        if Result = DBIERR_NONE then
          if sbcIsWriteOnly and sbcIsReadOnly then
            Result := DBIERR_NOTSUFFTABLERIGHTS;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Result <> DBIERR_NONE then try
    nxFreeAndNil(aCursor);
  except
  end;
  if (Result = DBIERR_NONE) and not Assigned(aCursor) then
    Result := DBIERR_NX_UNKNOWN;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdGetChangedTables(aTables : TStrings)
                                                      : TnxResult;
var
  LastCheckLSN  : TnxLSN;
  CheckedTables : TStringList;
  Trans         : TnxBaseTransaction;
  Cursor        : TnxAbstractCursor;
  FullTableName : string;
  i             : Integer;
begin
  try
    Result := Self.NotifyExtenders(eaGetChangedTables, True, [aTables]);
    if Result <> DBIERR_NONE then
      Exit;

    Trans := (TransContext as TnxServerTransContext).stcTransaction;
    if Assigned(Trans) then
      LastCheckLSN := Pred(Trans.LSN)
    else
      LastCheckLSN :=
        TnxServerEngine(Session.ServerEngine).seBufferManager.CurrentLSN;

    adCursorsPadlock.Lock;
    try
      CheckedTables := TStringList.Create;
      try
        CheckedTables.Duplicates := dupError;
        CheckedTables.Sorted := True;

        aTables.BeginUpdate;
        try
          Cursor := adCursorsHead;
          while Assigned(Cursor) do begin
            if Cursor is TnxServerTableCursor then
              with TnxServerTableCursor(Cursor) do begin
                FullTableName := FullName;
                if not CheckedTables.Find(FullTableName, i) then begin
                  if stcTable.CurrentLSN[Trans] > sdLastCheckLSN then
                    aTables.Add(FullTableName);
                  CheckedTables.Add(FullTableName);
                end;
              end;
            Cursor := Cursor.DatabaseNext;
          end;
        finally
          aTables.EndUpdate;
        end;
      finally
        nxFreeAndNil(CheckedTables);
      end;
    finally
      adCursorsPadlock.UnLock;
    end;

    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaGetChangedTables, False, [aTables]);

    sdLastCheckLSN := LastCheckLSN;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdGetStructureGeneration: Integer;
begin
  if sdFolderStructureGeneration <> sdFolder.sfStructureGeneration then begin
    sdFolderStructureGeneration := sdFolder.sfStructureGeneration;
    Inc(sdStructureGeneration);
  end;
  Result := sdStructureGeneration;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdGetTable(out aTable      : TnxServerBaseTable;
                                    const aTableName  : string;
                                    const aPassword   : UnicodeString;
                                          aForServer  : Boolean;
                                      out aIsReadOnly : Boolean;
                                          aInternal   : Boolean;
                                          aIsCache    : Boolean)
                                                      : TnxResult;
var
  RootTableName  : string;
  ChildTableName : string;

  RealTableName  : string;

  Index          : Integer;

  NewlyOpened    : Boolean;
  RootTable      : TnxServerRootTable;
  Passwords      : TnxUnicodeStrings;
  {$IFDEF NX_LITE}
  {$I Lite\nxLite12.inc}
  {$ENDIF}
begin
  aIsReadOnly := False;
  aTable := nil;

  NewlyOpened := False;

  Passwords := sdBuildPasswords(aTableName, aPassword);

  nxStrSplit(aTableName, [':'], RootTableName, ChildTableName);

  Result := DBIERR_NONE;
  with sdFolder do try
    sfTablesPadlock.Lock;
    with sdTables, Lock do try
      if not Find(RootTableName, Index) then begin
        if not sfTables.Find(RootTableName, Index) then begin
          if sfInMemOnly then
            Result := DBIERR_NOSUCHTABLE
          else begin
            if sdFolder.sfTableExists(RootTableName) = DBIERR_NONE then begin
              if sdFolder.sfReadOnly then begin

                RootTable := TnxServerRootTable.Create
                  (sdFolder, RootTableName, omReadOnly, smShareRead, tsPersistent);
                try
                  Result := RootTable.srtOpenFiles(nil, Passwords, aForServer, [], aIsReadOnly);
                  NewlyOpened := True;
                except
                  on E : Exception do
                    Result := Self.asoConvertException(E);
                end;

              end else begin

                RootTable := TnxServerRootTable.Create
                  (sdFolder, RootTableName, omReadWrite, smExclusive, tsPersistent);
                try
                  Result := RootTable.srtOpenFiles(nil, Passwords, aForServer, [], aIsReadOnly);
                  NewlyOpened := True;
                except
                  on E : Exception do
                    Result := Self.asoConvertException(E);
                end;

                if Result = DBIERR_NOSUCHTABLE then begin
                  nxFreeAndNil(RootTable);

                  RootTable := TnxServerRootTable.Create
                    (sdFolder, RootTableName, omReadOnly, smShareRead, tsPersistent);
                  try
                    Result := RootTable.srtOpenFiles(nil, Passwords, aForServer, [], aIsReadOnly);
                    NewlyOpened := True;
                  except
                    on E : Exception do
                      Result := Self.asoConvertException(E);
                  end;
                end;

              end;

              if Result <> DBIERR_NONE then
                nxFreeAndNil(RootTable);
            end else
              Result := DBIERR_NOSUCHTABLE;
          end;

          if Result = DBIERR_NOSUCHTABLE then
            Result := EnxBaseException.nxSetMessage(Result,
              nxcOrgMessageMarker + ' Root table "' + RootTableName + '" not found');

        end else begin
          RootTable := TnxServerRootTable(sfTables.Objects[Index]);
          Result := RootTable.srtAuthenticatePassword(Passwords);
          if Result = DBIERR_TABLEREADONLY then begin
            Result := DBIERR_NONE;
            aIsReadOnly := True;
          end;
        end;
      end else begin
        RootTable := TnxServerRootTable(Objects[Index]);
        Result := RootTable.srtAuthenticatePassword(Passwords);
        if Result = DBIERR_TABLEREADONLY then begin
          Result := DBIERR_NONE;
          aIsReadOnly := True;
        end;
      end;

      if Result = DBIERR_NONE then begin
        if RootTable.srtOpenMode = omReadOnly then
          aIsReadOnly := True;

        if NewlyOpened and not aInternal then
          if seoVerifyTableNames in (Self.asoSession.ServerEngine as TnxServerEngine).seOptions then begin
            with TnxMemoryStream.Create do try
              if RootTable.srtStreamEngine.ReadNamedStream(nil, '$TableName', TheStream) = DBIERR_NONE then begin
                Position := 0;
                with TnxReader.Create(TheStream) do try
                  RealTableName := ReadString;
                  if not SameText(RootTableName, RealTableName) then begin
                    Result := EnxBaseException.nxSetMessage(DBIERR_INVALIDTABLENAME, 'Table file name ("%s") does not match actual table name ("%s")', [RootTableName, RealTableName]);
                    nxFreeAndNil(RootTable);
                  end;
                finally
                  Free;
                End;
              end;
            finally
              Free;
            end;
          end;
      end;

      if Result = DBIERR_NONE then
        Result := RootTable.GetChild(ChildTableName, aTable);

      {$IFDEF NX_LITE}
      {$I Lite\nxLite14.inc}
      {$ENDIF}

    finally
      sfTablesPadlock.UnLock;
      Unlock;
    end;
  finally
    if (Result = DBIERR_NONE) and Assigned(aTable) then
      if aTable.IsCache <> aIsCache then begin
        Result := EnxBaseException.nxSetMessage(DBIERR_FILENOACCESS, @rsTableHasConflictin);
        aTable := nil;
      end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdIterateDictionaries(aIterator    : TnxDictionaryIterator;
                                                 aAllowSystem : Boolean;
                                                 aIgnoreError : Boolean;
                                                 aCookie      : Pointer)
                                                              : TnxIteratorResult;
var
  Tables     : TStringList;
  Error      : TnxResult;
  i          : Integer;
  Dictionary : TnxDataDictionary;
begin
  Result := irContinue;
  sdFolder.sfTablesPadlock.Lock;
  try
    sdTables.Lock;
    try
      Tables := TStringList.Create;
      try
        Error := sdTableGetList(Tables, aAllowSystem);
        if Error <> DBIERR_NONE then
          raise EnxServerException.nxCreate(Error);

        for i := 0 to Pred(Tables.Count) do begin
          if Assigned(Tables.Objects[i]) then begin
            Result := aIterator(TnxServerRootTable(Tables.Objects[i]).srtDictionary, aCookie);
            if Result = irStop then
              Exit;
          end else begin
            Dictionary := TnxDataDictionary.Create;
            try
              Error := sdTableGetDictionary(Tables[i], '', Dictionary);
              if Error <> DBIERR_NONE then begin
                if aIgnoreError then
                  Result := irContinue
                else
                  raise EnxServerException.nxCreate(Error)
              end else
                Result := aIterator(Dictionary, aCookie);
              if Result = irStop then
                Exit;
            finally
              Dictionary.Free
            end;
          end;
        end;
      finally
        nxFreeAndNil(Tables);
      end;
    finally
      sdTables.Unlock;
    end;
  finally
    sdFolder.sfTablesPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.sdRemoveFromFolder;
var
  CheckInactive: Boolean;
begin
  sdFolder.sfDatabasesPadlock.Lock;
  try
    if Assigned(sdFolderNext) then
      sdFolderNext.sdFolderPrev := sdFolderPrev
    else
      if sdFolder.sfDatabasesTail = Self then
        sdFolder.sfDatabasesTail := sdFolderPrev;

    if Assigned(sdFolderPrev) then
      sdFolderPrev.sdFolderNext := sdFolderNext
    else
      if sdFolder.sfDatabasesHead = Self then
        sdFolder.sfDatabasesHead := sdFolderNext;

    sdFolderNext := nil;
    sdFolderPrev := nil;

    CheckInactive :=
    {$ifdef AllowInactiveCleanup}
      (seoCloseInactiveFolders in TnxServerEngine(asoGetServerEngine).seOptions) and
      sdFolder.sfIsInactive(False, False);
    {$else}
      false;
    {$endif}

    sdFolder.sfUpdateIsInactive;
  finally
    sdFolder.sfDatabasesPadlock.Unlock;
  end;

  if CheckInactive then
    with TnxServerEngine(asoGetServerEngine), seFoldersPadlock, sdFolder do begin
      Lock;
      try
        if sfIsInactive(False, False) then
          sdFolder.Free;
      finally
        Unlock;
      end;
    end;

  sdFolder := nil;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdStatementAlloc(out aStatement : TnxAbstractStatement;
                                                aTimeout   : TnxWord32)
                                                           : TnxResult;
begin
  aStatement := nil;
  try
    with sdFolder.sfServerEngine do
      if Assigned(seSqlEngine) then
        Result := seSqlEngine.StatementAlloc(Self, aStatement, aTimeout)
      else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSqlEngineRequired);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Result <> DBIERR_NONE then try
    nxFreeAndNil(aStatement);
  except
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdStatementExecDirect(aTimeout         : TnxWord32;
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
                                                                  : TnxResult;
var
  Statement : TnxServerStatement;
begin
  Result := DBIERR_NONE;
  aCursor := nil;
  aPhase := sedAlloc;
  try
    try
      nxLockTimeout;
      try

        Result := sdStatementAlloc(TnxAbstractStatement(Statement), aTimeout);

        if Result = DBIERR_NONE then try

          Statement.asExecDirect:=true;
          aPhase := sedPrepare;
          Result := Statement.ssPrepare(aStatementType, aQueryText, aPrepareStream);
          if Result <> DBIERR_NONE then
            Exit;

          aPhase := sedSetParams;
          Result := Statement.ssSetParams(aParams, aSetParamsStream);
          if Result <> DBIERR_NONE then
            Exit;

          aPhase := sedExec;
          TnxSessionStats.Count(sscStatements);
          LockedInc((asoSession.ServerEngine as TnxServerEngine).seExecutingStatements);
          try
            Result := Statement.ssExec(aCursor, aOpenMode, aExecStream);
          finally
            LockedDec((asoSession.ServerEngine as TnxServerEngine).seExecutingStatements);
          end;
          LockedInc((asoSession.ServerEngine as TnxServerEngine).seExecutedStatements);
          if Result <> DBIERR_NONE then
            Exit;

          aPhase := sedGetParams;
          if Assigned(aGetParamsStream) then begin
            Result := Statement.ssGetParams(aParams, aGetParamsStream);
            if Result <> DBIERR_NONE then
              Exit;
          end;

          aPhase := sedFree;
        finally
          nxFreeAndNil(Statement);
        end;

      finally
        nxUnlockTimeout;
      end;

    except
      on E : Exception do
        if aExecStream<>nil then
          Result := Self.asoConvertException(E)
        else
          raise;
    end;
  finally
    if Result <> DBIERR_NONE then try
      nxFreeAndNil(aCursor);
    except end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabase.sdStructureGenerationInc(aIsGlobal: Boolean);
begin
  Inc(sdStructureGeneration);
  if aIsGlobal then
    LockedInc(sdFolder.sfStructureGeneration);
  sdFolderStructureGeneration := sdFolder.sfStructureGeneration;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableBuild(aOverWrite  : Boolean;
                                  const aTableName  : string;
                                  const aPassword   : UnicodeString;
                                        aDictionary : TnxDataDictionary;
                                        aTableScope : TnxTableScope)
                                                    : TnxResult;
var
  i     : Integer;
  Table : TnxServerRootTable;
begin
  if sdOpenMode = omReadOnly then
    Result := DBIERR_READONLYDB
  else begin
    if aTableScope = tsPersistent then begin
      if (sdFolder.sfInMemOnly or nxTableNameIsTempGlobal(aTableName)) then
        aTableScope := tsTempGlobal
      else if nxTableNameIsTempDatabase(aTableName) then
        aTableScope := tsTempDatabase;
    end;

    Result := Self.NotifyExtenders(eaTableBuild, True, [aOverWrite, aTableName, aDictionary, @aTableScope]);

    if Result = DBIERR_NONE then with sdTables, Lock do try

      if Find(aTableName, i) then begin
        if not aOverWrite then begin
          Result := DBIERR_TABLEEXISTS;
          Exit;
        end;
      end else
        i := -1;

      if aTableScope in [tsTempDatabase, tsTempGlobal] then
        if Folder.sfTableExists(aTableName)=0 then
          if not aOverWrite then begin
              Result := DBIERR_TABLEEXISTS;
              Exit;
          end;

      if aTableScope = tsTempDatabase then begin
        Result := sdFolder.sfTableBuildPrim
          ('', aPassword, False, aDictionary, aTableScope, Table);

        if Result = DBIERR_NONE then begin
          Table.sbtNameInScope := aTableName;
          Table.srtDictionary._BaseName := aTableName;
          if i >= 0 then begin
            Result := DBIERR_TABLEOPEN;
            with TnxServerRootTable(Objects[i]) do begin
              LockedInc(sbtLockIsInactive);
              if srtIsInactive(True, True, 1) then try
                LockedDec(sbtLockIsInactive);
                if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                  Free;
                  Objects[i] := Table;
                  Result := DBIERR_NONE;
                end;
              except
                on E : Exception do
                  Self.asoConvertException(E); {will create a log entry...}
              end else
                LockedDec(sbtLockIsInactive);
            end;
            if Result <> DBIERR_NONE then
              nxFreeAndNil(Table);
          end else
            AddObject(aTableName, Table);
        end;
      end else begin
        if i >= 0 then begin
          Result := DBIERR_TABLEOPEN;
          with TnxServerRootTable(Objects[i]) do begin
            LockedInc(sbtLockIsInactive);
            if srtIsInactive(True, True, 1) then try
              LockedDec(sbtLockIsInactive);
              if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                Free;
                Delete(i);
                Result := DBIERR_NONE;
              end;
            except
              on E : Exception do
                Self.asoConvertException(E); {will create a log entry...}
            end else
              LockedDec(sbtLockIsInactive);
          end;
        end;

        if Result = DBIERR_NONE then
          Result := sdFolder.sfTableBuild
            (aOverWrite, aTableName, aPassword, False, aDictionary, aTableScope);
      end;

      if (Result = DBIERR_NONE) and (aTableName <> '') and not nxStartsWith(aTableName, ' ') then begin
        Inc(sdStructureGeneration);
        sdFolderStructureGeneration := sdFolder.sfStructureGeneration;
      end;
    finally
      Unlock;
    end;

    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaTableBuild, False, [aOverWrite, aTableName, aDictionary, @aTableScope]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableDelete(const aTableName : string;
                                         const aPassword  : UnicodeString)
                                                          : TnxResult;
var
  i         : Integer;
  Passwords : TnxUnicodeStrings;
begin
  Passwords := sdBuildPasswords(aTableName, aPassword);
  try
    if sdOpenMode = omReadOnly then
      Result := DBIERR_READONLYDB
    else begin
      with sdTables, Lock do try

        if Find(aTableName, i) then begin
          with TnxServerRootTable(Objects[i]) do begin
            Result := Self.NotifyExtenders(eaTableDelete, True, [aTableName, @srtTableScope]);
            if Result = DBIERR_NONE then begin
              Result := srtAuthenticatePassword(Passwords);
              if Result = DBIERR_NONE then begin
                Result := DBIERR_TABLEOPEN;
                LockedInc(sbtLockIsInactive);
                if srtIsInactive(True, True, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    Delete(i);
                    Free;
                    Result := DBIERR_NONE;
                  end;
                except
                  on E : Exception do
                    Self.asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);
              end;
            end;
          end;
        end else begin
          Result := Self.NotifyExtenders(eaTableDelete, True, [aTableName]);
          if Result = DBIERR_NONE then
            Result := sdFolder.sfTableDelete(aTableName, Passwords, False);
        end;

        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaTableDelete, False, [aTableName]);

        if (Result = DBIERR_NONE) and (aTableName <> '') and not nxStartsWith(aTableName, ' ') then begin
          Inc(sdStructureGeneration);
          sdFolderStructureGeneration := sdFolder.sfStructureGeneration;
        end;
      finally
        Unlock;
      end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableExists(const aTableName : string;
                                         const aPassword  : UnicodeString;
                                               aForServer : Boolean)
                                                          : TnxResult;
var
  RootName   : string;
  ChildName  : string;
  Table      : TnxServerBaseTable;
  IsReadOnly : Boolean;
begin
  with sdFolder do begin
    sfTablesPadlock.Lock;
    with sdTables, Lock do try
      nxStrSplit(aTableName, [':'], RootName, ChildName);

      if sdTables.Contains(RootName) then
        Result := DBIERR_NONE
      else
        Result := sdFolder.sfTableExists(RootName);

      if (Result = DBIERR_NONE) and (ChildName <> '') then begin
        Table := nil;
        Result := sdGetTable(Table, aTableName, aPassword, aForServer, IsReadOnly, False, sdIsCache);
        if Result = DBIERR_NOSUCHTABLE then
          Result := DBIERR_OBJNOTFOUND;

    {$ifdef AllowInactiveCleanup}
        if Assigned(Table) and
          (seoCloseInactiveTables in TnxServerEngine(asoGetServerEngine).seOptions) then begin
          if Table.sbtRoot.srtIsInactive(False, False, 0) then
            Table.sbtRoot.Free;
        end;
    {$endif}        
      end;
    finally
      Unlock;
      sfTablesPadlock.UnLock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableGetDictionary(const aTableName  : string;
                                                const aPassword   : UnicodeString;
                                                      aDictionary : TnxDataDictionary)
                                                                  : TnxResult;
var
  i         : Integer;
  Passwords : TnxUnicodeStrings;
begin
  Result := Self.NotifyExtenders(eaTableGetDictionary, True, [aTableName, aDictionary]);
  Passwords := sdBuildPasswords(aTableName, aPassword);
  if Result = DBIERR_NONE then begin
    with sdTables, Lock do try
      if Find(aTableName, i) then begin
        Result := TnxServerRootTable(Objects[i]).srtAuthenticatePassword(Passwords);
        if Result = DBIERR_NONE then begin
          aDictionary.Assign(TnxServerRootTable(Objects[i]).srtDictionary);
          Self.NotifyExtenders(eaTableGetDictionary, False, [aTableName, aDictionary]);
        end;
        Exit;
      end;
    finally
      Unlock;
    end;

    Result := sdFolder.sfTableGetDictionary(aTableName, Passwords, False, aDictionary);

    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaTableGetDictionary, False, [aTableName, aDictionary]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableGetList(aList        : TStrings;
                                          aAllowSystem : Boolean)
                                                       : TnxResult;
var
  i    : Integer;
  List : TStringList;
begin
  aList.BeginUpdate;
  try
    aList.Clear;

    try
      Result := Self.NotifyExtenders(eaTableGetList, True, [aList]);
      if Result = DBIERR_NONE then begin
        aList.BeginUpdate;
        try
          aList.Clear;

          List := TStringList.Create;
          try
            List.Sorted := True;
            List.Duplicates := dupIgnore;

            Result := sdFolder.sfTableGetList(List);
            with sdTables, Lock do try
              List.AddStrings(Mappings);
            finally
              Unlock;
            end;

            for i := Pred(List.Count) downto 0 do
              if nxCheckValidRootTableName(List[i], False, aAllowSystem) <> DBIERR_NONE then
                List.Delete(i);

            aList.AddStrings(List);
          finally
            nxFreeAndNil(List);
          end;
        finally
          aList.EndUpdate;
        end;
        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaTableGetList, False, [aList]);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableRebuildIndex(const aTableName : string;
                                               const aPassword  : UnicodeString;
                                               const aIndexName : string;
                                                     aIndexID   : Integer;
                                                 out aTaskInfo  : TnxAbstractTaskInfo)
                                                                : TnxResult;
var
  Database     : TnxServerDatabase;
  Cursor       : TnxServerTableCursor;
begin
  Result := DBIERR_NONE;
  aTaskInfo := nil;
  try
    if sdOpenMode = omReadOnly then
      Result := DBIERR_READONLYDB
    else begin
      Result := TnxServerSession(asoSession).ssDatabaseOpen(
        TnxAbstractDatabase(Database), sdAlias, nil, sdFolder, sdOpenMode,
        sdShareMode, True, atoTimeout);
      if Result = DBIERR_NONE then try
        Database.sdTables := sdTables;

        Result := Database.sdCursorOpen(TnxAbstractCursor(Cursor), nil,
          aTableName, aPassword, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then try

          with Cursor.stcTable.sbtTableDescriptor do
            if Assigned(IndicesDescriptor) then
              with IndicesDescriptor do begin
                if aIndexName <> '' then
                  aIndexID := GetIndexFromName(aIndexName);

                if (aIndexID < 0) or (aIndexID >= IndexCount) then
                  Result := DBIERR_NOSUCHINDEX;
              end else
                Result := DBIERR_NOSUCHINDEX;

          if Result = DBIERR_NONE then
            if not Cursor.stcTable.IndicesEngine.Indices[aIndexID].KeyEngine.SupportsReindex then
              Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsRebuildingIsNotSupported);

          if Result <> DBIERR_NONE then
            Abort;


          Result := sdFolder.NotifyExtenders(eaTableRebuildIndex, True, [aTableName, aIndexID, @Cursor.stcTable.sbtRoot.srtTableScope]);
          if Result <> DBIERR_NONE then
            Abort;
          Result := Self.NotifyExtenders(eaTableRebuildIndex, True, [aTableName, aIndexID, @Cursor.stcTable.sbtRoot.srtTableScope]);
          if Result <> DBIERR_NONE then
            Abort;

          aTaskInfo := TnxServerRebuildIndexTaskInfo.Create(Cursor, aIndexID);
        except
          nxFreeAndNil(Cursor);
          raise;
        end else
          Abort;
      except
        nxFreeAndNil(Database);
        raise;
      end;
    end;
  except
    on E : EAbort do
      if Result = DBIERR_NONE then
        Result := Self.asoConvertException(E);
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableRecover(const aTableName : string;
                                          const aPassword  : UnicodeString;
                                            out aTaskInfo  : TnxAbstractTaskInfo)
                                                           : TnxResult;
var
  RootTableName  : string;
  ChildTableName : string;

  Database       : TnxServerDatabase;
  SourceCursor   : TnxServerTableCursor;

  TargetCursor   : TnxServerTableCursor;
  FailedCursor   : TnxServerTableCursor;

  FailedName     : string;
  TargetName     : string;

  MinDictionary  : TnxDataDictionary;

  Password       : UnicodeString;
begin
  nxStrSplit(aTableName, [':'], RootTableName, ChildTableName);
  if ChildTableName <> '' then
    Result := DBIERR_INVALIDPARAM
  else begin
    Result := DBIERR_NONE;
    aTaskInfo := nil;
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := Self.NotifyExtenders(eaTableRecover, True, [aTableName]);
        if Result <> DBIERR_NONE then
          Exit;

        Result := TnxServerSession(asoSession).ssDatabaseOpen(
          TnxAbstractDatabase(Database), sdAlias, nil, sdFolder, sdOpenMode,
          sdShareMode, True, atoTimeout);
        if Result = DBIERR_NONE then try
          Database.sdTables := sdTables;

          _ForRecover := True;
          try
            Result := Database.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
              aTableName, aPassword, False, omReadOnly, smExclusive, False, atoTimeout, '', -1, False);
          finally
            _ForRecover := False;
          end;
          if Result = DBIERR_NONE then try
            Password := SourceCursor.stcTable.sbtRoot.srtExtractPassword;
            if SourceCursor.stcTable.sbtRoot.srtSnapshotBlockCount > 0 then begin
              Result := DBIERR_TABLEOPEN;
              Abort;
            end;

            TargetName := aTableName + '_Recovered';
            FailedName := aTableName + '_Failed';

            sdFolder.sfTablesPadlock.Lock;
            try
             Result := Database.sdTableBuild(True, TargetName, Password,
               SourceCursor._Dictionary, SourceCursor.stcTable.sbtRoot.srtTableScope);
             if Result = DBIERR_NONE then try
               Result := Database.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
                 TargetName, Password, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
               if Result = DBIERR_NONE then try

                 MinDictionary := TnxDataDictionary.Create;
                 try
                   MinDictionary.AssignOnlyFields(SourceCursor._Dictionary);

                   Result := Database.sdTableBuild(True, FailedName, Password,
                     MinDictionary, SourceCursor.stcTable.sbtRoot.srtTableScope);
                   if Result = DBIERR_NONE then try
                     Result := Database.sdCursorOpen(TnxAbstractCursor(FailedCursor), nil,
                       FailedName, Password, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
                     if Result = DBIERR_NONE then try
                       aTaskInfo := TnxServerRecoverTaskInfo.Create(
                         TnxServerRecoverContainer.Create
                           (SourceCursor, TargetCursor, FailedCursor));
                     except
                       nxFreeAndNil(FailedCursor);
                       raise;
                     end else
                       Abort;
                   except
                     sdTableDelete(FailedName, Password);
                     raise;
                   end else
                     Abort;
                 finally
                   nxFreeAndNil(MinDictionary);
                 end;
               except
                 nxFreeAndNil(TargetCursor);
                 raise;
               end else
                 Abort;
             except
               sdTableDelete(TargetName, Password);
               raise;
             end else
               Abort;
            finally
              sdFolder.sfTablesPadlock.Unlock;
            end;
          except
            nxFreeAndNil(SourceCursor);
            raise;
          end else
            Abort;
        except
          nxFreeAndNil(Database);
          raise;
        end;
      end;
    except
      on E : EAbort do
        if Result = DBIERR_NONE then
          Result := Self.asoConvertException(E);
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  end;
end;

function TnxServerDatabase.sdTableRename(const aOldName  : string;
                                         const aNewName  : string;
                                         const aPassword : UnicodeString)
                                                         : TnxResult;
var
  i         : Integer;
  Passwords : TnxUnicodeStrings;
  Cursor    : TnxAbstractCursor;
begin
  Passwords := sdBuildPasswords(aOldName, aPassword);
  try
    if sdOpenMode = omReadOnly then
      Result := DBIERR_READONLYDB
    else with sdTables, Lock do try

      if Find(aOldName, i) then begin

        Result := Self.NotifyExtenders(eaTableRename, True, [aOldName, aNewName, @TnxServerRootTable(Objects[i]).srtTableScope]);
        if Result = DBIERR_NONE then begin
          if IndexOf(aNewName) < 0 then begin
            if sdFolder.sfTableExists(aNewName) = DBIERR_NONE then
              Result := DBIERR_TABLEEXISTS
            else begin
              Result := TnxServerRootTable(Objects[i]).srtAuthenticatePassword(Passwords);
              if Result = DBIERR_NONE then begin
                with TnxServerBaseTable(Objects[i]) do begin
                  sbtNameInScope := aNewName;
                  Root.srtDictionary._BaseName := aNewName;
                end;
                AddObject(aNewName, Objects[i]);
                Delete(IndexOf(aOldName));
              end;
            end;
          end else
            Result := DBIERR_TABLEEXISTS;
        end;
        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaTableRename, False, [aOldName, aNewName]);

      end else begin

        Result := Self.NotifyExtenders(eaTableRename, True, [aOldName, aNewName]);
        if Result = DBIERR_NONE then begin
          Result := sdFolder.sfTableRename(aOldName, aNewName, Passwords, False);
          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaTableRename, False, [aOldName, aNewName]);
        end;

      end;

      if Result = DBIERR_NONE then begin

        Result := sdCursorOpen(Cursor, nil, aNewName, aPassword, False, omReadWrite, smExclusive, False, 10000, '', -1, True);
        if Result = DBIERR_NONE then try
          if Cursor is TnxServerTableCursor then begin
            with TnxMemoryStream.Create do try
              with TnxWriter.Create(TheStream) do try
                WriteString(aNewName);
              finally
                Free;
              end;
              Result := TnxServerTableCursor(Cursor).sbcTableStreamWrite('$TableName', TheStream, True);
            finally
              Free;
            end;
          end;
        finally
          Cursor.Free;
        end;

      end;

      if (Result = DBIERR_NONE) and (aOldName <> '') and (aNewName <> '') and not nxStartsWith(aOldName, ' ') and not nxStartsWith(aNewName, ' ') then begin
        Inc(sdStructureGeneration);
        sdFolderStructureGeneration := sdFolder.sfStructureGeneration;
      end;
    finally
      Unlock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableRestructure(const aTableName   : string;
                                              const aPassword    : UnicodeString;
                                                    aDictionary  : TnxDataDictionary;
                                                    aMapperDesc  : TnxBaseTableMapperDescriptor;
                                                out aTaskInfo    : TnxAbstractTaskInfo)
                                                                 : TnxResult;
var
  RootTableName  : string;
  ChildTableName : string;

  Database       : TnxServerDatabase;
  SourceCursor   : TnxServerTableCursor;
  TargetCursor   : TnxServerTableCursor;
  TargetName     : string;
  Password       : UnicodeString;
begin
  aTaskInfo := nil;

  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  if not nxPatchPPLPresent then begin
    Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsPatchPPLrequired);
    Exit;
  end;
  {$ENDIF}

  nxStrSplit(aTableName, [':'], RootTableName, ChildTableName);
  if ChildTableName <> '' then
    Result := DBIERR_INVALIDPARAM
  else begin
    Result := DBIERR_NONE;
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := TnxServerSession(asoSession).ssDatabaseOpen(
          TnxAbstractDatabase(Database), sdAlias, nil, sdFolder, sdOpenMode,
          sdShareMode, True, atoTimeout);
        if Result = DBIERR_NONE then try
          Database.sdTables := sdTables;
          if ExplicitAllowSystem then
            Database.OptionSet('ALLOWSYSTEMTABLEACCESS', '1');

          Result := Database.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
            aTableName, aPassword, False, omReadOnly, smExclusive, False, atoTimeout, '', -1, False);
          if Result = DBIERR_NONE then try
            Result := sdFolder.NotifyExtenders(eaTableRestructure, True,
              [aTableName, aDictionary, aMapperDesc, @SourceCursor.stcTable.sbtRoot.srtTableScope]);
            if Result <> DBIERR_NONE then
              Abort;
            Result := Self.NotifyExtenders(eaTableRestructure, True,
              [aTableName, aDictionary, aMapperDesc, @SourceCursor.stcTable.sbtRoot.srtTableScope]);
            if Result <> DBIERR_NONE then
              Abort;

            if aDictionary.EncryptionEngine <> '' then
              Password := SourceCursor.stcTable.sbtRoot.srtExtractPassword
            else
              Password := '';
            if SourceCursor.stcTable.sbtRoot.srtSnapshotBlockCount > 0 then begin
              Result := DBIERR_TABLEOPEN;
              Abort;
            end;

            if SourceCursor.stcTable.sbtRoot.srtFileIsLink then begin
              Result := DBIERR_TABLEREADONLY;
              Abort;
            end;

            sdFolder.sfTablesPadlock.Lock;
            try
              Result := sdFolder.sfTableMakeUniqueName(nxcRestBaseName, TargetName);
              if Result <> DBIERR_NONE then
                Abort;
             Result := Database.sdTableBuild(False, TargetName, Password,
               aDictionary, SourceCursor.stcTable.sbtRoot.srtTableScope );
             if Result = DBIERR_NONE then try
               Result := Database.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
                 TargetName, Password, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
               if Result = DBIERR_NONE then try
                 aTaskInfo := TnxServerRestructureTaskInfo.Create(
                   TnxServerRestructureContainer.Create
                     (SourceCursor, TargetCursor, aMapperDesc));
               except
                 nxFreeAndNil(TargetCursor);
                 raise;
               end else
                 Abort;
             except
               sdTableDelete(TargetName, Password);
               raise;
             end else
               Abort;
            finally
              sdFolder.sfTablesPadlock.Unlock;
            end;
          except
            nxFreeAndNil(SourceCursor);
            raise;
          end else
            Abort;
        except
          nxFreeAndNil(Database);
          raise;
        end;
      end;
    except
      on E : EAbort do
        if Result = DBIERR_NONE then
          Result := Self.asoConvertException(E);
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTablesNeedingPackIterator(aDictionary : TnxDataDictionary;
                                                       aCookie     : Pointer)
                                                                   : TnxIteratorResult;
begin
  Result := irContinue;
  if aDictionary.RequiresPack then begin
    SetLength(PnxUnicodeStrings(aCookie)^, Succ(Length(PnxUnicodeStrings(aCookie)^)));
    PnxUnicodeStrings(aCookie)^[High(PnxUnicodeStrings(aCookie)^)] := aDictionary.BaseName;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.sdTableVerifyChecksum(const aTableName    : string;
                                                 const aPassword     : UnicodeString;
                                                       aRaw          : Boolean;
                                                       aForceRecheck : Boolean;
                                                   out aTaskInfo     : TnxAbstractTaskInfo)
                                                                     : TnxResult;
var
  RootTableName  : string;
  ChildTableName : string;

  Database       : TnxServerDatabase;
  SourceCursor   : TnxServerTableCursor;
begin
  nxStrSplit(aTableName, [':'], RootTableName, ChildTableName);
  if ChildTableName <> '' then
    Result := DBIERR_INVALIDPARAM
  else begin
    Result := DBIERR_NONE;
    aTaskInfo := nil;
    try
      Result := Self.NotifyExtenders(eaTableVerifyChecksum, True, [aTableName, @aRaw, @aForceRecheck]);
      if Result <> DBIERR_NONE then
        Exit;

      Result := TnxServerSession(asoSession).ssDatabaseOpen(
        TnxAbstractDatabase(Database), sdAlias, nil, sdFolder, sdOpenMode,
        sdShareMode, True, atoTimeout);
      if Result = DBIERR_NONE then try
        Database.sdTables := sdTables;

        Result := Database.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
          aTableName, aPassword, False, omReadOnly, smExclusive, False, atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then try
          if SourceCursor.stcTable.sbtRoot.srtMainFile.fiCheckSumSize > 0 then
            aTaskInfo := TnxServerVerifyChecksumTaskInfo.Create(SourceCursor, aRaw, aForceRecheck)
          else begin
            Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsTableSNoFileChecksum, [aTableName]);
            Abort;
          end;
        except
          nxFreeAndNil(SourceCursor);
          raise;
        end else
          Abort;
      except
        nxFreeAndNil(Database);
        raise;
      end;
    except
      on E : EAbort do
        if Result = DBIERR_NONE then
          Result := Self.asoConvertException(E);
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.StatementAlloc(out aStatement : TnxAbstractStatement;
                                              aTimeout   : TnxWord32)
                                                         : TnxResult;
  {$IFDEF NX_LITE}
var
  {$I Lite\nxLite7.inc}
  {$I Lite\nxLite9.inc}
  {$ELSE}
begin
  {$ENDIF}
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdStatementAlloc(aStatement, aTimeout);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.StatementExecDirect(aTimeout         : TnxWord32;
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
                                                                : TnxResult;
  {$IFDEF NX_LITE}
var
  {$I Lite\nxLite7.inc}
  {$I Lite\nxLite8.inc}
  {$ELSE}
begin
  {$ENDIF}
  nxSetTimeout(aTimeout);
  atoLock.Lock;
  try
    Result := sdStatementExecDirect(aTimeout, aStatementType, aQueryText,
      aPrepareStream, aParams, aSetParamsStream, aCursor, aOpenMode,
      aExecStream, aGetParamsStream, aPhase);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableAddField(const aTableName : string;
                                         const aPassword  : UnicodeString;
                                               aFieldDesc : TnxFieldDescriptor)
                                                          : TnxResult;
var
  Cursor     : TnxServerTableCursor;
  Table      : TnxServerRootTable;
  Folder     : TnxServerFolder;
  FolderLock : TnxPadlock;
  i          : Integer;
begin
  FolderLock := nil;
  Folder := nil;
  Table := nil;

  Result := nxCheckValidTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else try
        Result := sdCursorOpen(TnxAbstractCursor(Cursor), nil, aTableName, aPassword, False,
          omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then try
          Table := Cursor.stcTable.sbtRoot;
          if Table.srtTableScope > tsPersistent then
            Result := DBIERR_NOTSUPPORTED
          else begin
            Folder := Table.srtFolder;
            Folder.sfTablesPadlock.Lock;
            FolderLock := Folder.sfTablesPadlock;

            Result := sdFolder.NotifyExtenders(eaTableAddField, True, [aTableName, aFieldDesc, @Cursor.stcTable.sbtRoot.srtTableScope]);
            if Result = DBIERR_NONE then begin
              Result := Self.NotifyExtenders(eaTableAddField, True, [aTableName, aFieldDesc, @Cursor.stcTable.sbtRoot.srtTableScope]);
              if Result = DBIERR_NONE then begin
                Result := Cursor.stcAddField(aFieldDesc);
                if Result = DBIERR_NONE then
                  Self.NotifyExtenders(eaTableAddField, False, [aTableName, aFieldDesc, @Cursor.stcTable.sbtRoot.srtTableScope]);
              end;
              if Result = DBIERR_NONE then
                sdFolder.NotifyExtenders(eaTableAddField, False, [aTableName, aFieldDesc, @Cursor.stcTable.sbtRoot.srtTableScope]);
            end;
          end;
        finally
          nxFreeAndNil(Cursor);
        end;
      finally
        if Assigned(FolderLock) then begin
          i := Folder.sfTables.IndexOfObject(Table);
          if i >= 0 then
            Table.Free;
          FolderLock.Unlock;
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableAddIndex(const aTableName  : string;
                                         const aPassword   : UnicodeString;
                                               aIndexDesc  : TnxIndexDescriptor;
                                               aNewDefault : Boolean)
                                                           : TnxResult;
var
  Cursor    : TnxServerTableCursor;
begin
  Result := nxCheckValidTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := sdCursorOpen(TnxAbstractCursor(Cursor), nil, aTableName, aPassword, False,
          omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then try
          Result := sdFolder.NotifyExtenders(eaTableAddIndex, True, [aTableName, aIndexDesc, aNewDefault, @Cursor.stcTable.sbtRoot.srtTableScope]);
          if Result = DBIERR_NONE then begin
            Result := Self.NotifyExtenders(eaTableAddIndex, True, [aTableName, aIndexDesc, aNewDefault, @Cursor.stcTable.sbtRoot.srtTableScope]);
            if Result = DBIERR_NONE then begin
              Result := Cursor.stcAddIndex(aIndexDesc, aNewDefault);
              if Result = DBIERR_NONE then
                Self.NotifyExtenders(eaTableAddIndex, False, [aTableName, aIndexDesc, aNewDefault, @Cursor.stcTable.sbtRoot.srtTableScope]);
            end;
            if Result = DBIERR_NONE then
              sdFolder.NotifyExtenders(eaTableAddIndex, False, [aTableName, aIndexDesc, aNewDefault, @Cursor.stcTable.sbtRoot.srtTableScope]);
          end;
        finally
          nxFreeAndNil(Cursor);
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableAutoIncGet(const aTableName : string;
                                           const aPassword  : UnicodeString;
                                             out aValue     : TnxWord32)
                                                            : TnxResult;
var
  Cursor : TnxAbstractCursor;
begin
  Result := nxCheckValidTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sdCursorOpen(Cursor, nil, aTableName, aPassword, False, omReadOnly, smShared,
        False, atoTimeout, '', -1, False);
      if Result = DBIERR_NONE then try
        aValue := TnxServerBaseCursor(Cursor).sbcAutoIncGet;
      finally
        nxFreeAndNil(Cursor);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableBackup(const aTableName      : string;
                                       const aPassword       : UnicodeString;
                                             aTargetDatabase : TnxAbstractDataBase;
                                         out aTaskInfo       : TnxAbstractTaskInfo)
                                                             : TnxResult;
var
  SourceDatabase : TnxServerDatabase;
  SourceCursor   : TnxServerTableCursor;
  TargetDatabase : TnxServerDatabase;
  TargetCursor   : TnxServerTableCursor;
  Mapper         : TnxTableMapperDescriptor;
  Password       : UnicodeString;
  Dict           : TnxDataDictionary;
begin
  aTaskInfo := nil;

  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  if not nxPatchPPLPresent then begin
    Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsPatchPPLrequired);
    Exit;
  end;
  {$ENDIF}

  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  if not (aTargetDatabase is TnxServerDatabase) then begin
    Result := DBIERR_INVALIDPARAM;
    Exit;
  end;

  if aTargetDatabase.Session <> Session then begin
    Result := DBIERR_NOTSAMESESSION;
    Exit;
  end;

  if TnxServerDatabase(aTargetDatabase).sdFolder = sdFolder then begin
    Result := DBIERR_NX_SAMETABLE;
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      if TnxServerDatabase(aTargetDatabase).sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := Self.NotifyExtenders(eaTableBackup, True, [aTableName, aTargetDatabase]);
        if Result <> DBIERR_NONE then
          Abort;

        Result := TnxServerSession(asoSession).ssDatabaseOpen(
          TnxAbstractDatabase(SourceDatabase), sdAlias, Self.TransContext, sdFolder, sdOpenMode,
          sdShareMode, True, atoTimeout);
        if Result = DBIERR_NONE then try
          SourceDatabase.sdTables := sdTables;

          Result := SourceDatabase.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
            aTableName, aPassword, False, omReadOnly, smShared, False, atoTimeout, '', -1, False);
          if Result = DBIERR_NONE then try
            Password := SourceCursor.stcTable.sbtRoot.srtExtractPassword;

            with TnxServerDatabase(aTargetDatabase) do
              Result := TnxServerSession(asoSession).ssDatabaseOpen(
                TnxAbstractDatabase(TargetDatabase), sdAlias, nil, sdFolder, sdOpenMode,
                sdShareMode, True, atoTimeout);
            if Result = DBIERR_NONE then try
              TargetDatabase.sdFolder.sfTablesPadlock.Lock;
              try
                with SourceCursor.stcTable.sbtRoot do try
                  Dict := TnxDataDictionary.Create;
                  Dict.AssignOnlyFields(srtDictionary);
                  Dict.CheckValid(True);
                  Result := TargetDatabase.TableBuild(False, SourceCursor.RootName, Password,
                    Dict, srtTableScope);
                finally
                  nxFreeAndNil(Dict);
                end;
                if Result = DBIERR_NONE then try
                  Result := TargetDatabase.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
                    SourceCursor.RootName, Password, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
                  if Result = DBIERR_NONE then try
                    Mapper := TnxTableMapperDescriptor.Create;
                    try
                      Mapper.MapAllTablesAndFieldsByName(
                        SourceCursor.stcTable.sbtRoot.srtDictionary,
                        TargetCursor.stcTable.sbtRoot.srtDictionary);

                      aTaskInfo := TnxServerRestructureTaskInfo.Create(
                        TnxServerRestructureContainer.Create
                          (SourceCursor, TargetCursor, Mapper));
                    finally
                      FreeAndNil(Mapper);
                    end;
                  except
                    nxFreeAndNil(TargetCursor);
                    raise;
                  end else
                    Abort;
                except
                  TargetDatabase.sdTableDelete(SourceCursor.RootName, Password);
                  raise;
                end else
                  Abort;
              finally
                TargetDatabase.sdFolder.sfTablesPadlock.Unlock;
              end;
            except
              nxFreeAndNil(TargetDatabase);
              raise;
            end else
              Abort;
          except
            nxFreeAndNil(SourceCursor);
            raise;
          end else
            Abort;
        except
          nxFreeAndNil(SourceDatabase);
          raise;
        end;
      end;
    except
      on E : EAbort do
        if Result = DBIERR_NONE then
          Result := Self.asoConvertException(E);
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxServerRestructureTaskInfo(aTaskInfo));
      TnxServerRestructureTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableBuild(aOverWrite   : Boolean;
                                const aTableName   : string;
                                const aPassword    : UnicodeString;
                                      aDictionary  : TnxDataDictionary;
                                      aTableScope  : TnxTableScope;
                                      aAllowSystem : Boolean)
                                                   : TnxResult;
begin
  Result := nxCheckValidRootTableName(aTableName, False, aAllowSystem);
  if Result <> DBIERR_NONE then
    Exit;

  aDictionary.CheckValid(True);

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sdTableBuild(aOverWrite, aTableName, aPassword, aDictionary, aTableScope);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableChangePassword(const aTableName   : string;
                                               const aOldPassword : UnicodeString;
                                               const aNewPassword : UnicodeString)
                                                                  : TnxResult;
var
  Cursor : TnxAbstractCursor;
begin
  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sdCursorOpen(Cursor, nil, aTableName, aOldPassword, False, omReadWrite, smShared,
        False, atoTimeout, '', -1, False);
      if Result = DBIERR_NONE then try
        Result := (Cursor as TnxServerTableCursor).sbcChangePassword(aNewPassword);
      finally
        nxFreeAndNil(Cursor);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableDelete(const aTableName : string;
                                       const aPassword  : UnicodeString)
                                                        : TnxResult;
begin
  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableDelete(aTableName, aPassword);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableDropIndex(const aTableName : string;
                                          const aPassword  : UnicodeString;
                                          const aIndexName : string;
                                                aIndexID   : Integer)
                                                           : TnxResult;
var
  Cursor : TnxServerTableCursor;
begin
  Result := nxCheckValidTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  Result := nxCheckValidIdent(aIndexName, DBIERR_INVALIDINDEXNAME, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := sdCursorOpen(TnxAbstractCursor(Cursor), nil, aTableName, aPassword, False,
          omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then try
          Result := sdFolder.NotifyExtenders(eaTableDropIndex, True, [aTableName, aIndexName, aIndexID, @Cursor.stcTable.sbtRoot.srtTableScope]);
          if Result = DBIERR_NONE then begin
            Result := Self.NotifyExtenders(eaTableDropIndex, True, [aTableName, aIndexName, aIndexID, @Cursor.stcTable.sbtRoot.srtTableScope]);
            if Result = DBIERR_NONE then begin
              Result := Cursor.stcDropIndex(aIndexName, aIndexID);
              if Result = DBIERR_NONE then
                Self.NotifyExtenders(eaTableDropIndex, False, [aTableName, aIndexName, aIndexID]);
            end;
            if Result = DBIERR_NONE then
              sdFolder.NotifyExtenders(eaTableDropIndex, False, [aTableName, aIndexName, aIndexID]);
          end;
        finally
          nxFreeAndNil(Cursor);
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableEmpty(const aTableName : string;
                                      const aPassword  : UnicodeString)
                                                       : TnxResult;
var
  i         : Integer;
  OrgTable  : TnxServerRootTable;
  NewTable  : TnxServerRootTable;
  Passwords : TnxUnicodeStrings;
begin
  Passwords := sdBuildPasswords(aTableName, aPassword);

  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        with sdTables, Lock do try

          if Find(aTableName, i) then begin

            OrgTable := TnxServerRootTable(Objects[i]);
            with OrgTable do begin

              if DataPoliciesDenyEmpty(srtDictionary) then begin
                Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedDataPolicies);
                Exit;
              end;

              Result := Self.NotifyExtenders(eaTableEmpty, True, [aTableName, @srtTableScope]);
              if Result = DBIERR_NONE then
                if OrgTable.srtFileIsLink then
                  Result := DBIERR_TABLEREADONLY;

              if Result <> DBIERR_NONE then
                Exit;

              Result := srtAuthenticatePassword(Passwords);
              if Result = DBIERR_NONE then begin
                Result := DBIERR_TABLEOPEN;
                LockedInc(sbtLockIsInactive);
                if srtIsInactive(True, True, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    Result := sdFolder.sfTableBuildPrim
                      ('', srtExtractPassword, srtForServer, srtDictionary, srtTableScope , NewTable);
                    if Result = DBIERR_NONE then begin
                      NewTable.sbtNameInScope := aTableName;
                      NewTable.srtDictionary._BaseName := aTableName;

                      Free;
                      Objects[i] := NewTable;
                    end;
                  end;
                except
                  on E : Exception do
                    Self.asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);
              end;
            end;
          end else begin
            Result := Self.NotifyExtenders(eaTableEmpty, True, [aTableName]);
            if Result = DBIERR_NONE then
              Result := sdFolder.sfTableEmpty(aTableName, Passwords, False);
          end;

          if Result = DBIERR_NONE then
            Self.NotifyExtenders(eaTableEmpty, False, [aTableName]);
        finally
          Unlock;
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableExists(const aTableName   : string;
                                       const aPassword    : UnicodeString;
                                         out aExists      : Boolean;
                                             aAllowSystem : Boolean)
                                                          : TnxResult;
begin
  aExists := False;

  if aTableName = '' then begin
    Result := DBIERR_NONE;
    Exit;
  end;

  Result := nxCheckValidTableName(aTableName, True, aAllowSystem);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := Self.NotifyExtenders(eaTableExists, True, [aTableName, @aExists]);
      if Result = DBIERR_NONE then begin

        Result := sdTableExists(aTableName, aPassword, False);

        case Result of
          DBIERR_OBJNOTFOUND:
            Result := DBIERR_NONE;
          DBIERR_NONE:
            aExists := True;
        end;

        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaTableExists, False, [aTableName, @aExists]);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableGetDictionary(const aTableName  : string;
                                              const aPassword   : UnicodeString;
                                                    aDictionary : TnxDataDictionary)
                                                                : TnxResult;
begin
  Result := nxCheckValidRootTableName(aTableName, True);
  if Result = DBIERR_NONE then
    if not Assigned(aDictionary) then
      Result := DBIERR_INVALIDPARAM;
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sdTableGetDictionary(aTableName, aPassword, aDictionary);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableGetList(aList : TStrings)
                                              : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableGetList(aList, ExplicitAllowSystem);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TablePack(const aTableName : string;
                                     const aPassword  : UnicodeString;
                                       out aTaskInfo  : TnxAbstractTaskInfo)
                                                      : TnxResult;
var
  Database     : TnxServerDatabase;
  SourceCursor : TnxServerTableCursor;
  TargetCursor : TnxServerTableCursor;
  TargetName   : string;
  Mapper       : TnxTableMapperDescriptor;
  Password     : UnicodeString;
  Dict         : TnxDataDictionary;
begin
  aTaskInfo := nil;

  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  if not nxPatchPPLPresent then begin
    Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsPatchPPLrequired);
    Exit;
  end;
  {$ENDIF}

  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      if sdOpenMode = omReadOnly then
        Result := DBIERR_READONLYDB
      else begin
        Result := TnxServerSession(asoSession).ssDatabaseOpen(
          TnxAbstractDatabase(Database), sdAlias, nil, sdFolder, sdOpenMode,
          sdShareMode, True, atoTimeout);
        if Result = DBIERR_NONE then try
          Database.sdTables := sdTables;

          Result := Database.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
            aTableName, aPassword, False, omReadOnly, smExclusive, False, atoTimeout, '', -1, False);
          if Result = DBIERR_NONE then try
            Result := sdFolder.NotifyExtenders(eaTablePack, True, [aTableName, @SourceCursor.stcTable.sbtRoot.srtTableScope]);
            if Result <> DBIERR_NONE then
              Abort;
            Result := Self.NotifyExtenders(eaTablePack, True, [aTableName, @SourceCursor.stcTable.sbtRoot.srtTableScope]);
            if Result <> DBIERR_NONE then
              Abort;

            Password := SourceCursor.stcTable.sbtRoot.srtExtractPassword;

            if SourceCursor.stcTable.sbtRoot.srtFileIsLink then begin
              Result := DBIERR_TABLEREADONLY;
              Abort;
            end;

            sdFolder.sfTablesPadlock.Lock;
            try
              Result := sdFolder.sfTableMakeUniqueName(nxcPackBaseName, TargetName);
              if Result <> DBIERR_NONE then
                Abort;
             with SourceCursor.stcTable.sbtRoot do try
               Dict := TnxDataDictionary.Create;
               Dict.Assign(srtDictionary);
               Dict.CheckValid(True);
               Result := Database.sdTableBuild(False, TargetName, Password,
                 Dict, srtTableScope);
             finally
               nxFreeAndNil(Dict);
             end;
             if Result = DBIERR_NONE then try
               Result := Database.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
                 TargetName, Password, False, omReadWrite, smExclusive, False, atoTimeout, '', -1, False);
               if Result = DBIERR_NONE then try
                 Mapper := TnxTableMapperDescriptor.Create;
                 try
                   with SourceCursor.stcTable.sbtRoot do
                     Mapper.MapAllTablesAndFieldsByName(srtDictionary, srtDictionary);

                   aTaskInfo := TnxServerRestructureTaskInfo.Create(
                     TnxServerRestructureContainer.Create
                       (SourceCursor, TargetCursor, Mapper));
                 finally
                   FreeAndNil(Mapper);
                 end;
               except
                 nxFreeAndNil(TargetCursor);
                 raise;
               end else
                 Abort;
             except
               sdTableDelete(TargetName, Password);
               raise;
             end else
               Abort;
            finally
              sdFolder.sfTablesPadlock.Unlock;
            end;
          except
            nxFreeAndNil(SourceCursor);
            raise;
          end else
            Abort;
        except
          nxFreeAndNil(Database);
          raise;
        end;
      end;
    except
      on E : EAbort do
        if Result = DBIERR_NONE then
          Result := Self.asoConvertException(E);
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxServerRestructureTaskInfo(aTaskInfo));
      TnxServerRestructureTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableRebuildIndex(const aTableName : string;
                                             const aPassword  : UnicodeString;
                                             const aIndexName : string;
                                                   aIndexID   : Integer;
                                               out aTaskInfo  : TnxAbstractTaskInfo)
                                                              : TnxResult;
begin
  aTaskInfo := nil;

  Result := nxCheckValidTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  Result := nxCheckValidIdent(aIndexName, DBIERR_INVALIDINDEXNAME, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableRebuildIndex(aTableName, aPassword, aIndexName, aIndexID, aTaskInfo);
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxBaseServerRebuildIndexTaskInfo(aTaskInfo));
      TnxBaseServerRebuildIndexTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableRecover(const aTableName : string;
                                        const aPassword  : UnicodeString;
                                          out aTaskInfo  : TnxAbstractTaskInfo)
                                                         : TnxResult;
begin
  aTaskInfo := nil;

  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableRecover(aTableName, aPassword, aTaskInfo);
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxServerRecoverTaskInfo(aTaskInfo));
      TnxServerRecoverTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableRename(const aOldName  : string;
                                       const aNewName  : string;
                                       const aPassword : UnicodeString)
                                                       : TnxResult;
begin
  Result := nxCheckValidRootTableName(aOldName, True);
  if Result <> DBIERR_NONE then
    Exit;

  Result := nxCheckValidRootTableName(aNewName, False);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableRename(aOldName, aNewName, aPassword);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableRestructure(const aTableName   : string;
                                            const aPassword    : UnicodeString;
                                                  aDictionary  : TnxDataDictionary;
                                                  aMapperDesc  : TnxBaseTableMapperDescriptor;
                                            const aAllowSystem : Boolean;
                                              out aTaskInfo    : TnxAbstractTaskInfo)
                                                               : TnxResult;
begin
  aTaskInfo := nil;

  Result := nxCheckValidRootTableName(aTableName, True, aAllowSystem);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableRestructure(aTableName, aPassword, aDictionary, aMapperDesc, aTaskInfo);
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxServerRestructureTaskInfo(aTaskInfo));
      TnxServerRestructureTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabase.TableVerifyChecksum(const aTableName    : string;
                                               const aPassword     : UnicodeString;
                                                     aRaw          : Boolean;
                                                     aForceRecheck : Boolean;
                                                 out aTaskInfo     : TnxAbstractTaskInfo)
                                                                   : TnxResult;
begin
  aTaskInfo := nil;

  Result := nxCheckValidRootTableName(aTableName, True);
  if Result <> DBIERR_NONE then
    Exit;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sdTableVerifyChecksum(aTableName, aPassword, aRaw, aForceRecheck, aTaskInfo);
  finally
    atoLock.Unlock(Result);
  end;

  if Assigned(aTaskInfo) then try
    if Result = DBIERR_NONE then begin
      TnxServerTaskThread.Create(TnxServerVerifyChecksumTaskInfo(aTaskInfo));
      TnxServerVerifyChecksumTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    end else try
      nxFreeAndNil(aTaskInfo);
    except end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{==============================================================================}



{===TnxServerTransContext======================================================}
constructor TnxServerTransContext.Create(aSession : TnxAbstractSession;
                                         aTimeout : TnxWord32);
begin
  stcTransactionPadlock := TnxPadlock.Create(True);
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTransContext.Destroy;
begin
  inherited;
  nxFreeAndNil(stcTransactionPadlock);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransContext.Failed;
begin
  stcTransactionPadlock.Lock;
  try
    inherited;
    if Assigned(stcTransaction) then
      stcTransaction.Failed;
  finally
    stcTransactionPadlock.UnLock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionCommit: TnxResult;
begin
  try
    if Assigned(stcTransaction) then begin
      if stcTransaction.IsLocked then
        raise EnxServerEngineException.nxCreate(DBIERR_REENTERED, @rsTransactionIsInUse);

      if atcFailed then
        stcTransaction.MarkCorrupted;

      Result := stcTransaction.CheckState;
      if Result = DBIERR_NONE then begin
        Result := Self.NotifyExtenders(eaTransactionCommit, True, []);
        if Result = DBIERR_NONE then begin
          stcTransaction.Commit;
          Self.NotifyExtenders(eaTransactionCommit, False, []);
        end;
      end;
    end else
      Result := DBIERR_NOACTIVETRAN;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionInclude(aExclusive : Boolean;
                                               const aCursors   : array of TnxAbstractCursor)
                                                                : TnxResult;
var
  i : Integer;
begin
  if not Assigned(stcTransaction) then begin
    Result := DBIERR_NOACTIVETRAN;
    Exit;
  end;

  try
    for i:= Low(aCursors) to High(aCursors) do try
      if not (aCursors[i] is TnxServerBaseCursor) or
        ((aCursors[i] as TnxServerBaseCursor).CurrentTransContext <> Self) then begin
        Result := DBIERR_INVALIDHNDL;
        Exit;
      end;
    except
      Result := DBIERR_INVALIDHNDL;
      Exit;
    end;

    if atcFailed then
      stcTransaction.MarkCorrupted;

    Result := stcTransaction.CheckState;

    if Result = DBIERR_NONE then
      if aExclusive and (tsSnapshot in stcTransaction.State) then
        Result := DBIERR_TABLEREADONLY
      else try
        for i:= Low(aCursors) to High(aCursors) do begin
          if not (aCursors[i] is TnxServerTableCursor) then
            Result := DBIERR_INVALIDHNDL
          else
            with TnxServerTableCursor(aCursors[i]) do
              Result := sbcBeginContentLock(aExclusive, False);
          if Result <> DBIERR_NONE then
            Break;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionRollback: TnxResult;
begin
  Result := DBIERR_NONE;
  try
    if Assigned(stcTransaction) then begin
      if stcTransaction.IsLocked then
        raise EnxServerEngineException.nxCreate(DBIERR_REENTERED, @rsTransactionIsInUse);

      Self.NotifyExtenders(eaTransactionRollback, True, []);
      stcTransaction.Rollback;
      Self.NotifyExtenders(eaTransactionRollback, False, []);
    end else
      Result := DBIERR_NOACTIVETRAN;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionMarkCorrupted: TnxResult;
begin
  Result := DBIERR_NONE;
  try
    if Assigned(stcTransaction) then
      stcTransaction.MarkCorrupted
    else
      Result := DBIERR_NOACTIVETRAN;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTransContext.atcForceRollback;
begin
  inherited;

  stcTransactionPadlock.Lock;
  try
    while Assigned(stcTransaction) do
      stcTransaction.Rollback;
  finally
    stcTransactionPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionStart(aFailSafe              : Boolean;
                                                   aSnapShot              : Boolean;
                                                   aOverrideForceFailsafe : Boolean;
                                                   aNoMoreNested          : Boolean;
                                                   aForceNested           : Boolean;
                                                   aOverrideSecurity      : Boolean)
                                                                          : TnxResult;
begin
  try
    if Assigned(stcTransaction) then begin
      if atcFailed then
        stcTransaction.MarkCorrupted;

      Result := stcTransaction.CheckState;
      if Result = DBIERR_NONE then begin
        Result := Self.NotifyExtenders(eaTransactionStart, True, [aFailSafe, aSnapShot, stcTransaction, aForceNested, aOverrideSecurity]);
        if Result = DBIERR_NONE then begin
          stcTransaction.StartNested(aForceNested);
          Self.NotifyExtenders(eaTransactionStart, False, [aFailSafe, aSnapShot, stcTransaction, aForceNested, aOverrideSecurity]);
        end;
      end;
    end else begin
      if atcFailed then
        Result := DBIERR_NX_CorruptTrans
      else begin
        Result := Self.NotifyExtenders(eaTransactionStart, True, [aFailSafe, aSnapShot, nil, aForceNested, aOverrideSecurity]);
        if Result = DBIERR_NONE then begin
          stcTransactionPadlock.Lock;
          try
            if atcFailed then
              Result := DBIERR_NX_CorruptTrans
            else
              stcTransaction := TnxServerTransContextOwnedTransaction.
                Create(Self, aSnapShot, aFailSafe, aOverrideForceFailsafe);
          finally
            stcTransactionPadlock.Unlock;
          end;
          Self.NotifyExtenders(eaTransactionStart, False, [aFailSafe, aSnapShot, stcTransaction, aForceNested, aOverrideSecurity]);
        end;
      end;
    end;
    if (Result = DBIERR_NONE) and aNoMoreNested then
      stcTransaction.MarkNoMoreNested;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.stcTransactionStartWith(aFailSafe              : Boolean;
                                                       aSnapShot              : Boolean;
                                                 const aCursors               : array of TnxAbstractCursor;
                                                       aOverrideForceFailsafe : Boolean;
                                                       aNoMoreNested          : Boolean;
                                                       aForceNested           : Boolean;
                                                       aOverrideSecurity      : Boolean)
                                                                              : TnxResult;
var
  i : Integer;
begin
  try
    for i:= Low(aCursors) to High(aCursors) do try
      if not (aCursors[i] is TnxServerBaseCursor) or
        ((aCursors[i] as TnxServerBaseCursor).CurrentTransContext <> Self) then begin
        Result := DBIERR_INVALIDHNDL;
        Exit;
      end;
    except
      Result := DBIERR_INVALIDHNDL;
      Exit;
    end;

    if Assigned(stcTransaction) then begin
      if atcFailed then
        stcTransaction.MarkCorrupted;

      Result := stcTransaction.CheckState;
      if Result = DBIERR_NONE then begin
        Result := Self.NotifyExtenders(eaTransactionStart, True, [aFailSafe, aSnapShot, stcTransaction, aForceNested, aOverrideSecurity]);
        if Result = DBIERR_NONE then
          stcTransaction.StartNested(aForceNested);
      end;
    end else begin
      if atcFailed then
        Result := DBIERR_NX_CorruptTrans
      else begin
        Result := Self.NotifyExtenders(eaTransactionStart, True, [aFailSafe, aSnapShot, nil, aForceNested, aOverrideSecurity]);
        if Result = DBIERR_NONE then begin
          stcTransactionPadlock.Lock;
          try
            if atcFailed then
              Result := DBIERR_NX_CorruptTrans
            else
              stcTransaction := TnxServerTransContextOwnedTransaction.
                Create(Self, aSnapShot, aFailSafe, aOverrideForceFailsafe);
          finally
            stcTransactionPadlock.Unlock;
          end;
        end;
      end;
    end;

    if Result = DBIERR_NONE then begin
      try
        for i:= Low(aCursors) to High(aCursors) do begin
          if not (aCursors[i] is TnxServerTableCursor) then
            Result := DBIERR_INVALIDHNDL
          else
            with TnxServerTableCursor(aCursors[i]) do
              Result := sbcBeginContentLock(not aSnapShot, False);
          if Result <> DBIERR_NONE then
            Break;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        stcTransaction.Rollback
      else
        Self.NotifyExtenders(eaTransactionStart, False, [aFailSafe, aSnapShot, stcTransaction, aForceNested, aOverrideSecurity]);
    end;

    if (Result = DBIERR_NONE) and aNoMoreNested then
      stcTransaction.MarkNoMoreNested;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionCommit: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := stcTransactionCommit;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionCorrupted: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := stcTransactionMarkCorrupted;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionGetInfo(out aTransInfo   : TnxTransactionInfo;
                                                      aAllowCached : Boolean = True)
                                                                   : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      if Assigned(stcTransaction) then begin
        aTransInfo := stcTransaction.stGetInfo;
      end else begin
        Result := DBIERR_NOACTIVETRAN;
        aTransInfo.tiLevels := nil;
        FillChar(aTransInfo, SizeOf(aTransInfo), 0);
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionGetLevel(out aTransLevel : Integer)
                                                               : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      if Assigned(stcTransaction) then
        aTransLevel := stcTransaction.TransLevel.Level
      else
        Result := DBIERR_NOACTIVETRAN;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionInclude(aExclusive : Boolean;
                                            const aCursors   : array of TnxAbstractCursor)
                                                             : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := stcTransactionInclude(aExclusive, aCursors);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionRollback: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := stcTransactionRollback;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionStart(aFailSafe : Boolean;
                                                aSnapShot : Boolean)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := stcTransactionStart(aFailSafe, aSnapShot, False, False, False, False);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTransContext.TransactionStartWith(aFailSafe : Boolean;
                                                    aSnapShot : Boolean;
                                              const aCursors  : array of TnxAbstractCursor)
                                                              : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := stcTransactionStartWith(aFailSafe, aSnapShot, aCursors, False, False, False, False);
  finally
    atoLock.Unlock(Result);
  end;
end;
{==============================================================================}



{===TnxServerBaseTable=========================================================}
procedure TnxServerBaseTable.AfterConstruction;
begin
  inherited;
  LockedInc(TnxServerEngine(asoGetServerEngine).seTableCount);
  Include(sbtStates, stsLockedIncDone);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.asoGetServerEngine: TnxBaseServerEngine;
begin
  Result := sbtRoot.asoGetServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.BeforeDestruction;
begin
  asoDestroying := True;
  if Assigned(asoDestroyFlag) then
    asoDestroyFlag^ := True;
  if stsLockedIncDone in sbtStates then
    LockedDec(TnxServerEngine(asoGetServerEngine).seTableCount);
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxServerBaseTable.Create(aParent          : TnxExtendableServerObject;
                                const aName            : string;
                                      aTableDescriptor : TnxBaseTableDescriptor);
begin
  sbtChildNames := TStringList.Create;
  sbtChildNames.Sorted := True;
  sbtChildNames.Duplicates := dupError;

  if aParent is TnxServerBaseTable then
    sbtParent := TnxServerBaseTable(aParent);
  sbtTableDescriptor := aTableDescriptor;
  if Assigned(sbtParent) then
    sbtRoot := sbtParent.sbtRoot;

  sbtCursorsPadlock := TnxPadlock.Create(True);

  sbtLocks := TnxTableLockContainer.Create;

  sbtNameInScope := aName;

  sbtFieldsDescriptor := sbtTableDescriptor.FieldsDescriptor;

  inherited Create(aParent);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.CreateInstanceFor(const aName        : string;
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
  if SameText(Left, '<Table>') then
    Result := CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else if SameText(Left, '<Root>') then
    Result := sbtRoot.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxServerBaseTable.Destroy;
begin
  Assert(sbtLockIsInactive = 0);

  inherited;

  while Assigned(sbtCursorsTail) do
    sbtCursorsTail.Free;

  nxFreeAndNil(sbtCursorsPadlock);

  nxFreeAndNil(sbtLocks);

  nxFreeAndNil(sbtChildNames);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.FullName: string;
begin
  if Assigned(sbtParent) then
    Result := sbtParent.FullName + ':' + sbtNameInScope
  else
    Result := sbtNameInScope;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.GetChild(const aChildName : string;
                                       out aTable     : TnxServerBaseTable)
                                                      : TnxResult;
var
  LocalName : string;
  ChildName : string;
  Index     : Integer;
begin
  if aChildName = '' then begin
    aTable := Self;
    Result := DBIERR_NONE;
  end else begin
    nxStrSplit(aChildName, [':'], LocalName, ChildName);

    if LocalName = '.' then
      Result := GetChild(ChildName, aTable)
    else if LocalName = '..' then begin
      if Assigned(sbtParent) then
        Result := sbtParent.GetChild(ChildName, aTable)
      else
        Result := EnxBaseException.nxSetMessage(DBIERR_NOSUCHTABLE,
          nxcOrgMessageMarker + ' No parent for table "' + sbtRoot.FullName + '"');
    end else
      if sbtChildNames.Find(LocalName, Index) then
        Result := TnxServerBaseTable(sbtChildNames.Objects[Index]).
          GetChild(ChildName, aTable)
      else begin
        Result := EnxBaseException.nxSetMessage(DBIERR_NOSUCHTABLE,
          nxcOrgMessageMarker + ' No child table called "'+LocalName+'" in table "' + FullName + '"');
        aTable := nil;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  i            : Integer;
  stc          : TnxServerTableCursor;
  stcContainer : InxExceptionDataContainer;
  sbt          : TnxServerBaseTable;
  sbtContainer : InxExceptionDataContainer;
begin
  inherited;
  aContainer.AddValue('FullName', FullName);
  if sbtRoot <> Self then
    aContainer.AddValue('Root', sbtRoot);

  sbtCursorsPadlock.Lock;
  try
    aContainer.AddValue('OpenCursors', DoubleLinkedListCountStrings[Assigned(sbtCursorsHead), sbtCursorsHead = sbtCursorsTail]);
    if aIncludeChildren then begin
      stcContainer := aContainer.AddContainer('Cursors');
      stc := sbtCursorsHead;
      if Assigned(stc) then begin
        i := 0;
        while Assigned(stc) do begin
          stcContainer.AddValue('[' + IntToStr(i) + ']', stc, True);
          Inc(i);
          stc := stc.stcTableNext;
        end;
      end;
    end;
    sbtLocks.GetExceptionData(aContainer.AddContainer('Locks'));
  finally
    sbtCursorsPadlock.Unlock;
  end;

  if aIncludeChildren then begin
    sbtContainer := aContainer.AddContainer('Children');
    for i := Low(sbtChildren) to High(sbtChildren) do begin
      sbt := sbtChildren[i];
      sbtContainer.AddValue('[' + IntToStr(i) + ']', sbt, True);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtEnginesRollback(aTrans : TnxBaseTransaction);
var
  i: Integer;
begin
  if Assigned(sbtBlobEngine) then
    sbtBlobEngine.Rollback(aTrans);
  if Assigned(sbtRecordEngine) then
    sbtRecordEngine.Rollback(aTrans);
  for i := Low(sbtChildren) to High(sbtChildren) do
    sbtChildren[i].sbtEnginesRollback(aTrans);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtGetIsCache: Boolean;
begin
  Result := sbtTableDescriptor.CachingState = tcsIsCache;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtGetStats(aTrans : TnxBaseTransaction)
                                               : TnxServerTableStats;
var
  CurrentCursor   : TnxServerTableCursor;
  CurrentDatabase : TnxAbstractDatabase;
  CurrentSession  : TnxAbstractSession;

  Databases       : TnxSortedList;
  Sessions        : TnxSortedList;

  i               : Integer;
begin
  Finalize(Result);
  FillChar(Result, SizeOf(Result), 0);
  with Result do begin
    with sbtBlockAccess[0].HeaderAccess(aTrans, False) do try
      stsUsedBlocks := UsedBlocks;
      stsAvailableBlocks := AvailableBlocks;
      stsHeaderSignature := PnxBlockCommonHeader(Header)^.bchSignature;
    finally
      Free;
    end;
    with sbtRoot.srtFiles[0] do begin
      stsMainFileName := FileName;
      stsMainFileSize := FileSize;
      stsFileVersion := fiNexusVersion;
    end;

    Databases := TnxSortedList.Create(sbtCursorCount);
    Sessions := TnxSortedList.Create(sbtCursorCount);
    try
      sbtCursorsPadlock.Lock;
      try
        CurrentCursor := sbtCursorsHead;
        while Assigned(CurrentCursor) do begin
          Inc(stsOpenCursors);
          CurrentDatabase := CurrentCursor.acDatabase;
          if not Databases.Find(CurrentDatabase, i) then begin
            Databases.Add(CurrentDatabase);
            Inc(stsOpenByDatabases);
            CurrentSession := CurrentDatabase.Session;
            if not Sessions.Find(CurrentSession, i) then begin
              Sessions.Add(CurrentSession);
              Inc(stsOpenBySessions);
            end;
          end;
          CurrentCursor := CurrentCursor.stcTableNext;
        end;
      finally
        sbtCursorsPadlock.Unlock;
      end;
    finally
      Databases.Free;
      Sessions.Free;
    end;
    sbtRoot.srtStreamEngine.GetNamedStreamCount(aTrans, stsNamedStreamCount);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtCreateBlockAccess;
var
  i, j     : Integer;
  ID       : TnxInt32;
  BaseName : string;
begin
  if sbtTableDescriptor is TnxDataDictionary then
    ID := 0
  else
    ID := sbtTableDescriptor.ID;

  BaseName := FullName;

  j := Length(sbtBlockAccess);
  SetLength(sbtBlockAccess, Length(sbtRoot.srtFiles));
  for i := j to High(sbtBlockAccess) do
    sbtBlockAccess[i] := TnxBlockAccess.Create(sbtRoot.srtFiles[i],
      sbtRoot.sbtBlockAccess[i], BaseName, ID);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtCreateChildren(aTrans: TnxBaseTransaction);
var
  i            : Integer;
begin
  with sbtTableDescriptor.TablesDescriptor do begin
    if TableCount < 1 then
      Exit;

    SetLength(sbtChildren, TableCount);

    for i := 0 to Pred(TableCount) do begin
      sbtChildren[i] := TnxServerBaseTable.Create(Self,
        TableDescriptor[i].Name, TableDescriptor[i]);

      sbtChildNames.AddObject(TableDescriptor[i].Name, sbtChildren[i]);

      sbtChildren[i].sbtInitFromDescriptor(TableDescriptor[i]);
      sbtChildren[i].sbtCreateBlockAccess;
      sbtChildren[i].sbtCreateEngines(aTrans);
      sbtChildren[i].sbtCreateChildren(aTrans);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtCreateEngines(aTrans: TnxBaseTransaction);
begin
  sbtBlobEngine := TnxBaseBlobEngine.CreateEngine
    (sbtTableDescriptor, sbtBlockAccess, aTrans);

  sbtRecordEngine := TnxBaseRecordEngine.CreateEngine
    (sbtTableDescriptor, sbtBlockAccess, aTrans);

  sbtAutoIncEngine :=
   TnxBaseAutoIncEngine.CreateEngine
    (sbtTableDescriptor, sbtBlockAccess, aTrans);

  if not sbtForRecover then begin
    sbtIndicesEngine := TnxBaseIndicesEngine.CreateEngine
      (sbtTableDescriptor, sbtBlockAccess, sbtRecordEngine, aTrans);

    sbtInternalIndicesEngine := TnxBaseIndicesEngine.CreateEngine
      (sbtTableDescriptor.InternalIndicesDescriptor, sbtBlockAccess, sbtRecordEngine, aTrans);

    sbtFulltextEngine := TnxBaseFulltextTableEngine.CreateFor
      (sbtTableDescriptor, sbtBlockAccess, sbtIndicesEngine, aTrans);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtCurrentLSN(aTrans: TnxBaseTransaction): TnxLSN;
begin
  Result := sbtBlockAccess[0].CurrentLSN[aTrans];
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtDestroyBlockAccess;
var
  i: Integer;
begin
  for i := Low(sbtBlockAccess) to High(sbtBlockAccess) do
    nxFreeAndNil(sbtBlockAccess[i]);
  sbtBlockAccess := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtDestroyChildren;
var
  i: Integer;
begin
  for i := Low(sbtChildren) to High(sbtChildren) do
    if Assigned(sbtChildren[i]) then begin
      sbtChildren[i].sbtDestroyChildren;
      sbtChildren[i].sbtDestroyEngines;
      sbtChildren[i].sbtDestroyBlockAccess;

      nxFreeAndNil(sbtChildren[i]);
    end;
  sbtChildren := nil;
  if Assigned(sbtChildNames) then
    sbtChildNames.Clear;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtDestroyEngines;
begin
  nxFreeAndNil(sbtFulltextEngine);
  nxFreeAndNil(sbtBlobEngine);
  nxFreeAndNil(sbtRecordEngine);
  nxFreeAndNil(sbtAutoIncEngine);
  nxFreeAndNil(sbtIndicesEngine);
  nxFreeAndNil(sbtInternalIndicesEngine);
  sfiFree(sbtSFI);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtInitFromDescriptor(aTableDescriptor: TnxBaseTableDescriptor);
var
  lDataPolicies: TnxDataPoliciesDescriptor;
begin
  sbtForRecover := sbtForRecover or _ForRecover;

  sbtTableDescriptor := aTableDescriptor;
  sbtFieldsDescriptor := sbtTableDescriptor.FieldsDescriptor;
  sbtRecordAllocator := nxGetPool(sbtFieldsDescriptor.RecordLength + SizeOf(Pointer));
  sbtFieldsDescriptor.GetSpecialFieldsInfo(sbtSFI);
  lDataPolicies := GetDataPoliciesDescriptor(sbtTableDescriptor);
  if not sbtForRecover and Assigned(lDataPolicies) then begin
    sbtDenyRecordOperations  := lDataPolicies.DenyRecordOperations;
    sbtMinRecordCount        := lDataPolicies.MinRecordCount;
    sbtMaxRecordCount        := lDataPolicies.MaxRecordCount;
  end else begin
    sbtDenyRecordOperations := [];
    sbtMinRecordCount       := 0;
    sbtMaxRecordCount       := High(TnxWord32);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtIsInactive(aIgnoreKeepInMemory : Boolean;
                                          aRequestClose       : Boolean;
                                          aExpectedLockCount  : Integer = 0)
                                                              : Boolean;
var
  Cursor    : TnxAbstractCursor;
  i         : Integer;
begin
  Result := False;
  Cursor := sbtCursorsHead;
  if Assigned(sbtCursorsHead) then begin
    sbtCursorsPadlock.Lock;
    try
      while Assigned(sbtCursorsHead) do begin
        if aRequestClose then
          sbtCursorsHead.sbcRequestClose;
        if Cursor = sbtCursorsHead then
          Exit;
        sbtCursorsPadlock.Unlock;
        sbtCursorsPadlock.Lock;
        Cursor := sbtCursorsHead;
      end;
    finally
      sbtCursorsPadlock.Unlock;
    end;
  end;
  Result := True;
  for i := Low(sbtChildren) to High(sbtChildren) do begin
    Result := sbtChildren[i].sbtIsInactive
      (aIgnoreKeepInMemory, aRequestClose, aExpectedLockCount);
    if not Result then
      Exit;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtLocksEndTransaction(aTrans : TnxBaseTransaction);
var
  i: Integer;
begin
  sbtLocks.EndTransaction(aTrans);
  for i := Low(sbtChildren) to High(sbtChildren) do
    sbtChildren[i].sbtLocksEndTransaction(aTrans);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtLSNInit(aCursor       : TnxAbstractCursor;
                                        aRecordBuffer : PnxRecordBuffer);
var
  LSN    : TnxLSN;
begin
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     ((sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0)) and
     Assigned(aRecordBuffer)
  then begin
    if not aCursor.GetNextLSN(LSN) then
      LSN := 1;
    if sbtSFI.sfiFields[sftModifyLSN] >= 0 then
      sbtFieldsDescriptor.SetRecordField(sbtSFI.sfiFields[sftModifyLSN], aRecordBuffer, @LSN);
    if sbtSFI.sfiFields[sftInsertLSN] >= 0 then
      sbtFieldsDescriptor.SetRecordField(sbtSFI.sfiFields[sftInsertLSN], aRecordBuffer, @LSN);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtLSNUpdate(aCursor         : TnxAbstractCursor;
                                         aOldBuffer      : PnxRecordBuffer;
                                         aNewBuffer      : PnxRecordBuffer;
                                         aModifyOnInsert : Boolean = False)
                                                         : TnxResult;

  function CheckLSNField(aField: Integer; aDoInc: Boolean): TnxResult;
  var
    IsNull : Boolean;
    OldLSN : TnxLSN;
    NewLSN : TnxLSN;
  begin
    Result := DBIERR_NONE;
    if aField >= 0 then begin
      sbtFieldsDescriptor.GetRecordField(aField, aOldBuffer, IsNull, @OldLSN);
      if IsNull then
        OldLSN := 0;

      if aModifyOnInsert then
        NewLSN := OldLSN
      else begin
        sbtFieldsDescriptor.GetRecordField(aField, aNewBuffer, IsNull, @NewLSN);
        if IsNull then
          NewLSN := 0;
      end;

      if {$IFNDEF NX_ALLOW_LSN_UPDATE}OldLSN <> NewLSN{$ELSE}False{$ENDIF} then
        Result := DBIERR_OPTRECLOCKFAILED
      else if aDoInc then begin
        if not aCursor.GetNextLSN(NewLSN) then
          {$IFOPT Q+}{$DEFINE OVERFLOWCHECKON}{$ELSE}{$UNDEF OVERFLOWCHECKON}{$ENDIF}{$Q-}
          Inc(NewLSN);
          {$IFDEF OVERFLOWCHECKON}{$Q+}{$ENDIF}
        sbtFieldsDescriptor.SetRecordField(aField, aNewBuffer, @NewLSN);
      end;
    end;
  end;

begin
  Result := DBIERR_NONE;
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     Assigned(aOldBuffer) and
     Assigned(aNewBuffer)
  then begin
    Result := CheckLSNField(sbtSFI.sfiFields[sftModifyLSN], True);
    if Result = DBIERR_NONE then
      Result := CheckLSNField(sbtSFI.sfiFields[sftInsertLSN], False);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtRecRevInit(aRecordBuffer: PnxRecordBuffer);
var
  IsNull : Boolean;
  RecRev : TnxWord32;
begin
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     (sbtSFI.sfiFields[sftRecRev] >= 0) and
     Assigned(aRecordBuffer)
  then begin
    sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftRecRev], aRecordBuffer, IsNull, @RecRev);
    if IsNull then begin
      RecRev := 0;
      sbtFieldsDescriptor.SetRecordField(sbtSFI.sfiFields[sftRecRev], aRecordBuffer, @RecRev);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtRecRevUpdate(aOldBuffer      : PnxRecordBuffer;
                                            aNewBuffer      : PnxRecordBuffer;
                                            aModifyOnInsert : Boolean)
                                                            : TnxResult;
var
  IsNull    : Boolean;
  OldRecRev : TnxWord32;
  NewRecRev : TnxWord32;
begin
  Result := DBIERR_NONE;
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     (sbtSFI.sfiFields[sftRecRev] >= 0) and
     Assigned(aOldBuffer) and
     Assigned(aNewBuffer)
  then begin
    sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftRecRev], aOldBuffer, IsNull, @OldRecRev);
    if IsNull then
      OldRecRev := 0;

    if aModifyOnInsert then
      NewRecRev := OldRecRev
    else begin
      sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftRecRev], aNewBuffer, IsNull, @NewRecRev);
      if IsNull then
        NewRecRev := 0;
    end;

    if {$IFNDEF NX_ALLOW_RECREV_UPDATE}OldRecRev <> NewRecRev{$ELSE}False{$ENDIF} then
      Result := DBIERR_OPTRECLOCKFAILED
    else begin
      {$IFOPT Q+}
        {$DEFINE QWasOn}
      {$ENDIF}
      {$Q-}
      Inc(NewRecRev);
      {$IFDEF QWasOn}
        {$UNDEF QWasOn}
        {$Q+}
      {$ENDIF}
      sbtFieldsDescriptor.SetRecordField(sbtSFI.sfiFields[sftRecRev], aNewBuffer, @NewRecRev);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseTable.sbtRefNrInit(aRecordBuffer: PnxRecordBuffer);
begin
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     (sbtSFI.sfiFields[sftRefNr] >= 0) and
     Assigned(aRecordBuffer)
  then
    sbtFieldsDescriptor.SetRecordFieldNull(sbtSFI.sfiFields[sftRefNr], aRecordBuffer, True);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseTable.sbtRefNrUpdate(aOldBuffer      : PnxRecordBuffer;
                                           aNewBuffer      : PnxRecordBuffer;
                                           aRefNr          : TnxRefNr;
                                           aModifyOnInsert : Boolean)
                                                           : TnxResult;
var
  IsNull         : Boolean;
  OldRefNr       : TnxRefNr;
  NewRefNr       : TnxRefNr;
  NewRefNrActual : TnxInt64;

  function SetErrorMessage: TnxResult;
  begin
    Result := EnxBaseException.nxSetMessage(DBIERR_INVALIDMODIFYREQUEST,
      @rsDBIERR_INVALIDMODIFYREQUESTRefNrChanged,
      [OldRefNr, NewRefNr]
    );
  end;

begin
  Result := DBIERR_NONE;
  if (sbtTableDescriptor.CachingState <> tcsIsCache) and
     (sbtSFI.sfiFields[sftRefNr] >= 0) and
     Assigned(aOldBuffer) and
     Assigned(aNewBuffer)
  then begin
    sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftRefNr], aOldBuffer, IsNull, @OldRefNr);
    if IsNull then
      OldRefNr := aRefNr;

    sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftRefNr], aNewBuffer, IsNull, @NewRefNr);
    if IsNull or aModifyOnInsert then begin
      NewRefNr := aRefNr;
      NewRefNrActual := -1;
    end else
      NewRefNrActual := NewRefNr;

    if not aModifyOnInsert and ({$IFNDEF NX_ALLOW_REFNR_UPDATE}OldRefNr <> NewRefNr{$ELSE}False{$ENDIF}) then
      Result := SetErrorMessage
    else
      if NewRefNrActual <> NewRefNr then
        sbtFieldsDescriptor.SetRecordField(sbtSFI.sfiFields[sftRefNr], aNewBuffer, @NewRefNr);
  end;
end;
{==============================================================================}



{===TnxServerRootTable=========================================================}
var
  ResultSetCounter: Integer;
{------------------------------------------------------------------------------}
function TnxServerRootTable.asoGetServerEngine: TnxBaseServerEngine;
begin
  Result := srtFolder.sfServerEngine;
end;
{------------------------------------------------------------------------------}
constructor TnxServerRootTable.Create(aFolder    : TnxServerFolder;
                                const aName      : string;
                                      aOpenMode  : TnxOpenMode;
                                      aShareMode : TnxShareMode;
                                      aTableScope: TnxTableScope);
begin
  sbtRoot := Self;
  srtTableScope  := aTableScope;

  srtCommitPadlock := TnxPadlock.Create;
  srtContentPortal := TnxReadWritePortal.Create;

  srtTransLinksPadlock := TnxPadlock.Create(True);

  srtFolder := aFolder;
  if aName = '' then
    srtName := ' UnnamedTable_' + IntToStr(Int64(TnxNativeUInt(Self))) + '_' + IntToStr(LockedInc(ResultSetCounter))
  else
    srtName := aName;

  srtOpenMode := aOpenMode;
  srtShareMode := aShareMode;

  srtDictionary := TnxServerDataDict.Create;

  srtAddToFolder;
  inherited Create(aFolder, srtName, srtDictionary);
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.CreateInstanceFor(const aName        : string;
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
  if SameText(Left, '<Folder>') then
    Result := srtFolder.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
destructor TnxServerRootTable.Destroy;
begin
  srtRemoveFromFolder;
  srtServerEngineRemoveFromInactiveTables;

  inherited;

  srtCloseFiles;

  nxFreeAndNil(srtDictionary);

  nxFreeAndNil(srtTransLinksPadlock);

  nxFreeAndNil(srtContentPortal);
  nxFreeAndNil(srtCommitPadlock);
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.FullName: string;
begin
  Result := inherited FullName;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('Folder', srtFolder);
  aContainer.AddValue('ForServer', srtForServer);
  aContainer.AddValue('TableScope', GetEnumName(TypeInfo(TnxTableScope), Ord(srtTableScope)));
  aContainer.AddValue('OpenMode', GetEnumName(TypeInfo(TnxOpenMode), Ord(srtOpenMode)));
  aContainer.AddValue('ShareMode', GetEnumName(TypeInfo(TnxShareMode), Ord(srtShareMode)));
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtAddToFolder;
begin
  with srtFolder do begin
    sfTablesPadlock.Lock;
    try
      sfTables.AddObject(srtName, Self);
      if srtTableScope <> tsPersistent then
        LockedInc(sfInMemoryCount);
    finally
      sfTablesPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtAuthenticatePassword(aPasswords : TnxUnicodeStrings)
                                                               : TnxResult;
begin
  //!!!! check for multi file support
  if Assigned(srtFiles[0].fiEncryptionEngine) then
    Result := srtFiles[0].fiEncryptionEngine.AuthenticatePassword(aPasswords)
  else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtBeginCommit(aTransaction: TnxServerTransaction);
begin
  srtCommitPadlock.Lock;
  srtContentPortal.BeginWrite;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtBuildFiles(aTrans      : TnxBaseTransaction;
                                          aPasswords  : TnxUnicodeStrings;
                                          aForServer  : Boolean;
                                          aDictionary : TnxDataDictionary;
                                          aAttribs    : TnxFileAttributes;
                                          aStore      : TnxBaseTempStorage;
                                          aTableName  : string)
                                                      : TnxResult;
var
  i        : integer;
begin
  Result := srtCloseFiles;
  if Result = DBIERR_NONE then try
    srtForServer := aForServer;

    SetLength(srtFiles, aDictionary.FilesDescriptor.FileCount);
    srtFiles[0] := TnxBaseFile.Alloc(True, ChangeFileExt(
      nxMakeFullFileName(srtFolder.sfPath, srtName), '.' + srtFolder.sfServerEngine.seTableExtension),
      srtFolder.sfServerEngine.seBufferManager);

    srtMainFile := srtFiles[0];

    srtDictionary.ForceOffReadOnly;
    srtDictionary.Assign(aDictionary);

    if (Length(aPasswords) > 0) and (srtDictionary.EncryptionEngine = '') then begin
      if TnxBaseEncryptionEngine.HasEngine('nxsAesCcm256', aForServer) then
        srtDictionary.EncryptionEngine := 'nxsAesCcm256'
      else if TnxBaseEncryptionEngine.HasEngine('nxsAesCcm128', aForServer) then
        srtDictionary.EncryptionEngine := 'nxsAesCcm128'
      else if TnxBaseEncryptionEngine.HasEngine(nx1xDefault, aForServer) then
        srtDictionary.EncryptionEngine := nx1xDefault;
    end;

    srtDictionary.CheckValid(True);
    srtDictionary.CheckValid(True);
    srtDictionary.IncID;

    with srtDictionary.FieldsDescriptor do
      OriginalFieldCount := FieldCount;

    with TnxBaseFile(srtMainFile) do begin
      fiSnapshotBlockCount := @srtSnapshotBlockCount;
      fiAttributes := aAttribs;
      fiForServer := aForServer;
      fiEncryptionEngineName := srtDictionary.EncryptionEngine;
      fiStreamEngineName := srtDictionary.StreamDescriptor.StreamEngine;
      fiTempStore := aStore;
      fiInitialSize := srtDictionary.FilesDescriptor.FileDescriptor[0].InitialSize;
      fiGrowSize := srtDictionary.FilesDescriptor.FileDescriptor[0].GrowSize;
      fiMaxID := srtDictionary.CurrentID;
      fiLogTable := aTableName;
    end;

    for i := 0 to Pred(srtDictionary.FilesDescriptor.FileCount) do begin
      Result := srtCreateFile(i, aTrans, aPasswords, aForServer, aAttribs, aStore);
      if Result <> DBIERR_NONE then
        Break;
      NotifyExtenders(eaReplicatedFileInit, False, [srtFiles[i]]);
    end;

    if Result = DBIERR_NONE then
      for i := 0 to Pred(srtDictionary.FilesDescriptor.FileCount) do
        srtDictionary.FilesDescriptor.FileDescriptor[i].FileID := srtFiles[i].GetFileID;

    if Result = DBIERR_NONE then begin
      sbtCreateBlockAccess;

      srtStreamEngine := TnxBaseStreamEngine.CreateEngine(srtDictionary, sbtBlockAccess[0], aTrans);
      srtDictionary.WriteToFile(srtStreamEngine, aTrans, nxVersionNumber);

      sbtInitFromDescriptor(srtDictionary);
      sbtCreateEngines(aTrans);
      sbtCreateChildren(aTrans);

      if aTableName <> '' then
        with TnxMemoryStream.Create do try
          with TnxWriter.Create(TheStream) do try
            WriteString(aTableName);
          finally
            Free;
          end;
          srtStreamEngine.WriteNamedStream(aTrans, '$TableName', TheStream);
        finally
          Free;
        end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end else
    Exit;

  if Result <> DBIERR_NONE then begin
    srtCloseFiles;
    if srtTableScope  = tsPersistent then
      srtDeleteFiles;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtCanGrantRequest(aLink : TnxServerTransactionLevelTableLink)
                                                     : TnxCanGrantRequest;
var
  TransLink     : TnxServerTransactionLevelTableLink;
  Session       : TObject;
  LastTransLink : TnxServerTransactionLevelTableLink;
begin
  if Assigned(aLink.ttlReason) then
    aLink.ttlReason.Clear;

  Result := cgrLater;
  if Assigned(srtTransLinksGrantedHead) then begin
    if aLink.ttlExclusive then begin
      if (srtTransLinksGrantedHead = aLink.ttlConvertFrom) and
         (srtTransLinksGrantedTail = aLink.ttlConvertFrom) then
        Result := cgrYes
      else if Assigned(aLink.ttlTransactionLevel.tlTransaction.OwningSession) then begin
        Session := aLink.ttlTransactionLevel.tlTransaction.OwningSession;
        TransLink := srtTransLinksGrantedHead;
        LastTransLink := nil;
        while Assigned(TransLink) do begin
          if TransLink <> aLink.ttlConvertFrom then begin
            if TransLink.ttlTransactionLevel.tlTransaction.OwningSession = Session then begin
              srtSetReason(aLink, TransLink);
              Result := cgrNever;
              break;
            end;
            LastTransLink := TransLink;
          end;
          TransLink := TransLink.ttlTableNext;
        end;
        if Result <> cgrNever then
          srtSetReason(aLink, LastTransLink);
      end;
    end else
      if not srtTransLinksGrantedHead.ttlExclusive then
        Result := cgrYes
      else
        srtSetReason(aLink, srtTransLinksGrantedHead);
  end else
    Result := cgrYes;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtChangePassword(aTrans       : TnxBaseTransaction;
                                        const aNewPassword : UnicodeString)
                                                           : TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_NONE;
  try
    for i := Low(sbtBlockAccess) to High(sbtBlockAccess) do
      sbtBlockAccess[i].ChangePassword(aTrans, aNewPassword);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtCheckPendingRequests;

  procedure GrantRequest(aLink : TnxServerTransactionLevelTableLink);
  begin
    with aLink do begin
      ttlRemoveFromTable;
      if ttlState = ttlsPendingUpgrade then begin
        ttlState := ttlsGranted;
        ttlUpgradeCompleted;
      end else begin
        ttlState := ttlsGranted;
        ttlAddToTable;
      end;
      if Assigned(ttlEvent) then
        ttlEvent.SignalEvent;
    end;
  end;

  procedure DenyRequest(aLink : TnxServerTransactionLevelTableLink);
  begin
    with aLink do begin
      ttlRemoveFromTable;
      ttlState := ttlsFailed;
      if Assigned(ttlEvent) then
        ttlEvent.SignalEvent;
    end;
  end;

  function ProcessRequest(aLink : TnxServerTransactionLevelTableLink): Boolean;
  begin
    Result := True;
    case srtCanGrantRequest(aLink) of
      cgrYes:
        GrantRequest(aLink);
      cgrNever:
        DenyRequest(aLink);
    else
      Result := False;
    end;
  end;

begin
  if Assigned(srtTransLinksPendingUpgrade) then
    ProcessRequest(srtTransLinksPendingUpgrade)
  else
    while Assigned(srtTransLinksPendingHead) and
      ProcessRequest(srtTransLinksPendingHead) do {keep processing};
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtCloseFiles: TnxResult;
var
  FileInx  : integer;
begin
  Result := DBIERR_NONE;
  try
    try
      nxFreeAndNil(srtStreamEngine);
      sbtDestroyChildren;
      sbtDestroyEngines;
      sbtDestroyBlockAccess;
    finally
      for FileInx := High(srtFiles) downto Low(srtFiles) do try
        if Assigned(srtFiles[FileInx]) then begin
          if srtFiles[FileInx].FileIsOpen then
            srtFiles[FileInx].CloseFile;
          srtFiles[FileInx].fiBufMgr.RemoveFile(srtFiles[FileInx]);
          nxFreeAndNil(srtFiles[FileInx]);
        end;
      except
        on E : Exception do
          Self.asoConvertException(E); {will create a log entry...}
      end;

      srtFiles := nil;
      srtMainFile := nil;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtCreateFile(aFileInx   : Integer;
                                          aTrans     : TnxBaseTransaction;
                                          aPasswords : TnxUnicodeStrings;
                                          aForServer : Boolean;
                                          aAttribs   : TnxFileAttributes;
                                          aStore     : TnxBaseTempStorage)
                                                     : TnxResult;
begin
  if (aFileInx <> 0) then begin
    srtFiles[aFileInx] := TnxBaseFile.Alloc(True, ChangeFileExt(
      nxMakeFullFileName(srtFolder.sfPath, srtName),
      '.' + srtDictionary.FilesDescriptor.FileDescriptor[aFileInx].Extension),
      srtFolder.sfServerEngine.seBufferManager);
    with srtFiles[aFileInx] do begin
      fiSnapshotBlockCount := @srtSnapshotBlockCount;
      fiAttributes := aAttribs;
      fiForServer := aForServer;
      fiEncryptionEngineName := srtDictionary.EncryptionEngine;
      fiStreamEngineName := srtDictionary.StreamDescriptor.StreamEngine;
      fiTempStore := aStore;
      fiInitialSize := srtDictionary.FilesDescriptor.FileDescriptor[aFileInx].InitialSize;
      fiGrowSize := srtDictionary.FilesDescriptor.FileDescriptor[aFileInx].GrowSize;
      fiMaxID := srtDictionary.CurrentID;
    end;
  end;

  with srtFiles[aFileInx] do begin
    OpenFile(srtOpenMode, srtShareMode, true, true);
    try
      if fiOpenMode = omReadOnly then
        srtOpenMode := omReadOnly;
      fiBlockSize := srtDictionary.FilesDescriptor.FileDescriptor[aFileInx].BlockSize;
      if srtDictionary.Version >= 5 then
        fiNexusVersion := nxVersion47005
      else
        fiNexusVersion := nxTableFormatVersionNumber;
      Result := AddHeader(aTrans, aPasswords, srtDictionary.HeaderSignature);
      if Result <> DBIERR_NONE then begin
        fiBufMgr.RemoveFile(srtFiles[aFileInx]);
        CloseFile;
        if aFileInx <> 0 then begin
          Free;
          srtFiles[aFileInx] := nil;
        end;
        Exit;
      end;
    except
      fiBufMgr.RemoveFile(srtFiles[aFileInx]);
      CloseFile;
      if aFileInx <> 0 then begin
        Free;
        srtFiles[aFileInx] := nil;
      end;
      raise;
    end;{try..except}
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtDecCursorCount;
begin
  Dec(srtCursorCount);
  if (srtCursorCount = 0) and (srtTableScope = tsPersistent) then
    srtServerEngineAddToInactiveTables;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtDeleteFiles;
var
  i        : Integer;
  FullName : string;
begin
  with srtFolder, srtDictionary, FilesDescriptor do
    for i := 0 to Pred(FileCount) do begin
      if i = 0 then
        FullName := nxMakeFullFileName(sfPath,
          nxMakeFileNameExt(srtName, srtFolder.sfServerEngine.seTableExtension))
      else
        FullName := nxMakeFullFileName(sfPath,
          nxMakeFileNameExt(srtName, FileDescriptor[i].Extension));
      DeleteFile(FullName); {ignore errors}
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtEndCommitPhase1(aTransaction: TnxServerTransaction);
begin
  sbtLocksEndTransaction(aTransaction);
  srtContentPortal.EndWrite;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtEndCommitPhase2(aTransaction: TnxServerTransaction);
begin
  srtCommitPadlock.Unlock;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtExtractPassword: UnicodeString;
begin
  if Assigned(srtFiles[0].fiEncryptionEngine) then
    Result := srtFiles[0].fiEncryptionEngine.ExtractPassword
  else
    Result := '';
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtIncCursorCount;
begin
  if srtCursorCount = 0 then
    srtServerEngineRemoveFromInactiveTables;
  Inc(srtCursorCount);
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtIsInactive(aIgnoreKeepInMemory : Boolean;
                                          aRequestClose       : Boolean;
                                          aExpectedLockCount  : Integer = 0)
                                                              : Boolean;
var
  LockCount : Integer;
begin
  LockCount := LockedCompareExchange(sbtLockIsInactive, 0, 0);

  if (sbtRoot.srtTableScope  = tsTempUnnamed) and not Assigned(sbtCursorsHead) and (LockCount = aExpectedLockCount) then begin
    Assert(not Assigned(srtTransLinksPendingUpgrade));
    Assert(not Assigned(srtTransLinksPendingHead));
    Assert(not Assigned(srtTransLinksSnapshotGrantedHead));
    Assert(not (srtSnapshotBlockCount > 0));
    while Assigned(srtTransLinksGrantedHead) do
      srtTransLinksGrantedHead.Free;
  end;

  Result := not Assigned(srtTransLinksPendingUpgrade)
        and not Assigned(srtTransLinksPendingHead)
        and not Assigned(srtTransLinksGrantedHead)
        and not Assigned(srtTransLinksSnapshotGrantedHead)
        and not (srtSnapshotBlockCount > 0)
        and     (LockCount = aExpectedLockCount)
        and (aIgnoreKeepInMemory or (srtTableScope  in [tsPersistent, tsTempUnnamed]));

  if Result then begin
    Result := sbtIsInactive(aIgnoreKeepInMemory, aRequestClose, aExpectedLockCount);
    if not Result then
      Exit;

    Assert(not Assigned(srtTransLinksPendingUpgrade)
       and not Assigned(srtTransLinksPendingHead)
       and not Assigned(srtTransLinksGrantedHead)
       and not Assigned(srtTransLinksSnapshotGrantedHead)
       and not (srtSnapshotBlockCount > 0)
       and     (LockCount = aExpectedLockCount)
       and (aIgnoreKeepInMemory or (srtTableScope  in [tsPersistent, tsTempUnnamed])));
  end;

  if Result then begin
    Result := srtCommitPadlock.TryLock;
    if Result then
      srtCommitPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRootTable.srtOpenFiles(aTrans      : TnxBaseTransaction;
                                         aPasswords  : TnxUnicodeStrings;
                                         aForServer  : Boolean;
                                         aAttribs    : TnxFileAttributes;
                                     out aIsReadOnly : Boolean)
                                                     : TnxResult;
var
  Page           : PnxBlock;
  RelMethod      : TnxReleaseMethod;
  FileInx        : integer;
  s              : string;
  IsReadOnly     : Boolean;
  lFileID        : string;
  lFileIDChanged : Boolean;
  lTrans         : TnxBaseTransaction;
begin
  aIsReadOnly := False;
  srtFileIsLink := False;
  lFileIDChanged := False;
  lTrans := nil;

  Result := srtCloseFiles;
  if Result = DBIERR_NONE then try
    srtForServer := aForServer;

    SetLength(srtFiles, 1);
    srtFiles[0] := TnxBaseFile.Alloc(True, ChangeFileExt(
      nxMakeFullFileName(srtFolder.sfPath, srtName), '.' + srtFolder.sfServerEngine.seTableExtension),
      srtFolder.sfServerEngine.seBufferManager);

    srtMainFile := srtFiles[0];
    with srtMainFile do begin
      fiSnapshotBlockCount := @srtSnapshotBlockCount;
      fiAttributes := aAttribs;
      fiForServer := aForServer;
      fiLogTable := srtName;
      fiLogFile := '';
    end;

    //NotifyExtenders(eaOpenFile, True, [srtMainFile]);
    srtMainFile.OpenFile(srtOpenMode, srtShareMode, aForServer, False);
    if srtMainFile.fiOpenMode = omReadOnly then
      srtOpenMode := omReadOnly;
    if srtMainFile.fiIsLink then
      srtFileIsLink := True;
    NotifyExtenders(eaOpenFile, False, [srtMainFile]);

    s := ChangeFileExt(ExtractFileName(srtMainFile.fiName), '');

    if not AnsiSameStr(srtName, s) then
      if AnsiSameText(srtName, s) then begin
        srtFolder.sfTablesPadlock.Lock;
        try
          srtRemoveFromFolder;
          srtName := s;
          if AnsiSameText(sbtNameInScope, s) then begin
            sbtNameInScope := s;
            srtDictionary._BaseName := s;
          end;
          srtAddToFolder;
        finally
          srtFolder.sfTablesPadlock.Unlock;
        end;
      end;

    Result := srtMainFile.fiBufMgr.AddFile(srtMainFile, aTrans, aPasswords, False, RelMethod, Page, aIsReadOnly);
    if Result = DBIERR_NONE then begin
      RelMethod(Page);

      if srtMainFile.fiOpenMode = omReadOnly then
        srtOpenMode := omReadOnly;

      sbtCreateBlockAccess; {create block access for the main file}

      srtStreamEngine := TnxBaseStreamEngine.CreateEngine(TnxBaseStreamDescriptor(nil), sbtBlockAccess[0], nil);
      srtDictionary.ReadFromFile(srtStreamEngine, aTrans);
      srtStreamEngine.Initialize(srtDictionary);

      SetLength(srtFiles, srtDictionary.FilesDescriptor.FileCount);

      srtFiles[0].fiInitialSize := srtDictionary.FilesDescriptor.FileDescriptor[0].InitialSize;
      srtFiles[0].fiGrowSize := srtDictionary.FilesDescriptor.FileDescriptor[0].GrowSize;
      srtFiles[0].fiMaxID := srtDictionary.CurrentID;

      lFileID := srtFiles[0].GetFileID;
      if not (CompareStr(srtDictionary.FilesDescriptor.FileDescriptor[0].FileID, lFileID) = 0) then begin
        srtDictionary.FilesDescriptor.FileDescriptor[0].FileID := lFileID;
        lFileIDChanged := True;
      end;

      for FileInx := 1 to Pred(srtDictionary.FilesDescriptor.FileCount) do begin
        srtFiles[FileInx] := TnxBaseFile.Alloc(True, ChangeFileExt(
          nxMakeFullFileName(srtFolder.sfPath, srtName),
          '.' + srtDictionary.FilesDescriptor.FileDescriptor[FileInx].Extension),
          srtFolder.sfServerEngine.seBufferManager);
        with srtFiles[FileInx] do begin
          fiSnapshotBlockCount := @srtSnapshotBlockCount;
          fiAttributes := aAttribs;
          fiForServer := aForServer;
          fiInitialSize := srtDictionary.FilesDescriptor.FileDescriptor[FileInx].InitialSize;
          fiGrowSize := srtDictionary.FilesDescriptor.FileDescriptor[FileInx].GrowSize;
          fiMaxID := srtDictionary.CurrentID;
          fiLogTable := srtName;
          fiLogFile := srtDictionary.FilesDescriptor.FileDescriptor[FileInx].Extension;
        end;
      end;

      for FileInx := 1 to Pred(srtDictionary.FilesDescriptor.FileCount) do begin
        srtFiles[FileInx].OpenFile(srtMainFile.fiOpenMode, srtMainFile.fiShareMode,
          srtMainFile.fiWriteThru, False);
        if srtFiles[FileInx].fiIsLink then
          srtFileIsLink := True;
        NotifyExtenders(eaOpenFile, False, [srtFiles[FileInx]]);
        Result := srtFiles[FileInx].fiBufMgr.AddFile(srtFiles[FileInx], aTrans, aPasswords, False, RelMethod, Page, IsReadOnly);

        lFileID := srtFiles[FileInx].GetFileID;
        if not (CompareStr(srtDictionary.FilesDescriptor.FileDescriptor[FileInx].FileID, lFileID) = 0) then begin
          srtDictionary.FilesDescriptor.FileDescriptor[FileInx].FileID := lFileID;
          lFileIDChanged := True;
        end;

        Assert(IsReadOnly = aIsReadOnly);
        if Result <> DBIERR_NONE then
          Break;
        RelMethod(Page);
      end;

      if Result = DBIERR_NONE then begin
        if srtOpenMode = omReadOnly then
          aIsReadOnly := True;

        sbtCreateBlockAccess; {create block access for all additional files}
        sbtInitFromDescriptor(srtDictionary);
        sbtCreateEngines(nil);
        sbtCreateChildren(nil);

        if lFileIDChanged then begin
          srtDictionary.RecreateGuid;
          if not aIsReadOnly then begin
            if not Assigned(aTrans) then begin
              lTrans := TnxServerTransaction.Create(srtMainFile.fiBufMgr, nil, False, False, False);
              aTrans := lTrans;
            end;
            try
              srtDictionary.WriteToFile(srtStreamEngine, aTrans, nxVersionNumber);

              if Assigned(lTrans) then begin
                lTrans.Commit;
                lTrans := nil;
              end;
            finally
              if Assigned(lTrans) then
                lTrans.Rollback;
            end;
          end;
        end;

        NotifyExtenders(eaOpenFiles, False, []);
      end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end else
    Exit;

  if Result = DBIERR_FILENOACCESS then
    Result := EnxBaseException.nxSetMessage(DBIERR_NOSUCHTABLE, nxcOrgMessageMarker +
      ' Error opening files for root table "' + FullName + '"');

  if Result <> DBIERR_NONE then
    srtCloseFiles;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtRemoveFromFolder;
var
  Index : Integer;
begin
  with srtFolder do begin
    sfTablesPadlock.Lock;
    try
      with sfTables do
        if Find(srtName, Index) then begin
          Delete(Index);
          if srtTableScope <> tsPersistent then
            LockedDec(sfInMemoryCount);
        end;
    finally
      sfTablesPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtServerEngineAddToInactiveTables;
begin
  if srtInServerEngineInactiveTables then
    Exit;

  srtInactiveSince := Now;

  with srtFolder, sfServerEngine do begin
    seInactiveTablesPadlock.Lock;
    try
      srtServerEngineInactiveTablesPrev := seInactiveTablesTail;
      seInactiveTablesTail := Self;
      if Assigned(srtServerEngineInactiveTablesPrev) then
        srtServerEngineInactiveTablesPrev.srtServerEngineInactiveTablesNext := Self;
      if not Assigned(seInactiveTablesHead) then
        seInactiveTablesHead := Self;

      Inc(seInactiveTablesCount);
    finally
      seInactiveTablesPadlock.Unlock;
    end;
  end;

  srtInServerEngineInactiveTables := True;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtServerEngineRemoveFromInactiveTables;
begin
  if not srtInServerEngineInactiveTables then
    Exit;

  with srtFolder, sfServerEngine do begin
    seInactiveTablesPadlock.Lock;
    try
      if Assigned(srtServerEngineInactiveTablesNext) then
        srtServerEngineInactiveTablesNext.srtServerEngineInactiveTablesPrev := srtServerEngineInactiveTablesPrev
      else
        if seInactiveTablesTail = Self then
          seInactiveTablesTail := srtServerEngineInactiveTablesPrev;

      if Assigned(srtServerEngineInactiveTablesPrev) then
        srtServerEngineInactiveTablesPrev.srtServerEngineInactiveTablesNext := srtServerEngineInactiveTablesNext
      else
        if seInactiveTablesHead = Self then
          seInactiveTablesHead := srtServerEngineInactiveTablesNext;

      srtServerEngineInactiveTablesNext := nil;
      srtServerEngineInactiveTablesPrev := nil;

      Dec(seInactiveTablesCount);
    finally
      seInactiveTablesPadlock.Unlock;
    end;
  end;

  srtInServerEngineInactiveTables := False;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtSetFileMaxID;
var
  FileInx   : integer;
begin
  for FileInx := 0 to Pred(srtDictionary.FilesDescriptor.FileCount) do
    with srtFiles[FileInx] do
      fiMaxID := srtDictionary.CurrentID;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRootTable.srtSetReason(aRequestingLink, aConflictingLink: TnxServerTransactionLevelTableLink);
var
  Reason             : TnxLockFailureReason;
  RequestingSession  : TnxAbstractSession;
  ConflictingSession : TnxAbstractSession;
  Multiple           : Boolean;
const
  SharedExclusiveText : array[Boolean] of string =  //..
    ('compartido', 'exclusivo');
  UpgradeText : array[Boolean] of string =
    (' ', ' actualización ');
  SingleMultipleText : array[Boolean] of string =
    ('un bloqueo de tipo %s.', 'varios bloqueos de tipo %s.');
begin
  Reason := aRequestingLink.ttlReason;
  if not Assigned(Reason) then
    Exit;
  aRequestingLink.ttlReason := nil;

  Reason.Clear;

  RequestingSession := nil;
  with aRequestingLink.ttlTransactionLevel.tlTransaction do
    if OwningSession is TnxAbstractSession then
      RequestingSession  := TnxAbstractSession(OwningSession);

  Multiple := False;
  ConflictingSession := nil;
  if Assigned(aConflictingLink) then begin
    with aConflictingLink.ttlTransactionLevel.tlTransaction do
      if OwningSession is TnxAbstractSession then
        ConflictingSession  := TnxAbstractSession(OwningSession);

    with aConflictingLink do
      Multiple :=
        (Assigned(ttlTableNext) and (ttlTableNext <> aRequestingLink.ttlConvertFrom)) or
        (Assigned(ttlTablePrev) and (ttlTablePrev <> aRequestingLink.ttlConvertFrom));

    Reason.Add(Format('The requested %s transaction lock%sfor table "%s" could not be granted due to ' + SingleMultipleText[Multiple],
      [
        SharedExclusiveText[aRequestingLink.ttlExclusive],
        UpgradeText[Assigned(aRequestingLink.ttlConvertFrom)],
        FullName,
        SharedExclusiveText[aConflictingLink.ttlExclusive]
      ]) +
      nxeCustomInfo('LockError.Type', 'transaction') +
      nxeCustomInfo('LockError.RequestExclusive', IntToStr(Ord(aRequestingLink.ttlExclusive)))+
      nxeCustomInfo('LockError.ConflictExclusive', IntToStr(Ord(aConflictingLink.ttlExclusive))) +
      nxeCustomInfo('LockError.ConflictMultiple', IntToStr(Ord(Multiple)))
    );
  end else begin
    Reason.Add(Format('The requested %s transaction lock%sfor table "%s" could not be granted.',
      [
        SharedExclusiveText[aRequestingLink.ttlExclusive],
        UpgradeText[Assigned(aRequestingLink.ttlConvertFrom)],
        FullName
      ]) +
      nxeCustomInfo('LockError.Type', 'transaction') +
      nxeCustomInfo('LockError.RequestExclusive', IntToStr(Ord(aRequestingLink.ttlExclusive)))
    );
  end;

  //.. Reason.Add('');

  if ConflictingSession = nil then begin
    Reason.Add('El conflicto ha ocurrido con una sesión desconocida.' + nxeCustomInfo('LockError.UnknownSession', '1'));
  end else if RequestingSession = ConflictingSession then begin
    Reason.Add(nxeCustomInfo('LockError.SameSession', '1'));
    Reason.SameSession := True;
  end else begin
    if Multiple then
      Reason.Add('Una de las sesiones conflictivas es : ')
    else
      Reason.Add('El conflicto ha ocurrido en la siguiente sesión : ');  //..
    ConflictingSession.GetUserInfo(Reason);
  end;
end;
{==============================================================================}



{===TnxBlobLinkHandler=========================================================}
procedure TnxBlobLinkHandler.blhCursorRequestClose(Sender: TObject);
var
  Index: Integer;
begin
  if asoDestroying then
    Exit;
  blhPortal.BeginWrite;
  try
    if asoDestroying then
      Exit;
    Index := blhBlobCursors.IndexOfObject(Sender);
    if Index >= 0 then begin
      blhBlobCursors.Objects[Index].Free;
      blhBlobCursors.Delete(Index);
    end;
  finally
    blhPortal.EndWrite;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobLinkHandler.blhFindBlobCursor(const aTableName : string;
                                              const aPassword  : UnicodeString;
                                                out aCursor    : TnxServerBaseCursor)
                                                               : TnxResult;
var
  Index         : Integer;
  lTransContext : TnxAbstractTransContext;
begin
  if not Assigned(blhBlobCursors) then begin
    blhPortal.BeginWrite;
    try
      if not Assigned(blhBlobCursors) then begin
        blhBlobCursors := TStringList.Create;
        blhBlobCursors.Sorted := True;
        blhBlobCursors.Duplicates := dupError;
      end;
    finally
      blhPortal.EndWrite;
    end;
  end;

  if not blhBlobCursors.Find(aTableName, Index) then
    Index := -1;

  if Index >= 0 then begin
    aCursor := TnxServerBaseCursor(blhBlobCursors.Objects[Index]);
    if Assigned(blhTransContext) then
      aCursor.sbcTransContextSet(blhTransContext^);
    Result := DBIERR_NONE;
  end else begin
    blhPortal.BeginWrite;
    try
      if not blhBlobCursors.Find(aTableName, Index) then
        Index := -1;

      if Index >= 0 then begin
        aCursor := TnxServerBaseCursor(blhBlobCursors.Objects[Index]);
        Result := DBIERR_NONE;
      end else begin
        if Assigned(blhTransContext) then
          lTransContext := blhTransContext^
        else
          lTransContext := nil;

        Result := blhDatabase.sdCursorOpen(
          TnxAbstractCursor(aCursor), lTransContext, aTableName, aPassword, False, omReadOnly,
          smShared, False, blhDatabase.atoTimeout, '', -1, False);
        if Result = DBIERR_NONE then begin
          aCursor.OnRequestClose := blhRequestClose;
          blhBlobCursors.AddObject(aTableName, aCursor);
        end;
      end;
    finally
      blhPortal.EndWrite;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobLinkHandler.BlobLinkGetLength(const aTableName : string;
                                                    aBlobNr    : TnxBlobNr;
                                                out aLength    : TnxWord32)
                                                               : TnxResult;
var
  Cursor : TnxServerBaseCursor;
begin
  TnxReadWritePortal.CreateAndRead(blhPortal);
  try
    Result := blhFindBlobCursor(aTableName, ''{!!!}, Cursor);
    if Result = DBIERR_NONE then
      Result := Cursor.sbcBlobGetLength(ridNull, -1, aBlobNr, aLength, False, nil);
  finally
    blhPortal.EndRead;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobLinkHandler.BlobLinkRead(const aTableName : string;
                                               aBlobNr    : TnxBlobNr;
                                               aOffset    : TnxWord32;
                                               aLen       : TnxWord32;
                                               aStream    : TStream)
                                                          : TnxResult;
var
  Cursor : TnxServerBaseCursor;
begin
  TnxReadWritePortal.CreateAndRead(blhPortal);
  try
    Result := blhFindBlobCursor(aTableName, ''{!!!}, Cursor);
    if Result = DBIERR_NONE then
      Result := Cursor.sbcBlobRead(ridNull, -1, aBlobNr, aOffset, aLen, aStream, False, nil);
  finally
    blhPortal.EndRead;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxBlobLinkHandler.Create(aDatabase     : TnxServerDatabase;
                                      aTransContext : PnxServerTransContext);
begin
  blhRequestClose := nxRequestCloseHandlerEvent(blhCursorRequestClose);
  blhDatabase := aDatabase;
  blhTransContext := aTransContext;
  inherited Create(blhDatabase);
end;
{------------------------------------------------------------------------------}
destructor TnxBlobLinkHandler.Destroy;
var
  i: Integer;
begin
  if Assigned(blhRequestClose) then
    blhRequestClose.Disconnect;

  if Assigned(blhPortal) then
    blhPortal.BeginWrite;
  try
    if Assigned(blhBlobCursors) then begin
      for i := Pred(blhBlobCursors.Count) downto 0 do try
        blhBlobCursors.Objects[i].Free;
      except
        on E : Exception do
          asoConvertException(E); {will create a log entry...}
      end;

      nxFreeAndNil(blhBlobCursors);
    end;
  finally
    if Assigned(blhPortal) then
      blhPortal.EndWrite;
  end;

  inherited;

  nxFreeAndNil(blhPortal);
end;
{==============================================================================}



{===TnxServerBaseCursor========================================================}
function TnxServerBaseCursor.acSnapshotRequiredForBlobRead(const aRecID   : TnxRecID;
                                                                 aFieldNo : TnxInt32;
                                                                 aBlobNr  : TnxBlobNr;
                                                                 aReadOrg : Boolean)
                                                                          : Boolean;
begin
  Result := not Assigned(ActiveTrans);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.acTransactionRollbackForBlobReadSnapshoted: TnxResult;
var
  Trans: TnxServerTransaction;
begin
  Trans := ActiveTrans;
  if (not Assigned(Trans)) or
     ([tsSnapshot, tsForBlobRead] * Trans.btState <>
       [tsSnapshot, tsForBlobRead])
  then
    Result := DBIERR_NOACTIVETRAN
  else
    Result := sbcTransContext.stcTransactionRollback;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.acTransactionStartForBlobReadSnapshoted: TnxResult;
begin
  Result := sbcTransContext.stcTransactionStart(False, True, False, False, False, False);
  if Result = DBIERR_NONE then begin
    Assert(Assigned(sbcTrans^) and (tsSnapshot in sbcTrans^.btState));
    Include(sbcTrans^.btState, tsForBlobRead);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.AfterConstruction;
begin
  inherited;
  if not sbcIsReadOnly then
    if _Dictionary.Version < 2 then begin
      sbcIsReadOnly := True;
      sbcReadOnlyResult := DBIERR_TABLELEVEL;
      sbcReadOnlyResultMessage := @rsTableFormatOutdated;
    end;
  sbcSetToBegin;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.AutoIncGet(out aValue       : TnxWord32;
                                            aAllowCached : Boolean = False)
                                                         : TnxResult;
begin
  { aAllowCached ignored, only relevant for remote server engine }
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then
        try
          aValue := sbcAutoIncGet;
        finally
          sbcEndContentLock;
        end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.AutoIncSet(aValue : TnxWord32)
                                               : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcAutoIncSet(aValue);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobAddToCache(const aRecID   : TnxRecID;
                                                  aFieldNo : TnxInt32;
                                            const aBlobNr  : TnxBlobNr;
                                                  aLen     : TnxWord32;
                                            const aBlob    )
                                                           : TnxResult;
begin
  if not (acsIsCache in acStates) or
     not ridIsValid(aRecID) or
     (aFieldNo < 0) or
     (aBlobNr = 0) or
     (aLen < 1)
  then
    Result := inherited BlobAddToCache(aRecID, aFieldNo, aBlobNr, aLen, aBlob)
  else
    if sbcIsReadOnly then
      Result := sbcGetReadOnlyResult
    else begin
      nxSetTimeout(atoTimeout);
      atoLock.Lock;
      try
        try
          Result := sbcBlobAddToCache(aRecID, aFieldNo, aBlobNr, aLen, aBlob);
        except
          on E : Exception do
            Result := Self.asoConvertException(E);
        end;
      finally
        atoLock.Unlock(Result);
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobCreate(const aRecID   : TnxRecID;
                                              aFieldNo : TnxInt32;
                                          out aBlobNr  : TnxBlobNr)
                                                       : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobCreate(aRecID, aFieldNo, aBlobNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobCreateFile(const aRecID   : TnxRecID;
                                                  aFieldNo  : TnxInt32;
                                            const aFileName : string;
                                              out aBlobNr   : TnxBlobNr)
                                                            : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobCreateFile(aRecID, aFieldNo, aFileName, aBlobNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobDelete(const aRecID   : TnxRecID;
                                              aFieldNo : TnxInt32;
                                        const aBlobNr  : TnxBlobNr)
                                                       : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobDelete(aRecID, aFieldNo, aBlobNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobFree(const aRecID   : TnxRecID;
                                            aFieldNo : TnxInt32;
                                      const aBlobNr  : TnxBlobNr)
                                                     : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobFree(aRecID, aFieldNo, aBlobNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobModified(const aRecID    : TnxRecID;
                                                aFieldNo  : TnxInt32;
                                          const aBlobNr   : TnxBlobNr;
                                            out aModified : Boolean)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcBlobModified(aRecID, aFieldNo, aBlobNr, aModified);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobReplace(const aRecID   : TnxRecID;
                                               aFieldNo : TnxInt32;
                                         var   aBlobNr  : TnxBlobNr;
                                               aLen     : TnxWord32;
                                         const aBlob    )
                                                        : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobReplace(aRecID, aFieldNo, aBlobNr, aLen, aBlob);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobsCancel(const aRefNr: TnxRefNr): TnxResult;
begin
  if sbcIsReadOnly or not Assigned(acSFI.sfiBlobFields) then
    Result := DBIERR_NONE
  else if not (accCancelBlobs in acCapabilities) then
    Result := DBIERR_NOTSUPPORTED
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobsCancel(aRefNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobTruncate(const aRecID      : TnxRecID;
                                                aFieldNo    : TnxInt32;
                                          const aBlobNr     : TnxBlobNr;
                                                aBlobLength : TnxWord32)
                                                            : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobTruncate(aRecID, aFieldNo, aBlobNr, aBlobLength);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BlobWrite(const aRecID   : TnxRecID;
                                             aFieldNo : TnxInt32;
                                       const aBlobNr  : TnxBlobNr;
                                             aOffset  : TnxWord32;
                                             aLen     : TnxWord32;
                                       const aBlob    )
                                                      : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := sbcBlobWrite(aRecID, aFieldNo, aBlobNr, aOffset, aLen, aBlob);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                                               aSize     : TnxWord32;
                                           out aVariant  : Variant)
                                                         : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcBookmarkAsVariant(aBookmark, aSize, aVariant);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BookmarkCheckLocal(aBookmark: PnxBookmarkBuffer; aSize: TnxWord32): TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcBookmarkCheckLocal(aBookmark, aSize);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.BookmarkClear(aBookmark : PnxBookmarkBuffer;
                                           aSize     : TnxWord32)
                                                     : TnxResult;
begin
  try
    Result := sbcBookmarkClear(aBookmark, aSize);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.ChangePassword(const aNewPassword : UnicodeString)
                                                               : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      Result := sbcChangePassword(aNewPassword);
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.CompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                                              aBookmark2  : PnxBookmarkBuffer;
                                              aSize       : TnxWord32;
                                          out aCompResult : TnxValueRelationship)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcCompareBookmarks(aBookmark1, aBookmark2, aSize, aCompResult);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.CompareKeys(aFieldCount : Integer;
                                     aPartialLen : Integer;
                                     aDirectKey1 : Boolean;
                                     aKeyData1   : PnxKeyOrRecordBuffer;
                                     aDirectKey2 : Boolean;
                                     aKeyData2   : PnxKeyOrRecordBuffer;
                                 out aResult     : TnxValueRelationship)
                                                 : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcCompareKeys(aFieldCount, aPartialLen,
        aDirectKey1, aKeyData1, aDirectKey2, aKeyData2, aResult);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.CopyRecords(aDestCursor   : TnxAbstractCursor;
                                         aBlobCopyMode : TnxBlobCopyMode;
                                         aMaxTransSize : Integer)
                                                       : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcCopyRecords(aDestCursor, aBlobCopyMode, aMaxTransSize, True);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.CopyRecordsEx(aDestCursor     : TnxAbstractCursor;
                                           aBlobCopyMode   : TnxBlobCopyMode;
                                           aMaxTransSize   : Integer;
                                           aCheckValFields : Boolean)
                                                           : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcCopyRecords(aDestCursor, aBlobCopyMode, aMaxTransSize, aCheckValFields);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxServerBaseCursor.Create(aDelayInformMonitors : Boolean;
                                       aDatabase            : TnxServerDatabase;
                                       aTransContext        : TnxAbstractTransContext;
                                       aTimeout             : TnxWord32;
                                       aOpenMode            : TnxOpenMode);
begin
  esoDelayInformMonitors := aDelayInformMonitors;
  inherited Create(aDatabase, aTransContext, aTimeout);

  sbcForRecover := sbcForRecover or _ForRecover;

  sbcFilterTimeout := nxDefaultFilterTimeout;

  sbcInsertOptions := nxc_AllInsertOptions;

  sbcLockFailureReason := TnxLockFailureReason.Create;

  if Assigned(aTransContext) then
    sbcTransContext := aTransContext as TnxServerTransContext
  else
    sbcTransContext := aDatabase.TransContext as TnxServerTransContext;
  sbcTrans := @sbcTransContext.stcTransaction;

  sbcIsReadOnly := aOpenMode = omReadOnly;
  sbcReadOnlyResult := DBIERR_TABLEREADONLY;

  sbcOpenMode  := aOpenMode;

  if not (sbcForRecover or (acsIsCache in acStates)) then begin
    sbcDefaultValueHandler := TnxDefaultValueHandler.CreateFor
      (TableDescriptor.FieldsDescriptor, aaServer, Self);
    sbcValidationsHandler := TnxValidationsHandler.CreateFor
      (TableDescriptor.FieldsDescriptor, aaServer, Self);
  end;

  if not Assigned(acSFI) then
    acSetupDescriptorDependentFields;

  if Assigned(acSFI.sfiBlobFields) then
    Include(acCapabilities, accCancelBlobs);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.DeleteRecords: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcDeleteRecords;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerBaseCursor.Destroy;
begin
  try
    sbcTaskInfo.Free;
  except end;

  nxFreeAndNil(sbcFilter);
  nxFreeAndNil(sbcKeyFilter);

  nxFreeAndNil(sbcDefaultValueHandler);
  nxFreeAndNil(sbcDefaultValueHandlerClient);
  nxFreeAndNil(sbcValidationsHandler);
  inherited;
  nxFreeAndNil(sbcLockFailureReason);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.Duplicate(aOpenMode    : TnxOpenMode;
                               out aNewCursorID : TnxAbstractCursor)
                                                : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcDuplicate(aOpenMode, aNewCursorID);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.esoInformMonitors: Boolean;
begin
  Result := (inherited esoInformMonitors) and (not sbcForRecover);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.esoOptionChanged(const aName, aValue: string);
var
  Option : TnxInsertOption;
begin
  inherited;
  if SameText(aName, 'INSERT_OPTIONS_SETDEFAULT') then
    Option := ioSetDefault
  else if SameText(aName, 'INSERT_OPTIONS_SETAUTOINC') then
    Option := ioSetAutoInc
  else if SameText(aName, 'INSERT_OPTIONS_VALIDATE') then
    Option := ioValidate
  else if SameText(aName, 'INSERT_OPTIONS_MODIFYIFFOUND') then
    Option := ioModifyIfFound
  else
    Exit;

  if SameText(aValue, 'True') then
    Include(sbcInsertOptions, Option)
  else
    Exclude(sbcInsertOptions, Option);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterActivate(aFilterID : TnxFilterID)
                                                  : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if Assigned(sbcFilter) then
        Result := sbcFilter.ActivateFilter(aFilterID)
      else
        Result := DBIERR_NOSUCHFILTER;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterAddCustom(aFilter   : TnxBaseFilterDescriptor;
                                         out aFilterID : TnxFilterID;
                                             aActivated: Boolean)
                                                       : TnxResult;
var
  Filter : TnxBaseFilterEngine;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      Filter := TnxBaseFilterEngine.CreateFor(aFilter, Self);
      try
        sbcFilterAddCustom(Filter, aFilterID, aActivated);
      except
        nxFreeAndNil(Filter);
        raise;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterDeactivate(aFilterID : TnxFilterID)
                                                    : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if Assigned(sbcFilter) then
        Result := sbcFilter.DeactivateFilter(aFilterID)
      else
        Result := DBIERR_NOSUCHFILTER;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterRemove(aFilterID : TnxFilterID)
                                                : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if aFilterID = 0 then begin
        nxFreeAndNil(sbcFilter);
        Result := DBIERR_NONE;
      end else
        if Assigned(sbcFilter) then
          Result := sbcFilter.RemoveFilter(aFilterID, sbcFilter)
        else
          Result := DBIERR_NOSUCHFILTER;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterReplaceCustom(aFilter          : TnxBaseFilterDescriptor;
                                             var aFilterID        : TnxFilterID;
                                                 aActivated       : Boolean;
                                                 aIgnoreDropError : Boolean)
                                                                  : TnxResult;
var
  Filter : TnxBaseFilterEngine;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      Filter := TnxBaseFilterEngine.CreateFor(aFilter, Self);
      try
        { creating the new filter before trying to drop the old makes sure they
          get different FilterIDs }
        if aFilterID = 0 then
          nxFreeAndNil(sbcFilter)
        else
          if Assigned(sbcFilter) then
            Result := sbcFilter.RemoveFilter(aFilterID, sbcFilter)
          else
            Result := DBIERR_NOSUCHFILTER;

        if aIgnoreDropError then
          Result := DBIERR_NONE;

        if Result = DBIERR_NONE then begin
          aFilterID := 0;
          sbcFilterAddCustom(Filter, aFilterID, aActivated);
        end;
      except
        nxFreeAndNil(Filter);
        raise;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.FilterSetTimeout(aTimeout : TnxWord32)
                                                       : TnxResult;
begin
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      sbcFilterTimeout := aTimeout;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetActiveTrans: TnxServerTransaction;
begin
  if Assigned(sbcTrans) then
    Result := sbcTrans^
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetBookmark(aBookmark : PnxBookmarkBuffer;
                                         aSize     : TnxWord32)
                                                   : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcGetBookmark(aBookmark, aSize);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                              aSize     : TnxWord32)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcGetBookmarkCache(aBookmark, aSize);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
begin
  inherited;
  aContainer.AddValue('OpenMode', GetEnumName(TypeInfo(TnxOpenMode), Ord(sbcOpenMode)));
  aContainer.AddValue('IsReadOnly', sbcIsReadOnly);
  aContainer.AddValue('IsWriteOnly', sbcIsWriteOnly);
  aContainer.AddValue('IsResultSet', IsResultSet);
  aContainer.AddValue('IsUnnamed', IsUnnamed);
  aContainer.AddValue('UseNestedTransaction', sbcUseNestedTransaction);
  aContainer.AddValue('Filter', sbcFilter);
  aContainer.AddValue('KeyFilter', sbcKeyFilter);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetIndexID(out aIndexID : Integer)
                                                     : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcGetIndexID(aIndexID);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetRecordCount(out aRecCount : TnxWord32;
                                                aEstimate : Boolean = False)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcGetRecordCount(rcoClientFilteredKeyCount, aRecCount, aEstimate);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetRecordCountAsync(out aTaskInfo : TnxAbstractTaskInfo)
                                                           : TnxResult;
begin
  Result := GetRecordCountExAsync(rcoClientFilteredKeyCount, aTaskInfo);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.GetRecordCountEx(aOption   : TnxRecordCountOption;
                                          out aRecCount : TnxWord32;
                                              aEstimate : Boolean = False)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcGetRecordCount(aOption, aRecCount, aEstimate);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.KeyFilterActivate(aKeyFilterID : TnxKeyFilterID)
                                                            : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if Assigned(sbcKeyFilter) then
        Result := sbcKeyFilter.ActivateFilter(aKeyFilterID)
      else
        Result := DBIERR_NOSUCHFILTER;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.KeyFilterAddCustom(aKeyFilter   : TnxBaseFilterDescriptor;
                                            out aKeyFilterID : TnxKeyFilterID;
                                                aActivated   : Boolean)
                                                             : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcKeyFilterAddCustom(aKeyFilter, aKeyFilterID, aActivated);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.KeyFilterDeactivate(aKeyFilterID : TnxKeyFilterID)
                                                              : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcKeyFilterDeactivate(aKeyFilterID);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.KeyFilterRemove(aKeyFilterID : TnxKeyFilterID)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      if aKeyFilterID = 0 then begin
        nxFreeAndNil(sbcKeyFilter);
        Result := DBIERR_NONE;
      end else
        if Assigned(sbcKeyFilter) then
          Result := sbcKeyFilter.RemoveFilter(aKeyFilterID, sbcKeyFilter)
        else
          Result := DBIERR_NOSUCHFILTER;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.KeyFilterReplaceCustom(aKeyFilter       : TnxBaseFilterDescriptor;
                                                var aKeyFilterID     : TnxKeyFilterID;
                                                    aActivated       : Boolean;
                                                    aIgnoreDropError : Boolean)
                                                                     : TnxResult;
var
  KeyFilter : TnxBaseFilterEngine;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      KeyFilter := TnxBaseFilterEngine.CreateFor(aKeyFilter, sbcGetKeyFieldsSource);
      try
        { creating the new KeyFilter before trying to drop the old makes sure they
          get different KeyFilterIDs }
        if aKeyFilterID = 0 then
          nxFreeAndNil(sbcKeyFilter)
        else
          if Assigned(sbcKeyFilter) then
            Result := sbcKeyFilter.RemoveFilter(aKeyFilterID, sbcKeyFilter)
          else
            Result := DBIERR_NOSUCHFILTER;

        if aIgnoreDropError then
          Result := DBIERR_NONE;

        if Result = DBIERR_NONE then begin
          aKeyFilterID := 0;
          sbcKeyFilterAddCustomEngine(KeyFilter, aKeyFilterID, aActivated);
        end;
      except
        nxFreeAndNil(KeyFilter);
        raise;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.PrepareDestroy;
begin
  try
    sbcTaskInfo.Free;
  except end;

  nxFreeAndNil(sbcFilter);
  nxFreeAndNil(sbcKeyFilter);

  nxFreeAndNil(sbcDefaultValueHandler);
  nxFreeAndNil(sbcValidationsHandler);

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RangeReset: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      sbcRangeReset;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RangeSet(aFieldCount1 : Integer;
                                      aPartialLen1 : Integer;
                                      aDirectKey1  : Boolean;
                                      aKeyData1    : PnxKeyOrRecordBuffer;
                                      aKeyIncl1    : Boolean;
                                      aFieldCount2 : Integer;
                                      aPartialLen2 : Integer;
                                      aDirectKey2  : Boolean;
                                      aKeyData2    : PnxKeyOrRecordBuffer;
                                      aKeyIncl2    : Boolean)
                                                   : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcRangeSet(
        aFieldCount1, aPartialLen1, aDirectKey1, aKeyData1, aKeyIncl1,
        aFieldCount2, aPartialLen2, aDirectKey2, aKeyData2, aKeyIncl2);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
    if Result <> DBIERR_NONE then
      sbcRangeReset;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecNoGet(out aRecNo     : TnxWord32;
                                          aFlipOrder : Boolean)
                                                     : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then try
        Result := sbcRecNoGet(aRecNo, aFlipOrder);
      finally
        sbcEndContentLock;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecNoSet(aRecNo     : TnxWord32;
                                      aFlipOrder : Boolean)
                                                 : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then try
        Result := sbcRecNoSet(aRecNo, aFlipOrder);
      finally
        sbcEndContentLock;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecNoSupported: TnxResult;
begin
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.RecordBufferClear(aBuffer: PnxRecordBuffer);
begin
  inherited;

  if not sbcDefaultValueHandlerClientCreated then begin
    sbcDefaultValueHandlerClientCreated := True;
    sbcDefaultValueHandlerClient := TnxDefaultValueHandler.
      CreateFor(TableDescriptor.FieldsDescriptor, aaClient, Self);
  end;

  if Assigned(sbcDefaultValueHandlerClient) then
  sbcDefaultValueHandlerClient.SetDefaultValuesInsert(aBuffer);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordDelete(aData : PnxRecordBuffer;
                                          aLSN  : TnxLSN = 0)
                                                : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordDelete(aData, aLSN);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGet(aLockType : TnxLockType;
                                   aData     : PnxRecordBuffer)
                                             : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordGet(aLockType, aData);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
type
  TnxMemoryStreamCracker = class(TnxMemoryStream);
    { Cracker class provides access to SetCapacity method. }
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGetBatch(aCutoffSize : Integer;
                                            aOptions    : TnxRecordGetBatchExOptions;
                                        var aAccess     : TnxBatchStreamAccess;
                                            aMaxRecords : Integer = -1;
                                            aForward    : Boolean = True)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordGetBatch(aCutoffSize, aOptions, aAccess, aMaxRecords, aForward);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGetForKey(aFieldCount : integer;
                                             aPartialLen : integer;
                                             aDirectKey  : Boolean;
                                             aKeyData    : PnxKeyOrRecordBuffer;
                                             aData       : PnxRecordBuffer;
                                             aMatchFirst : Boolean;
                                             aFirstCall  : Boolean)
                                                         : TnxResult;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcRecordGetForKey(aFieldCount, aPartialLen, aDirectKey,
        aKeyData, aData, aMatchFirst, aFirstCall);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGetForKeyBatch(aCutoffSize : Integer;
                                                  aOptions    : TnxRecordGetBatchExOptions;
                                              var aAccess     : TnxBatchStreamAccess;
                                            const aKeys       : TnxDataSetKeyBufferArray;
                                                  aMatchFirst : Boolean;
                                                  aFirstCall  : Boolean)
                                                              : TnxResult;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcRecordGetForKeyBatch(aCutoffSize, aOptions, aAccess,
        aKeys, aMatchFirst, aFirstCall);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGetNext(aLockType : TnxLockType;
                                           aData     : PnxRecordBuffer)
                                                     : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordGetNext(aLockType, aData);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordGetPrior(aLockType : TnxLockType;
                                            aData     : PnxRecordBuffer)
                                                      : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordGetPrior(aLockType, aData);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordInsert(aLockType : TnxLockType;
                                          aData     : PnxRecordBuffer;
                                          aAutoInc  : PnxInt64 = nil)
                                                    : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordInsert(aLockType, sbcInsertOptions, aData, aAutoInc);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordInsertBatch(aStream : TnxCustomMemoryStream)
                                                       : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      Result := sbcRecordInsertBatch(aStream);
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordIsLocked(aLockType    : TnxLockType;
                                        out aLockPresent : TnxLockPresent)
                                                         : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  aLockPresent := lpNotAtAll;
  atoLock.Lock;
  try
    try
      Result := sbcRecordIsLocked(aLockType, aLockPresent);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordLockRelease(aAllLocks    : Boolean;
                                               aCancelBlobs : Boolean = False )  //..
                                                            : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcRecordLockRelease(aAllLocks, aCancelBlobs);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.RecordModify(aData        : PnxRecordBuffer;
                                          aReleaseLock : Boolean;
                                          aDataDiff    : PnxRecordDiff)
                                                       : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcRecordModify(aData, aReleaseLock, aDataDiff);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.RequestNestedTransactions;
begin
  sbcUseNestedTransaction := True;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sacGetOpenMode: TnxOpenMode;
begin
  Result := sbcOpenMode;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sacSetDefault(aRecordBuffer: PnxRecordBuffer; aIndex: Integer);
begin
  if Assigned(DefaultValueHandler) then
    DefaultValueHandler.SetDefaultValue(aRecordBuffer, aIndex);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sacSetDefaultsInsert(aRecordBuffer: PnxRecordBuffer);
begin
  if Assigned(DefaultValueHandler) then
    DefaultValueHandler.SetDefaultValuesInsert(aRecordBuffer);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcBeginReadOrgOverride;
begin
  BeginReadOrgOverride;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcBlobAddToCache(const aRecID   : TnxRecID;
                                                     aFieldNo : TnxInt32;
                                               const aBlobNr  : TnxBlobNr;
                                                     aLen     : TnxWord32;
                                               const aBlob    )
                                                              : TnxResult;
begin
  Result := nxpNotSupported('sbcBlobAddToCache');
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcCheckTransactionState: TnxResult;
begin
  with TnxServerTransContext(Database.TransContext) do
    if Assigned(sbcTrans^) then
      Result := sbcTrans^.CheckState
    else
      Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcDisableFilterTimeout;
begin
  Inc(sbcFilterTimeoutLock);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcDisableFilterTimeoutChange;
begin
  Inc(sbcFilterTimeoutChangeLock);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcEnableFilterTimeout;
begin
  Dec(sbcFilterTimeoutLock);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcEnableFilterTimeoutChange;
begin
  Dec(sbcFilterTimeoutChangeLock);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcEndReadOrgOverride;
begin
  EndReadOrgOverride;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcFilterAddCustom(aFilter   : TnxBaseFilterEngine;
                                             out aFilterID : TnxFilterID;
                                                 aActivated: Boolean);
begin
  if not Assigned(sbcFilter) then begin
    sbcFilter := aFilter;
  end else if sbcFilter is TnxFilterEngineHub then begin
    TnxFilterEngineHub(sbcFilter).AddFilter(aFilter);
  end else begin
    sbcFilter := TnxFilterEngineHub.Create(sbcFilter, aFilter);
  end;
  aFilterID := TnxFilterID(aFilter);
  if aActivated then
    aFilter.ActivateFilter(aFilterID);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcFilterBeginTimeout(aResult: PnxResult; aLongTimeout: Boolean = False);
var
  TimeOutAt: TnxInt64;
begin
  {$IFOPT Q+}
    {$DEFINE LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS OFF}
  {$ENDIF}
  if sbcFilterTimeoutChangeLock < 1 then begin
    if aLongTimeout then
      sbcFilterUntil := nxGetTimeout - 50
    else if sbcFilterTimeout > 0 then begin
      sbcFilterUntil := TnxInt64(GetTickCount64) + TnxInt64(sbcFilterTimeout);
      TimeOutAt := nxGetTimeout - 10;
      if sbcFilterUntil > TimeOutAt then
        sbcFilterUntil := TimeOutAt;
    end else
      sbcFilterUntil := 0;
  end;
  {$IFDEF LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS ON}
    {$UNDEF LocalOverflowCheckOFF}
  {$ENDIF}
  if Assigned(sbcFilter) then
    if (sbcFilterUntil > 0) and Assigned(aResult) then begin
      sbcFilter.kfCheckTimeOut := sbcFilterCheckTimeout;
      sbcFilter.kfResult := aResult;
    end else begin
      sbcFilter.kfCheckTimeOut := nil;
      sbcFilter.kfResult := nil;
    end;
  if Assigned(sbcKeyFilter) then
    if (sbcFilterUntil > 0) and Assigned(aResult) then begin
      sbcKeyFilter.kfCheckTimeOut := sbcFilterCheckTimeout;
      sbcKeyFilter.kfResult := aResult;
    end else begin
      sbcKeyFilter.kfCheckTimeOut := nil;
      sbcKeyFilter.kfResult := nil;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcFilterCheckTimeout(var aResult : TnxResult)
                                                               : Boolean;
var
  TickCount : TnxInt64;
begin
  Result := False;
  TickCount := GetTickCount64;
  if (sbcFilterTimeoutLock > 0) or (sbcFilterUntil = 0) then begin
    if TickCount > nxGetTimeout - 10 then begin
      aResult := DBIERR_NX_GeneralTimeout;
      Result := True;
    end;
  end else
    if TickCount > sbcFilterUntil then begin
      aResult := DBIERR_NX_FilterTimeout;
      Result := True;
    end else if TickCount > nxGetTimeout - 10 then begin
      aResult := DBIERR_NX_GeneralTimeout;
      Result := True;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcFilterEndTimeout;
begin
  if sbcFilterTimeoutChangeLock < 1 then
    sbcFilterUntil := 0;
  if Assigned(sbcKeyFilter) then begin
    sbcKeyFilter.kfCheckTimeOut := nil;
    sbcKeyFilter.kfResult := nil;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcGetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                                 aSize     : TnxWord32)
                                                           : TnxResult;
begin
  Result := DBIERR_NOTSUPPORTED;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcGetReadOnlyResult: TnxResult;
begin
  Result := sbcReadOnlyResult;
  if Assigned(sbcReadOnlyResultMessage) then
    Result := EnxBaseException.nxSetMessage(Result, sbcReadOnlyResultMessage);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcGetWriteOnlyResult: TnxResult;
begin
  Result := sbcWriteOnlyResult;
  if Assigned(sbcWriteOnlyResultMessage) then
    Result := EnxBaseException.nxSetMessage(Result, sbcWriteOnlyResultMessage);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcIsSystemTable: Boolean;
var
  lFullName : string;
begin
  lFullName := FullName;
  Result := (Length(lFullName)>0) and (lFullName[1]='$');
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcGetStats: TnxServerTableStats;
begin
  Finalize(Result);
  FillChar(Result, SizeOf(Result), 0);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcKeyFilterAddCustom(aKeyFilter   : TnxBaseFilterDescriptor;
                                               out aKeyFilterID : TnxKeyFilterID;
                                                   aActivated   : Boolean)
                                                                : TnxResult;
var
  Filter : TnxBaseFilterEngine;
begin
  Result := DBIERR_NONE;
  Filter := TnxBaseFilterEngine.CreateFor(aKeyFilter, sbcGetKeyFieldsSource);
  try
    sbcKeyFilterAddCustomEngine(Filter, aKeyFilterID, aActivated);
  except
    nxFreeAndNil(Filter);
    raise;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcKeyFilterAddCustomEngine(aKeyFilter   : TnxBaseFilterEngine;
                                                      out aKeyFilterID : TnxKeyFilterID;
                                                          aActivated   : Boolean);
begin
  if not Assigned(sbcKeyFilter) then begin
    sbcKeyFilter := aKeyFilter;
  end else if sbcKeyFilter is TnxFilterEngineHub then begin
    TnxFilterEngineHub(sbcKeyFilter).AddFilter(aKeyFilter);
  end else begin
    sbcKeyFilter := TnxFilterEngineHub.Create(sbcKeyFilter, aKeyFilter);
  end;
  aKeyFilterID := TnxKeyFilterID(aKeyFilter);
  if aActivated then
    aKeyFilter.ActivateFilter(aKeyFilterID);
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcKeyFilterDeactivate(aKeyFilterID : TnxKeyFilterID)
                                                                 : TnxResult;
begin
  if Assigned(sbcKeyFilter) then
    Result := sbcKeyFilter.DeactivateFilter(aKeyFilterID)
  else
    Result := DBIERR_NOSUCHFILTER;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcLockError(aResult: TnxResult): TnxResult;
var
  s, t: string;
begin
  s := nxcOrgMessageMarker;
  if sbcLockFailureReason.Count > 0 then begin
    if sbcLockFailureReason.SameSession then
      aResult := DBIERR_GROUPLOCKCONFLICT;

    s := s + #13#13 + sbcLockFailureReason.Text;
    sbcLockFailureReason.Clear;
  end;

  t := acGetFullName;
  s := s + #13#13 + ' Tabla : ' + t + nxeCustomInfo('TableName', t);  //..

  Result := EnxBaseException.nxSetMessage(aResult, s);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcMarkReadonly;
begin
  sbcIsReadOnly := True;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcRecordGetBatch(aCutoffSize : Integer;
                                               aOptions    : TnxRecordGetBatchExOptions;
                                           var aAccess     : TnxBatchStreamAccess;
                                               aMaxRecords : Integer = -1;
                                               aForward    : Boolean = True)
                                                           : TnxResult;
var
  lStream        : TnxMemoryStream;

  Error          : TnxResult;
  Count          : Integer;
  Size           : Integer;
  OrgSize        : TnxWord32;
  Offset         : TnxWord32;
  RecordLength   : TnxWord32;
  BookmarkLength : TnxWord32;
begin
  if aMaxRecords < 1 then
    aMaxRecords := High(Integer);
  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then with sbcTransContext do try
      if gboBlobs in aOptions then
        if not Assigned(acSFI.sfiBlobFields) then
          Exclude(aOptions, gboBlobs);

      if not Assigned(aAccess) then
        aAccess := CreateBatchStreamAccess(nil, aOptions)
      else
        aAccess.Clear;

      lStream := aAccess.Stream;
      if aCutoffSize = MaxInt then
        lStream.Capacity := 512*1024
      else
        lStream.Capacity := aCutoffSize;

      RecordLength := TableDescriptor.FieldsDescriptor.RecordLength;

      Error := DBIERR_NONE;
      lStream.WriteBuffer(Error, SizeOf(Error));
      Count := 0;
      lStream.WriteBuffer(Count, SizeOf(Count));

      OrgSize := RecordLength;
      Error := sbcGetBookmarkSize(BookmarkLength);
      if gboBookmarks in aOptions then begin
        Inc(OrgSize, BookmarkLength);
      end else begin
        BookmarkLength := 0;
        Error := DBIERR_NONE;
      end;

      if Error = DBIERR_NONE then
        if gboSetToBeginOrEnd in aOptions then
          if aForward then
            sbcSetToBegin
          else
            sbcSetToEnd;

      if gboUseFilterTimeout in aOptions then begin
        if Assigned(sbcFilter) or Assigned(sbcKeyFilter) then
          sbcFilterBeginTimeout(@Result);
        sbcDisableFilterTimeoutChange;
      end;
      try
        while (Error = DBIERR_NONE) and (lStream.Size < aCutoffSize) and (Count < aMaxRecords) do begin
          Size := OrgSize;
          lStream.WriteBuffer(Size, SizeOf(Size));
          OffSet := lStream.Position;
          lStream.Size := lStream.Size + Size;

          if aForward then
            Error := sbcRecordGetNext(nxltNoLock, PnxRecordBuffer(@lStream.ByteArray[Offset]))
          else
            Error := sbcRecordGetPrior(nxltNoLock, PnxRecordBuffer(@lStream.ByteArray[Offset]));

          if Error = DBIERR_NONE then
            if BookmarkLength > 0 then
              if acsIsCache in acStates then
                Error := sbcGetBookmarkCache(@lStream.ByteArray[Offset + RecordLength], BookmarkLength)
              else
                Error := sbcGetBookmark(@lStream.ByteArray[Offset + RecordLength], BookmarkLength);

          if Error = DBIERR_NONE then
            if gboBlobs in aOptions then begin
              Error := sbcCopyBlobsToBatchStream(Size, Offset, lStream, gboBlobNrs in aOptions, gboBlobsOnlyMarked in aOptions);

              if TnxWord32(Size) <> OrgSize then begin
                lStream.Position  := OffSet - SizeOf(Size);
                lStream.WriteBuffer(Size, SizeOf(Size));
              end;
            end;

          if Error = DBIERR_NONE then begin
            lStream.Position := lStream.Size;
            Inc(Count);
          end else
            lStream.Size := Offset;
        end;
      finally;
        if gboUseFilterTimeout in aOptions then begin
          sbcEnableFilterTimeoutChange;
          sbcFilterEndTimeout;
        end;
      end;

      if (Error = DBIERR_NX_FilterTimeout) and (Count = 0) then
        Result := Error;

      lStream.Position := 0;
      lStream.WriteBuffer(Error, SizeOf(Error));
      lStream.WriteBuffer(Count, SizeOf(Count));
    finally
      sbcEndContentLock;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Assigned(aAccess) then
    aAccess.Reset;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcRegisterInResultSetCache(const aSourceCursors : array of TnxServerBaseCursor;
                                                         const aOnEvict       : TnxCacheHandleNotify)
                                                                              : TnxBaseResultSetCacheHandle;
begin
  Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcRenameField(aFieldNo : Integer;
                                      const aNewName : string)
                                                     : TnxResult;
begin
  Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsSIsNotSupportedByS, ['sbcRenameField', ClassName]);
end;
{------------------------------------------------------------------------------}
procedure TnxServerBaseCursor.sbcRequestClose;
var
  PrevFlag  : PLongBool;
  Destroyed : LongBool;
begin
  if asoDestroying then
    Exit;
  Destroyed := False;
  if Assigned(sbcOnRequestCloseLock) then begin
    PrevFlag := asoDestroyFlag;
    asoDestroyFlag := @Destroyed;
    sbcOnRequestCloseLock.Lock;
    try
      if asoDestroying then
        Exit;
      if Assigned(sbcOnRequestClose) then
        sbcOnRequestClose.RequestClose(Self);
    finally
      if not Destroyed then begin
        asoDestroyFlag := PrevFlag;
        sbcOnRequestCloseLock.UnLock;
      end else
        if Assigned(PrevFlag) then
          PrevFlag^ := True;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcCopyBlobsToBatchStream(var aSize       : Integer;
                                                     const aOffset     : TnxWord32;
                                                           aStream     : TnxMemoryStream;
                                                           aAddBlobNr  : Boolean;
                                                           aOnlyMarked : Boolean)
                                                                       : TnxResult;
var
  BlobIdx     : Integer;
  BlobFldIdx  : Integer;
  BlobOffset  : TnxWord32;
  BlobNr      : TnxBlobNr;
  RecID       : TnxRecID;
  NewBlobNr   : TnxBlobNr;
  IsNull      : Boolean;
  BlobLength  : TnxWord32;
  NewPosition : TnxMemSize;
begin
  Result := DBIERR_NONE;
  if aOnlyMarked and not Assigned(acMarkedBlobs) then
    Exit;

  with TableDescriptor.FieldsDescriptor do
    for BlobIdx := Low(acSFI.sfiBlobFields) to High(acSFI.sfiBlobFields) do
      if not aOnlyMarked or
         nxIsBitSet(Pointer(acMarkedBlobs), BlobIdx)
      then begin
        BlobFldIdx := acSFI.sfiBlobFields[BlobIdx];
        with FieldDescriptor[BlobFldIdx] do begin
          GetRecordField(BlobFldIdx, @aStream.ByteArray[aOffset], IsNull, @BlobNr);
          if not IsNull then
            if BlobNr = 0 then begin
              { fix up invalid blob fields }
              IsNull := True;
              SetRecordFieldNull(BlobFldIdx, @aStream.ByteArray[aOffset], True);
            end;
          if not IsNull then begin
            RecID := acGetRecID(@aStream.ByteArray[aOffset]);
            Result := sbcBlobGetLength(RecID, BlobFldIdx, BlobNr, BlobLength, False, nil);
            if (Result = DBIERR_NONE) and (BlobLength < 1) then
              SetRecordFieldNull(BlobFldIdx, PnxRecordBuffer(@aStream.ByteArray[aOffset]), True)
            else begin
              aStream.Position := aStream.Size;
              Int64(NewBlobNr) := aStream.Position;
              if Result <> DBIERR_NONE then
                BlobLength := SizeOf(Result) or $80000000;
              aStream.WriteBuffer(BlobLength, SizeOf(BlobLength));
              BlobOffset := aStream.Position;
              if Result <> DBIERR_NONE then begin
                aStream.WriteBuffer(Result, SizeOf(Result));
                Result := DBIERR_NONE;
                BlobLength := BlobLength and not $80000000;
              end else begin
                if acoSkipReadingBlobDataForBatch in acOptions then begin
                  NewPosition := aStream.Position + BlobLength;
                  if aStream.Size < NewPosition then
                    aStream.Size := NewPosition;
                  aStream.Position := NewPosition;
                end else try
                  Result := sbcBlobRead(RecID, BlobFldIdx, BlobNr, 0, BlobLength, aStream, False, nil);
                except
                  on E : Exception do
                    Result := asoConvertException(E);
                end;
              end;
              if (aStream.Position - BlobOffset) <> BlobLength then
                Result := DBIERR_READERR;
              if Result = DBIERR_NONE then begin
                if aAddBlobNr then begin
                  aStream.Write(BlobNr, SizeOf(BlobNr));
                  Inc(aSize, SizeOf(BlobNr));
                end;
                SetRecordField(BlobFldIdx, PnxRecordBuffer(@aStream.ByteArray[aOffset]), @NewBlobNr);
                Inc(aSize, BlobLength + SizeOf(BlobLength));
              end else begin
                Result := DBIERR_NONE;
                SetRecordFieldNull(BlobFldIdx, PnxRecordBuffer(@aStream.ByteArray[aOffset]), True);
                aStream.Position := BlobOffset - SizeOf(TnxWord32);
                aStream.Size := aStream.Position;
              end;
            end;
          end;
        end;
        if Result <> DBIERR_NONE then
          Break;
      end;
end;
{------------------------------------------------------------------------------}
type
  PnxFilterIteratorData = ^TnxFilterIteratorData;
  TnxFilterIteratorData = record
    fidFilter    : TnxBaseFilterEngine;
    fidKeyFilter : TnxBaseFilterEngine;
    fidData      : PnxRecordBuffer;
  end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcSetToFilterKeyIterator(aCookie : Pointer;
                                                       aRefNr  : TnxRefNr;
                                                       aKey    : PnxKeyBuffer)
                                                               : TnxKeyIteratorResult;
begin
  Result := kirContinue;
  with PnxFilterIteratorData(aCookie)^ do
    if Assigned(fidKeyFilter) and not fidKeyFilter.MatchesBuffer(aKey) then
      Result := kirSkipKey;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.sbcSetToFilterRecIterator(aCookie : Pointer;
                                                       aRefNr  : TnxRefNr;
                                                       aRecord : PnxRecordBuffer)
                                                               : TnxRecordIteratorResult;
begin
  Result := rirStop;
  with PnxFilterIteratorData(aCookie)^ do
    if Assigned(fidFilter) and not fidFilter.MatchesBuffer(aRecord) then
      Result := rirContinue;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToBegin: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      sbcSetToBegin;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToBookmark(aBookmark : PnxBookmarkBuffer;
                                           aSize     : TnxWord32)
                                                     : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcSetToBookmark(aBookmark, aSize, False);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToCacheBookmark(aBookmark : PnxBookmarkBuffer;
                                                aSize     : TnxWord32)
                                                          : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcSetToBookmark(aBookmark, aSize, True);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToCursor(aCursor : TnxAbstractCursor)
                                                  : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  if aCursor = Self then
    Exit;
  atoLock.Lock;
  try
    try
      Result := sbcSetToCursor(aCursor);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToEnd: TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  atoLock.Lock;
  try
    try
      sbcSetToEnd;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToFilter(aFilter    : TnxBaseFilterDescriptor;
                                         aKeyFilter : TnxBaseFilterDescriptor;
                                         aForward   : TnxBoolean)
                                                    : TnxResult;
var
  Filter    : TnxBaseFilterEngine;
  KeyFilter : TnxBaseFilterEngine;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    if Assigned(aFilter) then
      Filter := TnxBaseFilterEngine.CreateFor(aFilter, Self)
    else
      Filter := nil;
    try
      if Assigned(Filter) then
        Filter.ActivateFilter(0);
      if Assigned(aKeyFilter) then
        KeyFilter := TnxBaseFilterEngine.CreateFor(aKeyFilter, sbcGetKeyFieldsSource)
      else
        KeyFilter := nil;
      try
        if Assigned(KeyFilter) then
          KeyFilter.ActivateFilter(0);
        Result := sbcSetToFilter(Filter, KeyFilter, aForward);
      finally
        nxFreeAndNil(KeyFilter);
      end;
    finally
      nxFreeAndNil(Filter);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SetToKey(aSearchAction : TnxSearchKeyAction;
                                      aFieldCount   : Integer;
                                      aPartialLen   : Integer;
                                      aDirectKey    : Boolean;
                                      aKeyData      : PnxKeyOrRecordBuffer)
                                                    : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcSetToKey(aSearchAction, aFieldCount, aPartialLen,
        aDirectKey, aKeyData);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.SwitchToIndex(const aIndexName : string;
                                                 aIndexID   : Integer;
                                                 aPosnOnRec : TnxPosnOnRec)
                                                            : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcSwitchToIndex(aIndexName, aIndexID, aPosnOnRec);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableIsLocked(aLockType    : TnxLockType;
                                       out aLockPresent : TnxLockPresent)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  Result := DBIERR_NONE;
  aLockPresent := lpNotAtAll;
  atoLock.Lock;
  try
    try
      aLockPresent := sbcTableIsLocked(aLockType);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableLockAcquire(aLockType : TnxLockType)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcTableLockAcquire(aLockType);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableLockRelease(aLockType : TnxLockType;
                                              aAllLocks : Boolean)
                                                        : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcTableLockRelease(aLockType, aAllLocks);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableStreamDelete(const aName : string)
                                                           : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      Result := sbcTableStreamDelete(aName, False);
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableStreamGetList(aStreams : TStrings)
                                                         : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcTableStreamGetList(aStreams, False);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableStreamRead(const aName   : string;
                                                   aStream : TStream)
                                                           : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := sbcTableStreamRead(aName, aStream, False);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TableStreamWrite(const aName   : string;
                                                    aStream : TStream)
                                                            : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      Result := sbcTableStreamWrite(aName, aStream, False);
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerBaseCursor.TransContextSet(aTransContext: TnxAbstractTransContext): TnxResult;
begin
  Result := DBIERR_NONE;
  if aTransContext = acTransContext then
    Exit;
  if Assigned(aTransContext) and (aTransContext.Session <> Session) then begin
    Result := DBIERR_NOTSAMESESSION;
    Exit;
  end;

  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := sbcTransContextSet(aTransContext);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{==============================================================================}



{===TnxServerTableCursor=======================================================}
function TnxServerTableCursor.ac_GetDictionary: TnxDataDictionary;
begin
  Result := stcTable.sbtRoot.srtDictionary;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.ascGetBlobCacheInfos(const aRecID : TnxRecID;
                                                     out aBCIs  : TnxBlobCacheInfos)
                                                                : TnxResult;
begin
  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try
        Result := stcBlobHandler.GetBlobCacheInfos(sbcTrans^, aRecID, aBCIs);
      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.ascSetBlobCacheFlushed(const aRecID     : TnxRecID;
                                                           aFieldNo   : TnxInt32;
                                                     const aBlobNr    : TnxBlobNr;
                                                           aNewBlobNr : PnxBlobNr = nil)
                                                                      : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobCacheFlushed(sbcTrans^, aRecID, aFieldNo,
              aBlobNr, aNewBlobNr);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.BlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                                 var aReply   : TnxBlobBatchReply)
                                                              : TnxResult;
begin
  if not bbrqIsValid(aRequest) then
    Result := DBIERR_NONE
  else if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := stcBlobBatchProcess(aRequest, aReply);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.BuildKey(aRecord       : PnxRecordBuffer;
                                       aKey          : PnxKeyBuffer;
                                       aIgnoreFilter : Boolean)
                                                     : TnxResult;
begin
  if not Assigned(stcIndexEngine) then begin
    Result := DBIERR_NOASSOCINDEX;
    Exit;
  end;

  Result := stcIndexEngine.KeyEngine.BuildKey(aRecord, aKey, 0, aIgnoreFilter);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.acGetAliasName: string;
begin
  if Database.GetAlias(Result) <> DBIERR_NONE then
    Result := '';
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.acGetFullName: string;
begin
  Result := Table.FullName;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.acGetTableDescriptor: TnxBaseTableDescriptor;
begin
  Result := stcTable.sbtTableDescriptor;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.ascGetAbstractBaseTable: TnxAbstractServerBaseTable;
begin
  Result := stcTable;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.ContainsLSNRefNr(var aLSN   : TnxLSN;
                                               var aRefNr : TnxRefNr)
                                                          : TnxResult;
begin
  if (aLSN = 0) and (aRefNr = 0) then
    Result := DBIERR_NOCURRREC
  else if
    ((aLSN <> 0) and Assigned(stcLSNIndexPath)) or
    ((aRefNr <> 0) and Assigned(stcRefNrIndexPath))
  then begin
    nxSetTimeout(atoTimeout);
    atoLock.Lock;
    try
      try
        Result := stcContainsLSNRefNr(aLSN, aRefNr);
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      atoLock.Unlock(Result);
    end;
  end else
    Result := DBIERR_NOASSOCINDEX;
end;
{------------------------------------------------------------------------------}
constructor TnxServerTableCursor.Create(aDelayInformMonitors : Boolean;
                                        aDatabase            : TnxServerDatabase;
                                        aTransContext        : TnxAbstractTransContext;
                                        aTable               : TnxServerBaseTable;
                                        aTimeout             : TnxWord32;
                                        aOpenMode            : TnxOpenMode;
                                        aShareMode           : TnxShareMode;
                                        aIndexName           : string;
                                        aIndexID             : Integer;
                                        aBlobCache           : Boolean;
                                        aInternal            : Boolean);
var
  DefaultIndex : Integer;
  CacheState   : TnxTableCachingState;
begin
  sbcForRecover := sbcForRecover or aTable.sbtForRecover or _ForRecover;

  if aInternal then
    BeginIgnoreSecurity;

  DefaultIndex := -1;

  with PnxInt64Rec(@stcSelfRefNr)^ do begin
    iHigh := High(iHigh);
    iLow := TnxWord32(Self);
  end;

  stcTable := aTable;
  if stcTable.IsCache then
    Include(acStates, acsIsCache);

  if acsIsCache in acStates then
    CacheState := tcsIsCache
  else
    CacheState := tcsCacheable;

  if TableDescriptor.IsCacheable(acCacheableInfo, CacheState) then
    Include(acStates, acsIsCacheable);

  if (acsIsCache in acStates) and not (acsIsCacheable in acStates) then
    raise EnxServerEngineException.nxCreate(DBIERR_NA, 'Cache Table is not Cacheable');

  { if the table is readonly }
  if stcTable.sbtRoot.srtOpenMode = omReadOnly then
    {force cursor to be readonly too}
    aOpenMode := omReadOnly;

  stcShareMode := aShareMode;
  sbcRecordBuffer := stcTable.sbtRecordAllocator.Alloc;

  acSetupDescriptorDependentFields;

  inherited Create(aDelayInformMonitors, aDatabase, aTransContext, aTimeout, aOpenMode);

  with stcTable, aDatabase do begin
    if Assigned(sbtIndicesEngine) then begin
      if sbtIndicesEngine.NLSVersionChanged then begin
        sbcIsReadOnly := True;
        sbcReadOnlyResult := DBIERR_TABLELEVEL;
        sbcReadOnlyResultMessage := @rsCurrentNLSVersionTableReadOnly;
{$IFDEF EXTENDED_IS_DOUBLE_ALIAS}
      end else if sbtIndicesEngine.ContainsExtended then begin
        sbcIsReadOnly := True;
        sbcReadOnlyResult := DBIERR_TABLELEVEL;
        sbcReadOnlyResultMessage := @rsContainsExtendedTableReadOnly;
{$ENDIF}
      end;
    end;
    if Assigned(sbtInternalIndicesEngine) then begin
      if sbtInternalIndicesEngine.NLSVersionChanged then begin
        sbcIsReadOnly := True;
        sbcReadOnlyResult := DBIERR_TABLELEVEL;
        sbcReadOnlyResultMessage := @rsCurrentNLSVersionTableReadOnly;
{$IFDEF EXTENDED_IS_DOUBLE_ALIAS}
      end else if sbtInternalIndicesEngine.ContainsExtended then begin
        sbcIsReadOnly := True;
        sbcReadOnlyResult := DBIERR_TABLELEVEL;
        sbcReadOnlyResultMessage := @rsContainsExtendedTableReadOnly;
{$ENDIF}
      end;
    end;

    if Assigned(sbtBlobEngine) and Assigned(sbtSFI.sfiBlobFields) then
      if acsIsCache in acStates then
        stcBlobHandler := TnxCachedBlobHandler.Create
          (Self, sbtBlobEngine, stcGetBlobLinkHandler, sbtTableDescriptor.FieldsDescriptor)
      else if aBlobCache and not sbcForRecover then
        stcBlobHandler := TnxCachingBlobHandler.Create
          (Self, sbtBlobEngine, stcGetBlobLinkHandler, sbtTableDescriptor.FieldsDescriptor)
      else
        stcBlobHandler := TnxPassthroughBlobHandler.Create
          (Self, sbtBlobEngine, stcGetBlobLinkHandler, sbtTableDescriptor.FieldsDescriptor)
    else
      stcBlobHandler := TnxNullBlobHandler.Create(Self);

    if not ((acsIsCache in acStates) or sbcForRecover) then begin
      stcFulltextEngine :=
        TnxBaseFulltextCursorEngine.CreateFor(sbtFulltextEngine, Self);
      stcRefIntEngine :=
        TnxBaseRefIntegrityEngine.CreateFor(TableDescriptor, Self);
    end;

    if Assigned(sbtIndicesEngine) then
      DefaultIndex := (sbtIndicesEngine.Descriptor as TnxMainIndicesDescriptor).DefaultIndex;
  end;

  if aIndexID < 0 then
    aIndexID := DefaultIndex;

  stcAddToTable;
  if
    sbcSwitchToIndex(aIndexName, aIndexID, porFalse) <> DBIERR_NONE
  then if
    sbcSwitchToIndex('', DefaultIndex, porFalse) <> DBIERR_NONE
  then
    sbcSwitchToIndex('', -1, porFalse);

  if Assigned(stcTable.sbtIndicesEngine) then begin
    stcSeqAccessIndexEngine := stcTable.sbtIndicesEngine.SeqIndexEngine;
    if Assigned(stcSeqAccessIndexEngine) then
      stcSeqAccessIndexPath := stcSeqAccessIndexEngine.CreateIndexPath;

    if (acCacheableInfo.ciModifyLSNIndex >= 0) then begin
      stcLSNIndexEngine := stcTable.sbtIndicesEngine.Indices[acCacheableInfo.ciModifyLSNIndex];
      if Assigned(stcLSNIndexEngine) then
        stcLSNIndexPath := stcLSNIndexEngine.CreateIndexPath;
    end;
    stcRefNrIndexEngine := stcTable.sbtIndicesEngine.SeqIndexEngine;
    if Assigned(stcRefNrIndexEngine) then
      stcRefNrIndexPath := stcRefNrIndexEngine.CreateIndexPath;
  end;

  if Assigned(stcTable.sbtInternalIndicesEngine) then begin
    if not (acsIsCache in acStates) then begin
      { don't need a graveyard in a cache table }
      if (acCacheableInfo.ciGraveyardLSNIndex >= 0) then begin
        stcGraveyardLSNIndexEngine := stcTable.sbtInternalIndicesEngine.Indices[acCacheableInfo.ciGraveyardLSNIndex];
        if Assigned(stcGraveyardLSNIndexEngine) then
          stcGraveyardLSNIndexPath := stcGraveyardLSNIndexEngine.CreateIndexPath;
      end;
      if (acCacheableInfo.ciGraveyardRefNrIndex >= 0) then begin
        stcGraveyardRefNrIndexEngine := stcTable.sbtInternalIndicesEngine.Indices[acCacheableInfo.ciGraveyardRefNrIndex];
        if Assigned(stcGraveyardRefNrIndexEngine) then
          stcGraveyardRefNrIndexPath := stcGraveyardRefNrIndexEngine.CreateIndexPath;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.CreateInstanceFor(const aName        : string;
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
  if SameText(Left, '<Table>') then
    Result := stcTable.CreateInstanceFor(Right, aClassID, aOuter, aInterfaceID, aInterface)
  else
    Result := inherited CreateInstanceFor(aName, aClassID, aOuter, aInterfaceID, aInterface)
end;
{------------------------------------------------------------------------------}
constructor TnxServerTableCursor.CreateResultSet(aDatabase     : TnxServerDatabase;
                                                 aTransContext : TnxAbstractTransContext;
                                                 aDictionary   : TnxDataDictionary;
                                                 aTimeout      : TnxWord32);
var
  i         : Integer;
  Table     : TnxServerRootTable;
  Result    : TnxResult;
begin
  with aDatabase.sdFolder do begin
    sfTablesPadlock.Lock;
    try
      with aDictionary, FilesDescriptor do
        for i := 0 to Pred(FileCount) do
          FileDescriptor[i].BlockSize := nxbs4k;

      Result := sfTableBuildPrim('', '', False, aDictionary, tsTempUnnamed, Table);
      if Result <> DBIERR_NONE then
        raise EnxServerEngineException.nxCreate(Result);

      IsUnnamed := True;
      Self.Create(True, aDatabase, aTransContext, Table, aTimeout, omReadWrite, smExclusive,'', -1, False, True);
    finally
      sfTablesPadlock.Unlock;
    end;
  end;
  if esoDelayInformMonitors then begin
    //delayed bseInformMonitorsCreated until after sfTablesPadlock.Unlock
    esoDelayInformMonitors := False;
    if esoInformMonitors then
      TnxServerEngine(asoGetServerEngine).bseInformMonitorsCreated(Self);
    // don't call esoNotifyAfterCreate, we are still in Create and esoNotifyAfterCreate will be called
    // in AfterConstruction as normal because esoDelayInformMonitors is already false again
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTableCursor.Destroy;
begin
  Assert(stcInUseCount = 0);

  try
    sbcTaskInfo.Free;
  except end;

  if Assigned(stcTable) and Assigned(stcTable.sbtLocks) then
    stcTable.sbtLocks.ClearAllLocks(Self);

  if Assigned(stcTransLink) then begin
    stcRemoveFromTransLink;
    stcTransLink := nil;
  end;

  inherited;

  if Assigned(stcIndexEngine) and Assigned(stcIndexEngine.KeyEngine) then
    with stcIndexEngine.KeyEngine do begin
      FreeKey(stcKeyBuffer);
      FreeKey(stcRangeStart.riKey);
      FreeKey(stcRangeEnd.riKey);
    end;
  nxFreeAndNil(stcIndexPath);
  nxFreeAndNil(stcSavePath);
  nxFreeAndNil(stcTempPath);

  if Assigned(stcTable) and Assigned(stcTable.sbtRecordAllocator) then begin
    stcTable.sbtRecordAllocator.Dispose(sbcRecordBuffer);
    stcTable.sbtRecordAllocator.Dispose(sbcRecordBuffer2);
  end;

  nxFreeAndNil(stcBlobHandler);
  nxFreeAndNil(stcBlobLinkHandler);
  nxFreeAndNil(stcFulltextEngine);
  nxFreeAndNil(stcRefIntEngine);

  nxFreeAndNil(stcSeqAccessIndexPath);
  nxFreeAndNil(stcLSNIndexPath);
  nxFreeAndNil(stcRefNrIndexPath);
  nxFreeAndNil(stcGraveyardLSNIndexPath);
  nxFreeAndNil(stcGraveyardRefNrIndexPath);

  stcRemoveFromTable;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.esoOptionGetParent(const aName  : string;
                                                   out aValue : string)
                                                              : TnxResult;
begin
  Result := DBIERR_OBJNOTFOUND;
  if Assigned(stcTable) then
    Result := stcTable.esoOptionGetEffective(aName, aValue);
  if Result = DBIERR_OBJNOTFOUND then
    Result := inherited esoOptionGetParent(aName, aValue);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.esoOptionListParent(aList : TStrings)
                                                        : TnxResult;
var
  ParentList: TStringList;
begin
  if Assigned(stcTable) then begin
    Result := stcTable.esoOptionList(aList);

    if Result = DBIERR_NONE then begin
      ParentList := TStringList.Create;
      try
        Result := inherited esoOptionListParent(ParentList);
        if Result = DBIERR_NONE then
          Result := esoOptionListMerge(aList, ParentList);
      finally
        nxFreeAndNil(ParentList);
      end;
    end;
  end else
    Result := inherited esoOptionListParent(aList);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.GetBlobs(aData       : PnxRecordBuffer;
                                       aMarkedOnly : Boolean;
                                   var aBlobCount  : TnxWord16;
                                       aBlobNrs    : PnxBlobNr)
                                                   : TnxResult;
begin
  if acsIsCache in acStates then
    Result := stcGetBlobs(aData, aMarkedOnly, aBlobCount, aBlobNrs)
  else
    Result := inherited GetBlobs(aData, aMarkedOnly, aBlobCount, aBlobNrs);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.GetDeletedRecords(aFromLSN    : TnxLSN;
                                            out aCacheInfos : TnxRecordCacheInfos;
                                                aMaxCount   : Integer = High(Integer);
                                                aCurrentLSN : PnxLSN = nil)
                                                            : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    try
      Result := stcGetDeletedRecords(aFromLSN, aCacheInfos, aMaxCount, aCurrentLSN);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);

  procedure RangeInfoToExceptionData(const aRangeInfo: TnxRangeInfo; const aContainer: InxExceptionDataContainer);
  begin
    with aRangeInfo, aContainer do begin
      AddValue('Valid', riValid);
      AddValue('FieldCount', riFieldCount);
      AddValue('Partitial', riPartitial);
      AddValue('Exclusive', riExclusive);
      if Assigned(riKey) and Assigned(stcIndexEngine) and Assigned(stcIndexEngine.KeyEngine) then
        stcIndexEngine.KeyEngine.KeyAsExceptionData(riKey, AddContainer('Key'));
    end;
  end;

begin
  inherited;
  aContainer.AddValue('Table', stcTable);
  aContainer.AddValue('IndexPath', GetEnumName(TypeInfo(TnxShareMode), Ord(stcShareMode)));

  if Assigned(stcIndexPath) then
    aContainer.AddValue('IndexPath', stcIndexPath)
  else
    aContainer.AddValue('IndexEngine', stcIndexEngine);

  with aContainer.AddContainer('Range') do begin
    RangeInfoToExceptionData(stcRangeStart, AddContainer('Start'));
    RangeInfoToExceptionData(stcRangeEnd, AddContainer('End'));
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.GetNextLSN(var aLSN: TnxLSN): Boolean;
begin
  Result := Assigned(sbcTrans) and Assigned(sbcTrans^);
  if Result then with sbcTrans^ do begin
    aLSN := TransBufferManager.NextLSN;
    if aLSN > btLSN then
      btLSN := aLSN;
    with TnxServerTransactionLevel(btTransLevelsTail) do
      if aLSN > tlLSN then
        tlLSN := btLSN;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.GetRecordCountExAsync(aOption   : TnxRecordCountOption;
                                                out aTaskInfo : TnxAbstractTaskInfo)
                                                              : TnxResult;
var
  RecCount : TnxWord32;
  Locked   : Boolean;

  procedure CompleteDirect;
  begin
    {W1020 here is ok!}
    aTaskInfo := TnxServerDoNothingTaskInfo.Create
      (TnxServerSession(TnxServerDatabase(acDatabase).asoSession), RecCount);
    with TnxServerTaskInfo(aTaskInfo) do begin
      MakeSnapshot(RecCount, RecCount, DBIERR_NONE);
      MarkFinished;
    end;
  end;

  procedure CountRecords;
  begin
    aTaskInfo := TnxServerGetRecCountTaskInfo.Create(aOption, RecCount, Self);
    try
      TnxServerTaskThread.Create(TnxServerGetRecCountTaskInfo(aTaskInfo));
      TnxServerGetRecCountTaskInfo(aTaskInfo).stiStartEvt.WaitForQuietly(2000);
    except
      nxFreeAndNil(aTaskInfo);
      raise;
    end;
  end;

begin
  aTaskInfo := nil;
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  Locked := True;
  try
    try
      if sbcIsWriteOnly then begin
        Result := sbcGetWriteOnlyResult;
        RecCount := 0;
        CompleteDirect;
      end else begin
        Result := sbcBeginContentLock(False, False);
        if Result = DBIERR_NONE then
          with sbcTransContext, stcTable do try
            if (aOption > rcoTotalRecordCount) and Assigned(stcIndexEngine) then begin
              stcIndexEngine.GetKeyCount(sbcTrans^, RecCount);

              if (aOption > rcoTotalKeyCount) and (stcRangeStart.riValid or stcRangeEnd.riValid or
                (Assigned(sbcFilter) and sbcFilter.Active) or
                (Assigned(sbcKeyFilter) and sbcKeyFilter.Active)) then begin
                try
                  atoLock.Unlock(Result);
                finally
                  Locked := False;
                end;
                CountRecords;
              end else
                CompleteDirect;
            end else begin
              sbtRecordEngine.GetRecordCount(sbcTrans^, RecCount);
              if (aOption > rcoRangedKeyCount) and
                ((Assigned(sbcFilter) and sbcFilter.Active) or
                (Assigned(sbcKeyFilter) and sbcKeyFilter.Active)) then begin
                try
                  atoLock.Unlock(Result);
                finally
                  Locked := False;
                end;
                CountRecords;
              end else
                CompleteDirect;
            end;
          finally
            sbcEndContentLock;
          end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    if Locked then
      atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.KeyToRecord(aKey    : PnxKeyBuffer;
                                          aRecord : PnxRecordBuffer)
                                                  : TnxResult;
begin
  if not Assigned(stcIndexEngine) then begin
    Result := DBIERR_NOASSOCINDEX;
    Exit;
  end;

  Result := stcIndexEngine.KeyEngine.KeyToRecord(aKey, aRecord);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.NotifyExtenders(aAction : TnxEngineAction;
                                              aBefore : Boolean;
                                        const aArgs   : array of const)
                                                      : TnxResult;
begin
  if Assigned(stcRefIntEngine) then begin
    nxLockTimeout;
    try
      Result := stcRefIntEngine.Notify(aAction, aBefore, aArgs);
    except
      on E : Exception do
        Result := asoConvertException(E);
    end;
    nxUnlockTimeout;
  end else
    Result := DBIERR_NONE;

  if Result = DBIERR_NONE then
    Result := inherited NotifyExtenders(aAction, aBefore, aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.PrepareDestroy;
begin
  inherited;
  nxFreeAndNil(stcBlobHandler);
  nxFreeAndNil(stcFulltextEngine);
  nxFreeAndNil(stcRefIntEngine);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.RestorePath: TnxResult;
begin
  if Assigned(stcSavePath) then begin
    nxFreeAndNil(stcTempPath);
    stcTempPath := stcIndexPath;
    stcIndexPath := stcSavePath;
    stcSavePath := nil;
    Result := DBIERR_NONE;
  end else
    Result := DBIERR_NOCURRREC;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sacGetRecordByID(const aRefNr        : TnxRefNr;
                                                     aRecordBuffer : PnxRecordBuffer)
                                                                   : TnxResult;
begin
  Result := IndexPath.SetToRecord(nil, aRefNr);
  stcTable.sbtRecordEngine.ReadRecord(sbcTrans^, aRefNr, aRecordBuffer);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sacGetRefNr: TnxRefNr;
begin
  Result := IndexPath.RefNr;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sacHasKey(aIndex: Integer; aValue: Variant): Boolean;
begin
  Result := False;
  try
    SetFieldAsVariantSelf(sbcRecordBuffer, aIndex, aValue);
  except
    Exit;
  end;
  if stcIndexEngine.KeyEngine.BuildKey(sbcRecordBuffer, stcKeyBuffer, 0, True) = DBIERR_NONE then
    Result:= stcIndexEngine.FindKey(sbcTrans^, stcKeyBuffer^, 1, 0, 0, stcIndexPath, skaAnyEqual, nil);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sacSetRefNr(const aRefNr: TnxRefNr);
begin
  IndexPath.SetToRecord(nil, aRefNr);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.SavePath: TnxResult;
begin
  if not Assigned(stcSavePath) then
    stcSavePath := LockedExchange(Pointer(stcTempPath), nil);

  if not Assigned(stcSavePath) then
    stcSavePath := stcIndexPath.Duplicate
  else
    stcSavePath.Assign(stcIndexPath);

  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcAutoIncGet : TnxWord32;
begin
  with sbcTransContext, stcTable do
    if Assigned(sbtAutoIncEngine) then
      Result := sbtAutoIncEngine.ReadAutoIncValue(sbcTrans^)
    else
      Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcAutoIncSet(aAutoInc : TnxWord32)
                                                     : TnxResult;
var
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          if Assigned(sbtAutoIncEngine) then
            sbtAutoIncEngine.SetAutoIncValue(sbcTrans^, aAutoInc)
          else
            Result := EnxBaseException.nxSetMessage(DBIERR_NOTSUPPORTED, @rsAutoIncSetNotSupported);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcAutoIncSetDirect(aAutoInc: TnxWord32);
begin
  with sbcTransContext, stcTable do
    if Assigned(sbtAutoIncEngine) then
      sbtAutoIncEngine.SetAutoIncValue(sbcTrans^, aAutoInc);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBeginContentLock(aExclusive   : Boolean;
                                                  aConditional : Boolean;
                                                  aInternal    : Boolean)
                                                               : TnxResult;
var
  NewLink : TnxServerTransactionLevelTableLink;
  Index   : Integer;
begin
  if (sbcIsReadOnly and aExclusive) and not aInternal then begin
    {never allow an exclusive transaction lock for a read-only cursor}
    Result := sbcGetReadOnlyResult;
    Exit;
  end;

  try
    if not Assigned(stcTransLink) then
      with sbcTransContext do
        if Assigned(sbcTrans^) then begin
          with sbcTrans^.stTableLinks do
            if Find(stcTable.sbtRoot.srtFolder.sfPath + '\' + stcTable.sbtRoot.srtName, Index) then begin
              stcTransLink := TnxServerTransactionLevelTableLink(Objects[Index]);
              stcAddToTransLink;
            end;
        end else begin
          if aExclusive then
            Result := DBIERR_NOACTIVETRAN
          else begin
            if stcShareMode <> smExclusive then
              stcTable.sbtRoot.srtContentPortal.BeginRead;
            Result := DBIERR_NONE;
          end;
          Exit;
        end;
    if Assigned(stcTransLink) then begin
      Result := stcTransLink.ttlTransactionLevel.tlTransaction.CheckState;
      if Result <> DBIERR_NONE then
        Exit;

      if aExclusive and (not stcTransLink.ttlExclusive) then begin
        if stcTransLink.ttlSnapshot then
          Result := DBIERR_TABLEREADONLY
        else if Assigned(stcTransLink.ttlConvertTo) then begin
          stcRemoveFromTransLink;
          stcTransLink := stcTransLink.ttlConvertTo;
          stcAddToTransLink;
          Result := DBIERR_NONE;
        end else
          with stcTable.sbtRoot do begin
            srtTransLinksPadlock.Lock;
            try
              if (srtTransLinksGrantedHead = stcTransLink) and
                (srtTransLinksGrantedTail = stcTransLink) and
                (stcTransLink.ttlTransactionLevel =
                  stcTransLink.ttlTransactionLevel.tlTransaction.TransLevel) then begin
                stcTransLink.ttlExclusive := True;
                Result := DBIERR_NONE;
                Exit;
              end;
              if Assigned(srtTransLinksPendingUpgrade) then begin
                Result := DBIERR_DEADLOCK;
                stcTransLink.ttlTransactionLevel.stlDeadlockDetected;
                Exit;
              end;
              NewLink := TnxServerTransactionLevelTableLink.Create(
                stcTransLink.ttlTransactionLevel,
                stcTable.sbtRoot,
                True,
                stcTransLink,
                sbcLockFailureReason);
              if (NewLink.ttlState in [ttlsPending, ttlsPendingUpgrade]) and not aConditional then
                NewLink.ttlEvent := TnxEvent.Create;
            finally
              srtTransLinksPadlock.Unlock;
            end;

            if not Assigned(NewLink.ttlEvent) then begin
              if NewLink.ttlState = ttlsGranted then
                Result := DBIERR_NONE
              else
                Result := DBIERR_LOCKTIMEOUT;
            end else
              Result := NewLink.WaitFor;

            srtTransLinksPadlock.Lock;
            try
              if Result = DBIERR_NONE then begin
                stcRemoveFromTransLink;
                NewLink.ttlReason := nil;
                stcTransLink := NewLink;
                stcAddToTransLink;
              end else begin
                Result := sbcLockError(Result);
                nxFreeAndNil(NewLink);
              end;
            finally
              srtTransLinksPadlock.Unlock;
            end;
          end;
      end;
    end else
      with sbcTransContext do begin
        Result := sbcTrans^.CheckState;
        if Result <> DBIERR_NONE then
          Exit;

        with stcTable.sbtRoot do begin
          srtTransLinksPadlock.Lock;
          try
            NewLink := TnxServerTransactionLevelTableLink.Create(
              TnxServerTransactionLevel(sbcTrans^.btTransLevelsTail),
              stcTable.sbtRoot,
              aExclusive,
              nil,
              sbcLockFailureReason);
            if (NewLink.ttlState in [ttlsPending, ttlsPendingUpgrade]) and not aConditional then
              NewLink.ttlEvent := TnxEvent.Create;
          finally
            srtTransLinksPadlock.Unlock;
          end;

          if not Assigned(NewLink.ttlEvent) then begin
            if NewLink.ttlState = ttlsGranted then
              Result := DBIERR_NONE
            else
              Result := DBIERR_LOCKTIMEOUT;
          end else
            Result := NewLink.WaitFor;

          srtTransLinksPadlock.Lock;
          try
            if Result = DBIERR_NONE then begin
              NewLink.ttlReason := nil;
              stcTransLink := NewLink;
              stcAddToTransLink;
            end else begin
              Result := sbcLockError(Result);
              nxFreeAndNil(NewLink);
            end;
          finally
            srtTransLinksPadlock.Unlock;
          end;
        end;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;

  if Result = DBIERR_NONE then begin
    Assert(Assigned(stcTransLink));
    Assert(stcTransLink.ttlState = ttlsGranted);
    if aExclusive then begin
      Assert(stcTransLink.ttlExclusive);
      Assert(stcTransLink.ttlTablePrev = nil);
      Assert(stcTransLink.ttlTableNext = nil);
      Assert(stcTransLink.ttlTable.srtTransLinksGrantedHead = stcTransLink);
      Assert(stcTransLink.ttlTable.srtTransLinksGrantedTail = stcTransLink);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobAddToCache(const aRecID   : TnxRecID;
                                                      aFieldNo : TnxInt32;
                                                const aBlobNr  : TnxBlobNr;
                                                      aLen     : TnxWord32;
                                                const aBlob    )
                                                               : TnxResult;
var
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin

          Result := stcBlobHandler.BlobAddToCache(sbcTrans^, aRecID, aFieldNo,
            aBlobNr, aLen, aBlob);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobCopyContentPrim(aSrcCursor   : TnxServerBaseCursor;
                                                     aSrcFieldNo  : TnxInt32;
                                               const aBlobNr      : TnxBlobNr;
                                                     aDestFieldNo : TnxInt32;
                                               const aDestBlobNr  : TnxBlobNr;
                                                     aMaxLength   : TnxWord32 = High(TnxWord32))
                                                                  : TnxResult;
var
  Blob      : TnxMemoryStream;
  Len       : TnxWord32;
  Offset    : TnxWord32;
begin
  {!!! redesign for new cursor classes !!!}
  with (aSrcCursor as TnxServerTableCursor), TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do begin
    Offset := 0;
    Result := GetBlobLength(sbcTrans^, aBlobNr,
      stcGetBlobLinkHandler.BlobLinkGetLength, Len);
    if Result <> DBIERR_NONE then
      Exit;
    Len := nxMinW32(aMaxLength, nxMinW32(Len, nxc_NumBLOBBytesToCopy));

    Blob := TnxMemoryStream.Create(Len);
    try
      repeat

        Blob.Position :=  0;

        Result := Read(sbcTrans^, aBlobNr, Offset, nxMinW32(aMaxLength, Len),
          stcGetBlobLinkHandler.BlobLinkRead, Blob);
        if Result <> DBIERR_NONE then
          Exit;

        Blob.Size := Blob.Position;

        if Blob.Position > 0 then begin
          Blob.Position := 0;

          with Self, TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
            Write(sbcTrans^, aDestBlobNr, Offset, Blob.Size, Blob.Memory^);

          Inc(Offset, Blob.Size);
          Dec(aMaxLength, Blob.Size);
        end;

      until (Blob.Size = 0);

      with Self, TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
        Truncate(sbcTrans^, aDestBlobNr, Offset);
    finally
      FreeAndNil(Blob);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobCopyPrim(aSrcCursor   : TnxServerBaseCursor;
                                              aSrcFieldNo  : TnxInt32;
                                        const aBlobNr      : TnxBlobNr;
                                              aDestFieldNo : TnxInt32;
                                          out aDestBlobNr  : TnxBlobNr;
                                              aMaxLength   : TnxWord32 = High(TnxWord32))
                                                           : TnxResult;
var
  Blob      : TnxMemoryStream;

  Len       : TnxWord32;
  Offset    : TnxWord32;
  FileName  : string;
begin
  Result := DBIERR_NONE;

  with (aSrcCursor as TnxServerTableCursor), TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
    if IsFileBlob(sbcTrans^, aBlobNr, FileName) then begin
      with Self, TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
        if aMaxLength = 0 then
          AddBlob(sbcTrans^, aDestBlobNr)
        else begin
          if aMaxLength < High(TnxWord32) then
            raise EnxServerEngineException.nxCreate(DBIERR_READONLYFLD);

          AddFileBlob(sbcTrans^, FileName, aDestBlobNr);
        end;
    end else begin
      Offset := 0;
      Result := GetBlobLength(sbcTrans^, aBlobNr,
        stcGetBlobLinkHandler.BlobLinkGetLength, Len);
      if Result <> DBIERR_NONE then
        Exit;
      Len := nxMinW32(aMaxLength, nxMinW32(Len, nxc_NumBLOBBytesToCopy));

      Blob := TnxMemoryStream.Create(Len);
      try
        { Create the Blob in the destination cursor. }
        with Self, TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
          AddBlob(sbcTrans^, aDestBlobNr);
        repeat
          Blob.Position := 0;

          Result := Read(sbcTrans^, aBlobNr, Offset, nxMinW32(aMaxLength, Len),
            stcGetBlobLinkHandler.BlobLinkRead, Blob);
          if Result <> DBIERR_NONE then
            Exit;

          Blob.Size := Blob.Position;

          if Blob.Position > 0 then begin
            Blob.Position := 0;

            with Self, TnxServerDatabase(acDatabase), stcTable, sbtBlobEngine do
              Write(sbcTrans^, aDestBlobNr, Offset, Blob.Size, Blob.Memory^);

            Inc(Offset, Blob.Size);
            Dec(aMaxLength, Blob.Size);
          end;
        until (Blob.Size = 0);
      finally
        FreeAndNil(Blob);
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobCreate(const aRecID   : TnxRecID;
                                                  aFieldNo : TnxInt32;
                                              out aBlobNr  : TnxBlobNr)
                                                           : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobHandler.BlobCreate(sbcTrans^, aRecID, aFieldNo, aBlobNr);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobCreateFile(const aRecID    : TnxRecID;
                                                      aFieldNo  : TnxInt32;
                                                const aFileName : string;
                                                  out aBlobNr   : TnxBlobNr)
                                                                : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobHandler.BlobCreateFile(sbcTrans^, aRecID, aFieldNo,
            aFileName, aBlobNr);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobCreateLink(const aRecID       : TnxRecID;
                                                      aFieldNo     : TnxInt32;
                                                const aTableName   : string;
                                                const aTableBlobNr : TnxBlobNr;
                                                  out aBlobNr      : TnxBlobNr)
                                                                   : TnxResult;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    Result := sbcBeginContentLock(True, False);
    if Result = DBIERR_NONE then begin
      Result := stcBlobHandler.BlobCreateLink
        (sbcTrans^, aRecID, aFieldNo, aTableName, aTableBlobNr, aBlobNr);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobDelete(const aRecID   : TnxRecID;
                                                  aFieldNo : TnxInt32;
                                            const aBlobNr  : TnxBlobNr)
                                                           : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobDelete(sbcTrans^, aRecID, aFieldNo, aBlobNr);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobFree(const aRecID   : TnxRecID;
                                                aFieldNo : TnxInt32;
                                          const aBlobNr  : TnxBlobNr)
                                                         : TnxResult;

  procedure SetMessage;
  begin
    Result := EnxBaseException.nxSetMessage(DBIERR_BLOBMODIFIED, nxcOrgMessageMarker + ' (BlobFree)');
  end;

var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
  BlobDeleted        : Boolean;
begin
  BlobDeleted := False;

  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);
          if Result = DBIERR_BLOBMODIFIED then
          { unfortunatly, earlier versions of NexusDB misused DBIERR_BLOBMODIFIED
            to report to the client that BlobFree had deleted the blob as it was
            0 size. So we can't use this error code for it's intented purpose of
            reporting that the Blob in the record has changed. By returning
            DBIERR_NX_SEGMENTDELETED, which would have been one of the possible
            outcomes of accessing an invalid/deleted BlobNr before the BlobNr
            verification was introduced in 4.70.05, the client will continue
            to behave correctly. }
            Result := DBIERR_NX_SEGMENTDELETED;

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobFree(sbcTrans^, aRecID, aFieldNo, aBlobNr, BlobDeleted);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;

  if (Result = DBIERR_NONE) and BlobDeleted then
    SetMessage;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobGetLength(const aRecID     : TnxRecID;
                                                     aFieldNo   : TnxInt32;
                                               const aBlobNr    : TnxBlobNr;
                                                 out aLength    : TnxWord32;
                                                     aReadOrg   : Boolean;
                                                     aNewBlobNr : PnxNewBlobNr)
                                                                : TnxResult;
var
  lBlobNr: TnxBlobNr;
begin
  lBlobNr := aBlobNr;
  if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
    nbnBlobNr := lBlobNr;
    nbnSet := False;
  end;

  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try

        Result := stcBlobVerifyNr(aRecID, aFieldNo, lBlobNr, aReadOrg or (acReadOrgOverride > 0), aNewBlobNr);

        if (Result = DBIERR_BLOBMODIFIED) and
           Assigned(aNewBlobNr) and
           aNewBlobNr.nbnSet and
           (aNewBlobNr.nbnBlobNr <> lBlobNr)
        then begin
          lBlobNr := aNewBlobNr.nbnBlobNr;
          Result := DBIERR_NONE;
        end;

        if Result = DBIERR_NONE then begin
          if lBlobNr = 0 then begin
            aLength := 0;
            Exit;
          end;
          Result := stcBlobHandler.BlobGetLength(sbcTrans^, aRecID, aFieldNo,
            aReadOrg or (acReadOrgOverride > 0), lBlobNr, aLength);
        end;

      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobIsLink(const aRecID          : TnxRecID;
                                                  aFieldNo        : TnxInt32;
                                                  aBlobNr         : TnxBlobNr;
                                              out aSrcTableName   : string;
                                              out aSrcTableBlobNr : TnxBlobNr)
                                                                  : Boolean;
begin
  with sbcTransContext, stcTable do
    Result := stcBlobHandler.BlobIsLink
      (sbcTrans^, aRecID, aFieldNo, aBlobNr, aSrcTableName, aSrcTableBlobNr);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobModified(const aRecID   : TnxRecID;
                                                    aFieldNo  : TnxInt32;
                                              const aBlobNr   : TnxBlobNr;
                                                out aModified : Boolean)
                                                              : TnxResult;
begin
  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try
        Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

        if Result = DBIERR_NONE then
          Result := stcBlobHandler.BlobModified(sbcTrans^, aRecID, aFieldNo,
            aBlobNr, aModified);
      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobRead(const aRecID     : TnxRecID;
                                                aFieldNo   : TnxInt32;
                                          const aBlobNr    : TnxBlobNr;
                                                aOffset    : TnxWord32;
                                                aLen       : TnxWord32;
                                                aStream    : TStream;
                                                aReadOrg   : Boolean;
                                                aNewBlobNr : PnxNewBlobNr)
                                                           : TnxResult;
var
  lBlobNr: TnxBlobNr;
begin
  lBlobNr := aBlobNr;
  if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
    nbnBlobNr := lBlobNr;
    nbnSet := False;
  end;

  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try

        Result := stcBlobVerifyNr(aRecID, aFieldNo, lBlobNr, aReadOrg or (acReadOrgOverride > 0), aNewBlobNr);

        if (Result = DBIERR_BLOBMODIFIED) and
           Assigned(aNewBlobNr) and
           aNewBlobNr.nbnSet and
           (aNewBlobNr.nbnBlobNr <> lBlobNr)
        then begin
          lBlobNr := aNewBlobNr.nbnBlobNr;
          Result := DBIERR_NONE;
        end;

        if Result = DBIERR_NONE then begin
          if lBlobNr = 0 then
            Exit;
          Result := stcBlobHandler.BlobRead(sbcTrans^, aRecID, aFieldNo,
            aReadOrg or (acReadOrgOverride > 0), lBlobNr, aOffset, aLen, aStream, nil);
        end;

      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobReadSnapshoted(const aRecID   : TnxRecID;
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
  lBlobNr: TnxBlobNr;
begin
  lBlobNr := aBlobNr;
  if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
    nbnBlobNr := lBlobNr;
    nbnSet := False;
  end;

  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try

        Result := stcBlobVerifyNr(aRecID, aFieldNo, lBlobNr, aReadOrg or (acReadOrgOverride > 0), aNewBlobNr);

        if (Result = DBIERR_BLOBMODIFIED) and
           Assigned(aNewBlobNr) and
           aNewBlobNr.nbnSet and
           (aNewBlobNr.nbnBlobNr <> lBlobNr)
        then begin
          lBlobNr := aNewBlobNr.nbnBlobNr;
          Result := DBIERR_NONE;
        end;

        if Result = DBIERR_NONE then begin
          if lBlobNr = 0 then begin
            if Assigned(aBlobLen) then
              aBlobLen^ := 0;
            Exit;
          end;
          Result := stcBlobHandler.BlobRead(sbcTrans^, aRecID, aFieldNo, aReadOrg or (acReadOrgOverride > 0),
            lBlobNr, aOffset, aLen, aStream, aBlobLen);
        end;

      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;

end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobReplace(const aRecID   : TnxRecID;
                                                   aFieldNo : TnxInt32;
                                               var aBlobNr  : TnxBlobNr;
                                                   aLen     : TnxWord32;
                                             const aBlob    )
                                                            : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          if aBlobNr <> 0 then
            Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobReplace(sbcTrans^, aRecID, aFieldNo,
              aBlobNr, aLen, aBlob);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobsCancel(const aRefNr: TnxRefNr): TnxResult;
var
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    case Result of
      DBIERR_NX_CORRUPTTRANS,
      DBIERR_DEADLOCK: begin
        // can't cancel the blobs because the transaction is already corrupted
        // but that's not a problem, because the corrupted transaction can only
        // be rolled back, so the blobs are already "canceled".
        Result := DBIERR_NONE;
        Exit;
      end;
    end;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobHandler.BlobsCancel(sbcTrans^, aRefNr);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobTruncate(const aRecID      : TnxRecID;
                                                    aFieldNo    : TnxInt32;
                                              const aBlobNr     : TnxBlobNr;
                                                    aBlobLength : TnxWord32)
                                                                : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobTruncate(sbcTrans^, aRecID, aFieldNo,
              aBlobNr, aBlobLength);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBlobWrite(const aRecID   : TnxRecID;
                                                 aFieldNo : TnxInt32;
                                           const aBlobNr  : TnxBlobNr;
                                                 aOffset  : TnxWord32;
                                                 aLen     : TnxWord32;
                                           const aBlob    )
                                                          : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyNr(aRecID, aFieldNo, aBlobNr, False, nil);

          if Result = DBIERR_NONE then
            Result := stcBlobHandler.BlobWrite(sbcTrans^, aRecID, aFieldNo,
              aBlobNr, aOffset, aLen, aBlob);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBookmarkAsVariant(aBookmark : PnxBookmarkBuffer;
                                                   aSize     : TnxWord32;
                                               out aVariant  : Variant)
                                                             : TnxResult;
begin
  Result := stcIndexPath.BookmarkAsVariant(aBookmark, aSize, aVariant);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBookmarkCheckLocal(aBookmark : PnxBookmarkBuffer;
                                                    aSize     : TnxWord32)
                                                              : TnxResult;
begin
  Result := stcIndexPath.CheckBookmark(aBookmark, aSize);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcBookmarkClear(aBookmark : PnxBookmarkBuffer;
                                               aSize     : TnxWord32)
                                                         : TnxResult;
begin
  Result := stcIndexPath.ClearBookmark(aBookmark, aSize);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcChangePassword(const aNewPassword : UnicodeString)
                                                                   : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else begin
    with sbcTransContext, stcTable do try
      Result := sbcCheckTransactionState;
      if Result <> DBIERR_NONE then
        Exit;

      if stcShareMode = smExclusive then
        LockResult := lrConflictUnknown
      else begin
        LockResult := sbtLocks.GetRecordLock
          (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
        if LockResult in lrFailed then begin
          Result := sbcLockError(DBIERR_FILELOCKED);
          Exit;
        end;
      end;

      try
        Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;

        try
          Result := sbcBeginContentLock(True, False);
          if Result = DBIERR_NONE then begin
            Result := sbtRoot.srtChangePassword(sbcTrans^, aNewPassword);

            if Result = DBIERR_NONE then begin
              Result := stcTransactionCommit;
              if Result = DBIERR_NONE then
                TransactionStarted := False;
            end;
          end;
        except
          on E : Exception do
            Result := Self.asoConvertException(E);
        end;

        if Result <> DBIERR_NONE then
          if TransactionStarted then
            stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
      finally
        if LockResult = lrGrantedNew then
          sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
      end;

    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcCheckTransactionState: TnxResult;
begin
  with sbcTransContext, stcTable do
    if Assigned(sbcTrans^) then
      if (tsSnapshot in sbcTrans^.State) and
        ([nxfaTemporary, nxfaMemTable] * sbtRoot.srtMainFile.fiAttributes
        <> [nxfaTemporary]) then
        Result := DBIERR_TABLEREADONLY
      else
        Result := inherited sbcCheckTransactionState
    else
      Result := inherited sbcCheckTransactionState
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcCompareBookmarks(aBookmark1  : PnxBookmarkBuffer;
                                                  aBookmark2  : PnxBookmarkBuffer;
                                                  aSize       : TnxWord32;
                                              out aCompResult : TnxValueRelationship)
                                                              : TnxResult;
begin
  Result := stcIndexPath.CompareBookmarks(aBookmark1, aBookmark2, aSize, aCompResult);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcCompareKeys(aFieldCount : Integer;
                                             aPartialLen : Integer;
                                             aDirectKey1 : Boolean;
                                             aKeyData1   : PnxKeyOrRecordBuffer;
                                             aDirectKey2 : Boolean;
                                             aKeyData2   : PnxKeyOrRecordBuffer;
                                         out aResult     : TnxValueRelationship)
                                                         : TnxResult;
var
  Key1 : PnxKeyBuffer;
  Key2 : PnxKeyBuffer;
begin
  aResult := nxEqual;

  if not Assigned(stcIndexEngine) then
    Result := DBIERR_NOASSOCINDEX
  else
    with stcIndexEngine.KeyEngine do begin
      if not aDirectKey1 then
        Key1 := AllocKey;
      if not aDirectKey2 then
        Key2 := AllocKey;
      try
        if aDirectKey1 then begin
          Result := DBIERR_NONE;
          Key1 := PnxKeyBuffer(aKeyData1);
        end else
          Result := BuildKey(PnxRecordBuffer(aKeyData1), Key1, 0, True);
        if Result = DBIERR_NONE then begin
          if aDirectKey2 then
            Key2 := PnxKeyBuffer(aKeyData2)
          else
            Result := BuildKey(PnxRecordBuffer(aKeyData2), Key2, 0, True);
          if Result = DBIERR_NONE then
            aResult := CompareKey(Key1, Key2, aFieldCount, aPartialLen);
        end;
      finally
        if not aDirectKey1 then
          FreeKey(Key1);
        if not aDirectKey2 then
          FreeKey(Key2);
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcCopyRecords(aDestCursor     : TnxAbstractCursor;
                                             aBlobCopyMode   : TnxBlobCopyMode;
                                             aMaxTransSize   : Integer;
                                             aCheckValFields : Boolean)
                                                             : TnxResult;
var
  BlobFields         : TnxList;
  SourceIndexPath    : TnxBaseIndexPath;
  TargetIndexPath    : TnxBaseIndexPath;
  DestCursor         : TnxServerTableCursor;
  i                  : Integer;
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
  Offset             : TnxWord32;
  BlobField          : Integer;
  IsNull             : Boolean;
  SrcBlobNr          : TnxBlobNr;
  BlobNr             : TnxBlobNr;
  NewRefNr           : TnxRefNr;
  TableName          : string;
  AutoIncHigh        : TnxWord32;
  ThisAutoInc        : TnxWord32;
  lRecordCount       : TnxWord32;
begin
  AutoIncHigh := 0;
  DestCursor := nil;
  Result := DBIERR_NONE;

  if not (aDestCursor is TnxServerTableCursor) then
    Result := DBIERR_INVALIDHNDL
  else begin
    DestCursor := TnxServerTableCursor(aDestCursor);
    if atoLock <> DestCursor.atoLock then
      Result := DBIERR_NOTSAMESESSION
    else if stcTable = DestCursor.stcTable then
      Result := DBIERR_NX_SameTable
    else if DestCursor.IsCache then
      Result := DBIERR_NOTSUPPORTED
    else if not sbcForRecover and (roInsert in DestCursor.stcTable.sbtDenyRecordOperations) then
      Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedDataPolicies);
  end;

  if Result <> DBIERR_NONE then
    Exit;

  BlobFields := TnxList.Create;
  try
    if not stcTable.sbtFieldsDescriptor.HasSameFields(DestCursor.
      stcTable.sbtFieldsDescriptor, BlobFields) then
      Result := DBIERR_NX_IncompatDict
    else begin
      if BlobFields.Count < 1 then
        nxFreeAndNil(BlobFields);
      SourceIndexPath := stcIndexPath.Duplicate;
      TargetIndexPath := DestCursor.stcIndexPath.Duplicate;
      with DestCursor do try
        if sbcIsReadOnly then
          Result := sbcGetReadOnlyResult
        else
          with sbcTransContext, stcTable do begin
            Result := sbcCheckTransactionState;
            if Result <> DBIERR_NONE then
              Exit;

            if stcTable.sbtRoot.srtDictionary.Version = 1 then begin
              Result := DBIERR_TABLELEVEL;
              Exit;
            end;

            if stcShareMode = smExclusive then
              LockResult := lrConflictUnknown
            else begin
              LockResult := sbtLocks.GetRecordLock
                (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
              if LockResult in lrFailed then begin
                Result := sbcLockError(DBIERR_FILELOCKED);
                Exit;
              end;
            end;

            try
              Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
              TransactionStarted := Result = DBIERR_NONE;
              if not TransactionStarted then
                Exit;

              try
                Result := sbcBeginContentLock(True, False);

                if Result = DBIERR_NONE then begin

                  Result := Self.sbcBeginContentLock(False, False);
                  if Result = DBIERR_NONE then try
                    Self.stcIndexPath.SetToBof;
                    Self.sbcDisableFilterTimeout;
                    try
                      TableName := FullName;

                      if sbtSFI.sfiFields[sftAutoInc] >= 0 then
                        AutoIncHigh := sbtAutoIncEngine.
                          ReadAutoIncValue(sbcTrans^);

                      Result := Self.sbcRecordGetNext(nxltNoLock, Self.sbcRecordBuffer);
                      while Result = DBIERR_NONE do begin

                        if aCheckValFields and Assigned(sbcValidationsHandler) then try
                          sbcValidationsHandler.ValidateRecord(nil, Self.sbcRecordBuffer);
                        except
                          on E : Exception do begin
                            Result := Self.asoConvertException(E);
                            Continue;
                          end;
                        end;

                        if Assigned(BlobFields) then
                          for i := 0 to Pred(BlobFields.Count) do begin
                            BlobField := Integer(BlobFields[i]);
                            Offset := sbtFieldsDescriptor.FieldDescriptor[BlobField].fdOffset;

                            sbtFieldsDescriptor.GetRecordField(BlobField,
                              Self.sbcRecordBuffer, IsNull, nil);

                            if not IsNull then begin
                              case aBlobCopyMode of
                                nxbcmNoCopy:
                                  sbtFieldsDescriptor.SetRecordField(BlobField,
                                    Self.sbcRecordBuffer, nil);
                                nxbcmCopyFull: begin
                                  SrcBlobNr := PnxInt64(@Self.sbcRecordBuffer^[Offset])^;
                                  Result := sbcBlobCopyPrim(Self, BlobField, SrcBlobNr, BlobField, BlobNr);
                                  if Result = DBIERR_NONE then
                                    PnxInt64(@Self.sbcRecordBuffer^[Offset])^ := BlobNr
                                  else
                                    break;
                                end;
                              else
                                SrcBlobNr := PnxInt64(@Self.sbcRecordBuffer^[Offset])^;

                                sbtBlobEngine.AddBlobLink(sbcTrans^,
                                  TableName, SrcBlobNr, BlobNr);

                                PnxInt64(@Self.sbcRecordBuffer^[Offset])^ := BlobNr;
                              end;
                            end;
                          end;

                        if not sbcForRecover and (Result = DBIERR_NONE) and (sbtMaxRecordCount < High(TnxWord32)) then begin
                          sbtRecordEngine.GetRecordCount(sbcTrans^, lRecordCount);
                          if lRecordCount >= sbtMaxRecordCount then
                            Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedMaxRecords);
                        end;

                        if Result = DBIERR_NONE then
                          Result := aDestCursor.NotifyExtenders(eaRecordInsert, True, [Integer(nxltNoLock), Self.sbcRecordBuffer, nxInt64Null]);

                        if Result = DBIERR_NONE then begin
                          if sbtSFI.sfiFields[sftRecRev] >= 0 then
                            sbtRecRevInit(Self.sbcRecordBuffer);
                          if sbtSFI.sfiFields[sftRefNr] >= 0 then
                            sbtRefNrInit(Self.sbcRecordBuffer);
                          if (sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0) then
                            sbtLSNInit(Self, Self.sbcRecordBuffer);
                          sbtRecordEngine.AddRecord(sbcTrans^, NewRefNr,
                            Self.sbcRecordBuffer);
                          if Assigned(sbtIndicesEngine) then
                            Result := sbtIndicesEngine.InsertKeys
                              (sbcTrans^, NewRefNr, Self.sbcRecordBuffer,
                                nil);

                          if (Result = DBIERR_NONE) and Assigned(stcFulltextEngine) then
                             Result := stcFulltextEngine.UpdateIndex
                              (sbcTrans^, nil, 0, Self.sbcRecordBuffer, NewRefNr);

                          if Result = DBIERR_NONE then begin
                            stcRecordResurrect(NewRefNr, Self.sbcRecordBuffer);

                            Result := aDestCursor.NotifyExtenders(eaRecordInsert, False, [Integer(nxltNoLock), Self.sbcRecordBuffer, NewRefNr]);

                            if Result = DBIERR_NONE then begin
                              if (sbtSFI.sfiFields[sftAutoInc] >= 0) then begin
                                sbtFieldsDescriptor.GetRecordField(sbtSFI.sfiFields[sftAutoInc],
                                  Self.sbcRecordBuffer, IsNull, @ThisAutoInc);
                                if not IsNull and (ThisAutoInc > AutoIncHigh) then
                                  AutoIncHigh := ThisAutoInc;
                              end;

                              if (aMaxTransSize > 0) and (sbcTrans^.
                                TransLevel.BlockCount > aMaxTransSize) then begin

                                if sbtSFI.sfiFields[sftAutoInc] >= 0 then
                                  sbtAutoIncEngine.SetAutoIncValue
                                    (sbcTrans^, AutoIncHigh);

                                if TransactionStarted then begin
                                  Result := stcTransactionCommit;
                                  if Result = DBIERR_NONE then begin
                                    TransactionStarted := False;
                                    Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
                                    if Result = DBIERR_NONE then begin
                                      TransactionStarted := True;
                                      Result := sbcBeginContentLock(True, False);
                                      if Result = DBIERR_NONE then
                                        if sbtSFI.sfiFields[sftAutoInc] >= 0 then
                                          AutoIncHigh := sbtAutoIncEngine.
                                            ReadAutoIncValue(sbcTrans^);
                                    end;
                                  end;
                                end;
                              end;

                            end;
                          end;
                        end;

                        if Result = DBIERR_NONE then
                          Result := Self.sbcRecordGetNext(nxltNoLock, Self.sbcRecordBuffer);
                      end;
                      if Result = DBIERR_EOF then
                        Result := DBIERR_NONE;
                    finally
                      Self.sbcEnableFilterTimeout;
                    end;
                  finally
                    Self.sbcEndContentLock;
                  end;

                  if (Result = DBIERR_NONE) and TransactionStarted then begin
                    if sbtSFI.sfiFields[sftAutoInc] >= 0 then
                      sbtAutoIncEngine.SetAutoIncValue
                        (sbcTrans^, AutoIncHigh);

                    Result := stcTransactionCommit;
                    if Result = DBIERR_NONE then
                      TransactionStarted := False;
                  end;
                end;
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end;

              if Result <> DBIERR_NONE then
                if TransactionStarted then
                  stcTransactionRollback
                else
                  stcTransactionMarkCorrupted;
            finally
              if LockResult = lrGrantedNew then
                sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
            end;
          end;
      finally
        Self.stcIndexPath.Assign(SourceIndexPath);
        DestCursor.stcIndexPath.Assign(TargetIndexPath);
        nxFreeAndNil(SourceIndexPath);
        nxFreeAndNil(TargetIndexPath);
      end;
    end;
  finally
    nxFreeAndNil(BlobFields);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcDeleteRecords: TnxResult;
var
  LockResult         : TnxLockResult;
  LockedRefNr        : TnxRefNr;
  TransactionStarted : Boolean;
  Counter            : Integer;
  BlobsRecID         : TnxRecID;
  lRecordCount       : TnxWord32;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    Exit;
  end;

  TransactionStarted := False;
  Counter := 0;

  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else
    with sbcTransContext, stcTable do begin
      if not sbcForRecover and (roDelete in sbtDenyRecordOperations) then begin
        Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedDataPolicies);
        Exit;
      end;

      Result := sbcCheckTransactionState;
      if Result <> DBIERR_NONE then
        Exit;

      if sbcUseNestedTransaction or not Assigned(sbcTrans^) or (sbcTrans^.stForceNested > 0) then begin
        Result := stcTransactionStart(False, False, False, not sbcUseNestedTransaction, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;
      end;

      Result := sbcBeginContentLock(True, False);
      if Result = DBIERR_NONE then try

        stcIndexPath.SetToBof;

        sbcDisableFilterTimeout;
        try
          Result := sbcRecordGetNext(nxltNoLock, sbcRecordBuffer);
          while Result = DBIERR_NONE do begin
            if not sbcForRecover and (sbtMinRecordCount > 0) then begin
              sbtRecordEngine.GetRecordCount(sbcTrans^, lRecordCount);
              if lRecordCount <= sbtMinRecordCount then begin
                Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedMinRecords);
                Break;
              end;
            end;

            LockedRefNr := stcIndexPath.RefNr;
            if acsIsCache in acStates then
              BlobsRecID.ridRefNr := stcIndexPath.CacheRefNr
            else
              BlobsRecID.ridRefNr := LockedRefNr;
            if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
              BlobsRecID.ridInsertLSN := PnxLSN(@sbcRecordBuffer[acSFI.sfiOffsets[sftInsertLSN]])^
            else
              BlobsRecID.ridInsertLSN := 0;
            LockResult := sbtLocks.GetRecordLock
              (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
            if LockResult in lrFailed then
              Result := sbcLockError(DBIERR_LOCKED);

            if Result = DBIERR_NONE then try
              Result := Self.NotifyExtenders(eaRecordDelete, True, [sbcRecordBuffer, LockedRefNr]);
              if Result = DBIERR_NONE then begin

                if Assigned(sbtIndicesEngine) then
                  Result := sbtIndicesEngine.DeleteKeys(sbcTrans^,
                    stcIndexPath.RefNr, sbcRecordBuffer, stcIndexPath);

                if (Result = DBIERR_NONE) and Assigned(stcFulltextEngine) then
                  Result := stcFulltextEngine.UpdateIndex
                    (sbcTrans^, sbcRecordBuffer, LockedRefNr, nil, 0);

                if Result = DBIERR_NONE then begin

                  if Result = DBIERR_NONE then begin
                    try
                      sbtRecordEngine.DeleteRecord(sbcTrans^, LockedRefNr);
                      if not Assigned(stcIndexEngine) then
                        stcIndexPath.SetToDeleted;
                    except
                      on E : Exception do
                        Result := Self.asoConvertException(E);
                    end;

                    if Result = DBIERR_NONE then
                      Result := Self.NotifyExtenders(eaRecordDelete, False, [sbcRecordBuffer, LockedRefNr]);

                    if Result = DBIERR_NONE then
                      Result := stcBlobHandler.
                        AfterDelete(sbcTrans^, BlobsRecID, sbcRecordBuffer);

                    if Result = DBIERR_NONE then
                      stcRecordBury(LockedRefNr, sbcRecordBuffer);

                    if Result <> DBIERR_NONE then
                      stcTransactionMarkCorrupted;
                  end;
                end;
              end;
            finally
              if LockResult = lrGrantedNew then
                sbtLocks.ReleaseRecordLock(Self, LockedRefNr, sbcTrans^);
            end;

            Inc(Counter);
            if Counter mod 500 = 1 then
              nxCheckRemainingTime;

            if Result = DBIERR_NONE then
              Result := sbcRecordGetNext(nxltNoLock, sbcRecordBuffer);
          end;

          if Result = DBIERR_EOF then
            Result := DBIERR_NONE;

          if Result = DBIERR_NONE then
            if TransactionStarted then begin
              Result := stcTransactionCommit;
              if Result = DBIERR_NONE then
                TransactionStarted := False;
            end;
        finally
          sbcEnableFilterTimeout;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcDuplicate(aOpenMode    : TnxOpenMode;
                                       out aNewCursorID : TnxAbstractCursor;
                                           aForceWrite  : Boolean = False)
                                                        : TnxResult;

  procedure CopyRangeInfo(const aFrom : TnxRangeInfo;
                            var aTo   : TnxRangeInfo);
  begin
    aTo.riFieldCount := aFrom.riFieldCount;
    aTo.riPartitial := aFrom.riPartitial;
    aTo.riExclusive := aFrom.riExclusive;
    aTo.riValid := aFrom.riValid;
    if Assigned(stcIndexEngine) then
      with stcIndexEngine.KeyEngine do
      if aTo.riValid then
        CopyKey(aFrom.riKey, aTo.riKey)
      else
        ClearKey(aTo.riKey);
  end;

var
  IndexID          : Integer;
  FilterID         : TnxFilterID;
  NewCursorIndexID : Integer;
begin
  aNewCursorID := nil;
  try
    if Assigned(stcIndexEngine) then
      IndexID := stcIndexEngine.IndexNumber
    else
      IndexID := -1;

    if not aForceWrite then
      if sbcOpenMode  = omReadOnly then
        aOpenMode := omReadOnly;

    with TnxServerDatabase(Database), stcTable do
      Result := sdCursorOpen(aNewCursorID, TnxServerTransContext(acTransContext), FullName, sbtRoot.srtExtractPassword,
        sbtRoot.srtForServer, aOpenMode, smShared, True, Self.atoTimeout, '', IndexID, False, (acsIsCache in acStates));

    if Result = DBIERR_NONE then
      with TnxServerBaseCursor(aNewCursorID) do begin
        sbcGetIndexID(NewCursorIndexID);
        if NewCursorIndexID <> IndexID then
          Result := sbcSwitchToIndex('', IndexID, porFalse);
        if Result = DBIERR_NONE then begin
          stcIndexPath.Assign(Self.stcIndexPath);
          CopyRangeInfo(Self.stcRangeStart, stcRangeStart);
          CopyRangeInfo(Self.stcRangeEnd, stcRangeEnd);
          if Assigned(Self.sbcFilter) then
            sbcFilterAddCustom(Self.sbcFilter.Duplicate(aNewCursorID), FilterID, False);
        end;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Result <> DBIERR_NONE then try
    nxFreeAndNil(aNewCursorID);
  except end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcEndContentLock;
begin
  if stcShareMode = smExclusive then
    Exit;

  if not Assigned(stcTransLink) then
    with sbcTransContext do
      if not Assigned(sbcTrans^) then
         stcTable.sbtRoot.srtContentPortal.EndRead;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcExtractPassword: UnicodeString;
begin
  Result := Table.Root.ExtractPassword;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetBookmark(aBookmark : PnxBookmarkBuffer;
                                             aSize     : TnxWord32)
                                                       : TnxResult;
begin
  Result := stcIndexPath.GetBookmark(aBookmark, aSize, False);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetBookmarkCache(aBookmark : PnxBookmarkBuffer;
                                                  aSize     : TnxWord32)
                                                            : TnxResult;
begin
  if acsIsCache in acStates then
    Result := stcIndexPath.GetBookmark(aBookmark, aSize, True)
  else
    Result := inherited sbcGetBookmarkCache(aBookmark, aSize);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetBookmarkSize(out aSize : TnxWord32)
                                                           : TnxResult;
begin
  if Assigned(stcIndexPath) then
    aSize := stcIndexPath.BookmarkSize
  else
    aSize := nxcl_FixedBookmarkSize;

  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetIndexID(out aIndexID : Integer)
                                                         : TnxResult;
begin
  Result := DBIERR_NONE;
  if Assigned(stcIndexEngine) then
    aIndexID := stcIndexEngine.IndexNumber
  else
    aIndexID := -1;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetKeyFieldsSource: InxFieldsSource;
begin
  Result := TnxKeyFieldsSource.Create(Self);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetPosition: TnxIndexPathPosition;
begin
  Result := stcIndexPath.Position;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetRecordCount(aOption   : TnxRecordCountOption;
                                            out aRecCount : TnxWord32;
                                                aEstimate : Boolean = False)
                                                          : TnxResult;

  function CountRecords: TnxResult;
  var
    TempIndexPath : TnxBaseIndexPath;
    TempFilter    : TnxBaseFilterEngine;
    TempKeyFilter : TnxBaseFilterEngine;
  begin
    TempFilter := nil;
    TempKeyFilter := nil;
    TempIndexPath := stcIndexPath.Duplicate;

    try

      if aOption < rcoServerFilteredKeyCount then begin
        TempFilter := sbcFilter;
        sbcFilter := nil;
        TempKeyFilter := sbcKeyFilter;
        sbcKeyFilter := nil;
      end;

      sbcDisableFilterTimeout;
      try
        aRecCount := 0;
        stcIndexPath.SetToEof;
        Result := sbcRecordGetPrior(nxltNoLock, nil);
        if Result = DBIERR_NONE then begin
          Result := sbcRecNoGet(aRecCount, False);
          if Result <> DBIERR_NONE then begin
            aRecCount := 0;
            stcIndexPath.SetToBof;
            Result := sbcRecordGetNext(nxltNoLock, nil);
            while Result = DBIERR_NONE do begin
              Inc(aRecCount);
              Result := sbcRecordGetNext(nxltNoLock, nil);
            end;
            if Result = DBIERR_EOF then
              Result := DBIERR_NONE;
          end;
        end else if Result = DBIERR_BOF then
          Result := DBIERR_NONE;
      finally
        sbcEnableFilterTimeout;
      end;

    finally

      stcIndexPath.Assign(TempIndexPath);
      nxFreeAndNil(TempIndexPath);

      if Assigned(TempFilter) then begin
        Assert(not Assigned(sbcFilter));
        sbcFilter := TempFilter;
      end;

      if Assigned(TempKeyFilter) then begin
        Assert(not Assigned(sbcKeyFilter));
        sbcKeyFilter := TempKeyFilter;
      end;

    end;
  end;

begin
  if sbcIsWriteOnly then begin
    aRecCount := 0;
    Result := sbcGetWriteOnlyResult;
    Exit;
  end;

  Result := sbcBeginContentLock(False, False);
  if Result = DBIERR_NONE then
    with sbcTransContext, stcTable do try
      if (aOption > rcoTotalRecordCount) and Assigned(stcIndexEngine) then
        if (aOption > rcoTotalKeyCount) and (stcRangeStart.riValid or stcRangeEnd.riValid or
          (Assigned(sbcFilter) and sbcFilter.Active) or
          (Assigned(sbcKeyFilter) and sbcKeyFilter.Active)) then begin
          if aEstimate then
            stcIndexEngine.EstimateRecordCount(sbcTrans^, stcRangeStart, stcRangeEnd, aRecCount, False)
          else
            Result := CountRecords
        end else
          stcIndexEngine.GetKeyCount(sbcTrans^, aRecCount)
      else
        if (aOption > rcoRangedKeyCount) and
          ((Assigned(sbcFilter) and sbcFilter.Active) or
          (Assigned(sbcKeyFilter) and sbcKeyFilter.Active)) then
          Result := CountRecords
        else
          sbtRecordEngine.GetRecordCount(sbcTrans^, aRecCount);
    finally
      sbcEndContentLock;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetRootName: string;
begin
  Result := Table.Root.Name;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcGetStats: TnxServerTableStats;
begin
  Result := stcTable.sbtGetStats(sbcTrans^);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcIterate(aData         : PPnxRecordBuffer;
                                          aKeyIterator  : TnxKeyIterator;
                                          aRecIterator  : TnxRecordIterator;
                                          aBackward     : Boolean;
                                          aCookie       : Pointer;
                                          aKeepPosition : Boolean = False;
                                          aResult       : PnxResult = nil;
                                          aLongFilter   : Boolean = True);
var
  Result     : TnxResult;
  lSkipFirst : Boolean;
begin
  if sbcIsWriteOnly then
    Exit;

  with sbcTransContext, stcTable do begin

    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then try
      Inc(stcInUseCount);

      if Assigned(aResult) and (Assigned(sbcFilter) or Assigned(sbcKeyFilter)) then
        sbcFilterBeginTimeout(aResult, aLongFilter);

      if Assigned(stcIndexEngine) then begin
        if aBackward then
          stcIndexEngine.IterateBackward(sbcTrans^, stcIndexPath, aData,
            aKeyIterator, aRecIterator, aCookie, stcRangeStart, stcRangeEnd,
            sbcFilter, sbcKeyFilter, aKeepPosition)
        else
          stcIndexEngine.Iterate(sbcTrans^, stcIndexPath, aData, aKeyIterator,
            aRecIterator, aCookie, stcRangeStart, stcRangeEnd, sbcFilter,
            sbcKeyFilter, aKeepPosition);
      end else begin
        lSkipFirst := False;
        if aKeepPosition then begin
          case stcIndexPath.Position of
            ippUnknown:
              aKeepPosition := False;
            ippOnCrackBefore :
              lSkipFirst := aBackward;
            ippOnCrackAfter:
              lSkipFirst := not aBackward;
            ippBof:
              if aBackward then
                Exit
              else
                aKeepPosition := False;
            ippEof:
              if not aBackward then
                Exit
              else
                aKeepPosition := False;
          end;
        end;
        if not aKeepPosition then
          stcIndexPath.SetToRecord(nil, 0);
        if aBackward then
          sbtRecordEngine.IterateBackward(sbcTrans^, stcIndexPath.RefNr, aData, aRecIterator, aCookie, sbcFilter, aKeepPosition, lSkipFirst)
        else
          sbtRecordEngine.Iterate(sbcTrans^, stcIndexPath.RefNr, aData, aRecIterator, aCookie, sbcFilter, aKeepPosition, lSkipFirst);

        if stcIndexPath.RefNr = 0 then
          if aBackward then
            stcIndexPath.SetToBof
          else
            stcIndexPath.SetToEof
        else
          stcIndexPath.Position := ippOnKey;
      end;
    finally
      sbcFilterEndTimeout;
      Dec(stcInUseCount);
      sbcEndContentLock;
    end else
      raise EnxServerEngineException.nxCreate(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcKeyFilterMatchesRecord(aRecord : PnxRecordBuffer;
                                                  const aRefNr  : TnxRefNr)
                                                                : Boolean;
begin
  if Assigned(stcIndexEngine) and Assigned(sbcKeyFilter) and sbcKeyFilter.Active then begin
    Result := (stcIndexEngine.KeyEngine.BuildKey(aRecord, stcKeyBuffer, aRefNr,
      False) = DBIERR_NONE)  and sbcKeyFilter.MatchesBuffer(stcKeyBuffer);
  end else
    Result := True;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcRangeReset;
begin
  stcRangeStart.riValid := False;
  stcRangeEnd.riValid := False;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRangeSet(aFieldCount1 : Integer;
                                          aPartialLen1 : Integer;
                                          aDirectKey1  : Boolean;
                                          aKeyData1    : PnxKeyOrRecordBuffer;
                                          aKeyIncl1    : Boolean;
                                          aFieldCount2 : Integer;
                                          aPartialLen2 : Integer;
                                          aDirectKey2  : Boolean;
                                          aKeyData2    : PnxKeyOrRecordBuffer;
                                          aKeyIncl2    : Boolean)
                                                       : TnxResult;
begin
  Result := DBIERR_NONE;
  if not Assigned(stcIndexEngine) then
    Result := DBIERR_NOASSOCINDEX
  else begin
    with stcRangeStart do begin
      riValid := Assigned(aKeyData1);
      if riValid then begin
        if aDirectKey1 then begin
          Result := DBIERR_NONE;
          stcIndexEngine.KeyEngine.CopyKey(PnxKeyBuffer(aKeyData1), riKey);
        end else
          Result := stcIndexEngine.KeyEngine.BuildKey(PnxRecordBuffer(aKeyData1), riKey, 0, True);
        riFieldCount := aFieldCount1;
        riPartitial := aPartialLen1;
        riExclusive := not aKeyIncl1;
      end;
    end;
    if Result = DBIERR_NONE then
      with stcRangeEnd do begin
        riValid := Assigned(aKeyData2);
        if riValid then begin
          if aDirectKey2 then begin
            Result := DBIERR_NONE;
            stcIndexEngine.KeyEngine.CopyKey(PnxKeyBuffer(aKeyData2), riKey);
          end else
          Result := stcIndexEngine.KeyEngine.BuildKey(PnxRecordBuffer(aKeyData2), riKey, 0, True);
          riFieldCount := aFieldCount2;
          riPartitial := aPartialLen2;
          riExclusive := not aKeyIncl2;
        end;
      end;
    if Result = DBIERR_NONE then
      stcIndexPath.SetToBof;
  end;

  if Result <> DBIERR_NONE then begin
    stcRangeStart.riValid := False;
    stcRangeEnd.riValid := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecNoGet(out aRecNo     : TnxWord32;
                                              aFlipOrder : Boolean)
                                                         : TnxResult;
begin
  with sbcTransContext, stcTable do
    if Assigned(stcIndexEngine) then
      Result := stcIndexEngine.RecNoGet(sbcTrans^, stcIndexPath,
        stcRangeStart, stcRangeEnd, sbcFilter, sbcKeyFilter, aRecNo, aFlipOrder)
    else
      Result := sbtRecordEngine.RecNoGet
        (sbcTrans^, stcIndexPath.RefNr, sbcFilter, aRecNo, aFlipOrder);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecNoSet(aRecNo     : TnxWord32;
                                          aFlipOrder : Boolean)
                                                     : TnxResult;
var
  RefNr : TnxRefNr;
begin
  with sbcTransContext, stcTable do begin

    if Assigned(stcIndexEngine) then
      Result := stcIndexEngine.RecNoSet(sbcTrans^, aRecNo, stcIndexPath,
        stcRangeStart, stcRangeEnd, sbcFilter, sbcKeyFilter, aFlipOrder)
    else begin
      Result := sbtRecordEngine.RecNoSet
        (sbcTrans^, aRecNo, RefNr, sbcFilter, aFlipOrder);

      case Result of
        DBIERR_BOF:
          stcIndexPath.SetToBof;
        DBIERR_EOF:
          stcIndexPath.SetToEof;
        DBIERR_NONE:
          stcIndexPath.SetToRecord(nil, RefNr);
      end;

    end;

  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordDelete(aData : PnxRecordBuffer;
                                              aLSN  : TnxLSN = 0)
                                                    : TnxResult;
var
  LockResult            : TnxLockResult;
  LockedRefNr           : TnxRefNr;
  TransactionStarted    : Boolean;
  TransactionRolledBack : Boolean;
  PlacedContentLock     : Boolean;
  OldIndexPath          : TnxBaseIndexPath;
  lLSN                  : TnxLSN;
  lRecordCount          : TnxWord32;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOCURRREC;
    Exit;
  end;

  if (aLSN <> 0) and (acSFI.sfiOffsets[sftModifyLSN] < 0) then begin
    Result := DBIERR_NOTSUPPORTED;
    Exit;
  end;

  if not Assigned(aData) then
    aData := sbcRecordBuffer;

  sbcRecordBufferOrg := nil;
  sbcRecordBufferOrgRefNr := 0;

  PlacedContentLock := False;
  TransactionStarted := False;
  TransactionRolledBack := False;
  OldIndexPath := nil;

  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else with sbcTransContext, stcTable do try
    if not sbcForRecover and (roDelete in sbtDenyRecordOperations) then begin
      Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedDataPolicies);
      Exit;
    end;

    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    Result := stcIndexPath.CheckCurrentState;
    if Result <> DBIERR_NONE then
      Exit;

    LockedRefNr := stcIndexPath.RefNr;
    if LockedRefNr <> 0 then begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_LOCKED);
        Exit;
      end;
    end else
      { don't have a RefNr yet, need to wait till after ValidateIndexPath to
        be sure we have one }
      LockResult := lrConflictUnknown;

    stcDeletingBlobsRecID := ridNull;
    try
      if sbcUseNestedTransaction or not Assigned(sbcTrans^) or (sbcTrans^.stForceNested > 0) then begin
        Result := stcTransactionStart(False, False, False, not sbcUseNestedTransaction, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;
      end;

      try
        Result := sbcBeginContentLock(True, False);

        if Result = DBIERR_NONE then begin
          PlacedContentLock := True;

          Result := stcValidateIndexPath;
          if Result = DBIERR_NONE then
            { make sure we have a lock}
            if LockResult in lrFailed then begin
              LockedRefNr := stcIndexPath.RefNr;
              if LockedRefNr = 0 then
                Result := DBIERR_NOCURRREC
              else begin
                LockResult := sbtLocks.GetRecordLock
                  (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
                if LockResult in lrFailed then
                  Result := sbcLockError(DBIERR_LOCKED);
              end;
            end else
              if LockedRefNr <> stcIndexPath.RefNr then
                { this really shouldn't happen... but check just in case... }
                Result := DBIERR_NOCURRREC;

          if acsIsCache in acStates then
            stcDeletingBlobsRecID.ridRefNr := stcIndexPath.CacheRefNr
          else
            stcDeletingBlobsRecID.ridRefNr := LockedRefNr;

          if Result = DBIERR_NONE then begin
            if Assigned(sbcKeyFilter) and sbcKeyFilter.Active and not
              (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key)) then
              Result := DBIERR_NOCURRREC
            else begin
              if not sbcForRecover and (sbtMinRecordCount > 0) then begin
                sbtRecordEngine.GetRecordCount(sbcTrans^, lRecordCount);
                if lRecordCount <= sbtMinRecordCount then
                  Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsDeleteDeniedMinRecords);
              end;

              if Result = DBIERR_NONE then begin
                sbtRecordEngine.ReadRecord
                  (sbcTrans^, stcIndexPath.RefNr, aData);
                sbcRecordBufferOrg := aData;
                sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;

                if aLSN <> 0 then begin
                  lLSN := PnxLSN(@sbcRecordBuffer[acSFI.sfiOffsets[sftModifyLSN]])^;
                  if (aLSN <> lLSN) and (lLSN <> 0) then
                    Result := DBIERR_NOCURRREC;
                end;
              end;

              if Result = DBIERR_NONE then begin
                if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
                  stcDeletingBlobsRecID.ridInsertLSN := PnxLSN(@sbcRecordBuffer[acSFI.sfiOffsets[sftInsertLSN]])^
                else
                  stcDeletingBlobsRecID.ridInsertLSN := 0;

                if Assigned(sbcFilter) and sbcFilter.Active then begin
                  sbcBeginReadOrgOverride;
                  try
                    if not sbcFilter.MatchesBuffer(aData) then
                      Result := DBIERR_NOCURRREC
                  finally
                    sbcEndReadOrgOverride;
                  end;
                end;
              end;

              if Result = DBIERR_NONE then begin
                Result := Self.NotifyExtenders(eaRecordDelete, True, [aData, LockedRefNr]);
                if Result = DBIERR_NONE then begin
                  OldIndexPath := stcIndexPath.Duplicate;

                  if Assigned(sbtIndicesEngine) then try
                    Result := sbtIndicesEngine.DeleteKeys(sbcTrans^,
                      stcIndexPath.RefNr, aData, stcIndexPath);
                  except
                    on E : Exception do
                      Result := Self.asoConvertException(E);
                  end;

                  if Result = DBIERR_NONE then begin
                    if Assigned(stcFulltextEngine) then try
                      Result := stcFulltextEngine.UpdateIndex
                        (sbcTrans^, aData, LockedRefNr, nil, 0);
                    except
                      on E : Exception do
                        Result := Self.asoConvertException(E);
                    end;

                    if Result = DBIERR_NONE then begin
                      try
                        sbtRecordEngine.DeleteRecord(sbcTrans^, LockedRefNr);
                        if not Assigned(stcIndexEngine) then
                          stcIndexPath.SetToDeleted;
                      except
                        on E : Exception do
                          Result := Self.asoConvertException(E);
                      end;
                      if Result = DBIERR_NONE then
                        Result := Self.NotifyExtenders(eaRecordDelete, False, [aData, LockedRefNr]);
                      if Result = DBIERR_NONE then
                        Result := stcBlobHandler.
                          AfterDelete(sbcTrans^, stcDeletingBlobsRecID, aData);
                      if Result = DBIERR_NONE then
                        Result := stcRecordBury(LockedRefNr, aData);
                      if Result = DBIERR_NONE then begin
                        if TransactionStarted then begin
                          Result := stcTransactionCommit;
                          if Result = DBIERR_NONE then
                            TransactionStarted := False;
                        end;
                      end else
                        stcTransactionMarkCorrupted;
                    end else
                      stcTransactionMarkCorrupted;
                  end;
                end;
              end;
            end;
          end;
        end;

      except
        on E : Exception do begin
          Result := Self.asoConvertException(E);
          stcTransactionMarkCorrupted;
        end;
      end;

      if Result <> DBIERR_NONE then begin
        if TransactionStarted then begin
          TransactionRolledBack := True;
          stcTransactionRollback;
        end;
        if Assigned(OldIndexPath) then
          stcIndexPath.Assign(OldIndexPath);
      end else
        if  LockResult = lrGrantedExisting then
          LockResult := lrGrantedNew;
    finally
      stcDeletingBlobsRecID := ridNull;
      if LockResult = lrGrantedNew then
        { If the transaction was rolled back, do NOT pass sbcTrans^ to
          ReleaseRecordLock. Otherwise, if the rolled back transaction was
          a nested transaction, sbcTrans^ will be non-nil and stored inside
          sbtLocks, but the transaction itself does NOT have a transaction
          lock on this table. When the transaction is then later finished
          (comitted or rolled back) sbtLocks will retain a reference to
          an already freed object, resulting in crashed later when it is
          being accessed }
        if PlacedContentLock and not TransactionRolledBack then
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, sbcTrans^)
        else
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, nil);
      nxFreeAndNil(OldIndexPath);
      sbcRecordBufferOrg := nil;
      sbcRecordBufferOrgRefNr := 0;
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordGet(aLockType : TnxLockType;
                                           aData     : PnxRecordBuffer)
                                                     : TnxResult;
var
  LockResult  : TnxLockResult;
  LockedRefNr : TnxRefNr;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOCURRREC;
    Exit;
  end;

  LockResult := lrConflictUnknown;
  LockedRefNr := stcIndexPath.RefNr;

  sbcRecordBufferOrg := nil;
  sbcRecordBufferOrgRefNr := 0;

  with sbcTransContext, stcTable do try
    if aLockType <> nxltNoLock then
      if LockedRefNr <> 0 then begin
        Result := stcIndexPath.CheckCurrentState;
        if Result <> DBIERR_NONE then
          Exit;

        LockResult := sbtLocks.GetRecordLock(sbcTrans^,
          Self, LockedRefNr, False, sbcLockFailureReason);

        if LockResult in lrFailed then begin
          Result := sbcLockError(DBIERR_LOCKED);
          Exit;
        end;
      end;

    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then try
      Result := stcValidateIndexPath;
      if Result = DBIERR_NONE then begin
        if aLockType <> nxltNoLock then begin
          { make sure we have a lock}
          if LockResult in lrFailed then begin
            LockedRefNr := stcIndexPath.RefNr;
            if LockedRefNr = 0 then
              Result := DBIERR_NOCURRREC
            else begin
              LockResult := sbtLocks.GetRecordLock
                (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
              if LockResult in lrFailed then
                Result := sbcLockError(DBIERR_LOCKED);
            end;
          end else
            if LockedRefNr <> stcIndexPath.RefNr then
              { this really shouldn't happen... but check just in case... }
              Result := DBIERR_NOCURRREC;
        end;

        if Result = DBIERR_NONE then
          if Assigned(sbcKeyFilter) and sbcKeyFilter.Active and
            not (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key)) then
            Result := DBIERR_NOCURRREC
          else begin
            if not Assigned(aData) and Assigned(sbcFilter) and sbcFilter.Active then
              aData := sbcRecordBuffer;

            if Assigned(aData) then begin

                sbtRecordEngine.ReadRecord(sbcTrans^, stcIndexPath.RefNr, aData);
                sbcRecordBufferOrg := aData;
                sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;

                if Assigned(sbcFilter) and sbcFilter.Active then begin
                  sbcBeginReadOrgOverride;
                  try
                    if not sbcFilter.MatchesBuffer(aData) then
                      Result := DBIERR_NOCURRREC;
                  finally
                    sbcEndReadOrgOverride;
                  end;
                end;

              if Result = DBIERR_NONE then
                Self.NotifyExtenders(eaRecordGet, False, [Ord(aLockType), aData, stcIndexPath.RefNr]);
            end;
          end;
      end;
    finally
      sbcEndContentLock;
      sbcRecordBufferOrg := nil;
      sbcRecordBufferOrgRefNr := 0;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if (Result <> DBIERR_NONE) and (LockResult = lrGrantedNew) then
    stcTable.sbtLocks.ReleaseRecordLock(Self, LockedRefNr, nil);
end;
{------------------------------------------------------------------------------}
type
  TnxRecordGetBatchIteratorData = record
    CutoffSize     : Integer;
    Options        : TnxRecordGetBatchExOptions;
    Stream         : TnxMemoryStream;
    MaxRecords     : Integer;
    Backward       : Boolean;

    RecordBuffer   : PnxRecordBuffer;

    Error          : TnxResult;
    Count          : Integer;
    Size           : Integer;
    OrgSize        : TnxWord32;
    Offset         : TnxWord32;
    RecordLength   : TnxWord32;
    BookmarkLength : TnxWord32;

    StreamEndOpen  : Boolean;
  end;
  PnxRecordGetBatchIteratorData = ^TnxRecordGetBatchIteratorData;

function TnxServerTableCursor.sbcRecordGetBatch(aCutoffSize : Integer;
                                                aOptions    : TnxRecordGetBatchExOptions;
                                            var aAccess     : TnxBatchStreamAccess;
                                                aMaxRecords : Integer = -1;
                                                aForward    : Boolean = True)
                                                            : TnxResult;
{$IFDEF NX_USE_ITERATE_FOR_RECORDGETBATCH}
var
  Data: TnxRecordGetBatchIteratorData;
{$ENDIF}
begin
  {$IFDEF NX_USE_ITERATE_FOR_RECORDGETBATCH}
  Result := DBIERR_NONE;
  with Data do try
    CutoffSize := aCutoffSize;
    Options := aOptions;
    if not Assigned(aAccess) then
      aAccess := CreateBatchStreamAccess(nil, aOptions)
    else
      aAccess.Clear;

    Stream := aAccess.Stream;
    MaxRecords := aMaxRecords;
    Backward := not aForward;

    if CutoffSize < 0 then
      CutoffSize := High(Integer);

    if MaxRecords < 1 then
      MaxRecords := High(Integer);

    Stream.Size := 0;

    if CutoffSize = High(Integer) then
      TnxMemoryStreamCracker(Stream).Capacity := 512*1024
    else
      TnxMemoryStreamCracker(Stream).Capacity := CutoffSize;

    RecordLength := TableDescriptor.FieldsDescriptor.RecordLength;

    Error := DBIERR_NONE;
    Stream.WriteBuffer(Error, SizeOf(Error));
    Count := 0;
    Stream.WriteBuffer(Count, SizeOf(Count));

    OrgSize := RecordLength;
    Error := sbcGetBookmarkSize(BookmarkLength);
    if gboBookmarks in Options then begin
      Inc(OrgSize, BookmarkLength);
    end else begin
      BookmarkLength := 0;
      Error := DBIERR_NONE;
    end;

    if gboBlobs in Options then
      if not Assigned(acSFI.sfiBlobFields) then
        Exclude(Options, gboBlobs);

    if Error = DBIERR_NONE then begin
      Size := OrgSize;
      Stream.WriteBuffer(Size, SizeOf(Size));
      OffSet := Stream.Position;
      Stream.Size := Stream.Size + Size;
      RecordBuffer := PnxRecordBuffer(@Stream.ByteArray[Offset]);
      StreamEndOpen := True;

      if Backward then
        Error := DBIERR_BOF
      else
        Error := DBIERR_EOF;

      sbcIterate(
        @RecordBuffer,
        nil,
        stcRecordGetBatchIterator,
        Backward,
        @Data,
        not (gboSetToBeginOrEnd in Options),
        @Error,
        not (gboUseFilterTimeout in aOptions)
      );

      if StreamEndOpen then
        Stream.Size :=  OffSet - SizeOf(Size);
    end;

    if (Error = DBIERR_NX_FilterTimeout) and (Count = 0) then
      Result := Error;

    Stream.Position := 0;
    Stream.WriteBuffer(Error, SizeOf(Error));
    Stream.WriteBuffer(Count, SizeOf(Count));
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
  if Assigned(aAccess) then
    aAccess.Reset;
  {$ELSE}
  Result := inherited;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcRecordBury(aRefNr : TnxRefNr;
                                            aData  : PnxRecordBuffer)
                                                   : TnxResult;
var
  lLSN: TnxLSN;
begin
  Result := DBIERR_NONE;
  if Assigned(stcGraveyardLSNIndexPath) and
     Assigned(stcGraveyardRefNrIndexPath)
  then begin
    //This is the LSN of when the record was last modified, don't store that
    //lLSN := PnxInt64(@aData[acCacheableInfo.ciLSNOffset])^;
    //Instead store a new LSN that indicates when in the sequence the
    //record was actually deleted:
    if GetNextLSN(lLSN) and
       not stcGraveyardLSNIndexEngine.InsertKey
             (sbcTrans^, lLSN, aRefNr, 0, stcGraveyardLSNIndexPath) or
       not stcGraveyardRefNrIndexEngine.InsertKey
             (sbcTrans^, aRefNr, lLSN, 0, stcGraveyardRefNrIndexPath)
    then
      Result := EnxBaseException.nxSetMessage(DBIERR_NX_CORRUPTTRANS,
        @rsTheGraveyardIsCorruptedCouldNotAdd )
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcRecordGetBatchIterator(aCookie : Pointer;
                                                        aRefNr  : TnxRefNr;
                                                        aRecord : PnxRecordBuffer)
                                                                : TnxRecordIteratorResult;
begin
  Result := rirContinue;
  with PnxRecordGetBatchIteratorData(aCookie)^ do begin
    Assert(StreamEndOpen);

    Error := DBIERR_NONE;
    if BookmarkLength > 0 then
      if acsIsCache in acStates then
        Error := sbcGetBookmarkCache(@Stream.ByteArray[Offset + RecordLength], BookmarkLength)
      else
        Error := sbcGetBookmark(@Stream.ByteArray[Offset + RecordLength], BookmarkLength);

    if Error = DBIERR_NONE then
      if gboBlobs in Options then begin
        Error := sbcCopyBlobsToBatchStream(Size, Offset, Stream, gboBlobNrs in Options, gboBlobsOnlyMarked in Options);

        if TnxWord32(Size) <> OrgSize then begin
          Stream.Position  := OffSet - SizeOf(Size);
          Stream.WriteBuffer(Size, SizeOf(Size));
        end;
      end;

    if Error = DBIERR_NONE then begin
      Stream.Position := Stream.Size;
      Inc(Count);
    end else
      Stream.Size := Offset - SizeOf(Size);

    StreamEndOpen := False;

    if (Error = DBIERR_NONE) and (Stream.Size < CutoffSize) and (Count < MaxRecords) and (nxGetRemainingTime > 15) then begin
      Size := OrgSize;
      Stream.WriteBuffer(Size, SizeOf(Size));
      OffSet := Stream.Position;
      Stream.Size := Stream.Size + Size;
      RecordBuffer := PnxRecordBuffer(@(Stream.ByteArray[Offset]));
      StreamEndOpen := True;

      if Backward then
        Error := DBIERR_BOF
      else
        Error := DBIERR_EOF;
    end else
      Result := rirStop;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordGetForKey(aFieldCount : integer;
                                                 aPartialLen : integer;
                                                 aDirectKey  : Boolean;
                                                 aKeyData    : PnxKeyOrRecordBuffer;
                                                 aData       : PnxRecordBuffer;
                                                 aMatchFirst : Boolean;
                                                 aFirstCall  : Boolean)
                                                             : TnxResult;
const
  SearchAction : array[Boolean] of TnxSearchKeyAction =
    (skaEqualLast, skaEqualFirst);
var
  RecordFound : Boolean;
  Filter      : TnxBaseFilterEngine;
  KeyFilter   : TnxBaseFilterEngine;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_RECNOTFOUND;
    Exit;
  end;

  if not Assigned(stcIndexEngine) then begin
    Result := DBIERR_NOASSOCINDEX;
    Exit;
  end;

  if aDirectKey then begin
    Result := DBIERR_NONE;
    stcIndexEngine.KeyEngine.CopyKey(PnxKeyBuffer(aKeyData), stcKeyBuffer);
  end else
    Result := stcIndexEngine.KeyEngine.BuildKey
      (PnxRecordBuffer(aKeyData), stcKeyBuffer, 0, True);
  if Result <> DBIERR_NONE then
    Exit;

  Filter := sbcFilter;
  if Assigned(Filter) and not Filter.Active then
    Filter := nil;

  KeyFilter := sbcKeyFilter;
  if Assigned(KeyFilter) and not KeyFilter.Active then
    KeyFilter := nil;

  if Assigned(Filter) and not Assigned(aData) then
    aData := sbcRecordBuffer;
  sbcRecordBufferOrg := nil;
  sbcRecordBufferOrgRefNr := 0;

  Result := sbcBeginContentLock(False, False);
  if Result = DBIERR_NONE then
    with sbcTransContext, stcTable do try

      if Assigned(Filter) or Assigned(KeyFilter) then begin
        if (aData = nil) and Assigned(Filter) then
          aData := sbcRecordBuffer;
        sbcFilterBeginTimeout(@Result);
      end;

      repeat

        if aFirstCall then begin
          RecordFound := stcIndexEngine.FindKey(sbcTrans^, stcKeyBuffer^,
            aFieldCount, aPartialLen, 0, stcIndexPath,
            SearchAction[aMatchFirst], KeyFilter) and stcIndexPath.KeyValid;
          aFirstCall := False;
        end else begin
          if aMatchFirst then
            RecordFound := stcIndexEngine.NextKey(sbcTrans^, stcIndexPath, KeyFilter)
          else
            RecordFound := stcIndexEngine.PrevKey(sbcTrans^, stcIndexPath, KeyFilter);

          if RecordFound and (Result = DBIERR_NONE) then
            RecordFound := stcIndexPath.KeyValid and
              (stcIndexEngine.KeyEngine.CompareKey(stcKeyBuffer, stcIndexPath.Key,
                aFieldCount, aPartialLen) = nxEqual);
        end;

        if Result = DBIERR_NONE then begin
          if RecordFound and (stcKeyIsInRange(stcIndexPath.Key) <> nxEqual) then
            RecordFound := False;

          if RecordFound then begin
            sbtRecordEngine.ReadRecord
              (sbcTrans^, stcIndexPath.RefNr, aData);
            sbcRecordBufferOrg := aData;
            sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
            Self.NotifyExtenders(eaRecordGet, False, [Ord(nxltNoLock), aData, stcIndexPath.RefNr]);
          end else begin
            Result := DBIERR_RECNOTFOUND;
            if aMatchFirst then
              stcIndexPath.SetToEof
            else
              stcIndexPath.SetToBof;
          end;
        end;

      until (Result <> DBIERR_NONE) or
        not Assigned(Filter) or
        Filter.MatchesBuffer(aData) or
        sbcFilterCheckTimeout(Result);

    finally
      sbcFilterEndTimeout;
      sbcEndContentLock;
      sbcRecordBufferOrg := nil;
      sbcRecordBufferOrgRefNr := 0;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordGetForKeyBatch(aCutoffSize : Integer;
                                                      aOptions    : TnxRecordGetBatchExOptions;
                                                  var aAccess     : TnxBatchStreamAccess;
                                                const aKeys       : TnxDataSetKeyBufferArray;
                                                      aMatchFirst : Boolean;
                                                      aFirstCall  : Boolean)
                                                                  : TnxResult;
type
  PBuffer = {$IFDEF DCC12OrLater}PByte{$ELSE}PChar{$ENDIF};
const
  SearchAction : array[Boolean] of TnxSearchKeyAction =
    (skaEqualLast, skaEqualFirst);
var
  lStream        : TnxMemoryStream;

  RecordFound    : Boolean;
  Filter         : TnxBaseFilterEngine;
  KeyFilter      : TnxBaseFilterEngine;
  KeyIndex       : Integer;
  KeyBuffer      : PnxDataSetKeyBuffer;
  FieldCount     : Integer;

  Count          : Integer;
  Size           : Integer;
  OrgSize        : TnxWord32;
  Offset         : TnxWord32;
  OrgPosition    : TnxWord32;
  RecordBuffer   : PnxRecordBuffer;
  RecordLength   : TnxWord32;
  BookmarkLength : TnxWord32;
begin
  aAccess := nil;
  try
    try
      if sbcIsWriteOnly then begin
        Result := sbcGetWriteOnlyResult;
        if Result = DBIERR_NONE then
          Result := DBIERR_RECNOTFOUND;
        Exit;
      end;

      if not Assigned(stcIndexEngine) then begin
        Result := DBIERR_NOASSOCINDEX;
        Exit;
      end;

      Filter := sbcFilter;
      if Assigned(Filter) and not Filter.Active then
        Filter := nil;

      KeyFilter := sbcKeyFilter;
      if Assigned(KeyFilter) and not KeyFilter.Active then
        KeyFilter := nil;

      Result := sbcBeginContentLock(False, False);
      if Result <> DBIERR_NONE then
        Exit;

      with sbcTransContext, stcTable do try
        if Assigned(Filter) or Assigned(KeyFilter) then
          sbcFilterBeginTimeout(@Result);

        if gboBlobs in aOptions then
          if not Assigned(acSFI.sfiBlobFields) then
            Exclude(aOptions, gboBlobs);

        aAccess := CreateBatchStreamAccess(nil, aOptions);
        lStream := aAccess.Stream;

        if aCutoffSize = MaxInt then
          lStream.Capacity := 512*1024
        else
          lStream.Capacity := aCutoffSize;

        RecordLength := TableDescriptor.FieldsDescriptor.RecordLength;

        lStream.WriteBuffer(Result, SizeOf(Result));
        Count := 0;
        lStream.WriteBuffer(Count, SizeOf(Count));

        OrgSize := RecordLength;
        Result := sbcGetBookmarkSize(BookmarkLength);
        if gboBookmarks in aOptions then begin
          Inc(OrgSize, BookmarkLength);
        end else begin
          BookmarkLength := 0;
          Result := DBIERR_NONE;
        end;

        if Result = DBIERR_NONE then begin
          for KeyIndex := Low(aKeys) to High(aKeys) do begin
            KeyBuffer := aKeys[KeyIndex];

            OrgPosition := lStream.Position;
            Size := OrgSize;
            lStream.WriteBuffer(Size, SizeOf(Size));
            OffSet := lStream.Position;
            lStream.Size := lStream.Size + Size;
            RecordBuffer := PnxRecordBuffer(@lStream.ByteArray[Offset]);

            if KeyBuffer.kbDirectKey then begin
              Result := DBIERR_NONE;
              stcIndexEngine.KeyEngine.CopyKey(PnxKeyBuffer(@KeyBuffer.kbBuffer), stcKeyBuffer);
            end else
              Result := stcIndexEngine.KeyEngine.BuildKey
                (PnxRecordBuffer(@KeyBuffer.kbBuffer), stcKeyBuffer, 0, True);

            FieldCount := KeyBuffer.kbFieldCount;
            if FieldCount = 0 then
              FieldCount := stcIndexEngine.KeyEngine.MaxFieldCount;
            if KeyBuffer^.kbPartialLen > 0 then
              Dec(FieldCount);

            if Result = DBIERR_NONE then begin
              repeat
                sbcRecordBufferOrg := nil;
                sbcRecordBufferOrgRefNr := 0;

                if aFirstCall then begin
                  RecordFound := stcIndexEngine.FindKey(sbcTrans^, stcKeyBuffer^,
                    FieldCount, KeyBuffer.kbPartialLen, 0, stcIndexPath,
                    SearchAction[aMatchFirst], KeyFilter) and stcIndexPath.KeyValid;
                  aFirstCall := False;
                end else begin
                  if aMatchFirst then
                    RecordFound := stcIndexEngine.NextKey(sbcTrans^, stcIndexPath, KeyFilter)
                  else
                    RecordFound := stcIndexEngine.PrevKey(sbcTrans^, stcIndexPath, KeyFilter);

                  if RecordFound and (Result = DBIERR_NONE) then
                    RecordFound := stcIndexPath.KeyValid and
                      (stcIndexEngine.KeyEngine.CompareKey(stcKeyBuffer, stcIndexPath.Key,
                        FieldCount, KeyBuffer.kbPartialLen) = nxEqual);
                end;

                if Result = DBIERR_NONE then begin
                  if RecordFound and (stcKeyIsInRange(stcIndexPath.Key) <> nxEqual) then
                    RecordFound := False;

                  if RecordFound then begin
                    sbtRecordEngine.ReadRecord
                      (sbcTrans^, stcIndexPath.RefNr, RecordBuffer);
                    sbcRecordBufferOrg := RecordBuffer;
                    sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
                    Self.NotifyExtenders(eaRecordGet, False, [Ord(nxltNoLock), RecordBuffer, stcIndexPath.RefNr]);
                  end else begin
                    Result := DBIERR_RECNOTFOUND;
                    if aMatchFirst then
                      stcIndexPath.SetToEof
                    else
                      stcIndexPath.SetToBof;
                  end;
                end;

              until (Result <> DBIERR_NONE) or
                not Assigned(Filter) or
                Filter.MatchesBuffer(RecordBuffer) or
                sbcFilterCheckTimeout(Result);
            end;
            sbcRecordBufferOrg := nil;
            sbcRecordBufferOrgRefNr := 0;

            aFirstCall := True;

            { 3 possible situations at this point:
              a) Result = DBIERR_NONE and the record has been written into RecordBuffer
                 -> We continue to the next record
              b) Result = any timeout
                 -> We stop and don't include this record in the result at all
              c) Result = any other error
                 -> We only store that error code for this record, and continue with
                    the next record }

            case Result of
              DBIERR_NONE: begin
                if BookmarkLength > 0 then
                  if acsIsCache in acStates then
                    Result := sbcGetBookmarkCache(@lStream.ByteArray[Offset + RecordLength], BookmarkLength)
                  else
                    Result := sbcGetBookmark(@lStream.ByteArray[Offset + RecordLength], BookmarkLength);

                if (gboBlobs in aOptions) and
                   (Result = DBIERR_NONE)
                then begin
                  Result := sbcCopyBlobsToBatchStream(Size, Offset, lStream, gboBlobNrs in aOptions, gboBlobsOnlyMarked in aOptions);
                  if TnxWord32(Size) <> OrgSize then begin
                    lStream.Position  := OffSet - SizeOf(Size);
                    lStream.WriteBuffer(Size, SizeOf(Size));
                  end;
                end;

              end;
              DBIERR_LOCKTIMEOUT,
              DBIERR_NX_GENERALTIMEOUT,
              DBIERR_NX_FILTERTIMEOUT: begin
                lStream.Position := OrgPosition;
                lStream.Size := OrgPosition;
              end;
            else
              { any other error }
              lStream.Position := OrgPosition;
              lStream.Size := OrgPosition;

              Size := SizeOf(Result);
              Cardinal(Size) := Cardinal(Size) or $80000000; // indicates that no record buffer and/or bookmark is provided
              lStream.WriteBuffer(Size, SizeOf(Size));
              lStream.WriteBuffer(Result, SizeOf(Result));
              Result := DBIERR_NONE;
            end;

            if Result <> DBIERR_NONE then
              Break;

            lStream.Position := lStream.Size;
            Inc(Count);

            if lStream.Position > aCutoffSize then
              Break;
          end;
        end;

        if (Result = DBIERR_NONE) and (Count = Length(aKeys)) then
          if aMatchFirst then
            Result := DBIERR_EOF
          else
            Result := DBIERR_BOF;

        lStream.Position := 0;
        lStream.WriteBuffer(Result, SizeOf(Result));
        lStream.WriteBuffer(Count, SizeOf(Count));

        if Count > 0 then
          Result := DBIERR_NONE;
      finally
        sbcFilterEndTimeout;
        sbcEndContentLock;
        sbcRecordBufferOrg := nil;
        sbcRecordBufferOrgRefNr := 0;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  finally
    if Assigned(aAccess) then
      aAccess.Reset;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordGetNext(aLockType : TnxLockType;
                                               aData     : PnxRecordBuffer)
                                                         : TnxResult;
const
  SearchAction : array[Boolean] of TnxSearchKeyAction =
    (skaGreaterEqual, skaGreater);
var
  Filter    : TnxBaseFilterEngine;
  KeyFilter : TnxBaseFilterEngine;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_EOF;
    Exit;
  end;

  Result := DBIERR_NONE;
  with sbcTransContext, stcTable do try
    if stcIndexPath.IsEof then
      Result := DBIERR_EOF
    else begin
      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then try

        Filter := sbcFilter;
        if Assigned(Filter) and not Filter.Active then
          Filter := nil;

        KeyFilter := sbcKeyFilter;
        if Assigned(KeyFilter) and not KeyFilter.Active then
          KeyFilter := nil;

        if not Assigned(aData) and (Assigned(Filter) or stcRangeEnd.riValid) then
          aData := sbcRecordBuffer;
        sbcRecordBufferOrg := nil;
        sbcRecordBufferOrgRefNr := 0;

        if Assigned(Filter) or Assigned(KeyFilter) then
          sbcFilterBeginTimeout(@Result);

        if Assigned(stcIndexEngine) and stcIndexPath.IsBof then
          with stcRangeStart do
            if riValid then begin
              if not stcIndexEngine.FindKey(sbcTrans^, riKey^, riFieldCount,
                riPartitial, 0, stcIndexPath, SearchAction[riExclusive], KeyFilter) or
                stcIndexPath.IsEof then begin
                stcIndexPath.SetToEof;
                Result := DBIERR_EOF;
                Exit;
              end;
              stcIndexPath.SetToCrackBefore;
            end;

        if Result = DBIERR_NONE then repeat
          if Assigned(stcIndexEngine) then begin
            if not stcIndexEngine.NextKey(sbcTrans^, stcIndexPath, KeyFilter) then
              Result := DBIERR_EOF
            else if Result = DBIERR_NONE then begin
              Assert(stcIndexPath.KeyValid);
              with stcRangeEnd do
                if riValid then
                  case -stcIndexEngine.KeyEngine.CompareKey(riKey, stcIndexPath.Key,
                    riFieldCount, riPartitial) of
                    nxEqual: if riExclusive then Result := DBIERR_EOF;
                    nxGreaterThan: Result := DBIERR_EOF;
                  end;
            end;

            if (Result = DBIERR_NONE) and Assigned(aData) then begin
              sbtRecordEngine.ReadRecord
                (sbcTrans^, stcIndexPath.RefNr, aData);
              sbcRecordBufferOrg := aData;
              sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
            end;
          end else begin
            sbtRecordEngine.ReadNextRecord(sbcTrans^, stcIndexPath.RefNr,
              stcIndexPath.RefNr, aData);
            if stcIndexPath.RefNr = 0 then
              Result := DBIERR_EOF
            else begin
              stcIndexPath.Position := ippOnKey;
              sbcRecordBufferOrg := aData;
              sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
            end;
          end;

          if Result = DBIERR_EOF then
            stcIndexPath.SetToEof;
        until (Result <> DBIERR_NONE) or ((not Assigned(Filter) or
          Filter.MatchesBuffer(aData) or sbcFilterCheckTimeout(Result)));

        if (Result = DBIERR_NONE) and (aLockType <> nxltNoLock) then
          if sbtLocks.GetRecordLock(sbcTrans^,
            Self, stcIndexPath.RefNr, False, sbcLockFailureReason) in lrFailed then begin
              stcIndexPath.SetToCrackBefore;
              Result := sbcLockError(DBIERR_LOCKED);
            end;

        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaRecordGet, False, [Ord(aLockType), aData, stcIndexPath.RefNr]);
      finally
        sbcFilterEndTimeout;
        sbcEndContentLock;
        sbcRecordBufferOrg := nil;
        sbcRecordBufferOrgRefNr := 0;
      end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordGetPrior(aLockType : TnxLockType;
                                                aData     : PnxRecordBuffer)
                                                          : TnxResult;
const
  SearchAction : array[Boolean] of TnxSearchKeyAction =
    (skaSmallerEqual, skaSmaller);
var
  Filter    : TnxBaseFilterEngine;
  KeyFilter : TnxBaseFilterEngine;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_BOF;
    Exit;
  end;

  with sbcTransContext, stcTable do try
    if stcIndexPath.IsBof then
      Result := DBIERR_BOF
    else begin
      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then try
        if Assigned(stcIndexEngine) and stcIndexPath.IsEof then
          with stcRangeEnd do
            if riValid then begin
              if not stcIndexEngine.FindKey(sbcTrans^, riKey^, riFieldCount,
                riPartitial, 0, stcIndexPath, SearchAction[riExclusive], sbcKeyFilter) or
                stcIndexPath.IsBof then begin
                stcIndexPath.SetToBof;
                Result := DBIERR_BOF;
                Exit;
              end;
              stcIndexPath.SetToCrackAfter;
            end;

        Filter := sbcFilter;
        if Assigned(Filter) and not Filter.Active then
          Filter := nil;

        KeyFilter := sbcKeyFilter;
        if Assigned(KeyFilter) and not KeyFilter.Active then
          KeyFilter := nil;

        if not Assigned(aData) and (Assigned(Filter) or stcRangeStart.riValid) then
          aData := sbcRecordBuffer;
        sbcRecordBufferOrg := nil;
        sbcRecordBufferOrgRefNr := 0;

        if Assigned(Filter) or Assigned(KeyFilter) then
          sbcFilterBeginTimeout(@Result);

        repeat
          if Assigned(stcIndexEngine) then begin
            if not stcIndexEngine.PrevKey(sbcTrans^, stcIndexPath, KeyFilter) then
              Result := DBIERR_BOF
            else if Result = DBIERR_NONE then begin
              Assert(stcIndexPath.KeyValid);
              with stcRangeStart do
                if riValid then
                  case -stcIndexEngine.KeyEngine.CompareKey(riKey, stcIndexPath.Key,
                    riFieldCount, riPartitial) of
                    nxSmallerThan: Result := DBIERR_BOF;
                    nxEqual: if riExclusive then Result := DBIERR_BOF;
                  end;
            end;

            if (Result = DBIERR_NONE) and Assigned(aData) then begin
              sbtRecordEngine.ReadRecord
                (sbcTrans^, stcIndexPath.RefNr, aData);
              sbcRecordBufferOrg := aData;
              sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
            end;
          end else begin
            sbtRecordEngine.ReadPrevRecord(sbcTrans^, stcIndexPath.RefNr,
              stcIndexPath.RefNr, aData);
            if stcIndexPath.RefNr = 0 then
              Result := DBIERR_BOF
            else begin
              stcIndexPath.Position := ippOnKey;
              sbcRecordBufferOrg := aData;
              sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;
            end;
          end;

          if Result = DBIERR_BOF then
            stcIndexPath.SetToBof
        until (Result <> DBIERR_NONE) or ((not Assigned(Filter) or
          Filter.MatchesBuffer(aData) or sbcFilterCheckTimeout(Result)));

        if (Result = DBIERR_NONE) and (aLockType <> nxltNoLock) then
          if sbtLocks.GetRecordLock(sbcTrans^,
            Self, stcIndexPath.RefNr, False, sbcLockFailureReason) in lrFailed then begin
              stcIndexPath.SetToCrackAfter;
              Result := sbcLockError(DBIERR_LOCKED);
            end;

        if Result = DBIERR_NONE then
          Self.NotifyExtenders(eaRecordGet, False, [Ord(aLockType), aData, stcIndexPath.RefNr]);
      finally
        sbcFilterEndTimeout;
        sbcEndContentLock;
        sbcRecordBufferOrg := nil;
        sbcRecordBufferOrgRefNr := 0;
      end;
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordInsert(aLockType      : TnxLockType;
                                              aInsertOptions : TnxInsertOptions;
                                              aData          : PnxRecordBuffer;
                                              aAutoInc       : PnxInt64 = nil)
                                                             : TnxResult;
var
  SelfLockResult        : TnxLockResult;
  LockResult            : TnxLockResult;
  LockedRefNr           : TnxRefNr;
  BlobsRecID            : TnxRecID;
  TransactionStarted    : Boolean;
  TransactionRolledBack : Boolean;
  PlacedContentLock     : Boolean;
  CompareResult         : TnxValueRelationship;
  OldAutoIncValue       : TnxWord32;
  AutoIncValue          : TnxWord32;
  IsNull                : Boolean;
  NewRefNr              : TnxRefNr;
  OldIndexPath          : TnxBaseIndexPath;
  OldRecord             : PnxRecordBuffer;
  NewCacheInfo          : TnxRecordCacheInfo;
  OldCacheInfo          : TnxRecordCacheInfo;
  lRecordCount          : TnxWord32;
  {$IFDEF NX_LITE}
  {$I Lite\nxLite12.inc}
  {$ENDIF}
  {$IFDEF __DEBUG}
  i: Integer;
  Value: Variant;
  s: string;
  {$ENDIF}
begin
  if Assigned(aAutoInc) then
    aAutoInc^ := -1;

  sbcRecordBufferOrg := nil;
  sbcRecordBufferOrgRefNr := 0;

  {$IFDEF __DEBUG}
  if Assigned(aData) then begin
    OutputDebugString(PChar('TnxServerTableCursor.sbcRecordInsert / ' + FullName ));
    with TableDescriptor, FieldsDescriptor do
      for i := 0 to Pred(FieldCount) do
        with FieldDescriptor[i] do begin
          Value := FieldByIndexAsVariant[aData, i];
          if VarIsNull(Value) then
            Value := '*** NULL ***'
          else
            if fdType in nxcBlobTypes then begin
              with Int64Rec(PnxInt64(@aData[fdOffset])^) do
                Value := '*** BLOB *** ' + IntToStr(Hi) + ':' + IntToStr(Lo);
            end else if fdType = nxtByteArray then
              Value := '*** BYTES ***';

          try
            s := VarToStr(Value);
          except
            s := '*** EXCEPT ***';
          end;

          OutputDebugString(PChar(Format('  Field #%d "%s" %s [%s]', [i, Name, GetEnumName(TypeInfo(TnxFieldType), Ord(fdType)), s])));
        end;
  end;
  {$ENDIF}

  OldAutoIncValue := 0;
  AutoIncValue := 0;
  TransactionRolledBack := False;
  TransactionStarted := False;
  PlacedContentLock := False;
  OldIndexPath := nil;
  LockResult := lrConflictUnknown;
  LockedRefNr := 0;
  BlobsRecID := ridNull;
  OldRecord := nil;

  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else with sbcTransContext, stcTable do try
    if not sbcForRecover and (roInsert in sbtDenyRecordOperations) then begin
      Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedDataPolicies);
      Exit;
    end;

    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      SelfLockResult := lrConflictUnknown
    else begin
      SelfLockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if SelfLockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      if sbcUseNestedTransaction or
         stcBlobHandler.NeedNested or
         not Assigned(sbcTrans^) or
         (sbcTrans^.stForceNested > 0)
      then begin
        Result := stcTransactionStart(False, False, False, not sbcUseNestedTransaction, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;
      end;

      try
        Result := sbcBeginContentLock(True, False);

        {$IFDEF NX_LITE}
        {$I Lite\nxLite13.inc}
        {$ENDIF}

        if Result = DBIERR_NONE then begin
          PlacedContentLock := True;

          if Assigned(sbcDefaultValueHandler) and (ioSetDefault in aInsertOptions) then
            sbcDefaultValueHandler.SetDefaultValuesInsert(aData);

          if (ioModifyIfFound in aInsertOptions) and
             Assigned(stcIndexEngine) and
             (not stcIndexEngine.Dups or stcIndexEngine.DupsNullOnly)
          then begin
            Result := stcIndexEngine.KeyEngine.BuildKey(aData, stcKeyBuffer, 0, True);
            if Result = DBIERR_NONE then
              if stcIndexEngine.DupsNullOnly and stcIndexEngine.KeyEngine.KeyContainsNulls(stcKeyBuffer) then
                Result := DBIERR_NX_KEYFILTERED;
            if Result = DBIERR_NONE then begin
              OldIndexPath := stcIndexPath.Duplicate;
              if stcIndexEngine.FindKey(sbcTrans^, stcKeyBuffer^, 0, 0, 0, stcIndexPath, skaAnyEqual, nil) then begin
                Exclude(aInsertOptions, ioSetAutoInc);

                LockedRefNr := stcIndexPath.RefNr;
                LockResult := sbtLocks.GetRecordLock
                  (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
                if LockResult in lrFailed then
                  Result := sbcLockError(DBIERR_RECLOCKFAILED);

                if acsIsCache in acStates then
                  BlobsRecID.ridRefNr := stcIndexPath.CacheRefNr
                else
                  BlobsRecID.ridRefNr := LockedRefNr;

                if Result = DBIERR_NONE then
                  if Assigned(sbcKeyFilter) and sbcKeyFilter.Active then
                    if not (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key)) then
                      Result := DBIERR_NOCURRREC;

                if Result = DBIERR_NONE then begin
                  sbtRecordEngine.ReadRecord
                    (sbcTrans^, stcIndexPath.RefNr, sbcRecordBuffer);
                  sbcRecordBufferOrg := sbcRecordBuffer;
                  sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;

                  if Assigned(sbcFilter) and sbcFilter.Active then begin
                    sbcBeginReadOrgOverride;
                    try
                      if not sbcFilter.MatchesBuffer(sbcRecordBuffer) then
                        Result := DBIERR_NOCURRREC;
                    finally
                      sbcEndReadOrgOverride;
                    end;
                  end;

                  OldRecord := sbcRecordBuffer;
                end;

                if not (acsIsCache in acStates) then begin
                  if (Result = DBIERR_NONE) and (sbtSFI.sfiFields[sftRefNr] >= 0) then
                    Result := sbtRefNrUpdate(sbcRecordBuffer, aData, stcIndexPath.RefNr, True);
                  if (Result = DBIERR_NONE) and (sbtSFI.sfiFields[sftRecRev] >= 0) then
                    Result := sbtRecRevUpdate(sbcRecordBuffer, aData, True);
                  if (Result = DBIERR_NONE) and ((sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0)) then
                    Result := sbtLSNUpdate(Self, sbcRecordBuffer, aData, True);
                end else if (ExtractCacheInfo(OldRecord, OldCacheInfo) = DBIERR_NONE) and
                            (ExtractCacheInfo(aData, NewCacheInfo) = DBIERR_NONE) and
                            rciIsSame(OldCacheInfo, NewCacheInfo)
                then
                  Result := DBIERR_NX_CACHE_VALID;

              end else
                Exclude(aInsertOptions, ioModifyIfFound);
            end else begin
              Result := DBIERR_NONE;
              Exclude(aInsertOptions, ioModifyIfFound);
            end;
          end else
            Exclude(aInsertOptions, ioModifyIfFound);

          if Result = DBIERR_NONE then
            if ioModifyIfFound in aInsertOptions then begin
              if not sbcForRecover and (roModify in sbtDenyRecordOperations) then
                Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsModifyDeniedDataPolicies);
            end else begin
              if not sbcForRecover and (sbtMaxRecordCount < High(TnxWord32)) then begin
                sbtRecordEngine.GetRecordCount(sbcTrans^, lRecordCount);
                if lRecordCount >= sbtMaxRecordCount then
                  Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedMaxRecords);
              end;
            end;

          if Result = DBIERR_NONE then
            if not IsCache and
               (sbtSFI.sfiFields[sftAutoInc] >= 0) and
               (ioSetAutoInc in aInsertOptions)
            then with sbtFieldsDescriptor do begin
              GetRecordField(sbtSFI.sfiFields[sftAutoInc], aData, IsNull, @AutoIncValue);
              if IsNull or (AutoIncValue = 0) then begin
                AutoIncValue := sbtAutoIncEngine.NextAutoIncValue(sbcTrans^, @OldAutoIncValue);
                if Assigned(aAutoInc) then
                  aAutoInc^ := AutoIncValue;
                SetRecordField(sbtSFI.sfiFields[sftAutoInc], aData, @AutoIncValue);
              end else
                AutoIncValue := 0;
            end;

          if Result = DBIERR_NONE then
            if ioModifyIfFound in aInsertOptions then
              Result := Self.NotifyExtenders(eaRecordModify, True, [aData, sbcRecordBuffer, aLockType = nxltNoLock, stcIndexPath.RefNr])
            else
              Result := Self.NotifyExtenders(eaRecordInsert, True, [Integer(aLockType), aData, nxInt64Null]);

          if Result = DBIERR_NONE then
            if ioModifyIfFound in aInsertOptions then begin
              if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
                BlobsRecID.ridInsertLSN := PnxLSN(@sbcRecordBuffer[acSFI.sfiOffsets[sftInsertLSN]])^
              else
                BlobsRecID.ridInsertLSN := 0;

              Result := stcBlobHandler.BeforeModify(sbcTrans^, BlobsRecID, sbcRecordBuffer, aData)
            end else
              Result := stcBlobHandler.BeforeInsert(sbcTrans^, aData);

          if Result = DBIERR_NONE then
            if not (ioModifyIfFound in aInsertOptions) then begin
              sbtRefNrInit(aData);
              sbtRecRevInit(aData);
              sbtLSNInit(Self, aData);

              if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
                BlobsRecID.ridInsertLSN := PnxLSN(@aData[acSFI.sfiOffsets[sftInsertLSN]])^
              else
                BlobsRecID.ridInsertLSN := 0;
            end;

          if Result = DBIERR_NONE then begin
            try
              if Assigned(sbcValidationsHandler) and (ioValidate in aInsertOptions) then
                sbcValidationsHandler.ValidateRecord(OldRecord, aData)
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end;

            if aLockType <> nxltNoLock then begin
              Result := stcRecordIsInRange(aData, 0, CompareResult);
              case Result of
                DBIERR_NONE:
                  if CompareResult <> nxEqual then
                    Result := EnxServerEngineException.nxSetMessage(DBIERR_RECLOCKFAILED, nxcOrgMessageMarker + ' Record outside current range. Record not inserted')
                  else
                    if Assigned(sbcFilter) and sbcFilter.Active and
                      not sbcFilter.MatchesBuffer(aData) then
                        Result := EnxServerEngineException.nxSetMessage(DBIERR_RECLOCKFAILED, nxcOrgMessageMarker + ' Record does not match active filter. Record not inserted')
                    else if not sbcKeyFilterMatchesRecord(aData, 0) then
                      Result := EnxServerEngineException.nxSetMessage(DBIERR_RECLOCKFAILED, nxcOrgMessageMarker + ' Record does not match active key filter. Record not inserted');
                DBIERR_NX_KEYFILTERED:
                  Result := EnxServerEngineException.nxSetMessage(DBIERR_RECLOCKFAILED, nxcOrgMessageMarker + ' Record does not match filter on conditional index. Record not inserted');
              end;
            end;

            if Result = DBIERR_NONE then begin
              if ioModifyIfFound in aInsertOptions then
                sbtRecordEngine.UpdateRecord(sbcTrans^, stcIndexPath.RefNr,
                  aData, nil)
              else
                sbtRecordEngine.AddRecord(sbcTrans^, NewRefNr, aData);

              if not Assigned(OldIndexPath) then
                OldIndexPath := stcIndexPath.Duplicate;

              if Assigned(sbtIndicesEngine) then try
                if ioModifyIfFound in aInsertOptions then
                  Result := sbtIndicesEngine.UpdateKeys(sbcTrans^,
                    stcIndexPath.RefNr, sbcRecordBuffer, stcIndexPath.RefNr,
                      aData, stcIndexPath)
                else
                  Result := sbtIndicesEngine.InsertKeys
                    (sbcTrans^, NewRefNr, aData, stcIndexPath);
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end else
                if not (ioModifyIfFound in aInsertOptions) then
                  stcIndexPath.SetToRecord(aData, NewRefNr);

              if (Result = DBIERR_NONE) and Assigned(stcFulltextEngine) then try
                Result := stcFulltextEngine.UpdateIndex
                  (sbcTrans^, OldRecord, 0, aData, NewRefNr);
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end;

              if Result = DBIERR_NONE then
                if not (ioModifyIfFound in aInsertOptions) then
                begin
                  stcRecordResurrect(NewRefNr, aData);
                  if acsIsCache in acStates then
                    BlobsRecID.ridRefNr := stcIndexPath.CacheRefNr
                  else
                    BlobsRecID.ridRefNr := NewRefNr;
                end;

              if Result <> DBIERR_NONE then begin
                if not TransactionStarted then begin
                  if ioModifyIfFound in aInsertOptions then begin
                    sbtRecordEngine.UpdateRecord(sbcTrans^, stcIndexPath.RefNr,
                      sbcRecordBuffer, nil);
                  end else begin
                    sbtRecordEngine.DeleteRecord(sbcTrans^, NewRefNr);
                    if AutoIncValue <> 0 then
                      sbcAutoIncSetDirect(OldAutoIncValue);
                  end;
                end;
              end else begin
                if ioModifyIfFound in aInsertOptions then begin
                  case stcKeyIsInRange(stcIndexPath.Key) of
                    nxSmallerThan, nxGreaterThan: begin
                      stcIndexPath.Assign(OldIndexPath);
                      stcIndexPath.SetToDeleted;
                    end;
                  end;
                  if stcIndexPath.IsOnKey then
                    if (Assigned(sbcFilter) and sbcFilter.Active and not sbcFilter.MatchesBuffer(aData)) or
                      (Assigned(sbcKeyFilter) and sbcKeyFilter.Active and
                        not (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key))) then begin

                      stcIndexPath.Assign(OldIndexPath);
                      stcIndexPath.SetToDeleted;
                    end;

                  if (aLockType <> nxltNoLock) and (not stcIndexPath.IsOnKey or
                    (sbtLocks.GetRecordLock(sbcTrans^, Self,
                    stcIndexPath.RefNr, True, sbcLockFailureReason) in lrFailed)) then begin
                    Result := sbcLockError(DBIERR_RECLOCKFAILED);
                    stcTransactionMarkCorrupted;
                  end else begin
                    Result := Self.NotifyExtenders(eaRecordModify, False,
                      [aData, sbcRecordBuffer, aLockType = nxltNoLock, stcIndexPath.RefNr]);

                    if Result = DBIERR_NONE then begin
                      Result := stcBlobHandler.AfterModify
                        (sbcTrans^, BlobsRecID, sbcRecordBuffer, aData);
                    end;

                    if Result = DBIERR_NONE then begin
                      if TransactionStarted then begin
                        Result := stcTransactionCommit;
                        if Result = DBIERR_NONE then
                          TransactionStarted := False;
                      end;
                    end else
                      stcTransactionMarkCorrupted;
                  end;
                end else begin
                  if (aLockType <> nxltNoLock) and (not stcIndexPath.IsOnKey or
                    (sbtLocks.GetRecordLock(sbcTrans^, Self,
                    stcIndexPath.RefNr, True, sbcLockFailureReason) in lrFailed)) then begin
                    Result := sbcLockError(DBIERR_RECLOCKFAILED);
                    stcTransactionMarkCorrupted;
                  end else begin
                    Result := Self.NotifyExtenders(eaRecordInsert, False, [Integer(aLockType), aData, NewRefNr]);

                    if Result = DBIERR_NONE then begin
                      Result := stcBlobHandler.AfterInsert
                        (sbcTrans^, BlobsRecID, aData);
                    end;

                    if Result = DBIERR_NONE then begin
                      if TransactionStarted then begin
                        Result := stcTransactionCommit;
                        if Result = DBIERR_NONE then
                          TransactionStarted := False;
                      end;
                      if stcIndexPath.KeyValid then
                        case stcKeyIsInRange(stcIndexPath.Key) of
                          nxSmallerThan: stcIndexPath.SetToBof;
                          nxGreaterThan: stcIndexPath.SetToEof;
                        end;
                      if aLockType <> nxltNoLock then
                        LockResult := lrGrantedExisting; //so we don't release it later
                    end else
                      stcTransactionMarkCorrupted;
                  end;
                end;
              end;
            end;
          end;
        end;

      except
        on E : Exception do begin
          Result := Self.asoConvertException(E);
          { something has gone wrong indeed... }
          stcTransactionMarkCorrupted;
        end;
      end;

      if Result <> DBIERR_NONE then begin
        if TransactionStarted then begin
          TransactionRolledBack := True;
          stcTransactionRollback;
        end;
        if Result = DBIERR_NX_CACHE_VALID then
          Result := DBIERR_NONE
        else begin
          if Assigned(OldIndexPath) then
            stcIndexPath.Assign(OldIndexPath);
          if not IsCache and
             (AutoIncValue <> 0)
          then with sbtFieldsDescriptor do
            SetRecordField(sbtSFI.sfiFields[sftAutoInc], aData, nil);
          if Assigned(aAutoInc) then
            aAutoInc^ := -1;
        end;
      end;
    finally
      if SelfLockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);

      if LockResult = lrGrantedNew then
        { If the transaction was rolled back, do NOT pass sbcTrans^ to
          ReleaseRecordLock. Otherwise, if the rolled back transaction was
          a nested transaction, sbcTrans^ will be non-nil and stored inside
          sbtLocks, but the transaction itself does NOT have a transaction
          lock on this table. When the transaction is then later finished
          (comitted or rolled back) sbtLocks will retain a reference to
          an already freed object, resulting in crashed later when it is
          being accessed }
        if PlacedContentLock and not TransactionRolledBack then
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, sbcTrans^)
        else
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, nil);

      nxFreeAndNil(OldIndexPath);
      sbcRecordBufferOrg := nil;
      sbcRecordBufferOrgRefNr := 0;
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordInsertBatch(aStream : TnxCustomMemoryStream)
                                                           : TnxResult;
var
  TransactionStarted : Boolean;
  LockResult         : TnxLockResult;
  Count              : Integer;
  Size               : Integer;
  RecordBuffer       : PnxRecordBuffer;
  BlobLength         : PnxWord32;
  AutoIncValue       : TnxWord32;

  BlobIdx            : Integer;
  BlobFldIdx         : Integer;

  BlobNr             : Int64;
  NewBlobNr          : TnxBlobNr;
  NewRefNr           : TnxRefNr;
  IsNull             : Boolean;
  lRecordCount       : TnxWord32;

  {$IFDEF NX_LITE}
  {$I Lite\nxLite12.inc}
  {$ENDIF}
begin
  TransactionStarted := False;
  with sbcTransContext, stcTable do try
    if not sbcForRecover and (roInsert in sbtDenyRecordOperations) then begin
      Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedDataPolicies);
      Exit;
    end;

    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      if sbcUseNestedTransaction or not Assigned(sbcTrans^) or (sbcTrans^.stForceNested > 0) then begin
        Result := stcTransactionStart(False, False, False, not sbcUseNestedTransaction, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;
      end;

      Result := sbcBeginContentLock(True, False);

      {$IFDEF NX_LITE}
      {$I Lite\nxLite13.inc}
      {$ENDIF}

      if Result = DBIERR_NONE then try
        aStream.Position := SizeOf(TnxCursorID);
        aStream.ReadBuffer(Count, SizeOf(Count));
        if Count < 0 then
          Count := 0;

        if not sbcForRecover and (sbtMaxRecordCount < High(TnxWord32)) then begin
          sbtRecordEngine.GetRecordCount(sbcTrans^, lRecordCount);
          if lRecordCount + TnxWord32(Count) > sbtMaxRecordCount then
            Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsInsertDeniedMaxRecords);
        end;

        while (Count > 0) and (Result = DBIERR_NONE) do begin
          aStream.ReadBuffer(Size, SizeOf(Size));
          RecordBuffer := PnxRecordBuffer(@aStream.ByteArray[aStream.Position]);

          { fixup blobs }
          if Assigned(sbtSFI.sfiBlobFields) then
            with sbtFieldsDescriptor do
              for BlobIdx := Low(sbtSFI.sfiBlobFields) to High(sbtSFI.sfiBlobFields) do begin
                BlobFldIdx := sbtSFI.sfiBlobFields[BlobIdx];
                with FieldDescriptor[BlobFldIdx] do begin
                  GetRecordField(BlobFldIdx, RecordBuffer, IsNull, @BlobNr);
                  if not IsNull then begin
                    BlobLength := Pointer(TnxNativeUInt(aStream.Memory) + {$IFDEF CPUX64}NativeUInt{$ENDIF}(BlobNr));
                    if BlobLength^ < 1 then
                      SetRecordFieldNull(BlobFldIdx, RecordBuffer, True)
                    else with sbtBlobEngine do try
                      AddBlob(sbcTrans^, NewBlobNr);
                      Write(sbcTrans^, NewBlobNr, 0, BlobLength^,
                        Pointer(TnxNativeUInt(BlobLength)+SizeOf(TnxWord32))^);
                      SetRecordField(BlobFldIdx, RecordBuffer, @NewBlobNr);
                    except
                      on E : Exception do
                        Result := Self.asoConvertException(E);
                    end;
                  end;
                end;
              end;

          if Result = DBIERR_NONE then begin
            if Assigned(sbcDefaultValueHandler) and (ioSetDefault in sbcInsertOptions)  then
              sbcDefaultValueHandler.SetDefaultValuesInsert(RecordBuffer);

            if not IsCache and
               (sbtSFI.sfiFields[sftAutoInc] >= 0) and
               (ioSetAutoInc in sbcInsertOptions)
            then with sbtFieldsDescriptor do begin
              GetRecordField(sbtSFI.sfiFields[sftAutoInc], RecordBuffer, IsNull, @AutoIncValue);
              if IsNull or (AutoIncValue = 0) then begin
                AutoIncValue := sbtAutoIncEngine.NextAutoIncValue(sbcTrans^);
                SetRecordField(sbtSFI.sfiFields[sftAutoInc], RecordBuffer, @AutoIncValue);
              end;
            end;

            Result := stcBlobHandler.BeforeInsert(sbcTrans^, RecordBuffer);
            if Result <> DBIERR_NONE then
              Break;

            Result := Self.NotifyExtenders(eaRecordInsert, True, [Integer(nxltNoLock), RecordBuffer, nxInt64Null]);
            if Result <> DBIERR_NONE then
              Break;

            if sbtSFI.sfiFields[sftRecRev] >= 0 then
              sbtRecRevInit(RecordBuffer);
            if sbtSFI.sfiFields[sftRefNr] >= 0 then
              sbtRefNrInit(RecordBuffer);
            if (sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0) then
              sbtLSNInit(Self, RecordBuffer);

            if Assigned(sbcValidationsHandler) and (ioValidate in sbcInsertOptions) then
              sbcValidationsHandler.ValidateRecord(nil, RecordBuffer);

            sbtRecordEngine.AddRecord(sbcTrans^, NewRefNr, RecordBuffer);
            if Assigned(sbtIndicesEngine) then
              Result := sbtIndicesEngine.InsertKeys
                (sbcTrans^, NewRefNr, RecordBuffer, nil);

            if (Result = DBIERR_NONE) and Assigned(stcFulltextEngine) then
              Result := stcFulltextEngine.UpdateIndex
                (sbcTrans^, nil, 0, RecordBuffer, NewRefNr);

            if Result = DBIERR_NONE then begin
              stcRecordResurrect(NewRefNr, RecordBuffer);
              Result := Self.NotifyExtenders(eaRecordInsert, False, [Integer(nxltNoLock), RecordBuffer, NewRefNr]);
            end;

            aStream.Position := aStream.Position + Size;
            Dec(Count);

            if Count mod 100 = 0 then
              nxCheckRemainingTime;
          end;

          {$IFDEF NX_LITE}
          if Count > 0 then begin
            {$I Lite\nxLite13.inc}
          end;
          {$ENDIF}
        end;

        if Result = DBIERR_NONE then begin
          if TransactionStarted then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordIsLocked(aLockType    : TnxLockType;
                                            out aLockPresent : TnxLockPresent)
                                                             : TnxResult;
begin
  aLockPresent := lpNotAtAll;
  Result := stcIndexPath.CheckCurrentState;
  if Result = DBIERR_NONE then
    aLockPresent := stcTable.sbtLocks.IsRecordLocked(Self, stcIndexPath.RefNr);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordLockRelease(aAllLocks    : Boolean;
                                                   aCancelBlobs : Boolean)
                                                                : TnxResult;
var
  lRefNr : TnxRefNr;
begin
  Result := DBIERR_NONE;
  if aAllLocks then begin
    stcTable.sbtLocks.ClearRecordLocks(Self);
    if aCancelBlobs and (accCancelBlobs in acCapabilities) then
      Result := sbcBlobsCancel(0);
  end else begin
    Result := stcIndexPath.CheckCurrentState;
    if Result = DBIERR_NONE then with stcTable do begin
      sbtLocks.ReleaseRecordLock(Self, stcIndexPath.RefNr, nil);
      if aCancelBlobs and (accCancelBlobs in acCapabilities) then begin
        if (acsIsCache in acStates) and (stcIndexPath.CacheRefNr <> 0) then
          lRefNr := stcIndexPath.CacheRefNr
        else
          lRefNr := stcIndexPath.RefNr;
        if lRefNr <> 0 then
          Result := sbcBlobsCancel(lRefNr);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRecordModify(aData        : PnxRecordBuffer;
                                              aReleaseLock : Boolean;
                                              aDataDiff    : PnxRecordDiff)
                                                           : TnxResult;
var
  LockResult            : TnxLockResult;
  LockedRefNr           : TnxRefNr;
  BlobsRecID            : TnxRecID;
  TransactionStarted    : Boolean;
  TransactionRolledBack : Boolean;
  PlacedContentLock     : Boolean;
  CompareResult         : TnxValueRelationship;
  OldIndexPath          : TnxBaseIndexPath;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOCURRREC;
    Exit;
  end;

  if Assigned(aDataDiff) and not (acsIsCacheable in acStates) then begin
    Result := DBIERR_INVALIDPARAM;
    Exit;
  end;

  TransactionRolledBack := False;
  TransactionStarted := False;
  PlacedContentLock := False;
  OldIndexPath := nil;

  sbcRecordBufferOrg := nil;
  sbcRecordBufferOrgRefNr := 0;

  if sbcIsReadOnly then
    Result := sbcGetReadOnlyResult
  else with sbcTransContext, stcTable do try
    if not sbcForRecover and (roModify in sbtDenyRecordOperations) then begin
      Result := EnxBaseException.nxSetMessage(DBIERR_TABLEREADONLY, @rsModifyDeniedDataPolicies);
      Exit;
    end;

    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if not Assigned(aDataDiff) then begin
      if Assigned(sbcDefaultValueHandler) then
        sbcDefaultValueHandler.SetDefaultValuesModify(aData);

      if not aReleaseLock then begin
        Result := stcRecordIsInRange(aData, 0, CompareResult);
        case Result of
          DBIERR_NONE:
            if CompareResult <> nxEqual then
              Result := DBIERR_RECLOCKFAILED
            else if Assigned(sbcFilter) and sbcFilter.Active
              and not sbcFilter.MatchesBuffer(aData) then
                Result := DBIERR_RECLOCKFAILED
            else if not sbcKeyFilterMatchesRecord(aData, stcIndexPath.RefNr) then
              Result := DBIERR_RECLOCKFAILED;
          DBIERR_NX_KEYFILTERED:
            Result := DBIERR_RECLOCKFAILED;
        end;
        if Result <> DBIERR_NONE then
          Exit;
      end;
    end;

    Result := stcIndexPath.CheckCurrentState;
    if Result <> DBIERR_NONE then
      Exit;

    LockedRefNr := stcIndexPath.RefNr;
    if LockedRefNr <> 0 then begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_RECLOCKFAILED);
        Exit;
      end;
    end else
      { don't have a RefNr yet, need to wait till after ValidateIndexPath to
        be sure we have one }
      LockResult := lrConflictUnknown;

    try
      if sbcUseNestedTransaction or stcBlobHandler.NeedNested or
        not Assigned(sbcTrans^) or (sbcTrans^.stForceNested > 0) then begin
        Result := stcTransactionStart(False, False, False, not sbcUseNestedTransaction, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;
      end;

      try
        Result := sbcBeginContentLock(True, False);

        if Result = DBIERR_NONE then begin
          PlacedContentLock := True;

          Result := stcValidateIndexPath;

          { make sure we have a lock}
          if LockResult in lrFailed then begin
            LockedRefNr := stcIndexPath.RefNr;
            if LockedRefNr = 0 then
              Result := DBIERR_NOCURRREC
            else begin
              LockResult := sbtLocks.GetRecordLock
                (sbcTrans^, Self, LockedRefNr, False, sbcLockFailureReason);
              if LockResult in lrFailed then
                Result := sbcLockError(DBIERR_RECLOCKFAILED);
            end;
          end else
            if LockedRefNr <> stcIndexPath.RefNr then
              { this really shouldn't happen... but check just in case... }
              Result := DBIERR_NOCURRREC;

          if acsIsCache in acStates then
            BlobsRecID.ridRefNr := stcIndexPath.CacheRefNr
          else
            BlobsRecID.ridRefNr := LockedRefNr;

          if Result = DBIERR_NONE then
            if Assigned(sbcKeyFilter) and sbcKeyFilter.Active then
              if not (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key)) then
                Result := DBIERR_NOCURRREC;

          if Result = DBIERR_NONE then begin
            sbtRecordEngine.ReadRecord
              (sbcTrans^, stcIndexPath.RefNr, sbcRecordBuffer);
            sbcRecordBufferOrg := sbcRecordBuffer;
            sbcRecordBufferOrgRefNr := stcIndexPath.RefNr;

            if Assigned(sbcFilter) and sbcFilter.Active then begin
              sbcBeginReadOrgOverride;
              try
                if not sbcFilter.MatchesBuffer(sbcRecordBuffer) then
                  Result := DBIERR_NOCURRREC;
              finally
                sbcEndReadOrgOverride;
              end;
            end;

            if Assigned(aDataDiff) then begin
              with aDataDiff^, rdBlobBatch do begin
                Assert(Assigned(rdDiff));
                dciDecompress(DCI, sbcRecordBuffer, rdDiff, aData);
                if Assigned(rdbbRequest) and Assigned(rdbbReply) then
                  Result := BlobBatchApply(aData, rdbbRequest^, rdbbReply^);
                if Assigned(rdFull) then
                  if Result = DBIERR_NONE then
                    nxMove(aData^, rdFull^, acRecordLength);
              end;

              if Result = DBIERR_NONE then begin
                if Assigned(sbcDefaultValueHandler) then
                  sbcDefaultValueHandler.SetDefaultValuesModify(aData);

                if not aReleaseLock then begin
                  Result := stcRecordIsInRange(aData, 0, CompareResult);
                  case Result of
                    DBIERR_NONE:
                      if CompareResult <> nxEqual then
                        Result := DBIERR_RECLOCKFAILED
                      else if Assigned(sbcFilter) and sbcFilter.Active
                        and not sbcFilter.MatchesBuffer(aData) then
                          Result := DBIERR_RECLOCKFAILED
                      else if not sbcKeyFilterMatchesRecord(aData, stcIndexPath.RefNr) then
                        Result := DBIERR_RECLOCKFAILED;
                    DBIERR_NX_KEYFILTERED:
                      Result := DBIERR_RECLOCKFAILED;
                  end;
                end;
              end;
            end;

            if (Result = DBIERR_NONE) and (sbtSFI.sfiFields[sftRefNr] >= 0) then
              Result := sbtRefNrUpdate(sbcRecordBuffer, aData, stcIndexPath.RefNr);
            if (Result = DBIERR_NONE) and (sbtSFI.sfiFields[sftRecRev] >= 0) then
              Result := sbtRecRevUpdate(sbcRecordBuffer, aData);
            if (Result = DBIERR_NONE) and ((sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0)) then
              Result := sbtLSNUpdate(Self, sbcRecordBuffer, aData);
          end;

          if Result = DBIERR_NONE then
            Result := Self.NotifyExtenders(eaRecordModify, True,
              [aData, sbcRecordBuffer, aReleaseLock, stcIndexPath.RefNr]);

          if Result = DBIERR_NONE then begin
            if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
              BlobsRecID.ridInsertLSN := PnxLSN(@aData[acSFI.sfiOffsets[sftInsertLSN]])^
            else
              BlobsRecID.ridInsertLSN := 0;

            Result := stcBlobHandler.BeforeModify
              (sbcTrans^, BlobsRecID, sbcRecordBuffer, aData);
          end;

          if Result = DBIERR_NONE then begin
            sbtRecordEngine.UpdateRecord(sbcTrans^, stcIndexPath.RefNr,
              aData, nil);

            try
              if (Result = DBIERR_NONE) and Assigned(sbcValidationsHandler) then
                sbcValidationsHandler.ValidateRecord(sbcRecordBuffer, aData);
            except
              on E : Exception do
                Result := Self.asoConvertException(E);
            end;

            if Result = DBIERR_NONE then begin
              OldIndexPath := stcIndexPath.Duplicate;

              if Assigned(sbtIndicesEngine) then try
                Result := sbtIndicesEngine.UpdateKeys(sbcTrans^,
                  stcIndexPath.RefNr, sbcRecordBuffer, stcIndexPath.RefNr,
                    aData, stcIndexPath);
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end;

              if (Result = DBIERR_NONE) and Assigned(stcFulltextEngine) then try
                Result := stcFulltextEngine.UpdateIndex
                  (sbcTrans^, sbcRecordBuffer, stcIndexPath.RefNr, aData, stcIndexPath.RefNr);
              except
                on E : Exception do
                  Result := Self.asoConvertException(E);
              end;
            end;

            if Result <> DBIERR_NONE then begin
              if not TransactionStarted then
                sbtRecordEngine.UpdateRecord(sbcTrans^, stcIndexPath.RefNr,
                  sbcRecordBuffer, nil);
            end else begin
              if stcIndexPath.KeyValid then
                case stcKeyIsInRange(stcIndexPath.Key) of
                  nxSmallerThan, nxGreaterThan: begin
                    stcIndexPath.Assign(OldIndexPath);
                    stcIndexPath.SetToDeleted;
                  end;
                end;
              if stcIndexPath.IsOnKey then
                if (Assigned(sbcFilter) and sbcFilter.Active and not sbcFilter.MatchesBuffer(aData)) or
                  (Assigned(sbcKeyFilter) and sbcKeyFilter.Active and
                    not (stcIndexPath.KeyValid and sbcKeyFilter.MatchesBuffer(stcIndexPath.Key))) then begin

                  stcIndexPath.Assign(OldIndexPath);
                  stcIndexPath.SetToDeleted;
                end;

              if not aReleaseLock and (not stcIndexPath.IsOnKey or
                (sbtLocks.GetRecordLock(sbcTrans^, Self,
                stcIndexPath.RefNr, True, sbcLockFailureReason) in lrFailed)) then begin
                Result := sbcLockError(DBIERR_RECLOCKFAILED);
                stcTransactionMarkCorrupted;
              end else begin
                Result := Self.NotifyExtenders(eaRecordModify, False,
                  [aData, sbcRecordBuffer, aReleaseLock, stcIndexPath.RefNr]);

                if Result = DBIERR_NONE then
                  Result := stcBlobHandler.AfterModify
                    (sbcTrans^, BlobsRecID, sbcRecordBuffer, aData);

                if Result = DBIERR_NONE then begin
                  if TransactionStarted then begin
                    Result := stcTransactionCommit;
                    if Result = DBIERR_NONE then
                      TransactionStarted := False;
                  end;
                end else
                  stcTransactionMarkCorrupted;
              end;
            end;

          end;
        end;

      except
        on E : Exception do begin
          Result := Self.asoConvertException(E);
          { something has gone wrong indeed... }
          stcTransactionMarkCorrupted;
        end;
      end;

      if Result <> DBIERR_NONE then begin
        if TransactionStarted then begin
          TransactionRolledBack := True;
          stcTransactionRollback;
        end;
        if Assigned(OldIndexPath) then
          stcIndexPath.Assign(OldIndexPath);
      end else
        if aReleaseLock then
          LockResult := lrGrantedNew;
    finally
      if LockResult = lrGrantedNew then
        { If the transaction was rolled back, do NOT pass sbcTrans^ to
          ReleaseRecordLock. Otherwise, if the rolled back transaction was
          a nested transaction, sbcTrans^ will be non-nil and stored inside
          sbtLocks, but the transaction itself does NOT have a transaction
          lock on this table. When the transaction is then later finished
          (comitted or rolled back) sbtLocks will retain a reference to
          an already freed object, resulting in crashed later when it is
          being accessed }
        if PlacedContentLock and not TransactionRolledBack then
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, sbcTrans^)
        else
          sbtLocks.ReleaseRecordLock(Self, LockedRefNr, nil);
      nxFreeAndNil(OldIndexPath);
      sbcRecordBufferOrg := nil;
      sbcRecordBufferOrgRefNr := 0;
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcRenameField(aFieldNo : Integer;
                                       const aNewName : string)
                                                      : TnxResult;
begin
  if (stcTable.sbtRoot.srtTableScope = tsTempUnnamed) then
    if (stcTable.sbtCursorsHead = Self) and (stcTable.sbtCursorsTail = Self) then
      with TableDescriptor, FieldsDescriptor do begin
        if (aFieldNo < 0) or (aFieldNo >= FieldCount) then begin
          Result := DBIERR_INVALIDDESCNUM;
          Exit;
        end;
        if GetFieldFromName(aNewName) >= 0 then begin
          Result := DBIERR_NAMENOTUNIQUE;
          Exit;
        end;
        stcTable.sbtRoot.srtDictionary.ForceOffReadOnly;
        try
          FieldDescriptor[aFieldNo].ChangeName(aNewName);
        finally
          stcTable.sbtRoot.srtDictionary.ForceOnReadOnly;
        end;
        Result := DBIERR_NONE;
        Exit;
      end;

  Result := inherited sbcRenameField(aFieldNo, aNewName);
end;
{------------------------------------------------------------------------------}
type
  PnxRecoverData = ^TnxRecoverData;
  TnxRecoverData = record
    rdBuffer       : PnxRecordBuffer;
    rdDestCursor   : TnxServerBaseCursor;
    rdFailedCursor : TnxServerBaseCursor;
    rdError        : TnxResult;
    rdTransCount   : Integer;
    rdBlobFields   : TnxList;
    rdFile         : Integer;
    rdBlock        : TnxBlockNumber;
  end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcSetOnRequestClose(aHandler: InxRequestCloseHandler);
begin
  stcTable.sbtCursorsPadlock.Lock;
  try
    inherited sbcSetOnRequestClose(aHandler);
  finally
    stcTable.sbtCursorsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcSetToBegin;
begin
  stcIndexPath.SetToBof;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcSetToBookmark(aBookmark : PnxBookmarkBuffer;
                                               aSize     : TnxWord32;
                                               aIsCache  : Boolean)
                                                         : TnxResult;
begin
  Result := stcIndexPath.SetToBookmark(aBookmark, aSize, aIsCache);

  if (Result = DBIERR_NONE) then
    if stcIndexPath.KeyValid then
      case stcKeyIsInRange(stcIndexPath.Key) of
        nxSmallerThan: stcIndexPath.SetToBof;
        nxGreaterThan: stcIndexPath.SetToEof;
      end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcSetToCursor(aCursor : TnxAbstractCursor)
                                                     : TnxResult;
begin
  Result := DBIERR_NONE;
  if aCursor is TnxServerTableCursor then begin
    if TnxServerTableCursor(aCursor).stcTable <> stcTable then
      Result := DBIERR_DIFFERENTTABLES
    else if TnxServerTableCursor(aCursor).atoLock <> atoLock then
      Result := DBIERR_NOTSAMESESSION
    else
      if TnxServerTableCursor(aCursor).stcIndexEngine = stcIndexEngine then
        stcIndexPath.Assign(TnxServerTableCursor(aCursor).stcIndexPath)
      else begin
        Result := TnxServerTableCursor(aCursor).
          sbcRecordGet(nxltNoLock, sbcRecordBuffer);

        if Result = DBIERR_NONE then
          stcIndexPath.SetToRecord(sbcRecordBuffer,
            TnxServerTableCursor(aCursor).stcIndexPath.RefNr);
      end;

      if (Result = DBIERR_NONE) and stcIndexPath.KeyValid then
          case stcKeyIsInRange(stcIndexPath.Key) of
            nxSmallerThan: stcIndexPath.SetToBof;
            nxGreaterThan: stcIndexPath.SetToEof;
          end;
  end else
    Result := DBIERR_INVALIDHNDL;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.sbcSetToEnd;
begin
  stcIndexPath.SetToEof;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcSetToFilter(aFilter    : TnxBaseFilterEngine;
                                             aKeyFilter : TnxBaseFilterEngine;
                                             aForward   : TnxBoolean)
                                                        : TnxResult;
var
  FilterIteratorData : TnxFilterIteratorData;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOCURRREC;
    Exit;
  end;

  try
    with sbcTransContext, stcTable do begin
      FilterIteratorData.fidFilter := aFilter;
      FilterIteratorData.fidKeyFilter := aKeyFilter;
      FilterIteratorData.fidData := nil;

      Result := sbcBeginContentLock(False, False);
      if Result = DBIERR_NONE then try
        if Assigned(stcIndexEngine) and not (stcIndexEngine.KeyEngine is TnxRefKeyEngine) then begin
          if aForward then
            stcIndexEngine.Iterate(sbcTrans^, stcIndexPath, @FilterIteratorData.fidData, sbcSetToFilterKeyIterator, sbcSetToFilterRecIterator,
              @FilterIteratorData, stcRangeStart, stcRangeEnd, sbcFilter, sbcKeyFilter)
          else
            stcIndexEngine.IterateBackward(sbcTrans^, stcIndexPath, @FilterIteratorData.fidData, sbcSetToFilterKeyIterator, sbcSetToFilterRecIterator,
              @FilterIteratorData, stcRangeStart, stcRangeEnd, sbcFilter, sbcKeyFilter)
        end else begin
          stcIndexPath.SetToRecord(nil, 0);
          if aForward then
            sbtRecordEngine.Iterate(sbcTrans^, stcIndexPath.RefNr, @FilterIteratorData.fidData, sbcSetToFilterRecIterator,
              @FilterIteratorData, sbcFilter)
          else
            sbtRecordEngine.IterateBackward(sbcTrans^, stcIndexPath.RefNr, @FilterIteratorData.fidData, sbcSetToFilterRecIterator,
              @FilterIteratorData, sbcFilter);

          if stcIndexPath.RefNr = 0 then
            stcIndexPath.SetToEof
          else
            if Assigned(stcIndexEngine) then begin
              stcIndexPath.SetToRecord(nil, stcIndexPath.RefNr);
              stcValidateIndexPath;
            end;
        end;
      finally
        sbcEndContentLock;
      end;
    end;

    if stcIndexPath.Position = ippOnKey then
      Result := DBIERR_NONE
    else
      Result := DBIERR_NOCURRREC;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcSetToKey(aSearchAction : TnxSearchKeyAction;
                                          aFieldCount   : Integer;
                                          aPartialLen   : Integer;
                                          aDirectKey    : Boolean;
                                          aKeyData      : PnxKeyOrRecordBuffer)
                                                        : TnxResult;
begin
  if not Assigned(stcIndexEngine) then begin
    Result := DBIERR_NOASSOCINDEX;
    Exit;
  end;

  if aDirectKey then begin
    Result := DBIERR_NONE;
    stcIndexEngine.KeyEngine.CopyKey(PnxKeyBuffer(aKeyData), stcKeyBuffer);
  end else
    Result := stcIndexEngine.KeyEngine.BuildKey
      (PnxRecordBuffer(aKeyData), stcKeyBuffer, 0, True);

  if Result <> DBIERR_NONE then
    Exit;

  Result := sbcBeginContentLock(False, False);
  if Result = DBIERR_NONE then
    with sbcTransContext, stcTable do try
      if stcIndexEngine.FindKey(sbcTrans^, stcKeyBuffer^, aFieldCount,
        aPartialLen, 0, stcIndexPath, aSearchAction, sbcKeyFilter) then begin

        if stcIndexPath.KeyValid then begin
          case stcKeyIsInRange(stcIndexPath.Key) of
            nxSmallerThan: stcIndexPath.SetToBof;
            nxGreaterThan: stcIndexPath.SetToEof;
          end;
        end;

        if stcIndexPath.IsOnKey then
          if aSearchAction in [skaEqualLast, skaSmallerEqual, skaSmaller] then
            stcIndexPath.SetToCrackAfter
          else
            stcIndexPath.SetToCrackBefore
        else
          if aSearchAction in [skaEqualFirst, skaEqualLast] then
            Result := DBIERR_RECNOTFOUND;

      end else begin

        if aSearchAction in [skaEqualLast, skaSmallerEqual, skaSmaller] then
          stcIndexPath.SetToBof
        else
          stcIndexPath.SetToEof;

        if aSearchAction in [skaEqualFirst, skaEqualLast] then
          Result := DBIERR_RECNOTFOUND;

      end;
    finally
      sbcEndContentLock;
    end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcSwitchToIndex(const aIndexName : string;
                                                     aIndexID   : Integer;
                                                     aPosnOnRec : TnxPosnOnRec)
                                                                : TnxResult;
var
  NewIndexEngine : TnxBaseIndexEngine;
  NewIndexPath   : TnxBaseIndexPath;
begin
  Result := DBIERR_NONE;
  with stcTable do try
    if Assigned(sbtIndicesEngine) then with sbtIndicesEngine.Descriptor do begin
      if aIndexName <> '' then begin
        aIndexID := GetIndexFromName(aIndexName);
        if aIndexID < 0 then begin
          Result := DBIERR_NOSUCHINDEX;
          Exit;
        end;
      end;

      if (aIndexID < -1) or (aIndexID > Pred(IndexCount)) then begin
        Result := DBIERR_NOSUCHINDEX;
        Exit;
      end;

      if aIndexID = -1 then
        NewIndexEngine := nil
      else
        NewIndexEngine := sbtIndicesEngine[aIndexID];
    end else begin
      if (aIndexName <> '') or not (Succ(aIndexID) in [0, 1]) then begin
        Result := DBIERR_NOSUCHINDEX;
        Exit;
      end;

      NewIndexEngine := nil;
    end;

    if Assigned(NewIndexEngine) then begin
      if NewIndexEngine.NLSVersionChanged then begin
        Result := EnxBaseException.nxSetMessage(DBIERR_TABLELEVEL, @rsCurrentNLSVersionIndexDisabled);
        Exit;
{$IFNDEF CPUX86}
      end else if NewIndexEngine.ContainsExtended then begin
        Result := EnxBaseException.nxSetMessage(DBIERR_TABLELEVEL, @rsContainsExtendedIndexDisabled);
        Exit;
{$ENDIF}
      end;
    end;

    if aPosnOnRec in [porTrue, porTry] then begin
      if not Assigned(stcIndexPath) then
        Result := DBIERR_NOCURRREC
      else
        Result := sbcRecordGet(nxltNoLock, sbcRecordBuffer);
      if Result <> DBIERR_NONE then begin
        if (ErrCat(Result) <> ERRCAT_LOCKCONFLICT) and (Result <> DBIERR_NX_GENERALTIMEOUT) then
          Result := DBIERR_NOCURRREC;
      end;

      if (aPosnOnRec = porTry) and (
           (Result = DBIERR_NOCURRREC) or
           (Result = DBIERR_RECDELETED) or
           (Result = DBIERR_BOF)  or
           (Result = DBIERR_EOF)
         )
      then begin
        aPosnOnRec := porFalse;
        Result := DBIERR_NONE;
      end;

      if (aPosnOnRec <> porFalse) and (Result <> DBIERR_NONE) then
        Exit;
    end;

    if Assigned(NewIndexEngine) then
      NewIndexPath := NewIndexEngine.CreateIndexPath
    else
      NewIndexPath := TnxBaseIndexPath.CreateStandalone;

    try
      if aPosnOnRec in [porTrue, porTry] then begin
        Result := NewIndexPath.SetToRecord(sbcRecordBuffer, stcIndexPath.RefNr);
        if (Result = DBIERR_NONE) and Assigned(NewIndexEngine) then begin
          Result := sbcBeginContentLock(False, False);
          if Result = DBIERR_NONE then try
            with sbcTransContext do
              NewIndexEngine.ValidateIndexPath(sbcTrans^, NewIndexPath);
            Result := NewIndexPath.CheckCurrentState;
          finally
            sbcEndContentLock;
          end;
        end else
          if Result = DBIERR_NX_KEYFILTERED then
            Result := DBIERR_NOCURRREC;

        if (aPosnOnRec = porTry) and (
             (Result = DBIERR_NOCURRREC) or
             (Result = DBIERR_RECDELETED) or
             (Result = DBIERR_BOF)  or
             (Result = DBIERR_EOF)
           )
        then begin
          NewIndexPath.SetToBof;
          Result := DBIERR_NONE;
        end;
      end else
        NewIndexPath.SetToBof;

      //switching indices always deactivates all key filters
      sbcKeyFilterDeactivate(0);

      if Result = DBIERR_NONE then begin
        if Assigned(stcIndexEngine) then
          with stcIndexEngine.KeyEngine do begin
            FreeKey(stcKeyBuffer);
            FreeKey(stcRangeStart.riKey);
            FreeKey(stcRangeEnd.riKey);
          end;

        stcIndexEngine := NewIndexEngine;
        nxFreeAndNil(stcIndexPath);
        nxFreeAndNil(stcSavePath);
        nxFreeAndNil(stcTempPath);
        stcIndexPath := NewIndexPath;
        NewIndexPath := nil;

        if Assigned(stcIndexEngine) then
          with stcIndexEngine.KeyEngine do begin
            stcKeyBuffer := AllocKey;
            stcRangeStart.riKey := AllocKey;
            stcRangeEnd.riKey := AllocKey;
          end;

        stcRangeStart.riValid := False;
        stcRangeEnd.riValid := False;
      end;
    finally
      nxFreeAndNil(NewIndexPath);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableIsLocked(aLockType : TnxLockType)
                                                         : TnxLockPresent;
begin
  Result := lpNotAtAll;
  case aLockType of
    nxltReadLock:
      Result := stcTable.sbtLocks.IsReadLocked(Self);
    nxltWriteLock:
      Result := stcTable.sbtLocks.IsWriteLocked(Self);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableLockAcquire(aLockType : TnxLockType)
                                                            : TnxResult;
var
  LockResult : TnxLockResult;
begin
  Result := DBIERR_NONE;
  try
    LockResult := lrConflictUnknown;
    with sbcTransContext do
      case aLockType of
        nxltReadLock:
          LockResult := stcTable.sbtLocks.GetReadLock(sbcTrans^, Self, False, sbcLockFailureReason);
        nxltWriteLock:
          LockResult := stcTable.sbtLocks.GetWriteLock(sbcTrans^, Self, False, sbcLockFailureReason);
      end;
    if LockResult in lrFailed then
      Result := sbcLockError(DBIERR_FILELOCKED);
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableLockRelease(aLockType : TnxLockType;
                                                  aAllLocks : Boolean)
                                                            : TnxResult;
begin
  Result := DBIERR_NONE;
  try
    if aAllLocks then
      stcTable.sbtLocks.ClearCursorLocks(Self)
    else with sbcTransContext do
      case aLockType of
        nxltReadLock:
          stcTable.sbtLocks.ReleaseReadLock(Self);
        nxltWriteLock:
          stcTable.sbtLocks.ReleaseWriteLock(Self);
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
function TnxServerTableCursor.sbcTableStreamDelete(const aName     : string;
                                                         aInternal : Boolean)
                                                                   : TnxResult;
var
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
begin
  Result := nxCheckValidIdent(aName, DBIERR_INVALIDNAME, False, aInternal);
  if Result <> DBIERR_NONE then
    Exit;

  with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed or aInternal);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False, aInternal);
        if Result = DBIERR_NONE then begin
          Result := sbtRoot.srtStreamEngine.DeleteNamedStream(sbcTrans^, aName);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableStreamGetList(aStreams  : TStrings;
                                                    aInternal : Boolean)
                                                              : TnxResult;
var
  Streams : TStringList;
  i       : Integer;
begin
  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try

        Streams := TStringList.Create;
        try

          Result := sbtRoot.srtStreamEngine.GetNamedStreamList(sbcTrans^, Streams);

          if Result = DBIERR_NONE then begin
            for i := Pred(Streams.Count) downto 0 do
              if nxCheckValidIdent(Streams[i], DBIERR_INVALIDNAME, False, aInternal) <> DBIERR_NONE then
                Streams.Delete(i);
            aStreams.Assign(Streams);
          end else
            aStreams.Clear;

        finally
          Streams.Free;
        end;

      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableStreamRead(const aName     : string;
                                                       aStream   : TStream;
                                                       aInternal : Boolean)
                                                                 : TnxResult;
begin
  Result := nxCheckValidIdent(aName, DBIERR_INVALIDNAME, False, aInternal);
  if Result <> DBIERR_NONE then
    Exit;

  try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable.sbtRoot do try
        Result := srtStreamEngine.ReadNamedStream(sbcTrans^, aName, aStream);
      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTableStreamWrite(const aName     : string;
                                                        aStream   : TStream;
                                                        aInternal : Boolean)
                                                                  : TnxResult;
var
  LockResult   : TnxLockResult;
  TransactionStarted : Boolean;
begin
  Result := nxCheckValidIdent(aName, DBIERR_INVALIDNAME, False, aInternal);
  if Result <> DBIERR_NONE then
    Exit;

  with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed or aInternal);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False, aInternal);
        if Result = DBIERR_NONE then begin
          Result := sbtRoot.srtStreamEngine.WriteNamedStream
            (sbcTrans^, aName, aStream);

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
    end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.sbcTransContextSet(aTransContext: TnxAbstractTransContext): TnxResult;
begin
  Result := DBIERR_NONE;
  if acTransContext = aTransContext then
    Exit;
  if Assigned(aTransContext) and (aTransContext.Session <> Session) then begin
    Result := DBIERR_NOTSAMESESSION;
    Exit;
  end;

  if Assigned(stcTransLink) then begin
    Result := DBIERR_ACTIVETRAN;
    Exit;
  end;

  acRemoveFromTransContext;
  acTransContext := aTransContext;
  acAddToTransContext;

  if Assigned(aTransContext) then
    sbcTransContext := aTransContext as TnxServerTransContext
  else
    sbcTransContext := Database.TransContext as TnxServerTransContext;
  sbcTrans := @sbcTransContext.stcTransaction;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcContainsLSNRefNr(var aLSN   : TnxLSN;
                                                  var aRefNr : TnxRefNr)
                                                             : TnxResult;
var
  lLSN    : TnxLSN;
  lRefNr  : TnxRefNr;
  lIsNull : Boolean;
begin
  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOTSUFFTABLERIGHTS;
    Exit;
  end;

  if (aLSN <> 0) and Assigned(stcLSNIndexPath) then begin
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try
        if stcLSNIndexEngine.FindKey(sbcTrans^, aLSN, 0, 0, 0, stcLSNIndexPath, skaAnyEqual, nil) and
           stcLSNIndexPath.IsOnKey
        then begin
          if acsIsCache in acStates then
            lRefNr := stcLSNIndexPath.CacheRefNr
          else
            lRefNr := stcLSNIndexPath.RefNr;

          if aRefNr = 0 then
            aRefNr := lRefNr
          else
            if aRefNr <> lRefNr then
              Result := DBIERR_KEYORRECDELETED;
        end else
          Result := DBIERR_RECNOTFOUND;
      finally
        sbcEndContentLock;
      end;
  end else if (aRefNr <> 0) and Assigned(stcRefNrIndexPath) then begin
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try
        if stcRefNrIndexEngine.FindKey(sbcTrans^, aRefNr, 0, 0, 0, stcRefNrIndexPath, skaAnyEqual, nil) and
           stcRefNrIndexPath.IsOnKey
        then begin
          if not Assigned(sbcRecordBuffer2) then
            sbcRecordBuffer2 := stcTable.sbtRecordAllocator.Alloc;

          sbtRecordEngine.ReadRecord(sbcTrans^, aRefNr, sbcRecordBuffer2);
          sbtFieldsDescriptor.GetRecordField(acSFI.sfiFields[sftModifyLSN] , sbcRecordBuffer2, lIsNull, @lLSN);
          if not lIsNull then begin
            if aLSN = 0 then
              aLSN := lLSN
            else
              if aLSN <> lLSN then
                Result := DBIERR_KEYORRECDELETED;
          end;
        end else
          Result := DBIERR_RECNOTFOUND;
      finally
        sbcEndContentLock;
      end;
  end else
    Result := DBIERR_NOASSOCINDEX;
end;
{------------------------------------------------------------------------------}
type
  TnxGetDeletedRecordsIteratorData = record
    gdriCacheInfos : PnxRecordCacheInfos;
    gdriMaxCount   : Integer;
    gdriBufferCount: Integer;
    gdriCount      : Integer;
    gdriEof        : Boolean;
  end;
  PnxGetDeletedRecordsIteratorData = ^TnxGetDeletedRecordsIteratorData;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcGetDeletedRecords(aFromLSN    : TnxLSN;
                                               out aCacheInfos : TnxRecordCacheInfos;
                                                   aMaxCount   : Integer = High(Integer);
                                                   aCurrentLSN : PnxLSN = nil)
                                                               : TnxResult;
var
  lRangeStart : TnxRangeInfo;
  lCookie     : TnxGetDeletedRecordsIteratorData;
begin
  SetLength(aCacheInfos, 0);
  if Assigned(aCurrentLSN) then
    aCurrentLSN^ := 0;

  if sbcIsWriteOnly then begin
    Result := sbcGetWriteOnlyResult;
    if Result = DBIERR_NONE then
      Result := DBIERR_NOTSUFFTABLERIGHTS;
    Exit;
  end;

  if not Assigned(stcGraveyardLSNIndexPath) then
    Result := DBIERR_NOASSOCINDEX
  else begin
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with lCookie, lRangeStart do try
        riValid      := aFromLSN <> 0;
        if riValid
          then riKey := @aFromLSN
          else riKey := nil;
        riFieldCount := 1;
        riPartitial  := 0;
        riExclusive  := True;

        gdriCacheInfos  := @aCacheInfos;
        gdriMaxCount    := aMaxCount;
        gdriBufferCount := Min(1024*1024, aMaxCount);
        gdriCount       := 0;
        gdriEof         := True;
        SetLength(gdriCacheInfos^, gdriBufferCount);

        stcGraveyardLSNIndexEngine.Iterate(sbcTrans^, stcGraveyardLSNIndexPath, nil,
          stcGetDeletedRecordsKeyIterator, nil, @lCookie, lRangeStart, nxEmptyRangeInfo,
          nil, nil, False);

        if gdriBufferCount > gdriCount then
          SetLength(gdriCacheInfos^, gdriCount);

        if (gdriCount = 0) and gdriEof then
          Result := DBIERR_EOF;

        if Assigned(aCurrentLSN) then
          if gdriEof then
            aCurrentLSN^ := stcGetCurrentLSN
          else if gdriCount > 0 then
            aCurrentLSN^ := aCacheInfos[Pred(gdriCount)].rciModifyLSN;
      finally
        sbcEndContentLock;
      end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcAddField(aFieldDesc: TnxFieldDescriptor): TnxResult;
var
  TransactionStarted : Boolean;
  Dict               : TnxServerDataDict;
begin
  with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if not sbtRecordEngine.CanAddField(aFieldDesc) then
      Result := DBIERR_NOTSUPPORTED
    else if sbtRoot.srtDictionary.Version < 3 then
      Result := DBIERR_TABLELEVEL
    else if not sbtTableDescriptor.IsFieldDescValid(aFieldDesc) then
      Result := DBIERR_INVALIDFLDDESC
    else if sbtTableDescriptor.GetFieldFromName(aFieldDesc.Name) <> -1 then
      Result := DBIERR_NAMENOTUNIQUE
    else if (sbtTableDescriptor.FieldsDescriptor.FieldCount - sbtTableDescriptor.FieldsDescriptor.OriginalFieldCount) >= 255 then
      Result := DBIERR_FLDLIMIT
    else begin
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin

          sbtRoot.srtDictionary.ForceOffReadOnly;
          with sbtTableDescriptor, FieldsDescriptor, AddField(aFieldDesc) do begin

            Dict := TnxServerDataDict.Create;
            Dict.Assign(sbtRoot.srtDictionary);
            Dict.CheckValid(True);

            if not Dict.IsEqual(sbtRoot.srtDictionary) then begin
              //remove the field descriptor again
              with sbtRoot, srtDictionary do begin
                ForceOffReadOnly;
                RemoveField(Number);
                ForceOnReadOnly;
              end;
              Result := DBIERR_NOTSUPPORTED
            end else
              with sbtRoot, srtDictionary do try
                ForceOnReadOnly; // prevent any further changes
                srtSetFileMaxID;
                WriteToFile(srtStreamEngine, sbcTrans^, nxVersionNumber);
              except

                //remove the field descriptor again
                ForceOffReadOnly;
                RemoveField(Number);
                ForceOnReadOnly;

                raise;
              end;

          end;

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted
      else
        if (sbtRoot.srtTableScope < tsTempUnnamed) and (acDatabase is TnxServerDatabase) then
          TnxServerDatabase(acDatabase).sdStructureGenerationInc(sbtRoot.srtTableScope < tsTempDatabase);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcAddIndex(aIndexDesc    : TnxIndexDescriptor;
                                          aIsNewDefault : Boolean = False)
                                                        : TnxResult;
var
  TransactionStarted : Boolean;
  OldDefault         : Integer;
  OldID              : Integer;
begin
  with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if sbtRoot.srtDictionary.Version < 3 then
      Result := DBIERR_TABLELEVEL
    else if not sbtTableDescriptor.IsIndexDescValid(aIndexDesc) then
      Result := DBIERR_INVALIDIDXDESC
    else if sbtTableDescriptor.GetIndexFromName(aIndexDesc.Name) <> -1 then
      Result := DBIERR_INDEXEXISTS
    else if assigned(sbtTableDescriptor.IndicesDescriptor) and
      (sbtTableDescriptor.IndicesDescriptor.IndexCount = nxcl_MaxIndexes) then
      Result := DBIERR_INDEXLIMIT
    else begin

      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin

          OldID := sbtRoot.srtDictionary.CurrentID;
          sbtRoot.srtDictionary.ForceOffReadOnly;
          with sbtTableDescriptor, EnsureIndicesDescriptor, AddIndex(aIndexDesc) do begin
            OldDefault := DefaultIndex;
            if aIsNewDefault then
              DefaultIndex := Number;

            with sbtRoot, srtDictionary do try
              IncID;
              ForceOnReadOnly; // prevent any further changes
              srtSetFileMaxID;
              WriteToFile(srtStreamEngine, sbcTrans^, nxVersionNumber);
            except

              //remove the index descriptor again
              ForceOffReadOnly;
              if aIsNewDefault then
                DefaultIndex := OldDefault;
              RemoveIndex(Number);
              if IndexCount = 0 then
                RemoveIndicesDescriptor;
              RestoreID(OldID);
              ForceOnReadOnly;

              raise;
            end;

            if not Assigned(sbtIndicesEngine) then
              sbtIndicesEngine := TnxBaseIndicesEngine.CreateEngine
                (sbtTableDescriptor, sbtBlockAccess, sbtRecordEngine, sbcTrans^, True)
            else
              sbtIndicesEngine.AddIndex(sbcTrans^, Number);
          end;

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted
      else
        if (sbtRoot.srtTableScope < tsTempUnnamed) and (acDatabase is TnxServerDatabase) then
          TnxServerDatabase(acDatabase).sdStructureGenerationInc(sbtRoot.srtTableScope < tsTempDatabase);
    end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.stcAddToTable;
begin
  stcTable.sbtCursorsPadlock.Lock;
  try
    stcTablePrev := stcTable.sbtCursorsTail;
    stcTable.sbtCursorsTail := Self;
    if Assigned(stcTablePrev) then
      stcTablePrev.stcTableNext:=Self;
    if not Assigned(stcTable.sbtCursorsHead) then
      stcTable.sbtCursorsHead := Self;
    Inc(stcTable.sbtCursorCount);

    if stcTable.sbtRoot = stcTable then begin
      stcTable.sbtRoot.srtIncCursorCount;
    end else begin
      stcTable.sbtRoot.sbtCursorsPadlock.Lock;
      try
        stcTable.sbtRoot.srtIncCursorCount;
      finally
        stcTable.sbtRoot.sbtCursorsPadlock.Unlock;
      end;
    end;
  finally
    stcTable.sbtCursorsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.stcAddToTransLink;
begin
  Assert(stcTransLinkPrev = nil);
  Assert(stcTransLinkNext = nil);
  Assert(stcTransLink <> nil);
  Assert(stcTransLink.ttlCursorsHead <> Self);
  Assert(stcTransLink.ttlCursorsTail <> Self);

  stcTransLinkPrev := stcTransLink.ttlCursorsTail;
  stcTransLink.ttlCursorsTail := Self;
  if Assigned(stcTransLinkPrev) then
    stcTransLinkPrev.stcTransLinkNext:=Self;
  if not Assigned(stcTransLink.ttlCursorsHead) then
    stcTransLink.ttlCursorsHead := Self;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcBlobBatchProcess(const aRequest : TnxBlobBatchRequest;
                                                    var aReply   : TnxBlobBatchReply)
                                                                 : TnxResult;
var
  LockResult         : TnxLockResult;
  TransactionStarted : Boolean;
  lEntriesCount      : Integer;
  lEntryIdx          : Integer;
begin
  with sbcTransContext, stcTable do begin
    Result := sbcCheckTransactionState;

    if Result <> DBIERR_NONE then
      Exit;

    if stcShareMode = smExclusive then
      LockResult := lrConflictUnknown
    else begin
      LockResult := sbtLocks.GetRecordLock
        (sbcTrans^, Self, stcSelfRefNr, False, sbcLockFailureReason);
      if LockResult in lrFailed then begin
        Result := sbcLockError(DBIERR_FILELOCKED);
        Exit;
      end;
    end;

    try
      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      TransactionStarted := Result = DBIERR_NONE;
      if not TransactionStarted then
        Exit;

      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then begin
          Result := stcBlobVerifyRecID(aRequest.bbrqRecID, False);
          if Result = DBIERR_NONE then begin
            lEntriesCount := Length(aRequest.bbrqEntries);
            lEntryIdx := 0;
            while lEntryIdx < lEntriesCount do begin
              Result := stcBlobBatchProcessEntry(
                aRequest.bbrqRecID,
                aRequest.bbrqEntries[lEntryIdx],
                aReply.bbrpEntries[lEntryIdx]
              );
              if Result = DBIERR_NONE then begin
                Inc(lEntryIdx);
                aReply.bbrpCount := lEntryIdx;
              end else
                Break;
            end;
          end;

          if Result = DBIERR_NONE then begin
            Result := stcTransactionCommit;
            if Result = DBIERR_NONE then
              TransactionStarted := False;
          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then
        if TransactionStarted then
          stcTransactionRollback
        else
          stcTransactionMarkCorrupted;
    finally
      if LockResult = lrGrantedNew then
        sbtLocks.ReleaseRecordLock(Self, stcSelfRefNr, nil);
      sbcRecordBufferBlobVerify := nil;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcBlobBatchProcessEntry(const aRecID   : TnxRecID;
                                                       const aRequest : TnxBlobBatchRequestEntry;
                                                         var aReply   : TnxBlobBatchReplyEntry)
                                                                      : TnxResult;
var
  lLen: Integer;
begin
  with aRequest, aReply do begin
    bbrpeBlobNr := bbrqeBlobNr;

    Result := stcBlobVerifyNrInner(aRecID, bbrqeFieldNo, bbrqeBlobNr, False, nil);
    if (Result = DBIERR_INVALIDBLOBHANDLE) and
       (bbrqeBlobNr = 0) and
       (bbrqeStateInfo in [cbsiCreated, cbsiCreatedFile])
    then
      Result := DBIERR_NONE;

    if Result = DBIERR_NONE then begin
      case bbrqeStateInfo of
        cbsiCreated, cbsiModified: begin
          lLen := Length(bbrqeData);
          if lLen > 0 then
            Result := stcBlobHandler.BlobReplace(sbcTrans^, aRecID, bbrqeFieldNo, bbrpeBlobNr, lLen, bbrqeData[0])
          else
            Result := stcBlobHandler.BlobReplace(sbcTrans^, aRecID, bbrqeFieldNo, bbrpeBlobNr, 0, Pointer(nil)^);
        end;
        cbsiCreatedFile: begin
          Result := stcBlobHandler.BlobCreateFile(sbcTrans^, aRecID, bbrqeFieldNo, bbrqeFileName, bbrpeBlobNr);
        end;
        cbsiDeleted: begin
          Result := stcBlobHandler.BlobDelete(sbcTrans^, aRecID, bbrqeFieldNo, bbrpeBlobNr);
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcBlobVerifyNr(const aRecID     : TnxRecID;
                                                    aFieldNo   : TnxInt32;
                                              const aBlobNr    : TnxBlobNr;
                                                    aReadOrg   : Boolean;
                                                    aNewBlobNr : PnxNewBlobNr)
                                                               : TnxResult;
begin
  if (aRecID.ridRefNr <> 0) and
     (aFieldNo >= 0) and
     not ridIsSame(stcDeletingBlobsRecID, aRecID)
  then begin
    if aBlobNr = 0 then
      Result := DBIERR_INVALIDBLOBHANDLE
    else begin
      Result := stcBlobVerifyRecID(aRecID, aReadOrg);
      try
        if Result = DBIERR_NONE then
          Result := stcBlobVerifyNrInner(aRecID, aFieldNo, aBlobNr, aReadOrg, aNewBlobNr);
      finally
        sbcRecordBufferBlobVerify := nil;
      end;
    end;
  end else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcBlobVerifyNrInner(const aRecID     : TnxRecID;
                                                         aFieldNo   : TnxInt32;
                                                   const aBlobNr    : TnxBlobNr;
                                                         aReadOrg   : Boolean;
                                                         aNewBlobNr : PnxNewBlobNr)
                                                                    : TnxResult;
var
  lBlobNr : PnxBlobNr;

  procedure SetMessage;
  var
    lNewBlobNr: TnxBlobNr;
  begin
    if Assigned(lBlobNr)
      then lNewBlobNr := lBlobNr^
      else lNewBlobNr := 0;

    Result := EnxBaseException.nxSetMessage(DBIERR_BLOBMODIFIED, nxcOrgMessageMarker + ' (BlobVerifyNr)' + sLineBreak
      + sLineBreak + ' Table: "' + FullName + '"'
      + sLineBreak + ' Field[' + IntToStr(aFieldNo) + ']: "' + FieldsDescriptor.FieldDescriptor[aFieldNo].Name + '"'
      + sLineBreak + ' BlobNr to verify: ' + Format('%d / $%x', [aBlobNr, aBlobNr])
      + sLineBreak + ' BlobNr in record: ' + Format('%d / $%x', [lNewBlobNr, lNewBlobNr])
      );
  end;

begin
  Result := DBIERR_NONE;
  if aFieldNo >= 0 then begin
    if aBlobNr = 0 then
      Result := DBIERR_INVALIDBLOBHANDLE
    else try
      if (aRecID.ridRefNr = 0) or
         ridIsInsert(aRecID) or
         not Assigned(sbcRecordBufferBlobVerify)
      then
        lBlobNr := nil
      else
        { assumption: the RecID has already been verified and the correct record loaded into sbcRecordBufferBlobVerify }
        lBlobNr := FieldsDescriptor.GetRecordFieldForFilter(aFieldNo, sbcRecordBufferBlobVerify);

      if not Assigned(lBlobNr) or (lBlobNr^ <> aBlobNr) then begin
        { The BlobNr in the record is different. Give the BlobHandler a chance
          to verify the number in case it's a new blob. }
        if not stcBlobHandler.BlobVerifyNr(sbcTrans^, aRecID, aFieldNo, aBlobNr, aReadOrg) then begin
          SetMessage;
          if Assigned(aNewBlobNr) then with aNewBlobNr^ do begin
            if Assigned(lBlobNr)
              then nbnBlobNr := lBlobNr^
              else nbnBlobNr := 0;
            nbnSet := True;
          end;
        end;
      end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcBlobVerifyRecID(const aRecID   : TnxRecID;
                                                       aReadOrg : Boolean)
                                                                : TnxResult;
begin
  sbcRecordBufferBlobVerify := nil;

  Result := DBIERR_NONE;
  if (aRecID.ridRefNr <> 0) and not (ridIsInsert(aRecID) or ridIsSame(stcDeletingBlobsRecID, aRecID)) then try
    if    aReadOrg
      and Assigned(sbcRecordBufferOrg)
      and (sbcRecordBufferOrgRefNr = aRecID.ridRefNr)
    then begin
      sbcRecordBufferBlobVerify := sbcRecordBufferOrg;
    end else begin
      if not Assigned(sbcRecordBuffer2) then
        sbcRecordBuffer2 := stcTable.sbtRecordAllocator.Alloc;

      if Assigned(stcSeqAccessIndexPath) then begin
        if stcSeqAccessIndexEngine.FindKey(sbcTrans^, aRecID.ridRefNr, 0, 0, 0,
             stcSeqAccessIndexPath, skaAnyEqual, nil)
        then
          stcTable.sbtRecordEngine.ReadRecord(sbcTrans^, stcSeqAccessIndexPath.RefNr, sbcRecordBuffer2)
        else begin
          Result := DBIERR_KEYORRECDELETED;
          Exit;
        end;
      end else
        stcTable.sbtRecordEngine.ReadRecord(sbcTrans^, aRecID.ridRefNr, sbcRecordBuffer2);
      sbcRecordBufferBlobVerify := sbcRecordBuffer2;
    end;

    if acSFI.sfiOffsets[sftInsertLSN] >= 0 then
      if aRecID.ridInsertLSN <> PnxLSN(@sbcRecordBuffer2[acSFI.sfiOffsets[sftInsertLSN]])^ then begin
        Result := DBIERR_KEYORRECDELETED;
        sbcRecordBufferBlobVerify := nil;
        Exit;
      end;

  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcCreateBulkBuilder(out aBulkBuilder : TnxBaseBulkBuilder
                                                       {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                                                       ;
                                                       aException   : PPointer
                                                       {$ENDIF}     )
                                                                    : TnxResult;
begin
  aBulkBuilder := nil;
  Result := DBIERR_NONE;
  try
    with stcTable do
      if Assigned(sbtIndicesEngine) then
        aBulkBuilder := sbtIndicesEngine.CreateBulkBuilder(sbcTrans^{$IFDEF NX_INDEX_BUILD_MULTITHREADED}, aException{$ENDIF});
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcDropIndex(const aIndexName : string;
                                                 aIndexID   : Integer)
                                                            : TnxResult;
var
  TransactionStarted : Boolean;
  {OldID              : Integer;}
begin
  with sbcTransContext, stcTable do try
    Result := sbcCheckTransactionState;
    if Result <> DBIERR_NONE then
      Exit;

    if aIndexName <> '' then
      aIndexID := sbtTableDescriptor.GetIndexFromName(aIndexName);

    if sbtRoot.srtDictionary.Version < 3 then
      Result := DBIERR_TABLELEVEL
    else if not assigned(sbtTableDescriptor.IndicesDescriptor) then
      Result := DBIERR_NOTINDEXED
    else with sbtTableDescriptor.IndicesDescriptor do
      if (aIndexID < 0) or (aIndexID > Pred(IndexCount)) then
        Result := DBIERR_NOSUCHINDEX
      else begin
        Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
        TransactionStarted := Result = DBIERR_NONE;
        if not TransactionStarted then
          Exit;

        try
          Result := sbcBeginContentLock(True, False);
          if Result = DBIERR_NONE then begin

            sbcSwitchToIndex('', -1, porFalse);

            {OldID := sbtRoot.srtDictionary.CurrentID;}
            sbtRoot.srtDictionary.ForceOffReadOnly;
            sbtTableDescriptor.IndicesDescriptor.RemoveIndex(aIndexID);
            sbtIndicesEngine.RemoveIndex(sbcTrans^, aIndexID);
            if sbtTableDescriptor.IndicesDescriptor.IndexCount < 1 then begin
              nxFreeAndNil(sbtIndicesEngine);
              sbtTableDescriptor.RemoveIndicesDescriptor;
            end;
            with sbtRoot do begin
              srtDictionary.IncID;
              srtSetFileMaxID;
              srtDictionary.ForceOnReadOnly;
              srtDictionary.WriteToFile(srtStreamEngine, sbcTrans^, nxVersionNumber);
            end;

            if Result = DBIERR_NONE then begin
              Result := stcTransactionCommit;
              if Result = DBIERR_NONE then
                TransactionStarted := False;
            end;

            if Assigned(sbtTableDescriptor.IndicesDescriptor) then
              sbcSwitchToIndex('', sbtTableDescriptor.IndicesDescriptor.DefaultIndex, porFalse);
          end;
        except
          on E : Exception do
            Result := Self.asoConvertException(E);
        end;
        if Result <> DBIERR_NONE then
          if TransactionStarted then
            stcTransactionRollback
          else
            stcTransactionMarkCorrupted
        else
          if (sbtRoot.srtTableScope < tsTempUnnamed) and (acDatabase is TnxServerDatabase) then
            TnxServerDatabase(acDatabase).sdStructureGenerationInc(sbtRoot.srtTableScope < tsTempDatabase);
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcGetBlobLinkHandler: TnxBaseBlobLinkHandler;
begin
  if Assigned(acTransContext) then begin
    if not Assigned(stcBlobLinkHandler) then
      stcBlobLinkHandler := TnxBlobLinkHandler.Create(TnxServerDatabase(acDatabase), @sbcTransContext);
    Result := stcBlobLinkHandler;
  end else
    Result := TnxServerDatabase(Database).sdBlobLinkHandler;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcGetBlobs(aData       : PnxRecordBuffer;
                                          aMarkedOnly : Boolean;
                                      var aBlobCount  : TnxWord16;
                                          aBlobNrs    : PnxBlobNr)
                                                      : TnxResult;
var
  lMarkedBlobs: Pointer;
begin
  if (
        aMarkedOnly and
        not Assigned(acMarkedBlobs)
     ) or
     not Assigned(stcBlobHandler) or
     (stcBlobHandler is TnxNullBlobHandler)
  then begin
    Result := DBIERR_NONE;
    aBlobCount := 0;
  end else try
    Result := sbcBeginContentLock(False, False);
    if Result = DBIERR_NONE then
      with sbcTransContext, stcTable do try
        if aMarkedOnly then
          lMarkedBlobs := Pointer(acMarkedBlobs)
        else
          lMarkedBlobs := nil;
        Result := stcBlobHandler.GetBlobs(sbcTrans^, aData, lMarkedBlobs,
          aBlobCount, aBlobNrs);
      finally
        sbcEndContentLock;
      end;
  except
    on E : Exception do
      Result := Self.asoConvertException(E);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcGetCurrentLSN: TnxLSN;
begin
  Result := 0;
  if not Assigned(sbcTrans) then
    Exit;

  Result := stcTable.sbtRoot.CurrentLSN[sbcTrans^];
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcGetDeletedRecordsKeyIterator(aCookie : Pointer;
                                                              aRefNr  : TnxRefNr;
                                                              aKey    : PnxKeyBuffer)
                                                                      : TnxKeyIteratorResult;
var
  lCookie : PnxGetDeletedRecordsIteratorData absolute aCookie;
  lLSN    : PnxLSN absolute aKey;
begin
  with lCookie^ do begin
    if gdriCount = gdriMaxCount then begin
      gdriEof := False;
      Result := kirStop;
      Exit;
    end else
      Result := kirSkipKey;

    if gdriCount = gdriBufferCount then begin
      gdriBufferCount := Min(2 * gdriBufferCount, gdriMaxCount);
      SetLength(gdriCacheInfos^, gdriBufferCount);
    end;

    with gdriCacheInfos^[gdriCount] do begin
      rciRefNr := aRefNr;
      rciModifyLSN := lLSN^;
    end;

    Inc(gdriCount);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcKeyIsInRange(aKey : PnxKeyBuffer)
                                                   : TnxValueRelationship;
begin
  Result := nxEqual;
  if not Assigned(stcIndexEngine) then
    Exit;

  with stcRangeStart do
    if riValid then
      case -stcIndexEngine.KeyEngine.CompareKey(riKey, aKey, riFieldCount, riPartitial) of
        nxEqual:
          if riExclusive then Result := nxSmallerThan;
        nxSmallerThan:
          Result := nxSmallerThan;
      end;
  if Result = nxEqual then
    with stcRangeEnd do                                                                                   
      if riValid then
        case -stcIndexEngine.KeyEngine.CompareKey(riKey, aKey, riFieldCount, riPartitial) of
          nxEqual:
            if riExclusive then Result := nxGreaterThan;
          nxGreaterThan:
            Result := nxGreaterThan;
        end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcRecordIsInRange(aRecord : PnxRecordBuffer;
                                           const aRefNr  : TnxRefNr;
                                             out aRel    : TnxValueRelationship)
                                                         : TnxResult;
begin
  if Assigned(stcIndexEngine) then begin
    Result :=
      stcIndexEngine.KeyEngine.BuildKey(aRecord, stcKeyBuffer, aRefNr, False);
    aRel := stcKeyIsInRange(stcKeyBuffer);
  end else begin
    Result := DBIERR_NONE;
    aRel := nxEqual;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcRecordResurrect(aRefNr : TnxRefNr;
                                                 aData  : PnxRecordBuffer)
                                                        : TnxResult;
var
  lLSN: TnxLSN;
begin
  Result := DBIERR_NONE;
  if Assigned(stcGraveyardLSNIndexPath) and
     Assigned(stcGraveyardRefNrIndexPath)
  then begin
    if stcGraveyardRefNrIndexEngine.FindKey(sbcTrans^, aRefNr, 0, 0, 0,
         stcGraveyardRefNrIndexPath, skaAnyEqual, nil)
    then begin
      Result := DBIERR_NX_CORRUPTTRANS;
      lLSN := stcGraveyardRefNrIndexPath.RefNr;
      if stcGraveyardRefNrIndexEngine.DeleteKey(sbcTrans^, aRefNr, lLSN,
           0, stcGraveyardRefNrIndexPath)
      then begin
        if stcGraveyardLSNIndexEngine.FindKey(sbcTrans^, lLSN, 0, 0, 0,
             stcGraveyardLSNIndexPath, skaAnyEqual, nil)
        then begin
          if stcGraveyardLSNIndexEngine.DeleteKey(sbcTrans^, lLSN, aRefNr,
               0, stcGraveyardLSNIndexPath)
          then begin
            Result := DBIERR_NONE;
          end;
        end;
      end;
    end;
  end;
  if Result = DBIERR_NX_CORRUPTTRANS then
    Result := EnxBaseException.nxSetMessage(DBIERR_NX_CORRUPTTRANS,
      @rsTheGraveyardIsCorruptedCouldNotRemove);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcRecoverRecordsIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
var
  i                  : Integer;
  BrokenBlobFields   : TnxList;
  Offset             : TnxWord32;
  BlobField          : Integer;
  IsNull             : Boolean;
  SrcBlobNr          : TnxBlobNr;
  BlobNr             : TnxBlobNr;
  TransactionStarted : Boolean;

begin
  BrokenBlobFields := nil;
  BlobField := -1;
  try
    with PnxRecoverData(aCookie)^ do begin
      Assert(rdTransCount = 1);

      rdError := rdDestCursor.sbcTransContext.stcTransactionStart(False, False, False, False, False, rdDestCursor.IsResultSet);
      if rdError = DBIERR_NONE then begin
        Inc(rdTransCount);
        try
          nxMove(rdBuffer^, TnxServerBaseCursor(rdDestCursor).sbcRecordBuffer^, TableDescriptor.FieldsDescriptor.RecordLength);

          if Assigned(rdBlobFields) then
            for i := 0 to Pred(rdBlobFields.Count) do begin
              TransactionStarted := False;
              BlobField := Integer(rdBlobFields[i]);
              try
                Offset := Self.TableDescriptor.FieldsDescriptor.FieldDescriptor[BlobField].fdOffset;

                Self.TableDescriptor.FieldsDescriptor.GetRecordField(BlobField,
                  rdBuffer, IsNull, @SrcBlobNr);

                if not IsNull then begin
                  rdError := rdDestCursor.sbcTransContext.stcTransactionStart(False, False, False, False, False, rdDestCursor.IsResultSet);
                  if rdError = DBIERR_NONE then begin
                    TransactionStarted := True;
                    rdError := TnxServerBaseCursor(rdDestCursor).sbcBlobCopyPrim(Self, BlobField, SrcBlobNr, BlobField, BlobNr);
                    if rdError = DBIERR_NONE then begin
                      PnxInt64(@TnxServerBaseCursor(rdDestCursor).sbcRecordBuffer^[Offset])^ := BlobNr;
                      rdError := rdDestCursor.sbcTransContext.stcTransactionCommit;
                      if rdError = DBIERR_NONE then
                        TransactionStarted := False;
                    end;
                  end;
                end;
              except
                on E : Exception do
                  rdError := Self.asoConvertException(E);
              end;

              if rdError <> DBIERR_NONE then begin
                if not Assigned(BrokenBlobFields) then
                  BrokenBlobFields := TnxList.Create;
                BrokenBlobFields.Add(Pointer(BlobField));

                Self.TableDescriptor.FieldsDescriptor.SetRecordField(BlobField,
                  TnxServerBaseCursor(rdDestCursor).sbcRecordBuffer, nil);
              end;

              if TransactionStarted then begin
                Assert(rdError <> DBIERR_NONE);
                rdDestCursor.sbcTransContext.stcTransactionRollback;
              end;

              if Assigned(BrokenBlobFields) then
                break;
            end;

          if not Assigned(BrokenBlobFields) then
            rdError := rdDestCursor.sbcRecordInsert(nxltNoLock, [ioValidate], TnxServerBaseCursor(rdDestCursor).sbcRecordBuffer);

          if (rdError <> DBIERR_NONE) or
              Assigned(BrokenBlobFields) then begin
            rdDestCursor.sbcTransContext.stcTransactionRollback;
            Dec(rdTransCount);
            rdError := rdDestCursor.sbcTransContext.stcTransactionStart(False, False, False, False, False, rdDestCursor.IsResultSet);
            if rdError = DBIERR_NONE then begin
              Inc(rdTransCount);

              nxMove(rdBuffer^, TnxServerBaseCursor(rdFailedCursor).sbcRecordBuffer^, TableDescriptor.FieldsDescriptor.RecordLength);

              if Assigned(rdBlobFields) then
                for i := 0 to Pred(rdBlobFields.Count) do begin
                  TransactionStarted := False;
                  try
                    BlobField := Integer(rdBlobFields[i]);
                    Offset := Self.TableDescriptor.FieldsDescriptor.FieldDescriptor[BlobField].fdOffset;

                    Self.TableDescriptor.FieldsDescriptor.GetRecordField(BlobField,
                      rdBuffer, IsNull, @SrcBlobNr);

                    if not IsNull then begin
                      rdError := rdDestCursor.sbcTransContext.stcTransactionStart(False, False, False, False, False, rdDestCursor.IsResultSet);
                      if rdError = DBIERR_NONE then begin
                        TransactionStarted := True;
                        rdError := TnxServerBaseCursor(rdFailedCursor).sbcBlobCopyPrim(Self, BlobField, SrcBlobNr, BlobField, BlobNr);
                        if rdError = DBIERR_NONE then begin
                          PnxInt64(@TnxServerBaseCursor(rdFailedCursor).sbcRecordBuffer^[Offset])^ := BlobNr;
                          rdError := rdDestCursor.sbcTransContext.stcTransactionCommit;
                          if rdError = DBIERR_NONE then
                            TransactionStarted := False;
                        end;
                      end;
                    end;
                  except
                    on E : Exception do
                      rdError := Self.asoConvertException(E);
                  end;

                  if rdError <> DBIERR_NONE then begin
                    Self.TableDescriptor.FieldsDescriptor.SetRecordField(BlobField,
                      TnxServerBaseCursor(rdFailedCursor).sbcRecordBuffer, nil);
                  end;

                  if TransactionStarted then begin
                    Assert(rdError <> DBIERR_NONE);
                    rdDestCursor.sbcTransContext.stcTransactionRollback;
                  end;

                end;

              rdError := rdFailedCursor.sbcRecordInsert(nxltNoLock, [], TnxServerBaseCursor(rdFailedCursor).sbcRecordBuffer);
            end;
          end;

        except
          on E : Exception do
            rdError := Self.asoConvertException(E);
        end;

        if rdTransCount = 2 then
          if rdError = DBIERR_NONE then begin
            rdError := rdDestCursor.sbcTransContext.stcTransactionCommit;
            if rdError = DBIERR_NONE then
              Dec(rdTransCount);
          end else
            rdDestCursor.sbcTransContext.stcTransactionRollback;

      end;

      if rdError = DBIERR_NONE then
        Result := rirContinue
      else
        Result := rirStop;

{      if Result = rirContinue then begin
        if Integer(sbcTrans^.BlockCount) > rdMaxTrans then begin
          rdError := rdDestCursor.sbcTransContext.stcTransactionCommit;
          if rdError = DBIERR_NONE then begin
            Dec(rdTransCount);
            rdError := rdDestCursor.sbcTransContext.stcTransactionStart(False, False);
            if rdError = DBIERR_NONE then
              Inc(rdTransCount);
          end;
          if rdError = DBIERR_NONE then
            Result := rirContinue
          else
            Result := rirStop;
        end;
      end;}
    end;
  finally
    if Assigned(BrokenBlobFields) then
      BrokenBlobFields.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.stcRemoveFromTable;
var
  CheckInactive : Boolean;
begin
  if Assigned(stcTable) then begin
    LockedInc(stcTable.sbtLockIsInactive);
    try
      stcTable.sbtCursorsPadlock.Lock;
      try
        if Assigned(stcTableNext) then
          stcTableNext.stcTablePrev := stcTablePrev
        else
          if stcTable.sbtCursorsTail = Self then
            stcTable.sbtCursorsTail := stcTablePrev;

        if Assigned(stcTablePrev) then
          stcTablePrev.stcTableNext := stcTableNext
        else
          if stcTable.sbtCursorsHead = Self then
            stcTable.sbtCursorsHead := stcTableNext;

        stcTableNext := nil;
        stcTablePrev := nil;

        Dec(stcTable.sbtCursorCount);

        if stcTable.sbtRoot = stcTable then begin
          stcTable.sbtRoot.srtDecCursorCount;
        end else begin
          stcTable.sbtRoot.sbtCursorsPadlock.Lock;
          try
            stcTable.sbtRoot.srtDecCursorCount;
          finally
            stcTable.sbtRoot.sbtCursorsPadlock.Unlock;
          end;
        end;

        CheckInactive := stcTable.sbtRoot.srtIsInactive(False, False, 1) and not stcTable.sbtRoot.asoDestroying;
      finally
        stcTable.sbtCursorsPadlock.Unlock;
      end;

      if CheckInactive then
        if
    {$ifdef AllowInactiveCleanup}
          (seoCloseInactiveTables in TnxServerEngine(asoGetServerEngine).seOptions) or
    {$endif}
          (stcTable.sbtRoot.srtTableScope  = tsTempUnnamed) then
          with stcTable, sbtRoot.srtFolder, sfTablesPadlock do begin
            Lock;
            try
              LockedDec(stcTable.sbtLockIsInactive);
              if sbtRoot.srtIsInactive(False, False, 0) then begin
                stcTable.sbtRoot.Free;
                stcTable := nil;
              end else
                stcTable := nil;
            finally
              Unlock;
            end;
          end;
    finally
      if Assigned(stcTable) then
        LockedDec(stcTable.sbtLockIsInactive);
    end;
  end;

  stcTable := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableCursor.stcRemoveFromTransLink;
begin
  if Assigned(stcTransLinkNext) then
    stcTransLinkNext.stcTransLinkPrev := stcTransLinkPrev
  else
    if stcTransLink.ttlCursorsTail = Self then
      stcTransLink.ttlCursorsTail := stcTransLinkPrev;

  if Assigned(stcTransLinkPrev) then
    stcTransLinkPrev.stcTransLinkNext := stcTransLinkNext
  else
    if stcTransLink.ttlCursorsHead = Self then
      stcTransLink.ttlCursorsHead := stcTransLinkNext;

  stcTransLinkNext := nil;
  stcTransLinkPrev := nil;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcSortEnginePutIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
var
  Error : TnxResult;
begin
  Result := rirContinue;
  Error := TnxBaseSortEngine(aCookie).Put(aRecord);
  if Error <> DBIERR_NONE then
    raise EnxServerEngineException.nxCreate(Error);
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcSortRecords(aIndexDesc : TnxIndexDescriptor)
                                                        : TnxResult;
var
  SortEngine   : TnxBaseSortEngine;
begin
  Assert(not Assigned(stcIndexEngine));

  SortEngine := nxcSortEngineClass.Create(TnxServerDatabase(acDatabase), stcTable.sbtRoot.srtDictionary, aIndexDesc);
  try
    with sbcTransContext, stcTable do begin
      Result := stcTransactionStart(False, False, sbtRoot.srtTableScope  <> tsPersistent, True, False, IsResultSet or IsUnnamed);
      if Result <> DBIERR_NONE then
        Exit;
      try
        sbcIterate(@sbcRecordBuffer, nil, stcSortEnginePutIterator, False, SortEngine);
        Result := stcTransactionCommit;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then begin
        stcTransactionRollback;
        Exit;
      end;

      Result := stcTransactionStart(False, False, False, True, False, IsResultSet or IsUnnamed);
      if Result <> DBIERR_NONE then
        Exit;
      try
        Result := sbcBeginContentLock(True, False);
        if Result = DBIERR_NONE then
          sbtRecordEngine.ReplaceAllRecords(sbcTrans^, SortEngine.Get);

        if SortEngine.Get(nil) <> DBIERR_EOF then
          Result := DBIERR_NX_Unknown; {should never happen}

        if Result = DBIERR_NONE then
          Result := stcTransactionCommit;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;

      if Result <> DBIERR_NONE then begin
        stcTransactionRollback;
        Exit;
      end;

      stcIndexPath.SetToBof;
    end;
  finally
    nxFreeAndNil(SortEngine);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableCursor.stcValidateIndexPath: TnxResult;
begin
  if Assigned(stcIndexEngine) then begin
    stcIndexEngine.ValidateIndexPath(sbcTrans^, stcIndexPath);
    if stcIndexPath.KeyValid then
      case stcKeyIsInRange(stcIndexPath.Key) of
        nxSmallerThan: stcIndexPath.SetToBof;
        nxGreaterThan: stcIndexPath.SetToEof;
      end;
  end;
  Result := stcIndexPath.CheckCurrentState;
end;
{==============================================================================}



{===TnxServerStatement=========================================================}
constructor TnxServerStatement.Create(aDatabase : TnxSqlAbstractDatabase;
                                      aTimeout  : TnxWord32);
begin
  inherited Create(aDatabase, aTimeout);
end;
{==============================================================================}



{===TnxBaseAliasHandler========================================================}
procedure TnxBaseAliasHandler.GetConfigSettings(aSettings: TnxBaseSettings);
begin
  inherited;
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='Aliases';
    DefaultValue:='';
    SettingType:=nxstAliases;
    PropertyName:='Aliases';
  end;    // with
end;
{------------------------------------------------------------------------------}
function TnxBaseAliasHandler.IsAlias(const aAlias: string): Boolean;
var
  Path: string;
begin
  Result := GetPath(aAlias, Path) = DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseAliasHandler.LoadConfig(aConfig: TnxBaseComponentConfiguration);
var
  I : Integer;
  lStringlist : TStringList;
  laliases: string;
  lAlias: string;
  lPath: string;
begin
  inherited;
  laliases:=aConfig.GetValue('Aliases', laliases);
  lStringlist:=TStringlist.Create;
  try
    lStringList.Text:=StringReplace(lAliases, ';', #13, [rfReplaceAll]);
    Clear;
    for I := 0 to lStringlist.Count - 1 do begin    // Iterate
      lAlias:=lStringlist.Names[i];
      lPath:=lStringlist.Values[lAlias];

      if nxCheckValidIdent(lAlias, DBIERR_INVALIDALIASNAME, False, True) <> DBIERR_NONE then
        aConfig.Config.Errors:=aConfig.Config.Errors+
          'ERROR: AliasName "'+lAlias+'" is not valid. Alias has not been activated in the server engine.'#13#10
      else begin
        if (lPath<>'') and (lPath[1]<>'#') then
          if not DirectoryExists(lPath) then
            aConfig.Config.Errors:=aConfig.Config.Errors+
              'WARNING: Database folder for "'+lAlias+'" does not exist: "'+lPath+#13#10;

        Add(lAlias, lPath, False);
      end;
    end;    // for
  finally
    lStringlist.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseAliasHandler.LoadSettingsFromStream(aReader: TnxReader);
var
  lAlias: string;
  lPath: string;
  Version: Integer;
begin
  inherited;

  Clear;

  with aReader do begin
    Version := ReadInteger; // version
    if Version <> 1 then
      raise EnxComponentException.nxCreate(DBIERR_NX_INCOMPATSTREAM);
    ReadListBegin;
    while not EndOfList do
    begin
      lAlias:=ReadString;
      lPath:=Readstring;

      Add(lAlias, lPath, False);
    end;
    ReadListEnd;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseAliasHandler.SaveConfig(aConfig: TnxBaseComponentConfiguration);
var
  List : TObjectList;
  I : Integer;
  lStringlist : TStringList;
  laliases: string;
  lAlias: string;
  lPath: string;
begin
  inherited;
  laliases:=aConfig.GetValue('Aliases', laliases);
  lStringlist:=TStringlist.Create;
  List := TObjectList.Create;
  try
    GetList(List);
    for I := 0 to List.Count - 1 do begin    // Iterate
      lAlias:=TnxAliasDescriptor(List[i]).adAlias;
      lPath:=TnxAliasDescriptor(List[i]).adPath;

      lStringlist.Add(lAlias+'='+lPath);
    end;    // for
    lAliases:=StringReplace(lStringlist.Text, #13, ';', [rfReplaceAll]);
    lAliases:=StringReplace(lAliases, #10, '', [rfReplaceAll]);
    aConfig.SetValue('Aliases', lAliases);
  finally
    lStringlist.Free;
    List.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseAliasHandler.SaveSettingsToStream(aWriter: TnxWriter);
var
  i    : Integer;
  List : TObjectList;
begin
  inherited;

  List := TObjectList.Create;
  try
    GetList(List);
    with aWriter do begin
      WriteInteger(1); // version
      WriteListBegin;
      for i := Pred(List.Count) downto 0 do
        with TnxAliasDescriptor(List[i]) do begin
          WriteString(adAlias);
          WriteString(adPath);
        end;
      WriteListEnd;
    end;
  finally
    List.Free;
  end;
end;
{==============================================================================}



{===TnxSimpleAliasHandler======================================================}
type
  TnxAliasItem = class(TnxObject)
    Path: string;
    constructor Create(const aPath: string);
  end;
{------------------------------------------------------------------------------}
constructor TnxAliasItem.Create(const aPath: string);
begin
  Path := aPath;
  inherited Create;
end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxSimpleAliasHandler.Add(const aAlias, aPath: string; aEnforce: Boolean): TnxResult;
var
  Index: Integer;
begin
  nxcDependentList.BeginWrite;
  try
    with sahList do
      if Find(aAlias, Index) then
        Result := DBIERR_NAMENOTUNIQUE
      else begin
        Result := DBIERR_NONE;
        if aEnforce then
          if not ForceDirectories(aPath) then begin
            Result := DBIERR_DIRNOACCESS;
            Exit;
          end;
        AddObject(aAlias, TnxAliasItem.Create(aPath));
      end;
  finally
    nxcDependentList.EndWrite;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSimpleAliasHandler.Clear;
var
  i: Integer;
  anObject: TObject;
begin
  for i := Pred(sahList.Count) downto 0 do
  begin
    anObject:=sahList.Objects[i];
    anObject.Free;
    sahList.Objects[i]:=nil;
  end;
  sahList.Clear;
end;
{------------------------------------------------------------------------------}
constructor TnxSimpleAliasHandler.Create(aOwner: TComponent);
begin
  sahList := TStringList.Create;
  sahList.Sorted := True;
  sahList.Duplicates := dupError;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSimpleAliasHandler.Delete(const aAlias: string): TnxResult;
var
  Index: Integer;
begin
  nxcDependentList.BeginWrite;
  try
    with sahList do
      if Find(aAlias, Index) then begin
        Objects[Index].Free;
        Delete(Index);
        Result := DBIERR_NONE;
      end else
        Result := DBIERR_UNKNOWNDB;
  finally
    nxcDependentList.EndWrite;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxSimpleAliasHandler.Destroy;
begin
  if Assigned(sahList) then
    Clear;
  nxFreeAndNil(sahList);
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSimpleAliasHandler.GetList(aList: TObjectList): TnxResult;
var
  TempDesc : TnxAliasDescriptor;
  Index    : Integer;
begin
  nxcDependentList.BeginRead;
  try
    Result := DBIERR_NONE;
    with sahList do
      for Index := 0 to Pred(Count) do begin
        TempDesc := TnxAliasDescriptor.Create;
        with TempDesc do begin
          adAlias := Strings[Index];
          adPath := TnxAliasItem(Objects[Index]).Path;
        end;
        aList.Add(TempDesc);
      end;
  finally
    nxcDependentList.EndRead;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSimpleAliasHandler.GetPath(const aAlias : string;
                                         var aPath  : string)
                                                    : TnxResult;
var
  Index: Integer;
begin
  nxcDependentList.BeginRead;
  try
    with sahList do
      if Find(aAlias, Index) then begin
        aPath := TnxAliasItem(Objects[Index]).Path;
        Result := DBIERR_NONE;
      end else
        Result := DBIERR_UNKNOWNDB;
  finally
    nxcDependentList.EndRead;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSimpleAliasHandler.Modify(const aAlias   : string;
                                      const aNewName : string;
                                      const aNewPath : string;
                                            aEnforce : Boolean)
                                                     : TnxResult;
var
  Index: Integer;
  Path: string;
begin
  nxcDependentList.BeginWrite;
  try
    if aNewPath = '' then
      Result := GetPath(aAlias, Path)
    else begin
      Result := DBIERR_NONE;
      Path := aNewPath;
    end;

    if Result = DBIERR_NONE then
      if (aAlias = aNewName) or (aNewName = '') then begin
        with sahList do
          if Find(aAlias, Index) then begin
            if aEnforce then
              if not ForceDirectories(Path) then begin
                Result := DBIERR_DIRNOACCESS;
                Exit;
              end;
            TnxAliasItem(Objects[Index]).Path := Path;
            Result := DBIERR_NONE;
          end else
            Result := DBIERR_UNKNOWNDB;
      end else
        if sahList.Find(aNewName, Index) then
          Result := DBIERR_NAMENOTUNIQUE
        else begin
          Result := Delete(aAlias);
          if Result = DBIERR_NONE then
            Result := Add(aNewName, Path, aEnforce);
        end;
  finally
    nxcDependentList.EndWrite;
  end;
end;
{==============================================================================}



{===TnxServerEngine============================================================}
function TnxServerEngine.bseCreateInstanceFor(aSession     : TnxAbstractSession;
                                        const aName        : string;
                                        const aClassID     : TnxGuid;
                                        const aOuter       : InxInterface;
                                        const aInterfaceID : TnxGuid;
                                          out aInterface   )
                                                           : HRESULT;
begin
  if SameText(aName, '<AliasHandler>') then
    Result := seAliasHandler.nxcCreateInstance(aSession, aClassID, aOuter, aInterfaceID, aInterface)
  else if SameText(aName, '<Registry>') then begin
    if Assigned(nxRegistryClassActivator) then
      Result := nxRegistryClassActivator.CreateInstance(aClassID, aOuter, aInterfaceID, aInterface)
    else
      RESULT := E_NOTIMPL;
  end else
    Result := inherited bseCreateInstanceFor(aSession, aName, aClassID, aOuter, aInterfaceID, aInterface);
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.bseGetExceptionClass: EnxExceptionClass;
begin
  Result := EnxServerEngineException;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.bseGetKeepSessionStats: Boolean;
begin
  Result := seoKeepSessionStats in seOptions;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.bseGetServerGuid: TnxGuid;
begin
  Result := seServerGuid;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.bseGetServerName: string;
begin
  Result := seServerName;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.bseInactive;
begin
  inherited;
  if seoCloseAllWhenInactive in seOptions then begin
    seCloseInactiveTables;
    seCloseInactiveFolders;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxServerEngine.Create(aOwner: TComponent);
begin
  if not Succeeded(CoCreateGUID(seServerGuid)) then
    seServerGuid := nxNullGuid;

  seMaxRAM := -1;
  seTempStoreSize := -1;

  seTableExtension := 'nx1';

  seFoldersPadlock := TnxPadlock.Create(True);

  seFolders := TStringList.Create;
  seFolders.Sorted := True;
  seFolders.Duplicates := dupError;

  seInactiveTablesPadlock := TnxPadlock.Create(True);
  seInactiveFoldersPadlock := TnxPadlock.Create(True);

  inherited;
  seSetAliasHandler(seCreateAliasHandler);
end;
{------------------------------------------------------------------------------}
destructor TnxServerEngine.Destroy;
begin
  inherited;

  nxFreeAndNil(seFolders);
  nxFreeAndNil(seFoldersPadlock);

  nxFreeAndNil(seBufferManager);

  nxFreeAndNil(seAliasHandler);

  nxFreeAndNil(seInactiveTablesPadlock);
  nxFreeAndNil(seInactiveFoldersPadlock);
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.GetDisplayOnlyValue(aValueName: string): string;
begin
  if sametext(aValueName, 'ActiveOptions') then
  begin
    result:='';
    {$ifdef NX_MM_USE_FASTMM4}
    result:=result+', NX_MM_USE_FASTMM4';
    {$ifdef FullDebugMode}
    result:=result+' (FullDebugMode)';
    {$endif};
    {$endif};
    {$ifdef SecureServer}
    result:=result+', SecureServer';
    {$endif}
    {$ifdef NX_DEBUG}
    result:=result+', NX_DEBUG';
    {$endif}
    {$ifdef NX_PROTECT_SERVER_ON_CRITICAL_ERROR}
    result:=result+', NX_PROTECT_SERVER_ON_CRITICAL_ERROR';
    {$endif}
    {$ifdef NX_TRIAL}
    result:=result+', NX_TRIAL';
    {$endif}
    {$ifdef ExtendedLiterals}
    result:=result+', ExtendedLiterals';
    {$endif}
    {$ifdef StarterEdition}
    result:=result+', StarterEdition';
    {$endif}
    {$IFDEF NX_BDE_REPLACEMENT_EDITION}
    result:=result+', BDE Replacement Edition';
    {$ENDIF}

    if nxIsAWESupported then
      result:=result+', NX_MM_SUPPORT_AWE';

    if Disable30900LocaleFixes then
      result:=result+', Disable30900LocaleFixes';

    Result := copy(result, 3, length(result));
  end else
  if sametext(aValueName, 'ServerEngine Version') then
    Result := Version
  else
    Result := inherited GetDisplayOnlyValue(aValueName);
end;
{------------------------------------------------------------------------------}
type
  TnxTableLockContainerAccess = class(TnxTableLockContainer);

function TnxServerEngine.GetRecordLockInfo: TnxRecordLockInfoArray;
var
  FolderIndex,
  TableIndex   : Integer;
  Folder       : TnxServerFolder;
  Table        : TnxServerRootTable;
  TLCA         : TnxTableLockContainerAccess;
  idx          : Integer;

  procedure PopulateCommonRecordInfo(aCursor : TnxServerTableCursor);
  begin
    SetLength(Result, Succ(Length(Result)));
    with Result[High(Result)] do begin
      rliDatabasePath := Folder.Path;
      rliTablename := Table.srtName;
      rliConnectedFrom :=  TnxServerSession(aCursor.Session).asConnectedFrom;
      rliClientInfo := TnxServerSession(aCursor.Session).asLock.slExceptionHookInfo.ehiClient;
//      rliQuery := TnxServerSession(aCursor.Session).asLock.slExceptionHookInfo.ehiQuery;
    end;
  end;

begin
  SetLength(Result, 0);

  seFoldersPadlock.Lock;
  try
    for FolderIndex := 0 to Pred(seFolders.Count) do begin
      Folder := TnxServerFolder(seFolders.Objects[FolderIndex]);

      Folder.sfTablesPadlock.Lock;
      try
        for TableIndex := 0 to Pred(Folder.sfTables.Count) do begin
          Table := TnxServerRootTable(Folder.sfTables.Objects[TableIndex]);

          TLCA := TnxTableLockContainerAccess(Table.sbtLocks);
          TLCA.tlcGate.Lock;
          try
            with TLCA do begin
              for idx := 0 to Pred(tlcRecordLockListCount) do begin
                PopulateCommonRecordInfo(tlcRecordLockList[idx].rlCursor as TnxServerTableCursor);
                with Result[High(Result)] do begin
                  rliLockType := 'Record';
                  rliLockedAt := tlcRecordLockList[idx].rlLockedAt;
                  rliCursorID := TnxInt64(@tlcRecordLockList[idx].rlCursor);
                  rliRefnr := TnxInt64(@tlcRecordLockList[idx].rlRefNr);
                end;
              end;

              for idx := 0 to Pred(tlcReadLockListCount) do begin
                PopulateCommonRecordInfo(tlcReadLockList[idx].clCursor as TnxServerTableCursor);
                with Result[High(Result)] do begin
                  rliLockType := 'Read';
                  rliLockedAt := tlcReadLockList[idx].clLockedAt;
                  rliCursorID := TnxInt64(@tlcReadLockList[idx].clCursor);
                end;
              end;

            end;
          finally
            TLCA.tlcGate.Unlock;
          end;
        end;

      finally
        Folder.sfTablesPadlock.Unlock;
      end;
    end;

  finally
    seFoldersPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.GetConfigSettings(aSettings: TnxBaseSettings); //..
begin
  inherited;
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='ServerName';
    _Label := 'Nombre del servidor';
    DefaultValue:='Gestwin';
    SettingType:=nxstString;
    PropertyName:='ServerName';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='MaxRam';
    _Label := 'RAM máxima';
    DefaultValue:=-1;
    SettingType:=nxstInteger;
    PropertyName:='MaxRam';
    Min:=-1;
    Max:=128*1024;
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='TempStoreSize';
    _Label := 'Tamaño almac. temp.';
    DefaultValue:=-1;
    SettingType:=nxstInteger;
    PropertyName:='TempStoreSize';
    Min:=-1;
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='TempStorePath';
    _Label := 'Path almac. temp.';
    DefaultValue:='';
    SettingType:=nxstString;
    PropertyName:='TempStorePath';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='JournalEngineClass';
    _Label := 'Clase de diario';
    DefaultValue:='';
    SettingType:=nxstString;
    EnforceValues:=true;
    PropertyName:='JournalEngineClass';
    ValueList:='Tnx1xRollbackJournalEngine,Tnx1xJournalEngine,Tnx1xCommitJournalEngine';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='Options';
    _Label := 'Opciones';
    DefaultValue:='';
    SettingType:=nxstMultiOption;
    PropertyName:='Options';
    ValueList:='ReadOnly,ForceFailSafe,CloseInactiveFolders,CloseInactiveTables,InMemOnly,IsSecure,VerifyTableNames,CloseAllWhenInactive,KeepSessionStats';
  end;    // with

  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='ActiveOptions';
    _Label := 'Opciones activas';
    DefaultValue:='';
    SettingType:=nxstCaption;
    PropertyName:='ActiveOptions';
  end;    // with

  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='ServerEngine Version';
    DefaultValue:=Version;
    SettingType:=nxstCaption;
    PropertyName:=Name;
  end;    // with
  //..
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.GetStatsCaptions(const aList: TStrings);
begin
  aList.Add('License Key Status');
  inherited;
  with aList do begin
    Add('Executing Statements');
    Add('Executed Statements');
    Add('Active Folders');
    Add('Inactive Folders');
    Add('Active Tables');
    Add('Inactive Tables');
  end;
  TnxBufferManager.GetStatsCaptions(aList);
  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  with aList do begin
    Add('ThreadPool.WorkerThreadCount');
    Add('ThreadPool.IdleWorkerThreadCount');
    Add('ThreadPool.QueuedRequestCount');
    Add('ThreadPool.RetiredWorkerThreadCount');
    Add('ThreadPool.AverageCPUUsage');
    Add('ThreadPool.CurrentCPUUsage');
    Add('ThreadPool.ThreadSuspended');
    Add('ThreadPool.LastSuspendTick');
    Add('ThreadPool.LastThreadCreationTick');
    Add('ThreadPool.LastQueuedRequestCount');
  end;
{$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.GetStatsValues(const aList: TStrings);
begin
  aList.Add(nxGetLicenseKeyStatus);
  inherited;
  with aList do begin
    Add(nxIntToStr(seExecutingStatements));
    Add(nxIntToStr(seExecutedStatements));
    Add(nxIntToStr(seFolderCount - seInactiveFoldersCount));
    Add(nxIntToStr(seInactiveFoldersCount));
    Add(nxIntToStr(seTableCount - seInactiveTablesCount));
    Add(nxIntToStr(seInactiveTablesCount));
  end;
  if Assigned(seBufferManager) then
    seBufferManager.GetStatsValues(aList)
  else
    TnxBufferManager.GetStatsValuesStatic(aList);

  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  with aList, TThreadPoolStats.Default do begin
    Add(nxIntToStr(WorkerThreadCount));
    Add(nxIntToStr(IdleWorkerThreadCount));
    Add(nxIntToStr(QueuedRequestCount));
    Add(nxIntToStr(RetiredWorkerThreadCount));
    Add(nxIntToStr(AverageCPUUsage));
    Add(nxIntToStr(CurrentCPUUsage));
    Add(nxIntToStr(ThreadSuspended));
    Add(nxIntToStr(LastSuspendTick));
    Add(nxIntToStr(LastThreadCreationTick));
    Add(nxIntToStr(LastQueuedRequestCount));
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.GetTransactionInfo: TnxTransactionLockInfoArray;
var
  FolderIndex,
  TableIndex   : Integer;
  Folder       : TnxServerFolder;
  Table        : TnxServerRootTable;
  Link         : TnxServerTransactionLevelTableLink;
begin
  SetLength(Result, 0);

  seFoldersPadlock.Lock;
  try
    for FolderIndex := 0 to Pred(seFolders.Count) do begin
      Folder := TnxServerFolder(seFolders.Objects[FolderIndex]);

      Folder.sfTablesPadlock.Lock;
      try
        for TableIndex := 0 to Pred(Folder.sfTables.Count) do begin
          Table := TnxServerRootTable(Folder.sfTables.Objects[TableIndex]);

          Table.srtTransLinksPadlock.Lock;
          try
            Link := Table.srtTransLinksGrantedHead;
            while Assigned(Link) do begin
              if not Link.ttlSnapshot then begin
                SetLength(Result, Succ(Length(Result)));
                with Result[High(Result)] do begin
                  tliDatabasePath := Folder.Path;
                  tliTablename := Table.srtName;
                  tliConnectedFrom :=  TnxServerSession(Link.ttlTransactionLevel.tlTransaction.OwningSession).asConnectedFrom;
                  tliClientInfo := TnxServerSession(Link.ttlTransactionLevel.tlTransaction.OwningSession).asLock.slExceptionHookInfo.ehiClient;
//                  tliQuery := TnxServerSession(Link.ttlTransactionLevel.tlTransaction.OwningSession).asLock.slExceptionHookInfo.ehiQuery;
                  tliStartedAt := Link.ttlTransactionLevel.tlStartTime;
                  tliTransactionState := Copy(GetEnumName(TypeInfo(TnxServerTransactionLevelTableLinkState), Integer(Link.ttlState)), 5, 20);
                  if Link.ttlExclusive then
                    tliTransactionType := 'Exclusive'
                  else
                    tliTransactionType := 'Shared';
                end;

              end;
              Link := Link.ttlTransactionLevelNext;
            end;

          finally
            Table.srtTransLinksPadlock.Unlock;
          end;
        end;

      finally
        Folder.sfTablesPadlock.Unlock;
      end;
    end;

  finally
    seFoldersPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.IsSecureServer: Boolean;
begin
  Result := seoIsSecure in seOptions;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.LoadConfig(aConfig: TnxBaseComponentConfiguration);
var
  lClass : TClass;
  I : Integer;
  J : TnxServerEngineOption;
  lCount : Integer;
  lName : string;
  newoptionslogic: integer;
  iOpt: integer;
begin
  inherited;
  ServerName:=aConfig.GetValue('ServerName', ServerName);
  MaxRAM:=aConfig.GetValue('MaxRAM', MaxRam);
  TempStorePath:=aConfig.GetValue('TempStorePath', TempStorePath);
  TempStoreSize:=aConfig.GetValue('TempStoreSize', TempStoreSize);
  lName:=aConfig.GetValue('JournalEngineClass', JournalEngineClass.ClassName);
  lClass:=GetClass(lName);
  if (lClass<>nil) and (lClass.InheritsFrom(TnxBaseJournalEngine)) then
    JournalEngineClass:=TnxJournalEngineClass(lClass);
  seOptions := [];
  lCount:=aConfig.GetValue('OptionsCount', 0);

  newoptionslogic:=aConfig.GetValue('NewOptionsLogic', 0);

  if NewOptionsLogic=1 then
  begin
    iOpt:=aConfig.GetValue('Options', 0);
    for j := Low(TnxServerEngineOption) to High(TnxServerEngineOption) do
      if (iOpt and trunc(power(2, Integer(j)))) = trunc(power(2, Integer(j))) then
        Include(seOptions, j);
  end
  else
  begin
    for I := 1 to lCount do begin    // Iterate
      lName:=aConfig.GetValue('Options'+inttostr(i),'');
      Include(seOptions, TnxServerEngineOption(
        GetEnumValue(TypeInfo(TnxServerEngineOption), lName)));
    end;    // for
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.LoadSettingsFromStream(aReader: TnxReader);
var
  lClass: TClass;
  Version: Integer;
begin
  inherited;

  with aReader do begin
    Version:=ReadInteger; // version
    if Version <> 1 then
      raise EnxComponentException.nxCreate(DBIERR_NX_INCOMPATSTREAM);
    ServerName := ReadString;
    MaxRam := ReadInteger;
    TempStoreSize := ReadInteger;
    TempStorePath := ReadString;
    lClass:=FindClass(ReadString);
    if (lClass<>nil) and (lClass.InheritsFrom(TnxBaseJournalEngine)) then
      JournalEngineClass:=TnxJournalEngineClass(lClass);

    seOptions := [];

    ReadListBegin;
    while not EndOfList do
      Include(seOptions, TnxServerEngineOption(
        GetEnumValue(TypeInfo(TnxServerEngineOption), ReadString)));
    ReadListEnd;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.nxcNotification(aSender    : TnxComponent;
                                          aOperation : TnxNotifyOp;
                                          aParam     : Pointer);
begin
  inherited;
  if aOperation = nxn_Destroy then
    if aSender = seAliasHandler then begin
      Active := False;
      seAliasHandler := nil;
    end else if aSender = seSqlEngine then begin
      Active := False;
      seSqlEngine := nil;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.SaveConfig(
  aConfig: TnxBaseComponentConfiguration);
var
  I : TnxServerEngineOption;
  j: integer;
  lCount : Integer;
  iOpt: integer;
begin
  inherited;
  aConfig.SetValue('ServerName', ServerName);
  aConfig.SetValue('MaxRAM', MaxRAM);
  aConfig.SetValue('TempStorePath', TempStorePath);
  aConfig.SetValue('TempStoreSize', TempStoreSize);
  aConfig.SetValue('JournalEngineClass', JournalEngineClass.ClassName);

  // Delete old settings
  lCount:=aConfig.GetValue('OptionsCount', 0);
  for j := 1 to lCount do
    aConfig.SetValue('Options'+inttostr(j), '');

  // write new ones
  lCount:=0;
  iOpt:=0;
  for i := Low(TnxServerEngineOption) to High(TnxServerEngineOption) do
    if i in Options then
    begin
      inc(lcount);
      iOpt:=iOpt+trunc(power(2, Integer(i)));
      aConfig.SetValue('Options'+inttostr(lCount), (GetEnumName(TypeInfo(TnxServerEngineOption), Ord(i))));
    end;
  aConfig.SetValue('OptionsCount', lCount);
  aConfig.SetValue('Options', iOpt);
  aConfig.SetValue('NewOptionsLogic', 1);
  aConfig.SetValue('ServerEngine Version', Version);
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.SaveSettingsToStream(aWriter: TnxWriter);
var
  i: TnxServerEngineOption;
begin
  inherited;

  with aWriter do begin
    WriteInteger(1); //version
    WriteString(ServerName);
    WriteInteger(MaxRam);
    WriteInteger(TempStoreSize);
    WriteString(TempStorePath);
    WriteString(JournalEngineClass.ClassName);

    WriteListBegin;
    for i := Low(TnxServerEngineOption) to High(TnxServerEngineOption) do
      if i in Options then
        WriteString(GetEnumName(TypeInfo(TnxServerEngineOption), Ord(i)));
    WriteListEnd;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.scDeactivating;
begin
  inherited;

  nxFreeAndNil(seBufferManager);
  seExecutedStatements := 0;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.scInitializing;
var
  TempStorePath  : string;
  MaxRAM         : Integer;
  MaxRAM1        : Integer;
  MaxRAM2        : Integer;
  TempStoreSize  : Integer;

  MemoryStatusEx : TMemoryStatusEx;

  FreeAvailable  : Int64;
  TotalSpace     : Int64;
begin
  TempStorePath := Trim(seTempStorePath);
  if TempStorePath = '' then begin
    TempStorePath := StringOfChar(#0, MAX_PATH);
    SetLength(TempStorePath, GetTempPath(MAX_PATH, PChar(TempStorePath)));
  end;

  MaxRAM := seMaxRAM;
  if MaxRAM < 1 then begin
    MemoryStatusEx.dwLength := SizeOf(MemoryStatusEx);
    if not _GlobalMemoryStatusEx(MemoryStatusEx) then
      EmulateGlobalMemoryStatusEx(MemoryStatusEx);

    MaxRAM := MemoryStatusEx.ullTotalPhys div (1024 * 1024);

    MaxRAM1 := MaxRAM div 2;
    MaxRAM2 := MaxRAM - Max(2048, (MaxRAM * 2) div 10);

    MaxRAM := Max(MaxRAM1, MaxRAM2);
  end;

  TempStoreSize := seTempStoreSize;
  if TempStoreSize < 0 then begin
    TempStoreSize := 0;
    if GetDiskFreeSpaceEx(PChar(TempStorePath), FreeAvailable, TotalSpace, nil) then
      TempStoreSize := nxMinI64(CalcMaxFileSize(TempStorePath) div (1024 * 1024 * 3), nxMinI32(MaxRAM * 10, FreeAvailable div (1024 * 1024 * 3)));
  end;

  seBufferManager := TnxBufferManager.Create(TempStorePath);
  seBufferManager.MaxRAM := MaxRAM;
  seBufferManager.TempStoreSize := TempStoreSize;

  seTempStorePath := TempStorePath;   //.. De este modo puedo leerlo luego desde AdminServerService

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.scIsStateParent(aComponent : TnxStateComponent)
                                                    : Boolean;
begin
  Result := (aComponent = seSqlEngine) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.scStarting;
begin
  inherited;
  seCleanupThread := TnxSimpleTimerThread.Create(1000, tpHighest, seCleanupCallback);
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.scStateChanged(aOldState, aNewState: TnxState);
begin
  inherited;
  if Assigned(_DesigntimeActiveServerEngines) and (GetCurrentThreadId = MainThreadID) then try
    if scActiveDesigntime then begin
      if _DesigntimeActiveServerEngines.IndexOf(Self) < 0 then
        _DesigntimeActiveServerEngines.Add(Self);
    end else
      _DesigntimeActiveServerEngines.Remove(Self);
  except end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.scStopping;
begin
  nxFreeAndNil(seCleanupThread);

  if assigned(SqlEngine) then
    SqlEngine.PrepareShutdown;
  inherited;

  seFoldersPadlock.Lock;
  try
    while seFolders.Count > 0 do
      seFolders.Objects[Pred(seFolders.Count)].Free;
  finally
    seFoldersPadlock.Unlock;
  end;
  seExecutedStatements := 0;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seCleanupCallback(aSender: TObject);
var
  Folder    : TnxServerFolder;
  CheckTime : Boolean;
  WasClosed : Boolean;
begin
  CheckTime := seInactiveFoldersCount > 0;
  while (seInactiveFoldersCount > MaxInactiveFolderCount) or CheckTime do begin
    seInactiveFoldersPadlock.Lock;
    try
      if seFoldersPadlock.TryLock then try
        if CheckTime then
          CheckTime := seInactiveFoldersCount > 0;
        if (seInactiveFoldersCount > MaxInactiveFolderCount) or CheckTime then begin
          CheckTime := (Now - seInactiveFoldersHead.sfInactiveSince) > MaxInactiveFolderTime;
          if (seInactiveFoldersCount > MaxInactiveFolderCount) or CheckTime then begin
            if seInactiveFoldersHead.sfIsInactive(False, False) then
              seInactiveFoldersHead.Free
            else
              seInactiveFoldersHead.sfServerEngineRemoveFromInactiveFolders;
          end;

          CheckTime := Assigned(seInactiveFoldersHead) and ((Now - seInactiveFoldersHead.sfInactiveSince) > MaxInactiveFolderTime);
        end;
      finally
        seFoldersPadlock.Unlock;
      end else
        Exit;
    finally
      seInactiveFoldersPadlock.Unlock;
    end;
  end;

  CheckTime := seInactiveTablesCount > 0;
  while (seInactiveTablesCount > MaxInactiveTableCount) or CheckTime do begin
    seInactiveTablesPadlock.Lock;
    try
      if seFoldersPadlock.TryLock then try
        if CheckTime then
          CheckTime := seInactiveTablesCount > 0;
        if (seInactiveTablesCount > MaxInactiveTableCount) or CheckTime then begin
          Folder := seInactiveTablesHead.srtFolder;
          if Folder.sfTablesPadlock.TryLock then try
            CheckTime := (Now - seInactiveTablesHead.srtInactiveSince) > MaxInactiveTableTime;
            if (seInactiveTablesCount > MaxInactiveTableCount) or CheckTime then
              with seInactiveTablesHead do begin
                WasClosed := False;

                LockedInc(sbtLockIsInactive);
                if srtIsInactive(False, False, 1) then try
                  LockedDec(sbtLockIsInactive);
                  if LockedCompareExchange(sbtLockIsInactive, 0, 0) = 0 then begin
                    WasClosed := True;
                    Free;
                  end;
                except
                  on E : Exception do
                    asoConvertException(E); {will create a log entry...}
                end else
                  LockedDec(sbtLockIsInactive);

                if not WasClosed then
                  srtServerEngineRemoveFromInactiveTables;
              end;
          finally
            Folder.sfTablesPadlock.Unlock;
          end else
            Exit;

          CheckTime := Assigned(seInactiveTablesHead) and ((Now - seInactiveTablesHead.srtInactiveSince) > MaxInactiveTableTime);
        end;
      finally
        seFoldersPadlock.Unlock;
      end else
        Exit;
    finally
      seInactiveTablesPadlock.Unlock;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seCloseInactiveFolders: TnxResult;
var
  i         : Integer;
  ClosedAny : Boolean;
begin
  Result := DBIERR_NONE;
  try
    seFoldersPadlock.Lock;
    try
      repeat
        ClosedAny := False;
        i := Pred(seFolders.Count);
        while i >= 0 do begin
          with TnxServerFolder(seFolders.Objects[i]) do
            if sfIsInactive(False, True) then try
              Free;
              ClosedAny := True;
            except
              on E : Exception do
                Result := bseConvertException(E, nil); {will create a log entry...}
            end;
          i := nxMinI32(Pred(i), Pred(seFolders.Count));
        end;
      until not ClosedAny;
    finally
      seFoldersPadlock.Unlock;
    end;
  except
    on E : Exception do
      Result := bseConvertException(E, nil);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seCloseInactiveTables: TnxResult;
var
  i           : Integer;
  Locked      : Boolean;
  RepeatCount : Integer;
begin
  Result := DBIERR_NONE;
  try
    RepeatCount := 0;
    repeat
      Locked := seFoldersPadlock.TryLock;
      if Locked then try
        for i := Pred(seFolders.Count) downto 0 do begin
          Result := TnxServerFolder(seFolders.Objects[i]).sfCloseInactiveTables;
          if Result = DBIERR_LOCKED then
            Locked := False;
          if Result <> DBIERR_NONE then
            break;
        end;
      finally
        seFoldersPadlock.Unlock;
      end;
      if not Locked then begin
        Inc(RepeatCount);
        Sleep(50);
      end;
    until Locked or (RepeatCount > 20);
    if Result = DBIERR_LOCKED then
      Result := DBIERR_NONE;
  except
    on E : Exception do
      Result := bseConvertException(E, nil);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seCreateAliasHandler: TnxBaseAliasHandler;
begin
  Result := TnxSimpleAliasHandler.Create(nil)
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetMaxRAM: Integer;
begin
  Result := seMaxRAM;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetOptions: TnxServerEngineOptions;
begin
  Result := seOptions;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetServerName: string;
begin
  Result := seServerName;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetSessionClass: TnxServerSessionClass;
begin
  Result := TnxServerSession;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetTempStorePath: string;
begin
  Result := seTempStorePath;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seGetTempStoreSize: Integer;
begin
  Result := seTempStoreSize;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.seSessionOpen(out aSession       : TnxAbstractSession;
                                     const aUserName      : UnicodeString;
                                     const aPassword      : UnicodeString;
                                     const aConnectedFrom : string;
                                           aTimeout       : TnxWord32;
                                           aClientVersion : Integer)
                                                          : TnxResult;
begin
  aSession := nil;
  if _FatalException then
    Result := EnxBaseException.nxSetMessage(DBIERR_NX_CORRUPTTRANS, @rsFatalError)
  else begin
    Result := DBIERR_NONE;
    aSession := seGetSessionClass.Create
      (Self, aTimeout, aUserName, aPassword, aConnectedFrom, aClientVersion);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetAliasHandler(const Value : TnxBaseAliasHandler);
begin
  if seAliasHandler <> Value then begin
    scCheckInactive;
    nxcRemoveDependingOn(seAliasHandler);
    seAliasHandler := Value;
    if Assigned(seAliasHandler) then
      seAliasHandler.DisplayName := 'Aliases';
    nxcAddDependingOn(seAliasHandler);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetMaxRAM(const Value: Integer);
begin
  if Value <> seMaxRAM then begin
    scCheckInactive;
    seMaxRAM := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetOptions(const Value: TnxServerEngineOptions);
begin
  scCheckInactive;
  seOptions := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetServerName(const Value: string);
begin
  scCheckInactive;
  seServerName := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetSqlEngine(const Value: TnxBaseSqlEngine);
begin
  if seSqlEngine <> Value then begin
    scCheckInactive;

    nxcRemoveDependingOn(seSqlEngine);
    seSqlEngine := Value;
    nxcAddDependingOn(seSqlEngine);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetTableExtension(const Value: string);
begin
  if Value <> seTableExtension then begin
    scCheckInactive;
    nxcCheck(nxCheckValidIdent(Value, DBIERR_INVALIDFILEEXTN, False));
    seTableExtension := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetTempStorePath(const Value: string);
begin
  if Value <> seTempStorePath then begin
    scCheckInactive;
    seTempStorePath := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.seSetTempStoreSize(const Value: Integer);
begin
  if Value <> seTempStoreSize then begin
    scCheckInactive;
    seTempStoreSize := Value;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerEngine.SessionOpenEx(out aSession       : TnxAbstractSession;
                                     const aUserName      : UnicodeString;
                                     const aPassword      : UnicodeString;
                                     const aConnectedFrom : string;
                                           aTimeout       : TnxWord32;
                                           aClientVersion : Integer)
                                                          : TnxResult;
begin
  aSession := nil;

  scCheckStarted;
  nxSetTimeout(aTimeout);
  try
    Result := seSessionOpen
      (aSession, aUserName, aPassword, aConnectedFrom, aTimeout, aClientVersion);
    if Result = DBIERR_NONE then
      if (seoIsSecure in seOptions) or aSession.MustBeAuthenticated then
        if not aSession.Authenticated then begin
          Result := DBIERR_INVALIDUSRPASS;
          nxFreeAndNil(aSession);
        end;
  except
    on E : Exception do
      Result := bseConvertException(E, nil);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerEngine.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(seAliasHandler) then
    if Name = '' then
      seAliasHandler.Name := ''
    else
      seAliasHandler.Name := Name + '_AliasHandler';
end;
{==============================================================================}



{===TnxServerTaskThread========================================================}
constructor TnxServerTaskThread.Create(aTaskInfo: TnxServerTaskInfo);
begin
  sttTaskInfo := aTaskInfo;
  FreeOnTerminate := True;
  inherited Create(sttTaskInfo.stiThreadPriority);
end;
{------------------------------------------------------------------------------}
procedure TnxServerTaskThread.DoBeforeExecute;
begin
  sttTaskInfo.Init;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTaskThread.InnerExecute;
begin
  nxSetTimeout(0);
  nxLockTimeout;
  try
    sttTaskInfo.Execute;
  finally
    nxUnlockTimeout;
  end;
end;
{==============================================================================}



{===TnxServerRestructureTaskInfo======================================================}
constructor TnxServerRestructureTaskInfo.Create(aContainer: TnxServerRestructureContainer);
begin
  rtiContainer := aContainer;
  rtiContainer.srcOwner := Self;
  inherited Create(rtiContainer.GetSession, rtiContainer.GetRecordCount);
end;
{------------------------------------------------------------------------------}
destructor TnxServerRestructureTaskInfo.Destroy;
begin
  inherited;
  nxFreeAndNil(rtiContainer);
end;
{------------------------------------------------------------------------------}
procedure TnxServerRestructureTaskInfo.Execute;
begin
  stiExecuting := True;
  stiStartEvt.SignalEvent;
  try
    rtiContainer.Execute;
  finally
    MarkFinished;
    stiExecuting := False;
  end;
end;
{==============================================================================}



{===TnxServerRestructureNode===================================================}
constructor TnxServerRestructureNode.Create(aOwner        : TnxServerRestructureContainer;
                                            aSourceCursor : TnxServerTableCursor;
                                            aTargetCursor : TnxServerTableCursor;
                                            aMapperDesc   : TnxBaseRecordMapperDescriptor);
begin
  srnOwner := aOwner;
  srnSourceCursor := aSourceCursor;
  srnTargetCursor := aTargetCursor;
  srnMapperDesc := aMapperDesc;
  if Assigned(srnMapperDesc) then
    srnSourceCursor.sbcGetRecordCount(rcoTotalRecordCount, srnRecordCount);
  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxServerRestructureNode.Destroy;
begin
  FreeAndNil(srnSourceCursor);
  FreeAndNil(srnTargetCursor);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRestructureNode.Execute;
var
  SourceCount : Cardinal;
  TargetCount : Cardinal;
  {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
  lException  : Exception;
  {$ENDIF}
begin
  if not Assigned(srnMapperDesc) then
    Exit;

  RecordMapper := nil;

  srnError := DBIERR_NONE;
  RecordsRead := 0;
  RecordsWritten := 0;
  try
    with srnTargetCursor.sbcTransContext do try
      try
        srnSourceCursor.sbcSwitchToIndex('', -1, porFalse);

        RecordsRead := 0;
        RecordsWritten := 0;

        if Assigned(srnMapperDesc) then
          RecordMapper := TnxBaseRecordMapperEngine.CreateFor
            (srnMapperDesc, srnSourceCursor, srnTargetCursor);

        if Assigned(RecordMapper) then begin

          srnError := stcTransactionStart(False, False, False, True, False, srnTargetCursor.IsResultSet);
          TransactionStarted := srnError = DBIERR_NONE;
          if TransactionStarted then begin
            try
              srnError := srnTargetCursor.sbcBeginContentLock(True, False);

              if srnError = DBIERR_NONE then begin

                {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                lException := nil;
                try
                {$ENDIF}
                  srnError := srnTargetCursor.stcCreateBulkBuilder(srnBulkBuilder{$IFDEF NX_INDEX_BUILD_MULTITHREADED}, @lException{$ENDIF});

                  if srnError = DBIERR_NONE then try

                    RecordMapper.BeforeFirstRecord;

                    srnSourceCursor.stcIndexPath.SetToBof;
                    srnBuffer := nil;
                    srnError := DBIERR_NONE;
                    try
                      srnSourceCursor.sbcIterate(@srnBuffer, nil, RestructureIterator, False, nil);
                    except
                      on E : Exception do
                        srnError := srnOwner.srcOwner.asoConvertException(E);
                    end;

                    {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                    if Assigned(lException) then
                      srnError := srnOwner.srcOwner.asoConvertException(lException);
                    {$ENDIF}

                    if srnError = DBIERR_EOF then
                      srnError := DBIERR_NONE;

                    if srnError = DBIERR_NONE then try
                      if Assigned(srnBulkBuilder) then
                        srnError := srnBulkBuilder.Finalize(srnTargetCursor.sbcTrans^);
                    except
                      on E : Exception do
                        srnError := srnOwner.srcOwner.asoConvertException(E);
                    end;

                    {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                    if Assigned(lException) then
                      srnError := srnOwner.srcOwner.asoConvertException(lException);
                    {$ENDIF}

                    if srnError = DBIERR_NONE then begin

                      RecordMapper.BeforeCommit;

                      if TransactionStarted then begin
                        srnError := stcTransactionCommit;
                        if srnError = DBIERR_NONE then begin
                          RecordsWritten := RecordsRead;
                          TransactionStarted := False;
                        end;
                      end;
                    end;

                  finally
                    nxFreeAndNil(srnBulkBuilder);
                  end;
                {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
                finally
                  nxFreeAndNil(lException);
                end;
                {$ENDIF}

              end;
            except
              on E : Exception do
                srnError := srnOwner.srcOwner.asoConvertException(E);
            end;

            if srnError <> DBIERR_NONE then
              if TransactionStarted then
                stcTransactionRollback
              else
                stcTransactionMarkCorrupted;
          end;
        end;

        if srnError = DBIERR_NONE then begin
          srnError := srnSourceCursor.sbcGetRecordCount(rcoTotalRecordCount, SourceCount);
          if srnError = DBIERR_NONE then begin
            srnError := srnTargetCursor.sbcGetRecordCount(rcoTotalRecordCount, TargetCount);
            if (srnError = DBIERR_NONE) and (SourceCount <> TargetCount) then
              srnError := DBIERR_FILECORRUPT;
          end;
        end;

        if MakeSnapshot(RecordsRead, RecordsWritten, DBIERR_NONE) then
          srnError := DBIERR_UPDATEABORT;
      except
        on E : Exception do
          srnError := srnOwner.srcOwner.asoConvertException(E);
      end;
    except
      on E : Exception do
        srnError := srnOwner.srcOwner.asoConvertException(E);
    end;
  finally
    MakeSnapshot(RecordsRead, RecordsWritten, srnError);
    nxFreeAndNil(RecordMapper);
  end;
  if srnError <> DBIERR_NONE then
    nxCheck(srnError);
end;
{------------------------------------------------------------------------------}
function TnxServerRestructureNode.MakeSnapshot(aRecordsRead    : TnxWord32;
                                               aRecordsWritten : TnxWord32;
                                               aErrorCode      : TnxResult)
                                                               : Boolean;
begin
  Result := srnOwner.MakeSnapshot(aRecordsRead, aRecordsWritten, aErrorCode);
end;
{------------------------------------------------------------------------------}
function TnxServerRestructureNode.RestructureIterator(aCookie : Pointer;
                                                      aRefNr  : TnxRefNr;
                                                      aRecord : PnxRecordBuffer)
                                                              : TnxRecordIteratorResult;
var
  NewRefNr           : TnxRefNr;
begin
  Inc(RecordsRead);

  with srnTargetCursor, stcTable, sbtFieldsDescriptor do begin
    InitRecord(sbcRecordBuffer);

    srnError := RecordMapper.MapRecord
      (aRecord^,
       sbcRecordBuffer^);

    if (srnError = DBIERR_NONE) and Assigned(sbcValidationsHandler) then try
      sbcValidationsHandler.ValidateRecord(nil, sbcRecordBuffer);
    except
      on E : Exception do
        srnError := srnTargetCursor.asoConvertException(E);
    end;

    if srnError = DBIERR_NONE then begin

      if sbtSFI.sfiFields[sftRecRev] >= 0 then
        sbtRecRevInit(sbcRecordBuffer);
      if sbtSFI.sfiFields[sftRefNr] >= 0 then
        sbtRefNrInit(sbcRecordBuffer);
      if (sbtSFI.sfiFields[sftModifyLSN] >= 0) or (sbtSFI.sfiFields[sftInsertLSN] >= 0) then
        sbtLSNInit(srnTargetCursor, sbcRecordBuffer);

      sbtRecordEngine.AddRecord(sbcTrans^, NewRefNr,
        sbcRecordBuffer);

      if Assigned(srnBulkBuilder) then
        srnError := srnBulkBuilder.InsertKey(@NewRefNr, sbcRecordBuffer, sbcTrans^);

      if (srnError = DBIERR_NONE) and Assigned(stcFulltextEngine) then
        srnError := stcFulltextEngine.UpdateIndex
          (sbcTrans^, nil, 0, sbcRecordBuffer, NewRefNr);

      if srnError = DBIERR_NONE then begin
        if RecordsRead mod 10 = 0 then
          if MakeSnapshot(RecordsRead, RecordsWritten, DBIERR_NONE) then
            srnError := DBIERR_UPDATEABORT;
      end;
    end;
  end;

  if srnError = DBIERR_NONE then begin
    {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
    if Assigned(srnBulkBuilder) and Assigned(srnBulkBuilder.bbbException^) then begin
      srnError := srnOwner.srcOwner.asoConvertException(Exception(srnBulkBuilder.bbbException^));
      if srnError <> DBIERR_NONE then
        Exit(rirStop);
    end;
    {$ENDIF}
    Result := rirContinue
  end else
    Result := rirStop;
end;
{==============================================================================}



{===TnxServerRestructureContainer==============================================}
constructor TnxServerRestructureContainer.Create(aSourceCursor : TnxServerTableCursor;
                                                 aTargetCursor : TnxServerTableCursor;
                                                 aMapperDesc   : TnxBaseTableMapperDescriptor);
var
  i: Integer;
begin
  try
    srcMapperDesc := aMapperDesc.Duplicate;

    srcSourceShareMode := aSourceCursor.stcShareMode;

    srcNodes := TnxList.Create;
    srcNodes.Add(TnxServerRestructureNode.Create(Self,
      aSourceCursor, aTargetCursor, srcMapperDesc.RecordMapper));

    srcSourceDatabase := TnxServerDatabase(aSourceCursor.Database);
    srcTargetDatabase := TnxServerDatabase(aTargetCursor.Database);

    srcPassword := aSourceCursor.stcTable.sbtRoot.srtExtractPassword;
    srcSourceName := aSourceCursor.stcTable.sbtNameInScope;
    srcTargetName := aTargetCursor.stcTable.sbtNameInScope;

    with aTargetCursor.stcTable.sbtRoot do
      if srtFiles[0].fiAttributes * [nxfaTemporary, nxfaMemTable] = [] then
        for i := Low(srtFiles) to High(srtFiles) do
          Include(srtFiles[i].fiAttributes, nxfaTransWriteThrough);

    srcIterateMappers('', srcMapperDesc);
    inherited Create;
  except
    srcSourceDatabase := nil;
    srcTargetDatabase := nil;
    if assigned(srcNodes) and (srcNodes.Count > 0) then
      with TnxServerRestructureNode(srcNodes[0]) do begin
        srnSourceCursor := nil;
        srnTargetCursor := nil;
      end;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerRestructureContainer.Destroy;
var
  i: Integer;
begin
  if Assigned(srcNodes) then
    for i := 0 to Pred(srcNodes.Count) do
      TObject(srcNodes[i]).Free;
  nxFreeAndNil(srcNodes);
  if srcSourceDatabase = srcTargetDatabase then
    srcTargetDatabase := nil;
  nxFreeAndNil(srcSourceDatabase);
  nxFreeAndNil(srcTargetDatabase);
  nxFreeAndNil(srcMapperDesc);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRestructureContainer.Execute;
var
  Result             : TnxResult;

  i                  : Integer;

  TempName           : string;

  Persistent         : Boolean;

  NamedStreams       : TStringList;
  CopyStream         : TnxMemoryStream;
begin
  Result := DBIERR_NONE;
  NamedStreams := TStringList.Create;
  CopyStream := TnxMemoryStream.Create;
  try

    TnxServerRestructureNode(srcNodes[0]).srnSourceCursor.sbcTableStreamGetList(NamedStreams, True);
    for i := 0 to Pred(NamedStreams.Count) do
      if not (SameText(NamedStreams[i], 'DICT') or SameText(NamedStreams[i], '$TableName')) then begin
        CopyStream.Clear;
        TnxServerRestructureNode(srcNodes[0]).srnSourceCursor.sbcTableStreamRead(NamedStreams[i], CopyStream, True);
        TnxServerRestructureNode(srcNodes[0]).srnTargetCursor.sbcTableStreamWrite(NamedStreams[i], CopyStream, True);
      end;

    try
      srcBaseRecordsRead := 0;
      srcBaseRecordsWritten := 0;
      for i := 0 to Pred(srcNodes.Count) do begin
        TnxServerRestructureNode(srcNodes[i]).Execute;
        srcBaseRecordsRead := srcCurrentRecordsRead;
        srcBaseRecordsWritten := srcCurrentRecordsWritten;
      end;
    except
      on E : Exception do
        Result := srcOwner.asoConvertException(E);
    end;

    try
      if srcSourceDatabase = srcTargetDatabase then begin
        with srcSourceDatabase do begin
          sdFolder.sfTablesPadlock.Lock;
          try
            Persistent := TnxServerRestructureNode(srcNodes[0]).srnTargetCursor.stcTable.sbtRoot.srtTableScope  = tsPersistent;

            for i := 0 to Pred(srcNodes.Count) do
              TObject(srcNodes[i]).Free;
            nxFreeAndNil(srcNodes);

            if Result = DBIERR_NONE then begin
              if sdFolder.sfInMemOnly or not Persistent then begin
                Result := sdTableDelete(srcSourceName, srcPassword);
                if Result = DBIERR_NONE then
                  Result := sdTableRename(srcTargetName, srcSourceName, srcPassword)
              end else begin
                Result := sdFolder.sfTableMakeUniqueName('$' + srcSourceName + '_Backup', TempName);
                if Result = DBIERR_NONE then begin
                  Result := sdTableRename(srcSourceName, TempName, srcPassword);
                  if Result = DBIERR_NONE then begin
                    Result := sdTableRename(srcTargetName, srcSourceName, srcPassword);
                    if Result = DBIERR_NONE then
                      sdTableDelete(TempName, srcPassword)
                    else begin
                      sdTableRename(TempName, srcSourceName, srcPassword);
                      sdTableDelete(srcTargetName, srcPassword);
                    end;
                  end else
                    sdTableDelete(srcTargetName, srcPassword);
                end else
                  sdTableDelete(srcTargetName, srcPassword);
              end;
            end else
              sdTableDelete(srcTargetName, srcPassword);
          finally
            sdFolder.sfTablesPadlock.Unlock;
          end;
        end;
        srcTargetDatabase := nil;
      end else begin
        for i := Pred(srcNodes.Count) downto 0 do
          TObject(srcNodes[i]).Free;
        nxFreeAndNil(srcNodes);
        srcTargetDatabase.sdFolder.sfCloseInactiveTables;
      end;

      nxFreeAndNil(srcSourceDatabase);
      nxFreeAndNil(srcTargetDatabase);
    except
      on E : Exception do
        Result := srcOwner.asoConvertException(E);
    end;

  finally
    MakeSnapshot(0, 0, Result);
    NamedStreams.Free;
    CopyStream.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRestructureContainer.GetRecordCount: TnxWord32;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(srcNodes.Count) do
    Inc(Result, TnxServerRestructureNode(srcNodes[i]).srnRecordCount);
end;
{------------------------------------------------------------------------------}
function TnxServerRestructureContainer.GetSession: TnxServerSession;
begin
  Result := TnxServerSession(srcSourceDatabase.asoSession);
end;
{------------------------------------------------------------------------------}
function TnxServerRestructureContainer.MakeSnapshot(aRecordsRead    : TnxWord32;
                                                    aRecordsWritten : TnxWord32;
                                                    aErrorCode      : TnxResult)
                                                                    : Boolean;
begin
  srcCurrentRecordsRead := srcBaseRecordsRead + aRecordsRead;
  srcCurrentRecordsWritten := srcBaseRecordsWritten + aRecordsWritten;
  Result := srcOwner.MakeSnapshot(srcCurrentRecordsRead,
    srcCurrentRecordsWritten, aErrorCode)
end;
{------------------------------------------------------------------------------}
procedure TnxServerRestructureContainer.srcIterateMappers(const aName       : string;
                                                                aMapperDesc : TnxBaseTableMapperDescriptor);
var
  i: Integer;
begin
  with aMapperDesc do
    for i := 0 to Pred(TableCount) do
      srcProcessMapper(aName + ':' + TableDescriptor[i].Name,
       TableDescriptor[i]);
end;
{------------------------------------------------------------------------------}
procedure TnxServerRestructureContainer.srcProcessMapper(const aName       : string;
                                                               aMapperDesc : TnxBaseTableMapperDescriptor);
var
  SourceName   : string;
  TargetName   : string;

  Result       : TnxResult;

  SourceCursor : TnxServerTableCursor;
  TargetCursor : TnxServerTableCursor;
begin
  SourceName := srcSourceName + aName;
  TargetName := aMapperDesc.MapTo;
  if TargetName = '' then
    TargetName := '.';

  if TargetName[1] = '.' then
    TargetName := srcTargetName + aName + ':' + TargetName
  else
    TargetName := srcTargetName + ':' + TargetName;

  Result := srcSourceDatabase.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
    SourceName, srcPassword, False, omReadOnly, srcSourceShareMode, False, srcSourceDatabase.atoTimeout, '', -1, False);
  if Result <> DBIERR_NONE then
    raise EnxServerEngineException.nxCreate(Result);
  try
    Result := srcTargetDatabase.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
      TargetName, srcPassword, False, omReadWrite, smExclusive, False, srcTargetDatabase.atoTimeout, '', -1, False);
    if Result <> DBIERR_NONE then
      raise EnxServerEngineException.nxCreate(Result);
  except
    nxFreeAndNil(SourceCursor);
    raise;
  end;

  srcNodes.Add(TnxServerRestructureNode.Create(Self,
    SourceCursor, TargetCursor, aMapperDesc.RecordMapper));

  srcIterateMappers(aName, aMapperDesc);
end;
{==============================================================================}



{===TnxBaseServerRebuildIndexTaskInfo==========================================}
constructor TnxBaseServerRebuildIndexTaskInfo.Create(aCursor  : TnxServerTableCursor;
                                                     aIndexID : Integer);
var
  RecordCount : TnxWord32;
begin
  riiDatabase := TnxServerDatabase(aCursor.acDatabase);
  riiCursor := aCursor;
  riiIndexID := aIndexID;
  riiCursor.stcTable.sbtRecordEngine.GetRecordCount(nil, RecordCount);
  inherited Create(TnxServerSession(riiDatabase.asoSession), RecordCount);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseServerRebuildIndexTaskInfo.Execute;
{$IFDEF NX_INDEX_BUILD_MULTITHREADED}
var
  lException  : Exception;
{$ENDIF}
begin
  stiExecuting := True;
  stiStartEvt.SignalEvent;
  riiError := DBIERR_NONE;
  riiRecordsRead := 0;
  riiRecordsWritten := 0;
  try
    with riiDatabase do try
      riiKey := nil;
      riiIndexEngine := nil;

      riiMaxTransSize :=
        (nxMinW32(TnxServerEngine(TnxServerSession(asoSession).asServerEngine).
          seBufferManager.MaxRAM div 3, 256) * 1024 * 1024) div
          _BlockSizes[riiCursor.stcTable.sbtRoot.srtMainFile.fiBlockSize];

      with riiCursor do
        riiError := sbcTransContext.stcTransactionStart(False, False, False, False, False, IsResultSet or IsUnnamed);
      riiTransactionStarted := riiError = DBIERR_NONE;
      if riiTransactionStarted then try
        riiError := riiCursor.sbcBeginContentLock(True, False);

        if riiError = DBIERR_NONE then begin
          riiIndexEngine := riiCursor.stcTable.sbtIndicesEngine[riiIndexID];
          riiIndexEngine.DeleteAllKeys(riiCursor.sbcTrans^);

          riiCursor.sbcSwitchToIndex('', -1, porFalse);
          riiCursor.stcIndexPath.SetToBof;
        end;

        {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
        lException := nil;
        try
        {$ENDIF}
          riiBulkBuilder := riiIndexEngine.CreateBulkBuilder(riiCursor.sbcTrans^{$IFDEF NX_INDEX_BUILD_MULTITHREADED}, @lException{$ENDIF});
          try
            if riiError = DBIERR_NONE then try
              riiBuffer := nil;
              riiCursor.sbcIterate(@riiBuffer, nil, RebuildIterator, False, nil);
            finally
              if Assigned(riiKey) then
                riiIndexEngine.KeyEngine.FreeKey(riiKey);
            end;

            {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
            if Assigned(lException) then
              riiError := asoConvertException(lException);
            {$ENDIF}

            if riiError = DBIERR_EOF then
              riiError := DBIERR_NONE;

            if riiError = DBIERR_NONE then try
              if Assigned(riiBulkBuilder) then
                riiError := riiBulkBuilder.Finalize(riiCursor.sbcTrans^);
            except
              on E : Exception do
                riiError := asoConvertException(E);
            end;

            if riiError = DBIERR_NONE then
              if riiTransactionStarted then begin
                riiError := TransactionCommit;
                if riiError = DBIERR_NONE then begin
                  riiRecordsWritten := riiRecordsRead;
                  riiTransactionStarted := False;
                end;
              end;
          finally
            nxFreeAndNil(riiBulkBuilder);
          end;
        {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
        finally
          nxFreeAndNil(lException);
        end;
        {$ENDIF}
      except
        on E : Exception do
          riiError := Self.asoConvertException(E);
      end;

      if riiTransactionStarted and (riiError <> DBIERR_NONE) then
        TransactionRollback;

      if MakeSnapshot(riiRecordsRead, riiRecordsWritten, DBIERR_NONE) then
        riiError := DBIERR_UPDATEABORT;

      if Self is TnxServerRebuildIndexTaskInfo then begin
        nxFreeAndNil(riiCursor);
        nxFreeAndNil(riiDatabase);
      end;
    except
      on E : Exception do
        riiError := Self.asoConvertException(E);
    end;
  finally
    MakeSnapshot(riiRecordsRead, riiRecordsWritten, riiError);
    MarkFinished;
    stiExecuting := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseServerRebuildIndexTaskInfo.RebuildIterator(aCookie : Pointer;
                                                           aRefNr  : TnxRefNr;
                                                           aRecord : PnxRecordBuffer)
                                                                   : TnxRecordIteratorResult;
begin
  Inc(riiRecordsRead);

  with riiCursor, stcTable, sbtFieldsDescriptor do begin
    if riiError = DBIERR_NONE then begin
      if Assigned(riiBulkBuilder) then
        riiError := riiBulkBuilder.InsertKey(@aRefNr, aRecord, sbcTrans^);

      if riiError = DBIERR_NONE then begin
        if riiRecordsRead mod 10 = 0 then
          if MakeSnapshot(riiRecordsRead, riiRecordsWritten, DBIERR_NONE) then
            riiError := DBIERR_UPDATEABORT;
      end;
    end;
  end;

  if riiError = DBIERR_NONE then begin
    {$IFDEF NX_INDEX_BUILD_MULTITHREADED}
    if Assigned(riiBulkBuilder) and Assigned(riiBulkBuilder.bbbException^) then begin
      riiError := asoConvertException(Exception(riiBulkBuilder.bbbException^));
      if riiError <> DBIERR_NONE then
        Exit(rirStop);
    end;
    {$ENDIF}
    Result := rirContinue
  end else
    Result := rirStop;
end;
{==============================================================================}



{===TnxServerRebuildIndexTaskInfo==============================================}
destructor TnxServerRebuildIndexTaskInfo.Destroy;
begin
  inherited;
  nxFreeAndNil(riiDatabase);
end;
{==============================================================================}



{===TnxServerGetRecCountTaskInfo===============================================}
constructor TnxServerGetRecCountTaskInfo.Create(aOption      : TnxRecordCountOption;
                                                aRecordCount : TnxWord32;
                                                aCursor      : TnxServerBaseCursor);
begin
  rciDatabase := TnxServerDatabase(aCursor.acDatabase);
  rciCursor := aCursor;
  rciOption := aOption;
  Assert(rciCursor.sbcTaskInfo = nil);
  rciCursor.sbcTaskInfo := Self;
  inherited Create(TnxServerSession(rciDatabase.asoSession), aRecordCount);
end;
{------------------------------------------------------------------------------}
destructor TnxServerGetRecCountTaskInfo.Destroy;
begin
  inherited;
  Assert(rciCursor.sbcTaskInfo = Self);
  rciCursor.sbcTaskInfo := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxServerGetRecCountTaskInfo.Execute;
var
  lIndexPath       : TnxBaseIndexPath;
  Count            : Integer;
  Result           : TnxResult;
  SnapshotResult   : TnxResult;
  StepSize         : Integer;
  TempFilter       : TnxBaseFilterEngine;
  TempKeyFilter    : TnxBaseFilterEngine;
begin
  stiExecuting := True;
  TnxServerSession(asoSession).atoLock.Lock;
  try
    stiStartEvt.SignalEvent;
    nxSetTimeout(0);
    Result := DBIERR_NONE;
    Count := 0;
    try
      try
        StepSize := nxMaxI32(1, stiStatus.tsTotalRecs div 100);
        with rciCursor as TnxServerTableCursor{!!!} do begin

          TempFilter := nil;
          TempKeyFilter := nil;
          lIndexPath := stcIndexPath.Duplicate;

          try

            if rciOption < rcoServerFilteredKeyCount then begin
              TempFilter := sbcFilter;
              sbcFilter := nil;
              TempKeyFilter := sbcKeyFilter;
              sbcKeyFilter := nil;
            end;

            stcIndexPath.SetToBof;
            Result := sbcRecordGetNext(nxltNoLock, nil);
            while (Result = DBIERR_NONE) or (Result = DBIERR_NX_FILTERTIMEOUT) do begin
              if Result = DBIERR_NONE then
                Inc(Count);
              Result := sbcRecordGetNext(nxltNoLock, nil);
              if Count mod StepSize = 0 then begin
                SnapshotResult := Result;
                case SnapshotResult of
                  DBIERR_NX_FILTERTIMEOUT,
                  DBIERR_EOF:
                    SnapshotResult := DBIERR_NONE;
                end;
                if MakeSnapshot(Count, Count, SnapshotResult) then
                  Result := DBIERR_UPDATEABORT;
              end;
            end;
            if Result = DBIERR_EOF then
              Result := DBIERR_NONE;

          finally

            stcIndexPath.Assign(lIndexPath);
            nxFreeAndNil(lIndexPath);

            if Assigned(TempFilter) then begin
              Assert(not Assigned(sbcFilter));
              sbcFilter := TempFilter;
            end;
            if Assigned(TempKeyFilter) then begin
              Assert(not Assigned(sbcKeyFilter));
              sbcKeyFilter := TempKeyFilter;
            end;

          end;
        end;
      except
        on E : Exception do
          Result := Self.asoConvertException(E);
      end;
    finally
      MakeSnapshot(Count, Count, Result);
      MarkFinished;
    end;
  finally
    TnxServerSession(asoSession).atoLock.Unlock(Result);
    stiExecuting := False;
  end;
end;
{==============================================================================}


(*
{===TnxServerTableToStreamNode===================================================}
constructor TnxServerTableToStreamNode.Create(aOwner        : TnxServerTableToStreamContainer;
                                              aSourceCursor : TnxServerTableCursor);
begin
  ttsnOwner := aOwner;
  ttsnSourceCursor := aSourceCursor;
  ttsnSourceCursor.sbcGetRecordCount(rcoTotalRecordCount, ttsnRecordCount);
  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTableToStreamNode.Destroy;
begin
  FreeAndNil(ttsnSourceCursor);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableToStreamNode.Execute(aStream: TnxTableToStreamStream);
var
  Result      : TnxResult;
  Source      : PChar;
  NullBits    : PnxByteArray;
  i           : Integer;

  Len16       : TnxWord16;
  Len32       : TnxWord32;

  RecordsRead : TnxWord32;
begin
  Result := DBIERR_NONE;
  RecordsRead := 0;
  try
    with TnxServerDatabase(ttsnSourceCursor.Database) do try
      try
        ttsnSourceCursor.sbcSwitchToIndex('', -1, False);

        RecordsRead := 0;

        try
          if Result = DBIERR_NONE then begin
            ttsnSourceCursor.stcIndexPath.SetToBof;
            Result := ttsnSourceCursor.sbcRecordGetNext(nxltNoLock,
              ttsnSourceCursor.sbcRecordBuffer);
          end;

          while Result = DBIERR_NONE do begin
            Inc(RecordsRead);

            with ttsnSourceCursor.TableDescriptor.FieldsDescriptor do begin
              Source := Pointer(ttsnSourceCursor.sbcRecordBuffer);

              NullBits := @PnxByteArray(Source)^[LogicalRecordLength];
              aStream.WriteBuffer(NullBits^, (FieldCount + 7) div 8);

              for i := 0 to Pred(FieldCount) do
                with FieldDescriptor[i] do begin
                  if not nxIsBitSet(NullBits, i) then begin
                    case fdType of
                      nxtBlob..nxcLastBlobType: begin
                        Result := ttsnSourceCursor.sbcBlobGetLength
                          (i, PnxInt64(Source)^, Len32, False);
                        if Result <> DBIERR_NONE then
                          Break;
                        aStream.WriteBuffer(Len32, SizeOf(Len32));
                        Result := ttsnSourceCursor.sbcBlobRead
                          (i, PnxInt64(Source)^, 0, Len32, aStream, False);
                        if Result <> DBIERR_NONE then
                          Break;
                      end;
                      nxtShortString: begin
                        Len16 := PnxByte8(Source)^;
                        aStream.WriteBuffer(Source^, Succ(Len16));
                      end;
                      nxtNullString: begin
                        Len16 := StrLen(Source);
                        aStream.WriteBuffer(Len16, SizeOf(Len16));
                        aStream.WriteBuffer(Source^, Len16);
                      end;
                      nxtWideString: begin
                        Len16 := lstrlenW(PWideChar(Source));
                        aStream.WriteBuffer(Len16, SizeOf(Len16));
                        aStream.WriteBuffer(Source^, Len16 * SizeOf(WideChar));
                      end;
                    else
                      aStream.WriteBuffer(Source^, fdLength);
                    end;
                  end;
                  Inc(Source, fdLength);
                end;
            end;

            if Result = DBIERR_NONE then
              Result := ttsnSourceCursor.sbcRecordGetNext(nxltNoLock,
                ttsnSourceCursor.sbcRecordBuffer);
          end;

          if Result = DBIERR_EOF then
            Result := DBIERR_NONE;

        except
          on E : Exception do
            Result := ttsnOwner.ttscOwner.asoConvertException(E);
        end;

        if MakeSnapshot(RecordsRead, DBIERR_NONE) then
          Result := DBIERR_UPDATEABORT;
      except
        on E : Exception do
          Result := ttsnOwner.ttscOwner.asoConvertException(E);
      end;
    except
      on E : Exception do
        Result := ttsnOwner.ttscOwner.asoConvertException(E);
    end;
  finally
    MakeSnapshot(RecordsRead, Result);
  end;
  if Result <> DBIERR_NONE then
    nxCheck(Result);
end;
{------------------------------------------------------------------------------}
function TnxServerTableToStreamNode.MakeSnapshot(aRecordsRead    : TnxWord32;
                                                 aErrorCode      : TnxResult)
                                                                 : Boolean;
begin
  Result := ttsnOwner.MakeSnapshot(aRecordsRead, aErrorCode);
end;
{==============================================================================}



{===TnxServerTableToStreamContainer==============================================}
constructor TnxServerTableToStreamContainer.Create(aSourceCursor : TnxServerTableCursor);
begin
  ttscNodes := TnxList.Create;
  ttscNodes.Add(TnxServerTableToStreamNode.Create(Self, aSourceCursor));
  ttscDatabase := TnxServerDatabase(aSourceCursor.Database);

  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxServerTableToStreamContainer.Destroy;
var
  i: Integer;
begin
  if Assigned(ttscNodes) then
    for i := 0 to Pred(ttscNodes.Count) do
      TObject(ttscNodes[i]).Free;
  nxFreeAndNil(ttscNodes);
  nxFreeAndNil(ttscDatabase);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxServerTableToStreamContainer.Execute(aStream: TnxTableToStreamStream);
var
  Result             : TnxResult;

  i                  : Integer;

  NamedStreams       : TStringList;
begin
  Result := DBIERR_NONE;
  NamedStreams := TStringList.Create;
  try
    aStream.WriteVersion(1);

    aStream.WriteBegin(smTableStream);

    TnxServerTableToStreamNode(ttscNodes[0]).ttsnSourceCursor.TableStreamGetList(NamedStreams);
    for i := 0 to Pred(NamedStreams.Count) do
      if not SameText(NamedStreams[i], 'DICT') then begin
        aStream.WriteMarker(smTableStream);
        aStream.WriteString(NamedStreams[i]);
        TnxServerTableToStreamNode(ttscNodes[0]).ttsnSourceCursor.TableStreamRead(NamedStreams[i], aStream);
      end;

    aStream.WriteEnd(smTableStream);

    try
      ttscBaseRecordsRead := 0;

      aStream.WriteBegin(smTable);

      for i := 0 to Pred(ttscNodes.Count) do begin
        aStream.WriteMarker(smTable);
        TnxServerTableToStreamNode(ttscNodes[i]).Execute(aStream);
        ttscBaseRecordsRead := ttscCurrentRecordsRead;
      end;

      aStream.WriteEnd(smTable);
    except
      on E : Exception do
        Result := ttscOwner.asoConvertException(E);
    end;

  finally
    MakeSnapshot(0, Result);
    NamedStreams.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerTableToStreamContainer.GetRecordCount: TnxWord32;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(ttscNodes.Count) do
    Inc(Result, TnxServerTableToStreamNode(ttscNodes[i]).ttsnRecordCount);
end;
{------------------------------------------------------------------------------}
function TnxServerTableToStreamContainer.GetSession: TnxServerSession;
begin
  Result := TnxServerSession(ttscDatabase.asoSession);
end;
{------------------------------------------------------------------------------}
function TnxServerTableToStreamContainer.MakeSnapshot(aRecordsRead    : TnxWord32;
                                                      aErrorCode      : TnxResult)
                                                                      : Boolean;
begin
  ttscCurrentRecordsRead := ttscBaseRecordsRead + aRecordsRead;
  Result := ttscOwner.MakeSnapshot(ttscCurrentRecordsRead,
    ttscCurrentRecordsRead, aErrorCode)
end;
{==============================================================================}
*)


{===TnxServerRecoverTaskInfo======================================================}
constructor TnxServerRecoverTaskInfo.Create(aContainer: TnxServerRecoverContainer);
begin
  rtiContainer := aContainer;
  rtiContainer.srcOwner := Self;
  inherited Create(rtiContainer.GetSession, rtiContainer.GetTotalBlockCount);
end;
{------------------------------------------------------------------------------}
destructor TnxServerRecoverTaskInfo.Destroy;
begin
  inherited;
  nxFreeAndNil(rtiContainer);
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverTaskInfo.Execute;
begin
  stiExecuting := True;
  stiStartEvt.SignalEvent;
  try
    rtiContainer.Execute;
  finally
    MarkFinished;
    stiExecuting := False;
  end;
end;
{==============================================================================}



{===TnxServerRecoverNode===================================================}
constructor TnxServerRecoverNode.Create(aOwner        : TnxServerRecoverContainer;
                                        aSourceCursor : TnxServerTableCursor;
                                        aTargetCursor : TnxServerTableCursor;
                                        aFailedCursor : TnxServerTableCursor);
var
  Error          : TnxResult;
  OrigialAutoInc : TnxWord32;
begin
  srnOwner := aOwner;
  srnSourceCursor := aSourceCursor;
  srnTargetCursor := aTargetCursor;
  srnFailedCursor := aFailedCursor;
  with srnSourceCursor, TableDescriptor.RecordDescriptor do begin
    srnID := stcTable.sbtRecordEngine.GetRecoverID;
    srnFileNumber := FileNumber;
  end;

  srnBlobFields := TnxList.Create;
  srnSourceCursor.TableDescriptor.FieldsDescriptor.HasSameFields(srnTargetCursor.TableDescriptor.FieldsDescriptor, srnBlobFields);
  if srnBlobFields.Count < 1 then
    nxFreeAndNil(srnBlobFields);

  OrigialAutoInc := srnSourceCursor.sbcAutoIncGet;

  Error := srnTargetCursor.sbcAutoIncSet(OrigialAutoInc);
  if Error = DBIERR_NOTSUPPORTED then
    Error := DBIERR_NONE;

  if Error = DBIERR_NONE then begin
    Error := srnFailedCursor.sbcAutoIncSet(OrigialAutoInc);
    if Error = DBIERR_NOTSUPPORTED then
      Error := DBIERR_NONE;
  end;

  nxCheck(Error);

  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxServerRecoverNode.Destroy;
begin
  FreeAndNil(srnSourceCursor);
  FreeAndNil(srnTargetCursor);
  FreeAndNil(srnFailedCursor);
  FreeAndNil(srnBlobFields);
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxServerRecoverNode.IterateBlock(aCookie  : Pointer;
                                           aBlockNr : TnxBlockNumber;
                                           aBlock   : PnxBlock)
                                                    : TnxBlockIteratorResult;
begin
  Result := birContinue;

  with PnxRecoverData(aCookie)^, srnSourceCursor do begin
    rdBuffer := nil;
    rdDestCursor := srnTargetCursor;
    rdFailedCursor := srnFailedCursor;
    rdBlobFields := srnBlobFields;
    rdBlock := aBlockNr;

    try
      if stcTable.sbtRecordEngine.RecoverIterate(aBlock, aBlockNr,
        @rdBuffer, stcRecoverRecordsIterator,
        aCookie) = rirStop then
        Result := birStop;
    except
      on E : Exception do
        rdError := srnSourceCursor.asoConvertException(E);
    end;

    if rdError <> DBIERR_NONE then
      Result := birStop;

  end;
end;
{==============================================================================}



{===TnxServerRecoverContainer==============================================}
constructor TnxServerRecoverContainer.Create(aSourceCursor : TnxServerTableCursor;
                                             aTargetCursor : TnxServerTableCursor;
                                             aFailedCursor : TnxServerTableCursor);
var
  MapperDesc : TnxTableMapperDescriptor;
  i          : Integer;
begin
  srcNodes := TnxList.Create;

  srcNodes.Add(TnxServerRecoverNode.Create(Self,
    aSourceCursor, aTargetCursor, aFailedCursor));

  srcSourceRootTable :=  aSourceCursor.stcTable.Root;

  srcSourceDatabase := TnxServerDatabase(aSourceCursor.Database);
  srcTargetDatabase := TnxServerDatabase(aTargetCursor.Database);
  Assert(srcTargetDatabase = TnxServerDatabase(aFailedCursor.Database));

  srcPassword := aSourceCursor.stcTable.sbtRoot.srtExtractPassword;
  srcSourceName := aSourceCursor.stcTable.sbtNameInScope;
  srcTargetName := aTargetCursor.stcTable.sbtNameInScope;
  srcFailedName := aFailedCursor.stcTable.sbtNameInScope;

  MapperDesc := TnxTableMapperDescriptor.Create;
  try
    MapperDesc.MapAllTablesAndFieldsByName(aSourceCursor._Dictionary, aTargetCursor._Dictionary);
    srcIterateMappers('', MapperDesc);
  finally
    nxFreeAndNil(MapperDesc);
  end;

  srcBuildMap;
  srcGetFiles;

  with aTargetCursor.stcTable.sbtRoot do
    if srtFiles[0].fiAttributes * [nxfaTemporary, nxfaMemTable] = [] then
      for i := Low(srtFiles) to High(srtFiles) do
        Include(srtFiles[i].fiAttributes, nxfaTransWriteThrough);

  with aFailedCursor.stcTable.sbtRoot do
    if srtFiles[0].fiAttributes * [nxfaTemporary, nxfaMemTable] = [] then
      for i := Low(srtFiles) to High(srtFiles) do
        Include(srtFiles[i].fiAttributes, nxfaTransWriteThrough);

  inherited Create;
end;
{------------------------------------------------------------------------------}
destructor TnxServerRecoverContainer.Destroy;
var
  i: Integer;
begin
  if Assigned(srcNodes) then
    for i := 0 to Pred(srcNodes.Count) do
      TObject(srcNodes[i]).Free;
  nxFreeAndNil(srcNodes);
  if Assigned(srcTargetDatabase) then
    srcTargetDatabase.sdFolder.sfCloseInactiveTables;
  if srcSourceDatabase = srcTargetDatabase then
    srcTargetDatabase := nil;
  nxFreeAndNil(srcSourceDatabase);
  nxFreeAndNil(srcTargetDatabase);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverContainer.Execute;
var
  Result             : TnxResult;

  i                  : Integer;

  NamedStreams       : TStringList;
  CopyStream         : TnxMemoryStream;

  RecoverData        : TnxRecoverData;
begin
  Result := DBIERR_NONE;
  NamedStreams := TStringList.Create;
  CopyStream := TnxMemoryStream.Create;
  try

    { try to get a list of table streams}
    try
      TnxServerRecoverNode(srcNodes[0]).srnSourceCursor.sbcTableStreamGetList(NamedStreams, True);
      for i := 0 to Pred(NamedStreams.Count) do
        { try to copy this stream }
        if not (SameText(NamedStreams[i], 'DICT') or SameText(NamedStreams[i], '$TableName')) then try
          CopyStream.Clear;
          TnxServerRecoverNode(srcNodes[0]).srnSourceCursor.sbcTableStreamRead(NamedStreams[i], CopyStream, True);
          TnxServerRecoverNode(srcNodes[0]).srnTargetCursor.sbcTableStreamWrite(NamedStreams[i], CopyStream, True);
        except end;
    except end;

    RecoverData.rdBuffer := nil;
//    RecoverData.rdMaxTrans := Integer(32 * 1024 * 1024) div
//      Integer(TnxServerRecoverNode(srcNodes[0]).srnTargetCursor.stcTable.sbtRoot.Dictionary.FilesDescriptor.FileDescriptor[0].BlockSizeBytes);
    RecoverData.rdError := DBIERR_NONE;
    RecoverData.rdTransCount := 0;

    nxSetTimeout(24 * 60 * 60 * 1000, True);
    nxLockTimeout;
    try
      with TnxServerRecoverNode(srcNodes[0]).srnTargetCursor do
        RecoverData.rdError := sbcTransContext.stcTransactionStart(False, False, False, False, False, IsResultSet or IsUnnamed);
      if RecoverData.rdError = DBIERR_NONE then try
        Inc(RecoverData.rdTransCount);
        srcBaseBlocksRead := 0;
        srcBaseBlocksWritten := 0;
        for i := Low(srcFiles) to High(srcFiles) do
          if Assigned(srcFiles[i]) then begin
            srcBlocksRead := 0;
            srcBlocksWritten := 0;
            RecoverData.rdFile := i;
            if srcFiles[i].IterateBlocks(@RecoverData, srcBlockIterator) = birStop then begin
              if RecoverData.rdError = DBIERR_NONE then
                RecoverData.rdError := DBIERR_NX_RECOVERFAILED;
              break;
            end;
            srcBaseBlocksRead := srcCurrentBlocksRead;
            srcBaseBlocksWritten := srcCurrentBlocksWritten;
          end;
      except
        on E : Exception do
          RecoverData.rdError := srcOwner.asoConvertException(E);
      end;

      if RecoverData.rdTransCount > 0 then begin
        { assume that an error is caused by problems related to
          reading the original table; attempt to commit tables
          with failed and recovered data }
        RecoverData.rdError := TnxServerRecoverNode(srcNodes[0]).srnTargetCursor.sbcTransContext.stcTransactionCommit;
        if RecoverData.rdError = DBIERR_NONE then
          Dec(RecoverData.rdTransCount);

        if (RecoverData.rdTransCount > 0) and (RecoverData.rdError = DBIERR_NONE) then
          RecoverData.rdError := DBIERR_NX_UNKNOWN;

        while RecoverData.rdTransCount > 0 do begin
          TnxServerRecoverNode(srcNodes[0]).srnTargetCursor.sbcTransContext.stcTransactionRollback;
          Dec(RecoverData.rdTransCount);
        end;
      end;

      Result := RecoverData.rdError;
    finally
      nxUnlockTimeout;
    end;

  finally
    MakeSnapshot(0, 0, Result);
    NamedStreams.Free;
    CopyStream.Free;

  end;
end;
{------------------------------------------------------------------------------}
function TnxServerRecoverContainer.GetSession: TnxServerSession;
begin
  Result := TnxServerSession(srcSourceDatabase.asoSession);
end;
{------------------------------------------------------------------------------}
function TnxServerRecoverContainer.GetTotalBlockCount: TnxWord32;
var
  i: Integer;
begin
  Result := 0;
  for i := Low(srcFiles) to High(srcFiles) do
    if Assigned(srcFiles[i]) then
      Inc(Result, srcFiles[i].PhysicalBlockCount);
end;
{------------------------------------------------------------------------------}
function TnxServerRecoverContainer.MakeSnapshot(aBlocksRead    : TnxWord32;
                                                aBlocksWritten : TnxWord32;
                                                aErrorCode      : TnxResult)
                                                                : Boolean;
begin
  srcCurrentBlocksRead := srcBaseBlocksRead + aBlocksRead;
  srcCurrentBlocksWritten := srcBaseBlocksWritten + aBlocksWritten;
  Result := srcOwner.MakeSnapshot(srcCurrentBlocksRead,
    srcCurrentBlocksWritten, aErrorCode)
end;
{------------------------------------------------------------------------------}
function TnxServerRecoverContainer.srcBlockIterator(aCookie  : Pointer;
                                                    aBlockNr : TnxBlockNumber;
                                                    aBlock   : PnxBlock)
                                                             : TnxBlockIteratorResult;
var
  ID: Integer;
begin
  Result := birContinue;
  Inc(srcBlocksRead);
  with PnxRecoverData(aCookie)^ do begin
    if Assigned(aBlock) then begin
      Inc(srcBlocksWritten);
      ID := srcFiles[rdFile].fiHeaderAccessFactory.GetID(aBlock);
      Result := birContinue;

      if (ID >= 0) and (ID <= High(srcIDMap[rdFile])) then
        if Assigned(srcIDMap[rdFile, ID]) then
          Result := srcIDMap[rdFile, ID].IterateBlock(aCookie, aBlockNr, aBlock);
    end;

    if MakeSnapshot(srcBlocksRead, srcBlocksWritten, DBIERR_NONE) then begin
      rdError := DBIERR_UPDATEABORT;
      Result := birStop;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverContainer.srcBuildMap;
var
  i: Integer;
begin
  srcIDMap := nil;

  for i := 0 to Pred(srcNodes.Count) do
    with TnxServerRecoverNode(srcNodes[i]) do begin
      if High(srcIDMap) < srnFileNumber then
        SetLength(srcIDMap, Succ(srnFileNumber));
      if High(srcIDMap[srnFileNumber]) < srnID then
        SetLength(srcIDMap[srnFileNumber], Succ(srnID));
      srcIDMap[srnFileNumber, srnID] := TnxServerRecoverNode(srcNodes[i]);
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverContainer.srcGetFiles;
var
  i: Integer;
begin
  srcFiles := nil;
  SetLength(srcFiles, Length(srcIDMap));
  for i := Low(srcIDMap) to High(srcIDMap) do
    if Length(srcIDMap[i]) > 0 then
      srcFiles[i] := srcSourceRootTable.srtFiles[i];
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverContainer.srcIterateMappers(const aName       : string;
                                                            aMapperDesc : TnxBaseTableMapperDescriptor);
var
  i: Integer;
begin
  with aMapperDesc do
    for i := 0 to Pred(TableCount) do
      srcProcessMapper(aName + ':' + TableDescriptor[i].Name,
       TableDescriptor[i]);
end;
{------------------------------------------------------------------------------}
procedure TnxServerRecoverContainer.srcProcessMapper(const aName       : string;
                                                           aMapperDesc : TnxBaseTableMapperDescriptor);
var
  SourceName   : string;
  TargetName   : string;
  FailedName   : string;

  Result       : TnxResult;

  SourceCursor : TnxServerTableCursor;
  TargetCursor : TnxServerTableCursor;
  FailedCursor : TnxServerTableCursor;
begin
  SourceName := srcSourceName + aName;

  TargetName := aMapperDesc.MapTo;
  if TargetName = '' then
    TargetName := '.';

  if TargetName[1] = '.' then
    TargetName := srcTargetName + aName + ':' + TargetName
  else
    TargetName := srcTargetName + ':' + TargetName;

  FailedName := aMapperDesc.MapTo;
  if FailedName = '' then
    FailedName := '.';

  if FailedName[1] = '.' then
    FailedName := srcFailedName + aName + ':' + FailedName
  else
    FailedName := srcFailedName + ':' + FailedName;

  Result := srcSourceDatabase.sdCursorOpen(TnxAbstractCursor(SourceCursor), nil,
    SourceName, srcPassword, False, omReadOnly, smExclusive, False, srcSourceDatabase.atoTimeout, '', -1, False);
  if Result <> DBIERR_NONE then
    raise EnxServerEngineException.nxCreate(Result);
  try
    Result := srcTargetDatabase.sdCursorOpen(TnxAbstractCursor(TargetCursor), nil,
      TargetName, srcPassword, False, omWriteOnly, smExclusive, False, srcTargetDatabase.atoTimeout, '', -1, False);
    if Result <> DBIERR_NONE then
      raise EnxServerEngineException.nxCreate(Result);
    try
      Result := srcTargetDatabase.sdCursorOpen(TnxAbstractCursor(FailedCursor), nil,
        FailedName, srcPassword, False, omWriteOnly, smExclusive, False, srcTargetDatabase.atoTimeout, '', -1, False);
      if Result <> DBIERR_NONE then
        raise EnxServerEngineException.nxCreate(Result);
      try
        srcNodes.Add(TnxServerRecoverNode.Create(Self, SourceCursor, TargetCursor, FailedCursor));
      except
        nxFreeAndNil(FailedCursor);
        raise;
      end;
    except
      nxFreeAndNil(TargetCursor);
      raise;
    end;
  except
    nxFreeAndNil(SourceCursor);
    raise;
  end;

  srcIterateMappers(aName, aMapperDesc);
end;
{==============================================================================}



{===TnxServerStatement=========================================================}
function TnxServerStatement.Exec(out aCursor   : TnxAbstractCursor;
                                     aOpenMode : TnxOpenMode;
                                     aStream   : TStream)
                                               : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    asExecDirect:=false;
    TnxSessionStats.Count(sscStatements);
    LockedInc((asoSession.ServerEngine as TnxServerEngine).seExecutingStatements);
    try
      Result := ssExec(aCursor, aOpenMode, aStream);
    finally
      LockedDec((asoSession.ServerEngine as TnxServerEngine).seExecutingStatements);
    end;
    LockedInc((asoSession.ServerEngine as TnxServerEngine).seExecutedStatements);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerStatement.GetParams(const aParams : TnxSqlParamList;
                                            aStream : TStream)
                                                    : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssGetParams(aParams, aStream);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerStatement.Prepare(aStatementType : TnxStatementType;
                              const aQueryText     : WideString;
                                    aStream        : TStream)
                                                   : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssPrepare(aStatementType, aQueryText, aStream);
  finally
    atoLock.Unlock(Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerStatement.SetParams(const aParams : TnxSqlParamList;
                                            aStream : TStream)
                                                    : TnxResult;
begin
  nxSetTimeout(atoTimeout);
  atoLock.Lock;
  try
    Result := ssSetParams(aParams, aStream);
  finally
    atoLock.Unlock(Result);
  end;
end;
{==============================================================================}



{===TnxKeyFieldsSource=========================================================}
function TnxKeyFieldsSource.BeginReadOrgOverride: Integer;
begin
  Result := KeyEngine.BeginReadOrgOverride;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.BlobsSupported: Boolean;
begin
  Result := KeyEngine.BlobsSupported;
end;
{------------------------------------------------------------------------------}
constructor TnxKeyFieldsSource.Create(aOwner: TnxServerTableCursor);
begin
  kfsOwner := aOwner;
  inherited Create;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.EndReadOrgOverride: Integer;
begin
  Result := KeyEngine.EndReadOrgOverride;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetCursor: TObject;
begin
  Result := kfsOwner;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldAsVariant(aBuffer : PnxRecordBuffer;
                                              aField  : Integer)
                                                      : OleVariant;
begin
  Result := KeyEngine.GetFieldAsVariant(aBuffer, aField);
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldCount: Integer;
begin
  Result := KeyEngine.GetFieldCount;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldDescriptor(aIndex : Integer)
                                                      : InxFieldDescriptor;
begin
  Result := KeyEngine.GetFieldDescriptor(aIndex);
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldForFilter(aField    : Integer;
                                              aName     : PAnsiChar;
                                              aData     : PnxRecordBuffer;
                                          out aType     : TnxWord16;
                                          out aSize     : TnxWord16;
                                          out aIsNull   : Boolean;
                                          out aValue    : PnxFieldBuffer;
                                          out aCodePage : TnxWord16)
                                                        : Boolean;
begin
  Result := KeyEngine.GetFieldForFilter
    (aField, aName, aData, aType, aSize, aIsNull, aValue, aCodePage);
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldFromName(const aFieldName: string): Integer;
begin
  Result := KeyEngine.GetFieldFromName(aFieldName);
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetFieldsOffset: integer;
begin
  Result := KeyEngine.GetFieldsOffset;
end;
{------------------------------------------------------------------------------}
function TnxKeyFieldsSource.GetKeyEngine: InxFieldsSource;
begin
  Result := kfsOwner.stcIndexEngine.KeyEngine;
end;
{==============================================================================}



{===TnxServerDoNothingTaskInfo=================================================}
procedure TnxServerDoNothingTaskInfo.Execute;
begin
  {do nothing}
end;
{==============================================================================}



{===TnxServerVerifyChecksumTaskInfo============================================}
constructor TnxServerVerifyChecksumTaskInfo.Create(aCursor: TnxServerTableCursor; aRaw, aForceRecheck: Boolean);
var
  i           : Integer;
  TotalBlocks : TnxWord32;
begin
  vctiRaw          := aRaw;
  vctiForceRecheck := aForceRecheck;

  vctiCursor := aCursor;
  vctiTable := vctiCursor.stcTable.sbtRoot;
  vctiFiles := vctiTable.srtFiles;
  TotalBlocks := 0;
  for i := Low(vctiFiles) to High(vctiFiles) do
    if Assigned(vctiFiles[i]) then
      Inc(TotalBlocks, vctiFiles[i].fiUsedBlocks);
  inherited Create(vctiCursor.Database.Session as TnxServerSession, TotalBlocks);
end;
{------------------------------------------------------------------------------}
destructor TnxServerVerifyChecksumTaskInfo.Destroy;
begin
  inherited;
  nxFreeAndNil(vctiCursor);
end;
{------------------------------------------------------------------------------}
procedure TnxServerVerifyChecksumTaskInfo.Execute;
var
  i                  : Integer;
begin
  stiExecuting := True;
  stiStartEvt.SignalEvent;
  try
    vctiCount := 0;
    vctiError := DBIERR_NONE;
    try
      nxSetTimeout(24 * 60 * 60 * 1000, True);
      nxLockTimeout;
      try
        for i := Low(vctiFiles) to High(vctiFiles) do try
          vctiFile := vctiFiles[i];
          if Assigned(vctiFile) then begin
            vctiChecksum := nil;
            SetLength(vctiChecksum, vctiFile.fiCheckSumSize);
            if (Length(vctiChecksum) > 0) and ((not vctiFile.fiCheckSumVerified) or vctiForceRecheck)  then begin
              if vctiRaw then
                vctiFile.IterateBlocksRaw(nil, vctiBlockIterator)
              else
                vctiFile.IterateBlockCookies(nil, vctiBlockCookieIterator);
              if vctiError = DBIERR_NONE then begin
                vctiFile.fiCheckSumVerified := nxCmpDynBytes(vctiChecksum, vctiFile.fiChecksum) = nxEqual;
                if not vctiFile.fiCheckSumVerified then
                  vctiError := DBIERR_HEADERCORRUPT;
              end;
            end else
              Inc(vctiCount, vctiFile.fiUsedBlocks);
          end;
          if stiCancelled or (vctiError <> DBIERR_NONE) then
            break;
          MakeSnapshot(vctiCount, vctiCount, vctiError);
        except
          on E : Exception do
            vctiError := Self.asoConvertException(E);
        end;
      finally
        nxUnlockTimeout;
      end;
    finally
      MakeSnapshot(vctiCount, vctiCount, vctiError);
    end;
  finally
    MarkFinished;
    stiExecuting := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerVerifyChecksumTaskInfo.vctiBlockCookieIterator(aCookie      : Pointer;
                                                                 aBlockNr     : TnxBlockNumber;
                                                                 aBlock       : PnxBlock;
                                                                 aBlockCookie : TnxBytes)
                                                                              : TnxBlockIteratorResult;
begin
  try
    if aBlockNr = Pred(vctiFile.fiUsedBlocks) then
      Result := birStop
    else
      Result := birContinue;

    if aBlockNr = 0 then
      Exit;

    vctiFile.fiEncryptionEngine.beeAddChecksumForCookie(aBlockCookie, aBlockNr, vctiChecksum);
  except
    on E : Exception do begin
      vctiError := Self.asoConvertException(E);
      Result := birStop;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxServerVerifyChecksumTaskInfo.vctiBlockIterator(aCookie  : Pointer;
                                                           aBlockNr : TnxBlockNumber;
                                                           aBlock   : PnxBlock)
                                                                    : TnxBlockIteratorResult;
begin
  try
    if aBlockNr = Pred(vctiFile.fiUsedBlocks) then
      Result := birStop
    else
      Result := birContinue;

    if aBlockNr = 0 then
      Exit;

    vctiFile.fiEncryptionEngine.beeAddChecksumForBlock(aBlock^, _BlockSizes[vctiFile.fiBlockSize], aBlockNr, vctiChecksum);
  except
    on E : Exception do begin
      vctiError := Self.asoConvertException(E);
      Result := birStop;
    end;
  end;
end;
{==============================================================================}

{ TnxServerDatabaseCursorSourceContainer }

{==============================================================================}
constructor TnxServerDatabaseCursorSourceContainer.Create(aDatabase : TnxServerDatabase;
                                                          aSource   : InxDatabaseCursorSource);
begin
  cscDatabase := aDatabase;
  cscSource := aSource;
  cscLock := cscDatabase.atoLock;
  cscAddToDatabase;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabaseCursorSourceContainer.cscAddToDatabase;
begin
  with cscDatabase do begin
    cscDatabasePrev := sdCursorSourceTail;
    sdCursorSourceTail := Self;
    if Assigned(cscDatabasePrev) then
      cscDatabasePrev.cscDatabaseNext:=Self;
    if not Assigned(sdCursorSourceHead) then
      sdCursorSourceHead := Self;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabaseCursorSourceContainer.cscRemoveFromDatabase;
begin
  if Assigned(cscDatabaseNext) then
    cscDatabaseNext.cscDatabasePrev := cscDatabasePrev
  else
    if cscDatabase.sdCursorSourceTail = Self then
      cscDatabase.sdCursorSourceTail := cscDatabasePrev;

  if Assigned(cscDatabasePrev) then
    cscDatabasePrev.cscDatabaseNext := cscDatabaseNext
  else
    if cscDatabase.sdCursorSourceHead = Self then
      cscDatabase.sdCursorSourceHead := cscDatabaseNext;

  cscDatabaseNext := nil;
  cscDatabasePrev := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxServerDatabaseCursorSourceContainer.CursorOpen(out aCursor    : TnxAbstractCursor;
                                                          const aTableName : string;
                                                            var aResult    : TnxResult);
var
  Container : TnxServerDatabaseCursorSourceContainer;
begin
  if not Assigned(Self) then
    Exit;
  Container := Self;
  while Assigned(Container) do begin
    aCursor := Container.cscSource.CursorOpen(aTableName);
    if Assigned(aCursor) then begin
      aResult := DBIERR_NONE;
      Exit;
    end;
    Container := Container.cscDatabaseNext;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxServerDatabaseCursorSourceContainer.Destroy;
begin
  Unregister;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxServerDatabaseCursorSourceContainer.Unregister: TnxResult;
var
  Lock : InxSimpleLock;
begin
  Result := DBIERR_NONE;
  Lock := cscLock;
  if Assigned(Lock) then begin
    Lock.Lock;
    try
      cscRemoveFromDatabase;
      cscSource := nil;
      cscLock := nil;
    finally
      Lock.Unlock(Result);
    end;
  end;
end;
{==============================================================================}

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  TnxServerEngine.rcRegister;
finalization
  TnxServerEngine.rcUnregister;
end.
