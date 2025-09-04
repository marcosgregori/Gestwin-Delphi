object boxGaaForm: TboxGaaForm
  Left = 455
  Top = 256
  HelpType = htKeyword
  HelpKeyword = 'b_gaa'
  HelpContext = 4104
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de asientos de amortizaci'#243'n'
  ClientHeight = 135
  ClientWidth = 647
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs10'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 28
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 81
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      647
      54)
    Height = 54
    Width = 647
    object Panel3: TcxGroupBox
      Left = 191
      Top = 6
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = []
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 3
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 45
      Width = 261
      object OkButton: TgBitBtn
        Left = 2
        Top = 2
        Width = 127
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 0
        GlyphBitmap = gmOk
      end
      object CloseButton: TgBitBtn
        Left = 132
        Top = 2
        Width = 128
        Height = 42
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 6
        OptionsImage.Spacing = 8
        TabOrder = 1
        GlyphBitmap = gmClose
      end
    end
  end
  object dataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alClient
    Alignment = alCenterCenter
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    Height = 73
    Width = 631
    object FechaCtrl: TcxDBDateEdit
      Left = 108
      Top = 17
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 0
      Width = 150
    end
    object Label1: TcxLabel
      Left = 15
      Top = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 1
      Transparent = True
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FechaCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 326
    Top = 4
  end
  object InmovilizadoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Inmovilizado'
    IndexFieldNames = 'Codigo'
    Left = 264
    Top = 34
  end
  object LineaInmovilizadoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaInmovilizado'
    IndexFieldNames = 'Codigo;NroRegistro'
    Left = 234
    Top = 34
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 204
    Top = 34
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 326
    Top = 34
  end
  object SaldosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 296
    Top = 34
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 295
    Top = 4
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 262
    Top = 4
  end
end
