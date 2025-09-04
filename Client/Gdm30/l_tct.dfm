object RptTctForm: TRptTctForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_tcv'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 
    'Listado de tarifas de venta por c'#243'digo de tarifa y clase de art'#237 +
    'culo'
  ClientHeight = 171
  ClientWidth = 554
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
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
      544
      130)
    Height = 130
    Width = 544
    object gxRangeBox2: TgxRangeBox
      Left = 101
      Top = 71
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox1: TgxRangeBox
      Left = 100
      Top = 18
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoArticuloInicialCtrl: TcxDBTextEdit
      Left = 118
      Top = 62
      DescriptionLabel = Label5
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 2
      Width = 102
    end
    object CodigoArticuloFinalCtrl: TcxDBTextEdit
      Left = 118
      Top = 89
      DescriptionLabel = Label6
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 3
      Width = 102
    end
    object Label4: TcxLabel
      Left = 10
      Top = 65
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 248
      Top = 65
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 312
      AnchorY = 75
    end
    object Label6: TcxLabel
      Left = 248
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      Height = 20
      Width = 312
      AnchorY = 102
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 117
      Top = 9
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoTarifaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 0
      Width = 29
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 117
      Top = 36
      DescriptionLabel = cxLabel1
      DataBinding.DataField = 'CodigoTarifaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoTarifaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoTarifaCtrlPropertiesValidate
      TabOrder = 1
      Width = 29
    end
    object Label1: TcxLabel
      Left = 11
      Top = 12
      Caption = 'C'#243'digo tarifa'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 175
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object cxLabel1: TcxLabel
      Left = 175
      Top = 39
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 135
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      554
      36)
    Height = 36
    Width = 554
    object Panel3: TcxGroupBox
      Left = 192
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
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 430
    Top = 12
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 399
    Top = 12
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
    end
    object DataCodigoTarifaInicial: TWideStringField
      FieldName = 'CodigoTarifaInicial'
      Size = 2
    end
    object DataCodigoTarifaFinal: TWideStringField
      FieldName = 'CodigoTarifaFinal'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 366
    Top = 12
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tct'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 332
    Top = 12
  end
end
