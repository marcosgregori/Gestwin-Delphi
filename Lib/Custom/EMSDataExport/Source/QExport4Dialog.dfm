object QExport4DialogF: TQExport4DialogF
  Left = 417
  Top = 294
  BorderStyle = bsDialog
  Caption = 'QExport4DialogF'
  ClientHeight = 475
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object paFileName: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    ParentShowHint = False
    ShowHint = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    DesignSize = (
      475
      67)
    Height = 67
    Width = 475
    object laFileName: TcxLabel
      Left = 9
      Top = 13
      Caption = 'Destination file'
      Transparent = True
    end
    object edFileName: TEdit
      Left = 101
      Top = 10
      Width = 257
      Height = 23
      TabOrder = 0
      OnChange = edFileNameChange
    end
    object chShowFile: TcxCheckBox
      Left = 9
      Top = 38
      Caption = 'Open file after export'
      TabOrder = 1
      Transparent = True
      OnClick = chShowFileClick
    end
    object chPrintFile: TcxCheckBox
      Left = 201
      Top = 38
      Caption = 'Print file after export'
      TabOrder = 2
      Transparent = True
      OnClick = chPrintFileClick
    end
    object bBrowse: TgBitBtn
      Left = 365
      Top = 8
      Width = 106
      Height = 28
      Anchors = [akTop, akRight]
      Caption = '&Seleccionar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = GContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 3
      TabStop = False
      OnClick = bBrowseClick
      GlyphBitmap = gmFolder
    end
  end
  object paButtons: TcxGroupBox
    Left = 0
    Top = 443
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    Height = 32
    Width = 475
    object bCancel: TgBitBtn
      Left = 386
      Top = 2
      Width = 85
      Height = 28
      Cancel = True
      Caption = '&Cerrar'
      Enabled = True
      ModalResult = 2
      OptionsImage.ImageIndex = 7
      OptionsImage.Images = GContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 0
      GlyphBitmap = gmClose
    end
    object bStart: TgBitBtn
      Left = 297
      Top = 2
      Width = 85
      Height = 28
      Caption = 'E&xportar'
      Enabled = True
      OptionsImage.ImageIndex = 28
      OptionsImage.Images = GContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      OnClick = bStartClick
      GlyphBitmap = gmExport
    end
    object bTools: TgBitBtn
      Left = 4
      Top = 2
      Width = 91
      Height = 28
      Caption = 'Plantillas'
      Enabled = True
      OptionsImage.ImageIndex = 10
      OptionsImage.Images = GContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 2
      OnClick = bToolsClick
      GlyphBitmap = gmSetup
    end
  end
  object Pages: TcxPageControl
    Left = 0
    Top = 67
    Width = 475
    Height = 376
    Align = alClient
    TabOrder = 2
    Properties.ActivePage = tshExportType
    Properties.CustomButtons.Buttons = <>
    OnChange = PagesChange
    ClientRectBottom = 374
    ClientRectLeft = 2
    ClientRectRight = 473
    ClientRectTop = 24
    object tshExportType: TcxTabSheet
      Caption = 'Export &Type'
      object pcExportType: TcxPageControl
        Left = 0
        Top = 0
        Width = 471
        Height = 350
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = tshExportFormats
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 469
        ClientRectTop = 24
        object tshExportFormats: TcxTabSheet
          Caption = '&Formats'
          object rgExportType: TcxRadioGroup
            Left = 0
            Top = 0
            Caption = '  Export to  '
            Properties.Columns = 3
            Properties.Items = <
              item
                Caption = 'MS Excel'
                Value = 0
              end
              item
                Caption = 'MS Word'
                Value = 0
              end
              item
                Caption = 'RTF'
                Value = 0
              end
              item
                Caption = 'HTML'
                Value = 0
              end
              item
                Caption = 'Text File'
                Value = 0
              end
              item
                Caption = 'XML'
                Value = 0
              end
              item
                Caption = 'DBF'
                Value = 0
              end
              item
                Caption = 'PDF'
                Value = 0
              end
              item
                Caption = 'CSV File'
                Value = 0
              end
              item
                Caption = 'DIF File'
                Value = 0
              end
              item
                Caption = 'SYLK File'
                Value = 0
              end
              item
                Caption = 'LaTeX'
                Value = 0
              end
              item
                Caption = 'SQL'
                Value = 0
              end
              item
                Caption = 'Windows Clipboard'
                Value = 0
              end
              item
                Caption = 'ODS'
                Value = 0
              end
              item
                Caption = 'ODT'
                Value = 0
              end
              item
                Caption = 'MS Excel 2007'
                Value = 0
              end
              item
                Caption = 'MS Word 2007'
                Value = 0
              end
              item
                Caption = 'MS Access'
                Value = 0
              end
              item
                Caption = 'MS Access 2007'
                Value = 0
              end>
            ItemIndex = 0
            TabOrder = 0
            OnClick = rgExportTypeClick
            Height = 181
            Width = 459
          end
        end
        object tshExportOptions: TcxTabSheet
          Caption = '&Options'
          object gbExportConstraints: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            Caption = '  Constraints  '
            TabOrder = 0
            Height = 134
            Width = 467
            object laSkipRecCount_01: TcxLabel
              Left = 14
              Top = 83
              Caption = 'Skip'
              Transparent = True
            end
            object laSkipRecCount_02: TcxLabel
              Left = 104
              Top = 83
              Caption = 'record(s)'
              Transparent = True
            end
            object laExportRecCount_02: TcxLabel
              Left = 328
              Top = 102
              Caption = 'record(s)'
              Enabled = False
              Transparent = True
            end
            object edSkipRecCount: TEdit
              Left = 58
              Top = 79
              Width = 40
              Height = 23
              TabOrder = 3
              Text = '0'
              OnChange = edSkipRecCountChange
              OnKeyPress = NumberKeyPress
            end
            object chGoToFirstRecord: TcxCheckBox
              Left = 14
              Top = 21
              Caption = 'Go to the first record'
              State = cbsChecked
              TabOrder = 0
              Transparent = True
              OnClick = chGoToFirstRecordClick
            end
            object rbExportAllRecords: TcxRadioButton
              Left = 195
              Top = 81
              Width = 179
              Height = 17
              Caption = 'Export all records'
              Checked = True
              TabOrder = 4
              TabStop = True
              OnClick = rbExportAllRecordsClick
              Transparent = True
            end
            object rbExportOnly: TcxRadioButton
              Left = 195
              Top = 104
              Width = 95
              Height = 17
              Caption = 'Export only'
              TabOrder = 6
              OnClick = rbExportOnlyClick
              Transparent = True
            end
            object edExportRecCount: TEdit
              Left = 280
              Top = 101
              Width = 40
              Height = 23
              Enabled = False
              TabOrder = 5
              Text = '0'
              OnChange = edExportRecCountChange
              OnKeyPress = NumberKeyPress
            end
            object chCurrentRecordOnly: TcxCheckBox
              Left = 251
              Top = 21
              Caption = 'Current record only'
              TabOrder = 1
              Transparent = True
              OnClick = chCurrentRecordOnlyClick
            end
            object chExportEmpty: TcxCheckBox
              Left = 14
              Top = 43
              Caption = 'Allow export empty data source'
              TabOrder = 2
              Transparent = True
              OnClick = chExportEmptyClick
            end
          end
        end
      end
    end
    object tshFields: TcxTabSheet
      Caption = 'F&ields'
      object bAddOneExportedField: TSpeedButton
        Left = 205
        Top = 112
        Width = 51
        Height = 22
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEE88EEEEEEEEEEEEEE608EEEEEEEEEEEEE6608EEE
          EEEEEEEEE66608EEEEEEEEEEE666608EEEEEEEEEE6666608EEEEEEEEE666666E
          EEEEEEEEE66666EEEEEEEEEEE6666EEEEEEEEEEEE666EEEEEEEEEEEEE66EEEEE
          EEEEEEEEE6EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        Layout = blGlyphTop
        Margin = 1
        OnClick = bAddOneExportedFieldClick
      end
      object bAddAllExportedField: TSpeedButton
        Left = 205
        Top = 138
        Width = 51
        Height = 22
        Caption = '>>'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEE88EEEEEE88EEEEEE608EEEEE608EEEEE6608EEEE660
          8EEEE66608EEE66608EEE666608EE666608EE6666608E6666608E666666EE666
          666EE66666EEE66666EEE6666EEEE6666EEEE666EEEEE666EEEEE66EEEEEE66E
          EEEEE6EEEEEEE6EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        Layout = blGlyphTop
        Margin = 1
        OnClick = bAddAllExportedFieldClick
      end
      object bDelOneExportedField: TSpeedButton
        Left = 205
        Top = 195
        Width = 51
        Height = 22
        Caption = '<'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEE88EEEEEEEEEEEEE806EEEEEEEEEEEE8066E
          EEEEEEEEEE80666EEEEEEEEEE806666EEEEEEEEE8066666EEEEEEEEEE666666E
          EEEEEEEEEE66666EEEEEEEEEEEE6666EEEEEEEEEEEEE666EEEEEEEEEEEEEE66E
          EEEEEEEEEEEEEE6EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        Layout = blGlyphTop
        Margin = 1
        OnClick = bDelOneExportedFieldClick
      end
      object bDelAllExportedField: TSpeedButton
        Left = 205
        Top = 221
        Width = 51
        Height = 22
        Caption = '<<'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEE88EEEEEE88EEEEE806EEEEE806EEEE8066EEEE8
          066EEE80666EEE80666EE806666EE806666E8066666E8066666EE666666EE666
          666EEE66666EEE66666EEEE6666EEEE6666EEEEE666EEEEE666EEEEEE66EEEEE
          E66EEEEEEE6EEEEEEE6EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        Layout = blGlyphTop
        Margin = 1
        OnClick = bDelAllExportedFieldClick
      end
      object laAvailableFields: TcxLabel
        Left = 0
        Top = 8
        AutoSize = False
        Caption = 'Availabel fields:'
        ParentColor = False
        Transparent = True
        Height = 22
        Width = 200
      end
      object laExportedFields: TcxLabel
        Left = 262
        Top = 8
        AutoSize = False
        Caption = 'Exported fields:'
        ParentColor = False
        Transparent = True
        Height = 22
        Width = 200
      end
      object lstAvailableFields: TListView
        Left = 0
        Top = 30
        Width = 200
        Height = 292
        Columns = <
          item
            Width = 195
          end
          item
            Width = 0
          end>
        DragMode = dmAutomatic
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SmallImages = imgFields
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = bAddOneExportedFieldClick
        OnDragDrop = lstAvailableFieldsDragDrop
        OnDragOver = FieldsListDragOver
      end
      object lstExportedFields: TListView
        Left = 262
        Top = 30
        Width = 200
        Height = 292
        Columns = <
          item
            Width = 195
          end
          item
            Width = 0
          end>
        DragMode = dmAutomatic
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SmallImages = imgFields
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = bDelOneExportedFieldClick
        OnDragDrop = lstExportedFieldsDragDrop
        OnDragOver = FieldsListDragOver
      end
      object chShowDisplayLabel: TcxCheckBox
        Left = 12
        Top = 324
        Caption = 'Show Display Label'
        TabOrder = 2
        OnClick = chShowDisplayLabelClick
      end
    end
    object tshFormats: TcxTabSheet
      Caption = '&Formats'
      object gbStandardFormats: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Caption = '  Common  '
        TabOrder = 0
        Height = 147
        Width = 471
        object laIntegerFormat: TcxLabel
          Left = 4
          Top = 19
          AutoSize = False
          Caption = 'Integer Format'
          Transparent = True
          Height = 19
          Width = 95
        end
        object laDateFormat: TcxLabel
          Left = 4
          Top = 43
          AutoSize = False
          Caption = 'Date Format'
          Transparent = True
          Height = 19
          Width = 95
        end
        object laDateTimeFormat: TcxLabel
          Left = 4
          Top = 67
          AutoSize = False
          Caption = 'DateTime Format'
          Transparent = True
          Height = 19
          Width = 95
        end
        object laFloatFormat: TcxLabel
          Left = 222
          Top = 19
          AutoSize = False
          Caption = 'FloatFormat'
          Transparent = True
          Height = 19
          Width = 94
        end
        object laTimeFormat: TcxLabel
          Left = 222
          Top = 43
          AutoSize = False
          Caption = 'Time Format'
          Transparent = True
          Height = 19
          Width = 94
        end
        object laCurrencyFormat: TcxLabel
          Left = 222
          Top = 67
          AutoSize = False
          Caption = 'Currency Format'
          Transparent = True
          Height = 19
          Width = 94
        end
        object laBooleanTrue: TcxLabel
          Left = 4
          Top = 91
          AutoSize = False
          Caption = 'Boolean true'
          Transparent = True
          Height = 19
          Width = 95
        end
        object laBooleanFalse: TcxLabel
          Left = 222
          Top = 91
          AutoSize = False
          Caption = 'Boolean false'
          Transparent = True
          Height = 19
          Width = 94
        end
        object laNullString: TcxLabel
          Left = 4
          Top = 115
          AutoSize = False
          Caption = 'Null string'
          Transparent = True
          Height = 19
          Width = 95
        end
        object edIntegerFormat: TEdit
          Left = 103
          Top = 15
          Width = 115
          Height = 23
          TabOrder = 0
          OnChange = edIntegerFormatChange
        end
        object edDateFormat: TEdit
          Left = 103
          Top = 39
          Width = 115
          Height = 23
          TabOrder = 2
          OnChange = edDateFormatChange
        end
        object edDateTimeFormat: TEdit
          Left = 103
          Top = 63
          Width = 115
          Height = 23
          TabOrder = 4
          OnChange = edDateTimeFormatChange
        end
        object edFloatFormat: TEdit
          Left = 340
          Top = 15
          Width = 115
          Height = 23
          TabOrder = 1
          OnChange = edFloatFormatChange
        end
        object edTimeFormat: TEdit
          Left = 340
          Top = 39
          Width = 115
          Height = 23
          TabOrder = 3
          OnChange = edTimeFormatChange
        end
        object edCurrencyFormat: TEdit
          Left = 340
          Top = 63
          Width = 115
          Height = 23
          TabOrder = 5
          OnChange = edCurrencyFormatChange
        end
        object edBooleanTrue: TEdit
          Left = 103
          Top = 87
          Width = 115
          Height = 23
          TabOrder = 6
          OnChange = edBooleanTrueChange
        end
        object edBooleanFalse: TEdit
          Left = 340
          Top = 87
          Width = 115
          Height = 23
          TabOrder = 7
          OnChange = edBooleanFalseChange
        end
        object edNullString: TEdit
          Left = 103
          Top = 111
          Width = 115
          Height = 23
          TabOrder = 8
          OnChange = edNullStringChange
        end
      end
      object gbUserFormat: TcxGroupBox
        Left = 0
        Top = 221
        Align = alClient
        Caption = '  User  '
        TabOrder = 2
        Height = 129
        Width = 471
        object bAddUserFormat: TSpeedButton
          Left = 347
          Top = 15
          Width = 75
          Height = 25
          Caption = '&Add'
          OnClick = bAddUserFormatClick
        end
        object bEditUserFormat: TSpeedButton
          Left = 347
          Top = 40
          Width = 75
          Height = 25
          Caption = '&Edit'
          OnClick = bEditUserFormatClick
        end
        object bDeleteUserFormat: TSpeedButton
          Left = 347
          Top = 65
          Width = 75
          Height = 25
          Caption = '&Delete'
          OnClick = bDeleteUserFormatClick
        end
        object bClearUserFormats: TSpeedButton
          Left = 347
          Top = 90
          Width = 75
          Height = 25
          Caption = 'C&lear'
          OnClick = bClearUserFormatsClick
        end
        object laEqual_01: TcxLabel
          Left = 159
          Top = 17
          AutoSize = False
          Caption = '='
          ParentFont = False
          Transparent = True
          Height = 19
          Width = 15
        end
        object cbxFormatFields: TComboBox
          Left = 8
          Top = 15
          Width = 145
          Height = 23
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbxFormatFieldsChange
        end
        object cbxUserFormats: TComboBox
          Left = 181
          Top = 15
          Width = 145
          Height = 23
          TabOrder = 1
        end
        object lstUserFormats: TListView
          Left = 8
          Top = 41
          Width = 318
          Height = 74
          Columns = <
            item
              Width = 142
            end
            item
              Alignment = taCenter
              Width = 30
            end
            item
              Width = 142
            end>
          HideSelection = False
          ReadOnly = True
          RowSelect = True
          ShowColumnHeaders = False
          SmallImages = imgFields
          TabOrder = 2
          ViewStyle = vsReport
        end
      end
      object gbSeparators: TcxGroupBox
        Left = 0
        Top = 147
        Align = alTop
        Caption = 'Separators'
        TabOrder = 1
        Height = 74
        Width = 471
        object laDecimalSeparator: TcxLabel
          Left = 4
          Top = 19
          AutoSize = False
          Caption = 'Decimal Separator'
          Transparent = True
          Height = 19
          Width = 115
        end
        object laThousandSeparator: TcxLabel
          Left = 222
          Top = 19
          AutoSize = False
          Caption = 'Thousand Separator'
          Transparent = True
          Height = 19
          Width = 115
        end
        object laDateSeparator: TcxLabel
          Left = 4
          Top = 44
          AutoSize = False
          Caption = 'Date Separator'
          Transparent = True
          Height = 19
          Width = 115
        end
        object laTimeSeparator: TcxLabel
          Left = 222
          Top = 44
          AutoSize = False
          Caption = 'Time Separator'
          Transparent = True
          Height = 19
          Width = 115
        end
        object edDecimalSeparator: TEdit
          Left = 125
          Top = 15
          Width = 93
          Height = 23
          TabOrder = 0
          OnExit = edDecimalSeparatorExit
        end
        object edThousandSeparator: TEdit
          Left = 340
          Top = 15
          Width = 93
          Height = 23
          TabOrder = 1
          OnExit = edThousandSeparatorExit
        end
        object edDateSeparator: TEdit
          Left = 125
          Top = 40
          Width = 93
          Height = 23
          TabOrder = 2
          OnExit = edDateSeparatorExit
        end
        object edTimeSeparator: TEdit
          Left = 340
          Top = 40
          Width = 93
          Height = 23
          TabOrder = 3
          OnExit = edTimeSeparatorExit
        end
      end
    end
    object tshHeaderFooter: TcxTabSheet
      Caption = 'Hea&der && Footer'
      object laHeader: TcxLabel
        Left = 9
        Top = 12
        AutoSize = False
        Caption = 'Header text:'
        ParentColor = False
        Transparent = True
        Height = 22
        Width = 440
      end
      object laFooter: TcxLabel
        Left = 9
        Top = 173
        AutoSize = False
        Caption = 'Footer text:'
        ParentColor = False
        Transparent = True
        Height = 20
        Width = 440
      end
      object memHeader: TMemo
        Left = 9
        Top = 34
        Width = 440
        Height = 135
        TabOrder = 0
      end
      object memFooter: TMemo
        Left = 9
        Top = 193
        Width = 440
        Height = 128
        TabOrder = 1
      end
    end
    object tshCaptions: TcxTabSheet
      Caption = '&Captions'
      object laCaptionRow: TcxLabel
        Left = 330
        Top = 2
        Caption = 'Caption row'
        Transparent = True
      end
      object sgrCaptions: TStringGrid
        Left = 0
        Top = 25
        Width = 462
        Height = 320
        ColCount = 2
        DefaultRowHeight = 19
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        TabOrder = 2
        OnDrawCell = sgrCaptionsDrawCell
        OnGetEditText = sgrCaptionsGetEditText
        ColWidths = (
          64
          64)
        RowHeights = (
          19
          19)
      end
      object chAllowCaptions: TcxCheckBox
        Left = 1
        Top = 1
        Caption = 'Allow captions'
        State = cbsChecked
        TabOrder = 1
        Transparent = True
        OnClick = chAllowCaptionsClick
      end
      object cbxColumnAlign: TComboBox
        Left = 80
        Top = 87
        Width = 75
        Height = 23
        Style = csDropDownList
        TabOrder = 3
        Visible = False
        OnExit = cbxColumnAlignExit
      end
      object edColumnWidth: TEdit
        Left = 67
        Top = 119
        Width = 85
        Height = 23
        TabOrder = 4
        Text = '0'
        Visible = False
        OnExit = edColumnWidthExit
      end
      object udColumnWidth: TUpDown
        Left = 152
        Top = 119
        Width = 15
        Height = 23
        Associate = edColumnWidth
        Max = 1000
        TabOrder = 5
        Visible = False
      end
      object edCaptionRow: TEdit
        Left = 412
        Top = 1
        Width = 50
        Height = 23
        TabOrder = 0
        Text = '-1'
        OnExit = edCaptionRowExit
        OnKeyDown = edCaptionRowKeyDown
      end
    end
    object tshRTF: TcxTabSheet
      Caption = 'Word / RTF Options'
      object pcRTF: TcxPageControl
        Left = 1
        Top = 1
        Width = 460
        Height = 352
        TabOrder = 0
        Properties.ActivePage = tsRTFDataStyles
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 350
        ClientRectLeft = 2
        ClientRectRight = 458
        ClientRectTop = 24
        object tsRTFDataStyles: TcxTabSheet
          Caption = 'Data Styles'
          object pcRTFStyles: TcxPageControl
            Left = 0
            Top = 0
            Width = 190
            Height = 326
            Align = alLeft
            TabOrder = 0
            Properties.ActivePage = tsRTFBaseStyles
            Properties.CustomButtons.Buttons = <>
            OnChange = pcRTFStylesChange
            ExplicitHeight = 322
            ClientRectBottom = 324
            ClientRectLeft = 2
            ClientRectRight = 188
            ClientRectTop = 24
            object tsRTFBaseStyles: TcxTabSheet
              Caption = 'Base Styles'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object lstRTFBaseStyles: TListView
                Left = 0
                Top = 0
                Width = 182
                Height = 292
                Align = alClient
                Columns = <
                  item
                    Width = 178
                  end>
                HideSelection = False
                MultiSelect = True
                ReadOnly = True
                ShowColumnHeaders = False
                SmallImages = imgFields
                TabOrder = 0
                ViewStyle = vsReport
                OnChange = lstRTFBaseStylesChange
                OnDeletion = lstRTFBaseStylesDeletion
              end
            end
            object tsRTFStripStyles: TcxTabSheet
              Caption = 'Strip Styles'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object tbRTFStripStyles: TToolBar
                Left = 0
                Top = 0
                Width = 182
                Height = 24
                AutoSize = True
                ButtonHeight = 24
                ButtonWidth = 25
                Images = ilXLSStyles
                TabOrder = 0
                object tbtAddRTFStyle: TToolButton
                  Left = 0
                  Top = 0
                  Caption = 'tbtAddRTFStyle'
                  ImageIndex = 0
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtAddRTFStyleClick
                end
                object tbtDelRTFStyle: TToolButton
                  Left = 25
                  Top = 0
                  Caption = 'tbtDelRTFStyle'
                  ImageIndex = 1
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtDelRTFStyleClick
                end
                object tbtMoveRTFStyleUp: TToolButton
                  Left = 50
                  Top = 0
                  Caption = 'tbtMoveRTFStyleUp'
                  ImageIndex = 2
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtMoveRTFStyleUpClick
                end
                object tbtMoveRTFStyleDown: TToolButton
                  Left = 75
                  Top = 0
                  Caption = 'tbtMoveRTFStyleDown'
                  ImageIndex = 3
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtMoveRTFStyleDownClick
                end
                object ToolButton6: TToolButton
                  Left = 100
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton6'
                  ImageIndex = 4
                  Style = tbsSeparator
                end
                object tbtLoadRTFStyle: TToolButton
                  Left = 108
                  Top = 0
                  Caption = 'tbtLoadRTFStyle'
                  ImageIndex = 4
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtLoadRTFStyleClick
                end
                object tbtSaveRTFStyle: TToolButton
                  Left = 133
                  Top = 0
                  Caption = 'tbtSaveRTFStyle'
                  ImageIndex = 5
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtSaveRTFStyleClick
                end
              end
              object lstRTFStripStyles: TListView
                Left = 0
                Top = 24
                Width = 182
                Height = 229
                Align = alClient
                Columns = <
                  item
                    Width = 178
                  end>
                HideSelection = False
                ReadOnly = True
                ShowColumnHeaders = False
                SmallImages = imgFields
                TabOrder = 1
                ViewStyle = vsReport
                OnChange = lstRTFBaseStylesChange
                OnDeletion = lstRTFBaseStylesDeletion
              end
              object rgRTFStripType: TRadioGroup
                Left = 0
                Top = 253
                Width = 182
                Height = 39
                Align = alBottom
                Caption = 'Strip Type'
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  'None'
                  'Col'
                  'Row')
                TabOrder = 2
                OnClick = rgRTFStripTypeClick
              end
            end
          end
          object paRTFStyle: TcxGroupBox
            Left = 193
            Top = 0
            TabOrder = 1
            Height = 323
            Width = 258
            object pbRTFSample: TPaintBox
              Left = 5
              Top = 169
              Width = 248
              Height = 50
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -20
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              OnPaint = pbRTFSamplePaint
            end
            object bRTFFontColor: TSpeedButton
              Left = 13
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Font color'
              Flat = True
              Glyph.Data = {
                C6050000424DC605000000000000360400002800000014000000140000000100
                0800000000009001000000000000000000000001000000010000000000000000
                80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                A6000020400000206000002080000020A0000020C0000020E000004000000040
                20000040400000406000004080000040A0000040C0000040E000006000000060
                20000060400000606000006080000060A0000060C0000060E000008000000080
                20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                20004000400040006000400080004000A0004000C0004000E000402000004020
                20004020400040206000402080004020A0004020C0004020E000404000004040
                20004040400040406000404080004040A0004040C0004040E000406000004060
                20004060400040606000406080004060A0004060C0004060E000408000004080
                20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                20008000400080006000800080008000A0008000C0008000E000802000008020
                20008020400080206000802080008020A0008020C0008020E000804000008040
                20008040400080406000804080008040A0008040C0008040E000806000008060
                20008060400080606000806080008060A0008060C0008060E000808000008080
                20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
                FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
                FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
                FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFF}
              ParentShowHint = False
              ShowHint = True
              Spacing = 0
              OnClick = bRTFFontColorClick
              OnMouseDown = bRTFFontColorMouseDown
              OnMouseUp = bRTFFontColorMouseUp
            end
            object bRTFFontBold: TSpeedButton
              Left = 38
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Bold'
              AllowAllUp = True
              GroupIndex = 1
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
                0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
                F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
                0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              Spacing = 0
              OnClick = bRTFFontBoldClick
            end
            object bRTFFontItalic: TSpeedButton
              Left = 63
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Italic'
              AllowAllUp = True
              GroupIndex = 2
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
                FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
                FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
                0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontItalicClick
            end
            object pbRTFFontColor: TPaintBox
              Left = 16
              Top = 81
              Width = 18
              Height = 4
              OnPaint = pbRTFFontColorPaint
            end
            object bRTFFontStrikeOut: TSpeedButton
              Left = 88
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Strike Out'
              AllowAllUp = True
              GroupIndex = 3
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
                FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
                F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
                0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontStrikeOutClick
            end
            object bRTFFontUnderline: TSpeedButton
              Left = 113
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Single'
              AllowAllUp = True
              GroupIndex = 4
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontUnderlineClick
            end
            object bRTFFontLeft: TSpeedButton
              Left = 144
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Left'
              GroupIndex = 5
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontLeftClick
            end
            object bRTFFontCenter: TSpeedButton
              Left = 169
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Center'
              GroupIndex = 5
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontCenterClick
            end
            object bRTFFontRight: TSpeedButton
              Left = 194
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Right'
              GroupIndex = 5
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontRightClick
            end
            object bRTFFontFill: TSpeedButton
              Left = 219
              Top = 63
              Width = 25
              Height = 25
              Hint = 'Fill'
              GroupIndex = 5
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              OnClick = bRTFFontFillClick
            end
            object bRTFBackgroundColor: TSpeedButton
              Left = 13
              Top = 93
              Width = 25
              Height = 25
              Hint = 'Background Color'
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                FFF7447FFFFFFFFF0000}
              ParentShowHint = False
              ShowHint = True
              Spacing = 0
              OnClick = bRTFBackgroundColorClick
              OnMouseDown = bRTFBackgroundColorMouseDown
              OnMouseUp = bRTFBackgroundColorMouseUp
            end
            object pbRTFBackgroundColor: TPaintBox
              Left = 16
              Top = 110
              Width = 18
              Height = 4
              OnPaint = pbRTFBackgroundColorPaint
            end
            object bRTFHighlightColor: TSpeedButton
              Left = 38
              Top = 93
              Width = 25
              Height = 25
              Hint = 'Highlight Color'
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000010000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF00000FFFFFFFFFFF0000FFFF
                08FFF0FFFFFFFFFF0000FFFFF08FC80FFFFFFFFF0000FFFFFF0CC880FFFFFFFF
                0000FFFFFFF0C8780FFFFFFF0000FFFFFFFF0FF780FFFFFF0000FFFFFFFFF0FF
                780FFFFF0000FFFFFFFFFF0FF7C0FFFF0000FFFFFFFFFFF07FC0FFFF0000FFFF
                FFFFFFFF000FFFFF0000}
              ParentShowHint = False
              ShowHint = True
              Spacing = 0
              OnClick = bRTFHighlightColorClick
              OnMouseDown = bRTFHighlightColorMouseDown
              OnMouseUp = bRTFHighlightColorMouseUp
            end
            object pbRTFHighlightColor: TPaintBox
              Left = 41
              Top = 110
              Width = 18
              Height = 4
              OnPaint = pbRTFHighlightColorPaint
            end
            object bRTFResetItem: TSpeedButton
              Left = 9
              Top = 225
              Width = 115
              Height = 22
              Caption = 'Reset Item'
              OnClick = bRTFResetItemClick
            end
            object bRTFResetAll: TSpeedButton
              Left = 135
              Top = 225
              Width = 115
              Height = 22
              Caption = 'Reset All'
              OnClick = bRTFResetAllClick
            end
            object laRTFSample: TcxLabel
              Left = 5
              Top = 146
              AutoSize = False
              Caption = 'Sample'
              ParentColor = False
              ParentFont = False
              Transparent = True
              Height = 20
              Width = 248
            end
            object laRTFFont: TcxLabel
              Left = 16
              Top = 13
              Caption = 'Font'
              Transparent = True
            end
            object laRTFFontSize: TcxLabel
              Left = 16
              Top = 38
              Caption = 'Size'
              Transparent = True
            end
            object cbRTFFont: TComboBox
              Left = 69
              Top = 12
              Width = 150
              Height = 23
              Style = csDropDownList
              TabOrder = 0
              OnChange = cbRTFFontChange
            end
            object cbRTFFontSize: TComboBox
              Left = 69
              Top = 37
              Width = 55
              Height = 23
              TabOrder = 1
              OnChange = cbRTFFontSizeChange
              Items.Strings = (
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
            end
            object chRTFAllowBackground: TcxCheckBox
              Left = 134
              Top = 121
              Caption = 'Allow Background'
              TabOrder = 3
              OnClick = chRTFAllowBackgroundClick
            end
            object chRTFAllowHighlight: TcxCheckBox
              Left = 12
              Top = 121
              Caption = 'Allow Highlight'
              TabOrder = 2
              OnClick = chRTFAllowHighlightClick
            end
          end
        end
        object tsRTFAdvanced: TcxTabSheet
          Caption = 'Advanced'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object rgRTFPageOrientation: TRadioGroup
            Left = 3
            Top = 1
            Width = 207
            Height = 42
            Caption = ' Page Orientation '
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Portrait'
              'Landscape')
            TabOrder = 0
            OnClick = rgRTFPageOrientationClick
          end
        end
      end
    end
    object tshXML: TcxTabSheet
      Caption = 'XML Options'
      object laXMLEncoding: TcxLabel
        Left = 190
        Top = 19
        Caption = 'Codificaci'#243'n'
        Transparent = True
      end
      object laXMLDocumentType: TcxLabel
        Left = 14
        Top = 55
        AutoSize = False
        Caption = 'XML document type'
        Transparent = True
        Height = 20
        Width = 130
      end
      object chXMLStandalone: TcxCheckBox
        Left = 14
        Top = 17
        Caption = 'Standalone'
        TabOrder = 1
        Transparent = True
        OnClick = chXMLStandaloneClick
      end
      object edXMLEncoding: TEdit
        Left = 267
        Top = 15
        Width = 170
        Height = 23
        TabOrder = 0
        OnChange = edXMLEncodingChange
      end
      object cbXMLDocumentType: TComboBox
        Left = 151
        Top = 52
        Width = 156
        Height = 23
        Style = csDropDownList
        TabOrder = 2
        OnChange = cbXMLDocumentTypeChange
        Items.Strings = (
          'Data Packet'
          'MS Access')
      end
      object gbXMLMSAccessOptions: TcxGroupBox
        Left = 7
        Top = 81
        Caption = 'XML MS Access options'
        TabOrder = 3
        Visible = False
        Height = 81
        Width = 449
        object chXMLMSAccessUseSchema: TcxCheckBox
          Left = 22
          Top = 22
          Caption = 'Create XSD schema'
          TabOrder = 0
          Transparent = True
          Visible = False
          OnClick = chXMLMSAccessUseSchemaClick
        end
        object chXMLMSAccessConvertImages: TcxCheckBox
          Left = 22
          Top = 42
          Caption = 'Convert images to bitmap'
          TabOrder = 1
          Transparent = True
          Visible = False
          OnClick = chXMLMSAccessConvertImagesClick
        end
      end
    end
    object tshSQL: TcxTabSheet
      Caption = '&SQL Options'
      object gbSQLCommit: TcxGroupBox
        Left = 0
        Top = 75
        Align = alTop
        Caption = '  Commit options  '
        TabOrder = 1
        Height = 75
        Width = 471
        object laSQLUseCommit_02: TcxLabel
          Left = 164
          Top = 22
          Caption = 'record(s)'
          Transparent = True
        end
        object laSQLCommitStatement: TcxLabel
          Left = 10
          Top = 48
          Caption = 'Commit statement'
          Transparent = True
        end
        object laSQLUseCommit_01: TcxLabel
          Left = 10
          Top = 22
          Caption = 'Commit after'
          Transparent = True
        end
        object edSQLCommitRecCount: TEdit
          Left = 117
          Top = 18
          Width = 41
          Height = 23
          TabOrder = 0
          Text = '0'
          OnChange = edSQLCommitRecCountChange
          OnKeyPress = NumberKeyPress
        end
        object chSQLCommitAfterScript: TcxCheckBox
          Left = 253
          Top = 20
          Caption = 'Commit after script'
          TabOrder = 1
          OnClick = chSQLCommitAfterScriptClick
        end
        object edSQLCommitStatement: TEdit
          Left = 117
          Top = 44
          Width = 310
          Height = 23
          TabOrder = 2
          OnChange = edSQLCommitStatementChange
        end
      end
      object gbSQLMisc: TcxGroupBox
        Left = 0
        Top = 150
        Align = alClient
        Caption = '  Other options'
        TabOrder = 2
        Height = 200
        Width = 471
        object laSQLNullString: TcxLabel
          Left = 10
          Top = 23
          Caption = 'Export null values as'
          Transparent = True
        end
        object laSQLStatementTerm: TcxLabel
          Left = 10
          Top = 49
          Caption = 'Statement term'
          Transparent = True
        end
        object edSQLNullString: TEdit
          Left = 133
          Top = 19
          Width = 100
          Height = 23
          TabOrder = 0
          OnChange = edSQLNullStringChange
        end
        object edSQLStatementTerm: TEdit
          Left = 133
          Top = 45
          Width = 27
          Height = 23
          TabOrder = 1
          Text = ';'
          OnChange = edSQLStatementTermChange
        end
      end
      object gbSQLTableOptions: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Caption = 'Table options'
        TabOrder = 0
        Height = 75
        Width = 471
        object laSQLTableName: TcxLabel
          Left = 10
          Top = 22
          Caption = 'Table name'
          Transparent = True
        end
        object chSQLCreateTable: TcxCheckBox
          Left = 13
          Top = 46
          Caption = 'Add "Create Table" statement'
          TabOrder = 1
          OnClick = chSQLCreateTableClick
        end
        object edSQLTableName: TEdit
          Left = 117
          Top = 18
          Width = 310
          Height = 23
          TabOrder = 0
          OnChange = edSQLTableNameChange
        end
      end
    end
    object tshHTML: TcxTabSheet
      Caption = '&HTML Options'
      object pcHTML: TcxPageControl
        Left = 0
        Top = 0
        Width = 471
        Height = 350
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = tshHTMLPreview
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 469
        ClientRectTop = 24
        object tshHTMLPreview: TcxTabSheet
          Caption = '&Preview'
          object paHTMLPreview: TcxGroupBox
            Left = 0
            Top = 0
            Align = alClient
            TabOrder = 0
            Height = 324
            Width = 467
            object bHTMLSaveTemplate: TSpeedButton
              Left = 320
              Top = 58
              Width = 120
              Height = 24
              Caption = 'S&ave as template ...'
              OnClick = bHTMLSaveTemplateClick
            end
            object bHTMLLoadTemplate: TSpeedButton
              Left = 320
              Top = 86
              Width = 120
              Height = 24
              Caption = '&Load template ...'
              OnClick = bHTMLLoadTemplateClick
            end
            object laHTMLTemplate: TcxLabel
              Left = 320
              Top = 9
              Caption = 'Template'
              Transparent = True
            end
            object paHTMLBackground: TcxGroupBox
              Left = 5
              Top = 6
              TabOrder = 0
              OnClick = paHTMLBackgroundClick
              Height = 210
              Width = 310
              object laHTMLFont: TcxLabel
                Tag = 1
                Left = 15
                Top = 7
                Hint = 'Click here for default font color select'
                Caption = 'Default text'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Transparent = True
                OnClick = laHTMLFontClick
              end
              object laHTMLLink: TcxLabel
                Tag = 11
                Left = 15
                Top = 173
                Hint = 'Click here for non-visited link color select'
                AutoSize = False
                Caption = 'Non-visited link'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Transparent = True
                OnClick = laHTMLLinkClick
                Height = 16
                Width = 287
              end
              object laHTMLVLink: TcxLabel
                Tag = 12
                Left = 15
                Top = 191
                Hint = 'Click here for visited link color select'
                AutoSize = False
                Caption = 'Visited link'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Transparent = True
                OnClick = laHTMLVLinkClick
                Height = 16
                Width = 287
              end
              object laHTMLALink: TcxLabel
                Tag = 13
                Left = 15
                Top = 155
                Hint = 'Click here for active link color select'
                AutoSize = False
                Caption = 'Active link'
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Transparent = True
                OnClick = laHTMLALinkClick
                Height = 16
                Width = 287
              end
              object paHTMLColumnHead_1: TcxGroupBox
                Left = 15
                Top = 26
                Hint = 'Click here for header row color select'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = paHTMLColumnHead_1Click
                Height = 25
                Width = 77
                object laHTMLHead_1: TcxLabel
                  Left = 23
                  Top = 4
                  Caption = 'Num'
                  ParentFont = False
                  Transparent = True
                  OnClick = laHTMLHead_1Click
                end
              end
              object paHTMLColumnHead_2: TcxGroupBox
                Left = 92
                Top = 26
                Hint = 'Click here for header row color select'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                OnClick = paHTMLColumnHead_1Click
                Height = 25
                Width = 105
                object laHTMLHead_2: TcxLabel
                  Left = 32
                  Top = 4
                  Caption = 'Name'
                  ParentFont = False
                  Transparent = True
                  OnClick = laHTMLHead_1Click
                end
              end
              object paHTMLColumnHead_3: TcxGroupBox
                Left = 197
                Top = 26
                Hint = 'Click here for header row color select'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                OnClick = paHTMLColumnHead_1Click
                Height = 25
                Width = 105
                object laHTMLHead_3: TcxLabel
                  Left = 39
                  Top = 4
                  Caption = 'Age'
                  ParentFont = False
                  Transparent = True
                  OnClick = laHTMLHead_1Click
                end
              end
              object paHTMLOddRowCol_1: TcxGroupBox
                Left = 15
                Top = 51
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 77
                object laHTMLData_1: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 1'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLOddRowCol_2: TcxGroupBox
                Left = 92
                Top = 51
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 4
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_5: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' John'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLOddRowCol_3: TcxGroupBox
                Left = 197
                Top = 51
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 5
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_9: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 34'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_1: TcxGroupBox
                Left = 15
                Top = 76
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 6
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 77
                object laHTMLData_2: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 2'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_2: TcxGroupBox
                Left = 92
                Top = 76
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 7
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_6: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' Marcella'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_3: TcxGroupBox
                Left = 197
                Top = 76
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 8
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_10: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 27'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLOddRowCol_4: TcxGroupBox
                Left = 15
                Top = 101
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 9
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 77
                object laHTMLData_3: TcxLabel
                  Left = 2
                  Top = 20
                  Align = alLeft
                  Caption = ' 3'
                  ParentFont = False
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLOddRowCol_5: TcxGroupBox
                Left = 92
                Top = 101
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 10
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_7: TcxLabel
                  Left = 2
                  Top = 20
                  Align = alLeft
                  Caption = ' Alex'
                  ParentFont = False
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLOddRowCol_6: TcxGroupBox
                Left = 197
                Top = 101
                Hint = 'Click for odd row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 11
                OnClick = paHTMLOddRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_11: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 25'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_4: TcxGroupBox
                Left = 15
                Top = 126
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 12
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 77
                object laHTMLData_4: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 4'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_5: TcxGroupBox
                Left = 92
                Top = 126
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 13
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_8: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' Julia'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
              object paHTMLEvenRowCol_6: TcxGroupBox
                Left = 197
                Top = 126
                Hint = 'Click for even row color change'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 14
                OnClick = paHTMLEvenRowCol_1Click
                Height = 25
                Width = 105
                object laHTMLData_12: TcxLabel
                  Left = 2
                  Top = 20
                  Hint = 'Click here to table font change'
                  Align = alLeft
                  Caption = ' 48'
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                  Transparent = True
                  OnClick = laHTMLData_1Click
                end
              end
            end
            object cbxHTMLTemplate: TComboBox
              Left = 320
              Top = 32
              Width = 120
              Height = 23
              Style = csDropDownList
              TabOrder = 1
              OnChange = cbxHTMLTemplateChange
              Items.Strings = (
                'Custom'
                'Black&White'
                'Classic'
                'ColorFul'
                'Gray'
                'MS_Money'
                'Murky'
                'Olive'
                'Plain'
                'Simple')
            end
          end
        end
        object tshHTMLBasic: TcxTabSheet
          Caption = '&Basic'
          object laHTMLTitle: TcxLabel
            Left = 8
            Top = 15
            AutoSize = False
            Caption = 'Title'
            Transparent = True
            Height = 21
            Width = 28
          end
          object edHTMLTitle: TEdit
            Left = 64
            Top = 14
            Width = 382
            Height = 23
            TabOrder = 0
            OnChange = edHTMLTitleChange
          end
          object gbHTMLUsingCSS: TcxGroupBox
            Left = 1
            Top = 43
            Caption = ' Using CSS '
            TabOrder = 1
            Height = 140
            Width = 455
            object btnHTMLCSSFileName: TSpeedButton
              Left = 364
              Top = 80
              Width = 23
              Height = 24
              Caption = ' ...'
              Enabled = False
              Margin = 0
              OnClick = btnHTMLCSSFileNameClick
            end
            object laHTMLCSSFileName: TcxLabel
              Left = 27
              Top = 81
              Caption = 'CSS file name'
              Enabled = False
              Transparent = True
            end
            object rbInternal: TcxRadioButton
              Left = 8
              Top = 23
              Width = 113
              Height = 17
              Caption = 'Internal'
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rbInternalClick
            end
            object rbExternal: TcxRadioButton
              Tag = 1
              Left = 8
              Top = 52
              Width = 113
              Height = 17
              Caption = 'External'
              TabOrder = 1
              OnClick = rbExternalClick
            end
            object edHTMLCSSFileName: TEdit
              Left = 140
              Top = 80
              Width = 221
              Height = 23
              Enabled = False
              TabOrder = 2
              OnChange = edHTMLCSSFileNameChange
            end
            object chHTMLOverwriteCSSFile: TcxCheckBox
              Left = 26
              Top = 107
              Caption = 'Overwrite CSS file if exists'
              Enabled = False
              TabOrder = 3
              OnClick = chHTMLOverwriteCSSFileClick
            end
          end
        end
        object tshHTMLMultifile: TcxTabSheet
          Caption = 'Multi-file'
          object gbHTMLMultifileOptions: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            Caption = '  Multi-file export  '
            TabOrder = 0
            Height = 265
            Width = 467
            object laHTMLFileRecCount_01: TcxLabel
              Left = 27
              Top = 46
              Caption = 'Maximum'
              Enabled = False
              Transparent = True
            end
            object laHTMLFileRecCount_02: TcxLabel
              Left = 134
              Top = 45
              Caption = 'record(s) in single file'
              Enabled = False
              Transparent = True
            end
            object laHTMLIndexLinkTemplate: TcxLabel
              Left = 46
              Top = 94
              Caption = 'Index Link Template'
              Transparent = True
            end
            object edHTMLFileRecCount: TEdit
              Left = 91
              Top = 44
              Width = 35
              Height = 23
              Enabled = False
              TabOrder = 2
              Text = '0'
              OnChange = edHTMLFileRecCountChange
              OnKeyPress = NumberKeyPress
            end
            object chHTMLGenerateIndex: TcxCheckBox
              Left = 27
              Top = 69
              Caption = 'Generate index'
              Enabled = False
              TabOrder = 3
              OnClick = chHTMLGenerateIndexClick
            end
            object chHTMLUseMultiFileExport: TcxCheckBox
              Left = 14
              Top = 19
              Caption = 'Use multi-file export'
              TabOrder = 0
              OnClick = chHTMLUseMultiFileExportClick
            end
            object gbHTMLNavigation: TcxGroupBox
              Left = 240
              Top = 69
              Caption = ' Navigation '
              TabOrder = 1
              Height = 184
              Width = 202
              object laHTMLIndexLinkTitle: TcxLabel
                Left = 10
                Top = 49
                Caption = 'Index Link Title'
              end
              object laHTMLFirstLinkTitle: TcxLabel
                Left = 10
                Top = 71
                Caption = 'First Link Title'
              end
              object laHTMLPriorLinkTitle: TcxLabel
                Left = 10
                Top = 93
                Caption = 'Prior Link Title'
              end
              object laHTMLNextLinkTitle: TcxLabel
                Left = 10
                Top = 115
                Caption = 'Next Link Title'
              end
              object laHTMLLastLinkTitle: TcxLabel
                Left = 10
                Top = 137
                Caption = 'Last Link Title'
              end
              object chHTMLNavigationOnTop: TcxCheckBox
                Left = 10
                Top = 18
                Caption = 'On Top'
                TabOrder = 0
                OnClick = chHTMLNavigationOnTopClick
              end
              object chHTMLNavigationOnBottom: TcxCheckBox
                Left = 92
                Top = 18
                Caption = 'On Bottom'
                TabOrder = 1
                OnClick = chHTMLNavigationOnBottomClick
              end
              object edHTMLIndexLinkTitle: TEdit
                Left = 92
                Top = 45
                Width = 100
                Height = 23
                TabOrder = 2
                Text = 'Index'
                OnChange = edHTMLIndexLinkTitleChange
              end
              object edHTMLFirstLinkTitle: TEdit
                Left = 92
                Top = 67
                Width = 100
                Height = 23
                TabOrder = 3
                Text = 'First'
                OnChange = edHTMLFirstLinkTitleChange
              end
              object edHTMLPriorLinkTitle: TEdit
                Left = 92
                Top = 89
                Width = 100
                Height = 23
                TabOrder = 4
                Text = 'Prior'
                OnChange = edHTMLPriorLinkTitleChange
              end
              object edHTMLNextLinkTitle: TEdit
                Left = 92
                Top = 111
                Width = 100
                Height = 23
                TabOrder = 5
                Text = 'Next'
                OnChange = edHTMLNextLinkTitleChange
              end
              object edHTMLLastLinkTitle: TEdit
                Left = 92
                Top = 133
                Width = 100
                Height = 23
                TabOrder = 6
                Text = 'Last'
                OnChange = edHTMLLastLinkTitleChange
              end
            end
            object edHTMLIndexLinkTemplate: TEdit
              Left = 46
              Top = 115
              Width = 169
              Height = 23
              TabOrder = 4
              OnChange = edHTMLIndexLinkTemplateChange
            end
          end
        end
        object tshHTMLAdvanced: TcxTabSheet
          Caption = '&Advanced'
          object gbHTMLBodyOptions: TcxGroupBox
            Left = 0
            Top = 0
            Align = alTop
            Caption = '  Body options  '
            TabOrder = 0
            Height = 105
            Width = 467
            object btnHTMLBackground: TSpeedButton
              Left = 422
              Top = 37
              Width = 21
              Height = 22
              Caption = ' ...'
              Margin = 0
              OnClick = btnHTMLBackgroundClick
            end
            object laHTMLBodyFontName: TcxLabel
              Left = 7
              Top = 15
              Caption = 'Font name'
              Transparent = True
            end
            object laHTMLBackground: TcxLabel
              Left = 7
              Top = 41
              Caption = 'Background'
              Transparent = True
            end
            object laHTMLBodyAdvanced: TcxLabel
              Left = 7
              Top = 66
              Caption = 'Advanced attributes'
              Transparent = True
            end
            object cbxHTMLFontName: TComboBox
              Left = 131
              Top = 12
              Width = 170
              Height = 23
              TabOrder = 0
              OnChange = cbxHTMLFontNameChange
            end
            object edHTMLBackground: TEdit
              Left = 131
              Top = 37
              Width = 287
              Height = 23
              TabOrder = 1
              OnChange = edHTMLBackgroundChange
            end
            object edHTMLBodyAdvanced: TEdit
              Left = 131
              Top = 62
              Width = 304
              Height = 23
              TabOrder = 2
              OnChange = edHTMLBodyAdvancedChange
            end
          end
          object gbHTMLTableOptions: TcxGroupBox
            Left = 0
            Top = 105
            Align = alTop
            Caption = '  Table options  '
            TabOrder = 1
            Height = 109
            Width = 467
            object btnHTMLTableBackground: TSpeedButton
              Left = 422
              Top = 44
              Width = 21
              Height = 22
              Caption = ' ...'
              Margin = 0
              OnClick = btnHTMLTableBackgroundClick
            end
            object laHTMLCellPadding: TcxLabel
              Left = 5
              Top = 19
              Caption = 'Cell padding'
              Transparent = True
            end
            object laHTMLCellSpacing: TcxLabel
              Left = 182
              Top = 19
              AutoSize = False
              Caption = 'Cell spacing'
              Transparent = True
              Height = 19
              Width = 77
            end
            object laHTMLBorderWidth: TcxLabel
              Left = 312
              Top = 19
              AutoSize = False
              Caption = 'Border'
              Transparent = True
              Height = 19
              Width = 73
            end
            object laHTMLTableAdvanced: TcxLabel
              Left = 5
              Top = 72
              Caption = 'Advanced attributes'
              Transparent = True
            end
            object laHTMLTableBackground: TcxLabel
              Left = 7
              Top = 47
              Caption = 'Background'
              Transparent = True
            end
            object edHTMLCellPadding: TEdit
              Left = 131
              Top = 18
              Width = 48
              Height = 23
              TabOrder = 0
              OnChange = edHTMLCellPaddingChange
              OnKeyPress = NumberKeyPress
            end
            object edHTMLCellSpacing: TEdit
              Left = 262
              Top = 18
              Width = 48
              Height = 23
              TabOrder = 1
              OnChange = edHTMLCellSpacingChange
              OnKeyPress = NumberKeyPress
            end
            object edHTMLBorderWidth: TEdit
              Left = 387
              Top = 18
              Width = 48
              Height = 23
              TabOrder = 2
              OnChange = edHTMLBorderWidthChange
              OnKeyPress = NumberKeyPress
            end
            object edHTMLTableAdvanced: TEdit
              Left = 131
              Top = 68
              Width = 304
              Height = 23
              TabOrder = 4
              OnChange = edHTMLTableAdvancedChange
            end
            object edHTMLTableBackground: TEdit
              Left = 131
              Top = 43
              Width = 287
              Height = 23
              TabOrder = 3
              OnChange = edHTMLTableBackgroundChange
            end
          end
        end
      end
    end
    object tshXLS: TcxTabSheet
      Caption = '&Excel Options'
      object pcXLS: TcxPageControl
        Left = 0
        Top = 0
        Width = 471
        Height = 350
        Align = alClient
        TabOrder = 0
        Properties.ActivePage = tshXLSExtensions
        Properties.CustomButtons.Buttons = <>
        OnChange = pcXLSChange
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 469
        ClientRectTop = 24
        object tshXLSDataFormat: TcxTabSheet
          Caption = '&Data Format'
          object btnXLSResetItem: TSpeedButton
            Left = 211
            Top = 245
            Width = 107
            Height = 28
            Caption = 'Reset Item'
            OnClick = btnXLSResetItemClick
          end
          object btnXLSResetAll: TSpeedButton
            Left = 322
            Top = 245
            Width = 107
            Height = 28
            Caption = 'Reset All'
            OnClick = btnXLSResetAllClick
          end
          object pcXLSDataFormat: TcxPageControl
            Left = 184
            Top = 0
            Width = 270
            Height = 143
            TabOrder = 1
            Properties.ActivePage = tshXLSFont
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 141
            ClientRectLeft = 2
            ClientRectRight = 268
            ClientRectTop = 24
            object tshXLSFont: TcxTabSheet
              Caption = '&Font'
              object btnFontColor: TSpeedButton
                Left = 9
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Font color'
                Flat = True
                Glyph.Data = {
                  C6050000424DC605000000000000360400002800000014000000140000000100
                  0800000000009001000000000000000000000001000000010000000000000000
                  80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                  A6000020400000206000002080000020A0000020C0000020E000004000000040
                  20000040400000406000004080000040A0000040C0000040E000006000000060
                  20000060400000606000006080000060A0000060C0000060E000008000000080
                  20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                  200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                  200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                  200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                  20004000400040006000400080004000A0004000C0004000E000402000004020
                  20004020400040206000402080004020A0004020C0004020E000404000004040
                  20004040400040406000404080004040A0004040C0004040E000406000004060
                  20004060400040606000406080004060A0004060C0004060E000408000004080
                  20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                  200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                  200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                  200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                  20008000400080006000800080008000A0008000C0008000E000802000008020
                  20008020400080206000802080008020A0008020C0008020E000804000008040
                  20008040400080406000804080008040A0008040C0008040E000806000008060
                  20008060400080606000806080008060A0008060C0008060E000808000008080
                  20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                  200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                  200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                  200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                  2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                  2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                  2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                  2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                  2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                  2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                  2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
                  FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnFontColorClick
                OnMouseDown = btnFontColorMouseDown
                OnMouseUp = btnFontColorMouseUp
              end
              object btnFontBold: TSpeedButton
                Left = 40
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Bold'
                AllowAllUp = True
                GroupIndex = 1
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
                  0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
                  F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
                  0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnFontBoldClick
              end
              object btnFontItalic: TSpeedButton
                Left = 65
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Italic'
                AllowAllUp = True
                GroupIndex = 2
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
                  FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
                  FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
                  0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnFontItalicClick
              end
              object btnFontStrikeOut: TSpeedButton
                Left = 90
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Strike Out'
                AllowAllUp = True
                GroupIndex = 3
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
                  FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
                  F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
                  0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnFontStrikeOutClick
              end
              object btnUnderlineSingle: TSpeedButton
                Left = 121
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Single'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnUnderlineSingleClick
              end
              object btnUnderlineSingleAccounting: TSpeedButton
                Left = 146
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Single Accounting'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000FFF000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnUnderlineSingleAccountingClick
              end
              object btnUnderlineDouble: TSpeedButton
                Left = 171
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Double'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  F000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnUnderlineDoubleClick
              end
              object btnUnderlineDoubleAccounting: TSpeedButton
                Left = 196
                Top = 56
                Width = 25
                Height = 25
                Hint = 'Double Accounting'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  F000FFF000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000FFF000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnUnderlineDoubleAccountingClick
              end
              object btnHorizontalLeft: TSpeedButton
                Left = 40
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Left'
                AllowAllUp = True
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnHorizontalLeftClick
              end
              object btnHorizontalCenter: TSpeedButton
                Left = 65
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Center'
                AllowAllUp = True
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnHorizontalCenterClick
              end
              object btnHorizontalRight: TSpeedButton
                Left = 90
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Right'
                AllowAllUp = True
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnHorizontalRightClick
              end
              object btnHorizontalFill: TSpeedButton
                Left = 115
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Fill'
                AllowAllUp = True
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnHorizontalFillClick
              end
              object btnVerticalTop: TSpeedButton
                Left = 146
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Top'
                GroupIndex = 7
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7
                  FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF
                  0000FFF7FFF7FFF7FFF7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                  F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                  F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                  0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnVerticalTopClick
              end
              object btnVerticalCenter: TSpeedButton
                Left = 172
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Center'
                GroupIndex = 7
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  F7FFF7FFF7FFFFFF0000FFFFF7FFF7FFF7FFFFFF0000FFF7F7F7F7F7F7F7FFFF
                  0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                  F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                  F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                  0000FFFFF7FFF7FFF7FFFFFF0000FFFFF7FFF7FFF7FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnVerticalCenterClick
              end
              object btnVerticalBottom: TSpeedButton
                Left = 197
                Top = 84
                Width = 25
                Height = 25
                Hint = 'Bottom'
                GroupIndex = 7
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7
                  F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                  0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                  F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                  F7F7F7F7F7F7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF
                  0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnVerticalBottomClick
              end
              object pbFontColor: TPaintBox
                Left = 12
                Top = 73
                Width = 18
                Height = 4
                OnPaint = pbFontColorPaint
              end
              object laXLSFont: TcxLabel
                Left = 6
                Top = 8
                Caption = 'Font'
                Transparent = True
              end
              object laXLSFontSize: TcxLabel
                Left = 6
                Top = 34
                Caption = 'Size'
                Transparent = True
              end
              object cbxXLSFont: TComboBox
                Left = 76
                Top = 5
                Width = 150
                Height = 23
                Style = csDropDownList
                TabOrder = 0
                OnChange = cbxXLSFontChange
              end
              object cbxXLSFontSize: TComboBox
                Left = 77
                Top = 30
                Width = 55
                Height = 23
                TabOrder = 1
                OnChange = cbxXLSFontSizeChange
                Items.Strings = (
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
              end
            end
            object tshXLSBorders: TcxTabSheet
              Caption = '&Borders'
              object btnBorderTop: TSpeedButton
                Left = 21
                Top = 8
                Width = 25
                Height = 25
                Hint = 'Top Border'
                AllowAllUp = True
                GroupIndex = 8
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF7F7F7F7F7F7F7FFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7FFFFF7FF
                  FFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7F7F7F7F7F7F7FFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF000000000
                  0000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnBorderTopClick
              end
              object btnBorderBottom: TSpeedButton
                Left = 21
                Top = 33
                Width = 25
                Height = 25
                Hint = 'Bottom Border'
                AllowAllUp = True
                GroupIndex = 9
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF0000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7FFFFF7FF
                  FFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7F7F7F7F7F7F7FFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFF7FFFFF7FFFFF7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7F7F7F7F7
                  F7F7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnBorderBottomClick
              end
              object btnBorderLeft: TSpeedButton
                Left = 21
                Top = 58
                Width = 25
                Height = 25
                Hint = 'Left Border'
                AllowAllUp = True
                GroupIndex = 10
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF0F7F7F7F7F7F7FFFF0000FFF0FFFFFFFFFFFFFFFF
                  0000FFF0FFFFF7FFFFF7FFFF0000FFF0FFFFFFFFFFFFFFFF0000FFF0FFFFF7FF
                  FFF7FFFF0000FFF0FFFFFFFFFFFFFFFF0000FFF0F7F7F7F7F7F7FFFF0000FFF0
                  FFFFFFFFFFFFFFFF0000FFF0FFFFF7FFFFF7FFFF0000FFF0FFFFFFFFFFFFFFFF
                  0000FFF0FFFFF7FFFFF7FFFF0000FFF0FFFFFFFFFFFFFFFF0000FFF0F7F7F7F7
                  F7F7FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnBorderLeftClick
              end
              object btnBorderRight: TSpeedButton
                Left = 21
                Top = 83
                Width = 25
                Height = 25
                Hint = 'Right Border'
                AllowAllUp = True
                GroupIndex = 11
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFF7F7F7F7F7F7F0FFFF0000FFFFFFFFFFFFFFF0FFFF
                  0000FFF7FFFFF7FFFFF0FFFF0000FFFFFFFFFFFFFFF0FFFF0000FFF7FFFFF7FF
                  FFF0FFFF0000FFFFFFFFFFFFFFF0FFFF0000FFF7F7F7F7F7F7F0FFFF0000FFFF
                  FFFFFFFFFFF0FFFF0000FFF7FFFFF7FFFFF0FFFF0000FFFFFFFFFFFFFFF0FFFF
                  0000FFF7FFFFF7FFFFF0FFFF0000FFFFFFFFFFFFFFF0FFFF0000FFF7F7F7F7F7
                  F7F0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = btnBorderRightClick
              end
              object btnBorderTopColor: TSpeedButton
                Left = 216
                Top = 8
                Width = 25
                Height = 25
                Hint = 'Top Border Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                  FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                  FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                  0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                  0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnBorderTopColorClick
                OnMouseDown = btnBorderTopColorMouseDown
                OnMouseUp = btnBorderTopColorMouseUp
              end
              object pbBorderTop: TPaintBox
                Left = 219
                Top = 25
                Width = 18
                Height = 4
                OnPaint = pbBorderTopPaint
              end
              object btnBorderBottomColor: TSpeedButton
                Left = 216
                Top = 33
                Width = 25
                Height = 25
                Hint = 'Bottom Border Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                  FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                  FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                  0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                  0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnBorderBottomColorClick
                OnMouseDown = btnBorderBottomColorMouseDown
                OnMouseUp = btnBorderBottomColorMouseUp
              end
              object pbBorderBottom: TPaintBox
                Left = 219
                Top = 50
                Width = 18
                Height = 4
                OnPaint = pbBorderBottomPaint
              end
              object btnBorderLeftColor: TSpeedButton
                Left = 216
                Top = 58
                Width = 25
                Height = 25
                Hint = 'Left Border Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                  FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                  FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                  0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                  0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnBorderLeftColorClick
                OnMouseDown = btnBorderLeftColorMouseDown
                OnMouseUp = btnBorderLeftColorMouseUp
              end
              object pbBorderLeft: TPaintBox
                Left = 219
                Top = 75
                Width = 18
                Height = 4
                OnPaint = pbBorderLeftPaint
              end
              object btnBorderRightColor: TSpeedButton
                Left = 216
                Top = 83
                Width = 25
                Height = 25
                Hint = 'Right Border Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                  FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                  FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                  0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                  0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnBorderRightColorClick
                OnMouseDown = btnBorderRightColorMouseDown
                OnMouseUp = btnBorderRightColorMouseUp
              end
              object pbBorderRight: TPaintBox
                Left = 219
                Top = 100
                Width = 18
                Height = 4
                OnPaint = pbBorderRightPaint
              end
              object cmbBorderTop: TComboBox
                Left = 56
                Top = 9
                Width = 150
                Height = 22
                Style = csOwnerDrawFixed
                TabOrder = 0
                OnChange = cmbBorderTopChange
                OnDrawItem = cmbBorderTopDrawItem
                Items.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13')
              end
              object cmbBorderBottom: TComboBox
                Left = 56
                Top = 34
                Width = 150
                Height = 22
                Style = csOwnerDrawFixed
                TabOrder = 1
                OnChange = cmbBorderBottomChange
                OnDrawItem = cmbBorderBottomDrawItem
                Items.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13')
              end
              object cmbBorderLeft: TComboBox
                Left = 56
                Top = 59
                Width = 150
                Height = 22
                Style = csOwnerDrawFixed
                TabOrder = 2
                OnChange = cmbBorderLeftChange
                OnDrawItem = cmbBorderLeftDrawItem
                Items.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13')
              end
              object cmbBorderRight: TComboBox
                Left = 56
                Top = 84
                Width = 150
                Height = 22
                Style = csOwnerDrawFixed
                TabOrder = 3
                OnChange = cmbBorderRightChange
                OnDrawItem = cmbBorderRightDrawItem
                Items.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13')
              end
            end
            object tshXLSFill: TcxTabSheet
              Caption = 'F&ill'
              object btnFillBackground: TSpeedButton
                Left = 22
                Top = 45
                Width = 25
                Height = 25
                Hint = 'Background Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                  FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                  F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                  0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                  07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                  FFF7447FFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnFillBackgroundClick
                OnMouseDown = btnFillBackgroundMouseDown
                OnMouseUp = btnFillBackgroundMouseUp
              end
              object pbFillBackground: TPaintBox
                Left = 25
                Top = 62
                Width = 18
                Height = 4
                OnPaint = pbFillBackgroundPaint
              end
              object btnFillForeground: TSpeedButton
                Left = 215
                Top = 45
                Width = 25
                Height = 25
                Hint = 'Foreground Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                  FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                  FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                  0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                  0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = btnFillForegroundClick
                OnMouseDown = btnFillForegroundMouseDown
                OnMouseUp = btnFillForegroundMouseUp
              end
              object pbFillForeground: TPaintBox
                Left = 218
                Top = 62
                Width = 18
                Height = 4
                OnPaint = pbFillForegroundPaint
              end
              object cmbPattern: TComboBox
                Left = 57
                Top = 46
                Width = 150
                Height = 22
                Style = csOwnerDrawFixed
                TabOrder = 0
                OnChange = cmbPatternChange
                OnDrawItem = cmbPatternDrawItem
                Items.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4'
                  '5'
                  '6'
                  '7'
                  '8'
                  '9'
                  '10'
                  '11'
                  '12'
                  '13'
                  '14'
                  '15'
                  '16'
                  '17'
                  '18')
              end
            end
            object tshXLSAggregate: TcxTabSheet
              Caption = '&Aggregate'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object rgXLSFunction: TRadioGroup
                Left = 5
                Top = 26
                Width = 253
                Height = 64
                Caption = 'Function'
                Columns = 3
                TabOrder = 0
                OnClick = rgXLSFunctionClick
              end
            end
          end
          object pcXLSFormats: TcxPageControl
            Left = 0
            Top = 0
            Width = 184
            Height = 321
            TabOrder = 0
            Properties.ActivePage = tshXLSFields
            Properties.CustomButtons.Buttons = <>
            OnChange = pcXLSFormatsChange
            ClientRectBottom = 319
            ClientRectLeft = 2
            ClientRectRight = 182
            ClientRectTop = 24
            object tshXLSFields: TcxTabSheet
              Caption = 'Fields'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object lstXLSFields: TListView
                Left = 0
                Top = 0
                Width = 176
                Height = 291
                Align = alClient
                Columns = <
                  item
                    Width = 170
                  end>
                HideSelection = False
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ShowColumnHeaders = False
                SmallImages = imgFields
                TabOrder = 0
                ViewStyle = vsReport
                OnChange = lstXLSFieldsChange
                OnDeletion = lstXLSFieldsDeletion
              end
            end
            object tshXLSOptions: TcxTabSheet
              Caption = 'Options'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object lstXLSOptions: TListView
                Left = 0
                Top = 0
                Width = 176
                Height = 291
                Align = alClient
                Columns = <
                  item
                    Width = 170
                  end>
                HideSelection = False
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ShowColumnHeaders = False
                SmallImages = imgFields
                TabOrder = 0
                ViewStyle = vsReport
                OnChange = lstXLSFieldsChange
                OnDeletion = lstXLSFieldsDeletion
              end
            end
            object tshXLSStyles: TcxTabSheet
              Caption = 'Styles'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object lstXLSStyles: TListView
                Left = 0
                Top = 24
                Width = 176
                Height = 227
                Align = alClient
                Columns = <
                  item
                    Width = 170
                  end>
                HideSelection = False
                MultiSelect = True
                ReadOnly = True
                RowSelect = True
                ShowColumnHeaders = False
                SmallImages = imgFields
                TabOrder = 1
                ViewStyle = vsReport
                OnChange = lstXLSFieldsChange
                OnDeletion = lstXLSFieldsDeletion
              end
              object rgXLSStripType: TRadioGroup
                Left = 0
                Top = 251
                Width = 176
                Height = 40
                Align = alBottom
                Caption = 'Strip type'
                Columns = 3
                ItemIndex = 0
                Items.Strings = (
                  'None'
                  'Column'
                  'Row')
                TabOrder = 2
                OnClick = rgXLSStripTypeClick
              end
              object tbrXLSStyles: TToolBar
                Left = 0
                Top = 0
                Width = 176
                Height = 24
                AutoSize = True
                ButtonHeight = 24
                ButtonWidth = 25
                Images = ilXLSStyles
                TabOrder = 0
                object tbtAddXLSStyle: TToolButton
                  Left = 0
                  Top = 0
                  Caption = 'tbtAddXLSStyle'
                  ImageIndex = 0
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtAddXLSStyleClick
                end
                object tbtDelXLSStyle: TToolButton
                  Left = 25
                  Top = 0
                  Caption = 'tbtDelXLSStyle'
                  ImageIndex = 1
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtDelXLSStyleClick
                end
                object tbtUpXLSStyle: TToolButton
                  Left = 50
                  Top = 0
                  Caption = 'tbtUpXLSStyle'
                  ImageIndex = 2
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtUpXLSStyleClick
                end
                object tbtDownXLSStyle: TToolButton
                  Left = 75
                  Top = 0
                  Caption = 'tbtDownXLSStyle'
                  ImageIndex = 3
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtDownXLSStyleClick
                end
                object ToolButton1: TToolButton
                  Left = 100
                  Top = 0
                  Width = 8
                  Caption = 'ToolButton1'
                  ImageIndex = 4
                  Style = tbsSeparator
                end
                object tbtLoadXLSStyle: TToolButton
                  Left = 108
                  Top = 0
                  Caption = 'tbtLoadXLSStyle'
                  ImageIndex = 4
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtLoadXLSStyleClick
                end
                object tbtSaveXLSStyle: TToolButton
                  Left = 133
                  Top = 0
                  Caption = 'tbtSaveXLSStyle'
                  ImageIndex = 5
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = tbtSaveXLSStyleClick
                end
              end
            end
          end
          object paXLSSampleCell: TcxGroupBox
            Left = 185
            Top = 145
            Style.BorderStyle = ebsNone
            TabOrder = 2
            Height = 84
            Width = 268
            object pbXLSCell: TPaintBox
              Left = 2
              Top = 43
              Width = 264
              Height = 39
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -20
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              OnPaint = pbXLSCellPaint
              ExplicitLeft = 0
              ExplicitTop = 15
              ExplicitWidth = 268
              ExplicitHeight = 57
            end
            object laXLSSampleCell: TcxLabel
              Left = 2
              Top = 20
              Align = alTop
              AutoSize = False
              Caption = 'Sample Cell'
              ParentColor = False
              ParentFont = False
              Transparent = True
              Height = 23
              Width = 264
            end
          end
        end
        object tshXLSExtensions: TcxTabSheet
          Caption = 'E&xtensions'
          object paXLSExtensionsLeft: TcxGroupBox
            Left = 0
            Top = 0
            TabOrder = 0
            Height = 249
            Width = 183
            object tbXLSExtension: TToolBar
              Left = 2
              Top = 20
              Width = 179
              Height = 26
              AutoSize = True
              ButtonHeight = 24
              ButtonWidth = 25
              EdgeBorders = [ebBottom]
              Images = ilXLSStyles
              TabOrder = 0
              object tbtAddXLSExtension: TToolButton
                Left = 0
                Top = 0
                Caption = 'tbtAddXLSExtension'
                ImageIndex = 0
                ParentShowHint = False
                ShowHint = True
                OnClick = tbtAddXLSExtensionClick
              end
              object tbtDelXLSExtension: TToolButton
                Left = 25
                Top = 0
                Caption = 'tbtDelXLSExtension'
                ImageIndex = 1
                ParentShowHint = False
                ShowHint = True
                OnClick = tbtDelXLSExtensionClick
              end
            end
            object tvXLSExtensions: TTreeView
              Left = 2
              Top = 46
              Width = 179
              Height = 201
              Align = alClient
              BorderStyle = bsNone
              HideSelection = False
              Images = ilXLSStyles
              Indent = 21
              ReadOnly = True
              TabOrder = 1
              OnChange = tvXLSExtensionsChange
            end
          end
          object paXLSExtensionsClient: TcxGroupBox
            Left = 187
            Top = 0
            TabOrder = 1
            Height = 316
            Width = 267
            object pcXLSExtensions: TcxPageControl
              Left = 2
              Top = 20
              Width = 263
              Height = 294
              Align = alClient
              TabOrder = 0
              Properties.ActivePage = tshXLSNotes
              Properties.CustomButtons.Buttons = <>
              Properties.TabHeight = 1
              ClientRectBottom = 292
              ClientRectLeft = 2
              ClientRectRight = 261
              ClientRectTop = 24
              object tshXLSHyperlinks: TcxTabSheet
                Caption = 'Hyperlinks'
                ExplicitLeft = 4
                ExplicitTop = 26
                ExplicitWidth = 255
                ExplicitHeight = 264
                object laXLSHyperlinkRow: TcxLabel
                  Left = 10
                  Top = 41
                  Caption = 'Row'
                  Transparent = True
                end
                object laXLSHyperlinkCol: TcxLabel
                  Left = 10
                  Top = 16
                  Caption = 'Col'
                  Transparent = True
                end
                object laXLSHyperlinkTitle: TcxLabel
                  Left = 10
                  Top = 74
                  Caption = 'Title'
                  Transparent = True
                end
                object laXLSHyperlinkTarget: TcxLabel
                  Left = 10
                  Top = 115
                  Caption = 'Target'
                  Transparent = True
                end
                object laXLSHyperlinkScreenTip: TcxLabel
                  Left = 10
                  Top = 160
                  Caption = 'Screen Tip'
                  Transparent = True
                end
                object edXLSHyperlinkRow: TEdit
                  Left = 52
                  Top = 40
                  Width = 50
                  Height = 23
                  TabOrder = 1
                  OnExit = edXLSHyperlinkRowExit
                end
                object edXLSHyperlinkCol: TEdit
                  Left = 52
                  Top = 15
                  Width = 50
                  Height = 23
                  TabOrder = 0
                  OnExit = edXLSHyperlinkColExit
                end
                object rgXLSHyperlinkStyle: TRadioGroup
                  Left = 109
                  Top = 5
                  Width = 140
                  Height = 62
                  Caption = ' Style '
                  ItemIndex = 0
                  Items.Strings = (
                    'URL'
                    'Local file')
                  TabOrder = 2
                  OnClick = rgXLSHyperlinkStyleClick
                end
                object edXLSHyperlinkTitle: TEdit
                  Left = 10
                  Top = 92
                  Width = 240
                  Height = 23
                  TabOrder = 3
                  OnChange = edXLSHyperlinkTitleChange
                end
                object edXLSHyperlinkTarget: TEdit
                  Left = 10
                  Top = 135
                  Width = 240
                  Height = 23
                  TabOrder = 4
                  OnChange = edXLSHyperlinkTargetChange
                end
                object edXLSHyperlinkScreenTip: TEdit
                  Left = 10
                  Top = 179
                  Width = 240
                  Height = 23
                  TabOrder = 5
                  OnChange = edXLSHyperlinkScreenTipChange
                end
              end
              object tshXLSNotes: TcxTabSheet
                Caption = 'Notes'
                object pcXLSNotes: TcxPageControl
                  Left = 0
                  Top = 0
                  Width = 259
                  Height = 268
                  Align = alClient
                  TabOrder = 0
                  Properties.ActivePage = tshXLSNoteFill
                  Properties.CustomButtons.Buttons = <>
                  ClientRectBottom = 266
                  ClientRectLeft = 2
                  ClientRectRight = 257
                  ClientRectTop = 24
                  object tshXLSNoteBase: TcxTabSheet
                    Caption = 'Base'
                    object laXLSNoteRow: TcxLabel
                      Left = 10
                      Top = 36
                      Caption = 'Row'
                      Transparent = True
                    end
                    object laXLSNoteCol: TcxLabel
                      Left = 10
                      Top = 11
                      Caption = 'Col'
                      Transparent = True
                    end
                    object laXLSNoteLines: TcxLabel
                      Left = 10
                      Top = 58
                      AutoSize = False
                      Caption = 'Text'
                      ParentColor = False
                      ParentFont = False
                      Transparent = True
                      Height = 16
                      Width = 237
                    end
                    object edXLSNoteRow: TEdit
                      Left = 50
                      Top = 32
                      Width = 50
                      Height = 23
                      TabOrder = 1
                      OnExit = edXLSNoteRowExit
                    end
                    object edXLSNoteCol: TEdit
                      Left = 50
                      Top = 7
                      Width = 50
                      Height = 23
                      TabOrder = 0
                      OnExit = edXLSNoteColExit
                    end
                    object mmXLSNoteLines: TMemo
                      Left = 10
                      Top = 74
                      Width = 237
                      Height = 138
                      TabOrder = 2
                      OnChange = mmXLSNoteLinesChange
                    end
                  end
                  object tshXLSNoteFont: TcxTabSheet
                    Caption = 'Font'
                    object btnXLSNoteFontColor: TSpeedButton
                      Left = 24
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Font color'
                      Flat = True
                      Glyph.Data = {
                        C6050000424DC605000000000000360400002800000014000000140000000100
                        0800000000009001000000000000000000000001000000010000000000000000
                        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                        A6000020400000206000002080000020A0000020C0000020E000004000000040
                        20000040400000406000004080000040A0000040C0000040E000006000000060
                        20000060400000606000006080000060A0000060C0000060E000008000000080
                        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                        20004000400040006000400080004000A0004000C0004000E000402000004020
                        20004020400040206000402080004020A0004020C0004020E000404000004040
                        20004040400040406000404080004040A0004040C0004040E000406000004060
                        20004060400040606000406080004060A0004060C0004060E000408000004080
                        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                        20008000400080006000800080008000A0008000C0008000E000802000008020
                        20008020400080206000802080008020A0008020C0008020E000804000008040
                        20008040400080406000804080008040A0008040C0008040E000806000008060
                        20008060400080606000806080008060A0008060C0008060E000808000008080
                        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
                        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
                        FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                        00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
                        FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
                        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                        FFFFFFFFFFFFFFFFFFFF}
                      ParentShowHint = False
                      ShowHint = True
                      Spacing = 0
                      OnClick = btnXLSNoteFontColorClick
                      OnMouseDown = btnXLSNoteFontColorMouseDown
                      OnMouseUp = btnXLSNoteFontColorMouseUp
                    end
                    object pbXLSNoteFontColor: TPaintBox
                      Left = 27
                      Top = 81
                      Width = 18
                      Height = 4
                      OnPaint = pbXLSNoteFontColorPaint
                    end
                    object btnXLSNoteFontBold: TSpeedButton
                      Left = 55
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Bold'
                      AllowAllUp = True
                      GroupIndex = 1
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
                        0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
                        F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
                        0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      Spacing = 0
                      OnClick = btnXLSNoteFontBoldClick
                    end
                    object btnXLSNoteFontItalic: TSpeedButton
                      Left = 80
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Italic'
                      AllowAllUp = True
                      GroupIndex = 2
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
                        FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
                        FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
                        0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteFontItalicClick
                    end
                    object btnXLSNoteFontStrikeOut: TSpeedButton
                      Left = 105
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Strike Out'
                      AllowAllUp = True
                      GroupIndex = 3
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
                        FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
                        F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
                        0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteFontStrikeOutClick
                    end
                    object btnXLSNoteUnderlineSingle: TSpeedButton
                      Left = 136
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Single'
                      AllowAllUp = True
                      GroupIndex = 5
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                        0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                        FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                        0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteUnderlineSingleClick
                    end
                    object btnXLSNoteUnderlineSingleAccounting: TSpeedButton
                      Left = 161
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Single Accounting'
                      AllowAllUp = True
                      GroupIndex = 5
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000FFF000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                        0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                        FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                        0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteUnderlineSingleAccountingClick
                    end
                    object btnXLSNoteUnderlineDouble: TSpeedButton
                      Left = 186
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Double'
                      AllowAllUp = True
                      GroupIndex = 5
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        F000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                        0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                        FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                        0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteUnderlineDoubleClick
                    end
                    object btnXLSNoteUnderlineDoubleAccounting: TSpeedButton
                      Left = 211
                      Top = 63
                      Width = 25
                      Height = 25
                      Hint = 'Double Accounting'
                      AllowAllUp = True
                      GroupIndex = 5
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        F000FFF000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000FFF000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                        0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                        FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                        0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteUnderlineDoubleAccountingClick
                    end
                    object btnXLSNoteHorizontalLeft: TSpeedButton
                      Left = 25
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Left'
                      AllowAllUp = True
                      GroupIndex = 6
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                        000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteHorizontalLeftClick
                    end
                    object btnXLSNoteHorizontalCenter: TSpeedButton
                      Left = 50
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Center'
                      AllowAllUp = True
                      GroupIndex = 6
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                        000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteHorizontalCenterClick
                    end
                    object btnXLSNoteHorizontalRight: TSpeedButton
                      Left = 75
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Right'
                      AllowAllUp = True
                      GroupIndex = 6
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                        000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteHorizontalRightClick
                    end
                    object btnXLSNoteHorizontalFill: TSpeedButton
                      Left = 100
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Fill'
                      AllowAllUp = True
                      GroupIndex = 6
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                        000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteHorizontalFillClick
                    end
                    object btnXLSNoteVerticalTop: TSpeedButton
                      Left = 131
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Top'
                      GroupIndex = 7
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7
                        FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF
                        0000FFF7FFF7FFF7FFF7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                        F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                        F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                        0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteVerticalTopClick
                    end
                    object btnXLSNoteVerticalCenter: TSpeedButton
                      Left = 157
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Center'
                      GroupIndex = 7
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        F7FFF7FFF7FFFFFF0000FFFFF7FFF7FFF7FFFFFF0000FFF7F7F7F7F7F7F7FFFF
                        0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                        F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                        F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                        0000FFFFF7FFF7FFF7FFFFFF0000FFFFF7FFF7FFF7FFFFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteVerticalCenterClick
                    end
                    object btnXLSNoteVerticalBottom: TSpeedButton
                      Left = 182
                      Top = 94
                      Width = 25
                      Height = 25
                      Hint = 'Bottom'
                      GroupIndex = 7
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF7
                        F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF
                        0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7
                        F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7F7F7F7F7F7F7FFFF0000FFF7
                        F7F7F7F7F7F7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF
                        0000FFF7FFF7FFF7FFF7FFFF0000FFF7FFF7FFF7FFF7FFFF0000FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      OnClick = btnXLSNoteVerticalBottomClick
                    end
                    object laXLSNoteFont: TcxLabel
                      Left = 3
                      Top = 8
                      Caption = 'Font'
                      Transparent = True
                    end
                    object laXLSNoteFontSize: TcxLabel
                      Left = 3
                      Top = 34
                      Caption = 'Size'
                      Transparent = True
                    end
                    object cbXLSNoteFont: TComboBox
                      Left = 77
                      Top = 7
                      Width = 150
                      Height = 23
                      Style = csDropDownList
                      TabOrder = 0
                      OnChange = cbXLSNoteFontChange
                    end
                    object cbXLSNoteFontSize: TComboBox
                      Left = 77
                      Top = 33
                      Width = 55
                      Height = 23
                      TabOrder = 1
                      OnExit = cbXLSNoteFontSizeExit
                      Items.Strings = (
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
                    end
                    object rgXLSNoteOrientation: TRadioGroup
                      Left = 8
                      Top = 130
                      Width = 235
                      Height = 112
                      Caption = ' Orientation '
                      ItemIndex = 0
                      Items.Strings = (
                        'No rotation'
                        'Top to bottom'
                        'Counter clock wise'
                        'Clock wise')
                      TabOrder = 2
                      OnClick = rgXLSNoteOrientationClick
                    end
                  end
                  object tshXLSNoteFill: TcxTabSheet
                    Caption = 'Fill'
                    object btnXLSNoteBackgroundColor: TSpeedButton
                      Left = 105
                      Top = 139
                      Width = 25
                      Height = 25
                      Hint = 'Background Color'
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                        FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                        F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                        0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                        07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                        FFF7447FFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      Spacing = 0
                      OnClick = btnXLSNoteBackgroundColorClick
                      OnMouseDown = btnXLSNoteBackgroundColorMouseDown
                      OnMouseUp = btnXLSNoteBackgroundColorMouseUp
                    end
                    object pbXLSNoteBackgroundColor: TPaintBox
                      Left = 108
                      Top = 156
                      Width = 18
                      Height = 4
                      OnPaint = pbXLSNoteBackgroundColorPaint
                    end
                    object btnXLSNoteForegroundColor: TSpeedButton
                      Left = 130
                      Top = 139
                      Width = 25
                      Height = 25
                      Hint = 'Foreground Color'
                      Flat = True
                      Glyph.Data = {
                        66010000424D6601000000000000760000002800000014000000140000000100
                        040000000000F000000000000000000000001000000010000000000000000000
                        8000008000000080800080000000800080008080000080808000C0C0C0000000
                        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                        0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                        FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                        FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                        0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                        0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                        FFFFFFFFFFFFFFFF0000}
                      ParentShowHint = False
                      ShowHint = True
                      Spacing = 0
                      OnClick = btnXLSNoteForegroundColorClick
                      OnMouseDown = btnXLSNoteForegroundColorMouseDown
                      OnMouseUp = btnXLSNoteForegroundColorMouseUp
                    end
                    object pbXLSNoteForegroundColor: TPaintBox
                      Left = 133
                      Top = 156
                      Width = 18
                      Height = 4
                      OnPaint = pbXLSNoteForegroundColorPaint
                    end
                    object laXLSNoteTransparency: TcxLabel
                      Left = 8
                      Top = 168
                      Caption = 'Transparency'
                      Transparent = True
                    end
                    object laXLSNoteTransparencyStart: TcxLabel
                      Left = 8
                      Top = 204
                      Caption = '0%'
                      Transparent = True
                    end
                    object laXLSNoteTransparencyFinish: TcxLabel
                      Left = 209
                      Top = 204
                      Caption = '100%'
                      Transparent = True
                    end
                    object gbXLSNoteFillType: TcxGroupBox
                      Left = 9
                      Top = 5
                      Caption = ' Fill Type '
                      TabOrder = 0
                      Height = 125
                      Width = 243
                      object rbXLSNoteFillSolid: TcxRadioButton
                        Left = 10
                        Top = 17
                        Width = 120
                        Height = 17
                        Caption = 'Solid'
                        Checked = True
                        TabOrder = 0
                        TabStop = True
                        OnClick = rbXLSNoteFillSolidClick
                      end
                      object rbXLSNoteFillGradient: TcxRadioButton
                        Left = 10
                        Top = 37
                        Width = 120
                        Height = 17
                        Caption = 'Gradient'
                        TabOrder = 1
                        OnClick = rbXLSNoteFillGradientClick
                      end
                      object paXLSNoteFillGradient: TcxGroupBox
                        Left = 28
                        Top = 59
                        PanelStyle.Active = True
                        Style.BorderStyle = ebsNone
                        TabOrder = 2
                        Height = 63
                        Width = 205
                        object rbXLSNoteGradientHorizontal: TcxRadioButton
                          Left = 0
                          Top = 0
                          Width = 100
                          Height = 17
                          Caption = 'Horizontal'
                          Checked = True
                          TabOrder = 0
                          TabStop = True
                          OnClick = rbXLSNoteGradientHorizontalClick
                        end
                        object rbXLSNoteGradientVertical: TcxRadioButton
                          Left = 0
                          Top = 23
                          Width = 100
                          Height = 17
                          Caption = 'Vertical'
                          TabOrder = 1
                          OnClick = rbXLSNoteGradientVerticalClick
                        end
                        object rbXLSNoteGradientDiagonalUp: TcxRadioButton
                          Left = 0
                          Top = 45
                          Width = 100
                          Height = 17
                          Caption = 'Diagonal Up'
                          TabOrder = 2
                          OnClick = rbXLSNoteGradientDiagonalUpClick
                        end
                        object rbXLSNoteGradientDiagonalDown: TcxRadioButton
                          Left = 100
                          Top = 0
                          Width = 100
                          Height = 17
                          Caption = 'Diagonal Down'
                          TabOrder = 3
                          OnClick = rbXLSNoteGradientDiagonalDownClick
                        end
                        object rbXLSNoteGradientFromCorner: TcxRadioButton
                          Left = 100
                          Top = 23
                          Width = 100
                          Height = 17
                          Caption = 'From Corner'
                          TabOrder = 4
                          OnClick = rbXLSNoteGradientFromCornerClick
                        end
                        object rbXLSNoteGradientFromCenter: TcxRadioButton
                          Left = 100
                          Top = 45
                          Width = 100
                          Height = 17
                          Caption = 'From Center'
                          TabOrder = 5
                          OnClick = rbXLSNoteGradientFromCenterClick
                        end
                      end
                    end
                    object trXLSNoteTransparency: TTrackBar
                      Left = 3
                      Top = 187
                      Width = 244
                      Height = 17
                      Max = 100
                      TabOrder = 1
                      TickStyle = tsNone
                      OnChange = trXLSNoteTransparencyChange
                    end
                  end
                end
              end
              object tshXLSCharts: TcxTabSheet
                Caption = 'Charts'
                object pcXLSCharts: TcxPageControl
                  Left = 0
                  Top = 0
                  Width = 259
                  Height = 268
                  Align = alClient
                  TabOrder = 0
                  Properties.ActivePage = tshXLSChartBase
                  Properties.CustomButtons.Buttons = <>
                  ClientRectBottom = 266
                  ClientRectLeft = 2
                  ClientRectRight = 257
                  ClientRectTop = 24
                  object tshXLSChartBase: TcxTabSheet
                    Caption = 'Base'
                    object laXLSChartTitle: TcxLabel
                      Left = 10
                      Top = 8
                      Caption = 'Title'
                      Transparent = True
                    end
                    object laXLSChartStyle: TcxLabel
                      Left = 10
                      Top = 36
                      Caption = 'Style'
                      Transparent = True
                    end
                    object edXLSChartTitle: TEdit
                      Left = 57
                      Top = 7
                      Width = 184
                      Height = 23
                      TabOrder = 0
                      OnChange = edXLSChartTitleChange
                    end
                    object cbXLSChartStyle: TComboBox
                      Left = 58
                      Top = 33
                      Width = 184
                      Height = 23
                      Style = csDropDownList
                      TabOrder = 1
                      OnChange = cbXLSChartStyleChange
                      Items.Strings = (
                        'Column'
                        'Column 3D'
                        'Bar'
                        'Bar 3D'
                        'Line'
                        'Line Mark'
                        'Line 3D'
                        'Pie'
                        'Pie 3D'
                        'Area'
                        'Area 3D'
                        'Surface'
                        'Surface 3D'
                        'Radar'
                        'Radar Area')
                    end
                    object rgXLSChartLegendPosition: TRadioGroup
                      Left = 10
                      Top = 64
                      Width = 232
                      Height = 95
                      Caption = ' Legend Position '
                      Columns = 2
                      ItemIndex = 0
                      Items.Strings = (
                        'Bottom'
                        'Corner'
                        'Top'
                        'Right'
                        'Left')
                      TabOrder = 2
                      OnClick = rgXLSChartLegendPositionClick
                    end
                    object chXLSChartShowLegend: TcxCheckBox
                      Left = 10
                      Top = 168
                      Caption = 'Show Legend'
                      TabOrder = 3
                      OnClick = chXLSChartShowLegendClick
                    end
                    object chXLSChartAutoColor: TcxCheckBox
                      Left = 10
                      Top = 191
                      Caption = 'Auto Color'
                      TabOrder = 4
                      OnClick = chXLSChartAutoColorClick
                    end
                  end
                  object tshXLSChartPosition: TcxTabSheet
                    Caption = 'Position'
                    object gbXLSChartCustomPosition: TcxGroupBox
                      Left = 27
                      Top = 160
                      TabOrder = 0
                      Height = 76
                      Width = 216
                      object laXLSChartPositionX1: TcxLabel
                        Left = 11
                        Top = 18
                        Caption = 'X1'
                        Transparent = True
                      end
                      object laXLSChartPositionX2: TcxLabel
                        Left = 109
                        Top = 18
                        Caption = 'X2'
                        Transparent = True
                      end
                      object laXLSChartPositionY1: TcxLabel
                        Left = 11
                        Top = 43
                        Caption = 'Y1'
                        Transparent = True
                      end
                      object laXLSChartPositionY2: TcxLabel
                        Left = 109
                        Top = 43
                        Caption = 'Y2'
                        Transparent = True
                      end
                      object edXLSChartPositionX1: TEdit
                        Left = 39
                        Top = 14
                        Width = 50
                        Height = 23
                        TabOrder = 0
                        OnExit = edXLSChartPositionX1Exit
                      end
                      object edXLSChartPositionX2: TEdit
                        Left = 155
                        Top = 14
                        Width = 50
                        Height = 23
                        TabOrder = 2
                        OnExit = edXLSChartPositionX2Exit
                      end
                      object edXLSChartPositionY1: TEdit
                        Left = 39
                        Top = 39
                        Width = 50
                        Height = 23
                        TabOrder = 1
                        OnExit = edXLSChartPositionY1Exit
                      end
                      object edXLSChartPositionY2: TEdit
                        Left = 155
                        Top = 39
                        Width = 50
                        Height = 23
                        TabOrder = 3
                        OnExit = edXLSChartPositionY2Exit
                      end
                    end
                    object rbXLSChartAutoPosition: TcxRadioButton
                      Left = 10
                      Top = 4
                      Width = 113
                      Height = 17
                      Caption = 'Auto Position'
                      Checked = True
                      TabOrder = 1
                      TabStop = True
                      OnClick = rbXLSChartAutoPositionClick
                    end
                    object rgXLSChartPlacement: TRadioGroup
                      Left = 27
                      Top = 20
                      Width = 216
                      Height = 45
                      Caption = ' Placement '
                      Columns = 2
                      ItemIndex = 0
                      Items.Strings = (
                        'Bottom'
                        'Right')
                      TabOrder = 2
                      OnClick = rgXLSChartPlacementClick
                    end
                    object gbXLSChartAutoPosition: TcxGroupBox
                      Left = 27
                      Top = 62
                      TabOrder = 3
                      Height = 73
                      Width = 216
                      object laXLSChartLeft: TcxLabel
                        Left = 10
                        Top = 18
                        Caption = 'Left'
                        Transparent = True
                      end
                      object laXLSChartHeight: TcxLabel
                        Left = 109
                        Top = 18
                        Caption = 'Height'
                        Transparent = True
                      end
                      object laXLSChartTop: TcxLabel
                        Left = 10
                        Top = 43
                        Caption = 'Top'
                        Transparent = True
                      end
                      object laXLSChartWidth: TcxLabel
                        Left = 109
                        Top = 43
                        Caption = 'Width'
                        Transparent = True
                      end
                      object edXLSChartLeft: TEdit
                        Left = 39
                        Top = 14
                        Width = 50
                        Height = 23
                        TabOrder = 0
                        OnExit = edXLSChartLeftExit
                      end
                      object edXLSChartHeight: TEdit
                        Left = 155
                        Top = 14
                        Width = 50
                        Height = 23
                        TabOrder = 2
                        OnExit = edXLSChartHeightExit
                      end
                      object edXLSChartTop: TEdit
                        Left = 39
                        Top = 39
                        Width = 50
                        Height = 23
                        TabOrder = 1
                        OnExit = edXLSChartTopExit
                      end
                      object edXLSChartWidth: TEdit
                        Left = 155
                        Top = 39
                        Width = 50
                        Height = 23
                        TabOrder = 3
                        OnExit = edXLSChartWidthExit
                      end
                    end
                    object rbXLSChartCustomPosition: TcxRadioButton
                      Left = 10
                      Top = 143
                      Width = 113
                      Height = 17
                      Caption = 'Custom Position'
                      TabOrder = 4
                      OnClick = rbXLSChartCustomPositionClick
                    end
                  end
                  object tshXLSChartCategoryLabels: TcxTabSheet
                    Caption = 'Category Labels'
                    object laXLSChartCategoryLabelsCol1: TcxLabel
                      Left = 31
                      Top = 86
                      Caption = 'Col 1'
                      Transparent = True
                    end
                    object laXLSChartCategoryLabelsRow1: TcxLabel
                      Left = 31
                      Top = 111
                      Caption = 'Row 1'
                      Transparent = True
                    end
                    object laXLSChartCategoryLabelsCol2: TcxLabel
                      Left = 136
                      Top = 84
                      Caption = 'Col 2'
                      Transparent = True
                    end
                    object laXLSChartCategoryLabelsRow2: TcxLabel
                      Left = 136
                      Top = 109
                      Caption = 'Row 2'
                      Transparent = True
                    end
                    object rbXLSChartCategoryLabelColumn: TcxRadioButton
                      Left = 16
                      Top = 8
                      Width = 113
                      Height = 17
                      Caption = 'Column'
                      Checked = True
                      TabOrder = 0
                      TabStop = True
                      OnClick = rbXLSChartCategoryLabelColumnClick
                    end
                    object rbXLSChartCategoryLabelCustom: TcxRadioButton
                      Left = 16
                      Top = 64
                      Width = 113
                      Height = 17
                      Caption = 'Custom'
                      TabOrder = 1
                      OnClick = rbXLSChartCategoryLabelCustomClick
                    end
                    object edXLSChartCategoryLabelsCol1: TEdit
                      Left = 77
                      Top = 82
                      Width = 50
                      Height = 23
                      TabOrder = 2
                      OnExit = edXLSChartCategoryLabelsCol1Exit
                    end
                    object edXLSChartCategoryLabelsRow1: TEdit
                      Left = 77
                      Top = 107
                      Width = 50
                      Height = 23
                      TabOrder = 3
                      OnExit = edXLSChartCategoryLabelsRow1Exit
                    end
                    object edXLSChartCategoryLabelsCol2: TEdit
                      Left = 187
                      Top = 82
                      Width = 50
                      Height = 23
                      TabOrder = 4
                      OnExit = edXLSChartCategoryLabelsCol2Exit
                    end
                    object edXLSChartCategoryLabelsRow2: TEdit
                      Left = 187
                      Top = 107
                      Width = 50
                      Height = 23
                      TabOrder = 5
                      OnExit = edXLSChartCategoryLabelsRow2Exit
                    end
                    object cbXLSChartCategoryLabelColumn: TComboBox
                      Left = 36
                      Top = 27
                      Width = 201
                      Height = 23
                      Style = csDropDownList
                      Sorted = True
                      TabOrder = 6
                      OnChange = cbXLSChartCategoryLabelColumnChange
                    end
                  end
                end
              end
              object tshXLSSeries: TcxTabSheet
                Caption = 'Series'
                object btnXLSSeriesColor: TSpeedButton
                  Left = 11
                  Top = 182
                  Width = 25
                  Height = 25
                  Hint = 'Color'
                  Flat = True
                  Glyph.Data = {
                    66010000424D6601000000000000760000002800000014000000140000000100
                    040000000000F000000000000000000000001000000010000000000000000000
                    8000008000000080800080000000800080008080000080808000C0C0C0000000
                    FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                    FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                    FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                    0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
                    FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
                    FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
                    0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
                    0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
                    FFFFFFFFFFFFFFFF0000}
                  ParentShowHint = False
                  ShowHint = True
                  Spacing = 0
                  OnClick = btnXLSSeriesColorClick
                  OnMouseDown = btnXLSSeriesColorMouseDown
                  OnMouseUp = btnXLSSeriesColorMouseUp
                end
                object pbXLSSeriesColor: TPaintBox
                  Left = 14
                  Top = 189
                  Width = 18
                  Height = 4
                  OnPaint = pbXLSSeriesColorPaint
                end
                object laXLSSeriesTitle: TcxLabel
                  Left = 11
                  Top = 10
                  Caption = 'Title'
                  Transparent = True
                end
                object edXLSSeriesTitle: TEdit
                  Left = 57
                  Top = 7
                  Width = 190
                  Height = 23
                  TabOrder = 0
                  OnChange = edXLSSeriesTitleChange
                end
                object gbXLSSeriesDataRange: TcxGroupBox
                  Left = 3
                  Top = 35
                  Caption = ' Data Range '
                  TabOrder = 1
                  Height = 143
                  Width = 245
                  object laXLSSeriesDataRangeCol1: TcxLabel
                    Left = 24
                    Top = 86
                    Caption = 'Col 1'
                    Transparent = True
                  end
                  object laXLSSeriesDataRangeRow1: TcxLabel
                    Left = 24
                    Top = 110
                    Caption = 'Row 1'
                    Transparent = True
                  end
                  object laXLSSeriesDataRangeCol2: TcxLabel
                    Left = 136
                    Top = 86
                    Caption = 'Col 2'
                    Transparent = True
                  end
                  object laXLSSeriesDataRangeRow2: TcxLabel
                    Left = 136
                    Top = 110
                    Caption = 'Row 2'
                    Transparent = True
                  end
                  object edXLSSeriesDataRangeCol1: TEdit
                    Left = 69
                    Top = 82
                    Width = 50
                    Height = 23
                    TabOrder = 0
                    OnExit = edXLSSeriesDataRangeCol1Exit
                  end
                  object edXLSSeriesDataRangeRow1: TEdit
                    Left = 69
                    Top = 106
                    Width = 50
                    Height = 23
                    TabOrder = 1
                    OnExit = edXLSSeriesDataRangeRow1Exit
                  end
                  object edXLSSeriesDataRangeCol2: TEdit
                    Left = 186
                    Top = 82
                    Width = 50
                    Height = 23
                    TabOrder = 2
                    OnExit = edXLSSeriesDataRangeCol2Exit
                  end
                  object edXLSSeriesDataRangeRow2: TEdit
                    Left = 186
                    Top = 106
                    Width = 50
                    Height = 23
                    TabOrder = 3
                    OnExit = edXLSSeriesDataRangeRow2Exit
                  end
                  object rbXLSSeriesColumn: TcxRadioButton
                    Left = 9
                    Top = 18
                    Width = 113
                    Height = 17
                    Caption = 'Column'
                    Checked = True
                    TabOrder = 4
                    TabStop = True
                    OnClick = rbXLSSeriesColumnClick
                  end
                  object cbXLSSeriesColumn: TComboBox
                    Left = 26
                    Top = 36
                    Width = 210
                    Height = 23
                    Style = csDropDownList
                    Sorted = True
                    TabOrder = 5
                    OnChange = cbXLSSeriesColumnChange
                  end
                  object rbXLSSeriesCustom: TcxRadioButton
                    Left = 9
                    Top = 65
                    Width = 113
                    Height = 17
                    Caption = 'Custom'
                    TabOrder = 6
                    OnClick = rbXLSSeriesCustomClick
                  end
                end
              end
              object tshXLSCells: TcxTabSheet
                Caption = 'Cells'
                object pcXLSCells: TcxPageControl
                  Left = 0
                  Top = 0
                  Width = 259
                  Height = 268
                  Align = alClient
                  TabOrder = 0
                  Properties.ActivePage = tshXLSCellBase
                  Properties.CustomButtons.Buttons = <>
                  OnChange = pcXLSCellsChange
                  ClientRectBottom = 266
                  ClientRectLeft = 2
                  ClientRectRight = 257
                  ClientRectTop = 24
                  object tshXLSCellBase: TcxTabSheet
                    Caption = 'Base'
                    object laXLSCellCol: TcxLabel
                      Left = 4
                      Top = 8
                      Caption = 'Col'
                      Transparent = True
                    end
                    object laXLSCellRow: TcxLabel
                      Left = 143
                      Top = 8
                      Caption = 'Row'
                      Transparent = True
                    end
                    object laXLSCellType: TcxLabel
                      Left = 4
                      Top = 40
                      Caption = 'Cell Type'
                      Transparent = True
                    end
                    object laXLSCellDateTimeFormat: TcxLabel
                      Left = 4
                      Top = 112
                      Caption = 'Date Time Format'
                      Transparent = True
                    end
                    object laXLSCellNumericFormat: TcxLabel
                      Left = 4
                      Top = 158
                      Caption = 'Numeric Format'
                      Transparent = True
                    end
                    object laXLSCellValue: TcxLabel
                      Left = 4
                      Top = 66
                      Caption = 'Value'
                      Transparent = True
                    end
                    object edXLSCellCol: TEdit
                      Left = 62
                      Top = 7
                      Width = 50
                      Height = 23
                      TabOrder = 0
                      OnExit = edXLSCellColExit
                      OnKeyDown = edXLSCellColKeyDown
                    end
                    object edXLSCellRow: TEdit
                      Left = 192
                      Top = 7
                      Width = 50
                      Height = 23
                      TabOrder = 1
                      OnExit = edXLSCellRowExit
                      OnKeyDown = edXLSCellRowKeyDown
                    end
                    object cbXLSCellType: TComboBox
                      Left = 62
                      Top = 36
                      Width = 180
                      Height = 23
                      Style = csDropDownList
                      TabOrder = 2
                      OnChange = cbXLSCellTypeChange
                      Items.Strings = (
                        'Boolean'
                        'DateTime'
                        'Numeric'
                        'String')
                    end
                    object edXLSCellDateTimeFormat: TEdit
                      Left = 4
                      Top = 132
                      Width = 237
                      Height = 23
                      TabOrder = 4
                      OnChange = edXLSCellDateTimeFormatChange
                    end
                    object edXLSCellNumericFormat: TEdit
                      Left = 4
                      Top = 177
                      Width = 237
                      Height = 23
                      TabOrder = 5
                      OnChange = edXLSCellNumericFormatChange
                    end
                    object edXLSCellValue: TEdit
                      Left = 62
                      Top = 65
                      Width = 180
                      Height = 23
                      TabOrder = 3
                      OnChange = edXLSCellValueChange
                    end
                  end
                end
              end
              object tshXLSMergedCells: TcxTabSheet
                Caption = 'Merged Cells'
                ExplicitLeft = 4
                ExplicitTop = 26
                ExplicitWidth = 255
                ExplicitHeight = 264
                object laXLSMergedCellsFirstCol: TcxLabel
                  Left = 8
                  Top = 20
                  Caption = 'First Col'
                  Transparent = True
                end
                object laXLSMergedCellsFirstRow: TcxLabel
                  Left = 126
                  Top = 20
                  Caption = 'First Row'
                  Transparent = True
                end
                object laXLSMergedCellsLastCol: TcxLabel
                  Left = 8
                  Top = 45
                  Caption = 'Last Col'
                  Transparent = True
                end
                object laXLSMergedCellsLastRow: TcxLabel
                  Left = 126
                  Top = 45
                  Caption = 'Last Row'
                  Transparent = True
                end
                object edXLSMergedCellsFirstCol: TEdit
                  Left = 71
                  Top = 19
                  Width = 50
                  Height = 23
                  TabOrder = 0
                  OnExit = edXLSMergedCellsFirstColExit
                end
                object edXLSMergedCellsFirstRow: TEdit
                  Left = 188
                  Top = 19
                  Width = 50
                  Height = 23
                  TabOrder = 1
                  OnExit = edXLSMergedCellsFirstRowExit
                end
                object edXLSMergedCellsLastCol: TEdit
                  Left = 71
                  Top = 44
                  Width = 50
                  Height = 23
                  TabOrder = 2
                  OnExit = edXLSMergedCellsLastColExit
                end
                object edXLSMergedCellsLastRow: TEdit
                  Left = 188
                  Top = 44
                  Width = 50
                  Height = 23
                  TabOrder = 3
                  OnExit = edXLSMergedCellsLastRowExit
                end
              end
            end
          end
        end
        object tshXLSAdvanced: TcxTabSheet
          Caption = '&Advanced'
          ExplicitLeft = 4
          ExplicitTop = 26
          ExplicitWidth = 459
          ExplicitHeight = 316
          object bXLSPageBackground: TSpeedButton
            Left = 378
            Top = 85
            Width = 22
            Height = 22
            Caption = ' ...'
            Margin = 0
            OnClick = bXLSPageBackgroundClick
          end
          object laXLSPageHeader: TcxLabel
            Left = 8
            Top = 15
            Caption = 'Page header'
            Transparent = True
          end
          object laXLSPageFooter: TcxLabel
            Left = 8
            Top = 39
            Caption = 'Page footer'
            Transparent = True
          end
          object laXLSSheetTitle: TcxLabel
            Left = 8
            Top = 63
            Caption = 'Sheet title'
            Transparent = True
          end
          object laXLSPageBackground: TcxLabel
            Left = 8
            Top = 87
            Caption = 'Background'
            Transparent = True
          end
          object laXLSDefRowHeight: TcxLabel
            Left = 8
            Top = 111
            Caption = 'Row Height'
            Transparent = True
          end
          object edXLSPageHeader: TEdit
            Left = 91
            Top = 12
            Width = 305
            Height = 23
            TabOrder = 0
            OnChange = edXLSPageHeaderChange
          end
          object edXLSPageFooter: TEdit
            Left = 91
            Top = 36
            Width = 305
            Height = 23
            TabOrder = 1
            OnChange = edXLSPageFooterChange
          end
          object edXLSSheetTitle: TEdit
            Left = 91
            Top = 60
            Width = 305
            Height = 23
            TabOrder = 2
            OnChange = edXLSSheetTitleChange
          end
          object chXLSAutoCalcColWidth: TcxCheckBox
            Left = 91
            Top = 133
            Caption = 'Auto Calculate Column Width'
            TabOrder = 5
            OnClick = chXLSAutoCalcColWidthClick
          end
          object edXLSPageBackground: TEdit
            Left = 91
            Top = 84
            Width = 287
            Height = 23
            TabOrder = 3
            OnChange = edXLSPageBackgroundChange
          end
          object chXLSAutoAddSheet: TcxCheckBox
            Left = 91
            Top = 156
            Caption = 'Auto Add New Sheet'
            State = cbsChecked
            TabOrder = 6
            OnClick = chXLSAutoAddSheetClick
          end
          object chXLSAutoTruncateValue: TcxCheckBox
            Left = 91
            Top = 179
            Caption = 'Auto truncate value'
            TabOrder = 7
            OnClick = chXLSAutoTruncateValueClick
          end
          object edXLSDefRowHeight: TEdit
            Left = 91
            Top = 108
            Width = 54
            Height = 23
            TabOrder = 4
            OnChange = edXLSDefRowHeightChange
            OnExit = edXLSDefRowHeightExit
          end
        end
      end
    end
    object tshASCII: TcxTabSheet
      Caption = 'ASCII Options'
      object gbTXTOptions: TcxGroupBox
        Left = 7
        Top = 8
        Caption = ' TXT Options '
        TabOrder = 0
        Height = 81
        Width = 449
        object laTXTSpacing: TcxLabel
          Left = 226
          Top = 24
          AutoSize = False
          Caption = 'Spacing'
          Transparent = True
          Height = 22
          Width = 87
        end
        object laTXTEncoding: TcxLabel
          Left = 226
          Top = 49
          AutoSize = False
          Caption = 'Encoding'
          Transparent = True
          Height = 22
          Width = 87
        end
        object chTXTAutoCalcColWidth: TcxCheckBox
          Left = 13
          Top = 25
          Caption = 'Calculate column width'
          State = cbsChecked
          TabOrder = 1
          OnClick = chTXTAutoCalcColWidthClick
        end
        object edTXTSpacing: TEdit
          Left = 318
          Top = 23
          Width = 36
          Height = 23
          TabOrder = 0
          Text = '1'
          OnChange = edTXTSpacingChange
        end
        object cbTXTEncoding: TComboBox
          Left = 318
          Top = 48
          Width = 71
          Height = 23
          Style = csDropDownList
          TabOrder = 2
          OnChange = cbTXTEncodingChange
          Items.Strings = (
            'ANSI'
            'OEM'
            'MAC'
            'UTF-8'
            'UTF-16'
            'UTF-32')
        end
      end
      object gbCSVOptions: TcxGroupBox
        Left = 8
        Top = 97
        Caption = ' CSV Options '
        TabOrder = 1
        Height = 78
        Width = 449
        object laCSVComma: TcxLabel
          Left = 225
          Top = 27
          AutoSize = False
          Caption = 'Comma'
          Transparent = True
          Height = 19
          Width = 85
        end
        object laCSVQuote: TcxLabel
          Left = 37
          Top = 48
          AutoSize = False
          Caption = 'Quote'
          Transparent = True
          Height = 19
          Width = 48
        end
        object chCSVQuoteStrings: TcxCheckBox
          Left = 13
          Top = 25
          Caption = 'Quote strings'
          State = cbsChecked
          TabOrder = 1
          OnClick = chCSVQuoteStringsClick
        end
        object edCSVComma: TEdit
          Left = 316
          Top = 23
          Width = 36
          Height = 23
          TabOrder = 0
          Text = ','
          OnExit = edCSVCommaExit
        end
        object edCSVQuote: TEdit
          Left = 119
          Top = 47
          Width = 36
          Height = 23
          TabOrder = 2
          OnExit = edCSVQuoteExit
        end
      end
    end
    object tshPDF: TcxTabSheet
      Caption = 'PDF Options'
      object lvPDFFonts: TListView
        Left = 3
        Top = 3
        Width = 188
        Height = 110
        Columns = <
          item
            Width = 184
          end>
        HideSelection = False
        ReadOnly = True
        ShowColumnHeaders = False
        SmallImages = imgFields
        TabOrder = 1
        ViewStyle = vsReport
        OnChange = lvPDFFontsChange
      end
      object pcPDFOptions: TcxPageControl
        Left = 3
        Top = 149
        Width = 462
        Height = 193
        TabOrder = 3
        Properties.ActivePage = tshPDFGridOptions
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 191
        ClientRectLeft = 2
        ClientRectRight = 460
        ClientRectTop = 24
        object tshPDFGridOptions: TcxTabSheet
          Caption = 'Grid Options'
          ExplicitLeft = 4
          ExplicitTop = 26
          ExplicitWidth = 454
          ExplicitHeight = 163
          object laPDFColSpacing: TcxLabel
            Left = 4
            Top = 16
            Caption = 'Col Spacing'
            Transparent = True
          end
          object laPDFRowSpacing: TcxLabel
            Left = 4
            Top = 41
            Caption = 'Row Spacing'
            Transparent = True
          end
          object laPDFGridLineWidth: TcxLabel
            Left = 4
            Top = 67
            Caption = 'Grid Line Width'
            Transparent = True
          end
          object edPDFColSpacing: TEdit
            Left = 103
            Top = 12
            Width = 50
            Height = 23
            TabOrder = 0
            OnChange = edPDFColSpacingChange
            OnKeyPress = NumberKeyPress
          end
          object edPDFRowSpacing: TEdit
            Left = 103
            Top = 37
            Width = 50
            Height = 23
            TabOrder = 1
            OnChange = edPDFRowSpacingChange
            OnKeyPress = NumberKeyPress
          end
          object edPDFGridLineWidth: TEdit
            Left = 103
            Top = 63
            Width = 50
            Height = 23
            TabOrder = 2
            OnChange = edPDFGridLineWidthChange
            OnKeyPress = NumberKeyPress
          end
        end
        object tshPDFPageOptions: TcxTabSheet
          Caption = 'Page Options'
          object laPDFPageFormat: TcxLabel
            Left = 8
            Top = 5
            Caption = 'Page Size'
            Transparent = True
          end
          object laPDFPageWidth: TcxLabel
            Left = 8
            Top = 55
            Caption = 'Width'
            Transparent = True
          end
          object laPDFPageHeight: TcxLabel
            Left = 8
            Top = 80
            Caption = 'Height'
            Transparent = True
          end
          object laPDFPageUnits: TcxLabel
            Left = 189
            Top = 5
            Caption = 'Units'
            Transparent = True
          end
          object laPDFPageOrientation: TcxLabel
            Left = 189
            Top = 57
            Caption = 'Orientation'
            Transparent = True
          end
          object cbPDFPageFormat: TComboBox
            Left = 8
            Top = 25
            Width = 168
            Height = 23
            Style = csDropDownList
            TabOrder = 1
            OnChange = cbPDFPageFormatChange
            Items.Strings = (
              'Letter'
              'Legal'
              'A3'
              'A4'
              'A5'
              'B5(JIS)'
              'US Std Fanfold'
              'Fanfold'
              'User')
          end
          object edPDFPageWidth: TEdit
            Left = 116
            Top = 51
            Width = 60
            Height = 23
            TabOrder = 3
            OnExit = edPDFPageWidthExit
          end
          object edPDFPageHeight: TEdit
            Left = 116
            Top = 76
            Width = 60
            Height = 23
            TabOrder = 4
            OnExit = edPDFPageHeightExit
          end
          object cbPDFPageUnits: TComboBox
            Left = 189
            Top = 25
            Width = 120
            Height = 23
            Style = csDropDownList
            TabOrder = 2
            OnChange = cbPDFPageUnitsChange
            Items.Strings = (
              'Inches'
              'Millimeters'
              'Dots')
          end
          object cbPDFPageOrientation: TComboBox
            Left = 189
            Top = 76
            Width = 120
            Height = 23
            Style = csDropDownList
            TabOrder = 5
            OnChange = cbPDFPageOrientationChange
            Items.Strings = (
              'Portrait'
              'Landscape')
          end
          object gbPDFMargins: TcxGroupBox
            Left = 320
            Top = 1
            Caption = 'Margins'
            TabOrder = 0
            Height = 130
            Width = 122
            object laPDFPageMarginLeft: TcxLabel
              Left = 10
              Top = 24
              Caption = 'Left'
              Transparent = True
            end
            object laPDFPageMarginRight: TcxLabel
              Left = 10
              Top = 48
              Caption = 'Right'
              Transparent = True
            end
            object laPDFPageMarginTop: TcxLabel
              Left = 10
              Top = 73
              Caption = 'Top'
              Transparent = True
            end
            object laPDFPageMarginBottom: TcxLabel
              Left = 10
              Top = 98
              Caption = 'Bottom'
              Transparent = True
            end
            object edPDFPageMarginLeft: TEdit
              Left = 65
              Top = 20
              Width = 50
              Height = 23
              TabOrder = 0
              OnExit = edPDFPageMarginLeftExit
            end
            object edPDFPageMarginRight: TEdit
              Left = 65
              Top = 44
              Width = 50
              Height = 23
              TabOrder = 1
              OnExit = edPDFPageMarginRightExit
            end
            object edPDFPageMarginTop: TEdit
              Left = 65
              Top = 69
              Width = 50
              Height = 23
              TabOrder = 2
              OnExit = edPDFPageMarginTopExit
            end
            object edPDFPageMarginBottom: TEdit
              Left = 65
              Top = 94
              Width = 50
              Height = 23
              TabOrder = 3
              OnExit = edPDFPageMarginBottomExit
            end
          end
        end
      end
      object pcPDFFonts: TcxPageControl
        Left = 196
        Top = 3
        Width = 269
        Height = 145
        TabOrder = 0
        Properties.ActivePage = tsBaseFonts
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 143
        ClientRectLeft = 2
        ClientRectRight = 267
        ClientRectTop = 2
        object tsBaseFonts: TcxTabSheet
          Caption = 'tsBaseFonts'
          TabVisible = False
          object bPDFBaseFontColor: TSpeedButton
            Left = 157
            Top = 54
            Width = 25
            Height = 25
            Hint = 'Font Color'
            Flat = True
            Glyph.Data = {
              76060000424D760A000000000000360400002800000014000000140000000100
              2000000000004006000000000000000000000001000000000000000000000000
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
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bPDFBaseFontColorClick
            OnMouseDown = bPDFBaseFontColorMouseDown
            OnMouseUp = bPDFBaseFontColorMouseUp
          end
          object pbPDFBaseFontColor: TPaintBox
            Left = 159
            Top = 72
            Width = 18
            Height = 4
            OnPaint = pbPDFBaseFontColorPaint
          end
          object laPDFFontName: TcxLabel
            Left = 5
            Top = 7
            Caption = 'Font Name'
            Transparent = True
          end
          object laPDFFontEncoding: TcxLabel
            Left = 4
            Top = 32
            Caption = 'Font Encoding'
            Transparent = True
          end
          object laPDFFontSize: TcxLabel
            Left = 4
            Top = 57
            Caption = 'Font Size'
            Transparent = True
          end
          object cbPDFFontName: TComboBox
            Left = 112
            Top = 3
            Width = 145
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cbPDFFontNameChange
            Items.Strings = (
              'Helvetica'
              'Helvetica Bold'
              'Helvetica Oblique'
              'Helvetica Bold Oblique'
              'Courier'
              'Courier Bold'
              'Courier Oblique'
              'Courier Bold Oblique'
              'Times Roman'
              'Times Bold'
              'Times Italic,'
              'Times Bold Italic'
              'Symbol'
              'Zapf Dingbats')
          end
          object cbPDFFontEncoding: TComboBox
            Left = 112
            Top = 28
            Width = 145
            Height = 23
            Style = csDropDownList
            TabOrder = 1
            OnChange = cbPDFFontEncodingChange
            Items.Strings = (
              'StandardEncoding'
              'WinAnsiEncoding'
              'MacRomanEncoding'
              'PDFDocEncoding')
          end
          object edPDFFontSize: TEdit
            Left = 112
            Top = 53
            Width = 42
            Height = 23
            TabOrder = 2
            OnChange = edPDFFontSizeChange
            OnKeyPress = NumberKeyPress
          end
          object paPDFSample: TcxGroupBox
            Left = 0
            Top = 84
            Caption = 'Sample'
            TabOrder = 3
            OnClick = sbPDFFontColorClick
            Height = 50
            Width = 261
          end
        end
        object tsUserFonts: TcxTabSheet
          Caption = 'tsUserFonts'
          ImageIndex = 1
          TabVisible = False
          object bPDFUserFontColor: TSpeedButton
            Left = 173
            Top = 28
            Width = 25
            Height = 25
            Hint = 'Font Color'
            Flat = True
            Glyph.Data = {
              76060000424D760A000000000000360400002800000014000000140000000100
              2000000000004006000000000000000000000001000000000000000000000000
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
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bPDFUserFontColorClick
            OnMouseDown = bPDFUserFontColorMouseDown
            OnMouseUp = bPDFUserFontColorMouseUp
          end
          object pbPDFUserFontColor: TPaintBox
            Left = 176
            Top = 46
            Width = 18
            Height = 4
            OnPaint = pbPDFUserFontColorPaint
          end
          object bPDFUserFontBold: TSpeedButton
            Left = 205
            Top = 28
            Width = 25
            Height = 25
            Hint = 'Bold'
            AllowAllUp = True
            GroupIndex = 1
            Flat = True
            Glyph.Data = {
              76060000424DB606000000000000760000002800000014000000140000000100
              2000000000004006000000000000000000001000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
              0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
              FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
              000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
              00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bPDFUserFontBoldClick
          end
          object bPDFUserFontItalic: TSpeedButton
            Left = 230
            Top = 28
            Width = 25
            Height = 25
            Hint = 'Italic'
            AllowAllUp = True
            GroupIndex = 2
            Flat = True
            Glyph.Data = {
              76060000424DB606000000000000760000002800000014000000140000000100
              2000000000004006000000000000000000001000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
              0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bPDFUserFontItalicClick
          end
          object laPDFUserFontName: TcxLabel
            Left = -2
            Top = 7
            Caption = 'User Font Name'
          end
          object laPDFUserFontSize: TcxLabel
            Left = 35
            Top = 33
            Caption = 'Font Size'
          end
          object cbPDFUserFontName: TComboBox
            Left = 102
            Top = 3
            Width = 154
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cbPDFUserFontNameChange
          end
          object cbPDFUserFontSize: TComboBox
            Left = 102
            Top = 29
            Width = 55
            Height = 23
            TabOrder = 1
            OnChange = cbPDFUserFontSizeChange
            OnKeyPress = NumberKeyPress
            Items.Strings = (
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
          end
          object paPDFUserSample: TcxGroupBox
            Left = 0
            Top = 62
            Align = alBottom
            TabOrder = 2
            Height = 79
            Width = 265
            object pbPDFUserSample: TPaintBox
              Left = 0
              Top = 13
              Width = 261
              Height = 66
              Hint = 'Sample Text'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -20
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = bPDFUserFontColorClick
              OnPaint = pbPDFUserSamplePaint
            end
            object laPDFUserSample: TcxLabel
              Left = 2
              Top = 20
              Align = alTop
              Caption = 'Sample Text'
              ParentColor = False
              ParentFont = False
              ExplicitWidth = 257
            end
          end
        end
      end
      object cbPDFEnableUserFonts: TcxCheckBox
        Left = 3
        Top = 120
        Caption = 'Enable User Fonts'
        TabOrder = 2
        OnClick = cbPDFEnableUserFontsClick
      end
    end
    object tshODS: TcxTabSheet
      Caption = 'ODS Options'
      ImageIndex = 12
      object pcODSMainOptions: TcxPageControl
        Left = 0
        Top = 0
        Width = 169
        Height = 350
        Align = alLeft
        TabOrder = 0
        Properties.ActivePage = tsODSOptions
        Properties.CustomButtons.Buttons = <>
        OnChange = pcODSMainOptionsChange
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 167
        ClientRectTop = 24
        object tsODSOptions: TcxTabSheet
          Caption = 'Options'
          object lvODSOptions: TListView
            Left = 0
            Top = 0
            Width = 165
            Height = 265
            Align = alTop
            Columns = <
              item
                Caption = 'Options'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 0
            ViewStyle = vsReport
            OnChange = lvODSOptionsChange
            OnDeletion = lvODSOptionsDeletion
            ExplicitWidth = 161
          end
          object paODSSheetName: TcxGroupBox
            Left = 0
            Top = 275
            Align = alBottom
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 49
            Width = 165
            object laODSSheetName: TcxLabel
              Left = 2
              Top = 2
              Align = alTop
              Caption = 'Sheet Name'
              Transparent = True
              ExplicitWidth = 157
            end
            object edODSSheetName: TEdit
              Left = 6
              Top = 22
              Width = 150
              Height = 23
              Hint = 'Sheet Name'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
          end
        end
        object tsODSStripStyles: TcxTabSheet
          Caption = 'Styles'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lvODSSStyles: TListView
            Left = 0
            Top = 30
            Width = 161
            Height = 205
            Align = alClient
            Columns = <
              item
                Caption = 'StripStyles'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvODSSStylesChange
            OnDeletion = lvODSSStylesDeletion
          end
          object rgODSStripType: TRadioGroup
            Left = 0
            Top = 235
            Width = 161
            Height = 81
            Align = alBottom
            Caption = 'Strip Type'
            ItemIndex = 0
            Items.Strings = (
              'None'
              'Column'
              'Row')
            TabOrder = 2
          end
          object tlbODSSStyles: TToolBar
            Left = 0
            Top = 0
            Width = 161
            Height = 30
            ButtonHeight = 25
            ButtonWidth = 25
            Caption = 'tlbODSSStyles'
            Images = ilXLSStyles
            TabOrder = 0
            object bODSAddSStyle: TToolButton
              Left = 0
              Top = 0
              Hint = 'Add new strip style'
              Caption = 'bODSAddSStyle'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSAddSStyleClick
            end
            object bODSRemoveSStyle: TToolButton
              Left = 25
              Top = 0
              Hint = 'Remove selected strip style'
              Caption = 'bODSRemoveSStyle'
              Enabled = False
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSRemoveSStyleClick
            end
            object bODSMoveUp: TToolButton
              Left = 50
              Top = 0
              Hint = 'Move selected strip style up'
              Caption = 'bODSMoveUp'
              Enabled = False
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSMoveUpClick
            end
            object bODSMoveDown: TToolButton
              Left = 75
              Top = 0
              Hint = 'Move selected strip style down'
              Caption = 'bODSMoveDown'
              Enabled = False
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSMoveDownClick
            end
            object bODSSeparator: TToolButton
              Left = 100
              Top = 0
              Width = 8
              Caption = 'bODSSeparator'
              ImageIndex = 4
              Style = tbsSeparator
            end
            object bODSLoadStyle: TToolButton
              Left = 108
              Top = 0
              Hint = 'Load Strip Styles'
              Caption = 'bODSLoadStyle'
              ImageIndex = 4
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSLoadStyleClick
            end
            object bODSSaveStyle: TToolButton
              Left = 133
              Top = 0
              Hint = 'Save Strip Styles'
              Caption = 'bODSSaveStyle'
              ImageIndex = 5
              ParentShowHint = False
              ShowHint = True
              OnClick = bODSSaveStyleClick
            end
          end
        end
      end
      object pcODSDataFormat: TcxPageControl
        Left = 168
        Top = 0
        Width = 294
        Height = 201
        TabOrder = 1
        Properties.ActivePage = tsODSFont
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 199
        ClientRectLeft = 2
        ClientRectRight = 292
        ClientRectTop = 24
        object tsODSFont: TcxTabSheet
          Caption = 'Font'
          object bODSFont: TSpeedButton
            Left = 86
            Top = 58
            Width = 25
            Height = 25
            Hint = 'Font color'
            Flat = True
            Glyph.Data = {
              C6050000424DC605000000000000360400002800000014000000140000000100
              0800000000009001000000000000000000000001000000010000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
              FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
              00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = bODSFontClick
            OnMouseDown = bODSFontMouseDown
            OnMouseUp = bODSFontMouseUp
          end
          object pbODSFontColor: TPaintBox
            Left = 89
            Top = 76
            Width = 18
            Height = 4
            OnPaint = pbODSFontColorPaint
          end
          object bODSBackgroundColor: TSpeedButton
            Left = 200
            Top = 133
            Width = 25
            Height = 25
            Hint = 'Background Color'
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
              FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
              F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
              0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
              07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
              FFF7447FFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = bODSBackgroundColorClick
            OnMouseDown = bODSBackgroundColorMouseDown
            OnMouseUp = bODSBackgroundColorMouseUp
          end
          object pbODSBackColor: TPaintBox
            Left = 204
            Top = 151
            Width = 18
            Height = 4
            OnPaint = pbODSBackColorPaint
          end
          object bODSBottom: TSpeedButton
            Left = 245
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Bottom'
            GroupIndex = 7
            Down = True
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0
              FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSBottomClick
          end
          object bODSMiddle: TSpeedButton
            Left = 220
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Middle'
            GroupIndex = 7
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFF0FFF0
              FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSMiddleClick
          end
          object bODSTop: TSpeedButton
            Left = 194
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Top'
            GroupIndex = 7
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
              0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSTopClick
          end
          object bODSJustify: TSpeedButton
            Left = 163
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Justify'
            GroupIndex = 6
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSJustifyClick
          end
          object bODSRight: TSpeedButton
            Left = 138
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Right'
            GroupIndex = 6
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSRightClick
          end
          object bODSCenter: TSpeedButton
            Left = 113
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Horizontal Center Aligment'
            GroupIndex = 6
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSCenterClick
          end
          object bODSLeft: TSpeedButton
            Left = 88
            Top = 93
            Width = 25
            Height = 25
            Hint = 'Horizontal Left Aligment'
            GroupIndex = 6
            Down = True
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSLeftClick
          end
          object bODSUnderline: TSpeedButton
            Left = 198
            Top = 58
            Width = 25
            Height = 25
            Hint = 'Single Underline'
            AllowAllUp = True
            GroupIndex = 5
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
              0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
              FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
              0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSUnderlineClick
          end
          object bODSStrikeOut: TSpeedButton
            Left = 167
            Top = 58
            Width = 25
            Height = 25
            Hint = 'Strike Out'
            AllowAllUp = True
            GroupIndex = 3
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
              FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
              F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
              0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSStrikeOutClick
          end
          object bODSItalic: TSpeedButton
            Left = 142
            Top = 58
            Width = 25
            Height = 25
            Hint = 'Italic'
            AllowAllUp = True
            GroupIndex = 2
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
              FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
              FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
              0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = bODSItalicClick
          end
          object bODSBold: TSpeedButton
            Left = 117
            Top = 58
            Width = 25
            Height = 25
            Hint = 'Bold'
            AllowAllUp = True
            GroupIndex = 1
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
              0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
              F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
              0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = bODSBoldClick
          end
          object laODSFontSize: TcxLabel
            Left = 5
            Top = 29
            Caption = 'Size'
            Transparent = True
          end
          object laODSFont: TcxLabel
            Left = 5
            Top = 4
            Caption = 'Font'
            Transparent = True
          end
          object cbODSBackground: TcxCheckBox
            Left = 78
            Top = 135
            Caption = 'Use Background'
            TabOrder = 2
            OnClick = cbODSBackgroundClick
          end
          object cbODSFontSize: TComboBox
            Left = 86
            Top = 28
            Width = 55
            Height = 23
            TabOrder = 1
            OnChange = cbODSFontSizeChange
            OnKeyPress = NumberKeyPress
            Items.Strings = (
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
          end
          object cbODSFont: TComboBox
            Left = 86
            Top = 3
            Width = 150
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cbODSFontChange
          end
        end
        object tsODSBorder: TcxTabSheet
          Caption = 'Border'
          ImageIndex = 1
          ExplicitLeft = 4
          ExplicitTop = 26
          ExplicitWidth = 286
          ExplicitHeight = 171
          object bODSBorderColor: TSpeedButton
            Left = 91
            Top = 25
            Width = 25
            Height = 25
            Hint = 'Border Color'
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
              FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
              FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
              0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
              0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = bODSBorderColorClick
            OnMouseDown = bODSBorderColorMouseDown
            OnMouseUp = bODSBorderColorMouseUp
          end
          object pbODSBorderColor: TPaintBox
            Left = 94
            Top = 42
            Width = 18
            Height = 4
            OnPaint = pbODSBorderColorPaint
          end
          object laODSBorderColor: TcxLabel
            Left = 4
            Top = 30
            Caption = 'Border Color'
            Transparent = True
          end
          object laODSBorderWidth: TcxLabel
            Left = 132
            Top = 30
            Caption = 'Border Width'
            Transparent = True
          end
          object edODSBorderWidth: TEdit
            Left = 221
            Top = 29
            Width = 33
            Height = 23
            Hint = 'Border Width'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '1'
            OnChange = edODSBorderWidthChange
            OnExit = edODSBorderWidthExit
            OnKeyPress = NumberKeyPress
          end
          object cbODSUseBorder: TcxCheckBox
            Left = 5
            Top = 4
            Caption = 'Use Border'
            TabOrder = 0
            OnClick = cbODSUseBorderClick
          end
        end
      end
      object paODSSample: TcxGroupBox
        Left = 170
        Top = 202
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 85
        Width = 290
        object pbODSSample: TPaintBox
          Left = 2
          Top = 37
          Width = 286
          Height = 46
          Hint = 'Sample Text'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnPaint = pbODSSamplePaint
          ExplicitLeft = 0
          ExplicitTop = 13
          ExplicitWidth = 290
          ExplicitHeight = 64
        end
        object laODSSampleCellLabel: TcxLabel
          Left = 2
          Top = 20
          Align = alTop
          Caption = 'Sample Text'
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
    end
    object tshODT: TcxTabSheet
      Caption = 'ODT Options'
      ImageIndex = 13
      object pcODTMainOptions: TcxPageControl
        Left = 0
        Top = 0
        Width = 169
        Height = 350
        Align = alLeft
        TabOrder = 0
        Properties.ActivePage = tsODTOptions
        Properties.CustomButtons.Buttons = <>
        OnChange = pcODTMainOptionsChange
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 167
        ClientRectTop = 24
        object tsODTOptions: TcxTabSheet
          Caption = 'Options'
          object paODTTableName: TcxGroupBox
            Left = 0
            Top = 275
            Align = alBottom
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 49
            Width = 165
            object laODTTableName: TcxLabel
              Left = 2
              Top = 2
              Align = alTop
              Caption = 'Table Name'
              Transparent = True
              ExplicitWidth = 157
            end
            object edODTTableName: TEdit
              Left = 5
              Top = 24
              Width = 152
              Height = 23
              Hint = 'Table Name'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
          end
          object lvODTOptions: TListView
            Left = 0
            Top = 0
            Width = 165
            Height = 275
            Align = alClient
            Columns = <
              item
                Caption = 'Options'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 0
            ViewStyle = vsReport
            OnChange = lvODTOptionsChange
            OnDeletion = lvODTOptionsDeletion
            ExplicitWidth = 161
            ExplicitHeight = 267
          end
        end
        object tsODTStripStyles: TcxTabSheet
          Caption = 'Styles'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object tlbODTSStyles: TToolBar
            Left = 0
            Top = 0
            Width = 161
            Height = 30
            ButtonHeight = 25
            ButtonWidth = 25
            Caption = 'tlbODTSStyles'
            Images = ilXLSStyles
            TabOrder = 0
            object bODTAddSStyle: TToolButton
              Left = 0
              Top = 0
              Hint = 'Add new strip style'
              Caption = 'bODTAddSStyle'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTAddSStyleClick
            end
            object bODTRemoveSStyle: TToolButton
              Left = 25
              Top = 0
              Hint = 'Remove selected strip style'
              Caption = 'bODTRemoveSStyle'
              Enabled = False
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTRemoveSStyleClick
            end
            object bODTMoveUp: TToolButton
              Left = 50
              Top = 0
              Hint = 'Move selected strip style up'
              Caption = 'bODTMoveUp'
              Enabled = False
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTMoveUpClick
            end
            object bODTMoveDown: TToolButton
              Left = 75
              Top = 0
              Hint = 'Move selected strip style down'
              Caption = 'bODTMoveDown'
              Enabled = False
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTMoveDownClick
            end
            object bODTSeparator: TToolButton
              Left = 100
              Top = 0
              Width = 8
              Caption = 'bODTSeparator'
              ImageIndex = 4
              Style = tbsSeparator
            end
            object bODTLoadStyle: TToolButton
              Left = 108
              Top = 0
              Hint = 'Load Strip Styles'
              Caption = 'bODTLoadStyle'
              ImageIndex = 4
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTLoadStyleClick
            end
            object bODTSaveStyle: TToolButton
              Left = 133
              Top = 0
              Hint = 'Save Strip Styles'
              Caption = 'bODTSaveStyle'
              ImageIndex = 5
              ParentShowHint = False
              ShowHint = True
              OnClick = bODTSaveStyleClick
            end
          end
          object lvODTSStyles: TListView
            Left = 0
            Top = 30
            Width = 161
            Height = 205
            Align = alClient
            Columns = <
              item
                Caption = 'StripStyles'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvODTSStylesChange
            OnDeletion = lvODTSStylesDeletion
          end
          object rgODTStripType: TRadioGroup
            Left = 0
            Top = 235
            Width = 161
            Height = 81
            Align = alBottom
            Caption = 'Strip Type'
            ItemIndex = 0
            Items.Strings = (
              'None'
              'Column'
              'Row')
            TabOrder = 2
          end
        end
        object tsODTBorder: TcxTabSheet
          Caption = 'Border'
          ImageIndex = 2
          ExplicitLeft = 4
          ExplicitTop = 26
          ExplicitWidth = 161
          ExplicitHeight = 316
          object bODTBorderColor: TSpeedButton
            Left = 88
            Top = 34
            Width = 25
            Height = 25
            Hint = 'Border Color'
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
              FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
              FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
              0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
              0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = bODTBorderColorClick
            OnMouseDown = bODTBorderColorMouseDown
            OnMouseUp = bODTBorderColorMouseUp
          end
          object pbODTTextBorder: TPaintBox
            Left = 92
            Top = 49
            Width = 18
            Height = 4
            OnPaint = pbODTTextBorderPaint
          end
          object laODTBorderColor: TcxLabel
            Left = 4
            Top = 37
            Caption = 'Border Color'
            Transparent = True
          end
          object laODTBorderWidth: TcxLabel
            Left = 4
            Top = 70
            Caption = 'Border Width'
            Transparent = True
          end
          object cbODTUseBorder: TcxCheckBox
            Left = 5
            Top = 4
            Caption = 'Use Border'
            TabOrder = 0
            OnClick = cbODTUseBorderClick
          end
          object edODTBorderWidth: TEdit
            Left = 88
            Top = 69
            Width = 33
            Height = 23
            Hint = 'Border Width'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = '1'
            OnChange = edODTBorderWidthChange
            OnExit = edODTBorderWidthExit
            OnKeyPress = NumberKeyPress
          end
        end
      end
      object pcODTDataFormat: TcxPageControl
        Left = 168
        Top = 0
        Width = 294
        Height = 201
        TabOrder = 1
        Properties.ActivePage = tsODTTextSheet
        Properties.CustomButtons.Buttons = <>
        Properties.TabHeight = 1
        ClientRectBottom = 199
        ClientRectLeft = 2
        ClientRectRight = 292
        ClientRectTop = 2
        object tsODTTextSheet: TcxTabSheet
          Caption = 'tsODTTextSheet'
          TabVisible = False
          object pcODTTextDataFormat: TcxPageControl
            Left = 0
            Top = 0
            Width = 290
            Height = 197
            Align = alClient
            TabOrder = 0
            Properties.ActivePage = tsODTTextFont
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 195
            ClientRectLeft = 2
            ClientRectRight = 288
            ClientRectTop = 24
            object tsODTTextFont: TcxTabSheet
              Caption = 'Font'
              object bODTTextFontColor: TSpeedButton
                Left = 77
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Font color'
                Flat = True
                Glyph.Data = {
                  C6050000424DC605000000000000360400002800000014000000140000000100
                  0800000000009001000000000000000000000001000000010000000000000000
                  80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                  A6000020400000206000002080000020A0000020C0000020E000004000000040
                  20000040400000406000004080000040A0000040C0000040E000006000000060
                  20000060400000606000006080000060A0000060C0000060E000008000000080
                  20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                  200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                  200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                  200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                  20004000400040006000400080004000A0004000C0004000E000402000004020
                  20004020400040206000402080004020A0004020C0004020E000404000004040
                  20004040400040406000404080004040A0004040C0004040E000406000004060
                  20004060400040606000406080004060A0004060C0004060E000408000004080
                  20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                  200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                  200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                  200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                  20008000400080006000800080008000A0008000C0008000E000802000008020
                  20008020400080206000802080008020A0008020C0008020E000804000008040
                  20008040400080406000804080008040A0008040C0008040E000806000008060
                  20008060400080606000806080008060A0008060C0008060E000808000008080
                  20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                  200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                  200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                  200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                  2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                  2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                  2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                  2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                  2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                  2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                  2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
                  FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTTextFontColorClick
                OnMouseDown = bODTTextFontColorMouseDown
                OnMouseUp = bODTTextFontColorMouseUp
              end
              object bODTTextBackground: TSpeedButton
                Left = 114
                Top = 130
                Width = 25
                Height = 25
                Hint = 'Background Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                  FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                  F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                  0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                  07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                  FFF7447FFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTTextBackgroundClick
                OnMouseDown = bODTTextBackgroundMouseDown
                OnMouseUp = bODTTextBackgroundMouseUp
              end
              object bODTTextJustify: TSpeedButton
                Left = 153
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Justify'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextJustifyClick
              end
              object bODTTextRight: TSpeedButton
                Left = 128
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Horizontal Right Aligment'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextRightClick
              end
              object bODTTextCenter: TSpeedButton
                Left = 103
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Center'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextCenterClick
              end
              object bODTTextLeft: TSpeedButton
                Left = 78
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Left'
                GroupIndex = 6
                Down = True
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextLeftClick
              end
              object bODTTextUnderline: TSpeedButton
                Left = 188
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Single Underline'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextUnderlineClick
              end
              object bODTTextStrikeOut: TSpeedButton
                Left = 158
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Strike Out'
                AllowAllUp = True
                GroupIndex = 3
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
                  FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
                  F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
                  0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextStrikeOutClick
              end
              object bODTTextItalic: TSpeedButton
                Left = 133
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Italic'
                AllowAllUp = True
                GroupIndex = 2
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
                  FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
                  FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
                  0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTTextItalicClick
              end
              object bODTTextBold: TSpeedButton
                Left = 108
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Bold'
                AllowAllUp = True
                GroupIndex = 1
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
                  0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
                  F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
                  0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTTextBoldClick
              end
              object pbODTTextFontColor: TPaintBox
                Left = 78
                Top = 78
                Width = 20
                Height = 5
                OnPaint = pbODTTextFontColorPaint
              end
              object pbODTTextBackground: TPaintBox
                Left = 114
                Top = 148
                Width = 18
                Height = 4
                OnPaint = pbODTTextBackgroundPaint
              end
              object bODTTextHighlight: TSpeedButton
                Left = 248
                Top = 131
                Width = 25
                Height = 25
                Hint = 'Highlight Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                  FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                  F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                  0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                  07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                  FFF7447FFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTTextHighlightClick
                OnMouseDown = bODTTextHighlightMouseDown
                OnMouseUp = bODTTextHighlightMouseUp
              end
              object pbODTTextHighlight: TPaintBox
                Left = 251
                Top = 149
                Width = 18
                Height = 4
                OnPaint = pbODTTextHighlightPaint
              end
              object laODTTextSize: TcxLabel
                Left = 14
                Top = 30
                Caption = 'Size'
                Transparent = True
              end
              object laODTTextFont: TcxLabel
                Left = 14
                Top = 5
                Caption = 'Font'
                Transparent = True
              end
              object cbODTTextFontSize: TComboBox
                Left = 77
                Top = 28
                Width = 55
                Height = 23
                TabOrder = 1
                OnChange = cbODTTextFontSizeChange
                OnKeyPress = NumberKeyPress
                Items.Strings = (
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
              end
              object cbODTTextFont: TComboBox
                Left = 77
                Top = 3
                Width = 150
                Height = 23
                Style = csDropDownList
                TabOrder = 0
                OnChange = cbODTTextFontChange
              end
              object cbODTTextBackground: TcxCheckBox
                Left = 4
                Top = 133
                Caption = 'Use Background'
                TabOrder = 2
                OnClick = cbODTTextBackgroundClick
              end
              object cbODTTextHighlight: TcxCheckBox
                Left = 146
                Top = 133
                Caption = 'Use Highlight'
                TabOrder = 3
                OnClick = cbODTTextHighlightClick
              end
            end
          end
        end
        object tsODTCellSheet: TcxTabSheet
          Caption = 'tsODTCellSheet'
          ImageIndex = 1
          TabVisible = False
          object pcODTCellDataFormat: TcxPageControl
            Left = 0
            Top = 0
            Width = 290
            Height = 197
            Align = alClient
            TabOrder = 0
            Properties.ActivePage = tsODTCellFont
            Properties.CustomButtons.Buttons = <>
            ClientRectBottom = 195
            ClientRectLeft = 2
            ClientRectRight = 288
            ClientRectTop = 24
            object tsODTCellFont: TcxTabSheet
              Caption = 'Font'
              object bODTCellFontColor: TSpeedButton
                Left = 67
                Top = 61
                Width = 24
                Height = 25
                Hint = 'Font color'
                Flat = True
                Glyph.Data = {
                  C6050000424DC605000000000000360400002800000014000000140000000100
                  0800000000009001000000000000000000000001000000010000000000000000
                  80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
                  A6000020400000206000002080000020A0000020C0000020E000004000000040
                  20000040400000406000004080000040A0000040C0000040E000006000000060
                  20000060400000606000006080000060A0000060C0000060E000008000000080
                  20000080400000806000008080000080A0000080C0000080E00000A0000000A0
                  200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
                  200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
                  200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
                  20004000400040006000400080004000A0004000C0004000E000402000004020
                  20004020400040206000402080004020A0004020C0004020E000404000004040
                  20004040400040406000404080004040A0004040C0004040E000406000004060
                  20004060400040606000406080004060A0004060C0004060E000408000004080
                  20004080400040806000408080004080A0004080C0004080E00040A0000040A0
                  200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
                  200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
                  200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
                  20008000400080006000800080008000A0008000C0008000E000802000008020
                  20008020400080206000802080008020A0008020C0008020E000804000008040
                  20008040400080406000804080008040A0008040C0008040E000806000008060
                  20008060400080606000806080008060A0008060C0008060E000808000008080
                  20008080400080806000808080008080A0008080C0008080E00080A0000080A0
                  200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
                  200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
                  200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
                  2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
                  2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
                  2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
                  2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
                  2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
                  2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
                  2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
                  FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
                  00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
                  FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTCellFontColorClick
                OnMouseDown = bODTCellFontColorMouseDown
                OnMouseUp = bODTCellFontColorMouseUp
              end
              object bODTCellBottom: TSpeedButton
                Left = 197
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Vertical Bottom Aligment'
                GroupIndex = 7
                Down = True
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
                  0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
                  F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
                  F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
                  0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0
                  FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellBottomClick
              end
              object bODTCellMiddle: TSpeedButton
                Left = 172
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Vertical Middle Aligment'
                GroupIndex = 7
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
                  0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
                  F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
                  F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
                  0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFF0FFF0
                  FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellMiddleClick
              end
              object bODTCellTop: TSpeedButton
                Left = 146
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Vertical Top Aligment'
                GroupIndex = 7
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
                  0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFF0F0F0F0
                  F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
                  F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
                  0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
                  F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellTopClick
              end
              object bODTCellJustify: TSpeedButton
                Left = 115
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Justify'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellJustifyClick
              end
              object bODTCellRight: TSpeedButton
                Left = 90
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Right'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellRightClick
              end
              object bODTCellCenter: TSpeedButton
                Left = 65
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Center'
                GroupIndex = 6
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellCenterClick
              end
              object bODTCellLeft: TSpeedButton
                Left = 40
                Top = 96
                Width = 25
                Height = 25
                Hint = 'Left'
                GroupIndex = 6
                Down = True
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
                  000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellLeftClick
              end
              object bODTCellUnderline: TSpeedButton
                Left = 177
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Single Underline'
                AllowAllUp = True
                GroupIndex = 5
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
                  0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
                  FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
                  0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellUnderlineClick
              end
              object bODTCellStrikeOut: TSpeedButton
                Left = 147
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Strike Out'
                AllowAllUp = True
                GroupIndex = 3
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
                  FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
                  F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
                  0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellStrikeOutClick
              end
              object bODTCellItalic: TSpeedButton
                Left = 122
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Italic'
                AllowAllUp = True
                GroupIndex = 2
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
                  FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
                  FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
                  0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                OnClick = bODTCellItalicClick
              end
              object bODTCellBold: TSpeedButton
                Left = 97
                Top = 61
                Width = 25
                Height = 25
                Hint = 'Bold'
                AllowAllUp = True
                GroupIndex = 1
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
                  0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
                  F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
                  0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTCellBoldClick
              end
              object pbODTCellFontColor: TPaintBox
                Left = 69
                Top = 79
                Width = 18
                Height = 4
                OnPaint = pbODTCellFontColorPaint
              end
              object bODTCellBackground: TSpeedButton
                Left = 111
                Top = 130
                Width = 25
                Height = 25
                Hint = 'Background Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                  FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                  F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                  0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                  07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                  FFF7447FFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTCellBackgroundClick
                OnMouseDown = bODTCellBackgroundMouseDown
                OnMouseUp = bODTCellBackgroundMouseUp
              end
              object pbODTCellBackground: TPaintBox
                Left = 114
                Top = 148
                Width = 18
                Height = 4
                OnPaint = pbODTCellBackgroundPaint
              end
              object bODTCellHighlight: TSpeedButton
                Left = 248
                Top = 131
                Width = 25
                Height = 25
                Hint = 'Highlight Color'
                Flat = True
                Glyph.Data = {
                  66010000424D6601000000000000760000002800000014000000140000000100
                  040000000000F000000000000000000000001000000010000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                  FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                  FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
                  0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
                  FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
                  F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
                  0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
                  07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
                  FFF7447FFFFFFFFF0000}
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                OnClick = bODTCellHighlightClick
                OnMouseDown = bODTCellHighlightMouseDown
                OnMouseUp = bODTCellHighlightMouseUp
              end
              object pbODTCellHighlight: TPaintBox
                Left = 251
                Top = 149
                Width = 18
                Height = 4
                OnPaint = pbODTCellHighlightPaint
              end
              object laODTCellFontSize: TcxLabel
                Left = 50
                Top = 35
                Caption = 'Size'
              end
              object laODTCellFont: TcxLabel
                Left = 47
                Top = 7
                Caption = 'Font'
              end
              object cbODTCellFontSize: TComboBox
                Left = 77
                Top = 31
                Width = 55
                Height = 23
                TabOrder = 1
                OnChange = cbODTCellFontSizeChange
                OnKeyPress = NumberKeyPress
                Items.Strings = (
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
              end
              object cbODTCellFont: TComboBox
                Left = 77
                Top = 3
                Width = 150
                Height = 23
                Style = csDropDownList
                TabOrder = 0
                OnChange = cbODTCellFontChange
              end
              object cbODTCellBackground: TcxCheckBox
                Left = 4
                Top = 135
                Caption = 'Use Background'
                TabOrder = 2
                OnClick = cbODTCellBackgroundClick
              end
              object cbODTCellHighlight: TcxCheckBox
                Left = 158
                Top = 136
                Caption = 'Use Highlight'
                TabOrder = 3
                OnClick = cbODTCellHighlightClick
              end
            end
          end
        end
      end
      object paODTSample: TcxGroupBox
        Left = 170
        Top = 202
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 77
        Width = 290
        object pbODTSample: TPaintBox
          Left = 2
          Top = 37
          Width = 286
          Height = 38
          Hint = 'Sample Text'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnPaint = pbODTSamplePaint
          ExplicitLeft = 0
          ExplicitTop = 13
          ExplicitWidth = 290
          ExplicitHeight = 64
        end
        object laODTSample: TcxLabel
          Left = 2
          Top = 20
          Align = alTop
          Caption = 'Sample Text'
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
    end
    object tshXlsx: TcxTabSheet
      Caption = 'Xlsx Options'
      ImageIndex = 14
      object pcXlsxMainOptions: TcxPageControl
        Left = 0
        Top = 0
        Width = 169
        Height = 350
        Align = alLeft
        TabOrder = 0
        Properties.ActivePage = tsXlsxOptions
        Properties.CustomButtons.Buttons = <>
        OnChange = pcXlsxMainOptionsChange
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 167
        ClientRectTop = 24
        object tsXlsxOptions: TcxTabSheet
          Tag = 1
          Caption = 'Options'
          object lvXlsxOptions: TListView
            Left = 0
            Top = 0
            Width = 165
            Height = 265
            Align = alTop
            Columns = <
              item
                Caption = 'Options'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 0
            ViewStyle = vsReport
            OnSelectItem = lvXlsxOptionsSelectItem
            ExplicitWidth = 161
          end
          object paXlsxSheetName: TcxGroupBox
            Left = 0
            Top = 275
            Align = alBottom
            PanelStyle.Active = True
            Style.BorderStyle = ebsNone
            TabOrder = 1
            Height = 49
            Width = 165
            object laXlsxSheetName: TcxLabel
              Left = 2
              Top = 2
              Align = alTop
              Caption = 'Sheet Name'
              Transparent = True
              ExplicitWidth = 157
            end
            object edXlsxSheetName: TEdit
              Left = 4
              Top = 23
              Width = 153
              Height = 23
              Hint = 'Sheet Name'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnChange = edXlsxSheetNameChange
            end
          end
        end
        object tsXlsxStripStyles: TcxTabSheet
          Tag = 2
          Caption = 'Styles'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object tlbXlsxSStyles: TToolBar
            Left = 0
            Top = 0
            Width = 161
            Height = 30
            ButtonHeight = 25
            ButtonWidth = 25
            Caption = 'tlbXlsxSStyles'
            Images = ilXLSStyles
            TabOrder = 0
            object btnXlsxAddSStyle: TToolButton
              Left = 0
              Top = 0
              Hint = 'Add new strip style'
              Caption = 'btnXlsxAddSStyle'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
              OnClick = btnXlsxAddSStyleClick
            end
            object btnXlsxRemoveSStyle: TToolButton
              Left = 25
              Top = 0
              Hint = 'Remove selected strip style'
              Caption = 'btnXlsxRemoveSStyle'
              Enabled = False
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = btnXlsxRemoveSStyleClick
            end
            object buXlsxSeparator: TToolButton
              Left = 50
              Top = 0
              Width = 8
              Caption = 'buXlsxSeparator'
              ImageIndex = 2
              Style = tbsSeparator
            end
            object btnXlsxMoveUp: TToolButton
              Left = 58
              Top = 0
              Hint = 'Move selected strip style up'
              Caption = 'btnXlsxMoveUp'
              Enabled = False
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = btnXlsxMoveUpClick
            end
            object btnXlsxMoveDown: TToolButton
              Left = 83
              Top = 0
              Hint = 'Move selected strip style down'
              Caption = 'btnXlsxMoveDown'
              Enabled = False
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = btnXlsxMoveDownClick
            end
          end
          object lvXlsxSStyles: TListView
            Left = 0
            Top = 30
            Width = 161
            Height = 205
            Align = alClient
            Columns = <
              item
                Caption = 'StripStyles'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvXlsxSStylesChange
            OnSelectItem = lvXlsxSStylesSelectItem
          end
          object rgXlsxStripType: TRadioGroup
            Left = 0
            Top = 235
            Width = 161
            Height = 81
            Align = alBottom
            Caption = 'Strip Type'
            ItemIndex = 0
            Items.Strings = (
              'None'
              'Column'
              'Row')
            TabOrder = 2
          end
        end
      end
      object pcXlsxDataFormat: TcxPageControl
        Left = 168
        Top = 0
        Width = 294
        Height = 201
        TabOrder = 1
        Properties.ActivePage = tsXlsxFont
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 199
        ClientRectLeft = 2
        ClientRectRight = 292
        ClientRectTop = 24
        object tsXlsxFont: TcxTabSheet
          Caption = 'Font'
          object btnXlsxBackgroundColor: TSpeedButton
            Left = 124
            Top = 136
            Width = 25
            Height = 25
            Hint = 'Background Color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
              FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
              F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
              0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
              07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
              FFF7447FFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnXlsxBackgroundColorClick
            OnMouseDown = btnXlsxBackgroundColorMouseDown
            OnMouseUp = btnXlsxBackgroundColorMouseUp
          end
          object btnXlsxFontColor: TSpeedButton
            Left = 86
            Top = 67
            Width = 25
            Height = 25
            Hint = 'Font color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              C6050000424DC605000000000000360400002800000014000000140000000100
              0800000000009001000000000000000000000001000000010000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
              FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
              00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnXlsxFontColorClick
            OnMouseDown = btnXlsxFontColorMouseDown
            OnMouseUp = btnXlsxFontColorMouseUp
          end
          object pbXlsxBackColor: TPaintBox
            Left = 128
            Top = 154
            Width = 18
            Height = 4
            OnPaint = pbXlsxBackColorPaint
          end
          object btnXlsxVerticalBottom: TSpeedButton
            Left = 206
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Bottom'
            GroupIndex = 7
            Down = True
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0
              FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxVerticalBottomClick
          end
          object btnXlsxVerticalCenter: TSpeedButton
            Left = 181
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Middle'
            GroupIndex = 7
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFF0FFF0
              FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxVerticalCenterClick
          end
          object btnXlsxVerticalTop: TSpeedButton
            Left = 155
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Top'
            GroupIndex = 7
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF
              0000FFFFFFF0FFF0FFF0FFFF0000FFFFFFF0FFF0FFF0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFF
              F0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF
              0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFF0F0F0F0
              F0F0FFFF0000FFFFF0F0F0F0F0F0FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxVerticalTopClick
          end
          object btnXlsxHorizontalRight: TSpeedButton
            Left = 124
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Right'
            GroupIndex = 6
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxHorizontalRightClick
          end
          object btnXlsxHorizontalCenter: TSpeedButton
            Left = 99
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Horizontal Center Aligment'
            GroupIndex = 6
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxHorizontalCenterClick
          end
          object btnXlsxHorizontalLeft: TSpeedButton
            Left = 74
            Top = 102
            Width = 25
            Height = 25
            Hint = 'Horizontal Left Aligment'
            GroupIndex = 6
            Down = True
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxHorizontalLeftClick
          end
          object btnXlsxUnderlineSingle: TSpeedButton
            Left = 167
            Top = 67
            Width = 25
            Height = 25
            Hint = 'Single Underline'
            AllowAllUp = True
            GroupIndex = 5
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
              0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
              FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
              0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxUnderlineSingleClick
          end
          object btnXlsxItalic: TSpeedButton
            Left = 142
            Top = 67
            Width = 25
            Height = 25
            Hint = 'Italic'
            AllowAllUp = True
            GroupIndex = 2
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
              FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
              FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
              0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxItalicClick
          end
          object btnXlsxBold: TSpeedButton
            Left = 117
            Top = 67
            Width = 25
            Height = 25
            Hint = 'Bold'
            AllowAllUp = True
            GroupIndex = 1
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
              0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
              F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
              0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnXlsxBoldClick
          end
          object pbXlsxFontColor: TPaintBox
            Left = 89
            Top = 85
            Width = 18
            Height = 4
            OnPaint = pbXlsxFontColorPaint
          end
          object btnXlsxWrapText: TSpeedButton
            Left = 175
            Top = 136
            Width = 72
            Height = 25
            Hint = 'Wrap Text'
            AllowAllUp = True
            GroupIndex = 9
            Caption = 'Wrap Text'
            Enabled = False
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = btnXlsxWrapTextClick
          end
          object laXlsxFontSize: TcxLabel
            Left = 9
            Top = 35
            Caption = 'Size'
            Enabled = False
            Transparent = True
          end
          object laXlsxFont: TcxLabel
            Left = 9
            Top = 10
            Caption = 'Font'
            Enabled = False
            Transparent = True
          end
          object chkXlsxUseBackground: TcxCheckBox
            Left = 14
            Top = 141
            Caption = 'Use Background'
            Enabled = False
            TabOrder = 2
            OnClick = chkXlsxUseBackgroundClick
          end
          object cbXlsxFontSize: TComboBox
            Left = 86
            Top = 34
            Width = 55
            Height = 23
            TabOrder = 1
            OnChange = cbXlsxFontSizeChange
            Items.Strings = (
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
          end
          object cbXlsxFont: TComboBox
            Left = 86
            Top = 9
            Width = 150
            Height = 23
            Style = csDropDownList
            TabOrder = 0
            OnChange = cbXlsxFontChange
          end
        end
        object tsXlsxBorder: TcxTabSheet
          Caption = 'Border'
          ImageIndex = 1
          object btnXlsxBorderColor: TSpeedButton
            Left = 82
            Top = 27
            Width = 25
            Height = 25
            Hint = 'Border Color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
              FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
              FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
              0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
              0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnXlsxBorderColorClick
            OnMouseDown = btnXlsxBorderColorMouseDown
            OnMouseUp = btnXlsxBorderColorMouseUp
          end
          object pbXlsxBorderColor: TPaintBox
            Left = 86
            Top = 44
            Width = 18
            Height = 4
            OnPaint = pbXlsxBorderColorPaint
          end
          object laXlsxBorderColor: TcxLabel
            Left = 4
            Top = 30
            Caption = 'Border Color'
            Enabled = False
            Transparent = True
          end
          object laXlsxBorderStyle: TcxLabel
            Left = 115
            Top = 29
            Caption = 'Border Style'
            Enabled = False
            Transparent = True
          end
          object chkXlsxUseBorder: TcxCheckBox
            Left = 5
            Top = 4
            Caption = 'Use Border'
            TabOrder = 0
            OnClick = chkXlsxUseBorderClick
          end
          object cbXlsxBorderStyle: TComboBox
            Left = 198
            Top = 28
            Width = 78
            Height = 23
            Style = csDropDownList
            Enabled = False
            TabOrder = 1
            OnChange = cbXlsxBorderStyleChange
            Items.Strings = (
              'Thin'
              'Dashed'
              'DashDot'
              'DashDotDot'
              'Dotted'
              'Hair'
              'Double'
              'Thick'
              'Medium'
              'MediumDashed'
              'MediumDashDot'
              'SlantDashDot'
              'MediumDashDotDot')
          end
        end
      end
      object paXlsxSample: TcxGroupBox
        Left = 170
        Top = 202
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 77
        Width = 290
        object pbXlsxSample: TPaintBox
          Left = 2
          Top = 37
          Width = 286
          Height = 38
          Hint = 'Sample Text'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnPaint = pbXlsxSamplePaint
          ExplicitLeft = 0
          ExplicitTop = 13
          ExplicitWidth = 290
          ExplicitHeight = 64
        end
        object laXlsxSampleCellLabel: TcxLabel
          Left = 2
          Top = 20
          Align = alTop
          Caption = 'Sample Text'
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object chXlsxAutoCalcColWidth: TcxCheckBox
        Left = 177
        Top = 285
        Caption = 'Auto Calculate Column Width'
        TabOrder = 3
        OnClick = chXlsxAutoCalcColWidthClick
      end
    end
    object tshDocx: TcxTabSheet
      Caption = 'Docx Options'
      ImageIndex = 15
      object pcDocxMainOptions: TcxPageControl
        Left = 0
        Top = 0
        Width = 169
        Height = 350
        Align = alLeft
        TabOrder = 0
        Properties.ActivePage = tsDocxOptions
        Properties.CustomButtons.Buttons = <>
        OnChange = pcDocxMainOptionsChange
        ClientRectBottom = 348
        ClientRectLeft = 2
        ClientRectRight = 167
        ClientRectTop = 24
        object tsDocxOptions: TcxTabSheet
          Tag = 1
          Caption = 'Options'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lvDocxOptions: TListView
            Left = 0
            Top = 0
            Width = 161
            Height = 316
            Align = alClient
            Columns = <
              item
                Caption = 'Options'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 0
            ViewStyle = vsReport
            OnSelectItem = lvDocxOptionsSelectItem
          end
        end
        object tsDocxStripStyles: TcxTabSheet
          Tag = 2
          Caption = 'Styles'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object tlbDocxSStyles: TToolBar
            Left = 0
            Top = 0
            Width = 161
            Height = 30
            ButtonHeight = 25
            ButtonWidth = 25
            Caption = 'tlbDocxSStyles'
            Images = ilXLSStyles
            TabOrder = 0
            object btnDocxAddSStyle: TToolButton
              Left = 0
              Top = 0
              Hint = 'Add new strip style'
              Caption = 'btnDocxAddSStyle'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
              OnClick = btnDocxAddSStyleClick
            end
            object btnDocxRemoveSStyle: TToolButton
              Left = 25
              Top = 0
              Hint = 'Remove selected strip style'
              Caption = 'btnDocxRemoveSStyle'
              Enabled = False
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = btnDocxRemoveSStyleClick
            end
            object buDocxSeparator: TToolButton
              Left = 50
              Top = 0
              Width = 8
              Caption = 'buDocxSeparator'
              ImageIndex = 2
              Style = tbsSeparator
            end
            object btnDocxMoveUp: TToolButton
              Left = 58
              Top = 0
              Hint = 'Move selected strip style up'
              Caption = 'btnDocxMoveUp'
              Enabled = False
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = btnDocxMoveUpClick
            end
            object btnDocxMoveDown: TToolButton
              Left = 83
              Top = 0
              Hint = 'Move selected strip style down'
              Caption = 'btnDocxMoveDown'
              Enabled = False
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = btnDocxMoveDownClick
            end
          end
          object lvDocxSStyles: TListView
            Left = 0
            Top = 30
            Width = 161
            Height = 205
            Align = alClient
            Columns = <
              item
                Caption = 'StripStyles'
                Width = 157
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = imgFields
            TabOrder = 1
            ViewStyle = vsReport
            OnChange = lvDocxSStylesChange
            OnSelectItem = lvDocxSStylesSelectItem
          end
          object rgDocxStripType: TRadioGroup
            Left = 0
            Top = 235
            Width = 161
            Height = 81
            Align = alBottom
            Caption = 'Strip Type'
            ItemIndex = 0
            Items.Strings = (
              'None'
              'Column'
              'Row')
            TabOrder = 2
          end
        end
        object tsDocxBorder: TcxTabSheet
          Tag = 3
          Caption = 'Border'
          ImageIndex = 2
          object btnDocxBorderColor: TSpeedButton
            Left = 76
            Top = 31
            Width = 25
            Height = 25
            Hint = 'Border Color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F446FF04448F
              FFFFFFFF0000F4446FF0F444FFFFFFFF0000FFFFFFFF0F444FFFFFFF0000FFFF
              FFFF0F4444FFFFFF0000FFFFFFFFF0F4444FFFFF0000FFFFFFFFF0FF444FFFFF
              0000FFFFFFFFFF0FF44FFFFF0000FFFFFFFFFFF0000FFFFF0000FFFFFFFFFFF8
              0BB0FFFF0000FFFFFFFFFFFF0BB0FFFF0000FFFFFFFFFFFFF0BB0FFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnDocxBorderColorClick
            OnMouseDown = btnDocxBorderColorMouseDown
            OnMouseUp = btnDocxBorderColorMouseUp
          end
          object pbDocxBorder: TPaintBox
            Left = 80
            Top = 49
            Width = 18
            Height = 4
            OnPaint = pbDocxBorderPaint
          end
          object laDocxBorderColor: TcxLabel
            Left = 4
            Top = 37
            Caption = 'Border Color'
            Enabled = False
            Transparent = True
          end
          object laDocxBorderStyle: TcxLabel
            Left = 4
            Top = 70
            Caption = 'Border Style'
            Enabled = False
            Transparent = True
          end
          object chkDocxUseBorder: TcxCheckBox
            Left = 5
            Top = 4
            Caption = 'Use Border'
            TabOrder = 0
            OnClick = chkDocxUseBorderClick
          end
          object cbDocxBorderStyle: TComboBox
            Left = 76
            Top = 66
            Width = 81
            Height = 23
            Style = csDropDownList
            Enabled = False
            TabOrder = 1
            OnChange = cbDocxBorderStyleChange
            Items.Strings = (
              'Single'
              'Thick'
              'Double'
              'Hairline'
              'Dot'
              'DashLargeGap'
              'DotDash'
              'DotDotDash'
              'Triple'
              'ThinThickSmallGap'
              'ThickThinSmallGap'
              'ThinThickThinSmallGap'
              'ThinThickMediumGap'
              'ThickThinMediumGap'
              'ThinThickThinMediumGap'
              'ThinThickLargeGap'
              'ThickThinLargeGap'
              'ThinThickThinLargeGap'
              'Wave'
              'DoubleWave'
              'DashSmallGap'
              'DashDotStroker'
              'Emboss3D'
              'Engrave3D')
          end
        end
      end
      object paDocxSample: TcxGroupBox
        Left = 170
        Top = 210
        Style.BorderStyle = ebsNone
        TabOrder = 2
        Height = 82
        Width = 290
        object pbDocxSample: TPaintBox
          Left = 2
          Top = 37
          Width = 286
          Height = 43
          Hint = 'Sample Text'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnPaint = pbDocxSamplePaint
          ExplicitLeft = 0
          ExplicitTop = 13
          ExplicitWidth = 290
          ExplicitHeight = 64
        end
        object laDocxSampleCellLabel: TcxLabel
          Left = 2
          Top = 20
          Align = alTop
          Caption = 'Sample Text'
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object pcDocxDataFormat: TcxPageControl
        Left = 168
        Top = 0
        Width = 294
        Height = 206
        TabOrder = 1
        Properties.ActivePage = tsDocxFont
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 204
        ClientRectLeft = 2
        ClientRectRight = 292
        ClientRectTop = 24
        object tsDocxFont: TcxTabSheet
          Caption = 'Font'
          object btnDocxFontColor: TSpeedButton
            Left = 77
            Top = 59
            Width = 25
            Height = 25
            Hint = 'Font color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              C6050000424DC605000000000000360400002800000014000000140000000100
              0800000000009001000000000000000000000001000000010000000000000000
              80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
              A6000020400000206000002080000020A0000020C0000020E000004000000040
              20000040400000406000004080000040A0000040C0000040E000006000000060
              20000060400000606000006080000060A0000060C0000060E000008000000080
              20000080400000806000008080000080A0000080C0000080E00000A0000000A0
              200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
              200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
              200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
              20004000400040006000400080004000A0004000C0004000E000402000004020
              20004020400040206000402080004020A0004020C0004020E000404000004040
              20004040400040406000404080004040A0004040C0004040E000406000004060
              20004060400040606000406080004060A0004060C0004060E000408000004080
              20004080400040806000408080004080A0004080C0004080E00040A0000040A0
              200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
              200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
              200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
              20008000400080006000800080008000A0008000C0008000E000802000008020
              20008020400080206000802080008020A0008020C0008020E000804000008040
              20008040400080406000804080008040A0008040C0008040E000806000008060
              20008060400080606000806080008060A0008060C0008060E000808000008080
              20008080400080806000808080008080A0008080C0008080E00080A0000080A0
              200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
              200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
              200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
              2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
              2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
              2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
              2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
              2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
              2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
              2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFF000000FFFFFFFF0000000000FFFFFFFFFFFFFFFF0000FF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF000000FFFFFFFF
              FFFFFFFFFFFFFF00FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000
              00000000FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFF00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnDocxFontColorClick
            OnMouseDown = btnDocxFontColorMouseDown
            OnMouseUp = btnDocxFontColorMouseUp
          end
          object btnDocxBackground: TSpeedButton
            Left = 182
            Top = 116
            Width = 25
            Height = 25
            Hint = 'Background Color'
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFF070F
              FFFFFFFF0000FFFFFFF07770FFF7FFFF0000FFFFFF0888770FF47FFF0000FFFF
              F0F8888770F44FFF0000FFFF08FF888877444FFF0000FFFFF08FF80887444FFF
              0000FFFFFF08F04084444FFF0000FFFFFFF08F487444FFFF0000FFFFFFF40847
              07FFFFFF0000FFFFFFF480407FFFFFFF0000FFFFFFF48847FFFFFFFF0000FFFF
              FFF7447FFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnDocxBackgroundClick
            OnMouseDown = btnDocxBackgroundMouseDown
            OnMouseUp = btnDocxBackgroundMouseUp
          end
          object btnDocxJustify: TSpeedButton
            Left = 156
            Top = 87
            Width = 25
            Height = 25
            Hint = 'Justify'
            GroupIndex = 6
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxJustifyClick
          end
          object btnDocxRight: TSpeedButton
            Left = 131
            Top = 87
            Width = 25
            Height = 25
            Hint = 'Horizontal Right Aligment'
            GroupIndex = 6
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFF0000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000000000FFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxRightClick
          end
          object btnDocxCenter: TSpeedButton
            Left = 106
            Top = 87
            Width = 25
            Height = 25
            Hint = 'Center'
            GroupIndex = 6
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFF0000000000FFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF0000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxCenterClick
          end
          object btnDocxLeft: TSpeedButton
            Left = 81
            Top = 87
            Width = 25
            Height = 25
            Hint = 'Left'
            GroupIndex = 6
            Down = True
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FF0000000000FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FF00
              000000000000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FF0000000000FFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FF00000000000000FFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxLeftClick
          end
          object btnDocxUnderline: TSpeedButton
            Left = 158
            Top = 59
            Width = 25
            Height = 25
            Hint = 'Single Underline'
            AllowAllUp = True
            GroupIndex = 5
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFF000000000FFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFF00000FFFFFFFF0000FFFFFF000000
              0FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFF
              FF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF0000FFFFFF00FFF00FFFFFFF
              0000FFFFFF00FFF00FFFFFFF0000FFFFF0000F0000FFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxUnderlineClick
          end
          object btnDocxStrikeOut: TSpeedButton
            Left = 188
            Top = 59
            Width = 25
            Height = 25
            Hint = 'Strike Out'
            AllowAllUp = True
            GroupIndex = 3
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000F000F000000F
              FF000FFF0000FF0FFF0F0FF0F0FFFFFF0000F0000000000000000FFF0000FFF0
              F0FF000FF0FFFFFF0000FFF000FF0FF0F0FFFFFF0000FFFF0FFF0FF0F0FF0FFF
              0000FFFF0FF0000FFF000FFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxStrikeOutClick
          end
          object btnDocxItalic: TSpeedButton
            Left = 133
            Top = 59
            Width = 25
            Height = 25
            Hint = 'Italic'
            AllowAllUp = True
            GroupIndex = 2
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFFF0000FFFFFFFFFF0000FFFFFFF00FFF
              FFFFFFFF0000FFFFFFF000FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFF0000FFFF
              FFFF000FFFFFFFFF0000FFFFFFFFF00FFFFFFFFF0000FFFFFFFFF000FFFFFFFF
              0000FFFFFFFFFF00FFFFFFFF0000FFFFFFFFF0000FFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            OnClick = btnDocxItalicClick
          end
          object btnDocxBold: TSpeedButton
            Left = 108
            Top = 59
            Width = 25
            Height = 25
            Hint = 'Bold'
            AllowAllUp = True
            GroupIndex = 1
            Enabled = False
            Flat = True
            Glyph.Data = {
              66010000424D6601000000000000760000002800000014000000140000000100
              040000000000F000000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFFFF0000FFFFF0000000FFFFFFFF0000FFFFF0000000
              0FFFFFFF0000FFFFF000FFF00FFFFFFF0000FFFFF000FF000FFFFFFF0000FFFF
              F0000000FFFFFFFF0000FFFFF000F00FFFFFFFFF0000FFFFF000FF00FFFFFFFF
              0000FFFFF0000000FFFFFFFF0000FFFFF000000FFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
              FFFFFFFFFFFFFFFF0000}
            ParentShowHint = False
            ShowHint = True
            Spacing = 0
            OnClick = btnDocxBoldClick
          end
          object pbDocxFontColor: TPaintBox
            Left = 80
            Top = 77
            Width = 18
            Height = 4
            OnPaint = pbDocxFontColorPaint
          end
          object pbDocxBackground: TPaintBox
            Left = 185
            Top = 134
            Width = 18
            Height = 4
            OnPaint = pbDocxBackgroundPaint
          end
          object laDocxFontSize: TcxLabel
            Left = 14
            Top = 33
            Caption = 'Size'
            Enabled = False
            Transparent = True
          end
          object laDocxFont: TcxLabel
            Left = 14
            Top = 5
            Caption = 'Font'
            Enabled = False
            Transparent = True
          end
          object cbDocxFontSize: TComboBox
            Left = 77
            Top = 32
            Width = 55
            Height = 23
            Enabled = False
            TabOrder = 1
            OnChange = cbDocxFontSizeChange
            Items.Strings = (
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
          end
          object cbDocxFont: TComboBox
            Left = 77
            Top = 4
            Width = 150
            Height = 23
            Style = csDropDownList
            Enabled = False
            TabOrder = 0
            OnChange = cbDocxFontChange
          end
          object chkDocxBackground: TcxCheckBox
            Left = 4
            Top = 117
            Caption = 'Use Background'
            Enabled = False
            TabOrder = 2
            OnClick = chkDocxBackgroundClick
          end
          object chkDocxHighlight: TcxCheckBox
            Left = 4
            Top = 145
            Caption = 'Use Highlight'
            Enabled = False
            TabOrder = 4
            OnClick = chkDocxHighlightClick
          end
          object cbDocxHighlight: TComboBox
            Left = 119
            Top = 144
            Width = 89
            Height = 23
            Style = csDropDownList
            Enabled = False
            TabOrder = 3
            OnChange = cbDocxHighlightChange
            Items.Strings = (
              'hcNone'
              'hcYellow'
              'hcGreen'
              'hcCyan'
              'hcMagenta'
              'hcBlue'
              'hcRed'
              'hcDarkBlue'
              'hcDarkCyan'
              'hcDarkGreen'
              'hcDarkMagent'
              'hcDarkRed'
              'hcDarkYellow'
              'hcDarkGray'
              'hcLightGray'
              'hcBlack')
          end
        end
      end
    end
    object tshAccess: TcxTabSheet
      Caption = 'Access Options'
      ImageIndex = 16
      object gbAccessTableOptions: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        Caption = 'Table Options'
        TabOrder = 0
        Height = 121
        Width = 471
        object laAccessTableName: TcxLabel
          Left = 9
          Top = 52
          Caption = 'Table Name'
          Transparent = True
        end
        object laAccessPassword: TcxLabel
          Left = 9
          Top = 26
          Caption = 'Password'
          Transparent = True
        end
        object edAccessTableName: TEdit
          Left = 92
          Top = 50
          Width = 189
          Height = 23
          TabOrder = 1
        end
        object chAccessCreateTable: TcxCheckBox
          Left = 9
          Top = 82
          Caption = 'Create table if it does not exist'
          State = cbsChecked
          TabOrder = 2
          Transparent = True
        end
        object edAccessPassword: TEdit
          Left = 92
          Top = 24
          Width = 189
          Height = 23
          PasswordChar = '*'
          TabOrder = 0
        end
      end
    end
  end
  object sdExportFile: TSaveDialog
    Left = 28
    Top = 534
  end
  object imgFields: TImageList
    Left = 56
    Top = 562
    Bitmap = {
      494C010104000600780010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000008080000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000008000000000000000FF
      0000000000000080000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000800000000000FF00
      FF00000000008000800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008000000000000000FF00
      0000000000008000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      0000000000000000000000000000000000000080000000FF000000FF000000FF
      000000FF000000FF000000800000000000008080800000000000000000000000
      00000000000000000000000000000000000080008000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0080008000000000008080800000000000000000000000
      00000000000000000000000000000000000080000000FF000000FF000000FF00
      0000FF000000FF00000080000000000000008080800000000000000000000000
      0000000000000000000000000000008080000080800000FFFF00008080000000
      00000080800000FFFF0000000000000000008080800000000000000000000000
      0000000000000000000000000000008000000080000000FF0000008080000000
      00000080800000FF000000000000000000008080800000000000000000000000
      00000000000000000000000000008000800080008000FF00FF00008080000000
      000000808000FF00FF0000000000000000008080800000000000000000000000
      00000000000000000000000000008000000080000000FF000000008080000000
      000000808000FF00000000000000000000008080800000000000000000000000
      00000000000080808000000000000080800000FFFF0000FFFF00000000008080
      80000000000000FFFF0000FFFF00008080008080800000000000000000000000
      00000000000080808000000000000080000000FF000000FF0000000000008080
      80000000000000FF000000FF0000008000008080800000000000000000000000
      000000000000808080000000000080008000FF00FF00FF00FF00000000008080
      800000000000FF00FF00FF00FF00800080008080800000000000000000000000
      000000000000808080000000000080000000FF000000FF000000000000008080
      800000000000FF000000FF000000800000008080800000000000000000008080
      8000808080008080800080808000008080000080800000FFFF00008080000000
      00000080800000FFFF0000000000000000008080800000000000000000008080
      8000808080008080800080808000008000000080000000FF0000008080000000
      00000080800000FF000000000000000000008080800000000000000000008080
      80008080800080808000808080008000800080008000FF00FF00008080000000
      000000808000FF00FF0000000000000000008080800000000000000000008080
      80008080800080808000808080008000000080000000FF000000008080000000
      000000808000FF00000000000000000000008080800000000000000000000000
      0000000000008080800000000000000000000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000808000000000008080800000000000000000000000
      0000000000008080800000000000000000000080000000FF000000FF000000FF
      000000FF000000FF000000800000000000008080800000000000000000000000
      00000000000080808000000000000000000080008000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0080008000000000008080800000000000000000000000
      00000000000080808000000000000000000080000000FF000000FF000000FF00
      0000FF000000FF00000080000000000000008080800000000000000000008080
      80008080800080808000808080008080800000808000008080000000000000FF
      FF00000000000080800000000000000000008080800000000000000000008080
      80008080800080808000808080008080800000800000008000000000000000FF
      0000000000000080000000000000000000008080800000000000000000008080
      800080808000808080008080800080808000800080008000800000000000FF00
      FF00000000008000800000000000000000008080800000000000000000008080
      800080808000808080008080800080808000800000008000000000000000FF00
      0000000000008000000000000000000000008080800000000000000000000000
      0000000000008080800000000000000000008080800080808000008080000080
      8000008080000080800000000000000000008080800000000000000000000000
      0000000000008080800000000000000000008080800080808000008000000080
      0000008000000080000000000000000000008080800000000000000000000000
      0000000000008080800000000000000000008080800080808000800080008000
      8000800080008000800000000000000000008080800000000000000000000000
      0000000000008080800000000000000000008080800080808000800000008000
      0000800000008000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000008000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFC3FFC3FFC3FFC3
      00010001000100017F007F007F007F0040004000400040005A005A005A005A00
      40004000400040005B005B005B005B0040014001400140015B035B035B035B03
      40034003400340037FFB7FFB7FFB7FFB40BB40BB40BB40BB7FFB7FFB7FFB7FFB
      0003000300030003000300030003000300000000000000000000000000000000
      000000000000}
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 84
    Top = 562
  end
  object ColorDialog: TColorDialog
    CustomColors.Strings = (
      'ColorA=CE6B00'
      'ColorB=EC7A00')
    Options = [cdAnyColor]
    Left = 112
    Top = 562
  end
  object sdHTMLTemplate: TSaveDialog
    DefaultExt = 'htf'
    Filter = 'HTML template file (*.htf)|*.htf'
    Title = 'Save as HTML template'
    Left = 196
    Top = 534
  end
  object odHTMLTemplate: TOpenDialog
    DefaultExt = 'htf'
    Filter = 'HTML template file (*.htf)|*.htf'
    Title = 'Load HTML template'
    Left = 168
    Top = 534
  end
  object odHTMLCSS: TOpenDialog
    DefaultExt = 'css'
    Filter = 'Style sheets files (*.css)|*.css|All F\files (*.*)|*.*'
    Left = 224
    Top = 534
  end
  object opdHTMLBackground: TOpenPictureDialog
    Filter = 
      'All (*.gif;*.jpg;*.jpeg;*.bmp)|*.gif;*.jpg;*.jpeg;*.bmp;|CompuSe' +
      'rve GIF Image (*.gif)|*.gif|JPEG Image File (*.jpg)|*.jpg|JPEG I' +
      'mage File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp'
    Left = 252
    Top = 534
  end
  object sdOptions: TSaveDialog
    DefaultExt = 'cfg'
    Filter = 'Configuration files (*.cfg)|*.cfg|All files (*.*)|*.*'
    Left = 140
    Top = 534
  end
  object odOptions: TOpenDialog
    DefaultExt = 'cfg'
    Filter = 'Configuration files (*.cfg)|*.cfg|All files (*.*)|*.*'
    Left = 112
    Top = 534
  end
  object ilXLSStyles: TImageList
    Height = 18
    Width = 18
    Left = 28
    Top = 562
    Bitmap = {
      494C01010C000E00780012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000004800000001002000000000000051
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040404000A4A0A000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040404000000000004040
      40004040400040404000FFFFFF00404040004040400040404000A4A0A0004040
      4000404040004040400040404000A4A0A0004040400000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040404000A4A0A0004040
      4000C0404000C0404000404040004040400040E0E00040E0E000404040004040
      40004040E0004040E0004040A000404040004040400000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000A4A0A0004040
      4000C0404000C0404000C04040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      000000000000FF000000FF0000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000A4A0A0004040
      4000C0404000C0404000C04040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000800000008000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040404000A4A0A0004040
      4000C0404000C0404000C04040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000800000008000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000A4A0A0004040
      4000C0404000C0404000C04040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      000000000000FF00000000000000800080000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000000000004040
      4000C0404000C0404000C04040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      0000000000000000000000000000800080000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000A4A0A0000000
      00004040400040404000404040004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      0000000000000000000000000000000000008000800000000000000000000000
      0000000000008000800000000000FF0000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF000000000000000000000000004040400000000000A4A0
      A0004040400000000000000000004040400040E0E00040E0E00040A0A0004040
      40004040E0004040E0004040A000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000080008000000000000000
      000080008000000000000000000000000000FF00000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000040404000A4A0A0000000
      00004040400000000000000000004040400040E0E00040E0E00040A0A0004040
      4000404040004040E0004040A000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      800000000000000000000000000000000000FF000000FF000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040404000FFFFFF00A4A0
      A0004040400000000000000000004040400040E0E00040E0E00040A0A0004040
      4000000000004040400040404000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      800000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF000000000000000000000000000000000040404000FFFF
      FF004040400000000000000000004040400040E0E00040E0E000000000004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000004040
      4000404040000000000000000000000000004040400040404000404040004040
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000404040000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000404040004040
      4000404040004040400000000000404040004040400040404000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004040400000000000FFFF
      FF0000000000FFFFFF0040404000FFFFFF0000000000FFFFFF00000000004040
      40000000000000000000000000000000000000000000A4A0A000A4A0A000A4A0
      A000A4A0A000A4A0A000A4A0A000A4A0A000A4A0A000A4A0A000A4A0A000A4A0
      A000A4A0A000A4A0A000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000000000000080800000000000000000000000
      0000000000000000000000000000000000004040400000000000404040004040
      4000404040004040400040404000404040004040400040404000404040000000
      0000404040000000000000000000000000004040400040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      40004040400040404000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000000000000080800000000000000000000000
      00000000000000000000000000000000000040404000FFFFFF0040404000A4A0
      A0004040400000000000000000000000000040404000A4A0A00040404000FFFF
      FF004040400000000000000000000000000040404000FFFFFF0040E0E000FFFF
      FF0040E0E000FFFFFF0040E0E000FFFFFF0040E0E0004040400040404000FFFF
      FF0040E0E00040404000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000000000000080800000000000000000000000
      0000000000000000000000000000000000004040400000000000404040004040
      4000404040004040400040404000404040004040400040404000404040000000
      0000404040000000000000000000000000004040400040E0E000FFFFFF0040E0
      E000FFFFFF0040E0E000FFFFFF0040E0E000FFFFFF0040404000C0DCC0004040
      4000FFFFFF0040404000A4A0A000000000000000000000000000000000000000
      000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      0000000000000000000000000000000000000080800000000000000000000000
      000000000000000000000000000040404000C04040004040400000000000FFFF
      FF0000000000FFFFFF0040404000FFFFFF0000000000FFFFFF00000000004040
      40000000000000000000000000000000000040404000FFFFFF0040E0E000FFFF
      FF0040E0E000FFFFFF0040E0E000FFFFFF0040E0E0004040400040E0E000C0DC
      C0004040400040404000A4A0A00000000000000000000000000000000000FFFF
      FF000000000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF0000000000000000000000000000000000000000000000
      0000000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000008080000080800000000000000000000000
      0000000000000000000040404000C0404000C0404000C0404000404040004040
      40004040400040404000C0404000404040004040400040404000404040000000
      0000000000000000000000000000000000004040400040E0E000FFFFFF0040E0
      E000FFFFFF0040E0E000FFFFFF0040E0E000FFFFFF0040404000404040004040
      40004040400040404000A4A0A0000000000000000000000000000000000000FF
      FF00FFFFFF000000000000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00000FFFF00000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      0000000000000000000000000000008080000080800000000000000000000000
      000000000000A4A0A000C0404000C0404000C0404000C040400040A0400040A0
      400040A0400040A04000C0404000C0404000A4A0A00000000000000000000000
      0000000000000000000000000000FFFFFF0040404000FFFFFF00A4A0A00040E0
      E000FFFFFF0040E0E000FFFFFF0040E0E00040E0E000FFFFFF0040E0E000FFFF
      FF0040E0E00040404000A4A0A00000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000080800000000000000000000000
      000000000000A4A0A000C0404000C0404000C0404000C040400040A0400040A0
      400040A0400040A04000C0A04000C04040004040400000000000000000000000
      0000000000000000000000000000A4A0A00040E0E00040E0E000A4A0A000FFFF
      FF0040E0E000A4A0A00040E0E000FFFFFF00FFFFFF0040E0E000FFFFFF0040E0
      E000FFFFFF0040404000A4A0A0000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000080800000000000000000000000
      000000000000A4A0A000C0404000C04040000000000040A0400040A0400040A0
      400040A0400040A04000C0404000C04040004040400000000000000000000000
      000000000000000000000000000000000000A4A0A000FFFFFF00A4A0A00040E0
      E000A4A0A00040E0E000FFFFFF0040E0E00040E0E000FFFFFF0040E0E000FFFF
      FF0040E0E00040404000A4A0A00000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000080800000000000000000000000
      000000000000A4A0A000C04040000000000040A0400040A0400040A0400040A0
      4000C0404000C0A04000C040400040A040004040400000000000000000000000
      0000000000000000000000000000A4A0A000A4A0A000A4A0A000FFFFFF00A4A0
      A000FFFFFF0040E0E000FFFFFF0040E0E000FFFFFF0040E0E000FFFFFF0040E0
      E000FFFFFF0040404000A4A0A0000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000080800000000000000000000000
      000000000000A4A0A000C0404000000000000000000000000000C040400040A0
      400040A04000C040400040A0400040A040004040400000000000000000000000
      0000000000000000000000000000FFFFFF0040E0E000A4A0A00040E0E000FFFF
      FF00A4A0A000A4A0A000A4A0A000A4A0A0004040400040404000404040004040
      4000404040004040400000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      000000000000A4A0A000A4A0A000C0404000FFFFFF0000000000C0404000C040
      4000C0404000C040400040A0400040A04000A4A0A00000000000000000000000
      000000000000000000000000000000000000A4A0A00040E0E000A4A0A00040E0
      E000A4A0A00040E0E00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000000000C0C0C00000000000000000000000
      00000000000000000000A4A0A000FFFFFF0000000000FFFFFF000000000040A0
      400040A0400040A0400040A04000404040000000000000000000000000000000
      0000000000000000000000000000A4A0A00040E0E00000000000A4A0A000FFFF
      FF0000000000A4A0A00040E0E000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A4A0A000A4A0A000C0A04000000000000000
      00000000000040A0400040404000000000000000000000000000000000000000
      000000000000000000000000000040E0E0000000000000000000A4A0A00040E0
      E0000000000000000000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4A0A000A4A0A000A4A0A000A4A0
      A000A4A0A000A4A0A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A0A000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000080000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080000000FF000000FF0000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080000000FF000000FF000000FF000000FF00000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080000000FF000000FF000000FF000000FF00000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF000000FF000000FF000000FF000000FF000000FF000000800000000000
      0000000000000000000000000000000000000000000000000000000000000080
      000000800000008000000080000000FF000000FF000000FF000000FF00000080
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      8000000080000000800000008000000080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000008000
      0000000000000000000000000000000000000000000000000000000000000080
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000800000000000000000000000000000000000000000
      00000000000000000000000080000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000800000000000000000000000000000000000000000000000000000000080
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000800000000000000000000000000000000000000000
      00000000000000000000000080000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000080000000000000000000000000000000
      000000000000000000000000000080000000800000008000000080000000FF00
      0000FF000000FF000000FF000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000800000000000000000000000000000000000000000000000000000000080
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000800000000000000000000000000000000000000000
      00000000000000000000000080000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000080000000000000000000000000000000
      000000000000000000000000000080000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000800000000000
      0000000000000000000000000000000000000000000080000000800000008000
      000080000000FF000000FF000000FF000000FF00000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000080
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000800000000000000000000000000000000000000000
      00000000000000000000000080000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000080000000000000000000000000000000
      000000000000000000000000000080000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      000000800000008000000080000000FF000000FF000000FF000000FF00000080
      0000008000000080000000800000000000000000000000000000000000000000
      0000000000000000000000008000000080000000800000008000000080000000
      8000000080000000800000008000000080000000000000000000000000000000
      00000000000000000000000000000000000080000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080000000FF000000FF000000FF000000FF00000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000FF000000FF00
      0000FF000000FF000000FF000000FF0000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080000000FF000000FF000000FF000000FF00000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000FF00
      0000FF000000FF000000FF000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000800000008000000080000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000FF000000FF00000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080000000FF000000FF000000FF000000FF00000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000008000000080000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000480000000100010000000000600300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFF000000C001FFFFFFFFFFFFFF000000
      8000E0001FFFFFFFFF000000A0006FFFFFFFFE00010000008000681FFFFFFE00
      010000008000E99FF8000600010000008000EFEF38000600010000008000E9F7
      38000600010000008000E9FAF800060001000000A000EEFDF800060001000000
      9000EF7AF800060001000000A600EFB778000600010000009600EFCF38000600
      010000008608EFCF3800060001000000C62FEFFFFFFFFE0001000000E70FEFFF
      FFFFFE0001000000F7FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFC21FFFFF000000FFFFF8003FA8AF80
      01000000FFFFF0003F40170001000000FFFFF0003F07070001000000E007F000
      3F40170001000000C003F0003E28AF0001000000C001F0003C001F0001000000
      C000F00038007E0001000000C000F00038007E0001000000C007F00038807F00
      01000000C007F00039007E0001000000C00FF00039C07E0003000000E07FF000
      38407F03FF000000E07FF0003CA0FE49FF000000FFFFF0003E39FECDFF000000
      FFFFFFFFFF03FFCFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFC0FFFCFF000000FC0FFFFF
      FFC0FFF87F000000FC0FFFFFFFC0FFF03F000000FC0FFFFFFFC0FFE01F000000
      E001FC00FFC0FFC00F000000E001FC00FFC0FF8007000000E001FC00FE001F80
      07000000E001FC00FE001F8007000000E001FC00FE001FF03F000000E001FC00
      FF003FF03F000000FC0FFFFFFF807FF03F000000FC0FFFFFFFC0FFF03F000000
      FC0FFFFFFFE1FFF03F000000FFFFFFFFFFF3FFF03F000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
      000000000000}
  end
  object odXLSStyle: TOpenDialog
    DefaultExt = 'xst'
    Filter = 'Excel style file (*.xst)|*.xst|All files (*.*)|*.*'
    Left = 56
    Top = 534
  end
  object sdXLSStyle: TSaveDialog
    DefaultExt = 'xst'
    Filter = 'Excel style file (*.xst)|*.xst|All files (*.*)|*.*'
    Left = 84
    Top = 534
  end
  object pmTools: TPopupMenu
    Left = 280
    Top = 534
    object miLoadOptions: TMenuItem
      Caption = 'Load Export Options'
      OnClick = miLoadOptionsClick
    end
    object miSaveOptions: TMenuItem
      Caption = 'Save Export Options'
      OnClick = miSaveOptionsClick
    end
  end
  object sdRTFStyle: TSaveDialog
    DefaultExt = 'rst'
    Filter = 'RTF style file (*.rst)|*.xst|All files (*.*)|*.*'
    Left = 168
    Top = 562
  end
  object odRTFStyle: TOpenDialog
    DefaultExt = 'rst'
    Filter = 'RTF style file (*.rst)|*.xst|All files (*.*)|*.*'
    Left = 140
    Top = 562
  end
  object ClipExp: TQExport4Clipboard
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Separator = ','
    ClipboardViewer = 'Clipbrd.exe'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    Left = 28
    Top = 502
  end
  object HTMLExp: TQExport4HTML
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Header.Strings = (
      '<br>')
    Footer.Strings = (
      '<br>')
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    TableOptions.HeadersRowBgColor = clRed
    TableOptions.HeadersRowFontColor = clWhite
    TableOptions.TableBgColor = 15497728
    TableOptions.TableFontColor = clWhite
    TableOptions.OddRowBgColor = 13527808
    HTMLOptions.BackgroundColor = 10040115
    HTMLOptions.LinkColor = 8253289
    HTMLOptions.VLinkColor = clFuchsia
    HTMLOptions.ALinkColor = clLime
    HTMLOptions.TextFont.Charset = DEFAULT_CHARSET
    HTMLOptions.TextFont.Color = clWhite
    HTMLOptions.TextFont.Height = -11
    HTMLOptions.TextFont.Name = 'Arial'
    HTMLOptions.TextFont.Style = []
    HTMLOptions.DefaultOptions = [doFontSize]
    Navigation.IndexLinkTitle = 'Index'
    Navigation.FirstLinkTitle = 'First'
    Navigation.PriorLinkTitle = 'Prior'
    Navigation.NextLinkTitle = 'Next'
    Navigation.LastLinkTitle = 'Last'
    Left = 56
    Top = 502
  end
  object LaTeXExp: TQExport4LaTeX
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    Options.DocumentParams = 'a4paper'
    Options.CodePage = 1251
    Options.Languages = 'english'
    Left = 84
    Top = 502
  end
  object ASCIIExp: TQExport4ASCII
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    CSVComma = ','
    Left = 112
    Top = 502
  end
  object XLSExp: TQExport4XLS
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    Options.PageFooter = 'Page &P of &N'
    Options.SheetTitle = 'Sheet 1'
    Options.CaptionsFormat.Font.Style = [xfsBold]
    Options.HyperlinkFormat.Font.Color = clrBlue
    Options.HyperlinkFormat.Font.Underline = fulSingle
    Options.NoteFormat.Alignment.Horizontal = halLeft
    Options.NoteFormat.Alignment.Vertical = valTop
    Options.NoteFormat.Font.Size = 8
    Options.NoteFormat.Font.Style = [xfsBold]
    Options.NoteFormat.Font.Name = 'Tahoma'
    FieldFormats = <>
    StripStyles = <>
    Hyperlinks = <>
    Notes = <>
    Charts = <>
    Sheets = <>
    Pictures = <>
    Images = <>
    Cells = <>
    Aggregates = <>
    MergedCells = <>
    DefRowHeight = 12.750000000000000000
    Left = 140
    Top = 502
  end
  object PDFExp: TQExport4PDF
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    Options.PageOptions.MarginLeft = 1.170000000000000000
    Options.PageOptions.MarginRight = 0.569999999999999900
    Options.PageOptions.MarginTop = 0.780000000000000000
    Options.PageOptions.MarginBottom = 0.780000000000000000
    Options.HeaderFont.UserFont.Charset = DEFAULT_CHARSET
    Options.HeaderFont.UserFont.Color = clWindowText
    Options.HeaderFont.UserFont.Height = -13
    Options.HeaderFont.UserFont.Name = 'Arial'
    Options.HeaderFont.UserFont.Style = []
    Options.HeaderFont.Charset = ANSI_CHARSET
    Options.CaptionFont.UserFont.Charset = DEFAULT_CHARSET
    Options.CaptionFont.UserFont.Color = clWindowText
    Options.CaptionFont.UserFont.Height = -13
    Options.CaptionFont.UserFont.Name = 'Arial'
    Options.CaptionFont.UserFont.Style = []
    Options.CaptionFont.Charset = ANSI_CHARSET
    Options.DataFont.UserFont.Charset = DEFAULT_CHARSET
    Options.DataFont.UserFont.Color = clWindowText
    Options.DataFont.UserFont.Height = -13
    Options.DataFont.UserFont.Name = 'Arial'
    Options.DataFont.UserFont.Style = []
    Options.DataFont.Charset = ANSI_CHARSET
    Options.FooterFont.UserFont.Charset = DEFAULT_CHARSET
    Options.FooterFont.UserFont.Color = clWindowText
    Options.FooterFont.UserFont.Height = -13
    Options.FooterFont.UserFont.Name = 'Arial'
    Options.FooterFont.UserFont.Style = []
    Options.FooterFont.Charset = ANSI_CHARSET
    Left = 168
    Top = 502
  end
  object SQLExp: TQExport4SQL
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = '.'
    Formats.ThousandSeparator = '.'
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.NULLString = 'null'
    Formats.IntegerFormat = '######0'
    Formats.FloatFormat = '######0.########'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '######0.########'
    CommitStatement = 'COMMIT WORK;;;;;;;;;'
    NullValue = 'null'
    IBDialect = 3
    BinaryAsHex = False
    Left = 196
    Top = 502
  end
  object XMLExp: TQExport4XML
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Options.Version = '1.0'
    Options.ExportXSDSchema = False
    Left = 224
    Top = 502
  end
  object DBFExp: TQExport4DBF
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    ExportTimeAsStr = False
    NullValue = 'null'
    Left = 252
    Top = 502
  end
  object RTFExp: TQExport4RTF
    About = '(About EMS QuickExport)'
    _Version = '4.2'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    Options.CaptionStyle.Font.Charset = DEFAULT_CHARSET
    Options.CaptionStyle.Font.Color = clBlack
    Options.CaptionStyle.Font.Height = -13
    Options.CaptionStyle.Font.Name = 'Arial'
    Options.CaptionStyle.Font.Style = [fsBold]
    Options.CaptionStyle.AllowHighlight = True
    Options.CaptionStyle.Alignment = talCenter
    Options.DataStyle.Font.Charset = DEFAULT_CHARSET
    Options.DataStyle.Font.Color = clBlack
    Options.DataStyle.Font.Height = -13
    Options.DataStyle.Font.Name = 'Arial'
    Options.DataStyle.Font.Style = []
    Options.DataStyle.AllowHighlight = True
    Options.StripStyles = <>
    Options.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    Options.HeaderStyle.Font.Color = clBlack
    Options.HeaderStyle.Font.Height = -13
    Options.HeaderStyle.Font.Name = 'Arial'
    Options.HeaderStyle.Font.Style = []
    Options.HeaderStyle.AllowHighlight = True
    Options.FooterStyle.Font.Charset = DEFAULT_CHARSET
    Options.FooterStyle.Font.Color = clBlack
    Options.FooterStyle.Font.Height = -13
    Options.FooterStyle.Font.Name = 'Arial'
    Options.FooterStyle.Font.Style = []
    Options.FooterStyle.AllowHighlight = True
    Left = 280
    Top = 502
  end
  object ODSExp: TQExport4ODS
    About = '(About EMS AdvancedExport)'
    _Version = '3.40'
    SheetName = 'Sheet1'
    ODSOptions.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    ODSOptions.HeaderStyle.Font.Color = clBlack
    ODSOptions.HeaderStyle.Font.Height = -13
    ODSOptions.HeaderStyle.Font.Name = 'Arial'
    ODSOptions.HeaderStyle.Font.Style = []
    ODSOptions.FooterStyle.Font.Charset = DEFAULT_CHARSET
    ODSOptions.FooterStyle.Font.Color = clBlack
    ODSOptions.FooterStyle.Font.Height = -13
    ODSOptions.FooterStyle.Font.Name = 'Arial'
    ODSOptions.FooterStyle.Font.Style = []
    ODSOptions.CaptionRowStyle.Font.Charset = DEFAULT_CHARSET
    ODSOptions.CaptionRowStyle.Font.Color = clBlack
    ODSOptions.CaptionRowStyle.Font.Height = -13
    ODSOptions.CaptionRowStyle.Font.Name = 'Arial'
    ODSOptions.CaptionRowStyle.Font.Style = []
    ODSOptions.DataStyle.Font.Charset = DEFAULT_CHARSET
    ODSOptions.DataStyle.Font.Color = clBlack
    ODSOptions.DataStyle.Font.Height = -13
    ODSOptions.DataStyle.Font.Name = 'Arial'
    ODSOptions.DataStyle.Font.Style = []
    ODSOptions.StripStylesList = <>
    Left = 308
    Top = 502
  end
  object ODTExp: TQExport4ODT
    About = '(About EMS AdvancedExport)'
    _Version = '3.40'
    TableName = 'Table1'
    ODTOptions.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    ODTOptions.HeaderStyle.Font.Color = clBlack
    ODTOptions.HeaderStyle.Font.Height = -13
    ODTOptions.HeaderStyle.Font.Name = 'Arial'
    ODTOptions.HeaderStyle.Font.Style = []
    ODTOptions.FooterStyle.Font.Charset = DEFAULT_CHARSET
    ODTOptions.FooterStyle.Font.Color = clBlack
    ODTOptions.FooterStyle.Font.Height = -13
    ODTOptions.FooterStyle.Font.Name = 'Arial'
    ODTOptions.FooterStyle.Font.Style = []
    ODTOptions.CaptionRowStyle.Font.Charset = DEFAULT_CHARSET
    ODTOptions.CaptionRowStyle.Font.Color = clBlack
    ODTOptions.CaptionRowStyle.Font.Height = -13
    ODTOptions.CaptionRowStyle.Font.Name = 'Arial'
    ODTOptions.CaptionRowStyle.Font.Style = []
    ODTOptions.DataStyle.Font.Charset = DEFAULT_CHARSET
    ODTOptions.DataStyle.Font.Color = clBlack
    ODTOptions.DataStyle.Font.Height = -13
    ODTOptions.DataStyle.Font.Name = 'Arial'
    ODTOptions.DataStyle.Font.Style = []
    ODTOptions.StripStylesList = <>
    ODTOptions.Border.BorderStyle = bsODFSolid
    Left = 336
    Top = 502
  end
  object XlsxExp: TQExport4Xlsx
    About = '(About EMS AdvancedExport)'
    _Version = '3.40'
    Formats.DecimalSeparator = ','
    Formats.ThousandSeparator = #160
    Formats.DateSeparator = '.'
    Formats.TimeSeparator = ':'
    Formats.BooleanTrue = 'true'
    Formats.BooleanFalse = 'false'
    Formats.IntegerFormat = '#'#160'###'#160'##0'
    Formats.FloatFormat = '#'#160'###'#160'##0,00'
    Formats.DateFormat = 'dd.MM.yyyy'
    Formats.TimeFormat = 'h:mm'
    Formats.DateTimeFormat = 'dd.MM.yyyy h:mm'
    Formats.CurrencyFormat = '#,###,##0.00 '#8364
    SheetName = 'sheet1'
    XlsxOptions.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.HeaderStyle.Font.Color = clBlack
    XlsxOptions.HeaderStyle.Font.Height = -15
    XlsxOptions.HeaderStyle.Font.Name = 'Calibri'
    XlsxOptions.HeaderStyle.Font.Style = []
    XlsxOptions.CaptionRowStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.CaptionRowStyle.Font.Color = clBlack
    XlsxOptions.CaptionRowStyle.Font.Height = -15
    XlsxOptions.CaptionRowStyle.Font.Name = 'Calibri'
    XlsxOptions.CaptionRowStyle.Font.Style = []
    XlsxOptions.DataStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.DataStyle.Font.Color = clBlack
    XlsxOptions.DataStyle.Font.Height = -15
    XlsxOptions.DataStyle.Font.Name = 'Calibri'
    XlsxOptions.DataStyle.Font.Style = []
    XlsxOptions.FooterStyle.Font.Charset = DEFAULT_CHARSET
    XlsxOptions.FooterStyle.Font.Color = clBlack
    XlsxOptions.FooterStyle.Font.Height = -15
    XlsxOptions.FooterStyle.Font.Name = 'Calibri'
    XlsxOptions.FooterStyle.Font.Style = []
    XlsxOptions.StripStylesList = <>
    Left = 364
    Top = 502
  end
  object DocxExp: TQExport4Docx
    About = '(About EMS AdvancedExport)'
    _Version = '3.40'
    DocxOptions.HeaderStyle.Font.Charset = DEFAULT_CHARSET
    DocxOptions.HeaderStyle.Font.Color = clBlack
    DocxOptions.HeaderStyle.Font.Height = -15
    DocxOptions.HeaderStyle.Font.Name = 'Calibri'
    DocxOptions.HeaderStyle.Font.Style = []
    DocxOptions.CaptionRowStyle.Font.Charset = DEFAULT_CHARSET
    DocxOptions.CaptionRowStyle.Font.Color = clBlack
    DocxOptions.CaptionRowStyle.Font.Height = -15
    DocxOptions.CaptionRowStyle.Font.Name = 'Calibri'
    DocxOptions.CaptionRowStyle.Font.Style = []
    DocxOptions.DataStyle.Font.Charset = DEFAULT_CHARSET
    DocxOptions.DataStyle.Font.Color = clBlack
    DocxOptions.DataStyle.Font.Height = -15
    DocxOptions.DataStyle.Font.Name = 'Calibri'
    DocxOptions.DataStyle.Font.Style = []
    DocxOptions.StripStylesList = <>
    DocxOptions.FooterStyle.Font.Charset = DEFAULT_CHARSET
    DocxOptions.FooterStyle.Font.Color = clBlack
    DocxOptions.FooterStyle.Font.Height = -15
    DocxOptions.FooterStyle.Font.Name = 'Calibri'
    DocxOptions.FooterStyle.Font.Style = []
    Left = 392
    Top = 502
  end
  object odODSStyle: TOpenDialog
    DefaultExt = 'dst'
    Filter = 'ODS style file (*.dst)|*.dst|All files (*.*)|*.*'
    Left = 195
    Top = 563
  end
  object odODTStyle: TOpenDialog
    DefaultExt = 'dtt'
    Filter = 'ODT style file (*.dtt)|*.dtt|All files (*.*)|*.*'
    Left = 222
    Top = 563
  end
  object sdODSStyle: TSaveDialog
    DefaultExt = 'dst'
    Filter = 'ODS style file (*.dst)|*.dst|All files (*.*)|*.*'
    Left = 249
    Top = 563
  end
  object sdODTStyle: TSaveDialog
    DefaultExt = 'dtt'
    Filter = 'ODT style file (*.dtt)|*.dtt|All files (*.*)|*.*'
    Left = 276
    Top = 564
  end
end
