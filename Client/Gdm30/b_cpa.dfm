object BrwCpaForm: TBrwCpaForm
  Left = 437
  Top = 317
  HelpType = htKeyword
  HelpKeyword = 'b_cpa'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 
    'Cambio de precios de venta de art'#237'culos desde albaranes de compr' +
    'a'
  ClientHeight = 442
  ClientWidth = 1004
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
    Height = 397
    Width = 994
    object Grid: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 946
      Height = 387
      Margins.Right = 0
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      object TableView: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.GridMode = True
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = MemDataSource
        DataController.KeyFieldNames = 'NroLinea'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.BandMoving = False
        OptionsCustomize.BandSizing = False
        OptionsCustomize.BandsQuickCustomizationShowCommands = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'Compra'
            Styles.Header = CaptionStyle
          end
          item
          end
          item
            Caption = 'Venta'
            Styles.Header = CaptionStyle
          end>
        object TableViewCodigoArticulo: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CodigoArticulo'
          Options.Editing = False
          Options.Focusing = False
          Width = 86
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TableViewCodigoClaseA: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CodigoClaseA'
          Options.Editing = False
          Options.Focusing = False
          Width = 23
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object TableViewCodigoClaseB: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CodigoClaseB'
          Options.Editing = False
          Options.Focusing = False
          Width = 22
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object TableViewCodigoClaseC: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CodigoClaseC'
          Options.Editing = False
          Options.Focusing = False
          Width = 23
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object TableViewDescripcion: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
          Options.Focusing = False
          Width = 273
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object TableViewPrecioCompra: TcxGridDBBandedColumn
          Caption = 'Precio'
          DataBinding.FieldName = 'PrecioCompra'
          Options.Editing = False
          Options.Focusing = False
          Width = 73
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object TableViewDescuentoCompra: TcxGridDBBandedColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'DescuentoCompra'
          Options.Editing = False
          Options.Focusing = False
          Width = 50
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object TableViewMargen: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Margen'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.ValidateOnEnter = False
          Properties.OnValidate = TableViewMargenPropertiesValidate
          Styles.Header = CaptionStyle
          Width = 67
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TableViewPrecioVenta: TcxGridDBBandedColumn
          Caption = 'Precio'
          DataBinding.FieldName = 'PrecioVenta'
          Width = 74
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object TableViewPrecioVentaIVA: TcxGridDBBandedColumn
          Caption = 'Precio IVA inc.'
          DataBinding.FieldName = 'PrecioVentaIVA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.OnValidate = TableViewPrecioVentaIVAPropertiesValidate
          Width = 85
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object TableViewRecargo: TcxGridDBBandedColumn
          DataBinding.FieldName = 'Recargo'
          Width = 66
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object TableViewDescuento: TcxGridDBBandedColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          Width = 50
          Position.BandIndex = 2
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
      end
      object GridLevel: TcxGridLevel
        GridView = TableView
      end
    end
    object TableViewManager: TGridTableViewController
      AlignWithMargins = True
      Left = 951
      Top = 5
      Margins.Left = 0
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = TableView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 387
      Width = 38
    end
  end
  object ButtonsPanel: TgxEditPanel
    Left = 0
    Top = 402
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    PanelKind = epButtonsPanel
    DesignSize = (
      1004
      40)
    Height = 40
    Width = 1004
    object Panel3: TcxGroupBox
      Left = 353
      Top = 2
      Anchors = []
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 36
      Width = 298
      object CloseButton: TgBitBtn
        AlignWithMargins = True
        Left = 98
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        Cancel = True
        Caption = '&Cerrar'
        Enabled = True
        ModalResult = 2
        OptionsImage.ImageIndex = 7
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 0
        GlyphBitmap = gmClose
      end
      object OkButton: TgBitBtn
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 90
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 6
        Margins.Bottom = 0
        Align = alLeft
        Caption = '&Aceptar'
        Enabled = True
        ModalResult = 1
        OptionsImage.ImageIndex = 2
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        OptionsImage.Margin = 4
        OptionsImage.Spacing = 5
        TabOrder = 1
        GlyphBitmap = gmOk
      end
      object ActualizarButton: TgBitBtn
        AlignWithMargins = True
        Left = 199
        Top = 2
        Width = 96
        Height = 32
        Hint = 
          'Actualizar los precios de venta de todas las l'#237'neas\naplicando l' +
          'os m'#225'rgenes comerciales indicados'
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Actualizar'
        Enabled = True
        OptionsImage.ImageIndex = 25
        OptionsImage.Images = ApplicationContainer.ButtonImageList
        TabOrder = 2
        OnClick = ActualizarButtonClick
        GlyphBitmap = gmCalculator
      end
    end
  end
  object FormManager: TgxFormManager
    FirstDataControl = Grid
    ShowQueryOption = False
    OnInitializeForm = FormManagerInitializeForm
    OnPreparedForm = FormManagerPreparedForm
    OnOkButton = FormManagerOkButton
    Left = 672
    Top = 128
  end
  object MemDataSource: TDataSource
    DataSet = MemTable
    Left = 608
    Top = 128
  end
  object LineaMovimientoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 639
    Top = 91
    object LineaMovimientoTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object LineaMovimientoTableNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object LineaMovimientoTableNroPagina: TSmallintField
      FieldName = 'NroPagina'
    end
    object LineaMovimientoTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object LineaMovimientoTableFecha: TDateField
      FieldName = 'Fecha'
    end
    object LineaMovimientoTableNroRegistro: TUnsignedAutoIncField
      FieldName = 'NroRegistro'
    end
    object LineaMovimientoTableCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object LineaMovimientoTableCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object LineaMovimientoTableCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object LineaMovimientoTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object LineaMovimientoTableCantidad: TBCDField
      FieldName = 'Cantidad'
      Precision = 16
    end
    object LineaMovimientoTablePrecio: TFloatField
      FieldName = 'Precio'
    end
    object LineaMovimientoTableDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object LineaMovimientoTableFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object LineaMovimientoTableFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object LineaMovimientoTableAsignacionOrigen: TSmallintField
      FieldName = 'AsignacionOrigen'
    end
    object LineaMovimientoTableTipoMovimientoOrigen: TSmallintField
      FieldName = 'TipoMovimientoOrigen'
    end
    object LineaMovimientoTableEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object LineaMovimientoTableNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object LineaMovimientoTableNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object LineaMovimientoTableUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object LineaMovimientoTableLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object LineaMovimientoTableNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
      Size = 40
    end
    object LineaMovimientoTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
    end
    object LineaMovimientoTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
    end
    object LineaMovimientoTableCampoLibre3: TDateField
      FieldName = 'CampoLibre3'
    end
    object LineaMovimientoTableCampoLibre4: TBCDField
      FieldName = 'CampoLibre4'
      Precision = 16
    end
    object LineaMovimientoTableCampoLibre5: TWideStringField
      FieldName = 'CampoLibre5'
      Size = 40
    end
    object LineaMovimientoTableCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object LineaMovimientoTableUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object LineaMovimientoTableCantidadAjustada: TBCDField
      FieldName = 'CantidadAjustada'
      Precision = 16
    end
    object LineaMovimientoTableCantidadProcesada: TBCDField
      FieldName = 'CantidadProcesada'
      Precision = 16
    end
    object LineaMovimientoTableProcesada: TBooleanField
      FieldName = 'Procesada'
    end
    object LineaMovimientoTablePrecioDivisa: TBCDField
      FieldName = 'PrecioDivisa'
      Precision = 16
    end
    object LineaMovimientoTableRecargo: TBCDField
      FieldName = 'Recargo'
      Precision = 16
    end
    object LineaMovimientoTablePuntoVerde: TBCDField
      FieldName = 'PuntoVerde'
      Precision = 16
    end
    object LineaMovimientoTableContribucionRAP: TBCDField
      FieldName = 'ContribucionRAP'
      Precision = 16
    end
    object LineaMovimientoTableNroCajas: TBCDField
      FieldName = 'NroCajas'
      Precision = 16
    end
    object LineaMovimientoTableLargo: TBCDField
      FieldName = 'Largo'
      Precision = 16
    end
    object LineaMovimientoTableAncho: TBCDField
      FieldName = 'Ancho'
      Precision = 16
    end
    object LineaMovimientoTableAlto: TBCDField
      FieldName = 'Alto'
      Precision = 16
    end
    object LineaMovimientoTableBultos: TBCDField
      FieldName = 'Bultos'
      Precision = 16
    end
    object LineaMovimientoTableImporteRecargo: TBCDField
      FieldName = 'ImporteRecargo'
      Precision = 16
    end
    object LineaMovimientoTablePorcentajeRecargo: TBCDField
      FieldName = 'PorcentajeRecargo'
      Precision = 16
    end
    object LineaMovimientoTableNoCalcularMargen: TBooleanField
      FieldName = 'NoCalcularMargen'
    end
    object LineaMovimientoTableTipoLinea: TWideStringField
      FieldName = 'TipoLinea'
      Size = 3
    end
    object LineaMovimientoTableOferta: TBooleanField
      FieldName = 'Oferta'
    end
    object LineaMovimientoTablePesoEnvase: TBCDField
      FieldName = 'PesoEnvase'
      Precision = 16
    end
    object LineaMovimientoTableTara: TBCDField
      FieldName = 'Tara'
      Precision = 16
    end
    object LineaMovimientoTablePeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object LineaMovimientoTableImporteBruto: TBCDField
      FieldName = 'ImporteBruto'
      Precision = 16
    end
    object LineaMovimientoTableImporteDescuento: TBCDField
      FieldName = 'ImporteDescuento'
      Precision = 16
    end
    object LineaMovimientoTableImporteNeto: TBCDField
      FieldName = 'ImporteNeto'
      Precision = 16
    end
    object LineaMovimientoTableCodigoTipoIVA: TSmallintField
      FieldName = 'CodigoTipoIVA'
    end
    object LineaMovimientoTableCuotaIVA: TBCDField
      FieldName = 'CuotaIVA'
      Precision = 16
    end
    object LineaMovimientoTableCuotaRE: TBCDField
      FieldName = 'CuotaRE'
      Precision = 16
    end
    object LineaMovimientoTablePrecioIVA: TBCDField
      FieldName = 'PrecioIVA'
      Precision = 16
    end
    object LineaMovimientoTableImporteTotal: TBCDField
      FieldName = 'ImporteTotal'
      Precision = 16
    end
    object LineaMovimientoTableParametros: TWordField
      FieldName = 'Parametros'
    end
    object LineaMovimientoTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
  end
  object LineaMovimientoDataSource: TDataSource
    DataSet = LineaMovimientoTable
    Enabled = False
    Left = 605
    Top = 91
  end
  object MemTable: TnxeTable
    Session = DataAccessModule.LocalSession
    Timeout = 6000
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'MemTablenxInd1'
        Fields = 'NroLinea'
        Options = [ixPrimary, ixUnique]
      end>
    TableType = ttMemVirtual
    Left = 639
    Top = 127
    object MemTableNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object MemTableCodigoArticulo: TStringField
      FieldName = 'CodigoArticulo'
    end
    object MemTableCodigoClaseA: TStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object MemTableCodigoClaseB: TStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object MemTableCodigoClaseC: TStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object MemTableDescripcion: TStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object MemTablePrecioCompra: TFloatField
      FieldName = 'PrecioCompra'
    end
    object MemTableDescuentoCompra: TCurrencyField
      FieldName = 'DescuentoCompra'
    end
    object MemTableMargen: TCurrencyField
      FieldName = 'Margen'
    end
    object MemTablePrecioVenta: TFloatField
      FieldName = 'PrecioVenta'
    end
    object MemTablePrecioVentaIVA: TFloatField
      FieldName = 'PrecioVentaIVA'
    end
    object MemTableRecargo: TCurrencyField
      FieldName = 'Recargo'
    end
    object MemTableDescuento: TCurrencyField
      FieldName = 'Descuento'
    end
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 639
    Top = 161
  end
  object BandStyleRepository: TcxStyleRepository
    Left = 638
    Top = 214
    PixelsPerInch = 96
    object CaptionStyle: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      TextColor = clGrayText
    end
  end
end
