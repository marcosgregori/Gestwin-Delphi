object RptRopForm: TRptRopForm
  Left = 542
  Top = 416
  HelpType = htKeyword
  HelpKeyword = 'l_rop'
  HelpContext = 2113
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Relaci'#243'n de operaciones con proveedores'
  ClientHeight = 222
  ClientWidth = 452
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Height = 181
    Width = 442
    object gxRangeBox2: TgxRangeBox
      Left = 118
      Top = 16
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 134
      Top = 8
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 134
      Top = 35
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object ImporteMinimoCtrl: TcxDBCurrencyEdit
      Left = 134
      Top = 62
      DataBinding.DataField = 'ImporteMinimo'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 67
    end
    object TipoCtrl: TcxDBIndexedComboBox
      Left = 134
      Top = 115
      DataBinding.DataField = 'TipoDocumento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Relaci'#243'n de operaciones'
        'Comunicado a proveedores (carta)')
      TabOrder = 4
      Width = 191
    end
    object OrdenarPorNIFCtrl: TcxDBCheckBox
      Left = 6
      Top = 143
      AutoSize = False
      Caption = 'Ordenar por N.I.F.'
      DataBinding.DataField = 'OrdenarPorNIF'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 145
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 65
      TabStop = False
      Caption = 'Importe m'#237'nimo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 10
      Top = 119
      TabStop = False
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object AgruparPorNIFCtrl: TcxDBCheckBox
      Left = 7
      Top = 88
      AutoSize = False
      Caption = 'Agrupar por N.I.F.'
      DataBinding.DataField = 'AgruparPorNIF'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = AgruparPorNIFCtrlPropertiesChange
      TabOrder = 3
      Transparent = True
      Height = 24
      Width = 144
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 186
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      452
      36)
    Height = 36
    Width = 452
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
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 410
    Top = 12
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 380
    Top = 76
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 348
    Top = 76
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 379
    Top = 12
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
    object DataOrdenarPorNIF: TBooleanField
      FieldName = 'OrdenarPorNIF'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 346
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_rop'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 346
    Top = 44
  end
  object CartaReport: TgxReportManager
    FileName = 'fro'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 380
    Top = 44
  end
end
