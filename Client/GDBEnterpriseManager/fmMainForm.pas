{##############################################################################}
{# NexusDB Enterprise Manager: fmMainForm.pas 4.7001                         #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Main Form                                      #}
{##############################################################################}

{$I nxemDefine.inc}

unit fmMainForm;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

{ menu groupindexes:

  window    menuitem  index
  -------------------------
  mainform: File:           0
  mainform: Edit:           1

  Servers : Servers:        2

  Tablebrowser: Table:      3
  tablebrowser: View:       4
  tablebrowser: Options:    5

  querybrowser: Query:      2
  querybrowser: View:       3
  querybrowser: Connection: 4
  querybrowser: Options:    5

  mainform: Global Options: 7
  mainform: Window:         8
  mainform: Help:           9
}

uses
{$IFDEF NX_EXCEPTION_LOG}
  nxExceptionHook,
{$ENDIF}
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  DB,
  Types,
  UITypes,
  Messages,
  SysUtils,
  Forms,
  Dialogs,
  Menus,
  ComCtrls,
  ToolWin,
  Graphics,
  ExtCtrls,
  StdActns,
  Classes,
  ActnList,
  ImgList,
  Controls,
  StdCtrls,
  AppEvnts,
  Actions,
  System.Notification,

  cxLookAndFeels,
  dxBarDBNav,
  dxDockControl,
  dxBar,
  cxGrid,
  dxBarExtItems,
  dxDockPanel,
  cxClasses,
  cxPC,
  cxControls,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinsForm,
  dxSkinChooserGallery,
  dxBarSkinnedCustForm, dxSkinsdxBarPainter,
  dxSkinscxPCPainter, dxRibbonGallery,
  cxGraphics,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxTreeView, dxSkinBasic, dxSkinOffice2019Black, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White,
  dxForms, unScaledForm, 
  cxStyles, 
  dxCore,

  nxllTransport,
  nxchCommandHandler,
  nxdb,
  nxsdServerEngine,
  nxsrServerEngine,
  nxsrSqlEngineBase,
  nxsqlEngine,
  nxllComponent,
  nxlgEventLog,
  fmQueryBrowser, 
  GestwinSkin, 
  GestwinWhiteSkin, 
  System.ImageList,
  cxImageList;

type
  TfrmMain = class(TdxScaledForm)
    dlgPrinterSetup: TPrinterSetupDialog;
    logMain: TnxEventLog;
    ActionList1: TActionList;
    acHelpContents: THelpContents;
    acGlobalOptionsDefaultTimeout: TAction;
    acHelpAbout: TAction;
    acHelpNexusDBWebSite: TAction;
    acHelpNexusDBNewsgroups: TAction;
    acFileExit: TAction;
    acFilePrintSetup: TAction;
    acGlobalOptimisticRecordlocks: TAction;
    acGlobalOptionsHeartbeatFrequency: TAction;
    acEditCut: TEditCut;
    acEditCopy: TEditCopy;
    acEditPaste: TEditPaste;
    acEditSelectAll: TEditSelectAll;
    acEditUndo: TEditUndo;
    dxDockingManager: TdxDockingManager;
    dxBarManager: TdxBarManager;
    mnuFilePrintSetup: TdxBarButton;
    mnuFileExit: TdxBarButton;
    mnuFile: TdxBarSubItem;
    mnuEditUndo: TdxBarButton;
    mnuEditCut: TdxBarButton;
    mnuEditCopy: TdxBarButton;
    mnuEditPaste: TdxBarButton;
    mnuEditSelectAll: TdxBarButton;
    Edit1: TdxBarSubItem;
    mnuGlobalOptionsReadonlyDatasets: TdxBarButton;
    mnuGlobalOptionsDefaultTimeout: TdxBarButton;
    mnuGlobalOptionsOptimisticRecordlocks: TdxBarButton;
    mnuGlobalOptionsHeartbeatFrequency: TdxBarButton;
    mnuOptions: TdxBarSubItem;
    mnuWindow: TdxBarSubItem;
    mnuHelpContents: TdxBarButton;
    mnuHelpWebSite: TdxBarButton;
    mnuHelpNewsgroups: TdxBarButton;
    mnuHelpAbout: TdxBarButton;
    mnuHelp: TdxBarSubItem;
    dxDockSiteMain: TdxDockSite;
    dpServer: TdxDockPanel;
    cxLookAndFeelController: TcxLookAndFeelController;
    acQueryExecute: TAction;
    acQuerySave: TAction;
    acQueryOpen: TAction;
    acQueryParameterValues: TAction;
    acQueryCopyToTable: TAction;
    acQueryPrintPreview: TAction;
    acQueryDesignReport: TAction;
    acQueryFind: TAction;
    acQueryViewShowBlobFields: TAction;
    acQueryViewRefresh: TAction;
    acQueryViewLog: TAction;
    acQueryNextStatement: TAction;
    acQueryPrevStatement: TAction;
    acQueryOptionsLiveDataset: TAction;
    acQueryOptionsProperties: TAction;

    mnuQuery: TdxBarSubItem;
    mnuQueryExecute: TdxBarButton;
    mnuQueryOpenScript: TdxBarButton;
    mnuQuerySaveScript: TdxBarButton;
    meQueryFind: TdxBarButton;
    mnuQueryParamValues: TdxBarButton;
    mnuQueryCopyToTable: TdxBarButton;
    mnuQueryPrintPreview: TdxBarButton;
    mnuQueryDesignReport: TdxBarButton;
    mnuQueryView: TdxBarSubItem;
    mnuQueryViewShowBLOBFields: TdxBarButton;
    mnuQueryViewLog: TdxBarButton;
    mnuQueryViewRefresh: TdxBarButton;
    mnuQueryConnection: TdxBarSubItem;
    mnuQueryConnectionNew: TdxBarButton;
    mnuQueryConnectionRemove: TdxBarButton;
    mnuQueryConnectionNext: TdxBarButton;
    mnuQueryConnectionPrev: TdxBarButton;
    mnuQueryOptions: TdxBarSubItem;
    mnuQueryOptionsLiveDataset: TdxBarButton;
    mnuQueryOptionsProperties: TdxBarButton;
    mnuOptionsDebugLog: TdxBarButton;

    acServersRefresh: TAction;
    acServersRegister: TAction;
    acServersSQL: TAction;
    mnuServerRefresh: TdxBarButton;
    mnuServerRegister: TdxBarButton;
    meServersSQL: TdxBarButton;
    mnuServers1: TdxBarSubItem;

    mnuTable: TdxBarSubItem;
    mnuTableView: TdxBarSubItem;
    mnuTableViewRefresh: TdxBarButton;
    mnuTableViewShowRecordCount: TdxBarButton;
    mnuTableViewShowFilter: TdxBarButton;
    mnuTableResetCol: TdxBarButton;
    mnuTableOptions: TdxBarSubItem;
    mnuTableOptionsDebugLog: TdxBarButton;
    mnuTableOptionsTimeout: TdxBarButton;

    mnuTableViewShowRange: TdxBarButton;
    mnuTableViewShowBLOBFields: TdxBarButton;
    mnuTablePrintPreview: TdxBarButton;
    mnuTableDesignReport: TdxBarButton;

    mnuTableCopyToTable: TdxBarButton;
    mnuTableDeleteRecords: TdxBarButton;
    mnuTableSetFieldtoNULL: TdxBarButton;
    mnuTableNextTable1: TdxBarButton;

    acTableResetColumns: TAction;
    acTableSetFieldtoNULL: TAction;
    acTableNextTable: TAction;
    acTableCopyToTable: TAction;
    acTableDeleteRecords: TAction;
    acTablePrintPreview: TAction;
    acTableDesignReport: TAction;
    acTableViewShowFilter: TAction;
    acTableViewShowRange: TAction;
    acTableViewShowBLOBFields: TAction;
    acTableViewShowRecordCount: TAction;
    acTableViewRefresh: TAction;
    acTableOptionsDebugLog: TAction;
    acTableOptionsTimeout: TAction;

    dxLayoutDockSite1: TdxLayoutDockSite;
    acGlobalOptionsReadonlyDatasets: TAction;
    dxBarButton4: TdxBarButton;
    tiStartup: TTimer;
    acGlobalOptionsRecNoSupport: TAction;
    mnuGlobalOptionsRecNoSupport: TdxBarButton;
    mnuGlobalOptionsRuntimeLoadedPackages: TdxBarButton;
    pmTabContainerList: TPopupMenu;
    acGlobalOptionsCloseActiveWindow: TAction;
    ApplicationEvents1: TApplicationEvents;
    acGlobalOptionsDisplayMilliseconds: TAction;
    mnuGlobalOptionsDisplayMilliseconds: TdxBarButton;
    mnuServer: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    acGlobalOptionsUsePlainGrid: TAction;
    mnuGlobalOptionsUsePlainGrid: TdxBarButton;
    acQueryViewShowRecordCount: TAction;
    mnuQueryViewShowRecordCount: TdxBarButton;
    tiCloseLostComm: TTimer;
    meQueryReplace: TdxBarButton;
    acQueryReplace: TAction;
    dxBarSeparator1: TdxBarSeparator;
    meGotoBookmarks: TdxBarSubItem;
    meToggleBookmarks: TdxBarSubItem;
    meToggleBookmark1: TdxBarButton;
    meToggleBookmark2: TdxBarButton;
    meToggleBookmark3: TdxBarButton;
    meToggleBookmark4: TdxBarButton;
    meToggleBookmark5: TdxBarButton;
    meToggleBookmark6: TdxBarButton;
    meToggleBookmark7: TdxBarButton;
    meToggleBookmark8: TdxBarButton;
    meToggleBookmark9: TdxBarButton;
    meGotoBookmark0: TdxBarButton;
    meGotoBookmark1: TdxBarButton;
    meGotoBookmark2: TdxBarButton;
    meGotoBookmark3: TdxBarButton;
    meGotoBookmark4: TdxBarButton;
    meGotoBookmark5: TdxBarButton;
    meGotoBookmark6: TdxBarButton;
    meGotoBookmark7: TdxBarButton;
    meGotoBookmark8: TdxBarButton;
    meGotoBookmark9: TdxBarButton;
    meClearBookmarks: TdxBarButton;
    acQueryToggleBookmark0: TAction;
    acQueryToggleBookmark1: TAction;
    acQueryToggleBookmark2: TAction;
    acQueryToggleBookmark3: TAction;
    acQueryToggleBookmark4: TAction;
    acQueryToggleBookmark5: TAction;
    acQueryToggleBookmark6: TAction;
    acQueryToggleBookmark7: TAction;
    acQueryToggleBookmark8: TAction;
    acQueryToggleBookmark9: TAction;
    acQueryGotoBookmark0: TAction;
    acQueryGotoBookmark1: TAction;
    acQueryGotoBookmark2: TAction;
    acQueryGotoBookmark3: TAction;
    acQueryGotoBookmark4: TAction;
    acQueryGotoBookmark5: TAction;
    acQueryGotoBookmark6: TAction;
    acQueryGotoBookmark7: TAction;
    acQueryGotoBookmark8: TAction;
    acQueryGotoBookmark9: TAction;
    acQueryClearBookmarks: TAction;
    tiActivateQueryEdit: TTimer;
    mnuServersBroadcastForServers: TdxBarButton;
    acServersBroadcastForServers: TAction;
    dxBarSeparator2: TdxBarSeparator;
    mnuHelpOpenLogFolder: TdxBarButton;
    acHelpOpenLogFolder: TAction;
    mnuQueryConnectionSqlHistoryOptions: TdxBarButton;
    acQuerySqlHistoryOptions: TAction;
    mnuGlobalOptionsReloadLastSql: TdxBarButton;
    acGlobalOptionsReloadLastSql: TAction;
    mnuGlobalOptionsCloseInactiveFolders: TdxBarButton;
    acGlobalOptionsAllowCloseInactiveCalls: TAction;
    dxbsServerName: TdxBarStatic;
    dxbsDatabaseName: TdxBarStatic;
    dxbsRunAt: TdxBarStatic;
    dxBarSeparator3: TdxBarSeparator;
    mnuServersServerList: TdxBarButton;
    acServersActivateServerList: TAction;
    mnuTableViewUseGridMode: TdxBarButton;
    acTableViewUseGridMode: TAction;
    acQueryViewUseGridMode: TAction;
    mnuQueryViewUseGridMode: TdxBarButton;
    mnuGlobalOptionsUseLongTabDescription: TdxBarButton;
    acGlobalOptionsUseLongTabDescription: TAction;
    acGlobalOptionsNewTableDefaults: TAction;
    mnuGlobalOptionsNewTableDefaults: TdxBarButton;
    dxBarLargeButton1: TdxBarButton;
    mnuGlobalOptionsAutoTreeRefresh: TdxBarButton;
    acGlobalOptionsAutoTreeRefresh: TAction;
    acGlobalOptionsUseLargeToolbarGlyphs: TAction;
    dxBarLargeButton2: TdxBarButton;
    dxBarLargeButton3: TdxBarButton;
    dxBarButton3: TdxBarButton;
    acQuerySyntaxCheck: TAction;
    dxBarSeparator4: TdxBarSeparator;
    mnuQuerySyntaxCheck: TdxBarButton;
    NotificationCenter1: TNotificationCenter;
    acQueryQueryBuilder: TAction;
    mnuQueryQueryBuilder: TdxBarButton;
    tbNewUpdate: TdxBar;
    acUpdateNewUpdate: TAction;
    bbNewUpdate: TdxBarButton;
    tiUpdateCheck: TTimer;
    dxSkinController: TdxSkinController;
    dxSkinChooserGalleryItem: TdxSkinChooserGalleryItem;
    dxBarSeparator5: TdxBarSeparator;
    FontDialog: TFontDialog;
    acGlobalOptionsChooseFont: TAction;
    dxBarButton5: TdxBarButton;
    cxStyleRepository: TcxStyleRepository;
    cxsUpdateStyle: TcxStyle;
    meQueryFindNext: TdxBarButton;
    acQueryFindNext: TAction;
    ImageList: TcxImageList;

    procedure FormCreate(Sender: TObject);
    procedure acGlobalOptionsReadonlyDatasetsMenuExecute(Sender: TObject);
    procedure acGlobalOptionsDefaultTimeoutExecute(Sender: TObject);
    procedure acHelpContentsExecute(Sender: TObject);
    procedure acHelpNexusDBWebSiteExecute(Sender: TObject);
    procedure acHelpNexusDBNewsgroupsExecute(Sender: TObject);
    procedure acHelpAboutExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure acFileExitUpdate(Sender: TObject);
    procedure acFilePrintSetupExecute(Sender: TObject);
    procedure acFilePrintSetupUpdate(Sender: TObject);
    procedure acFileExitExecute(Sender: TObject);
    procedure acGlobalOptimisticRecordlocksExecute(Sender: TObject);
    procedure acGlobalOptionsHeartbeatFrequencyExecute(Sender: TObject);
    procedure acEditSelectAllExecute(Sender: TObject);
    procedure acEditCutExecute(Sender: TObject);
    procedure acEditCopyExecute(Sender: TObject);
    procedure acEditUndoExecute(Sender: TObject);
    procedure acEditCutUpdate(Sender: TObject);
    procedure acEditCopyUpdate(Sender: TObject);
    procedure acEditPasteUpdate(Sender: TObject);
    procedure acEditSelectAllUpdate(Sender: TObject);
    procedure acEditUndoUpdate(Sender: TObject);
    procedure dpServerCloseQuery(Sender: TdxCustomDockControl;
      var CanClose: Boolean);
    procedure acQueryNextStatementExecute(Sender: TObject);
    procedure acQueryPrevStatementExecute(Sender: TObject);
    procedure acQueryExecuteExecute(Sender: TObject);
    procedure acQuerySaveExecute(Sender: TObject);
    procedure acQueryOpenExecute(Sender: TObject);
    procedure acQueryParameterValuesExecute(Sender: TObject);
    procedure acQueryCopyToTableExecute(Sender: TObject);
    procedure acQueryPrintPreviewExecute(Sender: TObject);
    procedure acQueryDesignReportExecute(Sender: TObject);
    procedure acQueryFindExecute(Sender: TObject);
    procedure acQueryOptionsLiveDatasetExecute(Sender: TObject);
    procedure acQueryOptionsPropertiesExecute(Sender: TObject);
    procedure acQueryViewShowBlobFieldsExecute(Sender: TObject);
    procedure acQueryViewRefreshExecute(Sender: TObject);
    procedure acQueryViewLogExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acServersRefreshExecute(Sender: TObject);
    procedure acServersRegisterExecute(Sender: TObject);
    procedure acServersSQLExecute(Sender: TObject);
    procedure acServersSQLUpdate(Sender: TObject);
    procedure acTableResetColumnsExecute(Sender: TObject);
    procedure acTableSetFieldtoNULLExecute(Sender: TObject);
    procedure acTableNextTableExecute(Sender: TObject);
    procedure acTableCopyToTableExecute(Sender: TObject);
    procedure acTableDeleteRecordsExecute(Sender: TObject);
    procedure acTablePrintPreviewExecute(Sender: TObject);
    procedure acTableDesignReportExecute(Sender: TObject);
    procedure acTableOptionsDebugLogExecute(Sender: TObject);
    procedure acTableOptionsTimeoutExecute(Sender: TObject);
    procedure acTableViewShowFilterExecute(Sender: TObject);
    procedure acTableViewShowRangeExecute(Sender: TObject);
    procedure acTableViewShowBLOBFieldsExecute(Sender: TObject);
    procedure acTableViewShowRecordCountExecute(Sender: TObject);
    procedure acTableViewRefreshExecute(Sender: TObject);
    procedure tiStartupTimer(Sender: TObject);
    procedure acGlobalOptionsRecNoSupportExecute(Sender: TObject);
    procedure mnuGlobalOptionsRuntimeLoadedPackagesClick(Sender: TObject);
    procedure ArrangeBarsButtonClick(Sender: TObject);
    procedure dxDockingManagerCreateTabContainer(
      Sender: TdxCustomDockControl;
      ATabContainer: TdxTabContainerDockSite);
    procedure acGlobalOptionsCloseActiveWindowExecute(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure dpServerEndDocking(Sender: TdxCustomDockControl;
      Zone: TdxZone; X, Y: Integer);
    procedure dxDockingManagerActiveDockControlChanged(Sender: TObject);
    procedure acGlobalOptionsDisplayMillisecondsExecute(Sender: TObject);
    procedure acQueryNextStatementUpdate(Sender: TObject);
    procedure acQueryPrevStatementUpdate(Sender: TObject);
    procedure acGlobalOptionsUsePlainGridExecute(Sender: TObject);
    procedure acQueryViewShowRecordCountExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tiCloseLostCommTimer(Sender: TObject);
    procedure acQueryReplaceExecute(Sender: TObject);
    procedure acQueryToggleBookmark0Execute(Sender: TObject);
    procedure acQueryGotoBookmark0Execute(Sender: TObject);
    procedure acQueryClearBookmarksExecute(Sender: TObject);
    procedure acQueryToggleBookmark0Update(Sender: TObject);
    procedure acQueryGotoBookmark0Update(Sender: TObject);
    procedure acQueryClearBookmarksUpdate(Sender: TObject);
    procedure meToggleBookmark9Click(Sender: TObject);
    procedure tiActivateQueryEditTimer(Sender: TObject);
    procedure acServersBroadcastForServersExecute(Sender: TObject);
    procedure acHelpOpenLogFolderExecute(Sender: TObject);
    procedure acQuerySqlHistoryOptionsExecute(Sender: TObject);
    procedure acQuerySqlHistoryOptionsUpdate(Sender: TObject);
    procedure acGlobalOptionsReloadLastSqlExecute(Sender: TObject);
    procedure acEditPasteExecute(Sender: TObject);
    procedure acQueryPrintPreviewUpdate(Sender: TObject);
    procedure acServersActivateServerListExecute(Sender: TObject);
    procedure acQueryViewUseGridModeExecute(Sender: TObject);
    procedure acTableViewUseGridModeExecute(Sender: TObject);
    procedure acTableViewUseGridModeUpdate(Sender: TObject);
    procedure acQueryViewUseGridModeUpdate(Sender: TObject);
    procedure acTableViewShowFilterUpdate(Sender: TObject);
    procedure acTableViewShowRangeUpdate(Sender: TObject);
    procedure acTableViewShowBLOBFieldsUpdate(Sender: TObject);
    procedure acTableViewShowRecordCountUpdate(Sender: TObject);
    procedure acQueryViewShowBlobFieldsUpdate(Sender: TObject);
    procedure acQueryViewLogUpdate(Sender: TObject);
    procedure acQueryViewShowRecordCountUpdate(Sender: TObject);
    procedure acGlobalOptionsUseLongTabDescriptionExecute(Sender: TObject);
    procedure acGlobalOptionsNewTableDefaultsExecute(Sender: TObject);
    procedure acGlobalOptionsAutoTreeRefreshExecute(Sender: TObject);
    procedure acGlobalOptionsUseLargeToolbarGlyphsExecute(Sender: TObject);
    procedure acQuerySyntaxCheckExecute(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
    procedure acQueryQueryBuilderUpdate(Sender: TObject);
    procedure acQueryQueryBuilderExecute(Sender: TObject);
    procedure acGlobalOptionsAllowCloseInactiveCallsExecute(Sender: TObject);
    procedure acUpdateNewUpdateExecute(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure tiUpdateCheckTimer(Sender: TObject);
    procedure dxSkinChooserGalleryItemSkinChanged(Sender: TObject;
      const ASkinName: string);
    procedure acGlobalOptionsChooseFontExecute(Sender: TObject);
    procedure dxDockingManagerCreateFloatSite(Sender: TdxCustomDockControl;
      AFloatSite: TdxFloatDockSite);
    procedure dxDockingManagerCreateLayoutSite(
      Sender: TdxCustomDockControl; ALayoutSite: TdxLayoutDockSite);
    procedure dxDockingManagerCreateSideContainer(
      Sender: TdxCustomDockControl;
      ASideContainer: TdxSideContainerDockSite);
    procedure acQueryFindNextExecute(Sender: TObject);
  protected {private}
    StartNotificationTime  : TDateTime;
    AlwaysShowNotification : Boolean;
    NotificationText       : string;

    DisplayUpdateDone      : Boolean;

    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);

    procedure DoDockPanelClose(Sender: TdxCustomDockControl);
    procedure DoTabContainerActiveChildChanged(Sender: TdxContainerDockSite; Child: TdxCustomDockControl);

    procedure TabContainerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure TabContainerMoveTabs(Sender: TObject);
    procedure TabContainerContextPopupItemClicked(Sender: TObject);

    procedure DoShortCut(var Msg: TWMKey; var Handled: Boolean);

    procedure SetSkin(ASkinItem: TdxSkinChooserGalleryGroupItem);
    procedure SetGlobalFont(aChangeScale : Boolean);
    procedure UpdateLookAndFeel;

    procedure Loaded; override;
  public
    DisableShortcut            : Boolean;

    QueryBrowserToActivate     : TfrmQueryBrowser;

    procedure LoadConfig;
    procedure SaveConfig;

    procedure SetCustomEditActions;
    procedure ResetCustomEditActions;

    procedure AddFormToDockPanel(aForm: TForm; aOwner: TdxDockPanel);
    function CreateAndDockDockPanel: TdxDockPanel;
    procedure EnableActiveFormActions(aForm : TForm);
    procedure DockPanelOnActivate(Sender: TdxCustomDockControl; Active: Boolean);

    function IsShortCut(var Message: TWMKey): Boolean; override;

    procedure StartNotificationTiming(const aText : string; aAlwaysShow : Boolean = False);
    procedure StopNotificationTiming;
  end;

var
  frmMain: TfrmMain;

implementation

{$IFDEF CPUX86}
{$R WindowsXP.Res}
{$ENDIF}

{$R *.DFM}

uses
  shellapi,
  Clipbrd,
  IniFiles,
  System.DateUtils,
  Math,

  dxStatusBar,
  dxThreading,
  dxSkinsStrs,
  dxSkinsLookAndFeelPainter,

  SynEdit,
  SynMemo,

  nxllConst,
  nxllUtils,
  nxllTypes,
  nxllMemoryManager,
  nxsdTypes,
  nxseAllEngines,
  nxreRemoteServerEngine,
  nxdbBase,
  unFormList,
  //.. nxemGlyphs,
  nxpvAboutFrm,
  nxptBasePooledTransport,
  nxExeConst,
  fmBaseBrowser,
  fmTreeBrowser,
  fmDictionaryBrowser2,
  fmTableBrowser,
  unConfigInfo,
  unTreeNodeObject,
  dgInputQueryInteger,
  dgSelectRuntimePackages,
  dmMain,
  dgNewTableDefaults,
  unUpdateCheck;

resourcestring
  rsAboutNexusDBEnterpriseManager    = 'About NexusDB Enterprise Manager';
  rsDefaultTimeoutMs                 = 'Default Timeout (ms)';
  rsKeepaliveFrequencyMs             = 'Keepalive Frequency';
  rsNexusDBEnterpriseManager         = 'NexusDB Enterprise Manager';
  rsThereIsOneOrMoreActiveTransactio = 'There is one or more active transactions. Are you sure you want ';
  rsToQuitAndRollbackTheTransactions = 'to quit and Rollback the transactions?';
  rsValue                            = 'Value:';
  rsMoveTabsDown                     = 'Tabs at Bottom';
  rsMoveTabsUp                       = 'Tabs on Top';

const
  csBIN                              = '..\BIN\';
  csLOG                              = '.LOG';

{ TfrmMain }

procedure TfrmMain.LoadConfig;
begin
  { Set window coordinates }
  nxeConfigGetFormPrefs(Name + '.WindowPlacement', Self);
  acGlobalOptionsReadonlyDatasets.Checked := coReadOnlyDatasets in Config.Options;
  acGlobalOptimisticRecordlocks.Checked := Config.OptimisticRecordlocks;
  acGlobalOptionsRecNoSupport.Checked := Config.RecNoSupport;
  acGlobalOptionsDisplayMilliseconds.Checked := Config.DisplayMilliseconds;
  acGlobalOptionsUsePlainGrid.Checked := Config.UsePlainGrid;
  acServersBroadcastForServers.Checked := Config.BroadcastForServers and (not nxFindCmdLineSwitch('NOBROADCAST'));
  acGlobalOptionsReloadLastSql.Checked := Config.ReloadLastSql;
  acGlobalOptionsAutoTreeRefresh.Checked := Config.AutoTreeRefresh;
  acGlobalOptionsUseLargeToolbarGlyphs.Checked := Config.UseLargeToolbarGlyphs;
  dpServer.Width := Config.ServerWindowWidth;
end;
{------------------------------------------------------------------------------}
procedure TfrmMain.SaveConfig;
begin
  with Config do begin
    Options := [];
    if acGlobalOptionsReadonlyDatasets.Checked then
      Options := Options + [coReadOnlyDataSets]
    else
      Options := Options - [coReadOnlyDataSets];
    OptimisticRecordlocks := acGlobalOptimisticRecordlocks.Checked;
    RecNoSupport := acGlobalOptionsRecNoSupport.Checked;
    DisplayMilliseconds := acGlobalOptionsDisplayMilliseconds.Checked;
    UsePlainGrid := acGlobalOptionsUsePlainGrid.Checked;
    ServerWindowWidth := dpServer.Width;
    ReloadLastSql := acGlobalOptionsReloadLastSql.Checked;
    AutoTreeRefresh := acGlobalOptionsAutoTreeRefresh.Checked;
    UseLargeToolbarGlyphs := acGlobalOptionsUseLargeToolbarGlyphs.Checked;
    OriginalHeight := Screen.MonitorFromWindow(Handle).Height;
    OriginalWidth := Screen.MonitorFromWindow(Handle).Width;
    Save;
  end;
  nxeConfigSaveFormPrefs(Name + '.WindowPlacement', Self);
end;
{------------------------------------------------------------------------------}
procedure TfrmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  if (E is EnxDatabaseError) and
     (EnxDatabaseError(E).ErrorCode = $2C0C) then
    tiCloseLostComm.Enabled := True
  else
  if not Application.Terminated then
    Application.ShowException(E);
end;
{------------------------------------------------------------------------------}
procedure TfrmMain.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  TheNotification: TNotification;
begin
  if (not DisplayUpdateDone) and
     (unUpdateCheck.NewVersion > StringReplace(Format('%.4f', [nxVersionNumber / 10000.0]), ',', '.', [rfReplaceAll])) then begin
    DisplayUpdateDone := True;
    acUpdateNewUpdate.Caption := 'New Update: v' + unUpdateCheck.NewVersion + ' released';

    tbNewUpdate.Visible := True;

    if unUpdateCheck.NewVersion > Config.LastUpdateVersion then begin
      if TOSVersion.Major >= 8 then begin
        TheNotification := NotificationCenter1.CreateNotification;
        try
          TheNotification.Name := 'UpdateNotification';
          TheNotification.Title := 'NexusDB Enterprise Manager';
          TheNotification.AlertBody := 'NexusDB Update: v' + unUpdateCheck.NewVersion + ' has been released.';

          NotificationCenter1.PresentNotification(TheNotification);
        finally
          TheNotification.Free;
        end;
      end;
    end;

    Config.LastUpdateVersion := unUpdateCheck.NewVersion;
    Config.LastUpdateCheck := Now;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  { write log to app directory }
  logMain.FileName := Config.WorkingDirectory + ChangeFileExt(ExtractFileName(Application.ExeName), csLOG);
  Application.OnException := ApplicationEvents1Exception;
  Application.OnShortCut := DoShortCut;

  acGlobalOptionsReadonlyDatasets.Checked := False;

  Caption := StringReplace(Format(Caption, [nxVersionNumber / 10000.0]), ',', '.', [rfReplaceAll]);

  acTableSetFieldtoNULL.SecondaryShortCuts.AddObject('Ctrl+VK_NUMPAD0', TObject(Shortcut(VK_NUMPAD0, [ssCtrl])));

  ScalingDone := True;
end;
{------------------------------------------------------------------------------}
procedure TfrmMain.acGlobalOptionsReadonlyDatasetsMenuExecute(Sender: TObject);
var
  Idx : Integer;
begin
  acGlobalOptionsReadonlyDatasets.Checked := not acGlobalOptionsReadonlyDatasets.Checked;

  with Config do
    if acGlobalOptionsReadonlyDatasets.Checked then
      Options := Options + [coReadOnlyDatasets]
    else
      Options := Options - [coReadOnlyDatasets];

  for Idx := 0 to Pred(Screen.FormCount) do
    if Screen.Forms[Idx] is TfrmBaseBrowser then
      with TfrmBaseBrowser(Screen.Forms[Idx]) do begin
        ReadOnly := acGlobalOptionsReadonlyDatasets.Checked;
        UpdateDisplay;
      end;
end;

procedure TfrmMain.acGlobalOptionsDefaultTimeoutExecute(Sender: TObject);
var
  TempTO : Integer;
  Idx : Integer;
begin
  TempTO := Config.DefaultTimeout;

  if InputQueryInteger(rsDefaultTimeoutMs, rsValue, TempTO, -1, MaxInt) then begin
    Config.DefaultTimeout := TempTO;
    { set default timeout on open servers, tables and queries }
    for idx := 0 to Pred(frmTreeBrowser.tvServers.Items.Count) do
      if frmTreeBrowser.GetNodeObject(frmTreeBrowser.tvServers.Items[idx]).NodeType=ntServer then
        frmTreeBrowser.GetNodeObject(frmTreeBrowser.tvServers.Items[idx]).Session.TimeOut := Config.DefaultTimeout;
  end;
end;

procedure TfrmMain.acHelpContentsExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TfrmMain.acHelpNexusDBWebSiteExecute(Sender: TObject);
begin
  ShellToWWW;
end;

procedure TfrmMain.acHelpOpenLogFolderExecute(Sender: TObject);
begin
  {$IFDEF NX_EXCEPTION_LOG_IN_APP_FOLDER}
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName)), nil, nil, SW_SHOWNORMAL);
  {$ELSE}
  ShellExecute(0, 'open', PChar(nxAppHomeDirectory(nxAppDataSubdirVista)), nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfrmMain.acHelpNexusDBNewsgroupsExecute(Sender: TObject);
begin
  ShellToNews;
end;

procedure TfrmMain.acHelpAboutExecute(Sender: TObject);
begin
//caption := font.Size.ToString + ', ' + Getcurrentppi.ToString; exit;
  with TnxAboutFrm.Create(Application) do
  try
    Caption := rsAboutNexusDBEnterpriseManager;
    ProgramName.Caption := rsNexusDBEnterpriseManager;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i           : Integer;
  FormsToFree : array of TForm;
begin
  SaveConfig;
  tbNewUpdate.Visible := False;
  dxBarManager.SaveToRegistry(nxccREG_PRODUCT + nxeRegistrySubKey + '\' + Name + '.' + dxBarManager.Name);
  SetLength(FormsToFree, 0);
  for i := 0 to Pred(Screen.FormCount) do
    if (Screen.Forms[i] is TfrmTableBrowser) or
       (Screen.Forms[i] is TfrmQueryBrowser) or
       (Screen.Forms[i] is TfrmDictionaryBrowser2) then begin
      SetLength(FormsToFree, Succ(Length(FormsToFree)));
      FormsToFree[Pred(Length(FormsToFree))] := Screen.Forms[i];
    end;

  for i := Low(FormsToFree) to High(FormsToFree) do
    if (FormsToFree[i] is TfrmTableBrowser) or
       (FormsToFree[i] is TfrmQueryBrowser) or
       (FormsToFree[i] is TfrmDictionaryBrowser2) then try
      FormsToFree[i].Close;
      FormsToFree[i].Free;
    except
      on EAbort do
        raise;
      on Exception do; //swallow errors; we want to close anyway
    end;
end;

function TfrmMain.IsShortCut(var Message: TWMKey): Boolean;
begin
  if DisableShortcut then
    Result := False
  else
    Result := inherited;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  i : Integer;
begin
  EnableActiveFormActions(nil);

  frmTreeBrowser := TfrmTreeBrowser.Create(dpServer);
  frmTreeBrowser.Parent := dpServer;
  AddFormToDockPanel(frmTreeBrowser, dpServer);

  dxBarManager.LoadFromRegistry(nxccREG_PRODUCT + nxeRegistrySubKey + '\' + Name + '.' + dxBarManager.Name);
  tbNewUpdate.Visible := False;
  //force main menu visible and top row
  with dxBarManager.BarByComponentName('dxBarManagerBar1') do begin
    if not Visible then begin
      Visible := True;
      DockingStyle := dsTop;
      Row := 0;
      for i := 0 to Pred(dxBarManager.Bars.Count) do
        if not SameText(dxBarManager.Bars[i].Name, 'dxBarManagerBar1') and not (dxBarManager.Bars[i] = tbNewUpdate) then
          dxBarManager.Bars[i].Row := dxBarManager.Bars[i].Row + 1;
    end;
  end;
  dxBarManager.UseLargeImagesForLargeIcons := Config.UseLargeToolbarGlyphs;
  dxBarManager.LargeIcons := Config.UseLargeToolbarGlyphs;

  cxLookAndFeelController.NativeStyle := False;
  cxLookAndFeelController.SkinName := Config.SkinName;
  frmTreeBrowser.dxBarManager1.LookAndFeel.SkinName := Config.SkinName;
  frmTreeBrowser.tvServers.Style.LookAndFeel.SkinName := Config.SkinName;
  dxSkinChooserGalleryItem.SelectedSkinName := RootLookAndFeel.Painter.LookAndFeelName;

  tiStartup.Enabled := True;

  LoadConfig;
  frmTreeBrowser.tvServers.SetFocus;
end;


procedure TfrmMain.acFileExitUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := True;
end;

procedure TfrmMain.acFilePrintSetupExecute(Sender: TObject);
begin
//
end;

procedure TfrmMain.acFilePrintSetupUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := True;
end;

procedure TfrmMain.acFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.acGlobalOptimisticRecordlocksExecute(Sender: TObject);
var
  i,
  Dummy      : Integer;
begin
  acGlobalOptimisticRecordlocks.Checked := not acGlobalOptimisticRecordlocks.Checked;

  for i := 0 to Pred(Screen.FormCount) do
    if Screen.Forms[i] is TfrmTableBrowser then
    with TfrmTableBrowser(Screen.Forms[i]) do begin
      if acGlobalOptimisticRecordlocks.Checked and
         Table.TableDescriptor.FieldsDescriptor.HasRecRevField(Dummy) then begin
        Table.Close;
        Table.Options := Table.Options + [dsoOptimisticLocks];
        Table.Open;
      end
      else begin
        Table.Close;
        Table.Options := Table.Options - [dsoOptimisticLocks];
        Table.Open;
      end;
    end;
end;

type
  TnxBasePooledTransportCracker = class(TnxBasePooledTransport);

procedure TfrmMain.acGlobalOptionsHeartbeatFrequencyExecute(Sender: TObject);
var
  TempKF : Integer;
  Idx : Integer;
begin
  TempKF := Config.KeepaliveFrequency;

  if InputQueryInteger(rsKeepaliveFrequencyMs, rsValue, TempKF, 0, MaxInt) then begin
    Config.KeepaliveFrequency := TempKF;
    with frmTreeBrowser, tvServers, Items do
    for idx := 0 to Pred(Count) do 
      if Assigned(GetNodeObject(Items[Idx]).Transport) and
         (GetNodeObject(Items[Idx]).Transport is TnxBasePooledTransport) then
        TnxBasePooledTransportCracker(GetNodeObject(Items[Idx]).Transport).btHeartbeatInterval := TempKF;
  end;
end;

procedure TfrmMain.acGlobalOptionsUseLargeToolbarGlyphsExecute(Sender: TObject);
begin
  acGlobalOptionsUseLargeToolbarGlyphs.Checked := not acGlobalOptionsUseLargeToolbarGlyphs.Checked;
  dxBarManager.ImageOptions.UseLargeImagesForLargeIcons := acGlobalOptionsUseLargeToolbarGlyphs.Checked;
  dxBarManager.ImageOptions.LargeIcons := acGlobalOptionsUseLargeToolbarGlyphs.Checked;
  Config.UseLargeToolbarGlyphs := acGlobalOptionsUseLargeToolbarGlyphs.Checked;
end;

procedure TfrmMain.acGlobalOptionsNewTableDefaultsExecute(Sender: TObject);
begin
  with TdlgNewTableDefaults.Create(Self) do try
    dmEM.nxSessionEMSystem.GetRegisteredClassList(setRecordDescriptors, cbRecordEngine.Properties.Items);
    cbRecordEngine.ItemIndex := cbRecordEngine.Properties.Items.IndexOf(Config.NewTableDefaultRecordEngine);
    cbCompressionEngine.ItemIndex := cbCompressionEngine.Properties.Items.IndexOf(Config.NewTableDefaultCompressionEngine);
    seCompressionLevel.Value := Config.NewTableDefaultCompressionLevel;
    dmEM.nxSessionEMSystem.GetRegisteredClassList(setEncryptionEngines, cbEncryptionEngine.Properties.Items);
    cbEncryptionEngine.Properties.Items.Insert(0, '');
    cbEncryptionEngine.ItemIndex := cbEncryptionEngine.Properties.Items.IndexOf(Config.NewTableDefaultEncryptionEngine);
    dmEM.nxSessionEMSystem.GetRegisteredClassList(setIndexEngines, cbIndexEngine.Properties.Items);
    cbIndexEngine.ItemIndex := cbIndexEngine.Properties.Items.IndexOf(Config.NewTableDefaultIndexEngine);
    if ShowModal = mrOk then begin
      Config.NewTableDefaultRecordEngine := cbRecordEngine.Properties.Items[cbRecordEngine.ItemIndex];
      Config.NewTableDefaultCompressionEngine := cbCompressionEngine.Properties.Items[cbCompressionEngine.ItemIndex];
      Config.NewTableDefaultCompressionLevel := seCompressionLevel.Value;
      Config.NewTableDefaultEncryptionEngine := cbEncryptionEngine.Properties.Items[cbEncryptionEngine.ItemIndex];
      Config.NewTableDefaultIndexEngine := cbIndexEngine.Properties.Items[cbIndexEngine.ItemIndex];
      Config.Save;
    end;

  finally
    Free;
  end;
end;

{ edit action support for non-TCustomEdit descendants }
procedure TfrmMain.acEditSelectAllExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    TSynMemo(Screen.ActiveControl).SelectAll;
end;

procedure TfrmMain.acEditCutExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    TSynMemo(Screen.ActiveControl).CutToClipboard;
end;

procedure TfrmMain.acEditCopyExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    TSynMemo(Screen.ActiveControl).CopyToClipboard;
end;

procedure TfrmMain.acEditUndoExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    TSynMemo(Screen.ActiveControl).Undo;
end;

procedure TfrmMain.acEditCutUpdate(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    acEditCut.Enabled := TSynMemo(Screen.ActiveControl).SelLength <> 0;
end;

procedure TfrmMain.acEditCopyUpdate(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    acEditCopy.Enabled := TSynMemo(Screen.ActiveControl).SelLength <> 0;
end;

procedure TfrmMain.acEditPasteExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    TSynMemo(Screen.ActiveControl).PasteFromClipboard
  else if Screen.ActiveControl is TCustomEdit then
    TCustomEdit(Screen.ActiveControl).PasteFromClipboard;
end;

procedure TfrmMain.acEditPasteUpdate(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    acEditPaste.Enabled := Clipboard.HasFormat(CF_TEXT) and not TSynMemo(Screen.ActiveControl).ReadOnly
  else if Screen.ActiveControl is TCustomEdit then
    acEditPaste.Enabled := Clipboard.HasFormat(CF_TEXT) and not TCustomEdit(Screen.ActiveControl).ReadOnly
  else
    acEditPaste.Enabled := False;
end;

procedure TfrmMain.acEditSelectAllUpdate(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    acEditSelectAll.Enabled := TSynMemo(Screen.ActiveControl).GetTextLen > 0;
end;

procedure TfrmMain.acEditUndoUpdate(Sender: TObject);
begin
  if Screen.ActiveControl is TSynMemo then
    acEditUndo.Enabled := TSynMemo(Screen.ActiveControl).CanUndo;
end;

procedure TfrmMain.SetCustomEditActions;
begin
  acEditSelectAll.OnExecute := acEditSelectAllExecute;
  acEditCut.OnExecute := acEditCutExecute;
  acEditCopy.OnExecute:= acEditCopyExecute;
  acEditPaste.OnExecute := acEditPasteExecute;
  acEditUndo.OnExecute := acEditUndoExecute;
  acEditCut.OnUpdate := acEditCutUpdate;
  acEditCopy.OnUpdate := acEditCopyUpdate;
  acEditPaste.OnUpdate := acEditPasteUpdate;
  acEditSelectAll.OnUpdate := acEditSelectAllUpdate;
  acEditUndo.OnUpdate := acEditUndoUpdate;
end;

procedure TfrmMain.ResetCustomEditActions;
begin
  acEditSelectAll.OnExecute := nil;
  acEditCut.OnExecute := nil;
  acEditCopy.OnExecute:= nil;
  acEditPaste.OnExecute := nil;
  acEditUndo.OnExecute := nil;
  acEditCut.OnUpdate := nil;
  acEditCopy.OnUpdate := nil;
  acEditPaste.OnUpdate := nil;
  acEditSelectAll.OnUpdate := nil;
  acEditUndo.OnUpdate := nil;
end;
{ end custom edit event support }

procedure TfrmMain.AddFormToDockPanel(aForm: TForm; aOwner: TdxDockPanel);
begin
  aForm.Align := alClient;
  aForm.Visible := True;
  aOwner.Caption := aForm.Caption;
  if aForm is TfrmQueryBrowser then
    aOwner.Caption := aOwner.Caption + ' [' + fmQueryBrowser.LastQueryBrowserNum.ToString + ']';
  if not Assigned(aOwner.OnCloseQuery) then
    aOwner.OnCloseQuery := TdxDockControlCloseQueryEvent(aForm.OnCloseQuery);
end;

procedure TfrmMain.StartNotificationTiming(const aText : string; aAlwaysShow : Boolean = False);
begin
  StartNotificationTime := Now;
  AlwaysShowNotification := aAlwaysShow;
  NotificationText := aText;
end;

procedure TfrmMain.StopNotificationTiming;
var
  TheNotification: TNotification;
begin
  if TOSVersion.Major >= 8 then
  if (not (FindControl(GetForegroundWindow()) <> nil)) or
    AlwaysShowNotification {or
    (Now - StartNotificationTime > OneSecond * 30)} then begin
    TheNotification := NotificationCenter1.CreateNotification;
    try
      TheNotification.Name := 'Windows10Notification';
      TheNotification.Title := 'NexusDB Enterprise Manager';
      TheNotification.AlertBody := NotificationText;

      NotificationCenter1.PresentNotification(TheNotification);
    finally
      TheNotification.Free;
    end;
  end;
end;

procedure TfrmMain.ArrangeBarsButtonClick(Sender: TObject);
var
  I, J, Offset: Integer;
  DockRow: TdxDockRow;
begin
  with dxBarManager do
  begin
    LockUpdate := True;

    for J := 0 to Bars.DockControls[dsTop].RowList.Count - 1 do
    begin
      DockRow := TdxDockRow(Bars.DockControls[dsTop].RowList[J]);
      Offset := 0;
      for I := 0 to DockRow.ColList.Count - 1 do
        with TdxDockCol(DockRow.ColList[I]) do
        begin
          Pos := Point(Offset, Pos.Y);
          Inc(Offset, BarControl.Width);
        end;
    end;

    LockUpdate := False;
  end;
end;

procedure TfrmMain.dpServerCloseQuery(Sender: TdxCustomDockControl; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TfrmMain.acQueryNextStatementExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then begin
    TfrmQueryBrowser(LastActivatedForm).acQueryNextStatementExecute(Sender);
    dxbsServerName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseServerName.AsString;
    dxbsDatabaseName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseDatabaseName.AsString;
    dxbsRunAt.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseRunAt.AsString;
  end;
end;

procedure TfrmMain.acQueryPrevStatementExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then begin
    TfrmQueryBrowser(LastActivatedForm).acQueryPrevStatementExecute(Sender);
    dxbsServerName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseServerName.AsString;
    dxbsDatabaseName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseDatabaseName.AsString;
    dxbsRunAt.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseRunAt.AsString;
  end;
end;

procedure TfrmMain.acQueryExecuteExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryExecuteExecute(Sender, TfrmQueryBrowser(LastActivatedForm).SyntaxCheckOnly);
end;

procedure TfrmMain.acQuerySaveExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQuerySaveExecute(Sender);
end;

procedure TfrmMain.acQuerySqlHistoryOptionsExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQuerySqlHistoryOptionsExecute(Sender);
end;

procedure TfrmMain.acQuerySqlHistoryOptionsUpdate(Sender: TObject);
begin
  with FormList do
    acQuerySqlHistoryOptions.Enabled := LastActivatedForm is TfrmQueryBrowser;
end;

procedure TfrmMain.acQuerySyntaxCheckExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryExecuteExecute(Sender, True);
end;

procedure TfrmMain.acQueryToggleBookmark0Execute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryToggleBookmarkExecute(Sender);
end;

procedure TfrmMain.acQueryToggleBookmark0Update(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryToggleBookmarkUpdate(Sender);
end;

procedure TfrmMain.acQueryOpenExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryOpenExecute(Sender);
end;

procedure TfrmMain.acQueryParameterValuesExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryParameterValuesExecute(Sender);
end;

procedure TfrmMain.acQueryClearBookmarksExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryClearBookmarksExecute(Sender);
end;

procedure TfrmMain.acQueryClearBookmarksUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryClearBookmarksUpdate(Sender);
end;

procedure TfrmMain.acQueryCopyToTableExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryCopyToTableExecute(Sender);
end;

procedure TfrmMain.acQueryPrintPreviewExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryPrintPreviewExecute(Sender);
end;

procedure TfrmMain.acQueryPrintPreviewUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryPrintPreviewUpdate(Sender);
end;

procedure TfrmMain.acQueryQueryBuilderExecute(Sender: TObject);
begin
  {$IFDEF EMIncludeActiveQueryBuilder}
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryQueryBuilderExecute(Sender);
  {$ENDIF}
end;

procedure TfrmMain.acQueryQueryBuilderUpdate(Sender: TObject);
begin
  {$IFNDEF EMIncludeActiveQueryBuilder}
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryQueryBuilderUpdate(Sender);
  {$ENDIF}
end;

procedure TfrmMain.acQueryReplaceExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryReplaceExecute(Sender);
end;

procedure TfrmMain.acQueryDesignReportExecute(Sender: TObject);
begin
  with FormList do
  begin
    if LastActivatedForm is TfrmQueryBrowser then
      TfrmQueryBrowser(LastActivatedForm).acQueryDesignReportExecute(Sender);
  end;
end;

procedure TfrmMain.acQueryFindExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryFindExecute(Sender);
end;

procedure TfrmMain.acQueryFindNextExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryFindNextExecute(Sender);
end;

procedure TfrmMain.acQueryGotoBookmark0Execute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryGotoBookmarkExecute(Sender);
end;

procedure TfrmMain.acQueryGotoBookmark0Update(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryGotoBookmarkUpdate(Sender);
end;

procedure TfrmMain.acQueryOptionsLiveDatasetExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryOptionsLiveDatasetExecute(Sender);
end;

procedure TfrmMain.acQueryOptionsPropertiesExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryOptionsPropertiesExecute(Sender);
end;

procedure TfrmMain.acQueryViewShowBlobFieldsExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acViewShowBlobFieldsExecute(Sender);
end;

procedure TfrmMain.acQueryViewShowBlobFieldsUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    acQueryViewShowBLOBFields.Checked := TfrmQueryBrowser(LastActivatedForm).paBottom.Visible;
end;

procedure TfrmMain.acQueryViewRefreshExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acViewRefreshExecute(Sender);
end;

procedure TfrmMain.acQueryViewLogExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acViewLogExecute(Sender);
end;


procedure TfrmMain.acQueryViewLogUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    acQueryViewLog.Checked := TfrmQueryBrowser(LastActivatedForm).meSQLLog.Visible;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  idx : Integer;
begin
  CanClose := True;
  if frmTreeBrowser.ActiveTransactionCount>0 then
    if MessageDlg(rsThereIsOneOrMoreActiveTransactio+#13+#10+rsToQuitAndRollbackTheTransactions, mtWarning, [mbYes,mbNo], 0) = mrNo then begin
      CanClose := False;
      Exit;
    end;

  for Idx := 0 to Pred(Screen.FormCount) do
    if (Screen.Forms[Idx] is TfrmQueryBrowser) and
       (TfrmQueryBrowser(Screen.Forms[Idx]).paCancelableQuery.Visible) then begin
      FormList.DockPanelFromForm(Screen.Forms[Idx]).Activate;
      MessageBeep(MB_ICONASTERISK);
      CanClose := False;
      Break;
    end;
end;

procedure TfrmMain.acServersActivateServerListExecute(Sender: TObject);
begin
  frmTreeBrowser.SetFocus;
end;

procedure TfrmMain.acServersBroadcastForServersExecute(Sender: TObject);
begin
  acServersBroadcastForServers.Checked := not acServersBroadcastForServers.Checked;
  frmTreeBrowser.acServersBroadcastForServersExecute(Sender);
end;

procedure TfrmMain.acServersRefreshExecute(Sender: TObject);
begin
  frmTreeBrowser.acServersRefreshExecute(Sender);
end;

procedure TfrmMain.acServersRegisterExecute(Sender: TObject);
begin
  frmTreeBrowser.acServersRegisterExecute(Sender);
end;

procedure TfrmMain.acServersSQLExecute(Sender: TObject);
begin
  frmTreeBrowser.acServersSQLExecute(Sender);
end;

procedure TfrmMain.acServersSQLUpdate(Sender: TObject);
begin
  frmTreeBrowser.acServersSQLUpdate(Sender);
end;

function TfrmMain.CreateAndDockDockPanel : TdxDockPanel;

  function GetFirstDockPanelChild(aParent : TdxCustomDockControl) : TdxDockPanel;
  var
    i : Integer;
  begin
    Result := nil;
    for i := 0 to Pred(aParent.ChildCount) do begin
      if aParent.Children[i] is TdxDockPanel then begin
        Result := TdxDockPanel(aParent.Children[i]);
        Exit;
      end;
    end;
  end;

  function DockPanelChildCount(aParent : TdxCustomDockControl) : Integer;
  var
    i : Integer;
  begin
    Result := 0;
    for i := 0 to Pred(aParent.ChildCount) do
      if aParent.Children[i] is TdxDockPanel then
        Inc(Result);
  end;

  function GetLayoutDockSite(aParent : TdxCustomDockControl) : TdxLayoutDockSite;
  var
    i : Integer;
  begin
    Result := nil;
    for i := 0 to Pred(aParent.ChildCount) do begin
      if aParent.Children[i] is TdxLayoutDockSite then begin
        Result := TdxLayoutDockSite(aParent.Children[i]);
        Exit;
      end;
    end;
  end;

begin
  Result := TdxDockPanel.Create(Self);
  Result.ParentFont := True;
  Result.Font.Name := Config.FontName;
  Result.Font.Size := Config.FontSize;
  Result.TabsProperties.Style := 11; //Skin

  if assigned(FormList.LastActivatedForm) then begin
    with FormList.DockPanelFromForm(FormList.LastActivatedForm) do begin
      if AutoHide then
        AutoHide := False;
      if Assigned(TabContainer) then
      begin
        TabContainer.ShowHint:=true;
        Result.ShowHint:=true;
        Result.DockTo(TabContainer, dtClient, -1);
      end
      else
        Result.DockTo(FormList.DockPanelFromForm(FormList.LastActivatedForm), dtClient, -1);
    end;
  end
  else
  if not Assigned(GetLayoutDockSite(frmMain.dxDockSiteMain)) then
    Result.DockTo(frmMain.dxDockSiteMain, dtClient, -1)
  else
  if (DockPanelChildCount(GetLayoutDockSite(frmMain.dxDockSiteMain)) = 0) and
     not Assigned(GetLayoutDockSite(frmMain.dxDockSiteMain).TabContainer) then begin
    Result.DockTo(GetLayoutDockSite(frmMain.dxDockSiteMain), dtClient, -1);
  end
  else
  if Assigned(GetLayoutDockSite(frmMain.dxDockSiteMain).TabContainer) then
    Result.DockTo(GetFirstDockPanelChild(GetLayoutDockSite(frmMain.dxDockSiteMain).TabContainer), dtClient, -1)
  else
    Result.DockTo(GetFirstDockPanelChild(GetLayoutDockSite(frmMain.dxDockSiteMain)), dtClient, -1);
  Result.OnClose := DoDockPanelClose;
end;

procedure TfrmMain.EnableActiveFormActions(aForm: TForm);
const
  eaShowMenu : Array[False..True] of TdxBarItemVisible = (ivNever, ivAlways);
var
  EnabledActions : Boolean;
begin
  dxBarManager.LockUpdate := True;
  try
    mnuServer.Visible := ivAlways;
    { for dual action actions }
    EnabledActions := Assigned(aForm);
    acTableSetFieldtoNULL.Enabled := EnabledActions;
    { de/activate query browser actions }
    EnabledActions := Assigned(aForm) and (aForm is TfrmQueryBrowser);
    acQueryNextStatement.Enabled := EnabledActions;
    acQueryPrevStatement.Enabled := EnabledActions;

    acQueryExecute.Enabled := EnabledActions;
    acQuerySyntaxCheck.Enabled := EnabledActions;
    acQuerySave.Enabled := EnabledActions;
    acQueryOpen.Enabled := EnabledActions;
    acQueryParameterValues.Enabled := EnabledActions;
    acQueryCopyToTable.Enabled := EnabledActions;
    acQueryPrintPreview.Enabled := EnabledActions;
    acQueryDesignReport.Enabled := EnabledActions;
    acQueryFind.Enabled := EnabledActions;

    acQueryViewShowBlobFields.Enabled := EnabledActions;
    acQueryViewShowRecordCount.Enabled := EnabledActions;
    acQueryViewUseGridMode.Enabled := (not acGlobalOptionsUsePlainGrid.Checked) and EnabledActions;
    acQueryViewRefresh.Enabled := EnabledActions;
    acQueryViewLog.Enabled := EnabledActions;

    acQueryOptionsLiveDataset.Enabled := EnabledActions;
    acQueryOptionsProperties.Enabled := EnabledActions;

    mnuQuery.Visible := eaShowMenu[EnabledActions];
    mnuQueryView.Visible := eaShowMenu[EnabledActions];
    mnuQueryConnection.Visible := eaShowMenu[EnabledActions];
    mnuQueryOptions.Visible := eaShowMenu[EnabledActions];

    if EnabledActions then begin
      acQueryViewRefresh.ShortCut := TextToShortCut('F5');
      acQueryViewShowBlobFields.ShortCut := TextToShortCut('Ctrl+B');
      acQueryViewUseGridMode.ShortCut := TextToShortCut('Ctrl+G');
      acQueryFind.ShortCut := TextToShortCut('Ctrl+F');
      acQueryOptionsProperties.ShortCut := TextToShortCut('Ctrl+P');
      acQueryOptionsLiveDataset.ShortCut := TextToShortCut('Ctrl+D');
      acQueryPrintPreview.ShortCut := TextToShortCut('Ctrl+R');
    end
    else begin
      acQueryViewRefresh.ShortCut := scNone;
      acQueryViewShowBlobFields.ShortCut := scNone;
      acQueryViewUseGridMode.ShortCut := scNone;
      acQueryFind.ShortCut := scNone;
      acQueryOptionsProperties.ShortCut := scNone;
      acQueryOptionsLiveDataset.ShortCut := scNone;
      acQueryPrintPreview.ShortCut := scNone;
    end;

    { de/activate table browser actions }
    EnabledActions := Assigned(aForm) and (aForm is TfrmTableBrowser);
    acTableResetColumns.Enabled := EnabledActions;
    acTableNextTable.Enabled := EnabledActions;
    acTableCopyToTable.Enabled := EnabledActions;
    acTableDeleteRecords.Enabled := EnabledActions;
    acTablePrintPreview.Enabled := EnabledActions;
    acTableDesignReport.Enabled := EnabledActions;
    acTableViewShowFilter.Enabled := EnabledActions;
    acTableViewShowRange.Enabled := EnabledActions;
    acTableViewShowBLOBFields.Enabled := EnabledActions;
    acTableViewShowRecordCount.Enabled := EnabledActions;
    acTableViewUseGridMode.Enabled := (not acGlobalOptionsUsePlainGrid.Checked) and EnabledActions;
    acTableViewRefresh.Enabled := EnabledActions;
    acTableOptionsDebugLog.Enabled := EnabledActions;
    acTableOptionsTimeout.Enabled := EnabledActions;

    mnuTable.Visible := eaShowMenu[EnabledActions];
    mnuTableView.Visible := eaShowMenu[EnabledActions];
    mnuTableOptions.Visible := eaShowMenu[EnabledActions];

    if EnabledActions then begin
      acTableViewRefresh.ShortCut := TextToShortCut('F5');
      acTableViewShowBlobFields.ShortCut := TextToShortCut('Ctrl+B');
      acTableViewUseGridMode.ShortCut := TextToShortCut('Ctrl+G');
      acTableViewShowFilter.ShortCut := TextToShortCut('Ctrl+F');
      acTablePrintPreview.ShortCut := TextToShortCut('Ctrl+P');
      acTableDesignReport.ShortCut := TextToShortCut('Ctrl+D');
      acTableViewShowRange.ShortCut := TextToShortCut('Ctrl+R');
    end
    else begin
      acTableViewRefresh.ShortCut := scNone;
      acTableViewShowBlobFields.ShortCut := scNone;
      acTableViewShowFilter.ShortCut := scNone;
      acTableViewUseGridMode.ShortCut := scNone;
      acTablePrintPreview.ShortCut := scNone;
      acTableDesignReport.ShortCut := scNone;
      acTableViewShowRange.ShortCut := scNone;
    end;

  finally
    dxBarManager.LockUpdate := False;
  end;
end;

procedure TfrmMain.dxDockingManagerActiveDockControlChanged(Sender: TObject);
var
  i : Integer;
begin
  if dxDockingController.ActiveDockControl is TdxDockPanel then
    with dxDockingController.ActiveDockControl as TdxDockPanel do begin
      for i := 0 to Pred(ComponentCount) do
        if (Components[i] is TfrmBaseBrowser) or
           (Components[i] is TfrmDictionaryBrowser2) then begin
          FormList.LastActivatedForm := TForm(Components[i]);
          Break;
        end;
    end;
end;

procedure TfrmMain.acTableResetColumnsExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableResetColumnsExecute(Sender);
end;

procedure TfrmMain.acTableSetFieldtoNULLExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableSetFieldtoNULLExecute(Sender)
  else
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQuerySetFieldtoNULLExecute(Sender);
end;

procedure TfrmMain.acTableNextTableExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableNextTableExecute(Sender);
end;

procedure TfrmMain.acTableCopyToTableExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableCopyToTableExecute(Sender);
end;

procedure TfrmMain.acTableDeleteRecordsExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableDeleteRecordsExecute(Sender);
end;

procedure TfrmMain.acTablePrintPreviewExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTablePrintPreviewExecute(Sender);
end;

procedure TfrmMain.acTableDesignReportExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableDesignReportExecute(Sender);
end;

procedure TfrmMain.acTableOptionsDebugLogExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acOptionsDebugLogExecute(Sender);
end;

procedure TfrmMain.acTableOptionsTimeoutExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acOptionsTimeoutExecute(Sender);
end;

procedure TfrmMain.acTableViewShowFilterExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acViewShowFilterExecute(Sender);
end;

procedure TfrmMain.acTableViewShowFilterUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    acTableViewShowFilter.Checked := TfrmTableBrowser(LastActivatedForm).paFilter.Visible;
end;

procedure TfrmMain.acTableViewShowRangeExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acViewShowRangeExecute(Sender);
end;

procedure TfrmMain.acTableViewShowRangeUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    acTableViewShowRange.Checked := TfrmTableBrowser(LastActivatedForm).paRange.Visible;
end;

procedure TfrmMain.acTableViewShowBLOBFieldsExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acViewShowBLOBFieldsExecute(Sender);
end;

procedure TfrmMain.acTableViewShowBLOBFieldsUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    acTableViewShowBLOBFields.Checked := TfrmTableBrowser(LastActivatedForm).paBottom.Visible;
end;

procedure TfrmMain.acTableViewShowRecordCountExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acViewShowRecordCountExecute(Sender);
end;

procedure TfrmMain.acTableViewShowRecordCountUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    acTableViewShowRecordCount.Checked := TfrmTableBrowser(LastActivatedForm).StatusBar.Panels[iPanelRecordCount].Text <> '';
end;

procedure TfrmMain.acTableViewUseGridModeExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acTableViewUseGridModeExecute(Sender);
end;

procedure TfrmMain.acTableViewUseGridModeUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    acTableViewUseGridMode.Checked := TfrmTableBrowser(LastActivatedForm).cxGrid1DBTableView1.DataController.DataModeController.GridMode;
end;

procedure TfrmMain.acUpdateNewUpdateExecute(Sender: TObject);
begin
  if ShellExecute(0, 'open', 'https://www.nexusdb.com/support/index.php?q=nxdbupdatelandingpage', '', '', SW_SHOWNORMAL) <= 32 then
    ShowMessage(cnxBrowserError);
end;

procedure TfrmMain.acTableViewRefreshExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmTableBrowser then
    TfrmTableBrowser(LastActivatedForm).acViewRefreshExecute(Sender);
end;

procedure TfrmMain.tiStartupTimer(Sender: TObject);
var
  IniPassword,
  value        : string;
  Quit         : Boolean;
  IniFile      : TIniFile;

begin
  tiStartup.Enabled := False;

  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    IniPassword := ReverseString(IniFile.ReadString('Settings', 'SimplePassword', ''));
  finally
    IniFile.Free;
  end;

  if (Config.SimplePassword <> '') or
     (IniPassword <> '') then begin
    repeat
      Quit := not InputQuery('EM Password', 'Password:', value);
    until Quit or (Config.SimplePassword = value) or (IniPassword = value);

    if Quit then begin
      Close;
      Exit;
    end;
  end;

  frmTreeBrowser.Initialize;
  TdlgSelectRuntimePackages.LoadRuntimePackages;
end;

procedure TfrmMain.tiUpdateCheckTimer(Sender: TObject);
begin
  if tiUpdateCheck.Interval < MSecsPerDay then
    tiUpdateCheck.Interval := MSecsPerDay;
  unUpdateCheck.StartUpdateCheck('EM');
end;

procedure TfrmMain.UpdateLookAndFeel;
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
          tbNewUpdate.Color := (AProperty as TdxSkinColor).Value;
      if AGroup.GetPropertyByName(sdxSkinsEditorHyperLinkTextColor, AProperty) then
        if AProperty is TdxSkinColor then begin
          cxsUpdateStyle.TextColor := (AProperty as TdxSkinColor).Value;
          cxsUpdateStyle.Font.Color := (AProperty as TdxSkinColor).Value;
        end;
    end;
  end;
end;

procedure TfrmMain.acGlobalOptionsRecNoSupportExecute(Sender: TObject);
var
  i: Integer;
begin
  acGlobalOptionsRecNoSupport.Checked := not acGlobalOptionsRecNoSupport.Checked;
  for i := 0 to Pred(FormList.Count) do
    if FormList.Form(i) is TfrmBaseBrowser then
    with TfrmBaseBrowser(FormList.Form(i)) do begin
      if acGlobalOptionsRecNoSupport.Checked then
        TnxDataset(dsBrowser.DataSet).Options :=
          TnxDataset(dsBrowser.DataSet).Options + [dsoRecNoSupport]
      else
        TnxDataset(dsBrowser.DataSet).Options :=
          TnxDataset(dsBrowser.DataSet).Options - [dsoRecNoSupport];
      DisplayRecNo;
    end;
end;

procedure TfrmMain.acGlobalOptionsReloadLastSqlExecute(Sender: TObject);
begin
  acGlobalOptionsReloadLastSql.Checked := not acGlobalOptionsReloadLastSql.Checked;
end;

procedure TfrmMain.DoDockPanelClose(Sender: TdxCustomDockControl);
var
  DummyAction : TCloseAction;
begin
  with FormList do begin
    with FormFromDockPanel(Sender as TdxDockPanel) do
      if Assigned(OnClose) then
        OnClose(FormFromDockPanel(Sender as TdxDockPanel), DummyAction);
    LastActivatedForm := nil;

    RemoveForm(FormFromDockPanel(Sender as TdxDockPanel));
  end;
end;

procedure TfrmMain.DoShortCut(var Msg: TWMKey; var Handled: Boolean);
var
  TabContainer : TdxTabContainerDockSite;

  function HasTabContainerParent(var aTabContainer : TdxTabContainerDockSite) : Boolean;
  var
    Control : TdxCustomDockControl;
  begin
    Result := False;
    aTabContainer := nil;
    Control := dxDockingController.ActiveDockControl;
    while Assigned(Control) do begin
      if Control is TdxTabContainerDockSite then begin
        Result := True;
        aTabContainer := TdxTabContainerDockSite(Control);
        Break;
      end;
      Control := Control.ParentDockControl;
    end;
  end;

begin
  Handled := False;
  if (Msg.CharCode = 9) and (GetAsyncKeyState(VK_CONTROL) < 0) and HasTabContainerParent(TabContainer) then begin
    Handled := True;
     if GetAsyncKeyState(VK_SHIFT) < 0 then begin
       if TabContainer.ActiveChildIndex = 0 then
         TabContainer.ActiveChildIndex := TabContainer.ChildCount - 1
       else
         TabContainer.ActiveChildIndex := TabContainer.ActiveChildIndex - 1;
     end
     else
       if TabContainer.ActiveChildIndex = TabContainer.ChildCount - 1 then
         TabContainer.ActiveChildIndex := 0
       else
         TabContainer.ActiveChildIndex := TabContainer.ActiveChildIndex + 1;
  end;
end;

procedure TfrmMain.meToggleBookmark9Click(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryToggleBookmarkExecute(Sender);
end;

procedure TfrmMain.mnuGlobalOptionsRuntimeLoadedPackagesClick(Sender: TObject);
begin
  with TdlgSelectRuntimePackages.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TfrmMain.NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
begin
  if ANotification.Name = 'UpdateNotification' then
    acUpdateNewUpdateExecute(nil)
  else
    Application.BringToFront;
end;

procedure TfrmMain.DoTabContainerActiveChildChanged(Sender : TdxContainerDockSite;
                                                    Child  : TdxCustomDockControl);
var
  i : Integer;
begin
  if Assigned(Child) and
    (Child is TdxDockPanel) then
    with Child as TdxDockPanel do begin
      for i := 0 to Pred(ComponentCount) do begin
        if (Components[i] is TfrmQueryBrowser) then begin
          QueryBrowserToActivate := TfrmQueryBrowser(Components[i]);
          tiActivateQueryEdit.Enabled := True;
          Break;
        end;
      end;
    end;
end;

procedure TfrmMain.dxDockingManagerCreateFloatSite(
  Sender: TdxCustomDockControl; AFloatSite: TdxFloatDockSite);
begin
  AFloatSite.ParentFont := True;
end;

procedure TfrmMain.dxDockingManagerCreateLayoutSite(
  Sender: TdxCustomDockControl; ALayoutSite: TdxLayoutDockSite);
begin
  ALayoutSite.ParentFont := True;
end;

procedure TfrmMain.dxDockingManagerCreateSideContainer(
  Sender: TdxCustomDockControl; ASideContainer: TdxSideContainerDockSite);
begin
  ASideContainer.ParentFont := True;
end;

procedure TfrmMain.dxDockingManagerCreateTabContainer(Sender        : TdxCustomDockControl;
                                                      ATabContainer : TdxTabContainerDockSite);
begin
  aTabContainer.OnContextPopup := TabContainerContextPopup;
  aTabContainer.OnActiveChildChanged := DoTabContainerActiveChildChanged;
  if Config.TabsOnTop then
    ATabContainer.TabsProperties.TabPosition := tpTop
  else
    ATabContainer.TabsProperties.TabPosition := tpBottom;
  ATabContainer.ParentFont := True;
end;

procedure TfrmMain.dxSkinChooserGalleryItemSkinChanged(Sender: TObject; const ASkinName: string);
var
  i : Integer;
begin
  SetSkin(dxSkinChooserGalleryItem.SelectedGroupItem);
  frmTreeBrowser.dxBarManager1.LookAndFeel.SkinName := ASkinName;
  frmTreeBrowser.tvServers.Style.LookAndFeel.SkinName := ASkinName;
  frmTreeBrowser.StatusBar.LookAndFeel.SkinName := ASkinName;
  dxDockingManager.LookAndFeel.SkinName := ASkinName;
  for i := 0 to Pred(Screen.FormCount) do
    if Screen.Forms[i] is TfrmBaseBrowser then
      (Screen.Forms[i] as TfrmBaseBrowser).UpdateLookAndFeel;
  Config.SkinName := aSkinName;
  UpdateLookAndFeel;
end;

procedure TfrmMain.SetSkin(ASkinItem: TdxSkinChooserGalleryGroupItem);
begin
  ASkinItem.ApplyToRootLookAndFeel;
end;

type
  TdxTabContainerDockSiteAccess = class(TdxTabContainerDockSite);

procedure TfrmMain.TabContainerContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  i           : Integer;
  Menu        : TMenuItem;
  MenuPos      : TPoint;
begin
  Handled := False;

  if TdxTabContainerDockSiteAccess(Sender).TabsController.GetTabIndexAtPoint(MousePos) >= 0 then begin
    with pmTabContainerList do begin
      Items.Clear;
      with TdxTabContainerDockSite(Sender) do begin
        Menu := TMenuItem.Create(nil);
        Menu.OnClick := TabContainerMoveTabs;
        Menu.Tag := TnxNativeInt(TdxTabContainerDockSite(Sender));
        Items.Add(Menu);

        if TdxTabContainerDockSite(Sender).TabsProperties.TabPosition = tpTop then
          Menu.Caption := rsMoveTabsDown
        else
          Menu.Caption := rsMoveTabsUp;

        for i := 0 to Pred(ChildCount) do begin
          Menu := TMenuItem.Create(nil);
          Menu.Caption := Children[i].Caption;
          Menu.OnClick := TabContainerContextPopupItemClicked;
          Menu.Tag := TnxNativeInt(TdxTabContainerDockSite(Sender));
          Items.Add(Menu);
        end;
      end;
      MenuPos := (Sender as TdxTabContainerDockSite).ClientToScreen(MousePos);
      Popup(MenuPos.X, MenuPos.Y);
    end;

    Handled := True;
    Exit;
  end;
end;

procedure TfrmMain.TabContainerContextPopupItemClicked(Sender: TObject);
begin
  with TMenuItem(Sender) do
    TdxTabContainerDockSite(Tag).ActiveChildIndex := Parent.IndexOf(TMenuItem(Sender)) - 1;
end;

procedure TfrmMain.acGlobalOptionsAutoTreeRefreshExecute(Sender: TObject);
begin
  acGlobalOptionsAutoTreeRefresh.Checked := not acGlobalOptionsAutoTreeRefresh.Checked;
  Config.AutoTreeRefresh := acGlobalOptionsAutoTreeRefresh.Checked;
end;

procedure TfrmMain.SetGlobalFont(aChangeScale : Boolean);
var
  i, j,
  NewFontSize : Integer;
begin
  NewFontSize := IfThen(aChangeScale and (CurrentPPI <> PixelsPerInch), Trunc(Config.FontSize * (CurrentPPI / PixelsPerInch)), Config.FontSize);
  dxBarManager.Font.Name := Config.FontName;
  dxBarManager.Font.Size := Config.FontSize;
  dxDockingManager.Font.Name := Config.FontName;
  dxDockingManager.Font.Size := Config.FontSize;

  for i := 0 to Pred(Screen.FormCount) do begin
    Screen.Forms[i].Font.Name := Config.FontName;
    Screen.Forms[i].Font.Size := NewFontSize;
    for j := 0 to Pred(Screen.Forms[i].ComponentCount) do
      if Screen.Forms[i].Components[j] is TFrame then begin
        (Screen.Forms[i].Components[j] as TFrame).Font.Name := Config.FontName;
        (Screen.Forms[i].Components[j] as TFrame).Font.Size := NewFontSize;
      end
      else
      if Screen.Forms[i].Components[j] is TdxDockSite then begin
        (Screen.Forms[i].Components[j] as TdxDockSite).Font.Name := Config.FontName;
        (Screen.Forms[i].Components[j] as TdxDockSite).Font.Size := NewFontSize;
      end
      else
      if Screen.Forms[i].Components[j] is TdxLayoutDockSite then begin
        (Screen.Forms[i].Components[j] as TdxLayoutDockSite).Font.Name := Config.FontName;
        (Screen.Forms[i].Components[j] as TdxLayoutDockSite).Font.Size := NewFontSize;
      end
      else
      if Screen.Forms[i].Components[j] is TdxDockPanel then begin
        (Screen.Forms[i].Components[j] as TdxDockPanel).Font.Name := Config.FontName;
        (Screen.Forms[i].Components[j] as TdxDockPanel).Font.Size := NewFontSize;
      end;
  end;
end;

procedure TfrmMain.acGlobalOptionsChooseFontExecute(Sender: TObject);
begin
  FontDialog.Font.Name := Config.FontName;
  FontDialog.Font.Size := Config.FontSize;
  if FontDialog.Execute then begin
    Config.FontName := FontDialog.Font.Name;
    Config.FontSize := FontDialog.Font.Size;
    Application.DefaultFont.Name := Config.FontName;
    Application.DefaultFont.Size := Config.FontSize;
//    SetGlobalFont(True);
  end;
end;

procedure TfrmMain.acGlobalOptionsCloseActiveWindowExecute(Sender: TObject);
begin
  if Assigned(FormList.LastActivatedForm) then
    FormList.DockPanelFromForm(FormList.LastActivatedForm).Close;
//    FormList.StartFreeTimer(FormList.DockPanelFromForm(FormList.LastActivatedForm));
end;

procedure TfrmMain.acGlobalOptionsAllowCloseInactiveCallsExecute(Sender: TObject);
begin
  acGlobalOptionsAllowCloseInactiveCalls.Checked := not acGlobalOptionsAllowCloseInactiveCalls.Checked;
  Config.AllowCloseInactive := acGlobalOptionsAllowCloseInactiveCalls.Checked;
end;

procedure TfrmMain.ApplicationEvents1Deactivate(Sender: TObject);
begin
  if Assigned(frmTreeBrowser) and
     Assigned(frmTreeBrowser.ActivePopupMenu) and
     Assigned(frmTreeBrowser.ActivePopupMenu.ItemLinks) and
     Assigned(frmTreeBrowser.ActivePopupMenu.ItemLinks.BarControl) then
    TdxBarSubMenuControl(frmTreeBrowser.ActivePopupMenu.ItemLinks.BarControl).Hide;
end;

procedure TfrmMain.dpServerEndDocking(Sender: TdxCustomDockControl;
  Zone: TdxZone; X, Y: Integer);
var
  i : Integer;
begin
  with frmTreeBrowser, tvServers do begin
    for i := 0 to Pred(Items.Count) do
      if GetNodeObject(Items[i]).NodeType in [ntDatabase, ntTables, ntStoredProcs, ntViews, ntCheckConstraints] then
        Items[i].HasChildren := True;
  end;
end;

procedure TfrmMain.DockPanelOnActivate(Sender: TdxCustomDockControl; Active: Boolean);
var
  i : Integer;
begin
  if Assigned(Sender) and
    (Sender is TdxDockPanel) then
  if Active then begin
    with Sender as TdxDockPanel do begin
      for i := 0 to Pred(ComponentCount) do begin
        if (Components[i] is TfrmQueryBrowser) then
          TfrmQueryBrowser(Components[i]).SetFocusedControl(TfrmQueryBrowser(Components[i]).SQLEditor);
        (*if (Components[i] is TfrmBaseBrowser) or
           (Components[i] is TfrmDictionaryBrowser2) then begin
          FormList.LastActivatedForm := TForm(Components[i]);
          Break;
        end;*)
      end;
    end;
  end
  else
    FormList.LastActivatedForm := nil;
end;


procedure TfrmMain.acGlobalOptionsDisplayMillisecondsExecute(Sender: TObject);
begin
  acGlobalOptionsDisplayMilliseconds.Checked := not acGlobalOptionsDisplayMilliseconds.Checked;
  Config.DisplayMilliseconds := acGlobalOptionsDisplayMilliseconds.Checked;
end;

procedure TfrmMain.TabContainerMoveTabs(Sender: TObject);
begin
  if TdxTabContainerDockSite(TMenuItem(Sender).Tag).TabsProperties.TabPosition = tpTop then
    TdxTabContainerDockSite(TMenuItem(Sender).Tag).TabsProperties.TabPosition := tpBottom
  else
    TdxTabContainerDockSite(TMenuItem(Sender).Tag).TabsProperties.TabPosition := tpTop;
  Config.TabsOnTop := (TdxTabContainerDockSite(TMenuItem(Sender).Tag).TabsProperties.TabPosition = tpTop);
end;

procedure TfrmMain.acQueryNextStatementUpdate(Sender: TObject);
begin
  with FormList do begin
    acQueryNextStatement.Enabled :=
      (LastActivatedForm is TfrmQueryBrowser) and not
      (TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowse.IsEmpty);
    if acQueryNextStatement.Enabled then begin
      dxbsServerName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseServerName.AsString;
      dxbsDatabaseName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseDatabaseName.AsString;
      dxbsRunAt.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseRunAt.AsString;
    end
    else begin
      dxbsServerName.Caption := '<>';
      dxbsDatabaseName.Caption := '<>';
      dxbsRunAt.Caption := '<>';
    end;
  end;
end;

procedure TfrmMain.acQueryPrevStatementUpdate(Sender: TObject);
begin
  with FormList do begin
    acQueryPrevStatement.Enabled :=
      (LastActivatedForm is TfrmQueryBrowser) and not
      (TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowse.IsEmpty);
    if acQueryPrevStatement.Enabled then begin
      dxbsServerName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseServerName.AsString;
      dxbsDatabaseName.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseDatabaseName.AsString;
      dxbsRunAt.Caption := TfrmQueryBrowser(LastActivatedForm).taSqlHistoryBrowseRunAt.AsString;
    end
    else begin
      dxbsServerName.Caption := '<>';
      dxbsDatabaseName.Caption := '<>';
      dxbsRunAt.Caption := '<>';
    end;
  end;
end;

procedure TfrmMain.acGlobalOptionsUseLongTabDescriptionExecute(Sender: TObject);
begin
  acGlobalOptionsUseLongTabDescription.Checked := not acGlobalOptionsUseLongTabDescription.Checked;
  Config.UseLongTabDescription := acGlobalOptionsUseLongTabDescription.Checked;
end;

procedure TfrmMain.acGlobalOptionsUsePlainGridExecute(Sender: TObject);
var
  i : Integer;
begin
  acGlobalOptionsUsePlainGrid.Checked := not acGlobalOptionsUsePlainGrid.Checked;
  Config.UsePlainGrid := acGlobalOptionsUsePlainGrid.Checked;
  for i := 0 to Pred(Screen.FormCount) do
    if Screen.Forms[i] is TfrmBaseBrowser then
    with TfrmBaseBrowser(Screen.Forms[i]) do begin
      if acGlobalOptionsUsePlainGrid.Checked then begin
        cxGrid1DBTableView1.DataController.DataSource := nil;
        cxDataGrid.Visible := False;

        PlainDataGrid.Visible := True;
        PlainDataGrid.DataSource := dsBrowser;
      end
      else begin
        PlainDataGrid.Visible := False;
        PlainDataGrid.DataSource := nil;

        cxDataGrid.Visible := True;
        cxGrid1DBTableView1.DataController.DataSource := dsBrowser;
        RebuildColumns;
      end;
    end;
end;

procedure TfrmMain.acQueryViewShowRecordCountExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acViewShowRecordCountExecute(Sender);
end;

procedure TfrmMain.acQueryViewShowRecordCountUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    acQueryViewShowRecordCount.Checked := TfrmQueryBrowser(LastActivatedForm).LocalShowRecordCount;
end;

procedure TfrmMain.acQueryViewUseGridModeExecute(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    TfrmQueryBrowser(LastActivatedForm).acQueryViewUseGridModeExecute(Sender);
end;

procedure TfrmMain.acQueryViewUseGridModeUpdate(Sender: TObject);
begin
  with FormList do
  if LastActivatedForm is TfrmQueryBrowser then
    acQueryViewUseGridMode.Checked := TfrmQueryBrowser(LastActivatedForm).cxGrid1DBTableView1.DataController.DataModeController.GridMode;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  nxFreeAndNil(frmTreeBrowser);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TfrmMain.tiActivateQueryEditTimer(Sender: TObject);
begin
  tiActivateQueryEdit.Enabled := False;
  if Assigned(QueryBrowserToActivate) then
    QueryBrowserToActivate.SQLEditor.SetFocus;
end;

procedure TfrmMain.tiCloseLostCommTimer(Sender: TObject);
var
  Node : TTreeNode;
begin
  tiCloseLostComm.Enabled := False;
  with frmTreebrowser do begin
    Node := tvServers.Items[0].GetNextSibling;
    while Assigned(Node) do begin
      with TnxRemoteServerEngine(GetNodeObject(Node).ServerEngine).Transport do
      if (State = nxsStarted) and not IsConnected then begin
        Node.Selected := True;
        DoDetach;
      end;
      Node := Node.getNextSibling;
    end;
  end;
end;

procedure TfrmMain.Loaded;
begin
  inherited;

  with dxDockingManager do begin
    Font.Name := Config.FontName;
    Font.Size := Config.FontSize;
    DefaultFloatSiteProperties.Font.Name := Config.FontName;
    DefaultFloatSiteProperties.Font.Size := Config.FontSize;
    DefaultHorizContainerSiteProperties.Font.Name := Config.FontName;
    DefaultHorizContainerSiteProperties.Font.Size := Config.FontSize;
    DefaultLayoutSiteProperties.Font.Name := Config.FontName;
    DefaultLayoutSiteProperties.Font.Size := Config.FontSize;
    DefaultTabContainerSiteProperties.Font.Name := Config.FontName;
    DefaultTabContainerSiteProperties.Font.Size := Config.FontSize;
    DefaultVertContainerSiteProperties.Font.Name := Config.FontName;
    DefaultVertContainerSiteProperties.Font.Size := Config.FontSize;
  end;

  with dxBarManager do begin
    Font.Name := Config.FontName;
    Font.Size := Config.FontSize;
  end;

end;

initialization
// turn off Grid multi-threading - avoid reentrancy
 dxThreading.dxEnableMultiThreading := False;
end.


