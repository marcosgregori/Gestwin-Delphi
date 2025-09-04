object boxEA3Form: TboxEA3Form
  Left = 321
  Top = 218
  HelpType = htKeyword
  HelpKeyword = 'b_ea3'
  HelpContext = 1130
  BorderStyle = bsDialog
  Caption = 'Enlace con impuesto de sociedades A3'
  ClientHeight = 108
  ClientWidth = 475
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
    Height = 67
    Width = 465
    object PathCtrl: TcxDBTextEdit
      Left = 110
      Top = 7
      DataBinding.DataField = 'Path'
      DataBinding.DataSource = DataSource
      Properties.OnValidate = PathCtrlPropertiesValidate
      TabOrder = 0
      Width = 235
    end
    object examinarButton: TgBitBtn
      Left = 356
      Top = 4
      Width = 103
      Height = 30
      Caption = 'E&xaminar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      TabStop = False
      OnClick = examinarButtonClick
      GlyphBitmap = gmFolder
    end
    object FicheroCtrl: TcxDBTextEdit
      Left = 110
      Top = 34
      DataBinding.DataField = 'Fichero'
      DataBinding.DataSource = DataSource
      TabOrder = 2
      Width = 67
    end
    object Label3: TcxLabel
      Left = 7
      Top = 12
      Caption = 'Path (directorio)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 7
      Top = 38
      Caption = 'Fichero'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 182
      Top = 38
      Caption = '.DAT'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 72
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    ExplicitTop = 82
    DesignSize = (
      475
      36)
    Height = 36
    Width = 475
    object Panel2: TcxGroupBox
      Left = 149
      Top = 3
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 30
      Width = 173
      object gBitBtn1: TgBitBtn
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
      object gBitBtn2: TgBitBtn
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
    
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 414
    Top = 66
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 382
    Top = 66
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 128
    end
    object DataFichero: TWideStringField
      FieldName = 'Fichero'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 350
    Top = 66
  end
  object SaldosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 318
    Top = 66
    object SaldosTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object SaldosTableCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 9
    end
    object SaldosTableCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 3
    end
  end
end
