object RptBanForm: TRptBanForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_ban'
  HelpContext = 3101
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de cuentas financieras'
  ClientHeight = 111
  ClientWidth = 486
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
    PanelStyle.Active = True
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      476
      70)
    Height = 70
    Width = 476
    object gxRangeBox1: TgxRangeBox
      Left = 64
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 80
      Top = 7
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoQueryRequest
      Properties.TextEditPad = tpRightZero
      Properties.OnValidate = CodigoValidate
      TabOrder = 0
      Width = 73
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 80
      Top = 34
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoValidate
      TabOrder = 1
      Width = 73
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 165
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
    end
    object Label4: TcxLabel
      Left = 165
      Top = 37
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 308
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
    ExplicitLeft = 2
    DesignSize = (
      486
      36)
    Height = 36
    Width = 486
    object Panel3: TcxGroupBox
      Left = 158
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 123
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
    Left = 346
    Top = 4
  end
  object report: TgxReportManager
    FileName = 'dm10\l_ban'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 315
    Top = 34
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 315
    Top = 4
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 9
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 282
    Top = 4
  end
end
