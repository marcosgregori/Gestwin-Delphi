object rptDirForm: TrptDirForm
  Left = 400
  Top = 247
  HelpType = htKeyword
  HelpKeyword = 'l_dir'
  HelpContext = 1116
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Diario resumen mensual'
  ClientHeight = 323
  ClientWidth = 452
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
  object DataPanel: TgxEditPanel
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
    Height = 282
    Width = 442
    object gxRangeBox1: TgxRangeBox
      Left = 122
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object RayadoModernoCtrl: TcxDBCheckBox
      Left = 7
      Top = 227
      AutoSize = False
      Caption = '&Rayado moderno o americano'
      DataBinding.DataField = 'RayadoModerno'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = RayadoModernoCtrlPropertiesChange
      TabOrder = 7
      Transparent = True
      Height = 37
      Width = 152
    end
    object PeriodoInicialCtrl: TcxDBSpinEdit
      Left = 139
      Top = 9
      DescriptionLabel = Label3
      DataBinding.DataField = 'PeriodoInicial'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 0
      Width = 54
    end
    object PeriodoFinalCtrl: TcxDBSpinEdit
      Left = 139
      Top = 36
      DescriptionLabel = Label6
      DataBinding.DataField = 'PeriodoFinal'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.ImmediatePost = True
      Properties.MaxValue = 14.000000000000000000
      Properties.OnValidate = PeriodoCtrlPropertiesValidate
      TabOrder = 1
      Width = 54
    end
    object PrimeraPaginaCtrl: TcxDBSpinEdit
      Left = 141
      Top = 127
      DataBinding.DataField = 'PrimeraPagina'
      DataBinding.DataSource = DataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 4
      Width = 54
    end
    object PrimerAsientoCtrl: TcxDBSpinEdit
      Left = 141
      Top = 100
      DataBinding.DataField = 'PrimerAsiento'
      DataBinding.DataSource = DataSource
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 3
      Width = 54
    end
    object PaginadoCtrl: TcxDBCheckBox
      Left = 7
      Top = 184
      AutoSize = False
      Caption = '&Cada asiento en una nueva p'#225'gina'
      DataBinding.DataField = 'Paginado'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 6
      Transparent = True
      Height = 36
      Width = 152
    end
    object NivelCtrl: TcxDBIndexedComboBox
      Left = 141
      Top = 155
      DataBinding.DataField = 'Nivel'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Cuenta de 3 d'#237'gitos'
        'Cuenta de 4 d'#237'gitos')
      TabOrder = 5
      Width = 148
    end
    object Label4: TcxLabel
      Left = 11
      Top = 12
      Caption = 'Periodo (mes)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 8
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 11
      Top = 130
      Caption = 'Primer n'#186' de p'#225'gina'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 9
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 11
      Top = 103
      Caption = 'Primer n'#186' de asiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 10
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 205
      Top = 12
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
      Height = 19
      Width = 180
    end
    object Label6: TcxLabel
      Left = 205
      Top = 39
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
      Height = 19
      Width = 180
    end
    object Label7: TcxLabel
      Left = 11
      Top = 159
      Caption = 'Formar con'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object PeriodosNaturalesCtrl: TcxDBCheckBox
      Left = 7
      Top = 60
      AutoSize = False
      Caption = '&Mostrar solo periodos naturales'
      DataBinding.DataField = 'PeriodosNaturales'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 36
      Width = 150
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 287
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
      Left = 140
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
    FirstDataControl = PeriodoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 332
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_dir'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    BeforeStart = ReportBeforeStart
    Left = 272
    Top = 44
  end
  object SaldosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 302
    Top = 44
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 301
    Top = 14
    object DataPeriodoInicial: TSmallintField
      FieldName = 'PeriodoInicial'
    end
    object DataPeriodoFinal: TSmallintField
      FieldName = 'PeriodoFinal'
    end
    object DataPrimeraPagina: TSmallintField
      FieldName = 'PrimeraPagina'
    end
    object DataRayadoModerno: TBooleanField
      FieldName = 'RayadoModerno'
    end
    object DataPrimerAsiento: TSmallintField
      FieldName = 'PrimerAsiento'
    end
    object DataNivel: TSmallintField
      FieldName = 'Nivel'
    end
    object DataPaginado: TBooleanField
      FieldName = 'Paginado'
    end
    object DataPeriodosNaturales: TBooleanField
      FieldName = 'PeriodosNaturales'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 272
    Top = 14
  end
end
