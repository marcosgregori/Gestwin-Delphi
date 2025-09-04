object BoxCdvForm: TBoxCdvForm
  Left = 396
  Top = 242
  HelpType = htKeyword
  HelpKeyword = 'b_cdv'
  BorderStyle = bsDialog
  Caption = 'Copia de documentos de ventas'
  ClientHeight = 233
  ClientWidth = 511
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
    Height = 192
    Width = 501
    object InformacionCtrl: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 112
      Align = alClient
      Caption = 'Informaci'#243'n'
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 1
      Height = 75
      Width = 491
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 
          'Indique la serie de facturaci'#243'n  del documento destino y pulse [' +
          'Aceptar] para crear una copia del registro actual.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 476
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        497
        107)
      Height = 107
      Width = 497
      object SerieCtrl: TcxDBTextEdit
        Left = 192
        Top = 6
        CaptionLabel = Label2
        DescriptionLabel = Label1
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnEditRequest = SerieCtrlPropertiesEditRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 0
        Width = 25
      end
      object SuprimirCtrl: TcxDBCheckBox
        Left = 8
        Top = 33
        AutoSize = False
        Caption = 'Suprimir documento original'
        DataBinding.DataField = 'Suprimir'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 201
      end
      object Label2: TcxLabel
        Left = 11
        Top = 10
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 237
        Top = 10
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 252
      end
      object ActualizarPreciosCtrl: TcxDBCheckBox
        Left = 8
        Top = 57
        AutoSize = False
        Caption = 'Actualizar los &precios y descuentos de las l'#237'neas'
        DataBinding.DataField = 'ActualizarPrecios'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = True
        TabOrder = 4
        Transparent = True
        Height = 38
        Width = 201
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 197
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      511
      36)
    Height = 36
    Width = 511
    object Panel3: TcxGroupBox
      Left = 171
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
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 298
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 269
    Top = 10
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataSuprimir: TBooleanField
      FieldName = 'Suprimir'
    end
    object DataActualizarPrecios: TBooleanField
      FieldName = 'ActualizarPrecios'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 240
    Top = 10
  end
end
