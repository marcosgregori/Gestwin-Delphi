object cxImpForm: TcxImpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de impresos'
  ClientHeight = 230
  ClientWidth = 582
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 201
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = GridDBTableView
    SourceField = QueryNroRegistro
    SourceQuery = Query
    Height = 29
    Width = 582
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 582
    Height = 201
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object GridDBTableView: TcxGridDBTableView
      Tag = 417478424
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
      OptionsBehavior.IncSearchItem = GridDBTableViewDescripcion
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
        Caption = 'N'#186
        DataBinding.FieldName = 'NroRegistro'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 30
      end
      object GridDBTableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 300
      end
      object GridDBTableViewImpresora: TcxGridDBColumn
        DataBinding.FieldName = 'Impresora'
        Width = 120
      end
      object GridDBTableViewPagina: TcxGridDBColumn
        Caption = 'P'#225'gina'
        DataBinding.FieldName = 'Pagina'
        Width = 80
      end
    end
    object GridLevel: TcxGridLevel
      GridView = GridDBTableView
    end
  end
  object Query: TnxeQuery
    Database = DataAccessModule.AppDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT '
      '* '
      'FROM '
      'InformeExterno'
      'WHERE '
      '( TipoDocumento=:TipoDocumento ) AND'
      
        '(:SetupSection OR  Empresa='#39#39' OR Empresa IS NULL OR Empresa=:Cod' +
        'igoEmpresa )'
      'ORDER BY TipoDocumento, NroRegistro')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'TipoDocumento'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftBoolean
        Name = 'SetupSection'
        ParamType = ptInput
        Value = False
      end
      item
        DataType = ftWideString
        Name = 'CodigoEmpresa'
        ParamType = ptInput
        Value = ''
      end>
    object QueryTipoDocumento: TSmallintField
      FieldName = 'TipoDocumento'
    end
    object QueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 999
      MinValue = 1
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object QueryFichero: TWideStringField
      FieldName = 'Fichero'
      Size = 128
    end
    object QueryImpresora: TWideStringField
      FieldName = 'Impresora'
      Size = 128
    end
    object QueryPagina: TWideStringField
      FieldName = 'Pagina'
      Size = 64
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
