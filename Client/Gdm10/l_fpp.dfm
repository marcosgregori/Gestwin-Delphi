object rptFppForm: TrptFppForm
  Left = 349
  Top = 313
  HelpType = htKeyword
  HelpKeyword = 'l_fpp'
  HelpContext = 3119
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de facturas pendientes de pago'
  ClientHeight = 233
  ClientWidth = 567
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    Width = 557
    object gxRangeBox1: TgxRangeBox
      Left = 109
      Top = 12
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 109
      Top = 65
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 124
      Top = 6
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 124
      Top = 33
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 124
      Top = 60
      DescriptionLabel = Label11
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 2
      Width = 74
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 124
      Top = 87
      DescriptionLabel = Label3
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 3
      Width = 74
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 5
      Top = 140
      AutoSize = False
      Caption = 'Mostrar efectos pendientes'
      DataBinding.DataField = 'MostrarEfectos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 38
      Width = 137
    end
    object Label8: TcxLabel
      Left = 8
      Top = 9
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 8
      Top = 63
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label11: TcxLabel
      Left = 249
      Top = 63
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 300
    end
    object Label3: TcxLabel
      Left = 249
      Top = 90
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 300
    end
    object cxDBCheckBox2: TcxDBCheckBox
      Left = 5
      Top = 118
      AutoSize = False
      Caption = 'Incluir abonos'
      DataBinding.DataField = 'IncluirAbonos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 4
      Transparent = True
      Height = 22
      Width = 137
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
      567
      36)
    Height = 36
    Width = 567
    object Panel3: TcxGroupBox
      Left = 198
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 404
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_fpp'
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    Left = 306
    Top = 12
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 338
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 371
    Top = 12
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 9
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 9
    end
    object DataMostrarEfectos: TBooleanField
      FieldName = 'MostrarEfectos'
    end
    object DataIncluirAbonos: TBooleanField
      FieldName = 'IncluirAbonos'
    end
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 342
    Top = 42
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 372
    Top = 42
  end
  object EfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 402
    Top = 42
  end
end
