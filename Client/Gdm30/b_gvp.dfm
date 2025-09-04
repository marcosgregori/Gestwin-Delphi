object BoxGvpForm: TBoxGvpForm
  Left = 436
  Top = 288
  HelpType = htKeyword
  HelpKeyword = 'b_gvp'
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de albaranes de ventas peri'#243'dicas'
  ClientHeight = 192
  ClientWidth = 584
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
    DesignSize = (
      574
      151)
    Height = 151
    Width = 574
    object gxRangeBox1: TgxRangeBox
      Left = 117
      Top = 71
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 132
      Top = 35
      DescriptionLabel = Label8
      DataBinding.DataField = 'Serie'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 132
      Top = 62
      DescriptionLabel = Label3
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteInicialCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteInicialCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 132
      Top = 89
      DescriptionLabel = Label4
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteInicialCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteInicialCtrlPropertiesValidate
      TabOrder = 3
      Width = 46
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 132
      Top = 116
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object Label6: TcxLabel
      Left = 8
      Top = 38
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 204
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 362
    end
    object Label7: TcxLabel
      Left = 8
      Top = 65
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 119
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 204
      Top = 65
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 362
    end
    object Label4: TcxLabel
      Left = 204
      Top = 92
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
      Height = 19
      Width = 362
    end
    object cxLabel1: TcxLabel
      Left = 7
      Top = 11
      Caption = 'Tipo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object TipoCtrl: TcxDBSpinEdit
      Left = 132
      Top = 8
      DescriptionLabel = DescTipoLabel
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TipoCtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = TipoCtrlPropertiesValidate
      TabOrder = 0
      Width = 50
    end
    object DescTipoLabel: TcxLabel
      Left = 204
      Top = 11
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 362
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 156
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      584
      36)
    Height = 36
    Width = 584
    object Panel3: TcxGroupBox
      Left = 206
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
    FirstDataControl = TipoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 430
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 431
    Top = 44
    object DataTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 44
  end
end
