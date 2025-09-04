
unit EnterpriseData;

interface

uses SysUtils,
     Classes,
     Windows,
     Generics.Collections,

     nxsdServerEngine,
     nxreRemoteServerEngine,
     nxptBasePooledTransport,
     nxtwWinsockTransport,
     nxllTransport,
     nxtmSharedMemoryTransport,
     nxtnNamedPipeTransport,
     nxllComponent,
     nxsrServerEngine,
     nxllPlatformInterface,
     nxsdTableMapperDescriptor,
     nxsdRecordMapperDescriptor,
     nxsdFieldMapperDescriptor,

     nxsdTypes,
     nxllTypes,
     nxsdConst,
     nxllBde,
     nxsdDataDictionary,
     nxseAutoComponent,
     nxdbBase,

     DB,
     nxDB,

     DataManager,
     BaseSessionData,
     MainData,
     nxsrSqlEngineBase,
     nxsqlEngine,

     AppManager,
     SectionData,

     StdCtrls;

type
  TTableLocation = ( dlLocal, dlRemote, dlLocalUpdatable );
  TModuleFunction = function( const Args : array of Variant ) : Variant of object;

  TEnterpriseDataModule = class(TSectionDataModule)
    AuxDatabase: TnxeDatabase;
    Database: TnxeDatabase;
    procedure SectionDataModuleDestroy(Sender: TObject);
    procedure SectionDataModuleCreate(Sender: TObject);

  private

    // Esta variable global indica que se ha realizado al menos una reestructuracion

    FOnUserDatabaseUpdated : TSimpleEvent;
    FTableLocationList : TStringList;

    // Los siguientes parámetros se refieren a UserDatabase

    FMajorVersion,
    FMinorVersion,
    FRelease,
    FBuild : Word;

    FLastUpdate : TDateTime;
    FOptions : String;

    FBackupDir : String;

    FUserDataPath,
    FUserRemoteDataPath,
    FUserAuxDataPath : String;

    function GetMajorVersion : Word;
    function GetMinorVersion : Word;
    function GetRelease : Word;
    function GetBuild : Word;
    function GetComparableVersion : String;  // En formato VVRRBB  ( Version-Release-Build : 10030006 )

    function GetLastUpdate : TDateTime;
    function GetCodigoEmpresa : String;
    function GetCodigoEmpresaAuxiliar : String;
    function GetUserDataPath: String;
    function GetUserRemoteDataPath: String;
    function GetUserAuxDataPath: String;

    function GetMainDataModule : TMainDataModule;

    function GetOnUserDatabaseUpdated : TSimpleEvent;
    procedure SetOnUserDatabaseUpdated( Const Value : TSimpleEvent );

  protected

    FCodigoEmpresa,
    FCodigoEmpresaAuxiliar : String;

  public

    constructor Create( SessionData : TBaseSessionDataModule; CodigoEmpresa, DataPath : String );

    procedure OpenAuxDatabase( CodigoEmpresaAuxiliar : String; DataPath : String = '' );
    procedure CloseSessionDatabases( ASession : TnxSession );
    procedure CloseUserDatabases;

    procedure DoUserDatabaseUpdated;

    procedure FreeAllDataModules;

    procedure ClearTableLocations;
    procedure AddTableLocation( TableName : String; Location : TTableLocation );
    Function  GetTableLocation( TableName : String ) : TTableLocation;

    procedure BackupUserTables( FileNames : array of string; DirExtension : String = ''; DeleteTables  : Boolean = False; OnFileProcessed : TShowProgressEvent = nil );
    procedure RestoreUserTables( FileNames : array of string; DirExtension : String = ''; DeleteTables : Boolean = False; OnFileProcessed : TShowProgressEvent = nil );
    procedure PackTables( TableNames : array of String );

    procedure CheckUserAuxDatabase( Dataset : TDataset );
    procedure CheckVersionAndExecute( AMajorVersion, AMinorVersion, ARelease : SmallInt; ExecProc : TSimpleEvent );

    property MajorVersion : Word read GetMajorVersion;
    property MinorVersion : Word read GetMinorVersion;
    property Release : Word read GetRelease;
    property Build : Word read GetBuild;
    property ComparableVersion : String read GetComparableVersion;

    property LastUpdate : TDateTime read GetLastUpdate;

    property CodigoEmpresa : String read GetCodigoEmpresa;
    property CodigoEmpresaAuxiliar : String read GetCodigoEmpresaAuxiliar;

    property MainDataModule : TMainDataModule read GetMainDataModule;

    property UserDataPath : String read GetUserDataPath;
    property UserRemoteDataPath : String read GetUserRemoteDataPath;
    property UserAuxDataPath : String read GetUserAuxDataPath;

    property OnUserDatabaseUpdated : TSimpleEvent read GetOnUserDatabaseUpdated write SetOnUserDatabaseUpdated;
  end;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   Controls,
       ExtCtrls,
       Forms,
       Variants,
       IniFiles,
       DBConsts,
       TypInfo,
       Files,
       LibUtils,
       DateUtils,
       nxdmServer,

       ServerDataModule,

       nxdbStrings,
       nxllBdeStrings;

resourceString

      RsMsg12  = 'El directorio %s, asignado a la Empresa %s no existe o no es accesible.';
      RsMsg16  = 'No se ha podido inicializar la base de datos de la aplicación.';

      RsMsg69  = 'Gestor de transacciones : ... aplicando cambios.';
      RsMsg70  = 'Gestor de transacciones : ... cancelando cambios.';
      RsMsg71  = 'Gestor de transacciones : Iniciando ...';

      RsMsg74  = 'La versión de la base de datos es superior a la de la aplicación instalada.';

      RsMsg90  = 'Se ha excedido el número máximo de conexiones permitidas.';
      RsMsg91  = 'Si desea utilizar más conexiones simultáneas a la base de datos póngase en contacto con su distribuidor o agente para aumentar el número de conexiones concurrentes.';

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

// TEnterpriseDataModule

procedure TEnterpriseDataModule.SetOnUserDatabaseUpdated( const Value: TSimpleEvent);
begin
     FOnUserDatabaseUpdated := Value;
end;

procedure TEnterpriseDataModule.OpenAuxDatabase( CodigoEmpresaAuxiliar : String;
                                                 DataPath              : String = '' );
begin
     With AuxDatabase do
       begin
       Close;
       FCodigoEmpresaAuxiliar := CodigoEmpresaAuxiliar;
       AliasPath := SessionDataModule.EnterpriseDataPath( DataPath, FCodigoEmpresaAuxiliar );
       Session := SessionDataModule.DBSession;
       FUserAuxDataPath := AliasPath;
       Open;
       end;
end;

procedure TEnterpriseDataModule.SectionDataModuleCreate(Sender: TObject);
begin
     FTableLocationList := TStringList.Create;
end;

procedure TEnterpriseDataModule.SectionDataModuleDestroy(Sender: TObject);
begin
     try
       LogMessage( 'Limpiando datos sesión (EnterpriseData) : ' +
                   SessionDataModule.ComputerName +
                   '. Iniciada el ' + FormatDateTime( 'dd/mm/yyyy hh:mm:ss', SessioNDataModule.StartedAt ) );
       FTableLocationList.Free;
     except
       end;
end;

procedure TEnterpriseDataModule.CloseSessionDatabases( ASession : TnxSession );

var  Index : SmallInt;

begin
     With ASession do
       For Index := 0 to DatabaseCount - 1 do
         Databases[ Index ].Close;
end;

procedure TEnterpriseDataModule.CloseUserDatabases;
begin
     SectionDatabase.Close;
     AuxDatabase.Close;
end;

procedure TEnterpriseDataModule.ClearTableLocations;
begin
     FTableLocationList.Clear;
end;

procedure TEnterpriseDataModule.DoUserDatabaseUpdated;
begin
     If   not SessionDataModule.InitializingDatabase and Assigned( FOnUserDatabaseUpdated )
     then FOnUserDatabaseUpdated;
     SessionDataModule.UpdateDatabaseInfo( SectionDatabase, VersionInfo.MajorVersion, VersionInfo.MinorVersion, VersionInfo.Release, VersionInfo.Build );
end;

procedure TEnterpriseDataModule.AddTableLocation( TableName : String;
                                                  Location  : TTableLocation );
begin
     FTableLocationList.AddObject( TableName, TObject(Location ) );
end;

function TEnterpriseDataModule.GetTableLocation( TableName : String ) : TTableLocation;

var  Index : Integer;

begin
     With FTableLocationList do
       If   Find( TableName, Index )
       then Result := TTableLocation( Objects[ Index ] )
       else Result := dlLocal;
end;

// Los DataModules de la Empresa pertenecen a EnterpriseData

procedure TEnterpriseDataModule.FreeAllDataModules;

var  I : SmallInt;
     DataModule : TServerDataModule;

begin
     If   not ( csDestroying in ComponentState )
     then For I := ComponentCount - 1 downto 0 do
            If   Components[ I ] is TServerDataModule
            then begin
                 DataModule := TServerDataModule( Components[ I ] );
                 If   DataModule.Tag<>0
                 then DataModule.Free;
                 end;
end;

function TEnterpriseDataModule.GetUserDataPath: String;
begin
     Result := FUserDataPath;
end;

function TEnterpriseDataModule.GetUserRemoteDataPath: String;
begin
     Result := FUserRemoteDataPath;
end;

function TEnterpriseDataModule.GetUserAuxDataPath: String;
begin
     Result := FUserAuxDataPath;
end;

constructor TEnterpriseDataModule.Create( SessionData    : TBaseSessionDataModule;
                                          CodigoEmpresa,
                                          DataPath       : String );
begin
     inherited Create( SessionData );

     FSectionDatabase := Database;
     FCodigoEmpresa := CodigoEmpresa;
     FUserDataPath := SessionDataModule.EnterpriseDataPath( DataPath, FCodigoEmpresa );

     try

       With Database do
         begin
         Session := SessionDataModule.DBSession;
         AliasPath := FUserDataPath;
         Open;
         end;

       If   SessionDataModule.ClientType<>ctLicensing
       then begin

            SessionDataModule.GetDatabaseInfo( Database, FMajorVersion, FMinorVersion, FRelease, FBuild, FLastUpdate, FOptions );

            // Cuando se crea una nueva Empresa se utiliza la función InitializingDatabase que fija la variable FInitializingDatabase

            If   not SessionDataModule.UpdatingDatabase and
                 not SessionDataModule.InitializingDatabase
            then SessionDataModule.CheckDatabaseVersion( Database, ComparableVersion, CodigoEmpresa );

            end;

     except on E : Exception do
       begin
       If   not ( IsDesignTime or SessionDataModule.UpdatingDatabase )     // Quiero la posibilidad de acceder a la base de datos en algunas aplicaciones en modo diseño, pero no que se muestre un error si no está disponible
       then SessionDataModule.SendNotification( ntError, RsMsg16, Format( RsMsg12, [ FUserDataPath, FCodigoEmpresa ] ) );
       raise;
       end;
     end;

end;

function TEnterpriseDataModule.GetBuild: Word;
begin
     Result := FBuild;
end;

function TEnterpriseDataModule.GetCodigoEmpresa: String;
begin
     Result := FCodigoEmpresa;
end;

function TEnterpriseDataModule.GetCodigoEmpresaAuxiliar: String;
begin
     Result := FCodigoEmpresaAuxiliar;
end;

function TEnterpriseDataModule.GetComparableVersion : String;
begin
     Result := AppManager.GetComparableVersion( FMajorVersion, FMinorVersion, FRelease );
end;

procedure TEnterpriseDataModule.CheckVersionAndExecute( AMajorVersion, AMinorVersion, ARelease : SmallInt; ExecProc : TSimpleEvent );
begin
     If   GetComparableVersion<AppManager.GetComparableVersion( AMajorVersion, AMinorVersion, ARelease )
     then ExecProc;
end;

function TEnterpriseDataModule.GetLastUpdate: TDateTime;
begin
     Result := FLastUpdate;
end;

procedure TEnterpriseDataModule.CheckUserAuxDatabase( Dataset : TDataset );

var  WasActive : Boolean;

begin
     If   Dataset is TnxeTable
     then With TnxeTable( Dataset ) do
            begin
            WasActive := Active;
            Close;
            If   AuxDatabase.Active
            then Database := AuxDatabase
            else Database := SectionDatabase;
            Active := WasActive;
            end;
end;

procedure TEnterpriseDataModule.BackupUserTables( FileNames       : array of string;
                                                  DirExtension    : String = '';
                                                  DeleteTables    : Boolean = False;
                                                  OnFileProcessed : TShowProgressEvent = nil );

var  Index : SmallInt;
     BaseBackupDir,
     SourceFileName,
     TargetFileName : String;

begin

     BaseBackupDir := FUserDataPath + '\archivo' + DirExtension;
     FBackupDir := BaseBackupDir;
     Index := 1;
     While DirectoryExists( FBackupDir ) do
       begin
       FBackupDir := BaseBackupDir + '_' + IntToStr( Index );
       Inc( Index );
       end;

     CreateDirPath( FBackupDir );
     For Index := 0 to High( FileNames ) do
       try
         SourceFileName := FUserDataPath + '\' + FileNames[ Index ] + '.nx1';
         TargetFileName := FBackupDir + '\' + FileNames[ Index ] + '.nx1';
         If   CopyFile( SourceFileName, TargetFileName )
         then If   DeleteTables
              then SectionDatabase.DeleteTable( FileNames[ Index ], '' );
         If   Assigned( OnFileProcessed )
         then OnFileProcessed( FileNames[ Index ], ( Index * 100 ) div High( FileNames ) );
       except
         end;
end;

procedure TEnterpriseDataModule.RestoreUserTables( FileNames       : array of string;
                                                   DirExtension    : String = '';
                                                   DeleteTables    : Boolean = False;
                                                   OnFileProcessed : TShowProgressEvent = nil );

var  Index : SmallInt;
     SourceFileName,
     TargetFileName : String;

begin

     // Si no se especifica DirExtension se asume que se quiere restaurar desde el último FBackupDir

     If   DirExtension<>''
     then FBackupDir := FUserDataPath + '\archivo' + DirExtension;

     CreateDirPath( FBackupDir );
     For Index := 0 to High( FileNames ) do
       try
         SourceFileName := FBackupDir + '\' + FileNames[ Index ] + '.nx1';
         TargetFileName := FUserDataPath + '\' + FileNames[ Index ] + '.nx1';
         If   CopyFile( SourceFileName, TargetFileName )
         then If   DeleteTables
              then EraseFile( SourceFileName );
         If   Assigned( OnFileProcessed )
         then OnFileProcessed( FileNames[ Index ], ( Index * 100 ) div High( FileNames ) );
       except
         end;
end;

procedure TEnterpriseDataModule.PackTables( TableNames : array of String );

var  Index : SmallInt;
     TableName : String;

begin
     For Index := 0 to High( TableNames ) do
       begin
       TableName := ExtractFileNameWithoutExtension( TableNames[ Index ] );
       SessionDataModule.PackTable( SectionDatabase, TableName );
       end;
end;

//..

function TEnterpriseDataModule.GetMainDataModule: TMainDataModule;
begin
     Result := TMainDataModule( SessionDataModule.MainDataModule );
end;

function TEnterpriseDataModule.GetMajorVersion: Word;
begin
     Result := FMajorVersion;
end;

function TEnterpriseDataModule.GetMinorVersion: Word;
begin
     Result := FMinorVersion;
end;

function TEnterpriseDataModule.GetOnUserDatabaseUpdated: TSimpleEvent;
begin
     Result := FOnUserDatabaseUpdated;
end;

function TEnterpriseDataModule.GetRelease: Word;
begin
     Result := FRelease;
end;

end.
