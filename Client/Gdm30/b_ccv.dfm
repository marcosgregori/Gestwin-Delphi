object BoxCcvForm: TBoxCcvForm
  Left = 533
  Top = 361
  HelpType = htKeyword
  HelpKeyword = 'b_ccv'
  BorderStyle = bsDialog
  Caption = 'Cierre del ciclo de facturaci'#243'n de ventas'
  ClientHeight = 200
  ClientWidth = 450
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
      440
      159)
    Height = 159
    Width = 440
    object gxRangeBox1: TgxRangeBox
      Left = 116
      Top = 16
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 116
      Top = 71
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 132
      Top = 62
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 2
      Width = 100
    end
    object SerieIncialCtrl: TcxDBTextEdit
      Left = 132
      Top = 8
      DescriptionLabel = Label2
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 132
      Top = 89
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 3
      Width = 100
    end
    object ContabilizarCtrl: TcxDBCheckBox
      Left = 10
      Top = 118
      AutoSize = False
      Caption = 'Contabilizar'
      DataBinding.DataField = 'Contabilizar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = ContabilizarCtrlPropertiesEditValueChanged
      TabOrder = 4
      Transparent = True
      Height = 21
      Width = 139
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 132
      Top = 35
      DescriptionLabel = Label3
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object Label1: TcxLabel
      Left = 13
      Top = 66
      Caption = 'Fecha factura'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 196
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 233
    end
    object Label6: TcxLabel
      Left = 13
      Top = 12
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 196
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
      Height = 19
      Width = 233
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 164
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      450
      36)
    Height = 36
    Width = 450
    object Panel3: TcxGroupBox
      Left = 139
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
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 312
    Top = 74
  end
  object EfectoCobrarTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 377
    Top = 74
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Serie;Fecha;NroFactura'
    Left = 344
    Top = 42
  end
  object ApunteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 345
    Top = 74
  end
  object MovimientoCajaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 376
    Top = 42
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieIncialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 378
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 349
    Top = 10
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataContabilizar: TBooleanField
      FieldName = 'Contabilizar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 318
    Top = 10
  end
end
