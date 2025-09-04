object RptLfcForm: TRptLfcForm
  Left = 526
  Top = 371
  HelpType = htKeyword
  HelpKeyword = 'l_lfc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Relaci'#243'n de facturas de clientes'
  ClientHeight = 278
  ClientWidth = 508
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 468
    ExplicitHeight = 216
    DesignSize = (
      498
      237)
    Height = 237
    Width = 498
    object gxRangeBox1: TgxRangeBox
      Left = 108
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 108
      Top = 95
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 108
      Top = 149
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 123
      Top = 140
      DescriptionLabel = Label1
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 5
      Width = 46
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 123
      Top = 167
      DescriptionLabel = Label4
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 6
      Width = 46
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 123
      Top = 86
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      TabOrder = 3
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 123
      Top = 113
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      TabOrder = 4
      Width = 100
    end
    object SerieInicialCtrl: TcxDBTextEdit
      Left = 123
      Top = 5
      DescriptionLabel = Label20
      DataBinding.DataField = 'SerieInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object GrupoClienteCtrl: TcxDBTextEdit
      Left = 123
      Top = 59
      CaptionLabel = Label9
      DescriptionLabel = Label10
      DataBinding.DataField = 'GrupoCliente'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = GrupoClienteCtrlPropertiesQueryRequest
      Properties.OnValidate = GrupoClienteCtrlPropertiesValidate
      TabOrder = 2
      Width = 32
    end
    object SerieFinalCtrl: TcxDBTextEdit
      Left = 123
      Top = 32
      DescriptionLabel = Label2
      DataBinding.DataField = 'SerieFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
      Properties.OnValidate = SerieCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 7
      Top = 190
      AutoSize = False
      Caption = '&Iniciar p'#225'gina con cada cliente'
      DataBinding.DataField = 'IniciarPagina'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 36
      Width = 134
    end
    object Label3: TcxLabel
      Left = 10
      Top = 143
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label19: TcxLabel
      Left = 10
      Top = 8
      TabStop = False
      Caption = 'Serie'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 196
      Top = 8
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 260
      Height = 19
      Width = 290
    end
    object Label9: TcxLabel
      Left = 10
      Top = 62
      TabStop = False
      Caption = 'Grupo de cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 196
      Top = 62
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 260
      Height = 19
      Width = 290
    end
    object Label2: TcxLabel
      Left = 196
      Top = 35
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 260
      Height = 19
      Width = 290
    end
    object Label6: TcxLabel
      Left = 10
      Top = 90
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 196
      Top = 143
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 260
      Height = 19
      Width = 290
    end
    object Label4: TcxLabel
      Left = 196
      Top = 170
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 260
      Height = 19
      Width = 290
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 242
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 221
    ExplicitWidth = 478
    DesignSize = (
      508
      36)
    Height = 36
    Width = 508
    object Panel3: TcxGroupBox
      Left = 169
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
    Model = fmReportForm
    
    FirstDataControl = SerieInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 394
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 361
    Top = 12
    object DataSerieInicial: TWideStringField
      FieldName = 'SerieInicial'
      Size = 2
    end
    object DataSerieFinal: TWideStringField
      FieldName = 'SerieFinal'
      Size = 2
    end
    object DataGrupoCliente: TWideStringField
      FieldName = 'GrupoCliente'
      Size = 3
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataIniciarPagina: TBooleanField
      FieldName = 'IniciarPagina'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 328
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_lfc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 294
    Top = 12
  end
end
