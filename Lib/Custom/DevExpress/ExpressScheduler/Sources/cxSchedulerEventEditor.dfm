object cxSchedulerEventEditorForm: TcxSchedulerEventEditorForm
  Left = 313
  Top = 267
  ClientHeight = 507
  ClientWidth = 565
  Color = clBtnFace
  Constraints.MinHeight = 410
  Constraints.MinWidth = 458
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 17
  object pnlButtons: TPanel
    Left = 0
    Top = 469
    Width = 565
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 0
    ExplicitTop = 445
    ExplicitWidth = 537
    object pnlThreeButtons: TPanel
      Left = 0
      Top = 0
      Width = 455
      Height = 38
      Align = alClient
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 0
      ExplicitLeft = -1
      DesignSize = (
        455
        38)
      object btnOk: TcxButton
        Left = 130
        Top = 4
        Width = 95
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
        OnClick = btnOkClick
        ExplicitLeft = 102
      end
      object btnCancel: TcxButton
        Left = 240
        Top = 4
        Width = 95
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
        OnClick = btnCancelClick
        ExplicitLeft = 212
      end
      object btnDelete: TcxButton
        Left = 350
        Top = 4
        Width = 95
        Height = 27
        Anchors = [akTop, akRight]
        Caption = '&Delete'
        TabOrder = 2
        OnClick = btnDeleteClick
        ExplicitLeft = 322
      end
    end
    object pnlRecurrence: TPanel
      Left = 455
      Top = 0
      Width = 110
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 1
      ExplicitLeft = 427
      object btnRecurrence: TcxButton
        Left = 5
        Top = 4
        Width = 95
        Height = 27
        Caption = '&Recurrencia'
        TabOrder = 0
        OnClick = btnRecurrenceClick
      end
    end
  end
  object pnlInformation: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 8
    DesignSize = (
      565
      41)
    object Bevel6: TdxBevel
      Left = 10
      Top = 36
      Width = 545
      Height = 7
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 430
    end
    object btnFindTime: TcxButton
      Left = 409
      Top = 6
      Width = 147
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Encontrar tiempo disponible'
      TabOrder = 0
      OnClick = btnFindTimeClick
      ExplicitLeft = 381
    end
    object cxGroupBox1: TcxGroupBox
      Left = 13
      Top = 6
      Alignment = alCenterCenter
      Anchors = [akLeft, akTop, akRight]
      ParentBackground = False
      ParentColor = False
      Style.Color = clInfoBk
      Style.TransparentBorder = False
      TabOrder = 1
      Height = 26
      Width = 392
      object lbInformation: TcxLabel
        Left = 3
        Top = 3
        AutoSize = False
        Caption = 'Entra en conflicto con otro evento de la agenda.'
        Style.TransparentBorder = False
        Transparent = True
        Height = 18
        Width = 354
      end
    end
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 41
    Width = 565
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      565
      64)
    object lbSubject: TcxLabel
      Left = 16
      Top = 10
      Caption = 'Subject:'
      FocusControl = teSubject
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbLocation: TcxLabel
      Left = 16
      Top = 38
      Caption = 'Location:'
      FocusControl = teLocation
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbLabel: TcxLabel
      Left = 340
      Top = 38
      Anchors = [akTop, akRight]
      Caption = 'La&bel:'
      FocusControl = icbLabel
      Style.TransparentBorder = False
      Transparent = True
    end
    object teSubject: TcxTextEdit
      Left = 113
      Top = 6
      Anchors = [akLeft, akTop, akRight]
      Properties.OnChange = OnChanged
      TabOrder = 0
      Width = 484
    end
    object teLocation: TcxTextEdit
      Left = 113
      Top = 34
      Anchors = [akLeft, akTop, akRight]
      Properties.OnChange = OnChanged
      TabOrder = 1
      Width = 212
    end
    object icbLabel: TcxImageComboBox
      Left = 396
      Top = 34
      Anchors = [akTop, akRight]
      Properties.Items = <>
      Properties.OnChange = OnChanged
      TabOrder = 2
      ExplicitLeft = 368
      Width = 159
    end
  end
  object pnlTime: TPanel
    Left = 0
    Top = 105
    Width = 565
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 2
    DesignSize = (
      565
      67)
    object Bevel4: TdxBevel
      Left = 10
      Top = 0
      Width = 544
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 429
    end
    object lbStartTime: TcxLabel
      Left = 16
      Top = 15
      Caption = 'Start time:'
      FocusControl = deStart
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbEndTime: TcxLabel
      Left = 16
      Top = 43
      Caption = 'End time:'
      FocusControl = deEnd
      Style.TransparentBorder = False
      Transparent = True
    end
    object deStart: TcxDateEdit
      Left = 113
      Top = 11
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = OnChanged
      Properties.OnEditValueChanged = StartDateChanged
      TabOrder = 0
      Width = 121
    end
    object teStart: TcxTimeEdit
      Left = 241
      Top = 11
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = OnEventTimeChanged
      TabOrder = 1
      Width = 78
    end
    object deEnd: TcxDateEdit
      Left = 113
      Top = 39
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = OnChanged
      TabOrder = 2
      Width = 121
    end
    object teEnd: TcxTimeEdit
      Left = 241
      Top = 39
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = OnEventTimeChanged
      TabOrder = 3
      Width = 78
    end
    object cbAllDayEvent: TcxCheckBox
      Left = 337
      Top = 12
      Caption = 'All day event'
      Properties.OnChange = cbAllDayEventPropertiesChange
      TabOrder = 4
      Transparent = True
    end
  end
  object pnlRecurrenceInfo: TPanel
    Left = 0
    Top = 217
    Width = 565
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 4
    DesignSize = (
      565
      41)
    object Bevel7: TdxBevel
      Left = 11
      Top = 0
      Width = 544
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 429
    end
    object lbRecurrence: TcxLabel
      Left = 16
      Top = 15
      Caption = 'Recurrence:'
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbRecurrencePattern: TcxLabel
      Left = 113
      Top = 15
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'PatternInfo'
      Style.TransparentBorder = False
      Properties.WordWrap = True
      Transparent = True
      Height = 22
      Width = 443
    end
  end
  object pnlPlaceHolder: TPanel
    Left = 0
    Top = 301
    Width = 565
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 6
    object pnlReminder: TPanel
      Left = 0
      Top = 4
      Width = 257
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 0
      object cbReminder: TcxCheckBox
        Left = 11
        Top = 9
        Caption = 'Reminder:'
        Properties.OnChange = OnChanged
        State = cbsChecked
        TabOrder = 0
        Transparent = True
        OnClick = cbReminderClick
      end
      object cbReminderMinutesBeforeStart: TcxComboBox
        Left = 113
        Top = 8
        Properties.ImmediateDropDownWhenKeyPressed = False
        Properties.ImmediatePost = True
        Properties.IncrementalSearch = False
        Properties.OnChange = OnChanged
        Properties.OnPopup = cbReminderMinutesBeforeStartPropertiesPopup
        Properties.OnValidate = cbReminderMinutesBeforeStartPropertiesValidate
        TabOrder = 1
        Width = 121
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 565
      Height = 4
      Align = alTop
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 1
      ExplicitWidth = 537
      DesignSize = (
        565
        4)
      object Bevel3: TdxBevel
        Left = 11
        Top = 0
        Width = 543
        Height = 4
        Anchors = [akLeft, akTop, akRight]
        Shape = dxbsLineCenteredVert
        ExplicitWidth = 428
      end
    end
    object pnlShowTimeAs: TPanel
      Left = 257
      Top = 4
      Width = 281
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 2
      object lbShowTimeAs: TcxLabel
        Left = 23
        Top = 12
        Caption = 'Mostrar:'
        FocusControl = icbShowTimeAs
        Style.TransparentBorder = False
        Transparent = True
      end
      object icbShowTimeAs: TcxImageComboBox
        Left = 108
        Top = 8
        Properties.Items = <>
        Properties.OnChange = OnEventTimeChanged
        TabOrder = 0
        Width = 130
      end
    end
  end
  object pnlMessage: TPanel
    Left = 0
    Top = 344
    Width = 565
    Height = 125
    Align = alClient
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 7
    ExplicitTop = 336
    ExplicitWidth = 537
    ExplicitHeight = 109
    DesignSize = (
      565
      125)
    object Bevel2: TdxBevel
      Left = 11
      Top = 0
      Width = 544
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 429
    end
    object Bevel1: TdxBevel
      Left = 11
      Top = 117
      Width = 544
      Height = 7
      Anchors = [akLeft, akRight, akBottom]
      Shape = dxbsLineCenteredVert
      ExplicitTop = 42
      ExplicitWidth = 429
    end
    object meMessage: TcxMemo
      Left = 10
      Top = 12
      Anchors = [akLeft, akTop, akRight, akBottom]
      Properties.OnChange = OnChanged
      TabOrder = 0
      Height = 99
      Width = 546
    end
  end
  object pnlResource: TPanel
    Left = 0
    Top = 258
    Width = 565
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 5
    DesignSize = (
      565
      43)
    object Bevel5: TdxBevel
      Left = 11
      Top = -4
      Width = 544
      Height = 7
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 429
    end
    object lbResource: TcxLabel
      Left = 16
      Top = 8
      Caption = 'Resource(s):'
      Style.TransparentBorder = False
      Transparent = True
    end
    object cbResources: TcxCheckComboBox
      Left = 113
      Top = 4
      Anchors = [akLeft, akTop, akRight]
      Properties.DropDownAutoWidth = False
      Properties.EditValueFormat = cvfIndices
      Properties.Items = <>
      Properties.OnChange = OnResourceIDChanged
      Properties.OnClickCheck = cbResourcesPropertiesClickCheck
      TabOrder = 0
      Width = 443
    end
  end
  object pnlTaskComplete: TPanel
    Left = 0
    Top = 172
    Width = 565
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      565
      45)
    object Bevel8: TdxBevel
      Left = 11
      Top = 0
      Width = 544
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = dxbsLineCenteredVert
      ExplicitWidth = 429
    end
    object lbTaskComplete: TcxLabel
      Left = 16
      Top = 18
      Caption = 'Task complete:'
      FocusControl = seTaskComplete
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbTaskStatus: TcxLabel
      Left = 280
      Top = 18
      Caption = 'Task status:'
      FocusControl = cbxTaskStatus
      Style.TransparentBorder = False
      Transparent = True
    end
    object seTaskComplete: TcxSpinEdit
      Left = 113
      Top = 14
      Properties.AssignedValues.EditFormat = True
      Properties.AssignedValues.MinValue = True
      Properties.Increment = 25.000000000000000000
      Properties.LargeIncrement = 25.000000000000000000
      Properties.MaxValue = 100.000000000000000000
      Properties.OnChange = seTaskCompleteChange
      Properties.OnEditValueChanged = seTaskCompleteChange
      TabOrder = 0
      Width = 121
    end
    object cbxTaskStatus: TcxComboBox
      Left = 365
      Top = 14
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = cbxTaskStatusChange
      Properties.OnEditValueChanged = cbxTaskStatusChange
      TabOrder = 1
      Width = 130
    end
  end
end
