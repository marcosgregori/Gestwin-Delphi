unit DataManager;

interface

uses SysUtils,
     Controls,
     Variants,
     Classes,
     Generics.Collections,
     Rtti,
     TypInfo,

     nxllException,
     nxsdServerEngine,
     nxreRemoteServerEngine,
     nxptBasePooledTransport,
     nxtwWinsockTransport,
     nxllTransport,
     nxtcCOMTransport,
     nxllComponent,
     nxsrServerEngine,
     nxsdDataDictionaryStrings,

     nxsdTypes,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdConst,
     nxllBde,
     nxsdDataDictionary,
     nxdbBase,

     {$IFDEF SERVERAPP}
     MemoryDataset,
     {$ELSE}
     dxmdaset,
     {$ENDIF}
     SQLSet,

     DB,
     nxDB,

     LibUtils,
     AppManager;

type

  TSQLFieldOrder = ( sfNoOrder, sfAscend, sfDescend );

  TnxeDatabaseDictionary = class;
  TKeySource = ( ksLowest, ksGreatest,  ksRangeStart, ksRangeEnd, ksRecord, ksList, ksKey );
  TFieldArea = ( faKey, faData, faAll );
  TTableType = ( ttStandard, ttTemporal, ttVirtual, ttRecover, ttMemVirtual );
  TTableSide = ( tsClientSide, tsServerSide, tsMemory );
  TMasterRelation = (mrLoose, mrBalanced, mrTied );
  TStringKey = shortString;
  TFieldValuesArray = array of Variant;
  TFieldsArray = array of TField;
  TCheckRangeState = ( rsInRange, rsLow, rsHigh, rsExcluded );

  TnxeDatasetFields = class;
  TgxMemData = class;
  TnxeTable = class;
  TnxeQuery = class;

  TDataEventEvent = procedure( Event : TDataEvent; Info : Longint ) of object;
  TDatabaseErrorEvent = procedure ( Dataset : TDataset; Exception : EDatabaseError; TableName : String = '' ) of object;
  TDatasetFieldsEvent = procedure ( DatasetFields : TnxeDatasetFields ) of object;
  TDatasetInternalEvent = procedure ( Correct : Boolean ) of object;
  TDatasetCheckEvent = function( Dataset : TDataset ) : Boolean of object;
  TCheckDetailDatasetsEvent = function( Dataset : TDataset; Posting : Boolean ) : Boolean of object;
  TDatasetGetValueEvent = function( Dataset : TDataset ) : Integer of object;
  TDataSourceNotifyEvent = procedure( DataSource: TDataSource ) of object;
  TCopyRecordsPostEvent = function( SourceTable : TnxDataset; TargetTable : TnxeTable ) : Boolean of object;

  TCheckFieldFunction = reference to function( Field : TField ) : Boolean;

  TRangeStateRecord = record
    CheckState   : TCheckRangeState;
    IndexSegment : SmallInt;
    end;

  InxeDataset = interface ['{E098D990-B540-45E2-ACDB-28A9DC535910}']
    function GetAutoIncFieldName : String;
    procedure SetAutoIncFieldName( const Value : String );
    function GetFireEditionEvents : Boolean;
    procedure SetFireEditionEvents( const Value : Boolean );
    function GetShiftingRecords : Boolean;
    procedure SetShiftingRecords( const Value : Boolean );
    function GetOnUpdateState : TDataSetNotifyEvent;
    procedure SetOnUpdateState( const Value : TDataSetNotifyEvent );
    function GetOnApplyMasterRange : TDataSetNotifyEvent;
    procedure SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
    function GetAutoIncField : TField;
    function GetMinAutoIncValue : Variant;
    function GetMaxAutoIncValue : Variant;
    function GetMasterRelation : TMasterRelation;
    procedure SetMasterRelation( const Value : TMasterRelation );
    function SetTempState(const Value: TDataSetState): TDataSetState;
    procedure RestoreState(const Value: TDataSetState);
    function  GetOpenOnMasterActivation : Boolean;
    function  GetReadOnly : Boolean;
    procedure SetReadOnly( const Value : Boolean );

    procedure ApplyMasterRange;
    function IsAppending : Boolean;
    procedure OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );
    procedure UnlockRecord;
    procedure DeleteRecords( Raw : Boolean = False );
    procedure Update;

    property AutoIncFieldName : String read GetAutoIncFieldName write SetAutoIncFieldName;
    property FireEditionEvents : Boolean read GetFireEditionEvents write SetFireEditionEvents;
    property AutoIncField : TField read GetAutoIncField;
    property MinAutoIncValue : Variant read GetMinAutoIncValue;
    property MasterRelation : TMasterRelation read GetMasterRelation write SetMasterRelation;
    property MaxAutoIncValue : Variant read GetMaxAutoIncValue;
    property ReadOnly : Boolean read GetReadOnly write SetReadOnly;
    property ShiftingRecords : Boolean read GetShiftingRecords write SetShiftingRecords;

    property OnApplyMasterRange : TDataSetNotifyEvent read GetOnApplyMasterRange write SetOnApplyMasterRange;
    property OnUpdateState : TDataSetNotifyEvent read GetOnUpdateState write SetOnUpdateState;
    end;

  TnxeFieldsDescriptor = class( TnxFieldsDescriptor )
  public property LogRecLen : Integer read fsdLogRecLen;
    end;

  TAttrFieldName = class( TCustomAttribute )
    private
      FFieldName : String;
    public
      constructor Create( AFieldName : String );
    property FieldName : String read FFieldName write FFieldName;
    end;

  TAttrCalculatedField = class( TCustomAttribute )
    end;

  TAttrPeriodicalField = class( TCustomAttribute )
    private
      FFieldBaseName : String;
      FPeriodicalNames : String;
    public
      constructor Create( AFieldBaseName : String = ''; APeriodicalNames : String = '' );
    property FieldBaseName : String read FFieldBaseName write FFieldBaseName;
    property PeriodicalNames : String read FPeriodicalNames write FPeriodicalNames;
    end;

  TnxeDatasetFields = class( TComponent )
    private

      FRemoteCursorID : TnxCursorID;
      FDataset : TnxDataset;
      FTable : TnxeTable;
      FQuery : TnxeQuery;
      FIDataset : InxeDataset;
      FStaticData : Boolean;
      FMemDataset,
      FCalcMemDataset : TgxMemData;
      FInitialized,
      FIncompleteDataset,
      FCopyMemoFields,
      FCopyImageFields : Boolean;

      function  GetField( AFieldName : String; AFieldType : TFieldType; RaiseErrorIfNotFound : Boolean = True ) : TField; overload;
      function  GetField( AFieldName : String; AFieldClass : TClass; RaiseErrorIfNotFound : Boolean = True ) : TField; overload;

    protected

    public

      {  Puede que más adelante
      Id : TLongWordField;
      Creado : TDateTimeField;
      Actualizado : TDateTimeField;
      }

      constructor Create( ADataset : TnxDataset; StaticData : Boolean = False; Incomplete : Boolean = False; OnSetup : TDatasetFieldsEvent = nil ); reintroduce; overload;

      procedure SetupFields; virtual;

      function FindField( FieldName : String ) : TField;
      function Fields : TFields;
      function GetRemoteCursorID : TnxCursorID;

      function CopyMemDatasetFields( Target : TDataSet ) : Integer;
      function  CopyDatasetFields( Source, Target : TDataSet ) : Integer;
      procedure CopyFieldsFrom( ADataset : TnxDataset );
      procedure CopyFieldsTo(ADataSet: TnxDataSet);
      procedure Setup( ADataSet : TnxDataSet; StaticData : Boolean = False; Incomplete : Boolean = False; OnSetup : TDataSetFieldsEvent = nil );
      procedure Update( ADataset : TnxDataset = nil; Incomplete : Boolean = False; OnSetup : TDataSetFieldsEvent = nil );
      procedure Clear( ADataSet : TnxDataSet = nil; Incomplete : Boolean = False; OnSetup : TDataSetFieldsEvent = nil );
      procedure CopyStaticFieldsTo( ADataSet : TnxDataSet );
      procedure DatasetAppend;
      procedure DatasetEdit;
      procedure DatasetCancel;
      procedure DatasetBrowse;
      procedure DatasetPost;
      procedure DatasetDelete;

      function SetStateFromInterface( InterfaceState : TDataSetState ) : Boolean;

      function WideStringField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TWideStringField;
      function GuidField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TGuidField;
      function UnsignedAutoIncField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TUnsignedAutoIncField;
      function FloatField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TFloatField;
      function BCDField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TBCDField;
      function IntegerField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TIntegerField;
      function SmallIntField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TSmallintField;
      function WordField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TWordField;
      function ByteField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TByteField;
      function LongWordField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TLongWordField;
      function LargeIntField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TLargeIntField;
      function DateField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TDateField;
      function TimeField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TTimeField;
      function DateTimeField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TDateTimeField;
      function BooleanField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TBooleanField;
      function BlobField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TBlobField;
      function WideMemoField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TWideMemoField;
      function GraphicField( FieldName : String; RaiseErrorIfNotFound : Boolean = True ) : TGraphicField;

      // Creación de campos calculados. Si existen (se han creado manualmente) se utilizan, en caso contrario se crean.

      function CreateCalculatedField( AFieldName : String; FieldType : TFieldType ) : TField; overload;
      function CreateCalculatedField( AFieldName : String; FieldClass : TClass ) : TField; overload;

      property CopyMemoFields : Boolean read FCopyMemoFields write FCopyMemoFields default True;
      property CopyImageFields : Boolean read FCopyImageFields write FCopyImageFields default False;

      property Dataset : TnxDataset read FDataset;
      property IDataset : InxeDataset read FIDataset;
      property Initialized : Boolean read FInitialized;
      property MemDataset : TgxMemData read FMemDataset;
      property Query : TnxeQuery read FQuery;
      property Table : TnxeTable read FTable;
      property StaticData : Boolean read FStaticData;
      property IncompleteDataset : Boolean read FIncompleteDataset write FIncompleteDataset;
      property RemoteCursorID : TnxCursorID read FRemoteCursorID write FRemoteCursorID;
      property CalcMemDataset : TgxMemData read FCalcMemDataset;
      end;

  TnxeDatabase = class( TnxDatabase )
  private
    FUpdatable : Boolean;  // Indica que es una base de datos que se puede actualizar de forma automática
  published
    property Updatable : Boolean read FUpdatable write FUpdatable default False;
    end;

  TnxeDatabaseDictionary = class( TnxeDatabase )
  private

    FTargetDatabase : TnxDatabase;   // La base de datos asociada a este diccionario. En general AppDatabase o UserDatabase.
    FIsAnOldVersion : Boolean;
    FTableList : TStringList;
    FOnBeforeUpdate,
    FOnAfterUpdate,
    FOnVerify : TSimpleEvent;
    FSQLSet : TgxSQLSet;

  protected
    procedure Notification( AComponent : TComponent; Operation: TOperation ); override;
    function GetSQLItems : TgxSQLItems;
    procedure SetSQLItems( const Value : TgxSQLItems );
    procedure DoOnVerify;
    procedure DoAfterUpdate;
    procedure DoBeforeUpdate;
    procedure scStarted; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetOrderedTableNames( AList : TStrings );

    Procedure Setup;
    procedure BeforeUpdate; virtual;
    procedure Verify; virtual;
    procedure AfterUpdate; virtual;
    procedure CreateTable( TableName : String; DefaultRecords : Boolean = False );
    procedure CopyDefaultRecords(TargetTable: TnxTable);

    property IsAnOldVersion : Boolean read FIsAnOldversion write FIsAnOldVersion;
    property SQLSet : TgxSQLSet read FSQLSet;

  published
    property TargetDatabase : TnxDatabase read FTargetDatabase write FTargetDatabase;
    property SQLItems : TgxSQLItems read GetSQLItems write SetSQLItems;
    property OnVerify : TSimpleEvent read FOnVerify write FOnVerify;
    property OnBeforeUpdate : TSimpleEvent read FOnBeforeUpdate write FOnBeforeUpdate;
    property OnAfterUpdate : TSimpleEvent read FOnAfterUpdate write FOnAfterUpdate;
    end;

  {
    El único objetivo de esta clase es definir una función LookupByID que no requiera el SessionID
    El ID del cursor no se busca en una lista ni nada parecido, es una referencia directa a la clase.
    El SessionID de la función ordinaria no es más que una comprobación adicional para
    evitar errores con supuestos IDs que no pertenezcan a la sesión indicada. En mi caso, ni caso.
  }

  TnxAbstractServerObjectHelper = class Helper for TnxAbstractServerObject
   class function LookupByID( ABaseID : TnxBaseID; out ABase ) : TnxResult;
   end;

   TnxBaseSessionHelper = class Helper for TnxBaseSession
    public
      procedure AssignAbstractSession( Value : TnxAbstractSession );
    end;

  TnxeTable = class( TnxTable, InxeDataset )
    private

    FDatabaseDictionary : TnxeDatabaseDictionary;
    FDataDictionary : TnxDataDictionary;   // Diccionario de referencia (el de la base de datos fDatabaseDictionary)
    FInternalSeekProcess,
    FInternalAppendProcess,
    FDeletingMasterRecord : Boolean;
    FCurrentBuffer : TnxRecordBuffer;
    FCurrentSearchKeyAction : TnxSearchKeyAction;
    FSavedAbstractCursor : TnxAbstractCursor;
    FCheckSearchAction : Boolean;
    FCreateIfAbsent,
    FCopyTableRecords,
    FSettingKey,
    FUpdatingProcess,
    FPostingKeyBuffer : Boolean;
    FTableType : TTableType;
    FClosingRecord,
    FGettingNewAutoIncValue,
    FHasPredefinedFields,                    // Indica que la lista de campos se ha predefinido (como en la mayoría de los registros de líneas, por ejemplo)
    FRecordOpened : Boolean;
    FAutoIncValueEditState : TDatasetState;  // El estado que tenía la tabla cuando se ha llamado a la generación automática de clave
    FAutoIncFieldName : String;              // La utilizo para saber si el usuario ha modificado algún valor de la clave o no antes de pulsar [F12]
    FAutoIncField : TField;
    FIndexNumber : Integer;
    FPreserveTemporalTableName : Boolean;
    FBlockDataEvents,
    FFireEditionEvents,
    FOpenOnMasterActivation,
    FRemoteEdit : Boolean;

    FOnRemotePost,
    FOnRemoteDelete : TDataSetNotifyEvent;

    FCanEdit,
    FCanInsert,
    FCanModify,
    FFailOnError,
    FInserting,
    FShiftingRecords : Boolean;

    FMasterRelation : TMasterRelation;
    FSavedState,
    FPreviousState : TDatasetState;

    FOnCanEditRecord,
    FOnCheckValidRecord : TDatasetCheckEvent;
    FOnCheckDetailDatasets : TCheckDetailDatasetsEvent;

    FOnGetRecord,
    FOnRecordChanged,
    FOnOpenRecord,
    FOnCloseRecord,
    FOnUpdateState,
    FOnSetKey : TDataSetNotifyEvent;
    FOnGetAutoIncValue : TDatasetGetValueEvent;
    FOnDataEvent : TDataEventEvent;

    FRangeState : TRangeStateRecord;
    FSavedRangeStart,
    FSavedRangeEnd : Pointer;
    FRangeRestored : Boolean;
    FRangeStartValues,
    FRangeEndValues : TFieldValuesArray;

    FDontCheckNullIndexValues : Boolean;

    procedure SetKeyBuffer( AKeyIndex : TnxKeyIndex );
    procedure PostKeyBuffer;
    function CheckSearchRecord( AGetMode : TGetMode ) : TGetResult;
    function GetBaseTableName : String;
    function GetFilePath : String;
    procedure SetCurrentSearchKeyAction( SearchCond : TnxSearchKeyAction );
    function GetAutoIncFieldName : String;
    procedure SetAutoIncFieldName( const Value : String );
    function GetFireEditionEvents : Boolean;
    procedure SetFireEditionEvents( const Value : Boolean );
    function GetShiftingRecords : Boolean;
    procedure SetShiftingRecords( const Value : Boolean );
    function GetOnUpdateState : TDataSetNotifyEvent;
    procedure SetOnUpdateState( const Value : TDataSetNotifyEvent );
    function GetOnApplyMasterRange : TDataSetNotifyEvent;
    procedure SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
    function GetAutoIncField : TField;
    function GetMinAutoIncValue : Variant;
    function GetMaxAutoIncValue : Variant;
    function GetMasterRelation : TMasterRelation;
    procedure SetMasterRelation( const Value : TMasterRelation );
    function SetTempState(const Value: TDataSetState): TDataSetState;
    procedure RestoreState(const Value: TDataSetState);
    function GetOpenOnMasterActivation : Boolean;
    function  GetReadOnly : Boolean;
    procedure SetReadOnly( const Value : Boolean );

    protected

    procedure Loaded; override;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OpenCursor(aInfoQuery: Boolean); override;
    procedure dsCloseCursorID; override;
    function GetCanEditRecord : Boolean;
    function GetRecord( ABuffer : TnxRecordBuffer; AGetMode : TGetMode; ADoCheck : Boolean ) : TGetResult; override;
    function GetEditing : Boolean;
    function GetEditingKey : Boolean;
    function GetReadableRecord : Boolean;
    function GetInternalProcess : Boolean;
    function GetModified : Boolean;
    procedure SetModified( const Value : Boolean );  // No sobreescribe el procedimiento del padre, solo me permite forzar el cambio el estado manualmente
    procedure SetSettingKey( const Value : Boolean );
    procedure GetRangeValues( var RangeStartValues : TFieldValuesArray; var RangeEndValues : TFieldValuesArray );
    function CheckRange( Values : TFieldValuesArray; var RangeStartValues : TFieldValuesArray; var RangeEndValues : TFieldValuesArray ) : TRangeStateRecord;
    procedure InternalPrepareKeyFields( const AKeyValues : array of const );

    function dsGetActiveBuffer(var ABuffer : TnxRecordBuffer): Boolean; override;
    function GetDataDictionary : TnxDataDictionary;
    function GetIndexNumber : integer;
    // procedure SetIndexNumber( const Value : integer );
    function KeyFieldCount( KeyBuffer : PnxDataSetKeyBuffer ) : integer;
    procedure FillSegments( FromSegment : SmallInt; MaxValues : Boolean );

    // Master-Detail

    procedure PropertyChanged;

    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalEdit; override;
    procedure InternalInsert; override;
    procedure InternalDelete; override;

    procedure DoAfterEdit; override;
    procedure DoBeforePost; override;
    procedure DoBeforeCancel; override;
    procedure DoBeforeDelete; override;
    procedure DoBeforeScroll; override;

    procedure DoOnRemotePost;
    procedure DoOnRemoteDelete;


  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AssignAbstractCursor( CursorID : TnxCursorID );
    procedure RestoreAbstractCursor;

    constructor AssignRootPropertiesFrom( ReferenceTable : TnxeTable );

    procedure SetDefaultErrorManager;
    procedure CopyIndexValues( SourceTable : TnxDataSet );
    procedure CopyFieldValues( SourceTable : TnxDataSet; ExcludeIndexFields : Boolean = False; IgnoreNonExistentFields : Boolean = False );

    function  SameKeyFields( const AKeyValues : array of const; LastSegment : SmallInt = -1 ) : Boolean; overload;
    function  SameKeyFields( AKeyValues : array of Variant; LastSegment : SmallInt = -1 ) : Boolean; overload;

    procedure dsError(const aErrorCode: TnxResult);

    function  StructChanged( CheckLocale : Boolean = False ) : Boolean;
    function  FieldStructChanged : Boolean;
    function  IndexStructChanged : Boolean;
    procedure CopyDictionaryRecords;
    procedure CheckTableStructure;
    procedure CheckTable;
    procedure CreateTemporalTableName( PreserveIt : Boolean = False );

    procedure DoOnSetKey;          // Estos eventos deben utilizarse exclusivamente para controlar los procesos de edición
    procedure DoOnGetRecord;       // y solo se llaman si FireEditionEvents está activado
    procedure DoOnRecordChanged;
    procedure DoOnOpenRecord;
    procedure DoOnCloseRecord;
    procedure DoOnUpdateState;

    procedure DoOnReadRecord;
    procedure DoOnNewRecord; override;
    procedure DoOnDefaultError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    procedure DoOnPostOrDeleteError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    function GetFieldIndexOnKey( FieldNo : SmallInt ) : SmallInt;
    function GetRemoteCursorID : TnxCursorID;

    function  IsFieldOnIndex( FieldDesc : TnxFieldDescriptor; IndexNumber : ShortInt ) : Boolean;
    function  IsIndexField( Field : TField ) : Boolean;
    function  IsFieldIndexed( Field : TField) : Boolean;
    procedure RemoveField( FieldName : String );
    function  IsFullRangeFixed : Boolean;
    function  IsAppending : Boolean;
    function  HasBlobs : Boolean;
    function  HasNestedDatasets : Boolean;
    procedure OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );
    procedure MasterChanged;

    {
    procedure SaveCurrentRecord( var RecordBuffer : TnxRecordBuffer );
    procedure RestoreSavedRecord( var RecordBuffer : TnxRecordBuffer; FreeRecord : Boolean = False );
    procedure FreeSavedRecord( var RecordBuffer : TnxRecordBuffer );
    }
    procedure EditKey;
    procedure SetKey;
    procedure Post; override;
    procedure Cancel; override;
    procedure CancelRange;
    procedure Browse;
    procedure Update;
    procedure RefreshAndEdit;
    function ReloadRecord( DisableCtrls : Boolean = False ) : Boolean;
    procedure CheckRecord;
    function  CheckDetailDataSets( Posting : Boolean = False ) : Boolean;
    procedure WriteMemoBuffer( AField : TField; const Buffer; Count : Longint );
    function  ReadMemoBuffer( AField : TField; var Buffer; BufferSize : Longint ) : LongInt;

    function  GetFieldValues : TFieldValuesArray;
    procedure SetFieldValues( const Values : TFieldValuesArray );
    function  GetFieldIndexValues : TFieldValuesArray; overload;
    procedure SetFieldIndexValues( const Values : TFieldValuesArray; const LastFieldName : string = '' );
    procedure ClearFieldValues;
    function  GetIndexFields : TFieldsArray; overload;
    procedure GetIndexFields( FieldList : TList ); overload;

    procedure ResetFound;
    function  SetToDatasetPos( Dataset : TnxDataset ) : Boolean;
    function  GotoKeyValues( const KeyValues : TFieldValuesArray )  : Boolean;
    // function  InternalFindKey( SearchCond : TnxSearchKeyAction; const KeyValues : TFieldValuesArray = nil; OnGetRecord : TDataSetInternalEvent = nil ) : Boolean;
    procedure InternalAppend;

    procedure SetKeyValues( const AKeyValues : array of const ); overload;
    procedure SetKeyValues( FieldValues : TFieldValuesArray ); overload;
    procedure SetKeyValues( AKeyIndex : TnxKeyIndex ; FieldValues : TFieldValuesArray ); overload;
    function  GetKeyValues : TFieldValuesArray; overload;
    function  GetKeyValues( AKeyIndex : TnxKeyIndex ) : TFieldValuesArray; overload;

    function  SetKeyRange( ARangeValues : array of Variant; ApplyRangeNow : Boolean = True ) : Boolean;
    function  SetDefaultKeyRange( ApplyRangeNow : Boolean = True ) : TFieldValuesArray;
    procedure SetDefaultRangeValues( RangeStart, RangeEnd : array of Variant );

    function  GotoRecord( SearchCond : TnxSearchKeyAction ) : Boolean;
    procedure CopyRecords( SourceTable : TnxDataSet; aCopyBLOBs : Boolean; BeforePostRecord : TCopyRecordsPostEvent = nil; aMaxTransSize : integer = 0 );
    procedure DeleteRangeRecords( const AStartValues, AEndValues : array of const; Raw : Boolean = False );
    procedure DeleteRecords( Raw : Boolean = False );
    function  DeleteMasterRecord : Boolean;
    procedure CloneRecord( const KeyValues : array of const );
    procedure CopyAndAppendRecord( SourcerDataSet : TnxDataSet; RaiseExceptionOnDuplicate : Boolean = True; ExcludeKeyFields : Boolean = False );
    function  PostRecord( CancelOnError : Boolean = True ) : Integer;
    procedure UnlockRecord;

    procedure SetRange( const AValues : array of const ); overload;
    procedure SaveRange( var SavedRangeStart : Pointer; var SavedRangeEnd : Pointer ); overload;
    procedure SaveRange; overload;
    procedure RestoreRange( var SavedRangeStart : Pointer; var SavedRangeEnd : Pointer ); overload;
    procedure RestoreRange( SetRangeRestored : Boolean = True ); overload;
    function  UpdateRange : Boolean;
    function  IsKeyInRange : Boolean;
    procedure ApplyMasterRange;

    function  GetDataValues : TFieldValuesArray;
    procedure SetDataValues( FieldValues : TFieldValuesArray );
    function  GetIndexValues : TFieldValuesArray;
    procedure SetIndexValues( FieldValues : TFieldValuesArray; CheckNumericFieldsRange : Boolean = False; SkipSegment : SmallInt = -1 );
    procedure CheckNullIndexValues;

    function  FindGreater( const AKeyValues : array of const ) : Boolean;
    function  FindGreaterOrEqual( const AKeyValues : array of const ) : Boolean;
    function  FindSmaller( const AKeyValues : array of const ) : Boolean;
    function  FindSmallerOrEqual( const AKeyValues : array of const ) : Boolean;
    function  FindEqualFirst( const AKeyValues : array of const ) : Boolean;
    function  FindEqualLast( const AKeyValues : array of const ) : Boolean;

    function  GetNextAutoIncValue : Variant;
    // function  GetNewAutoIncValue : Integer;
    function  GetNewAutoIncValue( IndexValues : TFieldValuesArray = nil ) : Variant;
    function  GetNewAutoIncStringValue( TemplateValue : String = '' ) : String;
    procedure NewAutoIncRecord( AppendRecord : Boolean = True );

    property AutoIncField : TField read GetAutoIncField;
    property AutoIncValueEditState : TDatasetState read FAutoIncValueEditState;
    property CanEditRecord : Boolean read GetCanEditRecord;
    property DatabaseDictionary : TnxeDatabaseDictionary read FDatabaseDictionary write FDatabaseDictionary;
    property DataDictionary : TnxDataDictionary read GetDataDictionary;
    property DeletingMasterRecord : Boolean read FDeletingMasterRecord;
    property DontCheckNullIndexValues : Boolean read FDontCheckNullIndexValues write FDontCheckNullIndexValues;
    property IndexNumber : integer read GetIndexNumber; //  write SetIndexNumber;
    property Inserting : Boolean read FInserting;
    property FailOnError : Boolean read FFailOnError write FFailOnError;
    property FilePath: String read GetFilePath;
    property BaseTableName : String read GetBaseTableName;
    property InternalSeekProcess : Boolean read FInternalSeekProcess;
    property InternalAppendProcess : Boolean read FInternalAppendProcess;
    property GettingNewAutoIncValue : Boolean read FGettingNewAutoIncValue;
    property SettingKey : Boolean read FSettingKey write SetSettingKey;
    property Editing : Boolean read GetEditing;
    property EditingKey : Boolean read GetEditingKey;
    property UpdatingProcess : Boolean read FUpdatingProcess;
    property ReadableRecord : Boolean read GetReadableRecord;
    property InternalProcess : Boolean read GetInternalProcess;
    property RecordOpened : Boolean read FRecordOpened;
    property HasPredefinedFields : Boolean read FHasPredefinedFields;
    property RangeRestored : Boolean read FRangeRestored;
    property PreserveTemporalTableName : Boolean read FPreserveTemporalTableName write FPreserveTemporalTableName default False;
    property PreviousState : TDataSetState read FPreviousState default dsInactive;
    property Modified : Boolean read GetModified write SetModified;
    property MinAutoIncValue : Variant read GetMinAutoIncValue;
    property MaxAutoIncValue : Variant read GetMaxAutoIncValue;
    property ShiftingRecords : Boolean read GetShiftingRecords write SetShiftingRecords;

    property OnDataEvent : TDataEventEvent read FOnDataEvent write FOnDataEvent;

    published

    property AutoIncFieldName : String read FAutoIncFieldName write SetAutoIncFieldName;
    property CanInsert : Boolean read FCanInsert write FCanInsert default True;
    property CanEdit : Boolean read FCanEdit write FCanEdit default True;
    property CanModify : Boolean read FCanModify write FCanModify default True;
    property CreateIfAbsent : Boolean read FCreateIfAbsent write FCreateIfAbsent default True;
    property BlockDataEvents : Boolean read FBlockDataEvents write FBlockDataEvents default False;
    property FireEditionEvents : Boolean read FFireEditionEvents write FFireEditionEvents default False;
    property OpenOnMasterActivation : Boolean read FOpenOnMasterActivation write FOpenOnMasterActivation default true;
    property MasterRelation : TMasterRelation read GetMasterRelation write SetMasterRelation default mrLoose;
    property TableType : TTableType read FTableType write FTableType default ttStandard;

    property OnCheckDetailDatasets : TCheckDetailDatasetsEvent read FOnCheckDetailDatasets write FOnCheckDetailDatasets;
    property OnCheckValidRecord : TDataSetCheckEvent read FOnCheckValidRecord write FOnCheckValidRecord;
    property OnCanEditRecord : TDataSetCheckEvent read FOnCanEditRecord write FOnCanEditRecord;
    property OnSetKey : TDataSetNotifyEvent read FOnSetKey write FOnSetKey;
    property OnGetRecord : TDataSetNotifyEvent read FOnGetRecord write FOnGetRecord;
    property OnRecordChanged : TDataSetNotifyEvent read FOnRecordChanged write FOnRecordChanged;
    property OnOpenRecord : TDataSetNotifyEvent read FOnOpenRecord write FOnOpenRecord;
    property OnCloseRecord : TDataSetNotifyEvent read FOnCloseRecord write FOnCloseRecord;
    property OnUpdateState : TDataSetNotifyEvent read FOnUpdateState write FOnUpdateState;
    property OnGetAutoIncValue : TDataSetGetValueEvent read FOnGetAutoIncValue write FOnGetAutoIncValue;
    property OnSetLinkRange;
    property OnApplyMasterRange;
    property OnRemotePost : TDataSetNotifyEvent read FOnRemotePost write FOnRemotePost;
    property OnRemoteDelete : TDataSetNotifyEvent read FOnRemoteDelete write FOnRemoteDelete;

    property RemoteEdit : Boolean read FRemoteEdit write FRemoteEdit default False;
    end;

  TnxeQuery = class( TnxQuery, InxeDataset )
  private
    FAutoIncFieldName : String;
    FAutoIncField : TField;
    FMinAutoIncValue,
    FMaxAutoIncValue : Variant;
    FMasterRelation : TMasterRelation;

    FFailOnError,
    FBlockDataEvents,
    FFireEditionEvents,
    FOpenOnMasterActivation,
    FApplyingMasterRange,
    FShiftingRecords : Boolean;

    FOnGetRecord,
    FOnRecordChanged,
    FOnUpdateState : TDataSetNotifyEvent;
    FOnGetAutoIncValue : TDatasetGetValueEvent;
    FOnCanEditRecord : TDatasetCheckEvent;
    FOnDataEvent : TDataEventEvent;
    FOnApplyMasterRange : TDataSetNotifyEvent;

    function GetAutoIncFieldName : String;
    procedure SetAutoIncFieldName( const Value : String );
    function GetFireEditionEvents : Boolean;
    procedure SetFireEditionEvents( const Value : Boolean );
    function GetShiftingRecords : Boolean;
    procedure SetShiftingRecords( const Value : Boolean );
    function GetOnUpdateState : TDataSetNotifyEvent;
    procedure SetOnUpdateState( const Value : TDataSetNotifyEvent );
    function GetOnApplyMasterRange : TDataSetNotifyEvent;
    procedure SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
    function GetAutoIncField : TField;
    function GetMinAutoIncValue : Variant;
    function GetMaxAutoIncValue : Variant;
    function GetMasterRelation : TMasterRelation;
    procedure SetMasterRelation( const Value : TMasterRelation );
    function SetTempState(const Value: TDataSetState): TDataSetState;
    procedure RestoreState(const Value: TDataSetState);
    function GetOpenOnMasterActivation : Boolean;
    function  GetReadOnly : Boolean;
    procedure SetReadOnly( const Value : Boolean );

  protected
    procedure OpenCursor(aInfoQuery: Boolean); override;

    function GetCanEditRecord : Boolean;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    function GetEditing : Boolean;
    procedure SetParsedSQLText( Value : UnicodeString );
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function dsApplyMasterRange(aFollowedByFirst: Boolean) : Boolean; override;

    procedure InternalEdit; override;

    procedure DoAfterClose; override;

  public
    constructor Create(AOwner: TComponent); override;
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure SetDefaultErrorManager;
    function  GetNewAutoIncValue : Variant;

    procedure DoOnUpdateState;   //  Eventos de edición
    procedure DoOnGetRecord;
    procedure DoOnRecordChanged;

    procedure DoOnPostOrDeleteError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    procedure DoOnDefaultError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    function  IsAppending : Boolean;
    procedure DeleteRecords( Raw : Boolean = False );
    procedure RefreshQuery( OnlyIfActive : Boolean = True );
    procedure Update;
    procedure UnlockRecord;
    procedure ApplyMasterRange;

    procedure ExecSQLVars( const SQLString : String; Values : array of Variant );
    procedure ExecSQLFields( const SQLString : String; Fields : array of TField );

    procedure SetParamValuesFromFields( Values : array of TField );
    procedure SetParamValues( Values : array of Variant );
    procedure OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );

    property AutoIncField : TField read GetAutoIncField;
    property CanEditRecord : Boolean read GetCanEditRecord;
    property Editing : Boolean read GetEditing;
    property FailOnError : Boolean read FFailOnError write FFailOnError;
    property ParsedSQLText : UnicodeString read QuText write SetParsedSQLText;
    property MinAutoIncValue : Variant read GetMinAutoIncValue;
    property MaxAutoIncValue : Variant read GetMaxAutoIncValue;
    property ShiftingRecords : Boolean read GetShiftingRecords write SetShiftingRecords;

    property OnApplyMasterRange : TDataSetNotifyEvent read FOnApplyMasterRange write FOnApplyMasterRange;
    property OnDataEvent : TDataEventEvent read FOnDataEvent write FOnDataEvent;
  published

    property AutoIncFieldName : String read FAutoIncFieldName write SetAutoIncFieldName;
    property BlockDataEvents : Boolean read FBlockDataEvents write FBlockDataEvents default False;
    property FireEditionEvents : Boolean read FFireEditionEvents write FFireEditionEvents default False;
    property OpenOnMasterActivation : Boolean read FOpenOnMasterActivation write FOpenOnMasterActivation default true;
    property MasterRelation : TMasterRelation read GetMasterRelation write SetMasterRelation default mrLoose;

    property OnCanEditRecord : TDataSetCheckEvent read FOnCanEditRecord write FOnCanEditRecord;
    property OnGetRecord : TDataSetNotifyEvent read FOnGetRecord write FOnGetRecord;
    property OnGetAutoIncValue : TDataSetGetValueEvent read FOnGetAutoIncValue write FOnGetAutoIncValue;
    property OnRecordChanged : TDataSetNotifyEvent read FOnRecordChanged write FOnRecordChanged;
    property OnUpdateState : TDataSetNotifyEvent read FOnUpdateState write FOnUpdateState;
    end;

  TnxeCachedDataSet = class( TnxCachedDataSet, InxeDataset )
  private
    FAutoIncFieldName : String;
    FAutoIncField : TField;
    FMinAutoIncValue,
    FMaxAutoIncValue : Variant;
    FMasterRelation : TMasterRelation;

    FFailOnError,
    FBlockDataEvents,
    FFireEditionEvents,
    FOpenOnMasterActivation,
    FShiftingRecords : Boolean;

    FOnGetRecord,
    FOnRecordChanged,
    FOnUpdateState : TDataSetNotifyEvent;
    FOnGetAutoIncValue : TDatasetGetValueEvent;
    FOnCanEditRecord : TDatasetCheckEvent;
    FOnDataEvent : TDataEventEvent;

    function GetAutoIncFieldName : String;
    procedure SetAutoIncFieldName( const Value : String );
    function GetFireEditionEvents : Boolean;
    procedure SetFireEditionEvents( const Value : Boolean );
    function GetShiftingRecords : Boolean;
    procedure SetShiftingRecords( const Value : Boolean );
    function GetOnUpdateState : TDataSetNotifyEvent;
    procedure SetOnUpdateState( const Value : TDataSetNotifyEvent );
    function GetOnApplyMasterRange : TDataSetNotifyEvent;
    procedure SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
    function GetAutoIncField : TField;
    function GetMinAutoIncValue : Variant;
    function GetMaxAutoIncValue : Variant;
    function GetMasterRelation : TMasterRelation;
    procedure SetMasterRelation( const Value : TMasterRelation );
    function SetTempState(const Value: TDataSetState): TDataSetState;
    procedure RestoreState(const Value: TDataSetState);
    function GetOpenOnMasterActivation : Boolean;
    function  GetReadOnly : Boolean;
    procedure SetReadOnly( const Value : Boolean );

  protected

    function GetCanEditRecord : Boolean;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    function GetEditing : Boolean;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure InternalEdit; override;

    procedure DoAfterClose; override;

  public
    constructor Create(AOwner: TComponent); override;

    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure SetDefaultErrorManager;
    function  GetNewAutoIncValue : Variant;

    procedure DoOnUpdateState;   //  Eventos de edición
    procedure DoOnGetRecord;
    procedure DoOnRecordChanged;

    procedure DoOnPostOrDeleteError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    procedure DoOnDefaultError( DataSet : TDataSet; E : EDatabaseError; var Action : TDataAction ); virtual;
    function  IsAppending : Boolean;
    procedure DeleteRangeRecords( const AStartValues, AEndValues : array of const; Raw : Boolean = False );
    procedure DeleteRecords( Raw : Boolean = False );
    procedure Update;
    procedure UnlockRecord;
    procedure ApplyMasterRange;

    procedure OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );

    property AutoIncField : TField read GetAutoIncField;
    property CanEditRecord : Boolean read GetCanEditRecord;
    property Editing : Boolean read GetEditing;
    property FailOnError : Boolean read FFailOnError write FFailOnError;
    property MinAutoIncValue : Variant read GetMinAutoIncValue;
    property MaxAutoIncValue : Variant read GetMaxAutoIncValue;
    property ShiftingRecords : Boolean read GetShiftingRecords write SetShiftingRecords;

    property OnDataEvent : TDataEventEvent read FOnDataEvent write FOnDataEvent;

  published

    property AutoIncFieldName : String read FAutoIncFieldName write SetAutoIncFieldName;
    property BlockDataEvents : Boolean read FBlockDataEvents write FBlockDataEvents default False;
    property FireEditionEvents : Boolean read FFireEditionEvents write FFireEditionEvents default False;
    property OpenOnMasterActivation : Boolean read FOpenOnMasterActivation write FOpenOnMasterActivation default true;
    property MasterRelation : TMasterRelation read GetMasterRelation write SetMasterRelation default mrLoose;

    property OnCanEditRecord : TDataSetCheckEvent read FOnCanEditRecord write FOnCanEditRecord;
    property OnGetRecord : TDataSetNotifyEvent read FOnGetRecord write FOnGetRecord;
    property OnGetAutoIncValue : TDataSetGetValueEvent read FOnGetAutoIncValue write FOnGetAutoIncValue;
    property OnRecordChanged : TDataSetNotifyEvent read FOnRecordChanged write FOnRecordChanged;
    property OnUpdateState : TDataSetNotifyEvent read FOnUpdateState write FOnUpdateState;
    property OnSetLinkRange;
    property OnApplyMasterRange;
    end;

  TnxeStoredProc = class( TnxStoredProc )
    procedure ExecProc( ParamValues : array of Variant ); overload;
    end;
  
  TgxMemData = class( {$IFDEF SERVERAPP} TMemData {$ELSE} TdxMemData {$ENDIF} )
  private
    function GetModified : Boolean;
    procedure SetModified( const Value : Boolean );
  protected
  public
   function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
   procedure DeleteAllRecords;

   property Modified: Boolean read GetModified write SetModified;

   end;

  TDatabaseErrorProcedure = procedure( DataSet : TDataSet; Exception : EDatabaseError; TableName : String = '' );

  TDatabaseErrorInfo = record
    ErrorCode : TnxResult;
    StError : String;
    StDesc : String;
    StSystem : String;
    VerifyDatabase : Boolean;
    UpdateDatabase : Boolean;
    FatalError : Boolean;
    end;

function  NexusToBDEFieldType( DataType : TnxFieldType ) : TFieldType;
function  GetDataTypeString( DataType : TFieldType ) : String;
function  FieldWidth( Field : TField ) : SmallInt;
function  GetMaxValue( DataType : TFieldType ) : Variant;
procedure SetMaxFieldValue( AField : TField );
function  GetMinValue( DataType : TFieldType ) : Variant;
procedure SetMinFieldValue( AField : TField );
function  CompareFieldValues( Values1, Values2 : TFieldValuesArray ) : ShortInt;
function  IndexSegments( DataDictionary : TnxDataDictionary; IndexNumber : ShortInt ) : ShortInt;

function  GetTableDictionary( TableName : String ) : TnxeDatabaseDictionary;
function  GetTemporalTableName( Database : TnxDatabase; TableName : String ) : String;
function  IsBaseTableName( TableName : String ) : Boolean;
procedure ClearFieldValues( ADataSet : TDataSet );
function  FieldValuesArray( Values : Array of const ) : TFieldValuesArray;
procedure SwapFieldValues( Field1, Field2 : TField );
procedure SetSignedValue( Field1, Field2 : TBCDField; Value : Decimal; Inverted : Boolean = False );
function  GetSignedValue( Field1, Field2 : TBCDField; Inverted : Boolean = False ) : Decimal;
procedure SetFieldValue( AField : TField; const AValue : Variant );
function  GetRecordFieldValues( Dataset : TDataset ) : TFieldValuesArray;
procedure SetRecordFieldValues( Dataset : TDataset; const Values : TFieldValuesArray );
procedure ClearRecordFieldValues( Dataset : TnxDataset );

procedure CreateCompIndex( DataDictionary : TnxDataDictionary; IndexName, IndexFields : String );
function FieldExists( Database : TnxDatabase; Table : TnxTable; TableName, FieldName : String; CheckField : TCheckFieldFunction = nil ) : Boolean; overload;
function FieldExists( DataDictionary : TnxDataDictionary; FieldName : String ) : Boolean; overload;
function RemoveField( DataDictionary : TnxDataDictionary; FieldName : String ) : Boolean;
function GetMinFieldValue( AField : TField ) : Variant;
function GetMaxFieldValue( AField : TField ) : Variant;

procedure GetDatabaseError( DataSet : TDataSet; AException : Exception; var ErrorInfo : TDatabaseErrorInfo; TableName  : String = '' );

procedure RequestDatabaseUpdate( CodigoEmpresa : String; ForceCompactation : Boolean = False );
procedure RequestDatabaseInitialize;

function GetSQLTimeout : Integer;
function GetRemoteCompressionType : SmallInt;

function  SQLFormat( FormatStr : String; Args : array of const ) : String;
function  SQLVarsFormat( FormatStr : String; Args : array of Variant ) : String;
function  SQLFieldsFormat( FormatStr : String; Args : array of TField ) : String;

procedure SQLAddCondition( var SQLWhereStr : String; ConditionStr : String; Args : array of Variant );

procedure SetSQLVar( var FormatStr : String; const VariableName : String; SQLString : String; Args : array of const ); overload;
procedure SetSQLVar( var FormatStr : String; const VariableName : String; SQLString : String ); overload;
procedure SetSQLVar( var FormatStr : String; const VariableName : String; Field : TField ); overload;
procedure SetSQLVar( var FormatStr : String; Field : TField ); overload;
procedure SetSQLVars( var FormatStr : String; ParamValues : TDictionary< String, Variant > ); overload;
procedure SetSQLVars( var FormatStr : String; Fields  : array of TField ); overload;
procedure SetSQLVars( var FormatStr : String; Dataset : TgxMemData ); overload;

function SQLFieldValue( Field : TField ) : String;
function SQLVarValue( Value : Variant ) : String;

procedure ShowDatabaseError( DataSet : TDataSet; AException : Exception; TableName : String = '' );
procedure CheckStatus( AErrorCode : TnxResult; NotifyError : Boolean = True );

procedure RaiseRecordNotFoundException;
procedure RaiseNoCurrentRecordException;
procedure RaiseNoCurrentTransContextException;
function ShiftRecordUp( Table : TnxeTable; ToFirstRow : Boolean = False ) : Boolean;
function ShiftRecordDown( Table : TnxeTable; ToLastRow : Boolean = False ) : Boolean;

function UpdateDatabaseAlias( Session : TnxSession; Name, Path : String ) : Boolean;

const     DBIERR_CANTEDIT   = ( ERRBASE_SEC + 20 );
          DBIERR_CANTINSERT = ( ERRBASE_SEC + 21 );
          DBIERR_CANTPOST   = ( ERRBASE_SEC + 22 );
          DBIERR_CANTDELETE = ( ERRBASE_SEC + 23 );

          CM_UPDATEDATABASE = CM_BASE + 100;
          CM_INITIALIZEDATABASE = CM_BASE + 101;

var       DictionaryList    : TList<TnxeDatabaseDictionary> = nil;

          SQLTimeOut : SmallInt = 0;                    // 0 = Normal, 1 = Alto y 2 = Muy alto
          RemoteDataCompression : SmallInt = 0;         // 0 = Sin compresión, 1..3 = ZIP Bajo-Medio-Alto y 4 = Algoritmo RLE

          DefaultTimeout : Integer = 6000;
          LockEditTimeOut : Integer = 3000;             // Si hay una transacción en marcha se le puede dar un pequeño margen de tiempo sin que esto moleste demasiado al usuario (creo)
          LockWaitTimeout : Integer = 30000;

          HighSQLTimeout : Integer = 9000000;           // 15 minutos
          MediumSQLTimeout : Integer = 360000;          // 6 minutos
          LowSQLTimeout : Integer = 180000;             // 3 minutos

          UpdatingDictionaries : Boolean  = False;
          VerifyingTables : Boolean  = False;
          RecoveringTables : Boolean  = False;

          OnDatabaseError   : TDatabaseErrorProcedure = nil;

const     MaxSmallint       : SmallInt = High( SmallInt );
          MaxLongint        : Longint  = High( Longint );

          // Estos valores, aunque si que son los maximos y minimos del tipo Currency, los utilizo para todos los valores reales

          MinCurrency       : Currency = -922337203685477.5808;
          MaxCurrency       : Currency = 922337203685477.5807;

          MaxAnsiChar       : AnsiChar = 'Z'; //.. #255;
          MaxDoubleError    : Double   = 0.0000001;

          // Tamaño por defecto del bloque de lectura en las consultas

          DBIERR_TABLESTRUCTCHANGED   = ( ERRBASE_VERSION + 100 );
          DBIERR_TABLEVERSIONMISMATCH = ( ERRBASE_VERSION + 101 );
          DBIERR_TABLEVERSIONOBSOLETE = ( ERRBASE_VERSION + 102 );

resourceString
          RsRegistroInexistente = '< Registro inexistente >';

const     RsDescripcion = 'Descripcion';
          RsNombre = 'Nombre';

var       LastErrorCode : TnxResult   = DBIERR_NONE;
          LastErrorDataset : TDataset = nil;
          LastErrorTableName : String = '';

          ErrorCounter : Integer = 0;
          ShowErrorDialog : Boolean = True;

implementation

uses   Windows,
       Forms,
       MaskUtils,

       DBConsts,

       nxdbStrings,
       nxllBdeStrings,
       nxllUtils,
       nxllFastMove,
       nxllMemoryManager,
       nxsdDataDictionaryRefInt,

       AnsiStrings;

resourceString

      RsMsg1  = 'Nombre de campo incorrecto (%s).';
      RsMsg2  = 'Tipo de campo calculado no definido.';
      RsMsg3  = 'Tipo de Dataset incorrecto.';
      RsMsg4  = 'No le esté permitido realizar inserciones (altas).';
      RsMsg5  = 'El valor máximo permitido para este campo es %d.';
      RsMsg6  = 'La versión de la tabla no coincide con la de la aplicación.';
      RsMsg7  = 'La base de datos necesita ser actualizada pero esta aplicación no puede realizar el proceso.';
      RsMsg8  = 'Utilice una versión completa de Gestwin para actualizar la base de datos.';
      RsMsg9  = 'Error del gestor de base de datos. ';
      RsMsg10 = 'Mensaje de error : ';
      RsMsg11 = 'La notificación tiene su origen en [B]%s[/B].';
      RsMsg12  = 'Tipo de campo incorrecto (%s, %s).';
      RsRecordNotFoundMessage = 'No se puede editar el registro porque no se ha encontrado.';
      RsNoCurrentRecordMessage = 'El registro que se pretende modificar no es el mismo que se leyó originalmente.';
      RsNoCurrentTransContextMessage = 'La transacción indicada no existe.';
      RsDisorderedTransactionSecuence  = 'La secuencia de transacciones no está ordenada';

// Funciones

function NexusToBDEFieldType( DataType : TnxFieldType ) : TFieldType;
begin

     case DataType of
       nxtBoolean      : Result := ftBoolean;
       nxtWideChar     : Result := ftBoolean;
       nxtChar,
       nxtByte,
       nxtInt8,
       nxtInt16        : Result := ftSmallint;
       nxtWord16       : Result := ftWord;
       nxtInt32,
       nxtWord32       : Result := ftInteger;
       nxtInt64        : Result := ftLargeInt;
       nxtAutoInc      : Result := ftAutoInc;
       nxtSingle,
       nxtDouble,
       nxtExtended     : Result := ftFloat;
       nxtCurrency     : Result := ftCurrency;
       nxtBCD          : Result := ftBCD;
       nxtDate         : Result := ftDate;
       nxtTime         : Result := ftTime;
       nxtDateTime     : Result := ftDateTime;
       nxtBlob         : Result := ftBlob;
       nxtBlobMemo     : Result := ftMemo;
       nxtBlobGraphic  : Result := ftGraphic;
       nxtByteArray    : Result := ftVarBytes;
       nxtNullString,
       nxtShortString  : Result := ftString;
       nxtWideString   : Result := ftWideString;
       nxtBlobWideMemo : Result := ftWideMemo;
       else              Result := ftUnknown;
       end;
end;

function GetDataTypeString( DataType : TFieldType ) : String;
begin
     case DataType of
       ftString,
       ftWideString : Result := 'String';
       ftSmallint   : Result := 'SmallInt';
       ftInteger    : Result := 'Integer';
       ftWord       : Result := 'Word';
       ftBoolean    : Result := 'Boolean';
       ftFloat      : Result := 'Float';
       ftCurrency   : Result := 'Currency';
       ftBCD        : Result := 'BCD';
       ftDate       : Result := 'Date';
       ftTime       : Result := 'Time';
       ftDateTime   : Result := 'DateTime';
       ftAutoInc    : Result := 'AutoInc';
       ftBlob       : Result := 'Blob';
       ftMemo       : Result := 'Memo';
       ftGraphic    : Result := 'Graphic';
       ftFmtMemo    : Result := 'FmtMemo';
       ftLargeint   : Result := 'LargeInt';
       ftVariant    : Result := 'Variant';
       ftGuid       : Result := 'Guid';
       ftTimeStamp  : Result := 'TimeStamp';
       ftWideMemo   : Result := 'WideMemo';
       else           Result := '<Desconocido>';
       end;
end;

function FieldWidth( Field : TField ) : SmallInt;
begin
     case Field.DataType of
        ftSmallInt   : Result :=  5;
        ftInteger    : Result := 10;
        ftFloat,
        ftCurrency,
        ftBCD        : Result := 12;
        ftBoolean    : Result := 2;
        ftString,
        ftWideString : Result := TStringField( Field ).Size;
        ftWideMemo   : Result := MaxSmallint; // Simplemente un valor, puesto que el tamaño del Memo no está fijado de antemano
        else           Result := 10;          // Un valor por defecto
        end;
end;

function GetMaxValue( DataType : TFieldType ) : Variant;
begin
     case DataType of
       ftSmallint   : Result := High( SmallInt );
       ftDate       : Result := DMYToDateStamp( 31, 12, 9000 );
       ftTime       : Result := HMSToTimeStamp( 24, 59, 59 );
       ftInteger    : Result := High( Integer );
       ftWord       : Result := High( Word );
       ftLargeint   : Result := High( LargeInt );
       ftLongWord   : Result := High( LongWord );
       ftBoolean    : Result := True;
       ftDateTime   : Result := EncodeDate( 9000, 12, 31 );
       ftFloat,
       ftCurrency,
       ftBCD        : Result := MaxCurrency;
       else           Result := HighStrCode;
       end;
end;

(*

function IsRangeAssigned( MinValue, MaxValue : Variant ) : Boolean;
begin
     Result := not( ( MinValue=0 ) and ( MaxValue=0 ) );
end;

function GetMaxFieldValue( AField : TField ) : Variant;

function GetMaxValueIfRangeAssigned( MinValue, MaxValue : Variant ) : Variant;
begin
     If   IsRangeAssigned( MinValue, MaxValue )
     then Result := MaxValue
     else Result := 0;
end;

begin
     Result := Null;
     If   Assigned( AField )
     then begin

          {
            Compruebo en cada caso si se ha fijado el rango en el TField.
            Por desgracia los campos MinValue y MaxValue están definidos en cada tipo de campo y no
            existe una función de nivel superior es TField que permita obtenerlos (que yo sepa)
          }

          If   AField is TSmallIntField
          then With TSmallIntField( AField ) do
                 Result := GetMaxValueIfRangeAssigned( MinValue, MaxValue )
          else If   AField is TIntegerField
               then With TIntegerField( AField ) do
                      Result := GetMaxValueIfRangeAssigned( MinValue, MaxValue )
               else If   AField is TLargeintField
                    then With TLongWordField( AField ) do
                           Result := GetMaxValueIfRangeAssigned( MinValue, MaxValue )
                    else If   AField is TLongWordField
                         then With TLongWordField( AField ) do
                                Result := GetMaxValueIfRangeAssigned( MinValue, MaxValue )
                         else If   ( AField is TCurrencyField ) or
                                   ( AField is TFloatField )
                              then With TFloatField( AField ) do
                                     Result := GetMaxValueIfRangeAssigned( MinValue, MaxValue );


          If   VarIsNull( Result )
          then Result := GetMaxValue( AField.DataType );

          end;
end;
*)

function IsRangeAssigned( MinValue, MaxValue : Extended ) : Boolean;
begin
     Result := not( ( MinValue=0 ) and ( MaxValue=0 ) );
end;

function GetMaxFieldValue( AField : TField ) : Variant;
begin
     Result := Null;
     If   Assigned( AField )
     then begin

          // Compruebo en cada caso si se ha fijado el rango en el Field

          If   AField is TSmallIntField
          then begin
               With TSmallIntField( AField ) do
                 If   IsRangeAssigned( MinValue, MaxValue )
                 then Result := MaxValue
                 else Result := GetMaxValue( ftSmallInt);
               end
          else If   AField is TIntegerField
               then begin
                    With TIntegerField( AField ) do
                      If   IsRangeAssigned( MinValue, MaxValue )
                      then Result := MaxValue
                      else Result := GetMaxValue( ftInteger );
                    end
               else If   AField is TLongWordField
                    then begin
                         With TLongWordField( AField ) do
                           If   IsRangeAssigned( MinValue, MaxValue )
                           then Result := MaxValue
                           else Result := GetMaxValue( ftLongWord );
                         end
                    else If   AField is TFloatField     // No creo que haya fijado rangos de valores Float, pero bueno
                         then begin
                              With TFloatField( AField ) do
                                If   IsRangeAssigned( MinValue, MaxValue )
                                then Result := MaxValue
                                else Result := GetMaxValue( ftFloat );
                              end
                         else Result := GetMaxValue( AField.DataType );
          end;
end;

procedure SetMaxFieldValue( AField : TField );
begin
     With AField do
       Value := GetMaxFieldValue( AField );
end;

function GetMinValue( DataType : TFieldType ) : Variant;
begin

     //  Es posible que Null sea una buena opción como valor mínimo para cualquier tipo de dato ...
     //* (Revisar)

     case DataType of
       ftSmallint   : Result := 0;
       ftDate       : Result := DMYToDateStamp( 1, 1, 1 );
       ftTime       : Result := HMSToTimeStamp( 0, 0, 0 );
       ftInteger    : Result := 0;
       ftWord       : Result := 0;
       ftBoolean    : Result := False;
       ftDateTime   : Result := EncodeDate( 1, 1, 1 );
       ftFloat,
       ftCurrency,
       ftBCD        : Result := MinCurrency;
       else           Result := Null;  // antes ''
       end;
end;

function GetMinFieldValue( AField : TField ) : Variant;
begin
     Result := Null;
     If   Assigned( AField )
     then begin
          If   AField is TSmallIntField
          then begin
               With TSmallIntField( AField ) do
                 If   IsRangeAssigned( MinValue, MaxValue )
                 then Result := MinValue
                 else Result := GetMinValue( ftSmallInt );
               end
          else If   AField is TIntegerField
               then begin
                    With TIntegerField( AField ) do
                      If   IsRangeAssigned( MinValue, MaxValue )
                      then Result := MinValue
                      else Result := GetMinValue( ftInteger );
                    end
               else If   AField is TFloatField
                    then begin
                         With TFloatField( AField ) do
                           If   IsRangeAssigned( MinValue, MaxValue )
                           then Result := MinValue
                           else Result := GetMinValue( ftFloat );
                         end
                    else Result := GetMinValue( AField.DataType );
          end;
end;

procedure SetMinFieldValue( AField : TField );
begin
     With AField do
       Value := GetMinFieldValue( AField );
end;

function CompareFieldValues( Values1,
                             Values2 : TFieldValuesArray ) : ShortInt;

var  Inx  : SmallInt;

begin
     If   High( Values1 )=High( Values2 )
     then begin
          Result := 0;
          For Inx := 0 to High( Values1 ) do
            If   Values1[ Inx ]>Values2[ Inx ]
            then begin
                 Result := 1;
                 Exit;
                 end
            else If   Values1[ Inx ]<Values2[ Inx ]
                 then begin
                      Result := -1;
                      Exit;
                      end;
          end
     else Result := 2;  // No comparables
end;

function IndexSegments( DataDictionary : TnxDataDictionary;
                        IndexNumber    : ShortInt ) : ShortInt;

var  InxDesc : TnxIndexDescriptor;
     KeyDesc : TnxCompKeyDescriptor;

begin
     Result := -1;
     If   ( IndexNumber>0 ) and ( IndexNumber<DataDictionary.IndicesDescriptor.IndexCount )
     then begin
          InxDesc := TnxIndexDescriptor( DataDictionary.IndicesDescriptor.IndexDescriptor[ IndexNumber ] );
          If   Assigned( InxDesc )
          then begin
               KeyDesc := TnxCompKeyDescriptor( InxDesc.KeyDescriptor );
               Result := KeyDesc.KeyFieldCount;
               end;
          end;
end;

function SQLFieldValue( Field : TField ) : String;
begin
     case Field.DataType of
       ftString,
       ftWideString,
       ftMemo         : Result := QuotedStr( Field.AsString );
       ftDate         : Result := SQLDateString( TDateField( Field ).Value );
       ftBoolean      : Result := StrFormatBool( TBooleanField( Field ).Value, bfTrueFalse );
       ftTime         : Result := SQLTimeString( TTimeField( Field ).Value );
       ftGuid         : Result := SQLGuid( TGuidField( Field ).AsGuid );
       else             Result := Field.AsString;
       end;
end;

function SQLVarValue( Value : Variant ) : String;
begin
     case VarType( Value ) of
       varString,
       varUString     : Result := QuotedStr( Value );
       varDate        : Result := SQLDateString( Value );
       varBoolean     : Result := StrFormatBool( Value, bfTrueFalse );
       // varTime        : Result := SQLTimeString( Value );
       // varGuid        : Result := SQLGuid( Value );
       else             Result := Value;
       end;
end;

// Esta función espera que la ubicación de los parámetros se determinen utilizando ? y no %. Esto es así
// porque el tipo de dato no es relevante, ya que es determinado por la misma función.

function SQLFieldsFormat( FormatStr : String;
                          Args      : array of TField ) : String;

var  I : SmallInt;
     StrValue : String;

begin
     For I := 0 to High( Args ) do
       begin
       StrValue := SQLFieldValue( Args[ I ] );
       FormatStr := StringReplace( FormatStr, '?', StrValue, [ rfIgnoreCase ] );
       end;
     Result := ' ' + FormatStr + ' ';  // Evitando que queden pegados
end;

function SQLVarsFormat( FormatStr : String;
                        Args      : array of Variant ) : String;

var  I : SmallInt;
     StrValue : String;

begin
     For I := 0 to High( Args ) do
       begin
       StrValue := SQLVarValue( Args[ I ] );
       FormatStr := StringReplace( FormatStr, '?', StrValue, [ rfIgnoreCase ] );
       end;
     Result := ' ' + FormatStr + ' ';
end;

procedure SQLAddCondition( var SQLWhereStr  : String;
                               ConditionStr : String;
                               Args         : array of Variant );
begin
     If   SQLWhereStr<>''
     then StrAdd( SQLWhereStr, ' AND ' );
     StrAdd( SQLWhereStr, SQLVarsFormat( ConditionStr, Args ) );
end;


// Obsoleto

function SQLFormat( FormatStr : String;
                    Args      : array of const ) : String;

var  Index : SmallInt;
     StrArgs : array of ShortString;  // No adaptar a String o UnicodeString

begin
     If   High( Args )=-1
     then Result := FormatStr
     else begin
          SetLength( StrArgs, High( Args ) + 1 );
          For Index := 0 to High( Args ) do
            If   Args[ Index ].vType=vtObject
            then begin
                 Args[ Index ].vType := vtString;
                 If   Args[ Index ].VObject is TField
                 then StrArgs[ Index ] := ShortString( SQLFieldValue( TField( Args[ Index ].vObject ) ) );
                 Args[ Index ].VString := @StrArgs[ Index ];
                 end;
          Result := Format( FormatStr, Args );
          end;
end;

// Esta primera función es mixta. Utiliza para la construcción de SQLString parametros del tipo ?, para finalmente asignar el valor
// resultante a una variable del tipo <Nombre>

procedure SetSQLVar( var   FormatStr    : String;
                     const VariableName : String;
                           SQLString    : String;
                           Args         : array of const );
begin
     If   High( Args )>=0
     then SQLString := SQLFormat( SQLString, Args );
     SetSQLVar( FormatStr, VariableName, SQLString );
end;

procedure SetSQLVar( var   FormatStr    : String;
                     const VariableName : String;
                           Field        : TField );
begin
     SetSQLVar( FormatStr, VariableName, SQLFieldValue( Field ) );
end;

procedure SetSQLVar( var   FormatStr    : String;
                           Field        : TField );
begin
     SetSQLVar( FormatStr, Field.FieldName, SQLFieldValue( Field ) );
end;

procedure SetSQLVar( var   FormatStr    : String;
                     const VariableName : String;
                           SQLString    : String );
begin
     FormatStr := StringReplace( FormatStr, '<' + VariableName + '>', SQLString, [ rfReplaceAll, rfIgnoreCase ] );
end;

procedure SetSQLVars( var   FormatStr   : String;
                            ParamValues : TDictionary< String, Variant > );

var Pair : TPair< String, Variant>;

begin
     For Pair in ParamValues do
       SetSQLVar( FormatStr, Pair.Key, SQLVarValue( Pair.Value ) );
end;

procedure SetSQLVars( var   FormatStr   : String;
                            Fields      : array of TField );

var Field : TField;

begin
     For Field in Fields do
       SetSQLVar( FormatStr, Field );
end;

procedure SetSQLVars( var   FormatStr   : String;
                            Dataset     : TgxMemData );

var Field : TField;

begin
     For Field in Dataset.Fields do
       SetSQLVar( FormatStr, Field );
end;

procedure RemoveSQLString( var   FormatStr : String;
                           const Str       : String );
begin
     FormatStr := StringReplace( FormatStr, Str, ' ', [ rfReplaceAll, rfIgnoreCase ] );
end;

procedure RaiseRecordNotFoundException;
begin
     raise EnxDatabaseError.nxCreate( DBIERR_RECNOTFOUND, RsRecordNotFoundMessage );
end;

procedure RaiseNoCurrentRecordException;
begin
     raise EnxDatabaseError.nxCreate( DBIERR_NOCURRREC, RsNoCurrentRecordMessage );
end;

procedure RaiseNoCurrentTransContextException;
begin
     raise EnxDatabaseError.nxCreate( DBIERR_NX_CORRUPTTRANS, RsNoCurrentTransContextMessage );
end;

// Funciones locales

function GetCustomFieldClass(FieldType: TFieldType): TFieldClass;
begin
     case FieldType of
       ftString     : Result := TStringField;
       ftWideString : Result := TWideStringField;
       ftSmallint   : Result := TSmallintField;
       ftInteger    : Result := TIntegerField;
       ftWord       : Result := TWordField;
       ftBoolean    : Result := TBooleanField;
       ftFloat      : Result := TFloatField;
       ftCurrency   : Result := TCurrencyField;
       ftDate       : Result := TDateField;
       ftTime       : Result := TTimeField;
       ftDateTime   : Result := TDateTimeField;
       else           Result := nil;
       end;
end;

function IsBaseTableName( TableName : String ) : Boolean;
begin
     Result := ( Pos( '$', TableName )=0 ) and ( Pos( '_', TableName )=0 );
end;

procedure ClearFieldValues( ADataSet : TDataSet );

var  Inx  : SmallInt;

begin
     With ADataSet do
       For Inx := 0 to Pred( FieldCount ) do
         Fields[ Inx ].Clear;
end;

function  FieldValuesArray( Values : Array of const ) : TFieldValuesArray;

var  Inx : SmallInt;

begin
     SetLength( Result, High( Values ) + 1 );
     For Inx := 0 to High( Values ) do
       Result[ Inx ] := VarRecToVariant( Values[ Inx ] );
end;

procedure SwapFieldValues( Field1, Field2 : TField );

var  Value : Variant;

begin
     Value := Field1.Value;
     Field1.Value := Field2.Value;
     Field2.Value := Value;
end;

function GetRecordFieldValues( Dataset : TDataset ) : TFieldValuesArray;

var  Inx  : SmallInt;

begin
     With Dataset do
       begin
       SetLength( Result, FieldCount );
       For Inx := 0 to Pred( FieldCount ) do
         Result[ Inx ] := Fields[ Inx ].Value;
       end;
end;

procedure SetRecordFieldValues(       Dataset : TDataset;
                                const Values  : TFieldValuesArray );

var  Inx  : SmallInt;

begin
     With Dataset do
       begin
       If   not ( State in [ dsEdit, dsInsert ] )
       then Edit;
       For Inx := 0 to High( Values ) do
         Fields[ Inx ].Value := Values[ Inx ];
       end;
end;

procedure ClearRecordFieldValues( Dataset : TnxDataset );

var  Inx  : SmallInt;

begin
     With Dataset do
       For Inx := 0 to Pred( FieldCount ) do
         Fields[ Inx ].Clear;
end;

// Esta función fija el valor del campo solo si éste es diferente. Solo sirve para evitar que se marque como modificado.

procedure SetFieldValue( AField : TField; const AValue : Variant );
begin
     If   AField.Value<>AValue
     then AField.Value := AValue;
end;

procedure SetSignedValue( Field1,
                          Field2   : TBCDField;
                          Value    : Decimal;
                          Inverted : Boolean );

var  Positive : Boolean;

begin
     Positive := ( Value>0.0 ) xor Inverted;
     Value := Abs( Value );
     If   Positive
     then begin
          Field1.Value := Value;
          Field2.Value := 0.0;
          end
     else begin
          Field1.Value := 0.0;
          Field2.Value := Value;
          end;
end;

function GetSignedValue( Field1,
                         Field2   : TBCDField;
                         Inverted : Boolean ) : Decimal;
begin
     If   Inverted
     then Result := Field2.Value - Field1.Value
     else Result := Field1.Value - Field2.Value;
end;

function  GetTableDictionary( TableName : String ) : TnxeDatabaseDictionary;

var  Inx : SmallInt;

begin
     Result := nil;
     If   ( TableName<>'' ) and IsBaseTableName( TableName )
     then With DictionaryList do
            For Inx := 0 to Count - 1 do
              With Items[ Inx ] do
                begin
                Open;
                If   FTableList.IndexOf( TableName )>=0 // TableExists( TableName, '' ) // El segundo parámetro es 'password'
                then begin
                     Result := Items[ Inx ];
                     Break;
                     end;
                end;
end;

function GetTemporalTableName( Database  : TnxDatabase;
                               TableName : String ) : String;

var  TemporalTableName : String;
     Pn : SmallInt;

begin
     Pn := Pos( '_', TableName );
     If   Pn<>0
     then TableName := Copy( TableName, 1, Pn - 1 );
     repeat
       TemporalTableName := TableName + '_' + IntToStr( Random( 999999 ) );
     until not Database.TableExists( TemporalTableName, '' );
     Result := TemporalTableName;
end;

procedure CreateCompIndex( DataDictionary : TnxDataDictionary;
                           IndexName,
                           IndexFields    : String );

var  IndexDescriptor : TnxIndexDescriptor;
     FieldList : TStringList;
     Inx : SmallInt;

begin
     FieldList := TStringList.Create;
     try
       ExtractStrings( [ ';' ], [], PChar( IndexFields ), FieldList );
       // ExtractStringList( IndexFields, FieldList, True, ';' );
       With DataDictionary do
         begin
         IndexDescriptor := IndicesDescriptor.AddIndex( IndexName, 0, False, '', TnxCompKeyDescriptor );
         With FieldList do
           For Inx := 0 to count - 1 do
             TnxCompKeyDescriptor( IndexDescriptor.KeyDescriptor ).Add( GetFieldFromName( Strings[ Inx ] ) );
         end;
     finally
       FieldList.Free;
       end;
end;

function FieldExists( Database : TnxDatabase; Table : TnxTable; TableName, FieldName : String; CheckField : TCheckFieldFunction = nil ) : Boolean;
begin
     Result := False;
     Table.Close;
     Table.Database := Database;
     Table.TableName := TableName;
     Table.IndexName := csSeqAccessIndexName;
     try
       Table.Open;
       var Field := Table.FindField( FieldName );
       If   Assigned( Field )
       then If   Assigned( CheckField )
            then Result := CheckField( Field )
            else Result := True;
     finally
       Table.Close;
       end;
end;

function FieldExists( DataDictionary : TnxDataDictionary;
                      FieldName      : String ) : Boolean;
begin
     Result := DataDictionary.FieldsDescriptor.GetFieldFromName( FieldName )<>-1;
end;

function RemoveField( DataDictionary : TnxDataDictionary;
                      FieldName      : String ) : Boolean;

var  FieldIndex : SmallInt;

begin
     Result := False;
     FieldIndex := DataDictionary.FieldsDescriptor.GetFieldFromName( FieldName );
     If   FieldIndex<>-1
     then begin
          DataDictionary.FieldsDescriptor.RemoveField( FieldIndex );
          Result := true;
          end;
end;

procedure RequestDatabaseUpdate( CodigoEmpresa     : String;
                                 ForceCompactation : Boolean = False );
begin
     If   not DatabaseUpdateRequested
     then begin
          DatabaseUpdateRequested := True;
          If   Assigned( Application ) and
               Assigned( Application.MainForm )
          then begin
               CodigoEmpresaActual := CodigoEmpresa;
               If   not ServerApplication
			   then PostMessage( Application.MainForm.Handle, CM_UPDATEDATABASE, Integer( ForceCompactation ), 0 );
               end
          else begin
               ShowNotification( ntExceptionError, RsMsg7, RsMsg8 );
               Abort;
               end;
          end
end;

procedure RequestDatabaseInitialize;
begin
     If   not ServerApplication
	 then If   Assigned( Application )
          then PostMessage( Application.MainForm.Handle, CM_INITIALIZEDATABASE, 0, 0 );
end;

function GetSQLTimeout : Integer;
begin
     If   SQLTimeOut=1
     then Result := MediumSQLTimeout      // 6 minutos
     else If   SQLTimeOut=2
          then Result := HighSQLTimeout   // 15 minutos
          else Result := LowSQLTimeout;   // 3 minutos
end;

function GetRemoteCompressionType : SmallInt;
begin
     case RemoteDataCompression of
        1 : Result := 1;  // ZIP (1-8)
        2 : Result := 4;
        3 : Result := 9;
        4 : Result := 10;  // RLE
       else Result := 0;   // Sin compresión
     end;
end;

procedure DoOpenDetailDatasets( RootDataset         : TnxDataset;
                                OnOpenDetailDataset : TDataSetNotifyEvent = nil );

var DataSetList : TList<TDataset>;
    Dataset : TDataset;
    IDataset : InxeDataset;

begin
    With RootDataset do
      begin
      DataSetList := TList<TDataset>.Create;
      try
        
        GetDetailDataSets( DataSetList );
        For Dataset in DataSetList do
          begin
          Dataset.GetInterface( InxeDataset, IDataset );
          If   Assigned( IDataset )
          then If   IDataset.GetOpenOnMasterActivation
              then begin

                   If   Assigned( OnOpenDetailDataset )
                   then OnOpenDetailDataset( Dataset );
                   Dataset.Open;

                   If   Assigned( IDataset.OnApplyMasterRange )
                   then IDataset.OnApplyMasterRange( Dataset )
                   else begin
                        IDataset.ApplyMasterRange;
                        { ***** DEBUG
                        Dataset.First;
                        }
                        end;

                   IDataset.OpenDetailDataSets;
                   end;
          end;
      finally 
        DataSetList.Free;
        end;
      end;
end;

function ShiftRecordUp( Table : TnxeTable; ToFirstRow : Boolean = False ) : Boolean;

var  I, J : Integer;
     RecordFieldValues : TFieldValuesArray;

begin
     Result := False;
     With Table do
       If   Assigned( AutoIncField )
       then begin
             Database.StartTransactionWith( [ Table ] );
             try
               Cancel;
               Prior;  // Solo para comprobar que no es ya la primera línea del rango
               If   not Bof
               then begin

                    If   ToFirstRow
                    then Next;
                    RecordFieldValues := GetFieldValues;
                    I := FAutoIncField.Value;
                    Delete; // La linea en curso

                    If   ToFirstRow
                    then begin
                         If   I<FAutoIncField.Value
                         then I := FAutoIncField.Value;
                         While not Bof do
                           begin
                           Edit;
                           FAutoIncField.Value := I;
                           Post;
                           Dec( I );
                           Prior;
                           end;
                         J := MinAutoIncValue;
                         end
                    else begin
                         Edit;
                         FAutoIncField.Value := I;
                         Post;
                         J := I + 1;
                         end;

                    Append;
                    SetFieldValues( RecordFieldValues );
                    FAutoIncField.Value := J;
                    Post;

                    end;

               Database.Commit;
               Result := True;
             except
               Database.RollBack;
               end;

             end;
end;

function ShiftRecordDown( Table : TnxeTable; ToLastRow : Boolean = False ) : Boolean;

var  I, J : Integer;
     RecordFieldValues : TFieldValuesArray;
     Bm : TBookMark;

begin
     Result := False;
     With Table do
       If   Assigned( AutoIncField )
       then begin
            Database.StartTransactionWith( [ Table ] );
            try
              Cancel;
              If   not ToLastRow
              then Bm := GetBookMark;
              Next;
              If   not Eof
              then begin

                   If   ToLastRow
                   then Prior;
                   RecordFieldValues := GetFieldValues;
                   I := FAutoIncField.Value;
                   Delete;

                   If   ToLastRow
                   then begin
                        While not Eof do
                          begin
                          Edit;
                          FAutoIncField.Value := I;
                          Post;
                          Inc( I );
                          Next;
                          end;
                        J := I;
                        end
                   else begin
                        GotoBookMark( Bm );
                        Edit;
                        FAutoIncField.Value := I;
                        Post;
                        J := I - 1;
                        end;

                   Append;
                   SetFieldValues( RecordFieldValues );
                   FAutoIncField.Value := J;
                   Post;
                   end;

              Database.Commit;
              Result := True;
            except
              Database.RollBack;
              end;

            end;
end;

procedure GetDatabaseError(     DataSet    : TDataSet;
                                AException : Exception;
                            var ErrorInfo  : TDatabaseErrorInfo;
                                TableName  : String = '' );

var   ADatasetName : String;
      BaseException : InxBaseException;
      DatabaseException : InxException;

resourceString
      RsError1     = 'Servidor de base de datos inactivo.';
      RsError2     = 'El índice [B]%s[/B] no existe en la tabla [B]%s[/B]';
      RsError3     = 'Falta un valor de campo requerido.';
      RsError4     = 'Valor de clave incorrecto (posiblemente duplicado)';
      RsError5     = 'Error de posicionamiento.';
      RsError6     = 'Identificador de fichero no válido.';
      RsError7     = 'Registro bloqueado por otro usuario, ventana o proceso.';
      RsError8     = 'Puede reintentar el proceso más adelante cuando el registro haya sido liberado.';
      RsError9     = 'Directorio no válido.';
      RsError10    = 'El directorio de datos no existe o no tiene acceso permitido al mismo.';
      RsError11    = 'El fichero [B]%s[/B] ha sido bloqueado por otro usuario o proceso.';
      RsError12    = 'Reintente el proceso cuando nadie más lo esté utilizando.';
      RsError13    = 'Si está conectado a una red local compruebe si el servidor funciona correctamente.'#13'No olvide revisar también la configuración del servidor en la Ficha de la empresa.';
      RsError14    = 'El registro ha sido borrado o la clave modificada.';
      RsError15    = 'La tabla está abierta y no puede realizarse esta operación.';
      RsError16    = 'Esta tabla ya existe y no puedo sobreescribirla.';
      RsError17    = 'Ha intentando mezclar objetos de dos sesiones distintas. ¿?';
      RsError18    = 'La consulta no ha podido completarse en el tiempo estipulado.';
      RsError19    = 'Notifique esta circunstancia a su técnico de soporte para que revise los tiempos de respuesta de su equipo.';
      RsError20    = 'Un registro de datos (BLOB) asociado a este registro es defectuoso.';
      RsError21    = 'La tabla [B]%s[/B] no tiene la estructura esperada (no es la versión correcta).';
      RsError22    = 'No intente acceder de nuevo a la aplicación y notifique este extremo a su TÉCNICO DE SOPORTE.';
      RsError23    = 'La estructura del fichero no es la esperada.';
      RsError24    = 'Este error no debería ocurrir en circunstancias normales.'#13'Notique a su soporte técnico este extremo.';
      RsError25    = 'Se ha intendo utilizar un índice inexistente en la tabla [B]%s[/B]';
      RsError26    = 'Si está en un entorno de red, compruebe que el servidor de base de datos (SBD) está ejecutándose en la máquina servidor'#13'Si el SBD está ejecutándose, compruebe si acepta peticiones (está arrancado).';
      RsError27    = 'Un Blob (dato binario asociados al registro) está en mal estado.';
      RsError28    = 'Regenere el fichero de datos. Si ya ha sido regenerado y el error persiste, solicite soporte técnico.';
      RsError29    = 'No puedo acceder al fichero [B]%s[/B]. Acceso denegado.';
      RsError30    = 'El fichero [B]%s[/B] no puede ser bloqueado de forma exclusiva. Ha sido abierto por otro usuario o proceso.';

      RsError32    = 'Espere a que el fichero sea liberado y reintente el proceso.';
      RsError33    = 'Error durante la actualización del fichero.';
      RsError34    = 'El fichero no ha sido actualizado.'#13'Notique a su soporte técnico este extremo.';
      RsError35    = 'Versión incorrecta de la tabla.';
      RsError36    = 'Versión incorrecta del servidor de base de datos.';
      RsError37    = 'La reinstalación de GESTWIN puede solucionar el problema.';
      RsError38    = 'La tabla no existe en el directorio indicado. No puede ser abierta.';
      RsError39    = 'No se puede acceder al registro. Otro proceso lo ha bloqueado o impide su modificación.';
      RsError40    = 'Espere a que el registro sea accesible y/o averigue el motivo del bloqueo (otro usuario o proceso está impidiendo el acceso).';
      RsError41    = 'Se ha modificado la estructura de los indices de la tabla.';
      RsError42    = 'No puede suprimirse este registro.';
      RsError43    = 'Este registro es referenciado por uno o más registros de otras tablas de la base de datos.'#13'Para poder eliminarlo deben suprimirse antes todas las referencias que existan.';
      RsError44    = 'No existen una o más referencias del registro que intenta crear.';
      RsError45    = 'El registro hace referencia (al menos) a un registro que no existe.'#13'Compruebe que todos los registros maestros existan y que los ficheros estén en buen estado.';
      RsError46    = 'Se ha intentado abrir una tabla inexistente.';
      RsError47    = 'Esto no debería ocurrir en circunstancias normales.'#13'Se va ha proceder a verificar el estado de la base de datos.';

      RsError48    = 'Se ha perdido la conexión con el servidor de datos.';
      RsError49    = 'Éste es un error grave, y se procederá a abandonar la aplicación.'#13'Compruebe que el servidor esté funcionando y que no se han bloqueado los puertos de trabajo (por defecto 16000 ó 17000).';

begin

     // InxException, InxBaseException

     ErrorInfo.StError := '';
     ErrorInfo.StDesc := '';

     If   Assigned( AException )
     then begin
          If   Supports( AException, InxBaseException, BaseException )
          then ErrorInfo.ErrorCode := BaseException.ErrorCode
          else Exit;
          If   Supports( AException, InxException, DatabaseException )
          then ErrorInfo.StDesc := DatabaseException.ProcessedErrorString;
          If   Assigned( DataSet )
          then LastErrorDataset := Dataset;
          end
     else If   ErrorInfo.ErrorCode=ERRCAT_NONE   // 0
          then Exit;

     If   ( ( ErrorInfo.ErrorCode and $FF00 )<>ERRBASE_LOCKCONFLICT ) and ( ErrorInfo.ErrorCode=LastErrorCode )
     then Inc( ErrorCounter )
     else ErrorCounter := 0;

     LastErrorCode  := ErrorInfo.ErrorCode;
     LastErrorTableName := TableName;

     ErrorInfo.UpdateDatabase := False;
     ErrorInfo.VerifyDatabase := False;
     ErrorInfo.FatalError := False;

     try

       If   Assigned( Dataset )
       then ADatasetName := Dataset.Name
       else ADatasetName := TableName;

       With ErrorInfo do
         case ErrorCode of

           DBIERR_SERVERCOMMLOST   : begin
                                     StError := RsError48;
                                     StDesc := RsError49;
                                     FatalError := True;
                                     end;

           DBIERR_SERVERNOTFOUND   : begin
                                     StError := RsError1;
                                     StDesc := RsError26;
                                     FatalError := True;
                                     end;

           DBIERR_SERVERVERSION    : begin
                                     StError    := RsError36;
                                     StDesc     := RsError37;
                                     FatalError := True;
                                     end;

           DBIERR_FILENOACCESS     : begin
                                     StError := Format( RsError29, [ ADatasetName ] );
                                     StDesc := RsError26;
                                     end;

           DBIERR_REQDERR          : begin
                                     StError    := RsError3;
                                     FatalError := True;
                                     end;

           DBIERR_KEYVIOL          : StError    := RsError4;

           DBIERR_INVALIDBOOKMARK,
           DBIERR_NOCURRREC        : StError := RsError5;

           DBIERR_INVALIDHNDL      : begin
                                     StError := RsError6;
                                     StDesc  := RsError13;
                                     end;

           ERRCODE_INVALIDBLOBHANDLE : StError := RsError20;

           DBIERR_KEYORRECDELETED  : StError := RsError14;

           DBIERR_TABLEOPEN        : StError := RsError15;

           DBIERR_TABLEEXISTS      : StError := RsError16;

           DBIERR_LOCKED,
           DBIERR_DEADLOCK,
           DBIERR_RECLOCKFAILED,
           DBIERR_RECGROUPCONFLICT : begin
                                     StError := RsError7;
                                     StDesc  := RsError8;
                                     end;

           DBIERR_NX_GENERALTIMEOUT,
           DBIERR_LOCKTIMEOUT      : StError := RsError39;

           DBIERR_INVALIDDIR       : begin
                                     StError := RsError9;
                                     StDesc  := RsError10;
                                     end;

           DBIERR_NEEDEXCLACCESS   : begin
                                     StError := Format( RsError30, [ ADatasetName ] );
                                     StDesc  := RsError12;
                                     end;

           DBIERR_FILELOCKED       : begin
                                     StError := Format( RsError11, [ ADatasetName ] );
                                     StDesc  := RsError12;
                                     end;

           DBIERR_NOTSAMESESSION   : StError := RsError17;

           $120{,
           DBIERR_TIMEOUT}         : begin
                                     StError := RsError18;
                                     StDesc  := RsError19;
                                     FatalError := True;
                                     end;

           {
           DBIERR_RESOURCELOCKED   : begin
                                     StError := RsError21;
                                     StDesc  := RsError22;
                                     end;
           }

           DBIERR_INVALIDRECSTRUCT : begin
                                     StError := RsError23;
                                     StDesc := RsError24;
                                     FatalError := True;
                                     end;

           DBIERR_BLOBERR          : begin
                                     StError := RsError27;
                                     StDesc := RsError28;
                                     end;

           DBIERR_INVALIDXLATION   : begin
                                     StError := RsError33;
                                     StDesc := RsError34;
                                     FatalError := True;
                                     end;

           DBIERR_TABLELEVEL       : StError := RsError35;

           DBIERR_NOSUCHTABLE      : StError := RsError38;

           DBIERR_NOSUCHINDEX,
           DBIERR_NOASSOCINDEX     : begin
                                     StError := RsError41;
                                     UpdateDatabase := True;
                                     end;
           DBIERR_DETAILRECORDSEXIST
                                   : begin
                                     StError := RsError42;
                                     StDesc := RsError43;
                                     end;

           DBIERR_FORIEGNKEYERR    : begin
                                     StError := RsError44;
                                     StDesc := RsError45;
                                     end;

           DBIERR_TABLEVERSIONMISMATCH
                                   : begin
                                     StError := Format( RsError21, [ ADatasetName ] );
                                     StDesc := RsError22;
                                     FatalError := True;
                                     end;

           DBIERR_INVALIDTABLENAME : begin
                                     StError := RsError46;
                                     StDesc := RsError47;
                                     VerifyDatabase := True;
                                     end;

           else                      begin
                                     If   StError=''
                                     then StError := RsMsg9;
                                     If   StDesc<>''
                                     then StDesc := StDesc + #13;
                                     StDesc := StDesc + RsMsg10 + { RemoveTags( } nxGetErrorString( ErrorCode ) {) };
                                     end;
           end;

       If   ADatasetName<>''
       then ErrorInfo.StSystem := Format( RsMsg11, [ ADatasetName ] )
       else ErrorInfo.StSystem := '';

     finally
       LastErrorCode := ErrorInfo.ErrorCode;
       end;

end;

procedure ShowDatabaseError( DataSet    : TDataSet;
                             AException : Exception;
                             TableName  : String = '' );

var  ErrorInfo : TDatabaseErrorInfo;
     Updatable : Boolean;
     CmpState : TComponentState;

begin

     If   not ShowErrorDialog or
          not Assigned( AException ) or
          ( ( AException is EnxBaseException ) and ( Pos( '[EAbort]', AException.Message )<>0 ) )   // Las excepciones generados en el servidor son siempre convertidas en EnxBaseException por NexusDB, incluso un simple Abort
     then Exit;

     With ErrorInfo do
       try

         GetDatabaseError( DataSet, AException, ErrorInfo, TableName );

         If   Assigned( Application.MainForm )
         then CmpState := Application.MainForm.ComponentState;

         If   ErrorInfo.StError<>''
         then ShowNotification( ntError, ErrorInfo.StError, ErrorInfo.StDesc, ErrorInfo.StSystem );

         If   not IsDesignTime and not( csLoading in CmpState )
         then LogMessage( StError );

       finally

         If   FatalError
         then begin
              If   not IsDesignTime
              then PrgExit( False, True );
              end
         else If   not ServerApplication
           then begin

               Updatable := True;
               If   Assigned( Dataset )
               then If   Dataset is TnxeTable
                    then If   TnxDataset( Dataset ).Database is TnxeDatabase
                         then Updatable := TnxeDatabase( TnxDataset( Dataset ).Database ).Updatable;

               If   Updatable
               then begin
                    If   UpdateDatabase
                    then begin
                         DatabaseUpdateRequested := True;
                         If   Assigned( Application )
                         then PostMessage( Application.MainForm.Handle, CM_UPDATEDATABASE, 0, 0 );
                         end
                    else If   VerifyDatabase
                         then begin
                              If   Assigned( Application )
                              then PostMessage( Application.MainForm.Handle, CM_INITIALIZEDATABASE, 0, 0 );
                              end;
                    end;
               end;
         end;

end;

procedure CheckStatus( AErrorCode  : TnxResult;
                       NotifyError : Boolean  = True );
begin
     If   ( AErrorCode<>DBIERR_NONE ) and
          ( AErrorCode<>DBIERR_RECNOTFOUND ) and
          ( AErrorCode<>DBIERR_EOF ) and
          ( AErrorCode<>DBIERR_BOF )
     then raise EnxDatabaseError.nxCreate( AErrorCode );
end;

function UpdateDatabaseAlias( Session : TnxSession;
                              Name,
                              Path    : String ) : Boolean;

var  AliasPath : String;

begin
     Result := False;
     With Session do
       try
         If   IsAlias( Name )  // Si ya existe
         then begin
              GetAliasPath( Name, AliasPath );
              If   AliasPath<>Path
              then ModifyAlias( Name, Name, Path );   // El nombre sigue siendo el mismo
              end
         else AddAlias( Name, Path );
         Result := True;
       except
         end;
end;

//  TnxeDatabaseDictionary ------------------------------------------------

constructor TnxeDatabaseDictionary.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     DictionaryList.Add( Self );
     FTableList := TStringList.Create;
     
     FSQLSet := TgxSQLSet.Create( Self );
     FSQLSet.Name := 'SQLSet';
end;

procedure TnxeDatabaseDictionary.CreateTable( TableName      : String;
                                              DefaultRecords : Boolean = False );

var  DataDictionary : TnxDataDictionary;
     Table : TnxTable;

begin
     If   Assigned( TargetDatabase )
     then begin
          DataDictionary := TnxDataDictionary.Create;
          try
            GetDataDictionary( TableName, '', DataDictionary );
            DataDictionary.AddLocaleDescriptor;
            TargetDatabase.CreateTable( True, TableName, '', DataDictionary );
            If   DefaultRecords
            then begin
                 Table := TnxTable.Create( Self );
                 try
                   Table.Database := TargetDatabase;
                   Table.TableName := TableName;
                   Table.Open;
                   CopyDefaultRecords( Table );
                 finally
                   Table.Free;
                   end;
                 end;
          finally
            DataDictionary.Free;
            end;
          end;
end;


procedure TnxeDatabaseDictionary.CopyDefaultRecords( TargetTable : TnxTable );

var  DictionaryTable : TnxTable;

begin
     DictionaryTable := TnxTable.Create( Self );
     try
       DictionaryTable.Database := Self;
       DictionaryTable.TableName := TargetTable.TableName;
       DictionaryTable.Open;
       DictionaryTable.IndexName := csSeqAccessIndexName;
       TargetTable.CopyRecords( DictionaryTable, True );
     finally
       DictionaryTable.Free;
       end;
end;

destructor TnxeDatabaseDictionary.Destroy;
begin
     FSQLSet.Free;
     DictionaryList.Remove( Self );
     FTableList.Free;
     inherited;
end;

procedure TnxeDatabaseDictionary.scStarted;
begin
     inherited;
     GetTableNames( FTableList );
end;

// Esta función devuelve una lista de las tablas del diccionario pero ordenadas atendiendo a sus relaciones de dependencia (integridad referencial)

procedure TnxeDatabaseDictionary.GetOrderedTableNames( AList : TStrings );

var  I, J, K : Integer;
     TableName : String;
     Dictionary : TnxDataDictionary;
     RefIntegrityDescriptor : TnxRefIntegrityDescriptor;
     Reorder : Boolean;

procedure ReorderElement( TargetTableName, SourceTableName : String );

var  TargetIndex,
     SourceIndex : Integer;

begin
     With AList do
       begin
       TargetIndex := IndexOf( TargetTableName );
       SourceIndex := IndexOf( SourceTableName );
       If   SourceIndex<TargetIndex
       then begin
            Insert( TargetIndex + 1, SourceTableName );
            Delete( SourceIndex );
            end;
       end;
end;

begin
     GetTableNames( AList );
     For I := 0 to AList.Count - 1 do
       begin
       TableName := AList.Strings[ I ];
       Dictionary := TnxDataDictionary.Create;
       try
         GetDataDictionary( TableName, '', Dictionary );
         If   Assigned( Dictionary )
         then begin
              RefIntegrityDescriptor := GetRefIntegrityDescriptor( Dictionary );
              If   Assigned( RefIntegrityDescriptor )
              then With RefIntegrityDescriptor do
                     For J := 0 to ridReferenceCount - 1 do
                       begin
                       Reorder := False;
                       With ridReferences[ J ] do
                         For K := Low( rdActions ) to High(rdActions) do
                           If   rdActions[ K ] is TnxTargetRequiredActionDescriptor
                           then begin
                                Reorder := True;
                                Break;
                                end;
                       If   Reorder
                       then ReorderElement( ridReferences[ J ].TargetCursor.ReferencedTableName, TableName );
                       end;
              end;
       finally
         Dictionary.Free;
         end;
       end;
end;

procedure TnxeDatabaseDictionary.Verify;
begin
     DoOnVerify;
end;

procedure TnxeDatabaseDictionary.BeforeUpdate;
begin
     DoBeforeUpdate;
end;

procedure TnxeDatabaseDictionary.AfterUpdate;
begin
     DoAfterUpdate;
     If   UpdatingDictionaries and not ServerApplication
     then Setup;
end;

procedure TnxeDatabaseDictionary.Setup;

procedure ExecSQLItem( ItemName : String );

var   SQLText : String;

begin
     SQLText := SQLSet.GetSQLText( ItemName );
     If   SQLText<>''
     then TargetDatabase.ExecQuery( SQLText, [] );
end;

begin
     If   Assigned( TargetDatabase )
     then begin
          ExecSQLItem( 'Procedures' );
          ExecSQLItem( 'Constraints' );
          ExecSQLItem( 'Triggers' );
          ExecSQLItem( 'Views' );
          end;
end;

procedure TnxeDatabaseDictionary.SetSQLItems( const Value : TgxSQLItems );
begin
      FSQLSet.SQLItems := Value;
end;

function TnxeDatabaseDictionary.GetSQLItems : TgxSQLItems;
begin
      Result := FSQLSet.SQLItems;
end;

procedure TnxeDatabaseDictionary.Notification( AComponent : TComponent;
                                               Operation  : TOperation);
begin
     inherited;
     If   Operation=opRemove
     then If   AComponent=FTargetDatabase
          then FTargetDatabase := nil;
end;

procedure TnxeDatabaseDictionary.DoAfterUpdate;
begin
     If   Assigned( FOnAfterUpdate )
     then FOnAfterUpdate;
end;

procedure TnxeDatabaseDictionary.DoBeforeUpdate;
begin
     If   Assigned( FOnBeforeUpdate )
     then FOnBeforeUpdate;
end;

procedure TnxeDatabaseDictionary.DoOnVerify;
begin
     If   Assigned( FOnVerify )
     then FOnVerify;
end;

//  TAttrFieldName -----------------------------------------------------

constructor TAttrFieldName.Create( AFieldName : String );
begin
     FFieldName := AFieldName;
end;

//  TAttrPeriodicalField -----------------------------------------------------

constructor TAttrPeriodicalField.Create( AFieldBaseName : String = ''; APeriodicalNames : String = '' );
begin
     FFieldBaseName := AFieldBaseName;
     FPeriodicalnames := APeriodicalNames;
end;

//  TnxeDataSetFields -----------------------------------------------------

constructor TnxeDataSetFields.Create( ADataSet   : TnxDataSet;
                                      StaticData : Boolean = False;
                                      Incomplete : Boolean = False;
                                      OnSetup    : TDataSetFieldsEvent = nil );
begin
     inherited Create( ADataSet );
     If   Assigned( ADataset )
     then Setup( ADataSet, StaticData, Incomplete, OnSetup );
end;

procedure TnxeDataSetFields.Setup( ADataSet   : TnxDataSet;
                                   StaticData : Boolean = False;
                                   Incomplete : Boolean = False;
                                   OnSetup    : TDataSetFieldsEvent = nil );
begin

     If   not FInitialized
     then begin

          FDataSet := ADataSet;
          FStaticData := StaticData;
          FCopyMemoFields := True;
          FCopyImageFields := False;

          If   ADataset is TnxeTable
          then FIncompleteDataset := Incomplete or ( TnxeTable( ADataset ).TableType in [ ttTemporal, ttVirtual, ttMemVirtual ] )
          else FIncompleteDataset := True;

          ADataset.GetInterface( InxeDataset, FIDataset );

          If   ADataset is TnxeQuery
          then FQuery := TnxeQuery( ADataset )
          else If   ADataset is TnxeTable
               then FTable := TnxeTable( ADataset );

          FRemoteCursorID := GetRemoteCursorID;

          If   FStaticData
          then begin
               FMemDataSet := TgxMemData.Create( Self );
               With FMemDataSet do
                 begin

                 FieldDefs.Assign( FDataSet.FieldDefs );

                 For var FieldDef in FieldDefs do
                   If   TFieldDef( FieldDef ).DataType=ftAutoInc
                   then TFieldDef( FieldDef ).DataType := ftLongWord;

                 FieldOptions.AutoCreateMode := acCombineAlways;
                 CreateFields;

                 Open;
                 end;
               end;

          If   Assigned( OnSetup )
          then OnSetup( Self );

          SetupFields;

          If   Assigned( FCalcMemDataset )
          then With FCalcMemDataset do
                 begin
                 Open;
                 Append;
                 end;

          end;

     FInitialized := True;
end;

procedure TnxeDataSetFields.SetupFields;

var  RttiContext : TRttiContext;
     RttiType : TRttiType;
     RttiArrayType : TRttiArrayType;
     ClassFieldType : TRttiType;
     ClassField : TRttiField;
     FieldClass : TClass;
     Index,
     ArrayIndex : SmallInt;
     ArrayValue : TValue;
     ElementField : TField;
     DimType: TRttiOrdinalType;
     ElementFieldName : String;

     // Variables assignadas a atributos del campo

     AttrFieldName,
     AttrFieldBaseName,
     AttrPeriodicalNames : String;
     AttrIsPeriodical,
     AttrIsCalculated : Boolean;

     PeriodicalList : TStringList;

function GetFieldValue( FieldClass : TClass;
                        FieldName  : String ) : TField;
begin

     Result := nil;

     If   AttrIsCalculated
     then Result := CreateCalculatedField( AttrFieldBaseName, FieldClass )
     else begin
          If   FieldClass=TWideStringField then
           Result := WideStringField(FieldName)
          else If FieldClass = TIntegerField then
           Result := IntegerField(FieldName)
          else If FieldClass = TSmallintField then
           Result := SmallIntField(FieldName)
          else If FieldClass = TBCDField then
           Result := BCDField(FieldName)
          else If FieldClass = TDateField then
           Result := DateField(FieldName)
          else If FieldClass = TBooleanField then
           Result := BooleanField(FieldName)
          else If FieldClass = TLongWordField then
           Result := LongWordField(FieldName)
          else If FieldClass = TFloatField then
           Result := FloatField(FieldName)
          else If FieldClass = TWordField then
           Result := WordField(FieldName)
          else If FieldClass = TLargeIntField then
           Result := LargeIntField(FieldName)
          else If FieldClass = TTimeField then
           Result := TimeField(FieldName)
          else If FieldClass = TDateTimeField then
           Result := DateTimeField(FieldName)
          else If FieldClass = TBlobField then
           Result := BlobField(FieldName)
          else If FieldClass = TWideMemoField then
           Result := WideMemoField(FieldName)
          else If FieldClass = TGraphicField then
           Result := GraphicField(FieldName)
          else If FieldClass = TGuidField then
           Result := GuidField(FieldName)
          else If FieldClass = TUnsignedAutoIncField then
           Result := UnsignedAutoIncField(FieldName)
           else If FieldClass = TByteField then
           Result := ByteField(FieldName);
          end;
end;

procedure GetFieldAttributes( Field : TRttiField );

var  Attribute : TCustomAttribute;

begin

     AttrFieldName := Field.Name;
     AttrFieldBaseName := AttrFieldName;
     AttrIsPeriodical := False;
     AttrIsCalculated := False;

     For Attribute in Field.GetAttributes do
       If   Attribute is TAttrFieldName
       then AttrFieldName := TAttrFieldName( Attribute ).FieldName
       else If   Attribute is TAttrCalculatedField
            then AttrIsCalculated := True
            else If   Attribute is TAttrPeriodicalField
                 then begin
                      AttrIsPeriodical := True;
                      With TAttrPeriodicalField( Attribute ) do
                        begin
                        If   FieldBaseName<>''
                        then AttrFieldBaseName := FieldBaseName;
                        AttrPeriodicalNames := PeriodicalNames
                        end;
                      end;
end;

function IsCalculatedField( Field : TRttiField ) : Boolean;

var  Attribute : TCustomAttribute;

begin
     For Attribute in Field.GetAttributes do
       If   Attribute is TAttrCalculatedField
       then begin
            Result := True;
            Exit;
            end;
     Result := False;
end;

begin
     RttiContext := TRttiContext.Create;
     try
       RttiType := RttiContext.GetType( ClassInfo );
       For ClassField in RttiType.GetFields do  // GetDeclaredFields no incluye los de las 'parent classes'
         If   Assigned( ClassField.FieldType )
         then begin
              GetFieldAttributes( ClassField );
              ClassFieldType := ClassField.FieldType;
              If   ClassFieldType.TypeKind=tkClass
              then begin
                   FieldClass := ClassFieldType.AsInstance.MetaclassType;
                   If   FieldClass.InheritsFrom( TField )
                   then begin
                        ElementField := GetFieldValue( FieldClass, AttrFieldName );
                        If   Assigned( ElementField )
                        then ClassField.SetValue( Self, ElementField );
                        end;
                   end
              else If   ClassFieldType.TypeKind=tkArray
                   then begin

                        RttiArrayType := TRttiArrayType( ClassFieldType );
                        FieldClass := RttiArrayType.ElementType.AsInstance.MetaclassType;
                        If   FieldClass.InheritsFrom( TField )
                        then begin

                             ArrayValue := ClassField.GetValue( Self );

                             // Solo soporto arrays unidimensionales

                             If   Assigned( RttiArrayType.Dimensions[ 0 ] )
                             then begin
                                  DimType := RttiArrayType.Dimensions[ 0 ] as TRttiOrdinalType;
                                  ArrayIndex := DimType.MinValue;
                                  end
                             else ArrayIndex := 1;

                             PeriodicalList := TStringList.Create;
                             If   AttrPeriodicalNames<>''
                             then PeriodicalList.CommaText := AttrPeriodicalNames;

                             try

                               For Index := 0 to ArrayValue.GetArrayLength - 1 do
                                 begin

                                 If   AttrIsPeriodical
                                 then begin
                                      If   AttrPeriodicalNames<>''
                                      then ElementFieldName := AttrFieldBaseName + PeriodicalList[ Index ]
                                      else ElementFieldName := AttrFieldBaseName + ListaPeriodos[ ArrayIndex ];
                                      end
                                 else ElementFieldName := AttrFieldBaseName + IntToStr( ArrayIndex );

                                 ElementField := GetFieldValue( FieldClass, ElementFieldName );
                                 ArrayValue.SetArrayElement( Index, ElementField );
                                 Inc( ArrayIndex );
                                 end;

                               ClassField.SetValue( Self, ArrayValue );

                             finally
                               PeriodicalList.Free;
                               end;

                             end;
                        end;
              end;

     finally
       RttiContext.Free;
       end;
end;

procedure TnxeDataSetFields.Clear( ADataSet : TnxDataSet = nil;
                                   Incomplete : Boolean = False;
                                   OnSetup    : TDataSetFieldsEvent = nil );

var  TargetDataset : TDataset;

begin

     If   not Assigned( FDataSet ) and
          Assigned( ADataSet )
     then Setup( ADataset, True, Incomplete, OnSetup );

     If   FStaticData
     then TargetDataset := FMemDataSet
     else TargetDataset := FDataSet;

     If   Assigned( TargetDataset )
     then begin
          TargetDataset.Cancel;
          If   StaticData
          then begin
			            TargetDataset.Edit;
		             ClearFieldValues( TargetDataset );
			            end
          else try
			              TargetDataset.Append;
               finally
			              DatasetBrowse;
			              end;
          end;
end;

procedure TnxeDataSetFields.Update( ADataSet   : TnxDataSet = nil;
                                    Incomplete : Boolean = False;
                                    OnSetup    : TDataSetFieldsEvent = nil );

var  TargetDataset : TDataset;

begin

     // Un caso especial que permite inicializar el TnxeDataSetFields cuando se actualiza por primera vez
     // Por supuesto se trata de un StaticData que obtiene los datos de ADataset

     If   not Assigned( FDataSet ) and
          Assigned( ADataSet )
     then Setup( ADataset, True, Incomplete, OnSetup );

     If   FStaticData
     then begin
          If   not Assigned( ADataSet )
          then ADataSet := FDataSet;
          TargetDataset := FMemDataSet
          end
     else TargetDataset := FDataSet;   // Si no es StaticData entonces ADataset debe estar asignado (se producirá una excepción si no lo está)

     If   FStaticData or ( ADataSet<>TargetDataset )     // Si ambos Datasets son el mismo, y no son datos estáticos, los datos ya están actualizados
     then begin

          TargetDataset.Cancel;

          If   StaticData
          then TargetDataset.Edit
          else TargetDataset.Append;

          If   ADataSet.Found or ( ADataSet.State in [ dsEdit, dsInsert ] )
          then CopyDatasetFields( ADataSet, TargetDataset )
          else ClearFieldValues( TargetDataset );

          // Si es Static data dejo el dataset (que es un TgxMemData) en modo edición por si quiero modificar algún valor

          If   not StaticData
          then DatasetBrowse;  // Que es FDataset

          end;

end;

function TnxeDataSetFields.CopyMemDatasetFields( Target : TDataSet ) : Integer;
begin
     Result := CopyDatasetFields( FMemDataset, Target );
end;

function TnxeDataSetFields.CopyDatasetFields( Source,
                                              Target : TDataSet ) : Integer;
var  FieldCtr: Integer;
     DestField,
     SourceField: TField;

begin
     Result := 0;
     For FieldCtr := 0 to Source.FieldCount - 1 do
       begin
       SourceField := Source.Fields[ FieldCtr ];
       DestField := Target.FindField( SourceField.FieldName );
       If   Assigned( DestField )
       then If   not ( not FCopyMemoFields and ( SourceField.DataType in [ ftMemo, ftFmtMemo, ftWideMemo ] ) ) and
                 not ( not FCopyImageFields and ( SourceField.DataType=ftGraphic ) )
            then begin
                 DestField.Value := SourceField.Value;
                 Inc( Result );
                 end;
       end;
end;

procedure TnxeDataSetFields.CopyFieldsFrom( ADataSet : TnxDataSet );
begin
     If   ADataSet<>FDataSet
     then try
            FDataSet.Edit;
            CopyDatasetFields( ADataSet, FDataSet )
          finally
             DatasetBrowse;
             end;
end;

procedure TnxeDataSetFields.CopyFieldsTo( ADataSet : TnxDataSet );
begin
     If   ADataSet<>FDataSet
     then begin
          ADataset.Edit;
          CopyDatasetFields( FDataset, ADataset );
          end;
end;

function TnxeDataSetFields.Fields : TFields;
begin
     If   FStaticData
     then Result := FMemDataset.Fields
     else Result := FDataset.Fields;
end;

function TnxeDataSetFields.FindField( FieldName : String ) : TField;
begin
     If   FStaticData
     then Result := FMemDataset.FindField( FieldName )
     else Result := FDataset.FindField( FieldName );
end;

procedure TnxeDataSetFields.CopyStaticFieldsTo( ADataSet : TnxDataSet );
begin
     If   FStaticData
     then CopyDatasetFields( FMemDataset, ADataset );
end;

procedure TnxeDataSetFields.DatasetAppend;
begin
     FDataSet.Append;
end;

procedure TnxeDataSetFields.DatasetEdit;
begin
     FDataSet.Edit;
end;

procedure TnxeDataSetFields.DatasetCancel;
begin
     FDataSet.Cancel;
end;

procedure TnxeDatasetFields.DatasetPost;
begin
     FDataSet.Post;
end;

procedure TnxeDatasetFields.DatasetDelete;
begin
     FDataSet.Delete;
end;

procedure TnxeDataSetFields.DatasetBrowse;
begin
     If   Assigned( FTable )
     then FTable.Browse
     else raise Exception.Create( RsMsg3 );
end;

function TnxeDatasetFields.SetStateFromInterface( InterfaceState : TDataSetState ): Boolean;

var  TargetDataset : TDataset;

begin

     Result := False;

     If   FStaticData
     then TargetDataset := FMemDataSet
     else TargetDataset := FDataSet;

     TargetDataset.Cancel;

     If   ( InterfaceState=dsEdit ) and not FStaticData
     then TargetDataset.Edit
     else begin
          TargetDataset.Append;
          Result := True;
          end;

end;

function TnxeDataSetFields.GetField( AFieldName           : String;
                                     AFieldType           : TFieldType;
                                     RaiseErrorIfNotFound : Boolean = True ) : TField;

var  SourceDataSet : TDataSet;

begin
     Result := nil;

     If   FStaticData
     then SourceDataSet := FMemDataSet
     else SourceDataSet := FDataSet;

     With SourceDataSet do
       begin

       If   not Active
       then Open;

       Result := FindField( AFieldName );

       // Estoy intentando suprimir los '_' de los nombres de campo, pero aún quedan muchos

       If   not Assigned( Result )
       then Result:= FindField( StrRemoveChars( AFieldName, [ '_' ] ) );

       If   Assigned( Result )
       then If   not ( ( Result.DataType=ftAutoInc ) and ( AFieldType=ftLongWord ) ) and  // La excepción de los autoinc en los querys
                 ( Result.DataType<>AFieldType )
            then If   FIncompleteDataset
                 then Result := nil
                 else If   RaiseErrorIfNotFound
                      then raise EnxDatabaseError.CreateFmt( RsMsg12, [ SourceDataSet.Name,  AFieldName ] );

       If   not Assigned( Result ) and
            not FIncompleteDataset and
            ( FieldDefList.Count=FieldList.Count ) and   // Indica que existe una lista explícita de campos. En este caso puede que no estén todos los existentes.
            ( AFieldName<>'Id' ) and                     // El identificador no es un campo obligatorio (se ha añadido recientemente y no todos los datasets fijos (con TDataset.DefaultFields=False) lo tienen
            RaiseErrorIfNotFound and
            not DatabaseUpdateRequested
       then raise EnxDatabaseError.CreateFmt( RsMsg1, [ AFieldName ] );

       end;
end;

function TnxeDatasetFields.GetRemoteCursorID : TnxCursorID;
begin
     If   Assigned( Dataset ) and ( Dataset.AbstractCursor is TnxRemoteCursor )
     then Result := TnxRemoteCursor( Dataset.AbstractCursor ).RemoteID
     else Result := 0;
end;

function TnxeDataSetFields.GetField( AFieldName           : String;
                                     AFieldClass          : TClass;
                                     RaiseErrorIfNotFound : Boolean = True ) : TField;

var  SourceDataSet : TDataSet;

begin
     Result := nil;

     If   FStaticData
     then SourceDataSet := FMemDataSet
     else SourceDataSet := FDataSet;

     With SourceDataSet do
       begin

       If   not Active
       then Open;

       Result := FindField( AFieldName );

       // Estoy intentando suprimir los '_' de los nombres de campo, pero aún quedan muchos

       If   not Assigned( Result )
       then Result:= FindField( StrRemoveChars( AFieldName, [ '_' ] ) );

       If   Assigned( Result )
       then If   Result.ClassType<>AFieldClass
            then If   not ( ( Result.DataType=ftAutoInc ) and ( AFieldClass=TLongWordField ) )  // La excepción de los autoinc en los querys
                 then If   FIncompleteDataset
                      then Result := nil
                      else If   RaiseErrorIfNotFound
                           then raise EnxDatabaseError.nxCreate( DBIERR_INVALIDFLDTYPE );

       If   not Assigned( Result ) and not FIncompleteDataset and RaiseErrorIfNotFound and not ( not ServerApplication and DatabaseUpdateRequested )
       then raise EnxDatabaseError.nxCreate( DBIERR_INVALIDFIELDNAME );

       end;
end;

function TnxeDataSetFields.WideStringField( FieldName            : String;
                                            RaiseErrorIfNotFound : Boolean = True ) : TWideStringField;
begin
     Result := GetField( FieldName, ftWideString, RaiseErrorIfNotFound ) as TWideStringField;
end;

function TnxeDataSetFields.GuidField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TGuidField;
begin
     Result := GetField( FieldName, ftGuid, RaiseErrorIfNotFound ) as TGuidField;
end;

function TnxeDataSetFields.UnsignedAutoIncField( FieldName            : String;
                                                 RaiseErrorIfNotFound : Boolean = True ) : TUnsignedAutoIncField;
begin
     Result := GetField( FieldName, ftAutoInc, RaiseErrorIfNotFound ) as TUnsignedAutoIncField
end;

function TnxeDataSetFields.FloatField( FieldName            : String;
                                       RaiseErrorIfNotFound : Boolean = True ) : TFloatField;
begin
     Result := GetField( FieldName, ftFloat, RaiseErrorIfNotFound ) as TFloatField;
end;

function TnxeDataSetFields.BCDField( FieldName            : String;
                                     RaiseErrorIfNotFound : Boolean = True ) : TBCDField;
begin
     Result := GetField( FieldName, ftBCD, RaiseErrorIfNotFound ) as TBCDField;
end;

function TnxeDataSetFields.IntegerField( FieldName            : String;
                                         RaiseErrorIfNotFound : Boolean = True ) : TIntegerField;
begin
     Result := GetField( FieldName, ftInteger, RaiseErrorIfNotFound ) as TIntegerField;
end;

function TnxeDataSetFields.SmallIntField( FieldName            : String;
                                          RaiseErrorIfNotFound : Boolean = True ) : TSmallintField;
begin
     Result := GetField( FieldName, ftSmallInt, RaiseErrorIfNotFound ) as TSmallintField;
end;

function TnxeDataSetFields.LargeIntField( FieldName            : String;
                                          RaiseErrorIfNotFound : Boolean = True ) : TLargeIntField;
begin
     Result := GetField( FieldName, ftLargeInt, RaiseErrorIfNotFound ) as TLargeIntField;
end;

function TnxeDataSetFields.WordField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TWordField;
begin
     Result := GetField( FieldName, ftWord, RaiseErrorIfNotFound ) as TWordField;
end;

function TnxeDataSetFields.ByteField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TByteField;
begin
     Result := GetField( FieldName, ftByte, RaiseErrorIfNotFound ) as TByteField;
end;

function TnxeDataSetFields.LongWordField( FieldName            : String;
                                          RaiseErrorIfNotFound : Boolean = True ) : TLongWordField;
begin
     Result := GetField( FieldName, ftLongWord, RaiseErrorIfNotFound ) as TLongWordField;
end;

function TnxeDataSetFields.DateField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TDateField;
begin
     Result := GetField( FieldName, ftDate, RaiseErrorIfNotFound ) as TDateField;
end;

function TnxeDataSetFields.DateTimeField( FieldName            : String;
                                          RaiseErrorIfNotFound : Boolean = True ) : TDateTimeField;
begin
     Result := GetField( FieldName, ftDateTime, RaiseErrorIfNotFound ) as TDateTimeField;
end;

function TnxeDataSetFields.TimeField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TTimeField;
begin
     Result := GetField( FieldName, ftTime, RaiseErrorIfNotFound ) as TTimeField;
end;

function TnxeDataSetFields.BooleanField( FieldName            : String;
                                         RaiseErrorIfNotFound : Boolean = True ) : TBooleanField;
begin
     Result := GetField( FieldName, ftBoolean, RaiseErrorIfNotFound ) as TBooleanField;
end;

function TnxeDataSetFields.BlobField( FieldName            : String;
                                      RaiseErrorIfNotFound : Boolean = True ) : TBlobField;
begin
     Result := GetField( FieldName, ftBlob, RaiseErrorIfNotFound ) as TBlobField;
end;

function TnxeDataSetFields.WideMemoField( FieldName            : String;
                                          RaiseErrorIfNotFound : Boolean = True ) : TWideMemoField;
begin
     Result := GetField( FieldName, ftWideMemo, RaiseErrorIfNotFound ) as TWideMemoField;
end;

function TnxeDataSetFields.GraphicField( FieldName : String;
                                         RaiseErrorIfNotFound : Boolean = True ) : TGraphicField;
begin
     Result := GetField( FieldName, ftGraphic, RaiseErrorIfNotFound ) as TGraphicField;
end;

function TnxeDataSetFields.CreateCalculatedField( AFieldName : String;
                                                  FieldType : TFieldType ) : TField;
begin
     Result := GetField( AFieldName, FieldType, False );
     If   not Assigned( Result )
     then begin

          If   Assigned( FCalcMemDataset )
          then FCalcMemDataset.Close  // Por si acaso
          else FCalcMemDataset := TgxMemData.Create( Self );

          case FieldType of
            ftSmallInt    : Result := TSmallIntField.Create( FDataset );
            ftInteger     : Result := TIntegerField.Create( FDataset );
            ftString      : Result := TStringField.Create( FDataset );
            ftWideString  : Result := TWideStringField.Create( FDataset );
            ftFloat       : Result := TFloatField.Create( FDataset );
            ftBCD         : Result := TBCDField.Create( FDataset );
            ftBoolean     : Result := TBooleanField.Create( FDataset );
            ftDate        : Result := TDateField.Create( FDataset );
            else
              raise Exception( RsMsg2 );
            end;

          With Result do
            begin
            FieldName := AFieldName;
            FieldKind := fkData; // fkCalculated;
            Dataset := FCalcMemDataset;
            end;

          end;
end;

function TnxeDataSetFields.CreateCalculatedField( AFieldName : String;
                                                  FieldClass : TClass ) : TField;
begin
     Result := GetField( AFieldName, FieldClass, False );
     If   not Assigned( Result )
     then begin

          If   Assigned( FCalcMemDataset )
          then FCalcMemDataset.Close
          else FCalcMemDataset := TgxMemData.Create( Self );

          If   FieldClass=TSmallIntField then
           Result := TSmallintField.Create(FDataset)
          else If FieldClass = TIntegerField then
           Result := TIntegerField.Create(FDataset)
          else If FieldClass = TStringField then
           Result := TStringField.Create( FDataset )
          else If FieldClass = TWideStringField then
           Result := TWideStringField.Create( FDataset )
          else If FieldClass = TFloatField then
           Result := TFloatField.Create( FDataset )
          else If FieldClass = TBCDField then
            Result := TBCDField.Create( FDataset )
          else If FieldClass = TBooleanField then
            Result := TBooleanField.Create( FDataset )
          else If FieldClass = TDateField then
            Result := TDateField.Create( FDataset )
          else  raise Exception( RsMsg2 );

          With Result do
            begin
            FieldName := AFieldName;
            FieldKind := fkData; // fkCalculated;
            Dataset := FCalcMemDataset;
            end;

          end;
end;

// TnxeTable -------------------------------------------------------------

constructor TnxeTable.Create( AOwner : TComponent );
begin
     inherited Create( AOwner );
     FTableType := ttStandard;
     FCreateIfAbsent := True;
     FCanEdit := True;
     FCanInsert := True;
     FCanModify := True;
     FMasterRelation := mrLoose;
     FOpenOnMasterActivation := True;
     FPreviousState := dsInactive;   
end;

destructor TnxeTable.Destroy;
begin
     FreeAndNil( FDataDictionary );
     nxFreeMem( FSavedRangeStart );
     nxFreeMem( FSavedRangeEnd );
     FRangeStartValues := nil;
     FRangeEndValues := nil;
     inherited;
end;

function TnxeTable.GetIndexNumber : Integer;
begin
     AbstractCursor.GetIndexID( FIndexNumber );
     Result := FIndexNumber;
end;

{
procedure TnxeTable.SetIndexNumber( const Value : Integer );
begin
    If   ( Value>=0 ) and ( Value<IndexDefs.Count )
    then begin
         IndexName := IndexDefs.Items[ Value ].Name;
         FIndexNumber := Value;
         end
    else dsError( DBIERR_NOSUCHINDEX );

end;
}

constructor TnxeTable.AssignRootPropertiesFrom( ReferenceTable : TnxeTable );
begin
     Session := ReferenceTable.Session;
     Database := ReferenceTable.Database;
     TableName := ReferenceTable.TableName;
     TableType := ReferenceTable.TableType;
     IndexFieldNames := ReferenceTable.IndexFieldNames;
end;

procedure TnxeTable.dsError( const AErrorCode : TnxResult );
begin
     inherited dsError( AErrorCode );
end;

function TnxeTable.GetDataDictionary : TnxDataDictionary;
begin
     If   not Assigned( FDataDictionary ) and Assigned( FDatabaseDictionary )
     then begin
          FDataDictionary := TnxDataDictionary.Create;
          FDatabaseDictionary.GetDataDictionary( GetBaseTableName, '', FDataDictionary );
          end;
     Result := FDataDictionary;
end;

procedure TnxeTable.PropertyChanged;
begin
     If   not ServerApplication
	 then begin
	      FDatabaseDictionary := nil;
          FreeAndNil( FDataDictionary );
          end;
end;

function TnxeTable.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
     Result := GetCustomFieldClass( FieldType );
     If   not Assigned( Result )
     then Result := inherited GetFieldClass( FieldType );
end;

procedure TnxeTable.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FAutoIncField
          then FAutoIncField := nil;
          end;
end;

procedure TnxeTable.Loaded;
begin
     inherited;
     SetDefaultErrorManager;
     TimeOut := DefaultTimeout;
     FHasPredefinedFields := Fields.Count>0;
end;

procedure TnxeTable.SetDefaultErrorManager;
begin
     If   not Assigned( OnEditError )
     then OnEditError := DoOnDefaultError;
     If   not Assigned( OnPostError )
     then OnPostError := DoOnPostOrDeleteError;
     If   not Assigned( OnDeleteError )
     then OnDeleteError := DoOnPostOrDeleteError;
end;

procedure TnxeTable.DoOnDefaultError(     DataSet : TDataSet;
                                          E       : EDatabaseError;
                                      var Action  : TDataAction );
begin

     {
     Si se fija FailOnError estamos indicando que queremos que se produzca directamente
     la excepción sin intentar mostrar previamente un mensaje de error.
     }

     If   not FFailOnError
     then If   Assigned( OnDatabaseError )
          then OnDatabaseError( DataSet, E );
end;

procedure TnxeTable.DoOnPostOrDeleteError(      DataSet : TDataSet;
                                                E       : EDatabaseError;
                                            var Action  : TDataAction );
begin
     DoOnDefaultError( Dataset, E, Action );
end;

function TnxeTable.GetBaseTableName : String;
begin
     Result := StrRemoveChars( ExtractSubString( TableName, '_' ), [ '#' ] );
end;

function TnxeTable.GetFilePath : String;
begin
     If   Assigned( Database )
     then Result := AddPathDelim( Database.Path ) + TableName
     else Result := TableName;
     Result := Result + '.nx1';
end;

procedure TnxeTable.CreateTemporalTableName( PreserveIt : Boolean = False );
begin
     TableName := GetTemporalTableName( Database, BaseTableName );
     If   FTableType=ttMemVirtual
     then TableName := '##' + TableName;
     FPreserveTemporalTableName := PreserveIt;
end;

procedure TnxeTable.OpenCursor( AInfoQuery : Boolean );

var  ATableScope : TnxTableScope;

begin

     {
     Las tablas temporales (ttTemporal) se diferencian de las virtuales (ttVirtual) en que las primeras tienen
     un DatabaseDictionary asociado en el que se define su estructura y las virtuales se crean mediante un
     procedimiento externo (por ejemplo CreateEmptyTable, que crea una tabla a partir de una sentencia SQL
     o a partir de sus IndexDefs y FieldDefs )
     }

     FRecordOpened := False;

     If   not IsDesignTime
     then try

            ErrorCounter := 0;
            FCopyTableRecords := False;

            If   FTableType in [ ttVirtual, ttMemVirtual ]
            then begin
                 {
                   Si es un tabla virtual y el campo FPreserveTemporalTableName es true es porque la tabla
                   ha sido creada previamente utilizando una sentencia SQL o cualquier otro método.
                   En ese supuesto la tabla solo debe abrirse y no se debe intentar crear a partir de su definición
                   de campos e índices (IndexDefs, FieldDefs)
                 }

                 If   ( FieldCount>0 ) and not FPreserveTemporalTableName // Definida a partir de sus campos y nueva
                 then begin
                      CreateTemporalTableName;
                      // TableName := GetTemporalTableName( Database, TableName );
                      If   FTableType=ttMemVirtual
                      then ATableScope := tsTempDatabase
                      else ATableScope := tsPersistent;
                      CreateTableEx( nxbs4k, ATableScope );
                      end;

                 end
            else If   FTableType<>ttRecover
                 then begin

                      If   ( FTableType=ttTemporal ) and not FPreserveTemporalTableName
                      then TableName := GetTemporalTableName( Database, TableName );

                      If   not Assigned( FDatabaseDictionary )
                      then FDatabaseDictionary := GetTableDictionary( GetBaseTableName );

                      If   Assigned( Database ) and
                           Assigned( FDatabaseDictionary )
                      then If   ( FCreateIfAbsent or ( FTableType=ttTemporal ) ) and not Database.TableExists( TableName, '' )
                           then begin
                                DataDictionary.AddLocaleDescriptor;
                                Database.CreateTable( True, TableName, '', DataDictionary );
                                FCopyTableRecords := ( FTableType=ttStandard ) and ( Database.DisplayCategory<>'Temporal' );
                                end;
                      end;

           except on E : Exception do
             ShowDatabaseError( Self, E ) ;  // Si no es un error de NexusDB el procedimiento ShowDatabaseError volverá a lanzar la excepción
           end;

       try
         inherited OpenCursor( AInfoQuery );
       except on E : EnxDatabaseError do
              begin

              // Cuando las tablas se llevan de una máquina a otra con una tabla de códigos diferente se tienen que reconstruir los índices
              // (empaquetar/reconstruir) antes de poder utilizarlas

              If   not ServerApplication
			           then begin
              	    If   E.ErrorCode=DBIERR_TABLELEVEL
                   then RequestDatabaseUpdate( CodigoEmpresaActual, True )
                   else If   Assigned( dsAbstractCursor ) and not FCopyTableRecords    // Si FCopyTableRecords es True es porque se ha producido un error durante el intento de copia de registros
                        then CheckTable; // RequestDatabaseUpdate directamente?
                   end;

              raise;
              end
         else raise;
         end;


end;

procedure TnxeTable.dsCloseCursorID;
begin
     If   ServerApplication
	    then RestoreAbstractCursor;   // La tabla en el servidor nunca posee el cursor asignado desde el cliente. Éste debe ser destruido por la sesión del cliente.
     inherited;
end;

function TnxeTable.GetMinAutoIncValue : Variant;
begin
     Result := GetMinFieldValue( FAutoIncField );
end;

function TnxeTable.GetMasterRelation: TMasterRelation;
begin
     Result := FMasterRelation;
end;

function TnxeTable.GetOpenOnMasterActivation : Boolean;
begin
     Result := FopenOnMasterActivation;
end;

procedure TnxeTable.SetMasterRelation(const Value: TMasterRelation);
begin
     FMasterRelation := Value;
end;

function TnxeTable.GetMaxAutoIncValue : Variant;
begin
     Result := GetMaxFieldValue( FAutoIncField );
end;

function TnxeTable.GetModified : Boolean;
begin
     Result := inherited Modified;
end;

procedure TnxeTable.SetModified( const Value : Boolean );
begin
     inherited SetModified( Value );
end;

procedure TnxeTable.SetSettingKey( const Value : Boolean );
begin
     FSettingKey := Value;
end;

function TnxeTable.GetAutoIncField : TField;

var  AField : TField;

begin
     If   not Assigned( FAutoIncField ) and ( FAutoIncFieldName<>'' ) and Active
     then begin
          AField := FindField( FAutoIncFieldName );
          If   not Assigned( AField )
          then raise Exception.CreateFmt( RsMsg1, [ FAutoIncFieldName ] );
          FAutoIncField := AField;
          end;
     Result := FAutoIncField;
end;

function TnxeTable.GetAutoIncFieldName : String;
begin
     Result := FAutoIncFieldName;
end;

procedure TnxeTable.AssignAbstractCursor( CursorID : TnxCursorID );

var  AbstractCursor : TnxAbstractCursor;

begin
     FSavedAbstractCursor := dsAbstractCursor;
     If   TnxAbstractCursor.LookupByID( CursorID, AbstractCursor )=DBIERR_NONE
     then dsAbstractCursor := AbstractCursor
     else RaiseNoCurrentRecordException;
end;

procedure TnxeTable.RestoreAbstractCursor;
begin
     If   Assigned( FSavedAbstractCursor )
     then begin
          dsAbstractCursor := FSavedAbstractCursor;
          FSavedAbstractCursor := nil;
          end;
end;


procedure TnxeTable.SetAutoIncFieldName( const Value : String );
begin
     If   Value<>FAutoIncFieldName
     then begin
          FAutoIncFieldName := Value;
          FAutoIncField := nil;
          If   not ( csLoading in ComponentState ) and ( Value<>'' ) and Active
          then FAutoIncField := GetAutoIncField;
          end;
end;

function TnxeTable.GetFireEditionEvents : Boolean;
begin
     Result := FFireEditionEvents;
end;

procedure TnxeTable.SetFireEditionEvents( const Value : Boolean );
begin
     FFireEditionEvents := Value;
end;

function TnxeTable.GetShiftingRecords : Boolean;
begin
     Result := FShiftingRecords;
end;

procedure TnxeTable.SetShiftingRecords( const Value : Boolean );
begin
     FShiftingRecords := Value;
end;

function TnxeTable.GetOnUpdateState : TDataSetNotifyEvent;
begin
     Result := FOnUpdateState;
end;

procedure TnxeTable.SetOnUpdateState( const Value : TDataSetNotifyEvent );
begin
     FOnUpdateState := Value;
end;

function TnxeTable.GetOnApplyMasterRange : TDataSetNotifyEvent;
begin
     Result := FOnApplyMasterRange;
end;

procedure TnxeTable.SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
begin
     FOnApplyMasterRange := Value;
end;

function TnxeTable.GetEditing : Boolean;
begin
     Result := State in [ dsEdit, dsInsert ]; // No dsSetKey. En este estado solo se pueden modificar los campos del área de clave
end;

function TnxeTable.GetEditingKey : Boolean;
begin
     Result := State=dsSetKey;
end;

function TnxeTable.GetInternalProcess : Boolean;
begin
     Result := ( FSettingKey or FPostingKeyBuffer or FInternalSeekProcess or FInternalAppendProcess or FUpdatingProcess );
end;

function TnxeTable.GetReadableRecord : Boolean;
begin
     Result := ( State in [ dsBrowse, dsEdit, dsInsert ] ) and not InternalProcess;
end;

function TnxeTable.GetReadOnly: Boolean;
begin
     Result := ReadOnly;
end;

procedure TnxeTable.InternalAppend;
begin
     try
       FInternalAppendProcess := True;
       Append;
     finally
       FInternalAppendProcess := False;
       end;
end;

procedure TnxeTable.InternalDelete;

var  Buffer : TnxRecordBuffer;

begin
     If   FRemoteEdit and
          not FShiftingRecords
     then begin
          DoOnRemoteDelete;
          If   State=dsEdit
          then If   dsGetActiveBuffer( Buffer )
               then InitRecord( Buffer );
          end
     else inherited;
     FRecordOpened := False;
end;

procedure TnxeTable.CheckTable;
begin
     If   ( FTableType=ttStandard ) and not FCopyTableRecords
     then try
            CheckTableStructure;
          except on e : EnxDatabaseError do begin
                                            // CloseCursor;
                                            If   ( E.ErrorCode=DBIERR_TABLEVERSIONOBSOLETE ) or
                                                 ( E.ErrorCode=DBIERR_TABLESTRUCTCHANGED )
                                            then RequestDatabaseUpdate( CodigoEmpresaActual )
                                            else raise;
                                            end;
                 else raise;
            end;
end;

procedure TnxeTable.CopyDictionaryRecords;

var  DictionaryTable : TnxTable;
     SavedState : TDataSetState;

begin

     DictionaryTable := TnxTable.Create( Self );
     try

       DictionaryTable.Database := FDatabaseDictionary;
       DictionaryTable.TableName := TableName;
       DictionaryTable.Open;
       DictionaryTable.IndexName := csSeqAccessIndexName;

       SavedState := SetTempState( dsOpening );
       try
         CopyRecords( DictionaryTable, True );
       finally
         RestoreState( SavedState );
         end;

     finally
       DictionaryTable.Free;
       end;

end;

procedure TnxeTable.InternalOpen;
begin
     inherited;

     // Solo copio el contenido por defecto en tablas de datos de usuario

     If   FCopyTableRecords
     then CopyDictionaryRecords;

end;

function TnxeTable.FieldStructChanged : Boolean;
begin
     If   Assigned( _Dictionary ) and Assigned( DataDictionary )
     then Result := not _Dictionary.FieldsDescriptor.IsEqual( DataDictionary.FieldsDescriptor )
     else Result := False;
end;

function  TnxeTable.IndexStructChanged : Boolean;
begin
     If   Assigned( _Dictionary ) and Assigned( DataDictionary )
     then Result := not _Dictionary.IndicesDescriptor.IsEqual( DataDictionary.IndicesDescriptor )
     else Result := False;
end;

function TnxeTable.StructChanged( CheckLocale : Boolean = False ) : Boolean;

var  I, FInx : Integer;
     IndexDescriptor : TnxIndexDescriptor;

function CheckEqual( a, b : TnxDictionaryItem ) : Boolean;
begin
     Result := ( Assigned( a )=Assigned( b ) ) and ( not Assigned( a ) or a.IsEqual( b ) );
end;

begin

     // 02.02.2011 He modificado el método de comprobación porque cuando el tipo de servidor es distinto ( TnxRemoteServerEngine o TnxServerEngine )
     //            la clase del diccionario puede ser TnxDataDictionary o TnxServerDataDict, y la comparación _Dictionary.IsEqual( DataDictionary )
     //            indica que las estructura de la tabla ha cambiado, cuando no es necesariamente cierto.

     If   Assigned( _Dictionary ) and Assigned( DataDictionary )
     then begin

          Result := not ( SameText( _Dictionary.EncryptionEngine, DataDictionary.EncryptionEngine ) and
                          CheckEqual( _Dictionary.StreamDescriptor, DataDictionary.StreamDescriptor ) and
                          CheckEqual( _Dictionary.FilesDescriptor, DataDictionary.FilesDescriptor ) and
                          // CheckEqual( _Dictionary.IndicesDescriptor, DataDictionary.IndicesDescriptor ) and
                          CheckEqual( _Dictionary.FieldsDescriptor, DataDictionary.FieldsDescriptor ) and
                          CheckEqual( _Dictionary.RecordDescriptor, DataDictionary.RecordDescriptor) and
                          CheckEqual( _Dictionary.BlobDescriptor, DataDictionary.BlobDescriptor) and
                          CheckEqual( _Dictionary.AutoIncDescriptor, DataDictionary.AutoIncDescriptor) and
                          CheckEqual( _Dictionary.CustomDescsDescriptor, DataDictionary.CustomDescsDescriptor) and
                          CheckEqual( _Dictionary.TablesDescriptor, DataDictionary.TablesDescriptor ) );

          // Compruebo que el índice por defecto sea el mismo

          If   not Result
          then begin

               Result := DataDictionary.IndicesDescriptor.DefaultIndex<>_Dictionary.IndicesDescriptor.DefaultIndex;

               //* 02.07.2014  Ahora solo compruebo que los índices existan y que tengan la estructura esperada. De este
               //              modo puedo añadir indices desde módulos propietarios sin que se reestructure la tabla

               If   not Result
               then For I := 0 to DataDictionary.IndicesDescriptor.IndexCount - 1 do
                      begin
                      IndexDescriptor := _Dictionary.IndicesDescriptor.GetDescriptorFromName( DataDictionary.IndicesDescriptor.IndexDescriptor[ I ].Name );
                      If   Assigned( IndexDescriptor )
                      then begin
                           Result := not CheckEqual( IndexDescriptor, DataDictionary.IndicesDescriptor.IndexDescriptor[ I ] );
                           If   Result
                           then Break;
                           end
                     else Result := True;
                     end;

               // No me sirve que los campos sean compatibles. Cualquier cambio de tipo exige una reestructuración ...

               If   not Result
               then With DataDictionary.FieldsDescriptor do
                      For I := Low( FieldDescriptor ) to High( FieldDescriptor ) do
                        If   Result
                        then Exit
                        else begin
                             FInx := _Dictionary.FieldsDescriptor.GetFieldFromName( FieldDescriptor[ I ].Name );
                             If   FInx>=0
                             then Result := ( FieldDescriptor[ I ].fdType<>_Dictionary.FieldsDescriptor.FieldDescriptor[ FInx ].fdType ) or
                                            ( FieldDescriptor[ I ].fdUnits<>_Dictionary.FieldsDescriptor.FieldDescriptor[ FInx ].fdUnits ) or
                                            ( FieldDescriptor[ I ].fdRequired<>_Dictionary.FieldsDescriptor.FieldDescriptor[ FInx ].fdRequired )
                             else Result := True;
                             end;

               end;

          //* 27.11.2018  Los campos _Creado y _Actualizado son internos (no se muestran en la lista de campos del cliente) y contienen el timestamp de creación del registro
          //              y el de la última actualización del mismo.
          {
          If   not Result
          then Result := ( _Dictionary.FieldsDescriptor.GetFieldFromName( CreatedFieldName )=-1 ) or
                         ( _Dictionary.FieldsDescriptor.GetFieldFromName( ModifiedFieldName )=-1 );
          }
          //* 10.09.2011  La solución para actualizar los cambios en el NLS mediante la función PackTable no funciona si, por cualquier motivo,
          //              la tabla no tienen asignada ninguna página de códigos.

          // CheckLocale se supone que solo debe activarse cuando la consulta se está haciendo desde el mismo SO cuya página de códigos determina
          // la de las tablas, es decir, en instalaciones locales o, en entornos de red, desde el servidor.

          Result := Result or
                    not Assigned( _Dictionary.LocaleDescriptor ) or
                    ( Assigned( _Dictionary.LocaleDescriptor ) and CheckLocale and ( _Dictionary.LocaleDescriptor.Locale<>GetThreadLocale ) );

          end
     else Result := False;
end;

procedure TnxeTable.CheckTableStructure;
begin
     If   not DatabaseUpdateRequested
     then If   StructChanged
          then If   FCreateIfAbsent
               then begin
                    If   VerifyingTables or RecoveringTables
                    then dsError( DBIERR_TABLEVERSIONMISMATCH )
                    else dsError( DBIERR_TABLEVERSIONOBSOLETE );
                    end
               else dsError( DBIERR_TABLESTRUCTCHANGED );
end;

procedure TnxeTable.SetKeyBuffer( AKeyIndex : TnxKeyIndex );
begin
     // Equivale a idSetKeyBuffer( aKeyIndex, False ) sin Eventos
     idKeyBuffer := idKeyBuffers[ aKeyIndex ];
     Move( idKeyBuffer^, idKeyBuffers[ kiSave ]^, idKeyBufferSize );
     FSavedState := SetTempState( dsSetKey );
end;

procedure TnxeTable.PostKeyBuffer;
begin
     // Equivale a idPostKeyBuffer(False) sin Eventos
     Move( idKeyBuffers[ kiSave ]^, idKeyBuffer^, idKeyBufferSize );
     RestoreState( FSavedState );
     idKeyBuffer := nil;
end;

function  TnxeTable.GetFieldValues : TFieldValuesArray;
begin
     Result := GetRecordFieldValues( Self );
end;

procedure TnxeTable.ClearFieldValues;
begin
     ClearRecordFieldValues( Self );
end;

procedure TnxeTable.SetFieldValues( const Values : TFieldValuesArray );
begin
     SetRecordFieldValues( Self, Values );
end;

function TnxeTable.GetFieldIndexValues : TFieldValuesArray;

var  Inx  : SmallInt;

begin
     SetLength( Result, IndexFieldCount );
     For Inx := 0 to IndexFieldCount - 1 do
       Result[ Inx ] := idGetIndexField( Inx ).Value;
end;

procedure TnxeTable.SetFieldIndexValues( const Values        : TFieldValuesArray;
                                         const LastFieldName : string = '' );

var  Inx  : SmallInt;
     Field : TField;
     
begin
     FBlockDataEvents := True;   // Intento evitar que se produzcan eventos de cambio del campo en cada asignación
     try
       For Inx := 0 to high( Values ) do
         begin
         Field := idGetIndexField( Inx );
         If   Field.FieldName=LastFieldName   // Si se ha especificado un nombre de campo de ruptura, se finaliza la copia
         then Exit;
         Field.Value := Values[ Inx ];
         end;
     finally
       FBlockDataEvents := False;
       end;
end;

function TnxeTable.IsFullRangeFixed : Boolean;
begin
     If   Assigned( idKeyBuffers[ kiCurRangeStart ] ) and Assigned( idKeyBuffers[ kiCurRangeEnd ] )
     then Result := idKeyBuffers[ kiCurRangeStart ].kbModified and idKeyBuffers[ kiCurRangeEnd ].kbModified
     else Result := False;
end;

function  TnxeTable.IsAppending : Boolean;
begin
     Result := ( State=dsInsert ) and ( GetBookMarkFlag( ActiveBuffer )=bfEof );
end;

function TnxeTable.IsKeyInRange : Boolean;

var RangeStartValues,
    RangeEndValues : TFieldValuesArray;
    KeyValues : TFieldValuesArray;

begin
     GetRangeValues( RangeStartValues, RangeEndValues );
     KeyValues := GetIndexValues;
     Result := CheckRange( KeyValues, RangeStartValues, RangeEndValues ).CheckState=rsInRange;
end;

function TnxeTable.CheckRange(     Values           : TFieldValuesArray;
                               var RangeStartValues : TFieldValuesArray;
                               var RangeEndValues   : TFieldValuesArray ) : TRangeStateRecord;

var  Inx : SmallInt;
     Vr : TnxValueRelationship;
     OutOfRange : Boolean;

begin
     For Inx := 0 to Pred( IndexFieldCount ) do
       If   not VarIsNull( Values[ Inx ] ) and
            not VarIsNull( RangeStartValues[ Inx ] )
       then begin

            If   VarIsStr( Values[ Inx ] ) or VarIsStr( RangeStartValues[ Inx ] )
            then begin
                 Vr := nxCmpStr( VarToStr( Values[ Inx ] ), VarToStr( RangeStartValues[ Inx ] ) );
                 OutOfRange := ( ( Vr=1 ) and FlipOrder ) or ( ( Vr=-1 ) and not FlipOrder );
                 end
            else OutofRange := ( FlipOrder and  ( Values[ Inx ]>RangeStartValues[ Inx ] ) ) or
                               ( not FlipOrder and ( Values[ Inx ]<RangeStartValues[ Inx ] ) );

            If   OutOfRange
            then begin
                 With Result do
                   begin
                   If   FlipOrder
                   then CheckState := rsHigh
                   else CheckState := rsLow;
                   IndexSegment := Inx;
                   end;
                 Exit;
                 end;

            end;

     For Inx := 0 to Pred( IndexFieldCount ) do
       If   not VarIsNull( Values[ Inx ] ) and
            not VarIsNull( RangeEndValues[ Inx ] )
       then begin

            If   VarIsStr( Values[ Inx ] ) or VarIsStr( RangeEndValues[ Inx ] )
            then begin
                 Vr := nxCmpStr( VarToStr( Values[ Inx ] ), VarToStr( RangeEndValues[ Inx ] ) );
                 OutOfRange := ( ( Vr=-1 ) and FlipOrder ) or ( ( Vr=1 ) and not FlipOrder );
                 end
            else OutOfRange := ( FlipOrder and ( Values[ Inx ]<RangeEndValues[ Inx ] ) ) or
                               ( not FlipOrder and ( Values[ Inx ]>RangeEndValues[ Inx ] ) );

            If   OutOfRange
            then begin
                 With Result do
                   begin
                   If   FlipOrder
                   then CheckState := rsLow
                   else CheckState := rsHigh;
                   IndexSegment := Inx;
                   end;
                 Exit;
                 end;

            end;

     With Result do
       begin
       CheckState := rsInRange;
       IndexSegment := -1;
       end;

end;

procedure TnxeTable.GetRangeValues( var RangeStartValues : TFieldValuesArray;
                                    var RangeEndValues   : TFieldValuesArray );
begin
     try
       SetKeyBuffer( kiCurRangeStart );
       RangeStartValues := GetFieldIndexValues;
     finally
       PostKeyBuffer;
       end;

     try
       SetKeyBuffer( kiCurRangeEnd );
       RangeEndValues := GetFieldIndexValues
     finally
       PostKeyBuffer
       end;
end;

function TnxeTable.CheckSearchRecord( AGetMode : TGetMode ) : TGetResult;

var   GoForward : Boolean;
      KeyBuffer : PnxDataSetKeyBuffer;
      SearchCond : TnxSearchKeyAction;
      Status : TnxResult;
      LastRangeState : TRangeStateRecord;

      Inx : SmallInt;

      FieldIndexValues,
      RangeStartValues,
      RangeEndValues : TFieldValuesArray;


function CheckValidRecord(     IsCurrentValid : Boolean;
                           var GetResult      : TGetResult ) : Boolean;

var  CheckGetMode : TGetMode;

begin
     Result := False;
     If   Assigned( FOnCheckValidRecord )
     then begin
          CheckGetMode := AGetMode;
          If   CheckGetMode=gmCurrent
          then CheckGetMode := gmNext;
          repeat
            If   FOnCheckValidRecord( Self )
            then IsCurrentValid := True
            else begin
                 If   FCheckSearchAction and ( FCurrentSearchKeyAction in [ skaEqualFirst, skaEqualLast, skaAnyEqual ] ) // Posiciones exactas
                 then GetResult := grError
                 else begin
                      GetResult := inherited GetRecord( FCurrentBuffer, CheckGetMode, False );
                      Result := True;
                      end;
                 end;
          until IsCurrentValid or ( GetResult<>grOk );
          end;
end;

// Dos versiones de SetMinFieldValue y SetMaxFieldValue que evitan la comprobacion de los valores permitidos del TField (MinValue-MaxValue)
// y utilizan valores enteros para las claves enteras (son las que utilizo)

function SetMinFieldValue( AField : TField ) : Variant;
begin
     Result := Null;
     If   Assigned( AField )
     then If   AField is TSmallIntField
          then TSmallIntField( AField ).Value := Low( Smallint )
          else If   AField is TIntegerField
               then TIntegerField( AField ).Value := Low( Integer )
               else If   AField is TCurrencyField
                    then TCurrencyField( AField ).Value := MinCurrency
                    else If   AField is TFloatField
                         then TFloatField( AField ).Value := MinCurrency
                         else AField.Value := GetMinValue( AField.DataType );
end;

function SetMaxFieldValue( AField : TField ) : Variant;
begin
     Result := Null;
     If   Assigned( AField )
     then If   AField is TSmallIntField
          then TSmallIntField( AField ).Value := High( Smallint )
          else If   AField is TIntegerField
               then TIntegerField( AField ).Value := High( Integer )
               else If   AField is TCurrencyField
                    then TCurrencyField( AField ).Value := MaxCurrency
                    else If   AField is TFloatField
                         then TFloatField( AField ).Value := MaxCurrency
                         else AField.Value := GetMaxValue( AField.DataType );
end;

begin
     Result := grOk;

     If   not FInternalSeekProcess
     then begin
          dsStartBusy;
          try

            FInternalSeekProcess := True;

            If   IsFullRangeFixed
            then begin

                 GoForward := ( FlipOrder and ( AGetMode<>gmNext ) ) or ( not FlipOrder and ( AGetMode=gmNext ) );

                 GetRangeValues( RangeStartValues, RangeEndValues );

                 LastRangeState.CheckState := rsInRange;
                 LastRangeState.IndexSegment := 0;

                 repeat

                   FieldIndexValues := GetFieldIndexValues;
                   FRangeState := CheckRange( FieldIndexValues, RangeStartValues, RangeEndValues );

                   If   ( LastRangeState.CheckState<>rsInRange ) and ( LastRangeState.IndexSegment=0 )
                   then begin
                        If   GoForward
                        then Result := grEof
                        else Result := grBof;
                        Exit;
                        end;

                   LastRangeState.CheckState := FRangeState.CheckState;
                   LastRangeState.IndexSegment := FRangeState.IndexSegment;

                   With FRangeState do
                     If   CheckState<>rsInRange
                     then If   IndexSegment>0
                          then begin

                               // Ahora me pongo en modo edición de la clave

                               SetKeyBuffer( kiLookUp );

                               try

                                 If   GoForward
                                 then begin
                                      If   CheckState=rsLow
                                      then SearchCond := skaGreaterEqual
                                      else SearchCond := skaGreater;
                                      end
                                 else If   CheckState=rsHigh
                                      then SearchCond := skaSmallerEqual
                                      else SearchCond := skaSmaller;

                                 For Inx := 0 to Pred( IndexFieldCount ) do
                                   With IndexFields[ Inx ] do
                                     If   Inx<IndexSegment
                                     then Value := FieldIndexValues[ Inx ]
                                     else If   GoForward
                                          then begin
                                               If   CheckState=rsLow
                                               then begin
                                                    If   FlipOrder
                                                    then Value := RangeEndValues[ Inx ]
                                                    else Value := RangeStartValues[ Inx ];
                                                    end
                                               else If   Inx=IndexSegment
                                                    then SetMaxFieldValue( IndexFields[ Inx ] )
                                                    else Value := FieldIndexValues[ Inx ];
                                               end
                                          else begin
                                               If   CheckState=rsHigh
                                               then begin
                                                    If   FlipOrder
                                                    then Value := RangeStartValues[ Inx ]
                                                    else Value := RangeEndValues[ Inx ];
                                                    end
                                               else If   Inx=IndexSegment
                                                    then SetMinFieldValue( IndexFields[ Inx ] )
                                                    else Value := FieldIndexValues[ Inx ];
                                               end;

                                 KeyBuffer := idGetKeyBuffer( kiLookup );
                                 Status := dsAbstractCursor.SetToKey( SearchCond,
                                                                      KeyFieldCount( KeyBuffer ),
                                                                      0,
                                                                      False,
                                                                      Pointer( TnxRecordBuffer( KeyBuffer ) + SizeOf( TnxDataSetKeyBuffer ) ) );

                               finally
                                 PostKeyBuffer;
                                 end;

                               If    Status=DBIERR_NX_FilterTimeout
                               then  If   not dsCancelServerFilter
                                     then Status := dsGetNextOrPriorRecord( not GoForward, nxltNoLock, nil );

                               dsCheck( Status );

                               Result := inherited GetRecord( FCurrentBuffer, AGetMode, False );
                               If   Result<>grOk
                               then Exit;

                               end
                          else begin
                               If   GoForward
                               then Result := grEof
                               else Result := grBof;
                               Exit;
                               end;

                  If   CheckValidRecord( True, Result )
                  then If   Result=grOk
                       then FRangeState.CheckState := rsExcluded
                       else Exit;

                 until FRangeState.CheckState=rsInRange;

                 end
            else CheckValidRecord( False, Result );

          finally
            FInternalSeekProcess := False;
            dsEndBusy;
            end;

          end;
end;

function TnxeTable.KeyFieldCount( KeyBuffer : PnxDataSetKeyBuffer ) : integer;
begin
     Result := KeyBuffer^.kbFieldCount;
     If   Result=0
     then Result := Length( idIndexFieldMap );
     If   KeyBuffer^.kbPartialLen>0
     then Dec( Result );
end;

function TnxeTable.GotoKeyValues( const KeyValues : TFieldValuesArray ) : Boolean;

var  KeyBuffer : PnxDataSetKeyBuffer;
     Status : TnxResult;
     FieldCount : Integer;

begin

     dsStartBusy;
     try

       try

         CursorPosChanged;
         FInternalSeekProcess := True;

         If   State<>dsSetKey
         then EditKey;

         SetFieldIndexValues( KeyValues );

         KeyBuffer := idGetKeyBuffer( kiLookup );

         idBeforeGetRecordForKey;

      try

           FieldCount := KeyBuffer^.kbFieldCount;
           if FieldCount = 0 then
             FieldCount := Length(idIndexFieldMap);
           if KeyBuffer^.kbPartialLen > 0 then
             Dec(FieldCount);

           If   not dsNoCMR
           then dsAbstractCursor.AddCursorOption( acoRecordGetForKeyFollowedByRecordGet );

           try
             Result := idGetRecordForKey( dsAbstractCursor,
                                          FieldCount,
                                          KeyBuffer^.kbPartialLen,
                                          idIndexDirectKey,
                                          Pointer( TnxRecordBuffer( KeyBuffer ) + SizeOf( TnxDataSetKeyBuffer ) ),
                                          nil )=DBIERR_NONE;
           finally
             dsAbstractCursor.RemoveCursorOption( acoRecordGetForKeyFollowedByRecordGet );
             end;

         finally
           idAfterGetRecordForKey;
           end;

         If   Result
         then begin
              SetState( dsBrowse );
              Resync( [ rmExact, rmCenter ] );
              end;

      finally
         FInternalSeekProcess := False;
         end;
     finally
       dsEndBusy;
       end;
end;

{
function TnxeTable.InternalFindKey(       SearchCond  : TnxSearchKeyAction;
                                    const KeyValues   : TFieldValuesArray = nil;
                                          OnGetRecord : TDataSetInternalEvent = nil ) : Boolean;

var  KeyBuffer : PnxKeyBuffer;
     Status : TnxResult;

begin
     try
       CursorPosChanged;
       FInternalSeekProcess := True;
       SetCurrentSearchKeyAction( SearchCond );

       If   Assigned( KeyValues )
       then setFieldIndexValues( KeyValues );

       KeyBuffer := idGetKeyBuffer( kiLookup );
       Status := dsAbstractCursor.SetToKey( SearchCond,
                                            KeyFieldCount( KeyBuffer ),
                                            KeyBuffer^.kbPartialLen,
                                            idIndexDirectKey,
                                            Pointer( TnxRecordBuffer( KeyBuffer ) + SizeOf( TnxKeyBuffer ) ) );

       If   Status=DBIERR_NX_FilterTimeout
       then If   not dsCancelServerFilter
            then If   dsFlipOrder
                 then Status := dsGetPriorRecord( nxltNoLock, nil )
                 else Status := dsGetNextRecord( nxltNoLock, nil );

       Result := Status=DBIERR_NONE;

       If   Result
       then begin
            Resync( [ rmCenter ] );
            SetState( dsBrowse );
            If   Assigned( OnGetRecord )
            then OnGetRecord( Result );
            end;

     finally
       FInternalSeekProcess  := False;
       end;

end;
}

procedure TnxeTable.MasterChanged;
begin
     idMasterChanged(nil);
end;

function TnxeTable.dsGetActiveBuffer( var ABuffer : TnxRecordBuffer ): Boolean;
begin
     If   FInternalSeekProcess and not ( State=dsSetKey )
     then begin
          ABuffer := FCurrentBuffer;
          Result  := True;
          end
     else Result := inherited dsGetActiveBuffer( ABuffer );
end;

procedure TnxeTable.InternalEdit;
begin
     If   not FSettingKey   // No intento leer el registro cuando voy a entrar en modo dsSetKey
     then If   FCanEdit and CanEditRecord
          then inherited;
end;

procedure TnxeTable.Update;

var FieldIndexValues : TFieldValuesArray;

begin
     If   not FUpdatingProcess
     then If   ( State=dsInsert ) or ( ( State=dsEdit ) and Modified )
          then try
                 FUpdatingProcess := True;

                 If   RemoteEdit
                 then try // Intercepto la excepción porque las ediciones remotas no producen un error que pueda ser manejado por OnPostError
                        FieldIndexValues := GetFieldIndexValues;
                        Post;
                        If   GotoKeyValues( FieldIndexValues )
                        then begin
                             DoOnReadRecord;
                             Edit;
                             end
                        else dsError( DBIERR_NOCURRREC );
                      except on E : EnxBaseException do
                        begin
                        ShowDatabaseError( Self, E );                        
                        Cancel;                       
                        Abort;
                        end
                      else raise;
                      end
                 else begin
                      Post;
                      Edit;
                      end;

               finally
                 FUpdatingProcess := False;
                 end;
end;

function TnxeTable.CheckDetailDataSets( Posting : Boolean = False ) : Boolean;

var  DataSetList : TList<TDataset>;
     Dataset : TDataset;
     IDataset : InxeDataset;

begin

     //** 20.01.2010 Añadido el evento de comprobación alternativo

     If   Assigned( FOnCheckDetailDatasets )
     then Result := FOnCheckDetailDatasets( Self, Posting )
     else begin

          Result := True;

          DataSetList := TList<TDataset>.Create;
          try
            GetDetailDataSets( DataSetList );
            For Dataset in DataSetList do
              If   Dataset is TnxDataSet
              then begin
                   Dataset.GetInterface( InxeDataset, IDataset );
                   If   Assigned( IDataset )
                   then With Dataset do
                          If   IDataset.MasterRelation=mrTied
                          then begin
                               If   Posting and ( State in [ dsEdit, dsInsert ] )
                               then Post
                               else Cancel;
                               First;
                               If   Eof // RecordCount=0  Da errores esporádicos (al menos con NexusDB 2.0706 y anteriores)
                               then begin
                                    Result := False;
                                    Exit;
                                    end;
                               end;
              end;
          finally
            DataSetList.Free;
            end;

          end;
end;

procedure TnxeTable.InternalInsert;
begin
     If   ( RecordCount<>0 ) and not FCanInsert
     then Abort;
          {
          If   FCanEdit
          then Abort
          else raise EDatabaseError.Create( RsMsg4 );
          }
     inherited;
end;

procedure TnxeTable.DeleteRangeRecords( const AStartValues,
                                              AEndValues    : array of const;
                                              Raw           : Boolean = False );
begin
     try
       SetRange( AStartValues, AEndValues );
       DeleteRecords( Raw );
     finally
       CancelRange;
       end;
end;

procedure TnxeTable.DeleteRecords( Raw : Boolean = False );
begin

     If   Raw
     then inherited DeleteRecords
     else begin

          // La función DeleteRecords de Nexus se realiza en el servidor y no provoca los eventos necesarios por cada registero borrado

         try
           DisableControls;
           First;
           While not Eof do
             Delete;
         finally
           EnableControls;
           end;

         end;
end;

function TnxeTable.DeleteMasterRecord : Boolean;

var  DetailDatasets : array of TnxTable;

type TDetailDatasetCall = reference to procedure( Dataset : TnxTable );

procedure DoTiedDetailDatasets( DetailDatasetCall : TDetailDatasetCall );

var  DatasetList : TList<TDataset>;
     Dataset : TDataset;
     IDataset : InxeDataset;

begin
     DatasetList := TList<TDataset>.Create;
     try
       GetDetailDataSets( DatasetList );
       For Dataset in DatasetList do
         begin
         Dataset.GetInterface( InxeDataset, IDataset );
         If   Assigned( IDataset ) and ( IDataset is TnxTable )
         then If   IDataset.MasterRelation=mrTied
              then DetailDatasetCall( TnxTable( IDataset ) );
         end;

     finally
       DatasetList.Free;
       end;
end;

begin
     If   FRemoteEdit
     then begin
          Delete;
          Result := True;
          end
     else try
          FDeletingMasterRecord := True;
          Result := False;
          try

            try

              DetailDatasets := [];
              DoTiedDetailDatasets( procedure( Table : TnxTable )
                                    begin
                                    DetailDatasets := DetailDatasets + [ Table ];
                                    end );

              DetailDatasets := DetailDatasets + [ Self ];
              Database.StartTransactionWith( DetailDatasets );

              DisableControls;

              DoOnCloseRecord;

              // La función BeforeDelete se ejecuta antes de borrar los registros de los datasets de detalle para
              // poder realizar comprobaciones previas. En el Delete posterior no se llama a la función porque en ella
              // se comprueba que el flag FDeletingMasterRecord no esté activado (TnxeTable.DoBeforeDelete)

              If   Assigned( BeforeDelete )
              then BeforeDelete( Self );

              DoTiedDetailDatasets( procedure( Table : TnxTable )
                                    begin
                                    Table.DeleteRecords;
                                    end );

              Delete;
              Database.Commit;
              Result := True;

            except
              Database.Rollback;
              raise;
              end;

          finally
            EnableControls;
            end;

       finally
        FDeletingMasterRecord := False;
        end;

end;

procedure TnxeTable.SetRange( const AValues : array of const );
begin
     SetRange( AValues, AValues );
end;

procedure TnxeTable.SetReadOnly(const Value: Boolean);
begin
     ReadOnly := Value;
end;

procedure TnxeTable.SaveRange( var SavedRangeStart : Pointer;
                               var SavedRangeEnd   : Pointer );
begin
     SavedRangeStart := nxGetMem( idKeyBufferSize );
     nxMove( idKeyBuffers[ kiCurRangeStart ]^, SavedRangeStart^, idKeyBufferSize );
     SavedRangeEnd := nxGetMem( idKeyBufferSize );
     nxMove( idKeyBuffers[ kiCurRangeEnd ]^, SavedRangeEnd^, idKeyBufferSize );
end;

procedure TnxeTable.SaveRange;
begin
     SaveRange( FSavedRangeStart, FSavedRangeEnd );
     FRangeRestored := False;
end;

procedure TnxeTable.RestoreRange( var SavedRangeStart : Pointer;
                                  var SavedRangeEnd   : Pointer );
begin
     CheckBrowseMode;

     If   Assigned( SavedRangeStart )
     then nxMove( SavedRangeStart^, idKeyBuffers[ kiRangeStart ]^, idKeyBufferSize);
     If   Assigned( SavedRangeEnd )
     then nxMove( SavedRangeEnd^, idKeyBuffers[kiRangeEnd]^, idKeyBufferSize );

     idSetCursorRange( { aFollowedByFirst } True );

     nxFreeMem( SavedRangeStart );
     nxFreeMem( SavedRangeEnd );
end;

procedure TnxeTable.RestoreRange( SetRangeRestored : Boolean = True );
begin
     RestoreRange( FSavedRangeStart, FSavedRangeEnd );
     FRangeRestored := SetRangeRestored;
end;

procedure TnxeTable.RestoreState(const Value: TDataSetState);
begin
     inherited;
end;

function TnxeTable.UpdateRange : Boolean;

var  Bm : TBookMark;

begin
     Result := False;
     Cancel;
     If   FRangeRestored
     then begin
          FRangeRestored := False;
          If   IsKeyInRange
          then begin
               Bm := GetBookMark;
               ApplyRange;
               GotoBookMark( Bm );
               end
          else ApplyRange;
          Result := True;
          end;
end;

procedure TnxeTable.SetDefaultRangeValues( RangeStart, RangeEnd : array of Variant );

var  Inx : SmallInt;

begin
     SetLength( FRangeStartValues, High( RangeStart ) + 1 );
     For Inx := 0 to High( RangeStart ) do
       FRangeStartValues[ Inx ] := RangeStart[ Inx ];
     SetLength( FRangeEndValues, High( RangeEnd ) + 1 );
     For Inx := 0 to High( RangeEnd ) do
       FRangeEndValues[ Inx ] := RangeEnd[ Inx ];
end;

function TnxeTable.SetKeyRange( ARangeValues  : array of Variant;
                                ApplyRangeNow : Boolean = True ) : Boolean;

procedure SetKeyFields( AKeyIndex : TnxKeyIndex );

var  SaveState : TDataSetState;
     Inx : Integer;

begin
  SaveState := SetTempState(dsSetKey);
  try
    idKeyBuffer := idInitKeyBuffer( idKeyBuffers[ AKeyIndex ] );
    try

      For Inx := 0 to High( ARangeValues ) do
        If   VarType( ARangeValues[ Inx ] )=varEmpty
        then begin
             If   AKeyIndex=kiRangeStart
             then begin
                  If   Inx<=High( FRangeStartValues )
                  then IndexFields[ Inx ].Value := FRangeStartValues[ Inx ]
                  else SetMinFieldValue( IndexFields[ Inx ] );
                  end
             else begin
                  If   Inx<=High( FRangeEndValues )
                  then IndexFields[ Inx ].Value := FRangeEndValues[ Inx ]
                  else SetMaxFieldValue( IndexFields[ Inx ] );
                  end;
             end
        else IndexFields[ Inx ].Value := ARangeValues[ Inx ];

      idKeyBuffer^.kbFieldCount := High( ARangeValues );
      idKeyBuffer^.kbExclusive := False;
      idKeyBuffer^.kbModified := Modified;
      idKeyBuffer^.kbPartialLen := 0;
    finally
      idKeyBuffer := nil;
    end;
  finally
    RestoreState( SaveState );
  end;
end;

begin
     CheckBrowseMode;
     SetKeyFields( kiRangeStart );
     SetKeyFields( kiRangeEnd );

     // Si el rango ya había sido fijado y no ha cambiado, no se vuelve a fijar en idSetCursorRange, y la función devuelve False

     Result := idSetCursorRange( { aFollowedByFirst } ApplyRangeNow );
     If   Result and ApplyRangeNow
     then First;
end;

function TnxeTable.SetDefaultKeyRange( ApplyRangeNow : Boolean = True ) : TFieldValuesArray;

var  Inx : SmallInt;
     RangeValues : TFieldValuesArray;

begin
     SetLength( RangeValues, IndexFieldCount );
     For Inx := 0 to IndexFieldCount - 1 do
       RangeValues[ Inx ] := UnAssigned;
     SetKeyRange( RangeValues, ApplyRangeNow );
     Result := RangeValues;
end;

// Una copia idéntica del registro actual con una clave diferente

procedure TnxeTable.CloneRecord( const KeyValues : array of const );

var  FieldValues : TFieldValuesArray;

begin
     try
       DisableControls;
       CheckBrowseMode;
       FieldValues := GetFieldValues;
       Append;
       SetFieldValues( FieldValues );
       SetIndexValues( FieldValuesArray( KeyValues ) );
       Post;
     finally
       EnableControls;
       end;
end;

function TnxeTable.GetCanEditRecord : Boolean;
begin
     If   Assigned( FOnCanEditRecord )
     then Result := FOnCanEditRecord( Self )
     else Result := True;
end;

function TnxeTable.GetRecord( ABuffer  : TnxRecordBuffer;
                              AGetMode : TGetMode;
                              ADoCheck : Boolean ) : TGetResult;
begin
     FCurrentBuffer := ABuffer;
     Result := inherited GetRecord( ABuffer, AGetMode, ADoCheck );
     If   Result=grOk
     then Result := CheckSearchRecord( AGetMode );
     SetFound( Result=grOk );
     FCheckSearchAction := False;
end;

function TnxeTable.GetRemoteCursorID : TnxCursorID;
begin
     Result := TnxRemoteCursor( AbstractCursor ).RemoteID;
end;

function TnxeTable.SameKeyFields( AKeyValues  : array of Variant;
                                  LastSegment : SmallInt = -1 ) : Boolean;

var  Inx : SmallInt;

begin
     Result := False;
     If   ( High( AKeyValues )<IndexFieldCount ) and ( LastSegment<IndexFieldCount )
     then begin
          If   LastSegment=-1
          then LastSegment := High( AKeyValues );
          For Inx := 0 to LastSegment do
            If   IndexFields[ Inx ].Value<>AKeyValues[ Inx ]
            then Exit;
          Result := True;
          end;
end;

function TnxeTable.SameKeyFields( const AKeyValues  : array of const;
                                        LastSegment : SmallInt = -1 ) : Boolean;

var  Inx : SmallInt;

begin
     Result := False;
     If   ( High( AKeyValues )<IndexFieldCount ) and ( LastSegment<IndexFieldCount )
     then begin
          If   LastSegment=-1
          then LastSegment := High( AKeyValues );
          For Inx := 0 to LastSegment do
            If   IndexFields[ Inx ].Value<>VarRecToVariant( AKeyValues[ Inx ] )
            then Exit;
          Result := True;
          end;
end;

procedure TnxeTable.InternalPost;
begin
     If   FRemoteEdit and
          not FShiftingRecords and
          not ControlsDisabled
     then DoOnRemotePost
     else inherited;
end;

procedure TnxeTable.InternalPrepareKeyFields( const AKeyValues : array of const );
begin
     CheckBrowseMode;
     idSetKeyFields( kiLookup, AKeyValues, EmptySetKeyOptions );
end;

function  TnxeTable.FindGreater( const AKeyValues : array of const ) : Boolean;
begin
     InternalPrepareKeyFields( AKeyValues );
     Result := GotoRecord( skaGreater );
end;

function  TnxeTable.FindGreaterOrEqual( const AKeyValues : array of const ) : Boolean;
begin
     InternalPrepareKeyFields( AKeyValues );
     Result := GotoRecord( skaGreaterEqual );
end;

function  TnxeTable.FindSmaller( const AKeyValues : array of const ) : Boolean;
begin
     InternalPrepareKeyFields( AKeyValues );
     Result := GotoRecord( skaSmaller );
end;

function  TnxeTable.FindSmallerOrEqual( const AKeyValues : array of const ) : Boolean;
begin
     InternalPrepareKeyFields( AKeyValues );
     Result := GotoRecord( skaSmallerEqual );
end;

{ Para emular a los antiguos getFirstAtLeastEqual y getLastAtLeastEqual hay que poner el
 valor mínimo o máximo del campo variable en el último segmento de la clave.

 Por ejemplo : último asiento del ejercicio 2005 -> FindEqualLast( [ 2005, 99999999 ] )
               primer asiento del 2006 -> FindEqualFirst( [ 2006, 1 ] )
}

procedure TnxeTable.FillSegments( FromSegment : SmallInt;
                                  MaxValues   : Boolean );

var  SaveState : TDataSetState;
     Inx : SmallInt;

begin
     SaveState := SetTempState( dsSetKey );
     try
       idKeyBuffer := idGetKeyBuffer( kiLookup );   // No hay que limpiarlo
       try
         If   FromSegment<IndexFieldCount
         then For Inx := FromSegment to IndexFieldCount - 1 do
                If   MaxValues
                then SetMaxFieldValue( IndexFields[ Inx ] )
                else SetMinFieldValue( IndexFields[ Inx ] );
       finally
         idKeyBuffer := nil;
         end;
     finally
       RestoreState( SaveState );
       end;
end;

function TnxeTable.FindEqualFirst( const AKeyValues : array of const ) : Boolean;

var  LastComparableSegment : SmallInt;

begin
     Result := False;
     LastComparableSegment := High( AKeyValues );
     InternalPrepareKeyFields( AKeyValues );
     FillSegments( LastComparableSegment + 1, False );
     If   GotoRecord( skaGreaterEqual )
     then If   not SameKeyFields( AKeyValues, LastComparableSegment )
          then begin
               ClearBuffers;
               ResetFound;
               end
          else Result := True;
end;

function TnxeTable.FindEqualLast( const AKeyValues : array of const ) : Boolean;

var  LastComparableSegment : SmallInt;

begin
     Result := False;
     LastComparableSegment := High( AKeyValues );
     InternalPrepareKeyFields( AKeyValues );
     FillSegments( LastComparableSegment + 1, True );
     If   GotoRecord( skaSmallerEqual )
     then If   not SameKeyFields( AKeyValues, LastComparableSegment )
          then begin
               ClearBuffers;
               ResetFound;
               end
          else Result := True;
end;

procedure TnxeTable.CopyIndexValues( SourceTable : TnxDataSet );

var  Inx : SmallInt;

begin
     For Inx := 0 to Pred( IndexFieldCount ) do
       IndexFields[ Inx ].Value := SourceTable.FieldByName( IndexFields[ Inx ].FieldName ).Value;
end;

procedure TnxeTable.CopyFieldValues( SourceTable             : TnxDataSet;
                                     ExcludeIndexFields      : Boolean = False;
                                     IgnoreNonExistentFields : Boolean = False );

var  Inx : SmallInt;
     SourceFieldName : String;
     SourceField : TField;

begin
     For Inx := 0 to Pred( FieldCount ) do
       If   not ( ExcludeIndexFields and Fields[ Inx ].IsIndexField )
       then begin
            SourceFieldName := Fields[ Inx ].FieldName;
            SourceField := SourceTable.FindField( SourceFieldName );
            If   Assigned( SourceField )
            then Fields[ Inx ].Value := SourceField.Value
            else If   not IgnoreNonExistentFields
                 then DatabaseErrorFmt( SFieldNotFound, [ SourceFieldName ], Self );
            end;
end;

procedure TnxeTable.SetKeyValues( const AKeyValues : array of const );
begin
     idSetKeyFields( kiLookup, AKeyValues, EmptySetKeyOptions );
end;

procedure TnxeTable.SetKeyValues( FieldValues : TFieldValuesArray );
begin
     SetKeyValues( kiLookup, FieldValues );
end;

procedure TnxeTable.SetKeyValues( AKeyIndex   : TnxKeyIndex ;
                                  FieldValues : TFieldValuesArray );

var  SaveState : TDataSetState;
     Inx : Integer;

begin
    SaveState := SetTempState( dsSetKey );
    try
      idKeyBuffer := idInitKeyBuffer( idKeyBuffers[ AKeyIndex ] );
      try
        For Inx := 0 to Pred( IndexFieldCount ) do
          IndexFields[ Inx ].Value := FieldValues[ Inx ];
      finally
        idKeyBuffer := nil;
        end;
    finally
      RestoreState( SaveState );
      end;
end;

function TnxeTable.GetKeyValues : TFieldValuesArray;
begin
     Result := GetKeyValues( kiLookUp );
end;

function TnxeTable.GetIndexFields : TFieldsArray;
begin
     SetLength( Result, IndexFieldCount );
     For var Inx := 0 to Pred( IndexFieldCount ) do
       Result[ Inx ] := IndexFields[ Inx ];
end;
procedure TnxeTable.GetIndexFields( FieldList : TList );
begin
     For var Inx := 0 to Pred( IndexFieldCount ) do
       FieldList.Add( IndexFields[ Inx ] );
end;

function TnxeTable.GetKeyValues( AKeyIndex : TnxKeyIndex ) : TFieldValuesArray;

var  // SaveState : TDataSetState;
     Inx : SmallInt;

begin
     SetLength( Result, IndexFieldCount );
     For Inx := 0 to Pred( IndexFieldCount ) do
       Result[ Inx ] := IndexFields[ Inx ].Value;
    {
    SaveState := SetTempState( dsSetKey );
    try
      idKeyBuffer := idInitKeyBuffer( idKeyBuffers[ AKeyIndex ] );
      try
        SetLength( Result, IndexFieldCount );
        For Inx := 0 to Pred( IndexFieldCount ) do
          Result[ Inx ] := IndexFields[ Inx ].Value;
      finally
        idKeyBuffer := nil;
        end;
    finally
      RestoreState( SaveState );
      end;
    }
end;

function TnxeTable.GetDataValues : TFieldValuesArray;

var  Inx : SmallInt;

begin
     SetLength( Result, FieldCount );
     For Inx := 0 to Pred( FieldCount ) do
       If   not Fields[ Inx ].IsIndexField
       then Result[ Inx ] := Fields[ Inx ].Value;
end;

procedure TnxeTable.SetDataValues( FieldValues : TFieldValuesArray );

var  Inx : SmallInt;

begin
     For Inx := 0 to Pred( FieldCount ) do
       If   not Fields[ Inx ].IsIndexField
       then Fields[ Inx ].Value := FieldValues[ Inx ];
end;

function TnxeTable.GetIndexValues : TFieldValuesArray;

var  Inx : SmallInt;

begin
     SetLength( Result, IndexFieldCount );
     For Inx := 0 to Pred( IndexFieldCount ) do
       Result[ Inx ] := IndexFields[ Inx ].Value;
end;

procedure TnxeTable.SetIndexValues( FieldValues             : TFieldValuesArray;
                                    CheckNumericFieldsRange : Boolean = False;
                                    SkipSegment             : SmallInt = -1 );

var  Inx : SmallInt;
     IndexField : TField;

begin
     For Inx := 0 to Pred( IndexFieldCount ) do
       If   Inx<>SkipSegment
       then begin
            IndexField := IndexFields[ Inx ];

            If   CheckNumericFieldsRange
            then begin
                 // TIntegerField incluye TSmallIntField, TShortIntField y TByteField
                 If   IndexField is TIntegerField
                 then begin
                      var IntegerField := TIntegerField( IndexField );
                      If   not ( ( IntegerField.MinValue=0 ) and ( IntegerField.MaxValue=0 ) )
                      then If   ( FieldValues[ Inx ]<IntegerField.MinValue ) or ( FieldValues[ Inx ]>IntegerField.MaxValue )
                           then Continue;
                      end;
                 end;

            IndexFields[ Inx ].Value := FieldValues[ Inx ];
            end;
end;

procedure TnxeTable.CopyRecords( SourceTable      : TnxDataSet;
                                 ACopyBLOBs       : Boolean;
                                 BeforePostRecord : TCopyRecordsPostEvent = nil;
                                 AMaxTransSize    : Integer = 0 );

var PostRecord : Boolean;

begin

     // BlockReadSize no se puede activar por defecto en una tabla o consulta porque produce errores (probablemente no esté diseñado para eso)
     // La forma correcta es hacerlo en un proceso secuencial y delimitado como el siguiente.

     If   ( SourceTable.Session=Session ) and not Assigned( BeforePostRecord )
     then inherited CopyRecords( SourceTable, ACopyBLOBs, AMaxTransSize )
     else begin
          SetUnidirectional( True );

          Open;
          SourceTable.BlockReadSize := 6 * 1024 * 1024;  // 6MB
          SourceTable.First;
          While not SourceTable.Eof do
            begin
            Append;
            CopyFields( SourceTable );
            If   Assigned( BeforePostRecord )
            then PostRecord := BeforePostRecord( SourceTable, Self )
            else PostRecord := True;
            If   PostRecord
            then Post
            else Cancel;
            SourceTable.Next;
            end;

          SourceTable.BlockReadSize := 0;

          SetUnidirectional( False );
          Resync( [] );
          end;
end;

// PostRecord es una versión de Post que permite comprobar si ha finalizado correctamente sin lanzar una excepción

function TnxeTable.PostRecord( CancelOnError : Boolean = True ) : Integer;
begin
     try
       FFailOnError := True;
       Result := DBIERR_NONE;
       try
         Post;
       except on E : EnxDatabaseError do
                begin
                If   CancelOnError
                then Cancel;
                Result := E.ErrorCode;
                end
           else raise;
         end;
     finally
       FFailOnError := False;
       end;
end;

procedure TnxeTable.UnlockRecord;
begin
     InternalCancel;
end;

procedure TnxeTable.CopyAndAppendRecord( SourcerDataSet            : TnxDataSet;
                                         RaiseExceptionOnDuplicate : Boolean = True;
                                         ExcludeKeyFields          : Boolean = False );
begin
     try
       FFailOnError := True;
       try
         If   not ExcludeKeyFields
         then Append;
         CopyFieldValues( SourcerDataSet, ExcludeKeyFields );
         Post;
       except on E : Exception do
                begin
                Cancel;
                If   E is EnxDatabaseError
                then begin
                     If   RaiseExceptionOnDuplicate or ( EnxDatabaseError( E ).ErrorCode<>DBIERR_KEYVIOL )
                     then raise;
                     end
                else begin
                     ShowException( E, Self );
                     raise;
                     end;
                end;
         end;
     finally
       FFailOnError := False;
       end;
end;

{
procedure TnxeTable.SaveCurrentRecord( var RecordBuffer : TnxRecordBuffer );
begin
     RecordBuffer := AllocRecordBuffer;
     If   Assigned( RecordBuffer )
     then Move( ActiveBuffer^, RecordBuffer^, dsRecordBufferSize);
end;

procedure TnxeTable.RestoreSavedRecord( var RecordBuffer : TnxRecordBuffer;
                                            FreeRecord   : Boolean = False );
begin
     If   Assigned( RecordBuffer )
     then begin
          Move( RecordBuffer^, ActiveBuffer^, dsRecordBufferSize );
          If   FreeRecord
          then FreeSavedRecord( RecordBuffer );
          end;
end;

procedure TnxeTable.FreeSavedRecord( var RecordBuffer : TnxRecordBuffer );
begin
     If   Assigned( RecordBuffer )
     then FreeRecordBuffer( RecordBuffer );
     RecordBuffer := nil;
end;
}

procedure TnxeTable.DataEvent( Event : TDataEvent;
                               Info  : NativeInt );
begin

     If   FBlockDataEvents
     then Exit;

     case Event of
       deUpdateState     : If   not ( csDestroying in ComponentState )
                           then begin
                                FInserting := ( State=dsInsert ) or UpdatingProcess;
                                If   FFireEditionEvents
                                then DoOnUpdateState;
                                FPreviousState := State;
                                end;
       end;

     inherited;

     case Event of
       deDataSetChange,
       deDataSetScroll,
       deLayoutChange    : If   FFireEditionEvents and
                                not ControlsDisabled and
                                not UpdatingProcess
                           then begin
                                If   ( Event=deDataSetChange ) and ( State=dsSetKey )
                                then DoOnSetKey;
                                DoOnReadRecord;
                                end;

       deRecordChange    : ;

       dePropertyChange  : PropertyChanged;
       end;

     If   Assigned( FOnDataEvent )
     then FOnDataEvent( Event, Info );

end;

procedure TnxeTable.DoOnReadRecord;
begin
     If   ReadableRecord
     then DoOnGetRecord;
     If   not InternalProcess
     then DoOnRecordChanged;
end;

procedure TnxeTable.SetKey;
begin
     try
       FSettingKey := True;
       inherited SetKey;
       DoOnSetKey;
     finally
       FSettingKey := False;
       end;
end;

procedure TnxeTable.EditKey;
begin
     try
       FSettingKey := True;
       inherited EditKey;
       DoOnSetKey;
     finally
       FSettingKey := False;
       end;
end;

procedure TnxeTable.Post;
begin
     If   State<>dsSetKey
     then inherited Post
     else try
            FPostingKeyBuffer := True;
            idPostKeyBuffer( True );
          finally
            FPostingKeyBuffer := False;
            end;
end;

procedure TnxeTable.Cancel;

procedure CancelDetailDataSets;

var  DataSetList : TList<TDataset>;
     Dataset : TDataset;

begin
     DataSetList := TList<TDataset>.Create;
     try
       GetDetailDataSets( DataSetList );
       For Dataset in DataSetList do
         Dataset.Cancel;
     finally
       DataSetList.Free;
       end;
end;

begin
     If   not ( csDestroying in ComponentState )
     then begin
          If   Editing // State in [ dsEdit, dsInsert ]
          then CancelDetailDataSets;
          inherited;
          end;
end;

procedure TnxeTable.CancelRange;
begin
     Cancel;
     inherited CancelRange;
end;

procedure TnxeTable.CheckRecord;
begin
     CheckSearchRecord( gmNext );
end;

procedure TnxeTable.OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );
begin
     DoOpenDetailDataSets( Self, OnOpenDetailDataset );
end;

procedure TnxeTable.ApplyMasterRange;
begin
     dsApplyMasterRange( { aFollowedByFirst } True );
end;

// Browse equivale a un Cancel sin ningún intento de guardar el registro o la clave

procedure TnxeTable.Browse;

procedure CancelNestedDataSets;

var  I: Integer;

begin
     If   Assigned( NestedDataSets )
     then for I := 0 to NestedDataSets.Count - 1 do
            With TDataSet( NestedDataSets[ I ] ) do
              If   Active
              then Cancel;
end;

begin
     CancelNestedDataSets;
     If   not FSettingKey
     then InternalCancel;  //* 07.12.2010  Esto libera cualquier posible bloqueo del registro (si está, por ejemplo, en dsEdit)
     DoOnCloseRecord;
     FreeFieldBuffers;
     SetState( dsBrowse );
     DataEvent( deRecordChange, 0 );
     SetFound( True );
end;

procedure TnxeTable.RefreshAndEdit;
begin
     DisableControls;
     try
       Browse;
       Refresh;
       Edit;
     finally
       EnableControls;
       end;
end;

function TnxeTable.ReloadRecord( DisableCtrls : Boolean = False ) : Boolean;

var FieldIndexValues : TFieldValuesArray;

begin
     Result := False;
     try

        If   DisableCtrls
        then DisableControls;

        FieldIndexValues := GetFieldIndexValues;

        If   RangeRestored
        then begin
             If   IsKeyInRange
             then Result := UpdateRange
             else try
                    SaveRange;
                    CancelRange;
                    Result := GotoKeyValues( FieldIndexValues );
                  finally
                    RestoreRange;
                    end;
             end
        else Result := GotoKeyValues( FieldIndexValues );

        If   Result
        then DoOnReadRecord
        else Last;

      finally
        If   DisableCtrls
        then EnableControls;
        end;
end;

procedure TnxeTable.RemoveField( FieldName : String );

var  AField : TField;

begin
     AField := Fields.FieldByName( FieldName );
     If   Assigned( AField )
     then Fields.Remove( AField );
end;

function TnxeTable.HasNestedDatasets : Boolean;
begin
     Result := NestedDataSets.Count>0;
end;

procedure TnxeTable.WriteMemoBuffer(       AField  : TField;
                                     const Buffer;
                                           Count   : Longint );
begin
     With CreateBlobStream( AField, bmWrite ) do
       try
         WriteBuffer( Buffer, Count );
       finally
         Free;
         end;
end;

function TnxeTable.ReadMemoBuffer(     AField     : TField;
                                   var Buffer;
                                       BufferSize : Longint ) : LongInt;
begin
     With CreateBlobStream( AField, bmRead ) do
       try
          Result := Read( Buffer, BufferSize );
          If   Result=0
          then FillChar( Buffer, BufferSize, #0 );
       finally
         Free;
         end;
end;

procedure TnxeTable.DoOnSetKey;
begin
     If   Assigned( FOnSetKey )
     then FOnSetKey( Self );
end;

procedure TnxeTable.DoOnGetRecord;
begin
     // FRangeRestored := False;
     If   Assigned( FOnGetRecord )
     then FOnGetRecord( Self );
end;

procedure TnxeTable.DoOnRecordChanged;
begin
     // FRangeRestored := False;
     If   Assigned( FOnRecordChanged )
     then FOnRecordChanged( Self );
end;

procedure TnxeTable.DoOnRemoteDelete;
begin
     If   Assigned( FOnRemoteDelete )
     then FOnRemoteDelete( Self );
end;

procedure TnxeTable.DoOnRemotePost;
begin
     If   Assigned( FOnRemotePost )
     then FOnRemotePost( Self );
end;

procedure TnxeTable.DoOnOpenRecord;
begin
     If   not FRecordOpened and ( State=dsEdit )
     then begin
          If   Assigned( FOnOpenRecord )
          then FOnOpenRecord( Self );
          FRecordOpened := True;
          end;
end;

procedure TnxeTable.DoOnCloseRecord;
begin
     If   FRecordOpened and not FClosingRecord and ( State=dsEdit )
     then try
            FClosingRecord := True;
            If   Assigned( FOnCloseRecord ) and not InternalProcess
            then FOnCloseRecord( Self );
          finally
            FClosingRecord := False;
            end;
     FRecordOpened := False;
end;

procedure TnxeTable.DoOnUpdateState;
begin
     If   Assigned( FOnUpdateState )
     then FOnUpdateState( Self );
end;

function TnxeTable.GetFieldIndexOnKey( FieldNo : SmallInt ) : SmallInt;

var  I : Integer;

begin
     Result := -1;
     For I := Low( idIndexFieldMap ) to High( idIndexFieldMap ) do
       If   FieldNo=idIndexFieldMap[ I ]
       then begin
            Result := I;
            Exit;
            end;
end;

function TnxeTable.IsIndexField( Field : TField ) : Boolean;
begin
     Result := GetIsIndexField( Field );
end;

function TnxeTable.IsFieldIndexed( Field : TField ) : Boolean;

var  FieldDesc : TnxFieldDescriptor;

begin
     Result := False;
     FieldDesc := FieldsDescriptor.FieldDescriptor[ Pred( Field.FieldNo ) ];
     If   Assigned( FieldDesc )
     then Result := IsFieldOnIndex( FieldDesc, -1 );
end;

function TnxeTable.IsFieldOnIndex( FieldDesc   : TnxFieldDescriptor;
                                   IndexNumber : ShortInt ) : Boolean;

var   Inx,
      FirstIndex,
      LastIndex,
      InxNbr : SmallInt;
      InxDesc : TnxIndexDescriptor;
      KeyDesc : TnxCompKeyDescriptor;

begin
     Result := False;
     With DataDictionary do
       If   IndicesDescriptor.IndexCount>0
       then begin
            If   IndexNumber=-1
            then begin
                 FirstIndex := 1;
                 LastIndex  := IndicesDescriptor.IndexCount - 1;
                 end
            else begin
                 FirstIndex := IndexNumber + 1;
                 LastIndex  := IndexNumber + 1;
                 end;
            For InxNbr := FirstIndex to LastIndex do
              begin
              InxDesc := TnxIndexDescriptor( IndicesDescriptor.IndexDescriptor[ InxNbr ] );
              If   Assigned( InxDesc )
              then begin
                   KeyDesc := TnxCompKeyDescriptor( InxDesc.KeyDescriptor );
                   For Inx := 0 to KeyDesc.KeyFieldCount  - 1 do
                     If   KeyDesc.KeyFields[ Inx ].FieldNumber=FieldDesc.Number
                     then begin
                          Result := True;
                          Exit;
                          end;
                   end;
              end;
            end;
end;

function TnxeTable.SetTempState(const Value: TDataSetState): TDataSetState;
begin
     Result := inherited;
end;

procedure TnxeTable.ResetFound;
begin
     SetFound( False );
end;

function TnxeTable.SetToDatasetPos( Dataset : TnxDataset ) : Boolean;
begin
     try
       DisableControls;
       Cancel;
       SetKey;
       CopyIndexValues( Dataset );
       Result := GotoKey;
     finally
       EnableControls;
       end;
end;

function TnxeTable.HasBlobs : Boolean;

var   Inx  : SmallInt;

begin
     Result := False;
     If   Assigned( DataDictionary )
     then With DataDictionary do
            For Inx := 0 to FieldCount - 1 do
              With FieldsDescriptor.FieldDescriptor[ Inx ] do
                If   fdType in [ nxtBlob..nxtBLOBGraphic ]
                then begin
                     Result := True;
                     Exit;
                     end;
end;

procedure TnxeTable.SetCurrentSearchKeyAction( SearchCond : TnxSearchKeyAction );
begin
     FCurrentSearchKeyAction := SearchCond;
     FCheckSearchAction := True;  // Solo hasta el próximo GetRecord
end;

// No es más que un GotoNearest en el que se puede elegir la condición de búsqueda

function TnxeTable.GotoRecord( SearchCond : TnxSearchKeyAction ) : Boolean;

var  KeyBuffer : PnxDataSetKeyBuffer;
     Status : TnxResult;
     FieldCount : Integer;
     GetMode : TGetMode;

begin
     Result := False;

     dsCheckNotInOnFilterRecord;
     dsStartBusy;
     try

       CheckBiDirectional;

       CheckBrowseMode;

       try

         CursorPosChanged;

         SetCurrentSearchKeyAction( SearchCond );
         KeyBuffer := idGetKeyBuffer( kiLookup );

         idBeforeGetRecordForKey;
         try
           FieldCount := KeyBuffer^.kbFieldCount;
           If   FieldCount=0
           then FieldCount := Length( idIndexFieldMap );
           If   KeyBuffer^.kbPartialLen>0
           then Dec( FieldCount );

           If   not dsNoCMR and
                not dsInternalWriteOnly
           then dsAbstractCursor.AddCursorOption( acoSetToKeyFollowedBySync );
           try
             Status := dsAbstractCursor.SetToKey( SearchCond,
                                                  FieldCount,
                                                  KeyBuffer^.kbPartialLen,
                                                  idIndexDirectKey,
                                                  Pointer( TnxRecordBuffer( KeyBuffer ) + SizeOf( TnxDataSetKeyBuffer ) ) );
           finally
             dsAbstractCursor.RemoveCursorOption(acoSetToKeyFollowedBySync);
             end;

           If   Status=DBIERR_NX_FilterTimeout
           then If   not dsCancelServerFilter
                then Status := dsGetNextOrPriorRecord( dsFlipOrder, nxltNoLock, nil )

       finally
         idAfterGetRecordForKey;
         end;

       If   Status=DBIERR_NONE
       then begin

            If   SearchCond in [ skaSmaller, skaSmallerEqual, skaAnySmallerEqual ]
            then GetMode := gmPrior
            else GetMode := gmNext;

            If   GetRecord( FCurrentBuffer, GetMode, False )=grOk
            then begin
                 Resync( [ rmCenter ] );
                 DoAfterScroll;
                 Result := not IsEmpty;
                 end;

            end;

     finally
       dsInsideScroll := False;
       end;

     finally
       dsEndBusy;
       end;

  end;

procedure TnxeTable.CheckNullIndexValues;

var  Inx : SmallInt;
     AField : TField;

begin

     // No permito que en el área de clave existan nulos (con permiso de DontCheckNullIndexValues )

     If   not FDontCheckNullIndexValues and ( Editing or EditingKey )
     then For Inx := 0 to Pred( IndexFieldCount ) do
            begin
            AField := IndexFields[ Inx ];
            If   VarIsNull( AField.Value )
            then If   AField is TNumericField
                 then AField.Value := 0
                 else AField.AsString := '';
            end;

     // No es permante. Hay que fijarlo antes del Post y solo sirve para una vez.

     FDontCheckNullIndexValues := False;
end;

function TnxeTable.GetNextAutoIncValue : Variant;

{  Se utiliza una sentencia SQL del tipo :
   SELECT TOP 1 NroLinea
   FROM LineaMovimiento
   WHERE Ejercicio=2010 AND NroOperacion=903 AND NroPagina=0
   ORDER BY NroLinea DESC
}

var  Inx : SmallInt;
     SQLText,
     SQLFields : String;
     ResultField : TField;

begin
     Result := 0;
     If   Assigned( AutoIncField ) and ( IndexFields[ Pred( IndexFieldCount ) ].FieldName=AutoIncField.FieldName )
     then begin
          SQLText := 'SELECT TOP 1 ' + AutoIncFieldName + ' FROM '+ TableName;
          SQLFields := '';
          For Inx := 0 to IndexFieldCount - 2 do
            begin
            If   Inx=0
            then SQLFields := ' WHERE '
            else SQLFields := SQLFields + ' AND ';
            SQLFields := SQLFields + IndexFields[ Inx ].FieldName + '=' + SQLFieldValue( IndexFields[ Inx ] );
            end;
          SQLText := SQLText + SQLFields + ' ORDER BY ' + AutoIncField.FieldName + ' DESC';
          With Database.OpenQuery( SQLText, [] ) do
            try
              ResultField := FieldByName( AutoIncField.FieldName );
              If   Assigned( ResultField )
              then begin
                   Result := ResultField.Value;
                   If   Result<MinAutoIncValue
                   then Result := MinAutoIncValue
                   else If   Result>MaxAutoIncValue
                        then Result := MaxAutoIncValue
                        else Result := Result + 1;
                   end;
            finally
              Free;
              end;
          end;
end;

{
function TnxeTable.GetNewAutoIncValue : Integer;
begin
     Result := MinAutoIncValue;
     If   Assigned( FWorkTable )
     then With FWorkTable do
            begin
            Last;
            If   Eof
            then Result := MinAutoIncValue
            else If   AutoIncField.Value<MinAutoIncValue
                 then Result := MinAutoIncValue
                 else If   AutoIncField.Value>MaxAutoIncValue
                      then Result := MaxAutoIncValue
                      else Result := AutoIncField.Value + 1;
            end;
end;

}

function TnxeTable.GetNewAutoIncValue( IndexValues : TFieldValuesArray = nil ) : Variant;

var  Inx,
     NewValue : Integer;
     SavedState : TDataSetState;
     ValidRecord : Boolean;
     Segment : SmallInt;

begin

     NewValue := MinAutoIncValue;

     If  Assigned( AutoIncField ) and AutoIncField.IsIndexField
     then begin

          If   Assigned( FOnGetAutoIncValue )
          then NewValue := FOnGetAutoIncValue( Self )
          else begin

               Segment := GetFieldIndexOnKey( AutoIncField.FieldNo );

               CheckBrowseMode;

               If   not Assigned( IndexValues )
               then IndexValues := GetIndexValues;

               SavedState := SetTempState( dsSetKey );
               try
                 idKeyBuffer := idInitKeyBuffer( idKeyBuffers[ kiLookUp ] );
                 try

                   For Inx := 0 to Pred( IndexFieldCount ) do
                     If   Inx=Segment
                     then IndexFields[ Inx ].Value := MaxAutoIncValue
                     else If   Inx>Segment
                          then Null
                          else IndexFields[ Inx ].Value := IndexValues[ Inx ];

                   idKeyBuffer^.kbFieldCount := IndexFieldCount;
                   idKeyBuffer^.kbExclusive := False;
                   idKeyBuffer^.kbModified := True;
                   idKeyBuffer^.kbPartialLen := 0;

                 finally
                   idKeyBuffer := nil;
                   end;

               finally
                 RestoreState( SavedState );
                 end;

               ValidRecord := GotoRecord( skaSmallerEqual );
               If   ValidRecord and ( Segment>0 )
               then ValidRecord := SameKeyFields( IndexValues, Segment - 1 );

               If   ValidRecord
               then begin
                    If   AutoIncField.Value<MinAutoIncValue
                    then NewValue := MinAutoIncValue
                    else If   AutoIncField.Value>=MaxAutoIncValue
                         then raise Exception.Create( Format( RsMsg5, [ LongWord( AutoIncField.Value ) ] ) ) //* 19.09.2011 Opto por lanzar una excepción en lugar de devolver el valor máximo : NewValue := MaxAutoIncValue
                         else NewValue := AutoIncField.Value + 1;
                    end
               else NewValue := MinAutoIncValue;
               end;
        end;

     Result := NewValue;

end;

function TnxeTable.GetNewAutoIncStringValue( TemplateValue : String = '' ) : String;

var   St, LeftSt, RightSt : String;
      I, Cc, C1, C2, C3 : SmallInt;
      LastValue : Int64;
      CurrentSt,
      SearchSt : String;
      Eos, RecordFound : Boolean;

const SharpChar : Char = '#';

begin
     Result := '';
     If  Assigned( AutoIncField ) and AutoIncField.IsIndexField
     then try
            With DataDictionary do
              If   IndexFieldCount=1       // o sea, si hay un sólo segmento de clave
              then begin

                   CurrentSt := TemplateValue; // AutoIncField.Value;

                   St := CurrentSt;
                   Cc := Pos( SharpChar, St );
                                      
                   If   Cc=0
                   then begin
                        LeftSt := '';                        	
                        If   CurrentSt<>''
                        then If   CharInSet( CurrentSt[ 1 ], [ '0'..'9' ] ) 
                             then begin                                  
                                  If   ( Length( CurrentSt )<AutoIncField.Size )
                                  then LeftSt := CurrentSt;                                  
                                  end
                             else begin
                                  I := 1;
                                  var StLen := System.Length( CurrentSt );
                                  While ( I<=StLen ) and not CharInSet( CurrentSt[ I ], [ '0'..'9' ] ) do
                                    Inc( I );
                                  If   I>StLen
                                  then Exit;
                                  LeftSt := Copy( CurrentSt, 1, I - 1 );
                                  end;              
                        SearchSt := RightPad( LeftSt, AutoIncField.Size, '9' );
                        I := Length( LeftSt );
                        If   FindSmallerOrEqual( [ SearchSt ] )
                        then begin
                             CurrentSt := AutoIncField.AsAnsiString;
                             If   ( I=0 ) or ( Copy( CurrentSt, 1, I )=LeftSt )
                             then begin
                                  LastValue := StrToInt64( Copy( CurrentSt, I + 1, 255 ) ) + 1;
                                  If   System.Length( IntToStr( LastValue ) )>AutoIncField.Size
                                  then Exit;
                                  end
                             else LastValue := 1;
                             end
                        else LastValue := 1;

                        CurrentSt := LeftSt + StrIntPadded( LastValue, AutoIncField.Size - LeftSt.Length );
                        end
                   else begin
                        C1 := Cc;
                        While ( Cc<=Length( St ) ) and ( St[ Cc ]=SharpChar ) do
                          Inc( Cc );
                        C2 := Cc;
                        C3 := C2 - C1;
                        If   C3>0
                        then begin
                             LastValue := 0;
                             LeftSt := Copy( St,  1, C1 - 1 );
                             RightSt := Copy( St, C2, 255 );  // hasta el final
                             If   FindSmallerOrEqual( [ LeftSt + StrConst( C3, HighestChar ) + RightSt ] )
                             then begin
                                  Eos := False;
                                  CurrentSt := AutoIncField.AsAnsiString;
                                  RecordFound := ( Copy( CurrentSt,  1, C1 - 1 )=LeftSt ) and ( Copy( CurrentSt, C2, 255 )=RightSt );
                                  While not Eof and not Bof and not Eos and not RecordFound do
                                    begin
                                    If   Copy( CurrentSt,  1, C1 - 1 )=LeftSt  // segmento válido
                                    then Prior;
                                    CurrentSt := AutoIncField.AsAnsiString;
                                    If   not Bof
                                    then If   Copy( CurrentSt, 1, C1 - 1 )=LeftSt  // sigue siendo válido
                                         then RecordFound := ( RightSt='' ) or ( Copy( CurrentSt, C2, 255 )=RightSt )
                                         else Eos := True;
                                    end;

                                  If   RecordFound   // por fin !!!
                                  then begin
                                       St := Copy( CurrentSt, C1, C3 );
                                       If   ( St='' ) or not TryStrToInt64( St, LastValue )
                                       then LastValue := 1
                                       else LastValue := StrToInt( St ) + 1;
                                       end;

                                  end;
                             CurrentSt := LeftSt + StrIntPadded( LastValue, C3 ) + RightSt;
                             end;
                        end;

                   Result := CurrentSt;
                   end;
          except
            Result := '';
            end;

end;

procedure TnxeTable.NewAutoIncRecord( AppendRecord : Boolean = True );

var  NewValue : Integer;
     IndexValues : TFieldValuesArray;
     SavedState : TDataSetState;
     Segment : SmallInt;

begin
     If   ( State in [ dsBrowse, dsSetKey ] ) and Assigned( AutoIncField ) and AutoIncField.IsIndexField
     then begin

          FAutoIncValueEditState := State;
          FGettingNewAutoIncValue := True;

          Segment := -1;
          NewValue := -1;

          If   RecordCount=0
          then EditKey;

          Segment := GetFieldIndexOnKey( AutoIncField.FieldNo );

          If   State=dsBrowse
          then begin
               IndexValues := GetIndexValues;
               SavedState := SetTempState( dsSetKey );
               try
                 idKeyBuffer := idInitKeyBuffer( idKeyBuffers[ kiLookUp ] );
                   try
                      SetIndexValues( IndexValues, False, Segment );
                      DoOnSetKey;
                      IndexValues := GetIndexValues;
                   finally
                     idKeyBuffer := nil;
                     end;
               finally
                 RestoreState( SavedState );
                 end;
               end
          else begin
               DoOnSetKey;
               IndexValues := GetIndexValues;
               end;

          NewValue := GetNewAutoIncValue( IndexValues );

          If   AppendRecord
          then Append
          else begin
               ClearBuffers;
               SetKey;
               end;

          FGettingNewAutoIncValue := False;

          If   ( Segment<>-1 ) and ( NewValue<>-1 )
          then begin
               SetIndexValues( IndexValues, False, Segment );
               AutoIncField.Value := NewValue;
               end
          else Abort;

          end;
end;

procedure TnxeTable.DoAfterEdit;
begin
     If   Editing   // Se provoca también al editar la clave
     then begin
          inherited;
          DoOnOpenRecord;
          end;
end;

procedure TnxeTable.DoBeforePost;
begin
     CheckNullIndexValues;
     DoOnCloseRecord;
     inherited;
end;

procedure TnxeTable.DoBeforeCancel;
begin
     inherited;
     If   not IsDesignTime
     then DoOnCloseRecord;
end;

procedure TnxeTable.DoBeforeDelete;
begin
     If   not FDeletingMasterRecord
     then inherited;
end;

procedure TnxeTable.DoBeforeScroll;
begin
     inherited;
     ResetFound;
end;

procedure TnxeTable.DoOnNewRecord;
begin
     If   not FInternalAppendProcess and ( State=dsInsert )
     then inherited;
end;

// TnxeCachedDataset ---------------------------------------------------------------------------------------

procedure TnxeCachedDataSet.ApplyMasterRange;
begin
     dsApplyMasterRange( { aFollowedByFirst } True );
end;

constructor TnxeCachedDataset.Create(AOwner: TComponent);
begin
     inherited Create( AOwner );
     FMinAutoIncValue := 1;
     FMaxAutoIncValue := MaxSmallint;
     FMasterRelation := mrLoose;
     FOpenOnMasterActivation := True;
end;

procedure TnxeCachedDataset.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FAutoIncField
          then FAutoIncField := nil;
          end;
end;

procedure TnxeCachedDataset.Loaded;
begin
     inherited;
     SetDefaultErrorManager;
end;

procedure TnxeCachedDataset.SetDefaultErrorManager;
begin
     If   not Assigned( OnEditError )
     then OnEditError := DoOnDefaultError;
     If   not Assigned( OnPostError )
     then OnPostError := DoOnPostOrDeleteError;
     If   not Assigned( OnDeleteError )
     then OnDeleteError := DoOnPostOrDeleteError;
end;

procedure TnxeCachedDataset.DoOnDefaultError(     DataSet : TDataSet;
                                                  E       : EDatabaseError;
                                              var Action  : TDataAction );
begin
     If   FFailOnError
     then Action := daFail
     else If   Assigned( OnDatabaseError )
          then begin
               OnDatabaseError( DataSet, E );
               Action := daAbort;
               end;
end;

procedure TnxeCachedDataset.DoOnPostOrDeleteError(      DataSet : TDataSet;
                                                        E       : EDatabaseError;
                                                    var Action  : TDataAction );
begin
     DoOnDefaultError( Dataset, E, Action );
end;

function TnxeCachedDataset.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
     Result := GetCustomFieldClass( FieldType );
     If   not Assigned( Result )
     then Result := inherited GetFieldClass( FieldType );
end;

function TnxeCachedDataset.GetMinAutoIncValue : Variant;
begin
     If   Assigned( FAutoIncField )
     then Result := GetMinFieldValue( FAutoIncField )
     else Result := Low( Integer );
end;

function TnxeCachedDataSet.GetMasterRelation: TMasterRelation;
begin
     Result := FMasterRelation;
end;

procedure TnxeCachedDataSet.SetMasterRelation(const Value: TMasterRelation);
begin
     FMasterRelation := Value;
end;

function TnxeCachedDataset.GetOpenOnMasterActivation : Boolean;
begin
     Result := FopenOnMasterActivation;
end;

function TnxeCachedDataSet.GetReadOnly: Boolean;
begin
     Result := ReadOnly;
end;

function TnxeCachedDataset.GetMaxAutoIncValue : Variant;
begin
     If   Assigned( FAutoIncField )
     then Result := GetMaxFieldValue( FAutoIncField )
     else Result := MaxLongint;
end;

function TnxeCachedDataset.GetEditing : Boolean;
begin
     Result := State in [ dsEdit, dsInsert ];
end;

procedure TnxeCachedDataset.InternalEdit;
begin
     If   CanEditRecord
     then inherited;
end;

function TnxeCachedDataset.GetCanEditRecord : Boolean;
begin
     If   Assigned( FOnCanEditRecord )
     then Result := FOnCanEditRecord( Self )
     else Result := True;
end;

function TnxeCachedDataset.GetAutoIncField : TField;

var  AField : TField;

begin
     If   not Assigned( FAutoIncField ) and ( FAutoIncFieldName<>'' )
     then begin
          AField := FindField( FAutoIncFieldName );
          If   Assigned( AField )
          then FAutoIncField := AField;
          end;
     Result := FAutoIncField;
end;

function TnxeCachedDataset.GetAutoIncFieldName : String;
begin
     Result := FAutoIncFieldName;
end;

procedure TnxeCachedDataset.SetAutoIncFieldName( const Value : String );
begin
     If   Value<>FAutoIncFieldName
     then begin
          FAutoIncFieldName := Value;
          FAutoIncField := nil;
          If   not ( csLoading in ComponentState ) and ( Value<>'' )
          then FAutoIncField := GetAutoIncField;
          end;
end;

function TnxeCachedDataset.GetFireEditionEvents : Boolean;
begin
     Result := FFireEditionEvents;
end;

procedure TnxeCachedDataset.SetFireEditionEvents( const Value : Boolean );
begin
     FFireEditionEvents := Value;
end;

function TnxeCachedDataset.GetShiftingRecords : Boolean;
begin
     Result := FShiftingRecords;
end;

procedure TnxeCachedDataset.SetShiftingRecords( const Value : Boolean );
begin
     FShiftingRecords := Value;
end;

function TnxeCachedDataSet.SetTempState( const Value: TDataSetState): TDataSetState;
begin
     Result := inherited;
end;

procedure TnxeCachedDataSet.Update;
begin
     Post;
     Edit;
end;

procedure TnxeCachedDataset.UnlockRecord;
begin
     InternalCancel;
end;

function TnxeCachedDataset.GetOnUpdateState : TDataSetNotifyEvent;
begin
     Result := FOnUpdateState;
end;

procedure TnxeCachedDataset.SetOnUpdateState( const Value : TDataSetNotifyEvent );
begin
     FOnUpdateState := Value;
end;

procedure TnxeCachedDataSet.SetReadOnly(const Value: Boolean);
begin
     ReadOnly := Value;
end;

function TnxeCachedDataset.GetOnApplyMasterRange : TDataSetNotifyEvent;
begin
     Result := FOnApplyMasterRange;
end;

procedure TnxeCachedDataset.SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
begin
     FOnApplyMasterRange := Value;
end;

function TnxeCachedDataset.GetNewAutoIncValue : Variant;
begin
     Result := MinAutoIncValue;
     If   ( State in [ dsBrowse, dsSetKey ] ) and Assigned( AutoIncField )
     then If   Assigned( FOnGetAutoIncValue )
          then Result := FOnGetAutoIncValue( Self )
end;

procedure TnxeCachedDataset.DataEvent( Event : TDataEvent;
                                       Info  : NativeInt );
begin

     If   FBlockDataEvents
     then Exit;

     inherited;

     If   Assigned( FOnDataEvent )
     then FOnDataEvent( Event, Info );

     If   FFireEditionEvents
     then case Event of

            deUpdateState     : If   not ( csDestroying in ComponentState )
                                then DoOnUpdateState;

            deDataSetScroll,
            // deDataSetChange,
            deRecordChange    : If   not ControlsDisabled
                                then begin
                                     If   State in [ dsBrowse, dsEdit, dsInsert ]
                                     then DoOnGetRecord;
                                     DoOnRecordChanged;
                                     end;
            end;
end;

procedure TnxeCachedDataset.DoOnUpdateState;
begin
     If   Assigned( FOnUpdateState )
     then FOnUpdateState( Self );
end;

procedure TnxeCachedDataset.DoOnGetRecord;
begin
     If   Assigned( FOnGetRecord )
     then FOnGetRecord( Self );
end;

procedure TnxeCachedDataset.DoOnRecordChanged;
begin
     If   Assigned( FOnRecordChanged )
     then FOnRecordChanged( Self );
end;

function  TnxeCachedDataset.IsAppending : Boolean;
begin
     Result := ( State=dsInsert ) and ( GetBookMarkFlag( ActiveBuffer )=bfEof );
end;

procedure TnxeCachedDataset.OpenDetailDataSets;
begin
     DoOpenDetailDataSets( Self );
end;

procedure TnxeCachedDataSet.RestoreState(const Value: TDataSetState);
begin
     inherited;
end;

procedure TnxeCachedDataset.DoAfterClose;
begin
     inherited;
     For var Inx := ComponentCount - 1 downto 0 do
       If   Components[ Inx ] is TnxeDataSetFields
       then Components[ Inx ].Free;
end;

procedure TnxeCachedDataset.DeleteRangeRecords( const AStartValues,
                                                      AEndValues    : array of const;
                                                      Raw           : Boolean = False );
begin
     try
       SetRange( AStartValues, AEndValues );
       DeleteRecords( Raw );
     finally
       CancelRange;
       end;
end;

procedure TnxeCachedDataset.DeleteRecords( Raw : Boolean = False );
begin

     If   Raw
     then inherited DeleteRecords
     else begin

          // la función DeleteRecord de Nexus se realiza en el servidor y no provoca los eventos necesarios por cada registro borrado

          try
            DisableControls;
            First;
            While not Eof do
              Delete;
          finally
            EnableControls;
            end;

         end;
end;

// TnxeQuery -----------------------------------------------------------------------------------------------

procedure TnxeQuery.ApplyMasterRange;
begin
     dsApplyMasterRange( { aFollowedByFirst } True );
end;

constructor TnxeQuery.Create(AOwner: TComponent);
begin
     inherited Create( AOwner );
     FMinAutoIncValue := 1;
     FMaxAutoIncValue := MaxSmallint;
     FMasterRelation := mrLoose;
     FOpenOnMasterActivation := True;
end;

procedure TnxeQuery.Notification( AComponent : TComponent; Operation : TOperation );
begin
     inherited Notification( AComponent, Operation );
     If   Operation=opRemove
     then begin
          If   AComponent=FAutoIncField
          then FAutoIncField := nil;
          end;
end;

function TnxeQuery.dsApplyMasterRange(aFollowedByFirst: Boolean) : Boolean;
begin
     If   not FApplyingMasterRange
     then begin
          FApplyingMasterRange := True;
          try
            If   Assigned( FOnApplyMasterRange )
            then FOnApplyMasterRange( Self );
          finally
            FApplyingMasterRange := False;
            end;
          end;
     Result := True;
end;

procedure TnxeQuery.Loaded;
begin
     inherited;
     SetDefaultErrorManager;
     TimeOut := GetSQLTimeout;
end;

procedure TnxeQuery.SetDefaultErrorManager;
begin
     If   not Assigned( OnEditError )
     then OnEditError := DoOnDefaultError;
     If   not Assigned( OnPostError )
     then OnPostError := DoOnPostOrDeleteError;
     If   not Assigned( OnDeleteError )
     then OnDeleteError := DoOnPostOrDeleteError;
end;

procedure TnxeQuery.DoOnDefaultError(     DataSet : TDataSet;
                                          E       : EDatabaseError;
                                      var Action  : TDataAction );
begin
     If   FFailOnError
     then Action := daFail
     else If   Assigned( OnDatabaseError )
          then begin
               OnDatabaseError( DataSet, E );
               Action := daAbort;
               end;
end;

procedure TnxeQuery.DoOnPostOrDeleteError(      DataSet : TDataSet;
                                                E       : EDatabaseError;
                                            var Action  : TDataAction );
begin
     DoOnDefaultError( Dataset, E, Action );
end;

function TnxeQuery.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
     Result := GetCustomFieldClass( FieldType );
     If   not Assigned( Result )
     then Result := inherited GetFieldClass( FieldType );
end;

function TnxeQuery.GetMinAutoIncValue : Variant;
begin
     If   Assigned( FAutoIncField )
     then Result := GetMinFieldValue( FAutoIncField )
     else Result := Low( Integer );
end;

function TnxeQuery.GetMasterRelation: TMasterRelation;
begin
     Result := FMasterRelation;
end;

procedure TnxeQuery.SetMasterRelation(const Value: TMasterRelation);
begin
     FMasterRelation := Value;
end;

function TnxeQuery.GetOpenOnMasterActivation : Boolean;
begin
     Result := FOpenOnMasterActivation;
end;

function TnxeQuery.GetReadOnly: Boolean;
begin
     Result := ReadOnly;
end;

function TnxeQuery.GetMaxAutoIncValue : Variant;
begin
     If   Assigned( FAutoIncField )
     then Result := GetMaxFieldValue( FAutoIncField )
     else Result := MaxLongint;
end;

function TnxeQuery.GetEditing : Boolean;
begin
     Result := State in [ dsEdit, dsInsert ];
end;

{ QuText guarda una copia de SQL.Text que puede ser modificada sin que la sentencia SQL original
  se vea alterada. Es la que se utiliza para generar la consulta que se pasará al servidor.
  Se restituye cada vez que cambia SQL.Text
}

procedure TnxeQuery.SetParsedSQLText( Value : UnicodeString );
begin
     If   not ( csReading in ComponentState)
     then begin
          dsCursor.Active := False;
          Unprepare;
          QuText := QuParseSql( Value, False, sdParams );
          SetLength( QuText, LstrlenW( PWideChar( QuText ) ) );
          end;
end;

procedure TnxeQuery.SetReadOnly(const Value: Boolean);
begin
     ReadOnly := Value;
end;

procedure TnxeQuery.InternalEdit;
begin
     If   CanEditRecord
     then inherited;
end;

function TnxeQuery.GetCanEditRecord : Boolean;
begin
     If   Assigned( FOnCanEditRecord )
     then Result := FOnCanEditRecord( Self )
     else Result := True;
end;

function TnxeQuery.GetAutoIncField : TField;

var  AField : TField;

begin
     If   not Assigned( FAutoIncField ) and ( FAutoIncFieldName<>'' )
     then begin
          AField := FindField( FAutoIncFieldName );
          If   Assigned( AField )
          then FAutoIncField := AField;
          end;
     Result := FAutoIncField;
end;

function TnxeQuery.GetAutoIncFieldName : String;
begin
     Result := FAutoIncFieldName;
end;

procedure TnxeQuery.SetAutoIncFieldName( const Value : String );
begin
     If   Value<>FAutoIncFieldName
     then begin
          FAutoIncFieldName := Value;
          FAutoIncField := nil;
          If   not ( csLoading in ComponentState ) and ( Value<>'' )
          then FAutoIncField := GetAutoIncField;
          end;
end;

function TnxeQuery.GetFireEditionEvents : Boolean;
begin
     Result := FFireEditionEvents;
end;

procedure TnxeQuery.SetFireEditionEvents( const Value : Boolean );
begin
     FFireEditionEvents := Value;
end;

function TnxeQuery.GetShiftingRecords : Boolean;
begin
     Result := FShiftingRecords;
end;

procedure TnxeQuery.SetShiftingRecords( const Value : Boolean );
begin
     FShiftingRecords := Value;
end;

function TnxeQuery.SetTempState(const Value: TDataSetState): TDataSetState;
begin
     Result := inherited;
end;

procedure TnxeQuery.Update;
begin
     Post;
     Edit;
end;

procedure TnxeQuery.UnlockRecord;
begin
     InternalCancel;
end;

function TnxeQuery.GetOnUpdateState : TDataSetNotifyEvent;
begin
     Result := FOnUpdateState;
end;

procedure TnxeQuery.SetOnUpdateState( const Value : TDataSetNotifyEvent );
begin
     FOnUpdateState := Value;
end;

function TnxeQuery.GetOnApplyMasterRange : TDataSetNotifyEvent;
begin
     Result := nil;
end;

procedure TnxeQuery.SetOnApplyMasterRange( const Value : TDataSetNotifyEvent );
begin
end;

function TnxeQuery.GetNewAutoIncValue : Variant;
begin
     Result := MinAutoIncValue;
     If   ( State in [ dsBrowse, dsSetKey ] ) and Assigned( AutoIncField )
     then If   Assigned( FOnGetAutoIncValue )
          then Result := FOnGetAutoIncValue( Self )
end;

{
procedure TnxeQuery.SaveCurrentRecord( var RecordBuffer : TnxRecordBuffer );
begin
     RecordBuffer := AllocRecordBuffer;
     If   Assigned( RecordBuffer )
     then Move( ActiveBuffer^, RecordBuffer^, dsRecordBufferSize );
end;

procedure TnxeQuery.RestoreSavedRecord( var RecordBuffer : TnxRecordBuffer;
                                            FreeRecord   : Boolean = False );
begin
     If   Assigned( RecordBuffer )
     then begin
          Move( RecordBuffer^, ActiveBuffer^, dsRecordBufferSize );
          If   FreeRecord
          then FreeSavedRecord( RecordBuffer );
          end;
end;

procedure TnxeQuery.FreeSavedRecord( var RecordBuffer : TnxRecordBuffer );
begin
     If   Assigned( RecordBuffer )
     then FreeRecordBuffer( RecordBuffer );
     RecordBuffer := nil;
end;
}

procedure TnxeQuery.DataEvent( Event : TDataEvent;
                               Info  : NativeInt );
begin

     If   FBlockDataEvents
     then Exit;

     inherited;

     If   Assigned( FOnDataEvent )
     then FOnDataEvent( Event, Info );

     If   FFireEditionEvents
     then case Event of

            deUpdateState     : If   not ( csDestroying in ComponentState )
                                then DoOnUpdateState;

            deDataSetScroll,
            // deDataSetChange,
            deRecordChange    : If   not ControlsDisabled
                                then begin
                                     If   State in [ dsBrowse, dsEdit, dsInsert ]
                                     then DoOnGetRecord;
                                     DoOnRecordChanged;
                                     end;
            end;
end;

procedure TnxeQuery.DoOnUpdateState;
begin
     If   Assigned( FOnUpdateState )
     then FOnUpdateState( Self );
end;

procedure TnxeQuery.DoOnGetRecord;
begin
     If   Assigned( FOnGetRecord )
     then FOnGetRecord( Self );
end;

procedure TnxeQuery.DoOnRecordChanged;
begin
     If   Assigned( FOnRecordChanged )
     then FOnRecordChanged( Self );
end;

function  TnxeQuery.IsAppending : Boolean;
begin
     Result := ( State=dsInsert ) and ( GetBookMarkFlag( ActiveBuffer )=bfEof );
end;

procedure TnxeQuery.OpenCursor(aInfoQuery: Boolean);

var  CurCursor : TCursor;

begin
     //* 19.05.2010  Añadiendo un poco de interactividad
     CurCursor := Screen.Cursor;
     try
       Screen.Cursor := crHourglass;
       inherited;
     finally
       Screen.Cursor := CurCursor;
       end;
end;

procedure TnxeQuery.OpenDetailDataSets( OnOpenDetailDataset : TDataSetNotifyEvent = nil );
begin
     DoOpenDetailDataSets( Self );
end;

procedure TnxeQuery.DoAfterClose;
begin
     inherited;
     For var Inx := ComponentCount - 1 downto 0 do
       If   Components[ Inx ] is TnxeDataSetFields
       then Components[ Inx ].Free;
end;

procedure TnxeQuery.DeleteRecords( Raw : Boolean = False );
begin

     If   Raw
     then inherited DeleteRecords
     else begin

          // la función DeleteRecord de Nexus se realiza en el servidor y no provoca los eventos necesarios por cada registro borrado

          try
            DisableControls;
            First;
            While not Eof do
              Delete;
          finally
            EnableControls;
            end;

         end;
end;

procedure TnxeQuery.RefreshQuery( OnlyIfActive : Boolean = True );
begin

     If   OnlyIfActive and not Active
     then Exit;

     DisableControls;
     try
       Close;
       Open;
     finally
       EnableControls;
       end;
end;

procedure TnxeQuery.RestoreState(const Value: TDataSetState);
begin
     inherited;
end;

procedure TnxeQuery.ExecSQLVars( const SQLString : String;
                                       Values    : array of Variant );
begin
     Close;
     SQL.Text := SQLVarsFormat( SQLString, Values );
     Open;
end;

procedure TnxeQuery.ExecSQLFields( const SQLString : String;
                                         Fields    : array of TField );
begin
     Close;
     SQL.Text := SQLFieldsFormat( SQLString, Fields );
     Open;
end;

procedure TnxeQuery.SetParamValuesFromFields( Values : array of TField );

var  I : SmallInt;
     Param : TParam;
     ParamValue : Variant;

begin
     For I := 0 to High( Values ) do
       begin
       Param := Params.FindParam( Values[ I ].FieldName );
       If   Assigned( Param )
       then begin
            ParamValue := Values[ I ].Value;
            If   VarIsNull( ParamValue ) and ( Values[ I ].DataType in [ ftString, ftWideString ] )
            then ParamValue := '';
            Param.AssignFieldValue( Values[ I ], ParamValue );  // No quiero cambiar el nombre del parámetro, por eso no utilizo AssignField
            end;
       end;
end;

procedure TnxeQuery.SetParamValues( Values : array of Variant );

var  I : SmallInt;

begin
     For I := 0 to High( Values ) do
       Params[ I ].Value := Values[ I ];
end;

// TgxMemData

function TgxMemData.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
     Result := GetCustomFieldClass( FieldType );
     If   not Assigned( Result )
     then Result := inherited GetFieldClass( FieldType );
end;

procedure TgxMemData.DeleteAllRecords;
begin
     First;
     While not Eof do
       Delete;
end;

function TgxMemData.GetModified : Boolean;
begin
     Result := inherited Modified;
end;

procedure TgxMemData.SetModified( const Value : Boolean );
begin
     inherited SetModified( Value );
end;

{ TnxeStoredProc }

procedure TnxeStoredProc.ExecProc( ParamValues: array of Variant );

var  I : SmallInt;

begin
     For I := 0 to High( ParamValues ) do
       Params[ I ].Value := ParamValues[ I ];
     inherited ExecProc;
end;

{ TnxAbstractServerObjectHelper }

class function TnxAbstractServerObjectHelper.LookupByID(     ABaseID : TnxBaseID;
                                                         out ABase ) : TnxResult;
var InstanceClass : TClass;

begin
     Result := DBIERR_INVALIDHNDL;
     TnxAbstractServerObject( ABase ) := nil;
     try
       If not   IsBadReadPtr( Pointer( ABaseID ), InstanceSize) and
                nxIsClassInstance( Pointer( ABaseID ), InstanceClass ) and
                InstanceClass.InheritsFrom( Self ) and
                not TnxAbstractServerObject( ABaseID ).asoDestroying
       then begin
            TnxAbstractServerObject( ABase ) := TnxAbstractServerObject( ABaseID );
            Result := DBIERR_NONE;
            end;
     except
       end;

end;

{ TnxBaseSessionHelper }

procedure TnxBaseSessionHelper.AssignAbstractSession( Value : TnxAbstractSession );
begin
     bsAbstractSession := Value;
end;

initialization

     DictionaryList := TList<TnxeDatabaseDictionary>.Create;

     RegisterClasses( [ TnxDataDictionary,
                        TnxeDatabase,
                        TnxeDatabaseDictionary,
                        TnxeDataSetFields,
                        TnxeCachedDataSet,
                        TnxeTable,
                        TnxeQuery,
                        TnxeStoredProc ] );

finalization
     DictionaryList.Free;

end.
