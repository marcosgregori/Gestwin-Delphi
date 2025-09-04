object CxEpuForm: TCxEpuForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de existencias por ubicaci'#243'n'
  ClientHeight = 215
  ClientWidth = 644
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
    Top = 179
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryUbicacion
    SourceQuery = Query
    ExplicitWidth = 513
    Height = 36
    Width = 644
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 644
    Height = 179
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 513
    object TableView: TcxGridDBTableView
      Tag = 221269992
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      OnCustomDrawCell = TableViewCustomDrawCell
      DataController.DataModeController.GridMode = True
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewUbicacion
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
      object TableViewUbicacion: TcxGridDBColumn
        Caption = 'Ubicaci'#243'n'
        DataBinding.FieldName = 'Ubicacion'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 68
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 230
      end
      object TableViewLoteFabricacion: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LoteFabricacion'
        VisibleForCustomization = False
        Width = 120
      end
      object TableViewCantidad: TcxGridDBColumn
        DataBinding.FieldName = 'Cantidad'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        SortIndex = 0
        SortOrder = soDescending
        Width = 76
      end
      object TableViewUbicacionDeCarga: TcxGridDBColumn
        Caption = 'Carga'
        DataBinding.FieldName = 'UbicacionDeCarga'
        Visible = False
        Width = 50
      end
      object TableViewExistenciasVirtuales: TcxGridDBColumn
        Caption = 'Exist. virt.'
        DataBinding.FieldName = 'ExistenciasVirtuales'
        Width = 76
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
      'SELECT Stock.*,'
      '       Ubicacion.Descripcion,'
      '       Ubicacion.UbicacionDeCarga'
      'FROM   Stock, Ubicacion'
      
        'WHERE  Stock.CodigoAlmacen=Ubicacion.CodigoAlmacen AND Stock.Ubi' +
        'cacion=Ubicacion.Codigo')
    Left = 212
    Top = 78
    object QueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object QueryUbicacionDeCarga: TBooleanField
      FieldName = 'UbicacionDeCarga'
    end
    object QueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
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
    object QueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object QueryFechaUltEntrada: TDateField
      FieldName = 'FechaUltEntrada'
    end
    object QueryFechaUltSalida: TDateField
      FieldName = 'FechaUltSalida'
    end
    object QueryCosteUltEntrada: TBCDField
      FieldName = 'CosteUltEntrada'
    end
    object QueryCoste_Medio: TBCDField
      FieldName = 'Coste_Medio'
    end
    object QueryPrecioUltSalida: TBCDField
      FieldName = 'PrecioUltSalida'
    end
    object QueryPendiente_Recibir0: TBCDField
      FieldName = 'Pendiente_Recibir0'
    end
    object QueryPendiente_Recibir: TBCDField
      FieldName = 'Pendiente_Recibir'
    end
    object QueryPendiente_Servir0: TBCDField
      FieldName = 'Pendiente_Servir0'
    end
    object QueryPendiente_Servir: TBCDField
      FieldName = 'Pendiente_Servir'
    end
    object QueryReservado: TBCDField
      FieldName = 'Reservado'
    end
    object QueryApertura_Entradas: TBCDField
      FieldName = 'Apertura_Entradas'
    end
    object QueryApertura_Salidas: TBCDField
      FieldName = 'Apertura_Salidas'
    end
    object QueryEnero_Entradas: TBCDField
      FieldName = 'Enero_Entradas'
    end
    object QueryEnero_Salidas: TBCDField
      FieldName = 'Enero_Salidas'
    end
    object QueryFebrero_Entradas: TBCDField
      FieldName = 'Febrero_Entradas'
    end
    object QueryFebrero_Salidas: TBCDField
      FieldName = 'Febrero_Salidas'
    end
    object QueryMarzo_Entradas: TBCDField
      FieldName = 'Marzo_Entradas'
    end
    object QueryMarzo_Salidas: TBCDField
      FieldName = 'Marzo_Salidas'
    end
    object QueryAbril_Entradas: TBCDField
      FieldName = 'Abril_Entradas'
    end
    object QueryAbril_Salidas: TBCDField
      FieldName = 'Abril_Salidas'
    end
    object QueryMayo_Entradas: TBCDField
      FieldName = 'Mayo_Entradas'
    end
    object QueryMayo_Salidas: TBCDField
      FieldName = 'Mayo_Salidas'
    end
    object QueryJunio_Entradas: TBCDField
      FieldName = 'Junio_Entradas'
    end
    object QueryJunio_Salidas: TBCDField
      FieldName = 'Junio_Salidas'
    end
    object QueryJulio_Entradas: TBCDField
      FieldName = 'Julio_Entradas'
    end
    object QueryJulio_Salidas: TBCDField
      FieldName = 'Julio_Salidas'
    end
    object QueryAgosto_Entradas: TBCDField
      FieldName = 'Agosto_Entradas'
    end
    object QueryAgosto_Salidas: TBCDField
      FieldName = 'Agosto_Salidas'
    end
    object QuerySeptiembre_Entradas: TBCDField
      FieldName = 'Septiembre_Entradas'
    end
    object QuerySeptiembre_Salidas: TBCDField
      FieldName = 'Septiembre_Salidas'
    end
    object QueryOctubre_Entradas: TBCDField
      FieldName = 'Octubre_Entradas'
    end
    object QueryOctubre_Salidas: TBCDField
      FieldName = 'Octubre_Salidas'
    end
    object QueryNoviembre_Entradas: TBCDField
      FieldName = 'Noviembre_Entradas'
    end
    object QueryNoviembre_Salidas: TBCDField
      FieldName = 'Noviembre_Salidas'
    end
    object QueryDiciembre_Entradas: TBCDField
      FieldName = 'Diciembre_Entradas'
    end
    object QueryDiciembre_Salidas: TBCDField
      FieldName = 'Diciembre_Salidas'
    end
    object QueryCantidad: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Cantidad'
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
