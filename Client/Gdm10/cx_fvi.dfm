object cxFviForm: TcxFviForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de facturas emitidas'
  ClientHeight = 223
  ClientWidth = 571
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
    Top = 194
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryNroFactura
    FixedRangeField = QueryFecha
    SourceQuery = Query
    LockConnectorText = 'de la serie'
    LockEmptyText = 'gen'#233'rica'
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    OnUserSelection = QueryPanelUserSelection
    Height = 29
    Width = 571
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 571
    Height = 194
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 369592544
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
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Width = 28
      end
      object TableViewNroFactura: TcxGridDBColumn
        Caption = 'N'#186' Factura'
        DataBinding.FieldName = 'NroFactura'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 80
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 81
      end
      object TableViewPropietario: TcxGridDBColumn
        DataBinding.FieldName = 'Propietario'
        Width = 81
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 320
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        Visible = False
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
      'SELECT TipoAsiento,'
      '       Ejercicio,'
      '       NroAsiento,'
      '       Serie,'
      '       NroFactura,'
      '       NroEfecto,'
      '       Fecha,'
      '       Propietario,'
      '       Nombre,'
      '       CAST( 0.0 AS BCD(16,4) ) AS Importe'
      'FROM Asiento'
      
        'WHERE ( TipoAsiento=5  ) AND ( :TodosLosPropietarios OR ( Propie' +
        'tario=:Propietario) )'
      'ORDER BY Ejercicio, Serie, NroFactura')
    Left = 468
    Top = 34
    ParamData = <
      item
        DataType = ftBoolean
        Name = 'TodosLosPropietarios'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'Propietario'
        ParamType = ptUnknown
      end>
    object QueryTipoAsiento: TSmallintField
      FieldName = 'TipoAsiento'
    end
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroAsiento: TIntegerField
      FieldName = 'NroAsiento'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
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
