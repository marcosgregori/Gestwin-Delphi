object RptSubForm: TRptSubForm
  Left = 417
  Top = 279
  HelpType = htKeyword
  HelpKeyword = 'l_sub'
  HelpContext = 1101
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado del plan contable'
  ClientHeight = 200
  ClientWidth = 597
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
      587
      159)
    Height = 159
    Width = 587
    object gxRangeBox1: TgxRangeBox
      Left = 185
      Top = 14
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 200
      Top = 6
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnEditValueChanged = CodigoInicialCtrlPropertiesEditValueChanged
      Properties.OnValidate = CodigoInicialCtrlPropertiesValidate
      TabOrder = 0
      Width = 74
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 200
      Top = 33
      DescriptionLabel = Label4
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoFinalCtrlPropertiesValidate
      TabOrder = 1
      Width = 74
    end
    object OrdenarCtrl: TcxDBCheckBox
      Left = 8
      Top = 61
      AutoSize = False
      Caption = '&Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 211
    end
    object NivelesCtrl: TcxDBCheckBox
      Left = 8
      Top = 87
      AutoSize = False
      Caption = '&Incluir niveles superiores'
      DataBinding.DataField = 'IncluirNiveles'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 211
    end
    object Label1: TcxLabel
      Left = 12
      Top = 10
      Caption = 'C'#243'digo de nivel o subcuenta'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 288
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 289
    end
    object Label4: TcxLabel
      Left = 288
      Top = 36
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 289
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 8
      Top = 108
      AutoSize = False
      Caption = '&Mostrar informaci'#243'n descriptiva de las cuentas'
      DataBinding.DataField = 'MostrarDescripcion'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 7
      Transparent = True
      Height = 36
      Width = 211
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 164
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 150
    DesignSize = (
      597
      36)
    Height = 36
    Width = 597
    object Panel3: TcxGroupBox
      Left = 212
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      ExplicitLeft = 201
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
    Left = 464
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm10\l_sub'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 400
    Top = 40
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 433
    Top = 10
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 9
    end
    object DataCodigoFinal: TWideStringField
      DisplayWidth = 9
      FieldName = 'CodigoFinal'
      Size = 9
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataIncluirNiveles: TBooleanField
      FieldName = 'IncluirNiveles'
    end
    object DataMostrarDescripcion: TBooleanField
      FieldName = 'MostrarDescripcion'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 400
    Top = 10
  end
end
