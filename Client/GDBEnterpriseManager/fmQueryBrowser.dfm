inherited frmQueryBrowser: TfrmQueryBrowser
  Left = 425
  Top = 260
  Caption = '<server> - <database>'
  ClientHeight = 600
  ClientWidth = 703
  Constraints.MinWidth = 500
  KeyPreview = True
  ExplicitWidth = 703
  ExplicitHeight = 600
  DesignSize = (
    703
    600)
  TextHeight = 15
  inherited paClient: TPanel
    Top = 155
    Width = 703
    Height = 398
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 155
    ExplicitWidth = 703
    ExplicitHeight = 398
    inherited PlainDataGrid: TDBGrid
      Width = 703
      Height = 180
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
    end
    inherited cxDataGrid: TcxGrid
      Width = 703
      Height = 180
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Constraints.MinHeight = 92
      ExplicitWidth = 703
      ExplicitHeight = 180
      inherited cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.Filter.Visible = False
        DataController.Filter.Active = False
        inherited cxGrid1DBTableView1DBColumn1: TcxGridDBColumn
          DataBinding.IsNullValueType = True
          Options.Filtering = False
        end
      end
    end
    inherited splGridAndPageControl: TcxSplitter
      Top = 180
      Width = 703
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitTop = 180
      ExplicitWidth = 703
    end
    inherited paBottom: TPanel
      Top = 185
      Width = 703
      Height = 213
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitTop = 185
      ExplicitWidth = 703
      ExplicitHeight = 213
      inherited pcBlobfields: TcxPageControl
        Width = 703
        Height = 213
        ExplicitWidth = 703
        ExplicitHeight = 213
        ClientRectBottom = 207
        ClientRectRight = 697
      end
    end
  end
  object StatusBar: TdxStatusBar [1]
    Left = 0
    Top = 580
    Width = 703
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Waiting for input...'
        Width = 140
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Queries = 1'
        Width = 110
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Records: '
        Width = 220
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Execution Time = 0 ms'
        Width = 220
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'BLOB Size:'
        Width = 160
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'RecNo:'
      end>
    PaintStyle = stpsUseLookAndFeel
    ParentFont = True
  end
  object paTop: TPanel [2]
    Left = 0
    Top = 0
    Width = 703
    Height = 150
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object splQueryAndLog: TcxSplitter
      Left = 384
      Top = 0
      Width = 5
      Height = 150
      Cursor = crHSplit
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salRight
      AutoSnap = True
      MinSize = 1
      Control = meSQLLog
    end
    object SQLEditor: TSynMemo
      Left = 0
      Top = 0
      Width = 384
      Height = 150
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Color = 1973790
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      PopupMenu = pmSqlEditor
      TabOrder = 2
      CodeFolding.GutterShapeSize = 11
      CodeFolding.CollapsedLineColor = clGrayText
      CodeFolding.FolderBarLinesColor = clGrayText
      CodeFolding.IndentGuidesColor = clGray
      CodeFolding.IndentGuides = True
      CodeFolding.ShowCollapsedLine = False
      CodeFolding.ShowHintMark = True
      UseCodeFolding = False
      Gutter.DigitCount = 2
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -13
      Gutter.Font.Name = 'Consolas'
      Gutter.Font.Style = []
      Gutter.ShowLineNumbers = True
      Gutter.ShowModification = True
      Highlighter = SynSQLSynLight
      Lines.Strings = (
        'SQLEditor')
      Options = [eoAutoIndent, eoAutoSizeMaxScrollWidth, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabIndent, eoTabsToSpaces, eoTrimTrailingSpaces]
      RightEdge = 999
      TabWidth = 2
      WantTabs = True
      OnChange = SQLEditorChange
      FontSmoothing = fsmClearType
    end
    object meSQLLog: TcxMemo
      Left = 389
      Top = 0
      Cursor = crIBeam
      Align = alRight
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      TabOrder = 0
      Height = 150
      Width = 314
    end
  end
  object splQueryAndGrid: TcxSplitter [3]
    Left = 0
    Top = 150
    Width = 703
    Height = 5
    Cursor = crVSplit
    Hint = 'Resize | Resize windows'
    HotZoneClassName = 'TcxXPTaskBarStyle'
    AlignSplitter = salTop
    AutoSnap = True
    Control = paTop
    Color = clBtnFace
    ParentColor = False
  end
  inherited cxDBNavigator: TcxDBNavigator
    Top = 553
    Width = 702
    Height = 27
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 553
    ExplicitWidth = 702
    ExplicitHeight = 27
  end
  object paCancelableQuery: TPanel [5]
    Left = 440
    Top = 74
    Width = 236
    Height = 70
    Cursor = crHourGlass
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clAppWorkSpace
    ParentBackground = False
    TabOrder = 5
    Visible = False
    object btnCancel: TcxButton
      Left = 56
      Top = 45
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object laElapsed: TcxLabel
      Left = 72
      Top = 29
      Caption = '---'
      ParentColor = False
      Style.Color = clInactiveCaptionText
      Transparent = True
    end
    object laRunning: TcxLabel
      Left = 72
      Top = 10
      Caption = 'Query Running...'
      ParentColor = False
      Style.Color = clInactiveCaptionText
      Transparent = True
    end
  end
  inherited dsBrowser: TDataSource
    Left = 288
    Top = 448
  end
  inherited OpenDialog: TOpenDialog
    Filter = 'SQL files|*.sql|Text files|*.txt|All files|*.*'
    FilterIndex = 0
  end
  inherited SaveDialog: TSaveDialog
    DefaultExt = 'SQL'
    Filter = 'SQL scripts|*.sql|Text files|*.txt|All files|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
  object taSqlHistoryBrowse: TnxTable
    ActiveRuntime = True
    Database = dmEM.dbEMSystem
    FilterType = ftSqlWhere
    TableName = 'SQLLog'
    IndexFieldNames = 'ServerName;DatabaseName;RunAt'
    Left = 320
    Top = 192
    object taSqlHistoryBrowseID: TUnsignedAutoIncField
      FieldName = 'ID'
    end
    object taSqlHistoryBrowseRunAt: TDateTimeField
      FieldName = 'RunAt'
    end
    object taSqlHistoryBrowseServerName: TWideStringField
      FieldName = 'ServerName'
      Size = 200
    end
    object taSqlHistoryBrowseDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Size = 200
    end
    object taSqlHistoryBrowseSQL: TWideMemoField
      FieldName = 'SQL'
      BlobType = ftWideMemo
    end
    object taSqlHistoryBrowseQueryLog: TWideMemoField
      FieldName = 'QueryLog'
      BlobType = ftWideMemo
    end
    object taSqlHistoryBrowseErrorMessage: TWideMemoField
      FieldName = 'ErrorMessage'
      BlobType = ftWideMemo
    end
    object taSqlHistoryBrowseSessionID: TGuidField
      FieldName = 'SessionID'
      Size = 38
    end
    object taSqlHistoryBrowseRunTime: TLongWordField
      FieldName = 'RunTime'
    end
    object taSqlHistoryBrowseRunTimeAsString: TWideStringField
      FieldName = 'RunTimeAsString'
    end
    object taSqlHistoryBrowseQueryExecutionResult: TIntegerField
      FieldName = 'QueryExecutionResult'
    end
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 364
    Top = 104
  end
  object SynEditSearch: TSynEditSearch
    Left = 364
    Top = 72
  end
  object SynSQLSynLight: TSynSQLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = 8683520
    ConditionalCommentAttri.Foreground = 8683520
    DataTypeAttri.Foreground = 6316128
    DelimitedIdentifierAttri.Foreground = 1381795
    FunctionAttri.Foreground = 2514553
    IdentifierAttri.Foreground = clBlue
    NumberAttri.Foreground = 5801481
    StringAttri.Foreground = 1381795
    SymbolAttri.Foreground = clBlack
    TableNameAttri.Foreground = clBlue
    SQLDialect = sqlNexus
    Left = 368
    Top = 32
  end
  object taSqlHistoryPost: TnxTable
    ActiveRuntime = True
    Database = dmEM.dbEMSystem
    FilterType = ftSqlWhere
    TableName = 'SQLLog'
    IndexFieldNames = 'ServerName;DatabaseName;RunAt'
    Left = 320
    Top = 240
    object taSqlHistoryPostID: TUnsignedAutoIncField
      FieldName = 'ID'
    end
    object taSqlHistoryPostRunAt: TDateTimeField
      FieldName = 'RunAt'
    end
    object taSqlHistoryPostServerName: TWideStringField
      FieldName = 'ServerName'
      Size = 200
    end
    object taSqlHistoryPostDatabaseName: TWideStringField
      FieldName = 'DatabaseName'
      Size = 200
    end
    object taSqlHistoryPostSQL: TWideMemoField
      FieldName = 'SQL'
      BlobType = ftWideMemo
    end
    object taSqlHistoryPostQueryLog: TWideMemoField
      FieldName = 'QueryLog'
      BlobType = ftWideMemo
    end
    object taSqlHistoryPostErrorMessage: TWideMemoField
      FieldName = 'ErrorMessage'
      BlobType = ftWideMemo
    end
    object taSqlHistoryPostSessionID: TGuidField
      FieldName = 'SessionID'
      Size = 38
    end
    object taSqlHistoryPostRunTime: TLongWordField
      FieldName = 'RunTime'
    end
    object taSqlHistoryPostRunTimeAsString: TWideStringField
      FieldName = 'RunTimeAsString'
    end
    object taSqlHistoryPostQueryExecutionResult: TIntegerField
      FieldName = 'QueryExecutionResult'
    end
  end
  object tiElapsed: TTimer
    Enabled = False
    OnTimer = tiElapsedTimer
    Left = 616
    Top = 24
  end
  object FileSaveDialogXP: TSaveTextFileDialog
    DefaultExt = 'SQL'
    Filter = 'SQL scripts|*.sql|Text files|*.txt|All files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 152
    Top = 432
  end
  object FileSaveDialog7: TFileSaveDialog
    DefaultExtension = 'SQL'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'SQL scripts'
        FileMask = '*.sql'
      end
      item
        DisplayName = 'Text files'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'All files'
        FileMask = '*.*'
      end>
    FileTypeIndex = 0
    Options = [fdoOverWritePrompt, fdoForceFileSystem]
    OnExecute = FileSaveDialog7Execute
    OnFileOkClick = FileSaveDialog7FileOkClick
    Left = 80
    Top = 432
  end
  object FileOpenDialogXP: TOpenTextFileDialog
    Filter = 'SQL files|*.sql|Text files|*.txt|All files|*.*'
    FilterIndex = 0
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 152
    Top = 384
  end
  object FileOpenDialog7: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    OnExecute = FileOpenDialog7Execute
    OnFileOkClick = FileOpenDialog7FileOkClick
    Left = 80
    Top = 384
  end
  object pmSqlEditor: TPopupMenu
    Left = 240
    Top = 384
    object pmSqlEditorCut: TMenuItem
      Action = EditCut1
    end
    object pmSqlEditorCopy: TMenuItem
      Action = EditCopy1
    end
    object pmSqlEditorPaste: TMenuItem
      Action = EditPaste1
    end
    object pmSqlEditorSelectAll: TMenuItem
      Action = EditSelectAll1
    end
    object pmSqlEditorUndo: TMenuItem
      Action = EditUndo1
    end
    object pmSqlEditorDelete: TMenuItem
      Action = EditDelete1
    end
  end
  object ActionList1: TActionList
    Left = 296
    Top = 384
    object EditCut1: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object EditUndo1: TEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object EditDelete1: TEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
  end
  object SynEditOptionsDialog1: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 572
    Top = 452
  end
  object SynSQLSynDark: TSynSQLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = 5609834
    ConditionalCommentAttri.Foreground = 5609834
    DataTypeAttri.Foreground = 11770966
    DelimitedIdentifierAttri.Foreground = 7901646
    FunctionAttri.Foreground = 10345692
    IdentifierAttri.Foreground = 13948116
    KeyAttri.Foreground = 14064726
    NumberAttri.Foreground = 11062965
    StringAttri.Foreground = 8421631
    SymbolAttri.Foreground = 13948116
    TableNameAttri.Foreground = clBlue
    SQLDialect = sqlNexus
    Left = 408
    Top = 32
  end
end
