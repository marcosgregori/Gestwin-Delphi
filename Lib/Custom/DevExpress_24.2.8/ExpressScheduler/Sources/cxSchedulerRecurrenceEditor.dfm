object cxSchedulerRecurrenceEventEditorForm: TcxSchedulerRecurrenceEventEditorForm
  Left = 277
  Top = 263
  ActiveControl = teStart
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Event recurrence'
  ClientHeight = 388
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object gbPattern: TcxGroupBox
    Left = 8
    Top = 71
    Caption = 'Recurrence pattern'
    TabOrder = 4
    Height = 141
    Width = 517
    object pnlWeekly: TcxGroupBox
      Left = 131
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Visible = False
      Height = 101
      Width = 377
      object lbRecurEvery: TcxLabel
        Left = 7
        Top = 7
        Caption = 'Recur every'
        FocusControl = meNumOfWeek
        Style.TransparentBorder = False
        Transparent = True
      end
      object lbWeeksOn: TcxLabel
        Left = 135
        Top = 8
        Caption = 'week(s) on:'
        Style.TransparentBorder = False
        Transparent = True
      end
      object cbDayOfWeek4: TcxCheckBox
        Tag = 4
        Left = 270
        Top = 38
        Caption = 'Wednesday'
        Properties.OnChange = DoChange
        TabOrder = 4
        Transparent = True
      end
      object meNumOfWeek: TcxMaskEdit
        Left = 95
        Top = 5
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = DoChange
        TabOrder = 0
        OnExit = ValidateNumber
        Width = 32
      end
      object cbDayOfWeek2: TcxCheckBox
        Tag = 2
        Left = 92
        Top = 38
        Caption = 'Monday'
        Properties.OnChange = DoChange
        TabOrder = 2
        Transparent = True
      end
      object cbDayOfWeek3: TcxCheckBox
        Tag = 3
        Left = 181
        Top = 38
        Caption = 'Tuesday'
        Properties.OnChange = DoChange
        TabOrder = 3
        Transparent = True
      end
      object cbDayOfWeek5: TcxCheckBox
        Tag = 5
        Left = 3
        Top = 66
        Caption = 'Thursday'
        Properties.OnChange = DoChange
        TabOrder = 5
        Transparent = True
      end
      object cbDayOfWeek6: TcxCheckBox
        Tag = 6
        Left = 92
        Top = 66
        Caption = 'Friday'
        Properties.OnChange = DoChange
        TabOrder = 6
        Transparent = True
      end
      object cbDayOfWeek7: TcxCheckBox
        Tag = 7
        Left = 181
        Top = 66
        Caption = 'Saturday'
        Properties.OnChange = DoChange
        TabOrder = 7
        Transparent = True
      end
      object cbDayOfWeek1: TcxCheckBox
        Tag = 1
        Left = 3
        Top = 38
        Caption = 'Sunday'
        Properties.OnChange = DoChange
        TabOrder = 1
        Transparent = True
      end
    end
    object pnlDaily: TcxGroupBox
      Left = 130
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Visible = False
      Height = 101
      Width = 380
      object lbDay: TcxLabel
        Left = 144
        Top = 5
        Caption = 'day'
        Style.TransparentBorder = False
        Transparent = True
      end
      object rbEvery: TcxRadioButton
        Left = 4
        Top = 6
        Width = 66
        Height = 17
        Caption = 'Every'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object meDay: TcxMaskEdit
        Left = 99
        Top = 2
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = meDayPropertiesChange
        TabOrder = 2
        OnExit = ValidateNumber
        Width = 32
      end
      object rbEveryWeekday: TcxRadioButton
        Left = 4
        Top = 35
        Width = 171
        Height = 17
        Caption = 'Every weekday'
        TabOrder = 1
        OnClick = rbEveryWeekdayClick
        Transparent = True
      end
    end
    object pnlMonthly: TcxGroupBox
      Left = 130
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Visible = False
      Height = 101
      Width = 381
      object lbMonths: TcxLabel
        Left = 193
        Top = 5
        Caption = 'month(s)'
        Style.TransparentBorder = False
        Transparent = True
      end
      object lbMonths1: TcxLabel
        Left = 323
        Top = 36
        Caption = 'month(s)'
        Style.TransparentBorder = False
        Transparent = True
      end
      object lbOfEvery: TcxLabel
        Left = 92
        Top = 5
        Caption = 'of every'
        Style.TransparentBorder = False
        Transparent = True
      end
      object lbOfEvery1: TcxLabel
        Left = 229
        Top = 36
        Caption = 'of every'
        Style.TransparentBorder = False
        Transparent = True
      end
      object cbWeek: TcxComboBox
        Tag = 11534460
        Left = 53
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 4
        Width = 65
      end
      object meNumOfDay: TcxMaskEdit
        Tag = 11533468
        Left = 53
        Top = 2
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetDayRadioButtonChecked
        TabOrder = 2
        OnExit = ValidateNumber
        Width = 32
      end
      object meNumMonth: TcxMaskEdit
        Tag = 11533468
        Left = 151
        Top = 2
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetDayRadioButtonChecked
        TabOrder = 3
        OnExit = ValidateNumber
        Width = 32
      end
      object meNumMonth1: TcxMaskEdit
        Tag = 11534460
        Left = 285
        Top = 33
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 6
        OnExit = ValidateNumber
        Width = 32
      end
      object rbDay: TcxRadioButton
        Left = 4
        Top = 6
        Width = 50
        Height = 17
        Caption = 'Day'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object rbThe: TcxRadioButton
        Left = 4
        Top = 37
        Width = 49
        Height = 17
        Caption = 'The'
        TabOrder = 1
        OnClick = DoChange
        Transparent = True
      end
      object cbDay: TcxComboBox
        Tag = 11534460
        Left = 124
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 10
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 5
        Width = 96
      end
    end
    object pnlYearly: TcxGroupBox
      Left = 130
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Visible = False
      Height = 103
      Width = 380
      object lbOf: TcxLabel
        Left = 247
        Top = 36
        Caption = 'of'
        Style.TransparentBorder = False
        Transparent = True
      end
      object cbMonths1: TcxComboBox
        Tag = 11589716
        Left = 266
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 6
        Width = 90
      end
      object meDayOfMonth: TcxMaskEdit
        Tag = 11588656
        Left = 159
        Top = 2
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = cbMonthsPropertiesChange
        TabOrder = 3
        OnExit = ValidateNumber
        Width = 32
      end
      object cbMonths: TcxComboBox
        Tag = 11588656
        Left = 64
        Top = 2
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbMonthsPropertiesChange
        TabOrder = 2
        Width = 90
      end
      object cbWeek1: TcxComboBox
        Tag = 11589716
        Left = 64
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 4
        Width = 65
      end
      object rbEvery1: TcxRadioButton
        Left = 4
        Top = 6
        Width = 57
        Height = 17
        Caption = 'Every'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object rbThe1: TcxRadioButton
        Left = 4
        Top = 37
        Width = 49
        Height = 17
        Caption = 'The'
        TabOrder = 1
        Transparent = True
      end
      object cbDay1: TcxComboBox
        Tag = 11589716
        Left = 134
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 10
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 5
        Width = 103
      end
    end
    object pnlPeriodicity: TcxGroupBox
      Left = 3
      Top = 18
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 107
      Width = 130
      object Bevel1: TdxBevel
        Left = 122
        Top = 2
        Width = 6
        Height = 103
        Align = alRight
        AutoSize = True
        Shape = dxbsLineCenteredHorz
        ExplicitLeft = 99
        ExplicitHeight = 98
      end
      object rbYearly: TcxRadioButton
        Tag = 3
        Left = 8
        Top = 80
        Width = 111
        Height = 20
        Caption = 'Yearly'
        TabOrder = 3
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbWeekly: TcxRadioButton
        Tag = 1
        Left = 8
        Top = 32
        Width = 111
        Height = 20
        Caption = 'Weekly'
        TabOrder = 1
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbMonthly: TcxRadioButton
        Tag = 2
        Left = 8
        Top = 56
        Width = 111
        Height = 20
        Caption = 'Monthly'
        TabOrder = 2
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbDaily: TcxRadioButton
        Left = 8
        Top = 8
        Width = 111
        Height = 20
        Caption = 'Daily'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
    end
  end
  object btnOk: TcxButton
    Left = 110
    Top = 345
    Width = 96
    Height = 29
    Caption = '&Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 214
    Top = 345
    Width = 85
    Height = 29
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnRemove: TcxButton
    Left = 308
    Top = 345
    Width = 121
    Height = 29
    Caption = '&Remove recurrence'
    Enabled = False
    ModalResult = 3
    TabOrder = 2
  end
  object gbTime: TcxGroupBox
    Left = 8
    Top = 6
    Caption = 'Event time'
    TabOrder = 3
    Height = 63
    Width = 517
    object lbStart: TcxLabel
      Left = 14
      Top = 26
      Caption = 'Start:'
      FocusControl = teStart
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbEnd: TcxLabel
      Left = 144
      Top = 26
      Caption = 'End:'
      FocusControl = teEnd
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbDuration: TcxLabel
      Left = 272
      Top = 26
      Caption = 'Duration:'
      FocusControl = cbDuration
      Style.TransparentBorder = False
      Transparent = True
    end
    object teStart: TcxTimeEdit
      Left = 52
      Top = 23
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = StartTimeChanged
      TabOrder = 0
      Width = 78
    end
    object teEnd: TcxTimeEdit
      Left = 182
      Top = 23
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = EndTimeChanged
      TabOrder = 1
      Width = 78
    end
    object cbDuration: TcxComboBox
      Left = 343
      Top = 23
      Properties.ImmediateDropDownWhenKeyPressed = False
      Properties.ImmediatePost = True
      Properties.IncrementalSearch = False
      Properties.OnChange = DoChange
      Properties.OnPopup = cbDurationPropertiesPopup
      Properties.OnValidate = cbDurationPropertiesValidate
      TabOrder = 2
      Width = 129
    end
  end
  object gbRange: TcxGroupBox
    Left = 8
    Top = 215
    Caption = 'Range of recurrence'
    TabOrder = 5
    Height = 116
    Width = 517
    object lbStart1: TcxLabel
      Left = 16
      Top = 30
      Caption = 'Start:'
      FocusControl = deStart
      Style.TransparentBorder = False
      Transparent = True
    end
    object lbOccurrences: TcxLabel
      Left = 370
      Top = 57
      Caption = 'occurrences'
      Style.TransparentBorder = False
      Transparent = True
    end
    object deStart: TcxDateEdit
      Left = 64
      Top = 26
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = deStartPropertiesEditValueChanged
      TabOrder = 0
      Width = 135
    end
    object rbNoEndDate: TcxRadioButton
      Left = 223
      Top = 29
      Width = 119
      Height = 17
      Caption = 'No end date'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbNoEndDateClick
      Transparent = True
    end
    object rbEndAfter: TcxRadioButton
      Left = 223
      Top = 56
      Width = 97
      Height = 17
      Caption = 'End after:'
      TabOrder = 2
      OnClick = DoChange
      Transparent = True
    end
    object rbEndBy: TcxRadioButton
      Left = 223
      Top = 84
      Width = 97
      Height = 17
      Caption = 'End by:'
      TabOrder = 3
      OnClick = DoChange
      Transparent = True
    end
    object deEndBy: TcxDateEdit
      Tag = 11453468
      Left = 330
      Top = 82
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = deEndByPropertiesChange
      Properties.OnEditValueChanged = deEndByPropertiesEditValueChanged
      TabOrder = 5
      Width = 135
    end
    object meEndAfter: TcxMaskEdit
      Tag = 11452416
      Left = 330
      Top = 54
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d{0,4}'
      Properties.MaxLength = 0
      Properties.OnChange = meEndAfterPropertiesChange
      Properties.OnEditValueChanged = meEndAfterPropertiesEditValueChanged
      TabOrder = 4
      OnExit = meEndAfterExit
      Width = 32
    end
  end
end
