object CxLdp2Form: TCxLdp2Form
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de lotes de productos'
  ClientHeight = 211
  ClientWidth = 720
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 175
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryLoteFabricacion
    SourceField = QueryLoteFabricacion
    SourceQuery = Query
    OnColumVisibilityChanged = queryPanelColumVisibilityChanged
    Height = 36
    Width = 720
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 720
    Height = 175
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 22162400
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
      OptionsBehavior.IncSearchItem = TableViewFecha
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
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 73
      end
      object TableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' Operac.'
        DataBinding.FieldName = 'NroOperacion'
        Width = 78
      end
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Width = 27
      end
      object TableViewNroDocumento: TcxGridDBColumn
        Caption = 'N'#186' Docum.'
        DataBinding.FieldName = 'NroDocumento'
        Width = 79
      end
      object TableViewDescripcionDocumento: TcxGridDBColumn
        Caption = 'Tipo de documento'
        DataBinding.FieldName = 'DescripcionDocumento'
        Width = 132
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
      object TableViewLoteFabricacion: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LoteFabricacion'
        MinWidth = 40
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 113
      end
      object TableViewFechaCaducidad: TcxGridDBColumn
        Caption = 'Caducidad'
        DataBinding.FieldName = 'FechaCaducidad'
        Visible = False
        VisibleForCustomization = False
      end
      object TableViewCodigoAlmacen: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoAlmacen'
        Visible = False
      end
      object TableViewSumaCantidad: TcxGridDBColumn
        Caption = 'Cantidad'
        DataBinding.FieldName = 'SumaCantidad'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 80
      end
      object TableViewExistencias: TcxGridDBColumn
        DataBinding.FieldName = 'Existencias'
        Visible = False
        Width = 80
      end
      object TableViewExistenciasVirtuales: TcxGridDBColumn
        Caption = 'Exist. virtuales'
        DataBinding.FieldName = 'ExistenciasVirtuales'
        Visible = False
        Width = 80
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = QueryAfterOpen
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT Linea.CodigoClaseA,'
      '       Linea.CodigoClaseB,'
      '       Linea.CodigoClaseC,'
      '       Linea.LoteFabricacion,'
      '       Linea.CodigoAlmacen,'
      '       Linea.FechaCaducidad,'
      '       Linea.SumaCantidad,'
      '       Linea.NroOperacion,'
      '       Linea.Fecha,'
      '       Linea.UIDArticulo,'
      '       Linea.Serie,'
      '       Linea.NroDocumento,'
      '       Linea.Ejercicio,'
      '       Linea.TipoMovimiento,'
      '       Linea.NroRegistro'
      ''
      'FROM ( SELECT *'
      
        '        FROM ( SELECT LineaMovimiento.LoteFabricacion, LineaMovi' +
        'miento.CodigoAlmacen, LineaMovimiento.NroRegistro, SUM( LineaMov' +
        'imiento.Cantidad ) AS SumaCantidad'
      '                FROM LineaMovimiento'
      
        '                WHERE{  ( CodigoArticulo=:CodigoArticulo ) AND  ' +
        '( LoteFabricacion IS NOT NULL AND LoteFabricacion<>'#39#39' ) AND ( Fe' +
        'cha BETWEEN :FechaInicial AND :FechaFinal ) }'
      
        '                GROUP BY LoteFabricacion, CodigoAlmacen, NroRegi' +
        'stro'
      '              ) AS LineaExistencias'
      
        '        LEFT JOIN LineaMovimiento ON ( LineaMovimiento.NroRegist' +
        'ro=LineaExistencias.NroRegistro )'
      
        '        LEFT JOIN Movimiento ON ( LineaMovimiento.Ejercicio=Movi' +
        'miento.Ejercicio AND LineaMovimiento.NroOperacion=Movimiento.Nro' +
        'Operacion )'
      
        '        WHERE ( Movimiento.TipoMovimiento<>14 ) AND ( LineaMovim' +
        'iento.Cantidad>0.0  ) AND ( CodigoArticulo=:CodigoArticulo AND S' +
        'umaCantidad>0.0 ) ) AS Linea'
      ''
      'ORDER BY'
      '')
    Left = 212
    Top = 80
    ParamData = <
      item
        DataType = ftString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end
      item
        DataType = ftDate
        Name = 'FechaInicial'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftDate
        Name = 'FechaFinal'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
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
    object QueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object QueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object QueryFechaCaducidad: TDateField
      FieldName = 'FechaCaducidad'
    end
    object QuerySumaCantidad: TBCDField
      FieldName = 'SumaCantidad'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
      DisplayFormat = '#'
    end
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object QueryDescripcionDocumento: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'DescripcionDocumento'
      Size = 40
      Calculated = True
    end
    object QueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object QueryExistencias: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Existencias'
      Calculated = True
    end
    object QueryExistenciasVirtuales: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ExistenciasVirtuales'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
