{##############################################################################}
{# NexusDB: nxdb.pas 4.7516                                                  #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Data Access Components                                            #}
{##############################################################################}

{$I nxDefine.inc}

unit nxdb;

interface

uses
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Winapi.Windows{$ELSE}Windows{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Classes{$ELSE}Classes{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Contnrs{$ELSE}Contnrs{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Math{$ELSE}Math{$ENDIF},
  {$IFDEF DCC17OrLater}
    {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Generics.Collections{$ELSE}Collections{$ENDIF},
  {$ENDIF}
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.SysUtils{$ELSE}SysUtils{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.TypInfo{$ELSE}TypInfo{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.Variants{$ELSE}Variants{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Data.Db{$ELSE}Db{$ENDIF},
{$IFNDEF FPC}
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Data.DBCommon{$ELSE}DBCommon{$ENDIF},
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Data.DBConsts{$ELSE}DBConsts{$ENDIF},
{$ENDIF}
  {$IFDEF SUPPORTS_DOTTED_UNITNAMES}Data.FMTBcd{$ELSE}FMTBcd{$ENDIF},
  nxllBde,
  nxllComponent,
  nxllConst,
  nxllConvertException,
  nxllException,
  nxllFastFillChar,
  nxllFastMove,
  nxllList,
  nxllLockedFuncs,
  nxllMemoryManager,
  nxllPlatformInterface,
  nxllSessionNotifications,
  nxllStreams,
  nxllSync,
  nxllThread,
  nxllTypes,
  nxllUtils,
  nxllWideString,
  nxsdConst,
  nxsdDataDictionary,
  nxsdDataDictionaryAudit,
  nxsdDataDictionaryFulltext,
  nxsdDataDictionaryStrings,
  nxsdDefaultValueEngine,
  nxsdFilterDescriptorBase,
  nxsdFilterEngineBase,
  nxsdFilterEngineCallback,
  nxsdFilterEngineSimpleExpression,
  nxsdFilterEngineSQL,
  nxsdFmtBcd,
  nxsdNativeVariantConverter,
  nxsdServerEngine,
  nxsdTableMapperDescriptorBase,
  nxsdTypes,
  nxsdValidationEngine,
  nxsdBookmarkHandling,
  {$IFDEF DCC16OrLater}
  nxddDDetours,
  {$ENDIF}
  nxdbBase,
  nxdbConversion,
  nxdbStrings;

type
  TnxRecordBuffer = {$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer{$ELSE}PByte{$ENDIF}{$ELSE}PChar{$ENDIF};
  TBookmarkOrPointer = {$IFDEF FPC}Pointer{$ELSE}{$IFDEF DCC12OrLater}Pointer{$ELSE}TBookmark{$ENDIF}{$ENDIF};

const
  { The maximum number of bytes read/written to the server at once.
    <p>0 means do not limit "chunk" sizes, any other value determines
    the number of bytes. }
  nxMaxBlobChunk : Integer = 512 * 1024;

type
  TnxFieldList = TList{$IFDEF DCC17OrLater}<TField>{$ENDIF};

type
  TnxBaseSession = class;
  TnxBaseDatabase = class;
  TnxDatabase = class;
  TnxTransContext = class;
  TnxCursor = class;
  TnxDataset = class;
  TnxIndexDataSet = class;
  TnxTable = class;
  TnxStatementDataSet = class;
  TnxQuery = class;
  TnxStoredProc = class;

  { The base class for all client side data components }
  TnxDataAccessStateComponent = class(TnxStateComponent)
  protected
    procedure nxcCheck(const aErrorCode: TnxResult); override;
    procedure nxcError(const aErrorCode: TnxResult); overload; override;
    procedure nxcError(const aErrorCode: TnxResult; const aAltMsg: string); overload; override;
    procedure nxcError(const aErrorCode: TnxResult; const aAltMsg: string; const aArgs: array of const); overload; override;
    procedure nxcError(const aErrorCode: TnxResult; aAltMsgRes: PResStringRec); overload; override;
    procedure nxcError(const aErrorCode: TnxResult; aAltMsgRes: PResStringRec; const aArgs: array of const); overload; override;
    procedure nxcError(const aMsg: string); overload; override;
    procedure nxcError(const aMsg: string; const aArgs: array of const); overload; override;
    procedure nxcError(aMsgRes: PResStringRec); overload; override;
    procedure nxcError(aMsgRes: PResStringRec; const aArgs: array of const); overload; override;

    class function dascExceptionClass: EnxDatabaseErrorClass; virtual;
  end;

  { An event to get a user name and password for login purposes.
    Called from TnxBaseSession.                                  }
  TnxLoginEvent = procedure (aSender   : TnxBaseSession;
                         var aUserName : UnicodeString;
                         var aPassword : UnicodeString;
                         var aResult   : Boolean) of object;

  { Pointer to TnxBaseSession. }
  PnxBaseSession = ^TnxBaseSession;
  { The mother of all sessions. It implements a component that is
    used the same way as Borland's TSession and adds some
    features unique to NexusDB.                                   }
  TnxBaseSession = class(TnxDataAccessStateComponent, InxInterface, InxSessionRequests,
    InxSessionNotifications, InxSessionNotifier, InxRemoteTaskInfoCreator, InxClassActivator)
  protected {private}
    bsAbstractSession      : TnxAbstractSession;

    bsDefaultRef           : PnxBaseSession;

    bsDatabases            : TnxSortedList;
    bsTempDatabases        : TStringList;
    bsDefaultDatabase      : TnxDatabase;

    bsTransContexts        : TnxSortedList;
    bsDefaultTransContext  : TnxTransContext;

    bsUserName             : UnicodeString;
    bsCurrentUserName      : UnicodeString;
    bsPassword             : UnicodeString;
    bsPasswordRetries      : Integer;
    bsBeepOnLoginError     : Boolean;

    bsTimeout              : Integer;

    bsOnLogin              : TnxLoginEvent;

    bsSessionNotifications : TnxSessionNotifications;

    bsClientLocaleAsDefault : Boolean;

    function bsGetDatabase(aInx: Integer): TnxDatabase;
    function bsGetDatabaseCount: Integer;

    function bsGetTransContext(aInx: Integer): TnxTransContext;
    function bsGetTransContextCount: Integer;

    function bsGetServerEngine: TnxBaseServerEngine; virtual; abstract;

    procedure bsSetPassword(const aValue: UnicodeString);
    procedure bsSetUserName(const aValue: UnicodeString);

    function bsGetTimeout: Integer; virtual;
    procedure bsSetTimeout(aTimeout : Integer);

    function bsGetImplicitDatabase(const aAliasName : string;
                                         aCreate    : Boolean = True)
                                                    : TnxDataBase;
    function bsGetServerVersion: Integer;

    function bsGetDefault: Boolean;
    procedure bsSetDefault(const Value: Boolean);

    function bsGetSessionNotifications: InxSessionNotifications;
    procedure bsSetClientLocaleAsDefault(const Value: Boolean);
  protected
    procedure nxcAddDependent(aComponent: TnxComponent); override;
    procedure nxcRemoveDependent(aComponent: TnxComponent); override;

    procedure scInitializing; override;
    procedure scStarting; override;
    procedure scStopping; override;

    procedure bsCheckServerEngine; virtual;
    procedure bsRefreshTimeout; virtual;

    function bsDoLogin(var aUserName, aPassword : UnicodeString): Boolean;

    { InxSessionRequests. }
    function ProcessRequest(aSource         : TObject;
                            aThreadPriority : TnxThreadPriority;
                            aMsgID          : TnxMsgID;
                            aTimeout        : TnxWord32;
                            aRequestData    : Pointer;
                            aRequestDataLen : TnxWord32;
                            aReply          : PPointer;
                            aReplyLen       : PnxWord32;
                            aReplyType      : TnxNetMsgDataType;
                            aCanSkipCantSkip: Boolean = False;
                            aSequenceID     : PnxWord32 = nil)
                                            : TnxResult;

    function ProcessRequestDirect(aRemoteThreadPriority : TnxThreadPriority;
                                  aMsgID                : TnxMsgID;
                                  aTimeout              : TnxWord32;
                                  aRequestData          : Pointer;
                                  aRequestDataLen       : TnxWord32;
                                  aReply                : PPointer;
                                  aReplyLen             : PnxWord32;
                                  aReplyType            : TnxNetMsgDataType)
                                                        : TnxResult;

    procedure ProcessPost(aSource         : TObject;
                          aThreadPriority : TnxThreadPriority;
                          aMsgID          : TnxMsgID;
                          aTimeout        : TnxWord32;
                          aRequestData    : Pointer;
                          aRequestDataLen : TnxWord32);

    { InxRemoteTaskInfoCreator }
    function CreateRemoteTaskInfo(const aTaskID : TnxTaskID)
                                                : TnxAbstractTaskInfo;

    { InxSessionNotifier }
    procedure Disconnected;

    { InxClassActivator }
    function CreateInstance(const aClassID     : TnxGuid;
                            const aOuter       : InxInterface;
                            const aInterfaceID : TnxGuid;
                              out aInterface   )
                                               : HRESULT;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { This function returns true if the session is active/connected. }
    function IsConnected : Boolean;

    {-- CancelProcessing --}

    { This procedure can be called from another thread to terminate any
      currently ongoing processing. }
    procedure CancelProcessing;

    {-- Alias --}

    { Adds a new alias. If an error occurs, it triggers an exception.
      Parameters:
        aName: Aliasname
        aPath: Path the alias should point to
        aEnforce: If true, the path will be created
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    procedure AddAlias(const aName    : string;
                       const aPath    : string;
                             aEnforce : Boolean = False);
    { Adds a new alias and returns the error code.
      Parameters:
        aName: Aliasname
        aPath: Path the alias should point to
        aEnforce: If true, the path will be created
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
     }
    function AddAliasEx(const aName    : string;
                        const aPath    : string;
                              aEnforce : Boolean = False)
                                       : TnxResult;
    { Deletes the given alias. Triggers an exception if it fails.
      Parameters:
        aName: Aliasname
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    procedure DeleteAlias(const aName : string);
    { Deletes the given alias and returns the error code.
      Parameters:
        aName: Aliasname
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    function DeleteAliasEx(const aName : string)
                                       : TnxResult;
    { This function allows to change the name and/or path of an alias.
      <p>It triggers an exception if it fails.
      Parameters:
        aName: Aliasname
        aNewName: new Name of the Alias
        aNewPath: new Path of the Alias
        aEnforce: If true, the new path will be created
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    procedure ModifyAlias(const aName    : string;
                          const aNewName : string;
                          const aNewPath : string;
                                aEnforce : Boolean = False);
    { This function allows to change the name and/or path of an
      alias and returns the error code.

      Parameters
      aName:     Aliasname
      aNewName:  new Name of the Alias
      aNewPath:  new Path of the Alias
      aEnforce: If true, the new path will be created
      See Also
      AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
      ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
      GetAliasPathEx, IsAlias                                      }
    function ModifyAliasEx(const aName    : string;
                           const aNewName : string;
                           const aNewPath : string;
                                 aEnforce : Boolean = False)
                                          : TnxResult;
    { Fills the given list with all alias names.
      Parameters:
        aList: will hold the names after the call; must not be nil; always clears
          the list before adding the names
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    procedure GetAliasNames(aList: TStrings);
    { Fills the given list with all alias names and returns the error code.
      Parameters:
        aList: will hold the names after the call; must no be nil
        aEmptyList: clears the list before adding, if true
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    function GetAliasNamesEx(aList      : TStrings;
                             aEmptyList : Boolean)
                                        : TnxResult;
    { Returns the path an alias points to. Remember that this is always a server
      relative path! The method triggers an exception if it fails.
      Parameters:
        aName: AliasName
        aPath: will hold the path after the method returns
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    procedure GetAliasPath(const aName : string;
                             out aPath : string);
    { Returns the path an alias points to. Remember that this is always a server
      relative path! It returns the error code as function result.
      Parameters:
        aName: AliasName
        aPath: will hold the path after the method returns
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    function GetAliasPathEx(const aName : string;
                              out aPath : string)
                                        : TnxResult;
    { Returns true if an alias with the given name exists, otherwise false.
      Parameters:
        aName: AliasName
      See Also: AddAliasEx, DeleteAlias, DeleteAliasEx, ModifyAlias,
        ModifyAliasEx, GetAliasNames, GetAliasNamesEx, GetAliasPath,
        GetAliasPathEx, IsAlias
    }
    function IsAlias(const aName : string): Boolean;

    {-- passwords --}

    { Adds a password to the session password list. }
    procedure PasswordAdd(const aPassword : UnicodeString);
    { Adds a password to the session password list and returns the
      result code. If called with default parameter values, ignores the error
      indicating the password is already added to this session, and
      raises an exception on any other error. }
    function PasswordAddEx(const aPassword   : UnicodeString;
                           const aIgnoreDups : Boolean = True;
                           const aUseRaise   : Boolean = True) : TnxResult;
    { Remove a password to the session password list. }
    procedure PasswordRemove(const aPassword : UnicodeString);
    { Clear the session password list. }
    procedure PasswordRemoveAll;

    {-- misc --}

    { This method closes all temp databases of the session that
     have no active local Tables}
    procedure CloseInactiveLocalDatabases;

    { This method closes all folders of the session that were kept
      \open by the server caching mechanism.                       }
    procedure CloseInactiveFolders;
    { This method closes all tables of the session that were kept
      \open by the server caching mechanism.                      }
    procedure CloseInactiveTables;

    { Returns the tables of an alias in the given list.
      Parameters:
        aAliasName: the name of the alias
        aList: the list to hold the names; must not be nil
    }
    procedure GetTableNames(const aAliasName    : string;
                                  aList         : TStrings);

    { Returns the changed tables of an alias in the given list.
      Parameters:
        aAliasName: the name of the alias
        aList: the list to hold the names; must not be nil
    }
    procedure GetChangedTables(const aAliasName    : string;
                                     aList         : TStrings);

    { Checks if a table exist in a specific alias.
      Parameters:
        aAliasName: the name of the alias
        aTableName: the name of the table
        aPassword : tha encryption password for the table
    }
    function TableExists(const aAliasName : string;
                         const aTableName : string;
                         const aPassword  : UnicodeString)
                                          : Boolean;

    { Reads a named stream from a specified table in a
      specified alias. Returns an error code.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object into which the data is written
    }
    function TableStreamReadEx(const aAliasName  : string;
                               const aTableName  : string;
                               const aPassword   : UnicodeString;
                               const aStreamName : string;
                                     aStream     : TStream)
                                                 : TnxResult;

    { Reads a named stream from a specified table in a
      specified alias. Returns a newly creates stream
      object. The caller is responsible for freeing the
      stream object after use. Raises exception on error.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
    }
    function TableStreamRead(const aAliasName  : string;
                             const aTableName  : string;
                             const aPassword   : UnicodeString;
                             const aStreamName : string)
                                               : TStream;

    { Writes a named stream into a specified table in a
      specified alias. Returns an error code.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object to be written
    }
    function TableStreamWriteEx(const aAliasName  : string;
                                const aTableName  : string;
                                const aPassword   : UnicodeString;
                                const aStreamName : string;
                                      aStream     : TStream)
                                                  : TnxResult;

    { Writes a named stream into a specified table in a
      specified alias. Raises exception on error.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object to be written
    }
    procedure TableStreamWrite(const aAliasName  : string;
                               const aTableName  : string;
                               const aPassword   : UnicodeString;
                               const aStreamName : string;
                                     aStream     : TStream);

    { GetStoredProcNames returns a list of all stored procedures of a
      database/alias.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetStoredProcNames(const aAliasName : string;
                                       aList      : TStrings);
    { Returns the parameter defintions for a named stored procedure of
      the given Alias. }
    procedure GetStoredProcParams(const aAliasName      : string;
                                  const aStoredProcName : string;
                                    out aParams         : TnxStoredProcParamList);

    { GetStoredFuncNames returns a list of all stored functions of a
      database/alias.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetStoredFuncNames(const aAliasName : string;
                                       aList      : TStrings);
    { Returns the parameter defintions for a named stored functions of
      the given Alias. }
    procedure GetStoredFuncParams(const aAliasName      : string;
                                  const aStoredFuncName : string;
                                    out aParams         : TnxStoredProcParamList);

    { Returns a list of engines or descriptors of a particular type
      from the server.
      Parameters:
        aClassListType: the type of engines or descriptors list to return
        aList: an instance of a TStrings descendant; will hold the list on return
      See also: TnxClassListType }
    procedure GetRegisteredClassList(const aClassListType : TnxClassListType;
                                           aList          : TStrings);

    { Returns the implicit database for the given Alias, creates it if required.
      The returned database is guaranteed to be open.
      *do not free the returned database* }
    function OpenDatabase(const aAliasName : string) : TnxDatabase; virtual;

    { Returns the implicit database for the given Alias. May return nil.
      The returned database may be closed.
      *do not free the returned database* }
    function FindDatabase(const aAliasName : string) : TnxDatabase; virtual;

    { Returns the default session for the current thread or nil if non exist. }
    class function DefaultSession: TnxBaseSession;

    { Returns the default database for this session or nil if non exist. }
    function DefaultDatabase: TnxDatabase;

    { Returns the default TransContext for this session or nil if non exist. }
    function DefaultTransContext: TnxTransContext;

    { Returns the InxLoggedInUser31000 of this session if available }
    function LoggedInUser: InxLoggedInUser31000;

    { Returns the InxLoggedInAdministrator31000 of this session if available }
    function LoggedInAdministrator: InxLoggedInAdministrator31000;

    {-- properties --}

    { \Returns the Server Engine the session is connected to. Note,
      that this is read only in the base class. The Set method
      might be implemented in descendants.                          }
    property ServerEngine : TnxBaseServerEngine
      read bsGetServerEngine;

    { This property gives direct access to the internal session state. }
    property AbstractSession : TnxAbstractSession
      read bsAbstractSession;

    { Returns the Version of the server engine. }
    property ServerVersion: Integer
      read bsGetServerVersion;

    { Returns the number of tnxDatabase instances assigned to the session.
      See Also: Databases }
    property DatabaseCount: Integer
      read bsGetDatabaseCount;
    { Returns the instance of tnxDatabase with index aInx in the list of
      assigned databases.
      See Also: DatabaseCount }
    property Databases[aInx: Integer]: TnxDatabase
      read bsGetDatabase;

    { Returns the number of TnxTransContext instances assigned to the session.
      See Also: TransContexts }
    property TransContextCount: Integer
      read bsGetTransContextCount;
    { Returns the instance of TnxTransContext with index aInx in the list of
      assigned TransContexts.
      See Also: TransContextCount }
    property TransContexts[aInx: Integer]: TnxTransContext
      read bsGetTransContext;
  published
    { This event is triggered whenever the session is set to active
      and the connected server engine is in secure mode, thus
      requesting users to logon.

      Parameters
      aSender :    the session calling the event
      aUserName :  the username supplied to the Session, change if
                   wanted/needed
      aPassword :  the password supplied to the Session, change if
                   wanted/needed
      aResult :    return true for successful logon, false if you want
                   the logon to fail
      See Also
      UserName, BeepOnLoginError, Password, OnLogin,
      PasswordRetries                                                  }
    property OnLogin: TnxLoginEvent
      read bsOnLogin
      write bsOnLogin;
    { The user name used for logging in this session. It is only
      assigned while the session is active.

      See Also
      UserName, BeepOnLoginError, Password, OnLogin,
      PasswordRetries                                         }
    property CurrentUserName: UnicodeString
      read bsCurrentUserName;
    { The user name for the session. It is only used when the
      connected Server Engine is in secure mode.

      See Also
      UserName, BeepOnLoginError, Password, OnLogin,
      PasswordRetries                                         }
    property UserName: UnicodeString
      read bsUserName
      write bsSetUserName;
    { The password for the session. It is only used when the
      connected Server Engine is in secure mode.

      See Also
      UserName, BeepOnLoginError, Password, OnLogin,
      PasswordRetries                                        }
    property Password: UnicodeString
      read bsPassword
      write bsSetPassword;
    { The number of retries for logon before the session returns a
      DBIERR_INVALIDUSRPASS error is triggered.
      See Also: UserName, BeepOnLoginError, Password, OnLogin, PasswordRetries }
    property PasswordRetries: Integer
      read bsPasswordRetries
      write bsPasswordRetries
      default 3;
    { If true, a Beep is triggered whenever a failed Login occurs.
      See Also: UserName, BeepOnLoginError, Password, OnLogin, PasswordRetries }
    property BeepOnLoginError: Boolean
      read bsBeepOnLoginError
      write bsBeepOnLoginError
      default True;
    { Sets the Timeout for the Session commands (in ms). }
    property Timeout: Integer
      read bsTimeout
      write bsSetTimeout
      default -1;

    { If true this session is the default session for the <b>current thread</b>. }
    property Default: Boolean
      read bsGetDefault
      write bsSetDefault
      default False;

    property SessionNotifications: InxSessionNotifications
      read bsGetSessionNotifications
      implements InxSessionNotifications;

    property ClientLocaleAsDefault : Boolean
      read bsClientLocaleAsDefault
      write bsSetClientLocaleAsDefault
      default False;
  end;

  { A BDE compatible implementation of a NexusDB session. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxSession = class(TnxBaseSession)
  protected {private}
    sesServerEngine        : TnxBaseServerEngine;

    function bsGetServerEngine: TnxBaseServerEngine; override;
    procedure sesSetServerEngine(aServerEngine: TnxBaseServerEngine); virtual;
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;
  public
    { destructor. }
    destructor Destroy; override;
  published
    { The connected Server Engine. Please note that every Session
      must(!) be connected to a Server engine before it can be
      \opened                                                     }
    property ServerEngine
      write sesSetServerEngine;
  end;

  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  TnxBaseSessionPool = class;

  { A pooled, reference counted Session for use with session
    pools (TnxBaseSessionPool) }
  TnxPooledSession = class(TnxBaseSession)
  protected {private}
    psSessionPool  : TnxBaseSessionPool;
    psOwningThread : Cardinal;
    psRefCount     : Integer;
    psInPool       : Boolean;

    function bsGetServerEngine: TnxBaseServerEngine; override;
    function bsGetTimeout: Integer; override;

    procedure psSetSessionPool(aSessionPool: TnxBaseSessionPool);
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure scStopping; override;

    procedure psCheckThread;
    procedure psCheckNoThread;
    procedure psCheckNotReferenced;
  public
    { destructor. }
    destructor Destroy; override;

//DOM-IGNORE-BEGIN
    procedure AddRef;
    procedure Release;
//DOM-IGNORE-END
  published
    { The session pool the session belongs to. }
    property SessionPool: TnxBaseSessionPool
      read psSessionPool
      write psSetSessionPool;
  end;

  { Base class for session pools }
  TnxBaseSessionPool = class(TnxDataAccessStateComponent, IUnknown, InxSessionRequests)
  protected {private}
    bspSessions            : TnxListPortal;
    bspPool                : TnxThreadSafeStack;
    bspPool2               : TnxThreadSafeStack;
    bspOutstandingSessions : Integer;

    bspUserName            : UnicodeString;
    bspPassword            : UnicodeString;

    bspTimeout             : Integer;

    function bspGetServerEngine: TnxBaseServerEngine; virtual; abstract;

    procedure bspSetPassword(const aValue: UnicodeString);
    procedure bspSetUserName(const aValue: UnicodeString);

    function bspGetTimeout: Integer;
    procedure bspSetTimeout(aTimeout : Integer);
  protected
    procedure nxcAddDependent(aComponent: TnxComponent); override;
    procedure nxcRemoveDependent(aComponent: TnxComponent); override;

    procedure scInitializing; override;
    procedure scStarting; override;
    procedure scStopping; override;

    procedure bspCheckServerEngine; virtual;

    function bspCreateSession: TnxPooledSession; virtual;
    function bspReturn(aSession : TnxPooledSession)
                                : Boolean; virtual;

    { InxSessionRequests. }
    function ProcessRequest(aSource         : TObject;
                            aThreadPriority : TnxThreadPriority;
                            aMsgID          : TnxMsgID;
                            aTimeout        : TnxWord32;
                            aRequestData    : Pointer;
                            aRequestDataLen : TnxWord32;
                            aReply          : PPointer;
                            aReplyLen       : PnxWord32;
                            aReplyType      : TnxNetMsgDataType;
                            aCanSkipCantSkip: Boolean = False;
                            aSequenceID     : PnxWord32 = nil)
                                            : TnxResult;

    function ProcessRequestDirect(aRemoteThreadPriority : TnxThreadPriority;
                                  aMsgID                : TnxMsgID;
                                  aTimeout              : TnxWord32;
                                  aRequestData          : Pointer;
                                  aRequestDataLen       : TnxWord32;
                                  aReply                : PPointer;
                                  aReplyLen             : PnxWord32;
                                  aReplyType            : TnxNetMsgDataType)
                                                        : TnxResult;

    procedure ProcessPost(aSource         : TObject;
                          aThreadPriority : TnxThreadPriority;
                          aMsgID          : TnxMsgID;
                          aTimeout        : TnxWord32;
                          aRequestData    : Pointer;
                          aRequestDataLen : TnxWord32);
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { Returns a free session out of the pool. }
    function AcquireSession: TnxPooledSession;

    {-- properties --}

    { Returns the Server Engine the session pool is connected to. Note,
      that this is read only in the base class. The Set method
      might be implemented in descendants.                          }
    property ServerEngine : TnxBaseServerEngine
      read bspGetServerEngine;
  published
    { The user name for the session pool. It is only used when the
      connected Server Engine is in secure mode.

      See Also
      UserName, Password }
    property UserName: UnicodeString
      read bspUserName
      write bspSetUserName;
    { The password for the session pool. It is only used when the
      connected Server Engine is in secure mode.

      See Also
      UserName, Password }
    property Password: UnicodeString
      read bspPassword
      write bspSetPassword;

    { Sets the Timeout for the Session pool commands (in ms). }
    property Timeout: Integer
      read bspTimeout
      write bspSetTimeout
      default -1;
  end;

  { A threadsafe session pool. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxSessionPool = class(TnxBaseSessionPool)
  protected {private}
    spServerEngine        : TnxBaseServerEngine;

    function bspGetServerEngine: TnxBaseServerEngine; override;
    procedure spSetServerEngine(aServerEngine: TnxBaseServerEngine); virtual;
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;
  public
    { destructor. }
    destructor Destroy; override;
  published
    { The connected Server Engine. Please note that every Session
      must(!) be connected to a Server engine before it can be opened                                                     }
    property ServerEngine
      write spSetServerEngine;
  end;

  { A thread with an automatically created TnxSession instance. }
  TnxThreadWithSession = class(TnxInitThread)
  private
    function twsGetSession: TnxBaseSession;
  protected {private}
    twsSessionPool : TnxBaseSessionPool;
    twsSession     : TnxPooledSession;

    procedure DoBeforeExecute; override;
    procedure DoAfterExecute; override;
  public
    { Constructor.
      Parameters:
        aThreadPriority - priority of the created Thread
        aSessionPool - pool where the session is acquired from (MUST not be nil)
    }
    constructor Create(aThreadPriority : TThreadPriority;
                       aSessionPool    : TnxBaseSessionPool);

    { The auto created session which is only valid in the Execute environment! }
    property Session: TnxBaseSession
      read twsGetSession;
  end;

  { A thread with an automatically created TnxSession and TnxDatabase instance. }
  TnxThreadWithDatabase = class(TnxThreadWithSession)
  protected {private}
    twdAlias    : string;
    twdDatabase : TnxDatabase;
  protected
    procedure DoBeforeExecute; override;
    procedure DoAfterExecute; override;
  public
    { Constructor.
      Parameters:
        aThreadPriority - priority of the created Thread
        aSessionPool - pool where the session is acquired from (MUST not be nil)
        aAlias - the alias the database instance should point to
    }
    constructor Create(aThreadPriority : TThreadPriority;
                       aSessionPool    : TnxBaseSessionPool;
                 const aAlias          : string);

    { The auto created database which is only valid in the Execute environment! }
    property Database: TnxDatabase
      read twdDatabase;
  end;

  { A thread with an automatically created TnxSession, TnxDatabase and TnxTable instance. }
  TnxThreadWithTable = class(TnxThreadWithDatabase)
  protected {private}
    twtTableName : string;
    twtIndexName : string;
    twtPassword  : UnicodeString;
    twtTable     : TnxTable;
  protected
    procedure DoBeforeExecute; override;
    procedure DoAfterExecute; override;
  public
    { Constructor.
      Parameters:
        aThreadPriority - priority of the created Thread
        aSessionPool - pool where the session is acquired from (MUST not be nil)
        aAlias - the alias the database instance should point to
        aTableName - the name of the table to attach to
        aIndexName - the initial set index
        aPassword - the password needed to open the table
    }
    constructor Create(aThreadPriority : TThreadPriority;
                       aSessionPool    : TnxBaseSessionPool;
                 const aAlias          : string;
                 const aTableName      : string;
                 const aIndexName      : string;
                 const aPassword       : UnicodeString);

    { The auto created table which is only valid in the Execute environment! }
    property Table: TnxTable
      read twtTable;
  end;
  {$ENDIF}

  { Base class for all stateful components owned by a session, e.g. databases }
  TnxSessionOwnedDataAccessStateComponent = class(TnxDataAccessStateComponent)
  protected {private}
    soSession          : TnxBaseSession;
    soTimeout          : Integer;

    procedure soSetSession(Value: TnxBaseSession); virtual;

    procedure soSetTimeout(Value: Integer);
    function soGetTimeout: Integer;
  protected
    procedure Loaded; override;

    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure soCheckDefaults; virtual;

    procedure soRefreshTimeout; virtual; abstract;
    procedure soCheckSession;
  public
    { constructor }
    constructor Create(aOwner: TComponent); override;

    { see TDataset.AfterConstruction }
    procedure AfterConstruction; override;
  published
    { The session the database is attached to. This property <b>must</b> be set
      for the component to work properly. }
    property Session: TnxBaseSession
      read soSession
      write soSetSession;

    { Set the timeout for the component in ms. If -1 is specified the component
      inherits the value of the session it is connected to. }
    property Timeout: Integer
      read soTimeout
      write soSetTimeout
      default -1;
  end;

  TnxTransContextBase = class(TnxSessionOwnedDataAccessStateComponent)
  protected {private}
    function btcGetInTransaction: Boolean; virtual; abstract;
  public
    {-- transaction managment --}

    { StartTransaction tries to start a transaction. If it fails an exception is triggered.
      Parameters:
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransaction(aSnapShot: Boolean = False); virtual; abstract;
    { Tries start a transaction (if none was started by the current
      TnxDatabase), returns true if a new transaction was started,
      false if a transaction was already started by in this context
      or triggers an exception if an error occurs.

      Parameters
      aSnapshot :  if true it is handled as a SnapshotTransaction; for
                   more info see the nexus manual
      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted            }
    function TryStartTransaction(aSnapShot: Boolean = False) : Boolean; virtual; abstract;

    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWithEx, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransactionWith(const aTables   : array of TnxTable;
                                         aSnapShot : Boolean = False); virtual; abstract;
    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function StartTransactionWithEx(const aTables   : array of TnxTable;
                                          aSnapShot : Boolean = False)
                                                    : TnxResult; virtual; abstract;

    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionIncludeEx, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure TransactionInclude(const aTables    : array of TnxTable;
                                       aExclusive : Boolean = True); virtual; abstract;
    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionInclude, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function TransactionIncludeEx(const aTables    : array of TnxTable;
                                        aExclusive : Boolean = True)
                                                   : TnxResult; virtual; abstract;

    { This method commits a pending transaction (level). If an
      error occurs (e.g. deadlock detected or transaction level has
      been marked as corrupted) the transaction is <B>not</B>
      automatically rolled back. You have to call Rollback in that
      case.

      For more info see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted         }
    procedure Commit; virtual; abstract;
    { Rollback rolls (as the name says) back a pending transaction (level). All
      changes since the last StartTransaction (or equivalent) call are lost.
      For more info see the nexus manual.
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure Rollback; virtual; abstract;
    { This method marks the transaction (level) as corrupted and
      thus preventing it from ever being committed. For more info
      see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted        }
    procedure TransactionCorrupted; virtual; abstract;

    { Returns true if a transaction for the current database is active otherwise
      false.
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    property InTransaction : Boolean
       read btcGetInTransaction;
  end;

  { Base Implementation of a TDatabase similar component. }
  TnxBaseDatabase = class(TnxTransContextBase)
  protected {private}
    bdbTransContext: TnxTransContext;

    bdbAliasName: string;
    bdbAliasPath: string;

    bdbAbstractDatabase: TnxAbstractDatabase;
    bdbAbstractDatabase31000: InxAbstractDatabase31000;

    bdbExclusive: Boolean;
    bdbReadOnly: Boolean;
    bdbFailSafe: Boolean;

    bdbImplicit: Boolean;

    procedure bdbAcquireInterfaces;

    procedure bdbSetTransContext(Value: TnxTransContext);

    procedure bdbSetAliasName(Value: string);
    function bdbIsAliasNameStored: Boolean;

    procedure bdbSetAliasPath(Value: string);
    function bdbIsAliasPathStored: Boolean;

    procedure bdbCheckAlias;

    function bdbGetPath: string;

    procedure bdbSetExclusive(Value: Boolean);
    procedure bdbSetReadOnly(Value: Boolean);
    procedure bdbSetFailSafe(Value: Boolean);
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent): Boolean; override;

    procedure scInitializing; override;
    procedure scStarting; override;
    procedure scStopping; override;

    procedure soCheckDefaults; override;
    procedure soSetSession(Value: TnxBaseSession); override;

    function bdbDatabaseOpen: TnxAbstractSessionDatabaseOpen; virtual;
  public
    {-- miscellaneous --}

    { Returns true if the database exists. }
    function Exists: Boolean;

    { This method returns the remaining disk space for the disk this database/alias
      is stored on.
      Parameters:
        aFreeSpace: will hold the free space info after the method returns
    }
    function GetFreeDiskSpace: TnxInt64;

    { This method returns the remaining disk space for the disk this database/alias
      is stored on.
      Parameters:
        aFreeSpace: will hold the free space info after the method returns
    }
    function GetFreeDiskSpaceEx(out aFreeSpace : TnxInt64): TnxResult;

    { Returns the full (server based!) system path of the database. }
    function GetPath: string;

    property AbstractDatabase: TnxAbstractDatabase
      read bdbAbstractDatabase;

    { \Returns the file system path of this database. }
    property Path: string
      read bdbGetPath;
  published
    { The alias name the database is connected to. Either AliasName
      \or AliasPath <B>must</B> be set.

      See Also
      AliasPath }
    property AliasName: string
      read bdbAliasName
      write bdbSetAliasName
      stored bdbIsAliasNameStored;

    { The (local server) path the database is connected to. Either AliasName
      or AliasPath <b>must</b> be set.
      See Also: AliasName }
    property AliasPath: string
      read bdbAliasPath
      write bdbSetAliasPath
      stored bdbIsAliasPathStored;

    { If a database is exclusively opened, only ONE client has access at a time. }
    property Exclusive: Boolean
      read bdbExclusive
      write bdbSetExclusive
      default False;

    { Sets failsafe mode on or off. For more info see NexusDB manual. }
    property FailSafe: Boolean
      read bdbFailSafe
      write bdbSetFailSafe
      default False;

    { With this property a database can be set to read only. }
    property ReadOnly: Boolean
      read bdbReadOnly
      write bdbSetReadOnly
      default False;

    { The transaction context the database is attached to. This property can be
      nil. }
    property TransContext: TnxTransContext
      read bdbTransContext
      write bdbSetTransContext;
  end;

  { Component for storing a client side record buffer and blob cache. Can be attached to a TnxDatabase. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxCacheDatabase = class(TnxBaseDatabase)
  protected
    function bdbDatabaseOpen: TnxAbstractSessionDatabaseOpen; override;

    procedure soRefreshTimeout; override;
  end;

  { Implementation of a TDatabase similar component. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxDatabase = class(TnxBaseDatabase)
  protected {private}
    dbLoadedDefault         : Boolean;
    dbCacheDatabase         : TnxCacheDatabase;

    dbDataSets              : TnxSortedList;

    dbTables                : TnxSortedList;
    dbQueries               : TnxSortedList;

    function dbGetCursorCount: Integer;
    function dbGetCursor(aInx: Integer): TnxCursor;

    function dbGetDataSetCount: Integer;
    function dbGetDataSet(aInx: Integer): TnxDataset;

    function dbGetTableCount: Integer;
    function dbGetTable(aInx: Integer): TnxTable;

    function dbGetQueryCount: Integer;
    function dbGetQuery(aInx: Integer): TnxStatementDataSet;

    function btcGetInTransaction: Boolean; override;

    function dbGetDefault: Boolean;
    procedure dbSetDefault(const Value: Boolean);

    procedure dbSetCacheDatabase(aValue: TnxCacheDatabase);
  protected
    procedure Loaded; override;

    procedure nxcAddDependent(aComponent: TnxComponent); override;
    procedure nxcRemoveDependent(aComponent: TnxComponent); override;
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;
    procedure scStarting; override;
    procedure scStopping; override;

    procedure soRefreshTimeout; override;

    property CursorCount: Integer
      read dbGetCursorCount;
    property Cursors[aInx: Integer]: TnxCursor
      read dbGetCursor;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    {-- statement support --}
    { Executes a SQL query and returns it's result.

      Parameters:
        aQuery - the SQL query as string
        aParams - an array of parameter values
    }
    function ExecQuery(const aQuery  : string;
                       const aParams : array of const)
                                     : TnxDynVariantArray;

    { Executes a SQL query and returns it's result.

      Parameters:
        aFileName - the file containing the query
        aParams - an array of parameter values
    }
    function ExecQueryFromFile(const aFileName : string;
                               const aParams   : array of const)
                                               : TnxDynVariantArray;

    { Executes a SQL query and returns it's result.

      Parameters:
        aStream - the stream containing the query
        aParams - an array of parameter values
    }
    function ExecQueryFromStream(aStream : TStream;
                           const aParams : array of const)
                                         : TnxDynVariantArray;

    { Executes a SQL Stored Procedure and returns it's result.

      Parameters:
        aStoredProcName - the name of the procedure
        aParams - an array of parameter values
    }
    function ExecStoredProc(const aStoredProcName : string;
                            const aParams         : array of const)
                                                  : TnxDynVariantArray;

    { Executes a SQL query and returns a cursor (if applicaple)
      Parameters:
        aQuery - the SQL query as string
        aParams - array of parameter values
        aBlockReadSize - if > 0 then it's the size in bytes for block reading
          the resulting cursor
        aRequestLive - if true then tries to get a live result set
    }
    function OpenQuery(const aQuery         : string;
                       const aParams        : array of const;
                             aBlockReadSize : Integer = 0;
                             aRequestLive   : Boolean = False)
                                            : TnxQuery;
    { Opens SQL Stored Procedure and returns it's local instance

      Parameters:
        aStoredProcName - the name of the procedure
        aParams - an array of parameter values
    }
    function OpenStoredProc(const aStoredProcName : string;
                            const aParams         : array of const;
                                  aBlockReadSize  : Integer = 0)
                                                  : TnxStoredProc;

    { Opens a Table.
      Parameters:
        aTableName - the name of the table
        aIndexName - the name of the index
        aBlockReadSize - if > 0 then it's the size in bytes for block reading
          the resulting cursor
    }
    function OpenTable(const aTableName     : string;
                       const aIndexName     : string = '';
                             aBlockReadSize : Integer = 0)
                                            : TnxTable;

    {-- stored procedure management --}

    { GetStoredProcNames returns a list of all stored procedures of the database.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetStoredProcNames(aList: TStrings);
    { Returns the parameter defintions for a named stored procedure. }
    procedure GetStoredProcParams(const aStoredProcName : string;
                                    out aParams         : TnxStoredProcParamList);

    { GetStoredFuncNames returns a list of all stored function of the database.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetStoredFuncNames(aList: TStrings);
    { Returns the parameter defintions for a named stored function. }
    procedure GetStoredFuncParams(const aStoredFuncName : string;
                                    out aParams         : TnxStoredProcParamList);

    {-- table managment --}

    { GetTableNames returns a list of all tables of the database.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetTableNames(aList : TStrings);
    { GetChangedTables returns a list of all open tables in this database that
      have changed since the function was last called.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetChangedTables(aList : TStrings);

    { GetTablesNeedingPack returns a list of all tables that need to be packed.
      Parameters:
        aList: will hold the names after the method returns; must not be nil
    }
    procedure GetTablesNeedingPack(aList : TStrings);

    { This function returns true if a table with the given name
      exists otherwise false.

      Parameters
      aTableName :  table name                                  }
    function TableExists(const aTableName : string;
                         const aPassword  : UnicodeString)
                                          : Boolean;

    { Reads a named stream from a specified table.
      Returns an error code.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object into which the data is written
    }
    function TableStreamReadEx(const aTableName  : string;
                               const aPassword   : UnicodeString;
                               const aStreamName : string;
                                     aStream     : TStream)
                                                 : TnxResult;

    { Reads a named stream from a specified table.
      Returns a newly creates stream object.
      The caller is responsible for freeing the
      stream object after use. Raises exception on error.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
    }
    function TableStreamRead(const aTableName  : string;
                             const aPassword   : UnicodeString;
                             const aStreamName : string)
                                               : TStream;

    { Writes a named stream into a specified table.
      Returns an error code.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object to be written
    }
    function TableStreamWriteEx(const aTableName  : string;
                               const aPassword   : UnicodeString;
                               const aStreamName : string;
                                     aStream     : TStream)
                                                 : TnxResult;

    { Writes a named stream into a specified table.
      Raises exception on error.
      Parameters:
        aAliasName : the name of the alias
        aTableName : the name of the table
        aPassword  : tha encryption password for the table
        aStreamName: the name of the stream
        aStream    : a stream object to be written
    }
    procedure TableStreamWrite(const aTableName  : string;
                               const aPassword   : UnicodeString;
                               const aStreamName : string;
                                     aStream     : TStream);

    { Use CreateTable to create a new table with the structure defined by the
      given dictionary. Raises an exception on failure.
      Parameters:
        aOverWrite:
          if true, an existing table is overwritten if it is not in use
        aTableName:
          the name of the new table
        aDictionary:
          the dictionary that defines the table and index structure
      See Also: DeleteTable, CreateTableEx, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable
    }
    procedure CreateTable(aOverWrite  : Boolean;
                    const aTableName  : string;
                    const aPassword   : UnicodeString;
                          aDictionary : TnxDataDictionary;
                          aTableScope : TnxTableScope = tsPersistent);

    { Use CreateTable to create a new table with the structure defined by the
      given dictionary. Returns an error code on failure.
      Parameters:
        aOverWrite:
          if true, an existing table is overwritten if it is not in use
        aTableName:
          the name of the new table
        aDictionary:
          the dictionary that defines the table and index structure
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable
    }
    function CreateTableEx(aOverWrite  : Boolean;
                     const aTableName  : string;
                     const aPassword   : UnicodeString;
                           aDictionary : TnxDataDictionary;
                           aTableScope : TnxTableScope = tsPersistent)
                                       : TnxResult;
    { This method deletes the table with the given name.
      Parameters:
        aTableName: table name
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable
    }
    procedure DeleteTable(const aTableName : string;
                          const aPassword  : UnicodeString);
    { EmptyTable deletes <b>all</b> records of the given table.
      Parameters:
        aTableName: table name
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable
    }
    procedure EmptyTable(const aTableName : string;
                         const aPassword  : UnicodeString);
    { RenameTable changes the name of a table.
      Parameters:
        aOldName: name of existing table
        aNewName: new name for the table
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable
    }
    procedure RenameTable(const aOldName, aNewName: string; const aPassword: UnicodeString);

    { This method starts an asynchronous packing of the table. For this purpose a new
      identical table is created and the records are copied over from the
      old one. Raises an exception on failure.
      Parameters:
        aName: table name
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTableEx,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function PackTable(const aTableName : string;
                       const aPassword  : UnicodeString)
                                        : TnxAbstractTaskInfo;

    { This method starts an asynchronous packing of the table. For this purpose a new
      identical table is created and the records are copied over from the
      old one. Returns an error code on failure.
      Parameters:
        aName: table name
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function PackTableEx(const aTableName : string;
                         const aPassword  : UnicodeString;
                           out aTaskInfo  : TnxAbstractTaskInfo)
                                          : TnxResult;

    { This method starts an asynchronous backup of the table. For this purpose a new
      table with identical fields is created and the records are copied over from the
      old one. Raises an exception on failure.
      Parameters:
        aName   : table name
        aTarget : the database where the backup is created
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTableEx,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function BackupTable(const aTableName : string;
                         const aPassword  : UnicodeString;
                               aTarget    : TnxDatabase)
                                          : TnxAbstractTaskInfo;
    { This method starts an asynchronous backup of the table. For this purpose a new
      table with identical fields is created and the records are copied over from the
      old one. Returns an error code on failure.
      Parameters:
        aName: table name
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function BackupTableEx(const aTableName : string;
                           const aPassword  : UnicodeString;
                                 aTarget    : TnxDatabase;
                             out aTaskInfo  : TnxAbstractTaskInfo)
                                            : TnxResult;

    { ReindexTable starts an asynchronous re indexing of a certain
      index of a table. Raises an exception on failure.

      Parameters
      aName :      table name
      aIndexNum :  the index number of the index in the list of
                   indexes
      aTaskInfo :  Task information instance; use TaskInfo.GetStatus
                   to find out the status of the operation.
      See Also
      DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable
      ReIndexTableEx, RestructureTable, TnxAbstractTaskInfo,
      GetStatus                                                      }
    function ReIndexTable(const aTableName : string;
                          const aPassword  : UnicodeString;
                                aIndexNum  : Integer)
                                           : TnxAbstractTaskInfo; overload;

    { ReIndexTable starts an asynchronous re indexing of a certain
      index of a table. Raises an exception on failure.

      Parameters
      aName :       table name
      aIndexName :  the name of the index
      aTaskInfo :   Task information instance; use TaskInfo.GetStatus
                    to find out the status of the operation.
      See Also
      DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
      ReIndexTableEx, RestructureTable, TnxAbstractTaskInfo,
      GetStatus                                                       }
    function ReIndexTable(const aTableName : string;
                          const aPassword  : UnicodeString;
                          const aIndexName : string)
                                           : TnxAbstractTaskInfo; overload;

    { ReindexTableEx starts an asynchronous re indexing of a certain
      index of a table. Returns an error code on failure.

      Parameters
      aName :      table name
      aIndexNum :  the index number of the index in the list of
                   indexes
      aTaskInfo :  Task information instance; use TaskInfo.GetStatus
                   to find out the status of the operation.
      See Also
      DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable
      ReIndexTable, RestructureTable, TnxAbstractTaskInfo,
      GetStatus                                                      }
    function ReIndexTableEx(const aTableName : string;
                            const aPassword  : UnicodeString;
                                  aIndexNum  : Integer;
                              out aTaskInfo  : TnxAbstractTaskInfo)
                                             : TnxResult; overload;
    { ReIndexTableEx starts an asynchronous re indexing of a certain
      index of a table. Returns an error code on failure.

      Parameters
      aName :       table name
      aIndexName :  the name of the index
      aTaskInfo :   Task information instance; use TaskInfo.GetStatus
                    to find out the status of the operation.
      See Also
      DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
      ReIndexTable, RestructureTable, TnxAbstractTaskInfo,
      GetStatus                                                       }
    function ReIndexTableEx(const aTableName : string;
                            const aPassword  : UnicodeString;
                            const aIndexName : string;
                              out aTaskInfo  : TnxAbstractTaskInfo)
                                             : TnxResult; overload;

    { With this method you can start an asynchronous restructure of a given table.
      Raises an exception on failure.
      Parameters:
        aName: table name
        aDictionary: new dictionary of the table
        aFieldName: defines how fields are mapped from the old to the new structure
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function RestructureTable(const aTableName   : string;
                              const aPassword    : UnicodeString;
                                    aDictionary  : TnxDataDictionary;
                                    aMapperDesc  : TnxBaseTableMapperDescriptor)
                                                 : TnxAbstractTaskInfo;
    { With this method you can start an asynchronous restructure of a given table.
      Returns an error code on failure.
      Parameters:
        aName: table name
        aDictionary: new dictionary of the table
        aFieldName: defines how fields are mapped from the old to the new structure
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: DeleteTable, CreateTable, EmptyTable, RenameTable, PackTable,
        ReIndexTable, RestructureTable, TnxAbstractTaskInfo, GetStatus
    }
    function RestructureTableEx(const aTableName   : string;
                                const aPassword    : UnicodeString;
                                      aDictionary  : TnxDataDictionary;
                                      aMapperDesc  : TnxBaseTableMapperDescriptor;
                                  out aTaskInfo    : TnxAbstractTaskInfo)
                                                   : TnxResult;

    function AddFieldToTable(const aTableName   : string;
                             const aPassword    : UnicodeString;
                                   aFieldDesc   : TnxFieldDescriptor)
                                                : TnxResult;

    { Changes the password of a table and triggers an exception if it failed. }
    procedure ChangePassword(const aTableName   : string;
                             const aOldPassword : UnicodeString;
                             const aNewPassword : UnicodeString);

    { Changes the password of a table and returns an error if failed. }
    function ChangePasswordEx(const aTableName   : string;
                              const aOldPassword : UnicodeString;
                              const aNewPassword : UnicodeString)
                                                 : TnxResult;

    { The method attempts to recover records from a broken table.
      Recovered records are placed in a new table named
      TableName_Recovered. Triggers and exception on failure.
      Unrecoverable records are placed in a new table named
      TableName_Failed.

      Parameters
      aTableName :   table name
      aPassword  :   table password
    }
    function RecoverTable(const aTableName : string;
                          const aPassword  : UnicodeString)
                                           : TnxAbstractTaskInfo;
    { The method attempts to recover records from a broken table.
      Recovered records are placed in a new table named
      TableName_Recovered. Returns an error value on failure.
      Unrecoverable records are placed in a new table named
      TableName_Failed.

      Parameters
      aTableName :   table name
      aPassword  :   table password
      aTaskInfo  :   returned task info, needs to be freed after use
    }
    function RecoverTableEx(const aTableName : string;
                            const aPassword  : UnicodeString;
                              out aTaskInfo  : TnxAbstractTaskInfo)
                                             : TnxResult;

    { This function walks all the blocks in the table on disk, and
      verifies the whole table checksum in the header (if the table
      is encrypted using an encryption engine which supports whole
      table checksums).

      Parameters
      aTableName    :   table name
      aPassword     :   table password
      aRaw          :   use raw, encoded blocks instead of decoding them
      aForceRecheck :   check all blocks again, even if already successfully checked since the server opened the table
    }
    function VerifyChecksumTable(const aTableName    : string;
                                 const aPassword     : UnicodeString;
                                       aRaw          : Boolean;
                                       aForceRecheck : Boolean)
                                                     : TnxAbstractTaskInfo;

    { This function walks all the blocks in the table on disk, and
      verifies the whole table checksum in the header (if the table
      is encrypted using an encryption engine which supports whole
      table checksums).

      Parameters
      aTableName    :   table name
      aPassword     :   table password
      aRaw          :   use raw, encoded blocks instead of decoding them
      aForceRecheck :   check all blocks again, even if already successfully checked since the server opened the table
      aTaskInfo     :   returned task info, needs to be freed after use
    }
    function VerifyChecksumTableEx(const aTableName    : string;
                                   const aPassword     : UnicodeString;
                                         aRaw          : Boolean;
                                         aForceRecheck : Boolean;
                                     out aTaskInfo     : TnxAbstractTaskInfo)
                                                       : TnxResult;


    { The method returns the data dictionary of a given table.
      Raises an exception on failure.

      Parameters
      aTableName :   table name
      aDictionary :  will hold the dictionary after the method
                     \returns; must not be nil                 }
    procedure GetDataDictionary(const aTableName   : string;
                                const aPassword    : UnicodeString;
                                      aDictionary  : TnxDataDictionary);

    { The method returns the data dictionary of a given table.
      Returns an error code on failure.

      Parameters
      aTableName :   table name
      aDictionary :  will hold the dictionary after the method
                     \returns; must not be nil                 }
    function GetDataDictionaryEx(const aTableName   : string;
                                 const aPassword    : UnicodeString;
                                       aDictionary  : TnxDataDictionary)
                                                    : TnxResult;

    { Returns the next AutoInc value for the given table. }
    procedure GetAutoIncValue(const aTableName : string;
                              const aPassword  : UnicodeString;
                                out aValue     : TnxWord32);
    {-- transaction managment --}

    { StartTransaction tries to start a transaction. If it fails an exception is triggered.
      Parameters:
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransaction(aSnapShot: Boolean = False); override;
    { Tries start a transaction (if none was started by the current
      TnxDatabase), returns true if a new transaction was started,
      false if a transaction was already started by this database
      instance or triggers an exception if an error occurs.

      Parameters
      aSnapshot :  if true it is handled as a SnapshotTransaction; for
                   more info see the nexus manual
      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted            }
    function TryStartTransaction(aSnapShot: Boolean = False) : Boolean; override;

    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransactionWith(const aTables   : array of TnxTable;
                                         aSnapShot : Boolean = False); override;
    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function StartTransactionWithEx(const aTables   : array of TnxTable;
                                          aSnapShot : Boolean = False)
                                                    : TnxResult; override;

    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionIncludeEx, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure TransactionInclude(const aTables    : array of TnxTable;
                                       aExclusive : Boolean = True); override;
    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionInclude, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function TransactionIncludeEx(const aTables    : array of TnxTable;
                                        aExclusive : Boolean = True)
                                                   : TnxResult; override;

    { This method commits a pending transaction (level). If an
      error occurs (e.g. deadlock detected or transaction level has
      been marked as corrupted) the transaction is <B>not</B>
      automatically rolled back. You have to call Rollback in that
      case.

      For more info see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted         }
    procedure Commit; override;
    { Rollback rolls (as the name says) back a pending transaction (level). All
      changes since the last StartTransaction (or equivalent) call are lost.
      For more info see the nexus manual.
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure Rollback; override;
    { This method marks the transaction (level) as corrupted and
      thus preventing it from ever being committed. For more info
      see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted        }
    procedure TransactionCorrupted; override;

    { Implicit is true if the database instance was create implicitly, e.g
      by using tnxTable directly without assigning it to a database. }
    property Implicit: Boolean
      read bdbImplicit;

    { Returns the number of dataset instances attached to this database.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property DataSetCount: Integer
      read dbGetDataSetCount;
    { Returns the dataset with index aInx out of the list of attached dataset
      instances.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property DataSets[aInx: Integer]: TnxDataset
      read dbGetDataSet;

    { Returns the number of (client-side) table instances attached to the database component.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property TableCount: Integer
      read dbGetTableCount;
    { Returns the table with index aInx out of the list of attached table
      instances.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property Tables[aInx: Integer]: TnxTable
      read dbGetTable;

    { Returns the number of (client-side) query instances attached to the database component.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property QueryCount: Integer
      read dbGetQueryCount;
    { Returns the query with index aInx out of the list of attached query instances.
      See Also: DataSetCount, DataSets, TableCount, Tables, QueryCount, Queries
    }
    property Queries[aInx: Integer]: TnxStatementDataSet
      read dbGetQuery;
  published
  { If true this Database is the default database for it's session. }
    property Default: Boolean
      read dbGetDefault
      write dbSetDefault
      default False;

    property CacheDatabase: TnxCacheDatabase
      read dbCacheDatabase
      write dbSetCacheDatabase;
  end;

  { Container for a Transaction Context. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxTransContext = class(TnxTransContextBase)
  protected {private}
    tcAbstractTransContext : TnxAbstractTransContext;
    tcDatabases            : TnxSortedList;
    tcCursors              : TnxSortedList;
    tcFailSafe             : Boolean;

    tcLoadedDefault        : Boolean;

    procedure tcSetFailSafe(Value: Boolean);

    function tcGetDatabaseCount: Integer;
    function tcGetDatabase(aInx: Integer): TnxDatabase;

    function tcGetCursorCount: Integer;
    function tcGetCursor(aInx: Integer): TnxCursor;

    function tcGetDatasetCount: Integer;
    function tcGetDataset(aInx: Integer): TnxDataset;

    function btcGetInTransaction: Boolean; override;

    function tcGetDefault: Boolean;
    procedure tcSetDefault(const Value: Boolean);
  protected
    procedure Loaded; override;

    procedure nxcAddDependent(aComponent: TnxComponent); override;
    procedure nxcRemoveDependent(aComponent: TnxComponent); override;

    procedure scInitializing; override;
    procedure scStarting; override;
    procedure scStopping; override;

    procedure soRefreshTimeout; override;

    { Returns the number of cursor instances attached to this cursor.
      See Also: CursorCount, Cursors
    }
    property CursorCount: Integer
      read tcGetCursorCount;
    { Returns the cursor with index aInx out of the list of attached cursor
      instances.
      See Also: CursorCount, Cursors
    }
    property Cursors[aInx: Integer]: TnxCursor
      read tcGetCursor;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    {-- transaction managment --}

    { StartTransaction tries to start a transaction. If it fails an exception is triggered.
      Parameters:
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransaction(aSnapShot: Boolean = False); override;
    { Tries start a transaction (if none was started by the current
      TnxDatabase), returns true if a new transaction was started,
      false if a transaction was already started by in this context
      or triggers an exception if an error occurs.

      Parameters
      aSnapshot :  if true it is handled as a SnapshotTransaction; for
                   more info see the nexus manual
      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted            }
    function TryStartTransaction(aSnapShot: Boolean = False) : Boolean; override;

    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWithEx, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure StartTransactionWith(const aTables   : array of TnxTable;
                                         aSnapShot : Boolean = False); override;
    { Start a transaction if an exclusive lock can be granted on all specified tables.
      If the grant fails one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: the tables that should be part of the transaction
        aSnapshot: if true it is handled as a SnapshotTransaction; for more info
          see the nexus manual
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function StartTransactionWithEx(const aTables   : array of TnxTable;
                                          aSnapShot : Boolean = False)
                                                    : TnxResult; override;

    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an exception is raised.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionIncludeEx, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure TransactionInclude(const aTables    : array of TnxTable;
                                       aExclusive : Boolean = True); override;
    { Attempts to gain a shared or exclusive transaction lock on all specified tables.
      Requires an active transaction.
      If the grant fails for one or more tables or an error occurs, an error code is returned.
      Parameters:
        aTables: The tables that should be part of the transaction
        aExclusive: Requests exclusive locks if true, otherwise shared locks are requested.
      See Also: StartTransaction, TransactionInclude, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    function TransactionIncludeEx(const aTables    : array of TnxTable;
                                        aExclusive : Boolean = True)
                                                   : TnxResult; override;

    { This method commits a pending transaction (level). If an
      error occurs (e.g. deadlock detected or transaction level has
      been marked as corrupted) the transaction is <B>not</B>
      automatically rolled back. You have to call Rollback in that
      case.

      For more info see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted         }
    procedure Commit; override;
    { Rollback rolls (as the name says) back a pending transaction (level). All
      changes since the last StartTransaction (or equivalent) call are lost.
      For more info see the nexus manual.
      See Also: StartTransaction, StartTransactionWith, TryStartTransaction,
        Commit, Rollback, InTransaction, TransactionCorrupted
    }
    procedure Rollback; override;
    { This method marks the transaction (level) as corrupted and
      thus preventing it from ever being committed. For more info
      see the nexus manual.

      See Also
      StartTransaction, StartTransactionWith, TryStartTransaction,
      Commit, Rollback, InTransaction, TransactionCorrupted        }
    procedure TransactionCorrupted; override;

    { Returns the number of database instances attached to this database.
      See Also: DatabaseCount, Databases
    }
    property DatabaseCount: Integer
      read tcGetDatabaseCount;
    { Returns the database with index aInx out of the list of attached database
      instances.
      See Also: DatabaseCount, Databases
    }
    property Databases[aInx: Integer]: TnxDatabase
      read tcGetDatabase;

    { Returns the number of dataset instances attached to this dataset.
      See Also: DataSetCount, DataSets
    }
    property DataSetCount: Integer
      read tcGetDataSetCount;
    { Returns the dataset with index aInx out of the list of attached dataset
      instances.
      See Also: DataSetCount, DataSets
    }
    property DataSets[aInx: Integer]: TnxDataSet
      read tcGetDataSet;
  published
    { Sets failsafe mode on or off. For more info see NexusDB manual. }
    property FailSafe: Boolean
      read tcFailSafe
      write tcSetFailSafe
      default False;

    { Returns true if the current instance is the automatically created
      default Context for the owning session. Setting this property makes
      that context the default for all TnxDatabase that are attached to
      that session afterwards. }
    property Default: Boolean
      read tcGetDefault
      write tcSetDefault
      default False;
  end;

  { Class defintion for Cursors. }
  TnxCursorClass = class of TnxCursor;

  { Client side base dataset cursor class. }
  TnxCursor = class(TnxDataAccessStateComponent)
  protected {private}
    crDataSet      : TnxDataset;
    crDatabase     : TnxDatabase;
    crTransContext : TnxTransContext;

    procedure crSetDatabase(const Value: TnxDatabase);
    procedure crSetTransContext(const Value: TnxTransContext);
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure scCheckInactive; override;

    procedure scInitializing; override;
    procedure scStopping; override;

    procedure crCheckDatabase;
    procedure crRefreshTimeout;
  public
    { constructor. }
    constructor Create(aDataSet: TnxDataset); reintroduce;

    { The database the cursor belongs to. }
    property Database: TnxDatabase
      read crDatabase
      write crSetDatabase;

    property TransContext: TnxTransContext
      read crTransContext
      write crSetTransContext;

    property DataSet: TnxDataset
      read crDataSet;
  end;

  { Base class for NexusDB blob streams.

    Never create instances directly! Always use TnxDataSet.CreateBlobStream,
    which will create the right type of blob stream based on the state of the
    dataset.

    The blob stream should be freed again as soon as possible. It must be freed
    before calling Post or moving to another record.

    See Also
    TnxDataSet.CreateBlobStream
    TnxBlobStream
    TnxBlockModeBlobStream
    TnxBatchAppendBlobStream
    TnxMemoBlobStream                                         }
  TnxBaseBlobStream = class(TStream)
  protected {private}
    bbsField       : TBlobField;
    bbsFieldNo     : TnxWord32;
    bbsDataset     : TnxDataset;

    bbsMode        : TBlobStreamMode;

    bbsDataSetPrev : TnxBaseBlobStream;
    bbsDataSetNext : TnxBaseBlobStream;
  protected
    { constructor. }
    constructor Create(aField : TBlobField; aMode : TBlobStreamMode); virtual;

    procedure bbsAddToDataSet;
    procedure bbsRemoveFromDataSet;

    procedure bbsCheck(const aErrorCode: TnxResult);

    procedure bbsDisable; virtual;
  public
    { destructor. }
    destructor Destroy; override;

    { This method truncates the blob data at the current position. }
    procedure Truncate; virtual; abstract;
  end;
  TnxBaseBlobStreamClass = class of TnxBaseBlobStream;

  { This class is used if the dataset is in block read mode.

    Never create instances directly! Always use TnxDataSet.CreateBlobStream,
    which will create the right type of blob stream based on the state of the
    dataset.

    The blob stream should be freed again as soon as possible. It must be freed
    before calling Post or moving to another record.

    See Also
    TnxDataSet.CreateBlobStream
    TnxBaseBlobStream
    TnxBlobStream
    TnxBatchAppendBlobStream
    TnxMemoBlobStream                                          }
  TnxBlockModeBlobStream = class(TnxBaseBlobStream)
  protected {private}
    bmbsPosition  : Integer;
    bmbsBlob      : Pointer;
  protected
    procedure bbsDisable; override;

    { constructor. }
    constructor Create(aField : TBlobField; aMode : TBlobStreamMode); override;
  public

    { With this method you can read a number of bytes of the blob data.
      Parameters:
        aBuffer: variable to store the read bytes
        aCount: number of bytes to read
    }
    function Read(var aBuffer;
                      aCount : Integer)
                             : Integer; override;
    { Use Write to write a number of bytes to the blob at the
      current position. Take care to not accidentally overwrite
      data by not positioning with Seek first.

      Parameters
      aBuffer :  data to be written
      aCount :   number of bytes to write                       }
    function Write(const aBuffer; aCount: Integer) : Integer; override;
    { Seek sets the current position in the blob stream.
      Parameters:
        aOffset: the offset in bytes to move the pointer
        aOrigin: the origin of the aOffset
    }
    function Seek(aOffset : Integer; aOrigin : Word) : Integer; override;

    { This method truncates the blob data at the current position. }
    procedure Truncate; override;
  end;
  TnxBlockModeBlobStreamClass = class of TnxBlockModeBlobStream;

  { This class is used if the dataset is in batch append mode.

    Never create instances directly! Always use TnxDataSet.CreateBlobStream,
    which will create the right type of blob stream based on the state of the
    dataset.

    The blob stream should be freed again as soon as possible. It must be freed
    before calling Post or moving to another record.

    See Also
    TnxDataSet.CreateBlobStream
    TnxBaseBlobStream
    TnxBlobStream
    TnxBlockModeBlobStream
    TnxMemoBlobStream                                             }
  TnxBatchAppendBlobStream = class(TnxBaseBlobStream)
  private
    babsStream  : TnxMemoryStream;
  protected
    procedure bbsDisable; override;

    { constructor. }
    constructor Create(aField : TBlobField; aMode : TBlobStreamMode); override;

    procedure SetSize(NewSize: Integer); overload; override;
    procedure SetSize(const NewSize: Int64); overload; override;
  public
    { destructor. }
    destructor Destroy; override;
    { With this method you can read a number of bytes of the blob data.
      Parameters:
        aBuffer: variable to store the read bytes
        aCount: number of bytes to read
    }
    function Read(var aBuffer;
                      aCount : Integer)
                             : Integer; override;
    { Use Write to write a number of bytes to the blob at the
      current position. Take care to not accidentally overwrite
      data by not positioning with Seek first.

      Parameters
      aBuffer :  data to be written
      aCount :   number of bytes to write                       }
    function Write(const aBuffer; aCount: Integer) : Integer; override;
    { Seek sets the current position in the blob stream.
      Parameters:
        aOffset: the offset in bytes to move the pointer
        aOrigin: the origin of the aOffset
    }
    function Seek(aOffset : Integer; aOrigin : Word) : Integer; override;

    { This method truncates the blob data at the current position. }
    procedure Truncate; override;
  end;
  TnxBatchAppendBlobStreamClass = class of TnxBatchAppendBlobStream;

  { This class is used to access memo blobs if Transliterate is true.

    Never create instances directly! Always use TnxDataSet.CreateBlobStream,
    which will create the right type of blob stream based on the state of the
    dataset.

    The blob stream should be freed again as soon as possible. It must be freed
    before calling Post or moving to another record.

    See Also
    TnxDataSet.CreateBlobStream
    TnxBaseBlobStream
    TnxBlobStream
    TnxBlockModeBlobStream                                             }
  TnxMemoBlobStream = class(TnxBaseBlobStream)
  private
    mbsInnerStream : TnxBaseBlobStream;
    mbsStream      : TStream;

    mbsIsWide      : Boolean;
    mbsCodePage    : Word;

    mbsModified    : Boolean;
  protected
    procedure bbsDisable; override;

    { constructor. }
    constructor Create(aField : TBlobField; aMode : TBlobStreamMode; aInnerStream: TnxBaseBlobStream); reintroduce; virtual;

    procedure SetSize(NewSize: Integer); overload; override;
    procedure SetSize(const NewSize: Int64); overload; override;
  public
    { destructor. }
    destructor Destroy; override;
    { With this method you can read a number of bytes of the blob data.
      Parameters:
        aBuffer: variable to store the read bytes
        aCount: number of bytes to read
    }
    function Read(var aBuffer;
                      aCount : Integer)
                             : Integer; override;
    { Use Write to write a number of bytes to the blob at the
      current position. Take care to not accidentally overwrite
      data by not positioning with Seek first.

      Parameters
      aBuffer :  data to be written
      aCount :   number of bytes to write                       }
    function Write(const aBuffer; aCount: Integer) : Integer; override;
    { Seek sets the current position in the blob stream.
      Parameters:
        aOffset: the offset in bytes to move the pointer
        aOrigin: the origin of the aOffset
    }
    function Seek(aOffset : Integer; aOrigin : Word) : Integer; override;

    { This method truncates the blob data at the current position. }
    procedure Truncate; override;
  end;
  TnxMemoBlobStreamClass = class of TnxMemoBlobStream;

  { This class is used to access a blob directly. All calls are directly passed
    through to the server engine.

    Never create instances directly! Always use TnxDataSet.CreateBlobStream,
    which will create the right type of blob stream based on the state of the
    dataset.

    The blob stream should be freed again as soon as possible. It must be freed
    before calling Post or moving to another record.

    See Also
    TnxDataSet.CreateBlobStream
    TnxBaseBlobStream
    TnxBlockModeBlobStream
    TnxBatchAppendBlobStream
    TnxMemoBlobStream                                           }
  TnxBlobStream = class(TnxBaseBlobStream)
  protected {private}
    bsBuffer         : TnxRecordBuffer;

    bsCache          : TnxMemoryStream;
    bsCacheStatus    : TnxResult;

    bsModified       : Boolean;
    bsOpened         : Boolean;
    bsReadOrg        : Boolean;
    bsNeedsTruncate0 : Boolean;

    bsPosition       : TnxInt64;
    bsChunkSize      : Integer;
  protected
    procedure bbsDisable; override;

    { constructor. }
    constructor Create(aField   : TBlobField;
                       aMode    : TBlobStreamMode;
                       aReadOrg : Boolean;
                       aCached  : Boolean); reintroduce; virtual;

    function bsShouldRetry(var aStatus    : TnxResult;
                         const aNewBlobNr : TnxNewBlobNr)
                                          : Boolean;
    function bsHasRecordChangedAtServer(var aStatus    : TnxResult;
                                      const aNewBlobNr : TnxNewBlobNr)
                                                       : Boolean;

    function bsGetBlobSize : TnxWord32;

    procedure bsReadCache(aMaxSize: Int64 = -1); virtual;
    procedure bsWriteCache; virtual;

    function GetSize: Int64; override;
    procedure SetSize(NewSize: Integer); overload; override;
    procedure SetSize(const NewSize: Int64); overload; override;
  public
    { destructor. }
    destructor Destroy; override;

    procedure Flush; virtual;

    { With this method you can read a number of bytes of the blob data.
      Parameters:
        aBuffer: variable to store the read bytes
        aCount: number of bytes to read
    }
    function Read(var aBuffer; aCount : Integer) : Integer; override;
    { Use Write to write a number of bytes to the blob at the
      current position. Take care to not accidentally overwrite
      data by not positioning with Seek first.

      Parameters
      aBuffer :  data to be written
      aCount  :   number of bytes to write                       }
    function Write(const aBuffer; aCount: Integer) : Integer; override;
    { Seek sets the current position in the blob stream.
      Parameters:
        aOffset: the offset in bytes to move the pointer
        aOrigin: the origin of the aOffset
    }
    function Seek(aOffset : Integer; aOrigin : Word) : Integer; override;
    { Seek sets the current position in the blob stream.
      Parameters:
        aOffset: the offset in bytes to move the pointer
        aOrigin: the origin of the aOffset
    }
    function Seek(const aOffset: Int64; aOrigin: TSeekOrigin): Int64; override;

    { This method truncates the blob data at the current position. }
    procedure Truncate; override;

    { Chunksize specifies the number of byte that are read/written in
      one file access. }
    property ChunkSize : Integer
      read bsChunkSize
      write bsChunkSize;
  end;
  TnxBlobStreamClass = class of TnxBlobStream;

  TnxBlobField = class(TBlobField)
  protected {private}
    bfLoadedMarked: Boolean;

    function bfGetMarked: Boolean;
    procedure bfSetMarked(aValue: Boolean);
  protected
    procedure Loaded; override;
  published
    property Marked: Boolean
      read bfGetMarked
      write bfSetMarked
      default False;
  end;

  { Extended field class for memo fields. }
  TnxMemoField = class(TMemoField)
  protected {private}
    mfLoadedMarked : Boolean;
    mfIsWide       : Boolean;
    mfCodePage     : Word;

    function mfGetMarked: Boolean;
    procedure mfSetMarked(aValue: Boolean);
  protected
    procedure Loaded; override;
    procedure Bind(Binding: Boolean); {$IFNDEF FPC}override;{$ENDIF}
  public
    function GetAsString: string; override;
    {$IFDEF DCC12OrLater}function GetAsAnsiString: AnsiString; override;{$ENDIF}
    function GetAsVariant: Variant; override;

    procedure SetAsString(const Value: string); override;
    {$IFDEF DCC12OrLater}procedure SetAsAnsiString(const Value: AnsiString); override;{$ENDIF}
    procedure SetVarValue(const Value: Variant); override;

    function GetAsWideString: UnicodeString; {$IFDEF DCC12OrLater}override;{$ENDIF}
    procedure SetAsWideString(const Value: UnicodeString); {$IFDEF DCC12OrLater}override;{$ENDIF}

    { Returns the Value as UnicodeString. }
    property AsWideString: UnicodeString
      read GetAsWideString
      write SetAsWideString;

    property Marked: Boolean
      read mfGetMarked
      write mfSetMarked
      default False;
  end;

  {$IFDEF DCC12OrLater}
  TnxWideMemoField = class(TWideMemoField)
  protected {private}
    wmfLoadedMarked : Boolean;

    function wmfGetMarked: Boolean;
    procedure wmfSetMarked(aValue: Boolean);
  protected
    procedure Loaded; override;
  published
    property Marked: Boolean
      read wmfGetMarked
      write wmfSetMarked
      default False;
  end;
  {$ENDIF}

  TnxGraphicField = class(TGraphicField)
  protected {private}
    gfLoadedMarked : Boolean;

    function gfGetMarked: Boolean;
    procedure gfSetMarked(aValue: Boolean);
  protected
    procedure Loaded; override;
  published
    property Marked: Boolean
      read gfGetMarked
      write gfSetMarked
      default False;
  end;

  {$IFDEF SUPPORTS_CLASS_HELPERS}
  TnxBlobFieldHelper = class helper for TBlobField
  protected
    function bfhGetMarked: Boolean;
    procedure bfhSetMarked(aValue: Boolean);
  published
    property Marked: Boolean
      read bfhGetMarked
      write bfhSetMarked
      default False;
  end;

  TnxMemoFieldHelper = class helper (TnxBlobFieldHelper) for TMemoField
  end;

  {$IFDEF DCC12OrLater}
  TnxWideMemoFieldHelper = class helper (TnxBlobFieldHelper) for TWideMemoField
  end;
  {$ENDIF SUPPORTS_CLASS_HELPERS}

  TnxGraphicFieldHelper = class helper (TnxBlobFieldHelper) for TGraphicField
  end;
  {$ENDIF SUPPORTS_CLASS_HELPERS}


  { Extended field class for string fields. }
  TnxStringField = class(TStringField)
  protected {private}
    sfCodePage : Word;
  protected
    procedure Bind(Binding: Boolean); {$IFNDEF FPC}override;{$ENDIF}
  public
    function GetAsString: string; override;
    {$IFDEF DCC12OrLater}function GetAsAnsiString: AnsiString; override;{$ENDIF}
    function GetAsVariant: Variant; override;

    procedure SetAsString(const Value: string); override;
    {$IFDEF DCC12OrLater}procedure SetAsAnsiString(const Value: AnsiString); override;{$ENDIF}
    procedure SetVarValue(const Value: Variant); override;

    function GetAsWideString: UnicodeString; {$IFDEF DCC12OrLater}override;{$ENDIF}
    procedure SetAsWideString(const Value: UnicodeString); {$IFDEF DCC12OrLater}override;{$ENDIF}

    { Returns the Value as UnicodeString. }
    property AsWideString: UnicodeString
      read GetAsWideString
      write SetAsWideString;
  end;

  TnxLargeintField = class(TLargeintField)
  protected
    function GetAsBCD: TBcd; override;
    procedure SetAsBCD(const Value: TBcd); override;
  end;

  { Field class that can correctly get a nx internal keyvalue as variant. }
  TnxKeyAsVariantField = class(TVariantField)
  protected
    function GetAsString: string; override;
    {$IFDEF DCC10OrLater}
    function GetAsWideString: UnicodeString; override;
    {$ENDIF}
    function GetAsVariant: Variant; override;
    procedure SetVarValue(const Value: Variant); override;
  public
    { constructor }
    constructor Create(AOwner: TComponent); override;
  end;

  { A Class of TFieldDef (needed for abstraction purposes only.) }
  TFieldDefClass = class of TFieldDef;

  { This is an event handler definition for Filter timeouts. It gives the
    programmer a chance to commence with a filtering even if the filter
    timeout is reached.
    See also: TnxDataset.FilterTimeout }
  TnxServerFilterTimeoutEvent = procedure(Sender : TnxDataset;
                                      var Cancel : Boolean) of object;

  TDataSetLinkRangeEvent = function(DataSet: TDataSet) : SmallInt of object; //..

  { Dataset states are used internally by the dataset class. There's
    no need for developers to manipulate these. }
  TnxDataSetInternalState = (
    { \internal use only. }
    disClosing,
    { \internal use only. }
    disShutdownFromCursor,
    { \internal use only. }
    disIndexInvalid,
    { \internal use only. }
    disJustOpenedCursor,
    { \internal use only. }
    disFirstRecordGetNextPriorAfterOpen,
    { \internal use only. }
    disGetBookmarkAfterFirst,
    { \internal use only. }
    disGetBookmarkNotNeeded,
    { \internal use only. }
    disInGetRecords,
    { \internal use only. }
    disInMoveBy,
    { \internal use only. }
    disInFilterClientBlockRead,
    { \internal use only. }
    disDelayedBufferFillingOnOpen,
    { \internal use only. }
    disAfterUpdateState,
    { \internal use only. }
    dsiBlockReadNeedsFirst,
    { \internal use only. }
    dsiInGotoQueuedKeys,
    { \internal use only. }
    dsiInsertSuccessful,
    { \internal use only. }
    dsiInOnFilterRecord
  );

  { Dataset states are used internally by the dataset class. There's
    no need for developers to manipulate these. }
  TnxDataSetInternalStates = set of TnxDataSetInternalState;

  { Dataset options definition
    See Also: TnxDataset.Options }
  TnxDataSetOption = (
    { Use optimistic record locks for edit. }
    dsoOptimisticLocks,

    { Adds a field to access the current key value as variant }
    dsoAddKeyAsVariantField,

    { Allows use of RecNo if the table supports it }
    dsoRecNoSupport,

    { Sets KeyFieldCount in PSSetParams if not all KeyFields have been set }
    dsoSetKeyFieldCountForPSSetParams,

    { Prevents PSSetParams from calling CancelRange if aParams.Count = 0}
    dsoKeepExistingRangeForPSSetParams,

    { Allows PartialMatch Locate calls for integers if the locate is using an index }
    dsoAllowPartialMatchIndexedLocateForIntegers,

    { Disables optimisations to reduce message count over remote connections }
    dsoDisableClientMessageReduction,

    { Disables optimisations to reduce message count over remote connections }
    dsoSwitchToIndexImplicitFirst,

    { Builds the key when calling QueueKey. Saves memory, but may prevent later editing of queued keys }
    dsoBuildKeyOnQueue,

    { Reads the complete Blob into memory on opening a BlobStream,
      delays writing to the server until the BlobStream is closed }
    dsoCachedBlobStreams,

    { If caching is active, will attempt to retrieve any missing blobs that are
      marked together with their records and add them to the local cache }
    dsoPreCacheMarkedBlobs,

    { Automatically marks Blob fields when they are accessed in read or read,
      write mode }
    dsoAutoMarkBlobsOnReadAccess,

    { Prevents checking for InFilterRecord state, operations will still have undefined behavior
      even if the check is not performed and no exception thrown. }
    dsoIgnoreInFilterRecordState,
    
    { Prevents a resync when setting BlockReadSize to 0 }
    dsoSupressResyncOnDisableBlockRead,

    { tracks the busy state of the DataSet, and calls NoLongerBusy if assigned}
    dsoTrackBusy,

    { triggers on OnFilterServerTimeout events locally every FilterTimeout msec while Busy, requires dsoTrackBusy to be set }
    dsoFilterTimeoutEventForGetRecord,

    { do not use client side caching for this cursor, even if it is available }
    dsoNoClientCache
  );

  { Blob Cache Options. }
  TnxDataSetOptions = set of TnxDataSetOption;

  { Possible Filter types for TnxDataset.Filter }
  TnxFilterType = (
    { Use simple expression filter }
    ftSimple,
    { Use SQL WHERE based filter }
    ftSqlWhere
  );

  {$IFNDEF DCC18OrLater}
  TRecBuf = TnxNativeInt;
  TBufList = Array of TRecBuf;
  {$ENDIF}

  TnxPrivateBufferAccess = record
    FBufferCount: Integer;
    FRecordCount: Integer;
    FActiveRecord: Integer;
    FCurrentRecord: Integer;
    FBuffers: TBufList;
  end;
  PnxPrivateBufferAccess = ^TnxPrivateBufferAccess;

  TnxDataSetInOperation = (
    dioNone,
    dioCancel,
    dioClose,
    dioDelete,
    dioEdit,
    dioInsert,
    dioOpen,
    dioPost,
    dioPostAndEdit,
    dioRefresh,
    dioScroll
  );

  { TnxDataset is the base class for all TDataset compatible
    Nexus components. Most methods and properties work exactly
    the same as Borland's implementation.                      }
  TnxDataset = class(TDataSet)
  protected {private}
    dsActiveRuntime               : Boolean;
    dsActiveDesigntime            : Boolean;
    dsDeactivating                : Boolean;

    dsTimeout                     : Integer;

    dsSession                     : TnxBaseSession;
    dsAliasName                   : string;

    { cursor. }
    dsCursor                      : TnxCursor;
    dsAbstractCursor              : TnxAbstractCursor;
    ds_Dictionary                 : TnxDataDictionary;
    dsTableDescriptor             : TnxBaseTableDescriptor;
    dsFieldsDescriptor            : TnxFieldsDescriptor;
    dsDefaultValueHandler         : TnxDefaultValueHandler;
    dsValidationsHandler          : TnxValidationsHandler;
    dsSFI                         : PnxSpecialFieldsInfo;

    dsWriteOnly                   : Boolean;
    dsInternalWriteOnly           : Boolean;

    { state. }
    dsOptions                     : TnxDataSetOptions;

    dsInternalState               : TnxDataSetInternalStates;
    dsIgnoreDataEvents            : Boolean;

    dsFlipOrder                   : Boolean;

    { field access. }
    dsMapperNexusToVcl            : TnxDynMapperMethodArray;
    dsMapperVclToNexus            : TnxDynMapperMethodArray;
    dsMapperFieldOffset           : array of Integer;
    dsMappers                     : array of TnxBaseVclFieldMapper;
    dsMapperList                  : TObjectList;
    dsBlobFields                  : array of TBlobField;

    dsIgnoreReadOnly              : Integer;

    { filter. }
    dsFilterResync                : Boolean;
    dsFilterResyncDoesFirst       : Boolean;
    dsFilterType                  : TnxFilterType;
    dsSimpleExpressionFilterClass : TnxSimpleExpressionFilterDescriptorClass;
    dsSqlFilterClass              : TnxSqlFilterDescriptorClass;
    dsFilterClientBlockReadCountMx: Integer;
    dsFilterClientBlockReadCountCr: Integer;

    dsExprFilter                  : TnxFilterID;
    dsFuncFilter                  : TnxFilterID;
    dsRecordToFilter              : Pointer;
    dsTempBufferBackup            : TnxRecordBuffer;

    dsFilterTimeout               : TnxWord32;
    dsOnServerFilterTimeout       : TnxServerFilterTimeoutEvent;
    dsLastFilterTimeout           : Int64;

    { record buffer. }
    dsRecordLength                : Integer;
    dsOffsetBookmark              : Integer;
    dsOffsetCalcFlds              : Integer;
    dsOffsetRecInfos              : Integer;
    dsRecordBufferSize            : Integer;
    dsRecordBufferPool            : TnxMemoryPool;
    {$IFOPT C+}
    dsRecordBufferCount           : Integer;
    {$ENDIF}

    dsOldValuesBuffer             : TnxRecordBuffer;

    { blob streams. }
    dsBlobStreamsHead             : TnxBaseBlobStream;
    dsBlobStreamsTail             : TnxBaseBlobStream;

    { block read mode. }
    dsBlockReadSize               : Integer;
    dsBlockReadOptions            : TnxRecordGetBatchExOptions;
    dsBlockReadAccess             : TnxBatchStreamAccess;
    dsBlockReadEntry              : PnxBatchStreamEntry;
    dsBlockReadEntryData          : TnxBatchStreamEntry;

    dsBlockReadCount              : Integer;
    dsBlockReadPos                : Integer;
    dsBlockReadTotalPos           : Integer;
    dsBlockReadQueuedKeyPos       : Integer;
    dsBlockReadEof                : Boolean;
    dsBlockReadCurrentError       : TnxResult;

    { batch append. }
    dsBatchAppend                 : Integer;
    dsBatchAppendCutoff           : Integer;
    dsBatchAppendBlobs            : array of TnxMemoryStream;
    dsBatchAppendData             : TnxMemoryStream;
    dsBatchAppendStartOffset      : array of int64;
    dsBatchAppendRecordCount      : array of integer;

    { lookup }
    dsLookupOptions               : TLocateOptions;

    { workarounds for crappy Borland bugs }
    dsInsideScroll                : Boolean;
    dsBof                         : PBoolean;
    dsEof                         : PBoolean;

    { client message reduction }
    dsPrivateBufferAccess         : PnxPrivateBufferAccess;
    dsMoveByDistance              : Integer;
    dsInOperation                 : TnxDataSetInOperation;

    { blobs }
    dsMarkedBlobsByFieldName      : TnxFastStringListIC;
    dsMarkedBlobsByBlobIdx        : TnxMarkedBlobsByBlobIdx;

    { first bookmark }
    dsFirstBookmark               : TBookmark;

    { busy }
    dsBusyCount                   : NativeInt;
    dsOnNoLongerBusy              : TNotifyEvent;

    function dsNoCMR: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    procedure dsStartBusy; {$IFDEF SUPPORTS_INLINE}{$IFDEF DCC25OrLater}inline;{$ENDIF}{$ENDIF}
    procedure dsEndBusy; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function dsIsBusy: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    { property access methods. }
    procedure SetActive(Value: Boolean); override;
    procedure dsSetActiveDesigntime(const Value: Boolean);
    procedure dsSetActiveRuntime(const Value: Boolean);

    procedure dsSetOptions(Value: TnxDataSetOptions);

    procedure dsSetAliasName(Value: string);
    function dsIsAliasNameStored: Boolean;

    function dsGetDataBase: TnxDatabase;
    procedure dsSetDataBase(const Value: TnxDatabase); virtual;
    function dsIsDatabaseStored: Boolean;

    function dsGetTransContext: TnxTransContext;
    procedure dsSetTransContext(const Value: TnxTransContext);

    function dsGetCurrentTransContext: TnxTransContextBase;

    function dsGetSession: TnxBaseSession;
    procedure dsSetSession(const Value: TnxBaseSession);
    function dsIsSessionStored: Boolean;

    procedure dsSetTimeout(const Value: Integer);
    function dsGetTimeout: Integer;

    procedure dsSetFilterType(const Value: TnxFilterType);
    procedure dsSetFlipOrder(const Value: Boolean);
    procedure dsSetFlipOrderNoRefresh(const Value: Boolean);

    function dsGetVersion : string;
    procedure dsSetVersion(const Value : string);

    procedure dsSetFilterClientBlockReadCount(const Value: Integer);

    function dsGetBlobMarked(aField: TField): Boolean;
    procedure dsSetBlobMarked(aField: TField; const Value: Boolean);
    function dsFieldToBlobIdx(aField: TField): Integer;

    procedure dsSetFirstBookmark(const aFirstBookmark: TBookmark); virtual;
  protected
    procedure Loaded; override;
    procedure dsCheckDefaults; virtual;

    { open / close cursor }
    procedure OpenCursor(aInfoQuery : Boolean); override;
    procedure InternalOpen; override;
    function IsCursorOpen : Boolean; override;

    procedure InternalInitFieldDefs; override;
    procedure CreateFields; override;

    procedure CloseCursor; override;
    procedure InternalClose; override;

    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    procedure CheckFieldCompatibility(aField: TField; aFieldDef: TFieldDef); {$IFNDEF FPC}override;{$ENDIF}

    { bookmarks. }
    {$IFDEF DCC17OrLater}
    procedure SetBookmarkData(aBuffer : TnxRecordBuffer; aData : TBookmark); overload; override;
    procedure GetBookmarkData(aBuffer : TnxRecordBuffer; aData : TBookmark); overload; override;
    {$ENDIF}
    procedure SetBookmarkData(aBuffer : TnxRecordBuffer; aData : Pointer); override;
    procedure GetBookmarkData(aBuffer : TnxRecordBuffer; aData : Pointer); override;

    procedure SetBookmarkFlag(aBuffer : TnxRecordBuffer;
                              aValue  : TBookmarkFlag); override;
    function GetBookmarkFlag(aBuffer : TnxRecordBuffer): TBookmarkFlag; override;

    function GetBookmarkStr: TBookmarkStr; override;

    procedure EndDelayedBufferFillingOnOpen; {$IFDEF SUPPORTS_INLINE}inline;
    procedure InnerEndDelayedBufferFillingOnOpen;
    {$ENDIF}

    {$IFDEF DCC16OrLater}
    procedure BeforeBookmarkAvailable; virtual;
    procedure AfterBookmarkAvailable(var aAvailable: Boolean); virtual;

    procedure BeforeSetState(var Value: TDataSetState); virtual;
    procedure AfterSetState; virtual;
    {$ENDIF}

    {$IFDEF DCC17OrLater}
    procedure InternalGotoBookmark(aBookmark : TBookmark); overload; override;
    {$ENDIF}
    procedure InternalGotoBookmark(aBookmark : TBookmarkOrPointer); override;

    procedure DoInternalGotoBookmark(aBookmark : Pointer);

    { recno support. }
    function GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;

    { record buffer management. }
    function GetRecordSize : Word; override;

    function AllocRecordBuffer : TnxRecordBuffer; override;
    procedure InternalInitRecord(aBuffer : TnxRecordBuffer); override;
    procedure FreeRecordBuffer(var aBuffer : TnxRecordBuffer); override;

    { filter. }
    procedure SetFiltered(Value : Boolean); override;
    procedure SetFilterOptions(Value : TFilterOptions); override;
    procedure SetFilterText(const Value : string); override;
    procedure SetOnFilterRecord(const Value : TFilterRecordEvent); override;

    { record access/naviagtion. }
    function FindRecord(aRestart, aGoForward : Boolean) : Boolean; override;
    function GetRecord(aBuffer  : TnxRecordBuffer;
                       aGetMode : TGetMode;
                       aDoCheck : Boolean): TGetResult; override;

    function GetNextRecord: Boolean; override;
    function GetNextRecords: Integer; override;

    function GetPriorRecord: Boolean; override;
    function GetPriorRecords: Integer; override;
    function GetPriorRecordsCount(aCount: Integer): Integer; virtual;

    procedure SetCurrentRecord(Index: Integer); override;

{$IFDEF DCC17OrLater}
    procedure InternalAddRecord(Buffer: TnxRecordBuffer;
                                Append: Boolean); overload; override;
{$ENDIF}
    procedure InternalAddRecord(aBuffer : Pointer;
                                aAppend : Boolean); override;
    procedure InternalCancel; override;
    procedure InternalDelete; override;
    procedure InternalEdit; override;
    procedure InternalFirst; override;
    procedure InternalLast; override;
    procedure InternalPost; override;
    procedure InternalPostAndEdit; virtual;
    procedure InternalPostImpl(aKeepLock: Boolean); virtual;
    procedure InternalSetToRecord(aBuffer : TnxRecordBuffer); override;

    procedure DoClearAndInternalFirst;

    procedure DoBeforeCancel; override;
    procedure DoBeforeClose; override;
    procedure DoBeforeDelete; override;
    procedure DoBeforeEdit; override;
    procedure DoBeforeInsert; override;
    procedure DoBeforePost; override;
    procedure DoBeforeRefresh; override;
    procedure DoBeforeScroll; override;

    procedure DoAfterCancel; override;
    procedure DoAfterClose; override;
    procedure DoAfterDelete; override;
    procedure DoAfterEdit; override;
    procedure DoAfterInsert; override;
    procedure DoAfterOpen; override;
    procedure DoAfterPost; override;
    procedure DoAfterRefresh; override;
    procedure DoAfterScroll; override;

    procedure FreeFieldBuffers; override;

    procedure SetBufListSize(Value: Integer); override;

    { block read mode. }
    procedure SetBlockReadSize(Value: Integer); {$IFNDEF FPC} override; {$ENDIF}
    procedure BlockReadNext; {$IFNDEF FPC} override; {$ENDIF}
    procedure ResetBlockReadStream; virtual;

    {$IFDEF FPC}
    property BlockReadSize: Integer read dsBlockReadSize write SetBlockReadSize;
    {$ENDIF}

    { field access. }
    procedure ClearCalcFields(aBuffer : TnxRecordBuffer); override;
    procedure CloseBlob(aField : TField); override;
    {$IFDEF DCC17OrLater}
    procedure SetFieldData(aField : TField; aBuffer : TValueBuffer); overload; override;
    {$ENDIF}
    procedure SetFieldData(aField : TField; aBuffer : Pointer); override;
    {$IFNDEF DCC10OrLater}
    procedure DataConvert(aField: TField; aSource, aDest: Pointer; aToNative: Boolean); {$IFNDEF FPC}override;{$ENDIF}
    {$ENDIF}

    procedure RefreshInternalCalcFields(Buffer: TnxRecordBuffer); override;

    { info. }
    function GetCanModify : Boolean; override;
    function GetRecordCount : Integer; override;
    {$IFDEF FPC}
    procedure DataEvent(aEvent: TDataEvent; aInfo: Ptrint); override;
    {$ELSE}
    procedure DataEvent(aEvent: TDataEvent; aInfo: TnxNativeInt); override;
    {$ENDIF}

    procedure InternalHandleException; override;
    procedure SetName(const NewName : TComponentName); override;

    { == internal functions == }
    function dsGetCursorClass: TnxCursorClass; virtual;

    { error handling. }
    class function dsExceptionClass: EnxDatabaseErrorClass; virtual;

    procedure dsCheck(const aErrorCode: TnxResult); overload;
    procedure dsCheck(aField: TField; const aErrorCode: TnxResult); overload;
    procedure dsError(const aErrorCode: TnxResult); overload;
    procedure dsError(const aErrorCode: TnxResult; const aAltMsg: string); overload;
    procedure dsError(const aErrorCode: TnxResult; const aAltMsg: string; const aArgs: array of const); overload;
    procedure dsError(const aMsg: string); overload;
    procedure dsError(const aMsg: string; const aArgs: array of const); overload;
    procedure dsError(const aErrorCode: TnxResult; aAltMsgRes: PResStringRec); overload;
    procedure dsError(const aErrorCode: TnxResult; aAltMsgRes: PResStringRec; const aArgs: array of const); overload;
    procedure dsError(aMsgRes: PResStringRec); overload;
    procedure dsError(aMsgRes: PResStringRec; const aArgs: array of const); overload;

    { \open/close. }
    procedure dsOpenCursorID; virtual; abstract;
    procedure dsCloseCursorID; virtual;
    procedure dsShutdownFromCursor; virtual;
    procedure dsClearCursorDependentState; virtual;
    procedure dsSetupCursorDependentState; virtual;

    procedure dsCheckInactiveFromCursor; virtual;

    procedure dsInitMappers; virtual;
    procedure dsFreeMappers; virtual;

    { init. }
    procedure dsInitBookmarkSize; virtual;
    procedure dsInitOffsets; virtual;
    procedure dsInitPersistentFields;

    procedure dsBindFields(Binding: Boolean); virtual;
    procedure dsBindBlobFields(Binding: Boolean); virtual;
    procedure dsBindMappers(Binding: Boolean); virtual;

    { key buffers. }
    procedure dsInitKeyBuffers; virtual;
    procedure dsFreeKeyBuffers; virtual;

    { buffer management. }
    function dsGetActiveBuffer(var aBuffer : TnxRecordBuffer): Boolean; virtual;
    function dsGetActiveKeyBuffer(var aBuffer : TnxRecordBuffer): Boolean; virtual;
    function dsGetActiveKeyBufferForBatch(var aBuffer : TnxRecordBuffer): Boolean; virtual;

    procedure dsBlockReadEntryChanged; virtual;

    { filter. }
    procedure dsCreateExprFilter(const aText   : string;
                                       aOpts   : TFilterOptions;
                                       aActive : Boolean);
    procedure dsCreateFuncFilter(aFilterFunc : TnxFilterCallback;
                                 aActive     : Boolean);
    function dsDropFilter(aFilterID : TnxFilterID) : TnxResult;
    procedure dsDropFilters;

    function dsActivateFilter(aFilterID : TnxFilterID) : TnxResult;
    function dsDeactivateFilter(aFilterID : TnxFilterID) : TnxResult;

    procedure dsActivateFilters; virtual;
    procedure dsDeactivateFilters; virtual;

    function dsCancelServerFilter: Boolean; virtual;

    function dsOnFilterRecordCallback({aCookie : Integer = Self}
                                       aRecord : PnxRecordBuffer)
                                               : Boolean; register;

    class procedure dsSwitchBuffers(var a, b: TRecBuf); {$IFDEF SUPPORTS_STATIC}static;{$ENDIF} {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    procedure dsCheckNotInOnFilterRecord;

    procedure dsSetFilterData(aType : TnxFilterType;
                        const aText : string;
                              aOpts : TFilterOptions);
    procedure dsSetFilterTimeout(aTimeout : TnxWord32);

    function dsGetSimpleExpressionFilterClass : TnxSimpleExpressionFilterDescriptorClass; virtual;
    function dsGetSqlFilterClass : TnxSqlFilterDescriptorClass; virtual;

    { lookup support. }
    procedure dsDestroyLookupCursor; virtual;

    function dsLocateRecord(const aKeyFields  : string;
                            const aKeyValues  : Variant;
                                  aOptions    : TLocateOptions;
                                  aSyncCursor : Boolean)
                                              : Boolean; virtual;
    function dsCreateLookupFilter(aFields   : TnxFieldList;
                            const aValues   : Variant;
                                  aOptions  : TLocateOptions)
                                            : TnxBaseFilterDescriptor;
    { field managment. }
    function dsGetFieldDefClass: TFieldDefClass; virtual;
    procedure dsFieldDefCreated(aFieldDef        : TFieldDef;
                                aFieldDescriptor : TnxFieldDescriptor); virtual;

    { blobs. }
    procedure dsCheckOpenBlobStreams(aCanDisableStream: Boolean = False);

    function dsGetRecID(aBuffer : Pointer)
                                : TnxRecID;

    function dsGetBlobNr(aBuffer : Pointer;
                         aField  : TField;
                     out aIsNull : Boolean;
                     out aBlobNr : TnxBlobNr;
                     out aRecID  : TnxRecID)
                                 : TnxResult;
    function dsForceBlobNr(aBuffer : Pointer;
                           aField  : TField;
                       out aBlobNr : TnxBlobNr;
                       out aRecID  : TnxRecID)
                                   : TnxResult;
    procedure dsSetBlobNr(aBuffer : Pointer;
                          aField  : TField;
                          aBlobNr : TnxBlobNr);
    function dsTruncateBlob(aBuffer : Pointer;
                            aField  : TField;
                            aLength : Integer)
                                    : TnxResult;
    function dsFreeBlob(aBuffer : Pointer;
                        aField  : TField)
                                : TnxResult;

    function dsBlockModeBlobStreamClass: TnxBlockModeBlobStreamClass; virtual;
    function dsBatchAppendBlobStreamClass: TnxBatchAppendBlobStreamClass; virtual;
    function dsBlobStreamClass: TnxBlobStreamClass; virtual;
    function dsMemoBlobStreamClass: TnxMemoBlobStreamClass; virtual;

    { navigation. }
    function dsGetRecord(aLock   : TnxLockType;
                         aBuffer : Pointer)
                                 : TnxResult; virtual;
    function dsGetNextOrPriorRecord(aPrior  : Boolean;
                                    aLock   : TnxLockType;
                                    aBuffer : Pointer)
                                            : TnxResult; virtual;

    { locking. }
    procedure dsSetTableLock(aLockType: TnxLockType; aLock: Boolean); virtual;

    {-- *** --}
    function dsApplyMasterRange(aFollowedByFirst: Boolean): Boolean; virtual;

    { misc. }
    procedure dsRefreshTimeout; virtual;
    procedure dsResolveDatabase;
    procedure dsCheckOperation(aOperation  : TDataOperation;
                               aErrorEvent : TDataSetErrorEvent);
    function dsGetBuffer(Index: Integer): TRecBuf;
    procedure dsMoveBuffer(CurIndex, NewIndex: Integer);

    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;

    { transaction context }
    procedure dsTransContextChanged;

    { This is the transaction context the dataset is linked to. Can be nil,
      in which case the Database implicitly supplies the transaction context. }
    property TransContext: TnxTransContext
      read dsGetTransContext
      write dsSetTransContext;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { see TDataSet.AfterConstruction }
    procedure AfterConstruction; override;

    {== virtual TDataSet methods ==}
    {-- navigation --}
    procedure Post; override;
    procedure PostAndEdit; virtual;

    { see TDataSet.MoveBy. }
    function MoveBy(Distance: Integer): Integer; {$IFDEF DCC14OrLater}override;{$ENDIF}
    { see TDataSet.Resync. }
    procedure Resync(Mode: TResyncMode); override;

    { see TDataSet.First. }
    procedure First;

    {-- locate/lookup --}

    { see TDataSet.Locate }
    function Locate(const aKeyFields : string;
                    const aKeyValues : Variant;
                          aOptions   : TLocateOptions) : Boolean; override;
    { see TDataSet.Lookup }
    function Lookup(const aKeyFields    : string;
                    const aKeyValues    : Variant;
                    const aResultFields : string) : Variant; override;

    { These options are used when Lookup is being called, either explicitly
      or implicitly by the use of lookup fields in other datasets connected
      to this dataset. }
    property LookupOptions : TLocateOptions
      read dsLookupOptions
      write dsLookupOptions
      default [];

    {-- bookmarks --}

    { see TDataSet.BookmarkValid }
    function BookmarkValid(aBookmark : TBookmark) : Boolean; override;
    { see TDataSet.CompareBookmarks }
    function CompareBookmarks(aBookmark1 : TBookmark;
                              aBookmark2 : TBookmark)
                                         : Integer; override;
    { see TDataSet.GetBookmark }
    function GetBookmark: TBookmark; override;
    function GetBookmarkTemplate: {$IFDEF Unicode}TBookmark{$ELSE}TBookmarkStr{$ENDIF}; virtual;

    { Returns a key for the current record. }
    function KeyAsVariant: Variant; virtual;

    {-- blobs --}

    { This function creates the right type of blob stream based on the
      state of the dataset.

      The blob stream should be freed again as soon as possible. It must be freed
      before calling Post or moving to another record.

      See Also
      TDataSet.CreateBlobStream
      TnxBaseBlobStream
      TnxBlobStream
      TnxBlockModeBlobStream
      TnxBatchAppendBlobStream                                           }
    function CreateBlobStream(aField : TField;
                              aMode  : TBlobStreamMode) : TStream; override;

    {-- record access --}

    { see TDataSet.GetCurrentRecord }
    function GetCurrentRecord(aBuffer : TnxRecordBuffer) : Boolean; override;

    {-- field access --}

    { see TDataSet.GetFieldData }
{$IFDEF DCC17OrLater}
    function GetFieldData(       aField  : TField;
  {$IFDEF XE4OrLater}var{$ENDIF} aBuffer : TValueBuffer)
                                         : Boolean; overload; override;
{$ENDIF}
    function GetFieldData(aField  : TField;
                          aBuffer : Pointer): Boolean; override;

    {-- misc --}

    { see TDataSet.IsSequenced }
    function IsSequenced : Boolean; override;

    {-- IProviderSupport --}

    { see TDataset.PSReset }
    procedure PSReset; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSEndTransaction }
    procedure PSEndTransaction(Commit: Boolean); {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSInTransaction }
    function PSInTransaction: Boolean; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSStartTransaction }
    procedure PSStartTransaction; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSExecuteStatement }
    function PSExecuteStatement(const aSQL: string; aParams: TParams): Integer; overload; {$IFDEF DCC17OrLater}override;{$ENDIF}
    function PSExecuteStatement(const aSQL: string; aParams: TParams; var ResultSet: TDataSet): Integer; overload; {$IFDEF DCC17OrLater}override;{$ENDIF}
    function PSExecuteStatement(const aSQL: string; aParams: TParams; ResultSet: Pointer = nil): Integer; overload; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSGetQuoteChar }
    function PSGetQuoteChar: string; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSIsSQLSupported }
    function PSIsSQLSupported: Boolean; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSIsSQLBased }
    function PSIsSQLBased: Boolean; {$IFNDEF FPC}override;{$ENDIF}
    { see TDataset.PSGetUpdateException }
    function PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError; {$IFNDEF FPC}override;{$ENDIF}

    function IsCursorActive : Boolean; //..

    {== additional methods ==}
    {-- *** --}

    { GotoCurrent synchronizes a dataset with the given one or in
      \other words positions the dataset on the same record as
      aDataSet. This method will result in an error if that record
      is currently not visible (range/filter) or if aDataSet is not
      positioned on a valid record

      Parameters
      aDataset :  the dataset the current one is synchronized with  }
    procedure GotoCurrent(aDataSet : TnxDataset); virtual;
    function GotoCurrentEx(aDataSet : TnxDataset): TnxResult; virtual;
    { This method starts an asynchronous RecordCount. Very useful if there's
      for example a filter applied and the serves needs to iterate through
      all records to find out the count. Use TaskInfo.GetStatus to
      find out the status of the operation.
      Parameters:
        aTaskInfo: Task information instance; use TaskInfo.GetStatus to find out
          the status of the operation.
      See Also: TnxAbstractTaskInfo, GetStatus
    }
    procedure RecordCountAsync(out aTaskInfo : TnxAbstractTaskInfo);
    { Exists returns true if this table exists, in the given session/database context.
      <p>It can be called without opening the table. }
    function Exists : Boolean; virtual;

    {-- autoinc --}

    { GetAutoincValue gets the last used value of the AutoInc
      field of this dataset.

      this function works even if there is no autoinc field
      declared in the table, because Nexus always tracks a "highest
      autoinc" value in the header.

      Parameters
      aValue :  holds the highest AutoInc value after the method
                \returns
      See Also
      SetAutoIncValue                                               }
    procedure GetAutoIncValue(out aValue: TnxWord32; aAllowCached: Boolean = False); overload;
    function GetAutoIncValue(aAllowCached: Boolean = False): TnxWord32; overload; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}

    { Use this method to set the AutoInc field's value; be very careful with
      this because it might break referential integrity based on these values
      and also might lead to posting errors due to unique field violations.
      Parameters:
        aValue: the value you want to the AutoInc value to
      See Also: GetAutoIncValue
    }
    procedure SetAutoIncValue(aValue: TnxWord32);

    {-- table locks --}

    { LockTable locks the dataset for the given operation. Make
      sure to keep these locks as short as possible, because it
      might otherwise interfere with the functionality/access of
      \other instances to the table.

      These locks interact directly with record locks, e.g. you
      can't acquire a table lock while anyone else has a record
      lock.

      Parameters
      aLockType :  the type of lock you want to acquire
      See Also
      UnlockTable, UnlockTableAll                                }
    procedure LockTable(aLockType: TnxLockType);
    { Remove the given lock from the dataset with this method.
      Parameters:
        aLockType: the type of lock you want to release
      See Also: LockTable, UnlockTableAll
    }
    procedure UnlockTable(aLockType: TnxLockType);
    { UnlockTableAll releases <B>all</B> cursor based locks of this
      dataset, but this does <B>not</B> include record locks.

      See Also
      LockTable, UnlockTable                                        }
    procedure UnlockTableAll;

    { Returns the state of a lock of the certain type is active on the current table }
    function IsTableLocked(aLockType : TnxLockType): TnxLockPresent;

    { Returns the current Record's lock status. }
    function IsRecordLocked: TnxLockPresent;

    {-- blob access --}

    { AddFileBlob adds a blob linked to <B>real</B> file. Please
      keep in mind that the file and it's name are server based and
      that NexusDB is not responsible for this file.

      Parameters
      aField :     the blob field you want the file associated
                   with
      aFileName :  the file name                                    }
    procedure AddFileBlob(aField    : TField;
                    const aFileName : string);
    { AddFileBlob adds a blob linked to <B>real</B> file. Please
      keep in mind that the file and it's name are server based and
      that NexusDB is not responsible for this file.

      Parameters
      aField :     the blob field you want the file associated
                   with
      aFileName :  the file name                                    }
    function AddFileBlobEx(aField    : TField;
                     const aFileName : string)
                                     : TnxResult;

    function ReadBlobIntoStreamEx(aField    : TField;
                                  aStream   : TStream;
                                  aSnapshot : Boolean = True;
                                  aReadOrg  : Boolean = False)
                                            : TnxResult;
    procedure ReadBlobIntoStream(aField    : TField;
                                 aStream   : TStream;
                                 aSnapshot : Boolean = True;
                                 aReadOrg  : Boolean = False);
    function ReadBlobAsStream(aField    : TField;
                              aSnapshot : Boolean = True;
                              aReadOrg  : Boolean = False)
                                        : TStream;

    {-- record manipulation --}

    { The method copies all visible records from the source dataset
      to the current table.

      It correctly uses the ranges/filters on the source table.

      Parameters
      aSrcTable :      the dataset the records are coming from. apply
                       filters/ranges if you want to restrict the records
      aCopyBlobs :     set to true if you want to copy the blob fields too
      aMaxTransSize :  number of dirty mem blocks to copy in one
                       transaction                                         }
    procedure CopyRecords(aSrcTable     : TnxDataset;
                          aCopyBLOBs    : Boolean;
                          aMaxTransSize : Integer = 0);

    { The method copies all visible records from the source dataset
      to the current table.

      It correctly uses the ranges/filters on the source table.

      Parameters
      aSrcTable :      the dataset the records are coming from. apply
                       filters/ranges if you want to restrict the records
      aCopyBlobs :     set to true if you want to copy the blob fields too
      aMaxTransSize :  number of dirty mem blocks to copy in one
                       transaction
      aCheckValFields : Wether or not to enforce field validation checks}
    procedure CopyRecordsEx(aSrcTable       : TnxDataset;
                            aCopyBLOBs      : Boolean;
                            aMaxTransSize   : Integer = 0;
                            aCheckValFields : Boolean = True);
    { This method deletes <b>all</b> visible records of the current table.
      You can use filters/ranges to restrict the functionality to a subset
      of records. }
    procedure DeleteRecords;

    {-- batch append --}

    { Use BeginBatchAppend to start batch append mode. In this mode the only
      allowed actions are:
        setting field values, BatchPost, EndBatchAppend.
      <p>Please note that batch writing to blob fields is fully supported!
      Parameters:
        aCutoffSize: the size in bytes when a batch is send to the server.
    }
    procedure BeginBatchAppend(aCutoffSize: Integer);
    { Only call in batch append mode. It forces the dataset to post the current
      internal batch append buffer.
      Parameters:
        aCutoffSize: the size in bytes when a batch is send to the server.
      See Also: FlushBatchAppend, EndBatchAppend, BeginBatchAppend, BatchPost, InBatchAppend, CancelBatchAppend
    }
    procedure FlushBatchAppend;

    { This method terminates the batch append mode. It cancels internal
      batch append buffer WITHOUT sending it tp the server.
      See Also: FlushBatchAppend, EndBatchAppend, BeginBatchAppend, BatchPost, InBatchAppend, CancelBatchAppend
    }
    procedure CancelBatchAppend;

    { This method terminates the batch append mode. It sends the internal
      batch append buffer to the server if required.
      See Also: FlushBatchAppend, EndBatchAppend, BeginBatchAppend, BatchPost, InBatchAppend, CancelBatchAppend
    }
    procedure EndBatchAppend;
    { Only call BatchPost in batch append mode. It copies the current record
      buffer into the internal batch append buffer and posts the internal batch
      append buffer if its size is bigger than aCutoffSize defined in
      BeginBatchAppend.
      See Also: FlushBatchAppend, EndBatchAppend, BeginBatchAppend, BatchPost, InBatchAppend, CancelBatchAppend
    }
    procedure BatchPost;

    { This function returns true if a Batch Append is open.
      See Also: FlushBatchAppend, EndBatchAppend, BeginBatchAppend, BatchPost, InBatchAppend, CancelBatchAppend
    }
    function InBatchAppend: Boolean;

    {-- table streams --}

    { GetStreamList returns a list of the "table streams" saved in
      the table. A "table stream" is a delphi stream of system or
      user defined data that can be saved with a table. All tables
      contain a stream called DICT which contain the data
      dictionary.

      Parameters
      aStreams :  string list that will hold the names; must not be
                  nil
      See Also
      GetStreamList, WriteStream, ReadStream, DeleteStream          }
    procedure GetStreamList(aStreams: TStrings);
    { This method stores aStream in the table and overwrites any existing
      stream of that name.
      <p><b>NEVER EVER OVERWRITE THE DICT STREAM!</b>
      Parameters:
        aName: Name of the Stream
        aStream: the stream to write
      See Also: GetStreamList, WriteStream, ReadStream, DeleteStream
    }
    procedure WriteStream(const aName: string; aStream: TStream);
    { Use this method to read a certain stream. It raises exception if not the
      stream is not found.
      Parameters:
        aName: Name of the Stream
        aStream: the stream to read into; must not be nil
      See Also: GetStreamList, WriteStream, ReadStream, DeleteStream
    }
    procedure ReadStream(const aName: string; aStream: TStream);
    { Use this method to read a certain stream. It raises exception if not the
      stream is not found.
      Parameters:
        aName: Name of the Stream
        aStream: the stream to read into; must not be nil
      Returns:
        0 if all is ok, otherwise an error code
      See Also: GetStreamList, WriteStream, ReadStream, DeleteStream
    }
    function ReadStreamEx(const aName: string; aStream: TStream): TnxResult;
    { Use this to delete the streams.
      <p><b>NEVER EVER DELETE THE DICT STREAM!</b>
      Parameters:
        aName: Name of the stream
      See Also: GetStreamList, WriteStream, ReadStream, DeleteStream
    }
    procedure DeleteStream(const aName: string);

    { Returns the CacheInfo (if available) for the current record of the dataset.}
    function GetCacheInfo: TnxRecordCacheInfo; overload;

    { Fills in the provided CacheInfo with the CacheInfo (if available) for the
      current record of the dataset, and returns True if successful. }
    function GetCacheInfo(out aCacheInfo: TnxRecordCacheInfo): Boolean; overload;

    { Adds the given DataSet option and returns True if a changes was made. }
    function AddDataSetOption(aOption: TnxDataSetOption): Boolean;
    { Removes the given DataSet option and returns True if a changes was made. }
    function RemoveDataSetOption(aOption: TnxDataSetOption): Boolean;

    { Adds the given DataSet options and returns True if any changes were made. }
    function AddDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
    { Removes the given DataSet options and returns True if any changes were made. }
    function RemoveDataSetOptions(aOptions: TnxDataSetOptions): Boolean;

    { Returns True if the dataset has any of the given DataSet options. }
    function HasAnyDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
    { Returns True if the dataset has all of the given DataSet options. }
    function HasAllDataSetOptions(aOptions: TnxDataSetOptions): Boolean;

    { Adds the given BlockRead option and returns True if a changes was made. }
    function AddBlockReadOption(aOption: TnxRecordGetBatchExOption): Boolean;
    { Removes the given BlockRead option and returns True if a changes was made. }
    function RemoveBlockReadOption(aOption: TnxRecordGetBatchExOption): Boolean;

    { Adds the given BlockRead options and returns True if any changes were made. }
    function AddBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
    { Removes the given BlockRead options and returns True if any changes were made. }
    function RemoveBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;

    { Returns True if the BlockRead has any of the given BlockRead options. }
    function HasAnyBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
    { Returns True if the BlockRead has all of the given BlockRead options. }
    function HasAllBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;

    procedure ClearMarkedBlobs;
    procedure MarkAllBlobs;

    function RecID: TnxRecID;

    { This is a pointer to the current cursor of this dataset. }
    property AbstractCursor: TnxAbstractCursor
      read dsAbstractCursor;

    { The Dictionary holds all field and index definitions as well
      as full information on how to access and read the data file. }
    property _Dictionary: TnxDataDictionary
      read ds_Dictionary;

    { Returns the Table Descriptor of the data dictionary. }
    property TableDescriptor: TnxBaseTableDescriptor
      read dsTableDescriptor;

    { Returns the Fields Descriptor of the current table. }
    property FieldsDescriptor: TnxFieldsDescriptor
      read dsFieldsDescriptor;

    { The Filter class the dataset creates an instance of for each Filter
      evaluation set }
    property SimpleExpressionFilterClass: TnxSimpleExpressionFilterDescriptorClass
      read dsSimpleExpressionFilterClass
      write dsSimpleExpressionFilterClass;

    { the Filter class the dataset creates an instance of for each Filter
      evaluation set }
    property SqlFilterClass: TnxSqlFilterDescriptorClass
      read dsSqlFilterClass
      write dsSqlFilterClass;

    property BlobMarked[aField: TField]: Boolean
      read dsGetBlobMarked
      write dsSetBlobMarked;

    property FirstBookmark: TBookmark
      read dsFirstBookmark
      write dsSetFirstBookmark;
  published
    property Bof stored false;
    property Eof stored false;
    property BufferCount stored false;

    { Set ActiveRuntime to true if the dataset should be automatically opened
      at runtime. Take care that this needs a fully set up chain of components
      otherwise you very likely get an "could not connect to server" error
      on application startup.
      See Also: ActiveDesigntime
    }
    property ActiveRuntime: Boolean
      read dsActiveRuntime
      write dsSetActiveRuntime
      default False;

    { Set ActiveDesigntime to true if the dataset should be
      automatically opened at design time. Very handy to use in
      combination with ActiveRuntime if you need the dataset open
      at design time, but sometimes forget to close it before
      creating a shipping version.

      See Also
      ActiveRuntime                                               }
    property ActiveDesigntime: Boolean
      read dsActiveDesigntime
      write dsSetActiveDesigntime
      default False;

    { This is the session the dataset is linked to. You only need to set this
      if you want to use AliasName, otherwise (when using an explicit database
      component) it is automatically set internally. }
    property Session: TnxBaseSession
      read dsGetSession
      write dsSetSession
      stored dsIsSessionStored;

    { AliasName is a quick way to access an alias without a
      connected tnxDatabase. AliasName does <B>NOT</B> support
      direct paths!

      Please note that Session must be assigned for this to work. }
    property AliasName: string
      read dsAliasName
      write dsSetAliasName
      stored dsIsAliasNameStored;

    { This is the database the dataset is linked to. Either AliasName
      \or Database must be set.                                   }
    property Database: TnxDatabase
      read dsGetDataBase
      write dsSetDataBase
      stored dsIsDatabaseStored;

    property CurrentTransContext: TnxTransContextBase
      read dsGetCurrentTransContext;

    { The is the timeout in ms used for communication with the server. If it
      -1 the timeout is inherited from Database.
      See Also: FilterTimeout }
    property Timeout: Integer
      read dsTimeout
      write dsSetTimeout
      default -1;

    { The options of the current dataset }
    property Options: TnxDataSetOptions
      read dsOptions
      write dsSetOptions
      default [];

   { When this property is set to True, changing the Filter
     property causes the server to refresh the dataset.
     Set this property to False when you don't want the server to
     refresh the dataset. }
      property FilterResync : boolean
         read dsFilterResync
         write dsFilterResync
         default True;

   { When this property is set to True, when a FilterResync is performed,
     an implicit "First" takes place. Otherwise the Resync preserves the
     current position. }
      property FilterResyncDoesFirst : boolean
         read dsFilterResyncDoesFirst
         write dsFilterResyncDoesFirst
         default True;

    { The type of filter to use. }
    property FilterType: TnxFilterType
      read dsFilterType
      write dsSetFilterType
      default ftSimple;

    { see TDataset.Filter
      See Also: Filter, Filtered, FilterTimeout, OnServerFilterTimeout, FilterOptions,
      FilterClientBlockReadCount
    }
    property Filter;
    { see TDataset.Filtered
      See Also: Filter, Filtered, FilterTimeout, OnServerFilterTimeout, FilterOptions,
      FilterClientBlockReadCount
    }
    property Filtered;
    { see TDataset.FilterOptions
      See Also: Filter, Filtered, FilterTimeout, OnServerFilterTimeout, FilterOptions,
      FilterClientBlockReadCount
    }
    property FilterOptions;

    { This is the timeout in ms for Filter operations.

      See Also
      Filter, Filtered, FilterTimeout, OnServerFilterTimeout,
      FilterOptions, FilterClientBlockReadCount                     }
    property FilterTimeout : TnxWord32
       read dsFilterTimeOut
       write dsSetFilterTimeOut
       default nxDefaultFilterTimeout;

    { The event is triggered if the FilterTimeout time has passed
      since activating a filter. Set cancel to false to give the
      server another FilterTimeout period of time to finish the
      filtering.

      See Also
      Filter, Filtered, FilterTimeout, OnServerFilterTimeout,
      FilterOptions, FilterClientBlockReadCount                 }
    property OnServerFilterTimeout: TnxServerFilterTimeoutEvent
      read dsOnServerFilterTimeout
      write dsOnServerFilterTimeout;

    { If the DataSet is connected to a remote server engine,
      and a client side only filter is active, certain operations
      might retrieve up to this many records in a batch to minimize
      the number of messages if a large number of records don't pass
      the local filter.

      See Also
      Filter, Filtered, FilterTimeout, OnServerFilterTimeout,
      FilterOptions, OnServerFilterTimeout                        }
    property FilterClientBlockReadCount: Integer
      read dsFilterClientBlockReadCountMx
      write dsSetFilterClientBlockReadCount
      default 0;

    { Use BlockReadOptions to set how block/batch operations work.

      If gboBookmarks is true, bookmarks are received from the
      server as well as records. The Borland implementation in
      TTable doesn't support bookmarks during batch reads.

      If gboBlob is true, blobs are processed in the batch modes.  }
    property BlockReadOptions : TnxRecordGetBatchExOptions
      read dsBlockReadOptions
      write dsBlockReadOptions
      default [gboBlobs, gboBookmarks];

    { Flips the navigation order for normal navigation as well as calls
      to key lookups. }
    property FlipOrder: Boolean
      read dsFlipOrder
      write dsSetFlipOrder
      default False;

    property FlipOrderNoRefresh: Boolean
      read dsFlipOrder
      write dsSetFlipOrderNoRefresh
      stored False;

    {$IFDEF DCC17OrLater}
    property BookmarkTemplate: {$IFDEF Unicode}TBytes{$ELSE}TBookmarkStr{$ENDIF}
      read GetBookmarkTemplate;
    {$ENDIF}

    { see TDataSet.BeforeOpen }
    property BeforeOpen;
    { see TDataSet.AfterOpen }
    property AfterOpen;
    { see TDataSet.BeforeClose }
    property BeforeClose;
    { see TDataSet.AfterClose. }
    property AfterClose;
    { see TDataSet.BeforeInsert }
    property BeforeInsert;
    { see TDataSet.AfterInsert }
    property AfterInsert;
    { see TDataSet.BeforeEdit }
    property BeforeEdit;
    { see TDataSet.AfterEdit }
    property AfterEdit;
    { see TDataSet.BeforePost }
    property BeforePost;
    { see TDataSet.AfterPost }
    property AfterPost;
    { see TDataSet.BeforeCancel }
    property BeforeCancel;
    { see TDataSet.AfterCancel. }
    property AfterCancel;
    { see TDataSet.BeforeDelete }
    property BeforeDelete;
    { see TDataSet.AfterDelete }
    property AfterDelete;
    { see TDataSet.BeforeScroll }
    property BeforeScroll;
    { see TDataSet.AfterScroll }
    property AfterScroll;
    { see TDataSet.BeforeRefresh }
    property BeforeRefresh;
    { see TDataSet.AfterRefresh }
    property AfterRefresh;
    { see TDataSet.OnCalcFields }
    property OnCalcFields;
    { see TDataSet.OnDeleteError }
    property OnDeleteError;
    { see TDataSet.OnEditError }
    property OnEditError;
    { see TDataSet.OnFilterRecord }
    property OnFilterRecord;
    { see TDataSet.OnNewRecord }
    property OnNewRecord;
    { see TDataSet.OnPostError }
    property OnPostError;
    { see TDataSet.AutoCalcFields }
    property AutoCalcFields;

    property OnNoLongerBusy: TNotifyEvent
      read dsOnNoLongerBusy
      write dsOnNoLongerBusy;

    property IsBusy: Boolean
      read dsIsBusy;

    { The version information for the current dataset. }
    property Version : string
      read dsGetVersion
      write dsSetVersion
      stored False;
  end;

  { Used internally to address the different key buffers. }
  TnxKeyIndex = (
    { internal use only }
    kiLookup,
    { internal use only }
    kiRangeStart,
    { internal use only }
    kiRangeEnd,
    { internal use only }
    kiCurRangeStart,
    { internal use only. }
    kiCurRangeEnd,
    { internal use only }
    kiSave,
    { internal use only }
    kiQueuedKey
  );

  { SetKey option }
  TnxSetKeyOption = (
    { exclusive full match }
    skoExclusive,
    { partial match }
    skoPartialMatch
  );

  { Set of SetKey options. }
  TnxSetKeyOptions = set of TnxSetKeyOption;

  TnxAfterApplyBehavior = (
    aabDefault,
    aabAlwaysFirst,
    aabAlwaysKeepPosition
  );

  { Method defintion for DirectKeySetFields callback method. }
  TnxDirectKeySetFieldsMethod =
    procedure (const aValues1 : array of const;
               const aValues2 : array of const;
                     aOptions : TnxSetKeyOptions) of object;

  TnxIndexDef = class(TIndexDef)
  private
    FFilterExpression: string;
    FFilterType: TnxFilterType;
    procedure SetFilterExpression(const Value: string);
    procedure SetFilterType(const Value: TnxFilterType);
  public
    property FilterType: TnxFilterType read FFilterType write SetFilterType;
    property FilterExpression: string read FFilterExpression write SetFilterExpression;
  end;

  TnxIndexDefs = class(TIndexDefs)
  protected
    {$IFDEF DCC12OrLater}
    function GetIndexDefClass: TIndexDefClass; override;
    {$ENDIF}
  end;

  { TnxMasterDataLink //.. }

  TnxMasterDataLink = class( TMasterDataLink )
  protected

    FOnSetLinkRangeAssigned : Boolean;
    FOnApplyMasterRangeAssigned : Boolean;

    procedure RecordChanged(Field: TField); override;

   end;

  { TnxIndexDataSet adds support for indexing to TnxDataset. }
  TnxIndexDataSet = class(TnxDataset)
  protected { private index management. }
    idIndexDefs          : TnxIndexDefs;

    { current index. }
    idFieldsIndex        : Boolean;
    idDefaultIndex       : Boolean;
    idIndexName          : string;
    idIndexFieldNames    : string;
    idIndexFieldMap      : array of Integer;
    idIndexFieldMapNC    : array of Boolean;
    idIndexDirectKey     : Boolean;
    idIndexKeySize       : Integer;

    idDirectKeySetFields : TnxDirectKeySetFieldsMethod;

    { key buffers. }
    idKeyBufferSize      : Integer;
    idKeyBufferSizeRec   : Integer;
    idKeyBufferSizeKey   : Integer;
    idKeyBuffers         : array[TnxKeyIndex] of PnxDataSetKeyBuffer;
    idKeyBufferQueue     : TnxDataSetKeyBufferArray;
    idKeyBuffer          : PnxDataSetKeyBuffer;
    idKeyBufferEditQueued: PnxDataSetKeyBuffer;

    { lookup/locate. }
    idLookupFieldNames   : string;
    idLookupCaseIns      : Boolean;
    idLookupCursorID     : TnxAbstractCursor;

    { master/detail support. }
    idMasterLink : TnxMasterDataLink; //.. TMasterDataLink;

    FOnSetLinkRange : TDataSetLinkRangeEvent; //..
    FOnApplyMasterRange : TDataSetNotifyEvent; //..

    { == property access methods == }
    { FieldDefs. }
    function idFieldDefsStored : Boolean; virtual;

    { IndexDefs. }
    procedure idSetIndexDefs(Value : TIndexDefs);
    function idIndexDefsStored : Boolean; virtual;

    { IndexName. }
    function idGetIndexName : string;
    procedure idSetIndexName(const aValue : string);

    { IndexFieldNames. }
    function idGetIndexFieldNames : string;
    procedure idSetIndexFieldNames(const aValue : string);

    { IndexFieldCount. }
    function idGetIndexFieldCount: Integer;

    { IndexFields. }
    function idGetIndexField(aInx : Integer): TField;
    procedure idSetIndexField(aInx : Integer; const aValue : TField);

    { KeyExclusive. }
    function idGetKeyExclusive : Boolean;
    procedure idSetKeyExclusive(const aValue : Boolean);

    { KeyFieldCount. }
    function idGetKeyFieldCount : Integer;
    procedure idSetKeyFieldCount(const aValue : Integer);

    { KeyPartialLen. }
    function idGetKeyPartialLen : Integer;
    procedure idSetKeyPartialLen(const aValue : Integer);

    { master/detail support. }
    function idGetMasterFields : string;
    procedure idSetMasterFields(const aValue : string);

    function idGetMasterSource : TDataSource;
    procedure idSetMasterSource(const aValue : TDataSource);
    procedure idSetOnSetLinkRange( Value : TDataSetLinkRangeEvent ); //..
    procedure idSetOnApplyMasterRange( Value : TDataSetNotifyEvent ); //..

    function idGetIndexDefs: TIndexDefs;
  protected
    procedure InternalClose; override;

    { == virtual TDataSet methods == }
    { info. }
    {$IFDEF FPC}
    procedure DataEvent(aEvent: TDataEvent; aInfo: Ptrint); override;
    {$ELSE}
    procedure DataEvent(aEvent: TDataEvent; aInfo: TnxNativeInt); override;
    {$ENDIF}

    { record access/update. }
    procedure DoOnNewRecord; override;

    { master/detail support. }
    function GetDataSource: TDataSource; override;

    { field access. }
    {$IFDEF DCC17OrLater}
    procedure SetFieldData(aField : TField; aBuffer : TValueBuffer); override;
    {$ENDIF}
    procedure SetFieldData(aField : TField; aBuffer : Pointer); override;

    { index managment. }
    procedure UpdateIndexDefs; override;
    function GetIsIndexField(Field : TField): Boolean; override;

    { IProviderSupport. }
    function PSGetDefaultOrder: TIndexDef; {$IFNDEF FPC}override;{$ENDIF}
    function PSGetKeyFields: string; {$IFNDEF FPC}override;{$ENDIF}
    function PSGetIndexDefs(IndexTypes : TIndexOptions)
                                       : TIndexDefs; {$IFNDEF FPC}override;{$ENDIF}
    procedure PSSetParams(aParams: TParams); {$IFNDEF FPC}override;{$ENDIF}

    { == internal functions == init. }
    procedure dsInitBookmarkSize; override;

    function idCursorOpen(const aTableName   : string;
                          const aPassword    : UnicodeString;
                                aReadOnly    : Boolean;
                                aExclusive   : Boolean;
                                aChainedRead : Boolean)
                                             : TnxResult;

    { key buffers. }
    procedure dsInitKeyBuffers; override;
    procedure dsFreeKeyBuffers; override;

    { buffer management. }
    function dsGetActiveKeyBuffer(var aBuffer : TnxRecordBuffer): Boolean; override;
    function dsGetActiveKeyBufferForBatch(var aBuffer : TnxRecordBuffer): Boolean; override;

    { key managment. }
    procedure idCheckSetKeyMode;

    function idKeyBufferAlloc: PnxDataSetKeyBuffer; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    procedure idKeyBufferFree(var aKeyBuffer: PnxDataSetKeyBuffer); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function idInitKeyBuffer(aBuffer: PnxDataSetKeyBuffer): PnxDataSetKeyBuffer;

    procedure idSetKeyBuffer(aKeyIndex: TnxKeyIndex; aClear: Boolean);
    procedure idSetQueuedKeyBuffer(aIndex: Integer; aClear: Boolean);

    procedure idSetKeyFields(aKeyIndex : TnxKeyIndex;
                       const aValues   : array of const;
                             aOptions  : TnxSetKeyOptions); overload;
    procedure idSetKeyFields(aKeyIndex : TnxKeyIndex;
                       const aValues1  : array of const;
                       const aValues2  : array of const;
                             aOptions  : TnxSetKeyOptions); overload; virtual;

    function idGetKeyBuffer(aKeyIndex: TnxKeyIndex): PnxDataSetKeyBuffer;
    function idGetQueuedKeyBuffer(aIndex: Integer): PnxDataSetKeyBuffer;
    procedure idPostKeyBuffer(aCommit: Boolean);

    procedure idQueueKey(aKeyBuffer: PnxDataSetKeyBuffer);
    procedure idDeleteQueuedKey(aIndex: Integer);

    function idGetQueuedKeyCount: Integer;
    function idGetQueuedKeyFound: Boolean;

    { token index support }
    procedure idTokenIndexSetFields(const aValues1 : array of const;
                                    const aValues2 : array of const;
                                          aOptions : TnxSetKeyOptions);

    { ref index support }
    procedure idRefIndexSetFields(const aValues1 : array of const;
                                  const aValues2 : array of const;
                                        aOptions : TnxSetKeyOptions);

    { index managment. }
    procedure idSetIndex(const aValue       : string;
                               aFieldsIndex : Boolean);
    function idResolveIndexName(const aValue       : string;
                                      aFieldsIndex : Boolean)
                                                   : string;
    procedure idSwitchToIndex(const aIndexName: string);
    procedure idInitIndexMap;

    procedure idAddIndexDefsToIndicesDesc(aIndexDefs : TIndexDefs;
                                          aIndices   : TnxMainIndicesDescriptor);

    procedure idAddIndexDefToIndicesDesc(aIndexDef : TIndexDef;
                                         aIndices  : TnxMainIndicesDescriptor);

    { range managment. }
    function idHasActiveRangeStart: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function idHasActiveRangeEnd: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function idHasActiveRange: Boolean; {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
    function idResetCursorRange(aFollowedBySync: Boolean): Boolean; virtual;
    function idSetCursorRange(aFollowedByFirst: Boolean): Boolean; virtual;

    {-- ** --}
    function idGetRecordForKey(aCursor        : TnxAbstractCursor;
                               aFields        : Integer;
                               aPartialLength : Integer;
                               aDirectKey     : Boolean;
                               aInBuffer      : Pointer;
                               aOutBuffer     : Pointer)
                                              : TnxResult;

    procedure idBeforeGetRecordForKey; virtual;
    procedure idAfterGetRecordForKey; virtual;
    { locate/lookup support. }
    procedure dsDestroyLookupCursor; override;

    function dsLocateRecord(const aKeyFields  : string;
                            const aKeyValues  : Variant;
                                  aOptions    : TLocateOptions;
                                  aSyncCursor : Boolean)
                                              : Boolean; override;
    function dsLocateOrdinalPartialMatchRecord(Buffer       : TnxRecordBuffer;
                                               aFields      : TnxFieldList;
                                               LookupCursor : TnxAbstractCursor;
                                         const aKeyValues   : Variant)
                                                            : TnxResult;
    function idMapsToIndex(aFields          : TnxFieldList;
                           aCaseInsensitive : Boolean)
                                            : Boolean;
    function idGetLookupCursor(const aFieldNames      : string;
                                     aFields          : TnxFieldList;
                                     aCaseInsensitive : Boolean)
                                                      : TnxAbstractCursor;

    { master/detail support. }
    function dsApplyMasterRange(aFollowedByFirst: Boolean): Boolean; override;
    procedure idMasterChanged(Sender : TObject);
    procedure idMasterDisabled(Sender : TObject);
    procedure idSetLinkRange(aMasterFields : TnxFieldList);
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    {== virtual TDataSet methods ==}
    {-- record naviagtion/modification --}

    { see TDataSet.Post. }
    procedure Post; override;
    { see TDataSet.Cancel. }
    procedure Cancel; override;

    {== additional methods ==}
    {-- index managment --}

    { see TTable.GetIndexNames. }
    procedure GetIndexNames(aList : TStrings);

    {-- find record by key --}

    { see TTable.FindKey. }
    function FindKey(const aKeyValues : array of const) : Boolean; overload;
    { see TTable.FindKey. }
    function FindKey(const aKeyValues : array of const;
                           aOptions   : TnxSetKeyOptions)
                                      : Boolean; overload;
    { see TTable.FindNearest. }
    procedure FindNearest(const aKeyValues : array of const); overload;
    { see TTable.FindNearest. }
    procedure FindNearest(const aKeyValues : array of const;
                                aOptions   : TnxSetKeyOptions); overload;

    { see TTable.FindNearest. }
    procedure SetKey;
    { see TTable.EditKey. }
    procedure EditKey;

    { see TTable.GotoKey. }
    function GotoKey : Boolean;
    { see TTable.GotoNearest }
    procedure GotoNearest;
    { see TTable.GotoNearest }
    procedure GotoNearestBackward;

    function QueueKey: Boolean; overload;
    function QueueKey(const aKeyValues : array of const) : Boolean; overload;
    { see TTable.FindKey. }
    function QueueKey(const aKeyValues : array of const;
                            aOptions   : TnxSetKeyOptions)
                                       : Boolean; overload;

    procedure ClearQueuedKeys;
    procedure DeleteQueuedKey(aIndex: Integer);
    procedure SetQueuedKey(aIndex: Integer);
    procedure EditQueuedKey(aIndex: Integer);

    function GotoQueuedKeys(aBlockReadSize : Integer = High(Integer)): Boolean;

    {-- range management --}

    { Sets a normal simple Range (as opposed to SetRangeShared). }
    function SetRangeSimple(const aValue : array of const; aOptions: TnxSetKeyOptions = []; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;
    { ??? }
    function SetRangeShared(const aSharedValue, aStartValues, aEndValues : array of const; aOptions: TnxSetKeyOptions = []; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;
    { ??? }
    function SetRangeShared(const aSharedValue, aStartValues, aEndValues : array of const; aStartOptions, aEndOptions: TnxSetKeyOptions; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;

    { see TTable.SetRange. }
    function SetRange(const aStartValues, aEndValues : array of const; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;
    { see TTable.SetRange. }
    function SetRange(const aStartValues, aEndValues : array of const; aOptions: TnxSetKeyOptions; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;
    { see TTable.SetRange. }
    function SetRange(const aStartValues, aEndValues : array of const; aStartOptions, aEndOptions: TnxSetKeyOptions; aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean; overload;

    { see TTable.SetRangeStart. }
    procedure SetRangeStart;
    { see TTable.EditRangeStart. }
    procedure EditRangeStart;
    { see TTable.SetRangeEnd. }
    procedure SetRangeEnd;
    { see TTable.EditRangeEnd. }
    procedure EditRangeEnd;

    { see TTable.ApplyRange. }
    function ApplyRange(aAfterApply: TnxAfterApplyBehavior = aabDefault): Boolean;
    { see TTable.CancelRange. }
    procedure CancelRange(aGoFirst: Boolean = False);

    function HasActiveRangeStart: Boolean;
    function HasActiveRangeEnd: Boolean;
    function HasActiveRange: Boolean;

    { additional properties. }
    property FieldDefs
      stored idFieldDefsStored;

    property IndexDefs : TIndexDefs
      read idGetIndexDefs
      write idSetIndexDefs
      stored idIndexDefsStored;

    property IndexFieldNames : string
      read idGetIndexFieldNames
      write idSetIndexFieldNames;

    property IndexName : string
      read idGetIndexName
      write idSetIndexName;

    property ActiveIndexName : string
      read idIndexName;

    property IndexFields[aIndex: Integer]: TField
      read idGetIndexField
      write idSetIndexField;

    property IndexFieldCount : Integer
      read idGetIndexFieldCount;

    property KeyExclusive : Boolean
      read idGetKeyExclusive
      write idSetKeyExclusive;

    property KeyFieldCount : Integer
      read idGetKeyFieldCount
      write idSetKeyFieldCount;

    property KeyPartialLen : Integer
      read idGetKeyPartialLen
      write idSetKeyPartialLen;

    property QueuedKeyCount: Integer
      read idGetQueuedKeyCount;
    property QueuedKeyFound: Boolean
      read idGetQueuedKeyFound;

    { see TTable.MasterFields }
    property MasterFields : string
      read idGetMasterFields
      write idSetMasterFields;

    { see TTable.MasterSource }
    property MasterSource : TDataSource
      read idGetMasterSource
      write idSetMasterSource;

    property OnSetLinkRange : TDataSetLinkRangeEvent //..
      read FOnSetLinkRange
      write idSetOnSetLinkRange;

    property OnApplyMasterRange : TDataSetNotifyEvent  //..
      read FOnApplyMasterRange
      write idSetOnApplyMasterRange;
  end;

  { Method defintion for CreateTable callback event. }
  TnxCreateTableEvent = procedure(aSender     : TnxDataSet;
                                  aDictionary : TnxDataDictionary) of object;

  { TnxTable is a TTable compatible implementation of a NexusDB
    dataset.                                                    }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxTable = class(TnxIndexDataSet)
  protected {private}
    tbTableName     : string;
    tbPassword      : UnicodeString;
    tbStoreDefs     : Boolean;

    { mode. }
    tbReadOnly      : Boolean;
    tbExclusive     : Boolean;

    tbOnCreateTable : TnxCreateTableEvent;

    { == property access methods == StoreDefs. }
    function idFieldDefsStored : Boolean; override;
    function idIndexDefsStored : Boolean; override;

    procedure tbSetTableName(const Value: string); virtual;
    procedure tbSetPassword(const Value: UnicodeString); virtual;

    { mode. }
    procedure tbSetReadOnly(const Value: Boolean);
    procedure tbSetExclusive(const Value: Boolean);

    procedure tbSetWriteOnly(const Value: Boolean);
  protected
    {== virtual TDataSet methods ==}
    {-- info --}
    function GetCanModify : Boolean; override;

    { IProviderSupport. }
    function PSGetTableName: string; {$IFNDEF FPC}override;{$ENDIF}
    procedure PSSetCommandText(const CommandText: string); {$IFNDEF FPC}override;{$ENDIF}

    { == internal functions == open/close. }
    procedure dsOpenCursorID; override;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    {== additional methods ==}
    {-- table management --}

    { see TTable.CreateTable }
    procedure CreateTable(aTableScope : TnxTableScope = tsPersistent;
                          aNoIndices  : Boolean = False);
    { CreateTableEx is the same as CreateTable, but with the possibility
      to set the BlockSize for the new table.
      Parameters:
        aBlockSize: block size for the newly created table
    }
    procedure CreateTableEx(aBlockSize  : TnxBlockSize;
                            aTableScope : TnxTableScope = tsPersistent;
                            aNoIndices  : Boolean = False);

    { see TTable.DeleteTable }
    procedure DeleteTable;
    { see TTable.EmptyTable }
    procedure EmptyTable;
    { see TTable.RenameTable }
    procedure RenameTable(const aNewTableName: string);

    { See tnxDatabase.PackTable
      See Also: TnxBaseSession.PackTable }
    function PackTable : TnxAbstractTaskInfo;
    { See tnxDatabase.PackTable
      See Also: TnxBaseSession.PackTable }
    function PackTableEx(out aTaskInfo : TnxAbstractTaskInfo)
                                       : TnxResult;
    { See tnxDatabase.ReIndexTable
      See Also: TnxDatabase.ReIndexTable }
    function ReIndexTable(aIndexNum  : Integer)
                                     : TnxAbstractTaskInfo; overload;
    { See tnxDatabase.ReIndexTable
      See Also: TnxDatabase.ReIndexTable }
    function ReIndexTableEx(aIndexNum  : Integer;
                        out aTaskInfo  : TnxAbstractTaskInfo)
                                       : TnxResult; overload;
    { See tnxDatabase.ReIndexTable
      See Also: TnxDatabase.ReIndexTable }
    function ReIndexTable(const aIndexName : string)
                                           : TnxAbstractTaskInfo; overload;
    { See tnxDatabase.ReIndexTable
      See Also: TnxDatabase.ReIndexTable }
    function ReIndexTableEx(const aIndexName : string;
                              out aTaskInfo  : TnxAbstractTaskInfo)
                                             : TnxResult; overload;
    { See tnxDatabase.RestructureTable
      See Also: TnxDatabase.RestructureTable }
    function RestructureTable(aDictionary  : TnxDataDictionary;
                              aMapperDesc  : TnxBaseTableMapperDescriptor)
                                           : TnxAbstractTaskInfo;
    { See tnxDatabase.RestructureTable
      See Also: TnxDatabase.RestructureTable }
    function RestructureTableEx(aDictionary  : TnxDataDictionary;
                                aMapperDesc  : TnxBaseTableMapperDescriptor;
                            out aTaskInfo    : TnxAbstractTaskInfo)
                                             : TnxResult;

    {-- index management --}

    { see TTable.AddIndex
      See Also: AddIndex, AddIndexEx, DeleteIndex
    }
    procedure AddIndex(const aName          : string;
                       const aFields        : string;
                             aOptions       : TIndexOptions;
                       const aCaseInsFields : string = '';
                       const aDescFields    : string = '';
                             aNewPrimary    : Boolean = False);
    { With AddIndexEx you can use a complete index descriptor
      instead of just field names to define the index. This gives
      you much more control over the type of index created. The
      index creation will be executed asynchronously.

      Parameters
      aIndexDesc :  a full index descriptor for the new index
      aTaskInfo :   Task information instance; use TaskInfo.GetStatus to
                    find out the status of the operation.
      See Also
      AddIndex, AddIndexEx, DeleteIndex, TnxAbstractTaskInfo,
      GetStatus                                                          }
    function AddIndexEx(aIndexDesc  : TnxIndexDescriptor;
                        aNewPrimary : Boolean;
                    out aTaskInfo   : TnxAbstractTaskInfo)
                                    : TnxResult;
    { see TTable.DeleteIndex
      See Also: AddIndex, AddIndexEx, DeleteIndex
    }
    procedure DeleteIndex(const aIndexName : string);

    {-- misc --}

    { same as TnxDataset.Exists }
    function Exists : Boolean; override;

    { Changes the password of the table.

      Note: A change to a table password is only active after
            the table (not the cursor) has been re-opened by the server.
    }
    procedure ChangePassword(const aNewPassword: UnicodeString);

    procedure BeginClientOnlyCache;
    procedure EndClientOnlyCache;

    { see TTable.IndexFields }
    property IndexFields;
    { see TTable.IndexFieldCount. }
    property IndexFieldCount;
    { see TTable.KeyExclusive }
    property KeyExclusive;
    { see TTable.KeyFieldCount }
    property KeyFieldCount;
    { see TTable.KeyPartialLen }
    property KeyPartialLen;
  published
    { see TTable.TableName }
    property TableName: string
      read tbTableName
      write tbSetTableName;

    { The password of the current table. }
    property Password: UnicodeString
      read tbPassword
      write tbSetPassword;

    { see TTable.ReadOnly }
    property ReadOnly : Boolean
      read tbReadOnly
      write tbSetReadOnly
      default False;

    { see TTable.Exclusive }
    property Exclusive : Boolean
      read tbExclusive
      write tbSetExclusive
      default False;

    { This property can only be changed if the table is inactive. It prevents
      the table from ever trying to read records from the server. This improves
      performance for tables that are only used to insert records. }
    property WriteOnly : Boolean
      read dsWriteOnly
      write tbSetWriteOnly
      default False;

    { see TTable.StoreDefs }
    property StoreDefs: Boolean
      read tbStoreDefs
      write tbStoreDefs
      default False;

    { see TTable.FieldDefs }
    property FieldDefs;
    { see TTable.IndexDefs. }
    property IndexDefs;

    { see TTable.IndexFieldNames }
    property IndexFieldNames;
    { see TTable.IndexName }
    property IndexName;

    { see TTable.MasterFields }
    property MasterFields;

    { see TTable.MasterSource }
    property MasterSource;

    { This event is fired before the table is create by the server. }
    property OnCreateTable: TnxCreateTableEvent
      read tbOnCreateTable
      write tbOnCreateTable;

    property TransContext;
  end;

{$IFNDEF DCC10OrLater}// No need for this with Delphi10, it translates correctly the class.
(*$HPPEMIT 'namespace Nxdb'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT 'class DELPHICLASS TnxTable;'*)
(*$HPPEMIT '}'*)
{$ENDIF}

  TnxCachedDataSet = class;

  TnxBaseUpdateHandler = class;
  { Class defintion for TnxBaseUpdateHandler. }
  TnxBaseUpdateHandlerClass = class of TnxBaseUpdateHandler;


//DOM-IGNORE-BEGIN
  TnxCachedDataSetDatabaseExtender = class(TnxBaseEngineExtender)
  protected
    cdsdeDataSets: TStringList;
  public
    constructor Create(aDatabase: TnxAbstractDatabase);
    destructor Destroy; override;

    function Notify(aAction : TnxEngineAction;
                    aBefore : Boolean;
              const aArgs   : array of const)
                            : TnxResult; override;

    procedure AddDataSet(aDataSet: TnxCachedDataSet);
    procedure RemoveDataSet(aDataSet: TnxCachedDataSet);
  end;

  TnxCachedDataSetCursorExtender = class(TnxBaseEngineExtender)
  protected
    cdsceUpdateHandler: TnxBaseUpdateHandler;
  public
    constructor Create(aCursor        : TnxAbstractCursor;
                       aUpdateHandler : TnxBaseUpdateHandler);

    function Notify(aAction : TnxEngineAction;
                    aBefore : Boolean;
              const aArgs   : array of const)
                            : TnxResult; override;
  end;
//DOM-IGNORE-END

  TnxTargetDatabase = (
    tdSameAsSourceDataSet,
    tdSameAsCachedDataSet,
    tdSpecified
  );

  { Base Update object  for cached datasets. }
  TnxBaseUpdateObject = class(TnxComponent)
  protected {private}
    buoTargetDatabase: TnxTargetDatabase;

    procedure buoSetTargetDatabase(const Value: TnxTargetDatabase); virtual;
  protected
    function buoGetHandlerClass: TnxBaseUpdateHandlerClass; virtual; abstract;
  published
    property TargetDatabase: TnxTargetDatabase
      read buoTargetDatabase
      write buoSetTargetDatabase
      default tdSameAsSourceDataSet;
  end;

//DOM-IGNORE-BEGIN
  TnxBaseUpdateHandler = class(TnxDataAccessStateComponent)
  protected {private}
    buhUpdateObject  : TnxBaseUpdateObject;
    buhCachedDataSet : TnxCachedDataSet;
    buhDatabase      : TnxDatabase;
    buhFree          : Boolean;
  protected
    constructor Create(aUpdateObject  : TnxBaseUpdateObject;
                       aCachedDataSet : TnxCachedDataSet); reintroduce; virtual;

    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;

    procedure scSetState(aState : TnxState); override;

    procedure buhNotifyInsert(aCursor    : TnxAbstractCursor;
                              aNewRecord : PnxRecordBuffer); virtual; abstract;
    procedure buhNotifyModify(aCursor    : TnxAbstractCursor;
                              aNewRecord : PnxRecordBuffer;
                              aOldRecord : PnxRecordBuffer); virtual; abstract;
    procedure buhNotifyDelete(aCursor    : TnxAbstractCursor;
                              aOldRecord : PnxRecordBuffer); virtual; abstract;

  public
    procedure AfterConstruction; override;
  end;
//DOM-IGNORE-END

  { Update Object for updating a cached datasets source datasets using SQL
    Statements. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxSqlUpdateObject = class(TnxBaseUpdateObject)
  protected {private}
    suoSqlText : array[TUpdateKind] of TStrings;
    suoParams  : TParams;

    function suoGetSqlIndex(aIndex: Integer): TStrings;
    procedure suoSetSql(aUpdateKind: TUpdateKind; aValue: TStrings);
    procedure suoSetSqlIndex(aIndex: Integer; aValue: TStrings);
    function suoGetSql(aUpdateKind: TUpdateKind): TStrings;

    procedure suoReadParams(Reader : TReader);
    procedure suoWriteParams(Writer : TWriter);
    procedure suoSetParams(aParams: TParams);
  protected
    procedure DefineProperties(Filer : TFiler); override;

    function buoGetHandlerClass: TnxBaseUpdateHandlerClass; override;
  public
    { constructor }
    constructor Create(AOwner: TComponent); override;
    { destructor }
    destructor Destroy; override;

    { Gets/Sets the SQL statement for the given aUpdateKind.
      example:
        query (in TnxQuery connected via SourceDataSet):
          SELECT OrderID, CustomerID FROM Orders WHERE ShipVia = 2
        insert:
          INSERT INTO Orders (OrderID, CustomerID, ShipVia) VALUES (:OrderID, :CustomerID, :param$ShipVia)
        modify:
          UPDATE Orders SET OrderID = :OrderID; Customer = :CustomerID WHERE OrderID = :old$OrderID
        delete:
          DELETE FROM Orders WHERE OrderID = :OrderID

        and add to the Params collection a param called "ShipVia", type ftInteger, value 2
       }
    property Sql[aUpdateKind: TUpdateKind]: TStrings read suoGetSql write suoSetSql;
  published
    { SQL script used to update trecords of underlying datasets
      use :old$fieldname, :new$fieldname for specifying fieldvalues as parameters
      and param$paramname for original parameters }
    property ModifySql: TStrings index 0 read suoGetSqlIndex write suoSetSqlIndex;
    { SQL script used to insert new records to underlying datasets
      use $fieldname for specifying fieldvalues as parameters
      and param$paramname for original parameters }
    property InsertSql: TStrings index 1 read suoGetSqlIndex write suoSetSqlIndex;
    { SQL script used to delete records from underlying datasets
      use $fieldname for specifying fieldvalues as parameters
      and param$paramname for original parameters }
    property DeleteSql: TStrings index 2 read suoGetSqlIndex write suoSetSqlIndex;

    { see tQuery.Params }
    property Params : TParams
      read suoParams
      write suoSetParams
      stored False;
  end;

//DOM-IGNORE-BEGIN
  TnxSqlUpdateHandler = class(TnxBaseUpdateHandler)
  protected {private}
    suhSqlText        : array[TUpdateKind] of UnicodeString;
    suhSqlParams      : array[TUpdateKind] of TnxSqlParamList;
    suhSqlParamFields : array[TUpdateKind] of array of Integer; {+ = normal buffer, - = OldBuffer for modify}
    suhSqlParamCP     : array[TUpdateKind] of array of Word;
    suhStatements     : array[TUpdateKind] of TnxAbstractStatement;
  protected
    constructor Create(aUpdateObject  : TnxBaseUpdateObject;
                       aCachedDataSet : TnxCachedDataSet); override;

    procedure scStarting; override;
    procedure scStopping; override;

    procedure buhNotifyInsert(aCursor    : TnxAbstractCursor;
                              aNewRecord : PnxRecordBuffer); override;
    procedure buhNotifyModify(aCursor    : TnxAbstractCursor;
                              aNewRecord : PnxRecordBuffer;
                              aOldRecord : PnxRecordBuffer); override;
    procedure buhNotifyDelete(aCursor    : TnxAbstractCursor;
                              aOldRecord : PnxRecordBuffer); override;

    procedure suhExecStatement(aUpdateKind : TUpdateKind;
                               aCursor     : TnxAbstractCursor;
                               aOldRecord  : PnxRecordBuffer;
                               aNewRecord  : PnxRecordBuffer); virtual;

    function suhParseSql(const aStmt   : UnicodeString;
                           out aParams : TnxSqlParamList)
                                       : UnicodeString;
  end;
//DOM-IGNORE-END

  { Possible options for a cached dataset. }
  TnxCachedDataSetOption = (
    { copy indices from source. }
    cdsoCopyIndices,
    { Set the field visible flags. }
    cdsoSetVisibleFields
  );

  { Set of TnxCachedDataSetOption }
  TnxCachedDataSetOptions = set of TnxCachedDataSetOption;

//DOM-IGNORE-BEGIN
  TnxCachedDataSetCursor = class(TnxCursor)
  protected {private}
    crUpdateHandler     : TnxBaseUpdateHandler;

    procedure crSetUpdateHandler(const Value: TnxBaseUpdateHandler);
  protected
    procedure nxcNotification(aSender    : TnxComponent;
                              aOperation : TnxNotifyOp;
                              aParam     : Pointer); override;

    function scIsStateParent(aComponent : TnxStateComponent)
                                        : Boolean; override;
  public
    { The UpdateHandler the cursor belongs to. }
    property UpdateHandler: TnxBaseUpdateHandler
      read crUpdateHandler
      write crSetUpdateHandler;
  end;
//DOM-IGNORE-END

  { A natively caching Dataset. Attach a TnxSqlUpdateObject for allowing
    writeback to underlying datasets. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxCachedDataSet = class(TnxIndexDataSet)
  private
  protected {private}
    cdsReadOnly      : Boolean;
    cdsSourceDataSet : TnxDataSet;
    cdsBatchSize     : Integer;
    cdsOptions       : TnxCachedDataSetOptions;
    cdsUsedTableName : string;
    cdsTableName     : string;
    cdsUpdateObject  : TnxBaseUpdateObject;
    cdsUpdateHandler : TnxBaseUpdateHandler;

    cdsAddIndexDefs  : TIndexDefs;
    cdsAddFieldDefs  : TFieldDefs;

    cdsOnCreateTable : TnxCreateTableEvent;

    { == property access methods == StoreDefs. }
    procedure cdsSetReadOnly(const Value: Boolean);
    procedure cdsSetSourceDataSet(const Value: TnxDataSet);
    procedure cdsSetTableName(const Value: string);
    procedure cdsSetUpdateObject(const Value: TnxBaseUpdateObject);

    { AddIndexDefs. }
    procedure cdsSetAddIndexDefs(Value : TIndexDefs);
    function cdsAddIndexDefsStored : Boolean; virtual;

    { AddFieldDefs. }
    procedure cdsSetAddFieldDefs(Value : TFieldDefs);
    function cdsAddFieldDefsStored : Boolean; virtual;
  protected
    procedure Notification(aComponent: TComponent; aOperation: TOperation); override;

    {== virtual TDataSet methods ==}
    {-- info --}
    function GetCanModify : Boolean; override;
    procedure CreateFields; override;

    { == internal functions == open/close. }
    function dsGetCursorClass: TnxCursorClass; override;

    procedure dsOpenCursorID; override;
    procedure dsCloseCursorID; override;

    function cdsGetDatabaseExtender: TnxCachedDataSetDatabaseExtender;

    procedure cdsHandleError(aResult : TnxResult;
                       const aMsg    : string;
                             aStream : TStream); overload;
    procedure cdsHandleError(aResult : TnxResult;
                             aMsgRes : PResStringRec;
                             aStream : TStream); overload;

    procedure cdsUpdateHandlerCreated(aUpdateHandler : TnxBaseUpdateHandler);
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { see TTable.FieldDefs }
    property FieldDefs;
    { see TTable.IndexDefs. }
    property IndexDefs;

    { see TTable.IndexFields }
    property IndexFields;
    { see TTable.IndexFieldCount. }
    property IndexFieldCount;
    { see TTable.KeyExclusive }
    property KeyExclusive;
    { see TTable.KeyFieldCount }
    property KeyFieldCount;
    { see TTable.KeyPartialLen }
    property KeyPartialLen;
  published
    { see TTable.ReadOnly }
    property ReadOnly : Boolean
      read cdsReadOnly
      write cdsSetReadOnly
      default False;

    { Used to define additional indicies that should be added to the cached table }
    property AddIndexDefs : TIndexDefs
      read cdsAddIndexDefs
      write cdsSetAddIndexDefs
      stored cdsAddIndexDefsStored;

    { Used to define additional fields that should be added to the cached table }
    property AddFieldDefs : TFieldDefs
      read cdsAddFieldDefs
      write cdsSetAddFieldDefs
      stored cdsAddFieldDefsStored;

    { see TTable.IndexFieldNames }
    property IndexFieldNames;
    { see TTable.IndexName }
    property IndexName;

    { see TTable.MasterFields }
    property MasterFields;

    { see TTable.MasterSource }
    property MasterSource;

    { The dataset the data is fetched from. }
    property SourceDataSet: TnxDataSet
      read cdsSourceDataSet
      write cdsSetSourceDataSet;

    { Batch/Block size for in bytes. }
    property BatchSize: Integer
      read cdsBatchSize
      write cdsBatchSize
      default 512 * 1024;

    { Options for the cached dataset. }
    property Options: TnxCachedDataSetOptions
      read cdsOptions
      write cdsOptions;

    { Original Tablename. ??? }
    property TableName: string
      read cdsTableName
      write cdsSetTableName;

    { ??? }
    property UsedTableName: string
      read cdsUsedTableName;

    { The object responsible for updating the underlying datasets. }
    property UpdateObject: TnxBaseUpdateObject
      read cdsUpdateObject
      write cdsSetUpdateObject;

    { This event is fired before the local table is created by the server. }
    property OnCreateTable: TnxCreateTableEvent
      read cdsOnCreateTable
      write cdsOnCreateTable;
  end;

  { A memory table. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxMemTable = class(TnxIndexDataSet)
  private
  protected {private}
    mtUsedTableName : string;
    mtTableName     : string;
    mtStoreDefs     : Boolean;

    mtOnCreateTable : TnxCreateTableEvent;

    { == property access methods == StoreDefs. }
    procedure mtSetTableName(const Value: string);
  protected
    { == property access methods == StoreDefs. }
    function idFieldDefsStored : Boolean; override;
    function idIndexDefsStored : Boolean; override;

    {== virtual TDataSet methods ==}
    {-- info --}
    function GetCanModify : Boolean; override;

    { == internal functions == open/close. }
    procedure dsOpenCursorID; override;
    procedure dsCloseCursorID; override;
    function mtCreateDataDictionary: TnxDataDictionary; virtual;
  public
    { constructor. }
    constructor Create(AOwner: TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { see TTable.IndexFields }
    property IndexFields;
    { see TTable.IndexFieldCount. }
    property IndexFieldCount;
    { see TTable.KeyExclusive }
    property KeyExclusive;
    { see TTable.KeyFieldCount }
    property KeyFieldCount;
    { see TTable.KeyPartialLen }
    property KeyPartialLen;
  published
    { see TTable.IndexFieldNames }
    property IndexFieldNames;
    { see TTable.IndexName }
    property IndexName;

    { see TTable.StoreDefs }
    property StoreDefs: Boolean
      read mtStoreDefs
      write mtStoreDefs
      default False;

    { see TTable.FieldDefs }
    property FieldDefs;
    { see TTable.IndexDefs. }
    property IndexDefs;

    { see TTable.MasterFields }
    property MasterFields;

    { see TTable.MasterSource }
    property MasterSource;

    { Optional. When specified the name must be unique in the database.
      If a name is specified it is possible to access the mem table using other
      TnxTable and TnxQuery components connected to the same database under
      this name while the mem table is active. }
    property TableName: string
      read mtTableName
      write mtSetTableName;

    { Only valid while the table is active. If a TableName was specified
      UsedTableName will be equal to TableName. Otherwise it will contain
      the unique name that was created for this mem table. Other TnxTable and
      TnxQuery components connected to the same database will be able to access
      the mem table under this name while it is active. }
    property UsedTableName: string
      read mtUsedTableName;

    { This event is fired before the table is create. It allows modification of
      the data dictionary that will be used to create the table. }
    property OnCreateTable: TnxCreateTableEvent
      read mtOnCreateTable
      write mtOnCreateTable;
  end;


//DOM-IGNORE-BEGIN
  { Used internally by the query, if you set TnxStatementDataSet.DataSource.
    This object is used to manage that link.                      }
  TnxStatementDataSetDataLink = class(TDetailDataLink)
  protected {private}
    sddlStatementDataSet: TnxStatementDataSet;
  protected
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
    function GetDetailDataSet: TDataSet; override;
    procedure CheckBrowseMode; override;
  public
    { constructor. }
    constructor Create(aStatementDataSet: TnxStatementDataSet);
  end;
//DOM-IGNORE-END

  { TQuery compatible implementation of a Nexus Sql Query }
  TnxStatementDataSet = class(TnxDataset)
  protected {private}
    sdAbstractStatement : TnxAbstractStatement;

    sdDataLink          : TnxStatementDataSetDataLink;
    sdRowsAffected      : Integer;
    sdRecordsRead       : Integer;
    sdParams            : TParams;
    sdRequestLive       : Boolean;
    sdReadOnly          : Boolean;
    sdCanModify         : Boolean;
    sdExecuted          : Boolean;
    sdWasPrepared       : Boolean;
    sdLog               : TStringList;
    sdNoResultSetNeeded : Boolean;

    { property access methods. }
    function sdGetPrepared: Boolean;
    procedure sdSetPrepared(aValue : Boolean);

    function sdGetParamCount: Word;

    function sdGetDataSource: TDataSource;
    procedure sdSetDataSource(aDataSource: TDataSource);

    procedure sdSetParams(aParams: TParams);

    procedure sdSetRequestLive(aValue : Boolean);
  protected
    { == virtual TComponent methods == custom properties. }
    procedure DefineProperties(Filer : TFiler); override;

    {== virtual TDataSet methods ==}
    {-- info --}
    function GetCanModify : Boolean; override;

    {-- IProviderSupport --}
    procedure PSExecute; {$IFNDEF FPC}override;{$ENDIF}
    function PSGetParams: TParams; {$IFNDEF FPC}override;{$ENDIF}
    procedure PSSetParams(aParams: TParams); {$IFNDEF FPC}override;{$ENDIF}

    { == internal functions == }
    {-- open/close --}
    procedure dsOpenCursorID; override;
    procedure dsShutdownFromCursor; override;
    procedure dsCheckInactiveFromCursor; override;

    procedure sdExec;

    {-- misc --}
    procedure dsRefreshTimeout; override;
    function sdGetQueryInfo(out aText: UnicodeString): TnxStatementType; virtual; abstract;

    procedure sdHandleError(aResult : TnxResult;
                      const aMsg    : string;
                            aStream : TStream); overload;
    procedure sdHandleError(aResult : TnxResult;
                            aMsgRes : PResStringRec;
                            aStream : TStream); overload;

    { params. }
    procedure sdRefreshParams;
    procedure sdSetParamsFromCursor;
    procedure sdBuildParams(var aParamsList : TnxSqlParamList;
                            var aNeedsGet   : Boolean);
    procedure sdApplyParams(const aParamsList : TnxSqlParamList);

    { custom properties. }
    procedure sdReadParams(Reader : TReader);
    procedure sdWriteParams(Writer : TWriter);
  public
    { constructor. }
    constructor Create(aOwner : TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { see tQuery.Prepare }
    procedure Prepare; virtual;
    { see tQuery.UnPrepare }
    procedure Unprepare;

    { see tQuery.ParamByName }
    function ParamByName(const aName : string) : TParam;

    { Log returns a detailed analysis of the Query. You need to at least
      Prepare the Query for Log to be updated. }
    property Log: TStringList read sdLog;

    { see tQuery.Prepared }
    property Prepared : Boolean
      read sdGetPrepared
      write sdSetPrepared;

    { see tQuery.RowsAffected }
    property RowsAffected : Integer
      read sdRowsAffected;

    { RecordsRead is set after calling ExecSql and the value indicates how
      many records were read. }
    property RecordsRead: Integer
      read sdRecordsRead;

    { see tQuery.ParamCount }
    property ParamCount : Word
      read sdGetParamCount;
  published
    { see tQuery.DataSource. }
    property DataSource : TDataSource
      read sdGetDataSource
      write sdSetDataSource;

    { see tQuery.Params }
    property Params : TParams
      read sdParams
      write sdSetParams
      stored False;

    { Only supported for "SELECT * FROM tablename" type queries currently. }
    property RequestLive : boolean
      read sdRequestLive
      write sdSetRequestLive
      default False;

    { Prevents modification of a live result set. }
    property ReadOnly : Boolean
      read sdReadOnly
      write sdReadOnly
      default False;
  end;

  { This is the client side representation of a SQL query. It's very similar to
    the VCL TQuery class. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxQuery = class(TnxStatementDataSet)
  protected {private}
    quText              : UnicodeString;
    quParamCheck        : Boolean;
    quSql               : TStrings;

    { property access methods. }
    procedure quSetSql(aValue : TStrings);
  protected
    {== virtual TDataSet methods ==}
    {-- IProviderSupport --}
    function PSGetDefaultOrder: TIndexDef; {$IFNDEF FPC}override;{$ENDIF}
    function PSGetTableName: string; {$IFNDEF FPC}override;{$ENDIF}
    procedure PSSetCommandText(const aCommandText: string); {$IFNDEF FPC}override;{$ENDIF}

    {-- misc --}
    function sdGetQueryInfo(out aText: UnicodeString): TnxStatementType; override;

    procedure quSqlChanged(Sender : TObject);
    { params. }
    function quParseSql(const aStmt         : UnicodeString;
                              aCreateParams : boolean;
                              aParams       : TParams)
                                            : UnicodeString;
  public
    { constructor. }
    constructor Create(aOwner : TComponent); override;
    { destructor. }
    destructor Destroy; override;

    { see tQuery.ExecSql }
    procedure ExecSQL;

    { see tQuery.Text }
    property Text: UnicodeString
       read quText;
  published
    { see tQuery.ParamCheck }
    property ParamCheck : boolean
      read quParamCheck
      write quParamCheck
      default True;

    { see tQuery.SQL }
    property SQL : TStrings
      read quSql
      write quSetSql;
  end;

  { This class is the client side representation of a stored procedure. }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxStoredProc = class(TnxStatementDataSet)
  protected {private}
    spStoredProcName    : string;
    procedure spSetStoredProcName(const Value: string);
  protected
    {== virtual TDataSet methods ==}
    {-- IProviderSupport --}
    procedure PSSetCommandText(const aCommandText: string); {$IFNDEF FPC}override;{$ENDIF}

    {-- misc --}
    function sdGetQueryInfo(out aText: UnicodeString): TnxStatementType; override;

    {-- params --}
    procedure spCreateParams;
  public
    { see tQuery.Prepare }
    procedure Prepare; override;

    { Refreshed all Parameters. }
    procedure RefreshParam; virtual;

    { see tQuery.ExecSql }
    procedure ExecProc;
  published
    { The SQL name of the procedure. }
    property StoredProcName: string
      read spStoredProcName
      write spSetStoredProcName;
  end;

//DOM-IGNORE-BEGIN
{$UNDEF DeclareMissingIdentifiers}
{$IFDEF DCC5OrLater}
  {$DEFINE DeclareMissingIdentifiers}
{$ENDIF}

{$IFDEF DeclareMissingIdentifiers}

{$IFDEF FPC}
type
  TFieldMap = array[TFieldType] of Byte;

const
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16,
    fldBOOL, fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP,
    fldBYTES, fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB,
    fldBLOB, fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING,
    fldINT64, fldADT, fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB,
    fldUNKNOWN, fldUNKNOWN, fldUNKNOWN, fldZSTRING, fldTIMESTAMP, fldBCD,
    fldZSTRING, fldBLOB);

{$ELSE}

const
  {$IFNDEF DCC10OrLater}
  { Field Type Map. }
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16, fldBOOL,
    fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP, fldBYTES,
    fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB, fldBLOB,
    fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING, fldINT64, fldADT,
    fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB, fldUNKNOWN, fldUNKNOWN,
    fldUNKNOWN, fldZSTRING, fldTIMESTAMP, fldBCD);
  {$ELSE}
  {$IFNDEF DCC12OrLater}
  { Field Type Map. }
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16,
    fldBOOL, fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP,
    fldBYTES, fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB,
    fldBLOB, fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING,
    fldINT64, fldADT, fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB,
    fldUNKNOWN, fldUNKNOWN, fldUNKNOWN, fldZSTRING, fldTIMESTAMP, fldBCD,
    fldZSTRING, fldBLOB, fldTIMESTAMP, fldZSTRING);
  {$ELSE}
  {$IFNDEF DCC14OrLater}
  { Field Type Map. }
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16, fldBOOL, // 0..5
    fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP, fldBYTES, // 6..12
    fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB, fldBLOB, //13..19
    fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING, fldINT64, fldADT, // 20..26
    fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB, fldUNKNOWN, fldUNKNOWN, // 27..33
    fldUNKNOWN, fldZSTRING, fldDATETIME, fldBCD, // 34..37
    fldZSTRING, fldBLOB, fldDATETIME, fldINT32, // 38..41
    fldUINT32, fldINT16, fldUINT16, fldFLOAT, // 42..45
    fldUNKNOWN {ftConnection}, fldUNKNOWN {ftParams}, fldUNKNOWN {ftStream}); //46..48
  {$ELSE}
  {$IFNDEF DCC37OrLater}
  { Field Type Map. }
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16, fldBOOL, // 0..5
    fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP, fldBYTES, // 6..12
    fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB, fldBLOB, //13..19
    fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING, fldINT64, fldADT, // 20..26
    fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB, fldUNKNOWN, fldUNKNOWN, // 27..33
    fldUNKNOWN, fldZSTRING, fldDATETIME, fldBCD, // 34..37
    fldZSTRING, fldBLOB, fldDATETIME, fldINT32, // 38..41
    fldINT32, fldINT16, fldUINT16, fldFLOAT, // 42..45
    fldUNKNOWN {ftConnection}, fldUNKNOWN {ftParams}, fldUNKNOWN {ftStream}, //46..48
    fldDATETIMEOFFSET {ftTimeStampOffset}, fldUNKNOWN {ftObject}, fldSINGLE {ftSingle}); // 49..51
  {$ELSE}
  { Field Type Map. }
  FldTypeMap: TFieldMap = (
    fldUNKNOWN, fldZSTRING, fldINT16, fldINT32, fldUINT16, fldBOOL, // 0..5
    fldFLOAT, fldFLOAT, fldBCD, fldDATE, fldTIME, fldTIMESTAMP, fldBYTES, // 6..12
    fldVARBYTES, fldINT32, fldBLOB, fldBLOB, fldBLOB, fldBLOB, fldBLOB, //13..19
    fldBLOB, fldBLOB, fldCURSOR, fldZSTRING, fldZSTRING, fldINT64, fldADT, // 20..26
    fldArray, fldREF, fldTABLE, fldBLOB, fldBLOB, fldUNKNOWN, fldUNKNOWN, // 27..33
    fldUNKNOWN, fldZSTRING, fldDATETIME, fldBCD, // 34..37
    fldZSTRING, fldBLOB, fldDATETIME, fldINT32, // 38..41
    fldINT32, fldINT16, fldUINT16, fldFLOAT, // 42..45
    fldUNKNOWN {ftConnection}, fldUNKNOWN {ftParams}, fldUNKNOWN {ftStream}, //46..48
    fldDATETIMEOFFSET {ftTimeStampOffset}, fldUNKNOWN {ftObject}, fldSINGLE {ftSingle}, fldUINT64 {ftLargeUint}); // 49..52
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

{$ENDIF}

{$ENDIF}

var
  { the default Filter class. }
  nxDefaultSimpleExpressionFilterClass : TnxSimpleExpressionFilterDescriptorClass = nil;
  nxDefaultSqlFilterClass              : TnxSqlFilterDescriptorClass = nil;

const
  ParamTypeToNexusDB : array[TParamType] of TnxParamType = (
    nxptUnknown,
    nxptInput,
    nxptOutput,
    nxptInputOutput,
    nxptResult
  );

  ParamTypeFromNexusDB : array[TnxParamType] of TParamType = (
    ptUnknown,
    ptInput,
    ptOutput,
    ptInputOutput,
    ptResult
  );

  EmptySetKeyOptions : TnxSetKeyOptions = [];

var
  EmptyOpenArray : array of TVarRec;

procedure AssignValuesToParams(aParams: TParams;
                         const aValues: array of const);
procedure AssignValueToParam(aParam: TParam;
                       const aValue: TVarRec);
function ValuesFromParams(aParams : TParams)
                                  : TnxDynVariantArray;
//DOM-IGNORE-END

implementation

resourcestring
  rsGetBookmarkFlagNotSupported = 'GetBookmarkFlag is not supported in Block' +
  'Read mode';
  rsGetBookmarkIsNotSupported = 'GetBookmark is not supported in BlockRead m' +
  'ode without specifying gboBookmarks in BlockReadOptions';
  rsGetBookmarkStrIsNotSupported = 'GetBookmarkStr is not supported in BlockRead m' +
  'ode without specifying gboBookmarks in BlockReadOptions';
  rsKeyAsVariantIsNotSupported = 'KeyAsVariant is not supported in BlockRead m' +
  'ode without specifying gboBookmarks in BlockReadOptions';
  rsFilterTypeNotSupported = 'FilterType not supported';
  rsDsCreateLookupFilterNotSupported = 'dsCreateLookupFilter is not supporte' +
  'd under FPC';
  rsRecRevOrLSNRequired = 'A RecRev or LSN field is required for optimistic locking';
  rsPSGetIndexDefsNotSupported = 'PSGetIndexDefs is not supported in FPC';
  rsCreateTableExNotSupported = 'CreateTableEx is not supported in FPC witho' +
  'ut having FieldDefs specified';
  rsPSGetDefaultOrderNotSupported = 'PSGetDefaultOrder not supported in FPC';
  rsPSGetTableNameNotSupported = 'PSGetTableName is not supported in FPC';

{$IFDEF FPC}
resourcestring
  SNotEditing = 'Dataset not in edit or insert mode';
  SFieldIndexError = 'Field index out of range';
  SIndexFieldMissing = 'Cannot access index field ''%s''';
  SFieldValueError = 'Invalid value for field ''%s''';
  SNoFieldIndexes = 'No index currently active';
  SNotIndexField = 'Field ''%s'' is not indexed and cannot be modified';
  SFieldTypeMismatch = 'Type mismatch for field ''%s'', expecting: %s actual: %s';
  SRecordNotFound = 'Record not found';
{$ENDIF}

{.$i nxDebugAspect.inc}

{$IFNDEF DCC25OrLater}
function GetTickCount64: UInt64; stdcall; external kernel32 name 'GetTickCount64';
{$ENDIF}

{==============================================================================}
procedure AssignValuesToParams(aParams: TParams;
                         const aValues: array of const);
var
  i, j : Integer;
begin
  j := 0;
  for i := Low(aValues) to High(aValues) do begin
    while not (aParams[j].ParamType in [ptUnknown, ptInput, ptInputOutput]) do
      Inc(j);
    AssignValueToParam(aParams[j], aValues[i]);
    Inc(j);
  end;
end;
{------------------------------------------------------------------------------}
procedure AssignValueToParam(aParam: TParam;
                       const aValue: TVarRec);

  procedure Error;
  var
    S: string;
  begin
    s := aParam.Name;
    if s = '' then
      s := Format(rsUnnamedParam, [aParam.Index]);
    DatabaseErrorFmt(rsParamValueError, [s]);
  end;

var
  AnsiStr : AnsiString;
  ws      : UnicodeString;
begin
  with aParam, aValue do
    case VType of
      vtInteger:
        AsInteger := VInteger;
      vtBoolean:
        AsBoolean := VBoolean;
      vtChar: begin
        AnsiStr := VChar;
        AsString := string(AnsiStr);
      end;
      vtExtended:
        AsFloat := VExtended^;
      vtString: begin
        AnsiStr := VString^;
        AsString := string(AnsiStr);
      end;
      vtPointer:
        if VPointer <> nil then
          Error;
      vtPChar: begin
        AnsiStr := VPChar;
        AsString := string(AnsiStr);
      end;
      vtObject:
        if (VObject = nil) or (VObject is TPersistent) then
          Assign(TPersistent(VObject))
        else
          Error;
      vtAnsiString: begin
        AnsiStr := AnsiString(VAnsiString);
        AsString := string(AnsiStr);
      end;
      vtCurrency:
        AsCurrency := VCurrency^;
      vtVariant:
        if not VarIsClear(VVariant^) then
          Value := VVariant^
        else
          Clear;
      vtWideString: begin
        DataType := ftWideString;
        Value := WideString(VWideString);
      end;
      vtPWideChar: begin
        DataType := ftWideString;
        ws := VPWideChar;
        Value := ws;
      end;
      vtInt64: begin
        DataType := ftLargeint;
        Value := VInt64^;
      end;
      {$IFDEF DCC12OrLater}
      vtUnicodeString: begin
        DataType := ftWideString;
        Value := UnicodeString(VUnicodeString);
      end;
      {$ENDIF}
    else
      Error;
    end;
end;
{------------------------------------------------------------------------------}
function ValuesFromParams(aParams : TParams)
                                  : TnxDynVariantArray;
var
  i: Integer;
begin
  Result := nil;
  with aParams do
    for i := 0 to Pred(Count) do
      with Items[i] do
        if ParamType in [ptOutput, ptInputOutput, ptResult] then begin
          SetLength(Result, Succ(Length(Result)));
          Result[High(Result)] := Value;
        end;
end;
{==============================================================================}



{==============================================================================}
procedure AssignVarToField(aField: TField; const aVariant: Variant);
begin
  if (((TVarData(aVariant).VType = varOleStr) or (TVarData(aVariant).VType = varString)) and not
    (aField.DataType in [ftString, ftFixedChar, ftWideString]))
    and (aVariant = '') then
    aField.Clear
  else
    aField.Value := aVariant;
end;
{==============================================================================}



type
  TnxMemoryStreamHacker = class(TnxMemoryStream);

{==============================================================================}
class function TnxDataAccessStateComponent.dascExceptionClass: EnxDatabaseErrorClass;
begin
  Result := EnxDatabaseError;
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aErrorCode: TnxResult);
begin
  raise dascExceptionClass.nxcCreate(Self, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aErrorCode : TnxResult;
                                               const aAltMsg    : string);begin
  raise dascExceptionClass.nxcCreate(Self, aErrorCode, aAltMsg);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aErrorCode : TnxResult;
                                               const aAltMsg    : string;
                                               const aArgs      : array of const);begin
  raise dascExceptionClass.nxcCreate(Self, aErrorCode, aAltMsg, aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aErrorCode : TnxResult;
                                                     aAltMsgRes : PResStringRec);
begin
  raise dascExceptionClass.nxcCreate(Self, aErrorCode, LoadResString(aAltMsgRes));
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aErrorCode : TnxResult;
                                                     aAltMsgRes : PResStringRec;
                                               const aArgs      : array of const);
begin
  raise dascExceptionClass.nxcCreate(Self, aErrorCode, LoadResString(aAltMsgRes), aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aMsg: string);
begin
  raise dascExceptionClass.nxcCreate(Self, aMsg);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcCheck(const aErrorCode: TnxResult);
begin
  if aErrorCode <> DBIERR_NONE then
    raise dascExceptionClass.nxcCreate(Self, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(const aMsg: string; const aArgs: array of const);
begin
  raise dascExceptionClass.nxcCreate(Self, aMsg, aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(aMsgRes: PResStringRec);
begin
  raise dascExceptionClass.nxcCreate(Self, aMsgRes);
end;
{------------------------------------------------------------------------------}
procedure TnxDataAccessStateComponent.nxcError(aMsgRes : PResStringRec;
                                         const aArgs   : array of const);
begin
  raise dascExceptionClass.nxcCreate(Self, aMsgRes, aArgs);
end;
{==============================================================================}



{===TnxBaseSession=============================================================}
threadvar
  _nxDefaultSession : TnxBaseSession;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.AddAlias(const aName, aPath: string; aEnforce: Boolean);
begin
  nxcCheck(AddAliasEx(aName, aPath, aEnforce));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.AddAliasEx(const aName, aPath: string; aEnforce: Boolean): TnxResult;
begin
  Result := nxCheckValidAliasName(aName, False);
  if Result = DBIERR_NONE then
    if aPath = '' then
      Result := DBIERR_INVALIDPARAM
    else begin
      scCheckStarted;
      Result := bsAbstractSession.AliasAdd(aName, aPath, aEnforce);
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsCheckServerEngine;
begin
  if not Assigned(ServerEngine) then
    nxcError(DBIERR_NX_NoSessionSE);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsDoLogin(var aUserName, aPassword: UnicodeString): Boolean;
begin
  if Assigned(bsOnLogin) then
    bsOnLogin(Self, aUserName, aPassword, Result)
  else
    Result := Assigned(nxShowLoginFrm) and nxGetIsUIThread and nxShowLoginFrm(aUserName, aPassword);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetDatabase(aInx: Integer): TnxDatabase;
begin
  Result := TnxDatabase(bsDatabases[aInx]);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetDatabaseCount: Integer;
begin
  Result := bsDatabases.Count;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetDefault: Boolean;
begin
  Result := _nxDefaultSession = Self;
  if (Result <> Assigned(bsDefaultRef)) or
    (Result and (@_nxDefaultSession <> bsDefaultRef)) then
    nxcError(DBIERR_REENTERED, 'Default session has been used in another thread');
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetImplicitDatabase(const aAliasName : string;
                                                    aCreate    : Boolean)
                                                               : TnxDataBase;
var
  i: Integer;
begin
  nxcCheck(nxCheckValidAliasName(aAliasName, True));

  if bsTempDatabases.Find(aAliasName, i) then
    Result := TnxDataBase(bsTempDatabases.Objects[i])
  else if aCreate then begin
    i := bsTempDatabases.AddObject(aAliasName, nil);
    Result := TnxDatabase.Create(Self);
    bsTempDatabases.Objects[i] := Result;
    Result.Session := Self;
    Result.AliasName := aAliasName;
    Result.bdbImplicit := True;
  end else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetServerVersion: Integer;
begin
  scCheckStarted;
  Result := bsAbstractSession.ServerVersion;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetSessionNotifications: InxSessionNotifications;
var
  SessionNotifications : TnxSessionNotifications;
  Notifications        : InxSessionNotifications;
begin
  if not Assigned(bsSessionNotifications) then begin
    SessionNotifications := TnxSessionNotifications.Create(Self);
    if LockedCompareExchange(bsSessionNotifications, SessionNotifications, nil) <> nil then
      nxFreeAndNil(SessionNotifications)
    else
      if Assigned(bsAbstractSession) then
        if Supports(TObject(bsAbstractSession), InxSessionNotifications, Notifications) then
          Notifications.AddNotifier(Self);

    Result := bsSessionNotifications;
  end else
    Result := bsSessionNotifications;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetTimeout: Integer;
begin
  if bsTimeout < 0 then
    Result := nxDefaultTimeOut
  else
    Result := bsTimeout;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetTransContext(aInx: Integer): TnxTransContext;
begin
  Result := TnxTransContext(bsTransContexts[aInx]);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.bsGetTransContextCount: Integer;
begin
  Result := bsTransContexts.Count;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsRefreshTimeout;
var
  Idx : Integer;
begin
  if Assigned(bsAbstractSession) then begin
    bsAbstractSession.BeginTimeoutBatch;
    try
      bsAbstractSession.Timeout := bsGetTimeout;
      for Idx := 0 to Pred(DatabaseCount) do
        Databases[Idx].soRefreshTimeout;
      for Idx := 0 to Pred(TransContextCount) do
        TransContexts[Idx].soRefreshTimeout;
    finally
      bsAbstractSession.EndTimeoutBatch;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsSetClientLocaleAsDefault(const Value: Boolean);
begin
  scCheckInactive;
  bsClientLocaleAsDefault := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsSetDefault(const Value: Boolean);
begin
  if Default <> Value then
    if Value then begin
      if Assigned(_nxDefaultSession) then
        _nxDefaultSession.Default := False;
      _nxDefaultSession := Self;
      bsDefaultRef := @_nxDefaultSession;
    end else begin
      _nxDefaultSession := nil;
      bsDefaultRef := nil;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsSetPassword(const aValue: UnicodeString);
begin
  if bsPassword <> aValue then begin
    scCheckInactive;
    bsPassword := aValue;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsSetTimeout(aTimeout: Integer);
begin
  if bsTimeout <> aTimeout then begin
    bsTimeout := aTimeout;
    bsRefreshTimeout;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.bsSetUserName(const aValue: UnicodeString);
begin
  if bsUserName <> aValue then begin
    scCheckInactive;
    bsUserName := aValue;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.CancelProcessing;
begin
  bsAbstractSession.Failed(False);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.CloseInactiveLocalDatabases;
var
  i, j     : Integer;
  CanClose : Boolean;
begin
  scCheckStarted;
  for i := Pred(bsTempDatabases.Count) downto 0 do
    with TnxDatabase(bsTempDatabases.Objects[i]) do
      if bdbImplicit and Active then begin
        CanClose := True;
        for j := Pred(DataSetCount) downto 0 do
          if DataSets[j].Active then begin
            CanClose := False;
            break;
          end;
        if CanClose then
          Close;
      end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.CloseInactiveFolders;
var
  i, j     : Integer;
  CanClose : Boolean;
begin
  scCheckStarted;
  for i := Pred(bsTempDatabases.Count) downto 0 do
    with TnxDatabase(bsTempDatabases.Objects[i]) do
      if bdbImplicit and Active then begin
        CanClose := True;
        for j := Pred(DataSetCount) downto 0 do
          if DataSets[j].Active then begin
            CanClose := False;
            break;
          end;
        if CanClose then
          Close;
      end;
  nxcCheck(bsAbstractSession.CloseInactiveFolders);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.CloseInactiveTables;
begin
  scCheckStarted;
  nxcCheck(bsAbstractSession.CloseInactiveTables);
end;
{------------------------------------------------------------------------------}
constructor TnxBaseSession.Create(AOwner: TComponent);
begin
  bsDatabases := TnxSortedList.Create;
  bsTempDatabases := TStringList.Create;
  bsTempDatabases.Sorted := True;
  bsTempDatabases.Duplicates := dupError;
  bsTransContexts := TnxSortedList.Create;

  bsPasswordRetries := 3;
  bsBeepOnLoginError := True;
  bsTimeout := -1;

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.CreateInstance(const aClassID     : TnxGuid;
                                       const aOuter       : InxInterface;
                                       const aInterfaceID : TnxGuid;
                                         out aInterface   )
                                                          : HRESULT;
begin
  if not Assigned(bsAbstractSession) then
    Result := RPC_E_DISCONNECTED
  else
    Result := bsAbstractSession.CreateInstanceFor('<Registry>', aClassID, aOuter, aInterfaceID, aInterface);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.CreateRemoteTaskInfo(const aTaskID : TnxTaskID)
                                                           : TnxAbstractTaskInfo;
var
  RemoteTaskInfoCreator: InxRemoteTaskInfoCreator;
begin
  Result := nil;
  if Assigned(bsAbstractSession) then
    if Supports(TObject(bsAbstractSession), InxRemoteTaskInfoCreator, RemoteTaskInfoCreator) then
      Result := RemoteTaskInfoCreator.CreateRemoteTaskInfo(aTaskID);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.DefaultDatabase: TnxDatabase;
begin
  Result := bsDefaultDatabase;
end;
{------------------------------------------------------------------------------}
class function TnxBaseSession.DefaultSession: TnxBaseSession;
begin
  Result := _nxDefaultSession;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.DefaultTransContext: TnxTransContext;
begin
  Result := bsDefaultTransContext;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.DeleteAlias(const aName: string);
begin
  nxcCheck(DeleteAliasEx(aName));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.DeleteAliasEx(const aName: string): TnxResult;
begin
  Result := nxCheckValidAliasName(aName, True);
  if Result = DBIERR_NONE then begin
    scCheckStarted;
    Result := bsAbstractSession.AliasDelete(aName);
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseSession.Destroy;
begin
  if Assigned(bsDefaultRef) and (bsDefaultRef^ = Self) then
    bsDefaultRef^ := nil;
  bsDefaultRef := nil;
  inherited;
  nxFreeAndNil(bsDatabases);
  nxFreeAndNil(bsTransContexts);
  nxFreeAndNil(bsTempDatabases);
  nxFreeAndNil(bsSessionNotifications);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.Disconnected;
begin
  bsSessionNotifications.Disconnected;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.FindDatabase(const aAliasName: string): TnxDatabase;
begin
  Result := bsGetImplicitDatabase(aAliasName, False);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetAliasNames(aList: TStrings);
begin
  nxcCheck(GetAliasNamesEx(aList, True));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.GetAliasNamesEx(aList      : TStrings;
                                        aEmptyList : Boolean)
                                                   : TnxResult;
var
  List : TObjectList;
  Idx  : Integer;
begin
  if Assigned(aList) then begin
    scCheckStarted;
    List := TObjectList.Create;
    try
      aList.BeginUpdate;
      try
        if aEmptyList then
          aList.Clear;
        Result := bsAbstractSession.AliasGetList(List);
        if Result = DBIERR_NONE then
          for Idx := 0 to Pred(List.Count) do
            with TnxAliasDescriptor(List.Items[Idx]) do
              if aList.IndexOf(adAlias) < 0 then
                aList.Add(adAlias);
      finally
        aList.EndUpdate;
      end;
    finally
      List.Free;
    end;
  end else
    Result := DBIERR_INVALIDPARAM;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetAliasPath(const aName : string;
                                        out aPath : string);
begin
  nxcCheck(GetAliasPathEx(aName, aPath));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.GetAliasPathEx(const aName : string;
                                         out aPath : string)
                                                   : TnxResult;
begin
  aPath := '';
  Result := nxCheckValidAliasName(aName, True);
  if Result = DBIERR_NONE then begin
    scCheckStarted;
    Result := bsAbstractSession.AliasGetPath(aName, aPath);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetChangedTables(const aAliasName : string;
                                                aList      : TStrings);
var
  Database  : TnxDatabase;
begin
  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  aList.BeginUpdate;
  try
    aList.Clear;
    if aAliasName <> '' then begin
      Database := bsGetImplicitDatabase(aAliasName);
      if Assigned(Database) then begin
        if not Database.Active then
          Exit;
        Database.GetChangedTables(aList);
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetRegisteredClassList(const aClassListType : TnxClassListType;
                                                      aList          : TStrings);
begin
  if Assigned(aList) then begin
    aList.BeginUpdate;
    try
      aList.Clear;
      if Assigned(ServerEngine) and
         Assigned(bsAbstractSession) then
        bsAbstractSession.GetRegisteredClassList(aClassListType, aList);
    finally
      aList.EndUpdate;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetStoredProcNames(const aAliasName : string;
                                                  aList      : TStrings);
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  aList.BeginUpdate;
  try
    aList.Clear;
    if aAliasName <> '' then begin
      Database := bsGetImplicitDatabase(aAliasName);
      if Assigned(Database) then begin
        OldActive := Database.Active;
        Database.Active := True;
        try
          Database.GetStoredProcNames(aList);
        finally
          Database.Active := OldActive;
        end;
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetStoredFuncNames(const aAliasName : string;
                                                  aList      : TStrings);
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  aList.BeginUpdate;
  try
    aList.Clear;
    if aAliasName <> '' then begin
      Database := bsGetImplicitDatabase(aAliasName);
      if Assigned(Database) then begin
        OldActive := Database.Active;
        Database.Active := True;
        try
          Database.GetStoredFuncNames(aList);
        finally
          Database.Active := OldActive;
        end;
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetStoredProcParams(const aAliasName      : string;
                                             const aStoredProcName : string;
                                               out aParams         : TnxStoredProcParamList);
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  aParams := nil;

  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  nxcCheck(nxCheckValidStoredProcName(aStoredProcName, True));

  if aAliasName <> '' then begin
    Database := bsGetImplicitDatabase(aAliasName);
    if Assigned(Database) then begin
      OldActive := Database.Active;
      Database.Active := True;
      try
        Database.GetStoredProcParams(aStoredProcName, aParams);
      finally
        Database.Active := OldActive;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetStoredFuncParams(const aAliasName      : string;
                                             const aStoredFuncName : string;
                                               out aParams         : TnxStoredProcParamList);
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  aParams := nil;

  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  nxcCheck(nxCheckValidStoredProcName(aStoredFuncName, True));

  if aAliasName <> '' then begin
    Database := bsGetImplicitDatabase(aAliasName);
    if Assigned(Database) then begin
      OldActive := Database.Active;
      Database.Active := True;
      try
        Database.GetStoredFuncParams(aStoredFuncName, aParams);
      finally
        Database.Active := OldActive;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.GetTableNames(const aAliasName : string;
                                             aList      : TStrings);
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  aList.BeginUpdate;
  try
    aList.Clear;
    if aAliasName <> '' then begin
      Database := bsGetImplicitDatabase(aAliasName);
      if Assigned(Database) then begin
        OldActive := Database.Active;
        Database.Active := True;
        try
          Database.GetTableNames(aList);
        finally
          Database.Active := OldActive;
        end;
      end;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.IsAlias(const aName: string): Boolean;
var
  Path: string;
begin
  Result := (GetAliasPathEx(aName, Path) = DBIERR_NONE) and (Path <> '');
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.IsConnected: Boolean;
begin
  Result := Active;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.LoggedInAdministrator: InxLoggedInAdministrator31000;
begin
  Result := nil;
  scCheckStarted;
  Supports(LoggedInUser, InxLoggedInAdministrator31000, Result);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.LoggedInUser: InxLoggedInUser31000;
var
  Extender: InxSecurityExtender31000;
begin
  Result := nil;
  Extender := nil;
  scCheckStarted;
  bsAbstractSession.CreateInstanceFor('<Extenders>', CLSID_SecurityExtender, nil, InxSecurityExtender31000, Extender);
  if Assigned(Extender) then
    Result := Extender.LoggedInUser;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.ModifyAlias(const aName    : string;
                                     const aNewName : string;
                                     const aNewPath : string;
                                           aEnforce : Boolean = False);
begin
  nxcCheck(ModifyAliasEx(aName, aNewName, aNewPath, aEnforce));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.ModifyAliasEx(const aName    : string;
                                      const aNewName : string;
                                      const aNewPath : string;
                                            aEnforce : Boolean = False)
                                                     : TnxResult;
begin
  Result := nxCheckValidAliasName(aName, True);
  if Result = DBIERR_NONE then
    if (aNewName = '') and (aNewPath = '') then
      Result := DBIERR_INVALIDPARAM
    else begin
      scCheckStarted;
      Result := bsAbstractSession.AliasModify(aName, aNewName, aNewPath, aEnforce);
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.nxcAddDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxDatabase then
    bsDatabases.Add(aComponent)
  else if aComponent is TnxTransContext then
    bsTransContexts.Add(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.nxcRemoveDependent(aComponent: TnxComponent);
var
  i: Integer;
begin
  inherited;
  if aComponent is TnxDatabase then begin
    bsDatabases.Remove(aComponent);

    if bsDefaultDatabase = aComponent then
      bsDefaultDatabase := nil;

    with TnxDatabase(aComponent) do
      if bdbImplicit then
        with bsTempDatabases do
          if Find(bdbAliasName, i) then
            Delete(i);

  end else if aComponent is TnxTransContext then begin
    bsTransContexts.Remove(aComponent);

    if bsDefaultTransContext = aComponent then
      bsDefaultTransContext := nil;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.OpenDatabase(const aAliasName: string): TnxDatabase;
begin
  Result := bsGetImplicitDatabase(aAliasName);
  Result.Open;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.PasswordAdd(const aPassword: UnicodeString);
begin
  scCheckStarted;
  nxcCheck(bsAbstractSession.PasswordAdd(aPassword));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.PasswordAddEx(const aPassword   : UnicodeString;
                                      const aIgnoreDups : Boolean = True;
                                      const aUseRaise   : Boolean = True) : TnxResult;
begin
  scCheckStarted;
  Result := bsAbstractSession.PasswordAdd(aPassword);
  if aIgnoreDups and (Result = DBIERR_NAMENOTUNIQUE) then
    Result := DBIERR_NONE;
  if aUseRaise then
    nxcCheck(Result);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.PasswordRemove(const aPassword: UnicodeString);
begin
  scCheckStarted;
  nxcCheck(bsAbstractSession.PasswordRemove(aPassword));
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.PasswordRemoveAll;
begin
  scCheckStarted;
  nxcCheck(bsAbstractSession.PasswordRemoveAll);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.ProcessPost(aSource         : TObject;
                                     aThreadPriority : TnxThreadPriority;
                                     aMsgID          : TnxMsgID;
                                     aTimeout        : TnxWord32;
                                     aRequestData    : Pointer;
                                     aRequestDataLen : TnxWord32);
var
  SessionRequests: InxSessionRequests;
begin
  if aTimeout < 1 then
    aTimeout := bsGetTimeout;

  if Assigned(bsAbstractSession) then
    if Supports(TObject(bsAbstractSession), InxSessionRequests, SessionRequests) then
      SessionRequests.ProcessPost(aSource, aThreadPriority, aMsgID, aTimeout,
        aRequestData, aRequestDataLen);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.ProcessRequest(aSource         : TObject;
                                       aThreadPriority : TnxThreadPriority;
                                       aMsgID          : TnxMsgID;
                                       aTimeout        : TnxWord32;
                                       aRequestData    : Pointer;
                                       aRequestDataLen : TnxWord32;
                                       aReply          : PPointer;
                                       aReplyLen       : PnxWord32;
                                       aReplyType      : TnxNetMsgDataType;
                                       aCanSkipCantSkip: Boolean = False;
                                       aSequenceID     : PnxWord32 = nil)
                                                       : TnxResult;
var
  SessionRequests: InxSessionRequests;
begin
  if aTimeout < 1 then
    aTimeout := bsGetTimeout;

  Result := DBIERR_SERVERNOTFOUND;
  if Assigned(bsAbstractSession) then
    if Supports(TObject(bsAbstractSession), InxSessionRequests, SessionRequests) then
      Result := SessionRequests.ProcessRequest(aSource, aThreadPriority, aMsgID,
        aTimeout, aRequestData, aRequestDataLen, aReply, aReplyLen, aReplyType,
        aCanSkipCantSkip, aSequenceID);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.ProcessRequestDirect(aRemoteThreadPriority : TnxThreadPriority;
                                             aMsgID                : TnxMsgID;
                                             aTimeout              : TnxWord32;
                                             aRequestData          : Pointer;
                                             aRequestDataLen       : TnxWord32;
                                             aReply                : PPointer;
                                             aReplyLen             : PnxWord32;
                                             aReplyType            : TnxNetMsgDataType)
                                                                   : TnxResult;
var
  SessionRequests: InxSessionRequests;
begin
  if aTimeout < 1 then
    aTimeout := bsGetTimeout;

  Result := DBIERR_SERVERNOTFOUND;
  if Assigned(bsAbstractSession) then
    if Supports(TObject(bsAbstractSession), InxSessionRequests, SessionRequests) then
      Result := SessionRequests.ProcessRequestDirect(aRemoteThreadPriority, aMsgID,
        aTimeout, aRequestData, aRequestDataLen, aReply, aReplyLen, aReplyType);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.scInitializing;
begin
  inherited;
  bsCheckServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.scStarting;
var
  hStatus              : TnxResult;

  hUserName            : UnicodeString;
  hPassword            : UnicodeString;
  hRetryCount          : Integer;
  SessionNotifications : InxSessionNotifications;
begin
  inherited;

  Assert(not Assigned(bsAbstractSession));

  hRetryCount := 0;
  if bsUserName <> '' then
    hUserName := bsUserName
  else
    hUserName := nxclUserName;

  if bsPassword <> '' then
    hPassword := bsPassword
  else
    hPassword := nxclPassword;

  hStatus := ServerEngine.SessionOpen(bsAbstractSession, hUserName, hPassword, 'direct', bsGetTimeOut);
  try
    while (hRetryCount < bsPasswordRetries) and
          (hStatus = DBIERR_INVALIDUSRPASS) do begin
      if bsBeepOnLoginError then
        Beep;

      if not bsDoLogin(hUserName, hPassword) then
        Break
      else begin
        Inc(hRetryCount);
        hStatus := ServerEngine.SessionOpen(bsAbstractSession, hUserName, hPassword, 'direct', bsGetTimeOut);
      end;
    end;
    nxcCheck(hStatus);
  except
    nxFreeAndNil(bsAbstractSession);
    raise;
  end;
  if Assigned(bsAbstractSession) and Assigned(bsSessionNotifications) then
    if Supports(TObject(bsAbstractSession), InxSessionNotifications, SessionNotifications) then
      SessionNotifications.AddNotifier(Self);

  if bsClientLocaleAsDefault then
    bsAbstractSession.OptionSet('SQL_DEFAULT_LOCALE', IntToStr(GetThreadLocale));

  bsCurrentUserName := hUserName;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.scStopping;
begin
  bsSessionNotifications.Disconnected;

  bsCurrentUserName := '';
  inherited;
  nxFreeAndNil(bsAbstractSession);
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.TableExists(const aAliasName : string;
                                    const aTableName : string;
                                    const aPassword  : UnicodeString)
                                                     : Boolean;
var
  Database  : TnxDatabase;
  OldActive : Boolean;
begin
  Result := False;

  scCheckStarted;

  nxcCheck(nxCheckValidAliasName(aAliasName, True));
  nxcCheck(nxCheckValidTableName(aTableName, True));

  Database := bsGetImplicitDatabase(aAliasName, not (nxfClientMessageReduction in nxFeatures));
  if Assigned(Database) then begin
    OldActive := Database.Active;
    if Database.Active or not (nxfClientMessageReduction in nxFeatures) then begin
      Database.Active := True;
      try
        Result := Database.TableExists(aTableName, aPassword);
      finally
        Database.Active := OldActive;
      end;
    end else
      nxcCheck(bsAbstractSession.TableExists(aAliasName, aTableName, aPassword, Result));
  end else
    nxcCheck(bsAbstractSession.TableExists(aAliasName, aTableName, aPassword, Result));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.TableStreamRead(const aAliasName  : string;
                                        const aTableName  : string;
                                        const aPassword   : UnicodeString;
                                        const aStreamName : string)
                                                          : TStream;
begin
  scCheckStarted;
  Result := TnxMemoryStream.Create;
  try
    nxcCheck(TableStreamReadEx(aAliasName, aTableName, aPassword, aStreamName, Result));
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.TableStreamReadEx(const aAliasName  : string;
                                          const aTableName  : string;
                                          const aPassword   : UnicodeString;
                                          const aStreamName : string;
                                                aStream     : TStream)
                                                            : TnxResult;
begin
  scCheckStarted;

  Result := nxCheckValidAliasName(aAliasName, True);

  if Result = DBIERR_NONE then
    Result := nxCheckValidTableName(aTableName, True);

  if Result = DBIERR_NONE then
    Result := bsAbstractSession.
      TableStreamRead(aAliasName, aTableName, aPassword, aStreamName, aStream);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSession.TableStreamWrite(const aAliasName  : string;
                                          const aTableName  : string;
                                          const aPassword   : UnicodeString;
                                          const aStreamName : string;
                                                aStream     : TStream);
begin
  scCheckStarted;
  nxcCheck(TableStreamWriteEx(aAliasName, aTableName, aPassword, aStreamName, aStream));
end;
{------------------------------------------------------------------------------}
function TnxBaseSession.TableStreamWriteEx(const aAliasName  : string;
                                           const aTableName  : string;
                                           const aPassword   : UnicodeString;
                                           const aStreamName : string;
                                                 aStream     : TStream)
                                                             : TnxResult;
begin
  scCheckStarted;

  Result := nxCheckValidAliasName(aAliasName, True);

  if Result = DBIERR_NONE then
    Result := nxCheckValidTableName(aTableName, True);

  if Result = DBIERR_NONE then
    Result := bsAbstractSession.
      TableStreamWrite(aAliasName, aTableName, aPassword, aStreamName, aStream);
end;
{==============================================================================}



{===TnxSession=================================================================}
function TnxSession.bsGetServerEngine: TnxBaseServerEngine;
begin
  Result := sesServerEngine;
end;
{------------------------------------------------------------------------------}
destructor TnxSession.Destroy;
begin
  ServerEngine := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxSession.nxcNotification(aSender    : TnxComponent;
                                     aOperation : TnxNotifyOp;
                                     aParam     : Pointer);
begin
  inherited;
  if aSender = sesServerEngine then
    case aOperation of
      nxn_Destroy: begin
        Active := False;
        sesServerEngine := nil;
      end;
      nxn_ConnectionLost: begin
//!!!
//        if Active and ((bcClientID = AData) or (AData = 0)) then
//          bcDoConnectionLost;
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxSession.scIsStateParent(aComponent : TnxStateComponent)
                                               : Boolean;
begin
  Result := (aComponent = sesServerEngine) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxSession.sesSetServerEngine(aServerEngine: TnxBaseServerEngine);
begin
  if sesServerEngine <> aServerEngine then begin
    scCheckInactive;

    nxcRemoveDependingOn(sesServerEngine);
    sesServerEngine := aServerEngine;
    nxcAddDependingOn(sesServerEngine);
  end;
end;
{==============================================================================}



{$IFNDEF NX_BDE_REPLACEMENT_EDITION}
{===TnxPooledSession===========================================================}
procedure TnxPooledSession.AddRef;
begin
  scCheckStarted;
  psCheckThread;
  Inc(psRefCount);
end;
{------------------------------------------------------------------------------}
function TnxPooledSession.bsGetServerEngine: TnxBaseServerEngine;
begin
  if Assigned(psSessionPool) then
    Result := psSessionPool.bspGetServerEngine
  else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxPooledSession.bsGetTimeout: Integer;
begin
  if bsTimeout < 0 then
    if Assigned(psSessionPool) then
      Result := psSessionPool.bspGetTimeout
    else
      Result := nxDefaultTimeOut
  else
    Result := bsTimeout;
end;
{------------------------------------------------------------------------------}
destructor TnxPooledSession.Destroy;
begin
  SessionPool := nil;
  psCheckNotReferenced;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.nxcNotification(aSender    : TnxComponent;
                                           aOperation : TnxNotifyOp;
                                           aParam     : Pointer);
begin
  inherited;
  if aSender = psSessionPool then
    case aOperation of
      nxn_Destroy: begin
        Active := False;
        psSessionPool := nil;
      end;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.psCheckNoThread;
begin
  if psOwningThread <> 0 then
    nxcError(DBIERR_REENTERED);
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.psCheckNotReferenced;
begin
  if psRefCount <> 0 then
    nxcError(DBIERR_REENTERED, 'Pooled Session is still being referenced');
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.psCheckThread;
begin
  if psOwningThread <> GetCurrentThreadId then
    nxcError(DBIERR_REENTERED);
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.psSetSessionPool(aSessionPool : TnxBaseSessionPool);
begin
  if psSessionPool <> aSessionPool then begin
    scCheckInactive;

    nxcRemoveDependingOn(psSessionPool);
    psSessionPool := aSessionPool;
    nxcAddDependingOn(psSessionPool);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.Release;
begin
  scCheckStarted;
  psCheckThread;

  Dec(psRefCount);
  if psRefCount = 0 then begin
    Default := False;
    psOwningThread := 0;
    nxcNotifyDependents(nxn_Release);
    if not psSessionPool.bspReturn(Self) then
      Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxPooledSession.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result := (aComponent = psSessionPool) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxPooledSession.scStopping;
begin
  psCheckNotReferenced;
  inherited;
end;
{==============================================================================}



{===TnxBaseSessionPool=========================================================}
function TnxBaseSessionPool.AcquireSession: TnxPooledSession;
begin
  scCheckStarted;

  Result := bspPool.Pop;
  if Assigned(Result) then
    Result.psInPool := False
  else
    Result := bspCreateSession;

  Result.psCheckNotReferenced;
  Result.psCheckNoThread;

  Result.psOwningThread := GetCurrentThreadId;
  Result.psRefCount := 1;

  LockedInc(bspOutstandingSessions);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.bspCheckServerEngine;
begin
  if not Assigned(ServerEngine) then
    nxcError(DBIERR_NX_NoSessionSE);
end;
{------------------------------------------------------------------------------}
function TnxBaseSessionPool.bspCreateSession: TnxPooledSession;
begin
  Result := TnxPooledSession.Create(nil);
  try
    Result.SessionPool := Self;
    Result.Password := Password;
    Result.Username := UserName;
    Result.BeepOnLoginError := False;
    Result.PasswordRetries := 0;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSessionPool.bspGetTimeout: Integer;
begin
  if bspTimeout < 0 then
    Result := nxDefaultTimeOut
  else
    Result := bspTimeout;
end;
{------------------------------------------------------------------------------}
function TnxBaseSessionPool.bspReturn(aSession: TnxPooledSession): Boolean;
begin
  Result := aSession.Active;
  if Result then begin
    aSession.psCheckNotReferenced;
    aSession.psOwningThread := 0;
    if aSession.bsTimeout <> -1 then
      aSession.Timeout := -1;
    aSession.psInPool := True;
    bspPool.Push(aSession);
  end;
  LockedDec(bspOutstandingSessions);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.bspSetPassword(const aValue: UnicodeString);
begin
  scCheckInactive;
  bspPassword := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.bspSetTimeout(aTimeout: Integer);
begin
  scCheckInactive;
  bspTimeout := aTimeout;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.bspSetUserName(const aValue: UnicodeString);
begin
  scCheckInactive;
  bspUserName := aValue;
end;
{------------------------------------------------------------------------------}
constructor TnxBaseSessionPool.Create(AOwner: TComponent);
begin
  bspTimeout := -1;
  bspSessions := TnxListPortal.Create(TnxSortedList.Create);
  bspPool := TnxThreadSafeStack.Create;
  bspPool2 := TnxThreadSafeStack.Create;
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseSessionPool.Destroy;
begin
  inherited;
  nxFreeAndNil(bspSessions);
  nxFreeAndNil(bspPool);
  nxFreeAndNil(bspPool2);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.nxcAddDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxPooledSession then
    with bspSessions, BeginWrite do try
      Add(aComponent);
    finally
      EndWrite;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.nxcRemoveDependent(aComponent: TnxComponent);
var
  NewPool        : TnxThreadSafeStack;
  OldPool        : TnxThreadSafeStack;
  PoppedSession  : TnxPooledSession;
begin
  inherited;
  if aComponent is TnxPooledSession then
    with bspSessions, BeginWrite do try
      Remove(aComponent);
      if TnxPooledSession(aComponent).psInPool then begin
        PoppedSession := bspPool.Pop;
        if Assigned(PoppedSession) then begin
          if PoppedSession = aComponent then
            Exit;

          NewPool := bspPool2;
          NewPool.Push(PoppedSession);

          OldPool := bspPool;
          bspPool := NewPool;
          bspPool2 := OldPool;

          PoppedSession := OldPool.Pop;
          while Assigned(PoppedSession) do begin
            if PoppedSession <> aComponent then
              NewPool.Push(PoppedSession);
            PoppedSession := OldPool.Pop;
          end;
        end;
      end;
    finally
      EndWrite;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.ProcessPost(aSource         : TObject;
                                         aThreadPriority : TnxThreadPriority;
                                         aMsgID          : TnxMsgID;
                                         aTimeout        : TnxWord32;
                                         aRequestData    : Pointer;
                                         aRequestDataLen : TnxWord32);
begin
  with AcquireSession do try
    ProcessPost(aSource, aThreadPriority, aMsgID, aTimeout,
      aRequestData, aRequestDataLen);
  finally
    Release;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSessionPool.ProcessRequest(aSource         : TObject;
                                           aThreadPriority : TnxThreadPriority;
                                           aMsgID          : TnxMsgID;
                                           aTimeout        : TnxWord32;
                                           aRequestData    : Pointer;
                                           aRequestDataLen : TnxWord32;
                                           aReply          : PPointer;
                                           aReplyLen       : PnxWord32;
                                           aReplyType      : TnxNetMsgDataType;
                                           aCanSkipCantSkip: Boolean = False;
                                           aSequenceID     : PnxWord32 = nil)
                                                           : TnxResult;
begin
  with AcquireSession do try
    Result := ProcessRequest(aSource, aThreadPriority, aMsgID, aTimeout,
      aRequestData, aRequestDataLen, aReply, aReplyLen, aReplyType,
      aCanSkipCantSkip, aSequenceID);
  finally
    Release;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseSessionPool.ProcessRequestDirect(aRemoteThreadPriority : TnxThreadPriority;
                                                 aMsgID                : TnxMsgID;
                                                 aTimeout              : TnxWord32;
                                                 aRequestData          : Pointer;
                                                 aRequestDataLen       : TnxWord32;
                                                 aReply                : PPointer;
                                                 aReplyLen             : PnxWord32;
                                                 aReplyType            : TnxNetMsgDataType)
                                                                       : TnxResult;
begin
  with AcquireSession do try
    Result := ProcessRequestDirect(aRemoteThreadPriority, aMsgID, aTimeout,
      aRequestData, aRequestDataLen, aReply, aReplyLen, aReplyType);
  finally
    Release;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.scInitializing;
begin
  inherited;
  bspCheckServerEngine;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.scStarting;
begin
  inherited;

end;
{------------------------------------------------------------------------------}
procedure TnxBaseSessionPool.scStopping;
var
  PoppedSession: TnxPooledSession;
begin
  inherited;
  if bspOutstandingSessions <> 0 then
    nxcError(DBIERR_REENTERED);

  PoppedSession := bspPool.Pop;
  while Assigned(PoppedSession) do begin
    PoppedSession.psInPool := False;
    PoppedSession.Free;
    PoppedSession := bspPool.Pop;
  end;

  PoppedSession := bspPool2.Pop;
  while Assigned(PoppedSession) do begin
    PoppedSession.psInPool := False;
    PoppedSession.Free;
    PoppedSession := bspPool2.Pop;
  end;
end;
{==============================================================================}



{===TnxSessionPool=============================================================}
function TnxSessionPool.bspGetServerEngine: TnxBaseServerEngine;
begin
  Result := spServerEngine;
end;
{------------------------------------------------------------------------------}
destructor TnxSessionPool.Destroy;
begin
  ServerEngine := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionPool.nxcNotification(aSender    : TnxComponent;
                                     aOperation : TnxNotifyOp;
                                     aParam     : Pointer);
begin
  inherited;
  if aSender = spServerEngine then
    case aOperation of
      nxn_Destroy: begin
        Active := False;
        spServerEngine := nil;
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxSessionPool.scIsStateParent(aComponent : TnxStateComponent)
                                               : Boolean;
begin
  Result := (aComponent = spServerEngine) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxSessionPool.spSetServerEngine(aServerEngine: TnxBaseServerEngine);
begin
  if spServerEngine <> aServerEngine then begin
    scCheckInactive;

    nxcRemoveDependingOn(spServerEngine);
    spServerEngine := aServerEngine;
    nxcAddDependingOn(spServerEngine);
  end;
end;
{==============================================================================}



{===TnxThreadWithSession=======================================================}
constructor TnxThreadWithSession.Create(aThreadPriority : TThreadPriority;
                                        aSessionPool    : TnxBaseSessionPool);
begin
  twsSessionPool := aSessionPool;
  inherited Create(aThreadPriority);
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithSession.DoAfterExecute;
begin
  inherited;
  twsSession.Release;
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithSession.DoBeforeExecute;
begin
  inherited;
  try
    twsSession := twsSessionPool.AcquireSession;
    try
      twsSession.Default := True;
    except
      nxFreeAndNil(twsSession);
      raise;
    end;
  except
    inherited DoAfterExecute;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxThreadWithSession.twsGetSession: TnxBaseSession;
begin
  Result := twsSession;
end;
{==============================================================================}



{===TnxThreadWithDatabase======================================================}
constructor TnxThreadWithDatabase.Create(aThreadPriority : TThreadPriority;
                                         aSessionPool    : TnxBaseSessionPool;
                                   const aAlias          : string);
begin
  twdAlias := aAlias;
  inherited Create(aThreadPriority, aSessionPool);
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithDatabase.DoAfterExecute;
begin
  twdDatabase := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithDatabase.DoBeforeExecute;
begin
  inherited;
  try
    twdDatabase := Session.OpenDatabase(twdAlias);
    twdDatabase.Default := True;
  except
    inherited DoAfterExecute;
    raise;
  end;
end;
{==============================================================================}



{===TnxThreadWithTable======================================================}
constructor TnxThreadWithTable.Create(aThreadPriority : TThreadPriority;
                                      aSessionPool    : TnxBaseSessionPool;
                                const aAlias          : string;
                                const aTableName      : string;
                                const aIndexName      : string;
                                const aPassword       : UnicodeString);
begin
  twtTableName := aTableName;
  twtIndexName := aIndexName;
  twtPassword := aPassword;
  inherited Create(aThreadPriority, aSessionPool, aAlias);
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithTable.DoAfterExecute;
begin
  nxFreeAndNil(twtTable);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxThreadWithTable.DoBeforeExecute;
begin
  inherited;
  try
    twtTable := TnxTable.Create(nil);
    try
      twtTable.TableName := twtTableName;
      twtTable.IndexName := twtIndexName;
      twtTable.Password := twtPassword;
      twtTable.Open;
    except
      nxFreeAndNil(twtTable);
      raise;
    end;
  except
    inherited DoAfterExecute;
    raise;
  end;
end;
{==============================================================================}
{$ENDIF}



{===TnxSessionOwnedDataAccessStateComponent====================================}
procedure TnxSessionOwnedDataAccessStateComponent.AfterConstruction;
begin
  inherited;
  if not (csLoading in ComponentState) then
    soCheckDefaults;
end;
{------------------------------------------------------------------------------}
constructor TnxSessionOwnedDataAccessStateComponent.Create(aOwner: TComponent);
begin
  soTimeout := -1;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.Loaded;
begin
  inherited;
  soCheckDefaults;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.nxcNotification(aSender    : TnxComponent;
                                                                  aOperation : TnxNotifyOp;
                                                                  aParam     : Pointer);
begin
  inherited;
  if aOperation = nxn_Destroy then
    if aSender = soSession then begin
      Active := False;
      soSession := nil;
    end;
end;
{------------------------------------------------------------------------------}
function TnxSessionOwnedDataAccessStateComponent.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result :=
    (aComponent = soSession) or
    inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.soCheckDefaults;
begin
  if not Assigned(Session) then
    Session := TnxBaseSession.DefaultSession;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.soCheckSession;
begin
  if not Assigned(soSession) then
    nxcError(@rsNoOwningSession);
end;
{------------------------------------------------------------------------------}
function TnxSessionOwnedDataAccessStateComponent.soGetTimeout: Integer;
begin
  if soTimeout < 0 then
    if Assigned(soSession) then
      Result := soSession.bsGetTimeout
    else
      Result := nxDefaultTimeOut
  else
    Result := soTimeout;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.soSetSession(Value: TnxBaseSession);
begin
  if soSession <> Value then begin
    scCheckInactive;

    nxcRemoveDependingOn(soSession);
    soSession := Value;
    nxcAddDependingOn(soSession);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSessionOwnedDataAccessStateComponent.soSetTimeout(Value: Integer);
begin
  if soTimeout <> Value then begin
    soTimeout := Value;
    soRefreshTimeout;
  end;
end;

{==============================================================================}



{===TnxBaseDatabase============================================================}
procedure TnxBaseDatabase.bdbAcquireInterfaces;
begin
  if Assigned(bdbAbstractDatabase31000) then
    Exit;
  scCheckStarted;
  bdbAbstractDatabase.CreateInstanceFor('<Self>', CLSID_AbstractDatabase,
    nil, InxAbstractDatabase31000, bdbAbstractDatabase31000);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbCheckAlias;
begin
  if (bdbAliasName = '') and (bdbAliasPath = '') then
    nxcError(@rsAliasNameOrPathRequired);
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.bdbDatabaseOpen: TnxAbstractSessionDatabaseOpen;
begin
  Result := soSession.bsAbstractSession.DatabaseOpen;
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.bdbGetPath: string;
begin
  if Assigned(bdbAbstractDatabase) then
    if bdbAbstractDatabase.GetPath(Result) = DBIERR_NONE then
      Exit;

  Result := AliasPath;
  if Result = '' then
    if Assigned(Session) then
      Session.GetAliasPath(AliasName, Result)
    else
      scCheckStarted
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.bdbIsAliasNameStored: Boolean;
begin
  Result := bdbAliasName <> '';
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.bdbIsAliasPathStored: Boolean;
begin
  Result := bdbAliasPath <> '';
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetAliasName(Value: string);
begin
  Value := Trim(Value);

  if SameText(bdbAliasName, Value) then
    bdbAliasName := Value
  else begin

    if bdbImplicit then
      nxcError(@rsAliasNoChangeForImplicitDatabase);
    scCheckInactive;
    bdbAliasName := Value;
    if bdbAliasName <> '' then
      bdbAliasPath := '';
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetAliasPath(Value: string);
begin
  Value := ExcludeTrailingPathDelimiter(Trim(Value));
  if (Length(Value)=2) and (Ord(Value[1]) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z')]) and (Value[2]=':') then
    Value := Value + '\';

  if SameText(bdbAliasPath, Value) then
    {compat: this is only valid if the FS is case insensitive}
    bdbAliasPath := Value
  else begin
    if bdbImplicit then
      nxcError(@rsAliasNoChangeForImplicitDatabase);
    scCheckInactive;
    bdbAliasPath := Value;
    if bdbAliasPath <> '' then
      bdbAliasName := '';
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetExclusive(Value: Boolean);
begin
  if bdbExclusive <> Value then begin
    scCheckInactive;
    bdbExclusive := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetFailSafe(Value: Boolean);
begin
  bdbFailSafe := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetReadOnly(Value: Boolean);
begin
  if bdbReadOnly <> Value then begin
    scCheckInactive;
    bdbReadOnly := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.bdbSetTransContext(Value: TnxTransContext);
begin
  if bdbTransContext <> Value then begin
    scCheckInactive;
    nxcRemoveDependingOn(bdbTransContext);
    bdbTransContext := Value;
    nxcAddDependingOn(bdbTransContext);
    if Assigned(bdbTransContext) and Assigned(bdbTransContext.Session) then
      Session := bdbTransContext.Session;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.Exists: Boolean;
begin
  Result := Active;
  if not Result then begin
    Result := Assigned(Session);
    if Result then begin
      if AliasName <> '' then
        Result := Session.IsAlias(AliasName)
      else if AliasPath <> '' then try
        Open;
        Close;
      except
        Result := False;
      end
      else
        Result := False;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.GetFreeDiskSpace: TnxInt64;
begin
  nxcCheck(GetFreeDiskSpaceEx(Result));
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.GetFreeDiskSpaceEx(out aFreeSpace : TnxInt64)
                                                           : TnxResult;
begin
  scCheckStarted;
  Result := bdbAbstractDatabase.GetFreeSpace(aFreeSpace);
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.GetPath: string;
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.GetPath(Result));
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.nxcNotification(aSender    : TnxComponent;
                                          aOperation : TnxNotifyOp;
                                          aParam     : Pointer);
var
  WasSession : Boolean;
begin
  WasSession := aSender = soSession;
  inherited;
  case aOperation of
    nxn_Destroy:
      if WasSession then begin
        if bdbImplicit then
          Free;
      end else if aSender = bdbTransContext then begin
        Active := False;
        bdbTransContext := nil;
      end;
    nxn_Release:
      if WasSession then begin
        Close;
        if bdbImplicit then
          Free;
      end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.scInitializing;
begin
  inherited;
  soCheckSession;
  bdbCheckAlias;
end;
{------------------------------------------------------------------------------}
function TnxBaseDatabase.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result :=
    (aComponent = bdbTransContext) or
    inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.scStarting;
const
  OpenMode     : array[Boolean] of TnxOpenMode  = (omReadWrite , omReadOnly);
  ShareMode    : array[Boolean] of TnxShareMode = (smShared    , smExclusive);
var
  lTransContext : TnxAbstractTransContext;
  lAliasType    : string;
  lAlias        : string;
  lDatabaseOpen : TnxAbstractSessionDatabaseOpen;
begin
  inherited;

  if Assigned(bdbTransContext) then
    lTransContext := bdbTransContext.tcAbstractTransContext
  else
    lTransContext := nil;

  if bdbAliasName <> '' then begin
    lAliasType := nxatAliasName;
    lAlias := bdbAliasName;
  end else begin
    lAliasType := nxatAliasPath;
    lAlias := bdbAliasPath;
  end;

  lDatabaseOpen := bdbDatabaseOpen();

  nxcCheck(lDatabaseOpen(
    bdbAbstractDatabase,
    lAliasType,
    lAlias,
    lTransContext,
    OpenMode[bdbReadOnly],
    ShareMode[bdbExclusive],
    soGetTimeout
  ));
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.scStopping;
begin
  inherited;

  try
    bdbAbstractDatabase31000 := nil;
  except end;

  try
    nxFreeAndNil(bdbAbstractDatabase);
  except end;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.soCheckDefaults;
begin
  inherited;
  if Assigned(Session) then
    if not Assigned(TransContext) then
      TransContext := Session.DefaultTransContext;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseDatabase.soSetSession(Value: TnxBaseSession);
begin
  if bdbImplicit then
    Exit;
  inherited;
  if Assigned(Session) then
    if not Assigned(TransContext) or (TransContext.Session <> Session) then
      TransContext := Session.DefaultTransContext;
end;
{==============================================================================}



{===TnxCacheDatabase===========================================================}
function TnxCacheDatabase.bdbDatabaseOpen: TnxAbstractSessionDatabaseOpen;
begin
  Result := soSession.AbstractSession.DatabaseCacheOpen;
end;
{------------------------------------------------------------------------------}
procedure TnxCacheDatabase.soRefreshTimeout;
begin
  if Assigned(bdbAbstractDatabase) then
    bdbAbstractDatabase.Timeout := soGetTimeout;
end;
{==============================================================================}



{===TnxDatabase================================================================}
function TnxDatabase.AddFieldToTable(const aTableName : string;
                                     const aPassword  : UnicodeString;
                                           aFieldDesc : TnxFieldDescriptor)
                                                      : TnxResult;
begin
  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else if not Assigned(aFieldDesc) then
    Result := DBIERR_INVALIDPARAM
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableAddField(aTableName, aPassword, aFieldDesc);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.BackupTable(const aTableName : string;
                                 const aPassword  : UnicodeString;
                                       aTarget    : TnxDatabase)
                                                  : TnxAbstractTaskInfo;
begin
  nxcCheck(BackupTableEx(aTableName, aPassword, aTarget, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.BackupTableEx(const aTableName : string;
                                   const aPassword  : UnicodeString;
                                         aTarget    : TnxDatabase;
                                     out aTaskInfo  : TnxAbstractTaskInfo)
                                                    : TnxResult;
begin
  aTaskInfo := nil;

  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else if not Assigned(aTarget) then
    Result := DBIERR_INVALIDPARAM
  else if aTarget.Session <> Session then
    Result := DBIERR_NOTSAMESESSION
  else if (aTarget.AliasName = AliasName) and (aTarget.AliasPath = AliasPath) then
    Result := DBIERR_NX_SAMEFOLDER
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableBackup
      (aTableName, aPassword, aTarget.bdbAbstractDatabase, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.ChangePassword(const aTableName   : string;
                                     const aOldPassword : UnicodeString;
                                     const aNewPassword : UnicodeString);
begin
  scCheckStarted;
  nxcCheck(ChangePasswordEx(aTableName, aOldPassword, aNewPassword));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ChangePasswordEx(const aTableName   : string;
                                      const aOldPassword : UnicodeString;
                                      const aNewPassword : UnicodeString)
                                                         : TnxResult;
begin
  scCheckStarted;
  Result := bdbAbstractDatabase.
    TableChangePassword(aTableName, aOldPassword, aNewPassword);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.Commit;
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TransactionCommit);
end;
{------------------------------------------------------------------------------}
constructor TnxDatabase.Create(AOwner: TComponent);
begin
  dbDataSets := TnxSortedList.Create;
  dbTables := TnxSortedList.Create;
  dbQueries := TnxSortedList.Create;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.CreateTable(aOverWrite  : Boolean;
                            const aTableName  : string;
                            const aPassword   : UnicodeString;
                                  aDictionary : TnxDataDictionary;
                                  aTableScope : TnxTableScope);
begin
  nxcCheck(CreateTableEx(aOverWrite, aTableName, aPassword, aDictionary, aTableScope));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.CreateTableEx(aOverWrite  : Boolean;
                             const aTableName  : string;
                             const aPassword   : UnicodeString;
                                   aDictionary : TnxDataDictionary;
                                   aTableScope : TnxTableScope)
                                               : TnxResult;
begin
  if not Assigned(aDictionary) then
    Result := DBIERR_INVALIDPARAM
  else if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableBuild
      (aOverWrite, aTableName, aPassword, aDictionary, aTableScope, AbstractDatabase.ExplicitAllowSystem);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetCursor(aInx: Integer): TnxCursor;
begin
  Result := TnxCursor(dbDataSets[aInx]);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetCursorCount: Integer;
begin
  Result := dbDataSets.Count;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetDataSet(aInx: Integer): TnxDataset;
begin
  Result := TnxCursor(dbDataSets[aInx]).crDataSet;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetDataSetCount: Integer;
begin
  Result := dbDataSets.Count;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetDefault: Boolean;
begin
  Result := Assigned(Session) and (Session.bsDefaultDatabase = Self);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.btcGetInTransaction: Boolean;
var
  TransLevel : Integer;
  Error      : TnxResult;
begin
  if Active then begin
    Error := bdbAbstractDatabase.TransactionGetLevel(TransLevel);
    if Error = DBIERR_NOACTIVETRAN then
      Result := False
    else begin
      nxcCheck(Error);
      Result := TransLevel >= 0;
    end;
  end else
    Result := False;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetQuery(aInx: Integer): TnxStatementDataSet;
begin
  Result := TnxCursor(dbQueries[aInx]).crDataSet
    as TnxStatementDataSet;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetQueryCount: Integer;
begin
  Result := dbQueries.Count;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetTable(aInx: Integer): TnxTable;
begin
  Result := TnxCursor(dbTables[aInx]).crDataSet
    as TnxTable;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.dbGetTableCount: Integer;
begin
  Result := dbTables.Count;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.dbSetCacheDatabase(aValue: TnxCacheDatabase);
begin
  if dbCacheDatabase <> aValue then begin
    scCheckInactive;
    nxcRemoveDependingOn(dbCacheDatabase);
    dbCacheDatabase := aValue;
    nxcAddDependingOn(dbCacheDatabase);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.dbSetDefault(const Value: Boolean);
begin
  if csLoading in ComponentState then
    dbLoadedDefault := Value
  else
    if Default <> Value then
      if Value then begin
        if Assigned(Session) then
          Session.bsDefaultDatabase := Self;
      end else
        Session.bsDefaultDatabase := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.DeleteTable(const aTableName : string;
                                  const aPassword  : UnicodeString);
var
  Result : TnxResult;
begin
  if aTableName <> '' then begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableDelete(aTableName, aPassword);
    if Result <> DBIERR_NOSUCHTABLE then
      nxcCheck(Result);
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxDatabase.Destroy;
begin
  inherited;
  nxFreeAndNil(dbDataSets);
  nxFreeAndNil(dbTables);
  nxFreeAndNil(dbQueries);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.EmptyTable(const aTableName : string;
                                 const aPassword  : UnicodeString);
begin
  if aTableName = '' then
    nxcError(DBIERR_INVALIDTABLENAME);

  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TableEmpty(aTableName, aPassword));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ExecQuery(const aQuery  : string;
                               const aParams : array of const)
                                             : TnxDynVariantArray;
begin
  with TnxQuery.Create(nil) do try
    Database := Self;
    Sql.Text := aQuery;
    AssignValuesToParams(Params, aParams);
    ExecSql;
    Result := ValuesFromParams(Params);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ExecQueryFromFile(const aFileName : string;
                                       const aParams   : array of const)
                                                       : TnxDynVariantArray;
begin
  with TnxQuery.Create(nil) do try
    Database := Self;
    Sql.LoadFromFile(aFileName);
    AssignValuesToParams(Params, aParams);
    ExecSql;
    Result := ValuesFromParams(Params);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ExecQueryFromStream(aStream : TStream;
                                   const aParams : array of const)
                                                 : TnxDynVariantArray;
begin
  with TnxQuery.Create(nil) do try
    Database := Self;
    Sql.LoadFromStream(aStream);
    AssignValuesToParams(Params, aParams);
    ExecSql;
    Result := ValuesFromParams(Params);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ExecStoredProc(const aStoredProcName : string;
                                    const aParams         : array of const)
                                                          : TnxDynVariantArray;
begin
  Result := nil;
  with TnxStoredProc.Create(nil) do try
    Database := Self;
    StoredProcName := aStoredProcName;
    RefreshParam;
    AssignValuesToParams(Params, aParams);
    ExecProc;
    Result := ValuesFromParams(Params);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetAutoIncValue(const aTableName : string;
                                      const aPassword  : UnicodeString;
                                        out aValue     : TnxWord32);
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TableAutoIncGet(aTableName, aPassword, aValue));
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetChangedTables(aList: TStrings);
begin
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  scCheckStarted;

  aList.BeginUpdate;
  try
    aList.Clear;
    nxcCheck(bdbAbstractDatabase.GetChangedTables(aList));
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetDataDictionary(const aTableName  : string;
                                        const aPassword   : UnicodeString;
                                              aDictionary : TnxDataDictionary);
begin
  nxcCheck(GetDataDictionaryEx(aTableName, aPassword, aDictionary));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.GetDataDictionaryEx(const aTableName  : string;
                                         const aPassword   : UnicodeString;
                                               aDictionary : TnxDataDictionary)
                                                           : TnxResult;
begin
  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else if not Assigned(aDictionary) then
    Result := DBIERR_INVALIDPARAM
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableGetDictionary
      (ChangeFileExt(aTableName, ''), aPassword, aDictionary);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetStoredProcNames(aList: TStrings);
var
  NameField: TField;
begin
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  scCheckStarted;

  aList.BeginUpdate;
  try
    aList.Clear;
    with OpenQuery('SELECT * from #PROCEDURES', [], 512 * 1024) do try
      NameField := FieldByName('PROCEDURE_NAME');
      while not Eof do begin
        aList.Add(NameField.AsString);
        Next;
      end;
    finally
      Free;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetStoredProcParams(const aStoredProcName : string;
                                            out aParams         : TnxStoredProcParamList);
var
  NameField: TField;
  TypeField: TField;
  KindField: TField;
  SizeField: TField;
{const
  ParamType : array[Boolean] of TnxParamType = (
    nxptInput,
    nxptOutput
  );}
begin
  with OpenQuery('SELECT * FROM #PROCEDURE_ARGUMENTS WHERE PROCEDURE_NAME = :name',
    [aStoredProcName], 512 * 1024) do try

    NameField := FieldByName('PROCEDURE_ARGUMENT_NAME');
    TypeField := FieldByName('PROCEDURE_ARGUMENT_TYPE');
    KindField := FieldByName('PROCEDURE_ARGUMENT_KIND');
    SizeField := FieldByName('PROCEDURE_ARGUMENT_UNITS');

    while not Eof do begin

      SetLength(aParams, Succ(Length(aParams)));
      with aParams[High(aParams)] do begin
        piParamName := NameField.AsString;
        piDataType := FieldDataTypesMapSQL(TypeField.AsString);
        piParamType := nxStrToParamType(KindField.AsString);
        piSize := SizeField.AsInteger;
      end;

      Next;
    end;

  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetStoredFuncNames(aList: TStrings);
var
  NameField: TField;
begin
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  scCheckStarted;

  aList.BeginUpdate;
  try
    aList.Clear;
    with OpenQuery('SELECT * from #FUNCTIONS', [], 512 * 1024) do try
      NameField := FieldByName('FUNCTION_NAME');
      while not Eof do begin
        aList.Add(NameField.AsString);
        Next;
      end;
    finally
      Free;
    end;
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetStoredFuncParams(const aStoredFuncName : string;
                                            out aParams         : TnxStoredProcParamList);
var
  NameField: TField;
  TypeField: TField;
  KindField: TField;
  SizeField: TField;
{const
  ParamType : array[Boolean] of TnxParamType = (
    nxptInput,
    nxptOutput
  );}
begin
  with OpenQuery('SELECT * FROM #FUNCTION_ARGUMENTS WHERE FUNCTION_NAME = :name',
    [aStoredFuncName], 512 * 1024) do try

    NameField := FieldByName('FUNCTION_ARGUMENT_NAME');
    TypeField := FieldByName('FUNCTION_ARGUMENT_TYPE');
    KindField := FieldByName('FUNCTION_ARGUMENT_KIND');
    SizeField := FieldByName('FUNCTION_ARGUMENT_UNITS');

    while not Eof do begin

      SetLength(aParams, Succ(Length(aParams)));
      with aParams[High(aParams)] do begin
        piParamName := NameField.AsString;
        piDataType := FieldDataTypesMapSQL(TypeField.AsString);
        piParamType := nxStrToParamType(KindField.AsString);
        piSize := SizeField.AsInteger;
      end;

      Next;
    end;

  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetTableNames(aList: TStrings);
begin
  if not Assigned(aList) then
    nxcError(DBIERR_INVALIDPARAM);

  scCheckStarted;

  aList.BeginUpdate;
  try
    aList.Clear;
    nxcCheck(bdbAbstractDatabase.TableGetList(aList));
  finally
    aList.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.GetTablesNeedingPack(aList: TStrings);
begin
  bdbAcquireInterfaces;
  if Assigned(bdbAbstractDatabase31000) then
    nxUnicodeStringsToDelphiStrings(bdbAbstractDatabase31000.GetTablesNeedingPack, aList)
  else
    nxcCheck(DBIERR_NOTSUPPORTED);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.Loaded;
begin
  inherited;
  Default := dbLoadedDefault;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.nxcAddDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxCursor then begin
    dbDataSets.Add(aComponent);

    if TnxCursor(aComponent).crDataSet is TnxTable then
      dbTables.Add(aComponent)
    else if TnxCursor(aComponent).crDataSet is TnxStatementDataSet then
      dbQueries.Add(aComponent);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.nxcNotification(aSender    : TnxComponent;
                                      aOperation : TnxNotifyOp;
                                      aParam     : Pointer);
begin
  if (aSender = dbCacheDatabase) and (aOperation = nxn_Destroy) then begin
    Active := False;
    dbCacheDatabase := nil;
  end;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.nxcRemoveDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxCursor then begin
    if TnxCursor(aComponent).crDataSet is TnxTable then
      dbTables.Remove(aComponent)
    else if TnxCursor(aComponent).crDataSet is TnxStatementDataSet then
      dbQueries.Remove(aComponent);

    dbDataSets.Remove(aComponent);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.OpenQuery(const aQuery         : string;
                               const aParams        : array of const;
                                     aBlockReadSize : Integer = 0;
                                     aRequestLive   : Boolean = False)
                                                    : TnxQuery;
begin
  Result := TnxQuery.Create(nil);
  with Result do try
    Database := Self;
    Sql.Text := aQuery;
    AssignValuesToParams(Params, aParams);
    BlockReadSize := aBlockReadSize;
    RequestLive := aRequestLive;
    Open;
  except
    Free;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.OpenStoredProc(const aStoredProcName : string;
                                    const aParams         : array of const;
                                          aBlockReadSize  : Integer = 0)
                                                          : TnxStoredProc;
begin
  Result := TnxStoredProc.Create(nil);
  with Result do try
    Database := Self;
    StoredProcName := aStoredProcName;
    AssignValuesToParams(Params, aParams);
    BlockReadSize := aBlockReadSize;
    Open;
  except
    Free;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.OpenTable(const aTableName     : string;
                               const aIndexName     : string;
                                     aBlockReadSize : Integer)
                                                    : TnxTable;
begin
  Result := TnxTable.Create(nil);
  with Result do try
    Database := Self;
    TableName := aTableName;
    IndexName := aIndexName;
    BlockReadSize := aBlockReadSize;
    Open;
  except
    Free;
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.PackTable(const aTableName : string;
                               const aPassword  : UnicodeString)
                                                : TnxAbstractTaskInfo;
begin
  nxcCheck(PackTableEx(aTableName, aPassword, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.PackTableEx(const aTableName : string;
                                 const aPassword  : UnicodeString;
                                   out aTaskInfo  : TnxAbstractTaskInfo)
                                                  : TnxResult;
begin
  aTaskInfo := nil;

  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TablePack(aTableName, aPassword, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.RecoverTable(const aTableName: string; const aPassword: UnicodeString) : TnxAbstractTaskInfo;
begin
  nxcCheck(RecoverTableEx(aTableName, aPassword, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.RecoverTableEx(const aTableName : string;
                                    const aPassword  : UnicodeString;
                                      out aTaskInfo  : TnxAbstractTaskInfo)
                                                     : TnxResult;
begin
  Result := nxCheckValidRootTableName(aTableName, True);

  if Result = DBIERR_NONE then begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableRecover(aTableName, aPassword, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ReIndexTable(const aTableName : string;
                                  const aPassword  : UnicodeString;
                                  const aIndexName : string)
                                                   : TnxAbstractTaskInfo;
begin
  nxcCheck(ReIndexTableEx(aTableName, aPassword, aIndexName, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ReIndexTable(const aTableName : string;
                                  const aPassword  : UnicodeString;
                                        aIndexNum  : Integer)
                                                   : TnxAbstractTaskInfo;
begin
  nxcCheck(ReIndexTableEx(aTableName, aPassword, aIndexNum, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ReIndexTableEx(const aTableName : string;
                                    const aPassword  : UnicodeString;
                                    const aIndexName : string;
                                      out aTaskInfo  : TnxAbstractTaskInfo)
                                                     : TnxResult;
begin
  aTaskInfo := nil;

  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableRebuildIndex
      (aTableName, aPassword, aIndexName, -1, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.ReIndexTableEx(const aTableName : string;
                                    const aPassword  : UnicodeString;
                                          aIndexNum  : Integer;
                                      out aTaskInfo  : TnxAbstractTaskInfo)
                                                     : TnxResult;
begin
  aTaskInfo := nil;

  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableRebuildIndex
      (aTableName, aPassword, '', aIndexNum, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.RenameTable(const aOldName, aNewName: string; const aPassword: UnicodeString);
begin
  if aOldName = '' then
    nxcError(DBIERR_INVALIDTABLENAME);
  if aNewName = '' then
    nxcError(DBIERR_INVALIDTABLENAME);

  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TableRename(aOldName, aNewName, aPassword));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.RestructureTable(const aTableName   : string;
                                      const aPassword    : UnicodeString;
                                            aDictionary  : TnxDataDictionary;
                                            aMapperDesc  : TnxBaseTableMapperDescriptor)
                                                         : TnxAbstractTaskInfo;
begin
  nxcCheck(RestructureTableEx(aTableName, aPassword, aDictionary, aMapperDesc, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.RestructureTableEx(const aTableName   : string;
                                        const aPassword    : UnicodeString;
                                              aDictionary  : TnxDataDictionary;
                                              aMapperDesc  : TnxBaseTableMapperDescriptor;
                                          out aTaskInfo    : TnxAbstractTaskInfo)
                                                           : TnxResult;
begin
  aTaskInfo := nil;

  if aTableName = '' then
    Result := DBIERR_INVALIDTABLENAME
  else if not Assigned(aDictionary) then
    Result := DBIERR_INVALIDPARAM
  else begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableRestructure
      (aTableName, aPassword, aDictionary, aMapperDesc, bdbAbstractDatabase.ExplicitAllowSystem, aTaskInfo);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.Rollback;
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TransactionRollback);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result :=
    (aComponent = dbCacheDatabase) or
    inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.scStarting;
begin
  inherited;
  if Assigned(dbCacheDatabase) and
     Assigned(dbCacheDatabase.bdbAbstractDatabase)
  then
    bdbAbstractDatabase.SetCacheDatabase(dbCacheDatabase.bdbAbstractDatabase);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.scStopping;
var
  i : Integer;
begin
  for i := 0 to Pred(QueryCount) do
    Queries[i].Unprepare;

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.soRefreshTimeout;
var
  Idx : Integer;
begin
  if Assigned(bdbAbstractDatabase) then begin
    bdbAbstractDatabase.BeginTimeoutBatch;
    try
      bdbAbstractDatabase.Timeout := soGetTimeout;
      for Idx := 0 to Pred(CursorCount) do
        Cursors[Idx].crRefreshTimeout;
    finally
      bdbAbstractDatabase.EndTimeoutBatch;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.StartTransaction(aSnapShot: Boolean);
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TransactionStart(bdbFailSafe, aSnapShot));
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.StartTransactionWith(const aTables   : array of TnxTable;
                                                 aSnapShot : Boolean);
begin
  nxcCheck(StartTransactionWithEx(aTables, aSnapShot));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.StartTransactionWithEx(const aTables   : array of TnxTable;
                                                  aSnapShot : Boolean)
                                                            : TnxResult;
var
  Cursors : array of TnxAbstractCursor;
  Inx     : Integer;
begin
  scCheckStarted;

  SetLength(Cursors, Length(aTables));
  for Inx := Low(aTables) to High(aTables) do begin
    if not aTables[Inx].Active then
      nxcError(@rsTableMustBeActive, [Inx, aTables[Inx].TableName]);
    Cursors[Inx] := aTables[Inx].dsAbstractCursor;
  end;

  Result := bdbAbstractDatabase.TransactionStartWith
    (bdbFailSafe, aSnapShot, Cursors);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TableExists(const aTableName : string;
                                 const aPassword  : UnicodeString)
                                                  : Boolean;
begin
  if aTableName = '' then
    Result := False
  else begin
    scCheckStarted;
    nxcCheck(nxCheckValidTableName(aTableName, True, AbstractDatabase.ExplicitAllowSystem));
    nxcCheck(bdbAbstractDatabase.TableExists(aTableName, aPassword, Result, AbstractDatabase.ExplicitAllowSystem));
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TableStreamRead(const aTableName  : string;
                                     const aPassword   : UnicodeString;
                                     const aStreamName : string)
                                                       : TStream;
begin
  scCheckStarted;
  Result := TnxMemoryStream.Create;
  try
    nxcCheck(TableStreamReadEx(aTableName, aPassword, aStreamName, Result));
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TableStreamReadEx(const aTableName  : string;
                                       const aPassword   : UnicodeString;
                                       const aStreamName : string;
                                             aStream     : TStream)
                                                         : TnxResult;
begin
  scCheckStarted;

  Result := nxCheckValidTableName(aTableName, True, AbstractDatabase.ExplicitAllowSystem);

  if Result = DBIERR_NONE then
    Result := bdbAbstractDatabase.
      TableStreamRead(aTableName, aPassword, aStreamName, aStream);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.TableStreamWrite(const aTableName  : string;
                                       const aPassword   : UnicodeString;
                                       const aStreamName : string;
                                             aStream     : TStream);
begin
  scCheckStarted;
  nxcCheck(TableStreamWriteEx(aTableName, aPassword, aStreamName, aStream));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TableStreamWriteEx(const aTableName  : string;
                                        const aPassword   : UnicodeString;
                                        const aStreamName : string;
                                              aStream     : TStream)
                                                          : TnxResult;
begin
  scCheckStarted;

  Result := nxCheckValidTableName(aTableName, True, AbstractDatabase.ExplicitAllowSystem);

  if Result = DBIERR_NONE then
    Result := bdbAbstractDatabase.
      TableStreamWrite(aTableName, aPassword, aStreamName, aStream);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.TransactionCorrupted;
begin
  scCheckStarted;
  nxcCheck(bdbAbstractDatabase.TransactionCorrupted);
end;
{------------------------------------------------------------------------------}
procedure TnxDatabase.TransactionInclude(const aTables    : array of TnxTable;
                                               aExclusive : Boolean);
begin
  nxcCheck(TransactionIncludeEx(aTables, aExclusive));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TransactionIncludeEx(const aTables    : array of TnxTable;
                                                aExclusive : Boolean)
                                                           : TnxResult;
var
  Cursors : array of TnxAbstractCursor;
  Inx     : Integer;
begin
  scCheckStarted;

  SetLength(Cursors, Length(aTables));
  for Inx := Low(aTables) to High(aTables) do begin
    if not aTables[Inx].Active then
      nxcError(@rsTableMustBeActive, [Inx, aTables[Inx].TableName]);
    Cursors[Inx] := aTables[Inx].dsAbstractCursor;
  end;

  Result := bdbAbstractDatabase.TransactionInclude(aExclusive, Cursors);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.TryStartTransaction(aSnapShot: Boolean): Boolean;
begin
  Result := not InTransaction;
  if Result then
    StartTransaction(aSnapShot);
end;
{------------------------------------------------------------------------------}
function TnxDatabase.VerifyChecksumTable(const aTableName    : string;
                                         const aPassword     : UnicodeString;
                                               aRaw          : Boolean;
                                               aForceRecheck : Boolean)
                                                             : TnxAbstractTaskInfo;
begin
  nxcCheck(VerifyChecksumTableEx(aTableName, aPassword, aRaw, aForceRecheck, Result));
end;
{------------------------------------------------------------------------------}
function TnxDatabase.VerifyChecksumTableEx(const aTableName    : string;
                                           const aPassword     : UnicodeString;
                                                 aRaw          : Boolean;
                                                 aForceRecheck : Boolean;
                                             out aTaskInfo     : TnxAbstractTaskInfo)
                                                               : TnxResult;
begin
  Result := nxCheckValidRootTableName(aTableName, True);

  if Result = DBIERR_NONE then begin
    scCheckStarted;
    Result := bdbAbstractDatabase.TableVerifyChecksum(aTableName, aPassword, aRaw, aForceRecheck, aTaskInfo);
  end;
end;
{==============================================================================}



{===TnxTransContext============================================================}
procedure TnxTransContext.Commit;
begin
  scCheckStarted;
  nxcCheck(tcAbstractTransContext.TransactionCommit);
end;
{------------------------------------------------------------------------------}
constructor TnxTransContext.Create(AOwner: TComponent);
begin
  tcDatabases := TnxSortedList.Create;
  tcCursors := TnxSortedList.Create;
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxTransContext.Destroy;
begin
  inherited;
  nxFreeAndNil(tcDatabases);
  nxFreeAndNil(tcCursors);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.Loaded;
begin
  inherited;
  Default := tcLoadedDefault;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.nxcAddDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxDatabase then
    tcDatabases.Add(aComponent)
  else if aComponent is TnxCursor then
    tcCursors.Add(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.nxcRemoveDependent(aComponent: TnxComponent);
begin
  inherited;
  if aComponent is TnxDatabase then
    tcDatabases.Remove(aComponent)
  else if aComponent is TnxCursor then
    tcCursors.Remove(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.Rollback;
begin
  scCheckStarted;
  nxcCheck(tcAbstractTransContext.TransactionRollback);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.scInitializing;
begin
  inherited;
  soCheckSession;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.scStarting;
begin
  inherited;

  nxcCheck(soSession.bsAbstractSession.
    TransContextCreate(tcAbstractTransContext, soGetTimeout));
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.scStopping;
begin
  inherited;
  nxFreeAndNil(tcAbstractTransContext);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.soRefreshTimeout;
begin
  if Assigned(tcAbstractTransContext) then
    tcAbstractTransContext.Timeout := soGetTimeout;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.StartTransaction(aSnapShot : Boolean);
begin
  scCheckStarted;
  nxcCheck(tcAbstractTransContext.TransactionStart(tcFailSafe, aSnapShot));
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.StartTransactionWith(const aTables : array of TnxTable;
                                                     aSnapShot: Boolean);
begin
  nxcCheck(StartTransactionWithEx(aTables, aSnapShot));
end;
{------------------------------------------------------------------------------}
function TnxTransContext.StartTransactionWithEx(const aTables   : array of TnxTable;
                                                      aSnapShot : Boolean)
                                                                : TnxResult;
var
  Cursors : array of TnxAbstractCursor;
  Inx     : Integer;
begin
  scCheckStarted;

  SetLength(Cursors, Length(aTables));
  for Inx := Low(aTables) to High(aTables) do begin
    if not aTables[Inx].Active then
      nxcError(@rsTableMustBeActive, [Inx, aTables[Inx].TableName]);
    Cursors[Inx] := aTables[Inx].dsAbstractCursor;
  end;

  Result := tcAbstractTransContext.TransactionStartWith
    (tcFailSafe, aSnapShot, Cursors);
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetCursor(aInx: Integer): TnxCursor;
begin
  Result := TnxCursor(tcCursors[aInx]);
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetCursorCount: Integer;
begin
  Result := tcCursors.Count;
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetDatabase(aInx: Integer): TnxDatabase;
begin
  Result := TnxDatabase(tcDatabases[aInx]);
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetDatabaseCount: Integer;
begin
  Result := tcDatabases.Count;
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetDataset(aInx: Integer): TnxDataset;
begin
  Result := TnxCursor(tcCursors[aInx]).crDataSet;
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetDatasetCount: Integer;
begin
  Result := tcCursors.Count;
end;
{------------------------------------------------------------------------------}
function TnxTransContext.tcGetDefault: Boolean;
begin
  Result := Assigned(Session) and (Session.bsDefaultTransContext = Self);
end;
{------------------------------------------------------------------------------}
function TnxTransContext.btcGetInTransaction: Boolean;
var
  TransLevel : Integer;
  Error      : TnxResult;
begin
  scCheckStarted;
  Error := tcAbstractTransContext.TransactionGetLevel(TransLevel);
  if Error = DBIERR_NOACTIVETRAN then
    Result := False
  else begin
    nxcCheck(Error);
    Result := TransLevel >= 0;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.tcSetDefault(const Value: Boolean);
begin
  if csLoading in ComponentState then
    tcLoadedDefault := Value
  else
    if Default <> Value then
      if Value then begin
        if Assigned(Session) then
          Session.bsDefaultTransContext := Self;
      end else
        Session.bsDefaultTransContext := nil;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.tcSetFailSafe(Value: Boolean);
begin
  tcFailSafe := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.TransactionCorrupted;
begin
  scCheckStarted;
  nxcCheck(tcAbstractTransContext.TransactionCorrupted);
end;
{------------------------------------------------------------------------------}
procedure TnxTransContext.TransactionInclude(const aTables    : array of TnxTable;
                                                   aExclusive : Boolean);
begin
  nxcCheck(TransactionIncludeEx(aTables, aExclusive));
end;
{------------------------------------------------------------------------------}
function TnxTransContext.TransactionIncludeEx(const aTables    : array of TnxTable;
                                                    aExclusive : Boolean)
                                                               : TnxResult;
var
  Cursors : array of TnxAbstractCursor;
  Inx     : Integer;
begin
  scCheckStarted;

  SetLength(Cursors, Length(aTables));
  for Inx := Low(aTables) to High(aTables) do begin
    if not aTables[Inx].Active then
      nxcError(@rsTableMustBeActive, [Inx, aTables[Inx].TableName]);
    Cursors[Inx] := aTables[Inx].dsAbstractCursor;
  end;

  Result := tcAbstractTransContext.TransactionInclude(aExclusive, Cursors);
end;
{------------------------------------------------------------------------------}
function TnxTransContext.TryStartTransaction(aSnapShot : Boolean)
                                                       : Boolean;
begin
  Result := not InTransaction;
  if Result then
    StartTransaction(aSnapShot);
end;
{==============================================================================}



{===TnxCursor==================================================================}
procedure TnxCursor.crCheckDatabase;
begin
  if not Assigned(crDataBase) then
    crDataSet.dsError(@rsDataSetCantOpenDatabase);
end;
{------------------------------------------------------------------------------}
constructor TnxCursor.Create(aDataSet: TnxDataset);
begin
  crDataSet := aDataSet;
  inherited Create(nil);
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.crRefreshTimeout;
begin
  crDataSet.dsRefreshTimeout;
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.crSetDatabase(const Value: TnxDatabase);
begin
  if crDatabase <> Value then begin
    scCheckInactive;
    nxcRemoveDependingOn(crDatabase);
    crDatabase := Value;
    nxcAddDependingOn(crDatabase);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.crSetTransContext(const Value: TnxTransContext);
begin
  if crTransContext <> Value then begin
    if Assigned(Value) and (State = nxsStarted) then
      Value.Open;
    nxcRemoveDependingOn(crTransContext);
    crTransContext := Value;
    nxcAddDependingOn(crTransContext);
    if Assigned(crDataSet) then
      crDataSet.dsTransContextChanged;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.nxcNotification(aSender    : TnxComponent;
                                    aOperation : TnxNotifyOp;
                                    aParam     : Pointer);
begin
  inherited;
  if aOperation = nxn_Destroy then begin
    if aSender = crDatabase then begin
      Active := False;
      crDatabase := nil;
    end else if aSender = crTransContext then
      TransContext := nil;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.scCheckInactive;
begin
  if Assigned(crDataSet) then
    crDataSet.dsCheckInactiveFromCursor;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.scInitializing;
begin
  crDataSet.dsResolveDatabase;
  crCheckDatabase;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxCursor.scIsStateParent(aComponent: TnxStateComponent): Boolean;
begin
  Result :=
       (aComponent = crDatabase)
    or (aComponent = crTransContext)
    or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxCursor.scStopping;
begin
  inherited;
  if Assigned(crDataSet) then
    crDataSet.dsShutdownFromCursor;
end;
{==============================================================================}



{===TnxBaseBlobStream==========================================================}
procedure TnxBaseBlobStream.bbsAddToDataSet;
begin
  bbsDataSetPrev := bbsDataSet.dsBlobStreamsTail;
  bbsDataSet.dsBlobStreamsTail := Self;
  if Assigned(bbsDataSetPrev) then
    bbsDataSetPrev.bbsDataSetNext:=Self;
  if not Assigned(bbsDataSet.dsBlobStreamsHead) then
    bbsDataSet.dsBlobStreamsHead := Self;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseBlobStream.bbsCheck(const aErrorCode: TnxResult);
begin
  if aErrorCode <> DBIERR_NONE then
    with bbsDataset do
      raise dsExceptionClass.nxcCreate(bbsField, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseBlobStream.bbsDisable;
begin
  bbsField   := nil;
  bbsDataset := nil;
  bbsMode    := bmRead;
  bbsRemoveFromDataSet;
end;
{------------------------------------------------------------------------------}
procedure TnxBaseBlobStream.bbsRemoveFromDataSet;
begin
  if Assigned(bbsDataSetNext) then
    bbsDataSetNext.bbsDataSetPrev := bbsDataSetPrev
  else
    if bbsDataSet.dsBlobStreamsTail = Self then
      bbsDataSet.dsBlobStreamsTail := bbsDataSetPrev;

  if Assigned(bbsDataSetPrev) then
    bbsDataSetPrev.bbsDataSetNext := bbsDataSetNext
  else
    if bbsDataSet.dsBlobStreamsHead = Self then
      bbsDataSet.dsBlobStreamsHead := bbsDataSetNext;

  bbsDataSetNext := nil;
  bbsDataSetPrev := nil;
end;
{------------------------------------------------------------------------------}
constructor TnxBaseBlobStream.Create(aField : TBlobField;
                                     aMode  : TBlobStreamMode);
begin
  inherited Create;

  bbsMode := aMode;
  bbsField := aField;
  bbsFieldNo := Pred(bbsField.FieldNo);
  bbsDataset := bbsField.DataSet as TnxDataset;

  bbsAddToDataSet;
end;
{------------------------------------------------------------------------------}
destructor TnxBaseBlobStream.Destroy;
begin
  bbsRemoveFromDataSet;
  inherited;
end;
{==============================================================================}



{===TnxBlockModeBlobStream=====================================================}
procedure TnxBlockModeBlobStream.bbsDisable;
begin
  bmbsBlob := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxBlockModeBlobStream.Create(aField : TBlobField;
                                          aMode  : TBlobStreamMode);
var
  lBuffer     : TnxRecordBuffer;
  lBlobOffset : TnxBlobNr;
  lRecID      : TnxRecID;
  lOffset     : TnxWord32;
  lIsNull     : Boolean;
begin
  if aMode <> bmRead then
    raise EnxDatabaseError.nxCreate(DBIERR_READONLYFLD);

  with TnxDataset(aField.DataSet) do
    if dsGetActiveBuffer(lBuffer) then begin
      bbsCheck(dsGetBlobNr(lBuffer, aField, lIsNull, lBlobOffset, lRecID));
      if not lIsNull then begin
        lOffset := lBlobOffset;
        bmbsBlob := @dsBlockReadEntry.bseStreamBase[lOffset];
      end;
    end;

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxBlockModeBlobStream.Read(var aBuffer;
                                         aCount : Integer)
                                                : Integer;
begin
  if not Assigned(bmbsBlob) then begin
    Result := 0;
  end else begin
    Result := Max(0, Min(aCount, PInteger(bmbsBlob)^ - bmbsPosition));
    nxMove(Pointer(TnxNativeUInt(bmbsBlob) + TnxNativeUInt(bmbsPosition) + SizeOf(Integer))^,
      aBuffer, Result);
    Inc(bmbsPosition, Result);
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlockModeBlobStream.Seek(aOffset: Integer; aOrigin: Word): Integer;
begin
  case aOrigin of
    soFromBeginning : bmbsPosition := aOffset;
    soFromCurrent   : Inc(bmbsPosition, aOffset);
    soFromEnd       : begin
      if Assigned(bmbsBlob) then
        bmbsPosition := PInteger(bmbsBlob)^ + aOffset
      else
        bmbsPosition := aOffset;
    end;
  end;
  Result := bmbsPosition;
end;
{------------------------------------------------------------------------------}
procedure TnxBlockModeBlobStream.Truncate;
begin
  bbsCheck(DBIERR_READONLYFLD);
end;
{------------------------------------------------------------------------------}
function TnxBlockModeBlobStream.Write(const aBuffer; aCount: Integer): Integer;
begin
  Result := 0;
end;
{==============================================================================}



{===TnxBatchAppendBlobStream===================================================}
procedure TnxBatchAppendBlobStream.bbsDisable;
begin
  babsStream := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxBatchAppendBlobStream.Create(aField : TBlobField;
                                            aMode  : TBlobStreamMode);
begin
  inherited;

  with TnxDataset(aField.DataSet), dsFieldsDescriptor do begin
    SetLength(dsBatchAppendBlobs, FieldCount);
    if not Assigned(dsBatchAppendBlobs[Pred(aField.FieldNo)]) then
      dsBatchAppendBlobs[Pred(aField.FieldNo)] := TnxMemoryStream.Create;
    babsStream := dsBatchAppendBlobs[Pred(aField.FieldNo)];
    if bbsMode = bmWrite then
      babsStream.Clear;
    babsStream.Position := 0;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxBatchAppendBlobStream.Destroy;
begin
  if Assigned(babsStream) then
    babsStream.Position := 0;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxBatchAppendBlobStream.Read(var aBuffer;
                                           aCount : Integer)
                                                  : Integer;
begin
  if Assigned(babsStream) then
    Result := babsStream.Read(aBuffer, aCount)
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxBatchAppendBlobStream.Seek(aOffset : Integer;
                                       aOrigin : Word)
                                               : Integer;
begin
  if Assigned(babsStream) then
    Result := babsStream.Seek(aOffset, aOrigin)
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchAppendBlobStream.SetSize(NewSize: Integer);
begin
  if Assigned(babsStream) then
    babsStream.Size := NewSize;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchAppendBlobStream.SetSize(const NewSize: Int64);
begin
  babsStream.Size := NewSize;
end;
{------------------------------------------------------------------------------}
procedure TnxBatchAppendBlobStream.Truncate;
begin
  if Assigned(babsStream) then
    with babsStream do
      if Size > Position then
        Size := Position;
end;
{------------------------------------------------------------------------------}
function TnxBatchAppendBlobStream.Write(const aBuffer;
                                              aCount : Integer)
                                                     : Integer;
begin
  if bbsMode = bmRead then
    Result := 0
  else
    if Assigned(babsStream) then
      Result := babsStream.Write(aBuffer, aCount)
    else
      Result := 0;
end;
{==============================================================================}



{===TnxMemoBlobStream==========================================================}
procedure TnxMemoBlobStream.bbsDisable;
begin
  if Assigned(mbsInnerStream) then begin
    mbsInnerStream.bbsDisable;
    nxFreeAndNil(mbsInnerStream);
  end;
  if mbsStream is TnxBaseBlobStream then
    TnxBaseBlobStream(mbsStream).bbsDisable;
  nxFreeAndNil(mbsStream);

  inherited;
end;
{------------------------------------------------------------------------------}
constructor TnxMemoBlobStream.Create(aField       : TBlobField;
                                     aMode        : TBlobStreamMode;
                                     aInnerStream : TnxBaseBlobStream);
var
  InnerSize : Int64;
  s         : AnsiString;
  ws        : TnxWideString;
begin
  inherited Create(aField, aMode);

  with TnxDataset(aField.DataSet), dsFieldsDescriptor, FieldDescriptor[Pred(aField.FieldNo)] do begin
    mbsIsWide := fdType = nxtBlobWideMemo;
    mbsCodePage := UsedStorageCodePage;
  end;

  aInnerStream.Position := 0;

  if not mbsIsWide and (mbsCodePage = 0) then
    mbsStream := aInnerStream
  else begin
    mbsInnerStream := aInnerStream;

    if aMode <> bmWrite then begin
      InnerSize := mbsInnerStream.Size;

      if mbsIsWide then begin
        InnerSize := InnerSize and (not 1);
        SetLength(ws, InnerSize div 2);
        if InnerSize > 0 then
          mbsInnerStream.ReadBuffer(ws[0], InnerSize);
      end else {if mbsCodePage <> 0 then} begin
        SetLength(s, InnerSize);
        if InnerSize > 0 then
          mbsInnerStream.ReadBuffer(s[1], InnerSize);
        ws := nxStringToWideString(s, mbsCodePage);
        S := '';
      end;

      mbsStream := TnxAnsiStringStream.Create(nxWideStringToString(ws, 0));
    end else
      mbsStream := TnxMemoryStream.Create;
  end;

  mbsStream.Position := 0;
end;
{------------------------------------------------------------------------------}
destructor TnxMemoBlobStream.Destroy;
var
  Buffer     : Pointer;
  BufferSize : Integer;
  ws         : TnxWideString;
  s          : AnsiString;
begin
  try
    ws := nil;
    Buffer := nil;

    if mbsModified and Assigned(mbsInnerStream) then begin

      BufferSize := mbsStream.Size;
      if BufferSize > 0 then
        if mbsStream is TnxAnsiStringStream then
          Buffer := @TnxAnsiStringStream(mbsStream).DataString[1]
        else if mbsStream is TnxMemoryStream then
          Buffer := TnxMemoryStream(mbsStream).Memory
        else
          BufferSize := 0;

      if BufferSize > 0 then
        ws := nxBytesToWideString(Buffer^, BufferSize, 0);

      mbsInnerStream.Position := 0;

      if Length(ws) > 0 then
        if mbsIsWide then
          mbsInnerStream.WriteBuffer(ws[0], Length(ws) * SizeOf(WideChar))
        else begin
          s := nxWideStringToString(ws, mbsCodePage);
          if Length(s) > 0 then
            mbsInnerStream.WriteBuffer(s[1], Length(s));
        end;

      mbsInnerStream.Truncate;
    end;

  finally
    try
      nxFreeAndNil(mbsInnerStream);
    finally
      inherited;
      nxFreeAndNil(mbsStream);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxMemoBlobStream.Read(var aBuffer;
                                    aCount : Integer)
                                           : Integer;
begin
  if Assigned(mbsStream) then
    Result := mbsStream.Read(aBuffer, aCount)
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxMemoBlobStream.Seek(aOffset : Integer;
                                aOrigin : Word)
                                        : Integer;
begin
  if Assigned(mbsStream) then
    Result := mbsStream.Seek(aOffset, aOrigin)
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}
procedure TnxMemoBlobStream.SetSize(NewSize: Integer);
begin
  if Assigned(mbsStream) then
    mbsStream.Size := NewSize;
end;
{------------------------------------------------------------------------------}
procedure TnxMemoBlobStream.SetSize(const NewSize: Int64);
begin
  if Assigned(mbsStream) then
    mbsStream.Size := NewSize;
end;
{------------------------------------------------------------------------------}
procedure TnxMemoBlobStream.Truncate;
begin
  if bbsMode = bmRead then
    bbsCheck(DBIERR_READONLYFLD);

  if Assigned(mbsStream) then
    if mbsStream is TnxBaseBlobStream then
      TnxBaseBlobStream(mbsStream).Truncate
    else
      with mbsStream do
        if Size > Position then begin
          Size := Position;
          mbsModified := True;
        end;
end;
{------------------------------------------------------------------------------}
function TnxMemoBlobStream.Write(const aBuffer;
                                       aCount : Integer)
                                              : Integer;
begin
  if (bbsMode = bmRead) or not Assigned(mbsStream) then
    Result := 0
  else begin
    mbsModified := True;
    Result := mbsStream.Write(aBuffer, aCount);
  end;
end;
{==============================================================================}



{==============================================================================}
procedure TnxBlobStream.bbsDisable;
begin
  bsOpened := False;
  nxFreeAndNil(bsCache);
  bsBuffer := nil;
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.bsGetBlobSize: TnxWord32;
var
  lStatus     : TnxResult;
  lIsNull     : Boolean;
  lBlobNr     : TnxBlobNr;
  lNewBlobNr  : TnxNewBlobNr;
  lRecID      : TnxRecID;
begin
  Result := 0;
  if bsOpened then begin
    with bbsDataset do begin
      if bsNeedsTruncate0 then begin
        Truncate;
        bsNeedsTruncate0 := False;
        Exit;
      end;

      repeat
        lNewBlobNr.nbnSet := False;
        lStatus := dsGetBlobNr(bsBuffer, bbsField, lIsNull, lBlobNr, lRecID);
        if (lStatus = DBIERR_NONE) and (not lIsNull) then begin
          lNewBlobNr.nbnBlobNr := lBlobNr;
          lStatus := dsAbstractCursor.BlobGetLength(lRecID, bbsFieldNo, lBlobNr, Result, bsReadOrg, @lNewBlobNr);
        end;
        if (lStatus <> DBIERR_NONE) and bsShouldRetry(lStatus, lNewBlobNr) then
          Continue
        else begin
          if (bbsMode = bmRead) and
             (
               (lStatus = DBIERR_KEYORRECDELETED) or
               (lStatus = DBIERR_NOCURRREC)
             )
          then begin
            bsOpened := False;
            Exit;
          end;
          bbsCheck(lStatus);
        end;
        if (lNewBlobNr.nbnSet) and (lBlobNr <> lNewBlobNr.nbnBlobNr) then
          dsSetBlobNr(bsBuffer, bbsField, lNewBlobNr.nbnBlobNr);
        Break;
      until False;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.bsHasRecordChangedAtServer(var aStatus    : TnxResult;
                                                const aNewBlobNr : TnxNewBlobNr)
                                                                 : Boolean;
var
  LastErrorCode     : TnxResult;
  LastCustomMessage : string;
  Error             : TnxResult;
  Buffer            : TnxRecordBuffer;

  OldIsNull         : Boolean;
  OldBlobNr         : TnxBlobNr;
  OldRecID          : TnxRecID;

  NewIsNull         : Boolean;
  NewBlobNr         : TnxBlobNr;
  NewRecID          : TnxRecID;
begin
  EnxBaseException.GetLastConvertedException(LastErrorCode, LastCustomMessage);
  with bbsDataset do
    if aNewBlobNr.nbnSet then begin
      dsGetBlobNr(bsBuffer, bbsField, OldIsNull, OldBlobNr, OldRecID);
      NewBlobNr := aNewBlobNr.nbnBlobNr;
      if OldIsNull then
        OldBlobNr := 0;

      Result := OldBlobNr <> NewBlobNr;
      if Result then
        dsSetBlobNr(bsBuffer, bbsField, NewBlobNr);
    end else  try
      UpdateCursorPos;
      Buffer := AllocRecordBuffer;
      try
        Error := dsAbstractCursor.RecordGet(nxltNoLock, Pointer(Buffer));
        if (Error = DBIERR_KEYORRECDELETED) or (Error = DBIERR_NOCURRREC) then begin
          aStatus := Error;
          Result := True;
          dsSetBlobNr(bsBuffer, bbsField, 0);
        end else begin
          dsGetBlobNr(bsBuffer, bbsField, OldIsNull, OldBlobNr, OldRecID);
          dsGetBlobNr(  Buffer, bbsField, NewIsNull, NewBlobNr, NewRecID);

          if OldIsNull then
            OldBlobNr := 0;
          if NewIsNull then
            NewBlobNr := 0;

          Result := OldBlobNr <> NewBlobNr;

          if Result then
            dsSetBlobNr(bsBuffer, bbsField, NewBlobNr);
        end;
      finally
        FreeRecordBuffer(Buffer);
      end;
    finally
      if aStatus = LastErrorCode then
        EnxBaseException.SetLastConvertedException(LastErrorCode, LastCustomMessage);
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.bsReadCache(aMaxSize: Int64);
var
  IsNull         : Boolean;
  BlobNr         : TnxBlobNr;
  NewBlobNr      : TnxNewBlobNr;
  RecID          : TnxRecID;
begin
  if bsCacheStatus = DBIERR_NA then begin
    if aMaxSize <> 0 then begin
      repeat
        bsCache.Clear;
        bsCacheStatus := bbsDataSet.dsGetBlobNr(bsBuffer, bbsField, IsNull, BlobNr, RecID);
        if bsCacheStatus = DBIERR_NONE then begin
          if IsNull then
            Break;

          NewBlobNr.nbnBlobNr := BlobNr;
          NewBlobNr.nbnSet := False;

          bsCacheStatus := bbsDataSet.dsAbstractCursor.BlobRead(RecID, bbsFieldNo, BlobNr, 0,
            High(TnxWord32), bsCache, bsReadOrg, @NewBlobNr);
        end;
      until (bsCacheStatus = DBIERR_NONE) or not bsShouldRetry(bsCacheStatus, NewBlobNr);
      bsCache.Position := 0;
    end else
      bsCacheStatus := DBIERR_NONE;
  end;

  case bsCacheStatus of
    DBIERR_NONE : ;
    DBIERR_KEYORRECDELETED, DBIERR_NOCURRREC : bsCache.Clear;
  else
    bbsCheck(bsCacheStatus);
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.bsShouldRetry(var aStatus    : TnxResult;
                                   const aNewBlobNr : TnxNewBlobNr)
                                                    : Boolean;
begin
  if bbsMode = bmRead then
    case aStatus of
      DBIERR_NX_SEGMENTDELETED,
      DBIERR_NX_INVALIDSEGNR,
      DBIERR_NX_BADHEAPBLOCK,
      DBIERR_NX_BADBLOCKNR,
      DBIERR_BLOBMODIFIED:
        Result := True;
    else
      Result := ErrCat(aStatus) = ERRCAT_DATACORRUPT;
    end
  else
    Result := False;

  if not Result then
    Exit;

  Result := bsHasRecordChangedAtServer(aStatus, aNewBlobNr);
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.bsWriteCache;
var
  Status            : TnxResult;
  IsNull            : Boolean;
  BlobNr            : TnxBlobNr;
  NewBlobNr         : TnxBlobNr;
  RecID             : TnxRecID;
begin
  if bsCacheStatus = DBIERR_NONE then begin
    Status := bbsDataSet.dsGetBlobNr(bsBuffer, bbsField, IsNull, BlobNr, RecID);
    if Status = DBIERR_NONE then begin
      if bsCache.Size = 0 then begin
        if BlobNr <> 0 then
          Status := bbsDataset.AbstractCursor.BlobTruncate(RecID, bbsFieldNo, BlobNr, 0);
      end else begin
        NewBlobNr := BlobNr;
        Status := bbsDataset.AbstractCursor.BlobReplace(RecID, bbsFieldNo, NewBlobNr, bsCache.Size, bsCache.Memory^);
        if Status = DBIERR_NONE then
          if BlobNr <> NewBlobNr then
            bbsDataset.dsSetBlobNr(bsBuffer, bbsField, NewBlobNr);
      end;
    end;
    bbsCheck(Status);
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxBlobStream.Create(aField   : TBlobField;
                                 aMode    : TBlobStreamMode;
                                 aReadOrg : Boolean;
                                 aCached  : Boolean);
begin
  inherited Create(aField, aMode);

  bsChunkSize := nxMaxBlobChunk;

  if bbsDataset.State = dsFilter then
    raise EnxDatabaseError.nxcCreate(aField, @rsFltNoFldAccess);

  if aMode <> bmRead then begin
    if (aField.ReadOnly and not (bbsDataset.dsIgnoreReadOnly  > 0)) or aReadOrg then
      raise EnxDatabaseError.nxcCreate(aField, @rsBlobAccessNoMatch);
    if not (bbsDataSet.State in [dsEdit, dsInsert]) then
      raise EnxDatabaseError.nxcCreate(aField, @rsBlobTblNoEdit);
  end;

  bsReadOrg := aReadOrg;
  bsOpened := bbsDataset.dsGetActiveBuffer(bsBuffer);

  if not bsOpened and (aMode <> bmRead) then
    raise EnxDatabaseError.nxcCreate(aField, @rsNoFldBuffAccess);

  bsCacheStatus := DBIERR_NA;
  if bsOpened and aCached then begin
    bsCache := TnxMemoryStream.Create;
    if aMode = bmWrite then begin
      bsCacheStatus := DBIERR_NONE;
      bsModified := True;
    end;
  end else
    if aMode = bmWrite then
      bsNeedsTruncate0 := True;
end;
{------------------------------------------------------------------------------}
destructor TnxBlobStream.Destroy;
begin
  try
    try
      Flush;
    except
      on E: EnxDatabaseError do
        case E.ErrorCode of
          DBIERR_NX_CORRUPTTRANS,
          DBIERR_DEADLOCK: begin
            { ignore, the only thing that can happen later is that the transaction
              is rolled back, as such, not having been able to flush is inconsequential }
          end;
        else
          raise;
        end;
    end;
  finally
    inherited;
    nxFreeAndNil(bsCache);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.Flush;
begin
  if bsOpened then begin
    if bsNeedsTruncate0 then begin
      Truncate;
      bsNeedsTruncate0 := False;
    end;
    if bsModified then begin
      if Assigned(bsCache) and (bbsMode in [bmWrite, bmReadWrite]) then
        bsWriteCache;
      bbsField.Modified := True;
      bbsDataSet.DataEvent(deFieldChange, TnxNativeInt(bbsField));
      bsModified := False;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.GetSize: Int64;
begin
  if Assigned(bsCache) then begin
    bsReadCache;
    Result := bsCache.Size;
  end else
    Result := bsGetBlobSize;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.Read(var aBuffer; aCount: Integer): Integer;
var
  lStatus      : TnxResult;
  lIsNull      : Boolean;
  lBlobNr      : TnxBlobNr;
  lNewBlobNr   : TnxNewBlobNr;
  lRecID       : TnxRecID;

  lOldPos      : TnxWord32;
  lBytesRead   : TnxWord32;
begin
  Result := 0;
  lBytesRead := 0;
  if aCount < 1 then
    Exit;
  if bsOpened then begin
    if bsNeedsTruncate0 then begin
      Truncate;
      bsNeedsTruncate0 := False;
    end;

    if Assigned(bsCache) then begin
      bsReadCache;
      Result := bsCache.Read(aBuffer, aCount);
    end else with bbsDataSet do begin
      lStatus := bbsDataSet.dsGetBlobNr(bsBuffer, bbsField, lIsNull, lBlobNr, lRecID);
      if (lStatus = DBIERR_NONE) and not lIsNull then
        with TnxStaticMemoryStream.Create(@aBuffer, aCount) do try
          if aCount > 0 then begin
            lOldPos := Position;
            repeat
              lNewBlobNr.nbnBlobNr := lBlobNr;
              lNewBlobNr.nbnSet := False;
              lStatus := dsAbstractCursor.BlobRead
                (lRecID, bbsFieldNo, lBlobNr, bsPosition, aCount, TheStream, bsReadOrg, @lNewBlobNr);
              if (lStatus <> DBIERR_NONE) and bsShouldRetry(lStatus, lNewBlobNr) then begin
                Position := lOldPos;
                lStatus := bbsDataSet.dsGetBlobNr(bsBuffer, bbsField, lIsNull, lBlobNr, lRecID);
                if (lStatus = DBIERR_NONE) and not lIsNull then
                  Continue;
                lBytesRead := 0;
                lStatus := DBIERR_INVALIDBLOBOFFSET;
                Break;
              end else begin
                if (lNewBlobNr.nbnSet) and (lBlobNr <> lNewBlobNr.nbnBlobNr) then
                  dsSetBlobNr(bsBuffer, bbsField, lNewBlobNr.nbnBlobNr);
                lBytesRead := TnxWord32(Position) - lOldPos;
                Break;
              end;
            until False;

            case lStatus of
              DBIERR_NONE:
                Inc(bsPosition, lBytesRead);
              DBIERR_INVALIDBLOBOFFSET, DBIERR_KEYORRECDELETED, DBIERR_NOCURRREC: begin
                Result := 0;
                Exit;
              end;
            else
              bbsCheck(lStatus);
            end;
          end;
          Result := Position;
        finally
          Free;
        end;
    end
  end else
    Result := lBytesRead;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.Seek(aOffset: Integer; aOrigin: Word): Integer;
begin
  if Assigned(bsCache) then begin
    bsReadCache;
    Result := bsCache.Seek(aOffset, aOrigin);
  end else begin
    case aOrigin of
      soFromBeginning : bsPosition := aOffset;
      soFromCurrent   : Inc(bsPosition, aOffset);
      soFromEnd       : bsPosition := bsGetBlobSize + TnxInt64(aOffset);
    end;
    Result := bsPosition;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.Seek(const aOffset: Int64; aOrigin: TSeekOrigin): Int64;
begin
  if Assigned(bsCache) then begin
    bsReadCache;
    Result := bsCache.Seek(aOffset, aOrigin);
  end else begin
    case aOrigin of
      soBeginning : bsPosition := aOffset;
      soCurrent   : Inc(bsPosition, aOffset);
      soEnd       : bsPosition := bsGetBlobSize + aOffset;
    end;
    Result := bsPosition;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.SetSize(NewSize: Integer);
begin
  if bbsMode = bmRead then
    bbsCheck(DBIERR_READONLYFLD);

  if bsOpened then begin
    if bsNeedsTruncate0 then begin
      Truncate;
      bsNeedsTruncate0 := False;
    end;

    if Assigned(bsCache) then begin
      bsReadCache(NewSize);
      bsCache.SetSize(NewSize);
    end else
      bbsCheck(bbsDataSet.dsTruncateBlob(bsBuffer, bbsField, NewSize));
    bsModified := true;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.SetSize(const NewSize: Int64);
begin
  if bbsMode = bmRead then
    bbsCheck(DBIERR_READONLYFLD);

  if bsOpened then begin
    if bsNeedsTruncate0 then begin
      Truncate;
      bsNeedsTruncate0 := False;
    end;

    if Assigned(bsCache) then begin
      bsReadCache(NewSize);
      bsCache.SetSize(NewSize);
    end else
      bbsCheck(bbsDataSet.dsTruncateBlob(bsBuffer, bbsField, NewSize));
    bsModified := true;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobStream.Truncate;
begin
  if bbsMode = bmRead then
    bbsCheck(DBIERR_READONLYFLD);

  if bsOpened then begin
    if Assigned(bsCache) then begin
      if bsCacheStatus = DBIERR_NA then
        { we haven't loaded the cache yet, and are truncating down to 0 }
        bsCacheStatus := DBIERR_NONE
      else begin
        bsReadCache(bsCache.Position);
        bsCache.SetSize(bsCache.Position);
      end;
    end else
      bbsCheck(bbsDataSet.dsTruncateBlob(bsBuffer, bbsField, bsPosition));
    bsModified := true;
  end;
end;
{------------------------------------------------------------------------------}
function TnxBlobStream.Write(const aBuffer; aCount: Integer): Integer;
var
  lBlobNr    : TnxBlobNr;
  lNewBlobNr : TnxBlobNr;
  lIsNull    : Boolean;
  lRecID     : TnxRecID;
begin
  Result := 0;
  if (aCount > 0) and bsOpened and (bbsMode <> bmRead) then begin
    if Assigned(bsCache) then begin
      bsReadCache;
      Result := bsCache.Write(aBuffer, aCount);
    end else with bbsDataset do begin
      if bsNeedsTruncate0 then begin
        Assert(bsPosition = 0);
        bbsCheck(dsGetBlobNr(bsBuffer, bbsField, lIsNull, lBlobNr, lRecID));
        lNewBlobNr := lBlobNr;
        bbsCheck(dsAbstractCursor.BlobReplace
          (lRecID, bbsFieldNo, lNewBlobNr, aCount, aBuffer));
        if lNewBlobNr <> lBlobNr then
          dsSetBlobNr(bsBuffer, bbsField, lNewBlobNr);
        bsNeedsTruncate0 := False;
      end else begin
        bbsCheck(dsForceBlobNr(bsBuffer, bbsField, lBlobNr, lRecID));
        bbsCheck(dsAbstractCursor.BlobWrite
          (lRecID, bbsFieldNo, lBlobNr, bsPosition, aCount, aBuffer));
      end;
      Inc(bsPosition, aCount);
      Inc(Result, aCount);
    end;
    bsModified := True;
  end;
end;
{==============================================================================}


{$IFDEF SUPPORTS_CLASS_HELPERS}
{===TnxBlobFieldHelper=========================================================}
function TnxBlobFieldHelper.bfhGetMarked: Boolean;
begin
  Result := (DataSet as TnxDataset).BlobMarked[Self];
end;
{------------------------------------------------------------------------------}
procedure TnxBlobFieldHelper.bfhSetMarked(aValue: Boolean);
begin
  (DataSet as TnxDataset).BlobMarked[Self] := aValue;
end;
{==============================================================================}
{$ENDIF SUPPORTS_CLASS_HELPERS}



{===TnxBlobField===============================================================}
function TnxBlobField.bfGetMarked: Boolean;
begin
  if csLoading in ComponentState then
    Result := bfLoadedMarked
  else
    Result := (DataSet as TnxDataset).BlobMarked[Self];
end;
{------------------------------------------------------------------------------}
procedure TnxBlobField.bfSetMarked(aValue: Boolean);
begin
  if csLoading in ComponentState then
    bfLoadedMarked := aValue
  else
    (DataSet as TnxDataset).BlobMarked[Self] := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxBlobField.Loaded;
begin
  inherited;
  if bfLoadedMarked then
    (DataSet as TnxDataset).BlobMarked[Self] := True;
end;
{==============================================================================}



{===TnxMemoField===============================================================}
procedure TnxMemoField.Bind(Binding: Boolean);
begin
  inherited;
  if Binding then
    if FieldNo >= 0 then
      with TnxDataset(DataSet), dsFieldsDescriptor, FieldDescriptor[Pred(FieldNo)] do begin
        mfIsWide := fdType = nxtBlobWideMemo;
        mfCodePage := UsedStorageCodePage;
      end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC12OrLater}
function TnxMemoField.GetAsAnsiString: AnsiString;
var
  OldTransliterate : Boolean;
begin
  OldTransliterate := Transliterate;
  try
    if mfIsWide then
      Transliterate := True;
    Result := inherited GetAsAnsiString;
  finally
    Transliterate := OldTransliterate;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function TnxMemoField.GetAsString: string;
{$IFNDEF DCC12OrLater}
var
  OldTransliterate : Boolean;
{$ENDIF}
begin
  {$IFDEF DCC12OrLater}
  Result := GetAsWideString;
  {$ELSE}
  OldTransliterate := Transliterate;
  try
    if mfIsWide then
      Transliterate := True;
    Result := inherited GetAsString;
  finally
    Transliterate := OldTransliterate;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxMemoField.GetAsVariant: Variant;
begin
  Result := GetAsWideString;
end;
{------------------------------------------------------------------------------}
function TnxMemoField.GetAsWideString: UnicodeString;
var
  OldTransliterate : Boolean;
  Len              : Integer;
  s                : AnsiString;
begin
  OldTransliterate := Transliterate;
  try
    Transliterate := False;
    with DataSet.CreateBlobStream(Self, bmRead) do try
      if mfIsWide then begin
        Len := Size div SizeOf(WideChar);
        SetLength(Result, Len);
        if Len > 0 then
          ReadBuffer(Result[1], Len * SizeOf(WideChar));
      end else begin
        Len := Size;
        SetLength(s, Len);
        if Len > 0 then
          ReadBuffer(s[1], Len);
        Result := nxStringToDelphiWideString(s, mfCodePage);
      end;
    finally
      Free;
    end;
  finally
    Transliterate := OldTransliterate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxMemoField.Loaded;
begin
  inherited;
  if mfLoadedMarked then
    (DataSet as TnxDataset).BlobMarked[Self] := True;
end;
{------------------------------------------------------------------------------}
function TnxMemoField.mfGetMarked: Boolean;
begin
  if csLoading in ComponentState then
    Result := mfLoadedMarked
  else
    Result := (DataSet as TnxDataset).BlobMarked[Self];
end;
{------------------------------------------------------------------------------}
procedure TnxMemoField.mfSetMarked(aValue: Boolean);
begin
  if csLoading in ComponentState then
    mfLoadedMarked := aValue
  else
    (DataSet as TnxDataset).BlobMarked[Self] := aValue;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC12OrLater}
procedure TnxMemoField.SetAsAnsiString(const Value: AnsiString);
var
  OldTransliterate : Boolean;
begin
  OldTransliterate := Transliterate;
  try
    if mfIsWide then
      Transliterate := True;
    inherited SetAsAnsiString(Value);
  finally
    Transliterate := OldTransliterate;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxMemoField.SetAsString(const Value: string);
{$IFNDEF DCC12OrLater}
var
  OldTransliterate : Boolean;
{$ENDIF}
begin
  {$IFDEF DCC12OrLater}
  SetAsWideString(Value);
  {$ELSE}
  OldTransliterate := Transliterate;
  try
    if mfIsWide then
      Transliterate := True;
    inherited SetAsString(Value);
  finally
    Transliterate := OldTransliterate;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxMemoField.SetAsWideString(const Value: UnicodeString);
var
  OldTransliterate : Boolean;
  s                : AnsiString;
begin
  if Length(Value) > 0 then begin
    OldTransliterate := Transliterate;
    try
      Transliterate := False;
      with DataSet.CreateBlobStream(Self, bmWrite) do try
        if mfIsWide then
          WriteBuffer(Value[1], Length(Value) * SizeOf(WideChar))
        else begin
          s := nxDelphiWideStringToString(Value, mfCodePage);
          WriteBuffer(s[1], Length(s));
        end;
      finally
        Free;
      end;
    finally
      Transliterate := OldTransliterate;
    end;
  end else
    Clear;
end;
{------------------------------------------------------------------------------}
procedure TnxMemoField.SetVarValue(const Value: Variant);
begin
  if nxVarIsEmpty(Value) then
    Clear
  else if (TVarData(Value).VType = varOleStr) {$IFDEF DCC12OrLater} or (TVarData(Value).VType = varUString){$ENDIF} then
    SetAsWideString(Value)
  else
    inherited SetVarValue(Value);
end;
{==============================================================================}


{$IFDEF DCC12OrLater}
{===TnxWideMemoField===========================================================}
procedure TnxWideMemoField.Loaded;
begin
  inherited;
  if wmfLoadedMarked then
    (DataSet as TnxDataset).BlobMarked[Self] := True;
end;
{------------------------------------------------------------------------------}
function TnxWideMemoField.wmfGetMarked: Boolean;
begin
  if csLoading in ComponentState then
    Result := wmfLoadedMarked
  else
    Result := (DataSet as TnxDataset).BlobMarked[Self];
end;
{------------------------------------------------------------------------------}
procedure TnxWideMemoField.wmfSetMarked(aValue: Boolean);
begin
  if csLoading in ComponentState then
    wmfLoadedMarked := aValue
  else
    (DataSet as TnxDataset).BlobMarked[Self] := aValue;
end;
{==============================================================================}
{$ENDIF}


{===TnxGraphicField============================================================}
function TnxGraphicField.gfGetMarked: Boolean;
begin
  if csLoading in ComponentState then
    Result := gfLoadedMarked
  else
    Result := (DataSet as TnxDataset).BlobMarked[Self];
end;
{------------------------------------------------------------------------------}
procedure TnxGraphicField.gfSetMarked(aValue: Boolean);
begin
  if csLoading in ComponentState then
    gfLoadedMarked := aValue
  else
    (DataSet as TnxDataset).BlobMarked[Self] := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxGraphicField.Loaded;
begin
  inherited;
  if gfLoadedMarked then
    (DataSet as TnxDataset).BlobMarked[Self] := True;
end;
{==============================================================================}



{===TnxKeyAsVariantField=======================================================}
constructor TnxKeyAsVariantField.Create(AOwner: TComponent);
begin
  inherited;
  FieldKind := fkCalculated;
  FieldName := '_Key';
end;
{------------------------------------------------------------------------------}
function TnxKeyAsVariantField.GetAsString: string;
var
  v : Variant;
  i : Integer;
begin
  v := GetAsVariant;
  if VarIsArray(v) and not (TVarData(v).VType = varByte) then begin
    Result := '';
    for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
      Result := Result + VarToStr(v[i]) + ', ';
    SetLength(Result, Length(Result) - Length(' ,'));
  end else
    Result := VarToStr(v);
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC10OrLater}
function TnxKeyAsVariantField.GetAsWideString: UnicodeString;
var
  v : Variant;
  i : Integer;
begin
  v := GetAsVariant;
  if VarIsArray(v) and not (TVarData(v).VType = varByte) then begin
    Result := '';
    for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
      Result := Result + VarToWideStr(v[i]) + ', ';
    SetLength(Result, Length(Result) - Length(' ,'));
  end else
    Result := VarToWideStr(v);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function TnxKeyAsVariantField.GetAsVariant: Variant;
begin
  Result := (DataSet as TnxDataset).KeyAsVariant;
end;
{------------------------------------------------------------------------------}
procedure TnxKeyAsVariantField.SetVarValue(const Value: Variant);
begin
  { nothing }
end;
{==============================================================================}



{===TnxStringField===============================================================}
procedure TnxStringField.Bind(Binding: Boolean);
begin
  inherited;
  if Binding then
    if FieldNo >= 0 then
      with TnxDataset(DataSet), dsFieldsDescriptor, FieldDescriptor[Pred(FieldNo)] do begin
        sfCodePage := UsedStorageCodePage;
      end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC12OrLater}
function TnxStringField.GetAsAnsiString: AnsiString;
var
  OldTransliterate : Boolean;
begin
  OldTransliterate := Transliterate;
  try
    Result := inherited GetAsAnsiString;
  finally
    Transliterate := OldTransliterate;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function TnxStringField.GetAsString: string;
{$IFNDEF DCC12OrLater}
var
  OldTransliterate : Boolean;
{$ENDIF}
begin
  {$IFDEF DCC12OrLater}
  Result := GetAsWideString;
  {$ELSE}
  OldTransliterate := Transliterate;
  try
    Result := inherited GetAsString;
  finally
    Transliterate := OldTransliterate;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxStringField.GetAsVariant: Variant;
begin
  Result := GetAsWideString;
  if (Result = '') and IsNull then
    Result := Null;
end;
{------------------------------------------------------------------------------}
function TnxStringField.GetAsWideString: UnicodeString;
var
  OldTransliterate : Boolean;
  s                : AnsiString;
begin
  OldTransliterate := Transliterate;
  try
    Transliterate := False;
    s := {$IFDEF DCC12OrLater}inherited GetAsAnsiString{$ELSE}inherited GetAsString{$ENDIF};
    Result := nxStringToDelphiWideString(s, sfCodePage);
  finally
    Transliterate := OldTransliterate;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC12OrLater}
procedure TnxStringField.SetAsAnsiString(const Value: AnsiString);
var
  OldTransliterate : Boolean;
begin
  OldTransliterate := Transliterate;
  try
    inherited SetAsAnsiString(Value);
  finally
    Transliterate := OldTransliterate;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxStringField.SetAsString(const Value: string);
{$IFNDEF DCC12OrLater}
var
  OldTransliterate : Boolean;
{$ENDIF}
begin
  {$IFDEF DCC12OrLater}
  SetAsWideString(Value);
  {$ELSE}
  OldTransliterate := Transliterate;
  try
    inherited SetAsString(Value);
  finally
    Transliterate := OldTransliterate;
  end;
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxStringField.SetAsWideString(const Value: UnicodeString);
var
  OldTransliterate : Boolean;
  s                : AnsiString;
begin
  OldTransliterate := Transliterate;
  try
    Transliterate := False;
    s := nxDelphiWideStringToString(Value, sfCodePage);
    {$IFDEF DCC12OrLater}inherited SetAsAnsiString(s){$ELSE}inherited SetAsString(s){$ENDIF};
  finally
    Transliterate := OldTransliterate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStringField.SetVarValue(const Value: Variant);
begin
  if nxVarIsEmpty(Value) then
    Clear
  else if (TVarData(Value).VType = varOleStr) {$IFDEF DCC12OrLater} or (TVarData(Value).VType = varUString){$ENDIF} then
    SetAsWideString(Value)
  else
    inherited SetVarValue(Value);
end;
{==============================================================================}



{===TnxLargeintField===========================================================}
function TnxLargeintField.GetAsBCD: TBcd;
begin
  Result := TBcd(nxStrToFmtBcd({$IFDEF DCC12OrLater}GetAsAnsiString{$ELSE}GetAsString{$ENDIF}));
end;
{------------------------------------------------------------------------------}
procedure TnxLargeintField.SetAsBCD(const Value: TBcd);
begin
  SetAsLargeInt({$IFDEF DCC20OrLater}BcdToInt64(Value){$ELSE}nxBcdToInt64(TnxFmtBcd(Value)){$ENDIF});
end;
{==============================================================================}



{===TnxDataset=================================================================}
type
  PnxRecordInfos = ^TnxRecordInfos;
  TnxRecordInfos = packed record
    riRecNo        : TnxWord32;
    riBookmarkFlag : TBookmarkFlag;
  end;
{------------------------------------------------------------------------------}
procedure TnxDataset.AddFileBlob(aField    : TField;
                           const aFileName : string);
begin
  dsCheck(aField, AddFileBlobEx(aField, aFileName));
end;
{------------------------------------------------------------------------------}
function TnxDataset.AddFileBlobEx(aField    : TField;
                            const aFileName : string)
                                            : TnxResult;
var
  IsNull : Boolean;
  BlobNr : TnxBlobNr;
  RecID  : TnxRecID;
  Buffer : TnxRecordBuffer;
begin
  dsStartBusy;
  try
    if aFileName = '' then
      dsError(DBIERR_INVALIDPARAM);

    CheckActive;

    if not (State in dsEditModes - [dsSetKey]) then
      dsError(@rsDataSetNotEditing);
    if not dsGetActiveBuffer(Buffer) then
      dsError(@rsDataSetCantGetBuf);

    if (aField.FieldKind <> fkData) or
      not (dsFieldsDescriptor.FieldDescriptor[Pred(aField.FieldNo)].fdType in
      nxcBlobTypes) then begin
      Result := DBIERR_NOTABLOB;
      Exit;
    end;

    Result := dsGetBlobNr(Buffer, aField, IsNull, BlobNr, RecID);
    if Result <> DBIERR_NONE then
      Exit;

    if not IsNull then begin
      Result := dsTruncateBlob(Buffer, aField, 0);
      if Result <> DBIERR_NONE then
        Exit;

      Result := dsFreeBlob(Buffer, aField);
      if Result <> DBIERR_NONE then
        Exit;
    end;

    Result := dsAbstractCursor.BlobCreateFile(RecID, Pred(aField.FieldNo), aFileName, BlobNr);
    if Result <> DBIERR_NONE then
      Exit;

    dsFieldsDescriptor.SetRecordField(Pred(aField.FieldNo), Pointer(Buffer), @BlobNr);

    (aField as TBlobField).Modified := True;
    TnxDataSet(aField.DataSet).DataEvent(deFieldChange, TnxNativeInt(aField));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.AddBlockReadOption(aOption: TnxRecordGetBatchExOption): Boolean;
begin
  Result := not (aOption in dsBlockReadOptions);
  if Result then
    Include(dsBlockReadOptions, aOption);
end;
{------------------------------------------------------------------------------}
function TnxDataset.AddBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
begin
  Result := (aOptions * dsBlockReadOptions) <> aOptions;
  if Result then
    dsBlockReadOptions := dsBlockReadOptions + aOptions;
end;
{------------------------------------------------------------------------------}
function TnxDataset.AddDataSetOption(aOption: TnxDataSetOption): Boolean;
begin
  Result := not (aOption in dsOptions);
  if Result then
    Options := dsOptions + [aOption];
end;
{------------------------------------------------------------------------------}
function TnxDataset.AddDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
begin
  Result := (aOptions * dsOptions) <> aOptions;
  if Result then
    Options := dsOptions + aOptions;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC16OrLater}
procedure TnxDataset.AfterBookmarkAvailable(var aAvailable: Boolean);
var
  Buffer: TnxRecordBuffer;
begin
  if not aAvailable and
     (State = dsBlockRead) and
     (gboBookmarks in dsBlockReadAccess.bsaOptions) and
     dsGetActiveBuffer(Buffer)
  then
    aAvailable := True;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.AfterSetState;
begin
  {can be overridden}
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.AfterConstruction;
begin
  inherited;
  if not (csLoading in ComponentState) then
    dsCheckDefaults;
end;
{------------------------------------------------------------------------------}
function TnxDataset.AllocRecordBuffer: TnxRecordBuffer;
begin
  Result := dsRecordBufferPool.Alloc;
  {$IFOPT C+}
  Inc(dsRecordBufferCount);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.BatchPost;
var
  i, j       : Integer;
  OffSet     : TnxWord32;
  BlobOffset : Int64;
  CursorID   : TnxCursorID;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckActive;
    if dsBatchAppend < 1 then
      dsError(@rsBeginBatchAppendNotCalled);

    DoBeforePost;

    if Assigned(dsValidationsHandler) then
      dsValidationsHandler.ValidateRecord
        (nil, Pointer(ActiveBuffer));

    if not Assigned(dsBatchAppendData) then begin
      dsBatchAppendData := TnxMemoryStream.Create;
      TnxMemoryStreamHacker(dsBatchAppendData).Capacity := dsBatchAppendCutoff;
      CursorID := 0; {will be overwritten if needed}
      dsBatchAppendData.Write(CursorID,SizeOf(CursorID));
      i := 1;
      dsBatchAppendData.Write(i,SizeOf(i));
      dsBatchAppendStartOffset[0]:=dsBatchAppendData.Position;
    end else begin
      dsBatchAppendData.Position := SizeOf(CursorID);
      dsBatchAppendData.Read(i,SizeOf(i));
      Inc(i);
      dsBatchAppendData.Position := SizeOf(CursorID);
      dsBatchAppendData.Write(i,SizeOf(i));
      dsBatchAppendData.Position := dsBatchAppendData.Size;
    end;

    j := dsRecordLength;
    for i:= Low(dsBatchAppendBlobs) to High(dsBatchAppendBlobs) do
      if Assigned(dsBatchAppendBlobs[i]) then
        if dsBatchAppendBlobs[i].Size > 0 then
          Inc(j, dsBatchAppendBlobs[i].Size + SizeOf(Integer));
    dsBatchAppendData.Write(j, SizeOf(j));

    OffSet := dsBatchAppendData.Position;

    dsBatchAppendData.Write(Pointer(ActiveBuffer)^, dsRecordLength);
    for i:= Low(dsBatchAppendBlobs) to High(dsBatchAppendBlobs) do
      if Assigned(dsBatchAppendBlobs[i]) then
        if dsBatchAppendBlobs[i].Size > 0 then begin
          BlobOffset := dsBatchAppendData.Position;
          dsFieldsDescriptor.SetRecordField(i, PnxRecordBuffer(@dsBatchAppendData.ByteArray[OffSet]), @BlobOffset);
          j := dsBatchAppendBlobs[i].Size;
          dsBatchAppendData.Write(j, SizeOf(j));
          dsBatchAppendData.CopyFrom(dsBatchAppendBlobs[i], 0);
        end;

    SetState(dsBrowse);
    DoAfterPost;

    if dsBatchAppendData.Size > dsBatchAppendCutoff then
      FlushBatchAppend;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC16OrLater}
procedure TnxDataset.BeforeBookmarkAvailable;
begin
  EndDelayedBufferFillingOnOpen;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.BeforeSetState(var Value: TDataSetState);
begin
  if (Value = dsBrowse) and (dsBlockReadSize > 0) and (BlockReadSize > 0) and IsUniDirectional then
    Value := dsBlockRead;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.BeginBatchAppend(aCutoffSize: Integer);
var
  i:integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    Inc(dsBatchAppend);
    SetLength(dsBatchAppendStartOffset, dsBatchAppend);
    SetLength(dsBatchAppendRecordCount, dsBatchAppend);
    if Assigned(dsBatchAppendData) then
    begin
      dsBatchAppendData.Position := SizeOf(TnxCursorID);
      dsBatchAppendData.Read(i,SizeOf(i));
      dsBatchAppendData.Position := dsBatchAppendData.Size;
      dsBatchAppendStartOffset[dsBatchAppend-1]:=dsBatchAppendData.Size;
      dsBatchAppendRecordCount[dsBatchAppend-1]:=i;
    end;
    dsBatchAppendCutoff := aCutoffSize;
    if Assigned(dsBatchAppendData) and
      (dsBatchAppendData.Size > dsBatchAppendCutoff) then
      FlushBatchAppend;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.BlockReadNext;
var
  Error       : TnxResult;
  BRO         : TnxRecordGetBatchExOptions;
  Keys        : TnxDataSetKeyBufferArray;
  FirstCall   : Boolean;
  NextOk      : Boolean;
  lMaxRecords : Integer;
  lPrevBlockReadAccess : TnxBatchStreamAccess;
  lPrevBlockReadEntry  : TnxBatchStreamEntry;
begin
  dsStartBusy;
  try
    lMaxRecords := -1;

    BRO := dsBlockReadOptions;
    if not Assigned(dsSFI.sfiBlobFields) and not dsNoCMR then
      Exclude(BRO, gboBlobs);

    if not (gboBlobs in BRO) then
      Exclude(BRO, gboBlobsOnlyMarked);

    if (gboBlobsOnlyMarked in BRO) and
       not Assigned(dsMarkedBlobsByBlobIdx)
    then begin
      Exclude(BRO, gboBlobs);
      if dsoAutoMarkBlobsOnReadAccess in dsOptions then
        lMaxRecords := 1;
    end;

    if not (gboBlobs in BRO) then begin
      Exclude(BRO, gboBlobNrs);
      Exclude(BRO, gboBlobsOnlyMarked);
    end;

    lPrevBlockReadEntry := dsBlockReadEntry^;
    lPrevBlockReadAccess := nil;
    try
    repeat
      if dsiBlockReadNeedsFirst in dsInternalState then begin
        Exclude(dsInternalState, dsiBlockReadNeedsFirst);
        Include(BRO, gboSetToBeginOrEnd);
        dsBlockReadEof := False;
      end else begin
        Exclude(BRO, gboSetToBeginOrEnd);
        lMaxRecords := -1;
      end;

      if dsBlockReadPos>=dsBlockReadCount then begin
        if dsInternalWriteOnly or dsBlockReadEof then begin
          dsEof^ := True;
          Exit;
        end;

          if not Assigned(lPrevBlockReadAccess) then begin
            lPrevBlockReadAccess := dsBlockReadAccess;
            dsBlockReadAccess := nil;
          end;

        if (dsiInGotoQueuedKeys in dsInternalState) and (Self is TnxIndexDataSet) then begin
          Keys := TnxIndexDataSet(Self).idKeyBufferQueue;
          if dsBlockReadQueuedKeyPos > 0 then
            Keys := Copy(Keys, dsBlockReadQueuedKeyPos, Length(Keys));
        end else
          Keys := nil;

        Error := DBIERR_NONE;
        if (dsiInGotoQueuedKeys in dsInternalState) and (Length(Keys) < 1) then begin
          ClearBuffers;
          Exit;
        end;

        if nxfAllowLocalFilterForRecordGetBatch in nxFeatures then
          Include(BRO, gboAllowClientFilter);

        FirstCall := True;
        if Error = DBIERR_NONE then repeat
          if Length(Keys) > 0 then begin
            Error := dsAbstractCursor.RecordGetForKeyBatch(BlockReadSize, BRO,
              dsBlockReadAccess, Keys, not dsFlipOrder, FirstCall);
          end else begin
            if gboSetToBeginOrEnd in BRO then begin
              if {$IFDEF DCC17OrLater}Length(dsFirstBookmark) > 0{$ELSE}dsFirstBookmark <> nil{$ENDIF} then begin
                DoInternalGotoBookmark({$IFDEF DCC17OrLater}@dsFirstBookmark[0]{$ELSE}dsFirstBookmark{$ENDIF});
                Exclude(BRO, gboSetToBeginOrEnd);
              end;
            end;
            Error := dsAbstractCursor.RecordGetBatch
              (BlockReadSize, BRO, dsBlockReadAccess, lMaxRecords, not dsFlipOrder);
          end;
          Exclude(BRO, gboSetToBeginOrEnd);
          if Error = DBIERR_NX_FilterTimeout then begin
            if dsCancelServerFilter then
              Break
            else
              FirstCall := False;
          end else
            Break;
        until false;

        dsCheck(Error);

        dsBlockReadAccess.Reset(nxfAllowLocalFilterForRecordGetBatch in nxFeatures);
        Error := dsBlockReadAccess.InnerError;
        dsBlockReadCount := dsBlockReadAccess.Count;
        Inc(dsBlockReadQueuedKeyPos, dsBlockReadCount);
        dsBlockReadPos := 0;
        NextOK := dsBlockReadAccess.Next(dsBlockReadEntry, @dsBlockReadPos, @dsBlockReadTotalPos);
        if NextOK then
          dsBlockReadEntryChanged;

        if dsFlipOrder then
          case Error of
            DBIERR_EOF: Error := DBIERR_BOF;
            DBIERR_BOF: Error := DBIERR_EOF;
          end;

        if Error = DBIERR_EOF then begin
          dsBlockReadEof := True;
          if dsBlockReadPos > dsBlockReadCount then begin
            dsEof^ := True;
              if Assigned(lPrevBlockReadAccess) then begin
                nxFreeAndNil(dsBlockReadAccess);
                dsBlockReadAccess := lPrevBlockReadAccess;
                lPrevBlockReadAccess := nil;
                dsBlockReadEntry^ := lPrevBlockReadEntry;
              end;
            Exit;
          end;
        end else if Error <> DBIERR_NX_FilterTimeout then
          dsCheck(Error);

      end else begin
        NextOk := dsBlockReadAccess.Next(dsBlockReadEntry, @dsBlockReadPos, @dsBlockReadTotalPos);
        if NextOK then
          dsBlockReadEntryChanged;
      end;

      if not NextOk then begin
        nxFreeAndNil(dsBlockReadAccess);
        dsBlockReadCount := 0;
        dsBlockReadPos := 0;
        if dsBlockReadEof then begin
          dsEof^ := True;
            if Assigned(lPrevBlockReadAccess) then begin
              dsBlockReadAccess := lPrevBlockReadAccess;
              lPrevBlockReadAccess := nil;
              dsBlockReadEntry^ := lPrevBlockReadEntry;
            end;
          Exit;
        end;
      end;
    until dsBlockReadCount > 0;
    finally
      nxFreeAndNil(lPrevBlockReadAccess);
    end;

    dsBof^ := False;
    ///
    if CalcFieldsSize > 0 then
      GetCalcFields(TempBuffer);

    DataEvent(deDataSetScroll, -1);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.BookmarkValid(aBookmark: TBookmark): Boolean;
begin
  dsStartBusy;
  try
    CheckBiDirectional;

    if not Active or not Assigned(aBookmark) or dsInternalWriteOnly then
      Result := False
    else begin
      CursorPosChanged;
      Result :=
        (dsAbstractCursor.SetToBookmark(Pointer(aBookmark), BookmarkSize) = DBIERR_NONE) and
        (dsAbstractCursor.RecordGet(nxltNoLock, nil) = DBIERR_NONE);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CancelBatchAppend;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if Assigned(dsBatchAppendData) then begin
      Dec(dsBatchAppend);
      if (dsBatchAppend < 1) then begin
        nxFreeAndNil(dsBatchAppendData);
        dsBatchAppendStartOffset := nil;
        dsBatchAppendRecordCount := nil;
      end else begin
        dsBatchAppendData.Size:= dsBatchAppendStartOffset[dsBatchAppend];
        dsBatchAppendData.Position := SizeOf(TnxCursorID);
        dsBatchAppendData.Write(dsBatchAppendRecordCount[dsBatchAppend], SizeOf(Integer));
        dsBatchAppendData.Position := dsBatchAppendData.Size;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CheckFieldCompatibility(aField: TField; aFieldDef: TFieldDef);
begin
  { enforce strict field type matching }
  with aField do
    if (DataType <> aFieldDef.DataType) then
      DatabaseErrorFmt(SFieldTypeMismatch, [DisplayName,
        FieldTypeNames[DataType], FieldTypeNames[aFieldDef.DataType]], Self);

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.ClearCalcFields(aBuffer: TnxRecordBuffer);
begin
  nxFillChar(aBuffer[dsOffsetCalcFlds], CalcFieldsSize, 0);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.ClearMarkedBlobs;
begin
  dsStartBusy;
  try
    nxFreeAndNil(dsMarkedBlobsByFieldName);
    dsMarkedBlobsByBlobIdx := nil;
    if Assigned(dsAbstractCursor) then
      dsAbstractCursor.BlobsSetMarked(dsMarkedBlobsByBlobIdx);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CloseBlob(aField: TField);
begin
  dsCheck(aField, dsFreeBlob(Pointer(ActiveBuffer), aField));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CloseCursor;
var
  SavedBlockReadSize : Integer;
begin
  SavedBlockReadSize := BlockReadSize;
  try
    { inherited calls InternalClose)}
    inherited;
    dsCloseCursorID;
    dsFreeMappers;
  finally
    if not (disShutdownFromCursor in dsInternalState) then begin
      Include(dsInternalState, disClosing);
      try
        dsCursor.Active := False;
      finally
        Exclude(dsInternalState, disClosing);
      end;
    end;
    BlockReadSize := SavedBlockReadSize;
    dsFirstBookmark := nil;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.CompareBookmarks(aBookmark1 : TBookmark;
                                     aBookmark2 : TBookmark)
                                                : Integer;
var
  hResult           : TnxResult;
  ValueRelationship : TnxValueRelationship;
const
  NilCompare: array[Boolean, Boolean] of Integer =
    ((0, 1), (-1, 2));
begin
  dsStartBusy;
  try
    Result := NilCompare[Assigned(aBookMark1), Assigned(aBookMark2)];

    if Result = 2 then begin
      CheckActive;

      hResult := dsAbstractCursor.CompareBookMarks
        (Pointer(aBookMark1), Pointer(aBookMark2), BookmarkSize, ValueRelationship);
      Result := ValueRelationship;

      {$IFDEF RaiseaBookMarksExcept}
      dsCheck(aResult);
      {$ELSE}
      if hResult <> DBIERR_NONE then Result := hResult;
      {$ENDIF}
    end;

    if dsFlipOrder then
      Result := -Result;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CopyRecords(aSrcTable     : TnxDataset;
                                 aCopyBLOBs    : Boolean;
                                 aMaxTransSize : Integer);
const
  BlobCopyMode : array[Boolean] of TnxBlobCopyMode =
    (nxbcmNoCopy, nxbcmCopyFull);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    aSrcTable.CheckBrowseMode;

    if aSrcTable.Session <> Session then
      dsError(DBIERR_NOTSAMESESSION);

    dsCheck(aSrcTable.dsAbstractCursor.CopyRecords
      (dsAbstractCursor, BlobCopyMode[aCopyBLOBs], aMaxTransSize));

    Resync([]);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CopyRecordsEx(aSrcTable       : TnxDataset;
                                   aCopyBLOBs      : Boolean;
                                   aMaxTransSize   : Integer;
                                   aCheckValFields : Boolean);
const
  BlobCopyMode : array[Boolean] of TnxBlobCopyMode =
    (nxbcmNoCopy, nxbcmCopyFull);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    aSrcTable.CheckBrowseMode;

    if aSrcTable.Session <> Session then
      dsError(DBIERR_NOTSAMESESSION);

    dsCheck(aSrcTable.dsAbstractCursor.CopyRecordsEx
      (dsAbstractCursor, BlobCopyMode[aCopyBLOBs], aMaxTransSize, aCheckValFields));

    Resync([]);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxDataset.Create(AOwner: TComponent);
var
  PropInfo: PPropInfo;
const
  IsFieldMask = {$IFDEF CPUX86}$FE000000{$ELSE}$FE00000000000000{$ENDIF};
  FieldNoMask = {$IFDEF CPUX86}$00FFFFFF{$ELSE}$00FFFFFFFFFFFFFF{$ENDIF};
begin
  dsBlockReadEntry := @dsBlockReadEntryData;

  PropInfo := GetPropInfo(TypeInfo(TnxDataset), 'BOF');
  with PropInfo^ do
    {$IFNDEF FPC}
    if (TnxNativeUInt(GetProc) and IsFieldMask) = IsFieldMask then
    {$ENDIF}
      dsBof := Pointer(TnxNativeUInt(Self) + (TnxNativeUInt(GetProc) and FieldNoMask));
  Assert(Assigned(dsBof));

  PropInfo := GetPropInfo(TypeInfo(TnxDataset), 'EOF');
  with PropInfo^ do
    {$IFNDEF FPC}
    if (TnxNativeUInt(GetProc) and IsFieldMask) = IsFieldMask then
    {$ENDIF}
      dsEof := Pointer(TnxNativeUInt(Self) + (TnxNativeUInt(GetProc) and FieldNoMask));
  Assert(Assigned(dsEof));

  PropInfo := GetPropInfo(TypeInfo(TnxDataset), 'BufferCount');
  with PropInfo^ do
    {$IFNDEF FPC}
    if (TnxNativeUInt(GetProc) and IsFieldMask) = IsFieldMask then
    {$ENDIF}
      dsPrivateBufferAccess := Pointer(TnxNativeUInt(Self) + (TnxNativeUInt(GetProc) and FieldNoMask));
  Assert(Assigned(dsPrivateBufferAccess));

  dsFilterResync := True;
  dsFilterResyncDoesFirst := True;
  dsMapperList := TObjectList.Create;
  dsTimeout := -1;
  dsFilterTimeOut := nxDefaultFilterTimeout;
  dsBlockReadOptions := [gboBlobs, gboBookmarks];
  dsClearCursorDependentState;
  dsCursor := dsGetCursorClass.Create(Self);
  dsOptions := [];
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxDataset.CreateBlobStream(aField : TField;
                                     aMode  : TBlobStreamMode)
                                            : TStream;
var
  lFieldDescriptor: TnxFieldDescriptor;
begin
  dsStartBusy;
  try
    CheckActive;

    if not Assigned(aField) then
      dsError(DBIERR_INVALIDPARAM);

    if (aField.FieldKind = fkData) and (aField is TBlobField) then
      lFieldDescriptor := dsFieldsDescriptor.FieldDescriptor[Pred(aField.FieldNo)]
    else
      lFieldDescriptor := nil;

    if not Assigned(lFieldDescriptor) or
       not (lFieldDescriptor.fdType in nxcBlobTypes)
    then
      dsError(DBIERR_NOTABLOB);

    if (State = dsBlockRead) and
       (gboBlobs in dsBlockReadAccess.bsaOptions) and
       (
         not (gboBlobsOnlyMarked in dsBlockReadAccess.bsaOptions) or
         (
           Assigned(dsBlockReadAccess.bsaMarkedBlobs) and
           nxIsBitSet(Pointer(dsBlockReadAccess.bsaMarkedBlobs), dsSFI.sfiFieldsToBlobFields[lFieldDescriptor.Number])
         )
       )
    then
      Result := dsBlockModeBlobStreamClass.Create(TBlobField(aField), aMode)
    else
      if (State = dsInsert) and (dsBatchAppend > 0) then
        Result := dsBatchAppendBlobStreamClass.Create(TBlobField(aField), aMode)
      else
        Result := dsBlobStreamClass.Create(TBlobField(aField), aMode, State = dsOldValue, dsoCachedBlobStreams in dsOptions);

  {$IFNDEF DCC12OrLater}
    if TBlobField(aField).Transliterate {$IFDEF DCC10OrLater} and (TBlobField(aField).BlobType <> ftWideMemo){$ENDIF} then
      Result := dsMemoBlobStreamClass.Create(TBlobField(aField), aMode, TnxBaseBlobStream(Result));
  {$ENDIF}

    if (dsoAutoMarkBlobsOnReadAccess in dsOptions) and
       Assigned(Result) and
       (aMode <> bmWrite)
    then
      BlobMarked[aField] := True;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.CreateFields;
begin
  inherited CreateFields;
{$IFNDEF FPC}
  if dsoAddKeyAsVariantField in dsOptions then
    with TnxKeyAsVariantField.Create(Self) do
      DataSet := Self;
{$ENDIF}
end;
{------------------------------------------------------------------------------}
{$IFNDEF DCC10OrLater}
procedure TnxDataset.DataConvert(aField  : TField;
                                 aSource : Pointer;
                                 aDest   : Pointer;
                                 aToNative: Boolean);
begin
  case aField.DataType of
    ftWideString:
      Pointer(aDest^) := Pointer(aSource^);
  else
    inherited;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
{$IFDEF FPC}
procedure TnxDataset.DataEvent(aEvent: TDataEvent; aInfo: Ptrint);
{$ELSE}
procedure TnxDataset.DataEvent(aEvent: TDataEvent; aInfo: TnxNativeInt);
{$ENDIF}
var
  i : Integer;
begin
  if aEvent = deUpdateState then
    if csDesigning in ComponentState then
      dsActiveDesigntime := Active
    else
      dsActiveRuntime := Active;

  if dsIgnoreDataEvents then
    Exit;

  if aEvent = deUpdateState then
   Exclude(dsInternalState, disAfterUpdateState);

  inherited DataEvent(aEvent, aInfo);

  if aEvent = deUpdateState then begin
    Include(dsInternalState, disAfterUpdateState);
    EndDelayedBufferFillingOnOpen;
  end;

  if aEvent = deUpdateState then begin
    if State = dsEdit then begin
      FreeRecordBuffer(dsOldValuesBuffer);
      dsOldValuesBuffer := AllocRecordBuffer;
      nxMove(Pointer(ActiveBuffer)^, dsOldValuesBuffer^, dsRecordBufferSize);
    end else begin
      FreeRecordBuffer(dsOldValuesBuffer);
      dsOldValuesBuffer := nil;
    end;
    if State <> dsInsert then begin
      for i := Low(dsBatchAppendBlobs) to High(dsBatchAppendBlobs) do
        nxFreeAndNil(dsBatchAppendBlobs[i]);
      dsBatchAppendBlobs := nil;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DeleteRecords;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if State in [dsInsert, dsSetKey] then Cancel;
    CheckBiDirectional;
    CheckBrowseMode;

    if dsInternalWriteOnly then
      Exit;

    DoBeforeScroll;
    try
      dsCheck(dsAbstractCursor.DeleteRecords);
      DoClearAndInternalFirst;
      DataEvent(deDataSetChange, 0);
      DoAfterScroll;
    finally
      dsInsideScroll := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DeleteStream(const aName: string);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.TableStreamDelete(aName));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxDataset.Destroy;
begin
  inherited;
  nxFreeAndNil(dsCursor);
  nxFreeAndNil(dsBlockReadAccess);
  nxFreeAndNil(dsMapperList);
  nxFreeAndNil(dsMarkedBlobsByFieldName);
  sfiFree(dsSFI);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterCancel;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterClose;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterDelete;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterEdit;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterInsert;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterOpen;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsInternalWriteOnly := dsWriteOnly;
  BlockReadSize := dsBlockReadSize;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterPost;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterRefresh;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoAfterScroll;
begin
  Exclude(dsInternalState, dsiInsertSuccessful);
  dsInOperation := dioNone;
  dsInsideScroll := False;
  dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeCancel;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams(True);
  Exclude(dsInternalState, dsiInsertSuccessful);
  inherited;
  dsInOperation := dioCancel;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeClose;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams(True);
  Exclude(dsInternalState, dsiInsertSuccessful);
  inherited;
  dsInOperation := dioClose;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeDelete;
begin
  dsCheckNotInOnFilterRecord;
  CheckBiDirectional;
  if not CanModify then
    DatabaseError(SDataSetReadOnly, Self);

  dsCheckOpenBlobStreams(True);
  Exclude(dsInternalState, dsiInsertSuccessful);
  inherited;
  dsInOperation := dioDelete;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeEdit;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams;
  Exclude(dsInternalState, dsiInsertSuccessful);
  inherited;
  dsInOperation := dioEdit;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeInsert;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams;
  inherited;
  dsInOperation := dioInsert;
  Exclude(dsInternalState, dsiInsertSuccessful);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforePost;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams;
  Exclude(dsInternalState, dsiInsertSuccessful);
  inherited;
  dsInOperation := dioPost;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeRefresh;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams;
  inherited;
  dsInOperation := dioRefresh;
  { only called inside Refresh, in which case:
    UpdateCursorPos is followed by Resync
    Resync always starts with GetRecord(gmCurrent) }
  if not dsNoCMR then
    dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedBySync);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoBeforeScroll;
begin
  dsCheckNotInOnFilterRecord;
  dsCheckOpenBlobStreams;
  inherited;
  if dsInOperation <> dioCancel then
    dsInOperation := dioScroll;
  dsInsideScroll := True;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoClearAndInternalFirst;
begin
  dsStartBusy;
  try
    ClearBuffers;
    InternalFirst;
    GetNextRecord;
    GetNextRecords;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.DoInternalGotoBookmark(aBookmark: Pointer);
begin
  dsCheckNotInOnFilterRecord;

  dsCheck(dsAbstractCursor.SetToBookmark(aBookmark, BookmarkSize));
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsActivateFilter(aFilterID: TnxFilterID): TnxResult;
begin
  Result := dsAbstractCursor.FilterActivate(aFilterID);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsActivateFilters;
begin
  if (dsExprFilter <> 0) then
    dsCheck(dsActivateFilter(dsExprFilter));
  if (dsFuncFilter <> 0) then
    dsCheck(dsActivateFilter(dsFuncFilter));
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsApplyMasterRange(aFollowedByFirst: Boolean): Boolean;
begin
  Result := True;  //..
  { Can be overriden by derived classes. }
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsBatchAppendBlobStreamClass: TnxBatchAppendBlobStreamClass;
begin
  Result := TnxBatchAppendBlobStream;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsBindBlobFields(Binding: Boolean);

  procedure DoBindFields(Fields: TFields);
  var
    lField          : TField;
    lFieldIdx       : Integer;
    lBlobFldIdx     : Integer;
    lIndex          : Integer;
    lRequiredLength : Integer;
    lMarkedCount    : Integer;
  begin
    with dsSFI^ do begin
      lBlobFldIdx := 0;
      lMarkedCount := 0;

      lRequiredLength := Length(sfiBlobFields);
      if lRequiredLength > 0 then
        lRequiredLength := Succ(Pred(lRequiredLength) div 32);
      SetLength(dsMarkedBlobsByBlobIdx, lRequiredLength);

      for lFieldIdx := 0 to Pred(Fields.Count) do begin
        lField := Fields[lFieldIdx];

        if lField is TBlobField then begin

          if not Assigned(dsBlobFields) then
            SetLength(dsBlobFields, Fields.Count);
          dsBlobFields[lBlobFldIdx] := TBlobField(lField);
          Inc(lBlobFldIdx);

          if Assigned(dsMarkedBlobsByFieldName) and
             dsMarkedBlobsByFieldName.Find(lField.FieldName, lIndex)
          then begin
            lIndex := dsFieldToBlobIdx(lField);
            if lIndex >= 0 then begin
              nxSetBit(@dsMarkedBlobsByBlobIdx[0], lIndex);
              Inc(lMarkedCount);
            end;
          end;

        end else if lField.DataType in [ftADT, ftArray] then begin
          {$IFDEF FPC}
          raise Exception.Create('lField types ftADT, ftArray not supported');
          {$ELSE}
          DoBindFields(TObjectField(lField).Fields);
          {$ENDIF}
        end;
      end;
    end;

    SetLength(dsBlobFields, lBlobFldIdx);
    if lMarkedCount < 1 then
      dsMarkedBlobsByBlobIdx := nil;
    if Assigned(dsAbstractCursor) then
      dsAbstractCursor.BlobsSetMarked(dsMarkedBlobsByBlobIdx);
  end;

begin
  dsMarkedBlobsByBlobIdx := nil;
  dsBlobFields := nil;
  if not Binding then
    Exit;
  DoBindFields(Fields);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsBindFields(Binding: Boolean);
var
  KeyAsVariantField : TnxKeyAsVariantField;
begin
  if not Binding then
    dsBindBlobFields(Binding);

  KeyAsVariantField := nil;
  {$IFDEF XE7OrLater}
  if Binding and (dsoAddKeyAsVariantField in Options) then
    KeyAsVariantField := FindField('_Key') as TnxKeyAsVariantField;
  {$ENDIF}
  if Assigned(KeyAsVariantField) then
    KeyAsVariantField.SetDataType(ftVarBytes);
  try
    BindFields(Binding);
  finally
    if Assigned(KeyAsVariantField) then
      KeyAsVariantField.SetDataType(ftVariant);
  end;

  if Binding then
    dsBindBlobFields(Binding);

  dsBindMappers(Binding);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsBindMappers(Binding: Boolean);
var
  Idx, FldIdx : Integer;
  Field       : TField;
begin
  if Binding then
    for Idx := 0 to Pred(Fields.Count) do begin
      Field := Fields[Idx];
      if Field.FieldKind = fkData then begin
        FldIdx := Field.FieldNo;
        if (FldIdx >= 0) and (High(dsMappers) >= FldIdx) and Assigned(dsMappers[FldIdx]) then
          dsMappers[FldIdx].Bind(Field);
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsBlobStreamClass: TnxBlobStreamClass;
begin
  Result := TnxBlobStream;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsBlockModeBlobStreamClass: TnxBlockModeBlobStreamClass;
begin
  Result := TnxBlockModeBlobStream;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsBlockReadEntryChanged;
begin
  CursorPosChanged;
  {can be overridden}
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsCancelServerFilter: Boolean;
begin
  Result := False;
  if Assigned(dsOnServerFilterTimeout) then
    dsOnServerFilterTimeout(Self, Result);
  if dsoFilterTimeoutEventForGetRecord in dsOptions then
    dsLastFilterTimeout := GetTickCount64;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheck(const aErrorCode: TnxResult);
begin
  if aErrorCode <> DBIERR_NONE then
    raise dsExceptionClass.nxcCreate(Self, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheck(aField: TField; const aErrorCode: TnxResult);
begin
  if aErrorCode <> DBIERR_NONE then
    raise dsExceptionClass.nxcCreate(aField, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheckDefaults;
begin
  if not Assigned(Session) then
    Session := TnxBaseSession.DefaultSession;
  if (AliasName = '') and Assigned(Session) and not Assigned(Database) then
    Database := Session.DefaultDatabase;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheckInactiveFromCursor;
begin
  CheckInactive;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheckNotInOnFilterRecord;
begin
  if dsiInOnFilterRecord in dsInternalState then
    if not (dsoIgnoreInFilterRecordState in dsOptions) then
      dsError(@rsInOnFilterRecordNotPossible);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheckOpenBlobStreams(aCanDisableStream: Boolean);
begin
  if aCanDisableStream then
    while Assigned(dsBlobStreamsHead) do
      dsBlobStreamsHead.bbsDisable;

  if Assigned(dsBlobStreamsHead) then
    dsError(@rsMustFreeBlobStreams);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCheckOperation(aOperation  : TDataOperation;
                                      aErrorEvent : TDataSetErrorEvent);
var
  Done   : Boolean;
  Action : TDataAction;
begin
  try
    Done := False;
    repeat
      try
        UpdateCursorPos;
        aOperation;
        Done := True;
      except
        on E: EDatabaseError do
        begin
          Action := daFail;
          if Assigned(aErrorEvent) then aErrorEvent(Self, E, Action);
          if Action = daFail then raise;
          if Action = daAbort then {$IFDEF SUPPORTS_DOTTED_UNITNAMES}System.SysUtils{$ELSE}SysUtils{$ENDIF}.Abort;
        end;
      end;
    until Done;
  finally
    dsInOperation := dioNone;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsClearCursorDependentState;
begin
  ds_Dictionary := nil;
  dsTableDescriptor := nil;
  dsFieldsDescriptor := nil;
  sfiFree(dsSFI);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCloseCursorID;
begin
  dsStartBusy;
  try
    dsClearCursorDependentState;

    dsInternalState := dsInternalState - [
      disJustOpenedCursor,
      disFirstRecordGetNextPriorAfterOpen,
      disGetBookmarkAfterFirst,
      disInGetRecords,
      disInMoveBy,
      disInFilterClientBlockRead,
      disDelayedBufferFillingOnOpen
    ];
    dsExprFilter := 0;
    dsFuncFilter := 0;
    nxFreeAndNil(dsAbstractCursor);
    dsDestroyLookupCursor;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCreateExprFilter(const aText   : string;
                                              aOpts   : TFilterOptions;
                                              aActive : Boolean);
var
  Filter   : TnxBaseFilterDescriptor;
  Status   : TnxResult;
begin
  if dsNoCMR and (dsExprFilter <> 0) then begin
    dsDropFilter(dsExprFilter);
    dsExprFilter := 0;
  end;

  Status := DBIERR_NONE;
  Filter := nil;

  if aText <> '' then try
    case dsFilterType of
{$IFNDEF FPC}
      ftSimple: with TExprParser.Create(Self, aText, aOpts, [], '', nil, FldTypeMap) do try
        {$IFDEF DCC14OrLater}
        Filter := dsGetSimpleExpressionFilterClass.Create(TnxCANExpr(FilterData), nxGetThreadCodePage);
        {$ELSE}
        Filter := dsGetSimpleExpressionFilterClass.Create(PCANExpr(FilterData), nxGetThreadCodePage);
        {$ENDIF}
      finally
        Free;
      end;
{$ENDIF}
      ftSqlWhere:
        Filter := dsGetSqlFilterClass.Create(aText);
    end;

    if dsExprFilter <> 0 then
      if Assigned(Filter) then
        Status := dsAbstractCursor.FilterReplaceCustom(Filter, dsExprFilter, aActive, True)
      else begin
        dsDropFilter(dsExprFilter);
        dsExprFilter := 0;
      end
    else
      if Assigned(Filter) then
        Status := dsAbstractCursor.FilterAddCustom(Filter, dsExprFilter, aActive);

    if not Assigned(Filter) then
      dsError(DBIERR_NOTSUPPORTED, @rsFilterTypeNotSupported);

  finally
    nxFreeAndNil(Filter);
  end else if dsExprFilter <> 0 then begin
    dsDropFilter(dsExprFilter);
    dsExprFilter := 0;
  end;

  dsCheck(Status);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsCreateFuncFilter(aFilterFunc : TnxFilterCallback;
                                        aActive     : Boolean);
begin
  if dsFuncFilter <> 0 then begin
    dsDropFilter(dsFuncFilter);
    dsFuncFilter := 0;
  end;
  if Assigned(aFilterFunc) then
    dsCheck(dsAbstractCursor.FilterAddCallback
      ((Self), aFilterFunc, dsFuncFilter, aActive));
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsCreateLookupFilter(aFields  : TnxFieldList;
                                   const aValues  : Variant;
                                         aOptions : TLocateOptions)
                                                  : TnxBaseFilterDescriptor;
{$IFNDEF FPC}
var
  Idx           : Integer;
  Filter        : TFilterExpr;
  Expr          : PExprNode;
  Node          : PExprNode;
  FilterOptions : TFilterOptions;
{$ENDIF}
begin
{$IFDEF FPC}
  dsError(DBIERR_NOTSUPPORTED, @rsDsCreateLookupFilterNotSupported);
{$ELSE}
  if loCaseInsensitive in aOptions then
    FilterOptions := [foNoPartialCompare, foCaseInsensitive]
  else
    FilterOptions := [foNoPartialCompare];

  Filter := TFilterExpr.Create(Self, FilterOptions, [], '', nil, FldTypeMap);
  try
    Node := nil;
    Expr := nil;

    if aFields.Count = 1 then begin
      if VarIsArray(aValues) then
        Node := Filter.NewCompareNode(TField(aFields[0]), coEQ, aValues[0])
      else
        Node := Filter.NewCompareNode(TField(aFields[0]), coEQ, aValues);
      Expr := Node;
    end else
      for Idx := 0 to Pred(aFields.Count) do begin
        Node := Filter.NewCompareNode(TField(aFields[Idx]), coEQ, aValues[Idx]);
        if Idx = 0 then
          Expr := Node
        else
          Expr := Filter.NewNode(enOperator, coAND, Unassigned, Expr, Node);
      end;

    if Assigned(Node) and (loPartialKey in aOptions) then
      Node^.FPartial := True;

    Result := dsGetSimpleExpressionFilterClass.Create(PCANExpr(Filter.GetFilterData(Expr)), nxGetThreadCodePage);
  finally
    Filter.Free;
  end;
{$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsDeactivateFilter(aFilterID: TnxFilterID): TnxResult;
begin
  Result := dsAbstractCursor.FilterDeactivate(aFilterID);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsDeactivateFilters;
begin
  if (dsExprFilter <> 0) then
    dsCheck(dsDeactivateFilter(dsExprFilter));
  if (dsFuncFilter <> 0) then
    dsCheck(dsDeactivateFilter(dsFuncFilter));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsDestroyLookupCursor;
begin
  { Can be overriden by derived classes. }
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsDropFilter(aFilterID: TnxFilterID): TnxResult;
begin
  Result := dsAbstractCursor.FilterRemove(aFilterID);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsDropFilters;
begin
  if (dsExprFilter <> 0) then begin
    dsCheck(dsDropFilter(dsExprFilter));
    dsExprFilter := 0;
  end;

  if (dsFuncFilter <> 0) then begin
    dsCheck(dsDropFilter(dsFuncFilter));
    dsFuncFilter := 0;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aErrorCode: TnxResult);
begin
  raise dsExceptionClass.nxcCreate(Self, aErrorCode);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aMsg: string);
begin
  raise dsExceptionClass.nxcCreate(Self, aMsg);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aMsg: string; const aArgs: array of const);
begin
  raise dsExceptionClass.nxcCreate(Self, aMsg, aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aErrorCode : TnxResult;
                             const aAltMsg    : string);
begin
       raise dsExceptionClass.nxcCreate(Self, aErrorCode, aAltMsg);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aErrorCode : TnxResult;
                             const aAltMsg    : string;
                             const aArgs      : array of const);
begin
  raise dsExceptionClass.nxcCreate(Self, aErrorCode, aAltMsg, aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aErrorCode : TnxResult;
                                   aAltMsgRes : PResStringRec;
                             const aArgs      : array of const);
begin
  raise dsExceptionClass.nxcCreate(Self, aErrorCode, LoadResString(aAltMsgRes), aArgs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(const aErrorCode : TnxResult;
                                   aAltMsgRes : PResStringRec);
begin
  raise dsExceptionClass.nxcCreate(Self, aErrorCode, LoadResString(aAltMsgRes));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(aMsgRes: PResStringRec);
begin
  raise dsExceptionClass.nxcCreate(Self, LoadResString(aMsgRes));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsEndBusy;
begin
  if dsoTrackBusy in dsOptions then begin
    Dec(dsBusyCount);
    if dsBusyCount < 1 then begin
      dsBusyCount := 0;
      if Assigned(dsOnNoLongerBusy) then
        dsOnNoLongerBusy(Self);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsError(aMsgRes : PResStringRec;
                       const aArgs   : array of const);
begin
  raise dsExceptionClass.nxcCreate(Self, LoadResString(aMsgRes), aArgs);
end;
{------------------------------------------------------------------------------}
class function TnxDataset.dsExceptionClass: EnxDatabaseErrorClass;
begin
  Result := EnxDatabaseError;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsFieldDefCreated(aFieldDef        : TFieldDef;
                                       aFieldDescriptor : TnxFieldDescriptor);
begin
  case aFieldDescriptor.fdType of
    {$IFNDEF NX_ALLOW_RECREV_UPDATE}
    nxtRecRev:
      aFieldDef.InternalCalcField := True;
    {$ENDIF}
    {$IFNDEF NX_ALLOW_REFNR_UPDATE}
    nxtRefNr:
      aFieldDef.InternalCalcField := True;
    {$ENDIF}
    {$IFNDEF NX_ALLOW_LSN_UPDATE}
    nxtInt64:
      if aFieldDescriptor.fdDefaultValue is TnxNextLSNDefaultValueDescriptor then
        aFieldDef.InternalCalcField := True;
    {$ENDIF}
    nxtBcd, nxtFmtBcd: begin
      aFieldDef.Precision := aFieldDescriptor.fdUnits;
      aFieldDef.Size := aFieldDescriptor.fdDecPl;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsFieldToBlobIdx(aField: TField): Integer;
var
  lIndex: Integer;
begin
  Result := -1;
  if not Assigned(dsSFI) or
     not Assigned(dsSFI.sfiFieldsToBlobFields)
  then
    Exit;
  lIndex := Pred(aField.FieldNo);
  if (lIndex >= 0) and (lIndex <= High(dsSFI.sfiFieldsToBlobFields)) then
    Result := dsSFI.sfiFieldsToBlobFields[lIndex];
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsForceBlobNr(aBuffer : Pointer;
                                  aField  : TField;
                              out aBlobNr : TnxBlobNr;
                              out aRecID  : TnxRecID)
                                          : TnxResult;
var
  IsNull  : Boolean;
begin
  aRecID := dsGetRecID(aBuffer);
  dsFieldsDescriptor.GetRecordField(Pred(aField.FieldNo), aBuffer, IsNull, @aBlobNr);
  if IsNull or (aBlobNr = 0) then begin
    Result := dsAbstractCursor.BlobCreate(aRecID, Pred(aField.FieldNo), aBlobNr);
    if Result = DBIERR_NONE then
      dsFieldsDescriptor.SetRecordField(Pred(aField.FieldNo), aBuffer, @aBlobNr);
  end else
    Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsFreeBlob(aBuffer : Pointer;
                               aField  : TField)
                                       : TnxResult;
var
  BlobNr : TnxBlobNr;
  RecID  : TnxRecID;
  IsNull : Boolean;
begin
  Result := dsGetBlobNr(aBuffer, aField, IsNull, BlobNr, RecID);
  if (Result = DBIERR_NONE) and (not IsNull) then begin
    Result := dsAbstractCursor.BlobFree(RecID, Pred(aField.FieldNo), BlobNr);
    if Result = DBIERR_BLOBMODIFIED then begin
      { DBIERR_BLOBMODIFIED has a special meaning here:
        the BLOB was empty and the BLOB number has been deleted at the server;
        the client must set the BLOB field to null. }
      dsFieldsDescriptor.SetRecordField(Pred(aField.FieldNo), aBuffer, nil);
      Result := DBIERR_NONE;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsFreeKeyBuffers;
begin
  { Can be overriden by derived classes. }
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsFreeMappers;
begin
  nxFreeAndNil(dsDefaultValueHandler);
  nxFreeAndNil(dsValidationsHandler);
  dsMapperNexusToVcl := nil;
  dsMapperVclToNexus := nil;
  dsMapperFieldOffset := nil;
  dsMappers := nil;
  dsMapperList.Clear;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetActiveBuffer(var aBuffer: TnxRecordBuffer): Boolean;
begin
  dsBlockReadCurrentError := DBIERR_NA;
  Result := True;
  case State of
    dsBlockRead:
      if (dsiInOnFilterRecord in dsInternalState) and Assigned(dsRecordToFilter) then
        aBuffer := dsRecordToFilter
      else if IsEmpty or not Assigned(dsBlockReadAccess) then begin
        aBuffer := nil;
        Result := False;
      end else begin
        dsBlockReadCurrentError := dsBlockReadEntry.bseResult;
        if dsBlockReadCurrentError = DBIERR_NONE then
          aBuffer := TnxRecordBuffer(dsBlockReadEntry.bseRecord)
        else
          Result := dsGetActiveKeyBufferForBatch(aBuffer);
      end;
    dsBrowse:
      if IsEmpty then begin
        aBuffer := nil;
        Result := False;
      end else
        aBuffer := Pointer(ActiveBuffer);
    dsEdit, dsInsert:
      aBuffer := Pointer(ActiveBuffer);
    dsCalcFields:
      aBuffer := Pointer(CalcBuffer);
    dsFilter:
      aBuffer := dsRecordToFilter;
    dsOldValue: begin
      aBuffer := dsOldValuesBuffer;
      Result := Assigned(aBuffer);
    end;
    dsSetKey:
      Result := dsGetActiveKeyBuffer(aBuffer);
  else
    aBuffer := nil;
    Result := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetActiveKeyBuffer(var aBuffer: TnxRecordBuffer): Boolean;
begin
  aBuffer := nil;
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetActiveKeyBufferForBatch(var aBuffer: TnxRecordBuffer): Boolean;
begin
  aBuffer := nil;
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetBlobMarked(aField: TField): Boolean;
var
  lIndex: Integer;
begin
  Result := False;

  if not (aField is TBlobField) then
    Exit;
  if aField.FieldName = '' then
    Exit;

  if not Assigned(dsMarkedBlobsByFieldName) then
    Exit;

  if Assigned(dsAbstractCursor) then begin
    lIndex := dsFieldToBlobIdx(aField);
    if (lIndex >= 0) and
       Assigned(dsMarkedBlobsByBlobIdx)
    then
      Result := nxIsBitSet(@dsMarkedBlobsByBlobIdx[0], lIndex);
  end else
    Result := dsMarkedBlobsByFieldName.Find(aField.FieldName, lIndex);
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetBlobNr(aBuffer : Pointer;
                                aField  : TField;
                            out aIsNull : Boolean;
                            out aBlobNr : TnxBlobNr;
                            out aRecID  : TnxRecID)
                                        : TnxResult;
begin
     Result := DBIERR_NONE;
     // Cuando se intenta llamar a dsGetRecID y el contenido no es válido se produce una excepción en nxCalcELFHash
     If   State=dsSetKey    //..
     then aIsNull := True
     else begin
          aRecID := dsGetRecID(aBuffer);
          dsFieldsDescriptor.GetRecordField(Pred(aField.FieldNo), aBuffer, aIsNull, @aBlobNr);
          If   not aIsNull and ( aBlobNr=0 )
          then aIsNull := True;
          end;
     If   aIsNull
     then aBlobNr := 0;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetBuffer(Index: Integer): TRecBuf;
begin
  with dsPrivateBufferAccess^ do
    if Index <= High(FBuffers) then
      Result := FBuffers[Index]
    else
      Result := 0;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsNoCMR: Boolean;
begin
  Result :=
    (not (nxfCMR in nxFeatures)) or
    (dsoDisableClientMessageReduction in dsOptions);
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetCurrentTransContext: TnxTransContextBase;
begin
  Result := TransContext;
  if not Assigned(Result) then
    Result := Database;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetCursorClass: TnxCursorClass;
begin
  Result := TnxCursor;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetDataBase: TnxDatabase;
begin
  dsResolveDatabase;
  Result := dsCursor.Database;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetFieldDefClass: TFieldDefClass;
begin
  Result := TFieldDef;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetNextOrPriorRecord(aPrior  : Boolean;
                                           aLock   : TnxLockType;
                                           aBuffer : Pointer)
                                                   : TnxResult;
var
  ExpectedCalls : Integer;

  FailClientFilterFastAdded : Boolean;
  FirstAfterOpen            : Boolean;
  NextOK                    : Boolean;
begin
  if dsoFilterTimeoutEventForGetRecord in dsOptions then
    if dsLastFilterTimeout + dsFilterTimeout < GetTickCount64 then
      if dsCancelServerFilter then begin
        Result := DBIERR_NX_FilterTimeout;
        Exit;
      end;

  FailClientFilterFastAdded := False;
  FirstAfterOpen := disFirstRecordGetNextPriorAfterOpen in dsInternalState;

  if dsInternalWriteOnly then begin
    if aPrior then
      Result := DBIERR_BOF
    else
      Result := DBIERR_EOF;

  end else if
    ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead] * dsInternalState <> []) and
    not FirstAfterOpen
  then with dsPrivateBufferAccess^ do begin

    Assert(aLock = nxltNoLock);
    Assert(Assigned(aBuffer));

    Result := DBIERR_NONE;
    repeat
      repeat
        NextOk := False;
        if dsBlockReadCount = 0 then begin
          if disInMoveBy in dsInternalState then
            ExpectedCalls := Abs(dsMoveByDistance)
          else if disInGetRecords in dsInternalState then
            ExpectedCalls := FBufferCount - FRecordCount
          else
            ExpectedCalls := 1;

          if (dsFilterClientBlockReadCountCr > 0) and dsAbstractCursor.HasActiveLocalFilter then begin
            if ExpectedCalls < dsFilterClientBlockReadCountCr then
              ExpectedCalls := dsFilterClientBlockReadCountCr;
            if dsFilterClientBlockReadCountCr < dsFilterClientBlockReadCountMx then
              dsFilterClientBlockReadCountCr := Min(2 * dsFilterClientBlockReadCountCr, dsFilterClientBlockReadCountMx);
          end;

          if ExpectedCalls < 2 then begin
            dsInternalState := dsInternalState - [disInGetRecords, disInMoveBy, disInFilterClientBlockRead];
            Result := dsGetNextOrPriorRecord(aPrior, aLock, aBuffer);
            Exit;
          end;

          repeat
            nxFreeAndNil(dsBlockReadAccess);
            Result := dsAbstractCursor.RecordGetBatch
              (10 * 1024 * 1024, [gboBookmarks, gboAllowClientFilter, gboUseFilterTimeout], dsBlockReadAccess, ExpectedCalls, not aPrior);
            if Result = DBIERR_NX_FilterTimeout then begin
              if dsCancelServerFilter then
                Break;
            end else
              Break;
          until false;

          if Result = DBIERR_NOTSUPPORTED then begin
            dsInternalState := dsInternalState - [disInGetRecords, disInMoveBy, disInFilterClientBlockRead];
            Result := dsGetNextOrPriorRecord(aPrior, aLock, aBuffer);
            Exit;
          end;

          if Result <> DBIERR_NONE then
            Exit;

          dsBlockReadAccess.Reset;
          Result := dsBlockReadAccess.InnerError;
          dsBlockReadCount := dsBlockReadAccess.Count;

          dsBlockReadPos := 0;
          NextOK := dsBlockReadAccess.Next(dsBlockReadEntry, @dsBlockReadPos);
          dsBlockReadTotalPos := dsBlockReadPos;
          if NextOK then
            dsBlockReadEntryChanged;

          if dsBlockReadCount > 0 then
            if Result = DBIERR_NX_FilterTimeout then
              Result := DBIERR_NONE;

          if (    aPrior and (Result = DBIERR_BOF)) or
             (not aPrior and (Result = DBIERR_EOF))
          then begin
            dsBlockReadEof := True;
            if dsBlockReadPos > dsBlockReadCount then
              Exit;
            Result := DBIERR_NONE;
          end;
        end else
          if dsBlockReadPos < dsBlockReadCount then begin
            NextOk := dsBlockReadAccess.Next(dsBlockReadEntry, @dsBlockReadPos, @dsBlockReadTotalPos);
            if NextOK then
              dsBlockReadEntryChanged;
          end;

        if not NextOk then begin
          nxFreeAndNil(dsBlockReadAccess);
          dsBlockReadCount := 0;
          dsBlockReadPos := 0;
          if dsBlockReadEof then begin
            dsBlockReadEof := False;
            if aPrior then begin
              Result := DBIERR_BOF;
              Exit;
            end else begin
              Result := DBIERR_EOF;
              Exit;
            end;
          end;
        end;
      until dsBlockReadCount > 0;

      if Result <> DBIERR_NONE then
        Exit;

      Assert((dsBlockReadPos > 0) and (dsBlockReadPos <= dsBlockReadCount));
      Assert(Assigned(dsBlockReadEntry.bseRecord));

      Move(dsBlockReadEntry.bseRecord^, aBuffer^, dsRecordLength + BookmarkSize);

      with dsAbstractCursor do
        if IsRemote and not FilterMatchesBuffer(aBuffer) then
          Continue;

      Break;
    until False;
  end else begin
    Result := DBIERR_NONE;
    if (aLock = nxltNoLock) and
       (
         (
           (FilterClientBlockReadCount > 0) and
           dsAbstractCursor.HasActiveLocalFilter
         ) or
         FirstAfterOpen
       )
    then
      FailClientFilterFastAdded :=
        dsAbstractCursor.AddCursorOption(acoFailClientFilterFast);

    try
      repeat

        if (Result = DBIERR_NX_FILTERTIMEOUT) and
           (aLock = nxltNoLock) and
           (FilterClientBlockReadCount > 0) and
           dsAbstractCursor.HasActiveLocalFilter
        then try
          if FailClientFilterFastAdded then begin
            dsAbstractCursor.RemoveCursorOption(acoFailClientFilterFast);
            FailClientFilterFastAdded := False;
          end;

          Include(dsInternalState, disInFilterClientBlockRead);
          if not Assigned(aBuffer) then
            aBuffer := Pointer(TempBuffer);
          if dsFilterClientBlockReadCountMx > 0 then
            dsFilterClientBlockReadCountCr := Min(8, dsFilterClientBlockReadCountMx)
          else
            dsFilterClientBlockReadCountCr := 0;
          Result := dsGetNextOrPriorRecord(aPrior, aLock, aBuffer);
          if Result = DBIERR_NONE then begin
            InternalSetToRecord(aBuffer);
            Include(dsInternalState, disGetBookmarkNotNeeded);
          end;
          Exit;
        finally
          Exclude(dsInternalState, disInFilterClientBlockRead);
          nxFreeAndNil(dsBlockReadAccess);
          dsBlockReadCount := 0;
          dsBlockReadPos := 0;
          dsBlockReadTotalPos := 0;
          dsBlockReadQueuedKeyPos := 0;
          dsBlockReadEof := False;
          dsBlockReadCurrentError := DBIERR_NA;
        end;

        if aPrior then
          Result := dsAbstractCursor.RecordGetPrior(aLock, aBuffer)
        else
          Result := dsAbstractCursor.RecordGetNext(aLock, aBuffer);

        if FirstAfterOpen then begin
          if (Result = DBIERR_NONE) or (Result = DBIERR_NX_FilterTimeout) or (aPrior <> FlipOrder) then
            Exclude(dsInternalState, disFirstRecordGetNextPriorAfterOpen);

          if (Result = DBIERR_NX_FilterTimeout) and
             ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead] * dsInternalState <> [])
          then begin
            if FailClientFilterFastAdded then begin
              dsAbstractCursor.RemoveCursorOption(acoFailClientFilterFast);
              FailClientFilterFastAdded := False;
            end;
            Result := dsGetNextOrPriorRecord(aPrior, aLock, aBuffer);
            Exit;
          end;

          if Result = DBIERR_NONE then
            Include(dsInternalState, disGetBookmarkAfterFirst);
        end;

      until (Result <> DBIERR_NX_FilterTimeout) or dsCancelServerFilter;
    finally
      if FailClientFilterFastAdded then
        dsAbstractCursor.RemoveCursorOption(acoFailClientFilterFast);
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetRecID(aBuffer: Pointer): TnxRecID;
var
  lBookmark: PnxBookmark;
begin
  Result := dsAbstractCursor.acGetRecID(aBuffer);
  if Result.ridRefNr = 0 then begin
    if (State = dsBlockRead) and
       (
         not Assigned(dsBlockReadAccess) or
         not (gboBookmarks in dsBlockReadAccess.bsaOptions)
       )
    then begin
      { leave as 0 , 0 }
    end else if GetBookmarkFlag(aBuffer) = bfCurrent then begin
      lBookmark := PnxBookmark(@PnxByteArray(aBuffer)[dsOffsetBookmark]);
      with lBookmark^ do begin
        if bmHash = 0 then
          Exit;
        if bmKeyLen > (BookmarkSize - nxcl_FixedBookmarkSize) then
          Exit;
        if bmPos <> ippOnKey then
          Exit;
        if bmHash <> nxCalcELFHash(bmIndexID, nxcl_FixedBookmarkSize - SizeOf(bmHash) + bmKeyLen) then
          Exit;
      end;
      Result.ridRefNr := lBookmark.bmRefNr
    end else begin
      if dsiInsertSuccessful in dsInternalState then begin
        { leave as 0 , 0 }
      end else begin
        Result.ridRefNr := -1;
        Result.ridInsertLSN := -1;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetRecord(aLock   : TnxLockType;
                                aBuffer : Pointer)
                                        : TnxResult;
begin
  if dsInternalWriteOnly then
    Result := DBIERR_BOF
  else
    Result := dsAbstractCursor.RecordGet(aLock, Pointer(aBuffer));
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetSession: TnxBaseSession;
begin
  if Assigned(dsCursor.Database) then begin
    if dsSession <> dsCursor.Database.Session then
      Session := dsCursor.Database.Session;
  end;
  Result := dsSession;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetSimpleExpressionFilterClass: TnxSimpleExpressionFilterDescriptorClass;
begin
  if Assigned(dsSimpleExpressionFilterClass) then
    Result := dsSimpleExpressionFilterClass
  else
    Result := nxDefaultSimpleExpressionFilterClass;
  if not Assigned(Result) then
    Result := TnxSimpleExpressionFilterDescriptor;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetSqlFilterClass: TnxSqlFilterDescriptorClass;
begin
  if Assigned(dsSqlFilterClass) then
    Result := dsSqlFilterClass
  else
    Result := nxDefaultSqlFilterClass;
  if not Assigned(Result) then
    Result := TnxSqlFilterDescriptor;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetTimeout: Integer;
begin
  if dsTimeout < 0 then
    if Assigned(dsCursor.crDatabase) then
      Result := dsCursor.crDatabase.soGetTimeout
    else if Assigned(dsSession) then
      Result := dsSession.bsGetTimeout
    else
      Result := nxDefaultTimeOut
  else
    Result := dsTimeout;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetTransContext: TnxTransContext;
begin
  Result := dsCursor.TransContext;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsGetVersion: string;
begin
  Result := Format('%5.4f %s', [nxVersionNumber / 10000.0, nxSpecialString]);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsInitBookmarkSize;
var
  IndexID: Integer;
begin
  if Assigned(TableDescriptor.IndicesDescriptor) then
    dsAbstractCursor.GetIndexID(IndexID)
  else
    IndexID := -1;

  BookmarkSize := dsTableDescriptor.BookmarkSize[IndexID];
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsInitKeyBuffers;
begin
  { Can be overriden by derived classes. }
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsInitMappers;
var
  i      : Integer;
begin
  dsFreeMappers;
  with dsFieldsDescriptor do begin
    SetLength(dsMapperNexusToVcl, Succ(FieldCount));
    SetLength(dsMapperVclToNexus, Succ(FieldCount));
    SetLength(dsMapperFieldOffset, Succ(FieldCount));
    SetLength(dsMappers, Succ(FieldCount));
    for i:= 0 to Pred(FieldCount) do begin
      dsMappers[Succ(i)] := TnxBaseVclFieldMapper.GetMapperForDescriptor
        (FieldDescriptor[i], dsMapperNexusToVcl[Succ(i)], dsMapperVclToNexus[Succ(i)]);
      if Assigned(dsMappers[Succ(i)]) then
        dsMapperList.Add(dsMappers[Succ(i)]);
      dsMapperFieldOffset[Succ(i)] := FieldDescriptor[i].fdOffset;
    end;
  end;
  dsDefaultValueHandler :=
    TnxDefaultValueHandler.CreateFor(dsFieldsDescriptor, aaClient, dsAbstractCursor);
  dsValidationsHandler :=
    TnxValidationsHandler.CreateFor(dsFieldsDescriptor, aaClient, dsAbstractCursor);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsInitOffsets;
begin
  dsOffsetBookmark := dsRecordLength;
  dsOffsetCalcFlds := dsOffsetBookmark + BookmarkSize;
  dsOffsetRecInfos := dsOffsetCalcFlds + CalcFieldsSize;
  dsRecordBufferSize := dsOffsetRecInfos + SizeOf(TnxRecordInfos);
  {$IFOPT C+}
  Assert(dsRecordBufferCount = 0);
  {$ENDIF}
  dsRecordBufferPool := nxGetPool(dsRecordBufferSize);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsInitPersistentFields;
var
  Idx      : Integer;
  FldIdx   : Integer;
begin
  for Idx := 0 to Pred(Fields.Count) do
    with Fields[Idx] do
      if FieldKind = fkData then begin

{$IFDEF FPC}
        FldIdx := FieldDefs.IndexOf(FieldName);
        if FldIdx >= 0 then begin
          if DataType = ftString then
            Size := FieldDefs[FldIdx].Size;

          FldIdx := FieldDefs[FldIdx].FieldNo;
          if (FldIdx >= 0) and (High(dsMappers) >= FldIdx) and Assigned(dsMappers[FldIdx]) then
            dsMappers[FldIdx].Bind(Self.Fields[Idx]);
        end;
{$ELSE}
        FldIdx := FieldDefList.IndexOf(FullName);
        if FldIdx >= 0 then begin
          if DataType = ftString then
            Size := FieldDefList[FldIdx].Size;

          FldIdx := FieldDefList[FldIdx].FieldNo;
          if (FldIdx >= 0) and (High(dsMappers) >= FldIdx) and Assigned(dsMappers[FldIdx]) then
            dsMappers[FldIdx].Bind(Self.Fields[Idx]);
        end;
{$ENDIF}

     end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsIsAliasNameStored: Boolean;
begin
  Result := dsAliasName <> '';
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsIsBusy: Boolean;
begin
  Result := (dsBusyCount > 0) and (dsoTrackBusy in dsOptions);
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsIsDatabaseStored: Boolean;
begin
  Result := (dsAliasName = '') and Assigned(dsCursor.Database)
    and not dsCursor.Database.bdbImplicit;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsIsSessionStored: Boolean;
begin
  Result := Assigned(dsSession) and
    (not Assigned(dsCursor.Database) or dsCursor.Database.bdbImplicit);
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsLocateRecord(const aKeyFields  : string;
                                   const aKeyValues  : Variant;
                                         aOptions    : TLocateOptions;
                                         aSyncCursor : Boolean): Boolean;
var
  Fields          : TnxFieldList;
  Filter          : TnxBaseFilterDescriptor;
  Status          : TnxResult;
begin
  dsStartBusy;
  try
    CheckBrowseMode;
    CursorPosChanged;

    if dsInternalWriteOnly then
      Result := False
    else begin
      Fields := TnxFieldList.Create;
      try
        GetFieldList(Fields, aKeyFields);

        Filter := dsCreateLookupFilter(Fields, aKeyValues, aOptions);
        try
          Status := dsAbstractCursor.SetToFilter(Filter, nil, not dsFlipOrder);
          if (Status = DBIERR_NONE) and not aSyncCursor then
            Status := dsAbstractCursor.RecordGet(nxltNoLock, Pointer(TempBuffer));
        finally
          nxFreeAndNil(Filter);
        end;
      finally
        Fields.Free;
      end;

      case Status of
        DBIERR_NONE:
          Result := True;
        DBIERR_NOCURRREC, DBIERR_RECNOTFOUND:
          Result := False;
      else
        dsCheck(Status);
        Result := False;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsMemoBlobStreamClass: TnxMemoBlobStreamClass;
begin
  Result := TnxMemoBlobStream;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsMoveBuffer(CurIndex, NewIndex: Integer);
var
  Buffer: TRecBuf;
begin
  if (not IsUniDirectional) and (CurIndex <> NewIndex) then
    with dsPrivateBufferAccess^ do begin
      Buffer := FBuffers[CurIndex];
      if CurIndex < NewIndex then
        Move(FBuffers[CurIndex + 1], FBuffers[CurIndex], (NewIndex - CurIndex) * SizeOf(TRecBuf))
      else
        Move(FBuffers[NewIndex], FBuffers[NewIndex + 1], (CurIndex - NewIndex) * SizeOf(TRecBuf));
      FBuffers[NewIndex] := Buffer;
    end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsOnFilterRecordCallback(aRecord: PnxRecordBuffer): Boolean;
var
  SaveState              : TDataSetState;
  lBatchStreamAccess     : TnxBatchStreamAccess;
  lBatchStreamEntry      : PnxBatchStreamEntry;
  lPrevBatchStreamAccess : TnxBatchStreamAccess;
  lPrevBatchStreamEntry  : PnxBatchStreamEntry;
  lNeedBackupTempBuffer  : Boolean;
begin
  Result := True;
  if not Assigned(OnFilterRecord) then
    Exit;

  dsCheckNotInOnFilterRecord;
  Include(dsInternalState, dsiInOnFilterRecord);
  try
    lBatchStreamAccess := TnxBatchStreamAccess.Current;
    if Assigned(lBatchStreamAccess) and (lBatchStreamAccess.Cursor <> dsAbstractCursor) then
      lBatchStreamAccess := nil;
    if not Assigned(lBatchStreamAccess) and (State = dsBlockRead) then
      lBatchStreamAccess := dsBlockReadAccess;

    if Assigned(lBatchStreamAccess) then begin
      lBatchStreamEntry := lBatchStreamAccess.CurrentStreamEntry;
      if Assigned(lBatchStreamEntry) and (lBatchStreamEntry.bseRecord = aRecord) then begin
        // if the filter record callback is triggered out of TnxBatchStreamAccess.Next, we need to be in block read mode,
        // because the record buffer might contain blobs that have been retrieved as part of the batch instead of blob numbers
        lPrevBatchStreamAccess := dsBlockReadAccess;
        lPrevBatchStreamEntry := dsBlockReadEntry;
        try
          dsBlockReadAccess := lBatchStreamAccess;
          dsBlockReadEntry := lBatchStreamEntry;

          lNeedBackupTempBuffer := (State = dsBlockRead) and (lPrevBatchStreamEntry <> dsBlockReadEntry);

          SaveState := SetTempState(dsBlockRead);
          try
            dsRecordToFilter := aRecord;
            if lNeedBackupTempBuffer then begin
              // This happens if the dataset is BlockRead mode and then RecordCount is being called,
              // and optimized using a BatchRead operation. We must preserve the original TempBuffer,
              // because it's currently in use by the actual BlockRead mode
              if not Assigned(dsTempBufferBackup) then
                dsTempBufferBackup := AllocRecordBuffer;

              with dsPrivateBufferAccess^ do
                dsSwitchBuffers(FBuffers[FRecordCount], TRecBuf(dsTempBufferBackup));
            end;
            try
              if CalcFieldsSize > 0 then
                // while in block read mode, calculated fields use the TempBuffer...
                // make sure they are correct
                GetCalcFields(TempBuffer);

              // we are executing OnFilterRecord in dsBlockRead instead of dsFilter,
              // but that should be ok, because the only meaning of dsFilter is to
              // redirect field buffer access to the special Filter buffer, which
              // we aren't going to be using
              OnFilterRecord(Self, Result);
            finally
              if lNeedBackupTempBuffer then
                with dsPrivateBufferAccess^ do
                  dsSwitchBuffers(FBuffers[FRecordCount], TRecBuf(dsTempBufferBackup));
            end;
          finally
            dsRecordToFilter := nil;
            RestoreState(SaveState);
          end;
        finally
          dsBlockReadAccess := lPrevBatchStreamAccess;
          dsBlockReadEntry := lPrevBatchStreamEntry;
        end;
        Exit;
      end;
    end;

    SaveState := SetTempState(dsFilter);
    try
      dsRecordToFilter := aRecord;
      OnFilterRecord(Self, Result);
    finally
      dsRecordToFilter := nil;
      RestoreState(SaveState);
    end;
  finally
    Exclude(dsInternalState, dsiInOnFilterRecord);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsRefreshTimeout;
begin
  if Active then
    dsAbstractCursor.Timeout := dsGetTimeout;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsResolveDatabase;
begin
  if (dsAliasName <> '') and Assigned(dsSession) and
    (not Assigned(dsCursor.Database) or
    not SameText(dsCursor.Database.AliasName, dsAliasName)) then
      dsCursor.Database := dsSession.bsGetImplicitDatabase(dsAliasName);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetActiveDesigntime(const Value: Boolean);
begin
  dsActiveDesigntime := Value;
  if [csLoading, csDesigning] * ComponentState = [csDesigning] then
    Active := dsActiveDesigntime;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetActiveRuntime(const Value: Boolean);
begin
  dsActiveRuntime := Value;
  if [csLoading, csDesigning] * ComponentState = [] then
    Active := dsActiveRuntime;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetAliasName(Value: string);
begin
  Value := Trim(Value);

  if SameText(dsAliasName, Value) then
    dsAliasName := Value
  else begin
    CheckInactive;
    if Value<>'' then
      Database := nil;
    dsAliasName := Value;
    DataEvent(dePropertyChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetBlobMarked(aField: TField; const Value: Boolean);
var
  lIndex          : Integer;
  lRequiredLength : Integer;
begin
  if Assigned(aField) and Assigned(dsAbstractCursor) then begin
    lIndex := dsFieldToBlobIdx(aField);
    if lIndex < 0 then
      Exit;

    if (Assigned(dsMarkedBlobsByBlobIdx) and nxIsBitSet(@dsMarkedBlobsByBlobIdx[0], lIndex))
       =
       Value
    then
      Exit;
  end else
    lIndex := -1;

  if not (aField is TBlobField) then
    Exit;

  if aField.FieldName = '' then
    Exit;

  if Value then begin
    if not Assigned(dsMarkedBlobsByFieldName) then
      dsMarkedBlobsByFieldName := TnxFastStringListIC.CreateSorted(dupIgnore);

    dsMarkedBlobsByFieldName.Add(aField.FieldName);
  end else if Assigned(dsMarkedBlobsByFieldName) then begin
    if dsMarkedBlobsByFieldName.Find(aField.FieldName, lIndex) then
      dsMarkedBlobsByFieldName.Delete(lIndex);
    if dsMarkedBlobsByFieldName.Count = 0 then begin
      nxFreeAndNil(dsMarkedBlobsByFieldName);
      dsMarkedBlobsByBlobIdx := nil;
    end;
  end;

  if lIndex >= 0 then begin
    if Value then begin
      if not Assigned(dsMarkedBlobsByBlobIdx) then with dsSFI^ do begin
        lRequiredLength := Length(sfiBlobFields);
        if lRequiredLength > 0 then
          lRequiredLength := Succ(Pred(lRequiredLength) div 32);
        SetLength(dsMarkedBlobsByBlobIdx, lRequiredLength);
        if lRequiredLength < 1 then
          Exit;
      end;
      nxSetBit(@dsMarkedBlobsByBlobIdx[0], lIndex);
    end else begin
      if Assigned(dsMarkedBlobsByBlobIdx) then
        nxClearBit(@dsMarkedBlobsByBlobIdx[0], lIndex);
    end;
    dsAbstractCursor.BlobsSetMarked(dsMarkedBlobsByBlobIdx);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetBlobNr(aBuffer : Pointer;
                                 aField  : TField;
                                 aBlobNr : TnxBlobNr);
begin
  with dsFieldsDescriptor do
    if aBlobNr <> 0 then
      SetRecordField(Pred(aField.FieldNo), aBuffer, @aBlobNr)
    else
      SetRecordField(Pred(aField.FieldNo), aBuffer, nil);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetDataBase(const Value: TnxDatabase);
begin
  if dsCursor.Database <> Value then begin
    CheckInactive;
    if Assigned(Value) then begin
      Session := Value.Session;
      dsCursor.Database := nil;
      if Value.bdbImplicit then
        AliasName := Value.AliasName
      else
        AliasName := '';
      dsCursor.Database := Value;
    end else begin
      if Assigned(dsCursor.Database) then
        Session := dsCursor.Database.Session;
      dsCursor.Database := nil;
      AliasName := '';
    end;
    DataEvent(dePropertyChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFilterClientBlockReadCount(const Value: Integer);
begin
  if Value <> dsFilterClientBlockReadCountMx then begin
    dsFilterClientBlockReadCountMx := Value;
    if dsFilterClientBlockReadCountMx > 0 then
      dsFilterClientBlockReadCountCr := Min(8, dsFilterClientBlockReadCountMx)
    else
      dsFilterClientBlockReadCountCr := 0;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFilterData(aType : TnxFilterType;
                               const aText : string;
                                     aOpts : TFilterOptions);
begin
  dsStartBusy;
  try
    if (dsFilterType <> aType) or (Filter <> aText) or (FilterOptions <> aOpts) then begin
      CheckBiDirectional;
      if Active then begin
        CheckBrowseMode;
        dsDestroyLookupCursor;
        dsFilterType := aType;

        if Filtered and
           not dsNoCMR and
           dsFilterResync and
           not dsInternalWriteOnly
        then if dsFilterResyncDoesFirst then
          dsAbstractCursor.AddCursorOption(acoFilterActionFollowedByFirst)
        else
          dsAbstractCursor.AddCursorOption(acoFilterActionFollowedBySync);

        try

          dsCreateExprFilter(aText, aOpts, Filtered and not dsNoCMR);
          if Filtered and dsNoCMR and (dsExprFilter <> 0) then
            dsActivateFilter(dsExprFilter);

        finally

          dsAbstractCursor.RemoveCursorOptions([
            acoFilterActionFollowedByFirst,
            acoFilterActionFollowedBySync
          ]);

        end;

      end else
        dsFilterType := aType;

      inherited SetFilterText(aText);
      inherited SetFilterOptions(aOpts);
    end;
    if Active and Filtered and dsFilterResync and not dsInternalWriteOnly then
      if dsFilterResyncDoesFirst then
        First
      else
        Resync([]);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFilterTimeout(aTimeout: TnxWord32);
begin
  if dsFilterTimeout <> aTimeout then begin
    dsFilterTimeout := aTimeout;
    if Active then
      dsAbstractCursor.FilterSetTimeout(aTimeout);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFilterType(const Value: TnxFilterType);
begin
  dsCheckNotInOnFilterRecord;
  dsSetFilterData(Value, Filter, FilterOptions);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFirstBookmark(const aFirstBookmark: TBookmark);
begin
  if {$IFDEF DCC17OrLater}Length(aFirstBookmark) < 1{$ELSE}aFirstBookmark = nil{$ENDIF} then begin
    dsFirstBookmark := nil;
    Exit;
  end;

  CheckActive;

  {$IFDEF DCC17OrLater}
  if Length(aFirstBookmark) <> BookmarkSize then
    dsCheck(DBIERR_INVALIDBOOKMARK);
  {$ENDIF}

  dsCheck(dsAbstractCursor.BookmarkCheckLocal({$IFDEF DCC17OrLater}@aFirstBookmark[0]{$ELSE}PnxBookmarkBuffer(@aFirstBookmark){$ENDIF}, BookmarkSize));

  dsFirstBookmark := aFirstBookmark;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFlipOrder(const Value: Boolean);
begin
  dsStartBusy;
  try
    if dsFlipOrder <> Value then begin
      if not (State in [dsInactive, dsOpening]) then begin
        dsCheckNotInOnFilterRecord;
        CheckBrowseMode;
        UpdateCursorPos;
        dsFlipOrder := Value;
        if dsFlipOrder then
          dsAbstractCursor.AddCursorOption(acoFlipOrder)
        else
          dsAbstractCursor.RemoveCursorOption(acoFlipOrder);
        Resync([]);
      end else
        dsFlipOrder := Value;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetFlipOrderNoRefresh(const Value: Boolean);
begin
  if dsFlipOrder <> Value then begin
    if not (State in [dsInactive, dsOpening]) then begin
      dsFlipOrder := Value;
      if dsFlipOrder then
        dsAbstractCursor.AddCursorOption(acoFlipOrder)
      else
        dsAbstractCursor.RemoveCursorOption(acoFlipOrder);
    end else
      dsFlipOrder := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetOptions(Value: TnxDataSetOptions);
var
  AddedOptions   : TnxDataSetOptions;
  RemovedOptions : TnxDataSetOptions;
  ChangedOptions : TnxDataSetOptions;
begin
  if not (dsoTrackBusy in Value) then
    Exclude(Value, dsoFilterTimeoutEventForGetRecord);

  if Value <> dsOptions then begin

    AddedOptions := Value - dsOptions;
    RemovedOptions := dsOptions - Value;
    ChangedOptions := AddedOptions + RemovedOptions;

    if [dsoOptimisticLocks] * ChangedOptions <> [] then
      if State in dsEditModes then
        dsError(@rsDataSetEditing);

    if [dsoAddKeyAsVariantField] * ChangedOptions <> [] then
      CheckInactive;

    dsOptions := Value;

    if dsoTrackBusy in ChangedOptions then
      dsBusyCount := 0;

    if Assigned(dsAbstractCursor) and
       (dsoPreCacheMarkedBlobs in ChangedOptions)
    then
      if dsoPreCacheMarkedBlobs in dsOptions then
        dsAbstractCursor.AddCursorOption(acoPreCacheMarkedBlobs)
      else
        dsAbstractCursor.RemoveCursorOption(acoPreCacheMarkedBlobs);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetSession(const Value: TnxBaseSession);
begin
  if Value <> dsSession then begin
    if Assigned(dsCursor.Database) and
      (Value = dsCursor.Database.Session) then begin

        if Assigned(dsSession) then
          dsSession.RemoveFreeNotification(Self);

        dsSession := dsCursor.Database.Session;

        if Assigned(dsSession) then
          dsSession.FreeNotification(Self);

        DataEvent(dePropertyChange, 0);

        Exit;
      end;

    CheckInactive;

    if Assigned(dsSession) then
      dsSession.RemoveFreeNotification(Self);

    if not Assigned(dsCursor.Database) or
      (Value <> dsCursor.Database.Session) then begin
        if (dsAliasName =  '') and Assigned(Value) then
          dsCursor.Database := Value.DefaultDatabase
        else
          dsCursor.Database := nil;

        if Assigned(dsCursor.Database) then
          if dsCursor.Database.bdbImplicit then
            dsAliasName := dsCursor.Database.AliasName
          else
            dsAliasName := '';
      end;

    dsSession := Value;

    if Assigned(dsSession) then
      dsSession.FreeNotification(Self);

    DataEvent(dePropertyChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetTableLock(aLockType: TnxLockType; aLock: Boolean);
begin
  dsStartBusy;
  try
    if aLock then
      dsCheck(dsAbstractCursor.TableLockAcquire(aLockType))
    else
      dsCheck(dsAbstractCursor.TableLockRelease(aLockType, False));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetTimeout(const Value: Integer);
begin
  if dsTimeout <> Value then begin
    dsTimeout := Value;
    dsRefreshTimeout;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetTransContext(const Value: TnxTransContext);
begin
  if dsCursor.TransContext <> Value then begin
    if Active then
      CheckBrowseMode;

    dsCursor.TransContext := Value;
    DataEvent(dePropertyChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetupCursorDependentState;
begin
  ds_Dictionary := dsAbstractCursor._Dictionary;
  dsTableDescriptor := dsAbstractCursor.TableDescriptor;
  dsFieldsDescriptor := dsTableDescriptor.FieldsDescriptor;
  dsFieldsDescriptor.GetSpecialFieldsInfo(dsSFI);

  { this has always been the behavior even before the options were added, always set it }
  dsAbstractCursor.AddCursorOption(acoRecordGetFollowedByGetBookmark);
  if dsoPreCacheMarkedBlobs in dsOptions then
    dsAbstractCursor.AddCursorOption(acoPreCacheMarkedBlobs)
  else
    dsAbstractCursor.RemoveCursorOption(acoPreCacheMarkedBlobs);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsSetVersion(const Value: string);
begin
  {do nothing}
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsShutdownFromCursor;
begin
  if not (disClosing in dsInternalState) then begin
    Include(dsInternalState, disShutdownFromCursor);
    try
      Active := False;
    finally
      Exclude(dsInternalState, disShutdownFromCursor);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsStartBusy;
begin
  if dsoTrackBusy in dsOptions then begin
    Inc(dsBusyCount);
    if dsBusyCount = 1 then
      dsLastFilterTimeout := GetTickCount64;
  end;
end;
{------------------------------------------------------------------------------}
class procedure TnxDataset.dsSwitchBuffers(var a, b: TRecBuf);
begin
  a := a xor b;
  b := a xor b;
  a := a xor b;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.dsTransContextChanged;
var
  lTransContext: TnxAbstractTransContext;
begin
  if Assigned(dsAbstractCursor) then begin
    lTransContext := nil;
    if Assigned(TransContext) then
      lTransContext := TransContext.tcAbstractTransContext;
    dsCheck(dsAbstractCursor.TransContextSet(lTransContext));
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.dsTruncateBlob(aBuffer : Pointer;
                                   aField  : TField;
                                   aLength : Integer)
                                           : TnxResult;
var
  BlobNr : TnxBlobNr;
  RecID  : TnxRecID;
  IsNull : boolean;
begin
  Result := dsGetBlobNr(aBuffer, aField, IsNull, BlobNr, RecID);
  if Result = DBIERR_NONE then
    if IsNull then
      if aLength <> 0 then
        Result := DBIERR_INVALIDBLOBOFFSET
      else
        Result := DBIERR_NONE
    else
      Result := dsAbstractCursor.BlobTruncate(RecID, Pred(aField.FieldNo), BlobNr, aLength);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.EndBatchAppend;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    Dec(dsBatchAppend);
    if dsBatchAppend < 1 then begin
      dsBatchAppend := 0;
      FlushBatchAppend;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.EndDelayedBufferFillingOnOpen;
begin
  if disDelayedBufferFillingOnOpen in dsInternalState then
    {$IFDEF SUPPORTS_INLINE}
    InnerEndDelayedBufferFillingOnOpen;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InnerEndDelayedBufferFillingOnOpen;
begin
    {$ENDIF}
  if not (State in [dsInactive, dsOpening]) then begin
    Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
    ClearBuffers;
    dsPrivateBufferAccess^.FBufferCount := 0;
    {$IFNDEF FPC} //TODO check usage
    UpdateBufferCount;
    dsBof^ := True;
    {$ENDIF}
    if disAfterUpdateState in dsInternalState then
      inherited DataEvent(deLayoutChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.Exists: Boolean;
begin
  Result := Active;
end;
{------------------------------------------------------------------------------}
function TnxDataset.FindRecord(aRestart, aGoForward: Boolean): Boolean;
begin
  dsStartBusy;
  try
    if dsFlipOrder then
      aGoForward := not aGoForward;

    CheckBrowseMode;
    DoBeforeScroll;
    try
      SetFound(False);
      if dsInternalWriteOnly then
        Result := False
      else begin
        if dsNoCMR or (not aRestart) then
          UpdateCursorPos;

        CursorPosChanged;
        if not Filtered then
          dsActivateFilters;
        try
          if not dsNoCMR then
            { if dsGetNextOrPriorRecord switches to bulk reading because of a
              active client side filter and FilterClientBlockReadCount > 0,
              then it will most likely end in a SetToBookmark call, for which we
              can use a multipart reply to optimize the Resync below }
            dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGet);

          if aGoForward then begin
            if aRestart then begin
              if {$IFDEF DCC17OrLater}Length(dsFirstBookmark) > 0{$ELSE}dsFirstBookmark <> nil{$ENDIF} then begin
                if not dsNoCMR then
                  dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGetNext);
                DoInternalGotoBookmark({$IFDEF DCC17OrLater}@dsFirstBookmark[0]{$ELSE}dsFirstBookmark{$ENDIF});
              end else begin
                if not dsNoCMR then
                  dsAbstractCursor.AddCursorOption(acoSetToBeginFollowedByRecordGetNext);
                dsCheck(dsAbstractCursor.SetToBegin);
              end;
            end;
            Result := dsGetNextOrPriorRecord(False, nxltNoLock, nil) = DBIERR_NONE;
          end else begin
            if aRestart then begin
              if not dsNoCMR then
                dsAbstractCursor.AddCursorOption(acoSetToEndFollowedByRecordGetPrior);
              dsCheck(dsAbstractCursor.SetToEnd);
            end;
            Result := dsGetNextOrPriorRecord(True, nxltNoLock, nil) = DBIERR_NONE;
          end;
        finally
          if not Filtered then
            dsDeactivateFilters;
          dsAbstractCursor.RemoveCursorOptions([acoSetToBookmarkFollowedByRecordGet, acoSetToBookmarkFollowedByRecordGetNext]);
        end;
        if Result then begin
          Resync([rmExact, rmCenter]);
          SetFound(True);
          DoAfterScroll;
        end;
      end;
    finally
      dsInsideScroll := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.First;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if dsNoCMR then
      inherited First
    else begin
      CheckBrowseMode;
      DoBeforeScroll;
      try
        ClearBuffers;
        if IsUniDirectional then begin
          ResetBlockReadStream;
        end else begin
          InternalFirst;
          if GetNextRecord then
            GetNextRecords;
        end;
      finally
        dsBOF^ := True;
        DataEvent(deDataSetChange, 0);
        DoAfterScroll;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.FlushBatchAppend;
var
  Error: TnxResult;
  i: integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    if Assigned(dsBatchAppendData) then begin
      dsBatchAppendData.Position := 0;
      Error := dsAbstractCursor.RecordInsertBatch(dsBatchAppendData);
      nxFreeAndNil(dsBatchAppendData);
      for I := 0 to dsBatchAppend-1 do
      begin
        dsBatchAppendStartOffset[i]:=0;
        dsBatchAppendRecordCount[i]:=0;
      end;
      dsCheck(Error);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.FreeFieldBuffers;
var
  CancelBlobs  : Boolean;
  Result       : TnxResult;
  FieldIdx     : Integer;
  BlobFields   : array of TBlobField;
  BlobFieldIdx : Integer;
  Buffer       : TnxRecordBuffer;
  RefNr        : TnxRefNr;
begin
  CancelBlobs := Assigned(AbstractCursor) and (accCancelBlobs in AbstractCursor.Capabilities);
  if CancelBlobs and
     (
       (accCaching in AbstractCursor.Capabilities) or
       not dsNoCMR
     )
  then begin
    BlobFields := nil;
    if CancelBlobs then begin
      SetLength(BlobFields, Fields.Count);
      BlobFieldIdx := 0;
      for FieldIdx := 0 to Pred(Fields.Count) do
        if (Fields[FieldIdx] is TBlobField) then
          if TBlobField(Fields[FieldIdx]).Modified then begin
            BlobFields[BlobFieldIdx] := TBlobField(Fields[FieldIdx]);
            Inc(BlobFieldIdx);
          end;
      SetLength(BlobFields, BlobFieldIdx);
      CancelBlobs := BlobFieldIdx > 0;
    end;

    if CancelBlobs and dsGetActiveBuffer(Buffer) then begin
      if GetBookmarkFlag(Buffer) = bfCurrent then
        RefNr := PnxBookmark(@Buffer[dsOffsetBookmark]).bmRefNr
      else
        RefNr := -1;

      if RefNr <> 0 then begin
        Result := dsAbstractCursor.BlobsCancel(RefNr);
        if dsoOptimisticLocks in dsOptions then
          if (Result = DBIERR_KEYORRECDELETED) or
             (Result = DBIERR_NOCURRREC) then
          Result := DBIERR_NONE;
        if not dsDeactivating then
          dsCheck(Result);
        for BlobFieldIdx := Low(BlobFields) to High(BlobFields) do
          BlobFields[BlobFieldIdx].Modified := False;
      end;
    end;
  end;

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.FreeRecordBuffer(var aBuffer: TnxRecordBuffer);
begin
  {$IFOPT C+}
  if Assigned(aBuffer) then
    Dec(dsRecordBufferCount);
  {$ENDIF}
  dsRecordBufferPool.Dispose(aBuffer);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.GetAutoIncValue(out aValue       : TnxWord32;
                                         aAllowCached : Boolean = False);
begin
  CheckActive;
  dsCheck(dsAbstractCursor.AutoIncGet(aValue, aAllowCached));
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetAutoIncValue(aAllowCached : Boolean = False): TnxWord32;
begin
  GetAutoIncValue(Result, aAllowCached);
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetBookmark: TBookmark;
var
  Buffer: TnxRecordBuffer;
begin
  if State = dsBlockRead then begin
    if not (gboBookmarks in dsBlockReadAccess.bsaOptions) then
      dsError(DBIERR_NOTSUPPORTED, @rsGetBookmarkIsNotSupported);
    if dsGetActiveBuffer(Buffer) then begin
      {$IFDEF DCC12OrLater}
      SetLength(Result, BookmarkSize);
      {$ELSE}
      GetMem(Result, BookmarkSize);
      {$ENDIF};
      GetBookmarkData(Buffer, Result);
    end else
      Result := nil;
  end else
    Result := inherited GetBookmark;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxDataset.GetBookmarkData(aBuffer: TnxRecordBuffer; aData: TBookmark);
begin
  Assert(Length(aData) = BookmarkSize);
  nxMove(aBuffer[dsOffsetBookmark], aData[0], BookmarkSize);
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.GetBookmarkData(aBuffer: TnxRecordBuffer; aData: Pointer);
begin
  nxMove(aBuffer[dsOffsetBookmark], aData^, BookmarkSize);
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetBookmarkFlag(aBuffer: TnxRecordBuffer): TBookmarkFlag;
begin
  if State = dsBlockRead then
    Result := bfCurrent
  else
    Result := PnxRecordInfos(aBuffer + dsOffsetRecInfos)^.riBookmarkFlag
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetBookmarkStr: TBookmarkStr;
var
  Buffer: TnxRecordBuffer;
begin
  if State = dsBlockRead then begin
    if not (gboBookmarks in dsBlockReadAccess.bsaOptions) then
      dsError(DBIERR_NOTSUPPORTED, @rsGetBookmarkStrIsNotSupported);
    if dsGetActiveBuffer(Buffer) then begin
      SetLength(Result, BookmarkSize);
      GetBookmarkData(Buffer, Pointer(Result));
    end else
      Result := '';
  end else
    Result := inherited GetBookmarkStr;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetBookmarkTemplate: {$IFDEF Unicode}TBookmark{$ELSE}TBookmarkStr{$ENDIF};
begin
  CheckActive;
  {$IFDEF Unicode}
  Result := nil;
  SetLength(Result, BookmarkSize);
  if Assigned(Result) then
    dsCheck(dsAbstractCursor.BookmarkClear(PnxBookmarkBuffer(@Result[0]), BookmarkSize));
  {$ELSE}
  Result := '';
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetCacheInfo(out aCacheInfo: TnxRecordCacheInfo): Boolean;
var
  Buffer: TnxRecordBuffer;
begin
  dsStartBusy;
  try
    Result :=
      Active and
      dsGetActiveBuffer(Buffer) and
      (dsAbstractCursor.ExtractCacheInfo(Pointer(Buffer), aCacheInfo) = DBIERR_NONE);
    if not Result then
      rciClear(aCacheInfo);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetCacheInfo: TnxRecordCacheInfo;
begin
  GetCacheInfo(Result);
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetCanModify: Boolean;
begin
  Result := False; { Can be overridden by derived classes. }
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetCurrentRecord(aBuffer: TnxRecordBuffer): Boolean;
begin
  dsStartBusy;
  try
    if (not dsInternalWriteOnly) and (not IsEmpty) and (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then begin
      UpdateCursorPos;
      Result := dsAbstractCursor.RecordGet(nxltNoLock, Pointer(aBuffer))
        = DBIERR_NONE;
    end else
      Result := False;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  case FieldType of
    ftMemo    : Result := TnxMemoField;
    {$IFDEF DCC12OrLater}
    ftString  : Result := TnxStringField;
    {$ENDIF}
    {$IFDEF DCC14OrLater}
    ftAutoInc : Result := TUnsignedAutoIncField;
    {$ENDIF}
    ftLargeint: Result := TnxLargeintField;
  else
    Result := inherited GetFieldClass(FieldType);
  end;
  if Result = TBlobField then
    Result := TnxBlobField
  else if Result = TMemoField then
    Result := TnxMemoField
  {$IFDEF DCC12OrLater}
  else if Result = TWideMemoField then
    Result := TnxWideMemoField
  {$ENDIF}
  else if Result = TGraphicField then
    Result := TnxGraphicField;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
function TnxDataset.GetFieldData(aField  : TField;
  {$IFDEF XE4OrLater}var{$ENDIF} aBuffer : TValueBuffer)
                                         : Boolean;
var
  RecordBuffer   : TnxRecordBuffer;
  hFieldNo       : Integer;
begin
  Result := False;
  if not dsGetActiveBuffer(RecordBuffer) then
    Exit;
  with aField do begin
    hFieldNo := FieldNo;
    if hFieldNo > 0 then begin
      Result := not dsFieldsDescriptor.IsRecordFieldNull(Pred(hFieldNo), Pointer(RecordBuffer));
      if Result and Assigned(aBuffer) then begin
        Inc(RecordBuffer, dsMapperFieldOffset[hFieldNo]);
        dsMapperNexusToVcl[hFieldNo](RecordBuffer^, aBuffer[0]);
      end;
    end else {hFieldNo <= 0}
      if State in [dsBrowse, dsEdit, dsInsert, dsCalcFields, dsBlockRead] then begin
        if State = dsBlockRead then
          RecordBuffer := Pointer(TempBuffer);
        Inc(RecordBuffer, dsOffsetCalcFlds + Offset);
        Result := (Byte(RecordBuffer[0]) and 1) <> 0;
        if Result and (aBuffer <> nil) then
          nxMove(RecordBuffer[1], aBuffer[0], Min(DataSize, Length(aBuffer)));
      end;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
function TnxDataset.GetFieldData(aField  : TField;
                                 aBuffer : Pointer)
                                         : Boolean;
var
  RecordBuffer   : TnxRecordBuffer;
  hFieldNo       : Integer;
begin
  Result := False;
  if not dsGetActiveBuffer(RecordBuffer) then
    Exit;
  with aField do begin
    hFieldNo := FieldNo;
    if hFieldNo > 0 then begin
      Result := not dsFieldsDescriptor.IsRecordFieldNull(Pred(hFieldNo), Pointer(RecordBuffer));
      if Result and Assigned(aBuffer) then begin
        Inc(RecordBuffer, dsMapperFieldOffset[hFieldNo]);
        dsMapperNexusToVcl[hFieldNo](RecordBuffer^, aBuffer^);
      end;
    end else {hFieldNo <= 0}
      if State in [dsBrowse, dsEdit, dsInsert, dsCalcFields, dsBlockRead] then begin
        if State = dsBlockRead then
          RecordBuffer := Pointer(TempBuffer);
        Inc(RecordBuffer, dsOffsetCalcFlds + Offset);
        Result := (Byte(RecordBuffer[0]) and 1) <> 0;
        if Result and (aBuffer <> nil) then
          nxMove(RecordBuffer[1], aBuffer^, DataSize);
      end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetNextRecord: Boolean;
var
  GetMode   : TGetMode;
  NewRecord : Integer;
begin
  if dsInternalWriteOnly then begin
    Result := False;
    Exit;
  end;

  dsStartBusy;
  try
    if dsNoCMR then begin
      Result := inherited GetNextRecord;
      Exit;
    end;

    with dsPrivateBufferAccess^ do begin
      GetMode := gmNext;
      if FRecordCount > 0 then begin
        NewRecord := FRecordCount - 1;
        if (State = dsInsert) and (NewRecord = FActiveRecord) and
          (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then GetMode := gmCurrent;
        if FCurrentRecord <> NewRecord then begin
          if [disInGetRecords, disInMoveBy] * dsInternalState = [] then
          if GetMode = gmCurrent then
            AbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGet)
          else {GetMode = gmNext}
            { dsFlipOrder will be taken into account inside the AbstractCursor and
              must not be used to flip to acoSetToBookmarkFollowedByRecordGetPrior
              here }
            AbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGetNext);
          try
            SetCurrentRecord(NewRecord);
          finally
            AbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
          end;
        end;
      end{$IFDEF FPC};
      {$ELSE}
      else if (DataSetField <> nil) and (DataSetField.DataSet.State <> dsInsert) then
        DataSetField.DataSet.UpdateCursorPos;
      {$ENDIF};
      Result := (GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}dsGetBuffer(FRecordCount)), GetMode, True) = grOK);
      if Result then
      begin
        if FRecordCount = 0 then
          ActivateBuffers
        else
          if FRecordCount < FBufferCount then
            Inc(FRecordCount) else
            dsMoveBuffer(0, FRecordCount);
        FCurrentRecord := FRecordCount - 1;
        Result := True;
      end else
        CursorPosChanged;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetNextRecords: Integer;
begin
  if dsInternalWriteOnly then begin
    Result := 0;
    Exit;
  end;

  dsStartBusy;
  try
    if dsNoCMR or not dsAbstractCursor.IsRemote then begin
      Result := inherited GetNextRecords;
      Exit;
    end;

    if State = dsInactive then begin
      Include(dsInternalState, disDelayedBufferFillingOnOpen);
      ClearBuffers;
      Result := 0;
      Exit;
    end else if disDelayedBufferFillingOnOpen in dsInternalState then begin
      ClearBuffers;
      Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
    end;

    if dsFilterClientBlockReadCountMx > 0 then
      dsFilterClientBlockReadCountCr := Min(8, dsFilterClientBlockReadCountMx)
    else
      dsFilterClientBlockReadCountCr := 0;

    with dsPrivateBufferAccess^ do
      if (State in [dsBrowse, dsEdit{for PostAndEnd}]) and
         (dsBlockReadCount = 0) and (
           (FBufferCount - FRecordCount > 1) or
           (
             (dsFilterClientBlockReadCountMx > 0) and
             dsAbstractCursor.HasActiveLocalFilter
           )
         ) then begin
        Include(dsInternalState, disInGetRecords);
      end else begin
        Result := inherited GetNextRecords;
        Exit;
      end;
    try
      Result := inherited GetNextRecords;
    finally
      if (disInGetRecords in dsInternalState) then begin
        if dsBlockReadPos <> dsBlockReadCount then
          CursorPosChanged; { server side cursor position unreliable }
        nxFreeAndNil(dsBlockReadAccess);
        dsBlockReadCount := 0;
        dsBlockReadPos := 0;
        dsBlockReadTotalPos := 0;
        dsBlockReadQueuedKeyPos := 0;
        dsBlockReadEof := False;
        dsBlockReadCurrentError := DBIERR_NA;
      end;
      Exclude(dsInternalState, disInGetRecords);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetPriorRecord: Boolean;
begin
  if dsInternalWriteOnly then begin
    Result := False;
    Exit;
  end;

  dsStartBusy;
  try
    if dsNoCMR or not dsAbstractCursor.IsRemote then begin
      Result := inherited GetPriorRecord;
      Exit;
    end;

    CheckBiDirectional;
    with dsPrivateBufferAccess^ do begin
      if (FRecordCount > 0) and (FCurrentRecord <> 0) then begin
        if [disInGetRecords, disInMoveBy] * dsInternalState = [] then
          { dsFlipOrder will be taken into account inside the AbstractCursor and
            must not be used to flip to acoSetToBookmarkFollowedByRecordGetNext
            here }
          AbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGetPrior);
        try
          SetCurrentRecord(0);
        finally
          AbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
        end;
      end;
      Result := (GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}dsGetBuffer(FRecordCount)), gmPrior, True) = grOK);
      if Result then begin
        if FRecordCount = 0 then
          ActivateBuffers
        else begin
          dsMoveBuffer(FRecordCount, 0);
          if FRecordCount < FBufferCount then begin
            Inc(FRecordCount);
            Inc(FActiveRecord);
          end;
        end;
        FCurrentRecord := 0;
      end else
        CursorPosChanged;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetPriorRecords: Integer;
begin
  if dsInternalWriteOnly then begin
    Result := 0;
    Exit;
  end;

  dsStartBusy;
  try
    if dsNoCMR or not dsAbstractCursor.IsRemote then begin
      Result := inherited GetPriorRecords;
      Exit;
    end;

    if State = dsInactive then begin
      Include(dsInternalState, disDelayedBufferFillingOnOpen);
      ClearBuffers;
      Result := 0;
      Exit;
    end else if disDelayedBufferFillingOnOpen in dsInternalState then begin
      ClearBuffers;
      Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
    end;

    if dsFilterClientBlockReadCountMx > 0 then
      dsFilterClientBlockReadCountCr := Min(8, dsFilterClientBlockReadCountMx)
    else
      dsFilterClientBlockReadCountCr := 0;

    with dsPrivateBufferAccess^ do
      if (State in [dsBrowse, dsEdit{for PostAndEnd}]) and
         (dsBlockReadCount = 0) and (
           (FBufferCount - FRecordCount > 1) or
           (
             (dsFilterClientBlockReadCountMx > 0) and
             dsAbstractCursor.HasActiveLocalFilter
           )
         ) then begin
        Include(dsInternalState, disInGetRecords);
      end else begin
        Result := inherited GetPriorRecords;
        Exit;
      end;
    try
      Result := inherited GetPriorRecords;
    finally
      if (disInGetRecords in dsInternalState) then begin
        if dsBlockReadPos <> dsBlockReadCount then
          CursorPosChanged; { server side cursor position unreliable }
        nxFreeAndNil(dsBlockReadAccess);
        dsBlockReadCount := 0;
        dsBlockReadPos := 0;
        dsBlockReadTotalPos := 0;
        dsBlockReadQueuedKeyPos := 0;
        dsBlockReadEof := False;
        dsBlockReadCurrentError := DBIERR_NA;
      end;
      Exclude(dsInternalState, disInGetRecords);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetPriorRecordsCount(aCount: Integer): Integer;
begin
  if dsInternalWriteOnly then begin
    Result := 0;
    Exit;
  end;

  dsStartBusy;
  try
    with dsPrivateBufferAccess^ do
      if not dsNoCMR and
         dsAbstractCursor.IsRemote and
         (State = dsBrowse) and
         (dsBlockReadCount = 0) and
         (FBufferCount - FRecordCount > 1) then
        Include(dsInternalState, disInMoveBy);
    try
      Result := 0;
      dsMoveByDistance := aCount;
      while (aCount > 0) and GetPriorRecord do begin
        Inc(Result);
        Dec(aCount);
        dsMoveByDistance := aCount;
      end;
    finally
      if (disInMoveBy in dsInternalState) then begin
        if dsBlockReadPos <> dsBlockReadCount then
          CursorPosChanged; { server side cursor position unreliable }
        nxFreeAndNil(dsBlockReadAccess);
        dsBlockReadCount := 0;
        dsBlockReadPos := 0;
        dsBlockReadTotalPos := 0;
        dsBlockReadQueuedKeyPos := 0;
        dsBlockReadEof := False;
        dsBlockReadCurrentError := DBIERR_NA;
      end;
      Exclude(dsInternalState, disInMoveBy);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetRecNo: Integer;
var
  Error : TnxResult;
  RecNo : TnxWord32;
begin
  dsStartBusy;
  try
    if IsSequenced and not IsUniDirectional then begin
      CheckActive;
      if disDelayedBufferFillingOnOpen in dsInternalState then begin
        Result := 0;
        Exit;
      end;
      UpdateCursorPos;
      Error := dsAbstractCursor.RecNoGet(RecNo, dsFlipOrder);
      if Error = DBIERR_NONE then
        Result := RecNo
      else
        Result := -1;
    end else
      Result := -1;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetRecord(aBuffer  : TnxRecordBuffer;
                              aGetMode : TGetMode;
                              aDoCheck : Boolean)
                                       : TGetResult;
var
  Status   : TnxResult;
  Buffer   : Pointer;
begin
  dsStartBusy;
  try
    dsInternalState := dsInternalState - [
      disGetBookmarkAfterFirst,
      disGetBookmarkNotNeeded
    ];

    case aGetMode of
      gmNext :
        Status := dsGetNextOrPriorRecord(dsFlipOrder, nxltNoLock, Pointer(aBuffer));
      gmPrior :
        Status := dsGetNextOrPriorRecord(not dsFlipOrder, nxltNoLock, Pointer(aBuffer));
    else {gmCurrent}
      Status := dsGetRecord(nxltNoLock, Pointer(aBuffer));
    end;

    case Status of
      DBIERR_NONE : begin
        with PnxRecordInfos(aBuffer + dsOffsetRecInfos)^ do begin
          riBookmarkFlag := bfCurrent;
          riRecNo := 0;
        end;
        Buffer := aBuffer + dsOffsetBookmark;
        if (
             ([disInGetRecords, disInMoveBy] * dsInternalState = []) or
             (disGetBookmarkAfterFirst in dsInternalState)
           ) and
           (not (disGetBookmarkNotNeeded in dsInternalState) )
          then
            dsCheck(dsAbstractCursor.GetBookmark(Buffer, BookmarkSize));
        GetCalcFields(aBuffer);
        Result := grOK;
      end;
      DBIERR_BOF :
        if dsFlipOrder then
          Result := grEOF
        else
          Result := grBOF;
      DBIERR_EOF :
        if dsFlipOrder then
          Result := grBOF
        else
          Result := grEOF;
    else
      Result := grError;
      if aDoCheck or
         (ErrCat(Status) = ERRCAT_LOCKCONFLICT) or
         (Status = DBIERR_NX_GENERALTIMEOUT) or
         (Status = DBIERR_NX_FilterTimeout) then
        dsCheck(Status);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetRecordCount: Integer;
begin
  CheckActive;
  dsCheck(dsAbstractCursor.GetRecordCount(TnxWord32(Result)));
end;
{------------------------------------------------------------------------------}
function TnxDataset.GetRecordSize: Word;
begin
  Result := dsRecordLength;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.GetStreamList(aStreams: TStrings);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.TableStreamGetList(aStreams));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.GotoCurrent(aDataSet: TnxDataset);
begin
  dsCheck(GotoCurrentEx(aDataSet));
end;
{------------------------------------------------------------------------------}
function TnxDataset.GotoCurrentEx(aDataSet: TnxDataset): TnxResult;
var
  lBookmark: {$IFDEF Unicode}TBookmark{$ELSE}TBookmarkStr{$ENDIF};
begin
  Result := DBIERR_NOCURRREC;

  dsCheckNotInOnFilterRecord;
  CheckBiDirectional;

  CheckBrowseMode;

  if dsInternalWriteOnly then
    Exit;

  if aDataSet <> Self then begin
    if Session <> aDataSet.Session then begin
      Result := DBIERR_DIFFERENTTABLES;
      Exit;
    end;

    if (aDataSet.State = dsBlockRead) and
       (gboBookmarks in aDataSet.BlockReadOptions) and
       not dsNoCMR and
       (not nxSameGuid(aDataSet._Dictionary.Guid, nxNullGuid)) and
       nxSameGuid(aDataSet._Dictionary.Guid, _Dictionary.Guid) and
       (aDataSet._Dictionary.ID = _Dictionary.ID)
    then begin
      lBookmark := aDataSet.Bookmark;
      if {$IFDEF Unicode}not Assigned(lBookmark){$ELSE}Length(lBookmark) < 1{$ENDIF} then
        Exit;
      Bookmark := BookmarkFromGlobalBookmark({$IFNDEF DCC17OrLater}GetBookmarkTemplate{$ELSE}BookmarkTemplate{$ENDIF}, GlobalBookmarkFromBookmark(lBookmark));
      Result := DBIERR_NONE;
      Exit;
    end else begin
      aDataSet.CheckBiDirectional;
      if (not (aDataSet.State in [dsBrowse, dsEdit])) or aDataSet.IsEmpty then
        Exit;
      aDataSet.UpdateCursorPos;

      if not dsNoCMR then
        dsAbstractCursor.AddCursorOption(acoSetToCursorFollowedBySyncExact);
      try
        Result := dsAbstractCursor.SetToCursor(aDataSet.dsAbstractCursor);
      finally
        dsAbstractCursor.RemoveCursorOption(acoSetToCursorFollowedBySyncExact);
      end;
    end;
  end;

  if Result <> DBIERR_NONE then
    Exit;

  DoBeforeScroll;
  try
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
  finally
    dsInsideScroll := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.HasAllBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
begin
  Result := (aOptions * dsBlockReadOptions) = aOptions;
end;
{------------------------------------------------------------------------------}
function TnxDataset.HasAllDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
begin
  Result := (aOptions * dsOptions) = aOptions;
end;
{------------------------------------------------------------------------------}
function TnxDataset.HasAnyBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
begin
  Result := (aOptions * dsBlockReadOptions) <> [];
end;
{------------------------------------------------------------------------------}
function TnxDataset.HasAnyDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
begin
  Result := (aOptions * dsOptions) <> [];
end;
{------------------------------------------------------------------------------}
function TnxDataset.InBatchAppend: Boolean;
begin
  Result := dsBatchAppend > 0;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxDataset.InternalAddRecord(Buffer: TnxRecordBuffer; Append: Boolean);
begin
  dsStartBusy;
  try
    if not dsInternalWriteOnly then
      dsAbstractCursor.AddCursorOption(acoRecordInsertFollowedByRecordGet);
    dsCheck(dsAbstractCursor.RecordInsert(nxltNoLock, @Buffer[0]));
  finally
    dsEndBusy;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalAddRecord(aBuffer: Pointer; aAppend: Boolean);
begin
  dsStartBusy;
  try
    if not dsInternalWriteOnly then
      dsAbstractCursor.AddCursorOption(acoRecordInsertFollowedByRecordGet);
    dsCheck(dsAbstractCursor.RecordInsert(nxltNoLock, aBuffer));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalCancel;
var
  CancelBlobs  : Boolean;
  Result       : TnxResult;
  FieldIdx     : Integer;
  BlobFields   : array of TBlobField;
  BlobFieldIdx : Integer;
begin
  dsStartBusy;
  try
    if State in [dsEdit] then begin
      if not dsNoCMR and not dsInternalWriteOnly then
        if not (csDestroying in ComponentState) then
          dsAbstractCursor.AddCursorOption(acoLockReleaseFollowedByRecordGet);

      CancelBlobs := accCancelBlobs in dsAbstractCursor.Capabilities;
      BlobFields := nil;
      if CancelBlobs then begin
        SetLength(BlobFields, Fields.Count);
        BlobFieldIdx := 0;
        for FieldIdx := 0 to Pred(Fields.Count) do
          if (Fields[FieldIdx] is TBlobField) then
            if TBlobField(Fields[FieldIdx]).Modified then begin
              BlobFields[BlobFieldIdx] := TBlobField(Fields[FieldIdx]);
              Inc(BlobFieldIdx);
            end;
        SetLength(BlobFields, BlobFieldIdx);
        CancelBlobs := BlobFieldIdx > 0;
      end;

      Result := dsAbstractCursor.RecordLockRelease(False, CancelBlobs);

      if dsoOptimisticLocks in dsOptions then
        if (Result = DBIERR_KEYORRECDELETED) or
           (Result = DBIERR_NOCURRREC) then
        Result := DBIERR_NONE;

      if not dsDeactivating then
        dsCheck(Result);

      for BlobFieldIdx := Low(BlobFields) to High(BlobFields) do
        BlobFields[BlobFieldIdx].Modified := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalClose;
begin
  dsBindFields(False);
  if DefaultFields then
    DestroyFields;
  dsFreeKeyBuffers;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalDelete;
var
  Result : TnxResult;
  Buffer : TnxRecordBuffer;
begin
  dsStartBusy;
  try
    if not dsInternalWriteOnly then begin
      if not dsNoCMR then
        dsAbstractCursor.AddCursorOption(acoRecordDeleteFollowedBySync);

      Result := dsAbstractCursor.RecordDelete(nil);
      if ErrCat(Result) <> ERRCAT_NOTFOUND then
        dsCheck(Result);
    end;
    if State = dsEdit then
      if dsGetActiveBuffer(Buffer) then
        InitRecord(Buffer);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalEdit;
begin
  dsStartBusy;
  try
    if dsInternalWriteOnly then
      dsError(DBIERR_NOCURRREC)
    else begin
      if dsoOptimisticLocks in dsOptions then with dsSFI^ do begin
        if (sfiFields[sftRecRev] < 0) and
           (sfiFields[sftModifyLSN] < 0)
        then
          dsError(DBIERR_NOTSUPPORTED, @rsRecRevOrLSNRequired);
        dsCheck(dsAbstractCursor.RecordGet(nxltNoLock, Pointer(ActiveBuffer)));
      end else
        dsCheck(dsAbstractCursor.RecordGet(nxltWriteLock, Pointer(ActiveBuffer)));
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalFirst;
begin
  dsStartBusy;
  try
    if not dsInternalWriteOnly then
      if {$IFDEF DCC17OrLater}Length(dsFirstBookmark) > 0{$ELSE}dsFirstBookmark <> nil{$ENDIF} then begin
        if not dsNoCMR and
           ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead, disJustOpenedCursor] * dsInternalState = []) and
           (
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [acoSetToBookmarkFollowedByRecordGetNext]) or
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [])
           )
        then
          if dsFlipOrder then
            dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGetPrior)
          else
            dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGetNext);
        DoInternalGotoBookmark({$IFDEF DCC17OrLater}@dsFirstBookmark[0]{$ELSE}dsFirstBookmark{$ENDIF});
      end else if dsFlipOrder then begin
        if not dsNoCMR and
           ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead, disJustOpenedCursor] * dsInternalState = []) and
           (
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [acoSetToBookmarkFollowedByRecordGetPrior]) or
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [])
           )
        then
          if State <> dsBlockRead then
            dsAbstractCursor.AddCursorOption(acoSetToEndFollowedByRecordGetPrior);
        Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
        dsCheck(dsAbstractCursor.SetToEnd);
      end else begin
        if disJustOpenedCursor in dsInternalState then begin
          { a freshly opened cursor is positioned at BOF }
        end else begin
          if not dsNoCMR and
             ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead, disJustOpenedCursor] * dsInternalState = []) and
             (
               (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [acoSetToBookmarkFollowedByRecordGetNext]) or
               (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [])
             )
          then
            if State <> dsBlockRead then
              dsAbstractCursor.AddCursorOption(acoSetToBeginFollowedByRecordGetNext);
          Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
          dsCheck(dsAbstractCursor.SetToBegin);
        end;
      end;
    ResetBlockReadStream;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxDataset.InternalGotoBookmark(aBookmark: TBookmark);
begin
  dsCheckNotInOnFilterRecord;

  if dsInternalWriteOnly then
    Exit;

  if Length(aBookmark) <> BookmarkSize then
    dsError(DBIERR_INVALIDBOOKMARK);

  if not dsNoCMR then
    dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGet);
  try
    DoInternalGotoBookmark({$IFDEF DCC17OrLater}Pointer(@aBookmark[0]){$ELSE}aBookmark{$ENDIF});
  finally
    dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalGotoBookmark(aBookmark: TBookmarkOrPointer);
begin
  dsCheckNotInOnFilterRecord;

  if dsInternalWriteOnly then
    Exit;

  if not Assigned(aBookmark) then
    dsError(DBIERR_INVALIDBOOKMARK);

  if not dsNoCMR then
    dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByRecordGet);
  try
    DoInternalGotoBookmark(Pointer(aBookmark));
  finally
    dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalHandleException;
begin
  if Assigned(nxHandleException) then
    nxHandleException(Self);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalInitFieldDefs;

  procedure CreateFieldDef(aFieldDesc : TnxFieldDescriptor;
                           aFieldNo   : Integer);
  var
    FieldType  : TFieldType;
    Size       : TnxWord16;
    Attributes : TFieldAttributes;

    FieldDef   : TFieldDef;

  begin
    TnxBaseVCLFieldMapper.MapNexusDescriptorToVCL(aFieldDesc, FieldType, Size, Attributes);
    if FieldType <> ftUnknown then
      with aFieldDesc do begin
        FieldDef := TFieldDef(dsGetFieldDefClass.NewInstance);
        FieldDef.Name := Name;
        FieldDef.Attributes := Attributes;
        dsFieldDefCreated(FieldDef.Create(FieldDefs,
          Name, FieldType, Size, fdRequired, aFieldNo), aFieldDesc);
      end;
  end;

var
  i         : Integer;
begin
  FieldDefs.BeginUpdate;
  try
    FieldDefs.Clear;
    with dsFieldsDescriptor do
      for i := 0 to Pred(FieldCount) do
        CreateFieldDef(FieldDescriptor[i], Succ(i));
  finally
    FieldDefs.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalInitRecord(aBuffer: TnxRecordBuffer);
begin
  dsFieldsDescriptor.InitRecord(Pointer(aBuffer));
  if Assigned(dsDefaultValueHandler) then
    dsDefaultValueHandler.SetDefaultValuesInsert(Pointer(aBuffer));
  with PnxRecordInfos(aBuffer + dsOffsetRecInfos)^ do
    riRecNo := 0;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalLast;
begin
  dsStartBusy;
  try
    if not dsInternalWriteOnly then
      if dsFlipOrder then begin
        if (not dsNoCMR) and
           (State = dsBrowse) and
           ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead, disJustOpenedCursor] * dsInternalState = []) and
           (
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [acoSetToBookmarkFollowedByRecordGetNext]) or
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [])
           )
        then
          dsAbstractCursor.AddCursorOption(acoSetToBeginFollowedByRecordGetNext);
        Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
        dsCheck(dsAbstractCursor.SetToBegin)
      end else begin
        if (not dsNoCMR) and
           (State = dsBrowse) and
           ([disInGetRecords, disInMoveBy, disInFilterClientBlockRead, disJustOpenedCursor] * dsInternalState = []) and
           (
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [acoSetToBookmarkFollowedByRecordGetPrior]) or
             (acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [])
           )
        then
          dsAbstractCursor.AddCursorOption(acoSetToEndFollowedByRecordGetPrior);
        Exclude(dsInternalState, disDelayedBufferFillingOnOpen);
        dsCheck(dsAbstractCursor.SetToEnd);
      end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalOpen;
begin
  dsStartBusy;
  try
    if dsFlipOrder then
      dsAbstractCursor.AddCursorOption(acoFlipOrder)
    else
      dsAbstractCursor.RemoveCursorOption(acoFlipOrder);

    dsRecordLength := dsFieldsDescriptor.RecordLength;
    dsInitBookmarkSize;

    InternalInitFieldDefs;
    if DefaultFields then
      CreateFields
    else
      dsInitPersistentFields;

    dsBindFields(True);
    dsInitOffsets;
    dsInitKeyBuffers;

    if dsFilterTimeout <> nxDefaultFilterTimeout then
      if dsNoCMR then
        dsAbstractCursor.FilterSetTimeout(dsFilterTimeout);

    dsCreateExprFilter(Filter, FilterOptions, Filtered and not dsNoCMR);
    if Assigned(OnFilterRecord) then
      dsCreateFuncFilter(@TnxDataset.dsOnFilterRecordCallback, Filtered and not dsNoCMR);
    if Filtered and dsNoCMR then
      dsActivateFilters;

    dsApplyMasterRange(True);
    if dsBlockReadSize > 0 then
      dsInternalWriteOnly := True;

    InternalFirst;
    Exclude(dsInternalState, disJustOpenedCursor);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalPost;
begin
  InternalPostImpl(False);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalPostAndEdit;
begin
  InternalPostImpl(True);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalPostImpl(aKeepLock: Boolean);
var
  Result             : TnxResult;
  i                  : Integer;
begin
  dsStartBusy;
  try
    {$IFNDEF FPC}
    inherited InternalPost;
    {$ENDIF}

    case State of
      dsEdit: begin
        Assert(not dsInternalWriteOnly);

        if Assigned(dsDefaultValueHandler) then
          dsDefaultValueHandler.SetDefaultValuesModify(Pointer(ActiveBuffer));

        if Assigned(dsValidationsHandler) then
          dsValidationsHandler.ValidateRecord
            (Pointer(dsOldValuesBuffer), Pointer(ActiveBuffer));

        if (not dsNoCMR) and (not IsUniDirectional) then
          dsAbstractCursor.AddCursorOption(acoRecordModifyFollowedBySync);
        try
          Result := dsAbstractCursor.RecordModify
            (Pointer(ActiveBuffer), not aKeepLock, nil);
        finally
          dsAbstractCursor.RemoveCursorOption(acoRecordModifyFollowedBySync);
        end;

        if dsoOptimisticLocks in dsOptions then
          if (Result = DBIERR_KEYORRECDELETED) or
             (Result = DBIERR_NOCURRREC) then
          Result := DBIERR_OPTRECLOCKRECDEL;

        dsCheck(Result);
      end;
      dsInsert: begin
        if Assigned(dsValidationsHandler) then
          dsValidationsHandler.ValidateRecord
            (nil, Pointer(ActiveBuffer));

        if not dsInternalWriteOnly then
          dsAbstractCursor.AddCursorOption(acoRecordInsertFollowedByRecordGet);

        if aKeepLock then
          dsCheck(dsAbstractCursor.RecordInsert
            (nxltWriteLock, Pointer(ActiveBuffer)))
        else
          dsCheck(dsAbstractCursor.RecordInsert
            (nxltNoLock, Pointer(ActiveBuffer)));

        Include(dsInternalState, dsiInsertSuccessful);
      end;
    end;

    { prevent redundant calls to BlobFree }
    for i := Low(dsBlobFields) to High(dsBlobFields) do
      dsBlobFields[i].Modified := False;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.InternalSetToRecord(aBuffer: TnxRecordBuffer);
begin
  dsStartBusy;
  try
    DoInternalGotoBookmark(aBuffer + dsOffsetBookmark);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.IsCursorActive: Boolean;  //..
begin
     Result := dsCursor.Active;
end;
{------------------------------------------------------------------------------}
function TnxDataset.IsCursorOpen: Boolean;
begin
  Result := Assigned(dsAbstractCursor);
end;
{------------------------------------------------------------------------------}
function TnxDataset.IsRecordLocked: TnxLockPresent;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;
    CheckActive;
    if not IsEmpty then begin
      UpdateCursorPos;
      dsCheck(dsAbstractCursor.RecordIsLocked(nxltWriteLock, Result));
    end else
      Result := lpNotAtAll;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.IsSequenced: Boolean;
begin
  dsStartBusy;
  try
    Result :=
      not IsUniDirectional and
      (dsoRecNoSupport in Options) and
      Assigned(dsAbstractCursor) and
      (dsAbstractCursor.RecNoSupported = DBIERR_NONE);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.IsTableLocked(aLockType: TnxLockType): TnxLockPresent;
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.TableIsLocked(aLockType, Result));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.KeyAsVariant: Variant;
var
  Buffer : TnxRecordBuffer;
begin
  if State = dsBlockRead then begin
    if not (gboBookmarks in dsBlockReadAccess.bsaOptions) then
      dsError(DBIERR_NOTSUPPORTED, @rsKeyAsVariantIsNotSupported);
    if dsGetActiveBuffer(Buffer) then begin
      dsCheck(dsAbstractCursor.
        BookmarkAsVariant(@Buffer[dsOffsetBookmark], BookmarkSize, Result))
    end else
      Result := Unassigned;
  end else if dsGetActiveBuffer(Buffer) and
    (GetBookmarkFlag(Buffer) = bfCurrent) then
    dsCheck(dsAbstractCursor.
      BookmarkAsVariant(@Buffer[dsOffsetBookmark], BookmarkSize, Result))
  else
    Result := Unassigned;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.Loaded;
begin
  inherited;
  dsCheckDefaults;
  if not Active then
    if csDesigning in ComponentState then try
      Active := ActiveDesigntime
    except
      if Assigned(nxHandleException) then
        nxHandleException(Self);
    end else
      Active := ActiveRuntime;
end;
{------------------------------------------------------------------------------}
function TnxDataset.Locate(const aKeyFields : string;
                           const aKeyValues : Variant;
                                 aOptions   : TLocateOptions)
                                            : Boolean;
var
  RetryCount : Integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    EndDelayedBufferFillingOnOpen;
    CheckBrowseMode;
    DoBeforeScroll;
    try
      RetryCount := 0;
      repeat
        Result := dsLocateRecord(aKeyFields, aKeyValues, aOptions, True);
        if Result then begin
          try
            Resync([rmExact, rmCenter]);
          except
            on E: EnxDatabaseError do
              if (RetryCount < 100) and (E.ErrorCode = DBIERR_KEYORRECDELETED) then begin
                Inc(RetryCount);
                { The record has been modified/deleted between
                  dsLocateRecord and Resync, just retry... }
                Continue
              end else
                raise;
          end;
          DoAfterScroll;
        end;
        Exit;
      until False;
    finally
      dsInsideScroll := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.LockTable(aLockType: TnxLockType);
begin
  CheckActive;
  dsSetTableLock(aLockType, True);
end;
{------------------------------------------------------------------------------}
function TnxDataset.Lookup(const aKeyFields    : string;
                           const aKeyValues    : Variant;
                           const aResultFields : string)
                                               : Variant;
var
  SaveState : TDataSetState;
  Buffer    : Pointer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    Result := Null;
    if dsLocateRecord(aKeyFields, aKeyValues, dsLookupOptions, False) then begin
      Buffer :=  Pointer(TempBuffer);
      SaveState := SetTempState(dsCalcFields);
      try
        CalculateFields(Buffer);
        Result := FieldValues[aResultFields];
      finally
        RestoreState(SaveState);
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.MarkAllBlobs;
var
  lRequiredLength : Integer;
  lFieldIdx       : Integer;
  lField          : TField;
  lBlobIdx        : Integer;
begin
  dsStartBusy;
  try
    dsMarkedBlobsByBlobIdx := nil;
    if Assigned(dsSFI) then with dsSFI^ do begin
      lRequiredLength := Length(sfiBlobFields);
      if lRequiredLength > 0 then
        lRequiredLength := Succ(Pred(lRequiredLength) div 32);
      SetLength(dsMarkedBlobsByBlobIdx, lRequiredLength);
      if lRequiredLength < 1 then begin
        nxFreeAndNil(dsMarkedBlobsByFieldName);
        Exit;
      end;
    end;

    if Assigned(dsMarkedBlobsByFieldName) then
      dsMarkedBlobsByFieldName.Clear
    else
      dsMarkedBlobsByFieldName := TnxFastStringListIC.CreateSorted(dupIgnore);

    for lFieldIdx := 0 to Pred(Fields.Count) do begin
      lField := Fields[lFieldIdx];
      if lField.IsBlob then begin
        dsMarkedBlobsByFieldName.Add(lField.FieldName);
        if Assigned(dsMarkedBlobsByBlobIdx) then begin
          lBlobIdx := dsFieldToBlobIdx(lField);
          if lBlobIdx >= 0 then
            nxSetBit(@dsMarkedBlobsByBlobIdx[0], lBlobIdx);
        end;
      end;
    end;

    if dsMarkedBlobsByFieldName.Count < 1 then begin
      nxFreeAndNil(dsMarkedBlobsByFieldName);
      dsMarkedBlobsByBlobIdx := nil;
    end;

    if Assigned(dsAbstractCursor) then
      dsAbstractCursor.BlobsSetMarked(dsMarkedBlobsByBlobIdx);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.MoveBy(Distance: Integer): Integer;
var
  OldRecordCount, ScrollCount, I: Integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if dsNoCMR then begin
      Result := inherited MoveBy(Distance);
      Exit;
    end;

    with dsPrivateBufferAccess^ do begin
      CheckBrowseMode;
      Result := 0;
      DoBeforeScroll;
      if ((Distance > 0) and not dsEOF^) or ((Distance < 0) and not dsBOF^) then
      begin
        dsBOF^ := False;
        dsEOF^ := False;
        OldRecordCount := FRecordCount;
        ScrollCount := 0;
        try
          try
            while Distance > 0 do begin
              if FActiveRecord < FRecordCount - 1 then
                Inc(FActiveRecord)
              else begin
                if FRecordCount < FBufferCount then
                  I := 0
                else
                  I := 1;

                if not (disInMoveBy in dsInternalState) and
                   (Distance > 1) and
                   dsAbstractCursor.IsRemote and
                   (State = dsBrowse) and
                   (dsBlockReadCount = 0) then
                  Include(dsInternalState, disInMoveBy);

                dsMoveByDistance := Distance;

                if GetNextRecord then begin
                  Dec(ScrollCount, I);
                  if FActiveRecord < FRecordCount - 1 then
                    Inc(FActiveRecord);
                end else begin
                  dsEOF^ := True;
                  Break;
                end;
              end;
              Dec(Distance);
              Inc(Result);
            end;
          finally
            dsMoveByDistance := 0;
            if (disInMoveBy in dsInternalState) then begin
              if dsBlockReadPos <> dsBlockReadCount then
                CursorPosChanged; { server side cursor position unreliable }
              nxFreeAndNil(dsBlockReadAccess);
              dsBlockReadCount := 0;
              dsBlockReadPos := 0;
              dsBlockReadTotalPos := 0;
              dsBlockReadQueuedKeyPos := 0;
              dsBlockReadEof := False;
              dsBlockReadCurrentError := DBIERR_NA;
            end;
            Exclude(dsInternalState, disInMoveBy);
          end;

          try
            while Distance < 0 do begin
              if FActiveRecord > 0 then
                Dec(FActiveRecord)
              else begin
                if FRecordCount < FBufferCount then
                  I := 0
                else
                  I := 1;

                if not (disInMoveBy in dsInternalState) and
                   (Distance < -1) and
                   dsAbstractCursor.IsRemote and
                   (State = dsBrowse) and
                   (dsBlockReadCount = 0) then
                  Include(dsInternalState, disInMoveBy);

                dsMoveByDistance := Abs(Distance);

                if GetPriorRecord then begin
                  Inc(ScrollCount, I);
                  if FActiveRecord > 0 then
                    Dec(FActiveRecord);
                end else begin
                  dsBOF^ := True;
                  Break;
                end;
              end;
              Inc(Distance);
              Dec(Result);
            end;
          finally
            dsMoveByDistance := 0;
            if (disInMoveBy in dsInternalState) then begin
              if dsBlockReadPos <> dsBlockReadCount then
                CursorPosChanged; { server side cursor position unreliable }
              nxFreeAndNil(dsBlockReadAccess);
              dsBlockReadCount := 0;
              dsBlockReadPos := 0;
              dsBlockReadTotalPos := 0;
              dsBlockReadQueuedKeyPos := 0;
              dsBlockReadEof := False;
              dsBlockReadCurrentError := DBIERR_NA;
            end;
            Exclude(dsInternalState, disInMoveBy);
          end;
        finally
          if FRecordCount <> OldRecordCount then
            DataEvent(deDataSetChange, 0) else
            DataEvent(deDataSetScroll, ScrollCount);
          DoAfterScroll;
        end;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.Notification(aComponent : TComponent;
                                  aOperation : TOperation);
begin
  inherited;
  if (aComponent = dsSession) and (aOperation = opRemove) then begin
    try
      Active := False;
    except
      if csDesigning in ComponentState then begin
        InternalHandleException;
      end else
        raise;
    end;
    dsSession := nil;
    dsCursor.Database := nil;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.OpenCursor(aInfoQuery: Boolean);
var
  i : integer;
  nulllist: TList;
begin
  nulllist:=TList.Create;
  try
    if aInfoQuery and (Self is TnxQuery) then
    begin
      // temporarily make sure that parameters are not set to null
      // otherwise in a prepare we might not be able to get the type of
      // fields correctly. we need to somehow later on pass a IsPreparing
      // flag through to the parser to make it possible to skip the
      // check on 'field = null' constructs.
      for i:=0 to TnxQuery(Self).ParamCount-1 do
        if (TnxQuery(Self).Params[i].IsNull) and not (TnxQuery(Self).Params[i].DataType in [ftString, ftWideString, ftMemo{$IFDEF DCC10OrLater}, ftWideMemo{$endif}]) then
        begin
          if TnxQuery(Self).Params[i].DataType in [ftString, ftMemo, ftWideString{$IFDEF DCC10OrLater}, ftWideMemo{$endif}] then
            TnxQuery(Self).Params[i].AsString:='0'
          else
            TnxQuery(Self).Params[i].Value:=0;
          nulllist.Add(TnxQuery(Self).Params[i]);
        end;
    end;
    dsCursor.Active := True;
    dsOpenCursorID;
    if Assigned(dsAbstractCursor) then begin
      dsAbstractCursor.OnCancelServerFilter := dsCancelServerFilter;
      dsInitMappers;
      inherited OpenCursor(aInfoQuery);
    end;
  finally
    for i:=0 to nulllist.count-1 do
      TnxQuery(Self).Params[i].Clear;
    nulllist.free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.Post;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if dsBatchAppend > 0 then
      BatchPost
    else
      inherited;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.PostAndEdit;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if dsBatchAppend > 0 then
      Exit;

    UpdateRecord;
    case State of
      dsEdit, dsInsert:
        try
          DataEvent(deCheckBrowseMode, 0);
          DoBeforePost;
          dsInOperation := dioPostAndEdit;
          dsCheckOperation(InternalPostAndEdit, OnPostError);
          FreeFieldBuffers;
          SetState(dsEdit);
          Resync([rmExact]);
          DoAfterPost;

          DoBeforeEdit;
          dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
          GetCalcFields(ActiveBuffer);
          SetState(dsEdit);

          FreeRecordBuffer(dsOldValuesBuffer);
          dsOldValuesBuffer := AllocRecordBuffer;
          nxMove(Pointer(ActiveBuffer)^, dsOldValuesBuffer^, dsRecordBufferSize);

          DataEvent(deRecordChange, 0);
          DoAfterEdit;
        finally
          dsInOperation := dioNone;
          dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
        end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.PSEndTransaction(Commit: Boolean);
begin
  if Commit then
    Database.Commit
  else
    Database.Rollback;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSExecuteStatement(const aSQL    : string;
                                             aParams : TParams)
                                                     : Integer;

  { ClientDataSet/Midas uses ? for all params }
  function CreateParamNames : String;
  var
    ParamCount : Integer;
  begin
    Result := aSQL;
    ParamCount := 0;
    while Pos('?', Result)>0 do begin
      Inc(ParamCount);
      Result := StringReplace(Result, '?', ':P'+IntToStr(ParamCount), [rfIgnoreCase]);
    end;
  end;

var
  Query : TnxQuery;
begin
  Query := TnxQuery.Create(nil);
  try
    Query.Database := Database;
    Query.Sql.Text := CreateParamNames;
    Query.Params.Assign(aParams);
    Query.Open;
    Result := Query.RowsAffected;
  finally
    Query.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSExecuteStatement(const aSQL      : string;
                                             aParams   : TParams;
                                         var ResultSet : TDataSet)
                                                       : Integer;

  { ClientDataSet/Midas uses ? for all params }
  function CreateParamNames : String;
  var
    ParamCount : Integer;
  begin
    Result := aSQL;
    ParamCount := 0;
    while Pos('?', Result)>0 do begin
      Inc(ParamCount);
      Result := StringReplace(Result, '?', ':P'+IntToStr(ParamCount), [rfIgnoreCase]);
    end;
  end;

var
  Query : TnxQuery;
begin
  Query := TnxQuery.Create(nil);
  try
    Query.Database := Database;
    Query.Sql.Text := CreateParamNames;
    Query.Params.Assign(aParams);
    Query.Open;
    Result := Query.RowsAffected;
    ResultSet := Query;
    Query := nil;
  finally
    Query.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSExecuteStatement(const aSQL      : string;
                                             aParams   : TParams;
                                             ResultSet : Pointer)
                                                       : Integer;

  { ClientDataSet/Midas uses ? for all params }
  function CreateParamNames : String;
  var
    ParamCount : Integer;
  begin
    Result := aSQL;
    ParamCount := 0;
    while Pos('?', Result)>0 do begin
      Inc(ParamCount);
      Result := StringReplace(Result, '?', ':P'+IntToStr(ParamCount), [rfIgnoreCase]);
    end;
  end;

var
  Query : TnxQuery;
begin
  if Assigned(ResultSet) then
    TnxDataSet(ResultSet^) := nil;

  Query := TnxQuery.Create(nil);
  try
    Query.Database := Database;
    Query.Sql.Text := CreateParamNames;
    Query.Params.Assign(aParams);
    Query.Open;
    Result := Query.RowsAffected;
    if Assigned(ResultSet) then begin
      TnxDataSet(ResultSet^) := Query;
      Query := nil;
    end;
  finally
    Query.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSGetQuoteChar: string;
begin
  Result := '"';
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSGetUpdateException(E    : Exception;
                                         Prev : EUpdateError)
                                              : EUpdateError;
var
  PreviousError : Integer;
begin
  if E is EnxDatabaseError then
  begin
    if Prev <> nil then
      PreviousError := Prev.ErrorCode else
      PreviousError := 0;
    with EnxDatabaseError(E) do
      Result := EUpdateError.Create(Message, '', ErrorCode, PreviousError, E);
  end else
  {$IFNDEF FPC}
    Result := inherited PSGetUpdateException(E, Prev);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSInTransaction: Boolean;
begin
  Result := Assigned(Database) and Database.Active and Database.InTransaction;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSIsSqlBased: Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
function TnxDataset.PSIsSqlSupported: Boolean;
begin
  Result := True;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.PSReset;
begin
  inherited;
  if Active then
    First;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.PSStartTransaction;
begin
  Database.StartTransaction;
end;
{------------------------------------------------------------------------------}
function TnxDataset.ReadBlobAsStream(aField    : TField;
                                     aSnapshot : Boolean;
                                     aReadOrg  : Boolean)
                                               : TStream;
begin
  CheckActive;
  Result := TnxMemoryStream.Create;
  try
    ReadBlobIntoStream(aField, Result, aSnapshot, aReadOrg);
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.ReadBlobIntoStream(aField    : TField;
                                        aStream   : TStream;
                                        aSnapshot : Boolean;
                                        aReadOrg  : Boolean);
begin
  CheckActive;
  dsCheck(aField, ReadBlobIntoStreamEx(aField, aStream, aSnapshot, aReadOrg));
end;
{------------------------------------------------------------------------------}
type
  TMemoryStreamHacker = class(TMemoryStream);
{------------------------------------------------------------------------------}
function TnxDataset.ReadBlobIntoStreamEx(aField    : TField;
                                         aStream   : TStream;
                                         aSnapshot : Boolean;
                                         aReadOrg  : Boolean)
                                                   : TnxResult;
var
  lFieldNo          : Integer;
  lFieldDescriptor  : TnxFieldDescriptor;
  lIsNull           : Boolean;
  lBlobNr           : TnxBlobNr;
  lNewBlobNr        : TnxBlobNr;
  pNewBlobNr        : PnxBlobNr;
  lRecID            : TnxRecID;
  lBuffer           : TnxRecordBuffer;

  lSnapShot         : TnxBlobReadSnapshotState;
  lBlobLen          : TnxWord32;
  pBlobLen          : PnxWord32;

  lBytesToRead      : TnxWord32;

  lOldPos           : Int64;
  lBytesRead        : Int64;
  lBytesReadTotal   : Int64;
  lTotalSize        : Int64;

  lIsMemoryStream   : Boolean;
  lIsNxMemoryStream : Boolean;

  lIsMarked         : Boolean;
begin
  dsStartBusy;
  try
    lIsMarked := False;

    if not Assigned(aField) then begin
      Result := DBIERR_INVALIDPARAM;
      Exit;
    end;
    if not Assigned(aStream) then begin
      Result := DBIERR_INVALIDPARAM;
      Exit;
    end;
    if not Active then begin
      Result := DBIERR_INVALIDHNDL;
      Exit;
    end;

    if not dsGetActiveBuffer(lBuffer) then begin
      Result := DBIERR_NONE; //happens for example in dsBrowse with BOF and EOF = True
      Exit;
    end;

    lFieldNo := Pred(aField.FieldNo);
    if (aField is TBlobField) and
       (aField.FieldKind = fkData) and
       (lFieldNo >= 0)
    then
      lFieldDescriptor := dsFieldsDescriptor.FieldDescriptor[Pred(aField.FieldNo)]
    else
      lFieldDescriptor := nil;

    if not Assigned(lFieldDescriptor) or
       not (lFieldDescriptor.fdType in nxcBlobTypes)
    then begin
      Result := DBIERR_NOTABLOB;
      Exit;
    end;

    Result := dsGetBlobNr(lBuffer, aField, lIsNull, lBlobNr, lRecID);
    if Result <> DBIERR_NONE then
      Exit;

    if lIsNull then begin
      Result := DBIERR_NONE;
      Exit;
    end;

    if (State = dsBlockRead) and
       (gboBlobs in dsBlockReadAccess.bsaOptions) and
       (
         not (gboBlobsOnlyMarked in dsBlockReadAccess.bsaOptions) or
         (
           Assigned(dsBlockReadAccess.bsaMarkedBlobs) and
           nxIsBitSet(Pointer(dsBlockReadAccess.bsaMarkedBlobs), dsSFI.sfiFieldsToBlobFields[lFieldNo])
         )
       )
    then begin
      pBlobLen := Pointer(@dsBlockReadEntry.bseStreamBase[TnxNativeUInt(lBlobNr)]);
      if pBlobLen^ > 0 then
        aStream.WriteBuffer(PnxByteArray(pBlobLen)[SizeOf(Integer)], pBlobLen^);
      Exit;
    end;

    if State in [dsEdit, dsInsert] then
      { never need a lSnapShot when already editing this record }
      aSnapshot := False;

    lIsMemoryStream := aStream is TMemoryStream;
    lIsNxMemoryStream := (not lIsMemoryStream) and (aStream is TnxMemoryStream);

    lBlobLen := 0;
    if lIsMemoryStream or lIsNxMemoryStream then
      pBlobLen := @lBlobLen
    else
      pBlobLen := nil;

    lBytesToRead := nxMaxBlobChunk;

    lOldPos := aStream.Position;
    lBytesReadTotal := 0;

    lNewBlobNr := lBlobNr;
    pNewBlobNr := @lNewBlobNr;
    repeat
      if aSnapshot then
        lSnapShot := brssRequestStart
      else
        lSnapShot := brssNone;
      Result := dsAbstractCursor.BlobReadSnapshoted(lRecID, lFieldNo, lBlobNr, 0,
        lBytesToRead, aStream, aReadOrg, lSnapShot, pBlobLen, @pNewBlobNr);
      if (Result = DBIERR_BLOBMODIFIED) and Assigned(pNewBlobNr) then begin
        if lSnapShot = brssStarted then
          if dsAbstractCursor.Database.TransactionRollback = DBIERR_NONE then
            lSnapShot := brssClosed;
        Assert(lSnapShot in [brssNone, brssRequestStart, brssUnneccesary, brssFailedToStart, brssClosed]);
        lBlobNr := pNewBlobNr^;
        dsSetBlobNr(lBuffer, aField, lBlobNr);
      end else
        Break;
    until False;

    try
      if Result <> DBIERR_NONE then
        Exit;

      lBytesRead := aStream.Position - lOldPos;

      if lBytesRead >= lBytesToRead then begin

        if lBlobLen > 0 then begin
          lTotalSize := lOldPos + lBlobLen;
          if lIsMemoryStream then begin
            if TMemoryStreamHacker(aStream).Capacity < lTotalSize then
              TMemoryStreamHacker(aStream).Capacity := lTotalSize;
          end else if lIsNxMemoryStream then begin
            if TnxMemoryStream(aStream).Capacity < lTotalSize then
              TnxMemoryStream(aStream).Capacity := lTotalSize;
          end;
        end;

        Inc(lBytesReadTotal, lBytesRead);
        while lBytesRead >= lBytesToRead do begin

          lOldPos := aStream.Position;

          Result := dsAbstractCursor.BlobReadSnapshoted(lRecID, lFieldNo, lBlobNr, lBytesReadTotal,
            lBytesToRead, aStream, aReadOrg, lSnapShot, nil, nil);

          if Result <> DBIERR_NONE then
            Exit;

          lBytesRead := aStream.Position - lOldPos;
          Inc(lBytesReadTotal, lBytesRead);
        end;
      end;
    finally
      if lSnapShot = brssStarted then
        if dsAbstractCursor.Database.TransactionRollback = DBIERR_NONE then
          lSnapShot := brssClosed;
    end;

    Assert(lSnapShot in [brssNone, brssRequestStart, brssUnneccesary, brssFailedToStart, brssClosed]);

    if (dsoAutoMarkBlobsOnReadAccess in dsOptions) and
       (Result = DBIERR_NONE) and
       not lIsMarked
    then
      BlobMarked[aField] := True;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.ReadStream(const aName: string; aStream: TStream);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(ReadStreamEx(aName, aStream));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.ReadStreamEx(const aName   : string;
                                       aStream : TStream)
                                               : TnxResult;
begin
  dsStartBusy;
  try
    CheckActive;
    Result := dsAbstractCursor.TableStreamRead(aName, aStream);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxDataset.RecID: TnxRecID;
var
  lBuffer : TnxRecordBuffer;
begin
  Result := ridNull;
  CheckActive;
  if dsGetActiveBuffer(lBuffer) then
    Result := dsGetRecID(lBuffer);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.RecordCountAsync(out aTaskInfo : TnxAbstractTaskInfo);
begin
  dsCheckNotInOnFilterRecord;
  CheckActive;
  dsCheck(dsAbstractCursor.GetRecordCountAsync(aTaskInfo));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.RefreshInternalCalcFields(Buffer: TnxRecordBuffer);
begin
  {NOT inherited}
end;
{------------------------------------------------------------------------------}
function TnxDataset.RemoveBlockReadOption(aOption: TnxRecordGetBatchExOption): Boolean;
begin
  Result := aOption in dsBlockReadOptions;
  if Result then
    Exclude(dsBlockReadOptions, aOption);
end;
{------------------------------------------------------------------------------}
function TnxDataset.RemoveBlockReadOptions(aOptions: TnxRecordGetBatchExOptions): Boolean;
begin
  Result := (aOptions * dsBlockReadOptions) <> [];
  if Result then
    dsBlockReadOptions := dsBlockReadOptions - aOptions;
end;
{------------------------------------------------------------------------------}
function TnxDataset.RemoveDataSetOption(aOption: TnxDataSetOption): Boolean;
begin
  Result := aOption in dsOptions;
  if Result then
    Options := dsOptions - [aOption];
end;
{------------------------------------------------------------------------------}
function TnxDataset.RemoveDataSetOptions(aOptions: TnxDataSetOptions): Boolean;
begin
  Result := (aOptions * dsOptions) <> [];
  if Result then
    Options := dsOptions - aOptions;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.ResetBlockReadStream;
begin
  dsStartBusy;
  try
    Exclude(dsInternalState, dsiBlockReadNeedsFirst);
    nxFreeAndNil(dsBlockReadAccess);
    dsBlockReadCount := 0;
    dsBlockReadPos := 0;
    dsBlockReadTotalPos := 0;
    dsBlockReadQueuedKeyPos := 0;
    dsBlockReadEof := False;
    dsBlockReadCurrentError := DBIERR_NA;

    if State = dsBlockRead then try
      ActivateBuffers;
      dsBof^ := True;
      if not (dsiInGotoQueuedKeys in dsInternalState) then
        if not dsInternalWriteOnly then
          if dsNoCMR then begin
            if {$IFDEF DCC17OrLater}Length(dsFirstBookmark) > 0{$ELSE}dsFirstBookmark <> nil{$ENDIF} then begin
              DoInternalGotoBookmark({$IFDEF DCC17OrLater}@dsFirstBookmark[0]{$ELSE}@dsFirstBookmark{$ENDIF});
            end else
              if dsFlipOrder then
                dsCheck(dsAbstractCursor.SetToEnd)
              else
                dsCheck(dsAbstractCursor.SetToBegin);
          end else
            Include(dsInternalState, dsiBlockReadNeedsFirst);
      BlockReadNext;
    except
      ClearBuffers;
      BlockReadSize := 0;
      if dsNoCMR then
        { BlockReadSize does an implicit first if not dsNoCMR }
        First;
      raise;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.Resync(Mode: TResyncMode);
var
  Count: Integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    if dsNoCMR then begin
      inherited Resync(Mode);
      Exit;
    end;

    if not IsUniDirectional and IsCursorOpen then
      with dsPrivateBufferAccess^ do begin
      if rmExact in Mode then begin
        CursorPosChanged;
        if GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}FBuffers[FRecordCount]), gmCurrent, True) <> grOK then
          DatabaseError(SRecordNotFound, Self);
      end else
        if (GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}FBuffers[FRecordCount]), gmCurrent, False) <> grOK) and
          (GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}FBuffers[FRecordCount]), gmNext, False) <> grOK) and
          (GetRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}FBuffers[FRecordCount]), gmPrior, False) <> grOK) then begin

          ClearBuffers;
          DataEvent(deDataSetChange, 0);
          Exit;
        end;
      if rmCenter in Mode then
        Count := (FBufferCount - 1) div 2
      else
        Count := FActiveRecord;
      dsMoveBuffer(FRecordCount, 0);
      ActivateBuffers;
      try
        GetPriorRecordsCount(Count);
        GetNextRecords;
        GetPriorRecords;
      finally
        DataEvent(deDataSetChange, 0);
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetActive(Value: Boolean);
begin
  dsStartBusy;
  try
    try
      if Active and not Value then begin
        dsDeactivating := True;
        if dsInsideScroll and IsUniDirectional then begin
          ClearBuffers;
          dsInsideScroll := False;
          Exit;
        end;
        Cancel;
      end;
      try
        inherited;
      finally
        if csDesigning in ComponentState then
          dsActiveDesigntime := Active
        else
          dsActiveRuntime := Active;
      end;
      dsInsideScroll := False;
    finally
      dsDeactivating := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetAutoIncValue(aValue: TnxWord32);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.AutoIncSet(aValue));
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetBlockReadSize(Value: Integer);
var
  Changed: Boolean;
begin
  dsStartBusy;
  try
    Changed := dsBlockReadSize <> Value;

    if Changed then
      dsCheckNotInOnFilterRecord;

    dsBlockReadSize := Value;
    {$IFNDEF FPC}
    SetUniDirectional(dsBlockReadSize > 0);
    {$ENDIF}
    if dsBlockReadSize = 0 then
      Exclude(dsInternalState, dsiInGotoQueuedKeys);
    if Active then begin
      inherited;
      ResetBlockReadStream;
      if not (dsoSupressResyncOnDisableBlockRead in dsOptions) then
        if Changed and (Value = 0) then
          if dsNoCMR then
            Resync([])
          else
            First;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxDataset.SetBookmarkData(aBuffer: TnxRecordBuffer; aData: TBookmark);
begin
  if Length(aData) = BookmarkSize then
    nxMove(aData[0], aBuffer[dsOffsetBookmark], BookmarkSize)
  else begin
    { It is possible for SetBookmarkData to be called with aData=nil if the
      code in TDataSet.Insert us unable to get a bookmark for the old current
      record. }
    nxFillChar(aBuffer[dsOffsetBookmark], BookmarkSize, 0);
    SetBookmarkFlag(aBuffer, bfEOF);
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.SetBookmarkData(aBuffer: TnxRecordBuffer; aData: Pointer);
begin
  if Assigned(aData) then
    nxMove(aData^, aBuffer[dsOffsetBookmark], BookmarkSize)
  else begin
    { It is possible for SetBookmarkData to be called with aData=nil if the
      code in TDataSet.Insert us unable to get a bookmark for the old current
      record. }
    nxFillChar(aBuffer[dsOffsetBookmark], BookmarkSize, 0);
    SetBookmarkFlag(aBuffer, bfEOF);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetBookmarkFlag(aBuffer: TnxRecordBuffer; aValue: TBookmarkFlag);
begin
  if not (State in [dsInactive, dsBlockRead]) then
    PnxRecordInfos(aBuffer + dsOffsetRecInfos).riBookmarkFlag := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetBufListSize(Value: Integer);
begin
  inherited;
  if Value = 0 then begin
    FreeRecordBuffer(dsTempBufferBackup);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetCurrentRecord(Index: Integer);
var
  Buffer: TRecBuf;
begin
  dsStartBusy;
  try
    if dsNoCMR then begin
      inherited SetCurrentRecord(Index);
      Exit;
    end;

    if State = dsFilter then
      Exit;

    with dsPrivateBufferAccess^ do try
      if (FCurrentRecord <> Index) {$IFNDEF FPC}or (DataSetField <> nil){$ENDIF} then
      begin
        {$IFNDEF FPC}
        if (DataSetField <> nil) and (DataSetField.DataSet.State <> dsInsert) then
          DataSetField.DataSet.UpdateCursorPos;
        {$ENDIF}

        Buffer := FBuffers[Index];

        case dsInOperation of
          dioEdit: begin
            dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
            dsAbstractCursor.AddCursorOptions(acoSetToBookmarkFollowedByRecordGetForEdit);
          end;
          dioPost: begin
            if State = dsInsert then
              { The cursor position is irrelevant if we are about to make a
                RecordInsert call. This prevents unneccesary SetToBegin calls
                when using Append instead of Insert. }
              Exit;
          end;
          dioCancel: begin
            {if not (csDestroying in ComponentState) then
              dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedBySync);}
          end;
        end;

        if IsUniDirectional then begin
          if Assigned(dsBlockReadEntry) and Assigned(dsBlockReadEntry.bseBookmark) and (dsInOperation in [dioEdit, dioPost, dioCancel]) then begin
            InternalGotoBookmark(dsBlockReadEntry.bseBookmark);
            FCurrentRecord := Index;
          end;
        end else begin
          case GetBookmarkFlag({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}Buffer)) of
            bfCurrent,
            bfInserted: InternalSetToRecord({$IFDEF DCC12OrLater}{$IFDEF DCC17OrLater}TRecordBuffer({$ELSE}PByte({$ENDIF}{$ELSE}PChar({$ENDIF}Buffer));
            bfBOF: begin
              if acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [] then
                dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByNothing);
              InternalFirst;
            end;
            bfEOF: begin
              if acoSetToBookmarkFollowedByRecordGets * dsAbstractCursor.CursorOptions = [] then
                dsAbstractCursor.AddCursorOption(acoSetToBookmarkFollowedByNothing);
              InternalLast;
            end;
          end;
          FCurrentRecord := Index;
        end;
      end;
    finally
      dsAbstractCursor.RemoveCursorOptions(acoSetToBookmarkFollowedByRecordGets);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxDataset.SetFieldData(aField: TField; aBuffer: TValueBuffer);
var
  RecordBuffer : TnxRecordBuffer;
  hFieldNo     : Integer;
begin
  with aField do begin

    if not (State in dsWriteModes) then
      dsError(@rsDataSetNotEditing);
    if not dsGetActiveBuffer(RecordBuffer) then
      dsError(@rsDataSetCantGetBuf);

    if Length(aBuffer) < 1 then {JIC}
      aBuffer := nil;

    hFieldNo := FieldNo;
    if hFieldNo > 0 then begin
      if State = dsCalcFields then
        dsError(DBIERR_READONLYFLD);

      if ReadOnly and not ((State in [dsSetKey, dsFilter]) or (dsIgnoreReadOnly > 0)) then
        dsError(DBIERR_READONLYFLD);

      if (FieldKind = fkInternalCalc) and not (State = dsSetKey) then
        dsError(DBIERR_READONLYFLD);

      Validate(aBuffer);

      dsFieldsDescriptor.SetRecordFieldNull(Pred(hFieldNo),
        Pointer(RecordBuffer), not Assigned(aBuffer));
      if Assigned(aBuffer) then begin
        Inc(RecordBuffer, dsMapperFieldOffset[hFieldNo]);
        dsMapperVclToNexus[hFieldNo](aBuffer[0], RecordBuffer^);
      end;

    end else {hFieldNo <= 0} begin
      Inc(RecordBuffer, dsOffsetCalcFlds + Offset);
      if Assigned(aBuffer) then begin
        Byte(RecordBuffer[0]) := Byte(RecordBuffer[0]) or 1;
        nxMove(aBuffer[0], RecordBuffer[1], Min(DataSize, Length(aBuffer)));
      end else
        Byte(RecordBuffer[0]) := Byte(RecordBuffer[0]) and not 1;
    end;

    if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
      DataEvent(deFieldChange, TnxNativeInt(aField));
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxDataset.SetFieldData(aField: TField; aBuffer: Pointer);
var
  RecordBuffer : TnxRecordBuffer;
  hFieldNo     : Integer;
begin
  with aField do begin

    if not (State in dsWriteModes) then
      dsError(@rsDataSetNotEditing);
    if not dsGetActiveBuffer(RecordBuffer) then
      dsError(@rsDataSetCantGetBuf);

    hFieldNo := FieldNo;
    if hFieldNo > 0 then begin
      if State = dsCalcFields then
        dsError(DBIERR_READONLYFLD);

      if ReadOnly and not ((State in [dsSetKey, dsFilter]) or (dsIgnoreReadOnly > 0)) then
        dsError(DBIERR_READONLYFLD);

      if (FieldKind = fkInternalCalc) and not (State = dsSetKey) then
        dsError(DBIERR_READONLYFLD);

      Validate(aBuffer);

      dsFieldsDescriptor.SetRecordFieldNull(Pred(hFieldNo),
        Pointer(RecordBuffer), not Assigned(aBuffer));
      if Assigned(aBuffer) then begin
        Inc(RecordBuffer, dsMapperFieldOffset[hFieldNo]);
        dsMapperVclToNexus[hFieldNo](aBuffer^, RecordBuffer^);
      end;

    end else {hFieldNo <= 0} begin
      Inc(RecordBuffer, dsOffsetCalcFlds + Offset);
      if Assigned(aBuffer) then begin
        Byte(RecordBuffer[0]) := Byte(RecordBuffer[0]) or 1;
        nxMove(aBuffer^, RecordBuffer[1], DataSize);
      end else
        Byte(RecordBuffer[0]) := Byte(RecordBuffer[0]) and not 1;
    end;

    if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
      DataEvent(deFieldChange, TnxNativeInt(aField));
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetFiltered(Value: Boolean);
begin
  dsStartBusy;
  try
    if Active then begin
      CheckBiDirectional;
      CheckBrowseMode;
      if Filtered <> Value then begin
        dsCheckNotInOnFilterRecord;
        dsDestroyLookupCursor;
        if dsFilterResync and not dsInternalWriteOnly then begin
          if dsFilterResyncDoesFirst then begin
            if dsNoCMR then
              InternalFirst
            else
              if not IsUniDirectional then
                dsAbstractCursor.AddCursorOption(acoFilterActionFollowedByFirst);
          end else begin
            if not dsNoCMR then
              if not IsUniDirectional then
                dsAbstractCursor.AddCursorOption(acoFilterActionFollowedBySync);
          end;
        end;
        try
          if Value then
            dsActivateFilters
          else
            dsDeactivateFilters;
        finally
          dsAbstractCursor.RemoveCursorOptions([
            acoFilterActionFollowedByFirst,
            acoFilterActionFollowedBySync
          ]);
        end;
        inherited SetFiltered(Value);
      end;
      if dsFilterResync and not dsInternalWriteOnly then
        if dsFilterResyncDoesFirst then
          First
        else
          Resync([]);
    end else
      inherited;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetFilterOptions(Value: TFilterOptions);
begin
  dsSetFilterData(dsFilterType, Filter, Value);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetFilterText(const Value: string);
begin
  dsSetFilterData(dsFilterType, Value, FilterOptions);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  dsCursor.Name := NewName + '_Cursor';
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetOnFilterRecord(const Value: TFilterRecordEvent);
begin
  dsStartBusy;
  try
    if (@Value <> @OnFilterRecord) then begin
      if Active then begin
        dsCheckNotInOnFilterRecord;
        CheckBiDirectional;
        CheckBrowseMode;

        dsDestroyLookupCursor;
        if Assigned(Value) then
          dsCreateFuncFilter(@TnxDataset.dsOnFilterRecordCallback, Filtered and not dsNoCMR)
        else
          dsCreateFuncFilter(nil, False);
        if Filtered then begin
          if dsFuncFilter <> 0 then
            if dsNoCMR then
              dsCheck(dsActivateFilter(dsFuncFilter));
          {FilterResync should be checked here just like for expression filters}
          if dsFilterResync then
            if dsFilterResyncDoesFirst then
              First
            else
              Resync([]);
        end;
      end;
      inherited SetOnFilterRecord(Value);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.SetRecNo(Value: Integer);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    if IsSequenced then begin
      CheckActive;
      CheckBiDirectional;

      DoBeforeScroll;
      try
        if not dsNoCMR and not dsInternalWriteOnly then
          dsAbstractCursor.AddCursorOption(acoRecNoSetFollowedBySync);
        try
          if (dsAbstractCursor.RecNoSet(Value, dsFlipOrder) = DBIERR_NONE) and not dsInternalWriteOnly then begin
            Resync([rmCenter]);
            DoAfterScroll;
          end;
        finally
          dsAbstractCursor.RemoveCursorOption(acoRecNoSetFollowedBySync);
        end;
      finally
        dsInsideScroll := False;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.UnlockTable(aLockType: TnxLockType);
begin
  CheckActive;
  dsSetTableLock(aLockType, False);
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.UnlockTableAll;
begin
  CheckActive;
  dsCheck(dsAbstractCursor.TableLockRelease
    (nxltNoLock {ignored}, True));
end;
{------------------------------------------------------------------------------}
procedure TnxDataset.WriteStream(const aName: string; aStream: TStream);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.TableStreamWrite(aName, aStream));
  finally
    dsEndBusy;
  end;
end;
{==============================================================================}



{===TnxIndexDef================================================================}
{$IFDEF DCC12OrLater}
function TnxIndexDefs.GetIndexDefClass: TIndexDefClass;
begin
  Result := TnxIndexDef;
end;
{$ENDIF}
{==============================================================================}



{===TnxIndexDef================================================================}
procedure TnxIndexDef.SetFilterExpression(const Value: string);
begin
  FFilterExpression := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDef.SetFilterType(const Value: TnxFilterType);
begin
  FFilterType := Value;
end;
{==============================================================================}



{===TnxIndexDataSet============================================================}
function TnxIndexDataSet.ApplyRange(aAfterApply: TnxAfterApplyBehavior): Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    Result := idSetCursorRange(aAfterApply <> aabAlwaysKeepPosition);
    case aAfterApply of
      aabDefault:
        if Result then
          First;
      aabAlwaysFirst:
      begin
        First;
        Result := True;
      end;
      aabAlwaysKeepPosition:
      begin
        Resync([]);
        Result := False;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.Cancel;
begin
  dsStartBusy;
  try
    inherited;
    if State = dsSetKey then
      idPostKeyBuffer(False);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.CancelRange(aGoFirst: Boolean = False);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;

    if not dsNoCMR then begin
      if dsWriteOnly then
        Exit;
      if not idHasActiveRange then begin
        if aGoFirst then
          First;
        Exit;
      end;
      if dsBlockReadSize <> 0 then begin
        idResetCursorRange(False);
        ResetBlockReadStream;
        Exit;
      end;
    end;

    if not aGoFirst then
      UpdateCursorPos;

    if idResetCursorRange(not aGoFirst) then
      if not aGoFirst then
        Resync([]);

    if aGoFirst then //could be better optimized in CMR, but requires new type of server message
      First;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.ClearQueuedKeys;
var
  i: Integer;
begin
  for i := Low(idKeyBufferQueue) to High(idKeyBufferQueue) do
    idKeyBufferFree(idKeyBufferQueue[i]);
  idKeyBufferQueue := nil;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.dsLocateOrdinalPartialMatchRecord(Buffer       : TnxRecordBuffer;
                                                           aFields      : TnxFieldList;
                                                           LookupCursor : TnxAbstractCursor;
                                                     const aKeyValues   : Variant)
                                                                        : TnxResult;
var
  lMinValue     : Int64;
  lMaxValue     : Int64;
  DoFlipOrder   : Boolean;
  v             : Variant;
  S             : string;
  IntOrgValue   : Int64;
  IntSearchValue: Int64;
  SearchCond    : TnxSearchKeyAction;
  t             : string;
  i             : Integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    Result := DBIERR_RECNOTFOUND;
    if TField(aFields.Last) is TIntegerField then with TIntegerField(aFields.Last) do begin
      lMinValue := MinValue;
      if lMinValue = 0 then
        case TField(aFields.Last).DataType of
          ftSmallint:
            lMinValue := Low(SmallInt);
          ftInteger:
            lMinValue := Low(Integer);
          {$IFDEF DCC14OrLater}
          ftShortint:
            lMinValue := Low(ShortInt)
          {$ENDIF}
        end;
      lMaxValue := MaxValue;
      if lMaxValue = 0 then
        case TField(aFields.Last).DataType of
          ftSmallint:
            lMaxValue := High(SmallInt);
          ftInteger:
            lMaxValue := High(Integer);
          ftWord:
            lMaxValue := High(Word);
          {$IFDEF DCC14OrLater}
          ftShortint:
            lMaxValue := High(ShortInt);
          ftByte:
            lMaxValue := High(Byte);
          {$ENDIF}
        end;
    {$IFDEF VER200}
    end else if TField(aFields.Last) is TLongWordField then with TLongWordField(aFields.Last) do begin
      lMinValue := MinValue;
      lMaxValue := MaxValue;
      if (lMaxValue <= 0) or (lMaxValue > High(LongWord)) then
        lMaxValue := High(LongWord);
    {$ENDIF}
    end else if TField(aFields.Last) is TLargeIntField then with TLargeIntField(aFields.Last) do begin
      lMinValue := MinValue;
      if lMinValue = 0 then
        lMinValue := Low(Int64);
      lMaxValue   := MaxValue;
      if lMaxValue = 0 then
        lMaxValue := High(Int64);
    end else
      Exit;

    lMinValue := lMinValue div 10;
    lMaxValue := lMaxValue div 10;

    IntSearchValue := 0;
    SearchCond := skaEqualFirst;

    DoFlipOrder := (LookupCursor = dsAbstractCursor) and dsFlipOrder;
    try
      if VarIsArray(aKeyValues) then
        v := aKeyValues[Pred(aFields.Count)]
      else
        v := aKeyValues;

      if not(VarIsNull(v) or VarIsEmpty(v) or VarIsClear(v)) then begin
        Result := DBIERR_NONE;
        if VarIsStr(v) then begin
          S := v;
          if not TryStrToInt64(S, IntOrgValue) then
            Result := DBIERR_RECNOTFOUND;
        end else begin
          IntOrgValue := v;
          S           := IntToStr(IntOrgValue);
        end;
        if Result = DBIERR_NONE then begin
          IntSearchValue := IntOrgValue;
          if DoFlipOrder then begin
            SearchCond     := skaSmaller;
            IntSearchValue := IntSearchValue + 1;
          end else
            SearchCond := skaGreaterEqual;
        end;
      end;
    except
      Result := DBIERR_RECNOTFOUND;
    end;

    if Result = DBIERR_NONE then repeat
      try
        if (IntSearchValue < lMinValue) or (IntSearchValue > lMaxValue) then begin
          Result := DBIERR_RECNOTFOUND;
          Break;
        end;
        IntSearchValue := IntSearchValue * 10;
        dsFieldsDescriptor.InitRecord(Pointer(Buffer));
        for i := 0 to aFields.Count - 2 do
          AssignVarToField(TField(aFields[i]), aKeyValues[i]);
        {$IFDEF DCC14OrLater}
        TField(aFields.Last).AsLargeInt := IntSearchValue;
        {$ELSE}
        TField(aFields.Last).AsInteger := IntSearchValue;
        {$ENDIF}
      except
        Result := DBIERR_RECNOTFOUND;
        Break;
      end;

      Result := dsAbstractCursor.SetToKey(SearchCond, aFields.Count, 0, False, Pointer(Buffer));

      if Result = DBIERR_NX_FilterTimeout then
        if not dsCancelServerFilter then
          Result := DBIERR_NOCURRREC;

      if (Result = DBIERR_NOCURRREC) or (Result = DBIERR_NONE) then begin
          Result := dsGetNextOrPriorRecord(DoFlipOrder, nxltNoLock, Buffer);
      end else
        Break;

      if Result = DBIERR_NONE then try
        {$IFDEF DCC14OrLater}
        t := IntToStr(TField(aFields.Last).AsLargeInt);
        {$ELSE}
        t := IntToStr(TField(aFields.Last).AsInteger);
        {$ENDIF}
        SetLength(t, Length(S));
        if S <> t then
          Result := DBIERR_RECNOTFOUND;
      except
        Result := DBIERR_RECNOTFOUND;
        Break;
      end;

    until Result = DBIERR_NONE;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxIndexDataSet.Create(AOwner: TComponent);
begin
  idDefaultIndex := True;
  idIndexDefs := TnxIndexDefs.Create(Self);
  idMasterLink := TnxMasterDataLink.Create(Self);  //..
  idMasterLink.OnMasterChange := idMasterChanged;
  idMasterLink.OnMasterDisable := idMasterDisabled;
  inherited;
end;
{------------------------------------------------------------------------------}
{$IFDEF FPC}
procedure TnxIndexDataSet.DataEvent(aEvent: TDataEvent; aInfo: Ptrint);
{$ELSE}
procedure TnxIndexDataSet.DataEvent(aEvent: TDataEvent; aInfo: TnxNativeInt);
{$ENDIF}
begin
  if (aEvent = dePropertyChange) then
    IndexDefs.Updated := False;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.DeleteQueuedKey(aIndex: Integer);
begin
  idDeleteQueuedKey(aIndex);
end;
{------------------------------------------------------------------------------}
destructor TnxIndexDataSet.Destroy;
begin
  inherited;
  nxFreeAndNil(idIndexDefs);
  nxFreeAndNil(idMasterLink);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.DoOnNewRecord;
var
  i : Integer;
begin
  with idMasterLink, Fields do
    if Active and (Count > 0) then
      for i := 0 to Pred(Count) do
        IndexFields[i] := TField(Items[i]);

  inherited DoOnNewRecord;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.dsApplyMasterRange(aFollowedByFirst: Boolean) : Boolean; //..
begin
     dsStartBusy;
	    try
	      Result := False;
       With idMasterLink do
         If   Active and ( ( Fields.Count>0 ) or Assigned( FOnSetLinkRange ) or Assigned( FOnApplyMasterRange ) ) //..
         then begin
              idSetLinkRange( Fields );
              Result := idSetCursorRange( aFollowedByFirst );
              If   Result and Assigned( FOnApplyMasterRange )  //..
              then FOnApplyMasterRange( Self );
              end;
     finally
       dsEndBusy;
       end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.dsDestroyLookupCursor;
begin
  nxFreeAndNil(idLookupCursorID);
  idLookupFieldNames := '';
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.dsFreeKeyBuffers;
var
  KeyIndex: TnxKeyIndex;
begin
  for KeyIndex := Low(KeyIndex) to High(KeyIndex) do begin
    nxFreeMem(idKeyBuffers[KeyIndex]);
    idKeyBuffers[KeyIndex] := nil;
  end;
  ClearQueuedKeys;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.dsGetActiveKeyBuffer(var aBuffer: TnxRecordBuffer): Boolean;
begin
  aBuffer := nil;
  Result := Assigned(idKeyBuffer);
  if Result then begin
    Result := not idKeyBuffer.kbDirectKey;
    if Result then
      aBuffer := TnxRecordBuffer(@idKeyBuffer.kbBuffer);
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.dsGetActiveKeyBufferForBatch(var aBuffer: TnxRecordBuffer): Boolean;
var
  KeyBuffer : PnxDataSetKeyBuffer;
begin
  if (dsiInGotoQueuedKeys in dsInternalState) and
     (State = dsBlockRead) and
     (dsBlockReadTotalPos > 0) and
     (Pred(dsBlockReadTotalPos) <= High(idKeyBufferQueue))
  then begin
    KeyBuffer := idGetQueuedKeyBuffer(Pred(dsBlockReadTotalPos));
    Result := Assigned(KeyBuffer);
    if Result then
      if KeyBuffer.kbDirectKey then begin
        if not idIndexDirectKey and
           (dsoBuildKeyOnQueue in dsOptions)
        then begin
          aBuffer := TnxRecordBuffer(TempBuffer);
          Result := AbstractCursor.KeyToRecord(PnxKeyBuffer(@KeyBuffer.kbBuffer), PnxRecordBuffer(aBuffer)) = DBIERR_NONE;
        end else
          Result := False;
        if not Result then
          aBuffer := nil;
      end else
        aBuffer := TnxRecordBuffer(@idKeyBuffer.kbBuffer);
  end else
    Result := inherited dsGetActiveKeyBufferForBatch(aBuffer);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.dsInitBookmarkSize;
begin
  idInitIndexMap;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.dsInitKeyBuffers;
var
  KeyIndex: TnxKeyIndex;
begin
  idKeyBufferSizeRec := SizeOf(TnxDataSetKeyBuffer) + dsRecordLength;
  idKeyBufferSizeKey := SizeOf(TnxDataSetKeyBuffer) + idIndexKeySize;

  if idIndexDirectKey then
    idKeyBufferSize := idKeyBufferSizeKey
  else
    idKeyBufferSize := idKeyBufferSizeRec;

  try
    for KeyIndex := Low(KeyIndex) to High(KeyIndex) do
      idKeyBuffers[KeyIndex] := idKeyBufferAlloc;
  except
    dsFreeKeyBuffers;
    raise;
  end;

  if disIndexInvalid in dsInternalState then begin
    Exclude(dsInternalState, disIndexInvalid);
    idSwitchToIndex(idIndexName);
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.dsLocateRecord(const aKeyFields  : string;
                                        const aKeyValues  : Variant;
                                              aOptions    : TLocateOptions;
                                              aSyncCursor : Boolean)
                                                          : Boolean;

var
  Idx             : Integer;
  FieldCount      : Integer;
  PartialLength   : Integer;
  Buffer          : TnxRecordBuffer;
  Fields          : TnxFieldList;
  LookupCursor    : TnxAbstractCursor;
  Filter          : TnxBaseFilterDescriptor;
  Status          : TnxResult;
  CaseInsensitive : Boolean;
  SaveState       : TDataSetState;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    CursorPosChanged;

    if dsInternalWriteOnly then
      Result := False
    else begin
      Buffer := Pointer(TempBuffer);
      Fields := TnxFieldList.Create;
      try
        GetFieldList(Fields, aKeyFields);

        CaseInsensitive := loCaseInsensitive in aOptions;

        if idMapsToIndex(Fields, CaseInsensitive) then
          LookupCursor := dsAbstractCursor
        else
          LookupCursor := idGetLookupCursor(aKeyFields, Fields, CaseInsensitive);

        if Assigned(LookupCursor) then begin
          SaveState := SetTempState(dsFilter);
          dsRecordToFilter := Buffer;
          try
            dsFieldsDescriptor.InitRecord(Pointer(Buffer));
            FieldCount := Fields.Count;
            if FieldCount = 1 then begin
              if VarIsArray(aKeyValues) then
                AssignVarToField(TField(Fields.First), aKeyValues[0])
              else
                AssignVarToField(TField(Fields.First), aKeyValues);
            end else
              for Idx := 0 to Pred(FieldCount) do
                AssignVarToField(TField(Fields[Idx]), aKeyValues[Idx]);

            PartialLength := 0;
            if (loPartialKey in aOptions) and (TField(Fields.Last).DataType in
               [ftString, ftFixedChar, ftWideString]) then
              PartialLength := Pred(High(Integer));

            Status := idGetRecordForKey
              (LookupCursor, FieldCount, PartialLength, False, Buffer, Buffer);

            if (dsoAllowPartialMatchIndexedLocateForIntegers in dsOptions) and
               (Status <> DBIERR_NONE) and
               (loPartialKey in aOptions)
            then Status := dsLocateOrdinalPartialMatchRecord(Buffer, Fields,
              LookupCursor, aKeyValues);

          finally
            dsRecordToFilter := nil;
            RestoreState(SaveState);
          end;

          if (Status = DBIERR_NONE)
            and aSyncCursor
            and (LookupCursor <> dsAbstractCursor)
          then begin
            if not dsNoCMR then
              dsAbstractCursor.AddCursorOption(acoSetToCursorFollowedBySyncExact);
            try
              Status := dsAbstractCursor.SetToCursor(LookupCursor);
            finally
              dsAbstractCursor.RemoveCursorOption(acoSetToCursorFollowedBySyncExact);
            end;
          end;

        end else begin

          Filter := dsCreateLookupFilter(Fields, aKeyValues, aOptions);
          try
            Status := dsAbstractCursor.SetToFilter(Filter, nil, not dsFlipOrder);
            if (Status = DBIERR_NONE) and not aSyncCursor then
              Status := dsAbstractCursor.RecordGet(nxltNoLock, Pointer(Buffer));
          finally
            nxFreeAndNil(Filter);
          end;

        end;

      finally
        Fields.Free;
      end;

      case Status of
        DBIERR_NONE:
          Result := True;
        DBIERR_NOCURRREC, DBIERR_RECNOTFOUND:
          Result := False;
      else
        dsCheck(Status);
        Result := False;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.EditKey;
begin
  idSetKeyBuffer(kiLookup, False);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.EditQueuedKey(aIndex: Integer);
begin
  idSetQueuedKeyBuffer(aIndex, False);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.EditRangeEnd;
begin
  idSetKeyBuffer(kiRangeEnd, False);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.EditRangeStart;
begin
  idSetKeyBuffer(kiRangeStart, False);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.FindKey(const aKeyValues: array of const): Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    idSetKeyFields(kiLookup, aKeyValues, EmptySetKeyOptions);
    Result := GotoKey;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.FindKey(const aKeyValues : array of const;
                                       aOptions   : TnxSetKeyOptions)
                                                  : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    idSetKeyFields(kiLookup, aKeyValues, aOptions);
    Result := GotoKey;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.FindNearest(const aKeyValues: array of const);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    idSetKeyFields(kiLookup, aKeyValues, EmptySetKeyOptions);
    GotoNearest;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.FindNearest(const aKeyValues : array of const;
                                            aOptions   : TnxSetKeyOptions);
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    idSetKeyFields(kiLookup, aKeyValues, aOptions);
    GotoNearest;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.GetDataSource: TDataSource;
begin
  Result := MasterSource;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.GetIndexNames(aList: TStrings);
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
  IndexDefs.Update;
{$IFDEF FPC}
  aList.BeginUpdate;
  with IndexDefs do try
    aList.Clear;
    for I := 0 to Count - 1 do
      with TIndexDef(Items[I]) do
        if Name <> '' then
          aList.Add(Name);
  finally
    aList.EndUpdate;
  end;
{$ELSE}
  IndexDefs.GetItemNames(aList);
{$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.GetIsIndexField(Field: TField): Boolean;
var
  i : Integer;
begin
  Result := True;
  for i := Low(idIndexFieldMap) to High(idIndexFieldMap) do
    if Field.FieldNo = idIndexFieldMap[i] then
      Exit;
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.GotoKey: Boolean;
var
  KeyBuffer  : PnxDataSetKeyBuffer;
  Status     : TnxResult;
  FieldCount : Integer;
begin
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    DoBeforeScroll;
    try
      CursorPosChanged;

      KeyBuffer := idGetKeyBuffer(kiLookup);

      idBeforeGetRecordForKey;
      try
        FieldCount := KeyBuffer^.kbFieldCount;
        if FieldCount = 0 then
          FieldCount := Length(idIndexFieldMap);
        if KeyBuffer^.kbPartialLen > 0 then
          Dec(FieldCount);

        if (not dsNoCMR) and (not dsInternalWriteOnly) then
          dsAbstractCursor.AddCursorOption(acoRecordGetForKeyFollowedByRecordGet);
        try
          Status := idGetRecordForKey(dsAbstractCursor, FieldCount,
            KeyBuffer^.kbPartialLen, idIndexDirectKey,
            Pointer(TnxRecordBuffer(KeyBuffer) + SizeOf(TnxDataSetKeyBuffer)), nil);
        finally
          dsAbstractCursor.RemoveCursorOption(acoRecordGetForKeyFollowedByRecordGet);
        end;

        if not ((Status = DBIERR_NONE) or (Status = DBIERR_RECNOTFOUND)) then
          dsCheck(Status);
      finally
        idAfterGetRecordForKey;
      end;

      Result := Status = DBIERR_NONE;

      if Result and not dsInternalWriteOnly then begin
        Resync([rmExact, rmCenter]);
        DoAfterScroll;
      end;
    finally
      dsInsideScroll := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.GotoNearest;
var
  KeyBuffer  : PnxDataSetKeyBuffer;
  SearchCond : TnxSearchKeyAction;
  Status     : TnxResult;
  FieldCount : Integer;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBiDirectional;

    CheckBrowseMode;
    DoBeforeScroll;
    try
      CursorPosChanged;

      KeyBuffer := idGetKeyBuffer(kiLookup);

      if dsFlipOrder then
        if KeyBuffer^.kbExclusive then
          SearchCond := skaSmaller
        else
          SearchCond := skaSmallerEqual
      else
        if KeyBuffer^.kbExclusive then
          SearchCond := skaGreater
        else
          SearchCond := skaGreaterEqual;
      idBeforeGetRecordForKey;
      try
        FieldCount := KeyBuffer^.kbFieldCount;
        if FieldCount = 0 then
          FieldCount := Length(idIndexFieldMap);
        if KeyBuffer^.kbPartialLen > 0 then
          Dec(FieldCount);

        if not dsNoCMR and not dsInternalWriteOnly then
          dsAbstractCursor.AddCursorOption(acoSetToKeyFollowedBySync);
        try
          Status := dsAbstractCursor.SetToKey(SearchCond, FieldCount,
            KeyBuffer^.kbPartialLen, idIndexDirectKey,
            Pointer(TnxRecordBuffer(KeyBuffer) + SizeOf(TnxDataSetKeyBuffer)));
        finally
          dsAbstractCursor.RemoveCursorOption(acoSetToKeyFollowedBySync);
        end;

        if Status = DBIERR_NX_FilterTimeout then
          if not dsCancelServerFilter then
            Status := dsGetNextOrPriorRecord(dsFlipOrder, nxltNoLock, nil)
      finally
        idAfterGetRecordForKey;
      end;

      dsCheck(Status);
      if not dsInternalWriteOnly then
      begin
        Resync([rmCenter]);
        DoAfterScroll;
      end;
    finally
      dsInsideScroll := False;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.GotoNearestBackward;
begin
  dsStartBusy;
  try
    dsFlipOrder := not dsFlipOrder;
    try
      if dsFlipOrder then
        dsAbstractCursor.AddCursorOption(acoFlipOrder)
      else
        dsAbstractCursor.RemoveCursorOption(acoFlipOrder);
      GotoNearest;
    finally
      dsFlipOrder := not dsFlipOrder;
      if dsFlipOrder then
        dsAbstractCursor.AddCursorOption(acoFlipOrder)
      else
        dsAbstractCursor.RemoveCursorOption(acoFlipOrder);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.GotoQueuedKeys(aBlockReadSize : Integer = High(Integer)): Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    Result := Length(idKeyBufferQueue) > 0;
    if Result then begin
      if aBlockReadSize < 1 then
        aBlockReadSize := 1;
      Include(dsInternalState, dsiInGotoQueuedKeys);
      BlockReadSize := aBlockReadSize;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.HasActiveRange: Boolean;
begin
  Result := Active and idHasActiveRange;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.HasActiveRangeEnd: Boolean;
begin
  Result := Active and idHasActiveRangeEnd;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.HasActiveRangeStart: Boolean;
begin
  Result := Active and idHasActiveRangeStart;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idAddIndexDefsToIndicesDesc(aIndexDefs : TIndexDefs;
                                                      aIndices   : TnxMainIndicesDescriptor);
var
  SeqAccessName : string;
  i             : Integer;
begin
  SeqAccessName := csSeqAccessIndexName;
  for i := 0 to Pred(aIndexDefs.Count) do
    with aIndexDefs[i] do
      if not SameText(Name, SeqAccessName) and (Fields <> '') then
        idAddIndexDefToIndicesDesc(aIndexDefs[i], aIndices);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idAddIndexDefToIndicesDesc(aIndexDef : TIndexDef;
                                                     aIndices  : TnxMainIndicesDescriptor);
var
  FieldsDescriptor : TnxFieldsDescriptor;
  EFNPOS           : Integer;
  Fld              : string;
  FldList          : array of Integer;
  FldsInKey        : Integer;
  CaseInsFlds      : TStringList;
  DescFlds         : TStringList;
  KFD              : TnxKeyFieldDescriptor;
begin
  FieldsDescriptor := TnxFieldsDescriptor(aIndices.
    GetRelatedDescriptorOfType(TnxFieldsDescriptor));

  with aIndexDef do begin
    { Get Field List }
    EFNPOS := 1;
    FldsInKey := 0;
    FldList := nil;
    while EFNPos <= Length(Fields) do begin
       Fld:= ExtractFieldName(Fields, EFNPos);
       if (Fld<>'') and
          (Fld[length(Fld)]=';') then
          System.delete(Fld, length(Fld), 1);
      SetLength(FldList, Succ(FldsInKey));
      FldList[FldsInKey] := FieldsDescriptor.GetFieldFromName(Fld);
      if FldList[FldsInKey] < 0 then
        dsError(DBIERR_INVALIDFIELDNAME);
      Inc(FldsInKey);
    end;

    CaseInsFlds := TStringList.Create;
    try
      CaseInsFlds.Sorted := True;
      CaseInsFlds.Duplicates := dupIgnore;

      EFNPOS := 1;
      while EFNPos <= Length(CaseInsFields) do begin
         Fld := ExtractFieldName(CaseInsFields, EFNPos);
         if (Fld<>'') and (Fld[length(Fld)]=';') then
           System.Delete(Fld, length(Fld), 1);
        CaseInsFlds.Add(Fld);
      end;

      DescFlds := TStringList.Create;
      try
        DescFlds.Sorted := True;
        DescFlds.Duplicates := dupIgnore;

        EFNPOS := 1;
        while EFNPos <= Length(DescFields) do begin
           Fld := ExtractFieldName(DescFields, EFNPos);
           if (Fld<>'') and (Fld[length(Fld)]=';') then
             System.Delete(Fld, length(Fld), 1);
          DescFlds.Add(Fld);
        end;

        with aIndices.AddIndex(Name, 0, not (ixUnique in Options), '',
          TnxCompKeyDescriptor), TnxCompKeyDescriptor(KeyDescriptor) do begin
            for FldsInKey := Low(FldList) to High(FldList) do begin

              if FieldsDescriptor.FieldDescriptor[FldList[FldsInKey]].fdType in
                [nxtChar, nxtWideChar, nxtShortString, nxtNullString,
                  nxtWideString] then begin
                KFD := Add(FldList[FldsInKey], TnxExtTextKeyFieldDescriptor);
                TnxExtTextKeyFieldDescriptor(KFD).IgnoreCase := ixCaseInsensitive in Options;
                if CaseInsFlds.IndexOf(FieldsDescriptor.FieldDescriptor[FldList[FldsInKey]].Name) >= 0 then
                  TnxExtTextKeyFieldDescriptor(KFD).IgnoreCase := True;
              end else
                KFD := Add(FldList[FldsInKey]);

              KFD.Ascend := not (ixDescending in Options);
              if DescFlds.IndexOf(FieldsDescriptor.FieldDescriptor[FldList[FldsInKey]].Name) >= 0 then
                KFD.Ascend := False;
            end;

          if ixPrimary in Options then
            aIndices.DefaultIndex := Number;
        end;
      finally
        nxFreeAndNil(DescFlds);
      end;
    finally
      nxFreeAndNil(CaseInsFlds);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idAfterGetRecordForKey;
begin
  {can be overriden}
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idBeforeGetRecordForKey;
begin
  {can be overriden}
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idCheckSetKeyMode;
begin
  if State <> dsSetKey then DatabaseError(SNotEditing, Self);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idCursorOpen(const aTableName   : string;
                                      const aPassword    : UnicodeString;
                                            aReadOnly    : Boolean;
                                            aExclusive   : Boolean;
                                            aChainedRead : Boolean)
                                                         : TnxResult;
var
  DB                      : TnxAbstractDatabase;
  IndexName               : string;
  IndexID                 : Integer;
  CurrentIndexID          : Integer;
  OpenOptions             : TnxCursorOpenOptions;
  lFilterTimeout          : TnxWord32;
  lMarkedBlobsByFieldName : TStrings;
  lTransContext           : TnxAbstractTransContext;
const
  OpenMode  : array[Boolean] of TnxOpenMode  = (omReadWrite , omReadOnly);
  ShareMode : array[Boolean] of TnxShareMode = (smShared    , smExclusive);
begin
  dsStartBusy;
  try
    Assert(not Assigned(dsAbstractCursor));

    DB := Database.bdbAbstractDatabase;
    if not Assigned(DB) then begin
      Result := DBIERR_UNKNOWNDB;
      Exit;
    end;

    IndexName := '';
    if not dsNoCMR then
      if not (idDefaultIndex or idFieldsIndex) then
        IndexName := idIndexName;

    lMarkedBlobsByFieldName := nil;
    OpenOptions := [];

    if dsoNoClientCache in dsOptions then
      Include(OpenOptions, cooNoClientCache);

    if not dsNoCMR and
       aChainedRead and
       (not dsWriteOnly) and
       (not dsInternalWriteOnly) and
       (Filter = '') and
       (dsBlockReadSize = 0) and
       (not (idMasterLink.Active and (idMasterLink.Fields.Count > 0)))
    then begin
      Include(OpenOptions, cooRequestMultipartRecordGet);
      Include(OpenOptions, cooRecordGetFollowedByGetBookmark);
      if FlipOrder then
        Include(OpenOptions, cooFlipOrder);
      if (dsoPreCacheMarkedBlobs in dsOptions) and
         Assigned(dsMarkedBlobsByFieldName) and
         (dsMarkedBlobsByFieldName.Count > 0)
      then
        lMarkedBlobsByFieldName := dsMarkedBlobsByFieldName;
    end;

    lFilterTimeout := nxDefaultFilterTimeout;
    if not dsNoCMR then
      lFilterTimeout := dsFilterTimeout;

    lTransContext := nil;
    if Assigned(TransContext) then
      lTransContext := TransContext.tcAbstractTransContext;

    {try to open the table}
    dsAbstractCursor := nil;
    Result := DB.CursorOpen
      (dsAbstractCursor,
       lTransContext,
       aTableName,
       aPassword,
       OpenMode[aReadOnly],
       ShareMode[aExclusive],
       dsGetTimeOut,
       IndexName,
       -1,
       DB.ExplicitAllowSystem,
       OpenOptions,
       lFilterTimeout,
       lMarkedBlobsByFieldName);

    if Result = DBIERR_NONE then begin
      Assert(Assigned(dsAbstractCursor));

      if not dsNoCMR then
        Include(dsInternalState, disJustOpenedCursor);
      if cooRequestMultipartRecordGet in OpenOptions then
        Include(dsInternalState, disFirstRecordGetNextPriorAfterOpen);

      dsSetupCursorDependentState;

      if idDefaultIndex then
        idIndexName := idResolveIndexName('', False)
      else if idFieldsIndex then
        idIndexName := idResolveIndexName(idIndexFieldNames, True)
      else
        idIndexName := idResolveIndexName(idIndexName, False);

      if dsNoCMR then
        Include(dsInternalState, disIndexInvalid)
      else begin
        IndexID := dsTableDescriptor.GetIndexFromName(idIndexName);
        if (dsAbstractCursor.GetIndexID(CurrentIndexID) <> DBIERR_NONE) or
          (IndexID <> CurrentIndexID) then
          Include(dsInternalState, disIndexInvalid)
      end;
    end else begin
      Assert(not Assigned(dsAbstractCursor));
      dsClearCursorDependentState;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idDeleteQueuedKey(aIndex: Integer);
var
  KeyBuffer: PnxDataSetKeyBuffer;
  i        : Integer;
begin
  KeyBuffer :=  idGetQueuedKeyBuffer(aIndex);
  if (idKeyBuffer = KeyBuffer) or
     (idKeyBufferEditQueued = KeyBuffer)
  then begin
    SetState(dsBrowse);
    idKeyBuffer := nil;
    idKeyBufferEditQueued := nil;
    DataEvent(deDataSetChange, 0);
  end;

  Assert(idKeyBuffer <> KeyBuffer);
  i := aIndex + 1;
  while i <= High(idKeyBufferQueue) do begin
    idKeyBufferQueue[i - 1] := idKeyBufferQueue[i];
    Inc(i);
  end;
  SetLength(idKeyBufferQueue, Length(idKeyBufferQueue) - 1);

  idKeyBufferFree(KeyBuffer);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idFieldDefsStored: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetIndexDefs: TIndexDefs;
begin
  Result := idIndexDefs;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetIndexField(aInx: Integer): TField;
var
  FieldNo: Integer;
begin
  if (aInx < Low(idIndexFieldMap)) or (aInx > High(idIndexFieldMap)) then
    DatabaseError(SFieldIndexError, Self);
  FieldNo := idIndexFieldMap[aInx];
  Result := FieldByNumber(FieldNo);
  if Result = nil then
    DatabaseErrorFmt(SIndexFieldMissing, [FieldDefs[FieldNo - 1].Name], Self);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetIndexFieldCount: Integer;
begin
  Result := Length(idIndexFieldMap);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetIndexFieldNames: string;
begin
  if idFieldsIndex and not idDefaultIndex then
    Result := idIndexFieldNames
  else
    Result := '';
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetIndexName: string;
begin
  if not idFieldsIndex and not idDefaultIndex then
    Result := idIndexName
  else
    Result := '';
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetKeyBuffer(aKeyIndex : TnxKeyIndex)
                                                  : PnxDataSetKeyBuffer;
begin
  Result := idKeyBuffers[aKeyIndex];
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetKeyExclusive: Boolean;
begin
  idCheckSetKeyMode;
  Result := idKeyBuffer.kbExclusive;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetKeyFieldCount: Integer;
begin
  idCheckSetKeyMode;
  Result := idKeyBuffer.kbFieldCount;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetKeyPartialLen: Integer;
begin
  idCheckSetKeyMode;
  Result := idKeyBuffer.kbPartialLen;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetLookupCursor(const aFieldNames      : string;
                                                 aFields          : TnxFieldList;
                                                 aCaseInsensitive : Boolean)
                                                                  : TnxAbstractCursor;
var
  i, j       : Integer;
  Acceptable : Boolean;
  IndexName  : string;
begin
  dsStartBusy;
  try
    if (aFieldNames <> idLookupFieldNames) or
      (aCaseInsensitive <> idLookupCaseIns) then begin
      dsDestroyLookupCursor;
      if not idHasActiveRange then begin

        IndexName := '';
        with dsTableDescriptor, dsFieldsDescriptor do
          if assigned(IndicesDescriptor) then
            with IndicesDescriptor do
              for i:= 0 to Pred(IndexCount) do
                with IndexDescriptor[i] do
                  if KeyDescriptor is TnxCompKeyDescriptor then
                    with TnxCompKeyDescriptor(KeyDescriptor) do begin
                      if KeyFieldCount < aFields.Count then
                        Continue;
                      Acceptable := True;
                      for j:= 0 to Pred(aFields.Count) do
                        with KeyFields[j] do begin
                          if Succ(FieldNumber) <> TField(aFields[j]).FieldNo then begin
                            Acceptable := False;
                            Break;
                          end;

                          if Field.fdType in [nxtChar, nxtWideChar, nxtShortString,
                            nxtNullString, nxtWideString] then
                            if ((KeyFields[j] is TnxTextKeyFieldDescriptor) and
                              TnxTextKeyFieldDescriptor(KeyFields[j]).IgnoreCase)
                              <> aCaseInsensitive then begin
                              Acceptable := False;
                              Break;
                            end;
                        end;
                      if Acceptable then begin
                        IndexName := Name;
                        Break;
                      end;
                    end;

        if IndexName <> '' then begin
          dsCheck(dsAbstractCursor.Duplicate(omReadOnly, idLookupCursorID));
          try
            dsCheck(idLookupCursorID.SwitchToIndex(IndexName, -1, porFalse));
          except
            dsDestroyLookupCursor;
            raise;
          end;
        end;

        idLookupFieldNames := aFieldNames;
        idLookupCaseIns := aCaseInsensitive;
      end;
    end;
    Result := idLookupCursorID;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetMasterFields: string;
begin
  Result := idMasterLink.FieldNames;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetMasterSource: TDataSource;
begin
  Result := idMasterLink.DataSource;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetQueuedKeyBuffer(aIndex: Integer): PnxDataSetKeyBuffer;
begin
  if Cardinal(aIndex) > Cardinal(High(idKeyBufferQueue)) then
    dsError(DBIERR_OUTOFRANGE);
  Result := idKeyBufferQueue[aIndex];
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetQueuedKeyCount: Integer;
begin
  Result := Length(idKeyBufferQueue);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetQueuedKeyFound: Boolean;
var
  RecordBuffer: TnxRecordBuffer;
begin
  Result := False;

  if (dsiInGotoQueuedKeys in dsInternalState) and
     (State = dsBlockRead) and
     (dsBlockReadTotalPos > 0) and
     (Pred(dsBlockReadTotalPos) <= High(idKeyBufferQueue))
  then
    Result := dsGetActiveBuffer(RecordBuffer) and
      (dsBlockReadCurrentError = DBIERR_NONE);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idGetRecordForKey(aCursor        : TnxAbstractCursor;
                                           aFields        : Integer;
                                           aPartialLength : Integer;
                                           aDirectKey     : Boolean;
                                           aInBuffer      : Pointer;
                                           aOutBuffer     : Pointer)
                                                          : TnxResult;
var
  FirstCall : Boolean;
begin
  dsStartBusy;
  try
    if aFields = 0 then
      aFields := Length(idIndexFieldMap);
    if aPartialLength > 0 then
      Dec(aFields);

    FirstCall := True;
    repeat
      Result := aCursor.RecordGetForKey(aFields, aPartialLength, aDirectKey,
        aInBuffer, aOutBuffer, not dsFlipOrder, FirstCall);
      if Result = DBIERR_NX_FILTERTimeout then begin
        if dsCancelServerFilter then
          Break
        else
          FirstCall := False;
      end else
        Break;
    until False;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idHasActiveRange: Boolean;
begin
  Result := idHasActiveRangeStart or idHasActiveRangeEnd;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idHasActiveRangeEnd: Boolean;
begin
  Result := idKeyBuffers[kiCurRangeEnd].kbModified;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idHasActiveRangeStart: Boolean;
begin
  Result := idKeyBuffers[kiCurRangeStart].kbModified;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idIndexDefsStored: Boolean;
begin
  Result := False;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idInitIndexMap;
var
  i, j : Integer;
begin
  idIndexFieldMap := nil;
  idIndexFieldMapNC := nil;
  idIndexDirectKey := False;
  idDirectKeySetFields := nil;
  with dsTableDescriptor, dsFieldsDescriptor do begin
    if Assigned(IndicesDescriptor) then
      with IndicesDescriptor do begin
        i := GetIndexFromName(idIndexName);
        if i >= 0 then begin
          Self.BookmarkSize := BookmarkSize[i];
          with IndexDescriptor[i] do begin
            idIndexKeySize := KeyDescriptor.KeyLen;

            if KeyDescriptor is TnxCompKeyDescriptor then
              with TnxCompKeyDescriptor(KeyDescriptor) do begin
                SetLength(idIndexFieldMap, KeyFieldCount);
                SetLength(idIndexFieldMapNC, KeyFieldCount);
                for j:= 0 to Pred(KeyFieldCount) do
                  with KeyFields[j] do begin
                    idIndexFieldMap[j] := Succ(FieldNumber);
                    idIndexFieldMapNC[j] :=
                      ((KeyFields[j] is TnxTextKeyFieldDescriptor) and
                        TnxTextKeyFieldDescriptor(KeyFields[j]).IgnoreCase);
                  end;
              end
            else if KeyDescriptor is TnxMainIndexTokenKeyDescriptor then begin
              idIndexDirectKey := True;
              idDirectKeySetFields := idTokenIndexSetFields;
            end else if KeyDescriptor is TnxRefKeyDescriptor then begin
              idIndexDirectKey := True;
              idDirectKeySetFields := idRefIndexSetFields;
            end;
          end;
        end else
          Self.BookmarkSize := BookmarkSize[0];
      end
    else
      Self.BookmarkSize := BookmarkSize[0];
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idInitKeyBuffer(aBuffer: PnxDataSetKeyBuffer): PnxDataSetKeyBuffer;
begin
  Result := aBuffer;
  nxFillChar(aBuffer^, SizeOf(TnxDataSetKeyBuffer), 0);

  aBuffer.kbDirectKey := idIndexDirectKey;
  aBuffer := Pointer(TnxRecordBuffer(aBuffer) + SizeOf(TnxDataSetKeyBuffer));

  if idIndexDirectKey then
    nxFillChar(aBuffer^, idIndexKeySize, 0)
  else begin
    dsFieldsDescriptor.InitRecord(Pointer(aBuffer));
    if Assigned(dsDefaultValueHandler) then
      dsDefaultValueHandler.SetDefaultValuesInsert(Pointer(aBuffer));
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idKeyBufferAlloc: PnxDataSetKeyBuffer;
begin
  Result := idInitKeyBuffer(nxGetMem(idKeyBufferSize));
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idKeyBufferFree(var aKeyBuffer: PnxDataSetKeyBuffer);
begin
  nxFreeMem(aKeyBuffer);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idMapsToIndex(aFields          : TnxFieldList;
                                       aCaseInsensitive : Boolean)
                                                        : Boolean;
var
  Idx           : Integer;
begin
  Result := False;

  if aFields.Count > Length(idIndexFieldMap) then
    Exit;

  for Idx := 0 to Pred(aFields.Count) do
    with TField(aFields[Idx]) do begin
      if FieldNo <> idIndexFieldMap[Idx] then
        Exit;

      if DataType in [ftString, ftFixedChar, ftWideString] then
        if idIndexFieldMapNC[Idx] <> aCaseInsensitive then
          Exit;
    end;

  Result := True;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idMasterChanged(Sender: TObject);
begin
  dsStartBusy;
  try  
    If   Active
    then begin
         CheckBrowseMode;
         If   dsApplyMasterRange( { aFollowedByFirst } True )    //.. aFollowedByFirst solo es aplicable cuando no está activa la opción dsNoCMR,
         then First;                                             //.. y, aun así, no provoca en el cliente los eventos asociados a un First clásico
         end;
  finally
    dsEndBusy;
	end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idMasterDisabled(Sender: TObject);
begin
  dsStartBusy;
  try
    CancelRange;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idPostKeyBuffer(aCommit: Boolean);
var
  lTempKeyBuffer: PnxDataSetKeyBuffer;
begin
  DataEvent(deCheckBrowseMode, 0);

  if (idKeyBuffer = idKeyBuffers[kiQueuedKey]) then begin
    { we are editing a key that has been reduced from a record buffer to a direct key }
    Assert(Assigned(idKeyBufferEditQueued));
    if aCommit then begin
      Assert(idKeyBufferEditQueued.kbDirectKey);
      Assert(not idKeyBuffer.kbDirectKey);
      { we need to build a key from the record buffer again }
      idKeyBuffer.kbModified := Modified;

      lTempKeyBuffer := nxGetZeroMem(idKeyBufferSizeKey);
      try
        { we are building the key into a temporary buffer, so that we don't
          overwrite the }
        dsCheck(AbstractCursor.BuildKey(
          @idKeyBuffer.kbBuffer,
          @lTempKeyBuffer.kbBuffer,
          True
        ));
        lTempKeyBuffer^ := idKeyBuffer^;
        lTempKeyBuffer.kbDirectKey := True;

        nxMove(lTempKeyBuffer^, idKeyBufferEditQueued^, idKeyBufferSizeKey);
      finally
        nxFreeMem(lTempKeyBuffer);
      end;
    end else begin
      { don't need to do anything, the original buffer is untouched }
    end;
  end else begin
    if aCommit then
      idKeyBuffer.kbModified := Modified
    else
      nxMove(idKeyBuffers[kiSave]^, idKeyBuffer^, idKeyBufferSize);
  end;

  SetState(dsBrowse);

  idKeyBuffer := nil;
  idKeyBufferEditQueued := nil;

  DataEvent(deDataSetChange, 0);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idQueueKey(aKeyBuffer: PnxDataSetKeyBuffer);
var
  l      : Integer;
begin
  l := Length(idKeyBufferQueue);
  SetLength(idKeyBufferQueue, Succ(l));
  idKeyBufferQueue[l] := aKeyBuffer;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idRefIndexSetFields(const aValues1 : array of const;
                                              const aValues2 : array of const;
                                                    aOptions : TnxSetKeyOptions);

  procedure Error;
  begin
    DatabaseErrorFmt(SFieldValueError, ['<RefNr>']);
  end;

var
  AnsiStr : AnsiString;
  S       : string;
  i       : Int64;
  v       : PVarRec;
begin
  s := '';
  I := 0;
  v := nil;

  case Length(aValues1) of
    0: case Length(aValues2) of
         0: ;
         1: v := @aValues2[0];
       else
         Error;
       end;
    1: begin
      if Length(aValues2) <> 0 then
        Error;
      v := @aValues1[0]
    end;
  else
    Error;
  end;

  idInitKeyBuffer(idKeyBuffer);
  if assigned(v) then
    with v^ do begin
      case VType of
        vtString: begin
          AnsiStr := VString^;
          s := string(AnsiStr);
        end;
        vtPointer:
          if VPointer <> nil then
            Error;
        vtPChar: begin
          AnsiStr := VPChar;
          s := string(AnsiStr);
        end;
        vtAnsiString: begin
          AnsiStr := AnsiString(VAnsiString);
          s := string(AnsiStr);
        end;
        vtVariant:
          if not (VarIsEmpty(VVariant^) or VarIsNull(VVariant^)) then
            s := VVariant^;
        vtWideChar:
          s := VWideChar;
        vtPWideChar:
          s := VPWideChar;
        vtWideString:
          s := WideString(VWideString);
        vtInt64:
          i := VInt64^;
        {$IFDEF DCC12OrLater}
        vtUnicodeString:
          s := UnicodeString(VUnicodeString);
        {$ENDIF}
      else
        Error;
      end;

      if s <> '' then
        i := StrToInt64(s);

      idKeyBuffer.kbModified := i <> 0;
      PnxInt64(TnxRecordBuffer(idKeyBuffer) + SizeOf(TnxDataSetKeyBuffer))^ := i;
    end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idResetCursorRange(aFollowedBySync: Boolean): Boolean;
begin
  dsStartBusy;
  try
    Result := False;
    if dsWriteOnly then
      Exit;
    if dsInternalWriteOnly then
      aFollowedBySync := False;
    if idHasActiveRange then begin
      if aFollowedBySync and not dsNoCMR then
        dsAbstractCursor.AddCursorOption(acoRangeResetFollowedBySync);
      try
        dsCheck(dsAbstractCursor.RangeReset);
      finally
        dsAbstractCursor.RemoveCursorOption(acoRangeResetFollowedBySync);
      end;
      idInitKeyBuffer(idKeyBuffers[kiCurRangeStart]);
      idInitKeyBuffer(idKeyBuffers[kiCurRangeEnd]);
      dsDestroyLookupCursor;
      Result := True;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idResolveIndexName(const aValue       : string;
                                                  aFieldsIndex : Boolean)
                                                               : string;
begin
  UpdateIndexDefs;
  if aValue <> '' then begin
    if aFieldsIndex then
      Result := IndexDefs.FindIndexForFields(aValue).Name
    else begin
      if IndexDefs.IndexOf(aValue) < 0 then
        dsError(DBIERR_NOSUCHINDEX);
      Result := aValue;
    end;
  end else
    with dsTableDescriptor do
      if Assigned(IndicesDescriptor) then
        with IndicesDescriptor do
          if DefaultIndex >= 0 then
            Result := IndexDescriptor[DefaultIndex].Name
          else
            Result := ''
      else
        Result := '';
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.idSetCursorRange(aFollowedByFirst: Boolean): Boolean;
var
  RangeStart      : PnxDataSetKeyBuffer;
  RangeEnd        : PnxDataSetKeyBuffer;

  RangeStartBuf   : Pointer;
  RangeEndBuf     : Pointer;

  FieldCountStart : Integer;
  FieldCountEnd   : Integer;
begin
  dsStartBusy;
  try
    Result := False;
    if dsWriteOnly then
      Exit;

    if dsInternalWriteOnly then
      aFollowedByFirst := False;

    if idHasActiveRange
       and
       BuffersEqual(
         idKeyBuffers[kiRangeStart],
         idKeyBuffers[kiCurRangeStart],
         idKeyBufferSize)
       and
       BuffersEqual(
         idKeyBuffers[kiRangeEnd],
         idKeyBuffers[kiCurRangeEnd],
         idKeyBufferSize)
    then
    Exit;

    if dsFlipOrder then
      RangeStart := idKeyBuffers[kiRangeEnd]
    else
      RangeStart := idKeyBuffers[kiRangeStart];
    if RangeStart.kbModified then
      RangeStartBuf := Pointer(TnxRecordBuffer(RangeStart) + SizeOf(TnxDataSetKeyBuffer))
    else
      RangeStartBuf := nil;

    if dsFlipOrder then
      RangeEnd := idKeyBuffers[kiRangeStart]
    else
      RangeEnd := idKeyBuffers[kiRangeEnd];
    if RangeEnd.kbModified then
      RangeEndBuf := Pointer(TnxRecordBuffer(RangeEnd) + SizeOf(TnxDataSetKeyBuffer))
    else
      RangeEndBuf := nil;

    FieldCountStart := RangeStart.kbFieldCount;
    if FieldCountStart = 0 then
      FieldCountStart := Length(idIndexFieldMap);
    if RangeStart.kbPartialLen > 0 then
      Dec(FieldCountStart);

    FieldCountEnd := RangeEnd.kbFieldCount;
    if FieldCountEnd = 0 then
      FieldCountEnd := Length(idIndexFieldMap);
    if RangeEnd.kbPartialLen > 0 then
      Dec(FieldCountEnd);

    if not dsInternalWriteOnly then
      if {$IFDEF DCC17OrLater}Length(dsFirstBookmark) < 1{$ELSE}dsFirstBookmark = nil{$ENDIF} then
        if dsNoCMR then
          dsAbstractCursor.AddCursorOption(acoRangeSetFollowedBySetToBegin)
        else if (dsBlockReadSize = 0) and aFollowedByFirst then begin
          dsAbstractCursor.AddCursorOptions([
            acoRangeSetFollowedBySetToBegin,
            acoRangeSetFollowedByRecordGetNext
          ]);
          if disJustOpenedCursor in dsInternalState then
            Include(dsInternalState, disFirstRecordGetNextPriorAfterOpen);
        end;
    try
      dsCheck(dsAbstractCursor.RangeSet
        (FieldCountStart, RangeStart^.kbPartialLen, idIndexDirectKey, RangeStartBuf, not RangeStart^.kbExclusive,
         FieldCountEnd,     RangeEnd^.kbPartialLen, idIndexDirectKey,   RangeEndBuf, not   RangeEnd^.kbExclusive));
    finally
      dsAbstractCursor.RemoveCursorOptions([
        acoRangeSetFollowedBySetToBegin,
        acoRangeSetFollowedByRecordGetNext
      ]);
    end;

    nxMove(idKeyBuffers[kiRangeStart]^, idKeyBuffers[kiCurRangeStart]^,
      idKeyBufferSize);
    nxMove(idKeyBuffers[kiRangeEnd]^, idKeyBuffers[kiCurRangeEnd]^,
      idKeyBufferSize);

    dsDestroyLookupCursor;

    Result := True;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetIndex(const aValue       : string;
                                           aFieldsIndex : Boolean);
var
  DefaultIndex         : Boolean;
  IndexName            : string;
  RemovedImplicitFirst : Boolean;
  DoFirst              : Boolean;
begin
  dsStartBusy;
  try
    if idFieldsIndex = aFieldsIndex then
      if idFieldsIndex then begin
        if idIndexFieldNames = aValue then
          Exit;
      end else begin
        if idIndexName = aValue then
          Exit;
      end;

    DefaultIndex := (aValue = '');
    RemovedImplicitFirst := False;
    DoFirst := False;

    if not dsNoCMR then
      if (idMasterLink.Active) and (idMasterLink.Fields.Count > 0) then begin
        RemovedImplicitFirst := dsoSwitchToIndexImplicitFirst in dsOptions;
        if RemovedImplicitFirst then begin
          Exclude(dsOptions, dsoSwitchToIndexImplicitFirst);
          DoFirst := True;
        end;
      end;

    try
      if Active then begin
        CheckBrowseMode;
        IndexName := idResolveIndexName(aValue, aFieldsIndex);
        idSwitchToIndex(IndexName);
        idDefaultIndex := DefaultIndex;
        DoFirst := dsApplyMasterRange(True) or DoFirst;
      end else begin
        idDefaultIndex := DefaultIndex;
        if aFieldsIndex then
          idIndexName := ''
        else
          idIndexName := aValue;
      end;
    finally
      if RemovedImplicitFirst then
        Include(dsOptions, dsoSwitchToIndexImplicitFirst);
    end;

    idFieldsIndex := aFieldsIndex;
    if idFieldsIndex then
      idIndexFieldNames := aValue
    else
      idIndexFieldNames := '';

    if Active then
      if DoFirst then
        First
      else
        Resync([]);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetIndexDefs(Value: TIndexDefs);
begin
  idIndexDefs.Assign(Value);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetIndexField(aInx  : Integer;
                                    const aValue : TField);
begin
  idGetIndexField(aInx).Assign(aValue);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetIndexFieldNames(const aValue: string);
begin
  idSetIndex(aValue, aValue <> '');
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetIndexName(const aValue: string);
begin
  idSetIndex(aValue, False);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyBuffer(aKeyIndex : TnxKeyIndex;
                                         aClear    : Boolean);
begin
  CheckBrowseMode;

  idKeyBuffer := idKeyBuffers[aKeyIndex];
  idKeyBufferEditQueued := nil;

  nxMove(idKeyBuffer^, idKeyBuffers[kiSave]^, idKeyBufferSize);

  if aClear then
    idInitKeyBuffer(idKeyBuffer);

  SetState(dsSetKey);

  SetModified(idKeyBuffer.kbModified);

  DataEvent(deDataSetChange, 0);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyExclusive(const aValue: Boolean);
begin
  idCheckSetKeyMode;
  idKeyBuffer.kbExclusive := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyFieldCount(const aValue: Integer);
begin
  idCheckSetKeyMode;
  idKeyBuffer.kbFieldCount := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyFields(aKeyIndex : TnxKeyIndex;
                                   const aValues   : array of const;
                                         aOptions  : TnxSetKeyOptions);
begin
  idSetKeyFields(aKeyIndex, aValues, EmptyOpenArray, aOptions);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyFields(aKeyIndex : TnxKeyIndex;
                                   const aValues1  : array of const;
                                   const aValues2  : array of const;
                                         aOptions  : TnxSetKeyOptions);
var
  SaveState : TDataSetState;
  i, j      : Integer;
begin
  if not Assigned(idDirectKeySetFields) and (Length(idIndexFieldMap) = 0) then
    DatabaseError(SNoFieldIndexes, Self);

  SaveState := SetTempState(dsSetKey);
  try
    idKeyBuffer := idInitKeyBuffer(idKeyBuffers[aKeyIndex]);
    try
      if Assigned(idDirectKeySetFields) then
        idDirectKeySetFields(aValues1, aValues2, aOptions)
      else begin
        j := 0;
        for i := Low(aValues1) to High(aValues1) do begin
          IndexFields[j].AssignValue(aValues1[i]);
          Inc(j);
        end;
        for i := Low(aValues2) to High(aValues2) do begin
          IndexFields[j].AssignValue(aValues2[i]);
          Inc(j);
        end;

        idKeyBuffer^.kbFieldCount := j;
        idKeyBuffer^.kbExclusive := skoExclusive in aOptions;
        idKeyBuffer^.kbModified := Modified;
        idKeyBuffer^.kbPartialLen := 0;
        if skoPartialMatch in aOptions then
          if J > 0 then
            with IndexFields[Pred(j)] do
              if DataType in [ftString, ftFixedChar, ftWideString] then
                idKeyBuffer^.kbPartialLen := Pred(High(Integer));
      end;
    finally
      idKeyBuffer := nil;
    end;
  finally
    RestoreState(SaveState);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetKeyPartialLen(const aValue: Integer);
begin
  idCheckSetKeyMode;
  idKeyBuffer.kbPartialLen := aValue;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetLinkRange(aMasterFields: TnxFieldList);
var
  SaveState  : TDataSetState;
  SaveBuffer : PnxDataSetKeyBuffer;
  Idx        : Integer;
begin
  dsStartBusy;
  try
    SaveBuffer := idKeyBuffer;
    SaveState := SetTempState(dsSetKey);
    try
      idKeyBuffer := idInitKeyBuffer(idKeyBuffers[kiRangeStart]);
      idKeyBuffer^.kbModified := True;

	  If   Assigned( FOnSetLinkRange )  //..
	  then idKeyBuffer^.kbFieldCount := FOnSetLinkRange( Self )
	  else begin
	       for Idx := 0 to Pred(aMasterFields.Count) do
	         IndexFields[Idx] := TField(aMasterFields[Idx]);
           idKeyBuffer^.kbFieldCount := aMasterFields.Count;
           end;
		   
    finally
      RestoreState(SaveState);
      idKeyBuffer := SaveBuffer;
    end;

    nxMove(idKeyBuffers[kiRangeStart]^, idKeyBuffers[kiRangeEnd]^, idKeyBufferSize);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetMasterFields(const aValue: string);
begin
  dsStartBusy;
  try
    idMasterLink.FieldNames := aValue;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetMasterSource(const aValue: TDataSource);
begin
  dsStartBusy;
  try
    if IsLinkedTo(aValue) then
      dsError(@rsTblCircDataLink, [aValue.Name]);
    idMasterLink.DataSource := aValue;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetOnSetLinkRange( Value : TDataSetLinkRangeEvent ); //..
begin
     FOnSetLinkRange := Value;
     idMasterLink.FOnSetLinkRangeAssigned := Assigned( Value );
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetOnApplyMasterRange( Value : TDataSetNotifyEvent ); //..
begin
     FOnApplyMasterRange := Value;
     idMasterLink.FOnApplyMasterRangeAssigned := Assigned( Value );
end;

{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSetQueuedKeyBuffer(aIndex: Integer; aClear: Boolean);
begin
  CheckBrowseMode;

  idKeyBuffer := idGetQueuedKeyBuffer(aIndex);

  if idKeyBuffer.kbDirectKey then begin
    idKeyBufferEditQueued := idKeyBuffer;
    idKeyBuffer := idKeyBuffers[kiQueuedKey];

    if not aClear then begin
      idKeyBuffer^ := idKeyBufferEditQueued^;
      dsCheck(AbstractCursor.KeyToRecord(
        @idKeyBufferEditQueued.kbBuffer,
        @idKeyBuffer.kbBuffer
      ));
    end;
  end else begin
    idKeyBufferEditQueued := nil;
    nxMove(idKeyBuffer^, idKeyBuffers[kiSave]^, idKeyBufferSize);
  end;

  if aClear then
    idInitKeyBuffer(idKeyBuffer);

  SetState(dsSetKey);

  SetModified(idKeyBuffer.kbModified);

  DataEvent(deDataSetChange, 0);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idSwitchToIndex(const aIndexName: string);
var
  Status    : TnxResult;
  PosnOnRec : TnxPosnOnRec;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    idResetCursorRange(False);
    UpdateCursorPos;

    dsFreeKeyBuffers;
    try
      dsFirstBookmark := nil;
      if dsNoCMR then begin
        Status := dsAbstractCursor.SwitchToIndex(aIndexName, -1, porTrue);
        if (Status = DBIERR_NOCURRREC) or (Status = DBIERR_RECDELETED) or
          (Status = DBIERR_BOF)  or (Status = DBIERR_EOF)then
          Status := dsAbstractCursor.SwitchToIndex(aIndexName, -1, porFalse);
        if dsoSwitchToIndexImplicitFirst in dsOptions then begin
          if Status = DBIERR_NONE then
            InternalFirst;
        end;
      end else begin
        PosnOnRec := porTry;
        if (dsoSwitchToIndexImplicitFirst in dsOptions) or
           (disJustOpenedCursor in dsInternalState)
        then
          PosnOnRec := porFalse;

        Status := dsAbstractCursor.SwitchToIndex(aIndexName, -1, PosnOnRec);

        if (PosnOnRec = porFalse) and (Status = DBIERR_NONE) then
          dsBof^ := True;
      end;

      dsCheck(Status);

      idIndexName := aIndexName;
      Exclude(dsInternalState, disIndexInvalid);

      SetBufListSize(0);
      dsInitBookmarkSize;
      dsInitOffsets;
    finally
      dsInitKeyBuffers;
    end;
    try
      SetBufListSize(BufferCount + 1);
    except
      SetState(dsInactive);
      CloseCursor;
      raise;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.idTokenIndexSetFields(const aValues1 : array of const;
                                                const aValues2 : array of const;
                                                      aOptions : TnxSetKeyOptions);

  procedure Error;
  begin
    DatabaseErrorFmt(SFieldValueError, ['<Token>']);
  end;

var
  ws  : TnxWideString;
  Len : Integer;
  p   : TnxRecordBuffer;
  v   : PVarRec;
begin
  ws := nil;
  v := nil;

  case Length(aValues1) of
    0: case Length(aValues2) of
         0: ;
         1: v := @aValues2[0];
       else
         Error;
       end;
    1: begin
      if Length(aValues2) <> 0 then
        Error;
      v := @aValues1[0]
    end;
  else
    Error;
  end;

  idInitKeyBuffer(idKeyBuffer);
  if assigned(v) then
    with v^ do begin
      case VType of
        vtInteger:
         {$IFNDEF DCC12OrLater}
          ws := nxStringToWideString(IntToStr(VInteger), nxDefaultUserCodePage);
         {$ELSE}
          ws := nxUnicodeStringToWideString(IntToStr(VInteger));
         {$ENDIF}
        vtChar:
          ws := nxStringToWideString(VChar, nxDefaultUserCodePage);
        vtWideChar:
          ws := nxDelphiWideStringToWideString(VWideChar);
        vtString:
          ws := nxStringToWideString(VString^, nxDefaultUserCodePage);
        vtPointer:
          if VPointer <> nil then Error;
        vtPChar:
          ws := nxStringToWideString(VPChar, nxDefaultUserCodePage);
        vtPWideChar:
          ws := nxDelphiWideStringToWideString(VPWideChar);
        vtAnsiString:
          ws := nxStringToWideString(AnsiString(VAnsiString), nxDefaultUserCodePage);
        vtVariant:
          if not (VarIsEmpty(VVariant^) or VarIsNull(VVariant^)) then
            ws := nxDelphiWideStringToWideString(VVariant^);
        vtWideString:
          ws := nxDelphiWideStringToWideString(WideString(VWideString));
        {$IFDEF DCC12OrLater}
        vtUnicodeString:
          ws := nxUnicodeStringToWideString(UnicodeString(VUnicodeString));
        {$ENDIF}
      else
        Error;
      end;

      Len := nxMinI32(Length(ws), Pred(idIndexKeySize div 2));
      if (Len > 0) and (ws[Pred(Len)] >= SurrogateHighStart) and (ws[Pred(Len)] <= SurrogateHighEnd) then
        Dec(Len);

      idKeyBuffer.kbModified := Len > 0;

      if idKeyBuffer.kbModified then begin
        idKeyBuffer.kbFieldCount := 1;
        p := TnxRecordBuffer(idKeyBuffer) + SizeOf(TnxDataSetKeyBuffer);
        PnxWord16(p)^ := Len;
        Inc(PnxWord16(p));
        nxMove(ws[0], p^, Len * 2);

        idKeyBuffer.kbExclusive := skoExclusive in aOptions;
        if skoPartialMatch in aOptions then
          idKeyBuffer.kbPartialLen := Pred(High(Integer));
      end;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.InternalClose;
begin
  dsStartBusy;
  try
    inherited;
    IndexDefs.Updated := False;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.Post;
begin
  dsStartBusy;
  try
    inherited;
    if State = dsSetKey then
      idPostKeyBuffer(True);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.PSGetDefaultOrder: TIndexDef;
var
  NilList : TnxFieldList;

  function GetIdx(IdxType: TIndexOption): TIndexDef;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to IndexDefs.Count - 1 do
      if IdxType in IndexDefs[i].Options then
      try
        Result := IndexDefs[i];
        GetFieldList(NilList, Result.Fields);
        break;
      except
        Result := nil;
      end;
  end;

var
  DefIdx: TIndexDef;
begin
  NilList := nil;
  DefIdx := nil;
  IndexDefs.Update;
  try
    if IndexName <> '' then
      DefIdx := IndexDefs.Find(IndexName)
    else if IndexFieldNames <> '' then
      DefIdx := IndexDefs.FindIndexForFields(IndexFieldNames);
    if Assigned(DefIdx) then
      GetFieldList(NilList, DefIdx.Fields);
  except
    DefIdx := nil;
  end;
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixPrimary);
  if not Assigned(DefIdx) then
    DefIdx := GetIdx(ixUnique);
  if Assigned(DefIdx) then begin
    Result := TIndexDef.Create(nil, '', '', []);
    Result.Assign(DefIdx);
  end else
    Result := nil;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.PSGetIndexDefs(IndexTypes : TIndexOptions)
                                                   : TIndexDefs;
var
  i : Integer;
begin
  {$IFDEF FPC}
  dsError(DBIERR_NOTSUPPORTED, @rsPSGetIndexDefsNotSupported);
  {$ELSE}
  Result := GetIndexDefs(IndexDefs, IndexTypes);
  {$ENDIF}
  { remove Sequential Access Index }
  if Assigned(Result) then
  for i := Pred(Result.Count) downto 0 do begin
    if Result[i].Name = csSeqAccessIndexName then
      Result[i].Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.PSGetKeyFields: string;
var
  i          : Integer;
  Pos        : Integer;
  IndexFound : Boolean;
begin
  {$IFDEF FPC}
  Result := '';
  {$ELSE}
  Result := inherited PSGetKeyFields;
  {$ENDIF}
  if Result = '' then begin
    if not (Assigned(dsAbstractCursor) or Exists) then
      Exit;

    IndexFound := False;
    IndexDefs.Update;

    for i := 0 to Pred(IndexDefs.Count) do
      if ixUnique in IndexDefs[I].Options then begin
        Result := IndexDefs[I].Fields;
        IndexFound := (FieldCount = 0);
        if not IndexFound then begin
          Pos := 1;
          while Pos <= Length(Result) do begin
            IndexFound := FindField(ExtractFieldName(Result, Pos)) <> nil;
            if not IndexFound then
              Break;
          end;
        end;
        if IndexFound then
          Break;
      end;

    if not IndexFound then
      Result := '';
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.PSSetParams(aParams: TParams);

  procedure AssignFields;
  var
    i : Integer;
  begin
    for i := 0 to Pred(aParams.Count) do
      if aParams[i].Name <> '' then
        FieldByName(aParams[i].Name).Value := aParams[i].Value
      else
        indexFields[i].Value := aParams[i].Value;
    if dsoSetKeyFieldCountForPSSetParams in dsOptions then
      for i := Pred(IndexFieldCount) downto 0 do
        if not IndexFields[i].IsNull then begin
          KeyFieldCount := Succ(i);
          Break;
        end;
  end;

begin
  dsStartBusy;
  try
    if aParams.Count > 0 then begin
      Open;
      SetRangeStart;
      AssignFields;
      SetRangeEnd;
      AssignFields;
      ApplyRange;
    end else
      if Active then
        if not (dsoKeepExistingRangeForPSSetParams in dsOptions) then
          CancelRange;
    PSReset;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.QueueKey: Boolean;
var
  KeyBuffer       : PnxDataSetKeyBuffer;
  DirektKeyBuffer : PnxDataSetKeyBuffer;
begin
  CheckBiDirectional;
  CheckBrowseMode;

  KeyBuffer := idGetKeyBuffer(kiLookup);
  Result := KeyBuffer.kbModified;
  if Result then begin
    if (not KeyBuffer.kbDirectKey) and
       (dsoBuildKeyOnQueue in dsOptions)
    then repeat { until False, used instead of begin/end to allow "Break" to 
                  easily skip to the end of this block }
      DirektKeyBuffer := nxGetMem(idKeyBufferSizeKey);
      try
        if AbstractCursor.BuildKey(
             @KeyBuffer.kbBuffer,
             @DirektKeyBuffer.kbBuffer,
             True
           ) <> DBIERR_NONE 
        then
          { continue after the "until False" and add the full record buffer instead }
          Break; 
          
        DirektKeyBuffer^ := KeyBuffer^;
        DirektKeyBuffer.kbDirectKey := True;
        idQueueKey(DirektKeyBuffer);
        DirektKeyBuffer := nil; { we've added it to the queue, don't free it below anymore }
        idInitKeyBuffer(KeyBuffer);
      finally
        nxFreeMemDirect(DirektKeyBuffer);
      end;
      { we've added the direct key already, our work is done}
      Exit;
    until False;
    
    idQueueKey(KeyBuffer);
    idKeyBuffers[kiLookup] := idKeyBufferAlloc;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.QueueKey(const aKeyValues: array of const): Boolean;
begin
  CheckBiDirectional;

  CheckBrowseMode;
  idSetKeyFields(kiLookup, aKeyValues, EmptySetKeyOptions);
  Result := QueueKey;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.QueueKey(const aKeyValues : array of const;
                                        aOptions   : TnxSetKeyOptions)
                                                   : Boolean;
begin
  CheckBiDirectional;

  CheckBrowseMode;
  idSetKeyFields(kiLookup, aKeyValues, aOptions);
  Result := QueueKey;
end;
{------------------------------------------------------------------------------}
{$IFDEF DCC17OrLater}
procedure TnxIndexDataSet.SetFieldData(aField: TField; aBuffer: TValueBuffer);
begin
  with aField do
    if (State = dsSetKey) and ((FieldNo < 0) or (Length(idIndexFieldMap) > 0) and
      not Self.GetIsIndexField(aField)) then DatabaseErrorFmt(SNotIndexField, [DisplayName]);
  inherited;
end;
{$ENDIF}
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.SetFieldData(aField: TField; aBuffer: Pointer);
begin
  with aField do
    if (State = dsSetKey) and ((FieldNo < 0) or (Length(idIndexFieldMap) > 0) and
      not Self.GetIsIndexField(aField)) then DatabaseErrorFmt(SNotIndexField, [DisplayName]);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.SetKey;
begin
  idSetKeyBuffer(kiLookup, True);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.SetQueuedKey(aIndex: Integer);
begin
  idSetQueuedKeyBuffer(aIndex, True);
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRangeShared(const aSharedValue : array of const;
                                        const aStartValues : array of const;
                                        const aEndValues   : array of const;
                                              aOptions     : TnxSetKeyOptions;
                                              aAfterApply  : TnxAfterApplyBehavior)
                                                           : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    idSetKeyFields(kiRangeStart, aSharedValue, aStartValues, aOptions);
    idSetKeyFields(kiRangeEnd, aSharedValue, aEndValues, aOptions);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRangeSimple(const aValue      : array of const;
                                              aOptions    : TnxSetKeyOptions;
                                              aAfterApply : TnxAfterApplyBehavior)
                                                          : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    idSetKeyFields(kiRangeStart, aValue, aOptions);
    idSetKeyFields(kiRangeEnd, aValue, aOptions);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRangeShared(const aSharedValue  : array of const;
                                        const aStartValues  : array of const;
                                        const aEndValues    : array of const;
                                              aStartOptions : TnxSetKeyOptions;
                                              aEndOptions   : TnxSetKeyOptions;
                                              aAfterApply   : TnxAfterApplyBehavior)
                                                            : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    idSetKeyFields(kiRangeStart, aSharedValue, aStartValues, aStartOptions);
    idSetKeyFields(kiRangeEnd, aSharedValue, aEndValues, aEndOptions);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRange(const aStartValues  : array of const;
                                  const aEndValues    : array of const;
                                        aStartOptions : TnxSetKeyOptions;
                                        aEndOptions   : TnxSetKeyOptions;
                                        aAfterApply   : TnxAfterApplyBehavior)
                                                      : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    idSetKeyFields(kiRangeStart, aStartValues, aStartOptions);
    idSetKeyFields(kiRangeEnd, aEndValues, aEndOptions);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRange(const aStartValues : array of const;
                                  const aEndValues   : array of const;
                                        aAfterApply  : TnxAfterApplyBehavior)
                                                     : Boolean;
var
  Options     : TnxSetKeyOptions;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    Options := [];
    idSetKeyFields(kiRangeStart, aStartValues, Options);
    idSetKeyFields(kiRangeEnd, aEndValues, Options);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxIndexDataSet.SetRange(const aStartValues : array of const;
                                  const aEndValues   : array of const;
                                        aOptions     : TnxSetKeyOptions;
                                        aAfterApply  : TnxAfterApplyBehavior)
                                                     : Boolean;
begin
  dsCheckNotInOnFilterRecord;
  dsStartBusy;
  try
    CheckBrowseMode;
    idSetKeyFields(kiRangeStart, aStartValues, aOptions);
    idSetKeyFields(kiRangeEnd, aEndValues, aOptions);
    Result := ApplyRange(aAfterApply);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.SetRangeEnd;
begin
  idSetKeyBuffer(kiRangeEnd, True);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.SetRangeStart;
begin
  idSetKeyBuffer(kiRangeStart, True);
end;
{------------------------------------------------------------------------------}
procedure TnxIndexDataSet.UpdateIndexDefs;
var
  i, j            : Integer;
  IndexDef        : TIndexDef;
  hCaseInsFields  : string;
  hDescFields     : string;
  hFields         : string;

  TableDescriptor : TnxBaseTableDescriptor;
begin
  if not IndexDefs.Updated then begin
    IndexDefs.BeginUpdate;
    try

      if Assigned(dsTableDescriptor) then begin
        TableDescriptor := dsTableDescriptor;
      end else begin
        try
          OpenCursor(True);
        finally
          CloseCursor;
        end;
        Exit;
      end;

      IndexDefs.Clear;

      with TableDescriptor do
        if Assigned(IndicesDescriptor) then
          with IndicesDescriptor do
            for i:= 0 to Pred(IndexCount) do
              with IndexDescriptor[i] do begin
                hCaseInsFields := '';
                hDescFields := '';
                hFields := '';
                if KeyDescriptor is TnxCompKeyDescriptor then
                  with TnxCompKeyDescriptor(KeyDescriptor) do
                    for j:= 0 to Pred(KeyFieldCount) do
                      with KeyFields[j] do begin
                        if ((KeyFields[j] is TnxTextKeyFieldDescriptor) and
                          TnxTextKeyFieldDescriptor(KeyFields[j]).IgnoreCase) then
                          hCaseInsFields := hCaseInsFields + Field.Name + ';';
                        if not Ascend then
                          hDescFields := hDescFields + Field.Name + ';';
                        hFields := hFields + Field.Name + ';';
                      end;
                SetLength(hCaseInsFields, Pred(Length(hCaseInsFields)));
                SetLength(hDescFields, Pred(Length(hDescFields)));
                SetLength(hFields, Pred(Length(hFields)));

                IndexDef := {$IFNDEF DCC12OrLater}TnxIndexdef.Create(IndexDefs, '','',[]){$ELSE}IndexDefs.AddIndexDef{$ENDIF};
                IndexDef.Name := Name;
                IndexDef.CaseInsFields := hCaseInsFields;
                IndexDef.DescFields := hDescFields;
                IndexDef.Fields := hFields;
                if Dups <> idAll then
                  IndexDef.Options := IndexDef.Options + [ixUnique];
                if DefaultIndex = i then
                  IndexDef.Options := IndexDef.Options + [ixPrimary];
                if hCaseInsFields = hFields then
                  IndexDef.Options := IndexDef.Options + [ixCaseInsensitive];
                if hDescFields = hFields then
                  IndexDef.Options := IndexDef.Options + [ixDescending];

                with IndexDef as TnxIndexDef do
                  if KeyDescriptor.Filter is TnxBaseSimpleExpressionFilterDescriptor then
                    with TnxBaseSimpleExpressionFilterDescriptor(KeyDescriptor.Filter) do begin
                      FilterType := ftSimple;
                      FilterExpression := FilterText;
                    end
                  else if KeyDescriptor.Filter is TnxBaseSqlFilterDescriptor then
                    with TnxBaseSqlFilterDescriptor(KeyDescriptor.Filter) do begin
                      FilterType := ftSqlWhere;
                      FilterExpression := Expression;
                    end;
              end;
    finally
      IndexDefs.EndUpdate;
      IndexDefs.Updated := True;
    end;
  end;
end;
{==============================================================================}



{===TnxTable===================================================================}
procedure TnxTable.AddIndex(const aName          : string;
                            const aFields        : string;
                                  aOptions       : TIndexOptions;
                            const aCaseInsFields : string = '';
                            const aDescFields    : string = '';
                                  aNewPrimary    : Boolean = False);
var
  IndexDesc      : TnxIndexDescriptor;
  EFNPOS         : Integer;
  Fld            : string;
  TaskInfo       : TnxAbstractTaskInfo;
  Done           : Boolean;
  TaskStatus     : TnxTaskStatus;
  OldActive      : Boolean;
  SavedBookmark  : {$IFDEF DCC12OrLater}TBookmark{$ELSE}{$IFDEF FPC}TBookmark{$ELSE}TBookmarkStr{$ENDIF}{$ENDIF};
  SavedRangeStart: Pointer;
  SavedRangeEnd  : Pointer;
  FldDef         : TFieldDef;
  KFD            : TnxKeyFieldDescriptor;
  OldCursorActive: Boolean;
  CaseInsFlds    : TStringList;
  DescFlds       : TStringList;
begin
  dsStartBusy;
  try
    SavedRangeStart := nil;
    SavedRangeEnd := nil;

    OldActive := Active;
    FieldDefs.Update;
    IndexDefs.Update;

    IndexDesc := TnxIndexDescriptor.CreateStandalone
      (IndexDefs.Count, aName, 0, TnxCompKeyDescriptor);

    try
      if ixUnique in aOptions then
        IndexDesc.Dups := idNone
      else
        IndexDesc.Dups := idAll;

      CaseInsFlds := TStringList.Create;
      try
        CaseInsFlds.Sorted := True;
        CaseInsFlds.Duplicates := dupIgnore;

        EFNPOS := 1;
        while EFNPos <= Length(aCaseInsFields) do begin
           Fld := ExtractFieldName(aCaseInsFields, EFNPos);
           if (Fld<>'') and (Fld[length(Fld)]=';') then
             System.Delete(Fld, length(Fld), 1);
          CaseInsFlds.Add(Fld);
        end;

        DescFlds := TStringList.Create;
        try
          DescFlds.Sorted := True;
          DescFlds.Duplicates := dupIgnore;

          EFNPOS := 1;
          while EFNPos <= Length(aDescFields) do begin
             Fld := ExtractFieldName(aDescFields, EFNPos);
             if (Fld<>'') and (Fld[length(Fld)]=';') then
               System.Delete(Fld, length(Fld), 1);
            DescFlds.Add(Fld);
          end;

          EFNPOS := 1;
          with TnxCompKeyDescriptor(IndexDesc.KeyDescriptor) do
            while (EFNPos <= Length(aFields)) do begin
              Fld:= ExtractFieldName(aFields, EFNPos);
              if (Fld <> '') and (Fld[length(Fld)] = ';') then
                System.Delete(Fld, length(Fld), 1);

              FldDef := TFieldDef(FieldDefs.Find(Fld));
              if FldDef.DataType in [ftString, ftFixedChar, ftWideString] then begin
                KFD := Add(Pred(FldDef.FieldNo), TnxExtTextKeyFieldDescriptor);
                TnxExtTextKeyFieldDescriptor(KFD).IgnoreCase := ixCaseInsensitive in aOptions;
                if CaseInsFlds.IndexOf(FldDef.Name) >= 0 then
                  TnxExtTextKeyFieldDescriptor(KFD).IgnoreCase := True;
              end else
                KFD := Add(Pred(FldDef.FieldNo));

              KFD.Ascend := not (ixDescending in aOptions);
              if DescFlds.IndexOf(FldDef.Name) >= 0 then
                KFD.Ascend := False;
            end;
        finally
          nxFreeAndNil(DescFlds);
        end;
      finally
        nxFreeAndNil(CaseInsFlds);
      end;

      if OldActive then begin
        SavedBookmark := Bookmark;

        if idHasActiveRangeStart then begin
          SavedRangeStart := nxGetMem(idKeyBufferSize);
          nxMove(idKeyBuffers[kiCurRangeStart]^, SavedRangeStart^, idKeyBufferSize);
        end;

        if idHasActiveRangeEnd then begin
          SavedRangeEnd := nxGetMem(idKeyBufferSize);
          nxMove(idKeyBuffers[kiCurRangeEnd]^, SavedRangeEnd^, idKeyBufferSize);
        end;

        try
          { The table must be closed before an index can be added. }
          Active := False;
          try
            dsCheck(dsCursor.crDatabase.bdbAbstractDatabase.TableAddIndex
              (TableName, Password, IndexDesc, aNewPrimary));
            try
              dsCheck(dsCursor.crDatabase.bdbAbstractDatabase.TableRebuildIndex
                (TableName, Password, IndexDesc.Name, 0, TaskInfo));
              try
                Done := not Assigned(TaskInfo);
                while not Done do begin
                  Sleep(250);
                  dsCheck(TaskInfo.GetStatus(Done, TaskStatus));
                end;
              finally
                nxFreeAndNil(TaskInfo);
              end;
            except
              {something went wrong, try to remove the index again, ignore any error}
              dsCursor.crDatabase.bdbAbstractDatabase.TableDropIndex
                (TableName, Password, IndexDesc.Name, 0);
              raise;
            end;
          finally
            { Re-open the table. }
            Active := True;

            if Assigned(SavedRangeStart) then
              nxMove(SavedRangeStart^, idKeyBuffers[kiRangeStart]^, idKeyBufferSize);
            if Assigned(SavedRangeEnd) then
              nxMove(SavedRangeEnd^, idKeyBuffers[kiRangeEnd]^, idKeyBufferSize);
            idSetCursorRange(False);

            Bookmark := SavedBookmark;
          end;
        finally
          nxFreeMem(SavedRangeStart);
          nxFreeMem(SavedRangeEnd);
        end;

      end else begin
        OldCursorActive := dsCursor.Active;
        dsCursor.Active := True;
        with Database do try
          dsCheck(bdbAbstractDatabase.TableAddIndex(TableName, Password, IndexDesc, aNewPrimary));

          dsCheck(dsCursor.crDatabase.bdbAbstractDatabase.TableRebuildIndex
            (TableName, Password, IndexDesc.Name, 0, TaskInfo));
          try
            Done := not Assigned(TaskInfo);
            while not Done do begin
              Sleep(250);
              dsCheck(TaskInfo.GetStatus(Done, TaskStatus));
            end;
          finally
            nxFreeAndNil(TaskInfo);
          end;
        finally
          dsCursor.Active := OldCursorActive;
        end;
      end;
      { Make sure the index definitions are updated when required. }
      IndexDefs.Updated := False;
    finally
      nxFreeAndNil(IndexDesc);
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTable.AddIndexEx(aIndexDesc  : TnxIndexDescriptor;
                             aNewPrimary : Boolean;
                         out aTaskInfo   : TnxAbstractTaskInfo)
                                         : TnxResult;
var
  OldActive: Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  with Database do try
    Result := bdbAbstractDatabase.TableAddIndex
      (TableName, Password, aIndexDesc, aNewPrimary);
    if Result = DBIERR_NONE then
      Result := bdbAbstractDatabase.TableRebuildIndex
        (TableName, Password, aIndexDesc.Name, 0, aTaskInfo);
    if Result <> DBIERR_NONE then begin
      aTaskInfo := nil;
      {something went wrong, try to remove the index again, ignore any error}
      dsCursor.crDatabase.bdbAbstractDatabase.TableDropIndex
        (TableName, Password, aIndexDesc.Name, 0);
    end;
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.BeginClientOnlyCache;
begin
  CheckActive;
  CursorPosChanged;
  dsCheck(dsAbstractCursor.ClientOnlyCacheBegin);
end;
{------------------------------------------------------------------------------}
procedure TnxTable.ChangePassword(const aNewPassword: UnicodeString);
begin
  dsStartBusy;
  try
    CheckActive;
    dsCheck(dsAbstractCursor.ChangePassword(aNewPassword));
    tbPassword := aNewPassword;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxTable.Create(AOwner: TComponent);
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.CreateTable(aTableScope : TnxTableScope = tsPersistent;
                               aNoIndices  : Boolean = False);
begin
  CreateTableEx(nxbs4k, aTableScope, aNoIndices);
end;
{------------------------------------------------------------------------------}
procedure TnxTable.CreateTableEx(aBlockSize  : TnxBlockSize;
                                 aTableScope : TnxTableScope = tsPersistent;
                                 aNoIndices  : Boolean = False);
var
  Dict      : TnxDataDictionary;
  i         : Integer;
  OldActive : Boolean;
begin
  CheckInactive;

  if TableName = '' then
    dsError(DBIERR_INVALIDTABLENAME);

  {$IFDEF FPC}
  if FieldDefs.Count = 0 then
    dsError(DBIERR_NOTSUPPORTED, @rsCreateTableExNotSupported);
  {$ELSE}
  InitFieldDefsFromFields;
  {$ENDIF}

  {now fill in the descriptor fields}
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    Dict := TnxDataDictionary.Create;
    try
      Dict.FilesDescriptor.FileDescriptor[0].BlockSize := aBlockSize;

      for i := 0 to Pred(FieldDefs.Count) do
        if not Assigned(TnxBaseVclFieldMapper.
          AddDescriptorForFieldDef(Dict.FieldsDescriptor, FieldDefs[i])) then
            dsError(DBIERR_INVALIDFLDTYPE, @rsInvalidFieldType,
              [GetEnumName(TypeInfo(TFieldType), Ord(FieldDefs[i].DataType)),
              FieldDefs[i].Name]);

      if aNoIndices then
        Dict.RemoveIndicesDescriptor
      else
        if IndexDefs.Count > 0 then
          idAddIndexDefsToIndicesDesc(IndexDefs, Dict.EnsureIndicesDescriptor);

      if Assigned(tbOnCreateTable) then
        tbOnCreateTable(Self, Dict);

      dsCheck(Database.CreateTableEx(True, TableName, Password, Dict, aTableScope));
    finally
      Dict.Free;
    end;
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.DeleteIndex(const aIndexName: string);
var
  IndexName : string;
  OldActive : Boolean;
begin
  dsStartBusy;
  try
    IndexName := idResolveIndexName(aIndexName, False);
    CheckInactive;

    OldActive := dsCursor.Active;
    dsCursor.Active := True;
    with Database do try
      dsCheck(bdbAbstractDatabase.TableDropIndex
        (TableName, Password, IndexName, 0));
    finally
      dsCursor.Active := OldActive;
    end;
    IndexDefs.Updated := False;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.DeleteTable;
var
  OldActive : Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    dsCursor.Database.DeleteTable(TableName, Password);
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
destructor TnxTable.Destroy;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.dsOpenCursorID;
var
  Result         : TnxResult;
begin
  dsStartBusy;
  try
    Result := idCursorOpen(
      tbTableName,
      tbPassword,
      tbReadOnly or Database.ReadOnly,
      tbExclusive,
      True
    );

    if Result <> DBIERR_NONE then
      { If we failed because the table is readonly, force readonly mode. }
      if (Result = DBIERR_TABLEREADONLY) or (Result = DBIERR_READONLYDB) then begin
        if tbReadOnly then
          dsError(Result);
        tbReadOnly := True;
        dsOpenCursorID;
      end else
        dsCheck(Result);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.EmptyTable;
  procedure DoEmptyTable;
  var
    OldActive : Boolean;
  begin
    OldActive := dsCursor.Active;
    dsCursor.Active := True;
    try
      dsCursor.Database.EmptyTable(TableName, Password);
    finally
      dsCursor.Active := OldActive;
    end;
  end;

begin
  dsStartBusy;
  try
    if Active then begin
      CheckBrowseMode;
      Active := False;
      try
        DoEmptyTable;
      finally
        Active := True;
      end;
    end else
      DoEmptyTable;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.EndClientOnlyCache;
begin
  CheckActive;
  dsCheck(dsAbstractCursor.ClientOnlyCacheEnd);
end;
{------------------------------------------------------------------------------}
function TnxTable.Exists: Boolean;
var
  OldActive: Boolean;
begin
  Result := inherited Exists;
  if not Result and (TableName <> '') then try
    if Assigned(Database) then begin
      Result := Database.Exists;
      if Result then begin
        OldActive := dsCursor.Active;
        dsCursor.Active := True;
        try
          Result := Database.TableExists(TableName, Password);
        finally
          dsCursor.Active := OldActive;
        end;
      end;
    end;
  except
    Result := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTable.GetCanModify: Boolean;
begin
  Result := Active and not (ReadOnly or Database.ReadOnly);
  if Result and ((State = dsBlockRead) or (BlockReadSize > 0)) then begin
    if gboBookmarks in BlockReadOptions then
      Exit;
    Result := False;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTable.idFieldDefsStored: Boolean;
begin
  Result := tbStoreDefs and (FieldDefs.Count > 0);
end;
{------------------------------------------------------------------------------}
function TnxTable.idIndexDefsStored: Boolean;
begin
  Result := tbStoreDefs and (IndexDefs.Count > 0);
end;
{------------------------------------------------------------------------------}
function TnxTable.PackTable: TnxAbstractTaskInfo;
begin
  dsCheck(PackTableEx(Result));
end;
{------------------------------------------------------------------------------}
function TnxTable.PackTableEx(out aTaskInfo : TnxAbstractTaskInfo): TnxResult;
var
  OldActive: Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    Result := Database.PackTableEx(TableName, Password, aTaskInfo);
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTable.PSGetTableName: string;
begin
  Result := TableName;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.PSSetCommandText(const CommandText: string);
begin
  if CommandText <> '' then
    TableName := CommandText;
end;
{------------------------------------------------------------------------------}
function TnxTable.ReIndexTable(aIndexNum : Integer)
                                         : TnxAbstractTaskInfo;
begin
  dsCheck(ReIndexTableEx(aIndexNum, Result));
end;
{------------------------------------------------------------------------------}
function TnxTable.ReIndexTable(const aIndexName : string)
                                                : TnxAbstractTaskInfo;
begin
  dsCheck(ReIndexTableEx(aIndexName, Result));
end;
{------------------------------------------------------------------------------}
function TnxTable.ReIndexTableEx(aIndexNum : Integer;
                             out aTaskInfo : TnxAbstractTaskInfo)
                                           : TnxResult;
var
  OldActive : Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    Result := Database.ReIndexTableEx(TableName, Password, aIndexNum, aTaskInfo);
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
function TnxTable.ReIndexTableEx(const aIndexName : string;
                                   out aTaskInfo  : TnxAbstractTaskInfo)
                                                  : TnxResult;
var
  OldActive: Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    Result := Database.ReIndexTableEx(TableName, Password, aIndexName, aTaskInfo);
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.RenameTable(const aNewTableName: string);
var
  OldActive: Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    dsCursor.Database.RenameTable(TableName, aNewTableName, Password);
  finally
    dsCursor.Active := OldActive;
  end;
  TableName := aNewTableName;
end;
{------------------------------------------------------------------------------}
function TnxTable.RestructureTable(aDictionary  : TnxDataDictionary;
                                   aMapperDesc  : TnxBaseTableMapperDescriptor)
                                                : TnxAbstractTaskInfo;
begin
  dsCheck(RestructureTableEx(aDictionary, aMapperDesc, Result));
end;
{------------------------------------------------------------------------------}
function TnxTable.RestructureTableEx(aDictionary  : TnxDataDictionary;
                                     aMapperDesc  : TnxBaseTableMapperDescriptor;
                                 out aTaskInfo    : TnxAbstractTaskInfo)
                                                  : TnxResult;
var
  OldActive: Boolean;
begin
  CheckInactive;
  OldActive := dsCursor.Active;
  dsCursor.Active := True;
  try
    Result := Database.RestructureTableEx
      (TableName, Password, aDictionary, aMapperDesc, aTaskInfo);
  finally
    dsCursor.Active := OldActive;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.tbSetExclusive(const Value: Boolean);
begin
  if tbExclusive <> Value then begin
    CheckInactive;
    tbExclusive := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.tbSetPassword(const Value: UnicodeString);
begin
  CheckInactive;
  tbPassword := Value;
  DataEvent(dePropertyChange, 0);
end;
{------------------------------------------------------------------------------}
procedure TnxTable.tbSetReadOnly(const Value: Boolean);
begin
  if tbReadOnly <> Value then begin
    CheckInactive;
    tbReadOnly := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.tbSetTableName(const Value: string);
begin
  if SameText(tbTableName, Value) then
    tbTableName := Value
  else begin
    CheckInactive;
    tbTableName := Value;
    DataEvent(dePropertyChange, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTable.tbSetWriteOnly(const Value: Boolean);
begin
  if dsWriteOnly <> Value then begin
    CheckInactive;
    dsWriteOnly := Value;
    dsInternalWriteOnly := Value;
  end;
end;
{==============================================================================}



{===TnxCachedDataSetDatabaseExtender===========================================}
procedure TnxCachedDataSetDatabaseExtender.AddDataSet(aDataSet : TnxCachedDataSet);
begin
  if Assigned(aDataSet.UpdateObject) then
    with aDataSet, UpdateObject do
      cdsdeDataSets.AddObject(cdsUsedTableName,
        buoGetHandlerClass.Create(cdsUpdateObject, aDataSet));
end;
{------------------------------------------------------------------------------}
constructor TnxCachedDataSetDatabaseExtender.Create(aDatabase : TnxAbstractDatabase);
begin
  cdsdeDataSets := TStringList.Create;
  cdsdeDataSets.Sorted := True;
  cdsdeDataSets.Duplicates := dupError;
  inherited Create(nil, aDatabase);
end;
{------------------------------------------------------------------------------}
destructor TnxCachedDataSetDatabaseExtender.Destroy;
begin
  inherited;
  nxFreeAndNil(cdsdeDataSets);
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSetDatabaseExtender.Notify(aAction : TnxEngineAction;
                                                 aBefore : Boolean;
                                           const aArgs   : array of const)
                                                         : TnxResult;
var
  Cursor : TnxAbstractCursor;
  i      : Integer;
begin
  case aAction of
    eaChildCreate: if aArgs[0].VObject is TnxAbstractCursor then begin
      Cursor := TnxAbstractCursor(aArgs[0].VObject);
      with cdsdeDataSets do
        if Find(Cursor.FullName, i) then
          TnxCachedDataSetCursorExtender.Create(Cursor, TnxBaseUpdateHandler(Objects[i]));
    end;
    eaDestroy:
      with cdsdeDataSets do
        for i := Pred(Count) downto 0 do begin
          Objects[i].Free;
          Delete(i);
        end;
  end;
  Result := DBIERR_NONE;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSetDatabaseExtender.RemoveDataSet(aDataSet: TnxCachedDataSet);
var
  i: Integer;
begin
  with cdsdeDataSets do
    if Find(aDataSet.cdsUsedTableName, i) then begin
      with TnxBaseUpdateHandler(Objects[i]) do begin
        if StateTransition = nxstNone then
          Free
        else
          buhFree := True;
      end;
      Delete(i);
    end;
end;
{==============================================================================}



{===TnxCachedDataSetCursorExtender=============================================}
constructor TnxCachedDataSetCursorExtender.Create(aCursor        : TnxAbstractCursor;
                                                  aUpdateHandler : TnxBaseUpdateHandler);
begin
  cdsceUpdateHandler := aUpdateHandler;
  inherited Create(nil, aCursor);
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSetCursorExtender.Notify(aAction : TnxEngineAction;
                                               aBefore : Boolean;
                                         const aArgs   : array of const)
                                                       : TnxResult;
begin
  Result := DBIERR_NONE;
  if aBefore = False then try
    case aAction of
      eaRecordInsert :
        cdsceUpdateHandler.buhNotifyInsert
          (TnxAbstractCursor(beeExtendableObject), aArgs[1].VPointer);
      eaRecordModify :
        cdsceUpdateHandler.buhNotifyModify
          (TnxAbstractCursor(beeExtendableObject), aArgs[0].VPointer, aArgs[1].VPointer);
      eaRecordDelete :
        cdsceUpdateHandler.buhNotifyDelete
          (TnxAbstractCursor(beeExtendableObject), aArgs[0].VPointer);
    end;
  except
    on E : Exception do
      Result := ConvertException(E, nil, self, Self.ExtendableObject.MinVersion);
  end;
end;
{==============================================================================}



{===TnxBaseUpdateObject========================================================}
procedure TnxBaseUpdateObject.buoSetTargetDatabase(const Value: TnxTargetDatabase);
begin
  buoTargetDatabase := Value;
end;
{==============================================================================}



{===TnxBaseUpdateHandler=======================================================}
procedure TnxBaseUpdateHandler.AfterConstruction;
begin
  inherited;
  Open;
end;
{------------------------------------------------------------------------------}
constructor TnxBaseUpdateHandler.Create(aUpdateObject  : TnxBaseUpdateObject;
                                        aCachedDataSet : TnxCachedDataSet);
begin
  buhUpdateObject := aUpdateObject;
  buhCachedDataSet := aCachedDataSet;
  buhDatabase := buhCachedDataSet.SourceDataSet.Database;
  inherited Create(nil);
  nxcAddDependingOn(buhDatabase);
  aCachedDataSet.cdsUpdateHandlerCreated(Self);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseUpdateHandler.nxcNotification(aSender    : TnxComponent;
                                               aOperation : TnxNotifyOp;
                                               aParam     : Pointer);
begin
  inherited;
  if aSender = buhDatabase then
    case aOperation of
      nxn_Destroy: begin
        Active := False;
        buhDatabase := nil;
      end;
    end;
end;
{------------------------------------------------------------------------------}
function TnxBaseUpdateHandler.scIsStateParent(aComponent : TnxStateComponent)
                                                         : Boolean;
begin
  Result := (aComponent = buhDatabase) or inherited scIsStateParent(aComponent);
end;
{------------------------------------------------------------------------------}
procedure TnxBaseUpdateHandler.scSetState(aState: TnxState);
begin
  inherited;
  if buhFree then begin
    buhFree := False;
    Free;
  end;
end;
{==============================================================================}



{===TnxSqlUpdateObject=========================================================}
function TnxSqlUpdateObject.buoGetHandlerClass: TnxBaseUpdateHandlerClass;
begin
  Result := TnxSqlUpdateHandler;
end;
{------------------------------------------------------------------------------}
constructor TnxSqlUpdateObject.Create(AOwner: TComponent);
var
  i: TUpdateKind;
begin
  for i := Low(i) to High(i) do
    suoSqlText[i] := TStringList.Create;
  suoParams := TParams.Create(Self);

  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.DefineProperties(Filer: TFiler);

  function HasData : boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := not suoParams.IsEqual(TnxSqlUpdateObject(Filer.Ancestor).suoParams)
    else
      Result := suoParams.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ParamData', suoReadParams, suoWriteParams, HasData);
end;
{------------------------------------------------------------------------------}
destructor TnxSqlUpdateObject.Destroy;
var
  i: TUpdateKind;
begin
  for i := Low(i) to High(i) do
    nxFreeAndNil(suoSqlText[i]);

  nxFreeAndNil(suoParams);

  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSqlUpdateObject.suoGetSql(aUpdateKind: TUpdateKind): TStrings;
begin
  Result := suoSqlText[aUpdateKind];
end;
{------------------------------------------------------------------------------}
function TnxSqlUpdateObject.suoGetSqlIndex(aIndex: Integer): TStrings;
begin
  Result := suoSqlText[TUpdateKind(aIndex)];
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.suoReadParams(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(suoParams);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.suoSetParams(aParams: TParams);
begin
  suoParams.AssignValues(aParams);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.suoSetSql(aUpdateKind : TUpdateKind;
                                       aValue      : TStrings);
begin
  suoSqlText[aUpdateKind].Assign(aValue);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.suoSetSqlIndex(aIndex : Integer;
                                            aValue : TStrings);
begin
  suoSqlText[TUpdateKind(aIndex)].Assign(aValue);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateObject.suoWriteParams(Writer: TWriter);
begin
  Writer.WriteCollection(suoParams);
end;
{==============================================================================}



{===nxParamToSqlParamDesc======================================================}
procedure nxParamToSqlParamDesc(aParam    : TParam;
                            var aSqlParam : TnxSqlParamDesc);
var
  Len           : TnxWord32;
  TrgBuffer     : Pointer;
  SrcBuffer     : Pointer;
  TempVariant   : Variant;
begin
  with aSqlParam do begin
    case aParam.DataType of
      ftWideString: begin

        if aParam.IsNull then
          Len := 0
        else
          Len := Length(UnicodeString(aParam.Value));

        TnxBaseVclFieldMapper.MapParamTypeAndSizeToNexus
          (aParam.DataType, Len, piDataType, Len);
      end;
      ftLargeint:
        TnxBaseVclFieldMapper.MapParamTypeAndSizeToNexus
          (aParam.DataType, 8, piDataType, Len);
      ftGuid:
        TnxBaseVclFieldMapper.MapParamTypeAndSizeToNexus
          (aParam.DataType, 16, piDataType, Len);
    else
      TnxBaseVclFieldMapper.MapParamTypeAndSizeToNexus
        (aParam.DataType, aParam.GetDataSize, piDataType, Len);
    end;

    if aParam.IsNull then
      Len := 0
    else
    if (piDataType in [nxtBlob, nxtBlobGraphic]) then begin
      if VarIsArray(aParam.Value) then
        Len := nxVarArrayLength(aParam.Value, 1)
      else
        Len := aParam.GetDataSize;

      SetLength(piData, Len);
      if Len > 0 then begin
        TrgBuffer := @piData[Low(piData)];
        if VarIsArray(aParam.Value) then begin
          TempVariant := aParam.Value;
          SrcBuffer := VarArrayLock(TempVariant);
          try
            Move(SrcBuffer^, TrgBuffer^, Len);
          finally
            VarArrayUnlock(TempVariant);
          end;
        end else
          aParam.GetData(TrgBuffer);
      end;
    end else
    if piDataType = nxtBcd then
      VariantToNative(piDataType, CP_UTF8, IfThen(aParam.Precision = 0, 20, aParam.Precision), IfThen(aParam.NumericScale = 0, 4, aParam.NumericScale), aParam.Value, piData)
    else
    if piDataType = nxtFmtBcd then
      VariantToNative(piDataType, CP_UTF8, IfThen(aParam.Precision = 0, 64, aParam.Precision), IfThen(aParam.NumericScale = 0, 24, aParam.NumericScale), aParam.Value, piData)
    else
      VariantToNative(piDataType, CP_UTF8, 0, 0, aParam.Value, piData);
  end;
end;
{==============================================================================}



{===TnxSqlUpdateHandler========================================================}
procedure TnxSqlUpdateHandler.buhNotifyDelete(aCursor    : TnxAbstractCursor;
                                              aOldRecord : PnxRecordBuffer);
begin
  suhExecStatement(ukDelete, aCursor, aOldRecord, nil);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateHandler.buhNotifyInsert(aCursor    : TnxAbstractCursor;
                                              aNewRecord : PnxRecordBuffer);
begin
  suhExecStatement(ukInsert, aCursor, nil, aNewRecord);
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateHandler.buhNotifyModify(aCursor    : TnxAbstractCursor;
                                              aNewRecord : PnxRecordBuffer;
                                              aOldRecord : PnxRecordBuffer);
begin
  suhExecStatement(ukModify, aCursor, aOldRecord, aNewRecord);
end;
{------------------------------------------------------------------------------}
constructor TnxSqlUpdateHandler.Create(aUpdateObject  : TnxBaseUpdateObject;
                                       aCachedDataSet : TnxCachedDataSet);
var
  i               : TUpdateKind;
  j, k            : Integer;
  Left, Right     : string;
  ParamIsOld      : Integer;

  ParamsBytes     : TnxSqlParamList;
  ParamsRef       : TStringList;
  SourceParamsRef : TStringList;
  ParamBytes      : PnxSqlParamDesc;
  Param           : TParam;
  IsSource        : Boolean;
  SourceParams    : TParams;

  LocaleDesc      : TnxLocaleDescriptor;
begin
  SourceParams := nil;
  if aCachedDataSet.SourceDataSet is TnxStatementDataSet then
    SourceParams := TnxStatementDataSet(aCachedDataSet.SourceDataSet).Params;

  ParamsBytes := nil;
  ParamsRef := TStringList.Create;
  ParamsRef.Sorted := True;
  ParamsRef.Duplicates := dupError;
  try
    SourceParamsRef := TStringList.Create;
    SourceParamsRef.Sorted := True;
    SourceParamsRef.Duplicates := dupError;
    try
      inherited;
      with TnxSqlUpdateObject(aUpdateObject), aCachedDataSet do begin
        for i := Low(i) to High(i) do
          suhSqlText[i] := suhParseSql(suoSqlText[i].Text, suhSqlParams[i]);

        for i := Low(i) to High(i) do begin
          SetLength(suhSqlParamFields[i], Length(suhSqlParams[i]));
          SetLength(suhSqlParamCP[i], Length(suhSqlParams[i]));
          for j := Low(suhSqlParams[i]) to High(suhSqlParams[i]) do
            with suhSqlParams[i,j] do begin
              suhSqlParamFields[i, j] := 0;
              suhSqlParamCP[i, j] := 0;

              nxStrSplit(piParamName, ['$'], Left, Right);

              ParamIsOld := 0;
              if Right <> '' then begin
                IsSource := SameText(Left, 'sourceparam');

                if IsSource and not Assigned(SourceParams) then
                  dsError(DBIERR_INVALIDPARAM, 'SourceParams are only available if the SourceDataSet is a TnxStatementDataSet');

                if IsSource or SameText(Left, 'param') then begin

                  if IsSource and SourceParamsRef.Find(Right, k) then
                    ParamBytes := PnxSqlParamDesc(SourceParamsRef.Objects[k])
                  else if not IsSource and ParamsRef.Find(Right, k) then
                    ParamBytes := PnxSqlParamDesc(ParamsRef.Objects[k])
                  else begin
                    SetLength(ParamsBytes, Succ(Length(ParamsBytes)));
                    ParamBytes := @ParamsBytes[High(ParamsBytes)];
                    if IsSource then
                      SourceParamsRef.AddObject(Right, TObject(ParamBytes))
                    else
                      ParamsRef.AddObject(Right, TObject(ParamBytes));

                    if IsSource then
                      Param := SourceParams.FindParam(Right)
                    else
                      Param := Params.FindParam(Right);

                    if not Assigned(Param) then
                      if IsSource then
                        dsError(DBIERR_INVALIDPARAM, 'Unknown SourceParam "%s"', [Right])
                      else
                        dsError(DBIERR_INVALIDPARAM, 'Unknown Param "%s"', [Right]);

                    nxParamToSqlParamDesc(Param, ParamBytes^);
                  end;

                  piData := ParamBytes^.piData;
                  piDataType := ParamBytes^.piDataType;

                  Right := ''
                end else if SameText(Left, 'old') then
                  ParamIsOld := -1
                else if SameText(Left, 'new') then
                  ParamIsOld := 1
                else
                  Right := piParamName;
              end else
                Right := Left;

              case i of
                ukModify:
                  if ParamIsOld = 0 then
                    ParamIsOld := 1;
                ukInsert: begin
                  if ParamIsOld < 0 then
                    dsError(DBIERR_INVALIDPARAM, 'No old field values available in insert statement (%s)', [piParamName]);

                  if ParamIsOld = 0 then
                    ParamIsOld := 1;
                end;
                ukDelete: begin
                  if ParamIsOld > 0 then
                    dsError(DBIERR_INVALIDPARAM, 'No new field values available in delete statement (%s)', [piParamName]);

                  if ParamIsOld = 0 then
                    ParamIsOld := -1;
                end;
              end;

              if Right <> '' then begin
                suhSqlParamFields[i, j] := FieldsDescriptor.GetFieldFromName(Right);
                if suhSqlParamFields[i, j] < 0 then
                  dsError(DBIERR_INVALIDPARAM, 'Unknown Field "%s"', [Right]);
                with FieldsDescriptor.FieldDescriptor[suhSqlParamFields[i, j]] do begin
                  piDataType := fdType;
                  LocaleDesc := UsedLocaleDescriptor;
                  if Assigned(LocaleDesc) then begin
                    suhSqlParamCP[i, j] := LocaleDesc.StorageCodepage;
                    if suhSqlParamCP[i, j] = CP_UTF8 then
                      suhSqlParamCP[i, j] := 0;
                  end;
                end;
                suhSqlParamFields[i, j] := Succ(suhSqlParamFields[i, j]) * ParamIsOld;
              end;
            end;
        end;

      end;
    finally
      nxFreeAndNil(SourceParamsRef);
    end;
  finally
    nxFreeAndNil(ParamsRef);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateHandler.scStarting;
var
  i     : TUpdateKind;
  Error : TnxResult;
begin
  inherited;

  with buhCachedDataSet do
    for i := Low(i) to High(i) do begin
      dsCheck(SourceDataSet.Database.bdbAbstractDatabase.
        StatementAlloc(suhStatements[i], dsGetTimeout));
      with TnxMemoryStream.Create do try
        Error := suhStatements[i].Prepare(stQuery, suhSqlText[i], TheStream);
        if Error <> DBIERR_NONE then
          cdsHandleError(Error, @rsQueryPrepareFail, TheStream);
      finally
        Free;
      end;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateHandler.scStopping;
var
  i: TUpdateKind;
begin
  for i := Low(i) to High(i) do
    nxFreeAndNil(suhStatements[i]);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlUpdateHandler.suhExecStatement(aUpdateKind : TUpdateKind;
                                               aCursor     : TnxAbstractCursor;
                                               aOldRecord  : PnxRecordBuffer;
                                               aNewRecord  : PnxRecordBuffer);
var
  i            : Integer;
  Old          : Boolean;
  FieldNo      : Integer;
  RecordBuffer : PnxRecordBuffer;
  BlobLength   : TnxWord32;
  p            : PAnsiChar;
  Len          : Integer;
  Error        : TnxResult;
  NewCursor    : TnxAbstractCursor;
  Stream       : TnxAnsiStringStream;
//  RowsAffected : Integer;
begin
  with aCursor.TableDescriptor.FieldsDescriptor do
    for i := Low(suhSqlParamFields[aUpdateKind]) to High(suhSqlParamFields[aUpdateKind]) do
      if suhSqlParamFields[aUpdateKind, i] <> 0 then begin
        Old := suhSqlParamFields[aUpdateKind, i] < 0;
        FieldNo := Pred(Abs(suhSqlParamFields[aUpdateKind,i]));

        if Old then
          RecordBuffer := aOldRecord
        else
          RecordBuffer := aNewRecord;

        if not Assigned(RecordBuffer) then
          buhCachedDataSet.dsError(DBIERR_INVALIDPARAM);

        with suhSqlParams[aUpdateKind, i] do
          if IsRecordFieldNull(FieldNo, RecordBuffer) then
            piData := nil
          else with FieldDescriptor[FieldNo] do begin
            case fdType of
              nxtBlob..nxtBlobGraphic, nxtBlobWideMemo : begin
                buhCachedDataSet.dsCheck(aCursor.BlobGetLength(ridNull, FieldNo,
                  PnxInt64(@RecordBuffer[fdOffset])^, BlobLength, Old, nil));
                if BlobLength > 0 then begin
                  case fdType of
                    nxtBlobMemo: begin
                      Stream := TnxAnsiStringStream.Create('');
                      try
                        buhCachedDataSet.dsCheck(aCursor.BlobRead(ridNull, FieldNo,
                          PnxInt64(@RecordBuffer[fdOffset])^, 0, BlobLength, Stream, Old, nil));

                        piData := nxWideStringToBytes(
                          nxStringToWideString(Stream.DataString, suhSqlParamCP[aUpdateKind, i]),
                            CP_UTF8);
                        SetLength(piData, Succ(Length(piData))); {add trailing #0}

                      finally
                        Stream.Free;
                      end;
                    end;
                  else
                    SetLength(piData, BlobLength);
                    with TnxStaticMemoryStream.Create(@piData[0], BlobLength) do try
                      buhCachedDataSet.dsCheck(aCursor.BlobRead(ridNull, FieldNo,
                        PnxInt64(@RecordBuffer[fdOffset])^, 0, BlobLength, TheStream, Old, nil));
                      if fdType = nxtBlobWideMemo then
                        SetLength(piData, Length(piData)+2); {add trailing #0}
                    finally
                      Free;
                    end;
                  end;
                end else
                  piData := nil;
              end;
              nxtShortString, nxtNullString: begin
                piDataType := nxtNullString;
                p := @RecordBuffer[fdOffset];
                if fdType = nxtShortString then begin
                  Len := PnxByte8(p)^;
                  Inc(p);
                end else
                  Len := StrLen(p);
                piData := nxWideStringToBytes(
                  nxBytesToWideString(p^, Len, suhSqlParamCP[aUpdateKind, i]),
                    CP_UTF8);
                SetLength(piData, Succ(Length(piData)));
              end;
              nxtChar: begin
                piDataType := nxtNullString;
                piData := nxWideStringToBytes(
                  nxBytesToWideString(RecordBuffer[fdOffset], 1, suhSqlParamCP[aUpdateKind, i]),
                    CP_UTF8);
                SetLength(piData, Succ(Length(piData)));
              end;
              nxtWideString: begin
                p := @RecordBuffer[fdOffset];
                Len := Succ(lstrlenW(PWideChar(p))) * SizeOf(WideChar);
                SetLength(piData, Len);
                nxMove(p^, piData[0], Len);
              end;
            else
              SetLength(piData, fdLength);
              nxMove(RecordBuffer[fdOffset], piData[0], fdLength);
            end;
          end;

      end;

  with TnxMemoryStream.Create do try
    Error := suhStatements[aUpdateKind].SetParams(suhSqlParams[aUpdateKind], TheStream);
    if Error <> DBIERR_NONE then
      buhCachedDataSet.cdsHandleError(Error, @rsQuerySetParamsFail, TheStream);

    Size := 0;
    Position  := 0;

    NewCursor := nil;
    Error := suhStatements[aUpdateKind].Exec(NewCursor, omReadOnly, TheStream);
    if Error <> DBIERR_NONE then
      buhCachedDataSet.cdsHandleError(Error, @rsQueryExecFail, TheStream);
    if Assigned(NewCursor) then begin
      nxFreeAndNil(NewCursor);
      buhCachedDataSet.dsError(DBIERR_INVALIDPARAM, 'Statement returned a result set', []);
    end;

//    ReadBuffer(RowsAffected, SizeOf(RowsAffected));
//    if RowsAffected <> 0 then
//      buhCachedDataSet.dsError(DBIERR_INVALIDPARAM, '', []);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlUpdateHandler.suhParseSql(const aStmt   : UnicodeString;
                                           out aParams : TnxSqlParamList)
                                                       : UnicodeString;

  function WideCharToChar(aWideChar: WideChar): AnsiChar;
  begin
    if Ord(aWideChar) > 255 then
      Result := #0
    else
      Result := AnsiChar(Ord(aWideChar));
  end;

const
  ParamNameTerminators = [#9, #10, #13, ' ', ',', ';', '(', ')', '=', '>', '<', '+', '-', '*', '/'];
  StringDelims = ['''', '"'];
var
  CurPos, EndPos, NameEndPos, NameStartPos, StartPos : integer;
  LastDelim: WideChar;
  aLen : integer;
  LastChar: WideChar;
  SkipToEol : Boolean;
  CommentCount: Integer;
begin

  { Parameter format:
     :<contiguous text>
     :"<text>" (i.e., for multiword param names)

    Excluded:
     double colons
     a colon occuring within double or single quotes
  }

  aParams := nil;
  Result := aStmt;
  if aStmt = '' then
    Exit;

  CurPos := 1;
  LastDelim := #0;
  LastChar := #0;
  CommentCount := 0;
  SkipToEol := False;

  repeat
    if LastDelim = #0 then begin
      if SkipToEol and not (WideCharToChar(Result[CurPos]) in [#10,#13]) then begin
        Inc(CurPos);
        Continue;
      end;
      SkipToEol := False;

      if CommentCount = 0 then begin
        case Result[CurPos] of
          '/', '-':
            if LastChar = Result[CurPos] then begin
              SkipToEol := True;
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
          '*':
            if LastChar = '/' then begin
              Inc(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
        end;
      end else begin
        case Result[CurPos] of
          '/':
            if LastChar = '*' then begin
              Dec(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
          '*':
            if LastChar = '/' then begin
              Inc(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
        end;
      end;

      LastChar := Result[CurPos];

      if CommentCount > 0 then begin
        Inc(CurPos);
        Continue;
      end;
    end;

    { Is this the start of a literal? }
    if WideCharToChar(Result[CurPos]) in StringDelims then begin
      { Yes.  Skip to the end of the literal.  Note that we can have nested
        delimiters. }
      LastDelim := Result[CurPos];

      repeat
        Inc(CurPos);
        aLen := Length(Result);

        while (CurPos < aLen) and
              (not (Result[CurPos] = LastDelim)) do begin
          { Skip this char. }
          Inc(CurPos);
        end;

        if CurPos > aLen then
          Break;

        LastDelim := #0;

      until LastDelim = #0;

      { Move to the character after the final string delimiter. }
      Inc(CurPos);

    end else if (Result[CurPos] = ':') then begin
      { Is this a double colon? }
      if (Result[CurPos + 1] = ':') then
        Inc(CurPos, 2)
      else begin
        { No.  We have found a single colon.  Grab the name.  Note that the
          name may be in single quotes. }
        StartPos := CurPos;
        Inc(CurPos);
        { Is the colon followed by a double quote?  In other words, is the
          param name delimited by double quotes? }
        if Result[CurPos] = '"' then begin
          Inc(CurPos);
          NameStartPos := CurPos;
          repeat
            Inc(CurPos);
          until Result[CurPos] = '"';
          EndPos := CurPos;
          NameEndPos := CurPos - 1;
        end
        else begin
          NameStartPos := CurPos;
          repeat
            Inc(CurPos);
          until WideCharToChar(Result[CurPos]) in ParamNameTerminators;
          EndPos := CurPos - 1;
          NameEndPos := EndPos;
        end;

        { Create a TParam if necessary.  Replace the name with a '?'. }
        SetLength(aParams, Succ(Length(aParams)));
        with aParams[High(aParams)] do begin
          piParamName := Copy(Result, NameStartPos, (NameEndPos - NameStartPos) + 1);
          piParamType := nxptInput;
        end;

        Result[StartPos] := '?';
        System.Delete(Result, StartPos + 1, EndPos - StartPos);
        CurPos := StartPos + 1;

      end;
    end else
      { Not the start of a literal or a colon.  Move to next character. }
      Inc(CurPos);

  until (CurPos > Length(Result)) or (Result[CurPos] = #0);

end;
{==============================================================================}



{===TnxCachedDataSetCursor=====================================================}
procedure TnxCachedDataSetCursor.crSetUpdateHandler(const Value: TnxBaseUpdateHandler);
begin
  if crUpdateHandler <> Value then begin
    nxcRemoveDependingOn(crUpdateHandler);
    crUpdateHandler := Value;
    nxcAddDependingOn(crUpdateHandler);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSetCursor.nxcNotification(aSender    : TnxComponent;
                                                 aOperation : TnxNotifyOp;
                                                 aParam     : Pointer);
begin
  inherited;
  if aSender = crUpdateHandler then
    if aOperation = nxn_Destroy then
      crUpdateHandler := nil;
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSetCursor.scIsStateParent(aComponent : TnxStateComponent)
                                                           : Boolean;
begin
  Result := (Assigned(crUpdateHandler) and (aComponent = crUpdateHandler)) or
    inherited scIsStateParent(aComponent);
end;
{==============================================================================}



{===TnxCachedDataSet===========================================================}
function TnxCachedDataSet.cdsAddIndexDefsStored: Boolean;
begin
  Result := cdsAddIndexDefs.Count > 0;
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSet.cdsAddFieldDefsStored: Boolean;
begin
  Result := cdsAddFieldDefs.Count > 0;
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSet.cdsGetDatabaseExtender: TnxCachedDataSetDatabaseExtender;
begin
  Result := TnxCachedDataSetDatabaseExtender(Database.bdbAbstractDatabase.
    GetExtenderOfType(TnxCachedDataSetDatabaseExtender));

  if not Assigned(Result) then
    Result := TnxCachedDataSetDatabaseExtender.
      Create(Database.bdbAbstractDatabase);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsHandleError(aResult : TnxResult;
                                    const aMsg    : string;
                                          aStream : TStream);
var
  ErrorMessage       : AnsiString;
  ErrorMessageLength : integer;
begin
  if aResult <> DBIERR_NONE then begin
    aStream.Position := 0;
    ErrorMessageLength := 0;
    aStream.Read(ErrorMessageLength, SizeOf(ErrorMessageLength));
    if ErrorMessageLength > 0 then begin
      SetLength(ErrorMessage, ErrorMessageLength);
      aStream.Read(PAnsiChar(ErrorMessage)^, ErrorMessageLength);
      dsError(aResult, aMsg, [#13#10, ErrorMessage]);
    end else
      dsCheck(aResult);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsHandleError(aResult : TnxResult;
                                          aMsgRes : PResStringRec;
                                          aStream : TStream);
begin
  cdsHandleError(aResult, LoadResString(aMsgRes), aStream);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetAddIndexDefs(Value: TIndexDefs);
begin
  CheckInactive;
  cdsAddIndexDefs.Assign(Value);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetAddFieldDefs(Value: TFieldDefs);
begin
  CheckInactive;
  cdsAddFieldDefs.Assign(Value);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetReadOnly(const Value: Boolean);
begin
  if cdsReadOnly <> Value then begin
    CheckInactive;
    cdsReadOnly := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetSourceDataSet(const Value: TnxDataSet);
begin
  if Value = Self then
    raise dsExceptionClass.nxCreate(rsCachedDataSetCantReferenceItself);

  if cdsSourceDataSet <> Value then begin
    CheckInactive;
    if Assigned(cdsSourceDataSet) then
      cdsSourceDataSet.RemoveFreeNotification(Self);
    cdsSourceDataSet := Value;
    if Assigned(cdsSourceDataSet) then
      cdsSourceDataSet.FreeNotification(Self);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetTableName(const Value: string);
begin
  if cdsTableName <> Value then begin
    CheckInactive;
    cdsTableName := Value;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsSetUpdateObject(const Value: TnxBaseUpdateObject);
begin
  if cdsUpdateObject <> Value then begin
    CheckInactive;
    if Assigned(cdsUpdateObject) then
      cdsUpdateObject.RemoveFreeNotification(Self);
    cdsUpdateObject := Value;
    if Assigned(cdsUpdateObject) then
      cdsUpdateObject.FreeNotification(Self);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.cdsUpdateHandlerCreated(aUpdateHandler : TnxBaseUpdateHandler);
begin
  cdsUpdateHandler := aUpdateHandler;
  TnxCachedDataSetCursor(dsCursor).UpdateHandler := aUpdateHandler;
end;
{------------------------------------------------------------------------------}
constructor TnxCachedDataSet.Create(AOwner: TComponent);
begin
  cdsBatchSize := 512 * 1024;
  cdsAddIndexDefs := TIndexDefs.Create(nil);
  cdsAddFieldDefs := TFieldDefs.Create(Self);
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxCachedDataSet.Destroy;
begin
  inherited;
  nxFreeAndNil(cdsAddIndexDefs);
  nxFreeAndNil(cdsAddFieldDefs);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.dsCloseCursorID;
begin
  dsStartBusy;
  try
    inherited;
    if cdsUsedTableName <> '' then begin
      cdsGetDatabaseExtender.RemoveDataSet(Self);
      Database.DeleteTable(cdsUsedTableName, '');
      cdsUsedTableName := '';
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSet.dsGetCursorClass: TnxCursorClass;
begin
  Result := TnxCachedDataSetCursor;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.dsOpenCursorID;
const
  OpenMode  : array[Boolean] of TnxOpenMode  = (omReadWrite , omReadOnly);
var
  WasActive        : Boolean;
  WasWriteOnly     : Boolean;

  Dictionary       : TnxDataDictionary;
  TableCreated     : Boolean;

  Error            : TnxResult;

  Access           : TnxBatchStreamAccess;
  Entry            : TnxBatchStreamEntry;
  Done             : Boolean;

  FieldIdx         : Integer;
  AddFieldDefIdx   : Integer;

  SourceRecLen     : Integer;
  TargetNullOffset : Integer;
  NullLen          : Integer;

  TargetBuffer     : PnxRecordBuffer;

  BlobFields       : TnxBlobFields;
  BlobIdx          : Integer;
  BlobFldIdx       : Integer;

  BlobNr           : TnxBlobNr;
  NewBlobNr        : TnxBlobNr;
  IsNull           : Boolean;
  BlobLength       : PnxWord32;

  Extender         : TnxCachedDataSetDatabaseExtender;
  {$IFDEF FPC}
  NewInt           : Integer;
  {$ENDIF}

  BRO              : TnxRecordGetBatchExOptions;
begin
  dsStartBusy;
  try
    FieldDefs.Clear;
    FieldDefs.Updated := False;

    IndexDefs.Clear;
    IndexDefs.Updated := False;

    if not Assigned(cdsSourceDataSet) then
      dsError(DBIERR_INVALIDPARAM, 'SourceDataSet is not assigned', []);

    TableCreated := False;
    Extender := nil;
    WasActive := cdsSourceDataSet.Active;
    WasWriteOnly := cdsSourceDataSet.dsWriteOnly;
    if not WasActive then begin
      cdsSourceDataSet.dsWriteOnly := True;
      cdsSourceDataSet.dsInternalWriteOnly := True;
      cdsSourceDataSet.Open;
    end;
    try
      cdsSourceDataSet.CursorPosChanged;

      cdsUsedTableName := cdsTableName;
      if cdsUsedTableName = '' then
        cdsUsedTableName := 'CachedDataSet_' + IntToStr(Int64(TnxNativeUInt(Self)));

      try
        Dictionary := TnxDataDictionary.Create;
        try
          Dictionary.FieldsDescriptor.Assign(cdsSourceDataSet.TableDescriptor.FieldsDescriptor);

          with Dictionary.FieldsDescriptor do
            for FieldIdx := 0 to Pred(FieldCount) do
              case FieldDescriptor[FieldIdx].fdType of
                nxtAutoInc,
                nxtRecRev:
                  FieldDescriptor[FieldIdx].fdType := nxtWord32;
                nxtRefNr:
                  FieldDescriptor[FieldIdx].fdType := nxtInt64;
                nxtInt64:
                  if FieldDescriptor[FieldIdx].fdDefaultValue is TnxNextLSNDefaultValueDescriptor then
                    FieldDescriptor[FieldIdx].RemoveDefaultValue;
              end;

          if (cdsoCopyIndices in cdsOptions) and Assigned(cdsSourceDataSet.TableDescriptor.IndicesDescriptor) then begin
            Dictionary.AddIndicesDescriptor(TnxMainIndicesDescriptorClass(cdsSourceDataSet.TableDescriptor.IndicesDescriptor.ClassType));
            Dictionary.IndicesDescriptor.Assign(cdsSourceDataSet.TableDescriptor.IndicesDescriptor);
          end;

          for AddFieldDefIdx := 0 to Pred(AddFieldDefs.Count) do
            if not Assigned(TnxBaseVclFieldMapper.
              AddDescriptorForFieldDef(Dictionary.FieldsDescriptor, AddFieldDefs[AddFieldDefIdx])) then
                dsError(DBIERR_INVALIDFLDTYPE, @rsInvalidFieldType,
                  [GetEnumName(TypeInfo(TFieldType), Ord(AddFieldDefs[AddFieldDefIdx].DataType)),
                  AddFieldDefs[AddFieldDefIdx].Name]);

          if AddIndexDefs.Count > 0 then
            idAddIndexDefsToIndicesDesc(AddIndexDefs, Dictionary.EnsureIndicesDescriptor);

          TnxHeapRecordDescriptor(Dictionary.AddRecordDescriptor(TnxHeapRecordDescriptor)).
            AddRecordCompressionDescriptor;

          if Assigned(cdsOnCreateTable) then
            cdsOnCreateTable(Self, Dictionary);

          Database.CreateTable(False, cdsUsedTableName, '', Dictionary, tsTempDatabase);
          TableCreated := True;
        finally
          nxFreeAndNil(Dictionary);
        end;

        dsCheck(idCursorOpen(
          cdsUsedTableName,
          '',
          False,
          False,
          False
        ));

        dsAbstractCursor.OptionSet('INSERT_OPTIONS_SETDEFAULT', 'FALSE');
        dsAbstractCursor.OptionSet('INSERT_OPTIONS_SETAUTOINC', 'FALSE');
        dsAbstractCursor.OptionSet('INSERT_OPTIONS_VALIDATE', 'FALSE');

        Access := nil;
        BlobFields := nil;
        try
          BRO := [gboBlobs];
          with cdsSourceDataSet do begin
            BlobFields := dsSFI.sfiBlobFields;
            if dsNoCMR then begin
              if WasActive then
                  dsCheck(AbstractCursor.SetToBegin);
            end else begin
              if Assigned(BlobFields) then
                Include(BRO, gboSetToBeginOrEnd)
              else
                BRO := [gboSetToBeginOrEnd];
            end;
          end;
          Done := False;
          repeat
            Access.Clear;
            with cdsSourceDataSet do begin
              repeat
                Error := AbstractCursor.RecordGetBatch
                  (cdsBatchSize, BRO, Access);
                Exclude(BRO, gboSetToBeginOrEnd);
                if Error = DBIERR_NX_FilterTimeout then begin
                  if dsCancelServerFilter then
                    Break;
                end else
                  Break;
              until false;
              dsCheck(Error);
            end;

            if Access.InnerError = DBIERR_EOF then
              Done := True
            else
              cdsSourceDataSet.dsCheck(Access.InnerError);

            if dsFieldsDescriptor.FieldCount = cdsSourceDataSet.TableDescriptor.FieldsDescriptor.FieldCount then begin
              Access.InnerError := DBIERR_NONE;
              Access.Stream.Position := 0;
              dsCheck(dsAbstractCursor.RecordInsertBatch(Access.Stream));
            end else begin
              Access.Reset;
              SourceRecLen := cdsSourceDataSet.TableDescriptor.FieldsDescriptor.LogicalRecordLength;
              TargetNullOffset := dsFieldsDescriptor.LogicalRecordLength;
              with cdsSourceDataSet.TableDescriptor.FieldsDescriptor do
                NullLen := (FieldCount + 7) div 8;
              TargetBuffer := nxGetMem(dsFieldsDescriptor.RecordLength + SizeOf(Pointer));
              try
                while Access.Next(Entry) do begin
                  dsFieldsDescriptor.InitRecord(TargetBuffer);
                  nxMove(Entry.bseRecord^, TargetBuffer[0], SourceRecLen);
                  nxMove(Entry.bseRecord[SourceRecLen], TargetBuffer[TargetNullOffset], NullLen);

                  if Assigned(BlobFields) then
                    for BlobIdx := Low(BlobFields) to High(BlobFields) do begin
                      BlobFldIdx := Integer(BlobFields[BlobIdx]);
                      cdsSourceDataSet.TableDescriptor.FieldsDescriptor.GetRecordField(BlobFldIdx, Entry.bseRecord, IsNull, @BlobNr);
                      if not IsNull then begin
                        BlobLength := Pointer(@Entry.bseStreamBase[BlobNr]);
                        if BlobLength^ < 1 then
                          dsFieldsDescriptor.SetRecordFieldNull(BlobFldIdx, TargetBuffer, True)
                        else begin
                          dsCheck(dsAbstractCursor.BlobCreate(ridNull, BlobFldIdx, NewBlobNr));
                          try
                            dsCheck(dsAbstractCursor.BlobWrite(ridNull, BlobFldIdx, NewBlobNr, 0, BlobLength^, PnxByteArray(BlobLength)[4]));
                            dsFieldsDescriptor.SetRecordField(BlobFldIdx, TargetBuffer, @NewBlobNr);
                          except
                            dsAbstractCursor.BlobDelete(ridNull, BlobFldIdx, NewBlobNr);
                            raise;
                          end;
                        end;
                      end;
                    end;

                  dsCheck(dsAbstractCursor.RecordInsert(nxltNoLock, TargetBuffer));
                end;
              finally
                nxFreeMem(TargetBuffer);
              end;
            end;
          until Done;
        finally
          nxFreeAndNil(Access);
        end;

        Extender := cdsGetDatabaseExtender;
        Extender.AddDataSet(Self);

        dsClearCursorDependentState;
        nxFreeAndNil(dsAbstractCursor);

        dsCheck(idCursorOpen(
          cdsUsedTableName,
          '',
          cdsReadOnly,
          False,
          True
        ));
      except
        if Assigned(Extender) then
          Extender.RemoveDataSet(Self);

        dsClearCursorDependentState;

        if Assigned(dsAbstractCursor) then try
          nxFreeAndNil(dsAbstractCursor);
        except end;

        if TableCreated then
          Database.bdbAbstractDatabase.TableDelete(cdsUsedTableName, '');

        cdsUsedTableName := '';

        raise;
      end;
    finally
      if not WasActive then begin
        cdsSourceDataSet.Close;
        cdsSourceDataSet.dsWriteOnly := WasWriteOnly;
        cdsSourceDataSet.dsInternalWriteOnly := WasWriteOnly;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxCachedDataSet.GetCanModify: Boolean;
begin
  Result := Active and not (ReadOnly or Database.ReadOnly);
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.CreateFields;
var
  i : Integer;
begin
  inherited;

  if Assigned(cdsSourceDataSet) and
    (cdsoSetVisibleFields in cdsOptions) then begin
    for i := 0 to Pred(Fields.Count) do
      if Assigned(cdsSourceDataSet.FindField(Fields[i].FieldName)) then
        Fields[i].Visible :=
          cdsSourceDataSet.FindField(Fields[i].FieldName).Visible
      else
        Fields[i].Visible := False;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxCachedDataSet.Notification(aComponent : TComponent;
                                        aOperation : TOperation);
begin
  if aOperation = opRemove then
    if aComponent = cdsSourceDataSet then begin
      Close;
      cdsSourceDataSet := nil;
    end else if aComponent = cdsUpdateObject then begin
      Close;
      cdsUpdateObject := nil;
    end;
  inherited;
end;
{==============================================================================}



{===TnxMemTable================================================================}
function TnxMemTable.mtCreateDataDictionary: TnxDataDictionary;
var
  lFieldDefIdx: Integer;
begin
  Result := TnxDataDictionary.Create;
  try
    {$IFDEF FPC}
    if FieldDefs.Count = 0 then
      dsError(DBIERR_NOTSUPPORTED);
    {$ELSE}
    InitFieldDefsFromFields;
    {$ENDIF}

    for lFieldDefIdx := 0 to Pred(FieldDefs.Count) do
      if not Assigned(TnxBaseVclFieldMapper.
        AddDescriptorForFieldDef(Result.FieldsDescriptor, FieldDefs[lFieldDefIdx])) then
          dsError(DBIERR_INVALIDFLDTYPE, @rsInvalidFieldType,
            [GetEnumName(TypeInfo(TFieldType), Ord(FieldDefs[lFieldDefIdx].DataType)),
            FieldDefs[lFieldDefIdx].Name]);

    if IndexDefs.Count > 0 then
      idAddIndexDefsToIndicesDesc(IndexDefs, Result.EnsureIndicesDescriptor);

    TnxHeapRecordDescriptor(Result.AddRecordDescriptor(TnxHeapRecordDescriptor)).
      AddRecordCompressionDescriptor;
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxMemTable.mtSetTableName(const Value: string);
begin
  if mtTableName <> Value then begin
    CheckInactive;
    mtTableName := Value;
  end;
end;
{------------------------------------------------------------------------------}
constructor TnxMemTable.Create(AOwner: TComponent);
begin
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxMemTable.Destroy;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxMemTable.dsCloseCursorID;
begin
  dsStartBusy;
  try
    inherited;
    if mtUsedTableName <> '' then begin
      Database.DeleteTable(mtUsedTableName, '');
      mtUsedTableName := '';
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxMemTable.dsOpenCursorID;
var
  Dictionary   : TnxDataDictionary;
  TableCreated : Boolean;
begin
  dsStartBusy;
  try
    TableCreated := False;

    mtUsedTableName := mtTableName;
    if mtUsedTableName = '' then
      mtUsedTableName := 'MemoryTable_' + IntToStr(Int64(TnxNativeUInt(Self)));

    try
      Dictionary := mtCreateDataDictionary;
      try
        if Assigned(mtOnCreateTable) then
          mtOnCreateTable(Self, Dictionary);

        Database.CreateTable(False, mtUsedTableName, '', Dictionary, tsTempDatabase);
        TableCreated := True;
      finally
        nxFreeAndNil(Dictionary);
      end;

      dsCheck(idCursorOpen(
        mtUsedTableName,
        '',
        False,
        False,
        True
      ));
    except
      dsClearCursorDependentState;

      if Assigned(dsAbstractCursor) then try
        nxFreeAndNil(dsAbstractCursor);
      except end;

      if TableCreated then
        Database.bdbAbstractDatabase.TableDelete(mtUsedTableName, '');

      mtUsedTableName := '';

      raise;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxMemTable.GetCanModify: Boolean;
begin
  Result := Active and not Database.ReadOnly;
end;
{------------------------------------------------------------------------------}
function TnxMemTable.idFieldDefsStored: Boolean;
begin
  Result := mtStoreDefs and (FieldDefs.Count > 0);
end;
{------------------------------------------------------------------------------}
function TnxMemTable.idIndexDefsStored: Boolean;
begin
  Result := mtStoreDefs and (IndexDefs.Count > 0);
end;
{==============================================================================}



{===TnxStatementDataSetDataLink===========================================================}
procedure TnxStatementDataSetDataLink.ActiveChanged;
begin
  if sddlStatementDataSet.Active then
    sddlStatementDataSet.sdRefreshParams;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSetDataLink.CheckBrowseMode;
begin
  if sddlStatementDataSet.Active then
    sddlStatementDataSet.CheckBrowseMode;
end;
{------------------------------------------------------------------------------}
constructor TnxStatementDataSetDataLink.Create(aStatementDataSet: TnxStatementDataSet);
begin
  inherited Create;
  sddlStatementDataSet := aStatementDataSet;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSetDataLink.GetDetailDataSet: TDataSet;
begin
  Result := sddlStatementDataSet;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSetDataLink.RecordChanged(Field: TField);
begin
  if (Field = nil) and sddlStatementDataSet.Active then
    sddlStatementDataSet.sdRefreshParams;
end;
{==============================================================================}



{===TnxStatementDataSet===================================================================}
constructor TnxStatementDataSet.Create(aOwner: TComponent);
begin
  inherited;
  sdDataLink := TnxStatementDataSetDataLink.Create(Self);
  sdParams := TParams.Create(Self);
  sdRowsAffected := -1;
  sdLog := TStringList.Create;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.DefineProperties(Filer: TFiler);

  function HasData : boolean;
  begin
    if Assigned(Filer.Ancestor) then
      Result := not sdParams.IsEqual(TnxStatementDataSet(Filer.Ancestor).sdParams)
    else
      Result := sdParams.Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('ParamData', sdReadParams, sdWriteParams, HasData);
end;
{------------------------------------------------------------------------------}
destructor TnxStatementDataSet.Destroy;
begin
  Unprepare;
  inherited;
  nxFreeAndNil(sdDataLink);
  nxFreeAndNil(sdParams);
  nxFreeAndNil(sdLog);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.dsCheckInactiveFromCursor;
begin
  dsStartBusy;
  try
    inherited;
    Unprepare;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.dsOpenCursorID;
var
  Result         : TnxResult;
  ParamsList     : TnxSqlParamList;
  NeedsGet       : Boolean;
  PrepareStream  : TnxMemoryStream;
  SetParamStream : TnxMemoryStream;
  ExecStream     : TnxMemoryStream;
  GetParamStream : TnxMemoryStream;
  OpenMode       : TnxOpenMode;
  OpenCanModify  : Boolean;
  LogCount, L, i : Integer;
  S              : Ansistring;
  Phase          : TnxStatementExecDirectPhase;
  IndexID        : Integer;

  Text           : UnicodeString;
  StatementType  : TnxStatementType;

  ExceptIntf     : InxException;
begin
  dsStartBusy;
  try
    try
      ParamsList := nil;
      NeedsGet := False;

      sdWasPrepared := Prepared;

      if sdDataLink.Active then
        sdSetParamsFromCursor;

      if sdParams.Count > 0 then begin
        sdBuildParams(ParamsList, NeedsGet);
        if Assigned(sdAbstractStatement) then begin
          SetParamStream := TnxMemoryStream.Create;
          try
            Result := sdAbstractStatement.SetParams(ParamsList, SetParamStream);
            sdHandleError(Result, @rsQuerySetParamsFail, SetParamStream);
          finally
            SetParamStream.Free;
          end;
        end;
      end;

      { Execute the query. }
      if sdRequestLive then
        OpenMode := omReadWrite
      else
        OpenMode := omReadOnly;

      if sdNoResultSetNeeded then
        OpenMode := omNone;

      ExecStream := TnxMemoryStream.Create;
      if NeedsGet then
        GetParamStream := TnxMemoryStream.Create
      else
        GetParamStream := nil;
      try
        sdLog.Clear;

        if Assigned(sdAbstractStatement) then
          Result := sdAbstractStatement.Exec(dsAbstractCursor, OpenMode, ExecStream)
        else begin
          StatementType := sdGetQueryInfo(Text);

          if Text = '' then
            dsError(@rsEmptySqlStatement);

          dsCursor.Active := True;

          sdRowsAffected := -1;
          sdRecordsRead := 0;
          sdCanModify := False;
          sdExecuted := False;

          PrepareStream := TnxMemoryStream.Create;
          try
            SetParamStream := TnxMemoryStream.Create;
            try
              Result := Database.bdbAbstractDatabase.StatementExecDirect(dsGetTimeout,
                StatementType, Text, PrepareStream, ParamsList, SetParamStream,
                dsAbstractCursor, OpenMode, ExecStream, GetParamStream, Phase);

              case Phase of
                sedAlloc:
                  dsCheck(Result);
                sedPrepare:
                  sdHandleError(Result, @rsQueryPrepareFail, PrepareStream);
                sedSetParams:
                  sdHandleError(Result, @rsQuerySetParamsFail, SetParamStream);
                sedGetParams:
                  sdHandleError(Result, @rsQueryGetParamsFail, GetParamStream);
                sedFree:
                  dsCheck(Result);
              end;

            finally
              nxFreeAndNil(SetParamStream);
            end;
          finally
            nxFreeAndNil(PrepareStream);
          end;
        end;

        sdHandleError(Result, @rsQueryExecFail, ExecStream);

        sdCanModify := False;

        if Assigned(dsAbstractCursor) then begin

          if not dsNoCMR then
            Include(dsInternalState, disJustOpenedCursor);

          dsSetupCursorDependentState;

          ExecStream.Read(OpenCanModify, SizeOf(OpenCanModify));

          if sdRequestLive then
            sdCanModify := OpenCanModify;

          ExecStream.Read(IndexID, SizeOf(IndexID));
        end else begin
          ExecStream.Read(sdRowsAffected, SizeOf(sdRowsAffected));
          dsClearCursorDependentState;
        end;

        ExecStream.Read(sdRecordsRead, SizeOf(sdRecordsRead));

        ExecStream.Read(LogCount, sizeof(LogCount));
        if LogCount > 0 then begin
          for i := 0 to LogCount - 1 do begin
            ExecStream.Read(L, sizeof(L));
            if L > 0 then begin
              SetLength(S, L);
              ExecStream.Read(S[1], L);
              sdLog.Add(string(S));
            end;
          end;
        end;

        if NeedsGet then begin
          if Assigned(sdAbstractStatement) then begin
            Result := sdAbstractStatement.GetParams(ParamsList, GetParamStream);
            sdHandleError(Result, @rsQueryGetParamsFail, GetParamStream);
          end else
            {already done};

          sdApplyParams(ParamsList);
        end;

      finally
        ExecStream.Free;
        GetParamStream.Free;
      end;
    except
      on E: Exception do begin
        if sdLog.Count <= 0 then
          if Supports(E, InxException, ExceptIntf) then
            sdLog.CommaText := ExceptIntf.CustomInfos.Values['SqlLog'];
        raise;
      end;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.dsRefreshTimeout;
begin
  if Assigned(sdAbstractStatement) then
    sdAbstractStatement.Timeout := dsGetTimeout;
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.dsShutdownFromCursor;
begin
  dsStartBusy;
  try
    inherited;
    if not sdWasPrepared then
      Unprepare;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdExec;
var
  OldNoResultSetNeeded : Boolean;
begin
  dsStartBusy;
  try
    CheckInactive;
    OldNoResultSetNeeded := sdNoResultSetNeeded;
    sdNoResultSetNeeded := True;
    try
      dsOpenCursorID;
    finally
      sdNoResultSetNeeded := OldNoResultSetNeeded;
    end;
    nxFreeAndNil(dsAbstractCursor);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.GetCanModify: Boolean;
begin
  Result :=
    Active and
    sdCanModify and
    not ReadOnly and
    not Database.ReadOnly;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.ParamByName(const aName: string): TParam;
begin
  Result := sdParams.ParamByName(aName);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.Prepare;
var
  Result             : TnxResult;
  Stream             : TnxMemoryStream;

  StatementType      : TnxStatementType;
  Text               : UnicodeString;
begin
  dsStartBusy;
  try
    if Assigned(sdAbstractStatement) then
      exit;

    dsCursor.Active := True;

    sdRowsAffected := -1;
    sdRecordsRead := 0;
    sdCanModify := False;
    sdExecuted := False;

    StatementType := sdGetQueryInfo(Text);

    if Text<> '' then begin
      dsCheck(Database.bdbAbstractDatabase.StatementAlloc
        (sdAbstractStatement, dsGetTimeout));
      try
        Stream := TnxMemoryStream.Create;
        try
          Result := sdAbstractStatement.Prepare(StatementType, Text, Stream);
          sdHandleError(Result, @rsQueryPrepareFail, Stream);
        finally
          nxFreeAndNil(Stream);
        end;
      except
        nxFreeAndNil(sdAbstractStatement);
        raise;
      end;
    end else
      dsError(@rsEmptySqlStatement);
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.PSExecute;
begin
  sdExec;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.PSGetParams: TParams;
begin
  Result := Params;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.PSSetParams(aParams: TParams);
begin
  dsStartBusy;
  try
    if aParams.Count <> 0 then
      Params.Assign(aParams);
    Close;
    PSReset;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdApplyParams(const aParamsList: TnxSqlParamList);
var
  Param         : TParam;
  Index         : Integer;
begin
  if Length(aParamsList) <> sdParams.Count then
    dsError(DBIERR_INVALIDPARAM);

  for Index := 0 to Pred(sdParams.Count) do begin
    Param := sdParams.Items[Index];
    with aParamsList[Index] do begin
      if piParamType <> ParamTypeToNexusDB[Param.ParamType] then
        dsError(DBIERR_INVALIDPARAM);

      if piParamType in [nxptOutput, nxptInputOutput, nxptResult] then
        if Length(piData) < 1 then
          Param.Value := NULL
        else
          Param.Value := VariantFromNative(piDataType, CP_UTF8, 0, 0,
            @piData[0], Length(piData));
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdBuildParams(var aParamsList : TnxSqlParamList;
                                            var aNeedsGet   : Boolean);
var
  Param         : TParam;
  Index         : Integer;
const
  ParamTypeToNexusDB : array[TParamType] of TnxParamType = (
    nxptUnknown,
    nxptInput,
    nxptOutput,
    nxptInputOutput,
    nxptResult
  );
begin
  aNeedsGet := False;

  aParamsList := nil;
  SetLength(aParamsList, sdParams.Count);

  for Index := 0 to Pred(sdParams.Count) do begin
    Param := sdParams.Items[Index];
    with aParamsList[Index] do begin
      piParamName := Param.Name;
      piParamType := ParamTypeToNexusDB[Param.ParamType];

      aNeedsGet := aNeedsGet or
        (piParamType in [nxptOutput, nxptInputOutput, nxptResult]);
    end;
    nxParamToSqlParamDesc(Param, aParamsList[Index]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.sdGetDataSource: TDataSource;
begin
  Result := sdDataLink.DataSource;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.sdGetParamCount: Word;
begin
  Result := sdParams.Count;
end;
{------------------------------------------------------------------------------}
function TnxStatementDataSet.sdGetPrepared: Boolean;
begin
  Result := Assigned(sdAbstractStatement);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdHandleError(aResult : TnxResult;
                                      const aMsg    : string;
                                            aStream : TStream);
var
  ErrorMessage       : AnsiString;
  ErrorMessageLength : integer;
begin
  if aResult <> DBIERR_NONE then begin
    aStream.Position := 0;
    ErrorMessageLength := 0;
    aStream.Read(ErrorMessageLength, SizeOf(ErrorMessageLength));
    if ErrorMessageLength > 0 then begin
      SetLength(ErrorMessage, ErrorMessageLength);
      aStream.Read(PAnsiChar(ErrorMessage)^, ErrorMessageLength);
      dsError(aResult, aMsg, [#13#10, ErrorMessage]);
    end else
      dsCheck(aResult);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdHandleError(aResult : TnxResult;
                                            aMsgRes : PResStringRec;
                                            aStream : TStream);
begin
  sdHandleError(aResult, LoadResString(aMsgRes), aStream);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdReadParams(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(sdParams);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdRefreshParams;
begin
  dsStartBusy;
  try
    if not Active then
      Exit;

    DisableControls;
    try
      if sdDataLink.Active and
        (sdDataLink.DataSource.DataSet.State <> dsSetKey) then begin
        Close;
        Open;
      end;
    finally
      EnableControls;
    end;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdSetDataSource(aDataSource: TDataSource);
begin
  if IsLinkedTo(aDataSource) then
    dsError(@rsTblCircDataLink, [aDataSource.Name]);
  sdDataLink.DataSource := aDataSource;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdSetParams(aParams: TParams);
begin
  sdParams.AssignValues(aParams);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdSetParamsFromCursor;
var
  Idx: Integer;
begin
  if sdDataLink.Active then
    with sdDataLink.DataSource.DataSet do begin
      FieldDefs.Update;
      for Idx := 0 to Pred(sdParams.Count) do
        with sdParams[Idx] do
          if not Bound then begin
            AssignField(FieldByName(Name));
            Bound := False;
          end;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdSetPrepared(aValue: Boolean);
begin
  if aValue then
    Prepare
  else
    Unprepare;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdSetRequestLive(aValue: Boolean);
begin
  if sdRequestLive <> aValue then begin
    CheckInactive;
    sdRequestLive := aValue;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.sdWriteParams(Writer: TWriter);
begin
  Writer.WriteCollection(sdParams);
end;
{------------------------------------------------------------------------------}
procedure TnxStatementDataSet.Unprepare;
begin
  dsStartBusy;
  try
    nxFreeAndNil(sdAbstractStatement);
    if not Active and Assigned(dsCursor) and (dsCursor.scStateTransition = nxstNone) then
      dsCursor.Close;
  finally
    dsEndBusy;
  end;
end;
{==============================================================================}



{===TnxQuery===================================================================}
constructor TnxQuery.Create(aOwner: TComponent);
begin
  inherited;
  quParamCheck := True;
  quSql := TStringList.Create;
  TStringList(quSql).OnChange := quSqlChanged;
end;
{------------------------------------------------------------------------------}
destructor TnxQuery.Destroy;
begin
  inherited;
  nxFreeAndNil(quSql);
end;
{------------------------------------------------------------------------------}
procedure TnxQuery.ExecSQL;
begin
  sdExec;
end;
{------------------------------------------------------------------------------}
function TnxQuery.PSGetDefaultOrder: TIndexDef;
begin
  {$IFDEF FPC}
  dsError(DBIERR_NOTSUPPORTED, @rsPSGetDefaultOrderNotSupported);
  {$ELSE}
  Result := inherited PSGetDefaultOrder;
  if not Assigned(Result) then
    Result := GetIndexForOrderBy(Sql.Text, Self);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
function TnxQuery.PSGetTableName: string;
begin
  {$IFDEF FPC}
  dsError(DBIERR_NOTSUPPORTED, @rsPSGetTableNameNotSupported);
  {$ELSE}
  Result := GetTableNameFromSql(Sql.Text);
  {$ENDIF}
end;
{------------------------------------------------------------------------------}
procedure TnxQuery.PSSetCommandText(const aCommandText: string);
begin
  if aCommandText <> '' then
    Sql.Text := aCommandText;
end;
{------------------------------------------------------------------------------}
function TnxQuery.quParseSql(const aStmt         : UnicodeString;
                                   aCreateParams : boolean;
                                   aParams       : TParams)
                                                 : UnicodeString;

  function WideCharToChar(aWideChar: WideChar): AnsiChar;
  begin
    if Ord(aWideChar) > 255 then
      Result := #0
    else
      Result := AnsiChar(Ord(aWideChar));
  end;

const
  ParamNameTerminators = [#9, #10, #13, ' ', ',', ';', '(', ')', '=', '>', '<', '+', '-', '*', '/'];
  StringDelims = ['''', '"'];
var
  CurPos, EndPos, NameEndPos, NameStartPos, StartPos : integer;
  LastDelim: WideChar;
  aLen : integer;
  LastChar: WideChar;
  SkipToEol : Boolean;
  CommentCount: Integer;
begin
  { Parameter format:
     :<contiguous text>
     :"<text>" (i.e., for multiword param names)

    Excluded:
     double colons
     a colon occuring within double or single quotes
  }

  if aStmt = '' then
    Exit;

  Result := aStmt;

  CurPos := 1;
  LastDelim := #0;
  LastChar := #0;
  CommentCount := 0;
  SkipToEol := False;

  repeat
    if LastDelim = #0 then begin
      if SkipToEol and not (WideCharToChar(Result[CurPos]) in [#10,#13]) then begin
        Inc(CurPos);
        Continue;
      end;
      SkipToEol := False;

      if CommentCount = 0 then begin
        case Result[CurPos] of
          '/', '-':
            if LastChar = Result[CurPos] then begin
              SkipToEol := True;
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
          '*':
            if LastChar = '/' then begin
              Inc(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
        end;
      end else begin
        case Result[CurPos] of
          '/':
            if LastChar = '*' then begin
              Dec(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
          '*':
            if LastChar = '/' then begin
              Inc(CommentCount);
              LastChar := #0;
              Inc(CurPos);
              Continue;
            end;
        end;
      end;

      LastChar := Result[CurPos];

      if CommentCount > 0 then begin
        Inc(CurPos);
        Continue;
      end;
    end;

    { Is this the start of a literal? }
    if WideCharToChar(Result[CurPos]) in StringDelims then begin
      { Yes.  Skip to the end of the literal.  No nested delimiters. }
      LastDelim := Result[CurPos];

      repeat
        Inc(CurPos);
        aLen := Length(Result);

        while (CurPos < aLen) and
              (not (Result[CurPos] = LastDelim)) do begin
          { Skip this char. }
          Inc(CurPos);
        end;

        if CurPos > aLen then
          Break;

        LastDelim := #0;

      until LastDelim = #0;

      { Move to the character after the final string delimiter. }
      Inc(CurPos);

    end else if (Result[CurPos] = ':') then begin
      { Is this a double colon? }
      if (Result[CurPos + 1] = ':') then
        Inc(CurPos, 2)
      else begin
        { No.  We have found a single colon.  Grab the name.  Note that the
          name may be in single quotes. }
        StartPos := CurPos;
        Inc(CurPos);
        { Is the colon followed by a double quote?  In other words, is the
          param name delimited by double quotes? }
        if Result[CurPos] = '"' then begin
          Inc(CurPos);
          NameStartPos := CurPos;
          repeat
            Inc(CurPos);
          until Result[CurPos] = '"';
          EndPos := CurPos;
          NameEndPos := CurPos - 1;
        end
        else begin
          NameStartPos := CurPos;
          repeat
            Inc(CurPos);
          until WideCharToChar(Result[CurPos]) in ParamNameTerminators;
          EndPos := CurPos - 1;
          NameEndPos := EndPos;
        end;

        { Create a TParam if necessary.  Replace the name with a '?'. }
        if aCreateParams and Assigned(aParams) then
          aParams.CreateParam(ftUnknown,
                              Copy(Result, NameStartPos,
                                   (NameEndPos - NameStartPos) + 1), ptUnknown);

        Result[StartPos] := '?';
        System.Delete(Result, StartPos + 1, EndPos - StartPos);
        CurPos := StartPos + 1;

      end;
    end else
      { Not the start of a literal or a colon.  Move to next character. }
      Inc(CurPos);

  until (CurPos > Length(Result)) or (Result[CurPos] = #0);

end;
{------------------------------------------------------------------------------}
procedure TnxQuery.quSetSql(aValue: TStrings);
begin
  if quSql.Text <> aValue.Text then begin
    dsCursor.Active := False;
    Unprepare;
    quSql.BeginUpdate;
    try
      quSql.Assign(aValue);
    finally
      quSql.EndUpdate;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxQuery.quSqlChanged(Sender: TObject);
var
  List: TParams;
begin
  if not (csReading in ComponentState) then begin
    dsCursor.Active := False;
    Unprepare;
    if quParamCheck or (csDesigning in ComponentState) then begin
      List := TParams.Create(Self);
      try
        quText := quParseSql(Sql.Text, True, List);
        List.AssignValues(sdParams);
        sdParams.Clear;
        sdParams.Assign(List);
      finally
        List.Free;
      end;
    end else
      quText := Sql.Text;
    DataEvent(dePropertyChange, 0);
  end else
    quText := quParseSql(Sql.Text, False, sdParams);

  SetLength(quText, lstrlenW(PWideChar(quText)));
end;
{------------------------------------------------------------------------------}
function TnxQuery.sdGetQueryInfo(out aText: UnicodeString): TnxStatementType;
begin
  Result := stQuery;
  aText := quText;
end;
{==============================================================================}



{===TnxStoredProc==============================================================}
procedure TnxStoredProc.ExecProc;
begin
  sdExec;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProc.Prepare;
begin
  dsStartBusy;
  try
    inherited;
    if Params.Count = 0 then
      spCreateParams;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProc.PSSetCommandText(const aCommandText: string);
begin
  if aCommandText <> '' then
    StoredProcName := aCommandText;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProc.RefreshParam;
begin
  dsStartBusy;
  try
    Params.Clear;
    spCreateParams;
  finally
    dsEndBusy;
  end;
end;
{------------------------------------------------------------------------------}
function TnxStoredProc.sdGetQueryInfo(out aText: UnicodeString): TnxStatementType;
begin
  Result := stStoredProcedure;
  aText := spStoredProcName;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProc.spCreateParams;
var
  ServerParams : TnxStoredProcParamList;
  i            : Integer;
begin
  Database.GetStoredProcParams(spStoredProcName, ServerParams);
  if Length(ServerParams) = 0 then
    Database.GetStoredFuncParams(spStoredProcName, ServerParams);

  for i := Low(ServerParams) to High(ServerParams) do
    with ServerParams[i], TParam(Params.Add) do begin
      ParamType := ParamTypeFromNexusDB[piParamType];
      DataType := TnxBaseVclFieldMapper.MapNexusToParamType(piDataType);
      Size := piSize;
      Name := piParamName;
    end;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProc.spSetStoredProcName(const Value: string);
begin
  if not (csReading in ComponentState) then begin
    CheckInactive;
    if Value <> spStoredProcName then begin
      spStoredProcName := Value;
      Unprepare;
      sdParams.Clear;
      if csDesigning in ComponentState then try
        spCreateParams;
      except end;
    end;
  end else
    spStoredProcName := Value;
end;
{==============================================================================}

{$IFDEF DCC16OrLater}
type
  TBookmarkAvailable = function(Self: TDataSet): Boolean;
  TBookmarkAvailableEvent = function: Boolean of object;

var
  CodePointer_TDataSet_BookmarkAvailable : TBookmarkAvailable;
  Trampoline_TDataSet_BookmarkAvailable  : TBookmarkAvailable;

function Detour_TDataSet_BookmarkAvailable(Self: TDataSet): Boolean;
var
  lIsNxDataSet: Boolean;
begin
  lIsNxDataSet := Self is TnxDataSet;

  if lIsNxDataSet then
    TnxDataSet(Self).BeforeBookmarkAvailable;

  Result := Trampoline_TDataSet_BookmarkAvailable(Self);

  if lIsNxDataSet then
    TnxDataSet(Self).AfterBookmarkAvailable(Result);
end;

type
  TSetState = procedure(Self: TDataSet; Value: TDataSetState);
  TSetStateEvent = procedure(Value: TDataSetState) of object;

var
  CodePointer_TDataSet_SetState : TSetState;
  Trampoline_TDataSet_SetState  : TSetState;

procedure Detour_TDataSet_SetState(Self: TDataSet; Value: TDataSetState);
var
  lIsNxDataSet: Boolean;
begin
  lIsNxDataSet := Self is TnxDataSet;

  if lIsNxDataSet then
    TnxDataSet(Self).BeforeSetState(Value);

  Trampoline_TDataSet_SetState(Self, Value);

  if lIsNxDataSet then
    TnxDataSet(Self).AfterSetState;
end;


procedure InitDetour;
var
  lBookmarkAvailable : TBookmarkAvailableEvent;
  lSetState          : TSetStateEvent;
  Handle             : THandle;
begin
  {$IFDEF DCC12OrLater}
  {$WARN CONSTRUCTING_ABSTRACT OFF}
  {$ENDIF}
  with TnxDataSet.Create(nil) do try
    lBookmarkAvailable := BookmarkAvailable;
    CodePointer_TDataSet_BookmarkAvailable := TMethod(lBookmarkAvailable).Code;
    lSetState := SetState;
    CodePointer_TDataSet_SetState := TMethod(lSetState).Code;
  finally
    Free;
  end;
  {$IFDEF DCC12OrLater}
  {$WARN CONSTRUCTING_ABSTRACT ON}
  {$ENDIF}

  Handle := BeginTransaction;
  try

    @Trampoline_TDataSet_BookmarkAvailable := InterceptCreate(@CodePointer_TDataSet_BookmarkAvailable, @Detour_TDataSet_BookmarkAvailable);
    @Trampoline_TDataSet_SetState := InterceptCreate(@CodePointer_TDataSet_SetState, @Detour_TDataSet_SetState);

  finally
    EndTransaction(Handle);
  end;
end;

procedure DoneDetour;
var
  Handle : THandle;
begin
  Handle := BeginTransaction;
  try

    InterceptRemove(@Trampoline_TDataSet_BookmarkAvailable);
    InterceptRemove(@Trampoline_TDataSet_SetState);

  finally
    EndTransaction(Handle);
  end;
end;
{$ENDIF}

{==============================================================================}

{ TnxMasterDataLink }

procedure TnxMasterDataLink.RecordChanged( Field : TField );   //..
begin
     If   ( DataSource.State<>dsSetKey ) and
          DataSet.Active and
          ( ( Fields.Count>0 ) or FOnSetLinkRangeAssigned or FOnApplyMasterRangeAssigned ) and
          ( ( Field=nil ) or ( Fields.IndexOf( Field )>=0 ) ) and
          Assigned( OnMasterChange )
     then OnMasterChange( Self );
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  {$IFDEF DCC16OrLater}
    {$IFDEF BCB}
      {$IFDEF CPUX64}
      InitDetour;
      {$ENDIF}
    {$ELSE}
    InitDetour;
    {$ENDIF}
  {$ENDIF}
finalization
  {$IFDEF DCC16OrLater}
    {$IFDEF BCB}
      {$IFDEF CPUX64}
      DoneDetour;
      {$ENDIF}
    {$ELSE}
    DoneDetour;
    {$ENDIF}
  {$ENDIF}
end.
