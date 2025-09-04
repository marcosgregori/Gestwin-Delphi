object BoxEfcForm: TBoxEfcForm
  Left = 360
  Top = 217
  HelpType = htKeyword
  HelpKeyword = 'b_efc'
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de facturas de compra'
  ClientHeight = 242
  ClientWidth = 547
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
      537
      201)
    Height = 201
    Width = 537
    object gxRangeBox2: TgxRangeBox
      Left = 131
      Top = 40
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 131
      Top = 95
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ImprimirCtrl: TcxDBCheckBox
      Left = 8
      Top = 167
      AutoSize = False
      Caption = '&Imprimir'
      DataBinding.DataField = 'Imprimir'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 25
      Width = 156
    end
    object FechaAlbaranInicialCtrl: TcxDBDateEdit
      Left = 147
      Top = 86
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object FechaAlbaranFinalCtrl: TcxDBDateEdit
      Left = 147
      Top = 113
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 4
      Width = 100
    end
    object FechaFacturacionCtrl: TcxDBDateEdit
      Left = 147
      Top = 140
      DataBinding.DataField = 'FechaFacturacion'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 5
      Width = 100
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 147
      Top = 32
      DescriptionLabel = Label2
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 147
      Top = 59
      DescriptionLabel = Label3
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object SerieCtrl: TcxDBTextEdit
      Left = 147
      Top = 5
      DataBinding.DataField = 'SerieFacturacion'
      DataBinding.DataSource = DataSource
      TabOrder = 0
      Width = 25
    end
    object Label4: TcxLabel
      Left = 10
      Top = 89
      Caption = 'Fecha de albar'#225'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label12: TcxLabel
      Left = 10
      Top = 143
      Caption = 'Fecha de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 35
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 10
      Top = 8
      Caption = 'Serie de facturaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object desTipoAstoLabel: TcxLabel
      Left = 249
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 282
    end
    object Label2: TcxLabel
      Left = 249
      Top = 35
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 282
    end
    object Label3: TcxLabel
      Left = 249
      Top = 62
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 282
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 206
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      547
      36)
    Height = 36
    Width = 547
    object Panel3: TcxGroupBox
      Left = 188
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
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 354
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 323
    Top = 10
    object DataSerieFacturacion: TWideStringField
      FieldName = 'SerieFacturacion'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataFechaFacturacion: TDateField
      FieldName = 'FechaFacturacion'
    end
    object DataImprimir: TBooleanField
      FieldName = 'Imprimir'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 290
    Top = 10
  end
  object RelacionAlbaranesTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.TmpDatabase
    Timeout = 6000
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    TableType = ttTemporal
    Left = 322
    Top = 40
  end
end
