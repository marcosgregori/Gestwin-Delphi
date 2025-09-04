{##############################################################################}
{# NexusDB: nxsqlBase.pas 4.7516                                             #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: SQL Base Class Definitions                                        #}
{##############################################################################}

{$I nxDefine.inc}
{.$DEFINE DebugPsmStreams}

{$IFDEF DCC10OrLater}
  {$DEFINE SCOPE_ON_STACK}
{$ENDIF}

unit nxsqlBase;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Classes,
  nxllFastFillChar,
  nxllTypes,
  nxllMemoryManager,
  nxllList,
  nxllException,
  nxllSync,
  nxsdDataDictionary,
  nxsrSqlEngineBase,
  nxsdTypes,
  nxSQLProxiesIntf,
  nxsdServerEngine,
  nxsqlProxies,
  CocoaBaseW;

const
  CInternalVars: array[0..1] of String = ('$SQL$NO_HASH_JOIN', '$SQL$NO_MERGE_JOIN');

type
  EnxSqlException = class(EnxBaseException);
  EnxInternalSQLException = class(EnxBaseException);

  TnxSqlNode = class;

  TnxSqlPSMWriter = class
  private
{$IFDEF DebugPsmStreams}
    procedure WriteRawByte(B: Byte);
{$ENDIF}
  protected
    FTargetStream: TStream;
  public
    constructor Create(TargetStream: TStream);
    procedure WriteBool(B: Boolean);
    procedure WriteByte(B: Byte);
    procedure WriteInt(I: Integer);
    procedure WriteInt64(I: int64);
    procedure WriteLString(const Str: string);
    procedure WritePString(const Str: ShortString);
    procedure WriteWString(const Str: WideString);
    procedure WriteNode(Node: TnxSqlNode);
    procedure WriteNodeOpt(Node: TnxSqlNode);
  end;

  TnxSqlPSMReader = class
  private
{$IFDEF DebugPsmStreams}
    function ReadRawByte: Byte;
{$ENDIF}
  protected
    FSourceStream: TStream;
    FVersion: integer;
  public
    constructor Create(SourceStream: TStream);
    function ReadBool: Boolean;
    function ReadByte: Byte;
    function ReadInt: Integer;
    function ReadInt64: int64;
    function ReadLString: string;
    function ReadPString: ShortString;
    function ReadWString: WideString;
    function ReadNode(AOwner: TnxSqlNode): TnxSqlNode;
    function ReadNodeOpt(AOwner: TnxSqlNode): TnxSqlNode;
    property Version: integer read fVersion;
  end;

  TnxSqlExecScopeType = (estMainBlock, estBlock, estLoop);

  {$IFDEF SCOPE_ON_STACK}
  PnxSqlExecScope = ^TnxSqlExecScope;
  {$ENDIF}

  TnxSqlExecScope = {$IFDEF SCOPE_ON_STACK}record{$ELSE}class(TnxObject){$ENDIF}
  private
    esPrev: {$IFDEF SCOPE_ON_STACK}PnxSqlExecScope{$ELSE}TnxSqlExecScope{$ENDIF};
    FPC, FEndPC: Integer;
    FScopeType: TnxSqlExecScopeType;
    FBreakCalled: Boolean;
  public
    constructor Create(aScopeType: TnxSqlExecScopeType{; aEndPC: Integer});
    {$IFDEF SCOPE_ON_STACK}
    procedure Free;
    {$ENDIF}

    procedure Reset;

    function Next: Boolean;
    function Done: Boolean;
    procedure Continue;
    procedure Break;

    property PC: Integer read FPC;
    property EndPC: Integer read FEndPC write FEndPC;
    property ScopeType: TnxSqlExecScopeType read FScopeType;
    property BreakCalled: Boolean read FBreakCalled write FBreakCalled;
  end;

  {$IFDEF SCOPE_ON_STACK}
  TnxSqlExecScopePtr = PnxSqlExecScope;
  {$ELSE}
  TnxSqlExecScopePtr = TnxSqlExecScope;
  {$ENDIF}

  TnxSqlExternalColumnResolver = function(const ColumnName: string;
    var ColType: TnxFieldType; var ColSize: Integer; var ColDec: Integer; var ColLocaleDesc: TnxLocaleDescriptor): Integer of object;
  TnxSqlExternalColumnGetter = function(Index: Integer): variant of object;

  TnxSqlTriggerAction = (taNone, taInserting, taUpdating, taDeleting);

  TnxSqlContext = class(TnxObject)
  protected
    FDataBase: TnxSqlDatabaseProxy;
    FLocalValues: InxVariantList;
    FLocals: TnxFastStringListIC;
    FExceptionErrorCode: TnxResult;
    FExceptionMessage: string;
    FExecScopesTail: TnxSqlExecScopePtr;
    FExternalColumnResolver: TnxSqlExternalColumnResolver;
    FExternalColumnGetter: TnxSqlExternalColumnGetter;
    FTriggerAction: TnxSqlTriggerAction;
    FStartDateTime : TDateTime;
    FRowsAffected: integer;
    FRowsRead: integer;
    FIsSqlFilter: Boolean;
    FDefaultStringLiteralLocale: TnxLocaleDescriptor;
  public
    AllowNull: Boolean;
    fIteratorValues: PnxKeyBuffer;
    fIteratorData: Pointer;
    GlobalFilters: TList;
    FetchStatus: Integer;
    ExecDirect: Boolean;
    PadValues: Boolean;
    ContextID: Integer;
    Generation: Integer;
    RecordsRead: Int64;

    constructor Create(aDatabase: TnxSqlDatabaseProxy; aStartDateTime: TDateTime; aDefaultStringLiteralLocale: TnxLocaleDescriptor);
    destructor Destroy; override;

    property StartDateTime: TDateTime read FStartDateTime;
    property RowsAffected: integer read FRowsAffected write FRowsAffected;
    property RowsRead: integer read FRowsRead write FRowsRead;
    property IsSqlFilter: Boolean read FIsSqlFilter write FIsSqlFilter;
    property DefaultStringLiteralLocale: TnxLocaleDescriptor read FDefaultStringLiteralLocale;

    procedure IncGeneration;

    function LookUpLocal(const VarName: string;
      var LocalDef: TnxObject): PVariant;
    function LookUpLocalIndex(const VarName: string): integer;
    //function LookUpLocalLocale(const VarName: string): DWord;
    function LookUpLocalLocaleDesc(const VarName: string): TnxLocaleDescriptor;
    procedure DefineLocals(List: TnxFastStringListIC);
//    procedure MergeLocals(List: TnxFastStringListIC);
    procedure SetValue(const VarName: string; const Value: variant; aLocale: TnxLocaleDescriptor=nil);
    procedure SetToDefault(const VarName: string);
    function GetValue(const VarName: string): variant;
    function TryGetValue(const VarName: string): variant;
    procedure PushExecScope(var Scope: TnxSqlExecScope);
    function PopExecScope(aFree: Boolean = True): TnxSqlExecScopePtr;
    procedure Break;
    procedure Continue;
    function Done: Boolean;
    procedure Return;
    function Next: Boolean;
    function PC: Integer;
    procedure SetEndPC(EndPC: Integer);
    //procedure DumpLocals;
    function BreakCalled: Boolean;
    property ExceptionErrorCode: TnxResult read FExceptionErrorCode write FExceptionErrorCode;
    property ExceptionMessage: string read FExceptionMessage write FExceptionMessage;
    property ExternalColumnResolver: TnxSqlExternalColumnResolver
       read FExternalColumnResolver write FExternalColumnResolver;
    property ExternalColumnGetter: TnxSqlExternalColumnGetter
      read FExternalColumnGetter write FExternalColumnGetter;
    property TriggerAction: TnxSqlTriggerAction
      read FTriggerAction write FTriggerAction;
    procedure UpdateTime;

    property DatabaseProxy: TnxSqlDatabaseProxy
      read FDataBase;
  end;

  TnxSqlBindingStyle = (bsNormal, bsCorrelation, bsEmbedded);

  TnxSqlBlock = class;
  TnxSqlRootNode = class;
  TnxSqlCallback = procedure(Node: TnxSqlNode; UserData: TObject) of object;
  TnxSqlColumnListOwner = class;
  TnxSqlNode = class(TnxObject)
  private
    function GetContextParent: TnxSqlNode;
  protected
    FParent : TnxSqlNode;
    FOwner : TnxSqlRootNode;
    FOwnerSelect: TnxSqlColumnListOwner;
    FSourceLine: integer;
    procedure EBadCol(const ColName: string); overload;
    procedure EBadCol(const TableName, ColName: string); overload;
    procedure EBadCol(Token: PTokenRecord); overload;
    procedure EBadCol(TableName: PTokenRecord; const ColName: string); overload;
    procedure EBadTab(const TableName: string; const Location: string = ''); overload;
    procedure EBadTab(const aTableName: string; Token: PTokenRecord); overload;
    procedure EInvColRef; overload;
    procedure EInvColRef(const ColName: string); overload;
    procedure ENotCompatible(Source: TnxSqlNode);
    procedure ENotImpl(const MethodName: string);
    procedure EUnres(const TableName, ColName, Loc: string);
    function GetOwnerSelect : TnxSqlNode;
    function GetVersion: integer; virtual;
    class procedure SQLError(const ErrorMsg: string);
    procedure TypeMismatch(const Loc: string = '');
    procedure SetOwner(Value: TnxSqlRootNode);
    function IsContextRoot: Boolean; virtual;
  public
    class function NodesIdentical(N1, N2: TnxSqlNode): Boolean;
    property Owner :   TnxSqlRootNode read FOwner write SetOwner;
    property OwnerSelect : TnxSqlNode read GetOwnerSelect;
    property Parent : TnxSqlNode read FParent write FParent;
    property ContextParent: TnxSqlNode read GetContextParent;
    property SourceLine: integer read FSourceLine write FSourceLine;

    { called just before the destructor is called to allow for removal of
      dependencies between components. }
    procedure PrepareDestroy; virtual;

    procedure Assign(const Source: TnxSqlNode); virtual; abstract;
    function BindColumn(Context: TnxSqlContext; aInAggregate: Boolean; const DatabaseName, TableName, ColumnName, SourceLoc: string;
      BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean; MustSucceed: Boolean): TnxSqlFieldProxy; virtual; stdcall;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; virtual; abstract;
    constructor Create(AParent: TnxSqlNode); virtual;
    function Equals(ANode: TnxSqlNode): Boolean; reintroduce; virtual; abstract;
    function GetDecimals(Context: TnxSqlContext): Integer; virtual;
    function GetSize(Context: TnxSqlContext): Integer; virtual;
    function GetType(Context: TnxSqlContext): TnxFieldType; virtual;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); virtual; abstract;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); virtual; abstract;
    function ToString: WideString; reintroduce; virtual; abstract;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); virtual; stdcall; abstract;
    function IsParentTo(aChildNode: TnxSqlNode): Boolean;
    {function IsMemberOfPSMBlock: Boolean;}

    procedure LogNormal(const S: string); virtual;
    procedure LogVerbose(const S: string); virtual;
    function GetLogging: Boolean; virtual;
    function GetVerboseLogging: Boolean; virtual;
    procedure Indent; virtual;
    procedure Outdent; virtual;
    property Logging: Boolean read GetLogging;
    property NormalLogging: Boolean read GetLogging;
    property VerboseLogging: Boolean read GetVerboseLogging;
  end;

  InxSqlLockContainer = interface(InxInterface)
    ['{3C0D65E2-124A-4F02-BEAE-691CAE28CBFF}']
    procedure slcBeginUse;
    procedure slcEndUse;
    procedure Lock;
    procedure UnLock;
    function UseCount: integer;
    function CanOwnerBeFreed: Boolean;
  end;

   TnxSqlLockContainer = class(TnxInterfacedObject, InxSqlLockContainer)
   protected
     slcPadlock        : TnxPadlock;
     slcInUse          : Integer;
     slcInUseBy        : Cardinal;
     procedure slcInitPadlock;
     procedure slcBeginUse;
     procedure slcEndUse;
   public
     procedure Lock;
     procedure UnLock;
     function UseCount: integer;
     function CanOwnerBeFreed: Boolean;
     destructor Destroy; override;
   end;

   TnxSqlLockContainerIgnore = class(TnxInterfacedObject, InxSqlLockContainer)
   protected
    procedure slcBeginUse;
    procedure slcEndUse;
   public
     procedure Lock;
     procedure UnLock;
     function UseCount: integer;
     function CanOwnerBeFreed: Boolean;
   end;

  TnxSqlLockNode = class(TnxSqlNode)
  protected
    snLockContainer : InxSqlLockContainer;
  public
    constructor Create(AParent: TnxSqlNode); override;
    //constructor CreateWithLock(AOwner: TnxSqlNode; aLockContainer: InxSqlLockContainer); never used
    procedure Assign(const Source: TnxSqlNode); override;
    destructor Destroy; override;

    procedure snBeginUse;
    procedure snEndUse;

    property LockContainer: InxSqlLockContainer read snLockContainer;
  end;

  TnxSqlNodeList = class(TnxSqlNode)
  protected
    FList : TList;
    FOwner: TnxSqlNode;
    FOwnsItems: Boolean;
    procedure Clear;
    function GetItem(Index: Integer): TnxSqlNode; {$IFDEF DCC11OrLater} inline; {$ENDIF}
    function GetCount: Integer; {$IFDEF DCC11OrLater} inline; {$ENDIF}
  public
    property Item[Index: Integer]: TnxSqlNode read GetItem; default;
    property Count : Integer read GetCount;
    property Owner: TnxSqlNode read FOwner;
    property OwnsItems: Boolean read FOwnsItems write FOwnsItems;

    constructor Create(AOwner: TnxSqlNode); override;
    destructor Destroy; override;
    class function Identical(List1, List2: TnxSqlNodeList): Boolean;
    function IndexOf(Item: TnxSqlNode): Integer;
    procedure Insert(Index: Integer; Item: TnxSqlNode);

    function Add(Item: TnxSqlNode): TnxSqlNode; virtual;
    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(AList: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlFieldRef = class(TnxSqlNode)
  private
    FFieldName: PTokenRecord;
    FFieldNameStr: string;
    FTableName: PTokenRecord;
    FTableNameStr: string;
    FArgs: TList;
    TypeKnown : Boolean;
    FType : TnxFieldType;
    FSize: Integer;
    FDecimals: Integer;
    FField : TnxSqlFieldProxy;
    FFieldLifetimeMonitor: InxLifetimeMonitorRef;
    FFunction: TnxSqlNode; { actually TnxSqlAbstractFunc }
    fFunctionType: integer;
    FWasWildcard: Boolean;
    ExternalIndex: Integer;
    (*ExternalSize: Integer; // external size
    ExternalDecimals: Integer; // external number of decimals*)
    FLocaleDesc: TnxLocaleDescriptor;
    IsLocalVar: Boolean;
    FDatabaseName: PTokenRecord;
    FDatabaseNameStr: string;
    FIsOuterReference: Boolean;
    FAddedByWildcard: Boolean;
    fQuoted: Boolean;
    fFuncArgs: InxTypedVariantList;


    function CallFunc(Context: TnxSqlContext): Variant; stdcall;
    procedure CheckType(Context: TnxSqlContext; RaiseExceptions: Boolean = true);
    procedure InternalCheckType(Context: TnxSqlContext; RaiseException: Boolean);
    function GetArg(Index: Integer): TnxSqlNode;
    function GetArgCount: Integer;
    function GetTableNameStr: string;
    procedure SetTableNameStr(const Value: string);
    function GetFieldNameStr: string;
    function GetFieldNameFromToken: string;
    procedure SetFieldNameStr(const Value: string);
    procedure Clear;
    function GetDatabaseNameStr: string;
    procedure SetDatabasenameStr(const Value: string);
    function IsPartOfSelectionList: Boolean;
    procedure CheckCompat(TargetType, ValueType: TnxFieldType; const Loc,
      Expr: string);
    function GetQuoted: boolean;
    procedure ReleaseFunction;
  public
    property Arg[Index: Integer]: TnxSqlNode read GetArg; // actually TnxSqlCondExp
    property ArgCount: Integer read GetArgCount;
    property FieldName : PTokenRecord read FFieldName write FFieldName;
    property FieldNameStr: string read GetFieldNameStr write SetFieldNameStr;
    property FunctionRef: TnxSqlNode read FFunction;
    property TableName : PTokenRecord read FTableName write FTableName;
    property TableNameStr: string read GetTableNameStr write SetTableNameStr;
    property WasWildcard: Boolean read FWasWildcard write FWasWildcard;
    property DatabaseName: PTokenRecord read FDatabaseName write FDatabaseName;
    property DatabaseNameStr: string read GetDatabaseNameStr write SetDatabasenameStr;
    property Quoted: boolean read GetQuoted;

    property AddedByWildcard: Boolean read FAddedByWildcard write FAddedByWildcard;

    procedure AddArg(Arg: TnxSqlNode);
    function AllColumnReferencesQualified(const AliasName: string;
      var QualRefList: TnxFastStringListIC): Boolean;
    function DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
    procedure SetField(Value: TnxSqlFieldProxy);
    function FieldNameLoc: string;
    //function GetLocale(Context: TnxSqlContext): DWord;
    function GetLocaleDesc(Context: TnxSqlContext): TnxLocaleDescriptor;
    //function GetCodepage(Context: TnxSqlContext): Integer;
    function GetField(Context: TnxSqlContext; RaiseExceptions: Boolean = true): TnxSqlFieldProxy;
    function GetTitle(const Qualified, Quoted : boolean): string;
    function GetValueAsLenString(PV: PVariant; l: Integer): Variant;
    function GetValue(Context: TnxSqlContext): Variant;
    function IsAggregate(Strict: Boolean): Boolean;
    function IsColumnRef: Boolean;
    function IsOwnedByAggregate: Boolean;
    function IsDeterministic(Context: TnxSqlContext; aWithinRow: Boolean): Boolean;
    function IsFieldFrom(Context: TnxSqlContext; Table: TnxSqlTableProxy;
      var FieldReferenced: TnxSqlFieldProxy; var SameCase: Boolean; UpperLowerAccepted: Boolean; RaiseExceptions: Boolean = true): Boolean;
    function IsLocalVariable(Context: TnxSqlContext; var LocalNameStr: string): Boolean;
    function IsNull(Context: TnxSqlContext): Boolean;
    function IsOuterReference(Context: TnxSqlContext): Boolean;
    function IsUpperExpr(var Argument: TnxSqlNode): Boolean;
    function LocationStr: string;
    procedure MatchType(Context: TnxSqlContext; ExpectedType: TnxFieldType);
    {function QualifiedName : string;}
    function RefersTo(const aTableName: string): Boolean; overload; stdcall;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload; stdcall;
    function RefersToContextVar(Context: TnxSqlContext): Boolean;
    procedure Unbind;

    function IsUnqualifiedFunction: Boolean;
    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    constructor Create(AOwner: TnxSqlNode); override;
    destructor Destroy; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function GetDecimals(Context: TnxSqlContext): Integer; override;
    function GetSize(Context: TnxSqlContext): Integer; override;
    function GetType(Context: TnxSqlContext): TnxFieldType; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    property Args: TList read fArgs;
  end;

  TnxSqlColumn = class(TnxSqlNode)
  private
    function GetColumnNameStr: string;
    procedure SetColumnNameStr(const Value: string);
  protected
    FColumnName: PTokenRecord;
    FColumnNameStr: string;
  public
    property ColumnName: PTokenRecord read FColumnName write FColumnName;
    property ColumnNameStr: string read GetColumnNameStr write SetColumnNameStr;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlBaseColumn = class(TnxSqlNode)
  protected
    FFieldName: PTokenRecord;
    FFieldNameStr: string;
    FTableName: PTokenRecord;
    FTableNameStr: string;
    function GetTableNameStr: string;
    procedure SetTableNameStr(const Value: string);
    function GetFieldNameStr: string;
    procedure SetFieldNameStr(const Value: string);
  public
    property TableName: PTokenRecord read FTableName write FTableName;
    property TableNameStr: string read GetTableNameStr write SetTableNameStr;
    property FieldName: PTokenRecord read FFieldName write FFieldName;
    property FieldNameStr: string read GetFieldNameStr write SetFieldNameStr;

    function FieldNameLoc: string;

    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
  end;

  TnxObjectProc = function: Boolean of object;

  TnxSqlTriStateBool = (tsbUnknown, tsbFalse, tsbTrue);

  TnxSqlRootNode = class(TnxSqlLockNode)
  private
    FUseIndexes: Boolean;
    FAllowSimplification: Boolean;
    FCopyBlobs: Boolean;
    FParentBlock: TnxSqlBlock;
    Roots: TList;
    {function GetParmValue(Index: Integer): Variant;}
    function GetParentBlock: TnxSqlBlock;
    procedure SetUseIndexes(const Value: Boolean);
    //procedure UpdateUseIndexes(Node: TnxSqlNode; UserData: TObject);
    procedure SetCopyBlobs(const Value: Boolean);
    //procedure UpdateCopyBlobs(Node: TnxSqlNode; UserData: TObject);
    procedure SetDatabase(Value: TnxSqlDatabaseProxy);
    function GetParmPtr(Index: Integer): PVariant;
    function GetParameterLocale(Index: Integer): TnxLocaleDescriptor;
    function GetParameterFieldType(Index: Integer): TnxFieldType;
    procedure DoQualify(Node: TnxSqlNode; UserData: TObject);
  protected
    FDatabase : TnxSqlDatabaseProxy;
    procedure AddRoot(Node: TnxSqlRootNode);
    procedure RemoveRoot(Node: TnxSqlRootNode);
    function GetParmCount: Integer; virtual;
  public
    IsCreate: Boolean;
    IsAlter: Boolean;

    function BindingDatabase: TnxSqlDatabaseProxy;
    procedure QualifyColumns(const aTableName: String);
    property AllowSimplification: Boolean read FAllowSimplification write FAllowSimplification;
    property CopyBlobs: Boolean read FCopyBlobs write SetCopyBlobs;
    property Database: TnxSqlDatabaseProxy read FDatabase write SetDatabase;
    {property Parameter[Index: Integer]: Variant read GetParmValue;}
    property ParameterPtr[Index: Integer]: PVariant read GetParmPtr;
    property ParameterLocale[Index: Integer]: TnxLocaleDescriptor read GetParameterLocale;
    property ParameterType[Index: Integer]: TnxFieldType read GetParameterFieldType;
    property Parameters: Integer read GetParmCount;
    property ParentBlock: TnxSqlBlock read GetParentBlock;
    property UseIndexes: Boolean read FUseIndexes write SetUseIndexes;

    procedure ParametersChanged; virtual;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); virtual; abstract;
    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;
    function WhereIsValidFilterStatement: Boolean; virtual;
    procedure BindWhere(aContext: TnxSqlContext); virtual;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool; virtual;
    function EvaluateFirst(Context: TnxSqlContext): variant; virtual;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult; virtual; abstract;
    function IsDDLStatement: Boolean; virtual;
    procedure IncParmCount;
    function NeedsUnbinding: Boolean; virtual;
    function RefersTo(const aTableName: string): Boolean; virtual; abstract;
    function RefersTo2(const aTableName, aColumnName: string): Boolean; virtual; abstract;
    function RefersToContextVars(Context: TnxSqlContext): Boolean; virtual;
    function Simplify(Context: TnxSqlContext): Boolean; virtual; abstract;
    {procedure SetParentBlock(AParentBlock: TnxSqlBlock);} // used by views only
    procedure Unbind; virtual; abstract;
  end;

  TnxSqlColumnDefiner = class(TnxSqlNode)
  public
    procedure AddColumnDef(Target: TnxSqlColumnListOwner); virtual; abstract;
  end;

  TnxSqlInsertItem = class(TnxSqlColumnDefiner)
  private
    function GetColumnNameStr: string;
    procedure SetColumnNameStr(const Value: string);
  protected
    FColumnName: PTokenRecord;
    FColumnNameStr: string;
  public
    property ColumnName: PTokenRecord read FColumnName write FColumnName;
    property ColumnNameStr: string read GetColumnNameStr write SetColumnNameStr;

    procedure AddColumnDef(Target: TnxSqlColumnListOwner); override;
    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    function ToString: WideString; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
  end;

  TnxColumn = class(TnxObject)
  private
    function GetHasLocation: Boolean;
    function GetLocation: string;
    function GetName: string;
    function GetFieldRef: TnxSqlFieldRef;
  protected
    FName: string;
    FToken: PTokenRecord;
    FInfo: TObject;
    FHidden: Boolean;
  public
    constructor Create(aToken: PTokenRecord; aInfo: TObject);
    property Name: string read GetName write FName;
    property Info: TObject read FInfo write FInfo;
    property Location: string read GetLocation;
    property HasLocation: Boolean read GetHasLocation;
    property Token: PTokenRecord read FToken;
    property Hidden: Boolean read FHidden;
    property FieldRef: TnxSqlFieldRef read GetFieldRef;
  end;

  TnxColumnList = class(TnxObject)
  private
    function GetColumn(Index: Integer): TnxColumn;
    function GetCount: Integer; {$IFDEF DCC11OrLater} inline; {$ENDIF}
    {procedure SetColumn(Index: Integer; const Value: TnxColumn);}
  protected
    FList: TList;
  public
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    procedure AddColumn(const aName: string; aInfo: TObject); overload;
    procedure AddColumn(const aName: string; aInfo: TObject; Hidden: Boolean); overload;
    procedure AddColumn(aToken: PTokenRecord; aInfo: TObject); overload;
    property Column[Index: Integer]: TnxColumn read GetColumn{ write SetColumn}; default;
    function Exists(const Search: string): Boolean;
    function IndexOf(const Search: string): Integer; stdcall;
  end;

  TnxSqlSetPasswordsMode = (spRemoveAll, spAddList, spRemoveList, spReplaceWithList);
  TnxSqlSetPasswords = class(TnxSqlRootNode)
  private
    FMode: TnxSqlSetPasswordsMode;
    FPasswordList: TnxFastStringListIC;
  public
    property Mode: TnxSqlSetPasswordsMode read FMode write FMode;
    procedure AddPassword(PW: PTokenRecord); overload;
    procedure AddPassword(const PW: string); overload;
    procedure Clear;

    destructor Destroy; override;

    procedure Assign(const Source: TnxSqlNode); override;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); override;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult; override;
    function ExecuteDirect(aDatabase: TnxSqlAbstractDatabase) : TnxResult;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    function RefersTo(const aTableName: string): Boolean; override;
    function RefersTo2(const aTableName, aColumnName: string): Boolean; override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function Simplify(Context: TnxSqlContext): Boolean; override;
    procedure Unbind; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlColumnListOwner = class(TnxSqlRootNode)
  protected
    FT : TnxSqlTableProxy;
    //FColumns : TnxFastStringListIC;
    FColumnList: TnxColumnList;
    //function GetColumns: TnxFastStringListIC;
  public
    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;
    //property Columns: TnxFastStringListIC read GetColumns;
    property Columns: TnxColumnList read FColumnList;
    property T: TnxSqlTableProxy read FT;
  end;

  TnxSqlStatementBlock = class(TnxSqlRootNode)
  private
    FAtomic: Boolean;
    AnyViewsBound: Boolean;
  protected
    FStatementList: TList;
    procedure SetDatabase(const Value: TnxSqlDatabaseProxy);
    {procedure UpdateDatabase(Node: TnxSqlNode; UserData: TObject);}
    function IsPsmBlock: Boolean; virtual;
  public
    property Atomic: Boolean read FAtomic write FAtomic;
    property Database: TnxSqlDatabaseProxy read FDatabase write SetDatabase;

    property StatementList: TList read FStatementList;

    function RefersTo(const aTableName: string): Boolean; override;
    function RefersTo2(const aTableName, aColumnName: string): Boolean; override;

    procedure AddStatement(Statement: TnxSqlRootNode);
    procedure Assign(const Source: TnxSqlNode); override;
    procedure Clear;
    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); override;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function Simplify(Context: TnxSqlContext): Boolean; override;
    procedure Unbind; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlCustomSwitch = class
  private
    FSwitchName: PTokenRecord;
    FSwitchGroup: PTokenRecord;
    FSwitchValue: PTokenRecord;
  public
    property SwitchGroup: PTokenRecord read FSwitchGroup write FSwitchGroup;
    property SwitchName: PTokenRecord read FSwitchName write FSwitchName;
    property SwitchValue: PTokenRecord read FSwitchValue write FSwitchValue;
    constructor Create(aGroup, aItem, aValue: PTokenRecord);
  end;

  TnxSqlLogList = class(TnxFastStringListIC)
  private
    LastLog: Cardinal;
  public
    function Add(const S: string): Integer; override;
  end;

  TnxSqlBlock = class(TnxSqlStatementBlock)
  private
    ParmCount : Integer;
    ParmList : InxTypedVariantList;
    FIndentation: Integer;
    FLogging: Boolean;
    FVerboseLogging: Boolean;
    FFeatureSwitches: TStringList;
    FLogList: TnxSqlLogList;
    FStartDate,
    FStartDateTime,
    FStartTime : TDateTime;
    FTimeoutStr: PTokenRecord;
    Switches: TList;
    FOwnerStatement: TnxAbstractStatement;
    function GetLastStatement: TnxSqlRootNode;
    function IndentStr: string;
    procedure SetLogging(const Value: Boolean);
    procedure SetFeatureSwitches(Value: TStringList);
    procedure SetVerboseLogging(const Value: Boolean);
    procedure ApplyCustomSwitches;
    procedure SetCustomSwitchValue(const Group, Item, Value: string);
    procedure ClearCustomSwitch(const Group, Item: string);
    function GetSwitchOwner(const Group: string): TnxExtendableServerObject;
  public
    property OwnerStatement: TnxAbstractStatement read FOwnerStatement write FOwnerStatement;
    property LastStatement: TnxSqlRootNode read GetLastStatement;
    procedure AddSwitch(aGroup, aItem, aValue: PTokenRecord);
    procedure Assign(const Source: TnxSqlNode); override;
    procedure BindDatabase(aDatabase : TnxSqlDatabaseProxy; DefaultStringLiteralLocale: TnxLocaleDescriptor);
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    constructor Create(AParent: TnxSqlNode); override;
    procedure Clear;
    destructor Destroy; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool; override;
    function EvaluateFirst(Context: TnxSqlContext): variant; override;
    function FeatureEnabled(const FeatureName: string; DefaultValue: Boolean): Boolean;
    property FeatureSwitches: TStringList read FFeatureSwitches write SetFeatureSwitches;
    function WhereIsValidFilterStatement: Boolean; override;
    procedure BindWhere(aContext: TnxSqlContext); override;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean;
                     var aCursor: TnxAbstractCursor;
                     var RowsAffected,
                         aRecordsRead: integer) : TnxResult; override;
    procedure LogNormal(const s: string); override;
    procedure LogVerbose(const s: string); override;
    function GetLogging: Boolean; override;
    function GetVerboseLogging: Boolean; override;
    procedure Indent; override;
    procedure Outdent; override;
    property Logging: Boolean read GetLogging write SetLogging;
    property VerboseLogging: Boolean read GetVerboseLogging write SetVerboseLogging;
    property LogList: TnxSqlLogList read FLogList;
    procedure SetParameter(Index: Integer; const Value: Variant;
      aParamType: TnxParamType; aLocale: TnxLocaleDescriptor;
      aFieldType: TnxFieldType);
    function GetParameter(Index: Integer; aParamType: TnxParamType): Variant;
    function Simplify(Context: TnxSqlContext): Boolean; override;
    property StartDate: TDateTime read FStartDate;
    property StartDateTime: TDateTime read FStartDateTime;
    property StartTime : TDateTime read FStartTime;
    property TimeoutStr: PTokenRecord read FTimeoutStr write FTimeoutStr;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); override;
    procedure Unbind; override;
  end;

var
  nxSqlLockContainerClass : TClass = TnxSqlLockContainer;

function DataTypeToStr(ADT: TnxFieldType; ADecimals, ASize: Integer): string;
function IsReservedName(const Name: string): Boolean;
function PosCh(Chr : AnsiChar; const Str : AnsiString) : Cardinal; overload;
function PosCh(Chr : WideChar; const Str : UnicodeString) : Cardinal; overload;
function SplitString(SplitChar: Char; const S: string; var Rest: string): string;
function StripQuotes(const S: string): string;

type
  TnxSqlNodeClass  = class of TnxSqlNode;
  TnxSqlLockNodeClass = class of TnxSqlLockNode;

function NodeFromString(const ClassName: {$IFDEF UNICODE}string{$ELSE}ShortString{$ENDIF}; AParent: TnxSqlNode): TnxSqlNode;
procedure RegisterNodeType(ClassRef: TnxSqlNodeClass);

procedure CheckGlobalTempName(Name: PTokenRecord);
procedure CheckLocalTempName(Name: PTokenRecord);

function ValidColumnName(const aColumnName: string): string;

const
  TriStateBoolFromBool : array[Boolean] of TnxSqlTriStateBool = (tsbFalse, tsbTrue);
  TriStateBoolFromBoolCondNeg : array[Boolean, Boolean] of TnxSqlTriStateBool =
    ((tsbFalse, tsbTrue),
    (tsbTrue, tsbFalse));
//  BoolFromTriStateBool : array[TnxSqlTriStateBool] of Boolean = (False, False, True);

function VariantToTriStateBool(const aValue: Variant): TnxSqlTriStateBool;
function TriStateBoolToVariant(const aValue: TnxSqlTriStateBool): Variant;

var
  {Settings for use only with certain drivers:}

    AllowCompareAgainstNull: Boolean = False;
    { When true, makes comparisons against literal NULL valid, e.g.

          WHERE SomeField = NULL;

     The example above is not valid SQL syntax. The sentiment should be expressed

         WHERE SomeField IS NULL;

     but allowing the first for is convenient in certain driver scenarios.

     This switch should normally be left at its default setting of False.
    }


    //AutoCommitOnDDL: Boolean = False;
    { When true, causes any pending transaction to automatically be committed before
      a DDL statement executes. After the DDL statement has executed, a new transaction
      is automatically started for the non-DDL statements that follow.

      The ODBC driver requires this.

      This switch should normally be left at its default setting of False.
    }

implementation

uses
  {$IFDEF DCC16OrLater}
  Types,
  {$ENDIF}
  nxllConst,
  nxllLockedFuncs,
  nxllBde,
  SysUtils,
  Variants,
  nxSqlEngine,
  nxsrTimeoutHandling,
  nxsqlFunctionOrganizer,
  nxSqlTok,
  nxsqlTableExp,
  nxsqlCondExp,
  nxsqlDataManip,
  nxsqlPSM,
  nxsqlTest,
  nxsqlFunctions,
  Math,
  StrUtils;

resourcestring
  rsNoNodeCouldResolv = 'Ningún nodo pudo resolver la columna %s.%s %s';  //..
  rsUnknownColumnS = 'Columna desconocida %s';
  rsSNotCompatibleWi = '%s no compatible con %s';
  rsErrorInStatement = 'Error en la sentencia: %s';
  rsTypeMismatch = 'No coinciden los tipos';
  rsMethodNotImplement = 'Método no implementado:';
  rsErrorOnATOMICRequ = 'Error en la solicitud ATOMICA. Transacción explícita en curso: las transacciones anidadas no son compatibles ';
  rsATransactionStarte = 'Una transacción iniciada con BEGIN TRANSACTION se debe confirmar o revertir explícitamente';
  rsStandaloneSQLStat = 'Se esperaba una sentencia SQL independiente';
  rsDDLStatementsCanno = 'Las declaraciones DDL no pueden ejecutarse mientras una transacción está activa';
  rsErrorAttemptToSe = 'Error: Se ha intentado establecer un parámetro en una consulta no parametrizada';
  rsErrorAttemptToGe = 'Error: Se ha intentado obtener un parámetro en una consulta no parametrizada';
  rsTypeMismatchBetwee = 'Falta de coincidencia de tipo entre el argumento formal y el real %s (expresión: "%s")';
  rsStoredProceduresCa = 'Los procedimientos almacenados no pueden ser llamados de esta manera.';
  rsFunctionsThatModif = 'Las funciones que modifican datos pueden no ser llamadas en este contexto: %s';
  rsFunctionsThatRetur = 'Las funciones que devuelven una tabla como resultado pueden no ser llamadas en este contexto:%s';
  rsIncorrectNumberOf = 'Número incorrecto de argumentos entre declaración y uso:%s';
  rsNotImpl = 'no impl';
  rsUPPERExpressionIs = 'La expresión UPPER está vacía: %s';
  rsErrorExpectedPSM = 'Se esperaba una etiqueta PSM :%d, en su lugar:%d';
  rsBREAKMayNotAppear = 'BREAK no puede aparecer fuera de un bucle';
  rsCONTINUEMayNotApp = 'CONTINUE no puede aparecer fuera de un bucle';
  rsErrorInTnxSqlConte = 'Error en TnxSqlContext.GetValue - la variable local %s no ha sido encontrada';
  rsRETURNMayNotAppea = 'RETURN no puede aparecer fuera de un bucle';
  rsErrorInTnxSqlConte2 = 'Error wn TnxSqlContext.SetValue - variable local %s no encontrada';
  rsContinueIsNotAllo = 'CONTINUE no está permitido aquí';
  rsTheNameOfAGlobal = 'El nombre de una tabla temporal global debe comenzar con un prefijo ###';
  rsTheNameOfALocal = 'El nombre de una tabla temporal local debe comenzar con un prefijo # o ##';
  rsClassAlreadyRegist = 'Clase ya registrada';
  rsTypeSIsNotRegis = 'El tipo %s no está registrado con el sistema de transmisión PSM';
  rsUnknownColumn = 'Columna desconocida: ';
  rsUnableToResolveTh = 'No se puede resolver el identificador ';
  rsUnableToOpenTable = 'No se puede abrir la tabla: "';
  rsInvalidColumnRefer = 'Referencia de columna no válida';
  rsArgumentsNotAllowedForFieldRef = 'Argumentos no permitidos para referencia de campo: %s';   //..

{

OBSOLETE - see end of comment

const
  nxSqlReservedWordCount = 157;
  nxSqlReservedWords : array[0..nxSqlReservedWordCount-1] of string = (
  'ABS', 'ACHAR', 'ADD', 'ALL', 'ALTER', 'AND', 'ANY', 'AS', 'ASC', 'ASSERT',
  'ASTRING', 'AUTOINC' , 'AVG', 'BETWEEN', 'BLOB', 'BLOCK', 'BLOCKSIZE', 'BOOL',
  'BOOLEAN', 'BOTH', 'BY', 'BYTE', 'BYTEARRAY', 'CASCADE', 'CASE', 'CAST',
  'CEILING', 'CHAR', 'CHARACTER', 'CHARACTER_LENGTH', 'CHAR_LENGTH', 'CHR',
  'COALESCE', 'COLUMN', 'COUNT', 'CREATE', 'CROSS', 'CURRENT_DATE',
  'CURRENT_TIME', 'CURRENT_TIMESTAMP', 'CURRENT_USER', 'DATE', 'DATETIME',
  'DAY', 'DEFAULT', 'DELETE', 'DESC', 'DESCRIPTION', 'DISTINCT', 'DROP', 'DWORD',
  'ELSE', 'EMPTY', 'END', 'ESCAPE', 'EXISTS', 'EXP', 'EXTRACT', 'FALSE', 'FLOOR',
  'FOR', 'FROM', 'FULL', 'GROUP', 'GROW', 'GROWSIZE', 'HAVING', 'HOUR', 'IDENTITY',
  'IGNORE', 'IMAGE', 'IN', 'INDEX', 'INITIAL', 'INITIALSIZE', 'INNER', 'INSERT',
  'INT', 'INTEGER', 'INTERVAL', 'INTO', 'IS', 'JOIN', 'KANA', 'KEY', 'LARGEINT',
  'LEADING', 'LEFT', 'LIKE', 'LOCALE', 'LOG', 'LOWER', 'MATCH', 'MAX', 'MIN',
  'MINUTE', 'MONEY', 'MONTH', 'NATURAL', 'NCHAR', 'NOT', 'NULL', 'NULLIF',
  'NULLSTRING', 'NVARCHAR', 'ON', 'OR', 'ORDER', 'OUTER', 'PARTIAL', 'PERCENT',
  'POSITION', 'POWER', 'PRIMARY', 'RAND', 'REAL', 'RIGHT', 'ROUND', 'SECOND',
  'SELECT', 'SESSION_USER', 'SET', 'SHORTINT', 'SIZE', 'SMALLINT', 'SOME',
  'SORT', 'STRING', 'SUBSTRING', 'SUM', 'SYMBOLS', 'TABLE', 'TEXT', 'THEN',
  'TIME', 'TIMESTAMP', 'TINYINT', 'TO', 'TOP', 'TRAILING', 'TRIM', 'TRUE',
  'TYPE', 'UNION', 'UNIQUE', 'UNKNOWN', 'UPDATE', 'UPPER', 'USE', 'USER',
  'USING', 'VALUES', 'VARCHAR', 'WHEN', 'WHERE', 'WIDTH', 'WORD', 'YEAR');


Instead of this, use:

const
  TokStr : array[0..nn] of string = ( ... );
  FirstKeyword = n1;
  LastKeyword = n2;

from the nxSQLTok unit, which is auto-generated by the parser generator,
and therefore always up to date.
}

function VariantToTriStateBool(const aValue: Variant): TnxSqlTriStateBool;
begin
  if VarIsNull(aValue) then
    Result := tsbUnknown
  else
    if aValue = True then
      Result := tsbTrue
    else
      Result := tsbFalse;
end;

function TriStateBoolToVariant(const aValue: TnxSqlTriStateBool): Variant;
begin
  case aValue of
    tsbTrue: Result := True;
    tsbFalse: Result := False;
  else
    Result := Null;
  end;
end;


function ValidColumnName(const aColumnName: string): string;
var
  i, j: Integer;
begin
  Result := aColumnName;
  for i := 1 to length(Result) do begin
    j := Ord(Result[i]);
    if (j > 255) or not (AnsiChar(j) in nxcValidIdentChars) then
      Result[i] := '_';
  end;
end;

function DataTypeToStr(ADT: TnxFieldType; ADecimals, ASize: Integer): string;
begin
  Result := '';
  case ADT of
  nxtInterval : Result := Result + ' INTERVAL';
  nxtBoolean  :  Result := Result + ' BOOL';
  nxtChar : Result := Result + ' CHAR';
  nxtWideChar :  Result := Result + ' NCHAR';
  nxtByte : Result := Result + ' TINYINT';
  nxtWord16 : Result := Result + ' WORD';
  nxtWord32 : Result := Result + ' DWORD';
  nxtInt8 :  Result := Result + ' SHORTINT';
  nxtInt16 :  Result := Result + ' SMALLINT';
  nxtInt32 :  Result := Result + ' INT';
  nxtInt64 :  Result := Result + ' LARGEINT';
  nxtAutoInc :  Result := Result + ' AUTOINC';
  nxtRecRev :  Result := Result + ' RECREV';
  nxtSingle :  Result := Result + ' FLOAT';
  nxtDouble :  Result := Result + ' REAL';
  nxtExtended :  Result := Result + ' EXTENDED';
  nxtCurrency :  Result := Result + ' MONEY';
  nxtBcd :  Result := Result + ' DECIMAL';
  nxtDate :  Result := Result + ' DATE';
  nxtTime :  Result := Result + ' TIME';
  nxtDateTime :  Result := Result + ' DATETIME';
  nxtBlob :  Result := Result + ' BLOB';
  nxtBLOBMemo :  Result := Result + ' TEXT';
  nxtBlobWideMemo : Result := Result + ' NTEXT';
  nxtBLOBGraphic :  Result := Result + ' IMAGE';
  nxtByteArray :  Result := Result + ' BYTEARRAY';
  nxtShortString :  Result := Result + ' SHORTSTRING';
  nxtNullString :  Result := Result + ' NULLSTRING';
  nxtWideString : Result := Result + ' NVARCHAR';
  nxtGuid :  Result := Result + ' GUID';
  nxtFmtBcd :  Result := Result + ' FMTBCD';
  nxtRefNr :  Result := Result + ' REFNR';
  end;
  case ADT of
  nxtSingle, nxtDouble, nxtExtended, nxtCurrency :
    if ADecimals <> 0 then
      Result := Result + '(' + IntToStr(ADecimals) + ')';
  nxtBCD, nxtFmtBcd :
    Result := Result + '(' + IntToStr(ASize) + ', ' + IntToStr(ADecimals) + ')';
  nxtShortString, nxtNullString, nxtWideString :
    Result := Result + '(' + IntToStr(ASize) + ')';
  end;
end;

function IsReservedName(const Name: string): Boolean;
{var
  i: Integer;}
begin
  Result := IsKeyword(Name);

  {for i := FirstKeyword to LastKeyword do
    if CompareText(Name, TokStr[i]) = 0 then begin
      Result := True;
      exit;
    end;
  Result := False;}
end;

function PosCh(Chr : AnsiChar; const Str : AnsiString) : Cardinal; overload;
{$IFDEF CPUX86}
{-same as POS but searches for a single Char}
asm
  push ebx
  mov ecx, eax
  mov ebx, edx
  mov eax, edx
  test eax, eax
  jz @@3
  mov eax, [eax-04h]
  test eax, eax
  jbe @@3
@@1:
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jz @@3
  cmp cl, [edx]
  jz @@2
  inc edx
  dec eax
  jnz @@1
  jmp @@3
@@2:
  sub edx, ebx
  inc edx
  mov eax, edx
@@3:
  pop ebx
end;
{$ELSE}
begin
  Result := Pos(Chr, Str);
end;
{$ENDIF}

function PosCh(Chr : WideChar; const Str : UnicodeString) : Cardinal; overload;
begin
  Result := Pos(Chr, Str);
end;


function SplitString(SplitChar: Char; const S: string; var Rest: string): string;
var
  P: Integer;
begin
  P := PosCh(SplitChar, S);
  Result := copy(S, 1, P - 1);
  Rest := copy(S, P + 1, length(S) - P);
end;

function StripQuotes(const S: string): string;
begin
  if S <> '' then
    case S[1] of
    '''' :
      if S[length(S)] = '''' then begin
        Result := copy(S, 2, length(S) - 2);
        exit;
      end;
    '"' :
      if S[length(S)] = '"' then begin
        Result := copy(S, 2, length(S) - 2);
        exit;
      end;
    end;
  Result := S;
end;


{ TnxSqlNode }

function TnxSqlNode.BindColumn(Context: TnxSqlContext; aInAggregate: Boolean;
  const DatabaseName, TableName, ColumnName, SourceLoc: string;
  BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean;
  MustSucceed: Boolean): TnxSqlFieldProxy;
var
  cp: TnxSqlNode;
begin
  cp := ContextParent;
  if Assigned(cp) then
    Result := cp.BindColumn(Context, aInAggregate, DatabaseName, TableName,
      ColumnName, SourceLoc, BindingNode, BindingStyle, aIsOuterReference, MustSucceed)
  else
    if TableName <> '' then
      if MustSucceed then
        raise EnxInternalSQLException.CreateResFmt(@rsNoNodeCouldResolv,
          [TableName, ColumnName, SourceLoc])
      else
         Result := nil
    else
      if MustSucceed then
        raise EnxInternalSQLException.CreateResFmt(@rsUnknownColumnS, [ColumnName + SourceLoc])
      else
        Result := nil;
end;

constructor TnxSqlNode.Create(AParent: TnxSqlNode);
begin
  inherited Create;
  FParent := AParent;
  if AParent <> nil then begin
    if AParent is TnxSqlRootNode then
      FOwner := TnxSqlRootNode(AParent)
    else
      FOwner := AParent.Owner;
    Assert(FOwner <> nil);
  end;
end;

procedure TnxSqlNode.EBadCol(const ColName: string);
begin
  SQLError(rsUnknownColumn + ColName);
end;

procedure TnxSqlNode.EBadCol(const TableName, ColName: string);
begin
  EBadCol(TableName + '.' + ColName);
end;

procedure TnxSqlNode.EUnres(const TableName, ColName, Loc: string);
var
  S: string;
begin
  S := rsUnableToResolveTh;
  if TableName <> '' then
    S := S + '"' + StripQuotes(TableName) + '".';
  S := S + '"' + StripQuotes(ColName) + '"';
  S := S + Loc;
  SQLError(S);
end;

procedure TnxSqlNode.EBadCol(TableName: PTokenRecord; const ColName: string);
begin
  EBadCol(TokenToStr(TableName) + '.' + ColName + TokenToLocationStr(TableName));
end;

procedure TnxSqlNode.EBadCol(Token: PTokenRecord);
begin
  SQLError(rsUnknownColumn + TokenToStr(Token) + TokenToLocationStr(Token));
end;

procedure TnxSqlNode.EBadTab(const TableName: string; const Location: string = '');
begin
  SQLError(rsUnableToOpenTable + TableName + '" '+Location);
end;

procedure TnxSqlNode.EBadTab(const aTableName: string; Token: PTokenRecord);
var
  s: string;
begin
  s := rsUnableToOpenTable + aTableName + '"';
  if Assigned(Token) then
    s := s + ' ' + TokenToLocationStr(Token);
  SQLError(s);
end;

procedure TnxSqlNode.ENotCompatible(Source: TnxSqlNode);
begin
  raise EnxInternalSQLException.CreateResFmt(@rsSNotCompatibleWi, [Source.ClassName, ClassName]);
end;

procedure TnxSqlNode.EInvColRef;
begin
  EInvColRef('');
end;

procedure TnxSqlNode.EInvColRef(const ColName: string);
var
  S: string;
begin
  S := rsInvalidColumnRefer;
  if ColName <> '' then
    S := S + ':' + ColName;
  SqlError(S);
end;

function TnxSqlNode.GetContextParent: TnxSqlNode;
begin
  if IsContextRoot then
    Result := nil
  else
    Result := Parent;
end;

function TnxSqlNode.GetDecimals(Context: TnxSqlContext) : Integer;
begin
  Result := 0;
end;

function TnxSqlNode.GetLogging: Boolean;
begin
  Result := Assigned(FParent) and FParent.Logging;
end;

function TnxSqlNode.GetOwnerSelect: TnxSqlNode;
begin
  if (FOwnerSelect = nil) then begin
    FOwnerSelect := TnxSqlSELECT(Self);
    while (FOwnerSelect <> nil)
    and not (TObject(FOwnerSelect) is TnxSqlSELECT) do
      FOwnerSelect := TnxSqlSELECT(FOwnerSelect.Parent);
    if not (TObject(FOwnerSelect) is TnxSqlSELECT) then
      FOwnerSelect := nil;
  end;
  Result := TnxSqlSELECT(FOwnerSelect);
end;

function TnxSqlNode.GetSize(Context: TnxSqlContext): Integer;
begin
  Result := 0;
end;

function TnxSqlNode.GetType(Context: TnxSqlContext): TnxFieldType;
begin
  Result := nxtBoolean;
  Assert(False); {shouldn't get here}
end;

class function TnxSqlNode.NodesIdentical(N1, N2: TnxSqlNode): Boolean;
begin
  if N1 = nil then
    Result := N2 = nil
  else
    if N2 = nil then
      Result := False
    else
      Result := N1.Equals(N2);
end;

procedure TnxSqlNode.Outdent;
begin
  if Assigned(FParent) then
    FParent.Outdent;
end;

procedure TnxSqlNode.PrepareDestroy;
begin
  { can be overridden }
end;

class procedure TnxSqlNode.SQLError(const ErrorMsg: string);
begin
  raise EnxInternalSQLException.CreateResFmt(@rsErrorInStatement, [ErrorMsg]);
end;

procedure TnxSqlNode.TypeMismatch;
begin
  SQLError(rsTypeMismatch + Loc + ' ['+ToString+']');
end;

procedure TnxSqlNode.ENotImpl(const MethodName: string);
begin
  SQLError(rsMethodNotImplement + MethodName);
end;

(*procedure TnxSqlNode.LoadFromStream(Stream: TnxSqlPSMReader);
{var
  aByte: Byte;}
begin

end;

procedure TnxSqlNode.SaveToStream(Stream: TnxSqlPSMWriter);
begin

end;
*)
procedure TnxSqlNode.SetOwner(Value: TnxSqlRootNode);
begin
  fowner:=value;
end;

function TnxSqlNode.GetVerboseLogging: Boolean;
begin
  Result := Assigned(FParent) and FParent.VerboseLogging;
end;

function TnxSqlNode.GetVersion: integer;
begin
  result:=1;
end;

(*
function TnxSqlNode.IsMemberOfPSMBlock: Boolean;
var
  aNode: TnxSQLNode;
begin
  result:=false;

  aNode:=self;
  while aNode<>nil do
  begin
    if aNode is TnxSqlStatementBlock then
      if TnxSqlStatementBlock(aNode).IsPsmBlock then
      begin
        result:=true;
        exit;
      end;
    aNode:=aNode.Parent;
  end;
end;
*)

procedure TnxSqlNode.Indent;
begin
  if Assigned(FParent) then
    FParent.Indent;
end;

function TnxSqlNode.IsContextRoot: Boolean;
begin
  Result := False;
end;

function TnxSqlNode.IsParentTo(aChildNode: TnxSqlNode): Boolean;
begin
  while true do begin
    aChildNode := aChildNode.Parent;
    if aChildNode = nil then begin
      Result := False;
      exit;
    end;
    if aChildNode = Self then begin
      Result := True;
      exit;
    end;
  end;
end;

procedure TnxSqlNode.LogNormal(const s: string);
begin
  if Assigned(FParent) then
    FParent.LogNormal(s);
end;

procedure TnxSqlNode.LogVerbose(const s: string);
begin
  if Assigned(FParent) then
    FParent.LogVerbose(s);
end;

{ TnxSqlStatementBlock }

procedure TnxSqlStatementBlock.AddStatement(Statement: TnxSqlRootNode);
begin
  if Statement <> nil then begin
    Assert(Statement is TnxSqlNode);
    FStatementList.Add(Statement);
  end;
end;

procedure TnxSqlStatementBlock.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlStatementBlock then
    with TnxSqlStatementBlock(Source) do begin
      Self.Clear;
      for i := 0 to FStatementList.Count - 1 do
        Self.FStatementList.Add(TnxSqlNode(FStatementList[i]).Clone(Self));
  end else
    ENotCompatible(Source);
end;

procedure TnxSqlStatementBlock.Bind(Prebinding: Boolean; Context: TnxSqlContext);
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    TnxSqlRootNode(FStatementList[i]).Bind(Prebinding, Context);
end;

procedure TnxSqlStatementBlock.Clear;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    TObject(FStatementList[i]).Free;
  FStatementList.Clear;
end;

function TnxSqlStatementBlock.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlStatementBlock.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlStatementBlock.Create(AParent: TnxSqlNode);
begin
  inherited;
  FStatementList := TList.Create;
end;

destructor TnxSqlStatementBlock.Destroy;
begin
  Clear;
  FStatementList.Free;
  inherited;
end;

function TnxSqlStatementBlock.Equals(ANode: TnxSqlNode): Boolean;
var
  i: Integer;
begin
  Result := False;
  if ANode is TnxSqlStatementBlock then
    with TnxSqlStatementBlock(ANode) do
      if FStatementList.Count = Self.FStatementList.Count then begin
        for i := 0 to FStatementList.Count - 1 do
          if not TnxSqlRootNode(FStatementList[i]).Equals(
            TnxSqlRootNode(Self.FStatementList[i])) then
              exit;
      end;
end;

function TnxSqlStatementBlock.Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult;
var
  HadTransOnEntry, StartedTransaction: Boolean;
  n : TnxSQLRootNode;
  //aParent: TnxSqlNode;
  Scope: TnxSqlExecScope;
begin
  snBeginUse;
  try
    Assert(Context <> nil);
    Result := DBIERR_NONE;

    if Context.FExecScopesTail = nil then begin
      Scope := TnxSqlExecScope.Create(estMainBlock);
      Context.PushExecScope(Scope);
      StartedTransaction := False;
      try
        try
          if Atomic then begin
            if Database.ExplicitTransInProgress then
              raise EnxInternalSQLException.CreateRes(@rsErrorOnATOMICRequ);
            Result := Database.StartTransaction(False, True);
            if Result = DBIERR_NONE then begin
              Database.ExplicitTransInProgress := True;
              StartedTransaction := True;
            end;
          end;
          Context.SetEndPC(FStatementList.Count);
          Context.RowsAffected := 0;
          Context.RowsRead := 0;
          while Context.Next do begin
            nxCheckRemainingTime;
            RecordsRead := 0;
            RowsAffected := 0;
            Result := TnxSqlRootNode(FStatementList.List[Context.PC]).Execute(Context, aLiveResult, aCursor, RecordsRead, RowsAffected);
            Context.RowsAffected := RowsAffected;
            Context.RowsRead := RecordsRead;
            if Result <> DBIERR_NONE then
              break;
          end;
          if Atomic then begin
            if StartedTransaction then
              Database.Commit;
            Database.ExplicitTransInProgress := False;
          end;
        except
          if Atomic then begin
            if StartedTransaction then
              Database.AbortTransaction;
            Database.ExplicitTransInProgress := False;
          end;
          raise;
        end;
      finally
        Context.PopExecScope;
      end;
    end else begin
      HadTransOnEntry := (FDatabase <> nil) and FDatabase.ExplicitTransInProgress;
      StartedTransaction := False;
      try
        if Atomic then begin
          if Database.ExplicitTransInProgress then
            raise EnxInternalSQLException.CreateRes(@rsErrorOnATOMICRequ);
          Result := Database.StartTransaction(False, True);
          if Result = DBIERR_NONE then begin
            Database.ExplicitTransInProgress := True;
            StartedTransaction := True;
          end;
        end;

        Scope := TnxSqlExecScope.Create(estBlock);
        Context.PushExecScope(Scope);
        try
          Context.SetEndPC(FStatementList.Count);
          Context.RowsAffected := 0;
          Context.RowsRead := 0;
          while Context.Next do begin
            nxCheckRemainingTime;
            RecordsRead := 0;
            RowsAffected := 0;
            Context.UpdateTime;

            n:=TnxSqlRootNode(FStatementList.List[Context.PC]);
            Result := n.Execute(Context, aLiveResult, aCursor, RecordsRead, RowsAffected);
            if Result <> DBIERR_NONE then
              break;
            Context.RowsAffected := RowsAffected;
            Context.RowsRead := RecordsRead;

            if Result <> DBIERR_NONE then
              break;
          end;
        finally
          Context.PopExecScope;
        end;
        if Atomic then begin
          if StartedTransaction then
            Database.Commit;
          Database.ExplicitTransInProgress := False;
        end;
      except
        if Atomic then begin
          if StartedTransaction then
            Database.AbortTransaction;
          Database.ExplicitTransInProgress := False;
        end;
        raise;
      end;
      if (FDatabase <> nil) and FDatabase.ExplicitTransInProgress and not HadTransOnEntry then
        raise EnxInternalSQLException.CreateRes(@rsATransactionStarte);
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlStatementBlock.IsPsmBlock: Boolean;
begin
  result:=false;
end;

procedure TnxSqlStatementBlock.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i: Integer;
begin
  for i := 0 to Stream.ReadInt - 1 do
    AddStatement(Stream.ReadNode(Self) as TnxSqlRootNode);
  Atomic := Stream.ReadBool;
end;

function TnxSqlStatementBlock.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    if TnxSqlRootNode(FStatementList[i]).RefersTo(aTableName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlStatementBlock.RefersTo2(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    if TnxSqlRootNode(FStatementList[i]).RefersTo2(aTableName, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

procedure TnxSqlStatementBlock.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteInt(FStatementList.Count);
  for i := 0 to FStatementList.Count - 1 do
    Stream.WriteNode(TnxSqlRootNode(FStatementList[i]));
  Stream.WriteBool(Atomic);
end;


procedure TnxSqlStatementBlock.SetDatabase(const Value: TnxSqlDatabaseProxy);
var
  i: Integer;
begin
  FDatabase := Value;
  for i := 0 to FStatementList.Count - 1 do begin
    TnxSqlRootNode(FStatementList.List[i]).Database := Value;
    //TnxSqlRootNode(FStatementList[i]).Traverse(UpdateDatabase, nil, True);
  end;
end;

function TnxSqlStatementBlock.Simplify(Context: TnxSqlContext): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FStatementList.Count - 1 do
    if TnxSqlRootNode(FStatementList[i]).Simplify(Context) then begin
      Result := True;
      exit;
    end;
end;

function TnxSqlStatementBlock.ToString: WideString;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FStatementList.Count - 1 do
    Result := Result + TnxSqlRootNode(FStatementList[i]).ToString + '; ';
end;

procedure TnxSqlStatementBlock.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
var
  i: Integer;
begin
  Callback(Self, UserData);
  for i := 0 to FStatementList.Count - 1 do
    TnxSqlRootNode(FStatementList[i]).Traverse(Callback, UserData, IncludeNested);
end;

procedure TnxSqlStatementBlock.Unbind;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    TnxSqlRootNode(FStatementList[i]).Unbind;
end;

(*
procedure TnxSqlStatementBlock.UpdateDatabase(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlRootNode then
    TnxSqlRootNode(Node).FDatabase := FDatabase
  * experimental
  else
  if Node is TnxSqlTableRef then
    if TnxSqlTableRef(Node).BindView then
      AnyViewsBound := True;
  *
end;
*)

{ TnxSqlBlock }

procedure TnxSqlBlock.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlBlock then begin
    Clear;
    for i := 0 to TnxSqlBlock(Source).FStatementList.Count - 1 do
      AddStatement(TnxSqlRootNode(TnxSqlBlock(Source).FStatementList[i]).Clone(Self) as
        TnxSqlRootNode);
  end else
    ENotCompatible(Source);
end;

procedure TnxSqlBlock.Bind(Prebinding: Boolean; Context: TnxSqlContext);
begin
  inherited;

end;

procedure TnxSqlBlock.BindDatabase(aDatabase : TnxSqlDatabaseProxy; DefaultStringLiteralLocale: TnxLocaleDescriptor);
var
  i: Integer;
  Context: TnxSqlContext;
begin
  Context := TnxSqlContext.Create(aDatabase, Now, DefaultStringLiteralLocale);
  try
    AnyViewsBound := False;
    Database := aDatabase;
    for i := 0 to FStatementList.Count - 1 do
      TnxSqlRootNode(FStatementList[i]).Bind(True, Context);
    if AnyViewsBound then
      while Simplify(Context) do
        ;
  finally
    Context.Free;
  end;
end;

procedure TnxSqlBlock.Clear;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    TObject(FStatementList[i]).Free;
  FStatementList.Clear;
end;

function TnxSqlBlock.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlBlock.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlBlock.Create(AParent: TnxSqlNode);
begin
  inherited Create(nil);
  (*
  FLogging := True; {test}
  FLogList := TnxFastStringListIC.Create {test}
  *)
end;

destructor TnxSqlBlock.Destroy;
var
  i: Integer;
begin
  if Switches <> nil then begin
    for i := 0 to Switches.Count - 1 do
      TObject(Switches[i]).Free;
    FreeAndNil(Switches);
  end;
  ParmList:=nil;
  Clear;
  inherited;
  nxFreeAndNil(FFeatureSwitches);
  nxFreeAndNil(FLogList);
end;

function TnxSqlBlock.Equals(ANode: TnxSqlNode): Boolean;
var
  i: Integer;
begin
  Result := False;
  if ANode is TnxSqlBlock then
    with TnxSqlBlock(ANode) do begin
      if FStatementList.Count <> Self.FStatementList.Count then
        exit;
      for i := 0 to FStatementList.Count - 1 do
        if not TnxSqlNode(FStatementList[i]).Equals(Self.FStatementList[i]) then
          exit;
      Result := True;
    end;
end;

function TnxSqlBlock.EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  if FStatementList.Count <> 1 then
    raise EnxInternalSQLException.CreateRes(@rsStandaloneSQLStat);
  Result := TnxSqlRootNode(FStatementList.List[0]).EvaluateWhere(Context);
end;

function TnxSqlBlock.EvaluateFirst(Context: TnxSqlContext): variant;
begin
  if FStatementList.Count <> 1 then
    raise EnxInternalSQLException.CreateRes(@rsStandaloneSQLStat);
  Result := TnxSqlRootNode(FStatementList.List[0]).EvaluateFirst(Context);
end;

function TnxSqlBlock.FeatureEnabled(const FeatureName: string; DefaultValue: Boolean): Boolean;
const
  FalseTrue: array[Boolean] of string = ('False', 'True');
var
  i: Integer;
begin

  //LogVerbose('Checking for feature switch "' + FeatureName + '" in ' + ToString);

  if FFeatureSwitches = nil then begin
    Result := DefaultValue;
    //LogVerbose('No explicit feature switches were found. Default value of ' + FalseTrue[Result] + ' used.');
    exit;
  end;

  i := FFeatureSwitches.IndexOf(FeatureName);

  if i > -1 then begin
    Result := NativeInt(FFeatureSwitches.Objects[i]) <> 0;
    //LogVerbose('Explicit feature switches found. Requested value of ' + FalseTrue[Result] + ' used.');
    if Result <> DefaultValue then
      LogVerbose('Optional setting "' + FeatureName + '" explicitly changed to ' + FalseTrue[Result]);

  end else begin
    Result := DefaultValue;
    //LogVerbose('Explicit feature switches not found. Default value of ' + FalseTrue[Result] + ' used.');
  end;
end;

function TnxSqlBlock.WhereIsValidFilterStatement: Boolean;
begin
  if FStatementList.Count <> 1 then
    Result := False
  else
    Result := TnxSqlRootNode(FStatementList.List[0]).WhereIsValidFilterStatement;
end;

procedure TnxSqlBlock.BindWhere(aContext: TnxSqlContext);
begin
  TnxSqlRootNode(FStatementList.List[0]).BindWhere(aContext);
end;

function TnxSqlBlock.Execute(Context: TnxSqlContext; var aLiveResult: Boolean;
                     var aCursor: TnxAbstractCursor;
                     var RowsAffected,
                         aRecordsRead: integer) : TnxResult ;
var
  i, j: Integer;
  T: DWord;
  Timeout: Integer;
  TransLevel: Integer;
  TransPending: Integer;
  NeedNewTrans: Boolean;
  AutoCommitOnDDL: Boolean;
  NoProcessing: Boolean;
  Res: TnxResult;
  SwitchValue: string;
begin
  snBeginUse;
  try
    Result := DBIERR_NONE;
    RowsAffected := 0;

    ApplyCustomSwitches;
    if TimeoutStr <> nil then begin
      Timeout := TokenToInt(TimeoutStr);
      if Timeout <> -1 then
        nxSetTimeout(Timeout, True);
    end;
    FStartDate := Date;
    FStartTime := Time;
    FStartDateTime := Now;
    Context.RowsAffected := 0;
    Context.RowsRead := 0;

    AutoCommitOnDDL := False;
    if OwnerStatement <> nil then begin
      Res := (OwnerStatement as TnxSqlStatement).esoOptionGetEffective('AUTOCOMMITONDDL', SwitchValue);
      if (Res = DBIERR_NONE) and (length(SwitchValue) > 0) and (SwitchValue[1] <> '0') then
        AutoCommitOnDDL := True;
    end;

    NoProcessing := False;
    if OwnerStatement <> nil then begin
      Res := (OwnerStatement as TnxSqlStatement).esoOptionGetEffective('NO_PROCESSING', SwitchValue);
      if (Res = DBIERR_NONE) and (length(SwitchValue) = 1) and (SwitchValue[1] = '1') then
        NoProcessing := True;
    end;

    if NoProcessing then
      Inc(nxsqlNoProcessingCounter);
    try
      if not AutoCommitOnDDL then begin
        if Database.ServerDatabase.TransactionGetLevel(TransLevel) = DBIERR_NOACTIVETRAN then
          TransPending := 0
        else
          TransPending := 1;
        for i := 0 to FStatementList.Count - 1 do begin
          if TnxSqlRootNode(FStatementList.List[i]) is TnxSqlBeginTransaction then
            inc(TransPending)
          else
          if (TnxSqlRootNode(FStatementList.List[i]) is TnxSqlCommitTransaction)
          or  (TnxSqlRootNode(FStatementList.List[i]) is TnxSqlRollbackTransaction) then
            dec(TransPending)
          else
            if (TransPending > 0)
            and TnxSqlRootNode(FStatementList.List[i]).IsDDLStatement then
              raise EnxInternalSQLException.CreateRes(@rsDDLStatementsCanno);
        end;
      end;
      try
        if AutoCommitOnDDL then begin
          if Database.ServerDatabase.TransactionGetLevel(TransLevel) = DBIERR_NOACTIVETRAN then
            TransPending := 0
          else
            TransPending := 1;
        end else
          TransPending := 0;

        for i := 0 to FStatementList.Count - 1 do begin

          nxCheckRemainingTime;

          NeedNewTrans := False;

          if AutoCommitOnDDL then begin
            if TnxSqlRootNode(FStatementList.List[i]) is TnxSqlBeginTransaction then
              inc(TransPending)
            else
            if (TnxSqlRootNode(FStatementList.List[i]) is TnxSqlCommitTransaction)
            or  (TnxSqlRootNode(FStatementList.List[i]) is TnxSqlRollbackTransaction) then
              dec(TransPending)
            else
              if (TransPending > 0)
              and TnxSqlRootNode(FStatementList.List[i]).IsDDLStatement then begin
                Database.Commit;
                NeedNewTrans := True;
              end;
          end;

          if TnxSqlRootNode(FStatementList.List[i]).NeedsUnbinding then
            for j := i - 1 downto 0 do
              TnxSqlRootNode(FStatementList.List[j]).Unbind;
          aRecordsRead := 0;
          RowsAffected := 0;
          if Logging then begin
            LogNormal('==============================================================');
            LogNormal(format('Executing %s;', [TnxSqlRootNode(FStatementList.List[i]).ToString]));
            T := GetTickCount;
          end else
            T := 0;
          Context.UpdateTime;
          Result := TnxSqlRootNode(FStatementList.List[i]).Execute(Context, aLiveResult, aCursor, aRecordsRead, RowsAffected);
          Context.RowsAffected := RowsAffected;
          Context.RowsRead := aRecordsRead;
          if Logging then begin
            {$IFOPT Q+}
              {$DEFINE LocalOverflowCheckOFF}
              {$OVERFLOWCHECKS OFF}
            {$ENDIF}
            T := GetTickCount - T;
            {$IFDEF LocalOverflowCheckOFF}
              {$OVERFLOWCHECKS ON}
              {$UNDEF LocalOverflowCheckOFF}
            {$ENDIF}
            LogNormal(format('Rows read:%d Affected:%d', [aRecordsRead, RowsAffected]));
            LogNormal(format('Elapsed time (ms):%d', [T]));
          end;
          if Result <> DBIERR_NONE then
            break;

          if NeedNewTrans then
            Database.StartTransaction(False, False);

        end;
      except
        //Database.ClearTempTables;
        if Database.ExplicitTransInProgress then begin
          Database.AbortTransaction;
          Database.ExplicitTransInProgress := False;
        end;
        raise;
      end;
    finally
      if NoProcessing then try
        for i := 0 to FStatementList.Count - 1 do
          TnxSqlRootNode(FStatementList.List[i]).Unbind;
      finally
        Dec(nxsqlNoProcessingCounter);
      end;
    end;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlBlock.Indent;
begin
  inc(FIndentation);
end;

const
  IdentStrings: array[0..16] of string = (
    '',
    '  ',
    '    ',
    '      ',
    '        ',
    '          ',
    '            ',
    '              ',
    '                ',
    '                  ',
    '                    ',
    '                      ',
    '                        ',
    '                          ',
    '                            ',
    '                              ',
    '                                '
  );

function TnxSqlBlock.IndentStr: string;
begin
  if FIndentation <= 16 then
    Result := IdentStrings[FIndentation]
  else
    Result := StringOfChar(' ', FIndentation * 2);
end;

procedure TnxSqlBlock.LogNormal(const S: string);
begin
//writeln(IndentStr + S);
//  OutputDebugString(PAnsiCHar(IndentStr + S));
  if not Logging then
    exit;
  if S = '' then
    LogList.Add({IndentStr + }' ')
  else
    LogList.Add(IndentStr + S);
end;

procedure TnxSqlBlock.LogVerbose(const S: string);
begin
  if not VerboseLogging then
    exit;
  LogNormal(S);
end;

procedure TnxSqlBlock.Outdent;
begin
  if FIndentation > 0 then
    dec(FIndentation);
end;

procedure TnxSqlBlock.SetFeatureSwitches(Value: TStringList);
begin
  if value <> nil then begin
    if FFeatureSwitches <> nil then
      nxFreeAndNil(FFeatureSwitches);
    FFeatureSwitches := TStringList.Create;
    FFeatureSwitches.Assign(Value);
  end;
end;

procedure TnxSqlBlock.SetLogging(const Value: Boolean);
begin
  if Value <> FLogging then begin
    if Value then begin
      FLogList := TnxSqlLogList.Create;
      FLogList.Add(Format('Engine version: %5.4f %s', [nxVersionNumber / 10000.0, nxSpecialString]));
    end else begin
      LogList.Free;
      FLogList := nil;
    end;
    FLogging := Value;
  end;
end;

procedure TnxSqlBlock.SetVerboseLogging(const Value: Boolean);
begin
  if Value <> FVerboseLogging then begin
    if Value then begin
      SetLogging(True);
      LogNormal('Verbose=ON');
    end;
    FVerboseLogging := Value;
  end;
end;

procedure TnxSqlBlock.SetParameter(Index: Integer; const Value: Variant; aParamType: TnxParamType;
  aLocale: TnxLocaleDescriptor; aFieldType: TnxFieldType);
begin
  if ParmCount = 0 then
    raise EnxInternalSQLException.CreateRes(@rsErrorAttemptToSe);
  if ParmList = nil then
    ParmList := CreateTypedVariantList(ParmCount);
  ParmList.SetValue(Index, Value, aLocale, aFieldType, 0);
end;

function TnxSqlBlock.GetParameter(Index: Integer; aParamType: TnxParamType): Variant;
var
  Locale: TnxLocaleDescriptor;
begin
  if (ParmCount = 0) or (ParmList = nil) then
    raise EnxInternalSQLException.CreateRes(@rsErrorAttemptToGe);
  Result := ParmList.GetValue(Index, Locale);
end;

function TnxSqlBlock.Simplify(Context: TnxSqlContext): Boolean;
var
  i, j: Integer;
  Change: Boolean;
begin
  Result := False;
  LogVerbose('');
  j:=0;
  for i := 0 to FStatementList.Count - 1 do
    if (TObject(FStatementList.List[i]) as TnxSqlRootNode).AllowSimplification then begin
      LogVerbose('');
      Change := False;
      if Logging then
        LogVerbose('Simplifying: ' + TnxSqlRootNode(FStatementList.List[i]).ToString + ';');
      while TnxSqlRootNode(FStatementList.List[i]).Simplify(Context) do begin
        Change := True;
        inc(j);
        if Logging then begin
          LogVerbose('Simplification Loop '+inttostr(j));
//writeln('Simplification Loop '+inttostr(j));
          LogVerbose('New form:' + TnxSqlRootNode(FStatementList.List[i]).ToString + ';');
          LogVerbose('');
          {LogList.SaveToFile('c:\log.txt');}
        end;
      end;
      if Change then
        Result := True;
      if not Change then begin
        LogVerbose('  no change');
        LogVerbose('');
      end;
    end;
  LogVerbose('');
end;

function TnxSqlBlock.ToString: WideString;
var
  i: Integer;
begin
  for i := 0 to FStatementList.Count - 1 do
    Result := Result + TnxSqlRootNode(FStatementList[i]).ToString + ';';
end;

procedure TnxSqlBlock.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
var
  i: Integer;
begin
  Callback(Self, UserData);
  for i := 0 to FStatementList.Count - 1 do
    TnxSqlRootNode(FStatementList[i]).Traverse(Callback, UserData, IncludeNested);
end;

procedure TnxSqlBlock.Unbind;
begin
  inherited;

end;

function TnxSqlBlock.GetLastStatement: TnxSqlRootNode;
begin
  if FStatementList.Count > 0 then
    Result := TnxSqlRootNode(FStatementList[FStatementList.Count - 1])
  else
    Result := nil;
end;

function TnxSqlBlock.GetLogging: Boolean;
begin
  Result := FLogging;
end;

procedure TnxSqlBlock.AddSwitch(aGroup, aItem, aValue: PTokenRecord);
begin
  if Switches = nil then
    Switches := TList.Create;
  Switches.Add(TnxSqlCustomSwitch.Create(aGroup, aItem, aValue));
end;

procedure TnxSqlBlock.ApplyCustomSwitches;
var
  i: Integer;
begin
  if Switches <> nil then
    for i := 0 to Switches.Count - 1 do
      with TnxSqlCustomSwitch(Switches[i]) do
        if SwitchValue = nil then
          ClearCustomSwitch(TokenToStr(SwitchGroup), TokenToStr(SwitchName))
        else
          SetCustomSwitchValue(TokenToStr(SwitchGroup), TokenToStr(SwitchName), TokenToStrStripQ(SwitchValue));
end;

procedure TnxSqlBlock.ClearCustomSwitch(const Group, Item: string);
var
  Owner: TnxExtendableServerObject;
begin
  Owner := GetSwitchOwner(Group);
  if not Assigned(Owner) then
    raise EnxSqlException.nxCreate(DBIERR_OBJNOTFOUND, '"%s" is not a valid option owner', [Group]);
  Owner.esoOptionClear(Item);
end;

procedure TnxSqlBlock.SetCustomSwitchValue(const Group, Item, Value: string);
var
  Owner: TnxExtendableServerObject;
begin
  Owner := GetSwitchOwner(Group);
  if not Assigned(Owner) then
    raise EnxSqlException.nxCreate(DBIERR_OBJNOTFOUND, '"%s" is not a valid option owner', [Group]);
  Owner.esoOptionSet(Item, Value);
end;

function TnxSqlBlock.GetSwitchOwner(const Group: string): TnxExtendableServerObject;
begin
  if SameText(Group,'statement') then
    Result := OwnerStatement
  else if SameText(Group,'database') then
    Result := OwnerStatement.Database
  else if SameText(Group,'transcontext') then
    Result := OwnerStatement.Database.TransContext
  else if SameText(Group,'session') then
    Result := OwnerStatement.Database.Session
  else
    Result := nil;
end;

function TnxSqlBlock.GetVerboseLogging: Boolean;
begin
  Result := FVerboseLogging;
end;

{ TnxSqlFieldRef }

procedure TnxSqlFieldRef.AddArg(Arg: TnxSqlNode);
begin
  if FArgs = nil then
    FArgs := TList.Create;
  FArgs.Add(Arg);
end;

procedure TnxSqlFieldRef.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlFieldRef then begin
    Clear;
    DatabaseNameStr := TnxSqlFieldRef(Source).DatabaseNameStr;
    TableNameStr :=  TnxSqlFieldRef(Source).TableNameStr;
    FieldNameStr := TnxSqlFieldRef(Source).FieldNameStr;
    FFieldName := TnxSqlFieldRef(Source).FFieldName;
    fQuoted := TnxSqlFieldRef(Source).Quoted;
    for i := 0 to TnxSqlFieldRef(Source).ArgCount - 1 do
      AddArg(TnxSqlFieldRef(Source).Arg[i].Clone(Self));
    //IsFunctioncall := TnxSqlFieldRef(Source).IsFunctioncall;
  end else
    ENotCompatible(Source);
end;

function TnxSqlFieldRef.IsPartOfSelectionList: Boolean;
var
  Look: TnxSqlNode;
begin
  Look := Parent;
  while Look <> nil do begin
    if Look is TnxSqlSelectionList then begin
      Result := True;
      exit;
    end;
    if Look is TnxSqlRootNode then
      break;
    Look := Look.Parent;
  end;
  Result := False;
end;

procedure TnxSqlFieldRef.CheckCompat(TargetType, ValueType: TnxFieldType; const Loc, Expr: string);
var
  OK: Boolean;
begin
  if ValueType <> TargetType then begin
    OK := False;
    case TargetType of
    nxtChar, nxtWideChar, nxtBlobMemo, nxtShortString, nxtNullString, nxtWideString, nxtBlobWideMemo :
      OK := ValueType in [nxtChar, nxtWideChar, nxtBlobMemo, nxtShortString, nxtNullString, nxtWideString, nxtBlobWideMemo];
    nxtByte:
      OK := True;
    nxtWord16:
      OK := True;
    nxtWord32, nxtAutoInc, nxtRecRev:
      OK := True;
    nxtInt8 :
      OK := True;
    nxtInt16 :
      OK := True;
    nxtInt32 :
      OK := True;
    nxtSingle, nxtDouble, nxtExtended, nxtCurrency, nxtBCD, nxtFmtBCD:
      OK := ValueType in [nxtInt8, nxtInt16, nxtInt32, nxtInt64, nxtSingle, nxtDouble, nxtExtended, nxtCurrency, nxtBCD, nxtFmtBCD, nxtRefNr];
    nxtBlob, nxtByteArray, nxtBlobGraphic :
      OK := ValueType in [nxtBlob, nxtByteArray, nxtBlobGraphic];
    nxtInt64 :
      OK := ValueType in [nxtInt8, nxtInt16, nxtInt32, nxtInt64, nxtByte, nxtWord16, nxtWord32, nxtRefNr];
    end;
  end else
    OK := True;
  if not OK then
    raise EnxInternalSQLException.CreateResFmt(@rsTypeMismatchBetwee, [Loc, Expr]);
end;

function TnxSQLFieldRef.IsUnqualifiedFunction: Boolean;
var
  DB: TnxSqlDatabaseProxy;
  aFunction: TnxSqlAbstractFunc;
  lFieldNameStr : string;
  aStorage: TnxBaseSqlFunctionResolver;
begin
  result:=false;
  if Quoted then
    exit;
  if AddedByWildcard then
    exit;
  if TableNameStr<>'' then
    exit;
  DB:=Owner.Database.GetDatabase(DatabaseNameStr);
  lFieldNameStr := FieldNameStr;
  if DB<>nil then
    afunction := TnxDatabaseResolverHub(DB.PsmDictionary.FunctionResolver).LookupFunction(lFieldNameStr, nil, aStorage)
  else
    afunction := sServerFunctionsHub.LookupFunction(lFieldNameStr, nil, aStorage);

  result:=afunction<>nil;
  if aFunction is TnxSqlCREATEFUNC then
    if not TnxSqlCREATEFUNC(aFunction).Intrinsic then
      nxFreeAndNil(aFunction);
end;

procedure TnxSqlFieldRef.InternalCheckType;
var
  VP: PVariant;
  FLocalDef: TnxObject;
  DB: TnxSqlDatabaseProxy;
  aStorage: TnxBaseSqlFunctionResolver;
  //IsSysFunction,
  WasLocalVar: Boolean;
  lArg: TnxSqlNode;
  lFieldNameStr: string;
  lLocationStr: string;
  F: TnxSqlFieldProxy;
  i: Integer;
begin
  if TypeKnown then exit;

  lFieldNameStr := FieldNameStr;
  lLocationStr := LocationStr;

//  IsSysFunction := False;
  FIsOuterReference := False;
  ExternalIndex := -1;

  DB:=Owner.Database.GetDatabase(DatabaseNameStr);
  if (TableNameStr = '') then begin
    if Quoted then {quoted thus is a column, so don't try to bind to a function}
      FFunction := nil
    else
    if AddedByWildcard then {must be column, then, so don't try to bind to a function}
      FFunction := nil
    else if DB<>nil then
      FFunction := TnxDatabaseResolverHub(DB.PsmDictionary.FunctionResolver).LookupFunction(lFieldNameStr, Self, aStorage)
    else
      FFunction := sServerFunctionsHub.LookupFunction(lFieldNameStr, Self, aStorage);

    if FFunction <> nil then begin
      if not (FFunction is TnxSqlAbstractFunc) then
        raise EnxInternalSQLException.CreateRes(@rsStoredProceduresCa);

      if (FFunction is TnxSqlCREATEFUNC)
      and IsPartOfSelectionList then begin
        if TnxSqlCREATEFUNC(FFunction).Characteristics.SqlAccess = saModifiesData then
          raise EnxInternalSQLException.CreateResFmt(@rsFunctionsThatModif,
            [lFieldNameStr + lLocationStr]);
        if TnxSqlCREATEFUNC(FFunction).ReturnsTable
        or (TnxSqlCREATEFUNC(FFunction).Select <> nil) then
          raise EnxInternalSQLException.CreateResFmt(@rsFunctionsThatRetur,
            [lFieldNameStr + lLocationStr]);
      end;
      FLocaleDesc := TnxSqlAbstractFunc(FFunction).GetLocaleDesc(Context);
      if TnxSqlAbstractFunc(FFunction).ArgCount <> ArgCount then
        raise EnxInternalSQLException.CreateResFmt(@rsIncorrectNumberOf,
          [lFieldNameStr + lLocationStr]);

      if (FFunction is TnxSqlCREATEFUNC) then begin
        for i := 0 to ArgCount - 1 do
          CheckCompat(TnxSqlCREATEFUNC(FFunction).Parm[i].DataType, Arg[i].GetType(Context), LocationStr, Arg[i].ToString);
      end;


      case TnxSqlAbstractFunc(FFunction).ReturnTypeType of
      rttExplicit :
        begin
          FType := TnxSqlAbstractFunc(FFunction).ReturnType2;
          FSize := TnxSqlAbstractFunc(FFunction).ReturnSize;
          FDecimals := TnxSqlAbstractFunc(FFunction).ReturnDecimals;
        end;
      rttAsArg1x :
        begin
          lArg := Arg[0];
          FType := TnxSqlSimpleExpression(lArg).GetType(Context);
          FSize := TnxSqlSimpleExpression(lArg).GetSize(Context);
          FDecimals := TnxSqlSimpleExpression(lArg).GetDecimals(Context);
        end;
      rttAsArg2x :
        begin
          Assert(ArgCount >= 2);
          lArg := Arg[1];
          FType := TnxSqlSimpleExpression(lArg).GetType(Context);
          FSize := TnxSqlSimpleExpression(lArg).GetSize(Context);
          FDecimals := TnxSqlSimpleExpression(lArg).GetDecimals(Context);
        end;
      else
        raise EnxInternalSQLException.CreateRes(@rsNotImpl);
      end;
      TypeKnown := True;
      ffunctionType:=integer(aStorage.FunctionType);
      if aStorage.FunctionType = nxsft_Internal then begin
        //IsSysFunction := (FFieldName = nil) or (FFieldName.BufferStart^ <> '"');
        //if not IsSysFunction then begin
        //  ReleaseFunction;
        //end;
      end else
        exit;
    end;
  end;
  {if (ArgCount > 0) and not IsSysFunction then
    raise EnxInternalSQLException.Create('Unknown function:' + lFieldNameStr + lLocationStr);}
  if (Context <> nil) and (trim(TableNameStr) = '') then begin
    VP := Context.LookUpLocal(lFieldNameStr, FLocalDef);
    if VP <> nil then begin
      FType := TnxSqlParmDef(FLocalDef).DataType;
      FSize := TnxSqlParmDef(FLocalDef).Size;
      FDecimals := TnxSqlParmDef(FLocalDef).Decimals;
      TypeKnown := True;
      IsLocalVar := True;
//      IsSysFunction := False;
      {exit;}
    end;
  end;

  {if (ArgCount > 0) and not IsSysFunction then
    raise EnxInternalSQLException.Create('Unexpected argument:' + Arg[0].ToString);}

  TypeKnown := True;
  try
    WasLocalVar := IsLocalVar;
    IsLocalVar := False;
    try
      if GetField(Context) = nil then begin
        if assigned(Context) and assigned(Context.ExternalColumnResolver) then begin
          ExternalIndex := Context.ExternalColumnResolver(lFieldNameStr, FType,
            FSize{ExternalSize}, FDecimals{ExternalDecimals}, FLocaleDesc);
          if ExternalIndex <> -1 then
            exit;
        end;
        //if IsSysFunction then
        if assigned(FFunction) then
          exit;
        if not WasLocalVar then begin
          if RaiseException then begin
            //GetField(Context); // debug
            lLocationStr:=LocationStr;
            EUnRes(TableNameStr, lFieldNameStr, lLocationStr);
          end;
          exit;
        end
        else begin
          IsLocalVar := True;
          exit;
        end;
      end;
    except
      if WasLocalVar then begin
        IsLocalVar := True;
        exit;
      end else
        if RaiseException then
          raise;
    end;
    ReleaseFunction;
    F := GetField(Context);
    FType := F.GetType;
    FSize := F.GetSize;
    FDecimals := F.GetDecimals;
  except
    TypeKnown := False;
    if RaiseException then
      raise;
  end;
end;

function TnxSqlFieldRef.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlFieldRef.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlFieldRef.ReleaseFunction;
//var
//  IsSysFunction: boolean;
begin
  if fFunctionType = integer(nxsft_Internal) then begin
//    IsSysFunction := (FieldNameStr = '') {(FFieldName = nil)} or (FFieldName <> nil) and (FFieldName.BufferStart^ <> '"');
//    if not IsSysFunction then
//      FreeAndnil(FFunction);
    if FFunction is TnxSqlCREATEFUNC then
      if not TnxSqlCREATEFUNC(FFunction).Intrinsic then
        FreeAndnil(FFunction);
  end;
  fFuncArgs:=nil; // release the arguments list too, cause if we
      // rebind it's potentially different
  FFunction:=nil;
end;

constructor TnxSqlFieldRef.Create(AOwner: TnxSqlNode);
begin
  inherited;
  FFunction:=nil;
  ExternalIndex := -1;
  fQuoted:=false;
end;

function TnxSqlFieldRef.DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
var
  i: Integer;
  F: TnxSqlFieldProxy;
begin
  if FFunction <> nil then begin
    for i := 0 to ArgCount - 1 do
      //if TnxSqlCondExp(Arg[i]).DependsOn(Context, Table) then begin
      if TnxSqlSimpleExpression(Arg[i]).DependsOn(Context, Table) then begin
        Result := True;
        exit;
      end;
    Result := False;
  end else begin
    F := GetField(Context);
    if (F <> nil) then
      {if F.IsTarget then begin
        Assert(OwnerSelect <> nil);
        if GetField(Context).SrcIndex > -1 then
          Result := TnxSqlSimpleExpression(TnxsqlSELECT(OwnerSelect).RowBuilder.SourceFieldExpression[
            GetField(Context).SrcIndex]).DependsOn(Context, Table)
        else
          Result := GetField(Context).SrcField.OwnerTable = Table;
      end else}
        Result := F{GetField(Context)}.OwnerTable = Table
    else
      Result := False;
  end;
end;

destructor TnxSqlFieldRef.Destroy;
begin
  Clear;
//  ReleaseFunction;
  inherited;
end;

function TnxSqlFieldRef.Equals(ANode: TnxSqlNode): Boolean;
var
  i: Integer;
begin
  if ANode is TnxSqlFieldRef then begin
    with TnxSqlFieldRef(ANode) do
      Result := AnsiSameText(TableNameStr, Self.TableNameStr)
      //and (IsFunctioncall = Self.IsFunctioncall)
      and AnsiSameText(DatabaseNameStr, Self.DatabaseNameStr)
      and
      ( AnsiSameText(FieldNameStr, Self.FieldNameStr)
        or (WasWildcard and (Self.FieldNameStr = '')
        or (((FieldNameStr = '') and Self.WasWildcard))))
      and
        (ArgCount = Self.ArgCount);
    if Result then
      for i := 0 to ArgCount - 1 do
        if not Arg[i].Equals(TnxSqlFieldRef(ANode).Arg[i]) then begin
          Result := False;
          exit;
        end;
  end else
    Result := False;
end;

function TnxSqlFieldRef.GetArg(Index: Integer): TnxSqlNode;
begin
  Assert(FArgs <> nil);
  Result := TnxSqlNode(FArgs[Index]);
end;

function TnxSqlFieldRef.GetArgCount: Integer;
begin
  if FArgs <> nil then
    Result := FArgs.Count
  else
    Result := 0;
end;

function TnxSqlFieldRef.GetDecimals(Context: TnxSqlContext): Integer;
{var
  LocalDef: TnxObject;
  PV: PVariant;}
begin
  if not TypeKnown then
    CheckType(Context);
  Result := FDecimals;
  {if Context <> nil then begin
    PV := Context.LookUpLocal(FieldNameStr, LocalDef);
    if PV <> nil then begin
      Result := TnxSqlParmDef(LocalDef).Decimals;
      exit;
    end;
  end;
  if FFunction <> nil then
    Result := TnxSqlAbstractFunc(FFunction).ReturnDecimals
  else
    if ExternalIndex = -1 then
      Result := GetField(Context).GetDecimals
    else
      Result := ExternalDecimals;}
end;

function TnxSqlFieldRef.GetField(Context: TnxSqlContext; RaiseExceptions: Boolean): TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context, RaiseExceptions);
  if IsLocalVar then begin
    Result := nil;
    exit;
  end;
  if FFunction <> nil then
    Result := nil
  else begin
    if Assigned(FFieldLifetimeMonitor) then begin
      if not FFieldLifetimeMonitor.IsAlive then begin
        FField := nil;
        FFieldLifetimeMonitor := nil;
      end;
    end;
    if FField = nil then begin
      if Assigned(ContextParent) then
        FField := ContextParent.BindColumn(Context, IsOwnedByAggregate, DatabaseNameStr, TableNameStr,
          StripQuotes(FieldNameStr), FieldNameLoc, self, bsNormal, FIsOuterReference, False);
      if Assigned(FField) then begin
        if Assigned(FArgs) and (FArgs.Count > 0) then begin
          if RaiseExceptions then
            raise EnxSqlException.CreateResFmt(@rsArgumentsNotAllowedForFieldRef, [Self.ToString]);
          FField := nil;
        end else
          FFieldLifetimeMonitor := FField.OwnerTable.GetLifetimeMonitor;
      end;
    end;
    Result := FField;
  end;
end;

function TnxSqlFieldRef.GetSize(Context: TnxSqlContext): Integer;
{var
  LocalDef: TnxObject;
  PV: PVariant;}
begin
  if not TypeKnown then
    CheckType(Context);
  {if Context <> nil then begin
    PV := Context.LookUpLocal(FieldNameStr, LocalDef);
    if PV <> nil then begin
      Result := TnxSqlParmDef(LocalDef).Size;
      exit;
    end;
  end;}
  if FFunction <> nil then
  begin
    TnxSqlAbstractFunc(FFunction).CalcReturnSize(Args, Context);
    Result := TnxSqlAbstractFunc(FFunction).ReturnSize;
  end
  else
    Result := FSize;
end;

function ContainsInvalidIdentChars(const S: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if length(S) < 1 then
    exit;
  if not (Ord(S[1]) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('_'), Ord('@')]) then begin
    Result := True;
    exit;
  end;
  for i := 2 to length(S) do
    if not (Ord(S[i]) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('_'), Ord('0')..Ord('9'), Ord('@')]) then begin
      Result := True;
      exit;
    end;
end;

function TnxSqlFieldRef.GetTitle(const Qualified, Quoted : Boolean): string;
var
  TNS, QFN: string;
begin
  TNS := TableNameStr;
  if Quoted and (ContainsInvalidIdentChars(TNS) or IsReservedName(TNS)) then
    TNS := '"' + TNS + '"';
  QFN := FieldNameStr;
  if Quoted and (ContainsInvalidIdentChars(QFN) or IsReservedName(QFN)) then
    QFN := '"' + QFN + '"';
  if Qualified and (TNS <> '') then
    if FieldNameStr <> '' then
      Result := TNS + '.' + QFN
    else
      Result := TNS + '.*'
  else
    Result := QFN;
end;

function TnxSqlFieldRef.GetType(Context: TnxSqlContext): TnxFieldType;
begin
  if not TypeKnown then
    CheckType(Context);
  Result := FType;
end;

function TnxSqlFieldRef.CallFunc(Context: TnxSqlContext): Variant;
var
  V: Variant;
  i: Integer;
  aType: TnxFieldType;
  lArg: TnxSqlNode;
  ac: Integer;
begin
  ac := ArgCount;
  if ac > 0 then begin
    if fFuncArgs=nil then
    begin
      fFuncArgs := CreateTypedVariantList(ac);
      for i := 0 to ac - 1 do begin
        lArg := Arg[i];
        V := Unassigned;
        try
          Context.AllowNull:=true;
          aType:=TnxSqlSimpleExpression(lArg).GetType(Context);
        finally
          Context.AllowNull:=false;
        end;
        fFuncArgs.SetValue(
          i,
          V,
          TnxSqlSimpleExpression(lArg).GetLocaleDesc(Context),
          aType, TnxSqlSimpleExpression(lArg).GetSize(Context));
      end;
    end;

    for i := 0 to ac - 1 do begin
      lArg := Arg[i];
      V := Unassigned;
      V := TnxSqlSimpleExpression(lArg).GetValue(Context);
      fFuncArgs.SetValueOnly(i, V);
    end;
  end else
    nxIntfNil(fFuncArgs);
  if FFunction is TnxSqlCREATEFUNC then
    TnxSqlCREATEFUNC(FFunction).Database := Owner.Database;
  Result := TnxSqlAbstractFunc(FFunction).GetValue(fFuncArgs, Self, Context);
end;

procedure TnxSqlFieldRef.CheckType(Context: TnxSqlContext; RaiseExceptions: Boolean);
begin
  InternalCheckType(Context, RaiseExceptions);
end;

function TnxSqlFieldRef.IsAggregate(Strict: Boolean): Boolean;
var
  i: Integer;
begin
  if not TypeKnown then begin
    Result := False;
    exit;
  end;
  if FFunction = nil then
    Result := False
  else begin
    Result := ArgCount > 0;
    for i := 0 to ArgCount - 1 do
      if not TnxSqlSimpleExpression(Arg[i]).IsAggregate(Strict) then begin
        Result := False;
        break;
      end;
  end;
end;

//var
//  z, y: Integer;

function TnxSqlFieldRef.GetValueAsLenString(PV: PVariant; l: Integer): Variant;
var
  aString: string;
begin
  aString:=PV^;
  while length(astring)<l do
    aString:=aString+' ';
  result:=aString;
end;


function TnxSqlFieldRef.GetValue(Context: TnxSqlContext): Variant;
var
  LocalDef: TnxObject;
  PV: PVariant;
  F: TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if IsLocalVar then begin
    //can't cache this pointer - it needs to be looked up
    // from the context in case of recursive calls
    PV := Context.LookUpLocal(FieldNameStr, LocalDef);
    Result := PV^;

    if LocalDef is TnxSqlParmDef then
      if not VarIsNull(Result)
      and (TnxSqlParmDef(LocalDef).DataType=nxtNullString)
      and (TnxSqlParmDef(LocalDef).Decimals>0)
      then
        result:=GetValueAsLenString(PV, TnxSqlParmDef(LocalDef).Size);
    exit;
  end;
  if ExternalIndex <> -1 then begin
    Result := Context.ExternalColumnGetter(ExternalIndex);
    exit;
  end;
  if FFunction <> nil then
    Result := CallFunc(Context)
  else begin
    F := FField;
    if F = nil then
      F := GetField(Context);
    if F <> nil then
      Result := F.GetValue(Context)
    else
      raise Exception.Create('Invalid field');
  end;
end;

function TnxSqlFieldRef.IsDeterministic(Context: TnxSqlContext; aWithinRow: Boolean): Boolean;
var
  i: Integer;
begin
  if not TypeKnown then
    if Context <> nil then
    begin
      InternalCheckType(Context, false);
      if not TypeKnown then
      begin
        result:=false;  // can't know if parts are not yet bound
        exit;
      end;
    end
    else begin
      Result := False; // can't know without context
      exit;
    end;
  if IsLocalVar then
    Result := True
  else
  if ExternalIndex <> -1 then
    Result := False
  else
  if FFunction <> nil then begin
    Result := TnxSqlAbstractFunc(FFunction).IsDeterministic;
    if Result then begin
      for i := 0 to ArgCount - 1 do
        if not TnxSqlSimpleExpression(Arg[i]).IsDeterministic(Context, aWithinRow) then begin
          Result := False;
          exit;
        end;
    end;
  end else
    Result := aWithinRow;
end;

(*
function TnxSqlFieldRef.GetLocale(Context: TnxSqlContext): DWord;
var
  F: TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if IsLocalVar then begin
    Result := Context.LookUpLocalLocale(FieldNameStr);
    exit;
  end;
  if ExternalIndex <> -1 then begin
    Result := LOCALE_SYSTEM_DEFAULT; // for now
    exit;
  end;
  if FFunction <> nil then
    Result := LOCALE_SYSTEM_DEFAULT // for now
  else begin
    F := GetField(Context);
    if F.IsTarget then begin
      Assert(OwnerSelect <> nil);
      if F.SrcIndex > -1 then
        Result := TnxSqlSimpleExpression(TnxsqlSELECT(OwnerSelect).RowBuilder.SourceFieldExpression[
          F.SrcIndex]).GetLocale(Context)
      else
        Result := F.SrcField.GetLocale;
    end else
      Result := F.GetLocale;
  end;
end;
*)

function TnxSqlFieldRef.GetLocaleDesc(Context: TnxSqlContext): TnxLocaleDescriptor;
var
  F: TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if not (FType in nxcStringTypes) then begin
    Result := nil;
    Exit;
  end;
  if IsLocalVar then begin
    Result := Context.LookUpLocalLocaleDesc(FieldNameStr);
    exit;
  end;
  if ExternalIndex <> -1 then begin
    Result := FLocaleDesc;
    exit;
  end;
  if FFunction <> nil then
    Result := FLocaleDesc // for now
  else begin
    F := GetField(Context);
    {if F.IsTarget then begin
      Assert(OwnerSelect <> nil);
      if F.SrcIndex > -1 then
        Result := TnxSqlSimpleExpression(TnxsqlSELECT(OwnerSelect).RowBuilder.SourceFieldExpression[
          F.SrcIndex]).GetLocaleDesc(Context)
      else
        Result := F.SrcField.GetLocaleDesc;
    end else}
      Result := F.GetLocaleDesc;
  end;
end;

function TnxSqlFieldRef.GetQuoted: boolean;
var
  astring: string;
begin
  if FFieldName <> nil then begin
    aString := Trim(TokenToStr(FFieldName));
    Result := aString[1]='"';
  end else
    result:=fQuoted;
end;

{function TnxSqlFieldRef.GetCodepage(Context: TnxSqlContext): Integer;
var
  F: TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if IsLocalVar then begin
    Result := 0;
    exit;
  end;
  if ExternalIndex <> -1 then begin
    Result := 0;
    exit;
  end;
  if FFunction <> nil then
    Result := 0
  else begin
    F := GetField(Context);
    if F.IsTarget then begin
      Assert(OwnerSelect <> nil);
      if F.SrcIndex > -1 then
        Result := TnxSqlSimpleExpression(TnxsqlSELECT(OwnerSelect).RowBuilder.SourceFieldExpression[
          F.SrcIndex]).GetCodepage(Context)
      else
        Result := F.SrcField.GetCodepage;
    end else
      Result := F.GetCodepage;
  end;
end;}

function TnxSqlFieldRef.IsNull(Context: TnxSqlContext): Boolean;
var
  LocalDef: TnxObject;
  PV: PVariant;
  F: TnxSqlFieldProxy;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if IsLocalVar then begin
    //can't cache this pointer - it needs to be looked up
    // from the context in case of recursive calls
    PV := Context.LookUpLocal(FieldNameStr, LocalDef);
    Result := VarIsNull(PV^);
    exit;
  end;
  if ExternalIndex <> -1 then begin
    Result := VarIsNull(Context.ExternalColumnGetter(ExternalIndex));
    exit;
  end;
  if FFunction <> nil then
    Result := VarIsNull(CallFunc(Context))
  else begin
    F := FField;
    if F = nil then
      F := GetField(Context);
    Result := F.IsNull;
  end;
end;

procedure TnxSqlFieldRef.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i, c: Integer;
begin
  FieldNameStr := Stream.ReadLString;
  TableNameStr := Stream.ReadLString;
  c := Stream.ReadInt;
  for i := 0 to c - 1 do
    AddArg(Stream.ReadNode(Self) as TnxSqlSimpleExpression);
end;

procedure TnxSqlFieldRef.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteLString(FieldNameStr);
  Stream.WriteLString(TableNameStr);
  Stream.WriteInt(ArgCount);
  for i := 0 to ArgCount - 1 do
    Stream.WriteNode(Arg[i]);
end;

procedure TnxSqlFieldRef.MatchType(Context: TnxSqlContext; ExpectedType: TnxFieldType);
var
  aValue: string;
begin
  if GetType(Context) <> ExpectedType then
    case GetType(Context) of
      nxtBoolean:                             
        begin
          Owner.Database.ServerDatabase.Session.OptionGetEffective('NONSTRICTASSIGNMENT', aValue);
          if aValue<>'1' then
            TypeMismatch(LocationStr);
        end;
      nxtByte..nxtCurrency, nxtBcd, nxtFmtBcd :
        case ExpectedType of
          nxtByte..nxtCurrency, nxtBcd, nxtFmtBcd :
            ;
        else
          TypeMismatch(LocationStr);
        end;
      nxtDate,
      nxtTime,
      nxtDateTime :
        case ExpectedType of
          nxtDate..nxtDateTime :
            ;
        else
          TypeMismatch(LocationStr);
        end;
      nxtChar,
      nxtWideChar,
      nxtBlobMemo, nxtBlobWideMemo,
      nxtShortString..nxtWideString :
        case ExpectedType of
          nxtChar, nxtWideChar, nxtBlobMemo, nxtBlobWideMemo, nxtShortString..nxtWideString :
            ;
        else
          TypeMismatch(LocationStr);
        end;
      nxtBlob, {nxtBlobMemo, }nxtBlobGraphic{, nxtBlobWideMemo} :
        case ExpectedType of
          nxtChar, nxtWideChar,
          nxtShortString..nxtWideString,
          nxtBlob, {nxtBlobMemo, }nxtBlobGraphic{, nxtBlobWideMemo} :
            ;
        else
          TypeMismatch(LocationStr);
        end;
    else
      TypeMismatch(LocationStr);
    end;
end;

(*
function TnxSqlFieldRef.QualifiedName : string;
var
  Name : string;
begin
  Result := FieldNameStr;
  if FTableNameStr = '' then begin
    if assigned(FField) then
      Result := FField.OwnerTable.Name + '.' + FieldNameStr
    else
      Result := FieldNameStr;
  end
  else begin
    if OwnerSelect = nil then
      EInvColRef;
    Name := TnxsqlSELECT(OwnerSelect).TableRefList.AliasToName(FTableNameStr);
    if Name <> '' then
      Result := Name + '.' + FieldNameStr
    else
      Result := TableNameStr + '.' + FieldNameStr;
  end;
end;
*)

function TnxSqlFieldRef.ToString: WideString;
var
  i: Integer;
begin
  if (FFunction <> nil)
  or (FArgs <> nil) and (FArgs.Count > 0) then begin
    Result := ' ' + FieldNameStr;
    if (FArgs <> nil) and (FArgs.Count > 0) then begin
      Result := Result + '(';
      for i := 0 to FArgs.Count - 1 do begin
        Result := Result + Trim(Arg[i].ToString);
        if i < FArgs.Count - 1 then
          Result := Result + ', ';
      end;
      Result := Result + ')';
    end;
  end else begin
    Result := '';
    if WasWildcard then begin
      Result := Result + TableNameStr + '.*';
    end else
      Result := Result + GetTitle(True, True);
    if DatabaseNameStr <> '' then
      Result := DatabaseNameStr + '.' + Result;
    Result := ' ' + Result;
  end;
end;

function TnxSqlFieldRef.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
begin
  Result := TableNameStr <> '';
  if Result and SameText(TableNameStr, AliasName) then
    QualRefList.Add(FieldNameStr);
end;

procedure TnxSqlFieldRef.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
var
  i: Integer;
begin
  Callback(Self, UserData);
  if (FArgs <> nil) and (FArgs.Count > 0) then
    for i := 0 to FArgs.Count - 1 do
      Arg[i].Traverse(Callback, UserData, IncludeNested);
end;

procedure TnxSqlFieldRef.Unbind;
var
  i: Integer;
begin
  for i := 0 to ArgCount - 1 do
    TnxSqlSimpleExpression(Arg[i]).Unbind;
  FField := nil;
  FFieldLifetimeMonitor := nil;
  ReleaseFunction;
  TypeKnown := False;
end;

function TnxSqlFieldRef.GetTableNameStr: string;
begin
  if FTableName <> nil then
    Result := TokenToStrStripQ(FTableName)
  else
    Result := FTableNameStr;
end;

procedure TnxSqlFieldRef.SetTableNameStr(const Value: string);
begin
  if Value <> GetTableNameStr then begin
    FTableNameStr := Value;
    FTableName := nil;
  end;
end;

function TnxSqlFieldRef.GetFieldNameFromToken: string;
var
  i: integer;
begin
  Result := TokenToStrStripQ(FFieldName);
  FFieldNameStr:=Result;
  i:=1;
  while (i<Length(FFieldNameStr)) and (FFieldNameStr[i]=' ') do
    inc(i);
  fQuoted := (i<Length(FFieldNameStr)) and (FFieldNameStr[i]='"');
//  FFieldName := nil;
end;

function TnxSqlFieldRef.GetFieldNameStr: string;
begin
  if (FFieldNameStr='') and (FFieldName <> nil) then
    Result:=GetFieldNameFromToken
  else
    Result:=FFieldNameStr;
end;

procedure TnxSqlFieldRef.SetFieldNameStr(const Value: string);
begin
  if Value <> GetFieldNameStr then begin
    FFieldNameStr := Value;
    fQuoted := (Trim(Value)<>'') and (Trim(Value)[1]='"');
    FFieldName := nil;
  end;
end;

function TnxSqlFieldRef.GetDatabaseNameStr: string;
begin
  if FDatabaseName <> nil then
    Result := TokenToStrStripQ(FDatabaseName)
  else
    Result := FDatabaseNameStr;
  if Result='' then
    if (Owner<>nil) and (Owner.Database<>nil) then
      Result:=Owner.Database.DefaultDatabaseStr;
end;

procedure TnxSqlFieldRef.SetDatabasenameStr(const Value: string);
begin
  if Value <> GetDatabaseNameStr then begin
    FDatabaseNameStr := Value;
    FDatabaseName := nil;
  end;
end;

function TnxSqlFieldRef.LocationStr: string;
begin
  if FFieldName <> nil then
    Result := TokenToLocationStr(FFieldName)
  else
    Result := TokenToLocationStr(FFieldName);
end;

procedure TnxSqlFieldRef.SetField(Value: TnxSqlFieldProxy);
begin
  FField := Value;
end;

procedure TnxSqlFieldRef.Clear;
var
  i: Integer;
begin
  if FArgs <> nil then begin
    for i := 0 to FArgs.Count - 1 do
      TObject(FArgs[i]).Free;
    FArgs.Free;
  end;
  ReleaseFunction;
end;

function TnxSqlFieldRef.IsFieldFrom(Context: TnxSqlContext;
  Table: TnxSqlTableProxy; var FieldReferenced: TnxSqlFieldProxy;
  var SameCase: Boolean; UpperLowerAccepted: Boolean; RaiseExceptions: Boolean): Boolean;
begin
  Result := False;
  FieldReferenced := GetField(Context, RaiseExceptions);
  if FieldReferenced <> nil then begin
    if FieldReferenced.OwnerTable = Table then begin
      Result := True;
      SameCase := True;
    end;
  end else
    if FFunction <> nil then begin
      Result := UpperLowerAccepted
        and TnxSqlAbstractFunc(FFunction).CanOptimizeOn
        and (FArgs <> nil)
        and (FArgs.Count > 0)
        and TnxSqlSimpleExpression{CondExp}(FArgs[0]).IsFieldFrom(Context, Table, FieldReferenced, SameCase, True, RaiseExceptions);
      SameCase := False;
    end;
end;

function TnxSqlFieldRef.FieldNameLoc: string;
begin
  if FFieldName <> nil then
    Result := TokenToLocationStr(FFieldName)
  else
    Result := '';
end;

function TnxSqlFieldRef.IsLocalVariable(Context: TnxSqlContext; var LocalNameStr: string): Boolean;
begin
  if not TypeKnown then
    CheckType(Context); // make sure type is known
  if IsLocalVar then begin
    Result := True;
    LocalNameStr := FieldNameStr;
  end else
    Result := False;
end;

function TnxSqlFieldRef.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  Result := SameText(TableNameStr, aTableName);
  if not Result then begin
    for i := 0 to ArgCount - 1 do
      if TnxSqlSimpleExpression(Arg[i]).RefersTo(aTableName) then begin
        Result := True;
        exit;
      end;
    if (FArgs <> nil)
    and (FArgs.Count > 0)
    and (TableNameStr = '')
    and SameText(FieldNameStr, aTableName) then
      Result := True;
  end;
end;

function TnxSqlFieldRef.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  Result :=
    ({(TableNameStr = '') or} SameText(TableNameStr, aTableName))
    and SameText(FieldNameStr, aColumnName);
  if not Result then
    for i := 0 to ArgCount - 1 do
      //if TnxSqlCondExp(Arg[i]).RefersTo(aTableName, aColumnName) then begin
      if TnxSqlSimpleExpression(Arg[i]).RefersTo(aTableName, aColumnName) then begin
        Result := True;
        exit;
      end;
  if not Result and SameText(FieldNameStr, aColumnName) and (TableNameStr = '') then
    if Owner is TnxSqlSELECT then
      if TnxSqlSELECT(Owner).TableRefList.RefersTo(aTableName) then
        Result := True;
end;

function TnxSqlFieldRef.IsOwnedByAggregate: Boolean;
var
  Temp : TnxSqlNode;
begin
  Temp := FParent;
  while Temp <> nil do begin
    if Temp is TnxSqlAggregate then begin
      Result := True;
      exit;
    end;
    Temp := Temp.Parent;
  end;
  Result := False;
end;

function TnxSqlFieldRef.IsColumnRef: Boolean;
var
  i: Integer;
begin
  Result := False;
  if not TypeKnown then
    exit; // don't know, actually
  if IsLocalVar then
    exit;
  if ExternalIndex <> -1 then
    exit;
  if FFunction <> nil then begin
    for i := 0 to ArgCount - 1 do
      if TnxSqlSimpleExpression(Arg[i]).IsColumnRefExpr then begin
        Result := True;
        exit;
      end;
    Result := False;
    exit;
  end;
  Result := True;
end;

function TnxSqlFieldRef.RefersToContextVar(Context: TnxSqlContext): Boolean;
begin
  Assert(Context <> nil);
  if not TypeKnown then
    CheckType(Context);
  Result := IsLocalVar or (ExternalIndex <> -1)
end;

function TnxSqlFieldRef.IsUpperExpr(
  var Argument: TnxSqlNode): Boolean;
begin
  Result:=false;
  if (UpperCase(FieldNameStr) = 'UPPER') then
  begin
    if FArgs=nil then
      raise EnxInternalSQLException.CreateResFMT(@rsUPPERExpressionIs, [LocationStr]);
    if (FArgs.Count = 1) then begin
      Result := True;
      Argument := TnxSqlSimpleExpression(Arg[0]);
    end;
  end;
end;

function TnxSqlFieldRef.IsOuterReference(Context: TnxSqlContext): Boolean;
begin
  if not TypeKnown then
    GetType(Context);
  Result := FIsOuterReference;
end;

{ TnxSqlColumn }

procedure TnxSqlColumn.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlColumn then begin
    ColumnNameStr := TnxSqlColumn(Source).ColumnNameStr;
  end else
    ENotCompatible(Source);
end;

function TnxSqlColumn.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlColumn.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlColumn.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result :=
    (ANode is TnxSqlColumn)
      and AnsiSameText(ColumnNameStr, TnxSqlColumn(ANode).ColumnNameStr);
end;

function TnxSqlColumn.GetColumnNameStr: string;
begin
  if FColumnName <> nil then
    Result := TokenToStrStripQ(FColumnName)
  else
    Result := FColumnNameStr;
end;

procedure TnxSqlColumn.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  ColumnNameStr := Stream.ReadLString;
end;

procedure TnxSqlColumn.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteLString(ColumnNameStr);
end;

procedure TnxSqlColumn.SetColumnNameStr(const Value: string);
begin
  if Value <> GetColumnNameStr then begin
    FColumnNameStr := Value;
    FColumnName := nil;
  end;
end;

function TnxSqlColumn.ToString: WideString;
begin
  if (PosCh(' ', ColumnNameStr) <> 0)
  or IsReservedName(ColumnNameStr) then
    Result := ' "' + ColumnNameStr + '"'
  else
    Result := ' ' + ColumnNameStr;
end;

procedure TnxSqlColumn.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
end;

{ TnxSqlNodeList }

function TnxSqlNodeList.Add(
  Item: TnxSqlNode): TnxSqlNode;
begin
  FList.Add(Item);
  Result := Item;
end;

procedure TnxSqlNodeList.Assign(const Source: TnxSqlNode);
var
  i : Integer;
begin
  Clear;
  for i := 0 to TnxSqlNodeList(Source).Count - 1 do
    Add(TnxSqlNodeList(Source)[i].Clone(FOwner));
end;

procedure TnxSqlNodeList.Clear;
var
  i : Integer;
begin
  if OwnsItems then
    for i := 0 to FList.Count - 1 do
      Item[i].Free;
  FList.Clear;
end;

function TnxSqlNodeList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlNodeList.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlNodeList.Create(AOwner: TnxSqlNode);
begin
  inherited Create(AOwner);
  FOwner := AOwner;
  FList := TList.Create;
  FOwnsItems := True;
end;                              

destructor TnxSqlNodeList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TnxSqlNodeList.Equals(AList: TnxSqlNode): Boolean;
var
  i : Integer;
begin
  Result := False;
  if FList.Count <> TnxSqlNodeList(AList).Count then
    exit;
  for i := 0 to FList.Count - 1 do
    if not Item[i].Equals(TnxSqlNodeList(AList).Item[i]) then
      exit;
  Result := True;
end;

function TnxSqlNodeList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TnxSqlNodeList.GetItem(Index: Integer): TnxSqlNode;
begin
  {$IFOPT C+}
  Result := TnxSqlNode(FList[Index]);
  {$ELSE}
  Result := TnxSqlNode(FList.List[Index]);
  {$ENDIF}
end;

class function TnxSqlNodeList.Identical(List1,
  List2: TnxSqlNodeList): Boolean;
begin
  if List1 = nil then
    Result := List2 = nil
  else
    if List2 = nil then
      Result := False
    else
      Result := List1.Equals(List2);
end;

function TnxSqlNodeList.IndexOf(Item: TnxSqlNode): Integer;
begin
  Result := FList.IndexOf(Item);
end;

procedure TnxSqlNodeList.Insert(Index: Integer; Item: TnxSqlNode);
begin
  FList.Insert(Index, Item);
end;

procedure TnxSqlNodeList.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i: Integer;
begin
  for i := 0 to Stream.ReadInt - 1 do
    Add(Stream.ReadNode(Self) as TnxSqlNode);
end;

procedure TnxSqlNodeList.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteInt(Count);
  for i := 0 to Count - 1 do
    Stream.WriteNode(Item[i]);
end;

function TnxSqlNodeList.ToString: WideString;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to FList.Count - 1 do begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + Item[i].ToString;
  end;
end;

procedure TnxSqlNodeList.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
var
  i : Integer;
begin
  for i := 0 to FList.Count - 1 do
    Item[i].Traverse(Callback, UserData, IncludeNested);
end;

{ TnxSqlInsertItem }

procedure TnxSqlInsertItem.AddColumnDef(Target: TnxSqlColumnListOwner);
begin
  //Target.Columns.Add(ColumnName);
  Target.Columns.AddColumn(ColumnNameStr, nil);
end;

procedure TnxSqlInsertItem.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlInsertItem then begin
    ColumnNameStr := TnxSqlInsertItem(Source).ColumnNameStr;
  end else
    ENotCompatible(Source);
end;

function TnxSqlInsertItem.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlInsertItem.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlInsertItem.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result :=
    (ANode is TnxSqlInsertItem)
    and SameText(ColumnNameStr, TnxSqlInsertItem(ANode).ColumnNameStr);
end;

function TnxSqlInsertItem.GetColumnNameStr: string;
begin
  if FColumnName <> nil then
    Result := TokenToStrStripQ(FColumnName)
  else
    Result := FColumnNameStr;
end;

procedure TnxSqlInsertItem.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  ColumnNameStr := Stream.ReadLString;
end;

procedure TnxSqlInsertItem.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteLString(ColumnNameStr);
end;

procedure TnxSqlInsertItem.SetColumnNameStr(const Value: string);
begin
  if Value <> GetColumnNameStr then begin
    FColumnNameStr := Value;
    FColumnName := nil;
  end;
end;

function TnxSqlInsertItem.ToString: WideString;
begin
  Result := ColumnNameStr;
end;

procedure TnxSqlInsertItem.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
end;

{ TnxSqlColumnListOwner }

constructor TnxSqlColumnListOwner.Create(AParent: TnxSqlNode);
begin
  inherited;
  FColumnList := TnxColumnList.Create;
end;

destructor TnxSqlColumnListOwner.Destroy;
begin
  FColumnList.Free;
  inherited;
end;

{ TnxSqlRootNode }

constructor TnxSqlRootNode.Create(AParent: TnxSqlNode);
begin
  inherited;
  FUseIndexes := True;
  FAllowSimplification := True;
  if assigned(Owner) then
    Owner.AddRoot(Self);
end;

function TnxSqlRootNode.GetParentBlock: TnxSqlBlock;
begin
  if FParentBlock = nil then begin
    FParentBlock := TnxSqlBlock(Parent);
    while (FParentBlock <> nil)
    and not (TObject(FParentBlock) is TnxSqlBlock) do
      FParentBlock := TnxSqlBlock(FParentBlock.Parent);
  end;
  Result := FParentBlock;
end;

function TnxSqlRootNode.GetParmCount: Integer;
var
  PB: TnxSqlBlock;
begin
  PB := ParentBlock;
  if PB <> nil then
    Result := PB.ParmCount
  else
    Result:=0;
end;

{function TnxSqlRootNode.GetParmValue(Index: Integer): Variant;
var
  Locale: TnxLocaleDescriptor;
begin
  Result := ParentBlock.ParmList.GetValue(Index, Locale);
end;}

function TnxSqlRootNode.GetParameterLocale(
  Index: Integer): TnxLocaleDescriptor;
var
  {V: Variant;}
  PB: TnxSqlBlock;
  PL: InxTypedVariantList;
begin
  PB := ParentBlock;
  PL := PB.ParmList;
  if assigned(PL) then
    {V := }PL.GetValue(Index, Result)
  else
    Result := nil;
end;

function TnxSqlRootNode.GetParameterFieldType(
  Index: Integer): TnxFieldType;
begin
  Result := ParentBlock.ParmList.GetType(Index);
end;

procedure TnxSqlRootNode.QualifyColumns(const aTableName: String);
var
//  Prefix: string;
//  i: Integer;
  aData: TQualifyData;
begin
  if aTableName = '' then
    exit;
//  Prefix := UpperCase(aTableName) + '.';
  aData:=TQualifyData.Create;
  try
    aData.TableName:=aTableName;
    Traverse(DoQualify, aData, true);
  finally
    aData.Free;
  end;
end;

procedure TnxSqlRootNode.DoQualify(Node: TnxSqlNode;
  UserData: TObject);
//var
//  aColumn: TnxSqlFieldRef;
begin
  if Node is TnxSqlFieldRef then
    if TnxSqlFieldRef(Node).TableNameStr='' then
      TnxSqlFieldRef(Node).TableNameStr:=TQualifyData(UserData).TableName;
end;

function TnxSqlRootNode.GetParmPtr(Index: Integer): PVariant;
begin
  if ParentBlock.ParmList = nil then
    Result := nil
  else
    Result := ParentBlock.ParmList.GetValuePtr(Index);
end;

procedure TnxSqlRootNode.IncParmCount;
begin
  if ParentBlock<>nil then
    inc(ParentBlock.ParmCount);
end;

function TnxSqlRootNode.NeedsUnbinding: Boolean;
begin
  Result := False;
end;

procedure TnxSqlRootNode.SetCopyBlobs(const Value: Boolean);
var
  i: Integer;
begin
  FCopyBlobs := Value;
  //Traverse(UpdateCopyBlobs, nil, True);
  if assigned(Roots) then
    for i := 0 to Roots.Count - 1 do
      TnxSqlRootNode(Roots.List[i]).SetCopyBlobs(Value);
end;

procedure TnxSqlRootNode.SetUseIndexes(const Value: Boolean);
var
  i: Integer;
begin
  FUseIndexes := Value;
  //Traverse(UpdateUseIndexes, nil, True);
  if assigned(Roots) then
    for i := 0 to Roots.Count - 1 do
      TnxSqlRootNode(Roots.List[i]).SetUseIndexes(Value);
end;

procedure TnxSqlRootNode.SetDatabase(Value: TnxSqlDatabaseProxy);
var
  i: Integer;
begin
  FDatabase := Value;
  if assigned(Roots) then
    for i := 0 to Roots.Count - 1 do
      TnxSqlRootNode(Roots.List[i]).SetDatabase(Value);
end;

{procedure TnxSqlRootNode.UpdateUseIndexes(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlRootNode then
    TnxSqlRootNode(Node).FUseIndexes := UseIndexes;
end;

procedure TnxSqlRootNode.UpdateCopyBlobs(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlRootNode then
    TnxSqlRootNode(Node).FCopyBlobs := CopyBlobs;
end;}

function TnxSqlRootNode.EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  Result := tsbFalse;
end;

{
procedure TnxSqlRootNode.SetParentBlock(AParentBlock: TnxSqlBlock);
begin
  FParentBlock := AParentBlock;
end;
}

function TnxSqlRootNode.WhereIsValidFilterStatement: Boolean;
begin
  Result := False;
end;

function TnxSqlRootNode.EvaluateFirst(Context: TnxSqlContext): variant;
begin
  Result := null;
end;

function TnxSqlRootNode.IsDDLStatement: Boolean;
begin
  Result := False;
end;

function TnxSqlRootNode.BindingDatabase: TnxSqlDatabaseProxy;
var
  N: TnxSqlNode;
begin
  N := Self;
  while N <> nil do begin
    if N is TnxSqlBlock then
      if TnxSqlBlock(N).OwnerStatement <> nil then begin
        Result := (TnxSqlBlock(N).OwnerStatement as TnxSqlStatement).DatabaseProxy;
        if Result <> nil then
          exit;
      end;
    N := N.Parent;
  end;
  Result := nil;
end;

procedure TnxSqlRootNode.BindWhere(aContext: TnxSqlContext);
begin
end;

function TnxSqlRootNode.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
begin
  Result := False;
end;

procedure TnxSqlRootNode.ParametersChanged;
begin
  // do nothing
end;

procedure TnxSqlRootNode.AddRoot(Node: TnxSqlRootNode);
begin
  if Roots = nil then
    Roots := TList.Create;
  Roots.Add(Node);
end;

destructor TnxSqlRootNode.Destroy;
begin
  if assigned(Owner) then
    Owner.RemoveRoot(Self);
  nxFreeAndNil(Roots);
  inherited;
end;

procedure TnxSqlRootNode.RemoveRoot(Node: TnxSqlRootNode);
begin
  Roots.Remove(Node);
end;

{ TnxSqlLockNode }
{ never used
constructor TnxSqlLockNode.CreateWithLock(AOwner: TnxSqlNode; aLockContainer: InxSqlLockContainer);
begin
  snLockContainer := aLockContainer;
  Create(aOwner);
end;
}
procedure TnxSqlLockNode.Assign(const Source: TnxSqlNode);
begin
  if (source<>nil) and (source is TnxSqlLockNode) then
    TnxSqlLockNode(source).snLockContainer := snLockContainer;
end;

constructor TnxSqlLockNode.Create(AParent: TnxSqlNode);
begin
  inherited;
  if not Assigned(snLockContainer) then begin
    if Assigned(OwnerSelect) and (OwnerSelect <> Self) then
      snLockContainer := (OwnerSelect as TnxSQLSelect).LockContainer
    else if Assigned(Owner) and Assigned(Owner.OwnerSelect) and (Owner.OwnerSelect <> OwnerSelect) then
      snLockContainer := (Owner.OwnerSelect as TnxSQLSelect).LockContainer
    else begin
      if Owner is TnxSqlTableExp then
        snLockContainer := Owner.snLockContainer;
    end;

    if not Assigned(snLockContainer) then
      Supports(nxSqlLockContainerClass.Create, InxSqlLockContainer, snLockContainer);
  end
end;

destructor TnxSqlLockNode.Destroy;
begin
  inherited;
  Assert(not Assigned(snLockContainer) or snLockContainer.CanOwnerBeFreed);
end;

procedure TnxSqlLockNode.snBeginUse;
begin
  snLockContainer.slcBeginUse;
end;

procedure TnxSqlLockNode.snEndUse;
begin
  snLockContainer.slcEndUse;
end;

{ TnxColumn }

constructor TnxColumn.Create(aToken: PTokenRecord; aInfo: TObject);
begin
  inherited Create;
  FToken := aToken;
  FInfo := aInfo;
end;

function TnxColumn.GetFieldRef: TnxSqlFieldRef;
begin
  result:=nil;
  if info<>nil then
    if Info is TnxSqlSimpleExpression then
      if TnxSqlSimpleExpression(Info).TermList[0].FactorList[0] is TnxSqlFacColumn then
        result:=TnxSqlFacColumn(TnxSqlSimpleExpression(Info).TermList[0].FactorList[0]).FieldRef;
end;

function TnxColumn.GetHasLocation: Boolean;
begin
  Result := FToken <> nil;
end;

function TnxColumn.GetLocation: string;
begin
  if FToken <> nil then
    Result := TokenToLocationStr(FToken)
  else
    Result := '';
end;

function TnxColumn.GetName: string;
begin
  if FName <> '' then
    Result := FName
  else
    if FToken <> nil then
      Result := TokenToStrStripQ(FToken)
    else
      Result := '';
end;

{ TnxColumnList }

procedure TnxColumnList.AddColumn(aToken: PTokenRecord; aInfo: TObject);
begin
  FList.Add(TnxColumn.Create(aToken, aInfo));
end;

procedure TnxColumnList.AddColumn(const aName: string; aInfo: TObject);
var
  NewColumn: TnxColumn;
begin
  NewColumn := TnxColumn.Create(nil, aInfo);
  NewColumn.Name := aName;
  FList.Add(NewColumn);
end;

procedure TnxColumnList.AddColumn(const aName: string; aInfo: TObject;
  Hidden: Boolean);
var
  NewColumn: TnxColumn;
begin
  NewColumn := TnxColumn.Create(nil, aInfo);
  NewColumn.Name := aName;
  NewColumn.FHidden := True;
  FList.Add(NewColumn);
end;

procedure TnxColumnList.Clear;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    with Column[i] do begin
      if Hidden then
        Info.Free;
      Free;
    end;
  FList.Clear;
end;

constructor TnxColumnList.Create;
begin
  inherited;
  FList := TList.Create;
end;

destructor TnxColumnList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TnxColumnList.IndexOf(const Search: string): Integer;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if SameText(Search, Column[i].Name) then begin
      Result := i;
      exit;
    end;
  Result := -1;
end;

function TnxColumnList.Exists(const Search: string): Boolean;
begin
  Result := IndexOf(Search) <> -1;
end;

function TnxColumnList.GetColumn(Index: Integer): TnxColumn;
begin
  Result := TnxColumn(FList[Index]);
end;

function TnxColumnList.GetCount: Integer;
begin
  Result := FList.Count;
end;

{
procedure TnxColumnList.SetColumn(Index: Integer; const Value: TnxColumn);
begin
  FList[Index] := Value;
end;
}

{$IFDEF DebugPsmStreams}
const
  PsmBoolStartTag     = 254;
  PsmIntStartTag      = 253;
  PsmInt64StartTag    = 252;
  PsmNodeStartTag     = 251;
  PsmLStringStartTag  = 250;
  PsmBoolEndTag       = 249;
  PsmIntEndTag        = 248;
  PsmInt64EndTag      = 247;
  PsmNodeEndTag       = 246;
  PsmLStringEndTag    = 245;
  PsmPStringStartTag  = 244;
  PsmWStringStartTag  = 243;
  PsmPStringEndTag    = 242;
  PsmWStringEndTag    = 241;
  PsmByteStartTag     = 240;
  PsmByteEndTag       = 239;

procedure CheckTag(Tag, ExpectedTag: Byte);
begin
  if Tag <> ExpectedTag then
    raise EnxInternalSQLException.CreateResFmt(@rsErrorExpectedPSM, [ExpectedTag, Tag]);
end;

{$ENDIF}

{ TnxSqlPSMWriter }

constructor TnxSqlPSMWriter.Create(TargetStream: TStream);
begin
  inherited Create;
  FTargetStream := TargetStream;
end;

{$IFDEF DebugPsmStreams}
procedure TnxSqlPSMWriter.WriteRawByte(B: Byte);
begin
  FTargetStream.Write(B, 1);
end;
{$ENDIF}

procedure TnxSqlPSMWriter.WriteBool(B: Boolean);
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmBoolStartTag);
{$ENDIF}
  FTargetStream.Write(B, 1);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmBoolEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteInt(I: Integer);
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmIntStartTag);
{$ENDIF}
  FTargetStream.Write(I, 4);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmIntEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteByte(B: Byte);
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmByteStartTag);
{$ENDIF}
  FTargetStream.Write(B, 1);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmByteEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteInt64(I: int64);
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmInt64StartTag);
{$ENDIF}
  FTargetStream.Write(I, 8);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmInt64EndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteNode(Node: TnxSqlNode);
var
  lVersion: Integer;
  lByte: Byte;
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmNodeStartTag);
{$ENDIF}
  lByte:=255;
  FTargetStream.Write(lByte,1);
  lVersion:=Node.GetVersion;
  FTargetStream.Write(lVersion,sizeof(Integer));
  {$IFDEF UNICODE}
  WritePString(AnsiString(Node.ClassName));
  {$ELSE}
  WritePString(Node.ClassName);
  {$ENDIF}
  Node.SaveToStream(Self);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmNodeEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteNodeOpt(Node: TnxSqlNode);
begin
  if Node <> nil then begin
    WriteBool(True);
    WriteNode(Node);
  end else
    WriteBool(False);
end;

procedure TnxSqlPSMWriter.WriteLString(const Str: string);
var
  l       : Integer;
  AnsiStr : AnsiString;
begin
  AnsiStr := AnsiString(Str);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmLStringStartTag);
{$ENDIF}
  l := length(AnsiStr);
  WriteInt(l);
  if l > 0 then
    FTargetStream.Write(AnsiStr[1], l);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmLStringEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WritePString(const Str: ShortString);
var
  l: Integer;
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmPStringStartTag);
{$ENDIF}
  l := length(Str);
  WriteByte(l);
  if l > 0 then
    FTargetStream.Write(Str[1], l);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmPStringEndTag);
{$ENDIF}
end;

procedure TnxSqlPSMWriter.WriteWString(const Str: WideString);
var
  l: Integer;
begin
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmWStringStartTag);
{$ENDIF}
  l := length(Str);
  WriteInt(l);
  if l > 0 then
    FTargetStream.Write(Str[1], l * 2);
{$IFDEF DebugPsmStreams}
  WriteRawByte(PsmWStringEndTag);
{$ENDIF}
end;
{ TnxSqlPSMReader }

constructor TnxSqlPSMReader.Create(SourceStream: TStream);
begin
  inherited Create;
  fVersion:=1;
  FSourceStream := SourceStream;
end;

{$IFDEF DebugPsmStreams}
function TnxSqlPSMReader.ReadRawByte: Byte;
begin
  FSourceStream.Read(Result, 1);
end;
{$ENDIF}

function TnxSqlPSMReader.ReadBool: Boolean;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmBoolStartTag);
  {$ENDIF}
  FSourceStream.Read(Result, 1);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmBoolEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadInt: Integer;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmIntStartTag);
  {$ENDIF}
  FSourceStream.Read(Result, 4);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmIntEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadByte: Byte;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmByteStartTag);
  {$ENDIF}
  FSourceStream.Read(Result, 1);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmByteEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadInt64: int64;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmInt64StartTag);
  {$ENDIF}
  FSourceStream.Read(result, 8);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmInt64EndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadNode(AOwner: TnxSqlNode): TnxSqlNode;
var
  lVersion: integer;
  lByte: Byte;
  lOldVersion:integer;
  aType: String;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmNodeStartTag);
  {$ENDIF}
  // what follows is an ugly hack to introduce versioning int the PSM streams
  FSourceStream.Read(lByte, 1);
  if lByte<>255 then
  begin
    lVersion:=1;
    FSourceStream.Position:=FSourceStream.Position-1;
  end
  else
    FSourceStream.Read(lVersion, sizeof(lVersion));
  aType:=string(ReadPString);
  if atype='' then
    atype:=string(ReadPString);
  Result := NodeFromString(aType, AOwner);
  lOldVersion:=self.fVersion;
  self.fVersion:=lVersion;
  Result.LoadFromStream(Self);
  self.fVersion:=lOldVersion;
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmNodeEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadNodeOpt(AOwner: TnxSqlNode): TnxSqlNode;
begin
  if ReadBool then
    Result := ReadNode(AOwner)
  else
    Result := nil;
end;

function TnxSqlPSMReader.ReadLString: string;
var
  l: Integer;
  AnsiStr: AnsiString;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmLStringStartTag);
  {$ENDIF}
  l := ReadInt;
  SetLength(AnsiStr, l);
  if l > 0 then
    FSourceStream.Read(AnsiStr[1], l);
  Result := string(AnsiStr);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmLStringEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadPString: ShortString;
var
  b: Byte;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmPStringStartTag);
  {$ENDIF}
  b := ReadByte;
  Result[0] := AnsiChar(chr(b));
  if b > 0 then
    FSourceStream.Read(Result[1], b);
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmPStringEndTag);
  {$ENDIF}
end;

function TnxSqlPSMReader.ReadWString: WideString;
var
  l: Integer;
begin
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmWStringStartTag);
  {$ENDIF}
  l := ReadInt;
  if l = 0 then
    Result := ''
  else begin
    SetLength(Result, l);
    FSourceStream.Read(Result[1], l * 2);
  end;
  {$IFDEF DebugPsmStreams}
  CheckTag(ReadRawByte, PsmWStringEndTag);
  {$ENDIF}
end;

{ TnxSqlContext }

procedure TnxSqlContext.Break;
var
  Run: TnxSqlExecScopePtr;
begin
  IncGeneration;
  Run := FExecScopesTail;
  while Assigned(Run) do begin
    Run.Break; // note: Break is a method of execscope here
    if Run.ScopeType = estLoop then
      exit;
    Run := Run.esPrev;
  end;
  raise EnxInternalSQLException.CreateRes(@rsBREAKMayNotAppear);
end;

function TnxSqlContext.BreakCalled: Boolean;
begin
  Assert(Assigned(FExecScopesTail));
  Result := FExecScopesTail.BreakCalled;
end;

procedure TnxSqlContext.Continue;
var
  Run: TnxSqlExecScopePtr;
begin
  IncGeneration;
  Run := FExecScopesTail;
  while Assigned(Run) do begin
    if Run.ScopeType = estLoop then begin
      Run.Continue; // note: Continue is a method of execscope here
      exit;
    end else
      Run.Break;  // note: Break is a method of execscope here
    Run := Run.esPrev;
  end;

  raise EnxInternalSQLException.CreateRes(@rsCONTINUEMayNotApp);
end;

var
  _ContextID: Integer;

constructor TnxSqlContext.Create(aDatabase: TnxSqlDatabaseProxy; aStartDateTime: TDateTime; aDefaultStringLiteralLocale: TnxLocaleDescriptor);
begin
  ContextID := LockedInc(_ContextID);
  inherited Create;
  FDatabase := aDatabase;
  FDefaultStringLiteralLocale := aDefaultStringLiteralLocale;
  FStartDateTime := aStartDateTime;
  AllowNull:=false;
  GlobalFilters:=nil;
  FetchStatus := -1;
  PadValues := true;
end;

type
  TnxSqlParmDefInternal = class(TnxSqlParmDef);

procedure TnxSqlContext.DefineLocals(List: TnxFastStringListIC);
var
  i: Integer;
begin
  FLocals := TnxFastStringListIC.Create;
  FLocals.Assign(List);
  for i := low(CInternalVars) to  high(CInternalVars) do
    fLocals.AddObject(CInternalVars[i], TnxSqlParmDefInternal.Create(CInternalVars[i], nxtInt32, 0, 0, '', 0, '', 0, pmInOut, dtNull, nil));
  FLocalValues := CreateVariantList(FLocals.Count);
  for i := 0 to FLocals.Count - 1 do
    FLocalValues.SetValue(i, null, nil);
  for i := 0 to FLocals.Count - 1 do
    SetToDefault(FLocals[i]);
  FLocals.Sorted := True;
end;

destructor TnxSqlContext.Destroy;
var
  i: integer;
begin
  FLocalValues := nil;

  if Assigned(FLocals) then begin
    for i := 0 to Pred(FLocals.Count) do
      if FLocals.Objects[i] is TnxSqlParmDefInternal then
        FLocals.Objects[i].Free;
    nxFreeAndNil(FLocals);
  end;

  inherited;
end;

function TnxSqlContext.Done: Boolean;
begin
  IncGeneration;
  Assert(Assigned(FExecScopesTail));
  Result := FExecScopesTail.Done;
end;

{procedure TnxSqlContext.DumpLocals;
var
  V : Variant;
  i: Integer;
  Locale: DWord;
begin
  writeln('locals:');
  if FLocals <> nil then begin
    for i := 0 to FLocals.Count - 1 do begin
      V := Unassigned;
      V := FLocalValues.GetValue(i, Locale);
      if VarIsNull(V) then
        writeln(FLocals[i],': null')
      else
        writeln(FLocals[i],': ',V);
    end;
    writeln;
  end;
end;}

function TnxSqlContext.GetValue(const VarName: string): variant;
var
  VP: PVariant;
  LocalDef: TnxObject;
begin
  VP := LookUpLocal(VarName, LocalDef);
  if VP = nil then
    raise EnxInternalSQLException.CreateResFmt(@rsErrorInTnxSqlConte,
      [VarName]);
  Result := VP^;
end;

var
  _Generation: Integer;

procedure TnxSqlContext.IncGeneration;
begin
  Generation := LockedInc(_Generation);
end;

function TnxSqlContext.LookUpLocal(const VarName: string;
  var LocalDef: TnxObject): PVariant;
var
  i: Integer;
begin

  if FLocals <> nil then
    with FLocals do begin
      i := IndexOf(VarName);
      if i = -1 then
        Result := nil
      else begin
        LocalDef := TnxObject(Objects[i]);
        Result := FLocalValues.GetValuePtr(i);
      end;
    end
  else
    Result := nil;
end;

function TnxSqlContext.LookUpLocalIndex(const VarName: string): integer;
begin
  result:=-1;
  if FLocals <> nil then
    result := FLocals.IndexOf(VarName);
end;

{function TnxSqlContext.LookUpLocalLocale(const VarName: string): DWord;
var
  i: Integer;
begin
  Result := LOCALE_SYSTEM_DEFAULT;
  if FLocals <> nil then
    with FLocals do begin
      i := IndexOf(VarName);
      if i <> -1 then begin
        FLocalValues.GetValue(i, Result);
      end;
    end
  else
end;}

function TnxSqlContext.LookUpLocalLocaleDesc(
  const VarName: string): TnxLocaleDescriptor;
var
  i: Integer;
begin
  Result := nil;
  if FLocals <> nil then
    with FLocals do begin
      i := IndexOf(VarName);
      if i <> -1 then begin
        FLocalValues.GetValue(i, Result);
      end;
    end
  else
end;
{
procedure TnxSqlContext.MergeLocals(List: TnxFastStringListIC);
var
  i: Integer;
  OldList: TnxFastStringListIC;
  OldValues: InxVariantList;
begin
  OldList:=FLocals;
  FLocals:=nil;
  for i := 0 to OldList.Count-1 do
  begin
    if List.IndexOf(OldList[i])>-1 then
      raise Exception.Create('DECLARE failed: '+OldList[i]+' already declared in this context');
    List.Add(OldList[i]);
  end;
  OldValues:=FLocalValues;
  FLocalValues:=nil;

  DefineLocals(List);
  for I := 0 to OldList.Count-1 do
    SetValue(OldList[i], GetValue(OldList[i]));
  OldValues:=nil;
  OldList.Free;
end;
}
function TnxSqlContext.Next: Boolean;
begin
  IncGeneration;
  Assert(Assigned(FExecScopesTail));
  Result := FExecScopesTail.Next;
end;

function TnxSqlContext.PC: Integer;
begin
  Assert(Assigned(FExecScopesTail));
  Result := FExecScopesTail.PC;
end;

function TnxSqlContext.PopExecScope(aFree: Boolean = True): TnxSqlExecScopePtr;
begin
  IncGeneration;
  Assert(Assigned(FExecScopesTail));
  Result := FExecScopesTail;
  if Assigned(Result) then begin
    FExecScopesTail := Result.esPrev;
    Result.esPrev := nil;
  end;
  {$IFNDEF SCOPE_ON_STACK}
  if aFree then begin
    Result.Free;
    Result := nil;
  end;
  {$ENDIF}
end;

procedure TnxSqlContext.PushExecScope(var Scope: TnxSqlExecScope);
begin
  IncGeneration;
  Scope.esPrev := FExecScopesTail;
  FExecScopesTail := {$IFDEF SCOPE_ON_STACK}@{$ENDIF}Scope;
end;

procedure TnxSqlContext.Return;
var
  Run: TnxSqlExecScopePtr;
begin
  IncGeneration;
  Run := FExecScopesTail;
  while Assigned(Run) do begin
    Run.Break;
    if Run.ScopeType = estMainBlock then
      exit;
    Run := Run.esPrev;
  end;
  raise EnxInternalSQLException.CreateRes(@rsRETURNMayNotAppea);
end;

procedure TnxSqlContext.SetEndPC(EndPC: Integer);
begin
  Assert(Assigned(FExecScopesTail));
  FExecScopesTail.EndPC := EndPC;
end;

procedure TnxSqlContext.SetToDefault(const VarName: string);
var
  VP: PVariant;
  LocalDef: TnxObject;
  D: double;
begin
  VP := LookUpLocal(VarName, LocalDef);
  if VP = nil then
    raise EnxInternalSQLException.CreateResFmt(@rsErrorInTnxSqlConte2,
      [VarName]);
  VP^ := Unassigned;
  if LocalDef<>nil then
    with (LocalDef as TnxSqlParmDef) do begin
      case DefaultType of
      dtNull, dtEmpty :
        VP^ := null;
      dtLiteral :
        VP^ := DefaultValue.GetValue(Self);
      dtDate :
        begin
          D := int(StartDateTime);
          VP^ := TDateTime(D);
        end;
      dtTime :
        begin
          D := frac(StartDateTime);
          VP^ := TDateTime(D);
        end;
      dtDateTime :
        VP^ := StartDateTime;
      dtNewGuid :
        VP^ := NewGUIDToWideString;
      end;
    end;
end;

procedure TnxSqlContext.SetValue(const VarName: string;
  const Value: variant; aLocale: TnxLocaleDescriptor=nil);
var
  VP: PVariant;
  LocalDef: TnxObject;
  anIndex: integer;
begin
  VP := LookUpLocal(VarName, LocalDef);
  if VP = nil then
    raise EnxInternalSQLException.CreateResFmt(@rsErrorInTnxSqlConte2,
      [VarName]);
  anIndex:=LookUpLocalIndex(VarName);
  FLocalValues.SetValue(anIndex, Value, aLocale);
end;

function TnxSqlContext.TryGetValue(const VarName: string): variant;
var
  VP: PVariant;
  LocalDef: TnxObject;
begin
  VP := LookUpLocal(VarName, LocalDef);
  if VP = nil then
    Result := Null
  else
    Result := VP^;
end;

procedure TnxSqlContext.UpdateTime;
begin
  FStartDateTime := Now;
end;

{ TnxSqlExecScope }

procedure TnxSqlExecScope.Break;
begin
  FPC := FEndPC;
  FBreakCalled := True;
end;

procedure TnxSqlExecScope.Continue;
begin
  if FScopeType = estLoop then
    FPC := FEndPC
    //FPC := -1
  else
    raise EnxInternalSQLException.CreateRes(@rsContinueIsNotAllo);
end;

constructor TnxSqlExecScope.Create(aScopeType: TnxSqlExecScopeType);
begin
  {$IFNDEF SCOPE_ON_STACK}
  inherited Create;
  {$ENDIF}
  FScopeType := aScopeType;
  Reset;
end;

function TnxSqlExecScope.Done: Boolean;
begin
  Result := FPC >= FEndPC;
end;

{$IFDEF SCOPE_ON_STACK}
procedure TnxSqlExecScope.Free;
begin
  { do nothing }
end;
{$ENDIF}

function TnxSqlExecScope.Next: Boolean;
begin
  inc(FPC);
  Result := FPC < FEndPC;
end;

procedure TnxSqlExecScope.Reset;
begin
  FEndPC := -1;
  FPC := -1;
  FBreakCalled := False;
end;

{ TnxSqlBaseColumn }

function TnxSqlBaseColumn.FieldNameLoc: string;
begin
  if FFieldName <> nil then
    Result := TokenToLocationStr(FFieldName)
  else
    Result := '';
end;

function TnxSqlBaseColumn.GetFieldNameStr: string;
begin
  if FFieldName <> nil then
    Result := TokenToStrStripQ(FFieldName)
  else
    Result := FFieldNameStr;
end;

function TnxSqlBaseColumn.GetTableNameStr: string;
begin
  if FTableName <> nil then
    Result := TokenToStrStripQ(FTableName)
  else
    Result := FTableNameStr;
end;

procedure TnxSqlBaseColumn.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  TableNameStr := Stream.ReadLString;
  FieldNameStr := Stream.ReadLString;
end;

procedure TnxSqlBaseColumn.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteLString(TableNameStr);
  Stream.WriteLString(FieldNameStr);
end;

procedure TnxSqlBaseColumn.SetFieldNameStr(const Value: string);
begin
  if Value <> GetFieldNameStr then begin
    FFieldNameStr := Value;
    FFieldName := nil;
  end;
end;

procedure TnxSqlBaseColumn.SetTableNameStr(const Value: string);
begin
  if Value <> GetTableNameStr then begin
    FTableNameStr := Value;
    FTableName := nil;
  end;
end;

procedure CheckGlobalTempName(Name: PTokenRecord);
var
  S: WideString;
begin
  S := TokenToStrStripQ(Name);
  if copy(S, 1, 3) <> '###' then
    raise EnxInternalSQLException.CreateRes(@rsTheNameOfAGlobal);
end;

procedure CheckLocalTempName(Name: PTokenRecord);
var
  S: WideString;
begin
  S := TokenToStrStripQ(Name);
  if copy(S, 1, 1) <> '#' then
    raise EnxInternalSQLException.CreateRes(@rsTheNameOfALocal);
end;

{ TnxSqlSetPasswords }

procedure TnxSqlSetPasswords.AddPassword(PW: PTokenRecord);
begin
  if FPasswordList = nil then
    FPasswordList := TnxFastStringListIC.Create;
  FPasswordList.Add(TokenToStrStripQ(PW));
end;

procedure TnxSqlSetPasswords.AddPassword(const PW: string);
begin
  if FPasswordList = nil then
    FPasswordList := TnxFastStringListIC.Create;
  FPasswordList.Add(PW);
end;

procedure TnxSqlSetPasswords.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlSetPasswords then
    with TnxSqlSetPasswords(Source) do begin
      Self.Clear;
      Self.Mode := Mode;
      if FPasswordList <> nil then begin
        Self.FPasswordList := TnxFastStringListIC.Create;
        for i := 0 to FPasswordList.Count - 1 do
          Self.AddPassword(FPasswordList[i]);
      end;
    end
  else
    ENotCompatible(Source);
end;

procedure TnxSqlSetPasswords.Bind(Prebinding: Boolean;
  Context: TnxSqlContext);
begin
  case Mode of
  spRemoveAll :
    FDatabase.RemoveAllPasswords;
  spAddList :
    FDatabase.AddPasswords(FPasswordList);
  spRemoveList :
    FDatabase.RemovePasswords(FPasswordList);
  spReplaceWithList :
    begin
      FDatabase.RemoveAllPasswords;
      FDatabase.AddPasswords(FPasswordList);
    end;
  end;
end;

procedure TnxSqlSetPasswords.Clear;
begin
  if FPasswordList <> nil then begin
    FPasswordList.Free;
    FPasswordList := nil;
  end;
end;

function TnxSqlSetPasswords.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlSetPasswords.Create(AParent);
  Result.Assign(Self);
end;

destructor TnxSqlSetPasswords.Destroy;
begin
  Clear;
  inherited;
end;

function TnxSqlSetPasswords.Equals(ANode: TnxSqlNode): Boolean;
var
  i: Integer;
begin
  if ANode is TnxSqlSetPasswords then
    with TnxSqlSetPasswords(ANode) do begin
      Result := (Mode = Self.Mode)
        and
          ((FPasswordList = nil) and (Self.FPasswordList = nil))
        or
          ((FPasswordList <> nil)
           and (Self.FPasswordList <> nil)
           and (FPassWordList.Count = Self.FPasswordList.Count));
      if Result and (FPasswordList <> nil) then begin
        for i := 0 to FPasswordList.Count do
          if FPasswordList[i] <> Self.FPasswordList[i] then begin
            Result := False;
            exit;
          end;
      end;
    end
  else
    Result := False;
end;

function TnxSqlSetPasswords.Execute(Context: TnxSqlContext;
  var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
  var RecordsRead, RowsAffected: Integer): TnxResult;
begin
{ moved to Bind
  case Mode of
  spRemoveAll :
    FDatabase.RemoveAllPasswords;
  spAddList :
    FDatabase.AddPasswords(FPasswordList);
  spRemoveList :
    FDatabase.RemovePasswords(FPasswordList);
  spReplaceWithList :
    begin
      FDatabase.RemoveAllPasswords;
      FDatabase.AddPasswords(FPasswordList);
    end;
  end;
  }
  Result := DBIERR_NONE;
end;

function TnxSqlSetPasswords.ExecuteDirect(aDatabase: TnxSqlAbstractDatabase): TnxResult;
var
  i: Integer;
begin
  Result := DBIERR_NONE;
  case Mode of
    spRemoveAll :
      aDatabase.Session.PasswordRemoveAll;
    spAddList :
      for i := 0 to FPasswordList.Count - 1 do
        aDatabase.Session.PasswordAdd(FPasswordList[i]);
    spRemoveList :
      for i := 0 to FPasswordList.Count - 1 do
        aDatabase.Session.PasswordRemove(FPasswordList[i]);
    spReplaceWithList : begin
      aDatabase.Session.PasswordRemoveAll;
      for i := 0 to FPasswordList.Count - 1 do
        aDatabase.Session.PasswordAdd(FPasswordList[i]);
    end;
  end;
end;

procedure TnxSqlSetPasswords.LoadFromStream(Stream: TnxSqlPSMReader);
var
  Count,i: Integer;
begin
  Mode := TnxSqlSetPasswordsMode(Stream.ReadInt);
  Count := Stream.ReadInt;
  if Count > 0 then begin
    if FPasswordList = nil then
      FPasswordList := TnxFastStringListIC.Create;
    for i := 0 to Count - 1 do
      FPasswordList.Add(Stream.ReadLString);
  end;
end;

function TnxSqlSetPasswords.RefersTo(const aTableName: string): Boolean;
begin
  Result := False;
end;

function TnxSqlSetPasswords.RefersTo2(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := False;
end;

procedure TnxSqlSetPasswords.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteInt(ord(Mode));
  if FPasswordList = nil then
    Stream.WriteInt(0)
  else begin
    Stream.WriteInt(FPasswordList.Count);
    for i := 0 to FPasswordList.Count - 1 do
      Stream.WriteLString(FPasswordList[i]);
  end;
end;

function TnxSqlSetPasswords.Simplify(Context: TnxSqlContext): Boolean;
begin
  Result := False;
end;

function TnxSqlSetPasswords.ToString: WideString;
var
  i: Integer;
begin
  Result := 'SET PASSWORDS';
  if (FPasswordList <> nil) and (FPasswordList.Count > 0) then begin
    case Mode of
    spRemoveAll : ;
    spAddList:
      Result := Result + ' ADD';
    spRemoveList :
      Result := Result + ' REMOVE';
    spReplaceWithList :
      ;
    end;
    for i := 0 to FPasswordList.Count - 1 do
      Result := Result + QuotedStr(FPasswordList[i]) + IfThen(i < FPasswordList.Count - 1, ', ', '');
  end;
end;

procedure TnxSqlSetPasswords.Traverse(Callback: TnxSqlCallback;
  UserData: TObject; const IncludeNested: Boolean);
begin
end;

procedure TnxSqlSetPasswords.Unbind;
begin
end;

var
  NodeTypes: TnxFastStringListIC;

procedure EnsureList;
begin
  if NodeTypes = nil then begin
    NodeTypes := TnxFastStringListIC.Create;
    NodeTypes.Sorted := True;
  end;
end;

procedure RegisterNodeType(ClassRef: TnxSqlNodeClass);
begin
  EnsureList;
  if NodeTypes.IndexOfObject(TObject(ClassRef)) <> -1 then
    raise EnxInternalSQLException.CreateRes(@rsClassAlreadyRegist);
  NodeTypes.AddObject(ClassRef.ClassName, TObject(ClassRef));
end;

function NodeFromString(const ClassName: {$IFDEF UNICODE}string{$ELSE}ShortString{$ENDIF}; AParent: TnxSqlNode): TnxSqlNode;
var
  I: Integer;
  NodeClass: TnxSqlNodeClass;
begin
  result:=nil;
  if ClassName='' then
    exit;
  I := NodeTypes.IndexOf(ClassName);
  if I = -1 then
    raise EnxInternalSQLException.CreateResFmt(@rsTypeSIsNotRegis, [ClassName]);
  NodeClass := TnxSqlNodeClass(NodeTypes.Objects[I]);
  {if (NodeClass.InheritsFrom(TnxSqlLockNode)) then
    Result := TnxSqlLockNodeClass(NodeClass).CreateWithLock(AParent, nil)
  else

  No need to do this. CreateWithLock is not virtual, all it does is set the passed in
  lock container (which is already nil by default) and then calles the
  virtual Create constructor

  }
    Result := NodeClass.Create(AParent);
end;

{ TnxSqlCustomSwitch }

constructor TnxSqlCustomSwitch.Create(aGroup, aItem, aValue: PTokenRecord);
begin
  SwitchGroup := aGroup;
  SwitchName := aItem;
  SwitchValue := aValue;
end;

{ TnxSqlLockContainer }

function TnxSqlLockContainer.CanOwnerBeFreed: Boolean;
begin
  if (not Assigned(slcPadlock)) or (UseCount = 0) then
    Result := True
  else begin
    slcPadlock.Lock;
    Result :=
      (UseCount = 0) or (slcInUseBy = GetCurrentThreadId);
//      ((slcAllowInUseFree > 0) and (slcInUseBy = GetCurrentThreadId));
    slcPadlock.UnLock;
  end;
end;

destructor TnxSqlLockContainer.Destroy;
begin
  inherited;
  freeandnil(slcPadlock);
end;

function TnxSqlLockContainer.UseCount: integer;
begin
  result:=LockedCompareExchange(slcInUse, 0, 0);
end;

procedure TnxSqlLockContainer.Lock;
begin
  slcInitPadlock;
  slcPadlock.Lock;
end;

procedure TnxSqlLockContainer.slcBeginUse;
var
  ThreadError: Boolean;
begin
  ThreadError := False;
  slcInitPadlock;
  Assert(Assigned(slcPadlock));
  slcPadlock.Lock;
  if LockedInc(slcInUse) = 1 then
    slcInUseBy := GetCurrentThreadId
  else
    if slcInUseBy <> GetCurrentThreadId then begin
      LockedDec(slcInUse);
      {$IFOPT C+}
      ThreadError := True;
      {$ENDIF}
    end;
  slcPadlock.UnLock;
  Assert(not ThreadError, 'slcBeginUse called by a different thread on an already in use lock container');
end;

procedure TnxSqlLockContainer.slcEndUse;
var
  ThreadError : Boolean;
  NewCount    : Integer;
begin
  NewCount := -1;
  Assert(Assigned(slcPadlock));
  slcPadlock.Lock;
  ThreadError := slcInUseBy <> GetCurrentThreadId;
  if not ThreadError then begin
    NewCount := LockedDec(slcInUse);
    if NewCount = 0 then
      slcInUseBy := 0;
  end;
  slcPadlock.UnLock;
  Assert(not ThreadError, 'slcEndUse called by a different thread');
  Assert(NewCount >= 0);
end;

procedure TnxSqlLockContainer.slcInitPadlock;
var
  Padlock : TnxPadlock;
begin
  if not Assigned(slcPadlock) then begin
    Padlock := TnxPadlock.Create;
    if LockedCompareExchange(Pointer(slcPadlock), Pointer(Padlock), nil) <> nil then
      nxFreeAndNil(Padlock);
  end;
end;

procedure TnxSqlLockContainer.UnLock;
begin
  slcPadlock.UnLock;
end;

{ TnxSqlLogList }

function TnxSqlLogList.Add(const S: string): Integer;
var
  tc: Cardinal;
  t: string;
begin
  tc := GetTickCount;

  if LastLog <> 0 then
    t := IntToStr(tc-LastLog)
  else
    t := IntToStr(0);

  while Length(t) < 6 do
    t := '0' + t;
  Result := inherited Add('['+t+'] ' + s);
  LastLog := tc;
end;

{ TnxSqlLockContainerIgnore }

function TnxSqlLockContainerIgnore.CanOwnerBeFreed: Boolean;
begin
  Result := True;
end;

procedure TnxSqlLockContainerIgnore.Lock;
begin

end;

procedure TnxSqlLockContainerIgnore.slcBeginUse;
begin

end;

procedure TnxSqlLockContainerIgnore.slcEndUse;
begin

end;

procedure TnxSqlLockContainerIgnore.UnLock;
begin

end;

function TnxSqlLockContainerIgnore.UseCount: integer;
begin
  Result := 0;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  RegisterNodeType(TnxSqlBlock);
  RegisterNodeType(TnxSqlColumn);
  RegisterNodeType(TnxSqlFieldRef);
  RegisterNodeType(TnxSqlInsertItem);
  RegisterNodeType(TnxSqlNodeList);
  RegisterNodeType(TnxSqlSetPasswords);
  RegisterNodeType(TnxSqlStatementBlock);
finalization
  NodeTypes.Free;
end.

