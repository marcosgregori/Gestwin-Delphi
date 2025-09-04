object frxDesignerForm: TfrxDesignerForm
  Left = 418
  Top = 263
  Caption = 'Designer'
  ClientHeight = 748
  ClientWidth = 1353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  TextHeight = 20
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 1353
    Height = 1
    Align = alTop
    Style = bsRaised
    Visible = False
    ExplicitWidth = 1361
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 729
    Width = 1353
    Height = 19
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Width = 75
      end
      item
        Style = psOwnerDraw
        Width = 230
      end
      item
        Width = 50
      end>
    UseSystemFont = False
    OnDblClick = StatusBarDblClick
    OnMouseDown = StatusBarMouseDown
    OnDrawPanel = StatusBarDrawPanel
  end
  object DockBottom: TControlBar
    Left = 0
    Top = 728
    Width = 1353
    Height = 1
    Align = alBottom
    AutoSize = True
    BevelKind = bkNone
    RowSize = 27
    TabOrder = 1
  end
  object DockTop: TControlBar
    Left = 0
    Top = 24
    Width = 1353
    Height = 54
    Align = alTop
    AutoSize = True
    BevelKind = bkNone
    RowSize = 27
    TabOrder = 3
    object TextTB: TfrxDockToolBar
      Left = 11
      Top = 29
      Width = 658
      Height = 23
      Align = alNone
      AutoSize = True
      ButtonHeight = 23
      Caption = 'Text'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 1
      Wrapable = False
      object PanelTB1: TfrxTBPanel
        Left = 0
        Top = 0
        Width = 293
        Height = 23
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object FontSizeCB: TfrxComboBox
          Tag = 1
          Left = 248
          Top = 2
          Width = 40
          Height = 26
          Items.Strings = (
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12'
            '14'
            '16'
            '18'
            '20'
            '22'
            '24'
            '26'
            '28'
            '36'
            '48'
            '72')
          ListWidth = 0
          TabOrder = 0
          ItemIndex = -1
          OnClick = ToolButtonClick
        end
        object FontNameCB: TfrxFontComboBox
          Left = 98
          Top = 2
          Width = 145
          Height = 26
          MRURegKey = '\Software\Gestwin\MRUFont'
          DropDownCount = 12
          TabOrder = 1
          OnClick = ToolButtonClick
        end
        object StyleCB: TfrxComboBox
          Tag = 33
          Left = 0
          Top = 2
          Width = 93
          Height = 26
          ListWidth = 120
          TabOrder = 2
          ItemIndex = -1
          OnClick = ToolButtonClick
        end
      end
      object BoldB: TToolButton
        Tag = 2
        Left = 293
        Top = 0
        AllowAllUp = True
        ImageIndex = 20
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object ItalicB: TToolButton
        Tag = 3
        Left = 316
        Top = 0
        AllowAllUp = True
        ImageIndex = 21
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object UnderlineB: TToolButton
        Tag = 4
        Left = 339
        Top = 0
        AllowAllUp = True
        ImageIndex = 22
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object SepTB8: TToolButton
        Left = 362
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object FontB: TToolButton
        Tag = 43
        Left = 370
        Top = 0
        ImageIndex = 59
      end
      object FontColorB: TToolButton
        Tag = 5
        Left = 393
        Top = 0
        DropdownMenu = FontColorPopupMenu
        ImageIndex = 23
        Style = tbsDropDown
        OnClick = FontColorBClick
      end
      object HighlightB: TToolButton
        Tag = 6
        Left = 435
        Top = 0
        ImageIndex = 24
        OnClick = HighlightBClick
      end
      object RotateB: TToolButton
        Left = 458
        Top = 0
        DropdownMenu = RotationPopup
        ImageIndex = 64
      end
      object SepTB9: TToolButton
        Left = 481
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object TextAlignLeftB: TToolButton
        Tag = 7
        Left = 489
        Top = 0
        Grouped = True
        ImageIndex = 25
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object TextAlignCenterB: TToolButton
        Tag = 8
        Left = 512
        Top = 0
        Grouped = True
        ImageIndex = 26
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object TextAlignRightB: TToolButton
        Tag = 9
        Left = 535
        Top = 0
        Grouped = True
        ImageIndex = 27
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object TextAlignBlockB: TToolButton
        Tag = 10
        Left = 558
        Top = 0
        Grouped = True
        ImageIndex = 28
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object SepTB10: TToolButton
        Left = 581
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object TextAlignTopB: TToolButton
        Tag = 11
        Left = 589
        Top = 0
        Grouped = True
        ImageIndex = 29
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object TextAlignMiddleB: TToolButton
        Tag = 12
        Left = 612
        Top = 0
        Grouped = True
        ImageIndex = 30
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object TextAlignBottomB: TToolButton
        Tag = 13
        Left = 635
        Top = 0
        Grouped = True
        ImageIndex = 31
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
    end
    object FrameTB: TfrxDockToolBar
      Left = 682
      Top = 29
      Width = 354
      Height = 23
      Align = alNone
      AutoSize = True
      ButtonHeight = 23
      Caption = 'Frame'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 2
      Wrapable = False
      object FrameTopB: TToolButton
        Tag = 20
        Left = 0
        Top = 0
        AllowAllUp = True
        ImageIndex = 32
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object FrameBottomB: TToolButton
        Tag = 21
        Left = 23
        Top = 0
        AllowAllUp = True
        ImageIndex = 33
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object FrameLeftB: TToolButton
        Tag = 22
        Left = 46
        Top = 0
        AllowAllUp = True
        ImageIndex = 34
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object FrameRightB: TToolButton
        Tag = 23
        Left = 69
        Top = 0
        AllowAllUp = True
        ImageIndex = 35
        Style = tbsCheck
        OnClick = ToolButtonClick
      end
      object SepTB11: TToolButton
        Left = 92
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object FrameAllB: TToolButton
        Tag = 24
        Left = 100
        Top = 0
        ImageIndex = 36
        OnClick = ToolButtonClick
      end
      object FrameNoB: TToolButton
        Tag = 25
        Left = 123
        Top = 0
        ImageIndex = 37
        OnClick = ToolButtonClick
      end
      object FrameEditB: TToolButton
        Tag = 32
        Left = 146
        Top = 0
        ImageIndex = 60
        OnClick = ToolButtonClick
      end
      object SepTB12: TToolButton
        Left = 169
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object FillColorB: TToolButton
        Tag = 26
        Left = 177
        Top = 0
        DropdownMenu = FillColorPopupMenu
        ImageIndex = 38
        Style = tbsDropDown
        OnClick = FillColorBClick
      end
      object FillEditB: TToolButton
        Tag = 44
        Left = 219
        Top = 0
        ImageIndex = 109
        OnClick = ToolButtonClick
      end
      object FrameColorB: TToolButton
        Tag = 27
        Left = 242
        Top = 0
        DropdownMenu = FrameColorPopupMenu
        ImageIndex = 39
        Style = tbsDropDown
        OnClick = FrameColorBClick
      end
      object FrameStyleB: TToolButton
        Tag = 28
        Left = 284
        Top = 0
        ImageIndex = 40
        OnClick = FrameStyleBClick
      end
      object PanelTB2: TfrxTBPanel
        Left = 307
        Top = 0
        Width = 47
        Height = 23
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object FrameWidthCB: TfrxComboBox
          Tag = 29
          Left = 5
          Top = 2
          Width = 40
          Height = 26
          Items.Strings = (
            '0,1'
            '0,5'
            '1'
            '1,5'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
          ListWidth = 0
          TabOrder = 0
          ItemIndex = -1
          OnClick = ToolButtonClick
        end
      end
    end
    object StandardTB: TfrxDockToolBar
      Left = 11
      Top = 2
      Width = 495
      Height = 23
      Align = alNone
      AutoSize = True
      ButtonHeight = 23
      Caption = 'Standard'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 3
      Wrapable = False
      object NewB: TToolButton
        Tag = 40
        Left = 0
        Top = 0
        Action = NewReportCmd
      end
      object OpenB: TToolButton
        Tag = 41
        Left = 23
        Top = 0
        Action = OpenCmd
      end
      object SaveB: TToolButton
        Tag = 42
        Left = 46
        Top = 0
        Action = SaveCmd
      end
      object PreviewB: TToolButton
        Tag = 43
        Left = 69
        Top = 0
        Action = PreviewCmd
      end
      object SepTB4: TToolButton
        Left = 92
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object NewPageB: TToolButton
        Tag = 52
        Left = 100
        Top = 0
        Action = NewPageCmd
      end
      object NewDialogB: TToolButton
        Tag = 70
        Left = 123
        Top = 0
        Action = NewDialogCmd
      end
      object DeletePageB: TToolButton
        Tag = 53
        Left = 146
        Top = 0
        Action = DeletePageCmd
      end
      object PageSettingsB: TToolButton
        Tag = 54
        Left = 169
        Top = 0
        Action = PageSettingsCmd
      end
      object FindB: TToolButton
        Left = 192
        Top = 0
        Caption = 'Buscar'
        ImageIndex = 134
        Style = tbsCheck
        OnClick = FindBClick
      end
      object SepTB13: TToolButton
        Left = 215
        Top = 0
        Width = 8
        ImageIndex = 21
        Style = tbsSeparator
      end
      object CutB: TToolButton
        Tag = 44
        Left = 223
        Top = 0
        Action = CutCmd
      end
      object CopyB: TToolButton
        Tag = 45
        Left = 246
        Top = 0
        Action = CopyCmd
      end
      object PasteB: TToolButton
        Tag = 46
        Left = 269
        Top = 0
        Action = PasteCmd
      end
      object SepTB2: TToolButton
        Left = 292
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object UndoB: TToolButton
        Tag = 47
        Left = 300
        Top = 0
        Action = UndoCmd
      end
      object RedoB: TToolButton
        Tag = 48
        Left = 323
        Top = 0
        Action = RedoCmd
      end
      object SepTB3: TToolButton
        Left = 346
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object GroupB: TToolButton
        Left = 354
        Top = 0
        Action = GroupCmd
        ImageIndex = 17
      end
      object UngroupB: TToolButton
        Left = 377
        Top = 0
        Action = UngroupCmd
      end
      object SepTB20: TToolButton
        Left = 400
        Top = 0
        Width = 8
        ImageIndex = 60
        Style = tbsSeparator
      end
      object IntersectionsSelectionB: TToolButton
        Left = 408
        Top = 0
        Caption = 'IntersectionsSelection'
        ImageIndex = 135
        Style = tbsCheck
        OnClick = IntersectionsSelectionBClick
      end
      object SepTB21: TToolButton
        Left = 431
        Top = 0
        Width = 8
        ImageIndex = 0
        Style = tbsSeparator
      end
      object PanelTB3: TfrxTBPanel
        Left = 439
        Top = 0
        Width = 56
        Height = 23
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object ScaleCB: TfrxComboBox
          Left = 0
          Top = 2
          Width = 52
          Height = 26
          Hint = 'Scale'
          Items.Strings = (
            '25%'
            '50%'
            '75%'
            '100%'
            '150%'
            '200%'
            'Page width'
            'Whole page')
          ListWidth = 100
          TabOrder = 0
          Text = '100%'
          ItemIndex = -1
          OnClick = ScaleCBClick
        end
      end
    end
    object ExtraToolsTB: TToolBar
      Left = 917
      Top = 2
      Width = 0
      Height = 23
      Align = alNone
      AutoSize = True
      ButtonHeight = 23
      Caption = 'Extra Tools'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 4
      Wrapable = False
    end
    object AlignTB: TfrxDockToolBar
      Left = 519
      Top = 2
      Width = 385
      Height = 23
      Align = alNone
      AutoSize = True
      ButtonHeight = 23
      Caption = 'Align'
      DragKind = dkDock
      DragMode = dmAutomatic
      TabOrder = 0
      Wrapable = False
      object ShowGridB: TToolButton
        Tag = 55
        Left = 0
        Top = 0
        AllowAllUp = True
        ImageIndex = 18
        Style = tbsCheck
        OnClick = ShowGridBClick
      end
      object AlignToGridB: TToolButton
        Tag = 56
        Left = 23
        Top = 0
        AllowAllUp = True
        ImageIndex = 19
        Style = tbsCheck
        OnClick = AlignToGridBClick
      end
      object SetToGridB: TToolButton
        Tag = 31
        Left = 46
        Top = 0
        ImageIndex = 57
        OnClick = ToolButtonClick
      end
      object ToolButton1: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 85
        Style = tbsSeparator
      end
      object AlignLeftsB: TToolButton
        Tag = 60
        Left = 77
        Top = 0
        Caption = 'AlignLeftsB'
        ImageIndex = 41
        OnClick = AlignLeftsBClick
      end
      object AlignHorzCentersB: TToolButton
        Tag = 60
        Left = 100
        Top = 0
        Caption = 'AlignHorzCentersB'
        ImageIndex = 42
        OnClick = AlignHorzCentersBClick
      end
      object AlignRightsB: TToolButton
        Tag = 60
        Left = 123
        Top = 0
        Caption = 'AlignRightsB'
        ImageIndex = 45
        OnClick = AlignRightsBClick
      end
      object SepTB15: TToolButton
        Left = 146
        Top = 0
        Width = 8
        ImageIndex = 85
        Style = tbsSeparator
      end
      object AlignTopsB: TToolButton
        Tag = 60
        Left = 154
        Top = 0
        Caption = 'AlignTopsB'
        ImageIndex = 46
        OnClick = AlignTopsBClick
      end
      object AlignVertCentersB: TToolButton
        Tag = 60
        Left = 177
        Top = 0
        Caption = 'AlignVertCentersB'
        ImageIndex = 47
        OnClick = AlignVertCentersBClick
      end
      object AlignBottomsB: TToolButton
        Tag = 60
        Left = 200
        Top = 0
        Caption = 'AlignBottomsB'
        ImageIndex = 50
        OnClick = AlignBottomsBClick
      end
      object SepTB16: TToolButton
        Left = 223
        Top = 0
        Width = 8
        ImageIndex = 85
        Style = tbsSeparator
      end
      object SpaceHorzB: TToolButton
        Tag = 60
        Left = 231
        Top = 0
        Caption = 'SpaceHorzB'
        ImageIndex = 44
        OnClick = SpaceHorzBClick
      end
      object SpaceVertB: TToolButton
        Tag = 60
        Left = 254
        Top = 0
        Caption = 'SpaceVertB'
        ImageIndex = 49
        OnClick = SpaceVertBClick
      end
      object SepTB17: TToolButton
        Left = 277
        Top = 0
        Width = 8
        ImageIndex = 86
        Style = tbsSeparator
      end
      object CenterHorzB: TToolButton
        Tag = 60
        Left = 285
        Top = 0
        Caption = 'CenterHorzB'
        ImageIndex = 43
        OnClick = CenterHorzBClick
      end
      object CenterVertB: TToolButton
        Tag = 60
        Left = 308
        Top = 0
        Caption = 'CenterVertB'
        ImageIndex = 48
        OnClick = CenterVertBClick
      end
      object SepTB18: TToolButton
        Left = 331
        Top = 0
        Width = 8
        ImageIndex = 85
        Style = tbsSeparator
      end
      object SameWidthB: TToolButton
        Left = 339
        Top = 0
        Caption = 'SameWidthB'
        ImageIndex = 83
        OnClick = SameWidthBClick
      end
      object SameHeightB: TToolButton
        Left = 362
        Top = 0
        Caption = 'SameHeightB'
        ImageIndex = 84
        OnClick = SameHeightBClick
      end
    end
  end
  object LeftDockSite1: TfrxDockSite
    Left = 0
    Top = 78
    Width = 17
    Height = 650
    Align = alLeft
    AutoSize = True
    BevelOuter = bvNone
    Caption = ' '
    DockSite = True
    TabOrder = 2
    OnDockOver = CodeDockSiteDockOver
  end
  object ObjectsTB1: TToolBar
    Left = 23
    Top = 78
    Width = 27
    Height = 650
    Align = alLeft
    BorderWidth = 1
    ButtonHeight = 23
    TabOrder = 4
    Wrapable = False
  end
  object BackPanel: TPanel
    Left = 50
    Top = 78
    Width = 1303
    Height = 650
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object ScrollBoxPanel: TPanel
      Left = 65
      Top = 95
      Width = 297
      Height = 297
      BevelOuter = bvNone
      TabOrder = 0
      object ScrollBox: TfrxScrollBox
        Left = 21
        Top = 22
        Width = 276
        Height = 275
        HorzScrollBar.Margin = 10
        HorzScrollBar.Tracking = True
        VertScrollBar.Margin = 10
        VertScrollBar.Tracking = True
        Align = alClient
        BorderStyle = bsNone
        Color = clGray
        ParentColor = False
        TabOrder = 0
        OnMouseWheelDown = ScrollBoxMouseWheelDown
        OnMouseWheelUp = ScrollBoxMouseWheelUp
        OnResize = ScrollBoxResize
      end
      object LeftRuler: TfrxRuler
        Left = 0
        Top = 22
        Width = 21
        Height = 275
        Cursor = crHandPoint
        Align = alLeft
        DragCursor = crHSplit
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnDragOver = TopRulerDragOver
        Offset = 0
        Scale = 1.000000000000000000
        Start = 0
        Units = ruCM
        Size = 0
      end
      object TopRuler: TfrxRuler
        Left = 0
        Top = 0
        Width = 297
        Height = 22
        Cursor = crHandPoint
        Align = alTop
        DragCursor = crVSplit
        DragMode = dmAutomatic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnDragOver = TopRulerDragOver
        Offset = 22
        Scale = 1.000000000000000000
        Start = 0
        Units = ruCM
        Size = 0
      end
    end
    object CodePanel: TPanel
      Left = 394
      Top = 98
      Width = 377
      Height = 289
      BevelOuter = bvNone
      TabOrder = 1
      object CodeTB: TToolBar
        Left = 0
        Top = 0
        Width = 377
        Height = 25
        ButtonHeight = 23
        TabOrder = 0
        object frTBPanel1: TfrxTBPanel
          Left = 0
          Top = 0
          Width = 169
          Height = 23
          Align = alLeft
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object LangL: TLabel
            Left = 4
            Top = 4
            Width = 68
            Height = 20
            Caption = 'Language:'
          end
          object LangCB: TfrxComboBox
            Left = 60
            Top = 2
            Width = 100
            Height = 26
            ListWidth = 0
            TabOrder = 0
            ItemIndex = -1
            OnClick = LangCBClick
          end
        end
        object OpenScriptB: TToolButton
          Left = 169
          Top = 0
          ImageIndex = 1
          OnClick = OpenScriptBClick
        end
        object SaveScriptB: TToolButton
          Left = 192
          Top = 0
          ImageIndex = 2
          OnClick = SaveScriptBClick
        end
        object SepTB19: TToolButton
          Left = 215
          Top = 0
          Width = 8
          ImageIndex = 73
          Style = tbsSeparator
        end
        object RunScriptB: TToolButton
          Left = 223
          Top = 0
          ImageIndex = 90
          OnClick = RunScriptBClick
        end
        object RunToCursorB: TToolButton
          Left = 246
          Top = 0
          ImageIndex = 95
          OnClick = RunToCursorBClick
        end
        object StepScriptB: TToolButton
          Left = 269
          Top = 0
          ImageIndex = 91
          OnClick = RunScriptBClick
        end
        object StepOverScriptB: TToolButton
          Left = 292
          Top = 0
          ImageIndex = 96
          OnClick = RunScriptBClick
        end
        object StepReturnScriptB: TToolButton
          Left = 315
          Top = 0
          ImageIndex = 140
          OnClick = RunScriptBClick
        end
        object StopScriptB: TToolButton
          Left = 338
          Top = 0
          ImageIndex = 93
          OnClick = StopScriptBClick
        end
        object EvaluateB: TToolButton
          Left = 361
          Top = 0
          ImageIndex = 92
          OnClick = EvaluateBClick
        end
        object BreakPointB: TToolButton
          Left = 384
          Top = 0
          ImageIndex = 94
          OnClick = BreakPointBClick
        end
      end
      object CodeDockSite: TfrxDockSite
        Left = 0
        Top = 279
        Width = 377
        Height = 10
        Align = alBottom
        AutoSize = True
        BevelOuter = bvNone
        Caption = ' '
        Constraints.MaxHeight = 268
        DockSite = True
        TabOrder = 1
        OnDockOver = CodeDockSiteDockOver
      end
    end
    object LeftDockSite2: TfrxDockSite
      Left = 0
      Top = 24
      Width = 9
      Height = 626
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      DockSite = True
      TabOrder = 2
      OnDockOver = CodeDockSiteDockOver
    end
    object RightDockSite: TfrxDockSite
      Left = 1295
      Top = 24
      Width = 8
      Height = 626
      Align = alRight
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      DockSite = True
      TabOrder = 3
      OnDockOver = CodeDockSiteDockOver
    end
    object TabPanel: TPanel
      Left = 0
      Top = 0
      Width = 1303
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
    end
  end
  object PagePopup: TPopupMenu
    AutoPopup = False
    OnPopup = PagePopupPopup
    Left = 216
    Top = 284
    object EditMI1: TMenuItem
      Action = EditCmd
    end
    object AddChildMI: TMenuItem
      Caption = 'Add child band'
      OnClick = AddChildMIClick
    end
    object SepMI12: TMenuItem
      Caption = '-'
    end
    object SepMI8: TMenuItem
      Caption = '-'
    end
    object CutMI1: TMenuItem
      Action = CutCmd
    end
    object CopyMI1: TMenuItem
      Action = CopyCmd
    end
    object CopyContent2: TMenuItem
      Action = CopyContentCmd
    end
    object PasteMI1: TMenuItem
      Action = PasteCmd
    end
    object DeleteMI1: TMenuItem
      Action = DeleteCmd
    end
    object SelectAllMI1: TMenuItem
      Action = SelectAllCmd
    end
    object SelectAllOfTypeMI: TMenuItem
      Action = SelectAllOfTypeCmd
      Caption = 'Select same type on Parent'
    end
    object SelectAllOfTypeOnPageMI: TMenuItem
      Caption = 'Select same type on Page'
      OnClick = SelectAllOfTypeCmdExecute
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object BringtoFrontMI1: TMenuItem
      Action = BringToFrontCmd
    end
    object SendtoBackMI1: TMenuItem
      Action = SendToBackCmd
    end
    object TabOrderMI: TMenuItem
      Caption = 'Tab Order...'
      OnClick = TabOrderMIClick
    end
    object RevertInheritedMI: TMenuItem
      Caption = 'Reset to Parent object'
      OnClick = RevertInheritedMIClick
    end
    object RevertInheritedChildMI: TMenuItem
      Caption = 'Reset to Parent object with childs'
      OnClick = RevertInheritedMIClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 350
    Top = 316
  end
  object TabPopup: TPopupMenu
    Left = 216
    Top = 316
    object NewPageMI1: TMenuItem
      Action = NewPageCmd
    end
    object NewDialogMI1: TMenuItem
      Action = NewDialogCmd
    end
    object DeletePageMI1: TMenuItem
      Action = DeletePageCmd
    end
    object PageSettingsMI1: TMenuItem
      Action = PageSettingsCmd
    end
  end
  object ActionList: TActionList
    Left = 154
    Top = 284
    object UndoCmd: TAction
      Category = 'Edit'
      Caption = 'Undo'
      ImageIndex = 8
      ShortCut = 16474
      OnExecute = UndoCmdExecute
    end
    object RedoCmd: TAction
      Category = 'Edit'
      Caption = 'Redo'
      ImageIndex = 9
      OnExecute = RedoCmdExecute
    end
    object CutCmd: TAction
      Category = 'Edit'
      Caption = 'Cut'
      ImageIndex = 5
      ShortCut = 16472
      OnExecute = CutCmdExecute
    end
    object CopyCmd: TAction
      Category = 'Edit'
      Caption = 'Copy'
      ImageIndex = 6
      ShortCut = 16451
      OnExecute = CopyCmdExecute
    end
    object CopyContentCmd: TAction
      Category = 'Edit'
      Caption = 'Copy Content'
      ImageIndex = 6
      ShortCut = 49219
      OnExecute = CopyContentCmdExecute
    end
    object PasteCmd: TAction
      Category = 'Edit'
      Caption = 'Paste'
      Enabled = False
      ImageIndex = 7
      ShortCut = 16470
      OnExecute = PasteCmdExecute
    end
    object DeleteCmd: TAction
      Category = 'Edit'
      Caption = 'Delete'
      ImageIndex = 51
      OnExecute = DeleteCmdExecute
    end
    object DeletePageCmd: TAction
      Category = 'Edit'
      Caption = 'Delete Page'
      ImageIndex = 12
      OnExecute = DeletePageCmdExecute
    end
    object SelectAllCmd: TAction
      Category = 'Edit'
      Caption = 'Select All'
      ShortCut = 16449
      OnExecute = SelectAllCmdExecute
    end
    object EditCmd: TAction
      Category = 'Edit'
      Caption = 'Edit...'
      OnExecute = EditCmdExecute
    end
    object BringToFrontCmd: TAction
      Category = 'Edit'
      Caption = 'Bring to Front'
      ImageIndex = 14
      OnExecute = BringToFrontCmdExecute
    end
    object SendToBackCmd: TAction
      Category = 'Edit'
      Caption = 'Send to Back'
      ImageIndex = 15
      OnExecute = SendToBackCmdExecute
    end
    object NewItemCmd: TAction
      Category = 'File'
      Caption = 'New...'
      OnExecute = NewItemCmdExecute
    end
    object NewReportCmd: TAction
      Category = 'File'
      Caption = 'New Report'
      ImageIndex = 0
      OnExecute = NewReportCmdExecute
    end
    object NewPageCmd: TAction
      Category = 'File'
      Caption = 'New Page'
      ImageIndex = 10
      OnExecute = NewPageCmdExecute
    end
    object NewDialogCmd: TAction
      Category = 'File'
      Caption = 'New Dialog'
      ImageIndex = 11
      OnExecute = NewDialogCmdExecute
    end
    object OpenCmd: TAction
      Category = 'File'
      Caption = 'Open...'
      ImageIndex = 1
      ShortCut = 16463
      OnExecute = OpenCmdExecute
    end
    object SaveCmd: TAction
      Category = 'File'
      Caption = 'Save'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = SaveCmdExecute
    end
    object SaveAsCmd: TAction
      Category = 'File'
      Caption = 'Save As...'
      OnExecute = SaveAsCmdExecute
    end
    object PageSettingsCmd: TAction
      Category = 'File'
      Caption = 'Page Settings...'
      ImageIndex = 13
      OnExecute = PageSettingsCmdExecute
    end
    object PreviewCmd: TAction
      Category = 'File'
      Caption = 'Preview'
      ImageIndex = 3
      ShortCut = 16464
      OnExecute = PreviewCmdExecute
    end
    object ExitCmd: TAction
      Category = 'File'
      Caption = 'Exit'
      ShortCut = 32856
      OnExecute = ExitCmdExecute
    end
    object GroupCmd: TAction
      Category = 'Edit'
      Caption = 'Group'
      ImageIndex = 94
      OnExecute = GroupCmdExecute
    end
    object UngroupCmd: TAction
      Category = 'Edit'
      Caption = 'Ungroup'
      ImageIndex = 16
      OnExecute = UngroupCmdExecute
    end
    object FindCmd: TAction
      Category = 'Edit'
      Caption = 'Find...'
      ShortCut = 16454
      OnExecute = FindCmdExecute
    end
    object ReplaceCmd: TAction
      Category = 'Edit'
      Caption = 'Replace...'
      ShortCut = 16466
      OnExecute = ReplaceCmdExecute
    end
    object FindNextCmd: TAction
      Category = 'Edit'
      Caption = 'Find Next'
      Enabled = False
      ShortCut = 114
      OnExecute = FindNextCmdExecute
    end
    object ReportDataCmd: TAction
      Category = 'Report'
      Caption = 'Data...'
      ImageIndex = 53
      OnExecute = ReportDataCmdExecute
    end
    object VariablesCmd: TAction
      Category = 'Report'
      Caption = 'Variables...'
      ImageIndex = 52
      OnExecute = VariablesCmdExecute
    end
    object ReportStylesCmd: TAction
      Category = 'Report'
      Caption = 'Styles...'
      ImageIndex = 87
      OnExecute = ReportStylesCmdExecute
    end
    object ReportOptionsCmd: TAction
      Category = 'Report'
      Caption = 'Options...'
      OnExecute = ReportOptionsCmdExecute
    end
    object ShowRulersCmd: TAction
      Category = 'View'
      Caption = 'Rulers'
      OnExecute = ShowRulersCmdExecute
    end
    object ShowGuidesCmd: TAction
      Category = 'View'
      Caption = 'Guides'
      OnExecute = ShowGuidesCmdExecute
    end
    object AutoGuidesCmd: TAction
      Category = 'View'
      Caption = 'Auto Guides'
      OnExecute = AutoGuidesCmdExecute
    end
    object DeleteHGuidesCmd: TAction
      Category = 'View'
      Caption = 'Delete Horizontal Guides'
      OnExecute = DeleteHGuidesCmdExecute
    end
    object DeleteVGuidesCmd: TAction
      Category = 'View'
      Caption = 'Delete Vertical Guides'
      OnExecute = DeleteVGuidesCmdExecute
    end
    object OptionsCmd: TAction
      Category = 'View'
      Caption = 'Options...'
      OnExecute = OptionsCmdExecute
    end
    object HelpContentsCmd: TAction
      Category = 'Help'
      Caption = 'Help Contents...'
      ShortCut = 112
      OnExecute = HelpContentsCmdExecute
    end
    object AboutCmd: TAction
      Category = 'Help'
      Caption = 'About FastReport...'
      OnExecute = AboutCmdExecute
    end
    object StandardTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Standard'
      OnExecute = StandardTBCmdExecute
    end
    object TextTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Text'
      OnExecute = TextTBCmdExecute
    end
    object FrameTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Frame'
      OnExecute = FrameTBCmdExecute
    end
    object AlignTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Alignment Palette'
      OnExecute = AlignTBCmdExecute
    end
    object ExtraTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Extra Tools'
      OnExecute = ExtraTBCmdExecute
    end
    object InspectorTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Object Inspector'
      ShortCut = 122
      OnExecute = InspectorTBCmdExecute
    end
    object DataTreeTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Data Tree'
      OnExecute = DataTreeTBCmdExecute
    end
    object ReportTreeTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Report Tree'
      OnExecute = ReportTreeTBCmdExecute
    end
    object ToolbarsCmd: TAction
      Category = 'Toolbars'
      Caption = 'Toolbars'
      OnExecute = ToolbarsCmdExecute
    end
    object WatchTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Watch List'
      OnExecute = WatchTBCmdExecute
    end
    object BreakPointsTBCmd: TAction
      Category = 'Toolbars'
      Caption = 'Break Points List'
      OnExecute = BreakPointsTBCmdExecute
    end
    object SelectAllOfTypeCmd: TAction
      Category = 'Edit'
      Caption = 'SelectAllOfTypeCmd'
      OnExecute = SelectAllOfTypeCmdExecute
    end
    object EdConfigCmd: TAction
      Category = 'View'
      Caption = 'Editors configurator ..'
      OnExecute = EdConfigCmdExecute
    end
  end
  object BandsPopup: TPopupMenu
    OnPopup = BandsPopupPopup
    Left = 274
    Top = 316
    object ReportTitleMI: TMenuItem
      Caption = 'Report Title'
      OnClick = InsertBandClick
    end
    object ReportSummaryMI: TMenuItem
      Tag = 1
      Caption = 'Report Summary'
      OnClick = InsertBandClick
    end
    object PageHeaderMI: TMenuItem
      Tag = 2
      Caption = 'Page Header'
      OnClick = InsertBandClick
    end
    object PageFooterMI: TMenuItem
      Tag = 3
      Caption = 'Page Footer'
      OnClick = InsertBandClick
    end
    object HeaderMI: TMenuItem
      Tag = 4
      Caption = 'Header'
      OnClick = InsertBandClick
    end
    object FooterMI: TMenuItem
      Tag = 5
      Caption = 'Footer'
      OnClick = InsertBandClick
    end
    object MasterDataMI: TMenuItem
      Tag = 6
      Caption = 'Master Data'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object DetailDataMI: TMenuItem
      Tag = 7
      Caption = 'Detail Data'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object SubdetailDataMI: TMenuItem
      Tag = 8
      Caption = 'Subdetail Data'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object Data4levelMI: TMenuItem
      Tag = 9
      Caption = 'Data 4th level'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object Data5levelMI: TMenuItem
      Tag = 10
      Caption = 'Data 5th level'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object Data6levelMI: TMenuItem
      Tag = 11
      Caption = 'Data 6th level'
      ImageIndex = 53
      OnClick = InsertBandClick
    end
    object GroupHeaderMI: TMenuItem
      Tag = 12
      Caption = 'Group Header'
      ImageIndex = 61
      OnClick = InsertBandClick
    end
    object GroupFooterMI: TMenuItem
      Tag = 13
      Caption = 'Group Footer'
      OnClick = InsertBandClick
    end
    object ChildMI: TMenuItem
      Tag = 14
      Caption = 'Child'
      OnClick = InsertBandClick
    end
    object ColumnHeaderMI: TMenuItem
      Tag = 15
      Caption = 'Column Header'
      OnClick = InsertBandClick
    end
    object ColumnFooterMI: TMenuItem
      Tag = 16
      Caption = 'Column Footer'
      OnClick = InsertBandClick
    end
    object OverlayMI: TMenuItem
      Tag = 17
      Caption = 'Overlay'
      OnClick = InsertBandClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object VerticalbandsMI: TMenuItem
      Caption = 'Vertical bands'
      object HeaderMI1: TMenuItem
        Tag = 104
        Caption = 'Header'
        OnClick = InsertBandClick
      end
      object FooterMI1: TMenuItem
        Tag = 105
        Caption = 'Footer'
        OnClick = InsertBandClick
      end
      object MasterDataMI1: TMenuItem
        Tag = 106
        Caption = 'Master Data'
        ImageIndex = 53
        OnClick = InsertBandClick
      end
      object DetailDataMI1: TMenuItem
        Tag = 107
        Caption = 'Detail Data'
        ImageIndex = 53
        OnClick = InsertBandClick
      end
      object SubdetailDataMI1: TMenuItem
        Tag = 108
        Caption = 'Subdetail Data'
        ImageIndex = 53
        OnClick = InsertBandClick
      end
      object GroupHeaderMI1: TMenuItem
        Tag = 112
        Caption = 'Group Header'
        ImageIndex = 61
        OnClick = InsertBandClick
      end
      object GroupFooterMI1: TMenuItem
        Tag = 113
        Caption = 'Group Footer'
        OnClick = InsertBandClick
      end
      object ChildMI1: TMenuItem
        Tag = 114
        Caption = 'Child'
        OnClick = InsertBandClick
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 407
    Top = 336
  end
  object RotationPopup: TPopupMenu
    Left = 308
    Top = 316
    object R0MI: TMenuItem
      Tag = 30
      Caption = '0'
      OnClick = ToolButtonClick
    end
    object R45MI: TMenuItem
      Tag = 30
      Caption = '45'
      HelpContext = 45
      OnClick = ToolButtonClick
    end
    object R90MI: TMenuItem
      Tag = 30
      Caption = '90'
      HelpContext = 90
      OnClick = ToolButtonClick
    end
    object R180MI: TMenuItem
      Tag = 30
      Caption = '180'
      HelpContext = 180
      OnClick = ToolButtonClick
    end
    object R270MI: TMenuItem
      Tag = 30
      Caption = '270'
      HelpContext = 270
      OnClick = ToolButtonClick
    end
  end
  object OpenScriptDialog: TOpenDialog
    Left = 432
    Top = 120
  end
  object SaveScriptDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 470
    Top = 120
  end
  object ObjectsPopup: TPopupMenu
    Left = 269
    Top = 284
  end
  object DMPPopup: TPopupMenu
    Left = 310
    Top = 284
    object BoldMI: TMenuItem
      Tag = 34
      Caption = 'Bold'
      OnClick = ToolButtonClick
    end
    object ItalicMI: TMenuItem
      Tag = 35
      Caption = 'Italic'
      OnClick = ToolButtonClick
    end
    object UnderlineMI: TMenuItem
      Tag = 36
      Caption = 'Underline'
      OnClick = ToolButtonClick
    end
    object SuperScriptMI: TMenuItem
      Tag = 37
      Caption = 'SuperScript'
      OnClick = ToolButtonClick
    end
    object SubScriptMI: TMenuItem
      Tag = 38
      Caption = 'SubScript'
      OnClick = ToolButtonClick
    end
    object CondensedMI: TMenuItem
      Tag = 39
      Caption = 'Condensed'
      OnClick = ToolButtonClick
    end
    object WideMI: TMenuItem
      Tag = 40
      Caption = 'Wide'
      OnClick = ToolButtonClick
    end
    object N12cpiMI: TMenuItem
      Tag = 41
      Caption = '12 cpi'
      OnClick = ToolButtonClick
    end
    object N15cpiMI: TMenuItem
      Tag = 42
      Caption = '15 cpi'
      OnClick = ToolButtonClick
    end
  end
  object FontColorPopupMenu: TPopupMenu
    OnPopup = FontColorPopupMenuPopup
    Left = 394
    Top = 119
  end
  object FillColorPopupMenu: TPopupMenu
    OnPopup = FillColorPopupMenuPopup
    Left = 850
    Top = 99
  end
  object FrameColorPopupMenu: TPopupMenu
    OnPopup = FrameColorPopupMenuPopup
    Left = 890
    Top = 99
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'File'
      'Edit'
      'Report'
      'View'
      'Help'
      'Menus')
    Categories.ItemsVisibles = (
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
      True)
    ImageOptions.SmoothGlyphs = True
    ImageOptions.StretchGlyphs = False
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 155
    Top = 321
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      23
      0)
    object BarManagerMainMenu: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Main Menu'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 0
      FloatTop = 0
      FloatClientWidth = 51
      FloatClientHeight = 84
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemLinks = <
        item
          Visible = True
          ItemName = 'FileMenu'
        end
        item
          Visible = True
          ItemName = 'EditMenu'
        end
        item
          Visible = True
          ItemName = 'ReportMenu'
        end
        item
          Visible = True
          ItemName = 'ViewMenu'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      ShowMark = False
      SizeGrip = False
      UseOwnFont = True
      Visible = True
      WholeRow = False
    end
    object NewButton: TdxBarButton
      Category = 0
      Visible = ivAlways
      ImageIndex = 0
    end
    object dxBarButton1: TdxBarButton
      Caption = '&Ficheros recientes'
      Category = 0
      Hint = 'Ficheros recientes'
      Visible = ivAlways
    end
    object FicherosRecientesItem: TdxBarSubItem
      Caption = '&Ficheros recientes'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      LargeGlyph.SourceDPI = 96
      LargeGlyph.Data = {
        424D360900000000000036000000280000001800000018000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        000000000000000000004F4F4FCF525252FF4D4D4DFF4D4D4DFF4D4D4DFF4D4D
        4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D
        4DFF4D4D4DFF4D4D4DFF4D4D4DFF525252FF525252D700000000000000000000
        00000000000000000000515151FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF525252FF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFC0987BFFC098
        7BFFC0987BFFC0987BFFC0987BFFC0987BFFC0987BFFC0987BFFC0987BFFC098
        7BFFC0987BFFC0987BFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFDBC4B3FFDBC4
        B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4
        B3FFDBC4B3FFC0987BFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFFFFFFFFFFFFFFFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFC0987BFFDBC4B3FFDBC4
        B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4B3FFDBC4
        B3FFDBC4B3FFC0987BFFFFFFFFFFFEFEFEFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFEFEFEFFFDFDFDFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFB17533FFB175
        33FFEDE0D3FFB17533FFB17533FFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFDFDFDFFFDFDFDFF4D4D4DFF00000000000000000000
        000000000000000000004D4D4DFFFFFFFFFFFFFFFFFFFFFFFFFFB17533FFB175
        33FFEDE0D3FFB17533FFB17533FFFFFFFFFFDBC4B3FFDBC4B3FFDBC4B3FFDBC4
        B3FFDBC4B3FFC0987BFFFDFDFDFFFDFDFDFF4D4D4DFF00000000000000000000
        000000000000000000002525257ABABABABAFFFFFFFFFFFFFFFFB17533FFB175
        33FFEDE0D3FFB17533FFB17533FFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFDFDFDFFFDFDFDFF4D4D4DFF00000000000000000000
        00000000000000000000397A9B9B0E0E0E0EFBFBFBFB83838383724B21A4B175
        33FFEDE0D3FFB17533FFB17533FFFFFFFFFFDBC4B3FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC0987BFFFDFDFDFFFDFDFDFF4D4D4DFF000000000C1A21212249
        5D5D000000000001010151ADE7FF00000000535353531B3948480F1E2525A4A4
        A4A4FFFFFFFFB17533FFB17533FFFFFFFFFFC0987BFFC0987BFFC0987BFFC098
        7BFFC0987BFFC0987BFFFDFDFDFFFBFBFBFF525252FE00000000142B373751AD
        E7FF1C3D51530102030351ADE7FF020305051329373851ADE7FF1C3B4B4B8181
        8181FFFFFFFFB17533FFB17533FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFEFEFEFFFBFBFBFF525252FF00000000000000000D1B
        242551ADE7FF4491C1D551ADE7FF418AB9CC51ADE7FF142C3B3C49494949F6F6
        F6F6FFFFFFFFB17533FFB17533FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D
        4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF525252FF00000000020405050409
        0C0D418CBBCE4EA8E0F726516C6E50AAE3FB4089B7CA03050708020507070909
        0909BFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D
        4DFFFDFDFDFFFFFFFFFFFFFFFFFFBABABAFF616161FF0000000051ADE7FF51AD
        E7FF51ADE7FF254E696B010101042856737551ADE7FF51ADE7FF51ADE7FF336C
        898987878787FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D
        4DFFFDFDFDFFFFFFFFFFBBBBBBFF616161FE1717173B00000000000000000000
        0000438EBED250AAE3FB2857747651ADE7FF3F86B2C500000000020202021818
        1818C8C8C8C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4D4D
        4DFFFDFDFDFFBFBFBFFF616161FF1717173B0000000000000000000000001B3B
        4E5051ADE7FF3F86B3C651ADE7FF4088B5C851ADE7FF142B3A3B5B5B5B5BFCFC
        FCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5252
        52FFBDBDBDFF616161FF1717173B0000000000000000000000002045575751AD
        E7FF0F202A2B0000000051ADE7FF02030505142C3B3C51ADE7FF1A3746462A2A
        2A8C4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF4D4D4DFF5252
        52FF5C5C5CF31717173B0000000000000000000000000000000008111616152D
        3939000000000000000051ADE7FF00000000000000001B394848091318180000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      LargeImageIndex = 0
      ShowCaption = False
      SyncImageIndex = False
      ImageIndex = 0
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      LargeGlyph.SourceDPI = 96
      LargeGlyph.Data = {
        424D360900000000000036000000280000001800000018000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000008090912000000004C88
        AEBE66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF63B1E3F71729343900000000000000003E3F4084000000004C87
        ACBE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE3865818D0000000000000000585859BC00000000355C
        758466B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE508FB7C70000000000000000707070EE030303061D31
        3D4866B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF62B0E1F505090C0D00000000787878FE1517182E070A
        0D1065B5E7FC65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF192D3A3F00000000787878FF2F3132650000
        00005496C0D265B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF3159717C00000000787878FF494A4A9D0000
        00003C6B889766B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF4A85AAB900000000787878FF636464D40001
        01012640515D65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF5EAAD9EE03060708787878FF747474F9090A
        0B140E171C2265B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF65B5E8FE16273237787878FF787878FF2123
        2448010202035AA1CEE166B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF30566E78787878FF777777FE3C3D
        3E8100000000447899A965B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF65B5E8FE4984A9B9787878FF787878FF5758
        58BA000000002C4D616E66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF66B7
        EAFF66B7EAFF66B7EAFF66B7EAFF66B7EAFF62B0E1F5787878FF777777FE7171
        71F2020202041420283064B5E7FD66B7EAFF65B5E8FE65B5E8FE66B7EAFF65B5
        E8FE66B7EAFF65B5E8FE65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE66B7
        EAFF65B5E8FE65B5E8FE66B7EAFF65B5E8FE65B5E8FE787878FF777777FE7777
        77FE464747960606070D04050509040506090405060904050609040506090405
        0609040506090405060904050609040506090405060900000000000000000000
        00000000000000000000000000000000000000000000787878FF787878FF7878
        78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
        78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
        78FF787878FF787878FF787878FF696969DF00000000787878FF777777FE7777
        77FE787878FF777777FE777777FE787878FF777777FE777777FE787878FF7777
        77FE787878FF777777FE777777FE777777FE787878FF777777FE777777FE7878
        78FF777777FE777777FE787878FF4E4E4EA500000000787878FF777777FE7777
        77FE787878FF777777FE777777FE787878FF777777FE777777FE787878FF7777
        77FE787878FF777777FE777777FE777777FE787878FF777777FE777777FE7878
        78FF777777FE777777FE767676FB2B2B2B5C00000000787878FF787878FF7878
        78FF787878FF787878FF787878FF787878FF787878FF787878FF787878FF7878
        78FF777777FD4E4E4EA500000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000787878FF777777FE7777
        77FE787878FF777777FE777777FE787878FF777777FE777777FE787878FF7777
        77FE4E4E4EA50000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000004E4E4EA5777777FE7777
        77FE787878FF777777FE777777FE787878FF777777FE777777FE787878FF4E4E
        4EA5000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      LargeImageIndex = 1
      ShowCaption = False
      SyncImageIndex = False
      ImageIndex = 1
    end
    object DeleteHGuidesMI: TdxBarButton
      Action = DeleteHGuidesCmd
      Category = 0
    end
    object DeleteVGuidesMI: TdxBarButton
      Action = DeleteVGuidesCmd
      Category = 0
    end
    object EdConfigMI: TdxBarButton
      Action = EdConfigCmd
      Category = 0
      Visible = ivNever
    end
    object WatchMI: TdxBarButton
      Action = WatchTBCmd
      Category = 0
      ButtonStyle = bsChecked
    end
    object BreakPoints: TdxBarButton
      Action = BreakPointsTBCmd
      Category = 0
      ButtonStyle = bsChecked
    end
    object NewMI: TdxBarButton
      Action = NewItemCmd
      Category = 1
    end
    object NewReportMI: TdxBarButton
      Action = NewReportCmd
      Category = 1
    end
    object NewPageMI: TdxBarButton
      Action = NewPageCmd
      Category = 1
    end
    object NewDialogMI: TdxBarButton
      Action = NewDialogCmd
      Category = 1
    end
    object OpenMI: TdxBarButton
      Action = OpenCmd
      Category = 1
    end
    object SaveMI: TdxBarButton
      Action = SaveCmd
      Category = 1
    end
    object SaveAsMI: TdxBarButton
      Action = SaveAsCmd
      Category = 1
    end
    object PreviewMI: TdxBarButton
      Action = PreviewCmd
      Category = 1
    end
    object PageSettingsMI: TdxBarButton
      Action = PageSettingsCmd
      Category = 1
    end
    object ExitMI: TdxBarButton
      Action = ExitCmd
      Category = 1
    end
    object UndoMI: TdxBarButton
      Action = UndoCmd
      Category = 2
    end
    object RedoMI: TdxBarButton
      Action = RedoCmd
      Category = 2
    end
    object CutMI: TdxBarButton
      Action = CutCmd
      Category = 2
    end
    object CopyMI: TdxBarButton
      Action = CopyCmd
      Category = 2
    end
    object PasteMI: TdxBarButton
      Action = PasteCmd
      Category = 2
    end
    object DeleteMI: TdxBarButton
      Action = DeleteCmd
      Category = 2
    end
    object DeletePageMI: TdxBarButton
      Action = DeletePageCmd
      Category = 2
    end
    object SelectAllMI: TdxBarButton
      Action = SelectAllCmd
      Category = 2
    end
    object GroupMI: TdxBarButton
      Action = GroupCmd
      Category = 2
    end
    object UngroupMI: TdxBarButton
      Action = UngroupCmd
      Category = 2
    end
    object EditMI: TdxBarButton
      Action = EditCmd
      Category = 2
    end
    object FindMI: TdxBarButton
      Action = FindCmd
      Category = 2
    end
    object ReplaceMI: TdxBarButton
      Action = ReplaceCmd
      Category = 2
    end
    object FindNextMI: TdxBarButton
      Action = FindNextCmd
      Category = 2
    end
    object BringtoFrontMI: TdxBarButton
      Action = BringToFrontCmd
      Category = 2
    end
    object SendtoBackMI: TdxBarButton
      Action = SendToBackCmd
      Category = 2
    end
    object ReportDataMI: TdxBarButton
      Action = ReportDataCmd
      Category = 3
    end
    object VariablesMI: TdxBarButton
      Action = VariablesCmd
      Category = 3
    end
    object ReportStylesMI: TdxBarButton
      Action = ReportStylesCmd
      Category = 3
    end
    object ReportSettingsMI: TdxBarButton
      Action = ReportOptionsCmd
      Category = 3
    end
    object ToolbarsMI: TdxBarSubItem
      Action = ToolbarsCmd
      Category = 4
      ItemLinks = <
        item
          Visible = True
          ItemName = 'StandardMI'
        end
        item
          Visible = True
          ItemName = 'TextMI'
        end
        item
          Visible = True
          ItemName = 'FrameMI'
        end
        item
          Visible = True
          ItemName = 'AlignmentMI'
        end
        item
          Visible = True
          ItemName = 'ToolsMI'
        end
        item
          Visible = True
          ItemName = 'InspectorMI'
        end
        item
          Visible = True
          ItemName = 'DataTreeMI'
        end
        item
          Visible = True
          ItemName = 'ReportTreeMI'
        end
        item
          Visible = True
          ItemName = 'WatchMI'
        end
        item
          Visible = True
          ItemName = 'BreakPoints'
        end>
    end
    object StandardMI: TdxBarButton
      Action = StandardTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object TextMI: TdxBarButton
      Tag = 1
      Action = TextTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object FrameMI: TdxBarButton
      Tag = 2
      Action = FrameTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object AlignmentMI: TdxBarButton
      Tag = 3
      Action = AlignTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object ToolsMI: TdxBarButton
      Tag = 4
      Action = ExtraTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object InspectorMI: TdxBarButton
      Tag = 5
      Action = InspectorTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object DataTreeMI: TdxBarButton
      Tag = 6
      Action = DataTreeTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object ReportTreeMI: TdxBarButton
      Tag = 7
      Action = ReportTreeTBCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object ShowRulersMI: TdxBarButton
      Action = ShowRulersCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object ShowGuidesMI: TdxBarButton
      Action = ShowGuidesCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object AutoGuidesMI: TdxBarButton
      Action = AutoGuidesCmd
      Category = 4
      ButtonStyle = bsChecked
    end
    object OptionsMI: TdxBarButton
      Action = OptionsCmd
      Category = 4
    end
    object ConnectionsMI: TdxBarButton
      Caption = 'Connections...'
      Category = 4
      Visible = ivAlways
      OnClick = ConnectionsMIClick
    end
    object HelpContentsMI: TdxBarButton
      Action = HelpContentsCmd
      Category = 5
    end
    object AboutMI: TdxBarButton
      Action = AboutCmd
      Category = 5
    end
    object FileMenu: TdxBarSubItem
      Caption = '&File'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'NewReportMI'
        end
        item
          Visible = True
          ItemName = 'NewPageMI'
        end
        item
          Visible = True
          ItemName = 'NewDialogMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'OpenMI'
        end
        item
          Visible = True
          ItemName = 'SaveMI'
        end
        item
          Visible = True
          ItemName = 'SaveAsMI'
        end
        item
          Visible = True
          ItemName = 'FicherosRecientesItem'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'PreviewMI'
        end
        item
          Visible = True
          ItemName = 'PageSettingsMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'ExitMI'
        end>
    end
    object EditMenu: TdxBarSubItem
      Caption = '&Edit'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'UndoMI'
        end
        item
          Visible = True
          ItemName = 'RedoMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'CutMI'
        end
        item
          Visible = True
          ItemName = 'CopyMI'
        end
        item
          Visible = True
          ItemName = 'PasteMI'
        end
        item
          Visible = True
          ItemName = 'DeleteMI'
        end
        item
          Visible = True
          ItemName = 'DeletePageMI'
        end
        item
          Visible = True
          ItemName = 'SelectAllMI'
        end
        item
          Visible = True
          ItemName = 'GroupMI'
        end
        item
          Visible = True
          ItemName = 'UngroupMI'
        end
        item
          Visible = True
          ItemName = 'EditMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'FindMI'
        end
        item
          Visible = True
          ItemName = 'ReplaceMI'
        end
        item
          Visible = True
          ItemName = 'FindNextMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'BringtoFrontMI'
        end
        item
          Visible = True
          ItemName = 'SendtoBackMI'
        end>
    end
    object ReportMenu: TdxBarSubItem
      Caption = '&Report'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'ReportDataMI'
        end
        item
          Visible = True
          ItemName = 'VariablesMI'
        end
        item
          Visible = True
          ItemName = 'ReportStylesMI'
        end
        item
          Visible = True
          ItemName = 'ReportSettingsMI'
        end>
    end
    object ViewMenu: TdxBarSubItem
      Caption = '&View'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'ToolbarsMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'ShowRulersMI'
        end
        item
          Visible = True
          ItemName = 'ShowGuidesMI'
        end
        item
          Visible = True
          ItemName = 'AutoGuidesMI'
        end
        item
          Visible = True
          ItemName = 'DeleteHGuidesMI'
        end
        item
          Visible = True
          ItemName = 'DeleteVGuidesMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'OptionsMI'
        end
        item
          Visible = True
          ItemName = 'ConnectionsMI'
        end
        item
          Visible = True
          ItemName = 'EdConfigMI'
        end>
    end
    object HelpMenu: TdxBarSubItem
      Caption = '&Help'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'HelpContentsMI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'AboutMI'
        end>
    end
  end
end
