unit BaseServerContainer;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ExtCtrls,
  Forms,
  Generics.Collections,

  kbmMWCustomTransport,
  kbmMWServer,
  kbmMWCustomHTTPService,
  kbmMWSOAPTransStream,
  kbmMWAJAXTransStream,
  kbmMWTCPIPIndyServerTransport,
  kbmMemTable,
  kbmMWCustomConnectionPool,
  kbmMWCustomDataset,
  kbmMWNexusDB,
  kbmMWStreamFormat,
  kbmMWBinaryStreamFormat,
  kbmMWCustomSQLMetaData,
  kbmMWResolvers,

  Spring,

  kbmMWXMLStreamFormat,
  kbmMWJSONStreamFormat,
  kbmMWFilePool,
  kbmMWONStreamFormat,
  kbmMWSecurity,
  kbmMWLZHCompression,
  kbmMWHTTPSysServerTransport,

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
  nxdmServer, sgcSocket_Classes;

type

  TSessionNotificationEvent = procedure( SessionID : LongInt; ClientType : TClientType = ctWindows; ClientName : String = ''  ) of object;

  TAdminWebsocketsServiceFunction = function( Wsc : TsgcWSConnection; DataIn, DataOut : IsgcJSON ) : Boolean of object;
  TAdminWebSocketsServiceDictionary = TDictionary< String, TAdminWebsocketsServiceFunction >;

  TWebSocketHTTPServer = class( TsgcWebSocketHTTPServer )
    protected
    public
    function DoResponseHTTP(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo): Boolean; override;
    end;

  TBaseServerContainerModule = class(TDataModule)
    ServerTransport: TkbmMWTCPIPIndyServerTransport;
    FilePool: TkbmMWFilePool;
    JSONStreamFormat: TkbmMWJSONStreamFormat;
    FileServerTransport: TkbmMWTCPIPIndyServerTransport;
    XMLStreamFormat: TkbmMWXMLStreamFormat;
    Server: TkbmMWServer;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    FAdminWebServer : TWebSocketHTTPServer;
    FConfigFileName : String;

    FAdminFunctionDictionary : TAdminWebSocketsServiceDictionary;

    FOnSessionAdded,
    FOnSessionRemoved : Event<TSessionNotificationEvent>;

    procedure DoOnException( Sender : TObject; E : Exception );
    procedure OnLog(const Line: string);

    procedure AdminWebServerConnect(Connection: TsgcWSConnection);
    procedure AdminWebServerMessage(Connection: TsgcWSConnection; const Text: string);
    procedure AdminWebServerCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;AResponseInfo: TIdHTTPResponseInfo);

  protected

    procedure UpdateKbmMWTransportBindings( ATransport : TkbmMWTCPIPIndyServerTransport; AEnabled : Boolean;APort: Integer );

  public

    function RPCTransportEnabled: Boolean;
    procedure EnableRPCTransport(Active : Boolean); virtual;

    procedure EnableFileTransport(Active : Boolean); virtual;
    function FileTransportEnabled: Boolean;

    procedure LoadConfigFile;

    // AdminWebServer

    procedure EnableAdminWebServerTransport(Active : Boolean);
    function AdminWebServerTransportEnabled: Boolean;
    procedure AddAdminWebServiceFunction( EventName : String; ServiceFunction : TAdminWebsocketsServiceFunction );

    // RPC Web Server

    procedure EnableWebServerTransport(Active : Boolean); virtual; abstract;
    function WebServerTransportEnabled: Boolean; virtual; abstract;

    procedure Setup( LoadSettings : Boolean = False ); virtual;

    procedure RegisterServices; virtual;
    procedure UnRegisterServices; virtual;

    procedure DoSessionAdded( SessionID : LongInt; ClientType : TClientType = ctWindows; ClientName : String = '' );
    procedure DoSessionRemoved( SessionID : LongInt; ClientType : TClientType = ctWindows; ClientName : String = '' );

    property ConfigFileName : String read FConfigFileName;
    property AdminWebServer : TWebSocketHTTPServer read FAdminWebServer;

    property OnSessionAdded : Event<TSessionNotificationEvent> read FOnSessionAdded write FOnSessionAdded;
    property OnSessionRemoved : Event<TSessionNotificationEvent> read FOnSessionRemoved write FOnSessionRemoved;

  end;

  TBaseServerContainerModuleClass = class of TBaseServerContainerModule;

var BaseServerContainerModule : TBaseServerContainerModule = nil;

procedure LogException( E : Exception; Component : TComponent = nil );

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.dfm}

uses  System.UITypes,

      IdGlobal,
      IdSocketHandle,

      nxllConvertException,
      nxllUtils,
      nxllFastFillChar,
      nxExeConst,
      nxsrSystemStorage,
      nxServiceApp,

      LibUtils,
      ServerUtils,

      BaseSessionData,
      MainData;
     
resourceString
      RsMsg12 = 'No existe el fichero de configuración %s.';
      RsMsg13 = 'No se ha podido conectar con el servidor de correo.'#13'Revise su configuración y reintente el proceso.';
      RsMsg14 = 'Debe indicar el servidor SMTP y el nombre del usuario de correo.';
      RsMsg16 = 'Notificación de error del servidor de datos de %s';
      RsMsg17 = 'No se ha podido enviar la notifición de una excepción por correo.';
      RsMsg18 = 'Revise la configuración de correo del servidor.';
      RsMsg19 = 'Ha ocurrido un error al iniciar el servidor de administración Web.';
      RsMsg23 = 'Se ha producido una excepción (*).';

      RsSoporte = 'Soporte';
      RsNotificationsAddress = 'soporte@gestwin.com';
      RsServidorIniciado = 'Servidor iniciado.';

const gsc_MainSettingsExtension = '.settings';

// Funciones

function HandleNotifications( NotificationType  : TNotificationType;
                              Header            : String;
                              Description       : String = '';
                              SystemMessage     : String = '';
                              ForceBoxMsg       : Boolean = False  ) : TModalResult;
begin
     LogMessage( Header + ' ' + Description );
     {
     If   Assigned( nxService.ServerContainerModule )
     then nxService.ServerContainerModule.SMTPNotification( NotificationType, Header, Description );
     }
end;

procedure LogException( E : Exception; Component : TComponent = nil );
begin
     try
       ConvertException( E, dmServer.EventLog, Component, 0 );
     except
       end;
end;

{ TBaseServerContainerModule }

procedure TBaseServerContainerModule.DataModuleCreate(Sender: TObject);
begin
     BaseServerContainerModule := Self;
     Application.OnException := DoOnException;
	    OnShowNotification := HandleNotifications;

     FAdminFunctionDictionary := TDictionary< String, TAdminWebsocketsServiceFunction >.Create;

     FAdminWebServer := TWebSocketHTTPServer.Create ( Self );

     FAdminWebServer.DocumentRoot := './ServerData/Admin';
     FAdminWebServer.HTTP2Options.Enabled := True;
     FAdminWebServer.Charset := 'UTF-8';

     FAdminWebServer.Options.HTMLFiles := True;
     FAdminWebServer.Options.JavascriptFiles := True;

     FAdminWebServer.OnConnect := AdminWebServerConnect;
     FAdminWebServer.OnCommandGet := AdminWebServerCommandGet;
     FAdminWebServer.OnMessage :=  AdminWebServerMessage;

     // FAdminWebServer.FHTTPServer.MIMETable.AddMimeType( { Ext } '.vue', { MIMEType } 'text/html' );

end;

procedure TBaseServerContainerModule.DataModuleDestroy(Sender: TObject);
begin
     FAdminFunctionDictionary.Free;
     UnRegisterServices;
end;

procedure TBaseServerContainerModule.LoadConfigFile;

Var  AName : String;

begin
     try

       FConfigFileName := ChangeFileExt( ExcludeTrailingBackslash( ApplicationPath ) + '\' + ExtractFileName( ParamStr( 0 ) ), gsc_MainSettingsExtension );
       If   not FileExists( FConfigFileName ) or
           ( nxFindCmdLineSwitch( csINTERACTIVE ) and nxFindCmdLineSwitch( csRESET ) )
       then begin
           AName := ChangeFileExt( ParamStr( 0 ), '.init');
           If   not FileExists( AName )
           then raise Exception.Create( Format( RsMsg12, [ AName ] ) );

           dmServer.Server.LoadSettings( AName );
           dmServer.Server.SaveSettings( FConfigFileName );
           end
       else dmServer.Server.LoadSettings( FConfigFileName );

       dmServer.AdminWebServerServiceSettings.Active := True;  // Siempre activo
       If   dmServer.AdminWebServerServiceSettings.Port=0      // No ha sido configurado nunca
       then begin
            dmServer.AdminWebServerServiceSettings.Port := 10088;
            dmServer.Server.SaveSettings( FConfigFileName );
            end;

       If   dmServer.WebServerServiceSettings.Port=0        // No ha sido configurado nunca
       then begin
            dmServer.WebServerServiceSettings.Active := True;
            dmServer.WebServerServiceSettings.Port := 8081;
            dmServer.Server.SaveSettings( FConfigFileName );
            end;

       {
       If   nxFindCmdLineSwitch( csINTERACTIVE ) and nxFindCmdLineParam( csWRITECONFIG, AConfigParam )
       then begin
         If   ( Copy( AConfigParam, 1, 1 )='"' ) and
              ( Copy( AConfigParam, Length( AConfigParam ), 1 )='"' )
         then AConfigParam := Copy( AConfigParam, 2, Length( AConfigParam ) - 2 );
         dmServer.Server.SaveSettings( AConfigParam );
         end;
       }
       // Si se produce un error durante la carga de la configuraci�n (un puerto ocupado o cualquier otra cosa) creo
       // que es mejor iniciar igualmente y permitir, al menos, que se pueda acceder a la aplicaci�n para copmprobar
       // la configuraci�n
     except
       end;
end;


procedure TBaseServerContainerModule.Setup( LoadSettings : Boolean = False );
begin

     SetCurrentDir( ApplicationPath );  // Importante cuando se inicia como servicio

     nxSetSystemDatabaseFolder( nxAppHomeDirectory( nxAppDataSubdirVista ) + '$SYSTEM'); // nxSetSystemDatabaseFolder( ApplicationPath + '$SYSTEM');

     LogMessage( 'Inicio del setup' );

     try

       If   LoadSettings
       then LoadConfigFile;

       ExecuteProcedures( imStartUp, [] );

       RegisterServices;

     except on E : Exception do
       begin
       If   not nxStartedAsService
       then ShowNotification( ntStop, ExceptionMessage( E ) );
       Application.Terminate;
       Abort;
       end;

     end;

end;

procedure TBaseServerContainerModule.RegisterServices;
begin
end;

procedure TBaseServerContainerModule.UnRegisterServices;
begin
end;

procedure TBaseServerContainerModule.DoOnException( Sender : TObject;
                                                    E      : Exception );
begin
     If   not ReleasingApplication and
          not IsDesignTime
     then begin
          ShowNotification( ntExceptionError, RsMsg23, ExceptionMessage( E ) );
          ConvertException( E, dmServer.EventLog, Sender, 0 );
          // Abort;
          end;
end;

procedure TBaseServerContainerModule.DoSessionAdded( SessionID  : LongInt;
                                                     ClientType : TClientType;
                                                     ClientName : String );
begin
     LogMessage( 'Inicio de sesión : ' + ClientTypeNames[ ClientType ] + ', ' + ClientName + ' : ' + IntToStr( SessionID ) );
     FOnSessionAdded.Invoke( SessionID, ClientType, ClientName );
end;

procedure TBaseServerContainerModule.DoSessionRemoved( SessionID  : LongInt;
                                                       ClientType : TClientType;
                                                       ClientName : String );
begin
     FOnSessionRemoved.Invoke( SessionID, ClientType, ClientName );
     LogMessage( 'Fin de sesión : ' + IntToStr( SessionID ) );
end;

procedure TBaseServerContainerModule.UpdateKbmMWTransportBindings( ATransport : TkbmMWTCPIPIndyServerTransport;
                                                                   AEnabled   : Boolean;
                                                                   APort      : Integer );

var  SocketHandle : TIdSocketHandle;

begin
     ATransport.Enabled := False;

     try

       If   AEnabled
       then begin
            If   ATransport.Bindings.Count=0
            then SocketHandle := ATransport.Bindings.Add
            else SocketHandle := ATransport.Bindings[ 0 ];
            If   Assigned( SocketHandle )
            then begin
                 SocketHandle.IP := '0.0.0.0';
                 SocketHandle.Port := APort;
                 end;
            end;

       If   AEnabled
       then begin
            ATransport.Listen;
            ATransport.Server.Active := True;
            end
       else ATransport.Close;

     except on E : Exception do
       begin
         {
         If   TnxStateComponentSettings.InteractiveActivation
         then raise;
         }
       LogException( E, ATransport );
       end;
     end;

end;

function TBaseServerContainerModule.RPCTransportEnabled : Boolean;
begin
      Result := Server.Active and ServerTransport.IsListening;
end;

procedure TBaseServerContainerModule.EnableRPCTransport( Active : Boolean );
begin
     UpdateKbmMWTransportBindings( ServerTransport, Active , dmServer.RPCServicesSettings.Port );
end;

procedure TBaseServerContainerModule.EnableFileTransport( Active : Boolean );
begin
     UpdateKbmMWTransportBindings( FileServerTransport, Active, dmServer.FileServiceSettings.Port );
end;

procedure TBaseServerContainerModule.EnableAdminWebServerTransport(Active : Boolean);
begin
     If   FAdminWebServer.Active<>Active
     then try
            FAdminWebServer.Active := False;
            FAdminWebServer.Port := dmServer.AdminWebServerServiceSettings.Port;
            FAdminWebServer.Active := Active;
          except on E : Exception do
            ShowNotification( ntWarning, RsMsg19, E.Message );
            end;
end;

function TBaseServerContainerModule.FileTransportEnabled: Boolean;
begin
     Result := Server.Active and FileServerTransport.IsListening;
end;

// AdminWebServer

procedure TBaseServerContainerModule.AdminWebServerCommandGet( AContext      : TIdContext;
                                                               ARequestInfo  : TIdHTTPRequestInfo;
                                                               AResponseInfo : TIdHTTPResponseInfo );
begin
     //
end;

procedure TBaseServerContainerModule.AdminWebServerMessage(       Connection : TsgcWSConnection;
                                                            const Text       : String );

var  EventName,
     EventId,
     StoreId : String;

     DataIn : TsgcJSON;

     Sf : TAdminWebsocketsServiceFunction;
     DataOut : TsgcJSON;
     DataType,
     DataId,
     FunctionName : String;

     DataOutNode,
     DataInNode  : IsgcJSON;

     IdNode,
     EventNode : IsgcObjectJSON;

begin


     //  {"id":"0.4872582404836101","eventName":"GetSessionsDataList","data":{} }

     If   Text<>''
     then try

            DataIn := TsgcJSON.Create( nil );
            try

              DataIn.Read( Text );

              If   NodeExists( DataIn, 'id', IdNode )
              then begin
                   EventId := IdNode.Value;
                   If   NodeExists( DataIn, 'event', EventNode )
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

                                  FAdminFunctionDictionary.TryGetValue( FunctionName, Sf );
                                  If   Assigned( Sf )
                                  then try

                                         DataOut := TsgcJSON.Create( nil );   // Construyo un objeto de respuesta para que lo utilice la función
                                         try

                                           DataOut.AddPair( 'id', EventId);
                                           DataOut.AddPair( 'event', EventName );

                                           DataOutNode := DataOut.AddObject( 'data' ).JSONObject;
                                           TsgcJSON( DataOutNode ).EscapeStrings := True;

                                           var Correct := Sf( Connection, DataInNode, DataOutNode );
                                           DataOut.AddPair( 'correct', Correct );

                                           Connection.WriteData( DataOut.Text );

                                         finally
                                           FreeAndNil( DataOut );
                                           end;

                                       except on E : Exception do
                                         begin
                                         ShowNotification( TNotificationType.ntError, E.Message );
                                         end;
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

procedure TBaseServerContainerModule.AddAdminWebServiceFunction( EventName       : String;
                                                                 ServiceFunction : TAdminWebsocketsServiceFunction );
begin
     FAdminFunctionDictionary.Add( EventName, ServiceFunction );
end;

function TBaseServerContainerModule.AdminWebServerTransportEnabled: Boolean;
begin
     Result := FAdminWebServer.Active;
end;

procedure TBaseServerContainerModule.OnLog( const Line : string );
begin
     //..
end;

procedure TBaseServerContainerModule.AdminWebServerConnect( Connection : TsgcWSConnection);
begin
     //
end;

{ TWebSocketHTTPServer }

function TWebSocketHTTPServer.DoResponseHTTP( AContext      : TIdContext;
                                              ARequestInfo  : TIdHTTPRequestInfo;
                                              AResponseInfo : TIdHTTPResponseInfo ) : Boolean;
begin
     If   ( ARequestInfo.Document = '/' ) or ( ExtractFileExt( ARequestInfo.Document )='' )
     then ARequestInfo.Document := '/index.html';
     Result := inherited;
end;

end.
