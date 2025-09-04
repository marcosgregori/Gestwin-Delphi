object RptTlfForm: TRptTlfForm
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_tlf'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de referencias  y tarifas por cliente y familia'
  ClientHeight = 167
  ClientWidth = 575
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
    ExplicitWidth = 470
    ExplicitHeight = 109
    DesignSize = (
      565
      126)
    Height = 126
    Width = 565
    object gxRangeBox1: TgxRangeBox
      Left = 60
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 60
      Top = 69
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoClienteInicialCtrl: TcxDBTextEdit
      Left = 77
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'ClienteInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 0
      Width = 46
    end
    object CodigoClienteFinalCtrl: TcxDBTextEdit
      Left = 77
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'ClienteFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoClienteCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoClienteCtrlPropertiesValidate
      TabOrder = 1
      Width = 46
    end
    object CodigoFamiliaInicialCtrl: TcxDBTextEdit
      Left = 77
      Top = 62
      DescriptionLabel = Label5
      DataBinding.DataField = 'FamiliaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
      Properties.OnValidate = FamiliaCtrlPropertiesValidate
      TabOrder = 2
      Width = 62
    end
    object CodigoFamiliaFinalCtrl: TcxDBTextEdit
      Left = 77
      Top = 89
      DescriptionLabel = Label6
      DataBinding.DataField = 'FamiliaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = FamiliaCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = FamiliaCtrlPropertiesValidate
      TabOrder = 3
      Width = 62
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'Cliente'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 150
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 364
      Height = 19
      Width = 403
    end
    object Label4: TcxLabel
      Left = 10
      Top = 65
      TabStop = False
      Caption = 'Familia'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 150
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 364
      Height = 19
      Width = 403
    end
    object Label5: TcxLabel
      Left = 150
      Top = 65
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 364
      Height = 19
      Width = 403
    end
    object Label6: TcxLabel
      Left = 150
      Top = 92
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitWidth = 364
      Height = 19
      Width = 403
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 131
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 114
    ExplicitWidth = 480
    DesignSize = (
      575
      36)
    Height = 36
    Width = 575
    object Panel3: TcxGroupBox
      Left = 201
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 181
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
    
    FirstDataControl = CodigoClienteInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 342
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 311
    Top = 10
    object DataFamiliaInicial: TWideStringField
      FieldName = 'FamiliaInicial'
      Size = 6
    end
    object DataFamiliaFinal: TWideStringField
      FieldName = 'FamiliaFinal'
      Size = 6
    end
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
    Left = 278
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_tlf'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 244
    Top = 10
  end
end
