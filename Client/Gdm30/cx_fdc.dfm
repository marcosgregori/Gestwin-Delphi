object cxFdcForm: TcxFdcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de facturas de compra'
  ClientHeight = 199
  ClientWidth = 589
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
    Top = 170
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QuerySerieNroFactura
    FixedRangeField = QueryFecha
    SourceQuery = Query
    LockConnectorText = 'del proveedor'
    OnUserSelection = QueryPanelUserSelection
    AfterReadQueryState = QueryPanelAfterReadQueryState
    Height = 29
    Width = 589
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 589
    Height = 170
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 369590960
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
      OptionsBehavior.IncSearchItem = TableViewSerieNroFactura
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
      object TableViewProveedor: TcxGridDBColumn
        Caption = 'Provee.'
        DataBinding.FieldName = 'Proveedor'
        HeaderHint = 'Proveedor'
        Width = 49
      end
      object TableViewSerieNroFactura: TcxGridDBColumn
        Caption = 'Serie / N'#186' Factura'
        DataBinding.FieldName = 'SerieNroFactura'
        PropertiesClassName = 'TcxTextEditProperties'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 113
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 71
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 220
      end
      object TableViewImporte: TcxGridDBColumn
        Caption = 'Importe'
        DataBinding.FieldName = 'TotalFactura'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.UseThousandSeparator = True
        Width = 70
      end
      object TableViewTraspasada: TcxGridDBColumn
        Caption = 'Cont.'
        DataBinding.FieldName = 'Traspasada'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Width = 38
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
      
        'SELECT Ejercicio, SerieNroFactura, Fecha, Proveedor, TotalFactur' +
        'a, Traspasada, Proveedor.Nombre'
      'FROM   FacturaCompras, Proveedor'
      'WHERE  FacturaCompras.Proveedor=Proveedor.Codigo'
      'ORDER BY Fecha, SerieNroFactura'
      ''
      '')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QuerySerieNroFactura: TWideStringField
      FieldName = 'SerieNroFactura'
      Size = 81
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryProveedor: TWideStringField
      FieldName = 'Proveedor'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryTotalFactura: TBCDField
      FieldName = 'TotalFactura'
    end
    object QueryTraspasada: TBooleanField
      FieldName = 'Traspasada'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
