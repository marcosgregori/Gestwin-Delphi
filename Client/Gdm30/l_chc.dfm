object RptChcForm: TRptChcForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_chc'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de consumos habituales de clientes'
  ClientHeight = 115
  ClientWidth = 497
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
    ExplicitWidth = 411
    ExplicitHeight = 63
    DesignSize = (
      487
      74)
    Height = 74
    Width = 487
    object gxRangeBox1: TgxRangeBox
      Left = 64
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ClienteInicialCtrl: TcxDBTextEdit
      Left = 81
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object ClienteFinalCtrl: TcxDBTextEdit
      Left = 81
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object Label1: TcxLabel
      Left = 12
      Top = 11
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 142
      Top = 11
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 340
    end
    object Label2: TcxLabel
      Left = 142
      Top = 38
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 264
      Height = 19
      Width = 340
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 79
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 68
    ExplicitWidth = 421
    DesignSize = (
      497
      36)
    Height = 36
    Width = 497
    object Panel3: TcxGroupBox
      Left = 163
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
    
    FirstDataControl = ClienteInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 346
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 315
    Top = 10
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 282
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_chc'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 250
    Top = 8
  end
end
