unit ServerContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  Vcl.ExtCtrls,
  Generics.Collections,

  Data.DB,

  Spring,

  kbmMemTable,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWStreamFormat,
  kbmMWBinaryStreamFormat,
  kbmMWCustomSQLMetaData,
  kbmMWResolvers,
  kbmMWCustomTransport,
  kbmMWServer,
  kbmMWTCPIPIndyServerTransport,
  kbmMWJSONStreamFormat,
  kbmMWAS3Utils,
  kbmMWZipStdTransStream,
  kbmMWFilePool,

  SxBase,
  SxMain,
  ScroogeXHTML,
  ZipForge,

  nxdb,

  nxllComponent,
  nxllPluginBase,
  nxrpBase,
  nxrpServer,
  nxdbBackupController,
  nxsdServerEngine,
  nxreRemoteServerEngine,
  nxllTransport,
  nxptBasePooledTransport,
  nxtwWinsockTransport,
  nxtnNamedPipeTransport,

  sgcSocket_Classes,
  sgcIdContext,
  sgcIdCustomHTTPServer,
  sgcWebSocket_Classes,
  sgcWebSocket_Server,
  sgcWebSocket,
  sgcWebSocket_Classes_Indy,
  sgcWebSocket_Protocol_Base_Server,
  sgcWebSocket_Protocol_sgc_Server,
  sgcWebSocket_Protocol_Dataset_Server,
  sgcWebSocket_Protocols,
  sgcJSON,
  sgcBase_Classes,
  sgcTCP_Classes,
  sgcWebSocket_Protocol_Files_Server,
  
  AppManager,
  DataManager,
  BaseServerContainer,
  
  BaseSessionData;

type

  TServerService = ( ssAll, ssRPC, ssFileServer, ssWebsockets );

  TWebsocketsServiceFunction = function( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean of object;
  TWebSocketsServiceDictionary = TDictionary< String, TWebsocketsServiceFunction >;

  TServerContainerModule = class( TBaseServerContainerModule )
    CloneDatabase: TnxDatabase;
    OriginalDatabase: TnxDatabase;
    SessionSource: TnxSession;
    RemoteServerEngineSource: TnxRemoteServerEngine;
    BackupController: TnxBackupController;
    SessionTarget: TnxSession;
    RemoteServerEngineTarget: TnxRemoteServerEngine;
    SourceTransport: TnxNamedPipeTransport;
    TargetTransport: TnxNamedPipeTransport;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BackupControllerReportError(aSender: TnxBackupController;
      const aTableName: string; aException: Exception;
      var aAction: TnxErrorAction);
    procedure ZipForgeProcessFileFailure(Sender: TObject; FileName: string;
      Operation: TZFProcessOperation; NativeError, ErrorCode: Integer;
      ErrorMessage: string; var Action: TZFAction);

  private

    WatchDogTimer,
    BackupTimer,
    RebuildTimer : TTimer;
    FBackingUp,
    FBackupNow : Boolean;
    BackupTask : ITask;

    FWebServer: TWebSocketHTTPServer;
    FFunctionDictionary : TWebSocketsServiceDictionary;

    procedure BackupTimerTimer(Sender: TObject);
    procedure RebuildTimerTimer(Sender: TObject);
    procedure WatchDogTimerTimer(Sender: TObject);
    procedure Backup;

    procedure WebServerConnect( Connection: TsgcWSConnection );
    procedure WebServerMessage( Connection: TsgcWSConnection; const Text: string );

    procedure ServerSettingChanged( Sender : TObject );

  public

    procedure Setup( LoadSettings : Boolean = False ); override;
    procedure BackupAsync;
    procedure RegisterServices; override;
    procedure UnRegisterServices; override;

    // Web Server

    procedure EnableWebServerTransport(Active : Boolean); override;
    function WebServerTransportEnabled : Boolean; override;

    procedure AddWebServiceFunction( EventName : String; ServiceFunction : TWebsocketsServiceFunction );

    function CheckSessionDataModule( DataIn : IsgcJSON; var SessionDataModule : TBaseSessionDataModule; CheckClientId : Boolean = False ) : Boolean;
    procedure AddErrorMessage( DataOut : IsgcJSON; AErrorMessage : String;  AErrorCode : SmallInt );

    property BackingUp : Boolean read FBackingUp;
    property WebServer : TWebSocketHTTPServer read FWebServer;

  end;

  TServerContainerModuleClass = class of TServerContainerModule;

var  ServerContainerModule : TServerContainerModule = nil;

// Errores en los mensajes del servidor

const SE_WRONG_MESSAGE_SCHEMA  = 1;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses   System.UITypes,
       Forms,
       Files,
       DateUtils,
       LibUtils,
       ServerUtils,

       kbmMWFileService,

       nxsdTypes,
       nxsdDataDictionaryFullText,
       nxsrSystemStorage,
       nxServiceapp,
       nxdmServer,

       UpdateService,

       ApplicationServiceUnit,
       CapturadorServiceUnit,
       PreventaServiceUnit,

       SessionData,
       AdminServerService,
       WebService;

resourceString
     RsMsg1 = 'Se ha producido un error al realizar las copias de seguridad. ' ;
     RsMsg2 = 'Se ha realizado una copia de seguridad completa de los datos.';
     RsMsg3 = 'Ha ocurrido un error al iniciar el servidor Web.';
     RsMsg4 = 'Se ha iniciado un proceso automatizado de reconstrucción de resultados de la empresa %s.';
     RsMsg5 = 'El proceso automatizado de reconstrucción de resultados ha finalizado correctamente.';
     RsMsg6 = 'No se han podido cerrar todas las sesiones activas para realizar el proceso de reconstrucción.';
     RsMsg7 = 'Se ha producido un error durante el proceso de reconstrucción.';

procedure TServerContainerModule.DataModuleCreate(Sender: TObject);
begin
     inherited;

     ServerContainerModule := Self;


     {  De momento no está activado

     WatchDogTimer := TTimer.Create( Self );
     WatchDogTimer.OnTimer := WatchDogTimerTimer;
     WatchDogTimer.Interval := 30000;
     WatchDogTimer.Enabled := True;
     }

     BackupTimer := TTimer.Create( Self );
     BackupTimer.OnTimer := BackupTimerTimer;
     BackupTimer.Interval := 30000;
     BackupTimer.Enabled := False;

     RebuildTimer := TTimer.Create( Self );
     RebuildTimer.OnTimer := RebuildTimerTimer;
     RebuildTimer.Interval := 30000;
     RebuildTimer.Enabled := False;

     // Web Server

     FFunctionDictionary := TDictionary< String, TWebsocketsServiceFunction >.Create;

     FWebServer := TWebSocketHTTPServer.Create ( Self );

     FWebServer.DocumentRoot := './Web';
     FWebServer.Options.HTMLFiles := True;
     FWebServer.HTTP2Options.Enabled := True;
     FWebServer.Charset := 'utf-8';

     FWebServer.OnConnect := WebServerConnect;
     FWebServer.OnMessage := WebServerMessage;

     dmServer.ServerSettings.OnChanged.Add( ServerSettingChanged );

end;

procedure TServerContainerModule.DataModuleDestroy(Sender: TObject);
begin

     dmServer.ServerSettings.OnChanged.Remove( ServerSettingChanged );

     FFunctionDictionary.Free;
     // WatchDogTimer.Enabled := False;
     BackupTimer.Enabled := False;
     RebuildTimer.Enabled := False;
     inherited;
end;

procedure TServerContainerModule.RegisterServices;

var Sd : TkbmMWCustomServiceDefinition;

begin

     // Registrando los servicios

     Sd := Server.RegisterService( TUpdateService, False );
     With sd as TkbmMWFileServiceDefinition do
       begin
       RootPath := ApplicationPath + ServerRootPath;
       BlockSize :=  10 * ( 1024 * 1024 ); // Paquetes de 10Mb
       KeepPartialFileOnFailure := False;
       end;

     Sd := Server.RegisterService( TApplicationService, False );
     Sd := Server.RegisterService( TCapturadorService, False );
     Sd := Server.RegisterService( TPreventaService, False );

end;

procedure TServerContainerModule.UnRegisterServices;
begin

     Server.UnregisterService( TPreventaService.GetPrefServiceName );
     Server.UnregisterService( TCapturadorService.GetPrefServiceName );
     Server.UnregisterService( TApplicationService.GetPrefServiceName );
     Server.UnregisterService( TUpdateService.GetPrefServiceName );

end;

procedure TServerContainerModule.ServerSettingChanged(Sender: TObject);
begin
     RebuildTimer.Enabled := dmServer.ServerSettings.RebuildData;
     BackupTimer.Enabled := dmServer.ServerSettings.BackupData;
end;

procedure TServerContainerModule.BackupTimerTimer(Sender: TObject);

begin
     If   dmServer.ServerSettings.BackupData and not FBackingUp
     then begin
          // ShowNotification( ntInformation, 'Comprobando si se debe realizar la copia : ' + StrFormatTime( dmServer.ServerSettings.BackupTime, tfHoursMinutes ) + ' -> ' + StrFormatTime( Now, tfHoursMinutes )  );
          If   not ( ( DayOfWeek( Now ) in [ 1, 7 ] ) and not dmServer.ServerSettings.BackupWeekend )
          then If   ( HourOf( Now )=HourOf( dmServer.ServerSettings.BackupTime ) ) and ( MinuteOf( Now )=MinuteOf( dmServer.ServerSettings.BackupTime ) )
               then Backup;
          end;
end;

procedure TServerContainerModule.RebuildTimerTimer(Sender: TObject);

var  GlobalSessionDataModule,
     SessionDataModule : TSessionDataModule;
     CodigoEmpresa : String;

begin
     If   dmServer.ServerSettings.RebuildData
     then If   ( ( HourOf( Now )=HourOf( dmServer.ServerSettings.RebuildTime ) ) and ( MinuteOf( Now )=MinuteOf( dmServer.ServerSettings.RebuildTime ) ) )
          then begin

               RebuildTimer.Enabled := False;

               try

                 // Intentar cerrar las posibles sesiones activas no es aconsejable

                 GlobalSessionDataModule := GetSessionDataModuleExt( ctServer, 'Reconstruccion_Global', 'Reconstrucción de resultados', '', '' );
                 If   Assigned( GlobalSessionDataModule )
                 then With GlobalSessionDataModule.Dm00.EmpresaTable do
                        begin
                        First;
                        While not Eof do
                          begin

                          If   GlobalSessionDataModule.Dm00.DmEmpresaFields.Resultados_ReconstruirPeriodicamente.Value
                          then begin

                               CodigoEmpresa := GlobalSessionDataModule.Dm00.DmEmpresaFields.Codigo.Value;

                               LogMessage( Format( RsMsg4, [ CodigoEmpresa ] ) );
                               SessionDataModule := GetSessionDataModuleExt( ctServer,
                                                                             'Reconstruccion' + CodigoEmpresa,  // Si el ClientID no está asignado se intenta compartir la sessión
                                                                             'Empresa ' + CodigoEmpresa,
                                                                             '',
                                                                             CodigoEmpresa );

                               If   Assigned( SessionDataModule )
                               then try
                                      try
                                        SessionDataModule.Dm30.ReconstruccionResultadosModule.Reconstruccion;
                                        LogMessage( RsMsg5 );
                                      except on E : Exception do
                                        begin
                                        LogMessage( RsMsg7 + #13 + E.Message );
                                        Abort;
                                        end;
                                      end;

                                    finally
                                      SessionDataModule.Free;
                                      end;

                               end;

                          Next;
                          end;

                      end
                 else LogMessage( RsMsg6 );

               finally
                 GlobalSessionDataModule.Free;
                 RebuildTimer.Enabled := True;
                 end;
               end;
end;

procedure TServerContainerModule.Setup( LoadSettings : Boolean );
begin
     inherited;

     AdminServerServiceData;
     WebServiceData;  // De momento

end;

procedure TServerContainerModule.BackupAsync;
begin
     If   not FBackingUp
     then begin
          BackupTask := TTask.Create (
          procedure ()
          begin
            Backup;
          end );
          BackupTask.Start;
          end;
end;

procedure TServerContainerModule.Backup;

const TransactionsFile = 'nxTrans.cfg';

var   StrDay,
      CodigoEmpresa,
      ServerBackupPath,
      OriginalDatabaseDir,
      OriginalDatabasePath,
      CloneDatabasePath,
      TargetDayDirPath,
      TargetQuarterDirPath  : String;
      IoError : SmallInt;
      CompressedFileName,
      CompressedFilePath,
      MessageDescription,
      Path,
      TableName : String;
      FileList : TStringList;
      TableList : TStringList;
      TableArray : TnxStringArray;

      TaskInfo : TnxAbstractTaskInfo;
      TaskStatus : TnxTaskStatus;

function GetQuarterStr : String;

var  Month,
     Quarter : Word;

begin
     Month := MonthOf( Now );
     Quarter := ( Month div 3 ) + 1;
     Result := Quarter.ToString;
end;

begin

     try

       BackupTimer.Enabled := False;
       FBackingUp := True;

       FileList := TStringList.Create;
       TableList := TStringList.Create;

       var GlobalSessionDataModule := GetSessionDataModuleExt( ctServer, 'Backup_Global', 'Copias de seguridad', '', '' );
       If   Assigned( GlobalSessionDataModule )
       then try

              try

                RemoteServerEngineSource.Active := True;
                SessionSource.Active := True;
                SourceTransport.Active := True;

                RemoteServerEngineTarget.Active := True;
                SessionTarget.Active := True;
                TargetTransport.Active := True;
              

                StrDay := DayOfWeek( Now ).ToString;

                GetFileList( ApplicationPath, 'data_???', FileList, { Recursive } False, { RemoveExtension} False, { AddFileInfo } False, faDirectory );
                FileList.Insert( 0, 'data' );
                var Inx := FileList.IndexOf( 'data_999' );
                If   Inx>=0
                then FileList.Delete( inx );

                For var StrItem in FileList do
                  begin

                  CodigoEmpresa := Copy( StrItem, 6, 3 );  // Si es 'data' estará vacio

                  BackupController.Close;

                  OriginalDatabaseDir := StrItem;

                  If   dmServer.ServerSettings.BackupPath=''
                  then ServerBackupPath := AddPathDelim( ApplicationPath ) + 'Backup\Server\'
                  else ServerBackupPath := dmServer.ServerSettings.BackupPath;

                  CloneDatabasePath := TemporalDataPath + OriginalDatabaseDir + '\';

                  CreateDirPath( CloneDatabasePath );
                  EraseDirectory( CloneDatabasePath, { RemoveDir } False );

                  OriginalDatabasePath := AddPathDelim( ApplicationPath ) + OriginalDatabaseDir;   // Base de datos global

                  OriginalDatabase.Close;
                  OriginalDatabase.AliasPath := OriginalDatabasePath;

                  CloneDatabase.Close;
                  CloneDatabase.AliasPath := CloneDatabasePath;

                  OriginalDatabase.Open;
                  OriginalDatabase.GetTableNames( TableList );
                  TableArray := [];
                  For var TblName : String in TableList do
                    TableArray := TableArray + [ TblName ];
                  BackupController.SetTableList( TableArray );

                  CloneDatabase.Open;

                  try
                    BackupController.Backup;
                  finally
                    BackupController.Close;
                    OriginalDatabase.Close;
                    CloneDatabase.Close;
                    
                    end;

                  SessionTarget.CloseInactiveTables;
                  SessionTarget.CloseInactiveFolders;

                  CompressedFileName := OriginalDatabaseDir + '.zip';
                  CompressedFilePath := TemporalDataPath + CompressedFileName;
                  EraseFile( CompressedFilePath, False );  // Por si existe

                  try

                    var ZipForge := TZipForge.Create( nil );

                    try
                      ZipForge.CompressionLevel := clNormal;
                      ZipForge.Zip64Mode := zmAuto;
                      ZipForge.UnicodeFileNames := True;
                      ZipForge.OnProcessFileFailure := ZipForgeProcessFileFailure;

                      ZipForge.FileName := CompressedFilePath;
                      ZipForge.BaseDir := CloneDatabasePath;

                      ZipForge.OpenArchive;

                      ZipForge.FileMasks.Clear;
                      ZipForge.FileMasks.Add( '*.*' );
                      ZipForge.ExclusionMasks.Add( TransactionsFile );

                      ZipForge.AddFiles;

                      ZipForge.CloseArchive;

                    finally
                      FreeAndNil( ZipForge );
                      end;

                    CopyFile( CompressedFilePath, ServerBackupPath + CompressedFileName, [ cfOverWrite ] );

                    EraseDirectory( CloneDatabasePath );
                    EraseFile( CompressedFilePath, { NotifyError } False );

                  except on E : Exception do
                    ShowNotification( ntInformation, 'Excepción. Empresa : ' + CodigoEmpresa + '. ' + E.Message );
                    end;

                  // La copia de ficheros doc (básicamenbte PDFs) y reports es incremental. Algunos clientes generan todos los documentos en formato PDF para
                  // enviarselos a los clientes, por lo que el directorio suele ser enorme.

                  // Si CodigoEmpresa='' es porque se esta copiando data. En ese caso conviene aprovechar para copiar reports_

                  var DirPath := 'reports_' + CodigoEmpresa;
                  var SourceDir := AddPathDelim( ApplicationPath ) + DirPath;

                  If   DirectoryExists( SourceDir )
                  then CopyDirectory( SourceDir, ServerBackupPath + DirPath, [ cfOverWrite, cfCheckDate ] );

                  If   CodigoEmpresa<>''
                  then begin
                       DirPath := 'doc_' + CodigoEmpresa;
                       SourceDir := AddPathDelim( ApplicationPath ) + DirPath;
                       If   DirectoryExists( SourceDir )
                       then CopyDirectory( SourceDir, ServerBackupPath + DirPath, [ cfOverWrite, cfCheckDate ] );
                       end;

                  {

                  ShowNotification( ntInformation, Format( RsMsg2, [ OriginalDatabasePath ] ) );

                  TargetDayDirPath := AddPathDelim( dmServer.ServerSettings.BackupDestination ) + 'Dia_' + StrDay;
                  CreateDirPath( TargetDayDirPath );

                  CopyFile( CompressedFilePath, AddPathDelim( TargetDayDirPath ) + CompressedFileName, [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ] );

                  TargetQuarterDirPath := AddPathDelim( dmServer.ServerSettings.BackupDestination ) + 'Trimestre_' + GetQuarterStr;
                  CreateDirPath( TargetQuarterDirPath );

                  CopyFile( AddPathDelim( TargetDayDirPath ) + CompressedFileName, AddPathDelim( TargetQuarterDirPath ) + CompressedFileName, [ cfNotIfyIfAbsent, cfOverWrite, cfNotifyError ] );

                  }

                  end;

                ShowNotification( ntInformation, RsMsg2 );

              except on E : Exception do
                ShowNotification( ntError, RsMsg1, E.Message );
                end;

            finally
              FileList.Free;
              TableList.Free;
              GlobalSessionDataModule.Free;
              end;

     finally

       SourceTransport.Active := False;
       SessionSource.Active := False;
       RemoteServerEngineSource.Active := False;

       TargetTransport.Active := False;
       SessionTarget.Active := False;
       RemoteServerEngineTarget.Active := False;

       FBackingUp := False;
       BackupTimer.Enabled := True;
       end;

end;

procedure TServerContainerModule.BackupControllerReportError(       ASender    : TnxBackupController;
                                                              const ATableName : string;
                                                                    AException : Exception;
                                                              var   AAction    : TnxErrorAction );
begin
     inherited;
     If   Assigned( AException )
     then LogMessage( AException.Message );
     AAction := TnxErrorAction.eaTryNext;  // Intento seguir con la siguiente tabla
end;

procedure TServerContainerModule.EnableWebServerTransport(Active : Boolean);
begin
     If   FWebServer.Active<>Active
     then try
            FWebServer.Active := False;
            FWebServer.Port := dmServer.WebServerServiceSettings.Port;
            FWebServer.Active := Active;
          except on E : Exception do
            ShowNotification( ntWarning, RsMsg3, E.Message );
            end;
end;

function TServerContainerModule.WebServerTransportEnabled : Boolean;
begin
      Result := FWebServer.Active;
end;

procedure TServerContainerModule.ZipForgeProcessFileFailure(     Sender        : TObject;
                                                                 FileName      : string;
                                                                 Operation     : TZFProcessOperation;
                                                                 NativeError,
                                                                 ErrorCode     : Integer;
                                                                 ErrorMessage  : string;
                                                             var Action        : TZFAction );
begin
     inherited;
     LogMessage( ErrorMessage );
     Action := TZFAction.fxaIgnore;
end;

procedure TServerContainerModule.AddWebServiceFunction( EventName       : String;
                                                        ServiceFunction : TWebsocketsServiceFunction );
begin
     FFunctionDictionary.Add( EventName, ServiceFunction );
end;

procedure TServerContainerModule.WatchDogTimerTimer(Sender: TObject);
begin
     CheckWindowsSessionsStatus;
end;

procedure TServerContainerModule.WebServerConnect( Connection : TsgcWSConnection);
begin
     //
end;


procedure TServerContainerModule.AddErrorMessage( DataOut       : IsgcJSON;
                                                  AErrorMessage : String;
                                                  AErrorCode    : SmallInt );

var  NodeArray,
     NodeObject : IsgcJSON;
     ObjectIndex : SmallInt;

begin

     If   NodeExists( DataOut, 'errors', NodeArray )
     then ObjectIndex := NodeArray.Count + 1
     else begin
          NodeArray := DataOut.AddArray( 'errors' ).JSONObject;
          ObjectIndex := 1;
          end;

     // errors : [ { id, field, path, message }... ]

     NodeObject := NodeArray.AddObject( IntToStr( ObjectIndex ) ).JSONObject;
     NodeObject.AddPair(  'code', AErrorCode );
     NodeObject.AddPair(  'message', AErrorMessage );

     DataOut.AddPair( 'correct', False );  // Si ya existe se actualiza el valor
end;

function TServerContainerModule.CheckSessionDataModule(     DataIn            : IsgcJSON;
                                                        var SessionDataModule : TBaseSessionDataModule;
                                                            CheckClientId     : Boolean = False ) : Boolean;

var  SessionId : Integer;
     ClientId : String;
     Node : IsgcObjectJSON;

begin

     Result := False;
     SessionDataModule := nil;

     try

       If   not NodeExists( DataIn, 'sessionId', Node )
       then Result := True  // Es un mensaje que no pasa el sessionId, presumiblemente uno de gestión de sesiones
       else If   Node.Value<>'null'
            then begin
                 SessionId := Node.Value;
                 ClientId := GetNodeValue( DataIn, 'clientId', '' );

                 If   SessionId>=0
                 then begin
                      SessionDataModule := GetSessionDataModule( SessionId );
                      If   Assigned( SessionDataModule ) and CheckClientId
                      then If   SessionDataModule.ClientId<>ClientId
                           then SessionDataModule := nil;   // No es la sesión de este usuario
                      end;

                 Result := Assigned( SessionDataModule );

                 end;

     except
       end;

end;

procedure TServerContainerModule.WebServerMessage(       Connection : TsgcWSConnection;
                                                   const Text       : String );

var  EventName,
     EventId,
     StoreId : String;

     DataIn : TsgcJSON;

     Sf : TWebsocketsServiceFunction;
     DataOut : TsgcJSON;
     DataType,
     DataId,
     FunctionName : String;

     DataOutNode,
     DataInNode  : IsgcJSON;

     IdNode,
     EventNode : IsgcObjectJSON;
     SessionDataModule : TBaseSessionDataModule;

begin


     //  {"id":"0.4872582404836101","event":"GetSessionsDataList","data":{} }

     If   Text<>''
     then try

            DataIn := TsgcJSON.Create( nil );
            try

              DataIn.Read( Text );

              If   NodeExists( DataIn, 'id', IdNode )
              then begin
                   EventId := IdNode.Value;
                   If   NodeExists( DataIn, 'eventName', EventNode )
                   then begin
                        EventName := EventNode.Value;
                        If   EventName<>''
                        then begin

                             If   NodeExists( DataIn, 'data', DataInNode )
                             then begin

                                  FunctionName := EventName;

                                  StoreId := GetNodeValue( DataInNode, 'storeId', '' );
                                  If   StoreId<>''
                                  then StrAdd( FunctionName, '.' + StoreId );

                                  FFunctionDictionary.TryGetValue( FunctionName, Sf );
                                  If   Assigned( Sf )
                                  then try

                                         DataOut := TsgcJSON.Create( nil );   // Construyo un objeto de respuesta para que lo utilice la función
                                         try

                                           DataOut.AddPair( 'id', EventId);
                                           DataOut.AddPair( 'eventName', EventName );

                                           DataOutNode := DataOut.AddObject( 'data' ).JSONObject;
                                           TsgcJSON( DataOutNode ).EscapeStrings := True;

                                           CheckSessionDataModule( DataInNode, SessionDataModule, { CheckClientId } True );

                                           var Correct := Sf( SessionDataModule, DataInNode, DataOutNode );

                                           DataOut.AddPair( 'correct', Correct );

                                           // else AddErrorMessage( DataOut, 'Estructura del mensaje errónea', { SE_WRONG_MESSAGE_SCHEMA } 1 );

                                           Connection.WriteData( DataOut.Text );

                                         finally
                                           FreeAndNil( DataOut );
                                           end;

                                       except on E : Exception do
                                         ShowNotification( TNotificationType.ntError, E.Message );
                                         end;
                                  end
                             else ;  // Error?
                             end;
                        end;
                   end;

            finally
              FreeAndNil( DataIn );
              end;
          except
            // Pendiente
            end;
end;

initialization
    ServerContainerClass := TServerContainerModule;

end.

