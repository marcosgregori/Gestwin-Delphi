object cxCls1Form: TcxCls1Form
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de '
  ClientHeight = 183
  ClientWidth = 371
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 147
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 36
    Width = 371
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 371
    Height = 147
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 222411640
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
      OptionsBehavior.IncSearchItem = TableViewCodigo
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
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 30
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 190
      end
      object TableViewPeso: TcxGridDBColumn
        DataBinding.FieldName = 'Peso'
        Visible = False
        VisibleForCustomization = False
        Width = 60
      end
      object TableViewCapacidad: TcxGridDBColumn
        DataBinding.FieldName = 'Capacidad'
        Visible = False
        VisibleForCustomization = False
        Width = 60
      end
      object TableViewTipo: TcxGridDBColumn
        DataBinding.FieldName = 'Tipo'
        Visible = False
        VisibleForCustomization = False
        Width = 25
      end
      object TableViewDisponibleTienda: TcxGridDBColumn
        Caption = 'Disp. tienda'
        DataBinding.FieldName = 'DisponibleTienda'
        Visible = False
        VisibleForCustomization = False
        Width = 30
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
      'SELECT *'
      'FROM   Clase'
      'WHERE NroClase=:NroClase AND Codigo LIKE :CodigoOrigen '
      'ORDER BY Codigo')
    Left = 210
    Top = 76
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'NroClase'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Size = 2
        Value = '%'
      end>
    object QueryNroClase: TSmallintField
      FieldName = 'NroClase'
    end
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object QueryPeso: TBCDField
      FieldName = 'Peso'
      Precision = 16
    end
    object QueryCapacidad: TBCDField
      FieldName = 'Capacidad'
      Precision = 16
    end
    object QueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object QueryDisponibleTienda: TBooleanField
      FieldName = 'DisponibleTienda'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
