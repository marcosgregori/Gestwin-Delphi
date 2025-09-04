
unit MainData;

interface

uses SysUtils,
     Classes,
     Windows,
     Generics.Collections,

     nxsdTypes,
     nxsdConst,
     nxsdTableMapperDescriptor,
     nxsdRecordMapperDescriptor,
     nxsdFieldMapperDescriptor,
     nxsdServerEngine,
     nxsdDataDictionary,

     nxreRemoteServerEngine,
     nxtwWinsockTransport,

     nxllTypes,
     nxllUtils,
     nxllBde,
     nxllTransport,
     nxllZipCompressor,
     nxllRleCompressor,
     nxllComponent,
     nxllPlatformInterface,

     nxptBasePooledTransport,
     nxtmSharedMemoryTransport,
     nxtnNamedPipeTransport,
     nxseAutoComponent,
     nxdbBase,

     DB,
     nxDB,

     AppManager,

     nxsrSqlEngineBase,
     nxsqlEngine,
     Sqlset,
     nxllPluginBase,
     nxsiServerInfoPluginBase,
     nxsiServerInfoPluginClient,
     nxchCommandHandler,

     DataManager,
     BaseServerContainer,
     SectionData,
     BaseSessionData,
     nxsrServerEngine,
     
     kbmMemTable,
     kbmMWCustomConnectionPool,
     kbmMWCustomDataset,
     kbmMWNexusDB,
     kbmMWCustomSQLMetaData,
     kbmMWResolvers;

type


  TMainDataModule = class(TSectionDataModule)
    Database: TnxeDatabase;
    Dictionary: TnxeDatabaseDictionary;
    procedure SectionDataModuleDestroy(Sender: TObject);
  private

    FOnAppDatabaseUpdated : TSimpleEvent;
    FApplicationDataDirectory : String;

    // Esta variable global indica que se ha realizado al menos una reestructuracion

    FMajorVersion,
    FMinorVersion,
    FRelease,
    FBuild : Word;
    FLastUpdate : TDateTime;
    FOptions : String;

    // En formato VVRRBB  ( Version-Release-Build : 100306 )

    function GetComparableVersion : String;


  public

    constructor Create( SessionDataModule : TBaseSessionDataModule );
    destructor Destroy; override;

    procedure CheckVersionAndExecute( AMajorVersion, AMinorVersion, ARelease : SmallInt; ExecProc : TSimpleEvent );

    procedure Initialize;
    procedure DoAppDatabaseUpdated;

    property MajorVersion : Word read FMajorVersion;
    property MinorVersion : Word read FMinorVersion;
    property Release : Word read FRelease;
    property Build : Word read FBuild;
    property ComparableVersion : String read GetComparableVersion;

    property LastUpdate : TDateTime read FLastUpdate;

    property ApplicationDataDirectory : String read FApplicationDataDirectory;
    property OnAppDatabaseUpdated : TSimpleEvent read FOnAppDatabaseUpdated write FOnAppDatabaseUpdated;


  end;


var  ShowErrorDialog : Boolean = True;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   System.UITypes,
       Controls,
       ExtCtrls,
       Forms,
       Variants,
       IniFiles,
       DBConsts,
       TypInfo,
       LibUtils,
       Files,
       // HTMLRender,

       nxdbStrings,
       nxllBdeStrings,
       nxsdDefaultValueEngine,
       nxsdValidationEngine,

       nxdmServer;

       // La versión de la base de datos actual

const  // Errores de Nexus no incluidos en nxsrBase

       DBIERR_RESOURCELOCKED    = $3C01;
       DBIERR_TIMEOUT           = $3C65;


// TMainDataModule

{ NOTA : Utilizo una tabla y no un fichero ordinario (por ejemplo en formato XML) porque el acceso
         al directorio del usuario no está garantizado a través de un path desde un equipo cliente.
}

procedure TMainDataModule.DoAppDatabaseUpdated;
begin
     If   Assigned( FOnAppDatabaseUpdated )
     then FOnAppDatabaseUpdated;
     SessionDataModule.UpdateDatabaseInfo( Database, VersionInfo.MajorVersion, VersionInfo.MinorVersion, VersionInfo.Release, VersionInfo.Build );
end;

function TMainDataModule.GetComparableVersion : String;
begin

     // No se incluye el Build en la versión de la base de datos

     Result := AppManager.GetComparableVersion( FMajorVersion, FMinorVersion, FRelease );
end;

procedure TMainDataModule.CheckVersionAndExecute( AMajorVersion, AMinorVersion, ARelease : SmallInt; ExecProc : TSimpleEvent );
begin
     If   GetComparableVersion<AppManager.GetComparableVersion( AMajorVersion, AMinorVersion, ARelease )
     then ExecProc;
end;

destructor TMainDataModule.Destroy;
begin
     try
       inherited;
     except on E : Exception do
       LogException( E, Self );
       end;
end;

procedure TMainDataModule.SectionDataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.DictionaryList.Remove( Dictionary );
end;

constructor TMainDataModule.Create( SessionDataModule    : TBaseSessionDataModule );

const DataDirectory = 'data';
      DataDictionaryDirectory = 'dm00';

var   DataAliasPath : String;

begin

     inherited Create( SessionDataModule );

     FSectionDatabase := Database;

     If   not IsDesignTime
     then begin

          ShowErrorDialog := True;

          try

            // Cada sesión pasa el directorio raiz de la aplicación cliente (RootDataPath), de este modo se puede acceder a los datos de la aplicación
            // de cada directorio o instalación de Gestwin situada en un mismo equipo

            FApplicationDataDirectory := SessionDataModule.RootDataPath + DataDirectory;

            SessionDataModule.SetupDatabaseDictionary( Dictionary, Database );

            With Database do
              begin
              Session := SessionDataModule.DBSession;
              AliasPath := FApplicationDataDirectory;
              end;

            If   not DirectoryExists( FApplicationDataDirectory )
            then begin
                 CreateDirPath( FApplicationDataDirectory );
                 Initialize;
                 end;

            // Tener siempre disponible el Alias de la base de datos principal me permite utilizarlo en consulta SQL que
            // hago desde la base de datos de la Empresa (ie: SELECT * FROM data.Pais LEFT JOIN TiposIVAArticulo ... )

            UpdateDatabaseAlias( SessionDataModule.DBSession, DataDirectory, Database.AliasPath );

            Database.Open;

            // Cuando la sesión la inicia el servicio de actualizaciones no debe comprobarse la versión de la base de datos

            If   SessionDataModule.ClientType<>ctLicensing
            then begin

                 SessionDataModule.GetDatabaseInfo( Database, FMajorVersion, FMinorVersion, FRelease, FBuild, FLastUpdate, FOptions );

                 If   not SessionDataModule.UpdatingDatabase and
                      not SessionDataModule.InitializingDatabase
                 then SessionDataModule.CheckDatabaseVersion( Database, ComparableVersion );

                 end;

          except on E : Exception do
            begin
            InitializationError := True;
            If   not SessionDataModule.DatabaseUpdateRequested
            then SessionDataModule.SendNotification( ntError, ExceptionMessage( E, True ) );
            end;
          end;

          end;
end;

procedure TMainDataModule.Initialize;
begin
     Database.Close;

     SessionDataModule.InitializeDatabase( Database );

     With VersionInfo do
       SessionDataModule.UpdateDatabaseInfo( Database, MajorVersion, MinorVersion, Release, Build );  // Esta función abre la base de datos

end;

{ Este código lo mantengo porque es interesante

procedure TMainDataModule.GetDefaultTableFieldMap( Database        : TnxDatabase;
                                                   Dictionary      : TnxeDatabaseDictionary;
                                                   TableName       : String;
                                                   AFieldMap       : TStringList;
                                                   ADataDictionary : TnxDataDictionary );

var   Index : SmallInt;
      Fmi : integer;
      DataTable : TnxeTable;
      OldFieldMap  : TStringList;

begin
     DataTable   := TnxeTable.Create( self );
     OldFieldMap := TStringList.Create;
     try

       DataTable.Database := Database;
       DataTable.TableName := TableName;
       DataTable.Open;

       GetFieldNames( DataTable.DataDictionary, OldFieldMap, [] );

       DataTable.Close;
       DataTable.Database := Dictionary;
       DataTable.Open;

       ADataDictionary.Assign( DataTable.DataDictionary );  // El diccionario de la versión actual

       With DataTable.DataDictionary.FieldsDescriptor do
         For Index := 0 to FieldCount - 1 do
           With FieldDescriptor[ Index ] do
             begin
             Fmi := OldFieldMap.IndexOf( Name );
             If   Fmi>=0
             then AFieldMap.Add( Name + '=' + OldFieldMap[ Fmi ] );
             end;

     finally
       DataTable.Free;
       OldFieldMap.Free;
       end;

end;
}


initialization

finalization

end.
