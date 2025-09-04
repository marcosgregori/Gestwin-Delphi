object RptTvpForm: TRptTvpForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_tvp'
  HelpContext = 1107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de tipos de venta peri'#243'dica'
  ClientHeight = 111
  ClientWidth = 506
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
    ExplicitWidth = 415
    ExplicitHeight = 67
    DesignSize = (
      496
      70)
    Height = 70
    Width = 496
    object gxRangeBox1: TgxRangeBox
      Left = 64
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBSpinEdit
      Left = 81
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 53
    end
    object CodigoFinalCtrl: TcxDBSpinEdit
      Left = 81
      Top = 33
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 53
    end
    object Label1: TcxLabel
      Left = 8
      Top = 9
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 147
      Top = 9
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 344
    end
    object Label4: TcxLabel
      Left = 147
      Top = 36
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 344
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 75
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 72
    ExplicitWidth = 425
    DesignSize = (
      506
      36)
    Height = 36
    Width = 506
    object Panel3: TcxGroupBox
      Left = 167
      Top = 4
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 126
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
    
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 312
    Top = 8
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tvp'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 218
    Top = 8
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 281
    Top = 8
    object DataCodigoInicial: TSmallintField
      FieldName = 'CodigoInicial'
    end
    object DataCodigoFinal: TSmallintField
      FieldName = 'CodigoFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 248
    Top = 8
  end
end
