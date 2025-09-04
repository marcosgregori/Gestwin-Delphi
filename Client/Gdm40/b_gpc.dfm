object BoxGpcForm: TBoxGpcForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_mve'
  BorderStyle = bsDialog
  Caption = 'Generaci'#243'n de pedidos de compra por proveedor'
  ClientHeight = 507
  ClientWidth = 946
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
  object ButtonPanel: TgxEditPanel
    Left = 0
    Top = 471
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    PanelKind = epButtonsPanel
    DesignSize = (
      946
      36)
    Height = 36
    Width = 946
    object Panel3: TcxGroupBox
      Left = 389
      Top = 4
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
        Enabled = False
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
  object DataPanel: TgxEditPanel
    AlignWithMargins = True
    Left = 5
    Top = 153
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
    TabOrder = 1
    PanelKind = epInputPanel
    Height = 318
    Width = 936
    object LinesGrid: TcxGrid
      Left = 2
      Top = 2
      Width = 894
      Height = 267
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object LinesView: TcxGridDBTableView
        Tag = 256402344
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = LinesViewCustomDrawCell
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = LineaMovimientoDataSource
        DataController.KeyFieldNames = 'NroRegistro'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <
          item
            Links = <
              item
                Column = LinesViewEjercicio
              end>
            SummaryItems = <>
          end
          item
            Links = <
              item
                Column = LinesViewCabeceraPedido
              end>
            SummaryItems = <>
          end>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Preview.Column = LinesViewAnotacion
        Preview.LeftIndent = 25
        Preview.Visible = True
        object LinesViewCabeceraProveedor: TcxGridDBColumn
          DataBinding.FieldName = 'CabeceraProveedor'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Visible = False
          OnGetDisplayText = LinesViewCabeceraProveedorGetDisplayText
          GroupIndex = 0
        end
        object LinesViewCabeceraPedido: TcxGridDBColumn
          DataBinding.FieldName = 'CabeceraPedido'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Visible = False
          OnGetDisplayText = LinesViewCabeceraPedidoGetDisplayText
          GroupIndex = 1
        end
        object LinesViewSeleccionLinea: TcxGridDBColumn
          DataBinding.FieldName = 'SeleccionLinea'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Width = 20
        end
        object LinesViewEjercicio: TcxGridDBColumn
          DataBinding.FieldName = 'Ejercicio'
          Visible = False
        end
        object LinesViewNroLinea: TcxGridDBColumn
          DataBinding.FieldName = 'NroLinea'
          Visible = False
        end
        object LinesViewNroRegistro: TcxGridDBColumn
          DataBinding.FieldName = 'NroRegistro'
          Visible = False
        end
        object LinesViewCodigoArticulo: TcxGridDBColumn
          Caption = 'Articulo'
          DataBinding.FieldName = 'CodigoArticulo'
          Width = 90
        end
        object LinesViewCodigoClaseA: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Width = 22
        end
        object LinesViewCodigoClaseB: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Width = 22
        end
        object LinesViewCodigoClaseC: TcxGridDBColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Width = 21
        end
        object LinesViewDescripcion: TcxGridDBColumn
          DataBinding.FieldName = 'Descripcion'
          Width = 230
        end
        object LinesViewCodigoAlmacen: TcxGridDBColumn
          Caption = 'Alm.'
          DataBinding.FieldName = 'CodigoAlmacen'
          HeaderHint = 'Almac'#233'n'
          Width = 27
        end
        object LinesViewUbicacion: TcxGridDBColumn
          Caption = 'Ubic.'
          DataBinding.FieldName = 'Ubicacion'
          HeaderHint = 'Ubicaci'#243'n'
          Width = 54
        end
        object LinesViewCantidad: TcxGridDBColumn
          Caption = 'Cantidad'
          DataBinding.FieldName = 'CantidadAjustada'
          Width = 80
        end
        object LinesViewCantidadCargada: TcxGridDBColumn
          Caption = 'Cargado'
          DataBinding.FieldName = 'CantidadCargada'
          Visible = False
        end
        object LinesViewServido: TcxGridDBColumn
          Caption = 'Servido'
          DataBinding.FieldName = 'CantidadProcesada'
          Width = 80
        end
        object LinesViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          Width = 70
        end
        object LinesViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 43
        end
        object LinesViewImporteNeto: TcxGridDBColumn
          Caption = 'Importe'
          DataBinding.FieldName = 'ImporteNeto'
          Width = 100
        end
        object LinesViewAnotacion: TcxGridDBColumn
          Caption = 'Anotaci'#243'n'
          DataBinding.FieldName = 'Anotacion'
          PropertiesClassName = 'TcxRichEditProperties'
        end
      end
      object LinesLevel: TcxGridLevel
        GridView = LinesView
      end
    end
    object FooterPanel: TcxGroupBox
      Left = 2
      Top = 269
      Align = alBottom
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = True
      TabOrder = 1
      Height = 47
      Width = 932
      object HintLabel: TcxLabel
        AlignWithMargins = True
        Left = 2
        Top = 5
        Margins.Left = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Align = alClient
        Style.TextColor = clGray
        Properties.WordWrap = True
        TabOrder = 0
        Transparent = True
        Width = 837
      end
      object TodoButton: TgBitBtn
        AlignWithMargins = True
        Left = 842
        Top = 8
        Width = 85
        Height = 31
        Hint = 'Selecciona todas las l'#237'neas'
        Margins.Top = 6
        Margins.Bottom = 6
        Align = alRight
        Caption = '&Todas'
        Enabled = True
        ModalResult = 8
        OptionsImage.ImageIndex = 9
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TabStop = False
        OnClick = TodoButtonClick
        GlyphBitmap = gmAll
      end
    end
    object LinesViewManager: TGridTableViewController
      Left = 896
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      TableView = LinesView
      ShiftRecords = False
      UseGridFilterBox = False
      OnUserSelection = LinesViewManagerUserSelection
      Height = 267
      Width = 38
    end
  end
  object KeyPanel: TgxEditPanel
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    PanelKind = epKeyPanel
    Height = 148
    Width = 946
    object cxGroupBox1: TcxGroupBox
      Left = 6
      Top = 90
      Align = alClient
      Caption = '  Selecci'#243'n de pedidos de venta'
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextColor = clGreen
      Style.TextStyle = []
      TabOrder = 1
      Height = 56
      Width = 938
      object Label6: TcxLabel
        Left = 22
        Top = 28
        TabStop = False
        Caption = 'Desde el'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 0
        Transparent = True
      end
      object FechaInicialCtrl: TcxDBDateEdit
        Left = 104
        Top = 26
        DataBinding.DataField = 'FechaInicial'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.ImmediatePost = True
        TabOrder = 1
        Width = 100
      end
      object FechaFinalCtrl: TcxDBDateEdit
        Left = 268
        Top = 26
        DataBinding.DataField = 'FechaFinal'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.ImmediatePost = True
        TabOrder = 2
        Width = 100
      end
      object cxLabel1: TcxLabel
        Left = 212
        Top = 29
        TabStop = False
        Caption = 'hasta el'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
      end
      object IncluirIVACtrl: TcxDBCheckBox
        Left = 378
        Top = 26
        AutoSize = False
        Caption = 'Fecha de entrega'
        DataBinding.DataField = 'FechaEntrega'
        DataBinding.DataSource = DataSource
        Properties.Alignment = taRightJustify
        Properties.ImmediatePost = True
        Properties.MultiLine = True
        Properties.NullStyle = nssUnchecked
        TabOrder = 4
        Transparent = True
        Height = 23
        Width = 147
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 2
      Top = 2
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TextColor = clGreen
      Style.TextStyle = []
      TabOrder = 0
      DesignSize = (
        942
        88)
      Height = 88
      Width = 942
      object CodigoProveedorCtrl: TcxDBTextEdit
        Left = 106
        Top = 4
        DescriptionLabel = Label16
        DataBinding.DataField = 'CodigoProveedor'
        DataBinding.DataSource = DataSource
        Properties.OnQueryRequest = CodigoProveedorCtrlPropertiesQueryRequest
        Properties.OnEditRequest = CodigoProveedorCtrlPropertiesEditRequest
        Properties.TextEditPad = tpLeftZero
        Properties.OnValidate = CodigoProveedorCtrlPropertiesValidate
        TabOrder = 0
        Width = 46
      end
      object cxLabel2: TcxLabel
        Left = 10
        Top = 63
        TabStop = False
        Caption = 'Fecha'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Transparent = True
      end
      object FechaCtrl: TcxDBDateEdit
        Left = 106
        Top = 58
        DataBinding.DataField = 'Fecha'
        DataBinding.DataSource = DataSource
        Properties.Required = True
        Properties.ImmediatePost = True
        TabOrder = 2
        Width = 100
      end
      object Label16: TcxLabel
        Left = 183
        Top = 7
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Style.TextColor = clNavy
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Transparent = True
        Height = 19
        Width = 454
      end
      object Label3: TcxLabel
        Left = 10
        Top = 7
        TabStop = False
        Caption = 'Proveedor'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 4
        Transparent = True
      end
      object NroDocumentoCaptionLabel: TcxLabel
        Left = 10
        Top = 34
        TabStop = False
        Caption = 'Serie'
        Style.TransparentBorder = False
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 5
        Transparent = True
      end
      object SerieCtrl: TcxDBTextEdit
        Left = 106
        Top = 31
        DataBinding.DataField = 'Serie'
        DataBinding.DataSource = DataSource
        Properties.MaxLength = 8
        TabOrder = 6
        Width = 28
      end
    end
  end
  object FormManager: TgxFormManager
    Dataset = Data
    FirstKeyControl = CodigoProveedorCtrl
    FirstDataControl = LinesGrid
    Model = fmPersistentInputForm
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnCreateForm = FormManagerCreateForm
    OnDestroyForm = FormManagerDestroyForm
    OnOkButton = FormManagerOkButton
    OnFocusedAreaChanged = FormManagerFocusedAreaChanged
    Left = 848
    Top = 18
  end
  object LineaMovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Filtered = True
    OnCalcFields = LineaMovimientoQueryCalcFields
    OnFilterRecord = LineaMovimientoQueryFilterRecord
    SQL.Strings = (
      'SELECT LineaMovimiento.*,'
      '       Movimiento.Serie,'
      '       Movimiento.NroDocumento,'
      '       Movimiento.Propietario,'
      '       Articulo.CodigoProveedor'
      'FROM   LineaMovimiento'
      
        '       LEFT JOIN Movimiento ON ( LineaMovimiento.Ejercicio=Movim' +
        'iento.Ejercicio AND LineaMovimiento.NroOperacion=Movimiento.NroO' +
        'peracion )'
      
        '       LEFT JOIN Articulo ON ( LineaMovimiento.CodigoArticulo=Ar' +
        'ticulo.Codigo )'
      'WHERE 0>0')
    Left = 688
    Top = 188
    object LineaMovimientoQueryCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object LineaMovimientoQuerySeleccionProveedor: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'SeleccionProveedor'
      Calculated = True
    end
    object LineaMovimientoQuerySeleccionPedido: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'SeleccionPedido'
      Calculated = True
    end
    object LineaMovimientoQueryCabeceraProveedor: TStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraProveedor'
      Size = 80
      Calculated = True
    end
    object LineaMovimientoQueryCabeceraPedido: TStringField
      FieldKind = fkCalculated
      FieldName = 'CabeceraPedido'
      Size = 80
      Calculated = True
    end
    object LineaMovimientoQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object LineaMovimientoQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object LineaMovimientoQueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object LineaMovimientoQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoQueryNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoQuerySeleccionLinea: TBooleanField
      DisplayLabel = 'Sel.'
      DisplayWidth = 3
      FieldKind = fkCalculated
      FieldName = 'SeleccionLinea'
      Calculated = True
    end
    object LineaMovimientoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoQueryFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoQueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoQueryCantidad: TBCDField
      FieldName = 'Cantidad'
    end
    object LineaMovimientoQueryCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
    end
    object LineaMovimientoQueryCantidadCargada: TBCDField
      FieldKind = fkCalculated
      FieldName = 'CantidadCargada'
      Calculated = True
    end
    object LineaMovimientoQueryCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
    end
    object LineaMovimientoQueryProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoQueryPrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
    end
    object LineaMovimientoQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoQueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object LineaMovimientoQueryPuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
    end
    object LineaMovimientoQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoQueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object LineaMovimientoQueryImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
      Precision = 16
    end
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoQuery
    Left = 656
    Top = 188
  end
  object Data: TgxMemData
    Indexes = <>
    SortOptions = []
    Left = 688
    Top = 20
    object DataCodigoProveedor: TStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object DataSerie: TStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DataFecha: TDateField
      FieldName = 'Fecha'
    end
    object DataFechaEntrega: TBooleanField
      FieldName = 'FechaEntrega'
    end
    object DataFechaInicial: TDateField
      FieldName = 'FechaInicial'
    end
    object DataFechaFinal: TDateField
      FieldName = 'FechaFinal'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    OnDataChange = DataSourceDataChange
    Left = 656
    Top = 20
  end
  object LineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistroOrigen'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    RemoteEdit = True
    Left = 689
    Top = 257
  end
  object MovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    RemoteEdit = True
    Left = 689
    Top = 223
  end
end
