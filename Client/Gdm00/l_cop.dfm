object rptCopForm: TrptCopForm
  Left = 496
  Top = 303
  HelpType = htKeyword
  HelpKeyword = 'l_cop'
  HelpContext = 214
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de c'#243'digos postales'
  ClientHeight = 133
  ClientWidth = 431
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
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
      421
      92)
    Height = 92
    Width = 421
    object gxRangeBox1: TgxRangeBox
      Left = 96
      Top = 43
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 113
      Top = 36
      DescriptionLabel = Label5
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 113
      Top = 63
      DescriptionLabel = Label6
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 2
      Width = 25
    end
    object CodigoPaisCtrl: TcxDBTextEdit
      Left = 113
      Top = 9
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoPais'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoPaisCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoPaisCtrlPropertiesValidate
      TabOrder = 0
      Width = 32
    end
    object Label1: TcxLabel
      Left = 10
      Top = 40
      Caption = 'Provincia'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 10
      Top = 12
      Caption = 'C'#243'digo del pa'#237's'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 160
      Top = 12
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 250
    end
    object Label5: TcxLabel
      Left = 160
      Top = 40
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 250
    end
    object Label6: TcxLabel
      Left = 160
      Top = 66
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 250
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 97
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      431
      36)
    Height = 36
    Width = 431
    object Panel3: TcxGroupBox
      Left = 129
      Top = 4
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
    FirstDataControl = CodigoPaisCtrl
    Model = fmReportForm
    
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 306
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm00\l_cop'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 214
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 276
    Top = 10
    object DataCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Required = True
      Size = 3
    end
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
    Left = 244
    Top = 10
  end
end
