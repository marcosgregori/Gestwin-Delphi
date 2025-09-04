object RptSdaForm: TRptSdaForm
  Left = 549
  Top = 429
  HelpType = htKeyword
  HelpKeyword = 'l_sda'
  HelpContext = 1117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de saldos deudores y acreedores'
  ClientHeight = 225
  ClientWidth = 593
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
      583
      184)
    Height = 184
    Width = 583
    object CuentaRangeBox: TgxRangeBox
      Left = 105
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
      Visible = False
    end
    object PeriodoCtrl: TcxDBSpinEdit
      Left = 120
      Top = 58
      DescriptionLabel = Label6
      DataBinding.DataField = 'Periodo'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 2
      Width = 51
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 120
      Top = 112
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      Properties.MaxLength = 8
      TabOrder = 4
      Width = 81
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 120
      Top = 4
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.OnEditValueChanged = CodigoInicialCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 120
      Top = 31
      DescriptionLabel = Label9
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.ValidationOptions = []
      Properties.OnValidate = CodigoFinalCtrlPropertiesValidate
      TabOrder = 1
      Visible = False
      Width = 74
    end
    object TipoCtrl: TcxDBIndexedComboBox
      Left = 120
      Top = 85
      DataBinding.DataField = 'Tipo'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Deudor'
        'Acreedor')
      TabOrder = 3
      Width = 86
    end
    object OrdenarCtrl: TcxDBIndexedComboBox
      Left = 120
      Top = 139
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'c'#243'digo de subcuenta'
        'descripci'#243'n'
        'importe')
      TabOrder = 5
      Width = 149
    end
    object Label5: TcxLabel
      Left = 13
      Top = 62
      TabStop = False
      Caption = 'Periodo (mes)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 13
      Top = 115
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 13
      Top = 89
      TabStop = False
      Caption = 'Tipo de saldo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 235
      Top = 62
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
      Height = 19
      Width = 343
    end
    object Label3: TcxLabel
      Left = 13
      Top = 8
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 235
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 343
    end
    object Label8: TcxLabel
      Left = 13
      Top = 143
      TabStop = False
      Caption = 'Ordenar por ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 235
      Top = 34
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
      Height = 19
      Width = 343
    end
    object EditSelector: TgxEditSelector
      Left = 200
      Top = 4
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 14
      EditMode = tesSimple
      SelectorOptions.StartEdit = CodigoInicialCtrl
      SelectorOptions.EndEdit = CodigoFinalCtrl
      SelectorOptions.GridView = CuentasTableView
      SelectorOptions.RangeBox = CuentaRangeBox
      SelectorOptions.FieldName = 'Codigo'
      Height = 25
      Width = 25
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 189
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      593
      36)
    Height = 36
    Width = 593
    object Panel3: TcxGroupBox
      Left = 211
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 10
  end
  object SaldosQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 441
    Top = 42
  end
  object report: TgxReportManager
    FileName = 'dm10\l_sda'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 441
    Top = 76
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 411
    Top = 10
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 9
      FieldName = 'CodigoFinal'
      Size = 9
    end
    object DataPeriodo: TSmallintField
      FieldName = 'Periodo'
    end
    object DataTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataOrdenar: TSmallintField
      FieldName = 'Ordenar'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 378
    Top = 10
  end
  object CuentasTable: TnxeTable
    ActiveRuntime = True
    Database = SessionDataModule.InMemoryDatabase
    Timeout = 6000
    StoreDefs = True
    FieldDefs = <
      item
        Name = 'NroRegistro'
        DataType = ftSmallint
      end
      item
        Name = 'Codigo'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Descripcion'
        DataType = ftString
        Size = 80
      end>
    IndexDefs = <
      item
        Name = 'Sequential Access Index'
        Options = [ixPrimary, ixUnique, ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'CuentasTablenxInd1'
        Fields = 'NroRegistro'
      end>
    AutoIncFieldName = 'NroRegistro'
    TableType = ttMemVirtual
    Left = 345
    Top = 8
    object CuentasTableNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object CuentasTableCodigo: TStringField
      FieldName = 'Codigo'
      Required = True
      Size = 9
    end
    object CuentasTableDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 80
    end
  end
  object CuentasDataSource: TDataSource
    DataSet = CuentasTable
    Left = 313
    Top = 8
  end
  object cxGridViewRepository1: TcxGridViewRepository
    Left = 280
    Top = 8
    object CuentasTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = CuentasDataSource
      DataController.KeyFieldNames = 'NroRegistro'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.FocusCellOnCycle = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.Appending = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object CuentasTableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Required = True
        Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
        Properties.ValidationOptions = [evoRaiseException, evoAllowLoseFocus]
        Properties.OnValidate = CuentasTableViewCodigoPropertiesValidate
        Width = 80
      end
      object CuentasTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
end
