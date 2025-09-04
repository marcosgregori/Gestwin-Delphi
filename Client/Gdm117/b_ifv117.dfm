object BoxIfv117Form: TBoxIfv117Form
  Left = 516
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'b_iav'
  BorderStyle = bsDialog
  Caption = 'Importaci'#243'n de facturas'
  ClientHeight = 157
  ClientWidth = 516
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs60'
  Position = poDefault
  Visible = True
  TextHeight = 17
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 116
    Width = 506
    object cxGroupBox5: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 52
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 0
      Height = 59
      Width = 496
      object cxLabel5: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Indique el nombre del fichero con las facturas a importar.'
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 481
      end
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 41
      Width = 496
      object examinarButton: TgBitBtn
        Left = 390
        Top = 8
        Width = 103
        Height = 28
        Caption = 'E&xaminar ...'
        Enabled = True
        OptionsImage.ImageIndex = 21
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        TabStop = False
        OnClick = examinarButtonClick
        GlyphBitmap = gmFolder
      end
      object Label3: TcxLabel
        Left = 6
        Top = 12
        Caption = 'Fichero a importar'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 133
        Top = 9
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 246
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 121
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      516
      36)
    Height = 36
    Width = 516
    object Panel3: TcxGroupBox
      Left = 173
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 174
      object OkButton: TgBitBtn
        Left = 1
        Top = 1
        Width = 85
        Height = 28
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 88
        Top = 1
        Width = 85
        Height = 28
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 341
    Top = 45
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 371
    Top = 45
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = PathCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 401
    Top = 45
  end
end
