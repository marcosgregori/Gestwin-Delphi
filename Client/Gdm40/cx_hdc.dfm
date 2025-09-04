object CxHdcForm: TCxHdcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  ActiveControl = Grid
  BorderStyle = bsDialog
  Caption = 'Consulta de hojas de carga'
  ClientHeight = 194
  ClientWidth = 518
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
    Top = 158
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    FixedRangeField = QueryFecha
    SourceQuery = Query
    Height = 36
    Width = 518
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 518
    Height = 158
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 369597472
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewNroHoja
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
      object TableViewNroHoja: TcxGridDBColumn
        Caption = 'N'#186' Hoja'
        DataBinding.FieldName = 'NroHoja'
        Width = 73
      end
      object TableViewCodigoTransportista: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'CodigoTransportista'
        Width = 39
      end
      object TableViewNombre: TcxGridDBColumn
        Caption = 'Transportista'
        DataBinding.FieldName = 'Nombre'
        Width = 278
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 96
      end
      object TableViewNoProcesar: TcxGridDBColumn
        Caption = 'N.P.'
        DataBinding.FieldName = 'NoProcesar'
        Width = 32
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
      
        'SELECT Ejercicio, NroHoja, CodigoTransportista, Transportista.No' +
        'mbre, Fecha, NoProcesar'
      
        'FROM HojaCarga LEFT JOIN Transportista ON ( HojaCarga.CodigoTran' +
        'sportista=Transportista.Codigo )'
      'ORDER BY Fecha')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroHoja: TIntegerField
      FieldName = 'NroHoja'
    end
    object QueryCodigoTransportista: TWideStringField
      FieldName = 'CodigoTransportista'
      Size = 2
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryNoProcesar: TBooleanField
      FieldName = 'NoProcesar'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
