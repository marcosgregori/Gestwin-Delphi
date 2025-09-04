
unit EnterpriseDataAccess;

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
     nxllComponent,
     nxsrServerEngine,
     nxllPlatformInterface,
     nxpvPlatformImplementation,
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
     cxLabel,
     cxProgressBar,

     AppContainer,

     AppManager,
     DataManager,
     nxsrSqlEngineBase,
     nxsqlEngine;

type
  TTableLocation = ( dlLocal, dlRemote, dlLocalUpdatable );

  TTransactionId = record
    Id : LongInt;
    Notify : Boolean;
    end;

  TTransactionStack = class( TStack< TTransactionId > )
    private
    FCurrentId : LongInt;
    public
    function Push( const Notify : Boolean ) : LongInt; inline;
    end;

  TEnterpriseDataModule = class(TDataModule)
    UserDatabase: TnxeDatabase;
    UserAuxDatabase: TnxeDatabase;
    procedure EnterpriseDataModuleDestroy(Sender: TObject);
    procedure EnterpriseDataModuleCreate(Sender: TObject);
    procedure UserDatabaseStateChanged(Sender: TObject);

  private

    FTransactionStack : TTransactionStack;

    FInitializingDatabase : Boolean;

    FOpStatus : TnxResult;

    // Esta variable global indica que se ha realizado al menos una reestructuracion

    FOnUserDatabaseUpdated : TSimpleEvent;
    FTableLocationList : TStringList;

    // Los siguientes parámetros se refieren a UserDatabase

    {
    FMajorVersion,
    FMinorVersion,
    FRelease,
    FBuild : Word;
    }

    FLastUpdate : TDateTime;
    FOptions : String;

    FBackupDir : String;

    TaskInfo : TnxAbstractTaskInfo;
    TaskStatus : TnxTaskStatus;

    // procedure UpdateAlias( Session : TnxBaseSession; AliasName, AliasPath : String );

    FCodigoEmpresa,
    FCodigoEmpresaAuxiliar : String;

    // function GetComparableVersion : Integer;  // En formato VVRRBB  ( Version-Release-Build : 100306 )

  public

    UserDataPath,
    UserRemoteDataPath,
    UserAuxDataPath : String;

    function  GetUserDataPath( DataPath : String; UnCodigoEmpresa : String = '' ) : String;
    function  SetUserDataPath( UnCodigoEmpresa : String; DataPath : String = ''; ProcessError : Boolean = True ) : Boolean;
    procedure SetUserAuxDataPath( UnCodigoEmpresa : String; DataPath : String = '' );

    procedure CloseSessionDatabases( ASession : TnxSession );
    procedure CloseUserDatabases;

    procedure ClearTableLocations;
    procedure AddTableLocation( TableName : String; Location : TTableLocation );
    Function  GetTableLocation( TableName : String ) : TTableLocation;

    function StartTransaction( Notify  : Boolean = True ) : LongInt; overload;
    function StartTransaction( const ATables : array of TnxTable; Notify  : Boolean = True ) : LongInt; overload;

    procedure Commit( Id : LongInt = 0 );
    procedure RollBack( Id : LongInt = 0 );

    function  ExecQuery( const SQLString : String; RaiseError : Boolean = True; Notify : Boolean = True ) : TnxDynVariantArray;
    function  OpenQuery( const SQLString : String; RaiseError : Boolean = True; Notify : Boolean = True ) : TnxQuery;

    procedure CheckUserAuxDatabase( Dataset : TDataset );

    function AddDataDirectory( DataPath : String; UnCodigoEmpresa : String = '' ) : String;
    function RemoveDataDirectory( DataPath : String ) : String;

    property InitializingDatabase : Boolean read FInitializingDatabase write FInitializingDatabase;

    {
    property MajorVersion : Word read FMajorVersion;
    property MinorVersion : Word read FMinorVersion;
    property Release : Word read FRelease;
    property Build : Word read FBuild;
    property ComparableVersion : Integer read GetComparableVersion;
    }

    property LastUpdate : TDateTime read FLastUpdate;

    // property VersionNumber : Integer read GetVersionNumber;

    property CodigoEmpresa : String read FCodigoEmpresa;
    property CodigoEmpresaAuxiliar : String read FCodigoEmpresaAuxiliar;

    property OnUserDatabaseUpdated : TSimpleEvent read FOnUserDatabaseUpdated write FOnUserDatabaseUpdated;
  end;


function EnterpriseDataModule : TEnterpriseDataModule;
procedure UnloadEnterpriseDataModule;

implementation

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

       NexusRpcData,

       nxdbStrings,
       nxllBdeStrings,

       DataAccess,

       b_msg,
       b_reg,
       b_spr,

       f_prg;

       // La versión de la base de datos actual.

var  FEnterpriseDataModule : TEnterpriseDataModule = nil;


resourceString
      RsMsg1   = 'La secuencia de transacciones no está ordenada';

      RsMsg90  = 'Se ha excedido el número máximo de conexiones permitidas.';
      RsMsg91  = 'Si desea utilizar más conexiones simultáneas a la base de datos póngase en contacto con su distribuidor o agente para aumentar el número de conexiones concurrentes.';

// Funciones

function EnterpriseDataModule : TEnterpriseDataModule;
begin
     If   not Assigned( FEnterpriseDataModule )
     then FEnterpriseDataModule := TEnterpriseDataModule.Create( nil );
     Result := FEnterpriseDataModule;
end;

// Cuidado con descargar el EnterpriseDataModule sin que estén el resto de módulos vinculados a éste descargados

procedure UnloadEnterpriseDataModule;
begin
     If   Assigned( FEnterpriseDataModule )
     then FEnterpriseDataModule.Free;
end;

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

function TEnterpriseDataModule.GetUserDataPath( DataPath        : String;
                                                UnCodigoEmpresa : String = '' ) : String;
begin
     If   DataPath=''
     then DataPath := DataAccessModule.RootDataPath;
     Result := AddDataDirectory( DataPath, UnCodigoEmpresa );
end;

function TEnterpriseDataModule.SetUserDataPath( UnCodigoEmpresa : String;
                                                DataPath        : String = '';
                                                ProcessError    : Boolean = True ) : Boolean;

var Created : Boolean;

begin
     Result := False;
     DataAccessModule.CloseInactiveMainSessionResources;
     FCodigoEmpresa := UnCodigoEmpresa;
     UserDataPath := GetUserDataPath( DataPath, FCodigoEmpresa );
     try

       With UserDatabase do
         begin
         Close;
         AliasPath := UserDataPath;
         Session := DataAccessModule.MainSession;
         Open;
         end;

       Result := True;

     except on E : EAbort    do ;
            on E : Exception do
       If   ProcessError
       then begin
            ShowNotification( ntError, RsMsg16, Format( RsMsg12, [ UserDataPath, FCodigoEmpresa ] ) );
            PrgExit( False, True );
            raise;
            end
       else If   not ( E is EDatabaseError )
            then raise;
       end;
end;

function TEnterpriseDataModule.AddDataDirectory( DataPath        : String;
                                                 UnCodigoEmpresa : String = '' ) : String;

var  Path : String;

begin
     If   UnCodigoEmpresa=''
     then UnCodigoEmpresa := FCodigoEmpresa;
     Path := UpperCase( RemovePathDelim( DataPath ) );
     If   UpperCase( Copy( Path, Length( Path ) - 7, 5 ) )<>'DATA_'  // El Path ya incluye el directorio destino
     then Result := AddPathDelim( DataPath ) + 'data_' + UnCodigoEmpresa
     else Result := DataPath;
end;

function TEnterpriseDataModule.RemoveDataDirectory( DataPath : String ) : String;

var  DataPos : SmallInt;

begin
     DataPos := Pos( 'DATA_', UpperCase( DataPath ) );
     If   DataPos=0
     then Result := DataPath
     else Result := Copy( DataPath, 1, Pred( DataPos ) );
end;

procedure TEnterpriseDataModule.SetUserAuxDataPath( UnCodigoEmpresa : String;
                                                    DataPath        : String = '' );
begin
     With UserAuxDatabase do
       begin
       Close;

       FCodigoEmpresaAuxiliar := UnCodigoEmpresa;

       Session := DataAccessModule.MainSession;

       AliasPath := GetUserDataPath( DataPath, FCodigoEmpresaAuxiliar );
       UserAuxDataPath := AliasPath;

       Open;

       // UpdateAlias( Session, 'dataAux_' + CodigoEmpresa, AliasPath );
       end;
end;

{
procedure TEnterpriseDataModule.UpdateAlias( Session     : TnxBaseSession;
                                       AliasName,
                                       AliasPath   : String );
begin
     With Session do
       If   IsAlias( AliasName )
       then ModifyAlias( AliasName, AliasName, AliasPath )
       else AddAlias( AliasName, AliasPath );
end;
}

procedure TEnterpriseDataModule.EnterpriseDataModuleCreate(Sender: TObject);
begin
     {
     If   DesignEnvironment
     then With UserDatabase do
            begin
            Close;
            AliasPath := 'F:\Desktop\Gestwin\data_001';
            Session := DataAccessModule.MainSession;
            Open;
            end
     else }

     FTableLocationList := TStringList.Create;
     FTransactionStack := TTransactionStack.Create;
end;

procedure TEnterpriseDataModule.EnterpriseDataModuleDestroy(Sender: TObject);
begin

     If   not IsDesignTime
     then begin
          CloseUserDatabases;
          FTableLocationList.Free;
          end;

     FTransactionStack.Free;
     FEnterpriseDataModule := nil;
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
     UserDatabase.Close;
     UserAuxDatabase.Close;
end;

procedure TEnterpriseDataModule.ClearTableLocations;
begin
     FTableLocationList.Clear;
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

function TEnterpriseDataModule.ExecQuery( const SQLString     : String;
                                                RaiseError    : Boolean = True;
                                                Notify        : Boolean = True ) : TnxDynVariantArray;
begin
     Result := DataAccess.ExecQuery( UserDatabase, SQLString, RaiseError, Notify );
end;

function TEnterpriseDataModule.OpenQuery( const SQLString     : String;
                                                RaiseError    : Boolean = True;
                                                Notify        : Boolean = True ) : TnxQuery;
begin
     Result := DataAccess.OpenQuery( UserDatabase, SQLString, RaiseError, Notify );
end;

function TEnterpriseDataModule.StartTransaction( Notify  : Boolean = True ) : LongInt;
begin
     Result := StartTransaction( [], Notify );
end;

function TEnterpriseDataModule.StartTransaction( const ATables : array of TnxTable;
                                                       Notify  : Boolean = True ) : LongInt;

procedure StartTransation( Database : TnxDatabase );
begin
     If   Database.Active
     then If   High( ATables )=-1
          then Database.StartTransaction
          else Database.StartTransactionWith( ATables );
end;

begin

     If   Notify
     then ProcessFrame.AddMsg( ntInformation, RsMsg71 );

     Result := FTransactionStack.Push( Notify );
   
     StartTransation( UserDatabase );
     StartTransation( UserAuxDatabase );
end;

procedure TEnterpriseDataModule.UserDatabaseStateChanged(Sender: TObject);

var  ConexionesActivas : Integer;
     DatabaseState : TnxState;

begin

     //* 04.07.2009  He quitado una referencia a DataAccessModule porque provocaba que se cargara el módulo durante la desactivación.
     //              En su lugar utilizo el parámetro Sender.

     If   Assigned( Sender ) and ( Sender is TnxDatabase )
     then begin
          DatabaseState := TnxDatabase( Sender ).State;
          case DatabaseState of
            nxsStarted : If   not UnProtectedApp and not SpEvaluation
                         then begin

                              // Solo si el usuario está usando una conexión remota

                              With DataAccessModule do
                                If   MainSession.ServerEngine is TnxRemoteServerEngine
                                then If   NexusRpc.SessionCount>SpServerConnections
                                     then begin
                                          ShowNotification( ntStop, RsMsg90, RsMsg91 );
                                          PrgExit( False, True );
                                          Abort;
                                          end;
                              end;
            end;
          end;
end;

procedure TEnterpriseDataModule.Commit( Id : LongInt = 0 );

procedure Commit( Database : TnxDatabase );
begin
     With Database do
       If   Active
       then try
              Commit;
            except on E : EnxDatabaseError do If   E.ErrorCode<>DBIERR_NOACTIVETRAN
                                              then raise;
             else raise;
             end;
end;

begin
     var TransactionId := FTransactionStack.Pop;
     If   ( Id<>0 ) and ( Id<>TransactionId.Id )
     then raise EnxDatabaseError.Create( RsMsg1 );
     Commit( UserAuxDatabase );
     Commit( UserDatabase );
     If   TransactionId.Notify
     then ProcessFrame.AddMsg( ntInformation, RsMsg69 );
end;


procedure TEnterpriseDataModule.RollBack( Id : LongInt = 0 );

procedure RollBack( Database : TnxDatabase );
begin
     With Database do
       If   Active
       then try
              RollBack;
            except on E : EnxDatabaseError do
                     If   E.ErrorCode<>DBIERR_NOACTIVETRAN
                     then raise;
                   else raise;
              end;
end;

begin
     var TransactionId := FTransactionStack.Pop;
     If   ( Id<>0 ) and ( Id<>TransactionId.Id )
     then raise EnxDatabaseError.Create( RsMsg1 );

     RollBack( UserAuxDatabase );
     RollBack( UserDatabase );

     If   TransactionId.Notify
     then ProcessFrame.AddMsg( ntError, RsMsg70 );
end;

procedure TEnterpriseDataModule.CheckUserAuxDatabase( Dataset : TDataset );
begin
     With TnxeTable( Dataset ) do
       If   UserAuxDatabase.Active
       then Database := UserAuxDatabase
       else Database := UserDatabase;
end;

{ TTransactionStack }

function TTransactionStack.Push( const Notify : Boolean ) : LongInt;

var  TransactionId : TTransactionId;

begin
     Inc( FCurrentId );
     TransactionId.Id := FCurrentId;
     TransactionId.Notify := Notify;
     inherited Push( TransactionId );
     Result := FCurrentId;
end;

initialization

   If   IsDesignTime
   then EnterpriseDataModule;

finalization
   FreeAndNil( FEnterpriseDataModule );

end.
