object frmTreeBrowser: TfrmTreeBrowser
  Left = 316
  Top = 327
  ActiveControl = tvServers
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Servers'
  ClientHeight = 423
  ClientWidth = 215
  Color = clBtnFace
  ParentFont = True
  Position = poDefault
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object tvServers: TcxTreeView
    Left = 0
    Top = 0
    Width = 215
    Height = 404
    Align = alClient
    TabOrder = 0
    OnClick = tvServersClick
    OnDblClick = tvServersDblClick
    OnKeyDown = tvServersKeyDown
    OnContextPopup = tvServersContextPopup
    HotTrack = True
    Indent = 27
    RightClickSelect = True
    OnDeletion = tvServersDeletion
    OnEditing = tvServersEditing
    OnEdited = tvServersEdited
    OnExpanding = tvServersExpanding
  end
  object StatusBar: TdxStatusBar
    Left = 0
    Top = 404
    Width = 215
    Height = 19
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    PaintStyle = stpsUseLookAndFeel
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Black'
    ParentFont = True
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'popmnuDatabase'
      'popmnuServer'
      'popmnuTable')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    LookAndFeel.SkinName = 'DevExpressStyle'
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 112
    Top = 8
    PixelsPerInch = 96
    object popmnuTableSQL: TdxBarButton
      Caption = 'SQL'
      Category = 0
      Hint = 'Open SQL Browser'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 115
      OnClick = popmnuDatabaseSQLClick
    end
    object popmnuTablesEmptyAllTables: TdxBarButton
      Caption = '&Empty All Tables'
      Category = 0
      Hint = 'Empty All Tables'
      Visible = ivAlways
      OnClick = popmnuTablesEmptyAllTablesClick
    end
    object popmnuTableCloneTableStructure: TdxBarButton
      Caption = 'Cl&one Table Structure'
      Category = 0
      Hint = 'Clone Table Structure'
      Visible = ivAlways
      ImageIndex = 2
      OnClick = popmnuTableCloneTableStructureClick
    end
    object popmnuServerRefreshServerList: TdxBarButton
      Caption = '&Refresh Server List'
      Category = 0
      Hint = 'Refresh Server List'
      Visible = ivAlways
      ImageIndex = 4
      OnClick = popmnuServerRefreshServerListClick
    end
    object popmnuTablesChangePassword: TdxBarButton
      Caption = 'C&hange Password (All Tables)'
      Category = 0
      Hint = 'Change Password (All Tables)'
      Visible = ivAlways
      OnClick = popmnuTablesChangePasswordClick
    end
    object popmnuTableChangePassword: TdxBarButton
      Caption = 'C&hange Password'
      Category = 0
      Hint = 'Change Password'
      Visible = ivAlways
      OnClick = popmnuTableChangePasswordClick
    end
    object popmnuDatabaseRefIntEditor: TdxBarButton
      Caption = 'Referential Inte&grity'
      Category = 0
      Hint = 'Referential Integrity'
      Visible = ivAlways
      OnClick = popmnuDatabaseRefIntEditorClick
    end
    object popmnuStoredProcsAddStoredProc: TdxBarButton
      Caption = 'Add &Procedure'
      Category = 0
      Hint = 'Add Procedure'
      Visible = ivAlways
      OnClick = popmnuStoredProcsAddStoredProcClick
    end
    object popmnuTablesRefresh: TdxBarButton
      Caption = '&Refresh List'
      Category = 0
      Hint = 'Refresh List'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuTablesRefreshClick
    end
    object popmnuViewsRefresh: TdxBarButton
      Caption = '&Refresh List'
      Category = 0
      Hint = 'Refresh List'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuViewsRefreshClick
    end
    object popmnuStoredProcsEdit: TdxBarButton
      Caption = 'Edit'
      Category = 0
      Hint = 'Edit'
      Visible = ivAlways
    end
    object popmnuStoredProcDelete: TdxBarButton
      Caption = '&Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 46
      OnClick = popmnuStoredProcDeleteClick
    end
    object popmnuStoredProcOpen: TdxBarButton
      Caption = 'Open'
      Category = 0
      Hint = 'Open'
      Visible = ivAlways
    end
    object popmnuStoredProcEdit: TdxBarButton
      Caption = '&Edit'
      Category = 0
      Hint = 'Edit'
      Visible = ivAlways
      OnClick = popmnuStoredProcEditClick
    end
    object popmnuViewDelete: TdxBarButton
      Caption = '&Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 46
      OnClick = popmnuViewDeleteClick
    end
    object popmnuViewEdit: TdxBarButton
      Caption = '&Edit'
      Category = 0
      Hint = 'Edit'
      Visible = ivAlways
      OnClick = popmnuViewEditClick
    end
    object popmnuViewOpen: TdxBarButton
      Caption = '&Open'
      Category = 0
      Hint = 'Open'
      Visible = ivAlways
      ImageIndex = 31
      OnClick = popmnuViewOpenClick
    end
    object popmnuTriggersRefresh: TdxBarButton
      Caption = '&Refresh List'
      Category = 0
      Hint = 'Refresh List'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuTriggersRefreshClick
    end
    object popmnuTriggerDelete: TdxBarButton
      Caption = '&Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 46
      OnClick = popmnuTriggerDeleteClick
    end
    object popmnuTriggerEdit: TdxBarButton
      Caption = '&Edit'
      Category = 0
      Hint = 'Edit'
      Visible = ivAlways
      OnClick = popmnuTriggerEditClick
    end
    object popmnuTriggersAdd: TdxBarButton
      Caption = '&Add'
      Category = 0
      Hint = 'Add'
      Visible = ivAlways
      ImageIndex = 55
      OnClick = popmnuTriggersAddClick
    end
    object popmnuViewsAdd: TdxBarButton
      Caption = '&Add'
      Category = 0
      Hint = 'Add'
      Visible = ivAlways
      ImageIndex = 53
      OnClick = popmnuViewsAddClick
    end
    object popmnuStoredProcsAdd: TdxBarSubItem
      Caption = '&Add'
      Category = 0
      Visible = ivAlways
      ImageIndex = 50
      ItemLinks = <
        item
          Visible = True
          ItemName = 'popmnuStoredProcsAddFunction'
        end
        item
          Visible = True
          ItemName = 'popmnuStoredProcsAddStoredProc'
        end>
    end
    object popmnuStoredProcsAddFunction: TdxBarButton
      Caption = 'Add &Function'
      Category = 0
      Hint = 'Add Function'
      Visible = ivAlways
      OnClick = popmnuStoredProcsAddFunctionClick
    end
    object popmnuCheckConstraintsRefresh: TdxBarButton
      Caption = 'Re&fresh List'
      Category = 0
      Hint = 'Refresh List'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuCheckConstraintsRefreshClick
    end
    object popmnuCheckConstraintsAdd: TdxBarButton
      Caption = '&Add'
      Category = 0
      Hint = 'Add'
      Visible = ivAlways
      ImageIndex = 58
      OnClick = popmnuCheckConstraintsAddClick
    end
    object popmnuCheckConstraintDelete: TdxBarButton
      Caption = '&Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 46
      OnClick = popmnuCheckConstraintDeleteClick
    end
    object popmnuCheckConstraintEdit: TdxBarButton
      Caption = '&Edit'
      Category = 0
      Hint = 'Edit'
      Visible = ivAlways
      OnClick = popmnuCheckConstraintEditClick
    end
    object popmnuDatabaseRefresh: TdxBarButton
      Caption = 'Re&fresh'
      Category = 0
      Hint = 'Refresh'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuDatabaseRefreshClick
    end
    object popmnuDatabaseDesignReport: TdxBarButton
      Caption = 'Design Re&port...'
      Category = 0
      Hint = 'Design Report'
      Visible = ivAlways
      ImageIndex = 33
      ShortCut = 16452
      OnClick = popmnuDatabaseDesignReportClick
    end
    object popmnuTablePrintPreview: TdxBarButton
      Caption = 'Print Preview'
      Category = 0
      Hint = 'Print Preview'
      Visible = ivAlways
      ImageIndex = 34
      ShortCut = 16464
      OnClick = popmnuTablePrintPreviewClick
    end
    object popmnuTablesRecoverAllTables: TdxBarButton
      Caption = 'Re&cover All Tables'
      Category = 0
      Hint = 'Recover All Tables'
      Visible = ivAlways
      OnClick = popmnuTablesRecoverAllTablesClick
    end
    object popmnuTablesChangeAllTables: TdxBarButton
      Caption = 'Change &All Tables'
      Category = 0
      Hint = 'Change All Tables'
      Visible = ivAlways
      OnClick = popmnuTablesChangeAllTablesClick
    end
    object dxBarSeparator1: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
    end
    object popmnuDatabaseDDCG: TdxBarButton
      Caption = 'S&QL/Data Dictionary Source Code Generator'
      Category = 0
      Hint = 'SQL/Data Dictionary Source Code Generator'
      Visible = ivAlways
      ImageIndex = 32
      OnClick = popmnuDatabaseDDCGClick
    end
    object dxBarSeparator2: TdxBarSeparator
      Category = 0
      Visible = ivAlways
    end
    object popmnuTableStreams: TdxBarButton
      Caption = 'Table Streams...'
      Category = 0
      Hint = 'Table Streams'
      Visible = ivAlways
      OnClick = popmnuTableStreamsClick
    end
    object popmnuServerCloseInactive: TdxBarButton
      Caption = 'Close &Inactive Tables and Folders'
      Category = 0
      Hint = 'Close Inactive Tables and Folders'
      Visible = ivAlways
      OnClick = popmnuServerCloseInactiveClick
    end
    object popmnuTablesVerifyAllTables: TdxBarButton
      Caption = '&Verify All Tables'
      Category = 0
      Hint = 'Verify All Tables'
      Visible = ivAlways
      OnClick = popmnuTablesVerifyAllTablesClick
    end
    object popmnuTableVerifyTable: TdxBarButton
      Caption = 'Verify Table'
      Category = 0
      Hint = 'Verify Table'
      Visible = ivAlways
      OnClick = popmnuTableVerifyTableClick
    end
    object popmnuTablesPackNLS: TdxBarButton
      Caption = 'Pack Tables Needing &NLS Update'
      Category = 0
      Hint = 'Pack Tables Needing NLS Update'
      Visible = ivAlways
      OnClick = popmnuTablesPackNLSClick
    end
    object popmnuClientToClientMessaging: TdxBarButton
      Caption = 'Client to Client &Messaging...'
      Category = 0
      Hint = 'Client to Client Messaging'
      Visible = ivAlways
      OnClick = popmnuClientToClientMessagingClick
    end
    object popmnuServerProperties: TdxBarButton
      Caption = 'Connection &Properties'
      Category = 0
      Hint = 'Connection Properties'
      Visible = ivAlways
      OnClick = popmnuServerPropertiesClick
    end
    object popmnuServerUsersAndPrivileges: TdxBarButton
      Caption = '&Users And Privileges'
      Category = 0
      Hint = 'Users And Privileges'
      Visible = ivAlways
      OnClick = popmnuServerUsersAndPrivilegesClick
    end
    object popmnuDatabaseShowinExplorer: TdxBarButton
      Caption = 'Show in Explorer'
      Category = 0
      Hint = 'Show in Explorer'
      Visible = ivAlways
      OnClick = popmnuDatabaseShowinExplorerClick
    end
    object popmnuDatabaseNewTable: TdxBarButton
      Caption = 'New &Table'
      Category = 1
      Visible = ivAlways
      ImageIndex = 20
      ShortCut = 45
      OnClick = popmnuDatabaseNewTableClick
    end
    object popmnuServerNewDatabase: TdxBarButton
      Caption = '&New Database Alias...'
      Category = 1
      Visible = ivAlways
      ImageIndex = 5
      ShortCut = 187
      OnClick = popmnuServerNewDatabaseClick
    end
    object popmnuDatabaseDelete: TdxBarButton
      Caption = '&Delete Database Alias'
      Category = 1
      Hint = 'Delete Database Alias'
      Visible = ivAlways
      ImageIndex = 21
      ShortCut = 46
      OnClick = popmnuDatabaseDeleteClick
    end
    object popmnuDatabaseRename: TdxBarButton
      Caption = '&Rename Database Alias'
      Category = 1
      Visible = ivAlways
      OnClick = popmnuDatabaseRenameClick
    end
    object popmnuDatabaseStartTrans: TdxBarButton
      Caption = '&Start Transaction'
      Category = 1
      Visible = ivAlways
      ImageIndex = 15
      OnClick = popmnuDatabaseStartTransClick
    end
    object popmnuDatabaseCommitTrans: TdxBarButton
      Caption = '&Commit Transaction'
      Category = 1
      Visible = ivAlways
      OnClick = popmnuDatabaseCommitTransClick
    end
    object popmnuDatabaseRollbackTrans: TdxBarButton
      Caption = 'R&ollback Transaction'
      Category = 1
      Visible = ivAlways
      OnClick = popmnuDatabaseRollbackTransClick
    end
    object popmnuStoredProcsRefresh: TdxBarButton
      Caption = 'Re&fresh List'
      Category = 1
      Hint = 'Refresh List'
      Visible = ivAlways
      ImageIndex = 37
      OnClick = popmnuStoredProcsRefreshClick
    end
    object popmnuTablesPackAllTables: TdxBarButton
      Caption = '&Pack All Tables'
      Category = 1
      Visible = ivAlways
      ImageIndex = 22
      OnClick = popmnuTablesPackAllTablesClick
    end
    object popmnuTablesEnterPassword: TdxBarButton
      Caption = 'Enter Pass&word (All Tables)'
      Category = 1
      Hint = 'Enter Password (All Tables)'
      Visible = ivAlways
      OnClick = popmnuTablesEnterPasswordClick
    end
    object popmnuDatabaseLiveBackup: TdxBarButton
      Caption = 'Live &Backup'
      Category = 1
      Visible = ivAlways
      ImageIndex = 24
      OnClick = popmnuDatabaseLiveBackupClick
    end
    object popmnuDatabaseRestore: TdxBarButton
      Caption = 'R&estore'
      Category = 1
      Visible = ivAlways
      OnClick = popmnuDatabaseRestoreClick
    end
    object popmnuDatabaseCSVImport: TdxBarButton
      Caption = 'CSV &Import ...'
      Category = 1
      Visible = ivAlways
      ImageIndex = 25
      OnClick = popmnuDatabaseCSVImportClick
    end
    object popmnuDatabaseSQL: TdxBarButton
      Caption = 'S&QL'
      Category = 1
      Hint = 'Open SQL Browser'
      Visible = ivAlways
      ImageIndex = 31
      ShortCut = 115
      OnClick = popmnuDatabaseSQLClick
    end
    object popmnuServerAttach: TdxBarButton
      Caption = '&Connect'
      Category = 2
      Hint = 'Connect'
      Visible = ivAlways
      ImageIndex = 17
      OnClick = popmnuServerAttachClick
    end
    object popmnuServerDetach: TdxBarButton
      Caption = '&Disconnect'
      Category = 2
      Enabled = False
      Hint = 'Disconnect'
      Visible = ivAlways
      ImageIndex = 18
      ShortCut = 16430
      OnClick = popmnuServerDetachClick
    end
    object popmnuServerRefreshDatabaseList: TdxBarButton
      Caption = 'Re&fresh Database List'
      Category = 2
      Visible = ivAlways
      ShortCut = 116
      OnClick = popmnuServerRefreshDatabaseListClick
    end
    object popmnuServerStatistics: TdxBarButton
      Caption = 'Server &Statistics...'
      Category = 2
      Hint = 'Server Statistics'
      Visible = ivNever
      ImageIndex = 19
    end
    object popmnuTableBrowseTable: TdxBarButton
      Caption = 'Browse &Table'
      Category = 3
      Visible = ivAlways
      ImageIndex = 16
      OnClick = popmnuTableBrowseTableClick
    end
    object popmnuTableDefinition: TdxBarButton
      Caption = 'View &Dictionary'
      Category = 3
      Hint = 'View Dictionary'
      Visible = ivAlways
      OnClick = popmnuTableDefinitionClick
    end
    object popmnuTableNew: TdxBarButton
      Caption = '&New Table'
      Category = 3
      Visible = ivAlways
      ImageIndex = 20
      ShortCut = 45
      OnClick = popmnuTableNewClick
    end
    object popmnuTableDelete: TdxBarButton
      Caption = 'De&lete Table'
      Category = 3
      Visible = ivAlways
      ImageIndex = 26
      ShortCut = 46
      OnClick = popmnuTableDeleteClick
    end
    object popmnuTableRename: TdxBarButton
      Caption = '&Rename Table'
      Category = 3
      Visible = ivAlways
      OnClick = popmnuDatabaseRenameClick
    end
    object popmnuTableReindex: TdxBarButton
      Caption = 'Reinde&x...'
      Category = 3
      Visible = ivAlways
      ImageIndex = 27
      OnClick = popmnuTableReindexClick
    end
    object popmnuTablePackTable: TdxBarButton
      Caption = '&Pack Table'
      Category = 3
      Visible = ivAlways
      ImageIndex = 22
      OnClick = popmnuTablePackClick
    end
    object popmnuTableRestructure: TdxBarButton
      Caption = 'Re&structure...'
      Category = 3
      Hint = 'Restructure'
      Visible = ivAlways
      ImageIndex = 20
      OnClick = popmnuTableRestructureClick
    end
    object popmnuTableEnterPassword: TdxBarButton
      Caption = 'Enter Pass&word...'
      Category = 3
      Hint = 'Enter Password'
      Visible = ivAlways
      OnClick = popmnuTableEnterPasswordClick
    end
    object popmnuTableSetAutoInc: TdxBarButton
      Caption = 'Set &AutoInc...'
      Category = 3
      Visible = ivAlways
      OnClick = popmnuTableSetAutoIncClick
    end
    object popmnuTableEmpty: TdxBarButton
      Caption = '&Empty'
      Category = 3
      Visible = ivAlways
      ImageIndex = 26
      OnClick = popmnuTableEmptyClick
    end
    object popmnuTableRecover: TdxBarButton
      Caption = 'Re&cover Records'
      Category = 3
      Visible = ivAlways
      OnClick = popmnuTableRecoverClick
    end
    object popmnuTableImportCSV: TdxBarButton
      Caption = 'CSV I&mport ...'
      Category = 3
      Visible = ivAlways
      ImageIndex = 25
      OnClick = popmnuTableImportCSVClick
    end
  end
  object popmnuDatabase: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuDatabaseNewTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuServerNewDatabase'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseDelete'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseRename'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseShowinExplorer'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseStartTrans'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseCommitTrans'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseRollbackTrans'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseLiveBackup'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseRestore'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseRefIntEditor'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseDDCG'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseDesignReport'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseCSVImport'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    OnPopup = popmnuDatabasePopup
    Left = 40
    Top = 40
    PixelsPerInch = 96
  end
  object popmnuServer: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuServerAttach'
      end
      item
        Visible = True
        ItemName = 'popmnuServerDetach'
      end
      item
        Visible = True
        ItemName = 'popmnuServerProperties'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuServerNewDatabase'
      end
      item
        Visible = True
        ItemName = 'popmnuServerRefreshDatabaseList'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuServerUsersAndPrivileges'
      end
      item
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuClientToClientMessaging'
      end
      item
        Visible = True
        ItemName = 'popmnuServerCloseInactive'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuServerRefreshServerList'
      end
      item
        Visible = True
        ItemName = 'popmnuServerStatistics'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    OnPopup = popmnuServerPopup
    Left = 8
    Top = 40
    PixelsPerInch = 96
  end
  object popmnuTable: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuTableBrowseTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableSQL'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableNew'
      end
      item
        Visible = True
        ItemName = 'popmnuTableDelete'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRename'
      end
      item
        Visible = True
        ItemName = 'popmnuTableCloneTableStructure'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableDefinition'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRestructure'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableReindex'
      end
      item
        Visible = True
        ItemName = 'popmnuTablePackTable'
      end
      item
        Visible = True
        ItemName = 'popmnuTableVerifyTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableEnterPassword'
      end
      item
        Visible = True
        ItemName = 'popmnuTableChangePassword'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableSetAutoInc'
      end
      item
        Visible = True
        ItemName = 'popmnuTableEmpty'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRecover'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableStreams'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTablePrintPreview'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableImportCSV'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    OnPopup = popmnuTablePopup
    Left = 104
    Top = 72
    PixelsPerInch = 96
  end
  object tiAlign: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tiAlignTimer
    Left = 176
    Top = 8
  end
  object popmnuChildTable: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuTableBrowseTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableSQL'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableNew'
      end
      item
        Visible = True
        ItemName = 'popmnuTableDelete'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRename'
      end
      item
        Visible = True
        ItemName = 'popmnuTableCloneTableStructure'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableDefinition'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRestructure'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableReindex'
      end
      item
        Visible = True
        ItemName = 'popmnuTablePackTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableEnterPassword'
      end
      item
        Visible = True
        ItemName = 'popmnuTableChangePassword'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableSetAutoInc'
      end
      item
        Visible = True
        ItemName = 'popmnuTableEmpty'
      end
      item
        Visible = True
        ItemName = 'popmnuTableRecover'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTablePrintPreview'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTableImportCSV'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    OnPopup = popmnuChildTablePopup
    Left = 136
    Top = 72
    PixelsPerInch = 96
  end
  object WinsockTransportBroadcast: TnxWinsockTransport
    DisplayCategory = 'Transports'
    Left = 32
    Top = 304
  end
  object NamedPipeTransportBroadcast: TnxNamedPipeTransport
    DisplayCategory = 'Transports'
    Left = 72
    Top = 304
  end
  object SharedMemoryTransportBroadcast: TnxSharedMemoryTransport
    DisplayCategory = 'Transports'
    Left = 113
    Top = 305
  end
  object popmnuTables: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuDatabaseNewTable'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTablesRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTablesPackAllTables'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesEmptyAllTables'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesRecoverAllTables'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesChangeAllTables'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesVerifyAllTables'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesPackNLS'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTablesEnterPassword'
      end
      item
        Visible = True
        ItemName = 'popmnuTablesChangePassword'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseCSVImport'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 72
    Top = 72
    PixelsPerInch = 96
  end
  object popmnuStoredProcs: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuStoredProcsAdd'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuStoredProcsRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 72
    Top = 168
    PixelsPerInch = 96
  end
  object popmnuViews: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuViewsAdd'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuViewsRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 72
    Top = 136
    PixelsPerInch = 96
  end
  object popmnuStoredProc: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuStoredProcsAdd'
      end
      item
        Visible = True
        ItemName = 'popmnuStoredProcEdit'
      end
      item
        Visible = True
        ItemName = 'popmnuStoredProcDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 104
    Top = 168
    PixelsPerInch = 96
  end
  object popmnuView: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuViewOpen'
      end
      item
        Visible = True
        ItemName = 'popmnuViewEdit'
      end
      item
        Visible = True
        ItemName = 'popmnuViewDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 104
    Top = 136
    PixelsPerInch = 96
  end
  object popmnuTrigger: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuTriggersAdd'
      end
      item
        Visible = True
        ItemName = 'popmnuTriggerEdit'
      end
      item
        Visible = True
        ItemName = 'popmnuTriggerDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 104
    Top = 104
    PixelsPerInch = 96
  end
  object popmnuTriggers: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuTriggersAdd'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuTriggersRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 72
    Top = 104
    PixelsPerInch = 96
  end
  object popmnuCheckConstraints: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuCheckConstraintsAdd'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuCheckConstraintsRefresh'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 72
    Top = 200
    PixelsPerInch = 96
  end
  object popmnuCheckConstraint: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'popmnuCheckConstraintsAdd'
      end
      item
        Visible = True
        ItemName = 'popmnuCheckConstraintEdit'
      end
      item
        Visible = True
        ItemName = 'popmnuCheckConstraintDelete'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'popmnuDatabaseSQL'
      end>
    UseOwnFont = False
    OnCloseUp = popmnuServerCloseUp
    Left = 104
    Top = 200
    PixelsPerInch = 96
  end
  object tiRightSelect: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tiRightSelectTimer
    Left = 168
    Top = 256
  end
  object nxHttpTransport1: TnxHttpTransport
    DisplayCategory = 'Transports'
    ClientIgnoreUnknownCA = False
    ClientIgnoreCertDateInvalid = False
    ClientIgnoreCertCNInvalid = False
    ClientIgnoreCertWrongUsage = False
    Left = 32
    Top = 272
  end
end
