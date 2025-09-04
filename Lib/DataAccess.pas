
unit DataAccess;

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
     nxPatchPPL,

     nxreRemoteServerEngine,

     nxtwWinsockTransport,

     nxDBBase,
     nxllException,
     nxllTypes,
     nxllUtils,
     nxllBde,
     nxllTransport,
     nxllZipCompressor,
     nxllRleCompressor,
     nxllComponent,
     nxllPlatformInterface,

     nxsrServerEngine,

     nxpvPlatformImplementation,
     nxptBasePooledTransport,
     nxseAutoComponent,

     DB,
     nxDB,

     AppContainer,
     nxsrSqlEngineBase,
     nxsqlEngine,
     Sqlset,
     nxllPluginBase,
     nxsiServerInfoPluginBase,
     nxsiServerInfoPluginClient,
     nxchCommandHandler,
     nxllSessionNotifications,
     nxllSimpleSession,
     nxrpBase,
     nxrpClient,
     nxtnNamedPipeTransport,

     AppManager,
     DataManager;

type

  TProcessResult = 0..idNo;
  TReestructureEventType = ( reCheck, reBefore, reAfter );
  TDictionaryNotification = ( dnVerify, dnBeforeUpdate, dnAfterUpdate );

  TProcessRec = record
    Database,
    BackupDatabase : TnxDatabase;
    Dictionary : TnxeDatabaseDictionary;
    TableName : String;
    DiscardOldTable : Boolean;
    ProcessPercent : Integer;
    end;

  TReestructureData = record
    Dictionary,
    Database : TnxDatabase;
    TableName : String;
    TableMapper : TnxTableMapperDescriptor;
    OldDictionary,
    NewDictionary : TnxDataDictionary;
    DoProcess : Boolean;
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

  TDataAccessModule = class(TDataModule)
    MainSession: TnxSession;
    WinsockTransport: TnxWinsockTransport;
    RemoteServerEngine: TnxRemoteServerEngine;
    AppDatabase: TnxeDatabase;
    DatabaseInfoTable: TnxeTable;
    LocalSession: TnxSession;
    LocalServerEngine: TnxServerEngine;
    LocalSqlEngine: TnxSqlEngine;
    RemoteServerInfoPlugin: TnxRemoteServerInfoPlugin;
    NamedPipeTransport: TnxNamedPipeTransport;
    SessionPool: TnxSessionPool;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure LocalSessionStateChanged(Sender: TObject);

  private

    FPackingTable : Boolean;

    FOpStatus : TnxResult;

    FDirectTemporalPath : String;
    FRestrictedTableNames : TStringList;     // Lista de tablas limitadas (versión de evaluación)

    FBackupDir : String;

    FOnUpdateTableProgress : TTableProgressEvent;
    ProcessData : TProcessRec;
    TaskInfo : TnxAbstractTaskInfo;
    TaskStatus : TnxTaskStatus;

    Function  PackProcess : Boolean;
    procedure WaitForTaskEnding;
    procedure TaskEnded;

  public

    Function  RootDataPath : String;

    procedure UpdateRemoteDataCompression;

    procedure CloseInactiveMainSessionResources;
    procedure CloseInactiveLocalSessionResources;
    procedure CloseSessionDatabases( ASession : TnxSession );

    procedure AddRestrictedTables( TableNames : array of string );
    function  IsARestrictedTable( TableName : string ) : Boolean;

    function  ExecQuery( const SQLString : String; RaiseError : Boolean = True ) : TnxDynVariantArray;

    Function  PackTable( Database : TnxDatabase; TableName : String ) : TProcessResult;
    procedure PackTables( Database : TnxDatabase; TableNames : array of String );

    property DirectTemporalPath : String  read FDirectTemporalPath;

  end;

function DataAccessModule : TDataAccessModule;

procedure SetFieldsMapOptions( RecordMapperDescriptor : TnxRecordMapperDescriptor; FieldNames : array of String; ASourceName : String = #0; ADataLossAction : TnxDataLossAction = dlaBestFit );
function  GetFieldTypeHasChanged( OldDictionary, NewDictionary : TnxDataDictionary; FieldName : String ) : Boolean;
procedure NotifyDictionary( ADatabase : TnxDatabase; Notification : TDictionaryNotification );

procedure SetupDatabaseDictionary( ADatabaseDictionary : TnxeDatabaseDictionary );
function  GetDatabaseDictionary( AName : TComponentName ) : TnxeDatabaseDictionary;
function  GetTableDictionary( ATableName : TComponentName ) : TnxeDatabaseDictionary;
procedure GetTableNames( AList : TStrings; AddDictionaryName : Boolean = False );
function  GetTableDatabase( ATableName : String; ASession : TnxSession = nil ): TnxDatabase;
function  ExecQuery( ADatabase : TnxDatabase; const SQLString : String; RaiseError : Boolean = True; Notify : Boolean = True ) : TnxDynVariantArray;
function  OpenQuery( ADatabase : TnxDatabase; const SQLString  : String; RaiseError : Boolean = True; Notify : Boolean = True ) : TnxQuery;

procedure AddReestructureNotification( TableName : String; Event : TReestructureTableEvent );
procedure NotifyReestructureEvent( EventType : TReestructureEventType; var ReestructureData : TReestructureData );

procedure AddRecoverNotification( TableName : String; Event : TRecoverTableEvent );
procedure NotifyRecoverEvent( TableName : String  );

resourceString

      RsMsg1   = 'No he podido cargar el servidor de datos (aplicación GServer.exe).';
      RsMsg2   = 'Se ha producido un error durante la inicialización del gestor de base de datos.';
      RsMsg3   = 'No se ha podido iniciar el servidor de datos (GServer).';
      RsMsg4   = 'No se ha encontrado el SERVICIO (GServer) necesario para iniciar una sesión a través de Terminal Server.';
      RsMsg5   = 'Revise la configuración de arranque de GESTWIN y/o el estado del servidor de base de datos.';
      RsMsg6   = 'Se ha producido un error al intentar abrir el diccionario [Color=Maroon]%s[/Color].';
      RsMsg7   = 'La clave activa del cursor [B]%s[/B] tiene un número diferente de segmentos';
      RsMsg8   = 'No he conseguido eliminar la tabla temporal [B]%s[/B].';
      RsMsg9   = 'La estructura del cursor origen no permite fijar la posición en el destino.';
      RsMsg10  = 'No se ha podido crear o acceder al directorio de datos de la aplicación.';
      RsMsg11  = 'Directorio : [B]%s[/B].';
      RsMsg12  = 'El directorio [B]%s[/B] asignado a la Empresa [B]%s[/B] no existe o no es accesible.';
      RsMsg13  = 'Verificando el estado de las tablas.';
      RsMsg14  = 'Tabla : %s.';

      RsMsg16  = 'No se ha podido inicializar la base de datos de la aplicación.';
      RsMsg61  = 'Compactando y reindexando.';
      RsMsg62  = 'Verificando datos asociados (Blobs).';
      RsMsg63  = 'Error del gestor de base de datos. ';
      RsMsg64  = 'Mensaje de error : ';
      RsMsg65  = 'Compactando y ajustando tablas.';
      RsMsg66  = 'Regenerando la tabla.'#13'En proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';
      RsMsg67  = 'En el proceso de regeneración de la tabla [B]%s[/B] [Color=Red]SE HA PERDIDO INFORMACION[/Color].';
      RsMsg68  = 'Es conveniente que recurra a su SOPORTE TECNICO para intentar recuperar la información perdida.';
      RsMsg69  = 'Gestor de transacciones : ... aplicando cambios.';
      RsMsg70  = 'Gestor de transacciones : ... cancelando cambios.';
      RsMsg71  = 'Gestor de transacciones : Iniciando ...';
      RsMsg72  = 'Se ha producido un error durante el empaquetado NLS de la tabla.';
      RsMsg73  = 'Copiando la tabla.'#13'El proceso puede durar bastante si la tabla contiene mucha información. Tenga paciencia ...';
      RsMsg74  = 'La versión de la base de datos es superior a la de la aplicación instalada.';
      RsMsg75  = 'Debe instalar la última versión disponible o, preferiblemente, solicitar asistencia técnica.'#13'Utilizar versiones incorrectas de la aplicación y de la base de datos puede originar una PÉRDIDA IRREVERSIBLE DE INFORMACIÓN.';
      // RsMsg76  = 'No se ha podido abrir la tabla con información sobre la base de datos activa.';
      // RsMsg77  = 'Revise el estado de la tabla y sus derechos de acceso al directorio de la base de datos o a la tabla.';
      RsMsg78  = 'Éste es un error de configuración grave.';

      RsMsg79  = 'Se ha producido un error ejecutando una sentencia SQL.';
      RsMsg80  = 'Se procede a abandonar la aplicación.'#13'[Color=Maroon]Notifique a su proveedor este extremo.[/Color]';

      RsRegistroInexistente  = '< Registro inexistente >';

implementation

{$R *.dfm}

uses   WinAPI.Messages,
       Controls,
       ExtCtrls,
       Forms,
       Variants,
       IniFiles,
       DBConsts,
       TypInfo,
       LibUtils,
       Files,
       
       nxdbStrings,
       nxllBdeStrings,
       nxsdDefaultValueEngine,
       nxsdValidationEngine,

       AppForms,
       NexusRpcData,

       b_reg,
       b_msg,
       b_spr,

       f_prg;

       // La versión de la base de datos actual

const  DatabaseInfoFileName      = '_DBI';

       MajorVersionFieldName    = 'MajorVersion';
       MinorVersionFieldName    = 'MinorVersion';
       ReleaseFieldName         = 'Release';
       BuildFieldName           = 'Build';
       UpdatedFieldName         = 'Updated';
       OptionsFieldName         = 'Options';

       TmpDirBaseName           = 'gw$tmp_';

       // Errores de Nexus no incluidos en nxsrBase

       DBIERR_RESOURCELOCKED    = $3C01;
       DBIERR_TIMEOUT           = $3C65;

var  FDataAccessModule : TDataAccessModule = nil;

     FReestructureNotifyList : TReestructureNotifyList = nil;
     FRecoverNotifyList : TRecoverNotifyList = nil;

// Registros

procedure TReestructureData.Setup( ADictionary, ADatabase : TnxDatabase; ATableName : String );
begin
     Dictionary := ADictionary;
     Database := ADatabase;
     TableName := AtableName;
     TableMapper := nil;
     OldDictionary := nil;
     NewDictionary := nil;
     DoProcess := True;
end;

// Funciones

function DataAccessModule : TDataAccessModule;
begin
     If   not Assigned( FDataAccessModule )
     then FDataAccessModule := TDataAccessModule.Create( nil );
     Result := FDataAccessModule;
end;

function  BoolToModalResult( Value : Boolean ) : TProcessResult;
begin
     If   Value
     then Result := mrOk
     else Result := mrCancel;
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

procedure NotifyDictionary( ADatabase    : TnxDatabase;
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

function GetDatabaseDictionary( AName : TComponentName ) : TnxeDatabaseDictionary;

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

function GetTableDictionary( ATableName : TComponentName ) : TnxeDatabaseDictionary;

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

function GetTableDatabase( ATableName : String;
                           ASession   : TnxSession = nil ) : TnxDatabase;

var  Index : SmallInt;

begin
     Result := nil;
     If   not Assigned( ASession )
     then ASession := DataAccessModule.MainSession;
     With ASession do
       For Index := 0 to DatabaseCount - 1 do
         If   not ( Databases[ Index ] is TnxeDatabaseDictionary )
         then If   ( Databases[ Index ].Active ) and ( Databases[ Index ].TableExists( ATableName, '' ) )
              then begin
                   Result := Databases[ Index ];
                   Exit;
                   end;
end;

procedure GetTableNames( AList           : TStrings;
                         AddDictionaryName : Boolean = False );

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
                With Dictionary do
                  begin
                  DictionaryActive := Active;
                  If   not DictionaryActive
                  then Open;

                  GetTableNames( DictTableList );

                  If   AddDictionaryName
                  then begin
                       var DictionaryName := ExtractFileName( Dictionary.AliasPath );
                       For var Inx := 0 to DictTableList.Count - 1 do
                         AList.AddPair( DictionaryName, DictTableList.Strings[ Inx ] );
                       end
                  else AList.AddStrings( DictTableList );

                  If   not DictionaryActive
                  then Close;
                  end;
                end;
         finally
           DictTableList.Free;
           AList.EndUpdate;
           end;

end;

procedure SetupDatabaseDictionary( ADatabaseDictionary : TnxeDatabaseDictionary );
begin
     With ADatabaseDictionary do
       try
         Active := False;
         AliasPath := DataAccessModule.RootDataPath + ExtractFileName( AliasPath );
         Session := DataAccessModule.AppDatabase.Session;
         If   StateTransition=nxstNone
         then Active := True;
       except
         ShowNotification( ntStop, Format( RsMsg6, [ AliasPath ] ), RsMsg78 + RsMsg80 );

         // Un diccionario que no existe es un error de configuración grave. Salgamos de aquí lo antes posible.

         PrgExit( False, True );
         Abort;
         end;
end;

function ExecQuery(        ADatabase  : TnxDatabase;
                     const SQLString  : String;
                           RaiseError : Boolean = True;
                           Notify     : Boolean = True ) : TnxDynVariantArray;
begin
     try
       With TnxeQuery.Create( nil ) do
         try
           Database := ADatabase;
           TimeOut := GetSQLTimeout;
           Sql.Text := SQLString;
           ExecSql;
           Result := ValuesFromParams( Params );
         finally
           Free;
           end;

     except on E : EnxDatabaseError do
       If   RaiseError
       then raise
       else If   Notify
            then begin
                 ShowNotification( ntError, RsMsg79, E.Message );
                 Result := VarArrayOf( [ E.ErrorCode, E.ErrorString ] );
                 end;
       else raise;
     end;
end;

function OpenQuery(       ADatabase  : TnxDatabase;
                    const SQLString  : String;
                          RaiseError : Boolean = True;
                          Notify     : Boolean = True ) : TnxQuery;
begin
     try
       Result := TnxQuery.Create( nil );
       With Result do
         try
           Database := ADatabase;
           TimeOut := GetSQLTimeOut;
           Sql.Text := SQLString;
           RequestLive := False;
           Open;
         except
           Free;
           raise;
           end;

     except on E : EnxDatabaseError do
       If   RaiseError
       then raise
       else If   Notify
            then begin
                 ShowNotification( ntError, RsMsg79, E.Message );
                 Result := nil;
                 end;
       else raise;
       end;

end;

procedure AddReestructureNotification( TableName : String;
                                       Event     : TReestructureTableEvent );
begin
     FReestructureNotifyList.Add( TReestructureNotifyItem.Create( TableName, Event ) );
end;

procedure NotifyReestructureEvent(     EventType        : TReestructureEventType;
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

procedure AddRecoverNotification( TableName : String;
                                  Event     : TRecoverTableEvent );
begin
     FRecoverNotifyList.Add( TRecoverNotifyItem.Create( TableName, Event ) );
end;

procedure NotifyRecoverEvent( TableName : String  );

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

// TReestructureNotifyItem

constructor TReestructureNotifyItem.Create( AName  : String;
                                            AEvent : TReestructureTableEvent );
begin
     inherited Create;
     Name := AName;
     Event := AEvent;
end;

// TReestructureNotifyList

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

// TRecoverNotifyItem

constructor TRecoverNotifyItem.Create( AName  : String;
                                       AEvent : TRecoverTableEvent );
begin
     inherited Create;
     Name := AName;
     Event := AEvent;
end;

// TRecoverNotifyList

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

// TDataAccessModule

procedure TDataAccessModule.UpdateRemoteDataCompression;
begin
     WinsockTransport.CompressType := GetRemoteCompressionType;
end;

procedure TDataAccessModule.LocalSessionStateChanged(Sender: TObject);
begin
     If   LocalSession.State=nxsInactive
     then If   ( FDirectTemporalPath<>'' ) and ( Pos( TmpDirBaseName, FDirectTemporalPath )<>0 )  // Me aseguro mucho de que sea un directorio temporal
          then EraseDirectory( FDirectTemporalPath );
end;

function TDataAccessModule.RootDataPath : String;
begin
     Result := NexusRpc.GetRootDataPath;
end;

procedure TDataAccessModule.DataModuleCreate(Sender: TObject);

const DataAlias = 'data';

var   TmpDataPath : String;
      Created : Boolean;

begin

     FDataAccessModule := Self;

     If   not IsDesignTime
     then begin

          ShowErrorDialog := True;

          {$IFDEF DEBUG}

          With WinsockTransport do
            begin
            HeartbeatInterval := 600000;
            LostConnectionTimeout := 600000;
            WatchdogInterval := 600000;
            TimeOut := 600000;
            end;

          With NamedPipeTransport do
            begin
            HeartbeatInterval := 600000;
            LostConnectionTimeout := 600000;
            WatchdogInterval := 600000;
            TimeOut := 600000;
            end;
          {$ENDIF}

          try

            // Asignando el directorio temporal

            If   TemporalDataRemote
            then TmpDataPath := AddPathDelim( ApplicationPath ) + 'temp\'
            else TmpDataPath := TemporalDataPath;

            repeat
              FDirectTemporalPath := AddPathDelim( AddPathDelim( TmpDataPath ) + TmpDirBaseName + IntToStr( Random( 99999 ) ) );
            until not DirectoryExists( FDirectTemporalPath );

            CreateDirPath( FDirectTemporalPath, RsMsg10 );

            TemporalDataPath := FDirectTemporalPath;

            {  DEBUG ONLY
            If   not IsDesignTime
            then OnDatabaseError := ShowDatabaseError;
            }

            WinsockTransport.Port := PuertoWinsock;
            NamedPipeTransport.Port := PuertoLocal;

            // 03.09.2015 El transporte NamedPipe también se puede utilizar a través de una red Windows (SharedMemory era solo local)

            FRestrictedTableNames := TStringList.Create;

            If   DataAccessTransport=dtWinsock
            then begin
                 RemoteServerEngine.Transport := WinsockTransport;
                 If   ApplicationServerName<>''
                 then WinsockTransport.ServerName := ApplicationServerName;
                 end
            else begin
                 RemoteServerEngine.Transport := NamedPipeTransport;
                 If   ApplicationServerName<>''
                 then NamedPipeTransport.ServerName := ApplicationServerName;
                 end;

            MainSession.ServerEngine := RemoteServerEngine;
            
            MainSession.Active := True;
            SessionPool.Active := True;

            With AppDatabase do
              begin
              AliasPath := RootDataPath + DataAlias;
              Open;
              end;

          except on E : Exception do
            begin
            InitializationError := True;
            raise;
            end;
          end;

          end;
end;


procedure TDataAccessModule.DataModuleDestroy(Sender: TObject);
begin
     If   not IsDesignTime
     then begin
          AppDatabase.Active := False;

          If   MainSession.Active
          then CloseInactiveMainSessionResources;

          MainSession.Active := False;

          FRestrictedTableNames.Free;
          end;
     FDataAccessModule := nil;
end;

procedure TDataAccessModule.CloseInactiveMainSessionResources;
begin
     With MainSession do
       begin
       CloseInactiveTables;
       CloseInactiveFolders;
       end;
end;

procedure TDataAccessModule.CloseInactiveLocalSessionResources;
begin
     With LocalSession do
       begin
       CloseInactiveTables;
       CloseInactiveFolders;
       end;
end;

procedure TDataAccessModule.CloseSessionDatabases( ASession : TnxSession );

var  Index : SmallInt;

begin
     With ASession do
       For Index := 0 to DatabaseCount - 1 do
         Databases[ Index ].Close;
end;

function TDataAccessModule.ExecQuery( const SQLString  : String;
                                          RaiseError : Boolean = True ) : TnxDynVariantArray;
begin
     Result := DataAccess.ExecQuery( AppDatabase, SQLString, RaiseError );
end;

procedure TDataAccessModule.AddRestrictedTables( TableNames : array of string );

var  Index : SmallInt;

begin
     For Index := 0 to High( TableNames ) do
       FRestrictedTableNames.Add( TableNames[ Index ] );
end;

function  TDataAccessModule.IsARestrictedTable( TableName : string ) : Boolean;

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

procedure TDataAccessModule.WaitForTaskEnding;

var  CancelTask,
     Done : Boolean;

begin
     If   Assigned( TaskInfo )
     then With ProcessData do
            try
              If   Assigned( ProcessFrame )
              then ProcessFrame.ShowProgressBar;
              Done := False;
              While not Done do
                begin
                Sleep( 250 );
                TaskInfo.GetStatus( Done, TaskStatus );
                CheckStatus( TaskStatus.TsErrorCode );
                CancelTask := False;
                If   Assigned( FOnUpdateTableProgress )
                then CancelTask := FOnUpdateTableProgress( TableName, TaskStatus.TsPercentDone )
                else If   Assigned( ProcessFrame )
                     then begin
                          ProcessFrame.SetProgressBarPercent( TaskStatus.TsPercentDone );
                          CancelTask := ProcessFrame.Canceled;
                          end;
                Application.ProcessMessages;
                If   CancelTask
                then begin
                     TaskInfo.Cancel;
                     Abort;
                     end;
                end;
            finally
              TaskEnded;
              end;
end;

procedure TDataAccessModule.TaskEnded;
begin
     If   Assigned( TaskInfo )
     then TaskInfo.Free;
     If   Assigned( ProcessFrame )
     then ProcessFrame.HideProgressBar;
end;

function  TDataAccessModule.PackTable( Database  : TnxDatabase;
                                       TableName : String ) : TProcessResult;
begin
     try
       FPackingTable := True;
       Result := 0;
       ProcessData.Database := Database;
       ProcessData.TableName := TableName;

       If   Assigned( FOnUpdateTableProgress ) or Assigned( ProcessFrame )
       then Result := BoolToModalResult( PackProcess )
       else Result := CreateRegForm( PackProcess );

     finally
       FPackingTable := False;
       end;
end;

function TDataAccessModule.PackProcess : Boolean;

var   Exists,
      Done : Boolean;
      PackResult : TnxResult;

begin
     Result := False;
     With ProcessData do
       begin
       Exists := Database.TableExists( TableName, '' );
       If   Exists
       then begin

            If   Assigned( FOnUpdateTableProgress )
            then FOnUpdateTableProgress( TableName, 0 )
            else If   Assigned( ProcessFrame )
                 then ProcessFrame.AddMsg( ntInformation, '  ' + TableName )
                 else begin
                      RegForm.InfoLabel.Caption := TableName + '.' + #13 + RsMsg61;
                      Application.ProcessMessages;
                      end;

            TaskInfo := nil;
            PackResult := Database.PackTableEx( TableName, '', TaskInfo );
            If   PackResult=DBIERR_NONE
            then begin
                 WaitForTaskEnding;
                 Result := True;
                 end
            else begin
                 TaskEnded;
                 ShowNotification( ntStop, RsMsg72, Format( RsMsg14, [ TableName ] ) + ' ' + RsMsg64 + nxGetErrorString( PackResult ) );
                 Abort;
                 end;

            end;
       end;
end;

procedure TDataAccessModule.PackTables( Database   : TnxDatabase;
                                        TableNames : array of String );

var  Index : SmallInt;

begin
     If   Assigned( ProcessFrame )
     then ProcessFrame.AddMsg( ntInformation, RsMsg65 );
     For Index := 0 to High( TableNames ) do
       PackTable( Database, ExtractFileNameWithoutExtension( TableNames[ Index ] ) );
end;

procedure InitializeDataAccessModule;
begin
     DataAccessModule;
end;

initialization

   If   IsDesignTime
   then InitializeDataAccessModule
   else AddProcedure( imStartup, 0, InitializeDataAccessModule );

   FReestructureNotifyList := TReestructureNotifyList.Create;
   FRecoverNotifyList := TRecoverNotifyList.Create;

finalization

   FreeAndNil( FDataAccessModule );

   FreeAndNil( FReestructureNotifyList );
   FreeAndNil( FRecoverNotifyList );

end.

