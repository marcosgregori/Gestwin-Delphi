{##############################################################################}
{# NexusDB Enterprise Manager: fmQueryBrowser.pas 4.7001                     #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Query Dialog                                   #}
{##############################################################################}

{$I nxemDefine.inc}

unit fmQueryBrowser;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  UITypes,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Grids,
  DBGrids,
  Mask,
  ActnList,
  ComCtrls,
  Contnrs,
  ExtCtrls,
  ToolWin,
  ImgList,
  Buttons,
  Menus,
  DBCtrls,
  Db,

  cxStyles,
  cxCustomData,
  cxGraphics,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxControls,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxBar,
  dxStatusBar,
  dxBarDBNav,
  cxNavigator,
  cxDBNavigator,
  cxSplitter,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  cxCalendar,
  cxTextEdit,
  cxDBLookupComboBox,
  cxLookAndFeels,
  cxLookAndFeelPainters,

  SynEdit,
  SynMemo,

  unFormList,
  nxllComponent,
  nxllTransport,
  nxllThread,
  nxdbBase,
  nxdb,
  unSqlWindowConfig,
  dgSQLParameters,
  unTreeNodeObject,
  fmBaseBrowser,
  SynEditSearch,
  SynEditMiscClasses,
  SynEditRegexSearch,
  SynEditHighlighter,
  Vcl.ExtDlgs,
  Vcl.StdActns,
  System.Actions,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  dxBarBuiltInMenu,
  SynEditOptionsDialog,
  dxDateRanges, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinOffice2019Colorful,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxButtons, cxContainer, cxMemo,
  cxPC, cxCheckBox, cxMaskEdit, cxImage, cxLabel, dxScrollbarAnnotations,
  SynHighlighterSQL,
  SynHighlighterNexusDBSQL, dxSkinBasic, dxSkinOffice2019Black,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, System.ImageList,
  cxImageList;

const
  WM_QueryTeardown     = WM_USER + 1;

type
  TnxSQLConnection = class;

  TnxQueryWorkerThread = class(TnxInitThread)
  protected
    qwtRunTime          : Cardinal;
    qwtAfterExecute     : TNotifyEvent;
    qwtSQLConnection    : TnxSQLConnection;
    qwtLowPriorityAfter : Integer;
    procedure InnerExecute; override;
  public
    constructor Create(aThreadPriority   : TThreadPriority;
                       aSQLConnection    : TnxSQLConnection;
                       aOnTerminate      : TNotifyEvent);
  end;

  TnxQueryExecutionResult = (qerCancelledQuerySetup,
                             qerCancelledRunningQuery,
                             qerRanSuccessfully,
                             qerErrorRaised);

  TfrmQueryBrowser = class(TfrmBaseBrowser)
    StatusBar: TdxStatusBar;
    paTop: TPanel;
    splQueryAndGrid: TcxSplitter;
    splQueryAndLog: TcxSplitter;
    taSqlHistoryBrowse: TnxTable;
    taSqlHistoryBrowseID: TUnsignedAutoIncField;
    taSqlHistoryBrowseRunAt: TDateTimeField;
    taSqlHistoryBrowseServerName: TWideStringField;
    taSqlHistoryBrowseDatabaseName: TWideStringField;
    taSqlHistoryBrowseSQL: TWideMemoField;
    taSqlHistoryBrowseSessionID: TGuidField;
    taSqlHistoryBrowseQueryLog: TWideMemoField;
    taSqlHistoryBrowseErrorMessage: TWideMemoField;
    taSqlHistoryBrowseRunTime: TLongWordField;
    taSqlHistoryBrowseRunTimeAsString: TWideStringField;
    SQLEditor: TSynMemo;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynEditSearch: TSynEditSearch;
    SynSQLSynLight: TSynSQLSyn;
    taSqlHistoryPost: TnxTable;
    taSqlHistoryPostID: TUnsignedAutoIncField;
    taSqlHistoryPostRunAt: TDateTimeField;
    taSqlHistoryPostServerName: TWideStringField;
    taSqlHistoryPostDatabaseName: TWideStringField;
    taSqlHistoryPostSQL: TWideMemoField;
    taSqlHistoryPostQueryLog: TWideMemoField;
    taSqlHistoryPostErrorMessage: TWideMemoField;
    taSqlHistoryPostSessionID: TGuidField;
    taSqlHistoryPostRunTime: TLongWordField;
    taSqlHistoryPostRunTimeAsString: TWideStringField;
    tiElapsed: TTimer;
    paCancelableQuery: TPanel;
    btnCancel: TcxButton;
    taSqlHistoryPostQueryExecutionResult: TIntegerField;
    taSqlHistoryBrowseQueryExecutionResult: TIntegerField;
    FileSaveDialogXP: TSaveTextFileDialog;
    FileSaveDialog7: TFileSaveDialog;
    FileOpenDialogXP: TOpenTextFileDialog;
    FileOpenDialog7: TFileOpenDialog;
    pmSqlEditor: TPopupMenu;
    pmSqlEditorCut: TMenuItem;
    pmSqlEditorCopy: TMenuItem;
    pmSqlEditorPaste: TMenuItem;
    pmSqlEditorSelectAll: TMenuItem;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    pmSqlEditorUndo: TMenuItem;
    pmSqlEditorDelete: TMenuItem;
    SynEditOptionsDialog1: TSynEditOptionsDialog;
    meSQLLog: TcxMemo;
    laElapsed: TcxLabel;
    laRunning: TcxLabel;
    SynSQLSynDark: TSynSQLSyn;
    procedure Initialize;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender : TObject;
                    var Action : TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tiElapsedTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SQLEditorChange(Sender: TObject);
    procedure FileOpenDialog7Execute(Sender: TObject);
    procedure FileOpenDialog7FileOkClick(Sender: TObject;
      var CanClose: Boolean);
    procedure FileSaveDialog7Execute(Sender: TObject);
    procedure FileSaveDialog7FileOkClick(Sender: TObject;
      var CanClose: Boolean);
  private
    { Private declarations }
    FSyntaxCheckOnly,
    fOldSyntaxCheckOnly,
    FOldCancelableQuery       : Boolean;
    FServerName               : string;
    FDatabaseName             : string;
    FConfig                   : TnxeSQLConfig;
    FConnection               : TnxSQLConnection;
    FUserName                 : string;
    FPassword                 : string;
    FDatabase                 : TnxDatabase;
    FLastQueryIsSelect        : Boolean;
    FSuppressParamsDialog     : Boolean;
    FSupressSyntaxOKDialog    : Boolean;
    FInitialStatement         : string;
    FDatabaseNode             : TnxemNode;
    FBeforeInitDone           : Boolean;
    fFirstHistoryMoveDone     : Boolean;

    fSearchBackwards          : boolean;
    fSearchCaseSensitive      : boolean;
    fSearchFromCaret          : boolean;
    fSearchSelectionOnly      : boolean;
    fSearchTextAtCaret        : boolean;
    fSearchWholeWords         : boolean;
    fSearchRegex              : boolean;
    fSearchWasReplace         : boolean;

    fSearchText               : string;
    fSearchTextHistory        : string;
    fReplaceText              : string;
    fReplaceTextHistory       : string;

    FileDialogCustomItemIndex : Cardinal;

    procedure DoSearchReplaceText(AReplace: boolean; ABackwards, aFindNext: boolean);
    procedure ShowSearchReplaceDialog(AReplace: boolean);

    procedure SetControls;
    procedure GetNewConnection;
    procedure DisplayHint(Sender : TObject);
    procedure WMGetMinMaxInfo(var Message : TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure SetLogVisible(aVisible: Boolean);
    function AddToSqlHistory(aSql : string; aExecuting : Boolean) : Boolean;

    procedure QueryThreadTerminate(Sender: TObject);
    procedure QuerySetup(var aQueryExecutionResult : TnxQueryExecutionResult);
    procedure QueryTeardown(const aQueryExecutionResult : TnxQueryExecutionResult; aInFormClose : Boolean = False);
    procedure WMQueryTeardown(var Message : TMessage); message WM_QueryTeardown;
    procedure WMRestoreSettings(var Message : TMessage); message WM_Restore_Settings;
  protected
    FLog                       : TnxBaseLog;
    FOnFormActivate            : TOnFormActivate;
    QueryCancelled             : Boolean;

    procedure SavePreferences; override;
    procedure SaveFontPreferences;
    procedure LoadPreferences; override;
    procedure DisplayBLOBSize(BlobStream: TStream); override;
    function  GetShowBLOBFields: Boolean; override;
    procedure SetShowBLOBFields(const Value: Boolean); override;
    function GetDefaultRequestLive: Boolean; override;
    function FormatExecutionTime(aTimeInMs : dword; aIncludeDescription : Boolean = True; aIncludeMs : Boolean = True) : string;
  public
    RemoveTempAliasOnClose          : Boolean;
    TempAliasToRemove               : string;
    SessionID                       : TGuid;
    SqlHistoryOnlyCurrentWindow,
    SQLHistoryOnlyContainsPhrase    : Boolean;
    SQLHistoryPhrase                : string;
    ReloadLastSql                   : Boolean;
    InQueryExecute                  : Boolean;
    LocalShowRecordCount            : Boolean;

    procedure UpdateDisplay; override;
    procedure DisplayRecNo; override;
    procedure UpdateLookAndFeel; override;

    procedure CreateSqlHistoryFilter;

    procedure acQueryExecuteExecute(Sender: TObject; aSyntaxCheckOnly : Boolean);
    procedure acQuerySaveExecute(Sender: TObject);
    procedure acQueryOpenExecute(Sender: TObject);
    procedure acQueryParameterValuesExecute(Sender: TObject);
    procedure acQueryCopyToTableExecute(Sender: TObject);
    procedure acQueryPrintPreviewExecute(Sender: TObject);
    procedure acQueryDesignReportExecute(Sender: TObject);
    procedure acViewShowBlobFieldsExecute(Sender: TObject);
    procedure acViewShowRecordCountExecute(Sender: TObject);
    procedure acViewLogExecute(Sender: TObject);
    procedure acViewRefreshExecute(Sender: TObject);
    procedure acQueryOptionsLiveDatasetExecute(Sender: TObject);
    procedure acQueryOptionsPropertiesExecute(Sender: TObject);
    procedure acQueryFindExecute(Sender: TObject);
    procedure acQueryFindNextExecute(Sender: TObject);
    procedure acQueryCopyToTableUpdate(Sender: TObject);
    procedure acQueryPrevStatementExecute(Sender: TObject);
    procedure acQueryNextStatementExecute(Sender: TObject);
    procedure acQueryPrintPreviewUpdate(Sender: TObject);
    procedure acQueryReplaceExecute(Sender: TObject);
    procedure acQueryToggleBookmarkExecute(Sender: TObject);
    procedure acQueryGotoBookmarkExecute(Sender: TObject);
    procedure acQueryClearBookmarksExecute(Sender: TObject);
    procedure acQueryToggleBookmarkUpdate(Sender: TObject);
    procedure acQueryGotoBookmarkUpdate(Sender: TObject);
    procedure acQueryClearBookmarksUpdate(Sender: TObject);
    procedure acQuerySqlHistoryOptionsExecute(Sender: TObject);
    procedure acQueryViewUseGridModeExecute(Sender: TObject);
    procedure acQuerySetFieldtoNULLExecute(Sender: TObject);
    procedure acQueryQueryBuilderUpdate(Sender: TObject);
    procedure acQueryQueryBuilderExecute(Sender: TObject);
    property ServerName : string
      read FServerName write FServerName;
    property DatabaseName : string
      read FDatabaseName write FDatabaseName;
    property Log : TnxBaseLog
      read FLog write FLog;
    property Password : string
      read FPassword write FPassword;
    property InitialStatement : string
      read FInitialStatement write FInitialStatement;
    property UserName : string
      read FUserName write FUserName;
    property Database: TnxDatabase
      read FDatabase write FDatabase;
    property DatabaseNode : TnxemNode
      read FDatabaseNode write FDatabaseNode;
    property SyntaxCheckOnly : Boolean
      read FSyntaxCheckOnly;
  published
    property
      OnFormActivate : TOnFormActivate read FOnFormActivate;
  end;

  {This class maintains the objects required for each SQL client
   connection.}
  TnxSQLConnection = class
  protected
    FQuery               : TnxQuery;
    FName                : string;
    FLastQueryText       : string;
    FExecutionTime       : DWord;
    FdlgParams           : TdlgParams;
    FRequestLive         : Boolean;
    FBeepAfterExecute    : Boolean;
    FCancelableQuery     : Boolean;
    FLowPriorityAfter    : Integer;
    FInQuery             : Boolean;
    FSqlBrowser          : TfrmQueryBrowser;
    FOriginalDatabase,
    FCancelableDatabase  : TnxDatabase;
    FCancelableSession   : TnxSession;
    FQueryException     : TObject;
  public
    WorkerThread       : TnxQueryWorkerThread;

    constructor Create(aDatabase           : TnxDatabase;
                       defTimeout          : Integer;
                       defReqLive          : Boolean;
                       defBeepAfterExecute : Boolean;
                       defLowPriorityAfter : Integer;
                       defCancelableQuery  : Boolean;
                       aSqlBrowser         : TfrmQueryBrowser);
    destructor Destroy; override;

    property ExecutionTime : DWord read FExecutionTime write FExecutionTime;
    property InQuery : Boolean read FInQuery write FInQuery;
    property Name : string read FName write FName;
    property Query : TnxQuery read FQuery;
    property LastQueryText : string read FLastQueryText write FLastQueryText;
      { The text of the query as last entered into the SQL window.
        We save it aside from the TnxQuery so that we don't trash the
        query's resultset. }
    property dlgParams : TdlgParams read FdlgParams write FdlgParams;
      { we keep an instance of the params dialog around
        when a query has parameters; thus saving the values }
    property RequestLive : Boolean read FRequestLive write FRequestLive;
    property BeepAfterExecute : Boolean read FBeepAfterExecute write FBeepAfterExecute;
    property CancelableQuery : Boolean read FCancelableQuery write FCancelableQuery;
    property LowPriorityAfter : Integer read FLowPriorityAfter write FLowPriorityAfter;
    property QueryException : TObject read FQueryException write FQueryException;
  end;

var
  NumQueryBrowsersTotal  : Integer;
  LastQueryBrowserNum    : Integer;

implementation

uses
  Variants,
  Math,
  ShlObj,

  SynUnicode,
  dlgSearchText,
  dlgReplaceText,
  dlgConfirmReplace,
  SynEditTypes,
  SynEditMiscProcs,

  //.. nxemGlyphs,
  nxllException,
  nxllMemoryManager,
  {$IFDEF EMIncludeReportEngine}
  nxemReportEngineFastReport,
  {$ENDIF}
  nxsrServerEngine,
  nxllUtils,
  nxllBde,
  nxllConst,
  unConfigInfo,
  nxsdTypes,

  dxDockPanel,
  dxDockControl,
  cxGridDBDataDefinitions,
  dxSkinsStrs,
  dxSkinsLookAndFeelPainter,

  {$IFDEF EMIncludeActiveQueryBuilder}
  dgQueryBuilder,
  {$ENDIF}
  dgCopyToTable,
  dgSQLOptions,
  dgSQLBrowserSqlHistory,
  fmTreeBrowser,
  dgSQLError,
  fmMainForm,
  dmMain;

{$R *.DFM}

resourcestring
  rsBLOBSize                        = 'BLOB Size: ';
  rsConnectionDeleted               = 'Connection deleted';
  rsCurrentQueryHasNoParameters     = 'Current Query has no parameters';
  rsExecutingSQL                    = 'Executing SQL...';
  rsSyntaxCheckingSQL               = 'Syntax Checking SQL...';
  rsNewQuery                        = 'New Query';
  rsQueries                         = 'Queries = %d';
  rsQuery                           = 'Query';
  rsQueryExecuted                   = 'Query Executed';
  rsQueryFailed                     = 'Query Failed!';
  rsQueryCancelled                  = 'Query Cancelled';
  rsQueryRetrieved                  = 'Query Retrieved';
  rsRecordCount                     = 'Records: ';
  rsRowsAffected                    = 'Rows affected = ';
  rsSyntaxIsValid                   = 'Syntax is valid';
  rsExecutionTimeMs                 = '%.3d ms';
  rsExecutionTimeSecs               = '%.2d sec %.3d ms';
  rsExecutionTimeSecsNoMs           = '%.2d sec';
  rsExecutionTimeMins               = '%.2d min %.2d sec';
  rsExecutionTimeHours              = '%.2d h %.2d m %.2d s';
  rsExecutionTimeDays               = '%d d %.2d h %.2d m %.2d s';
  rsConnections                     = 'Connections';

  nxConnChanged                     = 'Connection changed';

  rsTextNotFound                    = 'Text not found';

const
  nxc_LogStatement = '#L+';

  iPanelDescription = 0;
  iPanelQueryCount  = 1;
  iPanelRecordCount = 2;
  iPanelExecTime    = 3;
  iPanelBLOBSize    = 4;
  iPanelRecNo       = 5;

type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise       : PRaiseFrame;
    ExceptAddr      : Pointer;
    ExceptObject    : TObject;
    ExceptionRecord : PExceptionRecord;
  end;
  

{====================================================================}
constructor TnxSQLConnection.Create(aDatabase           : TnxDatabase;
                                    defTimeout          : Integer;
                                    defReqLive          : Boolean;
                                    defBeepAfterExecute : Boolean;
                                    defLowPriorityAfter : Integer;
                                    defCancelableQuery  : Boolean;
                                    aSqlBrowser         : TfrmQueryBrowser);
begin
  inherited Create;
  FExecutionTime := 0;
  FRequestLive := defReqLive;
  FBeepAfterExecute := defBeepAfterExecute;
  FLowPriorityAfter := defLowPriorityAfter;
  FCancelableQuery := defCancelableQuery;
  FSqlBrowser := aSqlBrowser;
  FOriginalDatabase := aDatabase;
  FOriginalDatabase.Active := True;

  FQuery := TnxQuery.Create(nil);
  with FQuery do begin
    FCancelableDatabase := TnxDatabase.Create(nil);
    FCancelableDatabase.AliasName := aDatabase.AliasName;
    FCancelableDatabase.Session := TnxSession.Create(nil);
    with frmTreeBrowser.GetNodeObject(frmTreeBrowser.GetServerNode(frmTreeBrowser.GetTreeNodeFromObject(FSqlBrowser.DatabaseNode))) do begin
      FCancelableDatabase.Session.UserName := UserName;
      FCancelableDatabase.Session.Password := Password;
    end;
    TnxSession(FCancelableDatabase.Session).ServerEngine := FOriginalDatabase.Session.ServerEngine;
    FCancelableDatabase.Active := True;
    Name := rsQuery + IntToStr(GetTickCount);
    RequestLive := defReqLive;
    Timeout := defTimeout;
    if frmMain.acGlobalOptionsRecNoSupport.Checked then
      Options := Options + [dsoRecNoSupport];
  end;

  FName := rsNewQuery;
  FLastQueryText := '';
end;
{------------------------------------------------------------------------------}
destructor TnxSQLConnection.Destroy;
begin
  try
    try
      if FQuery.State in [dsInsert, dsEdit] then
        FQuery.Post;
    except
      FQuery.Cancel;
    end;
    FQuery.Close;
    FQuery.Free;
    FCancelableDatabase.Session.Free;
    FCancelableDatabase.Free;
  except
    on E:EnxDatabaseError do
      if E.ErrorCode <> DBIERR_SERVERCOMMLOST then
        raise;
    on E:Exception do
      raise;
  end;

  if Assigned(dlgParams) then
    dlgParams.Free;
  inherited Destroy;
end;
{====================================================================}

{===TfrmQueryBrowser=================================================}
procedure TfrmQueryBrowser.DisplayHint(Sender : TObject);
begin
//  StatusBar.Panels[iPanelDescription].Text := Application.Hint;
end;
{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.FileOpenDialog7Execute(Sender: TObject);
var
  CustInterface : IFileDialogCustomize;
  i             : Integer;
begin
  if FileOpenDialog7.Dialog.QueryInterface(IFileDialogCustomize, CustInterface) = S_OK then
  begin
    CustInterface.StartVisualGroup(0, 'Encoding');
    CustInterface.AddComboBox(2);
    for i := 0 to Pred(FileOpenDialogXP.Encodings.Count) do
      CustInterface.AddControlItem(2, i + 1, PChar(FileOpenDialogXP.Encodings[i]));
    CustInterface.EndVisualGroup;
    CustInterface.SetSelectedControlItem(2, 5); //utf-8
   end;
end;

procedure TfrmQueryBrowser.FileOpenDialog7FileOkClick(Sender: TObject; var CanClose: Boolean);
var
  CustInterface : IFileDialogCustomize;
begin
  FileDialogCustomItemIndex := 0;
  if FileOpenDialog7.Dialog.QueryInterface(IFileDialogCustomize, CustInterface) = S_OK then
    CustInterface.GetSelectedControlItem(2, FileDialogCustomItemIndex);
end;

procedure TfrmQueryBrowser.FileSaveDialog7Execute(Sender: TObject);
var
  CustInterface : IFileDialogCustomize;
  i             : Integer;
begin
  if FileSaveDialog7.Dialog.QueryInterface(IFileDialogCustomize, CustInterface) = S_OK then
  begin
    CustInterface.StartVisualGroup(0, 'Encoding');
    CustInterface.AddComboBox(2);
    for i := 0 to Pred(FileSaveDialogXP.Encodings.Count) do
      CustInterface.AddControlItem(2, i + 1, PChar(FileSaveDialogXP.Encodings[i]));
    CustInterface.EndVisualGroup;
    CustInterface.SetSelectedControlItem(2, 5); //utf-8
   end;
end;

procedure TfrmQueryBrowser.FileSaveDialog7FileOkClick(Sender: TObject; var CanClose: Boolean);
var
  CustInterface : IFileDialogCustomize;
begin
  FileDialogCustomItemIndex := 0;
  if FileSaveDialog7.Dialog.QueryInterface(IFileDialogCustomize, CustInterface) = S_OK then
    CustInterface.GetSelectedControlItem(2, FileDialogCustomItemIndex);
end;

function TfrmQueryBrowser.FormatExecutionTime(aTimeInMs: dword; aIncludeDescription : Boolean = True; aIncludeMs : Boolean = True) : string;
begin
  if aTimeInMs < 1000 then
    Result := Format(rsExecutionTimeMs, [aTimeInMs])
  else
  if aIncludeMs and (aTimeInMs < 60*1000) then
    Result := Format(rsExecutionTimeSecs, [aTimeInMs div 1000, aTimeInMs mod 1000])
  else
  if (not aIncludeMs) and (aTimeInMs < 60*1000) then
    Result := Format(rsExecutionTimeSecsNoMs, [aTimeInMs div 1000])
  else
  if aTimeInMs < 60*60*1000 then begin
    aTimeInMs := aTimeInMs div 1000;
    Result := Format(rsExecutionTimeMins, [aTimeInMs div 60, aTimeInMs mod 60])
  end
  else
  if aTimeInMs < 24*60*60*1000 then begin
    aTimeInMs := aTimeInMs div 1000;
    Result := Format(rsExecutionTimeHours, [aTimeInMs div (60*60),
                                           (aTimeInMs mod (60*60)) div 60,
                                           (aTimeInMs mod (60*60)) mod 60]);
  end
  else begin
    aTimeInMs := aTimeInMs div 1000;
    Result := Format(rsExecutionTimeDays, [aTimeInMs div (24*60*60),
                                           aTimeInMs div (60*60) mod 24,
                                          (aTimeInMs mod (60*60)) div 60,
                                          (aTimeInMs mod (60*60)) mod 60]);
  end;
  if aIncludeDescription then
    Result := 'Execution time = ' + Result;
end;

procedure TfrmQueryBrowser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if frmMain.QueryBrowserToActivate = Self then
    frmMain.QueryBrowserToActivate := nil;

  if Assigned(FConnection) then
  if FConnection.CancelableQuery and FConnection.InQuery and paCancelableQuery.Visible then begin
    QueryCancelled := True;
    try
      FConnection.Query.Session.CancelProcessing;
    except
    end;
    QueryTeardown(qerCancelledRunningQuery, True);
  end;

  try
    try
      if FConnection.Query.State in [dsInsert, dsEdit] then
        FConnection.Query.Post;
    except
      FConnection.Query.Cancel;
    end;
    FConnection.Query.Close;
  except
    on E:EnxDatabaseError do
      if E.ErrorCode <> DBIERR_SERVERCOMMLOST then
        raise;
    on E:Exception do
      raise;
  end;

  AddToSqlHistory(SQLEditor.Text, False);

  if RemoveTempAliasOnClose then begin
    Database.Session.DeleteAlias(TempAliasToRemove);
    frmTreeBrowser.LoadOutlineDatabases(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode).Parent);
  end;

  frmMain.ResetCustomEditActions;

  try
    dsBrowser.DataSet := nil;
  except
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.FormDestroy(Sender: TObject);
begin
  SavePreferences;
  FConnection.Free;
  if Assigned(FConfig) then
    FConfig.Free;
  Application.OnHint := nil;

  Dec(NumQueryBrowsersTotal);
  if NumQueryBrowsersTotal = 0 then
    LastQueryBrowserNum := 0;

  inherited;
end;

procedure TfrmQueryBrowser.FormResize(Sender: TObject);
begin
  inherited;

  if paCancelableQuery.Visible then begin
    btnCancel.Top := (Height - btnCancel.Height) div 2;
    btnCancel.Left := (Width - btnCancel.Width) div 2;
    laElapsed.Top := btnCancel.Top - Trunc(laElapsed.Height * 1.5);
    laElapsed.Left := btnCancel.Left;
    laRunning.Top := laElapsed.Top - Trunc(laRunning.Height * 1.5);
    laRunning.Left := laElapsed.Left;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.Initialize;
var
  RunAt           : TDateTime;
  SkipLogModifier : Boolean;
begin
  FLastQueryIsSelect := True;
  SkipLogModifier := False;

  RunAt := 0;
  taSqlHistoryBrowse.IndexFieldNames := 'ServerName;DatabaseName;RunAt';

  taSqlHistoryBrowse.SetRange([ServerName, DatabaseName], [ServerName, DatabaseName]);
  if not taSqlHistoryBrowse.IsEmpty then begin
    taSqlHistoryBrowse.Last;
    RunAt := taSqlHistoryBrowseRunAt.AsDateTime;
    if ReloadLastSql then begin
      FInitialStatement := taSqlHistoryBrowseSQL.AsString;
      SkipLogModifier := True;
    end;
  end;
  taSqlHistoryBrowse.CancelRange;

  if FConfig.GlobalSqlHistoryOrderBy <> '' then
    taSqlHistoryBrowse.IndexFieldNames := FConfig.GlobalSqlHistoryOrderBy;

  CreateGUID(SessionID);
  CreateSqlHistoryFilter;

  if RunAt <> 0 then
    taSqlHistoryBrowse.Locate('ServerName;DatabaseName;RunAt', VarArrayOf([ServerName, DatabaseName, RunAt]), [])
  else
    taSqlHistoryBrowse.Last;

  frmMain.dxbsServerName.Caption := taSqlHistoryBrowseServerName.AsString;
  frmMain.dxbsDatabaseName.Caption := taSqlHistoryBrowseDatabaseName.AsString;
  frmMain.dxbsRunAt.Caption := taSqlHistoryBrowseRunAt.AsString;

  //if not reloading, the next/prev history needs to pull up the current record first
  fFirstHistoryMoveDone := ReloadLastSql;

  if not SkipLogModifier then begin
    if FInitialStatement = '' then begin
      FInitialStatement := 'SELECT ';
    if FConfig.GlobalViewLog then
      FInitialStatement := nxc_LogStatement + #13#10 + #13#10 + FInitialStatement;
    end;
  end;

  GetNewConnection;
  SQLEditor.Text := FInitialStatement;
  SQLEditor.ResetModificationIndicator;
  SQLEditor.SetFocus;
  FConnection.LastQueryText := SQLEditor.Text;
  Application.OnHint := DisplayHint;
  FSyntaxCheckOnly := False;
  FLastQueryIsSelect := True;
end;
{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.GetNewConnection;
begin
  FConnection := TnxSQLConnection.Create(FDatabase,
                                         FConfig.GlobalTimeout,
                                         not FReadOnly and FConfig.GlobalRequestLive,
                                         FConfig.GlobalBeepAfterExecute,
                                         FConfig.GlobalLowPriorityAfter,
                                         FConfig.GlobalCancelableQuery,
                                         Self);
  dsBrowser.DataSet := FConnection.Query;
  RebuildColumns;
  AdjustColumWidths;
  SetControls;
end;
{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.LoadPreferences;
begin
  inherited;
  paBottom.Visible := False;
  splGridAndPageControl.Visible := False;
  splQueryAndLog.Visible := False;
  meSQLLog.Visible := False;
  FConfig := TnxeSQLConfig.Create(Caption, Screen.MonitorFromWindow(Handle));
  FConfig.Refresh;

  with FConfig do begin
    { the oncheck flips it back :) }
    frmMain.acQueryViewLog.Checked := ViewLog;
    frmMain.acQueryViewShowRecordCount.Checked := ShowRecordCount;
    LocalShowRecordCount := ShowRecordCount;
    frmMain.acQueryOptionsLiveDataset.Checked := FConfig.GlobalRequestLive;
  end;
end;

procedure TfrmQueryBrowser.QuerySetup;
var
  i : Integer;
begin
  if FSyntaxCheckOnly then
    aQueryExecutionResult := qerRanSuccessfully
  else
    aQueryExecutionResult := qerCancelledQuerySetup;
  FreeBLOBTabSheets;
  if not FConnection.CancelableQuery then
    Screen.Cursor := crHourGlass;
  meSQLLog.Clear;

  StatusBar.Panels[iPanelDescription].Text := rsSyntaxCheckingSQL;
  StatusBar.Refresh;
  DisplayBLOBSize(nil);
  FConnection.Query.SQL.Clear;
  FConnection.QueryException := nil;
  if FConnection.FCancelableQuery then
    FConnection.Query.Database := FConnection.FCancelableDatabase
  else
    FConnection.Query.Database := FConnection.FOriginalDatabase;

  if Config.UsePlainGrid then
    PlainDataGrid.Columns.Clear
  else
    cxGrid1DBTableView1.ClearItems;
  Application.ProcessMessages;

  with frmTreeBrowser, GetNodeObject(GetServerNode(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode))) do
  for i := 0 to Pred(TablePasswords.Count) do try
    FConnection.Query.Session.PasswordAdd(TablePasswords[i]);
  except
    on E:EnxDatabaseError do
      if E.ErrorCode <> DBIERR_NAMENOTUNIQUE then begin
        FConnection.QueryException := AcquireExceptionObject;
        aQueryExecutionResult := qerErrorRaised;
        Exit;
      end;
  end;

  FConnection.Query.RequestLive := FConnection.RequestLive;
  if SQLEditor.SelAvail then begin
    FConnection.Query.SQL.Text := SQLEditor.SelText;
    FConnection.Name := SQLEditor.SelText;
  end else begin
    FConnection.Query.SQL.Text := SQLEditor.Text;
    FConnection.Name := SQLEditor.Lines[0];
  end;

  { do we need to present the Params dialog? }
  if not FSuppressParamsDialog then begin
    if FConnection.Query.ParamCount > 0 then begin
      if not Assigned(FConnection.dlgParams) then
        FConnection.dlgParams := TdlgParams.Create(Self);

      if not FConnection.dlgParams.EditParamValues(FConnection.Query.Params) then begin
        aQueryExecutionResult := qerCancelledQuerySetup;
        Exit;
      end;
    end
    else
    { params not needed anymore? }
    if Assigned(FConnection.dlgParams) then begin
      FConnection.dlgParams.Free;
      FConnection.dlgParams := Nil;
    end;
  end
  else
    { get stored values }
    FConnection.dlgParams.GetParamValues(FConnection.Query.Params);

  if FSyntaxCheckOnly then
    StatusBar.Panels[iPanelDescription].Text := rsSyntaxCheckingSQL
  else
    StatusBar.Panels[iPanelDescription].Text := rsExecutingSQL;
  StatusBar.Refresh;

  if SQLEditor.SelAvail then
    AddToSqlHistory(SQLEditor.Text, True);

  if AddToSqlHistory(FConnection.Query.SQL.Text, True) then begin
    frmMain.acQueryNextStatement.Update;
    frmMain.acQueryPrevStatement.Update;
  end;

  if Config.UsePlainGrid then begin
    PlainDataGrid.DataSource := nil;
    PlainDataGrid.Columns.BeginUpdate;
  end
  else begin
    cxGrid1DBTableView1.DataController.DataSource := nil;
    cxGrid1DBTableView1.BeginUpdate;
  end;

  if FConnection.LowPriorityAfter <> 0 then
    FConnection.Query.Session.AbstractSession.OptionSet('PRIORITY_REDUCTION_TIMEOUT', IntToStr(FConnection.LowPriorityAfter));

  if FConnection.FCancelableQuery then begin
    QueryCancelled := False;
    paCancelableQuery.Visible := True;
    paCancelableQuery.Left := Left;
    paCancelableQuery.Top := Top;
    paCancelableQuery.Width := Width;
    paCancelableQuery.Height := Height;
    btnCancel.Top := (Height - btnCancel.Height) div 2;
    btnCancel.Left := (Width - btnCancel.Width) div 2;
    laElapsed.Top := btnCancel.Top - Trunc(laElapsed.Height * 1.5);
    laElapsed.Left := btnCancel.Left;
    laRunning.Top := laElapsed.Top - Trunc(laRunning.Height * 1.5);
    laRunning.Left := laElapsed.Left;
    laElapsed.Caption := FormatExecutionTime(0, False, False);

    paCancelableQuery.BringToFront;
    tiElapsed.Enabled := True;
    FConnection.InQuery := True;
    FConnection.ExecutionTime := GetTickCount;
    FConnection.WorkerThread :=
      TnxQueryWorkerThread.Create(tpNormal,
                                  FConnection,
                                  QueryThreadTerminate);
    //presumably...
    aQueryExecutionResult := qerRanSuccessfully;
  end
  else begin
    FConnection.ExecutionTime := GetTickCount;
    try
      if FSyntaxCheckOnly then
        FConnection.Query.Prepare
      else
        FConnection.Query.Open;
      FConnection.ExecutionTime := GetTickCount - FConnection.ExecutionTime;
      aQueryExecutionResult := qerRanSuccessfully;
    except
      FConnection.ExecutionTime := GetTickCount - FConnection.ExecutionTime;
      FConnection.QueryException := AcquireExceptionObject;
      aQueryExecutionResult := qerErrorRaised;
      Exit;
    end;
  end;
end;

procedure TfrmQueryBrowser.QueryTeardown(const aQueryExecutionResult : TnxQueryExecutionResult; aInFormClose : Boolean = False);
const
  nxc_ErrorAtLine = ' at line ';
  nxc_ErrorAtPosition = ' pos ';
var
  Line,
  Position,
  ErrorAtLinePos,
  ErrorAtPositionPos : Integer;
begin
  try
    //always save regardless of successful result
    taSqlHistoryPost.Edit;
    taSqlHistoryPostRunTime.Value := FConnection.ExecutionTime;
    taSqlHistoryPostRunTimeAsString.AsString := FormatExecutionTime(FConnection.ExecutionTime, False);
    taSqlHistoryPostQueryLog.AsString := FConnection.Query.Log.Text;
    taSqlHistoryPostQueryExecutionResult.AsInteger := Integer(aQueryExecutionResult);
    taSqlHistoryPost.Post;

    if aQueryExecutionResult = qerRanSuccessfully then
      if Config.UsePlainGrid then
        PlainDataGrid.DataSource := dsBrowser
      else
        cxGrid1DBTableView1.DataController.DataSource := dsBrowser;

    if Config.UsePlainGrid then
      PlainDataGrid.Columns.EndUpdate
    else
      cxGrid1DBTableView1.EndUpdate;

    paCancelableQuery.Visible := False;

    if FConnection.LowPriorityAfter <> 0 then
      FConnection.Query.Session.AbstractSession.OptionSet('PRIORITY_REDUCTION_TIMEOUT', '0');

    try
      if Assigned(FConnection.QueryException) then
        try
          raise Exception(FConnection.QueryException);
        finally
          FConnection.QueryException := nil;
          ReleaseExceptionObject;
        end;


      FLastQueryIsSelect := FConnection.Query.Active;

      if FConnection.BeepAfterExecute then
         MessageBeep($FFFFFFFF);

      RebuildColumns;
      AdjustColumWidths;

      if FSyntaxCheckOnly then begin
        StatusBar.Panels[iPanelDescription].Text := rsSyntaxIsValid;
        if not FSupressSyntaxOKDialog then
          ShowMessage(rsSyntaxIsValid);
      end
      else
      if FLastQueryIsSelect then begin
        if aQueryExecutionResult = qerCancelledRunningQuery then
           StatusBar.Panels[iPanelDescription].Text := rsQueryCancelled
        else
          StatusBar.Panels[iPanelDescription].Text := rsQueryRetrieved;
        if not FConnection.Query.CanModify or frmMain.acQueryViewShowRecordCount.Checked then
          StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount +
                                                      nxCommaizeChL(FConnection.Query.RecordCount,
                                                      {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator);
        StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(FConnection.ExecutionTime);

        { make sure no column exceeds screen width }
{!!!}//          igdBrowser.bgAdjustColumWidths;
        if Config.UsePlainGrid then
          PlainDataGrid.ReadOnly := FReadOnly or not FConnection.Query.CanModify
        else
          cxGrid1DBTableView1.OptionsData.Editing := not (FReadOnly or not FConnection.Query.CanModify);

        FConnection.Query.BeforePost := nxDatasetBeforePost;
        FConnection.Query.AfterPost := nxDatasetAfterPost;
        FConnection.Query.AfterDelete := nxDatasetAfterDelete;
        FConnection.Query.AfterScroll := nxDatasetAfterScroll;
        FConnection.Query.AfterCancel := nxDatasetAfterCancel;

        CreateBLOBTabSheets;
        ViewActiveBlobField;
        DisplayRecNo;
        { update newly created dynamic components }
        SetTabSheetsReadOnly(FReadOnly or not FConnection.Query.CanModify);

      end else begin
        if aQueryExecutionResult = qerCancelledRunningQuery then
          StatusBar.Panels[iPanelDescription].Text := rsQueryCancelled
        else
          StatusBar.Panels[iPanelDescription].Text := rsQueryExecuted;
        StatusBar.Panels[iPanelRecordCount].Text := rsRowsAffected +
                                                     nxCommaizeChL(FConnection.Query.RowsAffected,
                                                     {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator);
        StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(FConnection.ExecutionTime);
      end;
      meSQLLog.Lines.Text := FConnection.Query.Log.Text;

      if not aInFormClose then
      if DatabaseNode.Database.Session.IsAlias(DatabaseNode.Database.AliasName) then begin
        if frmMain.acGlobalOptionsAutoTreeRefresh.Checked then begin
          frmTreeBrowser.LoadOutlineDatabases(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode).Parent);
          frmTreeBrowser.LoadOutlineTables(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode.TablesNodeObject));
          frmTreeBrowser.LoadOutlineTriggers(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode.TriggersNodeObject));
          frmTreeBrowser.LoadOutlineViews(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode.ViewsNodeObject));
          frmTreeBrowser.LoadOutlineStoredProcs(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode.StoredProcsNodeObject));
          frmTreeBrowser.LoadOutlineCheckConstraints(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode.CheckConstraintsNodeObject));
        end;
      end
      else begin
        frmTreeBrowser.LoadOutlineDatabases(frmTreeBrowser.GetTreeNodeFromObject(DatabaseNode).Parent);
        MessageDlg('NOTE! The currently active database was dropped by this script. No other queries can be run from this query window. Close this window and open another on an existing database.', mtInformation, [mbOK], 0);
        frmMain.acQueryExecute.Enabled := False;
      end;

    except
      on E: EnxDatabaseError do begin
        if not FSyntaxCheckOnly then begin
          taSqlHistoryPost.Edit;
          taSqlHistoryPostErrorMessage.AsString := E.Message;
          taSqlHistoryPost.Post;
        end;

        if not aInFormClose then begin
          meSQLLog.Lines.Text :=
            E.Message + #13#10 + #13#10 + '=== Query Log ===' + #13#10 + #13#10 +
            FConnection.Query.Log.Text;

          if aQueryExecutionResult = qerCancelledRunningQuery then
            StatusBar.Panels[iPanelDescription].Text := rsQueryCancelled
          else
            StatusBar.Panels[iPanelDescription].Text := rsQueryFailed;
          StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount + '0';
          StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(FConnection.ExecutionTime);

          if FConnection.BeepAfterExecute then
             MessageBeep($FFFFFFFF);

          ErrorAtLinePos := Pos(nxc_ErrorAtLine, E.Message);
          ErrorAtPositionPos := Pos(nxc_ErrorAtPosition, E.Message);

          if SQLErrorDlg(Self, E.Message, E.ExceptionData.ToString,
                        (ErrorAtLinePos>0) and (ErrorAtLinePos<ErrorAtPositionPos))=mrOK then begin
            { format of error statement we search for is
              ' at line xxx pos yyy' or ' at line xxx, pos yyy' }
            ErrorAtLinePos := ErrorAtLinePos + Length(nxc_ErrorAtLine);
            Line := 0;
            while CharInSet(E.Message[ErrorAtLinePos], ['0'..'9']) do begin
              Line := 10 * Line + StrToInt(Copy(E.Message, ErrorAtLinePos, 1));
              Inc(ErrorAtLinePos);
            end;

            ErrorAtPositionPos := ErrorAtPositionPos + Length(nxc_ErrorAtPosition);
            Position := 0;
            while CharInSet(E.Message[ErrorAtPositionPos], ['0'..'9']) do begin
              Position := 10 * Position + StrToInt(Copy(E.Message, ErrorAtPositionPos, 1));
              Inc(ErrorAtPositionPos);
            end;

            { if we queried on a selection, adjust for that }
            if SQLEditor.SelAvail then begin
              if Succ(SQLEditor.BlockBegin.Line) = Line then
                Position := Position + SQLEditor.BlockBegin.Char;

              Line := Line + SQLEditor.BlockBegin.Line - 1;
            end;

            SQLEditor.CaretX := Position;
            SQLEditor.CaretY := Line;
          end;
        end;
      end;
    end;
  finally
    fSyntaxCheckOnly := fOldSyntaxCheckOnly;
    if not FConnection.CancelableQuery then begin
      InQueryExecute := False;
      Screen.Cursor := crDefault;
      SetControls;
    end;
    FConnection.FCancelableQuery := FOldCancelableQuery;
  end;
end;

procedure TfrmQueryBrowser.QueryThreadTerminate(Sender: TObject);
begin
  if not QueryCancelled then begin
    tiElapsed.Enabled := False;
    paCancelableQuery.Visible := False;
    if Assigned(FConnection.QueryException) then
      PostMessage(Handle, WM_QueryTeardown, NativeUInt(qerErrorRaised), 0)
    else
      PostMessage(Handle, WM_QueryTeardown, NativeUInt(qerRanSuccessfully), 0);
  end;
end;

procedure TfrmQueryBrowser.SaveFontPreferences;
begin
  if Assigned(FConfig) then begin
    with FConfig do begin
      GlobalFontName := SQLEditor.Font.Name;
      GlobalFontSize := SQLEditor.Font.Size;
    end;
  end;
end;

procedure TfrmQueryBrowser.SavePreferences;
begin
  inherited;
  if Assigned(FConfig) then begin
    with FConfig do begin
      QueryAndGridSplitterPos := paTop.Height;
      if meSQLLog.Visible then
        QueryAndLogSplitterPos := meSQLLog.Width;
      ViewLog := frmMain.acQueryViewLog.Checked;
      ShowRecordCount := frmMain.acQueryViewShowRecordCount.Checked;
      Save(Screen.MonitorFromWindow(Handle));
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmQueryBrowser.SetControls;
begin
  frmMain.acQueryOptionsLiveDataset.Enabled := False;
  //double assignment intentional
  frmMain.acQueryOptionsLiveDataset.Enabled := True;
  with FConnection.Query do begin
    if FLastQueryIsSelect then begin
      if Active then begin
        if not CanModify or frmMain.acQueryViewShowRecordCount.Checked then
          StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount +
                                                      nxCommaizeChL(RecordCount, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)
        else
          StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount;
        StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(FConnection.ExecutionTime);
      end else begin
        StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount + '0';
        if StatusBar.Panels[iPanelDescription].Text <> rsQueryFailed then //dont null out time spent if an error occurs
          StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(0);
      end;
    end
    else begin
      StatusBar.Panels[iPanelRecordCount].Text :=
        rsRowsAffected + nxCommaizeChL(RowsAffected, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator);
      StatusBar.Panels[iPanelExecTime].Text := FormatExecutionTime(FConnection.ExecutionTime);
    end;
  end;

  StatusBar.Panels[iPanelQueryCount].Text := format(rsQueries, [taSqlHistoryBrowse.RecordCount]);
  StatusBar.Refresh;
end;

procedure TfrmQueryBrowser.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  MinMax : PMinMaxInfo;
begin
  inherited;
  MinMax := Message.MinMaxInfo;
  MinMax^.ptMinTrackSize.x := 535;
end;

procedure TfrmQueryBrowser.WMQueryTeardown(var Message: TMessage);
begin
  QueryTeardown(TnxQueryExecutionResult(Message.WParam));
end;

procedure TfrmQueryBrowser.WMRestoreSettings(var Message: TMessage);
begin
  with FConfig do begin
    SQLEditor.Font.Name := GlobalFontName;
    SQLEditor.Font.Size := GlobalFontSize;
    paTop.Height := (QueryAndGridSplitterPos * 9) div Application.DefaultFont.Size;
    meSQLLog.Width := (QueryAndLogSplitterPos * 9) div Application.DefaultFont.Size;
  end;
  SetGridModeBufferCount;
end;

procedure TfrmQueryBrowser.DisplayBLOBSize(BlobStream: TStream);
begin
  if Assigned(BlobStream) then
    StatusBar.Panels[iPanelBLOBSize].Text := rsBLOBSize + nxCommaizeChL(BlobStream.Size, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)
  else
    StatusBar.Panels[iPanelBLOBSize].Text := rsBLOBSize;
end;

function TfrmQueryBrowser.GetShowBLOBFields: Boolean;
begin
  Result := frmMain.acQueryViewShowBLOBFields.Checked;
end;

procedure TfrmQueryBrowser.SetShowBLOBFields(const Value: Boolean);
begin
  frmMain.acQueryViewShowBLOBFields.Checked := Value;
  if Visible then
    SetGridModeBufferCount;
end;

procedure TfrmQueryBrowser.ShowSearchReplaceDialog(AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  Statusbar.Panels[0].Text := '';
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
    dlg := TTextSearchDialog.Create(Self);
  with dlg do try
    Position := poMainFormCenter;
    // assign search options
    SearchBackwards := fSearchBackwards;
    SearchCaseSensitive := fSearchCaseSensitive;
    SearchFromCursor := fSearchFromCaret;
    SearchInSelectionOnly := fSearchSelectionOnly;
    SearchRegularExpression := fSearchRegex;
    // start with last search text
    SearchText := fSearchText;
    if fSearchTextAtCaret then begin
      // if something is selected search for that text
      if SQLEditor.SelAvail and (SQLEditor.BlockBegin.Line = SQLEditor.BlockEnd.Line)
      then
        SearchText := SQLEditor.SelText
      else
        SearchText := SQLEditor.GetWordAtRowCol(SQLEditor.CaretXY);
    end;
    SearchTextHistory := fSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := fReplaceText;
      ReplaceTextHistory := fReplaceTextHistory;
    end;
    SearchWholeWords := fSearchWholeWords;
    if ShowModal = mrOK then begin
      fSearchBackwards := SearchBackwards;
      fSearchCaseSensitive := SearchCaseSensitive;
      fSearchFromCaret := SearchFromCursor;
      fSearchSelectionOnly := SearchInSelectionOnly;
      fSearchWholeWords := SearchWholeWords;
      fSearchRegex := SearchRegularExpression;
      fSearchText := SearchText;
      fSearchTextHistory := SearchTextHistory;
      fSearchWasReplace := AReplace;
      if AReplace then with dlg as TTextReplaceDialog do begin
        fReplaceText := ReplaceText;
        fReplaceTextHistory := ReplaceTextHistory;
      end;
      if fSearchText <> '' then begin
        DoSearchReplaceText(AReplace, fSearchBackwards, False);
//        fSearchFromCaret := TRUE;
      end;
      frmMain.acQueryFindNext.Enabled := True;
    end
    else
      frmMain.acQueryFindNext.Enabled := False;
  finally
    dlg.Free;
  end;
end;

procedure TfrmQueryBrowser.SQLEditorChange(Sender: TObject);
begin
  inherited;
  if SQLEditor.Lines.Count = 0 then
    SQLEditor.Gutter.DigitCount := 2
  else
    SQLEditor.Gutter.DigitCount := Max(2, Succ(Trunc(Log10(SQLEditor.Lines.Count))));
end;

procedure TfrmQueryBrowser.tiElapsedTimer(Sender: TObject);
begin
  laElapsed.Caption := FormatExecutionTime(GetTickCount - FConnection.ExecutionTime, False, False);
end;

procedure TfrmQueryBrowser.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;

  FBeforeInitDone := True;
  SqlHistoryOnlyCurrentWindow := False;
  for i := 0 to Pred(FileSaveDialogXP.Encodings.Count) do begin
    if SameText(FileSaveDialogXP.Encodings[i], 'Ascii') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.ASCII
    else
    if SameText(FileSaveDialogXP.Encodings[i], 'Ansi') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.ANSI
    else
    if SameText(FileSaveDialogXP.Encodings[i], 'Unicode') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.Unicode
    else
    if SameText(FileSaveDialogXP.Encodings[i], 'Big Endian Unicode') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.BigEndianUnicode
    else
    if SameText(FileSaveDialogXP.Encodings[i], 'UTF-7') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.UTF7
    else
    if SameText(FileSaveDialogXP.Encodings[i], 'UTF-8') then
      FileSaveDialogXP.Encodings.Objects[i] := TEncoding.UTF8;
  end;
  for i := 0 to Pred(FileOpenDialogXP.Encodings.Count) do begin
    if SameText(FileOpenDialogXP.Encodings[i], 'Ascii') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.ASCII
    else
    if SameText(FileOpenDialogXP.Encodings[i], 'Ansi') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.ANSI
    else
    if SameText(FileOpenDialogXP.Encodings[i], 'Unicode') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.Unicode
    else
    if SameText(FileOpenDialogXP.Encodings[i], 'Big Endian Unicode') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.BigEndianUnicode
    else
    if SameText(FileOpenDialogXP.Encodings[i], 'UTF-7') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.UTF7
    else
    if SameText(FileOpenDialogXP.Encodings[i], 'UTF-8') then
      FileOpenDialogXP.Encodings.Objects[i] := TEncoding.UTF8;
  end;

  Inc(NumQueryBrowsersTotal);
  Inc(LastQueryBrowserNum);
end;

procedure TfrmQueryBrowser.acQueryExecuteExecute(Sender: TObject; aSyntaxCheckOnly : Boolean);
var
  QueryExecutionResult : TnxQueryExecutionResult;
begin
  fOldSyntaxCheckOnly := FSyntaxCheckOnly;
  FSyntaxCheckOnly := aSyntaxCheckOnly;
  FOldCancelableQuery := FConnection.FCancelableQuery;
  if aSyntaxCheckOnly then
    FConnection.FCancelableQuery := False;

  QuerySetup(QueryExecutionResult);
  if (not FConnection.FCancelableQuery) and
     (QueryExecutionResult <> qerCancelledQuerySetup) then
    QueryTeardown(QueryExecutionResult);
  if QueryExecutionResult = qerCancelledQuerySetup then
    Screen.Cursor := crDefault;
end;

procedure TfrmQueryBrowser.acQuerySaveExecute(Sender: TObject);
begin
  if Win32MajorVersion >= 6 then begin
    if FileSaveDialog7.FileName = '' then
      FileSaveDialog7.FileName := FileOpenDialog7.FileName;
    if FileSaveDialog7.Execute then begin
      if FileDialogCustomItemIndex > 0 then
        SQLEditor.Lines.SaveToFile(FileSaveDialog7.FileName, FileSaveDialogXP.Encodings.Objects[FileDialogCustomItemIndex - 1] as TEncoding)
      else
        SQLEditor.Lines.SaveToFile(FileSaveDialog7.FileName);
    end;
  end
  else begin
    if FileSaveDialogXP.FileName = '' then
      FileSaveDialogXP.FileName := OpenDialog.FileName;
    if FileSaveDialogXP.Execute then begin
      if FileExists(FileSaveDialogXP.FileName) then
        DeleteFile(FileSaveDialogXP.FileName);
      SQLEditor.Lines.SaveToFile(FileSaveDialogXP.FileName, FileSaveDialogXP.Encodings.Objects[FileSaveDialogXP.EncodingIndex] as TEncoding);
    end;
  end;
end;

procedure TfrmQueryBrowser.acQuerySqlHistoryOptionsExecute(Sender: TObject);
begin
  if ShowSqlHistoryOptionsDlg(Self) = mrOK then begin
    FConfig.GlobalSqlHistoryOrderBy := taSqlHistoryBrowse.IndexFieldNames;
  end;
end;

procedure TfrmQueryBrowser.acQueryToggleBookmarkExecute(Sender: TObject);
begin
  with (Sender as TAction) do begin
    Checked := not Checked;
    if Checked then
      SQLEditor.SetBookMark((Sender as TAction).Tag, SQLEditor.CaretX, SQLEditor.CaretY)
    else
      SQLEditor.ClearBookMark((Sender as TAction).Tag);
  end;
end;

procedure TfrmQueryBrowser.acQueryToggleBookmarkUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := True;
end;

procedure TfrmQueryBrowser.acQueryViewUseGridModeExecute(Sender: TObject);
begin
  frmMain.acQueryViewUseGridMode.Checked := not frmMain.acQueryViewUseGridMode.Checked;

  if not Config.UsePlainGrid then begin
    Screen.Cursor := crHourGlass;
    try
      cxGrid1DBTableView1.DataController.DataModeController.GridMode := frmMain.acQueryViewUseGridMode.Checked;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmQueryBrowser.acQueryOpenExecute(Sender: TObject);
begin
  if Win32MajorVersion >= 6 then begin
    if FileOpenDialog7.Execute then begin
      FileSaveDialog7.FileName := FileOpenDialog7.FileName;
      if FileDialogCustomItemIndex > 0 then begin
        SQLEditor.Lines.DefaultEncoding := FileOpenDialogXP.Encodings.Objects[FileDialogCustomItemIndex - 1] as TEncoding;
        SQLEditor.Lines.LoadFromFile(FileOpenDialog7.FileName, FileOpenDialogXP.Encodings.Objects[FileDialogCustomItemIndex - 1] as TEncoding);
      end
      else
        SQLEditor.Lines.LoadFromFile(FileOpenDialog7.FileName);
      FConnection.Name := SQLEditor.Lines[0];
      FConnection.Query.SQL.Clear;
    end;
  end
  else begin
    if FileOpenDialogXP.Execute then begin
      FileSaveDialogXP.FileName := FileOpenDialogXP.FileName;
      SQLEditor.Lines.DefaultEncoding := FileOpenDialogXP.Encodings.Objects[FileOpenDialogXP.EncodingIndex] as TEncoding;
      SQLEditor.Lines.LoadFromFile(FileOpenDialogXP.FileName, FileOpenDialogXP.Encodings.Objects[FileOpenDialogXP.EncodingIndex] as TEncoding);
      FConnection.Name := SQLEditor.Lines[0];
      FConnection.Query.SQL.Clear;
    end;
  end;
end;

procedure TfrmQueryBrowser.acQueryParameterValuesExecute(Sender: TObject);
var
  SaveSyntaxOnly,
  SaveCancelableQuery : Boolean;
begin
  { if query isn't active then update from memo etc and prepare statement }
  if not FConnection.Query.Active then begin
    SaveSyntaxOnly := FSyntaxCheckOnly;
    SaveCancelableQuery := FConnection.CancelableQuery;
    FConnection.CancelableQuery := False;
    FSupressSyntaxOKDialog := True;
    try
      FSyntaxCheckOnly := True;
      acQueryExecuteExecute(Sender, True);
    finally
      FSyntaxCheckOnly := SaveSyntaxOnly;
      FConnection.CancelableQuery := SaveCancelableQuery;
      FSupressSyntaxOKDialog := False;
    end;
  end;

  if FConnection.Query.ParamCount=0 then begin
    MessageDlg(rsCurrentQueryHasNoParameters, mtInformation, [mbOK], 0);
    Exit;
  end;

  if not Assigned(FConnection.dlgParams) then
    FConnection.dlgParams := TdlgParams.Create(Self);

  if FConnection.dlgParams.EditParamValues(FConnection.Query.Params) then
  if FConnection.Query.Active then begin
    FSuppressParamsDialog := True;
    try
      acQueryExecuteExecute(Sender, False);
    finally
      FSuppressParamsDialog := False;
    end;
  end;
end;

procedure TfrmQueryBrowser.acQueryClearBookmarksExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to 9 do
    SQLEditor.ClearBookMark(i);
end;

procedure TfrmQueryBrowser.acQueryClearBookmarksUpdate(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to 9 do
    if SQLEditor.IsBookmark(i) then begin
      (Sender as TAction).Enabled := True;
      Exit;
    end;
  (Sender as TAction).Enabled := False;
end;

function TfrmQueryBrowser.AddToSqlHistory(aSql : string; aExecuting : Boolean) : Boolean;
begin
  Result := False;
  if Assigned(FConnection) then begin
    if (FConnection.LastQueryText = aSql) and
       (not aExecuting) then
      Exit;

    if (not aExecuting) or
       (aExecuting and (FConnection.LastQueryText <> aSql)) then begin
        taSqlHistoryPost.Append;
        taSqlHistoryPostServerName.AsString := ServerName;
        taSqlHistoryPostDatabaseName.AsString := DatabaseName;
        taSqlHistoryPostSessionID.AsString := GuidToString(SessionID);
      end
      else begin
        taSqlHistoryPost.Edit;
        taSqlHistoryPostRunAt.AsDateTime := Now;
      end;
    taSqlHistoryPostSQL.AsString := aSql;
    taSqlHistoryPost.Post;
    taSqlHistoryBrowse.GotoCurrent(taSqlHistoryPost);
    FConnection.LastQueryText := aSql;
    Result := True;
  end;
end;

procedure TfrmQueryBrowser.btnCancelClick(Sender: TObject);
begin
  QueryCancelled := True;
  FConnection.Query.Session.CancelProcessing;
  tiElapsed.Enabled := False;
  paCancelableQuery.Visible := False;
  FConnection.ExecutionTime := GetTickCount - FConnection.ExecutionTime;
  QueryTeardown(qerCancelledRunningQuery);
end;

procedure TfrmQueryBrowser.CreateSqlHistoryFilter;
var
  s : string;
begin
  s := '';
  if SqlHistoryOnlyCurrentWindow then
    s := 'SessionID=guid' + QuotedStr(GuidToString(SessionID));
  if SqlHistoryOnlyCurrentWindow and
     SQLHistoryOnlyContainsPhrase then
    s := s + ' AND ';
  if SQLHistoryOnlyContainsPhrase then
    s := s + 'lower("SQL") like ' + QuotedStr('%' + SQLHistoryPhrase + '%');
  taSqlHistoryBrowse.Filter := s;
  taSqlHistoryBrowse.Filtered := taSqlHistoryBrowse.Filter <> '';
end;

procedure TfrmQueryBrowser.acQueryCopyToTableExecute(Sender: TObject);
var
  TableName: String;
  CopyBlobs : Boolean;
  Table : TnxTable;
begin
  if ShowCopyTableDlg(FDatabase, '', FConnection.FQuery,
                      TableName, CopyBlobs) = mrOK then begin
    Table := TnxTable.Create(nil);
    try
      Screen.Cursor := crHourGlass;
      Table.Database := FConnection.Query.Database;
      Table.TableName := TableName;
      Table.Open;
      Table.Timeout := FConnection.FQuery.Timeout;
      Table.CopyRecords(FConnection.FQuery, CopyBlobs);
    finally
      Screen.Cursor := crDefault;
      Table.Close;
      Table.Free;
      { force the second table to close if it wasn't open before }
//      FConnection.Query.Session.CloseInactiveTables;
    end;
  end;
end;

procedure TfrmQueryBrowser.acQueryPrintPreviewExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeReportEngine}
  { reports can use the default components }
  FConnection.Query.Session.Default := True;
  FConnection.Query.Database.Default := True;
  SingleQueryReport(FConnection.Query);
  {$ENDIF}
end;

procedure TfrmQueryBrowser.acQueryDesignReportExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeReportEngine}
  { reports can use the default components }
  FConnection.Query.Session.Default := True;
  FConnection.Query.Database.Default := True;
  DesignReport(Database);
  {$ENDIF}
end;

procedure TfrmQueryBrowser.acViewShowBlobFieldsExecute(Sender: TObject);
begin
  inherited;
  frmMain.acQueryViewShowBLOBFields.Checked := not frmMain.acQueryViewShowBLOBFields.Checked;

  paBottom.Visible := frmMain.acQueryViewShowBLOBFields.Checked and (pcBlobFields.PageCount > 0);

  splGridAndPageControl.Visible := frmMain.acQueryViewShowBLOBFields.Checked and (pcBlobFields.PageCount > 0);
  if frmMain.acQueryViewShowBLOBFields.Checked and (pcBlobFields.PageCount > 0) then
    ViewActiveBlobField
  else
    DisplayBLOBSize(nil);
end;

procedure TfrmQueryBrowser.acQueryOptionsLiveDatasetExecute(Sender: TObject);
begin
  { Switch on/off requesting live datasets. }
  frmMain.acQueryOptionsLiveDataset.Checked := not frmMain.acQueryOptionsLiveDataset.Checked;
  FConnection.RequestLive := frmMain.acQueryOptionsLiveDataset.Checked;
end;

procedure TfrmQueryBrowser.acQueryOptionsPropertiesExecute(Sender: TObject);
var
  OptionsDlg  : TdlgSQLOptions;
begin
  {displays a set of options for the sql window and current query}
  OptionsDlg := TdlgSQLOptions.Create(Self);
  with OptionsDlg do begin
    SyntaxOnly := FSyntaxCheckOnly;
    with FConnection.Query do begin
      OptionsDlg.Timeout := Timeout;
      RequestLiveDS := frmMain.acQueryOptionsLiveDataset.Checked;
      QueryFont := SQLEditor.Font;
      BeepAfterExecute := FConnection.BeepAfterExecute;
      CancelableQuery := FConnection.CancelableQuery;
      LowPriorityAfter := FConnection.LowPriorityAfter;
      GlobalTimeout := FConfig.GlobalTimeout;
      GlobalRequestLiveDS := FConfig.GlobalRequestLive;
      GlobalBeepAfterExecute := FConfig.GlobalBeepAfterExecute;
      GlobalCancelableQuery := FConfig.GlobalCancelableQuery;
      GlobalLowPriorityAfter := FConfig.GlobalLowPriorityAfter;
      GlobalInsertLogStatement := FConfig.GlobalViewLog;
      try
        if ShowModal = mrOK then begin
          Timeout := OptionsDlg.Timeout;
          if not Active then
            RequestLive := RequestLiveDS;
          FConnection.RequestLive := RequestLiveDS;
          frmMain.acQueryOptionsLiveDataset.Checked := RequestLiveDS;
          SQLEditor.Font.Name := QueryFont.Name;
          SQLEditor.Font.Size := QueryFont.Size;
          FSyntaxCheckOnly := SyntaxOnly;
          FConnection.BeepAfterExecute := BeepAfterExecute;
          FConnection.CancelableQuery := CancelableQuery;
          FConnection.LowPriorityAfter := LowPriorityAfter;
          FConfig.GlobalTimeout := GlobalTimeout;
          FConfig.GlobalRequestLive := GlobalRequestLiveDS;
          FConfig.GlobalBeepAfterExecute := GlobalBeepAfterExecute;
          FConfig.GlobalCancelableQuery := GlobalCancelableQuery;
          FConfig.GlobalLowPriorityAfter := GlobalLowPriorityAfter;
          FConfig.GlobalViewLog := GlobalInsertLogStatement;
          SavePreferences;
          SaveFontPreferences;
        end;
      finally
        OptionsDlg.Free;
      end;
    end;
  end;
end;

procedure TfrmQueryBrowser.UpdateDisplay;
begin
  if FBeforeInitDone then
    Exit;

  if frmMain.acGlobalOptionsRecNoSupport.Checked then
    StatusBar.Panels[iPanelRecNo].Text := Format('RecNo: %s', [nxCommaizeChL(FConnection.Query.RecNo, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)])
  else
    StatusBar.Panels[iPanelRecordCount].Text := '';

  if Config.UsePlainGrid then
    PlainDataGrid.ReadOnly := FReadOnly or not FConnection.Query.CanModify
  else
    cxGrid1DBTableView1.OptionsData.Editing := not (FReadOnly or not FConnection.Query.CanModify);
  SetTabSheetsReadOnly(FReadOnly or not FConnection.Query.CanModify);
end;

procedure TfrmQueryBrowser.acViewLogExecute(Sender: TObject);
begin
  frmMain.acQueryViewLog.Checked := not frmMain.acQueryViewLog.Checked;
  SetLogVisible(frmMain.acQueryViewLog.Checked);
end;

procedure TfrmQueryBrowser.SetLogVisible(aVisible : Boolean);
begin
  meSQLLog.Visible := aVisible;
  splQueryAndLog.Visible := aVisible;
  { add log switch if necessary }
  if aVisible then
    if Pos(nxc_LogStatement, SQLEditor.Text) <= 0 then begin
      SQLEditor.Lines.Insert(0, nxc_LogStatement);
      SQLEditor.Lines.Insert(1, '');
    end;
end;

procedure TfrmQueryBrowser.acQueryFindExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

procedure TfrmQueryBrowser.acQueryFindNextExecute(Sender: TObject);
begin
  DoSearchReplaceText(fSearchWasReplace, fSearchBackwards, True);
end;

procedure TfrmQueryBrowser.acQueryGotoBookmarkExecute(Sender: TObject);
begin
  SQLEditor.GotoBookMark((Sender as TAction).Tag);
end;

procedure TfrmQueryBrowser.acQueryGotoBookmarkUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := SQLEditor.IsBookmark((Sender as TAction).Tag);
end;

procedure TfrmQueryBrowser.acQueryCopyToTableUpdate(Sender: TObject);
begin
  inherited;
  frmMain.acQueryCopyToTable.Enabled := FConnection.Query.Active;
end;

procedure TfrmQueryBrowser.FormShow(Sender: TObject);
begin
  inherited;

  FBeforeInitDone := False;
  dtShown := True;
  FReadOnly := frmMain.acGlobalOptionsReadonlyDatasets.Checked;
  SetLogVisible(frmMain.acQueryViewLog.Checked);
  if TdxDockPanel(Parent) = dxDockingController.ActiveDockControl then
    SQLEditor.SetFocus;
  SQLEditor.WordWrap := False;

  UpdateLookAndFeel;
  PostMessage(Handle, WM_Restore_Settings, 0, 0);
end;

procedure TfrmQueryBrowser.UpdateLookAndFeel;
var
  APainterInfo: TdxSkinLookAndFeelPainterInfo;
  ASkin: TdxSkin;
  AGroup: TdxSkinControlGroup;
  AProperty: TdxSkinProperty;
begin
  if RootLookAndFeel.Painter.GetPainterData(APainterInfo) then
  begin
    ASkin := APainterInfo.Skin;
    //Find an element group
    if ASkin.GetGroupByName('Editors', AGroup) then
    begin
      if AGroup.GetPropertyByName(sdxSkinsEditorBackgroundColor, AProperty) then
        if AProperty is TdxSkinColor then
          SQLEditor.Color := (AProperty as TdxSkinColor).Value;
      if AGroup.GetPropertyByName(sdxSkinsEditorTextColor, AProperty) then
        if AProperty is TdxSkinColor then
          SQLEditor.Font.Color := (AProperty as TdxSkinColor).Value;
    end;
  end;

  if ((SQLEditor.Color and $FF) + ((SQLEditor.Color shr 8) and $FF) + ((SQLEditor.Color shr 16) and $FF)) / 3 >= $80  then
    SQLEditor.Highlighter := SynSQLSynLight
  else
    SQLEditor.Highlighter := SynSQLSynDark;

  SQLEditor.Gutter.Color := SQLEditor.Color;
  SQLEditor.Gutter.Font.Color := SQLEditor.Font.Color;
end;

function TfrmQueryBrowser.GetDefaultRequestLive : Boolean;
begin
  Result := FConfig.GlobalRequestLive;
end;

procedure TfrmQueryBrowser.acQueryPrevStatementExecute(Sender: TObject);
begin
  AddToSqlHistory(SQLEditor.Text, False);
  if not taSqlHistoryBrowse.Bof then
    if fFirstHistoryMoveDone then
      taSqlHistoryBrowse.Prior;
  SQLEditor.Text := taSqlHistoryBrowseSQL.AsString;
  SQLEditor.ResetModificationIndicator;
  FConnection.LastQueryText := SQLEditor.Text; //instead of taSqlHistoryBrowseSQL.AsString because editor may add extra lineshift
  fFirstHistoryMoveDone := True;
end;

procedure TfrmQueryBrowser.acQueryPrintPreviewUpdate(Sender: TObject);
begin
  if Assigned(FConnection) then
    frmMain.acQueryPrintPreview.Enabled := FConnection.Query.Active;
end;

procedure TfrmQueryBrowser.acQueryQueryBuilderExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeActiveQueryBuilder}
  with TdlgQueryBuilder.Create(Self) do try
    InitSql := SQLEditor.Text;
    acNexusDBMetadataProvider1.Connection := Database;
    if ShowModal = mrOK then begin
      SQLEditor.Text := meSQL.Text;
      SQLEditor.ResetModificationIndicator;
    end;
  finally
    Free;
  end
  {$ENDIF}
end;

procedure TfrmQueryBrowser.acQueryQueryBuilderUpdate(Sender: TObject);
begin
  {$IFNDEF EMIncludeActiveQueryBuilder}
  frmMain.acQueryQueryBuilder.Enabled := False;
  {$ENDIF}
end;

procedure TfrmQueryBrowser.acQueryReplaceExecute(Sender: TObject);
begin
  ShowSearchReplaceDialog(TRUE);
end;

procedure TfrmQueryBrowser.acViewRefreshExecute(Sender: TObject);
begin
  acQueryExecuteExecute(Sender, False);
end;

procedure TfrmQueryBrowser.DoSearchReplaceText(AReplace, ABackwards, aFindNext: boolean);
var
  Options: TSynSearchOptions;
begin
  Statusbar.Panels[0].Text := '';
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if fSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if (not aFindNext) and (not fSearchFromCaret) then
    Include(Options, ssoEntireScope);
  if fSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if fSearchWholeWords then
    Include(Options, ssoWholeWord);
  if fSearchRegex then
    SQLEditor.SearchEngine := SynEditRegexSearch
  else
    SQLEditor.SearchEngine := SynEditSearch;
  SQLEditor.BeginUpdate;
  try
    if SQLEditor.SearchReplace(fSearchText, fReplaceText, Options) = 0 then
    begin
      MessageBeep(MB_ICONASTERISK);
      Statusbar.Panels[0].Text := rsTextNotFound;
      if ssoBackwards in Options then
        SQLEditor.BlockEnd := SQLEditor.BlockBegin
      else
        SQLEditor.BlockBegin := SQLEditor.BlockEnd;
      SQLEditor.CaretXY := SQLEditor.BlockBegin;
    end;
  finally
    SQLEditor.EndUpdate;
  end;
  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure TfrmQueryBrowser.acQueryNextStatementExecute(Sender: TObject);
begin
  AddToSqlHistory(SQLEditor.Text, False);
  if not taSqlHistoryBrowse.Eof then
    if fFirstHistoryMoveDone then
      taSqlHistoryBrowse.Next;
  SQLEditor.Text := taSqlHistoryBrowseSQL.AsString;
  SQLEditor.ResetModificationIndicator;

  FConnection.LastQueryText := SQLEditor.Text; //instead of taSqlHistoryBrowseSQL.AsString because editor may add extra lineshift
  fFirstHistoryMoveDone := True;
end;

procedure TfrmQueryBrowser.DisplayRecNo;
begin
  if frmMain.acGlobalOptionsRecNoSupport.Checked then
    StatusBar.Panels[iPanelRecNo].Text := Format('RecNo: %s', [nxCommaizeChL(FConnection.Query.RecNo, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator)])
  else
    StatusBar.Panels[iPanelRecNo].Text := 'RecNo:';
end;

procedure TfrmQueryBrowser.acViewShowRecordCountExecute(Sender: TObject);
begin
  with frmMain.acQueryViewShowRecordCount do begin
    Checked := not Checked;
    if Checked and
       FConnection.Query.Active then
      StatusBar.Panels[iPanelRecordCount].Text := rsRecordCount +
                                                  nxCommaizeChL(FConnection.Query.RecordCount, {$IFDEF DCC17OrLater}FormatSettings.{$ENDIF}ThousandSeparator);
    LocalShowRecordCount := Checked;
  end;
end;

procedure TfrmQueryBrowser.acQuerySetFieldtoNULLExecute(Sender: TObject);
var
  DoPost : Boolean;
  FieldIdx : Integer;
begin
    { set field to NULL? }
  if (((not Config.UsePlainGrid and cxGrid1DBTableView1.OptionsData.Editing) or
       (Config.UsePlainGrid and not PlainDataGrid.ReadOnly)) and
      (not FConnection.Query.IsEmpty)) then begin
    DoPost := not (FConnection.Query.State in [dsInsert, dsEdit]);
    if DoPost then
      FConnection.Query.Edit;
    if Config.UsePlainGrid then begin
      if Assigned(PlainDataGrid.SelectedField) then
        PlainDataGrid.SelectedField.Value := NULL;
    end
    else
      if Assigned(cxGrid1DBTableView1.Controller.FocusedColumn) and
         Assigned(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding) and
         Assigned((cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding as TcxGridItemDBDataBinding).Field) then
        TcxGridItemDBDataBinding(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding).Field.Value := NULL;
    if DoPost then
      FConnection.Query.Post;
    { refresh if blobfield }
    if Config.UsePlainGrid then
      FieldIdx := FConnection.Query.TableDescriptor.GetFieldFromName(PlainDataGrid.SelectedField.FieldName)
    else
      FieldIdx := FConnection.Query.TableDescriptor.GetFieldFromName(TcxGridItemDBDataBinding(cxGrid1DBTableView1.Controller.FocusedColumn.DataBinding).FieldName);
    if FConnection.Query.TableDescriptor.FieldsDescriptor.FieldDescriptor[FieldIdx].fdType in [nxtBlob..nxtBLOBGraphic] then
      ViewActiveBlobField;
  end;
end;

{ TnxQueryWorkerThread }

procedure TnxQueryWorkerThread.InnerExecute;
var
  aTime: Cardinal;
begin
  while not Assigned(OnTerminate) do
    Sleep(1);
  // make sure the thread gets freed on termination
  FreeOnTerminate:=true;
  try
    try
      aTime := getTickCount;
      try
        qwtSQLConnection.Query.Open;
      finally
        aTime := getTickCount-aTime;
        qwtSQLConnection.ExecutionTime := aTime;
      end;
    except
      qwtSQLConnection.QueryException := AcquireExceptionObject;
    end;
  finally
    qwtSQLConnection.FInQuery := False;
  end;
end;

constructor TnxQueryWorkerThread.Create(aThreadPriority   : TThreadPriority;
                                        aSQLConnection    : TnxSQLConnection;
                                        aOnTerminate      : TNotifyEvent);
begin
  inherited Create(aThreadPriority);
  qwtSQLConnection := aSQLConnection;
  OnTerminate := aOnTerminate;
end;

initialization
  NumQueryBrowsersTotal  := 0;
  LastQueryBrowserNum    := 0;
end.


