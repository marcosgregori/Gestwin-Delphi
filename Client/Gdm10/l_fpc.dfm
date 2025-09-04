object rptFpcForm: TrptFpcForm
  Left = 444
  Top = 299
  HelpType = htKeyword
  HelpKeyword = 'l_fpc'
  HelpContext = 3112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de facturas pendientes de cobro'
  ClientHeight = 528
  ClientWidth = 491
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    DesignSize = (
      481
      487)
    Height = 487
    Width = 481
    object gxRangeBox1: TgxRangeBox
      Left = 119
      Top = 11
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 119
      Top = 192
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox5: TgxRangeBox
      Left = 119
      Top = 246
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox6: TgxRangeBox
      Left = 119
      Top = 300
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 135
      Top = 5
      DescriptionLabel = cxLabel2
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 135
      Top = 32
      DescriptionLabel = cxLabel3
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SeriePropertiesQueryRequest
      Properties.OnValidate = SeriePropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object PageControl: TcxPageControl
      Left = 5
      Top = 75
      Width = 470
      Height = 105
      Anchors = [akLeft, akTop, akRight]
      Focusable = False
      TabOrder = 2
      Properties.ActivePage = TabSheet2
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 101
      ClientRectLeft = 4
      ClientRectRight = 466
      ClientRectTop = 28
      object TabSheet2: TcxTabSheet
        Caption = '&Fecha de factura'
        object gxRangeBox2: TgxRangeBox
          Left = 110
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 126
          Top = 5
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 126
          Top = 32
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 100
        end
        object Label8: TcxLabel
          Left = 5
          Top = 9
          TabStop = False
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
      object TabSheet1: TcxTabSheet
        Caption = '&N'#186' de factura'
        object gxRangeBox3: TgxRangeBox
          Left = 110
          Top = 11
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroFacturaInicialCtrl: TcxDBTextEdit
          Left = 126
          Top = 5
          DataBinding.DataField = 'NroFacturaInicial'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 0
          Width = 67
        end
        object NroFacturaFinalCtrl: TcxDBTextEdit
          Left = 126
          Top = 32
          DataBinding.DataField = 'NroFacturaFinal'
          DataBinding.DataSource = DataSource
          Properties.Required = True
          TabOrder = 1
          Width = 67
        end
        object Label1: TcxLabel
          Left = 6
          Top = 9
          TabStop = False
          Caption = 'N'#186' de factura'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 135
      Top = 186
      DescriptionLabel = Label10
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 3
      Width = 78
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 135
      Top = 213
      DescriptionLabel = Label11
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 4
      Width = 78
    end
    object EntidadInicialCtrl: TcxDBTextEdit
      Left = 135
      Top = 240
      DescriptionLabel = Label14
      DataBinding.DataField = 'EntidadInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 5
      Width = 78
    end
    object EntidadFinalCtrl: TcxDBTextEdit
      Left = 135
      Top = 267
      DescriptionLabel = Label15
      DataBinding.DataField = 'EntidadFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 6
      Width = 78
    end
    object FormaCobroInicialCtrl: TcxDBTextEdit
      Left = 135
      Top = 294
      DescriptionLabel = Label18
      DataBinding.DataField = 'FormaCobroInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = FormaCobroCtrlPropertiesValidate
      TabOrder = 7
      Width = 29
    end
    object FormaCobroFinalCtrl: TcxDBTextEdit
      Left = 135
      Top = 321
      DescriptionLabel = Label19
      DataBinding.DataField = 'FormaCobroFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FormaCobroCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = FormaCobroCtrlPropertiesValidate
      TabOrder = 8
      Width = 29
    end
    object AgruparPorCtrl: TcxDBRadioGroup
      Left = 124
      Top = 347
      Alignment = alCenterCenter
      DataBinding.DataField = 'AgruparPor'
      DataBinding.DataSource = DataSource
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'Selecci'#243'n'
          Value = 0
        end
        item
          Caption = 'Cliente / Deudor'
          Value = 1
        end
        item
          Caption = 'Entidad financiera'
          Value = 2
        end
        item
          Caption = 'Forma de cobro'
          Value = 3
        end>
      Style.BorderStyle = ebsNone
      TabOrder = 9
      Transparent = True
      Height = 56
      Width = 274
    end
    object cxDBCheckBox2: TcxDBCheckBox
      Left = 8
      Top = 405
      AutoSize = False
      Caption = 'Incluir abonos'
      DataBinding.DataField = 'IncluirAbonos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 145
    end
    object Label6: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 11
      Top = 54
      TabStop = False
      Caption = 'Seleccionar por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 11
      Top = 190
      TabStop = False
      Caption = 'Cliente/deudor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 222
      Top = 190
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label11: TcxLabel
      Left = 222
      Top = 216
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label12: TcxLabel
      Left = 11
      Top = 244
      TabStop = False
      Caption = 'Entidad financiera'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object Label14: TcxLabel
      Left = 222
      Top = 244
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label15: TcxLabel
      Left = 222
      Top = 270
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label16: TcxLabel
      Left = 11
      Top = 298
      TabStop = False
      Caption = 'Forma de cobro'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
    end
    object Label18: TcxLabel
      Left = 222
      Top = 298
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label19: TcxLabel
      Left = 222
      Top = 324
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
      Height = 19
      Width = 254
    end
    object Label2: TcxLabel
      Left = 11
      Top = 354
      TabStop = False
      Caption = 'Agrupar por'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 22
      Transparent = True
    end
    object MostrarEfectosCtrl: TcxDBCheckBox
      Left = 8
      Top = 429
      AutoSize = False
      Caption = 'Mostrar efectos pendientes'
      DataBinding.DataField = 'MostrarEfectos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 23
      Transparent = True
      Height = 38
      Width = 145
    end
    object cxLabel2: TcxLabel
      Left = 222
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 24
      Transparent = True
      Height = 19
      Width = 275
    end
    object cxLabel3: TcxLabel
      Left = 222
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 25
      Transparent = True
      Height = 19
      Width = 275
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 492
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      491
      36)
    Height = 36
    Width = 491
    object Panel3: TcxGroupBox
      Left = 159
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
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = True
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    OnShowQueryButtonClick = FormManagerShowQueryButtonClick
    Left = 380
    Top = 12
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 380
    Top = 42
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_fpc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 284
    Top = 12
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 350
    Top = 42
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 320
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 349
    Top = 12
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
    object DataNroFacturaInicial: TIntegerField
      FieldName = 'NroFacturaInicial'
    end
    object DataNroFacturaFinal: TIntegerField
      FieldName = 'NroFacturaFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 9
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 9
    end
    object DataEntidadInicial: TWideStringField
      FieldName = 'EntidadInicial'
      Size = 9
    end
    object DataEntidadFinal: TWideStringField
      FieldName = 'EntidadFinal'
      Size = 9
    end
    object DataFormaCobroInicial: TWideStringField
      FieldName = 'FormaCobroInicial'
      Size = 2
    end
    object DataFormaCobroFinal: TWideStringField
      FieldName = 'FormaCobroFinal'
      Size = 2
    end
    object DataAgruparPor: TSmallintField
      FieldName = 'AgruparPor'
    end
    object DataIncluirAbonos: TBooleanField
      FieldName = 'IncluirAbonos'
    end
    object DataMostrarEfectos: TBooleanField
      FieldName = 'MostrarEfectos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 316
    Top = 12
  end
end
