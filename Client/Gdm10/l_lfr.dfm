object RptLfrForm: TRptLfrForm
  Left = 566
  Top = 373
  HelpType = htKeyword
  HelpKeyword = 'l_lfr'
  HelpContext = 2117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Libro registro de facturas recibidas'
  ClientHeight = 377
  ClientWidth = 627
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
    DesignSize = (
      617
      336)
    Height = 336
    Width = 617
    object gxRangeBox1: TgxRangeBox
      Left = 166
      Top = 12
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 182
      Top = 6
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 0
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 182
      Top = 33
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 1
      Width = 100
    end
    object SoloTablaCtrl: TcxDBCheckBox
      Left = 8
      Top = 259
      AutoSize = False
      Caption = '&Solo tabla resumen'
      DataBinding.DataField = 'SoloTablaResumen'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 163
    end
    object PrimerNroOrdenCtrl: TcxDBSpinEdit
      Left = 182
      Top = 60
      CaptionLabel = Label1
      DescriptionLabel = DescNroOrdenLabel
      DataBinding.DataField = 'PrimerNroOrden'
      DataBinding.DataSource = DataSource
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99999999.000000000000000000
      Properties.OnValidate = PrimerNroOrdenCtrlPropertiesValidate
      TabOrder = 2
      Width = 80
    end
    object TipoIVACtrl: TcxDBSpinEdit
      Left = 182
      Top = 205
      DescriptionLabel = descTipoIVALabel
      DataBinding.DataField = 'TipoIVA'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = TipoIVACtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 24.000000000000000000
      Properties.OnValidate = TipoIVACtrlPropertiesValidate
      TabOrder = 7
      Width = 42
    end
    object PorTipoIVACtrl: TcxDBCheckBox
      Left = 8
      Top = 207
      AutoSize = False
      Caption = 'Por tipo de I.V.A.'
      DataBinding.DataField = 'PorTipoIVA'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = PorTipoIVACtrlPropertiesEditValueChanged
      TabOrder = 6
      Transparent = True
      Height = 21
      Width = 163
    end
    object TipoRetencionCtrl: TcxDBSpinEdit
      Left = 182
      Top = 231
      DescriptionLabel = descRetencionLabel
      DataBinding.DataField = 'TipoRetencion'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Required = True
      Properties.OnQueryRequest = TipoRetencionCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 12.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = TipoRetencionCtrlPropertiesValidate
      TabOrder = 9
      Width = 42
    end
    object PorRetencionCtrl: TcxDBCheckBox
      Left = 8
      Top = 233
      AutoSize = False
      Caption = 'Por tipo de retenci'#243'n'
      DataBinding.DataField = 'PorTipoRetencion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = PorRetencionCtrlPropertiesEditValueChanged
      TabOrder = 8
      Transparent = True
      Height = 21
      Width = 163
    end
    object LibroRegistroCtrl: TcxDBIndexedComboBox
      Left = 182
      Top = 130
      CaptionLabel = Label2
      DataBinding.DataField = 'LibroRegistro'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'facturas recibidas y bienes de inversi'#243'n'
        'facturas recibidas'
        'bienes de inversi'#243'n'
        'operaciones intracomunitarias'
        'r'#233'gimen especial de agricultura, ganaderia y pesca'
        'inversi'#243'n del sujeto pasivo')
      TabOrder = 4
      Width = 312
    end
    object OrdenarPorRegistroCtrl: TcxDBCheckBox
      Left = 8
      Top = 87
      AutoSize = False
      Caption = '&Ordenar por n'#186' de registro'
      DataBinding.DataField = 'OrdenarPorRegistro'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = OrdenarPorRegistroCtrlPropertiesEditValueChanged
      TabOrder = 3
      Transparent = True
      Height = 36
      Width = 163
    end
    object LibroEspecialCtrl: TcxDBCheckBox
      Left = 8
      Top = 161
      AutoSize = False
      Caption = 'Libro especial'
      DataBinding.DataField = 'LibroEspecial'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = LibroEspecialCtrlPropertiesEditValueChanged
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 163
    end
    object Label4: TcxLabel
      Left = 11
      Top = 9
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 11
      Top = 63
      TabStop = False
      Caption = 'Primer n'#186' orden'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descTipoIVALabel: TcxLabel
      Left = 248
      Top = 208
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 384
    end
    object descRetencionLabel: TcxLabel
      Left = 248
      Top = 234
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 384
    end
    object Label2: TcxLabel
      Left = 11
      Top = 134
      TabStop = False
      Caption = 'Libro registro de ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 182
      Top = 89
      TabStop = False
      AutoSize = False
      Caption = 
        'Si los nros. de registro no est'#225'n correctamente asignados, esta ' +
        'ordenaci'#243'n puede dar lugar a un libro registro no v'#225'lido.'
      Style.TextColor = clGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      Transparent = True
      Height = 34
      Width = 413
    end
    object DescNroOrdenLabel: TcxLabel
      Left = 279
      Top = 63
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 385
    end
    object Label5: TcxLabel
      Left = 182
      Top = 161
      TabStop = False
      AutoSize = False
      Caption = 
        'Ninguno de los libros registro anteriores. La selecci'#243'n se reali' +
        'zar'#225' por tipo de I.V.A. y/o retenci'#243'n e incluir'#225' los tipos de I.' +
        'V.A. no liquidables.'
      Style.TextColor = clGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.WordWrap = True
      Transparent = True
      Height = 45
      Width = 413
    end
    object AgruparPorAcreedorCtrl: TcxDBCheckBox
      Left = 8
      Top = 286
      AutoSize = False
      Caption = 'Agrupar por acreedor'
      DataBinding.DataField = 'AgruparPorAcreedor'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 19
      Transparent = True
      Height = 21
      Width = 163
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 341
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      627
      36)
    Height = 36
    Width = 627
    object Panel3: TcxGroupBox
      Left = 228
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
  object Report: TgxReportManager
    FileName = 'dm10\l_lfr'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 408
    Top = 48
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FechaInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 502
    Top = 16
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 442
    Top = 48
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 472
    Top = 48
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 469
    Top = 16
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataSoloTablaResumen: TBooleanField
      FieldName = 'SoloTablaResumen'
    end
    object DataPrimerNroOrden: TIntegerField
      FieldName = 'PrimerNroOrden'
    end
    object DataPorTipoIVA: TBooleanField
      FieldName = 'PorTipoIVA'
    end
    object DataPorTipoRetencion: TBooleanField
      FieldName = 'PorTipoRetencion'
    end
    object DataTipoIVA: TSmallintField
      FieldName = 'TipoIVA'
    end
    object DataTipoRetencion: TSmallintField
      FieldName = 'TipoRetencion'
    end
    object DataLibroRegistro: TSmallintField
      FieldName = 'LibroRegistro'
    end
    object DataOrdenarPorRegistro: TBooleanField
      FieldName = 'OrdenarPorRegistro'
    end
    object DataLibroEspecial: TBooleanField
      FieldName = 'LibroEspecial'
    end
    object DataAgruparPorAcreedor: TBooleanField
      FieldName = 'AgruparPorAcreedor'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 436
    Top = 16
  end
end
