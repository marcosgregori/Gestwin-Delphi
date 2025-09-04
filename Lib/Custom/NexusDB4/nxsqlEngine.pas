{##############################################################################}
{# NexusDB: nxsqlEngine.pas 4.7516                                           #}
{# Copyright (c) UnSquashable Pty. Ltd. 2003-2025                             #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB: SQL Engine class                                                  #}
{##############################################################################}

{$I nxDefine.inc}

{$DEFINE SQLSupported}

unit nxsqlEngine;

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  Classes,
  SysUtils,
  nxllList,
  nxllTypes,
  nxllConst,
  nxllFastMove,
  nxllMemoryManager,
  nxllSync,
  nxsrSystemStorage,
  nxllStreams,
  nxsdTypes,
  nxsdServerEngine,
  nxsdDataDictionary,
  nxsdFilterEngineSQL,
  nxsdValidationEngine,
  nxsrSqlEngineBase,
  nxsrServerEngine,
  CocoaBaseW,
  nxsqlBase,
  nxsqlTok,
  nxsqlParse,
  nxsqlPSM,
  nxllComponent,
  nxsqlProxies;

type
  TnxSqlEngine = class;

  TnxSqlStatement = class(TnxServerStatement)
  private
    procedure EnsureLocalList;
    procedure AddLocal(Node: TnxSqlNode; UserData: TObject);
  protected {private}
    sqsSqlEngine       : TnxSqlEngine;

    sqsSqlEnginePrev   : TnxSqlStatement;
    sqsSqlEngineNext   : TnxSqlStatement;

    sqsTokens          : TTokenList;
    sqsRootNode        : TnxSqlBlock;
    sqsSource          : WideString;

    sqsStoredProc      : TnxSqlCREATEPROC;
    sqsStoredProcParms : InxTypedVariantList;

    sqsDatabaseProxy   : TnxSqlDatabaseProxy;
    sqsWideQuery       : WideString;

    FLocals            : TnxFastStringListIC;

    { InxExceptionData }
    procedure GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False); override;
  protected
    procedure sqsAddToSqlEngine;
    procedure sqsRemoveFromSqlEngine;

    procedure sqsParseQuery(Context: TnxSqlContext; const aQuery : WideString);
    procedure sqsLoadProcedure(const aStoredProc : WideString);
    procedure sqsBind;
    procedure sqsCreateDatabaseProxy;
  public
    constructor Create(aSqlEngine : TnxSqlEngine;
                       aDatabase  : TnxSqlAbstractDatabase;
                       aTimeout   : TnxWord32);
    destructor Destroy; override;

    procedure PrepareDestroy; override;

    function ssPrepare(aStatementType : TnxStatementType;
                 const aQueryText     : WideString;
                       aStream        : TStream)
                                      : TnxResult; override;

    function ssExec(out aCursor   : TnxAbstractCursor;
                        aOpenMode : TnxOpenMode;
                        aStream   : TStream)
                                  : TnxResult; override;

    function ssSetParams(const aParams : TnxSqlParamList;
                               aStream : TStream)
                                       : TnxResult; override;

    function ssGetParams(const aParams : TnxSqlParamList;
                               aStream : TStream)
                                       : TnxResult; override;
    procedure InvalidateParamDependentResults(Node: TnxSqlNode; UserData: TObject);

    property DatabaseProxy: TnxSqlDatabaseProxy read sqsDatabaseProxy;
  end;

  { This component encapsulates the full SQL engine. If your app
    or custom server does not need SQL capability, you can leave it out.
    To use, put on a datamodule and set the TnxServerEngine.SQLEngine
    property to point to this component.

    See Also: TnxServerEngine, SQLEngine
  }
  {$IFDEF DCC16OrLater}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 {$IFDEF DCC29OrLater}or pidWin64x{$ENDIF} {or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidAndroid})]
  {$ENDIF}
  TnxSqlEngine = class(TnxBaseSQLEngine)
  protected {private}
    sqeStmtLogging       : Boolean;
    sqeStmtLogDatabase       : TnxAbstractDatabase;
    sqeStmtLogSession        : TnxAbstractSession;
    sqeStmtLogTable      : TnxsdCursorWrapper;
    sqeStmtBookmarkSize  : integer;
    sqeStmtLogTableName  : String;
    sqeStmtLogPathName   : String;
    sqeStatementsPadlock : TnxPadlock;
    sqeStatementsHead    : TnxSqlStatement;
    sqeStatementsTail    : TnxSqlStatement;

    sqeSQLScriptFolder   : string;

    sqeDictionaryMode    : TnxSqlPSMDictionaryMode;

    FLCID                : Integer;

    procedure sqeSetDictionaryMode(const Value: TnxSqlPSMDictionaryMode);
    function sqeGetUseFieldCache: Boolean;
    procedure sqeSetUseFieldCache(const Value: Boolean);
  protected

    procedure scStopping; override;

    procedure LogEnd(aBookmark: PnxBookmarkBuffer;
                     aStatement: TnxSqlStatement;
                     Errorcode: integer; const ErrorString: String);
    function LogStart(aStatement: TnxSqlStatement): PnxBookmarkBuffer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property LCID: Integer read FLCID write FLCID;

    procedure GetConfigSettings(aSettings: TnxBaseSettings); override;
    procedure LoadConfig(aConfig: TnxBaseComponentConfiguration); override;
    procedure SaveConfig(aConfig: TnxBaseComponentConfiguration); override;
    procedure LoadSettingsFromStream(aReader: TnxReader); override;
    procedure SaveSettingsToStream(aWriter: TnxWriter); override;
    procedure PrepareShutdown; override;
    function StatementAlloc(aDatabase  : TnxAbstractDatabase;
                        out aStatement : TnxAbstractStatement;
                            aTimeout   : TnxWord32)
                                       : TnxResult; override;
    function LoadTriggersForTable(aDatabase: TnxSqlDatabaseProxy; const aTableName: string; var TriggerList: TnxList): Boolean;
  published
    property DictionaryMode: TnxSqlPSMDictionaryMode
      read sqeDictionaryMode
      write sqeSetDictionaryMode
      default dmPersistant;
    property StmtLogging: Boolean
      read sqeStmtLogging write sqeStmtLogging;
    property StmtLogTableName: String
      read sqeStmtLogTableName write sqeStmtLogTableName;
    property StmtLogPathName: String
      read sqeStmtLogPathName write sqeStmtLogPathName;
    property UseFieldCache: Boolean
      read sqeGetUseFieldCache write sqeSetUseFieldCache;
    property SQLScriptFolder: string 
	  read sqeSQLScriptFolder write sqeSQLScriptFolder;
  end;

  EnxSqlFilterStatementException = class(EnxBaseSqlFilterStatementException);

  TnxSqlFilterStatement = class(TnxBaseSqlFilterStatement)
  protected {priavte}
    sfsAbstractCursor : TnxAbstractCursor;

    sfsRootNode       : TnxSqlBlock;
    sfsTokens         : TTokenList;
    sfsLocalContext   : TnxSqlContext;
    sfsWideQuery      : WideString;
  protected
    function Evaluate: Boolean; override;
  public
    constructor Create(aFieldsSource : InxFieldsSource;
                 const aSqlText      : WideString); override;

    destructor Destroy; override;
  end;

  EnxSqlCheckStatementException = class(EnxBaseSqlCheckStatementException);

  TnxSqlCheckStatement = class(TnxBaseSqlCheckStatement)
  protected {priavte}
    scsServerCursor   : TnxSqlAbstractCursor;

    scsRootNode       : TnxSqlBlock;
    scsTokens         : TTokenList;
    scsLocalContext   : TnxSqlContext;
    scsWideQuery      : WideString;
  protected
    function BlobsSupported: Boolean; override;
    function BlobAsVariant(aField   : TnxFieldDescriptor;
                           aBlobNr  : TnxBlobNr;
                           aOldValue: Boolean)
                                    : Variant; override;

    function Evaluate: Boolean; override;
  public
    constructor Create(aFieldsDescriptor : TnxFieldsDescriptor;
                       aFieldDescriptor  : TnxFieldDescriptor;
                       aCursor           : TnxAbstractCursor;
                 const aSqlText          : WideString); override;

    destructor Destroy; override;
  end;


implementation

uses
  nxllBde,
  nxllUtils,
  Variants,
  nxllException,
  nxllConvertException,
  nxllWideString,
  nxsdNativeVariantConverter,
  nxsrTimeoutHandling,
  nxsqlCondExp,
  nxsqlDataDef,
  nxsqlFunctionOrganizer,
  nxsqlFunctions;

resourcestring
  rsSyntaxErrorAtLine = 'Error de sintaxis en la línea %d posición %d: %s se esperaba: %s';
  rsInvalidTokenError = 'Símbolo no válido: error en la línea %d posición %d';
  rsInvalidTokenError1 = 'Símbolo no válido: error en la línea 1 posición 1';
  rsTheStatementSC = 'La declaración "%s" no se puede usar como una declaración de filtro SQL independiente';

{===TnxSqlStatement============================================================}
constructor TnxSqlStatement.Create(aSqlEngine : TnxSqlEngine;
                                   aDatabase  : TnxSqlAbstractDatabase;
                                   aTimeout   : TnxWord32);
begin
  sqsSqlEngine := aSqlEngine;
  inherited Create(aDatabase, aTimeout);
  sqsAddToSqlEngine;
end;
{------------------------------------------------------------------------------}
destructor TnxSqlStatement.Destroy;
begin
  try
    sqsRemoveFromSqlEngine;
    nxFreeAndNil(sqsRootNode);
    nxFreeAndNil(sqsTokens);
    nxFreeAndNil(sqsStoredProc);
    //nxFreeAndNil(sqsStoredProcParms);
    sqsStoredProcParms := nil;
    if sqsDatabaseProxy <> nil then
      sqsDatabaseProxy.Cleanup;
    ClearProxy(sqsDatabaseProxy);
    nxFreeAndNil(FLocals);
  finally
    inherited;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.AddLocal(Node: TnxSqlNode; UserData: TObject);
var
  i: Integer;
  L: TnxSqlParmDef;
begin
  if Node is TnxSqlDECLAREStatement then
    with TnxSqlDECLAREStatement(Node) do
      for i := 0 to LocalList.Count - 1 do begin
        L := Local[i];
        Self.FLocals.AddObject(L.NameStr, L);
      end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.EnsureLocalList;
begin
  if FLocals = nil then begin
    FLocals := TnxFastStringListIC.Create;
    FLocals.Sorted := True;
    if sqsRootNode <> nil then
      sqsRootNode.Traverse(AddLocal, nil, False);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.GetExceptionData(const aContainer: InxExceptionDataContainer; aIncludeChildren: Boolean = False);
var
  Count : Integer;
  i     : Integer;
  u     : Variant;
  pv    : PVariant;
begin
  inherited;
  if Assigned(sqsStoredProc) then begin
    aContainer.AddValue('StoredProc', sqsStoredProc.ProcNameStr);
    if Assigned(sqsStoredProcParms) then begin
      Count := nxMinI32(sqsStoredProcParms.GetCount, sqsStoredProc.ProcParmCount);
      if Count > 0 then
        with aContainer.AddContainer('Params') do
          for i := 0 to Pred(Count) do
            AddValue(sqsStoredProc.Parm[i].NameStr, sqsStoredProcParms.GetValue(i));
    end;
  end else begin
    aContainer.AddValue('Source', sqsSource);
    if Assigned(sqsRootNode) then begin
      Count := sqsRootNode.Parameters;
      if Count > 0 then
        with aContainer.AddContainer('Params') do begin
          u := Unassigned;
          for i := 0 to Pred(Count) do begin
            pv := sqsRootNode.ParameterPtr[i];
            if not Assigned(pv) then
              pv := @u;
            AddValue('Param['+IntToStr(i)+']', pv^);
          end;
        end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlStatement.ssExec(out aCursor   : TnxAbstractCursor;
                                    aOpenMode : TnxOpenMode;
                                    aStream   : TStream)
                                              : TnxResult;
var
  x: Integer;
  L, C, I: Integer;
  RowsAffected: Integer;
  RecordsRead: Integer;
  LiveResult: Boolean;
  S: string;
  AnsiStr : AnsiString;
  Context: TnxSqlContext;
  IndexID : Integer;
  aBookmark: PnxBookmarkBuffer;
  ExceptionHookInfo: PnxExceptionHookInfo;
  CursorID: TnxCursorID;
begin
  nxsqlNoProcessingCounter := 0;

  ExceptionHookInfo := nxGetExceptionHookInfo;
  aBookMark := nil;
  if Assigned(ExceptionHookInfo) then
    ExceptionHookInfo.ehiQuery := sqsSource;
  try
    if sqsSqlEngine.sqeStmtLogging then
      aBookmark:=sqsSqlEngine.LogStart(self);

    Result := Self.NotifyExtenders(eaStatementExec, True, [@aCursor, Integer(aOpenMode), aStream]);

    if Result = DBIERR_NONE then begin
      Context := nil;
      try
        nxLockTimeout;
        try
          if OptionGetEffective('PRIORITY_REDUCTION_TIMEOUT', s) <> DBIERR_NONE then
            s := '0';
          nxBeginPriorityReduction(StrToIntDef(s, 0), THREAD_PRIORITY_LOWEST);
          try
            if assigned(sqsRootNode)
            or assigned(sqsStoredProc) then begin
              aCursor := nil;

              Assert(assigned(sqsDatabaseProxy));
              Assert(assigned(sqsDatabaseProxy.ServerDatabase));
              Assert(assigned(sqsDatabaseProxy.ServerDatabase.Session));

              Context := TnxSqlContext.Create(DatabaseProxy, Now, sqsDatabaseProxy.ServerDatabase.Session.ClientDefaultLocale);
              Context.ExecDirect:=asExecDirect;

              EnsureLocalList;
              Context.DefineLocals(FLocals);

              LiveResult := aOpenMode = omReadWrite;

              if assigned(sqsStoredProc) then
                try
                  sqsStoredProc.Unbind;
                  Result := sqsStoredProc.ExecuteBody(Context, sqsStoredProcParms,
                    LiveResult, aCursor, RowsAffected, RecordsRead)
                except
                  on E: Exception do begin
                    Self.sqsSqlEngine.lcLogs(['Store procedure that failed:' + #13#10 + sqsStoredProc.ProcNameStr], ConvertException(E, nil, self, Self.MinVersion));
                    raise;
                  end;
                end
              else begin
                try
                  //sqsRootNode.OwnerStatement := Self;
                  Result := sqsRootNode.Execute
                    (Context, LiveResult, aCursor, RowsAffected, RecordsRead);
                except
                  on E: Exception do begin
                    Self.sqsSqlEngine.lcLogs(['Query that failed:' + #13#10 + sqsSource], ConvertException(E, nil, self, Self.MinVersion));
                    raise;
                  end;
                end;
              end;

              {no result set cursor desired}
              if aOpenMode = omNone then
                nxFreeAndNil(aCursor);

              if (Result = DBIERR_NONE) and Assigned(aStream) then begin
                if Assigned(aCursor) then begin
                  aCursor.IsResultSet := True;
                  (aCursor as TnxSqlAbstractCursor).sbcSetToBegin;
                  {query}
                  CursorID := TnxCursorID(aCursor);  //cast is on purpose, code depends on cursor classes being allocated in the lower 4GB
                  aStream.Write(CursorID, SizeOf(TnxCursorID));
                  TnxSqlAbstractCursor(aCursor)._Dictionary.WriteToStream(
                    aStream, Database.Session.ClientVersion);
                  x := aStream.Position;

                  if not LiveResult then
                    if aCursor is TnxSqlAbstractCursor then
                      TnxSqlAbstractCursor(aCursor).sbcMarkReadonly;

                  aStream.Write(LiveResult, SizeOf(LiveResult));
                  if Database.Session.ClientVersion >= nxVersion20000 then begin
                    if (aCursor as TnxSqlAbstractCursor).sbcGetIndexID(IndexID) <> DBIERR_NONE then
                      IndexID := -1;
                    aStream.Write(IndexID, SizeOf(IndexID));
                  end;
                end else begin
                  {data manipulation}
                  CursorID := TnxCursorID(aCursor);  //cast is on purpose, code depends on cursor classes being allocated in the lower 4GB
                  aStream.Write(CursorID, SizeOf(TnxCursorID)); {zero}
                  x := aStream.Position;
                  aStream.Write(RowsAffected, SizeOf(RowsAffected));
                end;

                aStream.Write(RecordsRead, SizeOf(RecordsRead));
                if (sqsRootNode <> nil) and (sqsRootNode.LogList <> nil) then
                  C := sqsRootNode.LogList.Count
                else
                  C := 0;
                aStream.Write(C, SizeOf(C));
                if C > 0 then begin
                  for I := 0 to C - 1 do begin
                    AnsiStr := AnsiString(sqsRootNode.LogList[I]);
                    L := Length(AnsiStr);
                    aStream.Write(L, SizeOf(L));
                    if L > 0 then
                      aStream.Write(AnsiStr[1], L);
                  end;
                  sqsRootNode.LogList.Clear;
                end;

                aStream.Position := x;
              end;
            end else
              Result := DBIERR_NA;
          finally
            nxEndPriorityReduction;
          end;
        finally
          nxUnlockTimeout;
          Context.Free;
        end;
      except
        on E : Exception do begin
          Result := Self.asoConvertException(E);
          EnxBaseException.GetLastConvertedException(Result, s);
          if s = '' then
            s := E.Message;

          if (sqsRootNode <> nil) and (sqsRootNode.LogList <> nil) then
            s := s + nxeCustomInfo('SqlLog', sqsRootNode.LogList.CommaText);

          AnsiStr := AnsiString(s);

          L := Length(AnsiStr);

          if Assigned(aStream) then
          begin
            aStream.Position := 0;
            aStream.Size := 0;

            aStream.Write(L, SizeOf(L));
            if L > 0 then
              aStream.Write(AnsiStr[1], L);
          end
          else
            raise;
        end;
      end;


      if Result = DBIERR_NONE then
        Self.NotifyExtenders(eaStatementExec, False, [@aCursor, Integer(aOpenMode), aStream]);

      if sqsSqlEngine.sqeStmtLogging then
        sqsSqlEngine.LogEnd(aBookmark, self, Result, s);
    end;
  finally
    if Assigned(ExceptionHookInfo) then
      ExceptionHookInfo.ehiQuery := '';
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlStatement.ssGetParams(const aParams : TnxSqlParamList;
                                           aStream : TStream)
                                                   : TnxResult;
var
  I            : Integer;
  Value        : Variant;
begin
  Result := Self.NotifyExtenders(eaStatementGetParams, True, [@aParams, aStream]);
  if Result = DBIERR_NONE then begin
    Result := DBIERR_NONE;
    try
      if sqsStoredProc <> nil then begin
        for I := Low(aParams) to High(aParams) do
          with aParams[I] do begin
            if piParamType in [nxptInputOutput, nxptOutput, nxptResult] then begin
              Value := Unassigned;
              Value := sqsStoredProcParms.GetValue(i);
              VariantToNative(sqsStoredProc.Database.FormatSettings, piDataType, CP_UTF8, 0, 0, Value, piData);
            end;
          end;
      end else begin
        for I := Low(aParams) to High(aParams) do
          with aParams[I] do begin
            if piParamType in [nxptInputOutput, nxptOutput, nxptResult] then begin
              Value := sqsRootNode.GetParameter(I, piParamType);
              VariantToNative(sqsRootNode.Database.FormatSettings, piDataType, CP_UTF8, 0, 0, Value, piData);
            end;
          end;
      end;

      if Assigned(aStream) then
        With TnxWriter.Create(aStream) do try
          WriteInteger(Length(aParams));
          for I := Low(aParams) to High(aParams) do
            with aParams[I] do begin
              WriteInteger(Ord(piDataType));
              if piParamType in [nxptInputOutput, nxptOutput, nxptResult] then begin
                WriteInteger(Length(piData));
                if Length(piData) > 0 then begin
                  WriteListBegin;
                  Write(piData[Low(piData)], Length(piData));
                  WriteListEnd;
                end;
              end
              else
                WriteInteger(0);
            end;
        finally
          Free;
        end;
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaStatementGetParams, False, [@aParams, aStream]);
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlStatement.ssPrepare(aStatementType : TnxStatementType;
                             const aQueryText     : WideString;
                                   aStream        : TStream)
                                                  : TnxResult;
var
  L         : Integer;
  AnsiStr   : AnsiString;
  ExceptionHookInfo : PnxExceptionHookInfo;
  Context   : TnxSqlContext;
begin
  ExceptionHookInfo := nxGetExceptionHookInfo;
  if Assigned(ExceptionHookInfo) then
    ExceptionHookInfo.ehiQuery := aQueryText;
  try
  Result := Self.NotifyExtenders(eaStatementPrepare, True, [Integer(aStatementType), aQueryText, aStream]);
  if Result = DBIERR_NONE then begin
    Result := DBIERR_NONE;
    try
      nxLockTimeout;
      try
        sqsCreateDatabaseProxy;
        case aStatementType of
          stQuery: begin
            Assert(assigned(sqsDatabaseProxy));
            Assert(assigned(sqsDatabaseProxy.ServerDatabase));
            Assert(assigned(sqsDatabaseProxy.ServerDatabase.Session));

            Context := TnxSqlContext.Create(DatabaseProxy, Now, sqsDatabaseProxy.ServerDatabase.Session.ClientDefaultLocale);
            try
              sqsParseQuery(Context, aQueryText);
            finally
              Context.Free;
            end;
          end;
          stStoredProcedure:
            sqsLoadProcedure(aQueryText);
        end;
        if sqsRootNode<>nil then
        begin
          l:=0;
          while (l<sqsRootNode.StatementList.Count) and (TObject(sqsRootNode.StatementList[l]) is TnxSqlSetPasswords) do
          begin
            TnxSqlSetPasswords(sqsRootNode.StatementList[l]).ExecuteDirect(TnxSqlAbstractDatabase(asDatabase));
            inc(l);
          end;
        end;
        sqsBind;
      finally
        nxUnlockTimeout;
      end;
    except
      on E : Exception do begin
        Result := Self.asoConvertException(E);
        AnsiStr := AnsiString(E.Message);
        L := Length(AnsiStr);
        aStream.Write(L, SizeOf(L));
        if L > 0 then
          aStream.Write(AnsiStr[1], L);
      end;
    end;
    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaStatementPrepare, False, [Integer(aStatementType), aQueryText, aStream]);
  end;
  finally
    if Assigned(ExceptionHookInfo) then
      ExceptionHookInfo.ehiQuery := '';
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlStatement.ssSetParams(const aParams : TnxSqlParamList;
                                           aStream : TStream)
                                                   : TnxResult;
var
  I            : Integer;
  Value        : Variant;
begin
  Result := Self.NotifyExtenders(eaStatementSetParams, True, [@aParams, aStream]);
  if Result = DBIERR_NONE then begin
    Result := DBIERR_NONE;
    try
      if sqsStoredProc <> nil then begin
        for I := Low(aParams) to High(aParams) do
          with aParams[I] do begin
            Value := Null;

            if (piParamType in [nxptUnknown, nxptInput, nxptInputOutput]) and
              (Length(piData) > 0) then
                Value := VariantFromNative
                  (piDataType, CP_UTF8, 0, 0,
                    @piData[Low(piData)], Length(piData));

            sqsStoredProcParms.SetValue(i, Value, nil, piDataType
              {Params are 'locale neutral', just like string literals}, 0);
          end;
      end else begin
        for I := Low(aParams) to High(aParams) do
          with aParams[I] do begin
            if piParamName = '' then
              piParamName := ':' + IntToStr(Succ(i));

            Value := Null;

            if (piParamType in [nxptUnknown, nxptInput, nxptInputOutput]) and
              (Length(piData) > 0) then
                Value := VariantFromNative
                  (piDataType, CP_UTF8, 0, 0,
                    @piData[Low(piData)], Length(piData));

            sqsRootNode.SetParameter(I, Value, piParamType, nil, piDataType
              {Params are 'locale neutral', just like string literals});
          end;
      end;
      // notify all root nodes that the parameters have changed
      if sqsRootNode<>nil then
        sqsRootNode.Traverse(InvalidateParamDependentResults, nil, true);
    except
      on E : Exception do
        Result := Self.asoConvertException(E);
    end;
    if Result = DBIERR_NONE then
      Self.NotifyExtenders(eaStatementSetParams, False, [@aParams, aStream]);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsAddToSqlEngine;
begin
  sqsSqlEngine.sqeStatementsPadlock.Lock;
  try
    sqsSqlEnginePrev := sqsSqlEngine.sqeStatementsTail;
    sqsSqlEngine.sqeStatementsTail := Self;
    if Assigned(sqsSqlEnginePrev) then
      sqsSqlEnginePrev.sqsSqlEngineNext:=Self;
    if not Assigned(sqsSqlEngine.sqeStatementsHead) then
      sqsSqlEngine.sqeStatementsHead := Self;
  finally
    sqsSqlEngine.sqeStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsBind;
begin
  if (sqsRootNode <> nil) then begin

    Assert(assigned(sqsDatabaseProxy));
    Assert(assigned(sqsDatabaseProxy.ServerDatabase));
    Assert(assigned(sqsDatabaseProxy.ServerDatabase.Session));

    sqsRootNode.BindDatabase(sqsDatabaseProxy, sqsDatabaseProxy.ServerDatabase.Session.ClientDefaultLocale);
  end else if (sqsStoredProc <> nil) then
    sqsStoredProc.Database := sqsDatabaseProxy;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsCreateDatabaseProxy;
begin
  if not Assigned(sqsDatabaseProxy) then
  begin
    sqsDatabaseProxy := DatabaseProxyFromDatabase
      (TnxSqlAbstractDatabase(asDatabase), sqsSqlEngine.LCID, sqsSqlEngine.DictionaryMode);
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsLoadProcedure(const aStoredProc: WideString);
begin
  if not Assigned(sqsDatabaseProxy) then
    sqsDatabaseProxy := //DatabaseProxyFromDatabase(TnxSqlAbstractDatabase(asDatabase));
    DatabaseProxyFromDatabase
      (TnxSqlAbstractDatabase(asDatabase), sqsSqlEngine.LCID, sqsSqlEngine.DictionaryMode);

  nxFreeAndNil(sqsRootNode);
  nxFreeAndNil(sqsTokens);

  nxFreeAndNil(sqsStoredProc);
  nxIntfNil(sqsStoredProcParms);

  sqsStoredProc := TnxDatabaseResolverHub(sqsDatabaseProxy.PsmDictionary.FunctionResolver).
    LoadProcedure(sqsDatabaseProxy, aStoredProc, nil) as TnxSqlCREATEPROC;
  sqsStoredProcParms := CreateTypedVariantList(sqsStoredProc.ProcParmCount);
end;

{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsParseQuery(Context: TnxSqlContext; const aQuery: WideString);
var
  extoken: UnicodeString;
begin
  sqsWideQuery := aQuery;

  nxFreeAndNil(sqsRootNode);
  nxFreeAndNil(sqsTokens);

  nxFreeAndNil(sqsStoredProc);

  with TnxSqlTokenizer.Create do try
    if Tokenize(PWideChar(sqsWideQuery), Length(sqsWideQuery), False, False, sqsTokens) then
      with TnxSqlParser.Create(sqsTokens) do try
        //DumpTokens(sqsTokens);
        if Parse then begin
          Source := aQuery;
          Compile;
          sqsRootNode := RootNode;
          sqsSource := aQuery;
          sqsRootNode.OwnerStatement := Self;
          while sqsRootNode.Simplify(Context) do;
        end else begin
          if pos('SUBSTRING', ExpectedTokensString)>0 then
            extoken:='<builtin_function>, <stored_function>, '+ExpectedTokensString
          else
            extoken:=ExpectedTokensString;

          raise EnxInternalSQLException.CreateResFmt(@rsSyntaxErrorAtLine, [
            sqsTokens.TokenStartLine[FailedTokenIndex],
            sqsTokens.TokenStartPos[FailedTokenIndex],
            extoken,
            sqsTokens.TokenStr(FailedTokenIndex)
            ]);
        end;
      finally
        Free;
      end
    else with sqsTokens do
      if TokenCount > 0 then
        raise EnxInternalSQLException.CreateResFmt(@rsInvalidTokenError, [
          TokenEndLine[TokenCount - 1],
          TokenEndPos[TokenCount - 1]])
      else
        raise EnxInternalSQLException.CreateRes(@rsInvalidTokenError1);
  finally
    Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.sqsRemoveFromSqlEngine;
begin
  sqsSqlEngine.sqeStatementsPadlock.Lock;
  try
    if Assigned(sqsSqlEngineNext) then
      sqsSqlEngineNext.sqsSqlEnginePrev := sqsSqlEnginePrev
    else
      if sqsSqlEngine.sqeStatementsTail = Self then
        sqsSqlEngine.sqeStatementsTail := sqsSqlEnginePrev;

    if Assigned(sqsSqlEnginePrev) then
      sqsSqlEnginePrev.sqsSqlEngineNext := sqsSqlEngineNext
    else
      if sqsSqlEngine.sqeStatementsHead = Self then
        sqsSqlEngine.sqeStatementsHead := sqsSqlEngineNext;

    sqsSqlEngineNext := nil;
    sqsSqlEnginePrev := nil;
  finally
    sqsSqlEngine.sqeStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.InvalidateParamDependentResults(Node: TnxSqlNode;
  UserData: TObject);
begin
  // notify all root nodes that the parameters have changed
  if Node is TnxSqlRootNode then
    if TnxSqlRootNode(Node).Parameters>0 then
      TnxSqlRootNode(Node).ParametersChanged;
end;
{------------------------------------------------------------------------------}
procedure TnxSqlStatement.PrepareDestroy;
begin
  inherited;
  if Assigned(sqsRootNode) then
    sqsRootNode.PrepareDestroy;
  if Assigned(sqsStoredProc) then
    sqsStoredProc.PrepareDestroy;
 // oops - doesn't work
 // if sqsDatabaseProxy <> nil then
 //   sqsDatabaseProxy.PrepareDestroy;
end;

{==============================================================================}



{===TnxSqlEngine===============================================================}
constructor TnxSqlEngine.Create(AOwner: TComponent);
begin
  sqeStatementsPadlock := TnxPadlock.Create;
  sqeStmtLogTableName:='QueryLog';
  DisplayCategory:='SQL Engine';
  sqeStmtLogging:=false;
  FLCID := LOCALE_SYSTEM_DEFAULT;
  inherited;
end;
{------------------------------------------------------------------------------}
destructor TnxSqlEngine.Destroy;
begin
  inherited;
  nxFreeAndNil(sqeStatementsPadlock);
end;
procedure TnxSqlEngine.GetConfigSettings(aSettings: TnxBaseSettings);
begin
  inherited;
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='StmtLogTableName';
    _Label:='Statement Log Table Name';
    DefaultValue:='';
    SettingType:=nxstString;
    PropertyName:='StmtLogTableName';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='StmtLogPathName';
    _Label:='Statement Log Path Name';
    DefaultValue:='';
    SettingType:=nxstString;
    PropertyName:='StmtLogPathName';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='StmtLogging';
    _Label:='Statement Logging';
    DefaultValue:='';
    SettingType:=nxstBoolean;
    PropertyName:='StmtLogging';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='UseFieldCache';
    DefaultValue:='';
    SettingType:=nxstBoolean;
    PropertyName:='UseFieldCache';
  end;    // with
  with aSettings.AddSetting(TnxBaseSetting.Create) do begin
    Name:='SQLScriptFolder';
    DefaultValue:='';
    SettingType:=nxstString;
    PropertyName:='SQLScriptFolder';
    _Label := 'SQL Script Folder';
  end;    // with
end;

{------------------------------------------------------------------------------}
procedure TnxSqlEngine.LoadConfig(aConfig: TnxBaseComponentConfiguration);
begin
  inherited;
  sqeStmtLogTableName:=aConfig.GetValue('StmtLogTableName', sqeStmtLogTableName);
  sqeStmtLogPathName:=aConfig.GetValue('StmtLogPathName', sqeStmtLogPathName);
  if sqeStmtLogPathName <> '' then try
    ForceDirectories(sqeStmtLogPathName);
  except
  end;
  sqeStmtLogging:=aConfig.GetValue('StmtLogging', sqeStmtLogging);
  UseFieldCache:=aConfig.GetValue('UseFieldCache', sqeGetUseFieldCache);
  sqeSQLScriptFolder:=aConfig.GetValue('SQLScriptFolder', 'SQLScripts');
end;

procedure TnxSqlEngine.LoadSettingsFromStream(aReader: TnxReader);
var
  Version: Integer;
begin
  inherited;
  with aReader do begin
    Version:=ReadInteger; // version
    if Version <> 1 then
      raise EnxComponentException.nxCreate(DBIERR_NX_INCOMPATSTREAM);

    StmtLogTableName := ReadWideString;
    StmtLogPathName := ReadWideString;
    StmtLogging := ReadBoolean;
    UseFieldCache := ReadBoolean;
    SQLScriptFolder := ReadWideString;
  end;
end;

function TnxSqlEngine.LoadTriggersForTable(aDatabase: TnxSqlDatabaseProxy; const aTableName: string;
  var TriggerList: TnxList): Boolean;
var
  TriggerNameList: TnxFastStringListIC;
  i: Integer;
  {TargetTableName, Description, Source: string;}
  S: TStream;
  PSMReader: TnxSqlPSMReader;
  Trigger: TnxSqlCREATETRIGGER;
begin
  Result := False;
  //!!! Thorsten: This string should probably be a constant somewhere
  if copy(trim(aTableName), 1, length('UnnamedTable')) = 'UnnamedTable' then
    exit;
  TriggerList := nil;
  aDatabase.PsmDictionary.Lock;
  try
    TriggerNameList := aDatabase.PsmDictionary.TriggerListByTarget(aTableName);
    try
      for i := 0 to TriggerNameList.Count - 1 do begin
        S := aDatabase.PsmDictionary.TriggerLoadBegin(TriggerNameList[i]);
        PSMReader := TnxSqlPSMReader.Create(S);
        try
          Trigger := PSMReader.ReadNode(nil) as TnxSqlCREATETRIGGER;
          if TriggerList = nil then
            TriggerList := TnxList.Create;
          TriggerList.Add(Trigger);
          Result := True;
        finally
          PSMReader.Free;
          aDatabase.PsmDictionary.TriggerLoadEnd(S);
        end;
      end;
    finally
      TriggerNameList.Free;
    end;
  finally
    aDatabase.PsmDictionary.Unlock;
  end;
end;

function TnxSqlEngine.LogStart(aStatement: TnxSQLStatement): PnxBookmarkBuffer;
var
  lTableExists: Boolean;
  aDict: TnxDataDictionary;
  aCursor: TnxAbstractCursor;

begin
  sqeStatementsPadlock.Lock;
  try
    result:=nil;
    if sqeStmtLogSession=nil then
    begin
      aStatement.sqsDatabaseProxy.ServerDatabase.Session.ServerEngine.SessionOpenEx(
        sqeStmtLogSession, aStatement.sqsDatabaseProxy.ServerDatabase.Session.UserName,
        aStatement.sqsDatabaseProxy.ServerDatabase.Session.Password, '', 10000, nxVersionNumber);
      nxFreeAndNil(sqeStmtLogTable);
      nxFreeAndNil(sqeStmtLogDatabase);
    end;
    if sqeStmtLogDatabase=nil then
    begin
      nxFreeAndNil(sqeStmtLogTable);
      if sqeStmtLogSession.DatabaseOpen(sqeStmtLogDatabase, nxatAliasPath, sqeStmtLogPathName, nil, omReadWrite, smShared, 10000)<>DBIERR_NONE then
        exit;
      sqeStmtLogDatabase.TableExists(sqeStmtLogTableName, '', lTableExists, True);
      if not lTableExists then
      begin
        aDict:=TnxDataDictionary.Create;
        try
          with aDict.FieldsDescriptor do begin
            AddField('LogID', '', nxtAutoInc, 10, 0, true);
            AddField('Finished', '', nxtBoolean, 0, 0, true);
            AddField('StartTime', '', nxtDateTime, 0, 0, true);
            AddField('EndTime', '', nxtDateTime, 0, 0, false);
            AddField('AliasName', '', nxtWideString, 100, 0, true);
            AddField('UserName', '', nxtWideString, 100, 0, false);
            AddField('Timeout', '', nxtWord32, 10, 0, false);
            AddField('ErrorCode', '', nxtInt32, 0, 0, false);
            AddField('ErrorString', '', nxtBlobMemo, 0, 0, false);
            AddField('Query', '', nxtBlobMemo, 0, 0, false);
          end;
          if sqeStmtLogDatabase.TableBuild(False, sqeStmtLogTableName, '', aDict, tsPersistent, True) <> DBIERR_NONE then
            exit;
        finally
          aDict.free;
        end;
      end;
    end;

    if sqeStmtLogTable=nil then
    begin
      if sqeStmtLogDatabase.CursorOpen(aCursor, nil, sqeStmtLogTableName, '', omReadWrite, smShared, 10000, '', -1, True)<>DBIERR_NONE then
        exit;
      sqeStmtLogTable:=TnxsdCursorWrapper.Create(aCursor);
      sqeStmtBookmarkSize:=sqeStmtLogTable.Cursor._Dictionary.BookmarkSize[0];
    end;

    if (sqeStmtLogTable=nil) then
      exit;

    sqeStmtLogTable.Insert;
    try
      sqeStmtLogTable.SetFieldByName('AliasName', aStatement.sqsDatabaseProxy.ServerDatabase.Alias);
      sqeStmtLogTable.SetFieldByName('UserName', aStatement.sqsDatabaseProxy.ServerDatabase.Session.UserName);
      sqeStmtLogTable.SetFieldByName('Finished', false);
      sqeStmtLogTable.SetFieldByName('StartTime', now);
      sqeStmtLogTable.SetFieldByName('Timeout', nxGetRemainingTime);
      sqeStmtLogTable.SetBlobValue('Query', aStatement.sqsSource);
      sqeStmtLogTable.Post;
      result:=nxGetMem(sqeStmtBookmarkSize);
      sqeStmtLogTable.Cursor.GetBookmark(result, sqeStmtBookmarkSize);
    except
      sqeStmtLogTable.Cancel;
    end;
  finally
    sqeStatementsPadlock.Unlock
  end;
end;

procedure TnxSqlEngine.PrepareShutdown;
begin
  nxFreeAndNil(sqeStmtLogTable);
  nxFreeAndNil(sqeStmtLogDatabase);
  nxFreeAndNil(sqeStmtLogSession);
end;

procedure TnxSqlEngine.SaveConfig(aConfig: TnxBaseComponentConfiguration);
begin
  inherited;
  aConfig.SetValue('StmtLogTableName', sqeStmtLogTableName);
  aConfig.SetValue('StmtLogPathName', sqeStmtLogPathName);
  aConfig.SetValue('StmtLogging', sqeStmtLogging);
  aConfig.SetValue('UseFieldCache', sqeGetUseFieldCache);
  aConfig.SetValue('SQLScriptFolder', sqeSQLScriptFolder);
end;

procedure TnxSqlEngine.SaveSettingsToStream(aWriter: TnxWriter);
begin
  inherited;

  with aWriter do begin
    WriteInteger(1); //version
    WriteWideString(sqeStmtLogTableName);
    WriteWideString(sqeStmtLogPathName);
    WriteBoolean(sqeStmtLogging);
    WriteBoolean(sqeGetUseFieldCache);
    WriteWideString(SQLScriptFolder);
  end;
end;

procedure TnxSqlEngine.LogEnd(aBookmark: PnxBookmarkBuffer; aStatement: TnxSqlStatement; Errorcode: integer; const ErrorString: String);
begin
  sqeStatementsPadlock.Lock;
  try
    if (sqeStmtLogTable=nil) then
      exit;

    if sqeStmtLogTable.Cursor.SetToBookmark(aBookmark, sqeStmtBookmarkSize)<>DBIERR_NONE then
      exit;

    sqeStmtLogTable.Edit;
    try
      sqeStmtLogTable.SetFieldByName('Finished', true);
      sqeStmtLogTable.SetFieldByName('EndTime', now);
      sqeStmtLogTable.SetFieldByName('ErrorCode', Errorcode);
      sqeStmtLogTable.SetBlobValue('ErrorString', ErrorString);
      sqeStmtLogTable.Post;
    except
      sqeStmtLogTable.Cancel;
    end;
  finally
    if (aBookmark<>nil) then
      nxFreeMem(aBookmark);
    sqeStatementsPadlock.Unlock
  end;
end;

procedure TnxSqlEngine.scStopping;
begin
  nxFreeAndNil(sqeStmtLogTable);
  nxFreeAndNil(sqeStmtLogDatabase);
  nxFreeAndNil(sqeStmtLogSession);
  inherited;
  sqeStatementsPadlock.Lock;
  try
    while Assigned(sqeStatementsHead) do
      sqeStatementsHead.Free;
  finally
    sqeStatementsPadlock.Unlock;
  end;
end;
{------------------------------------------------------------------------------}
function TnxSqlEngine.sqeGetUseFieldCache: Boolean;
begin
  // result:=nxsqlProxies.UseFieldCache;
  result:=false;
end;

procedure TnxSqlEngine.sqeSetDictionaryMode(const Value: TnxSqlPSMDictionaryMode);
begin
  scCheckInactive;
  sqeDictionaryMode := Value;
end;

procedure TnxSqlEngine.sqeSetUseFieldCache(const Value: Boolean);
begin
//  nxsqlProxies.UseFieldCache:=value;
// never use field cache!
end;

{------------------------------------------------------------------------------}
function TnxSqlEngine.StatementAlloc(aDatabase  : TnxAbstractDatabase;
                                 out aStatement : TnxAbstractStatement;
                                     aTimeout   : TnxWord32): TnxResult;
begin
  aStatement := TnxSqlStatement.Create
    (Self, aDatabase as TnxSqlAbstractDatabase, aTimeout);
  Result := DBIERR_NONE;
end;
{==============================================================================}



{===TnxSqlFilterStatement======================================================}
constructor TnxSqlFilterStatement.Create(aFieldsSource : InxFieldsSource;
                                   const aSqlText      : WideString);
var
  Tokens    : TTokenList;
  lLCID     : Integer;
  lMode     : TnxSqlPSMDictionaryMode;
  DefLocale : TnxLocaleDescriptor;
  extoken   : UnicodeString;
begin
  inherited;

  sfsAbstractCursor := aFieldsSource.GetCursor as TnxAbstractCursor;

  sfsWideQuery := 'SELECT * FROM x WHERE ' + aSqlText + ';';

  with TnxSqlTokenizer.Create do try
    Tokens := nil;
    try
      if Tokenize(PWideChar(sfsWideQuery), Length(sfsWideQuery), False, False, Tokens) then begin
        with TnxSqlParser.Create(Tokens) do try
          if Parse then begin
            Compile;
            sfsRootNode := RootNode;
            sfsTokens := Tokens;
            Tokens := nil;
          end else begin
            if pos('SUBSTRING', ExpectedTokensString)>0 then
              extoken:='<builtin_function>, <stored_function>, '+ExpectedTokensString
            else
              extoken:=ExpectedTokensString;

            raise EnxInternalSQLException.CreateResFmt(@rsSyntaxErrorAtLine, [
              Tokens.TokenStartLine[FailedTokenIndex],
              Tokens.TokenStartPos[FailedTokenIndex],
              extoken,
              Tokens.TokenStr(FailedTokenIndex)
              ]);
          end;
        finally
          Free;
        end;
      end else
        if Tokens.TokenCount > 0 then
          raise EnxInternalSQLException.CreateResFmt(@rsInvalidTokenError, [
            Tokens.TokenEndLine[Tokens.TokenCount - 1],
            Tokens.TokenEndPos[Tokens.TokenCount - 1]])
        else
          raise EnxInternalSQLException.CreateRes(@rsInvalidTokenError1);
    finally
      nxFreeAndNil(Tokens);
    end;
  finally
    Free;
  end;

  Assert(Assigned(sfsRootNode));

  if Assigned(sfsAbstractCursor) and
    (sfsAbstractCursor.Database is TnxSqlAbstractDatabase) then begin

    lLCID := 0;
    lMode := dmPersistant;
    with sfsAbstractCursor.Database.Session do
      if ServerEngine is TnxServerEngine then
        with TnxServerEngine(ServerEngine) do
          if SqlEngine is TnxSqlEngine then
            with TnxSqlEngine(SqlEngine) do begin
              lLCID := LCID;
              lMode := DictionaryMode;
            end;

    sfsRootNode.Database :=
      DatabaseProxyFromDatabase(TnxSqlAbstractDatabase(sfsAbstractCursor.Database), lLCID, lMode);
  end;

  if assigned(sfsRootNode.Database) then begin
    Assert(assigned(sfsRootNode.Database.ServerDatabase));
    Assert(assigned(sfsRootNode.Database.ServerDatabase.Session));
    DefLocale := sfsRootNode.Database.ServerDatabase.Session.ClientDefaultLocale;
  end else
    DefLocale := nil;

  sfsLocalContext := TnxSqlContext.Create(sfsRootNode.Database, Now, DefLocale);

  sfsLocalContext.ExternalColumnResolver := GetExtColumnDef;
  sfsLocalContext.ExternalColumnGetter := GetExtColumnValue;
  sfsLocalContext.IsSQLFilter := True;

  if not sfsRootNode.WhereIsValidFilterStatement then
    raise EnxInternalSQLException.CreateResFmt(@rsTheStatementSC, [aSqlText]);

  sfsRootNode.BindWhere(sfsLocalContext);

end;
{------------------------------------------------------------------------------}
destructor TnxSqlFilterStatement.Destroy;
var
  aDB: TObject;
begin
  if sfsRootNode<>nil then
    aDB:=sfsRootNode.Database
  else
    aDB:=nil;
  nxFreeAndNil(sfsRootNode);
  nxFreeAndNil(sfsTokens);
  nxFreeAndNil(sfsLocalContext);
  ClearProxy(TnxSQLDatabaseProxy(aDB));
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSqlFilterStatement.Evaluate: Boolean;
begin
  Result := sfsRootNode.EvaluateWhere(sfsLocalContext) = tsbTrue;
end;
{==============================================================================}



{===TnxSqlCheckStatement======================================================}
function TnxSqlCheckStatement.BlobAsVariant(aField   : TnxFieldDescriptor;
                                            aBlobNr  : TnxBlobNr;
                                            aOldValue: Boolean)
                                                     : Variant;
var
  Error         : TnxResult;
  Len           : TnxWord32;
  VPtr          : PByte;
  ws            : WideString;
  Stream        : TnxAnsiStringStream;
begin
  Error := DBIERR_NONE;

  with aField do
    if Assigned(scsServerCursor) then begin
      Error := scsServerCursor.sbcBlobGetLength(ridNull, Number, aBlobNr, Len, aOldValue, nil);
      if Error = DBIERR_NONE then
        if Len = 0 then
          Result := null
        else begin
          if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
            if fdType = nxtBlobWideMemo then begin
              SetLength(ws, Len div 2);
              with TnxStaticMemoryStream.Create(@ws[1], Len) do try
                Error := scsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
              finally
                Free;
              end;
            end else begin
              Stream := TnxAnsiStringStream.Create(StringOfChar(AnsiChar(#0), Len));
              try
                Stream.Position := 0;
                Error := scsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, Stream, False, nil);
                if Error = DBIERR_NONE then
                  ws := nxStringToDelphiWideString(Stream.DataString, UsedStorageCodePage);
              finally
                Free;
              end;
            end;
            Result := ws;
          end else begin
            Result := VarArrayCreate([0, Pred(Len)], VarByte);
            VPtr := VarArrayLock(Result);
            try
              with TnxStaticMemoryStream.Create(VPtr, Len) do try
                Error := scsServerCursor.sbcBlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, aOldValue, nil);
              finally
                Free;
              end;
            finally
              VarArrayUnlock(Result);
            end;
          end;
        end;
    end else if Assigned(bscsCursor) then begin
      Error := bscsCursor.BlobGetLength(ridNull, Number, aBlobNr, Len, aOldValue, nil);
      if Error = DBIERR_NONE then
        if Len = 0 then
          Result := null
        else begin
          if fdType in [nxtBlobMemo, nxtBlobWideMemo] then begin
            if fdType = nxtBlobWideMemo then begin
              SetLength(ws, Len div 2);
              with TnxStaticMemoryStream.Create(@ws[1], Len) do try
                Error := bscsCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, False, nil);
              finally
                Free;
              end;
            end else begin
              Stream := TnxAnsiStringStream.Create(StringOfChar(AnsiChar(#0), Len));
              try
                Stream.Position := 0;
                Error := bscsCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, Stream, False, nil);
                if Error = DBIERR_NONE then
                  ws := nxStringToDelphiWideString(Stream.DataString, UsedStorageCodePage);
              finally
                Free;
              end;
            end;
            Result := ws;
          end else begin
            Result := VarArrayCreate([0, Pred(Len)], VarByte);
            VPtr := VarArrayLock(Result);
            try
              with TnxStaticMemoryStream.Create(VPtr, Len) do try
                Error := bscsCursor.BlobRead(ridNull, Number, aBlobNr, 0, Len, TheStream, aOldValue, nil);
              finally
                Free;
              end;
            finally
              VarArrayUnlock(Result);
            end;
          end;
        end;
    end else
      Result := Null;

  if Error <> DBIERR_NONE then
    raise EnxsqlCheckStatementException.nxCreate(Error);
end;
{------------------------------------------------------------------------------}
function TnxSqlCheckStatement.BlobsSupported: Boolean;
begin
  Result := Assigned(bscsCursor);
end;
{------------------------------------------------------------------------------}
constructor TnxSqlCheckStatement.Create(aFieldsDescriptor : TnxFieldsDescriptor;
                                        aFieldDescriptor  : TnxFieldDescriptor;
                                        aCursor           : TnxAbstractCursor;
                                  const aSqlText          : WideString);
var
  Tokens    : TTokenList;
  lLCID     : Integer;
  lMode     : TnxSqlPSMDictionaryMode;
  extoken   : UnicodeString;
begin
  inherited;

  if bscsCursor is TnxSqlAbstractCursor then
    scsServerCursor := TnxSqlAbstractCursor(bscsCursor);

  scsWideQuery := 'SELECT * FROM x WHERE ' + aSqlText + ';';

  with TnxSqlTokenizer.Create do try
    Tokens := nil;
    try
      if Tokenize(PWideChar(scsWideQuery), Length(scsWideQuery), False, False, Tokens) then begin
        with TnxSqlParser.Create(Tokens) do try
          if Parse then begin
            Compile;
            scsRootNode := RootNode;
            scsTokens := Tokens;
            Tokens := nil;
          end else begin
            if pos('SUBSTRING', ExpectedTokensString)>0 then
              extoken:='<builtin_function>, <stored_function>, '+ExpectedTokensString
            else
              extoken:=ExpectedTokensString;

            raise EnxInternalSQLException.CreateResFmt(@rsSyntaxErrorAtLine, [
              Tokens.TokenStartLine[FailedTokenIndex],
              Tokens.TokenStartPos[FailedTokenIndex],
              extoken,
              Tokens.TokenStr(FailedTokenIndex)
              ]);
          end;
        finally
          Free;
        end;
      end else
        if Tokens.TokenCount > 0 then
          raise EnxInternalSQLException.CreateResFmt(@rsInvalidTokenError, [
            Tokens.TokenEndLine[Tokens.TokenCount - 1],
            Tokens.TokenEndPos[Tokens.TokenCount - 1]])
        else
          raise EnxInternalSQLException.CreateRes(@rsInvalidTokenError1);
    finally
      nxFreeAndNil(Tokens);
    end;
  finally
    Free;
  end;

  Assert(Assigned(scsRootNode));

  if Assigned(bscsCursor) and
    (bscsCursor.Database is TnxSqlAbstractDatabase) then begin

    lLCID := 0;
    lMode := dmPersistant;

    with bscsCursor.Database.Session do
      if ServerEngine is TnxServerEngine then
        with TnxServerEngine(ServerEngine) do
          if SqlEngine is TnxSqlEngine then
            with TnxSqlEngine(SqlEngine) do begin
              lLCID := LCID;
              lMode := DictionaryMode;
            end;

    scsRootNode.Database :=
      DatabaseProxyFromDatabase(TnxSqlAbstractDatabase(bscsCursor.Database), lLCID, lMode);
  end;

  Assert(assigned(scsRootNode.Database));
  Assert(assigned(scsRootNode.Database.ServerDatabase));
  Assert(assigned(scsRootNode.Database.ServerDatabase.Session));

  scsLocalContext := TnxSqlContext.Create(scsRootNode.Database, Now, scsRootNode.Database.ServerDatabase.Session.ClientDefaultLocale);
  scsLocalContext.ExternalColumnResolver := GetExtColumnDef;
  scsLocalContext.ExternalColumnGetter := GetExtColumnValue;
end;
{------------------------------------------------------------------------------}
destructor TnxSqlCheckStatement.Destroy;
var
  aDB: TObject;
begin
  aDB:=scsRootNode.Database;
  nxFreeAndNil(scsRootNode);
  nxFreeAndNil(scsTokens);
  nxFreeAndNil(scsLocalContext);
  ClearProxy(TnxSQLDatabaseProxy(aDB));
  inherited;
end;
{------------------------------------------------------------------------------}
function TnxSqlCheckStatement.Evaluate: Boolean;
begin
  if Assigned(bscsOldRecord) then
    scsLocalContext.TriggerAction := taUpdating
  else
    scsLocalContext.TriggerAction := taInserting;
  Result := scsRootNode.EvaluateWhere(scsLocalContext) <> tsbFalse;
end;
{==============================================================================}

initialization
  {$IFDEF NX_PUBLICBETA}
  {$I PublicBeta\nxPublicBeta1.inc}
  {$ENDIF}
  if SqlFilterStatementClass = nil then
    SqlFilterStatementClass := TnxSqlFilterStatement;
  if SqlCheckStatementClass = nil then
    SqlCheckStatementClass := TnxSqlCheckStatement;
  TnxSqlEngine.rcRegister;
finalization
  TnxSqlEngine.rcUnregister;
  if SqlCheckStatementClass = TnxSqlCheckStatement then
    SqlCheckStatementClass := nil;
  if SqlFilterStatementClass = TnxSqlFilterStatement then
    SqlFilterStatementClass := nil;
end.

