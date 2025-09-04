object BoxImportForm: TBoxImportForm
  Left = 412
  Top = 216
  HelpType = htKeyword
  HelpContext = 4104
  BorderStyle = bsDialog
  Caption = 'Importaci'#243'n de ficheros CSV'
  ClientHeight = 206
  ClientWidth = 460
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  Position = poDefault
  Visible = True
  TextHeight = 15
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
    Height = 165
    Width = 450
    object Label1: TcxLabel
      Left = 11
      Top = 40
      Caption = 'Tabla'
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 11
      Top = 15
      Caption = 'Fichero'
      Transparent = True
    end
    object gBox1: TcxGroupBox
      Left = 9
      Top = 70
      Caption = 'Advertencia'
      ParentBackground = False
      TabOrder = 3
      Height = 81
      Width = 430
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 5
        Top = 23
        Align = alClient
        Caption = 
          'El fichero destino, si existe, ser'#225' suprimido. Aseg'#250'rese de que ' +
          ' tiene una copia de seguridad del mismo antes de realizar el pro' +
          'c'#39'eso.'
        Properties.WordWrap = True
        Transparent = True
        Width = 420
      end
    end
    object TablaCtrl: TcxDBComboBox
      Left = 61
      Top = 36
      DataBinding.DataField = 'Tabla'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Sorted = True
      TabOrder = 2
      Width = 163
    end
    object NombreFicheroCtrl: TcxDBTextEdit
      Left = 61
      Top = 11
      DataBinding.DataField = 'NombreFichero'
      DataBinding.DataSource = DataSource
      Properties.OnValidate = NombreFicheroCtrlPropertiesValidate
      TabOrder = 0
      Width = 269
    end
    object gBitBtn3: TgBitBtn
      Left = 336
      Top = 7
      Width = 96
      Height = 28
      Caption = 'Examinar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 1
      OnClick = gBitBtn3Click
      GlyphBitmap = gmFolder
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 170
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      460
      36)
    Height = 36
    Width = 460
    object Panel3: TcxGroupBox
      Left = 144
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
    FirstDataControl = NombreFicheroCtrl
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 416
    Top = 35
  end
  object ImportTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableType = ttRecover
    Left = 324
    Top = 35
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 387
    Top = 35
    object DataNombreFichero: TWideStringField
      FieldName = 'NombreFichero'
      Size = 80
    end
    object DataTabla: TWideStringField
      FieldName = 'Tabla'
      Size = 40
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 354
    Top = 35
  end
  object OpenDialog: TdxOpenFileDialog
    Left = 354
    Top = 68
  end
  object CuentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 352
    Top = 137
  end
end
