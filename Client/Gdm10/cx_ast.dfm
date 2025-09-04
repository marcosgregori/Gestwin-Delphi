object cxAstForm: TcxAstForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de asientos'
  ClientHeight = 225
  ClientWidth = 752
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
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 189
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceField = QueryNroAsiento
    FixedRangeField = QueryFecha
    SourceQuery = Query
    OnUserSelection = queryPanelUserSelection
    Height = 36
    Width = 752
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 752
    Height = 189
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 431103352
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.ExpressionEditing = True
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNombre
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
      object TableViewNroAsiento: TcxGridDBColumn
        Caption = 'N'#186' Asto.'
        DataBinding.FieldName = 'NroAsiento'
        HeaderHint = 'N'#170' Asiento'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 65
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 83
      end
      object TableViewTipoAsiento: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TipoAsiento'
        Width = 37
      end
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Visible = False
        VisibleForCustomization = False
      end
      object TableViewNroFactura: TcxGridDBColumn
        Caption = 'N'#186' Docum.'
        DataBinding.FieldName = 'NroFactura'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Visible = False
        VisibleForCustomization = False
      end
      object TableViewSerieNroFactura: TcxGridDBColumn
        Caption = 'Serie / N'#186' Factura'
        DataBinding.FieldName = 'SerieNroFactura'
        PropertiesClassName = 'TcxTextEditProperties'
        OnGetProperties = TableViewSerieNroFacturaGetProperties
        Width = 115
      end
      object TableViewPropietario: TcxGridDBColumn
        DataBinding.FieldName = 'Propietario'
        Width = 77
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 316
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
      
        'SELECT Ejercicio, NroAsiento, Fecha, TipoAsiento, Serie, NroFact' +
        'ura, Propietario, Nombre'
      'FROM Asiento'
      'ORDER BY Fecha, NroAsiento')
    Left = 470
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryTipoAsiento: TSmallintField
      FieldName = 'TipoAsiento'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object QueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
      DisplayFormat = '#'
    end
    object QuerySerieNroFactura: TStringField
      FieldKind = fkCalculated
      FieldName = 'SerieNroFactura'
      Size = 48
      Calculated = True
    end
    object QueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
