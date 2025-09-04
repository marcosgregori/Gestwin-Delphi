object CxFdvForm: TCxFdvForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de facturas de venta'
  ClientHeight = 337
  ClientWidth = 601
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 301
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryNroFactura
    FixedRangeField = QueryFecha
    SourceQuery = Query
    LockConnectorText = 'la serie'
    LockEmptyText = 'gen'#233'rica'
    OnUserSelection = QueryPanelUserSelection
    OnFormReport = QueryPanelFormReport
    Height = 36
    Width = 601
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 601
    Height = 301
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 221358088
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
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Width = 23
      end
      object TableViewNroFactura: TcxGridDBColumn
        Caption = 'N'#186' Factura'
        DataBinding.FieldName = 'NroFactura'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 76
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 71
      end
      object TableViewCodigoCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CodigoCliente'
        Width = 52
      end
      object TableViewRegistroAuxiliar: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'RegistroAuxiliar'
        Visible = False
        HeaderHint = 'Codigo del registro auxiliar'
        Width = 35
      end
      object TableViewAuxiliarDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'AuxiliarDescripcion'
        Visible = False
        HeaderHint = 'Descripci'#243'n del registro auxiliar'
        Width = 200
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 220
      end
      object TableViewNetoFactura: TcxGridDBColumn
        Caption = 'Imp. neto'
        DataBinding.FieldName = 'NetoFactura'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Visible = False
        Width = 80
      end
      object TableViewImporte: TcxGridDBColumn
        Caption = 'Importe'
        DataBinding.FieldName = 'TotalFactura'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.UseThousandSeparator = True
        Width = 80
      end
      object TableViewTraspasada: TcxGridDBColumn
        Caption = 'Cont.'
        DataBinding.FieldName = 'Traspasada'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Glyph.SourceHeight = 18
        Properties.Glyph.SourceWidth = 108
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
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT Factura.*, Cliente.Nombre'
      
        'FROM ( SELECT Ejercicio, Serie, NroFactura, Fecha, CodigoCliente' +
        ', RegistroAuxiliar, NetoFactura, TotalFactura, Traspasada'
      '       FROM FacturaVentas'
      
        '       WHERE ( :CualquierSerie OR ( Serie=:Serie ) ) ) AS Factur' +
        'a'
      '     LEFT JOIN Cliente ON ( CodigoCliente=Cliente.Codigo )'
      'ORDER BY Fecha, Serie, NroFactura')
    Left = 468
    Top = 34
    ParamData = <
      item
        DataType = ftBoolean
        Name = 'CualquierSerie'
        ParamType = ptUnknown
        Value = True
      end
      item
        DataType = ftWideString
        Name = 'Serie'
        ParamType = ptUnknown
      end>
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryNetoFactura: TBCDField
      FieldName = 'NetoFactura'
      Precision = 16
    end
    object QueryTotalFactura: TBCDField
      FieldName = 'TotalFactura'
    end
    object QueryRegistroAuxiliar: TWideStringField
      FieldName = 'RegistroAuxiliar'
      Size = 3
    end
    object QueryAuxiliarDescripcion: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'AuxiliarDescripcion'
      Size = 40
      Calculated = True
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
