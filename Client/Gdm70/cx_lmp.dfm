object CxLmpForm: TCxLmpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de relaciones de materiales y procesos'
  ClientHeight = 197
  ClientWidth = 726
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
    Top = 161
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryArticulo_Descripcion
    SourceField = QueryCodigoArticulo
    SourceQuery = Query
    Height = 36
    Width = 726
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 726
    Height = 161
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 439573192
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
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
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
      'SELECT CodigoArticulo, '
      '        CodigoClaseA, '
      '        CodigoClaseB, '
      '        CodigoClaseC, '
      '        Articulo.Descripcion AS Articulo_Descripcion,'
      '        Proceso, '
      '        CodigoOperacion, '
      '        Operacion.Descripcion AS Operacion_Descripcion'
      'FROM   RelacionOperaciones '
      
        '        LEFT JOIN Articulo ON ( RelacionOperaciones.CodigoArticu' +
        'lo=Articulo.Codigo )'
      
        '        LEFT JOIN Operacion ON ( RelacionOperaciones.CodigoOpera' +
        'cion=Operacion.Codigo )'
      ''
      'WHERE CodigoArticulo LIKE :CodigoOrigen'
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
      Origin = 'Articulo.Descripcion'
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
      Origin = 'Operacion.Descripcion'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
