object CxTcvForm: TCxTcvForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tarifa de precios por cantidad'
  ClientHeight = 271
  ClientWidth = 465
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 242
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = GridDBTableView
    SourceQuery = Query
    Height = 29
    Width = 465
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 465
    Height = 242
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object GridDBTableView: TcxGridDBTableView
      Tag = 484116664
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
      OptionsBehavior.IncSearchItem = GridDBTableViewNroRegistro
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
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object GridDBTableViewNroRegistro: TcxGridDBColumn
        Caption = 'N'#186' Reg.'
        DataBinding.FieldName = 'NroRegistro'
        Width = 50
      end
      object GridDBTableViewCantidadMinima: TcxGridDBColumn
        Caption = 'Cant. m'#237'nima'
        DataBinding.FieldName = 'CantidadMinima'
        Width = 85
      end
      object GridDBTableViewCantidadMaxima: TcxGridDBColumn
        Caption = 'Cant. m'#225'xima'
        DataBinding.FieldName = 'CantidadMaxima'
        Width = 85
      end
      object GridDBTableViewPrecio: TcxGridDBColumn
        DataBinding.FieldName = 'Precio'
        Width = 85
      end
      object GridDBTableViewDescuento: TcxGridDBColumn
        Caption = '% Dto.'
        DataBinding.FieldName = 'Descuento'
        Width = 45
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridDBTableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT *'
      'FROM TarifaCantidadVenta'
      
        'WHERE ( NroRegistro>0 ) AND ( CodigoCliente=:CodigoCliente ) AND' +
        ' ( CodigoArticulo=:CodigoArticulo ) AND ( CodigoClaseA=:CodigoCl' +
        'aseA ) AND ( CodigoClaseB=:CodigoClaseB ) AND ( CodigoClaseC=:Co' +
        'digoClaseC )'
      'ORDER BY NroRegistro')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoCliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoClaseA'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoClaseB'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoClaseC'
        ParamType = ptUnknown
      end>
    object QueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
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
    object QueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object QueryCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
    end
    object QueryCantidadMaxima: TBCDField
      FieldName = 'CantidadMaxima'
    end
    object QueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object QueryDescuento: TBCDField
      FieldName = 'Descuento'
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
    Timeout = 15000
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;NroRegistro'
    Left = 182
    Top = 78
  end
end
