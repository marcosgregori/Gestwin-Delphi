object CxOprForm: TCxOprForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de operarios'
  ClientHeight = 297
  ClientWidth = 377
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 261
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 36
    Width = 377
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 377
    Height = 261
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 239747576
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
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 54
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 273
      end
      object TableViewCodigoOperarioTipo: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'CodigoOperarioTipo'
        Width = 50
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
      'SELECT Codigo, Nombre, CodigoOperarioTipo'
      'FROM   Operario'
      'WHERE Codigo LIKE :CodigoOrigen '
      'ORDER BY Codigo')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Size = 2
        Value = '%'
      end>
    object QueryCodigo: TWideStringField
      DisplayWidth = 5
      FieldName = 'Codigo'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object QueryCodigoOperarioTipo: TWideStringField
      FieldName = 'CodigoOperarioTipo'
      Size = 5
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
