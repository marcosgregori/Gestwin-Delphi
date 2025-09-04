object RptUdaForm: TRptUdaForm
  Left = 540
  Top = 400
  HelpType = htKeyword
  HelpKeyword = 'l_uda'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de stocks m'#237'nimos, m'#225'ximos y ubicaciones de art'#237'culos'
  ClientHeight = 168
  ClientWidth = 572
  Color = clBtnFace
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
      562
      127)
    Height = 127
    Width = 562
    object gxRangeBox1: TgxRangeBox
      Left = 76
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox4: TgxRangeBox
      Left = 77
      Top = 72
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoArticuloInicialCtrl: TcxDBTextEdit
      Left = 93
      Top = 9
      DescriptionLabel = Label7
      DataBinding.DataField = 'CodigoArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 0
      Width = 107
    end
    object CodigoArticuloFinalCtrl: TcxDBTextEdit
      Left = 93
      Top = 36
      DescriptionLabel = Label8
      DataBinding.DataField = 'CodigoArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoArticuloCtrlPropertiesValidate
      TabOrder = 1
      Width = 107
    end
    object Label1: TcxLabel
      Left = 12
      Top = 12
      TabStop = False
      Caption = 'Art'#237'culo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 208
      Top = 12
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 344
    end
    object Label8: TcxLabel
      Left = 208
      Top = 39
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 344
    end
    object AlmacenInicialCtrl: TcxDBTextEdit
      Left = 93
      Top = 63
      DescriptionLabel = cxLabel1
      DataBinding.DataField = 'CodigoAlmacenInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      TabOrder = 2
      Width = 30
    end
    object AlmacenFinalCtrl: TcxDBTextEdit
      Left = 93
      Top = 90
      DescriptionLabel = Label9
      DataBinding.DataField = 'CodigoAlmacenFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 3
      Width = 30
    end
    object Label5: TcxLabel
      Left = 12
      Top = 66
      TabStop = False
      Caption = 'Almacen'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 208
      Top = 66
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 344
    end
    object Label9: TcxLabel
      Left = 208
      Top = 93
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 20
      Width = 344
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 132
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      572
      36)
    Height = 36
    Width = 572
    object Panel3: TcxGroupBox
      Left = 201
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
    Left = 462
    Top = 10
  end
  object report: TgxReportManager
    FileName = 'dm30\l_uda'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 364
    Top = 9
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 10
    object DataCodigoArticuloInicial: TWideStringField
      FieldName = 'CodigoArticuloInicial'
    end
    object DataCodigoArticuloFinal: TWideStringField
      FieldName = 'CodigoArticuloFinal'
    end
    object DataCodigoAlmacenInicial: TStringField
      FieldName = 'CodigoAlmacenInicial'
      Size = 2
    end
    object DataCodigoAlmacenFinal: TStringField
      FieldName = 'CodigoAlmacenFinal'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 398
    Top = 10
  end
end
