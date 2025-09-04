object RptFdaForm: TRptFdaForm
  Left = 448
  Top = 333
  HelpType = htKeyword
  HelpKeyword = 'l_fda'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Listado de fichas de art'#237'culos'
  ClientHeight = 524
  ClientWidth = 615
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
    DesignSize = (
      605
      483)
    Height = 483
    Width = 605
    object gxRangeBox1: TgxRangeBox
      Left = 173
      Top = 64
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object gxRangeBox2: TgxRangeBox
      Left = 173
      Top = 119
      Width = 13
      Height = 37
      ParentShowHint = False
      ShowHint = True
    end
    object ArticuloInicialCtrl: TcxDBTextEdit
      Left = 188
      Top = 110
      DescriptionLabel = Label4
      DataBinding.DataField = 'ArticuloInicial'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 4
      Width = 102
    end
    object ArticuloFinalCtrl: TcxDBTextEdit
      Left = 188
      Top = 137
      DescriptionLabel = Label7
      DataBinding.DataField = 'ArticuloFinal'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = ArticuloCtrlPropertiesQueryRequest
      Properties.ExpandZeroes = False
      Properties.TextEditPad = tpRightHighest
      Properties.PadAlways = True
      Properties.OnValidate = ArticuloCtrlPropertiesValidate
      TabOrder = 5
      Width = 102
    end
    object FechaInicialCtrl: TcxDBDateEdit
      Left = 188
      Top = 56
      DataBinding.DataField = 'FechaInicial'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 2
      Width = 100
    end
    object FechaFinalCtrl: TcxDBDateEdit
      Left = 188
      Top = 83
      DataBinding.DataField = 'FechaFinal'
      DataBinding.DataSource = DataSource
      Properties.Required = True
      TabOrder = 3
      Width = 100
    end
    object TipoMovimientoCtrl: TcxDBSpinEdit
      Left = 188
      Top = 164
      DescriptionLabel = Label8
      DataBinding.DataField = 'TipoMovimiento'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = TipoMovimientoCtrlPropertiesQueryRequest
      Properties.AssignedValues.MinValue = True
      Properties.ImmediatePost = True
      Properties.MaxValue = 99.000000000000000000
      Properties.OnValidate = TipoMovimientoCtrlPropertiesValidate
      TabOrder = 6
      Width = 59
    end
    object SoloConStockCtrl: TcxDBCheckBox
      Left = 5
      Top = 378
      AutoSize = False
      Caption = 'Solo art'#237'culos con existencias'
      DataBinding.DataField = 'SoloConStock'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 13
      Transparent = True
      Height = 25
      Width = 200
    end
    object MostrarPrecioNetoCtrl: TcxDBCheckBox
      Left = 5
      Top = 439
      AutoSize = False
      Caption = 'Mostrar el precio neto'
      DataBinding.DataField = 'MostrarPrecioNeto'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.NullStyle = nssUnchecked
      TabOrder = 15
      Transparent = True
      Height = 25
      Width = 200
    end
    object CodigoClaseACtrl: TcxDBTextEdit
      Tag = 1
      Left = 188
      Top = 266
      CaptionLabel = capClaseALabel
      DescriptionLabel = descClaseALabel
      DataBinding.DataField = 'CodigoClaseA'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 9
      Width = 32
    end
    object CodigoClaseBCtrl: TcxDBTextEdit
      Tag = 2
      Left = 188
      Top = 293
      CaptionLabel = capClaseBLabel
      DescriptionLabel = descClaseBLabel
      DataBinding.DataField = 'CodigoClaseB'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 10
      Width = 32
    end
    object CodigoClaseCCtrl: TcxDBTextEdit
      Tag = 3
      Left = 188
      Top = 320
      CaptionLabel = capClaseCLabel
      DescriptionLabel = descClaseCLabel
      DataBinding.DataField = 'CodigoClaseC'
      DataBinding.DataSource = DataSource
      Enabled = False
      Properties.OnQueryRequest = CodigoClaseCtrlPropertiesQueryRequest
      Properties.OnValidate = CodigoClaseCtrlPropertiesValidate
      TabOrder = 11
      Width = 32
    end
    object LoteCtrl: TcxDBTextEdit
      Left = 188
      Top = 347
      DataBinding.DataField = 'Lote'
      DataBinding.DataSource = DataSource
      Enabled = False
      TabOrder = 12
      Width = 119
    end
    object CodigoPropietarioCtrl: TcxDBTextEdit
      Left = 188
      Top = 239
      CaptionLabel = Label9
      DescriptionLabel = Label10
      DataBinding.DataField = 'CodigoPropietario'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = CodigoPropietarioCtrlPropertiesQueryRequest
      Properties.TextEditPad = tpLeftZero
      Properties.OnValidate = CodigoPropietarioCtrlPropertiesValidate
      TabOrder = 8
      Width = 46
    end
    object SeleccionAlmacenCtrl: TcxDBRadioGroup
      Left = 181
      Top = 5
      Alignment = alCenterCenter
      DataBinding.DataField = 'SeleccionAlmacen'
      DataBinding.DataSource = DataSource
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Caption = 'Todos'
          Value = 0
        end
        item
          Caption = 'Solo el ...'
          Value = 1
        end>
      Properties.OnEditValueChanged = SeleccionAlmacenCtrlPropertiesEditValueChanged
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 48
      Width = 116
    end
    object AlmacenCtrl: TcxDBTextEdit
      Left = 263
      Top = 25
      DescriptionLabel = DescAlmacenLabel
      DataBinding.DataField = 'Almacen'
      DataBinding.DataSource = DataSource
      Properties.OnQueryRequest = AlmacenCtrlPropertiesQueryRequest
      Properties.OnValidate = AlmacenCtrlPropertiesValidate
      TabOrder = 1
      Width = 26
    end
    object SoloAfectanExistenciasCtrl: TcxDBCheckBox
      Left = 5
      Top = 404
      AutoSize = False
      Caption = 'Solo art'#237'culos que afectan a las existencias'
      DataBinding.DataField = 'SoloAfectanExistencias'
      DataBinding.DataSource = DataSource
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      TabOrder = 14
      Transparent = True
      Height = 35
      Width = 200
    end
    object SoloTiposMovimientoStockCtrl: TcxDBCheckBox
      Left = 5
      Top = 192
      Hint = 
        'Marcar esta opci'#243'n supone excluir los movimientos  de las oferta' +
        's, presupuestos o pedidos de compra o venta.'
      AutoSize = False
      Caption = 'Solo tipos de movimiento que afectan a las existencias'
      DataBinding.DataField = 'SoloTiposMovimientoStock'
      DataBinding.DataSource = DataSource
      ParentShowHint = False
      Properties.Alignment = taRightJustify
      Properties.MultiLine = True
      Properties.NullStyle = nssUnchecked
      ShowHint = True
      TabOrder = 7
      Transparent = True
      Height = 46
      Width = 200
    end
    object Label3: TcxLabel
      Left = 8
      Top = 113
      TabStop = False
      Caption = 'Articulo'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 16
      Transparent = True
    end
    object Label6: TcxLabel
      Left = 8
      Top = 59
      TabStop = False
      Caption = 'Fecha'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 17
      Transparent = True
    end
    object Label2: TcxLabel
      Left = 8
      Top = 167
      TabStop = False
      Caption = 'Tipo de movimiento'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 18
      Transparent = True
    end
    object Label8: TcxLabel
      Left = 309
      Top = 167
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 19
      Transparent = True
      Height = 19
      Width = 287
    end
    object capClaseALabel: TcxLabel
      Left = 8
      Top = 269
      TabStop = False
      Caption = 'Clase A '
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 20
      Transparent = True
    end
    object capClaseBLabel: TcxLabel
      Left = 8
      Top = 296
      TabStop = False
      Caption = 'Clase B'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 21
      Transparent = True
    end
    object descClaseALabel: TcxLabel
      Left = 309
      Top = 269
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 22
      Transparent = True
      Height = 19
      Width = 290
    end
    object descClaseBLabel: TcxLabel
      Left = 309
      Top = 296
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 23
      Transparent = True
      Height = 19
      Width = 290
    end
    object capClaseCLabel: TcxLabel
      Left = 8
      Top = 323
      TabStop = False
      Caption = 'Clase C'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 24
      Transparent = True
    end
    object descClaseCLabel: TcxLabel
      Left = 309
      Top = 323
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 25
      Transparent = True
      Height = 19
      Width = 290
    end
    object Label5: TcxLabel
      Left = 9
      Top = 350
      TabStop = False
      Caption = 'Lote'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 26
      Transparent = True
    end
    object Label9: TcxLabel
      Left = 8
      Top = 242
      TabStop = False
      Caption = 'Propietario'
      Enabled = False
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 27
      Transparent = True
    end
    object Label10: TcxLabel
      Left = 309
      Top = 242
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Enabled = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 28
      Transparent = True
      Height = 19
      Width = 290
    end
    object Label1: TcxLabel
      Left = 8
      Top = 12
      TabStop = False
      Caption = 'Almac'#233'n'
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 29
      Transparent = True
    end
    object DescAlmacenLabel: TcxLabel
      Left = 308
      Top = 28
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 30
      Transparent = True
      Height = 19
      Width = 287
    end
    object Label4: TcxLabel
      Left = 309
      Top = 113
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 31
      Transparent = True
      Height = 19
      Width = 287
    end
    object Label7: TcxLabel
      Left = 309
      Top = 136
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Style.TextColor = clNavy
      Style.TransparentBorder = False
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 32
      Transparent = True
      Height = 19
      Width = 287
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 488
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      615
      36)
    Height = 36
    Width = 615
    object Panel3: TcxGroupBox
      Left = 222
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
    FirstDataControl = SeleccionAlmacenCtrl
    Model = fmReportForm
    ShowQueryOption = False
    OnInitializeForm = InitializeForm
    OnOkButton = FormManagerOkButton
    Left = 506
    Top = 14
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 476
    Top = 45
  end
  object Report: TgxReportManager
    FileName = 'dm30\l_fda'
    HideReportList = False
    SQLItems = <
      item
        Title = 'FichaArticulo'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(' +
          '40),'#13#10'NroDocumento INTEGER,'#13#10'NroLinea SMALLINT,'#13#10'NroRegistro INT' +
          'EGER,'#13#10'Fecha DATE,'#13#10'CodigoPropietario NVARCHAR(5),'#13#10'Nombre NVARC' +
          'HAR( 40 ),'#13#10'TipoMovimiento SMALLINT,'#13#10'DescripcionTipoMovimiento ' +
          'NVARCHAR(30),'#13#10'CodigoArticulo NVARCHAR(20),'#13#10'CodigoClaseA NVARCH' +
          'AR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'De' +
          'scripcion NVARCHAR(60),'#13#10'LoteFabricacion NVARCHAR(20),'#13#10'CodigoAl' +
          'macen NVARCHAR(2),'#13#10'Ubicacion NVARCHAR(6),'#13#10'Entradas BCD(16,4) ,' +
          #13#10'Salidas BCD(16,4),'#13#10'Precio Double Precision,'#13#10'Descuento BCD(16' +
          ',4),'#13#10'Existencias BCD(16,4),'#13#10'PrecioNeto BCD(16,4) );'#13#10#13#10'CREATE ' +
          'INDEX Index1 ON <TableName> ( CodigoArticulo, CodigoClaseA, Codi' +
          'goClaseB, CodigoClaseC );'#13#10
      end>
    ParamsDataset = Data
    ToPrinter = False
    Left = 476
    Top = 14
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea'
    Left = 446
    Top = 45
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 445
    Top = 14
    object DataSeleccionAlmacen: TSmallintField
      FieldName = 'SeleccionAlmacen'
    end
    object DataAlmacen: TWideStringField
      FieldName = 'Almacen'
      Size = 2
    end
    object DataArticuloInicial: TWideStringField
      FieldName = 'ArticuloInicial'
    end
    object DataArticuloFinal: TWideStringField
      FieldName = 'ArticuloFinal'
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
    object DataSoloTiposMovimientoStock: TBooleanField
      FieldName = 'SoloTiposMovimientoStock'
    end
    object DataCodigoPropietario: TWideStringField
      FieldName = 'CodigoPropietario'
      Size = 5
    end
    object DataCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object DataCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object DataCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object DataLote: TWideStringField
      FieldName = 'Lote'
    end
    object DataSoloConStock: TBooleanField
      FieldName = 'SoloConStock'
    end
    object DataSoloAfectanExistencias: TBooleanField
      FieldName = 'SoloAfectanExistencias'
    end
    object DataMostrarPrecioNeto: TBooleanField
      FieldName = 'MostrarPrecioNeto'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 412
    Top = 14
  end
end
