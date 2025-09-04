object BoxGasForm: TBoxGasForm
  Left = 522
  Top = 284
  HelpType = htKeyword
  HelpKeyword = 'b_gas'
  HelpContext = 8157
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de albaranes de salida'
  ClientHeight = 223
  ClientWidth = 459
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
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
    Height = 182
    Width = 449
    object RangoFechasPanel: TcxGroupBox
      Left = 2
      Top = 7
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 54
      Width = 445
      object gxRangeBox1: TgxRangeBox
        Left = 118
        Top = 8
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 132
        Top = 0
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        TabOrder = 0
        Width = 100
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 132
        Top = 27
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        TabOrder = 1
        Width = 100
      end
      object Label3: TcxLabel
        Left = 7
        Top = 3
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
    end
    object MainPanel: TcxGroupBox
      Left = 2
      Top = 61
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        445
        119)
      Height = 119
      Width = 445
      object cxGroupBox1: TcxGroupBox
        AlignWithMargins = True
        Left = 2
        Top = 31
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Informaci'#243'n'
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Height = 74
        Width = 409
        object cxLabel1: TcxLabel
          AlignWithMargins = True
          Left = 5
          Top = 20
          Margins.Top = 18
          Margins.Bottom = 0
          TabStop = False
          Align = alClient
          Caption = 
            'Este proceso crea albaranes de salida de material a partir de la' +
            's hojas de carga.'
          Style.TextColor = clInfoText
          Properties.WordWrap = True
          TabOrder = 0
          Transparent = True
          Width = 399
        end
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 132
        Top = 0
        DescriptionLabel = Label8
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 1
        Width = 25
      end
      object Label6: TcxLabel
        Left = 7
        Top = 3
        TabStop = False
        Caption = 'Serie de facturaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 2
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 192
        Top = 3
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 245
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 5
      Width = 445
    end
  end
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 187
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      459
      36)
    Height = 36
    Width = 459
    object Panel3: TcxGroupBox
      Left = 141
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
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 380
    Top = 13
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 350
    Top = 13
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataSerie: TStringField
      FieldName = 'Serie'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 317
    Top = 13
  end
end
