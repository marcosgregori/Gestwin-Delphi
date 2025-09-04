object boxDrcForm: TboxDrcForm
  Left = 520
  Top = 329
  HelpType = htKeyword
  HelpKeyword = 'b_drc'
  ActiveControl = CloseButton
  BorderStyle = bsDialog
  Caption = 'Descarga de rutas y ficheros'
  ClientHeight = 352
  ClientWidth = 555
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs30'
  Position = poDefault
  Visible = True
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
    Height = 311
    Width = 545
    object gxRangeBox2: TgxRangeBox
      Left = 158
      Top = 15
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object CodigoInicialCtrl: TcxDBTextEdit
      Left = 172
      Top = 7
      DescriptionLabel = Label2
      DataBinding.DataField = 'CodigoInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 0
      Width = 25
    end
    object CodigoFinalCtrl: TcxDBTextEdit
      Left = 172
      Top = 34
      DescriptionLabel = Label3
      DataBinding.DataField = 'CodigoFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = CodigoCtrlPropertiesValidate
      TabOrder = 1
      Width = 25
    end
    object CheckListBox: TcxCheckListBox
      Left = 172
      Top = 90
      Width = 355
      Height = 122
      Columns = 2
      EditValueFormat = cvfIndices
      Enabled = False
      Items = <>
      Sorted = True
      TabOrder = 3
    end
    object ModificarListaCtrl: TcxDBCheckBox
      Left = 4
      Top = 61
      AutoSize = False
      Caption = 'Modificar lista de ficheros'
      DataBinding.DataField = 'ModificarLista'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      Properties.OnChange = ModificarListaCtrlPropertiesChange
      TabOrder = 2
      Transparent = True
      Height = 23
      Width = 185
    end
    object Label7: TcxLabel
      Left = 8
      Top = 10
      TabStop = False
      Caption = 'Equipo m'#243'vil'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 4
      Transparent = True
    end
    object FicherosLabel: TcxLabel
      Left = 8
      Top = 93
      TabStop = False
      Caption = 'Ficheros a incluir'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 5
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 222
      Top = 10
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 6
      Transparent = True
      Height = 19
      Width = 305
    end
    object Label3: TcxLabel
      Left = 222
      Top = 37
      TabStop = False
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 7
      Transparent = True
      Height = 19
      Width = 305
    end
    object cxGroupBox1: TcxGroupBox
      AlignWithMargins = True
      Left = 6
      Top = 214
      Caption = 'Informaci'#243'n'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextStyle = [fsBold]
      TabOrder = 8
      Height = 84
      Width = 521
      object cxLabel1: TcxLabel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Margins.Left = 8
        Margins.Top = 20
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Caption = 
          'La lista de ficheros a incluir puede sobreescribir la informaci'#243 +
          'n generada durante la descarga de rutas.  Consulte la ayuda o el' +
          ' manual si tiene dudas sobre su funcionamiento.'
        Style.TextColor = clInfoText
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 506
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 316
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      555
      36)
    Height = 36
    Width = 555
    object Panel3: TcxGroupBox
      Left = 191
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
  object RutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    Left = 443
    Top = 42
  end
  object EquipoMovilTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 381
    Top = 42
  end
  object ConsumosClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    Left = 283
    Top = 42
  end
  object LineaRutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta;NroOrden'
    Left = 412
    Top = 42
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'SubcuentaCliente;FechaLibramiento'
    Left = 254
    Top = 42
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = CodigoInicialCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 442
    Top = 12
  end
  object VendedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 314
    Top = 42
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 410
    Top = 12
    object DataCodigoInicial: TWideStringField
      FieldName = 'CodigoInicial'
      Size = 2
    end
    object DataCodigoFinal: TWideStringField
      FieldName = 'CodigoFinal'
      Size = 2
    end
    object DataModificarLista: TBooleanField
      FieldName = 'ModificarLista'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 380
    Top = 12
  end
  object BackupController: TnxBackupController
    OnIncludeTable = BackupControllerIncludeTable
    OnTableProgress = BackupControllerTableProgress
    KeepIndexes = True
    Options = [bcoCloseInactiveOnTarget]
    SourceThreadPriority = NORMAL
    TargetThreadPriority = NORMAL
    SkippedTablesCount = 0
    UseLZCompression = False
    RemoveEncryption = False
    Left = 53
    Top = 148
  end
  object BackupDatabase: TnxDatabase
    Left = 19
    Top = 150
  end
  object RutasEquipoMovilTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RutasEquipoMovil'
    IndexFieldNames = 'CodigoEquipoMovil;NroOrden;CodigoRuta'
    Left = 349
    Top = 42
  end
end
