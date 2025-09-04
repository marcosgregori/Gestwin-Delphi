unit BaseSessionData;

interface

uses
  System.SysUtils,
  System.Classes,
  Generics.Collections,
  ExtCtrls,

  Data.DB,

  nxdb,
  nxllComponent,
  nxsdTypes,
  nxsdConst,
  nxsdTableMapperDescriptor,
  nxsdRecordMapperDescriptor,
  nxsdFieldMapperDescriptor, 
  nxsdServerEngine,
  nxsdDataDictionary,
  nxsrServerEngine,
  nxllTypes,
  nxllUtils,
  nxllBde,
  nxllTransport,
  nxllZipCompressor,
  nxllRleCompressor,
  nxllPlatformInterface,

  nxptBasePooledTransport,
  nxtmSharedMemoryTransport,
  nxtnNamedPipeTransport,
  nxseAutoComponent,
  nxdbBase,
  nxdbBackupController,

  SxBase,
  SxMain,
  ScroogeXHTML,

  kbmMemTable,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWCustomSQLMetaData,
  kbmMWResolvers,

  LibUtils,
  SessionIntf,
  BaseServerContainer,
  DataManager,
  AppManager,
  SQLSet;

type

  TReestructureEventType = ( reCheck, reBefore, reAfter );
  TDictionaryNotification = ( dnVerify, dnBeforeUpdate, dnAfterUpdate );

  TClientTypes = set of TClientType;

  TBaseSessionDataModule = class;

  {
  TProcessRec = record
    Database,
    BackupDatabase : TnxDatabase;
    Dictionary : TnxeDatabaseDictionary;
    TableName : String;
    DiscardOldTable : Boolean;
    ProcessPercent : Integer;
    end;
  }

  TReestructureData = record
    Dictionary,
    Database : TnxDatabase;
    DatabaseComparableVersion,
    TableName : String;
    TableMapper : TnxTableMapperDescriptor;
    RecordMapper : TnxRecordMapperDescriptor;
    OldDictionary,
    NewDictionary : TnxDataDictionary;
    DoProcess,
    DontCheckRecordMapping : Boolean;
    procedure Setup( ADictionary, ADatabase : TnxDatabase; ATableName : String );
    end;

  TTableProgressEvent = function( TableName : String; Percentaje : SmallInt ) : Boolean of object;
  TReestructureTableEvent = procedure( EventType : TReestructureEventType; var ReestructureData : TReestructureData ) of object;
  TRecoverTableEvent = procedure( TableName : String ) of object;

  TReestructureNotifyItem = class
  public
    Name : String;
    Event : TReestructureTableEvent;
    constructor Create( AName : String; AEvent : TReestructureTableEvent );
    end;

  TReestructureNotifyList = class( TList )
  public
    procedure Clear; override;
    function FindByName( const Name : String ) : TReestructureNotifyItem;
    end;

  TRecoverNotifyItem = class
  public
    Name : String;
    Event : TRecoverTableEvent;
    constructor Create( AName : String; AEvent : TRecoverTableEvent );
    end;

  TRecoverNotifyList = class( TList )
  public
    procedure Clear; override;
    function FindByName( const Name : String ) : TRecoverNotifyItem;
    end;

  TTransactionTag = record

    private

    Id : LongInt;
    Notify : Boolean;
    SessionDatamodule : TBaseSessionDataModule;
    Database : TnxDatabase;

    procedure PopAndCheck;

    public

    procedure Commit;
    procedure RollBack;

    end;

  TBaseSessionDataModule = class(TDataModule, IBaseSessionDataModule)
    PooledSession: TkbmMWPooledSession;
    ConnectionPool: TkbmMWNexusDBConnectionPool;
    AppResolver: TkbmMWNexusDBResolver;
    NexusDBMetaData: TkbmMWNexusDBMetaData;
    EnterpriseQuery: TkbmMWNexusDBQuery;
    DBSession: TnxSession;
    DatabaseInfoTable: TnxeTable;
    DatabaseInfoTableMajorVersion: TSmallintField;
    DatabaseInfoTableMinorVersion: TSmallintField;
    DatabaseInfoTableRelease: TSmallintField;
    DatabaseInfoTableBuild: TIntegerField;
    DatabaseInfoTableUpdated: TDateTimeField;
    DatabaseInfoTableOptions: TWideStringField;
    SQLSet: TgxSQLSet;
    ImportsDatabase: TnxeDatabase;
    ExportsDatabase: TnxeDatabase;
    InMemoryDatabase: TnxeDatabase;
    TemporalDatabase: TnxeDatabase;
    MainQuery: TkbmMWNexusDBQuery;
    BTScroogeXHTML: TBTScroogeXHTML;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    FID : SmallInt;
    FClientID : String;         // El ClientID, a diferencia del ID, es asignado desde el cliente remoto, para identificar la sesión (Servicios RPC, etc..)
    FProgramNumber : SmallInt;
    FClientType : TClientType;
    FComputerName,
    FUserName : String;
    FStartedAt : TDateTime;

    FModuleDictionary : TDictionary< String, TDataModule >;

    FTransactionStack : TStack< TTransactionTag >;
    FCurrentTransactionId : LongInt;
    FRootDataPath,                 // El directorio raiz de la aplicación Gestwin Cliente
    FTemporalDataPath : String;

    FUpdatingDatabaseComparableVersion : String;

    FDatabaseUpdateRequested,   // Indica que se ha solicitado la reestructuración de la base de datos

    FInitializingDatabase,
    FRecoveringDatabase,
    FUpdatingDatabase,
    FBackingUpDatabases,

    FUpdatingTable,
    FRestructuringTable,
    FReindexingTable,
    FPackingTable,
    FVerifyingTable,
    FRecoveringTable,
    FBackingUpTable : Boolean;

    FReestructuredFiles : Boolean;

    FRestrictedTableNames : TStringList;     // Lista de tablas limitadas (versión de evaluación)
    FReestructureNotifyList : TReestructureNotifyList;
    FRecoverNotifyList : TRecoverNotifyList;

    FTemporalDataInMemory : Boolean;

    TaskInfo : TnxAbstractTaskInfo;
    TaskStatus : TnxTaskStatus;

    // Datos globales de la sesión que se guardan aquí para que sean fácilmente accesibles desde los módulos

    FCodigoEmpresa,
    FCodigoUsuario : String;
    FEjercicio,
    FEjercicioProximo,
    FEjercicioAnterior,
    FNroMesInicial,
    FNroMesFinal : Word;

    FFechaHoy,
    FPrimerDiaEjercicio,
    FUltimoDiaEjercicio  : TDate;

    FLastNotificationType : TNotificationType;
    FLastNotificationCaption,
    FLastNotificationDescription : String;

    WatchDogTimer : TTimer;

    procedure SetFechaHoy( Value : TDate );

  protected

    FInitialized : Boolean;

    FNotificationCallBack : INotificationCallBack;
    FProgressCallBack : IProgressCallBack;

    // FClientSession : ISessionService;

    FMainDataModule : TDataModule;

    // FEnterpriseData se destruye y recrea cada vez que el usuario cambia de Empresa activa

    FEnterpriseDataModule : TDataModule;

    FDictionaryList : TList< TnxeDatabaseDictionary >;
    FUpdateDatabaseTableList,               // Está aquí, en lugar de en la función, para que sea accesible cuando se llama a los eventos asociodos a la actualización
    FPackDatabaseTableList  : TStringList;

    FLastAccess : TDateTime;

    function GetNotificationCallback: INotificationCallback;
    procedure SetNotificationCallback(const ACallback: INotificationCallback);

    function GetProgressCallback: IProgressCallback;
    procedure SetProgressCallback(const ACallback: IProgressCallback);

    // procedure RecoverProcessNotification( Sender : TObject );
    // procedure BackupProcessNotification( Sender : TObject );
    procedure ReIndexProcess;
    procedure WaitForTaskEnding( TableName : String; TaskInfo : TnxAbstractTaskInfo );
    procedure SetupTemporalDatabase( Database : TnxDatabase; SubDirectory : String = '' );

    procedure NotifyRecoverEvent(TableName: String);
    procedure NotifyReestructureEvent(EventType: TReestructureEventType; var ReestructureData: TReestructureData);

    function PushTransaction( const Database : TnxDatabase; Notify : Boolean = False ) : TTransactionTag;

  public

    constructor Create( AProgramaNumber : SmallInt; AClientApplicationPath : String; AClientType : TClientType; AComputerName : String = ''; AUserName : String = '';AClientID : String = '' ); reintroduce;
    destructor Destroy; override;

    function GetID : Integer;
    function GetClientID : String;
    function AsignaParametrosTrabajo( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate ) : Boolean; virtual; abstract;

    procedure AddModule( Name : String; Module : TDataModule );
    function GetModuleByName( Name : String ) : TDataModule;

    procedure SendDatabaseError( DataSet : TDataSet; AException : Exception; ErrorCode : TnxResult = 0; TableName : String = '' );

    function SessionCount( CodigoEmpresa : String = '' ) : SmallInt;
    procedure CloseSession;
    procedure CloseInactiveTables;
    procedure CloseSessionDatabases;

    procedure SendException( E : Exception; Component : TComponent = nil; InfoMsg : String = '' );
    function SendNotification( NotificationType: TNotificationType; Caption: String = ''; Description : String = '' ) : Boolean;
    procedure CleanNotificationData;
    procedure StartProgress(MarqueeMode: Boolean = False; MaxValue : Integer = 100 );
    function SendProgress( ObjectName : String; Percent1 : SmallInt = 0; Percent2 : SmallInt = 0 ) : Boolean;
    procedure EndProgress;

    function GetDatabaseDictionary(AName: TComponentName): TnxeDatabaseDictionary;
    function GetTableDatabase(ASession: TnxSession;ATableName: String): TnxDatabase;
    function GetTableDictionary(ATableName: TComponentName): TnxeDatabaseDictionary;
    procedure GetTableNames(AList: TStrings;ADictionaryName: TComponentName='');
    function InitializeDatabase( Database : TnxDatabase; UpdateInfo : Boolean = True ) : Boolean;
    function RecoverDatabase( Database: TnxDatabase; RecoverTableList: TStringArray): Boolean;

    procedure NotifyDictionary(ADatabase: TnxDatabase; Notification: TDictionaryNotification);
    procedure SetupDatabaseDictionary(ADatabaseDictionary: TnxeDatabaseDictionary; ADatabase : TnxDatabase );

    function  VerifyTable( Database : TnxDatabase; Dictionary : TnxeDatabaseDictionary; TableName : String ) : Boolean;

    function RecoverTable( Database : TnxDatabase; TableName : String; DiscardOldTable : Boolean = False ) : Boolean;
    procedure PackTable( Database : TnxDatabase; TableName : String );
    procedure ReIndexTable( Database : TnxDatabase; TableName : String );
    function ReStructureTable( Database : TnxDatabase; Dictionary : TnxeDatabaseDictionary; TableName : String ) : Boolean;
    procedure BackupTable( Database, BackupDatabase : TnxDatabase; TableName : String );
    procedure GetDatabaseInfo( ADatabase : TnxDatabase; var MajorVersion : Word; var MinorVersion : Word; var Release : Word; var Build : Word;var LastUpdate : TDateTime; var Options : String );
    procedure UpdateDatabaseInfo( ADatabase : TnxDatabase; AMajorVersion, AMinorVersion, ARelease, ABuild : Word; AOption : Char = #0 );
    function CheckDatabaseOption( ADatabase : TnxDatabase; AMajorVersion, AMinorVersion, ARelease, ABuild : Word; AOption : Char = #0 ) : Boolean;

    function  CreateTemporalSQLTable( var Table : TnxeTable; SQLCreateCommand : String; ATableType : TTableType = ttVirtual; Database : TnxeDatabase = nil ) : String;

    function  GetExportDirectory : String;
    function  GetImportDirectory : String;

    procedure CheckDatabaseVersion( Database : TnxDatabase; DiskVersion : String; CodigoEmpresa : String = '' );
    procedure UpdateDatabase( CodigoEmpresa : String; Database : TnxDatabase );
    procedure RequestDatabaseUpdate;

    procedure AddRecoverNotification(TableName: String; Event: TRecoverTableEvent);
    procedure AddReestructureNotification(TableName: String; Event : TReestructureTableEvent );
    procedure AddRestrictedTables( TableNames : array of string );
    function  IsARestrictedTable( TableName : string ) : Boolean;

    function EnterpriseDataPath( ADataPath : String; UnCodigoEmpresa : String = '' ) : String;
    function AddDataDirectory( ADataPath : String; UnCodigoEmpresa : String = '' ) : String;
    function RemoveDataDirectory( ADataPath : String ) : String;
    procedure EraseEnterpriseDatabase( CodigoEmpresa : String ); virtual; abstract;

    //

    function  CreateSQLTable( AOwner : TComponent; DatasetName, SQLString : String ) : TnxeTable;
    function  CreateEmptyTable( AOwner : TComponent; BaseName, CreateSQL : String; ATAbleType : TTableType = ttVirtual ) : TnxeTable;
    //

    function StartTransaction( MainDatabase : Boolean = False; Notify : Boolean = False ) : TTransactionTag;
    function StartTransactionWith( const ATables  : array of TnxTable; Notify : Boolean = False ) : TTransactionTag;

    // Utilidades de la sesión

    procedure SetupSessionParams( CodigoUsuario, CodigoEmpresa : String; Fecha : TDate; NroMesInicial : SmallInt ); virtual;

    function RTFToPlainText( Value : String; JSONText : Boolean = True ) : String;
    function RTFToHTMLText( Value : String; JSONText : Boolean = True ) : String;
    function StrToDate( St : String; var Date : TDateTime; DateFormat : TDateFormat = dfDefault ) : Boolean;
    function EjercicioFecha( ADate : TDateTime) : Word;
    function IsValidDate( Day, Month, Year : Word; var InvalidYear : Boolean ) : Boolean;
    function IsValidYear( Day, Month, Year : Word; ReferenceYear : Word = 0 ) : Boolean; overload;
    function IsValidYear( ADate : TDateTime; ReferenceYear : Word = 0 ) : Boolean; overload;
    procedure PeriodoEjercicio( Ejercicio : SmallInt; var FechaInicial : TDateTime; var FechaFinal : TDateTime );

    function EjercicioActual( Date : TDateTime ) : Boolean;
    function FechaPrimerDiaEjercicio( UnEjercicio : SmallInt = 0 ) : TDateTime;
    function FechaUltimoDiaEjercicio( UnEjercicio : SmallInt = 0 ) : TDateTime;

    // property SelectableFileLocation  : Boolean read FSelectableFileLocation write FSelectableFileLocation;

    // property ClientSession : ISessionService read FClientSession;

    property ReestructuredFiles : Boolean read FReestructuredFiles write FReestructuredFiles;

    property ProgramNumber: SmallInt read FProgramNumber;
    property StartedAt : TDateTime read FStartedAt;
    property ClientType : TClientType read FClientType;
    property ComputerName : String read FComputerName;
    property UserName : String read FUserName;
    property ClientID : String read GetClientID;
    property ID : Integer read GetID;

    property NotificationCallback: INotificationCallback read GetNotificationCallback write SetNotificationCallback;
    property ProgressCallback: IProgressCallback read GetProgressCallback write SetProgressCallback;

    property MainDataModule : TDataModule read FMainDataModule;
    property EnterpriseDataModule : TDataModule read FEnterpriseDataModule write FEnterpriseDataModule;

    property VerifyingTable : Boolean read FVerifyingTable write FVerifyingTable;
    property RecoveringTable : Boolean read FRecoveringTable write FRecoveringTable;
    property RestructuringTable : Boolean read FRestructuringTable write FRestructuringTable;
    property UpdatingTable : Boolean read FUpdatingTable write FUpdatingTable;
    property ReindexingTable : Boolean read FReindexingTable write FReindexingTable;
    property BackingUpTable : Boolean read FBackingUpTable write FBackingUpTable;
    property PackingTable : Boolean read FPackingTable write FPackingTable;

    property BackingUpDatabases : Boolean read FBackingUpDatabases write FBackingUpDatabases;
    property UpdatingDatabase : Boolean read FUpdatingDatabase write FUpdatingDatabase;
    property InitializingDatabase : Boolean read FInitializingDatabase write FInitializingDatabase;
    property RecoveringDatabase : Boolean read FRecoveringDatabase write FRecoveringDatabase;
    property DatabaseUpdateRequested : Boolean read FDatabaseUpdateRequested write FDatabaseUpdateRequested;
    property UpdatingDatabaseComparableVersion : String read FUpdatingDatabaseComparableVersion;
    property LastAccess : TDateTime read FLastAccess write FLastAccess;

    property CodigoEmpresa : String read FCodigoEmpresa write FCodigoEmpresa;
    property CodigoUsuario : String read FCodigoUsuario write FCodigoUsuario;
    property FechaHoy : TDate read FFechaHoy write SetFechaHoy;
    property Ejercicio : Word read FEjercicio write FEjercicio;
    property NroMesInicial : Word read FNroMesInicial write FNroMesInicial;
    property NroMesFinal : Word read FNroMesFinal write FNroMesFinal;
    property PrimerDiaEjercicio : TDate read FPrimerDiaEjercicio;
    property UltimoDiaEjercicio : TDate read FUltimoDiaEjercicio;

    property LastNotificationType : TNotificationType read FLastNotificationType;
    property LastNotificationCaption : String read FLastNotificationCaption;
    property LastNotificationDescription : String read FLastNotificationDescription;
    property RootDataPath : String read FRootDataPath;
    property TemporalDataPath : String read FTemporalDataPath;
    property DictionaryList : TList< TnxeDatabaseDictionary > read FDictionaryList;
    property UpdateDatabaseTableList : TStringList read FUpdateDatabaseTableList;
    property PackDatabaseTableList : TStringList read FPackDatabaseTableList;
    property TemporalDataInMemory : Boolean read FTemporalDataInMemory write FTemporalDataInMemory;

  end;

function CloseSessions( AClientTypes : TClientTypes; CallingSession : TBaseSessionDataModule = nil ) : Boolean;
function CloseSessionByIndex( ListIndex : SmallInt ) : Boolean;

procedure CheckWindowsSessionsStatus;

procedure SetFieldsMapOptions( RecordMapperDescriptor : TnxRecordMapperDescriptor; FieldNames : array of String; ASourceName : String = #0; ADataLossAction : TnxDataLossAction = dlaBestFit );
function  GetFieldTypeHasChanged( OldDictionary, NewDictionary : TnxDataDictionary; FieldName : String ) : Boolean;
procedure CheckStatus( AErrorCode : TnxResult; NotifyError : Boolean = True );

var  SessionDataList : TCompactList<TBaseSessionDataModule>;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  WinAPI.Windows,

      Variants,
      Files,

      nxllException,
      nxllBDEStrings,
      nxllConvertException,
      // nxWinAPI,
      nxsrSystemStorage,
      nxExeConst,
      nxdmServer,

      StrUtils,
      DateUtils,

      ServerDataModule,
      EnterpriseData,

      MainData;

{$R *.dfm}

const TmpDirBaseName  = 'gw$tmp_';
      DatabaseInfoFileName = '_DBI';

resourceString

      RsMsg1   = 'No se han podido cerrar todas las sesiones';
      RsMsg2   = 'Compruebe el estado de los clientes conectados y reintente el proceso cuando lo considere oportuno.';

      RsMsg6   = 'Se ha producido un error al intentar abrir el diccionario %s.';
      RsMsg7   = 'La clave activa del cursor %s tiene un número diferente de segmentos';
      RsMsg8   = 'No he conseguido eliminar la tabla temporal %s.';
      RsMsg9   = 'La estructura del cursor origen no permite fijar la posición en el destino.';
      RsMsg10  = 'No se ha podido acceder al directorio temporal.';
      RsMsg11  = 'Directorio : %s.';

      RsMsg12  = 'Regenerando las tablas.';
      RsMsg13  = 'Verificando el estado de las tablas.';
      RsMsg14  = 'Tabla : %s.';
      RsMsg15  = 'La notificación tiene su origen en %s.';
      RsMsg16  = 'Se ha producido un error durante la inicialización de la base de datos.';
      // RsMsg17  = 'Se ha producido una excepción (!).';
      RsMsg18  = 'Operación cancelada.';

      RsMsg61  = 'Compactando y reindexando.';
      RsMsg62  = 'Verificando datos asociados (Blobs).';
      RsMsg63  = 'Error del gestor de base de datos. ';
      RsMsg64  = 'Mensaje de error : ';
      RsMsg65  = 'Se ha producido un error compactando la tabla %s';
      RsMsg66  = 'Regenerando la tabla.'#13'En proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';
      RsMsg67  = 'En el proceso de regeneración de la tabla %s SE HA PERDIDO INFORMACION. ';
      RsMsg68  = 'Es conveniente que recurra a su SOPORTE TECNICO para intentar recuperar la información perdida.';
      RsMsg72  = 'Se ha producido el siguiente error durante el proceso en curso : %s.';
      RsMsg73  = 'Copiando la tabla.'#13'El proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';
      RsMsg74  = 'La versión de la base de datos es superior a la de la aplicación instalada.';
      RsMsg75  = 'Debe instalar la última versión disponible o, preferiblemente, solicitar asistencia técnica.'#13'Utilizar versiones incorrectas de la aplicación y de la base de datos puede originar una PÉRDIDA IRREVERSIBLE DE INFORMACIÓN.';
      RsMsg76  = 'No se ha podido abrir la tabla con información sobre la base de datos activa.';
      RsMsg77  = 'Revise el estado de la tabla y sus derechos de acceso al directorio de la base de datos o a la tabla.';
      RsMsg78  = 'Éste es un error de configuración grave.';
      RsMsg79  = 'Se ha producido un error ejecutando una sentencia SQL.';
      RsMsg80  = 'Se procede a abandonar la aplicación.'#13'[Color=Maroon]Notifique a su proveedor este extremo.[/Color]';
      RsMsg81  = 'Es necesario realizar una actualización de la base de datos.';
      RsMsg82  = 'No se puede realizar la actualización de la base de datos porque otros usuarios tienen sesiones activas en el servidor.';
      RsMsg83  = 'Cierre todas las sesiones y reintente el proceso.';

      RsRegistroInexistente  = '< Registro inexistente >';
      RsComponent = '. Componente : %s.';

      RsStartTransaction = 'Gestor de transacciones : Iniciando ...';
      RsCommit  = 'Gestor de transacciones : ... aplicando cambios.';
      RsRollback = 'Gestor de transacciones : ... cancelando cambios.';

procedure GetFieldNames(       ADataDictionary : TnxDataDictionary;
                               AList           : TStrings;
                         const DataTypes       : TnxFieldTypes  );

var   Index,
      ItemIndex : SmallInt;
      Fd : TnxFieldDescriptor;

begin
     If   Assigned( ADataDictionary )
     then With ADataDictionary.FieldsDescriptor do
            For Index := 0 to FieldCount - 1 do
              begin
              Fd := FieldDescriptor[ Index ];
              If   ( DataTypes=[] ) or ( Fd.fdType in DataTypes )
              then With AList do
                     begin
                     ItemIndex := Add( Fd.Name );
                     Objects[ ItemIndex ] := Pointer( Fd.fdType );
                     end;
              end;
end;

procedure SetFieldsMapOptions( RecordMapperDescriptor : TnxRecordMapperDescriptor;
                               FieldNames             : array of String;
                               ASourceName            : String = #0;
                               ADataLossAction        : TnxDataLossAction = dlaBestFit );

var  Index,
     FieldIndex : SmallInt;

begin
     For Index := 0 to High( FieldNames ) do
       With RecordMapperDescriptor do
         begin
         FieldIndex := FieldMapperIndexOf( FieldNames[ Index ] );
         If   FieldIndex>=0
         then With FieldMapper[ FieldIndex ] do
                begin
                If   ASourceName<>#0
                then SourceName := ASourceName;
                DataLossAction := ADataLossAction;
                end;
         end;
end;

function GetFieldTypeHasChanged( OldDictionary,
                                 NewDictionary : TnxDataDictionary;
                                 FieldName     : String ) : Boolean;
var  OldFieldIndex,
     NewFieldIndex : SmallInt;

begin
     Result := False;
     OldFieldIndex := OldDictionary.FieldsDescriptor.GetFieldFromName( FieldName );
     NewFieldIndex := NewDictionary.FieldsDescriptor.GetFieldFromName( FieldName );
     If   ( OldFieldIndex>=0 ) and ( NewFieldIndex>=0 )
     then Result := OldDictionary.FieldsDescriptor.FieldDescriptor[ OldFieldIndex ].fdType<>NewDictionary.FieldsDescriptor.FieldDescriptor[ NewFieldIndex ].fdType;
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

function CloseSessions( AClientTypes   : TClientTypes;
                        CallingSession : TBaseSessionDataModule = nil ) : Boolean;

var  SessionDataModule : TBaseSessionDataModule;
     MaxCount : SmallInt;
     SessionClosed : Boolean;

begin
     Result := False;
     try
       For SessionDataModule in SessionDataList do
         If   Assigned( SessionDataModule )  // Es una TCompactDataList que puede contener valores nulos
         then If   ( SessionDataModule.ClientType in AClientTypes ) and
                   not ( Assigned( CallingSession ) and ( SessionDataModule.ID=CallingSession.ID ) )
              then SessionDataModule.Free;
       Result := True;
     except on E : Exception do
       begin
       If   Assigned( CallingSession )
       then CallingSession.SendNotification( ntError, RsMsg1, RsMsg2 );
       Abort;
       end;
     end;
end;

procedure CheckWindowsSessionsStatus;

var  SessionDataModule : TBaseSessionDataModule;
     MaxCount : SmallInt;
     SessionClosed : Boolean;

begin
     try
       For SessionDataModule in SessionDataList do
         If   Assigned( SessionDataModule )
         then If   ( SessionDataModule.ClientType=ctWindows ) and
                   ( SessionDataModule.FInitialized )
              then If   not SessionDataModule.SendNotification( ntCheckSession )
                   then SessionDataModule.Free;
     except on E : Exception do
       begin

       end;
     end;
end;

function CloseSessionByIndex( ListIndex : SmallInt) : Boolean;

var  SessionDataModule : TBaseSessionDataModule;

begin
     Result := False;
     If   ( ListIndex>=0 ) and ( ListIndex<=SessionDataList.Count ) and Assigned( SessionDataList[ ListIndex ] )
     then try
            SessionDataModule := SessionDataList[ ListIndex ];

            SessionDataModule.Free;

            Result := True;
          except on E : Exception do
            begin
            end;
          end;
end;

{ TBaseSessionDataModule }

function TBaseSessionDataModule.RTFToPlainText( Value : String; JSONText : Boolean = True ) : String;
begin
     BTScroogeXHTML.ConvertToPlainText := True;
     Result := Trim( UTF8ToString( BTScroogeXHTML.Convert( Value ) ) );
     If   JSONText
     then Result := StrToJSONText( Result );
end;

function TBaseSessionDataModule.RTFToHTMLText( Value : String; JSONText : Boolean = True ) : String;
begin
     BTScroogeXHTML.ConvertToPlainText := False;
     Result := Trim( UTF8ToString( BTScroogeXHTML.Convert( Value ) ) );
     If   JSONText
     then Result := StrToJSONHTMLText( Result );
end;

procedure TBaseSessionDataModule.SendDatabaseError( DataSet    : TDataSet;
                                                    AException : Exception;
                                                    ErrorCode  : TnxResult = 0;
                                                    TableName  : String = '' );

var  ErrorInfo : TDatabaseErrorInfo;

begin

     GetDatabaseError( DataSet, AException, ErrorInfo, TableName );

     LastErrorDataset := DataSet;
     LastErrorCode := ErrorCode;

     If   ErrorInfo.StError<>''
     then SendNotification( ntError, ErrorInfo.StError, ErrorInfo.StDesc );

     If   not IsDesignTime
     then LogMessage( ErrorInfo.StError );

     If   ErrorInfo.FatalError
     then Abort;

end;


{ TReestructureData }

procedure TReestructureData.Setup( ADictionary, ADatabase : TnxDatabase; ATableName : String );
begin
     Dictionary := ADictionary;
     Database := ADatabase;
     TableName := AtableName;
     TableMapper := nil;
     OldDictionary := nil;
     NewDictionary := nil;
     DoProcess := True;
     DontCheckRecordMapping := False;
end;

{ TReestructureNotifyItem  }

constructor TReestructureNotifyItem.Create( AName  : String;
                                            AEvent : TReestructureTableEvent );
begin
     inherited Create;
     Name := AName;
     Event := AEvent;
end;

{ TReestructureNotifyList }

procedure TReestructureNotifyList.Clear;

var  Index  : Integer;

begin
     For Index := 0 to Count - 1 do
       TReestructureNotifyItem( Items[ Index ] ).Free;
     inherited;
end;

function TReestructureNotifyList.FindByName( const Name : String ) : TReestructureNotifyItem;

var  Index : Integer;
     ReestructureItem : TReestructureNotifyItem;

begin
     Result := nil;
     For Index := 0 to Count - 1 do
       begin
       ReestructureItem := TReestructureNotifyItem( Items[ Index ] );
       If   Assigned( ReestructureItem )
       then If   CompareText( Name, ReestructureItem.Name )=0
            then begin
                 Result := ReestructureItem;
                 Break;
                 end;
       end;
end;

{ TRecoverNotifyItem }

constructor TRecoverNotifyItem.Create( AName  : String;
                                       AEvent : TRecoverTableEvent );
begin
     inherited Create;
     Name := AName;
     Event := AEvent;
end;

{ TRecoverNotifyList }

procedure TRecoverNotifyList.Clear;

var  Index  : Integer;

begin
     For Index := 0 to Count - 1 do
       TRecoverNotifyItem( Items[ Index ] ).Free;
     inherited;
end;

function TRecoverNotifyList.FindByName( const Name : String ) : TRecoverNotifyItem;

var  Index : Integer;
     RecoverItem : TRecoverNotifyItem;

begin
     Result := nil;
     For Index := 0 to Count - 1 do
       begin
       RecoverItem := TRecoverNotifyItem( Items[ Index ] );
       If   Assigned( RecoverItem )
       then If   CompareText( Name, RecoverItem.Name )=0
            then begin
                 Result := RecoverItem;
                 Break;
                 end;
       end;
end;

{ TBaseSessionDataModule }

constructor TBaseSessionDataModule.Create( AProgramaNumber        : SmallInt;
                                           AClientApplicationPath : String;
                                           AClientType            : TClientType;
                                           AComputerName          : String = '';
                                           AUserName              : String = '';
                                           AClientID              : String = '' );

var  TmpDataPath : String;
     Guid : TGuid;

begin
     inherited Create( nil );

     FProgramNumber := AProgramaNumber;
     FClientType := AClientType;
     FClientID := AClientID;
     FRootDataPath := AddPathDelim( AClientApplicationPath { ApplicationPath } );
     FComputerName := AComputerName;
     FUserName := AUserName;
     FStartedAt := Now;

     DatabaseUpdateRequested := False;

     {$IFDEF DEBUGAPP}
     DBSession.Timeout := 600000;
     {$ENDIF}

     DBSession.ServerEngine := dmServer.ServerEngine;
     DBSession.Active := True;

     FDictionaryList := TList< TnxeDatabaseDictionary >.Create;
     FModuleDictionary := TDictionary< String, TDataModule >.Create;
     FRestrictedTableNames := TStringList.Create;
     FReestructureNotifyList := TReestructureNotifyList.Create;
     FRecoverNotifyList := TRecoverNotifyList.Create;
     FTransactionStack := TStack< TTransactionTag >.Create;

     FID := SessionDataList.Add( Self );

     // Asignando el directorio temporal (podría ser configurable)

     TmpDataPath := AddPathDelim( ApplicationPath ) + 'temp\';

     If   FClientID=''
     then begin
          CreateGUID( Guid  );
          FClientID := StrRemoveChars( Guid.ToString, [ '{', '}' ] ); // Por el formato JSON
          end;

     FMainDataModule := TMainDataModule.Create( Self );

     ConnectionPool.Database := TMainDataModule( FMainDataModule ).Database;
     ConnectionPool.Active := True;

     FTemporalDataPath := AddPathDelim( AddPathDelim( TmpDataPath ) + TmpDirBaseName + FClientID );

     If   not IsDesignTime
     then begin

          CreateDirPath( FTemporalDataPath );

          SetupTemporalDatabase( TemporalDatabase );
          SetupTemporalDatabase( ExportsDatabase, 'exports' );
          SetupTemporalDatabase( ImportsDatabase, 'imports' );

          InMemoryDatabase.Active := True;
          end;

end;

procedure TBaseSessionDataModule.DataModuleCreate(Sender: TObject);
begin
     inherited;

     DBSession.EventLog := dmServer.EventLog;

end;

procedure TBaseSessionDataModule.DataModuleDestroy(Sender: TObject);
begin
     //..
end;

destructor TBaseSessionDataModule.Destroy;
begin

     try

       SessionDataList.Remove( Self );

       {
       If   Assigned( FClientSession )
       then FClientSession.CloseSessionService( FId );
       }
       ConnectionPool.Active := False;
       ConnectionPool.Database := nil;

       If   Assigned( FEnterpriseDataModule )
       then try
              FEnterpriseDataModule.Free;
              FEnterpriseDataModule := nil;
            except on E : Exception do
              LogException( E, Self );
              // Debe continuar para limpiar el resto de componentes
            end;

       FMainDataModule.Free;
       FMainDataModule := nil;

       FModuleDictionary.Free;
       FDictionaryList.Free;

       FRestrictedTableNames.Free;
       FReestructureNotifyList.Free;
       FRecoverNotifyList.Free;
       FTransactionStack.Free;

       If   not IsDesignTime
       then begin

            TemporalDatabase.Close;
            ImportsDatabase.Close;
            ExportsDatabase.Close;
            InMemoryDatabase.Close;

            If   DBSession.Active
            then begin
                 DBSession.CloseInactiveTables;
                 DBSession.CloseInactiveFolders;  // Imprescindible si se quiere borrar el subdirectorio temporal
                 DBSession.Close;
                 end;

            If   Pos( TmpDirBaseName, FTemporalDataPath )<>0  // Una comprobación sensata
            then EraseDirectory( FTemporalDataPath, True );

            end;

     except on E : Exception do
       LogException( E, Self );
       end;

     inherited;
end;

function TBaseSessionDataModule.GetNotificationCallback: INotificationCallback;
begin
     Result := FNotificationCallBack;
end;

function TBaseSessionDataModule.GetProgressCallback: IProgressCallback;
begin
     Result := FProgressCallBack;
end;

procedure TBaseSessionDataModule.SendException( E         : Exception;
                                                Component : TComponent = nil;
                                                InfoMsg   : String = '' );

var NotificationType : TNotificationType;

begin
     try
       LogException( E, Component );
       If   E is EAbort
       then NotificationType := ntAbort
       else NotificationType := ntExceptionError;
       SendNotification( NotificationType, ExceptionMessage( E, True ), InfoMsg );
     except
       end;
end;

procedure TBaseSessionDataModule.CleanNotificationData;
begin
     FLastNotificationType := ntNone;
     FLastNotificationCaption := '';
     FLastNotificationDescription := '';
end;

function TBaseSessionDataModule.SendNotification( NotificationType : TNotificationType;
                                                  Caption          : String = '';
                                                  Description      : String = '' ) : Boolean;
begin
     try
       FLastNotificationType := NotificationType;
       FLastNotificationCaption := Caption;
       FLastNotificationDescription := Description;
       If   Assigned( FNotificationCallBack )
       then Result := FNotificationCallBack.SendNotification( NotificationType, Caption, Description )
       else Result := False;
     except
       Result := False;
       end;
end;

procedure TBaseSessionDataModule.StartProgress( MarqueeMode : Boolean = False;
                                                MaxValue    : LongInt = 100 );
begin
     If   Assigned( FProgressCallBack )
     then FProgressCallBack.StartProgress( MarqueeMode, MaxValue );
end;

function TBaseSessionDataModule.PushTransaction( const Database : TnxDatabase;
                                                       Notify   : Boolean = False ) : TTransactionTag;

var TransactionTag : TTransactionTag;

begin
     Inc( FCurrentTransactionId );

     TransactionTag.Id := FCurrentTransactionId;
     TransactionTag.SessionDataModule := Self;
     TransactionTag.Database := Database;
     TransactionTag.Notify := Notify;

     FTransactionStack.Push( TransactionTag );

     Result := TransactionTag;
end;

function TBaseSessionDataModule.StartTransaction( MainDatabase : Boolean = False;
                                                  Notify       : Boolean = False ) : TTransactionTag;

var  Database : TnxDatabase;

begin

     If   MainDatabase
     then Database := TMainDataModule( FMainDataModule ).Database
     else Database := TEnterpriseDataModule( FEnterpriseDataModule ).Database;

     Database.StartTransaction;

     If   Notify
     then SendNotification( ntInformation, RsStartTransaction );

     Result := PushTransaction( Database, Notify );
end;

function TBaseSessionDataModule.StartTransactionWith( const ATables : array of TnxTable;
                                                            Notify  : Boolean ) : TTransactionTag;
begin
     var Database := ATables[ 0 ].Database;
     Database.StartTransactionWith( ATables );
     If   Notify
     then SendNotification( ntInformation, RsStartTransaction );
     Result := PushTransaction( Database, Notify );
end;

function TBaseSessionDataModule.SendProgress( ObjectName : String;
                                              Percent1   : SmallInt = 0;
                                              Percent2   : SmallInt = 0  ) : Boolean;
begin
     If   Assigned( FProgressCallBack )
     then Result := FProgressCallBack.SendProgress( ObjectName, Percent1, Percent2 )
     else Result := False;
end;

procedure TBaseSessionDataModule.EndProgress;
begin
     If   Assigned( FProgressCallBack )
     then FProgressCallBack.EndProgress;
end;

procedure TBaseSessionDataModule.SetFechaHoy(Value: TDate);
begin
     FFechaHoy := Value;
end;

procedure TBaseSessionDataModule.SetNotificationCallback( const ACallback : INotificationCallback );
begin
     FNotificationCallBack := ACallback;
end;

procedure TBaseSessionDataModule.SetProgressCallback( const ACallback : IProgressCallback );
begin
     FProgressCallBack := ACallback;
end;

procedure TBaseSessionDataModule.AddModule( Name : String; Module : TDataModule );
begin
     FModuleDictionary.Add( Name, Module );
end;

function TBaseSessionDataModule.GetModuleByName( Name : String ) : TDataModule;

var  DataModule : TDataModule;

begin
     If   FModuleDictionary.TryGetValue( Name, DataModule )
     then Result := DataModule
     else Result := nil;
end;

procedure TBaseSessionDataModule.CloseInactiveTables;
begin

     If   DBSession.Active
     then DBSession.CloseInactiveTables;

     { Solo hay que llamar a CloseInactiveTables, cuando ya no se quiera trabajar más con la base de datos,
       porque cierra incluso los ficheros de configuración como $SQL$PROCEDURES o $SQL$FUNCTIONS }

end;

procedure TBaseSessionDataModule.CloseSession;
begin
     Free;
end;

procedure TBaseSessionDataModule.CloseSessionDatabases;

var  Index : SmallInt;

begin
     With DBSession do
       For Index := 0 to DatabaseCount - 1 do
         Databases[ Index ].Close;
end;

function TBaseSessionDataModule.InitializeDatabase( Database   : TnxDatabase;
                                                    UpdateInfo : Boolean = True ) : Boolean;

var  DictionaryIndex : SmallInt;
     DatabaseDictionary : TnxeDatabaseDictionary;

     IsDatabaseActive,
     IsDictionaryActive : Boolean;
     DictTableList : TStringList;
     TableIndex : SmallInt;
     TableName : String;

begin

     { El cometido de esta función es crear aquellas tablas que, por algún motivo, falten en la base de datos.
       No se verifica que las tablas existentes estén actualizadas
     }

     try

       Result := False;
       FInitializingDatabase := True;

       SendNotification( ntStartSubprocess, RsMsg13 );

       If   Assigned( Database )
       then try

              For DictionaryIndex := 0 To DictionaryList.Count - 1 do
                begin
                DatabaseDictionary := TnxeDatabaseDictionary( DictionaryList.Items[ DictionaryIndex ] );
                If   DatabaseDictionary.TargetDatabase=Database
                then begin

                     IsDictionaryActive := DatabaseDictionary.Active;
                     IsDatabaseActive := Database.Active;

                     DictTableList := TStringList.Create;

                     try

                       DatabaseDictionary.Open;
                       Database.Open;

                       try

                         DatabaseDictionary.GetTableNames( DictTableList );

                         For TableIndex := 0 to DictTableList.Count - 1 do
                           begin
                           TableName := DictTableList.Strings[ TableIndex ];
                           SendNotification( ntRecord, TableName );
                           If   not Database.TableExists( TableName, '' )
                           then DatabaseDictionary.CreateTable( TableName, True );
                           end;

                         DatabaseDictionary.Setup;

                       finally
                         DatabaseDictionary.Active := IsDictionaryActive;
                         Database.Active := IsDatabaseActive;
                         end;

                     finally
                       DictTableList.Free;
                       end;


                     end;

                end;

              If   UpdateInfo
              then UpdateDatabaseInfo( Database, VersionInfo.MajorVersion, VersionInfo.MinorVersion, VersionInfo.Release, VersionInfo.Build );

              Result := True;

            except on E : Exception do
              begin
              SendNotification( ntExceptionError, RsMsg16, ExceptionMessage( E ) );
              raise;
              end;
            end;

     finally
       FInitializingDatabase := False;
       SendNotification( ntEndSubprocess, '' );
       end;

end;

function TBaseSessionDataModule.RecoverDatabase( Database         : TnxDatabase;
                                                 RecoverTableList : TStringArray ) : Boolean;

var  TableName : String;
     ProcessCanceled : Boolean;

begin

     try

       Result := False;
       FRecoveringDatabase := True;
       ProcessCanceled := False;

       SendNotification( ntStartSubprocess, RsMsg12 );

       FPackDatabaseTableList := TStringList.Create;

       If   Assigned( Database )
       then try

              Database.GetTablesNeedingPack( FPackDatabaseTableList );

              For TableName in RecoverTableList do
                begin
                ProcessCanceled := SendNotification( ntRecord, TableName );
                If   ProcessCanceled
                then Break;
                RecoverTable( Database, TableName, True );
                If   FPackDatabaseTableList.IndexOf( TableName )<>-1  // Necesita ser compactada
                then PackTable( Database, TableName );
                end;

              Result := True;

            except
              SendNotification( ntError, RsMsg16 );
              end;

     finally
       FPackDatabaseTableList.Free;
       FRecoveringDatabase := False;
       SendNotification( ntEndSubprocess, '' );
       end;

end;

function TBaseSessionDataModule.GetTableDictionary( ATableName : TComponentName ) : TnxeDatabaseDictionary;

var  Index : SmallInt;

begin
     Result := nil;
     with DictionaryList do
       For Index := 0 to Count - 1 do
         With TnxeDatabaseDictionary( Items[ Index ] ) do
           If   TableExists( ATableName, '' )
           then begin
                Result := TnxeDatabaseDictionary( Items[ Index ] );
                Exit;
                end;
end;

{
function TBaseSessionDataModule.GetTableDictionary( TableName : String ) : TnxeDatabaseDictionary;

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
}

procedure TBaseSessionDataModule.NotifyDictionary( ADatabase    : TnxDatabase;
                                                   Notification : TDictionaryNotification );

var  Inx : SmallInt;
     DatabaseDictionary : TnxeDatabaseDictionary;

begin
     With DictionaryList do
       For Inx := 0 to Count - 1 do
         begin
         DatabaseDictionary := TnxeDatabaseDictionary( Items[ Inx ] );
         If   Assigned( DatabaseDictionary ) and ( DatabaseDictionary.TargetDatabase=ADatabase )
         then With DatabaseDictionary do
                case Notification of
                  dnVerify       : Verify;
                  dnBeforeUpdate : BeforeUpdate;
                  dnAfterUpdate  : AfterUpdate;
                  end;
         end;
end;

function TBaseSessionDataModule.GetDatabaseDictionary( AName : TComponentName ) : TnxeDatabaseDictionary;

var  Index : SmallInt;

begin
     Result := nil;
     with DictionaryList do
       For Index := 0 to Count - 1 do
         If   CompareText( TnxeDatabaseDictionary( Items[ Index ] ).Name, AName )=0
         then begin
              Result := Items[ Index ];
              Break;
              end;
end;

function TBaseSessionDataModule.GetTableDatabase( ASession   : TnxSession;
                                                  ATableName : String ) : TnxDatabase;

var  Index : SmallInt;

begin
     Result := nil;
     With ASession do
       For Index := 0 to DatabaseCount - 1 do
         If   not ( Databases[ Index ] is TnxeDatabaseDictionary )
         then If   ( Databases[ Index ].Active ) and ( Databases[ Index ].TableExists( ATableName, '' ) )
              then begin
                   Result := Databases[ Index ];
                   Exit;
                   end;
end;

procedure TBaseSessionDataModule.GetTableNames( AList           : TStrings;
                                                ADictionaryName : TComponentName = '' );

var  Index : SmallInt;
     Dictionary : TnxeDatabaseDictionary;
     DictTableList : TStringList;
     DictionaryActive : Boolean;

begin
     Assert( Assigned( AList ) );
     AList.BeginUpdate;
     DictTableList := TStringList.Create;
     If   Assigned( DictTableList )
     then try
            With DictionaryList do
              For Index := 0 to Count - 1 do
                begin
                Dictionary := TnxeDatabaseDictionary( Items[ Index ] );
                If   ( ADictionaryName='' ) or ( CompareText( Dictionary.Name, ADictionaryName )=0 )
                then With Dictionary do
                       begin
                       DictionaryActive := Active;
                       If   not DictionaryActive
                       then Open;
                       GetTableNames( DictTableList );
                       AList.AddStrings( DictTableList );
                       If   not DictionaryActive
                       then Close;
                       end;
                end;
         finally
           DictTableList.Free;
           AList.EndUpdate;
           end;

end;

function TBaseSessionDataModule.RecoverTable( Database        : TnxDatabase;
                                              TableName       : String;
                                              DiscardOldTable : Boolean = False ) : Boolean;

var   FailTable : TnxTable;
      ErrorCode : TnxResult;

begin
     try

       Result := False;
       FRecoveringTable := True;

       try

         If   Database.TableExists( TableName, '' )
         then begin

              SendNotification( ntInformation, '  ' + TableName );

              TaskInfo := nil;

              ErrorCode := Database.RecoverTableEx( TableName, '', TaskInfo );

              If   ErrorCode=DBIERR_NONE
              then begin

                   WaitForTaskEnding( TableName, TaskInfo );

                   // Database.Session.CloseInactiveTables;

                   If   DiscardOldTable and
                        Database.TableExists( TableName + '_Recovered', '' )
                   then begin
                        Database.DeleteTable( TableName, '' );
                        Database.ReNameTable( TableName + '_Recovered', TableName , '' );
                        end;

                   // Intento averiguar si hay registros perdidos

                   FailTable := TnxTable.Create( Self );
                   If   Assigned( FailTable )
                   then try
                          FailTable.TableName := TableName + '_Failed';
                          FailTable.Database := Database;
                          FailTable.Open;
                          If   FailTable.RecordCount<>0
                          then SendNotification( ntWarning, Format( RsMsg67, [ TableName ] ) + RsMsg68 )
                          else begin
                               FailTable.Close;
                               Database.DeleteTable( FailTable.TableName, '' );
                               end;
                        finally
                          FailTable.Free;
                          end;

                   NotifyRecoverEvent( TableName );
                   Result := True;
                   end
              else SendDatabaseError( nil, nil, ErrorCode, TableName );

              end;

         except on E : Exception do
           SendNotification( ntError, RsMsg63 + Format( RsMsg72, [ ExceptionMessage( E, True ) ] ) );
         end;

     finally
       FRecoveringTable := False;
       end;
end;

procedure TBaseSessionDataModule.SetupTemporalDatabase( Database     : TnxDatabase;
                                                        SubDirectory : String = '' );

var  StrAliasName : String;

begin
     With Database do
       try

         Close;

         Session := DBSession;
         If   SubDirectory='' // es el path temporal raiz
         then begin
              If   TemporalDataInMemory
              then AliasPath := '#'  // En memoria
              else AliasPath := AddPathDelim( TemporalDataPath );
              end
         else begin
              AliasPath := AddPathDelim( TemporalDataPath ) + SubDirectory;
              CreateDirPath( AliasPath );
              end;

         Open;

         If   SubDirectory=''
         then StrAliasName := 'temp'
         else StrAliasName := ExtractFileName( SubDirectory );

       except
         ShowNotification( ntError, RsMsg10, Format( RsMsg11, [ AliasPath ] ) );
         raise EnxDatabaseError.Create( JoinMessage( RsMsg10, Format( RsMsg11, [ AliasPath ] ) ) );
         end;

end;

// CreateTemporalSQLTable
//   @Database es la base de datos en la que se ejecutará la sentencia SQL, por defecto EnterpriseDatabase.
//   La tabla se creará en TemporalDatabase

function  TBaseSessionDataModule.CreateTemporalSQLTable( var Table            : TnxeTable;
                                                             SQLCreateCommand : String;
                                                             ATableType       : TTableType = ttVirtual;
                                                             Database         : TnxeDatabase = nil ) : String;  // TmpTableName

var  TmpTableName : String;

begin

     // Es evidente que si Table no está asignada se producirá una excepción

     Result := GetTemporalTableName( TemporalDatabase, Table.TableName );

     TmpTableName := '"' + TemporalDatabase.AliasPath + '".' + Result;
     If   not Assigned( Database )
     then Database := TEnterpriseDataModule( EnterpriseDataModule ).Database;

     // En SQLCreateCommand debe ir una sentencia de tipo Create Table <TableName> ...  o SELECT INTO <TableName> ...

     SQLCreateCommand := StringReplace( SQLCreateCommand, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );

     Database.ExecQuery( SQLCreateCommand, [] );

     With Table do
       begin
       Close;
       Database := TemporalDatabase;
       PreserveTemporalTableName := True;  // Ya tiene un nombre asignado y se ha definido a partir de un asentencia SQL
       TableName := Result;
       TableType := ATableType;
       Open;
       end;

end;

procedure TBaseSessionDataModule.WaitForTaskEnding( TableName : String;
                                                    TaskInfo  : TnxAbstractTaskInfo );

var  CancelTask,
     Done : Boolean;
     LastPercent : SmallInt;

begin
     If   Assigned( TaskInfo )
     then try
            Done := False;
            LastPercent := 0;
            While not Done do
              begin

              Sleep( 250 );
              TaskInfo.GetStatus( Done, TaskStatus );
              CheckStatus( TaskStatus.TsErrorCode );
              CancelTask := False;
              If   ( TaskStatus.TsPercentDone<>0 ) and ( TaskStatus.TsPercentDone<>LastPercent )
              then begin
                   // El -1 del primer porcentaje indica que ese valor no cambia
                   CancelTask := SendProgress( TableName, -1, TaskStatus.TsPercentDone );
                   LastPercent := TaskStatus.TsPercentDone;
                   end;

              If   CancelTask
              then Abort;

              end;

          finally
            If   Assigned( TaskInfo )
            then begin
                 try
                   TaskInfo.Cancel;
                 except
                   end;
                 TaskInfo.Free;
                 end;
            end;
end;

// Procedimientos para Backup

procedure TBaseSessionDataModule.BackupTable( Database,
                                              BackupDatabase : TnxDatabase;
                                              TableName      : String );

var   SourceTable,
      BackupTable : TnxTable;
      ATableMapper : TnxTableMapperDescriptor;

begin
     try

       FBackingUpTable := True;

       try
         If   Database.TableExists( TableName, '' )
         then begin

              SendNotification( ntInformation, '  ' + TableName );

              TaskInfo := nil;

              BackupDatabase.Open;  // Por si acaso
              BackupDatabase.DeleteTable( TableName, '' );

              Database.BackupTableEx( TableName, '', BackupDatabase, TaskInfo );

              WaitForTaskEnding( TableName, TaskInfo );

              // Las tablas de backup no contienen indices, así que la reestructuro para que quede exactamente igual que la original

              SourceTable := TnxeTable.Create( Self );
              SourceTable.Database := Database;
              SourceTable.TableName := TableName;

              try

                SourceTable.Open;

                BackupTable := TnxeTable.Create( Self );

                try
                  BackupTable.Database := BackupDatabase;
                  BackupTable.TableName := TableName;

                  ATableMapper := TnxTableMapperDescriptor.Create;

                  try
                    ATableMapper.MapAllTablesAndFieldsByName( SourceTable._Dictionary, SourceTable._Dictionary, dlaBestFit );

                    TaskInfo := nil;
                    BackupTable.RestructureTableEx( SourceTable._Dictionary, ATableMapper, TaskInfo );

                    WaitForTaskEnding( TableName, TaskInfo );

                  finally
                    ATableMapper.Free;
                    end;

                finally
                  BackupTable.Free;
                  end;

              finally
                SourceTable.Close;
                SourceTable.Free;
                end;

              end;

       except on E : Exception do
         SendNotification( ntError, RsMsg63 + Format( RsMsg72, [ ExceptionMessage( E, True ) ] ) );
         end;


     finally
       FBackingUpTable := False;
       end;
end;

{
procedure TBaseSessionDataModule.BackupProcessNotification( sender : TObject );
begin
     If   Assigned( FOnUpdateTableProgress )
     then With ProcessData do
            begin
            Inc( ProcessPercent );
            If   ProcessPercent>100
            then ProcessPercent := 0;
            FOnUpdateTableProgress( TableName, ProcessPercent );
            end;
end;
}

procedure TBaseSessionDataModule.PackTable( Database  : TnxDatabase;
                                            TableName : String );
begin
     try
       FPackingTable := True;

       If   Database.TableExists( TableName, '' )
       then begin

            SendNotification( ntInformation, '  ' + TableName );

            TaskInfo := nil;
            Database.PackTableEx( TableName, '', TaskInfo );
            WaitForTaskEnding( TableName, TaskInfo );

            end;

     finally
       FPackingTable := False;
       end;
end;


procedure TBaseSessionDataModule.ReIndexProcess;
begin

end;

procedure TBaseSessionDataModule.ReIndexTable( Database  : TnxDatabase;
                                               TableName : String );

var   IndexID : LongInt;
      // SegmentSize : SmallInt;
      DataTable : TnxeTable;

begin
     If   Database.TableExists( TableName, '' )
     then try
            FReindexingTable := True;

            try
              DataTable := TnxeTable.Create( self );
              try

                DataTable.Database  := Database;
                DataTable.TableName := TableName;
                DataTable.Open;

                {
                If   Assigned( FOnUpdateTableProgress )
                then FOnUpdateTableProgress( TableName, 0 );
                }
                With DataTable do
                  begin
                  // SegmentSize := 100 div DataDictionary.IndicesDescriptor.IndexCount;
                  For IndexID := 0 to DataDictionary.IndicesDescriptor.IndexCount - 1 do
                    begin
                    TaskInfo := nil;
                    Database.ReIndexTableEx( TableName, '', IndexID, TaskInfo );
                    WaitForTaskEnding( TableName, TaskInfo );
                    end;
                  end;

              finally
                DataTable.Free;
                end;

            except
              end;




           finally
             FReindexingTable := False;
             end;
end;

function TBaseSessionDataModule.ReStructureTable( Database   : TnxDatabase;
                                                  Dictionary : TnxeDatabaseDictionary;
                                                  TableName  : String ) : Boolean;

var   Status : TnxResult;
      Index,
      FieldIndex : SmallInt;
      ATableMapper : TnxTableMapperDescriptor;
      ARecordMapper : TnxRecordMapperDescriptor;
      OldDictionary,
      NewDictionary : TnxDataDictionary;
      ReestructureData : TReestructureData;
      OldFieldName : String;
      {
      RecordCount,
      RecNo : LongInt;
      Table : TnxeTable;
      GenerateIds : Boolean;
      IdField : TField;
      AutoIncFieldIndex : Integer;
      AutoIncValue : TnxWord32;
      }
      FieldMapperIndex : Integer;

const IdFieldName = 'Id';

begin

     try

       FRestructuringTable := True;
       Result := True;

       SendProgress( TableName, -1, 0 );

       TaskInfo := nil;
       Status := DBIERR_NONE;

       ReestructureData.SetUp( Dictionary, Database, TableName );

       OldDictionary := TnxDataDictionary.Create;
       NewDictionary := TnxDataDictionary.Create;
       ATableMapper := TnxTableMapperDescriptor.Create;

       If   Assigned( OldDictionary ) and
            Assigned( NewDictionary ) and
            Assigned( ATableMapper )
       then try

              Database.GetDataDictionary( TableName, '', OldDictionary );
              Dictionary.GetDataDictionary( TableName, '', NewDictionary );
              ATableMapper.MapAllTablesAndFieldsByName( OldDictionary, NewDictionary, dlaBestFit );

              ARecordMapper := TnxRecordMapperDescriptor( ATableMapper.RecordMapper );

              ReestructureData.DatabaseComparableVersion := FUpdatingDatabaseComparableVersion;
              ReestructureData.TableMapper := ATableMapper;
              ReestructureData.RecordMapper := ARecordMapper;
              ReestructureData.OldDictionary := OldDictionary;
              ReestructureData.NewDictionary := NewDictionary;

              NotifyReestructureEvent( reBefore, ReestructureData );

              // Si se ha puesto DoProcess a false en el evento anterior , simplemente se cancela el proceso.
              // No es necesariamente un error (si se desea provocar un error basta con generar una excepción)

              // Si en el diccionario queda la definición de alguna tabla de versiones obsoletas que ya no se utiliza
              // nos saltamos su actualización e intentamos suprimirla.

              If   ReestructureData.DoProcess
              then If   NewDictionary.Version>2
                   then begin

                        // Compruebo si hay en las descripciones sinónimos de campos (los utilizo para cambiar los nombres de algunos campos)

                        If   not ReestructureData.DontCheckRecordMapping
                        then With NewDictionary.FieldsDescriptor do
                               For Index := 0 to FieldCount - 1 do
                                 With FieldDescriptor[ Index ] do
                                     begin

                                     If   FdDesc=''
                                     then OldFieldName := Name
                                     else OldFieldName := FdDesc;

                                     FieldIndex := OldDictionary.FieldsDescriptor.GetFieldFromName( OldFieldName );
                                     If   FieldIndex<>-1
                                     then If   FdDesc<>''
                                          then ARecordMapper.AddMapping( FdDesc, Name, dlaBestFit );

                                     // Siempre aplico los valores por defecto si el campo es nulo

                                     FieldMapperIndex := ARecordMapper.FieldMapperIndexOf( Name );
                                     If   FieldMapperIndex>=0
                                     then ARecordMapper.FieldMapper[ FieldMapperIndex ].ApplyDefault := True;

                                     end;

                        // Puesto que solo se puede realizar la regeneración desde el servidor, puedo comparar el LocaleID de las tablas con la del SO para ver si coinciden

                        If   not Assigned( NewDictionary.LocaleDescriptor ) or
                             ( Assigned( NewDictionary.LocaleDescriptor ) and ( NewDictionary.LocaleDescriptor.Locale<>GetThreadLocale ) )
                        then NewDictionary.AddLocaleDescriptor;

                        {
                        If   Assigned( FOnReestructureMap )
                        then FOnReestructureMap( aTableMapper );
                        }

                        Status := Database.RestructureTableEx( TableName, '', NewDictionary, ATableMapper, TaskInfo );
                        CheckStatus( Status );

                        WaitForTaskEnding( TableName, TaskInfo );

                        Database.Session.CloseInactiveTables;

                        {
                        GenerateIds := not OldDictionary.FieldsDescriptor.HasAutoIncField( AutoIncFieldIndex ) and
                                       NewDictionary.FieldsDescriptor.HasAutoIncField( AutoIncFieldIndex );

                        If   GenerateIds
                        then begin
                             Table := TnxeTable.Create( Self );
                             If   Assigned( Table )
                             then try

                                    Table.TableType := ttRecover;
                                    Table.Database := Database;
                                    Table.TableName := TableName;
                                    Table.DatabaseDictionary := Dictionary;
                                    Table.Open;

                                    RecordCount := Table.RecordCount;
                                    RecNo := 1;

                                    AutoIncValue := 1;

                                    IdField := Table.Fields.FieldByName( IdFieldName );
                                    If   Assigned( IdField )
                                    then try

                                           While not Table.Eof do
                                             begin

                                             Table.Edit;
                                             IdField.Value := AutoIncValue;
                                             Inc( AutoIncValue );
                                             Table.Post;

                                             Percent := ( RecNo * 100 ) div RecordCount;
                                             If   ( Percent<>0 ) and ( Percent<>LastPercent )
                                             then begin
                                                  FClientSession.SendProgress( TableName, 0, Percent );
                                                  LastPercent := Percent;
                                                  end;

                                             Inc( RecNo );

                                             Table.Next;
                                             end;

                                           // Actualizo el valor del autoinc de la tabla

                                           Table.SetAutoIncValue( AutoIncValue );

                                         except on E : Exception do

                                           end;

                                  finally
                                    Table.Free;
                                    end;
                             end;

                        }

                        If   Status=DBIERR_NONE
                        then NotifyReestructureEvent( reAfter, ReestructureData );

                        end
                   else begin
                        // Es una tabla obsoleta. Mejor borrar su definición del diccionario.
                        Dictionary.DeleteTable( TableName, '' );
                        end;


        finally
          ATableMapper.Free;
          OldDictionary.Free;
          NewDictionary.Free;
          Result := ( Status=DBIERR_NONE ) or not ReestructureData.DoProcess;
          end;

     finally
       FRestructuringTable := False;
       end;

end;

function  TBaseSessionDataModule.VerifyTable( Database   : TnxDatabase;
                                              Dictionary : TnxeDatabaseDictionary;
                                              TableName  : String ) : Boolean;

var  DataTable : TnxeTable;
     ReestructureData : TReestructureData;

begin
     UpdatingTable := True;
     Result := False;
     DataTable := TnxeTable.Create( Self );
     If   Assigned( DataTable )
     then try

            DataTable.TableType := ttRecover;
            DataTable.Database := Database;
            DataTable.TableName := TableName;
            DataTable.DatabaseDictionary := Dictionary;
            DataTable.Open;

            ReestructureData.SetUp( Dictionary, Database, TableName );
            ReestructureData.OldDictionary := DataTable._Dictionary;

            ReestructureData.DoProcess := DataTable.StructChanged( True );

            NotifyReestructureEvent( reCheck, ReestructureData );

            DataTable.Close;

            If   ReestructureData.DoProcess
            then Result := ReStructureTable( Database, Dictionary, TableName )
            else Result := True;

          finally
            DataTable.Free;
            UpdatingTable := False;
            end;
end;


procedure TBaseSessionDataModule.SetupDatabaseDictionary( ADatabaseDictionary : TnxeDatabaseDictionary;
                                                          ADatabase           : TnxDatabase );
begin
     With ADatabaseDictionary do
       try
         Active := False;
         AliasPath := ApplicationDataPath + ExtractFileName( AliasPath );
         Session := DBSession;
         TargetDatabase := ADatabase;
         If   StateTransition=nxstNone
         then Active := True;

         DictionaryList.Add( ADatabaseDictionary );

       except
         ShowNotification( ntStop, Format( RsMsg6, [ AliasPath ] ), RsMsg78 + RsMsg80 );
         // Un diccionario que no existe es un error de configuración grave. Salgamos de aquí lo antes posible.
         raise EnxDatabaseError.Create( JoinMessage( Format( RsMsg6, [ AliasPath ] ), RsMsg78 + RsMsg80 ) );
         end;
end;

function TBaseSessionDataModule.GetExportDirectory : String;
begin
     Result := ExportsDatabase.AliasPath;
end;

function TBaseSessionDataModule.GetImportDirectory : String;
begin
     Result := ImportsDatabase.AliasPath;
end;

procedure TBaseSessionDataModule.AddReestructureNotification( TableName : String;
                                                              Event     : TReestructureTableEvent );
begin
     FReestructureNotifyList.Add( TReestructureNotifyItem.Create( TableName, Event ) );
end;

procedure TBaseSessionDataModule.NotifyReestructureEvent(     EventType        : TReestructureEventType;
                                                          var ReestructureData : TReestructureData );

var  ReestructureNotifyItem : TReestructureNotifyItem;

begin
     With FReestructureNotifyList do
       begin
       ReestructureNotifyItem := FindByName( ReestructureData.TableName );
       If   Assigned( ReestructureNotifyItem )
       then With ReestructureNotifyItem do
              If   Assigned( Event )
              then Event( EventType, ReestructureData );
       end;
end;

procedure TBaseSessionDataModule.AddRecoverNotification( TableName : String;
                                                         Event     : TRecoverTableEvent );
begin
     FRecoverNotifyList.Add( TRecoverNotifyItem.Create( TableName, Event ) );
end;

procedure TBaseSessionDataModule.NotifyRecoverEvent( TableName : String  );

var  RecoverNotifyItem : TRecoverNotifyItem;

begin
     With FRecoverNotifyList do
       begin
       RecoverNotifyItem := FindByName( TableName );
       If   Assigned( RecoverNotifyItem )
       then With RecoverNotifyItem do
              If   Assigned( Event )
              then Event( TableName );
       end;
end;

function TBaseSessionDataModule.EnterpriseDataPath( ADataPath       : String;
                                                    UnCodigoEmpresa : String = '' ) : String;
begin
     Result := AddDataDirectory( ADataPath, UnCodigoEmpresa );
end;

function TBaseSessionDataModule.AddDataDirectory( ADataPath       : String;
                                                  UnCodigoEmpresa : String = '' ) : String;

var  Path : String;

begin
     If   ADataPath=''
     then ADataPath := RootDataPath {ApplicationPath };
     If   UnCodigoEmpresa=''
     then UnCodigoEmpresa := FCodigoEmpresa;
     Path := UpperCase( RemovePathDelim( ADataPath ) );
     If   UpperCase( Copy( Path, Length( Path ) - 7, 5 ) )<>'DATA_'  // El Path ya incluye el directorio destino
     then Result := AddPathDelim( ADataPath ) + 'data_' + UnCodigoEmpresa
     else Result := ADataPath;
end;

function TBaseSessionDataModule.RemoveDataDirectory( ADataPath : String ) : String;

var  DataPos : SmallInt;

begin
     DataPos := Pos( 'DATA_', UpperCase( ADataPath ) );
     If   DataPos=0
     then Result := ADataPath
     else Result := Copy( ADataPath, 1, Pred( DataPos ) );
end;
procedure TBaseSessionDataModule.AddRestrictedTables( TableNames : array of string );

var  Index : SmallInt;

begin
     For Index := 0 to High( TableNames ) do
       FRestrictedTableNames.Add( TableNames[ Index ] );
end;

function  TBaseSessionDataModule.IsARestrictedTable( TableName : string ) : Boolean;

var  Index : SmallInt;

begin
     With FRestrictedTableNames do
       For Index := 0 to Count - 1 do
         If   UpperCase( TableName )=UpperCase( Strings[ Index ] )
         then begin
              Result := True;
              Exit;
              end;
     Result := False;
end;

(*
function TBaseSessionDataModule.GetOpenSessions : Integer;

const StSessions = 'Open Sessions';
      StTCPIPTransport = 'TCP/IPv4';
      StNamedPipeTransport = 'Named Pipe';

var   ConexionesActivas : LongInt;  // Número de sesiones remotas
      ValueIndex : Integer;

function GetTransportSessions( StTransport : String ) : SmallInt;

var  ComponentList : TStringList;

begin
     Result := 0;
     ComponentList := TStringList.Create;
     try
       dmServer.ServerInfoPlugin.GetServerStatsComponentCaptions( StTransport, ComponentList );
       ValueIndex := ComponentList.IndexOf( StSessions );
       If   ValueIndex>=0
       then try
              ComponentList.Clear;
              dmServer.ServerInfoPlugin.GetServerStatsComponentValues( StTransport, ComponentList );
              Result := StrToInt( ComponentList[ ValueIndex ] );
            except
              end;
     finally
       ComponentList.Free;
       end;
end;

begin

     // Result := MainDataModule.MainSession.MainServerEngine.SessionCount;

     ConexionesActivas := -1;

     With MainDataModule do
       try
         try
           // NxRemoteServerInfoPlugin.Session := EnterpriseDataModule.UserDatabase.Session;
           // dmServer.ServerInfoPlugin.Active := True;
           ConexionesActivas := GetTransportSessions( StTCPIPTransport ) +  GetTransportSessions( StNamedPipeTransport );
         finally
           // RemoteServerInfoPlugin.Active := False;
           end;
       except
        end;

     Result := ConexionesActivas;

end;

*)

procedure TBaseSessionDataModule.GetDatabaseInfo(     ADatabase     : TnxDatabase;
                                                  var MajorVersion  : Word;
                                                  var MinorVersion  : Word;
                                                  var Release       : Word;
                                                  var Build         : Word;
                                                  var LastUpdate    : TDateTime;
                                                  var Options       : String );

procedure UpdateVersionInfo( Reload : Boolean = False );
begin
     If   Reload
     then begin
          DatabaseInfoTable.Open;
          DatabaseInfoTable.Last;
          If   not DatabaseInfoTable.Found
          then Exit;
          end;
     MajorVersion := DatabaseInfoTableMajorVersion.Value;
     MinorVersion := DatabaseInfoTableMinorVersion.Value;
     Release := DatabaseInfoTableRelease.Value;
     Build := DatabaseInfoTableBuild.Value;
     LastUpdate := DatabaseInfoTableUpdated.Value;
     Options := DatabaseInfoTableOptions.Value;
end;

procedure SetCurrentVersion;
begin
     With VersionInfo do
       UpdateDatabaseInfo( ADatabase, MajorVersion, MinorVersion, Release, Build );
     UpdateVersionInfo( True );
end;


begin

     MajorVersion := 0;
     MinorVersion := 0;
     Release := 0;
     Build := 0;
     LastUpdate := LowestDateTime;

     With DatabaseInfoTable do
       begin
       Close;
       Database := ADatabase;
       end;

     try

       With ADatabase do
         If   not TableExists( DatabaseInfoFileName, '' )
         then ExecQuery( SQLSet.GetSQLText( 'CreateDatabaseInfo' ), [] );

       try
         DatabaseInfoTable.Open;
         DatabaseInfoTable.Last;
         If   DatabaseInfoTable.Found
         then UpdateVersionInfo;
       finally
         DatabaseInfoTable.Close;
         end;

     except
       SendNotification( ntError, RsMsg76 + HtmlCR + RsMsg77 );
       Abort;
       end;

end;

function TBaseSessionDataModule.GetID: Integer;
begin
     Result := FID;
end;

function TBaseSessionDataModule.GetClientID : String;
begin
     Result := FClientID;
end;

procedure TBaseSessionDataModule.UpdateDatabaseInfo( ADatabase      : TnxDatabase;
                                                     AMajorVersion,
                                                     AMinorVersion,
                                                     ARelease,
                                                     ABuild         : Word;
                                                     AOption        : Char = #0 );

var  OptionsString : String;

begin

     ADatabase.Open;

     If   not ADatabase.TableExists( DatabaseInfoFileName, '' )
     then ADatabase.ExecQuery( SQLSet.GetSQLText( 'CreateDatabaseInfo' ), [] );

     With DatabaseInfoTable do
       try
         Close;
         Database := ADatabase;
         Open;
         If   FindKey( [ AMajorVersion, AMinorVersion, ARelease, ABuild ] )
         then begin
              Edit;
              OptionsString := DatabaseInfoTableOptions.Value;
              If   Pos( AOption, OptionsString )=0
              then DatabaseInfoTableOptions.Value := OptionsString + AOption;
              end
         else begin
              Append;
              DatabaseInfoTableMajorVersion.Value := AMajorVersion;
              DatabaseInfoTableMinorVersion.Value := AMinorVersion;
              DatabaseInfoTableRelease.Value := ARelease;
              DatabaseInfoTableBuild.Value := ABuild;
              DatabaseInfoTableOptions.Value := AOption;
              end;
         DatabaseInfoTableUpdated.Value := Now;
         Post;
       finally
         Close;
         end;
end;

function TBaseSessionDataModule.CheckDatabaseOption( ADatabase      : TnxDatabase;
                                                     AMajorVersion,
                                                     AMinorVersion,
                                                     ARelease,
                                                     ABuild         : Word;
                                                     AOption        : Char = #0 ) : Boolean;

var  OptionsString : String;

begin
     Result := False;
     With DatabaseInfoTable do
       try
         Close;
         Database := ADatabase;
         Open;
         If   FindKey( [ AMajorVersion, AMinorVersion, ARelease, ABuild ] )
         then begin
              OptionsString := DatabaseInfoTableOptions.Value;
              Result := Pos( AOption, OptionsString )<>0;
              end;
       finally
         Close;
         end;
end;

procedure TBaseSessionDataModule.CheckDatabaseVersion( Database      : TnxDatabase;
                                                       DiskVersion   : String;
                                                       CodigoEmpresa : String = '' );

var  CurrentVersion : String;
     PackingList : TStringList;

begin
     CurrentVersion := GetAppComparableVersion( False );
     If   CurrentVersion<DiskVersion
     then begin
          InitializationError := True;
          ShowNotification( ntError, RsMsg74, RsMsg75 );  // Se muestra en el log o en la ventana de notificaciones del servidor
          raise EnxDatabaseError.Create( JoinMessage( RsMsg74, RsMsg75 ) );
          end
     else If   CurrentVersion>DiskVersion
          then RequestDatabaseUpdate;

     // Aunque la versión sea la correcta puede haber alguna tabla que necesita ser adaptada porque tiene un NLS erróneo

     If   CodigoEmpresa<>'999'   // La Empresa de demostración se actualiza y ajusta en un proceso posterior
     then begin
          PackingList := TStringList.Create;
          try
            Database.GetTablesNeedingPack( PackingList );
            If   PackingList.Count>0
            then RequestDatabaseUpdate;
          finally
           PackingList.Free;
           end;
          end;

     // Cada vez que se abre la base de datos se notifica a los diccionarios por si se quiere
     // hacer alguna verificación adicional (versiones, chequeos, etc..)

     NotifyDictionary( Database, dnVerify );

end;

procedure TBaseSessionDataModule.RequestDatabaseUpdate;
begin
     DatabaseUpdateRequested := True;
     ShowNotification( ntWarning, RsMsg81 );
     If   FInitialized  // Si todavía no se ha completado la inicialización de la sesión, se pospone la notificación
     then SendNotification( ntUpdateDatabase, CodigoEmpresa, RsMsg81 );
     Abort;
end;

function TBaseSessionDataModule.SessionCount( CodigoEmpresa : String = '' ) : SmallInt;

var  Index,
     AC : SmallInt;

begin
     Ac := 0;
     With SessionDataList do
       For Index := 0 to Count - 1 do
         If   Assigned( Items[ Index ] )
         then If   ( CodigoEmpresa='' ) or ( CodigoEmpresa=Items[ Index ].CodigoEmpresa )
              then Inc( AC );
     Result := AC;
end;

procedure TBaseSessionDataModule.UpdateDatabase( CodigoEmpresa : String;
                                                 Database      : TnxDatabase );

var  Index,
     Percent : Integer;
     TableName : String;
     Dictionary : TnxeDatabaseDictionary;
     DictionaryList : TList;
     ProcessCanceled : Boolean;
     MajorVersion,
     MinorVersion,
     Release,
     Build : Word;
     LastUpdate : TDateTime;
     Options : String;

begin

     // Si CodigoEmpresa='' es la base de datos de la aplicación y el número de sesiones es el total

     If   SessionCount( CodigoEmpresa )>1
     then begin
          SendNotification( ntExceptionError, RsMsg82, RsMsg83 );
          Abort;
          end;

     DictionaryList := TList.Create;
     FUpdateDatabaseTableList := TStringList.Create;
     FPackDatabaseTableList := TStringList.Create;

     try

       GetDatabaseInfo( Database, MajorVersion, MinorVersion, Release, Build, LastUpdate, Options );
       FUpdatingDatabaseComparableVersion := GetComparableVersion( MajorVersion, MinorVersion, Release );

       Database.GetTableNames( FUpdateDatabaseTableList );
       Database.GetTablesNeedingPack( FPackDatabaseTableList );

       With FUpdateDatabaseTableList do
         For Index := 0 to Count - 1 do
           begin
           Percent := ( Succ( Index ) * 100 ) div Succ( Count );
           TableName := Strings[ Index ];
           ProcessCanceled := SendProgress( TableName, Percent, 0 );
           If   not ProcessCanceled and ( FPackDatabaseTableList.IndexOf( TableName )<>-1 ) // Necesita ser compactada
           then PackTable( Database, TableName );
           end;

       NotifyDictionary( Database, dnBeforeUpdate );

       With FUpdateDatabaseTableList do
         For Index := 0 to Count - 1 do
           begin

           Percent := ( Succ( Index ) * 100 ) div Succ( Count );
           TableName := Strings[ Index ];
           ProcessCanceled := SendProgress( TableName, Percent, 0 );

           If   not ProcessCanceled
           then begin

                Dictionary := GetTableDictionary( TableName );
                If   Assigned( Dictionary )
                then try

                       With DictionaryList do
                         If   IndexOf( Dictionary )=-1
                         then Add( Dictionary );

                       ProcessCanceled := SendProgress( TableName, Percent, 0 );

                       If   ProcessCanceled or not VerifyTable( Database, Dictionary, TableName )
                       then Abort;

                       Dictionary.Setup;

                     except on E : Exception do
                       begin
                       SendNotification( ntError, Format( RsMsg65, [ TableName ] ), ExceptionMessage( E ) );
                       Abort;
                       end;

                     end;

                end;

           end;

       finally
         FreeAndNil( FUpdateDatabaseTableList );
         FreeAndNil( FPackDatabaseTableList );
         FreeAndNil( DictionaryList );
         end;   

       InitializeDatabase( Database, { UpdateInfo } False );  // Es necesario por si existen tablas nuevas

       NotifyDictionary( Database, dnAfterUpdate );

       UpdateDatabaseInfo( Database, VersionInfo.MajorVersion, VersionInfo.MinorVersion, VersionInfo.Release, VersionInfo.Build );

end;

// Funciones de utilidad de la sesión

procedure TBaseSessionDataModule.SetupSessionParams( CodigoUsuario,
                                                     CodigoEmpresa  : String;
                                                     Fecha          : TDate;
                                                     NroMesInicial  : SmallInt );
begin

       // Inicializando algunos parámetros de la sesión

       FCodigoEmpresa := CodigoEmpresa;
       FCodigoUsuario := CodigoUSuario;
       FechaHoy := Fecha;

       // Hay que asignar FNroMesInicial antes de llamar a EjercicioFecha porque utiliza su valor

       If   ( NroMesInicial<1 ) or ( NroMesInicial>12 )
       then FNroMesInicial := 1
       else FNroMesInicial := NroMesInicial;

       If   FNroMesInicial=1
       then FNroMesFinal := 12
       else FNroMesFinal := FNroMesInicial - 1;

       FEjercicio := EjercicioFecha( Fecha );
       FEjercicioProximo := Succ( Ejercicio );
       FEjercicioAnterior := Pred( Ejercicio );

       FPrimerDiaEjercicio := EncodeDate(  FEjercicio, FNroMesInicial, 1 );

       If   FNroMesInicial>1
       then FUltimoDiaEjercicio := EncodeDate( FEjercicioProximo, FNroMesFinal, DaysInAMonth( FEjercicioProximo, FNroMesFinal ) )
       else FUltimoDiaEjercicio := EncodeDate( FEjercicio, FNroMesFinal, DaysInAMonth( FEjercicio, FNroMesFinal ) );

end;

function TBaseSessionDataModule.StrToDate(     St         : String;
                                           var Date       : TDateTime;
                                               DateFormat : TDateFormat = dfDefault ) : Boolean;

var   Code    : LongInt;
      InvalidYear : Boolean;
      Day,
      Month,
      Year : Word;

begin

     { de momento solo acepta dfDefault, dfInput Y dfSQL }

     case DateFormat of
       dfDefault : St := StrRemoveChars( St, [ FormatSettings.DateSeparator ] );
       dfSQL     : begin
                   St := StrRemoveChars( St, [ '-' ] );
                   St := Copy( St, 7, 2 ) + Copy( St, 5, 2 ) + Copy( St, 1, 4 );
                   end;
       end;

     Val( Copy( St, 1, 2 ), Day,   Code );
     If   Code<>0
     then Day := 0;
     Val( Copy( St, 3, 2 ), Month, Code );
     If   Code<>0
     then Month := 0;
     If   Length( St )=4
     then Year := YearOf( FechaHoy )
     else If   Length( St )=6
          then begin
               val( Copy( St, 5, 2 ), Year, Code );
               If   Code=0
               then begin
                    If   Year>50
                    then Inc( Year, 1900 )
                    else Inc( Year, 2000 );
                    end
               else Year := 0;
               end
          else If   Length( St )=8
               then val( Copy( St, 5, 4 ), Year, Code )
               else begin
                    Result := False;
                    Exit;
                    end;

     If   Month=0
     then Month := MonthOf( FechaHoy );
     If   Year=0
     then Year := YearOf( FechaHoy );

     Result := IsValidDate( Day, Month, Year, InvalidYear );
     If   Result
     then Date := EncodeDate( Year, Month, Day );

end;

{ Esta función devuelve el ejercicio al que pertenece la fecha en cuestión
 (teniendo en cuenta que puede tratarse de una Empresa de ejercicio partido) }

function TBaseSessionDataModule.EjercicioFecha( ADate : TDateTime) : Word;
begin
     Result := LibUtils.AccountingYear( ADate, FNroMesInicial );
end;

function TBaseSessionDataModule.IsValidYear( ADate         : TDateTime;
                                             ReferenceYear : Word = 0 ) : Boolean;
var   Day,
      Month,
      Year    : Word;

begin
     If   ValueIsEmpty( ADate )
     then Result := False
     else begin
          DecodeDate( ADate, Year, Month, Day );
          Result := IsValidYear( Day, Month, Year, ReferenceYear );
          end;
end;

function TBaseSessionDataModule.IsValidYear( Day,
                                             Month,
                                             Year          : Word;
                                             ReferenceYear : Word = 0 ) : Boolean;
begin

     If   ReferenceYear=0
     then ReferenceYear := FEjercicio;

     If   FNroMesInicial=1
     then Result := Year=ReferenceYear
     else Result := ( ( Year=ReferenceYear ) and ( Month>=FNroMesInicial ) ) or
                    ( ( Year=ReferenceYear + 1 ) and ( Month<FNroMesInicial ) );

end;

function TBaseSessionDataModule.IsValidDate(     Day,
                                                 Month,
                                                 Year          : Word;
                                             var InvalidYear   : Boolean ) : Boolean;

begin
     InvalidYear := False;
     Result := False;

     If   ( Day   in [ 1..31 ] ) and
          ( Month in [ 1..12 ] )
     then begin
          If   Month=2
          then begin
               If   IsLeapYear( Year )
               then Result := Day<=29
               else Result := Day<=28;
               end
          else Result := not( ( Month in [ 4, 6, 9, 11 ] ) and ( Day>30 ) );
          end;

     If   Result and ( Ejercicio<>0 )
     then If   FNroMesInicial=1
          then begin
               If   Year<>Ejercicio
               then begin
                    Result := False;
                    InvalidYear := True;
                    end;
               end
          else If   not IsValidYear( Day, Month, Year, Ejercicio )
               then begin
                    Result := False;
                    InvalidYear := True;
                    end;
end;

function TBaseSessionDataModule.EjercicioActual( Date : TDateTime ) : Boolean;
begin
     Result := IsValidYear( Date, FEjercicio );
end;

function  TBaseSessionDataModule.FechaPrimerDiaEjercicio( UnEjercicio : SmallInt = 0 ) : TDateTime;
begin
     If   UnEjercicio=0
     then UnEjercicio := FEjercicio;
     Result := EncodeDate( UnEjercicio, NroMesInicial, 1 );
end;

function TBaseSessionDataModule.FechaUltimoDiaEjercicio( UnEjercicio : SmallInt ) : TDateTime;
begin
     If   UnEjercicio=0
     then UnEjercicio := FEjercicio;
     If   FNroMesInicial>1
     then Inc( UnEjercicio );
     Result := EncodeDate( UnEjercicio, FNroMesFinal, DaysInAMonth( UnEjercicio, FNroMesFinal ) );
end;

procedure TBaseSessionDataModule.PeriodoEjercicio(     Ejercicio    : SmallInt;
                                                   var FechaInicial : TDateTime;
                                                   var FechaFinal   : TDateTime );

var  MesFinal : SmallInt;

begin
     If   FNroMesInicial=1
     then MesFinal := 12
     else MesFinal := FNroMesInicial - 1;

     FechaInicial := EncodeDate( Ejercicio, FNroMesInicial, 1 );
     If   FNroMesInicial>1
     then FechaFinal := EncodeDate( Ejercicio + 1, MesFinal, DaysInAMonth( Ejercicio + 1, MesFinal ) )
     else FechaFinal := EncodeDate( Ejercicio, MesFinal, DaysInAMonth( Ejercicio, MesFinal ) );
end;

function  TBaseSessionDataModule.CreateSQLTable( AOwner       : TComponent;
                                                 DatasetName,
                                                 SQLString    : String ) : TnxeTable;

var  TmpTableName  : String;

begin
     Result := nil;

     TmpTableName := GetTemporalTableName( TemporalDatabase, DataSetName );

     // En CreateSQL debe ir una sentencia Create Table <TableName> ( ... );

     SQLString := StringReplace( SQLString, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );

     TemporalDatabase.ExecQuery( SQLString, [] );

     Result := TnxeTable.Create( AOwner );

     With Result do
       begin
       Close;
       Database := TemporalDatabase;
       TableName := TmpTableName;
       TableType := ttVirtual;
       Open;
       end;

end;

function  TBaseSessionDataModule.CreateEmptyTable( AOwner     : TComponent;
                                                   BaseName,
                                                   CreateSQL  : String;
                                                   ATAbleType : TTableType = ttVirtual ) : TnxeTable;

var   TmpTableName : String;
      Table : TnxeTable;

begin
     Result := nil;

     TmpTableName := GetTemporalTableName( TemporalDatabase, BaseName );
     Table := TnxeTable.Create( AOwner );
     If   Assigned( Table )
     then begin

          // En CreateSQL debe ir una sentencia Create Table <TableName> ( ... );

         CreateSQL := StringReplace( CreateSQL, '<TableName>', TmpTableName, [ rfReplaceAll, rfIgnoreCase ] );
         TemporalDatabase.ExecQuery( CreateSQL, [] );

         With Table do
           begin
           Close;
           Database := TemporalDatabase;
           TableName := TmpTableName;
           TableType := ATableType;
           Open;
           end;

         end;

      Result := Table;
end;

{ TTransactionTag }

procedure TTransactionTag.Commit;
begin
     PopAndCheck;
     Database.Commit;
     If   Notify
     then SessionDataModule.SendNotification( ntInformation, RsCommit );
end;

procedure TTransactionTag.Rollback;
begin
     PopAndCheck;
     Database.Rollback;
     If   Notify
     then SessionDataModule.SendNotification( ntInformation, RsRollback );
end;

procedure TTransactionTag.PopAndCheck;
begin
     var TransactionTag := SessionDataModule.FTransactionStack.Pop;
     If   ( TransactionTag.Id<>0 ) and ( Id<>TransactionTag.Id )
     then begin
          // SessionDataModule.FTransactionStack.Clear;
          raise EnxDatabaseError.Create( RsMsg12 );
          end;
end;

initialization
   SessionDataList := TCompactList<TBaseSessionDataModule>.Create;

finalization
   SessionDataList.Free;

end.


