object cxArrForm: TcxArrForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de art'#237'culos relacionados'
  ClientHeight = 209
  ClientWidth = 729
  Color = clBtnFace
  DoubleBuffered = True
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
    OnColumnsSetup = QueryPanelColumnsSetup
    OnSQLSetup = QueryPanelSQLSetup
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    OnUserSelection = QueryPanelUserSelection
    ExplicitTop = 180
    Height = 36
    Width = 729
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 729
    Height = 173
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitHeight = 180
    object TableView: TcxGridDBTableView
      Tag = 31111872
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
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
        Width = 100
      end
      object TableViewCodigoBarras: TcxGridDBColumn
        Caption = 'C'#243'd. de barras'
        DataBinding.FieldName = 'CodigoBarras'
        Visible = False
      end
      object TableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        MinWidth = 13
        Width = 300
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
        Width = 55
      end
      object TableViewPrecio_Venta: TcxGridDBColumn
        Caption = 'Prec. Venta'
        DataBinding.FieldName = 'Precio_Venta'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 70
      end
      object TableViewPrecioIVA: TcxGridDBColumn
        DataBinding.FieldName = 'PrecioIVA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 75
      end
      object TableViewObsoleto: TcxGridDBColumn
        Caption = 'Obsol.'
        DataBinding.FieldName = 'Obsoleto'
        DataBinding.IsNullValueType = True
        Visible = False
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
      object TableViewCampoLibre9: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre9'
        Visible = False
      end
      object TableViewCampoLibre10: TcxGridDBColumn
        DataBinding.FieldName = 'CampoLibre10'
        Visible = False
      end
      object TableViewUnidadesPorCaja: TcxGridDBColumn
        Caption = 'Unid. Caja'
        DataBinding.FieldName = 'UnidadesPorCaja'
        Visible = False
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
      'SELECT Articulo.Codigo,'
      '       Articulo.Descripcion,'
      '       Articulo.CodigoBarras,'
      '       Articulo.Familia,'
      '       Articulo.CodigoProveedor,'
      '       Articulo.Precio_Compra,'
      '       Articulo.Precio_Venta,'
      '       Articulo.TipoIVA,'
      '       Articulo.Obsoleto,'
      '       Articulo.CampoLibre1,'
      '       Articulo.CampoLibre2,'
      '       Articulo.CampoLibre3,'
      '       Articulo.CampoLibre4,'
      '       Articulo.CampoLibre9,'
      '       Articulo.CampoLibre10,'
      '       Articulo.UnidadesPorCaja,'
      '       Articulo.Anotacion,'
      '       Articulo.Imagen'
      'FROM   ArticulosRelacionados, Articulo'
      
        'WHERE  NOT Articulo.Obsoleto AND ArticulosRelacionados.Tipo=0 AN' +
        'D ArticulosRelacionados.Codigo=:CodigoArticulo AND ArticulosRela' +
        'cionados.Codigo=Articulo.Codigo'
      'ORDER BY Articulo.Codigo')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
    object QueryCodigo: TWideStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Codigo'
      Origin = 'ArticulosRelacionados.Codigo'
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
    object QueryPrecio_Venta: TFloatField
      FieldName = 'Precio_Venta'
    end
    object QueryTipoIVA: TSmallintField
      FieldName = 'TipoIVA'
    end
    object QueryPrecioIVA: TBCDField
      DisplayLabel = 'Precio con IVA'
      FieldKind = fkCalculated
      FieldName = 'PrecioIVA'
      Calculated = True
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
    object QueryCampoLibre9: TBooleanField
      FieldName = 'CampoLibre9'
    end
    object QueryCampoLibre10: TIntegerField
      FieldName = 'CampoLibre10'
    end
    object QueryUnidadesPorCaja: TBCDField
      FieldName = 'UnidadesPorCaja'
      DisplayFormat = '#'
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
end
