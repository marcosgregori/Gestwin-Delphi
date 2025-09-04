{##############################################################################}
{# NexusDB: dmMain.pas 4.7001                                                #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: main EM datamodule                                                #}
{##############################################################################}

{$I nxemDefine.inc}

unit dmMain;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  SysUtils,
  Classes,
  nxsrSqlEngineBase,
  nxsqlEngine,
  nxsdTypes,
  nxsdServerEngine,
  nxsrServerEngine,
  nxsdDataDictionary,
  nxdb,
  nxllComponent,
{$IFDEF NX_SECURE_STD_AESCCM}
  nxsscEncryptionEngineAesCcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_STD_XTSAES}
  nxssxEncryptionEngineXtsAesComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESCBCMAC}
  nxspEncryptionEngineAesCbcMacComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESCCM}
  nxspEncryptionEngineAesCcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_AESGCM}
  nxspEncryptionEngineAesGcmComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_SHACALCBCHMAC}
  nxspEncryptionEngineShacalCbcHmacComponent,
{$ENDIF}
{$IFDEF NX_SECURE_PRO_XCBAES}
  nxspEncryptionEngineXcbAesComponent,
{$ENDIF}
  DB,
  nxSqlTriggerExtender,
  nxsrAuditMonitor;

type
  TdmEM = class(TDataModule)
    nxSessionInMemOnly: TnxSession;
    dbEMSystem: TnxDatabase;
    dbInMemOnly: TnxDatabase;
    nxServerEngineInternalServer: TnxServerEngine;
    nxSqlEngineInternalServer: TnxSqlEngine;
    nxSessionEMSystem: TnxSession;
    taSQLLog: TnxTable;
    nxServerEngineEM: TnxServerEngine;
    nxSqlEngineEM: TnxSqlEngine;
    nxSqlTriggerMonitorInternalServer: TnxSqlTriggerMonitor;
    taSQLLogID: TUnsignedAutoIncField;
    taSQLLogRunAt: TDateTimeField;
    taSQLLogServerName: TWideStringField;
    taSQLLogDatabaseName: TWideStringField;
    taSQLLogSQL: TWideMemoField;
    taSQLLogSessionID: TGuidField;
    taSQLLogRunTime: TLongWordField;
    procedure DataModuleCreate(Sender: TObject);
    procedure nxServerEngineInternalServerStateChanged(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    nxAuditMonitor : TnxAuditMonitor;
    (*function GetTableVersion(aTableName : string) : string;
    procedure SetTableVersion(aTableName, aTableVersion : string);*)
  public
    function EMDescription : string;
  end;

var
  dmEM: TdmEM;

const
  sEMSystemAlias = '$EM_SYSTEM';

type
  TnxcgProgressCallback =
    procedure(const aTableName : String;
      var aStatus : TnxTaskStatus;
      var aCancel : Boolean) of object;

  procedure BuildAndEvolveDatabase(aDatabase : TnxDatabase;
    aProgressCallback : TnxcgProgressCallback = nil;
    const aPassword : String = '');

  procedure RestructureDatabase(aDatabase : TnxDatabase;
    aProgressCallback : TnxcgProgressCallback = nil;
    const aPassword : String = '');

  function TableCount: Integer;
  function GetTableDictionary(aDatabase : TnxDatabase; const aTableName : String): TnxDataDictionary;


implementation

{$R *.dfm}

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  ShellApi,
  nxllException,
  nxllUtils,
  nxllMemoryManager,
  nxExeConst,
  Math,
  StrUtils,
  Variants,
  DBCommon,
  nxllTypes,
  nxllBde,
  nxllWideString,
  nxsdConst,
  nxsdDataDictionaryStrings,
  nxsdDataDictionaryRefInt,
  nxsdDataDictionaryFulltext,
  nxsdFilterEngineSimpleExpression,
  nxsdFilterEngineSql,
  nxsdTableMapperDescriptor,
  nxsdRecordMapperDescriptor,
  nxSQLFunctionOrganizer,
  nxsdDataDictionaryAudit;

// SQLLog
function __SQLLog(aDatabase : TnxDatabase): TnxDataDictionary;
begin
  Result := TnxDataDictionary.Create;
  try
    with Result do begin
      AddRecordDescriptor(TnxBaseRecordDescriptor);
      with FieldsDescriptor do begin
        AddField('ID', '', nxtAutoInc, 10, 0, False);
        with AddField('RunAt', '', nxtDateTime, 0, 0, False) do
          AddDefaultValue(TnxCurrentDateTimeDefaultValueDescriptor);
        AddField('ServerName', '', nxtWideString, 200, 0, False);
        AddField('DatabaseName', '', nxtWideString, 200, 0, False);
        AddField('SQL', '', nxtBLOBWideMemo, 0, 0, False);
        AddField('QueryLog', '', nxtBLOBWideMemo, 0, 0, False);
        AddField('ErrorMessage', '', nxtBLOBWideMemo, 0, 0, False);
        AddField('SessionID', '', nxtGUID, 0, 0, False);
        AddField('RunTime', '', nxtWord32, 0, 0, False);
        AddField('RunTimeAsString', '', nxtWideString, 20, 0, False);
        AddField('QueryExecutionResult', '', nxtInt32, 0, 0, False);
      end;
      with EnsureIndicesDescriptor do begin
        with AddIndex('byID', 0, idNone), KeyDescriptor as TnxCompKeyDescriptor do
          Add(GetFieldFromName('ID'));
        with AddIndex('byServerNameDatabaseNameRunAt', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('ServerName'));
          Add(GetFieldFromName('DatabaseName'));
          Add(GetFieldFromName('RunAt'));
        end;
        with AddIndex('byServerNameRunAtDatabaseName', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('ServerName'));
          Add(GetFieldFromName('RunAt'));
          Add(GetFieldFromName('DatabaseName'));
        end;
        with AddIndex('byDatabaseNameServerNameRunAt', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('DatabaseName'));
          Add(GetFieldFromName('ServerName'));
          Add(GetFieldFromName('RunAt'));
        end;
        with AddIndex('byDatabaseNameRunAtServerName', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('DatabaseName'));
          Add(GetFieldFromName('RunAt'));
          Add(GetFieldFromName('ServerName'));
        end;
        with AddIndex('byRunAtDatabaseNameServerName', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('RunAt'));
          Add(GetFieldFromName('DatabaseName'));
          Add(GetFieldFromName('ServerName'));
        end;
        with AddIndex('byRunAtServerNameDatabaseName', 0, idAll), KeyDescriptor as TnxCompKeyDescriptor do begin
          Add(GetFieldFromName('RunAt'));
          Add(GetFieldFromName('ServerName'));
          Add(GetFieldFromName('DatabaseName'));
        end;
        AddIndex('SQLWords', 0, idAll, '', TnxMainIndexTokenKeyDescriptor);
      end;
      with EnsureFullTextDescriptor(Result) do begin
        with AddFullTextIndex('SQLWords', nil, 1) do begin
          AddFieldTokenExtractor(GetFieldFromName('SQL'));
          AddTokenFilter('TnxWideCharSeparatorTokenFilterDescriptor', TnxWideCharSeparatorTokenFilterDescriptor);
          AddTokenFilter('TnxLowercaseLocaleMappingTokenFilterDescriptor', TnxLowercaseLocaleMappingTokenFilterDescriptor);
          with AddTokenIndex('SQLWords', TnxMainIndexTokenIndexDescriptor) as TnxMainIndexTokenIndexDescriptor do begin
            MainIndexNumber := GetIndexFromName('SQLWords');
            IgnoreCase := True;
          end;
        end;
      end;
      CheckValid(False);
    end;
  except
    nxFreeAndNil(Result);
    raise;
  end;
end;

type
  TnxcgCreateDictCallback = function(aDatabase : TnxDatabase): TnxDataDictionary;

  TnxcgTableInfo = record
    TableName : String;
    Callback : TnxcgCreateDictCallback;
  end;

const
  TableInfos : array[0..0] of TnxcgTableInfo =
    ((TableName : 'SQLLog'; Callback : __SQLLog));

function TableCount: Integer;
begin
  Result := Length(TableInfos);
end;

function GetTableDictionary(aDatabase : TnxDatabase; const aTableName : String): TnxDataDictionary;
var
  I : Integer;
begin
  Result := nil;
  for I := Low(TableInfos) to High(TableInfos) do
    if SameText(aTableName, TableInfos[I].TableName) then begin
      Result := TableInfos[I].Callback(aDatabase);
      break;
    end;
end;

procedure RestructureTable(aDatabase : TnxDatabase;
  const aTableName, aPassword : String;
  aNewDict : TnxDataDictionary;
  aProgressCallback : TnxcgProgressCallback;
  var aCancelTask : Boolean;
  aFreeDict : Boolean = False);
var
  OldDict : TnxDataDictionary;
  Mapper : TnxTableMapperDescriptor;
  TaskInfo : TnxAbstractTaskInfo;
  Completed : Boolean;
  TaskStatus : TnxTaskStatus;
begin
  try
    OldDict := TnxDataDictionary.Create;
    try
      nxCheck(aDatabase.GetDataDictionaryEx(aTableName, aPassword, OldDict));
      if (aPassword <> '') and (aNewDict.EncryptionEngine = '') then
        aNewDict.EncryptionEngine := OldDict.EncryptionEngine;
      if OldDict.IsEqual(aNewDict) then
        Exit;
      Mapper := TnxTableMapperDescriptor.Create;
      try
        Mapper.MapAllTablesAndFieldsByName(OldDict, aNewDict);

        with TnxRecordMapperDescriptor(Mapper.RecordMapper) do
          if FieldMapperIndexOf('RunTime') >= 0 then
            UpdateSourceName('RunTime', '');

        nxCheck(aDatabase.RestructureTableEx(aTableName, aPassword, aNewDict, Mapper, TaskInfo));
        if Assigned(TaskInfo) then
          try
            while True do begin
              TaskInfo.GetStatus(Completed, TaskStatus);
              if Assigned(aProgressCallback) then
                aProgressCallback(aTableName, TaskStatus, aCancelTask);
              if Completed then
                break;
              if aCancelTask then
                nxCheck(TaskInfo.Cancel);
            end;
          finally
            TaskInfo.Free;
          end;
      finally
        Mapper.Free;
      end;
    finally
      OldDict.Free;
    end;
  finally
    if aFreeDict then
      aNewDict.Free;
  end;
end;

procedure BuildAndEvolveTable(aDatabase : TnxDatabase;
  const aTableName, aPassword : String;
  aCreateDictCallback : TnxcgCreateDictCallback;
  aProgressCallback : TnxcgProgressCallback;
  var aCancelTask : Boolean);
var
  Dict : TnxDataDictionary;
begin
  Dict := aCreateDictCallback(aDatabase);
  if Assigned(Dict) then
    try
      if not aDatabase.TableExists(aTableName, aPassword) then
        aDatabase.CreateTable(False, aTableName, aPassword, Dict)
      else
        RestructureTable(aDatabase, aTableName,
          aPassword, Dict, aProgressCallback, aCancelTask);
    finally
      Dict.Free;
    end;
end;

procedure BuildAndEvolveDatabase(aDatabase : TnxDatabase;
  aProgressCallback : TnxcgProgressCallback;
  const aPassword : String);
var
  I : Integer;
  CancelTask : Boolean;
begin
  CancelTask := False;
  for I := Low(TableInfos) to High(TableInfos) do begin
    BuildAndEvolveTable(aDatabase,
      TableInfos[I].TableName, aPassword,
      TableInfos[I].Callback, aProgressCallback, CancelTask);
    if CancelTask then
      Exit;
  end;
end;

procedure RestructureDatabase(aDatabase : TnxDatabase;
  aProgressCallback : TnxcgProgressCallback;
  const aPassword : String);
var
  I : Integer;
  CancelTask : Boolean;
begin
  CancelTask := False;
  for I := Low(TableInfos) to High(TableInfos) do begin
    RestructureTable(aDatabase,
      TableInfos[I].TableName, aPassword,
      TableInfos[I].Callback(aDatabase), aProgressCallback, CancelTask, True);
    if CancelTask then
      Exit;
  end;
end;


procedure TdmEM.DataModuleCreate(Sender: TObject);
begin
  sServerFunctionsHub.ServerEngine := nxServerEngineInternalServer;
  sServerFunctionsHub.LoadFromStorage(nil);
  if not ForceDirectories(nxAppHomeDirectory(nxAppDataSubdirVista) + sEMSystemAlias) then
    raise EnxBaseException.Create('Could not create system database directory :' + nxAppHomeDirectory(nxAppDataSubdirVista) + sEMSystemAlias);
  nxSessionEMSystem.AddAlias(sEMSystemAlias, nxAppHomeDirectory(nxAppDataSubdirVista) + sEMSystemAlias, True);
  dbEMSystem.AliasName := sEMSystemAlias;
  dbEMSystem.Open;
  if dbEMSystem.ReadOnly then
    raise EnxBaseException.Create('System Database is Read Only');
  BuildAndEvolveDatabase(dbEMSystem);
  taSQLLog.Open;
  if taSQLLog.ReadOnly then
    raise EnxBaseException.Create('System Database is Read Only');
  nxAuditMonitor := TnxAuditMonitor.Create(nil);
  nxAuditMonitor.ServerEngine := nxServerEngineInternalServer;
  nxAuditMonitor.Active:=true;
end;

procedure TdmEM.DataModuleDestroy(Sender: TObject);
begin
  nxAuditMonitor.Free;
end;

function TdmEM.EMDescription: string;
var
  Buffer   : string;
  Size     : TnxWord32;
  UserName : string;
begin
  Result := 'Enterprise Manager [';

  Size := 255;
  SetLength(UserName, Size) ;
   If GetUserName(PChar(UserName), Size) Then
     Result := Result + Copy(UserName, 1, Size - 1);

  Size := 256;
  SetLength(Buffer, Size) ;
  if GetComputerName(PChar(Buffer), Size) then
    Result := Result + ' on ' + Copy(Buffer, 1, Size);

  Result := Result  + ']';
end;

procedure TdmEM.nxServerEngineInternalServerStateChanged(Sender: TObject);
begin
  if (Sender as TnxServerEngine).Active then
    nxSqlTriggerMonitorInternalServer.Active := True;
end;




end.

