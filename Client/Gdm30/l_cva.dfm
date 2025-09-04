object RptCvaForm: TRptCvaForm
  Left = 637
  Top = 418
  HelpType = htKeyword
  HelpKeyword = 'l_dev'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de consumos  de art'#237'culos por vendedores'
  ClientHeight = 274
  ClientWidth = 533
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
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
      523
      233)
    Height = 233
    Width = 523
    object gxRangeBox1: TgxRangeBox
      Left = 110
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 110
      Top = 68
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 110
      Top = 121
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object VendedorInicialCtrl: TcxDBTextEdit
      Left = 125
      Top = 5
      DescriptionLabel = Label1
      DataBinding.DataField = 'VendedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object VendedorFinalCtrl: TcxDBTextEdit
      Left = 125
      Top = 32
      DescriptionLabel = Label2
      DataBinding.DataField = 'VendedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 125
      Top = 59
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 125
      Top = 86
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 3
      Width = 100
    end
    object DetalladoCtrl: TcxDBCheckBox
      Left = 10
      Top = 167
      AutoSize = False
      Caption = 'Listado detallado'
      DataBinding.DataField = 'Detallado'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = DetalladoCtrlPropertiesChange
      TabOrder = 6
      Transparent = True
      Height = 25
      Width = 133
    end
    object SoloFacturadosCtrl: TcxDBCheckBox
      Left = 10
      Top = 193
      AutoSize = False
      Caption = 'Solo lo facturado'
      DataBinding.DataField = 'SoloFacturados'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 25
      Width = 133
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 125
      Top = 113
      DescriptionLabel = Label15
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.PadAlways = True
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 4
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 125
      Top = 140
      DescriptionLabel = Label18
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 5
      Width = 102
    end
    object Label3: TcxLabel
      Left = 13
      Top = 8
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 13
      Top = 63
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 246
      Top = 8
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
    object Label2: TcxLabel
      Left = 246
      Top = 35
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
    object Label4: TcxLabel
      Left = 13
      Top = 116
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label15: TcxLabel
      Left = 246
      Top = 116
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
    object Label18: TcxLabel
      Left = 246
      Top = 143
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 238
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 181
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
    FirstDataControl = VendedorInicialCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 464
    Top = 14
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cva'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    OnSetReportName = ReportSetReportName
    Left = 370
    Top = 14
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 14
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataDetallado: TBooleanField
      FieldName = 'Detallado'
    end
    object DataSoloFacturados: TBooleanField
      FieldName = 'SoloFacturados'
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 402
    Top = 14
  end
end
