inherited frmTableBrowser: TfrmTableBrowser
  Left = 338
  Top = 283
  Caption = ''
  ClientHeight = 616
  ClientWidth = 760
  Constraints.MinHeight = 400
  ParentFont = False
  KeyPreview = True
  ExplicitWidth = 760
  ExplicitHeight = 616
  TextHeight = 15
  inherited paClient: TPanel
    Top = 111
    Width = 760
    Height = 460
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 95
    ExplicitWidth = 760
    ExplicitHeight = 476
    inherited PlainDataGrid: TDBGrid
      Width = 760
      Height = 243
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
    end
    inherited cxDataGrid: TcxGrid
      Width = 760
      Height = 243
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Constraints.MinHeight = 92
      LookAndFeel.Kind = lfOffice11
      ExplicitWidth = 760
      ExplicitHeight = 259
      inherited cxGrid1DBTableView1: TcxGridDBTableView
        inherited cxGrid1DBTableView1DBColumn1: TcxGridDBColumn
          DataBinding.IsNullValueType = True
        end
      end
    end
    inherited splGridAndPageControl: TcxSplitter
      Top = 243
      Width = 760
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitTop = 259
      ExplicitWidth = 760
    end
    inherited paBottom: TPanel
      Top = 248
      Width = 760
      Height = 212
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitTop = 264
      ExplicitWidth = 760
      ExplicitHeight = 212
      inherited pcBlobfields: TcxPageControl
        Width = 760
        Height = 212
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Constraints.MinHeight = 162
        ExplicitWidth = 760
        ExplicitHeight = 212
        ClientRectBottom = 206
        ClientRectRight = 754
      end
    end
  end
  object StatusBar: TdxStatusBar [1]
    Left = 0
    Top = 596
    Width = 760
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Records:'
        Width = 450
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Filter:'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Range:'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'BLOB Size:'
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'RecNo:'
        Width = 120
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    PaintStyle = stpsUseLookAndFeel
    ParentFont = True
  end
  object paIndex: TPanel [2]
    Left = 0
    Top = 0
    Width = 760
    Height = 28
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      760
      28)
    object btnFindNear: TcxButton
      Left = 672
      Top = 2
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Fi&nd'
      TabOrder = 2
      OnClick = btnFindNearClick
    end
    object laIndex: TcxLabel
      Left = 6
      Top = 3
      Caption = '&Index:'
      Transparent = True
    end
    object laFind: TcxLabel
      Left = 420
      Top = 3
      Anchors = [akTop, akRight]
      Caption = 'Fin&d nearest:'
      Transparent = True
    end
    object cbIndex: TcxComboBox
      Left = 53
      Top = 2
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = cbIndexChange
      ShowHint = True
      TabOrder = 0
      Width = 269
    end
    object cbFlipOrder: TcxCheckBox
      Left = 328
      Top = 3
      Anchors = [akTop, akRight]
      Caption = 'Flip Order'
      TabOrder = 3
      Transparent = True
      OnClick = cbFlipOrderClick
    end
    object edFindNearest: TcxTextEdit
      Left = 503
      Top = 2
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnEnter = edFindNearestEnter
      Width = 161
    end
  end
  object paFilter: TPanel [3]
    Left = 0
    Top = 28
    Width = 760
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      760
      26)
    object btnSetFilter: TcxButton
      Left = 672
      Top = 1
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'S&et Filter'
      TabOrder = 2
      OnClick = btnSetFilterClick
    end
    object laFilter: TcxLabel
      Left = 6
      Top = 3
      Caption = 'Fi&lter:'
      Transparent = True
    end
    object cbFilter: TcxComboBox
      Left = 53
      Top = -1
      Anchors = [akLeft, akTop, akRight]
      Properties.DropDownRows = 20
      Properties.OnCloseUp = cbFilterSelect
      TabOrder = 0
      OnEnter = cbFilterEnter
      Width = 269
    end
    object cbSQLFilter: TcxCheckBox
      Left = 328
      Top = 1
      Anchors = [akTop, akRight]
      Caption = 'S&QL Filter'
      TabOrder = 1
      Transparent = True
    end
  end
  object paRange: TPanel [4]
    Left = 0
    Top = 54
    Width = 760
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      760
      57)
    object btnSetClearRange: TcxButton
      Left = 672
      Top = 2
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Set &Range'
      TabOrder = 0
      OnClick = btnSetClearRangeClick
    end
    object btnEditRange: TcxButton
      Left = 672
      Top = 29
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Edit R&ange'
      TabOrder = 1
      OnClick = btnEditRangeClick
    end
    object laRangeStartDesc: TcxLabel
      Left = 6
      Top = 3
      Caption = 'Range start:'
      Transparent = True
    end
    object laRangeEndDesc: TcxLabel
      Left = 6
      Top = 30
      Caption = 'Range end:'
      Transparent = True
    end
    object laRangeStart: TcxLabel
      Left = 86
      Top = 3
      Caption = '[start]'
      Transparent = True
    end
    object laRangeEnd: TcxLabel
      Left = 86
      Top = 30
      Caption = '[end]'
      Transparent = True
    end
  end
  inherited cxDBNavigator: TcxDBNavigator
    Top = 571
    Width = 760
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 571
    ExplicitWidth = 760
  end
  inherited dsBrowser: TDataSource
    Left = 56
    Top = 176
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
  object nvTableBrowser: TdxBarDBNavigator
    CategoryName = 'DB Navigator'
    ConfirmDelete = False
    DataSource = dsBrowser
    DBCheckLinks = <>
    Left = 248
    Top = 134
  end
end
