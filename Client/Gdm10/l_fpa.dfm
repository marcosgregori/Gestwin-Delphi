object RptFpaForm: TRptFpaForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_fpa'
  HelpContext = 3104
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de formas de pago'
  ClientHeight = 113
  ClientWidth = 412
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
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
    ExplicitWidth = 399
    ExplicitHeight = 64
    DesignSize = (
      402
      72)
    Height = 72
    Width = 402
    object gxRangeBox1: TgxRangeBox
      Left = 64
      Top = 13
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 79
      Top = 7
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoValidate
      TabOrder = 0
      Width = 25
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 79
      Top = 34
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoValidate
      TabOrder = 1
      Width = 25
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 129
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 280
      Height = 19
      Width = 266
    end
    object Label2: TcxLabel
      Left = 129
      Top = 37
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 280
      Height = 19
      Width = 266
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 77
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 69
    ExplicitWidth = 409
    DesignSize = (
      412
      36)
    Height = 36
    Width = 412
    object Panel3: TcxGroupBox
      Left = 121
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 119
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
    Left = 346
    Top = 4
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 315
    Top = 4
    object DataCodigoInicial: TWideStringField
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
    Left = 282
    Top = 4
  end
  object report: TgxReportManager
    FileName = 'dm10\l_fpa'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 315
    Top = 34
  end
end
