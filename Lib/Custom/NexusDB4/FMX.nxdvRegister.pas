{##############################################################################}
{# NexusDB: nxdvRegister.pas 4.1301                                          #}
{# Copyright (c) Nexus Database 2003-2017                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: Property Editors for NexusDB Client Components                    #}
{##############################################################################}

{$I nxDefine.inc}

unit FMX.nxdvRegister;

interface

procedure Register;

implementation

uses
  SysUtils,
  Classes,
  DesignIntf,
  DesignEditors,
  RTLConsts,
  TypInfo,
  DB,
  DBReg,
  FldLinks,
  ColnEdit,
  //.. FileCtrl,
  nxllLockedFuncs,
  nxllTypes,
  nxllThread,
  nxllComponent,
  nxlgEventLog,
  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  nxllSimpleCommandHandler,
  nxllSimpleSession,
  {$ENDIF}
  nxllPluginBase,
  nxllZipCompressor,
  nxllRleCompressor,
  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  nxlgEventLogDispatcher,
  nxlgEventBasedLog,
  nxlgWinEventLog,
  nxsdSimpleMonitor,
  {$ENDIF}
  nxdb,
  nxdbBackupController,
  nxdbBatchMove,
  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  nxdbDatabaseMapper,
  {$ENDIF}
  {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
  nxreRemoteServerEngine,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    nxchCommandHandler,
      {$IFDEF RS2010OrLater}
      nxmrClient,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  nxsrServerEngine,
  nxsqlEngine,
  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  nxsqlTriggerExtender,
  {$ENDIF}
  {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
  nxtwWinsockTransport,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    nxtnNamedPipeTransport,
    nxtmSharedMemoryTransport,
    nxtcCOMTransport,
    nxtsBaseSecuredTransport,
    nxtsBlowfishRC4SecuredTransport,
    {$ENDIF}
  {$ENDIF}
  nxseAllEngines,
  FMX.nxdvVersionProperty,
  {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    nxsiServerInfoPluginServer,
    nxsiServerInfoPluginClient,
    nxsiServerInfoPluginCommandHandler,
    {$ENDIF}
  nxServerManager,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    nxrpServer,
    nxrpClient,
    nxrpCommandHandler,
    nxrcRemoteCommandsPluginServer,
    nxrcRemoteCommandsPluginClient,
    nxrcRemoteCommandsPluginCommandHandler,
    nxscrBaseScriptingEngine,
    nxsscrServerScriptingEngine,
    {$ENDIF}
  {$ENDIF}
  nxsrSecurityMonitor,
  nxseAutoComponent,
  FMX.nxpvPlatformImplementation,
  nxsrEncryptionEngineBase,
  nxsdTypes;

{===TnxBackupControllerEncryptionEngineNameProperty====================================}
type
  TnxBackupControllerEncryptionEngineNameProperty = class(TDBStringProperty)
  public
    function AutoFill: Boolean; override;
    procedure GetValueList(List: TStrings); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxBackupControllerEncryptionEngineNameProperty.AutoFill: Boolean;
begin
  with (GetComponent(0) as TnxBackupController) do try
    Result := Assigned(OriginalDatabase) and OriginalDatabase.Active and Assigned(OriginalDatabase.Session) and OriginalDatabase.Session.Active;
  except
    Result := False;
  end;
end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxBackupControllerEncryptionEngineNameProperty.GetValueList(List: TStrings);
var
  D : TnxDatabase;
begin
  D := (GetComponent(0) as TnxBackupController).OriginalDatabase;
  if Assigned(D) and Assigned(D.Session) then
      D.Session.GetRegisteredClassList(setEncryptionEngines, List);
end;
{==============================================================================}



{===TnxDatabaseAliasNameProperty===============================================}
type
  TnxDatabaseAliasNameProperty = class(TDBStringProperty)
  public
    function AutoFill: Boolean; override;
    procedure GetValueList(List: TStrings); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxDatabaseAliasNameProperty.AutoFill: Boolean;
begin
  with GetComponent(0) as TnxDatabase do try
    Result := Assigned(Session) and Session.Active;
  except
    Result := False;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabaseAliasNameProperty.GetValueList(List: TStrings);
var
  S : TnxBaseSession;
begin
  S := (GetComponent(0) as TnxDatabase).Session;
  if Assigned(S) then
    S.GetAliasNames(List);
end;
{==============================================================================}



{===TnxDatabaseAliasPathProperty===============================================}
type
  TnxDatabaseAliasPathProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxDatabaseAliasPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end;
{------------------------------------------------------------------------------}
procedure TnxDatabaseAliasPathProperty.Edit;
var
  Dir : string;
begin
  Dir := GetValue;
  (*  //..
  if SelectDirectory('Select Database Directory', '', Dir{$IFDEF DCC9OrLater}, [sdNewUI, sdShowEdit, sdShowShares, sdValidateDir]{$ENDIF}) then
    SetValue(Dir);
  *)
end;
{==============================================================================}



{===TnxDataSetProperty=========================================================}
type
  TnxDataSetProperty = class(TDBStringProperty)
  public
    function AutoFill: Boolean; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxDataSetProperty.AutoFill: Boolean;
begin
  with GetComponent(0) as TnxDataSet do try
    Result :=
      Assigned(Session) and Session.Active and
      Assigned(Database) and Database.Active;
  except
    Result := False;
  end;
end;
{==============================================================================}


{===TnxComponentProperty=======================================================}
type
  TnxComponentProperty = class(TComponentProperty)
  end;
{==============================================================================}



{===TnxDataSetDatabaseProperty=================================================}
type
  TnxDataSetDatabaseProperty = class(TnxComponentProperty)
  protected
    function GetComponentReference: TComponent; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxDataSetDatabaseProperty.GetComponentReference: TComponent;
begin
  Result := inherited GetComponentReference;
  if (Result is TnxDatabase) and TnxDatabase(Result).Implicit then
    Result := nil;
end;
{==============================================================================}



{===TnxDataSetAliasNameProperty================================================}
type
  TnxDataSetAliasNameProperty = class(TnxDataSetProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxDataSetAliasNameProperty.GetValueList(List: TStrings);
var
  S : TnxBaseSession;
begin
  try
    S := (GetComponent(0) as TnxDataSet).Session;
    if Assigned(S) then begin
      S.GetAliasNames(List);
    end;
  except
  end;
end;
{==============================================================================}



{===TnxIndexNameProperty=======================================================}
type
  TnxIndexNameProperty = class(TIndexNameProperty)
  public
    function AutoFill: Boolean; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxIndexNameProperty.AutoFill: Boolean;
begin
  with GetComponent(0) as TnxDataSet do try
    Result :=
      Assigned(Session) and Session.Active and
      Assigned(Database) and Database.Active and
      Exists;
  except
    Result := False;
  end;
end;
{==============================================================================}



{===TnxIndexFieldNamesProperty=================================================}
type
  TnxIndexFieldNamesProperty = class(TIndexFieldNamesProperty)
  public
    function AutoFill: Boolean; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxIndexFieldNamesProperty.AutoFill: Boolean;
begin
  with GetComponent(0) as TnxDataSet do try
    Result :=
      Assigned(Session) and Session.Active and
      Assigned(Database) and Database.Active and
      Exists;
  except
    Result := False;
  end;
end;
{==============================================================================}



{===TnxTableNameProperty=======================================================}
type
  TnxTableNameProperty = class(TnxDataSetProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxTableNameProperty.GetValueList(List: TStrings);
var
  DB : TnxDatabase;
begin
  try
    DB := TnxDatabase((GetComponent(0) as TnxTable).Database);
    if Assigned(DB) then begin
      DB.Active := True;
      DB.GetTableNames(List);
    end;
  except
  end;
end;
{==============================================================================}



{===TnxStoredProcNameProperty==================================================}
type
  TnxStoredProcNameProperty = class(TnxDataSetProperty)
  public
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxStoredProcNameProperty.GetValueList(List: TStrings);
var
  DB   : TnxDatabase;
  Temp : TStringList;
begin
  List.BeginUpdate;
  try
    List.Clear;
    try
      DB := TnxDatabase((GetComponent(0) as TnxStoredProc).Database);
      if Assigned(DB) then begin
        DB.Active := True;
        Temp := TStringList.Create;
        try
          DB.GetStoredProcNames(Temp);
          List.AddStrings(Temp);
          DB.GetStoredFuncNames(Temp);
          List.AddStrings(Temp);
        finally
          Temp.Free;
        end;
      end;
    except
    end;
  finally
    List.EndUpdate;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxStoredProcNameProperty.SetValue(const Value: string);
begin
  inherited;
  if AutoFill then
    (GetComponent(0) as TnxStoredProc).RefreshParam;
end;
{==============================================================================}



{===TnxTableFieldLinkProperty==================================================}
type
  TnxTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    flpTable: TnxTable;
  protected
    procedure GetFieldNamesForIndex(List: TStrings); override;
    function GetIndexBased: Boolean; override;
    function GetIndexDefs: TIndexDefs; override;
    function GetIndexFieldNames: string; override;
    function GetIndexName: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetIndexName(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    property IndexBased: Boolean read GetIndexBased;
    property IndexDefs: TIndexDefs read GetIndexDefs;
    property IndexFieldNames: string read GetIndexFieldNames write SetIndexFieldNames;
    property IndexName: string read GetIndexName write SetIndexName;
    property MasterFields: string read GetMasterFields write SetMasterFields;

    procedure Edit; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxTableFieldLinkProperty.Edit;
var
  Table: TnxTable;
begin
  Table := DataSet as TnxTable;
  flpTable := TnxTable.Create(nil);
  try
    flpTable.Database := Table.Database;
    flpTable.TableName := Table.TableName;
    if Table.IndexFieldNames <> '' then
      flpTable.IndexFieldNames := Table.IndexFieldNames else
      flpTable.IndexName := Table.IndexName;
    flpTable.MasterFields := Table.MasterFields;
    flpTable.Password := Table.Password;
    flpTable.Open;
    inherited Edit;
    if Changed then
    begin
      Table.MasterFields := flpTable.MasterFields;
      if flpTable.IndexFieldNames <> '' then
        Table.IndexFieldNames := flpTable.IndexFieldNames else
        Table.IndexName := flpTable.IndexName;
    end;
  finally
    flpTable.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxTableFieldLinkProperty.GetFieldNamesForIndex(List: TStrings);
var
  i: Integer;
begin
  for i := 0 to flpTable.IndexFieldCount - 1 do
    List.Add(flpTable.IndexFields[i].FieldName);
end;
{------------------------------------------------------------------------------}
function TnxTableFieldLinkProperty.GetIndexBased: Boolean;
begin
  Result := not IProviderSupport(flpTable).PSIsSQLBased;
end;
{------------------------------------------------------------------------------}
function TnxTableFieldLinkProperty.GetIndexDefs: TIndexDefs;
begin
  Result := flpTable.IndexDefs;
end;
{------------------------------------------------------------------------------}
function TnxTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := flpTable.IndexFieldNames;
end;
{------------------------------------------------------------------------------}
function TnxTableFieldLinkProperty.GetIndexName: string;
begin
  Result := flpTable.IndexName;
end;
{------------------------------------------------------------------------------}
function TnxTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := flpTable.MasterFields;
end;
{------------------------------------------------------------------------------}
procedure TnxTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  flpTable.IndexFieldNames := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxTableFieldLinkProperty.SetIndexName(const Value: string);
begin
  flpTable.IndexName := Value;
end;
{------------------------------------------------------------------------------}
procedure TnxTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  flpTable.MasterFields := Value;
end;
{==============================================================================}



{===TnxQueryParamsProperty=====================================================}
type
  TnxQueryParamsProperty = class(TCollectionProperty)
  public
    function GetColOptions: TColOptions; override;
  end;
{------------------------------------------------------------------------------}
function TnxQueryParamsProperty.GetColOptions: TColOptions;
begin
  Result := [];
end;
{==============================================================================}


{$IFNDEF NX_BDE_REPLACEMENT_EDITION}
{===TnxDatabaseMappingAliasNameProperty================================================}
type
  TnxDatabaseMappingAliasNameProperty = class(TnxDataSetProperty)
  public
    function AutoFill: Boolean; override;
    procedure GetValueList(List: TStrings); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxDatabaseMappingAliasNameProperty.AutoFill: Boolean;
begin
  with GetComponent(0) as TnxDatabaseMapping do try
    Result :=
      Assigned(Mapper.DefaultSession) and Mapper.DefaultSession.Active;
  except
    Result := False;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxDatabaseMappingAliasNameProperty.GetValueList(List: TStrings);
var
  S : TnxBaseSession;
begin
  try
    S := (GetComponent(0) as TnxDatabaseMapping).Mapper.DefaultSession;
    if Assigned(S) then begin
      S.GetAliasNames(List);
    end;
  except
  end;
end;
{==============================================================================}
{$ENDIF}



{==============================================================================}
type
  TnxThreadPriorityProperty = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxThreadPriorityProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paRevertable];
end;
{------------------------------------------------------------------------------}
function TnxThreadPriorityProperty.GetValue: string;
begin
  Result := ThreadPriorityToString(TnxThreadPriority(GetOrdValue));
end;
{------------------------------------------------------------------------------}
procedure TnxThreadPriorityProperty.GetValues(Proc: TGetStrProc);
begin
  GetThreadPriorities(Proc);
end;
{------------------------------------------------------------------------------}
procedure TnxThreadPriorityProperty.SetValue(const Value: string);
var
  NewValue: Longint;
begin
  if IdentToThreadPriority(Value, NewValue) then
    SetOrdValue(NewValue)
  else
    inherited SetValue(Value);
end;
{==============================================================================}



{===TnxSimpleAddStringList=====================================================}
type
  TnxSimpleAddStringList = class(TStringList)
  public
    procedure SimpleAdd(const s: string);
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxSimpleAddStringList.SimpleAdd(const s: string);
begin
  Add(s);
end;
{==============================================================================}



{===TnxInterfacedComponentProperty=============================================}
type
  TnxInterfacedComponentProperty = class(TnxComponentProperty)
  public
    function GetIID: TGUID; virtual; abstract;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TnxInterfacedComponentProperty.GetValues(Proc: TGetStrProc);
var
  sl        : TnxSimpleAddStringList;
  i         : Integer;
  Component : TComponent;
  Unknown   : IUnknown;
begin
  sl := TnxSimpleAddStringList.Create;
  try
    inherited GetValues(sl.SimpleAdd);
    for i := 0 to Pred(sl.Count) do begin
      Component := Designer.GetComponent(sl[i]);
      if Assigned(Component) and Component.GetInterface(GetIID, Unknown) then
        Proc(sl[i]);
      Unknown := nil;
    end;
  finally
    sl.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxInterfacedComponentProperty.SetValue(const Value: string);
var
  Component : TComponent;
  Unknown   : IUnknown;
begin
  inherited SetValue(Value);

  Component := GetComponentReference;

  if Assigned(Component) then begin

    if Component.GetInterface(GetIID, Unknown) then begin
      Unknown := nil;
      Exit;
    end;

    inherited SetValue('');

    raise EPropertyError.CreateRes(@SInvalidPropertyValue);

  end;

end;
{==============================================================================}



{===TnxSessionRequestInterfacedComponentProperty=================================================}
type
  TnxSessionRequestInterfacedComponentProperty = class(TnxInterfacedComponentProperty)
  public
    function GetIID: TGUID; override;
  end;
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
function TnxSessionRequestInterfacedComponentProperty.GetIID: TGUID;
begin
  Result := InxSessionRequests;
end;
{==============================================================================}

var
  _PlatformAddRef: Integer;

{===Register===================================================================}
procedure Register;
begin
  {$IFDEF DCC9OrLater}
  ForceDemandLoadState(dlDisable);
  {$ENDIF}

  if LockedExchange(_PlatformAddRef, 1) = 0 then
    FMX.nxpvPlatformImplementation.AddRef;

  RegisterComponents('NexusDB', [
    TnxSession,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    TnxSessionPool,
    {$ENDIF}
    TnxTransContext,
    TnxDatabase,
    TnxTable,
    TnxQuery,
    TnxStoredProc,
    TnxCachedDataSet,
    TnxSqlUpdateObject,
    TnxMemTable,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    TnxSqlTriggerMonitor,
    {$ENDIF}
    TnxBackupController,
    TnxServerEngine,
    {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
    TnxRemoteServerEngine,
      {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
        {$IFDEF RS2010OrLater}
        TnxMessageRelayClient,
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
    TnxSqlEngine,
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    TnxSimpleMonitor,
    {$ENDIF}
    TnxBatchMove,
    {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
    TnxWinsockTransport,
      {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
      TnxServerCommandHandler,
      TnxNamedPipeTransport,
      TnxSharedMemoryTransport,
      TnxCustomCOMTransport,
      TnxRegisteredCOMTransport,
      TnxBlowfishRC4SecuredTransport,
      TnxSecuredCommandHandler,
      {$ENDIF}
    {$ENDIF}
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    TnxEventLog,
    TnxEventLogDispatcher,
    TnxEventBasedLog,
    TnxWinEventLog,
    {$ENDIF}
    {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
      {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
      TnxSimpleCommandHandler,
      TnxSimpleSession,
      TnxServerInfoPlugin,
      TnxRemoteServerInfoPlugin,
      TnxServerInfoPluginCommandHandler,
      TnxRemotingServer,
      TnxRemotingClient,
      TnxRemotingCommandHandler,
      TnxRemoteRemoteCommandsPlugin,
      TnxServerRemoteCommandsPlugin,
      TnxRemoteCommandsPluginCommandHandler,
      {$ENDIF}
    {$ENDIF}
    TnxSecurityMonitor,
    {$IFNDEF NX_EMBEDDEDSERVER_ONLY}
      {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
      TnxServerManager,
      TnxCustomConnectionFilter,
      TnxPascalScriptEngine,
      TnxServerScriptEngine,
      {$ENDIF}
    {$ENDIF}
    {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
    TnxDatabaseMapper,
    {$ENDIF}
    Tnx1xAllEngines,
    TnxseAllEngines
  ]);

  RegisterFields([TnxMemoField]);
  {$IFDEF VER200}
  RegisterFields([TLongWordField, TShortintField, TByteField, TExtendedField, TUnsignedAutoIncField]);
  {$ENDIF}
  {$IFDEF VER210}
  RegisterFields([TUnsignedAutoIncField]);
  {$ENDIF}
  {$IFDEF VER220}
  RegisterFields([TUnsignedAutoIncField]);
  {$ENDIF}

  RegisterPropertyEditor(TnxStateComponent.ClassInfo, TnxBasePluginEngine, 'Session', TnxSessionRequestInterfacedComponentProperty);

  RegisterPropertyEditor(TypeInfo(TnxThreadPriority), TComponent, '', TnxThreadPriorityProperty);

  {register the property editors...}
  {...for databases}
  RegisterPropertyEditor(TypeInfo(string), TnxDatabase, 'AliasName', TnxDatabaseAliasNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TnxDatabase, 'AliasPath', TnxDatabaseAliasPathProperty);

  {...for datasets}
  RegisterPropertyEditor(TnxDatabase.ClassInfo, TnxDataSet, 'Database', TnxDataSetDatabaseProperty);
  RegisterPropertyEditor(TypeInfo(string), TnxDataSet, 'AliasName', TnxDataSetAliasNameProperty);
  {...for datasets with index support}
  RegisterPropertyEditor(TypeInfo(string), TnxIndexDataSet, 'IndexName', TnxIndexNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TnxIndexDataSet, 'IndexFieldNames', TnxIndexFieldNamesProperty);
  {...for tables}
  RegisterPropertyEditor(TypeInfo(string), TnxTable, 'TableName', TnxTableNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TnxTable, 'MasterFields', TnxTableFieldLinkProperty);
  {...for queries}
  RegisterPropertyEditor(TypeInfo(TParams), TnxQuery, 'Params', TnxQueryParamsProperty);
  //RegisterPropertyEditor(TypeInfo(TStrings), TnxQuery, 'SQL', TnxStringListProperty);
  {...for stored procedures}
  RegisterPropertyEditor(TypeInfo(string), TnxStoredProc, 'StoredProcName', TnxStoredProcNameProperty);
  {..for version number property}
  RegisterPropertyEditor(TypeInfo(string), TnxComponent, 'Version', TnxVersionProperty);
  RegisterPropertyEditor(TypeInfo(string), TnxDataset, 'Version', TnxVersionProperty);
  {$IFNDEF NX_BDE_REPLACEMENT_EDITION}
  {...for database mapper}
  RegisterPropertyEditor(TypeInfo(string), TnxDatabaseMapping, 'AliasName', TnxDatabaseMappingAliasNameProperty);
  {$ENDIF}
  {...for backupcontroller}
  RegisterPropertyEditor(TypeInfo(string), TnxBackupController, 'EncryptionEngine', TnxBackupControllerEncryptionEngineNameProperty);

  RegisterPropertiesInCategory(sDatabaseCategoryName, TnxDatabase,
    ['Session', 'AliasName', 'AliasPath']);

  RegisterPropertiesInCategory(sDatabaseCategoryName, TnxDataSet,
    ['Session', 'Database', 'AliasName']);
end;
{==============================================================================}


initialization
  if LockedExchange(_PlatformAddRef, 1) = 0 then
    FMX.nxpvPlatformImplementation.AddRef;
finalization
  if _PlatformAddRef > 0 then
    FMX.nxpvPlatformImplementation.Release;
end.
