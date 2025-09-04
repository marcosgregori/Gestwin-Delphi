object RptLfeForm: TRptLfeForm
  Left = 566
  Top = 373
  HelpType = htKeyword
  HelpKeyword = 'l_lfe'
  HelpContext = 2117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Libro registro de facturas expedidas'
  ClientHeight = 310
  ClientWidth = 585
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
      575
      269)
    Height = 269
    Width = 575
    object gxRangeBox1: TgxRangeBox
      Left = 132
      Top = 67
      Width = 13
      Height = 37
      Hint = 
        'Los campos situados a la derecha marcan un rango de valores.'#13'Arr' +
        'iba el l'#237'mite inferior y abajo el superior.'
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 132
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
      Left = 148
      Top = 62
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 148
      Top = 89
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object SoloTablaCtrl: TcxDBCheckBox
      Left = 8
      Top = 227
      AutoSize = False
      Caption = '&Solo tabla resumen'
      DataBinding.DataField = 'SoloTablaResumen'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 10
      Transparent = True
      Height = 21
      Width = 154
    end
    object TipoIVACtrl: TcxDBSpinEdit
      Left = 173
      Top = 173
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
      Top = 174
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
      Width = 154
    end
    object TipoRetencionCtrl: TcxDBSpinEdit
      Left = 173
      Top = 200
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
      Top = 201
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
      Width = 154
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 148
      Top = 7
      DescriptionLabel = DescSerieInicialLabel
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieFinalCtrlPropertiesValidate
      TabOrder = 0
      Width = 30
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 148
      Top = 34
      DescriptionLabel = DescSerieFinalLabel
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = SerieFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 30
    end
    object LibroEspecialCtrl: TcxDBCheckBox
      Left = 8
      Top = 148
      AutoSize = False
      Caption = 'Libro especial'
      DataBinding.DataField = 'LibroEspecial'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 5
      Transparent = True
      Height = 21
      Width = 154
    end
    object Label4: TcxLabel
      Left = 11
      Top = 65
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object descTipoIVALabel: TcxLabel
      Left = 229
      Top = 176
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 339
    end
    object descRetencionLabel: TcxLabel
      Left = 229
      Top = 203
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 339
    end
    object Label1: TcxLabel
      Left = 13
      Top = 10
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 173
      Top = 149
      TabStop = False
      Caption = 'La selecci'#243'n incluir'#225' los tipos de I.V.A. no liquidables.'
      Style.TextColor = clGray
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object DescSerieInicialLabel: TcxLabel
      Left = 233
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      ParentColor = False
      Style.Color = clNavy
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 339
    end
    object DescSerieFinalLabel: TcxLabel
      Left = 233
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      ParentColor = False
      Style.Color = clNavy
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 18
      Width = 339
    end
    object LibroRegistroCtrl: TcxDBIndexedComboBox
      Left = 148
      Top = 117
      CaptionLabel = Label2
      DataBinding.DataField = 'LibroRegistro'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'facturas expedidas'
        'operaciones intracomunitarias')
      TabOrder = 4
      Width = 221
    end
    object Label2: TcxLabel
      Left = 11
      Top = 121
      TabStop = False
      Caption = 'Libro registro de ...'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 274
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      585
      36)
    Height = 36
    Width = 585
    object Panel3: TcxGroupBox
      Left = 208
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
    FileName = 'dm10\l_lfe'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 320
    Top = 46
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = SerieInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 386
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 353
    Top = 14
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
    object DataSoloTablaResumen: TBooleanField
      FieldName = 'SoloTablaResumen'
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
    object DataLibroEspecial: TBooleanField
      FieldName = 'LibroEspecial'
    end
    object DataLibroRegistro: TSmallintField
      FieldName = 'LibroRegistro'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 320
    Top = 14
  end
end
