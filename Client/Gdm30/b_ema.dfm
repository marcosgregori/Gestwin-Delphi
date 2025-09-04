object BoxEmaForm: TBoxEmaForm
  Left = 538
  Top = 286
  HelpType = htKeyword
  HelpKeyword = 'b_ema'
  HelpContext = 1129
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de movimientos de almac'#233'n'
  ClientHeight = 503
  ClientWidth = 557
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
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
    DesignSize = (
      547
      462)
    Height = 462
    Width = 547
    object Shape1: TShape
      Left = 8
      Top = 167
      Width = 531
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
    end
    object PathCtrl: TcxDBTextEdit
      Left = 136
      Top = 108
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Path'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = PathCtrlPropertiesValidate
      TabOrder = 3
      Width = 299
    end
    object ExaminarButton: TgBitBtn
      Left = 442
      Top = 107
      Width = 101
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'E&xaminar ...'
      Enabled = True
      OptionsImage.ImageIndex = 21
      OptionsImage.Images = ApplicationContainer.ButtonImageList
      OptionsImage.Margin = 4
      OptionsImage.Spacing = 5
      TabOrder = 4
      TabStop = False
      OnClick = ExaminarButtonClick
      GlyphBitmap = gmFolder
    end
    object FormatoCtrl: TcxDBIndexedComboBox
      Left = 136
      Top = 8
      DataBinding.DataField = 'Formato'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'GESTWIN'
        'Texto delimitado por comas (ASCII)')
      Properties.OnEditValueChanged = FormatoCtrlPropertiesEditValueChanged
      TabOrder = 0
      Width = 212
    end
    object DestinoOrigenCtrl: TcxDBRadioGroup
      Left = 136
      Top = 63
      Alignment = alCenterCenter
      DataBinding.DataField = 'DestinoOrigen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Fichero'
          Value = 0
        end
        item
          Caption = 'Correo electr'#243'nico (e-mail)'
          Value = 1
        end>
      Properties.OnEditValueChanged = DestinoOrigenCtrlPropertiesEditValueChanged
      TabOrder = 2
      Height = 42
      Width = 192
    end
    object DireccionCorreoCtrl: TcxDBTextEdit
      Left = 136
      Top = 136
      CaptionLabel = Label9
      DescriptionLabel = Label10
      DataBinding.DataField = 'DireccionCorreo'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
      Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
      TabOrder = 5
      Width = 35
    end
    object ProcesoCtrl: TcxDBIndexedComboBox
      Left = 136
      Top = 35
      DataBinding.DataField = 'Proceso'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'Exportar'
        'Importar')
      Properties.OnEditValueChanged = ProcesoCtrlPropertiesEditValueChanged
      TabOrder = 1
      Width = 98
    end
    object TipoMovimientoCtrl: TcxDBSpinEdit
      Left = 136
      Top = 200
      DescriptionLabel = Label20
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
      Properties.DisplayFormat = '#'
      Properties.EditFormat = '#'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
      TabOrder = 6
      Width = 57
    end
    object TodosLosTiposCtrl: TcxDBCheckBox
      Left = 11
      Top = 174
      AutoSize = False
      Caption = 'Todos los tipos'
      DataBinding.DataField = 'TodosLosTipos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = TodosLosTiposCtrlPropertiesEditValueChanged
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
      Height = 25
      Width = 141
    end
    object PageControl: TcxPageControl
      Left = 6
      Top = 309
      Width = 535
      Height = 99
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 8
      Properties.ActivePage = TabSheet1
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 95
      ClientRectLeft = 4
      ClientRectRight = 531
      ClientRectTop = 28
      object TabSheet1: TcxTabSheet
        Caption = 'N'#186' de operaci'#243'n'
        object gxRangeBox1: TgxRangeBox
          Left = 107
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object NroOperacionInicialCtrl: TcxDBSpinEdit
          Left = 124
          Top = 6
          DataBinding.DataField = 'NroOperacionInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 80
        end
        object NroOperacionFinalCtrl: TcxDBSpinEdit
          Left = 124
          Top = 33
          DataBinding.DataField = 'NroOperacionFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 80
        end
        object Label4: TcxLabel
          Left = 2
          Top = 9
          TabStop = False
          Caption = 'N'#186' operaci'#243'n'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
      object TabSheet2: TcxTabSheet
        Caption = 'Fecha'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitWidth = 535
        ExplicitHeight = 71
        object gxRangeBox2: TgxRangeBox
          Left = 103
          Top = 12
          Width = 13
          Height = 37
          ParentShowHint = False
          ShowHint = True
        end
        object FechaInicialCtrl: TcxDBDateEdit
          Left = 120
          Top = 6
          DataBinding.DataField = 'FechaInicial'
          DataBinding.DataSource = DataSource
          TabOrder = 0
          Width = 100
        end
        object FechaFinalCtrl: TcxDBDateEdit
          Left = 120
          Top = 33
          DataBinding.DataField = 'FechaFinal'
          DataBinding.DataSource = DataSource
          TabOrder = 1
          Width = 100
        end
        object docInicialLabel: TcxLabel
          Left = 2
          Top = 9
          TabStop = False
          Caption = 'Fecha'
          Style.TransparentBorder = False
          Properties.Alignment.Horz = taLeftJustify
          TabOrder = 2
          Transparent = True
        end
      end
    end
    object ValoracionInventarioCtrl: TcxDBIndexedComboBox
      Left = 136
      Top = 255
      DataBinding.DataField = 'PrecioCoste'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        'Mejor coste disponible'
        'Coste medio'
        'Ultimo precio de compra'
        'Precio de la ficha del art'#237'culo')
      TabOrder = 9
      Width = 173
    end
    object ValorarInventariosCtrl: TcxDBCheckBox
      Left = 10
      Top = 228
      AutoSize = False
      Caption = 'Valorar inventarios'
      DataBinding.DataField = 'ValorarInventarios'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Alignment = taRightJustify
      Properties.ImmediatePost = True
      Properties.NullStyle = nssUnchecked
      Properties.OnEditValueChanged = ValorarInventariosCtrlPropertiesEditValueChanged
      Style.TransparentBorder = False
      TabOrder = 10
      Transparent = True
      Height = 25
      Width = 142
    end
    object Label2: TcxLabel
      Left = 11
      Top = 38
      TabStop = False
      Caption = 'Proceso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 11
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 11
      Top = 112
      TabStop = False
      Caption = 'Path (directorio)'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 12
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 11
      Top = 12
      TabStop = False
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object destinoOrigenLabel: TcxLabel
      Left = 11
      Top = 62
      TabStop = False
      Caption = 'Destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 11
      Top = 139
      TabStop = False
      Caption = 'Direcci'#243'n de correo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 213
      Top = 139
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
      Height = 19
      Width = 324
    end
    object Label19: TcxLabel
      Left = 11
      Top = 203
      TabStop = False
      Caption = 'Tipo de movimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object Label20: TcxLabel
      Left = 213
      Top = 203
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 19
      Width = 312
    end
    object Label1: TcxLabel
      Left = 10
      Top = 286
      TabStop = False
      Caption = 'Seleccionar movimientos por ...'
      Style.TextColor = clGreen
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
    end
    object Label7: TcxLabel
      Left = 11
      Top = 259
      TabStop = False
      Caption = 'Valoraci'#243'n'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object RenumerarDocumentosCtrl: TcxDBCheckBox
      Left = 10
      Top = 412
      AutoSize = False
      Caption = 'Renumerar documentos'
      DataBinding.DataField = 'RenumerarDocumentos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.FullFocusRect = True
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      Style.TransparentBorder = False
      TabOrder = 21
      Transparent = True
      Height = 38
      Width = 142
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 467
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      557
      36)
    Height = 36
    Width = 557
    object Panel3: TcxGroupBox
      Left = 193
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
    FirstDataControl = FormatoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 420
    Top = 14
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 423
    Top = 153
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 393
    Top = 153
  end
  object ExternMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 423
    Top = 183
  end
  object ExternLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 393
    Top = 183
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 361
    Top = 153
  end
  object ExternArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 361
    Top = 183
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 389
    Top = 14
    object DataProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object DataPath: TWideStringField
      FieldName = 'Path'
      Size = 125
    end
    object DataFormato: TSmallintField
      FieldName = 'Formato'
    end
    object DataDestinoOrigen: TSmallintField
      FieldName = 'DestinoOrigen'
    end
    object DataDireccionCorreo: TWideStringField
      FieldName = 'DireccionCorreo'
      Size = 2
    end
    object DataSituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataTodosLosTipos: TBooleanField
      FieldName = 'TodosLosTipos'
    end
    object DataValorarInventarios: TBooleanField
      FieldName = 'ValorarInventarios'
    end
    object DataNroOperacionInicial: TIntegerField
      FieldName = 'NroOperacionInicial'
    end
    object DataNroOperacionFinal: TIntegerField
      FieldName = 'NroOperacionFinal'
    end
    object DataPrecioCoste: TSmallintField
      FieldName = 'PrecioCoste'
    end
    object DataRenumerarDocumentos: TBooleanField
      FieldName = 'RenumerarDocumentos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 358
    Top = 14
  end
  object MovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 
      'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;' +
      'NroFactura'
    Left = 425
    Top = 213
  end
end
