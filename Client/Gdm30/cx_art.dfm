object cxArtForm: TcxArtForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de art'#237'culos'
  ClientHeight = 209
  ClientWidth = 804
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 173
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    SourceTable = ArticuloTable
    OnColumnsSetup = QueryPanelColumnsSetup
    OnSQLSetup = QueryPanelSQLSetup
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    OnUserSelection = QueryPanelUserSelection
    Height = 36
    Width = 804
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 804
    Height = 173
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 31111872
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = TableViewCustomDrawCell
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.KeyFieldNames = 'Codigo'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewDescripcion
      OptionsBehavior.FocusCellOnCycle = True
      OptionsBehavior.HotTrack = True
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Preview.Column = TableViewAnotacion
      Preview.Visible = True
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object TableViewCodigo: TcxGridDBColumn
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 99
      end
      object TableViewCodigoBarras: TcxGridDBColumn
        Caption = 'C'#243'd. de barras'
        DataBinding.FieldName = 'CodigoBarras'
        Visible = False
      end
      object TableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        MinWidth = 13
        Width = 297
      end
      object TableViewCodigoProveedor: TcxGridDBColumn
        Caption = 'Provee.'
        DataBinding.FieldName = 'CodigoProveedor'
        Visible = False
        HeaderHint = 'C'#243'digo del proveedor'
        Width = 40
      end
      object TableViewFamilia: TcxGridDBColumn
        DataBinding.FieldName = 'Familia'
        Width = 54
      end
      object TableViewPrecio_Compra: TcxGridDBColumn
        DataBinding.FieldName = 'Precio_Compra'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 90
      end
      object TableViewPrecio_Venta: TcxGridDBColumn
        Caption = 'Prec. Venta'
        DataBinding.FieldName = 'Precio_Venta'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 90
      end
      object TableViewMargenComercial: TcxGridDBColumn
        Caption = 'Margen'
        DataBinding.FieldName = 'MargenComercial'
        Visible = False
      end
      object TableViewObsoleto: TcxGridDBColumn
        Caption = 'Obsol.'
        DataBinding.FieldName = 'Obsoleto'
        Visible = False
        HeaderHint = 'Obsoleto'
        Width = 35
      end
      object TableViewAnotacion: TcxGridDBColumn
        DataBinding.FieldName = 'Anotacion'
        PropertiesClassName = 'TcxRichEditProperties'
        Properties.MemoMode = True
      end
      object TableViewCampoLibre1: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre1'
        Visible = False
      end
      object TableViewCampoLibre2: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre2'
        Visible = False
      end
      object TableViewCampoLibre3: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre3'
        Visible = False
      end
      object TableViewCampoLibre4: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre4'
        Visible = False
      end
      object TableViewCampoLibre5: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Width = 80
      end
      object TableViewCampoLibre6: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Width = 80
      end
      object TableViewCampoLibre7: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Width = 80
      end
      object TableViewCampoLibre8: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre8'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Width = 80
      end
      object TableViewCampoLibre9: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre9'
        Visible = False
      end
      object TableViewCampoLibre10: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre10'
        Visible = False
      end
      object TableViewCampoLibre11: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre11'
        Visible = False
      end
      object TableViewCampoLibre12: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre12'
        Visible = False
      end
      object TableViewCampoLibre13: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre13'
        Visible = False
        Width = 160
      end
      object TableViewCampoLibre14: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre14'
        Visible = False
        Width = 160
      end
      object TableViewCampoLibre15: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre15'
        Visible = False
        Width = 160
      end
      object TableViewCampoLibre16: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre16'
        Visible = False
        Width = 160
      end
      object TableViewUnidadesPorCaja: TcxGridDBColumn
        Caption = 'Unid. caja'
        DataBinding.FieldName = 'UnidadesPorCaja'
        Visible = False
        HeaderHint = 'Unidades por caja'
      end
      object TableViewUnidadesPorPallet: TcxGridDBColumn
        Caption = 'Unid. pallet'
        DataBinding.FieldName = 'UnidadesPorPallet'
        Visible = False
        HeaderHint = 'Unidades por pallet'
      end
      object TableViewImagen: TcxGridDBColumn
        DataBinding.FieldName = 'Imagen'
        PropertiesClassName = 'TcxImageProperties'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Visible = False
        Width = 100
      end
      object TableViewTipoIVA: TcxGridDBColumn
        Caption = 'Tipo I.V.A.'
        DataBinding.FieldName = 'TipoIVA'
        Visible = False
      end
      object TableViewPrecioCompraIVA: TcxGridDBColumn
        Caption = 'Prec. comp. IVA'
        DataBinding.FieldName = 'PrecioCompraIVA'
        HeaderHint = 'Precio de compra con I.V.A.'
        Width = 90
      end
      object TableViewPrecioVentaIVA: TcxGridDBColumn
        Caption = 'Prec. venta IVA'
        DataBinding.FieldName = 'PrecioVentaIVA'
        HeaderHint = 'Precio de venta con I.V.A.'
        Width = 90
      end
      object TableViewVisibleTienda: TcxGridDBColumn
        Caption = 'Disp. tienda'
        DataBinding.FieldName = 'VisibleTienda'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Visible = False
        HeaderHint = 'Disponible en la tienda'
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT Codigo,'
      '       Descripcion,'
      '       CodigoBarras,'
      '       Familia,'
      '       CodigoProveedor,'
      '       Precio_Compra,'
      '       Precio_Venta,'
      '       TipoIVA,'
      '       Obsoleto,'
      '       CampoLibre1,  CampoLibre2,  CampoLibre3,  CampoLibre4,'
      '       CampoLibre5,  CampoLibre6,  CampoLibre7,  CampoLibre8,'
      '       CampoLibre9,  CampoLibre10, CampoLibre11, CampoLibre12,'
      '       CampoLibre13, CampoLibre14, CampoLibre15, CampoLibre16,'
      '       UnidadesPorCaja,'
      '       UnidadesPorPallet,'
      '       MargenComercial,'
      '       VisibleTienda,'
      '       Anotacion,'
      '       Imagen'
      'FROM   Articulo'
      'ORDER BY Codigo')
    Left = 212
    Top = 78
    object QueryCodigo: TWideStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
    end
    object QueryDescripcion: TWideStringField
      DisplayLabel = 'Descripci'#243'n'
      FieldName = 'Descripcion'
      Size = 60
    end
    object QueryCodigoBarras: TWideStringField
      FieldName = 'CodigoBarras'
    end
    object QueryCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object QueryFamilia: TWideStringField
      FieldName = 'Familia'
      Size = 6
    end
    object QueryTipoIVA: TSmallintField
      FieldName = 'TipoIVA'
    end
    object QueryPrecio_Compra: TFloatField
      DisplayLabel = 'Prec. Compra'
      FieldName = 'Precio_Compra'
    end
    object QueryPrecioCompraIVA: TBCDField
      FieldKind = fkCalculated
      FieldName = 'PrecioCompraIVA'
      Calculated = True
    end
    object QueryPrecio_Venta: TFloatField
      FieldName = 'Precio_Venta'
    end
    object QueryPrecioVentaIVA: TBCDField
      DisplayLabel = 'Precio Venta IVA'
      FieldKind = fkCalculated
      FieldName = 'PrecioVentaIVA'
      Calculated = True
    end
    object QueryMargenComercial: TBCDField
      FieldName = 'MargenComercial'
      Precision = 16
    end
    object QueryObsoleto: TBooleanField
      FieldName = 'Obsoleto'
    end
    object QueryCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
      Size = 40
    end
    object QueryCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object QueryCampoLibre3: TWideStringField
      FieldName = 'CampoLibre3'
    end
    object QueryCampoLibre4: TWideStringField
      FieldName = 'CampoLibre4'
    end
    object QueryCampoLibre5: TBCDField
      FieldName = 'CampoLibre5'
      Precision = 16
    end
    object QueryCampoLibre6: TBCDField
      FieldName = 'CampoLibre6'
      Precision = 16
    end
    object QueryCampoLibre7: TBCDField
      FieldName = 'CampoLibre7'
      Precision = 16
    end
    object QueryCampoLibre8: TBCDField
      FieldName = 'CampoLibre8'
      Precision = 16
    end
    object QueryCampoLibre9: TBooleanField
      FieldName = 'CampoLibre9'
    end
    object QueryCampoLibre10: TIntegerField
      FieldName = 'CampoLibre10'
    end
    object QueryCampoLibre11: TIntegerField
      FieldName = 'CampoLibre11'
    end
    object QueryCampoLibre12: TIntegerField
      FieldName = 'CampoLibre12'
    end
    object QueryCampoLibre13: TWideStringField
      FieldName = 'CampoLibre13'
      Size = 40
    end
    object QueryCampoLibre14: TWideStringField
      FieldName = 'CampoLibre14'
      Size = 40
    end
    object QueryCampoLibre15: TWideMemoField
      FieldName = 'CampoLibre15'
      BlobType = ftWideMemo
      Size = 40
    end
    object QueryCampoLibre16: TWideMemoField
      FieldName = 'CampoLibre16'
      BlobType = ftWideMemo
      Size = 40
    end
    object QueryUnidadesPorCaja: TBCDField
      FieldName = 'UnidadesPorCaja'
      DisplayFormat = '#'
    end
    object QueryUnidadesPorPallet: TBCDField
      FieldName = 'UnidadesPorPallet'
      DisplayFormat = '#'
    end
    object QueryVisibleTienda: TBooleanField
      FieldName = 'VisibleTienda'
    end
    object QueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object QueryImagen: TGraphicField
      FieldName = 'Imagen'
      BlobType = ftGraphic
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
  object ArticuloTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    Filtered = True
    OnCalcFields = ArticuloTableCalcFields
    OnFilterRecord = ArticuloTableFilterRecord
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 182
    Top = 78
    object ArticuloTableCodigo: TWideStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
    end
    object ArticuloTableDescripcion: TWideStringField
      DisplayLabel = 'Descripci'#243'n'
      FieldName = 'Descripcion'
      Size = 60
    end
    object ArticuloTableCodigoBarras: TWideStringField
      FieldName = 'CodigoBarras'
    end
    object ArticuloTableCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object ArticuloTableFamilia: TWideStringField
      FieldName = 'Familia'
      Size = 6
    end
    object ArticuloTablePrecio_Compra: TFloatField
      DisplayLabel = 'Prec. Compra'
      FieldName = 'Precio_Compra'
    end
    object ArticuloTablePrecioCompraIVA: TBCDField
      DisplayLabel = 'Precio Compra IVA'
      FieldKind = fkCalculated
      FieldName = 'PrecioCompraIVA'
      Size = 0
      Calculated = True
    end
    object ArticuloTablePrecio_Venta: TFloatField
      FieldName = 'Precio_Venta'
    end
    object ArticuloTablePrecioVentaIVA: TBCDField
      DisplayLabel = 'Precio venta IVA'
      FieldKind = fkCalculated
      FieldName = 'PrecioVentaIVA'
      Calculated = True
    end
    object ArticuloTableMargenComercial: TBCDField
      FieldName = 'MargenComercial'
      Precision = 16
    end
    object ArticuloTableTipoIVA: TSmallintField
      FieldName = 'TipoIVA'
    end
    object ArticuloTableObsoleto: TBooleanField
      FieldName = 'Obsoleto'
    end
    object ArticuloTableCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
      Size = 40
    end
    object ArticuloTableCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object ArticuloTableCampoLibre3: TWideStringField
      FieldName = 'CampoLibre3'
    end
    object ArticuloTableCampoLibre4: TWideStringField
      FieldName = 'CampoLibre4'
    end
    object ArticuloTableCampoLibre5: TBCDField
      FieldName = 'CampoLibre5'
      Precision = 16
    end
    object ArticuloTableCampoLibre6: TBCDField
      FieldName = 'CampoLibre6'
      Precision = 16
    end
    object ArticuloTableCampoLibre7: TBCDField
      FieldName = 'CampoLibre7'
      Precision = 16
    end
    object ArticuloTableCampoLibre8: TBCDField
      FieldName = 'CampoLibre8'
      Precision = 16
    end
    object ArticuloTableCampoLibre9: TBooleanField
      FieldName = 'CampoLibre9'
    end
    object ArticuloTableCampoLibre10: TIntegerField
      FieldName = 'CampoLibre10'
    end
    object ArticuloTableCampoLibre11: TIntegerField
      FieldName = 'CampoLibre11'
    end
    object ArticuloTableCampoLibre12: TIntegerField
      FieldName = 'CampoLibre12'
    end
    object ArticuloTableCampoLibre13: TWideStringField
      FieldName = 'CampoLibre13'
      Size = 40
    end
    object ArticuloTableCampoLibre14: TWideStringField
      FieldName = 'CampoLibre14'
      Size = 40
    end
    object ArticuloTableCampoLibre15: TWideMemoField
      FieldName = 'CampoLibre15'
      BlobType = ftWideMemo
      Size = 40
    end
    object ArticuloTableCampoLibre16: TWideMemoField
      FieldName = 'CampoLibre16'
      BlobType = ftWideMemo
      Size = 40
    end
    object ArticuloTableVisibleTienda: TBooleanField
      FieldName = 'VisibleTienda'
    end
    object ArticuloTableImagen: TGraphicField
      FieldName = 'Imagen'
      BlobType = ftGraphic
    end
    object ArticuloTableAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object ArticuloTableUnidadesPorCaja: TBCDField
      FieldName = 'UnidadesPorCaja'
      DisplayFormat = '#'
    end
    object ArticuloTableUnidadesPorPallet: TBCDField
      FieldName = 'UnidadesPorPallet'
      Precision = 16
    end
  end
end
