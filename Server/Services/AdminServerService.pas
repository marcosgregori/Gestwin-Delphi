unit AdminServerService;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,

  Data.DB,

  sgcWebSocket_Classes,
  sgcJSON,

  AppManager,
  SectionData,
  BaseSessionData,
  SessionData;

type

  TGetValueFunction = reference to function( SessionDataModule : TBaseSessionDataModule ) : Variant;

  TAdminServerServiceDataModule= class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private

    function SessionActive( Index : SmallInt ) : Boolean;
    function GetDataInIndexValue( DataIn : IsgcJSON ) : SmallInt;
    procedure GetSessionDataValue( DataIn, DataOut : IsgcJSON; GetValueFunction : TGetValueFunction );
    procedure SessionAdded( SessionID : LongInt; ClientType : TClientType; ClientName : String );
    procedure SessionRemoved( SessionID : LongInt; ClientType : TClientType; ClientName : String );

  public

    function GetSessionsDataList( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function CloseSessionByIndex( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SaveSettings( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetDirStruct( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    {
    function GetSessionsCount( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function IsSessionActive( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function GetSessionStart( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function GetSessionID( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function GetSessionProgramNumber( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function GetSessionClientType( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function GetSessionClientName( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    }

    function GetServerInfo( Wsc : TsgcWSConnection; DataIn,DataOut : IsgcJSON ) : Boolean;

    function GetServerSettings( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetServerSettings( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetServerEngineSettings( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetServerEngineSettings( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetTCPIPv4TransportSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetTCPIPv4TransportSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetNamedPipeTransportSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetNamedPipeTransportSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetFileServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetFileServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetRPCServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetRPCServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function GetWebServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function SetWebServiceSettings( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    function BackupServer( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;
    function IsBackupRunning( Wsc: TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean;

    procedure SessionsDataListUpdated;


  end;

function AdminServerServiceData : TAdminServerServiceDataModule;

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses  StrUtils,
      Variants,

      nxDB,
      nxsrServerEngine,
      nxllComponent,
      nxllTransport,
      nxsrBufferManager,

      DataManager,
      LibUtils,
      ServerUtils,
      DateUtils,

      BaseServerContainer,
      ServerContainer,
      nxDmServer,

      SessionIntf;

{$R *.dfm}

var  AdminServerServiceDataModule : TAdminServerServiceDataModule = nil;

const  JournalEngineModesArray : TStringArray = [ 'Tnx1xJournalEngine', 'Tnx1xCommitJournalEngine', 'Tnx1xRollbackJournalEngine' ];
       PriorityArray : TStringArray = ['Parado', 'La más baja', 'Baja', 'Normal', 'Alta', 'La más alta', 'Tiempo crítico'];

function AdminServerServiceData : TAdminServerServiceDataModule;
begin
     If   not Assigned( AdminServerServiceDataModule )
     then AdminServerServiceDataModule := TAdminServerServiceDataModule.Create( BaseServerContainerModule );
     Result := AdminServerServiceDataModule;
end;

procedure TAdminServerServiceDataModule.DataModuleCreate( Sender : TObject );
begin
     With BaseServerContainerModule do
       begin
       AddAdminWebServiceFunction( 'GetSessionsDataList', GetSessionsDataList );
       AddAdminWebServiceFunction( 'GetDirStruct', GetDirStruct );

       AddAdminWebServiceFunction( 'CloseSessionByIndex', CloseSessionByIndex );
       AddAdminWebServiceFunction( 'SaveSettings', SaveSettings );

       AddAdminWebServiceFunction( 'GetServerInfo', GetServerInfo );

       AddAdminWebServiceFunction( 'GetServerSettings', GetServerSettings );
       AddAdminWebServiceFunction( 'SetServerSettings', SetServerSettings );

       AddAdminWebServiceFunction( 'GetServerEngineSettings', GetServerEngineSettings );
       AddAdminWebServiceFunction( 'SetServerEngineSettings', SetServerEngineSettings );

       AddAdminWebServiceFunction( 'GetTCPIPv4TransportSettings', GetTCPIPv4TransportSettings );
       AddAdminWebServiceFunction( 'SetTCPIPv4TransportSettings', SetTCPIPv4TransportSettings );

       AddAdminWebServiceFunction( 'GetNamedPipeTransportSettings', GetNamedPipeTransportSettings );
       AddAdminWebServiceFunction( 'SetNamedPipeTransportSettings', SetNamedPipeTransportSettings );

       AddAdminWebServiceFunction( 'GetFileServiceSettings', GetFileServiceSettings );
       AddAdminWebServiceFunction( 'SetFileServiceSettings', SetFileServiceSettings );

       AddAdminWebServiceFunction( 'GetRPCServiceSettings', GetRPCServiceSettings );
       AddAdminWebServiceFunction( 'SetRPCServiceSettings', SetRPCServiceSettings );

       AddAdminWebServiceFunction( 'GetWebServiceSettings', GetWebServiceSettings );
       AddAdminWebServiceFunction( 'SetWebServiceSettings', SetWebServiceSettings );

       AddAdminWebServiceFunction( 'BackupServer', BackupServer );
       AddAdminWebServiceFunction( 'IsBackupRunning', IsBackupRunning );

       OnSessionAdded.Add( SessionAdded );
       OnSessionRemoved.Add( SessionRemoved );
       end;

end;

function TAdminServerServiceDataModule.SaveSettings( Wsc     : TsgcWSConnection;
                                                     DataIn,
                                                     DataOut : IsgcJSON ) : Boolean;
begin
     dmServer.Server.SaveSettings( BaseServerContainerModule.ConfigFileName );
     DataOut.AddPair( 'FileName', BaseServerContainerModule.ConfigFileName );  // DataOut EscapeStrings es True
     Result := True;
end;

function TAdminServerServiceDataModule.SessionActive( Index : SmallInt ) : Boolean;
begin
     Result := ( Index>=0 ) and ( Index<=SessionDataList.Count ) and Assigned( SessionDataList[ Index ] );
end;

procedure TAdminServerServiceDataModule.SessionAdded( SessionID  : LongInt;
                                                      ClientType : TClientType;
                                                      ClientName : String );
begin
     SessionsDataListUpdated;  /// De momento solo necesito saber que la lista de sesiones ha cambiado
end;

procedure TAdminServerServiceDataModule.SessionRemoved( SessionID  : LongInt;
                                                        ClientType : TClientType;
                                                        ClientName : String );
begin
     SessionsDataListUpdated;
end;

function TAdminServerServiceDataModule.GetDataInIndexValue( DataIn : IsgcJSON ) : SmallInt;
begin
     Result := GetNodeValue( DataIn, 'index', -1 );
end;

function TAdminServerServiceDataModule.GetDirStruct( Wsc     : TsgcWSConnection;
                                                     DataIn,
                                                     DataOut : IsgcJSON ) : Boolean;
begin
     (*
     { [ { 'name': 'Documents',
           'isDirectory': true,
           'items': [ { 'name': 'Projects',
                        'isDirectory': true,
                        'items': [ { 'name': 'About',
                                     'isDirectory': true } ]
                      }
                    ],
         { 'name': 'Passwords',
           'isDirectory': true }
       ]
     }
     *)

     Result := True;

end;

procedure TAdminServerServiceDataModule.GetSessionDataValue( DataIn,
                                                             DataOut          : IsgcJSON;
                                                             GetValueFunction : TGetValueFunction );

var  Index : SmallInt;
     ResultValue : Variant;

begin
     Index := GetDataInIndexValue( DataIn );
     If   SessionActive( Index )
     then ResultValue := GetValueFunction( SessionDataList[ Index ] )
     else ResultValue := 0;
     DataOut.Node[ 'result' ].Value := ResultValue;
end;

// Notificaciones

procedure TAdminServerServiceDataModule.SessionsDataListUpdated;
begin
     // "{\"id\":\"0.325131753945749\",\"event\":\"GetSessionsDataList\",\"data\":{\"data\":[],\"totalCount\":0}}"

     BaseServerContainerModule.AdminWebServer.Broadcast( '{"id":"", "event":"SessionsDataListUpdated"}' );
end;

// RPCs

function TAdminServerServiceDataModule.BackupServer( Wsc     : TsgcWSConnection;
                                                     DataIn,
                                                     DataOut : IsgcJSON ) : Boolean;
begin
     Result := False;
     With ServerContainerModule do
       If   not BackingUp
       then begin
            BackupAsync;
            Result := True;
            end;
end;

function TAdminServerServiceDataModule.IsBackupRunning( Wsc     : TsgcWSConnection;
                                                        DataIn,
                                                        DataOut : IsgcJSON ) : Boolean;
begin
     Result := ServerContainerModule.BackingUp;
end;

function TAdminServerServiceDataModule.GetSessionsDataList( Wsc     : TsgcWSConnection;
                                                            DataIn,
                                                            DataOut : IsgcJSON ) : Boolean;
var  SessionDataModule : TBaseSessionDataModule;
     RecordsDataArray,
     RecordArray,
     RecordNode : IsgcJSON;
     TotalCount,
     Index : Integer;

begin
     RecordsDataArray := DataOut.AddArray( 'data' ).JSONObject;
     TotalCount := 0;
     For Index := 0 to SessionDataList.Count - 1 do
       begin
       SessionDataModule := SessionDataList[ Index ];
       If   Assigned( SessionDataModule ) // Es una TCompactList. Puede tener nulos.
       then begin
            RecordNode := RecordsDataArray.AddObject( StrInt( Index ) ).JSONObject;
            RecordNode.AddPair( 'Id', Index );  // Tiene que ser la posición real en la lista porque se utiliza para identificar la sesión en las llamadas
            RecordNode.AddPair( 'SessionId', SessionDataModule.ID );
            RecordNode.AddPair( 'ProgramNumber', SessionDataModule.ProgramNumber );
            RecordNode.AddPair( 'ClientType', Ord( SessionDataModule.ClientType ) );
            RecordNode.AddPair( 'ComputerName', SessionDataModule.ComputerName );
            RecordNode.AddPair( 'UserName', SessionDataModule.UserName );
            RecordNode.AddPair( 'StartedAt', FormatDateTime( 'dd/mm/yyyy hh:MM:ss', SessionDataModule.StartedAt ) );
            RecordNode.AddPair( 'LastAccess', SessionDataModule.LastAccess );
            Inc( TotalCount );
            end;
       end;
     DataOut.AddPair( 'totalCount', TotalCount );
     Result := True;
end;

function TAdminServerServiceDataModule.GetTCPIPv4TransportSettings( Wsc     : TsgcWSConnection;
                                                                    DataIn,
                                                                    DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'Active', dmServer.TCPIPv4Transport.Active );
     DataOut.AddPair( 'EventLogEnabled', dmServer.TCPIPv4Transport.EventLogEnabled );
     DataOut.AddPair( 'RespondToBroadcasts', dmServer.TCPIPv4Transport.RespondToBroadcasts );
     DataOut.AddPair( 'CompressLimit', dmServer.TCPIPv4Transport.CompressLimit );
     DataOut.AddPair( 'Port', dmServer.TCPIPv4Transport.Port );
     DataOut.AddPair( 'ServerThreadPriority', PriorityArray[ Ord( dmServer.TCPIPv4Transport.ServerThreadPriority ) ] );
     DataOut.AddPair( 'WatchdogInterval', dmServer.TCPIPv4Transport.WatchdogInterval );
     DataOut.AddPair( 'ConcurrentIOCPThreads', dmServer.TCPIPv4Transport.ConcurrentIOCPThreads );
     DataOut.AddPair( 'BroadCastThreadPriority', PriorityArray[ Ord( dmServer.TCPIPv4Transport.BroadCastThreadPriority ) ] );
     DataOut.AddPair( 'ListenThreadPriority', PriorityArray[ Ord( dmServer.TCPIPv4Transport.ListenThreadPriority ) ] );
     Result := True;
end;

function TAdminServerServiceDataModule.GetNamedPipeTransportSettings( Wsc     : TsgcWSConnection;
                                                                      DataIn,
                                                                      DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'Active', dmServer.NamedPipeTransport.Active );
     DataOut.AddPair( 'EventLogEnabled', dmServer.NamedPipeTransport.EventLogEnabled );
     DataOut.AddPair( 'RespondToBroadcasts', dmServer.NamedPipeTransport.RespondToBroadcasts );
     DataOut.AddPair( 'CompressLimit', dmServer.NamedPipeTransport.CompressLimit );
     DataOut.AddPair( 'Port', dmServer.NamedPipeTransport.Port );
     DataOut.AddPair( 'ServerThreadPriority', PriorityArray[ Ord( dmServer.NamedPipeTransport.ServerThreadPriority ) ] );
     DataOut.AddPair( 'WatchdogInterval', dmServer.NamedPipeTransport.WatchdogInterval );
     DataOut.AddPair( 'ConcurrentIOCPThreads', dmServer.NamedPipeTransport.ConcurrentIOCPThreads );
     Result := True;
end;

function TAdminServerServiceDataModule.GetFileServiceSettings( Wsc     : TsgcWSConnection;
                                                               DataIn,
                                                               DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'Active', dmServer.FileServiceSettings.Active );
     DataOut.AddPair( 'Port', dmServer.FileServiceSettings.Port );
     DataOut.AddPair( 'InternalAddresses', dmServer.FileServiceSettings.InternalAddresses );
     Result := True;
end;

function TAdminServerServiceDataModule.GetRPCServiceSettings( Wsc     : TsgcWSConnection;
                                                              DataIn,
                                                              DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'Active', dmServer.RPCServicesSettings.Active );
     DataOut.AddPair( 'Port', dmServer.RPCServicesSettings.Port );
     Result := True;
end;

function TAdminServerServiceDataModule.GetWebServiceSettings( Wsc     : TsgcWSConnection;
                                                              DataIn,
                                                              DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'Active', ServerContainerModule.WebServer.Active );
     DataOut.AddPair( 'Port', dmServer.WebServerServiceSettings.Port );
     Result := True;
end;

function TAdminServerServiceDataModule.SetWebServiceSettings( Wsc     : TsgcWSConnection;
                                                              DataIn,
                                                              DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

begin
     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then try

            ServerContainerModule.EnableWebServerTransport( False );

            dmServer.WebServerServiceSettings.Port := GetNodeValue( FormDataNode, 'Port', 80 );
            dmServer.WebServerServiceSettings.Active := GetNodeValue( FormDataNode, 'Active', True );

            If   dmServer.WebServerServiceSettings.Active
            then ServerContainerModule.EnableWebServerTransport( True );

            Result := True;

          except
            end;


end;

function TAdminServerServiceDataModule.CloseSessionByIndex(  Wsc     : TsgcWSConnection;
                                                             DataIn,
                                                             DataOut : IsgcJSON ) : Boolean;
begin
     BaseSessionData.CloseSessionByIndex( GetDataInIndexValue( DataIn ) );
     Result := True;
end;

function TAdminServerServiceDataModule.GetServerEngineSettings( Wsc     : TsgcWSConnection;
                                                                DataIn,
                                                                DataOut : IsgcJSON ) : Boolean;
var  Opt : TnxServerEngineOption;
     Options : Array of SmallInt;
     RecordNode,
     NodeArray : IsgcJSON;
     JournalEngineMode : SmallInt;

begin
     DataOut.AddPair( 'Active', dmServer.ServerEngine.Active );
     DataOut.AddPair( 'EventLogEnabled', dmServer.ServerEngine.EventLogEnabled );
     DataOut.AddPair( 'ServerName', dmServer.ServerEngine.ServerName );
     DataOut.AddPair( 'MaxRAM', dmServer.ServerEngine.MaxRAM );
     DataOut.AddPair( 'TempStoreSize', dmServer.ServerEngine.TempStoreSize );
     DataOut.AddPair( 'TempStorePath', dmServer.ServerEngine.TempStorePath );

     NodeArray := DataOut.AddArray( 'Options' ).JSONObject;

     Options := [];
     For Opt := Low( TnxServerEngineOption) to High( TnxServerEngineOption ) do
       NodeArray.AddPair( StrInt( Ord( Opt ) ), Opt in dmServer.ServerEngine.Options );

     JournalEngineMode := StringArrayIndexOf( JournalEngineModesArray, JournalEngineClass.ClassName );

     DataOut.AddPair( 'JournalEngineMode', JournalEngineMode );

     Result := True;
end;

function TAdminServerServiceDataModule.GetServerSettings( Wsc     : TsgcWSConnection;
                                                          DataIn,
                                                          DataOut : IsgcJSON ) : Boolean;
begin
     try

       DataOut.AddPair( 'AutoSaveConfig', dmServer.ServerSettings.AutosaveConfig );
       DataOut.AddPair( 'NotifyExceptions', dmServer.ServerSettings.NotifyExceptions );
       DataOut.AddPair( 'FromName', dmServer.ServerSettings.FromName );
       DataOut.AddPair( 'FromAddress', dmServer.ServerSettings.FromAddress );
       DataOut.AddPair( 'BackupData', dmServer.ServerSettings.BackupData );
       DataOut.AddPair( 'BackupTime', FormatDateTime( 'hhMM', dmServer.ServerSettings.BackupTime ) );
       DataOut.AddPair( 'BackupWeekend', dmServer.ServerSettings.BackupWeekend );
       DataOut.AddPair( 'RebuildData', dmServer.ServerSettings.RebuildData );
       DataOut.AddPair( 'RebuildTime', FormatDateTime( 'hhMM', dmServer.ServerSettings.RebuildTime ) );

       DataOut.AddPair( 'AdminWebServerPort', dmServer.AdminWebServerServiceSettings.Port );

     except
       end;

     Result := True;
end;

function TAdminServerServiceDataModule.GetServerInfo( Wsc     : TsgcWSConnection;
                                                      DataIn,
                                                      DataOut : IsgcJSON ) : Boolean;
begin
     DataOut.AddPair( 'VersionString', GetAppVersionString );
     Result := True;
end;

function TAdminServerServiceDataModule.SetServerEngineSettings( Wsc     : TsgcWSConnection;
                                                                DataIn,
                                                                DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;
     NodeArray : IsgcJSON;
     ServerEngineActive : Boolean;
     lClassName : String;
     lClass : TPersistentClass;
     TCPIPv4TransportActive,
     NamedPipeTransportActive : Boolean;

begin
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then begin

          ServerEngineActive := False;

          try

            TCPIPv4TransportActive := dmServer.TCPIPv4Transport.Active;
            NamedPipeTransportActive := dmServer.NamedPipeTransport.Active;

            dmServer.ServerEngine.Active := False;

            dmServer.ServerEngine.EventLogEnabled := GetNodeValue( FormDataNode, 'EventLogEnabled', True );
            dmServer.ServerEngine.ServerName := GetNodeValue( FormDataNode, 'ServerName', 'Gestwin' );
            dmServer.ServerEngine.MaxRAM := GetNodeValue( FormDataNode, 'MaxRAM', -1 );
            dmServer.ServerEngine.TempStoreSize := GetNodeValue( FormDataNode, 'TempStoreSize', -1 );

            dmServer.ServerEngine.Options := [];
            NodeArray := GetNodeObject( FormDataNode, 'Options' );
            For var I := 0 to NodeArray.Count - 1 do
              If   NodeArray.Item[ I ].Value
              then dmServer.ServerEngine.Options := dmServer.ServerEngine.Options + [ TnxServerEngineOption( I ) ];

            var JournalEngineModeIndex : SmallInt := GetNodeValue( FormDataNode, 'JournalEngineMode', 2 );
            If   not ( JournalEngineModeIndex in [ 0..2 ] )
            then JournalEngineModeIndex := 2;
            lClassName := JournalEngineModesArray[ JournalEngineModeIndex ];
            lClass := FindClass( lClassName );
            If   ( lClass<>nil ) and ( lClass.InheritsFrom( TnxBaseJournalEngine ) )
            then JournalEngineClass := TnxJournalEngineClass( lClass );

          finally
            dmServer.ServerEngine.Active := GetNodeValue( FormDataNode, 'Active', True );
            dmServer.TCPIPv4Transport.Active := TCPIPv4TransportActive;
            dmServer.NamedPipeTransport.Active := NamedPipeTransportActive;
            end;

          end;

     Result := True;
end;

function TAdminServerServiceDataModule.SetServerSettings( Wsc     : TsgcWSConnection;
                                                          DataIn,
                                                          DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

function StrToTime( Value  : String ) : TTime;

var  Hours, Minutes : Word;

begin
     try
        Hours := StrToInt( Copy( Value, 1, 2 ) );
        Minutes := StrToInt( Copy( Value, 3, 2 ) );
        Result := EncodeTime( Hours, Minutes, 0, 0 );
     except
       Result := 0;
       end;
end;

begin
     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then begin

          dmServer.ServerSettings.AutosaveConfig := GetNodeValue( FormDataNode, 'AutoSaveConfig', False );
          dmServer.ServerSettings.NotifyExceptions := GetNodeValue( FormDataNode, 'NotifyExceptions', False );
          dmServer.ServerSettings.FromName := GetNodeValue( FormDataNode, 'FromName', '' );
          dmServer.ServerSettings.FromAddress := GetNodeValue( FormDataNode, 'FromAddress', '' );
          dmServer.ServerSettings.BackupData := GetNodeValue( FormDataNode, 'BackupData', false );
          dmServer.ServerSettings.BackupTime := StrToTime( GetNodeValue( FormDataNode, 'BackupTime', '0000' ) );
          dmServer.ServerSettings.BackupWeekend := GetNodeValue( FormDataNode, 'BackupWeekend', false );
          dmServer.ServerSettings.RebuildData := GetNodeValue( FormDataNode, 'RebuildData', false );
          dmServer.ServerSettings.RebuildTime := StrToTime( GetNodeValue( FormDataNode, 'RebuildTime', '0000' ) );

          var AdminWebServerPort := dmServer.AdminWebServerServiceSettings.Port;
          dmServer.AdminWebServerServiceSettings.Port := GetNodeValue( FormDataNode, 'AdminWebServerPort', 10088 );
          If   ( AdminWebServerPort<>dmServer.AdminWebServerServiceSettings.Port ) and
               BaseServerContainerModule.AdminWebServer.Active
          then begin
               BaseServerContainerModule.EnableAdminWebServerTransport( False );
               BaseServerContainerModule.EnableAdminWebServerTransport( True );
               end;

          Result := True;
          end;
end;

function TAdminServerServiceDataModule.SetTCPIPv4TransportSettings( Wsc     : TsgcWSConnection;
                                                                    DataIn,
                                                                    DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

begin

     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then try

            dmServer.TCPIPv4Transport.Active := False;

            dmServer.TCPIPv4Transport.EventLogEnabled := GetNodeValue( FormDataNode, 'EventLogEnabled', True );
            dmServer.TCPIPv4Transport.RespondToBroadcasts := GetNodeValue( FormDataNode, 'RespondToBroadcasts', True );
            dmServer.TCPIPv4Transport.CompressLimit := GetNodeValue( FormDataNode, 'CompressLimit', -1 );
            dmServer.TCPIPv4Transport.Port := GetNodeValue( FormDataNode, 'Port', 16000 );

            dmServer.TCPIPv4Transport.ServerThreadPriority := TThreadPriority( StringArrayIndexOf( PriorityArray, GetNodeValue( FormDataNode, 'ServerThreadPriority', 'Normal' ) ) );
            dmServer.TCPIPv4Transport.WatchdogInterval := GetNodeValue( FormDataNode, 'WatchdogInterval', 10000 );
            dmServer.TCPIPv4Transport.ConcurrentIOCPThreads := GetNodeValue( FormDataNode, 'ConcurrentIOCPThreads', 0 );
            dmServer.TCPIPv4Transport.BroadCastThreadPriority := TThreadPriority( StringArrayIndexOf( PriorityArray, GetNodeValue( FormDataNode, 'BroadCastThreadPriority', 'Normal' ) ) );
            dmServer.TCPIPv4Transport.ListenThreadPriority := TThreadPriority( StringArrayIndexOf( PriorityArray, GetNodeValue( FormDataNode, 'ListenThreadPriority', 'Normal' ) ) );

            Result := True;
          finally
            dmServer.TCPIPv4Transport.Active := GetNodeValue( FormDataNode, 'Active', True );
            end;

end;

function TAdminServerServiceDataModule.SetNamedPipeTransportSettings( Wsc     : TsgcWSConnection;
                                                                      DataIn,
                                                                      DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

begin
     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then try

            dmServer.NamedPipeTransport.Active := False;

            dmServer.NamedPipeTransport.EventLogEnabled := GetNodeValue( FormDataNode, 'EventLogEnabled', True );
            dmServer.NamedPipeTransport.RespondToBroadcasts := GetNodeValue( FormDataNode, 'RespondToBroadcasts', True );
            dmServer.NamedPipeTransport.CompressLimit := GetNodeValue( FormDataNode, 'CompressLimit', -1 );
            dmServer.NamedPipeTransport.Port := GetNodeValue( FormDataNode, 'Port', 16000 );

            dmServer.NamedPipeTransport.ServerThreadPriority := TThreadPriority( StringArrayIndexOf( PriorityArray, GetNodeValue( FormDataNode, 'ServerThreadPriority', 'Normal' ) ) );
            dmServer.NamedPipeTransport.WatchdogInterval := GetNodeValue( FormDataNode, 'WatchdogInterval', 10000 );
            dmServer.NamedPipeTransport.ConcurrentIOCPThreads := GetNodeValue( FormDataNode, 'ConcurrentIOCPThreads', 0 );

            Result := True;
          finally
            dmServer.NamedPipeTransport.Active := GetNodeValue( FormDataNode, 'Active', True );
            end;

end;

function TAdminServerServiceDataModule.SetFileServiceSettings( Wsc     : TsgcWSConnection;
                                                               DataIn,
                                                               DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

begin
     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then begin
          dmServer.FileServiceSettings.Active := GetNodeValue( FormDataNode, 'Active', True );
          dmServer.FileServiceSettings.Port := GetNodeValue( FormDataNode, 'Port', 16000 );
          dmServer.FileServiceSettings.InternalAddresses := GetNodeValue( FormDataNode, 'InternalAddresses', '' );
          Result := True;
          end;

end;

function TAdminServerServiceDataModule.SetRPCServiceSettings( Wsc     : TsgcWSConnection;
                                                              DataIn,
                                                              DataOut : IsgcJSON ) : Boolean;
var  FormDataNode : IsgcJSON;

begin
     Result := False;
     FormDataNode := GetNodeObject( DataIn, 'formData' );
     If   Assigned( FormDataNode )
     then begin
          dmServer.RPCServicesSettings.Active := GetNodeValue( FormDataNode, 'Active', True );
          dmServer.RPCServicesSettings.Port := GetNodeValue( FormDataNode, 'Port', 16000 );
          Result := True;
          end;

end;

end.


