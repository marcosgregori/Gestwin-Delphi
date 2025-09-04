object CxTofForm: TCxTofForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tareas'
  ClientHeight = 297
  ClientWidth = 870
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
    Top = 268
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceQuery = Query
    Height = 29
    Width = 870
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 870
    Height = 268
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
      OptionsBehavior.IncSearchItem = TableViewNroOrdenFabricacion
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
      object TableViewNroOrdenFabricacion: TcxGridDBColumn
        Caption = 'N'#186' orden'
        DataBinding.FieldName = 'NroOrdenFabricacion'
        Width = 64
      end
      object TableViewNroProceso: TcxGridDBColumn
        Caption = 'Proc.'
        DataBinding.FieldName = 'NroProceso'
        HeaderHint = 'N'#250'mero de proceso'
        Width = 40
      end
      object TableViewSegmento: TcxGridDBColumn
        Caption = 'Seg.'
        DataBinding.FieldName = 'Segmento'
        HeaderHint = 'Segmento'
        Width = 38
      end
      object TableViewCodigoMaquina: TcxGridDBColumn
        Caption = 'M'#225'q.'
        DataBinding.FieldName = 'CodigoMaquina'
        HeaderHint = 'M'#225'quina'
        Width = 46
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 70
      end
      object TableViewTurno: TcxGridDBColumn
        DataBinding.FieldName = 'Turno'
        Width = 50
      end
      object TableViewTiempo: TcxGridDBColumn
        DataBinding.FieldName = 'Tiempo'
        PropertiesClassName = 'TcxDurationEditProperties'
        Width = 60
      end
      object TableViewCodigoArticulo: TcxGridDBColumn
        Caption = 'Art'#237'culo'
        DataBinding.FieldName = 'CodigoArticulo'
        Width = 67
      end
      object TableViewCodigoClaseA: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseA'
        Width = 30
      end
      object TableViewCodigoClaseB: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseB'
        Width = 30
      end
      object TableViewCodigoClaseC: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoClaseC'
        Width = 30
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 299
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
      '       NroOrdenFabricacion,'
      '       NroProceso,'
      '       Segmento,'
      '       CodigoMaquina,'
      '       Fecha,'
      '       Turno,'
      '       Tiempo,'
      '       OrdenFabricacion.CodigoArticulo,'
      '       OrdenFabricacion.CodigoClaseA,'
      '       OrdenFabricacion.CodigoClaseB,'
      '       OrdenFabricacion.CodigoClaseC,'
      '       Articulo.Descripcion AS Descripcion'
      ''
      'FROM   SecuenciaAsignacion,'
      '       OrdenFabricacion,'
      '       Articulo'
      ''
      'WHERE  <Seleccion> AND'
      
        '       OrdenFabricacion.Ejercicio=SecuenciaAsignacion.Ejercicio ' +
        'AND SecuenciaAsignacion.NroOrdenFabricacion=OrdenFabricacion.Nro' +
        'Orden AND'
      '       OrdenFabricacion.CodigoArticulo=Articulo.Codigo'
      ''
      
        'ORDER BY SecuenciaAsignacion.NroOrdenFabricacion, SecuenciaAsign' +
        'acion.NroProceso, SecuenciaAsignacion.Segmento'
      '')
    Left = 214
    Top = 78
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOrdenFabricacion: TIntegerField
      FieldName = 'NroOrdenFabricacion'
    end
    object QueryNroProceso: TSmallintField
      FieldName = 'NroProceso'
    end
    object QuerySegmento: TSmallintField
      FieldName = 'Segmento'
    end
    object QueryCodigoMaquina: TWideStringField
      FieldName = 'CodigoMaquina'
      Size = 5
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryTurno: TSmallintField
      FieldName = 'Turno'
    end
    object QueryTiempo: TLongWordField
      FieldName = 'Tiempo'
    end
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
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
