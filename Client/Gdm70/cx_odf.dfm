object CxOdfForm: TCxOdfForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de '#243'rdenes de fabricaci'#243'n'
  ClientHeight = 297
  ClientWidth = 872
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 261
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryNroOrden
    FixedRangeField = QueryFechaInicio
    SourceQuery = Query
    Height = 36
    Width = 872
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 872
    Height = 261
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 239747576
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNroOrden
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
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object TableViewEjercicio: TcxGridDBColumn
        DataBinding.FieldName = 'Ejercicio'
        Width = 65
      end
      object TableViewNroOrden: TcxGridDBColumn
        Caption = 'N'#186' Orden'
        DataBinding.FieldName = 'NroOrden'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 75
      end
      object TableViewCodigoArticulo: TcxGridDBColumn
        Caption = 'Art'#237'culo'
        DataBinding.FieldName = 'CodigoArticulo'
        Width = 92
      end
      object TableViewCodigoClaseA: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseA'
        Visible = False
        Width = 35
      end
      object TableViewCodigoClaseB: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseB'
        Visible = False
        Width = 35
      end
      object TableViewCodigoClaseC: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseC'
        Visible = False
        Width = 35
      end
      object TableViewLote: TcxGridDBColumn
        DataBinding.FieldName = 'Lote'
        Visible = False
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 200
      end
      object TableViewFechaInicio: TcxGridDBColumn
        Caption = 'Inicio'
        DataBinding.FieldName = 'FechaInicio'
        VisibleForCustomization = False
        Width = 82
      end
      object TableViewFechaFinalizacion: TcxGridDBColumn
        Caption = 'Fin'
        DataBinding.FieldName = 'FechaFinalizacion'
        Width = 82
      end
      object TableViewNroPedido: TcxGridDBColumn
        Caption = 'N'#186' Pedido'
        DataBinding.FieldName = 'NroPedido'
        Width = 74
      end
      object TableViewPropietario: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'Propietario'
        Width = 53
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 130
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT OrdenFabricacion.Ejercicio,'
      '       OrdenFabricacion.NroOrden,'
      '       OrdenFabricacion.CodigoArticulo,'
      '       OrdenFabricacion.CodigoClaseA,'
      '       OrdenFabricacion.CodigoClaseB,'
      '       OrdenFabricacion.CodigoClaseC,'
      '       OrdenFabricacion.Lote,'
      '       Articulo.Descripcion,'
      '       LineaOFOperacion.FechaInicio,'
      '       LineaOFOperacion.FechaFinalizacion,'
      '       OrdenFabricacion.NroPedido,'
      '       Movimiento.Propietario,'
      '       Cliente.Nombre'
      'FROM   OrdenFabricacion'
      
        '       LEFT JOIN Articulo ON ( OrdenFabricacion.CodigoArticulo=A' +
        'rticulo.Codigo )'
      
        '       LEFT JOIN Movimiento ON ( Movimiento.TipoMovimiento=14 AN' +
        'D OrdenFabricacion.EjercicioPedido=Movimiento.Ejercicio AND Orde' +
        'nFabricacion.NroPedido=Movimiento.NroDocumento )'
      
        '       LEFT JOIN Cliente ON ( Movimiento.Propietario=Cliente.Cod' +
        'igo )'
      
        '       LEFT JOIN LineaOFOperacion ON ( OrdenFabricacion.Ejercici' +
        'o=LineaOFOperacion.Ejercicio AND LineaOFOperacion.Tipo=0 AND Ord' +
        'enFabricacion.NroOrden=LineaOFOperacion.NroOrden AND LineaOFOper' +
        'acion.NroProceso=1 )'
      ''
      'ORDER BY LineaOFOperacion.FechaInicio')
    Left = 214
    Top = 78
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOrden: TIntegerField
      FieldName = 'NroOrden'
    end
    object QueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object QueryFechaInicio: TDateField
      FieldName = 'FechaInicio'
    end
    object QueryFechaFinalizacion: TDateField
      FieldName = 'FechaFinalizacion'
    end
    object QueryNroPedido: TIntegerField
      FieldName = 'NroPedido'
    end
    object QueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object QueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object QueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object QueryLote: TWideStringField
      FieldName = 'Lote'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
