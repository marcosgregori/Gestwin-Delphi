object cxFcgForm: TcxFcgForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  BorderStyle = bsDialog
  Caption = 'Consulta de facturas recibidas'
  ClientHeight = 323
  ClientWidth = 942
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 144
  TextHeight = 28
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 269
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    PanelStyle.Active = True
    PanelStyle.CaptionIndent = 3
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QuerySerie
    FixedRangeField = QueryFecha
    SourceQuery = Query
    LockConnectorText = 'del proveedor/acreedor'
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    OnUserSelection = QueryPanelUserSelection
    AfterReadQueryState = QueryPanelAfterReadQueryState
    Height = 54
    Width = 942
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 942
    Height = 269
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 431101944
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Position = fpTop
      FilterBox.Visible = fvNever
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataModeController.GridMode = True
      DataController.DataSource = dataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.SeparatorWidth = 9
      FixedDataRows.SeparatorWidth = 9
      NewItemRow.SeparatorWidth = 9
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = TableViewSerieNroFactura
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
      OptionsView.NavigatorOffset = 75
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GroupByBox = False
      Preview.LeftIndent = 30
      Preview.RightIndent = 8
      RowLayout.MinValueWidth = 120
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object TableViewNroFactura: TcxGridDBColumn
        DataBinding.FieldName = 'NroFactura'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Visible = False
        MinWidth = 30
        VisibleForCustomization = False
      end
      object TableViewPropietario: TcxGridDBColumn
        DataBinding.FieldName = 'Propietario'
        MinWidth = 30
        Width = 134
      end
      object TableViewSerieNroFactura: TcxGridDBColumn
        Caption = 'Serie / N'#186' Factura'
        DataBinding.FieldName = 'Serie'
        MinWidth = 30
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 209
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        MinWidth = 30
        Width = 137
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        MinWidth = 30
        Width = 464
      end
      object TableViewNroRegistro: TcxGridDBColumn
        Caption = 'N'#186' Registro'
        DataBinding.FieldName = 'NroRegistro'
        Visible = False
        MinWidth = 30
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        Visible = False
        MinWidth = 30
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
      'SELECT Ejercicio,'
      '       NroAsiento,'
      '       TipoAsiento,'
      '       Serie,'
      '       NroFactura,'
      '       NroEfecto,'
      '       Fecha,'
      '       Propietario,'
      '       Nombre,'
      '       NroRegistro,'
      '       CAST( 0.0 AS BCD(16,4) ) AS Importe'
      'FROM Asiento'
      'WHERE TipoAsiento=6'
      'ORDER BY Fecha')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
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
    end
    object QueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 9
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryNroRegistro: TIntegerField
      FieldName = 'NroRegistro'
    end
    object QueryImporte: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Importe'
      Precision = 16
      Calculated = True
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
