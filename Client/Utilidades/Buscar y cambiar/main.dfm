object Form1: TForm1
  Left = 357
  Top = 261
  BorderStyle = bsDialog
  Caption = 'Buscar y cambiar fragmentos de texto'
  ClientHeight = 460
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 293
    Width = 47
    Height = 13
    Caption = 'Buscar ...'
  end
  object Label3: TLabel
    Left = 6
    Top = 315
    Width = 73
    Height = 13
    Caption = 'Sustituir por ...'
  end
  object Label4: TLabel
    Left = 6
    Top = 341
    Width = 40
    Height = 13
    Caption = 'Ficheros'
  end
  object Bevel1: TBevel
    Left = 2
    Top = 403
    Width = 467
    Height = 23
  end
  object Label5: TLabel
    Left = 6
    Top = 407
    Width = 42
    Height = 13
    Caption = 'Fichero :'
  end
  object ficheroLabel: TLabel
    Left = 114
    Top = 407
    Width = 349
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object PathLabel: TLabel
    Left = 8
    Top = 224
    Width = 465
    Height = 27
    AutoSize = False
    Caption = 'C:\Users\Marcos\Desktop'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 205
    Width = 46
    Height = 13
    Caption = 'Directorio'
  end
  object buscaSubCheckBox: TCheckBox
    Left = 5
    Top = 267
    Width = 121
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Incluir subdirectorios'
    TabOrder = 0
  end
  object searchEdit: TEdit
    Left = 112
    Top = 289
    Width = 357
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object changeEdit: TEdit
    Left = 112
    Top = 311
    Width = 357
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object tipoFicheroRadio: TRadioGroup
    Left = 112
    Top = 333
    Width = 280
    Height = 63
    ItemIndex = 2
    Items.Strings = (
      '.pas'
      '.dfm'
      'Todos (.pas, .dfm, .inc, .fr3)')
    TabOrder = 3
  end
  object Button2: TButton
    Left = 161
    Top = 431
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 237
    Top = 431
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 394
    Top = 198
    Width = 75
    Height = 25
    Caption = '&Red ...'
    TabOrder = 8
    TabStop = False
    OnClick = Button4Click
  end
  object Button1: TButton
    Left = 395
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Attrib -r ...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button5: TButton
    Left = 395
    Top = 366
    Width = 75
    Height = 25
    Caption = 'Convert'
    TabOrder = 7
    OnClick = Button5Click
  end
  object DirectoryCtrl: TcxShellTreeView
    Left = 5
    Top = 4
    Width = 460
    Height = 188
    Indent = 19
    Options.ShowNonFolders = False
    RightClickSelect = True
    Root.BrowseFolder = bfCustomPath
    TabOrder = 9
    OnChange = DirectoryCtrlChange
  end
end
