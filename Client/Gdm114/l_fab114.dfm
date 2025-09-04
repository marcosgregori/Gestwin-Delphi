object RptFab114Form: TRptFab114Form
  Left = 355
  Top = 257
  HelpType = htKeyword
  HelpKeyword = 'l_fab114'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Listado de f'#225'bricas'
  ClientHeight = 164
  ClientWidth = 499
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs114'
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
    ExplicitTop = 6
    ExplicitHeight = 146
    DesignSize = (
      489
      123)
    Height = 123
    Width = 489
    object gxRangeBox1: TgxRangeBox
      Left = 148
      Top = 17
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object FabricaInicialCtrl: TcxDBTextEdit
      Left = 165
      Top = 8
      DescriptionLabel = Label3
      DataBinding.DataField = 'FabricaInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 0
      Width = 34
    end
    object FabricaFinalCtrl: TcxDBTextEdit
      Left = 165
      Top = 35
      DescriptionLabel = Label2
      DataBinding.DataField = 'FabricaFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = VendedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = VendedorCtrlPropertiesValidate
      TabOrder = 1
      Width = 34
    end
    object OrdenarCtrl: TcxDBCheckBox
      Left = 9
      Top = 64
      AutoSize = False
      Caption = 'Ordenar alfab'#233'ticamente'
      DataBinding.DataField = 'Ordenar'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 2
      Transparent = True
      Height = 21
      Width = 175
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 9
      Top = 87
      AutoSize = False
      Caption = 'Mostrar todos los datos'
      DataBinding.DataField = 'TodosLosDatos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 3
      Transparent = True
      Height = 21
      Width = 175
    end
    object Label1: TcxLabel
      Left = 12
      Top = 11
      TabStop = False
      Caption = 'F'#225'brica'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 210
      Top = 11
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
    object Label2: TcxLabel
      Left = 210
      Top = 38
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
      Height = 19
      Width = 271
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 128
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 151
    DesignSize = (
      499
      36)
    Height = 36
    Width = 499
    object Panel3: TcxGroupBox
      Left = 165
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
    
    FirstDataControl = FabricaInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 376
    Top = 10
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 347
    Top = 10
    object DataFabricaInicial: TWideStringField
      FieldName = 'FabricaInicial'
      Size = 2
    end
    object DataFabricaFinal: TWideStringField
      FieldName = 'FabricaFinal'
      Size = 2
    end
    object DataOrdenar: TBooleanField
      FieldName = 'Ordenar'
    end
    object DataTodosLosDatos: TBooleanField
      FieldName = 'TodosLosDatos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 314
    Top = 10
  end
  object Report: TgxReportManager
    FileName = 'dm114\l_fab'
    HideReportList = False
    SQLItems = <>
    ParamsDataset = Data
    ToPrinter = False
    Left = 280
    Top = 11
  end
end
