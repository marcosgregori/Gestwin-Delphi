object CxTdvForm: TCxTdvForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tarifas de venta'
  ClientHeight = 267
  ClientWidth = 426
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
    Top = 231
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceQuery = Query
    Height = 36
    Width = 426
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 426
    Height = 231
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 217341144
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
      OptionsBehavior.IncSearchItem = TableViewCodigoTarifa
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
      object TableViewCodigoTarifa: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'CodigoTarifa'
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
      end
      object TableViewPrecio: TcxGridDBColumn
        DataBinding.FieldName = 'Precio'
        Width = 90
      end
      object TableViewRecargo: TcxGridDBColumn
        DataBinding.FieldName = 'Recargo'
        Width = 82
      end
      object TableViewDescuento: TcxGridDBColumn
        Caption = '% Dto.'
        DataBinding.FieldName = 'Descuento'
        Width = 55
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
      
        'SELECT   TarifaVentas.CodigoTarifa, TarifaVentas.Precio, TarifaV' +
        'entas.Recargo, TarifaVentas.Descuento, CodigoTarifa.Descripcion'
      
        'FROM     TarifaVentas LEFT JOIN CodigoTarifa ON ( TarifaVentas.C' +
        'odigoTarifa=CodigoTarifa.Codigo )'
      'WHERE    Tipo=0 AND CodigoArticulo=:CodigoArticulo'
      'ORDER BY TarifaVentas.CodigoTarifa')
    Left = 214
    Top = 78
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
    object QueryCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 5
    end
    object QueryRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object QueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object QueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
  object TarifaCantidadVentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;NroRegistro'
    Left = 182
    Top = 78
  end
end
