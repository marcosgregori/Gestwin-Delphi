object RptCatForm: TRptCatForm
  Left = 394
  Top = 275
  HelpType = htKeyword
  HelpKeyword = 'l_cat'
  HelpContext = 1103
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de categor'#237'as'
  ClientHeight = 115
  ClientWidth = 463
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs207'
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
    ExplicitWidth = 428
    ExplicitHeight = 66
    DesignSize = (
      453
      74)
    Height = 74
    Width = 453
    object gxRangeBox1: TgxRangeBox
      Left = 67
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object Label1: TcxLabel
      Left = 10
      Top = 11
      TabStop = False
      Caption = 'C'#243'digo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 148
      Top = 9
      TabStop = False
      Anchors = [akLeft]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitTop = 11
      Height = 19
      Width = 264
    end
    object Label4: TcxLabel
      Left = 148
      Top = 34
      TabStop = False
      Anchors = [akLeft]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      ExplicitTop = 39
      Height = 19
      Width = 264
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 82
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlQueryRequest
      Properties.OnValidate = CodigoCtrlValidate
      TabOrder = 3
      Width = 47
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 82
      Top = 36
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.OnValidate = CodigoCtrlValidate
      TabOrder = 4
      Width = 47
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
    ExplicitTop = 71
    ExplicitWidth = 438
    DesignSize = (
      463
      36)
    Height = 36
    Width = 463
    object Panel3: TcxGroupBox
      Left = 146
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 133
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
    Left = 322
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm207\l_cat'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 232
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 291
    Top = 10
    object DataCodigoInicial: TStringField
      FieldName = 'CodigoInicial'
      Size = 5
    end
    object DataCodigoFinal: TStringField
      FieldName = 'CodigoFinal'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 262
    Top = 10
  end
end
