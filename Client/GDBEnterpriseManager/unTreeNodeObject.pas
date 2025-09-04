{##############################################################################}
{# NexusDB Enterprise Manager: unTreeNode.pas 4.7001                         #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Treenode object list support                   #}
{##############################################################################}

{$I nxemDefine.inc}

unit unTreeNodeObject;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  Classes,
  nxdb,
  nxsdServerEngine,
  nxllComponent,
  nxllTransport,
  nxchCommandHandler,
  nxtsBaseSecuredTransport,
  nxllList,
  nxmrClient,
  nxmrTypes;

type
  TnxemNodeType =
   (ntServer,
    ntDatabase,
    ntTables,
    ntTable,
    ntChildTable,
    ntViews,
    ntView,
    ntTriggers,
    ntTrigger,
    ntStoredProcs,
    ntProcedure,
    ntFunction,
    ntCheckConstraints,
    ntCheckConstraint);

  { this class is a placeholder for the nx objects for the treenodes
    in the treeview.

    server nodes contain tnxserverengine, tnxtransport, tnxsqlengine, tnxsession objects,
    depending on the type of serverengine.

    database nodes contain tnxdatabase objects

    table nodes contain tnxtable objects, reference counted. The same TnxTable instance is used for table browser, restructure, view, etc

    childtable nodes contain tnxtable objects
  }

  // implements "reference counting" to keep track of open vs close calls
  TnxTableRefCount = class(TnxTable)
  protected
    thRefCount : Integer;
  public
    procedure Open; reintroduce;
    procedure Close; reintroduce;
  end;

  TnxemNodeClass = class of TnxemNode;

  TnxemNode = class(TObject)
  protected {private}
    emnNodeType                    : TnxemNodeType;

    emnNxObject                    : TComponent;
    emnNxSession                   : TnxSession;
    emnNxTransport                 : TnxBaseTransport;
    emnNxServerCommandHandler      : TnxServerCommandHandler;
    emnMessageRelayClient          : TnxMessageRelayClient;
    emnSecuredCommandHandler       : TnxSecuredCommandHandler;

    emnMessageList                 : TnxFastStringList;

    emnInTransaction               : Boolean;
    emnTablesNodeObject,
    emnStoredProcsNodeObject,
    emnViewsNodeObject,
    emnTriggersNodeObject,
    emnCheckConstraintsNodeObject  : TnxemNode;

    emnTableBusy                   : Boolean;

    emnTablePasswords              : TnxFastStringListCS;

    function GetAsServerEngine: TnxBaseServerEngine;
    function GetAsDatabase: TnxDatabase;
    function GetAsTable: TnxTableRefCount;
    function GetInTransaction: Boolean;
    procedure SetAsDatabase(const Value: TnxDatabase);
    procedure SetAsServerEngine(const Value: TnxBaseServerEngine);
    procedure SetAsTable(const Value: TnxTableRefCount);
    procedure SetTransport(const Value: TnxBaseTransport);

    procedure DoLogin(aSender   : TnxBaseSession;
                  var aUserName : UnicodeString;
                  var aPassword : UnicodeString;
                  var aResult   : Boolean);

    procedure emnMessageReceived(aSender  : TnxMessageRelayClient;
                                 aMessage : TnxReceivedMessage);
  public
    UserName,
    Password                       : UnicodeString;

    destructor Destroy; override;

    procedure SetServerLicensePluginUsername(aUsername : string);

    procedure SetupMessaging;
    procedure ActivateMessaging;

    property NodeType : TnxemNodeType read emnNodeType write emnNodeType;
    property ServerEngine : TnxBaseServerEngine read GetAsServerEngine write SetAsServerEngine;
    property Database : TnxDatabase read GetAsDatabase write SetAsDatabase;
    property Table : TnxTableRefCount read GetAsTable write SetAsTable;
    property Transport : TnxBaseTransport read emnNxTransport write SetTransport;
    property Session : TnxSession read emnNxSession;
    property TableBusy : Boolean read emnTableBusy write emnTableBusy;
    property InTransaction : Boolean read GetInTransaction write emnInTransaction;
    property TablesNodeObject : TnxemNode read emnTablesNodeObject write emnTablesNodeObject;
    property StoredProcsNodeObject : TnxemNode read emnStoredProcsNodeObject write emnStoredProcsNodeObject;
    property ViewsNodeObject : TnxemNode read emnViewsNodeObject write emnViewsNodeObject;
    property TriggersNodeObject : TnxemNode read emnTriggersNodeObject write emnTriggersNodeObject;
    property CheckConstraintsNodeObject : TnxemNode read emnCheckConstraintsNodeObject write emnCheckConstraintsNodeObject;
    property TablePasswords : TnxFastStringListCS read emnTablePasswords;
    property MessageRelayClient : TnxMessageRelayClient read emnMessageRelayClient;
    property MessageList : TnxFastStringList read emnMessageList;
  end;

var
  nxemNodeClass : TnxemNodeClass;

implementation

uses
  Sysutils,
  nxllPlatformInterface,
  nxllMemoryManager,
  nxllException,
  nxllBde,
  nxllPluginBase,
  nxsrServerEngine,
  nxreRemoteServerEngine,
  //.. nxslServerLicensePluginIntf,
  unConfigInfo,
  dmMain;

{ TnxemNode }

procedure TnxemNode.DoLogin(aSender: TnxBaseSession; var aUserName,
  aPassword: UnicodeString; var aResult: Boolean);
begin
  aResult := nxShowLoginFrm(aUserName, aPassword);
  UserName := aUserName;
  Password := aPassword;
end;

procedure TnxemNode.emnMessageReceived(aSender  : TnxMessageRelayClient;
                                       aMessage : TnxReceivedMessage);
begin
  emnMessageList.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ': ' + GUIDToString(aMessage.rmFrom) + ': ' + aMessage.rmMsg);
end;

function TnxemNode.GetAsDatabase: TnxDatabase;
begin
  Result := emnNxObject as TnxDatabase;
end;

function TnxemNode.GetAsTable: TnxTableRefCount;
begin
  Result := emnNxObject as TnxTableRefCount;
end;

function TnxemNode.GetAsServerEngine: TnxBaseServerEngine;
begin
  Result := emnNxObject as TnxBaseServerEngine;
end;

procedure TnxemNode.SetAsDatabase(const Value: TnxDatabase);
begin
  emnNxObject := Value;
  emnNodeType := ntDatabase;
end;

procedure TnxemNode.SetAsServerEngine(const Value: TnxBaseServerEngine);
begin
  emnNxObject := Value;
  emnNodeType := ntServer;

  emnNxSession := TnxSession.Create(nil);
  emnNxSession.OnLogin := DoLogin;
  emnNxSession.ServerEngine := Value;

  emnTablePasswords := TnxFastStringListCS.CreateSorted(dupIgnore);

  { global var that stops all automatic login dialogs }
//  nxShowLoginFrm := nil;
end;

procedure TnxemNode.SetAsTable(const Value: TnxTableRefCount);
begin
  emnNxObject := Value;
  emnNodeType := ntTable;
end;

procedure TnxemNode.SetServerLicensePluginUsername(aUsername: string);
{
var
  ServerLicense  : InxServerLicenseClientInterface;
}
begin
{ //..
  if not (emnNxObject is TnxServerEngine) then try
    if Session.AbstractSession.
      CreateInstanceFor('ServerLicenseMonitor', CLSID_ServerLicenseClientInterface, nil, InxServerLicenseClientInterface, ServerLicense) = S_OK then
      nxCheck(ServerLicense.SetUserName(aUsername));
  except
    on E:EnxBaseException do begin
      case E.ErrorCode of
        DBIERR_CLIENTSLIMIT : raise EnxBaseException.Create('Server Licence Plugin reports nxServer license limit was reached.');
        DBIERR_NX_LICENSE_EXPIRED : raise EnxBaseException.Create('Server Licence Plugin reports nxServer license has expired.');
        DBIERR_NX_UNKNOWNMSG : ; // "message is unrecognized" eg there is no server license plugin server-side
      else
        raise;
      end;
    end;
    on E:Exception do
      raise;
  end;
}
end;

procedure TnxemNode.SetTransport(const Value: TnxBaseTransport);
begin
  emnNxTransport := Value;
  if emnNxObject is TnxRemoteServerEngine then begin
    TnxRemoteServerEngine(emnNxObject).Transport := emnNxTransport;
  end
  else
  if emnNxObject is TnxServerEngine then begin
    nxFreeAndNil(emnNxServerCommandHandler);
    emnNxServerCommandHandler := TnxServerCommandHandler.Create(nil);
    emnNxServerCommandHandler.ServerEngine := TnxServerEngine(emnNxObject);
    if Assigned(Value) then begin
      Value.CommandHandler := emnNxServerCommandHandler;
      Value.Mode := nxtmListen;
      Value.Enabled := True;
      Value.Active := True;
    end;
  end;
end;

procedure TnxemNode.SetupMessaging;
begin
  if emnNxObject is TnxRemoteServerEngine then begin
    if not Assigned(emnMessageRelayClient) then
      emnMessageRelayClient := TnxMessageRelayClient.Create(nil);
    if not Assigned(emnMessageList) then
      emnMessageList := TnxFastStringList.Create;
    emnMessageRelayClient.Active := False;
    emnMessageRelayClient.Session := Session;
    emnMessageRelayClient.Description := dmEM.EMDescription;
    emnMessageRelayClient.Promiscuous := True;
    emnMessageRelayClient.OnMessageReceived := emnMessageReceived;
    if not Assigned(emnSecuredCommandHandler) then
      if emnNxTransport is TnxBaseSecuredTransport then begin
        emnSecuredCommandHandler := TnxSecuredCommandHandler.Create(nil);
        emnSecuredCommandHandler.SecuredTransport := emnNxTransport as TnxBaseSecuredTransport;
      end;
  end;
end;

procedure TnxemNode.ActivateMessaging;
begin
  if emnNxObject is TnxRemoteServerEngine then try
    emnMessageRelayClient.Active := True;
  except
    on E:EnxPluginEngineException do begin
      case E.ErrorCode of
        DBIERR_OSUNKNOWN : ; //couldn't activate, move on
      else
        raise;
      end;
    end;
    on E:EnxBaseException do begin
      case E.ErrorCode of
        DBIERR_NX_UNKNOWNMSG : ; // "message is unrecognized" eg there is no messaging plugin server-side
      else
        raise;
      end;
    end;
    on E:Exception do
      raise;
  end;
end;

destructor TnxemNode.Destroy;
begin
  nxFreeAndNil(emnNxServerCommandHandler);
  if (not (NodeType in [ntTables, ntTriggers, ntViews, ntStoredProcs, ntCheckConstraints])) and
      Assigned(emnNxObject) then
    nxFreeAndNil(emnNxObject);
  nxFreeAndNil(emnNxSession);
  if (emnNxTransport is TnxBaseSecuredTransport) and
      Assigned(TnxBaseSecuredTransport(emnNxTransport).Transport) then
    TnxBaseSecuredTransport(emnNxTransport).Transport.Free;
  nxFreeAndNil(emnNxTransport);
  nxFreeAndNil(emnTablePasswords);
  nxFreeAndNil(emnMessageRelayClient);
  nxFreeAndNil(emnMessageList);
  nxFreeAndNil(emnSecuredCommandHandler);
  inherited;
end;


function TnxemNode.GetInTransaction: Boolean;
begin
  GetAsDatabase;
  Result := emnInTransaction;
end;

{ TnxTableRefCount }

procedure TnxTableRefCount.Close;
begin
  Dec(thRefCount);
  if thRefCount <= 0 then begin
    inherited Close;
    if Config.AllowCloseInactive and Assigned(Database) and Assigned(Database.Session) then
      Database.Session.CloseInactiveTables;
  end;
end;

procedure TnxTableRefCount.Open;
begin
  inherited Open;
  Inc(thRefCount);
end;

initialization
  nxemNodeClass := TnxemNode;
end.
