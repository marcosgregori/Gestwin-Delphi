object BoxEmvForm: TBoxEmvForm
  Left = 538
  Top = 286
  HelpType = htKeyword
  HelpKeyword = 'b_emv'
  HelpContext = 1129
  BorderStyle = bsDialog
  Caption = 'Exportaci'#243'n e importaci'#243'n de movimientos de venta'
  ClientHeight = 525
  ClientWidth = 559
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
  object DataPanel: TgxEditPanel
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
    Height = 484
    Width = 549
    object OpcionesExportacionPanel: TcxGroupBox
      Left = 2
      Top = 206
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 1
      DesignSize = (
        545
        261)
      Height = 261
      Width = 545
      object gxRangeBox1: TgxRangeBox
        Left = 137
        Top = 96
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object gxRangeBox2: TgxRangeBox
        Left = 137
        Top = 150
        Width = 13
        Height = 37
        ParentShowHint = False
        ShowHint = True
      end
      object ReferenciasPedidosCtrl: TcxDBCheckBox
        Left = 5
        Top = 195
        AutoSize = False
        Caption = '&Mantener las referencias a pedidos'
        DataBinding.DataField = 'ReferenciasPedidos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 7
        Transparent = True
        Height = 38
        Width = 166
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 151
        Top = 87
        CaptionLabel = DocInicialLabel
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = FechalCtrlPropertiesValidate
        TabOrder = 3
        Width = 100
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 151
        Top = 114
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = FechalCtrlPropertiesValidate
        TabOrder = 4
        Width = 100
      end
      object ClienteInicialCtrl: TcxDBTextEdit
        Left = 151
        Top = 141
        CaptionLabel = Label1
        DescriptionLabel = Label5
        DataBinding.DataField = 'ClienteInicial'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftZero
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 5
        Width = 46
      end
      object ClienteFinalCtrl: TcxDBTextEdit
        Left = 151
        Top = 168
        DescriptionLabel = Label6
        DataBinding.DataField = 'ClienteFinal'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = ClienteCtrlPropertiesQueryRequest
        Properties.TextEditPad = tpLeftHighest
        Properties.PadAlways = True
        Properties.OnValidate = ClienteCtrlPropertiesValidate
        TabOrder = 6
        Width = 46
      end
      object SituacionCtrl: TcxDBIndexedComboBox
        Left = 152
        Top = 2
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
        TabOrder = 0
        Width = 191
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 151
        Top = 60
        CaptionLabel = CaptionSerieLabel
        DescriptionLabel = DescSerieLabel
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = SerieCtrlPropertiesQueryRequest
        Properties.PadAlways = True
        Properties.OnValidate = SerieCtrlPropertiesValidate
        TabOrder = 2
        Width = 28
      end
      object TodasLasSeriesCtrl: TcxDBCheckBox
        Left = 5
        Top = 31
        AutoSize = False
        Caption = 'Todas las series'
        DataBinding.DataField = 'TodasLasSeries'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.NullStyle = nssUnchecked
        Properties.OnEditValueChanged = TodasLasSeriesCtrlPropertiesEditValueChanged
        Style.BorderStyle = ebsNone
        Style.HotTrack = True
        Style.Shadow = False
        Style.TransparentBorder = False
        TabOrder = 1
        Transparent = True
        Height = 25
        Width = 165
      end
      object DocInicialLabel: TcxLabel
        Left = 7
        Top = 90
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label1: TcxLabel
        Left = 7
        Top = 144
        TabStop = False
        Caption = 'Cliente'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object Label4: TcxLabel
        Left = 7
        Top = 6
        TabStop = False
        Caption = 'Situaci'#243'n'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object Label5: TcxLabel
        Left = 210
        Top = 142
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 12
        Transparent = True
        Height = 20
        Width = 320
        AnchorY = 152
      end
      object Label6: TcxLabel
        Left = 210
        Top = 169
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 13
        Transparent = True
        Height = 20
        Width = 320
        AnchorY = 179
      end
      object CaptionSerieLabel: TcxLabel
        Left = 7
        Top = 63
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 14
        Transparent = True
      end
      object DescSerieLabel: TcxLabel
        Left = 210
        Top = 61
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        TabOrder = 15
        Transparent = True
        Height = 20
        Width = 320
        AnchorY = 71
      end
      object RenumerarDocumentosCtrl: TcxDBCheckBox
        Left = 5
        Top = 235
        AutoSize = False
        Caption = 'Renumerar documentos'
        DataBinding.DataField = 'RenumerarDocumentos'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.FullFocusRect = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        Style.TransparentBorder = False
        TabOrder = 8
        Transparent = True
        Height = 21
        Width = 166
      end
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      DesignSize = (
        545
        204)
      Height = 204
      Width = 545
      object Shape1: TShape
        Left = 8
        Top = 168
        Width = 522
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        Pen.Color = clBtnShadow
        ExplicitWidth = 530
      end
      object DestinoOrigenCtrl: TcxDBRadioGroup
        Left = 141
        Top = 57
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
        Height = 53
        Width = 202
      end
      object destinoOrigenLabel: TcxLabel
        Left = 8
        Top = 64
        TabStop = False
        Caption = 'Destino'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 7
        Transparent = True
      end
      object DireccionCorreoCtrl: TcxDBTextEdit
        Left = 151
        Top = 138
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
        Width = 28
      end
      object ExaminarButton: TgBitBtn
        Left = 434
        Top = 109
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
        OnClick = ExaminarButtonClick
        GlyphBitmap = gmFolder
      end
      object FormatoCtrl: TcxDBIndexedComboBox
        Left = 151
        Top = 5
        DataBinding.DataField = 'Formato'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = TipoExportacionValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'GESTWIN'
          'Texto delimitado por comas (ASCII)')
        TabOrder = 0
        Width = 211
      end
      object Label10: TcxLabel
        Left = 210
        Top = 144
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Enabled = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 8
        Transparent = True
        Height = 19
        Width = 320
      end
      object Label2: TcxLabel
        Left = 8
        Top = 36
        TabStop = False
        Caption = 'Proceso'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 9
        Transparent = True
      end
      object Label3: TcxLabel
        Left = 8
        Top = 113
        TabStop = False
        Caption = 'Directorio'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 10
        Transparent = True
      end
      object Label7: TcxLabel
        Left = 8
        Top = 178
        TabStop = False
        Caption = 'Tipo de documento'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 11
        Transparent = True
      end
      object Label8: TcxLabel
        Left = 8
        Top = 9
        TabStop = False
        Caption = 'Formato'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 12
        Transparent = True
      end
      object Label9: TcxLabel
        Left = 8
        Top = 141
        TabStop = False
        Caption = 'Direcci'#243'n de correo'
        Enabled = False
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 13
        Transparent = True
      end
      object PathCtrl: TcxDBTextEdit
        Left = 151
        Top = 110
        Anchors = [akLeft, akTop, akRight]
        DataBinding.DataField = 'Path'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.OnValidate = PathCtrlPropertiesValidate
        TabOrder = 3
        Width = 277
      end
      object ProcesoCtrl: TcxDBIndexedComboBox
        Left = 151
        Top = 32
        DataBinding.DataField = 'Proceso'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = TipoExportacionValuePosted
        Properties.Alignment.Horz = taLeftJustify
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Exportar'
          'Importar')
        TabOrder = 1
        Width = 97
      end
      object TipoMovimientoCtrl: TcxDBRadioGroup
        Left = 142
        Top = 172
        Alignment = alCenterCenter
        DataBinding.DataField = 'TipoMovimiento'
        DataBinding.DataSource = DataSource
        Properties.OnValuePosted = TipoMovimientoCtrlPropertiesValuePosted
        Properties.Columns = 3
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Caption = 'P&resupuestos'
            Value = 13
          end
          item
            Caption = '&Pedidos'
            Value = 14
          end
          item
            Caption = 'Al&baranes'
            Value = 15
          end>
        Style.BorderStyle = ebsNone
        TabOrder = 6
        Height = 28
        Width = 342
      end
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 489
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      559
      36)
    Height = 36
    Width = 559
    object Panel3: TcxGroupBox
      Left = 194
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
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 456
    Top = 344
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstDataControl = FormatoCtrl
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnOkButton = FormManagerOkButton
    Left = 486
    Top = 16
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento'
    Left = 426
    Top = 344
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 396
    Top = 344
  end
  object ExternClienteTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 456
    Top = 374
  end
  object ExternMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 426
    Top = 374
  end
  object ExternLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 397
    Top = 375
  end
  object ExternFacturaVentasTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 337
    Top = 374
  end
  object FacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 337
    Top = 344
  end
  object EfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 307
    Top = 344
  end
  object ExternEfectoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 307
    Top = 374
  end
  object ArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 277
    Top = 344
  end
  object ExternArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 277
    Top = 374
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 455
    Top = 16
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
    object DataClienteInicial: TWideStringField
      FieldName = 'ClienteInicial'
      Size = 5
    end
    object DataClienteFinal: TWideStringField
      FieldName = 'ClienteFinal'
      Size = 5
    end
    object DataReferenciasPedidos: TBooleanField
      FieldName = 'ReferenciasPedidos'
    end
    object DataTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DataTodasLasSeries: TBooleanField
      FieldName = 'TodasLasSeries'
    end
    object DataSerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataRenumerarDocumentos: TBooleanField
      FieldName = 'RenumerarDocumentos'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 424
    Top = 16
  end
  object MovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 
      'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;' +
      'NroFactura'
    Left = 428
    Top = 404
  end
  object GrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 368
    Top = 344
  end
  object ExternGrupoLineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 367
    Top = 373
  end
end
