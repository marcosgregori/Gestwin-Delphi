object frmMain: TfrmMain
  Left = 288
  Top = 207
  Caption = 'runtime'
  ClientHeight = 442
  ClientWidth = 626
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 600
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 626
    Height = 423
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'Panel1'
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 3
      Top = 3
      Width = 620
      Height = 417
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 1
      Caption = 'Panel2'
      ParentBackground = False
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 1
        Top = 1
        Width = 618
        Height = 415
        ActivePage = tbsRichEdit
        Align = alClient
        Images = ImageList1
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Convert RTF files to XHTML'
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Splitter2: TSplitter
            Left = 0
            Top = 177
            Width = 610
            Height = 6
            Cursor = crVSplit
            Align = alTop
            ExplicitWidth = 543
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 610
            Height = 177
            Align = alTop
            BorderWidth = 3
            Caption = ' '
            ParentBackground = False
            TabOrder = 0
            object Splitter1: TSplitter
              Left = 279
              Top = 4
              Width = 6
              Height = 169
            end
            object DirectoryListBox1: TDirectoryListBox
              Left = 4
              Top = 4
              Width = 275
              Height = 169
              Align = alLeft
              FileList = FileListBox1
              ItemHeight = 16
              TabOrder = 0
            end
            object FileListBox1: TFileListBox
              Left = 285
              Top = 4
              Width = 321
              Height = 169
              Align = alClient
              ItemHeight = 13
              Mask = '*.rtf'
              PopupMenu = PopupMenu1
              TabOrder = 1
              OnDblClick = startConversion
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 183
            Width = 610
            Height = 203
            Align = alClient
            BorderWidth = 3
            Caption = ' '
            ParentBackground = False
            TabOrder = 1
            object memLog: TMemo
              Left = 4
              Top = 4
              Width = 602
              Height = 195
              Align = alClient
              Lines.Strings = (
                
                  'To convert a RTF file, double-click the file name. The XHTML fil' +
                  'e will be opened in the default '
                'browser.')
              ScrollBars = ssVertical
              TabOrder = 0
            end
          end
        end
        object tbsRichEdit: TTabSheet
          Caption = 'RichEdit to XHTML'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel10: TPanel
            Left = 0
            Top = 41
            Width = 610
            Height = 345
            Align = alClient
            BevelInner = bvLowered
            BorderWidth = 3
            Caption = ' '
            TabOrder = 0
            object RichEdit2: TRichEdit
              Left = 5
              Top = 5
              Width = 600
              Height = 335
              Align = alClient
              BorderStyle = bsNone
              BorderWidth = 3
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Lines.Strings = (
                'RichEdit to (X)HTML conversion'
                
                  'To change the text style in this RichEdit, right-click to open t' +
                  'he context menu.'
                
                  'To add a hyperlink for "ScroogeXHTML", read the documentation ;-' +
                  ')')
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 610
            Height = 41
            Align = alTop
            Caption = ' '
            ParentBackground = False
            TabOrder = 1
            object Button1: TButton
              Left = 16
              Top = 8
              Width = 75
              Height = 25
              Caption = 'Convert'
              TabOrder = 0
              OnClick = ConvertRichEdit
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Settings'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 610
            Height = 386
            Align = alClient
            BevelOuter = bvNone
            BorderWidth = 3
            Caption = 'Panel6'
            TabOrder = 0
            object PageControl2: TPageControl
              Left = 3
              Top = 3
              Width = 604
              Height = 380
              ActivePage = TabSheet3
              Align = alClient
              TabOrder = 0
              object TabSheet3: TTabSheet
                Caption = 'General'
                ImageIndex = 1
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object GridPanel1: TGridPanel
                  Left = 0
                  Top = 0
                  Width = 596
                  Height = 352
                  Align = alClient
                  BevelOuter = bvNone
                  Caption = 'GridPanel1'
                  ColumnCollection = <
                    item
                      Value = 16.666666666666680000
                    end
                    item
                      Value = 83.333333333333310000
                    end>
                  ControlCollection = <
                    item
                      Column = 0
                      Control = Label2
                      Row = 0
                    end
                    item
                      Column = 1
                      Control = cbxof
                      Row = 0
                    end
                    item
                      Column = 1
                      Control = CbxConvertToPlainText
                      Row = 1
                    end
                    item
                      Column = 0
                      Control = Label8
                      Row = 2
                    end
                    item
                      Column = 1
                      Control = ediHTMLFile
                      Row = 2
                    end
                    item
                      Column = 1
                      Control = CbxConvertEmptyParagraphs
                      Row = 3
                    end
                    item
                      Column = 1
                      Control = cbxSpaces
                      Row = 4
                    end
                    item
                      Column = 1
                      Control = cbxDebugMode
                      Row = 5
                    end
                    item
                      Column = 1
                      Control = cbxPictures
                      Row = 6
                    end>
                  ParentBackground = False
                  RowCollection = <
                    item
                      Value = 100.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end
                    item
                      SizeStyle = ssAbsolute
                      Value = 31.000000000000000000
                    end>
                  ShowCaption = False
                  TabOrder = 0
                  object Label2: TLabel
                    AlignWithMargins = True
                    Left = 23
                    Top = 3
                    Width = 73
                    Height = 13
                    Align = alTop
                    Alignment = taRightJustify
                    Caption = 'Output format:'
                  end
                  object cbxof: TListBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 3
                    Width = 491
                    Height = 129
                    Align = alClient
                    ItemHeight = 13
                    TabOrder = 0
                  end
                  object CbxConvertToPlainText: TCheckBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 138
                    Width = 491
                    Height = 25
                    Align = alClient
                    Caption = 'ConvertToPlainText'
                    TabOrder = 1
                    Visible = False
                  end
                  object Label8: TLabel
                    AlignWithMargins = True
                    Left = 3
                    Top = 169
                    Width = 93
                    Height = 28
                    Align = alClient
                    Alignment = taRightJustify
                    Caption = 'Output file name:'
                    ExplicitLeft = 12
                    ExplicitWidth = 84
                    ExplicitHeight = 13
                  end
                  object ediHTMLFile: TEdit
                    AlignWithMargins = True
                    Left = 102
                    Top = 169
                    Width = 491
                    Height = 21
                    Align = alTop
                    TabOrder = 2
                  end
                  object CbxConvertEmptyParagraphs: TCheckBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 200
                    Width = 491
                    Height = 25
                    Hint = 
                      'Set this property to True to replace empty paragraphs (where the' +
                      ' opening <p> tag is followed by the closing </p> tag) by a line ' +
                      'break tag (<br />). '
                    Align = alClient
                    Caption = 
                      'ConvertEmptyParagraphs (caution! works only with TRANSITIONAL do' +
                      'ctypes)'
                    TabOrder = 3
                  end
                  object cbxSpaces: TCheckBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 231
                    Width = 491
                    Height = 25
                    Align = alClient
                    Caption = 'Convert multiple spaces to &&nbsp;'
                    TabOrder = 4
                  end
                  object cbxDebugMode: TCheckBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 262
                    Width = 491
                    Height = 25
                    Align = alClient
                    Caption = 'Debug Mode'
                    TabOrder = 5
                  end
                  object cbxPictures: TCheckBox
                    AlignWithMargins = True
                    Left = 102
                    Top = 293
                    Width = 491
                    Height = 25
                    Align = alClient
                    Caption = 'ConvertPictures'
                    TabOrder = 6
                    OnClick = cbxHyperClick
                  end
                end
              end
              object TabSheet8: TTabSheet
                Caption = 'Fonts'
                ImageIndex = 4
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object VleFonts: TValueListEditor
                  Left = 0
                  Top = 19
                  Width = 596
                  Height = 333
                  Align = alClient
                  KeyOptions = [keyEdit, keyAdd, keyDelete, keyUnique]
                  TabOrder = 0
                  TitleCaptions.Strings = (
                    'Font name starts with'
                    'Replace by')
                  ColWidths = (
                    206
                    384)
                end
                object Panel3: TPanel
                  Left = 0
                  Top = 0
                  Width = 596
                  Height = 19
                  Align = alTop
                  Alignment = taLeftJustify
                  BevelOuter = bvNone
                  Caption = 'Editor for ReplaceFonts property'
                  ParentBackground = False
                  TabOrder = 1
                end
              end
              object TabSheet2: TTabSheet
                Caption = 'Hyperlinks'
                DoubleBuffered = True
                ParentDoubleBuffered = False
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object cbxHyper: TCheckBox
                  Left = 11
                  Top = 17
                  Width = 129
                  Height = 13
                  Caption = 'ConvertHyperlinks'
                  Checked = True
                  State = cbChecked
                  TabOrder = 0
                  OnClick = cbxHyperClick
                end
                object pnlHyper: TPanel
                  Left = 0
                  Top = 38
                  Width = 583
                  Height = 278
                  Align = alCustom
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  BevelOuter = bvNone
                  Caption = ' '
                  ParentBackground = False
                  TabOrder = 1
                  object Label11: TLabel
                    Left = 14
                    Top = 112
                    Width = 60
                    Height = 13
                    Caption = 'HyperlinkList'
                  end
                  object cbxOpenInNewBrowser: TCheckBox
                    Left = 11
                    Top = 32
                    Width = 126
                    Height = 17
                    Caption = 'OpenInNewBrowser'
                    TabOrder = 0
                  end
                  object cbxUseHyperlinkList: TCheckBox
                    Left = 11
                    Top = 80
                    Width = 97
                    Height = 17
                    Caption = 'UseHyperlinkList'
                    TabOrder = 1
                  end
                  object cbxReplaceEMailLinks: TCheckBox
                    Left = 11
                    Top = 56
                    Width = 134
                    Height = 17
                    Caption = 'ReplaceEMailLinks'
                    TabOrder = 2
                  end
                  object memHyperlinkList: TMemo
                    Left = 11
                    Top = 128
                    Width = 246
                    Height = 136
                    Align = alCustom
                    Anchors = [akLeft, akTop, akBottom]
                    ScrollBars = ssBoth
                    TabOrder = 3
                  end
                end
              end
              object TabSheet6: TTabSheet
                Caption = 'HTML wrapper'
                ImageIndex = 2
                ExplicitLeft = 0
                ExplicitTop = 0
                ExplicitWidth = 0
                ExplicitHeight = 0
                object cbxAddOuterHTML: TCheckBox
                  Left = 11
                  Top = 15
                  Width = 406
                  Height = 17
                  Caption = 
                    'AddOuterHTML (generate <html>...</html> and <body>...</body> tag' +
                    's)'
                  Checked = True
                  State = cbChecked
                  TabOrder = 0
                  OnClick = cbxAddOuterHTMLClick
                end
                object Panel7: TPanel
                  Left = 0
                  Top = 81
                  Width = 596
                  Height = 271
                  Align = alBottom
                  BevelOuter = bvNone
                  Caption = ' '
                  TabOrder = 1
                  object Label1: TLabel
                    Left = 11
                    Top = 8
                    Width = 69
                    Height = 13
                    Caption = 'Document title'
                  end
                  object Label4: TLabel
                    Left = 11
                    Top = 128
                    Width = 83
                    Height = 13
                    Caption = 'Style sheet name'
                  end
                  object Label5: TLabel
                    Left = 11
                    Top = 38
                    Width = 85
                    Height = 13
                    Caption = 'META tag: author'
                  end
                  object Label6: TLabel
                    Left = 11
                    Top = 68
                    Width = 105
                    Height = 13
                    Caption = 'META tag: description'
                  end
                  object Label7: TLabel
                    Left = 11
                    Top = 98
                    Width = 99
                    Height = 13
                    Caption = 'META tag: keywords'
                  end
                  object Label9: TLabel
                    Left = 11
                    Top = 230
                    Width = 107
                    Height = 13
                    Caption = 'Optional <meta> tags'
                  end
                  object Label3: TLabel
                    Left = 11
                    Top = 158
                    Width = 72
                    Height = 13
                    Caption = 'Embedded CSS'
                  end
                  object ediTitle: TEdit
                    Left = 166
                    Top = 5
                    Width = 320
                    Height = 21
                    TabOrder = 0
                    Text = 'ediTitle'
                  end
                  object ediStyle: TEdit
                    Left = 166
                    Top = 125
                    Width = 320
                    Height = 21
                    TabOrder = 4
                    Text = 'default.css'
                  end
                  object ediAuthor: TEdit
                    Left = 166
                    Top = 35
                    Width = 320
                    Height = 21
                    TabOrder = 1
                    Text = 'Michael Justin'
                  end
                  object ediDescription: TEdit
                    Left = 166
                    Top = 65
                    Width = 320
                    Height = 21
                    TabOrder = 2
                    Text = 'document description ...'
                  end
                  object ediKeywords: TEdit
                    Left = 166
                    Top = 95
                    Width = 320
                    Height = 21
                    TabOrder = 3
                    Text = 'RTF, XHTML, convert'
                  end
                  object cbxMetaDate: TCheckBox
                    Left = 166
                    Top = 226
                    Width = 275
                    Height = 17
                    Caption = 'Meta Date (document generation date and time)'
                    TabOrder = 5
                  end
                  object cbxMetaGenerator: TCheckBox
                    Left = 166
                    Top = 248
                    Width = 259
                    Height = 17
                    Caption = 'Meta Generator (converter name and version)'
                    TabOrder = 6
                  end
                  object MemCss: TMemo
                    Left = 166
                    Top = 156
                    Width = 320
                    Height = 64
                    Lines.Strings = (
                      'BODY, P {'
                      '  margin-bottom:0px;margin-top:0px;'
                      ' }')
                    ScrollBars = ssVertical
                    TabOrder = 7
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 423
    Width = 626
    Height = 19
    Panels = <>
    SimplePanel = True
    SizeGrip = False
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 362
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    Left = 426
    Top = 200
    object OpenwithNotepad1: TMenuItem
      Caption = 'Open with Notepad'
      OnClick = OpenwithNotepad1Click
    end
  end
  object ImageList1: TImageList
    Left = 498
    Top = 100
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B58C730084634200841000008410000084100000841000008463
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AD311800C6210000FF845A00E7ADA500E7ADA500E7ADA500E7ADA500FF6B
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C621
      0000FF290000E794840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6B3900FF29
      0000DE84630000000000B58C730063312900633129008C6B5A00846342006331
      29006331290063312900734A3900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6B3900CE63
      290000000000DE846300C6210000FF290000FF6B3900FF6B3900FF290000C621
      0000FF6B3900E7948400C6210000B58C73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF6B3900FF290000B58C
      730000000000FF6B3900FF290000DE8463000000000000000000E7948400C621
      00000000000000000000FF6B3900841000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF845A00C62100000000
      000000000000FF6B3900C6210000000000000000000000000000FF6B39008410
      00000000000000000000FF6B3900841000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF845A00841000000000
      000000000000FF6B390084100000000000000000000000000000FF6B39008410
      00000000000000000000FF845A00841000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF946B00C62100000000
      000000000000FF6B390084100000000000000000000000000000FF6B39008410
      00000000000000000000FF845A00841000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7948400FF2900009C84
      840000000000E7948400FF2900008C6B5A000000000000000000FF2900008410
      00000000000000000000FF6B3900C62100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6B39008463
      42000000000000000000E7948400C621000063312900AD311800FF2900008410
      00000000000000000000FF290000846342000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7948400C621
      0000948C8C000000000000000000E7948400FF946B00E7948400E7948400FF29
      000000000000FF6B3900FF290000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E794
      8400C62100009C84840000000000000000000000000000000000000000000000
      0000FF6B3900FF290000E7948400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E7948400FF290000AD311800847B7300948C8C00948C8C008C6B5A00AD31
      1800FF290000E794840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7948400FF6B3900FF6B3900FF6B3900FF845A00E794
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AD7B6300AD7B6300AD7B6300AD7B63000000000000000000000000000000
      00000000000000000000000000000000000000000000ADADA5008C8C8C00636B
      6300BDB5AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD7B
      6300DEA57300EFC69400E7C6A500DEB58C00AD7B6300AD7B6300AD7B6300AD7B
      63000000000000000000000000000000000000000000ADA59C009C522100844A
      18006B4218005A311800424A4200BDB5AD000000000000000000000000000000
      00000000000000000000000000000000000000000000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE6300000000000021ADD60029B5DE0018AD
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD7B6300DEB5
      8C00EFB57300EFC69C00EFD6B500EFCEA500C69C6B00734A42008C524A00AD7B
      6300AD7B6300AD7B6300000000000000000000000000A59C9400AD4A0000DEAD
      7300EFB58C00C67B39009C5221005A311800424A4200BDB5AD00000000000000
      00000000000000000000000000000000000000000000CE630000FFFFFF00FFFF
      FF00FFFFF700FFF7E700FFEFD600FFE7C600FFD6AD00FFD6AD00F7D6AD00FFD6
      AD00FFD6AD00FFD6AD00FFD6AD00CE6300000000000021ADD6009CDEEF0084EF
      FF0042C6E70018ADD60010A5C60010A5C60010A5C60000000000000000000000
      00000000000000000000000000000000000000000000AD7B6300E7BD9400EFC6
      8C00EFB57300EFC6A500F7E7CE00F7D6AD00C69C8400734A4200734A4200CEA5
      7300EFBD8C00D6A58400AD7B630000000000000000009C948C00B5520800E7BD
      9400FFEFD600FFDEC600FFDEB500F7BD8400C68442009C5221004A2918000000
      00000000000000000000000000000000000000000000CE630000FFFFFF00BDC6
      C600BDC6C600BDC6C600BDC6C600BDC6C600BDC6C600BDC6C600BDC6C600BDC6
      C600BDC6C600BDC6C600FFD6AD00CE6300000000000021ADD6004ABDE7009CFF
      FF0094FFFF006BDEF7006BDEF7006BDEF7006BDEF70042C6E70018ADD60010A5
      C60000000000000000000000000000000000AD7B6300F7CE9C00F7D69400EFC6
      8C00EFB57300F7CEAD00FFEFDE00FFE7C600CEA58C00734A4200734A4200CEA5
      7300EFBD8C00DEB58400AD7B63000000000000000000948C7300B5520800E7C6
      AD00FFE7D600FFDEC600FFDEB500FFE7BD00FFD68400FFAD52006B3108009494
      94000000000000000000000000000000000000000000CE630000FFFFFF00FFFF
      FF002929290052524A00A5ADA500FFF7E700FFE7C600FFE7C600FFD6AD00FFD6
      AD00F7D6AD00FFD6AD00FFD6AD00CE6300000000000021ADD6004ABDE700ADFF
      FF008CF7FF008CEFFF008CEFFF008CEFFF006BDEF7006BDEF7006BDEF70042C6
      EF0018ADD600000000000000000000000000AD7B6300F7D69C00F7D69400F7C6
      8C00F7B56B00F7CEAD00FFF7EF00FFEFDE00CEAD9C006B423900734A4200CEA5
      7300EFBD8C00DEB58400AD7B63000000000000000000948C7300BD631000E7CE
      B500FFEFD600CED6CE00009CCE00FFDEB500FFC65200F7B56B005A3118008484
      84000000000000000000000000000000000000000000CE630000FFFFFF00BDC6
      C60052524A00424239004A5A5A00949C9400BDC6C600BDC6C600BDC6C600BDC6
      C600BDC6C600BDC6C600FFD6AD00CE6300000000000021ADD60021ADD600ADDE
      EF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEFFF006BDEF7006BDE
      F70042C6EF00000000000000000000000000AD7B6300F7D69C00FFD69400E7BD
      9400B5A59400F7CEAD00FFFFF700FFF7EF00DEC6B5009463520084524200CEA5
      8400EFBD8C00DEB58400AD7B63000000000000000000948C7300BD631000FFDE
      C600DEE7DE00009CCE00009CCE00BDBDA50094946B00D6945A00844A10008484
      84009494940000000000000000000000000000000000CE630000FFFFFF00FFFF
      FF00FFFFFF0052737300427BA50010526B00845A4A00A5ADA500FFE7C600FFE7
      C600FFD6AD00FFD6AD00FFD6AD00CE6300000000000021ADD6006BDEF70021AD
      D6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEFFF008CEFFF006BDE
      F7006BDEF70010A5C6000000000000000000AD7B6300FFD69400D6CEA5004AA5
      E7001884F70084ADDE00FFFFEF00FFF7EF00FFF7E700F7E7CE00E7C6A500E7C6
      9C00E7BD9400DEB58400AD7B630000000000000000009C846300C66B2100FFE7
      D60031ADD600BDD6DE00ADD6D600009CCE00A59C8400EFB58C00FFCE9400C684
      420094633100636B6300949494000000000000000000CE630000FFFFFF00BDC6
      C600BDC6C6005273730039739400947B7300BD6B3100845A4A00949C9400BDC6
      C600BDC6C600ADB5BD00FFD6AD00CE6300000000000021ADD60094F7FF0021AD
      D600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEFFF008CEFFF006BDE
      F7006BDEF70031BDE7000000000000000000AD7B63009CC6C60039B5FF0029AD
      FF00299CFF001084FF0084BDF700FFFFEF00FFF7EF00FFEFDE00F7E7CE00EFD6
      B500EFC69C00DEB58C00A57B730000000000000000009C846300C66B2100F7EF
      E700F7F7EF00FFF7E700DEE7DE0031A5BD00FFE7C600E7AD6B00C6844200FFCE
      9400FFCE9400BD946300525A8400636B630000000000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF007B6B7300EFBD8400EFA55A00BD733100845A4A00A5AD
      A500FFE7C600FFD6AD00FFD6AD00CE6300000000000021ADD6009CFFFF006BDE
      F70021ADD60010A5C60010A5C60010A5C600ADDEEF008CF7FF0084EFFF0084EF
      FF006BDEF7006BDEF70010A5C60000000000399CF70039A5FF0039ADFF0039B5
      FF0031A5FF002194FF001084FF008CC6F700FFFFEF00FFF7EF00FFEFDE00FFE7
      C600DEC6B500948C94009C7B840000000000000000009C846300C66B2100FFF7
      EF00FFF7F700FFF7E700FFF7E70042ADCE00F7EFDE00E7BD94005A3110008C7B
      5A00EFB58C00AD9C9C00295AD6004252B50000000000CE630000FFFFFF00BDC6
      C600BDC6C600BDC6C600AD7B6B00F7D6A500F7C68C00EFA55200BD733100845A
      4A00949C9400BDC6C600FFD6AD00CE6300000000000021ADD6009CFFFF0094F7
      FF006BDEF7006BDEF7006BDEF70063DEF70021ADD600ADDEEF0084EFFF0084EF
      FF0084EFFF0094EFFF0029A5D6000000000000000000399CFF0039A5FF0039AD
      FF0039B5FF0031A5FF002194FF001084FF008CC6F700FFFFEF00FFFFEF00D6D6
      D6006B7BAD00737394000000000000000000000000009C846300CE7B3900FFF7
      F700FFFFFF00FFF7F700FFF7EF00ADD6D600CEE7E700F7BD94004A2918008484
      840000000000BDB5AD00396BD600394A9C0000000000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AD7B6B00F7D6A500F7C68C00EFA55A00BD6B
      3100845A4A00A5ADA500FFD6AD00CE6300000000000021ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF006BDEF7006BDEF70021ADD60010A5C60021A5
      D60021A5D60021A5D60010A5C600000000000000000000000000399CF70039A5
      FF0039ADFF0039ADFF0031A5FF002194FF001084FF0094C6FF00B5CEE700426B
      BD004A6BA50000000000000000000000000000000000AD8C6300CE7B3900FFF7
      F700FFFFFF00FFFFFF00FFFFFF00D6EFEF00CEE7E700F7BD84004A2918008484
      84000000000000000000000000000000000000000000CE630000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AD7B6B00F7D6A500F7C68C00EFA5
      5A00B56B3900845A4A00949C9400CE6300000000000021ADD600C6FFFF0094FF
      FF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF006BDEF7006BDEF70010AD
      DE000000000000000000000000000000000000000000000000000000000039A5
      FF0039ADFF0039B5FF0039ADFF00299CFF002194FF001084FF00296BE7002963
      C6000000000000000000000000000000000000000000ADA59C00CE630800C673
      3100D6945A00DEB59C00EFCEC600F7EFE700FFFFFF00E7BD9400524221008484
      84000000000000000000000000000000000000000000CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000AD7B6B00F7D6A500948C
      9C0031A5F7000010AD0000009400CE6300000000000018ADD6009CDEEF00C6FF
      FF00C6FFFF009CDEEF0010ADD60010A5C60010A5C60010A5C60010A5C60010A5
      CE00000000000000000000000000000000000000000000000000000000000000
      000039A5FF0039ADFF0039B5FF0031ADFF003194F7001029B5003152DE000000
      00000000000000000000000000000000000000000000BDB5AD00E78C2100C65A
      0000C65A0000C65A0000BD520000C65A0800C67B3900C6733100524A29009494
      9400000000000000000000000000000000000000000000000000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000AD7B6B00429C
      EF000821D6000821D6000010AD0000009400000000000000000029B5DE0021AD
      D60010A5C60010A5C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000039A5FF0039ADFF00000000000000000010089400314ADE000000
      000000000000000000000000000000000000000000000000000000000000BDB5
      AD00ADA59C009C948C00CE8C3900D6842900D6730800D66B0000949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000010
      C6006B8CFF00086BFF000821D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010109C00314ADE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000010C6000010C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00F80F000000000000F00F000000000000
      E3FF000000000000C401000000000000C80000000000000088CC000000000000
      99CC00000000000099CC00000000000099CC00000000000088CC000000000000
      CC0C000000000000C609000000000000E3F1000000000000F003000000000000
      FC0F000000000000FFFF000000000000F0FF87FFFFFFFFFFE00F80FF80008FFF
      C003803F8000807F8001801F8000800F0001800F800080070001800F80008007
      0001800780008003000180018000800300018000800080010001800080008001
      8003800880008001C007800F8000800FE00F800F8000800FF01F800FC000C3FF
      F99FE01FFFE1FFFFFF9FFFFFFFF3FFFF00000000000000000000000000000000
      000000000000}
  end
end
