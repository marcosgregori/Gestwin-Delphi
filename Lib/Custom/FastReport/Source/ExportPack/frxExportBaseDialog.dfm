object frxBaseExportDialog: TfrxBaseExportDialog
  Tag = 8700
  Left = 85
  Top = 248
  ActiveControl = AllRB
  Caption = 'Export to PDF'
  ClientHeight = 311
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 17
  object PageControl1: TcxPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 409
    Height = 265
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = ExportPage
    Properties.CustomButtons.Buttons = <>
    Properties.MultiLine = True
    ClientRectBottom = 261
    ClientRectLeft = 4
    ClientRectRight = 405
    ClientRectTop = 28
    object ExportPage: TcxTabSheet
      Caption = 'Export'
      object GroupPageRange: TcxGroupBox
        Tag = 7
        Left = 0
        Top = 0
        Align = alTop
        Caption = ' Page range  '
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Height = 149
        Width = 401
        object DescrL: TcxLabel
          Tag = 9
          AlignWithMargins = True
          Left = 26
          Top = 103
          Margins.Left = 24
          Align = alBottom
          AutoSize = False
          Caption = 
            'Enter page numbers and/or page ranges, separated by commas. For ' +
            'example, 1,3,5-12'
          Properties.WordWrap = True
          TabOrder = 4
          Transparent = True
          Height = 41
          Width = 370
        end
        object AllRB: TcxRadioButton
          Tag = 3
          Left = 12
          Top = 27
          HelpContext = 108
          Caption = 'All'
          Checked = True
          TabOrder = 0
          TabStop = True
          AutoSize = True
          Transparent = True
        end
        object CurPageRB: TcxRadioButton
          Tag = 4
          Left = 12
          Top = 49
          HelpContext = 118
          Caption = 'Current page'
          TabOrder = 1
          AutoSize = True
          Transparent = True
        end
        object PageNumbersRB: TcxRadioButton
          Tag = 5
          Left = 12
          Top = 72
          HelpContext = 124
          Caption = 'Pages:'
          TabOrder = 2
          AutoSize = True
          Transparent = True
        end
        object PageNumbersE: TcxTextEdit
          Left = 106
          Top = 70
          HelpContext = 133
          TabOrder = 3
          OnKeyPress = PageNumbersEKeyPress
          Width = 175
        end
      end
      object GroupQuality: TcxGroupBox
        Tag = 8
        AlignWithMargins = True
        Left = 3
        Top = 152
        Align = alClient
        Caption = ' Export settings '
        Style.TextStyle = [fsBold]
        TabOrder = 1
        Height = 0
        Width = 395
      end
      object SaveToGroupBox: TcxGroupBox
        Tag = 162
        Left = 0
        Top = 152
        Align = alBottom
        Caption = 'Save To'
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 2
        Height = 81
        Width = 401
        object FiltersNameCB: TcxComboBox
          AlignWithMargins = True
          Left = 5
          Top = 24
          Margins.Top = 22
          Align = alTop
          TabOrder = 0
          Text = 'FiltersNameCB'
          Width = 391
        end
        object OpenCB: TcxCheckBox
          Tag = 8706
          Left = 6
          Top = 50
          Caption = 'Open after export'
          State = cbsChecked
          TabOrder = 1
        end
      end
    end
  end
  object ButtonsGroupBox: TcxGroupBox
    Left = 0
    Top = 271
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    Height = 40
    Width = 415
    object CancelB: TcxButton
      Tag = 2
      AlignWithMargins = True
      Left = 320
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
      Left = 224
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
      OnClick = OkBClick
    end
  end
end
