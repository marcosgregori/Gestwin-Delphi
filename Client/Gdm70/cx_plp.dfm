object CxPlpForm: TCxPlpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Selecci'#243'n de plantilla de relaciones de materiales y procesos'
  ClientHeight = 195
  ClientWidth = 744
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
    Top = 159
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceQuery = Query
    OnDataSelected = QueryPanelDataSelected
    Height = 36
    Width = 744
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 744
    Height = 159
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 564317088
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
      OptionsBehavior.IncSearchItem = TableViewCodigoArticulo
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
      object TableViewCodigoArticulo: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CodigoArticulo'
        Width = 84
      end
      object TableViewCodigoClaseA: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseA'
        Width = 25
      end
      object TableViewCodigoClaseB: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseB'
        Width = 25
      end
      object TableViewCodigoClaseC: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseC'
        Width = 25
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Articulo_Descripcion'
        Width = 300
      end
      object TableViewProceso: TcxGridDBColumn
        Caption = 'Proc.'
        DataBinding.FieldName = 'Proceso'
        Width = 35
      end
      object TableViewCodigoOperacion: TcxGridDBColumn
        Caption = 'Op.'
        DataBinding.FieldName = 'CodigoOperacion'
        Width = 35
      end
      object TableViewOperacion_Descripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Operacion_Descripcion'
        Width = 200
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
      ''
      'SELECT CodigoArticulo,'
      '       CodigoClaseA,'
      '       CodigoClaseB,'
      '       CodigoClaseC,'
      '       Articulo.Descripcion AS Articulo_Descripcion,'
      '       Proceso,'
      '       CodigoOperacion,'
      '       Operacion.Descripcion AS Operacion_Descripcion'
      ''
      'FROM   RelacionOperaciones'
      
        '            LEFT JOIN Articulo ON ( RelacionOperaciones.CodigoAr' +
        'ticulo=Articulo.Codigo )'
      
        '            LEFT JOIN Operacion ON ( RelacionOperaciones.CodigoO' +
        'peracion=Operacion.Codigo )'
      ''
      
        'WHERE  RelacionOperaciones.CodigoArticulo LIKE :CodigoOrigen AND' +
        ' RelacionOperaciones.Proceso=1 AND'
      '       RelacionOperaciones.CodigoArticulo=Articulo.Codigo AND'
      '       RelacionOperaciones.CodigoOperacion=Operacion.Codigo'
      ''
      'ORDER BY CodigoArticulo, Proceso')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Size = 20
        Value = '%'
      end>
    object QueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
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
    object QueryArticulo_Descripcion: TWideStringField
      FieldName = 'Articulo_Descripcion'
      Size = 60
    end
    object QueryProceso: TSmallintField
      FieldName = 'Proceso'
    end
    object QueryCodigoOperacion: TWideStringField
      FieldName = 'CodigoOperacion'
      Size = 5
    end
    object QueryOperacion_Descripcion: TWideStringField
      FieldName = 'Operacion_Descripcion'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
  object RelacionMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 296
    Top = 76
  end
  object RelacionOperacionesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 262
    Top = 76
  end
end
