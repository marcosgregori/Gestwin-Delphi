object BoxEmcForm: TBoxEmcForm
  Left = 538
  Top = 286
  HelpType = htKeyword
  HelpKeyword = 'b_emc'
  HelpContext = 1129
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de movimientos de compras'
  ClientHeight = 435
  ClientWidth = 521
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
      511
      394)
    Height = 394
    Width = 511
    object Shape1: TShape
      Left = 8
      Top = 171
      Width = 498
      Height = 1
      Anchors = [akLeft, akTop, akRight]
      Pen.Color = clBtnShadow
      ExplicitWidth = 477
    end
    object gxRangeBox1: TgxRangeBox
      Left = 129
      Top = 244
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 129
      Top = 298
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ReferenciasPedidosCtrl: TcxDBCheckBox
      Left = 6
      Top = 341
      Hint = 'Mantener las referencias a pedidos'
      AutoSize = False
      Caption = '&Mantener las referencias a pedidos'
      DataBinding.DataField = 'ReferenciasPedidos'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 12
      Transparent = True
      Height = 36
      Width = 157
    end
    object PathCtrl: TcxDBTextEdit
      Left = 143
      Top = 114
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Path'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = PathCtrlPropertiesValidate
      TabOrder = 3
      Width = 254
    end
    object ExaminarButton: TgBitBtn
      Left = 405
      Top = 113
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
      Left = 143
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
      Width = 222
    end
    object DestinoOrigenCtrl: TcxDBRadioGroup
      Left = 134
      Top = 61
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
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Height = 54
      Width = 194
    end
    object DireccionCorreoCtrl: TcxDBTextEdit
      Left = 143
      Top = 141
      CaptionLabel = Label9
      DescriptionLabel = Label10
      DataBinding.DataField = 'DireccionCorreo'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.Required = True
      Properties.OnQueryRequest = DireccionCorreoCtrlPropertiesQueryRequest
      Properties.OnEditRequest = DireccionCorreoCtrlPropertiesEditRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = DireccionCorreoCtrlPropertiesValidate
      TabOrder = 5
      Width = 25
    end
    object ProcesoCtrl: TcxDBIndexedComboBox
      Left = 143
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
      Width = 97
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 143
      Top = 235
      CaptionLabel = DocInicialLabel
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 8
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 143
      Top = 262
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      Properties.OnValidate = FechaCtrlPropertiesValidate
      TabOrder = 9
      Width = 100
    end
    object ProveedorInicialCtrl: TcxDBTextEdit
      Left = 143
      Top = 289
      CaptionLabel = Label1
      DescriptionLabel = Label5
      DataBinding.DataField = 'ProveedorInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 10
      Width = 46
    end
    object ProveedorFinalCtrl: TcxDBTextEdit
      Left = 143
      Top = 316
      DescriptionLabel = Label6
      DataBinding.DataField = 'ProveedorFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ProveedorCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftHighest
      Properties.PadAlways = True
      Properties.OnValidate = ProveedorCtrlPropertiesValidate
      TabOrder = 11
      Width = 46
    end
    object SituacionCtrl: TcxDBIndexedComboBox
      Left = 143
      Top = 208
      CaptionLabel = Label4
      DataBinding.DataField = 'Situacion'
      DataBinding.DataSource = DataSource
      Properties.Alignment.Horz = taLeftJustify
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '<Todos>'
        'No facturables'
        'Pendientes de facturar'
        'Facturados'
        'Pendientes de contabilizar'
        'Contabilizados')
      Properties.OnEditValueChanged = SituacionCtrlPropertiesEditValueChanged
      TabOrder = 7
      Width = 191
    end
    object TipoMovimientoCtrl: TcxDBRadioGroup
      Left = 134
      Top = 178
      Alignment = alCenterCenter
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.Columns = 3
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = '&Ofertas'
          Value = 10
        end
        item
          Caption = '&Pedidos'
          Value = 11
        end
        item
          Caption = 'Al&baranes'
          Value = 12
        end>
      Properties.OnEditValueChanged = TipoMovimientoCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 6
      Height = 28
      Width = 288
    end
    object Label2: TcxLabel
      Left = 8
      Top = 39
      TabStop = False
      Caption = 'Proceso'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 13
      Transparent = True
    end
    object Label3: TcxLabel
      Left = 8
      Top = 117
      TabStop = False
      Caption = 'Directorio'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 14
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 8
      Top = 12
      TabStop = False
      Caption = 'Formato'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 15
      Transparent = True
    end
    object destinoOrigenLabel: TcxLabel
      Left = 8
      Top = 66
      TabStop = False
      Caption = 'Destino'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 8
      Top = 145
      TabStop = False
      Caption = 'Direcci'#243'n de correo'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 231
      Top = 145
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
      Height = 19
      Width = 275
    end
    object DocInicialLabel: TcxLabel
      Left = 8
      Top = 234
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
    end
    object Label1: TcxLabel
      Left = 8
      Top = 292
      TabStop = False
      Caption = 'Proveedor'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object Label4: TcxLabel
      Left = 8
      Top = 212
      TabStop = False
      Caption = 'Situaci'#243'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
    end
    object Label5: TcxLabel
      Left = 231
      Top = 292
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 22
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label6: TcxLabel
      Left = 231
      Top = 319
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 23
      Transparent = True
      Height = 19
      Width = 275
    end
    object Label7: TcxLabel
      Left = 8
      Top = 183
      TabStop = False
      Caption = 'Tipo de documento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 24
      Transparent = True
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 399
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      521
      36)
    Height = 36
    Width = 521
    object Panel3: TcxGroupBox
      Left = 175
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
  object ProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 458
    Top = 254
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FormatoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 476
    Top = 12
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 428
    Top = 254
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 398
    Top = 254
  end
  object ExternProveedorTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 458
    Top = 284
  end
  object ExternMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 428
    Top = 284
  end
  object ExternLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 398
    Top = 284
  end
  object ExternFacturaComprasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 368
    Top = 284
  end
  object FacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Proveedor;Fecha'
    Left = 368
    Top = 254
  end
  object EfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 338
    Top = 254
  end
  object ExternEfectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 338
    Top = 284
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 308
    Top = 254
  end
  object ExternArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 308
    Top = 284
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 445
    Top = 12
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
    object DataProveedorInicial: TWideStringField
      FieldName = 'ProveedorInicial'
      Size = 5
    end
    object DataProveedorFinal: TWideStringField
      FieldName = 'ProveedorFinal'
      Size = 5
    end
    object DataReferenciasPedidos: TBooleanField
      FieldName = 'ReferenciasPedidos'
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 414
    Top = 12
  end
  object MovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 
      'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;' +
      'NroFactura'
    Left = 430
    Top = 314
  end
  object MovimientoOrigenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 430
    Top = 346
  end
end
