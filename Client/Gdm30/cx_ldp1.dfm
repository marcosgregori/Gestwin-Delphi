object CxLdp1Form: TCxLdp1Form
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de lotes de productos'
  ClientHeight = 251
  ClientWidth = 387
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
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 222
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryLoteFabricacion
    SourceField = QueryLoteFabricacion
    SourceQuery = Query
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    Height = 29
    Width = 387
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 387
    Height = 222
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 583668208
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
      OptionsBehavior.IncSearchItem = TableViewLoteFabricacion
      OptionsBehavior.FocusCellOnCycle = True
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
      Styles.ContentEven = ApplicationForms.QueryContentEvenStyle
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
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 120
      end
      object TableViewCodigoAlmacen: TcxGridDBColumn
        Caption = 'Alm.'
        DataBinding.FieldName = 'CodigoAlmacen'
        Visible = False
        Width = 35
      end
      object TableViewUbicacion: TcxGridDBColumn
        Caption = 'Ubicaci'#243'n'
        DataBinding.FieldName = 'Ubicacion'
        Visible = False
        Width = 60
      end
      object TableViewEntradas: TcxGridDBColumn
        DataBinding.FieldName = 'Entradas'
        Width = 110
      end
      object TableViewExistencias: TcxGridDBColumn
        DataBinding.FieldName = 'Existencias'
        Visible = False
        Width = 110
      end
      object TableViewExistenciasVirtuales: TcxGridDBColumn
        Caption = 'Exist. virtuales'
        DataBinding.FieldName = 'ExistenciasVirtuales'
        Visible = False
        Width = 110
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Filtered = True
    AfterOpen = QueryAfterOpen
    OnCalcFields = QueryCalcFields
    ReadOnly = True
    SQL.Strings = (
      'SELECT CodigoClaseA,'
      '       CodigoClaseB,'
      '       CodigoClaseC,'
      '       LoteFabricacion,'
      '       CodigoAlmacen,'
      '       Ubicacion'
      'FROM   Stock'
      'WHERE  ( Ejercicio=:Ejercicio ) AND'
      '       ( CodigoArticulo=:CodigoArticulo) AND'
      '       ( LoteFabricacion<>'#39#39' )'
      ''
      
        '                                                                ' +
        ' ')
    Left = 44
    Top = 54
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Ejercicio'
        ParamType = ptUnknown
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
    object QueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object QueryEntradas: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Entradas'
      Precision = 16
      Calculated = True
    end
    object QueryExistencias: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Existencias'
      Precision = 16
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
    Left = 44
    Top = 88
  end
end
