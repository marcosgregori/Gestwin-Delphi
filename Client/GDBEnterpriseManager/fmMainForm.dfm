object frmMain: TfrmMain
  Left = 420
  Top = 228
  Caption = 'NexusDB Enterprise Manager %.4f'
  ClientHeight = 479
  ClientWidth = 1125
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 17
  object dxDockSiteMain: TdxDockSite
    Left = 0
    Top = 90
    Width = 1125
    Height = 389
    ManagerFont = False
    ParentFont = True
    Align = alClient
    DockingType = 5
    OriginalWidth = 1125
    OriginalHeight = 389
    object dxLayoutDockSite1: TdxLayoutDockSite
      Left = 217
      Top = 0
      Width = 908
      Height = 389
      ParentShowHint = False
      ShowHint = False
      DockingType = 0
      OriginalWidth = 300
      OriginalHeight = 200
    end
    object dpServer: TdxDockPanel
      Left = 0
      Top = 0
      Width = 217
      Height = 389
      ManagerFont = False
      ParentFont = True
      AllowClosing = False
      AllowDockClients = []
      AllowFloating = True
      AutoHide = False
      Caption = 'dpServer'
      CaptionButtons = [cbMaximize, cbHide]
      CustomCaptionButtons.Buttons = <>
      ImageIndex = 12
      TabsProperties.CustomButtons.Buttons = <>
      TabsProperties.Style = 11
      OnCloseQuery = dpServerCloseQuery
      OnEndDocking = dpServerEndDocking
      DockingType = 1
      OriginalWidth = 217
      OriginalHeight = 140
    end
  end
  object dlgPrinterSetup: TPrinterSetupDialog
    Left = 35
    Top = 168
  end
  object logMain: TnxEventLog
    Enabled = True
    NumRotations = 0
    RotationSize = 32
    FileName = 'nxEnterpriseManager.log'
    MaxSize = 0
    Left = 128
    Top = 168
  end
  object ActionList1: TActionList
    Left = 240
    Top = 128
    object acQuerySyntaxCheck: TAction
      Category = 'Query'
      Caption = 'Query Syntax Check'
      Hint = 'Query Syntax Check'
      ImageIndex = 6
      ShortCut = 24645
      OnExecute = acQuerySyntaxCheckExecute
    end
    object acHelpContents: THelpContents
      Category = 'Help'
      Caption = '&Contents'
      Enabled = False
      Hint = 'Help Contents'
      ImageIndex = 11
      Visible = False
      OnExecute = acHelpContentsExecute
    end
    object acGlobalOptionsReadonlyDatasets: TAction
      Category = 'GlobalOptions'
      Caption = '&Readonly Datasets'
      Hint = 'Readonly Datasets (Global)'
      ImageIndex = 20
      OnExecute = acGlobalOptionsReadonlyDatasetsMenuExecute
    end
    object acGlobalOptionsDefaultTimeout: TAction
      Category = 'GlobalOptions'
      Caption = '&Default Timeout'
      Hint = 'Default Timeout'
      ImageIndex = 7
      OnExecute = acGlobalOptionsDefaultTimeoutExecute
    end
    object acHelpAbout: TAction
      Category = 'Help'
      Caption = '&About'
      Hint = 'About EM'
      ImageIndex = 8
      OnExecute = acHelpAboutExecute
    end
    object acHelpNexusDBWebSite: TAction
      Category = 'Help'
      Caption = '&NexusDB Web Site'
      Hint = 'Goto NexusDB Website'
      ImageIndex = 9
      OnExecute = acHelpNexusDBWebSiteExecute
    end
    object acHelpNexusDBNewsgroups: TAction
      Category = 'Help'
      Caption = 'NexusDB Newsgroups'
      Hint = 'Open NexusDB Newsgroups'
      ImageIndex = 10
      OnExecute = acHelpNexusDBNewsgroupsExecute
    end
    object acFileExit: TAction
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit'
      OnExecute = acFileExitExecute
      OnUpdate = acFileExitUpdate
    end
    object acFilePrintSetup: TAction
      Category = 'File'
      Caption = 'Print Set&up...'
      Hint = 'Print Setup'
      Visible = False
      OnExecute = acFilePrintSetupExecute
      OnUpdate = acFilePrintSetupUpdate
    end
    object acGlobalOptimisticRecordlocks: TAction
      Category = 'GlobalOptions'
      Caption = 'Optimistic Recordlocks'
      Hint = 'Optimistic Recordlocks'
      ImageIndex = 45
      OnExecute = acGlobalOptimisticRecordlocksExecute
    end
    object acGlobalOptionsHeartbeatFrequency: TAction
      Category = 'GlobalOptions'
      Caption = 'Heartbeat Frequency'
      Hint = 'Heartbeat Frequency'
      ImageIndex = 18
      OnExecute = acGlobalOptionsHeartbeatFrequencyExecute
    end
    object acGlobalOptionsRecNoSupport: TAction
      Category = 'GlobalOptions'
      Caption = 'RecNo Support'
      Hint = 'RecNo Support'
      ImageIndex = 46
      OnExecute = acGlobalOptionsRecNoSupportExecute
    end
    object acEditCut: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Enabled = False
      Hint = 'Cut'
      ImageIndex = 1
      ShortCut = 16472
    end
    object acEditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      Hint = 'Copy'
      ImageIndex = 2
      ShortCut = 16451
    end
    object acEditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste'
      ImageIndex = 3
      ShortCut = 16470
      OnExecute = acEditPasteExecute
    end
    object acEditSelectAll: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All'
      ShortCut = 16449
    end
    object acEditUndo: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo'
      ImageIndex = 0
      ShortCut = 16474
    end
    object acQueryExecute: TAction
      Category = 'Query'
      Caption = '&Execute'
      Hint = 'Execute Active Query'
      ImageIndex = 6
      ShortCut = 16453
      OnExecute = acQueryExecuteExecute
    end
    object acQuerySave: TAction
      Category = 'Query'
      Caption = '&Save Script'
      Hint = 'Save Query Text'
      ImageIndex = 29
      ShortCut = 16467
      OnExecute = acQuerySaveExecute
    end
    object acQueryOpen: TAction
      Category = 'Query'
      Caption = '&Open Script'
      Hint = 'Load Query Text'
      ImageIndex = 30
      ShortCut = 16463
      OnExecute = acQueryOpenExecute
    end
    object acQueryParameterValues: TAction
      Category = 'Query'
      Caption = 'Para&meter Values'
      Hint = 'Set Parameter Values'
      ImageIndex = 32
      ShortCut = 16461
      OnExecute = acQueryParameterValuesExecute
    end
    object acQueryCopyToTable: TAction
      Category = 'Query'
      Caption = '&Copy To Table...'
      Hint = 'Copy To Table'
      ImageIndex = 27
      OnExecute = acQueryCopyToTableExecute
    end
    object acQueryPrintPreview: TAction
      Category = 'Query'
      Caption = 'P&rint Preview'
      Hint = 'Print Preview'
      ImageIndex = 33
      ShortCut = 16466
      OnExecute = acQueryPrintPreviewExecute
      OnUpdate = acQueryPrintPreviewUpdate
    end
    object acQueryDesignReport: TAction
      Category = 'Query'
      Caption = 'Design Repor&t'
      Hint = 'Design Report'
      ImageIndex = 34
      ShortCut = 16468
      OnExecute = acQueryDesignReportExecute
    end
    object acQueryViewShowBlobFields: TAction
      Category = 'QueryView'
      Caption = 'Show &Blob Fields'
      Hint = 'Show Blob Fields'
      ImageIndex = 36
      ShortCut = 16450
      OnExecute = acQueryViewShowBlobFieldsExecute
      OnUpdate = acQueryViewShowBlobFieldsUpdate
    end
    object acQueryViewRefresh: TAction
      Category = 'QueryView'
      Caption = 'Refresh'
      Hint = 'Refresh View'
      ImageIndex = 37
      ShortCut = 116
      OnExecute = acQueryViewRefreshExecute
    end
    object acQueryOptionsLiveDataset: TAction
      Category = 'QueryOptions'
      Caption = 'Request Live &Dataset'
      Hint = 'Request Live Dataset'
      ImageIndex = 20
      ShortCut = 16452
      OnExecute = acQueryOptionsLiveDatasetExecute
    end
    object acQueryOptionsProperties: TAction
      Category = 'QueryOptions'
      Caption = '&Properties'
      Hint = 'Query Properties'
      ImageIndex = 48
      ShortCut = 16464
      OnExecute = acQueryOptionsPropertiesExecute
    end
    object acQueryViewLog: TAction
      Category = 'QueryView'
      Caption = 'View Query Analysis'
      Hint = 'View Query Log'
      ImageIndex = 38
      ShortCut = 16460
      OnExecute = acQueryViewLogExecute
      OnUpdate = acQueryViewLogUpdate
    end
    object acQueryFind: TAction
      Category = 'Query'
      Caption = 'Find'
      Hint = 'Find text in SQL statement'
      ImageIndex = 35
      ShortCut = 16454
      OnExecute = acQueryFindExecute
    end
    object acQueryReplace: TAction
      Category = 'Query'
      Caption = 'Replace'
      Hint = 'Replace Text'
      ShortCut = 16456
      OnExecute = acQueryReplaceExecute
    end
    object acQueryNextStatement: TAction
      Category = 'Query'
      Caption = 'Show Next Statement'
      Hint = 'Show Next Statement'
      ImageIndex = 39
      ShortCut = 32807
      OnExecute = acQueryNextStatementExecute
      OnUpdate = acQueryNextStatementUpdate
    end
    object acQueryPrevStatement: TAction
      Category = 'Query'
      Caption = 'Show Previous Statement'
      Hint = 'Show Previous Statement'
      ImageIndex = 40
      ShortCut = 32805
      OnExecute = acQueryPrevStatementExecute
      OnUpdate = acQueryPrevStatementUpdate
    end
    object acServersRefresh: TAction
      Category = 'Servers'
      Caption = '&Refresh Server List'
      Hint = 'Refresh the list of servers'
      ImageIndex = 4
      OnExecute = acServersRefreshExecute
    end
    object acServersRegister: TAction
      Category = 'Servers'
      Caption = 'R&egister Servers...'
      Hint = 'Register servers by network address'
      ImageIndex = 5
      OnExecute = acServersRegisterExecute
    end
    object acServersSQL: TAction
      Category = 'Servers'
      Caption = 'New &SQL Query Window'
      Hint = 'Run SQL Queries'
      ImageIndex = 31
      ShortCut = 115
      OnExecute = acServersSQLExecute
      OnUpdate = acServersSQLUpdate
    end
    object acTableResetColumns: TAction
      Category = 'Table'
      Caption = '&Reset Columns'
      Hint = 'Reset Columns'
      OnExecute = acTableResetColumnsExecute
    end
    object acTableSetFieldtoNULL: TAction
      Category = 'Table'
      Caption = 'Set Field to NULL'
      Hint = 'Set Field to NULL'
      ImageIndex = 61
      ShortCut = 16432
      OnExecute = acTableSetFieldtoNULLExecute
    end
    object acTableNextTable: TAction
      Category = 'Table'
      Caption = '&Next Table'
      Hint = 'Next Table'
      ImageIndex = 39
      ShortCut = 16462
      OnExecute = acTableNextTableExecute
    end
    object acTableCopyToTable: TAction
      Category = 'Table'
      Caption = 'Copy To &Table...'
      Hint = 'Copy To Table'
      ImageIndex = 27
      OnExecute = acTableCopyToTableExecute
    end
    object acTableDeleteRecords: TAction
      Category = 'Table'
      Caption = 'Delete Records...'
      Hint = 'Delete Records'
      ImageIndex = 26
      OnExecute = acTableDeleteRecordsExecute
    end
    object acTablePrintPreview: TAction
      Category = 'Table'
      Caption = '&Print Preview...'
      Hint = 'Print Preview'
      ImageIndex = 33
      ShortCut = 16464
      OnExecute = acTablePrintPreviewExecute
    end
    object acTableDesignReport: TAction
      Category = 'Table'
      Caption = '&Design Report...'
      Hint = 'Design Report'
      ImageIndex = 34
      ShortCut = 16452
      OnExecute = acTableDesignReportExecute
    end
    object acTableViewShowFilter: TAction
      Category = 'TableView'
      Caption = 'Show &Filter'
      Checked = True
      Hint = 'Show Filter'
      ImageIndex = 41
      ShortCut = 16454
      OnExecute = acTableViewShowFilterExecute
      OnUpdate = acTableViewShowFilterUpdate
    end
    object acTableViewShowRange: TAction
      Category = 'TableView'
      Caption = 'Show &Range'
      Checked = True
      Hint = 'Show Range'
      ImageIndex = 43
      ShortCut = 16466
      OnExecute = acTableViewShowRangeExecute
      OnUpdate = acTableViewShowRangeUpdate
    end
    object acTableViewShowBLOBFields: TAction
      Category = 'TableView'
      Caption = 'Show &BLOB Fields'
      Hint = 'Show BLOB Fields'
      ImageIndex = 36
      ShortCut = 16450
      OnExecute = acTableViewShowBLOBFieldsExecute
      OnUpdate = acTableViewShowBLOBFieldsUpdate
    end
    object acTableViewShowRecordCount: TAction
      Category = 'TableView'
      Caption = 'Show Record Count'
      Hint = 'Show Record Count'
      ImageIndex = 25
      ShortCut = 16471
      OnExecute = acTableViewShowRecordCountExecute
      OnUpdate = acTableViewShowRecordCountUpdate
    end
    object acTableViewRefresh: TAction
      Category = 'TableView'
      Caption = 'Refresh'
      Hint = 'Refresh'
      ImageIndex = 37
      ShortCut = 116
      OnExecute = acTableViewRefreshExecute
    end
    object acTableOptionsDebugLog: TAction
      Category = 'TableOptions'
      Caption = '&Debug Log'
      Hint = 'Debug Log'
      ImageIndex = 44
      Visible = False
      OnExecute = acTableOptionsDebugLogExecute
    end
    object acTableOptionsTimeout: TAction
      Category = 'TableOptions'
      Caption = 'Set &Timeout'
      Hint = 'Set Timeout'
      ImageIndex = 7
      OnExecute = acTableOptionsTimeoutExecute
    end
    object acGlobalOptionsCloseActiveWindow: TAction
      Category = 'GlobalOptions'
      Caption = 'Close Active Window'
      Hint = 'Close Active Window'
      ImageIndex = 47
      ShortCut = 16499
      OnExecute = acGlobalOptionsCloseActiveWindowExecute
    end
    object acGlobalOptionsDisplayMilliseconds: TAction
      Category = 'GlobalOptions'
      Caption = 'Display Milliseconds'
      Hint = 'Display Milliseconds'
      ImageIndex = 59
      OnExecute = acGlobalOptionsDisplayMillisecondsExecute
    end
    object acGlobalOptionsUsePlainGrid: TAction
      Category = 'GlobalOptions'
      Caption = 'Use Plain Grid'
      Hint = 'Use Plain Grid'
      ImageIndex = 60
      OnExecute = acGlobalOptionsUsePlainGridExecute
    end
    object acQueryViewShowRecordCount: TAction
      Category = 'QueryView'
      Caption = 'Show Record Count'
      Hint = 'Show Record Count'
      ImageIndex = 25
      ShortCut = 16471
      OnExecute = acQueryViewShowRecordCountExecute
      OnUpdate = acQueryViewShowRecordCountUpdate
    end
    object acQueryToggleBookmark0: TAction
      Category = 'Query'
      Caption = 'Bookmark 0'
      ShortCut = 41008
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark1: TAction
      Tag = 1
      Category = 'Query'
      Caption = 'Bookmark 1'
      ShortCut = 41009
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark2: TAction
      Tag = 2
      Category = 'Query'
      Caption = 'Bookmark 2'
      ShortCut = 41010
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark3: TAction
      Tag = 3
      Category = 'Query'
      Caption = 'Bookmark 3'
      ShortCut = 41011
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark4: TAction
      Tag = 4
      Category = 'Query'
      Caption = 'Bookmark 4'
      ShortCut = 41012
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark5: TAction
      Tag = 5
      Category = 'Query'
      Caption = 'Bookmark 5'
      ShortCut = 41013
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark6: TAction
      Tag = 6
      Category = 'Query'
      Caption = 'Bookmark 6'
      ShortCut = 41014
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark7: TAction
      Tag = 7
      Category = 'Query'
      Caption = 'Bookmark 7'
      ShortCut = 41015
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark8: TAction
      Tag = 8
      Category = 'Query'
      Caption = 'Bookmark 8'
      ShortCut = 41016
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryToggleBookmark9: TAction
      Tag = 9
      Category = 'Query'
      Caption = 'Bookmark 9'
      ShortCut = 41017
      OnExecute = acQueryToggleBookmark0Execute
      OnUpdate = acQueryToggleBookmark0Update
    end
    object acQueryGotoBookmark0: TAction
      Category = 'Query'
      Caption = 'Bookmark 0'
      ShortCut = 24624
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark1: TAction
      Tag = 1
      Category = 'Query'
      Caption = 'Bookmark 1'
      ShortCut = 24625
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark2: TAction
      Tag = 2
      Category = 'Query'
      Caption = 'Bookmark 2'
      ShortCut = 24626
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark3: TAction
      Tag = 3
      Category = 'Query'
      Caption = 'Bookmark 3'
      ShortCut = 24627
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark4: TAction
      Tag = 4
      Category = 'Query'
      Caption = 'Bookmark 4'
      ShortCut = 24628
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark5: TAction
      Tag = 5
      Category = 'Query'
      Caption = 'Bookmark 5'
      ShortCut = 24629
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark6: TAction
      Tag = 6
      Category = 'Query'
      Caption = 'Bookmark 6'
      ShortCut = 24630
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark7: TAction
      Tag = 7
      Category = 'Query'
      Caption = 'Bookmark 7'
      ShortCut = 24631
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark8: TAction
      Tag = 8
      Category = 'Query'
      Caption = 'Bookmark 8'
      ShortCut = 24632
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryGotoBookmark9: TAction
      Tag = 9
      Category = 'Query'
      Caption = 'Bookmark 9'
      ShortCut = 24633
      OnExecute = acQueryGotoBookmark0Execute
      OnUpdate = acQueryGotoBookmark0Update
    end
    object acQueryClearBookmarks: TAction
      Category = 'Query'
      Caption = 'Clear Bookmarks'
      Hint = 'Clear Bookmarks'
      ShortCut = 49220
      OnExecute = acQueryClearBookmarksExecute
      OnUpdate = acQueryClearBookmarksUpdate
    end
    object acServersBroadcastForServers: TAction
      Category = 'Servers'
      Caption = 'Broadcast For Servers'
      Checked = True
      Hint = 'Broadcast For Servers'
      ImageIndex = 12
      OnExecute = acServersBroadcastForServersExecute
    end
    object acHelpOpenLogFolder: TAction
      Category = 'Help'
      Caption = 'Open Log Folder'
      Hint = 'Open Log Folder'
      OnExecute = acHelpOpenLogFolderExecute
    end
    object acQuerySqlHistoryOptions: TAction
      Category = 'Query'
      Caption = 'Sql History Options'
      Hint = 'Sql History Options'
      ImageIndex = 32
      OnExecute = acQuerySqlHistoryOptionsExecute
      OnUpdate = acQuerySqlHistoryOptionsUpdate
    end
    object acGlobalOptionsReloadLastSql: TAction
      Category = 'GlobalOptions'
      Caption = 'Reload Last Sql'
      Hint = 
        'Reloads last SQL saved for a particular Server/Database when new' +
        ' Query Browser is opened'
      OnExecute = acGlobalOptionsReloadLastSqlExecute
    end
    object acGlobalOptionsAllowCloseInactiveCalls: TAction
      Category = 'GlobalOptions'
      Caption = 'Allow "Close Inactive" Calls'
      Hint = 'Calls "CloseInactiveFolders/Tables" methods on table.Close'
      OnExecute = acGlobalOptionsAllowCloseInactiveCallsExecute
    end
    object acServersActivateServerList: TAction
      Category = 'Servers'
      Caption = 'Server List'
      Hint = 'Make Server List Active'
      ImageIndex = 62
      ShortCut = 123
      OnExecute = acServersActivateServerListExecute
    end
    object acTableViewUseGridMode: TAction
      Category = 'TableView'
      Caption = 'Use Grid Mode'
      Hint = 'Use Grid Mode'
      ImageIndex = 63
      ShortCut = 16455
      OnExecute = acTableViewUseGridModeExecute
      OnUpdate = acTableViewUseGridModeUpdate
    end
    object acQueryViewUseGridMode: TAction
      Category = 'QueryView'
      Caption = 'Use Grid Mode'
      Hint = 'Use Grid Mode'
      ImageIndex = 63
      ShortCut = 16455
      OnExecute = acQueryViewUseGridModeExecute
      OnUpdate = acQueryViewUseGridModeUpdate
    end
    object acGlobalOptionsUseLongTabDescription: TAction
      Category = 'GlobalOptions'
      Caption = 'Use Long Tab Descriptions'
      Hint = 'Use Long Tab Descriptions'
      OnExecute = acGlobalOptionsUseLongTabDescriptionExecute
    end
    object acGlobalOptionsNewTableDefaults: TAction
      Category = 'GlobalOptions'
      Caption = 'New Table Defaults...'
      OnExecute = acGlobalOptionsNewTableDefaultsExecute
    end
    object acGlobalOptionsAutoTreeRefresh: TAction
      Category = 'GlobalOptions'
      Caption = 'Auto Tree Refresh'
      Hint = 'Auto Tree Refresh'
      ImageIndex = 64
      OnExecute = acGlobalOptionsAutoTreeRefreshExecute
    end
    object acGlobalOptionsUseLargeToolbarGlyphs: TAction
      Category = 'GlobalOptions'
      Caption = 'Use Large Toolbar Glyphs'
      Hint = 'Use Large Toolbar Glyphs'
      OnExecute = acGlobalOptionsUseLargeToolbarGlyphsExecute
    end
    object acQueryFindNext: TAction
      Category = 'Query'
      Caption = 'Find &Next'
      Hint = 'Redo Last Find or Replace'
      ShortCut = 114
      OnExecute = acQueryFindNextExecute
    end
    object acQueryQueryBuilder: TAction
      Category = 'Query'
      Caption = 'Query Builder'
      ShortCut = 16465
      OnExecute = acQueryQueryBuilderExecute
      OnUpdate = acQueryQueryBuilderUpdate
    end
    object acUpdateNewUpdate: TAction
      Category = 'Update'
      Caption = 'New Update'
      OnExecute = acUpdateNewUpdateExecute
    end
    object acGlobalOptionsChooseFont: TAction
      Category = 'GlobalOptions'
      Caption = 'Choose Font...'
      OnExecute = acGlobalOptionsChooseFontExecute
    end
  end
  object dxDockingManager: TdxDockingManager
    Color = clBtnFace
    DefaultHorizContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultHorizContainerSiteProperties.Dockable = True
    DefaultHorizContainerSiteProperties.ImageIndex = -1
    DefaultVertContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultVertContainerSiteProperties.Dockable = True
    DefaultVertContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.CustomCaptionButtons.Buttons = <>
    DefaultTabContainerSiteProperties.Dockable = True
    DefaultTabContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.TabsProperties.CloseButtonMode = cbmEveryTab
    DefaultTabContainerSiteProperties.TabsProperties.CustomButtons.Buttons = <>
    DefaultTabContainerSiteProperties.TabsProperties.HotTrack = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Images = ImageList
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    Options = [doActivateAfterDocking, doDblClickDocking, doFloatingOnTop, doFreeOnClose, doTabContainerHasCaption, doTabContainerCanAutoHide, doSideContainerCanClose, doSideContainerCanAutoHide, doTabContainerCanInSideContainer]
    OnActiveDockControlChanged = dxDockingManagerActiveDockControlChanged
    OnCreateFloatSite = dxDockingManagerCreateFloatSite
    OnCreateLayoutSite = dxDockingManagerCreateLayoutSite
    OnCreateSideContainer = dxDockingManagerCreateSideContainer
    OnCreateTabContainer = dxDockingManagerCreateTabContainer
    Left = 240
    Top = 184
    PixelsPerInch = 96
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'File'
      'Edit'
      'Global Options'
      'Window'
      'Help'
      'Menus'
      'Query'
      'View'
      'Connection'
      'Query Options'
      'Servers'
      'Table'
      'View'
      'Table Options'
      'Menus')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True)
    ImageOptions.CacheGlyphs = False
    ImageOptions.Images = ImageList
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    MenusShowRecentItemsFirst = False
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    UseSystemFont = False
    Left = 360
    Top = 128
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      90
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Main Menu'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 825
      FloatTop = 556
      FloatClientWidth = 95
      FloatClientHeight = 210
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuFile'
        end
        item
          Visible = True
          ItemName = 'Edit1'
        end
        item
          Visible = True
          ItemName = 'mnuServer'
        end
        item
          Visible = True
          ItemName = 'mnuQuery'
        end
        item
          Visible = True
          ItemName = 'mnuQueryView'
        end
        item
          Visible = True
          ItemName = 'mnuQueryOptions'
        end
        item
          Visible = True
          ItemName = 'mnuTable'
        end
        item
          Visible = True
          ItemName = 'mnuTableView'
        end
        item
          Visible = True
          ItemName = 'mnuTableOptions'
        end
        item
          Visible = True
          ItemName = 'mnuOptions'
        end
        item
          Visible = True
          ItemName = 'mnuHelp'
        end>
      MultiLine = True
      OldName = 'Main Menu'
      OneOnRow = True
      Row = 0
      UseOwnFont = True
      Visible = True
      WholeRow = True
    end
    object dxBarManagerBar2: TdxBar
      Caption = 'Edit'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 404
      FloatTop = 341
      FloatClientWidth = 23
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuEditCut'
        end
        item
          Visible = True
          ItemName = 'mnuEditCopy'
        end
        item
          Visible = True
          ItemName = 'mnuEditPaste'
        end
        item
          Visible = True
          ItemName = 'mnuEditUndo'
        end>
      OldName = 'Edit'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar3: TdxBar
      Caption = 'Query'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 59
      DockingStyle = dsTop
      FloatLeft = 352
      FloatTop = 271
      FloatClientWidth = 192
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryExecute'
        end
        item
          Visible = True
          ItemName = 'mnuQuerySyntaxCheck'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryOpenScript'
        end
        item
          Visible = True
          ItemName = 'mnuQuerySaveScript'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'meQueryFind'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryParamValues'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryCopyToTable'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryPrintPreview'
        end
        item
          Visible = True
          ItemName = 'mnuQueryDesignReport'
        end>
      OldName = 'Query'
      OneOnRow = False
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar4: TdxBar
      Caption = 'Query View'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 281
      DockedTop = 59
      DockingStyle = dsTop
      FloatLeft = 400
      FloatTop = 271
      FloatClientWidth = 72
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryViewShowBLOBFields'
        end
        item
          Visible = True
          ItemName = 'mnuQueryViewShowRecordCount'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryViewUseGridMode'
        end
        item
          Visible = True
          ItemName = 'mnuQueryViewLog'
        end
        item
          Visible = True
          ItemName = 'mnuQueryViewRefresh'
        end>
      OldName = 'View'
      OneOnRow = False
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar5: TdxBar
      Caption = 'Connections'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 442
      DockedTop = 59
      DockingStyle = dsTop
      FloatLeft = 449
      FloatTop = 271
      FloatClientWidth = 96
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryConnectionPrev'
        end
        item
          Visible = True
          ItemName = 'mnuQueryConnectionNext'
        end
        item
          Visible = True
          ItemName = 'mnuQueryConnectionSqlHistoryOptions'
        end
        item
          Visible = True
          ItemName = 'dxbsServerName'
        end
        item
          Visible = True
          ItemName = 'dxbsDatabaseName'
        end
        item
          Visible = True
          ItemName = 'dxbsRunAt'
        end>
      OldName = 'Connections'
      OneOnRow = False
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar6: TdxBar
      Caption = 'Query Options'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 481
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 496
      FloatTop = 270
      FloatClientWidth = 48
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryOptionsLiveDataset'
        end
        item
          Visible = True
          ItemName = 'mnuQueryOptionsProperties'
        end>
      OldName = 'Query Options'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar7: TdxBar
      Caption = 'Table'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 646
      DockedTop = 59
      DockingStyle = dsTop
      FloatLeft = 323
      FloatTop = 310
      FloatClientWidth = 309
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableSetFieldtoNULL'
        end
        item
          Visible = True
          ItemName = 'mnuTableNextTable1'
        end
        item
          Visible = True
          ItemName = 'mnuTableCopyToTable'
        end
        item
          Visible = True
          ItemName = 'mnuTableDeleteRecords'
        end
        item
          Visible = True
          ItemName = 'mnuTablePrintPreview'
        end
        item
          Visible = True
          ItemName = 'mnuTableDesignReport'
        end>
      OldName = 'Table'
      OneOnRow = False
      Row = 2
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar8: TdxBar
      Caption = 'Table View'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 704
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 360
      FloatTop = 335
      FloatClientWidth = 103
      FloatClientHeight = 120
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableViewShowFilter'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowRange'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowBLOBFields'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowRecordCount'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewUseGridMode'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewRefresh'
        end>
      OldName = 'View'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar9: TdxBar
      Caption = 'Table Options'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 902
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 404
      FloatTop = 341
      FloatClientWidth = 24
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableOptionsTimeout'
        end>
      OldName = 'Table Options'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar10: TdxBar
      AllowCustomizing = False
      AllowQuickCustomizing = False
      Caption = 'Global Options'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 262
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 296
      FloatTop = 361
      FloatClientWidth = 114
      FloatClientHeight = 88
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsReadonlyDatasets'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsOptimisticRecordlocks'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsRecNoSupport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsDefaultTimeout'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsHeartbeatFrequency'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsAutoTreeRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsDisplayMilliseconds'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsUsePlainGrid'
        end>
      OldName = 'Global Options'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar11: TdxBar
      Caption = 'Help'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 131
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 662
      FloatTop = 344
      FloatClientWidth = 23
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuHelpContents'
        end
        item
          Visible = True
          ItemName = 'mnuHelpWebSite'
        end
        item
          Visible = True
          ItemName = 'mnuHelpNewsgroups'
        end
        item
          Visible = True
          ItemName = 'mnuHelpAbout'
        end>
      OldName = 'Help'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar12: TdxBar
      Caption = 'Servers'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 566
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 404
      FloatTop = 341
      FloatClientWidth = 23
      FloatClientHeight = 66
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuServersBroadcastForServers'
        end
        item
          Visible = True
          ItemName = 'mnuServerRefresh'
        end
        item
          Visible = True
          ItemName = 'mnuServerRegister'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'meServersSQL'
        end>
      OldName = 'Servers'
      OneOnRow = False
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object tbNewUpdate: TdxBar
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'New Update'
      CaptionButtons = <>
      Color = clGreen
      DockedDockingStyle = dsTop
      DockedLeft = 1012
      DockedTop = 27
      DockingStyle = dsTop
      FloatLeft = 1153
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Hidden = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewUpdate'
        end>
      OneOnRow = False
      Row = 1
      UseOwnFont = True
      Visible = True
      WholeRow = False
    end
    object mnuServers1: TdxBarSubItem
      Caption = '&Servers'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuServerRefresh'
        end
        item
          Visible = True
          ItemName = 'mnuServerRegister'
        end
        item
          Visible = True
          ItemName = 'meServersSQL'
        end>
    end
    object dxBarButton4: TdxBarButton
      Action = acGlobalOptionsReadonlyDatasets
      Category = 0
    end
    object mnuGlobalOptionsRecNoSupport: TdxBarButton
      Action = acGlobalOptionsRecNoSupport
      Category = 0
      ButtonStyle = bsChecked
    end
    object mnuServer: TdxBarSubItem
      Caption = '&Servers'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuServersBroadcastForServers'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuServersServerList'
        end>
    end
    object dxBarButton1: TdxBarButton
      Action = acServersRefresh
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = acServersRegister
      Category = 0
    end
    object meQueryReplace: TdxBarButton
      Action = acQueryReplace
      Category = 0
    end
    object dxBarSeparator1: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
    end
    object meGotoBookmarks: TdxBarSubItem
      Caption = 'Goto Bookmarks'
      Category = 0
      Hint = 'Goto Bookmarks'
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'meGotoBookmark1'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark2'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark3'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark4'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark5'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark6'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark7'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark8'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmark9'
        end>
    end
    object meGotoBookmark0: TdxBarButton
      Caption = 'Bookmark 0'
      Category = 0
      Visible = ivNever
      OnClick = acQueryGotoBookmark0Execute
    end
    object meGotoBookmark1: TdxBarButton
      Action = acQueryGotoBookmark1
      Category = 0
    end
    object meGotoBookmark2: TdxBarButton
      Action = acQueryGotoBookmark2
      Category = 0
    end
    object meGotoBookmark3: TdxBarButton
      Action = acQueryGotoBookmark3
      Category = 0
    end
    object meGotoBookmark4: TdxBarButton
      Action = acQueryGotoBookmark4
      Category = 0
    end
    object meGotoBookmark5: TdxBarButton
      Action = acQueryGotoBookmark5
      Category = 0
    end
    object meGotoBookmark6: TdxBarButton
      Action = acQueryGotoBookmark6
      Category = 0
    end
    object meGotoBookmark7: TdxBarButton
      Action = acQueryGotoBookmark7
      Category = 0
    end
    object meGotoBookmark8: TdxBarButton
      Action = acQueryGotoBookmark8
      Category = 0
    end
    object meGotoBookmark9: TdxBarButton
      Action = acQueryGotoBookmark9
      Category = 0
    end
    object meToggleBookmarks: TdxBarSubItem
      Caption = 'Toggle Bookmarks'
      Category = 0
      Hint = 'Toggle Bookmarks'
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'meToggleBookmark1'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark2'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark3'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark4'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark5'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark6'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark7'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark8'
        end
        item
          Visible = True
          ItemName = 'meToggleBookmark9'
        end>
    end
    object meToggleBookmark1: TdxBarButton
      Action = acQueryToggleBookmark1
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark2: TdxBarButton
      Action = acQueryToggleBookmark2
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark3: TdxBarButton
      Action = acQueryToggleBookmark3
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark4: TdxBarButton
      Action = acQueryToggleBookmark4
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark5: TdxBarButton
      Action = acQueryToggleBookmark5
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark6: TdxBarButton
      Action = acQueryToggleBookmark6
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark7: TdxBarButton
      Action = acQueryToggleBookmark7
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark8: TdxBarButton
      Action = acQueryToggleBookmark8
      Category = 0
      ButtonStyle = bsChecked
    end
    object meToggleBookmark9: TdxBarButton
      Action = acQueryToggleBookmark9
      Category = 0
      ButtonStyle = bsChecked
    end
    object meClearBookmarks: TdxBarButton
      Action = acQueryClearBookmarks
      Category = 0
    end
    object mnuServersBroadcastForServers: TdxBarButton
      Action = acServersBroadcastForServers
      Category = 0
      ButtonStyle = bsChecked
      LargeImageIndex = 12
    end
    object dxBarSeparator2: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
    end
    object mnuHelpOpenLogFolder: TdxBarButton
      Action = acHelpOpenLogFolder
      Category = 0
    end
    object mnuQueryConnectionSqlHistoryOptions: TdxBarButton
      Action = acQuerySqlHistoryOptions
      Category = 0
    end
    object mnuGlobalOptionsReloadLastSql: TdxBarButton
      Action = acGlobalOptionsReloadLastSql
      Category = 0
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsCloseInactiveFolders: TdxBarButton
      Action = acGlobalOptionsAllowCloseInactiveCalls
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxbsServerName: TdxBarStatic
      Caption = '<>'
      Category = 0
      Hint = '<>'
      Visible = ivAlways
      Left = 622
      Top = 348
    end
    object dxbsDatabaseName: TdxBarStatic
      Caption = '<>'
      Category = 0
      Hint = '<>'
      Visible = ivAlways
      Left = 590
      Top = 348
    end
    object dxbsRunAt: TdxBarStatic
      Caption = '<>'
      Category = 0
      Hint = '<>'
      Visible = ivAlways
      Left = 558
      Top = 348
    end
    object dxBarSeparator3: TdxBarSeparator
      Category = 0
      Visible = ivAlways
    end
    object mnuServersServerList: TdxBarButton
      Action = acServersActivateServerList
      Category = 0
    end
    object mnuGlobalOptionsUseLongTabDescription: TdxBarButton
      Action = acGlobalOptionsUseLongTabDescription
      Category = 0
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsNewTableDefaults: TdxBarButton
      Action = acGlobalOptionsNewTableDefaults
      Category = 0
    end
    object dxBarLargeButton1: TdxBarButton
      Action = acGlobalOptionsNewTableDefaults
      Category = 0
    end
    object dxBarLargeButton2: TdxBarButton
      Action = acGlobalOptionsUseLargeToolbarGlyphs
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarLargeButton3: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton3: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarSeparator4: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
    end
    object mnuQuerySyntaxCheck: TdxBarButton
      Action = acQuerySyntaxCheck
      Category = 0
    end
    object mnuQueryQueryBuilder: TdxBarButton
      Action = acQueryQueryBuilder
      Category = 0
    end
    object bbNewUpdate: TdxBarButton
      Action = acUpdateNewUpdate
      Category = 0
      Style = cxsUpdateStyle
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000F744558745469746C650052656D696E6465723B931C221700000290
        49444154785E7D934D685C5518869F73E7DEDECCBD765226249DBF26D1B425FD
        49A575136D02A9A864D5A41574A11B775D19E3A2AD9BAA34D46E9A9045282485
        B6140A2E5C982CB482888834A11A096A7E081284942815273399C9DC9F73EF31
        83C345C3D007BEEFF01DBEF781B338002CDF3D5F2D0001E8DF8CF69F5B981A78
        B430F18AFC61FCCCFC83ABA7DF020C40CC8F9DE1C7D13E00945200B0787BB036
        107B70FDD537D666DE57A5F5EF955FFC45FD3D7743ADDC39ABBEBCF2E2BB805E
        0DCD5DEF89041A40E087D4D09B6CE3E3E6E3AF114FA6C02B60DA162D9D9D3C63
        884B8001209D8028F0AF20BAD00854474CFE89DADE4B90FF1577631E82C708F4
        CC9BDD691BA8788E240A00F89E8CE6C09346505825282CE3FE364D79F10B82AD
        3F70B7CA7C3ABBE100F88EFF7F818C8C08E9F8844E1EE516084B8F09DD125108
        447D812B113B00BAE7FAD4C3AB4800BDBAE757763DA1F7A36F0510BF7FE1D495
        FD870F22AC16C230041143B39BF13D8BA6A4E2E660DB87803D787745FBAF4000
        D6BD77BA468E76ED1BEE78A9818603ED18C938662E8399B2918575DA0E051C6D
        8F0D8DF76747000BD0A8B53D77DE3E7635D5FEDC70E648234F23D31A23DB9A1B
        BAD1971AA9E622414217C3277B4C12CD8D6889E789D959B4D85F68C9161AD239
        84D180BB29B16C83174E1469D4D41060D604C8CD82F3F9DC67AB2C7D57E6C9AA
        47716D052505BAB91FA3F159A49921BF1963E9A7120FBF2A902FFB3380041035
        8975F974FAE5B4A50FC475D125946A3175DA9CA283525091E1EF41A89EEC9C3F
        6F6C07D3134B5B5F03DB4AA9801A02308038B0173830D69BABDC7ABD5D8DF664
        2B402B9000ACDA9E883E53B5ED2EC0FAA43B3D39D99753D7BA53538015EDEC2A
        9DFA381FCC6EBC075C043CC0A13EFC03958F2CEB2B785A640000000049454E44
        AE426082}
      PaintStyle = psCaptionGlyph
    end
    object dxSkinChooserGalleryItem: TdxSkinChooserGalleryItem
      Caption = 'Skin...'
      Category = 0
      Visible = ivAlways
      OnSkinChanged = dxSkinChooserGalleryItemSkinChanged
      ImageIndex = 65
      ItemLinks = <>
    end
    object dxBarSeparator5: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object dxBarButton5: TdxBarButton
      Action = acGlobalOptionsChooseFont
      Category = 0
    end
    object meQueryFindNext: TdxBarButton
      Action = acQueryFindNext
      Category = 0
    end
    object mnuFilePrintSetup: TdxBarButton
      Action = acFilePrintSetup
      Category = 1
    end
    object mnuFileExit: TdxBarButton
      Action = acFileExit
      Category = 1
    end
    object mnuQueryExecute: TdxBarButton
      Action = acQueryExecute
      Category = 1
    end
    object mnuQueryOpenScript: TdxBarButton
      Action = acQueryOpen
      Category = 1
    end
    object mnuQuerySaveScript: TdxBarButton
      Action = acQuerySave
      Category = 1
    end
    object meQueryFind: TdxBarButton
      Action = acQueryFind
      Category = 1
    end
    object mnuQueryParamValues: TdxBarButton
      Action = acQueryParameterValues
      Category = 1
    end
    object mnuQueryCopyToTable: TdxBarButton
      Action = acQueryCopyToTable
      Category = 1
    end
    object mnuQueryPrintPreview: TdxBarButton
      Action = acQueryPrintPreview
      Category = 1
    end
    object mnuQueryDesignReport: TdxBarButton
      Action = acQueryDesignReport
      Category = 1
    end
    object mnuServerRefresh: TdxBarButton
      Action = acServersRefresh
      Category = 1
    end
    object mnuServerRegister: TdxBarButton
      Action = acServersRegister
      Category = 1
    end
    object meServersSQL: TdxBarButton
      Action = acServersSQL
      Category = 1
    end
    object mnuTableResetCol: TdxBarButton
      Action = acTableResetColumns
      Category = 1
    end
    object mnuTableSetFieldtoNULL: TdxBarButton
      Action = acTableSetFieldtoNULL
      Category = 1
    end
    object mnuTableNextTable1: TdxBarButton
      Action = acTableNextTable
      Category = 1
    end
    object mnuTableCopyToTable: TdxBarButton
      Action = acTableCopyToTable
      Category = 1
    end
    object mnuTableDeleteRecords: TdxBarButton
      Action = acTableDeleteRecords
      Category = 1
    end
    object mnuTablePrintPreview: TdxBarButton
      Action = acTablePrintPreview
      Category = 1
    end
    object mnuTableDesignReport: TdxBarButton
      Action = acTableDesignReport
      Category = 1
    end
    object mnuEditUndo: TdxBarButton
      Action = acEditUndo
      Category = 2
    end
    object mnuEditCut: TdxBarButton
      Action = acEditCut
      Category = 2
    end
    object mnuEditCopy: TdxBarButton
      Action = acEditCopy
      Category = 2
    end
    object mnuEditPaste: TdxBarButton
      Action = acEditPaste
      Category = 2
    end
    object mnuEditSelectAll: TdxBarButton
      Action = acEditSelectAll
      Category = 2
    end
    object mnuQueryViewShowBLOBFields: TdxBarButton
      Action = acQueryViewShowBlobFields
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuQueryViewLog: TdxBarButton
      Action = acQueryViewLog
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuQueryViewRefresh: TdxBarButton
      Action = acQueryViewRefresh
      Category = 2
    end
    object mnuTableViewShowFilter: TdxBarButton
      Action = acTableViewShowFilter
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuTableViewShowRange: TdxBarButton
      Action = acTableViewShowRange
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuTableViewShowBLOBFields: TdxBarButton
      Action = acTableViewShowBLOBFields
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuTableViewShowRecordCount: TdxBarButton
      Action = acTableViewShowRecordCount
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuTableViewRefresh: TdxBarButton
      Action = acTableViewRefresh
      Category = 2
    end
    object mnuQueryViewShowRecordCount: TdxBarButton
      Action = acQueryViewShowRecordCount
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuQueryViewUseGridMode: TdxBarButton
      Action = acQueryViewUseGridMode
      Category = 2
    end
    object mnuTableViewUseGridMode: TdxBarButton
      Action = acTableViewUseGridMode
      Category = 2
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsAutoTreeRefresh: TdxBarButton
      Action = acGlobalOptionsAutoTreeRefresh
      Category = 3
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsReadonlyDatasets: TdxBarButton
      Action = acGlobalOptionsReadonlyDatasets
      Category = 3
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsDefaultTimeout: TdxBarButton
      Action = acGlobalOptionsDefaultTimeout
      Category = 3
    end
    object mnuGlobalOptionsOptimisticRecordlocks: TdxBarButton
      Action = acGlobalOptimisticRecordlocks
      Category = 3
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsHeartbeatFrequency: TdxBarButton
      Action = acGlobalOptionsHeartbeatFrequency
      Category = 3
    end
    object mnuQueryConnectionNew: TdxBarButton
      Caption = '&New'
      Category = 3
      Hint = 'Create New Database Connection'
      Visible = ivAlways
      LargeImageIndex = 5
      ShortCut = 16462
    end
    object mnuQueryConnectionRemove: TdxBarButton
      Caption = '&Remove'
      Category = 3
      Hint = 'Remove Database Connection'
      Visible = ivAlways
      LargeImageIndex = 21
      ShortCut = 16459
    end
    object mnuQueryConnectionNext: TdxBarButton
      Action = acQueryNextStatement
      Category = 3
    end
    object mnuQueryConnectionPrev: TdxBarButton
      Action = acQueryPrevStatement
      Category = 3
    end
    object mnuTableOptionsDebugLog: TdxBarButton
      Action = acTableOptionsDebugLog
      Caption = 'Transport &Debug Log'
      Category = 3
    end
    object mnuTableOptionsTimeout: TdxBarButton
      Action = acTableOptionsTimeout
      Category = 3
    end
    object mnuGlobalOptionsRuntimeLoadedPackages: TdxBarButton
      Caption = 'Runtime Loaded Packages'
      Category = 3
      Hint = 'Runtime Loaded Packages'
      Visible = ivAlways
      LargeImageIndex = 32
      OnClick = mnuGlobalOptionsRuntimeLoadedPackagesClick
    end
    object mnuGlobalOptionsDisplayMilliseconds: TdxBarButton
      Action = acGlobalOptionsDisplayMilliseconds
      Category = 3
      ButtonStyle = bsChecked
    end
    object mnuGlobalOptionsUsePlainGrid: TdxBarButton
      Action = acGlobalOptionsUsePlainGrid
      Category = 3
      ButtonStyle = bsChecked
    end
    object mnuQueryOptionsLiveDataset: TdxBarButton
      Action = acQueryOptionsLiveDataset
      Category = 4
      ButtonStyle = bsChecked
    end
    object mnuQueryOptionsProperties: TdxBarButton
      Action = acQueryOptionsProperties
      Category = 4
    end
    object mnuOptionsDebugLog: TdxBarButton
      Caption = 'Debug &Log'
      Category = 4
      Visible = ivAlways
    end
    object mnuTable: TdxBarSubItem
      Caption = '&Table'
      Category = 4
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableResetCol'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableSetFieldtoNULL'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableNextTable1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableCopyToTable'
        end
        item
          Visible = True
          ItemName = 'mnuTableDeleteRecords'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTablePrintPreview'
        end
        item
          Visible = True
          ItemName = 'mnuTableDesignReport'
        end>
    end
    object mnuTableView: TdxBarSubItem
      Caption = 'Table &View'
      Category = 4
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableViewShowFilter'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowRange'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowBLOBFields'
        end
        item
          Visible = True
          ItemName = 'mnuTableViewShowRecordCount'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableViewUseGridMode'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableViewRefresh'
        end>
    end
    object mnuTableOptions: TdxBarSubItem
      Caption = 'Table &Options'
      Category = 4
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuTableOptionsTimeout'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableOptionsDebugLog'
        end>
    end
    object mnuHelpContents: TdxBarButton
      Action = acHelpContents
      Category = 5
    end
    object mnuHelpWebSite: TdxBarButton
      Action = acHelpNexusDBWebSite
      Category = 5
    end
    object mnuHelpNewsgroups: TdxBarButton
      Action = acHelpNexusDBNewsgroups
      Category = 5
    end
    object mnuHelpAbout: TdxBarButton
      Action = acHelpAbout
      Category = 5
    end
    object mnuQuery: TdxBarSubItem
      Caption = '&Query'
      Category = 5
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryExecute'
        end
        item
          Visible = True
          ItemName = 'mnuQuerySyntaxCheck'
        end
        item
          Visible = True
          ItemName = 'mnuQueryOpenScript'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuTableSetFieldtoNULL'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryConnectionPrev'
        end
        item
          Visible = True
          ItemName = 'mnuQueryConnectionNext'
        end
        item
          Visible = True
          ItemName = 'mnuQueryConnectionSqlHistoryOptions'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'meQueryFind'
        end
        item
          Visible = True
          ItemName = 'meQueryReplace'
        end
        item
          Visible = True
          ItemName = 'meQueryFindNext'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'meToggleBookmarks'
        end
        item
          Visible = True
          ItemName = 'meGotoBookmarks'
        end
        item
          Visible = True
          ItemName = 'meClearBookmarks'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryParamValues'
        end
        item
          Visible = True
          ItemName = 'mnuQueryQueryBuilder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryCopyToTable'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryPrintPreview'
        end
        item
          Visible = True
          ItemName = 'mnuQueryDesignReport'
        end>
    end
    object mnuQueryView: TdxBarSubItem
      Caption = 'Query &View'
      Category = 5
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryViewShowBLOBFields'
        end
        item
          Visible = True
          ItemName = 'mnuQueryViewShowRecordCount'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryViewUseGridMode'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryViewLog'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryViewRefresh'
        end>
    end
    object mnuQueryConnection: TdxBarSubItem
      Caption = 'Query &Connection'
      Category = 5
      Visible = ivAlways
      ItemLinks = <>
    end
    object mnuQueryOptions: TdxBarSubItem
      Caption = 'Query &Options'
      Category = 5
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuQueryOptionsLiveDataset'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuQueryOptionsProperties'
        end>
    end
    object mnuFile: TdxBarSubItem
      Caption = '&File'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuFilePrintSetup'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuFileExit'
        end>
    end
    object Edit1: TdxBarSubItem
      Caption = '&Edit'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuEditUndo'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuEditCut'
        end
        item
          Visible = True
          ItemName = 'mnuEditCopy'
        end
        item
          Visible = True
          ItemName = 'mnuEditPaste'
        end
        item
          Visible = True
          ItemName = 'mnuEditSelectAll'
        end>
    end
    object mnuOptions: TdxBarSubItem
      Caption = '&Global Options'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsReadonlyDatasets'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsOptimisticRecordlocks'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsRecNoSupport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsDefaultTimeout'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsHeartbeatFrequency'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsCloseInactiveFolders'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsAutoTreeRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsDisplayMilliseconds'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsUsePlainGrid'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsReloadLastSql'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsUseLongTabDescription'
        end
        item
          Visible = True
          ItemName = 'mnuGlobalOptionsNewTableDefaults'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuGlobalOptionsRuntimeLoadedPackages'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator5'
        end
        item
          Visible = True
          ItemName = 'dxSkinChooserGalleryItem'
        end>
    end
    object mnuWindow: TdxBarSubItem
      Caption = '&Window'
      Category = 6
      Visible = ivAlways
      ItemLinks = <>
    end
    object mnuHelp: TdxBarSubItem
      Caption = '&Help'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'mnuHelpContents'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuHelpWebSite'
        end
        item
          Visible = True
          ItemName = 'mnuHelpNewsgroups'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuHelpOpenLogFolder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'mnuHelpAbout'
        end>
    end
  end
  object cxLookAndFeelController: TcxLookAndFeelController
    Kind = lfOffice11
    NativeStyle = False
    ScrollbarMode = sbmClassic
    SkinName = 'DevExpressStyle'
    Left = 360
    Top = 184
  end
  object tiStartup: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tiStartupTimer
    Left = 72
    Top = 283
  end
  object pmTabContainerList: TPopupMenu
    Left = 240
    Top = 251
  end
  object ApplicationEvents1: TApplicationEvents
    OnDeactivate = ApplicationEvents1Deactivate
    OnIdle = ApplicationEvents1Idle
    Left = 360
    Top = 251
  end
  object tiCloseLostComm: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tiCloseLostCommTimer
    Left = 72
    Top = 339
  end
  object tiActivateQueryEdit: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tiActivateQueryEditTimer
    Left = 72
    Top = 387
  end
  object NotificationCenter1: TNotificationCenter
    OnReceiveLocalNotification = NotificationCenter1ReceiveLocalNotification
    Left = 636
    Top = 128
  end
  object tiUpdateCheck: TTimer
    Interval = 1
    OnTimer = tiUpdateCheckTimer
    Left = 72
    Top = 435
  end
  object dxSkinController: TdxSkinController
    Kind = lfOffice11
    NativeStyle = False
    ScrollbarMode = sbmClassic
    SkinName = 'DevExpressStyle'
    Left = 560
    Top = 248
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 512
    Top = 128
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 240
    Top = 320
    PixelsPerInch = 96
    object cxsUpdateStyle: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 13470494
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      TextColor = clRed
    end
  end
  object ImageList: TcxImageList
    SourceDPI = 96
    DrawingStyle = dsSelected
    FormatVersion = 1
    DesignInfo = 20185446
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000105040F082F20840C4832CC0F5A3EFF0F5A3EFF0C46
          30C6072C1F7E0106041200000000000000000000000000000000000000000000
          000000000000051B134811543BE4217654FF2A8760FF309168FF309168FF2A86
          60FF217754FF12583EF0061C134B000000000000000000000000000000000000
          000009261B63277556FF2D8662FF37956EFF37956EFF37956EFF37956EFF3795
          6EFF37956EFF2E8662FF176245FC071E154E000000000000000000000000040D
          0A211B6648F939916CFF409B75FF409B75FF74B79BFFA2CEBCFFA2CEBCFF74B7
          9BFF3E9A74FF3E9A74FF348C68FF1A6246F0020705120000000000000000133F
          2E936EA68FFFAFD6C6FFAFD6C6FFAFD6C6FF69A28BFF2E775AFF2E775AFF69A2
          8BFF79BAA0FF459F7BFF459F7BFF3C8A6BFF1138298400000000000000002265
          4AE1267354FF267354FF267354FF267354FF1B533CB7040B0818040B08181B53
          3CB769A58DFF4DA583FF4DA583FF489D7CFF1F5D44CF00000000000000000000
          000000000000000000000000000000000000000000000000000000000000050D
          091B398365FF56AA8AFF56AA8AFF59AB8CFF2A7657F900000000000000000000
          0000000000000000000000000000000000000204030920523DA500000000050C
          09183A8666FF5FB092FF5FB092FF6FB79CFF2F7B5BF600000000000000000000
          000000000000000000000000000008130E242D6E52D2489373FF0C1C15362964
          4BC04F9E7FFF67B69AFF67B69AFF80BDA6FF2D6C50CF00000000000000000000
          00000000000000000000122B204E388362F059A688FF5CA98CFF479574FF5CA9
          8CFF70BBA1FF70BBA1FF81C3ACFF82B9A2FF204A378700000000000000000000
          000001020103224B388454A181FF68B398FF78C1A9FF78C1A9FF78C1A9FF78C1
          A9FF78C1A9FF86C8B2FF93C9B5FF3F8E6AF908110D1E00000000000000000102
          010331684FB17DB89FFFA1D3C3FF85C8B3FF7FC6B0FF7FC6B0FF7FC6B0FF85C9
          B4FFA0D5C4FFB1D8CAFF78B59CFF1B3A2C630000000000000000000000000000
          00000B1812273E8061D283BDA4FFC2E3D9FF9ED5C5FFACDCCDFFC9E8DFFFC2E3
          D9FF92C6B1FF499773F91F403169000000000000000000000000000000000000
          0000000000000204030629533F844E9E79FCA3D1BFFF87C1A8FF53A37EFF4995
          71ED30624B9C0B17112400000000000000000000000000000000000000000000
          000000000000000000000000000015291F3F488F6EDE57A782FF030604090000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000408060C3668509F000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000030C
          0921104A33C6145E41FC0F4832C004140E360000000000000000000000000000
          000004140E360F4832C0145E41FC104A33C6030C09210000000000000000104A
          33C60B3223870104030C04150F39114F37D50516103C00000000000000000516
          103C114F37D504150F390104030C0B322387104A33C60000000000000000145F
          42FF01070512000000000000000004150F39104B34C90000000000000000104B
          34C904150F39000000000000000001070512145F42FF00000000000000001152
          39DB04150F39000000000000000001070512145F42FF0000000000000000145F
          42FF01070512000000000000000004150F39115239DB00000000000000000827
          1B69115239DB04120C300104030C0B32238714573DEB0F0F0F3600000000195C
          42EC224B3BB20104030C04120C30115239DB08271B6900000000000000000000
          0000092C1E75145E41FC145F42FF155E41FB394E46FF434343F03B3B3B71889D
          95FB176044FF145F42FF145E41FC092C1E750000000000000000000000000000
          0000000000000104030C04130D33161D1A5F464646FC575757FFCECECEFF7B7B
          7BFF6A716EFA1C2B26680104030C000000000000000000000000000000000000
          0000000000000000000000000000000000002929297BCECECEFF2A2A2AFF7575
          75FF2D2D2D680000000000000000000000000000000000000000000000000000
          00000000000000000000000000000707070FB0B0B0E9A9A9A9FF757575FF5D5D
          5DFF383838C90303030900000000000000000000000000000000000000000000
          00000000000000000000000000007E7E7EC0C7C7C7FF767676FF5A5A5ADC4747
          47FF474747FF2C2C2C9F00000000000000000000000000000000000000000000
          0000000000000000000036363662D9D9D9FF7F7F7FFF575757BD0404040C3535
          35BD474747FF474747FF1515154B000000000000000000000000000000000000
          0000000000000707070DC8C8C8F5979797FF606060D20707070F000000000404
          040F3A3A3AD2474747FF3D3D3DDB020202060000000000000000000000000000
          0000000000006C6C6C9EB5B5B5FF696969E40C0C0C1B00000000000000000000
          00000808081B3F3F3FE4474747FF202020720000000000000000000000000000
          00000A0A0A10C6C6C6F8717171F01515152D0000000000000000000000000000
          0000000000000D0D0D2D434343F0404040E70303030900000000000000000000
          00007D7D7DA7848484FA1E1E1E42000000000000000000000000000000000000
          0000000000000000000012121242454545F92020207200000000000000000000
          0000898989DB2929295A00000000000000000000000000000000000000000000
          00000000000000000000000000001919195A383838C900000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000004A221585853E
          26EE894028F6894028F6894028F6894028F6894028F6894028F6894028F68940
          28F6853E26EE4A22158500000000000000000000000000000000884129EEFBF6
          F3FFFDF9F5FFFDF8F5FFFCF7F4FFFCF7F3FFFCF6F2FFFBF6F1FFFBF5F1FFFBF5
          F0FFF9F2ECFF884129EE0000000000000000000000000000000092492FF8FDF9
          F6FFFBEDE0FFFAEBDEFFFAE8DAFFF9E6D6FFF7E3D3FFF6E0CFFFF5DECBFFF3DB
          C6FFFBF3EEFF92492FF800000000000000000000000000000000954D32F7FDF9
          F5FFFAEBDEFFFAE7D9FFF9E5D5FFF7E2D1FFF6DFCDFFF5DDC9FFF3DAC4FFF2D7
          C2FFFBF3EDFF9A5034FFFFFFFFFF894028F6853E26EE4A2215859A5336F7FDF8
          F5FFFAE8DAFFF9E5D5FFF7E2D1FFF6DFCDFFF5DDC9FFF3DAC4FFF2D6C0FFF1D6
          BDFFFAF2ECFFA25B3EFFFBF5F1FFFBF5F0FFF9F2ECFF884129EE9E593AF7FDF7
          F4FFF9E6D6FFF7E2D1FFF6DFCDFFF5DDC9FFF3DAC4FFF2D6C0FFF1D4BBFFF1D2
          BAFFFAF1EBFFA66041FFF5DECBFFF3DBC6FFFBF3EEFF92492FF8A45F3FF7FCF7
          F3FFF7E3D3FFF6DFCDFFF5DDC9FFF3DAC4FFF2D6C0FFF1D4BBFFF0D0B7FFF0CF
          B5FFFAF1EAFFAB6645FFF3DAC4FFF2D7C2FFFBF3EDFF954D32F7A86543F7FCF7
          F2FFF6E0CFFFF5DDC9FFF3DAC4FFF2D6C0FFF1D4BBFFF0D0B7FFEFCDB2FFEECC
          AFFFFAF1E9FFAE6946FFF2D6C0FFF1D6BDFFFAF2ECFF9A5336F7AC6B47F7FCF6
          F1FFF5DECBFFF3DAC4FFF2D6C0FFF1D4BBFFF1D4BDFFF9EBE0FFD29D79FFD5A5
          85FFD19F7EFFBA7B57FFF1D4BBFFF1D2BAFFFAF1EBFF9E593AF7B06F4BF7FCF5
          F0FFF3DBC6FFF2D6C0FFF1D4BBFFF0D0B7FFF1D3BCFFF8EADFFFC07F56FFC07F
          56FFBB7C57FFD5A788FFF0D0B7FFF0CFB5FFFAF1EAFFA45F3FF7B5754FF8FBF5
          EFFFF2D7C2FFF1D5BDFFF0D1B9FFEFCEB4FFF0D1B7FFFBF2EAFFC07F56FFBF80
          5BFFDBB091FFF0D0B7FFEFCDB2FFEECCAFFFFAF1E9FFAB6744FCB47650F2FBF3
          EDFFFBF4EDFFFBF3EDFFFBF2ECFFFBF2EBFFFAF1E9FFF5E7DEFFC2835CFFE0B6
          98FFF1D4BDFFF9EBE0FFD29D79FFD5A585FFD19F7EFF9C6140E067442E89B679
          52F2BC7D54FABC7D54FAC07F56FFC18159FFC18158FFCD9571FFE1B899FFF0D0
          B7FFF1D3BCFFF8EADFFFC07F56FFC07F56FFBB7C57FF55362477000000000000
          00000000000000000000FFFFFFFFFBF5EFFFF2D7C2FFF1D5BDFFF0D1B9FFEFCE
          B4FFF0D1B7FFFBF2EAFFC07F56FFBF805BFF492F206400000000000000000000
          00000000000000000000B47650F2FBF3EDFFFBF4EDFFFBF3EDFFFBF2ECFFFBF2
          EBFFFAF1E9FFF5E7DEFFC2835CFF412A1D570000000000000000000000000000
          0000000000000000000067442E89B67952F2BC7D54FABC7D54FABC7D54FABC7D
          54FABC7D54FA8F5F40BE402A1D55000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000542719968F432AFF8F432AFF8F43
          2AFF8F432AFF8F432AFF8F432AFF8F432AFF8F432AFF542719960B244496133D
          73FF133D73FF133D73FF133D73FF133D73FF93482DFFF1EDE5FFF0ECE3FFEFEB
          E1FFEFE9DFFFEEE7DCFFEEE5D9FFECE3D6FFECE0D3FF93482DFF154076FF78A3
          C8FF78A3C8FF78A3C8FF78A3C8FF78A3C8FF984E32FFF0ECE3FFE5DDCDFFE4DB
          C9FFE3D7C5FFE2D4C0FFE0D1BBFFDFCCB6FFEBDFCFFF984E32FF17447AFF7AA6
          CBFF4181B5FF4181B5FF4181B5FF4181B5FF9D5437FFEFEBE1FFE4DBC9FFE3D7
          C5FFE2D4BFFFE0D1BAFFDFCCB5FFDDC9B0FFE9DCCBFF9D5437FF1A497EFF7CAA
          CEFF4586BAFF4485B9FF4485B9FF4485B9FFA35B3CFFEFE9DFFFE3D7C5FFE2D4
          BFFFE0D1BAFFDFCCB5FFDDC9AFFFDBC5AAFFE9DAC8FFA35B3CFF1E4E83FF7FAE
          D2FF498CBFFF488BBEFF488BBEFF488BBEFFA96341FFEEE7DCFFE2D4C0FFE0D1
          BAFFDFCCB5FFDDC9AFFFDBC5A9FFDAC1A4FFE8D8C5FFA96341FF215388FF83B2
          D6FF4E92C4FF4D91C4FF4D91C4FF4D91C4FFAF6A46FFEEE5D9FFE0D1BBFFDFCC
          B5FFDDC9AFFFDBC5A9FFDAC1A3FFD9BF9FFFE7D6C2FFAF6A46FF25598DFF86B6
          DAFF5298CAFF5197CAFF5197CAFF5197CAFFB4704BFFECE3D6FFDFCCB6FFDDC9
          AFFFDBC5A9FFDAC1A3FFD9BE9EFFE7D6C2FFE6D4BFFFB4704BFF285F91FF89BB
          DEFF579FD0FF569ED0FF569ED0FF569ED0FFB97650FFECE0D3FFDDC9B0FFDBC5
          AAFFDAC1A4FFD9BF9FFFE7D6C2FFF4DDCAFFB97650FF6D452F962B6496FF8DBF
          E2FF5CA5D5FF5BA4D5FF5BA4D5FF5BA4D5FFBD7B53FFF8E7DAFFF7E5D6FFF7E3
          D3FFF5E0D0FFF4DFCCFFF4DDCAFFBD7B53FF6F483196000000002F699BFF8FC4
          E5FF60ABDAFF5FAADAFF5FAADAFF5FAADAFF98918CFFC07F56FFC07F56FFC07F
          56FFC07F56FFC07F56FFC07F56FF714B33960000000000000000326E9FFF92C7
          E9FF64B0DFFF63AFDFFF63AFDFFF63AFDFFF63AFDFFF63AFDFFF63AFDFFF64B0
          DFFF92C7E9FF326E9FFF000000000000000000000000000000003472A3FF94CB
          EBFF67B5E3FF7091A3FF777777FF777777FF777777FF777777FF7091A3FF67B5
          E3FF94CBEBFF3472A3FF000000000000000000000000000000003675A6FFD0E8
          F7FFD0E8F7FF878787FFF4F4F4FFE9E9E9FFE9E9E9FFF4F4F4FF878787FFD0E8
          F7FFD0E8F7FF3675A6FF00000000000000000000000000000000214763963878
          A8FF3878A8FF6F8A9DFF969696FFFBFBFBFFFBFBFBFF969696FF6F8A9DFF3878
          A8FF3878A8FF2147639600000000000000000000000000000000000000000000
          000000000000000000005F5F5F96A1A1A1FFA1A1A1FF5F5F5F96000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000010103062C1E81000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010705150B422EBA135F43FF0104030C0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000416103C11553CE4227856FF217654FF146145FF1258
          3EED0C3B2A9F030D092400000000000000000000000000000000000000000000
          0000000000000B2F2178186346FC499375FF38966FFF38966FFF38966FFF3692
          6CFF2A805DFF186346FC0A2A1E6C000000000000000000000000000000000000
          0000000000000A2319541C6649F677AC97FF74B69BFF6CB296FF99CAB6FF70B4
          98FF439D78FF3A936FFF338263FF0B291E630000000000000000000000000000
          0000000000000000000007181136206549E76EA68FFF6CA790FF3E8267FF73A9
          94FF84BFA8FF4DA482FF419775FF216A4DF3040C091B00000000000000002975
          56F62B7959FF2B7959FF2B7959FF0B1E1640216147D242896CFF081610301743
          3190629F86FF7BBBA2FF51A786FF489576FF153E2E870000000000000000307C
          5CF96FB79CFF5FB092FF3F8A6BFF08150F2A0206040C1F533DAB010101030000
          00001943318A72AC94FF5BAE8FFF55A587FF25654ACF00000000000000002D6E
          52D281BEA7FF67B69AFF53A183FF1F4B38900000000000000000275F47B70306
          050C08140F27499072FFBCDED2FFB7DBCEFF327D5EF60000000000000000204A
          378782B9A2FF81C3ACFF6FBAA0FF529F80FF224E3B900B1A14304C9777FF3172
          56D20F221A403A8866FF3A8866FF3A8866FF398564F900000000000000000811
          0D1E3E8A68F393C8B5FF87C8B2FF77C0A8FF60AC8FFF4B9A78FF62AE91FF5EAA
          8DFF3B8363E70E1F173600000000000000000000000000000000000000000000
          00001A382B6077B49AFFB0D7C9FFA0D5C4FF86C9B4FF7FC6B0FF7FC6B0FF7FC6
          B0FF7ABBA3FF44916EF617312654000000000000000000000000000000000000
          0000000000001E3E2F66499773F992C6B1FFC0E3D7FFCAE8DFFFADDCCDFFA9DA
          CBFF9ECDBBFF4A9975FC23493878000000000000000000000000000000000000
          000000000000000000000B1711242F604999489370EA52A27CFF86C0A7FF8EC5
          ADFF478F6DE413261D3C00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000204030656A680FF3D78
          5CBA070E0A150000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002A53407E0000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000001616164B3A3A3AC44C4C4CFF4C4C4CFF4C4C4CFF4C4C
          4CFF4C4C4CFF4C4C4CFF4C4C4CFF4C4C4CFF2D2D2D9600000000000000000000
          0000000000002F2F2F97555555FF9C9C9CFF868686FFAEAEAEFFAEAEAEFFAEAE
          AEFFAEAEAEFFAEAEAEFFAEAEAEFFAEAEAEFF505050FF00000000000000000000
          00003D3D3DB96A6A6AFFB5B5B5FFC4C4C4FF6F6F6FFFAEAEAEFFAEAEAEFFAEAE
          AEFFFFFFFFFFAEAEAEFFFFFFFFFFAEAEAEFF545454FF00000000000000004444
          44C28A8A8AFFC1C1C1FFC4C4C4FFC4C4C4FF727272FFAEAEAEFFC6C6C6FFC6C6
          C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FF585858FF00000000000000005F5F
          5FFFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF777777FFAEAEAEFF909090FF9090
          90FF909090FF909090FF909090FF909090FF5E5E5EFF00000000000000006464
          64FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF7B7B7BFFAEAEAEFFC6C6C6FFC6C6
          C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FF636363FF00000000000000006B6B
          6BFFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF808080FFAEAEAEFF909090FF9090
          90FF909090FF909090FF909090FF909090FF6A6A6AFF00000000000000007272
          72FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF858585FFAEAEAEFFC6C6C6FFC6C6
          C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FF707070FF00000000000000007979
          79FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF898989FFAEAEAEFF909090FF9090
          90FF909090FF909090FF909090FF909090FF777777FF00000000000000008080
          80FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF8E8E8EFFAEAEAEFFC6C6C6FFC6C6
          C6FFC6C6C6FFC6C6C6FFC6C6C6FFC6C6C6FF7D7D7DFF00000000000000008787
          87FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF939393FFAEAEAEFF909090FF9090
          90FF909090FF909090FF909090FF909090FF848484FF00000000000000008D8D
          8DFFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FF989898FFAEAEAEFFAEAEAEFFAEAE
          AEFFAEAEAEFFAEAEAEFFAEAEAEFFAEAEAEFF8A8A8AFF00000000000000009393
          93FFC4C4C4FFC4C4C4FFC0C0C0FFADADADFFE4E4E4FFE7E7E7FFE7E7E7FFE7E7
          E7FFE7E7E7FFE7E7E7FFE7E7E7FFE7E7E7FF909090FF00000000000000009898
          98FFBFBFBFFFAEAEAEFFB2B2B2FFD8D8D8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8
          E8FFE8E8E8FFE5E5E5FFCBCBCBFFA8A8A8FF5858589600000000000000009B9B
          9BFFB6B6B6FFDADADAFFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFDADA
          DAFFBCBCBCFF9E9E9EFF5B5B5B961D1D1D300000000000000000000000005D5D
          5D969E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF8080
          80CF414141690707070C00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000D0D0D1E3B3B3B875F5F5FDB6F6F6FFF6F6F6FFF6161
          61DE3D3D3D8D1010102400000000000000000000000000000000000000000000
          0000000000003D3D3D8A7E7E7EFFB8B8B8FFE4E4E4FFF7F7F7FFF7F7F7FFE6E6
          E6FFBBBBBBFF818181FF3E3E3E8D000000000000000000000000000000000000
          000044444496A2A2A2FFF1F1F1FFF7F7F7FFD9D9D9FFCDCDCDFFCDCDCDFFD8D8
          D8FFF5F5F5FFF2F2F2FFA7A7A7FF444444960000000000000000000000004040
          408AA5A5A5FFF8F8F8FFE3E3E3FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCF
          CFFFCFCFCFFFE0E0E0FFF8F8F8FFA9A9A9FF43434390000000000D0D0D1B8888
          88FFF2F2F2FFE5E5E5FFD3D3D3FFD3D3D3FFD3D3D3FFEFEFEFFFD3D3D3FFD3D3
          D3FFD3D3D3FFD3D3D3FFE3E3E3FFF5F5F5FF888888FF1414142A42424284BEBE
          BEFFF8F8F8FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FF757575FFEFEFEFFFD7D7
          D7FFD7D7D7FFD7D7D7FFD7D7D7FFF8F8F8FFC5C5C5FF494949936A6A6ACFE4E4
          E4FFE8E8E8FFDCDCDCFFDCDCDCFFDCDCDCFFDCDCDCFF757575FF757575FFEFEF
          EFFFDCDCDCFFDCDCDCFFDCDCDCFFE5E5E5FFE9E9E9FF717171DB818181F3F5F5
          F5FFE3E3E3FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FF757575FF757575FF7575
          75FFEFEFEFFFE0E0E0FFE0E0E0FFE2E2E2FFF7F7F7FF848484F9888888F9F8F8
          F8FFE7E7E7FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FF757575FF757575FF7575
          75FFC3C3C3FFE5E5E5FFE5E5E5FFE7E7E7FFF8F8F8FF888888F9747474CFE7E7
          E7FFF1F1F1FFE9E9E9FFE9E9E9FFE9E9E9FFE9E9E9FF757575FF757575FFC3C3
          C3FFE9E9E9FFE9E9E9FFE9E9E9FFF0F0F0FFEAEAEAFF777777D54C4C4C84C9C9
          C9FFFCFCFCFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFF757575FFC3C3C3FFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFFCFCFCFFC9C9C9FF4C4C4C841010101B9D9D
          9DFFF6F6F6FFF8F8F8FFF1F1F1FFF1F1F1FFF1F1F1FFC3C3C3FFF1F1F1FFF1F1
          F1FFF1F1F1FFF1F1F1FFF7F7F7FFF8F8F8FFA1A1A1FF1010101B000000004F4F
          4F84B8B8B8FFFDFDFDFFFAFAFAFFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5
          F5FFF5F5F5FFF9F9F9FFFEFEFEFFBBBBBBFF5353538A00000000000000000000
          00005A5A5A93B8B8B8FFF8F8F8FFFEFEFEFFFCFCFCFFFAFAFAFFF9F9F9FFFCFC
          FCFFFEFEFEFFF9F9F9FFBCBCBCFF5C5C5C960000000000000000000000000000
          00000000000054545487A6A6A6FFCCCCCCFFE0E0E0FFF3F3F3FFF4F4F4FFE1E1
          E1FFCECECEFFA7A7A7FF5656568A000000000000000000000000000000000000
          000000000000000000000B0B0B124C4C4C786E6E6EAE8E8E8EE1909090E47070
          70B15050507E0D0D0D1500000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000010A071E062E20870A4B34DB0C573CFF0C573CFF0A4C
          34DE0730218D020C082400000000000000000000000000000000000000000000
          000000000000082E2081146043FF3A8567FF7CB49DFFA4CEBCFFA4CEBCFF81B7
          A1FF3E886AFF146244FF082E2081000000000000000000000000000000000000
          00000A2E207B237454FF88BDA7FF679F89FF2E7459FF146043FF146043FF2A71
          56FF629B85FF8BBFAAFF257756FF092C1F750000000000000000000000000D34
          2584277859FF88BEA8FF33785EFF7DA898FFD6E4DFFFFFFFFFFFFFFFFFFFDCE7
          E3FF85AD9EFF2D7459FF89BDA9FF297A5AFF0D34258400000000030B081B2873
          55FF68AF93FF387E62FF93B8A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF98BBADFF337A5EFF6EB296FF277355FF05120D2A133B2B844391
          71FF69A68EFF7FAC9AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEA
          EAFFFFFFFFFFFFFFFFFF8CB4A4FF66A38AFF439273FF15423093236147CF51A1
          82FF4A8E72FFCDDFD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBCBCBCFF5F5F
          5FFFF9F9F9FFFFFFFFFFDAE7E2FF43896CFF51A383FF25674CDB2F795AF35FAF
          91FF3C8667FFEEF4F2FFFFFFFFFFFFFFFFFFFFFFFFFFBCBCBCFF5D5D5DFFE4E4
          E4FFFFFFFFFFFFFFFFFFFAFCFBFF348161FF60B092FF307C5CF9368362F976BE
          A4FF408D6CFFEFF5F2FFFFFFFFFFFFFFFFFFFFFFFFFFC8C8C8FF5B5B5BFFD7D7
          D7FFFFFFFFFFFFFFFFFFFAFCFBFF3A8866FF75BDA2FF368362F9327255CF88C2
          ADFF529C7DFFCFE3DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8C8C8FF5B5B
          5BFFD7D7D7FFFFFFFFFFDDEBE5FF4D9878FF8AC4AFFF337558D5234C398484BC
          A5FF6AB398FF8ABCA5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8C8
          C8FF5B5B5BFFF2F2F2FF99C5B1FF64AE92FF83BCA4FF234C398408100C1B529F
          7BFFACD8C9FF58A483FFA3CBB9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFEAEAEAFFA5CDBAFF55A280FFABD8CAFF57A17FFF08100C1B000000002750
          3D8175B599FFB1DCCEFF63AE8EFF8CC0A8FFC3DED1FFE6F1ECFFE8F2EEFFC5DF
          D3FF93C4ADFF60AC8CFFADDBCBFF79B89CFF28523F8400000000000000000000
          000029523F8176B89AFFC4E6DBFF90CAB5FF6EB698FF5CAA87FF5BA986FF6DB5
          97FF8CC8B1FFC4E6DCFF7CBB9FFF29513E7E0000000000000000000000000000
          0000000000002E5844875FAC87FF90C8B0FFABD7C6FFC3E5DAFFC5E6DBFFACD8
          C7FF93CAB2FF60AD88FF2F5A458A000000000000000000000000000000000000
          00000000000000000000060C09122A503E783D7459AE4F9674E1509875E43E76
          5BB12C54417E070E0B1500000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000A0A549611118FFF0A0A54960000000000000000000000000000
          00000A0A549611118FFF0A0A5496000000000000000000000000000000000000
          000000000000111190FF4D61D0FF2A32AAFF0A0A559600000000000000000A0A
          53932830A9FF4D61D0FF111190FF000000000000000000000000000000000000
          000000000000101293FF4E64D1FF4E64D1FF262FA9FF090A5593090A5390252E
          A8FF4D63D0FF4E64D1FF101293FF000000000000000000000000000000000000
          000000000000101295FF5068D4FF324ECCFF4F67D3FF242DA9FF242CA8FF4E66
          D3FF334ECCFF5068D4FF101295FF000000000000000000000000000000000000
          000000000000101398FF536BD7FF1B3CC9FF3955D0FF5169D6FF5169D6FF3956
          D1FF1B3CC9FF536BD7FF101398FF000000000000000000000000000000000000
          0000000000000F139BFF5670DAFF1F41CDFF1D40CDFF2144CEFF2144CEFF1D40
          CDFF1F41CDFF5670DAFF0F139BFF000000000000000000000000000000000000
          0000000000000F139EFF5975DCFF2348D0FF2147D0FF2147D0FF2147D0FF2147
          D0FF2348D0FF5975DCFF0F139EFF000000000000000000000000000000000000
          0000000000000F14A1FF5C7ADFFF274ED4FF254DD4FF254DD4FF254DD4FF254D
          D4FF274ED4FF5C7ADFFF0F14A1FF000000000000000000000000000000000000
          0000000000000E14A5FF5E7FE3FF2A55D9FF2854D9FF2854D9FF2854D9FF2854
          D9FF2A55D9FF5E7FE3FF0E14A5FF000000000000000000000000000000000000
          0000000000000E15A8FF6183E6FF2E5BDDFF2C5ADDFF2C5ADDFF2C5ADDFF2C5A
          DDFF2E5BDDFF6183E6FF0E15A8FF000000000000000000000000000000000000
          0000000000000E15ABFF6489E8FF3262E0FF3061E0FF3061E0FF3061E0FF3061
          E0FF3262E0FF6489E8FF0E15ABFF000000000000000000000000000000000000
          0000000000000D15AEFF678DEBFF3668E4FF3467E4FF3467E4FF3467E4FF3467
          E4FF3668E4FF678DEBFF0D15AEFF000000000000000000000000000000000000
          0000000000000D16B1FF7C9FF0FF396DE8FF376CE8FF376CE8FF376CE8FF376C
          E8FF396DE8FF7DA0F0FF0D16B1FF000000000000000000000000000000000000
          0000000000000D16B3FF98B5F5FF779DF1FF779DF1FF779DF1FF779DF1FF779D
          F1FF799EF1FF98B5F5FF0D16B3FF000000000000000000000000000000000000
          000000000000070E6B965F75DCFF99B7F6FF99B7F6FF99B7F6FF99B7F6FF99B7
          F6FF99B7F6FF5A6FD9FF070E6B96000000000000000000000000000000000000
          0000000000000204202D070E6C960C17B7FF0C17B7FF0C17B7FF0C17B7FF0C17
          B7FF0C17B7FF070E6C9602031A24000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000202028E0D0D
          0DFF0D0D0DFF0D0D0DFF0D0D0DFF0D0D0DFF535252FF8B593AFF90664AFF5252
          52FF0D0D0DFF0D0D0DFF0D0D0DFF0D0D0DFF0D0D0DFF0202028E090909F22D2D
          2DFF2B2B2BFF2B2B2BFF2B2B2BFF2B2B2BFF161616FF946D54FF9B7A64FF1414
          14FF2B2B2BFF2B2B2BFF2B2B2BFF2B2B2BFF2D2D2DFF090909F20F0F0FD83737
          37FF323232FF323232FF323232FF323232FF1F1F1FFFA38673FFAD9585FF1C1C
          1CFF323232FF323232FF323232FF323232FF373737FF101010DE0F0F0F943B3B
          3BFB444444FF3B3B3BFF3A3A3AFF3F3F3FFF272727FFB8A69BFFC3B4AAFF2424
          24FF3F3F3FFF3A3A3AFF3B3B3BFF444444FF3D3D3DFB1010109D060606302121
          21F23F3F3FFB525252FF484848FF515151FF888888FFAC8B75FFB59986FF8D8D
          8DFF505050FF484848FF525252FF3F3F3FFB222222F307070739000000000505
          0522151515892E2E2EF64B4B4BFD474748FFFBFBFCFFA59288FFAA9E98FFFBFC
          FCFF474747FF4B4B4BFD2E2E2EF6151515890505052200000000000000000000
          0000000000000B0B0B411C1C1CA57C7C7CFF74B8DBFFBCDFFAFFBCDFFAFF7CBD
          DEFF7C7C7CFF1C1C1CA50B0B0B41000000000000000000000000000000000000
          000000000000000000000000000000070B0F036495C9047FBDFF047FBDFF0364
          95C900090D120000000000000000000000000000000000000000000000000000
          0000000000000000000000000000024B6F9651A3D4FF97C4E8FF97C4E8FF53A4
          D4FF024B6F960000000000000000000000000000000000000000000000000000
          00000000000000000000023A57754BA1D2FFABCFEFFF90BFEAFF8FBFEAFFABCF
          EFFF4CA2D2FF02344E6900000000000000000000000000000000000000000000
          00000000000000000000036FA5DE99C8EAFF98C5EDFF8BBEEBFF8BBEEBFF98C5
          EDFF92C4E8FF03699CD200000000000000000000000000000000000000000000
          00000000000000000000292939FFA0ACBCFFB2D5F3FF91C3EEFF91C3EEFFB2D5
          F3FF8F9CACFF1D1D2DFF00000000000000000000000000000000000000000000
          00000000000000000000313747F6304155FF93ADC6FF97C9F2FF94C5EDFF8DA6
          BEFF232F44FF1F2437F400000000000000000000000000000000000000000000
          000000000000000000002D2D36AD464653FF454552FF41414FFF3E3E4BFF3838
          46FF30303FFF1B1B25A500000000000000000000000000000000000000000000
          0000000000000000000010101233515462FA555561FF51515EFF4C4C59FF4545
          52FF3A3E4CFA09090B2D00000000000000000000000000000000000000000000
          000000000000000000000000000018181B444D4D57CD61616CFF5B5B67FF3F3F
          49C91111143F0000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00005A25138E993F21F2993F21F2993F21F2993F21F25A25138E000000000000
          00000000000000000000000000000000000000000000000000005C29178E9E46
          27F29E4627F2C67435FFC67435FFC67435FFC67435FFA64F30FBA34C2CF75C29
          178E000000000000000000000000000000000000000000000000A2512FF2CE82
          45FFAB5A37FBCE8245FFCE8245FFCE8245FFCE8245FFAB5A37FBCE8245FFAB5A
          37FB646464640000000000000000000000000000000000000000A75A37F2D691
          56FFB06340FBD69156FFD69156FFD69156FFD69156FFB06340FBD69156FFB063
          40FBAAAAAAAA0000000000000000000000000000000000000000AD643FF2EFCF
          B3FFDE9F66FFDE9F66FFDE9F66FFDE9F66FFDE9F66FFDE9F66FFEFCFB3FFB66E
          49FFB0C9BFFF115D40FF115D40FF0A3726960000000000000000683F288EB975
          4DFBF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFBA774FFFBFA3
          86FFBDDCCFFF38966FFF38966FFF1C694BFF1C694BFF103E2C9600000000956F
          56BABC7B52FB4F7D91FD047FBDFF047FBDFF63A4C3FFD9B39BFFBEA286FFC5E2
          D7FF95C9B6FF51A786FF51A786FF2A7757FF51A786FF2A7757FF000000000000
          00002B7498BF047FBDFF50D2F1FF50D2F1FF047FBDFF65B1D4FFD8E8E1FFA6D4
          C4FF6CB99EFF6CB99EFF6CB99EFF388765FF6CB99EFF388765FF000000000000
          0000047FBDFF74DBF3FF74DBF3FF74DBF3FF74DBF3FF047FBDFFDBEFE9FF85CA
          B5FF85CAB5FF85CAB5FF85CAB5FF85CAB5FFCAE8DFFF469571FF000000000000
          0000047FBDFF99E5F5FF99E5F5FF99E5F5FF99E5F5FF047FBDFFF2FAF8FFD2ED
          E6FFD2EDE6FFD2EDE6FFD2EDE6FFD2EDE6FF51A17CFF305F4996000000000000
          0000024B6F96047FBDFFB2EBF6FFB2EBF6FF047FBDFF53A0C3F29ECDB6FF2791
          A5FF047FBDFF047FBDFF2791A5FF59AA83FF34644D9600000000000000000000
          000000000000024B6F96047FBDFF047FBDFF4C94B9E069696969024B6F96047F
          BDFF50D2F1FF50D2F1FF047FBDFF024B6F960000000000000000000000000000
          0000000000000000000000000000000000000000000000000000047FBDFF74DB
          F3FF74DBF3FF74DBF3FF74DBF3FF047FBDFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000047FBDFF99E5
          F5FF99E5F5FF99E5F5FF99E5F5FF047FBDFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000024B6F96047F
          BDFFB2EBF6FFB2EBF6FF047FBDFF024B6F960000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000024B
          6F96047FBDFF047FBDFF024B6F96000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000F06031C431B0E806D2B16D07F321AF27F321AF26F2C
          16D3461C0E861207042200000000000000000000000000000000000000000000
          000000000000461D0F83873A1EF3A35122F9B86127FDC06929FFC06929FFB862
          28FDA45223F98A3B1EF4481D0F86000000000000000000000000000000000000
          00004E21128E9B4C24F7BF6B2CFEC26D2DFFC26D2DFFC26D2DFFC26D2DFFC26D
          2DFFC26D2DFFC06B2DFF9D4D24F74E21128E0000000000000000000000004A21
          12839E502AF7C47132FFC47132FFC47132FFC47132FFFFFFFFFFFFFFFFFFC471
          32FFC47132FFC47132FFC47132FFA05129F74D221389000000000F07041A944A
          2CF3C47437FEC77638FFC77638FFC77638FFC77638FFFFFFFFFFFFFFFFFFC776
          38FFC77638FFC77638FFC77638FFC67538FF944A2BF3170B06284B24157DB168
          3EF9CA7B3EFFCA7B3EFFCA7B3EFFCA7B3EFFCA7B3EFFB36E1FFFB36E1FFFCA7B
          3EFFCA7B3EFFCA7B3EFFCA7B3EFFCA7B3EFFB4693EF95329188C783D24C4C37A
          42FDCD8144FFCD8144FFCD8144FFCD8144FFCD8144FFFFFFFFFFFFFFFFFFCD81
          44FFCD8144FFCD8144FFCD8144FFCD8144FFC57A42FD7F4126D0914D2EE7CE85
          4CFED0874BFFD0874BFFD0874BFFD0874BFFD0874BFFFFFFFFFFFFFFFFFFD087
          4BFFD0874BFFD0874BFFD0874BFFD0874BFFD0874CFF944F2FEC995333ECD797
          61FFD48D52FFD48D52FFD48D52FFD48D52FFD48D52FFD48D52FFFFFFFFFFFFFF
          FFFFD48D52FFD48D52FFD48D52FFD48D52FFD7955FFF995333EC824A2DC4D59E
          73FDD79358FFD79358FFD79358FFD79358FFD79358FFD79358FFD79358FFFFFF
          FFFFFFFFFFFFD79358FFD79358FFD79358FFD6A075FD864C2FCA55321F7DC995
          74F9DB9C64FFDA985EFFDA985EFFFFFFFFFFDA985EFFDA985EFFDA985EFFFFFF
          FFFFFFFFFFFFDA985EFFDA985EFFDB9A62FFC99473F955321F7D120B071AAD6C
          47F3E4B893FEDD9E65FFDD9D64FFBC7F32FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFBC7F32FFDD9D64FFDD9D64FFE5B892FEAF6F4AF3120B071A000000005936
          227DC08865F6EAC29EFFE0A46EFFDFA169FFBD8134FFBD8134FFBD8134FFBD81
          34FFDFA169FFE0A36DFFEAC19CFFC28C69F65D39248300000000000000000000
          0000653F288CC18965F6EBC9AAFEE9BD94FFE6B384FFE3AA76FFE3AA75FFE6B3
          83FFE9BC92FFECC9ABFEC48E6AF6663F298E0000000000000000000000000000
          0000000000005E3B2680B6764FF3CF9F7CF8DCB495FBE9C8ABFDEAC9ACFEDDB5
          96FBD1A07FF8B77750F3603C2783000000000000000000000000000000000000
          000000000000000000000D080511543622727A4E32A59F6541D6A06641D87D4F
          33A8593824780F09061400000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000031A
          114E0634249F02120C3600000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000006291C751B6B
          4BFF1E7853FF0F5A3EFF03150E3C000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000176346FF85BA
          A4FF3B9770FF257F5AFF156144FF0517103C0C382796146043FF146043FF0C38
          2796030C092100000000000000000000000000000000000000000C3022752E76
          5AFF8DC1ABFF469E79FF2F8763FF1C694BFF287C5AFF3A9871FF3A9871FF2C82
          5FFF103D2C960000000000000000000000000000000000000000000000001137
          287B367E61FF95C5B3FF4FA583FF409775FF48A17EFF48A17EFF48A17EFF77B9
          9FFF4F9076FF0A38279900000000000000000000000000000000000000000000
          0000153B2B7B398465FF54A888FF57AB8BFF57AB8BFF57AB8BFF82C0A9FF5D99
          82FF0E593EFF186D4BFF0837269F03130D360000000000000000000000000000
          0000204E3A964A9879FF66B599FF66B599FF66B599FF8DC8B3FF659F88FF145F
          43FF25805AFF2E9066FF247D58FF0C3B299F0000000000000000000000000000
          00003E8D6AFF75BFA6FF75BFA6FF75BFA6FF98CFBDFF6BA68EFF1B674AFF2E86
          62FF38966FFF38966FFF3A9770FF196548FF0000000000000000000000000000
          0000479672FF98D1C0FF83C8B3FFA3D6C6FF73AD95FF236F51FF388E6CFF449E
          7AFF449E7AFF449E7AFF7FBCA4FF216C4EFC0000000000000000000000000102
          0103509F7AFFA6D3C2FFB7E1D5FF79B49CFF2B7858FF449776FF51A786FF51A7
          86FF51A786FF5BAC8DFF619F86FF184432930000000000000000000000000000
          0000182F244857A781FF80BDA3FF338160FF50A081FF5FB092FF5FB092FF5FB0
          92FF6EB79CFF5BAB8DFF378464FF1537296F0000000000000000000000000000
          000000000000020403062B5D46A071AD94FF8CC8B3FF6CB99EFF6CB99EFF9BD0
          BDFFA7D1C1FF84C4AEFF64B295FF3F8D6CFF193B2C6F00000000000000000000
          0000000000000000000000000000295A449F93C5B1FFC5E5DAFFC5E5DAFF7AB6
          9CFF469471FF9ECCBBFF8FCCB8FF70BBA1FF489674FF1B3C2D69000000000000
          00000000000000000000000000000F2019362E5F489F499974FF499974FF2B5A
          4496162F234E4E9C78FFA4D1C0FF9AD3C2FFA0D2C1FF4C9B77FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000001831254E54A37EFFA8D4C3FF79B99DFF21423269000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000182F24483B7358B11C372A5400000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000505
          2B4E0B0B589F04041E3600000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000008084275151D
          9FFF1020ADFF111291FF0404223C0A0A5596111190FF111190FF0A0A55960202
          1321000000000000000000000000000000000000000000000000131596FF6C7A
          D4FF203BC5FF1225B2FF101395FF111EA7FF1330C2FF1330C2FF1222ADFF090B
          5796010105090000000000000000000000000000000000000000070946752025
          A2FF7182D8FF2140CAFF1731BEFF1939C8FF1939C8FF1939C8FF304DCEFF444D
          B9FF070844720000000000000000000000000000000000000000000000000709
          4C7B1A20A6FF1E41CCFF1F44CFFF1F44CFFF1F44CFFF3657D4FF7080D7FF181D
          A3FF01010B12000000000000000000000000000000000000000000000000090C
          6096192DB8FF2751D6FF2751D6FF2751D6FF3D63DAFF7386DBFF181EA8FF0608
          3F63000000000000020307073A69000000000000000000000000000000000E15
          A8FF2E5DDEFF2E5DDEFF2E5DDEFF436EE1FF768BDFFF1820ADFF050841630000
          000004042542111291FF101BA3FF0B0B5A9F04041E3600000000000000000D15
          AEFF537FE9FF3468E5FF4977E8FF788FE4FF1720B3FF05084463000000000405
          2642101394FF1125B3FF122FC2FF1124B0FF0A0B5C9F00000000000002030F18
          B3FF7086E1FF6A94F0FF7B94E7FF1721B7FF0509456300000000040527421114
          98FF152BB7FF1737C7FF1737C7FF1939C7FF101297FF00000000000000000306
          33480F1BB8FF586CD8FF1623BBFF05094763000000000405284210159DFF1831
          BDFF1D40CDFF1D40CDFF1D40CDFF5C75DAFF0F139AFC00000000000000000000
          00000102141B060C60840102141B0000000004052A421016A2FF1C39C3FF234B
          D3FF234BD3FF234BD3FF2D53D5FF4350BFFF090C5D9300000000000000000000
          0000000000000000000000000000000004061017A7FF2140C9FF2A56DAFF2A56
          DAFF2A56DAFF3C64DDFF2750D5FF121BAAFF0609486F00000000000000000000
          0000000000000000000000000000060946694755C7FF577FE6FF3061E0FF3061
          E0FF6A8EE9FF7E94E4FF4D77E4FF2B55D8FF131DAFFF06094669000000000000
          000000000000000000000000000000000000080E6D9F6679D9FF9BB5F3FF9BB5
          F3FF4B5BCDFF121CB1FF7086DFFF5581EAFF6784E3FF101AB1FF000000000000
          00000000000000000000000000000000000003052636080E709F0D16B3FF0D16
          B3FF080D69960407374E121CB5FF7187E1FF3C4CC9FF05094A69000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000306334808107EB104083C5400000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000161616363F3F3F9C525252CC525252CC5F5F5FEA676767FF676767FF5F5F
          5FEA525252CC525252CC4040409F171717390000000000000000000000003F3F
          3F967C7C7CFF8E8E8EFF9B9B9BFFA1A1A1FFB2B2B2FFC1C1C1FFCECECEFFDBDB
          DBFFDADADAFFE1E1E1FFC1C1C1FF898989FF3F3F3F9600000000000000007070
          70FFAFAFAFFF9A9A9AFFA1A1A1FFABABABFFB6B6B6FFC1C1C1FFCECECEFFE4E4
          E4FFF6F6F6FFFFFFFFFFF4F4F4FFECECECFF707070FF00000000000000007676
          76FFAFAFAFFF9A9A9AFFA1A1A1FFABABABFFB6B6B6FFC1C1C1FFCECECEFFE4E4
          E4FFF6F6F6FFFFFFFFFFF4F4F4FFECECECFF767676FF00000000000000007D7D
          7DFFA1A1A1FF7F7F7FFF787878FF7A7A7AFF747474FF6E6E6EFF6E6E6EFF7878
          78FF898989FF8B8B8BFFA0A0A0FFD0D0D0FF7D7D7DFF00000000000000008080
          80FF8A8A8AFF959595FF9F9F9FFFA5A5A5FFB3B3B3FFC1C1C1FFCECECEFFDCDC
          DCFFDEDEDEFFE5E5E5FFC8C8C8FF969696FF808080FF00000000000000008E8E
          8EFFAFAFAFFF9A9A9AFFA1A1A1FFABABABFFB6B6B6FFC1C1C1FFCECECEFFE4E4
          E4FFF6F6F6FFFFFFFFFFF4F4F4FFECECECFF8E8E8EFF0000000000000000A0A0
          A0FFC3C3C3FFB3B3B3FFB9B9B9FFC0C0C0FFC8C8C8FFD1D1D1FFDADADAFFEBEB
          EBFFF8F8F8FFFFFFFFFFF7F7F7FFF0F0F0FFA0A0A0FF0000000000000000AFAF
          AFFFD1D1D1FF9D9D9DFF868686FF878787FF787878FF6E6E6EFF6E6E6EFF7979
          79FF8B8B8BFF8B8B8BFFA3A3A3FFDBDBDBFFAFAFAFFF00000000000000009292
          92FF8A8A8AFF959595FF9F9F9FFFA5A5A5FFB3B3B3FFC1C1C1FFCECECEFFDCDC
          DCFFDEDEDEFFE5E5E5FFC8C8C8FF969696FF929292FF00000000000000008E8E
          8EFFAFAFAFFF9A9A9AFFA1A1A1FFABABABFFB6B6B6FFC1C1C1FFCECECEFFE4E4
          E4FFF6F6F6FFFFFFFFFFF4F4F4FFECECECFF8E8E8EFF0000000000000000A0A0
          A0FFC3C3C3FFB3B3B3FFB9B9B9FFC0C0C0FFC8C8C8FFD1D1D1FFDADADAFFEBEB
          EBFFF8F8F8FFFFFFFFFFF7F7F7FFF0F0F0FFA0A0A0FF0000000000000000AFAF
          AFFFD2D2D2FFA1A1A1FF8C8C8CFF8C8C8CFF7F7F7FFF757575FF757575FF8080
          80FF909090FF919191FFA8A8A8FFDCDCDCFFAFAFAFFF0000000000000000AFAF
          AFFFA6A6A6FFD3D3D3FFE8E8E8FFE8E8E8FFF6F6F6FFFFFFFFFFFFFFFFFFF6F6
          F6FFE8E8E8FFE8E8E8FFD4D4D4FFA7A7A7FFAFAFAFFF00000000000000008282
          82BBC7C7C7FFE1E1E1FFEEEEEEFFEEEEEEFFF4F4F4FFFFFFFFFFFFFFFFFFF5F5
          F5FFEEEEEEFFEEEEEEFFE1E1E1FFC7C7C7FF828282BB00000000000000000000
          00004141415A7A7A7AA8949494CC949494CCA1A1A1DEB9B9B9FFB9B9B9FFA3A3
          A3E1949494CC949494CC7A7A7AA84141415A0000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001111
          11273E3E3E90484848A81B1B1B3F000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002F2F2F6C7878
          78FFD1D1D1FF9C9C9CFF7D7D7DFF3D3D3D8A0303030600000000000000000000
          000000000000000000000000000000000000000000004141418D989898FFE9E9
          E9FFEFEFEFFF919191FF949494FF9B9B9BFF4545459600000000000000000000
          00000000000000000000000000000000000048484896BEBEBEFFF0F0F0FFF1F1
          F1FFEFEFEFFF919191FF919191FF919191FF7A7A7AFF00000000000000000000
          000000000000111111273E3E3E90484848A8808080FFF1F1F1FFF1F1F1FFF1F1
          F1FFEFEFEFFF919191FF919191FF919191FF808080FF00000000000000000000
          00002F2F2F6C787878FFD1D1D1FF9C9C9CFF878787FFF1F1F1FFF1F1F1FFEEEE
          EEFFD6D6D6FFC0C0C0FF9B9B9BFF919191FF878787FF00000000000000004141
          418D989898FFE9E9E9FFEFEFEFFF919191FF8D8D8DFFDDDDDDFFA1A1A1FF8F8F
          8FFFB8B8B8FFD0D0D0FFD0D0D0FFB7B7B7FF868686F30000000048484896BEBE
          BEFFF0F0F0FFF1F1F1FFEFEFEFFF919191FF848484FF787878FFD1D1D1FF9C9C
          9CFF7D7D7DFF9C9C9CFFD2D2D2FFAFAFAFFF5050508A00000000808080FFF1F1
          F1FFF1F1F1FFF1F1F1FFEFEFEFFF828282FF989898FFE9E9E9FFEFEFEFFF9191
          91FF949494FF9B9B9BFF737373E4323232540000000000000000878787FFF1F1
          F1FFF1F1F1FFEEEEEEFFA0A0A0FFBEBEBEFFF0F0F0FFF1F1F1FFEFEFEFFF9191
          91FF919191FF919191FF7A7A7AFF0000000000000000000000008D8D8DFFF1F1
          F1FFE5E5E5FFD2D2D2FF808080FFF1F1F1FFF1F1F1FFF1F1F1FFEFEFEFFF9191
          91FF919191FF919191FF808080FF0000000000000000000000008A8A8AF0E1E1
          E1FFD0D0D0FFD0D0D0FF878787FFF1F1F1FFF1F1F1FFEEEEEEFFD6D6D6FFC0C0
          C0FF9B9B9BFF919191FF878787FF00000000000000000000000051515187A5A5
          A5FFD0D0D0FFD1D1D1FF8D8D8DFFF1F1F1FFE5E5E5FFD2D2D2FFD0D0D0FFD0D0
          D0FFD0D0D0FFB7B7B7FF868686F3000000000000000000000000000000001818
          182759595990AAAAAAFF919191FCE1E1E1FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0
          D0FFD4D4D4FFAFAFAFFF5050508A000000000000000000000000000000000000
          0000000000000F0F0F1851515187A5A5A5FFD0D0D0FFD1D1D1FFD5D5D5FFBDBD
          BDFF717171BD3232325400000000000000000000000000000000000000000000
          00000000000000000000000000001818182759595990AAAAAAFF7F7F7FCF3F3F
          3F66000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFF54A57FFFF9FDFCFF54A57FFF54A57FFF54A57FFFE8F6F2FF54A57FFFDDF2
          ECFF54A57FFF54A57FFF54A57FFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0
          E9FFD2EEE6FFCDECE4FFC8EAE1FFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFF54A57FFFF1FAF7FF54A57FFF54A57FFF54A57FFFDDF2ECFF54A57FFFD2EE
          E6FF54A57FFF54A57FFF54A57FFFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDEC
          E4FFC8EAE1FFC3E8DEFFBFE6DBFFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FF54A57FFFE8F6F2FF54A57FFF54A57FFF54A57FFFD2EEE6FF54A57FFFC8EA
          E1FF54A57FFF54A57FFF54A57FFFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFE9F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8
          DEFFBEE6DBFFBAE5D9FFB7E3D7FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FF54A57FFFDDF2ECFF54A57FFF54A57FFF54A57FFFC8EAE1FF54A57FFFBFE6
          DBFF54A57FFF54A57FFF54A57FFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000004343
          4396727272FF727272FF727272FF727272FF727272FF43434396000000000000
          0000000000000000000000000000000000000000000000000000000000007979
          79FFC8C8C8FFB5B5B5FFB5B5B5FFB5B5B5FFC8C8C8FF797979FF000000000000
          0000000000000000000000000000000000000000000000000000000000008282
          82FFD1D1D1FFC1C1C1FFC1C1C1FFC1C1C1FFD1D1D1FF828282FF000000000000
          000000000000083524960E5A3EFF0E5A3EFF0E5A3EFF0E5A3EFF0E5A3EFF0E5A
          3EFF0E5A3EFF0E5A3EFF5D8979FFCDCDCDFFDADADAFF8B8B8BFF000000000000
          000000000000156144FF309168FF309168FF309168FF309168FF309168FF3091
          68FF309168FF309168FF156144FFE3E3E3FFEAEAEAFF949494FF000000000000
          0000000000001E6A4CFF3E9A74FF3E9A74FF3E9A74FF3E9A74FF3E9A74FF3E9A
          74FF3E9A74FF3E9A74FF1E6A4CFFF7F7F7FFF9F9F9FF9C9C9CFF000000000000
          000000000000277455FF4DA583FF4DA583FF4DA583FF4DA583FF4DA583FF4DA5
          83FF4DA583FF4DA583FF277455FFA1A1A1FFA1A1A1FF5F5F5F96000000000000
          000000000000317F5EFF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB0
          92FF5FB092FF5FB092FF317F5EFF000000000000000000000000000000000000
          0000000000003B8A67FF70BBA1FF70BBA1FF70BBA1FF70BBA1FF70BBA1FF70BB
          A1FF70BBA1FF70BBA1FF3B8A67FF000000000000000000000000434343967272
          72FF727272FF449470FF7FC6B0FF7FC6B0FF7FC6B0FF7FC6B0FF7FC6B0FF7FC6
          B0FF7FC6B0FF7FC6B0FF449470FF000000000000000000000000797979FFC8C8
          C8FFB5B5B5FF4D9D78FF8DCFBCFF8DCFBCFF8DCFBCFF8DCFBCFF8DCFBCFF8DCF
          BCFF8DCFBCFF8DCFBCFF4D9D78FF000000000000000000000000828282FFD1D1
          D1FFC1C1C1FF54A47EFF96D5C4FF96D5C4FF96D5C4FF96D5C4FF96D5C4FF96D5
          C4FF96D5C4FF96D5C4FF54A47EFF0000000000000000000000008B8B8BFFDADA
          DAFFCDCDCDFF89B8A1FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF34644D96000000000000000000000000949494FFEAEA
          EAFFE3E3E3FFE3E3E3FFE3E3E3FFEAEAEAFF949494FF00000000000000000000
          00000000000000000000000000000000000000000000000000009C9C9CFFF9F9
          F9FFF7F7F7FFF7F7F7FFF7F7F7FFF9F9F9FF9C9C9CFF00000000000000000000
          00000000000000000000000000000000000000000000000000005F5F5F96A1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F9600000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000306000003060000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000005052C4E121290FF121290FF0505
          2745000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000006063157121493FF1125B3FF1124B1FF1213
          92FF050527450000000000000000000000000000000000000000000000000000
          000000000000000000000607365D111597FF132AB7FF1432C3FF1432C3FF1328
          B4FF111495FF0405264200000000000000000000000000000000000000000000
          00000000000006073B6312159AFF162FBCFF1837C7FF1837C7FF1837C7FF1837
          C7FF152BB7FF111398FF04052742000000000000000000000000000000000000
          00000708416C13189EFF1A35C1FF1C3ECBFF1C3ECBFF1C3ECBFF1C3ECBFF1C3E
          CBFF1C3ECBFF1830BBFF11149BFF0405263F0000000000000000000000000708
          456F1219A3FF2040C8FF274BD2FF274BD2FF274BD2FF274BD2FF274BD2FF274B
          D2FF274BD2FF274BD2FF1E38C0FF10149FFF030421360000000003041E30141B
          A5FF284ACFFF335AD9FF335AD9FF335AD9FF335AD9FF335AD9FF335AD9FF335A
          D9FF335AD9FF335AD9FF335AD9FF2541C6FF090C649F00000000080C63992944
          C8FF4168E1FF4269E1FF4269E1FF4269E1FF4269E1FF4269E1FF4269E1FF4269
          E1FF4269E1FF4269E1FF4269E1FF4269E1FF2A3BBDFF050736540F17A9FF446B
          E2FF4F77E8FF4F77E8FF4F77E8FF4F77E8FF4F77E8FF4F77E8FF4F77E8FF4F77
          E8FF4F77E8FF4F77E8FF4F77E8FF4F77E8FF4565DAFF0A0F77B41822B2FF5B83
          EDFF5C84EEFF5C84EEFF5C84EEFF5C84EEFF5C84EEFF6389EFFF5F86EEFF5C84
          EEFF5C84EEFF5C84EEFF5C84EEFF5C84EEFF5D83EBFF0D149FEA0F18B0FF7698
          F4FF688EF2FF688EF2FF688EF2FF688EF2FF698FF2FF829FF2FF7F9EF3FF688E
          F2FF688EF2FF688EF2FF688EF2FF688EF2FF7395F2FF0E16A4ED080E71A2768E
          E9FF7E9FF7FF7397F6FF7498F6FF7B9DF7FF8CA9F8FF5467D8FF5366D5FF89A7
          F8FF7A9CF7FF7498F6FF7397F6FF799BF7FF7D97EEFF09107EB4030528391D2A
          BEFF7E96EEFF93AEFAFF92ADFAFF86A0F3FF4B5ED5FF070C6690070D6A965062
          D6FF88A2F3FF93AEFAFF93AEFAFF8BA6F6FF2D3BC5FF0406354B000000000306
          2D3F080F79A80C17B5FC0C16B1F6091188BD04083C5400000000000000000408
          435D09128EC60C16B1F61421BBFF0A1397D205094B6900000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000010709000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000006291C780B4D35E106291C780000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000E5038E12F8C64FF0E5038E10000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000135A3FF0308F68FF135A3FF00000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000002070512216C4FFF399771FF267053FF030C
          081E000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000081D1545347F61FF429D78FF388265FF0A22
          1851000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000164331963F9170FF4BA380FF409271FF1644
          3299000000000000000000000000000000000000000000000000000000000000
          00000000000000000000010101032C7959FF52A686FF55A989FF52A686FF2D7A
          5AFF010302060000000000000000000000000000000000000000000000000000
          000000000000000000001536286C479375FF5FB092FF5FB092FF5FB092FF4894
          75FF143427690000000000000000000000000000000000000000000000000000
          00000000000001020103388765FF60AF92FF68B79BFF68B79BFF68B79BFF5FAE
          91FF2D6E52D20000000000000000000000000000000000000000000000000000
          0000000000001E45347E55A183FF72BDA4FF72BDA4FF6CB79EFF72BDA4FF72BD
          A4FF549F81FF1D42317800000000000000000000000000000000000000000000
          0000000000003D8565E776BEA6FF7BC3ACFF448E74FF1A674AFF448E74FF7BC3
          ACFF74BDA5FF3B8262E100000000000000000000000000000000000000000000
          0000030504094E9C78FF8CCDB8FF80C6AFFF378363FFB6DACCFF398565FF7FC5
          AEFF8FCEBAFF499974FF00000000000000000000000000000000000000000000
          000000000000458B6BE1ABD9C9FF8BCEBAFF66B092FF4B9A75FF66B092FF8BCE
          BAFFA7D7C6FF428666D800000000000000000000000000000000000000000000
          000000000000274D3B787CBB9FFFBCE3D8FF9ED7C8FF91D2BFFF9FD8C8FFBEE4
          DAFF7CBB9FFF2447366F00000000000000000000000000000000000000000000
          0000000000000000000033624B967DBDA0FFB8DED0FFD1ECE5FFB6DDCFFF79BB
          9DFF33624B960000000000000000000000000000000000000000000000000000
          000000000000000000000000000022403160468667C958A881FC458466C6203E
          305D000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000002F2F2F965050
          50FF505050FF505050FF505050FF505050FF505050FF505050FF505050FFE0E3
          F7FF4F64D2FF1936C4FF1732C3FF4D62D1FF02071D2600000000545454FFFFFF
          FFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFE5E8F7FF2241
          CAFF1737C8FF1333C7FF1233C6FF1333C7FF1837C5FB03061B23585858FFFDFD
          FDFFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FF5D77D9FF1D42
          CFFF1B41CFFF7A90E3FFF5F7FEFF617CDDFF1940CDFF112B9DC35E5E5EFFFDFD
          FDFFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FF2C55D7FF234D
          D6FF819BE8FF1A43D2FF7B97E6FFF0F3FCFF1F4BD5FF1B45D0FB636363FFFDFD
          FDFFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFF3764E0FF2D5B
          DDFFF7FAFEFF84A0EDFF1E4FDBFF7E9BEBFF2857DCFF2050D7F96A6A6AFFFDFD
          FDFFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFF6D92E9FF2F64
          E5FF789BEEFFF5F8FDFF85A3EEFF3166E5FF3266E5FF1C43A1B5707070FFFDFD
          FDFFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFDAE0EDFF4679
          EBFF346DEAFF346CEAFF356DEBFF3970EBFF386DE0F3060D1C1F777777FFFDFD
          FDFFEFEFEFFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFE0E4
          EBFF7DA2EDFF5085EFFF5185F0FF82A8F5FF05091314000000007D7D7DFFFDFD
          FDFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEBEBEBFFEAEAEAFFEAEA
          EAFFE9E9E9FFE9E9E9FFFDFDFDFFFFFFFFFF0000000000000000848484FFFDFD
          FDFFECECECFFECECECFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8
          E8FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF00000000000000008A8A8AFFFDFD
          FDFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8E8FFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF0000000000000000909090FFFDFD
          FDFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFDFDFFE0E0
          E0FFE5E5E5FFEBEBEBFF909090FF555555960000000000000000959595FFFDFD
          FDFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFFDFDFDFFE5E5
          E5FFEBEBEBFF959595FF585858960000000000000000000000009A9A9AFFFDFD
          FDFFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE5E5E5FFE5E5E5FFFDFDFDFFEBEB
          EBFF9A9A9AFF5B5B5B96000000000000000000000000000000009E9E9EFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF9E9E
          9EFF5D5D5D9600000000000000000000000000000000000000005F5F5F96A1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F
          5F96000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005154
          6870485CC9F71936C4FF1732C3FF4155C4F2383D535C00000000000000000000
          0000000000000000000000000000000000000000000000000000717483892241
          CAFF1737C8FF1333C7FF1233C6FF1333C7FF1C3BC9FF484C61692D2D2D964C4C
          4CFF4C4C4CFF4C4C4CFF4C4C4CFF4C4C4CFF4C4C4CFF6C6C6CFF607ADCFF1D42
          CFFF1B41CFFF7A90E3FFF5F7FEFF617CDDFF1940CDFF4862D5FD505050FFAEAE
          AEFFAEAEAEFFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFE0E0E0FF2C55D7FF234D
          D6FF819BE8FF1A43D2FF7B97E6FFF0F3FCFF1F4BD5FF1F49D4FF555555FFAEAE
          AEFFAEAEAEFFC2C2C2FF909090FF909090FF909090FFD0D0D0FF3865E1FF2D5B
          DDFFF7FAFEFF84A0EDFF1E4FDBFF7E9BEBFF2857DCFF2656DDFF5A5A5AFFAEAE
          AEFFAEAEAEFFC2C2C2FF909090FF909090FF909090FFBEBEBEFF7297EEFF2F64
          E5FF789BEEFFF5F8FDFF85A3EEFF3166E5FF3266E5FF668DEBFF616161FFAEAE
          AEFFAEAEAEFFAEAEAEFFAEAEAEFFAEAEAEFFAEAEAEFFB4B4B4FFE5EBF8FF487B
          ECFF346DEAFF346CEAFF356DEBFF3970EBFF4479ECFFD1D8E7FF5E5E5EE7E8E8
          E8FFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFF1F1F1FFF2F6
          FDFF85AAF5FF5287F2FF5186F1FF82A8F5FFEEF2FCFF7A7A7AE9484848A5C3C3
          C3FFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFE1E1
          E1FFF1F1F1FFF7F7F7FFF6F6F6FFEFEFEFFFC8C8C8FF484848A530303066AAAA
          AAFFDEDEDEFFDEDEDEFFE5E5E5FFF4F4F4FFF8F8F8FFFCFCFCFFFCFCFCFFF8F8
          F8FFF4F4F4FFE5E5E5FFDEDEDEFFDEDEDEFFAAAAAAFF2E2E2E63121212248F8F
          8FFFDEDEDEFFE9E9E9FFF8F8F8FFEDEDEDFFE3E3E3FFDEDEDEFFDEDEDEFFE3E3
          E3FFEDEDEDFFF8F8F8FFEAEAEAFFDEDEDEFF8F8F8FFF0F0F0F1E000000007575
          75E1D7D7D7FFF6F6F6FFE4E4E4FFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDE
          DEFFDEDEDEFFE4E4E4FFF6F6F6FFD6D6D6FF757575E100000000000000005B5B
          5BA5C6C6C6FFF1F1F1FFE2E2E2FFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDE
          DEFFDEDEDEFFE2E2E2FFF1F1F1FFC5C5C5FF5656569C00000000000000003939
          3963B4B4B4FFE1E1E1FFEDEDEDFFE6E6E6FFE1E1E1FFDEDEDEFFDEDEDEFFE1E1
          E1FFE6E6E6FFEDEDEDFFE2E2E2FFB2B2B2FF3434345A00000000000000001414
          1421A1A1A1FFDEDEDEFFDEDEDEFFE4E4E4FFE6E6E6FFE8E8E8FFE8E8E8FFE6E6
          E6FFE4E4E4FFDEDEDEFFDDDDDDFFA0A0A0FF1212121E00000000000000000000
          00005C5C5C969D9D9DFF9D9D9DFF9D9D9DFF9D9D9DFF9D9D9DFF9D9D9DFF9D9D
          9DFF9D9D9DFF9D9D9DFF9D9D9DFF5C5C5C960000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005555
          55FF555555FF00000000555555FF555555FF00000000555555FF555555FF0000
          0000555555FF555555FF00000000555555FF555555FF00000000000000005959
          59FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000595959FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006161
          61FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000616161FF00000000000000006565
          65FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000656565FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006F6F
          6FFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000006F6F6FFF00000000000000007474
          74FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000747474FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007D7D
          7DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007D7D7DFF00000000000000008282
          82FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000828282FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008989
          89FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000898989FF00000000000000008B8B
          8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF0000
          00008B8B8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000A141B322547
          63B509131C330000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000048789FFF4184
          BAFF356791FF0D1B274600000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000005583AAFFA5CB
          EAFF4488C2FF396D95FF0F1D2A48000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000213E558B5589
          ADFFA3CBEEFF478DC6FF3E759FFF10202B460000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000002343
          59895B8FB4FFA6CDEEFF4E96CDFF427FA7FF12222E4700000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000027465C876098BCFFA8D4F1FF55A0D5FF4988AFFF14253047000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000002A4C618867A0C1FFA9DBF5FF5CA9DBFF5190B6FF152732460000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002E4F65876CA7CBFFACDBF6FF63B1E5FF5697BFFF1629
          3445000000000000000000000000000000000E0E0E1F00000000000000000000
          00000000000000000000000000003055698771B0D3FFB1E1F9FF74C0F0FF5CA3
          CAFFC5C5C5FF01010102000000000606060C767878F821212148000000000000
          000000000000000000000000000000000000345A6F8A73B6D9FFB4DDF4FF7984
          89FF9C9A98FF737373E51E1E1E3B767675E7BABCBBFF767474EF000000000000
          000000000000000000000000000000000000000000002239465583888BF7B5B2
          B0FFDAD9D8FFC1C1C1FF818180F3C0BEBEFF888888F54242427C000000000000
          0000000000000000000000000000000000000000000000000000807C7AD6C3C4
          C1FFE3E3E4FFE9E5E6FFF0EFEFFF9E9F9FFF0808080D00000000000000000000
          00000000000000000000000000000000000000000000000000000F0E0E179595
          96F9F1EFF2FFFAF8F9FFCBCCCBFF797979C40000000000000000000000000000
          00000000000000000000A3A3A3F09D9D9DE7979996E1909190D6A9A8A9FAE0E1
          E1FFF0EEEFFFCACACAFF7E7C7DBE040404060000000000000000000000000000
          0000000000000000000004040406333333476C6A6B96A09E9FDFB0B1B1F9B1B3
          B2FD8B8D8EC93D3C3D5800000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000BA7751FFBA77
          51FF744A339F0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000744A339FBA7751FFBA7751FFBA7751FFBA77
          51FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000BA7751FFBA7751FF744A339F0000
          0000BA7751FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000BA7751FF000000007249329C000000000000
          000000000000000000004A2916967E4525FF7E4525FF7E4525FF7E4525FF7E45
          25FF7E4525FF4A29169600000000000000000000000000000000000000000000
          00000000000000000000894B28FFFEFDFCFFFEFDFCFFFEFDFCFFFEFDFCFFFEFD
          FCFFFEFDFCFF894B28FF00000000000000000000000000000000000000000000
          00000000000000000000A1592FFFFEFDFCFFF8EEE8FFF7ECE5FFF7EBE4FFF6E8
          E0FFFEFDFCFFA1592FFF00000000000000000000000000000000000000000000
          00000000000000000000B16234FFFEFDFCFFF8EDE7FFF7EBE4FFF6E8E0FFF6E7
          DFFFFEFDFCFFB16234FF00000000000000000000000000000000000000000000
          00000000000000000000BF6938FFFEFDFCFFF7ECE5FFF6E8E0FFF6E7DFFFF5E6
          DDFFFEFDFCFFBF6938FF00000000000000000000000000000000000000000000
          00000000000000000000C87342FFFEFDFCFFF7ECE5FFF6E7DFFFF5E6DDFFF5E6
          DDFFFEFDFCFFC87342FF00000000000000000000000000000000000000000000
          00000000000000000000CC7D4FFFFEFDFCFFF7EBE4FFF5E6DDFFFEFDFCFFFEFD
          FCFFFEFDFCFFCC7D4FFF00000000000000000000000000000000000000000000
          00000000000000000000CF855BFFFEFDFCFFF6E8E0FFF5E6DDFFFEFDFCFFCF85
          5BFFCF855BFFCC7D4FFF00000000000000000000000000000000000000000000
          00000000000000000000D38E66FFFEFDFCFFFEFDFCFFFEFDFCFFFEFDFCFFD38E
          66FFD38E66FFE3B89FFF00000000000000000000000000000000040302060000
          000000000000000000007D574196D5946EFFD5946EFFD5946EFFD5946EFFD594
          6EFFE3B89FFF00000000000000000000000000000000040302067D5036AB0403
          0206BA7751FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000BA7751FF040302067D5036ABBA7751FFBA77
          51FF040302060000000000000000000000000000000000000000000000000000
          000000000000000000000000000004030206BA7751FFBA7751FFBA7751FFBA77
          51FF815338B10403020600000000000000000000000000000000000000000000
          0000000000000000000004030206815338B1BA7751FFBA7751FF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000414141966F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F6FFF6F6F
          6FFF6F6F6FFF6F6F6FFF6F6F6FFF414141960000000000000000000000000000
          0000717171FFC4C4C4FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0
          B0FFB0B0B0FFB0B0B0FFC4C4C4FF717171FF0000000000000000000000000000
          0000747474FFC5C5C5FF949494FF717171FFB2B2B2FF949494FF717171FFB2B2
          B2FF949494FF717171FFC5C5C5FF747474FF0000000000000000000000000000
          0000777777FFC8C8C8FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6
          B6FFB6B6B6FFB6B6B6FFC8C8C8FF777777FF0000000000000000000000000000
          00007B7B7BFFCBCBCBFF949494FF717171FFBABABAFF949494FF717171FFBABA
          BAFF949494FF717171FFCBCBCBFF7B7B7BFF0000000000000000000000000000
          00007F7F7FFFCECECEFFBEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFBEBE
          BEFFBEBEBEFFBEBEBEFFCECECEFF7F7F7FFF0000000000000000000000000000
          0000838383FFD1D1D1FF949494FF717171FFC2C2C2FF949494FF717171FFC2C2
          C2FF949494FF717171FFD1D1D1FF838383FF0000000000000000000000000000
          0000878787FFD5D5D5FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7
          C7FFC7C7C7FFC7C7C7FFD5D5D5FF878787FF0000000000000000000000000000
          00008B8B8BFFD8D8D8FF949494FF717171FFCBCBCBFF949494FF717171FFCBCB
          CBFF5258DBFF5258DBFFD8D8D8FF8B8B8BFF0000000000000000000000000000
          00008F8F8FFFDCDCDCFFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0
          D0FFD0D0D0FFD0D0D0FFDCDCDCFF8F8F8FFF0000000000000000000000000000
          0000939393FFDFDFDFFFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4D4FFD4D4
          D4FFD4D4D4FFD4D4D4FFDFDFDFFF939393FF0000000000000000000000000000
          0000969696FFE2E2E2FFCE8246FFCE8246FFCE8246FFCD8246FFCE8246FFCE82
          46FFCE8246FFCE8245FFE2E2E2FF969696FF0000000000000000000000000000
          0000999999FFE4E4E4FFDA985EFFDA985EFFDA985EFFDA985EFFDA985EFFDA98
          5EFFDA985EFFDA985EFFE4E4E4FF999999FF0000000000000000000000000000
          00009C9C9CFFECECECFFE3A870FFE3A870FFE3A870FFE3A870FFE3A870FFE3A8
          70FFE3A870FFE3A870FFECECECFF9C9C9CFF0000000000000000000000000000
          00009F9F9FFFF9F9F9FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
          F7FFF7F7F7FFF7F7F7FFF9F9F9FF9F9F9FFF0000000000000000000000000000
          00005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F960000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000414141966F6F
          6FFF4141419600000000414141966F6F6FFF41414196000000000A0A54961111
          8FFF11118FFF0A0A549600000000414141966F6F6FFF41414196737373FFE6E6
          E6FF737373FF00000000737373FFE6E6E6FF737373FF00000000101292FF122E
          C1FF122EC1FF101292FF00000000737373FFE6E6E6FF737373FF767676FFE7E7
          E7FF767676FF00000000767676FFE7E7E7FF767676FF00000000101295FF1534
          C5FF1534C5FF101295FF00000000767676FFE7E7E7FF767676FF7B7B7BFFE8E8
          E8FF7B7B7BFF000000007B7B7BFFE8E8E8FF7B7B7BFF00000000101399FF1A3B
          C9FF1A3BC9FF101399FF000000007B7B7BFFE8E8E8FF7B7B7BFF7F7F7FFFEAEA
          EAFF7F7F7FFF000000007F7F7FFFEAEAEAFF7F7F7FFF000000000F139DFF1F43
          CEFF1F43CEFF0F139DFF000000007F7F7FFFEAEAEAFF7F7F7FFF848484FFECEC
          ECFF848484FF00000000848484FFECECECFF848484FF000000000F14A1FF244C
          D4FF244CD4FF0F14A1FF00000000848484FFECECECFF848484FF898989FFEEEE
          EEFF898989FF00000000898989FFEEEEEEFF898989FF000000000E14A5FF2955
          D9FF2955D9FF0E14A5FF00000000898989FFEEEEEEFF898989FF8E8E8EFFF0F0
          F0FF8E8E8EFF000000008E8E8EFFF0F0F0FF8E8E8EFF000000000E15A9FF2E5E
          DFFF2E5EDFFF0E15A9FF000000008E8E8EFFF0F0F0FF8E8E8EFF939393FFF2F2
          F2FF939393FF00000000939393FFF2F2F2FF939393FF000000000D15ADFF3366
          E4FF3366E4FF0D15ADFF00000000939393FFF2F2F2FF939393FF979797FFF3F3
          F3FF979797FF00000000979797FFF3F3F3FF979797FF000000000D16B1FF386D
          E8FF386DE8FF0D16B1FF00000000979797FFF3F3F3FF979797FF9B9B9BFFF7F7
          F7FF9B9B9BFF000000009B9B9BFFF7F7F7FF9B9B9BFF000000000D16B4FF3B73
          ECFF3B73ECFF0D16B4FF000000009B9B9BFFF7F7F7FF9B9B9BFF9E9E9EFFFCFC
          FCFF9E9E9EFF000000009E9E9EFFFCFCFCFF9E9E9EFF000000000C17B7FF9FBC
          F7FF9FBCF7FF0C17B7FF000000009E9E9EFFFCFCFCFF9E9E9EFF5F5F5F96A1A1
          A1FF5F5F5F96000000005F5F5F96A1A1A1FF5F5F5F9600000000070E6D960C17
          B9FF0C17B9FF070E6D96000000005F5F5F96A1A1A1FF5F5F5F96000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000935
          24960F5A3EFF0F5A3EFF0F5A3EFF093524960000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001763
          46FF32926AFF32926AFF32926AFF176346FF00000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF216D
          4FFF429D78FF429D78FF429D78FF216D4FFF0000000000000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFF7EAF9BFF2B7959FF2B79
          59FF55A989FF55A989FF55A989FF2B7959FF2B7959FF194734961B684AFFFCFD
          FDFFFCFEFEFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FF378563FFBEE0D4FF68B7
          9BFF68B79BFF68B79BFF68B79BFF68B79BFFBEE0D4FF378563FF247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FF84BAA3FF41916DFFC6E5
          DBFF7BC3ACFF7BC3ACFF7BC3ACFFC6E5DBFF41916DFF265540962C7A5AFFF8FC
          FAFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFF85BEA5FF4B9B
          76FFCDEAE1FF8BCEBAFFCDEAE1FF4B9B76FF95C4AEFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FF85C2
          A8FF53A47EFFD2EDE6FF53A47EFF89C3AAFF368462FF000000003E8D6AFFF4FA
          F8FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EA
          E1FF85C4A8FF59AA83FF81C2A6FFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFE9F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8
          DEFFBEE6DBFFBAE5D9FFB7E3D7FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FFE4F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8DEFFBFE6
          DBFFBBE5D9FFB7E3D7FFB4E2D5FFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFFBD7B03FFB77501FFB57200FFAF6E00FFAC6B00FFAB6B00FFAB6C00FFAD6F
          00FFAB7201FFAC7200FFB07C0AFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFBF9350FFBE8E49FFBE8A3FFFBF8831FFBF882EFFBF852DFFC18530FFC085
          2DFFC3892BFFC3882DFFC2923AFFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFFE4C4A2FFE5CBACFFEAD0B0FFF0D3B0FFF0D2B0FFEFD3B3FFF1D6B3FFF0D5
          B5FFEDD8BAFFF0D6BAFFEED6B9FFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFE7C497FFEACAA0FFF1D0A2FFF2D4ACFFF3D6B4FFF5DDBEFFEFD9B5FFF0DA
          B3FFF1DBB8FFF5E2C0FFF4DFC5FFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FFEABA71FFEDBA74FFEEBE79FFEEBF7EFFF0BF80FFF3C485FFF5C383FFF2C3
          86FFF5C98DFFF5CD97FFF3CB99FFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFECB566FFECB667FFEDB667FFEBB46AFFEBB56AFFF1B86DFFF1BC71FFEFBC
          79FFF2C07AFFF2C07BFFF2BF77FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FFECB159FFEDB25DFFEFB35FFFF1B160FFEFB565FFF2B76DFFF1BB70FFF2BE
          77FFF3BF7AFFF4BF7AFFF3C07AFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00002F2F2F96505050FF505050FF505050FF505050FF505050FF505050FF5050
          50FF505050FF505050FF505050FF505050FF505050FF2F2F2F96000000000000
          0000545454FFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFF545454FF000000000000
          0000585858FFBC8E80FF8D4128FFB78A7CFFF2F2F2FFF2F2F2FFF2F2F2FFF1F1
          F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFFDFDFDFF585858FF000000000000
          0000794C3CFF94482DFFC47132FF93472DFFF2F2F2FFF1F1F1FFF1F1F1FFF0F0
          F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFFDFDFDFF5E5E5EFF000000005328
          168E92482BFFC97A3CFFC97A3CFF9A5032FF9A5032FF9A5032FF9A5032FFBD91
          80FFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFFDFDFDFF636363FF572D1A8E954C
          2DF2CF8447FFCF8447FFCF8447FFCF8447FFCF8447FFCF8447FFCF8447FFA158
          39FFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFFDFDFDFF6A6A6AFF9C5534F2EAC7
          AAFFD58F54FFD58F54FFD58F54FFD58F54FFD58F54FFD58F54FFD58F54FFA861
          40FFEDEDEDFFECECECFFEBEBEBFFEBEBEBFFFDFDFDFF707070FF6037238EA35E
          3BF2EDCCAFFFDB995FFFDB995FFFEDCCAFFFEDCCAFFFEDCCAFFFEDCCAFFFAF6A
          47FFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFFDFDFDFF777777FF00000000643C
          268EB06D47FFF0D1B4FFE0A269FFB6734DFFB6734DFFB6734DFFB6724DFFCCA4
          8EFFEAEAEAFFEAEAEAFFE9E9E9FFE9E9E9FFFDFDFDFF7D7D7DFF000000000000
          0000A17B63FFBC7A52FFF1D4B8FFBC7951FFEBEBEBFFEBEBEBFFEAEAEAFFEAEA
          EAFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF000000000000
          00008A8A8AFFD9B39BFFBF7E55FFD1AB93FFEAEAEAFFEAEAEAFFE9E9E9FFE8E8
          E8FFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF000000000000
          0000909090FFFDFDFDFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7
          E7FFFDFDFDFFE0E0E0FFE5E5E5FFEBEBEBFF909090FF55555596000000000000
          0000959595FFFDFDFDFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6
          E6FFFDFDFDFFE5E5E5FFEBEBEBFF959595FF5858589600000000000000000000
          00009A9A9AFFFDFDFDFFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE5E5E5FFE5E5
          E5FFFDFDFDFFEBEBEBFF9A9A9AFF5B5B5B960000000000000000000000000000
          00009E9E9EFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFF9E9E9EFF5D5D5D96000000000000000000000000000000000000
          00005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FF5F5F5F9600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00002F2F2F96505050FF505050FF505050FF505050FF505050FF505050FF5050
          50FF505050FF505050FF505050FF505050FF505050FF2F2F2F96000000000000
          0000545454FFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFF545454FF000000000000
          0000585858FFFDFDFDFFB78A7CFF8D4128FFB78A7BFFF2F2F2FFF2F2F2FFF1F1
          F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFFDFDFDFF585858FF000000000000
          00005E5E5EFFFDFDFDFF93472DFFC47132FF93472DFFBA8D7EFFF1F1F1FFF0F0
          F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFFDFDFDFF5E5E5EFF5328168E8D43
          26F292482BFF9A5033FF9A5032FFC97A3CFFC97A3CFF9A5032FFBD9280FFEFEF
          EFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFFDFDFDFF636363FF954C2DF2CF84
          47FFCF8447FFCF8447FFCF8447FFCF8447FFCF8447FFCF8447FFA15839FFC196
          84FFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFFDFDFDFF6A6A6AFF9C5534F2D58F
          54FFD58F54FFD58F54FFD58F54FFD58F54FFD58F54FFD58F54FFEAC7AAFFA861
          40FFEDEDEDFFECECECFFEBEBEBFFEBEBEBFFFDFDFDFF707070FFA35E3BF2EDCC
          AFFFEDCCAFFFEDCCAFFFEDCCAFFFDB995FFFDB995FFFEDCCAFFFAF6A47FFC8A0
          8BFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFFDFDFDFF777777FF643C268EAA66
          41F2B06D47FFB7734DFFB6734DFFE0A269FFF0D1B4FFB6734DFFCCA48EFFEBEB
          EBFFEAEAEAFFEAEAEAFFE9E9E9FFE9E9E9FFFDFDFDFF7D7D7DFF000000000000
          0000848484FFFDFDFDFFBC7951FFF1D4B8FFBC7951FFCFA890FFEAEAEAFFEAEA
          EAFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF000000000000
          00008A8A8AFFFDFDFDFFD1AB93FFBF7E55FFD1AA92FFEAEAEAFFE9E9E9FFE8E8
          E8FFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF000000000000
          0000909090FFFDFDFDFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7
          E7FFFDFDFDFFE0E0E0FFE5E5E5FFEBEBEBFF909090FF55555596000000000000
          0000959595FFFDFDFDFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6
          E6FFFDFDFDFFE5E5E5FFEBEBEBFF959595FF5858589600000000000000000000
          00009A9A9AFFFDFDFDFFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE5E5E5FFE5E5
          E5FFFDFDFDFFEBEBEBFF9A9A9AFF5B5B5B960000000000000000000000000000
          00009E9E9EFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFF9E9E9EFF5D5D5D96000000000000000000000000000000000000
          00005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FF5F5F5F9600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000031F
          155D000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000062F2087196C
          4BFF062F20870000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000010583CF03290
          68FF1C704EFF0A36259300000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000155C41F03995
          6EFF34936CFF217353FF0C3727900000000000000000000000000F3828871A63
          47F01C694BFF1C694BFF1C694BFF1C694BFF1C694BFF1C694BFF1C694BFF3C97
          72FF3E9A74FF3D9973FF277858FF0F3A298D000000000000000021694CF04BA1
          80FF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A1
          7EFF48A17EFF48A17EFF479F7CFF2E7D5DFF133E2D8D00000000287052F056A8
          89FF53A888FF53A888FF53A888FF53A888FF53A888FF53A888FF53A888FF53A8
          88FF53A888FF53A888FF53A888FF52A686FF358263FF14392A7B2E7858F062B0
          93FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB0
          92FF5FB092FF5FB092FF5FB092FF62B294FF99C9B7FF348161FF357F5FF06CB8
          9CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB8
          9CFF6AB89CFF6AB89CFF6DB99EFFA6D3C3FF589C7FFF1B41317B3B8665F0BBDE
          D3FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FF7AC1
          A9FF75BFA6FF78C0A8FFAAD7C8FF60A386FF234F3B8D00000000254F3C87428C
          6AF0469571FF469571FF469571FF469571FF469571FF469571FF469571FF80C5
          AFFF81C7B1FFAFDACDFF69AB8EFF27523E8D0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000489370F08BCB
          B7FFB6DFD3FF70B295FF2A56428D000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000004A9472EAB6DF
          D2FF75B699FF2E5B469000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002C54418175B8
          99FF2C5441810000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000162A
          203F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000010203265F9CFF22538ED21C4575AE10274363040B
          121B000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000026568FD2C0E1F6FFA6D4F0FF83B8DFFF3A79
          B7FF0000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF23647BFFD5E6F5FFD7E9FAFFCBE3F9FF9FD9
          F4FF468BC3FFE8EFF6FF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFD4E1EDFF7FA7D2FFF9FCFEFFBCE3F9FF38BD
          E8FF519ACCFF498DC5FFE8EFF6FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFFFCFEFEFFF9FDFCFFF6FBFAFFF1FAF7FF6390C2FFC8E4F5FF44D0F4FF00C3
          F2FF25B8E6FF5198CBFF4D91C6FFE8EFF6FF1B684AFF00000000247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8EFF6FF608FC4FFC2EAF8FF28CB
          F3FF00C3F2FF25B8E6FF5198CBFF5193C8FFE8EFF6FF000000002C7A5AFFF8FC
          FAFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFE8EFF6FF6594C5FFC2EB
          F8FF28CBF3FF00C3F2FF25B8E6FF5198CBFF5696CAFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFE8EFF6FF6B97
          C7FFC2EBF8FF28CBF3FF00C3F2FF27B8E6FF5299CCFF6C9DCBFF3E8D6AFFF4FA
          F8FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFE8EF
          F6FF709BCAFFC2EBF8FF28CBF3FF00C3F2FF3FBBE6FF5693C7FF479672FFF1F9
          F7FFE9F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8
          DEFFE8EFF6FF759ECCFFC2EBF8FF42D0F3FF5E9FCEFF2C3F57724E9E79FFEEF9
          F5FFE4F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8DEFFBFE6
          DBFFBBE5D9FFE8EFF6FF79A1CEFF7CA4CEFF59989BFF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFC8E6E2FFC5E3E2FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000013131351373737E70C0C0C330000000000000000000000001313
          134E373737E70C0C0C3300000000000000000000000000000000000000000000
          000000000000000000001313134E383838EA0E0E0E393D3D3DFF141414543737
          37E70B0B0B300000000000000000000000000000000000000000000000000000
          000000000000000000000000000011111148383838EA3D3D3DFF373737E70B0B
          0B30000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000003D3D3DFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000003D3D3DFF000000000000
          00000000000000000000000000000000000000000000000000009A5033FF9A50
          33FF9A5033FF9A5033FF9A5033FF9A5033FF9A5033FF9A5033FF9A5033FF9A50
          33FF9A5033FF9A5033FF9A5033FF9A5033FF9A5033FF00000000A8A8A8FFE0E0
          E0FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
          D6FFD6D6D6FFD6D6D6FFD6D6D6FFE0E0E0FFA8A8A8FF00000000ACACACFFE3E3
          E3FF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFF9E9E9EFFD9D9D9FF9E9E
          9EFF9E9E9EFF9E9E9EFF9E9E9EFFE3E3E3FFACACACFF00000000B2B2B2FFE6E6
          E6FFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDD
          DDFFDDDDDDFFDDDDDDFFDDDDDDFFE6E6E6FFB2B2B2FF00000000B7B7B7FFE9E9
          E9FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFE1E1E1FF56B38BFF56B3
          8BFF56B38BFF56B38BFF56B38BFFE9E9E9FFB7B7B7FF00000000BDBDBDFFECEC
          ECFFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5E5FFEFD1A0FFEFD1
          A0FFEFD1A0FFEFD1A0FFEFD1A0FFECECECFFBDBDBDFF00000000C3C3C3FFEFEF
          EFFFA5A5A5FFA5A5A5FFA5A5A5FFEAEAEAFFA5A5A5FFEAEAEAFFF2C17DFFF2C1
          7DFFF2C17DFFF2C17EFFF3C17DFFEFEFEFFFC3C3C3FF00000000C8C8C8FFF5F5
          F5FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFEEBA6FFFEEBA
          6FFFEEBA6FFFEEBA6FFFEEBA6FFFF5F5F5FFC8C8C8FF00000000CDCDCDFFFCFC
          FCFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
          FBFFFBFBFBFFFBFBFBFFFBFBFBFFFCFCFCFFCDCDCDFF00000000F1D4B8FFF1D4
          B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4
          B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FFF1D4B8FF00000000C07F56FFC07F
          56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F
          56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FF00000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000002F2F
          2F96505050FF505050FF505050FF505050FF505050FF505050FF505050FF5050
          50FF505050FF505050FF505050FF505050FF2F2F2F9600000000000000005454
          54FFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFF545454FF00000000000000005858
          58FFFDFDFDFFF3F3F3FFC36F30FFC36F30FFF2F2F2FFC36F30FFC36F30FFF1F1
          F1FFC36F30FFC36F30FFEFEFEFFFFDFDFDFF585858FF00000000000000005E5E
          5EFFFDFDFDFFF2F2F2FFC77637FFC77637FFF1F1F1FFC77637FFC77637FFF0F0
          F0FFC77637FFC77637FFEEEEEEFFFDFDFDFF5E5E5EFF00000000000000006363
          63FFFDFDFDFFF2F2F2FFCB7D3FFFCB7D3FFFF0F0F0FFCB7D3FFFCB7D3FFFEFEF
          EFFFCB7D3FFFCB7D3FFFEDEDEDFFFDFDFDFF636363FF00000000000000006A6A
          6AFFFDFDFDFFF1F1F1FFD08549FFD08549FFEFEFEFFFD08549FFD08549FFEEEE
          EEFFD08549FFD08549FFECECECFFFDFDFDFF6A6A6AFF00000000000000007070
          70FFFDFDFDFFF0F0F0FFD48E52FFD48E52FFEEEEEEFFD48E52FFD48E52FFEDED
          EDFFD48E52FFD48E52FFEBEBEBFFFDFDFDFF707070FF00000000000000007777
          77FFFDFDFDFFEFEFEFFFD9965CFFD9965CFFEDEDEDFFECECECFFECECECFFEBEB
          EBFFD9965CFFD9965CFFEAEAEAFFFDFDFDFF777777FF00000000000000007D7D
          7DFFFDFDFDFFEDEDEDFFDD9D64FFDD9D64FFECECECFFEBEBEBFFEBEBEBFFEAEA
          EAFFDD9D64FFDD9D64FFE9E9E9FFFDFDFDFF7D7D7DFF00000000000000008484
          84FFFDFDFDFFECECECFFE1A46BFFE1A46BFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9
          E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF00000000000000008A8A
          8AFFFDFDFDFFEBEBEBFFE3A870FFE3A870FFEAEAEAFFE9E9E9FFE8E8E8FFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF00000000000000009090
          90FFFDFDFDFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFD
          FDFFE0E0E0FFE5E5E5FFEBEBEBFF909090FF5555559600000000000000009595
          95FFFDFDFDFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFFDFD
          FDFFE5E5E5FFEBEBEBFF959595FF585858960000000000000000000000009A9A
          9AFFFDFDFDFFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE5E5E5FFE5E5E5FFFDFD
          FDFFEBEBEBFF9A9A9AFF5B5B5B96000000000000000000000000000000009E9E
          9EFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFF9E9E9EFF5D5D5D9600000000000000000000000000000000000000005F5F
          5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FF5F5F5F960000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000604B44808C3F
          27FF8C3F27FF604B448000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000B45132FFDE81
          3AFFC47132FF8C3F27FF604B4480000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000C78E6AFFECCB
          ADFFDE813AFFC47132FF8C3F27FF604B44800000000000000000000000000000
          0000000000000000000000000000000000000000000000000000604B4480C78E
          6AFFECCBADFFDE813AFFC47132FF8C3F27FF604B448000000000000000000000
          000000000000000000000000000000000000000000000000000000000000604B
          4480C78E6AFFECCBADFFDE813AFFC47132FF8C3F27FF5B4C48A5383838B44848
          48E7484848E4383838B117171748000000000000000000000000000000000000
          0000604B4480C78E6AFFECCBADFFCE7C3DFF836147FF7F7F7FFFCBCBCBFFECEC
          ECFFEAEAEAFFC9C9C9FF7D7D7DFF333333960606061200000000000000000000
          000000000000604B4480C78E6AFF978A7DFFB0B0B0FFFAFAFAFFF8F8F8FFF4F4
          F4FFF5F5F5FFF8F8F8FFFAFAFAFFA9A9A9FF3636369600000000000000000000
          0000000000000000000061534FAD979797FFF8F8F8FFEEEEEEFFEDEDEDFFEDED
          EDFFEDEDEDFFEDEDEDFFEFEFEFFFF8F8F8FF8F8F8FFF22222257000000000000
          00000000000000000000525252C3D6D6D6FFEDEDEDFFE6E6E6FFE6E6E6FFE6E6
          E6FFE6E6E6FFE6E6E6FFE6E6E6FFEEEEEEFFD4D4D4FF515151C0000000000000
          00000000000000000000707070F9F1F1F1FFE0E0E0FFDEDEDEFFDEDEDEFFDEDE
          DEFFDEDEDEFFDEDEDEFFDEDEDEFFE1E1E1FFEFEFEFFF6E6E6EF3000000000000
          00000000000000000000787878F9F1F1F1FFDCDCDCFFD7D7D7FFD7D7D7FFD7D7
          D7FFD7D7D7FFD7D7D7FFD7D7D7FFDDDDDDFFEDEDEDFF747474F0000000000000
          00000000000000000000646464C3DBDBDBFFE3E3E3FFD0D0D0FFCFCFCFFFCFCF
          CFFFCFCFCFFFCFCFCFFFD0D0D0FFE6E6E6FFDBDBDBFF646464C3000000000000
          000000000000000000003131315AB2B2B2FFF2F2F2FFD4D4D4FFCCCCCCFFCACA
          CAFFCACACAFFCDCDCDFFD7D7D7FFF3F3F3FFABABABFF3131315A000000000000
          000000000000000000000000000055555596CECECEFFF4F4F4FFE6E6E6FFD9D9
          D9FFD9D9D9FFE7E7E7FFF4F4F4FFCACACAFF5555559600000000000000000000
          00000000000000000000000000001919192A59595996BBBBBBFFDFDFDFFFF1F1
          F1FFF1F1F1FFDEDEDEFFB7B7B7FF595959961414142100000000000000000000
          000000000000000000000000000000000000000000003737375A737373BA9292
          92ED909090EA717171B732323251000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFFBD7B03FFB77501FFB57200FFAF6E00FFAC6B00FFAB6B00FFAB6C00FFAD6F
          00FFAB7201FFAC7200FFB07C0AFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFBF9350FFBE8E49FFBE8A3FFFBF8831FFBF882EFFBF852DFFC18530FFC085
          2DFFC3892BFFC3882DFFC2923AFFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFFE4C4A2FFE5CBACFFEAD0B0FFF0D3B0FFF0D2B0FFEFD3B3FFF1D6B3FFF0D5
          B5FFEDD8BAFFF0D6BAFFEED6B9FFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFE7C497FFEACAA0FFF1D0A2FFF2D4ACFFF3D6B4FFF5DDBEFFEFD9B5FFF0DA
          B3FFF1DBB8FFF5E2C0FFF4DFC5FFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FFEABA71FFEDBA74FFEEBE79FFEEBF7EFFF0BF80FFF3C485FFF5C383FFF2C3
          86FFF5C98DFFF5CD97FFF3CB99FFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFECB566FFECB667FFEDB667FFEBB46AFFEBB56AFFF1B86DFFF1BC71FFEFBC
          79FFF2C07AFFF2C07BFFF2BF77FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FFECB159FFEDB25DFFEFB35FFFF1B160FFEFB565FFF2B76DFFF1BB70FFF2BE
          77FFF3BF7AFFF4BF7AFFF3C07AFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000010103062C1E81000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010705150B422EBA135F43FF0104030C0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000416103C11553CE4227856FF217654FF146145FF1258
          3EED0C3B2A9F030D092400000000000000000000000000000000000000000000
          0000000000000B2F2178186346FC499375FF38966FFF38966FFF38966FFF3692
          6CFF2A805DFF186346FC0A2A1E6C000000000000000000000000000000000000
          0000000000000A2319541C6649F677AC97FF74B69BFF6CB296FF99CAB6FF70B4
          98FF439D78FF3A936FFF338263FF0B291E630000000000000000000000000000
          0000000000000000000007181136206549E76EA68FFF6CA790FF3E8267FF73A9
          94FF84BFA8FF4DA482FF419775FF216A4DF3040C091B00000000000000002975
          56F62B7959FF2B7959FF2B7959FF0B1E1640216147D242896CFF081610301743
          3190629F86FF7BBBA2FF51A786FF489576FF153E2E870000000000000000307C
          5CF96FB79CFF5FB092FF3F8A6BFF08150F2A0206040C1F533DAB010101030000
          00001943318A72AC94FF5BAE8FFF55A587FF25654ACF00000000000000002D6E
          52D281BEA7FF67B69AFF53A183FF1F4B38900000000000000000275F47B70306
          050C08140F27499072FFBCDED2FFB7DBCEFF327D5EF60000000000000000204A
          378782B9A2FF81C3ACFF6FBAA0FF529F80FF224E3B900B1A14304C9777FF3172
          56D20F221A403A8866FF3A8866FF3A8866FF398564F900000000000000000811
          0D1E3E8A68F393C8B5FF87C8B2FF77C0A8FF60AC8FFF4B9A78FF62AE91FF5EAA
          8DFF3B8363E70E1F173600000000000000000000000000000000000000000000
          00001A382B6077B49AFFB0D7C9FFA0D5C4FF86C9B4FF7FC6B0FF7FC6B0FF7FC6
          B0FF7ABBA3FF44916EF617312654000000000000000000000000000000000000
          0000000000001E3E2F66499773F992C6B1FFC0E3D7FFCAE8DFFFADDCCDFFA9DA
          CBFF9ECDBBFF4A9975FC23493878000000000000000000000000000000000000
          000000000000000000000B1711242F604999489370EA52A27CFF86C0A7FF8EC5
          ADFF478F6DE413261D3C00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000204030656A680FF3D78
          5CBA070E0A150000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002A53407E0000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFF54A57FFFF9FDFCFF54A57FFF54A57FFF54A57FFF54A57FFF54A57FFF54A5
          7FFF54A57FFF54A57FFF54A57FFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0
          E9FFD2EEE6FFCDECE4FFC8EAE1FFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFF54A57FFFF1FAF7FF54A57FFF54A57FFF54A57FFF54A57FFF54A57FFF54A5
          7FFF54A57FFF54A57FFF54A57FFFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDEC
          E4FFC8EAE1FFC3E8DEFFBFE6DBFFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FF54A57FFFE8F6F2FF54A57FFF54A57FFF54A57FFF54A57FFF54A57FFF54A5
          7FFF54A57FFF54A57FFF54A57FFFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFE9F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8
          DEFFBEE6DBFFBAE5D9FFB7E3D7FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FF54A57FFFDDF2ECFF54A57FFF54A57FFF54A57FFF54A57FFF54A57FFF54A5
          7FFF54A57FFF54A57FFF54A57FFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000031F
          155D000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000062F2087196C
          4BFF062F20870000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000010583CF03290
          68FF1C704EFF0A36259300000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000155C41F03995
          6EFF34936CFF217353FF0C3727900000000000000000000000000F3828871A63
          47F01C694BFF1C694BFF1C694BFF1C694BFF1C694BFF1C694BFF1C694BFF3C97
          72FF3E9A74FF3D9973FF277858FF0F3A298D000000000000000021694CF04BA1
          80FF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A1
          7EFF48A17EFF48A17EFF479F7CFF2E7D5DFF133E2D8D00000000287052F056A8
          89FF53A888FF53A888FF53A888FF53A888FF53A888FF53A888FF53A888FF53A8
          88FF53A888FF53A888FF53A888FF52A686FF358263FF14392A7B2E7858F062B0
          93FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB0
          92FF5FB092FF5FB092FF5FB092FF62B294FF99C9B7FF348161FF357F5FF06CB8
          9CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB8
          9CFF6AB89CFF6AB89CFF6DB99EFFA6D3C3FF589C7FFF1B41317B3B8665F0BBDE
          D3FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FF7AC1
          A9FF75BFA6FF78C0A8FFAAD7C8FF60A386FF234F3B8D00000000254F3C87428C
          6AF0469571FF469571FF469571FF469571FF469571FF469571FF469571FF80C5
          AFFF81C7B1FFAFDACDFF69AB8EFF27523E8D0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000489370F08BCB
          B7FFB6DFD3FF70B295FF2A56428D000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000004A9472EAB6DF
          D2FF75B699FF2E5B469000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000002C54418175B8
          99FF2C5441810000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000162A
          203F000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000031F155D00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000007332393176B49FF07332393000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000A3524901B6E4DFF2D8E65FF115C3FFC000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000C36268D207151FF33936BFF34946CFF166245FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000F3A298D267656FF3D9873FF3E9A74FF3E9A74FF1C694BFF1C694BFF1C69
          4BFF1C694BFF1C694BFF1C694BFF1C694BFF1C694BFF103E2C9600000000133B
          2B872D7C5CFF479F7CFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF48A1
          7EFF48A17EFF48A17EFF48A17EFF48A17EFF48A17EFF237051FF133527723582
          63FF51A585FF53A888FF53A888FF53A888FF53A888FF53A888FF53A888FF53A8
          88FF53A888FF53A888FF53A888FF53A888FF53A888FF2A7757FF348161FF95C7
          B4FF65B396FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF5FB0
          92FF5FB092FF5FB092FF5FB092FF5FB092FF5FB092FF317F5EFF193C2D72569B
          7EFFA5D2C2FF6EBA9FFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB8
          9CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF6AB89CFF388765FF00000000214B
          39875DA184FFACD7C8FF79C1A8FF75BFA6FF75BFA6FFC3E3D9FFC3E3D9FFC3E3
          D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FFC3E3D9FF3F8E6BFF000000000000
          000026513D8A65A88AFFB2DCCDFF82C7B2FF7FC6B0FF469571FF469571FF4695
          71FF469571FF469571FF469571FF469571FF469571FF29584296000000000000
          0000000000002954408A6AAE90FFB8E0D4FF8BCDB9FF4C9C77FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000002D59458D6FB294FFBBE3D7FF4E9B78F6000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000305C478D75B899FF305C478D000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000162A203F00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000002A2A2A696D6D6DFF2A2A2A690000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000595959D2C8C8C8FF7B7B7BFF3535
          357E000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000727272FFD8D8D8FFDFDFDFFF6767
          67E7000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000787878FFD7D7D7FFEAEAEAFF7878
          78FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007F7F7FFFD7D7D7FFEAEAEAFF7F7F
          7FFF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000878787FFD5D5D5FFE8E8E8FF8787
          87FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000030303057909090FFCFCFCFFFE5E5E5FF9393
          93FF3A3A3A690000000000000000000000000000000000000000000000000000
          00000000000000000000434343729A9A9AFFB9B9B9FFCBCBCBFFE3E3E3FFE8E8
          E8FFA2A2A2FF4848487B00000000000000000000000000000000000000000000
          0000000000004E4E4E7EA2A2A2FFB3B3B3FFBEBEBEFFCACACAFFE3E3E3FFF8F8
          F8FFF5F5F5FFADADADFF5555558A000000000000000000000000000000000000
          00005B5B5B8DA8A8A8FFA9A9A9FFB1B1B1FFBDBDBDFFCACACAFFE3E3E3FFF8F8
          F8FFFFFFFFFFF4F4F4FFBABABAFF5D5D5D900000000000000000000000006565
          6596AFAFAFFFA0A0A0FFA4A4A4FFB0B0B0FFBDBDBDFFCACACAFFE3E3E3FFF8F8
          F8FFFFFFFFFFF8F8F8FFEBEBEBFFC3C3C3FF656565960000000000000000B1B1
          B1FFB2B2B2FF8D8D8DFF838383FF858585FF7C7C7CFF757575FF757575FF8080
          80FF919191FF909090FFA4A4A4FFD4D4D4FFB1B1B1FF0000000000000000ADAD
          ADFFA6A6A6FFD3D3D3FFE8E8E8FFE8E8E8FFF6F6F6FFFFFFFFFFFFFFFFFFF6F6
          F6FFE8E8E8FFE8E8E8FFD4D4D4FFA7A7A7FFACACACFF00000000000000008282
          82BBC7C7C7FFE1E1E1FFEEEEEEFFEEEEEEFFF4F4F4FFFFFFFFFFFFFFFFFFF5F5
          F5FFEEEEEEFFEEEEEEFFE1E1E1FFC7C7C7FF828282BB00000000000000000000
          00004141415A7A7A7AA8949494CC949494CCA1A1A1DEB9B9B9FFB9B9B9FFA3A3
          A3E1949494CC949494CC7A7A7AA84141415A0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000B234496123C73FF0B23
          4496000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000143F76FF78A3C8FF143F
          76FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000164379FF79A5CAFF1643
          79FF000000000000000000000000000000000000000000000000000000000000
          00000000000002070D1D00000000000000000000000019477CFF7BA8CDFF1947
          7CFF000000000000000000000000000000000000000000000000000000000309
          11240C24428F204B7FFF143B6EED0E294CA5071629581C4A7FFF7EABD0FF1C4B
          80FF000000000000000000000000000000000000000000000000000000000E28
          468D6088AFFF78A5CAFF74A1C6FF5986B0FF3B6A99FF204F83FF29578AFF1C4C
          81FF071321420001010200000000000000000000000000000000000000001431
          519783A4C3FF9AC1DDFF5596C6FF73A8D0FF82B2D5FF82B2D5FF74A5CAFF5889
          B4FF3A6C9CFF225489FF194069C50C1E315C0000000000000000000000000711
          1A2E1A3E5EA691B4CFFFCAE1F1FFBBD8ECFFA4CBE6FF77B1DAFF3D73A5FF84B9
          DDFF8ABCDFFF8ABCDFFF74A7CDFF1F4970C50000000000000000000000000000
          00000B19253D1F4465A62F699BFF5486B0FF85ADCCFFB3D1E5FFCBE4F4FFBADB
          F0FF9FCDEAFF72B6E1FF91C6E7FF2F699BFF0000000000000000000000000000
          0000000000000E274796174379FF1E4E83FF275D90FF2F6A9CFF3B77A7FF6697
          BEFF95BCD7FFC2DDEFFFD0E8F7FF3472A3FF0E27479600000000000000000000
          000000000000205186FF7FAED2FF7FAED2FF7FAED2FF7FAED2FF7CACD0FF689D
          C5FF538CB8FF3E7DACFF3878A8FF558EB9FF205186FF13304F96000000000000
          000000000000296193FF8DBFE2FF5CA5D5FF5CA5D5FF5CA5D5FF3872A5FF5CA5
          D5FF5CA5D5FF5CA5D5FF5CA5D5FF8DBFE2FFCCE2F2FF296193FF000000000000
          000000000000326FA0FFD0E8F7FFD0E8F7FFD0E8F7FFD0E8F7FFD0E8F7FFD0E8
          F7FFD0E8F7FFD0E8F7FFD0E8F7FFD0E8F7FF326FA0FF1D415E96000000000000
          000000000000214763963878A8FF3878A8FF3878A8FF3878A8FF3878A8FF3878
          A8FF3878A8FF3878A8FF3878A8FF3878A8FF2147639600000000000000000000
          000000000000000000000000000000000000000000003776A6FFD0E8F7FF3776
          A6FF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000214763963878A8FF2147
          6396000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000022222269535353FF535353FF2222226900000000000000002222
          2269535353FF535353FF22222269000000000000000000000000000000000000
          0000252525695B5B5BFFBBBBBBFFDDDDDDFF5B5B5BFF00000000000000005B5B
          5BFFDDDDDDFFBBBBBBFF5B5B5BFF252525690000000000000000000000002A2A
          2A69656565FFC0C0C0FFDFDFDFFF656565FF2A2A2A6900000000000000002A2A
          2A69656565FFDFDFDFFFC0C0C0FF656565FF2A2A2A69000000002F2F2F697171
          71FFBBBBBBFFD2D2D2FF717171FF2F2F2F690000000000000000000000000000
          00002F2F2F69717171FFD2D2D2FFBBBBBBFF717171FF2F2F2F697C7C7CFFE6E6
          E6FFCDCDCDFF7C7C7CFF33333369000000000000000000000000000000000000
          000000000000333333697C7C7CFFCDCDCDFFE6E6E6FF7C7C7CFF383838698888
          88FFE9E9E9FFD3D3D3FF888888FF383838690000000000000000000000000000
          000038383869888888FFD3D3D3FFE9E9E9FF888888FF38383869000000003C3C
          3C69929292FFECECECFFDCDCDCFF929292FF3C3C3C6900000000000000003C3C
          3C69929292FFDCDCDCFFECECECFF929292FF3C3C3C6900000000000000000000
          0000404040699B9B9BFFF4F4F4FFF4F4F4FF9B9B9BFF00000000000000009B9B
          9BFFF4F4F4FFF4F4F4FF9B9B9BFF404040690000000000000000000000000000
          00000000000042424269A1A1A1FFA1A1A1FF4242426900000000000000004242
          4269A1A1A1FFA1A1A1FF42424269000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000777777FFFDFDFDFFEFEFEFFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFECEC
          ECFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFFDFDFDFF777777FF000000000000
          00007D7D7DFFFDFDFDFFEDEDEDFFEDEDEDFFECECECFFECECECFFEBEBEBFFEBEB
          EBFFEAEAEAFFEAEAEAFFE9E9E9FFE9E9E9FFFDFDFDFF7D7D7DFF000000000000
          0000848484FFFDFDFDFFECECECFFECECECFFEBEBEBFFEBEBEBFFEAEAEAFFEAEA
          EAFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF000000000000
          00008A8A8AFFFDFDFDFFEBEBEBFFEBEBEBFFEAEAEAFFEAEAEAFFE9E9E9FFE8E8
          E8FFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF000000000000
          0000909090FFFDFDFDFFEAEAEAFFE9E9E9FFE9E9E9FFE8E8E8FFE8E8E8FFE7E7
          E7FFFDFDFDFFE0E0E0FFE5E5E5FFEBEBEBFF909090FF55555596000000000000
          0000959595FFFDFDFDFFE9E9E9FFE8E8E8FFE8E8E8FFE7E7E7FFE7E7E7FFE6E6
          E6FFFDFDFDFFE5E5E5FFEBEBEBFF959595FF5858589600000000000000000000
          00009A9A9AFFFDFDFDFFE8E8E8FFE7E7E7FFE7E7E7FFE6E6E6FFE5E5E5FFE5E5
          E5FFFDFDFDFFEBEBEBFF9A9A9AFF5B5B5B960000000000000000000000000000
          00009E9E9EFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFF9E9E9EFF5D5D5D96000000000000000000000000000000000000
          00005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FF5F5F5F9600000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002F2F2F96505050FF505050FF505050FF505050FF505050FF505050FF5050
          50FF505050FF505050FF505050FF505050FF505050FF2F2F2F96000000000000
          0000545454FFFFFFFFFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFF545454FF000000000000
          0000585858FFFDFDFDFFF3F3F3FFF3F3F3FFF2F2F2FFF2F2F2FFF2F2F2FFF1F1
          F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFFDFDFDFF585858FF000000000000
          00005E5E5EFFFDFDFDFFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FFF1F1F1FFF0F0
          F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFFDFDFDFF5E5E5EFF000000000000
          0000636363FFFDFDFDFFF2F2F2FFF1F1F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEF
          EFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFFDFDFDFF636363FF}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000001
          01010103030403080A0C050F131708181F250B2029310D242F380D242F380B20
          293108181F25050F131703080A0C010304050001010100000000000101010104
          0506040A0D1008161D220D25313A1337475518455A6B1B4D65781B4D65781845
          5A6B133747550D26323B08161D22040A0D10010405060001010101030304040A
          0D1008182026102F3D491A4A6173257DA0BD29A0CAED29AAD6FA29AAD6FA29A0
          CAED257FA3C01A4A6173102F3D4909192127040A0D100103040503080A0C0816
          1D22102F3D491E5D788E2997C0E131BAE3FF3BC7EBFF40CEF0FF40CEF0FF3BC7
          EBFF32BBE3FF2997C0E11E5F7A91102F3D4908161D2203080A0C050E12160D25
          313A194960722999C2E13BC3E9FF4AD2F2FF4AD2F2FF4AD2F2FF4AD2F2FF4AD2
          F2FF4AD2F2FF3CC3EAFF2999C2E11A4A61730D26323B050F141808171E241336
          4654257CA0BA41BFE7FF55D4F3FF55D4F3FF55D4F3FF55D4F3FF55D4F3FF55D4
          F3FF55D4F3FF55D4F3FF3EBEE6FF2681A5C01337485608181F250B1F28301844
          596A2BA5D0EC58CFF0FF60D6F4FF60D6F4FF60D6F4FF60D6F4FF60D6F4FF60D6
          F4FF60D6F4FF60D6F4FF57CFF0FF2BA8D4F018465B6D0B202A320C232E371A4C
          63762BB3E1FA6FD7F4FF6CD8F4FF6CD8F4FF6CD8F4FF6CD8F4FF6CD8F4FF6CD8
          F4FF6CD8F4FF6CD8F4FF6FD9F4FF2BB6E5FD1B4E66790D25313A0C232E371A4C
          63762CB5E4FA8CDFF6FF77DAF5FF77DAF5FF77DAF5FF77DAF5FF77DAF5FF77DA
          F5FF77DAF5FF77DAF5FF8BDFF6FF2CB6E5FB1B4E66790D2530390B1F28301844
          596A2BA8D6EB9CE1F7FF82DCF6FF82DCF6FF82DCF6FF82DCF6FF82DCF6FF82DC
          F6FF82DCF6FF83DCF6FFA2E3F7FF2CABD9EE18455B6C0B20293108171D231335
          4653257EA1B758CBF2FFBEECFAFF8FDFF7FF8DDEF7FF8DDEF7FF8DDEF7FF8DDE
          F7FF8EDEF7FFBAEBFAFF55CBF2FF2682A6BC1337475508181F25050E12160D25
          303919485E702BA0CCDF7BD7F7FFD2F2FCFFB2E9FAFFA2E4F9FFA2E4F9FFB2E9
          FAFFD3F2FCFF7FD9F7FF2B9FCBDF19485E700D25313A050E12160207090B0715
          1B20102D3B461B50687B2B9FCBDD4ECBF6FFA3E4FAFFC8EEFCFFC8EEFCFFA3E4
          FAFF51CCF6FF2CA0CCDE1C526B7E102D3B4607151C210207090B01030304030A
          0D0F08171E240F2C3A4518465B6D247597AC2CA6D3E42DB7E7F42DB7E7F42CA6
          D3E4247698AD18465B6D0F2C3A4508181F25030A0D0F01030304000101010103
          040503090C0E07141A1F0C232E371233424F1741556519495F7119495F711741
          5565123343500C232E3707141A1F030A0D0F0103040500010101000000000001
          0101010303040206080A040D111407151C210A1D262D0C212C340C212C340A1D
          262D07151C21050E12150206080A010303040001010100000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000E4A34CB135E42FF135E42FF135E42FF135E42FF135E
          42FF135E42FF135E42FF135E42FF135E42FF135E42FF0F4D36D4000000000000
          00000000000000000000216D4FFFF6F9F8FFFFFFFFFFFFFFFFFFFBFDFDFFF5FB
          FAFFEFF9F6FFE8F6F2FFE0F3EEFFD9F1EBFFD4EFE8FF216D4FFF000000000000
          00000000000000000000307E5EFFF6F9F8FFFFFFFFFFF8FCFBFFEFF9F6FFE4F5
          F0FFD8F0E9FFCCEBE3FFC0E7DDFFB8E4D8FFD0EDE5FF317F5EFF000000000000
          0000000000000000000040906CFFF7FAF9FFF8FCFBFFEFF9F6FFE4F5F0FFD8F0
          E9FFCCEBE3FFC0E7DDFFB8E4D8FFB1E1D4FFD0EDE5FF41916DFF000000000000
          0000454545CB5A5A5AFF4FA07AFFFBFDFDFFF5FBFAFFEFF9F6FFE8F6F2FFE0F3
          EEFFD9F1EBFFD4EFE8FFD0EDE5FFD0EDE5FFD0EDE5FF4FA07AFF000000000000
          0000686868FFF9F9F9FF55A47FFF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF52A37DFF000000000000
          0000787878FFF9F9F9FF63AC8AFF93C6AEFF96C8B0FF96C8B0FF96C8B0FF96C8
          B0FF96C8B0FF96C8B0FF96C8B0FF96C8B0FF96C8B0FF4D9976F0000000000000
          0000888888FFF9F9F9FFACD3C0FF68B28EFF61AE89FF62AE89FF61AE89FF61AD
          89FF61AD88FF61AD88FF61AE89FF5CA884FF54A07BF02F5A45871D1D1D882626
          26AB959595FFFCFCFCFFF9F9F9FFF7F7F7FFF4F4F4FFF0F0F0FFEDEDEDFFEBEB
          EBFFE8E8E8FFE8E8E8FFE9E9E9FF9D9D9DFF0000000000000000303030ABA6A6
          A6AB999999FE9F9F9FFFA1A1A1FFA2A2A2FFA3A3A3FFA3A3A3FFA4A4A4FFA5A5
          A5FFA5A5A5FFA6A6A6FFA6A6A6FF9F9F9FFF00000000000000003A3A3AABA6A6
          A6AB9A9A9AF7C1C1C1FFC4C4C4FFC5C5C5FFC5C5C5FFC6C6C6FFC7C7C7FFC7C7
          C7FFC7C7C7FFC7C7C7FFC8C8C8FF979797F00000000000000000464646ABA6A6
          A6ABA2A2A2D49F9F9FF79F9F9FFAA0A0A0FAA1A1A1FAA1A1A1FAA2A2A2FAA2A2
          A2FAA3A3A3FAA0A0A0FA9B9B9BF0565656870000000000000000505050ABA9A9
          A9ABA6A6A6ABA4A4A4ABA0A0A0AB9C9C9CAB9A9A9AAB979797AB959595AB9595
          95AB959595AB505050AB00000000000000000000000000000000525252A95757
          57AB575757AB575757AB575757AB575757AB575757AB575757AB575757AB5757
          57AB575757AB525252AB000000000000000000000000000000004A4A4A9A7373
          73AB757575AB757575AB757575AB757575AB757575AB757575AB757575AB7575
          75AB757575AB4D4D4DA1000000000000000000000000000000002A2A2A544E4E
          4E9A525252A2515151A1515151A1515151A1515151A1515151A1515151A15151
          51A1515151A12E2E2E5B00000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000202111E09094C870F0F7BDB11118FFF11118FFF0F0F
          7CDE09094F8D0202142400000000000000000000000000000000000000000000
          000000000000090A4E8A121596FF1120AAFF1128B9FF112CC0FF112CC0FF1129
          BAFF1120ABFF121697FF090A508D000000000000000000000000000000000000
          0000090B5696111DA4FF1430C1FF1431C3FF1431C3FF1431C3FF1431C3FF1431
          C3FF1431C3FF1430C1FF121EA6FF090B5696000000000000000000000000090A
          518A1420A7FF1736C6FF1736C6FF1736C6FF1736C6FF1736C6FF1736C6FF1736
          C6FF1736C6FF1736C6FF1736C6FF1421A9FF090A5590000000000202101B171C
          A0FF1A3AC8FF1A3CCAFF5F77DAFFFFFFFFFF5F77DAFF1A3CCAFF1A3CCAFF5F77
          DAFFFFFFFFFF5F77DAFF1A3CCAFF1A3BC9FF161C9FFF0303192A080A51842235
          B8FF1E43CEFF1E43CEFFFFFFFFFFFFFFFFFFFFFFFFFF627CDDFF627CDDFFFFFF
          FFFFFFFFFFFFFFFFFFFF1E43CEFF1E43CEFF2136BBFF090B5A930C1082CF2242
          C9FF2249D2FF2249D2FF4448B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF4448B7FF2249D2FF2249D2FF2243CCFF0D1189DB0E139BF32950
          D4FF2751D6FF2751D6FF2751D6FF4448B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF4448B7FF2751D6FF2751D6FF2751D6FF2952D5FF0F149FF90E14A2F93E66
          DDFF2B58DBFF2B58DBFF2B58DBFF6B8AE6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF6B8AE6FF2B58DBFF2B58DBFF2B58DBFF3B64DDFF0E14A2F90B118ACF5270
          DCFF2F5EDFFF2F5EDFFF6E8FE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF6E8FE9FF2F5EDFFF2F5EDFFF5473DDFF0C128ED5070B5A845264
          D0FF3A6AE4FF3365E3FFFFFFFFFFFFFFFFFFFFFFFFFF4448B7FF4448B7FFFFFF
          FFFFFFFFFFFFFFFFFFFF3365E3FF3869E4FF5062D0FF070B5A840102131B1721
          B5FF7495EBFF386CE7FF4448B7FFFFFFFFFF4448B7FF366BE7FF366BE7FF4448
          B7FFFFFFFFFF4448B7FF366BE7FF7396ECFF1C27B7FF0102131B00000000070B
          5D843948C7FF7FA2F1FF3F74EBFF151AA5FF3970EAFF3970EAFF3970EAFF3970
          EAFF151AA5FF3E73EAFF7CA0F1FF3E4DCAFF070C618A00000000000000000000
          0000070D68933545C7FF8FACF1FF709AF2FF5B8BF0FF477DEEFF477DEEFF5A8A
          F0FF6E98F2FF8FADF2FF3C4DCAFF070E6A960000000000000000000000000000
          000000000000060C61871623BCFF5165D5FF7088E3FF8EA9EFFF8FABF0FF728A
          E3FF5569D7FF1825BCFF060C638A000000000000000000000000000000000000
          0000000000000000000001020D12060B577808107EAE0B14A3E10B15A5E40810
          80B1060B5B7E01020F1500000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000542618968E4129FF8E4129FF8E4129FF8E4129FF8E4129FF8E4129FF8E41
          29FF8E4129FF8E4129FF8E4129FF8E4129FF8E4129FF54261896000000000000
          000090442BFFFDF7F4FFFDF7F3FFFDF7F3FFFDF7F2FFFDF6F1FFFCF6F1FFFCF5
          F0FFFCF5EFFFFCF4EFFFFBF3EEFFFBF3EDFFFBF2ECFF90442BFF000000000000
          0000806156FF727272FFAAA59FFFFAEBDEFFAAA39DFF727272FFAAA19BFFF8E3
          D2FFF6E0CEFFF5DECBFFF4DCC7FFF3D9C3FFFBF1EBFF93482EFF000000004747
          4796797979FFF3F3F3FF797979FFFAE9DBFF797979FFF3F3F3FF797979FFACA3
          9CFFF5DECBFFF4DCC7FFF3D9C3FFF2D6C0FFFBF1EAFF974C31FF4C4C4C968282
          82FFF0F0F0FF828282FFB3ACA7FFF9E7D8FFB3ABA4FF828282FFF0F0F0FF8282
          82FFB1A79EFFF3D9C3FFF2D6C0FFF1D4BCFFFAF1E9FF9A5034FF8B8B8BFFF7F7
          F7FF8B8B8BFFBAB7B5FFF9E7D8FFF9E5D5FFF8E3D2FFB7AEA7FF8B8B8BFFF7F7
          F7FF8B8B8BFFF2D6C0FFF1D4BBFFF0D2B9FFFAF0E8FF9E5537FF575757969494
          94FFF9F9F9FF949494FFBEB5AFFFF8E3D2FFBCB3ACFF949494FFF9F9F9FF9494
          94FFBBAFA6FFF1D4BBFFF0D2B8FFF0CFB5FFFAEFE7FFA25A3BFF000000005C5C
          5C969C9C9CFFFCFCFCFF9C9C9CFFF6E0CEFF9C9C9CFFFCFCFCFF9C9C9CFFBFB4
          ABFFF1D4BBFFF0D2B8FFF0CFB4FFEFCCB1FFF9EFE7FFA65F3FFF000000000000
          0000A5887AFFA1A1A1FFC4BBB4FFF5DECBFFC3B9B1FFA1A1A1FFC2B7AEFFF1D4
          BBFFF0D2B8FFF0CFB4FFEFCCB0FFEDCBAEFFF9EEE5FFAA6442FF000000000000
          0000AE6946FFFCF4EFFFF5DECBFFF4DCC7FFF3D9C3FFF2D6C0FFF1D4BBFFF0D2
          B8FFF0CFB4FFEFCCB0FFEDCBADFFECC8AAFFF9EEE5FFAE6946FF000000000000
          0000B26E49FFFBF3EEFFF4DCC7FFF3D9C3FFF2D6C0FFF1D4BBFFF0D2B8FFF0CF
          B4FFF7E7DBFFD29D79FFD29C77FFD5A584FFD4A484FFB26E49FF000000000000
          0000B5724CFFFBF3EDFFF3D9C3FFF2D6C0FFF1D4BBFFF0D2B8FFF0CFB4FFEFCC
          B0FFF7E7D9FFC07F56FFC07F56FFC07F56FFB5724CFF6A432D96000000000000
          0000B9764FFFFBF2ECFFF2D6C0FFF1D4BBFFF0D2B8FFF0CFB4FFEFCCB0FFEDCB
          ADFFF6E5D8FFC07F56FFC07F56FFB9764FFF6D452E9600000000000000000000
          0000BC7A52FFFBF1EBFFF1D4BCFFF0D2B9FFF0CFB5FFEFCCB1FFEDCBAEFFECC8
          AAFFF9EEE5FFC07F56FFBC7A52FF6F4830960000000000000000000000000000
          0000BE7D54FFFBF1EAFFFAF1E9FFFAF0E8FFFAEFE7FFF9EFE7FFF9EEE5FFF9EE
          E5FFF9EDE4FFBE7D54FF704A3196000000000000000000000000000000000000
          0000714B3396C07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F
          56FFC07F56FF714B339600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000063323960C57
          3CFF0C573CFF0C573CFF0C573CFF0C573CFF0C573CFF0C573CFF0C573CFF0C57
          3CFF0C573CFF0C573CFF0C573CFF0C573CFF0633239600000000105B3FFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF105B3FFF00000000196548FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF196548FF000000001F6B4DFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF1F6B4DFF00000000257253FFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF257253FF000000002B7858FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF2B7858FF00000000317F5EFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF317F5EFF00000000378664FFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF378664FF000000003D8C69FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF3D8C69FF0000000043936FFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFF
          FFFFFFFFFFFFCCCCCCFFFFFFFFFFFFFFFFFF43936FFF00000000499974FFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCC
          CCFFCCCCCCFFCCCCCCFFCCCCCCFFCCCCCCFF499974FF000000004E9E79FF3381
          5FFF33815FFF33815FFF33815FFF33815FFF33815FFF33815FFF33815FFF3381
          5FFF33815FFF33815FFF33815FFF33815FFF4E9E79FF0000000052A37DFF56A7
          80FF56A780FF56A780FF56A780FF56A780FF56A780FF56A780FF56A780FF56A7
          80FF56A780FF56A780FF56A780FF56A780FF52A37DFF0000000056A780FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF56A780FF0000000034634C9659AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF34634C9600000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000030406023D
          5B7B036DA2DB047FBDFF047FBDFF047FBDFF047FBDFF047FBDFF047FBDFF047F
          BDFF047FBDFF047FBDFF2791C6FF012A3E5400000000000000000246698D2493
          C8FF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5
          EDFF8ED5EDFF2493C8FF4CABD6FF0479B4F3000D141B00000000036DA2DB8ED5
          EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5EDFF8ED5
          EDFF2493C8FF4CABD6FFB1EBF8FF2894C8FF0246698D000000000479B4F3DAF4
          FBFFDFF7FCFFDAF4FBFFDAF4FBFFDAF4FBFFDAF4FBFFDAF4FBFFDAF4FBFFDAF4
          FBFF1085C0FF4AD1F1FFA1E7F8FF7DC9E5FF036FA5DE00000000047FBDFF047F
          BDFF047FBDFF047FBDFF047FBDFF047FBDFF047FBDFF047FBDFF047FBDFF047F
          BDFF2791C6FF52D3F1FF60D6F2FFB0E7F5FF047FBDFF00000000000000000000
          00000000000001151F2A1285BFFCBBEDF9FF5FD6F2FF5BD5F2FF5BD5F2FF5BD5
          F2FF5BD5F2FF5BD5F2FF63D7F3FFBFECF9FF0479B4F300000000000000000000
          00000000000003557FAB73C1E1FFC1EFFAFF65D8F2FF65D8F2FF65D8F2FF65D8
          F2FF65D8F2FF65D8F2FF93E4F6FFA5D8EDFF036191C300000000000000000000
          0000011824302692C7FFC3EFF9FF72DBF3FF6FDAF3FF6FDAF3FF6FDAF3FF6FDA
          F3FF6FDAF3FF6FDAF3FFC9F1FAFF5BAED6FF012E455D00000000000000000000
          0000024B6F967CC4E2FFBDEEF9FF79DDF3FF79DDF3FF79DDF3FF79DDF3FF79DD
          F3FF79DDF3FF9BE6F6FFC2E8F5FF0976AEE80003040600000000000000000000
          00000470A7E1BCE9F6FF91E3F5FF83DFF4FF83DFF4FF83DFF4FF83DFF4FF83DF
          F4FF83DFF4FFCDF2FBFF5CAED6FF023A57750000000000000000000000000000
          0000047FBDFFD2F3FBFF8FE2F4FF8DE2F4FF8DE2F4FF8DE2F4FF8DE2F4FF8DE2
          F4FF8DE2F4FFD1F3FBFF1789C2FF000F161E0000000000000000000000000000
          0000047CB9F9D2F1F9FF9BE5F6FF96E4F5FF96E4F5FF96E4F5FF96E4F5FF96E4
          F5FF98E4F5FFD5F4FBFF047CB9F9000000000000000000000000000000000000
          0000036DA2DBB6DEEFFFB9EDF8FF9FE6F5FF9FE6F5FF9FE6F5FF9FE6F5FF9FE6
          F5FF9FE6F5FFD9F5FBFF0F85C0FF000000000000000000000000000000000000
          000002496D935CAED5FFE4F8FCFFAEEAF6FFA7E8F5FFA7E8F5FFA7E8F5FFA7E8
          F5FFA7E8F5FFDBF6FBFF3399CAFF418DB3FF458EB2FF4287AAF3000000000000
          0000000D141B0476B0ED81C1DFFFEAF8FBFFF0FBFDFFF0FBFDFFF0FBFDFFF0FB
          FDFFF0FBFDFFF0FBFDFF9FD1E7FF398EB8FF458EB2FF30637CB1000000000000
          00000000000001151F2A03557FAB047FBDFF047FBDFF047FBDFF047FBDFF047F
          BDFF047FBDFF047FBDFF047FBDFF1181BAFE2E789EDE0B171D2A}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00002F2F2F96505050FF505050FF505050FF505050FF505050FF505050FF5050
          50FF505050FF505050FF505050FF505050FF505050FF2F2F2F96000000000000
          0000545454FFFFFFFFFFFDFDFDFFE2BA9CFFC36F2FFFE5C3A8FFFDFDFDFFFDFD
          FDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFFFFFFFF545454FF000000000000
          0000585858FFFDFDFDFFEFE9E3FFC87A3EFFD0905FFFF2F2F2FFF2F2F2FFF1F1
          F1FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFFDFDFDFF585858FF000000000000
          00005E5E5EFFFDFDFDFFE0BDA1FFCA7B3DFFE6CEBBFFF1F1F1FFF1F1F1FFF0F0
          F0FFF0F0F0FFEFEFEFFFEFEFEFFFEEEEEEFFFDFDFDFF5E5E5EFF424242967070
          70FF6B6B6BFFFDFDFDFFD69C6EFFD28F59FFF1F0EFFFF0F0F0FFF0F0F0FFEFEF
          EFFFEFEFEFFFEEEEEEFFEEEEEEFFEDEDEDFFFDFDFDFF636363FF757575FFF9F9
          F9FF757575FFFDFDFDFFD49058FFDDAE87FFF0F0F0FFEFEFEFFFEFEFEFFFEEEE
          EEFFEEEEEEFFEDEDEDFFEDEDEDFFECECECFFFDFDFDFF6A6A6AFF484848967A7A
          7AFF6E6E6EFFD8D8D8FFD7945BFFDFB490FFEFEFEFFFEEEEEEFFEEEEEEFFEDED
          EDFFEDEDEDFFECECECFFE5D2C1FFEBEBEBFFFDFDFDFF707070FF000000000000
          0000727272FF737373FFC39E7CFFDC9F6AFFEBE5E0FFEDEDEDFFECECECFFECEC
          ECFFE6D4C3FFDEAD81FFDA985EFFEAEAEAFFFDFDFDFF777777FF000000000000
          00007D7D7DFFDCDCDCFF787675FFC5956BFFDFA46FFFE3BA95FFE2B48AFFDFA6
          73FFDE9F66FFDEA068FFE3BD9CFFE9E9E9FFFDFDFDFF7D7D7DFF000000000000
          0000848484FFFDFDFDFFD1D1D1FF80807FFFCBAA8CFFE2A975FFE1A670FFE3B2
          85FFE5C6AAFFE7E0D9FFE8E8E8FFE7E7E7FFFDFDFDFF848484FF000000000000
          00008A8A8AFFFDFDFDFFEBEBEBFFD2D2D2FF878787FFD0D0D0FFE9E9E9FFE8E8
          E8FFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF8A8A8AFF000000000000
          0000909090FFFDFDFDFFEAEAEAFFE9E9E9FFD3D3D3FF949494FF999999FFB9B9
          B9FFFDFDFDFFE0E0E0FFE5E5E5FFEBEBEBFF909090FF55555596000000000000
          0000959595FFFDFDFDFFE9E9E9FFE8E8E8FFE8E8E8FF9D9D9DFFFCFCFCFF9D9D
          9DFFFDFDFDFFE5E5E5FFEBEBEBFF959595FF5858589600000000000000000000
          00009A9A9AFFFDFDFDFFE8E8E8FFE7E7E7FFE7E7E7FFBDBDBDFFA1A1A1FFBDBD
          BDFFFDFDFDFFEBEBEBFF9A9A9AFF5B5B5B960000000000000000000000000000
          00009E9E9EFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFD
          FDFFFDFDFDFF9E9E9EFF5D5D5D96000000000000000000000000000000000000
          00005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FF5F5F5F9600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000003120C320F5B3FFF126244FF0520165A000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000004150E36176346FF29855FFF449C77FF3D7F65FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000007171138216D4FFF368F6BFF52A583FF98C5B2FF256F52FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00002B7859FF459A79FF63B092FF9EC9B8FF357E61FF0A1E1643000000000000
          00000000000017171748383838B1484848E7484848E7383838B1171717489898
          98FF56A688FF74BAA0FFA3CDBDFF3D8768FF0C20184100000000000000000909
          091B333333967F7F7FFFC9C9C9FFECECECFFECECECFFC9C9C9FF7F7F7FFF5757
          57EA4E4E4ED0AAD2C2FF45906FFF0E21193D0000000000000000000000003636
          3696AEAEAEFFFAFAFAFFF8F8F8FFF4F4F4FFF4F4F4FFF8F8F8FFFAFAFAFFA9A9
          A9FF575757E9989898FF000000000000000000000000000000002323235A9393
          93FFF8F8F8FFEEEEEEFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEFEFEFFFF6F6
          F6FF888888FF2323235A00000000000000000000000000000000525252C3D6D6
          D6FFEEEEEEFFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFF0F0
          F0FFD6D6D6FF525252C300000000000000000000000000000000707070F9F1F1
          F1FFE0E0E0FFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFE1E1
          E1FFEFEFEFFF6E6E6EF300000000000000000000000000000000787878F9F1F1
          F1FFDCDCDCFFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7D7FFDDDD
          DDFFEDEDEDFF747474F000000000000000000000000000000000646464C3DBDB
          DBFFE4E4E4FFD0D0D0FFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFD1D1D1FFE8E8
          E8FFDCDCDCFF646464C3000000000000000000000000000000003131315AB1B1
          B1FFF3F3F3FFD6D6D6FFCCCCCCFFCACACAFFCACACAFFCCCCCCFFD8D8D8FFF3F3
          F3FFA6A6A6FF3131315A00000000000000000000000000000000000000005555
          5596CCCCCCFFF4F4F4FFE6E6E6FFD9D9D9FFD9D9D9FFE6E6E6FFF4F4F4FFC7C7
          C7FF555555960000000000000000000000000000000000000000000000001717
          172759595996B8B8B8FFDFDFDFFFF1F1F1FFF1F1F1FFDFDFDFFFB8B8B8FF5959
          59961010101B0000000000000000000000000000000000000000000000000000
          00000000000034343454737373BA929292ED929292ED737373BA343434540000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000414141966F6F6FFF414141960000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000042424296717171FFD7D7D7FF717171FF4242429600000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000747474FFE2E2E2FFD9D9D9FFE2E2E2FF747474FF00000000464646967777
          77FF777777FF777777FF777777FF777777FF777777FF777777FF777777FF7777
          77FF777777FF777777FFD5D5D5FF777777FF777777FF464646967B7B7BFFDEDE
          DEFFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3
          D3FFD3D3D3FFD3D3D3FFD3D3D3FFD3D3D3FFDEDEDEFF7B7B7BFF7F7F7FFFE1E1
          E1FFD7D7D7FFB8B8B8FF777777FFB8B8B8FFD7D7D7FFD7D7D7FFD7D7D7FFD7D7
          D7FFB8B8B8FF777777FFB8B8B8FFD7D7D7FFE1E1E1FF7F7F7FFF838383FFE5E5
          E5FFDCDCDCFF777777FFDCDCDCFF777777FFDCDCDCFFDCDCDCFFDCDCDCFFDCDC
          DCFFDCDCDCFFDCDCDCFF777777FFDCDCDCFFE5E5E5FF838383FF878787FFE8E8
          E8FFE0E0E0FF777777FFE0E0E0FF777777FFE0E0E0FF777777FF777777FFE0E0
          E0FFCCCCCCFF777777FF777777FFE0E0E0FFE8E8E8FF878787FF8B8B8BFFECEC
          ECFFE5E5E5FF777777FFE5E5E5FF777777FFE5E5E5FFE5E5E5FFE5E5E5FFE5E5
          E5FF777777FFE5E5E5FF777777FFE5E5E5FFECECECFF8B8B8BFF8F8F8FFFEFEF
          EFFFE9E9E9FFCCCCCCFF777777FFCCCCCCFFE9E9E9FFE9E9E9FFE9E9E9FFE9E9
          E9FFCCCCCCFF777777FFCCCCCCFFE9E9E9FFEFEFEFFF8F8F8FFF939393FFF5F5
          F5FFF1F1F1FFF0F0F0FFF1F1F1FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2
          F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF5F5F5FF939393FF969696FFFBFB
          FBFFF7F7F7FFF5F5F5FFF7F7F7FFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
          FBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFCFCFCFF969696FF5A5A5A969999
          99FF999999FFF8F8F8FF999999FF999999FF999999FF999999FF999999FF9999
          99FF999999FF999999FF999999FF999999FF999999FF5A5A5A96000000009C9C
          9CFFFDFDFDFFFCFCFCFFFDFDFDFF9C9C9CFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005E5E
          5E969F9F9FFFFEFEFEFF9F9F9FFF5E5E5E960000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00005F5F5F96A1A1A1FF5F5F5F96000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000333333955757
          57FE575757FF575757FF575757FF33333396575757FF575757FF575757FF5757
          57FF33333396575757FF575757FF575757FF575757FF33333396656565FEB2B2
          B2FF989898FF989898FFB2B2B2FF656565FFB2B2B2FF989898FF989898FFB2B2
          B2FF656565FFB2B2B2FF989898FF989898FFB2B2B2FF656565FF777777FFBFBF
          BFFFAAAAAAFFAAAAAAFFBFBFBFFF777777FFBFBFBFFFAAAAAAFFAAAAAAFFBFBF
          BFFF777777FFBFBFBFFFAAAAAAFFAAAAAAFFBFBFBFFF777777FF888888FFD9D9
          D9FFCCCCCCFFCCCCCCFFD9D9D9FF888888FFD9D9D9FFCCCCCCFFCCCCCCFFD9D9
          D9FF888888FFD9D9D9FFCCCCCCFFCCCCCCFFD9D9D9FF888888FF979797FFF4F4
          F4FFF1F1F1FFF1F1F1FFF4F4F4FF979797FFF4F4F4FFF1F1F1FFF1F1F1FFF4F4
          F4FF979797FFF4F4F4FFF1F1F1FFF1F1F1FFF4F4F4FF979797FF5F5F5F96A1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FF5F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F96000000000000
          0000888888FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000888888FF0000000000000000000000000000
          00006B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B
          6BFF6B6B6BFF6B6B6BFF6B6B6BFF6B6B6BFF0000000000000000000000000000
          00000000000000000000000000000000000000000000555555FF555555FF0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000032323296555555FF555555FF555555FF5555
          55FF323232960000000000000000000000000000000000000000000000000000
          0000000000000000000000000000616161FFB0B0B0FF959595FF959595FFB0B0
          B0FF616161FF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000006F6F6FFFB9B9B9FFA2A2A2FFA2A2A2FFB9B9
          B9FF6F6F6FFF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000007E7E7EFFC5C5C5FFB1B1B1FFB1B1B1FFC5C5
          C5FF7E7E7EFF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000008C8C8CFFDBDBDBFFCECECEFFCECECEFFDBDB
          DBFF8C8C8CFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000989898FFF4F4F4FFF1F1F1FFF1F1F1FFF4F4
          F4FF989898FF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000005F5F5F96A1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FF5F5F5F960000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000424242967171
          71FF717171FF717171FF717171FF717171FF717171FF717171FF717171FF7171
          71FF717171FF717171FF717171FF717171FF717171FF42424296777777FFF4F4
          F4FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0
          F0FFF0F0F0FFF0F0F0FFF0F0F0FFF0F0F0FFF4F4F4FF777777FF7F7F7FFFF4F4
          F4FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8
          E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF7F7F7FFF878787FFF4F4
          F4FF717171FF717171FFE8E8E8FF717171FF717171FFE8E8E8FF717171FF7171
          71FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF878787FF8F8F8FFFF4F4
          F4FF717171FF717171FFE8E8E8FF717171FF717171FFE8E8E8FF717171FF7171
          71FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFF4F4F4FF8F8F8FFF969696FFF7F7
          F7FFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEE
          EEFFEEEEEEFFEEEEEEFFEEEEEEFFEEEEEEFFF7F7F7FF969696FF9C9C9CFFFCFC
          FCFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFB
          FBFFFBFBFBFFFBFBFBFFFBFBFBFFFBFBFBFFFCFCFCFF9C9C9CFF5F5F5F96A1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F96000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          200000000000000400000000000000000000000000000000000000000000011C
          2A39000407090000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000011C2A39349A
          CBFF0B83BFFF011F2F3F00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000407090C83
          BFFF8DCBE6FF2F9ACCFF024B6F960116212D0000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000011E
          2C3C1689C2FFBEE8F5FF6ABFE0FF0C84C0FF023C597800000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000023D5B7B2A94C8FFC3ECF7FF9EDFF2FF359ECEFF024F769F011B28360000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000243648744A2D0FFC9F1FBFFB2ECFAFF70C3E3FF0F85C1FF023D
          5B7B000000000000000000000000000000000000000000000000000000000000
          0000000000000000000002496D935DB0D7FFC4F1FBFFB3EDFAFFA0E1F4FF3CA2
          D0FF03547DA8011F2F3F00000000000000000000000000000000000000000115
          1F2A024B6F96047FBDFF047FBDFF047FBDFF6BC0E1FFA1E9F9FF81E2F7FFB3ED
          FAFF77C7E5FF1388C2FF02406081000000000000000000000000000000000249
          6D9381C4E2FFBCF0FAFFB5EEFAFFB5EEFAFFB5EEFAFF45D4F3FF45D4F3FF45D4
          F3FFB5EEFAFFA6E5F5FF40A5D2FF035781AE0122334500000000000000000115
          1F2A0982BFFFB4E2F2FFA6EBFAFF4AD7F4FF47D6F4FF47D6F4FF47D6F4FF47D6
          F4FFC5F3FCFFDEF8FDFFDEF8FDFF99D2E9FF1B8CC4FF000D141B000000000000
          00000236506C2893C8FFC8F1FBFF6EDFF6FF49D7F4FF49D7F4FF49D7F4FFA2EB
          F9FF6FC2E2FF047FBDFF047FBDFF035781AE0122334500000000000000000000
          00000000000002486B9061B2D8FFC3F2FCFF4BD8F5FF4BD8F5FF4BD8F5FF4BD8
          F5FFB7EFFBFF74C5E4FF0680BEFF011B28360000000000000000000000000000
          00000000000000010203035A85B49CD4EAFFBCF1FBFF4DD9F5FF4DD9F5FF4DD9
          F5FF4DD9F5FFB8F0FBFF74C5E4FF0680BEFF011E2C3C00000000000000000000
          000000000000000000000125384B1689C2FFC1EBF7FF93E8F9FF52DBF6FF52DB
          F6FF52DBF6FF52DBF6FFB9F0FBFF79C8E5FF0680BEFF01213142000000000000
          0000000000000000000000000000023F5D7E3FA0CEFFDFF9FDFFDFF9FDFFDFF9
          FDFFDFF9FDFFDFF9FDFFDFF9FDFFDFF9FDFF97D1E8FF0780BEFF000000000000
          000000000000000000000000000000000000024B6F96047FBDFF047FBDFF047F
          BDFF047FBDFF047FBDFF047FBDFF047FBDFF03557FAB01213142}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000012435480007
          0B0F542618968E4129FF8E4129FF8E4129FF8E4129FF8E4129FF8E4129FF8E41
          29FF8E4129FF8E4129FF8E4129FF8E4129FF8E4129FF5426189640A1CFFF0F86
          C1FF655658FFFDF7F4FFFDF7F3FFFDF7F3FFFDF7F2FFFDF6F1FFFCF6F1FFFCF5
          F0FFFCF5EFFFFCF4EFFFFBF3EEFFFBF3EDFFFBF2ECFF90442BFF0C83BFFF9AD3
          EAFF359ECEFF68AFD3FFCDD8D9FFFAEBDEFFFAE9DBFFF9E7D8FFF9E5D5FFF8E3
          D2FFF6E0CEFFF5DECBFFF4DCC7FFF3D9C3FFFBF1EBFF93482EFF01273A4E2290
          C6FFC2ECF7FF6CC0E1FF0C84C0FF89B8CDFFF9E7D8FFF9E5D5FFF8E3D2FFF6E0
          CEFFF5DECBFFF4DCC7FFF3D9C3FFF2D6C0FFFBF1EAFF974C31FF000000000243
          648749A5D1FFC7F2FBFF9CDFF2FF339DCEFF66A8C7FFCAD0CEFFF6E0CEFFF5DE
          CBFFF4DCC7FFF3D9C3FFF2D6C0FFF1D4BCFFFAF1E9FF9A5034FF012D435A0361
          91C3047FBDFF61B9DDFFB0ECFAFFB4EDFAFF6EC1E2FF0D84C0FF86B2C5FFF4DC
          C7FFF3D9C3FFF2D6C0FFF1D4BBFFF0D2B9FFFAF0E8FF9E5537FF0780BEFFA7DB
          EEFFB8F0FBFFB5EFFBFF55D9F5FF5DDBF5FFCAF3FCFFC2E8F5FF3A9DCDFFB8C3
          C2FFF2D6C0FFF1D4BBFFF0D2B8FFF0CFB5FFFAEFE7FFA25A3BFF012D435A1B8C
          C4FFC2EBF8FF8DE6F9FF4BD8F5FFB7EFFBFF5CB6DCFF238BBEFF85B0C0FFF2D6
          C0FFF1D4BBFFF0D2B8FFF0CFB4FFEFCCB1FFF9EFE7FFA65F3FFF000000000240
          608142A1CFFFCBF4FCFF5EDDF6FF63DEF6FFB8F0FBFF5DB7DCFF66A3BEFFE0CE
          BBFFF0D2B8FFF0CFB4FFEFCCB0FFEDCBAEFFF9EEE5FFAA6442FF000000000000
          00004A768CFF75BEDEFFDFF9FDFFDFF9FDFFDFF9FDFFDFF9FDFF6EBADCFF7EAA
          BAFFF0CFB4FFEFCCB0FFEDCBADFFECC8AAFFF9EEE5FFAE6946FF000000000000
          0000A07055FF6AAFD1FF047FBDFF047FBDFF047FBDFF047FBDFF65A1BBFFDFC9
          B5FFF7E7DBFFD29D79FFD29C77FFD5A584FFD4A484FFB26E49FF000000000000
          0000B5724CFFFBF3EDFFF3D9C3FFF2D6C0FFF1D4BBFFF0D2B8FFF0CFB4FFEFCC
          B0FFF7E7D9FFC07F56FFC07F56FFC07F56FFB5724CFF6A432D96000000000000
          0000B9764FFFFBF2ECFFF2D6C0FFF1D4BBFFF0D2B8FFF0CFB4FFEFCCB0FFEDCB
          ADFFF6E5D8FFC07F56FFC07F56FFB9764FFF6D452E9600000000000000000000
          0000BC7A52FFFBF1EBFFF1D4BCFFF0D2B9FFF0CFB5FFEFCCB1FFEDCBAEFFECC8
          AAFFF9EEE5FFC07F56FFBC7A52FF6F4830960000000000000000000000000000
          0000BE7D54FFFBF1EAFFFAF1E9FFFAF0E8FFFAEFE7FFF9EFE7FFF9EEE5FFF9EE
          E5FFF9EDE4FFBE7D54FF704A3196000000000000000000000000000000000000
          0000714B3396C07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F56FFC07F
          56FFC07F56FF714B339600000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000545454FF545454FF545454FF545454FF545454FF545454FF545454FF5454
          54FF545454FF545454FF545454FF545454FF545454FF00000000000000000000
          0000595959FF0000000000000000595959FF0000000000000000595959FF0000
          000000000000595959FF0000000000000000595959FF00000000000000000000
          00005F5F5FFF00000000000000005F5F5FFF00000000000000005F5F5FFF0000
          0000000000005F5F5FFF00000000000000005F5F5FFF00000000000000000000
          0000666666FF666666FF666666FF666666FF666666FF666666FF666666FF6666
          66FF666666FF666666FF666666FF666666FF666666FF00000000000000000000
          00006D6D6DFF00000000000000006D6D6DFF00000000000000006D6D6DFF0000
          0000000000006D6D6DFF00000000000000006D6D6DFF00000000000000000000
          0000757575FF0000000000000000757575FF0000000000000000757575FF0000
          000000000000757575FF0000000000000000757575FF00000000000000000000
          00007C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C
          7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF00000000000000000000
          0000848484FF0000000000000000848484FF0000000000000000848484FF0000
          000000000000848484FF0000000000000000848484FF00000000000000000000
          00008B8B8BFF00000000000000008B8B8BFF00000000000000008B8B8BFF0000
          0000000000008B8B8BFF00000000000000008B8B8BFF00000000000000000000
          0000929292FF929292FF929292FF929292FF929292FF929292FF929292FF9292
          92FF929292FF929292FF929292FF929292FF929292FF00000000000000000000
          0000989898FF0000000000000000989898FF0000000000000000989898FF0000
          000000000000989898FF0000000000000000989898FF00000000000000000000
          00009D9D9DFF00000000000000009D9D9DFF00000000000000009D9D9DFF0000
          0000000000009D9D9DFF00000000000000009D9D9DFF00000000000000000000
          0000A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000111111216161
          61C0818181FF646464C612121224000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000797979E3C2C2
          C2FFE8E8E8FFC5C5C5FF878787FF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C
          7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF49494996959595FFF2F2
          F2FFA7A7A7FFF5F5F5FF979797FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0
          E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FF919191FF8A8A8ADECDCD
          CDFFF8F8F8FFD0D0D0FFA0A0A0FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF5F5F5F96101010186F6F
          6FAB8E8E8EDB6F6F6FAB10101018000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000545454FF545454FF545454FF545454FF545454FF545454FF545454FF5454
          54FF545454FF545454FF545454FF545454FF545454FF00000000000000000000
          0000595959FF0000000000000000595959FF0000000000000000595959FF0000
          000000000000595959FF0000000000000000595959FF00000000000000000000
          00005F5F5FFF00000000000000005F5F5FFF00000000000000005F5F5FFF0000
          0000000000005F5F5FFF00000000000000005F5F5FFF00000000000000000000
          0000666666FF666666FF666666FF666666FF666666FF666666FF666666FF6666
          66FF666666FF666666FF666666FF666666FF666666FF00000000000000000000
          00006D6D6DFF00000000000000006D6D6DFF00000000000000006D6D6DFF0000
          0000000000006D6D6DFF00000000000000006D6D6DFF00000000000000000000
          0000757575FF0000000000000000757575FF0000000000000000757575FF0000
          000000000000757575FF0000000000000000757575FF00000000000000000000
          00007C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C
          7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF7C7C7CFF00000000000000000000
          0000848484FF0000000000000000848484FF0000000000000000848484FF0000
          000000000000848484FF0000000000000000848484FF00000000000000000000
          00008B8B8BFF00000000000000008B8B8BFF00000000000000008B8B8BFF0000
          0000000000008B8B8BFF00000000000000008B8B8BFF00000000000000000000
          0000929292FF929292FF929292FF929292FF929292FF929292FF929292FF9292
          92FF929292FF929292FF929292FF929292FF929292FF00000000000000000000
          0000989898FF0000000000000000989898FF0000000000000000989898FF0000
          000000000000989898FF0000000000000000989898FF00000000000000000000
          00009D9D9DFF00000000000000009D9D9DFF00000000000000009D9D9DFF0000
          0000000000009D9D9DFF00000000000000009D9D9DFF00000000000000000000
          0000A1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1
          A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FFA1A1A1FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000005555
          55FF555555FF00000000555555FF555555FF00000000555555FF555555FF0000
          0000555555FF555555FF00000000555555FF555555FF00000000000000005959
          59FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000595959FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006161
          61FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000616161FF00000000000000006565
          65FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000656565FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000006F6F
          6FFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000006F6F6FFF00000000000000007474
          74FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000747474FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007D7D
          7DFF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000007D7D7DFF00000000000000008282
          82FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000828282FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000008989
          89FF000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000898989FF00000000000000008B8B
          8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF0000
          00008B8B8BFF8B8B8BFF000000008B8B8BFF8B8B8BFF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFE5D9B6FFE5D9B6FFEBF8F5FFE5D9B6FFE5D9B6FFE9F7F3FFE5D9B6FFE5D9
          B6FFE5F5F1FFE5D9B6FFE5D9B6FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFFEBB060FFEBB060FFF6FBFAFFEBB060FFEBB060FFE8F6F2FFEBB060FFEBB0
          60FFD8F0E9FFEBB060FFEBB060FFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0
          E9FFD2EEE6FFCDECE4FFC8EAE1FFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFFEBB060FFEBB060FFEDF8F5FFEBB060FFEBB060FFDDF2ECFFEBB060FFEBB0
          60FFCDECE4FFEBB060FFEBB060FFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFEBB060FFEBB060FFE8F6F2FFEBB060FFEBB060FFD8F0E9FFEBB060FFEBB0
          60FFC8EAE1FFEBB060FFEBB060FFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EA
          E1FFC3E8DEFFBEE6DBFFBBE5D9FFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFEBB060FFEBB060FFDDF2ECFFEBB060FFEBB060FFCDECE4FFEBB060FFEBB0
          60FFBEE6DBFFEBB060FFEBB060FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FFEBB060FFEBB060FFD8F0E9FFEBB060FFEBB060FFC8EAE1FFEBB060FFEBB0
          60FFBBE5D9FFEBB060FFEBB060FFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFF54A57FFF54A57FFF54A57FFFF1FAF7FF54A57FFF54A57FFF54A57FFFDDF2
          ECFF54A57FFF54A57FFF54A57FFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFF54A57FFFA3D0BAFF54A57FFFEDF8F5FF54A57FFFA3D0BAFF54A57FFFD8F0
          E9FF54A57FFFA3D0BAFF54A57FFFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFF54A57FFF54A57FFF54A57FFFE8F6F2FF54A57FFF54A57FFF54A57FFFD2EE
          E6FF54A57FFF54A57FFF54A57FFFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDEC
          E4FFC8EAE1FFC3E8DEFFBFE6DBFFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FF54A57FFF54A57FFF54A57FFFDDF2ECFF54A57FFF54A57FFF54A57FFFC8EA
          E1FF54A57FFF54A57FFF54A57FFFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FF54A57FFFA3D0BAFF54A57FFFD8F0E9FF54A57FFFA3D0BAFF54A57FFFC3E8
          DEFF54A57FFFA3D0BAFF54A57FFFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FF54A57FFF54A57FFF54A57FFFD2EEE6FF54A57FFF54A57FFF54A57FFFBFE6
          DBFF54A57FFF54A57FFF54A57FFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000B4A33D40E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E593DFF0E59
          3DFF0E593DFF0E593DFF0E593DFF0E593DFF0B4A33D400000000146043FFFFFF
          FFFFFFFFFFFFFDFEFEFFFBFEFDFFFAFDFCFFF7FCFAFFF4FBF9FFF1FAF7FFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFF146043FF000000001B684AFFFCFD
          FDFF54A57FFF54A57FFF54A57FFFF1FAF7FF54A57FFF54A57FFF54A57FFFDDF2
          ECFF54A57FFF54A57FFF54A57FFFDEF2EDFF1B684AFF00000000247152FFFAFC
          FBFFF9FDFCFFF6FBFAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0
          E9FFD2EEE6FFCDECE4FFC8EAE1FFDBF1EBFF247152FF000000002C7A5AFFF8FC
          FAFF54A57FFF54A57FFF54A57FFFE8F6F2FF54A57FFF54A57FFF54A57FFFD2EE
          E6FF54A57FFF54A57FFF54A57FFFD8F0E9FF2C7A5AFF00000000368462FFF7FB
          FAFFF1FAF7FFEDF8F5FFE8F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDEC
          E4FFC8EAE1FFC3E8DEFFBFE6DBFFD6EFE8FF368462FF000000003E8D6AFFF4FA
          F8FF54A57FFF54A57FFF54A57FFFDDF2ECFF54A57FFF54A57FFF54A57FFFC8EA
          E1FF54A57FFF54A57FFF54A57FFFD3EEE7FF3E8D6AFF00000000479672FFF1F9
          F7FFE9F6F2FFE3F4EFFFDDF2ECFFD8F0E9FFD2EEE6FFCDECE4FFC8EAE1FFC3E8
          DEFFBEE6DBFFBAE5D9FFB7E3D7FFD1EEE6FF479672FF000000004E9E79FFEEF9
          F5FF54A57FFF54A57FFF54A57FFFD2EEE6FF54A57FFF54A57FFF54A57FFFBFE6
          DBFF54A57FFF54A57FFF54A57FFFD0EDE5FF4E9E79FF0000000054A57FFFEEF8
          F5FFEBF7F4FFE8F6F2FFE4F5F0FFE1F4EFFFDEF2EDFFDBF1EBFFD8F0E9FFD6EF
          E8FFD3EEE7FFD1EEE6FFD0EDE5FFD0EDE5FF54A57FFF0000000053A37DFD59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA83FF59AA
          83FF59AA83FF59AA83FF59AA83FF59AA83FF54A47EFF00000000509E7AFB99C9
          B2FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACA
          B3FF9ACAB3FF9ACAB3FF9ACAB3FF9ACAB3FF51A17CFF0000000053A17CF798C9
          B1FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF99C9
          B2FF99C9B2FF99C9B2FF99C9B2FF99C9B2FF55A37EFB00000000325F498E56A5
          7FF758A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A781FB58A7
          81FB58A781FB58A781FB58A781FB58A781FB33614B9200000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000000467414D410000AFC837058AE90000001974455874536F6674776172
          650041646F626520496D616765526561647971C9653C000001FE494441541819
          05C13D8B5D551806D0B5CFEC3B438292A860844444030A56016520F1A3157F82
          8568912A42D022A536565622A20863A1D80A7682626195221616C14EC542B412
          C50CDE997BF67E1FD76A876F7CF7161EC3F37802F7918E26C0DED22C4B93942A
          FFEC6FFCBC3D5DDFBBF3F1CB5F763C7D74EBDA759AA72E1E0852B11BB15BCBDE
          D29C3958B4C6F1B61C9FCC73BFFE797CE5F36F7EF9E4F0C6D7E716BC207C75E7
          5F1592B8F9E10FAA426B36BD5996663762BB9651DAB4F4D75EBAFCD09983FD8F
          163C1254C53ACA3A02D68ABEC7A63755B1DD957584C4F777EFD9DFECD99E8EFD
          8EB3A382D8EE0A2CAD11367DD134276BD99E46252A54E28FBF4E485A277D2612
          4E47C0DBAF5FB1E98BBEB0CEF8EFB48C2A5544A4CA3AA6A474B49A48BCFBD98F
          5A6B96C6A62F1A46C5182500387FFE41EBD823D1854AA99A1EBE709146130251
          A1AA245189AAA235EB3A48E9302709D012A05145124482444B24655D9BA47418
          B31010D1341249A44A441255532AA29CAE21A513B34278E7954B00000000E0D6
          D14FC688A4F4A535B38848F8E0F67500000070F3EA913987DD0889AE51150D70
          EDD2AB000000006A96B906A527C9AC34026EFFFE0500000078F6D117CD39AD33
          92A457FCB61BF5F83397CF6A8D379FFB14000000C085FBCB9C81BFDBE18D6FDF
          4FF224B92A7980928494A448498A14892448C83D6DB9FB3F217C6E8B6D10B0A2
          0000000049454E44AE426082}
      end>
  end
end
