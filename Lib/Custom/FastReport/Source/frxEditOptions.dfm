object frxOptionsEditor: TfrxOptionsEditor
  Left = 403
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Designer Options'
  ClientHeight = 510
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 17
  object ButtonsGroupBox: TcxGroupBox
    Left = 0
    Top = 470
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    Height = 40
    Width = 821
    object CancelB: TcxButton
      Tag = 2
      AlignWithMargins = True
      Left = 726
      Top = 5
      Width = 90
      Height = 30
      Align = alRight
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.SourceHeight = 18
      OptionsImage.Glyph.SourceWidth = 18
      OptionsImage.Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222077696474683D223234707822206865696768743D223234707822
        2076696577426F783D223020302032342032342220656E61626C652D6261636B
        67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
        3D227072657365727665223E262331303B20203C672069643D2269636F6E2220
        786D6C3A73706163653D227072657365727665223E202020203C706174682064
        3D224D31392E333533392C31372E323332364C31342E313231332C31326C352E
        323332362C2D352E3233323663302E323333332C2D302E323333332C302E3233
        33332C2D302E363135322C302C2D302E383438356C2D312E323732382C2D312E
        32373238632D302E323333332C2D302E323333332C2D302E363135322C2D302E
        323333332C2D302E383438352C304C31322C392E383738374C362E373637342C
        342E36343631632D302E323333332C2D302E323333332C2D302E363135322C2D
        302E323333332C2D302E383438352C304C342E363436312C352E39313839632D
        302E323333332C302E323333332C2D302E323333332C302E363135322C302C30
        2E383438354C392E383738372C31326C2D352E323332362C352E32333236632D
        302E323333332C302E323333332C2D302E323333332C302E363135322C302C30
        2E383438356C312E323732382C312E3237323863302E323333332C302E323333
        332C302E363135322C302E323333332C302E383438352C304C31322C31342E31
        3231336C352E323332362C352E3233323663302E323333332C302E323333332C
        302E363135322C302E323333332C302E383438352C306C312E323732382C2D31
        2E323732384331392E353837332C31372E383437382C31392E353837332C3137
        2E343635392C31392E333533392C31372E323332367A222066696C6C3D222344
        4234343533222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      OptionsImage.Margin = 6
      TabOrder = 0
    end
    object OkB: TcxButton
      Tag = 1
      AlignWithMargins = True
      Left = 630
      Top = 5
      Width = 90
      Height = 30
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.SourceHeight = 18
      OptionsImage.Glyph.SourceWidth = 18
      OptionsImage.Glyph.Data = {
        3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554
        462D38223F3E0D0A3C7376672076657273696F6E3D22312E31222069643D224C
        617965725F312220786D6C6E733D22687474703A2F2F7777772E77332E6F7267
        2F323030302F7376672220786D6C6E733A786C696E6B3D22687474703A2F2F77
        77772E77332E6F72672F313939392F786C696E6B2220783D223070782220793D
        22307078222077696474683D223234707822206865696768743D223234707822
        2076696577426F783D223020302032342032342220656E61626C652D6261636B
        67726F756E643D226E6577203020302032342032342220786D6C3A7370616365
        3D227072657365727665223E262331303B20203C672069643D2269636F6E2220
        786D6C3A73706163653D227072657365727665223E202020203C706174682064
        3D224D31392E343135352C362E313332366C2D392E3635322C392E3635326C2D
        342E3837392C2D342E383739632D302E323333332C2D302E323333332C2D302E
        363135322C2D302E323333332C2D302E383438352C306C2D312E323732382C31
        2E32373238632D302E323333332C302E323333332C2D302E323333332C302E36
        3135322C302C302E383438356C362E353736312C362E3537363163302E323333
        332C302E323333332C302E363135322C302E323333332C302E383438352C306C
        302E353330332C2D302E353330336C302E373432352C2D302E373432354C3231
        2E353336382C382E3235333963302E323333332C2D302E323333332C302E3233
        33332C2D302E363135322C302C2D302E383438356C2D312E323732382C2D312E
        323732384332302E303330372C352E383939322C31392E363438392C352E3839
        39322C31392E343135352C362E313332367A222066696C6C3D22233336424339
        42222F3E0D0A093C2F673E0D0A3C2F7376673E0D0A}
      OptionsImage.Margin = 6
      TabOrder = 1
    end
    object RestoreDefaultsB: TcxButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 137
      Height = 30
      Align = alLeft
      Caption = 'Restore defaults'
      TabOrder = 2
      OnClick = RestoreDefaultsBClick
    end
  end
  object LeftPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alLeft
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 470
    Width = 411
    object GridPanel: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Caption = 'Grid'
      TabOrder = 0
      Height = 175
      Width = 401
      object CMRB: TRadioButton
        Left = 8
        Top = 46
        Width = 109
        Height = 17
        Caption = 'Centimeters'
        TabOrder = 0
      end
      object InchesRB: TRadioButton
        Left = 8
        Top = 73
        Width = 109
        Height = 17
        Caption = 'Inches'
        TabOrder = 1
      end
      object PixelsRB: TRadioButton
        Left = 8
        Top = 100
        Width = 109
        Height = 17
        Caption = 'Pixels'
        TabOrder = 2
      end
      object Label2: TcxLabel
        Left = 8
        Top = 18
        Caption = 'Type'
        TabOrder = 11
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 132
        Top = 18
        Caption = 'Size'
        TabOrder = 12
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 8
        Top = 127
        Caption = 'Dialog form'
        TabOrder = 13
        Transparent = True
      end
      object Label13: TcxLabel
        Left = 172
        Top = 43
        Caption = 'cm'
        TabOrder = 14
        Transparent = True
      end
      object Label14: TcxLabel
        Left = 172
        Top = 70
        Caption = 'pg'
        TabOrder = 15
        Transparent = True
      end
      object Label15: TcxLabel
        Left = 172
        Top = 97
        Caption = 'px'
        TabOrder = 16
        Transparent = True
      end
      object Label16: TcxLabel
        Left = 172
        Top = 127
        Caption = 'px'
        TabOrder = 17
        Transparent = True
      end
      object ShowGridCB: TcxCheckBox
        Left = 224
        Top = 46
        Caption = 'Show grid'
        Style.TransparentBorder = False
        TabOrder = 7
        Transparent = True
      end
      object AlignGridCB: TcxCheckBox
        Left = 224
        Top = 73
        Caption = 'Align to grid'
        Style.TransparentBorder = False
        TabOrder = 8
        Transparent = True
      end
      object GuidesStickCB: TcxCheckBox
        Left = 224
        Top = 100
        Caption = 'Stick to guides'
        Style.TransparentBorder = False
        TabOrder = 9
        Transparent = True
      end
      object GuidesAsAnchorCB: TcxCheckBox
        Left = 224
        Top = 128
        Caption = 'Use guides as anchor'
        Style.TransparentBorder = False
        TabOrder = 10
        Transparent = True
      end
      object CME: TcxTextEdit
        Left = 132
        Top = 44
        AutoSize = False
        TabOrder = 3
        Height = 25
        Width = 37
      end
      object InchesE: TcxTextEdit
        Left = 132
        Top = 71
        AutoSize = False
        TabOrder = 4
        Height = 25
        Width = 37
      end
      object PixelsE: TcxTextEdit
        Left = 132
        Top = 98
        AutoSize = False
        TabOrder = 5
        Height = 25
        Width = 37
      end
      object DialogFormE: TcxTextEdit
        Left = 132
        Top = 126
        AutoSize = False
        TabOrder = 6
        Height = 25
        Width = 37
      end
    end
    object FontsPanel: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 186
      Align = alTop
      Caption = 'Fonts'
      TabOrder = 1
      Height = 129
      Width = 401
      object Label7: TcxLabel
        Left = 8
        Top = 22
        Caption = 'Code window'
        TabOrder = 5
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 8
        Top = 50
        Caption = 'Memo editor'
        TabOrder = 6
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 273
        Top = 22
        Caption = 'Size'
        TabOrder = 7
        Transparent = True
      end
      object Label10: TcxLabel
        Left = 273
        Top = 50
        Caption = 'Size'
        TabOrder = 8
        Transparent = True
      end
      object ObjectFontCB: TcxCheckBox
        Left = 11
        Top = 85
        Caption = 'Use object'#39's font settings'
        Style.TransparentBorder = False
        TabOrder = 4
        Transparent = True
      end
      object CodeWindowFontCB: TcxComboBox
        Left = 132
        Top = 21
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 0
        Width = 121
      end
      object CodeWindowSizeCB: TcxComboBox
        Left = 340
        Top = 21
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '8'
          '9'
          '10'
          '11'
          '12'
          '14')
        TabOrder = 1
        Width = 44
      end
      object MemoEditorFontCB: TcxComboBox
        Left = 132
        Top = 49
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 2
        Width = 121
      end
      object MemoEditorSizeCB: TcxComboBox
        Left = 340
        Top = 49
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          '8'
          '9'
          '10'
          '11'
          '12'
          '14')
        TabOrder = 3
        Width = 44
      end
    end
    object ColorsPanel: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 321
      Align = alClient
      Caption = 'Colors'
      TabOrder = 2
      Height = 144
      Width = 401
      object WorkspacePB: TPaintBox
        Left = 179
        Top = 25
        Width = 185
        Height = 25
        OnPaint = WorkspacePBPaint
      end
      object ToolPB: TPaintBox
        Left = 179
        Top = 56
        Width = 185
        Height = 25
        OnPaint = ToolPBPaint
      end
      object IntersectionsPB: TPaintBox
        Left = 179
        Top = 87
        Width = 185
        Height = 21
        OnPaint = IntersectionsPBPaint
      end
      object LCDCB: TcxCheckBox
        Left = 11
        Top = 85
        Caption = 'LCD grid color'
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
      end
      object WorkspaceB: TcxButton
        Left = 8
        Top = 25
        Width = 162
        Height = 25
        Caption = 'Workspace'
        TabOrder = 0
        OnClick = WorkspaceBClick
      end
      object ToolB: TcxButton
        Left = 8
        Top = 52
        Width = 162
        Height = 25
        Caption = 'Tool windows'
        TabOrder = 1
        OnClick = ToolBClick
      end
    end
  end
  object RightPanel: TcxGroupBox
    Left = 411
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    Height = 470
    Width = 410
    object CodePanel: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      Caption = 'Code complition and  Syntax memo'
      TabOrder = 0
      Height = 151
      Width = 400
      object Label18: TcxLabel
        Left = 214
        Top = 24
        Caption = 'Tab stops:'
        TabOrder = 5
        Transparent = True
      end
      object ShowScriptVARCB: TcxCheckBox
        Left = 14
        Top = 24
        Caption = 'Show script variables'
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
      end
      object ShowADDVARCB: TcxCheckBox
        Left = 14
        Top = 45
        Caption = 'Show report objects'
        Style.TransparentBorder = False
        TabOrder = 1
        Transparent = True
      end
      object ShowRttiVARCB: TcxCheckBox
        Left = 14
        Top = 67
        Caption = 'Show Rtti variables'
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
      end
      object MultiBCB: TcxCheckBox
        Left = 214
        Top = 67
        Caption = 'Soporte multi-byte'
        Style.TransparentBorder = False
        TabOrder = 4
        Transparent = True
      end
      object TBE: TcxTextEdit
        Left = 288
        Top = 22
        TabOrder = 6
        Width = 37
      end
      object IntersectionsB: TButton
        Left = 14
        Top = 98
        Width = 145
        Height = 31
        Caption = 'Intersections'
        TabOrder = 3
        OnClick = IntersectionsBClick
      end
    end
    object OtherPanel: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 162
      Align = alClient
      Caption = 'Other'
      TabOrder = 1
      Height = 303
      Width = 400
      object Label12: TcxLabel
        Left = 15
        Top = 149
        Caption = 'Gap between bands:'
        TabOrder = 6
        Transparent = True
      end
      object Label17: TcxLabel
        Left = 230
        Top = 149
        Caption = 'px'
        TabOrder = 7
        Transparent = True
      end
      object LGuidAcc: TcxLabel
        Left = 15
        Top = 177
        Caption = 'Guides stick accuracy:'
        TabOrder = 8
        Transparent = True
      end
      object Label20: TcxLabel
        Left = 230
        Top = 177
        Caption = 'px'
        TabOrder = 9
        Transparent = True
      end
      object EditAfterInsCB: TcxCheckBox
        Left = 15
        Top = 26
        Caption = 'Show editor after insert'
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
      end
      object FreeBandsCB: TcxCheckBox
        Left = 15
        Top = 70
        Caption = 'Free bands placement'
        Style.TransparentBorder = False
        TabOrder = 2
        Transparent = True
      end
      object BandsCaptionsCB: TcxCheckBox
        Left = 15
        Top = 48
        Caption = 'Show band'#39's captions'
        Style.TransparentBorder = False
        TabOrder = 1
        Transparent = True
      end
      object GapE: TcxTextEdit
        Left = 187
        Top = 148
        TabOrder = 5
        Width = 37
      end
      object EnableWorkspaceHints: TcxCheckBox
        Left = 14
        Top = 116
        Caption = 'Enable workspace hints'
        TabOrder = 4
        Transparent = True
      end
      object EGuidAcc: TcxTextEdit
        Left = 187
        Top = 176
        TabOrder = 10
        Width = 37
      end
      object EnableCodeWindowHint: TcxCheckBox
        Left = 14
        Top = 92
        Caption = 'Enable code window hints'
        TabOrder = 3
        Transparent = True
      end
    end
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 296
    Top = 366
  end
end
