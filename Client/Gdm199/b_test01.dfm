object boxTest01Form: TboxTest01Form
  Left = 412
  Top = 216
  HelpType = htKeyword
  HelpContext = 4104
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Pruebas para Gestwin Contable'
  ClientHeight = 585
  ClientWidth = 890
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -18
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs40'
  Position = poDefault
  Visible = True
  PixelsPerInch = 144
  TextHeight = 25
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
    PanelStyle.CaptionIndent = 3
    ParentBackground = False
    ParentColor = False
    Style.BorderStyle = ebsSingle
    Style.Color = cl3DLight
    TabOrder = 0
    PanelKind = epInputPanel
    DesignSize = (
      880
      526)
    Height = 526
    Width = 880
    object Label2: TLabel
      Left = 15
      Top = 225
      Width = 63
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Proceso'
      Transparent = True
    end
    object processLabel: TLabel
      Left = 101
      Top = 221
      Width = 589
      Height = 33
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object infoLabel: TLabel
      Left = 24
      Top = 270
      Width = 590
      Height = 33
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object counterLabel: TLabel
      Left = 450
      Top = 186
      Width = 164
      Height = 32
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -23
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object ResultadoLabel: TLabel
      Left = 410
      Top = 443
      Width = 432
      Height = 33
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object ProgressBar: TProgressBar
      Left = 15
      Top = 323
      Width = 842
      Height = 25
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object CancelarButton: TgBitBtn
      Left = 276
      Top = 357
      Width = 128
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Ca&ncelar'
      Enabled = False
      OptionsImage.ImageIndex = 14
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 6
      OptionsImage.Spacing = 8
      TabOrder = 1
      OnClick = CancelarButtonClick
      GlyphBitmap = gmDeleteField
    end
    object IniciarButton: TgBitBtn
      Left = 15
      Top = 357
      Width = 128
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Iniciar'
      Enabled = True
      OptionsImage.ImageIndex = 43
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 6
      OptionsImage.Spacing = 8
      TabOrder = 2
      OnClick = IniciarButtonClick
      GlyphBitmap = gmRight
    end
    object PruebaCtrl: TcxDBRadioGroup
      Left = 15
      Top = 9
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Prueba'
      DataBinding.DataField = 'Prueba'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Modificaci'#243'n de asientos'
          Value = 0
        end
        item
          Caption = 'Inserci'#243'n de asientos'
          Value = 1
        end
        item
          Caption = 'Inserci'#243'n de movimientos de almac'#233'n'
          Value = 2
        end
        item
          Caption = 'Inserci'#243'n de documentos de carga'
          Value = 3
        end
        item
          Caption = 'Transacciones'
          Value = 4
        end>
      Properties.OnEditValueChanged = cxDBRadioGroup1PropertiesEditValueChanged
      TabOrder = 3
      Height = 200
      Width = 377
    end
    object TipoMovimientoCtrl: TcxDBIndexedComboBox
      Left = 417
      Top = 18
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Oferta'
        'Pedido de compra'
        'Albaran de compra'
        'Presupuesto'
        'Pedido de venta'
        'Albaran de venta')
      TabOrder = 4
      OnClick = TipoMovimientoCtrlClick
      Width = 273
    end
    object NroLineasCtrl: TcxSpinEdit
      Left = 584
      Top = 54
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 5
      Value = 10
      Width = 106
    end
    object cxLabel1: TcxLabel
      Left = 417
      Top = 57
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabStop = False
      Caption = 'N'#186' medio de l'#237'neas'
      TabOrder = 6
      Transparent = True
    end
    object FacturarCtrl: TcxDBCheckBox
      Left = 410
      Top = 92
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Facturar'
      DataBinding.DataField = 'Facturar'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueGrayed = ''
      TabOrder = 7
      Transparent = True
    end
    object ContinuarButton: TgBitBtn
      Left = 144
      Top = 357
      Width = 128
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Continuar'
      Enabled = False
      OptionsImage.ImageIndex = 49
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 6
      OptionsImage.Spacing = 8
      TabOrder = 8
      OnClick = IniciarButtonClick
      GlyphBitmap = gmRefresh
    end
    object PasoApasoCtrl: TcxDBCheckBox
      Left = 410
      Top = 125
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Paso a paso'
      DataBinding.DataField = 'PasoApaso'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueGrayed = ''
      TabOrder = 9
      Transparent = True
    end
    object FechaCtrl: TcxDBDateEdit
      Left = 15
      Top = 441
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataBinding.DataField = 'Fecha'
      DataBinding.DataSource = DataSource
      TabOrder = 10
      Width = 152
    end
    object NroRegistroCtrl: TcxDBSpinEdit
      Left = 171
      Top = 441
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      DataBinding.DataField = 'NroRegistro'
      DataBinding.DataSource = DataSource
      TabOrder = 11
      Width = 65
    end
    object TestButton: TgBitBtn
      Left = 252
      Top = 438
      Width = 128
      Height = 42
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Test'
      Enabled = True
      OptionsImage.ImageIndex = 33
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 6
      OptionsImage.Spacing = 8
      TabOrder = 12
      OnClick = TestButtonClick
      GlyphBitmap = gmGears
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 15
      Top = 477
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'SQL'
      DataBinding.DataField = 'SQL'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.ValueGrayed = ''
      TabOrder = 13
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 531
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
      890
      54)
    Height = 54
    Width = 890
    object Panel3: TcxGroupBox
      Left = 381
      Top = 5
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
      Width = 131
      object CloseButton: TgBitBtn
        Left = 0
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
        TabOrder = 0
        GlyphBitmap = gmClose
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnCloseButton = FormManagerCloseButton
    Left = 515
    Top = 179
  end
  object AsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 452
    Top = 224
  end
  object ApunteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    AutoIncFieldName = 'NroApunte'
    Left = 386
    Top = 224
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 445
    Top = 179
    object DataPrueba: TSmallintField
      FieldName = 'Prueba'
    end
    object DataTodos: TBooleanField
      FieldName = 'Todos'
    end
    object DataTexto: TWideStringField
      FieldName = 'Texto'
      Size = 4
    end
    object DataFacturar: TBooleanField
      FieldName = 'Facturar'
    end
    object DataPasoApaso: TBooleanField
      FieldName = 'PasoApaso'
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object DataSQL: TBooleanField
      FieldName = 'SQL'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 385
    Top = 179
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    TableType = ttRecover
    Left = 517
    Top = 228
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 453
    Top = 273
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 517
    Top = 275
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 451
    Top = 320
  end
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 390
    Top = 317
  end
  object GrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 389
    Top = 270
  end
  object CargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Carga'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroLinea'
    Left = 693
    Top = 266
    object CargaTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object CargaTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object CargaTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object CargaTableCodigoFabrica: TWideStringField
      FieldName = 'CodigoFabrica'
      Size = 4
    end
    object CargaTableReferencia: TWideStringField
      FieldName = 'Referencia'
      Size = 40
    end
    object CargaTableHora: TTimeField
      FieldName = 'Hora'
    end
  end
  object DocumentoControlMercanciasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DocumentoControlMercancias'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    TableType = ttRecover
    Left = 743
    Top = 266
    object DocumentoControlMercanciasTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
      Required = True
    end
    object DocumentoControlMercanciasTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      Required = True
    end
    object DocumentoControlMercanciasTableCodigoNaviera: TWideStringField
      FieldName = 'CodigoNaviera'
      Size = 2
    end
    object DocumentoControlMercanciasTableFechaCarga: TDateField
      FieldName = 'FechaCarga'
    end
  end
  object TiposIVATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    Left = 638
    Top = 263
    object TiposIVATableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object TiposIVATableCodigo: TSmallintField
      FieldName = 'Codigo'
      Required = True
    end
    object TiposIVATableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 15
    end
    object TiposIVATableIVASoportado: TBCDField
      FieldName = 'IVASoportado'
      Precision = 16
    end
    object TiposIVATableCtaSoportado: TWideStringField
      FieldName = 'CtaSoportado'
      Size = 9
    end
    object TiposIVATableIVAREpercutido: TBCDField
      FieldName = 'IVAREpercutido'
      Precision = 16
    end
    object TiposIVATableRERepercutido: TBCDField
      FieldName = 'RERepercutido'
      Precision = 16
    end
    object TiposIVATableCtaRepercutido: TWideStringField
      FieldName = 'CtaRepercutido'
      Size = 9
    end
    object TiposIVATableLiquidable: TBooleanField
      FieldName = 'Liquidable'
    end
    object TiposIVATableSobreTotal: TBooleanField
      FieldName = 'SobreTotal'
    end
    object TiposIVATableCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
  end
end
