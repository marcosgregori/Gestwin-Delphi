{##############################################################################}
{# NexusDB Enterprise Manager: fmTreeBrowser.pas 4.7001                      #}
{# Copyright (c) Nexus Database 2003-2023                                     #}
{# All rights reserved.                                                       #}
{##############################################################################}
{# NexusDB Enterprise Manager: Treeview Child Form                            #}
{##############################################################################}

{$I nxemDefine.inc}

unit fmTreeBrowser;

{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

interface

uses
  {$IFDEF NXWINAPI}nxWinAPI{$ELSE}Windows{$ENDIF},
  UITypes,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  commctrl,
  ComCtrls,
  ToolWin,
  ImgList,
  Menus,
  ActnList,
  ExtCtrls,
  Syncobjs,

  dxBar,
  cxControls,
  cxContainer,
  cxTreeView,
  dxStatusBar,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxEdit, 
  cxClasses,

  unFormList,
  unTreeNodeObject,
  nxemBaseDictionaryEditors,
  nxdb,
  nxllTypes,
  nxllTransport,
  nxllList,
  nxllException,
  nxsdServerEngine,
  nxsrServerEngine,
  nxsdDataDictionary,
  nxllComponent,
  nxdbBackupController,
  nxtnNamedPipeTransport,
  nxptBasePooledTransport,
  nxtwWinsockTransport,
  nxthHttpTransport,
  nxllMemoryManager,
  nxtmSharedMemoryTransport,
  dgRebuildProgress, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinBasic, dxSkinOffice2019Black,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, dxForms, GestwinSkin,
  GestwinWhiteSkin,
  unScaledForm;

const
  nxc_InternalServerName      = 'Internal Server';
  WM_ChangeTreeNodeText       = WM_USER + 123;

type
  TfrmTreeBrowser = class;

  TnxBroadcastReplyTransportType = (brttWinsock, brttNamedPipe, brttSharedMemory);

  TnxBroadcastReplyHandler = class(TnxInterfacedObject, InxBroadcastReplyHandler)
  protected
    brhTreeBrowser   : TfrmTreeBrowser;
    brhTransportType : TnxBroadcastReplyTransportType;

    procedure ReplyReceived(aReply : InxBroadcastReply);
  public
    constructor Create(aTreeBrowser   : TfrmTreeBrowser;
                       aTransportType : TnxBroadcastReplyTransportType); virtual;
  end;

  TfrmTreeBrowser = class(TdxScaledForm)
    tvServers: TcxTreeView;
    dxBarManager1: TdxBarManager;
    popmnuDatabase: TdxBarPopupMenu;
    popmnuDatabaseNewTable: TdxBarButton;
    popmnuServerNewDatabase: TdxBarButton;
    popmnuDatabaseDelete: TdxBarButton;
    popmnuDatabaseRename: TdxBarButton;
    popmnuDatabaseStartTrans: TdxBarButton;
    popmnuDatabaseCommitTrans: TdxBarButton;
    popmnuDatabaseRollbackTrans: TdxBarButton;
    popmnuStoredProcsRefresh: TdxBarButton;
    popmnuTablesPackAllTables: TdxBarButton;
    popmnuTablesEnterPassword: TdxBarButton;
    popmnuDatabaseLiveBackup: TdxBarButton;
    popmnuDatabaseRestore: TdxBarButton;
    popmnuDatabaseCSVImport: TdxBarButton;
    popmnuDatabaseSQL: TdxBarButton;
    popmnuServer: TdxBarPopupMenu;
    popmnuServerAttach: TdxBarButton;
    popmnuServerDetach: TdxBarButton;
    popmnuServerRefreshDatabaseList: TdxBarButton;
    popmnuServerStatistics: TdxBarButton;
    popmnuTable: TdxBarPopupMenu;
    popmnuTableBrowseTable: TdxBarButton;
    popmnuTableDefinition: TdxBarButton;
    popmnuTableNew: TdxBarButton;
    popmnuTableDelete: TdxBarButton;
    popmnuTableRename: TdxBarButton;
    popmnuTableReindex: TdxBarButton;
    popmnuTablePackTable: TdxBarButton;
    popmnuTableRestructure: TdxBarButton;
    popmnuTableEnterPassword: TdxBarButton;
    popmnuTableSetAutoInc: TdxBarButton;
    popmnuTableEmpty: TdxBarButton;
    popmnuTableRecover: TdxBarButton;
    popmnuTableImportCSV: TdxBarButton;
    popmnuTableSQL: TdxBarButton;
    StatusBar: TdxStatusBar;
    tiAlign: TTimer;
    popmnuTablesEmptyAllTables: TdxBarButton;
    popmnuTableCloneTableStructure: TdxBarButton;
    popmnuChildTable: TdxBarPopupMenu;
    popmnuServerRefreshServerList: TdxBarButton;
    WinsockTransportBroadcast: TnxWinsockTransport;
    NamedPipeTransportBroadcast: TnxNamedPipeTransport;
    popmnuTablesChangePassword: TdxBarButton;
    popmnuTableChangePassword: TdxBarButton;
    SharedMemoryTransportBroadcast: TnxSharedMemoryTransport;
    popmnuDatabaseRefIntEditor: TdxBarButton;
    popmnuTables: TdxBarPopupMenu;
    popmnuStoredProcs: TdxBarPopupMenu;
    popmnuViews: TdxBarPopupMenu;
    popmnuStoredProcsAddStoredProc: TdxBarButton;
    popmnuStoredProc: TdxBarPopupMenu;
    popmnuView: TdxBarPopupMenu;
    popmnuTablesRefresh: TdxBarButton;
    popmnuViewsRefresh: TdxBarButton;
    popmnuStoredProcsEdit: TdxBarButton;
    popmnuStoredProcDelete: TdxBarButton;
    popmnuStoredProcOpen: TdxBarButton;
    popmnuStoredProcEdit: TdxBarButton;
    popmnuViewDelete: TdxBarButton;
    popmnuViewEdit: TdxBarButton;
    popmnuViewOpen: TdxBarButton;
    popmnuTrigger: TdxBarPopupMenu;
    popmnuTriggers: TdxBarPopupMenu;
    popmnuTriggersRefresh: TdxBarButton;
    popmnuTriggerDelete: TdxBarButton;
    popmnuTriggerEdit: TdxBarButton;
    popmnuTriggersAdd: TdxBarButton;
    popmnuViewsAdd: TdxBarButton;
    popmnuStoredProcsAdd: TdxBarSubItem;
    popmnuStoredProcsAddFunction: TdxBarButton;
    popmnuCheckConstraints: TdxBarPopupMenu;
    popmnuCheckConstraint: TdxBarPopupMenu;
    popmnuCheckConstraintsRefresh: TdxBarButton;
    popmnuCheckConstraintsAdd: TdxBarButton;
    popmnuCheckConstraintDelete: TdxBarButton;
    popmnuCheckConstraintEdit: TdxBarButton;
    popmnuDatabaseRefresh: TdxBarButton;
    popmnuDatabaseDesignReport: TdxBarButton;
    popmnuTablePrintPreview: TdxBarButton;
    popmnuTablesRecoverAllTables: TdxBarButton;
    popmnuTablesChangeAllTables: TdxBarButton;
    dxBarSeparator1: TdxBarSeparator;
    popmnuDatabaseDDCG: TdxBarButton;
    dxBarSeparator2: TdxBarSeparator;
    popmnuTableStreams: TdxBarButton;
    popmnuServerCloseInactive: TdxBarButton;
    tiRightSelect: TTimer;
    popmnuTablesVerifyAllTables: TdxBarButton;
    popmnuTableVerifyTable: TdxBarButton;
    popmnuTablesPackNLS: TdxBarButton;
    popmnuClientToClientMessaging: TdxBarButton;
    popmnuServerProperties: TdxBarButton;
    popmnuServerUsersAndPrivileges: TdxBarButton;
    popmnuDatabaseShowinExplorer: TdxBarButton;
    nxHttpTransport1: TnxHttpTransport;
    procedure acServersRefreshExecute(Sender: TObject);
    procedure acServersRegisterExecute(Sender: TObject);
    procedure acServersBroadcastForServersExecute(Sender: TObject);
    procedure popmnuDatabaseSQLClick(Sender: TObject);
    procedure popmnuTableSetAutoIncClick(Sender: TObject);
    procedure popmnuTableBrowseTableClick(Sender: TObject);
    procedure popmnuTablesPackAllTablesClick(Sender: TObject);
    procedure popmnuDatabaseDeleteClick(Sender: TObject);
    procedure popmnuDatabaseNewTableClick(Sender: TObject);
    procedure popmnuDatabaseRenameClick(Sender: TObject);
    procedure popmnuServerAttachClick(Sender: TObject);
    procedure popmnuServerDetachClick(Sender: TObject);
    procedure popmnuServerNewDatabaseClick(Sender: TObject);
    procedure popmnuServerRefreshDatabaseListClick(Sender: TObject);
    procedure popmnuTableDefinitionClick(Sender: TObject);
    procedure popmnuTableDeleteClick(Sender: TObject);
    procedure popmnuTableEmptyClick(Sender: TObject);
    procedure popmnuTableImportCSVClick(Sender: TObject);
    procedure popmnuTableNewClick(Sender: TObject);
    procedure popmnuTablePackClick(Sender: TObject);
    procedure popmnuTableRestructureClick(Sender: TObject);
    procedure popmnuTableReindexClick(Sender: TObject);
    procedure tvServersDblClick(Sender: TObject);
    procedure tvServersEdited(Sender: TObject; Node: TTreeNode;
      var S: string);
    procedure tvServersEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tvServersExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure tvServersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadPreferences;
    procedure popmnuTablesRefreshClick(Sender: TObject);
    procedure popmnuDatabaseStartTransClick(Sender: TObject);
    procedure popmnuDatabaseCommitTransClick(Sender: TObject);
    procedure popmnuDatabaseRollbackTransClick(Sender: TObject);
    procedure popmnuDatabaseLiveBackupClick(Sender: TObject);
    procedure popmnuDatabaseRestoreClick(Sender: TObject);
    procedure acServersSQLExecute(Sender: TObject);
    procedure acServersSQLUpdate(Sender: TObject);
    procedure popmnuDatabaseCSVImportClick(Sender: TObject);
    procedure popmnuTableEnterPasswordClick(Sender: TObject);
    procedure popmnuTablesEnterPasswordClick(Sender: TObject);
    procedure popmnuTableRecoverClick(Sender: TObject);
    procedure tiAlignTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure popmnuTablesEmptyAllTablesClick(Sender: TObject);
    procedure tvServersContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure popmnuServerPopup(Sender: TObject);
    procedure popmnuDatabasePopup(Sender: TObject);
    procedure popmnuTablePopup(Sender: TObject);
    procedure popmnuTableCloneTableStructureClick(Sender: TObject);
    procedure tvServersClick(Sender: TObject);
    procedure popmnuServerRefreshServerListClick(Sender: TObject);
    procedure popmnuTableChangePasswordClick(Sender: TObject);
    procedure popmnuTablesChangePasswordClick(Sender: TObject);
    procedure popmnuServerCloseUp(Sender: TObject);
    procedure popmnuDatabaseRefIntEditorClick(Sender: TObject);
    procedure popmnuChildTablePopup(Sender: TObject);
    procedure popmnuStoredProcsRefreshClick(Sender: TObject);
    procedure popmnuViewsRefreshClick(Sender: TObject);
    procedure popmnuStoredProcsAddStoredProcClick(Sender: TObject);
    procedure popmnuStoredProcEditClick(Sender: TObject);
    procedure popmnuStoredProcDeleteClick(Sender: TObject);
    procedure popmnuViewsAddClick(Sender: TObject);
    procedure popmnuViewEditClick(Sender: TObject);
    procedure popmnuViewDeleteClick(Sender: TObject);
    procedure popmnuViewOpenClick(Sender: TObject);
    procedure popmnuTriggersRefreshClick(Sender: TObject);
    procedure popmnuTriggersAddClick(Sender: TObject);
    procedure popmnuTriggerEditClick(Sender: TObject);
    procedure popmnuTriggerDeleteClick(Sender: TObject);
    procedure popmnuStoredProcsAddFunctionClick(Sender: TObject);
    procedure popmnuCheckConstraintsRefreshClick(Sender: TObject);
    procedure popmnuCheckConstraintsAddClick(Sender: TObject);
    procedure popmnuCheckConstraintEditClick(Sender: TObject);
    procedure popmnuCheckConstraintDeleteClick(Sender: TObject);
    procedure popmnuDatabaseRefreshClick(Sender: TObject);
    procedure popmnuDatabaseDesignReportClick(Sender: TObject);
    procedure popmnuTablePrintPreviewClick(Sender: TObject);
    procedure tvServersDeletion(Sender: TObject; aNode: TTreeNode);
    procedure popmnuTablesRecoverAllTablesClick(Sender: TObject);
    procedure popmnuTablesChangeAllTablesClick(Sender: TObject);
    procedure popmnuDatabaseDDCGClick(Sender: TObject);
    procedure popmnuTableStreamsClick(Sender: TObject);
    procedure popmnuServerCloseInactiveClick(Sender: TObject);
    procedure tiRightSelectTimer(Sender: TObject);
    procedure popmnuTablesVerifyAllTablesClick(Sender: TObject);
    procedure popmnuTableVerifyTableClick(Sender: TObject);
    procedure popmnuTablesPackNLSClick(Sender: TObject);
    procedure popmnuClientToClientMessagingClick(Sender: TObject);
    procedure popmnuServerPropertiesClick(Sender: TObject);
    procedure popmnuServerUsersAndPrivilegesClick(Sender: TObject);
    procedure popmnuDatabaseShowinExplorerClick(Sender: TObject);
  protected
    tvEditText                       : String;
    FOnFormActivate                  : TOnFormActivate;
    tvServersLock                    : TCriticalSection;
    NamedPipeActiveBroadcast,
    WinsockActiveBroadcast,
    SharedMemoryActiveBroadcast      : InxActiveBroadcast;
    tbServerBroadcastListWinsock,
    tbServerBroadcastListNamedPipe,
    tbServerBroadcastListSharedMemory,
    tbServerRegisteredList           : TStringList;
    tbInDeleteNodes                  : Boolean;

    function GetNewSelectedNode(aNode: TTreeNode): TTreeNode;
    function AddOutlineServer(aServer     : TnxBaseServerEngine;
                              aTransport  : TnxBaseTransport;
                              aServerName : string): TTreeNode;
    function AddOutlineStoredProc(aNode           : TTreeNode;
                                  aStoredProcName : string;
                                  aNodeType       : TnxemNodeType): TTreeNode;
    function AddOutlineView(aNode: TTreeNode; aViewName: string): TTreeNode;
    function AddOutlineTrigger(aNode: TTreeNode; aTriggerName: string): TTreeNode;
    function AddOutlineCheckConstraint(aNode: TTreeNode; aCheckConstraintName: string): TTreeNode;
    procedure DeleteNodeChildren(aNode: TTreeNode);
    procedure LoadOutlineServers;
    procedure LoadRegisteredOutlineServers;
    function AddOutlineChildTable(aParentNode : TTreeNode;
                                  aTableName  : string)
                                              : TTreeNode;
    procedure FreeOutlineObjects;
    procedure slServerAttach(aServerIndex: Integer);
    procedure SetStatusText(aText: string);
    procedure WarnAboutOutsideTransactionMethod;
    procedure LoadInternalServerAliasList(Node : TTreeNode);
    procedure WMChangeTreeNodeText(var Msg : TMessage); message WM_ChangeTreeNodeText;
    procedure CloseDictionaryBrowser(aTableNode: TTreeNode; aUnconditionalClose : Boolean);
    procedure CloseAllDictionaryBrowsers(aDatabase: TTreeNode);
    procedure CloseAllSQLBrowsers(aDatabase: TTreeNode);
    function ServerHasOpenTabs(aServerNode : TTreeNode) : Boolean;
    procedure SetPasswordOnTable(aTable: TnxTableRefCount; aPassword: String);
    procedure ChangePasswordOnTable(aTable: TnxTableRefCount; aPassword: String);
    procedure UpdateServerPopupMenu;
    procedure UpdateDatabasePopupMenu;
    procedure UpdateTablePopupMenu;
    procedure UpdateChildTablePopupMenu;
    procedure PackSingleTable(aNode: TTreeNode; RebuildProgress : TfrmRebuildProgress; aPackAll : Boolean);
    procedure OpenDictionaryBrowser(Editing: Boolean);
    function SqlBrowserCaptionFromNodeType(aNodeType: TnxemNodeType): string;
    procedure SaveRightClickSelected;

    procedure DoFormActivate;
  public
    { Public declarations }
    ActiveTransactionCount : Integer;
    ActivePopupMenu        : TdxBarPopupMenu;
    tbServerDropList       : TStringList;
    tbNodeDataList         : TStringList;
    SavedSelected          : TTreeNode;

    function DoAttach(aNode: TTreeNode): TnxResult;
    procedure DoDetach;
    procedure ShowQueryBrowser(aFromNodeType : TnxemNodeType; aSQLText : String; aAutoExecute : Boolean);
    function GetTreeNodeFromObject(aObject: TnxemNode): TTreeNode;
    function GetNodeObject(aNode: TTreeNode): TnxemNode;
    function GetSelectedNodeObject: TnxemNode;
    procedure LoadOutlineDatabases(aNode: TTreeNode);
    procedure LoadOutlineTables(aNode: TTreeNode);
    procedure LoadOutlineStoredProcs(aNode: TTreeNode);
    procedure LoadOutlineViews(aNode: TTreeNode);
    procedure LoadOutlineTriggers(aNode: TTreeNode);
    procedure LoadOutlineCheckConstraints(aNode: TTreeNode);
    function AddOutlineTable(aNode: TTreeNode; aTableName: string) : TTreeNode;
    function AddOutlineDatabase(aNode: TTreeNode; aAlias: string): TTreeNode;
    function AddNewTable(aDatabase: TnxDatabase; aTableName: string) : TTreeNode;
    procedure Initialize;
    function OpenAndCheckPassword(aTable : TnxTableRefCount) : Boolean;
    procedure ShowTableBrowser(aTable: TnxTableRefCount);
    function CloseTableBrowser(aTable : TnxTableRefCount; aCloseChildren : Boolean) : Boolean;
    function GetNodePath(aNode: TTreeNode): string;
    procedure CloseAllTableBrowsers(aTables: TTreeNode);
    function GetServerNode(aNode: TTreeNode): TTreeNode;
    procedure SaveInternalServerAliasList;
    procedure LoadOutlineChildTables(aParentNode       : TTreeNode;
                                     aDataDictionary   : TnxDataDictionary;
                                     aTablesDescriptor : TnxTablesDescriptor);
  published
    property
      OnFormActivate : TOnFormActivate read FOnFormActivate;
  end;

  EnxTreeBrowserException = class(EnxBaseException);

var
  frmTreeBrowser              : TfrmTreeBrowser;

implementation

{$R *.dfm}

uses
  Types,
  Db,
  StrUtils,
  System.Threading,
  ShellApi,
  System.IOUtils,

  dxDockPanel,
  dxDockControl,

  CustomAccessValidation,
  {$IFDEF EMIncludeReportEngine}
  nxemReportEngineFastReport,
  {$ENDIF}
  nxllJwaWinsock2,
  nxllConst,
  nxpvLoginFrm,
  fmMainForm,
  nxdbBase,
  nxllBDE,
  nxreRemoteServerEngine,
  nxllZipCompressor,
  nxllRleCompressor,
  nxllLz4Compressor,
  nxtsBaseSecuredTransport,
  nxtsBlowfishRC4SecuredTransport,
  {$IFDEF NX_SECURE_PRO}
  nxspBaseDHSecuredTransport,
  nxspDH2048withAESSecuredTransport,
  nxspDH8192withAESSecuredTransport,
  nxspDH8192withShaCalSecuredTransport,
  {$ENDIF}
  dgCSVImportNexus,
  unConfigInfo,
  dgAddDatabase,
  dgRegisteredServers,
  dgSelectIndex,
  nxsdTypes,
  nxsdConst,
  nxsdTableMapperDescriptor,
  nxsdDataDictionaryAudit,
  nxllStreams,
  nxllBdeStrings,
  nxllUtils,
  fmDictionaryBrowser2,
  dgSetAutoinc,
  fmBaseBrowser,
  fmTableBrowser,
  fmQueryBrowser,
  frmLiveBackup,
  dgLoginDialog,
  dgInputQueryString,
  dgChangeAllTables,
  fmTableStreams,
  //.. nxemGlyphs,
  dmMain,
  dgVerifyTables,
  dgClientMessaging,
  dgConnectionProperties,
  dgUsersAndPrivileges,

  nxRefIntegEditor,
  nxKPJclasses,

  nxcgMain,
  nxcgWizard;


resourcestring
  rsActiveTransactionGoAheadAnyway       = 'active transaction. Go ahead anyway?';
  rsAreYouSureYouWantToPackAllTables     = 'Are you sure you want to pack all tables?';
  rsAreYouSureYouWantToPackAllNLSTables  = 'Are you sure you want to pack all tables requiring NLS Index updates?';
  rsAreYouSureYouWantToEmptyAllTables    = 'Are you sure you want to empty all tables?';
  rsAreYouSureYouWantToRecoverAllTables  = 'Are you sure you want to recover all tables?';
  rsAreYouSureYouWantToStartTheTrans     = 'Are you sure you want to start the transaction?';
  rsBrowseTableInDatabase                = '%s in %s [%s]';
  rsCAUTIONDoNotUseThisCommandInALiv     = 'CAUTION: Do not use this command in a live environment. ';
  rsSharedMemory                         = ' (SharedMemory)';
  rsCouldNotActivateDatabaseAlias        = 'Could not activate database alias: ';
  rsCouldNotBeOpenedThisErrorIsLikel     = '" could not be opened. This error is likely caused by another server locking the directory.';
  rsCreateADatabaseFirstOrChooseAnot     = 'Create a database first or choose another server.';
  rsDelete                               = 'Delete ';
  rsDeleteAllRecordsIn                   = 'Delete all records in ';
  rsDeleteTable                          = 'Delete table %s?';
  rsDeleteTrigger                        = 'Delete trigger %s?';
  rsDeleteView                           = 'Delete view %s?';
  rsDeleteStoredProc                     = 'Delete procedure/function %s?';
  rsDeleteCheck                          = 'Delete check constraint %s?';
  rsErrorMessage                         = ', error message: ';
  rsFailedToConnectErrorMessage          = 'Failed to connect, error message: ';
  rsImmediatelyAndCannotBeRolledBack     = 'immediately, and cannot be rolled back as part of the currently ';
  rsInMemory                             = 'In Memory';
  rsInvalidPasswordUnableToOpenTable     = 'Invalid password. Unable to open table.';
  rsKey                                  = 'Key:';
  rsLoadingRegisteredServers             = 'Loading registered servers...';
  rsNamedPipe                            = ', NamedPipe)';
  rsNamedPipe1                           = ' (NamedPipe)';
  rsHttp1                                = ' (Http)';
  rsNoActiveNexusDBServersFound          = 'No active NexusDB servers found.';
  rsOn                                   = ' on ';
  rsPacking                              = ' (packing)';
  rsPacking1                             = 'Packing';
  rsRecovering                           = 'Recovering';
  rsRestructuring                        = 'Restructuring';
  rsPassword                             = 'Password:';
  rsPasswordToOpenTable                  = 'Password to open Table "';
  rsPasswordToOpenTable1                 = 'Password to open Table';
  rsProblemOpeningTable                  = 'Problem opening table: ';
  rsQueryDatabase                        = 'Query Database: ';
  rsSQL                                  = 'SQL: ';
  rsView                                 = 'View: ';
  rsTrigger                              = 'Trigger: ';
  rsStoredProc                           = 'Stored Proc: ';
  rsCheckConstraint                      = 'Check Constraint: ';
  rsTable                                = 'Table: ';
  rsReindexing                           = ' (reindexing)';
  rsReindexing1                          = 'Reindexing';
  rsSecuredTransportKey                  = 'Secured Transport Key';
  rsSetTablePassword                     = 'Set Table Password';
  rsChangeTablePassword                  = 'Change Table Password';
  rsSetTablePasswordForAllTables         = 'Set Table Password For All Tables';
  rsChangeTablePasswordForAllTables      = 'Change Table Password For All Tables';
  rsStartingAManualTransactionMightL     = 'Starting a manual transaction might lock out other users from ';
  rsTableHasNoAutoincField               = 'Table has no Autoinc field.';
  rsTheAlias                             = 'The alias "';
  rsTheDatabase                          = 'the database.';
  rsTheOperationYouAreAttemptingWill     = 'The operation you are attempting will be performed ';
  rsTransactionAlreadyInProgressYouM     = 'Transaction already in progress. You must commit or rollback ';
  rsUnableToOpenDatabaseErrorMessage     = 'Unable to open database. Error Message: ';
  rsUnknown                              = 'unknown';
  rsWinsock                              = ', Winsock)';
  rsWinsock1                             = ' (Winsock)';
  rsYourCurrentTransactionFirst          = 'your current transaction first.';
  rsRecoveredTableNames                  = 'Recovery finished. Recovered records were copied into %0:s_Recovered.Nx1, unrecoverable records into %0:s_Failed.Nx1.';
  rsRecoveredAllTables                   = 'Recovery finished. Recovered records were copied into <tablename>_Recovered.Nx1, unrecoverable records into <tablename>_Failed.Nx1.';
  rsNoServerActivated                    = 'No server has been activated yet. Connect to a server by doubleclicking it, or pressing Enter when the item is active.';
  rsEM_RI_SettingsFileName               = '\nxEnterpriseManagerRISettings.ini';
  rsCouldNotAddStoredProc                = 'Could not add Stored Procedure, error: ';
  rsCouldNotAddView                      = 'Could not add View, error: ';
  rsCouldNotAddTrigger                   = 'Could not add Trigger, error: ';
  rsCouldNotAddCheckConstraint           = 'Could not add Check Constraint, error: ';
  rsTablesNeededPacking                  = '%d tables of %d needed Packing.';
  rsServerMustBe310                      = 'The server must be at least version 3.10 to support this function.';
  rsPackingFinished                      = 'Packing finished';
  rsErrorsOccured                        = 'Errors occured on the following tables during processing:';

  csCreateStoredProc                  = 'CREATE OR ALTER PROCEDURE Insert_New_Name_Here' + #13#10 +
                                        '( /* IN Insert_Parameters_Here BOOLEAN */ )' + #13#10 +
                                        '-- READS SQL DATA -- needs either read-access' + #13#10 +
                                        '-- MODIFIES SQL DATA -- or write access' + #13#10 +
                                        'BEGIN' + #13#10 +
                                        '  ...procedure body...' + #13#10 +
                                        'END';

  csCreateFunction                    = 'CREATE OR ALTER FUNCTION Insert_New_Name_Here' + #13#10 +
                                        '( /* Insert_Parameters_Here BOOLEAN */ )' + #13#10 +
                                        'RETURNS ...datatype | table...' + #13#10 +
                                        'BEGIN' + #13#10 +
                                        '  ...function body...' + #13#10 +
                                        'END';

  csCreateView                        = 'CREATE VIEW Insert_New_Name_Here AS (' + #13#10 +
                                        'SELECT ...fields... FROM ...table...)';

  csCreateTrigger                     = 'CREATE OR ALTER TRIGGER Insert_New_Name_Here ' + #13#10 +
                                        'BEFORE | AFTER INSERT, DELETE, UPDATE ON ...tablename...' + #13#10 +
                                        'REFERENCING OLD AS o NEW AS n' + #13#10 +
                                        'BEGIN' + #13#10 +
                                        '  IF INSERTING THEN' + #13#10 +
                                        '    ...' + #13#10 +
                                        '  ELSEIF UPDATING THEN' + #13#10 +
                                        '    ...' + #13#10 +
                                        '  ELSEIF DELETING THEN' + #13#10 +
                                        '    ...' + #13#10 +
                                        '  END IF;' + #13#10 +
                                        'END';

  csCreateCheckConstraint             = 'ALTER TABLE %s ' + #13#10 +
                                        'ADD CONSTRAINT %s CHECK ' + #13#10 +
                                        '( %s );' + #13#10;

  csInsert_Name_Here                  = 'Insert_Name_Here';
  csInsert_New_Name_Here              = 'Insert_New_Name_Here';

  csDropRoutine                       = 'DROP ROUTINE IF EXISTS %s;' + #13#10 + #13#10;
  csDropView                          = 'DROP VIEW IF EXISTS %s;' + #13#10 + #13#10;
  csDropTrigger                       = 'DROP TRIGGER IF EXISTS %s;' + #13#10 + #13#10;
  csDropCheckConstraint               = 'ALTER TABLE %s ' + #13#10 +
                                        'DROP CONSTRAINT IF EXISTS %s;' + #13#10 + #13#10;
const
  cs2405                             = '$2405';
  csAliases                          = '.Aliases';
  csSELECTFROM                       = 'SELECT * FROM "';
  csCreateDatabase                   = 'CREATE ALIAS "<your alias here>" FROM ''<path to physical data here>''';

  csDnsNameMarker                    = '---';

  { Outline levels for treeview icons }
  nxc_AttachedServerImageIndex        = 12;
  nxc_DetachedServerImageIndex        = 13;
  nxc_DatabaseImageIndex              = 14;
  nxc_DatabaseInTransactionImageIndex = 15;
  nxc_SqlImageIndex                   = 31;
  nxc_TableImageIndex                 = 49;
  nxc_TablesImageIndex                = 16;
  nxc_ProcedureImageIndex             = 50;
  nxc_StoredProcsImageIndex           = 51;
  nxc_ViewImageIndex                  = 53;
  nxc_ViewsImageIndex                 = 52;
  nxc_FunctionImageIndex              = 54;
  nxc_TriggerImageIndex               = 55;
  nxc_TriggersImageIndex              = 56;
  nxc_CheckConstraintsImageIndex      = 57;
  nxc_CheckConstraintImageIndex       = 58;


type
  TnxWideBlobQuery = class(TnxQuery)
  protected
    procedure InternalInitFieldDefs; override;
  end;

  TnxCrackMemoField = class(TnxMemoField);

var
  WinsockBroadcastReplyHandler,
  NamedPipeBroadcastReplyHandler,
  SharedMemoryBroadcastReplyHandler : InxBroadcastReplyHandler;


procedure TnxWideBlobQuery.InternalInitFieldDefs;
var
  F        : integer;
  FieldDef : TFieldDef;
begin
  inherited;
  for f := 0 to FieldDefs.Count - 1 do begin
    FieldDef := FieldDefs[f];
    if FieldDef.DataType = ftBlob then
      FieldDef.DataType := ftMemo;
  end;
end;


{ utility functions }
function ServerIsRegistered(const ServerName: string; const RegisteredServerList : TStrings): Boolean;
var
  Idx                       : Integer;
begin
  Result := False;
  with Config do
    for Idx := 0 to Pred(RegisteredServerList.Count) do
      if AnsiCompareText(ServerName, RegisteredServerList[Idx]) = 0 then begin
        Result := True;
        Exit;
      end;
end;

procedure UpdateAllChildNodesInListWithDnsName(const aParent: TTreeNode; const aDnsName : string);
var
  Index         : Integer;
  NodePath      : string;
  ChildNode     : TTreeNode;
begin
  ChildNode := aParent.getFirstChild;
  with frmTreeBrowser do
    while Assigned(ChildNode) do begin
      Index := tbNodeDataList.IndexOfObject(GetNodeObject(ChildNode));
      NodePath := tbNodeDataList[Index];
      if Pos(csDnsNameMarker, NodePath) > 0 then
        tbNodeDataList[Index] := StringReplace(NodePath, csDnsNameMarker, aDnsName, []);
      UpdateAllChildNodesInListWithDnsName(ChildNode, aDnsName);
      ChildNode := aParent.GetNextChild(ChildNode);
    end;
end;

procedure GetDnsNameAsync(const aTreeNode : TTreeNode; const aIP : string);
begin
  TTask.Run(
    procedure
    var
      SockAddrIn                  : TSockAddrIn;
      HostEnt                     : PHostEnt;
      IP                          : AnsiString;
      Index                       : Integer;
    begin
      IP := AnsiString(IfThen(Pos('@', aIP) > 0, Copy(aIP, Succ(Pos('@', aIP)), Length(aIP)), aIP));
      SockAddrIn.sin_addr.s_addr := inet_addr(PAnsiChar(IP));
      HostEnt := gethostbyaddr(@SockAddrIn.sin_addr.s_addr, 4, PF_INET);
      if Assigned(Application) and (not Application.Terminated) and (HostEnt <> nil) and (Pos(csDnsNameMarker, aTreeNode.Text) > 0) then
        TThread.Synchronize(TThread.Current,
          procedure
          begin
            UpdateAllChildNodesInListWithDnsName(aTreeNode, HostEnt.h_name);
            Index := frmTreeBrowser.tbNodeDataList.IndexOf(aTreeNode.Text + '\');
            aTreeNode.Text := StringReplace(aTreeNode.Text, csDnsNameMarker, HostEnt.h_name, []);
            frmTreeBrowser.tbNodeDataList[Index] := aTreeNode.Text + '\';
          end);
    end);
end;

{ TfrmTreeBrowser }

procedure TfrmTreeBrowser.Initialize;
begin
  try
    LoadPreferences;
    LoadOutlineServers;
  except
    on E: Exception do
      showMessage(E.Message);
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.AddOutlineDatabase(aNode: TTreeNode; aAlias: string): TTreeNode;
var
  NodeObject,
  SubNodeObject               : TnxemNode;
  Path                        : String;
  SubNode                     : TTreeNode;

  function InMemoryOrPath(aPath : String) : String;
  begin
    if Copy(aPath, 1, 1)='#' then
      Result := rsInMemory
    else
      Result := aPath;
  end;

begin
  Result := nil;
  NodeObject := TnxemNode.Create;
  NodeObject.Database := TnxDatabase.Create(nil);
  NodeObject.Database.AliasName := aAlias;
  with tvServers do try
    case GetNodeObject(aNode).NodeType of
      ntServer: begin
          NodeObject.Database.Session := GetNodeObject(aNode).Session;
          try
            NodeObject.Database.Session.GetAliasPath(aAlias, Path);
          except
            Path := rsUnknown;
          end;
          Result := Items.AddChild(aNode,
            NodeObject.Database.AliasName + ' (' + InMemoryOrPath(Path) + ')');
          Result.ImageIndex := nxc_DatabaseImageIndex;
          Result.SelectedIndex := nxc_DatabaseImageIndex;
          tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
//          aNode.Expand(True);
        end;
      ntDatabase: begin
          NodeObject.Database.Session := GetNodeObject(aNode.Parent).Session;
          try
            NodeObject.Database.Session.GetAliasPath(aAlias, Path);
          except
            Path := rsUnknown;
          end;
          Result := Items.Add(aNode,
            NodeObject.Database.AliasName + ' (' + InMemoryOrPath(Path) + ')');
          Result.ImageIndex := nxc_DatabaseImageIndex;
          Result.SelectedIndex := nxc_DatabaseImageIndex;
          tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
//          aNode.Parent.Expand(True);
        end;
    end;
    if assigned(Result) then begin
      Result.HasChildren := True;

      SubNodeObject := TnxemNode.Create;
      SubNodeObject.Database := NodeObject.Database;
      SubNodeObject.NodeType := ntTables;
      NodeObject.TablesNodeObject := SubNodeObject;
      SubNode := Items.AddChild(Result, 'Tables');
      with SubNode do begin
        HasChildren := True;
        ImageIndex := nxc_TablesImageIndex;
        SelectedIndex := nxc_TablesImageIndex;
      end;
      tbNodeDataList.AddObject(GetNodePath(SubNode), SubNodeObject);

      SubNodeObject := TnxemNode.Create;
      SubNodeObject.Database := NodeObject.Database;
      SubNodeObject.NodeType := ntViews;
      NodeObject.ViewsNodeObject := SubNodeObject;
      SubNode := Items.AddChild(Result, 'Views');
      with SubNode do begin
        HasChildren := True;
        ImageIndex := nxc_ViewsImageIndex;
        SelectedIndex := nxc_ViewsImageIndex;
      end;
      tbNodeDataList.AddObject(GetNodePath(SubNode), SubNodeObject);

      SubNodeObject := TnxemNode.Create;
      SubNodeObject.Database := NodeObject.Database;
      SubNodeObject.NodeType := ntTriggers;
      NodeObject.TriggersNodeObject := SubNodeObject;
      SubNode := Items.AddChild(Result, 'Triggers');
      with SubNode Do begin
        HasChildren := True;
        ImageIndex := nxc_TriggersImageIndex;
        SelectedIndex := nxc_TriggersImageIndex;
      end;
      tbNodeDataList.AddObject(GetNodePath(SubNode), SubNodeObject);

      SubNodeObject := TnxemNode.Create;
      SubNodeObject.Database := NodeObject.Database;
      SubNodeObject.NodeType := ntStoredProcs;
      NodeObject.StoredProcsNodeObject := SubNodeObject;
      SubNode := Items.AddChild(Result, 'Stored Procedures');
      with SubNode Do begin
        HasChildren := True;
        ImageIndex := nxc_StoredProcsImageIndex;
        SelectedIndex := nxc_StoredProcsImageIndex;
      end;
      tbNodeDataList.AddObject(GetNodePath(SubNode), SubNodeObject);

      SubNodeObject := TnxemNode.Create;
      SubNodeObject.Database := NodeObject.Database;
      SubNodeObject.NodeType := ntCheckConstraints;
      NodeObject.CheckConstraintsNodeObject := SubNodeObject;
      SubNode := Items.AddChild(Result, 'Check Constraints');
      with SubNode Do begin
        HasChildren := True;
        ImageIndex := nxc_CheckConstraintsImageIndex;
        SelectedIndex := nxc_CheckConstraintsImageIndex;
      end;
      tbNodeDataList.AddObject(GetNodePath(SubNode), SubNodeObject);

    end;
    aNode.AlphaSort;
  except
    on E: Exception do
      MessageDlg(rsCouldNotActivateDatabaseAlias+aAlias+rsErrorMessage+E.Message, mtInformation, [mbOK], 0);
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.GetNodePath(aNode: TTreeNode) : string;
begin
  Result := '';
  while Assigned(aNode) do begin
    Result := aNode.Text + '\' + Result;
    aNode := aNode.Parent;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.AddOutlineServer(aServer: TnxBaseServerEngine; aTransport: TnxBaseTransport; aServerName: string): TTreeNode;
var
  Node                        : TTreeNode;
  NodeObject                  : TnxemNode;
begin
  NodeObject := TnxemNode.Create;
  NodeObject.ServerEngine := aServer;
  NodeObject.Transport := aTransport;
  if tvServers.Items.Count=0 then
    Node := tvServers.Items.Add(nil, aServerName)
  else
    Node := tvServers.Items.Add(tvServers.Items[0], aServerName);
  if assigned(Node) then begin
    Node.ImageIndex := nxc_DetachedServerImageIndex;
    Node.SelectedIndex := nxc_DetachedServerImageIndex;
    Node.HasChildren := false;
    tbNodeDataList.AddObject(GetNodePath(Node), NodeObject);
  end;
  Result := Node;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.AddOutlineTable(aNode: TTreeNode; aTableName: string) : TTreeNode;
var
  NodeObject                  : TnxemNode;
begin
  NodeObject := TnxemNode.Create;
  NodeObject.Table := TnxTableRefCount.Create(nil);
  NodeObject.Table.TableName := aTableName;
  NodeObject.Table.Session := GetNodeObject(aNode).Database.Session;
  NodeObject.Table.Database := GetNodeObject(aNode).Database;
  Result := tvServers.Items.AddChild(aNode, aTableName);
  if assigned(Result) then begin
    Result.ImageIndex := nxc_TableImageIndex;
    Result.SelectedIndex := nxc_TableImageIndex;
    Result.HasChildren := False;
    tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
  end;
  aNode.AlphaSort;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.DeleteNodeChildren(aNode: TTreeNode);
begin
  with tvServers do begin
    Items.BeginUpdate;
    tbInDeleteNodes := True;
    try
      aNode.DeleteChildren;
    finally
      Items.EndUpdate;
      tbInDeleteNodes := False;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.DoAttach(aNode: TTreeNode): TnxResult;
var
  SecuredKey                   : String;
  CompressType,
  CompressLimit                : Integer;
begin
  Result := DBIERR_NONE;
  SecuredKey := '';
  try
    if (GetNodeObject(aNode).Transport is TnxBlowfishRC4SecuredTransport) and
       ((GetNodeObject(aNode).Transport as TnxBlowfishRC4SecuredTransport).Key = '') then
      if InputQueryString(rsSecuredTransportKey, rsKey, SecuredKey) then
        (GetNodeObject(aNode).Transport as TnxBlowfishRC4SecuredTransport).Key := AnsiString(SecuredKey)
      else begin
        Result := DBIERR_INVALIDUSRPASS;
        Exit;
      end;

    {$IFDEF NX_SECURE_PRO}
    if (GetNodeObject(aNode).Transport is TnxBaseDHSecuredTransport) and
       ((GetNodeObject(aNode).Transport as TnxBaseDHSecuredTransport).RemotePublicKey = '') then
      if InputQueryString(rsSecuredTransportKey, rsKey, SecuredKey) then
        (GetNodeObject(aNode).Transport as TnxBaseDHSecuredTransport).RemotePublicKey := SecuredKey
      else begin
        Result := DBIERR_INVALIDUSRPASS;
        Exit;
      end;
    {$ENDIF}

    if ((aNode=tvServers.Items[0]) and not CheckCustomAccessValidation('Internal Server')) or
       ((aNode<>tvServers.Items[0]) and not CheckCustomAccessValidation(GetNodeObject(aNode).Transport.ServerName)) then
      Exit;

    if (aNode=tvServers.Items[0]) then begin
      if not GetNodeObject(aNode).Session.Active then begin
        GetNodeObject(aNode).Session.Active := True;
        GetNodeObject(aNode).Session.AbstractSession.OptionSet(csAuditUserIDOptionName, dmEM.EMDescription);
        LoadInternalServerAliasList(tvServers.Items[0]);
      end;
    end
    else begin
      {$IFDEF DEBUG}
//      tnxwinsocktransport(GetNodeObject(aNode).Transport).HeartbeatInterval := 0;
      {$ENDIF}
      if nxeConfigGetConnectionProperties(aNode.Text, CompressType, CompressLimit) then begin
        (GetNodeObject(aNode).Transport as TnxBasePooledTransport).CompressType := CompressType;
        (GetNodeObject(aNode).Transport as TnxBasePooledTransport).CompressLimit := CompressLimit;
      end;
      if GetNodeObject(aNode).Transport is TnxHttpTransport then begin
        with TnxHttpTransport(GetNodeObject(aNode).Transport) do begin
          ClientIgnoreUnknownCA := Config.HttpServerCertIgnore[ServerName].ClientIgnoreUnknownCA;
          ClientIgnoreCertDateInvalid := Config.HttpServerCertIgnore[ServerName].ClientIgnoreCertDateInvalid;
          ClientIgnoreCertCNInvalid := Config.HttpServerCertIgnore[ServerName].ClientIgnoreCertCNInvalid;
          ClientIgnoreCertWrongUsage := Config.HttpServerCertIgnore[ServerName].ClientIgnoreCertWrongUsage;
        end;
      end;
      GetNodeObject(aNode).SetupMessaging;
      GetNodeObject(aNode).Session.Active := True;
      GetNodeObject(aNode).Session.AbstractSession.OptionSet(csAuditUserIDOptionName, dmEM.EMDescription);
      LoadOutlineDatabases(aNode);
      GetNodeObject(aNode).SetServerLicensePluginUsername(PChar(dmEM.EMDescription));
      GetNodeObject(aNode).ActivateMessaging;
    end;

    aNode.ImageIndex := nxc_AttachedServerImageIndex;
    aNode.SelectedIndex := nxc_AttachedServerImageIndex;

    Config.LastServer := aNode.Text;
  except
    on E: Exception do begin
      { if connect attempt fails, reset component chain
        to default inactive state }
      GetNodeObject(aNode).Session.Active := False;
      GetNodeObject(aNode).Session.State := nxsInactive;
      GetNodeObject(aNode).ServerEngine.Active := False;
      GetNodeObject(aNode).ServerEngine.State := nxsInactive;
      if Assigned(GetNodeObject(aNode).Transport) then begin
        GetNodeObject(aNode).Transport.Active := False;
        GetNodeObject(aNode).Transport.State := nxsInactive;
        GetNodeObject(aNode).Transport.Enabled := True;
      end;
      raise EnxTreeBrowserException.Create(rsFailedToConnectErrorMessage + E.Message);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.DoDetach;
var
  i : Integer;
begin
  for i := Pred(tvServers.Selected.Count) downto 0 do
    CloseAllSQLBrowsers(GetTreeNodeFromObject(GetNodeObject(tvServers.Selected.Item[i])));
  for i := 0 to Pred(tvServers.Selected.Count) do begin
    CloseAllTableBrowsers(GetTreeNodeFromObject(GetNodeObject(tvServers.Selected.Item[i]).TablesNodeObject));

    if GetNodeObject(tvServers.Selected.Item[i]).InTransaction then begin
      GetSelectedNodeObject.InTransaction := False;
      Dec(ActiveTransactionCount);
    end;
  end;
  for i := 0 to Pred(tvServers.Selected.Count) do
    CloseAllDictionaryBrowsers(GetTreeNodeFromObject(GetNodeObject(tvServers.Selected.Item[i])));

//  GetSelectedNodeObject.Session.PasswordRemoveAll;

  GetSelectedNodeObject.Session.UserName := '';
  GetSelectedNodeObject.Session.Password := '';
  GetSelectedNodeObject.Session.Active := False;

  //keep internal server running for sql history etc
  if GetSelectedNodeObject.ServerEngine <> dmEM.nxServerEngineInternalServer then begin
    GetSelectedNodeObject.ServerEngine.Active := False;
    if Assigned(GetSelectedNodeObject.Transport) then
      GetSelectedNodeObject.Transport.Active := False
    else
      GetSelectedNodeObject.Session.Active := False;
  end;

  if (GetSelectedNodeObject.Transport is TnxBlowfishRC4SecuredTransport) then
    (GetSelectedNodeObject.Transport as TnxBlowfishRC4SecuredTransport).Key := '';

  GetSelectedNodeObject.TablePasswords.Clear;

  tvServers.Selected.Collapse(True);
  DeleteNodeChildren(tvServers.Selected);
  tvServers.Selected.HasChildren := False;
  tvServers.Selected.ImageIndex := nxc_DetachedServerImageIndex;
  tvServers.Selected.SelectedIndex := nxc_DetachedServerImageIndex;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.GetNodeObject(aNode: TTreeNode): TnxemNode;
var
  idx      : Integer;
  NodePath : string;
begin
  Result := nil;
  NodePath := GetNodePath(aNode);
  if Pos(rsPacking, NodePath) = Length(NodePath) - Length(rsPacking) then
    Delete(NodePath, Pos(rsPacking, NodePath), Length(rsPacking))
  else
  if Pos(rsRestructuring, NodePath) = Length(NodePath) - Length(rsRestructuring) then
    Delete(NodePath, Pos(rsRestructuring, NodePath), Length(rsRestructuring));
  idx := tbNodeDataList.IndexOf(NodePath);
  if idx >= 0 then
    Result := TnxemNode(tbNodeDataList.Objects[idx]);
  Assert(Assigned(Result));
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.GetSelectedNodeObject: TnxemNode;
begin
  Result := GetNodeObject(tvServers.Selected);
  Assert(Assigned(Result));
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.GetServerNode(aNode: TTreeNode): TTreeNode;
begin
  Result := aNode;
  while Assigned(Result.Parent) do
    Result := Result.Parent;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.FreeOutlineObjects;
var
  Index                       : Integer;
begin
  { Free the objects associated with the nodes. }
  with tbNodeDataList do begin
    for Index := 0 to pred(Count) do
      if assigned(Objects[Index]) then
        TObject(Objects[Index]).Free;
  end;
  tvServers.Items.Clear;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadInternalServerAliasList(Node : TTreeNode);
var
  i                           : Integer;
  Strings                     : TstringList;
begin
  { load list of aliases/directories }
  Strings := TstringList.Create;
  Strings.CaseSensitive := False;
  try
    GetNodeObject(Node).Session.GetAliasNames(Strings);

    for i := 0 to Pred(Strings.Count) do
      if not SameText(Strings[i], sEMSystemAlias) then
        GetNodeObject(Node).Session.DeleteAlias(Strings[i]);

    try
      if tvServers.Items[0].Count = 0 then
        AddOutlineDatabase(Node, sEMSystemAlias);
    except
      { swallow errors during initial loading. if user clicks
        database, we'll report problems then. }
    end;

    Strings.Clear;
    nxeConfigGetKeysAndValues(nxc_InternalServerName+csAliases, Strings);

    for i := 0 to Pred(Strings.Count) do begin
      if not SameText(Strings.Names[i], sEMSystemAlias) then begin
        GetNodeObject(Node).Session.AddAlias(Strings.Names[i], Strings.Values[Strings.Names[i]]);
        try
          AddOutlineDatabase(Node, Strings.Names[i]);
        except
          { swallow errors during initial loading. if user clicks
            database, we'll report problems then. }
        end;
      end;
    end;

  finally
    Strings.Free;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadOutlineServers;
begin
  { Load up the servers into the outline }
  SetStatusText(rsLoadingRegisteredServers);
  Screen.Cursor := crHourglass;
  tvServers.Items.BeginUpdate;
  try
    { internal engine first }
    AddOutlineServer(dmEM.nxServerEngineInternalServer, nil, nxc_InternalServerName);

    { then registered servers }
    LoadRegisteredOutlineServers;

    { then broadcast for currently active servers on OS supported transports }
    if (not nxFindCmdLineSwitch('NOBROADCAST')) and
       Config.BroadcastForServers then try
       { Hasta que no solucione el proveedor el uso de mail slots, que ahora son obsoletos, no puedo utilizar el broadcast en named pipe transport
      if NamedPipeTransportBroadcast.Supported then
        NamedPipeActiveBroadcast := NamedPipeTransportBroadcast.BeginBroadcast(NamedPipeBroadcastReplyHandler, 2000);
      }
      if WinsockTransportBroadcast.Supported then
        WinsockActiveBroadcast := WinsockTransportBroadcast.BeginBroadcast(WinsockBroadcastReplyHandler, 2000);
      if SharedMemoryTransportBroadcast.Supported then
        SharedMemoryActiveBroadcast := SharedMemoryTransportBroadcast.BeginBroadcast(SharedMemoryBroadcastReplyHandler, 2000);
    except
      on E: Exception do begin
        ShowMessage('Error in BeginBroadcast: ' + E.Message);
        SetStatusText('');
      end;
    end;

  finally
    tvServers.Items.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadRegisteredOutlineServers;
var
  i                           : Integer;
  NewTransport                : TnxBaseTransport;
  NewSecuredTransport         : TnxBaseSecuredTransport;
  NewPortnumber               : TnxWord16;
  NewServerName               : String;
  TempNode                    : TTreeNode;

  function ExtractPortnumber(aServerName : String; var aNewPortnumber : TnxWord16; var aNewServerName : String) : Boolean;
  var
    ColonPos                  : Integer;
  begin
    Result := False;
    aNewServerName := '';
    ColonPos := Length(aServerName);
    while (ColonPos > 0) and CharInSet(aServerName[ColonPos], ['0'..'9']) and (aServerName[ColonPos] <> ':') do
      Dec(ColonPos);
    if (ColonPos > 0) and (aServerName[ColonPos] = ':') then begin
      aNewPortnumber := StrToIntDef(Copy(aServerName, ColonPos + 1, Length(aServerName) - ColonPos), aNewPortnumber);
      aNewServerName := Copy(aServerName, 1, Pred(ColonPos));
      Result := True;
    end;
  end;

begin
  { Load up the servers into the outline }
  SetStatusText(rsLoadingRegisteredServers);
  frmMain.acServersRefresh.Enabled := False;
  frmMain.acServersRegister.Enabled := False;
  Screen.Cursor := crHourglass;
  tvServers.Items.BeginUpdate;
  try
    for i := Pred(tbServerDropList.Count) downto 0 do
      if (Config.RegisteredTcpIpServers.IndexOf(tbServerDropList[i]) < 0) and
         (Config.RegisteredNamedPipeServers.IndexOf(tbServerDropList[i]) < 0) and
         (Config.RegisteredHttpServers.IndexOf(tbServerDropList[i]) < 0) and
         (tbServerRegisteredList.IndexOf(tbServerDropList[i]) >= 0) then begin
        tvServers.Selected := TTreeNode(tbServerRegisteredList.Objects[
          tbServerRegisteredList.IndexOf(tbServerDropList[i])]);
        tbServerRegisteredList.Delete(tbServerRegisteredList.IndexOf(tbServerDropList[i]));
        DoDetach;
        tvServers.Items.Delete(tvServers.Selected);
      end;

    with Config.RegisteredTcpIpServers do
    for I := 0 to Count - 1 do
      if tbServerRegisteredList.IndexOf(Strings[i]) < 0 then begin
        if (Pos(SecuredTransportMarkerChars, Config.RegisteredTcpIpServers[i])>0) and
           Assigned(TnxRegisterableComponent.FindRegisteredClass(
             Copy(Config.RegisteredTcpIpServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredTcpIpServers[i])+2, Length(Config.RegisteredTcpIpServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredTcpIpServers[i])+2)))) then begin
          NewSecuredTransport := TnxBaseSecuredTransport(TnxRegisterableComponent.FindRegisteredClass(Copy(Config.RegisteredTcpIpServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredTcpIpServers[i])+2, Length(Config.RegisteredTcpIpServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredTcpIpServers[i])+2))).Create(nil));
          if Assigned(NewSecuredTransport) then begin
            TnxBaseSecuredTransport(NewSecuredTransport).Transport := TnxWinsockTransport.Create(nil);
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := Copy(Strings[I], 1, Pos(SecuredTransportMarkerChars, Strings[i])-1);
            NewPortnumber := 17000;
            TnxWinsockTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).CallbackThreadCount := 2;
            if ExtractPortnumber(TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName, NewPortnumber, NewServerName) then
              TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := NewServerName;
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.Enabled := True;
            if NewServerName <> '' then
              TnxWinsockTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := NewPortnumber
            else
              TnxWinsockTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := 17000;
            NewSecuredTransport.Enabled := True;
            TnxWinsockTransport(NewSecuredTransport.Transport).HeartbeatInterval := Config.KeepaliveFrequency;

            TempNode := AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewSecuredTransport, Copy(Strings[I], 1,
                                         Pred(Length(Strings[I]))) + rsWinsock + ' [' + csDnsNameMarker + ']');
            tbServerRegisteredList.AddObject(Strings[i], TempNode);
            GetDnsNameAsync(TempNode, TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName);
           end;
        end
        else begin
          NewTransport := TnxWinsockTransport.Create(nil);
          NewTransport.ServerName := Strings[I];
          NewPortnumber := 16000;
          if ExtractPortnumber(NewTransport.ServerName, NewPortnumber, NewServerName) then begin
            TnxWinsockTransport(NewTransport).Port := NewPortnumber;
            TnxWinsockTransport(NewTransport).ServerName := NewServerName;
          end;
          TnxWinsockTransport(NewTransport).CallbackThreadCount := 2;
          NewTransport.Enabled := True;
          TnxWinsockTransport(NewTransport).HeartbeatInterval := Config.KeepaliveFrequency;
          TempNode := AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewTransport, Strings[I] + rsWinsock1 + ' [' + csDnsNameMarker + ']');
          tbServerRegisteredList.AddObject(Strings[i], TempNode);
          GetDnsNameAsync(TempNode, TnxWinsockTransport(NewTransport).ServerName);
        end;
      end;

    with Config.RegisteredNamedPipeServers do
    for I := 0 to Count - 1 do begin
      if tbServerRegisteredList.IndexOf(Strings[i]) < 0 then
        if (Pos(SecuredTransportMarkerChars, Config.RegisteredNamedPipeServers[i]) > 0) and
            Assigned(TnxBaseTransport(TnxRegisterableComponent.FindRegisteredClass(
              Copy(Config.RegisteredNamedPipeServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredNamedPipeServers[i])+2, Length(Config.RegisteredNamedPipeServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredNamedPipeServers[i])+2))))) then begin
          NewSecuredTransport := TnxBaseSecuredTransport(TnxRegisterableComponent.FindRegisteredClass(Copy(Config.RegisteredNamedPipeServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredNamedPipeServers[i])+2, Length(Config.RegisteredNamedPipeServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredNamedPipeServers[i])+2))).Create(nil));
          if Assigned(NewSecuredTransport) then begin
            TnxBaseSecuredTransport(NewSecuredTransport).Transport := TnxNamedPipeTransport.Create(nil);
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := Copy(Strings[I], 1, Pos(SecuredTransportMarkerChars, Strings[i])-1);
            NewPortnumber := 17000;
            TnxNamedPipeTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).CallbackThreadCount := 2;
            if ExtractPortnumber(TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName, NewPortnumber, NewServerName) then
              TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := NewServerName;
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.Enabled := True;
            if NewServerName <> '' then
              TnxNamedPipeTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := NewPortnumber
            else
              TnxNamedPipeTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := 17000;
            NewSecuredTransport.Enabled := True;
            TnxNamedPipeTransport(NewSecuredTransport.Transport).HeartbeatInterval := Config.KeepaliveFrequency;
            tbServerRegisteredList.AddObject(Strings[i], AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewSecuredTransport, Copy(Strings[I], 1, Pred(Length(Strings[I]))) + rsNamedPipe));
          end;
        end
        else begin
          NewTransport := TnxNamedPipeTransport.Create(nil);
          NewTransport.ServerName := Strings[I];
          NewTransport.Enabled := True;
          TnxNamedPipeTransport(NewTransport).HeartbeatInterval := Config.KeepaliveFrequency;
          TnxNamedPipeTransport(NewTransport).CallbackThreadCount := 2;
          tbServerRegisteredList.AddObject(Strings[i], AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewTransport, Strings[I] + rsNamedPipe1));
        end;
      end;

    with Config.RegisteredHttpServers do
    for I := 0 to Count - 1 do begin
      if tbServerRegisteredList.IndexOf(Strings[i]) < 0 then
        if (Pos(SecuredTransportMarkerChars, Config.RegisteredHttpServers[i]) > 0) and
            Assigned(TnxBaseTransport(TnxRegisterableComponent.FindRegisteredClass(
              Copy(Config.RegisteredHttpServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredHttpServers[i])+2, Length(Config.RegisteredHttpServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredHttpServers[i])+2))))) then begin
          NewSecuredTransport := TnxBaseSecuredTransport(TnxRegisterableComponent.FindRegisteredClass(Copy(Config.RegisteredHttpServers[i], Pos(SecuredTransportMarkerChars, Config.RegisteredHttpServers[i])+2, Length(Config.RegisteredHttpServers[i])-(Pos(SecuredTransportMarkerChars, Config.RegisteredHttpServers[i])+2))).Create(nil));
          if Assigned(NewSecuredTransport) then begin
            TnxBaseSecuredTransport(NewSecuredTransport).Transport := TnxHttpTransport.Create(nil);
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := Copy(Strings[I], 1, Pos(SecuredTransportMarkerChars, Strings[i])-1);
            NewPortnumber := 17000;
            TnxHttpTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).CallbackThreadCount := 2;
            if ExtractPortnumber(TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName, NewPortnumber, NewServerName) then
              TnxBaseSecuredTransport(NewSecuredTransport).Transport.ServerName := NewServerName;
            TnxBaseSecuredTransport(NewSecuredTransport).Transport.Enabled := True;
            if NewServerName <> '' then
              TnxHttpTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := NewPortnumber
            else
              TnxHttpTransport(TnxBaseSecuredTransport(NewSecuredTransport).Transport).Port := 17000;
            NewSecuredTransport.Enabled := True;
            TnxHttpTransport(NewSecuredTransport.Transport).HeartbeatInterval := Config.KeepaliveFrequency;
            tbServerRegisteredList.AddObject(Strings[i], AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewSecuredTransport, Copy(Strings[I], 1, Pred(Length(Strings[I]))) + rsHttp1));
          end;
        end
        else begin
          NewTransport := TnxHttpTransport.Create(nil);
          NewTransport.ServerName := Strings[I];
          NewTransport.Enabled := True;
          TnxHttpTransport(NewTransport).HeartbeatInterval := Config.KeepaliveFrequency;
          TnxHttpTransport(NewTransport).CallbackThreadCount := 2;
          TnxHttpTransport(NewTransport).ClientIgnoreUnknownCA := Config.HttpServerCertIgnore[Strings[I]].ClientIgnoreUnknownCA;
          TnxHttpTransport(NewTransport).ClientIgnoreCertDateInvalid := Config.HttpServerCertIgnore[Strings[I]].ClientIgnoreCertDateInvalid;
          TnxHttpTransport(NewTransport).ClientIgnoreCertCNInvalid := Config.HttpServerCertIgnore[Strings[I]].ClientIgnoreCertCNInvalid;
          TnxHttpTransport(NewTransport).ClientIgnoreCertWrongUsage := Config.HttpServerCertIgnore[Strings[I]].ClientIgnoreCertWrongUsage;
          tbServerRegisteredList.AddObject(Strings[i], AddOutlineServer(TnxRemoteServerEngine.Create(nil), NewTransport, Strings[I] + rsHttp1));
        end;
      end;

  finally
    tvServers.Items.EndUpdate;
    Screen.Cursor := crDefault;
    frmMain.acServersRefresh.Enabled := True;
    frmMain.acServersRegister.Enabled := True;
    SetStatusText('');
  end;
end;

procedure TfrmTreeBrowser.popmnuDatabaseShowinExplorerClick(Sender: TObject);
var
  Path : string;
begin
  Path := GetSelectedNodeObject.Database.AliasPath;
  if Path.IsEmpty then
    GetSelectedNodeObject.Database.Session.GetAliasPath(GetSelectedNodeObject.Database.AliasName, Path);
  ShellExecute(Application.Handle, PChar('explore'), PChar(Path), nil, nil, SW_SHOWNORMAL);
end;

{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadOutlineDatabases(aNode: TTreeNode);
var
  AliasIdx,
  i                           : Integer;
  AliasList                   : TStringList;
  DropList                    : TStringList;
  AliasName                   : String;
begin
  if (not GetNodeObject(aNode).ServerEngine.Active) then
    if DoAttach(aNode) <> DBIERR_NONE then
      Exit;

  AliasList := TStringList.Create;
  AliasList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  try
    GetNodeObject(aNode).Session.GetAliasNames(AliasList);
    AliasList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(AliasList.Count) do
      AliasList.Objects[i] := TObject(False);

    { mark tables that already exist in treeview,
      add tables that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      AliasName := GetNodeObject(aNode.Item[i]).Database.AliasName;
      AliasIdx := AliasList.IndexOf(AliasName);
      if AliasIdx>=0 then
        AliasList.Objects[AliasIdx] := TObject(Boolean(AliasIdx>=0))
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new databases to treeview }
    for i := 0 to Pred(AliasList.Count) do
      if not Boolean(AliasList.Objects[i]) then try
        AddOutlineDatabase(aNode, AliasList[i]);
      except
        on E:Exception do
          MessageDlg(rsUnableToOpenDatabaseErrorMessage+E.Message, mtInformation, [mbOK], 0);
      end;

    { delete databases that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

  finally
    Aliaslist.Free;
    DropList.Free;
  end;
  aNode.AlphaSort;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadOutlineTables(aNode: TTreeNode);
var
  i,
  TableIdx                    : Integer;
  TableList                   : TStringList;
  DropList                    : TStringList;

begin
  if GetNodeObject(aNode).NodeType = ntTable then begin
    aNode := aNode.Parent;
    tvServers.Selected := aNode;
  end;

  tvServers.Items.BeginUpdate;
  TableList := TStringList.Create;
  TableList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  try
    try
      GetNodeObject(aNode).Database.Open;
    except
      on E: EnxDatabaseError do
        if Pos(cs2405, E.Message)>0 then begin
          MessageDlg(rsTheAlias + aNode.Text + rsCouldNotBeOpenedThisErrorIsLikel, mtError, [mbOK], 0);
          Exit;
        end
        else
          raise;
      on E: Exception do
        raise;
    end;
    GetNodeObject(aNode).Database.GetTableNames(TableList);

    TableList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(TableList.Count) do
      TableList.Objects[i] := TObject(False);

    { mark tables that already exist in treeview,
      add tables that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      TableIdx := TableList.IndexOf(aNode.Item[i].Text);
      if TableIdx>=0 then
        TableList.Objects[TableIdx] := TObject(Boolean(TableIdx>=0))
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new tables to treeview }
    for i := 0 to Pred(TableList.Count) do
      if not Boolean(TableList.Objects[i]) then
        AddOutlineTable(aNode, TableList[i]);

    { delete tables that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

    aNode.AlphaSort;
  finally
    tvServers.Items.EndUpdate;
    TableList.Free;
    DropList.Free;
  end;

end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadOutlineChildTables(aParentNode       : TTreeNode;
                                                 aDataDictionary   : TnxDataDictionary;
                                                 aTablesDescriptor : TnxTablesDescriptor);
var
  i,
  TableIdx                    : Integer;
  TableList                   : TStringList;
  DropList                    : TStringList;
  CreatedObjects              : Boolean;
  Password                    : String;
begin
  { aDataDicectory/aTablesDescriptor will be nil when
    called for the parent }
  if not Assigned(aDataDictionary) then begin
    aDataDictionary := TnxDataDictionary.Create;
    aTablesDescriptor := aDataDictionary.TablesDescriptor;

    Password := GetNodeObject(aParentNode).Table.Password;
    try
      nxCheck(GetNodeObject(aParentNode).Table.Database.GetDataDictionaryEx(
        GetNodeObject(aParentNode).Table.TableName, Password, aDataDictionary));
    except
      on E: EnxBaseException do
        if E.ErrorCode = DBIERR_INVALIDPASSWORD then begin
          Password := '';
          if InputQueryString('Input Password', 'Password:', Password, True) then begin
            try
              GetNodeObject(aParentNode).Table.Session.PasswordAdd(Password);
              GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
            except
              on E: EnxDatabaseError do
                if E.ErrorCode <> DBIERR_NAMENOTUNIQUE then
                  raise;
              on E: Exception do
                raise;
            end;
            GetNodeObject(aParentNode).Table.Password := Password;
            nxCheck(GetNodeObject(aParentNode).Table.Database.GetDataDictionaryEx(
              GetNodeObject(aParentNode).Table.TableName, Password, aDataDictionary));
          end;
        end
        else
          raise;
    end;

    CreatedObjects := True;
  end
  else
    CreatedObjects := False;

  tvServers.Items.BeginUpdate;
  TableList := TStringList.Create;
  TableList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  try
    for i := 0 to Pred(aTablesDescriptor.TableCount) do
      TableList.Add(aTablesDescriptor.TableDescriptor[i].Name);

    TableList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(TableList.Count) do
      TableList.Objects[i] := TObject(False);

    { mark tables that already exist in treeview,
      add tables that no longer exist in database to droplist }
    for i := 0 to Pred(aParentNode.Count) do begin
      TableIdx := TableList.IndexOf(aParentNode.Item[i].Text);
      if TableIdx>=0 then
        TableList.Objects[TableIdx] := TObject(Boolean(TableIdx>=0))
      else
        DropList.Add(aParentNode.Item[i].Text);
    end;

    { add new tables to treeview }
    for i := 0 to Pred(TableList.Count) do
      if not Boolean(TableList.Objects[i]) then
        LoadOutlineChildTables(AddOutlineChildTable(aParentNode, TableList[i]),
                               aDataDictionary,
                               aTablesDescriptor.TableDescriptor[aTablesDescriptor.GetTableIndexFromName(TableList[i])].TablesDescriptor);

    { delete tables that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aParentNode.Count) downto 0 do
      if (DropList.IndexOf(aParentNode.Item[i].Text)>=0) then
      with tvServers do begin
        aParentNode.Item[i].Delete;
      end;

    aParentNode.AlphaSort;
  finally
    tvServers.Items.EndUpdate;
    TableList.Free;
    DropList.Free;
    if CreatedObjects then
      aDataDictionary.Free;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.SqlBrowserCaptionFromNodeType(aNodeType : TnxemNodeType) : string;
begin
  case aNodeType of
    ntViews, ntView : Result := rsView;
    ntTriggers, ntTrigger : Result := rsTrigger;
    ntStoredProcs, ntProcedure, ntFunction : Result := rsStoredProc;
    ntCheckConstraints, ntCheckConstraint : Result := rsCheckConstraint;
  else
    Result := rsSql;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.ShowQueryBrowser(aFromNodeType : TnxemNodeType; aSQLText : String; aAutoExecute : Boolean);
var
  dummy                       : Boolean;
  DBName,
  SrvName                     : String;
  QueryBrowser                : TfrmQueryBrowser;
  dxDockPanel                 : TdxDockPanel;
  ParentNode                  : TTreeNode;
begin
  if tvServers.IsEditing then
    Exit;

  ParentNode := nil;

  { implicitly check valid directory }
  tvServersExpanding(tvServers, tvServers.Selected, dummy);
  Application.ProcessMessages;
  LockWindowUpdate(frmMain.Handle);
  try
    case GetSelectedNodeObject.NodeType of
      ntChildTable : begin
        DBName := GetSelectedNodeObject.Table.Database.AliasName;
        ParentNode := tvServers.Selected.Parent;
        while not (GetNodeObject(ParentNode).NodeType = ntTable) do
          ParentNode := ParentNode.Parent;
        SrvName := ParentNode.Parent.Parent.Text;
      end;
      ntTable, ntView, ntTrigger, ntProcedure, ntFunction, ntCheckConstraint : begin
        DBName := GetNodeObject(tvServers.Selected.Parent).Database.AliasName;
        SrvName := tvServers.Selected.Parent.Parent.Parent.Text;
      end;
      ntTables, ntViews, ntTriggers, ntStoredProcs, ntCheckConstraints : begin
        DBName := GetSelectedNodeObject.Database.AliasName;
        SrvName := tvServers.Selected.Parent.Parent.Text;
        GetNodeObject(tvServers.Selected.Parent).Database.Open;
      end;
      ntDatabase : begin
        DBName := GetSelectedNodeObject.Database.AliasName;
        SrvName := tvServers.Selected.Parent.Text;
        GetSelectedNodeObject.Database.Open;
      end;
      ntServer : begin
        DBName := '';
        SrvName := tvServers.Selected.Text;
        if tvServers.Selected.HasChildren then
          GetNodeObject(tvServers.Selected.getFirstChild).Database.Open;
      end;
    end;

    dxDockPanel := frmMain.CreateAndDockDockPanel;

    case GetSelectedNodeObject.NodeType of
      ntView            : dxDockPanel.ImageIndex := nxc_ViewImageIndex;
      ntTrigger         : dxDockPanel.ImageIndex := nxc_TriggerImageIndex;
      ntProcedure       : dxDockPanel.ImageIndex := nxc_StoredProcsImageIndex;
      ntFunction        : dxDockPanel.ImageIndex := nxc_FunctionImageIndex;
      ntCheckConstraint : dxDockPanel.ImageIndex := nxc_CheckConstraintImageIndex;
    else
      dxDockPanel.ImageIndex := nxc_SqlImageIndex;
    end;

    dxDockPanel.Font.Size := 9;
    QueryBrowser :=
      TfrmQueryBrowser.CreateWithCaption(dxDockPanel,
        IfThen(frmMain.acGlobalOptionsUseLongTabDescription.Checked,
               SqlBrowserCaptionFromNodeType(GetSelectedNodeObject.NodeType) + DBName + rsOn + SrvName,
               'SQL: ' + DBName));
    QueryBrowser.Parent := dxDockPanel;
    QueryBrowser.ServerNode := tvServers.Selected;

    while GetNodeObject(QueryBrowser.ServerNode).NodeType <> ntServer do
      QueryBrowser.ServerNode := QueryBrowser.ServerNode.Parent;

    FormList.AddFormDockPanelLink(QueryBrowser, dxDockPanel);

    with QueryBrowser do begin
      { If we're pointing to a table entry, get the table's
        database entry from the parent }
      DatabaseName := DBName;
      ServerName := SrvName;

      case GetSelectedNodeObject.NodeType of
        ntChildTable : begin
          DatabaseNode := GetNodeObject(ParentNode.Parent.Parent);
          Database := GetSelectedNodeObject.Table.Database;
          InitialStatement := csSELECTFROM + GetSelectedNodeObject.Table.TableName + '"';
        end;
        ntTable, ntView, ntTrigger, ntProcedure, ntFunction, ntCheckConstraint : begin
          DatabaseNode := GetNodeObject(tvServers.Selected.Parent.Parent);
          Database := GetNodeObject(tvServers.Selected.Parent).Database;
          case GetSelectedNodeObject.NodeType of
            ntTable : InitialStatement := csSELECTFROM + tvServers.Selected.Text + '"';
            ntTrigger,
            ntProcedure,
            ntFunction,
            ntCheckConstraint,
            ntView  : InitialStatement := aSQLText;
          end;
        end;
        ntTables, ntTriggers, ntStoredProcs, ntViews, ntCheckConstraints : begin
          DatabaseNode := GetNodeObject(tvServers.Selected.Parent);
          Database := GetSelectedNodeObject.Database;
          case GetSelectedNodeObject.NodeType of
            ntTables : begin
                         InitialStatement := csSELECTFROM + '"';
                         ReloadLastSql := frmMain.acGlobalOptionsReloadLastSql.Checked;
                       end;
            ntTriggers,
            ntStoredProcs,
            ntViews,
            ntCheckConstraints  : InitialStatement := aSQLText;
          end;
        end;
        ntDatabase : begin
          DatabaseNode := GetNodeObject(tvServers.Selected);
          Database := GetSelectedNodeObject.Database;
          InitialStatement := aSQLText;
          ReloadLastSql := frmMain.acGlobalOptionsReloadLastSql.Checked;
        end;
        ntServer : begin
          //create temporary database to work from if needed
          if not tvServers.Selected.HasChildren then begin
            GetSelectedNodeObject.Session.AddAlias('#TempWorkAlias_' + IntToStr(TnxNativeInt(@Self)), '#TempWorkAlias_' + IntToStr(Integer(@Self)));
            AddOutlineDatabase(tvServers.Selected, '#TempWorkAlias_' + IntToStr(TnxNativeInt(@Self))).Expand(True);
            tvServers.Selected.AlphaSort;
            DatabaseNode := GetNodeObject(tvServers.Selected.getFirstChild);
            Database := GetNodeObject(tvServers.Selected.getFirstChild).Database;
            TempAliasToRemove := '#TempWorkAlias_' + IntToStr(TnxNativeInt(@Self));
            RemoveTempAliasOnClose := True;
          end;
          DatabaseNode := GetNodeObject(tvServers.Selected.getFirstChild);
          Database := GetNodeObject(tvServers.Selected.getFirstChild).Database;
          InitialStatement := csCreateDatabase;
          ReloadLastSql := frmMain.acGlobalOptionsReloadLastSql.Checked;
        end;
      end;
      frmMain.AddFormToDockPanel(QueryBrowser, dxDockPanel);
      Log := frmMain.LogMain;
      Initialize;
      if aAutoExecute then
        acQueryExecuteExecute(Self, False);
      FormList.LastActivatedForm := QueryBrowser;
    end;
  finally
    LockWindowUpdate(0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.ShowTableBrowser(aTable: TnxTableRefCount);
var
  TableBrowser                : TfrmTableBrowser;
  SrvName                     : String;
  i                           : Integer;
  dxDockPanel                 : TdxDockPanel;
begin
  { if table already open in browser, make it active }
  with FormList do
  for i := 0 to Pred(Count) do
    if (Form(i) is TfrmTableBrowser) and
       (TfrmTableBrowser(Form(i)).TableNode=GetSelectedNodeObject) then begin
      if DockPanel(i).ParentDockControl is TdxTabContainerDockSite then
        TdxTabContainerDockSite(DockPanel(i).ParentDockControl).ActiveChild := DockPanel(i)
      else
        DockPanel(i).BringToFront;
      Exit;
    end;

  Screen.Cursor := crHourglass;
  LockWindowUpdate(frmMain.Handle);
  try

    if GetSelectedNodeObject.Table.Database.Session.ServerEngine is TnxRemoteServerEngine then
      SrvName := TnxRemoteServerEngine(GetSelectedNodeObject.Table.Database.Session.ServerEngine).Transport.ServerName
    else
      SrvName := nxc_InternalServerName;

    dxDockPanel := frmMain.CreateAndDockDockPanel;
    dxDockPanel.ImageIndex := nxc_TableImageIndex;

    dxDockPanel.Font.Size := 9;
    TableBrowser :=
      TfrmTableBrowser.CreateWithCaption(dxDockPanel,
        IfThen(frmMain.acGlobalOptionsUseLongTabDescription.Checked,
               Format(rsBrowseTableInDatabase, [GetSelectedNodeObject.Table.TableName, GetSelectedNodeObject.Table.Database.AliasName, SrvName]),
               'Table: ' + GetSelectedNodeObject.Table.TableName));
    TableBrowser.Parent := dxDockPanel;
    TableBrowser.ServerNode := tvServers.Selected;

    while GetNodeObject(TableBrowser.ServerNode).NodeType <> ntServer do
      TableBrowser.ServerNode := TableBrowser.ServerNode.Parent;

    FormList.AddFormDockPanelLink(TableBrowser, dxDockPanel);
    frmMain.AddFormToDockPanel(TableBrowser, dxDockPanel);

    with TableBrowser do begin
      TableNode := GetSelectedNodeObject;
      Table := aTable;
      AliasName := aTable.Database.AliasName;
      Initialize;
      if frmMain.acGlobalOptimisticRecordlocks.Checked and
         Table.TableDescriptor.FieldsDescriptor.HasRecRevField(i) then
        Table.Options := Table.Options + [dsoOptimisticLocks] else
        Table.Options := Table.Options - [dsoOptimisticLocks];
      FormList.LastActivatedForm := TableBrowser;
    end;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.slServerAttach(aServerIndex: Integer);
begin
  SetStatusText('');
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.SetStatusText(aText: string);
begin
  StatusBar.Panels[0].Text := ' ' + aText;
  StatusBar.Refresh;
  Application.ProcessMessages;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.UpdateServerPopupMenu;
begin
  popmnuServerAttach.Enabled := not GetSelectedNodeObject.Session.Active;
  popmnuServerDetach.Enabled := not popmnuServerAttach.Enabled;
  popmnuServerNewDatabase.Enabled := not popmnuServerAttach.Enabled;
  popmnuServerRefreshDatabaseList.Enabled := not popmnuServerAttach.Enabled;
  popmnuDatabaseSQL.Enabled := not popmnuServerAttach.Enabled;
  popmnuClientToClientMessaging.Enabled := (not popmnuServerAttach.Enabled) and
                                            Assigned(GetSelectedNodeObject.MessageRelayClient) and
                                            GetSelectedNodeObject.MessageRelayClient.Active;
  popmnuServerCloseInactive.Enabled := not popmnuServerAttach.Enabled;
  popmnuServerRefreshServerList.Enabled := True;
  popmnuServerProperties.Enabled := {popmnuServerDetach.Enabled and}
                                    Assigned(GetSelectedNodeObject.Transport) and
                                   (GetSelectedNodeObject.Transport is TnxBasePooledTransport);
  popmnuServerUsersAndPrivileges.Enabled := GetSelectedNodeObject.Session.Active;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuServerAttachClick(Sender: TObject);
begin
  if DoAttach(tvServers.Selected) = DBIERR_NONE then
    tvServers.Selected.Expand(False);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuServerDetachClick(Sender: TObject);
begin
  DoDetach;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuDatabaseNewTableClick(Sender: TObject);
var
  DictionaryBrowser           : TfrmDictionaryBrowser2;
  dxDockPanel                 : TdxDockPanel;
begin
  if tvServers.IsEditing then
    Exit;

  WarnAboutOutsideTransactionMethod;

  GetSelectedNodeObject.Database.Active := True;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  LockWindowUpdate(frmMain.Handle);
  try
    dxDockPanel := frmMain.CreateAndDockDockPanel;
    dxDockPanel.Font.Size := 9;
    DictionaryBrowser := TfrmDictionaryBrowser2.Create(dxDockPanel);
    DictionaryBrowser.Parent := dxDockPanel;
    DictionaryBrowser.ServerNode := tvServers.Selected;

    while GetNodeObject(DictionaryBrowser.ServerNode).NodeType <> ntServer do
      DictionaryBrowser.ServerNode := DictionaryBrowser.ServerNode.Parent;

    FormList.AddFormDockPanelLink(DictionaryBrowser, dxDockPanel);
    if GetSelectedNodeObject.NodeType = ntDatabase then
      DictionaryBrowser.CreateDictionary(GetSelectedNodeObject.Database, GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject))
    else
      DictionaryBrowser.CreateDictionary(GetSelectedNodeObject.Database, tvServers.Selected);
    frmMain.AddFormToDockPanel(DictionaryBrowser, dxDockPanel);
    FormList.LastActivatedForm := DictionaryBrowser;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuServerNewDatabaseClick(Sender: TObject);
var
  NewAlias                    : string;
  Node                        : TTreeNode;
begin
  Node := tvServers.Selected;
  if GetSelectedNodeObject.NodeType = ntDatabase then
    Node := Node.Parent;

  if not GetNodeObject(Node).ServerEngine.Active then
    popmnuServerAttachClick(Self);

  if ShowAddAliasDlg(GetNodeObject(Node).Session, NewAlias) = mrOK then begin
    AddOutlineDatabase(Node, NewAlias).Expand(True);
    Node.AlphaSort;
    Node.Expand(False);
    if Node = tvServers.Items[0] then
      SaveInternalServerAliasList;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.GetNewSelectedNode(aNode: TTreeNode): TTreeNode;
begin
  Result := aNode.Parent.GetNextChild(aNode);
  if not assigned(Result) then begin
    Result := aNode.Parent.GetPrevChild(aNode);
    if not assigned(Result) then
      Result := aNode.Parent;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuDatabaseDDCGClick(Sender: TObject);
begin
  with TddcgMainForm.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuDatabaseDeleteClick(Sender: TObject);
var
  Node                        : TTreeNode;
begin
  if tvServers.IsEditing then
    Exit;

  WarnAboutOutsideTransactionMethod;
  if MessageDlg(rsDelete + GetSelectedNodeObject.Database.AliasName + '?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    Screen.Cursor := crHourglass;
    try

      CloseAllDictionaryBrowsers(tvServers.Selected);
      CloseAllSQLBrowsers(tvServers.Selected);
      CloseAllTableBrowsers(GetTreeNodeFromObject(GetNodeObject(tvServers.Selected).TablesNodeObject));

      GetSelectedNodeObject.Database.Session.DeleteAlias(GetSelectedNodeObject.Database.AliasName);

      if tvServers.Selected.Parent = tvServers.Items[0] then
        SaveInternalServerAliasList;

      with tvServers do begin
        Node := Selected;
        Selected := GetNewSelectedNode(Node);
        Items.Delete(Node);
      end;

    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuDatabaseRenameClick(Sender: TObject);
begin
  WarnAboutOutsideTransactionMethod;
  tvServers.Selected.EditText;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.UpdateTablePopupMenu;
begin
  { update in UpdateChildTablePopupMenu if visible list changes }
  popmnuTableDelete.Visible := ivAlways;
  popmnuTableRename.Visible := ivAlways;
  popmnuTableEmpty.Visible := ivAlways;
  popmnuTableRecover.Visible := ivAlways;

  popmnuTableBrowseTable.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableDefinition.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableNew.Enabled := True;
  popmnuTableDelete.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableRename.Enabled := not GetSelectedNodeObject.TableBusy and not GetSelectedNodeObject.Table.Active;
  popmnuTableReindex.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTablePackTable.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableRestructure.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableEnterPassword.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableChangePassword.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableSetAutoInc.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableEmpty.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableRecover.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableImportCSV.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableCloneTableStructure.Enabled := not GetSelectedNodeObject.TableBusy;
  popmnuTableSQL.Enabled := True;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.OpenDictionaryBrowser(Editing : Boolean);
var
  i: Integer;
  DictionaryBrowser           : TfrmDictionaryBrowser2;
  dxDockPanel                 : TdxDockPanel;
  ParentNode                  : TTreeNode;
  browsemode                  : TnxDictionaryBrowseMode;
begin
  if tvServers.IsEditing then
    Exit;

  if Editing then
    browsemode:=bmRestructure
  else
    browsemode:=bmView;

    { if table already open in browser, make it active }
  with FormList do
  for i := 0 to Pred(Count) do
    if (Form(i) is TfrmDictionaryBrowser2) and
       (TfrmDictionaryBrowser2(Form(i)).TablesTreeNode.Data=GetSelectedNodeObject) and
       (TfrmDictionaryBrowser2(Form(i)).dbBrowsemode = browsemode) then begin
      if DockPanel(i).ParentDockControl is TdxTabContainerDockSite then
        TdxTabContainerDockSite(DockPanel(i).ParentDockControl).ActiveChild := DockPanel(i)
      else
        DockPanel(i).BringToFront;
      Exit;
    end;

  WarnAboutOutsideTransactionMethod;

  ParentNode := tvServers.Selected;
  while not (GetNodeObject(ParentNode).NodeType = ntTable) do
    ParentNode := ParentNode.Parent;
  if not OpenAndCheckPassword(GetNodeObject(ParentNode).Table) then
    Exit;

  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  LockWindowUpdate(frmMain.Handle);
  try
    dxDockPanel := frmMain.CreateAndDockDockPanel;
    dxDockPanel.Font.Size := 9;
    DictionaryBrowser := TfrmDictionaryBrowser2.Create(dxDockPanel);
    DictionaryBrowser.Parent := dxDockPanel;
    DictionaryBrowser.ServerNode := tvServers.Selected;

    while GetNodeObject(DictionaryBrowser.ServerNode).NodeType <> ntServer do
      DictionaryBrowser.ServerNode := DictionaryBrowser.ServerNode.Parent;

    FormList.AddFormDockPanelLink(DictionaryBrowser, dxDockPanel);
    ParentNode := tvServers.Selected;
    while not (GetNodeObject(ParentNode).NodeType = ntTable) do
      ParentNode := ParentNode.Parent;

    if Editing then
      DictionaryBrowser.EditDictionary(GetNodeObject(ParentNode).Table, tvServers.Selected)
    else
      DictionaryBrowser.ViewDictionary(GetNodeObject(ParentNode).Table, tvServers.Selected);
    frmMain.AddFormToDockPanel(DictionaryBrowser, dxDockPanel);
    FormList.LastActivatedForm := DictionaryBrowser;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableDefinitionClick(Sender: TObject);
begin
  OpenDictionaryBrowser(False);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableNewClick(Sender: TObject);
var
  DictionaryBrowser           : TfrmDictionaryBrowser2;
  dxDockPanel                 : TdxDockPanel;
  ParentNode                  : TTreeNode;
begin
  if tvServers.IsEditing then
    Exit;

  WarnAboutOutsideTransactionMethod;
  Screen.Cursor := crHourglass;
  Application.ProcessMessages;
  LockWindowUpdate(frmMain.Handle);
  try
    dxDockPanel := frmMain.CreateAndDockDockPanel;
    dxDockPanel.Font.Size := 9;
    DictionaryBrowser := TfrmDictionaryBrowser2.Create(dxDockPanel);
    DictionaryBrowser.Parent := dxDockPanel;
    DictionaryBrowser.ServerNode := tvServers.Selected;

    while GetNodeObject(DictionaryBrowser.ServerNode).NodeType <> ntServer do
      DictionaryBrowser.ServerNode := DictionaryBrowser.ServerNode.Parent;

    FormList.AddFormDockPanelLink(DictionaryBrowser, dxDockPanel);
    ParentNode := tvServers.Selected;
    while not (GetNodeObject(ParentNode).NodeType = ntTable) do
      ParentNode := ParentNode.Parent;
    DictionaryBrowser.CreateDictionary(GetNodeObject(ParentNode).Table.Database, ParentNode);
    frmMain.AddFormToDockPanel(DictionaryBrowser, dxDockPanel);
    FormList.LastActivatedForm := DictionaryBrowser;
  finally
    Screen.Cursor := crDefault;
    LockWindowUpdate(0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableDeleteClick(Sender: TObject);
var
  Node                        : TTreeNode;
begin
  if tvServers.IsEditing then
    Exit;

  WarnAboutOutsideTransactionMethod;
  if MessageDlg(Format(rsDeleteTable, [GetSelectedNodeObject.Table.TableName]),
    mtConfirmation,
    [mbYes, mbNo],
    0) = mrYes then begin
    CloseTableBrowser(GetSelectedNodeObject.Table, True);
    CloseDictionaryBrowser(tvServers.Selected, True);
    GetSelectedNodeObject.Table.Close;
//    GetSelectedNodeObject.Table.Session.CloseInactiveTables;
    Screen.Cursor := crHourglass;
    try
      with GetSelectedNodeObject.Table do
        Database.DeleteTable(TableName, Password);

      with tvServers do begin
        Node := Selected;
        Selected := GetNewSelectedNode(Node);
        Node.Delete;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTablePackClick(Sender: TObject);
var
  RebuildProgress : TfrmRebuildProgress;
begin
  WarnAboutOutsideTransactionMethod;
  RebuildProgress := TfrmRebuildProgress.Create(Self);
  try
    frmMain.Enabled := False;
    RebuildProgress.Show;
    PackSingleTable(tvServers.Selected, RebuildProgress, False);
  finally
    RebuildProgress.Free;
    frmMain.Enabled := True;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.PackSingleTable(aNode : TTreeNode; RebuildProgress : TfrmRebuildProgress; aPackAll : Boolean);
var
  Status                      : TnxTaskStatus;
  TaskInfo                    : TnxAbstractTaskInfo;
  Cancelled,
  Completed                   : Boolean;
  NodeObject                  : TnxemNode;
begin
  while GetNodeObject(aNode).NodeType = ntChildTable do
    aNode := aNode.Parent;

  NodeObject := GetNodeObject(aNode);
  CloseTableBrowser(NodeObject.Table, True);
  TaskInfo := NodeObject.Table.PackTable;
  try
    NodeObject.TableBusy := True;
    if not aPackAll then
      frmMain.StartNotificationTiming(rsPackingFinished);

    aNode.Text := NodeObject.Table.TableName + rsPacking;
    try
      Application.ProcessMessages;

      if Assigned(TaskInfo) then
        with RebuildProgress do begin
          ShowProgress(rsPacking1, NodeObject.Table.TableName, True);

          Cancelled := False;
          repeat
            if not Cancelled then
              TaskInfo.GetStatus(Completed, Status);

            Application.ProcessMessages;

            if not Completed then begin
              UpdateProgress(Status, Cancelled);
              if not Cancelled then
                Sleep(250)
              else
                TaskInfo.Cancel;
            end;
          until Completed or Cancelled;
          if Cancelled then
            Abort;
          Check(Status.tsErrorCode);
        end;
    finally
      aNode.Text := NodeObject.Table.TableName;
    end;
  finally
    NodeObject.TableBusy := False;
    if Assigned(TaskInfo) then
      TaskInfo.Free;
    if not aPackAll then
      frmMain.StopNotificationTiming;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableReindexClick(Sender: TObject);
var
  Node                        : TTreeNode;
  NodeObject                  : TnxemNode;
  Status                      : TnxTaskStatus;
  TaskInfo                    : TnxAbstractTaskInfo;
  IndexNum                    : Integer;
  Cancelled,
  Completed                   : Boolean;
  OldNodeText                 : String;
begin
  WarnAboutOutsideTransactionMethod;
  if SelectIndexDlg(GetSelectedNodeObject.Table, IndexNum) = mrOk then begin
    CloseTableBrowser(GetSelectedNodeObject.Table, False);
    GetSelectedNodeObject.Table.Close;
    Node := tvServers.Selected;
    NodeObject := GetNodeObject(Node);
    TaskInfo := NodeObject.Table.ReIndexTable(IndexNum);
    try
      NodeObject.TableBusy := True;

      OldNodeText := Node.Text;
      Node.Text := OldNodeText + rsReindexing;
      try
        Application.ProcessMessages;

        { Display the rebuild progress window }
        if Assigned(TaskInfo) then
          with TfrmRebuildProgress.Create(frmMain) do try
            frmMain.Enabled := False;
            Show;
            ShowProgress(rsReindexing1, NodeObject.Table.TableName, True);

            Cancelled := False;
            repeat
              if not Cancelled then
                TaskInfo.GetStatus(Completed, Status);

              Application.ProcessMessages;

              if not Completed then begin
                UpdateProgress(Status, Cancelled);
                if not Cancelled then
                  Sleep(250)
                else
                  TaskInfo.Cancel;
              end;
            until Completed or Cancelled;
            if Cancelled then
              Abort;
            Check(Status.tsErrorCode);
          finally
            Free;
            frmMain.Enabled := True;
          end;
      finally
        Node.Text := OldNodeText;
      end;
    finally
      NodeObject.TableBusy := False;
      if Assigned(TaskInfo) then
        TaskInfo.Free;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.CloseTableBrowser(aTable : TnxTableRefCount; aCloseChildren : Boolean) : Boolean;
var
  i                           : Integer;
begin
  Result := False;
  with FormList do
  for i := Pred(Count) downto 0 do
    if (Form(i) is TfrmTableBrowser) and
      ((TfrmTableBrowser(Form(i)).Table = aTable) or
       (aCloseChildren and
       (Pos(aTable.TableName + ':', TfrmTableBrowser(Form(i)).Table.TableName) = 1))) then begin
      DockPanel(i).Close;
      Result := True;
    end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.CloseDictionaryBrowser(aTableNode : TTreeNode; aUnconditionalClose : Boolean);
var
  i : Integer;
begin
  while GetNodeObject(aTableNode).NodeType <> ntTable do
    aTableNode := aTableNode.Parent;

  with FormList do
    for i := 0 to Pred(Count) do
      if (Form(i) is TfrmDictionaryBrowser2) and
         (TfrmDictionaryBrowser2(Form(i)).dbTable = GetNodeObject(aTableNode).Table) then begin
        TfrmDictionaryBrowser2(Form(i)).dbUnconditionalClose := aUnconditionalClose;
        DockPanel(i).Close;
        Break;
      end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.CloseAllDictionaryBrowsers(aDatabase : TTreeNode);
var
  i                           : Integer;
begin
  with FormList do
    for i := 0 to Pred(Count) do
      if (Form(i) is TfrmDictionaryBrowser2) and
         (TfrmDictionaryBrowser2(Form(i)).dbDatabase = GetNodeObject(aDatabase).Database) then begin
        DockPanel(i).Close;
        Break;
      end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.CloseAllSQLBrowsers(aDatabase : TTreeNode);
var
  i                           : Integer;
begin
  with FormList do
    for i := Pred(Count) downto 0 do
      if (Form(i) is TfrmQueryBrowser) and
         (TfrmQueryBrowser(Form(i)).Database = GetNodeObject(aDatabase).Database) then begin
        DockPanel(i).Close;
      end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.CloseAllTableBrowsers(aTables : TTreeNode);

  procedure CloseAllSubTableBrowsers(aParentTableNode : TTreeNode);
  var
    i,
    j                           : Integer;
  begin
    with FormList do
    for j := 0 to Pred(aParentTableNode.Count) do begin
      if aParentTableNode.Item[j].Count > 0 then
        CloseAllSubTableBrowsers(aParentTableNode.Item[j]);

      for i := 0 to Pred(Count) do
        if (Form(i) is TfrmTableBrowser) and
           (TfrmTableBrowser(Form(i)).Table = GetNodeObject(aParentTableNode.Item[j]).Table) then begin
          DockPanel(i).Close;
          Break;
        end;
    end;
  end;

var
  i,
  j                           : Integer;
begin
  with FormList do
  for j := 0 to Pred(aTables.Count) do begin
    if aTables.Item[j].Count > 0 then
      CloseAllSubTableBrowsers(aTables.Item[j]);

    for i := 0 to Pred(Count) do
      if (Form(i) is TfrmTableBrowser) and
         (TfrmTableBrowser(Form(i)).Table = GetNodeObject(aTables.Item[j]).Table) then begin
        DockPanel(i).Close;
        Break;
      end;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.ServerHasOpenTabs(aServerNode : TTreeNode) : Boolean;
var
  iForms : Integer;
begin
  Result := False;
  with FormList do
    for iForms := 0 to Pred(Count) do
      if ((Form(iForms) is TfrmBaseBrowser) and
          (TfrmBaseBrowser(Form(iForms)).ServerNode = aServerNode)) or
         ((Form(iForms) is TfrmDictionaryBrowser2) and
          (TfrmDictionaryBrowser2(Form(iForms)).ServerNode = aServerNode)) then
        Exit(True);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableRestructureClick(Sender: TObject);
begin
  OpenDictionaryBrowser(True);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableEmptyClick(Sender: TObject);
var
  SaveCursor                  : TCursor;
begin
  WarnAboutOutsideTransactionMethod;

  with GetSelectedNodeObject.Table do
  if MessageDlg(rsDeleteAllRecordsIn + TableName + '?',
    mtWarning, [mbYes, mbNo], 0) = mrYes then begin
    CloseTableBrowser(GetSelectedNodeObject.Table, False);
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    try
      try
        Close;
        Exclusive := True;
        Open;
      finally
        Close;
        Exclusive := False;
      end;
      EmptyTable;
    finally
      Screen.Cursor := SaveCursor;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableSetAutoIncClick(Sender: TObject);
var
  Seed                        : Cardinal;
  FieldNr                     : Integer;
  WasOpen                     : Boolean;
begin
  WasOpen := GetSelectedNodeObject.Table.Active;
  try
    if not WasOpen and not OpenAndCheckPassword(GetSelectedNodeObject.Table) then
      Exit;
    if GetSelectedNodeObject.Table.TableDescriptor.FieldsDescriptor.HasAutoIncField(FieldNr) then begin
      GetSelectedNodeObject.Table.GetAutoIncValue(Seed);
      if ShowSetAutoIncDlg(GetSelectedNodeObject.Table.TableName, Seed) = mrOK then
        GetSelectedNodeObject.Table.SetAutoIncValue(Seed);
    end
    else
      MessageDlg(rsTableHasNoAutoincField, mtInformation, [mbOK], 0);
  finally
    if WasOpen then
      GetSelectedNodeObject.Table.Close;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.tvServersDblClick(Sender: TObject);
begin
  with tvServers do begin
    if assigned(Selected) then
      case GetSelectedNodeObject.NodeType of
        ntServer: begin
                    if not GetSelectedNodeObject.Session.Active then
                      if DoAttach(Selected)<>DBIERR_NONE then
                        Exit;
                    Selected.Expand(False);
                  end;
        ntTable,
        ntChildTable: ShowTableBrowser(GetSelectedNodeObject.Table);
        ntTrigger : popmnuTriggerEditClick(Sender);
        ntProcedure,
        ntFunction : popmnuStoredProcEditClick(Sender);
        ntView : popmnuViewOpenClick(Sender);
        ntCheckConstraint : popmnuCheckConstraintEditClick(Sender);
      end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.tvServersExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  AllowExpansion := True;

  if (Node.Count = 0) then begin
    case GetNodeObject(Node).NodeType of
      ntServer      : LoadOutlineDatabases(Node);
      ntDatabase    : ;
      ntTables      : LoadOutlineTables(Node);
      ntTable       : LoadOutlineChildTables(Node, nil, nil);
      ntTriggers    : LoadOutlineTriggers(Node);
      ntViews       : LoadOutlineViews(Node);
      ntStoredProcs : LoadOutlineStoredProcs(Node);
      ntCheckConstraints : LoadOutlineCheckConstraints(Node);
    end;
    Node.HasChildren := (Node.Count > 0);
    AllowExpansion := Node.HasChildren;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.tvServersEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit := (GetNodeObject(Node).NodeType=ntDatabase) or
              ((GetNodeObject(Node).NodeType=ntTable) and
               (not GetNodeObject(Node).Table.Active));
  { remove directory path for editing }
  if  AllowEdit and
     (GetNodeObject(Node).NodeType=ntDatabase) then begin
    tvEditText := GetNodeObject(Node).Database.AliasName;
    PostMessage(Handle, WM_ChangeTreeNodeText, 0, 0);
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.tvServersEdited(Sender: TObject; Node: TTreeNode; var S: string);
var
  OldCursor                   : TCursor;
  Path                        : String;
  idx                         : Integer;

  procedure UpdateAllNodeChildrenInList(aParent: TTreeNode; aNewPart, aOldPart : string; aChangeChildTableNames : Boolean);
  var
    iPos          : Integer;
    OldNodePath   : string;
    ChildNode     : TTreeNode;
  begin
    ChildNode := aParent.getFirstChild;
    while Assigned(ChildNode) do begin
      OldNodePath := GetNodePath(ChildNode);
      iPos := Pos(aNewPart, OldNodePath);
      if iPos > 0 then begin
        Delete(OldNodePath, iPos, Length(aNewPart));
        Insert(aOldPart, OldNodePath, iPos);
        tbNodeDataList[tbNodeDataList.IndexOf(OldNodePath)] := GetNodePath(ChildNode);
        if aChangeChildTableNames then begin
          OldNodePath := GetNodeObject(ChildNode).Table.TableName;
          iPos := Pos(aOldPart, OldNodePath);
          if iPos > 0 then begin
            Delete(OldNodePath, iPos, Length(aOldPart));
            Insert(aNewPart, OldNodePath, iPos);
            GetNodeObject(ChildNode).Table.TableName := OldNodePath;
          end;
        end;
      end;
      UpdateAllNodeChildrenInList(ChildNode, aNewPart, aOldPart, aChangeChildTableNames);
      ChildNode := aParent.GetNextChild(ChildNode);
    end;
  end;

begin
  OldCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  try
    case GetNodeObject(Node).NodeType of
      ntDatabase: begin
          CloseAllDictionaryBrowsers(Node);
          CloseAllSQLBrowsers(Node);
          CloseAllTableBrowsers(GetTreeNodeFromObject(GetNodeObject(Node).TablesNodeObject));
          GetNodeObject(Node).Database.Close;
          GetNodeObject(Node.Parent).Session.ModifyAlias(GetNodeObject(Node).Database.AliasName, S, '');
          GetNodeObject(Node.Parent).Session.GetAliasPath(S, Path);
          GetNodeObject(Node).Database.AliasName := S;
          GetNodeObject(Node).Database.Open;
          S := S + ' (' + Path + ')';
          idx := tbNodeDataList.IndexOf(GetNodePath(Node));
          Node.Text := S;
          if idx >= 0 then
            tbNodeDataList[idx] := GetNodePath(Node);
          UpdateAllNodeChildrenInList(Node, s, tvEditText + ' (' + Path + ')', False);
        end;
      ntTable: begin
          tvEditText := GetNodeObject(Node).Table.TableName;
          GetNodeObject(Node).Table.RenameTable(S);
          idx := tbNodeDataList.IndexOf(GetNodePath(Node));
          Node.Text := S;
          if idx >= 0 then
            tbNodeDataList[idx] := GetNodePath(Node);
          UpdateAllNodeChildrenInList(Node, s, tvEditText, True);
          Node.Parent.AlphaSort;
        end;
    end;
  finally
    Screen.Cursor := OldCursor;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.tvServersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  AltMask                     = $20000000;
var
  WMKey                       : TWMKey;
  Point                       : TPoint;
begin
  { If user presses F2 then edit current node. }
  if (Key = VK_F2) and assigned(tvServers.Selected) then
    tvServers.Selected.EditText
  else
  if Key = VK_RETURN then begin
    Key := 0;
    if ssAlt in Shift then begin
      if Assigned(tvServers.Selected) and
        (GetSelectedNodeObject.NodeType = ntServer) then begin
          Point.X := 0;
          Point.Y := 0;
          Point := ClientToScreen(Point);
          popmnuServer.Popup(Point.X, Point.Y);
      end;
    end
    else
      tvServersDblClick(nil);
  end
  else begin
    ActivePopupMenu := nil;
    if Assigned(tvServers.Selected) then begin
      case GetSelectedNodeObject.NodeType of
        ntServer      : ActivePopupMenu := popmnuServer;
        ntDatabase    : ActivePopupMenu := popmnuDatabase;
        ntTables      : ActivePopupMenu := popmnuTables;
        ntTable       : ActivePopupMenu := popmnuTable;
        ntChildTable  : ActivePopupMenu := popmnuChildTable;
        ntTriggers    : ActivePopupMenu := popmnuTriggers;
        ntTrigger     : ActivePopupMenu := popmnuTrigger;
        ntViews       : ActivePopupMenu := popmnuViews;
        ntView        : ActivePopupMenu := popmnuView;
        ntStoredProcs : ActivePopupMenu := popmnuStoredProcs;
        ntProcedure,
        ntFunction    : ActivePopupMenu := popmnuStoredProc;
        ntCheckConstraints : ActivePopupMenu := popmnuCheckConstraints;
        ntCheckConstraint  : ActivePopupMenu := popmnuCheckConstraint;
      end;
    end;

    { recreate message }
    if Assigned(ActivePopupMenu) then begin
      WMKey.Msg := WM_KeyDown;
      WMKey.CharCode := Key;
      WMKey.KeyData := 0;
      if ssAlt in Shift then
        WMKey.KeyData := AltMask;

      if IsPopupMenuShortCut(ActivePopupMenu, WMKey) then
        Key := 0;
    end;
    ActivePopupMenu := nil;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableBrowseTableClick(Sender: TObject);
begin
  tvServersDblClick(nil);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuDatabaseSQLClick(Sender: TObject);
begin
  ShowQueryBrowser(ntDatabase, '', False);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTableImportCSVClick(Sender: TObject);
var
  WasOpen   : Boolean;
begin
  WasOpen := False;
  Screen.Cursor := crHourglass;
  with GetSelectedNodeObject, Table do
  try
    try
      WasOpen := Active;
      if not WasOpen then
        if not OpenAndCheckPassword(Table) then
          Exit;
      ImportTextFile(Table);

    except
      on E: Exception do begin
        showMessage(E.message);
      end;
    end;

  finally
    if not WasOpen then
      Close;
    Screen.Cursor := crDefault;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuServerRefreshDatabaseListClick(Sender: TObject);
begin
  LoadOutlineDatabases(tvServers.Selected);
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTablesPackAllTablesClick(Sender: TObject);
var
  TableIndex                  : Integer;
  Node                        : TTreeNode;
  RebuildProgress             : TfrmRebuildProgress;
  Errors                      : string;
begin
  Errors := '';
  Node := tvServers.Selected;
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;
  if MessageDlg(rsAreYouSureYouWantToPackAllTables, mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin

    CloseAllTableBrowsers(Node);

    if Node.Count = 0 then
      LoadOutlineTables(Node);

    RebuildProgress := TfrmRebuildProgress.Create(frmMain);
    try
      frmMain.Enabled := False;
      RebuildProgress.Show;
      frmMain.StartNotificationTiming(rsPackingFinished);
      for TableIndex := 0 to Pred(Node.Count) do try
        PackSingleTable(Node.Item[TableIndex], RebuildProgress, True);
      except
        on E:Exception do begin
          if Errors.IsEmpty then
            Errors := rsErrorsOccured + #13#10;
          Errors := Errors + GetNodeObject(Node.Item[TableIndex]).Table.TableName + ': ' + E.Message + #13#10;
        end;
      end;
    finally
      RebuildProgress.Free;
      frmMain.StopNotificationTiming;
      frmMain.Enabled := True;

      if not Errors.IsEmpty then
        ShowMessage(Errors);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTablesPackNLSClick(Sender: TObject);
var
  TableIndex,
  TablesProcessed             : Integer;
  Node                        : TTreeNode;
  RebuildProgress             : TfrmRebuildProgress;
  TableList                   : TStringList;
  Errors                      : string;
begin
  Errors := '';
  Node := tvServers.Selected;
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;
  if MessageDlg(rsAreYouSureYouWantToPackAllNLSTables, mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin

    CloseAllTableBrowsers(Node);

    if Node.Count = 0 then
      LoadOutlineTables(Node);

    TableList := TStringList.Create;
    RebuildProgress := TfrmRebuildProgress.Create(frmMain);
    try
      frmMain.Enabled := False;
      RebuildProgress.Show;
      try
        GetSelectedNodeObject.Database.GetTablesNeedingPack(TableList);
      except
        on E:EnxBaseException do
          if E.ErrorCode = DBIERR_NX_UNKNOWNMSG then begin
            MessageDlg(rsServerMustBe310, mtError, [mbOK], 0);
            Exit;
          end
          else
            raise;
      end;
      TableList.CaseSensitive := False;
      TableList.Sorted := True;
      TablesProcessed := 0;
      for TableIndex := 0 to Pred(Node.Count) do
        if TableList.IndexOf(Node.Item[TableIndex].Text) >= 0 then begin
          try
            PackSingleTable(Node.Item[TableIndex], RebuildProgress, True);
          except
            on E:Exception do begin
              if Errors.IsEmpty then
                Errors := rsErrorsOccured + #13#10;
              Errors := Errors + GetNodeObject(Node.Item[TableIndex]).Table.TableName + ': ' + E.Message + #13#10;
            end;
          end;

          Inc(TablesProcessed);
        end;

      MessageDlg(Format(rsTablesNeededPacking, [TablesProcessed, Node.Count]), mtInformation, [mbOK], 0);

      if not Errors.IsEmpty then
        ShowMessage(Errors);
    finally
      TableList.Free;
      RebuildProgress.Free;
      frmMain.Enabled := True;
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.acServersBroadcastForServersExecute(Sender: TObject);
begin
  if not nxFindCmdLineSwitch('NOBROADCAST') then begin
    Config.BroadcastForServers := (Sender as TAction).Checked;
    Config.Save;
  end;

  if (Sender as TAction).Checked then begin
    try
       { Idem
      if NamedPipeTransportBroadcast.Supported then
        NamedPipeActiveBroadcast := NamedPipeTransportBroadcast.BeginBroadcast(NamedPipeBroadcastReplyHandler, 2000);
      }
      if WinsockTransportBroadcast.Supported then
        WinsockActiveBroadcast := WinsockTransportBroadcast.BeginBroadcast(WinsockBroadcastReplyHandler, 2000);
      if SharedMemoryTransportBroadcast.Supported then
        SharedMemoryActiveBroadcast := SharedMemoryTransportBroadcast.BeginBroadcast(SharedMemoryBroadcastReplyHandler, 2000);
    except
      on E: Exception do begin
        ShowMessage('Error in BeginBroadcast: ' + E.Message);
        SetStatusText('');
      end;
    end;
  end
  else begin
    {
    if NamedPipeTransportBroadcast.Supported then
      NamedPipeActiveBroadcast.Stop;
    }
    if WinsockTransportBroadcast.Supported then
      WinsockActiveBroadcast.Stop;
    if SharedMemoryTransportBroadcast.Supported then
      SharedMemoryActiveBroadcast.Stop;
  end;

end;

procedure TfrmTreeBrowser.acServersRefreshExecute(Sender: TObject);

  procedure InternalRefresh(aBroadcastList : TStringList);
  var
    i: Integer;
  begin
    with tvServers, Items do
    for i := Pred(Count) downto 0 do
      if (GetNodeObject(Items[i]).NodeType = ntServer) and
         (GetNodeObject(Items[i]).ServerEngine is TnxRemoteServerEngine) and
         not GetNodeObject(Items[i]).ServerEngine.Active and
         (aBroadcastList.IndexOf(TnxRemoteServerEngine(GetNodeObject(Items[i]).ServerEngine).Transport.ServerName) >= 0) then begin
        aBroadcastList.Delete(aBroadcastList.IndexOf(TnxRemoteServerEngine(GetNodeObject(Items[i]).ServerEngine).Transport.ServerName));
        tvServers.Items.Delete(Items[i]);
      end;
  end;

begin
  SaveInternalServerAliasList;

  tvServersLock.Acquire;
  tvServers.Items.BeginUpdate;

  try
    InternalRefresh(tbServerBroadcastListWinsock);
    InternalRefresh(tbServerBroadcastListNamedPipe);
    InternalRefresh(tbServerBroadcastListSharedMemory);
  finally
    tvServers.Items.EndUpdate;
    tvServersLock.Release;
  end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.acServersRegisterExecute(Sender: TObject);
begin
  SaveInternalServerAliasList;
  if ShowRegisterServersDlg = mrOK then
    LoadRegisteredOutlineServers;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.LoadPreferences;
begin
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.SaveInternalServerAliasList;
var
  AliasStrings,
  Strings                     : TstringList;
  i                           : Integer;
  Path                        : string;
begin
  { save list of aliases/directories }
  if (tvServers.Items.Count > 0) and
     GetNodeObject(tvServers.Items[0]).Session.Active then begin
    AliasStrings := TstringList.Create;
    Strings := TstringList.Create;
    try
      GetNodeObject(tvServers.Items[0]).Session.GetAliasNamesEx(AliasStrings, True);

      for i := 0 to Pred(AliasStrings.Count) do begin
        GetNodeObject(tvServers.Items[0]).Session.GetAliasPath(AliasStrings[i], Path);
        Strings.Add(AliasStrings[i]+'='+Path);
      end;

      nxeConfigSaveKeysAndValues(nxc_InternalServerName+csAliases, Strings);

    finally
      AliasStrings.Free;
      Strings.Free;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TfrmTreeBrowser.AddNewTable(aDatabase: TnxDatabase; aTableName: string) : TTreeNode;
var
  i                           : Integer;
begin
  Result := nil;
  for i := 0 to Pred(tvServers.Items.Count) do
    if (GetNodeObject(tvServers.Items[i]).NodeType = ntTables) and
      (GetNodeObject(tvServers.Items[i]).Database = aDatabase) then begin
      Result := AddOutlineTable(tvServers.Items[i], aTableName);
      Break;
    end;
end;
{------------------------------------------------------------------------------}
procedure TfrmTreeBrowser.popmnuTablesRecoverAllTablesClick(Sender: TObject);
var
  TableIndex                  : Integer;
  Node                        : TTreeNode;
  Errors                      : string;
begin
  Errors := '';
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(rsAreYouSureYouWantToRecoverAllTables, mtWarning, [mbYes, mbNo], 0) = mrYes then begin

    Node := tvServers.Selected;
    CloseAllTableBrowsers(Node);

    if Node.Count = 0 then
      LoadOutlineTables(Node);

    for TableIndex := 0 to Pred(Node.Count) do try
      popmnuTableRecoverClick(Node.Item[TableIndex]);
    except
      on E:Exception do begin
        if Errors.IsEmpty then
          Errors := rsErrorsOccured + #13#10;
        Errors := Errors + GetNodeObject(Node.Item[TableIndex]).Table.TableName + ': ' + E.Message + #13#10;
      end;
    end;

    LoadOutlineTables(Node);
    if Errors.IsEmpty then
      ShowMessage(rsRecoveredAllTables)
    else
      ShowMessage(Errors);
  end;
end;

procedure TfrmTreeBrowser.popmnuTablesRefreshClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  LoadOutlineTables(tvServers.Selected);
end;

procedure TfrmTreeBrowser.popmnuTableStreamsClick(Sender: TObject);
begin
  with TfrmTableStreams.Create(Self) do try
    NodeObject := GetSelectedNodeObject;
    ShowModal;
  finally
    Free;
  end;
end;

function TfrmTreeBrowser.GetTreeNodeFromObject(aObject: TnxemNode): TTreeNode;
var
  i,
  idx                           : Integer;
begin
  Result := nil;
  idx := tbNodeDataList.IndexOfObject(aObject);
  if idx >= 0 then
    for i := 0 to Pred(tvServers.Items.Count) do
      if GetNodePath(tvServers.Items[i]) = tbNodeDataList[idx] then begin
        Result := tvServers.Items[i];
        Break;
      end;
end;

procedure TfrmTreeBrowser.popmnuDatabaseStartTransClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  if MessageDlg(rsCAUTIONDoNotUseThisCommandInALiv+#13+#10+rsStartingAManualTransactionMightL+#13+#10+rsTheDatabase+#13+#10+''+#13+#10+rsAreYouSureYouWantToStartTheTrans, mtWarning, [mbYes,mbNo], 0) = mrNo then
    Exit;
  GetSelectedNodeObject.Database.StartTransaction;
  GetSelectedNodeObject.InTransaction := True;
  tvServers.Selected.ImageIndex := nxc_DatabaseInTransactionImageIndex;
  tvServers.Selected.SelectedIndex := nxc_DatabaseInTransactionImageIndex;
  Inc(ActiveTransactionCount);
end;

procedure TfrmTreeBrowser.popmnuDatabaseCommitTransClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Commit;
  GetSelectedNodeObject.InTransaction := False;
  tvServers.Selected.ImageIndex := nxc_DatabaseImageIndex;
  tvServers.Selected.SelectedIndex := nxc_DatabaseImageIndex;
  Dec(ActiveTransactionCount);
end;

procedure TfrmTreeBrowser.popmnuDatabaseRollbackTransClick(Sender: TObject);
var
  i : Integer;
begin
  GetSelectedNodeObject.Database.Rollback;
  GetSelectedNodeObject.InTransaction := False;
  Dec(ActiveTransactionCount);
  tvServers.Selected.ImageIndex := nxc_DatabaseImageIndex;
  tvServers.Selected.SelectedIndex := nxc_DatabaseImageIndex;
  { cancel any tables in edit mode; refresh all tables }
  with GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject) do
  for i := 0 to Pred(Count) do
    if GetNodeObject(Item[i]).Table.Active then begin
      if (GetNodeObject(Item[i]).Table.State in [dsInsert, dsEdit]) then
        GetNodeObject(Item[i]).Table.Cancel;
      GetNodeObject(Item[i]).Table.Refresh;
    end;
end;

procedure TfrmTreeBrowser.UpdateDatabasePopupMenu;
var
  Path : string;
begin
  popmnuDatabaseStartTrans.Enabled := (not GetSelectedNodeObject.Database.Active) or (not GetSelectedNodeObject.Database.InTransaction);
  popmnuDatabaseCommitTrans.Enabled := GetSelectedNodeObject.Database.Active and GetSelectedNodeObject.Database.InTransaction;
  popmnuDatabaseRollbackTrans.Enabled := GetSelectedNodeObject.Database.Active and GetSelectedNodeObject.Database.InTransaction;

  popmnuDatabaseShowinExplorer.Enabled := False;
  Path := GetSelectedNodeObject.Database.AliasPath;
  if Path.IsEmpty then
    GetSelectedNodeObject.Database.Session.GetAliasPath(GetSelectedNodeObject.Database.AliasName, Path);
  popmnuDatabaseShowinExplorer.Enabled := (Copy(Path, 1, 1) <> '#') and not Path.IsEmpty and TDirectory.Exists(Path);
end;

{ used if we are in a transaction, and a routine which can't
  be rolled back is attempted (restructure, etc) }
procedure TfrmTreeBrowser.WarnAboutOutsideTransactionMethod;
var
  Database : TnxDatabase;
begin
  Database := nil;
  if GetSelectedNodeObject.NodeType in [ntTable, ntChildTable] then
    Database := GetSelectedNodeObject.Table.Database
  else
  if GetSelectedNodeObject.NodeType in [ntDatabase, ntTables, ntTriggers, ntViews, ntStoredProcs, ntCheckConstraints] then
    Database := GetSelectedNodeObject.Database
  else
  if GetSelectedNodeObject.NodeType in [ntView, ntTrigger, ntProcedure, ntFunction, ntCheckConstraint] then
    Database := GetNodeObject(tvServers.Selected.Parent).Database;

  Assert(Assigned(Database));

  if Database.Active and Database.InTransaction then
  if MessageDlg(rsTheOperationYouAreAttemptingWill+#13+#10+rsImmediatelyAndCannotBeRolledBack+#13+#10+rsActiveTransactionGoAheadAnyway, mtWarning, [mbYes,mbNo], 0) = mrNo then
    Abort;
end;

procedure TfrmTreeBrowser.acServersSQLExecute(Sender: TObject);
begin
  if tvServers.IsEditing then
    Exit;
    
  if not Assigned(tvServers.Selected) then begin
    MessageDlg(rsNoServerActivated, mtInformation, [mbOK], 0);
    Exit;
  end;

  if GetSelectedNodeObject.NodeType=ntServer then begin
    { just pick the first database... }
    if tvServers.Selected.Count>0 then begin
      tvServers.Selected := tvServers.Selected.Item[0];
      ShowQueryBrowser(ntDatabase, '', False);
    end
    else
      ShowQueryBrowser(ntServer, '', False);

  end
  else
    ShowQueryBrowser(ntDatabase, '', False);
end;

procedure TfrmTreeBrowser.popmnuDatabaseLiveBackupClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  if GetSelectedNodeObject.Database.InTransaction then begin
    MessageDlg(rsTransactionAlreadyInProgressYouM+#13+#10+rsYourCurrentTransactionFirst, mtInformation, [mbOK], 0);
    Exit;
  end;

  LoadOutlineTables(GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject));
  ShowLiveBackup(GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject));
end;

procedure TfrmTreeBrowser.popmnuDatabaseRestoreClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  if GetSelectedNodeObject.Database.InTransaction then begin
    MessageDlg(rsTransactionAlreadyInProgressYouM+#13+#10+rsYourCurrentTransactionFirst, mtInformation, [mbOK], 0);
    Exit;
  end;

  LoadOutlineTables(GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject));
  ShowRestoreBackup(GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject));
end;


procedure TfrmTreeBrowser.acServersSQLUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := tvServers.Items.Count>0;
end;

procedure TfrmTreeBrowser.popmnuDatabaseCSVImportClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  try
    ImportTextFile(nil);

  except
    on E: Exception do begin
      showMessage(E.message);
    end;
  end;
end;

procedure TfrmTreeBrowser.WMChangeTreeNodeText(var Msg: TMessage);
begin
  SendMessage(TreeView_GetEditControl(tvServers.InnerControl.Handle), WM_SETTEXT, 0, TnxNativeInt(PChar(tvEditText)));
  SendMessage(TreeView_GetEditControl(tvServers.InnerControl.Handle), EM_SETSEL, 0, -1);
end;

procedure TfrmTreeBrowser.popmnuTableEnterPasswordClick(Sender: TObject);
var
  Password : String;
begin
  Password := '';
  if InputQueryString(rsSetTablePassword, rsPassword, Password, True) then begin
    SetPasswordOnTable(GetSelectedNodeObject.Table, Password);
    try
      GetSelectedNodeObject.Table.Session.PasswordAdd(Password);
      GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
    except
      on E: EnxDatabaseError do
        if E.ErrorCode <> DBIERR_NAMENOTUNIQUE then
          raise;
      on E: Exception do
        raise;
    end;
  end;
end;

procedure TfrmTreeBrowser.popmnuTablesEnterPasswordClick(Sender: TObject);
var
  Password       : String;
  i              : Integer;
  AllowExpansion : Boolean;
begin
  GetSelectedNodeObject.Database.Active := True;
  AllowExpansion := True;
  tvServersExpanding(tvServers, tvServers.Selected, AllowExpansion);
  Password := '';
  if InputQueryString(rsSetTablePasswordForAllTables, rsPassword, Password, True) then begin
    with tvServers.Selected do
    for i := 0 to Pred(Count) do
      SetPasswordOnTable(GetNodeObject(Item[i]).Table, Password);
    try
      GetSelectedNodeObject.Database.Session.PasswordAdd(Password);
      GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
    except
      on E: EnxDatabaseError do
        if E.ErrorCode <> DBIERR_NAMENOTUNIQUE then
          raise;
      on E: Exception do
        raise;
    end;
  end;
end;

procedure TfrmTreeBrowser.SetPasswordOnTable(aTable : TnxTableRefCount; aPassword : String);
var
  WasActive : Boolean;
begin
  WasActive := aTable.Active;
  aTable.Active := False;
  try
    aTable.Password := aPassword;
  finally
    aTable.Active := WasActive;
  end;
end;

function TfrmTreeBrowser.OpenAndCheckPassword(aTable : TnxTableRefCount) : Boolean;
var
  Password         : String;
begin
  Result := False;
  try
    aTable.Open;
    Result := True;
  except
    on E: EnxDatabaseError do
      if E.ErrorCode = DBIERR_INVALIDPASSWORD then begin
        Password := '';
        if InputQueryString('Input Password', 'Password:', Password, True) then begin
          aTable.Password := Password;
          try
            aTable.Session.PasswordAdd(Password);
            GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
          except
            on E: EnxDatabaseError do
              if E.ErrorCode <> DBIERR_NAMENOTUNIQUE then
                raise;
            on E: Exception do
              raise;
          end;
          Result := OpenAndCheckPassword(aTable);
        end;
      end
      else
        raise;
  end;
end;

procedure TfrmTreeBrowser.popmnuTableRecoverClick(Sender: TObject);
var
  Status                      : TnxTaskStatus;
  TaskInfo                    : TnxAbstractTaskInfo;
  Cancelled,
  Completed                   : Boolean;
  NodeObject                  : TnxemNode;
begin
  if Sender is TTreeNode then
    NodeObject := GetNodeObject(TTreeNode(Sender))
  else
    NodeObject := GetNodeObject(tvServers.Selected);

  WarnAboutOutsideTransactionMethod;
  CloseTableBrowser(NodeObject.Table, True);
  NodeObject.TableBusy := True;

  try
    with NodeObject.Table do
      nxCheck(Database.RecoverTableEx(TableName, Password, TaskInfo));

    if Assigned(TaskInfo) then
      with TfrmRebuildProgress.Create(frmMain) do try
        frmMain.Enabled := False;
        Show;
        ShowProgress(rsRecovering, NodeObject.Table.TableName, True);
        Application.ProcessMessages;

        Cancelled := False;
        repeat
          if not Cancelled then
            TaskInfo.GetStatus(Completed, Status);

          Application.ProcessMessages;

          if not Completed then begin
            UpdateRecoverRecordsProgress(Status, Cancelled);
            if not Cancelled then
              Sleep(250)
            else
              TaskInfo.Cancel;
          end;
        until Completed or Cancelled;
        if Cancelled then
          Abort;
        Check(Status.tsErrorCode);
      finally
        Free;
        frmMain.Enabled := True;
      end;

    if not (Sender is TTreeNode) then
      LoadOutlineTables(tvServers.Selected.Parent);
  finally
    NodeObject.TableBusy := False;
    if Assigned(TaskInfo) then
      TaskInfo.Free;
  end;

  if not (Sender is TTreeNode) then
    ShowMessage(Format(rsRecoveredTableNames, [NodeObject.Table.TableName]));
end;

procedure TfrmTreeBrowser.tiAlignTimer(Sender: TObject);
begin
  tiAlign.Enabled := False;
  Align := alNone;
  //double assignment intentional
  Align := alClient;
end;

procedure TfrmTreeBrowser.tiRightSelectTimer(Sender: TObject);
begin
  tiRightSelect.Enabled := False;
  tvServers.Selected := SavedSelected;
end;

procedure TfrmTreeBrowser.SaveRightClickSelected;
begin
  SavedSelected := tvServers.Selected;
  tiRightSelect.Enabled := True;
end;

procedure TfrmTreeBrowser.FormDestroy(Sender: TObject);
begin
  tvServers.onClick := nil;
  tvServersLock.Free;
  if Assigned(NamedPipeActiveBroadcast) then
    NamedPipeActiveBroadcast.Stop;
  if Assigned(WinsockActiveBroadcast) then
    WinsockActiveBroadcast.Stop;
  if Assigned(SharedMemoryActiveBroadcast) then
    SharedMemoryActiveBroadcast.Stop;
  if Assigned(tbServerBroadcastListWinsock) then
    tbServerBroadcastListWinsock.Free;
  if Assigned(tbServerBroadcastListNamedPipe) then
    tbServerBroadcastListNamedPipe.Free;
  if Assigned(tbServerBroadcastListSharedMemory) then
    tbServerBroadcastListSharedMemory.Free;
  if Assigned(tbServerRegisteredList) then
    tbServerRegisteredList.Free;
  if Assigned(tbServerDropList) then
    tbServerDropList.Free;
  FreeOutlineObjects;
  tbNodeDataList.Free;

  inherited;
end;

procedure TfrmTreeBrowser.popmnuTablesEmptyAllTablesClick(Sender: TObject);
var
  TableIndex                  : Integer;
  Node                        : TTreeNode;
  UserResponse                : Word;
  SaveCursor                  : TCursor;
  Errors                      : string;
begin
  Errors := '';
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(rsAreYouSureYouWantToEmptyAllTables, mtWarning, [mbYes, mbNo], 0) = mrYes then begin

    Node := tvServers.Selected;
    CloseAllTableBrowsers(Node);

    if Node.Count = 0 then
      LoadOutlineTables(Node);

    UserResponse := mrNone;

    for TableIndex := 0 to Pred(Node.Count) do begin
      if UserResponse <> mrAll then
        UserResponse := MessageDlg(rsDeleteAllRecordsIn + GetNodeObject(Node.Item[TableIndex]).Table.TableName + '?',
                                   mtWarning, [mbYes, mbNo, mbAll], 0);

      if (UserResponse in [mrYes, mrAll])  then
      with GetNodeObject(Node.Item[TableIndex]) do begin
        CloseTableBrowser(Table, True);
        SaveCursor := Screen.Cursor;
        Screen.Cursor := crHourglass;
        try
          try
            try
              Table.Close;
              Table.Exclusive := True;
              Table.Open;
            finally
              Table.Close;
              Table.Exclusive := False;
            end;
            Table.EmptyTable;
          except
            on E:Exception do begin
              if Errors.IsEmpty then
                Errors := rsErrorsOccured + #13#10;
              Errors := Errors + Table.TableName + ': ' + E.Message + #13#10;
            end;
          end;
        finally
          Screen.Cursor := SaveCursor;
        end;
      end;
    end;

    if not Errors.IsEmpty then
      ShowMessage(Errors);
  end;
end;


procedure TfrmTreeBrowser.tvServersContextPopup(Sender   : TObject;
                                                MousePos : TPoint;
                                            var Handled  : Boolean);
begin
  if Assigned(tvServers.Selected) then
  if tvServers.IsEditing then
    Handled := False
  else begin
    case GetSelectedNodeObject.NodeType of
      ntServer      : ActivePopupMenu := popmnuServer;
      ntDatabase    : ActivePopupMenu := popmnuDatabase;
      ntTables      : ActivePopupMenu := popmnuTables;
      ntTable       : ActivePopupMenu := popmnuTable;
      ntChildTable  : ActivePopupMenu := popmnuChildTable;
      ntViews       : ActivePopupMenu := popmnuViews;
      ntView        : ActivePopupMenu := popmnuView;
      ntTriggers    : ActivePopupMenu := popmnuTriggers;
      ntTrigger     : ActivePopupMenu := popmnuTrigger;
      ntStoredProcs : ActivePopupMenu := popmnuStoredProcs;
      ntProcedure,
      ntFunction    : ActivePopupMenu := popmnuStoredProc;
      ntCheckConstraints : ActivePopupMenu := popmnuCheckConstraints;
      ntCheckConstraint  : ActivePopupMenu := popmnuCheckConstraint;
    end;

    Assert(Assigned(ActivePopupMenu));
    MousePos := ClientToScreen(MousePos);
    try
      Handled := True;
      ActivePopupMenu.Popup(MousePos.X, MousePos.Y);
    except
      if Assigned(ActivePopupMenu) and
         Assigned(ActivePopupMenu.ItemLinks) and
         Assigned(ActivePopupMenu.ItemLinks.BarControl) then
        TdxBarSubMenuControl(ActivePopupMenu.ItemLinks.BarControl).Hide;
      ActivePopupMenu := nil;
      raise;
    end;
    SaveRightClickSelected;
  end;
end;


procedure TfrmTreeBrowser.DoFormActivate;
begin
  tvServers.SetFocus;
end;

procedure TfrmTreeBrowser.FormCreate(Sender: TObject);
begin
  FOnFormActivate := DoFormActivate;
  tvServersLock := TCriticalSection.Create;
  WinsockBroadcastReplyHandler := TnxBroadcastReplyHandler.Create(Self, brttWinsock);
  NamedPipeBroadcastReplyHandler := TnxBroadcastReplyHandler.Create(Self, brttNamedPipe);
  SharedMemoryBroadcastReplyHandler := TnxBroadcastReplyHandler.Create(Self, brttSharedMemory);
  tbServerBroadcastListWinsock := TStringList.Create;
  tbServerBroadcastListWinsock.Duplicates := dupError;
  tbServerBroadcastListNamedPipe := TStringList.Create;
  tbServerBroadcastListNamedPipe.Duplicates := dupError;
  tbServerBroadcastListSharedMemory := TStringList.Create;
  tbServerBroadcastListSharedMemory.Duplicates := dupError;
  tbServerRegisteredList := TStringList.Create;
  tbServerRegisteredList.Duplicates := dupError;
  tbServerDropList := TStringList.Create;
  tbServerDropList.Duplicates := dupIgnore;
  tbNodeDataList := TStringList.Create;
  tbNodeDataList.CaseSensitive := False;
  tvServers.Images := frmMain.ImageList; //..
  ScalingDone := True;
end;

procedure TfrmTreeBrowser.popmnuServerPopup(Sender: TObject);
begin
  if (not GetSelectedNodeObject.ServerEngine.Active) or
     (Assigned(tvServers.Selected) and
      (tvServers.Selected = tvServers.Items[0])) then begin
//    if DoAttach(tvServers.Selected)<>DBIERR_NONE then
//      Exit;
    if tvServers.Selected.Count = 1 then
      tvServers.Selected.Item[0].Expand(False);
  end;
  UpdateServerPopupMenu;
end;

procedure TfrmTreeBrowser.popmnuServerPropertiesClick(Sender: TObject);
begin
  with TdlgConnectionProperties.Create(Self) do try
    with (GetSelectedNodeObject.Transport as TnxBasePooledTransport) do begin
      cbCompressionType.ItemIndex := CompressType;
      seCompressLimit.Value := CompressLimit;
      gbHttpTransport.Enabled := GetSelectedNodeObject.Transport is TnxHttpTransport;
      if GetSelectedNodeObject.Transport is TnxHttpTransport then begin
        cbClientIgnoreUnknownCA.Checked := (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreUnknownCA;
        cbClientIgnoreCertDateInvalid.Checked := (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertDateInvalid;
        cbClientIgnoreCertCNInvalid.Checked := (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertCNInvalid;
        cbClientIgnoreCertWrongUsage.Checked := (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertWrongUsage;
      end;
      if (ShowModal = mrOK) and
        ((CompressType <> cbCompressionType.ItemIndex) or
         (CompressLimit <> seCompressLimit.Value)) or
        ((GetSelectedNodeObject.Transport is TnxHttpTransport) and
       (((GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreUnknownCA <> cbClientIgnoreUnknownCA.Checked) or
        ((GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertDateInvalid <> cbClientIgnoreCertDateInvalid.Checked) or
        ((GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertCNInvalid <> cbClientIgnoreCertCNInvalid.Checked) or
        ((GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertWrongUsage <> cbClientIgnoreCertWrongUsage.Checked))) then begin
        if (not ServerHasOpenTabs(tvServers.Selected)) or
           (MessageDlg('To change connection properties, connection must be closed and all related Table/Sql/Restructure tabs will also close. Continue?',
                        TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], 0) = mrOk) then begin
          DoDetach;
          Connected := False;
          CompressType := cbCompressionType.ItemIndex;
          CompressLimit := seCompressLimit.Value;
          if GetSelectedNodeObject.Transport is TnxHttpTransport then begin
            (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreUnknownCA := cbClientIgnoreUnknownCA.Checked;
            (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertDateInvalid := cbClientIgnoreCertDateInvalid.Checked;
            (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertCNInvalid := cbClientIgnoreCertCNInvalid.Checked;
            (GetSelectedNodeObject.Transport as TnxHttpTransport).ClientIgnoreCertWrongUsage := cbClientIgnoreCertWrongUsage.Checked;
            var IgnoreRec := Default(TnxCertIgnoreRecord);
            IgnoreRec.ClientIgnoreUnknownCA := cbClientIgnoreUnknownCA.Checked;
            IgnoreRec.ClientIgnoreCertDateInvalid := cbClientIgnoreCertDateInvalid.Checked;
            IgnoreRec.ClientIgnoreCertCNInvalid := cbClientIgnoreCertCNInvalid.Checked;
            IgnoreRec.ClientIgnoreCertWrongUsage := cbClientIgnoreCertWrongUsage.Checked;
            Config.HttpServerCertIgnore[(GetSelectedNodeObject.Transport as TnxHttpTransport).ServerName] := IgnoreRec;
          end;
          nxeConfigSetConnectionProperties(tvServers.Selected.Text, CompressType, CompressLimit);
          if DoAttach(tvServers.Selected) = DBIERR_NONE then
            tvServers.Selected.Expand(False);
        end;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuDatabasePopup(Sender: TObject);
begin
  UpdateDatabasePopupMenu;
end;

procedure TfrmTreeBrowser.popmnuTablePopup(Sender: TObject);
begin
  UpdateTablePopupMenu;
end;

procedure TfrmTreeBrowser.popmnuTableCloneTableStructureClick(Sender: TObject);
var
  TName     : String;
  Dict      : TnxDataDictionary;
  WasOpen   : Boolean;
begin
  WasOpen := False;
  TName := tvServers.Selected.Text;
  if InputQuery('Clone Table', 'New Table Name', TName) then begin
    Dict := TnxDataDictionary.Create;
    with GetSelectedNodeObject, Table do
    try
      WasOpen := Active;
      if not WasOpen then
        if not OpenAndCheckPassword(Table) then
          Exit;
      Dict.Assign(_Dictionary);
      Check(Database.CreateTableEx(False, TName, '', Dict));
      LoadOutlineTables(tvServers.Selected.Parent);
    finally
      Dict.Free;
      if not WasOpen then
        Close;
    end;
  end;
end;

procedure TfrmTreeBrowser.tvServersClick(Sender: TObject);
begin
  if Assigned(tvServers.Selected) and
     (GetSelectedNodeObject.NodeType = ntTable) then
    LoadOutlineChildTables(tvServers.Selected, nil, nil);
end;

function TfrmTreeBrowser.AddOutlineChildTable(aParentNode : TTreeNode;
                                              aTableName  : string)
                                                          : TTreeNode;
var
  NodeObject                  : TnxemNode;
begin
  NodeObject := TnxemNode.Create;
  NodeObject.Table := TnxTableRefCount.Create(nil);
  NodeObject.NodeType := ntChildTable;
  NodeObject.Table.TableName := GetNodeObject(aParentNode).Table.TableName + ':' + aTableName;
  NodeObject.Table.Database := GetNodeObject(aParentNode).Table.Database;
  Result := tvServers.Items.AddChild(aParentNode, aTableName);
  if assigned(Result) then begin
    Result.ImageIndex := nxc_TableImageIndex;
    Result.SelectedIndex := nxc_TableImageIndex;
    Result.HasChildren := False;
    tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
  end;
  aParentNode.AlphaSort;
end;

procedure TfrmTreeBrowser.popmnuServerRefreshServerListClick(Sender: TObject);
begin
  acServersRefreshExecute(Sender);
end;

procedure TfrmTreeBrowser.UpdateChildTablePopupMenu;
begin
  { update in UpdateTablePopupMenu if visible list changes }
  popmnuTableDelete.Visible := ivNever;
  popmnuTableRename.Visible := ivNever;
  popmnuTableEmpty.Visible := ivNever;
  popmnuTableRecover.Visible := ivNever;
end;

procedure TfrmTreeBrowser.LoadOutlineStoredProcs(aNode: TTreeNode);
var
  StoredProcIdx,
  i                           : Integer;
  StoredProcList              : TStringList;
  DropList                    : TStringList;
  StoredProcName              : String;
  FunctionsQuery              : TnxQuery;
begin
  if (not GetNodeObject(aNode).Database.Active) then
    if DoAttach(aNode.Parent.Parent) <> DBIERR_NONE then
      Exit;

  StoredProcList := TStringList.Create;
  StoredProcList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  FunctionsQuery := TnxQuery.Create(nil);
  try
    with GetNodeObject(aNode) do
      Database.Session.GetStoredProcNames(Database.AliasName, StoredProcList);

    StoredProcList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(StoredProcList.Count) do
      StoredProcList.Objects[i] := TObject(False);

    { mark procs that already exist in treeview,
      add procs that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      if GetNodeObject(aNode.Item[i]).NodeType = ntFunction then
        Continue;
      StoredProcName := aNode.Item[i].Text;
      StoredProcIdx := StoredProcList.IndexOf(StoredProcName);
      if StoredProcIdx>=0 then
        StoredProcList.Objects[StoredProcIdx] := TObject(True)
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new procs to treeview }
    for i := 0 to Pred(StoredProcList.Count) do
      if not Boolean(StoredProcList.Objects[i]) then try
        AddOutlineStoredProc(aNode, StoredProcList[i], ntProcedure);
      except
        on E:Exception do
          MessageDlg(rsCouldNotAddStoredProc + E.Message, mtInformation, [mbOK], 0);
      end;

    { delete procs that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

    StoredProcList.Clear;
    DropList.Clear;

    FunctionsQuery.Database := GetNodeObject(aNode).Database;
    FunctionsQuery.SQL.Text := 'SELECT FUNCTION_NAME FROM #Functions';
    with FunctionsQuery do begin
      Open;
      First;
      while not EOF do begin
        StoredProcList.Add(FieldByName('FUNCTION_NAME').AsString);
        Next;
      end;
    end;

    { ensure default is false... }
    for i := 0 to Pred(StoredProcList.Count) do
      StoredProcList.Objects[i] := TObject(False);

    { mark funcs that already exist in treeview,
      add funcs that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      if GetNodeObject(aNode.Item[i]).NodeType = ntProcedure then
        Continue;
      StoredProcName := aNode.Item[i].Text;
      StoredProcIdx := StoredProcList.IndexOf(StoredProcName);
      if StoredProcIdx>=0 then
        StoredProcList.Objects[StoredProcIdx] := TObject(True)
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new funcs to treeview }
    for i := 0 to Pred(StoredProcList.Count) do
      if not Boolean(StoredProcList.Objects[i]) then try
        AddOutlineStoredProc(aNode, StoredProcList[i], ntFunction);
      except
        on E:Exception do
          MessageDlg(rsCouldNotAddStoredProc + E.Message, mtInformation, [mbOK], 0);
      end;

    { delete funcs that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

  finally
    StoredProclist.Free;
    DropList.Free;
    FunctionsQuery.Free;
  end;
  aNode.AlphaSort;
end;

procedure TfrmTreeBrowser.LoadOutlineCheckConstraints(aNode: TTreeNode);
var
  CheckConstraintIdx,
  i                           : Integer;
  CheckConstraintList         : TStringList;
  DropList                    : TStringList;
  CheckConstraintName         : String;
  CheckConstraintQuery        : TnxQuery;
begin
  if (not GetNodeObject(aNode).Database.Active) then
    if DoAttach(aNode.Parent.Parent) <> DBIERR_NONE then
      Exit;

  CheckConstraintList := TStringList.Create;
  CheckConstraintList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  CheckConstraintQuery := TnxQuery.Create(nil);
  try
    CheckConstraintList.Sorted := True;
    DropList.Sorted := True;

    CheckConstraintQuery.Database := GetNodeObject(aNode).Database;
    CheckConstraintQuery.SQL.Text := 'SELECT CHECK_CONSTRAINT_NAME, CHECK_CONSTRAINT_TABLE_NAME FROM #CHECK_CONSTRAINTS';
    with CheckConstraintQuery do begin
      Open;
      First;
      while not EOF do begin
        CheckConstraintList.Add(FieldByName('CHECK_CONSTRAINT_TABLE_NAME').AsString + '.' + FieldByName('CHECK_CONSTRAINT_NAME').AsString);
        Next;
      end;
    end;

    { ensure default is false... }
    for i := 0 to Pred(CheckConstraintList.Count) do
      CheckConstraintList.Objects[i] := TObject(False);

    { mark funcs that already exist in treeview,
      add funcs that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      if GetNodeObject(aNode.Item[i]).NodeType = ntProcedure then
        Continue;
      CheckConstraintName := aNode.Item[i].Text;
      CheckConstraintIdx := CheckConstraintList.IndexOf(CheckConstraintName);
      if CheckConstraintIdx>=0 then
        CheckConstraintList.Objects[CheckConstraintIdx] := TObject(True)
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new funcs to treeview }
    for i := 0 to Pred(CheckConstraintList.Count) do
      if not Boolean(CheckConstraintList.Objects[i]) then try
        AddOutlineCheckConstraint(aNode, CheckConstraintList[i]);
      except
        on E:Exception do
          MessageDlg(rsCouldNotAddCheckConstraint + E.Message, mtInformation, [mbOK], 0);
      end;

    { delete funcs that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

  finally
    CheckConstraintlist.Free;
    DropList.Free;
    CheckConstraintQuery.Free;
  end;
  aNode.AlphaSort;
end;

procedure TfrmTreeBrowser.LoadOutlineViews(aNode: TTreeNode);
var
  ViewIdx,
  i                     : Integer;
  ViewList              : TStringList;
  DropList              : TStringList;
  ViewName              : String;
  ViewQuery             : TnxQuery;
begin
  if (not GetNodeObject(aNode).Database.Active) then
    if DoAttach(aNode.Parent.Parent) <> DBIERR_NONE then
      Exit;

  ViewList := TStringList.Create;
  ViewList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  ViewQuery := TnxQuery.Create(nil);
  try
    ViewQuery.Database := GetNodeObject(aNode).Database;
    ViewQuery.SQL.Text := 'SELECT VIEW_NAME FROM #Views';
    with ViewQuery do begin
      Open;
      First;
      while not EOF do begin
        ViewList.Add(FieldByName('VIEW_NAME').AsString);
        Next;
      end;
    end;

    ViewList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(ViewList.Count) do
      ViewList.Objects[i] := TObject(False);

    { mark tables that already exist in treeview,
      add tables that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      ViewName := aNode.Item[i].Text;
      ViewIdx := ViewList.IndexOf(ViewName);
      if ViewIdx>=0 then
        ViewList.Objects[ViewIdx] := TObject(True)
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new databases to treeview }
    for i := 0 to Pred(ViewList.Count) do
      if not Boolean(ViewList.Objects[i]) then try
        AddOutlineView(aNode, ViewList[i]);
      except
        on E:Exception do
          MessageDlg(rsCouldNotAddView + E.Message, mtInformation, [mbOK], 0);
      end;

    { delete stored procs that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

  finally
    Viewlist.Free;
    DropList.Free;
    ViewQuery.Free;
  end;
  aNode.AlphaSort;
end;

procedure TfrmTreeBrowser.LoadOutlineTriggers(aNode: TTreeNode);
var
  TriggerIdx,
  i                     : Integer;
  TriggerList           : TStringList;
  DropList              : TStringList;
  TriggerName           : String;
  TriggerQuery          : TnxQuery;
begin
  if (not GetNodeObject(aNode).Database.Active) then
    if DoAttach(aNode.Parent.Parent) <> DBIERR_NONE then
      Exit;

  TriggerList := TStringList.Create;
  TriggerList.CaseSensitive := True;
  DropList := TStringList.Create;
  DropList.CaseSensitive := True;
  TriggerQuery := TnxQuery.Create(nil);
  try
    TriggerQuery.Database := GetNodeObject(aNode).Database;
    TriggerQuery.SQL.Text := 'SELECT TRIGGER_NAME FROM #Triggers';
    with TriggerQuery do begin
      Open;
      First;
      while not EOF do begin
        TriggerList.Add(FieldByName('TRIGGER_NAME').AsString);
        Next;
      end;
    end;

    TriggerList.Sorted := True;
    DropList.Sorted := True;

    { ensure default is false... }
    for i := 0 to Pred(TriggerList.Count) do
      TriggerList.Objects[i] := TObject(False);

    { mark tables that already exist in treeTrigger,
      add tables that no longer exist in database to droplist }
    for i := 0 to Pred(aNode.Count) do begin
      TriggerName := aNode.Item[i].Text;
      TriggerIdx := TriggerList.IndexOf(TriggerName);
      if TriggerIdx>=0 then
        TriggerList.Objects[TriggerIdx] := TObject(True)
      else
        DropList.Add(aNode.Item[i].Text);
    end;

    { add new triggers to tree }
    for i := 0 to Pred(TriggerList.Count) do
      if not Boolean(TriggerList.Objects[i]) then try
        AddOutlineTrigger(aNode, TriggerList[i]);
      except
        on E:Exception do
          MessageDlg(rsCouldNotAddTrigger + E.Message, mtInformation, [mbOK], 0);
      end;

    { delete triggers that no longer exist }
    if DropList.Count > 0 then
    for i := Pred(aNode.Count) downto 0 do
      if (DropList.IndexOf(aNode.Item[i].Text)>=0) then
      with tvServers do begin
        aNode.Item[i].Delete;
      end;

  finally
    Triggerlist.Free;
    DropList.Free;
    TriggerQuery.Free;
  end;
  aNode.AlphaSort;
end;

function TfrmTreeBrowser.AddOutlineStoredProc(aNode           : TTreeNode;
                                              aStoredProcName : string;
                                              aNodeType : TnxemNodeType): TTreeNode;
var
  NodeObject               : TnxemNode;
begin
  Result := nil;
  NodeObject := TnxemNode.Create;
  NodeObject.NodeType := aNodeType;
  with tvServers do try
    Result := Items.AddChild(aNode, aStoredProcName);
    if assigned(Result) then begin
      case aNodeType of
        ntProcedure: begin
          Result.ImageIndex := nxc_ProcedureImageIndex;
          Result.SelectedIndex := nxc_ProcedureImageIndex;
        end;
        ntFunction: begin
          Result.ImageIndex := nxc_FunctionImageIndex;
          Result.SelectedIndex := nxc_FunctionImageIndex;
        end;
      end;
      Result.HasChildren := False;
      tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
    end;
    aNode.AlphaSort;
  except
    on E: Exception do
      MessageDlg(rsCouldNotAddStoredProc + E.Message, mtInformation, [mbOK], 0);
  end;
end;

function TfrmTreeBrowser.AddOutlineView(aNode     : TTreeNode;
                                        aViewName : string): TTreeNode;
var
  NodeObject               : TnxemNode;
begin
  Result := nil;
  NodeObject := TnxemNode.Create;
  NodeObject.NodeType := ntView;
  with tvServers do try
    Result := Items.AddChild(aNode, aViewName);
    if assigned(Result) then begin
      Result.ImageIndex := nxc_ViewImageIndex;
      Result.SelectedIndex := nxc_ViewImageIndex;
      Result.HasChildren := False;
      tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
    end;
    aNode.AlphaSort;
  except
    on E: Exception do
      MessageDlg(rsCouldNotAddView + E.Message, mtInformation, [mbOK], 0);
  end;
end;

function TfrmTreeBrowser.AddOutlineTrigger(aNode        : TTreeNode;
                                           aTriggerName : string): TTreeNode;
var
  NodeObject               : TnxemNode;
begin
  Result := nil;
  NodeObject := TnxemNode.Create;
  NodeObject.NodeType := ntTrigger;
  with tvServers do try
    Result := Items.AddChild(aNode, aTriggerName);
    if assigned(Result) then begin
      Result.ImageIndex := nxc_TriggerImageIndex;
      Result.SelectedIndex := nxc_TriggerImageIndex;
      Result.HasChildren := False;
      tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
    end;
    aNode.AlphaSort;
  except
    on E: Exception do
      MessageDlg(rsCouldNotAddTrigger + E.Message, mtInformation, [mbOK], 0);
  end;
end;

function TfrmTreeBrowser.AddOutlineCheckConstraint(aNode                : TTreeNode;
                                                   aCheckConstraintName : string)
                                                                        : TTreeNode;
var
  NodeObject               : TnxemNode;
begin
  Result := nil;
  NodeObject := TnxemNode.Create;
  NodeObject.NodeType := ntCheckConstraint;
  with tvServers do try
    Result := Items.AddChild(aNode, aCheckConstraintName);
    if assigned(Result) then begin
      Result.ImageIndex := nxc_CheckConstraintImageIndex;
      Result.SelectedIndex := nxc_CheckConstraintImageIndex;
      Result.HasChildren := False;
      tbNodeDataList.AddObject(GetNodePath(Result), NodeObject);
    end;
    aNode.AlphaSort;
  except
    on E: Exception do
      MessageDlg(rsCouldNotAddCheckConstraint + E.Message, mtInformation, [mbOK], 0);
  end;
end;


{ TnxBroadcastReplyHandler }

constructor TnxBroadcastReplyHandler.Create(aTreeBrowser   : TfrmTreeBrowser;
                                            aTransportType : TnxBroadcastReplyTransportType);
begin
  inherited Create;
  brhTreeBrowser := aTreeBrowser;
  brhTransportType := aTransportType;
end;

procedure TnxBroadcastReplyHandler.ReplyReceived(aReply: InxBroadcastReply);
var
  NewTransport                : TnxBaseTransport;
begin
  if Application.Terminated then
    Exit;

  if aReply.GetServerVersion < nxVersion20000 then
    Exit;

  with brhTreeBrowser do begin
    tvServersLock.Acquire;

    try
      case brhTransportType of
        brttWinsock : if not ServerIsRegistered(aReply.GetServerName, Config.RegisteredTcpIpServers) and
                            (tbServerBroadcastListWinsock.IndexOf(aReply.GetServerName) < 0) then begin
                        try
                          tvServers.Items.BeginUpdate;
                          NewTransport := TnxWinsockTransport.Create(nil);
                          TnxWinsockTransport(NewTransport).ServerName := aReply.GetServerName;
                          NewTransport.Enabled := True;
                          TnxWinsockTransport(NewTransport).HeartbeatInterval := Config.KeepaliveFrequency;
                          TnxWinsockTransport(NewTransport).CallbackThreadCount := 2;
                          tbServerBroadcastListWinsock.Add(aReply.GetServerName);
                          GetDnsNameAsync(AddOutlineServer(TnxRemoteServerEngine.Create(nil),
                                          NewTransport,
                                          aReply.GetServerName + rsWinsock1 + ' [---]'), aReply.GetServerName);
                        finally
                          tvServers.Items.EndUpdate;
                        end;
                      end;
        brttNamedPipe : if not ServerIsRegistered(aReply.GetServerName, Config.RegisteredNamedPipeServers) and
                            (tbServerBroadcastListNamedPipe.IndexOf(aReply.GetServerName) < 0) then begin
                        try
                          tvServers.Items.BeginUpdate;
                          NewTransport := TnxNamedPipeTransport.Create(nil);
                          TnxNamedPipeTransport(NewTransport).ServerName := aReply.GetServerName;
                          NewTransport.Enabled := True;
                          TnxNamedPipeTransport(NewTransport).HeartbeatInterval := Config.KeepaliveFrequency;
                          TnxNamedPipeTransport(NewTransport).CallbackThreadCount := 2;
                          tbServerBroadcastListNamedPipe.Add(aReply.GetServerName);
                          AddOutlineServer(TnxRemoteServerEngine.Create(nil),
                                           NewTransport,
                                           aReply.GetServerName + rsNamedPipe1);
                        finally
                          tvServers.Items.EndUpdate;
                        end;
                      end;
        brttSharedMemory : if (tbServerBroadcastListSharedMemory.IndexOf(aReply.GetServerName) < 0) then begin
                             try
                               tvServers.Items.BeginUpdate;
                               NewTransport := TnxSharedMemoryTransport.Create(nil);
                               TnxSharedMemoryTransport(NewTransport).ServerName := aReply.GetServerName;
                               NewTransport.Enabled := True;
                               TnxSharedMemoryTransport(NewTransport).CallbackThreadCount := 2;
                               tbServerBroadcastListSharedMemory.Add(aReply.GetServerName);
                               AddOutlineServer(TnxRemoteServerEngine.Create(nil),
                                                NewTransport,
                                                aReply.GetServerName + rsSharedMemory);
                             finally
                               tvServers.Items.EndUpdate;
                             end;
                           end;
      end;

    finally
      tvServersLock.Release;
    end;
  end;
end;

procedure TfrmTreeBrowser.popmnuTableChangePasswordClick(Sender: TObject);
var
  Password : String;
begin
  Password := '';
  if InputQueryString(rsChangeTablePassword, rsPassword, Password, True) then begin
    ChangePasswordOnTable(GetSelectedNodeObject.Table, Password);
    GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
  end;
end;

procedure TfrmTreeBrowser.ChangePasswordOnTable(aTable : TnxTableRefCount; aPassword : String);
var
  WasOpen                     : Boolean;
  Dict                        : TnxDataDictionary;
  TaskInfo                    : TnxAbstractTaskInfo;
  Cancelled,
  Completed                   : Boolean;
  TableMapper                 : TnxTableMapperDescriptor;
  TaskStatus                  : TnxTaskStatus;
begin
  WasOpen := aTable.Active;
  if not aTable.Active then
    aTable.Open;
  Dict := TnxDataDictionary.Create;
  TableMapper := TnxTableMapperDescriptor.Create;
  try
    Dict.Assign(aTable._Dictionary);
    if Dict.EncryptionEngine = '' then begin
      Dict.EncryptionEngine := nx1xDefault;
      TableMapper.MapAllTablesAndFieldsByName(Dict, Dict);
      aTable.Close;
      nxCheck(aTable.Database.RestructureTableEx(aTable.TableName, aTable.Password, Dict, TableMapper, TaskInfo));
      try
        Application.ProcessMessages;

        if Assigned(TaskInfo) then
          with TfrmRebuildProgress.Create(frmMain) do try
            frmMain.Enabled := False;
            Show;
            ShowProgress(rsRestructuring, aTable.TableName, True);

            Cancelled := False;
            repeat
              if not Cancelled then
                TaskInfo.GetStatus(Completed, TaskStatus);

              Application.ProcessMessages;

              if not Completed then begin
                UpdateProgress(TaskStatus, Cancelled);
                if not Cancelled then
                  Sleep(500)
                else
                  TaskInfo.Cancel;
              end;
            until Completed or Cancelled;
            if Cancelled then
              Abort;
            Check(TaskStatus.tsErrorCode);
          finally
            Free;
            frmMain.Enabled := True;
          end;
      finally
        if Assigned(TaskInfo) then
          TaskInfo.Free;
      end;
    end;
  finally
    Dict.Free;
  end;
  aTable.Open;
  aTable.ChangePassword(aPassword);
  if not WasOpen then
    aTable.Close;
end;

procedure TfrmTreeBrowser.popmnuTablesChangePasswordClick(Sender: TObject);
var
  Password       : String;
  i              : Integer;
  AllowExpansion : Boolean;
begin
  GetSelectedNodeObject.Database.Active := True;
  AllowExpansion := True;
  tvServersExpanding(tvServers, tvServers.Selected, AllowExpansion);
  Password := '';
  if InputQueryString(rsChangeTablePasswordForAllTables, rsPassword, Password, True) then begin
    GetNodeObject(GetServerNode(tvServers.Selected)).TablePasswords.Add(Password);
    for i := 0 to Pred(tvServers.Selected.Count) do
      ChangePasswordOnTable(GetNodeObject(tvServers.Selected.Item[i]).Table, Password);
  end;
end;

procedure TfrmTreeBrowser.popmnuServerCloseInactiveClick(Sender: TObject);
begin
  GetSelectedNodeObject.Session.CloseInactiveTables;
  GetSelectedNodeObject.Session.CloseInactiveFolders;
end;

procedure TfrmTreeBrowser.popmnuServerCloseUp(Sender: TObject);
begin
  ActivePopupMenu := nil;
end;

procedure TfrmTreeBrowser.popmnuDatabaseRefIntEditorClick(Sender: TObject);
var
  Stream : TFileStream;
  RefIntegEditor : TnxRefIntegEditor;
begin
  GetSelectedNodeObject.Database.Active := True;
  RefIntegEditor := TnxRefIntegEditor.Create(Application.MainForm);
  with RefIntegEditor do try
    try
      Stream := nil;
      if FileExists(ExtractFilePath(Application.ExeName) + rsEM_RI_SettingsFileName) then try
        Stream := TFileStream.Create(ExtractFilePath(Application.ExeName) + rsEM_RI_SettingsFileName, fmOpenRead);
        LoadFromStream(Stream);
      finally
        nxFreeAndNil(Stream);
      end;
    except
    end;

    Database := GetSelectedNodeObject.Database;
    Edit;

    Stream := TFileStream.Create(ExtractFilePath(Application.ExeName) + rsEM_RI_SettingsFileName, fmCreate);
    try
      SaveToStream(Stream);
    finally
      Stream.Free;
    end;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuChildTablePopup(Sender: TObject);
begin
  UpdateTablePopupMenu;
  UpdateChildTablePopupMenu;
end;

procedure TfrmTreeBrowser.popmnuClientToClientMessagingClick(Sender: TObject);
begin
  with TdlgClientMessaging.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuStoredProcsRefreshClick(Sender: TObject);
begin
  LoadOutlineStoredProcs(tvServers.Selected);
end;

procedure TfrmTreeBrowser.popmnuViewsRefreshClick(Sender: TObject);
begin
  LoadOutlineViews(tvServers.Selected);
end;

procedure TfrmTreeBrowser.popmnuStoredProcsAddStoredProcClick(Sender: TObject);
begin
  ShowQueryBrowser(ntStoredProcs, csCreateStoredProc, False);
end;

procedure TfrmTreeBrowser.popmnuStoredProcsAddFunctionClick(Sender: TObject);
begin
  ShowQueryBrowser(ntStoredProcs, csCreateFunction, False);
end;

procedure TfrmTreeBrowser.popmnuStoredProcEditClick(Sender: TObject);
var
  i       : Integer;
  nxQuery : TnxWideBlobQuery;
begin
  nxQuery := TnxWideBlobQuery.Create(nil);
  try
    nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
    case GetSelectedNodeObject.NodeType of
      ntProcedure : nxQuery.Sql.Text :=
        'SELECT PROCEDURE_SOURCE as SOURCE from #procedures WHERE PROCEDURE_NAME = ' + QuotedStr(tvServers.Selected.Text);
      ntFunction : nxQuery.Sql.Text :=
        'SELECT FUNCTION_SOURCE as SOURCE from #functions WHERE FUNCTION_NAME = ' + QuotedStr(tvServers.Selected.Text);
    end;
    nxQuery.Open;
    for i := 0 to Pred(nxQuery.FieldCount) do
      if nxQuery.Fields[i] is TnxMemoField then
        TnxCrackMemoField(nxQuery.Fields[i]).mfIsWide := True;

    ShowQueryBrowser(GetSelectedNodeObject.NodeType,
      Format(csDropRoutine, ['"' + tvServers.Selected.Text + '"']) +
        TnxMemoField(nxQuery.FieldByName('SOURCE')).AsWideString,
      False);
  finally
    nxQuery.Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuStoredProcDeleteClick(Sender: TObject);
var
  nxQuery : TnxQuery;
begin
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(Format(rsDeleteStoredProc, [tvServers.Selected.Text]),
                mtConfirmation,
               [mbYes, mbNo],
                0) = mrYes then begin
    nxQuery := TnxQuery.Create(nil);
    try
      nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
      nxQuery.Sql.Text := Format(csDropRoutine, ['"' + tvServers.Selected.Text + '"']);
      nxQuery.ExecSql;
    finally
      nxQuery.Free;
    end;
    LoadOutlineStoredProcs(tvServers.Selected.Parent);
  end;
end;

procedure TfrmTreeBrowser.popmnuViewsAddClick(Sender: TObject);
begin
  ShowQueryBrowser(ntViews, csCreateView, False);
end;

procedure TfrmTreeBrowser.popmnuViewEditClick(Sender: TObject);
var
  i       : Integer;
  nxQuery : TnxWideBlobQuery;
begin
  nxQuery := TnxWideBlobQuery.Create(nil);
  try
    nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
    nxQuery.Sql.Text := 'SELECT VIEW_SOURCE from #views WHERE VIEW_NAME = ' + QuotedStr(tvServers.Selected.Text);
    nxQuery.Open;
    for i := 0 to Pred(nxQuery.Fields.Count) do
      if nxQuery.Fields[i] is TnxMemoField then
        TnxCrackMemoField(nxQuery.Fields[i]).mfIsWide := True;
    ShowQueryBrowser(ntView,
      Format(csDropView, ['"' + tvServers.Selected.Text + '"']) +
        TnxMemoField(nxQuery.FieldByName('VIEW_SOURCE')).AsWideString,
      False);
  finally
    nxQuery.Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuTablesVerifyAllTablesClick(Sender: TObject);
var
  TableIndex                  : Integer;
  Node                        : TTreeNode;
  NodeList                    : Array of string;
begin
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;

  Node := tvServers.Selected;
  CloseAllTableBrowsers(Node);

  if Node.Count = 0 then
    LoadOutlineTables(Node);

  SetLength(NodeList, Node.Count);
  for TableIndex := 0 to Pred(Node.Count) do
    NodeList[TableIndex] := GetNodeObject(Node.Item[TableIndex]).Table.TableName;

  TdlgVerifyTables.VerifyTables(Self, GetSelectedNodeObject.Database, NodeList);
end;

procedure TfrmTreeBrowser.popmnuTableVerifyTableClick(Sender: TObject);
var
  Node                        : TTreeNode;
  NodeList                    : Array of string;
begin
  WarnAboutOutsideTransactionMethod;

  Node := tvServers.Selected;
  CloseAllTableBrowsers(Node.Parent);

  SetLength(NodeList, 1);
  NodeList[0] := GetNodeObject(Node).Table.TableName;

  TdlgVerifyTables.VerifyTables(Self, GetNodeObject(Node).Table.Database, NodeList);
end;

procedure TfrmTreeBrowser.popmnuViewDeleteClick(Sender: TObject);
var
  nxQuery : TnxQuery;
begin
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(Format(rsDeleteView, [tvServers.Selected.Text]),
                mtConfirmation,
               [mbYes, mbNo],
                0) = mrYes then begin
    nxQuery := TnxQuery.Create(nil);
    try
      nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
      nxQuery.Sql.Text := Format(csDropView, ['"' + tvServers.Selected.Text + '"']);
      nxQuery.ExecSql;
    finally
      nxQuery.Free;
    end;
    LoadOutlineViews(tvServers.Selected.Parent);
  end;
end;

procedure TfrmTreeBrowser.popmnuViewOpenClick(Sender: TObject);
begin
  ShowQueryBrowser(ntView, 'SELECT * FROM ' + '"' + tvServers.Selected.Text + '"', True);
end;

procedure TfrmTreeBrowser.popmnuTriggersRefreshClick(Sender: TObject);
begin
  LoadOutlineTriggers(tvServers.Selected);
end;

procedure TfrmTreeBrowser.popmnuServerUsersAndPrivilegesClick(Sender: TObject);
var
  Admin   : InxLoggedInAdministrator31000;
  Modify  : InxModifyUser46000;
  s       : string;
begin
  Admin := GetNodeObject(tvServers.Selected).Session.LoggedInAdministrator;
  if not Assigned(Admin) then begin
    ShowMessage('Current user does not have Admin Privileges, please disconnect and log in with an Admin user account.' + #13#10  + #13#10 +
                'Note: If user credentials are not requested when you connect, then the "IsSecure" Server Engine setting on the NexusDB Server needs to be turned on.');
    Exit;
  end;

  s := GetNodeObject(tvServers.Selected).UserName;
  Modify := Admin.ModifyUser(s) as InxModifyUser46000;

  if (not Assigned(Modify)) or not Supports(Modify, InxModifyUser46000) then begin
    ShowMessage('The NexusDB Server you are connected to does not support the v4.60 interface required, consider upgrading the NexusDB Server to v4.60 or later for improved User Privilege support.');
    Exit;
  end;

  with TdlgUsersAndPrivileges.Create(nil) do//Self) do //Application.MainForm) do
  try
    Caption := Caption + ' for server: ' + tvServers.Selected.Text;
    Session := GetNodeObject(tvServers.Selected).Session;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuTriggersAddClick(Sender: TObject);
begin
  ShowQueryBrowser(ntTriggers, csCreateTrigger, False);
end;

procedure TfrmTreeBrowser.popmnuTriggerEditClick(Sender: TObject);
var
  i       : Integer;
  nxQuery : TnxWideBlobQuery;
begin
  nxQuery := TnxWideBlobQuery.Create(nil);
  try
    nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
    nxQuery.Sql.Text := 'SELECT TRIGGER_SOURCE from #triggers WHERE TRIGGER_NAME = ' + QuotedStr(tvServers.Selected.Text);
    nxQuery.Open;
    for i := 0 to Pred(nxQuery.Fields.Count) do
      if nxQuery.Fields[i] is TnxMemoField then
        TnxCrackMemoField(nxQuery.Fields[i]).mfIsWide := True;
    ShowQueryBrowser(ntTrigger,
      Format(csDropTrigger, ['"' + tvServers.Selected.Text + '"']) +
        TnxMemoField(nxQuery.FieldByName('TRIGGER_SOURCE')).AsWideString,
      False);
  finally
    nxQuery.Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuTriggerDeleteClick(Sender: TObject);
var
  nxQuery : TnxQuery;
begin
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(Format(rsDeleteTrigger, [tvServers.Selected.Text]),
                mtConfirmation,
               [mbYes, mbNo],
                0) = mrYes then begin
    nxQuery := TnxQuery.Create(nil);
    try
      nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
      nxQuery.Sql.Text := Format(csDropTrigger, ['"' + tvServers.Selected.Text + '"']);
      nxQuery.ExecSql;
    finally
      nxQuery.Free;
    end;
    LoadOutlineTriggers(tvServers.Selected.Parent);
  end;
end;

procedure TfrmTreeBrowser.popmnuCheckConstraintsRefreshClick(Sender: TObject);
begin
  LoadOutlineCheckConstraints(tvServers.Selected);
end;

procedure TfrmTreeBrowser.popmnuCheckConstraintsAddClick(Sender: TObject);
begin
  ShowQueryBrowser(ntTriggers,
                   Format(csCreateCheckConstraint, [csInsert_Name_Here, csInsert_New_Name_Here, '']),
                   False);
end;

procedure TfrmTreeBrowser.popmnuCheckConstraintEditClick(Sender: TObject);
var
  i              : Integer;
  nxQuery        : TnxWideBlobQuery;
  TableName,
  ConstraintName : string;
begin
  nxQuery := TnxWideBlobQuery.Create(nil);
  try
    nxStrSplit(tvServers.Selected.Text, ['.'], TableName, ConstraintName);
    nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
    nxQuery.Sql.Text := 'SELECT CHECK_CONSTRAINT_CHECK_CLAUSE, CHECK_CONSTRAINT_TABLE_NAME from #CHECK_CONSTRAINTS WHERE CHECK_CONSTRAINT_NAME = ' + QuotedStr(ConstraintName) +
                        ' AND CHECK_CONSTRAINT_TABLE_NAME = ' + QuotedStr(TableName);
    nxQuery.Open;
    for i := 0 to Pred(nxQuery.Fields.Count) do
      if nxQuery.Fields[i] is TnxMemoField then
        TnxCrackMemoField(nxQuery.Fields[i]).mfIsWide := True;
    ShowQueryBrowser(ntCheckConstraint,
      Format(csDropCheckConstraint, ['"' + TableName + '"', '"' + ConstraintName + '"']) +
        Format(csCreateCheckConstraint, ['"' + TableName + '"', '"' + ConstraintName + '"',
        TnxMemoField(nxQuery.FieldByName('CHECK_CONSTRAINT_CHECK_CLAUSE')).AsWideString]),
        False);
  finally
    nxQuery.Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuTablesChangeAllTablesClick(Sender: TObject);
var
  Node                        : TTreeNode;
begin
  Node := tvServers.Selected;
  GetSelectedNodeObject.Database.Active := True;
  WarnAboutOutsideTransactionMethod;

  if Node.Count = 0 then
    LoadOutlineTables(Node);

  with TdlgChangeAllTables.Create(Self) do try
    CurrentDatabase := GetSelectedNodeObject.Database;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmTreeBrowser.popmnuCheckConstraintDeleteClick(Sender: TObject);
var
  nxQuery        : TnxQuery;
  TableName,
  ConstraintName : string;
begin
  WarnAboutOutsideTransactionMethod;

  if MessageDlg(Format(rsDeleteCheck, [tvServers.Selected.Text]),
                mtConfirmation,
               [mbYes, mbNo],
                0) = mrYes then begin
    nxQuery := TnxQuery.Create(nil);
    try
      nxStrSplit(tvServers.Selected.Text, ['.'], TableName, ConstraintName);
      nxQuery.Database := GetNodeObject(tvServers.Selected.Parent).Database;
      nxQuery.Sql.Text := Format(csDropCheckConstraint, ['"' + TableName + '"', '"' + ConstraintName + '"']);
      nxQuery.Close;
      nxQuery.ExecSql;
    finally
      nxQuery.Free;
    end;
    LoadOutlineCheckConstraints(tvServers.Selected.Parent);
  end;
end;

procedure TfrmTreeBrowser.popmnuDatabaseRefreshClick(Sender: TObject);
begin
  GetSelectedNodeObject.Database.Active := True;
  LoadOutlineTables(GetTreeNodeFromObject(GetSelectedNodeObject.TablesNodeObject));
  LoadOutlineTriggers(GetTreeNodeFromObject(GetSelectedNodeObject.TriggersNodeObject));
  LoadOutlineViews(GetTreeNodeFromObject(GetSelectedNodeObject.ViewsNodeObject));
  LoadOutlineStoredProcs(GetTreeNodeFromObject(GetSelectedNodeObject.StoredProcsNodeObject));
  LoadOutlineCheckConstraints(GetTreeNodeFromObject(GetSelectedNodeObject.CheckConstraintsNodeObject));
end;

procedure TfrmTreeBrowser.popmnuDatabaseDesignReportClick(Sender: TObject);
begin
  {$IFDEF EMIncludeReportEngine}
  with GetSelectedNodeObject do begin
    Database.Session.Default := True;
    Database.Default := True;
    DesignReport(Database);
  end;
  {$ENDIF}
end;

procedure TfrmTreeBrowser.popmnuTablePrintPreviewClick(Sender: TObject);
var
  WasActive : Boolean;
begin
  {$IFDEF EMIncludeReportEngine}
  with GetSelectedNodeObject, Table do begin
    WasActive := Active;
    Session.Default := True;
    Database.Default := True;
    Active := True;
    SingleTableReport(Table);
    if not WasActive then
      Active := False;
  end;
  {$ENDIF}
end;

procedure TfrmTreeBrowser.tvServersDeletion(Sender: TObject; aNode: TTreeNode);
var
  idx : Integer;
begin
  if tbInDeleteNodes then begin
    idx := tbNodeDataList.IndexOf(GetNodePath(aNode));
    if idx >= 0 then begin
      TObject(tbNodeDataList.Objects[idx]).Free;
      tbNodeDataList.Delete(idx);
    end;
  end;
end;

end.

