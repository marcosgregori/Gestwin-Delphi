object RptCdtForm: TRptCdtForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_cdt'
  HelpContext = 1107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de c'#243'digos de tarifa'
  ClientHeight = 112
  ClientWidth = 424
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
      414
      71)
    Height = 71
    Width = 414
    object gxRangeBox1: TgxRangeBox
      Left = 60
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 77
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 29
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 77
      Top = 33
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 29
    end
    object Label1: TcxLabel
      Left = 8
      Top = 9
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 135
      Top = 9
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 269
    end
    object Label4: TcxLabel
      Left = 135
      Top = 36
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
    Top = 76
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      424
      36)
    Height = 36
    Width = 424
    object Panel3: TcxGroupBox
      Left = 126
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
    FirstDataControl = CodigoInicialCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 356
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_cdt'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 262
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 325
    Top = 10
    object DataCodigoInicial: TWideStringField
      DisplayWidth = 2
      FieldName = 'CodigoInicial'
      Size = 2
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 2
      FieldName = 'CodigoFinal'
      Size = 2
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 292
    Top = 10
  end
end
