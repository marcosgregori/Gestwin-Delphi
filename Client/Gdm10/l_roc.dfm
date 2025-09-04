object RptRocForm: TRptRocForm
  Left = 542
  Top = 416
  HelpType = htKeyword
  HelpKeyword = 'l_roc'
  HelpContext = 2113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de operaciones con clientes'
  ClientHeight = 359
  ClientWidth = 713
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
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
      703
      318)
    Height = 318
    Width = 703
    object gxRangeBox2: TgxRangeBox
      Left = 203
      Top = 16
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object CuentaRangeBox: TgxRangeBox
      Left = 204
      Top = 70
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 219
      Top = 8
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 219
      Top = 35
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 219
      Top = 114
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      TabOrder = 4
      Width = 67
    end
    object TipoCtrl: TcxDBIndexedComboBox
      Left = 219
      Top = 167
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Relaci'#243'n de operaciones'
        'Comunicado a clientes (carta)')
      Properties.OnValidate = TipoCtrlPropertiesValidate
      TabOrder = 6
      Width = 203
    end
    object ClientesRetencionCtrl: TcxDBCheckBox
      Left = 9
      Top = 248
      AutoSize = False
      Caption = 'Incluir a los clientes con retenci'#243'n'
      DataBinding.DataField = 'ClientesRetencion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 9
      Transparent = True
      Height = 25
      Width = 226
    end
    object OrdenarPorNIFCtrl: TcxDBCheckBox
      Left = 9
      Top = 274
      AutoSize = False
      Caption = 'Ordenar por N.I.F.'
      DataBinding.DataField = 'OrdenarPorNIF'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 226
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 117
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 10
      Top = 171
      TabStop = False
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object AgruparPorNIFCtrl: TcxDBCheckBox
      Left = 10
      Top = 142
      AutoSize = False
      Caption = 'Agrupar por N.I.F.'
      DataBinding.DataField = 'AgruparPorNIF'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparPorNIFCtrlPropertiesChange
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 225
    end
    object EnviarPorCorreoCtrl: TcxDBCheckBox
      Left = 10
      Top = 198
      AutoSize = False
      Caption = 'Enviar por correo'
      DataBinding.DataField = 'EnviarPorCorreo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnValidate = EnviarPorCorreoCtrlPropertiesValidate
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
      Height = 21
      Width = 225
    end
    object ExcluirClientesCorreoCtrl: TcxDBCheckBox
      Left = 10
      Top = 223
      AutoSize = False
      Caption = 'E&xcluir clientes de correo'
      DataBinding.DataField = 'ExcluirClientesCorreo'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 8
      Transparent = True
      Height = 21
      Width = 225
    end
    object SubcuentaInicialCtrl: TcxDBTextEdit
      Left = 219
      Top = 61
      DescriptionLabel = Label7
      DataBinding.DataField = 'SubcuentaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 2
      Width = 79
    end
    object SubcuentaFinalCtrl: TcxDBTextEdit
      Left = 219
      Top = 88
      DescriptionLabel = Label9
      DataBinding.DataField = 'SubcuentaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SubcuentaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpMiddleZero
      Properties.ValidationOptions = []
      Properties.OnValidate = SubcuentaCtrlPropertiesValidate
      TabOrder = 3
      Width = 79
    end
    object cxLabel1: TcxLabel
      Left = 10
      Top = 64
      TabStop = False
      Caption = 'Subcuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 334
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 350
    end
    object Label9: TcxLabel
      Left = 334
      Top = 91
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 350
    end
    object EditSelector: TgxEditSelector
      Left = 306
      Top = 61
      Alignment = alCenterCenter
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 17
      SelectorOptions.StartEdit = SubcuentaInicialCtrl
      SelectorOptions.EndEdit = SubcuentaFinalCtrl
      SelectorOptions.GridView = CuentasTableView
      SelectorOptions.RangeBox = CuentaRangeBox
      SelectorOptions.FieldName = 'Codigo'
      Height = 25
      Width = 25
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 323
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      713
      36)
    Height = 36
    Width = 713
    object Panel3: TcxGroupBox
      Left = 271
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
    Left = 665
    Top = 22
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 634
    Top = 86
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 600
    Top = 86
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 633
    Top = 22
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataImporteMinimo: TBCDField
      FieldName = 'ImporteMinimo'
    end
    object DataAgruparPorNIF: TBooleanField
      FieldName = 'AgruparPorNIF'
    end
    object DataTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object DataClientesRetencion: TBooleanField
      FieldName = 'ClientesRetencion'
    end
    object DataOrdenarPorNIF: TBooleanField
      FieldName = 'OrdenarPorNIF'
    end
    object DataEnviarPorCorreo: TBooleanField
      FieldName = 'EnviarPorCorreo'
    end
    object DataExcluirClientesCorreo: TBooleanField
      FieldName = 'ExcluirClientesCorreo'
    end
    object DataSubcuentaInicial: TStringField
      FieldName = 'SubcuentaInicial'
      Size = 9
    end
    object DataSubcuentaFinal: TStringField
      FieldName = 'SubcuentaFinal'
      Size = 9
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 600
    Top = 22
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_roc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 600
    Top = 54
  end
  object CartaReport: TgxReportManager
    FileName = 'fro'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 634
    Top = 54
  end
  object cxGridViewRepository1: TcxGridViewRepository
    Left = 360
    Top = 66
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
        Properties.OnEnter = CuentasTableViewCodigoPropertiesEnter
        Properties.OnQueryRequest = CuentasTableViewCodigoPropertiesQueryRequest
        Properties.ValidationOptions = [evoRaiseException, evoAllowLoseFocus]
        Properties.OnValidate = CuentasTableViewCodigoPropertiesValidate
        Width = 95
      end
      object CuentasTableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Options.Editing = False
        Options.Focusing = False
        Width = 350
      end
    end
  end
  object CuentasDataSource: TDataSource
    DataSet = CuentasTable
    Left = 393
    Top = 66
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
    Left = 425
    Top = 66
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
end
