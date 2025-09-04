object RptTcofForm: TRptTcofForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_tcof'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de tipos de comisi'#243'n por familia'
  ClientHeight = 220
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
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    ExplicitWidth = 442
    ExplicitHeight = 159
    DesignSize = (
      523
      179)
    Height = 179
    Width = 523
    object gxRangeBox1: TgxRangeBox
      Left = 72
      Top = 70
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 72
      Top = 124
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox3: TgxRangeBox
      Left = 72
      Top = 16
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoClienteInicialCtrl: TcxDBTextEdit
      Left = 89
      Top = 61
      DescriptionLabel = Label3
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 2
      Width = 46
    end
    object CodigoClienteFinalCtrl: TcxDBTextEdit
      Left = 89
      Top = 88
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 3
      Width = 46
    end
    object CodigoFamiliaInicialCtrl: TcxDBTextEdit
      Left = 89
      Top = 115
      DescriptionLabel = Label5
      DataBinding.DataField = 'FamiliaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
      TabOrder = 4
      Width = 62
    end
    object CodigoFamiliaFinalCtrl: TcxDBTextEdit
      Left = 89
      Top = 142
      DescriptionLabel = Label6
      DataBinding.DataField = 'FamiliaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoFamiliaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoFamiliaCtrlPropertiesValidate
      TabOrder = 5
      Width = 62
    end
    object VendedorInicialCtrl: TcxDBTextEdit
      Left = 89
      Top = 7
      DescriptionLabel = Label8
      DataBinding.DataField = 'VendedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 24
    end
    object VendedorFinalCtrl: TcxDBTextEdit
      Left = 89
      Top = 34
      DescriptionLabel = Label9
      DataBinding.DataField = 'VendedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 24
    end
    object Label1: TcxLabel
      Left = 10
      Top = 64
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 167
      Top = 64
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
    object Label4: TcxLabel
      Left = 10
      Top = 118
      TabStop = False
      Caption = 'Familia'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 167
      Top = 91
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
    object Label5: TcxLabel
      Left = 167
      Top = 118
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
    object Label6: TcxLabel
      Left = 167
      Top = 145
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
    object Label7: TcxLabel
      Left = 10
      Top = 10
      TabStop = False
      Caption = 'Vendedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 167
      Top = 10
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
    object Label9: TcxLabel
      Left = 167
      Top = 37
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 352
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 184
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 164
    ExplicitWidth = 452
    DesignSize = (
      533
      36)
    Height = 36
    Width = 533
    object Panel3: TcxGroupBox
      Left = 180
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 178
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
    
    FirstDataControl = VendedorInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 374
    Top = 16
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 343
    Top = 16
    object DataVendedorInicial: TWideStringField
      FieldName = 'VendedorInicial'
      Size = 2
    end
    object DataVendedorFinal: TWideStringField
      FieldName = 'VendedorFinal'
      Size = 2
    end
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 310
    Top = 16
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tcof'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 276
    Top = 16
  end
end
