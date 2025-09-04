{##############################################################################}
{# NexusDB: nxsqlTableExp.pas 4.7516                                         #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: SQL Table Expressions                                             #}
{##############################################################################}

{$I nxDefine.inc}

{$define remodelexists}
{.$define PushFilters}
{.$define SaveLogToFile}

{$define PullFiltersFromOROps}
{$define ChooseDriverTableBasedOnFilterOrTemp}

unit nxsqlTableExp;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Classes,
  CocoaBaseW,
  nxsdTypes,
  nxllTypes,
  nxllMemoryManager,
  nxllList,
  nxsdKeyEngineBase,
  nxsdDataDictionary,
  nxsdServerEngine,
  nxsrTypes,
  nxsqlProxies,
  nxsqlBase,
  nxsqlCondExp,
  nxsdFilterEngineBase,
  nxsdKeyEngineComp,
  nxsrServerEngine,
  nxsrSqlEngineBase,
  nxllWideStringList;

const
  HashSizesCount = 4;
  HashSizes : array[0..HashSizesCount-1] of DWord = (1021, 4093, 16381, 65479);
  MaxHashSize = 65479;
  RefPoolEntriesPerPage = 1024;
  RefSetHashSize = 16381;
type
  TnxSqlJoinType = (jtCross, jtInner, jtLeftOuter, jtRightOuter,
    jtFullOuter);

  PRefPoolEntry = ^TRefPoolEntry;
  TRefPoolEntry = record
    Ref: int64;
    Next: PRefPoolEntry;
  end;

  PRefPoolPage = ^TRefPoolPage;
  TRefPoolPage = record
    Next: PRefPoolPage;
    Entries: array[0..RefPoolEntriesPerPage-1] of TRefPoolEntry;
  end;

  TnxSqlRefNrPool = class(TnxObject)
  private
    FirstPage,
    CurPage: PRefPoolPage;
    SlotPtr: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Alloc: PRefPoolEntry;
  end;

  TnxSqlRefNrHashTable = array[0..RefSetHashSize-1] of PRefPoolEntry;

  TnxSqlRefNrSetIterator = procedure(const RefNr: int64; UserData: Pointer) of object;

  TnxSqlRefNrSet = class(TnxObject)
  private
    EntryHash: TnxSqlRefNrHashTable;
    EntryPool: TnxSqlRefNrPool;
    procedure AddItem(const RefNr: int64; UserData: Pointer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const RefNr: int64); overload;
    procedure Add(Source: TnxSqlRefNrSet); overload;
    function Exists(const RefNr: int64): Boolean;
    procedure Intersect(Source: TnxSqlRefNrSet; Negative: Boolean);
    procedure Iterate(Iterator: TnxSqlRefNrSetIterator; UserData: Pointer);
  end;

  TnxSqlExecParm = class(TnxObject)
  private
    FValueExp: TnxSqlSimpleExpression; //TnxSqlCondExp;
  public
    constructor Create(aValueExp: TnxSqlSimpleExpression);
    destructor Destroy; override;

    property ValueExp: TnxSqlSimpleExpression read FValueExp;

    function RefersTo(const aTableName: string): Boolean;  overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function ToString: WideString; reintroduce;
    procedure Unbind;
  end;

  TnxSqlTableRef = class;
  TnxSqlSelection = class;

  TnxSqlGroupColumn = class(TnxSqlBaseColumn)
  private
    //FDescending: Boolean;
    //FIgnoreCase: Boolean;
    FCompareFlags: TnxSqlCompareFlags;
    FLocaleInt: Integer;
    //FNullBehaviour: TnxNullBehaviour;
    FCollationName: PTokenRecord;
    FCollationNameStr: string;
    function GetLCID: LCID;
    function GetCollationNameStr: string;
    procedure SetCollationNameStr(const Value: string);
  public
    property CollationName: PTokenRecord read FCollationName write FCollationName;
    property CollationNameStr: string read GetCollationNameStr write SetCollationNameStr;
    property CompareFlags: TnxSqlCompareFlags read FCompareFlags write FCompareFlags;
    //property Descending: Boolean read FDescending write FDescending;
    //property IgnoreCase: Boolean read FIgnoreCase write FIgnoreCase;
    property Locale: LCID read GetLCID;
    property LocaleInt: Integer read FLocaleInt write FLocaleInt;
    //property NullBehaviour: TnxNullBehaviour read FNullBehaviour write FNullBehaviour;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    function QualifiedName(Context: TnxSqlContext): string;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlGroupColumnList = class(TnxSqlNodeList)
  private
    function RefersTo(const aTableName, aColumnName: string): Boolean;
  public
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Contains(Context: TnxSqlContext; const aColName : string): Boolean; stdcall;
  end;

  TnxSqlOrderByScope = class(TnxObject)
  private
    FUnqualColumnList: TnxFastStringListIC;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure AddColumn(const ColumnName: string); overload;
    function FindColumn(const ColumnName: string; MustExist: Boolean = False): Integer; overload;
  end;

  TnxSqlSortedState = (ssUnordered, ssReversed, ssOrdered);

  TnxSqlJoinTableExp = class;

  PJoinFieldArray = ^TJoinFieldArray;
  TJoinFieldArray = array of TnxSqlFieldProxy;

  TVariantArray = array[0..255] of Variant;
  PVariantArray = ^TVariantArray;
  
  PDupRec = ^TDupRec;
  TDupRec = record
    Next: PDupRec;
    RecBuffer: TnxNullType;
  end;
  PUniqueJoinKeyEntry = ^TUniqueJoinKeyEntry;
  TUniqueJoinKeyEntry = record
    Next: PUniqueJoinKeyEntry;
    Dup: PDupRec;
    Matched: Boolean;
    { Now allocated dynamically:
      JoinValues: array of Variant;
      RecBuffer: PnxRecordBuffer;
    }
  end;
  PUniqueHashEntry = ^TUniqueHashEntry;
  TUniqueHashEntry = record
    Next: PUniqueHashEntry;
    Hash: DWord; {un-truncated hash value}
    FirstRec: PUniqueJoinKeyEntry;
  end;

  TnxSqlPoolManager = class(TnxObject)
  private
    InternalItemSize: DWord;
    PageSize: DWord;
    Root: Pointer;
    NextPage: Pointer;
    Next: Pointer;
    Top: Pointer;
    function Grow: Boolean;
  public
    constructor Create(ItemSize, MaxItemCount: DWord);
    destructor Destroy; override;
    function Alloc: Pointer;
  end;

  PHashTable = ^THashTable;
  THashTable = array[0..MaxHashSize-1] of PUniqueHashEntry;

  PFirstHashData = ^TFirstHashData;
  TFirstHashData = record
    HashEntryPool, KeyEntryPool, DupEntryPool: TnxSqlPoolManager;
    UniqueJoinKeyEntrySize,
    LoopCounter,
    FilterMatchCount: Integer;
    FirstJoinFilters: TList;
    JoinAttrCount: Integer;
    FirstJoinFields: PJoinFieldArray;
    FirstJoinFieldLocaleDescriptors: array of TnxLocaleDescriptor;
    HashSize: DWord;
    HashTable: PHashTable;
    FirstTable: TnxSqlTableProxy;
    HashKeyBuffer: Pointer;
    HashKeyBufferSize: Integer;
    BuildRangeForSecond: Boolean;
    First: Boolean;
    JoinRangeFieldIndex: Integer;
    LowValue, HighValue: variant;
    Success: Boolean;
  end;

  PSecondHashData = ^TSecondHashData;
  TSecondHashData = record
    LoopCounter,
    FilterMatchCount, WriteCount: Integer;
    SecondJoinFilters: TList;
    JoinAttrCount: Integer;
    SecondJoinFields: PJoinFieldArray;
    SecondJoinFieldLocaleDescriptors: array of TnxLocaleDescriptor;
    HashSize: DWord;
    HashTable: PHashTable;
    FirstTable,
    SecondTable: TnxSqlTableProxy;
    UserData: Pointer;
    //ValueEntry: TUniqueJoinKeyEntry;
    ValueEntry: PVariantArray;
    SecondPreserved: Boolean;
    HashKeyBuffer: Pointer;
    HashKeyBufferSize: Integer;
    Success: Boolean;
  end;

  TnxSqlOuterJoinMode = (jmNone, jmLeft, jmRight, jmFull);
  TnxSQLLeftRight = (lrLeft, lrRight);

  TnxSqlRowBuilder = class(TnxObject)
  private
    fOrderByDescriptor          : TnxIndexDescriptor;

    FSources                : TnxSqlRowRangeList;
    FTargetTable            : TnxSqlTableProxy;
    Level                   : integer;
    FOwnerStatement         : TnxSqlBlock;
    FDatabase               : TnxSqlDatabaseProxy;
    FRecordRead            : Int64;
    FieldCopier             : TnxSqlRecordCopier;
    //FSourceFieldExpression,
    //TargetFields            : TList;
    TargetFields            : array of TnxSqlFieldProxy;
    FJoinCondition          : TnxSqlCondExp;
    RecListL,
    RecListR,
    DupList                 : TnxNRecordHash;
    FirstCondTerm,
    LastCondTerm            : Boolean;
    OptimizeCalled          : Boolean;
    WasOptimized            : Boolean;
    RowHandler              : TnxSqlRowBuilderCallback;
    InnerRowHandler         : TnxSqlRowBuilderCallback;
    FCopyBlobs              : Boolean;
    FContext                : TnxSqlContext;
    Limit                   : Int64;
    LimitStart              : Int64;
    RecordsWritten          : Int64;
    LimitReached            : Boolean;
    ReadReversed            : Boolean;
    FLogFirstPassOnly       : Boolean;
    NotFirstPass            : Boolean;
    FOwnerSelect            : TnxSqlNode;
    FOwnerJoin              : TnxSqlJoinTableExp;
    FOuterJoinMode          : TnxSqlOuterJoinMode;
    fCheckedIndex           : integer;
    SourceFieldExpressions  : array of TnxSqlSimpleExpression;
    procedure AddIndex(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC);
    function CompareKeyRelations(Context: TnxSqlContext; const NewRel, BestRel: TnxSqlKeyRelation): Boolean;
    function CompareRelations(Context: TnxSqlContext; const R1, R2: TnxSqlRowRange): Boolean;
    function CreateResultRecord(Cookie: Pointer): Boolean;
    function OuterRowHandler(Cookie: Pointer): Boolean;
    function FindRelations(Context: TnxSqlContext; RestSources : TnxSqlRowRangeList; CondTerm: TnxSqlCondTerm;
      MoreThanOne: Boolean): Boolean;
    procedure DumpOrderedList(OrderedSources: TnxSqlRowRangeList; const Title: string);
    function FindRelation(Context: TnxSqlContext; Term: TnxSqlCondTerm; CurFactor,
          CurFactor2: TnxSqlCondFactor; Table : TnxSqlTableProxy;
          TargetField : TnxSqlFieldProxy;
      var Operator: TnxSqlRelOp;
      var ArgExpression: TnxSqlNode;
      var SameCase: Boolean;
      var IsNullTest: Boolean): TnxSqlCondFactor;
    function VerboseLogging: boolean;
    function NormalLogging: boolean;
    procedure LogVerbose(const S1: string; B1: Boolean); overload;
    procedure LogVerbose(const S1: string; I1: Integer); overload;
    procedure Indent;
    procedure Outdent;
    procedure Optimize(UseIndex: Boolean; Context: TnxSqlContext);
    function ProcessLevel(Cookie1: Pointer): Boolean;
    procedure ReadSources(UserData: Pointer);
    procedure ShowComparison(const K1, K2: TnxSqlKeyRelation);
    function WriteNull(Cookie: Pointer): Boolean;
    procedure DumpIndexMetrics;
    function TryToAddSuitableIndex: Boolean;
    {function TryToLimit(aCondExp: TnxSqlCondExp; aSource:TnxSqlRowRange): boolean;}
    function SetOrderByIndex(OrderByScope: TnxSqlOrderByScope): TnxSqlSortedState;
    procedure SetSortedState;
    procedure LogRelationDataVerbose(Relation: TnxSqlKeyRelation);
    procedure LogRelationDataNormal(Relation: TnxSqlKeyRelation); stdcall;
    function TestEqualRelation(
      aBestKeyRelationSoFar: TnxSqlKeyRelation;
      aTable : TnxSqlTableProxy;
      aIndexNames: array of string;
      aDependencyIndex: Integer;
      aRelationField : TnxSqlFieldProxy;
      aArgExp: TnxSqlNode;
      aCondTerm: TnxSqlCondTerm;
      aCondFactor: TnxSqlCondFactor;
      aIsNullTest: Boolean): TnxSqlKeyRelation;
    function TestNonEqualRelation(aBestKeyRelationSoFar: TnxSqlKeyRelation;
      aTable: TnxSqlTableProxy; aIndexNames: array of string;
      aDependencyIndex: Integer; aRelationField: TnxSqlFieldProxy;
      aArgExp: TnxSqlNode; aOperator: TnxSqlRelOp;
      aCondTerm: TnxSqlCondTerm;
      aCondFactor: TnxSqlCondFactor): TnxSqlKeyRelation;
    function SortWillMatch(aIndex: PnxInt32 = nil): TnxSqlSortedState; stdcall;
    function ExecuteBinaryMergeJoin(
      JoinMode: TnxSqlOuterJoinMode;
      JoinFactors, JoinFiltersT1, JoinFiltersT2: TList;
      var RecordsRead: Integer): Boolean;
    function ExecuteBinaryHashJoin(
      JoinMode: TnxSqlOuterJoinMode;
      JoinFactors, JoinFiltersT1, JoinFiltersT2: TList;
      var RecordsRead: Integer;
      UserData: Pointer): Boolean;
    function GetDrivingTable(Range1, Range2: TnxSqlRowRange; JoinFilters1, JoinFilters2: TList; Context: TnxSqlContext): TnxSQLLeftRight;
    function ApplyFilterRange(Source: TnxSqlTableProxy;
      JoinFilters: TList): Boolean;
    function CanJoinViaIndex(Source: TnxSqlTableProxy;
      JoinFields: array of TnxSqlFieldProxy;
      SwitchTo: Boolean;
      MustBeForward: Boolean;
      var IsUnique: Boolean): Boolean;
    function MergeJoin(UseIndex: Boolean; LoopProc: TnxSqlRowBuilderCallback;
      OuterJoinMode: TnxSqlOuterJoinMode; UserData: Pointer; var RecordsRead: Integer): Boolean;
    function HashJoin(UseIndex: Boolean; LoopProc: TnxSqlRowBuilderCallback;
      OuterJoinMode: TnxSqlOuterJoinMode; UserData: Pointer; var RecordsRead: Integer): Boolean;
    function FirstHash(aCookie: Pointer): Boolean;
    procedure AddFirstToHash(FirstHashData: PFirstHashData);
    function SecondHash(aCookie: Pointer): Boolean;
    function WriteMatching(SecondHashData: PSecondHashData): Boolean;
    function LookupFromSecond(
      SecondHashData: PSecondHashData): PUniqueJoinKeyEntry; stdcall;
    procedure WriteMismatchedSecond(SecondHashData: PSecondHashData);
    function FullyOptimized: Boolean;
    {procedure AddColumn(SourceExpression: TnxSqlSimpleExpression;
      SourceField, TargetField: TnxSqlFieldProxy);}
    {procedure DumpTable(T: TnxSqlTableProxy);
    procedure DumpRecord(T: TnxSqlTableProxy);}
    {procedure LogVar(const V: variant);}
    procedure GetGlobalFilter(aTable: TnxSQLTableProxy; aFilterList: TList); stdcall;
    procedure GetGlobalJoinFilters(TL: TnxSqlTableProxy; TR: TnxSqlTableProxy; JoinFiltersT1: TList; JoinFiltersT2: TList; JoinFactors: TList); stdcall;
    function CalcEstimatedRangeCount(RowRange: TnxSqlRowRange; Filters: TList; UseGlobalFilters: Boolean): Cardinal; overload;
//    function CalcEstimatedRangeCount(RowRange: TnxSqlRowRange; Filters: TList): Cardinal; overload;
//    function CalcEstimatedRangeCount(RowRange: TnxSqlRowRange): Cardinal; overload;
    procedure FullTextIterate(Context: TnxSqlContext; Table: TnxSqlTableProxy; UserData: Pointer); stdcall;
    procedure TextEntryIterate(const RefNr: int64; UserData: Pointer);
    function IndexIterator(aCookie: Pointer;
      const RefId: int64; aKey: PnxKeyBuffer): Boolean;
    function HaveJoinRangeIndex(const FirstJoinFields  : array of TnxSqlFieldProxy;
                                      Source           : TnxSqlTableProxy;
                                const SecondJoinFields : array of TnxSqlFieldProxy;
                                  var JoinFieldIndex   : Integer;
                                  var IndexName        : string)
                                                       : Boolean;
    procedure ApplyJoinRange(Table: TnxSqlTableProxy;
      const IndexName: string; const LowRangeValue,
      HighRangeValue: variant);
    procedure PermutateAddIndex(T: TnxSqlTableProxy;
      FieldList: TnxFastStringListIC);
//    procedure Visit(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC; Map: array of Integer; k: Integer; var id: Integer);
    procedure BuildCompareDictionary(JoinFields: array of TnxSqlFieldProxy; var CompFieldCount: Integer; var CompareDictionary: TnxDataDictionary; Direct: Boolean; var CompareEngine: TnxBaseKeyEngine; Temp: TnxSqlTableProxy);
    //procedure ClearBindings(Node: TnxSqlNode; UserData: TObject);
    procedure SetOrderByDescriptor(value: TnxIndexDescriptor);
  public
    OrderByScope               : TnxSqlOrderByScope;
    SortedState                : TnxSqlSortedState;
    LimitDependsOnMatchingSort : Boolean;
    ContainsSearch             : TnxSqlCPContains;
    property OrderByDescriptor: TnxIndexDescriptor read fOrderByDescriptor write SetOrderByDescriptor;
    procedure AddColumnField(
     SourceField : TnxSqlFieldProxy;
      TargetField: TnxSqlFieldProxy);
    procedure AddColumnExpression(
     SourceExpression: TnxSqlSimpleExpression;
      TargetField: TnxSqlFieldProxy);
    procedure ClearColumnList;
    procedure CopyBackKeyRelations;
    constructor Create(Context: TnxSqlContext; aOwnerSelect: TnxSqlNode; aOwnerJoin: TnxSqlJoinTableExp; aDatabase: TnxSqlDatabaseProxy; aOwnerStatement: TnxSqlBlock; aCondExp: TnxSqlCondExp;
      aCopyBlobs: Boolean; aLogFirstPassOnly: Boolean);
    destructor Destroy; override;
    procedure Execute(aContext: TnxSqlContext; UseIndex: Boolean; LoopProc: TnxSqlRowBuilderCallback;
      OuterJoinMode: TnxSqlOuterJoinMode; UserData: Pointer; var RecordsRead: Integer);
    property JoinCondition : TnxSqlCondExp read FJoinCondition write FJoinCondition;
    procedure LogNormal(const S: string); overload;
    procedure LogVerbose(const S: string); overload;
    //property SourceFieldExpression: TList read FSourceFieldExpression;
    property Sources : TnxSqlRowRangeList read FSources;
    property TargetTable : TnxSqlTableProxy read FTargetTable write FTargetTable;
  end;

  TnxSqlUsingItem = class(TnxSqlNode)
  private
    function GetColumnNameStr: string;
    procedure SetColumnNameStr(const Value: string);
  private
    FColumnName: PTokenRecord;
    FColumnNameStr: string;
  public
    property ColumnName: PTokenRecord read FColumnName write FColumnName;
    property ColumnNameStr: string read GetColumnNameStr write SetColumnNameStr;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
  end;

  TnxSqlUsingList = class(TnxSqlNodeList)
  private
    function GetItem(Index: Integer): TnxSqlUsingItem;
    function RefersTo(const aTableName, aColumnName: string): Boolean;
  public
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function ReferencesFieldName(const aName: String): boolean; {virtual;} stdcall;
    property Item[Index: Integer]: TnxSqlUsingItem read GetItem; default;
  end;

  TnxSqlTableRefresher = procedure(Context: TnxSqlContext) of object;

  TnxSqlSELECT = class;

  TnxSQLJoinColumns = class(TnxFastStringListIC)
  protected
    expressions: TnxList;
  public
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure FreeExpressions;
    constructor Create;
    destructor Destroy; override;
  end;

  TnxSqlJoinTableExp = class(TnxSqlLockNode)
  private
    sjteRequestClose: InxRequestCloseHandlerEvent;
    FTableRef1: TnxSqlTableRef;
    FTableRef2: TnxSqlTableRef;
    FCondExp: TnxSqlCondExp;
    FJoinType: TnxSqlJoinType;
    FNatural: Boolean;
    Bound: Boolean;
    Binding: Boolean;
    TL2, TR2 : TnxSqlTableProxy;
    TL2Monitor, TR2Monitor : InxLifetimeMonitorRef;
    RL, RR : TnxSqlTableRefresher;
    Columns: TnxSQLJoinColumns;
    FRowBuilder : TnxSqlRowBuilder;
    FUsingList: TnxSqlUsingList;
    UsingCondExp: TnxSqlCondExp;
    FResultTable : TnxSqlTableProxy;
    HaveData: Boolean;
    FIsDependent: Boolean;
    fHasMetatable: Boolean;
    fHaveCheckedMetaTables: Boolean;
    SelectionFieldRefs: TList;
    FLastContext : TnxSqlContext;
    FLastContextID : Integer;
    FLastGeneration: Integer;
    FLastRecordsRead: Int64;
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function DoWork(NeedData: Boolean; Context: TnxSqlContext; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
    procedure Bind(Context: TnxSqlContext);
    procedure ClearBindings(Node: TnxSqlNode; UserData: TObject);
    procedure ClearColumns;
    function DoJoin(NeedData: Boolean; Context: TnxSqlContext; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
    procedure IterateSelectionFields(Node: TnxSqlNode; UserData: TObject);
    function BuildSimpleFieldExpr(AOwner: TnxSqlNode; const ATableName,
      AFieldName: string;
      AField: TnxSqlFieldProxy): TnxSqlSimpleExpression;
    procedure EnsureResultTable(NeedData: Boolean; Context: TnxSqlContext; Select: TnxSqlSELECT);
    function BindFieldDown(const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; Context: TnxSqlContext; var ColumnAlias: string): TnxSqlFieldProxy;
    function TargetFieldFromSourceField(
      const F: TnxSqlFieldProxy; Context: TnxSqlContext): TnxSqlFieldProxy;
    procedure OnRequestClose(Sender: TObject);
    procedure SetTableRef1(const Value: TnxSqlTableRef);
    procedure SetTableRef2(const Value: TnxSqlTableRef);
    function GetRefresh: TnxSqlTableRefresher;
    function IsColumnReferenced(aTableName, aTableAlias, aFieldName: String; Context: TnxSQLContext): Boolean;
    procedure DoRefresh(aContext: TnxSqlContext);
    function IsPSM: Boolean;
    procedure MetaTableChecker(Node: TnxSQLNode; UserData: TObject);
  public
    function HasMetaTableBase: Boolean;
    property CondExp: TnxSqlCondExp read FCondExp write FCondExp;
    property JoinType: TnxSqlJoinType read FJoinType write FJoinType;
    property Natural: Boolean read FNatural write FNatural;
    property UsingList  :  TnxSqlUsingList read FUsingList write FUsingList;
    property TableRef1: TnxSqlTableRef read FTableRef1 write SetTableRef1;
    property TableRef2: TnxSqlTableRef read FTableRef2 write SetTableRef2;

    property Refresh: TnxSqlTableRefresher read GetRefresh;
    property RowBuilder : TnxSqlRowBuilder read FRowBuilder;

    procedure Clear;
    function DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
    procedure Execute(Context: TnxSqlContext; var aLiveResult: Boolean;
      var aCursor: TnxAbstractCursor; var RecordsRead: Integer);
    function GetFieldsFromTable(const TableName: string; List: TList; Context: TnxSqlContext):
      TnxSqlTableProxy;
    function GetResultTable(Context: TnxSqlContext): TnxSqlTableProxy;
    function IsAmbiguousColumn(const ColumnName: string): Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function RefersToTemp: Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    procedure Unbind;

    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;

    procedure Assign(const Source: TnxSqlNode); override;
    function BindColumn(Context: TnxSqlContext; aInAggregate: Boolean; const DatabaseName, TableName, ColumnName, SourceLoc: string;
      BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean; MustSucceed: Boolean = True): TnxSqlFieldProxy; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
  end;

  TnxSqlNonJoinTableTerm = class;

  TnxSqlOrderColumn = class(TnxSqlBaseColumn)
  public
    function AllColumnReferencesQualified(
      const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
    function QualifiedName: string; stdcall;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    function ToString: WideString; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
  end;

  TnxSqlOrderItem = class(TnxSqlNode)
  private
    FColumn: TnxSqlOrderColumn;
    FCollationNameStr: string;
    FIndex: Integer;
    FDescending: Boolean;
    FCompareFlags: TnxSqlCompareFlags;
    FIgnoreCase: Boolean;
    FLocaleInt: Integer;
    FNullBehaviour: TnxNullBehaviour;
    FCollationName: PTokenRecord;
    function GetLCID: LCID;
    function GetCollationNameStr: string;
    procedure SetCollationNameStr(const Value: string);
  public
    property CollationName: PTokenRecord read FCollationName write FCollationName;
    property CollationNameStr: string read GetCollationNameStr write SetCollationNameStr;
    property Column: TnxSqlOrderColumn read FColumn write FColumn;
    property Descending: Boolean read FDescending write FDescending;
    property Index: Integer read FIndex write FIndex;
    property IgnoreCase: Boolean read FIgnoreCase write FIgnoreCase;
    property CompareFlags: TnxSqlCompareFlags read FCompareFlags write FCompareFlags;
    property Locale: LCID read GetLCID;
    property LocaleInt: Integer read FLocaleInt write FLocaleInt;
    property NullBehaviour: TnxNullBehaviour read FNullBehaviour write FNullBehaviour;

    destructor Destroy; override;

    function AllColumnReferencesQualified(
      const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlOrderList = class(TnxSqlNodeList)
  private
    function GetItem(Index: Integer): TnxSqlOrderItem;
  public
    function RefersTo(const aTableName, aColumnName: string): Boolean;
    function AllColumnReferencesQualified(const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    property Item[Index: Integer]: TnxSqlOrderItem read GetItem; default;
  end;

  TnxSqlNonJoinTableExp = class(TnxSqlLockNode)
  private
    FNonJoinTableTerm: TnxSqlNonJoinTableTerm;
    //fResultTable: TnxSQLTableProxy;
    function DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
    function TargetFieldFromSourceField(Context: TnxSqlContext;
      const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
    function GetRefresh: TnxSqlTableRefresher;
    function GetTheResultTable: TnxSQLTableProxy;
  public
    procedure EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean);
    property NonJoinTableTerm:  TnxSqlNonJoinTableTerm read FNonJoinTableTerm write FNonJoinTableTerm;
    property Refresh: TnxSqlTableRefresher read GetRefresh;
    destructor Destroy; override;

    procedure Clear;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
    function EvaluateFirst(Context: TnxSqlContext): variant;
    function WhereIsValidFilterStatement: Boolean;
    procedure BindWhere(aContext: TnxSqlContext); 
    procedure Execute(aContext: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor; var RecordsRead: Integer);
    function GetFieldsFromTable(const TableName: string; List: TList): TnxSqlTableProxy;
    function IsOrdered: Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsSelectInto: Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function RefersToTemp: Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    function GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;

    procedure Unbind;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    property ResultTable: TnxSQLTableProxy read GetTheResultTable;
  end;

  TnxSqlValueListList = class;

  TnxSqlNonJoinTablePrimary = class(TnxSqlLockNode)
  private
    FExecStatement: TnxSqlRootNode;
    FSelectSt: TnxSqlSELECT;
    FNonJoinTableExp:  TnxSqlNonJoinTableExp;
    FAll: Boolean;
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
    procedure EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean{; aOrderList: TnxSqlOrderList});
    function BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
    function TargetFieldFromSourceField(Context: TnxSqlContext;
      const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
    function GetRefreh: TnxSqlTableRefresher;
  public
    property ExecStatement: TnxSqlRootNode read FExecStatement write FExecStatement;
    property NonJoinTableExp: TnxSqlNonJoinTableExp read FNonJoinTableExp write FNonJoinTableExp;
    property SelectSt:  TnxSqlSELECT read FSelectSt write FSelectSt;
    property All: Boolean read FAll write FAll; {when part of an intersection expression}

    property Refresh: TnxSqlTableRefresher read GetRefreh;

    destructor Destroy; override;

    procedure BindWhere(aContext: TnxSqlContext);
    procedure Clear;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
    function EvaluateFirst(Context: TnxSqlContext): variant;
    function GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
    function IsOrdered: Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsSelectInto: Boolean;
    procedure Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor; var RecordsRead: Integer);
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function RefersToTemp: Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    procedure Unbind;
    function WhereIsValidFilterStatement: Boolean;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlSetOp = (soUnion, soExcept{, soIntersect});
  TnxSqlNonJoinTableTerm = class(TnxSqlLockNode)
  private
    FNonJoinTablePrimary: TnxSqlNonJoinTablePrimary;
    FAll: Boolean;
    FSetOp: TnxSqlSetOp;
    FSetPrimaries: TList;
    FResultTable: TnxSqlTableProxy;
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
    procedure EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean{; aOrderList: TnxSqlOrderList});
    function BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
    function TargetFieldFromSourceField(Context: TnxSqlContext;
      const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
    function GetSetPrimariesCount: Integer;
    function GetSetPrimary(Index: Integer): TnxSqlNonJoinTablePrimary;
    function DoIntersect(Context: TnxSqlContext): TnxSqlTableProxy;
    function GetRefresh: TnxSqlTableRefresher;
  public
    property NonJoinTablePrimary:  TnxSqlNonJoinTablePrimary read FNonJoinTablePrimary write FNonJoinTablePrimary;
    property All: Boolean // when part of a set operation
      read FAll write FAll;
    property SetOp: TnxSqlSetOp read FSetOp write FSetOp; // when part of a set operation

    property Refresh: TnxSqlTableRefresher read GetRefresh;
    property SetPrimariesCount: Integer read GetSetPrimariesCount;
    property SetPrimary[Index: Integer]: TnxSqlNonJoinTablePrimary read GetSetPrimary;

    destructor Destroy; override;

    procedure AddSetPrimary(aSetPrimary: TnxSqlNonJoinTablePrimary; aAll: Boolean); overload;
    procedure AddSetPrimary(aSetPrimary: TnxSqlNonJoinTablePrimary); overload;
    procedure Clear;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
    function EvaluateFirst(Context: TnxSqlContext): variant;
    function WhereIsValidFilterStatement: Boolean;
    procedure BindWhere(aContext: TnxSqlContext);
    procedure Execute(Context: TnxSqlContext;
      var aLiveResult: Boolean; var aCursor: TnxAbstractCursor; var RecordsRead: Integer);
    function GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
    function IsOrdered: Boolean;
    function IsSelectInto: Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsView: Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function RefersToTemp: Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    procedure Unbind;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlAggregateList = class(TnxSqlNodeList)
  private
    function GetItem(Index: Integer): TnxSqlAggregate;
  public
    function NeedToReadRecords(Context: TnxSqlContext): Boolean; stdcall;

    property Item[Index: Integer]: TnxSqlAggregate read GetItem; default;
  end;

  TnxSqlTableRefList = class;
  TnxSqlSelectionList = class;
  TnxSqlTableExp = class;

  TnxInternalTableRef = class(TnxObject)
  protected
    fIsJoinResult: Boolean;
    fTableInternal: TnxSqlTableProxy;
    FRefresh: TnxSqlTableRefresher;
    procedure TableDestroyed(sender: TObject); 
    procedure SetIsJoinResult(const Value: Boolean);
  public
    DatabaseName: string;
    Name: string;
    TableRef2: TnxSqlTableRef;
    TableExp: TnxSqlTableExp;
    UnNamed: Boolean;
    property IsJoinResult: Boolean read fIsJoinResult write SetIsJoinResult;
    constructor Create(const aDatabaseName, aName: string; aTableRef: TnxSqlTableRef;
      aTable: TnxSqlTableProxy; aUnnamed, aTakeOwnership: Boolean; aRefresh: TnxSqlTableRefresher;
        aTableExp: TnxSqlTableExp);
    destructor Destroy; override;
    procedure Refresh(aContext: TnxSqlContext);
    procedure SetTable(aTable: TnxSQLTableProxy; freeOld: boolean=false);
    {function GetTable(Context: TnxSqlContext; aOwner: TObject; aOpenMode: TnxSqlOpenmode): TnxSqlTableProxy;
    function GetResultTable(Context: TnxSqlContext): TnxSqlTableProxy;}
    property Table: TnxSqlTableProxy read fTableInternal;
  end;

  TnxInternalTableRefList = class(TnxObject)
  private
    function GetItem(Index: Integer): TnxInternalTableRef;
  private
    FList: TList;
  public
    destructor Destroy; override;
    function Add(ITR: TnxInternalTableRef): Integer;
    function FindTableRef(const DatabaseName, TableName: string;
      Context: TnxSQLContext): TnxSQLTableRef; stdcall;
    function Count: Integer;
    property Item[Index: Integer]: TnxInternalTableRef read GetItem; default;
    function IndexOf(const DatabaseName, TableName: string): Integer;
    procedure Clear;
  end;

  TnxSqlVolatile = (svUnchecked, svNo, svContext, svGeneration, svRecord, svAlways);

  TnxSqlSELECT = class(TnxSqlColumnListOwner)
  private
    ssRequestClose : InxRequestCloseHandlerEvent;
    fSetRangeCount: integer;
    FSelectStarFromSingleTable: Boolean;
    FDistinct : Boolean;
    FSpecialDistinct: Boolean;
    FSelectionList : TnxSqlSelectionList;
    FTableRefList : TnxSqlTableRefList;
    FGroupColumnList : TnxSqlGroupColumnList;
    FCondExpWhere: TnxSqlCondExp;
    FCondExpHaving: TnxSqlCondExp;
    FOrderList : TnxSqlOrderList;
    FLimitInt: Integer;
    FLimitStart: Integer;
    FLimitPercent: Boolean;
    FResultTable : TnxSqlTableProxy;
    TablesReferencedByOrder : TnxInternalTableRefList;
    TableAliases : TnxFastStringListIC;
    FHaveAggregates : Boolean;
    FIsDependent: Boolean;
    FRowBuilder : TnxSqlRowBuilder;
    FInWhere: Boolean;
    HaveData: Boolean;
    RequestLive: Boolean;
    TypeKnown: Boolean;
    FType: TnxFieldType;
    FDecimals: Integer;
    FSize: Integer;
    FTargetTableStr: string;
    FTargetTable: PTokenRecord;
    FTargetDatabase: PTokenRecord;
    FTargetDatabaseStr: string;
    BindingDown: Boolean;
    FSpecialInSubquery: Boolean;
    FOrderByScope: TnxSqlOrderByScope;
    FRefersToContextVars,
    FContextVarsChecked: Boolean;
    InGlobalAggregatedQuery: Boolean;
    OldIteratorValue: PnxKeyBuffer;
    BindingContext: TnxSqlContext;
    fOrigSelectionList: TnxSqlSelectionList;
    FFixedLimitInt: Integer;
    FFixedLimitStart: Integer;
    fLimitIntFactor: TnxSqlFacParm;
    fLimitIntExp: TnxSqlSimpleExpression;
    fLimitStartFactor: TnxSqlFacParm;
    fLimitStartExp: TnxSqlSimpleExpression;

    FVolatile: TnxSqlVolatile;

    FLastContext : TnxSqlContext;
    FLastContextID: Integer;
    FLastGeneration: Integer;
    FLastRecordsRead: Int64;

    //IterateRecordBuffer: PnxRecordBuffer;

    procedure AddTableFields(Context: TnxSQLContext; Table : TnxSqlTableProxy;
                       StartPoint : Integer;
                             FieldRef : TnxSqlFieldRef);
    {procedure AddTableFieldsFromList(Table : TnxSqlTableProxy;
                                const StartPoint : Integer;
                                      FieldRef : TnxSqlFieldRef;
                                      List: TList);}
    procedure AddTableRefs(Node: TnxSqlNode; UserData: TObject);
    procedure AddColumns(Node: TnxSqlNode; UserData: TObject);
    function GlobalAggregateQueryResult(Context: TnxSqlContext; NeedData: Boolean; var RecordsRead: Integer; Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
    function GroupedAggregateQueryResult(Context: TnxSqlContext; NeedData: Boolean; var RecordsRead: Integer; Recycle: TnxSqlTableProxy): TnxSqlTableProxy; stdcall;
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function BuildGroupByIndexDesc(Context: TObject; Dict: TnxBaseTableDescriptor; ResolveColumn: TnxSqlColumnResolver;
      const Casesensitive, IgnoreComposites: Boolean; BuildStandalone: Boolean = true): TnxIndexDescriptor;
    function BuildOrderByIndex(Context: TObject; Dict: TnxBaseTableDescriptor; ResolveColumn: TnxSqlColumnResolver;
      const Casesensitive, IgnoreComposites: Boolean; BuildStandalone: Boolean = true): TnxIndexDescriptor;
    function BuildSingleColumnIndexDesc(Field: TnxSqlFieldProxy; Descending: Boolean): TnxIndexDescriptor;
    procedure Clear;
    procedure ClearBindings(Node: TnxSqlNode; UserData: TObject);
    function CopyGrouped(T: TnxSqlTableProxy; Context: TnxSqlContext;
      SourceFields: TList; AggExpList: TList; AggList: TnxSqlAggregateList;
      aFieldDefList: TnxSqlFieldDefList{; var Mapping: TList}): TnxSqlTableProxy;
    function CalcAggregates(T: TnxSqlTableProxy; Context: TnxSqlContext; AggList: TnxSqlAggregateList): TnxSqlTableProxy;
    function DoAggOrderBy(Context: TObject; T: TnxSqlTableProxy; const NeedData : Boolean): TnxSqlTableProxy;
    //function DoHaving(T: TnxSqlTableProxy; Context: TnxSqlContext): TnxSqlTableProxy;
    procedure DoLimit({var }Table: TnxSqlTableProxy);
    {function} procedure DoSortOnAll(T: TnxSqlTableProxy){: TnxSqlTableProxy};
    function BuildGroupingTable(Context: TnxSqlContext; GroupColumnsIn : Integer;
      SourceFields: TList; AggList: TnxSqlAggregateList; var aFieldDefList: TnxSqlFieldDefList): TnxSqlTableProxy;
    function BuildAggResultTable(Context: TnxSqlContext; AggList: TnxSqlAggregateList): TnxsqlTableProxy;
    procedure {function} BuildAggList(Context: TnxSqlContext; var aAggList: TnxSQLAggregateList){: boolean};
    procedure DoOrderBy(Context: TObject; Table: TnxSqlTableProxy);
    procedure DoCheckAggregates(Context: TnxSqlContext; Flag: Boolean = true); stdcall;
    //procedure ResetStatic(Node: TnxSqlNode; UserData: TObject);
    function GetTargetTableStr: string;
    procedure SetTargetTableStr(const Value: string);
    function GetTargetDatabaseStr: string;
    procedure SetTargetDatabaseStr(const Value: string);
    function FindImplicitOrderByColumns: TnxFastStringListIC;
    procedure FlagAggregates(Node: TnxSqlNode; UserData: TObject);
    procedure EnumAggregates(Node: TnxSqlNode; UserData: TObject);
    procedure ExpandWildcards(Context: TnxSqlContext);
    //function CheckHaving(Context: TObject): Boolean;
    function DoWork(Context: TnxSqlContext; NeedData: Boolean; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy; QuitAfterFirst: Boolean): TnxSqlTableProxy;
    procedure UnbindIfRequired(Context: TnxSqlContext);
    procedure EnsureResultTable(Context: TnxSqlContext; NeedData, QuitAfterFirst: Boolean);
    procedure ClearTableList;
    function OnlyStraightAggregates(AggList: TnxSqlAggregateList): Boolean;
    function IsPSM: Boolean;
    function IsPSMLoop: Boolean;
    function IsSubQuery: Boolean;
    //function IsSingletableStarSelection(var TableName: string): Boolean;
    function CanUseIndexIterator(Context: TnxSqlContext; AggList: TnxSqlAggregateList; var IndexIndex: integer;
      var IndexNames: TnxSQLStringArray; var anEngine: TnxBaseKeyEngine; var aTable: TnxSQLTableProxy;
      var aDescriptor: TnxIndexDEscriptor; FieldDefList: TnxSqlFieldDefList): boolean;
    function NormalQueryResult(Context: TnxSqlContext; NeedData: Boolean; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy; QuitAfterFirst: Boolean; AggList: TnxSqlAggregateList = nil): TnxSqlTableProxy;
    procedure OnRequestClose(Sender: TObject);
     function StraightGlobalAggregates(Context: TnxSqlContext;
      NeedData: Boolean; AggList: TnxSqlAggregateList; Recycle: TnxSqlTableProxy;
      var RecordsRead: Integer): TnxSqlTableProxy;
    function TargetFieldFromSourceField(Context: TnxSqlContext; const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
    function TableWithCount(const ColumnName : string; Negate: Boolean; Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
    function UpdateAggregateCounters(Cookie: Pointer): Boolean;
    function ResolveColumn(Context: TObject; Dict: TnxBaseTableDescriptor; const QualifiedName: string): Integer;
    function ResolveGroupColumn(Context: TObject; Dict: TnxBaseTableDescriptor; const QualifiedName: string): Integer;
    function DoLive(Context: TnxSqlContext; var OutputTable: TnxSqlTableProxy): Boolean;
    procedure Rebind(Node: TnxSqlNode; UserData: TObject);
    procedure CheckContextVars(Context: TnxSqlContext);
    function GetRefresh: TnxSqlTableRefresher;
    procedure DoRefresh(aContext: TnxSqlContext);
    function ScanForValue(Cookie: Pointer): Boolean;
    function Grouper(Cookie: Pointer): Boolean;
    procedure WriteGroup(Cookie: Pointer);
    function LastSelectInBlock: Boolean;
    function UniqueKeyIterator(aCookie: Pointer; aRefNr: TnxRefNr; aKey: PnxKeyBuffer): TnxKeyIteratorResult;
   { function UniqueRecordIterator(aCookie: Pointer; aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;}
    function HasSubQuery: Boolean;
    function AliasFromFieldName(aTable: TnxSQLTableProxy; const aFieldName: String): String; stdcall;
    procedure DoCheckValidSelection(Context: TnxSqlContext); stdcall;
    function CalcAggIterator(aCookie: Pointer): Boolean;
    function CreateNewSelectionItem(const aTableName, aColumnName: String;
      aField: TnxSQLFieldProxy; NotQualifiable: boolean = false): TnxSqlSelection;
    procedure FillFieldDefList(FieldDefList: TnxSqlFieldDefList; Context: TnxSqlContext); stdcall;
    procedure EnumOuterAggregates(Node: TnxSqlNode; UserData: TObject);
    procedure ReportNonScalarError(const Result: Variant);
    procedure ReportNonSingleValueError;
    procedure DoSystemRow(Result: TnxSqlTableProxy);
    function HasSelectionSubQuery: Boolean;
    function GetLimitInt: Integer;
    procedure SetLimitInt(const Value: Integer);
    procedure SetLimitPercent(const Value: Boolean);
    procedure SetLimitStart(const Value: Integer);
    procedure SetLimitIntExp(const Value: TnxSqlSimpleExpression);
    procedure SetLimitIntFactor(const Value: TnxSqlFacParm);
    procedure SetLimitStartExp(const Value: TnxSqlSimpleExpression);
    procedure SetLimitStartFactor(const Value: TnxSqlFacParm);
  protected
    function GetVersion: integer; override;
  public
    Bound    : Integer;
    BoundGen : Integer;
    Binding  : Boolean;
    property LimitIntFactor: TnxSqlFacParm read fLimitIntFactor write SetLimitIntFactor;
    property LimitStartFactor: TnxSqlFacParm read fLimitStartFactor write SetLimitStartFactor;
    property LimitIntExp: TnxSqlSimpleExpression read fLimitIntExp write SetLimitIntExp;
    property LimitStartExp: TnxSqlSimpleExpression read fLimitStartExp write SetLimitStartExp;

    property CondExpHaving : TnxSqlCondExp read FCondExpHaving write FCondExpHaving;
    property CondExpWhere : TnxSqlCondExp read FCondExpWhere write FCondExpWhere;
    property Distinct: Boolean read FDistinct write FDistinct;
    property GroupColumnList : TnxSqlGroupColumnList read FGroupColumnList write FGroupColumnList;
    property FixedLimitInt: Integer read FFixedLimitInt write FFixedLimitInt;
    property FixedLimitStart: Integer read FFixedLimitStart write FFixedLimitStart;
    property LimitInt: Integer read GetLimitInt write SetLimitInt;
    property LimitPercent: Boolean read FLimitPercent write SetLimitPercent;
    property LimitStart: Integer read FLimitStart write SetLimitStart;
    property OrderList : TnxSqlOrderList read FOrderList write FOrderList;
    property SelectionList : TnxSqlSelectionList read FSelectionList write FSelectionList;
    property TableRefList : TnxSqlTableRefList read FTableRefList write FTableRefList;
    property TargetTable: PTokenRecord read FTargetTable write FTargetTable;
    property TargetTablestr: string read GetTargetTableStr write SetTargetTableStr;
    property TargetDatabase: PTokenRecord read FTargetDatabase write FTargetDatabase;
    property TargetDatabasestr: string read GetTargetDatabaseStr write SetTargetDatabaseStr;

    property HaveAggregates: Boolean read FHaveAggregates write FHaveAggregates;
    property InWhere: Boolean read FInWhere write FInWhere;
    property IsDependent: Boolean read FIsDependent;
    property Refresh: TnxSqlTableRefresher read GetRefresh;
    property RowBuilder : TnxSqlRowBuilder read FRowBuilder;
    property SpecialInSubquery: Boolean read FSpecialInSubquery write FSpecialInSubquery;
    property SpecialDistinct: Boolean read FSpecialDistinct write FSpecialDistinct;
    property ResultTable: TnxSQLTableProxy read FResultTable;

    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;

    function Volatile(Context: TnxSQLContext): Boolean;
    function AllColumnReferencesQualified(const AliasName: string;
      var QualRefList: TnxFastStringListIC): Boolean;
    function CheckAllValues(Context: TnxSqlContext; RelOp: TnxSqlRelOp; const Val: Variant): Variant;
    function CheckAnyValue(Context: TnxSqlContext; RelOp: TnxSqlRelOp; const Val: Variant): Variant;
    function CheckForValue(Context: TnxSqlContext; const Value: Variant; aPadSpace: Boolean):Boolean; register;
    function CheckNonEmpty(Context: TnxSqlContext): Boolean;
    function GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
    function GetLocale(Context: TnxSqlContext): DWord;
    function GetLocaleDesc(Context: TnxSqlContext): TnxLocaleDescriptor;
    function GetCodepage: Integer;
    function GetValue(Context: TnxSqlContext): Variant;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsSelection: Boolean;
    function IsView: Boolean;
    function Match(Context: TnxSqlContext; const Value: Variant; Unique: Boolean; MatchOption: TnxSqlMatchOption): Boolean;
    procedure MatchType(Context: TnxSqlContext; ExpectedType: TnxFieldType; AllowMultiple: Boolean);
    function RefersToContextVars(Context: TnxSqlContext): Boolean; override;
    function RefersToTemp: Boolean;

    procedure Assign(const Source: TnxSqlNode); override;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); override;
    function BindColumn(Context: TnxSqlContext; aInAggregate: Boolean; const DatabaseName, TableName, ColumnName, SourceLoc: string;
      BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean; MustSucceed: Boolean = True): TnxSqlFieldProxy; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool; override;
    function EvaluateFirst(Context: TnxSqlContext): variant; override;
    function IsCorrelatedSubquery(Context: TnxSqlContext): Boolean;
    function WhereIsValidFilterStatement: Boolean; override;
    procedure BindWhere(aContext: TnxSqlContext); override;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor; var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult; override;
    function FindField(Context: TnxSqlContext; const FieldName, SourceLoc: string): TnxSqlFieldProxy;
    function GetDecimals(Context: TnxSqlContext): Integer; override;
    function GetSize(Context: TnxSqlContext): Integer; override;
    function GetType(Context: TnxSqlContext): TnxFieldType; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure ParametersChanged; override;
    function RefersTo(const aTableName: string): Boolean; override;
    function RefersTo2(const aTableName, aColumnName: string): Boolean; override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function Simplify(Context: TnxSqlContext): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    procedure Unbind; override;
  protected
    fIsUniqueKeyIteration: boolean;
    fFirstSimplify: Boolean;
    TablesAdded: TList;
//    fRealTableOrder: TnxFastStringListIC;
  end;

  PnxSqlKeyIterateInfo = ^TnxSqlKeyIterateInfo;
  TnxSqlKeyIterateInfo = record
    Context: TnxSqlContext;
    KeyEngine: TnxBaseKeyEngine;
    BaseTable: TnxSQLTableProxy;
    IndexIndex: integer;
    DestinationTable: TnxSQLTableProxy;
    IndexDescriptor: TnxIndexDescriptor;
    //AggList2: TnxSqlAggregateList;
    AggArray: array of TnxSqlAggregate;
    AggArrayCount: Integer;
    LastField: integer;
    LoopProc: TnxSqlRowBuilderCallback;
    FieldsDescriptor: TnxFieldsDescriptor;
    FieldDefList: TnxSqlFieldDefList;
    Expressions: array of TnxSQLSimpleExpression;
    SourceFieldNames: array of string;
    SourceFieldKeyIndices: array of integer;
    SourceFieldKeyOffsets: array of integer;
  end;

  TnxSqlSelection = class(TnxSqlColumnDefiner)
  private
    FColumn: TnxSqlColumn;
    FSimpleExpression: TnxSqlSimpleExpression;
    fNotQualifiable: boolean;
    {FAddedByWildcard: Boolean;}
    function GetIndex: Integer;
    function Simplify(Context: TnxSqlContext): Boolean;
  public
    property Column : TnxSqlColumn read FColumn write FColumn;
    property SimpleExpression : TnxSqlSimpleExpression read FSimpleExpression write FSimpleExpression;

    {property AddedByWildcard: Boolean read FAddedByWildcard write FAddedByWildcard;}
    property Index: Integer read GetIndex;

    constructor Create(AParent: TnxSqlNode); override;

    function AllColumnReferencesQualified(
      const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
    function IsAggregateExpression(Strict: Boolean): Boolean;
    function IsColumnRefExpr: Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;

    destructor Destroy; override;

    procedure AddColumnDef(Target: TnxSqlColumnListOwner); override;
    procedure Assign(const Source: TnxSqlNode); override;
    function GetType(Context: TnxSqlContext): TnxFieldType; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    property NotQualifiable: boolean read fNotQualifiable write fNotQualifiable;
  end;

  TQualifyData = class(Tobject)
    TableName: String;
  end;

  TnxSqlSelectionList = class(TnxSqlNodeList)
  protected
//    function FindSelection(Context: TnxSqlContext; GroupCol : TnxSqlGroupColumn): TnxSqlSelection;
    function GetItem(Index: Integer): TnxSqlSelection;
    procedure DoQualify(Node: TnxSqlNode; UserData: TObject);
  public
    property Item[Index: Integer]: TnxSqlSelection read GetItem; default;

    constructor Create(AOwner: TnxSqlNode); override;
    destructor Destroy; override;
    procedure AddSelectAll;
    function AllColumnReferencesQualified(const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
    function IsQualifiedColumnList(const AliasName: string): Boolean;
    function IsStarSelection: Boolean;
    procedure QualifyColumns(const aTableName: String);
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    procedure Remove(anIndex: integer);

    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
  end;

  TnxSqlTableExp = class(TnxSqlRootNode)
  private
    function GetSetTerm(Index: Integer): TnxSqlNonJoinTableTerm;
    function GetSetTermCount: Integer;
    function DoUnionExceptIntersect(Context: TnxSqlContext): TnxSqlTableProxy;
    function GetRefresh: TnxSqlTableRefresher;
  private
    FJoinTableExp: TnxSqlJoinTableExp;
    FNonJoinTableExp: TnxSqlNonJoinTableExp;
    FNestedTableExp: TnxSqlTableExp;
    FSetTerms: TList;
    FResultTable: TnxSqlTableProxy;
    //FEmbeddedView: Boolean;
    procedure EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean; Select: TnxSqlSELECT);
    function BindTable(Context: TnxSqlContext; AOwner: TObject;
      const DatabaseName, TableName: string): TnxSqlTableProxy;
    function BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
    function TargetFieldFromSourceField(Context: TnxSqlContext;
      const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
  public
    //property EmbeddedView: Boolean read FEmbeddedView write FEmbeddedView;
    property ResultTable: TnxSqlTableProxy read FResultTable;
    property JoinTableExp: TnxSqlJoinTableExp read FJoinTableExp write FJoinTableExp;
    property NestedTableExp:  TnxSqlTableExp read FNestedTableExp write FNestedTableExp;
    property NonJoinTableExp: TnxSqlNonJoinTableExp read FNonJoinTableExp write FNonJoinTableExp;
    function RefersToTemp: Boolean;
    property Refresh: TnxSqlTableRefresher read GetRefresh;
    property SetTerm[Index: Integer] : TnxSqlNonJoinTableTerm read GetSetTerm;
    property SetTermCount: Integer read GetSetTermCount;

    procedure AddSetTerm(SetTerm: TnxSqlNonJoinTableTerm; SetOp: TnxSqlSetOp; All: Boolean); overload;
    procedure AddSetTerm(SetTerm: TnxSqlNonJoinTableTerm); overload;
    {function IsOrdered: Boolean;}
    function IsSelectInto: Boolean;
    function IsView: Boolean;

    destructor Destroy; override;

    procedure Assign(const Source: TnxSqlNode); override;
    procedure Bind(Prebinding: Boolean; Context: TnxSqlContext); override;
    function CheckNoDups(Context: TnxSqlContext): Boolean;
    procedure Clear;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool; override;
    function EvaluateFirst(Context: TnxSqlContext): variant; override;
    function WhereIsValidFilterStatement: Boolean; override;
    procedure BindWhere(aContext: TnxSqlContext); override;
    function Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor; var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult; override;
    function GetFieldsFromTable(Context: TnxSqlContext; const TableName: string; List: TList): TnxSqlTableProxy;
    function GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
    {procedure FreeResultTable;}
    function IsAmbiguousColumn(const ColumnName: string): Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsLeftOrRightJoin(var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
    function IsFullJoin(var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
    function RefersTo(const aTableName: string): Boolean; override;
    function RefersTo2(const aTableName, aColumnName: string): Boolean; override;
    function RefersToContextVars(Context: TnxSqlContext): Boolean; override;
    function Simplify(Context: TnxSqlContext): Boolean; override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
    procedure Unbind; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
  end;

  TnxSqlTableRef = class(TnxSqlLockNode)
  private
    FFuncName: PTokenRecord;
    FFuncNameStr: string;
    FParmList: TList;
    FTargetFunc: TnxSqlNode;
    FTargetFuncIsDeterministic: Boolean;
    FTargetFuncIsDeterministicWithinRow: Boolean;
    FuncTable: TnxSqlTableProxy;
    FuncTableContext     : TnxSqlContext;
    FuncTableGeneration  : Integer;
    FuncTableRecordsRead : Int64;

    function GetParentBlock: TnxSqlBlock;
    function GetDatabase: TnxSqlDatabaseProxy; {$IFDEF DCC11OrLater} inline; {$ENDIF}
    function GetFuncNameStr: string;
    procedure SetFuncNameStr(const Value: string);
    function GetParmCount: Integer;
    function GetParm(Index: Integer): TnxSqlExecParm;
    function GetTargetFunc: TnxSqlNode;
    procedure DoRefreshView(aContext: TnxSqlContext);
    procedure DoRefreshFunction(aContext: TnxSqlContext);
    function ExecuteTableFunction(aContext: TnxSqlContext): TnxSqlTableProxy;
    //procedure SetDatabase(Node: TnxSqlNode; UserData: TObject);
  private
    FAlias : PTokenRecord;
    FAliasStr: string;
    FTablename : PTokenRecord;
    FTablenameStr: string;
    FTableExp: TnxSqlTableExp;
    FColumnList: TnxSqlNodeList;
    FDatabaseName: PTokenRecord;
    FDatabaseNameStr: string;
    FTableInternal: TnxSqlTableProxy;
    IsView: Boolean;
    FIsAutoFilter: Boolean;
    function GetRefresh: TnxSqlTableRefresher;
    {ViewBound: Boolean;}
    function BindFieldDown(Context: TnxSqlContext;const DatabaseName, TableName,
      FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
    function BindTable(Context: TnxSqlContext; AOwner: TObject; const DatabaseName, TableName: string): TnxSqlTableProxy;
    function GetSQLName: string;
    function TargetFieldFromSourceField(Context: TnxSqlContext; const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
    function GetTablenameStr: string;
    procedure SetTablenameStr(const Value: string);
    function GetDatabaseNameStr: string;
    procedure SetDatabaseNameStr(const Value: string);
    function GetAliasStr: string;
    procedure SetAliasStr(const Value: string);
    property ParentBlock: TnxSqlBlock read GetParentBlock;
    property Database: TnxSqlDatabaseProxy read GetDatabase;
    procedure RequestDestroy(sender: TObject);
    procedure SetTable(aTable: TnxSqlTableProxy);
  public
    AssignedLocation: String;
    IsStandalone: Boolean;
    property IsAutoFilter: Boolean read FIsAutoFilter write FIsAutoFilter;
    property Alias : PTokenRecord read FAlias write FAlias;
    property AliasStr: string read GetAliasStr write SetAliasStr;
    property ColumnList  :  TnxSqlNodeList read FColumnList write FColumnList;
    property DatabaseName: PTokenRecord read FDatabaseName write FDatabaseName;
    property DatabaseNameStr: string read GetDatabaseNameStr write SetDatabaseNameStr;
    property Parm[Index: Integer]: TnxSqlExecParm read GetParm;
    property TableExp:  TnxSqlTableExp read FTableExp write FTableExp;
    property Tablename : PTokenRecord read FTablename write FTablename;
    property TablenameStr: string read GetTablenameStr write SetTablenameStr;
    property FuncName: PTokenRecord read FFuncName write FFuncName;
    property FuncNameStr: string read GetFuncNameStr write SetFuncNameStr;
    property Table: TnxSqlTableProxy read fTableInternal;

    property Refresh: TnxSqlTableRefresher read GetRefresh;
    property SQLName: string read GetSQLName;

    constructor Create(AParent: TnxSqlNode); override;
    destructor Destroy; override;

    procedure ClearStaleTableInstance(T: TnxSqlTableProxy);

    {procedure AddParm(ValueExp: TnxSqlCondExp; LocalName: PTokenRecord); overload;}
    procedure AddParm(ValueExp: TnxSqlSimpleExpression{TnxSqlCondExp{; const LocalName: string}); {overload;}
    procedure AddTableReference(Context: TnxSqlContext; Select: TnxSqlNode);
    function AliasLocationStr: string;
    {function BindView: Boolean;}
    procedure Clear;
    property ParmCount: Integer read GetParmCount;
    function GetTable(Context: TnxSqlContext; aOwner: TObject; aOpenMode: TnxSqlOpenmode): TnxSqlTableProxy;
    function GetResultTable(Context: TnxSqlContext): TnxSqlTableProxy;
    function HasColumn(const ColumnName: string): Boolean;
    function IsAmbiguousColumn(const ColumnName: string): Boolean;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function IsLeftOrRightJoin(var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
    function IsFullJoin(var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
    function LocationStr: string;
    {function PushCondFactors(Factors: TList): Boolean;}
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    function RefersToTemp: Boolean;
    function Simplify(Context: TnxSqlContext): Boolean;
    property TargetFunc: TnxSqlNode read GetTargetFunc;
    procedure Unbind;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlTableRefList = class(TnxSqlNodeList)
  private
    function BindTable(Context: TnxSqlContext; AOwner: TObject; const DatabaseName, TableName: string): TnxSqlTableProxy; stdcall;
    function BindToFieldWithin(Context: TnxSqlContext; const DatabaseName, TableName, FieldName, FieldNameLoc: string): TnxSqlFieldProxy; stdcall;
    function GetItem(Index: Integer): TnxSqlTableRef;
    function Simplify(Context: TnxSqlContext): Boolean;
  public
    property Item[Index: Integer]: TnxSqlTableRef read GetItem; default;

    {function ItemByName(TableName: string): TnxSqlTableRef;}
    {function AliasToName(const AAlias : string) : string;}
    function FieldListFromTable(Context: TnxSqlContext; const aTableName: string; List: TList): TnxSqlTableProxy; stdcall;
    function HasSuchAlias(const aAlias: string): Boolean; stdcall;
    function IsResultTable(T: TnxSqlTableProxy): Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function RefersToTemp: Boolean;
    function RefersToContextVars(Context: TnxSqlContext): Boolean;
    procedure Unbind;
    function Add(Item: TnxSqlNode): TnxSqlNode; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
  end;

  TnxSqlValueItem = class(TnxSqlNode)
  private
    FDefault : Boolean;
    FSimplex: TnxSqlSimpleExpression;
  public
    property Default : Boolean read FDefault write FDefault;
    property Simplex: TnxSqlSimpleExpression read FSimplex write FSimplex;

    procedure Unbind;

    destructor Destroy; override;

    function IsDeterministic(aWithinRow: Boolean): Boolean;
    {function IsLiteral: Boolean;}
    function IsNull: Boolean;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;

    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function Equals(ANode: TnxSqlNode): Boolean; override;
    function GetType(Context: TnxSqlContext): TnxFieldType; override;
    function GetSize(Context: TnxSqlContext): Integer; override;
    function GetDecimals(Context: TnxSqlContext): Integer; override;
    procedure LoadFromStream(Stream: TnxSqlPSMReader); override;
    procedure SaveToStream(Stream: TnxSqlPSMWriter); override;
    function ToString: WideString; override;
    procedure Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); override;
  end;

  TnxSqlValueList = class(TnxSqlNodeList)
  private
    FIsDeterministic: Boolean;
    function GetItem(Index: Integer): TnxSqlValueItem;
  public
    property Item[Index: Integer]: TnxSqlValueItem read GetItem; default;

    function IsDeterministic: Boolean;
    procedure Unbind;

    constructor Create(AOwner: TnxSqlNode); override;

    function Add(Item: TnxSqlNode): TnxSqlNode; override;
    procedure Assign(const Source: TnxSqlNode); override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    function ToString: WideString; override;
  end;

  TnxSqlValueListList = class(TnxSqlNodeList)
  private
    FResultTable: TnxSqlTableProxy;
    FIsDeterministic: Boolean;
    function GetItem(Index: Integer): TnxSqlValueList;
    {function GetOwnerStatement: TnxSqlColumnListOwner;}
  public
    property Item[Index: Integer]: TnxSqlValueList read GetItem; default;
    {property OwnerStatement: TnxSqlColumnListOwner read GetOwnerStatement;}

    constructor Create(AOwner: TnxSqlNode); override;
    destructor Destroy; override;

    function IsDeterministic: Boolean;
    procedure Merge(aList: TnxSqlValueListList);
    function RefersTo(const aTableName: string): Boolean; overload;
    function RefersTo(const aTableName, aColumnName: string): Boolean; overload;
    procedure Unbind;

    function Add(Item: TnxSqlNode): TnxSqlNode; override;
    function Clone(AParent: TnxSqlNode): TnxSqlNode; override;
    function ToString: WideString; override;
  end;

  TnxSqlColumnCalculator = class(TnxObject)
  protected
    bsfsFieldsDescriptor : TnxFieldsDescriptor;
    bsfsCursor           : TObject;
    bsfsRecord           : PnxRecordBuffer;
    sfsAbstractCursor    : TnxAbstractCursor;
    sfsServerCursor      : TnxSqlAbstractCursor;

    sfsRootNode          : TnxSqlBlock;
    sfsTokens            : TTokenList;
    sfsLocalContext      : TnxSqlContext;
    sfsWideQuery         : WideString;
  protected
    function BlobsSupported: Boolean;
    function BlobAsVariant(aField   : TnxFieldDescriptor;
                           aBlobNr  : TnxBlobNr)
                                    : Variant;

    function GetExtColumnDef(const aColumnName : string;
                               var aColType    : TnxFieldType;
                               var aColSize    : Integer;
                               var aColDec     : Integer;
                               var aColLocDesc : TnxLocaleDescriptor)
                                               : Integer;

    function GetExtColumnValue(aIndex : Integer)
                                      : Variant;

  public
    constructor Create(aFieldsDescriptor : TnxFieldsDescriptor;
                       aCursor           : TObject;
                 const aSqlText          : WideString);
    destructor Destroy; override;

    function GetValue(aRowBuffer         : PnxRecordBuffer): variant;
  end;

function TableNameStr(T: TnxsqlTableProxy): string;

type
  TnxSqlInt64Array = array[0..99999999] of Int64;
  PnxSqlInt64Array = ^TnxSqlInt64Array;
  TnxSqlRecPosList = class
  protected
    FBuffer: PnxSqlInt64Array;
    FCount: Integer;
    FBufferCount: Integer;
  public
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const P: int64);
    property Count: Integer read FCount;
    //function GetBuffer: PnxSqlInt64Array;
    property Buffer: PnxSqlInt64Array read FBuffer;
  end;

const
  VAR_CMP_LT        = 0;      { These are returned by VarCmp }
  VAR_CMP_EQ        = 1;
  VAR_CMP_GT        = 2;
  VAR_CMP_NULL      = 3;


//function VarCmp(const Left, Right: TVarData; LCID: Integer; Flags: LongWord): HRESULT; stdcall;

implementation

uses
  nxllLockedFuncs,
  nxllBde,
  nxllUtils,
  nxllFastMove,
  SysUtils,
  Variants,
  VarUtils,
  nxllWideString,
  nxsdNativeVariantConverter,
  nxsdConst,
  nxsdDataDictionaryStrings,
  nxsrTimeoutHandling,
  nxsrSortEngineBase,
  nxsqlTok,
  nxSqlParse,
  nxsqlDataManip,
  nxsqlPSM,
  nxsqlFunctionOrganizer,
  nxsqlViews,
  nxsqlEngine,
  nxsdFilterEngineSQL,
  nxllStreams,
  nxsrIndexEngineBase,
  Math,
  nxllException,
  nxsrBufferManager;

resourcestring
  rsAmbiguousTableReference = 'Referencia a tabla ambigua: %s%s'; //..
  rsDatatypeNotSupportedInDistinct = 'La columna %s%s tiene un tipo de dato (%s), que no es compatible con las operaciones DISTINCT';
  rsUnknownCollation = 'Colación desconocida:%s';
  rsONConditionMustBeBoolean = 'Una condición ON de un JOIN debe ser una expresión de tipo booleano: "%s"';
  rsAmbiguousColumnReference = 'Referencia a columna ambigua: campo "%s" - miembro de (%s)';
  rsAmbiguousColumnReference2 = 'Referencia a columna ambigua en la lista de selección: campo "%s" en (%s) - RefTabla1:%s - RefTabla2:%s - en %s';
  rsAggregateFunctionRequiresNumericExpression = 'La función agregada %s requiere una expresión numérica como argumento.';
  rsAmbiguousTableReference7 = 'Referencia a tabla ambigua: %s';
  rsCorrelationNameForSubQueryExpected = 'Se esperaba un nombre de correlación para la subconsulta:'#13;
  rsCorrelatedColumnNotInGrouping = 'La columna correlacionada referenciada debe aparecer en la lista de agrupación:%s.%s %s';
  rsAmbiguousColumnRef3 = 'Referencia a columna ambigua: "%s" - miembro de %s y de %s %s';
  rsAmbiguousColumnRef4 = 'referencia a columna ambigua:"%s" %s';
  rsAmbiguousUnqualifiedColumn = 'Referencia ambigua a columna no calificada: "%s"';
  rsColumnReferenceMustBeInGroupingOrAggregate = 'La referencia a la columna "%s" debe aparecer en la lista de agrupación o en una expresión agregada';
  rsScalarSubqueryExpected = 'Se esperaba una consulta secundaria: "%s". Los primeros dos valores de fila en el resultado de la subconsulta fueron: (%s),(%s)';
  rsSinglevalueQueryExpected = 'Se espera una consulta de un solo valor.:"%s"';
  rsColumnNumberMismatchInUnion = 'El número de columnas no coincide en la instrucción UNION / EXCEPT / INTERCEPT:"%s"';
  rsAllColumnsMustBeSortable = 'Todas las columnas que participan en una sentencia EXCEPT deben ser ordenables (%s)';
  rsFunctionNotFound = 'No se encontró la función "%s"';
  rsUnknownColumnInORDERBY = 'Columna desconocida en la cláusula ORDER BY:%s';
  rsSyntaxError = 'Error de sintaxis en la línea %d posición %d: se esperabla %s';
  rsInvalidTokenError = 'Token no válido: error en la línea %d posición %d';
  rsInvalidTokenErrorAtStart = 'Token no válido: error en la línea 1 pos 1';
  rsTheIndexSIsNotAFulltextIndex = 'El índice "%s" no es un índice de texto completo. Solo los índices de texto completo pueden usarse en una cláusula CONTAINS';
  rsIllegalJoinSyntax = 'Sintaxis de unión ilegal. (¿SELECT con corchetes?)';
  rsQualifiedSelectionReferenceNotAllowed = 'La referencia de selección cualificada del campo utilizado en el uso de la cláusula no está permitida (';
  rsQualifiedGroupingReferenceNotAllowed = 'No se permite la referencia de agrupación calificada del campo utilizado en el uso de la cláusula (';
  rsMergedColumnCantBeQualifified = 'La columna fusionada no puede ser calificada: ';
  rsInvalidReferenceToTableAlias = 'Referencia no válida al alias de tabla: ';
  rsUnexpectedNodeType = 'Tipo de nodo inesperado';
  rsOnlySELECTIsAllowedInSQLFilter = 'Solo se permite SELECT en expresiones de filtro SQL';
  rsNotAllColumnsSortable = 'No todas las columnas especificadas en la cláusula GROUP BY son ordenables';
  rsTOPMustGreaterZeroa = 'TOP debe especificar un valor >= 0';
  rsTopStartMustBeGreaterZero = 'El valor de inicio opcional en TOP debe ser 1 o mayor';
  rsCantResolveOrderColumn = 'No se puede resolver el orden de la columna';
  rsColumnIndexOutOfRange = 'Índice de columna en ORDER fuera de rango: ';
  rsSingleColumnQueryExpected = 'Error en la cláusula IN: se esperaba una consulta de una sola columna';
  rsGroupingFieldReferencesInvalidTable = 'El campo de agrupación "%s" hace referencia a una tabla que no es válida en este contexto.';
  rsDuplicateGroupByItem = 'Grupo duplicado por elemento: ';
  rsUnableToResolveTableOrAlias = 'No se puede resolver la tabla o alias ';
  rsNoWHEREClausePresent = 'No hay cláusula WHERE en la expresión SQL';
  rsINTONotValidInThisContext = '"INTO" no se puede utilizar en este contexto';
  rsQueryHasNoResultColumns = 'La consulta no tiene columnas de resultados.';
  rsOrderFieldNotPresentInDistinctSelection = 'Para consultas DISTINCT, ORDER BY solo puede listar los elementos presentes en la lista de selección';
  rsCONTAINSOnMultipleTablesNotSupported = 'No sepuede utilizar una búsqueda CONTAINS en consultas de varias tablas';
  rsNULLMustBeCastToSpecificType = 'NULL se debe convertir a un tipo específico en este contexto';
  rsSetOperationsNotAllowedInThisContext = 'Las operaciones de conjuntos no son compatibles en este contexto';
  rsOnlySimpleSELECTAllowedInFilters = 'Sólo se admiten SELECT simples en los filtros SQL';
  rsUndefined = 'no definido';
  rsIndexOutOfRange = 'Índice fuera de rango';
  rsONClauseOnNaturalJoinsNotAllowed = 'No se permite la cláusula ON en uniones naturales (como INNER, LEFT OUTER, RIGHT OUTER)';
  rsUsingClauseOnNaturalJoinsNotAllowed = 'No se permite el uso de la clausula USING en uniones naturales (como INNER, LEFT OUTER, RIGHT OUTER).';
  rsONOrUSINGClauseExpected = 'Se esperaba una cláusula ON o USING';
  rsColumnReferencesMustBeGroupedOrAggregate = 'Las referencias de columna deben estar en funciones agregadas o agrupadas en: "';
  rsSinglecolumnSubqueryExpected = 'Se espera una subconsulta de una sola columna';
  rsAmbiguousTableRef6 = 'Referencia a tabla ambigua:';
  rsSelectionMustBeColumnReferenceOrAggregate = 'La selección debe ser una referencia a columna o a un acumulado: "';  //..

//function VarCmp(const Left, Right: TVarData; LCID: Integer; Flags: LongWord): HRESULT; stdcall; external 'oleaut32.dll' name 'VarCmp';

const
  CanOptimizeOnOperator: array[TnxSqlRelOp] of Boolean = (
    {roNone, roEQ, roLE, roL, roG, roGE, roNE}
     FALSE,  TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE);
  NullStr: array[TnxNullBehaviour] of string = ('nulls at top', 'nulls at bottom', 'nulls as ascend', 'no nulls', 'nulls only');

function LocalesCompatible(L1, L2: TnxLocaleDescriptor; out UseThisOne: TnxLocaleDescriptor): Boolean; overload;
begin
  UseThisOne := L1;
  if Assigned(UseThisOne) and (UseThisOne.Locale <> 0) then begin
    if not Assigned(L2) or (L2.Locale = 0) then
      Result := True
    else
      Result := L1.IsEqual(L2);
  end else begin
    UseThisOne := L2;
    Result := True;
  end;
  if not Result then
    UseThisOne := nil;
    if Assigned(UseThisOne) and (UseThisOne.Locale = 0) then
      UseThisOne := nil;
end;

function LocalesCompatible(L1, L2: TnxLocaleDescriptor): Boolean; overload;
var
  UseThisOne: TnxLocaleDescriptor;
begin
  Result := LocalesCompatible(L1, L2, UseThisOne);
end;

{
function CanUseFirstLocaleDescriptor(L1, L2: TnxLocaleDescriptor): Boolean;
begin
  if Assigned(L1) and (L1.Locale <> 0) then begin
    if not Assigned(L2) or (L2.Locale = 0) then
      Result := True
    else
      Result := L1.IsEqual(L2);
  end else
    Result := not Assigned(L2) or (L2.Locale = 0);
end;
}

function SplitStringU(SplitChar: Char; const S: string; var Rest: string): string;
begin
  Result := AnsiUppercase(SplitString(SplitChar, S, Rest));
  Rest := AnsiUppercase(Rest);
end;

function ParenIfNonBlank(const S: string): string;
begin
  if S = '' then
    Result := ''
  else
    Result := ' (' + S + ')';
end;

function TableNameStr(T: TnxsqlTableProxy): string;
begin
  Result := T.Name + ParenIfNonBlank(T.Alias);
  if trim(Result) = '' then
    Result := '#INTERNAL_' + IntToHex(Integer(T),0);
end;

{type
  TnxGroupColumnTargetInfo = class(TnxObject)
  public
    SelFldIndex,
    LastValueIndex : Integer;
  end;}

{ TnxSqlGroupColumn }

procedure TnxSqlGroupColumn.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlGroupColumn then begin
    TableNameStr := TnxSqlGroupColumn(Source).TableNameStr;
    FieldNameStr := TnxSqlGroupColumn(Source).FieldNameStr;
  end else
    ENotCompatible(Source);
end;

function TnxSqlGroupColumn.ToString;
begin
  Result := ' ';
  if TableNameStr <> '' then
    Result := ' ' + TableNameStr + '.'
  else
    Result := ' ';
  Result := Result + FieldNameStr;
end;

procedure TnxSqlGroupColumn.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean); 
begin
  Callback(Self, UserData);
end;

function TnxSqlGroupColumn.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result := False;
  if ANode is TnxSqlGroupColumn then
    with TnxSqlGroupColumn(ANode) do
      if AnsiSameText(TableNameStr, Self.TableNameStr)
      and AnsiSameText(FieldNameStr, Self.FieldNameStr) then
        Result := True;
end;

function TnxSqlGroupColumn.QualifiedName(Context: TnxSqlContext): string;
begin
  if TableNameStr <> '' then
    Result := TableNameStr + '.' + FieldNameStr
  else
    Result := FieldNameStr;
end;

function TnxSqlGroupColumn.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlGroupColumn.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlGroupColumn.GetCollationNameStr: string;
begin
  if FCollationName <> nil then
    Result := TokenToStrStripQ(FCollationName)
  else
    Result := FCollationNameStr;
end;

function TnxSqlGroupColumn.GetLCID: LCID;
begin
  if (LocaleInt = 0) and (CollationNameStr <> '') then begin
    LocaleInt := nxLocaleFromCollation(CollationNameStr);
    if LocaleInt = -1 then
      raise EnxInternalSQLException.CreateFmt(rsUnknownCollation, [CollationNameStr]);
  end;
  Result := LocaleInt;
end;

procedure TnxSqlGroupColumn.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  inherited;
  //Descending := Stream.ReadBool;
  //IgnoreCase := Stream.ReadBool;
  CompareFlags := TnxSqlCompareFlags(Stream.ReadNodeOpt(Self));
  LocaleInt := Stream.ReadInt;
  CollationNameStr := Stream.ReadLString;
  //NullBehaviour := TnxNullBehaviour(Stream.ReadInt);
end;

procedure TnxSqlGroupColumn.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  inherited;
  //Stream.WriteBool(Descending);
  //Stream.WriteBool(IgnoreCase);
  Stream.WriteNodeOpt(CompareFlags);
  Stream.WriteInt(LocaleInt);
  Stream.WriteLString(CollationNameStr);
  //Stream.WriteInt(ord(NullBehaviour));
end;

procedure TnxSqlGroupColumn.SetCollationNameStr(const Value: string);
begin
  if Value <> GetCollationNameStr then begin
    FCollationNameStr := Value;
    FCollationName := nil;
  end;
end;

{ TnxSqlGroupColumnList }

function TnxSqlGroupColumnList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if ((TnxSqlGroupColumn(Item[i]).TableNameStr = '') or SameText(TnxSqlGroupColumn(Item[i]).TableNameStr, aTableName))
      and SameText(TnxSqlGroupColumn(Item[i]).FieldNameStr, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlGroupColumnList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlGroupColumnList.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlGroupColumnList.Contains(Context: TnxSqlContext; const aColName : string): Boolean;
var
  i : Integer;
  aGrpColText: string;
begin
  if aColName = '*' then begin
    Result := True;
    exit;
  end;
  for i := 0 to Count - 1 do begin
    aGrpColText := TnxSqlGroupColumn(Item[i]).FieldNameStr;
    Result := AnsiSameText(aColName, aGrpColText);
    if Result then
      exit;
  end;
  Result := False;
end;

{ TnxSqlRowBuilder }

constructor TnxSqlRowBuilder.Create(
  Context: TnxSqlContext; aOwnerSelect: TnxSqlNode; aOwnerJoin: TnxSqlJoinTableExp; aDatabase: TnxSqlDatabaseProxy;
  aOwnerStatement: TnxSqlBlock; aCondExp: TnxSqlCondExp;
  aCopyBlobs: Boolean; aLogFirstPassOnly: Boolean);
var
  IsView: Boolean;
begin
  inherited Create;
  Assert(Context <> nil);
  FDatabase := aDatabase;
  FOwnerStatement := aOwnerStatement;
  FJoinCondition := aCondExp;
  FSources := TnxSqlRowRangeList.Create(Self);
  if aOwnerSelect <> nil then
    IsView := (aOwnerSelect as TnxSqlSELECT).IsView
  else
    IsView := False;
  FieldCopier := TnxSqlRecordCopier.Create(aCopyBlobs, IsView);
  //FSourceFieldExpression := TList.Create;
  //TargetFields := TList.Create;
  FCopyBlobs := aCopyBlobs;
  Assert(Context <> nil);
  Assert(TObject(Context) is TnxSqlContext);
  FContext := Context;
  FLogFirstPassOnly := aLogFirstPassOnly;
  FOwnerSelect := aOwnerSelect;
  FOwnerJoin := aOwnerJoin;
  Limit := -1;
end;

destructor TnxSqlRowBuilder.Destroy;
begin
  nxFreeAndNil(FieldCopier);
  nxFreeAndNil(FSources);
  nxFreeAndNil(fOrderByDescriptor);
  inherited Destroy;
end;

procedure TnxSqlRowBuilder.AddColumnExpression(
  SourceExpression: TnxSqlSimpleExpression; TargetField: TnxSqlFieldProxy);
var
  l: Integer;
begin
  l := length(SourceFieldExpressions);
  SetLength(SourceFieldExpressions, l + 1);
  SourceFieldExpressions[l] := SourceExpression;

  l := length(TargetFields);
  SetLength(TargetFields, l + 1);
  TargetFields[l] := TargetField;

  FieldCopier.CantBlit := true;
end;

procedure TnxSqlRowBuilder.AddColumnField(SourceField,
  TargetField: TnxSqlFieldProxy);
begin
  assert(SourceField <> nil);
  assert(TargetField <> nil);
  FieldCopier.Add(SourceField, TargetField);
  //TargetFields.Add(TargetField);
end;

procedure TnxSqlRowBuilder.ClearColumnList;
var
  IsView: Boolean;
begin
  SetLength(SourceFieldExpressions, 0);
  //TargetFields.Clear;
  SetLength(TargetFields, 0);
  nxFreeAndNil(FieldCopier);
  if FOwnerSelect <> nil then
    IsView := (FOwnerSelect as TnxSqlSELECT).IsView
  else
    IsView := False;
  FieldCopier := TnxSqlRecordCopier.Create(FCopyBlobs, IsView);
end;

procedure TnxSqlRowBuilder.ShowComparison(const K1, K2: TnxSqlKeyRelation);
var
  U1, U2: Boolean;
begin
  U1 := K1.UniqueValue;
  U2 := K2.UniqueValue;
  if U1 then
    if not U2 then begin
      if VerboseLogging then
        LogVerbose('New key is unique', True);
      exit;
    end;
  U1 := K1.ClosedSegment;
  U2 := K2.ClosedSegment;
  if U1 then
    if U2 then
      if K1.EqualKeyDepth > K2.EqualKeyDepth then begin
        if VerboseLogging then
          LogVerbose('New key has more equal segments', True);
        exit;
      end else
      if K1.RelationFieldCount > K2.RelationFieldCount then begin
        if VerboseLogging then
          LogVerbose('New key has more segments', True);
        exit;
      end else
    else begin
      if VerboseLogging then
        LogVerbose('New key is a closed interval', True);
      exit;
    end;
  U1 := K1.RelationKeyIsUnique;
  U2 := K2.RelationKeyIsUnique;
  if U1 then
    if not U2 then begin
      if VerboseLogging then
        LogVerbose('New key is unique', True);
      exit;
    end;
end;

procedure TnxSqlRowBuilder.DumpOrderedList(OrderedSources : TnxSqlRowRangeList; const Title: string);
var
  j, y: integer;
  S: string;
begin
  if not VerboseLogging then
    exit;
  LogVerbose('');
  LogVerbose(Title, True);
  Indent;
  for j := 0 to pred(OrderedSources.Count) do begin
    LogVerbose(TableNameStr(OrderedSources.Item[j].Table));
    with OrderedSources.Item[j].KeyRelation do begin
      if CondFactor <> nil then begin
        LogVerbose(format('Number of columns in relation: %d',[RelationFieldCount]));
        S := '(';
        for y := 0 to pred(RelationFieldCount) do
          with Segment(y)^ do begin
            S := S + ' Column name:' + RelationField.Name;
            S := S + ' Primary argument expression:' + ArgExpression.ToString;
            S := S + ' Operator:' + RelOpStr[RelationOperator];

            if (ArgExpressionB <> nil)
            and (RelationOperatorB <> roNone)
            and (RelationB <> nil) then
                S := S + ' Secondary argument expression:' + ArgExpressionB.ToString +
                ' Operator:' + RelOpStr[RelationOperatorB];

          end;
        LogVerbose(S + ')');
        LogVerbose('Index name:' + IndexName);
      end else
        LogVerbose('No relation found');
    end;
  end;
  Outdent;
end;

function ArgExpressionDependsOn(ArgExpression : TnxSqlNode; Context: TnxSqlContext; aIndex: Integer;
  aTable: TnxSqlTableProxy): Boolean;
var
  i: Integer;
begin
  if ArgExpression is TnxSqlSimpleExpression then
    Result := TnxSqlSimpleExpression(ArgExpression).DependsOn(Context, aTable)
  else begin
    if ArgExpression is TnxSqlSimpleExpressionList then
      for i := 0 to TnxSqlSimpleExpressionList(ArgExpression).Count - 1 do
        if TnxSqlSimpleExpressionList(ArgExpression)[i].DependsOn(Context, aTable) then begin
          Result := True;
          exit;
        end;
    Result := False;
  end;
end;

procedure TnxSqlRowBuilder.LogRelationDataNormal(Relation: TnxSqlKeyRelation);
var
  i : Integer;
begin
  if not NormalLogging then
    exit;
  with Relation do begin
    LogNormal('Index name:' + IndexName);
    for i := 0 to pred(RelationFieldCount) do
      with Segment(i)^ do begin
      LogNormal(format('Primary relation:%s %s %s',[
        RelationField.Name, RelOpStr[RelationOperator], ArgExpression.ToString]));

      if RelationOperatorB <> roNone then
        LogNormal(format('Secondary relation:%s %s %s',[
          RelationField.Name, RelOpStr[RelationOperatorB], ArgExpressionB.ToString]));

    end;
  end;
end;

procedure TnxSqlRowBuilder.LogRelationDataVerbose(Relation: TnxSqlKeyRelation);
var
  i : Integer;
begin
  if not VerboseLogging then
    exit;
  with Relation do begin
    LogVerbose('---------------');
    LogVerbose('Conditional factor:' + CondFactor.ToString);
    LogVerbose('Index name:' + IndexName);
    LogVerbose(format('Columns in the key:%d',[RelationKeyFieldCount]));
    LogVerbose(format('Columns in the relation:%d',[RelationFieldCount]));
    for i := 0 to pred(RelationFieldCount) do
      with Segment(i)^ do begin
      LogVerbose(format('Primary relation:%s %s %s',[
        RelationField.Name, RelOpStr[RelationOperator], ArgExpression.ToString]));

      if RelationOperatorB <> roNone then
        LogVerbose(format('Secondary relation:%s %s %s',[
          RelationField.Name, RelOpStr[RelationOperatorB], ArgExpressionB.ToString]));

    end;
    LogVerbose('===============');
  end;
end;

function TnxSqlRowBuilder.TestEqualRelation(
  aBestKeyRelationSoFar: TnxSqlKeyRelation;
  aTable : TnxSqlTableProxy;
  aIndexNames: array of string;
  aDependencyIndex: Integer;
  aRelationField : TnxSqlFieldProxy;
  aArgExp: TnxSqlNode;
  aCondTerm: TnxSqlCondTerm;
  aCondFactor: TnxSqlCondFactor;
  aIsNullTest: Boolean): TnxSqlKeyRelation;
var
  i: Integer;
  TmpOp: TnxSqlRelOp;
  TmpExp: TnxSqlNode;
  Dups: TnxIndexDups;
  TmpSameCases,
  TmpIsNullTest,
  Filtered: Boolean;
  CF : TnxSqlCondFactor;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  F2 : TnxSqlFieldProxy;
  SegIdx: Integer;
  CurKeyRelation: TnxSqlKeyRelation;
  IndxFldCnt : Integer;
  IndexName: string;
  ConstraintName: string;
begin
  for i := 0 to length(aIndexNames) - 1 do begin
    IndexName := aIndexNames[i];

    aTable.GetIndexProperties(IndexName, Dups, Filtered, IndxFldCnt, SegmentInfo, ConstraintName);

    CurKeyRelation := TnxSqlKeyRelation.Create;
    try
      CurKeyRelation.CondFactor := aCondFactor;
      CurKeyRelation.RelationKeyIsUnique := Dups <> idAll;
      CurKeyRelation.RelationKeyFieldCount := IndxFldCnt;

      with CurKeyRelation.AddSegment^ do begin
        RelationField := aRelationField;
        ArgExpression := aArgExp;
        IsNullTest := aIsNullTest;
        RelationOperator := roEQ;
        RelationOperatorB := roNone;
        RelationKeyIsCaseInsensitive := SegmentInfo[0].IgnoreCase;
        RelationKeyFieldIsAlpha := IsCharType(aTable.FieldNC(SegmentInfo[0].FieldNo).GetType);
        RelationKeyIndexAsc := SegmentInfo[0].Ascending;
      end;

      CurKeyRelation.IndexName := IndexName;
      CurKeyRelation.DepIndex := aDependencyIndex;

      if IndxFldCnt > 1 then begin
        SegIdx := 1; // next segment
        repeat
          F2 := aTable.FieldNC(SegmentInfo[SegIdx].FieldNo);
          CF := FindRelation(FContext, aCondTerm, aCondFactor,
            nil, aTable, F2, TmpOp, TmpExp, TmpSameCases, TmpIsNullTest);
          if (CF = nil)
          or (TmpOp = roInList)
          or (not TmpSameCases and not SegmentInfo[SegIdx].IgnoreCase)
          then
            break
          else begin
            with CurKeyRelation.AddSegment^ do begin
              RelationField := F2;
              RelationOperator := TmpOp;
              ArgExpression := TmpExp;
              IsNullTest := TmpIsNullTest;
              SameCase := TmpSameCases;
              RelationOperatorB := roNone;

              if TmpOp <> roEQ then begin
                CF := FindRelation(FContext, aCondTerm, aCondFactor,
                  CF, aTable,
                  F2, TmpOp, TmpExp, TmpSameCases, TmpIsNullTest);

                if CF <> nil then begin
                  RelationB := CF;
                  RelationOperatorB := TmpOp;
                  ArgExpressionB := TmpExp;
                  IsNullTest := TmpIsNullTest;
                  SameCaseB := TmpSameCases;
                end;

                RelationKeyIndexAsc := SegmentInfo[SegIdx].Ascending;
                break;
              end;
            end;
          end;
          inc(SegIdx);
        until SegIdx >= IndxFldCnt;
      end;

      if aBestKeyRelationSoFar <> nil then begin
        if VerboseLogging then
        begin
          LogVerbose('Comparing key relations');
          Indent;
          LogRelationDataVerbose(aBestKeyRelationSoFar);
          LogRelationDataVerbose(CurKeyRelation);
        end;
        if CompareKeyRelations(FContext, CurKeyRelation, aBestKeyRelationSoFar) then begin
          if VerboseLogging then
          begin
            LogVerbose('');
            LogVerbose('New best key relation');
            ShowComparison(CurKeyRelation, aBestKeyRelationSoFar);
          end;
          nxFreeAndNil(aBestKeyRelationSoFar);
          aBestKeyRelationSoFar := CurKeyRelation;
          if VerboseLogging then
            LogRelationDataVerbose(CurKeyRelation);
          CurKeyRelation := nil;
        end;
        Outdent;
      end else begin
        aBestKeyRelationSoFar := CurKeyRelation;
        if VerboseLogging then
        begin
          LogRelationDataVerbose(CurKeyRelation);
          LogVerbose('');
          LogVerbose('Initial key relation');
          LogRelationDataVerbose(CurKeyRelation);
        end;
        CurKeyRelation := nil;
      end;
    finally
      nxFreeAndNil(CurKeyRelation);
    end;
  end;
  Result := aBestKeyRelationSoFar;
end;

function TnxSqlRowBuilder.TestNonEqualRelation(
  aBestKeyRelationSoFar: TnxSqlKeyRelation;
  aTable : TnxSqlTableProxy;
  aIndexNames: array of string;
  aDependencyIndex: Integer;
  aRelationField : TnxSqlFieldProxy;
  aArgExp: TnxSqlNode;
  aOperator: TnxSqlRelOp;
  aCondTerm: TnxSqlCondTerm;
  aCondFactor: TnxSqlCondFactor): TnxSqlKeyRelation;
var
  CF : TnxSqlCondFactor;
  i: Integer;
  TmpOp: TnxSqlRelOp;
  TmpExp: TnxSqlNode;
  Dups: TnxIndexDups;
  TmpSameCases,
  TmpIsNullTest,
  Filtered: Boolean;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  CurKeyRelation: TnxSqlKeyRelation;
  IndexName: string;
  IndxFldCnt : Integer;
  ConstraintName: string;
begin
  for i := 0 to length(aIndexNames) - 1 do begin
    IndexName := aIndexNames[i];

    aTable.GetIndexProperties(IndexName, Dups, Filtered, IndxFldCnt, SegmentInfo, ConstraintName);

    CurKeyRelation := TnxSqlKeyRelation.Create;
    try
      CurKeyRelation.CondFactor := aCondFactor;

      CurKeyRelation.RelationKeyIsUnique := Dups <> idAll;
      CurKeyRelation.RelationKeyFieldCount := IndxFldCnt;

      with CurKeyRelation.AddSegment^ do begin
        RelationField := aRelationField;
        ArgExpression := aArgExp;
        IsNullTest := False;
        RelationOperator := aOperator;
        RelationOperatorB := roNone;
        RelationKeyIsCaseInsensitive := SegmentInfo[0].IgnoreCase;
        RelationKeyIndexAsc := SegmentInfo[0].Ascending;
      end;
      CurKeyRelation.IndexName := IndexName;
      CurKeyRelation.DepIndex := aDependencyIndex;

      CF := FindRelation(FContext, aCondTerm, aCondFactor, nil,
        aTable, aRelationField, TmpOp, TmpExp, TmpSameCases, TmpIsNullTest);

      if CF <> nil then
        with CurKeyRelation.BottomSegment^ do begin
          RelationOperatorB := TmpOp;
          ArgExpressionB := TmpExp;
          SameCaseB := TmpSameCases;
          RelationB := CF;
        end;

      if aBestKeyRelationSoFar <> nil then begin
        if VerboseLogging then
        begin
          LogVerbose('Comparing key relations');
          Indent;
          LogRelationDataVerbose(aBestKeyRelationSoFar);
          LogRelationDataVerbose(CurKeyRelation);
        end;
        if CompareKeyRelations(FContext, CurKeyRelation,
          aBestKeyRelationSoFar) then begin
          if VerboseLogging then
            ShowComparison(CurKeyRelation, aBestKeyRelationSoFar);
          nxFreeAndNil(aBestKeyRelationSoFar);
          aBestKeyRelationSoFar := CurKeyRelation;
          if VerboseLogging then
          begin
            LogVerbose('New best key relation');
            LogRelationDataVerbose(CurKeyRelation);
          end;
          CurKeyRelation := nil;
        end;
        Outdent;
      end else begin
        aBestKeyRelationSoFar := CurKeyRelation;
        if VerboseLogging then
        begin
          LogVerbose('Initial key relation');
          LogRelationDataVerbose(CurKeyRelation);
        end;
        CurKeyRelation := nil;
      end;
    finally
      nxFreeAndNil(CurKeyRelation);
    end;
  end;
  Result := aBestKeyRelationSoFar;
end;

function TnxSqlRowBuilder.FindRelations(Context: TnxSqlContext; RestSources : TnxSqlRowRangeList; CondTerm: TnxSqlCondTerm;
  MoreThanOne: Boolean): Boolean;
var
  l, j, k, y : Integer;
  Best, x : Integer;
  F : TnxSqlFieldProxy;
  IndexNames: TnxSQLStringArray;
  IndxFldCnt : Integer;
  Found: Boolean;
  DepFound, DepLocation: Integer;
  BestRelation: TnxSqlRowRange;
  BestKeyRelation: TnxSqlKeyRelation;
  SameCase: Boolean;
  z: Integer;
  TmpOp: TnxSqlRelOp;
  TmpExp: TnxSqlNode;
  Dups: TnxIndexDups;
  TmpIsNullTest,
  Filtered, LiteralNull: Boolean;
  S: string;
  T: TnxsqlTableProxy;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  ConstraintName: string;
begin
  Result := False;

  if Assigned(ContainsSearch) then
    Exit;

with CondTerm do
  repeat

    BestRelation := nil;

    for j := 0 to pred(RestSources.Count) do begin
      RestSources.Item[j].Relations := 0;
      T := RestSources.Item[j].Table;

      S := TableNameStr(T);
      if VerboseLogging then
        LogVerbose('Looking for relations on ' +  S);

      BestKeyRelation := nil;

      Indent;
      if T.IndexCount = 0 then
      begin
        if VerboseLogging then
          LogVerbose('table has no indices');
      end
      else begin

        for k := 0 to pred(CondFactorCount) do begin
          if not OrderedSources.RelationUsed(CondFactor[k]) then
            with CondFactor[k] do begin
              try
                // force CondFactor to do conversion of NULL tests (if any) now  .
                // otherwise we'll be storing references to the original test, but
                // it'll be destroyed and replaced before we try to reference it
                //  (see TnxSqlCondFactor.CheckIfStatic for details) - issue #2319
                CondFactor[k].ForceCheckIfStatic(Context);
              if IsRelationTo(FContext, RestSources.Item[j].Table,
                F, TmpOp, TmpExp, SameCase, TmpIsNullTest)
              and CanOptimizeOnOperator[TmpOp] then begin

                if RestSources.Item[j].Outer {
                and ArgExpressionDependsOn(TmpExp, FContext, 0,
                  RestSources.Item[j].Opposite)} then begin
                  if VerboseLogging then
                  begin
                    LogVerbose(trim(CondFactor[k].ToString) + ' is a relation to ' +
                      TableNameStr(RestSources.Item[j].Table) +
                      '. Arg expression:' + TmpExp.ToString);
                    LogVerbose('but using would violate the outer join, so we can''t use it. Skipped.');
                  end;
                end else begin

                  if VerboseLogging then
                  begin
                    LogVerbose(trim(CondFactor[k].ToString) + ' is a relation to ' +
                      TableNameStr(RestSources.Item[j].Table));
                    Indent;
                    LogVerbose('Arg expression:' + TmpExp.ToString);

                    LogVerbose('');

                    LogVerbose('Checking dependencies on deeper tables for :' +
                      TmpExp.ToString);

                    Indent;
                  end;

                  DepFound := -1;
                  DepLocation := -1;

                  for l := pred(OrderedSources.Count) downto 0 do
                    if ArgExpressionDependsOn(TmpExp, FContext, 0,
                      OrderedSources.Item[l].Table) then begin
                      DepFound := l;
                      break;
                    end;

                  if DepFound <> -1 then begin
                    DepLocation := OrderedSources.DependencyExists(FContext, RestSources.
                      Item[j].Table);
                    if VerboseLogging then
                      LogVerbose('Deeper dependency found:' +
                        TmpExp.ToString + ' : ' +
                        TableNameStr(OrderedSources.Item[DepFound].Table) +
                        ' Position:' + IntToStr(DepFound)
                         + ' Location of dependency in ordered list:' + IntToStr(DepLocation))
                  end else
                    if VerboseLogging then
                      LogVerbose('No deeper dependency found on ' +
                        TmpExp.ToString);

                  if (DepFound <> -1) and (DepLocation <> -1) then begin
                    if VerboseLogging then
                    begin
                      LogVerbose('Can''t use this - something else depends on it');
                      Outdent;
                      LogVerbose('');
                    end
                  end else begin
                    if VerboseLogging then
                    begin
                      Outdent;
                      LogVerbose('');
                      LogVerbose('Relation found:' + ToString);
                    IsRelationTo(FContext, RestSources.Item[j].Table, F, TmpOp, TmpExp, SameCase, TmpIsNullTest);
                      Indent;
                      LogVerbose('Column:' + F.Name);
                      LogVerbose('Is same case?:' + IntToStr(ord(SameCase)));
                      LogVerbose('Operator:' +  RelOpStr[TmpOp]);
                      LogVerbose('Argument expression:' + TmpExp.ToString);
                      LogVerbose('Looking for indexes on that column');

                      Indent;
                    end;

                    if TmpExp is TnxSqlSimpleExpression then
                      LiteralNull := TnxSqlSimpleExpression(TmpExp).IsNullLiteral
                    else
                      LiteralNull := False;

                    x := RestSources.Item[j].Table.IndexesOnField(F, not SameCase, LiteralNull, TmpOp <> roEQ, IndexNames);

                    if x <> 0 then begin
                      if VerboseLogging then
                      begin
                        LogVerbose(IntToStr(x) + ' found');
                        Indent;
                      end;
                      for y := 0 to pred(x) do begin
                        RestSources.Item[j].Table.GetIndexProperties
                          (IndexNames[y], Dups, Filtered, IndxFldCnt, SegmentInfo, ConstraintName);
                        if VerboseLogging then
                        begin
                          LogVerbose('Index#' + IntToStr(y) + ': ' +
                                'Dups?:' + IntToStr(ord(Dups)) +
                                ' Segments:' +IntToStr(IndxFldCnt));
                          if IndxFldCnt <> 0 then begin
                            S := '(';
                            for z := 0 to pred(IndxFldCnt) do begin
                              S := S + RestSources.Item[j].Table.
                                FieldNC(SegmentInfo[z].FieldNo).Name +' ';
                            end;
                            LogVerbose(S + ')');
                          end;
                        end;
                      end;
                      Outdent;

                      if TmpOp = roEQ then
                        BestKeyRelation := TestEqualRelation(
                          BestKeyRelation,
                          RestSources.Item[j].Table,
                          IndexNames,
                          DepFound,
                          F,
                          TmpExp,
                          CondTerm,
                          CondFactor[k],
                          TmpIsNullTest)
                      else
                        BestKeyRelation := TestNonEqualRelation(
                          BestKeyRelation,
                          RestSources.Item[j].Table,
                          IndexNames,
                          DepFound,
                          F,
                          TmpExp,
                          TmpOp,
                          CondTerm,
                          CondFactor[k]);

                      RestSources.Item[j].Relations := RestSources.Item[j].Relations + 1;
                    end else
                      if VerboseLogging then
                        LogVerbose('none found');
                    if VerboseLogging then
                    begin
                      Outdent;
                      Outdent;
                    end;
                  end;
                  if VerboseLogging then
                    Outdent;
                end;
              end;
              except
                raise;
              end;
            end;
        end;
      end;

      if VerboseLogging then
      begin
        Outdent;
        LogVerbose('');
      end;
      if assigned(RestSources.Item[j].KeyRelation) then
        RestSources.Item[j].KeyRelation.Free;
      RestSources.Item[j].KeyRelation := BestKeyRelation;
    end;

    Best := -1;

    LogVerbose('--------------------------------');
    LogVerbose('Comparing key relations (if any)');
    Indent;

    for j := 0 to pred(RestSources.Count) do begin
      if (not MoreThanOne and (RestSources.Item[j].Relations = 1))
        or (MoreThanOne and (RestSources.Item[j].Relations > 0)) then begin
        if VerboseLogging then
          LogVerbose(TableNameStr(RestSources.Item[j].Table) + ' number of relations:' +
            IntToStr(RestSources.Item[j].Relations));
        if CompareRelations(Context, RestSources.Item[j], BestRelation) then begin
          BestRelation := RestSources.Item[j];

          Best := j;
        end;
      end;
    end;

    Found := False;
    if (BestRelation <> nil) and (BestRelation.KeyRelation <> nil) then begin
//      CalcEstimatedRangeCount(RestSources.Item[Best], nil, true);
//      if (BestRelation.KeyRelation.DepIndex = -1) and (OrderedSources.Count>0) and (RestSources.Item[Best].EstimatedRangeCount<OrderedSources[OrderedSources.Count-1].EstimatedRangeCount) then
      if (BestRelation.KeyRelation.DepIndex = -1) then
        OrderedSources.Add(RestSources.Item[Best])
      else
        OrderedSources.Insert(RestSources.Item[Best]);
      RestSources.Delete(Best);
      for j := 0 to pred(RestSources.Count) do
        if RestSources.Item[j].KeyRelation <> nil then
          RestSources.Item[j].KeyRelation.CondFactor := nil;
      Found := True;
      DumpOrderedList(OrderedSources, 'Ordered list so far(inner to outer):');
      Result := True;
    end;
    if VerboseLogging then
    begin
      Outdent;
      LogVerbose('--------------------------------');
      LogVerbose('');
    end;

  until not Found;
end;

procedure TnxSqlRowBuilder.DumpIndexMetrics;
var
  i, ic, j, k: Integer;
  Filtered: Boolean;
  Dups: TnxIndexDups;
  IndexFieldCount: Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  ConstraintName: string;
const
  {UniqueStr: array[Boolean] of string = ('Allows dups', 'Unique');}
  DupStr: array[TnxIndexDups] of string = ('Unique', 'Unique (ignore nulls)', 'Allow Dups');
  FilteredStr: array[Boolean] of string = ('Unfiltered', 'Filtered');
  DescAscStr: array[Boolean] of string = ('descending', 'ascending');
  CaseStr: array[Boolean] of string = ('case-sensitive', 'case-insensitive');
begin
  if not VerboseLogging then
    exit;

  LogVerbose('Indices');
  LogVerbose('-------');
  for i := 0 to Sources.Count - 1 do begin
    Indent;
    LogVerbose('');
    LogVerbose('Table: ' + TableNameStr(Sources[i].Table));
    Indent;
    ic := Sources[i].Table.IndexCount;
    if ic = 0 then
      LogVerbose('No indices')
    else begin
      LogVerbose('Indices:');
      Indent;
      for j := 0 to ic - 1 do begin
        Sources[i].Table.GetIndexProperties(Sources[i].Table.IndexName(j),
          Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
        LogVerbose(format('ix#:%d (%s), %s, %s, segments:%d', [j, Sources[i].Table.IndexName(j),
          DupStr[Dups], FilteredStr[Filtered], IndexFieldCount]));
        Indent;
        if IndexFieldCount = 0 then
          LogVerbose('no segments');
        for k := 0 to IndexFieldCount - 1 do
          with SegmentInfo[k] do begin
            LogVerbose(format('seg#:%d, %s, %s, %s, %s',[
              k,
              Sources[i].Table.FieldNC(FieldNo).Name,
              DescAscStr[Ascending],
              CaseStr[IgnoreCase],
              NullStr[NullBehaviour]
              ]));
          end;
        Outdent;
      end;
      Outdent;
    end;
    Outdent;
    Outdent;
  end;
  LogVerbose('=======');
end;

function CreateJoinIndexName(T: TnxSqlTableProxy): string;
var
  Seq: Integer;
begin
  Result := '$AUTO_JOIN_INDEX#1';
  Seq := 1;
  while T.IndexExists(Result) do begin
    Result := '$AUTO_JOIN_INDEX#' + IntToStr(Seq);
    inc(Seq);
  end;
end;

(*
function TnxSqlRowBuilder.TryToAddSuitableIndex: Boolean;
var
  i, j, k: Integer;
  FieldReferenced : TnxSqlFieldProxy;
  Operator: TnxSqlRelOp;
  ArgExpression: TnxSqlNode;
  IsNullTest,
  SameCase: Boolean;
  FieldList: TnxFastStringListIC;
  startTime: DWord;
  s: string;
  Done: Boolean;
begin
  Result := False;
{  if Sources.Count < 2 then
    exit;}
  FieldList := nil;
  try
    if VerboseLogging then
    begin
      LogVerbose('');
      LogVerbose('Looking for possible index additions');
    end;
    for i := 0 to Sources.Count - 1 do begin
      if VerboseLogging then
      begin
        Indent;
        LogVerbose('Table:' + TableNameStr(Sources[i].Table));
      end;

        // do som extra tweaking here for Meta tables
      if (Sources[i].Table.IsMetaTable) and (fOuterJoinMode<>jmNone) then
      begin
        // if we need to do an outer join we rather cache the meta tables
        TnxSqlDicTable(Sources[i].Table).ForceCache;
        // if we've a global where expression we apply it here; remember that Meta tables have no ranges...
        if (fOwnerSelect<>nil) and (fOwnerSelect is TnxSqlSELECT) and (TnxSqlSELECT(FOwnerSelect).CondExpWhere<>nil) then
          Sources.Item[0].Table.TryToLimit(FOwnerSelect);
      end;

      if (not Sources[i].Table.IsTemp) then
      begin
        if VerboseLogging then
          LogVerbose('Base table - can''t modify')
      end
      else if Sources[i].Table.GetRecordCount < 10 then
      begin
        if VerboseLogging then
          LogVerbose('Table too small')
      end
      else begin

        if JoinCondition <> nil then
          for j := 0 to pred(JoinCondition.CondTermCount) do
            with JoinCondition.CondTerm[j] do begin
              if VerboseLogging then
              begin
                Indent;
                LogVerbose('Term ' + IntToStr(j) + ' : ' + ToString);
              end;
              for k := 0 to CondFactorCount - 1 do begin
                if VerboseLogging then
                begin
                  Indent;
                  LogVerbose('Factor:' + IntToStr(k) + ' : ' +  CondFactor[k].ToString);
                end;
                if CondFactor[k].IsRelationTo(FContext, Sources[i].Table,
                  FieldReferenced, Operator, ArgExpression, SameCase, IsNullTest) then begin
                    if VerboseLogging then
                    begin
                      LogVerbose('Relation:');
                      LogVerbose('Column name, operator, arg expression, same case');
                      LogVerbose(
                        FieldReferenced.Name+', '+
                        RelOpStr[Operator]+', '+
                        ArgExpression.ToString+', '+
                        IntToStr(ord(SameCase)));
                    end;
                    if FieldList = nil then
                      FieldList := TnxFastStringListIC.Create;
                      case Operator of
                      roEQ :
                        if not IsNullTest then
                          FieldList.Insert(0, FieldReferenced.Name);
                      roInList :
                        if not IsNullTest then
                          FieldList.Add(FieldReferenced.Name);
                      {else
                        if not IsNullTest then
                          FieldList.Add(FieldReferenced.Name);}
                      end;
                  end;
                Outdent;
              end;
              Outdent;
              if (FieldList <> nil)
              and (FieldList.Count > 0)
              and (Sources[i].Table.Cursor <> nil) then begin
                if VerboseLogging then
                begin
                  LogVerbose('Suggested key:');
                  Indent;
                  for k := 0 to FieldList.Count - 1 do
                    LogVerbose(IntTostr(k) + ':' + FieldList[k]);
                  Outdent;
                end;
                {FDatabase.StartTransaction([Sources[i].Table]);}
                if NormalLogging then
                begin
                  s := ' (';
                  for k := 0 to FieldList.Count - 1 do begin
                    s := s + FieldList[k];
                    if k < FieldList.Count - 1 then
                      s := s + ', '
                    else
                      s := s + ')';
                  end;
                  LogNormal(' Adding index to table ' + TableNameStr(Sources[i].Table) + s);
                end;

                starttime := gettickcount;
                try
                  repeat
                    Done := True;
                    try
                      Sources[i].Table.AddIndex(CreateJoinIndexName(Sources[i].Table){'JOIN_INDEX'}, FieldList, idAll);
                    except
                      on e: Exception do
                        if pos('data dictionary is read only', e.Message) <> 0 then begin
                          {Probably failed because the index is too wide for the page size.
                           Retry with a reduce key size if possible}
                          if FieldList.Count > 1 then begin
                            FieldList.Delete(FieldList.Count - 1);
                            Done := False;
                          end else
                          begin
                            if NormalLogging then
                            begin
                              LogNormal('add index failed');
                              raise;
                            end;
                          end
                        end else
                          if NormalLogging then
                          begin
                            LogNormal('add index failed');
                            raise;
                          end;
                    end;
                  until Done;
                  {$IFOPT Q+}
                    {$DEFINE LocalOverflowCheckOFF}
                    {$OVERFLOWCHECKS OFF}
                  {$ENDIF}
                  if NormalLogging then
                    LogNormal(' elapsed:' + IntToStr(gettickcount-starttime));
                  {$IFDEF LocalOverflowCheckOFF}
                    {$OVERFLOWCHECKS ON}
                    {$UNDEF LocalOverflowCheckOFF}
                  {$ENDIF}
                  Result := True;
                finally
                  nxFreeAndNil(FieldList);
                end;
              end;
            end;
      end;
      Outdent;
    end;
    if VerboseLogging then
      LogVerbose('');
  finally
    nxFreeAndNil(FieldList);
  end;
end;
*)

procedure TnxSqlRowBuilder.AddIndex(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC);
var
  k: Integer;
  startTime: DWord;
  s: string;
  Done: Boolean;
begin
  if VerboseLogging then
  begin
    LogVerbose('Suggested key:');
    Indent;
    for k := 0 to FieldList.Count - 1 do
      LogVerbose(IntTostr(k) + ':' + FieldList[k]);
    Outdent;
  end;

  {FDatabase.StartTransaction([Sources[i].Table]);}
  if NormalLogging then
  begin
    s := ' (';
    for k := 0 to FieldList.Count - 1 do begin
      s := s + FieldList[k];
      if k < FieldList.Count - 1 then
        s := s + ', '
      else
        s := s + ')';
    end;
    LogVerbose(' Adding index to table ' + TableNameStr(T) + s);
  end;

  starttime := gettickcount;
  repeat
    Done := True;
    try
      (*
      write(TableNameStr(T), ': ');
      for k := 0 to FieldList.Count - 1 do
        write(FieldList[k], ' ');
      writeln;
      *)
      if T.IsTemp then
        T.AddIndex(CreateJoinIndexName(T), '', FieldList, idAll)
      else
        if not T.AddExternalIndex(CreateJoinIndexName(T), FieldList) then
          LogVerbose(' rejected as redundant or sub-optimal');
    except
      on e: Exception do
        if pos('data dictionary is read only', e.Message) <> 0 then begin
          {Probably failed because the index is too wide for the page size.
           Retry with a reduced key size if possible}
          if FieldList.Count > 1 then begin
            FieldList.Delete(FieldList.Count - 1);
            Done := False;
          end else begin
            if NormalLogging then
              LogVerbose('add index failed');
            raise;
          end
        end else begin
          if NormalLogging then
            LogVerbose('add index failed');
          raise;
        end;
    end;
  until Done;
  {$IFOPT Q+}
    {$DEFINE LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS OFF}
  {$ENDIF}
  if NormalLogging then
    LogVerbose(' elapsed:' + IntToStr(gettickcount-starttime));
  {$IFDEF LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS ON}
    {$UNDEF LocalOverflowCheckOFF}
  {$ENDIF}
end;

(*
procedure TnxSqlRowBuilder.Visit(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC; Map: array of Integer; k: Integer; var id: Integer);
var
  TmpList: TnxFastStringListIC;
  i: Integer;
begin
  inc(id);
  Map[k] := id;
  if id = high(Map) then begin
    TmpList := TnxFastStringListIC.Create;
    try
      for i := 0 to high(Map) do
        TmpList.Add(FieldList[Map[i]]);
      AddIndex(T, TmpList);
    finally
      TmpList.Free;
    end;
  end else begin
    for i := 0 to high(Map) do
      if Map[i] = 0 then
        Visit(T, FieldList, Map, i, id);
  end;
  dec(id);
  Map[k] := 0;
end;

procedure TnxSqlRowBuilder.PermutateAddIndex(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC);
var
  Map: array of Integer; // indexes into FieldList for current permutation
  i, id: Integer;
begin
  SetLength(Map, FieldList.Count);
  for i := 0 to high(Map) do
    Map[i] := 0;
  id := -1;
  Visit(T, FieldList, Map, 0, id);
end;
*)

procedure TnxSqlRowBuilder.PermutateAddIndex(T: TnxSqlTableProxy; FieldList: TnxFastStringListIC);
var
  i, j: Integer;
  TmpList: TnxFastStringListIC;
begin
  TmpList := TnxFastStringListIC.Create;
  try
  if FieldList.Count >= 4 then begin
    for i := 0 to nxMinI32(FieldList.Count, 6) - 1 do begin
      TmpList.Clear;
      TmpList.Add(FieldList[i]);
      AddIndex(T, TmpList);
    end;
  end else begin
    for i := 0 to FieldList.Count - 1 do begin
      for j := 0 to FieldList.Count - 1 do
        if i <> j then begin
          TmpList.Clear;
          TmpList.Add(FieldList[i]);
          TmpList.Add(FieldList[j]);
          AddIndex(T, TmpList);
        end;
    end;
  end;
  finally
    TmpList.Free;
  end;
end;

{ TnxSQLJoinColumns }

function TnxSQLJoinColumns.AddObject(const S: string; AObject: TObject): Integer;
begin
  Result := inherited AddObject(s, AObject);
  if aObject is TnxSqlSimpleExpression then
    expressions.Add(aObject);
end;

constructor TnxSQLJoinColumns.Create;
begin
  inherited;
  expressions:=TnxList.Create;
end;

destructor TnxSQLJoinColumns.Destroy;
begin
  inherited;
  FreeExpressions;
  expressions.free;
end;

procedure TnxSQLJoinColumns.FreeExpressions;
var
  i: integer;
begin
  for I := 0 to expressions.Count - 1 do
    TObject(expressions[i]).Free;
  expressions.Clear;
end;

function TnxSqlRowBuilder.TryToAddSuitableIndex: Boolean;
var
  i, j, k: Integer;
  FieldReferenced : TnxSqlFieldProxy;
  aOperator: TnxSqlRelOp;
  ArgExpression: TnxSqlNode;
  IsNullTest,
  SameCase: Boolean;
  FieldList: TnxFastStringListIC;

begin
  Result := False;

  // no point in doing this unless we have more than one table

  if Sources.Count < 2 then
    exit;

  FieldList := nil;
  try
    if VerboseLogging then
    begin
      LogVerbose('');
      LogVerbose('Looking for possible index additions');
    end;
    for i := 0 to Sources.Count - 1 do
      if Sources[i].KeyRelationRef = nil then begin
        if assigned(FieldList) then
          FieldList.Clear;
        if VerboseLogging then begin
          Indent;
          LogVerbose('Table:' + TableNameStr(Sources[i].Table));
        end;

          // do som extra tweaking here for Meta tables
        if (Sources[i].Table.IsMetaTable) and (fOuterJoinMode<>jmNone) then begin
          // if we need to do an outer join we rather cache the meta tables
          TnxSqlDicTable(Sources[i].Table).ForceCache;
          // if we've a global where expression we apply it here; remember that Meta tables have no ranges...
          if (fOwnerSelect <> nil) and (fOwnerSelect is TnxSqlSELECT) and (TnxSqlSELECT(FOwnerSelect).CondExpWhere <> nil) then
            Sources.Item[0].Table.TryToLimit(FOwnerSelect);
        end;

        {if (not Sources[i].Table.IsTemp) and not AllowExternalIndices then begin
          if VerboseLogging then
            LogVerbose('Base table - can''t modify')
        end
        else}
        if Sources[i].Table.GetRecordCount < 2 then begin
          if VerboseLogging then
            LogVerbose('Table too small')
        end else begin
          if JoinCondition <> nil then
            for j := 0 to pred(JoinCondition.CondTermCount) do
              with JoinCondition.CondTerm[j] do begin
                if VerboseLogging then begin
                  Indent;
                  LogVerbose('Term ' + IntToStr(j) + ' : ' + ToString);
                end;
                for k := 0 to CondFactorCount - 1 do begin
                  if VerboseLogging then begin
                    Indent;
                    LogVerbose('Factor:' + IntToStr(k) + ' : ' +  CondFactor[k].ToString);
                  end;
                  if CondFactor[k].IsRelationTo(FContext, Sources[i].Table,
                    FieldReferenced, aOperator, ArgExpression, SameCase, IsNullTest)
                    and (FieldReferenced.GetType in [nxtChar, nxtWideChar, nxtByte, nxtWord16,
                          nxtWord32, nxtInt8, nxtInt16, nxtInt32, nxtInt64, nxtAutoInc, nxtRefNr,
                          nxtDate, nxtTime, nxtDateTime, nxtShortString, nxtNullString,
                          nxtWideString, nxtRecRev, nxtGuid]) then begin
                      if VerboseLogging then begin
                        LogVerbose('Relation:');
                        LogVerbose('Column name, operator, arg expression, same case');
                        LogVerbose(
                          FieldReferenced.Name+', '+
                          RelOpStr[aOperator]+', '+
                          ArgExpression.ToString+', '+
                          IntToStr(ord(SameCase)));
                      end;
                      if FieldList = nil then
                        FieldList := TnxFastStringListIC.Create;
                        case aOperator of
                        roEQ :
                          if not IsNullTest then
                            if FieldList.IndexOf(FieldReferenced.Name) = -1 then
                              FieldList.Insert(0, FieldReferenced.Name);
                        roInList :
                          if not IsNullTest then
                            if FieldList.IndexOf(FieldReferenced.Name) = -1 then
                              FieldList.Add(FieldReferenced.Name);
                        end;
                    end;
                  Outdent;
                end;
                Outdent;
              end;
              if (FieldList <> nil)
              and (FieldList.Count > 0)
              and (Sources[i].Table.Cursor <> nil) then begin
                PermutateAddIndex(Sources[i].Table, FieldList);
                //AddIndex(Sources[i].Table, FieldList);
                Result := True;
              end;
        end;
        Outdent;
      end;
    if VerboseLogging then
      LogVerbose('');
  finally
    nxFreeAndNil(FieldList);
  end;
end;

procedure TnxSqlRowBuilder.Optimize(UseIndex: Boolean; Context: TnxSqlContext);
var
  RestSources : TnxSqlRowRangeList;
  i, j : Integer;
begin
  if OptimizeCalled then exit;

  WasOptimized := False;

  if (JoinCondition <> nil) and UseIndex then begin

    if NormalLogging then
    begin
      LogNormal('');
      LogNormal('Analyzing relation ' + JoinCondition.{Owner.}ToString + ';');
    end;
    if VerboseLogging then
    begin
      LogVerbose('');
      LogVerbose('Scanning for indexed relations');
      Indent;
    end;

    if assigned(FOwnerStatement) and FOwnerStatement.Logging then
      DumpIndexMetrics;

    for i := 0 to pred(JoinCondition.CondTermCount) do begin
      with JoinCondition.CondTerm[i] do begin
        if VerboseLogging then
        begin
          LogVerbose('------------------------------------------------------------');
          LogVerbose('Relation term ' +  IntToStr(i + 1) +  ' of ' + IntToStr(JoinCondition.CondTermCount) + ' : ' + ToString);
          Indent;
        end;

        nxFreeAndNil(OrderedSources);
        OrderedSources := TnxSqlRowRangeList.Create(Self);
        RestSources := TnxSqlRowRangeList.Create(Self);
        try
          RestSources.Assign(Sources);

          if VerboseLogging then
          begin
            LogVerbose('');
            LogVerbose('Looking for relations with exactly one possible index solution');
            Indent;
          end;

          if FindRelations(Context, RestSources, JoinCondition.CondTerm[i], False) then
            WasOptimized := True;

          DumpOrderedList(OrderedSources, 'Ordered list (inner to outer) after single-solution relations:');

          Outdent;

          if VerboseLogging then
          begin
            LogVerbose('');
            LogVerbose('Looking for relations with more than one possible index solution');
            Indent;
          end;

          if FindRelations(Context, RestSources, JoinCondition.CondTerm[i], True) then
            WasOptimized := True;

          DumpOrderedList(OrderedSources, 'Ordered list (inner to outer) after multiple-solution relations:');

          Outdent;

          for j := pred(RestSources.Count) downto 0 do begin
            OrderedSources.Add(RestSources.Item[j]);
            RestSources.Delete(j);
          end;

          Assert(RestSources.Count = 0);

          if NormalLogging then
          begin
            LogNormal('');
            LogNormal('Using access path:');
            LogNormal('');
            Indent;
            for j := pred(OrderedSources.Count) downto 0 do begin
              Indent;
              LogNormal('Table:' + TableNameStr(OrderedSources.Item[j].Table)+ ' (Estimated records: '+inttostr(OrderedSources.Item[j].EstimatedRangeCount)+')');
              if (OrderedSources.Item[j].KeyRelation <> nil) then
                LogRelationDataNormal(OrderedSources.Item[j].KeyRelation)
              else
                LogNormal('no relation');
                LogNormal('');
            end;
            for j := pred(OrderedSources.Count) downto 0 do begin
              Outdent;
            end;
            Outdent;
            LogNormal('------------------------------------------------------------');
          end;
        finally
          nxFreeAndNil(RestSources);
        end;
        if VerboseLogging then
        begin
          LogVerbose('');
          Outdent;
        end;
      end;
    end;
    if NormalLogging then
    begin
      Outdent;
      LogNormal('');
    end;
  end;
  OptimizeCalled := True;
end;

function TnxSqlRowBuilder.ProcessLevel(Cookie1: Pointer): Boolean;
type
  PLoHi64 = ^TLoHi64;
  TLoHi64 = packed record
    LoInt: Cardinal;
    HiInt: Cardinal;
  end;
begin
  if LimitReached then begin
    Result := False;
    exit;
  end;
  inc(FRecordRead);
  if Assigned(FContext) then
    FContext.RecordsRead := FRecordRead;
  if PLoHi64(@FRecordRead).LoInt mod 1024 = 0 then
    nxCheckRemainingTime;
  if Level > 0 then begin
    if (FOuterJoinMode <> jmNone) or (JoinCondition = nil) or (JoinCondition.AsBooleanLevel(Level, FContext) = tsbTrue) then begin
      dec(Level);
      ReadSources(Cookie1);
      inc(Level);
    end;
  end else
    if (JoinCondition = nil) {or assigned(ContainsSearch)} or (JoinCondition.AsBoolean(FContext) = tsbTrue) then
      RowHandler(Cookie1);
  if (Limit >= 0) and (RecordsWritten >= (Limit + LimitStart)) then begin
    LimitReached := True;
    Result := False; // stop
  end else
    Result := True; // continue
end;

function IsSimpleRelationBetween(Context: TnxSqlContext; CondTerm: TnxSqlCondTerm;
  Table1, Table2: TnxSqlTableProxy; OuterJoinMode: TnxSqlOuterJoinMode; UpperLowerAccepted: Boolean; var FailIdx: Integer;
  JoinFactors, JoinFiltersT1, JoinFiltersT2: TList): Boolean; stdcall;
var
  i: Integer;
  Col1, Col2: TnxSqlFieldProxy;
  CF: TnxSqlCondFactor;
begin
  try
    for i := 0 to CondTerm.CondFactorCount - 1 do begin
      CF := CondTerm.CondFactor[i];
      FailIdx := i;
      if CF.IsSimpleRelationBetween(Context, Table1, Table2, Col1, Col2, UpperLowerAccepted) then
        JoinFactors.Add(CF)
      else
      if CF.IsConstantFilterOn(Context, Table1)
      and not (OuterJoinMode in [jmLeft, jmFull]) then
        JoinFiltersT1.Add(CF.Clone(CF))
      else
      if CF.IsConstantFilterOn(Context, Table2)
      and not (OuterJoinMode in [jmRight, jmFull]) then
        JoinFiltersT2.Add(CF.Clone(CF))
      else begin
        {FailIdx := i;}
        Result := False;
        exit;
      end;
    end;
    Result := JoinFactors.Count > 0;
  except
    Result := False; {can fail due to binding errors in some cases}
  end;
end;

procedure TnxSqlRowBuilder.GetGlobalJoinFilters(TL: TnxSqlTableProxy; TR: TnxSqlTableProxy; JoinFiltersT1: TList; JoinFiltersT2: TList; JoinFactors: TList);
var
  j: Integer;
  Local_i: Integer;
  NewColumnName: string;
  NewTableName: string;
  CFCopy: TnxSqlCondFactor;
  FReq: TnxSqlFieldProxy;
  FLeq: TnxSqlFieldProxy;
  Fc: string;
  ClonedCondFact: TnxSqlCondFactor;
  OwnerTerm: TnxSqlCondTerm;
  //i: Integer;
  OwnerWhere: TnxSqlCondExp;
  aParent: TnxSQLNode;
{$ifdef PullFiltersFromOROps}
  found: boolean;
  foundfactorall: boolean;
  k,m : integer;
{$endif}
begin
  if FOwnerSelect=nil then
    exit;
  OwnerWhere:=TnxSQLSelect(FOwnerSelect).CondExpWhere;
  if OwnerWhere=nil then
    exit;
  aParent:=FOwnerJoin;
  {$ifndef PullFiltersFromOROps}
  if OwnerWhere.CondTermCount>1 then
    exit;
  {$endif}
  {clone conditions from outer WHERE expression that refer to this table}
  if {(FOwnerJoin <> nil) and }(OwnerWhere <> nil) then
  {can't handle OR in combination with other filters}
  begin
    OwnerTerm := OwnerWhere.CondTerm[0];

    for Local_i := 0 to OwnerTerm.CondFactorCount - 1 do
    begin
{$ifdef PullFiltersFromOROps}
      // we need to check for this factor if it appears in every term EXACTLY the same
      if (OwnerWhere.CondTermCount > 1)  then
      begin
        foundfactorall:=true;
        for k := 1 to OwnerWhere.CondTermCount - 1 do
        begin
          found:=false;
          for m := 0 to OwnerWhere.CondTerm[k].CondFactorCount - 1 do
            if OwnerTerm.CondFactor[Local_i].Equals(OwnerWhere.CondTerm[k].CondFactor[m]) then
              found:=true;
          foundfactorall:=foundfactorall and found;
          if not foundfactorall then
            break;
        end;
        if not foundfactorall then
          continue;
      end;
{$endif}
      if (aParent=nil) or (aParent<>FOwnerJoin) then
        aParent:=OwnerTerm.CondFactor[Local_i].Parent;
      if TnxSqlCondFactor(OwnerTerm.CondFactor[Local_i]).CondPrimary is TnxSqlCPUnique then
        continue;

      ClonedCondFact := OwnerTerm.CondFactor[Local_i].Clone(aParent) as TnxSqlCondFactor;
      try
        if (TL<>nil) and ClonedCondFact.{OwnerTerm.CondFactor[i]} IsConstantFilterOn(FContext, TL, Fc) and not (ClonedCondFact.RefersToContextVars(FContext)) then
        begin
          JoinFiltersT1.Add(ClonedCondFact);
          ClonedCondFact := nil;
          // see if we have an equal transition to the other table
          for j := 0 to JoinFactors.Count - 1 do
            if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True) and SameText(Fc, FLeq.Name) then
            begin
              CFCopy := OwnerTerm.CondFactor[Local_i].Clone(aParent) as TnxSqlCondFactor;
              if TR.Alias <> '' then
                NewTableName := TR.Alias
              else
                NewTableName := TR.Name;
              NewColumnName := FReq.Name;
              if CFCopy.AlterTableRef(NewTableName, NewColumnName) then
                JoinFiltersT2.Add(CFCopy)
              else
                CFCopy.Free;
              break;
            end;
        end
        else if (TR<>nil) and ClonedCondFact.{OwnerTerm.CondFactor[i]} IsConstantFilterOn(FContext, TR, Fc) and not (ClonedCondFact.RefersToContextVars(FContext)) then
        begin
          JoinFiltersT2.Add(ClonedCondFact);
          ClonedCondFact := nil;
          // see if we have an equal transition to the other table
          for j := 0 to JoinFactors.Count - 1 do
            if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True) and SameText(Fc, FReq.Name) then
            begin
              CFCopy := OwnerTerm.CondFactor[Local_i].Clone(aParent) as TnxSqlCondFactor;
              if TL.Alias <> '' then
                NewTableName := TL.Alias
              else
                NewTableName := TL.Name;
              NewColumnName := FLeq.Name;
              if CFCopy.AlterTableRef(NewTableName, NewColumnName) then
                JoinFiltersT1.Add(CFCopy)
              else
                CFCopy.Free;
              break;
            end;
        end;
      finally
        ClonedCondFact.Free;
      end;
    end;
  end;
end;

procedure TnxSqlRowBuilder.GetGlobalFilter(aTable: TnxSQLTableProxy; aFilterList: TList);
var
  OwnerWhere: TnxSqlCondExp;
  OwnerTerm: TnxSqlCondTerm;
  i:integer;
  ClonedCondFact: TnxSqlCondFactor;
  Fc: string;
{$ifdef PullFiltersFromOROps}
  k, m:integer;
//  FOwnerSelect: TnxSQLSelect;
  found: boolean;
  foundfactorall: boolean;
{$endif}
begin
  OwnerWhere:=TnxSqlSELECT(fOwnerSelect).CondExpWhere;
  if (OwnerWhere <> nil)
  and (OwnerWhere.CondTermCount = 1) {can't handle OR in combination with other filters} then begin
    OwnerTerm := OwnerWhere.CondTerm[0];
    for i := 0 to OwnerTerm.CondFactorCount - 1 do begin
      if OwnerTerm.CondFactor[i].RefersToContextVars(FContext) then
        continue;
      ClonedCondFact := OwnerTerm.CondFactor[i].Clone(FOwnerSelect) as TnxSqlCondFactor;
      try
        if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, aTable, Fc) then
        begin
          aFilterList.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
          ClonedCondFact:=nil;
        end;
      finally
        nxFreeAndNil(ClonedCondFact);
      end;
    end;
  end;

{$ifdef PullFiltersFromOROps}
  if (OwnerWhere <> nil)
  and (OwnerWhere.CondTermCount > 1) {check which filters are the same in ALL terms} then begin
    OwnerTerm := OwnerWhere.CondTerm[0];
    for i := 0 to OwnerTerm.CondFactorCount - 1 do begin
      foundfactorall:=true;
      for k := 1 to OwnerWhere.CondTermCount - 1 do
      begin
        found:=false;
        for m := 0 to OwnerWhere.CondTerm[k].CondFactorCount - 1 do
          if OwnerTerm.CondFactor[i].Equals(OwnerWhere.CondTerm[k].CondFactor[m]) then
            found:=true;
        foundfactorall:=foundfactorall and found;
      end;
      if foundfactorall then
      begin
        ClonedCondFact := OwnerTerm.CondFactor[i].Clone(FOwnerSelect) as TnxSqlCondFactor;
        try
          if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, aTable, Fc) then
          begin
            aFilterList.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
            ClonedCondFact:=nil;
          end;
        finally
          nxFreeAndNil(ClonedCondFact);
        end;
      end;
    end;
  end;
{$endif}
end;

(*
function TnxSqlRowBuilder.CalcEstimatedRangeCount(RowRange: TnxSqlRowRange; Filters: TList): Cardinal;
begin
  result:=CalcEstimatedRangeCount(RowRange, Filters, False);
end;

function TnxSqlRowBuilder.CalcEstimatedRangeCount(RowRange: TnxSqlRowRange): Cardinal;
begin
  result:=CalcEstimatedRangeCount(RowRange, nil, True);
end;
*)

function TnxSqlRowBuilder.CalcEstimatedRangeCount(RowRange: TnxSqlRowRange; Filters: TList; UseGlobalFilters: Boolean): Cardinal;
var
  I: Integer;
  RangeCount: Cardinal;
  JoinFilters: TList;
begin
  Result:=high(RangeCount);

  JoinFilters:=TList.Create;
  try
    // if there are no filters passed in, we get the global fitler list.
    if (Filters=nil) and UseGlobalFilters then
    begin
      GetGlobalFilter(RowRange.Table, JoinFilters);
      if JoinFilters.Count>0 then
        ApplyFilterRange(RowRange.Table, JoinFilters);
    end
    else
      if (Filters<>nil) and (Filters.Count>0) then
        ApplyFilterRange(RowRange.Table, Filters);

    RowRange.Table.Cursor.sbcGetRecordCount(rcoRangedKeyCount, RangeCount, true);
    RowRange.EstimatedRangeCount:=RangeCount;
  finally
    for I := 0 to JoinFilters.Count - 1 do    // Iterate
      TnxSqlCondFactor(JoinFilters[i]).Free;
    JoinFilters.free;
  end;
end;

{$HINTS OFF}
function TnxSqlRowBuilder.CompareRelations(Context: TnxSqlContext; const R1, R2: TnxSqlRowRange): Boolean;
var
//  aCount: Cardinal;
  U1, U2: Boolean;
//  aRatio: Double;
begin
  if R2 = nil then begin
    if VerboseLogging then
      LogVerbose('no previous relation');
    Result := True;
    exit;
  end;

// put that back in; without it we have major speed regressions all over the place  
  result:=GetDrivingTable(R1, R2, nil, nil, Context)=lrRight;
  exit;
(*
  if Ratio<0.2 then
    exit;
*)
  U1 := R1.KeyRelation.StartsWithLiterals(Context);
  U2 := R2.KeyRelation.StartsWithLiterals(Context);
  if U1 then
    if not U2 then begin
      Result := False;
      LogVerbose('2 is better, does not start with literals');
      exit;
    end else
  else
    if U2 then begin
      Result := True;
      LogVerbose('1 is better, does not start with literals');
      exit;
    end;

  U1 := R1.KeyRelation.UniqueValue;
  U2 := R2.KeyRelation.UniqueValue;
  if U1 then
    if not U2 then begin
      Result := True;
      LogVerbose('1 is better, unique value');
      exit;
    end else
  else
    if U2 then begin
      Result := False;
      LogVerbose('2 is better, unique value');
      exit;
    end;

  {moved here from below}
  U1 := R1.KeyRelation.RelationKeyIsUnique;
  U2 := R2.KeyRelation.RelationKeyIsUnique;
  if U1 then
    if not U2 then begin
      Result := True;
      LogVerbose('1 is better, unique relation key');
      exit;
    end else
  else
    if U2 then begin
      Result := False;
      LogVerbose('2 is better, unique relation key');
      exit;
    end;

  U1 := R1.KeyRelation.ClosedSegment;
  U2 := R2.KeyRelation.ClosedSegment;
  if U1 then
    if U2 then begin
      if R1.EstimatedRangeCount > R2.EstimatedRangeCount * 2 then begin
        Result := True;
        LogVerbose('1 is better, more rows');
        exit;
      end else
      if R2.EstimatedRangeCount > R1.EstimatedRangeCount * 2 then begin
        Result := False;
        LogVerbose('2 is better, more rows');
        exit;
      end;

      if R1.KeyRelation.EqualKeyDepth > R2.KeyRelation.EqualKeyDepth then begin
        Result := True;
        LogVerbose('1 is better, deeper equal key');
        exit;
      end else
      if R1.KeyRelation.EqualKeyDepth < R2.KeyRelation.EqualKeyDepth then begin
        Result := False;
        LogVerbose('2 is better, deeper equal key');
        exit;
      end else
      if R1.KeyRelation.RelationFieldCount > R2.KeyRelation.RelationFieldCount then begin
        Result := True;
        LogVerbose('1 is better, deeper key');
        exit;
      end else
      if R1.KeyRelation.RelationFieldCount < R2.KeyRelation.RelationFieldCount then begin
        Result := False;
        LogVerbose('2 is better, deeper key');
        exit;
      end else
    end else begin
      Result := True;
      LogVerbose('2 is better, closed segment');
      exit;
    end
  else
    if U2 then begin
      LogVerbose('1 is better, closed segment');
      Result := False;
      exit;
    end;

  if R1.EstimatedRangeCount > R2.EstimatedRangeCount then begin
    Result := True;
    LogVerbose('1 is better, more rows');
  end else begin
    Result := False;
    LogVerbose('2 is better, more rows');
  end;
  //exit;

  //result:=GetDrivingTable(R1, R2, nil, nil,)=lrRight;

  if VerboseLogging then
  begin
    LogVerbose('Comparing relations');
    Indent;
    LogVerbose('Relation 1:');
    Indent;
    LogVerbose('Table name:' + TableNameStr(R1.Table));
    LogVerbose('Is unique?:', R1.KeyRelation.UniqueValue);
    LogVerbose('Is closed segment?:',R1.KeyRelation.ClosedSegment);
    LogVerbose('Equal key depth:',R1.KeyRelation.EqualKeyDepth);
    LogVerbose('Key depth:',R1.KeyRelation.RelationFieldCount);
    LogVerbose('Relation key is unique?:',R1.KeyRelation.RelationKeyIsUnique);
    LogVerbose('Total Row count:',R1.Table.GetRecordCount);
    LogVerbose('Limited Row count (est):',R1.EstimatedRangeCount);
    LogVerbose('Expression:' + R1.KeyRelation.CondFactor.ToString);
    LogVerbose('Starts with literals:', R1.KeyRelation.StartsWithLiterals(Context));
    Outdent;
    LogVerbose('Relation 2:');
    Indent;
    LogVerbose('Table name:' + TableNameStr(R2.Table));
    LogVerbose('Is unique?:',R2.KeyRelation.UniqueValue);
    LogVerbose('Is closed segment?:',R2.KeyRelation.ClosedSegment);
    LogVerbose('Equal key depth:',R2.KeyRelation.EqualKeyDepth);
    LogVerbose('Key depth:',R2.KeyRelation.RelationFieldCount);
    LogVerbose('Relation key is unique?:',R2.KeyRelation.RelationKeyIsUnique);
    LogVerbose('Total Row count:',R2.Table.GetRecordCount);
    LogVerbose('Limited Row count (est):',R2.EstimatedRangeCount);
    LogVerbose('Expression:' + R2.KeyRelation.CondFactor.ToString);
    LogVerbose('Starts with literals:', R2.KeyRelation.StartsWithLiterals(Context));
    Outdent;
    Outdent;
  end; (**)
end;
{$HINTS ON}

function TnxSqlRowBuilder.CompareKeyRelations(Context: TnxSqlContext; const NewRel, BestRel: TnxSqlKeyRelation): Boolean;
var
  NewB, BestB: Boolean;

  function IsLiteral(N: TnxsqlNode): Boolean;
  var
    i: Integer;
  begin
    {TODO: check if this can be expanded to lower hsv levels}
    if N is TnxSqlSimpleExpression then
      Result := TnxSqlSimpleExpression(N).HasStaticValue(Context) = hsvYes
    else begin
      if N is TnxSqlSimpleExpressionList then begin
        Result := True;
        for i := 0 to TnxSqlSimpleExpressionList(N).Count - 1 do
          if not (TnxSqlSimpleExpressionList(N)[i].HasStaticValue(Context) = hsvYes) then begin
            Result := False;
            break;
          end;
      end else
        Result := False;
    end;
  end;

var
  mincount: integer;
  equal: boolean;
  segmentindex: integer;
begin
  // A. first we check whether one of the indexes is an "extension" of the other
  // this is the case if one index has the same restrictions as the other but
  // one or more additional ones

  // A.1 figure out the length of the shorter index
  mincount:=Min(NewRel.RelationFieldCount, BestRel.RelationFieldCount);

  // A.2 compare the common segments if they are the same
  equal:=true;
  for segmentindex := 0 to mincount-1 do
    if not NewRel.IsEqual(NewRel.Segment(segmentindex), BestRel.Segment(segmentindex)) then
    begin
      equal:=false;
      break;
    end;

  // A.3 if they are indeed such indexes then choose the one with more relations,
  // if they are the same then choose the new one arbitrary
  if equal then begin
    if NewRel.RelationFieldCount > BestRel.RelationFieldCount then begin
      if VerboseLogging then
        LogVerbose('new is deeper');
      Result := True;
    end else
    if NewRel.RelationFieldCount < BestRel.RelationFieldCount then begin
      if VerboseLogging then
        LogVerbose('old is deeper');
      Result := False;
    end
    else
    begin
      if (BestRel.RelationKeyFieldCount < NewRel.RelationKeyFieldCount) or
        (BestRel.RelationKeyIsUnique and not NewRel.RelationKeyIsUnique) then begin
        LogVerbose('old is more specific, keep old.');
        Result := False;
      end else begin
        LogVerbose('old and new are same, chose new.');
        Result := True;
      end;
    end;
    exit;
  end;


  // B. choose closed segments over open segments
  NewB := NewRel.ClosedSegment;
  BestB := BestRel.ClosedSegment;
  if NewB then
    if BestB then
      if NewRel.EqualKeyDepth > BestRel.EqualKeyDepth then begin
        if VerboseLogging then
          LogVerbose('new has deeper equal depth');
        Result := True;
        exit;
      end else
      if NewRel.EqualKeyDepth < BestRel.EqualKeyDepth then begin
        if VerboseLogging then
          LogVerbose('old has deeper equal depth');
        Result := False;
        exit;
      end else
      if NewRel.RelationFieldCount > BestRel.RelationFieldCount then begin
        if VerboseLogging then
          LogVerbose('new is deeper');
        Result := True;
        exit;
      end else
      if NewRel.RelationFieldCount < BestRel.RelationFieldCount then begin
        if VerboseLogging then
          LogVerbose('old is deeper');
        Result := False;
        exit;
      end else
    else begin
      if VerboseLogging then
        LogVerbose('new is closed');
      Result := True;
      exit;
    end
  else
    if BestB then begin
      if VerboseLogging then
        LogVerbose('old is closed');
      Result := False;
      exit;
    end;

  NewB := NewRel.UniqueValue;
  BestB := BestRel.UniqueValue;
  if NewB then
    if not BestB then begin
      Result := True;
      if VerboseLogging then
        LogVerbose('new is unique value');
      exit;
    end else
  else
    if BestB then begin
      if VerboseLogging then
        LogVerbose('new is not unique value but best is');
      Result := False;
      exit;
    end;

  NewB := IsLiteral(NewRel.Segment(0)^.ArgExpression);
  BestB := IsLiteral(BestRel.Segment(0)^.ArgExpression);
  if NewB then
    if not BestB then begin
      if VerboseLogging then
        LogVerbose('new is literal');
      //Result := True;
      Result := False;
      exit;
    end else
  else
    if BestB then begin
      if VerboseLogging then
        LogVerbose('old is literal');
      //Result := False;
      Result := True;
      exit;
    end;
  NewB := NewRel.RelationKeyIsUnique;
  BestB := BestRel.RelationKeyIsUnique;
  if NewB then
    if not BestB then begin
      if VerboseLogging then
        LogVerbose('new is unique relation key');
      Result := True;
      exit;
    end else
  else
    if BestB then begin
      if VerboseLogging then
        LogVerbose('old is unique relation key');
      Result := False;
      exit;
    end;
  if VerboseLogging then
    LogVerbose('relations have similar properties');
  Result := False;
end;

function TnxSqlRowBuilder.CreateResultRecord(Cookie: Pointer): Boolean;
var
  v: Variant;
  i : Integer;

begin
  if LimitReached then begin
    Result := False;
    Exit;
  end;

  if (Limit = 0) or (Limit > 0) and (RecordsWritten < LimitStart) then begin
    Result := True;
    Inc(RecordsWritten);
    Exit;
  end;

  if (Limit >= 0) and (RecordsWritten >= Limit + LimitStart) then begin
    LimitReached := True;
    Result := False;
    Exit;
  end;

  FTargetTable.Insert;
  for i := 0 to high(SourceFieldExpressions) do
    if assigned(SourceFieldExpressions[i]) then begin
      v := Unassigned;
      v := SourceFieldExpressions[i].GetValue(FContext);
      TargetFields[i].SetValue(v);
    end else
      TargetFields[i].SetValue(1);
  FieldCopier.Execute;
  FTargetTable.Post(False);
  Inc(RecordsWritten);

  Result := True;
end;

function TnxSqlRowBuilder.WriteNull(Cookie: Pointer): Boolean;
begin
  if not TnxNRecordHash(Cookie).Exists then
    CreateResultRecord(Cookie);
  Result := True; {continue}
end;

//  FTable.Iterate(aIterator, aCookie, aReadReversed);

type
  PTextIterateData = ^TTextIterateData;
  TTextIterateData = record
    Table: TnxSqlTableProxy;
    UserData: Pointer;
  end;

procedure TnxSqlRowBuilder.TextEntryIterate(const RefNr:int64; UserData: Pointer);
begin
  with PTextIterateData(UserData)^ do begin
    Table.GetRecordByIDDirect(RefNr);
    ProcessLevel(UserData);
  end;
end;

function TnxSqlRowBuilder.IndexIterator(aCookie: Pointer; const RefId: int64; aKey: PnxKeyBuffer): Boolean;
{var
  f: TextFile;
  tx: PChar;
  s: string;}
begin
{  inc(counter);
  assignfile(f, 'c:\test1.txt');
  Append(f);
  tx:=PChar(aKey)+1;
  s:=copy(Strpas(tx), 1, akey[0]);
  Writeln(f, inttostr(counter)+': '+s);
  closeFile(f);}
  TnxSqlRefNrSet(aCookie).Add(RefId);
  Result := True; {continue}
end;

procedure TnxSqlRowBuilder.FullTextIterate(Context: TnxSqlContext; Table: TnxSqlTableProxy; UserData: Pointer);
var
//  fi: TextFile;
  t, f, j, l: Integer;
  Term: TnxSqlFullTextSearchTerm;
  Factor: TnxSqlFullTextSearchFactor;
  w: widestring;
  FullTextBuffer: array of Word;

  FinalRefNrSet, TermRefNrSet, FactorRefNrSet: TnxSqlRefNrSet;
  TextIterateData: TTextIterateData;

  OuterContains: TnxSqlCPContains;
begin
  Table.SetIndex(ContainsSearch.IndexNameStr);
  if not Table.CurrentIndexIsFulltext then
    raise EnxSqlException.nxCreate(rsTheIndexSIsNotAFulltextIndex, [ContainsSearch.IndexNameStr]);
  OuterContains := _CurrentlyProcessedContains;
  _CurrentlyProcessedContains := ContainsSearch;
  FinalRefNrSet := TnxSqlRefNrSet.Create;
  try
    for t := 0 to high(ContainsSearch.Terms) do begin
      Term := ContainsSearch.Terms[t];
      TermRefNrSet := TnxSqlRefNrSet.Create;
      try
        for f := 0 to high(Term.Factors) do begin
          Factor := Term.Factors[f];
          FactorRefNrSet := TnxSqlRefNrSet.Create;
          try
            w := Factor.Expr.GetValue(Context);
            l := length(w);
            
            SetLength(FullTextBuffer, l + 1024);
            FullTextBuffer[0] := l;            
            for j := 1 to l do
              FullTextBuffer[j] := word(w[j]);

            if not Factor.StartsWith then
              l := 0;

            Table.Cursor.sbcRangeReset;
            Table.Cursor.sbcRangeSet(1, l, true, @FullTextBuffer[0], true, 1, l, true, @FullTextBuffer[0], true);

            Table.IterateIndex(IndexIterator, FactorRefNrSet);
            if f = 0 then
              // first factor
              if Factor.Negated then begin
                Table.Cursor.sbcRangeReset;
                Table.IterateIndex(IndexIterator, TermRefNrSet);
                TermRefNrSet.Intersect(FactorRefNrSet, Factor.Negated);
              end else
                TermRefNrSet.Add(FactorRefNrSet)
            else
              TermRefNrSet.Intersect(FactorRefNrSet, Factor.Negated);
          finally
            FactorRefNrSet.Free;
          end;
        end;
        FinalRefNrSet.Add(TermRefNrSet);
      finally
        TermRefNrSet.Free;
      end;
    end;
    TextIterateData.Table := Table;
    TextIterateData.UserData := UserData;
    FinalRefNrSet.Iterate(TextEntryIterate, @TextIterateData);
  finally
    _CurrentlyProcessedContains := OuterContains;
    FinalRefNrSet.Free;
  end;
end;

procedure TnxSqlRowBuilder.ReadSources;
begin
  if nxsqlNoProcessingCounter > 0 then
    Exit;

  if UserData = nil then
    UserData := Self;

  with Sources.Item[Level] do
    if assigned(ContainsSearch) then
      FulltextIterate(FContext, Table, UserData)
    else
      Iterate(ProcessLevel, UserData, ReadReversed);
end;

function TnxSqlRowBuilder.FindRelation(
      Context: TnxSqlContext;
      Term: TnxSqlCondTerm;
      CurFactor, CurFactor2: TnxSqlCondFactor;
      Table : TnxSqlTableProxy;
      TargetField : TnxSqlFieldProxy;
      var Operator: TnxSqlRelOp;
      var ArgExpression: TnxSqlNode;
      var SameCase: Boolean;
      var IsNullTest: Boolean): TnxSqlCondFactor;
var
  k, l : Integer;
  F : TnxSqlFieldProxy;
  CF: TnxSqlCondFactor;
  DepFound : Boolean;
begin
  with Term do begin
    for k := 0 to pred(CondFactorCount) do begin
      CF := CondFactor[k];
      if (CF <> CurFactor)
      and (CF <> CurFactor2)
      and not OrderedSources.RelationUsed(CF) then
        with CF do
          if IsRelationTo(FContext, Table,
            F, Operator, ArgExpression, SameCase, IsNullTest)
                and CanOptimizeOnOperator[Operator] then begin
              if F = TargetField then begin
                DepFound := False;
                for l := 0 to pred(OrderedSources.Count) do
                  if (ArgExpression is TnxSqlSimpleExpression)
                  and (TnxSqlSimpleExpression(ArgExpression).DependsOn(Context,
                      OrderedSources.Item[l].Table))
                  or (ArgExpression is TnxSqlSimpleExpressionList)
                  and (TnxSqlSimpleExpressionList(ArgExpression).DependsOn(
                    Context, OrderedSources.Item[l].Table)) then begin
                    DepFound := True;
                    break;
                  end;
                if not DepFound then begin
                  Result := CF;
                  exit;
                end;
              end;
            end;
    end;
  end;
  Result := nil;
end;

function TnxSqlRowBuilder.SetOrderByIndex(OrderByScope: TnxSqlOrderByScope): TnxSqlSortedState;
var
//  k: Integer;
  anAlias: string;
//  aSelection: TnxSQLSelection;
  I: Integer;
  j : Integer;
  c : Integer;
  //f: TnxSqlFieldProxy;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  S: TnxSqlTableProxy;
  St: string;
  Dups: TnxIndexDups;
  Filtered: Boolean;
  IndexFieldCount: Integer;
  Best, BestDepth: Integer;
  CurState: TnxSqlSortedState;
  ConstraintName: string;

  function OBIndexFieldCount: Integer;
  begin
    if OrderByDescriptor.KeyDescriptor is TnxCompKeyDescriptor then
      Result := TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFieldCount
    else
      Result := 0;
  end;

begin
  Result := ssUnordered; // assume we don't find anything good
  if Assigned(ContainsSearch) then
    exit;
  Best := -1;
  BestDepth := 0;
  // see if we have an index, which suits us
  if (Sources.Count = 1) and (OrderByDescriptor <> nil) then begin
    Assert(Assigned(OrderByScope));
    S := Sources[0].Table;
    if NormalLogging then
      LogNormal('Looking for index that matches requested output order');

    for i := 0 to S.IndexCount - 1 do begin

      St := S.IndexName(i);
      S.GetIndexProperties(St, Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);

      if VerboseLogging then
      begin
        Indent;
        LogVerbose('Index ' + IntTostr(i) + ' name:' + St +
                ' Dups?:' + IntToStr(ord(Dups)) +
                ' Segments:' +IntToStr(IndexFieldCount));
        if IndexFieldCount <> 0 then begin
          St := '(';
          for j := 0 to pred(IndexFieldCount) do begin
            St := St + 'seg#:' + IntToStr(j) + ' column#:' + IntToStr(SegmentInfo[j].FieldNo) + ': ' + S.FieldNC(SegmentInfo[j].FieldNo).Name +' ';
            st := st + ' ' + NullStr[SegmentInfo[j].NullBehaviour];
            if SegmentInfo[j].IgnoreCase then
              st := st + ' I/C ';
            if SegmentInfo[j].siLocale <> nil then
             st := st + ' locale:' + IntToStr(SegmentInfo[j].siLocale.Locale);
          end;
        end;
        if VerboseLogging then
          LogVerbose(St + ')');
        Outdent;
      end;

      {ignore keys with no fields (seq index) and filtered keys}
      if (IndexFieldCount > 0) and not Filtered then begin
        Indent;
        //Log(St);

        CurState := ssUnordered;

        if IndexFieldCount >= OBIndexFieldCount then begin
          for j := 0 to OBIndexFieldCount - 1 do begin
            anAlias:=TnxSqlSELECT(FOwnerSelect).AliasFromFieldName(S, S.FieldNC(SegmentInfo[j].FieldNo).Name);
            c := OrderByScope.FindColumn(anAlias);
            //f := S.FieldByName(anAlias);
            //if (c = -1) or (f = nil) or (f.Index <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].FieldNumber) then begin
            if (c <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].FieldNumber)
              and (not SameText(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].CustomStrings.Values['Name'], anAlias)) then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              CurState := ssUnordered;
              if VerboseLogging then
                LogVerbose('Column name mismatch');
              break;
            end;
            if SegmentInfo[j].NullBehaviour <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j].NullBehaviour then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              if VerboseLogging then
                LogVerbose('Null-behavior mismatch');
              CurState := ssUnordered;
              break;
            end;

            if SegmentInfo[j].IgnoreCase
            and ((not (TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j] is TnxTextKeyFieldDescriptor)
            or (not TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).IgnoreCase))) then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              CurState := ssUnordered;
              if VerboseLogging then
                LogVerbose('Casing mismatch');
              break;
            end;
            {
            if (SegmentInfo[j].siLocale <> nil)
            and ((not (TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j] is TnxTextKeyFieldDescriptor)
            or (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).LocaleDescriptor = nil)
            or not (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).LocaleDescriptor.IsEqual(SegmentInfo[j].siLocale)))) then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              CurState := ssUnordered;
              break;
            end;
            }
            if (TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j] is TnxTextKeyFieldDescriptor)
            and not LocalesCompatible(SegmentInfo[j].siLocale, TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j]).UsedLocaleDescriptor) then begin
              if VerboseLogging then
                LogVerbose('Locale mismatch');
              CurState := ssUnordered;
              break;
            end;
            (*
            if (SegmentInfo[j].siLocale <> nil)
            and (TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j] is TnxTextKeyFieldDescriptor)
            and
              ((TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j]).UsedLocaleDescriptor = nil)
              or
              (not (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).UsedLocaleDescriptor.IsEqual(SegmentInfo[j].siLocale)))) then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              Log('Locale mismatch');
              Log('Key''s locale desc <> nil');
              if TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j]).UsedLocaleDescriptor = nil then
                Log(' order-by segment''s locale desc = nil')
              else
                Log(' order-by segment''s locale:' + IntToStr(TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
                  KeyFields[j]).UsedLocaleDescriptor.Locale));
              CurState := ssUnordered;
              break;
            end;

            if (SegmentInfo[j].siLocale = nil)
            and (TnxKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]) is TnxTextKeyFieldDescriptor)
            and (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).LocaleDescriptor <> nil) then begin
              if j - 1 > BestDepth then begin
                BestDepth := j - 1;
                Best := i;
              end;
              Log('Locale mismatch');
              Log('Key''s locale desc = nil');
              Log('Order-by''s locale desc <> nil');
              CurState := ssUnordered;
              break;
            end;
            *)
            case CurState of
            ssUnordered :
              if SegmentInfo[j].Ascending = TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].Ascend then
                CurState := ssOrdered
              else
                CurState := ssReversed;
            ssReversed :
              if SegmentInfo[j].Ascending = TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].Ascend then begin
                if j - 1 > BestDepth then begin
                  BestDepth := j - 1;
                  Best := i;
                end;
                CurState := ssUnordered;
                break;
              end;
            ssOrdered :
              if SegmentInfo[j].Ascending <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].Ascend then begin
                if j - 1 > BestDepth then begin
                  BestDepth := j - 1;
                  Best := i;
                end;
                CurState := ssUnordered;
                break;
              end;
            end;
          end;
        end;

        if CurState > Result then begin
          Result := CurState;
          BestDepth := OBIndexFieldCount - 1;
          Best := i;
        end else
        if CurState = Result then
          if OBIndexFieldCount - 1 > BestDepth then begin
            BestDepth := OBIndexFieldCount - 1;
            Best := i;
          end;
        Outdent;
      end;
    end;

    case Result of
    ssUnordered :
      if Best <> -1 then begin
        St := S.IndexName(Best);
        if NormalLogging then
          LogNormal('No match. Best candidate:' + St);
        S.SetIndex(St);
      end;
    ssReversed :
      if Best <> -1 then begin
        St := S.IndexName(Best);
        if NormalLogging then
          LogNormal('Reverse match! :' + St);
        S.SetIndex(St);
      end;
    ssOrdered :
      if Best <> -1 then begin
        St := S.IndexName(Best);
        if NormalLogging then
          LogNormal('Match! :' + IntToStr(Best) + ': ' + St);
        S.SetIndex(St);
      end;
    end;
  end;
end;

procedure TnxSqlRowBuilder.SetSortedState;
var
  i: Integer;
  S: TnxSqlTableProxy;
  ixn: Integer;
  aSelectSt: TnxSqlSELECT;
  {
  j, c : Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  Dups: TnxIndexDups;
  Good, Filtered: Boolean;
  IndexFieldCount: Integer;
  ConstraintName: string;
  FieldAlias: string;
  }

  function OBIndexFieldCount: Integer;
  begin
    if OrderByDescriptor.KeyDescriptor is TnxCompKeyDescriptor then
      Result := TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFieldCount
    else
      Result := 0;
  end;

begin
  fCheckedIndex := -1;
  SortedState := ssUnordered;

  aSelectSt := TnxSqlSELECT(FOwnerSelect);

  if aSelectSt = nil then
    Exit;

  if OrderByDescriptor = nil then
    Exit;

  if aSelectSt.TablesReferencedByOrder.Count > 1 then
    Exit;

  // Check if all sorted fields belong to TablesReferencedByOrder[0]
  if aSelectSt.OrderList <> nil then
    for i:= 0 to aSelectSt.OrderList.Count-1 do
      if (aSelectSt.OrderList[i].Column<>nil) and (aSelectSt.OrderList[i].Column.TableNameStr<>'') and
         (not SameText(aSelectSt.OrderList[i].Column.TableNameStr, aSelectSt.TablesReferencedByOrder[0].Name)) then
        Exit;

  S := aSelectSt.TablesReferencedByOrder[0].Table;

  if s.IsMetaTable then
    ixn:=-1
  else
    S.Cursor.GetIndexID(ixn);

  fCheckedIndex:=ixn;

  if ixn > -1 then begin
    SortedState := SortWillMatch(@ixn);
    if ixn <> fCheckedIndex then begin
      fCheckedIndex := -1;
      SortedState := ssUnordered;
    end;
  end;

  if SortedState = ssUnordered then
    Exit;
{
  if aSelectSt.Volatile(fContext) then
    SortedState := ssUnordered;
}
  if aSelectSt.SpecialInSubQuery then
    SortedState := ssUnordered;

  if SortedState <> ssUnordered then
    S.SetIndex(S.IndexName(ixn));

  {
  aSelectSt:=TnxSqlSELECT(FOwnerSelect);

  if aSelectSt=nil then
    exit;

  if OrderByDescriptor=nil then
    exit;

  if TnxSqlSELECT(FOwnerSelect).TablesReferencedByOrder.Count > 1 then
    exit;

  // Check if all sorted fields belong to TablesReferencedByOrder[0]
  if aSelectSt.OrderList<>nil then
    for i:=0 to aSelectSt.OrderList.Count-1 do
      if (aSelectSt.OrderList[i].Column<>nil) and (aSelectSt.OrderList[i].Column.TableNameStr<>'') and
         (not SameText(aSelectSt.OrderList[i].Column.TableNameStr, aSelectSt.TablesReferencedByOrder[0].Name)) then
        exit;

//  if (TnxSqlSELECT(FOwnerSelect).TablesReferencedByOrder.Count=1) and (OrderByDescriptor <> nil) then begin
    S := TnxSqlSELECT(FOwnerSelect).TablesReferencedByOrder[0].Table;

    if s.IsMetaTable then
      ixn:=-1
    else
      S.Cursor.GetIndexID(ixn);
    fCheckedIndex:=ixn;
    if ixn > -1 then begin
      S.GetIndexProperties(S.IndexName(ixn), Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
      if not Filtered and (IndexFieldCount <= OBIndexFieldCount) then begin
        Good := True;
        for j := 0 to IndexFieldCount - 1 do begin

          FieldAlias := aSelectSt.AliasFromFieldName(s, s.FieldNC(SegmentInfo[j].FieldNo).Name);
          c := OrderByScope.FindColumn(FieldAlias);
          if (c <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].FieldNumber) then begin
            Good := False;
            break;
          end;

          if SegmentInfo[j].NullBehaviour <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
            KeyFields[j].NullBehaviour then begin
            Good := False;
            break;
          end;
          // We have to take ReadReversed into account. If it's false then the index
          //  is good if there is a match. But if it's true then the index is good
          //  if there is a mismatch.
          if ReadReversed then begin
            if SegmentInfo[j].Ascending = TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].Ascend then begin
              Good := False;
              break;
            end;
          end else begin
            if SegmentInfo[j].Ascending <> TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j].Ascend then begin
              Good := False;
              break;
            end;
          end;
          if SegmentInfo[j].IgnoreCase then
            if (not (TnxKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j]) is TnxTextKeyFieldDescriptor))
                or (not TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j]).IgnoreCase) then begin
              Good := False;
              break;
          end;
          if (SegmentInfo[j].siLocale <> nil)
          and ((not (TnxKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]) is TnxTextKeyFieldDescriptor))
          or (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).LocaleDescriptor = nil)
          or not (TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]).LocaleDescriptor.IsEqual(SegmentInfo[j].siLocale))) then begin
            Good := False;
            break;
          end;
          if (SegmentInfo[j].siLocale = nil)
          and (TnxKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
              KeyFields[j]) is TnxTextKeyFieldDescriptor)
          and not LocalesCompatible(SegmentInfo[j].siLocale, TnxTextKeyFieldDescriptor(TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).
                    KeyFields[j]).UsedLocaleDescriptor) then
          begin
            Good := False;
            break;
          end;
        end;
      end else
        Good := False;

      if TnxSqlSELECT(FOwnerSelect).Volatile(fContext) then
        Good:=false;
      if TnxSqlSELECT(FOwnerSelect).SpecialInSubQuery then
        Good:=false;

      if Good then begin
        if IndexFieldCount = OBIndexFieldCount then begin
          if VerboseLogging then
            LogVerbose('Output already sorted correctly');
          S.SetIndex(S.IndexName(ixn));
          SortedState := ssOrdered;
          exit;
        end;
      end;
    end;
  //end;
  }
end;

function TnxSqlRowBuilder.SortWillMatch(aIndex: PnxInt32 = nil): TnxSqlSortedState;
var
  j, k : Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  Dups: TnxIndexDups;
  Filtered: Boolean;
  IndexFieldCount: Integer;
  IndexName: string;
  ConstraintName: string;

  function OBIndexFieldCount: Integer;
  begin
    if OrderByDescriptor.KeyDescriptor is TnxCompKeyDescriptor then
      Result := TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFieldCount
    else
      Result := High(Integer);
  end;

var
  IndexFields: array of record
    Index: Integer;
    Alias: string;
    FieldNumber: Integer;
    RelationOperator: TnxSqlRelOp;
  end;

  OBIndexFields: array of record
    Index: Integer;
    KeyField: TnxKeyFieldDescriptor;
    FieldNumber: Integer;
  end;

begin
  if Assigned(aIndex) then
    aIndex^ := -1;
  Result := ssUnordered; // assume we don't find anything good


  if (Sources.Count = 1)
  and (OrderByDescriptor <> nil)
  and (JoinCondition.CondTermCount = 1) then
    with JoinCondition.CondTerm[0] do begin
      if OrderedSources.Count = 1 then begin
        with OrderedSources[0] do begin
          if KeyRelation <> nil then begin
            IndexName := KeyRelation.IndexName;
            Table.GetIndexProperties(IndexName, Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName, aIndex);
            if not Filtered and (IndexFieldCount >= OBIndexFieldCount) then begin

              SetLength(OBIndexFields, OBIndexFieldCount);
              for j := Low(OBIndexFields) to High(OBIndexFields) do
                with OBIndexFields[j] do begin
                  Index := j;
                  KeyField := TnxCompKeyDescriptor(OrderByDescriptor.KeyDescriptor).KeyFields[j];
                  FieldNumber := KeyField.FieldNumber;
                end;

              SetLength(IndexFields, IndexFieldCount);
              for j := Low(IndexFields) to High(IndexFields) do
                with IndexFields[j] do begin
                  Index := j;
                  Alias := TnxSqlSELECT(FOwnerSelect).AliasFromFieldName(Table, Table.FieldNC(SegmentInfo[j].FieldNo).Name);
                  FieldNumber := OrderByScope.FindColumn(Alias);
                  if j < KeyRelation.RelationFieldCount then
                    RelationOperator := KeyRelation.Segment(j).RelationOperator;
                end;

              for j := Low(IndexFields) to High(IndexFields) do
                if IndexFields[j].RelationOperator = roEQ then
                  for k := Low(OBIndexFields) to High(OBIndexFields) do
                    if OBIndexFields[k].FieldNumber = IndexFields[j].FieldNumber then
                      OBIndexFields[k].FieldNumber := -1;

              k := 0;
              j := 0;
              while j < Length(IndexFields) do begin
                if IndexFields[j].RelationOperator <> roEQ then begin
                  if j <> k then
                    IndexFields[k] := IndexFields[j];
                  Inc(k);
                end;
                Inc(j);
              end;
              SetLength(IndexFields, k);

              k := 0;
              j := 0;
              while j < Length(OBIndexFields) do begin
                if OBIndexFields[j].FieldNumber >= 0 then begin
                  if j <> k then
                    OBIndexFields[k] := OBIndexFields[j];
                  Inc(k);
                end;
                Inc(j);
              end;
              SetLength(OBIndexFields, k);

              if Length(OBIndexFields) > Length(IndexFields) then
                Exit;

              for j := Low(OBIndexFields) to High(OBIndexFields) do
                if OBIndexFields[j].FieldNumber <> IndexFields[j].FieldNumber then
                  Exit;

              if Length(OBIndexFields) = 0 then begin
                { all order by fields are restricted to just a single value,
                  no sorting is required }
                Result := ssOrdered;
              end else
                for k := Low(OBIndexFields) to High(OBIndexFields) do
                  with OBIndexFields[k] do begin
                    j := IndexFields[k].Index;

                    if SegmentInfo[j].NullBehaviour <> KeyField.NullBehaviour then begin
                      Result := ssUnordered;
                      Break;
                    end;
                    if SegmentInfo[j].IgnoreCase
                    and ((not (KeyField is TnxTextKeyFieldDescriptor))
                    or (not TnxTextKeyFieldDescriptor(KeyField).IgnoreCase)) then begin
                      Result := ssUnordered;
                      Break;
                    end;
                    if (SegmentInfo[j].siLocale <> nil)
                    and ((not (KeyField is TnxTextKeyFieldDescriptor))
                    or (TnxTextKeyFieldDescriptor(KeyField).LocaleDescriptor = nil)
                    or not (TnxTextKeyFieldDescriptor(KeyField).LocaleDescriptor.IsEqual(SegmentInfo[j].siLocale))) then begin
                      Result := ssUnordered;
                      Break;
                    end;
                    if (SegmentInfo[j].siLocale = nil)
                    and (KeyField is TnxTextKeyFieldDescriptor)
                    then begin
                      if not LocalesCompatible(SegmentInfo[j].siLocale, TnxTextKeyFieldDescriptor(KeyField).UsedLocaleDescriptor) then
                      begin
                        Result := ssUnordered;
                        Break;
                      end;
                    end;

                    case Result of
                      ssUnordered :
                        if SegmentInfo[j].Ascending = KeyField.Ascend then
                          Result := ssOrdered
                        else
                          Result := ssReversed;
                      ssReversed :
                        if SegmentInfo[j].Ascending = KeyField.Ascend then begin
                          Result := ssUnordered;
                          Break;
                        end;
                      ssOrdered :
                        if SegmentInfo[j].Ascending <> KeyField.Ascend then begin
                          Result := ssUnordered;
                          Break;
                        end;
                    end;
                  end;
            end;

            case Result of
            ssUnordered :
              ;
            ssReversed :
              if VerboseLogging then
                LogVerbose('Output will already be sorted correctly, but reversed');
            ssOrdered :
              if VerboseLogging then
                LogVerbose('Output will already be sorted correctly');
            end;
          end;
        end;
      end;
  end;
end;

procedure TnxSqlRowBuilder.ApplyJoinRange(Table: TnxSqlTableProxy; const IndexName: string; const LowRangeValue, HighRangeValue: variant);
var
  PrimaryValues,
  SecondaryValues : TnxSqlVariantArray;
  RangeCount1, RangeCount2: Cardinal;
  OldIndexId: Integer;
begin
  Table.Cursor.sbcGetRecordCount(rcoRangedKeyCount, RangeCount1, true);
  Table.Cursor.sbcGetIndexID(OldIndexId);
  Table.SetIndex(IndexName);
  SetLength(PrimaryValues, 1);
  SetLength(SecondaryValues, 1);
  PrimaryValues[0] := LowRangeValue;
  SecondaryValues[0] := HighRangeValue;
  Table.SetRange(PrimaryValues, SecondaryValues, 1, 1, True, True, 0);
  Table.Cursor.sbcGetRecordCount(rcoRangedKeyCount, RangeCount2, true);
  if RangeCount2 * 2 > RangeCount1 then begin
    LogVerbose('Not applying join range (suboptimal)');
    LogVerbose('- Estimated range count without range:', Integer(RangeCount1));
    LogVerbose('- Estimated range count with range:', Integer(RangeCount2));
    Table.ClearRange;
    //Table.Cursor.sbcSwitchToIndex('', OldIndexID, False);
    Table.SetIndex('');
  end;
end;

function TnxSqlRowBuilder.ApplyFilterRange(Source: TnxSqlTableProxy; JoinFilters: TList): Boolean;
{- apply an index range (if one exists) to optimize reading that satisfies
   all join filter expressions}
var
  i, j, k, l, BestDepth, BestKey: Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  Dups: TnxIndexDups;
  Filtered, Found: Boolean;
  IndexFieldCount: Integer;
  KeyField, ExprField: TnxSqlFieldProxy;
  Operator: TnxSqlRelOp;
  ArgExpression: TnxSqlNode;
  IsNullTest,
  SameCase: Boolean;
  Depth: Integer;
  PrimaryValues,
  SecondaryValues : TnxSqlVariantArray;
  s: string;
  IncludeLow, IncludeHigh: Boolean;
  LowDepth, HighDepth: Integer;
  V: variant;
  ConstraintName: string;
const
  BoolStr: array[Boolean] of string = ('No', 'Yes');
begin
  Result := False;
  if VerboseLogging then begin
    LogVerbose('');
    LogVerbose('Applying join filter range for ' + TableNameStr(Source));
  end;
  BestDepth := 0;
  BestKey := -1;
  for i := 0 to Source.IndexCount - 1 do begin
    Source.GetIndexProperties(Source.IndexName(i), Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
    if not Filtered and (IndexFieldCount > 0) then begin
      if VerboseLogging then
      begin
        LogVerbose('  possible candidate key:' + Source.IndexName(i));
        s := ' ( ';
        for j := 0 to IndexFieldCount - 1 do begin
          KeyField := Source.FieldNC(SegmentInfo[j].FieldNo);
          s := s + KeyField.Name + ' [';
          s := s + NullStr[SegmentInfo[j].NullBehaviour];
          s := s + ']';
        end;
        LogVerbose(s + ')');
      end;

      {see if we have deterministic expression values to build a range on this key}

      {first, go as deep as we can on equal expressions, because we can only
       continue deeper in the key from those}
      Depth := 0;
      for j := 0 to IndexFieldCount - 1 do begin
        Found := False;
        KeyField := Source.FieldNC(SegmentInfo[j].FieldNo);
        for k := JoinFilters.Count - 1 downto 0 do
          try
            if TnxSqlCondFactor(JoinFilters[k]).IsRelationTo(
                FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
              if (ExprField = KeyField) and (Operator = roEQ) then begin
                if not SameCase then begin
                  if not SegmentInfo[j].IgnoreCase then
                    Continue;
                end;
                if VerboseLogging then
                  LogVerbose('  Found equal expression for field ' + KeyField.Name + ' : ' + ArgExpression.ToString);
                Depth := j + 1;
                Found := True;
                Break; // doesn't matter if there are more - one will do
              end;
          except
            {may fail due to binding errors - not fatal, we just don't use it}
            {remove it if it failed to bind properly}
            JoinFilters.Delete(k);
          end;
        if not Found then
          Break;
      end;

      {See if we can use the last segment (if any)}

      if Depth < IndexFieldCount then begin
        KeyField := Source.FieldNC(SegmentInfo[Depth].FieldNo);
        if SegmentInfo[Depth].Ascending then
          for k := 0 to JoinFilters.Count - 1 do
            try
              if TnxSqlCondFactor(JoinFilters[k]).IsRelationTo(
                 FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
                if (ExprField = KeyField) then
                  case Operator of
                  roLE, roL, roG, roGE :
                    begin
                      if VerboseLogging then
                        LogVerbose('  Found non-equal expression for field ' + KeyField.Name + ' : ' + ArgExpression.ToString);
                      inc(Depth);
                      Break; // one is enough - we'll rescan for the closure one (if present) later
                    end;
                  end;
            except
              {may fail due to binding errors - not fatal, we just don't use it}
            end;
      end;
      if Depth > BestDepth then begin
        BestKey := i;
        BestDepth := Depth;
      end;
    end;
  end;

//  BestKey := -1;
  if BestKey <> -1 then begin
    if VerboseLogging then
    begin
      LogVerbose('Best key:' + Source.IndexName(BestKey));
      LogVerbose(' depth:' + IntToStr(BestDepth));
    end;

    SetLength(PrimaryValues, BestDepth);
    SetLength(SecondaryValues, BestDepth);
    Source.SetIndex(Source.IndexName(BestKey));

    {build the range values}

    Source.GetIndexProperties(Source.IndexName(BestKey), Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);

    for j := 0 to nxMinI32(IndexFieldCount - 1, BestDepth - 1) do begin
      KeyField := Source.FieldNC(SegmentInfo[j].FieldNo);
      for k := 0 to JoinFilters.Count - 1 do
        if TnxSqlCondFactor(JoinFilters[k]).IsRelationTo(
            FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
          if (ExprField = KeyField) and (Operator = roEQ) then begin
            Assert(ArgExpression is TnxSqlSimpleExpression);
            PrimaryValues[j] := Unassigned;
            V := TnxSqlSimpleExpression(ArgExpression).GetValue(FContext);
            PrimaryValues[j] := V;
            SecondaryValues[j] := UnAssigned;
            V := PrimaryValues[j];
            SecondaryValues[j] := V;
            Break; // doesn't matter if there are more - one will do
          end;
    end;

    {See if we can use the last segment (if any)}

    LowDepth := BestDepth;
    HighDepth := BestDepth;
    IncludeLow := True;
    IncludeHigh := True;

    if BestDepth <= IndexFieldCount then begin
      KeyField := Source.FieldNC(SegmentInfo[BestDepth - 1].FieldNo);
      for k := 0 to JoinFilters.Count - 1 do
        if TnxSqlCondFactor(JoinFilters[k]).IsRelationTo(
            FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
          if ((ExprField = KeyField) and (ArgExpression is TnxSqlSimpleExpression)) then
            case Operator of
            roLE, roL :
              begin
                IncludeHigh := Operator = roLE;
                SecondaryValues[BestDepth - 1] := TnxSqlSimpleExpression(ArgExpression).GetValue(FContext);
                dec(LowDepth);
                // see if we can close the range
                for l := 0 to JoinFilters.Count - 1 do
                  if TnxSqlCondFactor(JoinFilters[l]).IsRelationTo(
                    FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
                    if (ExprField = KeyField) and (Operator in [roGE, roG]) then begin
                      PrimaryValues[BestDepth - 1] := TnxSqlSimpleExpression(ArgExpression).GetValue(FContext);
                      IncludeLow := Operator = roGE;
                      inc(LowDepth);
                      Break;
                    end;
              end;
            roG, roGE :
              begin
                IncludeLow := Operator = roGE;
                PrimaryValues[BestDepth - 1] := TnxSqlSimpleExpression(ArgExpression).GetValue(FContext);
                // see if we can close the range
                dec(HighDepth);
                for l := 0 to JoinFilters.Count - 1 do
                  if TnxSqlCondFactor(JoinFilters[l]).IsRelationTo(
                    FContext, Source, ExprField, Operator, ArgExpression, SameCase, IsNullTest) then
                    if (ExprField = KeyField) and (Operator in [roLE, roL]) then begin
                      SecondaryValues[BestDepth - 1] := TnxSqlSimpleExpression(ArgExpression).GetValue(FContext);
                      IncludeHigh := Operator = roLE;
                      inc(HighDepth);
                      Break;
                    end;
              end;
            end;
    end;

    if VerboseLogging then
    begin
      LogVerbose('Applying filter index range using index' + Source.IndexName(BestKey));
      LogVerbose(' range - low depth:' + IntToStr(LowDepth) + ' high depth:' + IntTostr(HighDepth) + ' ilo:' + BoolStr[IncludeLow] + ' ihi:' + BoolStr[IncludeHigh]);
    end;
    Source.SetRange(PrimaryValues, SecondaryValues, LowDepth, HighDepth, IncludeLow, IncludeHigh, 0);
    Result := True;

  end else
    if VerboseLogging then
      LogVerbose('No suitable index found');
  if VerboseLogging then
    LogVerbose('');
end;

function TnxSqlRowBuilder.CanJoinViaIndex(Source: TnxSqlTableProxy;
  JoinFields: array of TnxSqlFieldProxy; SwitchTo: Boolean; MustBeForward: Boolean;
  var IsUnique: Boolean): Boolean;
{- select an index range (if one exists) that lists all the join fields from left to right}
var
  i, j: Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  Dups: TnxIndexDups;
  Filtered: Boolean;
  IndexFieldCount: Integer;
  KeyField: TnxSqlFieldProxy;
  s: string;
  Match: Boolean;
  ConstraintName: string;
begin
  Result := False;
  if VerboseLogging then
    LogVerbose('Looking for existing join index');
  for i := 0 to Source.IndexCount - 1 do begin
    Source.GetIndexProperties(Source.IndexName(i), Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
    if not Filtered and (IndexFieldCount > 0) then begin
      if VerboseLogging then
      begin
        LogVerbose('  possible candidate key:' + Source.IndexName(i));
        s := ' ( ';
        for j := 0 to IndexFieldCount - 1 do begin
          KeyField := Source.FieldNC(SegmentInfo[j].FieldNo);
          s := s + KeyField.Name + ' [';
          s := s + NullStr[SegmentInfo[j].NullBehaviour];
          if SegmentInfo[j].siLocale = nil then
            s := s + ', no expl. locale'
          else begin
            s := s + ', locale:' + IntToStr(SegmentInfo[j].siLocale.Locale);
          end;
          if SegmentInfo[j].IgnoreCase then begin
            s := s + ', ignore case'
          end;

          s := s + ']';
        end;
        LogVerbose(s + ')');
      end;

      if IndexFieldCount >= length(JoinFields) then begin
        Match := True; // assume success
        for j := 0 to high(JoinFields) do begin
          if (SegmentInfo[j].FieldNo <> JoinFields[j].Index)
          {can't use an index if it doesn't have nulls}
          {or SegmentInfo[j].IsTextKey
          and (SegmentInfo[j].siLocale <> nil)
          and (SegmentInfo[j].siLocale.Locale <> JoinFields[j].GetLocale)
           locale doesn't matter here since we're comparing for equality}
          or not (SegmentInfo[j].NullBehaviour in [nbTop, nbBottom, nbAsAscend]) then begin
            Match := False;
            Break;
          end;
          if MustBeForward and not SegmentInfo[j].Ascending then begin
            Match := False;
            Break;
          end;
          if MustBeForward {<- Caution! non-obvious use of MustBeForward: true means we're merge joining, in which case locale matters}
          and SegmentInfo[j].IsTextKey
          and (SegmentInfo[j].siLocale <> nil)
          and (SegmentInfo[j].siLocale.Locale <> JoinFields[j].GetLocale) then begin
            Match := False;
            Break;
          end;
          if (JoinFields[j].GetType = nxtGUID) and not SegmentInfo[j].IsTextKey then begin
            {GUID comparison must be string-based}
            Match := False;
            Break;
          end;
        end;
        if Match then begin
          // All fields found. Select this index and flag success
          if VerboseLogging then
            LogVerbose('Found suitable join index: ' + Source.IndexName(i));
          if SwitchTo then
            Source.SetIndex(Source.IndexName(i));
          Result := True;
          //Log('Join table by index');
          //DumpTable(Source);
          IsUnique := (Dups <> idAll) and (IndexFieldCount = length(JoinFields));
          if IsUnique then begin
            if VerboseLogging then
              LogVerbose('Join index is unique');
            exit;
          end;
        end;
      end;

    end;
  end;

  {if not Result then
    if Source.IsTemp then
      TryToAddSuitableIndex;}

  if not Result then
    if VerboseLogging then
      LogVerbose('No suitable index found');
end;

function TnxSqlRowBuilder.HaveJoinRangeIndex(const FirstJoinFields  : array of TnxSqlFieldProxy;
                                                   Source           : TnxSqlTableProxy;
                                             const SecondJoinFields : array of TnxSqlFieldProxy;
                                               var JoinFieldIndex   : Integer;
                                               var IndexName        : string)
                                                                    : Boolean;
{- see if we have a (preferably unique) index that starts with one of the join columns.
   if we do, return the name of the index and the index of the attribute in the join list.}
var
  i, j: Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  Dups: TnxIndexDups;
  Filtered: Boolean;
  IndexFieldCount: Integer;
  KeyField: TnxSqlFieldProxy;
  s: string;
  Match, IsUnique: Boolean;
  ConstraintName: string;
  LocaleDescriptor: TnxLocaleDescriptor;
begin
  Result := False; // assume failure
  if Length(SecondJoinFields) < 1 then
    Exit;

  if VerboseLogging then
    LogVerbose('Looking for join range index on ' + TableNameStr(Source));
  for i := 0 to Source.IndexCount - 1 do begin
    Source.GetIndexProperties(Source.IndexName(i), Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
    if not Filtered and (IndexFieldCount > 0) then begin
      if VerboseLogging then
      begin
        LogVerbose('  possible candidate key:' + Source.IndexName(i));
        s := ' ( ';
        for j := 0 to IndexFieldCount - 1 do begin
          KeyField := Source.FieldNC(SegmentInfo[j].FieldNo);
          s := s + KeyField.Name + ' [';
          if not SegmentInfo[j].Ascending then
            s := s + ', descending ';
          s := s + NullStr[SegmentInfo[j].NullBehaviour];
          if SegmentInfo[j].siLocale = nil then
            s := s + ', no expl. locale'
          else begin
            s := s + ', locale:' + IntToStr(SegmentInfo[j].siLocale.Locale);
          end;
          if SegmentInfo[j].IgnoreCase then
            s := s + ', ignore case';
          s := s + ']';
        end;
        LogVerbose(s + ')');
      end;

      for j := 0 to high(SecondJoinFields) do begin
        Match := True; // assume success
        if (SegmentInfo[0].FieldNo <> SecondJoinFields[j].Index)
        {can't use an index if it doesn't have nulls}
        {or SegmentInfo[j].IsTextKey
        and (SegmentInfo[j].siLocale <> nil)
        and (SegmentInfo[j].siLocale.Locale <> SecondJoinFields[j].GetLocale)
         locale doesn't matter here since we're comparing for equality}
        or not (SegmentInfo[0].NullBehaviour in [nbTop, nbBottom, nbAsAscend]) then
          Match := False
        else
        if SegmentInfo[0].IgnoreCase then
          Match := False
        else
        if not SegmentInfo[0].Ascending then
          Match := False
        else
        if (SecondJoinFields[j].GetType = nxtGUID) and not SegmentInfo[0].IsTextKey then
          {GUID comparison must be string-based}
          Match := False;

        if Match then begin
          if Length(FirstJoinFields) >= j then
            LocaleDescriptor := FirstJoinFields[j].GetLocaleDesc
          else
            LocaleDescriptor := nil;

          if Assigned(SegmentInfo[0].siLocale) <> Assigned(LocaleDescriptor) then
            Match := False
          else if Assigned(LocaleDescriptor) then
            if not LocaleDescriptor.IsEqual(SegmentInfo[0].siLocale) then
              Match := False;
        end;

        if Match then begin
          // Index found. Select this index and flag success
          if VerboseLogging then begin
            LogVerbose('Found suitable join range index: ' + Source.IndexName(i));
            LogVerbose('Join field:' + SecondJoinFields[j].Name);
          end;
          IndexName := Source.IndexName(i);
          Result := True;
            JoinFieldIndex := j;
          IsUnique := (Dups <> idAll) and (IndexFieldCount = 1);
          if IsUnique then begin
            if VerboseLogging then
              LogVerbose('Join index is unique');
            exit;
          end;
        end;
      end;

    end;
  end;

  if not Result then
    if VerboseLogging then
      LogVerbose('No suitable join range index found');
end;

function TnxSqlRowBuilder.GetDrivingTable(Range1,
  Range2: TnxSqlRowRange; JoinFilters1, JoinFilters2: TList; Context: TnxSqlContext): TnxSQLLeftRight;
var
  LUnfiltRecCount: integer;
  RUnfiltRecCount: integer;
  U1, U2: Boolean;
  aRatio: double;
  GlF1: TList;
  GlF2: TList;
  JF: TList;
  I: Integer;
  ResultFound: Boolean;
begin
//  result:=lrLeft;

  if VerboseLogging then
  begin
    LogVerbose('Deciding on better table for resolving relation between '+TableNameStr(Range1.Table)+' and '+TableNameStr(Range2.Table));
  end;

  if VerboseLogging then
    LogVerbose('Estimating participating keys ...');

{$ifdef PullFiltersFromOROps}
  if Range1.Table.IsJoinResult then
    if not Range2.Table.IsJoinResult then
    begin
      result:=lrLeft;
      exit;
    end;

  if Range2.Table.IsJoinResult then
    if not Range1.Table.IsJoinResult then
    begin
      result:=lrRight;
      exit;
    end;
{$endif}

  // that's still a pretty simple logic. we need to improve that by
  // getting some more calculation about equal transitions to the other table
  // etc into the CalcEstimatedCount's JoinFilters
  GlF1:=nil;
  GlF2:=nil;
  JF:=nil;
  if (JoinFilters1=nil) and (JoinFilters2=nil) then
  begin
    GlF1:=TList.Create;
    GlF2:=TList.Create;
    JF:=TList.Create;
    JoinFilters1:=GlF1;
    JoinFilters2:=GlF2;
    GetGlobalJoinFilters(Range1.Table, Range2.Table, JoinFilters1, JoinFilters2, JF);
  end;

  try
    CalcEstimatedRangeCount(Range1, JoinFilters1, false);
    CalcEstimatedRangeCount(Range2, JoinFilters2, false);
  finally
    if glF1<>nil then
      for I := 0 to glF1.Count - 1 do
        TObject(GlF1[i]).Free;

    if glF1<>nil then
      for I := 0 to glF2.Count - 1 do
        TObject(glF2[i]).Free;

    nxFreeAndNil(glF1);
    nxFreeAndNil(glF2);
    nxFreeAndNil(JF);
  end;

  LUnfiltRecCount := Range1.EstimatedRangeCount;
  RUnfiltRecCount := Range2.EstimatedRangeCount;


  if VerboseLogging then
  begin
    if Range1.Table.Cursor is TnxServerTableCursor then
      LogVerbose(TableNameStr(Range1.Table)+' has '+inttostr(TnxServerTableCursor(Range1.Table.Cursor).RangeStart.riFieldCount)+' filters');
    if Range2.Table.Cursor is TnxServerTableCursor then
      LogVerbose(TableNameStr(Range2.Table)+' has '+inttostr(TnxServerTableCursor(Range2.Table.Cursor).RangeStart.riFieldCount)+' filters');
    LogVerbose(TableNameStr(Range1.Table)+' has '+inttostr(LUnfiltRecCount)+' estimated keys');
    LogVerbose(TableNameStr(Range2.Table)+' has '+inttostr(RUnfiltRecCount)+' estimated keys');
  end;

  {figure out which table we're going to iterate over first}
  {if one table has filters but the other doesn't, use the filtered one first}

 ResultFound := False;
 Result := lrLeft; // to satisfy the compiler

//  aRatio := 0; //??
  if (not Assigned(FOwnerStatement)) or FOwnerStatement.FeatureEnabled('ChooseDriverTableBasedOnFilterOrTemp', True) then begin
    {if one of the tables has filters and the other one not then select it }
    if (TnxServerTableCursor(Range2.Table.Cursor).RangeStart.riValid) and (not TnxServerTableCursor(Range1.Table.Cursor).RangeStart.riValid) then
    begin
      LogVerbose(TableNameStr(Range2.Table) + ' chosen based on filter');
      result:=lrRight;
      ResultFound := True;
    end
    else
    if (TnxServerTableCursor(Range1.Table.Cursor).RangeStart.riValid) and (not TnxServerTableCursor(Range2.Table.Cursor).RangeStart.riValid) then
    begin
      LogVerbose(TableNameStr(Range1.Table) + ' chosen based on filter');
      result:=lrLeft;
      ResultFound := True;
    end
    else
    if (Range1.Table.IsTemp) and (not Range2.Table.IsTemp) and (LUnfiltRecCount>10)then
    begin
      LogVerbose(TableNameStr(Range2.Table) + ' chosen based on the other being a temp');
      result:=lrRight;
      ResultFound := True;
    end
    else
    if (Range2.Table.IsTemp) and (not Range1.Table.IsTemp) and (RUnfiltRecCount>10)then
    begin
      LogVerbose(TableNameStr(Range1.Table) + ' chosen based on the other being a temp');
      result:=lrLeft;
      ResultFound := True;
    end;
  end;

  if not ResultFound then begin
    if RUnfiltRecCount < LUnfiltRecCount then
    begin
      aRatio := (RUnfiltRecCount+1) / (LUnfiltRecCount+1);
      result:=lrRight;
    end
    else
    begin
      aRatio := (LUnfiltRecCount+1) / (RUnfiltRecCount+1);
      result:=lrLeft;
    end;

    if aRatio>0.1 then // only when we've not MUCH more in one table
    if (Range1.KeyRelation<>nil) and (Range2.KeyRelation<>nil) then
    begin
      U1 := Range1.KeyRelation.RelationKeyIsUnique;
      U2 := Range2.KeyRelation.RelationKeyIsUnique;
      if U1 then
        if not U2 then begin
          Result := lrRight;
          if VerboseLogging then
            LogVerbose('2 is better, unique relation key');
        end else
      else
        if U2 then begin
          Result := lrLeft;
          if VerboseLogging then
            LogVerbose('2 is better, unique relation key');
        end;
    end;
  end;

  if VerboseLogging then
  begin
    if result=lrRight then
      LogVerbose('Picked table "'+TableNameStr(Range2.Table)+'" as the better table to iterate over first')
    else
      LogVerbose('Picked table "'+TableNameStr(Range1.Table)+'" as the better table to iterate over first');
  end;

end;

function TnxSqlRowBuilder.VerboseLogging: boolean;
begin
  result:=false;
  if assigned(FOwnerStatement) then
    result:=FOwnerStatement.VerboseLogging;
end;

function TnxSqlRowBuilder.NormalLogging: boolean;
begin
  result:=false;
  if assigned(FOwnerStatement) then
    result:=FOwnerStatement.Logging;
end;

(*procedure TnxSqlRowBuilder.ClearBindings(Node: TnxSqlNode;
  UserData: TObject);
begin
  if Node is TnxSqlFieldRef then
    TnxSqlFieldRef(Node).Unbind;
end;*)

{ TnxSqlRecPosList }

procedure TnxSqlRecPosList.Add(const P: int64);
begin
  if FCount >= FBufferCount then begin
    inc(FBufferCount, 4096 div sizeof(int64));
    nxReallocMem(FBuffer, FBufferCount * sizeof(int64));
  end;
  FBuffer^[FCount] := P;
  inc(FCount);
end;

procedure TnxSqlRecPosList.Clear;
begin
  FCount := 0;
end;

destructor TnxSqlRecPosList.Destroy;
begin
  if FBuffer <> nil then
    nxFreeMem(FBuffer);
end;

{function TnxSqlRecPosList.GetBuffer: PnxSqlInt64Array;
begin
  Result := FBuffer;
end;}

function TnxSqlRowBuilder.ExecuteBinaryMergeJoin(
  JoinMode: TnxSqlOuterJoinMode;
  JoinFactors, JoinFiltersT1, JoinFiltersT2: TList;
  var RecordsRead: Integer): Boolean;

var
  RR, RW: Integer;

  function PrepareTable(Source: TnxSqlTableProxy; JoinFields: array of TnxSqlFieldProxy;
    JoinFilters: TList; var aDirect: Boolean): TnxSqlTableProxy;
  var
    FieldDefList : TnxSqlFieldDefList;
    i: Integer;
    RecordCopier : TnxSqlRecordCopier;
    Include: Boolean;
    Status: TnxResult;
    IndexDescriptor : TnxIndexDescriptor;
    lRR, lRW: Integer;
    IsUnique: Boolean;
    RecIdField: TnxSqlFieldProxy;
    //aDec: integer;
  begin
    aDirect := False; // assume not using the table directly
    {prepare table}
    if VerboseLogging then
      LogVerbose('Preparing ' + TableNameStr(Source));

    if JoinFilters.Count > 0 then begin
      if VerboseLogging then
        LogVerbose('Filters:');
      for i := 0 to JoinFilters.Count - 1 do
        if VerboseLogging then
          LogVerbose(TnxSqlCondFactor(JoinFilters[i]).ToString);
    end else begin
      if VerboseLogging then
        LogVerbose('No filters');
      // see if we have an index that has all the join attributes in its left-most columns.
      // if we do, select that and indicate to the main logic that we're joining directly
      //   on the source table.

      if CanJoinViaIndex(Source, JoinFields, True, True, IsUnique) then begin
        if VerboseLogging then
          LogVerbose('Table seems to have a join index');

        Result := Source;
        aDirect := True;
        exit;
      end;
    end;

    if VerboseLogging then
      LogVerbose('Table has no join index - building indirection table');

    lRR := 0;
    lRW := 0;

    FieldDefList := TnxSqlFieldDefList.Create;
    try
      for i := 0 to high(JoinFields) do begin
        with JoinFields[i] do
        begin
          {aDEc:=GetDecimals;
          if GetType in [nxtNullString, nxtWideString, nxtShortString] then
            aDec:=0;}
          FieldDefList.AddField(Name, '', GetType, GetSize, {aDec???}0, 0, 0, False, dtNull, null, [aaClient, aaServer], True, False, False, False, GetLocaleDesc, False);
        end;
      end;
      FieldDefList.AddField('recno', '', nxtInt64, 8, 0, 0, 0, False, dtNull, null, [aaClient, aaServer], True, False, False, False, nil, False);
      Result := FDatabase.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      nxFreeAndNil(FieldDefList);
    end;

    RecordCopier := TnxSqlRecordCopier.Create(False, (FOwnerSelect as TnxSqlSELECT).IsView);
    try

      for i := 0 to high(JoinFields) do
        RecordCopier.Add(Source.FieldByName(JoinFields[i].Name), Result.FieldNC(i));

      RecIdField := Result.FieldC(length(JoinFields));

      if JoinFilters.Count > 0 then
        ApplyFilterRange(Source, JoinFilters);

      FDatabase.StartTransaction([nil], False, True);
      try
        if Source.First then
          repeat
            inc(lRR);
            if lRR mod 1024 = 0 then
              nxCheckRemainingTime;
            Include := True;
            for i := 0 to JoinFilters.Count - 1 do
              if TnxSqlCondFactor(JoinFilters[i]).AsBoolean(FContext) <> tsbTrue then begin
                Include := False;
                Break;
              end;
            if Include then begin
              inc(lRW);
              Result.Insert;
              RecordCopier.Execute;
              RecIdField.SetValue(Source.GetCurrentRecordID);
              Result.Post(False);
            end;
          until not Source.Next;
        FDatabase.Commit;
      except
        FDatabase.AbortTransaction;
        raise;
      end;
      if VerboseLogging then
        LogVerbose('Rows copied:', lRW);
      inc(RR, lRR);
    finally
      nxFreeAndNil(RecordCopier);
    end;

    IndexDescriptor := TnxIndexDescriptor.CreateStandalone(0, 'SortIndex', 0, TnxCompKeyDescriptor);
    try
      for i := 0 to high(JoinFields) do
      begin
        TnxCompKeyDescriptor(IndexDescriptor.KeyDescriptor).Add(i, TnxExtTextKeyFieldDescriptor);
        if JoinFields[i].Descriptor.UsedLocaleDescriptor<>nil then
          TnxCompKeyDescriptor(IndexDescriptor.KeyDescriptor).KeyFields[i].AddLocaleDescriptor.Assign(JoinFields[i].Descriptor.UsedLocaleDescriptor);
      end;

{      IndexDescriptor.Dups:=idAll;
      if  Result.AddAndSetIndex(IndexDescriptor) then
        Status := DBIERR_NONE
      else
        raise EnxInternalSQLException.Create('error creating sorting index');}
// retired!
      Status := (Result.Cursor as TnxServerTableCursor).stcSortRecords(IndexDescriptor);
      if Status <> DBIERR_NONE then
        raise EnxSqlException.nxCreate(Status);
    finally
      nxFreeAndNil(IndexDescriptor);
    end;
  end;

  procedure GetMatching(T: TnxSqlTableProxy; Direct: Boolean;
    CompareEngine: TnxBaseKeyEngine; CompFieldCount: Integer;
    Matches: TnxSqlRecPosList; var FirstNonMatch: int64;
    const JoinFields: array of TnxSqlFieldProxy;
    CompRec: PnxRecordBuffer; HaveCompRec: Boolean);
  var
    Match2: Boolean;
    StartPos: int64;
    SaveRec: PnxRecordBuffer;
    rl: Integer;
  begin
    StartPos := T.GetCurrentRecordID;
    Assert(StartPos <> 0);
    SaveRec := nil;
    try
      Matches.Clear;
      rl := T.Cursor._Dictionary.FieldsDescriptor.RecordLength;
      SaveRec := nxGetMem(rl + SizeOf(Pointer));
      Move(T.RecordBuffer^, SaveRec^, rl);
      Matches.Add(T.GetCurrentRecordID);
      FirstNonMatch := 0;
      while T.Next do begin
        {if we have a compare rec with the key value from the opposite table,
         we can continue for as long as our join key is below that of the other table}
        Match2 := HaveCompRec and
          (CompareEngine.CompareRecord(CompRec, 0, T.RecordBuffer, 0, CompFieldCount, 0) > 0)
        or (CompareEngine.CompareRecord(SaveRec, 0, T.RecordBuffer, 0, CompFieldCount, 0) = 0);
        if Match2 then begin
          Matches.Add(T.GetCurrentRecordID);
        end else begin
          FirstNonMatch := T.GetCurrentRecordID;
          Break;
        end;

      end;
    finally
      if SaveRec <> nil then
        nxFreeMem(SaveRec);
      T.ClearNoRecordFlag;
      T.GetRecordByID(StartPos, nxltNoLock); // reposition
    end;
  end;

var
  i, j: Integer;
  TL, TR: TnxSqlTableProxy;
  TempL, TempR: TnxSqlTableProxy;
  F: TnxSqlFieldProxy;
  Op: TnxSqlRelOp;
  ArgExp: TnxSqlNode;
  IsNullTest,
  SameCase: Boolean;
  JoinFieldsL, JoinFieldsR: array of TnxSqlFieldProxy;
  JoinAttrCount: Integer;
  HaveLeft, HaveRight: Boolean;
  MatchLeft, MatchRight: TnxSqlRecPosList;
  SavePos,
  FirstNonMatchL, FirstNonMatchR: int64;
  CompRes: Integer;
  LV, RV: variant;
  NullInComp, NullInLeft, NullInRight: Boolean;
  PrepStart, Start: Cardinal;
  OwnerWhere: TnxSqlCondExp;
  DirectL, DirectR: Boolean;
  OwnerTerm: TnxSqlCondTerm;
  FLeq, FReq: TnxSqlFieldProxy;
  Fc: string;
  CFCopy : TnxSqlCondFactor;
  NewTableName, NewColumnName: string;
  Counter: Integer;
  CompareDictionaryL, CompareDictionaryR : TnxDataDictionary;
  CompareEngineL, CompareEngineR: TnxBaseKeyEngine;
  CompFieldCountL, CompFieldCountR: Integer;
  CompRecLeftLayoutRightValues,
  CompRecRightLayoutLeftValues: PnxRecordBuffer;
  HaveLeftCompRec, HaveRightCompRec: Boolean;
  Tmp: PnxRecordBuffer;
  MatchBuffer, MatchBuffer2: PnxSqlInt64Array;
  LUnfiltRecCount, RUnfiltRecCount: Cardinal;
  ClonedCondFact: TnxSqlCondFactor;
  TempLRecIDField,
  TempRRecIDField: TnxSqlFieldProxy;
  KeepGoing: Boolean;
begin
  if VerboseLogging then
    LogVerbose('Preparing for possible merge join');
  OwnerWhere := (FOwnerSelect as TnxSqlSELECT).CondExpWhere;
  if OwnerWhere <> nil then
    if VerboseLogging then
      LogVerbose('Outer filter expression: ' + OwnerWhere.ToString);
  TL := Sources.Item[0].Table;
  TR := Sources.Item[1].Table;

  if TL.Cursor._Dictionary.UsedStorageCodePage<>TR.Cursor._Dictionary.UsedStorageCodePage then
  begin
    LogVerbose('Codepages of tables don''t match. Can''t merge join.');
    result:=false;
    exit;
  end;

  if VerboseLogging then
  begin
    LogVerbose('Simple outer join between ' + TableNameStr(Sources.Item[0].Table) + ' and ' + TableNameStr(Sources.Item[1].Table));
    LogVerbose(TableNameStr(Sources.Item[0].Table) + ' - Rows in table:' + format('%.0n', [Sources.Item[0].Table.GetRecordCount * 1.0]));
    LogVerbose(TableNameStr(Sources.Item[1].Table) + ' - Rows in table:' + format('%.0n', [Sources.Item[1].Table.GetRecordCount * 1.0]));
  end;

  JoinAttrCount := JoinFactors.Count;
  SetLength(JoinFieldsL, JoinAttrCount);
  SetLength(JoinFieldsR, JoinAttrCount);

  {discover join attributes in order}
  for i := 0 to JoinAttrCount - 1 do begin
    if not TnxSqlCondFactor(JoinFactors[i]).IsRelationTo(FContext, TL, F, Op, ArgExp, SameCase, IsNullTest) then begin
      {oops - should not happen}
      Result := False;
      exit;
    end;
    JoinFieldsL[i] := F;
    if not TnxSqlCondFactor(JoinFactors[i]).IsRelationTo(FContext, TR, F, Op, ArgExp, SameCase, IsNullTest) then begin
      {oops - should not happen}
      Result := False;
      exit;
    end;
    JoinFieldsR[i] := F;
  end;


  for I := Low(JoinFieldsL) to High(JoinFieldsL) do
    if ((JoinFieldsL[i].GetPhysicalSize<>JoinFieldsR[i].GetPhysicalSize)
      or (JoinFieldsL[i].GetType<>JoinFieldsR[i].GetType)) then
    begin
      if VerboseLogging then
        LogVerbose('Join field types are no exact match. Can''t use merge join');
      result:=false;
      exit;
    end;


  if VerboseLogging then
  begin
    LogVerbose('Join attributes:');
    for i := 0 to high(JoinFieldsL) do
      LogVerbose(' ' + JoinFieldsL[i].Name + ' and ' + JoinFieldsR[i].Name);
    LogVerbose('');
  end;
  RR := 0;
  RW := 0;
  Start := GetTickCount;

  Result := True;

  TempL := nil;
  TempR := nil;
  CompareDictionaryL := nil;
  CompareDictionaryR := nil;
  CompareEngineL := nil;
  CompareEngineR := nil;
  CompRecLeftLayoutRightValues := nil;
  CompRecRightLayoutLeftValues := nil;
  HaveLeftCompRec := False;
  HaveRightCompRec := False;
  MatchLeft := TnxSqlRecPosList.Create;
  MatchRight := TnxSqlRecPosList.Create;
  try

    PrepStart := GetTickCount;
    {clone conditions from outer WHERE expression that refer to this table}
    if (FOwnerJoin <> nil) and (OwnerWhere <> nil)
    and (OwnerWhere.CondTermCount = 1) {can't handle OR in combination with other filters} then begin
      OwnerTerm := OwnerWhere.CondTerm[0];
      for i := 0 to OwnerTerm.CondFactorCount - 1 do begin
        ClonedCondFact := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
        try
          if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, TL, Fc)
          {and not (ClonedCondFact.RefersToContextVars(FContext))} then begin
            JoinFiltersT1.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
            ClonedCondFact := nil;
            // see if we have an equal transition to the other table
            for j := 0 to JoinFactors.Count - 1 do
              if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True)
              and SameText(Fc, FLeq.Name) then begin
                CFCopy := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
                if TR.Alias <> '' then
                  NewTableName := TR.Alias
                else
                  NewTableName := TR.Name;
                NewColumnName := FReq.Name;
                if (NewTableName <> '') and CFCopy.AlterTableRef(NewTableName, NewColumnName) then begin
                  JoinFiltersT2.Add(CFCopy);
                  Break;
                end else
                  CFCopy.Free;
              end;
          end else
          if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, TR, Fc)
          {and not (ClonedCondFact.RefersToContextVars(FContext))} then begin
            JoinFiltersT2.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
            ClonedCondFact := nil;
            // see if we have an equal transition to the other table
            for j := 0 to JoinFactors.Count - 1 do
              if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True)
              and SameText(Fc, FReq.Name) then begin
                CFCopy := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
                if TL.Alias <> '' then
                  NewTableName := TL.Alias
                else
                  NewTableName := TL.Name;
                NewColumnName := FLeq.Name;
                if (NewTableName <> '') and CFCopy.AlterTableRef(NewTableName, NewColumnName) then begin
                  JoinFiltersT1.Add(CFCopy);
                  Break;
                end else
                  CFCopy.Free;
              end;
          end;
        finally
          ClonedCondFact.Free;
        end;
      end;
    end;


    LUnfiltRecCount := TL.GetRecordCount;
    RUnfiltRecCount := TR.GetRecordCount;

    TempL := PrepareTable(TL, JoinFieldsL, JoinFiltersT1, DirectL);
    if VerboseLogging then
      LogVerbose('');
    TempR := PrepareTable(TR, JoinFieldsR, JoinFiltersT2, DirectR);
    if VerboseLogging then
      LogVerbose('');

    CompRecLeftLayoutRightValues := nxGetMem(TempL.Cursor._Dictionary.FieldsDescriptor.RecordLength + SizeOf(Pointer));
    CompRecRightLayoutLeftValues := nxGetMem(TempR.Cursor._Dictionary.FieldsDescriptor.RecordLength + SizeOf(Pointer));

    if (JoinMode in [jmNone, jmLeft]) and DirectR and (TR.GetRecordCount > TL.GetRecordCount * 10) then begin
      if not (TL.GetRecordCount < LUnfiltRecCount div 10)
      and not (TR.GetRecordCount < RUnfiltRecCount div 10) then begin
        TL.ClearRange;
        TR.ClearRange;
        Result := False;
        exit;
      end;
    end;

    if (JoinMode in [jmNone, jmRight]) and DirectL and (TL.GetRecordCount > TR.GetRecordCount * 10) then begin
      if not (TL.GetRecordCount < LUnfiltRecCount div 10)
      and not (TR.GetRecordCount < RUnfiltRecCount div 10) then begin
        TL.ClearRange;
        TR.ClearRange;
        Result := False;
        exit;
      end;
    end;

    {
    if (JoinMode <> jmFull)
    and DirectL and DirectR then begin
      Result := False;
      exit;
    end;
    }

    if NormalLogging then
    begin
      LogNormal('');
      LogNormal('Merge join');
      LogNormal('');
      {$IFOPT Q+}
        {$DEFINE LocalOverflowCheckOFF}
        {$OVERFLOWCHECKS OFF}
      {$ENDIF}
      LogNormal('Prep-time:' + IntToStr(GetTickCount - PrepStart));
      {$IFDEF LocalOverflowCheckOFF}
        {$OVERFLOWCHECKS ON}
        {$UNDEF LocalOverflowCheckOFF}
      {$ENDIF}
    end;

    inc(RecordsRead, RR);
    if NormalLogging then
      LogNormal('Records read:' + IntToStr(RR));

    {do the merge}

    HaveLeft := TempL.First;
    HaveRight := TempR.First;
    KeepGoing := True;

    Counter := 0;

    BuildCompareDictionary(JoinFieldsL, CompFieldCountL, CompareDictionaryL, DirectL, CompareEngineL, TempL);
    BuildCompareDictionary(JoinFieldsR, CompFieldCountR, CompareDictionaryR, DirectR, CompareEngineR, TempR);

    if DirectL then
      TempLRecIDField := nil // not used
    else
      TempLRecIDField := TempL.FieldC(JoinAttrCount);

    if DirectR then
      TempRRecIDField := nil // not used
    else
      TempRRecIDField := TempR.FieldC(JoinAttrCount);

    {We are about to do a merge join}
    if LimitDependsOnMatchingSort then begin
      if Limit > -1 then begin
        case SortWillMatch of
          ssUnordered: begin
            LogNormal('About to perform a merge join, limit depending on sort order active and sort order doesn''t match - disable limit optimization (limit must be applied after sorting result)');
            Limit := -1; //need to apply limit after sorting later
          end;
          ssReversed: begin
            LogNormal('About to perform a merge join, limit depending on sort order active and sort order is reverse - disable limit optimization (limit must be applied after sorting result)');
            Limit := -1; //need to apply limit after sorting later
          end;
          ssOrdered: begin
          end;
        end;
      end;
    end;

    while (HaveLeft or HaveRight) and KeepGoing do begin

      inc(Counter);
      if Counter mod 1024 = 0 then
        nxCheckRemainingTime;

      if HaveLeft then
        GetMatching(TempL, DirectL, CompareEngineL, CompFieldCountL, MatchLeft, FirstNonMatchL, JoinFieldsL,
          CompRecLeftLayoutRightValues, HaveLeftCompRec)
      else
        //SetLength(MatchLeft, 0);
        MatchLeft.Clear;

      if HaveRight then
        GetMatching(TempR, DirectR, CompareEngineR, CompFieldCountR, MatchRight, FirstNonMatchR, JoinFieldsR,
          CompRecRightLayoutLeftValues, HaveRightCompRec)
      else
        //SetLength(MatchRight, 0);
        MatchRight.Clear;

      HaveLeftCompRec := False;
      HaveRightCompRec := False;

      if not HaveLeft then
        case JoinMode of
        jmNone, jmLeft :
          Break;
        else
          if not HaveRight then
            Break;
          // null records
          TL.NullRecord;
          MatchBuffer := MatchRight.Buffer;
          for j := 0 to MatchRight.Count - 1 do begin
            TempR.GetRecordByIDDirect(MatchBuffer^[j]{MatchRight[j]});
            if not DirectR then begin
              TR.GetRecordByIDDirect(TempRRecIDField.GetValue);
            end;
            KeepGoing := CreateResultRecord(nil);
            inc(RW);
          end;
          if FirstNonMatchR <> 0 then begin
            TempR.ClearNoRecordFlag;
            TempR.GetRecordByID(FirstNonMatchR, nxltNoLock);
          end else
            HaveRight := False;
        end;

      if not HaveRight then
        case JoinMode of
        jmNone, jmRight :
          Break;
        else
          if not HaveLeft then
            Break;
          // null records
          TR.NullRecord;
          MatchBuffer := MatchLeft.Buffer;
          for i := 0 to MatchLeft.Count - 1{ high(MatchLeft)} do begin
            TempL.GetRecordByIDDirect(MatchBuffer[i]{MatchLeft[i]});
            if not DirectL then begin
              TL.GetRecordByIDDirect(TempLRecIDField.GetValue);
            end;
            KeepGoing := CreateResultRecord(nil);
            inc(RW);
          end;
          if FirstNonMatchL <> 0 then begin
            TempL.ClearNoRecordFlag;
            TempL.GetRecordByID(FirstNonMatchL, nxltNoLock)
          end else
            HaveLeft := False;
        end;

      if HaveLeft and HaveRight then begin
        CompRes := 1;
        NullInComp := False;
        NullInLeft := False;
        NullInRight := False;

        for i := 0 to JoinAttrCount - 1 do begin
          if DirectL then
            LV := JoinFieldsL[i].GetValue(nil, false, nxtByte, false)
          else
            LV := TempL.FieldNC(i).GetValue(nil, false, nxtByte, false);
          if DirectR then
            RV := JoinFieldsR[i].GetValue(nil, false, nxtByte, false)
          else
            RV := TempR.FieldNC(i).GetValue(nil, false, nxtByte, false);
          NullInComp := NullInComp or VarIsNull(LV) or VarIsNull(RV);
          NullInLeft := NullInLeft or VarIsNull(LV);
          NullInRight := NullInRight or VarIsNull(RV);

          if {LV < RV} SimpleCompare(roL, LV, RV, JoinFieldsL[i].Descriptor.UsedLocaleDescriptor, JoinFieldsR[i].Descriptor.UsedLocaleDescriptor, false, false) then begin
            CompRes := 0;
            Break;
          end else
          if  {LV > RV} SimpleCompare(roG, LV, RV, JoinFieldsL[i].Descriptor.UsedLocaleDescriptor, JoinFieldsR[i].Descriptor.UsedLocaleDescriptor, false, false) then begin
            CompRes := 2;
            Break;
          end;
        end;

        case CompRes of
        0 :
          begin
            // left is smaller
            if JoinMode in [jmLeft, jmFull] then begin
              // write null records
              SavePos := TempR.GetCurrentRecordID;
              TR.NullRecord;
              MatchBuffer := MatchLeft.Buffer;
              for i := 0 to MatchLeft.Count - 1{ high(MatchLeft)} do begin
                TempL.GetRecordByIDDirect(MatchBuffer^[i]{MatchLeft[i]});
                if not DirectL then begin
                  TL.GetRecordByIDDirect(TempLRecIDField.GetValue);
                end;
                KeepGoing := CreateResultRecord(nil);
                inc(RW);
              end;
              TempR.ClearNoRecordFlag;
              TempR.GetRecordByID(SavePos, nxltNoLock);
            end;
            if FirstNonMatchL <> 0 then begin
              {build a comparison record for left based on the current right record,
               which will let us continue iterating over left as long as we're below
               the current right merge key value}
              Tmp := TempL.SwapRecordBuffer(CompRecLeftLayoutRightValues);
              try
                for i := 0 to JoinAttrCount - 1 do begin
                  if DirectR then
                    RV := JoinFieldsR[i].GetValue(nil, false, nxtByte, false)
                  else
                    RV := TempR.FieldNC(i).GetValue(nil, false, nxtByte, false);
                  if DirectL then
                    JoinFieldsL[i].SetValue(RV)
                  else
                    TempL.FieldNC(i).SetValue(RV);
                end;
              finally
                TempL.SwapRecordBuffer(Tmp);
              end;
              HaveLeftCompRec := True;
              TempL.ClearNoRecordFlag;
              TempL.GetRecordByID(FirstNonMatchL, nxltNoLock)
            end else
              HaveLeft := False;
          end;
        1 :
          begin
            // identical
            // write join records
            if NullInComp then begin
              // special case - null in comparison - not really equal, so write outer records
              if JoinMode in [jmLeft, jmFull] then begin
                // write null records
                TR.NullRecord;
                MatchBuffer := MatchLeft.Buffer;
                for i := 0 to MatchLeft.Count - 1 { high(MatchLeft)} do begin
                  TempL.GetRecordByIDDirect(MatchBuffer^[i]{ MatchLeft[i]});
                  if not DirectL then begin
                    TL.GetRecordByIDDirect(TempLRecIDField.GetValue);
                  end;
                  KeepGoing := CreateResultRecord(nil);
                  inc(RW);
                end;
              end;
              if JoinMode in [jmRight, jmFull] then begin
                // write null records
                TL.NullRecord;
                MatchBuffer := MatchRight.Buffer;
                for j := 0 to MatchRight.Count - 1{ high(MatchRight)} do begin
                  TempR.GetRecordByIDDirect(MatchBuffer^[j] { MatchRight[j]});
                  if not DirectR then begin
                    TR.GetRecordByIDDirect(TempRRecIDField.GetValue);
                  end;
                  KeepGoing := CreateResultRecord(nil);
                  inc(RW);
                end;
              end;

              if (JoinMode in [jmLeft, jmFull]) or NullInLeft then begin
                if FirstNonMatchL <> 0 then begin
                  TempL.ClearNoRecordFlag;
                  TempL.GetRecordByID(FirstNonMatchL, nxltNoLock)
                end else
                  HaveLeft := False;
              end;

              if (JoinMode in [jmRight, jmFull]) or NullInRight then begin
                if FirstNonMatchR <> 0 then begin
                  TempR.ClearNoRecordFlag;
                  TempR.GetRecordByID(FirstNonMatchR, nxltNoLock);
                end else
                  HaveRight := False;
              end;
            end else begin
              {Log('merge match');}
              MatchBuffer := MatchLeft.Buffer;
              MatchBuffer2 := MatchRight.Buffer;
              for i := 0 to MatchLeft.Count - 1{ high(MatchLeft)} do begin
                //TempL.GetRecordByID(MatchLeft[i], nxltNoLock);
                TempL.GetRecordByIDDirect(MatchBuffer^[i] { MatchLeft[i]});
                {Log('TempL');
                DumpRecord(TempL);}
                if not DirectL then begin
                  TL.GetRecordByIDDirect(TempLRecIDField.GetValue);
                  {Log('TL');
                  DumpRecord(TL);}
                end;

                for j := 0 to MatchRight.Count - 1 { high(MatchRight)} do begin
                  TempR.GetRecordByIDDirect(MatchBuffer2^[j] { MatchRight[j]});
                  {Log('TempR');
                  DumpRecord(TempR);}
                  if not DirectR then begin
                    TR.GetRecordByIDDirect(TempRRecIDField.GetValue);
                    {Log('TR');
                    DumpRecord(TR);}
                  end;
                  KeepGoing := CreateResultRecord(nil);
                  {Log('Result');
                  DumpRecord(FTargetTable);}
                  inc(RW);
                end;
              end;

              if FirstNonMatchL <> 0 then begin
                TempL.ClearNoRecordFlag;
                TempL.GetRecordByID(FirstNonMatchL, nxltNoLock)
              end else
                HaveLeft := False;
              if FirstNonMatchR <> 0 then begin
                TempR.ClearNoRecordFlag;
                TempR.GetRecordByID(FirstNonMatchR, nxltNoLock);
              end else
                HaveRight := False;
            end;
          end;
        2 :
          begin
            // right is smaller
            if JoinMode in [jmRight, jmFull] then begin
              // write null records
              SavePos := TempL.GetCurrentRecordID;
              TL.NullRecord;
              MatchBuffer := MatchRight.Buffer;
              for j := 0 to MatchRight.Count - 1 { high(MatchRight)} do begin
                TempR.GetRecordByIDDirect(MatchBuffer^[j] { MatchRight[j]});
                if not DirectR then begin
                  TR.GetRecordByIDDirect(TempRRecIDField.GetValue(nil, false, nxtByte, false));
                end;
                KeepGoing := CreateResultRecord(nil);
                inc(RW);
              end;
              TempL.ClearNoRecordFlag;
              TempL.GetRecordByID(SavePos, nxltNoLock);
            end;
            if FirstNonMatchR <> 0 then begin
              {build a comparison record for right based on the current left record,
               which will let us continue iterating over right as long as we're below
               the current left merge key value}
              Tmp := TempR.SwapRecordBuffer(CompRecRightLayoutLeftValues);
              try
                for i := 0 to JoinAttrCount - 1 do begin
                  if DirectL then
                    LV := JoinFieldsL[i].GetValue(nil, false, nxtByte, false)
                  else
                    LV := TempL.FieldNC(i).GetValue(nil, false, nxtByte, false);
                  if DirectR then
                    JoinFieldsR[i].SetValue(LV, True)
                  else
                    TempR.FieldNC(i).SetValue(LV, True);
                end;
              finally
                TempR.SwapRecordBuffer(Tmp);
              end;
              HaveRightCompRec := True;
              TempR.ClearNoRecordFlag;
              TempR.GetRecordByID(FirstNonMatchR, nxltNoLock);
            end else
              HaveRight := False;
          end;
        end;
      end;

    end;

  finally
    if not DirectL and (TempL <> nil) then begin
      TempL.Owner := nil;
      FreeAndNil(TempL);
    end;
    if not DirectR and (TempR <> nil) then begin
      TempR.Owner := nil;
      FreeAndNil(TempR);
    end;
    FreeAndNil(CompareEngineL);
    FreeAndNil(CompareEngineR);
    FreeAndNil(CompareDictionaryL);
    FreeAndNil(CompareDictionaryR);
    if CompRecLeftLayoutRightValues <> nil then
      nxFreeMem(CompRecLeftLayoutRightValues);
    if CompRecRightLayoutLeftValues <> nil then
      nxFreeMem(CompRecRightLayoutLeftValues);
    nxFreeAndNil(MatchLeft);
    nxFreeAndNil(MatchRight);
  end;
  {$IFOPT Q+}
    {$DEFINE LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS OFF}
  {$ENDIF}
  if NormalLogging then
    LogNormal('Elapsed:' + IntTostr(GetTickCount - Start));
  {$IFDEF LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS ON}
    {$UNDEF LocalOverflowCheckOFF}
  {$ENDIF}
  if NormalLogging then
  begin
    Lognormal('Records written:' + IntToStr(RW));
    LogNormal('');
  end;
  {DumpTable(FTargetTable);}
end;

procedure TnxSqlRowBuilder.AddFirstToHash(FirstHashData: PFirstHashData);
var
  NewEntry: PUniqueJoinKeyEntry;
  Entry: PUniqueHashEntry;
  i: Integer;
  H, HashSlot: DWord;
  UniqueEntry: PUniqueJoinKeyEntry;
  NewDup: PDupRec;
  V: variant;
  NewEntryJoinValues, UniqueEntryJoinValues: PVariantArray;
  NewEntryRecordBuffer, NewDupRecBuffer : PnxRecordBuffer;
  Match: Boolean;
begin
  NewEntry := FirstHashData.KeyEntryPool.Alloc;
  if NewEntry = nil then begin
    FirstHashData.Success := False;
    exit;
  end;

  NewEntryJoinValues := PVariantArray(TnxNativeUInt(NewEntry) + sizeof(TUniqueJoinKeyEntry));
  fillchar(NewEntryJoinValues^, FirstHashData.JoinAttrCount * sizeof(Variant), 0);

  {first attribute:}
  V := FirstHashData.FirstJoinFields^[0].GetValue(nil, false, nxtByte, false);
  NewEntryJoinValues[0] := V;
  H := VariantHash(V, FirstHashData.FirstJoinFieldLocaleDescriptors[0],
    FirstHashData.HashKeyBuffer, FirstHashData.HashKeyBufferSize);
  if FirstHashData.BuildRangeForSecond
  and (FirstHashData.JoinRangeFieldIndex = 0) then
    if not VarIsNull(V) then
      if not FirstHashData.First then begin
        if nxVarCmp(V, FirstHashData.HighValue, FirstHashData.FirstJoinFields^[0].GetLocale, FirstHashData.FirstJoinFields^[0].GetLocaleFlags) = VAR_CMP_GT then
          FirstHashData.HighValue := V
        else
        if nxVarCmp(V, FirstHashData.LowValue, FirstHashData.FirstJoinFields^[0].GetLocale, FirstHashData.FirstJoinFields^[0].GetLocaleFlags) = VAR_CMP_LT then
          FirstHashData.LowValue := V;
      end else begin
        FirstHashData.LowValue := V;
        FirstHashData.HighValue := V;
        FirstHashData.First := False;
      end;

  {remaining attributes (if any):}
  for i := 1 to FirstHashData.JoinAttrCount - 1 do begin
    V := FirstHashData.FirstJoinFields^[i].GetValue;
    if FirstHashData.BuildRangeForSecond
    and (FirstHashData.JoinRangeFieldIndex = i) then
      if not VarIsNull(V) then
        if not FirstHashData.First then begin
          if nxVarCmp(V, FirstHashData.HighValue, FirstHashData.FirstJoinFields^[i].GetLocale, FirstHashData.FirstJoinFields^[i].GetLocaleFlags) = VAR_CMP_GT then
            FirstHashData.HighValue := V
          else
          if nxVarCmp(V, FirstHashData.LowValue, FirstHashData.FirstJoinFields^[i].GetLocale, FirstHashData.FirstJoinFields^[i].GetLocaleFlags) = VAR_CMP_LT then
            FirstHashData.LowValue := V;
        end else begin
          FirstHashData.LowValue := V;
          FirstHashData.HighValue := V;
          FirstHashData.First := False;
        end;
    NewEntryJoinValues[i] := V;
    H := H xor VariantHash(V, FirstHashData.FirstJoinFieldLocaleDescriptors[i],
      FirstHashData.HashKeyBuffer, FirstHashData.HashKeyBufferSize);
  end;

  HashSlot := H mod FirstHashData.HashSize;

  Entry := FirstHashData.HashTable[HashSlot];
  while Entry <> nil do begin
    if Entry.Hash = H then begin
      {found identical hash - now look for identical attr values}
      UniqueEntry := Entry.FirstRec;
      while UniqueEntry <> nil do begin
        UniqueEntryJoinValues := PVariantArray(TnxNativeUInt(UniqueEntry) + sizeof(TUniqueJoinKeyEntry));
        Match := True;
        for i := 0 to FirstHashData.JoinAttrCount - 1 do
          if nxVarCmp(
            {TVarData(}UniqueEntryJoinValues[i]{)},
            {TVarData(}NewEntryJoinValues[i]{)}, 0, 0) <> VAR_CMP_EQ then begin
              Match := False;
              Break;
            end;
        if Match then begin
          {found attribute match}
          {allocate dup entry for record buffer and link into list}
          //0 new(NewDup);
          NewDup := FirstHashData.DupEntryPool.Alloc;
          NewDup.Next := UniqueEntry.Dup;
          //NewDup.RecBuffer := nxGetMem(FirstHashData.FirstTable.RecordLen);
          NewDupRecBuffer := @NewDup.RecBuffer;
          nxMove(FirstHashData.FirstTable.RecBuffer^, NewDupRecBuffer^, FirstHashData.FirstTable.RecordLen);
          UniqueEntry.Dup := NewDup;
          {no longer need the allocated attribute set}
          for i := 0 to FirstHashData.JoinAttrCount - 1 do
            NewEntryJoinValues[i] := Null;
          //Dispose(NewEntry);
          //0 nxFreeMem(NewEntry);
          exit;
        end;
        UniqueEntry := UniqueEntry.Next;
      end;
      {didn't find this attribute set}
      {link in the new attribute set and save the record with it}
      //NewEntry.RecBuffer := nxGetMem(FirstHashData.FirstTable.RecordLen);
      NewEntryRecordBuffer := PnxRecordBuffer(TnxNativeUInt(NewEntry) + sizeof(TUniqueJoinKeyEntry) + TnxNativeUInt(FirstHashData.JoinAttrCount) * sizeof(Variant));
      nxMove(FirstHashData.FirstTable.RecBuffer^, NewEntryRecordBuffer^, FirstHashData.FirstTable.RecordLen);
      NewEntry.Next := Entry.FirstRec;
      NewEntry.Dup := nil;
      NewEntry.Matched := False;
      Entry.FirstRec := NewEntry;
      exit;
    end;
    Entry := Entry^.Next;
  end;
  {Didn't find this hash}
  {Build new entry}
  //0 new(Entry);
  Entry := FirstHashData.HashEntryPool.Alloc;
  Entry.FirstRec := nil;
  Entry.Hash := H;
  Entry.Next := FirstHashData.HashTable[HashSlot];
  FirstHashData.HashTable[HashSlot] := Entry;
  {link in the new attribute set and save the record with it}
  //NewEntry.RecBuffer := nxGetMem(FirstHashData.FirstTable.RecordLen);
  //nxMove(FirstHashData.FirstTable.RecBuffer^, NewEntry.RecBuffer^, FirstHashData.FirstTable.RecordLen);
  NewEntryRecordBuffer := PnxRecordBuffer(TnxNativeUInt(NewEntry) + sizeof(TUniqueJoinKeyEntry) + TnxNativeUInt(FirstHashData.JoinAttrCount) * sizeof(Variant));
  nxMove(FirstHashData.FirstTable.RecBuffer^, NewEntryRecordBuffer^, FirstHashData.FirstTable.RecordLen);
  NewEntry.Next := Entry.FirstRec;
  NewEntry.Dup := nil;
  NewEntry.Matched := False;
  Entry.FirstRec := NewEntry;
end;

function TnxSqlRowBuilder.FirstHash(aCookie: Pointer): Boolean;
var
  I: Integer;
  Include: Boolean;
begin
  with PFirstHashData(aCookie)^ do begin
    inc(LoopCounter);
    inc(FContext.RecordsRead);
    if LoopCounter mod 4096 = 0 then
      nxCheckRemainingTime;
    Include := True;
    for i := 0 to FirstJoinFilters.Count - 1 do
      if TnxSqlCondFactor(FirstJoinFilters[i]).AsBoolean(FContext) <> tsbTrue then begin
        Include := False;
        Break;
      end;
    if Include then begin
      AddFirstToHash(PFirstHashData(aCookie));
      inc(FilterMatchCount);
    end;
    Result := Success;
  end;
end;

function TnxSqlRowBuilder.LookupFromSecond(SecondHashData: PSecondHashData): PUniqueJoinKeyEntry;
var
  Entry: PUniqueHashEntry;
  i: Integer;
  H, HashSlot: DWord;
  UniqueEntry: PUniqueJoinKeyEntry;
  UniqueEntryJoinValues: PVariantArray;
  Match: Boolean;
begin
  for i := 0 to SecondHashData.JoinAttrCount - 1 do begin
    //SecondHashData.ValueEntry.JoinValues[i] := SecondHashData.SecondJoinFields^[i].GetValue;
    SecondHashData.ValueEntry[i] := SecondHashData.SecondJoinFields^[i].GetValue(nil, false, nxtByte, false);
    //if VarIsNull(SecondHashData.ValueEntry.JoinValues[i]) then begin
    if VarIsNull(SecondHashData.ValueEntry[i]) then begin
      Result := nil;
      exit;
    end;
  end;
  //H := VariantHash(SecondHashData.ValueEntry.JoinValues[0], SecondHashData.SecondJoinFieldLocaleDescriptors[0],
  H := VariantHash(SecondHashData.ValueEntry[0], SecondHashData.SecondJoinFieldLocaleDescriptors[0],
    SecondHashData.HashKeyBuffer, SecondHashData.HashKeyBufferSize);
  for i := 1 to SecondHashData.JoinAttrCount - 1 do
    //H := H xor VariantHash(SecondHashData.ValueEntry.JoinValues[i], SecondHashData.SecondJoinFieldLocaleDescriptors[i],
    H := H xor VariantHash(SecondHashData.ValueEntry[i], SecondHashData.SecondJoinFieldLocaleDescriptors[i],
    SecondHashData.HashKeyBuffer, SecondHashData.HashKeyBufferSize);

  HashSlot := H mod SecondHashData.HashSize;

  Entry := SecondHashData.HashTable[HashSlot];
  while Entry <> nil do begin
    if Entry.Hash = H then begin
      {found identical hash - now look for identical attr values}
      UniqueEntry := Entry.FirstRec;
      while UniqueEntry <> nil do begin
        UniqueEntryJoinValues := PVariantArray(TnxNativeUInt(UniqueEntry) + sizeof(TUniqueJoinKeyEntry));
        Match := True;
        for i := 0 to SecondHashData.JoinAttrCount - 1 do
          if nxVarCmp(
            {TVarData(}UniqueEntryJoinValues[i]{)},
            //{TVarData(}SecondHashData.ValueEntry.JoinValues[i]{)}, 0, 0) <> VAR_CMP_EQ then begin
            {TVarData(}SecondHashData.ValueEntry[i]{)}, 0, 0) <> VAR_CMP_EQ then begin
              Match := False;
              Break;
            end;
        if Match then begin
          {found attribute match}
          Result := UniqueEntry;
          exit;
        end;
        UniqueEntry := UniqueEntry.Next;
      end;
      {didn't find this attribute set}
      Result := nil;
      exit;
    end;
    Entry := Entry^.Next;
  end;
  {Didn't find this hash}
  Result := nil;
end;

function TnxSqlRowBuilder.WriteMatching(SecondHashData: PSecondHashData): Boolean;
var
  FirstMatchEntry: PUniqueJoinKeyEntry;
  CurDup: PDupRec;
  FirstTmp, FirstEntryRecordBuffer, CurDupRecBuffer: PnxRecordBuffer;
begin
  Result := False; {no match}
  with SecondHashData^ do begin
    FirstMatchEntry := LookupFromSecond(SecondHashData);
    if FirstMatchEntry <> nil then begin
      {found an attribute match}
      {write a result row for each copy}
      {first the master record}
      FirstEntryRecordBuffer := PnxRecordBuffer(TnxNativeUInt(FirstMatchEntry) + sizeof(TUniqueJoinKeyEntry) + TnxNativeUInt(SecondHashData.JoinAttrCount) * sizeof(Variant));
      FirstTmp := FirstTable.SwapRecordBuffer(FirstEntryRecordBuffer);
      try
        InnerRowHandler(UserData);
        inc(SecondHashData.WriteCount);
      finally
        FirstTable.SwapRecordBuffer(FirstTmp); // make sure to swap back the rec buffer in case of an exception
      end;
      {then any dups we have}
      CurDup := FirstMatchEntry.Dup;
      while CurDup <> nil do begin
        CurDupRecBuffer := PnxRecordBuffer(TnxNativeUInt(CurDup) + sizeof(TDupRec));
        FirstTmp := FirstTable.SwapRecordBuffer(CurDupRecBuffer);
        try
          InnerRowHandler(UserData);
          inc(SecondHashData.WriteCount);
        finally
          FirstTable.SwapRecordBuffer(FirstTmp);
        end;
        CurDup := CurDup.Next;
      end;
      FirstMatchEntry.Matched := True;
      Result := True;  {match}
    end;
  end;
end;

procedure TnxSqlRowBuilder.WriteMismatchedSecond(SecondHashData: PSecondHashData);
begin
  {didn't find a match for the row in the second table}
  {write a null (right-outer-join) row}
  SecondHashData.FirstTable.NullRecord;
  InnerRowHandler(SecondHashData.UserData);
  inc(SecondHashData.WriteCount);
end;

function TnxSqlRowBuilder.SecondHash(aCookie: Pointer): Boolean;
var
  i: Integer;
  Include: Boolean;
begin
  with PSecondHashData(aCookie)^ do begin
    inc(LoopCounter);
    inc(FContext.RecordsRead);
    if LoopCounter mod 4096 = 0 then
      nxCheckRemainingTime;
    Include := True;
    for i := 0 to SecondJoinFilters.Count - 1 do
      if TnxSqlCondFactor(SecondJoinFilters[i]).AsBoolean(FContext) <> tsbTrue then begin
        Include := False;
        Break;
      end;
    if Include then begin
      if not WriteMatching(PSecondHashData(aCookie)) and SecondPreserved then
        WriteMismatchedSecond(PSecondHashData(aCookie));
      inc(FilterMatchCount);
    end;
  end;
  Result := not LimitReached;
end;

procedure DisposeHashTable(HashTable: PHashTable; HashSize: DWord; JoinAttrCount: Integer);
var
  Entry {0, TmpEntry}: PUniqueHashEntry;
  i, j: Integer;
  UniqueEntry, TmpUniqueEntry: PUniqueJoinKeyEntry;
  CurDup{ 0, TmpDup}: PDupRec;
  EntryJoinValues: PVariantArray;
begin
  for i := 0 to HashSize - 1 do begin
    Entry := HashTable[i];
    while Entry <> nil do begin
      UniqueEntry := Entry.FirstRec;
      while UniqueEntry <> nil do begin
        CurDup := UniqueEntry.Dup;
        while CurDup <> nil do begin
          //0 TmpDup := CurDup;
          CurDup := CurDup.Next;
          //0 nxFreeMem(TmpDup.RecBuffer);
          //0 Dispose(TmpDup);
        end;
        TmpUniqueEntry := UniqueEntry;
        UniqueEntry := UniqueEntry.Next;
        //nxFreeMem(TmpUniqueEntry.RecBuffer);
        //Dispose(TmpUniqueEntry);
        EntryJoinValues := PVariantArray(TnxNativeUInt(TmpUniqueEntry) + sizeof(TUniqueJoinKeyEntry));
        for j := 0 to JoinAttrCount - 1 do
          EntryJoinValues[j] := null;
        //0 nxFreeMem(TmpUniqueEntry);
      end;
      //0 TmpEntry := Entry;
      Entry := Entry^.Next;
      //0 Dispose(TmpEntry);
    end;
  end;
  FreeMem(HashTable);
end;


function TnxSqlRowBuilder.ExecuteBinaryHashJoin(
  JoinMode: TnxSqlOuterJoinMode; JoinFactors, JoinFiltersT1,
  JoinFiltersT2: TList; var RecordsRead: Integer;
  UserData: Pointer): Boolean;
var
  RR, RW: Integer;
  FirstTable, SecondTable: TnxSqlTableProxy;
  FirstJoinFilters, SecondJoinFilters: TList;
  FirstPreserved, SecondPreserved: Boolean;
  FirstJoinFields, SecondJoinFields,
  JoinFieldsL, JoinFieldsR: array of TnxSqlFieldProxy;
  JoinAttrCount: Integer;
  JoinRangeFieldIndex: Integer;
  JoinRangeIndexName: string;
  BuildRangeForSecond: Boolean;
  LowRangeValue, HighRangeValue: variant;
var
  HashTable: PHashTable;
  HashSize: DWord;
  HashEntryPool, KeyEntryPool, DupEntryPool: TnxSqlPoolManager;

  procedure WriteMismatchedFirsts;
    {iterate the hash table, writing null records for
     rows that were not used (matched to the second table}
  var
    Entry: PUniqueHashEntry;
    i: Integer;
    UniqueEntry: PUniqueJoinKeyEntry;
    UniqueEntryRecordBuffer: PnxRecordBuffer;
    FirstTmp, CurDupRecBuffer: PnxRecordBuffer;
    CurDup: PDupRec;
  begin
    for i := 0 to HashSize - 1 do begin
      Entry := HashTable[i];
      while Entry <> nil do begin
        UniqueEntry := Entry.FirstRec;
        while UniqueEntry <> nil do begin
          if not UniqueEntry.Matched then begin
            {found an attribute set, which wasn't used}
            {write null records}
            SecondTable.NullRecord;
            UniqueEntryRecordBuffer := PnxRecordBuffer(TnxNativeUInt(UniqueEntry) + sizeof(TUniqueJoinKeyEntry) + TnxNativeUInt(JoinAttrCount) * sizeof(Variant));
            FirstTmp := FirstTable.SwapRecordBuffer(UniqueEntryRecordBuffer);
            try
              InnerRowHandler(UserData);
              //CreateResultRecord(0);
              inc(RW);
            finally
              FirstTable.SwapRecordBuffer(FirstTmp);
            end;
            {then any dups we have}
            CurDup := UniqueEntry.Dup;
            while CurDup <> nil do begin
              CurDupRecBuffer := PnxRecordBuffer(TnxNativeUInt(CurDup) + sizeof(TDupRec));
              FirstTmp := FirstTable.SwapRecordBuffer(CurDupRecBuffer);
              try
                InnerRowHandler(UserData);
                //CreateResultRecord(0);
                inc(RW);
              finally
                FirstTable.SwapRecordBuffer(FirstTmp);
              end;
              CurDup := CurDup.Next;
            end;
          end;
          UniqueEntry := UniqueEntry.Next;
        end;
        Entry := Entry^.Next;
      end;
    end;
  end;

  function BuildHashOnFirst: Boolean;
  var
    FirstHashData: TFirstHashData;
    i, z: Integer;
  begin
    Result := True;
    try
      if FirstJoinFilters.Count > 0 then
        ApplyFilterRange(FirstTable, FirstJoinFilters);

      FirstHashData.UniqueJoinKeyEntrySize := sizeof(TUniqueJoinKeyEntry) + JoinAttrCount * sizeof(Variant) + FirstTable.RecordLen + SizeOf(Pointer);
      FirstHashData.LoopCounter := 0;
      FirstHashData.FilterMatchCount := 0;
      FirstHashData.FirstJoinFilters := FirstJoinFilters;
      FirstHashData.JoinAttrCount := JoinAttrCount;
      FirstHashData.FirstJoinFields := @FirstJoinFields;
      SetLength(FirstHashData.FirstJoinFieldLocaleDescriptors, length(FirstJoinFields));
      for i := 0 to high(FirstJoinFields) do
        FirstHashData.FirstJoinFieldLocaleDescriptors[i] := FirstJoinFields[i].GetLocaleDesc;
      FirstHashData.HashSize := HashSize;
      FirstHashData.HashTable := HashTable;
      FirstHashData.FirstTable := FirstTable;
      FirstHashData.BuildRangeForSecond := BuildRangeForSecond;
      FirstHashData.JoinRangeFieldIndex := JoinRangeFieldIndex;
      FirstHashData.First := True;

      if FirstTable.GetRecordCount > 0 then begin
        HashEntryPool := TnxSqlPoolManager.Create(sizeof(TUniqueHashEntry), FirstTable.GetRecordCount);
        KeyEntryPool := TnxSqlPoolManager.Create(FirstHashData.UniqueJoinKeyEntrySize, FirstTable.GetRecordCount);
        DupEntryPool := TnxSqlPoolManager.Create(sizeof(TDupRec) + FirstTable.RecordLen + SizeOf(Pointer), FirstTable.GetRecordCount);
        if not (Assigned(HashEntryPool.Root) and Assigned(KeyEntryPool.Root) and Assigned(DupEntryPool.Root)) then begin
          Result := False;
          Exit;
        end;
      end else begin
        HashEntryPool := nil;
        KeyEntryPool := nil;
        DupEntryPool := nil;
      end;
      FirstHashData.HashEntryPool := HashEntryPool;
      FirstHashData.KeyEntryPool := KeyEntryPool;
      FirstHashData.DupEntryPool := DupEntryPool;

      z := 0;

      for i := 0 to JoinAttrCount - 1 do
        z := nxMaxI32(z, FirstJoinFields[i].GetHashBufferSize);

      FirstHashData.HashKeyBufferSize := z;
      FirstHashData.HashKeyBuffer := AllocMem(z);
      FirstHashData.Success := True;

      try
        FirstTable.Iterate(FirstHash, @FirstHashData);

        if not FirstHashData.Success then begin
          Result := False;
          exit;
        end;

        LowRangeValue := null;
        HighRangeValue := null;

        if BuildRangeForSecond and not FirstHashData.First then begin
          LowRangeValue := FirstHashData.LowValue;
          HighRangeValue := FirstHashData.HighValue;
        end;

      finally
        FreeMem(FirstHashData.HashKeyBuffer);
      end;

      if NormalLogging then
        LogNormal('Rows that are matching applied filter expression on (first) table "' + TableNameStr(FirstTable) + '": ' + IntToStr(FirstHashData.FilterMatchCount));
      inc(RR, FirstHashData.LoopCounter);
    finally
      FirstTable.ClearRange;
    end;
  end;

  function IterateSecond: Boolean;
  var
    SecondHashData: TSecondHashData;
    i, z: Integer;
  begin
    {if SecondJoinFilters.Count > 0 then
      ApplyFilterRange(SecondTable, SecondJoinFilters);}

    if VerboseLogging and (SecondJoinFilters.Count > 0) then begin
      LogVerbose('Second join filter(s):');
      for i := 0 to SecondJoinFilters.Count - 1 do
        LogVerbose(TnxSqlCondFactor(SecondJoinFilters[i]).ToString);
      LogVerbose('======================');
    end;

    SecondHashData.LoopCounter := 0;
    SecondHashData.FilterMatchCount := 0;
    SecondHashData.WriteCount := 0;
    SecondHashData.SecondJoinFilters := SecondJoinFilters;
    SecondHashData.JoinAttrCount := JoinAttrCount;
    SecondHashData.SecondJoinFields := @SecondJoinFields;
    SetLength(SecondHashData.SecondJoinFieldLocaleDescriptors, length(SecondJoinFields));
    for i := 0 to high(SecondHashData.SecondJoinFieldLocaleDescriptors) do
      SecondHashData.SecondJoinFieldLocaleDescriptors[i] := SecondJoinFields[i].GetLocaleDesc;
    SecondHashData.HashSize := HashSize;
    SecondHashData.HashTable := HashTable;
    SecondHashData.FirstTable := FirstTable;
    SecondHashData.SecondTable := SecondTable;
    SecondHashData.UserData := UserData;
    SecondHashData.SecondPreserved := SecondPreserved;
    SecondHashData.Success := True;
    //SetLength(SecondHashData.ValueEntry.JoinValues, JoinAttrCount);
    SecondHashData.ValueEntry := nxGetMem(JoinAttrCount * sizeof(Variant));
    try
      FillChar(SecondHashData.ValueEntry^, JoinAttrCount * sizeof(Variant), 0);

      z := 0;

      for i := 0 to JoinAttrCount - 1 do
        z := nxMaxI32(z, SecondJoinFields[i].GetHashBufferSize);

      SecondHashData.HashKeyBufferSize := z;
      SecondHashData.HashKeyBuffer := AllocMem(z);
      try
        SecondTable.Iterate(SecondHash, @SecondHashData);
      finally
        FreeMem(SecondHashData.HashKeyBuffer);
      end;
    finally
      if assigned(SecondHashData.ValueEntry) then
        nxFreeMem(SecondHashData.ValueEntry);
    end;

    if not SecondHashData.Success then begin
      Result := False;
      exit;
    end;

    if NormalLogging then
      LogNormal('Rows that are matching applied filter expression on (second) table "' + TableNameStr(SecondTable) + '": ' + IntToStr(SecondHashData.FilterMatchCount));
    inc(RR, SecondHashData.LoopCounter);
    inc(RW, SecondHashData.WriteCount);

    if FirstPreserved then
      WriteMismatchedFirsts;
    Result := True;
  end;

  function DoHashJoin: Boolean;
  var
    D, RC: Cardinal;
    DoingIndexFilteringOnSecond: Boolean;
    HashTableMemory, HashEntryPoolMemory,
    KeyEntryPoolMemory, DupEntryPoolMemory, TotalRequired,
    RC64, Avail: int64;
  begin
    Result := True;
    RC := FirstTable.GetRecordCount;
    RC64 := FirstTable.GetRecordCount;
    HashSize := HashSizes[HashSizesCount - 1];
    D := HashSizesCount - 1;
    while (HashSize > RC) and (D > 0) do begin
      dec(D);
      HashSize := HashSizes[D];
    end;

    // calculate memory requirement and compare to available memory

    Avail :=
      (FirstTable.Database.ServerDatabase.Session.ServerEngine as TnxServerEngine).BufferManager.AvailableRAM;

    LogVerbose('Calculating if enough memory is available for hash join');
    HashTableMemory := HashSize * sizeof(PUniqueHashEntry);
    LogVerbose(format('  Hash table memory requirement:%0.n', [HashTableMemory*1.0]));
    HashEntryPoolMemory := sizeof(TUniqueHashEntry) * RC64;
    LogVerbose(format('  Hash table pool memory requirement:%0.n', [HashEntryPoolMemory*1.0]));
    KeyEntryPoolMemory := (sizeof(TUniqueJoinKeyEntry) + JoinAttrCount * sizeof(Variant) + FirstTable.RecordLen + SizeOf(Pointer)) * RC64;
    LogVerbose(format('  Key entry pool memory requirement:%0.n', [KeyEntryPoolMemory*1.0]));
    DupEntryPoolMemory := (sizeof(TDupRec) + FirstTable.RecordLen + SizeOf(Pointer)) * RC64;
    LogVerbose(format('  Duplicate entry pool memory requirement:%0.n', [DupEntryPoolMemory*1.0]));
    LogVerbose('  ----------------------');
    TotalRequired := HashTableMemory + HashEntryPoolMemory + KeyEntryPoolMemory + DupEntryPoolMemory;
    LogVerbose(format('  Total memory requirement:%0.n', [TotalRequired*1.0]));
    LogVerbose(format('  Available scratch memory:%0.n', [Avail*1.0]));

    if Avail < 64 * 1024 * 1024 then
    begin
      Avail := 64 * 1024 * 1024;
      LogVerbose('Always allow Hash joins with less than 64 megs ram use');
    end;

    if TotalRequired <= Avail then begin
      LogVerbose('Enough memory is available to perform hash join');
    end else begin
      LogVerbose('Not enough memory is available to perform hash join');
      Result := False;
      exit;
    end;
    LogVerbose('');

    HashTable := AllocMem(HashSize * sizeof(PUniqueHashEntry));
    try
      // If second is not preserved (inner or left-outer type join)
      // and we're not using an index for filtering on second
      // and there's a join index on second, then
      //    we can set a range to (potentially) limit the number of rows
      //    read in IterateSecond from range values extracted in
      //    BuildHashOnFirst.

      DoingIndexFilteringOnSecond := (SecondJoinFilters.Count > 0)
        and ApplyFilterRange(SecondTable, SecondJoinFilters);

      BuildRangeForSecond := False;

      if not SecondPreserved
      and not DoingIndexFilteringOnSecond
      and HaveJoinRangeIndex(FirstJoinFields, SecondTable, SecondJoinFields, JoinRangeFieldIndex, JoinRangeIndexName) then begin
        LogVerbose('Building range for second table');
        BuildRangeForSecond := True;
      end;

      // note: if statement here only controls what is logged, not the actual join logic
      if not SecondPreserved
      and not DoingIndexFilteringOnSecond
      and NormalLogging then
        if (JoinRangeIndexName<>'') then
          LogNormal('Slave (inner) table index: '+JoinRangeIndexName)
        else
          LogNormal('No slave (inner) table index available');

      if not BuildHashOnFirst then begin
        Result := False;
        exit;
      end;

      if BuildRangeForSecond then
        ApplyJoinRange(SecondTable, JoinRangeIndexName, LowRangeValue, HighRangeValue);

      if (RC > 0) or SecondPreserved then
        if not IterateSecond then begin
          Result := False;
          exit;
        end else
      else
        if FirstPreserved then
          WriteMismatchedFirsts;
    finally
      SecondTable.ClearRange;
      DisposeHashTable(HashTable, HashSize, JoinAttrCount);
      HashEntryPool.Free;
      KeyEntryPool.Free;
      DupEntryPool.Free;
    end;
  end;

var
  aResult: TnxSQLLeftRight;
//  RightFirst: boolean;
//  RUnfiltRecCount: Integer;
//  LUnfiltRecCount: Integer;
//  aColumnList: TnxFastStringListIC;
  TL, TR: TnxSqlTableProxy;
  i, j: Integer;
  F: TnxSqlFieldProxy;
  Op: TnxSqlRelOp;
  ArgExp: TnxSqlNode;
  IsNullTest,
  SameCase: Boolean;
  Start: Cardinal;
  OwnerWhere: TnxSqlCondExp;
  OwnerTerm: TnxSqlCondTerm;
  FLeq, FReq: TnxSqlFieldProxy;
  Fc: string;
  CFCopy : TnxSqlCondFactor;
  NewTableName, NewColumnName: string;
  ClonedCondFact: TnxSqlCondFactor;
  IsUnique: Boolean;
  JoinViaIndex: Boolean;
  FirstSource: TnxSqlRowRange;
  SecondSource: TnxSqlRowRange;
begin
  result:=false;
//  JoinViaIndex:=false;
  if (fOwnerJoin<>nil) and (fOwnerJoin.UsingList<>nil) then
  begin
    if VerboseLogging then
      LogVerbose('UsingList is not empty -> hash join not possible!');
    exit;
  end;

  if FOwnerSelect=nil then
    raise EnxInternalSQLException.Create(rsIllegalJoinSyntax);

  OwnerWhere := (FOwnerSelect as TnxSqlSELECT).CondExpWhere;
  if OwnerWhere <> nil then
    if VerboseLogging then
      LogVerbose('Outer filter expression: ' + OwnerWhere.ToString);
  TL := Sources.Item[0].Table;
  TR := Sources.Item[1].Table;

  TL.ClearRange;
  TR.ClearRange;

  if VerboseLogging then
  begin
    LogVerbose('Simple join between tables "' + TableNameStr(Sources.Item[0].Table) + '" and "' + TableNameStr(Sources.Item[1].Table) + '"');
    LogVerbose('Table "' + TableNameStr(Sources.Item[0].Table) + '" - Rows in table:' + format('%.0n', [Sources.Item[0].Table.GetRecordCount * 1.0]));
    LogVerbose('Table "' + TableNameStr(Sources.Item[1].Table) + '" - Rows in table:' + format('%.0n', [Sources.Item[1].Table.GetRecordCount * 1.0]));
  end;

  JoinAttrCount := JoinFactors.Count;
  SetLength(JoinFieldsL, JoinAttrCount);
  SetLength(JoinFieldsR, JoinAttrCount);

  {discover join attributes in order}
  for i := 0 to JoinAttrCount - 1 do begin
    if not TnxSqlCondFactor(JoinFactors[i]).IsRelationTo(FContext, TL, F, Op, ArgExp, SameCase, IsNullTest) then begin
      {oops - should not happen}
      Result := False;
      exit;
    end;
    JoinFieldsL[i] := F;
    if not TnxSqlCondFactor(JoinFactors[i]).IsRelationTo(FContext, TR, F, Op, ArgExp, SameCase, IsNullTest) then begin
      {oops - should not happen}
      Result := False;
      exit;
    end;
    JoinFieldsR[i] := F;
    if JoinFieldsL[i].GetType <> JoinFieldsR[i].GetType then begin
      if VerboseLogging then
        LogVerbose('Join attribute types don''t match - can''t use hash join');
      Result := False;
      exit;
    end;
  end;

  if VerboseLogging then
  begin
    LogVerbose('Join attributes:');
    for i := 0 to high(JoinFieldsL) do
      LogVerbose(' "' + JoinFieldsL[i].Name + '" and "' + JoinFieldsR[i].Name + '"');
    LogVerbose('');
  end;

  RR := 0;
  RW := 0;
  Start := GetTickCount;

  SetLength(FirstJoinFields, 0);
  SetLength(SecondJoinFields, 0);

  {clone conditions from outer WHERE expression that refer to this table}
  LogVerbose('Attempting to clone conditions from outer WHERE');
  if (FOwnerJoin <> nil) and (OwnerWhere <> nil)
  and (OwnerWhere.CondTermCount = 1) {can't handle OR in combination with other filters} then begin
    OwnerTerm := OwnerWhere.CondTerm[0];
    for i := 0 to OwnerTerm.CondFactorCount - 1 do begin
      ClonedCondFact := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
      LogVerbose('Looking at conditional factor "' + ClonedCondFact.ToString + '"');
      try
        if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, TL, Fc)
        {and not (ClonedCondFact.RefersToContextVars(FContext))} then begin
          LogVerbose('- is a constant filter on ' + TL.Name + ' ( ' + TL.Alias + ')');
          JoinFiltersT1.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
          ClonedCondFact := nil;
          // see if we have an equal transition to the other table
          for j := 0 to JoinFactors.Count - 1 do
            if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True)
            and SameText(Fc, FLeq.Name) then begin
              CFCopy := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
              if TR.Alias <> '' then
                NewTableName := TR.Alias
              else
                NewTableName := TR.Name;
              LogVerbose('- equal transition to ' + NewTableName);
              NewColumnName := FReq.Name;
              if CFCopy.AlterTableRef(NewTableName, NewColumnName) then begin
                LogVerbose('- cloned as ' + CFCopy.ToString);
                JoinFiltersT2.Add(CFCopy);
              end else
                CFCopy.Free;
              Break;
            end;
        end else
        if ClonedCondFact{OwnerTerm.CondFactor[i]}.IsConstantFilterOn(FContext, TR, Fc)
        {and not (ClonedCondFact.RefersToContextVars(FContext))}then begin
          LogVerbose('- is a constant filter on ' + TR.Name + ' ( ' + TR.Alias + ')');
          JoinFiltersT2.Add(ClonedCondFact{OwnerTerm.CondFactor[i].Clone(FOwnerJoin)});
          ClonedCondFact := nil;
          // see if we have an equal transition to the other table
          for j := 0 to JoinFactors.Count - 1 do
            if TnxSqlCondFactor(JoinFactors[j]).IsSimpleRelationBetween(FContext, TL, TR, FLeq, FReq, True)
            and SameText(Fc, FReq.Name) then begin
              CFCopy := OwnerTerm.CondFactor[i].Clone(FOwnerJoin) as TnxSqlCondFactor;
              if TL.Alias <> '' then
                NewTableName := TL.Alias
              else
                NewTableName := TL.Name;
              LogVerbose('- equal transition to ' + NewTableName);
              NewColumnName := FLeq.Name;
              if CFCopy.AlterTableRef(NewTableName, NewColumnName) then begin
                LogVerbose('- cloned as ' + CFCopy.ToString);
                JoinFiltersT1.Add(CFCopy);
              end else
                CFCopy.Free;
              Break;
            end;
        end else
          LogVerbose('- not applicable in this context.');
      finally
        ClonedCondFact.Free;
      end;
    end;
  end;

  aResult:=GetDrivingTable(Sources[0], Sources[1], JoinFiltersT1, JoinFiltersT2, fContext);
  if aResult=lrRight then begin
    FirstSource:=Sources[1];
    SecondSource:=Sources[0];
    FirstTable := TR;
    FirstJoinFields := JoinFieldsR;
    FirstJoinFilters := JoinFiltersT2;
    SecondTable := TL;
    SecondJoinFields := JoinFieldsL;
    SecondJoinFilters := JoinFiltersT1;
    FirstPreserved := JoinMode in [jmRight, jmFull];
    SecondPreserved := JoinMode in [jmLeft, jmFull];
  end else begin
    FirstTable := TL;
    FirstSource:=Sources[0];
    SecondSource:=Sources[1];
    FirstJoinFields := JoinFieldsL;
    FirstJoinFilters := JoinFiltersT1;
    SecondTable := TR;
    SecondJoinFields := JoinFieldsR;
    SecondJoinFilters := JoinFiltersT2;
    FirstPreserved := JoinMode in [jmLeft, jmFull];
    SecondPreserved := JoinMode in [jmRight, jmFull];
  end;

  if ((not SecondPreserved) and ((FirstSource.EstimatedRangeCount = 0) and (FirstTable.GetRecordCount = 0)))
    or ((not FirstPreserved) and ((SecondSource.EstimatedRangeCount = 0) and (SecondTable.GetRecordCount = 0))) then begin
    LogNormal('non-OUTER table is empty - JOIN can''t ever produce output - shortcircuting');
    Result := True;
    Exit;
  end;

  if not FirstPreserved and ((SecondJoinFilters = nil) or (SecondJoinFilters.Count = 0)) then
  begin
    JoinViaIndex:=CanJoinViaIndex(FirstTable, FirstJoinFields, False, False, IsUnique);
    if JoinViaIndex then begin
      if IsUnique then
        if FirstTable.GetRecordCount > SecondTable.GetRecordCount * 2 then begin
          if VerboseLogging then
            LogVerbose('Inner table has a unique join index and is more than twice the size of outer table');
          Result := False;
          exit;
      end;
      {if FirstTable.GetRecordCount > SecondTable.GetRecordCount * 10 then begin
        Log('Inner table has a join index and has 10 or more times the rows of the outer table');
        Result := False;
        exit;
      end;}
    end;
  end;

  if not SecondPreserved and ((FirstJoinFilters = nil) or (FirstJoinFilters.Count = 0)) then
  begin
    JoinViaIndex:=CanJoinViaIndex(SecondTable, SecondJoinFields, False, False, IsUnique);
    if JoinViaIndex then begin
      {if IsUnique then}
        if SecondTable.GetRecordCount > FirstTable.GetRecordCount * 4 then begin
          if VerboseLogging then
            LogVerbose('Inner table has a unique join index and is more than twice the size of outer table');
          Result := False;
          exit;
        end;
      {if SecondTable.GetRecordCount > FirstTable.GetRecordCount * 10 then begin
        Log('Inner table has a join index and has 10 or more times the rows of the outer table');
        Result := False;
        exit;
      end;}
    end;
  end;

  {don't do hash join if the driver table has less than 500 or more than 1,500,000 rows}
  if (FirstSource.EstimatedRangeCount> 1000001) then begin
    LogNormal('Driver table too small or too large for hash join');
    Result := False;
    exit;
  end;

  if (SecondSource.EstimatedRangeCount > 2000001) then begin
    LogNormal('Secondary table too small or too large for hash join');
    Result := False;
    exit;
  end;

  if (FirstSource.EstimatedRangeCount=0) or ((SecondSource.EstimatedRangeCount div FirstSource.EstimatedRangeCount) > 1000) then begin
    LogNormal('Driver/secondary table ratio too high for hash join');
    Result := False;
    exit;
  end;

  if NormalLogging then
  begin
    LogNormal('');
    LogNormal('Hash join. Driving (outer) table: "' + TableNameStr(FirstTable) + '"');
  end;

  (* hash join doesn't benefit from this anyway
  if not JoinViaIndex then
  begin
    if SecondTable.IsTemp then
    begin
      aColumnList:=TnxFastStringListIC.Create;
      try
        //for j := 0 to high(JoinFieldsL) do
        //  aColumnList.Add(JoinFieldsL[j].Name);
        for j := 0 to high(secondJoinFields) do
          aColumnList.Add(SecondJoinFields[j].Name);

        SecondTable.AddIndex('tempsecond', aColumnList, idAll, false, true);
      finally
        aColumnList.Free;
      end;
    end;
  end;
  *)

  {We are about to do a hash join}
  if LimitDependsOnMatchingSort then begin
    if Limit > -1 then
      LogNormal('About to perform a hash join, limit depending on sort order active - disable limit optimization (limit must be applied after sorting result)');
    {hash joins are always unsorted}
    Limit := -1; //need to apply limit after sorting later
  end;

  if not DoHashJoin then begin
    Result := False;
    LogNormal('!!! Hash join failed - most likely due to a low-memory condition');
    exit;
  end;

  Result := True;

  if NormalLogging then
  begin
    {$IFOPT Q+}
      {$DEFINE LocalOverflowCheckOFF}
      {$OVERFLOWCHECKS OFF}
    {$ENDIF}
    LogNormal('Elapsed:' + IntToStr(GetTickCount - Start));
    {$IFDEF LocalOverflowCheckOFF}
      {$OVERFLOWCHECKS ON}
      {$UNDEF LocalOverflowCheckOFF}
    {$ENDIF}
    LogNormal('Records written:' + IntToStr(RW));
    LogNormal('');
  end;
end;

function TnxSqlRowBuilder.MergeJoin(UseIndex: Boolean; LoopProc: TnxSqlRowBuilderCallback;
      OuterJoinMode: TnxSqlOuterJoinMode; UserData: Pointer; var RecordsRead: Integer): Boolean;
var
  JoinFactors, JoinFiltersT1, JoinFiltersT2: TList;
  i, FailIdx : Integer;
  avar: Variant;
begin
  Result := False;
  {TODO: possible optimization to allow merge join in more cases here, validate if the FOwnerJoin check can be removed }
  if FOwnerJoin <> nil then begin
    if VerboseLogging then
    begin
      LogVerbose('');
      LogVerbose('Considering merge join');
    end;

    // fix for ADO.NET schema generation
    avar:=FContext.TryGetValue('$SQL$NO_MERGE_JOIN');
    if (avar<>null) and wordbool(avar) then
    begin
      LogNormal('Mergejoin disabled: $SQL$NO_MERGE_JOIN = true');
      exit;
    end;

  if OuterJoinMode<>jmNone then
  begin
    LogNormal('Mergejoin not possible with outer join.');
    exit;
  end;

    {
    if OuterJoinMode<>jmNone then
    begin
      if VerboseLogging then
        LogVerbose('Outer Join -> Can''t use merge join.');
      exit;
    end;
    }

    if Assigned(FOwnerJoin) and (fOwnerJoin.Natural or (fOwnerJoin.UsingList<>nil)) then
    begin
      LogVerbose('Join is natural or using -> Can''t use merge join.');
      exit;
    end;

    if UseIndex then begin
      if (UserData = nil) then begin
        if FJoinCondition <> nil then begin
          if (Sources.Count = 2) then begin
//            if not ((Sources.Item[0].Table.GetRecordCount > 50 * Sources.Item[1].Table.GetRecordCount)
//            or (Sources.Item[1].Table.GetRecordCount > 50 * Sources.Item[0].Table.GetRecordCount)) then
            if not Sources.Item[0].Table.IsMetaTable and not Sources.Item[1].Table.IsMetaTable then begin
              if Assigned(FOwnerJoin) and (FOwnerJoin.JoinType = jtInner) and
              ((Sources.Item[0].Table.GetRecordCount = 0) or (Sources.Item[1].Table.GetRecordCount = 0)) then begin
                if NormalLogging then
                  LogNormal('INNER JOIN with at least one source table empty - shortcircuiting');
                  Result := True;
                  Exit;
              end;
              if (FJoinCondition.CondTermCount = 1) then begin
                if not assigned(LoopProc) then begin
                  JoinFactors := TList.Create;
                  JoinFiltersT1 := TList.Create;
                  JoinFiltersT2 := TList.Create;
                  try
                    if IsSimpleRelationBetween(FContext, JoinCondition.CondTerm[0],
                      Sources.Item[0].Table, Sources.Item[1].Table, OuterJoinMode, False, FailIdx,
                      JoinFactors, JoinFiltersT1, JoinFiltersT2) then begin
                      if ExecuteBinaryMergeJoin(OuterJoinMode, JoinFactors, JoinFiltersT1, JoinFiltersT2, RecordsRead) then begin
                        Result := True;
                        //exit;
                      end else
                        if VerboseLogging then
                          LogVerbose('Simple merge join execution failed or was deemed sub-optimal');
                    end else begin
                      if VerboseLogging then
                        LogVerbose(JoinCondition.CondTerm[0].CondFactor[FailIdx].ToString + ' is not a simple relation between '
                          + TableNameStr(Sources.Item[0].Table) + ' and ' + TableNameStr(Sources.Item[1].Table));
                    end;
                  finally
                    JoinFactors.Free;
                    if JoinFiltersT1 <> nil then begin
                      for i := 0 to JoinFiltersT1.Count - 1 do
                        TObject(JoinFiltersT1[i]).Free;
                      JoinFiltersT1.Free;
                    end;
                    if JoinFiltersT2 <> nil then begin
                      for i := 0 to JoinFiltersT2.Count - 1 do
                        TObject(JoinFiltersT2[i]).Free;
                      JoinFiltersT2.Free;
                    end;
                  end;
                end else
                begin
                  if VerboseLogging then
                    LogVerbose('Loop proc assigned (not a row-producing expression)');
                end
              end else
              begin
                if VerboseLogging then
                  LogVerbose('More than one logical term in join condition')
                end
            {  else
                begin
                  if VerboseLogging then
                    LogVerbose('Mismatched table sizes - merge-joined deemed sub-optimal');
              end}
            end else
            begin
              if VerboseLogging then
                LogVerbose('One more table is a meta-table, cannot merge-join those');
            end
          end else
          begin
            if VerboseLogging then
              LogVerbose('Not a binary join');
          end
        end else
        begin
          if VerboseLogging then
            LogVerbose('No join condition');
        end
      end else
      begin
        if VerboseLogging then
          LogVerbose('UserData is <> nil');
      end
    end else
    begin
      if VerboseLogging then
        LogVerbose('optimization disabled');
    end
  end;
end;


function TnxSqlRowBuilder.HashJoin(UseIndex: Boolean;
  LoopProc: TnxSqlRowBuilderCallback; OuterJoinMode: TnxSqlOuterJoinMode;
  UserData: Pointer; var RecordsRead: Integer): Boolean;
var
  JoinFactors, JoinFiltersT1, JoinFiltersT2: TList;
  i, FailIdx : Integer;
  aVar: Variant;
begin
  Result := False;
//  if FOwnerJoin <> nil then begin
    if VerboseLogging then
    begin
      LogVerbose('');
      LogVerbose('');
      LogVerbose('Considering hash join');
    end;

    avar:=FContext.TryGetValue('$SQL$NO_HASH_JOIN');
    if not VarIsNull(aVar) and wordbool(avar) then
    begin
      LogNormal('Hashjoin disabled: $SQL$NO_HASH_JOIN = true');
      exit;
    end;

    if UseIndex then begin
      //if (UserData = 0) then begin
        if FJoinCondition <> nil then begin

          if (JoinCondition.Parent<>nil) and (joincondition.Parent is TnxSqlJoinTableExp) then
            if (joincondition.Parent as TnxSqlJoinTableExp).Natural then begin
              if VerboseLogging then
                LogVerbose('Natural join selected, can''t use hash join');
              exit;
            end;

          if (Sources.Count = 2) then begin
            if not Sources.Item[0].Table.IsMetaTable and not Sources.Item[1].Table.IsMetaTable then begin

              if Assigned(FOwnerJoin) and (FOwnerJoin.JoinType = jtInner) and
              ((Sources.Item[0].Table.GetRecordCount = 0) or (Sources.Item[1].Table.GetRecordCount = 0)) then begin
                if NormalLogging then
                  LogNormal('INNER JOIN with at least one source table empty - shortcircuiting');
                  Result := True;
                  Exit;
              end;

              if (FJoinCondition.CondTermCount = 1) then begin
                  JoinFactors := TList.Create;
                  JoinFiltersT1 := TList.Create;
                  JoinFiltersT2 := TList.Create;
                  try
                    if IsSimpleRelationBetween(FContext, JoinCondition.CondTerm[0],
                      Sources.Item[0].Table, Sources.Item[1].Table, OuterJoinMode, False, FailIdx,
                      JoinFactors, JoinFiltersT1, JoinFiltersT2) then begin
                      if ExecuteBinaryHashJoin(OuterJoinMode, JoinFactors, JoinFiltersT1, JoinFiltersT2, RecordsRead, UserData) then begin
                        Result := True;
                        //exit;
                      end else
                      begin
                        if VerboseLogging then
                          LogVerbose('Binary hash join execution failed or was deemed sub-optimal');
                      end
                    end else begin
                      if VerboseLogging then
                        LogVerbose(JoinCondition.CondTerm[0].CondFactor[FailIdx].ToString + ' is not a simple relation between '
                          + TableNameStr(Sources.Item[0].Table) + ' and ' + TableNameStr(Sources.Item[1].Table));
                    end;
                  finally
                    JoinFactors.Free;
                    if JoinFiltersT1 <> nil then begin
                      for i := 0 to JoinFiltersT1.Count - 1 do
                        TObject(JoinFiltersT1[i]).Free;
                      JoinFiltersT1.Free;
                    end;
                    if JoinFiltersT2 <> nil then begin
                      for i := 0 to JoinFiltersT2.Count - 1 do
                        TObject(JoinFiltersT2[i]).Free;
                      JoinFiltersT2.Free;
                    end;
                  end;
              end else
              begin
                if VerboseLogging then
                  LogVerbose('More than one logical term in join condition')
              end
            end else begin
              if VerboseLogging then
                LogVerbose('One more table is a meta-table, cannot hash-join those');
            end
          end else
          begin
            if VerboseLogging then
              LogVerbose('Not a binary join');
          end
        end else
        begin
          if VerboseLogging then
            LogVerbose('No join condition');
        end
    end else
    begin
      if VerboseLogging then
        LogVerbose('optimization disabled');
    end;
end;

function TnxSqlRowBuilder.FullyOptimized: Boolean;
var
  i, j: Integer;
begin
  for j := 0 to pred(JoinCondition.CondTermCount) do
    with JoinCondition.CondTerm[j] do
      for i := OrderedSources.Count - 1 downto 0 do
        if (OrderedSources.Item[i].KeyRelation = nil) then begin
          if VerboseLogging then
            LogVerbose('Not fully optimized');
          Result := False;
          exit;
        end;
  Result := True;
end;

procedure TnxSqlRowBuilder.CopyBackKeyRelations;
var
  i, j, k: Integer;
begin
  for i := 0 to Sources.Count - 1 do
    Sources.Item[i].KeyRelationRef := nil;
  if assigned(JoinCondition) then  
    for j := 0 to pred(JoinCondition.CondTermCount) do
      with JoinCondition.CondTerm[j] do
        for i := OrderedSources.Count - 2 downto 0 do
          if (OrderedSources.Item[i].KeyRelation <> nil) then begin
            for k := 0 to Sources.Count - 1 do
              if Sources.Item[k].Table = OrderedSources.Item[i].Table then begin
                Sources.Item[k].KeyRelationRef := OrderedSources.Item[i].KeyRelation;
                Break;
              end;
          end;
end;

procedure TnxSqlRowBuilder.Execute(aContext: TnxSqlContext; UseIndex: Boolean; LoopProc: TnxSqlRowBuilderCallback;
      OuterJoinMode: TnxSqlOuterJoinMode; UserData: Pointer; var RecordsRead: Integer);
var
  Tables: string;
  i, j, f: Integer;
  Start: Cardinal;
  OrderByState: TnxSqlSortedState;
  t, c1, c2: Comp;
  TmpT0, TmpT1: TnxSqlTableProxy;
  TmpN: string;
  TmpRR0, TmpRR1: TnxSqlRowRange;
  TmpTerm: TnxSqlCondTerm;
  JoinFiltersT1: TList;
  JoinFactors: TList;

  OldGen : Integer;
  OldRR  : Int64;
begin
  if Assigned(aContext) then begin
    OldGen := aContext.Generation;
    OldRR := aContext.RecordsRead;
    aContext.IncGeneration;
  end else begin
    OldGen := -1;
    OldRR := -1;
  end;
  try
  Assert(aContext <> nil);
  FOuterJoinMode := OuterJoinMode;
  FContext := aContext;
  if assigned(LoopProc) then
    InnerRowHandler := LoopProc
  else
    InnerRowHandler := CreateResultRecord;

  if assigned(FOwnerStatement) and (FOwnerStatement.Logging) and ((not FLogFirstPassOnly) or not NotFirstPass) then begin
    if NormalLogging then
    begin
      LogNormal('');
      LogNormal('Processing row build on behalf of');

      Indent;
      if FOwnerJoin <> nil then
        LogNormal(FOwnerJoin.ToString)
      else if FOwnerSelect <> nil then
        LogNormal(FOwnerSelect.ToString);
      Outdent;

      LogNormal('');
      Indent;

      LogNormal('Participating tables:');
      Tables:='';
      for i := 0 to Sources.Count - 1 do begin
        TmpT0 := Sources.Item[i].Table;
        TmpN := TableNameStr(TmpT0);
        Tables := Tables + TmpN + ', ';
        if VerboseLogging then
          LogVerbose(TmpN + ' - Rows in table:' + format('%.0n', [TmpT0.GetRecordCount * 1.0]));
      end;
      LogNormal(Tables);
      Outdent;
      LogNormal('');
    end;
  end;

  if JoinCondition<>nil then begin
    if (Sources.Count=2) and not FLogFirstPassOnly {don't use this for sub-queries} then
      if HashJoin(UseIndex, LoopProc, OuterJoinMode, UserData, RecordsRead) then
        exit;
    LogNormal('Hash join deemed unsuitable');

    if (Sources.Count=2) and not FLogFirstPassOnly {don't use this for sub-queries} then
      if MergeJoin(UseIndex, LoopProc, OuterJoinMode, UserData, RecordsRead) then
        exit;
    LogNormal('Merge join deemed unsuitable');

    if NormalLogging then
      LogNormal('Using standard join');
  end;

  ReadReversed := False;
  LimitReached := False;
  FRecordRead := 0;
  if Assigned(FContext) then
    FContext.RecordsRead := FRecordRead;
  RecordsWritten := 0;


  RowHandler := OuterRowHandler;

  if OuterJoinMode <> jmNone then begin
    TmpRR0 := Sources.Item[0];
    TmpRR1 := Sources.Item[1];
    case OuterJoinMode of
    jmLeft, jmFull :
      begin
        TmpRR0.Outer := True;
        TmpRR0.Opposite := TmpRR1.Table;
        Sources.OuterJoin := True;
      end;
    jmRight :
      begin
        TmpRR1.Outer := True;
        TmpRR1.Opposite := TmpRR0.Table;
        Sources.OuterJoin := True;
      end;
    end;
  end;

  Start := GetTickCount;

  Optimize(UseIndex, FContext);
  if UseIndex then
    CopyBackKeyRelations;

  if not NotFirstPass and (not WasOptimized or not FullyOptimized) and UseIndex then begin
    //see if we can add an index to a temp table to allow for
    //optimization

    if TryToAddSuitableIndex then begin
      OptimizeCalled := False;
      Optimize(UseIndex, FContext);
    end;

  end;

  if OuterJoinMode=jmFull then
    WasOptimized:=false; // disallow use of indices for full joins - temp solution for 2470

  if WasOptimized then begin
    if VerboseLogging then
      LogVerbose('Was optimized');

    if LimitDependsOnMatchingSort then
      case SortWillMatch of
      ssUnordered :
        Limit := -1;
      ssReversed :
        ReadReversed := True;
      end;

    if JoinCondition.CondTermCount > 1 then begin
      DupList := TnxNRecordHash.Create;
      for i := 0 to pred(Sources.Count) do
        Duplist.AddTable(Sources.Item[i].Table);
    end else
      DupList := nil;

    {$ifdef SaveLogToFile}
    if (FOwnerStatement<>nil) and (FOwnerStatement.LogList<>nil) then
      FOwnerStatement.LogList.SaveToFile('c:\test.log');
    {$endif}
    FirstCondTerm := True;
    for i := 0 to pred(JoinCondition.CondTermCount) do begin
      LastCondTerm := i = pred(JoinCondition.CondTermCount);
      TmpTerm := JoinCondition.CondTerm[i];
      TmpTerm.OrderedSources.OuterJoin := OuterJoinMode <> jmNone;

      JoinFactors:=TList.Create;
      try
        for j:=0 to TmpTerm.OrderedSources.Count - 1 do
        begin
          JoinFiltersT1:=TList.Create;
          JoinFactors.Clear;
          GetGlobalJoinFilters(TmpTerm.OrderedSources.Item[j].Table, nil, JoinFiltersT1, nil, JoinFactors);

          if VerboseLogging then begin
            LogVerbose('Global join filters on table "' + TmpTerm.OrderedSources.Item[j].Table.Name + '"');
            Indent;
            if JoinFiltersT1.Count = 0 then
              LogVerbose('  (none)')
            else
            for f := 0 to JoinFiltersT1.Count - 1 do
              LogVerbose(TnxSqlCondFactor(JoinFiltersT1[f]).ToString);
            Outdent;
          end;

          if TmpTerm.OrderedSources.Item[j].GlobalFilters<>nil then
            TmpTerm.OrderedSources.Item[j].GlobalFilters:=nil; //this frees the contents!
          TmpTerm.OrderedSources.Item[j].GlobalFilters:=JoinFiltersT1;
        end;
        TmpTerm.OrderedSources.Join(FContext, TmpTerm, RowHandler, UserData, ReadReversed);
      finally
        for j := 0 to TmpTerm.OrderedSources.Count - 1 do
          TmpTerm.OrderedSources.Item[j].GlobalFilters:=nil; //this frees the contents!
        JoinFactors.Free;
      end;

      inc(FRecordRead, TmpTerm.OrderedSources.RecordsRead);
      if Assigned(FContext) then
        FContext.RecordsRead := FRecordRead;
      FirstCondTerm := False;
    end;

    nxFreeAndNil(DupList);

    if OuterJoinMode = jmFull then begin
      if VerboseLogging then
        LogVerbose('Processing opposite side of full join');
      TmpRR0 := Sources.Item[0];
      TmpRR1 := Sources.Item[1];
      TmpRR0.Outer := False;
      TmpRR1.Outer := True;
      TmpRR1.Opposite := TmpRR0.Table;

      OptimizeCalled := False;
      Optimize(UseIndex, FContext);

      if not WasOptimized then begin
        //see if we can add an index to a temp table to allow for
        //optimization

        if TryToAddSuitableIndex then begin
          OptimizeCalled := False;
          Optimize(UseIndex, FContext);

        end;
      end;

      if WasOptimized then begin

        if VerboseLogging then
          LogVerbose('Was optimized');

        if JoinCondition.CondTermCount > 1 then begin
          DupList := TnxNRecordHash.Create;
          for i := 0 to pred(Sources.Count) do
            Duplist.AddTable(Sources.Item[i].Table);
        end else
          DupList := nil;

        FirstCondTerm := True;
        {$ifdef SaveLogToFile}
        if (FOwnerStatement<>nil) and (FOwnerStatement.LogList<>nil) then
          FOwnerStatement.LogList.SaveToFile('c:\test.log');
        {$endif}

        for i := 0 to pred(JoinCondition.CondTermCount) do begin
          LastCondTerm := i = pred(JoinCondition.CondTermCount);
          with JoinCondition.CondTerm[i] do begin
            OrderedSources.OuterJoin := True;
            OrderedSources.SkipInner := True;
            OrderedSources.Join(FContext,JoinCondition.CondTerm[i], RowHandler, UserData, ReadReversed);
            inc(FRecordRead, OrderedSources.RecordsRead);
            if Assigned(FContext) then
              FContext.RecordsRead := FRecordRead;
          end;
          FirstCondTerm := False;
        end;

        nxFreeAndNil(DupList);

      end else begin
        if VerboseLogging then
          LogVerbose('Was not optimized');
        if JoinCondition <> nil then
          JoinCondition.SetLevelDep(FContext, Sources);
        Level := Sources.Count - 1;
        {$ifdef SaveLogToFile}
        if (FOwnerStatement<>nil) and (FOwnerStatement.LogList<>nil) then
          FOwnerStatement.LogList.SaveToFile('c:\test.log');
        {$endif}
        ReadSources(UserData);
      end;
      OptimizeCalled := False;

    end;

    SortedState := ssUnordered;
    if JoinCondition.CondTermCount = 1 then
      if
        (JoinCondition.CondTerm[0].OrderedSources.Count < 1) or
        (JoinCondition.CondTerm[0].OrderedSources.Item[0].IterateCalled <= 1)
      then
        SetSortedState;

    case SortedState of
    ssUnordered :
      if LimitDependsOnMatchingSort then
        Limit := -1;
    ssReversed :
      ReadReversed := True;
    end;

  end else begin
    if VerboseLogging then
      LogVerbose('Was not optimized');

    // see if we have an index, which suits us
    OrderByState := SetOrderByIndex(OrderByScope);

    SortedState := ssOrdered;

    case OrderByState of
    ssUnordered :
      begin
        if LimitDependsOnMatchingSort then
          Limit := -1;
        SortedState := ssUnOrdered;
      end;
    ssReversed :
      ReadReversed := True;
    end;


    case OuterJoinMode of
    jmLeft :
      begin
        RecListL := TnxNRecordHash.Create;
        ReclistL.AddTable(Sources.Item[0].Table);
      end;
    jmRight :
      begin
        RecListR := TnxNRecordHash.Create;
        ReclistR.AddTable(Sources.Item[1].Table);
      end;
    jmFull :
      begin
        RecListL := TnxNRecordHash.Create;
        ReclistL.AddTable(Sources.Item[0].Table);
        RecListR := TnxNRecordHash.Create;
        ReclistR.AddTable(Sources.Item[1].Table);
      end;
    end;
    if JoinCondition <> nil then
      JoinCondition.SetLevelDep(FContext, Sources);
    Level := Sources.Count - 1;
    ReadSources(UserData);

    if OuterJoinMode <> jmNone then begin
      TmpT0 := Sources.Item[0].Table;
      TmpT1 := Sources.Item[1].Table;
      case OuterJoinMode of
      jmLeft :
        begin
          TmpT1.NullRecord;
          TmpT0.Iterate(WriteNull, RecListL);
          nxFreeAndNil(RecListL);
        end;
      jmRight :
        begin
          TmpT0.NullRecord;
          TmpT1.Iterate(WriteNull, RecListR);
          nxFreeAndNil(RecListR);
        end;
      jmFull :
        begin
          TmpT1.NullRecord;
          TmpT0.Iterate(WriteNull, RecListL);
          TmpT0.NullRecord;
          TmpT1.Iterate(WriteNull, RecListR);
          nxFreeAndNil(RecListL);
          nxFreeAndNil(RecListR);
        end;
      end;
    end;

  end;
//  if assigned(FOwnerStatement) and (FOwnerStatement.Logging) then
//    LogVerbose(format('Theoretical max rows to read: %.0n', [Count]));
  {inc(RecordsRead, FRecordsRead);}
  c1 := RecordsRead;
  c2 := FRecordRead;
  t := c1 + c2;
  if t > high(Integer) then
    RecordsRead := MaxInt
  else begin
    RecordsRead := Trunc(t);
    {inc(RecordsRead, Sources.RecordsRead);}
    t := RecordsRead + Sources.RecordsRead;
    if t > high(Integer) then
      RecordsRead := MaxInt
    else
      RecordsRead := Trunc(t);
  end;
  {LogNormal(format('Rows read: %.0n', [1.0 * FRecordsRead + Sources.RecordsRead]));}
  if assigned(FOwnerStatement) and (FOwnerStatement.Logging) then
  begin
    if NormalLogging then
    begin
      LogNormal(format('Rows written: %.0n', [1.0 * RecordsWritten]));
      {$IFOPT Q+}
        {$DEFINE LocalOverflowCheckOFF}
        {$OVERFLOWCHECKS OFF}
      {$ENDIF}
      LogNormal('Elapsed in rowbuilder:' + IntToStr(GetTickCount - Start));
      {$IFDEF LocalOverflowCheckOFF}
        {$OVERFLOWCHECKS ON}
        {$UNDEF LocalOverflowCheckOFF}
      {$ENDIF}
      LogNormal('');
    end;
  //SetSortedState;
    if FLogFirstPassOnly then begin
      if VerboseLogging then
      begin
        LogVerbose('Rowset used as column sub-query - only this first pass is logged');
        LogVerbose('');
        NotFirstPass := True;
      end;
    end;
  end;
  if FLogFirstPassOnly then
    NotFirstPass := True;
  finally
   {$ifdef SaveLogToFile}
   if (FOwnerStatement<>nil) and (FOwnerStatement.LogList<>nil) then
      FOwnerStatement.LogList.SaveToFile('c:\test.log');
   {$endif}
   if Assigned(aContext) then begin
     aContext.Generation := OldGen;
     aContext.RecordsRead := OldRR;
   end;
  end;
end;

procedure TnxSqlRowBuilder.LogVerbose(const S: string);
begin
  if FLogFirstPassOnly and NotFirstPass then exit;
  if assigned(FOwnerStatement) then
    FOwnerStatement.LogVerbose(S);
end;

procedure TnxSqlRowBuilder.SetOrderByDescriptor(value: TnxIndexDescriptor);
begin
  if fOrderByDescriptor<>nil then
    fOrderByDescriptor.free;
  
  fOrderByDescriptor:=value;
end;

procedure TnxSqlRowBuilder.BuildCompareDictionary(
  JoinFields: array of TnxSqlFieldProxy;
  var CompFieldCount: Integer;
  var CompareDictionary: TnxDataDictionary;
  Direct: Boolean;
  var CompareEngine: TnxBaseKeyEngine;
  Temp: TnxSqlTableProxy);
var
  i: Integer;
  j: Integer;
  ld: TnxLocaleDescriptor;
begin
  {build dictionary for comparing}
  CompareDictionary := TnxDataDictionary.Create;
  CompareDictionary.AssignOnlyFields(Temp.Cursor._Dictionary);
  with CompareDictionary.AddIndicesDescriptor do
    with AddIndex('CompareIndex', 0, True, '', TnxCompKeyDescriptor) do begin
      if Direct then begin
        // join fields are stored in the JoinFields array
        for i := 0 to high(JoinFields) do
          with TnxExtTextKeyFieldDescriptor(
            TnxCompKeyDescriptor(KeyDescriptor).Add(JoinFields[i].Index, TnxExtTextKeyFieldDescriptor)) do begin
            IgnoreCase := False;
            ld := JoinFields[i].GetLocaleDesc;
            if ld <> nil then
              AddLocaleDescriptor.Assign(ld);
          end;
        CompFieldCount := length(JoinFields);
      end else begin
        // join fields are all fields from left except recno
        for j := 0 to Temp.FieldCount - 2 do
          with TnxExtTextKeyFieldDescriptor(TnxCompKeyDescriptor(KeyDescriptor).Add(j, TnxExtTextKeyFieldDescriptor)) do begin
            IgnoreCase := False;
            ld := Temp.FieldNC(j).GetLocaleDesc;
            if ld <> nil then
              AddLocaleDescriptor.Assign(ld);
          end;
        CompFieldCount := Temp.FieldCount - 1;
      end;
    end;
  CompareEngine := TnxBaseKeyEngine.CreateFor(CompareDictionary.IndicesDescriptor.IndexDescriptor[0].KeyDescriptor);
end;

procedure TnxSqlRowBuilder.LogNormal(const S: string);
begin
  if FLogFirstPassOnly and NotFirstPass then exit;
  if assigned(FOwnerStatement) then
    FOwnerStatement.LogNormal(S);
end;

procedure TnxSqlRowBuilder.LogVerbose(const S1: string; B1: Boolean);
const
  FalseTrue: array[Boolean] of string = ('FALSE', 'TRUE');
begin
  if FLogFirstPassOnly and NotFirstPass then exit;
  if assigned(FOwnerStatement) then
    FOwnerStatement.LogVerbose(format('%s %s', [S1, FalseTrue[B1]]));
end;

procedure TnxSqlRowBuilder.LogVerbose(const S1: string; I1: Integer);
begin
  if FLogFirstPassOnly and NotFirstPass then exit;
  if assigned(FOwnerStatement) then
    FOwnerStatement.LogVerbose(format('%s %d', [S1, I1]));
end;

procedure TnxSqlRowBuilder.Indent;
begin
  if assigned(FOwnerStatement) then
    FOwnerStatement.Indent;
end;

procedure TnxSqlRowBuilder.Outdent;
begin
  if assigned(FOwnerStatement) then
    FOwnerStatement.Outdent;
end;

function TnxSqlRowBuilder.OuterRowHandler(Cookie: Pointer): Boolean;
begin
  if (DupList <> nil)
  and not FirstCondTerm
  and DupList.Exists then begin
    Result := True; // continue
    exit;
  end;

  if LimitReached then
    Result := False
  else begin
    Result := InnerRowHandler(Cookie);
    if Result then begin
//      inc(RecordsWritten);
      if (Limit >= 0) and (RecordsWritten >= Limit + LimitStart) then begin
        LimitReached := True;
        Result := False;
      end;
    end;
  end;

  if (DupList <> nil)
  and not LastCondTerm then
    DupList.Add;
  if assigned(RecListL) then
    if not RecListL.Exists then
      RecListL.Add;
  if assigned(RecListR) then
    if not RecListR.Exists then
      RecListR.Add;
end;

{ TnxSqlJoinTableExp }

function TnxSqlJoinTableExp.BuildSimpleFieldExpr(AOwner: TnxSqlNode;
  const ATableName, AFieldName: string; AField: TnxSqlFieldProxy
    ): TnxSqlSimpleExpression;
var
  Term: TnxSqlTerm;
  Fact: TnxSqlFacColumn;
  FieldRef: TnxSqlFieldRef;
begin
  Result := TnxSqlSimpleExpression.Create(AOwner);
  Term := TnxSqlTerm.Create(Result);
  Fact := TnxSqlFacColumn.Create(Term);
  FieldRef := TnxSqlFieldRef.Create(Fact);
  FieldRef.TableNameStr := ATableName;
  FieldRef.FieldNameStr := AFieldName;
  FieldRef.SetField(AField);
  Fact.FieldRef := FieldRef;
  Term.AddFactor(Fact);
  Result.AddTerm(Term);
end;

procedure TnxSqlJoinTableExp.ClearColumns;
begin
  if not Assigned(Columns) then
    exit;
  Columns.FreeExpressions;
  Columns.Clear;
end;

procedure TnxSqlJoinTableExp.OnRequestClose(Sender: TObject);
begin
  snLockContainer.Lock;
  try
    if snLockContainer.UseCount=0 then
      Unbind;
  finally
    snLockContainer.Unlock;
  end;
end;

function TnxSqlJoinTableExp.IsColumnReferenced(aTableName, aTableAlias, aFieldName: String; Context: TnxSQLContext): Boolean;
var
  aOwner: TnxSQLRootNode;
  aSelect: TnxSQLSelect;
  i: Integer;
  Simp: TnxSQLSimpleExpression;
  FR: TnxSqlFieldRef;
begin
  Result := True;
  exit;
  result:=false;
  aOwner:=Owner;
  while aOwner<>nil do
  begin
    if aOwner.RefersTo2(aTableName, aFieldName) or aOwner.RefersTo2(aTableAlias, aFieldName) then
      result:=true;
    if (not result) and (aOwner.OwnerSelect<>nil) then
    begin
      aSelect:=TnxSQLSelect(aOwner.OwnerSelect);

      for i := aSelect.SelectionList.Count -1 downto 0 do
      begin
        Simp := aSelect.SelectionList[i].SimpleExpression;
        if Simp <> nil then
        begin
          if Simp.TermList[0].FactorList[0] is TnxSqlFacColumn then
          begin
            FR := TnxSqlFacColumn(Simp.TermList[0].FactorList[0]).FieldRef;
            if FR <> nil then
            begin
              if FR.FieldNameStr = '' then
              begin
                if FR.TableNameStr = '' then
                  result:= true // all tables, all fields
                else
                  if SameText(FR.TableNameStr, aTableName) or (SameText(FR.TableNameStr, aTableAlias)) then
                    result:=true;
              end;
            end;
          end;
        end;
      end;

      if not result and (TnxSQLSelect(aOwner.OwnerSelect).RefersTo2(aTableName, aFieldName) or
        TnxSQLSelect(aOwner.OwnerSelect).RefersTo2(aTableAlias, aFieldName)) then
        result:=true;
    end;
    aOwner:=aOwner.Owner;
  end;
end;

procedure TnxSqlJoinTableExp.Bind;
var
//  aTableName: string;
  aFieldName: string;
//  aOwner: TnxSQLRootNode;
  i, j : Integer;
  FL, FR: TnxSqlFieldProxy;
  lCondTerm: TnxSqlCondTerm;
  lCondFact: TnxSqlCondFactor;
  lCondPrim :  TnxSqlCPSimple;
  lSimp1, lSimp2, cSimp, cSimp1, cSimp2: TnxSqlSimpleExpression;
  cTerm: TnxSqlTerm;
  cFact: TnxSqlFacFunc;
  cScalar : TnxSqlsfCoalesce;
  S: string;
  N1, N2: string;
  aName: string;
begin
  snBeginUse;
  try
    if Binding then
      Exit;
    Binding := True;

    FIsDependent := False;
    if Natural then begin
      if CondExp <> nil then
        SQLError(rsONClauseOnNaturalJoinsNotAllowed);
      if UsingList <> nil then
        sQLError(rsUsingClauseOnNaturalJoinsNotAllowed);
    end;
    if not Natural and not (JoinType in [jtCross{,jtUnion}]) then begin
      if (CondExp = nil) and (UsingList = nil) then
        SQLError(rsONOrUSINGClauseExpected);
    end;
    if CondExp <> nil then
      CondExp.Traverse(ClearBindings, Context, False);
    Assert(assigned(TableRef1));
    Assert(assigned(TableRef2));
    if TableRef1.AliasStr <> '' then
      N1 := TableRef1.AliasStr
    else
      N1 := TableRef1.TablenameStr;
    if TableRef2.AliasStr <> '' then
      N2 := TableRef2.AliasStr
    else
      N2 := TableRef2.TablenameStr;
    if SameText(N1, N2) then
      SQLError(format(rsAmbiguousTableReference, [N2, TableRef2.LocationStr]));
    TL2 := TableRef1.BindTable(Context, Self, '', TableRef1.TableNameStr);
    if TL2 = nil then
      EBadTab(TableRef1.TableNameStr, TableRef1.Tablename);
    TL2Monitor := TL2.GetLifetimeMonitor;
    TR2 := TableRef2.BindTable(Context, Self, '', TableRef2.TableNameStr);
    if TR2 = nil then
      EBadTab(TableRef2.TableNameStr, TableRef2.TableName);
    TR2Monitor := TR2.GetLifetimeMonitor;
{ rollback 2234
    RL := TableRef1.Refresh;
    RR := TableRef2.Refresh;
}
    if assigned(TableRef1.TableExp) then
      RL := TableRef1.TableExp.Refresh
    else
      RL := nil;
    if assigned(TableRef2.TableExp) then
      RR := TableRef2.TableExp.Refresh
    else
      RR := nil;

    if not Assigned(sjteRequestClose) then
      sjteRequestClose := nxRequestCloseHandlerEvent(OnRequestClose);

    TL2.SetCloseNotification(sjteRequestClose);
    TR2.SetCloseNotification(sjteRequestClose);

    Assert(Assigned(Columns));
    ClearColumns;

    if Natural then begin
      UsingCondExp := TnxSqlCondExp.Create(Self);
      lCondTerm := TnxSqlCondTerm.Create(UsingCondExp);
      for i := 0 to TL2.FieldCount - 1 do begin
        FL := TL2.FieldC(i);
        FR := TR2.FieldByName(FL.Name);
        if FR <> nil then begin
          FL.ExactReference:=true;
          FR.ExactReference:=true;
          lCondFact := TnxSqlCondFactor.Create(lCondTerm);
          lCondPrim :=  TnxSqlCPSimple.Create(lCondFact); //TnxSqlCondPrimary.Create(lCondFact);
          lSimp1 := BuildSimpleFieldExpr(lCondPrim, TableRef1.SQLName,
            FL.Name, FL);
          lSimp2 := BuildSimpleFieldExpr(lCondPrim, TableRef2.SQLName,
            FR.Name, FR);
          case JoinType of
          jtRightOuter :
            Columns.AddObject(FL.Name, FR);
          jtFullOuter :
            begin
              cSimp := TnxSqlSimpleExpression.Create(Self);
              cTerm := TnxSqlTerm.Create(cSimp);
              cFact := TnxSqlFacFunc.Create(cTerm);
              cScalar := TnxSqlsfCoalesce.Create(cFact);
              cSimp1 := BuildSimpleFieldExpr(cScalar, TableRef1.SQLName,
                FL.Name, FL);
              cSimp2 := BuildSimpleFieldExpr(cScalar, TableRef2.SQLName,
                FR.Name, FR);
              if ReturnPropagetedField(FL, FR)=FL then
              begin
                TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
                TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
              end
              else
              begin
                TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
                TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
              end;
              cFact.ScalarFunc := cScalar;
              cTerm.AddFactor(cFact);
              cSimp.AddTerm(cTerm);
              Columns.AddObject(FL.Name, cSimp);
            end;
          else
            begin
              if ReturnPropagetedField(FL, FR)=FL then
                Columns.AddObject(FL.Name, FL)
              else
                Columns.AddObject(FR.Name, FR)
            end;
          end;
          lCondPrim.SimpleExp1 := lSimp1;
          lCondPrim.SimpleExp2 := lSimp2;
          lCondPrim.RelOp := roEQ;
          lCondFact.CondPrimary := lCondPrim;
          lCondTerm.AddCondFactor(lCondFact);
        end;
      end;
      if lCondTerm.CondFactorCount = 0 then begin
        nxFreeAndNil(lCondTerm);
        nxFreeAndNil(UsingCondExp);
      end else begin
        UsingCondExp.AddCondTerm(lCondTerm);
        UsingCondExp.MatchType(Context, nxtBoolean);
      end;
      for i := 0 to TL2.FieldCount - 1 do begin
        FL := TL2.FieldC(i);
        if Columns.IndexOf(FL.Name) = -1 then
          Columns.AddObject(FL.Name, FL);
      end;
      for i := 0 to TR2.FieldCount - 1 do begin
        FR := TR2.FieldC(i);
        if Columns.IndexOf(FR.Name) = -1 then
          Columns.AddObject(FR.Name, FR);
      end;
    end else
    if UsingList <> nil then begin
      UsingCondExp := TnxSqlCondExp.Create(Self);
      try
      lCondTerm := TnxSqlCondTerm.Create(UsingCondExp);
      for i := 0 to UsingList.Count - 1 do begin
        FL := TL2.FieldByName(UsingList[i].ColumnNameStr);
        if FL = nil then
          EBadCol(TableRef1.SQLName, UsingList[i].ColumnNameStr);
        FR := TR2.FieldByName(UsingList[i].ColumnNameStr);
        if FR = nil then
          EBadCol(TableRef2.SQLName, UsingList[i].ColumnNameStr);

        FL.ExactReference:=true;
        FR.ExactReference:=true;


        // check for illegal qualified references
        if (OwnerSelect<>nil) and (OwnerSelect is TnxSQLSelect) then
        begin
          for j := 0 to TnxSQLSelect(OwnerSelect).SelectionList.Count - 1 do
          begin
            if TableRef1.AliasStr<>'' then
              aName:=TableRef1.AliasStr
            else
              aName:=TableRef1.TablenameStr;

            if (aName<>'') and TnxSQLSelect(OwnerSelect).SelectionList[j].SimpleExpression.RefersTo(aName) then
              if TnxSQLSelect(OwnerSelect).SelectionList[j].SimpleExpression.RefersTo(aName, UsingList[i].ColumnNameStr) then
                raise EnxInternalSQLException.Create(rsQualifiedSelectionReferenceNotAllowed+aName+'.'+UsingList[i].ColumnNameStr+')!');

            if TableRef2.AliasStr<>'' then
              aName:=TableRef2.AliasStr
            else
              aName:=TableRef2.TablenameStr;
            if (aName<>'') and TnxSQLSelect(OwnerSelect).SelectionList[j].SimpleExpression.RefersTo(aName) then
              if TnxSQLSelect(OwnerSelect).SelectionList[j].SimpleExpression.RefersTo(aName, UsingList[i].ColumnNameStr) then
                raise EnxInternalSQLException.Create(rsQualifiedSelectionReferenceNotAllowed+aName+'.'+UsingList[i].ColumnNameStr+')!');
          end;
          if TnxSQLSelect(OwnerSelect).GroupColumnList<>nil then
            for j := 0 to TnxSQLSelect(OwnerSelect).GroupColumnList.Count - 1 do
            begin
              if SameText(trim(TnxSQLSelect(OwnerSelect).GroupColumnList[j].ToString), (TableRef1.TablenameStr+'.'+UsingList[i].ColumnNameStr)) then
                raise EnxInternalSQLException.Create(rsQualifiedGroupingReferenceNotAllowed+TableRef1.TablenameStr+'.'+UsingList[i].ColumnNameStr+')!');
              if SameText(trim(TnxSQLSelect(OwnerSelect).GroupColumnList[j].ToString), (TableRef2.TablenameStr+'.'+UsingList[i].ColumnNameStr)) then
                raise EnxInternalSQLException.Create(rsQualifiedGroupingReferenceNotAllowed+TableRef2.TablenameStr+'.'+UsingList[i].ColumnNameStr+')!');
            end;
        end;

        lCondFact := TnxSqlCondFactor.Create(lCondTerm);
        lCondPrim := TnxSqlCPSimple.Create(lCondFact);

        FL.SlaveField := FR;
        FR.SlaveField := FL;
        lSimp1 := BuildSimpleFieldExpr(lCondPrim, TableRef1.SQLName,
          FL.Name, FL);
        lSimp2 := BuildSimpleFieldExpr(lCondPrim, TableRef2.SQLName,
          FR.Name, FR);
        case JoinType of
        jtFullOuter :
          begin
            cSimp := TnxSqlSimpleExpression.Create(Self);
            cTerm := TnxSqlTerm.Create(cSimp);
            cFact := TnxSqlFacFunc.Create(cTerm);
            cScalar := TnxSqlsfCoalesce.Create(cFact);
            cSimp1 := BuildSimpleFieldExpr(cScalar{cCoalesce}, TableRef1.SQLName,
              FL.Name, FL);
            cSimp2 := BuildSimpleFieldExpr(cScalar{cCoalesce}, TableRef2.SQLName,
              FR.Name, FR);
            if ReturnPropagetedField(FL, FR)=FL then
            begin
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
            end
            else
            begin
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
            end;
            cFact.ScalarFunc := cScalar;
            cTerm.AddFactor(cFact);
            cSimp.AddTerm(cTerm);
            cSimp.LeftFullSlaveField := FL;
            cSimp.RightFullSlaveField := FR;
            Columns.AddObject(FL.Name, cSimp);
          end;
        else
        begin
          if UsingList<>nil then
          begin
            cSimp := TnxSqlSimpleExpression.Create(Self);
            cTerm := TnxSqlTerm.Create(cSimp);
            cFact := TnxSqlFacFunc.Create(cTerm);
            cScalar := TnxSqlsfCoalesce.Create(cFact);
            TnxSqlsfCoalesce(cScalar).StrictTypes:=true;
            cSimp1 := BuildSimpleFieldExpr(cScalar, TableRef1.SQLName,
              FL.Name, FL);
            cSimp2 := BuildSimpleFieldExpr(cScalar, TableRef2.SQLName,
              FR.Name, FR);
            if ReturnPropagetedField(FL, FR)=FL then
            begin
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
            end
            else
            begin
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp2);
              TnxSqlsfCoalesce(cScalar).AddArg(cSimp1);
            end;
            cFact.ScalarFunc := cScalar;
            cTerm.AddFactor(cFact);
            cSimp.AddTerm(cTerm);
            cSimp.LeftFullSlaveField := FL;
            cSimp.RightFullSlaveField := FR;
            Columns.AddObject(FL.Name, cSimp);
          end
          else
          begin
            if ReturnPropagetedField(FL, FR)=FL then
              Columns.AddObject(FL.Name, FL)
            else
              Columns.AddObject(FR.Name, FR);
          end;
        end;
        end;
        lCondPrim.SimpleExp1 := lSimp1;
        lCondPrim.SimpleExp2 := lSimp2;
        lCondPrim.RelOp := roEQ;
        lCondFact.CondPrimary := lCondPrim;
        lCondTerm.AddCondFactor(lCondFact);
      end;
      UsingCondExp.AddCondTerm(lCondTerm);
      UsingCondExp.MatchType(Context, nxtBoolean);
      for i := 0 to TL2.FieldCount - 1 do begin
        FL := TL2.FieldNC(i);
        if Columns.IndexOf(FL.Name) = -1 then
          Columns.AddObject(FL.Name, FL);
      end;
      for i := 0 to TR2.FieldCount - 1 do begin
        FL := TR2.FieldNC(i);
        j := Columns.IndexOf(FL.Name);
        if j = -1 then
          Columns.AddObject(FL.Name, FL)
        else
        if j >= UsingList.Count then begin
          //Columns.AddObject(TR.Name + '.' + FL.Name, FL);
          S := FL.Name;
          j := 2;
          while Columns.IndexOf(S + '_' + IntToStr(j)) <> -1 do
            inc(j);
          Columns.AddObject(S+ '_' + IntToStr(j), FL);
        end;
      end;
      except
        nxFreeAndNil(lCondTerm);
        nxFreeAndNil(UsingCondExp);
        raise;
      end;
    end else begin
      for i := 0 to TL2.FieldCount - 1 do
      begin
//        aOwner:=Owner;
        aFieldName:=TL2.FieldNC(i).Name;
        if not TL2.IsTemp then
        begin
          if IsColumnReferenced(TL2.Name, TL2.Alias, TL2.FieldNC(i).Name, Context) then
            Columns.AddObject(TL2.FieldNC(i).Name, TL2.FieldNC(i));
        end
        else
            Columns.AddObject(aFieldName, TL2.FieldNC(i));
      end;

      for i := 0 to TR2.FieldCount - 1 do
        if Columns.IndexOf(TR2.FieldNC(i).Name) = -1 then
        begin
          aFieldName:=TR2.FieldNC(i).Name;
          if not TR2.IsTemp then
          begin
          if IsColumnReferenced(TR2.Name, TR2.Alias, TR2.FieldNC(i).Name, Context) then
              Columns.AddObject(TR2.FieldNC(i).Name, TR2.FieldNC(i));
          end
          else
              Columns.AddObject(aFieldName, TR2.FieldNC(i));
        end
        else begin
          if TR2.Name<>'' then
            S := TR2.Name + '.' + TR2.FieldNC(i).Name
          else
            S := TR2.FieldNC(i).Name;
          if Columns.IndexOf(S) = -1 then
              Columns.AddObject(S, TR2.FieldNC(i))
          else begin
            j := 2;
            while Columns.IndexOf(S + '_' + IntToStr(j)) <> -1 do
              inc(j);
              Columns.AddObject(S+ '_' + IntToStr(j), TR2.FieldNC(i));
          end;
        end;

      if assigned(CondExp) and (CondExp.GetType(Context) <> nxtBoolean) then
        raise EnxInternalSQLException.CreateFmt(rsONConditionMustBeBoolean, [trim(CondExp.ToString)]);

    end;

    if TnxSQLSelect(OwnerSelect).VerboseLogging then
    begin
      TnxSQLSelect(OwnerSelect).LogVerbose('Total columncount: '+inttostr(TL2.FieldList.Count+TL2.FieldList.Count));
      TnxSQLSelect(OwnerSelect).LogVerbose('Referenced columncount: '+inttostr(Columns.Count));
    end;

    Bound := True;
  finally
    Binding := False;
    snEndUse;
  end;
end;

threadvar
  _LockUnbindIfRequired: Integer;

  function TnxSqlJoinTableExp.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  Result := TableRef1.BindTable(Context, AOwner, DatabaseName, TableName);
  if Result = nil then
    Result := TableRef2.BindTable(Context, AOwner, DatabaseName, TableName);
end;

function TnxSqlJoinTableExp.BindColumn(Context: TnxSqlContext; aInAggregate: Boolean;
  const DatabaseName, TableName, ColumnName, SourceLoc: string;
  BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean; MustSucceed: Boolean = True): TnxSqlFieldProxy;
var
  T: TnxSqlTableProxy;
  I: Integer;
  n1, n2: string;
begin
  if Natural and (TableName <> '') then
    if MustSucceed then
      EBadCol(TableName, ColumnName + SourceLoc)
    else begin
      Result := nil;
      exit;
    end;
  if (UsingList <> nil) and (TableName <> '') then begin
    for i := 0 to UsingList.Count - 1 do
      if SameText(UsingList[i].ColumnNameStr, ColumnName) then begin
        if MustSucceed then
          EBadCol(TableName, ColumnName + SourceLoc)
        else begin
          Result := nil;
          exit;
        end;
      end;
  end;
  if TableName <> '' then begin
    if (UsingList<>nil) then
      for I := 0 to Usinglist.Count - 1 do
        if sameText(UsingList[i].ColumnNameStr, ColumnName) then
          raise EnxInternalSQLException.Create(rsMergedColumnCantBeQualifified+TableName+'.'+ColumnName );

    if (BindingStyle = bsCorrelation) and (TableName <> '') then begin
      if SameText(TableRef1.AliasStr, TableName)
      or SameText(TableRef2.AliasStr, TableName) then
        if MustSucceed then
          raise EnxInternalSQLException.Create(rsInvalidReferenceToTableAlias+TableName+'.'+ColumnName )
        else begin
          Result := nil;
          exit;
        end;
    end;
    Inc(_LockUnbindIfRequired);
    try
      T := TableRef1.BindTable(Context, Self, DatabaseName, TableName);
    finally
      Dec(_LockUnbindIfRequired);
    end;
    if T <> nil then
      if T <> TL2 then begin
        Result := TableRef1.TargetFieldFromSourceField(Context, T.FieldByName(ColumnName));
        exit;
      end;

    if T = nil then begin
      Inc(_LockUnbindIfRequired);
      try
        T := TableRef2.BindTable(Context, Self, DatabaseName, TableName);
      finally
        Dec(_LockUnbindIfRequired);
      end;
      if T <> nil then
        if T <> TR2 then begin
          Result := TableRef2.TargetFieldFromSourceField(Context, T.FieldByName(ColumnName));
          exit;
        end;
    end;
    if T = nil then begin
      Result := nil;
      if ContextParent <> nil then begin
        Result := ContextParent.BindColumn(Context, aInAggregate, DatabaseName, TableName, ColumnName, SourceLoc, BindingNode, bsEmbedded, aIsOuterReference, False);
        FIsDependent := Result <> nil;
      end else begin
        if MustSucceed then
          EBadCol(TableName, ColumnName + SourceLoc)
        else begin
          Result := nil;
          exit;
        end;
      end;
      exit;
    end;

    Assert(T <> nil);
    Result := T.FieldByName(ColumnName);

    if Result = nil then
      if ContextParent <> nil then
        Result := ContextParent.BindColumn(Context, aInAggregate, DatabaseName, TableName, ColumnName, SourceLoc, BindingNode, bsEmbedded, aIsOuterReference, False)
      else
        if MustSucceed then
          EBadCol(TableName, ColumnName)
        else begin
          Result := nil;
          exit;
        end;
  end else begin
    Result:=nil;
    if (TL2 <> nil) and (TL2.FieldByName(ColumnName) <> nil) then
      Result := TL2.FieldByName(ColumnName);
    if (TR2 <> nil) and (TR2.FieldByName(ColumnName) <> nil) then begin
      if (UsingList=nil) and (not Natural) and (Result<>nil) then
      begin
         if tl2.IsJoinResult or (tl2.name='') then
           n1:='[JoinResult]'
         else
           n1:=TL2.Name;

         if TR2.IsJoinResult or (tr2.name='') then
           n2:='[JoinResult]'
         else
           n2:=TR2.Name;

        raise EnxInternalSQLException.CreateFmt(rsAmbiguousColumnReference,
          [ColumnName, n1 +'('+ TL2.Alias +') / '+n2+'('+TR2.Alias+')'])
      end
      else
        Result := TR2.FieldByName(ColumnName);
    end;

    if Result<>nil then
      exit;

    if ContextParent <> nil then
      Result := ContextParent.BindColumn(Context, aInAggregate, DatabaseName, TableName, ColumnName, SourceLoc, BindingNode, bsEmbedded, aIsOuterReference, MustSucceed)
    else
      if MustSucceed then
        EBadCol(ColumnName + SourceLoc);
  end;
end;

function TnxSqlJoinTableExp.BindFieldDown(const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; Context: TnxSqlContext; var ColumnAlias: string): TnxSqlFieldProxy;
var
  i: Integer;
  //Result1, Result2:TnxSqlFieldProxy;
begin
  snBeginUse;
  try
    if not Bound then
      Bind(Context);
    Result := nil;
    if Natural and (TableName <> '') then begin
      Result := TableRef1.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
      if Result<>nil then
      begin
        if TableRef2.Table.FieldList.FieldByName(FieldName)<>nil then
          result:=nil
      end
      else
      begin
        Result:=TableRef2.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
        if Result<>nil then
          if TableRef1.Table.FieldList.FieldByName(FieldName)<>nil then
            result:=nil
      end;
    end;
    if (UsingList <> nil) and (TableName <> '') then begin
      for i := 0 to UsingList.Count - 1 do
        if SameText(UsingList[i].ColumnNameStr, FieldName) then begin
          Result := nil;
          exit;
        end;
    end;

    if TableName <> '' then begin

      Inc(_LockUnbindIfRequired);
      try
        if Result = nil then begin
          Result := TableRef1.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
          if Result = nil then
            Result := TableRef2.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
        end;
      finally
        Dec(_LockUnbindIfRequired);
      end;

      if Result = nil then
        exit;

      EnsureResultTable(False, Context, nil);

      for i := 0 to pred(Columns.Count) do
        if (Columns.Objects[i] = Result)
        or (Columns.Objects[i] <> nil)
        and (TObject(Columns.Objects[i]) is TnxSqlFieldProxy)
        and (TnxSqlFieldProxy(Columns.Objects[i]).SlaveField = Result)
         then begin
          Result := FResultTable.FieldC(i);
          exit;
        end;

      if JoinType = jtFullOuter then
        for i := 0 to pred(Columns.Count) do
          if (Columns.Objects[i] <> nil)
          and (TObject(Columns.Objects[i]) is TnxSqlSimpleExpression)
          and ( (TnxSqlSimpleExpression(Columns.Objects[i]).LeftFullSlaveField = Result)
            or (TnxSqlSimpleExpression(Columns.Objects[i]).RightFullSlaveField = Result))
           then begin
            Result := FResultTable.FieldC(i);
            exit;
          end;

      Result := nil;

    end else begin
      if Result=nil then
      begin
      if TL2.FieldByName(FieldName) <> nil then begin
        Result := TL2.FieldByName(FieldName);
        Exit;
      end;
      if TR2.FieldByName(FieldName) <> nil then begin
        Result := TR2.FieldByName(FieldName);
        Exit;
      end;
      end;
      EBadCol(FieldName);
    end;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlJoinTableExp.ClearBindings(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlFieldRef then
    TnxSqlFieldRef(Node).Unbind;
end;

function TnxSqlJoinTableExp.DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
begin
  snBeginUse;
  try
    if not Bound then
      Bind(Context);
    Result :=
      ((UsingCondExp <> nil) and UsingCondExp.DependsOn(Context, Table))
      or ((CondExp <> nil) and CondExp.DependsOn(Context, Table));
  finally
    snEndUse;
  end;
end;

function TnxSqlJoinTableExp.DoJoin(NeedData: Boolean; Context: TnxSqlContext; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
var
  i, selectedfield : Integer;
  T2 : TnxSqlTableProxy;
  F : TnxSqlFieldProxy;
  N : TnxSqlNode;
  FieldDefList: TnxSqlFieldDefList;
  OuterJoinMode: TnxSqlOuterJoinMode;
  C: TnxSqlCondExp;
  CN: string;
  Seq: Integer;
  ColumnName: string;
  aField: TnxSqlFieldProxy;
  IsSelection: Boolean;
  lOwnerSelect : TnxSqlNode;
begin
  if Recycle <> nil then begin
    Recycle.Empty;
    Result := Recycle;
  end else begin
      FieldDefList := TnxSqlFieldDefList.Create;
      try
        Assert(Assigned(Columns));
        for i := 0 to pred(Columns.Count) do begin
          CN := ValidColumnName(Columns[i]);
          if FieldDefList.FieldExists(CN) then begin
            Seq := 2;
            while FieldDefList.FieldExists(CN + IntToStr(Seq)) do
              inc(Seq);
            CN := CN + IntToStr(Seq);
          end;
          if Columns.Objects[i] is TnxSqlFieldProxy then begin
            F := TnxSqlFieldProxy(Columns.Objects[i]);
            FieldDefList.AddField(CN, '', F.GetType, F.GetSize, F.GetDecimals,
              1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, F.GetLocaleDesc, False);
          end else begin
            N := TnxSqlNode(Columns.Objects[i]);
            FieldDefList.AddField(CN, '', N.GetType(Context),
              N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
          end;
        end;

        Assert(Owner is TnxSqlTableExp);
        Result := TnxSqlTableExp(Owner).Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);

        for i := 0 to pred(Columns.Count) do begin
          if Columns.Objects[i] is TnxSQLFieldProxy then
          begin
            if TnxSQLFieldProxy(Columns.Objects[i]).ExactReference then
            begin
              CN := ValidColumnName(Columns[i]);
              aField:=Result.FieldByName(CN);
              if aField<>nil then
                aField.ExactReference:=true;
            end
          end else
          if Columns.Objects[i] is TnxSqlSimpleExpression then
          begin
            if (TnxSqlSimpleExpression(Columns.Objects[i]).LeftFullSlaveField<>nil) and
              TnxSqlSimpleExpression(Columns.Objects[i]).LeftFullSlaveField.ExactReference then
            begin
              CN := ValidColumnName(Columns[i]);
              aField:=Result.FieldByName(CN);
              if aField<>nil then
                aField.ExactReference:=true;
            end
          end
          else
            raise EnxInternalSQLException.Create(rsUnexpectedNodeType);
        end;
      finally
        nxFreeAndNil(FieldDefList);
      end;
    end;

    lOwnerSelect := OwnerSelect;
  try

    if RowBuilder = nil then begin
      if UsingCondExp <> nil then
        C := UsingCondExp
      else
        C := CondExp;

      if assigned(lOwnerSelect) then
        IsSelection := TnxSqlSELECT(lOwnerSelect).IsSelection
      else
        IsSelection := False;

      FRowBuilder := TnxSqlRowBuilder.Create(Context, lOwnerSelect, Self, TnxSqlTableExp(Owner).Database, Owner.ParentBlock, C, Owner.CopyBlobs, IsSelection);
      RowBuilder.Sources.Add(TnxSqlRowRange.Create(TL2));
      RowBuilder.Sources.Add(TnxSqlRowRange.Create(TR2));
    end;

    if (not Natural)
    and (UsingList=nil)
    and (lOwnerSelect <> nil)
    and (lOwnerSelect is TnxSQLSelect) then
      for I := 0 to TnxSQLSelect(lOwnerSelect).SelectionList.Count - 1 do begin
        SelectionFieldRefs.Clear;
        TnxSQLSelect(lOwnerSelect).SelectionList[i].Traverse(IterateSelectionFields, nil, true);
        for selectedfield:=0 to SelectionFieldRefs.Count-1 do
        begin
          ColumnName:=TnxSQLSelect(lOwnerSelect).SelectionList[i].ToString;
          if TnxSQLFieldRef(SelectionFieldRefs[selectedfield]).TableNameStr='' then
          begin
            ColumnName:= TnxSQLFieldRef(SelectionFieldRefs[selectedfield]).FieldNameStr;//trim(TnxSQLSelect(lOwnerSelect).SelectionList[i].ToString);
            begin
              if (TL2.FieldByName(ColumnName)<>nil) and (TR2.FieldByName(ColumnName) <> nil) then
                raise EnxInternalSQLException.CreateFmt(rsAmbiguousColumnReference2,
                  [ColumnName, TnxSQLSelect(lOwnerSelect).SelectionList[i].ToString, tl2.Name, tr2.Name, TnxSQLFieldRef(SelectionFieldRefs[selectedfield]).LocationStr]);
            end;
          end;
        end;
      end;

    RowBuilder.ClearColumnList;

    Assert(Assigned(Columns));
    for i := 0 to pred(Columns.Count) do
      if Columns.Objects[i] is TnxSqlFieldProxy then
        RowBuilder.AddColumnField(
            TnxSqlFieldProxy(Columns.Objects[i]),
            Result.FieldNC(i))
      else
        RowBuilder.AddColumnExpression(
            TnxSqlSimpleExpression(Columns.Objects[i]),
            Result.FieldNC(i));

    if NeedData then begin
      RowBuilder.TargetTable := Result;
      Owner.Database.StartTransaction([nil], False, True);
      try
        Result.BeginBatchPostMode;
        try
          case JoinType of
          jtLeftOuter :
            OuterJoinMode := jmLeft;
          jtRightOuter :
            OuterJoinMode := jmRight;
          jtFullOuter :
            OuterJoinMode := jmFull;
          else
            OuterJoinMode := jmNone;
          end;

          if assigned(RL) then
            RL(Context);
          if assigned(RR) then
            RR(Context);

          RowBuilder.Execute(Context, Owner.UseIndexes, nil, OuterJoinMode, nil, RecordsRead);
          Result.EndBatchPostMode(false);
        except
          Result.EndBatchPostMode(true);
          raise;
        end;
        Owner.Database.Commit;
      except
        Owner.Database.AbortTransaction;
        raise;
      end;
    end;

    {for i := 0 to Result.FieldCount - 1 do
      Result.FieldNC(i).IsTarget := False;}

    if (Parent is TnxSqlIn) or (Parent is TnxSqlCPMatch) then begin
      T2 := Result.CopySortedOnAllFields(Self);
      Result.TransplantCursorFrom(T2);
      {
      Result.Owner := nil;
      nxFreeAndNil(Result);
      Result := T2;
      }
    end;
  except
      Result.Owner := nil;
      nxFreeAndNil(Result);
    raise;
  end;
end;

procedure TnxSqlJoinTableExp.EnsureResultTable(NeedData: Boolean; Context: TnxSqlContext; Select: TnxSqlSELECT);
var
  RecordsRead: Integer;
  SaveTable: TnxSqlTableProxy;
  {aParent: TnxSQLNode;}
begin
  snBeginUse;
  try
    if not Bound then
      Bind(Context);
    SaveTable := nil;

    if (NeedData and not HaveData) then begin
      SaveTable := FResultTable;
      FResultTable := nil;
    end;
    if FResultTable = nil then begin
      try
        FResultTable := DoWork(NeedData, Context, RecordsRead, SaveTable);
      except
        if FResultTable<>nil then
        begin
          FResultTable.Owner:=nil;
          nxFreeAndNil(FResultTable);
        end;
{        if (SaveTable <> nil) and (SaveTable <> FResultTable) then begin
          SaveTable.Owner := nil;
          nxFreeAndNil(SaveTable);
        end;}
        raise;
      end;
      HaveData := NeedData;
      if (SaveTable <> nil) and (SaveTable <> FResultTable) then begin
        SaveTable.Owner := nil;
        nxFreeAndNil(SaveTable);
      end;
      if HaveData then begin
        FLastContext := Context;
        if Assigned(Context) then begin
          FLastContextID := Context.ContextID;
          FLastGeneration := Context.Generation;
          FLastRecordsRead := Context.RecordsRead;
        end else begin
          FLastContextID := -1;
          FLastGeneration := -1;
          FLastRecordsRead := -1;
        end;
      end;
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlJoinTableExp.DoWork(NeedData: Boolean; Context: TnxSqlContext; var RecordsRead: Integer;
      Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    if not Bound then
      Bind(Context);
    Result := DoJoin(NeedData, Context, RecordsRead, Recycle);
  finally
    snEndUse;
  end;
end;

function TnxSqlJoinTableExp.GetResultTable(Context: TnxSqlContext): TnxSqlTableProxy;
begin
  EnsureResultTable(True, Context, nil);
  Result := FResultTable;
end;

procedure TnxSqlJoinTableExp.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlJoinTableExp then begin
    Clear;
    JoinType := TnxSqlJoinTableExp(Source).JoinType;
    Natural := TnxSqlJoinTableExp(Source).Natural;
    if TnxSqlJoinTableExp(Source).TableRef1 <> nil then
      TableRef1 := TnxSqlJoinTableExp(Source).TableRef1.Clone(Self) as TnxSqlTableRef;
    if TnxSqlJoinTableExp(Source).TableRef2 <> nil then
      TableRef2 := TnxSqlJoinTableExp(Source).TableRef2.Clone(Self) as TnxSqlTableRef;
    if TnxSqlJoinTableExp(Source).CondExp <> nil then
      CondExp := TnxSqlJoinTableExp(Source).CondExp.Clone(Self) as TnxSqlCondExp;
    if TnxSqlJoinTableExp(Source).UsingList <> nil then
      UsingList := TnxSqlJoinTableExp(Source).UsingList.Clone(Self) as TnxSqlUsingList;
  end else
    ENotCompatible(Source);
end;

procedure TnxSqlJoinTableExp.Clear;
begin
  snBeginUse;
  try
    ClearColumns;
    nxFreeAndNil(UsingCondExp);
    nxFreeAndNil(FTableRef1);
    nxFreeAndNil(FTableRef2);
    nxFreeAndNil(FCondExp);
    nxFreeAndNil(FUsingList);
  finally
    snEndUse;
  end;
end;

destructor TnxSqlJoinTableExp.Destroy;
begin
  snBeginUse;
  try
    if Assigned(sjteRequestClose) then
      sjteRequestClose.Disconnect;

    ClearColumns;
    nxFreeAndNil(Columns);
    nxFreeAndNil(FRowBuilder);
    if (TL2 <> nil) and (TL2.Owner = Self) then begin
      TL2.Owner := nil;
      nxFreeAndNil(TL2);
    end;
    if (TR2 <> nil) and (TR2.Owner = Self) then begin
      TR2.Owner := nil;
      nxFreeAndNil(TR2);
    end;
    Clear;
    if FResultTable <> nil then
      if FResultTable.Owner = Self then begin
        FResultTable.Owner := nil;
        nxFreeAndNil(FResultTable);
      end;
    nxFreeAndNil(UsingCondExp);
    nxFreeAndNil(SelectionFieldRefs);
  finally
    snEndUse;
  end;
  inherited;
end;

function TnxSqlJoinTableExp.ToString: WideString;
begin
  Result := ' ' + TableRef1.ToString;
  if JoinType = jtCross then
    Result := Result + ' CROSS JOIN '
  else begin
    if Natural then
      Result := Result + ' NATURAL';
    case JoinType of
    jtInner :
      Result := Result + ' INNER';
    jtLeftOuter :
      Result := Result + ' LEFT OUTER';
    jtRightOuter :
      Result := Result + ' RIGHT OUTER';
    jtFullOuter :
      Result := Result + ' FULL OUTER';
    {jtUnion :
      Result := Result + ' UNION';}
    end;
    Result := Result + ' JOIN';
  end;
  Result := Result + TableRef2.ToString;
  if CondExp <> nil then
    Result := Result + ' ON' + CondExp.ToString;
  if UsingList <> nil then
    Result := Result + ' USING (' + UsingList.ToString + ')';
end;

procedure TnxSqlJoinTableExp.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if assigned(TableRef1) then
    TableRef1.Traverse(Callback, UserData, IncludeNested);
  if assigned(TableRef2) then
    TableRef2.Traverse(Callback, UserData, IncludeNested);
  if assigned(CondExp) then
    CondExp.Traverse(Callback, UserData, IncludeNested);
  if assigned(UsingList) then
    UsingList.Traverse(Callback, UserData, IncludeNested);
end;

function TnxSqlJoinTableExp.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlJoinTableExp then
    with TnxSqlJoinTableExp(ANode) do
      Result := (JoinType = Self.JoinType)
        and (Natural = Self.Natural)
        and NodesIdentical(TableRef1, Self.TableRef1)
        and NodesIdentical(TableRef2, Self.TableRef2)
        and NodesIdentical(CondExp, Self.CondExp)
        and TnxSqlNodeList.Identical(UsingList, Self.UsingList)
  else
    Result := False;
end;

procedure TnxSqlJoinTableExp.Execute(Context: TnxSqlContext;
  var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
  var RecordsRead: Integer);
var
  T : TnxSqlTableProxy;
begin
  nxFreeAndNil(aCursor);
  snBeginUse;
  try
    Assert(Owner <> nil);
    aLiveResult := False;
    T := DoWork(True, Context, RecordsRead, nil);
    aCursor := T.Cursor;
    T.LeaveCursorOpen := True;
    if T.Owner = self then begin
      T.Owner := nil;
      nxFreeAndNil(T);
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlJoinTableExp.GetFieldsFromTable(const TableName: string;
  List: TList; Context: TnxSqlContext): TnxSqlTableProxy;
var
  i: Integer;
begin
  Result := nil;
  if SameText(TableRef1.AliasStr, TableName)
  or SameText(TableRef1.TableNameStr, TableName) then begin
    Result := GetResultTable(Context);
    for i := 0 to pred(Columns.Count) do
      if Columns.Objects[i] is TnxSqlFieldProxy then
        if TableRef1.IsResultTable(TnxSqlFieldProxy(Columns.Objects[i]).OwnerTable)
        or ((TnxSqlFieldProxy(Columns.Objects[i]).SlaveField <> nil)
        and TableRef1.IsResultTable(TnxSqlFieldProxy(Columns.Objects[i]).SlaveField.OwnerTable))
        {if (TnxSqlFieldProxy(Columns.Objects[i]).OwnerTable = TableRef1.FTable)
        or ((TnxSqlFieldProxy(Columns.Objects[i]).SlaveField <> nil)
        and (TnxSqlFieldProxy(Columns.Objects[i]).SlaveField.OwnerTable = TableRef1.FTable))}
        then
          List.Add(Columns.Objects[i]);
    exit;
  end;
  if SameText(TableRef2.AliasStr, TableName)
  or SameText(TableRef2.TableNameStr, TableName) then begin
    Result := GetResultTable(Context);
    for i := 0 to pred(Columns.Count) do
      if Columns.Objects[i] is TnxSqlFieldProxy then
        if TableRef2.IsResultTable(TnxSqlFieldProxy(Columns.Objects[i]).OwnerTable)
        or ((TnxSqlFieldProxy(Columns.Objects[i]).SlaveField <> nil)
        and TableRef2.IsResultTable(TnxSqlFieldProxy(Columns.Objects[i]).SlaveField.OwnerTable))
        {if (TnxSqlFieldProxy(Columns.Objects[i]).OwnerTable = TableRef2.FTable)
        or ((TnxSqlFieldProxy(Columns.Objects[i]).SlaveField <> nil)
        and (TnxSqlFieldProxy(Columns.Objects[i]).SlaveField.OwnerTable = TableRef2.FTable))}
        then
          List.Add(Columns.Objects[i]);
    exit;
  end;
  if TableRef1.TableExp <> nil then
    if TableRef1.TableExp.JoinTableExp <> nil then begin
      Result := TableRef1.TableExp.JoinTableExp.GetFieldsFromTable(TableName, List, Context);
      if Result <> nil then
        exit;
    end;
  if TableRef2.TableExp <> nil then
    if TableRef2.TableExp.JoinTableExp <> nil then begin
      Result := TableRef2.TableExp.JoinTableExp.GetFieldsFromTable(TableName, List, Context);
      if Result <> nil then
        exit;
    end;
end;

function TnxSqlJoinTableExp.Simplify(Context: TnxSqlContext): Boolean;
begin
  if assigned(CondExp) then
    Result := CondExp.Simplify(Context)
  else
    Result := False;
  Result := Result or TableRef1.Simplify(Context) or TableRef2.Simplify(Context);
end;

function TnxSqlJoinTableExp.TargetFieldFromSourceField(
  const F: TnxSqlFieldProxy; Context: TnxSqlContext): TnxSqlFieldProxy;
var
  i: Integer;
begin
  for i := 0 to pred(Columns.Count) do
    if Columns.Objects[i] = F then begin
      Result := GetResultTable(Context).FieldNC(i);
      exit;
    end;
  Result := TableRef1.TargetFieldFromSourceField(Context, F);
  if Result <> nil then begin
    for i := 0 to pred(Columns.Count) do
      if Columns.Objects[i] = Result then begin
        Result := GetResultTable(Context).FieldNC(i);
        exit;
      end;
  end;
  Result := TableRef2.TargetFieldFromSourceField(Context, F);
  if Result <> nil then begin
    for i := 0 to pred(Columns.Count) do
      if Columns.Objects[i] = Result then begin
        Result := GetResultTable(Context).FieldNC(i);
        exit;
      end;
  end;
  Result := nil;
end;

function TnxSqlJoinTableExp.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlJoinTableExp.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlJoinTableExp.Unbind;
begin
  snBeginUse;
  try
    ClearColumns;
    if assigned(CondExp) then
      CondExp.Unbind;

    if Assigned(TL2) and Assigned(TL2Monitor) and not TL2Monitor.IsAlive then
      TL2 := nil;

    if TL2<>nil then
      if TL2.Owner=self then
        TL2.Owner:=TableRef1;

    TableRef1.Unbind;
    TL2 := nil;
    TL2Monitor := nil;

    if Assigned(TR2) and Assigned(TR2Monitor) and not TR2Monitor.IsAlive then
      TR2 := nil;

    if TR2<>nil then
      if TR2.Owner=self then
        TR2.Owner:=TableRef2;

    TableRef2.Unbind;
    TR2 := nil;
    TR2Monitor := nil;

    RL := nil;
    RR := nil;
    nxFreeAndNil(FRowBuilder);
    if FResultTable<>nil then
      if FResultTable.Owner=self then
        nxFreeAndnil(FResultTable);

    Bound := False;
  finally
    snEndUse
  end;
end;

function TnxSqlJoinTableExp.IsAmbiguousColumn(
  const ColumnName: string): Boolean;
begin
  Result := not Natural and TableRef1.HasColumn(ColumnName) and TableRef2.HasColumn(ColumnName);
end;

procedure TnxSqlJoinTableExp.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  JoinType := TnxSqlJoinType(Stream.ReadInt);
  Natural := Stream.ReadBool;
  TableRef1 := Stream.ReadNode(Self) as TnxSqlTableRef;
  TableRef2 := Stream.ReadNode(Self) as TnxSqlTableRef;
  if Stream.ReadBool then
    CondExp := Stream.ReadNode(Self) as TnxSqlCondExp;
  if Stream.ReadBool then
    UsingList := Stream.ReadNode(Self) as TnxSqlUsingList;
end;

procedure TnxSqlJoinTableExp.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteInt(ord(JoinType));
  Stream.WriteBool(Natural);
  Stream.WriteNode(TableRef1);
  Stream.WriteNode(TableRef2);
  if CondExp <> nil then begin
    Stream.WriteBool(True);
    Stream.WriteNode(CondExp);
  end else
    Stream.WriteBool(False);
  if UsingList <> nil then begin
    Stream.WriteBool(True);
    Stream.WriteNode(UsingList);
  end else
    Stream.WriteBool(False);
end;

function TnxSqlJoinTableExp.RefersTo(const aTableName: string): Boolean;
begin
  Result := TableRef1.RefersTo(aTableName) or TableRef2.RefersTo(aTableName)
    or assigned(CondExp) and CondExp.RefersTo(aTableName);
end;

function TnxSqlJoinTableExp.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := TableRef1.RefersTo(aTableName, aColumnName)
    or TableRef2.RefersTo(aTableName, aColumnName)
    or assigned(CondExp) and CondExp.RefersTo(aTableName, aColumnName);
  if not Result then
    if UsingList<>nil then
      result:=UsingList.RefersTo(aTableName, aColumnName);
end;

function TnxSqlJoinTableExp.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
begin
  Result := TableRef1.RefersToContextVars(Context)
    or TableRef2.RefersToContextVars(Context)
    or assigned(CondExp) and CondExp.RefersToContextVars(Context);
end;

function TnxSqlJoinTableExp.RefersToTemp: Boolean;
begin
  Result := TableRef1.RefersToTemp or TableRef2.RefersToTemp;
end;

procedure TnxSqlJoinTableExp.SetTableRef1(const Value: TnxSqlTableRef);
begin
  nxFreeAndNil(FTableRef1);
  FTableRef1 := Value;
end;

procedure TnxSqlJoinTableExp.SetTableRef2(const Value: TnxSqlTableRef);
begin
  nxFreeAndNil(FTableRef2);
  FTableRef2 := Value;
end;

function TnxSqlJoinTableExp.IsResultTable(T: TnxSqlTableProxy): Boolean;
begin
  Result := TableRef1.IsResultTable(T) or TableRef2.IsResultTable(T);
end;

procedure TnxSqlJoinTableExp.IterateSelectionFields(Node: TnxSqlNode;
  UserData: TObject);
begin
  if Node is TnxSQLFieldRef then
  begin
    SelectionFieldRefs.Add(TnxSQLFieldRef(Node));
  end;
end;

function TnxSqlJoinTableExp.IsPSM: Boolean;
var
  P: TnxSqlNode;
begin
  P := Parent;
  while P <> nil do begin
    if (P is TnxSqlCREATEPROC)
    or (P is TnxSqlCREATEFUNC)
    or (P is TnxSqlCREATETRIGGER)
    or (P is TnxSqlWHILE)
    or (P is TnxSqlREPEAT)
     then begin
      Result := True;
      exit;
    end;
    P := P.Parent;
  end;
  Result := False;
end;

function TnxSqlJoinTableExp.GetRefresh: TnxSqlTableRefresher;
begin
  Result := nil;
  if FIsDependent or IsPSM then
    Result := DoRefresh;
end;

procedure TnxSqlJoinTableExp.DoRefresh(aContext: TnxSqlContext);
begin
  if not HaveData or
     (FLastContext <> aContext) or
     not Assigned(FLastContext) or
     not Assigned(aContext) or
     (FLastContextID <> aContext.ContextID) or
     (FLastGeneration <> aContext.Generation) or
     (FLastRecordsRead <> aContext.RecordsRead) then begin

    HaveData := False;
    EnsureResultTable(True, aContext, nil);
    HaveData := True;
    FLastContext := aContext;
    if Assigned(aContext) then begin
      FLastContextID := aContext.ContextID;
      FLastGeneration := aContext.Generation;
      FLastRecordsRead := aContext.RecordsRead;
    end else begin
      FLastContextID := -1;
      FLastGeneration := -1;
      FLastRecordsRead := -1;
    end;
  end;
end;

procedure TnxSqlJoinTableExp.MetaTableChecker(Node: TnxSQLNode; UserData: TObject);
begin
  if Node is TnxSqlTableRef then
    if TnxSQLTableRef(Node).Table is TnxSqlDicTable then
      fHasMetaTable:=true;

end;

function TnxSqlJoinTableExp.HasMetaTableBase: Boolean;
//var
//  HasMetaTable: integer;
begin
//  result:=false;
  if fHaveCheckedMetaTables then
    result:=fHasMetatable
  else
  begin
    fHasMetatable:=false;
    if Owner is TnxSqlNode then
      TnxSqlNode(Owner).Traverse(MetaTableChecker, nil, true);
    result:=fHasMetatable;
    fHaveCheckedMetaTables:=true;
  end;
end;

{ TnxSqlNonJoinTableExp }

procedure TnxSqlNonJoinTableExp.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlNonJoinTableExp then begin
    Clear;
    if TnxSqlNonJoinTableExp(Source).NonJoinTableTerm <> nil then
      NonJoinTableTerm := TnxSqlNonJoinTableExp(Source).NonJoinTableTerm.Clone(Self) as TnxSqlNonJoinTableTerm;
  end else
    ENotCompatible(Source);
end;

function TnxSqlNonJoinTableExp.BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
begin
  Result := NonJoinTableTerm.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
end;

function TnxSqlNonJoinTableExp.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  Result := NonJoinTableTerm.BindTable(Context, AOwner, DatabaseName, TableName);
end;

procedure TnxSqlNonJoinTableExp.Clear;
begin
  snBeginUse;
  try
    nxFreeAndNil(FNonJoinTableTerm);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableExp.DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
begin
  Assert(NonJoinTableTerm <> nil);
  Result := NonJoinTableTerm.DependsOn(Table, Context);
end;

destructor TnxSqlNonJoinTableExp.Destroy;
begin
  Clear;
  inherited;
end;

function TnxSqlNonJoinTableExp.ToString: WideString;
begin
  if assigned(NonJoinTableTerm) then
    Result := NonJoinTableTerm.ToString;
end;

procedure TnxSqlNonJoinTableExp.EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean);
begin
  snBeginUse;
  try
    Assert(Assigned(NonJoinTableTerm));
    NonJoinTableTerm.EnsureResultTable(Context, NeedData{, aOrderList});
  finally
    snEndUse;
  end;
end;

procedure TnxSqlNonJoinTableExp.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if assigned(NonJoinTableTerm) then
    NonJoinTableTerm.Traverse(Callback, UserData, IncludeNested);
end;

function TnxSqlNonJoinTableExp.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result :=
    ANode is TnxSqlNonJoinTableExp
    and NodesIdentical(NonJoinTableTerm,
      TnxSqlNonJoinTableExp(ANode).NonJoinTableTerm);
end;

function TnxSqlNonJoinTableExp.EvaluateWhere(
  Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  Assert(NonJoinTableTerm <> nil);
  Result := NonJoinTableTerm.EvaluateWhere(Context);
end;

function TnxSqlNonJoinTableExp.EvaluateFirst(
  Context: TnxSqlContext): variant;
begin
  Assert(NonJoinTableTerm <> nil);
  Result := NonJoinTableTerm.EvaluateFirst(Context);
end;

function TnxSqlNonJoinTableExp.WhereIsValidFilterStatement: Boolean;
begin
  Result := (NonJoinTableTerm <> nil) and NonJoinTableTerm.WhereIsvalidFilterStatement;
end;

procedure TnxSqlNonJoinTableExp.BindWhere;
begin
  NonJoinTableTerm.BindWhere(aContext);
end;

procedure TnxSqlNonJoinTableExp.Execute(aContext: TnxSqlContext;
  var aLiveResult: Boolean;
  var aCursor: TnxAbstractCursor; var RecordsRead: Integer);
begin
  snBeginUse;
  try
    Assert(NonJoinTableTerm <> nil);
    NonJoinTableTerm.Execute(aContext, aLiveResult, aCursor, RecordsRead);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableExp.GetFieldsFromTable(const TableName: string; List: TList): TnxSqlTableProxy;
begin
  Result := nil;
end;

function TnxSqlNonJoinTableExp.GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Assert(NonJoinTableTerm <> nil);
    Result := NonJoinTableTerm.GetResultTable(Context, aNeedData);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableExp.GetTheResultTable: TnxSQLTableProxy;
begin
  result:=NonJoinTableTerm.FResultTable;
end;

function TnxSqlNonJoinTableExp.GetRefresh: TnxSqlTableRefresher;
begin
  Result := NonJoinTableTerm.Refresh;
end;

function TnxSqlNonJoinTableExp.Simplify(Context: TnxSqlContext): Boolean;
begin
  Assert(NonJoinTableTerm <> nil);
  Result := NonJoinTableTerm.Simplify(Context);
end;

constructor TnxSqlJoinTableExp.Create(AParent: TnxSqlNode);
begin
  inherited;
  SelectionFieldRefs:=TList.Create;
  Columns := TnxSQLJoinColumns.Create;
  fHaveCheckedMetaTables:=false;
end;

function TnxSqlNonJoinTableExp.TargetFieldFromSourceField(Context: TnxSqlContext;
  const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
begin
  Result := NonJoinTableTerm.TargetFieldFromSourceField(Context, F);
end;

function TnxSqlNonJoinTableExp.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlNonJoinTableExp.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlNonJoinTableExp.Unbind;
begin
  NonJoinTableTerm.Unbind;
end;

procedure TnxSqlNonJoinTableExp.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  NonJoinTableTerm := Stream.ReadNode(Self) as TnxSqlNonJoinTableTerm;
end;

procedure TnxSqlNonJoinTableExp.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteNode(NonJoinTableTerm);
end;

function TnxSqlNonJoinTableExp.RefersTo(const aTableName: string): Boolean;
begin
  Result := NonJoinTableTerm.RefersTo(aTableName);
end;

function TnxSqlNonJoinTableExp.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := NonJoinTableTerm.RefersTo(aTableName, aColumnName);
end;

function TnxSqlNonJoinTableExp.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
begin
  Result := NonJoinTableTerm.RefersToContextVars(Context);
end;

function TnxSqlNonJoinTableExp.RefersToTemp: Boolean;
begin
  Result := NonJoinTableTerm.RefersToTemp;
end;

function TnxSqlNonJoinTableExp.IsResultTable(T: TnxSqlTableProxy): Boolean;
begin
  Result := NonJoinTableTerm.IsResultTable(T);
end;

function TnxSqlNonJoinTableExp.IsOrdered: Boolean;
begin
  Result := NonJoinTableTerm.IsOrdered;
end;

function TnxSqlNonJoinTableExp.IsSelectInto: Boolean;
begin
  Result := NonJoinTableTerm.IsSelectInto;
end;

{ TnxSqlNonJoinTablePrimary }

procedure TnxSqlNonJoinTablePrimary.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlNonJoinTablePrimary then begin
    Clear;
    if TnxSqlNonJoinTablePrimary(Source).ExecStatement <> nil then
      ExecStatement := TnxSqlNonJoinTablePrimary(Source).ExecStatement.Clone(Self) as TnxSqlRootNode;
    if TnxSqlNonJoinTablePrimary(Source).SelectSt <> nil then
      SelectSt := TnxSqlNonJoinTablePrimary(Source).SelectSt.Clone(Self) as TnxSqlSELECT;
    if TnxSqlNonJoinTablePrimary(Source).NonJoinTableExp <> nil then
      NonJoinTableExp := TnxSqlNonJoinTablePrimary(Source).NonJoinTableExp.Clone(Self) as TnxSqlNonJoinTableExp;
    All := TnxSqlNonJoinTablePrimary(Source).All;
  end else
    ENotCompatible(Source);
end;

function TnxSqlNonJoinTablePrimary.BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
var
  b: Boolean;
begin
  if SelectSt <> nil then
    Result := SelectSt.BindColumn(Context, False, DatabaseName, TableName, FieldName, FieldNameLoc, nil, bsNormal, b)
  else
  if NonJoinTableExp <> nil then
    Result := NonJoinTableExp.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias)
  else
    Result := nil;
end;

function TnxSqlNonJoinTablePrimary.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  if SelectSt <> nil then
    Result := SelectSt.BindTable(Context, AOwner, DatabaseName, TableName)
  else
  if NonJoinTableExp <> nil then
    Result := NonJoinTableExp.BindTable(Context, AOwner, DatabaseName, TableName)
  else
    Result := nil;
end;

procedure TnxSqlNonJoinTablePrimary.Clear;
begin
  snBeginUse;
  try
    nxFreeAndNil(FSelectSt);
    nxFreeAndNil(FNonJoinTableExp);
    nxFreeAndNil(FExecStatement);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTablePrimary.DependsOn(
  Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
begin
  if SelectSt <> nil then
    Result := SelectSt.DependsOn(Table, Context)
  else
  if NonJoinTableExp <> nil then
    Result := NonJoinTableExp.DependsOn(Table, Context)
  else
    Result := False;
end;

destructor TnxSqlNonJoinTablePrimary.Destroy;
begin
  Clear;
  inherited;
end;

function TnxSqlNonJoinTablePrimary.ToString: WideString;
begin
  if ExecStatement <> nil then
    Result := ExecStatement.ToString
  else
  if SelectSt <> nil then
    Result := SelectSt.ToString
  else
  if NonJoinTableExp <> nil then
    Result := ' (' + NonJoinTableExp.ToString + ')'
end;

procedure TnxSqlNonJoinTablePrimary.EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean);
begin
  snBeginUse;
  try
    if SelectSt <> nil then
      SelectSt.EnsureResultTable(Context, NeedData, False);
    if NonJoinTableExp <> nil then
      NonJoinTableExp.EnsureResultTable(Context, NeedData);
  finally
    snEndUse;
  end;
end;

procedure TnxSqlNonJoinTablePrimary.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if SelectSt <> nil then
    SelectSt.Traverse(Callback, UserData, IncludeNested);
  if NonJoinTableExp <> nil then
    NonJoinTableExp.Traverse(Callback, UserData, IncludeNested);
  if ExecStatement <> nil then
    ExecStatement.Traverse(Callback, UserData, IncludeNested);
end;

function TnxSqlNonJoinTablePrimary.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlNonJoinTablePrimary then
    with TnxSqlNonJoinTablePrimary(ANode) do
      Result := NodesIdentical(SelectSt, Self.SelectSt)
        and NodesIdentical(NonJoinTableExp, Self.NonJoinTableExp)
        and NodesIdentical(ExecStatement, Self.ExecStatement)
        and (All = Self.All)
  else
    Result := False;
end;

function TnxSqlNonJoinTablePrimary.EvaluateWhere(
  Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  if assigned(SelectSt) then
    Result := SelectSt.EvaluateWhere(Context)
  else
    raise EnxInternalSQLException.Create(rsOnlySELECTIsAllowedInSQLFilter);
end;

function TnxSqlNonJoinTablePrimary.EvaluateFirst(
  Context: TnxSqlContext): variant; 
begin
  if assigned(SelectSt) then
    Result := SelectSt.EvaluateFirst(Context)
  else
    raise EnxInternalSQLException.Create(rsOnlySELECTIsAllowedInSQLFilter);
end;

function TnxSqlNonJoinTablePrimary.WhereIsValidFilterStatement: Boolean;
begin
  Result := assigned(SelectSt) and SelectSt.WhereIsValidFilterStatement;
end;

procedure TnxSqlNonJoinTablePrimary.BindWhere;
begin
  SelectSt.BindWhere(aContext);
end;

procedure TnxSqlNonJoinTablePrimary.Execute(
  Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
  var RecordsRead: Integer);
var
  RowsAffected: Integer;
begin
  snBeginUse;
  try
    if assigned(ExecStatement) then
      ExecStatement.Execute(Context, aLiveResult, aCursor, RecordsRead, RowsAffected)
    else
    if assigned(SelectSt) then
      SelectSt.Execute(Context, aLiveResult, aCursor, RecordsRead, RowsAffected)
    else
    if assigned(NonJoinTableExp) then
      NonJoinTableExp.Execute(Context, aLiveResult, aCursor, RecordsRead)
    else
      Assert(False);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTablePrimary.GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Result := nil;
    if assigned(ExecStatement) then
      Result := (ExecStatement as TnxSqlExecStatement).GetResultTable(Context)
    else
    if assigned(SelectSt) then
    begin
  //    if SelectSt.OrderList<>nil then
    //    raise EnxInternalSQLException.Create('ORDER BY in union not supported');
      Result := SelectSt.GetResultTable(Context, aNeedData)
    end
    else
    if assigned(NonJoinTableExp) then
      Result := NonJoinTableExp.GetResultTable(Context, aNeedData)
    else
      Assert(False);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTablePrimary.Simplify(Context: TnxSqlContext): Boolean;
begin
  if assigned(SelectSt) then
    Result := SelectSt.Simplify(Context)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.Simplify(Context)
  else
    Result := False;
end;

function TnxSqlNonJoinTablePrimary.TargetFieldFromSourceField(
  Context: TnxSqlContext; const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
begin
  Result := nil;
  if assigned(SelectSt) then
    Result := SelectSt.TargetFieldFromSourceField(Context, F)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.TargetFieldFromSourceField(Context, F)
  else
    Assert(False);
end;

function TnxSqlNonJoinTablePrimary.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlNonJoinTablePrimary.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlNonJoinTablePrimary.Unbind;
begin
  if assigned(SelectSt) then
    SelectSt.Unbind;
  if assigned(NonJoinTableExp) then
    NonJoinTableExp.Unbind;
end;

procedure TnxSqlNonJoinTablePrimary.LoadFromStream(
  Stream: TnxSqlPSMReader);
begin
  NonJoinTableExp := TnxSqlNonJoinTableExp(Stream.ReadNodeOpt(Self));
  SelectSt := TnxsqlSELECT(Stream.ReadNodeOpt(Self));
  ExecStatement := TnxSqlRootNode(Stream.ReadNodeOpt(Self));
  All := Stream.ReadBool;
end;

procedure TnxSqlNonJoinTablePrimary.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteNodeOpt(NonJoinTableExp);
  Stream.WriteNodeOpt(SelectSt);
  Stream.WriteNodeOpt(ExecStatement);
  Stream.WriteBool(All);
end;

function TnxSqlNonJoinTablePrimary.RefersTo(
  const aTableName: string): Boolean;
begin
  Result :=
    assigned(ExecStatement) and ExecStatement.RefersTo(aTableName)
    or assigned(SelectSt) and SelectSt.RefersTo(aTableName)
    or assigned(NonJoinTableExp) and NonJoinTableExp.RefersTo(aTableName);
end;

function TnxSqlNonJoinTablePrimary.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result :=
    assigned(ExecStatement) and ExecStatement.RefersTo2(aTableName, aColumnName)
    or assigned(SelectSt) and SelectSt.RefersTo2(aTableName, aColumnName)
    or assigned(NonJoinTableExp) and NonJoinTableExp.RefersTo(aTableName, aColumnName);
end;

function TnxSqlNonJoinTablePrimary.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
begin
  Result :=
    assigned(ExecStatement) and ExecStatement.RefersToContextVars(Context)
    or assigned(SelectSt) and SelectSt.RefersToContextVars(Context)
    or assigned(NonJoinTableExp) and NonJoinTableExp.RefersToContextVars(Context);
end;

function TnxSqlNonJoinTablePrimary.RefersToTemp: Boolean;
begin
  Result :=
    assigned(ExecStatement)
    or assigned(SelectSt) and SelectSt.RefersToTemp
    or assigned(NonJoinTableExp) and NonJoinTableExp.RefersToTemp;
end;

function TnxSqlNonJoinTablePrimary.IsResultTable(
  T: TnxSqlTableProxy): Boolean;
begin
  Result :=
    assigned(SelectSt) and SelectSt.IsResultTable(T)
    or assigned(NonJoinTableExp) and NonJoinTableExp.IsResultTable(T);
end;

function TnxSqlNonJoinTablePrimary.GetRefreh: TnxSqlTableRefresher;
begin
  Result := nil;
  if assigned(SelectSt) then
    Result := SelectSt.Refresh;
end;

function TnxSqlNonJoinTablePrimary.IsOrdered: Boolean;
begin
  Result :=
    assigned(SelectSt) and (SelectSt.OrderList <> nil)
    or assigned(NonJoinTableExp) and NonJoinTableExp.IsOrdered;
end;

function TnxSqlNonJoinTablePrimary.IsSelectInto: Boolean;
begin
  Result := assigned(SelectSt) and (SelectSt.TargetTablestr <> '') 
end;

{ TnxSqlNonJoinTableTerm }

procedure TnxSqlNonJoinTableTerm.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlNonJoinTableTerm then begin
    Clear;
    if TnxSqlNonJoinTableTerm(Source).NonJoinTablePrimary <> nil then
      NonJoinTablePrimary := TnxSqlNonJoinTableTerm(Source).NonJoinTablePrimary.Clone(Self) as TnxSqlNonJoinTablePrimary;
    //Union
    All := TnxSqlNonJoinTableTerm(Source).All;
    SetOp := TnxSqlNonJoinTableTerm(Source).SetOp;
    for i := 0 to TnxSqlNonJoinTableTerm(Source).SetPrimariesCount - 1 do
      AddSetPrimary(TnxSqlNonJoinTableTerm(Source).SetPrimary[i].Clone(Self) as TnxSqlNonJoinTablePrimary);
  end else
    ENotCompatible(Source);
end;

function TnxSqlNonJoinTableTerm.BindFieldDown(Context: TnxSqlContext;const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
begin
  Result := NonJoinTablePrimary.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
end;

function TnxSqlNonJoinTableTerm.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  Result := NonJoinTablePrimary.BindTable(Context, AOwner, DatabaseName, TableName);
end;

procedure TnxSqlNonJoinTableTerm.Clear;
var
  i: Integer;
begin
  snBeginUse;
  try
    nxFreeAndNil(FNonJoinTablePrimary);
    for i := 0 to setprimariesCount - 1 do
      SetPrimary[i].Free;
    nxFreeAndNil(FSetPrimaries);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableTerm.DependsOn(
  Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
begin
  Assert(NonJoinTablePrimary <> nil);
  Result := NonJoinTablePrimary.DependsOn(Table, Context);
end;

destructor TnxSqlNonJoinTableTerm.Destroy;
begin
  if FResultTable <> nil then begin
    if FResultTable.Owner = Self then begin
      FResultTable.Owner := nil;
      nxFreeAndNil(FResultTable);
    end;
  end;
  Clear;
  inherited;
end;

function TnxSqlNonJoinTableTerm.ToString: WideString;
begin
  if assigned(NonJoinTablePrimary) then
    Result := NonJoinTablePrimary.ToString;
end;

procedure TnxSqlNonJoinTableTerm.EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean);
begin
  snBeginUse;
  try
    assert(assigned(NonJoinTablePrimary));
    NonJoinTablePrimary.EnsureResultTable(Context, NeedData);
  finally
    snEndUse;
  end;
end;

procedure TnxSqlNonJoinTableTerm.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
var
  i: Integer;
begin
  Callback(Self, UserData);
  if assigned(NonJoinTablePrimary) then
    NonJoinTablePrimary.Traverse(Callback, UserData, IncludeNested);
  for i := 0 to setprimariesCount - 1 do
    SetPrimary[i].Traverse(Callback, UserData, IncludeNested);
end;

function TnxSqlNonJoinTableTerm.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result :=
    ANode is TnxSqlNonJoinTableTerm
    and NodesIdentical(NonJoinTablePrimary, TnxSqlNonJoinTableTerm(ANode).NonJoinTablePrimary)
    and (All = TnxSqlNonJoinTableTerm(ANode).All)
    and (SetOp = TnxSqlNonJoinTableTerm(ANode).SetOp);
end;

function TnxSqlNonJoinTableTerm.EvaluateWhere(
  Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  Assert(NonJoinTablePrimary <> nil);
  Result := NonJoinTablePrimary.EvaluateWhere(Context);
end;

function TnxSqlNonJoinTableTerm.EvaluateFirst(
  Context: TnxSqlContext): variant;
begin
  Assert(NonJoinTablePrimary <> nil);
  Result := NonJoinTablePrimary.EvaluateFirst(Context);
end;

function TnxSqlNonJoinTableTerm.WhereIsValidFilterStatement: Boolean;
begin
  Result := (NonJoinTablePrimary <> nil) and NonJoinTablePrimary.WhereIsValidFilterStatement;
end;

procedure TnxSqlNonJoinTableTerm.BindWhere;
begin
  NonJoinTablePrimary.BindWhere(aContext);
end;

function TnxSqlNonJoinTableTerm.DoIntersect(Context: TnxSqlContext):TnxSqlTableProxy;
var
  T: TnxSqlTableProxy;
  FC: TnxSqlRecordCopier;
  i, j, k, l: Integer;
  FieldDefList, FieldDefListU : TnxSqlFieldDefList;
  TUs: array of TnxSqlTableProxy;
  Same, SameFound: Boolean;
  V1, V2: variant;
  A1, A2: array of int64;
  Tmp: TnxSqlTableProxy;
begin
  T := NonJoinTablePrimary.GetResultTable(Context, True);

  SetLength(TUs, SetPrimariesCount);
  try
    for i := 0 to SetPrimariesCount - 1 do
      TUs[i] := SetPrimary[i].GetResultTable(Context, True);

    FieldDefList := T.ExtractFieldDef;
    FieldDefListU := nil;
    try
      for j := 0 to SetPrimariesCount - 1 do begin
        nxFreeAndNil(FieldDefListU);
        FieldDefListU := TUs[j].ExtractFieldDef;
        FieldDefList.CoerceTypes(FieldDefListU);
      end;
      Result := Owner.Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      nxFreeAndNil(FieldDefList);
      nxFreeAndNil(FieldDefListU);
    end;

    try
      FC := nil;
      try
        FC := TnxSqlRecordCopier.Create(True, IsView);
        for i := 0 to Result.FieldCount - 1 do
          FC.Add(T.FieldC(i), Result.FieldNC(i));
        Owner.Database.StartTransaction([nil], False, True);
        try
          Result.BeginBatchPostMode;
          try
            if T.First then
              repeat
                Result.Insert;
                FC.Execute;
                Result.Post;
              until not T.Next;
              Result.EndBatchPostMode(false);
            except
              Result.EndBatchPostMode(true);
              raise;
            end;
            Owner.Database.Commit;
          except
            Owner.Database.AbortTransaction;
            raise;
          end;
        finally
          nxFreeAndNil(FC);
        end;
    finally
      if T.Owner = Self then begin
        T.Owner := nil;
        nxFreeAndNil(T);
      end;
    end;

    for i := 0 to SetPrimariesCount - 1 do begin
      if not SetPrimary[i].All then begin
        Tmp := Result.CopyUnique(Context, Result.Owner, True, True, False, IsView);
        {Result.Owner := nil;
        nxFreeAndNil(Result);
        Result := Tmp;}
        Result.TransplantCursorFrom(Tmp);
        Tmp := TUs[i].CopyUnique(Context, Self{TUs[i].Owner}, True, True, False, IsView);
        TUs[i].TransplantCursorFrom(Tmp);
        {if TUs[i].Owner = Self then begin
          TUs[i].Owner := nil;
          TUs[i].Free;
        end;
        TUs[i] := Tmp;}
      end;
      SetLength(A1, Result.GetRecordCount);
      SetLength(A2, TUs[i].GetRecordCount);
      j := 0;
      if Result.First then
        repeat
          A1[j] := Result.GetCurrentRecordID;
          inc(j);
        until not Result.Next;
      j := 0;
      if TUs[i].First then
        repeat
          A2[j] := TUs[i].GetCurrentRecordID;
          inc(j);
        until not TUs[i].Next;
      j := 0;
      while j < length(A1) do begin
        if A1[j] <> 0 then begin
          Result.GetRecordByID(A1[j], nxltWriteLock);
          SameFound := False;
          k := 0;
          while k < length(A2) do begin
            if A2[k] <> 0 then begin
              TUs[i].GetRecordByID(A2[k], nxltWriteLock);

              Same := True;
              for l := 0 to Result.FieldCount - 1 do begin
                V1 := Unassigned;
                V1 := TUs[i].FieldC(l).GetValue;
                V2 := Unassigned;
                V2 := Result.FieldC(l).GetValue;
                if VarIsNull(V1) then
                  if not VarIsNull(V2) then begin
                    Same := False;
                    Break;
                  end else
                else
                  if VarIsNull(V2) then begin
                    Same := False;
                    Break;
                  end else
                    if V1 <> V2 then begin
                      Same := False;
                      Break;
                    end;
              end;

              if Same then begin
                A2[k] := 0;
                SameFound := True;
                Break;
              end;
            end;
            inc(k);
          end;
          if not SameFound then
            Result.Delete;
        end;
        inc(j);
      end;

    end;

  finally
    for i := 0 to SetPrimariesCount - 1 do
      if (TUs[i]<>nil) and (TUs[i].Owner = Self) then begin
        TUs[i].Owner := nil;
        nxFreeAndNil(TUs[i]);
      end;
  end;
end;

procedure TnxSqlNonJoinTableTerm.Execute(
  Context: TnxSqlContext;
  var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
  var RecordsRead: Integer);
var
  ResultT: TnxSqlTableProxy;
begin
  nxFreeAndNil(aCursor);
  snBeginUse;
  try
    Assert(NonJoinTablePrimary <> nil);
    if SetPrimariesCount > 0 then begin
      ResultT := nil;
      try
        ResultT := DoIntersect(Context);
        aCursor := ResultT.Cursor;
        aLiveResult := False;
        ResultT.LeaveCursorOpen := True;
      finally
        if ResultT <> nil then begin
          ResultT.Owner := nil;
          nxFreeAndNil(ResultT);
        end;
      end;
    end else
      NonJoinTablePrimary.Execute(Context, aLiveResult, aCursor, RecordsRead);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableTerm.GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Assert(NonJoinTablePrimary <> nil);
    if SetPrimariesCount > 0 then begin
      Result := DoIntersect(Context);
      if FResultTable <> nil then begin
        if FResultTable.Owner = Self then begin
          FResultTable.Owner := nil;
          nxFreeAndNil(FResultTable);
        end;
        FResultTable := Result;
      end;
    FResultTable := Result;
    end else
      Result := NonJoinTablePrimary.GetResultTable(Context, aNeedData);
  finally
    snEndUse;
  end;
end;

function TnxSqlNonJoinTableTerm.GetRefresh: TnxSqlTableRefresher;
begin
  Result := nil;
  if SetPrimariesCount = 0 then
    Result := NonJoinTablePrimary.Refresh;
end;

function TnxSqlNonJoinTableTerm.Simplify(Context: TnxSqlContext): Boolean;
begin
  Assert(NonJoinTablePrimary <> nil);
  Result := NonJoinTablePrimary.Simplify(Context);
end;

function TnxSqlNonJoinTableTerm.TargetFieldFromSourceField(Context: TnxSqlContext;
  const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
begin
  Result := NonJoinTablePrimary.TargetFieldFromSourceField(Context, F);
end;

function TnxSqlNonJoinTableTerm.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlNonJoinTableTerm.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlNonJoinTableTerm.Unbind;
var
  i: Integer;
begin
  NonJoinTablePrimary.Unbind;
  if (FResultTable<>nil) then
    if (FResultTable.Owner=self) then
      nxFreeAndnil(FResultTable);

  for i := 0 to setprimariesCount - 1 do
    SetPrimary[i].Unbind;
end;

procedure TnxSqlNonJoinTableTerm.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i: Integer;
begin
  NonJoinTablePrimary := Stream.ReadNode(Self) as TnxSqlNonJoinTablePrimary;
  All := Stream.ReadBool;
  SetOp := TnxSqlSetOp(Stream.ReadInt);
  for i := 0 to Stream.ReadInt - 1 do
    AddSetPrimary(Stream.ReadNode(Self) as TnxSqlNonJoinTablePrimary);
end;

procedure TnxSqlNonJoinTableTerm.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteNode(NonJoinTablePrimary);
  Stream.WriteBool(All);
  Stream.WriteInt(ord(SetOp));
  Stream.WriteInt(SetPrimariesCount);
  for i := 0 to SetPrimariesCount - 1 do
    Stream.WriteNode(SetPrimary[i]);
end;

procedure TnxSqlNonJoinTableTerm.AddSetPrimary(
  aSetPrimary: TnxSqlNonJoinTablePrimary; aAll: Boolean);
begin
  AddSetPrimary(aSetPrimary);
  aSetPrimary.All := aAll;
end;

procedure TnxSqlNonJoinTableTerm.AddSetPrimary(
  aSetPrimary: TnxSqlNonJoinTablePrimary);
begin
  if FSetPrimaries = nil then
    FSetPrimaries := TList.Create;
  FSetPrimaries.Add(aSetPrimary);
end;

function TnxSqlNonJoinTableTerm.GetSetPrimariesCount: Integer;
begin
  if FSetPrimaries <> nil then
    Result := FSetPrimaries.Count
  else
    Result := 0;
end;

function TnxSqlNonJoinTableTerm.GetSetPrimary(
  Index: Integer): TnxSqlNonJoinTablePrimary;
begin
  Result := TnxSqlNonJoinTablePrimary(FSetPrimaries[Index]);
end;

function TnxSqlNonJoinTableTerm.RefersTo(
  const aTableName: string): Boolean;
var
  i: Integer;
begin
  Result := NonJoinTablePrimary.RefersTo(aTableName);
  if not Result then
    for i := 0 to SetPrimariesCount - 1 do
      if SetPrimary[i].RefersTo(aTableName) then begin
        Result := True;
        exit;
      end;
end;

function TnxSqlNonJoinTableTerm.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  Result := NonJoinTablePrimary.RefersTo(aTableName, aColumnName);
  if not Result then
    for i := 0 to SetPrimariesCount - 1 do
      if SetPrimary[i].RefersTo(aTableName, aColumnName) then begin
        Result := True;
        exit;
      end;
end;

function TnxSqlNonJoinTableTerm.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
var
  i: Integer;
begin
  Result := NonJoinTablePrimary.RefersToContextVars(Context);
  if not Result then
    for i := 0 to SetPrimariesCount - 1 do
      if SetPrimary[i].RefersToContextVars(Context) then begin
        Result := True;
        exit;
      end;
end;

function TnxSqlNonJoinTableTerm.IsSelectInto: Boolean;
begin
  Result := (SetPrimariesCount = 0) and NonJoinTablePrimary.IsSelectInto;
end;

function TnxSqlNonJoinTableTerm.IsOrdered: Boolean;
begin
  Result := (SetPrimariesCount = 0) and NonJoinTablePrimary.IsOrdered;
end;

function TnxSqlNonJoinTableTerm.RefersToTemp: Boolean;
var
  i: Integer;
begin
  Result := NonJoinTablePrimary.RefersToTemp;
  if not Result then
    for i := 0 to SetPrimariesCount - 1 do
      if SetPrimary[i].RefersToTemp then begin
        Result := True;
        exit;
      end;
end;

function TnxSqlNonJoinTableTerm.IsResultTable(
  T: TnxSqlTableProxy): Boolean;
var
  i: Integer;
begin
  Result := (T = FResultTable) or NonJoinTablePrimary.IsResultTable(T);
  if not Result then begin
    for i := 0 to SetPrimariesCount - 1 do
      if SetPrimary[i].IsResultTable(T) then begin
        Result := True;
        exit;
      end;
  end;
end;

function TnxSqlNonJoinTableTerm.IsView: Boolean;
var
  Look: TnxSqlNode;
begin
  Look := Parent;
  while Look <> nil do begin
    if Look is TnxSqlCREATEVIEW then begin
      Result := True;
      exit;
    end;
    Look := Look.Parent;
  end;
  Result := False;
end;

{ TnxSqlOrderColumn }

procedure TnxSqlOrderColumn.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlOrderColumn then begin
    TableNameStr := TnxSqlOrderColumn(Source).TableNameStr;
    FieldNameStr := TnxSqlOrderColumn(Source).FieldNameStr;
  end else
    ENotCompatible(Source);
end;

function TnxSqlOrderColumn.ToString: WideString;
begin
  if TableNameStr <> '' then
    Result := ' ' + TableNameStr + '.'
  else
    Result := ' ';
  Result := Result + FieldNameStr;
end;

procedure TnxSqlOrderColumn.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
end;

function TnxSqlOrderColumn.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlOrderColumn then
    with TnxSqlOrderColumn(ANode) do
      Result :=
        AnsiSameText(TableNameStr, Self.TableNameStr)
        and AnsiSameText(FieldNameStr, Self.FieldNameStr)
  else
    Result := False;
end;

function TnxSqlOrderColumn.QualifiedName : string;

  function QuotedFieldName: string;
  var
    S: string;
  begin
    S := FieldNameStr;
    if (PosCh(' ', S) <> 0)
    or IsReservedName(S) then
      Result := '"' + S + '"'
    else
      Result := S;
  end;

begin
  if TableNameStr <> '' then
    Result := TableNameStr + '.' + QuotedFieldName
  else
    Result := QuotedFieldName;
end;

function TnxSqlOrderColumn.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlOrderColumn.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlOrderColumn.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
begin
  Result := TableNameStr <> '';
  if Result and SameText(TableNameStr, AliasName) then
    QualRefList.Add(FieldNameStr);
end;

{ TnxSqlOrderItem }

function TnxSqlOrderItem.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
begin
  Result := Column.AllColumnReferencesQualified(AliasName, QualRefList); 
end;

procedure TnxSqlOrderItem.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlOrderItem then begin
    if TnxSqlOrderItem(Source).Column <> nil then begin
      nxFreeAndNil(FColumn);
      Column := TnxSqlOrderItem(Source).Column.Clone(Self) as TnxSqlOrderColumn;
    end;
    Index := TnxSqlOrderItem(Source).Index;
    Descending := TnxSqlOrderItem(Source).Descending;
    IgnoreCase := TnxSqlOrderItem(Source).IgnoreCase;
    nxFreeAndNil(FCompareFlags);
    if TnxSqlOrderItem(Source).CompareFlags <> nil then
      CompareFlags := TnxSqlOrderItem(Source).Clone(Self) as TnxSqlCompareFlags;
    LocaleInt := TnxSqlOrderItem(Source).LocaleInt;
    NullBehaviour := TnxSqlOrderItem(Source).NullBehaviour;
  end else
    ENotCompatible(Source);
end;

function TnxSqlOrderItem.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlOrderItem.Create(AParent);
  Result.Assign(Self);
end;

destructor TnxSqlOrderItem.Destroy;
begin
  nxFreeAndNil(FColumn);
  nxFreeAndNil(FCompareFlags);
  inherited;
end;

function TnxSqlOrderItem.Equals(ANode: TnxSqlNode): Boolean;
begin
  Result := False;
  if ANode is TnxSqlOrderItem then
    with TnxSqlOrderItem(ANode) do
      if (Descending = Self.Descending)
        and (Index = Self.Index)
        and NodesIdentical(Column, Self.Column)
        and (IgnoreCase = Self.IgnoreCase)
        and NodesIdentical(CompareFlags, Self.CompareFlags)
        and (LocaleInt = Self.LocaleInt)
        and (NullBehaviour = Self.NullBehaviour) then
          Result := True;
end;

function TnxSqlOrderItem.GetCollationNameStr: string;
begin
  if FCollationName <> nil then
    Result := TokenToStrStripQ(FCollationName)
  else
    Result := FCollationNameStr;
end;

function TnxSqlOrderItem.GetLCID: LCID;
begin
  if (LocaleInt = 0) and (CollationNameStr <> '') then begin
    LocaleInt := nxLocaleFromCollation(CollationNameStr);
    if LocaleInt = -1 then
      raise EnxInternalSQLException.CreateFmt(rsUnknownCollation, [CollationNameStr]);
  end;
  Result := LocaleInt;
end;

procedure TnxSqlOrderItem.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  Column := Stream.ReadNode(Self) as TnxSqlOrderColumn;
  Descending := Stream.ReadBool;
  Index := Stream.ReadInt;
  IgnoreCase := Stream.ReadBool;
  CompareFlags := TnxSqlCompareFlags(Stream.ReadNodeOpt(Self));
  LocaleInt := Stream.ReadInt;
  NullBehaviour := TnxNullBehaviour(Stream.ReadInt);
  CollationNameStr := Stream.ReadLString;
end;

procedure TnxSqlOrderItem.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteNode(Column);
  Stream.WriteBool(Descending);
  Stream.WriteInt(Index);
  Stream.WriteBool(IgnoreCase);
  Stream.WriteNodeOpt(CompareFlags);
  Stream.WriteInt(LocaleInt);
  Stream.WriteInt(ord(NullBehaviour));
  Stream.WriteLString(CollationNameStr);
end;

procedure TnxSqlOrderItem.SetCollationNameStr(const Value: string);
begin
  if Value <> GetCollationNameStr then begin
    FCollationNameStr := Value;
    FCollationName := nil;
  end;
end;

function TnxSqlOrderItem.ToString: WideString;
begin
  if Column <> nil then
    Result := trim(Column.ToString)
  else
    Result := ' ' + IntToStr(Index);
  if Descending then
    Result := Result + ' DESC'
  {else
    Result := Result + ' ASC' - default}
      ;
  if LocaleInt <> 0 then
    Result := Result + ' LOCALE ' + IntToStr(LocaleInt);
  if IgnoreCase then
    Result := Result + ' IGNORE CASE';
  if CompareFlags <> nil then
    Result := Result + CompareFlags.ToString;
  case NullBehaviour of
  nbTop :
    //Result := Result + ' NULLS FIRST'; default
    ;
  nbBottom :
    Result := Result + ' NULLS LAST';
  nbAsAscend :
    Result := Result + ' NULLS AS ASCEND';
  nbFilterNull :
    Result := Result + ' NO NULLS';
  nbFilterNonNull :
    Result := Result + ' NULLS ONLY';
  end;
end;

procedure TnxSqlOrderItem.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if Column <> nil then
    Column.Traverse(Callback, UserData, IncludeNested);
end;

{ TnxSqlSELECT }

procedure TnxSqlSELECT.AddTableFields(Context: TnxSQLContext; Table : TnxSqlTableProxy;
                                StartPoint : Integer;
                                      FieldRef : TnxSqlFieldRef);
var
  Factor : TnxSqlFacColumn;
  j : Integer;
  Selection : TnxSqlSelection;
  StartVal : Integer;
  Term : TnxSqlTerm;
//  anAlias: string;
begin
  Assert(Table <> nil);
  Assert(Table is TnxSqlTableProxy);
{
  if TablesAdded.IndexOf(Table)>-1 then
    exit;
  TablesAdded.Add(Table);
 
  if (Table.Alias = '') and (Table.Owner<>nil) and (Table.Owner is TnxSqlJoinTableExp) then
  begin
    AddTableFields(Context, TnxSqlJoinTableExp(Table.Owner).TableRef1.Table, Startpoint, FieldRef);
    AddTableFields(Context, TnxSqlJoinTableExp(Table.Owner).TableRef2.Table, Startpoint, FieldRef);
    exit;
  end;
}
  if Table.FieldCount > 0 then begin
    StartVal := Pred(Table.FieldCount);
    if FieldRef <> nil then begin
      FieldRef.WasWildcard := True;
      FieldRef.FieldNameStr := Table.FieldNC(StartVal).Name;
// following line rolled back by HD; this change Breaks column binding in join
//      FieldRef.SetField(Table.FieldNC(StartVal));
      if Table.Alias <> '' then
        FieldRef.TableNameStr := Table.Alias
      else
        FieldRef.TableNameStr := Table.Name;
      dec(StartVal);
    end;
    for j := 0 to StartVal do begin
      Selection := TnxSqlSelection.Create(self);
      Selection.SimpleExpression :=
        TnxSqlSimpleExpression.Create(Selection);
      Term := TnxSqlTerm.Create(Selection.SimpleExpression);
      Factor := TnxSqlFacColumn.Create(Term);
      Factor.FieldRef := TnxSqlFieldRef.Create(Factor);
      Factor.FieldRef.AddedByWildcard := True;

// following line rolled back by HD; this change Breaks column binding in join
//      Factor.FieldRef.SetField(Table.FieldNC(j));
      if Table.Alias <> '' then
        Factor.FieldRef.TableNameStr := Table.Alias
      else
        Factor.FieldRef.TableNameStr := Table.Name;
      Factor.FieldRef.FieldNameStr := Table.FieldNC(j).Name;
      Term.AddFactor(Factor);
      {Selection.AddedByWildcard := True;}
      Selection.SimpleExpression.AddTerm(Term);
      SelectionList.Insert(StartPoint+j, Selection);
    end;
  end;
end;

(*
procedure TnxSqlSELECT.AddTableFieldsFromList(Table : TnxSqlTableProxy;
                                const StartPoint : Integer;
                                      FieldRef : TnxSqlFieldRef;
                                      List: TList);
var
  Factor : TnxSqlFacColumn;
  j : Integer;
  Selection : TnxSqlSelection;
  StartVal : Integer;
  Term : TnxSqlTerm;
  aFieldName: String;
  //IsUsingItem: boolean;
  Skip: Boolean;
  I: Integer;
  //k: Integer;
begin
  Assert(Table <> nil);
  Assert(Table is TnxSqlTableProxy);
  if List.Count=0 then
  begin
    SelectionList.Remove(StartPoint);
    exit;
  end;

  if Table.FieldCount > 0 then begin
    StartVal := Pred(List.Count);
    if FieldRef <> nil then begin
      FieldRef.WasWildcard := True;
      FieldRef.FieldNameStr := TnxSqlFieldProxy(List[StartVal]).Name;
      // following line rolled back by HD; this change Breaks column binding in join
      //      FieldRef.SetField(TnxSqlFieldProxy(List[StartVal]));
      dec(StartVal);
    end;
    if StartVal < 0 then
      exit;
    aFieldName:=TnxSqlFieldProxy(List[StartVal]).Name;
    for j := StartVal downto 0 do begin
      // check whether the field is part of using list in joins
      //IsUsingItem:=false;
      Skip:=false;
      if (Table.Owner is TnxSqlJoinTableExp) then
      begin
        if TnxSqlJoinTableExp(Table.Owner).Natural then
         skip:=true;

        if (TnxSqlJoinTableExp(Table.Owner).UsingList<>nil) then
          for I := 0 to TnxSqlJoinTableExp(Table.Owner).UsingList.Count - 1 do
            if SameText(TnxSqlFieldProxy(List[j]).Name, TnxSqlJoinTableExp(Table.Owner).UsingList.Item[i].ColumnNameStr) then
              Skip:=true;
      end;

      if skip then
        Continue;

      Selection := TnxSqlSelection.Create(Self);
      Selection.SimpleExpression :=
        TnxSqlSimpleExpression.Create(Selection);
      Term := TnxSqlTerm.Create(Selection.SimpleExpression);
      Factor := TnxSqlFacColumn.Create(Term);
      Factor.FieldRef := TnxSqlFieldRef.Create(Factor);
// following line rolled back by HD; this change Breaks column binding in join
//      Factor.FieldRef.SetField(TnxSqlFieldProxy(List[j]));

      if TnxSqlFieldProxy(List[j]).OwnerTable.Alias <> '' then
        Factor.FieldRef.TableNameStr :=
            TnxSqlFieldProxy(List[j]).OwnerTable.Alias
      else
        Factor.FieldRef.TableNameStr := TnxSqlFieldProxy(List[j]).OwnerTable.Name;
      Factor.FieldRef.FieldNameStr := TnxSqlFieldProxy(List[j]).Name;
      Term.AddFactor(Factor);
      Selection.AddedByWildcard := True;
      Selection.SimpleExpression.AddTerm(Term);
      SelectionList.Insert(StartPoint, Selection);
    end;
  end;
end;
*)

procedure TnxSqlSELECT.AddTableRefs(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlTableRef then
    TnxSqlTableRef(Node).AddTableReference(TnxSqlContext(UserData), Self);
end;

procedure TnxSqlSELECT.AddColumns(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlColumnDefiner then
    TnxSqlColumnDefiner(Node).AddColumnDef(Self);
end;

function TnxSqlSELECT.GroupedAggregateQueryResult(Context: TnxSqlContext;
  NeedData: Boolean; var RecordsRead: Integer; Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
var
//  FieldNum: Integer;
//  BackWards: boolean;
  KeyIterateInfo: TnxSqlKeyIterateInfo;
  IndexNames: TnxSQLStringArray;
  aStringList: TnxFastStringListIC;
  I: Integer;
  GroupColumnsIn : Integer;
  AggExpList,
  SourceFields : TList;
  Status : TnxResult;
  AggList: TnxSqlAggregateList;
  FieldDefList: TnxSqlFieldDefList;
  {Mapping: TList;
  NeedMapping: Boolean;}
  S: DWord;
  FieldDefList2: TnxSqlFieldDefList;
begin
  snBeginUse;
  try
    if NormalLogging then
      LogNormal('Grouped query');
    Result:=nil;
    S := GetTickCount;
    Assert(GroupColumnList <> nil);
    RequestLive := False;

    SourceFields := nil;
    AggExpList := nil;

    try
      SourceFields := TList.Create;

      AggExpList := TList.Create;

      GroupColumnsIn := GroupColumnList.Count;

      Assert(GroupColumnsIn > 0);

      AggList := TnxSqlAggregateList.Create(Self);
      try
        AggList.OwnsItems := False;

        FieldDefList:=nil;
        BuildAggList(Context, AggList);

        FieldDefList2:=TnxSQLFIeldDefList.Create;
        try
          FillFieldDefList(FieldDefList2, Context);
          if (not AggList.NeedToReadRecords(Context)) and CanUseIndexIterator(Context, AggList, KeyIterateInfo.IndexIndex, IndexNames, KeyIterateInfo.KeyEngine, KeyIterateInfo.BaseTable, KeyIterateInfo.IndexDescriptor, FieldDefList2) then
          begin
            if VerboseLogging then
              LogVerbose('Aggregates can be built on the fly using an index.');
            Distinct:=true;
            FreeAndNil(result);
            exit;
          end;
        finally
          FieldDefList2.Free;
        end;

        AggList.Clear;

        if VerboseLogging then
          LogVerbose('Building sorted intermediate result');
        Result := BuildGroupingTable(Context, GroupColumnsIn, SourceFields, AggList, FieldDefList);

        try
          if (CondExpWhere = nil)
		  {TODO: check if this can be expanded to lower hsv levels}
          or not (CondExpWhere.HasStaticValue(Context) = hsvYes)
          or (CondExpWhere.AsBoolean(Context) = tsbTrue) then begin

            if RowBuilder = nil then begin

              FRowBuilder := TnxSqlRowBuilder.Create(Context, Self, nil, Database, ParentBlock, CondExpWhere, CopyBlobs, IsSelection);

              Assert(Assigned(TablesReferencedByOrder));
              for i := 0 to pred(TablesReferencedByOrder.Count) do
                RowBuilder.Sources.Add(
                  TnxSqlRowRange.Create(
                    TablesReferencedByOrder[i].Table
                    ));
            end;

            RowBuilder.ClearColumnList;

            for i := 0 to pred(GroupColumnsIn) do
              RowBuilder.AddColumnField(
                SourceFields.List[i],
                Result.FieldNC(i));

            for i := 0 to AggList.Count - 1 do
              RowBuilder.AddColumnExpression(AggList[i].SimpleExpression,
                Result.FieldNC(i + GroupColumnsIn));

            if NeedData then begin
              RowBuilder.TargetTable := Result;

  { Rollback 2234
              for i := 0 to pred(TablesReferencedByOrder.Count) do
              begin
                TablesReferencedByOrder[i].Refresh(Context);
              end;
  }
              Database.StartTransaction([nil], False, True);
              try
                Result.BeginBatchPostMode;
                try
                  if TablesReferencedByOrder.Count = 1 then begin
                    nxFreeAndNil(RowBuilder.fOrderByDescriptor);
                    if TablesReferencedByOrder[0].Table.
                        Cursor <> nil then
                      RowBuilder.OrderByDescriptor := BuildGroupByIndexDesc(
                        Context,
                        TablesReferencedByOrder[0].Table.Cursor.TableDescriptor,
                        ResolveGroupColumn, True, False)
                    else
                      RowBuilder.OrderByDescriptor := nil;
                    RowBuilder.OrderByScope := FOrderByScope;
                  end;

                  RowBuilder.Execute(Context, UseIndexes, nil, jmNone, nil, RecordsRead);
                  if RowBuilder.OrderByDescriptor<>nil then
                  begin
                    aStringList:=TnxFastStringListIC.Create;
                    try
                      for I := 0 to GroupColumnList.Count - 1 do    // Iterate
                        aStringlist.Add(TnxSqlGroupColumn(GroupColumnList[i]).QualifiedName(context));
                      Result.AddIndex('TempGroupByIndex', '', aStringlist, idAll, false, false);
                      if result.IndexExists('TempGroupByIndex') then
                      begin
                        result.SetIndex('TempGroupByIndex');
                        RowBuilder.SortedState :=ssOrdered;
                      end;
                    finally
                      aStringlist.free;
                    end;
                  end;
                  Result.EndBatchPostMode(false);
                except
                  Result.EndBatchPostMode(true);
                  raise;
                end;
                Database.Commit;
              except
                Database.AbortTransaction;
                raise;
              end;
            end;

            (*
            writeln('table dump:');
            if Result.First then
              repeat
                for i := 0 to Result.FieldCount - 1 do
                  DumpField(Result.FieldC(i).GetValue);
                writeln;
              until not Result.Next;
            writeln('=======');
            *)

            {for i := 0 to Result.FieldCount - 1 do
              Result.FieldNC(i).IsTarget := False;}

            if RowBuilder.SortedState <> ssOrdered then begin
              Status := Result.Sort(Context, BuildGroupByIndexDesc, ResolveGroupColumn, True, False);
              if Status = DBIERR_NOTSUPPORTED then
                raise EnxSqlException.Create(rsNotAllColumnsSortable)
              else
              if Status <> DBIERR_NONE then
                raise EnxSqlException.nxCreate(Status);
            end;
          end;

          {$IFOPT Q+}
            {$DEFINE LocalOverflowCheckOFF}
            {$OVERFLOWCHECKS OFF}
          {$ENDIF}
          if VerboseLogging then
            LogVerbose('Elapsed (intermediate result):' + IntToStr(GetTickCount - S));
          {$IFDEF LocalOverflowCheckOFF}
            {$OVERFLOWCHECKS ON}
            {$UNDEF LocalOverflowCheckOFF}
          {$ENDIF}
          {try}

            Result := CopyGrouped(Result, Context, SourceFields, AggExpList, AggList, FieldDefList{, Mapping});

            //Result := DoHaving(Result, Context);

            if ((Parent is TnxSqlIn) and not SpecialInSubquery) or (Parent is TnxSqlCPMatch) then
              {Result := }DoSortOnAll(Result)
            else
              Result := DoAggOrderBy(Context, Result, NeedData);

          DoLimit(Result);

          if assigned(Recycle) then begin
            Recycle.TransplantCursorFrom(Result);
            Result := Recycle;
          end;

        except
          Result.Owner := nil;
          nxFreeAndNil(Result);
          raise;
        end;

      finally
        nxFreeAndNil(AggList);
        nxFreeAndNil(FieldDefList);
      end;

    finally
      nxFreeAndNil(SourceFields);
      nxFreeAndNil(AggExpList);
    end;
  finally
    snEndUse;
  end;
end;

type
  TAggCalcDataPacket = class
    RowBuilder   : TnxSqlRowBuilder;
    Context      : TnxSqlContext;
    AggList      : TnxSqlAggregateList;
    AggListCount : integer;
  end;

function TnxSqlSELECT.UpdateAggregateCounters(Cookie: Pointer): Boolean;
var
  i: Integer;
begin
//  with TAggCalcDataPacket(Cookie) as TAggCalcDataPacket, AggList do
    for i := 0 to TAggCalcDataPacket(Cookie).AggListCount - 1 do
      TAggCalcDataPacket(Cookie).AggList.Item[i].Update(TAggCalcDataPacket(Cookie).Context);
  with TAggCalcDataPacket(Cookie) do
    if Assigned(RowBuilder) then
      Inc(RowBuilder.RecordsWritten);
  Result := True; // continue
end;

function TnxSqlSELECT.BuildSingleColumnIndexDesc(Field: TnxSqlFieldProxy; Descending: Boolean): TnxIndexDescriptor;
var
  aF: TnxKeyFieldDescriptor;
begin
  Result := TnxIndexDescriptor.CreateStandalone(0, 'singlecolumnindex', 0, TnxCompKeyDescriptor);
  try
    af:=TnxCompKeyDescriptor(Result.KeyDescriptor).Add(Field.Index);
    af.Ascend := not Descending;
    af.CustomStrings.Add('Name='+field.Name);
    if (Field.Descriptor <> nil) and (Field.Descriptor.UsedLocaleDescriptor <> nil) then
      af.AddLocaleDescriptor.Assign(Field.Descriptor.UsedLocaleDescriptor);
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;

type
  PRebindInfo = ^TRebindInfo;
  TRebindInfo = record
    Context: TnxSqlContext;
    TargetTable: TnxSqlTableProxy;
    GroupFieldList: TList;
    ReboundFieldRefs: TList;
    OldField: TList;
  end;

function TnxSqlSELECT.StraightGlobalAggregates(Context: TnxSqlContext;
  NeedData: Boolean; AggList: TnxSqlAggregateList; Recycle: TnxSqlTableProxy;
  var RecordsRead: Integer): TnxSqlTableProxy;
var
  FieldDefList: TnxSqlFieldDefList;
  ai, i: Integer;
  N : TnxSqlNode;
  AggCalcData: TAggCalcDataPacket;
  F: TnxSqlFieldProxy;
  AggExpList : TList;
  Ag : TnxSqlAggregate;
  FldType : TnxFieldType;
  v: Variant;
  RebindInfo: TRebindInfo;
begin
  if Recycle <> nil then begin
    Recycle.Empty;
    Result := Recycle;

    AggExpList := TList.Create;
    try
      for i := 0 to pred(Columns.Count) do begin
        N := TnxSqlNode(Columns[i].Info);
        AggExpList.Add(N);
      end;

      RowBuilder.ClearColumnList;

      if NeedData then begin
        for i := 0 to AggList.Count - 1 do
          with AggList[i] do
            CreateCounter(SimpleExpression, Context);

        RowBuilder.TargetTable := nil;
        Database.StartTransaction([nil], False, True);
        try
          AggCalcData := TAggCalcDataPacket.Create;
          try
            AggCalcData.Context := Context;
            AggCalcData.AggList := AggList;
            AggCalcData.AggListCount:=AggList.Count;

            RowBuilder.LimitDependsOnMatchingSort := False;
            RowBuilder.Limit := -1;

            if (AggList.Count = 1) then
              with AggList[0] do
                if (SimpleExpression <> nil)
                and SimpleExpression.IsField(Context, F) {as opposed to an expr} then begin
                  if AgFunction in [agMin, agMax] then begin

                    RowBuilder.Limit := 1;
                    RowBuilder.LimitDependsOnMatchingSort := True;

                    RowBuilder.OrderByDescriptor := BuildSingleColumnIndexDesc(F, AgFunction <> agMin);
                    FOrderByScope.Clear;
                    FOrderByScope.AddColumn(F.Name);
                    RowBuilder.OrderByScope := FOrderByScope;
                    AggCalcData.RowBuilder := RowBuilder;
                  end;
                end;

            RowBuilder.Execute(Context, UseIndexes, UpdateAggregateCounters, jmNone, AggCalcData, RecordsRead);
          finally
            nxFreeAndNil(AggCalcData);
          end;
          if (CondExpHaving = nil)
          or (CondExpHaving.AsBoolean(Context) = tsbTrue) then begin
            Result.Insert;
            for i := 0 to AggExpList.Count - 1 do begin
              v := Unassigned;
              v := TnxSqlSimpleExpression(AggExpList.List[i]).GetValue(Context);
              Result.FieldNC(i).SetValue(v);
            end;
            Result.Post;
          end;

          for i := 0 to AggList.Count - 1 do
            AggList[i].DeleteCounter;
          Database.Commit;
        except
          Database.AbortTransaction;
          raise;
        end;
      end;
    finally
      nxFreeAndNil(AggExpList);
    end;
    exit;
  end;
  {check function/source type compatibility}
  for i := 0 to AggList.Count - 1 do begin
    Ag := AggList[i];
    if Ag.SimpleExpression <> nil then begin
      FldType := Ag.SimpleExpression.GetType(Context);
      if not Ag.ValidType(FldType) then
        raise EnxInternalSQLException.CreateFmt(rsAggregateFunctionRequiresNumericExpression,
                                  [AgString[Ag.AgFunction]]);
    end;
  end;

  AggExpList := TList.Create;
  try
    FieldDefList := TnxSqlFieldDefList.Create;
    try
      ai:=0;
      Assert(Assigned(Columns));
      for i := 0 to pred(Columns.Count) do begin
        N := TnxSqlNode(Columns[i].Info);
        case N.GetType(Context) of
        nxtBcd, nxtFmtBcd :
          FieldDefList.AddField(Columns[i].Name, '',
            N.GetType(Context), 20 - N.GetDecimals(Context), N.GetDecimals(Context), 1, 1,
            False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
        nxtExtended, nxtDouble,
        nxtCurrency..nxtDateTime, {nxtBcd, nxtFmtBcd,}
        nxtBoolean..nxtWideChar,
        nxtShortString..nxtWideString :
          FieldDefList.AddField(Columns[i].Name, '',
            N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1,
            False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
        else
        begin
          case AggList[ai].AgFunction of
          agCount :
            FieldDefList.AddField(Columns[i].Name, '', nxtInt64, 0, 0, 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
          agMin,
          agMax :
            FieldDefList.AddField(Columns[i].Name, '', N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
          else
            FieldDefList.AddField(Columns[i].Name, '', N.GetType(Context){nxtDouble}, 8, N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
          end;
          inc(ai);
        end;
        end;
        AggExpList.Add(N);
      end;

      Result := Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      nxFreeAndNil(FieldDefList);
    end;

    RowBuilder.ClearColumnList;

    if NeedData then begin
      for i := 0 to AggList.Count - 1 do
        with AggList[i] do
          CreateCounter(SimpleExpression, Context);

      RowBuilder.TargetTable := nil;
      Database.StartTransaction([nil], False, True);
      try
        AggCalcData := TAggCalcDataPacket.Create;
        try
          AggCalcData.Context := Context;
          AggCalcData.AggList := AggList;
          AggCalcData.AggListCount:=AggList.Count;

          RowBuilder.LimitDependsOnMatchingSort := False;
          RowBuilder.Limit := -1;

          if (AggList.Count = 1) then
            with AggList[0] do
              if (SimpleExpression <> nil)
              and SimpleExpression.IsField(Context, F) {as opposed to and expr} then begin
                if AgFunction in [agMin, agMax] then begin

                  RowBuilder.Limit := 1;
                  RowBuilder.LimitDependsOnMatchingSort := True;

                  RowBuilder.OrderByDescriptor := BuildSingleColumnIndexDesc(F, AgFunction <> agMin);
                  FOrderByScope.Clear;
                  FOrderByScope.AddColumn(F.Name);
                  RowBuilder.OrderByScope := FOrderByScope;
                  AggCalcData.RowBuilder := RowBuilder;
                end;
              end;

          RowBuilder.Execute(Context, UseIndexes, UpdateAggregateCounters, jmNone, AggCalcData, RecordsRead);
        finally
          nxFreeAndNil(AggCalcData);
        end;

        if CondExpHaving <> nil then begin
          RebindInfo.TargetTable := nil;
          RebindInfo.GroupFieldList := nil;
          RebindInfo.Context := Context;
          RebindInfo.ReboundFieldRefs := TList.Create;
          RebindInfo.OldField := TList.Create;
          try
            CondExpHaving.Traverse(Rebind, @RebindInfo, True);
          finally
            RebindInfo.ReboundFieldRefs.Free;
            RebindInfo.OldField.Free;
          end;
        end;

        if (CondExpHaving = nil)
        or (CondExpHaving.AsBoolean(Context) = tsbTrue) then begin
          Result.Insert;
          for i := 0 to Result.FieldCount - 1 do begin// AggList.Count - 1 do
            v := Unassigned;
            v := TnxSqlSimpleExpression(AggExpList.List[i]).GetValue(Context);
            Result.FieldNC(i).SetValue(v);
          end;
          Result.Post;
        end;

        for i := 0 to AggList.Count - 1 do
          AggList[i].DeleteCounter;
        Database.Commit;
      except
        Database.AbortTransaction;
        raise;
      end;
    end;
  finally
    nxFreeAndNil(AggExpList);
  end;
end;

function TnxSqlSELECT.GlobalAggregateQueryResult(Context: TnxSqlContext;
  NeedData: Boolean; var RecordsRead: Integer; Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
var
  i : Integer;
  ColumnName: string;
  AggList: TnxSqlAggregateList;
//  KeyIterateInfo: TnxSqlKeyIterateInfo;
//  IndexNames: TnxSQLStringArray;

begin
  Assert(GroupColumnList = nil);

  RequestLive := False;

  if (CondExpWhere = nil)
  and (TablesReferencedByOrder.Count = 1)
  and (CondExpHaving = nil)
  and (SelectionList.Count = 1) then
    with SelectionList[0] do
      if (SimpleExpression <> nil)
      and (length(SimpleExpression.TermList) = 1) then
        with SimpleExpression.TermList[0] do
          if length(FactorList) = 1 then
            if FactorList[0] is TnxSqlFacAgg then
            with TnxSqlFacAgg(FactorList[0]) do
              if (Aggregate <> nil)
              and (Aggregate.AgFunction = agCount)
              and (Aggregate.SimpleExpression = nil) then begin
                if Column <> nil then
                  ColumnName := Column.ColumnNameStr
                else
                  ColumnName := 'COUNT()';
                TablesReferencedByOrder[0].Refresh(Context);
{!!!                if not Assigned(TablesReferencedByOrder[0].Table) then begin
                  asm int 3 end;
                  Bind(False, Context);
                end;}
                Result := TableWithCount(ColumnName, UnaryMinus, Recycle);
                exit;
              end;


  Result := nil;

  DoCheckAggregates(Context);

  AggList := TnxSqlAggregateList.Create(Self);
  try
    AggList.OwnsItems := False;
    BindingContext := Context;
    SelectionList.Traverse(EnumAggregates, AggList, False);
    if CondExpHaving <> nil then
      CondExpHaving.Traverse(EnumAggregates, AggList, False);
    try
      if RowBuilder = nil then
      begin
        FRowBuilder := TnxSqlRowBuilder.Create(Context, Self, nil, Database, ParentBlock, CondExpWhere, CopyBlobs, IsSelection);

        Assert(Assigned(TablesReferencedByOrder));
        for i := 0 to pred(TablesReferencedByOrder.Count) do
          RowBuilder.Sources.Add(
            TnxSqlRowRange.Create(
              TablesReferencedByOrder[i].Table
              ));
      end;


      if OnlyStraightAggregates(AggList) then

        Result := StraightGlobalAggregates(Context, NeedData, AggList, Recycle, RecordsRead)

      else begin

        if Recycle <> nil then begin
          Recycle.Owner := nil;
          nxFreeAndNil(Recycle);
        end;

        // make a nasty dummy call to force binding of the CondExphaving
        // otherwise we've to duplicate some code for that.
        if CondExpHaving<>nil then
          CondExpHaving.DependsOn(Context, RowBuilder.Sources[0].Table);
        Result := BuildAggResultTable(Context, AggList);

        RowBuilder.ClearColumnList;

        for i := 0 to AggList.Count - 1 do begin
          RowBuilder.AddColumnExpression(
            AggList[i].SimpleExpression,
            Result.FieldNC(i));
        end;

        if NeedData then begin

          RowBuilder.TargetTable := Result;
          Database.StartTransaction([nil], False, True);
          try
            Result.BeginBatchPostMode;
            try
              RowBuilder.Execute(Context, UseIndexes, nil, jmNone, nil, RecordsRead);
              Result.EndBatchPostMode(false);
            except
              Result.EndBatchPostMode(true);
              raise;
            end;
            Database.Commit;
          except
            Database.AbortTransaction;
            raise;
          end;

        end;

        {for i := 0 to Result.FieldCount - 1 do
          Result.FieldNC(i).IsTarget := False;}

        Result := CalcAggregates(Result, Context, AggList);

      end;

      {Result := DoHaving(Result, Context);}


      if ((Parent is TnxSqlIn) and not SpecialInSubquery) or (Parent is TnxSqlCPMatch) then
        {Result := }DoSortOnAll(Result)
      else
        Result := DoAggOrderBy(Context, Result, NeedData);

    except
      if Result <> nil then begin
        Result.Owner := nil;
        nxFreeAndNil(Result);
      end;
      raise;
    end;

  finally
    nxFreeAndNil(AggList);
  end;
end;

procedure TnxSqlSELECT.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlSELECT then begin
    Clear;
    Distinct := TnxSqlSELECT(Source).Distinct;
    LimitInt := TnxSqlSELECT(Source).LimitInt;
    LimitStart := TnxSqlSELECT(Source).LimitStart;
    LimitPercent := TnxSqlSELECT(Source).LimitPercent;
    FixedLimitInt := TnxSqlSELECT(Source).FixedLimitInt;
    FixedLimitStart := TnxSqlSELECT(Source).FixedLimitStart;

    if TnxSqlSELECT(Source).LimitIntFactor <> nil then
      LimitIntFactor := TnxSqlSELECT(Source).LimitIntFactor.Clone(Self) as TnxSqlFacParm;
    if TnxSqlSELECT(Source).LimitStartFactor <> nil then
      LimitStartFactor := TnxSqlSELECT(Source).LimitStartFactor.Clone(Self) as TnxSqlFacParm;

    if TnxSqlSELECT(Source).LimitIntExp <> nil then
      LimitIntExp := TnxSqlSELECT(Source).LimitIntExp.Clone(Self) as TnxSqlSimpleExpression;

    if TnxSqlSELECT(Source).LimitStartExp <> nil then
      LimitStartExp := TnxSqlSELECT(Source).LimitStartExp.Clone(Self) as TnxSqlSimpleExpression;

    if TnxSqlSELECT(Source).SelectionList <> nil then
      SelectionList := TnxSqlSELECT(Source).SelectionList.Clone(Self) as TnxSqlSelectionList;
    TableRefList := TnxSqlTableRefList.Create(Self);
    TableRefList.Assign(TnxSqlSELECT(Source).TableRefList);
    if TnxSqlSELECT(Source).CondExpWhere <> nil then
      CondExpWhere := TnxSqlSELECT(Source).CondExpWhere.Clone(Self) as TnxSqlCondExp;
    if TnxSqlSELECT(Source).GroupColumnList <> nil then
      GroupColumnList := TnxSqlSELECT(Source).GroupColumnList.Clone(Self) as TnxSqlGroupColumnList;
    if TnxSqlSELECT(Source).CondExpHaving <> nil then
      CondExpHaving := TnxSqlSELECT(Source).CondExpHaving.Clone(Self) as TnxSqlCondExp;
    if TnxSqlSELECT(Source).OrderList <> nil then
      OrderList := TnxSqlSELECT(Source).OrderList.Clone(Self) as TnxSqlOrderList;
    TargetTableStr := TnxSqlSELECT(Source).TargetTableStr;
    TargetDatabasestr := TnxSqlSELECT(Source).TargetDatabasestr;
  end else
    ENotCompatible(Source);
end;

procedure TnxSqlSELECT.ClearBindings(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlFieldRef then
    TnxSqlFieldRef(Node).Unbind;
end;

{procedure TnxSqlSELECT.ResetStatic(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlExprNode then
    TnxSqlExprNode(Node).ResetStaticCheck;
end;}

procedure TnxSqlSELECT.OnRequestClose(Sender: TObject);
var
  LockContainer: InxSqlLockContainer;
begin
  LockContainer := snLockContainer;
  if Assigned(LockContainer) then begin
    LockContainer.Lock;
    try
      if LockContainer.UseCount = 0 then
        Unbind;
    finally
      LockContainer.Unlock;
    end;
  end;
end;

procedure TnxSqlSELECT.Bind(Prebinding: Boolean; Context: TnxSqlContext);
var
  i, j : Integer;
  T : TnxSqlTableProxy;
  {Alias: string;}
  ct: TnxFieldType;
const
  LiveMode : array[Boolean] of TnxSqlOpenmode = (somReadOnly, somWriteShared);
begin
  if not Assigned(Database) then
    if Assigned(Owner) then
      if Assigned(Owner.Database) then
        Database := Owner.Database;

  if FFirstSimplify then //make sure we've simplified the query before doing anything
    while Simplify(Context) do;

  if LimitIntFactor<>nil then
    LimitInt := LimitIntFactor.GetValue(Context)
  else if LimitIntExp<>nil then
    LimitInt := LimitIntExp.GetValue(Context)
  else
    LimitInt := FixedLimitInt;

  if LimitStartFactor<>nil then
    LimitStart := LimitStartFactor.GetValue(Context)
  else
  if LimitStartExp<>nil then
    LimitStart := LimitStartExp.GetValue(Context)
  else
    LimitStart := FixedLimitStart;

  if LimitInt <> -1 then begin
    if LimitInt < 0 then
      raise EnxInternalSQLException.Create(rsTOPMustGreaterZeroa);
    if (LimitStart <> -1) and (LimitStart < 1)  then
      raise EnxInternalSQLException.Create(rsTopStartMustBeGreaterZero);
  end;

  snBeginUse;
  try
    if Binding then
      Exit;
    Binding := True;

    {don't clear bindings for sub-queries as that will disable
     explicit redirection to grouping columns for a grouped
     enclosing query (issue #1434)}
    if (CondExpWhere <> nil) and not IsSubQuery then
      CondExpWhere.Traverse(ClearBindings, Context, False);
    if (CondExpHaving <> nil) and not IsSubQuery then
      CondExpHaving.Traverse(ClearBindings, Context, False);

    ClearTableList;

    TableRefList.Traverse(AddTableRefs, Context, False);
    Assert(Assigned(TablesReferencedByOrder));

    {check for duplicate, unqualified tables in the from list}
    for i := 0 to TablesReferencedByOrder.Count - 1 do
      if not TablesReferencedByOrder[i].UnNamed
      and (TablesReferencedByOrder[i].TableRef2.AliasStr = '') then
        for j := i + 1 to TablesReferencedByOrder.Count - 1 do
          if not TablesReferencedByOrder[j].UnNamed
          and (TablesReferencedByOrder[j].TableRef2.AliasStr = '') then
            if SameText(
              TablesReferencedByOrder[i].TableRef2.TablenameStr,
              TablesReferencedByOrder[j].TableRef2.TablenameStr) then
                raise EnxInternalSQLException.CreateFmt(rsAmbiguousTableReference7, [
                  TablesReferencedByOrder[j].TableRef2.TablenameStr]);

    for i := 0 to pred(TablesReferencedByOrder.Count) do begin
      Assert(TablesReferencedByOrder[i].Name <> '');
      if TablesReferencedByOrder[i].UnNamed then
      begin
        Assert(TablesReferencedByOrder[i].Table <> nil);
        if (TnxInternalTableRef(TablesReferencedByOrder[i]).Table.Owner is TnxSqlSELECT) and
          (TnxSQLSelect(TnxInternalTableRef(TablesReferencedByOrder[i]).Table.Owner).IsSubQUery) and
          (not (TnxSQLSelect(TnxInternalTableRef(TablesReferencedByOrder[i]).Table.Owner).IsPSM) and
          (TnxInternalTableRef(TablesReferencedByOrder[i]).Table.Alias='')) then
            raise EnxSqlException.nxCreate(rsCorrelationNameForSubQueryExpected+
              TnxSQLSelect(TnxInternalTableRef(TablesReferencedByOrder[i]).Table.Owner).ToString);
      end
      else begin
        T :=  TablesReferencedByOrder[i].TableRef2.GetTable(Context, Self, Livemode[RequestLive]);

        if T = nil then
          if TablesReferencedByOrder[i].TableRef2.TableName=nil then
            EBadTab(TablesReferencedByOrder[i].TableRef2.TablenameStr, TablesReferencedByOrder[i].TableRef2.AssignedLocation)
          else
            EBadTab(TablesReferencedByOrder[i].TableRef2.TablenameStr, TablesReferencedByOrder[i].TableRef2.Tablename);

        TablesReferencedByOrder[i].SetTable(T);

        if not Assigned(ssRequestClose) then
          ssRequestClose := nxRequestCloseHandlerEvent(OnRequestClose);

        T.SetCloseNotification(ssRequestClose);
      end;
    end;

    ExpandWildcards(Context);

    if CondExpWhere <> nil then
      CondExpWhere.MatchType(Context, nxtBoolean);

    if CondExpHaving <> nil then
      CondExpHaving.MatchType(Context, nxtBoolean);

    Assert(Assigned(Columns));
    Columns.Clear;
    if SelectionList <> nil then
      SelectionList.Traverse(AddColumns, Context, False);

    HaveAggregates := False;

    if SelectionList <> nil then
      SelectionList.Traverse(FlagAggregates, Context, False);

    if Distinct then begin
      Assert(Assigned(Columns));
        for i := 0 to pred(Columns.Count) do begin
          ct := TnxSqlNode(Columns[i].Info).GetType(Context);
          case ct of
          nxtBoolean..nxtDateTime,
          nxtShortString..nxtWideString,
          nxtGuid, nxtBCD, nxtFmtBCD :;
          else
            SQLError(format(rsDatatypeNotSupportedInDistinct,
              [Columns[i].Name, Columns[i].Location, FieldDataTypeNames[ct, fdtnSqlFixed]]));
          end;
        end;
    end;

    Bound := Context.ContextID;
    BoundGen := Context.Generation;
  finally
    Binding := False;
    snEndUse;
  end;
end;

function TnxSqlSELECT.BindColumn(Context: TnxSqlContext; aInAggregate: Boolean;
  const DatabaseName, TableName, ColumnName, SourceLoc: string;
  BindingNode: TnxSqlNode; BindingStyle: TnxSqlBindingStyle;
      var aIsOuterReference: Boolean; MustSucceed: Boolean = True): TnxSqlFieldProxy;
var
  T: TnxSqlTableProxy;
  j, k, b : Integer;
  Tmp: TnxSqlFieldProxy;
  //FirstTable: integer;
  aName: string;
  aName2: String;
  DoBindDown: Boolean;
  //aParent: TnxSQLNode;
  IsValid: boolean;

  function TableRefIxBoundFrom: Integer;
  var
    i: Integer;
  begin
    if BindingNode <> nil then
      for i := 0 to TableRefList.Count - 1 do
        if TableRefList[i].IsParentTo(BindingNode) then begin
          Result := i;
          exit;
        end;
    Result := -1;
  end;

begin
  {IsValid := True;}
  aIsOuterReference := False;
  Result := nil;
  if TableName <> '' then begin
    Assert(Assigned(TablesReferencedByOrder));
    j := TablesReferencedByOrder.IndexOf(DatabaseName, TableName);
    if (j = -1) or ((TablesReferencedByOrder[j].Table<>nil) and (TablesReferencedByOrder[j].Table.Alias <> '')) then begin
      Assert(Assigned(TableAliases));
      with TableAliases do begin
        j := IndexOf(TableName);
        if j <> -1 then begin
//          B := TableRefIxBoundFrom;
{ HD: removed that check, even though it has (MINOR) regression for 1971 and 2249)
          if (BindingStyle = bsEmbedded)
          or (B <> -1) and (B <> j)
          {or (BindingStyle = bsCorrelation) and SelectionList.IsParentTo(BindingNode) then}
//            T := nil
//          else}
          {if assigned(BindingNode) and (TableRefList.Count > 1) and not TableRefList[j].IsParentTo(BindingNode) then
            T := nil
          else
          {if BindingFromSubQuery and (TableRefList.Count > 1) then
            T := nil
          else} begin
            j := Integer(Objects[j]);
            T := TablesReferencedByOrder[j].Table;
            if (T = nil) and (TablesReferencedByOrder[j].TableRef2 <> nil) then
              T := TablesReferencedByOrder[j].TableRef2.GetResultTable(Context);
          end;
          if T = nil then
            if MustSucceed then
              EInvColRef(TableName + '.' + ColumnName + SourceLoc)
            else
              exit;
        end else begin
          DoBindDown:=true;
{ HD: removed that check, even though it has (MINOR) regression for 1971 and 2249)
          if BindingStyle=bsCorrelation then
          begin
            aParent:=BindingNode;
            IsValid:=false;
            while aParent<>nil do
            begin
              if aParent is TNxSQLSelection then
                IsValid:=true;
              aParent:=aParent.Parent;
            end;
            if not IsValid then
              DoBindDown:=false;
          end;}
          if BindingStyle = bsNormal then
          begin
            IsValid:=true;
//            aParent:=BindingNode;
{ HD: removed that check, even though it has (MINOR) regression for 1971 and 2249)
            while aParent<>nil do
            begin
              aString:=aParent.ClassName+': '+aParent.ToString;
              if (aParent is TnxSqlSelection) and (aParent<>self) then
              begin
                aParent:=nil;
                IsValid:=false;
              end
              else
              begin
                if (aParent is TnxSqlSelect) and (aParent<>self) then
                begin
                  if TnxSqlSelect(aParent).TablesReferencedByOrder.FindTableRef(TableName, Context)<>nil then
                    IsValid:=false;
                end;
                aParent:=aParent.Parent;
//              end;
            end;
            }
            if not IsValid then
              DoBindDown:=false;
          end;
          if BindingDown or not (BindingStyle in [bsNormal, bsCorrelation]) then
          begin
            IsValid:=false;
            if not IsValid then
            begin
              Result := nil;
              DoBindDown:=false;
            end;
          end;
          if DoBindDown then
            try
              BindingDown := True;
              Result := TableRefList.BindToFieldWithin(Context, DatabaseName, TableName, ColumnName, SourceLoc);
            finally
              BindingDown := False;
            end;
          if Result = nil then
            if IsSubQuery then begin
              try
                IsValid:=true;
{ HD: removed that check, even though it has (MINOR) regression for 1971 and 2249)
                aParent:=BindingNode;
                while aParent<>nil do
                begin
                  if (aParent is TnxSqlSelect) and (aParent<>self) then
                  begin
                    //aParent:=nil;
                    Break;
                  end;
                  if aParent is TnxSqlTableRef then
                    if (TnxSqlTableRef(aParent).AliasStr<>'') and (TnxSqlTableRef(aParent).TableNameStr='') then
                      IsValid:=false;
                  aParent:=aParent.Parent;
                end;}

{                while aParent<>nil do
                begin
                  if (aParent is TnxSqlTableExp) and (TnxSqlTableExp(aParent).fSetTerms<>nil) and (TnxSqlTableExp(aParent).fSetTerms.Count=1) and
                    (TObject(TnxSqlTableExp(aParent).fSetTerms[0]) is TnxSqlNonJoinTableTerm) then
                  begin
                    IsValid:=false;
                    Result := Parent.BindColumn(Context, aInAggregate, TableName, ColumnName, SourceLoc, BindingNode, bsCorrelation, aIsOuterReference, False);
                    aIsOuterReference := True;
                    FIsDependent := True;
                    Break;
                  end;
                  aParent:=aParent.Parent;
                end;}

                if IsValid then
                begin
                  if ContextParent <> nil then
                    Result := ContextParent.BindColumn(Context, aInAggregate, DatabaseName, TableName, ColumnName, SourceLoc, BindingNode, bsCorrelation, aIsOuterReference, False)
                  else
                    Result := nil;
                  aIsOuterReference := True;
                  FIsDependent := True;
                  exit;
                end;
              except
                Result := nil;
              end;
            end;
          if Result = nil then
            if MustSucceed then
              EInvColRef(TableName + '.' + ColumnName + SourceLoc);
          exit;
        end;
      end;
    end else begin
      B := TableRefIxBoundFrom;
      if (B <> -1) and (B <> j) then
      {if assigned(BindingNode) then begin
        b := TableRefBoundFrom;
        if not TableRefList[j].IsParentTo(BindingNode) then}
          if MustSucceed then
            EBadCol(TableName, ColumnName + SourceLoc)
          else begin
            Result := nil;
            exit;
          end;
      {end;}
      {if BindingFromSubQuery and (TableRefList.Count > 1) then
        if MustSucceed then
          EBadCol(TableName, ColumnName + SourceLoc)
        else begin
          Result := nil;
          exit;
        end;}
      T := TablesReferencedByOrder[j].Table;
      if (T = nil) then
      begin
        if not MustSucceed then
         exit;

        // try to bind the table
        BindTable(Context, TablesReferencedByOrder[j].TableRef2.Owner, DatabaseName, TableName);
        k:=TableRefList.IndexOf(TablesReferencedByOrder[j].TableRef2);
        if k<>-1 then
        begin
          T := TableRefList[k].Table;
          TablesReferencedByOrder[j].SetTable(T);
        end;
      end;
      Assert(T <> nil, 'Table not resolved:' + TablesReferencedByOrder[j].Name + SourceLoc);
    end;
    Assert(T <> nil);
    Result := T.FieldByName(ColumnName);

    if (Result = nil) then
      if MustSucceed then
        EBadCol(TableName, ColumnName + SourceLoc);

    {if InGlobalAggregatedQuery and not aInAggregate then
      raise EnxInternalSQLException.CreateFmt('Column reference is invalid in the context of a non-grouped query:%s.%s %s',
        [TableName, ColumnName, SourceLoc]);}

    if (GroupColumnList <> nil) and (Result <> nil) and (BindingStyle = bsCorrelation) then
      if not GroupColumnList.Contains(Context, ColumnName) then
        raise EnxInternalSQLException.CreateFmt(rsCorrelatedColumnNotInGrouping,
          [TableName, ColumnName, SourceLoc]);
  end else begin
    Assert(Assigned(TablesReferencedByOrder));
    Result := nil;
    //FirstTable:=-1;
    for j := 0 to pred(TablesReferencedByOrder.Count) do begin
      T := TablesReferencedByOrder[j].Table;
      if (T <> nil) then begin
        Assert(T is TnxSqlTableProxy);
        Tmp := T.FieldByName(ColumnName);
        if (Tmp <> nil) {and not (Tmp.OwnerTable.Owner is TnxSqlJoinTableExp) }then begin
          if Tmp.OwnerTable.Owner is TnxSqlJoinTableExp then
            Tmp:=TableRefList.BindToFieldWithin(Context, DatabaseName, TableName, ColumnName, SourceLoc);
          if (Tmp <> nil) then
          if Result = nil then
          begin
            //FirstTable:=j;
            Result := Tmp
          end
          else
          begin
            if TMP.ExactReference then
              Result:=TMP
            else
            if Result.ExactReference then
              Result:=result
            else
            begin
              if Result.OwnerTable.Owner is TnxSqlJoinTableExp then
                aName:='join result'
              else
              begin
                if Result.OwnerTable.Alias<>'' then
                  aName:=Result.OwnerTable.Alias
                else
                  aName:=Result.OwnerTable.Name;
              end;
              if T.Alias<>'' then
                aName2:=T.Alias
              else
                aName2:=T.Name;
              raise EnxInternalSQLException.CreateResFmt(@rsAmbiguousColumnRef3,
                [ColumnName, aName2, aName, SourceLoc]);
            end;
          end;
        end;
        if TablesReferencedByOrder[j].TableRef2 <> nil then
          if TablesReferencedByOrder[j].TableRef2.IsAmbiguousColumn(ColumnName) then
            raise EnxInternalSQLException.CreateFmt(rsAmbiguousColumnRef4,
              [ColumnName, SourceLoc]);
      end;
    end;
    if Result <> nil then
      exit;

    if Result = nil then
      //if IsSubQuery then begin
        try
          {The following check disabled in response to issue #2324, part 2.
           Not sure why I felt it was necessary in the first place -
             the SELECT isn't typically fully bound here as this method is called from Bind.}
          {if Bound then}
          begin
            if ContextParent <> nil then
              Result := ContextParent.BindColumn(Context, aInAggregate, DatabaseName, TableName, ColumnName, SourceLoc, Self, bsCorrelation, aIsOuterReference,MustSucceed)
            else
              Result := nil;
            if Result <> nil then begin
              FIsDependent := aIsOuterReference;
              if not fIsDependent and IsSubQuery then
              begin
                IsValid:=false;
                for j := 0 to TableRefList.Count - 1 do
                  if (result.OwnerTable.Name=TableRefList[j].TableNameStr) then
                    IsValid:=true;
                if not IsValid then
                  FIsDependent:=true;
              end;

              exit;
            end;
          end;
        except
          Result := nil;
        end;
      //end;

    if MustSucceed then
      EBadCol(ColumnName + SourceLoc);
  end;
end;

function TnxSqlSELECT.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Result := TableRefList.BindTable(Context, AOwner, DatabaseName, TableName);
  finally
    snEndUse;
  end;
end;

function TnxSqlSELECT.ResolveGroupColumn(Context: TObject; Dict: TnxBaseTableDescriptor; const QualifiedName{TableName, ColumnName}: string): Integer;
var
  z, k, IX : Integer;
  Stripped, s, AliasName, ColumnName : string;
  FR : TnxSqlFieldRef;
  Fac: TnxSqlFac;
begin
  Result := -1;
  Assert(Assigned(Columns));
  Stripped := StripQuotes(QualifiedName);
  z := Columns.IndexOf(Stripped);
  if z = -1 then begin
    z := PosCh('.', QualifiedName);
    if z = 0 then begin
      S := AnsiUpperCase('.' + QualifiedName);

      z := -1;
      for k := 0 to pred(Columns.Count) do
        if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
          z := k;
          Break;
        end;

      if z = -1 then
        for k := 0 to pred(Columns.Count) do begin
          Assert(Columns[k].Info is TnxSqlSimpleExpression);
          Fac := TnxSqlSimpleExpression(Columns[k].Info).TermList[0].FactorList[0];
          if Fac is TnxSqlFacColumn then begin
            FR := TnxSqlFacColumn(Fac).FieldRef;
            AliasName := SplitStringU('.', FR.ToString, ColumnName);
            if SameText(QualifiedName, Trim(ColumnName)) then begin
              z := k;
              Break;
            end;
          end;
        end;
      if z = -1 then
        exit;

    end else begin
      z := -1;

      for k := 0 to pred(Columns.Count) do begin
        Assert(Columns[k].Info is TnxSqlSimpleExpression);
        with TnxSqlSimpleExpression(Columns[k].Info).TermList[0] do
          if FactorList[0] is TnxSqlFacColumn then begin
            FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
            if SameText(QualifiedName, Trim(FR.ToString)) then begin
              z := k;
              Break;
            end;
          end;
      end;

      if z = -1 then begin
        AliasName := SplitStringU('.', QualifiedName, ColumnName);

        Assert(Assigned(TableAliases));
        IX := TableAliases.IndexOf(AliasName);
        if IX <> -1 then begin
          IX := Integer(TableAliases.Objects[IX]);
          Assert(Assigned(TablesReferencedByOrder));
          S := TablesReferencedByOrder[IX].Name + '.' + ColumnName;

          z := -1;
          for k := 0 to Pred(Columns.Count) do begin
            Assert(Columns[K].Info is TnxSqlSimpleExpression);
            with TnxSqlSimpleExpression(Columns[K].Info).TermList[0] do
              if FactorList[0] is TnxSqlFacColumn then begin
                FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
                if Assigned(FR) and
                SameText(S, Trim(FR.ToString)) then begin
                  z := k;
                  Break;
                end;
              end;
          end;
        end else
          z := -1;
      end;

      if z = -1 then begin
        (*
        SplitString('.', QualifiedName, S);
        z := -1;
        S := AnsiUpperCase(S);
        for k := 0 to pred(Columns.Count) do
          if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
            z := k;
            Break;
          end;
        *)
        if z = -1 then
          exit;
      end;
    end;
  end;

  Result := Dict.GetFieldFromName(Columns[z].Name);
end;

function TnxSqlSELECT.BuildGroupByIndexDesc(Context: TObject; Dict: TnxBaseTableDescriptor;
  ResolveColumn: TnxSqlColumnResolver;
  const CaseSensitive, IgnoreComposites : Boolean; BuildStandalone: Boolean = true): TnxIndexDescriptor;
var
  i: Integer;
  KeyDescrip: TnxCompKeyDescriptor;
  FieldNum: Integer;
  S: string;
begin
  FOrderByScope.Clear;
  Result := TnxIndexDescriptor.CreateStandalone(0, 'GroupByIndex', 0, TnxCompKeyDescriptor);
  try
    KeyDescrip := TnxCompKeyDescriptor(Result.KeyDescriptor);
    for i := 0 to pred(GroupColumnList.Count) do begin
      S := (GroupColumnList.Item[i] as TnxSqlGroupColumn).QualifiedName(nil);
      FOrderByScope.AddColumn(S);
      FieldNum := ResolveGroupColumn(Context, Dict, S);
      if FieldNum = -1 then
        FieldNum := i;
      if Dict.FieldsDescriptor.FieldDescriptor[FieldNum].fdType in
        [nxtChar, nxtWideChar, nxtShortString, nxtNullString, nxtWideString] then begin
        TnxTextKeyFieldDescriptor(KeyDescrip.Add(FieldNum, TnxTextKeyFieldDescriptor)).
          IgnoreCase := not CaseSensitive;
      end else
        KeyDescrip.Add(FieldNum);
    end;
    Result.Dups := idAll;
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;

function Unqualified(const S: string): string;
var
  p: Integer;
begin
  p := pos('.', S);
  if p <> 0 then
    Result := copy(S, P + 1, MAXINT)
  else
    Result := S;
end;

{
function ExtractTableQual(const S: string): string;
var
  p: Integer;
begin
  p := pos('.', S);
  if p <> 0 then begin
    Result := copy(S, 1, P - 1);
    Result := trim(StripQuotes(Result));
  end else
    Result := '';
end;
}

function TnxSqlSELECT.ResolveColumn(Context: TObject; Dict: TnxBaseTableDescriptor; const QualifiedName: string): Integer;
var
  z, k, IX : Integer;
  Stripped, s, AliasName, ColumnName : string;
  FR : TnxSqlFieldRef;
  aList: TList;
  I: Integer;
  found: Boolean;
begin
  Assert(Assigned(Columns));
  z := Columns.IndexOf(StripQuotes(QualifiedName));
  if z = -1 then begin
    Stripped := StripQuotes(Unqualified(QualifiedName));
    z := -1; //Columns.IndexOf(Stripped);
    if z = -1 then begin
      z := PosCh('.', QualifiedName);
      if z = 0 then begin
        S := AnsiUpperCase('.' + QualifiedName);

        z := -1;
        for k := 0 to pred(Columns.Count) do
          if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
            z := k;
            Break;
          end;

        if z = -1 then
          EBadCol(Stripped);

      end else begin
        z := -1;

        for k := 0 to pred(Columns.Count) do begin
          Assert(Columns[k].Info is TnxSqlSimpleExpression);
          with TnxSqlSimpleExpression(Columns[k].Info).TermList[0] do
            if FactorList[0] is TnxSqlFacColumn then begin
              FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
              if SameText(QualifiedName, Trim(FR.ToString)) then begin
                z := k;
                Break;
              end;
            end;
        end;

        if z = -1 then begin
          AliasName := SplitStringU('.', QualifiedName, ColumnName);

          Assert(Assigned(TableAliases));
          IX := TableAliases.IndexOf(AliasName);
          if IX <> -1 then begin
            IX := Integer(TableAliases.Objects[IX]);
            Assert(Assigned(TablesReferencedByOrder));
            S := TablesReferencedByOrder[IX].Name + '.' + ColumnName;

            z := -1;
            for k := 0 to Pred(Columns.Count) do begin
              Assert(Columns[k].Info is TnxSqlSimpleExpression);
              with TnxSqlSimpleExpression(Columns[k].Info).TermList[0] do
                if FactorList[0] is TnxSqlFacColumn then begin
                  FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
                  if Assigned(FR) and
                  SameText(S, Trim(FR.ToString)) then begin
                    z := k;
                    Break;
                  end;
                end;
            end;
          end else
            z := -1;
        end;

        if z = -1 then begin

          if pos('.', QualifiedName)>0 then
          begin
            s:=copy(QualifiedName, 1, pos('.', QualifiedName)-1);
            aList:=TList.Create();
            try
              TableRefList.FieldListFromTable(TnxSQLContext(Context), s, aList);
              SplitString('.', QualifiedName, S);
              found:=false;
              for I := 0 to aList.Count - 1 do
                if TObject(aList[i]) is TnxSqlFieldProxy then
                  if SameText(TnxSqlFieldProxy(aList[i]).Name, s) then
                     found:=true;
              if not found then
                EBadCol(QualifiedName);
            finally
              aList.Free;
            end;
          end;

          SplitString('.', QualifiedName, S);
          z := -1;
          S := AnsiUpperCase(S);
          for k := 0 to pred(Columns.Count) do
            if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
              z := k;
              Break;
            end;
          if z = -1 then begin
            Result := Dict.GetFieldFromName(S);
            if Result <> -1 then
              exit;
            EBadCol(QualifiedName);
          end;

        end;
      end;
    end;
  end;

  Result := Dict.GetFieldFromName(Columns[z].Name);
  if Result = -1 then
    Result := Dict.GetFieldFromName(Stripped);
  if Result = -1 then begin
    z := 0;
    for k := 0 to Dict.FieldsDescriptor.FieldCount - 1 do
      if SameText(Stripped, Unqualified(Dict.FieldsDescriptor.FieldDescriptor[k].Name)) then begin
        inc(z);
        Result := k;
      end;
    if z > 1 then
      raise EnxInternalSQLException.CreateFmt(rsAmbiguousUnqualifiedColumn, [Stripped]);
  end;
  if Result = -1 then
    EBadCol(Stripped);
end;

function TnxSqlSELECT.BuildOrderByIndex(Context: TObject; Dict: TnxBaseTableDescriptor;
  ResolveColumn: TnxSqlColumnResolver;
  const CaseSensitive,IgnoreComposites : Boolean; BuildStandalone: Boolean = true): TnxIndexDescriptor;
var
  i, fieldNum : Integer;
  KeyDescrip : TnxCompKeyDescriptor;
  KeyFieldDescrip : TnxKeyFieldDescriptor;
  LocaleDescriptor : TnxLocaleDescriptor;
  OItem: TnxSqlOrderItem;
begin
  Result := TnxIndexDescriptor.CreateStandalone(0, 'OrderByIndex', 0, TnxCompKeyDescriptor);
  try
    KeyDescrip := TnxCompKeyDescriptor(Result.KeyDescriptor);
    for i := 0 to FOrderList.Count - 1 do begin
      OItem := FOrderList[i];

      if OItem.Column <> nil then begin
        FieldNum := ResolveColumn(Context, Dict, OItem.Column.QualifiedName);
        if (FieldNum < 0) or (FieldNum > Dict.FieldsDescriptor.FieldCount - 1) then
          raise EnxInternalSQLException.Create(rsCantResolveOrderColumn+ OItem.Column.QualifiedName+''' at '+OItem.Column.FieldNameLoc);
      end else begin
        FieldNum := OItem.Index - 1;
        if (FieldNum < 0) or (FieldNum > Dict.FieldsDescriptor.FieldCount - 1) then
          raise EnxInternalSQLException.Create(rsColumnIndexOutOfRange+ IntToStr(FieldNum + 1));
      end;


      if Dict.FieldsDescriptor.FieldDescriptor[FieldNum].fdType in
        [nxtChar, nxtWideChar, nxtShortString, nxtNullString, nxtWideString] then begin

        KeyFieldDescrip := KeyDescrip.Add(FieldNum, TnxExtTextKeyFieldDescriptor);
        //LocaleDescriptor := Dict.FieldsDescriptor.FieldDescriptor[FieldNum].UsedLocaleDescriptor;


        LocaleDescriptor := nil;
        try
          if Dict.FieldsDescriptor.FieldDescriptor[FieldNum].UsedLocaleDescriptor <> nil then begin
            LocaleDescriptor := TnxLocaleDescriptor.Create(nil);
            LocaleDescriptor.Assign(Dict.FieldsDescriptor.FieldDescriptor[FieldNum].UsedLocaleDescriptor);
          end;

          if Assigned(LocaleDescriptor) or (OItem.LocaleInt <> 0) or (OItem.CollationNameStr <> '') then
            with TnxExtTextKeyFieldDescriptor(KeyFieldDescrip).AddLocaleDescriptor do begin
              if (OItem.LocaleInt <> 0) or (OItem.CollationNameStr <> '') then
                Locale := OItem.GetLCID
              else begin
                if Assigned(LocaleDescriptor) then begin
                  Locale := LocaleDescriptor.Locale;
                  Flags := LocaleDescriptor.Flags;
                end else
                  if Dict.UsedLocaleDescriptor <> nil then
                    Locale := Dict.UsedLocaleDescriptor.Locale
                  else
                    Locale := Database.LCID;
              end;
              if OItem.CompareFlags <> nil then begin
                IgnoreKanaType := OItem.CompareFlags.IgnoreKanaType;
                IgnoreNonSpace := OItem.CompareFlags.IgnoreNonSpace;
                IgnoreSymbols := OItem.CompareFlags.IgnoreSymbols;
                IgnoreWidth := OItem.CompareFlags.IgnoreWidth;
                UseStringSort := OItem.CompareFlags.UseStringSort;
              end;
            end;
        finally
          if assigned(LocaleDescriptor) then
            LocaleDescriptor.Free;
        end;

        TnxTextKeyFieldDescriptor(KeyFieldDescrip).IgnoreCase := OItem.IgnoreCase;
      end else
        KeyFieldDescrip := KeyDescrip.Add(FieldNum);

      KeyFieldDescrip.Ascend := not OItem.Descending;
      KeyFieldDescrip.NullBehaviour := OItem.NullBehaviour;
    end;
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;

function TnxSqlSELECT.FindImplicitOrderByColumns: TnxFastStringListIC;
var
  i, z, k, IX: Integer;
  s, AliasName, ColumnName : string;
  FR : TnxSqlFieldRef;
  OC: TnxSqlOrderColumn;
begin
  Result := TnxFastStringListIC.Create;
  if FOrderList = nil then
    exit;
  Result.Sorted := True;
  for i := 0 to FOrderList.Count - 1 do begin
    OC := FOrderList[i].Column;
    if OC <> nil then begin
      s := OC.QualifiedName;
      Assert(Assigned(Columns));
      z := Columns.IndexOf(StripQuotes(S));
      if z = -1 then begin
        z := PosCh('.', S);
        if z = 0 then begin
          S := AnsiUpperCase('.' + S);
          z := -1;
          for k := 0 to pred(Columns.Count) do
            if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
              z := k;
              Break;
            end;

          if z = -1 then
            Result.Add(StripQuotes(OC.QualifiedName));

        end else begin
          z := -1;
          Assert(Assigned(Columns));
          for k := 0 to pred(Columns.Count) do begin
            Assert(Columns[k].Info is TnxSqlSimpleExpression);
            with TnxSqlSimpleExpression(Columns[k].Info).TermList[0] do
              if FactorList[0] is TnxSqlFacColumn then begin
                FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
                if SameText(S, Trim(FR.ToString)) then begin
                  z := k;
                  Break;
                end;
              end;
          end;
          if z = -1 then begin
            AliasName := SplitStringU('.', S, ColumnName);

            Assert(Assigned(TableAliases));
            IX := TableAliases.IndexOf(AliasName);
            if IX <> -1 then begin
              IX := Integer(TableAliases.Objects[IX]);
              Assert(Assigned(TablesReferencedByOrder));

              for k := 0 to Pred(Columns.Count) do
                if SameText(Columns[k].Name, ColumnName) then begin
                  z := k;
                  Break;
                end;

              if z = -1 then begin
                S := TablesReferencedByOrder[IX].Name + '.' + ColumnName;

                z := -1;
                Assert(Assigned(Columns));
                for k := 0 to Pred(Columns.Count) do begin
                  Assert(Columns[K].Info is TnxSqlSimpleExpression);
                  with TnxSqlSimpleExpression(Columns[K].Info).TermList[0] do
                    if FactorList[0] is TnxSqlFacColumn then begin
                      FR := TnxSqlFacColumn(FactorList[0]).FieldRef;
                      if Assigned(FR) and
                      (SameText(S, Trim(FR.ToString))
                       or SameText(ColumnName, Trim(FR.ToString))) then begin
                        z := k;
                        Break;
                      end;
                    end;
                end;
              end;
            end else
              z := -1;
          end;

          if z = -1 then begin
            (*
            SplitString('.', S, S);
            z := -1;
            Assert(Assigned(Columns));
            S := AnsiUpperCase(S);
            for k := 0 to pred(Columns.Count) do
              if pos(S, AnsiUpperCase(Columns[k].Name)) <> 0 then begin
                z := k;
                Break;
              end;

            if z = -1 then*)
              //Result.Add(S);
              Result.Add(StripQuotes(OC.QualifiedName));
          end;
        end;
      end;

    end;
  end;
end;

function TnxSqlSELECT.CheckAllValues(Context: TnxSqlContext; RelOp: TnxSqlRelOp;
  const Val: Variant): Variant;
var
  TestValue: Variant;
begin
  EnsureResultTable(Context, True, false);
  Result := Unassigned;
  if VarIsNull(Val) then exit;
  Assert(FResultTable <> nil);
  Result:=false;
  if FResultTable.First then begin
    repeat
      TestValue := Unassigned;
      TestValue := FResultTable.FirstVisibleField.GetValue;
      if VarIsNull(TestValue) then
      begin
        result:=null;
        exit;
      end;
      case RelOp of
      roEQ :
        if TestValue <> Val then
          exit;
      roLE :
        if Val > TestValue then
          exit;
      roL :
        if Val >= TestValue then
          exit;
      roG :
        if Val <= TestValue then
          exit;
      roGE :
        if Val < TestValue then
          exit;
      roNE :
        if TestValue = Val then
          exit;
      end;
    until not FResultTable.Next;
    Result := True;
  end else
    Result := true; // empty result set mans TRUE
end;

function TnxSqlSELECT.CheckAnyValue(Context: TnxSqlContext; RelOp: TnxSqlRelOp;
  const Val: Variant): Variant;
Var
  TestValue: Variant;
  AllNull: Boolean;
begin
  EnsureResultTable(Context, True, False);
  Result := True;
  AllNull := False;
  if FResultTable.First then
    repeat
      AllNull := True;
      TestValue := Unassigned;
      TestValue := FResultTable.FirstVisibleField.GetValue;
      if not varisnull(TestValue) then begin
        AllNull := False;
        case RelOp of
        roEQ :
          if TestValue = Val then
            exit;
        roLE :
          if Val <= TestValue then
            exit;
        roL :
          if Val < TestValue then
            exit;
        roG :
          if Val > TestValue then
            exit;
        roGE :
          if Val >= TestValue then
            exit;
        roNE :
          if TestValue <> Val then
            exit;
        end;
      end;
    until not FResultTable.Next;
  if AllNull then
    Result := null
  else
    Result := False;
end;

type
  PValueScanData = ^TValueScanData;
  TValueScanData = record
    ValueToFind: OleVariant;
    F: TnxSqlFieldProxy;
    NeedToTrim: boolean;
    Found: Boolean;
  end;

function TnxSqlSELECT.ScanForValue(Cookie: Pointer): Boolean;
var
  V: Variant;
begin
  with PValueScanData(Cookie)^ do begin
    V := F.GetValue;
    if NeedToTrim and (f.Descriptor.fdType=nxtNullstring) then
      V:=Trim(v);

    if nxVarCmp({TVarData(}ValueToFind{)}, {TVarData(}V{)}, F.GetLocale, F.GetLocaleFlags) = VAR_CMP_EQ then begin
      Found := True;
      Result := False; {Break iterate loop}
      exit;
    end;
  end;
  Result := True; {continue}
end;


function TnxSqlSELECT.CheckForValue(Context: TnxSqlContext; const Value: Variant; aPadSpace: Boolean): Boolean;
var
  ValueScanData: TValueScanData;
//  anIndexEngine: TnxBaseIndexEngine;
  CheckField: Integer;
  I: Integer;
//  aBuffer: TnxDynByteArray;
//  aRecordBuffer: PnxRecordBuffer;
begin
  if VarIsNull(Value) then
    Result := False
  else begin
    EnsureResultTable(Context, True, False);
    CheckField:=-1;
    for I := 0 to FResultTable.FieldCount - 1 do
      if FResultTable.FieldList[i].Descriptor.fdNoClientAccess=false then begin
        if CheckField<>-1 then
          raise EnxInternalSQLException.Create(rsSingleColumnQueryExpected)
        else
          CheckField:=i;
      end;
    if CheckField=-1 then
      raise EnxInternalSQLException.Create(rsSingleColumnQueryExpected);
    if Volatile(Context) then begin
      ValueScanData.Found := False;
      ValueScanData.F := FResultTable.FieldNC(CheckField);
      ValueScanData.NeedToTrim:=aPadSpace or ((ValueScanData.F.Descriptor.fdType=nxtNullstring) and (ValueScanData.F.Descriptor.fdDecPl<>0));
      if aPadSpace and (ValueScanData.F.Descriptor.fdType=nxtNullstring) then
        ValueScanData.ValueToFind := Trim(Value)
      else
        ValueScanData.ValueToFind := Value;
      FResultTable.Iterate(ScanForValue, @ValueScanData);
      Result := ValueScanData.Found;
    end else begin
      assert(FResultTable.FieldList[CheckField] is TnxSqlFieldProxy);
      Result := FResultTable.Cursor.sacHasKey(TnxSqlFieldProxy(FResultTable.FieldList[CheckField]).Index, Value);
    end;
  end;
end;

function TnxSqlSELECT.CheckNonEmpty(Context: TnxSqlContext) : Boolean;
begin
  EnsureResultTable(Context, True, True);
  Result := FResultTable.First;
end;

function TnxSqlSELECT.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlSELECT.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlSELECT.ClearTableList;
var
  i : Integer;
begin
  if TablesReferencedByOrder <> nil then begin
    for i := 0 to pred(TablesReferencedByOrder.Count) do
      with TablesReferencedByOrder[i] do
      begin
        if (Table<>nil) then
          if (Table.Owner=self) then
            Table.Owner:=TablesReferencedByOrder[i];
        SetTable(nil);
      end;
    TablesReferencedByOrder.Clear;
  end;
  if TableAliases <> nil then
    TableAliases.Clear;
  Bound := -1;
  BoundGen := -1;
end;

procedure TnxSqlSELECT.Clear;
begin
  snBeginUse;
  try
    ClearTableList;

    nxFreeAndNil(FSelectionList);
    nxFreeAndNil(FTableRefList);
    nxFreeAndNil(FCondExpWhere);
    nxFreeAndNil(FGroupColumnList);
    nxFreeAndNil(FCondExpHaving);
    nxFreeAndNil(FOrderList);
  finally
    snEndUse;
  end;
end;

constructor TnxSqlSELECT.Create(AParent: TnxSqlNode);
begin
  inherited;
  fSetRangeCount:=0;
  fFirstSimplify:=true;
  fResultTable:=nil;
//  fRealTableOrder:=TnxFastStringListIC.Create;
  TablesAdded:=TList.Create;
  TablesReferencedByOrder := TnxInternalTableRefList.Create;
  //TnxFastStringListIC.Create;
  TableAliases := TnxFastStringListIC.Create;
  TableAliases.Sorted := True;
  TableAliases.Duplicates := dupError;
  FOrderByScope := TnxSqlOrderByScope.Create;
  LimitInt := -1;
  LimitStart := -1;
  FixedLimitInt := -1;
  FixedLimitStart := -1;
end;

function TnxSqlSELECT.DependsOn(Table: TnxSqlTableProxy; Context: TnxSqlContext): Boolean;
begin
  snBeginUse;
  try
    if Bound < 1 then
      Bind(False, Context);
    Result :=
      ((CondExpWhere <> nil) and CondExpWhere.DependsOn(Context, Table))
    or ((CondExpHaving <> nil) and CondExpHaving.DependsOn(Context, Table));
  finally
    snEndUse;
  end;
end;

destructor TnxSqlSELECT.Destroy;
begin
  snBeginUse;
  try
    if Assigned(ssRequestClose) then
      ssRequestClose.Disconnect;

    nxFreeAndNil(FOrderByScope);
    Unbind;
    Clear;
    nxFreeAndNil(TablesReferencedByOrder);
    nxFreeAndNil(TableAliases);
  //  nxFreeAndNil(fRealTableOrder);
    nxFreeAndNil(TablesAdded);
    if FResultTable <> nil then begin
      FResultTable.Owner := nil;
      nxFreeAndNil(FResultTable);
    end;
    nxFreeAndNil(fSelectionList);
    nxFreeAndNil(fOrigSelectionList);
    nxFreeAndNil(fLimitIntFactor);
    nxFreeAndNil(fLimitIntExp);
    nxFreeAndNil(fLimitStartFactor);
    nxFreeAndNil(fLimitStartExp);
  finally
    snEndUse;
  end;
  inherited;
end;

{function TnxSqlSELECT.CheckHaving(Context: TObject): Boolean;
begin
  Result := CondExpHaving.AsBoolean(TnxSqlContext(Context)) = tsbTrue;
end;}

function TnxSqlSELECT.DoAggOrderBy(Context: TObject; T: TnxSqlTableProxy; const NeedData : Boolean): TnxSqlTableProxy;
var
  Status : TnxResult;
begin
  Result := T;
  if (FOrderList <> nil) and NeedData then begin
    Status := Result.Sort(Context, BuildOrderByIndex, ResolveColumn, False, False);
    if Status <> DBIERR_NONE then
      raise EnxSqlException.nxCreate(Status);
  end;
end;

function TnxSqlSELECT.BuildGroupingTable(Context: TnxSqlContext; GroupColumnsIn : Integer;
  SourceFields: TList; AggList: TnxSqlAggregateList; var aFieldDefList: TnxSqlFieldDefList): TnxSqlTableProxy;
var
  i: Integer;
  Co : TnxSqlGroupColumn;
  F : TnxSqlFieldProxy;
  Ag : TnxSqlAggregate;
  FldType : TnxFieldType;
  {IsAggregate: Boolean;}
  B: Boolean;
  Qual: string;
begin
  aFieldDefList := TnxSqlFieldDefList.Create;
  for i := 0 to pred(GroupColumnsIn) do begin
    Co := GroupColumnList[i] as TnxSqlGroupColumn;
    if (co.TableNameStr<>'') and (TablesReferencedByOrder.FindTableRef('', co.TableNameStr, Context)=nil) then
      raise EnxInternalSQLException.Create(Format(rsGroupingFieldReferencesInvalidTable, [Co.ToString]));
    F := BindColumn(Context, False, '', Co.TableNameStr, Co.FieldNameStr, Co.FieldNameLoc, nil, bsNormal, B, True);
    if f=nil then
      EInvColRef(Co.TableNameStr + '.' + Co.FieldNameStr + Co.FieldNameLoc);

    SourceFields.Add(F);
    Qual := ValidColumnName(Co.QualifiedName(Context));
    if not aFieldDefList.FieldExists(Qual) then
      aFieldDefList.AddField(
        Qual,
        '',
        F.GetType,
        F.GetSize,
        F.GetDecimals, 1, 1,
        False, dtNull, null, [aaClient, aaServer], True, False, False, False, nil, False)
    else
      raise EnxInternalSQLException.Create(rsDuplicateGroupByItem+ValidColumnName(Co.QualifiedName(Context)));
  end;

  SelectionList.Traverse(EnumAggregates, AggList, False);
  if CondExpHaving <> nil then
    CondExpHaving.Traverse(EnumAggregates, AggList, False);

  for i := 0 to AggList.Count - 1 do begin
    Ag := AggList[i];
    if Ag.SimpleExpression <> nil then begin
      FldType := Ag.SimpleExpression.GetType(Context);
      if not Ag.ValidType(FldType) then
        raise EnxInternalSQLException.CreateFmt(rsAggregateFunctionRequiresNumericExpression,
                                  [AgString[Ag.AgFunction]]);

      if Ag.AgFunction = agAvg then
        aFieldDefList.AddField(
          ValidColumnName(Ag.GetTitle(True) + '$' + IntToStr(i)),
          '', nxtDouble, 0, 2, 1, 1, False, dtNull,null{ nil}, [aaClient, aaServer], True, False, False, False, nil, true)
      else
        aFieldDefList.AddField(
          ValidColumnName(Ag.GetTitle(True) + '$' + IntToStr(i)),
          '', FldType,
          Ag.SimpleExpression.GetSize(Context),
          Ag.SimpleExpression.GetDecimals(Context), 1, 1,
          False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, true)
    end
    else
      aFieldDefList.AddField(
        ValidColumnName(Ag.GetTitle(True) + '$' + IntToStr(i)),
        '', nxtDouble, 0, 0, 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, true);

  end;

  DoCheckValidSelection(Context);

  Result := Database.CreateTemporaryTableWithoutIndex(Self,
    aFieldDefList);
  Result.DebugComment := 'grouping table for "' + ToString + '"';
end;

function TnxSqlSELECT.BuildAggResultTable(Context: TnxSqlContext; AggList: TnxSqlAggregateList): TnxSqlTableProxy;
var
  FieldDefList: TnxSqlFieldDefList;
  i: Integer;
  Ag : TnxSqlAggregate;
  FldType : TnxFieldType;
begin
  FieldDefList := TnxSqlFieldDefList.Create;
  try
    for i := 0 to AggList.Count - 1 do begin
      Ag := AggList[i];
      if Ag.SimpleExpression <> nil then begin
        FldType := Ag.SimpleExpression.GetType(Context);
        if not Ag.ValidType(FldType) then
          raise EnxInternalSQLException.CreateFmt(rsAggregateFunctionRequiresNumericExpression,
                                    [AgString[Ag.AgFunction]]);
        if Ag.AgFunction = agAvg then
          FieldDefList.AddField(
            Ag.GetTitle(True) + '$' + IntToStr(i),
            '', nxtDouble, 0, 2, 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False)
        else
          FieldDefList.AddField(
            Ag.GetTitle(True) + '$' + IntToStr(i),
            '', FldType,
            Ag.SimpleExpression.GetSize(Context),
            Ag.SimpleExpression.GetDecimals(Context), 1, 1,
            False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False)
      end
      else
        FieldDefList.AddField(
          Ag.GetTitle(True) + '$' + IntToStr(i),
          '', nxtDouble, 0, 0, 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);

    end;

    Result := Database.CreateTemporaryTableWithoutIndex(Self,
      FieldDefList);
  finally
    nxFreeAndNil(FieldDefList);
  end;
end;

procedure TnxSqlSELECT.DoCheckValidSelection;
var
  i: Integer;
  Selection : TnxSqlSelection;
begin
  for i := 0 to SelectionList.Count - 1 do begin
    Selection := SelectionList[i];
    Selection.GetType(Context);
    if not Selection.IsAggregateExpression(True) then
      if Selection.IsColumnRefExpr then
      begin
        if Columns[i].FieldRef.FunctionRef<>nil then
        begin
        end
        else
          if ((GroupColumnList <> nil) and (not GroupColumnList.Contains(Context, Columns[i].FieldRef.FieldNameStr))) then
            SQLError(rsColumnReferencesMustBeGroupedOrAggregate + trim(Selection.ToString) + '"');
      end
      else if (Selection.FSimpleExpression<>nil) and (Selection.FSimpleExpression.TermList[0].FactorList[0].IsCorrelatedSubquery(Context)) then
        SQLError(rsSelectionMustBeColumnReferenceOrAggregate + trim(Selection.ToString) + '"');
  end;
end;

procedure TnxSqlSELECT.DoCheckAggregates;
var
  i: Integer;
  Selection : TnxSqlSelection;
  {SeenAgg: Boolean;}
begin
  InGlobalAggregatedQuery := Flag;
  try
    {SeenAgg := False;}
    for i := 0 to SelectionList.Count - 1 do begin
      Selection := SelectionList[i];
      Selection.GetType(Context);
      if not Selection.IsAggregateExpression(True) then
        if Selection.IsColumnRefExpr then
        begin
          if ((GroupColumnList = nil) or (not GroupColumnList.Contains(Context, Columns[i].FieldRef.FieldNameStr))) then
             SQLError(rsColumnReferencesMustBeGroupedOrAggregate + trim(Selection.ToString) + '"');
        end;
    end;
  finally
    InGlobalAggregatedQuery := False;
  end;
end;


procedure TnxSqlSELECT.Rebind(Node: TnxSqlNode; UserData: TObject);
var
  F, F2: TnxSqlFieldProxy;
  i, j: Integer;
  Found: Boolean;
  aTTable: TnxSqlTableProxy;
begin
  if Node is TnxSqlSELECT then
    with PRebindInfo(UserData)^ do
      if TnxSqlSELECT(Node).Bound < 1 then
        TnxSqlSELECT(Node).Bind(False, Context);
  if Node is TnxSqlFieldRef then
    with PRebindInfo(UserData)^, TnxSqlFieldRef(Node) do begin
      {if not IsOwnedByAggregate then} begin
        aTTable:=TargetTable;
        F := GetField(Context);
        if F <> nil then begin
          if not IsOwnedByAggregate or IsOuterReference(Context) then begin
            Found := False;
            if GroupFieldList <> nil then
              for i := 0 to GroupFieldList.Count - 1 do
              begin
                assert(TObject(GroupFieldList[i]) is TnxSqlFieldProxy);
                if TnxSqlFieldProxy(GroupFieldList[i]) = F then begin
                  F2 := aTTable.FieldByName(F.Name);
                  if F2 = nil then begin
                    for j := 0 to aTTable.FieldCount - 1 do begin
                      if SameText(aTTable.FieldNC(j).Name,
                        TnxSqlFieldRef(Node).TableNameStr + '.' + F.Name)
                      or SameText(aTTable.FieldNC(j).Name,
                        F.OwnerTable.Alias + '.' + F.Name)
                      or ((TnxSqlFieldRef(Node).TableNameStr = '')
                        and SameText(Unqualified(aTTable.FieldNC(j).Name), F.Name)) then begin
                        F2 := aTTable.FieldNC(j);
                        Break;
                      end;
                    end;
                    if F2 = nil then begin
                      if TableNameStr<>'' then
                        F2 := aTTable.FieldByName(TableNameStr+'.'+FieldNameStr)
                      else
                        F2 := aTTable.FieldByName(FieldNameStr)
                    end;
                  end;
                  if assigned(F2) then begin
                    ReboundFieldRefs.Add(Node);
                    OldField.Add(F);
                    SetField(F2);
                    Found := True;
                    Break;
                  end;
                end;
              end;
            if not Found and (OwnerSelect = Self) and not IsOuterReference(Context) then
              raise EnxInternalSQLException.CreateFmt(rsColumnReferenceMustBeInGroupingOrAggregate,
               [F.Name]);
          end;
        end;
      end;
    end;
end;

function IsStarSelection(const S: string): Boolean;
begin
  Result := (trim(S) = '*') or (pos('.*', S) <> 0);
end;

type
  PGrouperData = ^TGrouperData;
  TGrouperData = record
    SourceFields: array of TnxSqlFieldProxy;
    LastValues: InxVariantList;
    IsFirst: Boolean;
    HaveGroup: Boolean;
    SourceFieldCount: Integer;
    PrevBuffer: PnxRecordBuffer;
    Source: TnxSqlTableProxy;
    Target: TnxSqlTableProxy;
    Context: TnxSqlContext;
    GroupCounter: Integer;
    AggExpList: TList;
    AggList: TnxSqlAggregateList;
    Counter: Integer;
  end;

procedure TnxSqlSELECT.WriteGroup(Cookie: Pointer);
var
  i : Integer;
  v : Variant;
begin
  with PGrouperData(Cookie)^ do begin
    if (CondExpHaving = nil)
    or (CondExpHaving.AsBoolean(Context) = tsbTrue) then begin
      inc(GroupCounter);
      Target.Insert;
      for i := 0 to AggExpList.Count - 1 do begin
        v := Unassigned;
        v := TnxSqlSimpleExpression(AggExpList.List[i]).GetValue(Context);
        Target.FieldNC(i).SetValue(v);
      end;
      Target.Post;
    end;
    for i := 0 to AggList.Count - 1 do
      AggList[i].ResetCounters;
  end;
end;

function TnxSqlSELECT.Grouper(Cookie: Pointer): Boolean;
var
  i: Integer;
  v1, v2: Variant;
  NewGroup: Boolean;
  F: TnxSqlFieldProxy;
begin
  with PGrouperData(Cookie)^ do begin

    if IsFirst then begin
      IsFirst := False;
      NewGroup := True;
    end else begin
      NewGroup := False;
      for i := 0 to SourceFieldCount - 1 do begin
        v1 := Unassigned;
        v1 := SourceFields[i].GetValue; //Source.FieldNC(i).GetValue;
        v2 := Unassigned;
        v2 := LastValues.GetValueFast(i);
        if nxVarCmp2({TVarData(}V1, {TVarData(}V2, SourceFields[i].GetLocale, SourceFields[i].GetLocaleFlags) <> VAR_CMP_EQ then begin
        //if v1 <> v2 then begin
          NewGroup := True;
          Break;
        end;
      end;
    end;
    if NewGroup then begin
      if HaveGroup then begin
        PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);
        try
          //Source.Prior;
          WriteGroup(Cookie);
        finally
          PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);
        end;
        //Source.Next;
        //Source.SwapRecordBuffer(TmpBuffer);
      end;
      for i := 0 to SourceFieldCount - 1 do begin
        v1 := Unassigned;
        F := Source.FieldNC(i);
        v1 := F.GetValue;
        LastValues.SetValue(i, v1, F.GetLocaleDesc);
      end;
      HaveGroup := True;
    end;

    for i := 0 to AggList.Count - 1 do
      AggList[i].Update(Context);

    PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);

    Inc(Counter);
    if Counter mod 4096 = 0 then
      nxCheckRemainingTime;

  end;
  Result := True; {continue}
end;

function TnxSqlSELECT.CopyGrouped(T: TnxSqlTableProxy; Context: TnxSqlContext;
  SourceFields: TList; AggExpList: TList; AggList: TnxSqlAggregateList;
  aFieldDefList: TnxSqlFieldDefList{; var Mapping: TList}): TnxSqlTableProxy;
var
  FieldDefList: TnxSqlFieldDefList;
  i: Integer;
  N : TnxSqlNode;
  T2 : TnxSqlTableProxy;

  procedure DoCopyGrouped(const Source, Target: TnxSqlTableProxy;
    GroupColumnsOut, NonGroupColumns: Integer;
    const AggExpList: TList);

  var
    //i,
    //Counter, GroupCounter        : Integer;
    //IsFirst, HaveGroup, NewGroup : Boolean;
    LastValues                   : InxVariantList;
//    v                            : Variant;

    (*
    procedure WriteGroup;
    var
      i : Integer;
    begin
      if (CondExpHaving = nil)
      or (CondExpHaving.AsBoolean(Context) = tsbTrue) then begin
        inc(GroupCounter);
        Target.Insert;
        for i := 0 to AggExpList.Count - 1 do begin
          v := Unassigned;
          v := TnxSqlSimpleExpression(AggExpList.List[i]).GetValue(Context);
          Target.FieldNC(i).SetValue(v);
        end;
        Target.Post;
      end;
      for i := 0 to AggList.Count - 1 do
        AggList[i].ResetCounters;
    end;
    *)

  var
//    Locale: TnxLocaleDescriptor;
//    v1, v2: Variant;
    RebindInfo: TRebindInfo;
    //PrevBuffer: PnxByteArray;
    Tmp: PnxRecordBuffer;
    GrouperData: TGrouperData;
    i: Integer;
  begin
    GrouperData.GroupCounter := 0;
    //GroupCounter := 0;
    try
      Database.StartTransaction([nil], False, True);
      try
        //Counter := 0;
        //IsFirst := True;
        //HaveGroup := False;
        LastValues := CreateVariantList(SourceFields.Count);
        for i := 0 to AggList.Count - 1 do
          AggList[i].CreateCounter(Source.FieldNC(i + SourceFields.Count));

        {re-bind group references}

        RebindInfo.TargetTable := Source{Target};
        RebindInfo.GroupFieldList := SourceFields;
        RebindInfo.Context := Context;
        RebindInfo.ReboundFieldRefs := TList.Create;
        RebindInfo.OldField := TList.Create;

        try
          for i := 0 to AggExpList.Count - 1 do begin
            Assert(TObject(AggExpList.List[i]) is TnxSqlSimpleExpression);
            TnxSqlSimpleExpression(AggExpList.List[i]).Traverse(Rebind, @RebindInfo, True);
          end;

          if CondExpHaving <> nil then
            CondExpHaving.Traverse(Rebind, @RebindInfo, True);

          //nxGetmem(PrevBuffer, Source.RecordLen);

          SetLength(GrouperData.SourceFields, SourceFields.Count);
          for i := 0 to SourceFields.Count - 1 do
            GrouperData.SourceFields[i] := Source.FieldNC(i);
          GrouperData.LastValues := LastValues;
          GrouperData.IsFirst := True;
          GrouperData.HaveGroup := False;
          GrouperData.SourceFieldCount := SourceFields.Count;
          nxGetmem(GrouperData.PrevBuffer, Source.RecordLen + SizeOf(Pointer));
          Tmp := GrouperData.PrevBuffer;
          GrouperData.Source := Source;
          GrouperData.Target := Target;
          GrouperData.Context := Context;
          GrouperData.AggExpList := AggExpList;
          GrouperData.AggList := AggList;
          GrouperData.Counter := 0;

          Source.Iterate(Grouper, @GrouperData, False, True);

          (*
          Source.First;
          while not Source.EOF do begin
            if IsFirst then begin
              IsFirst := False;
              NewGroup := True;
            end else begin
              NewGroup := False;
              for i := 0 to pred(SourceFields.Count) do begin
                v1 := Unassigned;
                v1 := Source.FieldNC(i).GetValue;
                v2 := Unassigned;
                v2 := LastValues.GetValue(i, Locale);
                if v1 <> v2  then begin
                  NewGroup := True;
                  Break;
                end;
              end;
            end;
            if NewGroup then begin
              if HaveGroup then begin
                PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);
                //Source.Prior;
                WriteGroup;
                PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);
                //Source.Next;
                //Source.SwapRecordBuffer(TmpBuffer);
              end;
              for i := 0 to SourceFields.Count - 1 do begin
                v1 := Unassigned;
                v1 := Source.FieldNC(i).GetValue;
                LastValues.SetValue(i, v1, Source.FieldNC(i).GetLocaleDesc);
              end;
              HaveGroup := True;
            end;

            for i := 0 to AggList.Count - 1 do
              AggList[i].Update(Context);

            PrevBuffer := Source.SwapRecordBuffer(PrevBuffer);

            Inc(Counter);
            if Counter mod 4096 = 0 then
              nxCheckRemainingTime;

            Source.Next;

          end;
          *)

          GrouperData.PrevBuffer := Source.SwapRecordBuffer(GrouperData.PrevBuffer);
          try
            if GrouperData.HaveGroup { or (SourceFields.Count = 0) never true any more} then
              WriteGroup(@GrouperData);
          finally
            if GrouperData.PrevBuffer <> Tmp then
              GrouperData.PrevBuffer := Source.SwapRecordBuffer(GrouperData.PrevBuffer);
          end;
          nxFreeMem(GrouperData.PrevBuffer);
          for i := 0 to AggList.Count - 1 do
            AggList[i].DeleteCounter;
        finally
          for i := 0 to RebindInfo.ReboundFieldRefs.Count - 1 do
          begin
            assert(TObject(RebindInfo.OldField[i]) is TnxSqlFieldProxy);
            TnxSqlFieldRef(RebindInfo.ReboundFieldRefs[i]).SetField(TnxSqlFieldProxy(RebindInfo.OldField[i]));
          end;
          nxFreeAndNil(RebindInfo.ReboundFieldRefs);
          nxFreeAndNil(RebindInfo.OldField);
        end;
        Database.Commit;
      except
        Database.AbortTransaction;
        raise;
      end;
    finally
      //nxFreeAndNil(LastValues);
      LastValues := nil;
    end;
    if NormalLogging then
      LogNormal('Groups written:' + IntToStr(GrouperData.GroupCounter));
  end;

{var}
  {F: TnxSqlFieldProxy;}
  {j: Integer;}
  {TableQual,
  UColumnTitle,
  ColumnTitle: string;}
var
  S: DWord;
  Col: TnxColumn;
  Name: string;
begin
  if VerboseLogging then
    LogVerbose('Grouping result');
  S := GetTickCount;
  {Mapping := TList.Create;}
  FieldDefList := TnxSqlFieldDefList.Create;
  try
    Assert(Assigned(Columns));
    for i := 0 to pred(Columns.Count) do begin
      Col := Columns[i];
      Name := Col.Name;
      N := TnxSqlNode(Col.Info);
      AggExpList.Add(N);
      if not FieldDefList.FieldExists(Name) then begin
        FieldDefList.AddField(Name, '',
         N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null, [aaClient, aaServer], True, False, False, False, nil, False);
        //Mapping.Add(Pointer(i));
      end;
    end;
    T2 := Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
  finally
    nxFreeAndNil(FieldDefList);
  end;

  try
    DoCopyGrouped(
      T,
      T2,
      SourceFields.Count,
      Columns.Count - SourceFields.Count + 0{HiddenCount},
      AggExpList);
  except
    T2.Owner := nil;
    T2.Free;
    raise;
  end;
  T.Owner := nil;
  nxFreeAndNil(T);
  Result := T2;
  {$IFOPT Q+}
    {$DEFINE LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS OFF}
  {$ENDIF}
  if NormalLogging then
    LogNormal('Elapsed (grouping):' + IntToStr(GetTickCount - S));
  {$IFDEF LocalOverflowCheckOFF}
    {$OVERFLOWCHECKS ON}
    {$UNDEF LocalOverflowCheckOFF}
  {$ENDIF}
end;

type
  TCalcAggIteratorData = record
    AggListCount_1: Integer;
    Counter: Integer;
    Context: TnxSqlContext;
    AggArray: array of TnxSqlAggregate;
  end;
  PCalcAggIteratorData = ^TCalcAggIteratorData;

function TnxSqlSELECT.CalcAggIterator(aCookie: Pointer): Boolean;
var
  i: Integer;
begin
  with PCalcAggIteratorData(aCookie)^ do begin
    for i := 0 to AggListCount_1 do
      AggArray[i].Update(Context);

    Inc(Counter);
    if Counter mod 1024 = 0 then
      nxCheckRemainingTime;
  end;
  Result := True; {continue}
end;

function TnxSqlSELECT.CalcAggregates(T: TnxsqlTableProxy; Context: TnxSqlContext; AggList: TnxSqlAggregateList): TnxsqlTableProxy;
var
  FieldDefList: TnxSqlFieldDefList;
  i, c: Integer;
  N : TnxSqlNode;
  //Counter: Integer;
  AggExpList: TList;
  v: Variant;
  CalcAggIteratorData: TCalcAggIteratorData;
  TmpAgg: TnxSqlAggregate;
begin
  AggExpList := TList.Create;
  try
    FieldDefList := TnxSqlFieldDefList.Create;
    try
      Assert(Assigned(Columns));
      for i := 0 to pred(Columns.Count) do begin
        N := TnxSqlNode(Columns[i].Info);
        case N.GetType(Context) of
        nxtCurrency..nxtDateTime, nxtBcd, nxtFmtBcd,
        nxtBoolean..nxtWideChar,
        nxtShortString..nxtWideString :
          FieldDefList.AddField(Columns[i].Name, '', N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
        nxtByte, nxtWord16, nxtWord32,
        nxtInt8, nxtInt16, nxtInt32,
        nxtInt64, nxtAutoInc, nxtRecRev, nxtRefNr :
          FieldDefList.AddField(Columns[i].Name, '', nxtInt64, N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
        else
          FieldDefList.AddField(Columns[i].Name, '', N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
          (*
          case AggList[i].AgFunction of
          agCount :
            FieldDefList.AddField(Columns[i].Name, '', nxtInt64, 8, 0, 1, 1, False, dtNull, null{nil}, False, nil);
          agMin,
          agMax :
            FieldDefList.AddField(Columns[i].Name, '', N.GetType(Context), N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, False, nil);
          else
            FieldDefList.AddField(Columns[i].Name, '', nxtDouble, 8, N.GetDecimals(Context), 1, 1, False, dtNull, null{nil}, False, nil);
          end;
          *)
        end;
        AggExpList.Add(N);
      end;

      Result := Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      nxFreeAndNil(FieldDefList);
    end;

    Database.StartTransaction([nil], False, True);
    try
      c := AggList.Count;
      CalcAggIteratorData.AggListCount_1 := c - 1;
      CalcAggIteratorData.Counter := 0;
      CalcAggIteratorData.Context := Context;
      SetLength(CalcAggIteratorData.AggArray, c);
      for i := 0 to c - 1 do begin
        TmpAgg := AggList[i];
        TmpAgg.CreateCounter(T.FieldNC(i));
        CalcAggIteratorData.AggArray[i] := TmpAgg;
      end;
      T.Iterate(CalcAggIterator, @CalcAggIteratorData);

      (*
      Counter := 0;
      for i := 0 to AggList.Count - 1 do
        AggList[i].CreateCounter(T.FieldNC(i));

      T.First;
      while not T.EOF do begin
        for i := 0 to AggList.Count - 1 do
          AggList[i].Update(Context);
        T.Next;

        Inc(Counter);
        if Counter mod 1024 = 0 then
          nxCheckRemainingTime;
      end;
      *)

      Result.Insert;
      for i := 0 to AggExpList.Count - 1 do begin
        v := Unassigned;
        v := TnxSqlSimpleExpression(AggExpList.List[i]).GetValue(Context);
        Result.FieldNC(i).SetValue(v);
      end;
      Result.Post;

      for i := 0 to AggList.Count - 1 do
        AggList[i].DeleteCounter;
      Database.Commit;
    except
      Database.AbortTransaction;
      raise;
    end;

    T.Owner := nil;
    nxFreeAndNil(T);
  finally
    nxFreeAndNil(AggExpList);
  end;
end;

(*
function TnxSqlSELECT.DoHaving(T: TnxSqlTableProxy; Context: TnxSqlContext): TnxSqlTableProxy;
var
  T2 : TnxSqlTableProxy;
begin
  Result := T;
  if CondExpHaving <> nil then begin
    {CondExpHaving.BindHaving(Result, Context);}
    CondExpHaving.Traverse(ResetStatic, Context, False);
    T2 := Result.CopyValidated(Context, Self, CheckHaving, CopyBlobs);
    Result.Owner := nil;
    nxFreeAndNil(Result);
    Result := T2;
  end;
end;*)

procedure TnxSqlSELECT.DoOrderBy(Context: TObject; Table: TnxSqlTableProxy);
var
  Status : TnxResult;
begin
  if fOrderlist=nil then
    exit;
  if (RowBuilder = nil) or (RowBuilder.SortedState <> ssOrdered) then
    if (RowBuilder.SortedState = ssReversed) and (RowBuilder.ReadReversed) then begin
      {we are good}
    end else if FOrderList <> nil then begin
      LogNormal('No existing index that matched the ORDER BY clause was found - sorting results');
      Status := Table.Sort(Context, BuildOrderByIndex, ResolveColumn, False, False);
      if Status <> DBIERR_NONE then
        raise EnxSqlException.nxCreate(Status);
    end;
end;

function TnxSqlSELECT.OnlyStraightAggregates(AggList: TnxSqlAggregateList): Boolean;
var
  i: Integer;
//  TableName, ColumnName: string;
  N : TnxSqlNode;
begin
  Result := True;
  (*
  for i := 0 to AggList.Count - 1 do begin
    *
    if AggList[i].Distinct then
      case AggList[i].AgFunction of
      agMin, agMax :
        //A DISTINCT request on MIN and MAX is ignored;
      else
        Result := False;
        exit;
      end;
    *

    with AggList[i] do
      if (SimpleExpression <> nil)
      and not SimpleExpression.IsColumn(TableName, ColumnName) then begin
        Result := False;
        exit;
      end;

  end;
  *)
  for i := 0 to pred(Columns.Count) do begin
    N := TnxSqlNode(Columns[i].Info);
    if not (N is TnxSqlSimpleExpression)
    or not TnxSqlSimpleExpression(N).IsPureAggregateExpression then begin
      Result := False;
      exit;
    end;
  end;
end;

{function} procedure TnxSqlSELECT.DoSortOnAll(T: TnxSqlTableProxy){: TnxSqlTableProxy};
var
  Tmp: TnxSqlTableProxy;
begin
  Tmp := T.CopySortedOnAllFields(Self);
  T.TransplantCursorFrom(Tmp);
  {T.Owner := nil;
  nxFreeAndNil(T);}
end;

function TnxSqlSELECT.DoWork(Context: TnxSqlContext; NeedData: Boolean; var RecordsRead: Integer;
  Recycle: TnxSqlTableProxy; QuitAfterFirst: Boolean): TnxSqlTableProxy;
var
//  anAgg: TNxSQLAggregateList;
  NeedToGroup: boolean;
  I: Integer;
//  I: Integer;
begin
  Result := nil; {to satisfy the compiler}
  snBeginUse;
  try
    if Bound < 1 then
      Bind(False, Context);

    if (CondExpHaving <> nil) or HaveAggregates or (GroupColumnList <> nil) then begin
      if GroupColumnList <> nil then begin
        {if Recycle <> nil then begin
          Recycle.Owner := nil;
          nxFreeAndNil(Recycle);
        end;}
        NeedToGroup:=true;

(*        if not HaveAggregates then
        begin
          if (GroupColumnList<>nil) and (GroupColumnList.Count = Columns.Count) then
          begin
            NeedToGroup:=false;
            Distinct:=true;
            for I := 0 to GroupColumnList.Count - 1 do    // Iterate
            begin

{              Hannes, you can't really do this.
              TnxColumn(Columns[i]).Name refers to the column alias.
              Column aliases are invisible to the group by list, so any
              equality among items in the group by list and a column alias is incidental and
              must always evaluate to false. - Per}

              if (uppercase(TnxSQLColumn(GroupColumnList[i]).ColumnNameStr)<>uppercase(TnxColumn(Columns[i]).Name)) or (CondExpHaving<>nil) then
              begin
                if VerboseLogging then
                  LogVerbose('No need to really group. Query is equivalent to distinct');
                NeedToGroup:=true;
                Break;
              end;
            end;
          end;
        end;*)

        if NeedToGroup then
          Result := GroupedAggregateQueryResult(Context, NeedData, RecordsRead, Recycle)
        else
          Distinct:=true;
      end else
        Result := GlobalAggregateQueryResult(Context, NeedData, RecordsRead, Recycle);
    end;
    if Result=nil then
      Result := NormalQueryResult(Context, NeedData, RecordsRead, Recycle, QuitAfterFirst);
    if not LastSelectInBlock then
      for i:=0 to TableRefList.Count-1 do
        TableRefList[i].Unbind;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlSELECT.CheckContextVars(Context: TnxSqlContext);
begin
  if Bound < 1 then
    Bind(True, Context);
  if SelectionList.RefersToContextVars(Context) then
    FRefersToContextVars := True
  else
  if (CondExpWhere <> nil) and CondExpWhere.RefersToContextVars(Context) then
    FRefersToContextVars := True
  else begin
    if Assigned(TableRefList) then
      FRefersToContextVars := TableRefList.RefersToContextVars(Context)
    else
      FRefersToContextVars := False;
  end;
  FContextVarsChecked := True;
end;

function TnxSqlSELECT.RefersToContextVars(Context: TnxSqlContext): Boolean;
begin
  if not FContextVarsChecked then
    CheckContextVars(Context);
  Result := FRefersToContextVars;
end;

procedure TnxSqlSELECT.EnsureResultTable(Context: TnxSqlContext; NeedData, QuitAfterFirst: Boolean);
var
  RecordsRead: Integer;
  SaveTable: TnxSqlTableProxy;
  {aParent: TnxSQLNode;}
  i: Integer;
begin
  snBeginUse;
  try
    SaveTable := nil;

    Assert(TObject(Self) is TnxSqlSELECT);

    UnbindIfRequired(Context);

    if (NeedData and Volatile(Context))
    or (NeedData and not HaveData) then
      if FResultTable <> nil then begin
        Assert(TObject(FResultTable) is TnxSqlTableProxy);
        Assert(FResultTable.Owner = Self);
        SaveTable := FResultTable;
        HaveData:=false;
          for i := 0 to pred(TablesReferencedByOrder.Count) do
            TablesReferencedByOrder[i].Refresh(Context);
        FResultTable := nil;
        if Volatile(Context) and (IsSubQuery) then
          Unbind;
      end;

    if Bound < 1 then
      Bind(NeedData, Context);

    if FResultTable = nil then begin
      FResultTable := DoWork(Context, NeedData, RecordsRead, SaveTable, QuitAfterFirst);
      HaveData := NeedData;
      if HaveData then begin
        FLastContext := Context;
        if Assigned(Context) then begin
          FLastContextID := Context.ContextID;
          FLastGeneration := Context.Generation;
          FLastRecordsRead := Context.RecordsRead;
        end else begin
          FLastContextID := -1;
          FLastGeneration := -1;
          FLastRecordsRead := -1;
        end;
      end;
    end;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlSELECT.DoRefresh(aContext: TnxSqlContext);
begin
    if not HaveData or
       (FLastContext <> aContext) or
       not Assigned(FLastContext) or
       not Assigned(aContext) or
       (FLastContextID <> aContext.ContextID) or
       (FLastGeneration <> aContext.Generation) or
       (FLastRecordsRead <> aContext.RecordsRead) then begin

      HaveData := False;
      EnsureResultTable(aContext, True, False);
      HaveData := True;
      FLastContext := aContext;
      if Assigned(aContext) then begin
        FLastContextID := aContext.ContextID;
        FLastGeneration := aContext.Generation;
        FLastRecordsRead := aContext.RecordsRead;
      end else begin
        FLastContextID := -1;
        FLastGeneration := -1;
        FLastRecordsRead := -1;
      end;
    end;
end;

{
var
  RecordsRead: Integer;
//  i: Integer;
begin
  Assert(FResultTable <> nil);
  Assert(TObject(FResultTable) is TnxSqlTableProxy);
  Assert(FResultTable.Owner = Self);

  FResultTable := DoWork(aContext, True, RecordsRead, FResultTable, False);
  HaveData := True;
end;
}
function TnxSqlSELECT.GetRefresh: TnxSqlTableRefresher;
begin
  Result := nil;
  if IsDependent or IsPSM then
    Result := DoRefresh;
end;

procedure TnxSqlSELECT.EnumOuterAggregates(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlAggregate then
    if TnxSqlAggregate(Node).IsOuterAggregate(BindingContext) then
      TnxSqlAggregate(Node).AddAggregate(UserData as TnxSqlAggregateList);
end;

procedure TnxSqlSELECT.EnumAggregates(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlAggregate then
  begin
    TnxSqlAggregate(Node).AddAggregate(UserData as TnxSqlAggregateList);
  end else
  if Node is TnxSqlInSub then begin
    TnxSqlSELECT(TnxSqlInSub(Node).SubQuery).Traverse(EnumOuterAggregates, UserData, True);
  end else
  if Node is TnxSqlFacSub then begin
    if TnxSqlSELECT(TnxSqlFacSub(Node).SubQuery).Bound < 1 then
      TnxSqlSELECT(TnxSqlFacSub(Node).SubQuery).Bind(true, BindingContext);
    TnxSqlSELECT(TnxSqlFacSub(Node).SubQuery).Traverse(EnumOuterAggregates, UserData, True);
  end;
end;

function TnxSqlSELECT.CreateNewSelectionItem(const aTableName, aColumnName: String; aField: TnxSQLFieldProxy; NotQualifiable: boolean = false): TnxSqlSelection;
var
  Selection: TnxSqlSelection;
  Term: TnxSqlTerm;
  Factor: TnxSqlFacColumn;
begin
  Selection := TnxSqlSelection.Create(self);
  Selection.SimpleExpression :=
    TnxSqlSimpleExpression.Create(Selection);
  Term := TnxSqlTerm.Create(Selection.SimpleExpression);
  Factor := TnxSqlFacColumn.Create(Term);
  Factor.FieldRef := TnxSqlFieldRef.Create(Factor);
  Factor.FieldRef.TableNameStr := aTableName;
  Factor.FieldRef.FieldNameStr := aColumnName;
  Factor.FieldRef.AddedByWildcard := True;
  Term.AddFactor(Factor);
  {Selection.AddedByWildcard := True;}
  Selection.SimpleExpression.AddTerm(Term);
  Selection.NotQualifiable:=NotQualifiable;
  result:=Selection;
end;

procedure TnxSqlSELECT.ExpandWildcards;
var
  SortedFieldList: TnxFastStringListIC;
  lDatabaseName, lTableName: string;
  k: Integer;
  LastTableName: TnxFastStringListIC;

  procedure AddFieldsOfTable(const aFilter: String; aTable: TnxSQLTableProxy; UsingList: TnxSqlUsingList; Natural: boolean);
  var
    idx: integer;
    aTableName: string;
    aField: TnxSqlFieldProxy;
    aFieldName: string;
    UnQualified: Boolean;
    j, k, l: Integer;
    stable: TnxSQLTableProxy;
  begin
    if aTable.Alias<>'' then
      aTableName:=aTable.Alias
    else
      aTableName:=aTable.Name;

    // sort out using fields; they have to folded into one UNQUALIFIED field,
    // thus we delete the qualified references so far from the list,
    // as the new unqualified one will be added at the bottom
    if (UsingList<>nil) and (LastTableName.Count>0) then
      for j := 0 to UsingList.Count - 1 do
        for l := 0 to LastTableName.Count - 1 do
        begin
          k:=SortedFieldList.IndexOf(LastTableName[l]+'.'+ UsingList[j].ColumnNameStr);
          if k>-1 then
          begin
            TnxSqlSelection(SortedFieldList.Objects[k]).Free;
            SortedFieldList.Delete(k);
          end;
        end;

    if UsingList<>nil then
      LastTableName.Add(aTableName);


    if (aTable.Owner is TnxSqlJoinTableExp) and TnxSqlJoinTableExp(aTable.Owner).Natural and (aFilter='') then
    begin
      // we need to put the joined coluns first.
      for idx := 0 to aTable.FieldCount - 1 do
      begin
        aField:=aTable.FieldList[idx];
        aFieldName:=aField.Name;
        if TnxSqlJoinTableExp(aTable.Owner).TableRef1.HasColumn(aFieldName) and TnxSqlJoinTableExp(aTable.Owner).TableRef2.HasColumn(aFieldName) then
          if SortedFieldList.IndexOf(aField.Name)<0 then
            SortedFieldList.AddObject(aField.Name, CreateNewSelectionItem('', aFieldName, aField));
      end;
    end;

    if (aTable.Owner is TnxSqlJoinTableExp) and (TnxSqlJoinTableExp(aTable.Owner).UsingList<>nil) and (AFilter='') then
    begin
      // we need to put the Usinglist columns first.
      for idx := 0 to aTable.FieldCount - 1 do
      begin
        aField:=aTable.FieldList[idx];
        aFieldName:=aField.Name;
        if TnxSqlJoinTableExp(aTable.Owner).UsingList.ReferencesFieldName(aFieldName) then
          if SortedFieldList.IndexOf(aField.Name)<0 then
            SortedFieldList.AddObject(aField.Name, CreateNewSelectionItem('', aFieldName, aField, True));
      end;
    end;


    for idx := 0 to aTable.FieldCount - 1 do
    begin
      aField:=aTable.FieldList[idx];
      aFieldName:=aField.Name;
      UnQualified:=false;

      if (UsingList<>nil) and UsingList.ReferencesFieldName(aFieldName) then
        Unqualified:=true;

      if (aTable.Owner is TnxSqlJoinTableExp) and (TnxSqlJoinTableExp(aTable.Owner).UsingList<>nil) then
        if TnxSqlJoinTableExp(aTable.Owner).UsingList.ReferencesFieldName(aFieldName) then
          UnQualified:=true;

      if (aTable.Owner is TnxSqlJoinTableExp) and (TnxSqlJoinTableExp(aTable.Owner).Natural) then
      begin
        if (aTable.Owner is TnxSqlJoinTableExp) then
          if TnxSqlJoinTableExp(aTable.Owner).TableRef1.HasColumn(aFieldName) and TnxSqlJoinTableExp(aTable.Owner).TableRef2.HasColumn(aFieldName) then
            UnQualified:=true;
      end;

      for j := 0 to TablesReferencedByOrder.Count - 1 do
      begin
        sTable:=TablesReferencedByOrder[j].Table;
        if (stable=nil) or (sTable=aTable) then
          continue;
        if (sTable.Owner is TnxSqlJoinTableExp) and (TnxSqlJoinTableExp(sTable.Owner).UsingList<>nil) then
          if TnxSqlJoinTableExp(sTable.Owner).UsingList.ReferencesFieldName(aFieldName) then
            UnQualified:=true;
      end;


      if UnQualified then
      begin
        if aFilter='' then
          if SortedFieldList.IndexOf(aField.Name)<0 then
            SortedFieldList.AddObject(aField.Name, CreateNewSelectionItem('', aField.Name, aField));
      end
      else
      begin
        if atablename<>'' then
          SortedFieldList.AddObject(aTablename+'.'+aField.Name, CreateNewSelectionItem(aTablename, aField.Name, aField))
        else
          if SortedFieldList.IndexOf(aField.Name)<0 then
            SortedFieldList.AddObject(aField.Name, CreateNewSelectionItem(aTablename, aField.Name, aField))
      end;
    end;
  end;

  procedure AddTable(Context: TNxSQLContext; const aFilter: String; aTableExp: TnxSqlTableExp; aTableRef: TnxSqlTableRef; UsingList: TnxSqlUsingList; IsNatural: boolean);
  var
//    idx: integer;
//    k: integer;
//    UnQualified: boolean;
    aTableName: string;
    aTable: TnxSQLTableProxy;
//    aFieldName: string;
  begin
    if (aTableExp<>nil) and (aTableExp.JoinTableExp<>nil) then
    begin
      AddTable(Context, aFilter, aTableExp.JoinTableExp.TableRef1.TableExp, aTableExp.JoinTableExp.TableRef1, aTableExp.JoinTableExp.UsingList, aTableExp.JoinTableExp.Natural);
      AddTable(Context, aFilter, aTableExp.JoinTableExp.TableRef2.TableExp, aTableExp.JoinTableExp.TableRef2, aTableExp.JoinTableExp.UsingList, aTableExp.JoinTableExp.Natural);
    end
    else
    if (aTableExp<>nil) and (aTableExp.NonJoinTableExp<>nil) then
    begin
      aTable:=aTableExp.NonJoinTableExp.NonJoinTableTerm.NonJoinTablePrimary.GetResultTable(Context, False);
      aTable.Alias:=TnxSqlTableRef(aTableExp.Parent).ALiasStr;
      AddFieldsOfTable(aFilter, aTable, UsingList, IsNatural);
    end
    else
    if (aTableExp<>nil) and (aTableExp.NestedTableExp<>nil) then
    begin
      aTable:=aTableExp.NestedTableExp.ResultTable;
      if aTable=nil then
        aTable:=aTableExp.NestedTableExp.GetResultTable(Context, false);
      AddFieldsOfTable(aFilter, aTable, nil, false);
    end
    else
    begin
      if aTableRef=nil then
        assert(aTableRef<>nil);
      if aTableRef.AliasStr<>'' then
        aTableName:=aTableRef.AliasStr
      else
        aTableName:=aTableRef.TablenameStr;
      if (aFilter<>'') and not SameText(aFilter, aTableName) then
        exit;

      if Assigned(aTableRef.Table) then
        aTable := aTableRef.Table
      else
        aTable := aTableRef.GetTable(Context, Self, somReadOnly);
      AddFieldsOfTable(aFilter, aTable, UsingList, IsNatural);
    end;
  end;


var
  i, j, ix : Integer;
  T : TnxSqlTableProxy;
  Simp : TnxSqlSimpleExpression;
  FR : TnxSqlFieldRef;
  aRef: TnxSqlTableRef;
  {List: TList;}
  aPos: Integer;
  //anInt: TnxInternalTableRef;
  Sel: TnxSqlSelection;
begin
  FSelectStarFromSingleTable := True;

  if fOrigSelectionList = nil then
    fOrigSelectionList:=TnxSQLSelectionList(SelectionList.Clone(SelectionList.Parent))
  else
  begin
    SelectionList.SetOwner(nil);
    SelectionList.Free;
    fSelectionList:=TnxSQLSelectionList(fOrigSelectionList.Clone(fOrigSelectionList.Parent));
  end;

  if SelectionList = nil then
    exit;

  if SelectionList.Count <> 1 then
    FSelectStarFromSingleTable := False;


  if VerboseLogging then
    LogVerbose('* ExpandWildcards');

  SortedFieldList:=TnxFastStringListIC.Create;
  LastTableName:=TnxFastStringListIC.Create;

  try

    for i := SelectionList.Count -1 downto 0 do begin
      SortedFieldList.Clear;
      Sel := SelectionList[i];
      Simp := Sel.SimpleExpression;
      if Simp <> nil then begin
        if Simp.TermList[0].FactorList[0] is TnxSqlFacColumn then begin
          FR := TnxSqlFacColumn(Simp.TermList[0].FactorList[0]).FieldRef;
          if FR <> nil then begin
            if FR.FieldNameStr = '' then begin
              Assert(Assigned(TablesReferencedByOrder));
              if FR.TableNameStr = '' then begin
                Assert(Assigned(TablesReferencedByOrder));
                Sel.Free;
                SelectionList.Remove(i);
                aPos:=i;
                for j := 0 to pred(TablesReferencedByOrder.Count) do begin
                  with TablesReferencedByOrder[j] do
                    if (TableRef2 = nil)
                    and (TableExp = nil)
                    and (Table <> nil) then
                      AddTableFields(Context, Table, aPos, nil)
                    else
                      AddTable(Context, '', TableExp, TableRef2, nil, false);
                end;
                k:=0;
                for j := 0 to SortedFieldList.Count - 1 do begin
                  SelectionList.Insert(i+k, TnxSqlSelection(SortedFieldList.Objects[j]));
                  inc(k);
                end;
             end else begin
                ix := TablesReferencedByOrder.IndexOf(FR.DatabaseNameStr, FR.TableNameStr);
                if ix = -1 then begin
                lDatabaseName := FR.DatabaseNameStr;
                lTableName:=FR.TableNameStr;
                ix := TablesReferencedByOrder.IndexOf(lDatabaseName, lTableName);

                if ix = -1 then begin

                  Assert(Assigned(TablesReferencedByOrder));
                  SelectionList[i].Free;
                  SelectionList.Remove(i);
                  aPos:=i;

                  aRef:=TablesReferencedByOrder.FindTableRef(lDatabaseName, lTableName, Context);
                  if aRef=nil then
                    raise EnxInternalSQLException.Create(rsUnableToResolveTableOrAlias+ltablename+'.')
                  else if aRef.IsStandalone then
                    freeandnil(aref);
                  

                  for j := 0 to TablesReferencedByOrder.Count-1 do
                    with TablesReferencedByOrder[j] do
                      if (TableRef2 = nil) and (TableExp = nil) and (Table <> nil) then begin
                        if sametext(Table.Name, lTableName) and ((lDatabaseName = '') or SameText(Table.Database.AliasName, lDatabaseName)) then
                          AddTableFields(Context, Table, aPos, nil)
                      end else
                        AddTable(Context, lTableName, TableExp, TableRef2, nil, false);

                  k:=0;
                  for j := 0 to SortedFieldList.Count - 1 do
                    if TnxSqlSelection(SortedFieldList.Objects[j]).RefersTo(lTableName) then
                    begin
                      SelectionList.Insert(i+k, TnxSqlSelection(SortedFieldList.Objects[j]));
                      inc(k);
                    end;

{                  Assert(Assigned(TableAliases));
                  with TableAliases do begin
                    ix := IndexOf(FR.TableNameStr);
                    if ix <> -1 then
                      ix := Integer(Objects[ix])
                    else begin
                      List := TList.Create;
                      try
                        T := TableRefList.FieldListFromTable(Context, FR.TableNameStr, List);
                        if T <> nil then begin
                          if (T.Owner is TnxSqlJoinTableExp) and (TnxSqlJoinTableExp(T.Owner).Natural) then
                          begin
                            SelectionList[i].Free;
                            SelectionList.Remove(i)
                          end
                          else
                            AddTableFieldsFromList(T, i, FR, List);
                          ix := -1;
                        end else
                          SQLError('Invalid table reference: "' + FR.TableNameStr + '"' + FR.LocationStr);
                      finally
                        nxFreeAndNil(List);
                      end;
                    end;}
                  end;
                end;
                if ix <> -1 then begin
                  T := TablesReferencedByOrder[ix].Table;
                  AddTableFields(Context, T, i, FR);
                end;
                if TablesReferencedByOrder.Count <> 1 then
                  FSelectStarFromSingleTable := False;
              end;
            end else
              FSelectStarFromSingleTable := False;
          end else
            FSelectStarFromSingleTable := False;
        end else
          FSelectStarFromSingleTable := False;
      end else
        FSelectStarFromSingleTable := False;
    end;
  finally
    SortedFieldList.Free;
    LastTableName.Free;
    if VerboseLogging then
      LogVerbose('Expanded to :'#13+ToString);
  end;
end;

function TnxSqlSELECT.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlSELECT then
    with TnxSqlSELECT(ANode) do
      Result := (Distinct = Self.Distinct)
        and SameText(TargetTableStr, Self.TargetTableStr)
        and SameText(TargetDatabasestr, Self.TargetDatabasestr)
        and TnxSqlNodeList.Identical(SelectionList, Self.SelectionList)
        and TableRefList.Equals(Self.TableRefList)
        and NodesIdentical(CondExpWhere, Self.CondExpWhere)
        and TnxSqlNodeList.Identical(GroupColumnList, Self.GroupColumnList)
        and NodesIdentical(CondExpHaving, Self.CondExpHaving)
        and TnxsqlNodeList.Identical(OrderList, Self.OrderList)
  else
    Result := False;
end;

function TnxSqlSELECT.EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  if CondExpWhere = nil then
    raise EnxInternalSQLException.Create(rsNoWHEREClausePresent);
  Result := CondExpWhere.AsBoolean(Context);
  if FResultTable <> nil then begin
    Assert(TObject(FResultTable) is TnxSqlTableProxy);
    Assert(FResultTable.Owner = Self);
    FResultTable := nil;
  end;
end;

procedure TnxSqlSELECT.BindWhere;
begin
  CondExpWhere.Validate(aContext);
end;

function TnxSqlSELECT.EvaluateFirst(Context: TnxSqlContext): variant;
begin
  if CondExpWhere = nil then
    raise EnxInternalSQLException.Create(rsNoWHEREClausePresent);
  Result := CondExpWhere.GetValue(Context);
end;

function TnxSqlSELECT.WhereIsValidFilterStatement: Boolean;
begin
  Result := (CondExpWhere <> nil) and CondExpWhere.IsValidFilterStatement;
end;

function TnxSqlSELECT.LastSelectInBlock: Boolean;
var
  P1: TnxSqlNonJoinTablePrimary;
  P2: TnxSqlNonJoinTableTerm;
  P3: TnxSqlNonJoinTableExp;
  P4: TnxSqlTableExp;
  P5: TnxSqlBlock;
  i, j: Integer;
begin
  Result := True;
  if (Parent <> nil) and (Parent is TnxSqlNonJoinTablePrimary) then begin
    P1 := TnxSqlNonJoinTablePrimary(Parent);
    if (P1.Parent <> nil) and (P1.Parent is TnxSqlNonJoinTableTerm) then begin
      P2 := TnxSqlNonJoinTableTerm(P1.Parent);
      if (P2.Parent <> nil) and (P2.Parent is TnxSqlNonJoinTableExp) then begin
        P3 := TnxSqlNonJoinTableExp(P2.Parent);
        if (P3.Parent <> nil) and (P3.Parent is TnxSqlTableExp) then begin
          P4 := TnxSqlTableExp(P3.Parent);
          if (P4.Parent <> nil) and (P4.Parent is TnxSqlBlock) then begin
            P5 := TnxSqlBlock(P4.Parent);
            for i := 0 to P5.StatementList.Count - 1 do
              if P5.StatementList[i] = P4 then begin
                for j := i + 1 to P5.StatementList.Count - 1 do
                  if TObject(P5.StatementList[j]) is TnxSqlTableExp then begin
                    Result := False;
                    exit;
                  end;
                exit;
              end;
          end;
        end;
      end;
    end;
  end;
end;

procedure DumpRow(T: TnxSqlTableProxy);
var
  i: Integer;
begin
  for i := 0 to T.FieldCount - 1 do
    write(VarToStr(T.fieldNC(i).GetValue(nil)),' ');
  writeln;
end;

procedure DumpTable(T: TnxSqlTableProxy);
begin
  if T.First then
    repeat
      DumpRow(T);
    until not T.Next;
  writeln('======');
end;

function TnxSqlSELECT.Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult;
var
  T : TnxSqlTableProxy;
  lTName, lTDBName: string;
  i: Integer;
  SaveTable: TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Result := DBIERR_NONE;
    RequestLive := aLiveResult;

    UnbindIfRequired(Context);

    SaveTable := nil;
    if Volatile(Context) then begin
      if FResultTable <> nil then begin
        Assert(TObject(FResultTable) is TnxSqlTableProxy);
        Assert(FResultTable.Owner = Self);
        SaveTable := FResultTable;
      end;
      HaveData := False;
      for i := 0 to pred(TablesReferencedByOrder.Count) do
        TablesReferencedByOrder[i].Refresh(Context);
      FResultTable := nil;
    end;

    T := DoWork(Context, True, RecordsRead, SaveTable, False);

    nxFreeAndNil(aCursor);

    if T.MappingCursor <> nil then
      aCursor := T.MappingCursor
    else
      aCursor := T.Cursor;

    aLiveResult := RequestLive;
    T.LeaveCursorOpen := True;
    lTName := TargetTableStr;
    lTDBName := TargetDatabaseStr;
    if (length(lTName) > 1)
    and (lTDBName = '')
    and (lTName[1] = '#')
    and (lTName[2] <> '#')
    and not LastSelectInBlock
    and (T.Owner = Self) then begin
      T.CloneTable(lTDBName, lTName, True, nil, True);
  //    T.Owner := nil;
    //  nxFreeAndNil(T);
  //    Database.MakeTempFromCursor(lTName, aCursor);
  //    aCursor := nil;
    end else begin
      if lTName <> '' then
        T.CloneTable(lTDBName, lTName, True, nil, True);
    end;
    if (T <> nil) and (T.Owner = Self) then begin
      T.Owner := nil;
      nxFreeAndNil(T);
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlSELECT.FindField(Context: TnxSqlContext; const FieldName, SourceLoc: string): TnxSqlFieldProxy;
var
  S, Dat, Tab, Col: string;
  B: Boolean;
begin
  Dat := SplitString('.', FieldName, S);
  Tab := SplitString('.', S, Col);
  if (Dat <> '') and (Tab = '') then begin
    Tab := Dat;
    Dat := '';
  end;
  Result := BindColumn(Context, False, Dat, Tab, Col, SourceLoc, nil, bsNormal, B, True);
end;

procedure TnxSqlSELECT.FlagAggregates(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlAggregate then
    TnxSqlAggregate(Node).FlagAggregate(Self);
end;

function TnxSqlSELECT.GetDecimals(Context: TnxSqlContext): Integer;
begin
  if not TypeKnown then begin
    EnsureResultTable(Context, False, False);
    with FResultTable.FieldNC(0) do begin
      FDecimals := GetDecimals;
      FType := GetType;
      FSize := GetSize;
    end;
    TypeKnown := True;
  end;
  Result := FDecimals;
end;

function TnxSqlSELECT.GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    if TargetTableStr <> '' then
      raise EnxInternalSQLException.Create(rsINTONotValidInThisContext);

    EnsureResultTable(Context, aNeedData, False);
    Result := FResultTable;
  finally
    snEndUse;
  end;
end;

function TnxSqlSELECT.GetSize(Context: TnxSqlContext): Integer;
begin
  if not TypeKnown then begin
    EnsureResultTable(Context, False, False);
    with FResultTable.FieldNC(0) do begin
      FDecimals := GetDecimals;
      FType := GetType;
      FSize := GetSize;
    end;
    TypeKnown := True;
  end;
  Result := FSize;
end;

function TnxSqlSELECT.GetType(Context: TnxSqlContext): TnxFieldType;
begin
  if not TypeKnown then begin
    EnsureResultTable(Context, False, False);
    with FResultTable.FieldNC(0) do begin
      FDecimals := GetDecimals;
      FType := GetType;
      FSize := GetSize;
    end;
    TypeKnown := True;
  end;
  Result := FType;
end;

function VarToStr(const V: variant): string;
begin
  if VarIsNull(V) then
    Result := '<null>'
  else
    Result := string(V);
end;


procedure TnxSqlSELECT.ReportNonScalarError(const Result: Variant);
begin
  raise EnxInternalSQLException.CreateFmt(rsScalarSubqueryExpected, [ToString, VarToStr(Result), VarToStr(FResultTable.FieldNC(0).GetValue)]);
end;

procedure TnxSqlSELECT.ReportNonSingleValueError;
begin
  raise EnxSqlException.CreateFmt(rsSinglevalueQueryExpected, [ToString]);
end;

function TnxSqlSELECT.GetValue(Context: TnxSqlContext): Variant;
begin
  EnsureResultTable(Context, True, True);
  if FResultTable.First then begin
    Result := FResultTable.FieldNC(0).GetValue;
    if FResultTable.Next then
      ReportNonScalarError(Result);
    if FResultTable.VisibleFieldCount > 1 then
      ReportNonSingleValueError;
  end else
    Result := Null;
end;

function TnxSqlSELECT.GetCodepage: Integer;
begin
  Result := 0;
end;

function TnxSqlSELECT.GetLimitInt: Integer;
begin
  Result := FLimitInt;
  if Result<0 then
    Result:=FFixedLimitInt;
end;

function TnxSqlSELECT.GetLocale(Context: TnxSqlContext): DWord;
begin
  EnsureResultTable(Context, False, True);
   Result := FResultTable.FieldNC(0).GetLocale;
end;

function TnxSqlSELECT.GetLocaleDesc(
  Context: TnxSqlContext): TnxLocaleDescriptor;
begin
  EnsureResultTable(Context, False, True);
  Result := FResultTable.FieldNC(0).GetLocaleDesc;
end;

function TnxSqlSELECT.IsPSM: Boolean;
var
  P: TnxSqlNode;
begin
//  result:=false;
  //exit;
  P := Parent;
  while P <> nil do begin
    if (P is TnxSqlCREATEPROC)
    or (P is TnxSqlCREATEFUNC)
    or (P is TnxSqlCREATETRIGGER)
    or (P is TnxSqlWHILE)
    or (P is TnxSqlREPEAT)
     then begin
      Result := True;
      exit;
    end;
    P := P.Parent;
  end;
  Result := False;
end;

function TnxSqlSELECT.IsPSMLoop: Boolean;
var
  P: TnxSqlNode;
begin
//  result:=false;
  //exit;
  P := Parent;
  while P <> nil do begin
    if (P is TnxSqlWHILE)
    or (P is TnxSqlREPEAT)
     then begin
      Result := True;
      exit;
    end;
    P := P.Parent;
  end;
  Result := False;
end;

function TnxSqlSELECT.IsSubQuery: Boolean;
var
  P: TnxSqlNode;
begin
  P := ContextParent;
  while P <> nil do begin
    if (P is TnxSqlSELECT)
    or (P is TnxSqlUPDATE)
    or (P is TnxSqlDELETE)
    or (P is TnxSqlINSERT)
    or (P is TnxSqlCREATETRIGGER) then begin
      Result := True;
      exit;
    end;
    P := P.ContextParent;
  end;
  Result := False;
end;

function RangeIsOne(const Table: TnxSqlTableProxy): Boolean;
begin
  Result := Table.First and not Table.Next;
end;

function TnxSqlSELECT.Match(Context: TnxSqlContext; const Value: Variant; Unique: Boolean;
  MatchOption: TnxSqlMatchOption): Boolean;
begin
  EnsureResultTable(Context, True, False);
  if VarIsNull(Value) then
    Result := True
  else begin
    FResultTable.SetRange1(Value);
    if not Unique then
      Result := FResultTable.First
    else
      Result := RangeIsOne(FResultTable);
  end;
end;

procedure TnxSqlSELECT.MatchType(Context: TnxSqlContext; ExpectedType: TnxFieldType; AllowMultiple: Boolean);
begin
  if not AllowMultiple and (SelectionList.Count <> 1) then
    SQLError(rsSinglecolumnSubqueryExpected);
  EnsureResultTable(Context, False, False);
end;

function BuildClosure(Context: TnxSqlContext; T: TnxSqlTableProxy; KeySeg: Integer; const SegmentInfo: TnxSqlIndexSegmentInfoArray; CondTerm: TnxSqlCondTerm;
  MatchOp: TnxSqlRelOp;
  FactorsUsed: TList; var Values: TnxSqlVariantArray; ParentBlock: TnxSqlBlock): Boolean;
var
  F: TnxSqlFieldProxy;
  Op: TnxSqlRelOp;
  ArgExpr: TnxSqlNode;
  IsNullTest, SameCase: Boolean;
  i: Integer;
  lCondFactor: TnxSqlCondFactor;
begin
  if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
    ParentBlock.LogVerbose('  Looking for closure expression');
  for i := 0 to CondTerm.CondFactorCount - 1 do begin
    lCondFactor := CondTerm.CondFactor[i];
    {possibly multiple AND'ed conditions}
    if lCondFactor.IsRelationTo(Context, T, F, Op, ArgExpr, SameCase, IsNullTest) then begin
      if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
        ParentBlock.LogVerbose('  Found relation:"' + lCondFactor.ToString + '"');
      if ArgExpr is TnxSqlSimpleExpression
      and SameText(F.Name, T.FieldC(SegmentInfo[KeySeg].FieldNo).Name) then
        if Op = MatchOp then begin
          Values[KeySeg] := Unassigned;
          Values[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
          FactorsUsed.Add(lCondFactor);
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('  Range closed!');
          Result := True;
          exit;
        end else begin
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('  not the right operator');
        end
      else
        if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
          ParentBlock.LogVerbose('  key does not match conditions');
    end;
  end;
  if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
    ParentBlock.LogVerbose('  none found');
  Result := False;
end;

function BuildRange(Context: TnxSqlContext; T: TnxSqlTableProxy; KeySeg, KeyDepth: Integer;
  const SegmentInfo: TnxSqlIndexSegmentInfoArray; CondTerm: TnxSqlCondTerm;
  FactorsUsed: TList; var StartValues, EndValues: TnxSqlVariantArray; ParentBlock: TnxSqlBlock;
  var PartialLength: Integer): Integer;
var
  F, lF: TnxSqlFieldProxy;
  Op: TnxSqlRelOp;
  ArgExpr: TnxSqlNode;
  IsNullTest, SameCase: Boolean;
  i: Integer;
  lCondFactor: TnxSqlCondFactor;
begin
  PartialLength := 0;
  if KeySeg >= KeyDepth then begin
    if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
      ParentBlock.LogVerbose('Not enough columns in index key');
    Result := KeySeg - 1;
    exit;
  end;
  {first look for equal match}
  for i := 0 to CondTerm.CondFactorCount - 1 do begin
    if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
      ParentBlock.LogVerbose('Considering equality expressions (if any)');
    {possibly multiple AND'ed conditions}
    lCondFactor := CondTerm.CondFactor[i];
    if lCondFactor.IsRelationTo(Context, T, F, Op, ArgExpr, SameCase, IsNullTest) then begin
      if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
        ParentBlock.LogVerbose('  Found relation:"' + lCondFactor.ToString + '"');
      if (SameCase or SegmentInfo[KeySeg].IgnoreCase) and (ArgExpr is TnxSqlSimpleExpression)
      and SameText(F.Name, T.FieldC(SegmentInfo[KeySeg].FieldNo).Name)
      and (
        (SegmentInfo[KeySeg].siLocale = nil)
        or (SegmentInfo[KeySeg].siLocale.Locale = 0)
        or not (SegmentInfo[KeySeg].IsTextKey)
        or SegmentInfo[KeySeg].IgnoreCase) then
        case Op of
        roEQ :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            StartValues[KeySeg] := Unassigned;
            StartValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if VarIsNull(StartValues[KeySeg]) then begin
              if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
                ParentBlock.LogVerbose('  NULL value argument');
              Result := -1;
              exit;
            end;
            SetLength(EndValues, KeySeg + 1);
            EndValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := StartValues[KeySeg];
            if VarIsNull(EndValues[KeySeg]) then begin
              if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
                ParentBlock.LogVerbose('  NULL value argument');
              Result := -1;
              exit;
            end;
            Result := BuildRange(Context, T, KeySeg + 1, KeyDepth, SegmentInfo, CondTerm,
              FactorsUsed, StartValues, EndValues, ParentBlock, PartialLength);
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  equal range found');
            exit;
          end;
        roBeginsWith :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            StartValues[KeySeg] := Unassigned;
            StartValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if VarIsNull(StartValues[KeySeg]) then begin
              if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
                ParentBlock.LogVerbose('  NULL value argument');
              Result := -1;
              exit;
            end;
            SetLength(EndValues, KeySeg + 1);
            EndValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := StartValues[KeySeg];
            PartialLength := length(EndValues[KeySeg]);
            Result := 0;
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  partial key equal range found');
            exit;
          end;
        end
      else begin
        if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
          ParentBlock.LogVerbose('  key does not match conditions:');
        if not (SameCase or SegmentInfo[KeySeg].IgnoreCase) then
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('    case mismatch');
        if not (ArgExpr is TnxSqlSimpleExpression) then
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('    argument is not a simple expression');
        lF := T.FieldC(SegmentInfo[KeySeg].FieldNo);
        if not SameText(F.Name, lF.Name) then
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('    not the right column name ("' + F.Name + '" vs "' +
              lF.Name + '")');
      end;
    end;
  end;
  {then look for other matches}
  for i := 0 to CondTerm.CondFactorCount - 1 do begin
    if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
      ParentBlock.LogVerbose('Considering non-equality expressions (if any)');
    {possibly multiple AND'ed conditions}
    lCondFactor := CondTerm.CondFactor[i];
    if lCondFactor.IsRelationTo(Context, T, F, Op, ArgExpr, SameCase, IsNullTest) then begin
      if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
        ParentBlock.LogVerbose('  Found relation:"' + lCondFactor.ToString + '"');
      if SameCase and (ArgExpr is TnxSqlSimpleExpression)
      and SameText(F.Name, T.FieldC(SegmentInfo[KeySeg].FieldNo).Name)
      and SegmentInfo[KeySeg].Ascending
      and (
        (SegmentInfo[KeySeg].siLocale = nil)
        or (SegmentInfo[KeySeg].siLocale.Locale = 0)
        or not (SegmentInfo[KeySeg].IsTextKey)
        or SegmentInfo[KeySeg].IgnoreCase) then
        case Op of
        roEQ : {handled above}
          ;
        roLE :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            SetLength(EndValues, KeySeg + 1);
            StartValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  <= sub-range found');
            BuildClosure(Context, T, KeySeg, SegmentInfo, CondTerm, roGE, FactorsUsed, StartValues, ParentBlock);
            Result := KeySeg;
            exit;
          end;
        roL :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            SetLength(EndValues, KeySeg + 1);
            EndValues[KeySeg] := Unassigned;
            StartValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  < sub-range found');
            BuildClosure(Context, T, KeySeg, SegmentInfo, CondTerm, roG, FactorsUsed, StartValues, ParentBlock);
            Result := KeySeg;
            exit;
          end;
        roG :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            SetLength(EndValues, KeySeg + 1);
            StartValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := Unassigned;
            StartValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  > sub-range found');
            BuildClosure(Context, T, KeySeg, SegmentInfo, CondTerm, roL, FactorsUsed, EndValues, ParentBlock);
            Result := KeySeg;
            exit;
          end;
        roGE :
          begin
            FactorsUsed.Add(lCondFactor);
            SetLength(StartValues, KeySeg + 1);
            SetLength(EndValues, KeySeg + 1);
            StartValues[KeySeg] := Unassigned;
            EndValues[KeySeg] := Unassigned;
            StartValues[KeySeg] := TnxSqlSimpleExpression(ArgExpr).GetValue(Context);
            if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
              ParentBlock.LogVerbose('  >= sub-range found');
            BuildClosure(Context, T, KeySeg, SegmentInfo, CondTerm, roLE, FactorsUsed, EndValues, ParentBlock);
            Result := KeySeg;
            exit;
          end;
        else
          if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
            ParentBlock.LogVerbose('  unsupported operator');
        end
      else begin
        if (ParentBlock<>nil) and (ParentBlock.VerboseLogging) then
        begin
          ParentBlock.LogVerbose('  key does not match conditions:');
          if not (SameCase or SegmentInfo[KeySeg].IgnoreCase) then
            if ParentBlock <> nil then ParentBlock.LogVerbose('    case mismatch');
          if not (ArgExpr is TnxSqlSimpleExpression) then
            if ParentBlock <> nil then ParentBlock.LogVerbose('    argument is not a simple expression');
          lF := T.FieldC(SegmentInfo[KeySeg].FieldNo);
          if not SameText(F.Name, lF.Name) then
            if ParentBlock <> nil then ParentBlock.LogVerbose('    not the right column name ("' + F.Name + '" vs "' +
              lF.Name + '")');
        end;
      end;
    end;
  end;
  Result := KeySeg - 1;
end;

function TnxSqlSELECT.HasSelectionSubQuery:Boolean;
var
  aT: TnxSqlTerm;
  I : Integer;
  expr: TnxSQLSimpleExpression;
begin
  result:=false;
  for I := 0 to SelectionList.Count - 1 do    // Iterate
  begin
    expr:=SelectionList.GetItem(i).SimpleExpression;
    if expr<>nil then
    begin
      aT:=TnxSqlTerm(expr.TermList[0]);
      if at.FactorList[0] is TnxSqlFacSub then
      begin
        result:=true;
        exit;
      end;
    end;
  end;    // for
end;

function TnxSqlSELECT.HasSubQuery:Boolean;
var
  aTerm: TnxSqlCondTerm;
  I, J: Integer;
  aFactor: TnxSqlCondFactor;
begin
  result:=false;
  if CondExpWhere<>nil then
    for I := 0 to CondExpWhere.CondTermCount - 1 do    // Iterate
    begin
      aTerm:=TnxSqlCondTerm(CondExpWhere.CondTerm[0]);
      for j:=0 to aTerm.CondFactorCount-1 do
      begin
        aFactor:=aTerm.CondFactor[j];
        if (aFactor.CondPrimary<>nil) and (aFactor.CondPrimary is TnxSqlCPIn) then
          if (TnxSqlCPIn(aFactor.CondPrimary).InClause<>nil) and (TnxSqlCPIn(aFactor.CondPrimary).InClause is TnxSqlInSub) then
          begin
            result:=true;
            exit;
          end;
      end;
    end;    // for
//  TnxSqlInSub(TnxSqlCPIn(TnxSqlCondTerm(CondExpWhere.CondTermList[0]).CondFactor[0].CondPrimary).InClause)
end;

function TnxSqlSELECT.DoLive(Context: TnxSqlContext; var OutputTable: TnxSqlTableProxy):Boolean;
var
  i, j : Integer;
  Dups: TnxIndexDups;
  FoundIndex, Good, Filtered: Boolean;
  IndexFieldCount: Integer;
  SegmentInfo: TnxSqlIndexSegmentInfoArray;
  S, FoundIndexName, BestIndexName: string;
  CondTerm: TnxSqlCondTerm;
  R, DL, DR: Integer;
  FactorsUsed: TList;
  StartValues, EndValues: TnxSqlVariantArray;
  aFunc: TnxSqlFac;
  BestDepth: Integer;
  N : TnxSqlNode;
  FieldList: TnxFastStringListIC;
  F: TnxSqlFieldProxy;
  PartialLength: Integer;
  ConstraintName: string;
begin
  Result := False;
  if NormalLogging then
    LogNormal('Live result requested');

  if HasSubQuery or HasSelectionSubQuery then
  begin
    if NormalLogging then
      LogNormal('Query has sub query, live request cannot be satisfied');
    exit;
  end;

  if TargetTablestr <> '' then begin
    if NormalLogging then
      LogNormal('Query has INTO clause, live request cannot be satisfied');
    exit;
  end;

  if (TablesReferencedByOrder[0].Table is TnxSqlDicTable) then begin
    if NormalLogging then
      LogNormal('Request is for a system table, live request cannot be satisfied');
    exit;
  end;

  if (TablesReferencedByOrder = nil) or (TablesReferencedByOrder.Count > 1) then begin
    if NormalLogging then
      LogNormal('Request is for multi-table query, live request cannot be satisfied');
    exit;
  end;

  if TablesReferencedByOrder[0].Table.IsTemp
  or (TablesReferencedByOrder[0].Table.Name = '')
  then begin
    if NormalLogging then
      LogNormal('Outermost table is an intermediate result, live request cannot be satisfied');
    exit;
  end;

  if Assigned(GroupColumnList) and (GroupColumnList.Count > 0) or Assigned(CondExpHaving) then begin
    if NormalLogging then
      LogNormal('Query is grouped, live request cannot be satisfied');
    exit;
  end;

  if (LimitInt >= 0) then begin
    if NormalLogging then
      LogNormal('Request is limited, live request cannot be satisfied');
    exit;
  end;

  if Distinct then begin
    if NormalLogging then
      LogNormal('Request is for distinct values, live request cannot be satisfied');
    exit;
  end;

  if TablesReferencedByOrder[0].Table.Database <> Database then begin
    if NormalLogging then
      LogNormal('Table is not part of the current default database, live request cannot be satisfied');
    exit;
  end;

  if TablesReferencedByOrder[0].Table.IsWrapper then begin
    if NormalLogging then
      LogNormal('Table is a cursor wrapper, live request cannot be satisfied');
    exit;
  end;


  Assert(Assigned(Columns));
  FieldList := TnxFastStringListIC.Create;
  try
    for i := 0 to pred(Columns.Count) do begin
      N := TnxSqlNode(Columns[i].Info);
      if not (N is TnxSqlSimpleExpression) then begin
        if NormalLogging then
          LogNormal('A Column requested (' + N.ToString + ') is not all simple source columns, live request cannot be satisfied');
        exit;
      end;

      if TnxSqlSimpleExpression(N).IsFunction(Context, aFunc) then begin
        if NormalLogging then
          LogNormal('Column expression "' + N.ToString +'" is a function expression, live request cannot be satisfied');
        exit;
      end;

      if TnxSqlSimpleExpression(N).IsField(Context, F) and SameText(F.Name, Columns[i].Name) then
        FieldList.Add(F.Name) {simple column reference}
      else begin
        if TnxSqlSimpleExpression(N).IsBlobExpression(COntext) then begin
          if NormalLogging then
            LogNormal('Column expression "' + N.ToString +'" is a BLOB expression, live request cannot be satisfied');
          exit;
        end;
        if TnxSqlSimpleExpression(N).IsCorrelatedSubquery(Context) then begin
          if NormalLogging then
            LogNormal('Column expression "' + N.ToString +'" contains a correlated subquery, live request cannot be satisfied');
          exit;
        end;
        if Columns[i].Name <> '' then
          S := Columns[i].Name
        else
          S := TnxSqlSimpleExpression(N).GetTitle(True);
        FieldList.AddObject(S, N); {expression}
      end;
    end;

    if Assigned(OrderList) and (OrderList.Count > 0) then begin
      if VerboseLogging then
        begin
        LogVerbose('Query is ordered - look for matching index');
        LogVerbose('  Columns:');
      end;
      Assert(Assigned(Columns));
      FOrderByScope.Clear;
      for i := 0 to pred(Columns.Count) do begin
        FOrderByScope.AddColumn(Columns[i].Name);
        if VerboseLogging then
          LogVerbose('  ' + Columns[i].Name);
      end;
      FoundIndex := False;
      with TablesReferencedByOrder[0].Table do begin
        for i := 0 to IndexCount - 1 do begin
          FoundIndexName := IndexName(i);
          if VerboseLogging then
            LogVerbose('Considering index: ' + FoundIndexName);
          GetIndexProperties(FoundIndexName, Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
          if IndexFieldCount >= OrderList.Count then begin
            Good := True;
            for j := 0 to OrderList.Count - 1 do begin
              if assigned(OrderList[j].Column) then begin
                if not SameText(OrderList[j].Column.FieldNameStr, FieldNC(SegmentInfo[j].FieldNo).Name) then begin
                  if VerboseLogging then
                    LogVerbose('  Column "' + OrderList[j].Column.FieldNameStr + '" not present in key');
                  Good := False;
                  Break;
                end;
                if OrderList[j].Descending <> not SegmentInfo[j].Ascending then begin
                  if VerboseLogging then
                    LogVerbose('  Column #' + IntTostr(j) + ' is sorted in the wrong direction');
                  Good := False;
                  Break;
                end;
                if OrderList[j].IgnoreCase <> SegmentInfo[j].IgnoreCase then begin
                  if VerboseLogging then
                    LogVerbose('  Column #' + IntTostr(j) + ' has different casing semantics');
                  Good := False;
                  Break;
                end;
                if (SegmentInfo[j].siLocale = nil) then
                  if OrderList[j].Locale <> 0 then begin
                    if VerboseLogging then
                      LogVerbose('  Column #' + IntTostr(j) + ' has different locale semantics');
                    Good := False;
                    Break;
                  end else
                else
                  if (OrderList[j].Locale <> 0)
                  and (OrderList[j].Locale <> SegmentInfo[j].siLocale.Locale) then begin
                    if VerboseLogging then
                      LogVerbose('  Column #' + IntTostr(j) + ' has different locale semantics');
                    Good := False;
                    Break;
                  end;
                if SegmentInfo[j].NullBehaviour <> OrderList[j].NullBehaviour then begin
                  if VerboseLogging then
                    LogVerbose('  Column #' + IntTostr(j) + ' has different null behaviour');
                  Good := False;
                  Break;
                end;
              end else
                Good := False;
            end;
            if Good then begin
              FoundIndex := True;
              Break;
            end;
          end else
            if VerboseLogging then
              LogVerbose('  not all requested columns present in key');
        end;
      end;
      if FoundIndex then begin
        if NormalLogging then
          LogNormal('Found matching index:' + FoundIndexName);
        Result := True;
      end else begin
        if NormalLogging then
          LogNormal('Query is ordered in a way that does not match an existing index, live request cannot be satisfied');
        exit;
      end;
    end else
      FoundIndex := False;


    if Assigned(CondExpWhere)
	{TODO: check if this can be expanded to lower hsv levels}
    and not ((CondExpWhere.HasStaticValue(Context) = hsvYes)
             and (CondExpWhere.AsBoolean(Context) = tsbTrue)) then begin

      if VerboseLogging then
        LogVerbose('Query has a WHERE clause');

      {we have a WHERE clause and it is not unconditionally TRUE}

      {if we have an index we need to use to satisfy an ORDER BY clause, see if the condition
       expresses only limits that can be enforced with a range on that index}

      if FoundIndex then begin
        if VerboseLogging then
          LogVerbose('Index previously selected. Looking for possible ranges on that index');
        if CondExpWhere.CondTermCount = 1 then begin
          {OR expressions not allowed}
          CondTerm := CondExpWhere.CondTerm[0];
          TablesReferencedByOrder[0].Table.GetIndexProperties(FoundIndexName, Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
          FactorsUsed := TList.Create;
          try
            if VerboseLogging then
              LogVerbose('Trying to build range using index ' + FoundIndexName);
            R := BuildRange(Context, TablesReferencedByOrder[0].Table, 0,
              IndexFieldCount, SegmentInfo, CondTerm, FactorsUsed,
              StartValues, EndValues, ParentBlock, PartialLength);
            OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
            OutputTable.SetIndex(FoundIndexName);
            if R >= 0 then begin
              if VerboseLogging then
                LogVerbose('Found range. Depth:' + IntToStr(R + 1));
              if PartialLength = 0 then begin
                DL := R + 1;
                DR := R + 1;
              end else begin
                DL := R;
                DR := R;
              end;
              for i := 0 to DL - 1 do
                if VarIsEmpty(StartValues[i]) then begin
                  DL := i;
                  Break;
                end;
              for i := 0 to DR - 1 do
                if VarIsEmpty(EndValues[i]) then begin
                  DR := i;
                  Break;
                end;
              OutputTable.SetRange(StartValues, EndValues, DL, DR, True, True, PartialLength);
            end else begin
              if VerboseLogging then
                LogVerbose('Did not find range');
            end;
            { We need to set a filter for any conditions not filtered by the range}
            try
              OutputTable.SetMappingCursor(Context, CondExpWhere.ToString, FieldList);
            except
              if NormalLogging then
                LogNormal('Not able to build valid SQL filter, live request cannot be satisfied');
              Result := False;
            end;
            exit;
          finally
            nxFreeAndNil(FactorsUsed);
          end;
        end;
        {no range - use filter}
        OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
        Result := True;
        if FoundIndex then
          OutputTable.SetIndex(FoundIndexName)
        else
          OutputTable.SetIndex(OutputTable.IndexName(0));
        try
          OutputTable.SetMappingCursor(Context, CondExpWhere.ToString, FieldList);
        except
          if NormalLogging then
            LogNormal('Not able to build valid SQL filter, live request cannot be satisfied');
          Result := False;
        end;
        exit;
      end else begin
        if VerboseLogging then
          LogVerbose('No index previously selected. Looking for possible ranges on any index');
        {otherwise, see if the condition expresses only limits that can be enforced
         with a range on any index}
        BestDepth := -1;
        with TablesReferencedByOrder[0].Table do begin
          for i := 0 to IndexCount - 1 do begin
            FoundIndexName := IndexName(i);
            if CondExpWhere.CondTermCount = 1 then begin
              {OR expressions not allowed}
              CondTerm := CondExpWhere.CondTerm[0];
              GetIndexProperties(FoundIndexName, Dups, Filtered, IndexFieldCount, SegmentInfo, ConstraintName);
              FactorsUsed := TList.Create;
              try
                if VerboseLogging then
                  LogVerbose('Trying to build range using index ' + FoundIndexName);
                R := BuildRange(Context, TablesReferencedByOrder[0].Table, 0,
                  IndexFieldCount, SegmentInfo, CondTerm, FactorsUsed,
                  StartValues, EndValues, ParentBlock, PartialLength);
                if R >= 0 then begin
                  if VerboseLogging then
                    LogVerbose('Found range. Depth:' + IntToStr(R + 1));
                  if R >= BestDepth then begin
                    if VerboseLogging then
                      LogVerbose('Best so far');
                    BestDepth := R;
                    BestIndexName := FoundIndexName;
                    if OutputTable <> nil then begin
                      OutputTable.Owner := nil;
                      nxFreeAndNil(OutputTable);
                    end;
                    OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
                    OutputTable.SetIndex(FoundIndexName);
                    if PartialLength = 0 then begin
                      DL := R + 1;
                      DR := R + 1;
                    end else begin
                      DL := R;
                      DR := R;
                    end;
                    for j := 0 to DL - 1 do
                      if VarIsEmpty(StartValues[j]) then begin
                        DL := j;
                        Break;
                      end;
                    for j := 0 to DR - 1 do
                      if VarIsEmpty(EndValues[j]) then begin
                        DR := j;
                        Break;
                      end;
                    OutputTable.SetRange(StartValues, EndValues, DL, DR, True, True, PartialLength);
                  end;
                end;
              finally
                nxFreeAndNil(FactorsUsed);
              end;
            end;
          end;
        end;
        if BestDepth <> -1 then begin
          {found range}
          Result := True;
          try
            OutputTable.SetMappingCursor(Context, CondExpWhere.ToString, FieldList);
          except
            if NormalLogging then
              LogNormal('Not able to build valid SQL filter, live request cannot be satisfied');
            Result := False;
          end;
          exit;
        end else begin
          {no range - use filter}
          OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
          Result := True;
          try
            OutputTable.SetMappingCursor(Context, CondExpWhere.ToString, FieldList);
          except
            try
              OutputTable.Owner := nil;
              nxFreeAndNil(OutputTable);
            except
            end;
            if NormalLogging then
              LogNormal('Not able to build valid SQL filter, live request cannot be satisfied');
            Result := False;
          end;
          exit;
        end;
      end;

      if NormalLogging then
        LogNormal('Query has a WHERE clause, live request cannot be satisfied');
      Result := False;
      exit;
      
    end;
    if FSelectStarFromSingleTable then begin
      OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
      if FoundIndex then
        OutputTable.SetIndex(FoundIndexName)
      else
      begin
        if OutputTable.IndexCount>0 then // the assumption that a table has to have anindex is flawed
          OutputTable.SetIndex(OutputTable.IndexName(0));
      end;
      Result := True;
//      OutputTable.SetMappingCursor(Context, '', FieldList);
    end else begin
      OutputTable := TablesReferencedByOrder[0].Table.Duplicate(Self);
      if FoundIndex then
        OutputTable.SetIndex(FoundIndexName)
      else begin
        FoundIndexName := OutputTable.IndexName(0);
        if (FoundIndexName <> '$$$UnKnOwN$$$') and (FoundIndexName <> '') then
          OutputTable.SetIndex(FoundIndexName);
      end;
      Result := True;
      OutputTable.SetMappingCursor(Context, '', FieldList);
    end;
  finally
    nxFreeAndNil(FieldList);
  end;
end;

procedure SplitAlias(const QualifiedName: string; var ColumnName, TableName: string);
var
  p: Integer;
begin
  TableName := '';
  p := pos('.', QualifiedName);
  if p = 0 then
    ColumnName := QualifiedName
  else begin
    TableName := copy(QualifiedName, 1, p - 1);
    ColumnName := copy(QualifiedName, p + 1, MaxInt);
  end;
end;

procedure TnxSqlSELECT.DoSystemRow(Result: TnxSqlTableProxy);
var
  Info: TObject;
  IsSystemRow: Boolean;
  anExp:TnxSqlSimpleExpression;
  F : TnxSqlFieldProxy;
  i : Integer;
  TmpTerm: TnxSqlTerm;
  TmpFactor: TnxSqlFac;
  TmpCondFactor: TnxSqlFacCond;
begin
  IsSystemRow := False;
  // fill in SYSTEM_ROW# values, if requested
  Info := Columns[0].Info;
  if Info is TnxSqlSimpleExpression then begin
    if (length(TnxSqlSimpleExpression(Info).TermList) = 1) then begin
      TmpTerm := TnxSqlSimpleExpression(Info).TermList[0];
      if (length(TmpTerm.FactorList) = 1) then begin
        TmpFactor := TmpTerm.FactorList[0];
        if (TmpFactor is TnxSqlFacFunc)
          and (TnxSqlFacFunc(TmpFactor).ScalarFunc is TnxSqlsfSystemRow) then
          IsSystemRow:=true;

        if (TmpFactor is TnxSQLFacCond) then begin
          TmpCondFactor := TnxSqlFacCond(TmpFactor);
          if (TmpCondFactor.CondExp.CondTermCount=1) and
             (TmpCondFactor.CondExp.CondTerm[0].CondFactorCount=1) and
             (TmpCondFactor.CondExp.CondTerm[0].CondFactor[0].CondPrimary is TnxSqlCPSimple) then
          begin
            anExp:=TnxSqlCPSimple(TmpCondFactor.CondExp.CondTerm[0].CondFactor[0].CondPrimary).SimpleExp1;
            if (length(anExp.TermList) = 1) and (length(anExp.TermList[0].FactorList) = 1) and
              (anExp.TermList[0].FactorList[0] is TnxSqlFacFunc)
            and (TnxSqlFacFunc(anExp.TermList[0].FactorList[0]).ScalarFunc is TnxSqlsfSystemRow) then
              isSystemRow:=true;
          end;
        end;
      end;
    end;
  end;

 if IsSystemRow then begin
   F := Result.FieldNC(0);
   if F <> nil then begin
     i := 1;
     if Result.First then
       repeat
         F.SetValue(i);
         Result.Update;
         inc(i);
       until not Result.Next;
    end;
  end;
end;

function TnxSqlSELECT.NormalQueryResult(Context: TnxSqlContext; NeedData: Boolean;
  var RecordsRead: Integer; Recycle: TnxSqlTableProxy; QuitAfterFirst: Boolean; AggList: TnxSqlAggregateList = nil): TnxSqlTableProxy;
var
  PresortIndex: string;
  IndexFieldList: TList;
  lPresorted: boolean;
  BackWards: boolean;
  KeyIterateInfo: TnxSqlKeyIterateInfo;
  KeyFieldSource: InxFieldsSource;
  FieldNum: integer;
  i, c : Integer;
  N : TnxSqlNode;
  T2 : TnxSqlTableProxy;
  F : TnxSqlFieldProxy;
  FieldDefList: TnxSqlFieldDefList;
  SkipDuptrimming, HaveTable: Boolean;
//  Info: TObject;
  XList: TnxFastStringListIC;
  SX: TnxSqlSimpleExpression;
  Term: TnxSqlTerm;
  Factor: TnxSqlFacColumn;
  FieldRef: TnxSqlFieldRef;
  TabName, ColName: string;
  IndexNames: TnxSQLStringArray;
  BaseCursor: TnxSqlAbstractCursor;
//  anExp:TnxSqlSimpleExpression;
  //IsExistsSubQuery: Boolean;
  aggListCreated: Boolean;
  TmpOI: TnxSqlOrderItem;
  fdx: TObject;
  TmpAgg: TnxSqlAggregate;
  idx: integer;
begin
  FieldDefList := nil;
  Result := nil;
  aggListCreated:=false;
  lPresorted := False;
  HaveTable := False;
  //IsExistsSubQuery:=false;
  if (Parent<>nil) and (Parent is TnxSqlCPExists) then
  begin
    QuitAfterFirst:=true;
    //IsExistsSubQuery:=true;
  end;

      XList := FindImplicitOrderByColumns;
      try
        if Distinct and (XList.Count > 0) then
          raise EnxInternalSQLException.Create(rsOrderFieldNotPresentInDistinctSelection);
        for i := 0 to XList.Count - 1 do begin
          SX := TnxSqlSimpleExpression.Create(Self);
          Term := TnxSqlTerm.Create(SX);
          Factor := TnxSqlFacColumn.Create(Term);
          FieldRef := TnxSqlFieldRef.Create(Factor);
          SplitAlias(StripQuotes(XList[i]), ColName, TabName);
          FieldRef.FieldNameStr := StripQuotes(ColName);
          FieldRef.TableNameStr := TabName;
          Factor.FieldRef := FieldRef;
          Term.AddFactor(Factor);
          SX.AddTerm(Term);
          if TabName <> '' then
            Columns.AddColumn(TabName + '.' + StripQuotes(ColName), SX, True)
          else
            Columns.AddColumn(StripQuotes(ColName), SX, True);
        end;
      finally
        nxFreeAndNil(XList);
      end;


  try
    if Recycle <> nil then begin
      if Recycle.IsTemp {and not Assigned(Recycle.Cursor.TableDescriptor.IndicesDescriptor)} then begin
        c := Columns.Count;
        if Recycle.FieldCount = c then begin
          HaveTable := True;
          for i := 0 to c - 1 do begin
            N := TnxSqlNode(Columns[i].Info);
            F := Recycle.FieldNC(i);
            if (F.GetType <> N.GetType(Context)) then begin
              HaveTable := False;
              Break;
            end;
          end;
          if HaveTable then begin
            {for small tables, it's faster to recycle,
             for large tables, it's faster to re-create}
            // can't safely do this - we may have references
            // to this table proxy further up the hierarchy (see issue #2197)
            //if Recycle.GetRecordCount < 100 then begin
              Recycle.Empty;
              Result := Recycle;
            //end else
            //  HaveTable := False;
          end;
        end;
      end;

      {
      -- can't safely do this - we may have references
      -- to this table proxy further up the hierarchy (see issue #2197)
      if IsExistsSubQuery or IsSubQuery then
        HaveTable:=false; }

      if not HaveTable then
        if Recycle <> nil then begin
          HaveData:=false;
          Recycle.Owner := nil;
          nxFreeAndNil(Recycle);
        end;
    end;

    if RequestLive and not IsSubQuery and DoLive(Context, Result) then begin
      if NormalLogging then
        LogNormal('Result is live');
      if Recycle <> nil then begin
        Recycle.Owner := nil;
        nxFreeAndNil(Recycle);
      end;
      exit;
    end;

    RequestLive := False;

    if SelectionList.Count=0 then
      raise EnxInternalSQLException.Create(rsQueryHasNoResultColumns);

    if not HaveTable then begin
      FieldDefList := TnxSqlFieldDefList.Create;
      try
        FillFieldDefList(FieldDefList, Context);

        Result := Database.CreateTemporaryTableWithoutIndex(Self,
          FieldDefList);
      finally
        for i := 0 to FieldDefList.Count - 1 do
          nxFreeAndNil(FieldDefList.Field[i].fdLocaleDesc);
        /// nxFreeAndNil(FieldDefList); deleted at end!
      end;
    end;

    if (CondExpWhere = nil)
    or not (CondExpWhere.HasStaticValue(Context) = hsvYes)
    or (CondExpWhere.AsBoolean(Context) = tsbTrue) then
      begin

        if RowBuilder = nil then begin
          FRowBuilder := TnxSqlRowBuilder.Create(
            Context, Self, nil, Database, ParentBlock, CondExpWhere, CopyBlobs, IsSelection);

          Assert(Assigned(TablesReferencedByOrder));
          for i := 0 to pred(TablesReferencedByOrder.Count) do begin
            if not Assigned(TablesReferencedByOrder[i].Table) then begin
              Assert(Assigned(TablesReferencedByOrder[i].TableExp));
              TablesReferencedByOrder[i].SetTable(TablesReferencedByOrder[i].TableExp.GetResultTable(Context, True));
            end;

            RowBuilder.Sources.Add(
              TnxSqlRowRange.Create(
                TablesReferencedByOrder[i].Table));
          end;

          HaveTable := False; {we must force row defs to be added to rowbuilder below}
        end;

        if not HaveTable then begin
          RowBuilder.ClearColumnList;

          Assert(Assigned(Columns));
          for i := 0 to pred(Columns.Count) do begin
            if TnxSqlSimpleExpression(Columns[i].Info).IsField(Context, F) then begin
              RowBuilder.AddColumnField(
                F,
                Result.FieldNC(i));
            end else begin
              RowBuilder.AddColumnExpression(
                TnxSqlSimpleExpression(Columns[i].Info),
                Result.FieldNC(i));
            end;
          end;
        end;

        {for i := 0 to Result.FieldCount - 1 do
          Result.FieldNC(i).IsTarget := False;}

        SkipDupTrimming:=true;
        if (Distinct or SpecialInSubquery) and NeedData then begin
          { If this is a select from a single base table
            and if the selection list contains only plain table columns
            and the source table contains a unique index (no nulls) on those columns
            - or a sub-set, then we know the result does not contain any duplicates.
            If SpecialDistinct is true, we further know that the remaining values
            are to be used in a comparison, so NULL values don't matter. In that
            case we can also use a unique index, which allows for NULLs}

          if VerboseLogging then
            LogVerbose('*** Distinct query');

          SkipDuptrimming := False;

          XList := TnxFastStringListIC.Create;
          IndexFieldList:= TList.Create;
          try
            F := nil;
            if (TablesReferencedByOrder.Count = 1)
            and not TablesReferencedByOrder[0].Table.IsTemp then begin
              SkipDupTrimming := True;
              for i := 0 to Columns.Count - 1 do
                if not TnxSqlSimpleExpression(Columns[i].Info).IsField(Context, F) then begin
                  SkipDupTrimming := False;
                  Break;
                end else
                begin
                  XList.Add(F.Name);
                  IndexFieldList.Add(f);
                end;
            end;

            SkipDupTrimming := SkipDupTrimming
              and TablesReferencedByOrder[0].Table.HasUniqueKeyOn(XList, SpecialDistinct);

            PresortIndex:='';
            if SpecialInSubquery then
            begin
              PresortIndex:=TablesReferencedByOrder[0].Table.IndexOnFields(IndexFieldList, false, true, true, IndexNames, true);
              if PresortIndex<>'' then
              begin
                TablesReferencedByOrder[0].Table.SetIndex(PresortIndex);
                // we don't need to trim dup cause we've changed the logic in procedure TnxSqlRowRange.ApplyRange to not iterate duplicates
                SkipDupTrimming:=true;
                lPresorted:=true;
              end;
            end;


//            commenting this out fixes issues #2265, #2287, #2288, #2290, & #2291

            // check if we can use index iteration
            if ((not SpecialInSubquery) or lPresorted) {and (not IsPSM)} and
              (CanUseIndexIterator(Context, nil, KeyIterateInfo.IndexIndex, IndexNames, KeyIterateInfo.KeyEngine, KeyIterateInfo.BaseTable, KeyIterateInfo.IndexDescriptor, FieldDefList)) then
            begin
              BaseCursor:= KeyIterateInfo.BaseTable.Cursor as TnxSqlAbstractCursor;


              T2 := FDatabase.CreateTemporaryTableWithoutIndex(KeyIterateInfo.BaseTable.Owner, FieldDefList);
              BackWards:=false;
              // check for order to figure out if we should iterate forward or backward
              if Assigned(OrderList) and Assigned(F) then
                if OrderList.Count=1 then begin
                 TmpOI := OrderList[0];
                 FieldNum := BaseCursor._Dictionary.GetFieldFromName(TmpOI.Column.QualifiedName);
                  if FieldNum=F.Index then
                  begin
                    // yes we need to order by the same field, so just use the index
                    // either forward or backward and set the orderstate
                    BackWards:=TmpOI.Descending;
                    RowBuilder.SortedState :=ssOrdered;
                  end;
                end;

              KeyIterateInfo.DestinationTable:=t2;
              KeyIterateInfo.BaseTable.SetIndex(IndexNames[KeyIterateInfo.IndexIndex]);
              try
                if HaveAggregates then
                  if AggList=nil then
                  begin
                    AggList:=TnxSqlAggregateList.Create(self);
                    AggList.OwnsItems := False;
                    aggListCreated:=true;
                    BuildAggList(Context, AggList);
                  end;



                if AggList<>nil then
                begin
                  for I := 0 to FieldDefList.Count - 1 do    // Iterate
                    if FieldDefList.Field[i].fdAggregate then
                      Break;
                  KeyIterateInfo.LastField:=i;
                end
                else
                  KeyIterateInfo.LastField:=KeyIterateInfo.DestinationTable.Cursor._Dictionary.FieldsDescriptor.FieldCount;

                KeyIterateInfo.FieldDefList := FieldDefList;

                SetLength(KeyIterateInfo.Expressions, KeyIterateInfo.LastField);
                SetLength(KeyIterateInfo.SourceFieldNames, KeyIterateInfo.LastField);
                SetLength(KeyIterateInfo.SourceFieldKeyIndices, KeyIterateInfo.LastField);
                SetLength(KeyIterateInfo.SourceFieldKeyOffsets, KeyIterateInfo.LastField);
                KeyFieldSource := KeyIterateInfo.KeyEngine;
                try
                  for I := 0 to KeyIterateInfo.LastField - 1  do begin
                    fdx := FieldDefList.Field[i].fdExpression;
                    if assigned(fdx) then begin
                      Assert(fdx is TnxSQLSimpleExpression);
                      F := nil;
                      if not TnxSQLSimpleExpression(fdx).IsField(Context, F)
                      and not TnxSQLSimpleExpression(fdx).IsAggregate(true) then begin
                        KeyIterateInfo.Expressions[i] := TnxSQLSimpleExpression(fdx);
                        KeyIterateInfo.SourceFieldNames[i] := '';
                      end else begin
                        KeyIterateInfo.Expressions[i] := nil;
                        if Assigned(F) then
                          KeyIterateInfo.SourceFieldNames[i] := F.Name
                        else
                          KeyIterateInfo.SourceFieldNames[i] := '';
                      end;
                      if KeyIterateInfo.SourceFieldNames[i] <> '' then begin
                        KeyIterateInfo.SourceFieldKeyIndices[i] := KeyFieldSource.GetFieldFromName(KeyIterateInfo.SourceFieldNames[i]);
                        if KeyIterateInfo.SourceFieldKeyIndices[i] >= 0 then
                          KeyIterateInfo.SourceFieldKeyOffsets[i] := KeyIterateInfo.KeyEngine.KeyFieldOffset[KeyIterateInfo.SourceFieldKeyIndices[i]]
                        else
                          KeyIterateInfo.SourceFieldKeyOffsets[i] := -1;
                      end else begin
                        KeyIterateInfo.SourceFieldKeyIndices[i] := -1;
                        KeyIterateInfo.SourceFieldKeyOffsets[i] := -1;
                      end;
                    end;
                  end;
                finally
                  KeyFieldSource := nil;
                end;

                nxGetMem(OldIteratorValue, KeyIterateInfo.KeyEngine.KeyLength + SizeOf(Pointer));
                try
                  fIsUniqueKeyIteration:=true;
                  KeyIterateInfo.Context:=Context;
                  //KeyIterateInfo.AggList2:=AggList;
                  if Assigned(AggList) then
                  begin
                    KeyIterateInfo.AggArrayCount := AggList.Count;
                    SetLength(KeyIterateInfo.AggArray, KeyIterateInfo.AggArrayCount);
                    for I := 0 to KeyIterateInfo.AggArrayCount - 1 do begin   // Iterate
                      TmpAgg := AggList[i];
                      TmpAgg.CreateCounter(TmpAgg.SimpleExpression, Context);
                      KeyIterateInfo.AggArray[i] := TmpAgg;
                    end;
                  end else begin
                    SetLength(KeyIterateInfo.AggArray, 0);
                    KeyIterateInfo.AggArrayCount := 0;
                  end;

                  KeyIterateInfo.DestinationTable.BeginBatchPostMode;
                  KeyIterateInfo.FieldsDescriptor := KeyIterateInfo.DestinationTable.Cursor._Dictionary.FieldsDescriptor;
                  try
                    if not lPresorted then
                      KeyIterateInfo.LoopProc:=nil;

                    if QuitAfterFirst then
                      LimitInt := 1;

                    KeyIterateInfo.BaseTable.Cursor.sbcIterate(nil, UniqueKeyIterator, nil, Backwards, @KeyIterateInfo);
                    if not fIsUniqueKeyIteration then
                      UniqueKeyIterator(@KeyIterateInfo, -1, nil);
                    KeyIterateInfo.DestinationTable.EndBatchPostMode(false);
                  except
                    KeyIterateInfo.DestinationTable.EndBatchPostMode(true);
                    raise;
                  end;
                finally
                  nxFreeMem(OldIteratorValue);
                end;
              finally
                // make sure that the temporary index is not active
                KeyIterateInfo.BaseTable.SetIndex('');
              end;
              if (OrderList<>nil) and (GroupColumnList<>nil) and (OrderList.Count<>GroupColumnList.Count) then
                RowBuilder.SortedState :=ssUnordered;

              Result.TransplantCursorFrom(T2);

              SkipDupTrimming:=true;
              NeedData:=false;
            end;

          finally
            XList.Free;
            IndexFieldList.Free;
          end;
        end;

        if NeedData then begin
          RowBuilder.TargetTable := Result;
          Database.StartTransaction([nil], False, True);
          try
            RowBuilder.LimitDependsOnMatchingSort := OrderList <> nil;
            if QuitAfterFirst then
              RowBuilder.Limit := 2 // was 1, but we need to know if there were more than 1
            else
            if (LimitInt >= 0) and not LimitPercent then begin
              RowBuilder.Limit := LimitInt;
              if LimitStart >= 1 then
                RowBuilder.LimitStart := LimitStart -1 {RowBuilder's counter is zero-based}
              else
                RowBuilder.LimitStart := 0;
              RowBuilder.LimitDependsOnMatchingSort := OrderList <> nil;
            end else
              RowBuilder.Limit := -1; // not limited

            if (OrderList <> nil) and not Distinct then begin
              RowBuilder.OrderByScope := FOrderByScope;
              RowBuilder.OrderByDescriptor := BuildOrderByIndex(Context, Result.Cursor.TableDescriptor, ResolveColumn, False, False);
            end else
              RowBuilder.OrderByDescriptor := nil;

            if CondExpWhere <> nil then
              RowBuilder.ContainsSearch := CondExpWhere.GetContainsPrimary
            else
              RowBuilder.ContainsSearch := nil;

            if assigned(RowBuilder.ContainsSearch) then
              if RowBuilder.Sources.Count > 1 then
                raise EnxInternalSQLException.Create(rsCONTAINSOnMultipleTablesNotSupported);

            Result.BeginBatchPostMode;
            try
              RowBuilder.Execute(Context, UseIndexes, nil, jmNone, nil, RecordsRead);
              Result.EndBatchPostMode(false);
            except
              Result.EndBatchPostMode(true);

              Result.Owner := nil;
              nxFreeAndNil(Result);

              raise;
            end;

            Database.Commit;
          except
            Database.AbortTransaction;
            raise;
          end;
        end;

        if not SkipDupTrimming then
        begin
          T2 := Result.CopyUnique(Context, Self, True, CopyBlobs, False, IsView, lPresorted);
          Result.TransplantCursorFrom(T2);
        end;

        if ((Parent is TnxSqlIn) and not SpecialInSubquery) or (Parent is TnxSqlCPMatch) then begin
          begin
            if RowBuilder.Limit <> LimitInt then begin
              // the RowBuilder couldn't do the limit for us

              idx:=Result.GetCurrentIndexIndex;
              // check if the index has been changed through further processing since
              // we checked on orderstate, e.g. if we have transplanted a cursor
              // if we don't have an index set on the result table then there's no issue
              if (idx>-1) and (RowBuilder<>nil) and (idx<>RowBuilder.fCheckedIndex) then
                RowBuilder.SortedState :=ssUnordered;

              DoOrderBy(Context, Result);
              DoLimit(Result);
            end;

            T2 := Result.CopySortedOnAllFields(Self);
            Result.TransplantCursorFrom(T2);
          end;
        end else begin
          idx:=Result.GetCurrentIndexIndex;
          // check if the index has been changed through further processing since
          // we checked on orderstate, e.g. if we have transplanted a cursor
          // if we don't have an index set on the result table then there's no issue
          if (idx>-1) and (RowBuilder<>nil) and (idx<>RowBuilder.fCheckedIndex) then
            RowBuilder.SortedState :=ssUnordered;

          DoOrderBy(Context, Result);
          DoLimit(Result);
        end;
      end;

    DoSystemRow(Result);

  finally
    if aggListCreated then
      nxFreeAndNil(AggList);
    if assigned(FieldDefList) then
      nxFreeAndNil(FieldDefList);
  end;
end;

function TnxSqlSELECT.AllColumnReferencesQualified(const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
begin
  if SelectionList <> nil then
    Result := SelectionList.AllColumnReferencesQualified(AliasName, QualRefList)
  else
    Result := False;
  if CondExpWhere <> nil then
    Result := Result and CondExpWhere.AllColumnReferencesQualified(AliasName, QualRefList);
  if CondExpHaving <> nil then
    Result := Result and CondExpHaving.AllColumnReferencesQualified(AliasName, QualRefList);
  if OrderList <> nil then
    Result := Result and OrderList.AllColumnReferencesQualified(AliasName, QualRefList);
end;

function TnxSqlSELECT.Simplify(Context: TnxSqlContext): Boolean;
{var
  i: Integer;
  Factors: TList;}
var
//  WasAdded: boolean;
{$ifdef remodelexists}
  aSelect: TnxSqlSELECT;
{$endif}
  i, j, k: Integer;
  JoinTableExp: TnxSqlJoinTableExp;
  InnerTableName: string;
  FoundFilter, CanDo: Boolean;
  InFactor: TnxSqlCondFactor;
  MasterTableName, MasterTableDatabase, MasterColumn,
  CorrelatedDatabase, CorrelatedTable, CorrelatedColumn: string;
  NewTableRef, NewTableRef2: TnxSqlTableRef;
  NewCondFactor: TnxSqlCondFactor;
  NewTerm: TnxSqlTerm;
  NewFactor: TnxSqlFacColumn;
  NewFieldRef: TnxSqlFieldRef;
  NewTableExp: TnxSqlTableExp;
  NewNonJoinTableExp: TnxSqlNonJoinTableExp;
  NewNonJoinTableTerm: TnxSqlNonJoinTableTerm;
  NewNonJoinTablePrimary: TnxSqlNonJoinTablePrimary;
  NewSelect: TnxSqlSELECT;
  NewSelection: TnxSqlSelection;
  NewSimplex: TnxSqlSimpleExpression;
  {$IFDEF PushFilters}
  NewCondExp: TnxSqlCondExp;
  NewCondTerm: TnxSqlCondTerm;
  NewCondPrimary: TnxSqlCPSimple;
  CondFactors: TnxSqlCondFactorArray;
  {$ENDIF}
  //QualRefList: TnxFastStringListIC;
  //OuterList: TList;
  //NormalList: TList;
  //NoJoins: TList;
  Found: Boolean;
  TableRef : TnxSqlTableRef;

begin
  fFirstSimplify:=false;

  if TableRefList=nil then
  begin
    TableRefList:=TnxSqlTableRefList.Create(self);
    TableRef := TnxSqlTableRef.Create(TableRefList);
    TableRef.TablenameStr := '#dummy';
    TableRef.DatabaseNameStr := '';
    TableRefList.Add(TableRef);
  end;

  if SelectionList <> nil then
    Result := SelectionList.Simplify(Context)
  else
    Result := False;
  Result := Result or TableRefList.Simplify(Context);
  if CondExpWhere <> nil then
    Result := Result or CondExpWhere.Simplify(Context);
  if CondExpHaving <> nil then
    Result := Result or CondExpHaving.Simplify(Context);

  if not Result then begin
    {if there's a left or right outer join in the sources,
     and if we have a where clause,
     and that where clause contains
       in every disjunction
         some non-null filter expression on the inner table of the outer join,
           then the join can be transformed into an inner join}
    for i := 0 to TableRefList.Count - 1 do
      if TableRefList[i].IsLeftOrRightJoin(JoinTableExp) then begin
        if JoinTableExp.JoinType = jtLeftOuter then begin
          InnerTableName := JoinTableExp.TableRef2.AliasStr;
          if InnerTableName = '' then
            InnerTableName := JoinTableExp.TableRef2.TablenameStr;
        end else begin
          {right outer}
          InnerTableName := JoinTableExp.TableRef1.AliasStr;
          if InnerTableName = '' then
            InnerTableName := JoinTableExp.TableRef1.TablenameStr;
        end;
        if InnerTableName <> '' then begin
          if CondExpWhere <> nil then begin
            CanDo := True;
            for j := 0 to CondExpWhere.CondTermCount - 1 do begin
              FoundFilter := False;
              for k := 0 to CondExpWhere.CondTerm[j].CondFactorCount - 1 do
                if CondExpWhere.CondTerm[j].CondFactor[k].IsNonNullFilterOn(InnerTableName) then begin
                  FoundFilter := True;
                  Break;
                end;
              if not FoundFilter then begin
                CanDo := False;
                Break;
              end;
            end;
            if CanDo then begin
              JoinTableExp.JoinType := jtInner;
              Result := True;
              exit;
            end;
          end;
        end;
      end else

(*      if TableRefList[i].IsFullJoin(JoinTableExp) then
      begin
        {if it's a full join and we have non-null filter expressions
         on either side, we can change those sides to inner joins}
        {try left first}
        InnerTableName := JoinTableExp.TableRef1.AliasStr;
        if InnerTableName = '' then
          InnerTableName := JoinTableExp.TableRef1.TablenameStr;
        if InnerTableName <> '' then begin
          if CondExpWhere <> nil then begin
            CanDo := True;
            for j := 0 to CondExpWhere.CondTermCount - 1 do begin
              FoundFilter := False;
              for k := 0 to CondExpWhere.CondTerm[j].CondFactorCount - 1 do
                if CondExpWhere.CondTerm[j].CondFactor[k].IsNonNullFilterOn(InnerTableName) then begin
                  FoundFilter := True;
                  Break;
                end;
              if not FoundFilter then begin
                CanDo := False;
                Break;
              end;
            end;
            if CanDo then begin
              JoinTableExp.JoinType := jtRightOuter;
              Result := True;
              exit;
            end;
          end;
        end;
        {no filter on left, try right}
        InnerTableName := JoinTableExp.TableRef2.AliasStr;
        if InnerTableName = '' then
          InnerTableName := JoinTableExp.TableRef2.TablenameStr;
        if InnerTableName <> '' then begin
          if CondExpWhere <> nil then begin
            CanDo := True;
            for j := 0 to CondExpWhere.CondTermCount - 1 do begin
              FoundFilter := False;
              for k := 0 to CondExpWhere.CondTerm[j].CondFactorCount - 1 do
                if CondExpWhere.CondTerm[j].CondFactor[k].IsNonNullFilterOn(InnerTableName) then begin
                  FoundFilter := True;
                  Break;
                end;
              if not FoundFilter then begin
                CanDo := False;
                Break;
              end;
            end;
            if CanDo then begin
              JoinTableExp.JoinType := jtLeftOuter;
              Result := True;
              exit;
            end;
          end;
        end;
      end;
*)
  end;
  if not Result
  and (CondExpWhere <> nil)
  and (TableRefList.Count = 1)
  and SelectionList.IsQualifiedColumnList(TableRefList[0].AliasStr) then begin
    {if there's a where clause containing a correlated IN clause,
      merge that IN clause into the current FROM list as a join.
     We can only do this if the original master table is qualified with an alias
     and if all items in the selection list are qualified columns from this table.
     This is because at this stage we don't otherwise know if the items in the
     selection list are indeed columns, and we would need to qualify them to
     disambiguate them.}
    MasterTableName := TableRefList[0].AliasStr;
    MasterTableDatabase := TableRefList[0].DatabaseNameStr;
    if MasterTableName <> '' then
      if CondExpWhere.ContainsCorrelatedInClause(MasterTableDatabase, MasterTableName, InFactor, MasterColumn,
          CorrelatedDatabase, CorrelatedTable, CorrelatedColumn) then
        if (not (InFactor.CondPrimary is TnxSqlCPIn)) or ((InFactor.CondPrimary is TnxSqlCPIn) and not TnxSqlCPIn(InFactor.CondPrimary).InClause.Negated) then
        begin
        {Add correlation table from sub-query to table ref list, add synthesized alias-name}
        NewTableRef := TnxSqlTableRef.Create(TableRefList);
        NewTableRef.AliasStr := 'flattened_in_table_' + IntToStr(TableRefList.Count);
        NewTableExp := TnxSqlTableExp.Create(NewTableRef);
        NewNonJoinTableExp := TnxSqlNonJoinTableExp.Create(NewTableExp);
        NewNonJoinTableTerm := TnxSqlNonJoinTableTerm.Create(NewNonJoinTableExp);
        NewNonJoinTablePrimary := TnxSqlNonJoinTablePrimary.Create(NewNonJoinTableTerm);
        NewSelect := TnxSqlSELECT.Create(NewNonJoinTablePrimary);
        NewTableRef2 := TnxSqlTableRef.Create(NewSelect);
        NewTableRef2.TablenameStr := CorrelatedTable;
        NewTableRef2.DatabaseNameStr := CorrelatedDatabase;
        NewSelect.TableRefList := TnxSqlTableRefList.Create(NewSelect);
        NewSelect.TableRefList.Add(NewTableRef2);
        NewSelect.Distinct := True;
        NewSelect.SpecialDistinct := True; // indicate that we don't care about NULL values
        NewSelect.SelectionList := TnxSqlSelectionList.Create(NewSelect);
        if CorrelatedColumn <> '' then begin
          NewSelection := TnxSqlSelection.Create(NewSelect.SelectionList);
          NewSimplex := TnxSqlSimpleExpression.Create(NewSelection);
          NewTerm := TnxSqlTerm.Create(NewSimplex);
          NewFactor := TnxSqlFacColumn.Create(NewTerm);
          NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
          NewFieldRef.FieldNameStr := CorrelatedColumn;
          NewFactor.FieldRef := NewFieldRef;
          NewTerm.AddFactor(NewFactor);
          NewSimplex.AddTerm(NewTerm);
          NewSelection.SimpleExpression := NewSimplex;
          NewSelect.SelectionList.Add(NewSelection);
        end;
        NewNonJoinTablePrimary.SelectSt := NewSelect;
        NewNonJoinTableTerm.NonJoinTablePrimary := NewNonJoinTablePrimary;
        NewNonJoinTableExp.NonJoinTableTerm := NewNonJoinTableTerm;
        NewTableExp.NonJoinTableExp := NewNonJoinTableExp;
        NewTableRef.TableExp := NewTableExp;
        TableRefList.Add(NewTableRef);
        {change in-clause into comparison-predicate}
        NewCondFactor := TnxSqlCondFactor.Create(InFactor.Parent);
        NewCondFactor.CondPrimary := TnxSqlCPSimple.Create(NewCondFactor);
        with TnxSqlCPSimple(NewCondFactor.CondPrimary) do begin

          if (InFactor.CondPrimary is TnxSqlCPIn) and TnxSqlCPIn(InFactor.CondPrimary).InClause.Negated then
            RelOp := roNE
          else
            RelOp := roEQ;

          SimpleExp1 := TnxSqlSimpleExpression.Create(NewCondFactor.CondPrimary);
          NewTerm := TnxSqlTerm.Create(SimpleExp1);
          NewFactor := TnxSqlFacColumn.Create(NewTerm);
          NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
          NewFieldRef.FieldNameStr := CorrelatedColumn;
          NewFieldRef.TableNameStr := NewTableRef.AliasStr;
          NewFactor.FieldRef := NewFieldRef;
          NewTerm.AddFactor(NewFactor);
          SimpleExp1.AddTerm(NewTerm);

          SimpleExp2 := TnxSqlSimpleExpression.Create(NewCondFactor.CondPrimary);
          NewTerm := TnxSqlTerm.Create(SimpleExp2);
          NewFactor := TnxSqlFacColumn.Create(NewTerm);
          NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
          NewFieldRef.FieldNameStr := MasterColumn;
          NewFieldRef.TableNameStr := MasterTableName;
          NewFieldRef.DatabaseNameStr := MasterTableDatabase;
          NewFactor.FieldRef := NewFieldRef;
          NewTerm.AddFactor(NewFactor);
          SimpleExp2.AddTerm(NewTerm);

        end;
        InFactor.Assign(NewCondFactor);
        NewCondFactor.Free;
        Result := True;
        exit;
      end;
  end;

// if it's simple EXISTS query we remodel it to a IN subselect
{$ifdef remodelexists}

  if not Result
  and (CondExpWhere <> nil)
  and (TableRefList.Count = 1)
  and (TableRefList[0].TablenameStr <> '')
  and (TableRefList[0].DatabaseNameStr = '')
  and (CondExpWhere.CondTermCount = 1)
  and (Parent is TnxSqlCPExists)
  and assigned(TnxSqlCPExists(Parent).OwnerSelect)
  and IsSubQuery then
  begin
    {look for correlation}
//    Found := False;
    aSelect:=TnxSqlSELECT(TnxSqlCPExists(Parent).OwnerSelect);
    if aSelect.CondExpWhere <> nil then begin    
      if aSelect.CondExpWhere.CondTermCount = 1 then begin {can't handle multiple EXISTS OR'ed together - issue #2333}
        MasterTableName := aSelect.TableRefList[0].TablenameStr;

        if CondExpWhere.CondTerm[0].CondFactorCount=1 then
          if CondExpWhere.CondTerm[0].CondFactor[0].IsCorrelationTo(MasterTableName, MasterColumn, CorrelatedColumn) then
          begin
            InFactor:=TnxSqlCPExists(Parent).Parent as TnxSQLCondFactor;
            if not InFactor.UnaryNot then
              with TnxSqlCPExists(Parent) do
                with TnxSqlSELECT(SubQuery) do
                  if CondExpHaving=nil then
                  begin
                    CorrelatedDatabase := TableRefList[0].DatabaseNameStr;
                    CorrelatedTable := TableRefList[0].TablenameStr;
                    // first we need to make sure that all columns are qualified
                    if aSelect.TableRefList[0].AliasStr<>'' then
                      aSelect.SelectionList.QualifyColumns(aSelect.TableRefList[0].AliasStr)
                    else
                      aSelect.SelectionList.QualifyColumns(MasterTableName);

                    // then we create a new subquery and IN condfactor
                    NewCondFactor := TnxSqlCondFactor.Create(aSelect.CondExpWhere);
                    NewCondFactor.CondPrimary := TnxSqlCPIn.Create(NewCondFactor);

                    NewSimplEx := TnxSqlSimpleExpression.Create(NewCondFactor.CondPrimary);
                    NewTerm := TnxSqlTerm.Create(NewSimplEx);
                    NewFactor := TnxSqlFacColumn.Create(NewTerm);
                    NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
                    NewFieldRef.FieldNameStr := MasterColumn;
                    NewFieldRef.TableNameStr := aSelect.TableRefList[0].AliasStr;
                    NewFactor.FieldRef := NewFieldRef;
                    NewTerm.AddFactor(NewFactor);
                    NewSimplEx.AddTerm(NewTerm);

                    TnxSqlCPIn(NewCondFactor.CondPrimary).SimpleExp:=NewSimplex;
                    TnxSqlCPIn(NewCondFactor.CondPrimary).InClause:=TnxSqlInSub.Create(NewCondFactor.CondPrimary);

                    NewSelect := TnxSqlSELECT.Create(TnxSqlCPIn(NewCondFactor.CondPrimary).InClause);
                    NewSelect.Distinct := True;
                    NewSelect.SpecialDistinct := True; // indicate that we don't care about NULL values
                    NewSelect.SelectionList := TnxSqlSelectionList.Create(NewSelect);
                    NewSelection := TnxSqlSelection.Create(NewSelect.SelectionList);

                    NewTableRef2 := TnxSqlTableRef.Create(NewSelect);
                    NewTableRef2.TablenameStr := CorrelatedTable;
                    NewTableRef2.DatabaseNameStr := CorrelatedDatabase;

                    NewSelect.TableRefList := TnxSqlTableRefList.Create(NewSelect);
                    NewSelect.TableRefList.Add(NewTableRef2);

                    NewSimplex := TnxSqlSimpleExpression.Create(NewSelection);
                    NewTerm := TnxSqlTerm.Create(NewSimplex);
                    NewFactor := TnxSqlFacColumn.Create(NewTerm);
                    NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
                    NewFieldRef.FieldNameStr := CorrelatedColumn;
                    NewFactor.FieldRef := NewFieldRef;
                    NewTerm.AddFactor(NewFactor);
                    NewSimplex.AddTerm(NewTerm);
                    NewSelection.SimpleExpression := NewSimplex;
                    NewSelect.SelectionList.Add(NewSelection);

                    TnxSqlInSub(TnxSqlCPIn(NewCondFactor.CondPrimary).InClause).SubQuery:=NewSelect;

                    // remove the old Exists cond factor and put in the new IN one
                    aSelect.CondExpWhere.CondTerm[0].RemoveFactor(InFactor);
                    aSelect.CondExpWhere.CondTerm[0].AddCondFactor(NewCondFactor);

                    // get rid of the old one
                    InFactor.Owner:=nil;
                    InFactor.Free;

                    Result := True;
                    exit;
                  end;
          end;
        end;
    end;
  end;
{$endif}

  // if the query is correlated,
  // and the from clause contains named tables
  // extract the table into a separate sub-query
  // so that missing indices can be added on the fly
  if not Result
  and (CondExpWhere <> nil)
  and (TableRefList.Count = 1)
  and (TableRefList[0].TablenameStr <> '')
  and (TableRefList[0].DatabaseNameStr = '')
  and (CondExpWhere.CondTermCount = 1)
  and (not (Parent is TnxSqlCPExists))
  and ((Owner=nil) or not (Owner is TnxSQLUpdate))
  and IsSubQuery then begin
    {look for correlation}
    Found := False;
    for i := 0 to CondExpWhere.CondTerm[0].CondFactorCount - 1 do
      if CondExpWhere.CondTerm[0].CondFactor[i].IsCorrelationTo(TableRefList[0].TablenameStr) then begin
        Found := True;
        Break;
      end;
    if Found then begin
      NewTableExp := TnxSqlTableExp.Create(TableRefList[0]);
      NewNonJoinTableExp := TnxSqlNonJoinTableExp.Create(NewTableExp);
      NewNonJoinTableTerm := TnxSqlNonJoinTableTerm.Create(NewNonJoinTableExp);
      NewNonJoinTablePrimary := TnxSqlNonJoinTablePrimary.Create(NewNonJoinTableTerm);
      NewSelect := TnxSqlSELECT.Create(NewNonJoinTablePrimary);
      NewTableRef2 := TnxSqlTableRef.Create(NewSelect);
      NewTableRef2.TablenameStr := TableRefList[0].TablenameStr;
      NewTableRef2.AliasStr := TableRefList[0].AliasStr;
      NewSelect.TableRefList := TnxSqlTableRefList.Create(NewSelect);
      NewSelect.TableRefList.Add(NewTableRef2);
      NewSelect.SelectionList := TnxSqlSelectionList.Create(NewSelect);
      NewSelection := TnxSqlSelection.Create(NewSelect.SelectionList);
      NewSimplex := TnxSqlSimpleExpression.Create(NewSelection);
      NewTerm := TnxSqlTerm.Create(NewSimplex);
      NewFactor := TnxSqlFacColumn.Create(NewTerm);
      NewFieldRef := TnxSqlFieldRef.Create(NewFactor);
      NewFactor.FieldRef := NewFieldRef;
      NewTerm.AddFactor(NewFactor);
      NewSimplex.AddTerm(NewTerm);
      NewSelection.SimpleExpression := NewSimplex;
      NewSelect.SelectionList.Add(NewSelection);
      NewNonJoinTablePrimary.SelectSt := NewSelect;
      NewNonJoinTableTerm.NonJoinTablePrimary := NewNonJoinTablePrimary;
      NewNonJoinTableExp.NonJoinTableTerm := NewNonJoinTableTerm;
      NewTableExp.NonJoinTableExp := NewNonJoinTableExp;
      TableRefList[0].TableExp := NewTableExp;
      if TableRefList[0].AliasStr = '' then
        TableRefList[0].AliasStr := TableRefList[0].TablenameStr;
      TableRefList[0].TablenameStr := '';
      Result := True;
      exit;
    end;
  end;
  {$IFDEF PushFilters}
  // If this is a join
  // and if we have a where clause
  //   with only conjunctions (no ORs)
  //   and with simple literal or parm filters on individual tables in the FROM list
  //   push those tables along with their filters into sub-queries in the FROM list.
  //   The subquery get the same alias name as the original source table.
  if not Result // not already doing a simplification?
  and (TableRefList.Count > 1) // is this a classical join?
  and assigned(CondExpWhere) // have a WHERE clause?
  and (CondExpWhere.CondTermCount = 1) // with no ORs?
  then begin
    for k := 0 to TableRefList.Count - 1 do begin
      NewTableRef := TableRefList[k];
      MasterTableName := NewTableRef.TablenameStr;
      if MasterTableName <> '' then begin
        SetLength(CondFactors, 0);
        if CondExpWhere.CondTerm[0].HasFiltersOn(MasterTableName, CondFactors) then begin
          // turn table ref with expl. table name into a sub-query
          NewTableRef.AliasStr := NewTableRef.TablenameStr;
          NewTableExp := TnxSqlTableExp.Create(NewTableRef);
          NewNonJoinTableExp := TnxSqlNonJoinTableExp.Create(NewTableExp);
          NewNonJoinTableTerm := TnxSqlNonJoinTableTerm.Create(NewNonJoinTableExp);
          NewNonJoinTablePrimary := TnxSqlNonJoinTablePrimary.Create(NewNonJoinTableTerm);
          NewSelect := TnxSqlSELECT.Create(NewNonJoinTablePrimary);
          NewTableRef2 := TnxSqlTableRef.Create(NewSelect);
          NewTableRef2.TablenameStr := NewTableRef.TablenameStr;
          NewTableRef2.DatabaseNameStr := NewTableRef.DatabaseNameStr;
          NewSelect.TableRefList := TnxSqlTableRefList.Create(NewSelect);
          NewSelect.TableRefList.Add(NewTableRef2);
          NewSelect.SelectionList := TnxSqlSelectionList.Create(NewSelect);
          NewSelect.SelectionList.AddSelectAll;
          NewNonJoinTablePrimary.SelectSt := NewSelect;
          NewNonJoinTableTerm.NonJoinTablePrimary := NewNonJoinTablePrimary;
          NewNonJoinTableExp.NonJoinTableTerm := NewNonJoinTableTerm;
          NewTableExp.NonJoinTableExp := NewNonJoinTableExp;
          NewTableRef.TableExp := NewTableExp;
          NewTableRef.TablenameStr := '';
          NewTableRef.DatabaseNameStr := '';
          NewTableRef.IsAutoFilter := True; // flag to prevent further cloning of transitive closures for this table
          NewCondExp := TnxSqlCondExp.Create(NewSelect);
          NewCondTerm := TnxSqlCondTerm.Create(NewCondExp);
          NewCondExp.AddCondTerm(NewCondTerm);
          NewSelect.CondExpWhere := NewCondExp;
          // clone outer filter conditions into the sub-query
          for j := 0 to high(CondFactors) do
            NewCondTerm.AddCondFactor(CondFactors[j].Clone(NewCondTerm) as TnxSqlCondFactor);
          // remove outer filter conditions just cloned
          for j := high(CondFactors) downto 0 do begin
            CondExpWhere.CondTerm[0].RemoveFactor(CondFactors[j]);
            CondFactors[j].Free;
          end;
          Result := True;
          exit;
        end;
      end;
    end;
  end;
  {$ENDIF}
end;

function TnxSqlSELECT.TableWithCount(const ColumnName : string; Negate: Boolean; Recycle: TnxSqlTableProxy): TnxSqlTableProxy;
var
  FieldDefList: TnxSqlFieldDefList;
  F: TnxsqlFieldProxy;
  RecordCount: TnxInt64;
begin
  Result := nil;
  if Recycle <> nil then begin
    if Recycle.IsTemp and not Assigned(Recycle.Cursor.TableDescriptor.IndicesDescriptor) then
      if Recycle.FieldCount = 1 then begin
        F := Recycle.FieldNC(0);
        if (F.GetType = nxtInt64) then begin
          Recycle.Empty;
          Result := Recycle;
          Recycle := nil;
        end;
      end;
    if Recycle <> nil then begin
      Recycle.Owner := nil;
      nxFreeAndNil(Recycle);
    end;
  end;
  if Result = nil then begin
    FieldDefList := TnxSqlFieldDefList.Create;
    try
      FieldDefList.AddField(ColumnName, '', nxtInt64, 8, 0, 1, 1, False, dtNull, null{nil}, [aaClient, aaServer], True, False, False, False, nil, False);
      Result := Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      nxFreeAndNil(FieldDefList);
    end;
  end;
  Database.StartTransaction([nil], False, True);
  try
    Result.Insert;
    RecordCount := TablesReferencedByOrder[0].Table.GetRecordCount;
    if Negate then
      RecordCount := -RecordCount;
    Result.FieldNC(0).SetValue(RecordCount);
    Result.Post;
    Database.Commit;
  except
    Database.AbortTransaction;
    raise;
  end;
end;

function TnxSqlSELECT.TargetFieldFromSourceField(
  Context: TnxSqlContext; const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
var
  i: Integer;
begin
  for i := 0 to pred(Columns.Count) do
    if Columns[i].Info = F then begin
      Result := GetResultTable(Context, False).FieldNC(i);
      exit;
    end;
  Result := nil;
end;

function TnxSqlSELECT.ToString: WideString;
var
  S: string;
begin
  Result := 'SELECT';
  if Distinct then
    Result := Result + ' DISTINCT'{
  else
    Result := Result + ' ALL'};
  if LimitInt >= 0 then
    Result := Result + ' TOP ' + IntToStr(LimitInt);
  if LimitPercent then
    Result := Result + ' PERCENT';
  if LimitStart <> -1 then
    Result := Result + ', ' + IntToStr(LimitStart);
  if SelectionList = nil then
    Result := Result + ' *'
  else begin
    S := SelectionList.ToString;
    if trim(S) = '' then
      Result := Result + ' *'
    else
      Result := Result + S;
  end;
  if TargetTablestr <> '' then begin
    Result := Result + ' INTO ';
    if TargetDatabasestr <> '' then
      Result := Result + TargetDatabasestr + '.';
    Result := Result + TargetTablestr;
  end;
  if TableRefList<>nil then
  begin
    Result := Result + ' FROM';
    Result := Result + TableRefList.ToString;
  end;
  if CondExpWhere <> nil then
    Result := Result + ' WHERE' + CondExpWhere.ToString;
  if GroupColumnList <> nil then
    Result := Result + ' GROUP BY' + GroupColumnList.ToString;
  if CondExpHaving <> nil then
    Result := Result + ' HAVING' + CondExpHaving.ToString;
  if OrderList <> nil then
    Result := Result + ' ORDER BY ' + OrderList.ToString;
end;

procedure TnxSqlSELECT.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  if IncludeNested then begin
    Callback(Self, UserData);
    if SelectionList <> nil then
      SelectionList.Traverse(Callback, UserData, IncludeNested);
    if TableRefList <> nil then
      TableRefList.Traverse(Callback, UserData, IncludeNested);
    if CondExpWhere <> nil then
      CondExpWhere.Traverse(Callback, UserData, IncludeNested);
    if GroupColumnList <> nil then
      GroupColumnList.Traverse(Callback, UserData, IncludeNested);
    if CondExpHaving <> nil then
      CondExpHaving.Traverse(Callback, UserData, IncludeNested);
    if OrderList <> nil then
      OrderList.Traverse(Callback, UserData, IncludeNested);
  end;
end;

procedure TnxSqlSELECT.Unbind;
var
  i: Integer;
  N: TnxSqlNode;
begin
  snBeginUse;
  try
    if TableRefList <> nil then
      TableRefList.Unbind;
    nxFreeAndNil(FRowBuilder);
    if CondExpWhere <> nil then
      CondExpWhere.Unbind;
    if CondExpHaving <> nil then
      CondExpHaving.Unbind;
    if assigned(Columns) then
      for i := 0 to pred(Columns.Count) do begin
        N := TnxSqlNode(Columns[i].Info);
        if (N <> nil)
        and (N is TnxSqlSimpleExpression) then
          TnxSqlSimpleExpression(N).Unbind;
      end;

    ClearTableList;
    if FResultTable<>nil then
      if FResultTable.Owner=self then
        nxFreeAndnil(FResultTable);

    Bound := -1;
    BoundGen := -1;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlSELECT.UnbindIfRequired(Context: TnxSqlContext);
var
  i: Integer;
begin
  if _LockUnbindIfRequired < 1 then
    if (Bound > 0) and ((Bound <> Context.ContextID) or (BoundGen <> Context.Generation)) then begin
      // this indicates we're dealing with a prepared query. We can't use external indices
      // after the first call as potentially in between something was changed, thus we need to rebind
      for I := 0 to TableRefList.Count-1 do
      begin
        if TableRefList[i].Table<>nil then begin
          if TableRefList[i].Table.HasExternalIndices then begin
            Unbind;
            Break;
          end;
        end;
        // similarily we need to unbind if we have outer joins
        if (TnxSqlTableRef(TableRefList[i]).TableExp<>nil) and (TnxSqlTableRef(TableRefList[i]).TableExp.JoinTableExp<>nil) and
          (TnxSqlTableRef(TableRefList[i]).TableExp.JoinTableExp.FJoinType in [jtLeftOuter, jtRightOuter, jtFullOuter]) then begin
          Unbind;
          Break;
        end;
      end;
    end;
end;

procedure TnxSqlSELECT.FillFieldDefList(FieldDefList: TnxSqlFieldDefList; Context: TnxSqlContext);
var
  IsAggregate: Boolean;
  Locale: TnxLocaleDescriptor;
  i: Integer;
  N: TnxSqlNode;
  Col: TnxColumn;
  Name: string;
  s: string;
  AlwaysWide: Boolean;
  lType:TnxFieldType;
begin
  s := '';
  Context.DatabaseProxy.ServerDatabase.esoOptionGetEffective('$SQL$RESULTSET_ALWAYS_WIDE', s);
  AlwaysWide := SameText(s, 'true');

  Assert(Assigned(Columns));
  FOrderByScope.Clear;
  for i := 0 to pred(Columns.Count) do begin
    Col := Columns[i];
    Name := Col.Name;
    N := TnxSqlNode(Col.Info);
    IsAggregate := false;
    Locale := nil;
    if (N is TnxSqlSimpleExpression) then begin
      IsAggregate := TnxSqlSimpleExpression(N).IsAggregate(true);
      if TnxSqlSimpleExpression(N).IsNullLiteral then
        raise EnxInternalSQLException.Create(rsNULLMustBeCastToSpecificType);
      Locale := TnxSqlSimpleExpression(N).GetLocaleDesc(Context);
    end;

    lType := N.GetType(Context);
    if AlwaysWide then
      case lType of
        nxtChar:
          lType := nxtWideChar;
        nxtBlobMemo:
          lType := nxtBlobWideMemo;
        nxtShortString,
        nxtNullString:
          lType := nxtWideString;
      end;

    FieldDefList.AddField(Name, '', lType, N.GetSize(Context), N.GetDecimals(Context), 1, 1, False, dtNull, null, [aaClient, aaServer], True, False, False, {nil} Col.Hidden, Locale, IsAggregate, N);
    FOrderByScope.AddColumn(Name);
  end;
end;

procedure TnxSqlSELECT.DoLimit({var }Table: TnxSqlTableProxy);
var
  LimitValue,
  LimitBegin,
  RecordCount: int64;
  T2: TnxSqlTableProxy;
begin
  if (RowBuilder<>nil) and (RowBuilder.Limit = LimitInt) then
    exit;

  if LimitInt >= 0 then begin
    LimitBegin := LimitStart;
    RecordCount := Table.GetRecordCount;
    if LimitPercent then begin
      if LimitInt = -1 then
        LimitValue := RecordCount
      else
        LimitValue := LimitInt * RecordCount div 100;
    end else
      if LimitInt = -1 then
        LimitValue := RecordCount
      else
        LimitValue := LimitInt;
    if LimitStart>RecordCount then
      Table.Empty
    else
    if (LimitStart>0) or ((LimitValue >= 0) and (LimitValue < RecordCount)) then begin
      T2 := Table.CopyLimited(Table.Owner, LimitValue, LimitBegin, CopyBlobs, IsView);
      if assigned(RowBuilder) then begin
        if RowBuilder.FieldCopier.ContainsBlobFields then begin
          RowBuilder.Free;
          FRowBuilder := nil;
        end;
      end;
      Table.TransplantCursorFrom(T2);

      {
      Table.Owner := nil;
      nxFreeAndNil(Table);
      Table := T2;
      }
    end;
  end;
end;

procedure TnxSqlSELECT.LoadFromStream(Stream: TnxSqlPSMReader);
var
  nodeopt: TnxSqlNode;
  version: integer;
begin
  Distinct := Stream.ReadBool;
  fFixedLimitInt := Stream.ReadInt;
  LimitStart := Stream.ReadInt;
  LimitPercent := Stream.ReadBool;
  SelectionList := TnxSqlSelectionList(Stream.ReadNodeOpt(Self));
  TargetTableStr := Stream.ReadLString;
  TargetDatabasestr := Stream.ReadLString;
  TableRefList := Stream.ReadNode(Self) as TnxSqlTableRefList;
  CondExpWhere := TnxSqlCondExp(Stream.ReadNodeOpt(Self));
  GroupColumnList := TnxSqlGroupColumnList(Stream.ReadNodeOpt(Self));
  CondExpHaving := TnxSqlCondExp(Stream.ReadNodeOpt(Self));
  OrderList := TnxSqlOrderList(Stream.ReadNodeOpt(Self));

  version:=fFixedLimitInt;

  if version<-100 then
  begin
    nodeopt:=Stream.ReadNodeOpt(Self);
    if nodeopt<>nil then
        LimitIntFactor:=TnxSqlFacParm.Create(nodeopt);
    fFixedLimitInt:=Stream.ReadInt;
  end;
  if version<-101 then
  begin
    nodeopt:=Stream.ReadNodeOpt(Self);
    if (nodeopt<>nil) and (nodeopt is TnxSQLSimpleExpression) then
        fLimitIntExp:=TnxSQLSimpleExpression(nodeopt);
  end;
end;

procedure TnxSqlSELECT.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteBool(Distinct);
  Stream.WriteInt(-102); // version hack
  Stream.WriteInt(LimitStart);
  Stream.WriteBool(LimitPercent);
  Stream.WriteNodeOpt(SelectionList);
  Stream.WriteLString(TargetTableStr);
  Stream.WriteLString(TargetDatabasestr);
  Stream.WriteNode(TableRefList);
  Stream.WriteNodeOpt(CondExpWhere);
  Stream.WriteNodeOpt(GroupColumnList);
  Stream.WriteNodeOpt(CondExpHaving);
  Stream.WriteNodeOpt(OrderList);
  Stream.WriteNodeOpt(LimitIntFactor);
  Stream.WriteInt(FixedLimitInt);
  Stream.WriteNodeOpt(LimitIntExp);
end;

function TnxSqlSELECT.GetTargetTableStr: string;
begin
  if FTargetTable <> nil then
    Result := TokenToStrStripQ(FTargetTable)
  else
    Result := FTargetTableStr;
end;

procedure TnxSqlSELECT.SetTargetTableStr(const Value: string);
begin
  if GetTargetTableStr <> Value then begin
    FTargetTableStr := Value;
    FTargetTable := nil;
  end;
end;

function TnxSqlSELECT.IsSelection: Boolean;
begin
  Result :=
    (Parent is TnxSqlFacSub)
    or (Parent is TnxSqlAllOrAnyClause)
    or (Parent is TnxSqlCPExists)
    or (Parent is TnxSqlCPMatch)
    or (Parent is TnxSqlInSub);
end;

(*
function TnxSqlSELECT.IsSingletableStarSelection(
  var TableName: string): Boolean;
begin
  Result := False;
  if assigned(CondExpHaving) then exit;
  if assigned(CondExpWhere) then exit;
  if Distinct then exit;
  if assigned(GroupColumnList) then exit;
  if LimitInt <> -1 then exit;
  if assigned(OrderList) then exit;
  if not SelectionList.IsStarSelection then exit;
  if TableRefList.Count <> 1 then exit;
  if TargetTablestr <> '' then exit;
  if TableRefList[0].DatabaseNameStr <> '' then exit;
  if assigned(TableRefList[0].TableExp) then exit;
  if TableRefList[0].FuncNameStr <> '' then exit;
  TableName := TableRefList[0].TablenameStr;
  Result := True;
end;
*)

function TnxSqlSELECT.GetTargetDatabaseStr: string;
begin
  if FTargetDatabase <> nil then
    Result := TokenToStrStripQ(FTargetDatabase)
  else
    Result := FTargetDatabaseStr;
end;

procedure TnxSqlSELECT.SetLimitInt(const Value: Integer);
begin
  FLimitInt:=value;
end;

procedure TnxSqlSELECT.SetLimitIntExp(const Value: TnxSqlSimpleExpression);
begin
  fLimitIntExp := Value;
end;

procedure TnxSqlSELECT.SetLimitIntFactor(const Value: TnxSqlFacParm);
begin
  fLimitIntFactor := Value;
end;

procedure TnxSqlSELECT.SetLimitPercent(const Value: Boolean);
begin
  FLimitPercent := Value;
end;

procedure TnxSqlSELECT.SetLimitStart(const Value: Integer);
begin
  FLimitStart := Value;
end;

procedure TnxSqlSELECT.SetLimitStartExp(const Value: TnxSqlSimpleExpression);
begin
  fLimitStartExp := Value;
end;

procedure TnxSqlSELECT.SetLimitStartFactor(const Value: TnxSqlFacParm);
begin
  fLimitStartFactor := Value;
end;

procedure TnxSqlSELECT.SetTargetDatabaseStr(const Value: string);
begin
  if GetTargetDatabaseStr <> Value then begin
    FTargetDatabaseStr := Value;
    FTargetDatabase := nil;
  end;
end;

function TnxSqlSELECT.RefersTo(const aTableName: string): Boolean;
begin
  Result :=
    not TableRefList.HasSuchAlias(aTableName)
    and (SameText(TargetTablestr, aTableName)
      or SelectionList.RefersTo(aTableName)
      or TableRefList.RefersTo(aTableName)
      or assigned(CondExpWhere) and CondExpWhere.RefersTo(aTableName)
      or assigned(CondExpHaving) and CondExpHaving.RefersTo(aTableName));
end;

function TnxSqlSELECT.RefersTo2(const aTableName,
  aColumnName: string): Boolean;
begin
  Result :=
    SelectionList.RefersTo(aTableName, aColumnName)
    or ((OrderList<>nil) and OrderList.RefersTo(aTableName, aColumnName))
    or ((GroupColumnList<>nil) and GroupColumnList.RefersTo(aTableName, aColumnName))
    or TableRefList.RefersTo(aTableName, aColumnName)
    or assigned(CondExpWhere) and CondExpWhere.RefersTo(aTableName, aColumnName)
    or assigned(CondExpHaving) and CondExpHaving.RefersTo(aTableName, aColumnName);
end;

function TnxSqlSELECT.RefersToTemp: Boolean;
begin
  Result := TableRefList.RefersToTemp;
end;

function TnxSqlSELECT.IsResultTable(T: TnxSqlTableProxy): Boolean;
begin
  Result := (T = FResultTable) or TableRefList.IsResultTable(T);
end;

function TnxSqlSELECT.IsCorrelatedSubquery(Context: TnxSqlContext): Boolean;
begin
  if Bound < 1 then
    Bind(True, Context);
  Result := IsDependent;
end;

function TnxSqlSELECT.IsView: Boolean;
var
  Look: TnxSqlNode;
begin
  Look := Parent;
  while Look <> nil do begin
    if Look is TnxSqlCREATEVIEW then begin
      Result := True;
      exit;
    end;
    Look := Look.Parent;
  end;
  Result := False;
end;

function TnxSqlSELECT.UniqueKeyIterator(aCookie: Pointer;
  aRefNr: TnxRefNr; aKey: PnxKeyBuffer): TnxKeyIteratorResult;


  procedure UpdateAggregates(aI: PnxSqlKeyIterateInfo);
  var
    anAgg: TnxSQLAggregate;
    I: Integer;
  begin
    for I := 0 to ai.AggArrayCount - 1 do    // Iterate
    begin
      anAgg:=ai.AggArray[i];
      if anAgg.AgFunction = agCount then
        anAgg.Counter.Increment;
    end;
  end;

var
  aI: PnxSqlKeyIterateInfo;
  I: Integer;
  aValue: Variant;
  //KeyFieldIndex: Integer;
  //F: TnxSQlFieldProxy;
begin
  aI:=PnxSqlKeyIterateInfo(aCookie);

  // this function is called from an index iteration
  // CAREFUL: the unique records are written AFTER new key value is found, thus
  // the function needs to be called manually (with akey=nil) after a full
  // iteration to write the last record to the destination.
  // This at first sight illogical implementation was chosen to allow for
  // aggregates being calculated on the fly without the need for a second
  // iteration.

  if fIsUniqueKeyIteration then
  begin
    // on first run we simply memorize the key
    if akey<>nil then
      ai.KeyEngine.CopyKey(aKey, OldIteratorValue);
    fIsUniqueKeyIteration:=false;
    Result := kirSkipKey;
    exit;
  end;

  if (aKey=nil) or (aI.KeyEngine.CompareKey(OldIteratorValue, aKey, ai.LastField, 0)<>0) then
  begin
    // the key has changed, so we calculate the aggregates
    UpdateAggregates(ai);

    if assigned(ai.LoopProc) then
    begin
      ai.LoopProc(ai);
    end
    else
    begin
      // and insert a new record
      ai.DestinationTable.Insert;
      // copy normal fields (REMEMBER: we are writing the OLD value and not the new one
      for I := 0 to ai.LastField-1  do // Iterate
        if ai.SourceFieldKeyOffsets[i] >= 0 then
          if not nxIsBitSet(OldIteratorValue, ai.SourceFieldKeyIndices[i]) then
            ai.DestinationTable.Cursor._Dictionary.FieldsDescriptor.SetRecordField(i, ai.DestinationTable.RecordBuffer,
              @OldIteratorValue[ai.SourceFieldKeyOffsets[i]]);

      for I := 0 to ai.LastField-1  do    // Iterate
        if ai.Expressions[i] <> nil then
        //if ai.FieldDefList.Field[i].fdExpression<>nil then
          //if not TnxSQLSimpleExpression(ai.FieldDefList.Field[i].fdExpression).IsField(ai.Context, F) and not TnxSQLSimpleExpression(ai.FieldDefList.Field[i].fdExpression).IsAggregate(true) then
          begin
            ai.Context.fIteratorValues:=OldIteratorValue;
            ai.Context.fIteratorData:=aI;
            try
              //aValue:=TnxSQLSimpleExpression(ai.FieldDefList.Field[i].fdExpression).GetValue(ai.Context);
              aValue := ai.Expressions[i].GetValue(ai.Context);
              ai.FieldsDescriptor.FieldByIndexAsVariant[ai.DestinationTable.RecordBuffer, i] := aValue;
            finally
              ai.Context.fIteratorValues:=nil;
              ai.Context.fIteratorData:=nil;
            end;
          end;



      for I := 0 to ai.AggArrayCount - 1 do    // Iterate
      begin
        with ai.AggArray[i] do begin
          ai.FieldsDescriptor.
            FieldByIndexAsVariant[ai.DestinationTable.RecordBuffer, i+ai.LastField] :=
              Counter.Count;
          Counter.Reset;
        end;
      end;
      // post the changes (hopefully BatchPost was initiated before the iteration
      ai.DestinationTable.Post;
      if LimitInt=1 then
      begin
        result:=kirStop;
        exit;
      end;
    end;

    // memorize the key
    if aKey<>nil then
      ai.KeyEngine.CopyKey(aKey, OldIteratorValue);
  end
  else
    // the key stayed the same, so we only update the aggregates
    UpdateAggregates(ai);

  // jump to next key
  result:=kirSkipKey;
end;

{function TnxSqlSELECT.UniqueRecordIterator(aCookie: Pointer;
  aRefNr: TnxRefNr; aRecord: PnxRecordBuffer): TnxRecordIteratorResult;
begin
  //
  Result:=rirContinue;
end;}

function TnxSqlSELECT.CanUseIndexIterator(Context: TnxSqlContext; AggList: TnxSqlAggregateList;
  var IndexIndex: integer; var IndexNames: TnxSQLStringArray; var anEngine: TnxBaseKeyEngine;
  var aTable: TnxSQLTableProxy; var aDescriptor: TnxIndexDescriptor; FieldDefList: TnxSqlFieldDefList): boolean;
var
  FirstField: string;
  I: Integer;
  FieldNum: integer;
  S: string;
  aList: TnxFastStringListIC;
  aName: string;
  FieldList: TList;
  F: TnxSqlFieldProxy;
  aggFound: Boolean;
begin
  result:=false;
  anEngine:=nil;
  aTable:=nil;
  aDescriptor:=nil;
  IndexIndex:=-1;

  // we can't use index iteration at the moment if we have more than one table referenced
  // investigate further in future
  if (TablesReferencedByOrder.Count <> 1) then
    exit;

  (* !!!! Hannes, fix for issue #2228 - apparently we can't use this if there's a WHERE condition at all *)
  // we can't use index iteration if there's a where clause with ors attached
  if (CondExpWhere<>nil) (* and (CondExpWhere.CondTermCount>1) *) then
    exit;

  if (CondExpHaving <> nil) and (CondExpHaving.CondTermCount>0) then
    exit;


{  if not TnxSqlSimpleExpression(Columns[0].Info).IsField(Context, F) then
    exit;   }

  if VerboseLogging then
    LogVerbose('Looking for index to iterate grouping');

  if (CondExpWhere<>nil) and (CondExpWhere.CondTermCount>0) then
  begin
    if (GroupColumnList<>nil) and  (GroupColumnList.Count>0) then
      exit; // can't use index iteration
    if (CondExpHaving<>nil) and (CondExpHaving.CondTermCount>0) then
      exit; // can't use index iteration
  end;

  DoCheckValidSelection(Context);

  aggFound:=false;
  // make sure that we only use index iteration if all aggregates are after
  // the last field reference
  // XXX the logic can *possibly* improved to avoid this condition

  if FieldDefList=nil then
    exit;

  for I := 0 to FieldDefList.Count-1 do
  begin
    if FieldDefList.Field[i].fdAggregate then
      aggFound:=true
    else
      if aggFound then
        exit;
  end;
    

  FieldList:=TList.Create;
  try
    if GroupColumnList=nil then
    begin
      for I := 0 to Columns.Count - 1 do    // Iterate
      begin
        if TnxSqlSimpleExpression(Columns[i].Info).IsField(Context, F) then
          FieldList.Add(f)
        else
        begin
          if not TnxSqlSimpleExpression(Columns[i].Info).IsAggregateExpression(true) then
          begin
            result:=false;
            exit;
          end;
        end;
      end;    // for
    end
    else
    begin
      aList:=TnxFastStringListIC.Create;
      try
        for I := 0 to Columns.Count - 1 do
          if TnxSqlSimpleExpression(Columns[i].Info).IsField(Context, F) then
            aList.Add(F.Name);



        for I := 0 to GroupColumnList.Count - 1 do    // Iterate
        begin
          S := (GroupColumnList.Item[i] as TnxSqlGroupColumn).QualifiedName(nil);
          F:=TablesReferencedByOrder[0].Table.FieldByName(s);

          if (f<>nil) and (aList.Count>0) and (i<aList.Count) and not SameText(F.Name,aList[i]) then
          begin
            // Grouping order <> column field order
            result:=false;
            exit;
          end;

          FieldNum := -1;
          if f<>nil then
            FieldNum := TablesReferencedByOrder[0].Table.FieldByName(s).Index
          else
          if Assigned(TablesReferencedByOrder[0].Table.Cursor) then          
            FieldNum := ResolveGroupColumn(Context, TablesReferencedByOrder[0].Table.Cursor._Dictionary, S);

          if FieldNum = -1 then begin
            {FieldNum := i;}
            Result := False;
            exit;
          end;

          FieldList.Add(TablesReferencedByOrder[0].Table.FieldC(FieldNum));
        end;    // for
      finally
        aList.Free;
      end;
    end;

    aName:=TablesReferencedByOrder[0].Table.IndexOnFields(FieldList, false, true, false, IndexNames, true);
    if aName='' then
      if VerboseLogging then
        LogVerbose('No current index found');

    if (aName='') and TablesReferencedByOrder[0].Table.IsTemp then
    begin
      if VerboseLogging then
        LogVerbose('Table is temp result - creating index for grouping!');
      aList:=TnxFastStringListIC.Create;
      try
        for I := 0 to FieldList.Count - 1 do    // Iterate
        begin
          assert(TObject(FieldList[i]) is TnxSqlFieldProxy);
          aList.Add(TnxSqlFieldProxy(FieldList[i]).Name);
        end;    // for
        TablesReferencedByOrder[0].Table.AddIndex('tempdistinctindex', '', aList, idAll, False, False);
        if TablesReferencedByOrder[0].Table.GetIndexIndex('tempdistinctindex')<>-1 then
          aName:='tempdistinctindex'
        else
          aName:='';
      finally
        aList.Free;
      end;
    end;
    if FieldList.Count>0 then
    begin
      assert(TOBject(FieldList[0]) is TnxSqlFieldProxy);
      FirstField:=uppercase(TnxSqlFieldProxy(FieldList[0]).Name);
    end
    else
      FirstField:='';
  finally
    nxFreeAndNil(FieldList);
  end;
//  IndexCount:=TablesReferencedByOrder[0].Table.IndexesOnField(F, false, true, false, IndexNames);

  if aName<>'' then
  begin
    aTable:=TablesReferencedByOrder[0].Table;
    aDescriptor:=aTable.Cursor.TableDescriptor.IndicesDescriptor.IndexDescriptor[aTable.GetIndexIndex(aName)];
    if aTable.Cursor is TnxServerTableCursor then begin
      anEngine:=TnxServerTableCursor(aTable.Cursor).Table.IndicesEngine.Indices[aTable.GetIndexIndex(aName)].KeyEngine;
      if anEngine is TnxCompKeyEngine then
        // make sure that the key and record format are the same
        if TnxCompKeyEngine(anEngine).KeyFieldEngine[0].KeySameAsRecordFormat then
          if aDescriptor.KeyDescriptor.Filter=nil then
          begin
             // now we need to check that where condition is not referencing any other fields
             // than the first in the index and is an equal
            if (CondExpWhere<>nil) and (CondExpWhere.CondTermCount>0) then
            begin
              if CondExpWhere.CondTerm[0].CondFactorCount>1 then
                exit;
              if not (CondExpWhere.CondTerm[0].CondFactor[0].RefersTo(aTable.Name, FirstField)) then
                exit;
            end;

            // we found a suitable index!
            SetLength(IndexNames, 1);
            IndexNames[0]:=aName;
            IndexIndex:=0;
            if NormalLogging then
              LogNormal('Using index "'+aName+'" to iterate.');
            result:=true;
          end;
    end;
  end;
end;

procedure{function} TnxSqlSELECT.BuildAggList(Context: TnxSqlContext;
  var aAggList: TnxSQLAggregateList){: boolean};
begin
  aAggList.Clear;
  if BindingContext=nil then
    BindingContext:=Context;
  SelectionList.Traverse(EnumAggregates, aAggList, False);
  if CondExpHaving <> nil then
    CondExpHaving.Traverse(EnumAggregates, aAggList, False);
end;

function TnxSqlSELECT.Volatile(Context: TnxSQLCOntext): Boolean;
var
  lParent: TnxSQLNode;
begin
  if FVolatile = svUnchecked then begin
    FVolatile := svNo {svContext?};

    if FVolatile < svContext then
      if Context.IsSqlFilter then
        FVolatile := svContext;

    if FVolatile < svGeneration then begin
      if IsPSMLoop then
        FVolatile := svGeneration;
      lParent := Parent;
      while (FVolatile < svGeneration) and Assigned(lParent) do begin
        if (lParent is TnxSqlWHILE) or (lParent is TnxSqlREPEAT) or (lParent is TnxSQLSetStatement) or (lParent is TnxSqlDECLAREStatement) then
          FVolatile := svGeneration;
        if (lParent.Owner<>nil) and ((lParent.Owner is TnxSQLSetStatement) or (lParent.Owner is TnxSqlWHILE) or (lParent.Owner is TnxSqlREPEAT)) then
          FVolatile := svGeneration;
        lParent := lParent.Parent;
      end;
    end;

    if FVolatile < svGeneration then
      if RefersToContextVars(Context) then
        FVolatile := svGeneration;

    if FVolatile < svRecord then begin
      if Bound < 1 then
        Bind(True, Context);
      if IsDependent then
        FVolatile := svRecord;
    end;
  end;

  Result := FVolatile > svNo;
  if not Result then
    Exit;
  if FVolatile = svAlways then
    Exit;

  {Result is True, FVolatile is svContext..svRecord}

  if   (FLastContext <> Context)
    or not Assigned(Context)
    or (FLastContextID <> Context.ContextID) then
      {Context changed}
      Exit;

  if FVolatile > svContext then begin
    if FLastGeneration <> Context.Generation then
      {Generation changed}
      Exit;
    if FVolatile > svGeneration then begin
      if FLastRecordsRead <> Context.RecordsRead then
        {RecordsRead changed}
        Exit;
    end;
  end;

  { Context, Generation, and RecordRead are the same }

  Result := False;
end;

procedure TnxSqlSELECT.ParametersChanged;
begin
  inherited;
  if FResultTable <> nil then begin
    FResultTable.Owner:=nil;
    FreeAndNil(fResultTable);
  end
end;

function TnxSqlSELECT.AliasFromFieldName(aTable: TnxSQLTableProxy; const aFieldName: String): String;
var
  aSelection: TnxSQLSelection;
  k: Integer;
  Fac: TnxSqlFac;
  s: string;
begin
  Result := aFieldName;

  if SelectionList.Count>0 then
    for k := 0 to SelectionList.Count - 1 do begin
      aSelection:=SelectionList[k];
      Fac := aSelection.FSimpleExpression.TermList[0].FactorList[0];
      if (Fac is TnxSqlFacColumn) then
        if (TnxSqlFacColumn(Fac).FieldRef.FieldNameStr=aFieldName) and
          ((TnxSqlFacColumn(Fac).FieldRef.TableNameStr='') or
           (TnxSqlFacColumn(Fac).FieldRef.TableNameStr=aTable.Name)) then
            if aSelection.Column<>nil then begin
              Result := aSelection.Column.ColumnNameStr;
              Exit;
            end;
    end {of for};

  for k := 0 to Pred(Columns.Count) do
    with Columns[k] do
      if SameText(Name, Result) then begin
        Result := Name;
        Exit;
      end;

  if Assigned(RowBuilder) and (RowBuilder.Sources.Count = 1) and Assigned(RowBuilder.Sources[0].Table) then begin
    s := RowBuilder.Sources[0].Table.Alias;
    if s <> '' then begin
      s := s + '.' + Result;
      for k := 0 to Pred(Columns.Count) do
        with Columns[k] do
          if SameText(Name, s) then begin
            Result := s;
            Exit;
          end;
    end;
  end;
end;

function TnxSqlSELECT.GetVersion: integer;
begin
  Result := 2;
end;

{ TnxSqlSelection }

procedure TnxSqlSelection.AddColumnDef(Target: TnxSqlColumnListOwner);
var
  S : string;
  t : string;
  F : TnxSqlNode;
  i : Integer;
begin
  if Column <> nil then
    S := Column.ColumnNameStr
  else    S := '';

  F := SimpleExpression;

  if (S = '') then
    S := nxMakeValidIdent(SimpleExpression.GetTitle(False));

  if Target.Columns.Exists(S) then begin
    i := 1;
    t := s;
    repeat
      inc(i);
      t := '_' + IntToStr(i);
      t := Copy(s, 1, 128 - Length(t)) + t;
    until not Target.Columns.Exists(t);
    Target.Columns.AddColumn(t, F);
  end else
    Target.Columns.AddColumn(S, F);
end;

function TnxSqlSelection.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
begin
  Result := FSimpleExpression.AllColumnReferencesQualified(AliasName, QualRefList);
end;

procedure TnxSqlSelection.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlSelection then begin
    nxFreeAndNil(FSimpleExpression);
    SimpleExpression := TnxSqlSelection(Source).SimpleExpression.Clone(Self) as TnxSqlSimpleExpression;
    FreeAndNil(FColumn);
    if assigned(TnxSqlSelection(Source).Column) then
      Column := TnxSqlSelection(Source).Column.Clone(Self) as TnxSqlColumn;
  end else
    ENotCompatible(Source);
end;

function TnxSqlSelection.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlSelection.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlSelection.Create(AParent: TnxSqlNode);
begin
  inherited;

end;

destructor TnxSqlSelection.Destroy;
begin
  nxFreeAndNil(FSimpleExpression);
  nxFreeAndNil(FColumn);
  inherited;
end;

function TnxSqlSelection.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlSelection then
    with TnxSqlSelection(ANode) do
      Result := NodesIdentical(SimpleExpression, Self.SimpleExpression)
    and NodesIdentical(Column, Self.Column)
  else
    Result := False;
end;

function TnxSqlSelection.GetIndex: Integer;
begin
  //Result := (Parent as TnxSqlSELECT).SelectionList.IndexOf(Self);
  Result := (Parent as TnxSqlSelectionList).IndexOf(Self);
end;

function TnxSqlSelection.GetType(Context: TnxSqlContext): TnxFieldType;
begin
  Result := SimpleExpression.GetType(Context);
end;

function TnxSqlSelection.IsAggregateExpression(Strict: Boolean): Boolean;
begin
  Result := SimpleExpression.IsAggregateExpression(Strict);
end;

function TnxSqlSelection.IsColumnRefExpr: Boolean;
begin
  Result := SimpleExpression.IsColumnRefExpr;
end;

procedure TnxSqlSelection.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  SimpleExpression := Stream.ReadNode(Self) as TnxSqlSimpleExpression;
  Column := TnxSqlColumn(Stream.ReadNodeOpt(Self));
end;

function TnxSqlSelection.RefersTo(const aTableName: string): Boolean;
begin
  Result := SimpleExpression.RefersTo(aTableName);
end;

function TnxSqlSelection.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := SimpleExpression.RefersTo(aTableName, aColumnName);
end;

function TnxSqlSelection.RefersToContextVars(Context: TnxSqlContext): Boolean;
begin
  Result := SimpleExpression.RefersToContextVars(Context);
end;

procedure TnxSqlSelection.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteNode(SimpleExpression);
  Stream.WriteNodeOpt(Column);
end;

function TnxSqlSelection.Simplify(Context: TnxSqlContext): Boolean;
begin
  Result := SimpleExpression.Simplify(Context);
end;

function TnxSqlSelection.ToString: WideString;
begin
  Result := SimpleExpression.ToString;
  if Column <> nil then
    Result := Result + ' AS' + Column.ToString;
end;

procedure TnxSqlSelection.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if Assigned(SimpleExpression) then
    SimpleExpression.Traverse(Callback, UserData, IncludeNested);
  if Assigned(Column) then
    Column.Traverse(Callback, UserData, IncludeNested);
end;

{ TnxSqlSelectionList }


function TnxSqlSelectionList.Simplify(Context: TnxSqlContext): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    Result := Result or Item[i].Simplify(Context);
end;

function TnxSqlSelectionList.GetItem(Index: Integer): TnxSqlSelection;
begin
  Result := TnxSqlSelection(inherited Item[Index]);
end;

function TnxSqlSelectionList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlSelectionList.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlSelectionList.Create(AOwner: TnxSqlNode);
begin
  inherited;
  // the selection list can have duplicates, thus we can't just autodelete
  OwnsItems:=false;
end;

function TnxSqlSelectionList.RefersTo(const aTableName: string): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlSelectionList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlSelectionList.RefersToContextVars(Context: TnxSqlContext): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersToContextVars(Context) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

procedure TnxSqlSelectionList.Remove(anIndex: integer);
begin
  FList.Delete(anIndex);
end;

function TnxSqlSelectionList.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if not Item[i].AllColumnReferencesQualified(AliasName, QualRefList) then begin
      Result := False;
      exit;
    end;
  Result := True;
end;

(*
function TnxSqlSelectionList.FindSelection(Context: TnxSqlContext;
  GroupCol : TnxSqlGroupColumn) : TnxSqlSelection;
var
  i : Integer;
  F : TnxSqlFieldProxy;
  Name : string;
begin
  Name := GroupCol.QualifiedName(Context);

  for i := 0 to Count - 1 do
    if Item[i].SimpleExpression.TermList[0].FactorList[0] is TnxSqlFacColumn and
       AnsiSameText(Trim(TnxSqlFacColumn(Item[i].SimpleExpression.TermList[0].FactorList[0]).
         FieldRef.QualifiedName), Name) then begin
      Result := Item[i];
      exit;
    end else
    if AnsiSameText(Trim(Item[i].ToString), Name) then begin
      Result := Item[i];
      exit;
    end else
    if Item[i].Column <> nil then
      if AnsiSameText(Item[i].Column.ColumnNameStr, Name) then begin
        Result := Item[i];
        exit;
      end else
    else
    if Item[i].SimpleExpression.IsField(Context, F) then
      if AnsiSameText(F.Name, Name) or
         AnsiSameText(F.QualName, Name) then begin
        Result := Item[i];
        exit;
      end;
  Result := nil;
end;
*)

function TnxSqlSelectionList.IsQualifiedColumnList(
  const AliasName: string): Boolean;
var
  Prefix: string;
  i: Integer;
begin
  Result := False;
  if AliasName = '' then
    exit;
  Prefix := UpperCase(AliasName) + '.';
  for i := 0 to Count - 1 do
    if pos(Prefix, UpperCase(Trim(Item[i].ToString))) <> 1 then
      exit;
  Result := True;
end;

function TnxSqlSelectionList.IsStarSelection: Boolean;
begin
  Result := (Count = 1) and (trim(Item[0].ToString) = '');
end;

procedure TnxSqlSelectionList.QualifyColumns(const aTableName: String);
var
  Prefix: string;
  i: Integer;
  aData: TQualifyData;
begin
  if aTableName = '' then
    exit;
  Prefix := UpperCase(aTableName) + '.';
  aData:=TQualifyData.Create;
  try
    aData.TableName:=aTableName;
    for i := 0 to Count - 1 do
      if pos(Prefix, UpperCase(Trim(Item[i].ToString))) <> 1 then
      begin
        Item[i].SimpleExpression.Traverse(DoQualify, aData, false);
      end;
  finally
    aData.Free;
  end;
end;

(*
destructor TnxSqlSelectionList.Destroy;
var
  aList: TList;
  I: Integer;
begin
  // the list can have duplicates that should only be freed once. since there's no
  // other mechanism in place at the moment we do a simple dirty check for that
  aList:=Tlist.Create;
  for I := 0 to Count - 1 do
    if aList.IndexOf(Item[i])<0 then
      aList.Add(Item[i]);
  Clear;
  for I := 0 to aList.Count - 1 do
    TObject(aList[i]).Free;
  inherited;
end;
*)

destructor TnxSqlSelectionList.Destroy;
var
  I, J: Integer;
  Item: Pointer;
begin
  // the list can have duplicates that should only be freed once. since there's no
  // other mechanism in place at the moment we do a simple dirty check for that
  for I := 0 to Count - 1 do begin
    Item := FList.List[I];
    if Item <> nil then begin
      TObject(Item).Free;
      //blank out any duplicate references to avoid double-frees
      for J := I + 1 to Count - 1 do
        if FList.List[J] = Item then
          FList.List[J] := nil;
    end;
  end;
  Clear;
  inherited;
end;

procedure TnxSqlSelectionList.DoQualify(Node: TnxSqlNode;
  UserData: TObject);
//var
//  aColumn: TnxSqlFieldRef;
begin
  if Node is TnxSqlFieldRef then
    if TnxSqlFieldRef(Node).TableNameStr='' then
      if TQualifyData(UserData).TableName<>'.' then
        if not TnxSqlFieldRef(Node).IsUnqualifiedFunction then
          TnxSqlFieldRef(Node).TableNameStr:=TQualifyData(UserData).TableName;
end;

procedure TnxSqlSelectionList.AddSelectAll;
var
  Selection: TnxSqlSelection; Exp: TnxSqlSimpleExpression; Term: TnxSqlTerm;
     Factor: TnxSqlFacColumn; FieldRef: TnxSqlFieldRef;
begin
   Selection := TnxSqlSelection.Create(Parent);
   Exp := TnxSqlSimpleExpression.Create(Selection);
   Term := TnxSqlTerm.Create(Exp);
   Factor :=  TnxSqlFacColumn.Create(Term);
   FieldRef := TnxSqlFieldRef.Create(Factor);
   Factor.FieldRef := FieldRef;
   Term.AddFactor(Factor);
   Exp.AddTerm(Term);
   Selection.SimpleExpression := Exp;
   Add(Selection);
end;

{ TnxSqlTableExp }

procedure TnxSqlTableExp.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlTableExp then begin
    Clear;
    if TnxSqlTableExp(Source).NestedTableExp <> nil then
      NestedTableExp := TnxSqlTableExp(Source).NestedTableExp.Clone(Self) as TnxSqlTableExp;
    if TnxSqlTableExp(Source).JoinTableExp <> nil then
      JoinTableExp := TnxSqlTableExp(Source).JoinTableExp.Clone(Self) as TnxSqlJoinTableExp;
    if TnxSqlTableExp(Source).NonJoinTableExp <> nil then
      NonJoinTableExp := TnxSqlTableExp(Source).NonJoinTableExp.Clone(Self) as TnxSqlNonJoinTableExp;
    if TnxSqlTableExp(Source).SetTermCount > 0 then begin
      FSetTerms := TList.Create;
      for i := 0 to TnxSqlTableExp(Source).SetTermCount - 1 do
        FSetTerms.Add(TnxSqlTableExp(Source).SetTerm[i].Clone(Self));
    end;
  end else
    ENotCompatible(Source);
end;

procedure TnxSqlTableExp.Bind;
begin
end;

function TnxSqlTableExp.BindFieldDown(Context: TnxSqlContext; const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
//var
//  i: Integer;
begin
{  for i := 0 to SetTermCount - 1 do begin
    Result := SetTerm[i].BindFieldDown(Context, TableName, FieldName, FieldNameLoc, ColumnAlias);
    if Result <> nil then
      exit;
  end;}
  if assigned(NestedTableExp) then
    Result := NestedTableExp.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.BindFieldDown(DatabaseName, TableName, FieldName, FieldNameLoc, Context, ColumnAlias)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias)
  else
    Result := nil;
end;

function TnxSqlTableExp.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
var
  i: Integer;
begin
  for i := 0 to SetTermCount - 1 do begin
    Result := SetTerm[i].BindTable(Context, AOwner, DatabaseName, TableName);
    if Result <> nil then
      exit;
  end;
  if assigned(NestedTableExp) then
    Result := NestedTableExp.BindTable(Context, AOwner, DatabaseName, TableName)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.BindTable(Context, AOwner, DatabaseName, TableName)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.BindTable(Context, AOwner, DatabaseName, TableName)
  else
    Result := nil;
end;

procedure TnxSqlTableExp.Clear;
var
  i: Integer;
begin
  snBeginUse;
  try
    for i := 0 to SetTermCount - 1 do
      SetTerm[i].Free;
    nxFreeAndNil(FSetTerms);

    nxFreeAndNil(FNestedTableExp);
    nxFreeAndNil(FJoinTableExp);
    nxFreeAndNil(FNonJoinTableExp);
  finally
    snEndUse;
  end;
end;

destructor TnxSqlTableExp.Destroy;
begin
  snBeginUse;
  try
    Clear;
    if FResultTable <> nil then begin
      FResultTable.Owner := nil;
      nxFreeAndNil(FResultTable);
    end;
  finally
    snEndUse;
  end;
  inherited;
end;

function TnxSqlTableExp.CheckNoDups(Context: TnxSqlContext): Boolean;
begin
  {EnsureResultTable(Context, True);}
  Result := not GetResultTable(Context, True).HasDuplicates(Context, True);
end;

function TnxSqlTableExp.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlTableExp.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlTableExp.DependsOn(Context: TnxSqlContext; Table: TnxSqlTableProxy): Boolean;
var
  i: Integer;
begin
  if assigned(NestedTableExp) then
    Result := NestedTableExp.DependsOn(Context, Table)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.DependsOn(Context, Table)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.DependsOn(Table, Context)
  else
    Result := False;
  if not Result then begin
    for i := 0 to SetTermCount - 1 do begin
      Result := SetTerm[i].DependsOn(Table, Context);
      if Result then
        exit;
    end;
  end;
end;

procedure TnxSqlTableExp.EnsureResultTable(Context: TnxSqlContext; NeedData: Boolean; Select: TnxSqlSELECT);
var
  i: Integer;
begin
  snBeginUse;
  try
    if assigned(NestedTableExp) then
      NestedTableExp.EnsureResultTable(Context, NeedData, Select);
    if assigned(JoinTableExp) then
      JoinTableExp.EnsureResultTable(NeedData, Context, Select);
    if assigned(NonJoinTableExp) then
      NonJoinTableExp.EnsureResultTable(Context, NeedData);
    for i := 0 to SetTermCount - 1 do
      SetTerm[i].EnsureResultTable(Context, NeedData);
  finally
    snEndUse;
  end;
end;

function TnxSqlTableExp.Equals(ANode: TnxSqlNode): Boolean;
var
  i: Integer;
begin
  if ANode is TnxSqlTableExp then
    with TnxSqlTableExp(ANode) do begin
      Result := NodesIdentical(NestedTableExp, Self.NestedTableExp)
        and NodesIdentical(JoinTableExp, Self.JoinTableExp)
        and NodesIdentical(NonJoinTableExp, Self.NonJoinTableExp);
      if Result then begin
        if SetTermCount <> Self.SetTermCount then begin
          Result := False;
          exit;
        end;
        for i := 0 to SetTermCount - 1 do
          if not SetTerm[i].Equals(Self.SetTerm[i]) then begin
            Result := False;
            exit;
          end;
      end;
    end
  else
    Result := False;
end;
                  
function TnxSqlTableExp.DoUnionExceptIntersect(Context: TnxSqlContext):TnxSqlTableProxy;
var
  T, T2: TnxSqlTableProxy;
  FC: TnxSqlRecordCopier;
  i, j: Integer;
  FieldDefList, FieldDefListU : TnxSqlFieldDefList;
  TUs: array of TnxSqlTableProxy;
  FoundSame, Same, Restart: Boolean;
  V1, V2: variant;
  Status: TnxResult;
begin
  Result := nil;
  T := nil;
  if assigned(NestedTableExp) then
    T := NestedTableExp.GetResultTable(Context, True)
  else if assigned(JoinTableExp) then
    T := JoinTableExp.GetResultTable(Context)
  else if assigned(NonJoinTableExp) then
    T := NonJoinTableExp.GetResultTable(Context, True)
  else
    Assert(False);

  FieldDefList := nil;
  SetLength(TUs, SetTermCount);
  try
    for i := 0 to SetTermCount - 1 do
      TUs[i] := nil;
    for i := 0 to SetTermCount - 1 do begin
      TUs[i] := SetTerm[i].GetResultTable(Context, True);
      if TUs[i].FieldCount <> T.FieldCount then
        raise EnxInternalSQLException.CreateResFmt(@rsColumnNumberMismatchInUnion,
          [ToString]);
    end;

    FieldDefList := T.ExtractFieldDef;
    FieldDefListU := nil;
    try
      for j := 0 to SetTermCount - 1 do begin
        nxFreeAndNil(FieldDefListU);
        FieldDefListU := TUs[j].ExtractFieldDef;
        FieldDefList.CoerceTypes(FieldDefListU);
      end;
      Result := Database.CreateTemporaryTableWithoutIndex(Self, FieldDefList);
    finally
      //nxFreeAndNil(FieldDefList); needed for type checking in EXCEPT logic below
      nxFreeAndNil(FieldDefListU);
    end;

    if not T.Database.ExplicitTransInProgress then
      Status := T.Database.StartTransaction(False, True)
    else
      Status := DBIERR_NONE;
    if Status = DBIERR_NONE then
      try

        try
          FC := nil;
          try
            FC := TnxSqlRecordCopier.Create(True, IsView);
            for i := 0 to Result.FieldCount - 1 do
              FC.Add(T.FieldC(i), Result.FieldNC(i));
            if T.First then
              repeat
                Result.Insert;
                FC.Execute;
                Result.Post;
              until not T.Next;
          finally
            nxFreeAndNil(FC);
          end;
        finally
          if T.Owner = Self then begin
            T.Owner := nil;
            nxFreeAndNil(T);
          end;
        end;

        for i := 0 to SetTermCount - 1 do begin
          (*
          for j := 0 to Result.FieldCount - 1 do begin
            FT1 := Result.FieldC(j).GetType;
            fT2 := TUs[i].FieldC(j).GetType;
            if not nxSqlCompatibleFields[FT1, FT2] then
              raise EnxInternalSQLException.CreateFmt('Union/Except error: The types of columns %s and %s are incompatible',
                [Result.FieldC(j).Name, TUs[i].FieldC(j).Name]);
          end;
          *)
          case SetTerm[i].SetOp of
          soUnion :
            begin
              FC := nil;
              try
                FC := TnxSqlRecordCopier.Create(True, IsView);
                for j := 0 to Result.FieldCount - 1 do
                  FC.Add(TUs[i].FieldC(j), Result.FieldNC(j));
                if TUs[i].First then
                  repeat
                    Result.Insert;
                    FC.Execute;
                    Result.Post;
                  until not TUs[i].Next;
              finally
                nxFreeAndNil(FC);
              end;
              if not SetTerm[i].All then begin
                T2 := Result.CopyUnique(Context, Self, True, True{CopyBlobs}, False, IsView);
                Result.TransplantCursorFrom(T2);
                {
                Result.Owner := nil;
                nxFreeAndNil(Result);
                Result := T2;}
              end;
            end;
          soExcept :
            begin

              for j := 0 to FieldDefList.Count - 1 do
                if not SortableType(FieldDefList.Field[j].fdType) then
                  raise EnxSqlException.CreateFmt(rsAllColumnsMustBeSortable,
                    [FieldDefList.Field[j].fdName]);

              repeat
                Restart := False;
                if Result.First then
                  repeat
                    FoundSame := False;
                    if TUs[i].First then
                      repeat
                        Same := True;
                        for j := 0 to Result.FieldCount - 1 do begin
                          V1 := Unassigned;
                          V1 := TUs[i].FieldC(j).GetValue;
                          V2 := Unassigned;
                          V2 := Result.FieldNC(j).GetValue;
                          if VarIsNull(V1) then
                            if not VarIsNull(V2) then begin
                              Same := False;
                              Break;
                            end else
                          else
                            if VarIsNull(V2) then begin
                              Same := False;
                              Break;
                            end else
                              if V1 <> V2 then begin
                                Same := False;
                                Break;
                              end;
                        end;
                        if Same then begin
                          if SetTerm[i].All then
                            TUs[i].Delete;
                          FoundSame := True;
                          Break;
                        end;
                      until FoundSame or not TUs[i].Next;
                    if FoundSame then begin
                      Result.Delete;
                      Restart := True;
                    end;
                  until Restart or not Result.Next;
              until not Restart;
            end;
          end;

        end;

      if not T.Database.ExplicitTransInProgress then
        T.Database.Commit;

    except
      T.Database.AbortTransaction;
      T.Database.ExplicitTransInProgress := False;
      nxFreeAndNil(result);
      raise;
    end else
      raise EnxSqlException.nxCreate(Status);

  finally
    nxFreeAndNil(FieldDefList);
    for i := 0 to SetTermCount - 1 do
      if (TUs[i] <> nil) and (TUs[i].Owner = Self) then begin
        TUs[i].Owner := nil;
        nxFreeAndNil(TUs[i]);
      end;
  end;
end;

function TnxSqlTableExp.Execute(Context: TnxSqlContext; var aLiveResult: Boolean; var aCursor: TnxAbstractCursor;
      var RecordsRead: Integer; var RowsAffected: Integer) : TnxResult;
var
  ResultT: TnxSqlTableProxy;
begin
  nxFreeAndNil(aCursor);
  snBeginUse;
  try
    Result := DBIERR_NONE;
    if SetTermCount > 0 then begin
      ResultT := nil;
      try
        ResultT := DoUnionExceptIntersect(Context);
        aCursor := ResultT.Cursor;
        aLiveResult := False;
        ResultT.LeaveCursorOpen := True;
      finally
        if ResultT <> nil then begin
          ResultT.Owner := nil;
          nxFreeAndNil(ResultT);
        end;
      end;

    end else begin
      if assigned(NestedTableExp) then
        NestedTableExp.Execute(Context, aLiveResult, aCursor, RecordsRead, RowsAffected);
      if assigned(JoinTableExp) then
        JoinTableExp.Execute(Context, aLiveResult, aCursor, RecordsRead);
      if assigned(NonJoinTableExp) then
        NonJoinTableExp.Execute(Context, aLiveResult, aCursor, RecordsRead);
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlTableExp.EvaluateWhere(Context: TnxSqlContext): TnxSqlTriStateBool;
begin
  if SetTermCount > 0 then
    raise EnxInternalSQLException.Create(rsSetOperationsNotAllowedInThisContext);
  if assigned(NestedTableExp) then
    raise EnxInternalSQLException.Create(rsOnlySimpleSELECTAllowedInFilters);
  if assigned(JoinTableExp) then
    raise EnxInternalSQLException.Create(rsOnlySimpleSELECTAllowedInFilters);
  Result := NonJoinTableExp.EvaluateWhere(Context);
end;

procedure TnxSqlTableExp.BindWhere(aContext: TnxSqlContext);
begin
  NonJoinTableExp.BindWhere(aContext);
end;

function TnxSqlTableExp.EvaluateFirst(Context: TnxSqlContext): variant;
begin
  if SetTermCount > 0 then
    raise EnxInternalSQLException.Create(rsSetOperationsNotAllowedInThisContext);
  if assigned(NestedTableExp) then
    raise EnxInternalSQLException.Create(rsOnlySimpleSELECTAllowedInFilters);
  if assigned(JoinTableExp) then
    raise EnxInternalSQLException.Create(rsOnlySimpleSELECTAllowedInFilters);
  Result := NonJoinTableExp.EvaluateFirst(Context);
end;

function TnxSqlTableExp.WhereIsValidFilterStatement: Boolean;
begin
  if (SetTermCount > 0) or assigned(NestedTableExp) or assigned(JoinTableExp) then
    Result := False
  else
    Result := NonJoinTableExp.WhereIsValidFilterStatement;
end;

function TnxSqlTableExp.GetFieldsFromTable(Context: TnxSqlContext; const TableName: string; List: TList):
  TnxSqlTableProxy;
begin
  Result := nil;
  if assigned(NestedTableExp) then
    Result := NestedTableExp.GetFieldsFromTable(Context, TableName, List)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.GetFieldsFromTable(TableName, List, Context)
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.GetFieldsFromTable(TableName, List)
  else
    Assert(False);
end;

function TnxSqlTableExp.GetRefresh: TnxSqlTableRefresher;
begin
  Result := nil;
  if SetTermCount = 0 then
    if assigned(NonJoinTableExp) then
      Result := NonJoinTableExp.Refresh
    else
    if assigned(NestedTableExp) then
      Result := NestedTableExp.Refresh
    else
    if assigned(JoinTableExp) then
      Result := JoinTableExp.Refresh;
end;

function TnxSqlTableExp.GetResultTable(Context: TnxSqlContext; aNeedData: Boolean): TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Result := nil;
    if SetTermCount > 0 then begin
      if assigned(Result) then
        result.Free;

      Result := DoUnionExceptIntersect(Context);
      if FResultTable = nil then
        FResultTable := Result
      else begin
        FResultTable.TransplantCursorFrom(Result);
        Result := FResultTable;
      end;
      {
      if FResultTable <> nil then begin
        if FResultTable.Owner = Self then begin
          FResultTable.Owner := nil;
          nxFreeAndNil(FResultTable);
        end;
      end;
      FResultTable := Result;
      }
    end else begin
      if assigned(NestedTableExp) then begin
        Result := NestedTableExp.GetResultTable(Context, aNeedData);
      end else
      if assigned(JoinTableExp) then begin
        Result := JoinTableExp.GetResultTable(Context);
      end else
      if assigned(NonJoinTableExp) then
        Result := NonJoinTableExp.GetResultTable(Context, aNeedData)
      else
        Assert(False);
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlTableExp.Simplify(Context: TnxSqlContext): Boolean;
var
  i: Integer;
begin
  if assigned(NestedTableExp) then
    Result := NestedTableExp.Simplify(Context)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.Simplify(Context)
  else
    Result := False;
  if assigned(NonJoinTableExp) then
    Result := Result or NonJoinTableExp.Simplify(Context);
  if not Result then
    for i := 0 to SetTermCount - 1 do 
      if SetTerm[i].Simplify(Context) then begin
        Result := True;
        exit;
      end;
end;

function TnxSqlTableExp.TargetFieldFromSourceField(
  Context: TnxSqlContext; const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
begin
  Result := nil;
  if assigned(NestedTableExp) then
    Result := NestedTableExp.TargetFieldFromSourceField(Context, F)
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.TargetFieldFromSourceField(F, Context)
  else
  if assigned(NonJoinTableExp) then
    NonJoinTableExp.TargetFieldFromSourceField(Context, F)
  else
    Assert(False);
end;

function TnxSqlTableExp.ToString: WideString;
var
  i: Integer;
begin
  if assigned(NestedTableExp) then
    Result := NestedTableExp.ToString
  else
  if assigned(JoinTableExp) then
    Result := JoinTableExp.ToString
  else
  if assigned(NonJoinTableExp) then
    Result := NonJoinTableExp.ToString;

  for i := 0 to SetTermCount - 1 do begin
    Result := Result + ' UNION ';
    if SetTerm[i].All then
      Result := Result + ' ALL ';
    Result := Result + SetTerm[i].ToString;
  end;
end;

procedure TnxSqlTableExp.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
var
  i: Integer;
begin
  Callback(Self, UserData);
  if assigned(NestedTableExp) then
    NestedTableExp.Traverse(Callback, UserData, IncludeNested);
  if assigned(JoinTableExp) then
    JoinTableExp.Traverse(Callback, UserData, IncludeNested);
  if assigned(NonJoinTableExp) then
    NonJoinTableExp.Traverse(Callback, UserData, IncludeNested);
  for i := 0 to SetTermCount - 1 do
    SetTerm[i].Traverse(Callback, UserData, IncludeNested);
end;

procedure TnxSqlTableExp.Unbind;
var
  i: Integer;
begin
  snBeginUse;
  try
    if assigned(NestedTableExp) then
      NestedTableExp.Unbind;
    if assigned(JoinTableExp) then
      JoinTableExp.Unbind;
    if assigned(NonJoinTableExp) then
      NonJoinTableExp.Unbind;
    if FResultTable<>nil then
      if FResultTable.Owner=self then
        nxFreeAndnil(FResultTable);
    for i := 0 to SetTermCount - 1 do
      SetTerm[i].Unbind;
  finally
    snEndUse;
  end;
end;

procedure TnxSqlTableExp.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i: Integer;
begin
  if Stream.ReadBool then
    JoinTableExp := Stream.ReadNode(Self) as TnxSqlJoinTableExp;
  if Stream.ReadBool then
    NonJoinTableExp := Stream.ReadNode(Self) as TnxSqlNonJoinTableExp;
  if Stream.ReadBool then
    NestedTableExp := Stream.ReadNode(Self) as TnxSqlTableExp;
  for i := 0 to Stream.ReadInt - 1 do
    AddSetTerm(Stream.ReadNode(Self) as TnxSqlNonJoinTableTerm);
end;

procedure TnxSqlTableExp.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  if JoinTableExp <> nil then begin
    Stream.WriteBool(True);
    Stream.WriteNode(JoinTableExp);
  end else
    Stream.WriteBool(False);
  if NonJoinTableExp <> nil then begin
    Stream.WriteBool(True);
    Stream.WriteNode(NonJoinTableExp);
  end else
    Stream.WriteBool(False);
  if NestedTableExp <> nil then begin
    Stream.WriteBool(True);
    Stream.WriteNode(NestedTableExp);
  end else
    Stream.WriteBool(False);
  Stream.WriteInt(SetTermCount);
  for i := 0 to SetTermCount - 1 do
    Stream.WriteNode(SetTerm[i]);
end;

function TnxSqlTableExp.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  if JoinTableExp <> nil then
    if JoinTableExp.RefersTo(aTableName) then
      exit;
  if NonJoinTableExp <> nil then
    if NonJoinTableExp.RefersTo(aTableName) then
      exit;
  if NestedTableExp <> nil then
    if NestedTableExp.RefersTo(aTableName) then
      exit;
  for i := 0 to SetTermCount - 1 do
    if SetTerm[i].RefersTo(aTableName) then
      exit;
  Result := False;
end;

function TnxSqlTableExp.RefersTo2(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  Result := True;
  if JoinTableExp <> nil then
    if JoinTableExp.RefersTo(aTableName, aColumnName) then
      exit;
  if NonJoinTableExp <> nil then
    if NonJoinTableExp.RefersTo(aTableName, aColumnName) then
      exit;
  if NestedTableExp <> nil then
    if NestedTableExp.RefersTo2(aTableName, aColumnName) then
      exit;
  for i := 0 to SetTermCount - 1 do
    if SetTerm[i].RefersTo(aTableName, aColumnName) then
      exit;
  Result := False;
end;

function TnxSqlTableExp.RefersToContextVars(
  Context: TnxSqlContext): Boolean;
var
  i: Integer;
begin
  Result := True;
  if JoinTableExp <> nil then
    if JoinTableExp.RefersToContextVars(Context) then
      exit;
  if NonJoinTableExp <> nil then
    if NonJoinTableExp.RefersToContextVars(Context) then
      exit;
  if NestedTableExp <> nil then
    if NestedTableExp.RefersToContextVars(Context) then
      exit;
  for i := 0 to SetTermCount - 1 do
    if SetTerm[i].RefersToContextVars(Context) then
      exit;
  Result := False;
end;

procedure TnxSqlTableExp.AddSetTerm(SetTerm: TnxSqlNonJoinTableTerm;
  SetOp: TnxSqlSetOp; All: Boolean);
begin
  if FSetTerms = nil then
    FSetTerms := TList.Create;
  SetTerm.All := All;
  SetTerm.SetOp := SetOp;
  FSetTerms.Add(SetTerm);
end;

procedure TnxSqlTableExp.AddSetTerm(SetTerm: TnxSqlNonJoinTableTerm);
begin
  if FSetTerms = nil then
    FSetTerms := TList.Create;
  FSetTerms.Add(SetTerm);
end;

function TnxSqlTableExp.GetSetTerm(
  Index: Integer): TnxSqlNonJoinTableTerm;
begin
  Result := TnxSqlNonJoinTableTerm(FSetTerms[Index]);
end;

function TnxSqlTableExp.GetSetTermCount: Integer;
begin
  if FSetTerms <> nil then
    Result := FSetTerms.Count
  else
    Result := 0;
end;

function TnxSqlTableExp.RefersToTemp: Boolean;
var
  i: Integer;
begin
  Result := True;
  if JoinTableExp <> nil then
    if JoinTableExp.RefersToTemp then
      exit;
  if NonJoinTableExp <> nil then
    if NonJoinTableExp.RefersToTemp then
      exit;
  if NestedTableExp <> nil then
    if NestedTableExp.RefersToTemp then
      exit;
  for i := 0 to SetTermCount - 1 do
    if SetTerm[i].RefersToTemp then
      exit;
  Result := False;
end;

function TnxSqlTableExp.IsFullJoin(
  var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
begin
  Result := (JoinTableExp <> nil)
    and (JoinTableExp.JoinType = jtFullOuter)
    and (SetTermCount = 0);
  if Result then
    aJoinTableExp := JoinTableExp;
end;

function TnxSqlTableExp.IsLeftOrRightJoin(
  var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
begin
  Result := (JoinTableExp <> nil)
    and (JoinTableExp.JoinType in [jtLeftOuter, jtRightOuter])
    and (SetTermCount = 0);
  if Result then
    aJoinTableExp := JoinTableExp;
end;

function TnxSqlTableExp.IsResultTable(T: TnxSqlTableProxy): Boolean;
var
  i: Integer;
begin
  Result := (T = FResultTable);
  if not Result then begin
    Result := True;
    if JoinTableExp <> nil then
      if JoinTableExp.IsResultTable(T) then
        exit;
    if NonJoinTableExp <> nil then
      if NonJoinTableExp.IsResultTable(T) then
        exit;
    if NestedTableExp <> nil then
      if NestedTableExp.IsResultTable(T) then
        exit;
    for i := 0 to SetTermCount - 1 do
      if SetTerm[i].IsResultTable(T) then
        exit;
    Result := False;
  end;
end;

function TnxSqlTableExp.IsView: Boolean;
var
  Look: TnxSqlNode;
begin
  Look := Parent;
  while Look <> nil do begin
    if Look is TnxSqlCREATEVIEW then begin
      Result := True;
      exit;
    end;
    Look := Look.Parent;
  end;
  Result := False;
end;

{function TnxSqlTableExp.IsOrdered: Boolean;
begin
  if SetTermCount > 0 then
    Result := False
  else
  if JoinTableExp <> nil then
    Result := False
  else
  if NonJoinTableExp <> nil then
    Result := NonJoinTableExp.IsOrdered
  else
  if NestedTableExp <> nil then
    Result := NestedTableExp.IsOrdered
  else
    Result := False;
end;}

{
procedure TnxSqlTableExp.FreeResultTable;
begin
  if FResultTable<>nil then
  begin
    FResultTable.Owner := nil;
    nxFreeAndNil(FResultTable);
  end;
end;
}

function TnxSqlTableExp.IsAmbiguousColumn(
  const ColumnName: string): Boolean;
begin
  if JoinTableExp <> nil then
    Result := JoinTableExp.IsAmbiguousColumn(ColumnName)
  else
    Result := False;
end;

function TnxSqlTableExp.IsSelectInto: Boolean;
begin
  Result := assigned(NonJoinTableExp) and NonJoinTableExp.IsSelectInto;
end;

{ TnxSqlTableRef }

procedure TnxSqlTableRef.AddParm(ValueExp: TnxSqlSimpleExpression{TnxSqlCondExp});
var
  NewParm: TnxSqlExecParm;
begin
  NewParm := TnxSqlExecParm.Create(ValueExp);
  FParmList.Add(NewParm);
end;

procedure TnxSqlTableRef.AddTableReference(Context: TnxSqlContext; Select: TnxSqlNode);
var
  IX, I : Integer;
  R: TnxSqlTableProxy;
begin
  snBeginUse;
  try
    Assert(Select is TnxSqlSELECT);
    Assert(Assigned(TnxSqlSELECT(Select).TablesReferencedByOrder));
    if TableNameStr <> '' then begin
      if IsView then
        IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(
          TnxInternalTableRef.Create(DatabaseNameStr, TableNameStr, Self, nil, False, False, DoRefreshView, nil))
      else
        IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(
          TnxInternalTableRef.Create(DatabaseNameStr, TableNameStr, Self, nil, False, False, nil, nil));
    end else begin
      if Assigned(TableExp) then begin
        TableExp.EnsureResultTable(Context, True, TnxSqlSELECT(Select));
        R := TableExp.GetResultTable(Context, True);
        if (AliasStr <> '') and not SameText(AliasStr, R.Alias) then
          R.SetAlias(AliasStr);
        if TnxSqlSELECT(Select).TablesReferencedByOrder.IndexOf('', '$$UNNAMED') = -1 then
          IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(TnxInternalTableRef.Create('', '$$UNNAMED',
            nil, R, True, False, TableExp.Refresh, TableExp))
        else begin
          I := 2;
          repeat
            if TnxSqlSELECT(Select).TablesReferencedByOrder.IndexOf('', '$$UNNAMED_' + IntToStr(I)) =
              -1 then begin
              IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(TnxInternalTableRef.Create('', '$$UNNAMED_' +
                IntToStr(I), nil, R, True, False, TableExp.Refresh, TableExp));
              Break;
            end;
            inc(I);
          until False;
        end;
        if TableExp.JoinTableExp<>nil then
          TnxSqlSELECT(Select).TablesReferencedByOrder[ix].IsJoinResult:=true;
      end else begin
          if TnxSqlSELECT(Select).TablesReferencedByOrder.IndexOf('', '$$UNNAMED') = -1 then
            IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(TnxInternalTableRef.Create('', '$$UNNAMED',
              Self, nil, False, False, DoRefreshFunction, nil))
          else begin
            I := 2;
            repeat
              if TnxSqlSELECT(Select).TablesReferencedByOrder.IndexOf('', '$$UNNAMED_' + IntToStr(I)) =
                -1 then begin
                IX := TnxSqlSELECT(Select).TablesReferencedByOrder.Add(TnxInternalTableRef.Create('', '$$UNNAMED_' + IntToStr(I),
                  Self, nil, False, False, DoRefreshFunction, nil));
                Break;
              end;
              inc(I);
            until False;
          end;
      end;
    end;
    if AliasStr <> '' then begin
      Assert(Assigned(TnxSqlSELECT(Select).TableAliases));
      if TnxSqlSELECT(Select).TableAliases.IndexOf(AliasStr) <> -1 then
        SQLError(rsAmbiguousTableRef6 + AliasStr + AliasLocationStr);
      TnxSqlSELECT(Select).TableAliases.AddObject(AliasStr, TObject(IX));
    end;
  finally
    snEndUse;
  end;
end;

function TnxSqlTableRef.AliasLocationStr: string;
begin
  if Alias <> nil then
    Result := TokenToLocationStr(Alias)
  else
    Result := '';
end;

procedure TnxSqlTableRef.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlTableRef then begin
    Clear;
    TableNameStr := TnxSqlTableRef(Source).TableNameStr;
    DatabaseNameStr := TnxSqlTableRef(Source).DatabaseNameStr;
    AssignedLocation:= TnxSqlTableRef(Source).LocationStr;

    AliasStr := TnxSqlTableRef(Source).AliasStr;
    if TnxSqlTableRef(Source).TableExp <> nil then
      TableExp := TnxSqlTableRef(Source).TableExp.Clone(Self) as TnxSqlTableExp;
    if TnxSqlTableRef(Source).ColumnList <> nil then
      ColumnList := TnxSqlTableRef(Source).ColumnList.Clone(Self) as TnxSqlNodeList;
    FuncNameStr := TnxSqlTableRef(Source).FuncNameStr;
    for i := 0 to TnxSqlTableRef(Source).ParmCount - 1 do
      AddParm(TnxSqlTableRef(Source).Parm[i].ValueExp.Clone(Self) as TnxSqlSimpleExpression);
  end else
    ENotCompatible(Source);
end;

function TnxSqlTableRef.BindFieldDown(Context: TnxSqlContext;const DatabaseName, TableName,
  FieldName, FieldNameLoc: string; var ColumnAlias: string): TnxSqlFieldProxy;
var
  Table: TnxSqlTableProxy;
begin
  if ((DatabaseName = '') or SameText(DatabaseName, Self.DatabaseNameStr))
    and (SameText(TableName, Self.TableNameStr)
    and (AliasStr = '')
  or SameText(TableName, AliasStr)) then begin
    Table := GetResultTable(Context);
    if Assigned(Table) then
      Result := Table.FieldByName(FieldName)
    else
      Result := nil;
  end else
  if (Self.TableNameStr = '') and (AliasStr = '') and (TableExp <> nil) then
    Result := TableExp.BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias)
  else
    Result := nil;
end;

function TnxSqlTableRef.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
begin
  Result:=nil;
  if SameText(TableName, AliasStr)
  or SameText(TableName, Self.TableNameStr) then begin
    if (DatabaseName = '') or SameText(DatabaseName, Self.DatabaseNameStr) then
      Result := GetTable(Context, AOwner, somReadOnly);
  end else
    if (AliasStr = '') and (TableExp <> nil) then
      Result := TableExp.BindTable(Context, AOwner, DatabaseName, TableName);
end;

procedure TnxSqlTableRef.Clear;
var
  i: Integer;
begin
  FTargetFunc.Free;
  FTargetFunc := nil;
  for i := 0 to FParmList.Count - 1 do
    TObject(FParmList[i]).Free;
  FParmList.Clear;
  nxFreeAndNil(FTableExp);
  nxFreeAndNil(FColumnList);
  SetTable(nil);
  FTableName := nil;
  FTablenameStr := '';
  FFuncName := nil;
  FFuncNameStr := '';
  FDatabaseName := nil;
  FDatabaseNameStr := '';
end;

function TnxSqlTableRef.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlTableRef.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlTableRef.Create(AParent: TnxSqlNode);
begin
  inherited;
  FParmList := TList.Create;
end;

destructor TnxSqlTableRef.Destroy;
begin
  if FTableInternal<>nil then
    FTableInternal.RemoveDestroyNotifification(RequestDestroy);
  Clear;
  SetTable(FTableInternal);
  nxFreeAndNil(FParmList);
  inherited;
end;

function TnxSqlTableRef.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlTableRef then
    with TnxSqlTableRef(ANode) do
      Result :=
        AnsiSameText(TableNameStr, Self.TableNameStr)
        and AnsiSameText(DatabaseNameStr, Self.DatabaseNameStr)
        and AnsiSameText(AliasStr, Self.AliasStr)
        and NodesIdentical(TableExp, Self.TableExp)
        and TnxSqlNodeList.Identical(ColumnList, Self.ColumnList)
  else
    Result := False;
end;

function TnxSqlTableRef.GetAliasStr: string;
begin
  if FAlias <> nil then
    Result := TokenToStrStripQ(FAlias)
  else
    Result := FAliasStr;
end;

function TnxSqlTableRef.GetDatabase: TnxSqlDatabaseProxy;
var
  DBName: string;
begin
  Result := Owner.Database;
  if FDatabaseName <> nil then
    DBName := TokenToStrStripQ(FDatabaseName)
  else
    DBName := FDatabaseNameStr;
  if DBName <> '' then
    Result := Result.GetDatabase(DBName);
end;

function TnxSqlTableRef.GetDatabaseNameStr: string;
begin
  if FDatabaseName <> nil then
    Result := TokenToStrStripQ(FDatabaseName)
  else
    Result := FDatabaseNameStr;
//  else
  if Result = '' then
    if Database<>nil then
      Result:=Database.DefaultDatabaseStr;
end;

function TnxSqlTableRef.GetFuncNameStr: string;
begin
  if FFuncName <> nil then
    Result := TokenToStrStripQ(FFuncName)
  else
    Result := FFuncNameStr;
end;

function TnxSqlTableRef.GetParentBlock: TnxSqlBlock;
begin
  Result := TnxSqlBlock(Parent);
  while (Result <> nil) and not (TObject(Result) is TnxSqlBlock) do
    Result := TnxSqlBlock(Result.Parent);
end;

function TnxSqlTableRef.GetParm(Index: Integer): TnxSqlExecParm;
begin
  Result := TnxSqlExecParm(FParmList[Index]);
end;

function TnxSqlTableRef.GetParmCount: Integer;
begin
  Result := FParmList.Count;
end;

function TnxSqlTableRef.GetResultTable(Context: TnxSqlContext): TnxSqlTableProxy;
begin
  Result := GetTable(Context, Self, somReadOnly);
end;

function TnxSqlTableRef.GetSQLName: string;
begin
  if AliasStr <> '' then
    Result := AliasStr
  else
  if TableNameStr <> '' then
    Result := TableNameStr
  else
    Result := 'UNNAMED';
end;

procedure TnxSqlTableRef.DoRefreshFunction(aContext: TnxSqlContext);
var
  Tmp : TnxSqlTableProxy;
begin
  if (FuncTableContext <> aContext) or
     not Assigned(FuncTableContext) or
     not Assigned(aContext) or
     (FuncTableGeneration <> aContext.Generation) or
     (not FTargetFuncIsDeterministic and (FuncTableRecordsRead <> aContext.RecordsRead)) or
     not FTargetFuncIsDeterministicWithinRow then begin

    Tmp := ExecuteTableFunction(aContext);
    FuncTable.TransplantCursorFrom(Tmp);

    FuncTableContext := aContext;
    if Assigned(aContext) then begin
      FuncTableGeneration := aContext.Generation;
      FuncTableRecordsRead := aContext.RecordsRead;
    end else begin
      FuncTableGeneration := -1;
      FuncTableRecordsRead := -1;
    end;

  end;
end;

procedure TnxSqlTableRef.DoRefreshView(aContext: TnxSqlContext);
var
  Tmp: TnxSqlTableProxy;
begin
  Tmp := OpenView(Self, ParentBlock, aContext, Database.GetDatabase(DatabaseNameStr), TableNameStr);
  Table.TransplantCursorFrom(Tmp);
end;

function TnxSqlTableRef.GetRefresh: TnxSqlTableRefresher;
begin
  if assigned(TableExp) then
    Result := TableExp.Refresh
  else if IsView then
    Result := DoRefreshView
  else
    Result := nil;
end;

function TnxSqlTableRef.GetTable(Context: TnxSqlContext; aOwner: TObject; aOpenMode: TnxSqlOpenmode): TnxSqlTableProxy;
var
  CNList: TnxFastStringListIC;
  i: Integer;
  Tmp: TnxSqlTableProxy;
  s: string;
  aDatabase: TnxSqlDatabaseProxy;
  {VD: TnxSqlCREATEVIEW;
  DB: TnxSqlDatabaseProxy;}
begin
(* test code
  if not ViewBound then begin
    DB := Database.GetDatabase(DatabaseNameStr);
    VD := LoadViewDefinition(DB, TableNameStr);
    if VD <> nil then begin
      ParentBlock.Log('Merging view definition "' + TableNameStr + '"');
      Clear;
      TableExp := VD.TableExp.Clone(Self) as TnxSqlTableExp;
      if VD.ColumnList <> nil then
        ColumnList := VD.ColumnList.Clone(Self) as TnxSqlNodeList;
      Simplify;
      ParentBlock.Log('Table reference definition after merge:"' + ToString + '"');
      VD.Free;
      TableExp.Traverse(SetDatabase, DB, True);
    end;
    ViewBound := True;
  end;
*)
  Assert(aOwner <> nil);
  if TableNameStr <> '' then begin
    if Table = nil then begin
      if Database=nil then
        if (aOwner is TnxSqlSELECT) and (TnxSqlSELECT(aOwner).Parent<>nil) then
          if (TnxSqlSELECT(aOwner).Parent is TnxSqlInSub) then begin
            if TnxSqlInSub(TnxSqlSELECT(aOwner).Parent).Owner<>nil then
            begin
              aDatabase:=TnxSqlInSub(TnxSqlSELECT(aOwner).Parent).Owner.Database;
              TnxSqlSELECT(aOwner).Database:=aDatabase;
            end;
          end else
          if (TnxSqlSELECT(aOwner).Parent is TnxSqlFacSub) then
          begin
            if TnxSqlFacSub(TnxSqlSELECT(aOwner).Parent).Owner<>nil then
            begin
              aDatabase:=TnxSqlFacSub(TnxSqlSELECT(aOwner).Parent).Owner.Database;
              TnxSqlSELECT(aOwner).Database:=aDatabase;
            end
          end
          else
          if (TnxSqlSELECT(aOwner).Parent is TnxSqlCPExists) then begin
            if TnxSqlCPExists(TnxSqlSELECT(aOwner).Parent).Owner<>nil then
            begin
              aDatabase:=TnxSqlCPExists(TnxSqlSELECT(aOwner).Parent).Owner.Database;
              TnxSqlSELECT(aOwner).Database:=aDatabase;
            end;
          end else
          if (TnxSqlSELECT(aOwner).Parent is TnxSqlNonJoinTablePrimary) then begin
            if TnxSqlNonJoinTablePrimary(TnxSqlSELECT(aOwner).Parent).OwnerSelect<>nil then
            begin
              aDatabase:=TnxSqlSelect(TnxSqlNonJoinTablePrimary(TnxSqlSELECT(aOwner).Parent).OwnerSelect).Database;
              TnxSqlSELECT(aOwner).Database:=aDatabase;
            end;
          end
          else
            raise Exception.Create('Unexpected owner type in TnxSqlTableRef.GetTable: '+TnxSqlSELECT(aOwner).Parent.ClassName);

      try
        if Database=nil then
          raise EnxSqlDatabaseProxyException.Create('Database is nil!!');
        SetTable(Database.TableByName(AOwner, DatabaseNameStr, TableNameStr, AliasStr, aOpenMode));
      except
        on e: EnxSqlDatabaseProxyException do
          if e.ErrorCode = DBIERR_INVALIDDIR then begin
            // augment exception message with alias name, and location (if known)
            if assigned(DatabaseName) then
              s := TokenToLocationStr(DatabaseName)
            else
              s := '';
            s := format(nxcOrgMessageMarker + ' ("%s"%s)', [DatabaseNameStr, s]);
            raise EnxSqlDatabaseProxyException.nxCreate(DBIERR_INVALIDDIR, s);
          end else
            raise;
      end;
      if Table <> nil then
        Table.SetIndex('')
      else begin
        SetTable(OpenView(Self{aOwner as TnxSqlNode}, ParentBlock, Context, Database.GetDatabase(DatabaseNameStr){Database}, TableNameStr));
        IsView := assigned(Table);
      end;
    end;
    Result := Table;
  end else
    if TableExp <> nil then
      Result := TableExp.GetResultTable(Context, True)
    else begin
      if FuncTable <> nil then begin
        DoRefreshFunction(Context);
        Result := FuncTable
      end else begin
        Result := ExecuteTableFunction(Context);

        FuncTableContext := Context;
        if Assigned(Context) then begin
          FuncTableGeneration := Context.Generation;
          FuncTableRecordsRead := Context.RecordsRead;
        end else begin
          FuncTableGeneration := -1;
          FuncTableRecordsRead := -1;
        end;

        FuncTable := Result;
      end;
    end;
  if (AliasStr <> '') and (Result <> nil) and not SameText(AliasStr, Result.Alias) then
    Result.SetAlias(AliasStr);
  if (Table <> nil) and (ColumnList <> nil) then begin
    CNList := TnxFastStringListIC.Create;
    try
      for i := 0 to ColumnList.Count - 1 do
        CNList.Add(TnxSqlInsertItem(ColumnList[i]).ColumnNameStr);
      Tmp := Result.RenameColumns(CNList, True);
      if Table = Result then
      begin
        Result.Owner := self;
        SetTable(Tmp);
      end;
{      nxFreeAndNil(Result); already freed in SetTable}
      Result := Tmp;
    finally
      nxFreeAndNil(CNList);
    end;
  end;
end;

function TnxSqlTableRef.IsAmbiguousColumn(
  const ColumnName: string): Boolean;
begin
  if TableExp <> nil then
    Result := TableExp.IsAmbiguousColumn(ColumnName)
  else
    Result := False;
end;

function TnxSqlTableRef.RefersToTemp: Boolean;
begin
  Result := (TableNameStr <> '') and (TableNameStr[1] = '#') and not IsReservedTableName(TableNameStr)
    or (TableExp <> nil) and TableExp.RefersToTemp;
end;

procedure TnxSqlTableRef.RequestDestroy(sender: TObject);
begin
  if Table=sender then
    fTableInternal:=nil;
end;

function TnxSqlTableRef.GetTablenameStr: string;
begin
  if FTablename <> nil then
    Result := TokenToStrStripQ(FTablename)
  else
    Result := FTablenameStr;
end;

function TnxSqlTableRef.GetTargetFunc: TnxSqlNode;
var
  aStorage: TnxBaseSqlFunctionResolver;
begin
  if FTargetFunc = nil then begin
    FTargetFunc := TnxDatabaseResolverHub(Database.PsmDictionary.FunctionResolver).LookupFunction(FuncNameStr, Self, aStorage);
    if not assigned(FTargetFunc) then
      raise EnxInternalSQLException.CreateFmt(rsFunctionNotFound, [FuncNameStr]);
    if FTargetFunc is TnxSqlCREATEFUNC then
      TnxSqlCREATEFUNC(FTargetFunc).Database := Database;
    FTargetFunc.Parent := Self;
  end;
  Result := FTargetFunc;
end;

(*
function TnxSqlTableRef.PushCondFactors(Factors: TList): Boolean;
var
  NewSelect: TnxSqlSELECT;
  NewTableRef: TnxSqlTableRef;
  NewCondTerm: TnxSqlCondTerm;
  i: Integer;
  Exp: TnxSqlSimpleExpression;
  Term: TnxSqlTerm;
  Factor: TnxSqlFacColumn;
  FieldRef: TnxSqlFieldRef;
  Selection: TnxSqlSelection;
begin
  Result := False;
  if TableExp = nil then begin
    TableExp := TnxSqlTableExp.Create(Self);
    TableExp.NonJoinTableExp := TnxSqlNonJoinTableExp.Create(TableExp);
    TableExp.NonJoinTableExp.NonJoinTableTerm := TnxSqlNonJoinTableTerm.Create(TableExp.NonJoinTableExp);
    TableExp.NonJoinTableExp.NonJoinTableTerm.NonJoinTablePrimary :=
      TnxSqlNonJoinTablePrimary.Create(TableExp.NonJoinTableExp.NonJoinTableTerm);
    NewSelect := TnxSqlSELECT.Create(TableExp.NonJoinTableExp.NonJoinTableTerm.NonJoinTablePrimary);
    TableExp.NonJoinTableExp.NonJoinTableTerm.NonJoinTablePrimary.SelectSt := NewSelect;

    NewSelect.SelectionList := TnxSqlSelectionList.Create(NewSelect);

    Selection := TnxSqlSelection.Create(NewSelect.SelectionList);
    Exp := TnxSqlSimpleExpression.Create(Selection);
    Term := TnxSqlTerm.Create(Exp);
    Factor := TnxSqlFacColumn.Create(Term);
    FieldRef := TnxSqlFieldRef.Create(Factor);
    Factor.FieldRef := FieldRef;
    Term.AddFactor(Factor);
    Exp.AddTerm(Term);
    Selection.SimpleExpression := Exp;

    NewSelect.SelectionList.Add(Selection);

    NewSelect.TableRefList := TnxSqlTableRefList.Create(NewSelect);
    NewTableRef := TnxSqlTableRef.Create(NewSelect.TableRefList);
    NewSelect.TableRefList.Add(NewTableRef);
    NewTableRef.TablenameStr := Self.TablenameStr;
    NewTableRef.AliasStr := Self.AliasStr;
    NewSelect.CondExpWhere := TnxSqlCondExp.Create(NewSelect);
    NewCondTerm := TnxSqlCondTerm.Create(NewSelect.CondExpWhere);
    NewSelect.CondExpWhere.AddCondTerm(NewCondTerm);
    for i := 0 to Factors.Count - 1 do
      NewCondTerm.AddCondFactor((TObject(Factors[i]) as TnxSqlCondFactor).Clone(NewCondTerm) as TnxSqlCondFactor);
    TablenameStr := '';
    Result := True;
  end;
  // can be expanded further
end;
*)

procedure TnxSqlTableRef.LoadFromStream(Stream: TnxSqlPSMReader);
var
  i: Integer;
  ValueExp: TnxSqlSimpleExpression; //TnxSqlCondExp;
begin
  TableNameStr := Stream.ReadLString;
  DatabaseNameStr := Stream.ReadLString;
  TableExp := TnxSqlTableExp(Stream.ReadNodeOpt(Self));
  ColumnList := TnxSqlNodeList(Stream.ReadNodeOpt(Self));
  AliasStr := Stream.ReadLString;
  FuncNameStr := Stream.ReadLString;
  for i := 0 to Stream.ReadInt - 1 do begin
    ValueExp := Stream.ReadNode(Self) as TnxSqlSimpleExpression; //TnxSqlCondExp;
    AddParm(ValueExp);
  end;
end;

procedure TnxSqlTableRef.SaveToStream(Stream: TnxSqlPSMWriter);
var
  i: Integer;
begin
  Stream.WriteLString(TableNameStr);
  Stream.WriteLString(DatabaseNameStr);
  Stream.WriteNodeOpt(TableExp);
  Stream.WriteNodeOpt(ColumnList);
  Stream.WriteLString(AliasStr);
  Stream.WriteLString(FuncNameStr);
  Stream.WriteInt(ParmCount);
  for i := 0 to ParmCount - 1 do
    Stream.WriteNode(Parm[i].ValueExp);
end;

procedure TnxSqlTableRef.SetAliasStr(const Value: string);
begin
  if Value <> GetAliasStr then begin
    FAliasStr := Value;
    FAlias := nil;
  end;
end;

procedure TnxSqlTableRef.SetDatabaseNameStr(const Value: string);
begin
  if Value <> GetDatabaseNameStr then begin
    FDatabaseNameStr := Value;
    FDatabaseName := nil;
  end;
end;

procedure TnxSqlTableRef.SetFuncNameStr(const Value: string);
begin
  if Value <> GetFuncNameStr then begin
    FFuncNameStr := Value;
    FFuncName := nil;
  end;
end;

procedure TnxSqlTableRef.SetTable(aTable: TnxSqlTableProxy);
begin
  if (fTableInternal<>nil) then
  begin
    fTableInternal.RemoveDestroyNotifification(RequestDestroy);
    if (fTableInternal.Owner=self) then
      fTableInternal.Free;
  end;

  FTableInternal:=aTable;

  if fTableInternal<>nil then
    fTableInternal.AddDestroyNotifification(RequestDestroy);
end;

procedure TnxSqlTableRef.SetTablenameStr(const Value: string);
begin
  if Value <> GetTablenameStr then begin
    FTablenameStr := Value;
    FTablename := nil;
  end;
end;

function TnxSqlTableRef.Simplify(Context: TnxSqlContext): Boolean;
//var
  //DB: TnxSqlDatabaseProxy;
  //ViewDef: TnxSqlCREATEVIEW;
  //Tmp: TnxSqlTableExp;
  //TableName: string;
begin
  if TableExp <> nil then begin
    if TableExp.Simplify(Context) then begin
      Result := True;
      exit;
    end;
    (* view in-lining - work in progress
    if TableExp.EmbeddedView then begin
      if TableExp.NestedTableExp <> nil then begin
        Tmp := TableExp.NestedTableExp.Clone(Self) as TnxSqlTableExp;
        TableExp.Free;
        TableExp := Tmp;
        Result := True;
        exit;
      end;
      if (TableExp.SetTermCount = 0)
      and (TableExp.NonJoinTableExp <> nil) then begin
        with TableExp.NonJoinTableExp.NonJoinTableTerm.NonJoinTablePrimary do begin
          if SelectSt <> nil then
            if SelectSt.IsSingletableStarSelection(TableName) then begin
              TableNameStr := TableName;
              TableExp.Free;
              TableExp := nil;
              Result := True;
              exit;
            end;
        end;
      end;
    end;
    *)
  end else begin
    (* view in-lining - work in progress
    if (DatabaseNameStr = '') and (TablenameStr <> '') then begin
      DB := Owner.BindingDatabase;
      if DB <> nil then begin
        ViewDef := LoadViewDefinition(DB, TableNameStr);
        if ViewDef <> nil then begin
          if ViewDef.ColumnList = nil then begin
            TableExp := ViewDef.TableExp.Clone(Self) as TnxSqlTableExp;
            TableExp.EmbeddedView := True;
            TableNameStr := '';
            Result := True;
            exit;
          end;
        end;
      end;
    end;
    *)
  end;
  Result := False;
end;

function TnxSqlTableRef.TargetFieldFromSourceField(Context: TnxSqlContext;
  const F: TnxSqlFieldProxy): TnxSqlFieldProxy;
begin
  if TableExp <> nil then
    Result := TableExp.TargetFieldFromSourceField(Context, F)
  else
    if FuncTable <> nil then
      Result := FuncTable.FieldByName(F.Name)
    else
      Result := nil;
end;

function TnxSqlTableRef.RefersTo(const aTableName: string): Boolean;
begin
  if TableNameStr <> '' then
    Result := SameText(TablenameStr, aTableName)
  else
  if TableExp <> nil then
    Result := TableExp.RefersTo(aTableName)
  else
    Result := False;
end;

function TnxSqlTableRef.IsFullJoin(
  var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
begin
  Result := (TableExp <> nil) and TableExp.IsFullJoin(aJoinTableExp);
end;

function TnxSqlTableRef.IsLeftOrRightJoin(
  var aJoinTableExp: TnxSqlJoinTableExp): Boolean;
begin
  Result := (TableExp <> nil) and TableExp.IsLeftOrRightJoin(aJoinTableExp);
end;

function TnxSqlTableRef.RefersToContextVars(Context: TnxSqlContext): Boolean;
begin
  if Assigned(FTargetFunc) then
    Result := TnxSqlAbstractFunc(FTargetFunc).RefersToContextVars(Context)
  else if Assigned(FTableExp) then
    Result := FTableExp.RefersToContextVars(Context)
  else
    Result := False;
end;

function TnxSqlTableRef.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  if TableExp <> nil then
    Result := TableExp.RefersTo2(aTableName, aColumnName)
  else
    Result := False;
end;

function TnxSqlTableRef.ToString: WideString;
var
  i: integer;
begin
  if FuncNameStr <> '' then begin
    if DatabaseNameStr <> '' then
      Result := ' TABLE(' + DatabaseNameStr + '.' + FuncNameStr+'('
    else
      Result := ' TABLE('  + FuncNameStr+'(';

    for I := 0 to ParmCount-1 do
    begin
      Result:=Result+Parm[i].ToString;
      if i<ParmCount-1 then
        Result:=Result+', ';
    end;

    Result := Result +') )';
    if AliasStr <> '' then
      Result := Result + ' AS ' + AliasStr;
  end else
  if TableNameStr <> '' then begin
    if DatabaseNameStr <> '' then
      Result := ' ' + DatabaseNameStr + '.' + TableNameStr
    else
      Result := ' ' + TableNameStr;
    if AliasStr <> '' then
      Result := Result + ' AS ' + AliasStr;
  end else
  if TableExp <> nil then begin
    Result := ' (' + TableExp.ToString + ')';
    if AliasStr <> '' then
      Result := Result + ' AS ' + AliasStr;
    if ColumnList <> nil then
      Result := Result + ' (' + ColumnList.ToString + ')';
  end;
end;

procedure TnxSqlTableRef.Traverse(Callback: TnxSqlCallback; UserData: TObject; const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if IncludeNested and assigned(TableExp) then
    TableExp.Traverse(Callback, UserData, IncludeNested);
  if assigned(ColumnList) then
    ColumnList.Traverse(Callback, UserData, IncludeNested);
end;

function TnxSqlTableRef.ExecuteTableFunction(aContext: TnxSqlContext): TnxSqlTableProxy;
var
  Args: InxVariantList;
  V: Variant;
  LocalNameStr: string;
  Locale: TnxLocaleDescriptor;
  Local_i: Integer;

  _ValueExp: TnxSqlSimpleExpression;

  {
  _HasFieldRef: Boolean;
  _IsAggregate: Boolean;
  _IsAggregateStrict: Boolean;
  _IsAggregateExpression: Boolean;
  _IsAggregateExpressionStrict: Boolean;
  _IsColumnRefExpr: Boolean;
  _IsBLOBExpression: Boolean;
  _IsBoolean: Boolean;
  _IsCorrelatedSubquery: Boolean;
  _IsDeterministic: Boolean;
  _IsDeterministicWithinRow: Boolean;
  _IsFunction: Boolean;
  _FuncFac: TnxSqlFac;
  _IsField: Boolean;
  _FieldReferenced: TnxSqlFieldProxy;
  _IsIndependent: Boolean;
  _IsLiteral: Boolean;
  _IsLocalVariable: Boolean;
  _LocalNameStr: string;
  _IsNull: Boolean;
  _IsNullLiteral: Boolean;
  _IsParameter: Boolean;
  _IsPureAggregateExpression: Boolean;
  {}
begin
  FTargetFuncIsDeterministic := True;
  FTargetFuncIsDeterministicWithinRow := True;
  Args := nil;
  try
    if TnxSqlCREATEFUNC(TargetFunc).ArgCount <> 0 then
    begin
      Args := CreateVariantList(TnxSqlCREATEFUNC(TargetFunc).ArgCount);
      for Local_i := 0 to TnxSqlCREATEFUNC(TargetFunc).ArgCount - 1 do
      begin
        if Parm[Local_i].ValueExp.IsLocalVariable(aContext, LocalNameStr) then
        begin
          case TnxSqlCREATEFUNC(TargetFunc).Parm[Local_i].Mode of
            pmIn, pmInOut:
              begin
                v := Unassigned;
                V := aContext.GetValue(LocalNameStr);
                Locale := aContext.LookUpLocalLocaleDesc(LocalNameStr);
                Args.SetValue(Local_i, V, Locale);
              end;
          else
            Args.SetValue(Local_i, null, nil);
          end;
        end
        else
        begin
          if Parm[Local_i].ValueExp <> nil then
          begin
            v := Unassigned;

            _ValueExp := Parm[Local_i].ValueExp;
            {
            _HasFieldRef := _ValueExp.HasFieldRef;
            _IsAggregate := _ValueExp.IsAggregate(False);
            _IsAggregateStrict := _ValueExp.IsAggregate(True);
            _IsAggregateExpression := _ValueExp.IsAggregateExpression(False);
            _IsAggregateExpressionStrict := _ValueExp.IsAggregateExpression(True);
            _IsColumnRefExpr := _ValueExp.IsColumnRefExpr;
            _IsBLOBExpression := _ValueExp.IsBLOBExpression(aContext);
            _IsBoolean := _ValueExp.IsBoolean(aContext);
            _IsCorrelatedSubquery := _ValueExp.IsCorrelatedSubquery(aContext);
            _IsDeterministic := _ValueExp.IsDeterministic(aContext, False);
            _IsDeterministicWithinRow := _ValueExp.IsDeterministic(aContext, True);
            _IsFunction := _ValueExp.IsFunction(aContext, _FuncFac);
            _IsField := _ValueExp.IsField(aContext, _FieldReferenced);
            _IsIndependent := _ValueExp.IsIndependent;
            _IsLiteral := _ValueExp.IsLiteral;
            _IsLocalVariable := _ValueExp.IsLocalVariable(aContext, _LocalNameStr);
            _IsNull := _ValueExp.IsNull(aContext);
            _IsNullLiteral := _ValueExp.IsNullLiteral;
            _IsParameter := _ValueExp.IsParameter;
            _IsPureAggregateExpression := _ValueExp.IsPureAggregateExpression;
            {}

            FTargetFuncIsDeterministic := FTargetFuncIsDeterministic and _ValueExp.IsDeterministic(aContext, False);
            FTargetFuncIsDeterministicWithinRow := FTargetFuncIsDeterministicWithinRow and _ValueExp.IsDeterministic(aContext, True);

            v := _ValueExp.GetValue(aContext);
            Args.SetValue(Local_i, v, _ValueExp.GetLocaleDesc(aContext));
          end;
        end;
      end;
    end;
    Result := TnxSqlCREATEFUNC(TargetFunc).GetResultTable(aContext, Args);
  finally
    Args := nil;
  end;
end;

procedure TnxSqlTableRef.Unbind;
begin
  SetTable(nil);
  if TableExp <> nil then
    TableExp.Unbind;
end;

function TnxSqlTableRef.IsResultTable(T: TnxSqlTableProxy): Boolean;
begin
  Result := (Table = T)
    or (TableExp <> nil) and TableExp.IsResultTable(T);
end;


(*procedure TnxSqlTableRef.SetDatabase(Node: TnxSqlNode; UserData: TObject);
begin
  if Node is TnxSqlTableRef then
    with TnxSqlTableRef(Node) do
      if TablenameStr <> '' then
        DatabaseNameStr := TnxSqlDatabaseProxy(UserData).ServerDatabase.Alias;
end;*)


(*
function TnxSqlTableRef.BindView: Boolean;
var
  VD: TnxSqlCREATEVIEW;
  DB: TnxSqlDatabaseProxy;
  ViewDbName: string;
begin
  Result := False;
  ViewDbName := DatabaseNameStr;
  DB := Database.GetDatabase(DatabaseNameStr);
  VD := LoadViewDefinition(DB, TableNameStr);
  if VD <> nil then begin
    ParentBlock.Log('Merging view definition "' + TableNameStr + '"');
    Clear;
    TableExp := VD.TableExp.Clone(Self) as TnxSqlTableExp;
    if VD.ColumnList <> nil then
      ColumnList := VD.ColumnList.Clone(Self) as TnxSqlNodeList;
    ParentBlock.Log('Table reference definition after merge:"' + ToString + '"');
    VD.Free;
    if DB <> Database then
      TableExp.Traverse(SetDatabase, @ViewDBName, True);
    {TableExp.Traverse(SetDatabase, DB, True);}
    Result := True;
  end;
end;
*)

procedure TnxSqlTableRef.ClearStaleTableInstance(T: TnxSqlTableProxy);
begin
  if T=Table then
    SetTable(nil);
end;

function TnxSqlTableRef.LocationStr: string;
begin
  if FTablename <> nil then
    Result := TokenToLocationStr(FTableName)
  else
    Result := '';
end;

function TnxSqlTableRef.HasColumn(const ColumnName: string): Boolean;
begin
  Result := (Table <> nil) and assigned(Table.FieldByName(ColumnName));
end;

{ TnxSqlTableRefList }

function TnxSqlTableRefList.BindToFieldWithin(Context: TnxSqlContext; const DatabaseName, TableName,
  FieldName, FieldNameLoc: string): TnxSqlFieldProxy;
var
  i : Integer;
  ColumnAlias: string;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    Result := Item[i].BindFieldDown(Context, DatabaseName, TableName, FieldName, FieldNameLoc, ColumnAlias);
    if Result <> nil then
      exit;
  end;
end;

function TnxSqlTableRefList.Add(Item: TnxSqlNode): TnxSqlNode;
begin
  result:=inherited Add(Item);
end;

function TnxSqlTableRefList.BindTable(Context: TnxSqlContext; AOwner: TObject;
  const DatabaseName, TableName: string): TnxSqlTableProxy;
var
  i : Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    Result := Item[i].BindTable(Context, AOwner, DatabaseName, TableName);
    if Result <> nil then
      exit;
  end;
end;

{
function TnxSqlTableRefList.AliasToName(const AAlias: string): string;
var
  I : Integer;
begin
  for I := 0 to Count - 1 do
    if SameText(Item[i].AliasStr, AAlias) then begin
      Result := Item[i].TableNameStr;
      exit;
    end;
end;
}

function TnxSqlTableRefList.HasSuchAlias(const aAlias: string): Boolean;
var
  I : Integer;
begin
  for I := 0 to Count - 1 do
    if SameText(Item[i].AliasStr, aAlias) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlTableRefList.FieldListFromTable(Context: TnxSqlContext; const aTableName: string;
  List: TList): TnxSqlTableProxy;
var
  i, j: Integer;
begin

  Result := nil;
  for i := 0 to Count - 1 do
    with Item[i] do
      if SameText(AliasStr, aTableName)
      or SameText(TableNameStr, aTableName) then begin
        Result := GetResultTable(Context);
        for j := 0 to Result.FieldCount - 1 do
          List.Add(Result.FieldNC(j));
        exit;
      end;

  for i := 0 to Count - 1 do
    with Item[i] do begin
      if TableExp <> nil then
        Result := TableExp.GetFieldsFromTable(Context, aTableName, List);
      if Result <> nil then
        exit;
    end;
end;

function TnxSqlTableRefList.GetItem(Index: Integer): TnxSqlTableRef;
begin
  Result := TnxSqlTableRef(inherited Item[Index]);
end;

function TnxSqlTableRefList.Simplify(Context: TnxSqlContext): Boolean;
var
  i: Integer;
  TE: TnxSqlTableExp;
  JTE: TnxSqlJoinTableExp;
//  NJTE: TnxSqlNonJoinTableExp;
//  NJTT: TnxSqlNonJoinTableTerm;
//  NJTP: TnxSqlNonJoinTablePrimary;
//  Sel: TnxSqlSELECT;
  Tmp: TnxSqlTableRef;
  anItem: TnxSqlTableRef;

{.$DEFINE  ExtendedInnerSimplify}  // work in progress
{.$DEFINE  InnerFlattening}  // work in progress

  {$ifdef ExtendedInnerSimplify}
  function SimplifyInner(aJoin: TnxSqlJoinTableExp; start: boolean): Boolean;
  var
    j, k: Integer;
  begin
    result:=false;
    if (aJoin.JoinType=jtInner) and (aJoin.FTableRef1.TableExp=nil) and (aJoin.FTableRef2.TableExp=nil) then
    begin
      if (aJoin.UsingList = nil)
      and not aJoin.Natural
      and ((aJoin.CondExp = nil)
        or (aJoin.CondExp.CondTermCount = 1)) then begin
          anItem:=Item[i];
          TMP:=TnxSqlTableRef(aJoin.TableRef2.Clone(Self));
          FList.Insert(i, aJoin.TableRef1.Clone(Self));
          TE:=TnxSqlTableExp(aJoin.Parent);

          anItem:=TnxSqlTableRef(TE.Parent);
          anItem.TableExp:=nil;
          anItem.TablenameStr:=TMP.TablenameStr;
          anItem.AliasStr:=TMP.AliasStr;
          anItem.FuncNameStr:=TMP.FuncNameStr;
          anItem.FParmList.Assign(tmp.FParmList);
          Assert(Self.Parent is TnxSqlSELECT);
          if aJoin.CondExp <> nil then begin
            if TnxSqlSELECT(Parent).CondExpWhere = nil then begin
              TnxSqlSELECT(Parent).CondExpWhere := TnxSqlCondExp.Create(Owner);
              TnxSqlSELECT(Parent).CondExpWhere.AddCondTerm(TnxSqlCondTerm.Create(TnxSqlSELECT(Parent).CondExpWhere));
            end;
            for j := 0 to TnxSqlSELECT(Parent).CondExpWhere.CondTermCount - 1 do begin
              for k := 0 to ajoin.CondExp.CondTerm[0].CondFactorCount - 1 do
                TnxSqlSELECT(Parent).CondExpWhere.CondTerm[j].AddCondFactor(
                  aJoin.CondExp.CondTerm[0].
                    CondFactor[k].Clone(TnxSqlSELECT(Parent).CondExpWhere.CondTerm[j]) as TnxSqlCondFactor);
            end;
            Result := True;
            exit;
        end;
      end
    end
    else
    begin
      if (aJoin.FTableRef1.TableExp<>nil) and (aJoin.FTableRef1.TableExp.JoinTableExp<>nil) then
      begin
        Result:=SimplifyInner(aJoin.FTableRef1.TableExp.JoinTableExp, false);
      end;
    end;
  end;
  {$endif}

{$ifndef ExtendedInnerSimplify}
var
  j, k: integer;
{$endif}

{$ifdef InnerFlattening}
var
  m: integer;
  newselect: TnxSQLSelect;
  NewNonJoinTableExp : TnxSqlNonJoinTableExp;
  NewNonJoinTableTerm : TnxSqlNonJoinTableTerm;
  NewNonJoinTablePrimary: TnxSqlNonJoinTablePrimary;
  newref: TnxSqlTableRef;
  newexp: TnxSqlTableExp;
{$endif}

begin
  for i := 0 to Count - 1 do begin
    TE := Item[i].TableExp;
    if TE <> nil then begin
      JTE := TE.JoinTableExp;
      if JTE <> nil then begin
{$ifdef ExtendedInnerSimplify}
------ Not yet ready for prime time
        result:=SimplifyInner(jte, true);
        if result then
          exit;
  {$ifdef InnerFlattening}
------ Not yet ready for prime time
        if (JTE.JoinType<>jtInner) and (JTE.TableRef1.TableExp=nil) then
        begin
          TMP:=TnxSqlTableRef(JTE.TableRef1.Clone(Self));
//          Item[i].Free;
//          FList.Delete(i);
          FList.Insert(i, tmp);

          newref:=TnxSqlTableRef.Create(tmp);
          newexp:=TnxSqlTableExp.Create(newref);
          NewNonJoinTableExp := TnxSqlNonJoinTableExp.Create(newexp);
          NewNonJoinTableTerm := TnxSqlNonJoinTableTerm.Create(NewNonJoinTableExp);
          NewNonJoinTablePrimary := TnxSqlNonJoinTablePrimary.Create(NewNonJoinTableTerm);
          NewSelect := TnxSqlSELECT.Create(NewNonJoinTablePrimary);
          NewSelect.Distinct := false;
          NewSelect.SelectionList := TnxSQLSelectionList(TnxSqlSELECT(Parent).SelectionList.Clone(NewSelect));
          m:=pred(NewSelect.SelectionList.Count);
          while m>0 do
          begin
            if NewSelect.SelectionList[m].RefersTo(JTE.TableRef2.SQLName) then
            begin
              NewSelect.SelectionList[m].Free;
              NewSelect.SelectionList.FList.Delete(m)
            end
            else
              dec(m);
          end;

          NewSelect.TableRefList := TnxSQLTableRefList(self.Clone(NewSelect));
          NewSelect.TableRefList.fList.Delete(i+1);

          NewSelect.CondExpWhere :=TnxSQLCondExp(TnxSqlSELECT(Parent).CondExpWhere.Clone(NewSelect));
          if NewSelect.CondExpWhere.CondTermCount=1 then
          begin
            m:=pred(NewSelect.CondExpWhere.CondTerm[0].CondFactorCount);
            while m>0 do
            begin
              if NewSelect.CondExpWhere.CondTerm[0].CondFactor[m].RefersTo(JTE.TableRef2.SQLName) then
                NewSelect.CondExpWhere.CondTerm[0].CondFactorList.Delete(m)
              else
                dec(m);
            end;
          end;

          TnxSqlSELECT(Parent).CondExpWhere:=nil;
          NewNonJoinTablePrimary.SelectSt:=newselect;
          NewNonJoinTableTerm.NonJoinTablePrimary:=NewNonJoinTablePrimary;
          NewNonJoinTableExp.NonJoinTableTerm:=NewNonJoinTableTerm;
          newexp.NonJoinTableExp:=NewNonJoinTableExp;

//          newref.TableExp:=newexp;
          JTE.TableRef1.TablenameStr:='';
          JTE.TableRef1.AliasStr:='flattened_innerjoins';

{          for k := 0 to i-1 do
          begin
            m:=pred(TnxSqlSELECT(Parent).SelectionList.Count);
            while m>0 do
            begin
                if TnxSqlSELECT(Parent).SelectionList[m].RefersTo(Item[k].SQLName) then
                begin
                  TnxSqlFacColumn(TnxSqlSELECT(Parent).SelectionList[m].SimpleExpression.TermList[0].FactorList[0]).FieldRef.TableNameStr:='flattened_innerjoins';
                end;
                dec(m);
            end;
          end;}
          JTE.TableRef1.TableExp:=newexp;
          m:=i;

          for m := 1 to i+1 do
            FList.Delete(0);

          result:=true;
        end;
        if result then
          exit;
{$endif}
{$endif}
        case JTE.JoinType of
(*        jtLeftOuter, jtRightOuter, jtFullOuter :
          if (JTE.UsingList = nil)
          and not JTE.Natural
          and ((JTE.CondExp = nil)
            or (JTE.CondExp.CondTermCount = 1)) then begin

              // lets walk to through the joins and find the first table
              TMP:=TnxSqlTableRef(JTE.TableRef1);
              while (tmp.TablenameStr='') and (tmp.FuncNameStr='') do
              begin
                if (Tmp.TableExp<>nil) and (Tmp.TableExp.JoinTableExp<>nil) then
                  tmp:=Tmp.TableExp.JoinTableExp.TableRef1
                else
                  Break;
              end;
              if (TnxSqlSELECT(Parent).CondExpWhere <> nil)
              and (TnxSqlSELECT(Parent).CondExpWhere.CondTermCount = 1) then begin
                OwnerTerm := TnxSqlSELECT(Parent).CondExpWhere.CondTerm[0];
                // let's see if we can pull a simple global table filter into a join condition
                for j := 0 to OwnerTerm.CondFactorCount - 1 do begin
                  if OwnerTerm.CondFactor[j].JoinSimplified then
                    continue;
                  
                  if (OwnerTerm.CondFactor[j].CondPrimary is TnxSqlCPSimple) then
                  begin
                    anexp:=nil;
                    if (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp2<>nil) and (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp2.IsLiteral) then
                      if (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp1<>nil) and (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp1.IsColumn(tab, col)) then
                        anexp:=TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp1;
                    if (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp1<>nil) and (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp1.IsLiteral) then
                      if (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp2<>nil) and (TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp2.IsColumn(tab, col)) then
                        anexp:=TnxSqlCPSimple(TnxSqlCondFactor(OwnerTerm.CondFactor[j]).CondPrimary).SimpleExp2;
                    if anexp<>nil then
                    begin
                      // lets walk to through the joins and find the first table
                      TMP:=TnxSqlTableRef(JTE.TableRef1);
                      while (tmp.TablenameStr='') and (tmp.FuncNameStr='') do
                      begin
                        if (Tmp.TableExp<>nil) and (Tmp.TableExp.JoinTableExp<>nil) then
                          tmp:=Tmp.TableExp.JoinTableExp.TableRef1
                        else
                          Break;
                      end;
                      if (TnxSqlJoinTableExp(tmp.Parent).CondExp<>nil) and (TnxSqlJoinTableExp(tmp.Parent).UsingList=nil) then
                        if SameText(tmp.TablenameStr, tab) or SameText(tmp.AliasStr, tab) then
                        begin
                          // found a match, so lets remove the global filter and add it as join filter
                          TnxSqlJoinTableExp(tmp.Parent).CondExp.CondTerm[0].AddCondFactor(OwnerTerm.CondFactor[j].Clone(TnxSqlJoinTableExp(tmp.Parent).CondExp.CondTerm[0]) as TnxSqlCondFactor);
                          OwnerTerm.CondFactor[j].JoinSimplified:=true;
  {                        OwnerTerm.DeleteCondFactor(j);
                          if OwnerTerm.CondFactorCount=0 then
                            nxFreeAndNil(TnxSqlSELECT(Parent).fCondExpWhere);}
                          result:=true;
                          exit;
                        end;

                    end;
                  end;
               end;
            end;
          end
          ;*)
        {$ifndef ExtendedInnerSimplify}
        jtInner :
          if (JTE.UsingList = nil)
          and not JTE.Natural
          and ((JTE.CondExp = nil)
            or (JTE.CondExp.CondTermCount = 1)) then begin
              anItem:=Item[i];
              TMP:=TnxSqlTableRef(JTE.TableRef1.Clone(Self));

 {
              if (tmp.TableExp<>nil) and (tmp.TableExp.JoinTableExp<>nil) then
              begin
                if tmp.TableExp.JoinTableExp.TableRef1.AliasStr<>'' then
                  tmp.AliasStr:=tmp.TableExp.JoinTableExp.TableRef1.AliasStr
                else
                if tmp.TableExp.JoinTableExp.TableRef1.TablenameStr<>'' then
                  tmp.AliasStr:=tmp.TableExp.JoinTableExp.TableRef1.TablenameStr;
              end;
}


              FList.Insert(0, JTE.TableRef2.Clone(Self));
              FList.Insert(0, Tmp);

              Assert(Self.Parent is TnxSqlSELECT);
              if JTE.CondExp <> nil then begin
                if TnxSqlSELECT(Parent).CondExpWhere = nil then begin
                  TnxSqlSELECT(Parent).CondExpWhere := TnxSqlCondExp.Create(Owner);
                  TnxSqlSELECT(Parent).CondExpWhere.AddCondTerm(TnxSqlCondTerm.Create(TnxSqlSELECT(Parent).CondExpWhere));
                end;
                for j := 0 to TnxSqlSELECT(Parent).CondExpWhere.CondTermCount - 1 do begin
                  for k := 0 to anItem.TableExp.JoinTableExp.CondExp.CondTerm[0].CondFactorCount - 1 do
                    TnxSqlSELECT(Parent).CondExpWhere.CondTerm[j].AddCondFactor(
                      JTE.CondExp.CondTerm[0].
                        CondFactor[k].Clone(TnxSqlSELECT(Parent).CondExpWhere.CondTerm[j]) as TnxSqlCondFactor);
                end;
                Item[i + 2].Free;
                FList.Delete(i + 2);
                Result := True;
                exit;
              end
              else
              begin
                Item[0].Free;
                FList.Delete(0);
                Item[0].Free;
                FList.Delete(0);
              end;
          end;
        {$endif}
        jtCross :
          begin
            Add(JTE.TableRef1.Clone(Self));
            Add(JTE.TableRef2.Clone(Self));
            Assert(Self.Parent is TnxSqlSELECT);
            Item[i].Free;
            FList.Delete(i);
            Result := True;
            exit;
          end;
        end;
      end; {else begin
        if TE.NonJoinTableExp <> nil then begin
          NJTE := TE.NonJoinTableExp;
          if (NJTE <> nil) then begin
            NJTT := NJTE.NonJoinTableTerm;
            if (NJTT <> nil) and (NJTT.SetPrimariesCount = 0) then begin
              NJTP := NJTT.NonJoinTablePrimary;
              if NJTP <> nil then begin
                Sel := NJTP.SelectSt;
                if Sel <> nil then begin
                  if not Sel.Distinct
                  and not assigned(Sel.CondExpHaving)
                  and not assigned(Sel.CondExpWhere)
                  and not assigned(Sel.GroupColumnList)
                  and (Sel.LimitInt = -1)
                  and not assigned(Sel.OrderList)
                  and (trim(Sel.SelectionList.ToString) = '')
                  and (Sel.TableRefList.Count = 1)
                  and (Sel.TableRefList[0].TablenameStr <> '')
                  and (Sel.TargetTablestr = '') then begin
                    Tmp := Sel.TableRefList[0].Clone(Self) as TnxSqlTableRef;
                    TmpA := Item[i].AliasStr;
                    Item[i].Assign(Tmp);
                    Item[i].AliasStr := TmpA;
                    Tmp.Free;
                    Result := True;
                    exit;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;  }

    end;
  end;

  for i := 0 to Count - 1 do
    if Item[i].Simplify(Context) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

procedure TnxSqlTableRefList.Unbind;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Item[i].Unbind;
end;

function TnxSqlTableRefList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlTableRefList.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlTableRefList.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlTableRefList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlTableRefList.RefersToContextVars(Context: TnxSqlContext): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersToContextVars(Context) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlTableRefList.RefersToTemp: Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersToTemp then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlTableRefList.IsResultTable(T: TnxSqlTableProxy): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].IsResultTable(T) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

{
function TnxSqlTableRefList.ItemByName(TableName: string): TnxSqlTableRef;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if SameText(Item[i].AliasStr, TableName)
    or SameText(Item[i].TableNameStr, TableName) then begin
      Result := Item[i];
      exit;
    end;
end;
}

{ TnxSqlUsingItem }

procedure TnxSqlUsingItem.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlUsingItem then begin
    ColumnNameStr := TnxSqlUsingItem(Source).ColumnNameStr;
  end else
    ENotCompatible(Source);
end;

function TnxSqlUsingItem.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlUsingItem then
    Result := SameText(ColumnNameStr, TnxSqlUsingItem(ANode).ColumnNameStr)
  else
    Result := False;
end;

function TnxSqlUsingItem.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlUsingItem.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlUsingItem.ToString;
begin
  Result := ' ' + ColumnNameStr;
end;

procedure TnxSqlUsingItem.Traverse(Callback: TnxSqlCallback; UserData: TObject; 
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
end;

procedure TnxSqlUsingItem.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  ColumnNameStr := Stream.ReadLString;
end;

procedure TnxSqlUsingItem.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteLString(ColumnNameStr);
end;

function TnxSqlUsingItem.GetColumnNameStr: string;
begin
  if FColumnName <> nil then
    Result := TokenToStrStripQ(FColumnName)
  else
    Result := FColumnNameStr;
end;

procedure TnxSqlUsingItem.SetColumnNameStr(const Value: string);
begin
  if Value <> GetColumnNameStr then begin
    FColumnNameStr := Value;
    FColumnName := nil;
  end;
end;

{ TnxSqlUsingList }

function TnxSqlUsingList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlUsingList.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlUsingList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if SameText(Item[i].ColumnNameStr, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlUsingList.GetItem(Index: Integer): TnxSqlUsingItem;
begin
  Result := TnxSqlUsingItem(inherited Item[Index]);
end;

function TnxSqlUsingList.ReferencesFieldName(const aName: String): boolean;
var
  k: integer;
begin
  result:=false;
  for k := 0 to Count - 1 do
    if SameText(Item[k].ColumnNameStr, aName) then
    begin
      result:=true;
      Break;
    end;
end;

{ TnxSqlValueItem }

procedure TnxSqlValueItem.Assign(const Source: TnxSqlNode);
begin
  if Source is TnxSqlValueItem then begin
    nxFreeAndNil(FSimplex);
    Default := TnxSqlValueItem(Source).Default;
    if TnxSqlValueItem(Source).Simplex <> nil then
      Simplex := TnxSqlValueItem(Source).Simplex.Clone(Self) as TnxSqlSimpleExpression;
  end else
    ENotCompatible(Source);
end;

function TnxSqlValueItem.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlValueItem.Create(AParent);
  Result.Assign(Self);
end;

destructor TnxSqlValueItem.Destroy;
begin
  nxFreeAndNil(FSimplex);
  inherited;
end;

function TnxSqlValueItem.Equals(ANode: TnxSqlNode): Boolean;
begin
  if ANode is TnxSqlValueItem then
    with TnxSqlValueItem(ANode) do
      Result := (Default = Self.Default)
      and NodesIdentical(Simplex, Self.Simplex)
  else
    Result := False;
end;

function TnxSqlValueItem.GetDecimals(Context: TnxSqlContext): Integer;
begin
  if assigned(Simplex) then
    Result := Simplex.GetDecimals(Context)
  else
    Result := 0;
end;

function TnxSqlValueItem.GetSize(Context: TnxSqlContext): Integer;
begin
  if assigned(Simplex) then
    Result := Simplex.GetSize(Context)
  else
    Result := 1;
end;

function TnxSqlValueItem.GetType(Context: TnxSqlContext): TnxFieldType;
begin
  if assigned(Simplex) then
    Result := Simplex.GetType(Context)
  else
    raise EnxInternalSQLException.Create(rsUndefined);
end;

function TnxSqlValueItem.IsDeterministic(aWithinRow: Boolean): Boolean;
begin
  Result := Default or (Simplex = nil) or Simplex.IsDeterministic(nil, aWithinRow);
end;

{
function TnxSqlValueItem.IsLiteral: Boolean;
begin
  Result := Default or (Simplex = nil) or Simplex.IsIndependent; {HasStaticValue;
end;
}

function TnxSqlValueItem.IsNull: Boolean;
begin
  Result := Simplex = nil;
end;

procedure TnxSqlValueItem.LoadFromStream(Stream: TnxSqlPSMReader);
begin
  Default := Stream.ReadBool;
  Simplex := TnxSqlSimpleExpression(Stream.ReadNodeOpt(Self));
end;

function TnxSqlValueItem.RefersTo(const aTableName: string): Boolean;
begin
  Result := (Simplex <> nil) and Simplex.RefersTo(aTableName);
end;

function TnxSqlValueItem.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := (Simplex <> nil) and Simplex.RefersTo(aTableName, aColumnName);
end;

procedure TnxSqlValueItem.SaveToStream(Stream: TnxSqlPSMWriter);
begin
  Stream.WriteBool(Default);
  Stream.WriteNodeOpt(Simplex);
end;

function TnxSqlValueItem.ToString: WideString;
begin
  if Default then
    Result := 'DEFAULT '
  else if Simplex = nil then
    Result := 'NULL '
  else                                        
    Result := Simplex.ToString;
end;

procedure TnxSqlValueItem.Traverse(Callback: TnxSqlCallback; UserData: TObject;
  const IncludeNested: Boolean);
begin
  Callback(Self, UserData);
  if assigned(Simplex) then
    Simplex.Traverse(Callback, UserData, IncludeNested);
end;

procedure TnxSqlValueItem.Unbind;
begin
  if Simplex <> nil then
    Simplex.Unbind;
end;

{ TnxSqlValueList }

function TnxSqlValueList.Add(Item: TnxSqlNode): TnxSqlNode;
begin
  Assert(Item is TnxSqlValueItem);
  FIsDeterministic := FIsDeterministic and TnxSqlValueItem(Item).IsDeterministic(False);
  Result := inherited Add(Item);
end;

procedure TnxSqlValueList.Assign(const Source: TnxSqlNode);
var
  i: Integer;
begin
  if Source is TnxSqlValueList then
    with TnxSqlValueList(Source) do begin
      Self.Clear;
      for i := 0 to Count - 1 do
        Self.Add(Item[i].Clone(Self));
    end
  else
    ENotCompatible(Source);
end;

function TnxSqlValueList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlValueList.Create(AParent);
  Result.Assign(Self);
end;

constructor TnxSqlValueList.Create(AOwner: TnxSqlNode);
begin
  inherited;
  FIsDeterministic := True;
end;

function TnxSqlValueList.GetItem(Index: Integer): TnxSqlValueItem;
begin
  Result := TnxSqlValueItem(inherited Item[Index]);
end;

function TnxSqlValueList.IsDeterministic: Boolean;
{var
  i: Integer;}
begin
  Result := FIsDeterministic;
  {for i := 0 to Count - 1 do
    if not Item[i].IsDeterministic then begin
      Result := False;
      exit;
    end;
  Result := True;}
end;

function TnxSqlValueList.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlValueList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if Item[i].RefersTo(aTableName, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlValueList.ToString: WideString;
begin
  Result := '(' + inherited ToString + ')';
end;

procedure TnxSqlValueList.Unbind;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Item[i].Unbind;
end;

{ TnxSqlValueListList }

function TnxSqlValueListList.GetItem(Index: Integer): TnxSqlValueList;
begin
  Result := TnxSqlValueList(inherited Item[Index]);
end;

{
function TnxSqlValueListList.GetOwnerStatement: TnxSqlColumnListOwner;
begin
  Result := TnxSqlColumnListOwner(Self);
  while (Result <> nil)
  and not (TObject(Result) is TnxSqlColumnListOwner) do
    if TObject(Result) is TnxSqlNodeList then
      Result := TnxSqlColumnListOwner(TnxSqlNodeList(Result).Owner)
    else
      Result := TnxSqlColumnListOwner(TnxSqlNode(Result).Parent);
  if not (TObject(Result) is TnxSqlColumnListOwner) then
    Result := nil;
end;
}

destructor TnxSqlValueListList.Destroy;
begin
  if FResultTable <> nil then begin
    FResultTable.Owner := nil;
    nxFreeAndNil(FResultTable);
  end;
  FResultTable := nil;
  inherited;
end;

function TnxSqlValueListList.ToString: WideString;
var
  i: Integer;
begin
  Result := 'VALUES ';
  for i := 0 to FList.Count - 1 do begin
    Result := Result + TnxSqlValueList(FList.List[i]).ToString;
    if i < Count - 1 then
      Result := Result + ',' + #13#10;
  end;
end;

function TnxSqlValueListList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlValueListList.Create(AParent);
  Result.Assign(Self);
end;

procedure TnxSqlValueListList.Merge(aList: TnxSqlValueListList);
var
  i: Integer;
begin
  {for i := 0 to aList.Count - 1 do
    FList.Add(aList.Item[i].Clone(Self));}
  for i := 0 to aList.Count - 1 do begin
    FList.Add(aList.Item[i]);
  end;
  aList.FList.Clear;
end;

procedure TnxSqlValueListList.Unbind;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TnxSqlValueList(FList.List[i]).Unbind;
  if FResultTable<>nil then
    if FResultTable.Owner=self then
      nxFreeAndnil(FResultTable);
end;

function TnxSqlValueListList.IsDeterministic: Boolean;
{var
  i: Integer;}
begin
  Result := FIsDeterministic;
  {for i := 0 to FList.Count - 1 do
    if not TnxSqlValueList(FList.List[i]).IsDeterministic then begin
      Result := False;
      exit;
    end;
  Result := True;}
end;

function TnxSqlValueListList.RefersTo(const aTableName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if TnxSqlValueList(FList.List[i]).RefersTo(aTableName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlValueListList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if TnxSqlValueList(FList.List[i]).RefersTo(aTableName, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

constructor TnxSqlValueListList.Create(AOwner: TnxSqlNode);
begin
  inherited;
  FIsDeterministic := True;
end;

function TnxSqlValueListList.Add(Item: TnxSqlNode): TnxSqlNode;
begin
  Assert(Item is TnxSqlValueList);
  FIsDeterministic := FIsDeterministic and TnxSqlValueList(Item).IsDeterministic;
  Result := inherited Add(Item);
end;

{ TnxSqlOrderList }

function TnxSqlOrderList.RefersTo(const aTableName,
  aColumnName: string): Boolean;
var
  i : Integer;
begin
  for i := 0 to Count - 1 do
    if ((Item[i].Column.TableNameStr = '') or SameText(Item[i].Column.TableNameStr, aTableName))
      and SameText(Item[i].Column.FieldNameStr, aColumnName) then begin
      Result := True;
      exit;
    end;
  Result := False;
end;

function TnxSqlOrderList.AllColumnReferencesQualified(
  const AliasName: string; var QualRefList: TnxFastStringListIC): Boolean;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if not Item[i].AllColumnReferencesQualified(AliasName, QualRefList) then begin
      Result := False;
      exit;
    end;
  Result := True;
end;

function TnxSqlOrderList.Clone(AParent: TnxSqlNode): TnxSqlNode;
begin
  Result := TnxSqlOrderList.Create(AParent);
  Result.Assign(Self);
end;

function TnxSqlOrderList.GetItem(Index: Integer): TnxSqlOrderItem;
begin
  Result := TnxSqlOrderItem(inherited Item[Index]);
end;

{ TnxSqlAggregateList }

function TnxSqlAggregateList.GetItem(Index: Integer): TnxSqlAggregate;
begin
  Result := TnxSqlAggregate(inherited GetItem(Index));
end;

{ This useless comment is required for BCB *yikes* }

function TnxSqlAggregateList.NeedToReadRecords(Context: TnxSqlContext): Boolean;
var
  F: TnxSQLFieldProxy;
  i: Integer;
  Ag: TnxSqlAggregate;
begin
  result:=false;
  for i := 0 to Count - 1 do begin
    Ag := Item[i];
    if not (Ag.AgFunction in [agCount]) then
    begin
      result:=true;
      exit;
    end;
    if Ag.SimpleExpression = nil then
      continue; //that's a count(*), no need to further look at this agg
    if not Ag.SimpleExpression.IsField(Context, F) then
    begin
      result:=true;        // expression is no field, can't handle that
      exit;
    end;
    if not (F.Name=TnxSqlGroupColumn(TnxSqlSELECT(GetOwnerSelect).GroupColumnList[0]).FieldNameStr) then
    begin
      result:=true;  // the field isn't the first field in the grouping; can't handle that
      exit;
    end;
  end;
end;

{ TnxInternalTableRef }

constructor TnxInternalTableRef.Create(const aDatabaseName, aName: string;
  aTableRef: TnxSqlTableRef; aTable: TnxSqlTableProxy; aUnnamed: Boolean;
    aTakeOwnership: Boolean; aRefresh: TnxSqlTableRefresher; aTableExp: TnxSqlTableExp);
begin
  DatabaseName := aDatabaseName;
  Name := aName;
  TableRef2 := aTableRef;
  if Assigned(aTable) then
    SetTable(aTable);
  Unnamed := aUnnamed;
  IsJoinResult:=false;
  if aTakeOwnership then
    Table.Owner := Self;
  FRefresh := aRefresh;
  TableExp := aTableExp;
end;

destructor TnxInternalTableRef.Destroy;
begin
  SetTable(nil);
  inherited;
end;

{
function TnxInternalTableRef.GetResultTable(
  Context: TnxSqlContext): TnxSqlTableProxy;
begin
  Result := GetTable(Context, Self, somReadOnly);
end;

function TnxInternalTableRef.GetTable(Context: TnxSqlContext;
  aOwner: TObject; aOpenMode: TnxSqlOpenmode): TnxSqlTableProxy;
begin
  Result := TableRef2.GetTable(Context, aOwner, aOpenMode);
  if TableRef2.IsView then
    FRefresh := TableRef2.Refresh;
end;
}

procedure TnxInternalTableRef.Refresh(aContext: TnxSqlContext);
var
  NewTable: TnxSqlTableProxy;
begin
  if assigned(FRefresh) then
    FRefresh(aContext)
  else if Assigned(Table) and Assigned(TableRef2) and Table.IsTemp and not TableRef2.IsView and not Table.IsMetaTable then begin
    TableRef2.SetTable(nil);
    NewTable := TableRef2.GetTable(aContext, Table.Owner, Table.stpOpenMode);
    if NewTable <> Table then
      Table.TransplantCursorFrom(NewTable);
  end;
end;

procedure TnxInternalTableRef.SetIsJoinResult(const Value: Boolean);
begin
  fIsJoinResult := Value;
  if fTableInternal<>nil then
    fTableInternal.IsJoinResult:=fIsJoinResult;
end;

procedure TnxInternalTableRef.SetTable(aTable: TnxSQLTableProxy; freeOld: boolean=false);
begin
  if aTable <> fTableInternal then begin
    if (Table<>nil) then
    begin
      Table.RemoveDestroyNotifification(TableDestroyed);
      if (Table.Owner=self) then
        fTableInternal.Free;
    end;

    fTableInternal:=aTable;

    if Table<>nil then
      Table.AddDestroyNotifification(TableDestroyed);
  end;
end;

procedure TnxInternalTableRef.TableDestroyed(sender: TObject);
begin
  if Table = sender then
    fTableInternal := nil;
end;

{ TnxInternalTableRefList }

function TnxInternalTableRefList.Add(ITR: TnxInternalTableRef): Integer;
begin
  if FList = nil then
    FList := TList.Create;
  Result := FList.Add(ITR);
end;

procedure TnxInternalTableRefList.Clear;
var
  i: Integer;
begin
  if FList <> nil then begin
    for i := 0 to Count - 1 do
      TObject(FList[i]).Free;
    nxFreeAndNil(FList);
  end;
end;

function TnxInternalTableRefList.Count: Integer;
begin
  if FList = nil then
    Result := 0
  else
    Result := FList.Count;
end;

destructor TnxInternalTableRefList.Destroy;
begin
  Clear;
  inherited;
end;

function TnxInternalTableRefList.GetItem(
  Index: Integer): TnxInternalTableRef;
begin
  if FList = nil then
    raise EnxInternalSQLException.Create(rsIndexOutOfRange);
  Result := TnxInternalTableRef(FList[Index]);
end;

function TnxInternalTableRefList.IndexOf(const DatabaseName, TableName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if SameText(Item[i].Name, TableName) and ((DatabaseName = '') or SameText(Item[i].DatabaseName, DatabaseName)) then begin
      Result := i;
      exit;
    end;
end;

function TnxInternalTableRefList.FindTableRef(
  const DatabaseName, TableName: string; Context: TnxSQLContext): TnxSQLTableRef;
var
  i: Integer;

    function GetRef(const DatabaseName, TableName: string; TableRef: TnxSqlTableRef; TableExp: TnxSQLTableExp): TnxSQLTableRef;
  var
    aTable: TnxSQLTableProxy;
    begin
      Result := nil;
      if (TableRef<>nil) and (SameText(TableName, TableRef.AliasStr) or SameText(TableName, TableRef.TablenameStr))
        and ((DatabaseName = '') or SameText(DatabaseName, TableRef.DatabaseNameStr)) then
      begin
        result:=TableRef;
        exit;
      end;

      if (TableRef<>nil) and (tableRef.TableExp<>nil) then
        TableExp:=tableRef.TableExp;
      
      if TableExp<>nil then
      begin
        if TableExp.JoinTableExp<>nil then
        begin
          result:=GetRef(DatabaseName, Tablename, TableExp.JoinTableExp.TableRef1, nil);
          if result<>nil then
            exit;
          result:=GetRef(DatabaseName, Tablename, TableExp.JoinTableExp.TableRef2, nil);
          if result<>nil then
            exit;
        end
        else
        if (TableExp.NestedTableExp<>nil) then
        begin
          aTable:=TableExp.NestedTableExp.GetResultTable(Context, false);
          result:=TnxSqlTableRef.Create(TableExp.NonJoinTableExp);
          result.IsStandalone:=true;
          result.SetTable(aTable);
//          result:=GetRef(TableName, nil,  TableExp.NestedTableExp);
        end
        else
        if (TableExp.NonJoinTableExp<>nil) then
        begin
          aTable:=TableExp.NonJoinTableExp.GetResultTable(Context, false);
          result:=TnxSqlTableRef.Create(TableExp.NonJoinTableExp);
          result.IsStandalone:=true;
          result.SetTable(aTable);
        end;
      end;
    end;


begin
  result:=nil;
  for i := 0 to Count - 1 do
  begin
    result:=GetRef(DatabaseName, TableName, Item[i].TableRef2, Item[i].TableExp);
    if result<>nil then
      exit;
  end;
end;

{ TnxSqlExexParm }

constructor TnxSqlExecParm.Create(
  aValueExp: TnxSqlSimpleExpression{TnxSqlCondExp});
begin
  FValueExp := aValueExp;
end;

destructor TnxSqlExecParm.Destroy;
begin
  nxFreeAndNil(FValueExp);
  inherited;
end;

function TnxSqlExecParm.RefersTo(const aTableName: string): Boolean;
begin
  Result := ValueExp.RefersTo(aTableName);
end;

function TnxSqlExecParm.RefersTo(const aTableName,
  aColumnName: string): Boolean;
begin
  Result := ValueExp.RefersTo(aTableName, aColumnName);
end;

function TnxSqlExecParm.ToString: WideString;
begin
  Result := ValueExp.ToString;
end;

procedure TnxSqlExecParm.Unbind;
begin
  ValueExp.Unbind;
end;

{ TnxSqlOrderByScope }

procedure TnxSqlOrderByScope.AddColumn(const ColumnName: string);
begin
  FUnQualColumnList.AddObject(ColumnName, TObject(FUnQualColumnList.Count));
end;

procedure TnxSqlOrderByScope.Clear;
begin
  FUnqualColumnList.Clear;
end;

constructor TnxSqlOrderByScope.Create;
begin
  FUnqualColumnList := TnxFastStringListIC.Create;
  FUnqualColumnList.Sorted := True;
end;

destructor TnxSqlOrderByScope.Destroy;
begin
  nxFreeAndNil(FUnqualColumnList);
  inherited;
end;

function TnxSqlOrderByScope.FindColumn(const ColumnName: string; MustExist: Boolean = False): Integer;
begin
  Result := FUnqualColumnList.IndexOf(ColumnName);
  if MustExist and (Result = -1) then
    raise EnxInternalSQLException.CreateFmt(rsUnknownColumnInORDERBY, [ColumnName]);
  if Result <> -1 then
    Result := Integer(FUnqualColumnList.Objects[Result]);
end;

{ TnxSqlColumnCalculator }

function TnxSqlColumnCalculator.BlobAsVariant(aField   : TnxFieldDescriptor;
                                              aBlobNr  : TnxBlobNr)
                                                       : Variant;
var
  Error         : TnxResult;
  Len           : TnxWord32;
  VPtr          : PByte;
  ws            : WideString;
  Stream        : TnxAnsiStringStream;
begin
  Error := DBIERR_NONE;

  with aField do
    if Assigned(sfsServerCursor) then begin
      Error := sfsServerCursor.sbcBlobGetLength(ridNull, Number, aBlobNr, Len, False, nil);
      if Error = DBIERR_NONE then
        if Len = 0 then
          Result := null
        else begin
          if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
            if fdType = nxtBlobWideMemo then begin
              SetLength(ws, Len div 2);
              with TnxStaticMemoryStream.Create(@ws[1], Len) do
                try
                  Error := sfsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
                finally
                  Free;
                end;
            end else begin
              Stream := TnxAnsiStringStream.Create(StringOfChar(AnsiChar(#0), Len));
              try
                Stream.Position := 0;
                Error := sfsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, Stream, False, nil);
                if Error = DBIERR_NONE then
                  ws := nxStringToDelphiWideString(Stream.DataString, UsedStorageCodePage);
              finally
                nxFreeAndNil(Stream);
              end;
            end;
            Result := ws;
          end else begin
            Result := VarArrayCreate([0, Pred(Len)], VarByte);
            VPtr := VarArrayLock(Result);
            try
              with TnxStaticMemoryStream.Create(VPtr, Len) do
                try
                  Error := sfsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
                finally
                  Free;
                end;
            finally
              VarArrayUnlock(Result);
            end;
          end;
        end;
    end else if Assigned(bsfsCursor) then begin
      Error := sfsAbstractCursor.BlobGetLength(ridNull, Number, aBlobNr, Len, False, nil);
      if Error = DBIERR_NONE then
        if Len = 0 then
          Result := null
        else begin
          if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
            if fdType = nxtBlobWideMemo then begin
              SetLength(ws, Len div 2);
              with TnxStaticMemoryStream.Create(@ws[1], Len) do
                try
                  Error := sfsAbstractCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
                finally
                  Free;
                end;
            end else begin
              Stream := TnxAnsiStringStream.Create(StringOfChar(AnsiChar(#0), Len));
              try
                Stream.Position := 0;
                Error := sfsAbstractCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, Stream, False, nil);
                if Error = DBIERR_NONE then
                  ws := nxStringToDelphiWideString(Stream.DataString, UsedStorageCodePage);
              finally
                nxFreeAndNil(Stream);
              end;
            end;
            Result := ws;
          end else begin
            Result := VarArrayCreate([0, Pred(Len)], VarByte);
            VPtr := VarArrayLock(Result);
            try
              with TnxStaticMemoryStream.Create(VPtr, Len) do
                try
                  Error := sfsAbstractCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
                finally
                  Free;
                end;
            finally
              VarArrayUnlock(Result);
            end;
          end;
        end;
    end else
      Result := Null;

  if Error <> DBIERR_NONE then
    raise EnxsqlCheckStatementException.nxCreate(Error);
end;

function TnxSqlColumnCalculator.BlobsSupported: Boolean;
begin
  Result := Assigned(sfsAbstractCursor);
end;

constructor TnxSqlColumnCalculator.Create(
  aFieldsDescriptor: TnxFieldsDescriptor; aCursor: TObject;
  const aSqlText: WideString);
var
  Tokens    : TTokenList;
  lLCID     : Integer;
  lMode     : TnxSqlPSMDictionaryMode;
begin
  bsfsFieldsDescriptor := aFieldsDescriptor;
  bsfsCursor := aCursor;

  sfsAbstractCursor := aCursor as TnxAbstractCursor;
  if sfsAbstractCursor is TnxSqlAbstractCursor then
    sfsServerCursor := TnxSqlAbstractCursor(sfsAbstractCursor);

  sfsWideQuery := 'SELECT * FROM x WHERE ' + aSqlText + ';';

  with TnxSqlTokenizer.Create do try
    Tokens := nil;
    try
      if Tokenize(PWideChar(sfsWideQuery), Length(sfsWideQuery), False, False, Tokens) then begin
        with TnxSqlParser.Create(Tokens) do try
          if Parse then begin
            Compile;
            sfsRootNode := RootNode;
            sfsTokens := Tokens;
            Tokens := nil;
          end else
            raise EnxInternalSQLException.CreateFmt(rsSyntaxError, [
              Tokens.TokenStartLine[FailedTokenIndex],
              Tokens.TokenStartPos[FailedTokenIndex],
              ExpectedTokensString
              ]);
        finally
          Free;
        end;
      end else
        if Tokens.TokenCount > 0 then
          raise EnxInternalSQLException.CreateFmt(rsInvalidTokenError, [
            Tokens.TokenEndLine[Tokens.TokenCount - 1],
            Tokens.TokenEndPos[Tokens.TokenCount - 1]])
        else
          raise EnxInternalSQLException.Create(rsInvalidTokenErrorAtStart);
    finally
      nxFreeAndNil(Tokens);
    end;
  finally
    Free;
  end;

  Assert(Assigned(sfsRootNode));

  if Assigned(sfsAbstractCursor) and
    (sfsAbstractCursor.Database is TnxServerDatabase) then begin

    lLCID := 0;
    lMode := dmPersistant;

    with sfsAbstractCursor.Database.Session do
      if ServerEngine is TnxServerEngine then
        with TnxServerEngine(ServerEngine) do
          if SqlEngine is TnxSqlEngine then
            with TnxSqlEngine(SqlEngine) do begin
              lLCID := LCID;
              lMode := DictionaryMode;
            end;
    sfsRootNode.Database :=
      DatabaseProxyFromDatabase(sfsAbstractCursor.Database as TnxSqlAbstractDatabase, lLCID, lMode);
  end;

  sfsLocalContext := TnxSqlContext.Create(sfsRootNode.Database, Now, nil);
  sfsLocalContext.ExternalColumnResolver := GetExtColumnDef;
  sfsLocalContext.ExternalColumnGetter := GetExtColumnValue;
end;

destructor TnxSqlColumnCalculator.Destroy;
var
  aDB: TObject;
begin
  if Assigned(sfsRootNode) then
    aDB:=sfsRootNode.Database;
  nxFreeAndNil(sfsLocalContext);
  nxFreeAndNil(sfsRootNode);
  nxFreeAndNil(sfsTokens);
  if Assigned(aDB) then
    ClearProxy(TnxSQLDatabaseProxy(aDB));
  inherited;
end;

function TnxSqlColumnCalculator.GetExtColumnDef(const aColumnName: string;
  var aColType: TnxFieldType; var aColSize, aColDec: Integer; var aColLocDesc: TnxLocaleDescriptor): Integer;
begin
  Result := bsfsFieldsDescriptor.GetFieldFromName(aColumnName);
  if Result >= 0 then
    with bsfsFieldsDescriptor.FieldDescriptor[Result] do
      if (fdType in [nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo]) and not BlobsSupported then
        Result := -1
      else begin
        aColType := fdType;
        aColSize := fdUnits;
        aColDec := fdDecPl;
        aColLocDesc := UsedLocaleDescriptor;
      end;
end;

function TnxSqlColumnCalculator.GetExtColumnValue(
  aIndex: Integer): Variant;
var
  lType            : TnxFieldType;
  lSize            : TnxWord16;
  lValue           : PnxFieldBuffer;
begin
  if Assigned(bsfsRecord) and
    bsfsFieldsDescriptor.GetRecordFieldForFilter(aIndex, bsfsRecord, lType, lSize, lValue) then
    if lType in [nxtBlob, nxtBlobMemo, nxtBlobGraphic, nxtBlobWideMemo] then
      Result := BlobAsVariant(bsfsFieldsDescriptor.FieldDescriptor[aIndex], PnxInt64(lValue)^)
    else
      with bsfsFieldsDescriptor.FieldDescriptor[aIndex] do
        Result := VariantFromNative(lType, UsedStorageCodepage, fdUnits,
          fdDecPl, lValue, lSize)
  else
    Result := Null;
end;

function TnxSqlColumnCalculator.GetValue(aRowBuffer: PnxRecordBuffer): variant;
begin
  bsfsRecord := aRowBuffer;
  Result := sfsRootNode.EvaluateFirst(sfsLocalContext);
end;

{ TnxSqlRefNrSet }

procedure TnxSqlRefNrSet.Add(const RefNr: int64);
var
  H: Integer;
  NewEntry: PRefPoolEntry;
begin
  if not Exists(RefNr) then begin
    H := RefNr mod RefSetHashSize;
    NewEntry := EntryPool.Alloc;
    NewEntry^.Ref := RefNr;
    NewEntry^.Next := EntryHash[H];
    EntryHash[H] := NewEntry;
  end;
end;

procedure TnxSqlRefNrSet.AddItem(const RefNr: int64; UserData: Pointer);
begin
  Add(RefNr);
end;

procedure TnxSqlRefNrSet.Add(Source: TnxSqlRefNrSet);
begin
  Source.Iterate(AddItem, nil);
end;

procedure TnxSqlRefNrSet.Clear;
begin
  EntryPool.Free;
  EntryPool := TnxSqlRefNrPool.Create;
  fillchar(EntryHash, sizeof(EntryHash), 0);
end;

constructor TnxSqlRefNrSet.Create;
begin
  EntryPool := TnxSqlRefNrPool.Create;
  fillchar(EntryHash, sizeof(EntryHash), 0);
end;

destructor TnxSqlRefNrSet.Destroy;
begin
  EntryPool.Free;
  fillchar(EntryHash, sizeof(EntryHash), 0);
  inherited;
end;

function TnxSqlRefNrSet.Exists(const RefNr: int64): Boolean;
var
  H: Integer;
  Look: PRefPoolEntry;
begin
  H := RefNr mod RefSetHashSize;
  Look := EntryHash[H];
  while Look <> nil do
    if Look^.Ref = RefNr then begin
      Result := True;
      exit;
    end else
      Look := Look^.Next;
  Result := False;
end;

procedure TnxSqlRefNrSet.Iterate(Iterator: TnxSqlRefNrSetIterator;
  UserData: Pointer);
var
  i: Integer;
  Look: PRefPoolEntry;
begin
  for i := 0 to RefSetHashSize - 1 do begin
    Look := EntryHash[i];
    while Look <> nil do begin
      Iterator(Look^.Ref, UserData);
      Look := Look^.Next;
    end;
  end;
end;

procedure TnxSqlRefNrSet.Intersect(Source: TnxSqlRefNrSet; Negative: Boolean);
var
  I: Integer;
  Prev, Look: PRefPoolEntry;
begin
  {remove the items from self not found in Source}
  for i := 0 to RefSetHashSize - 1 do begin
    Look := EntryHash[i];
    Prev := nil;
    while Look <> nil do begin
      if (Negative and Source.Exists(Look^.Ref))
      or (not Negative and not Source.Exists(Look^.Ref)) then begin
        if Prev <> nil then
          Prev^.Next := Look^.Next
        else
          EntryHash[i] := Look^.Next;
        if EntryHash[i]=Look then
          EntryHash[i]:=Look^.Next;
      end
      else
        Prev := Look;
      Look := Look^.Next;
    end;
  end;
end;

{ TnxSqlRefNrPool }

function TnxSqlRefNrPool.Alloc: PRefPoolEntry;
begin
  if SlotPtr >= RefPoolEntriesPerPage then begin
    new(CurPage);
    CurPage.Next := FirstPage;
    FirstPage := CurPage;
    SlotPtr := 0;
  end;
  Result := @CurPage.Entries[SlotPtr];
  inc(SlotPtr);
end;

constructor TnxSqlRefNrPool.Create;
begin
  SlotPtr := RefPoolEntriesPerPage;
end;

destructor TnxSqlRefNrPool.Destroy;
var
  Tmp: PRefPoolPage;
begin
  while CurPage <> nil do begin
    Tmp := CurPage^.Next;
    Dispose(CurPage);
    CurPage := Tmp;
  end;
  inherited;
end;

{ TnxSqlPoolManager }

function TnxSqlPoolManager.Alloc: Pointer;
begin
  if Root = nil then begin
    Result := nil;
    exit;
  end;
  while TnxNativeUInt(Next) >= TnxNativeUInt(NextPage) do begin
    if not Grow then begin
      Result := nil;
      exit;
    end;
  end;
  Result := Next;
  inc(TnxNativeUInt(Next), InternalItemSize);
end;

constructor TnxSqlPoolManager.Create(ItemSize, MaxItemCount: DWord);
begin
  if MaxItemCount = 0 then
    exit;
  InternalItemSize := ItemSize;
  PageSize := 4096;
  while PageSize < ItemSize do
    PageSize := PageSize + 4096;
  while PageSize mod InternalItemSize <> 0 do
    inc(InternalItemSize);
  Root := VirtualAlloc(nil, InternalItemSize * MaxItemCount, MEM_RESERVE, PAGE_NOACCESS);
  if Root = nil then
    exit;
  NextPage := Root;
  Next := Root;
  Top := Pointer(TnxNativeUInt(Root) + InternalItemSize * MaxItemCount);
end;

destructor TnxSqlPoolManager.Destroy;
begin
  if Root <> nil then
    VirtualFree(Root, 0, MEM_RELEASE);
  inherited;
end;

function TnxSqlPoolManager.Grow: Boolean;
var
  aPointer: Pointer;
begin
  if TnxNativeUInt(NextPage) >= TnxNativeUInt(Top) then begin
    Result := False;
    exit;
  end;
  aPointer:=
    VirtualAlloc(NextPage, PageSize, MEM_COMMIT, PAGE_READWRITE);
  if aPointer = nil then
    Result := False
  else begin
    inc(TnxNativeUInt(NextPage), PageSize);
    Result := True;
  end;
end;

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  RegisterNodeType(TnxSqlGroupColumn);
  RegisterNodeType(TnxSqlGroupColumnList);
  RegisterNodeType(TnxSqlJoinTableExp);
  RegisterNodeType(TnxSqlNonJoinTableExp);
  RegisterNodeType(TnxSqlNonJoinTablePrimary);
  RegisterNodeType(TnxSqlNonJoinTableTerm);
  RegisterNodeType(TnxSqlOrderColumn);
  RegisterNodeType(TnxSqlOrderItem);
  RegisterNodeType(TnxSqlOrderList);
  RegisterNodeType(TnxSqlSELECT);
  RegisterNodeType(TnxSqlSelection);
  RegisterNodeType(TnxSqlSelectionList);
  RegisterNodeType(TnxSqlTableExp);
  RegisterNodeType(TnxSqlTableRef);
  RegisterNodeType(TnxSqlTableRefList);
  RegisterNodeType(TnxSqlUsingItem);
  RegisterNodeType(TnxSqlUsingList);
  RegisterNodeType(TnxSqlValueItem);
  RegisterNodeType(TnxSqlValueList);
  RegisterNodeType(TnxSqlValueListList);
end.



