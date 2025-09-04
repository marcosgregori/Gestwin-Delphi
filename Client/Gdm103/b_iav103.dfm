object BoxIav103Form: TBoxIav103Form
  Left = 516
  Top = 388
  HelpType = htKeyword
  HelpKeyword = 'b_iav'
  BorderStyle = bsDialog
  Caption = 'Importaci'#243'n de albaranes de pozos de riego'
  ClientHeight = 201
  ClientWidth = 532
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs60'
  Position = poDefault
  Visible = True
  TextHeight = 15
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
    Height = 160
    Width = 522
    object cxGroupBox5: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 80
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 75
      Width = 512
      object cxLabel5: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 20
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 
          'Indique el nombre del fichero a importar y la serie en la que de' +
          'sea importar los albaranes generados a partir de ese fichero.'
        Properties.WordWrap = True
        Transparent = True
        Width = 497
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
      TabOrder = 0
      DesignSize = (
        512
        69)
      Height = 69
      Width = 512
      object examinarButton: TgBitBtn
        Left = 369
        Top = 5
        Width = 94
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
      object Label19: TcxLabel
        Left = 6
        Top = 36
        Caption = 'Serie de facturaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object Label20: TcxLabel
        Left = 162
        Top = 37
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clNavy
        Style.Font.Height = -11
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
        Height = 17
        Width = 341
      end
      object Label3: TcxLabel
        Left = 6
        Top = 12
        Caption = 'Fichero a importar'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 120
        Top = 8
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 246
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 120
        Top = 32
        DescriptionLabel = Label20
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 2
        Width = 25
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 165
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      532
      36)
    Height = 36
    Width = 532
    object Panel3: TcxGroupBox
      Left = 181
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
    Left = 375
    Top = 63
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 405
    Top = 63
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = PathCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 437
    Top = 63
  end
end
