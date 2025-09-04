object cxCdbForm: TcxCdbForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de c'#243'digos de barras'
  ClientHeight = 186
  ClientWidth = 596
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 157
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigoBarras
    FixedRangeField = QueryCodigoBarras
    SourceQuery = Query
    Height = 29
    Width = 596
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 596
    Height = 157
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 218613112
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
      OptionsBehavior.IncSearchItem = TableViewCodigoBarras
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
      object TableViewCodigoArticulo: TcxGridDBColumn
        Caption = 'Codigo'
        DataBinding.FieldName = 'CodigoArticulo'
        Width = 88
      end
      object TableViewCodigoBarras: TcxGridDBColumn
        Caption = 'Codigo de barras'
        DataBinding.FieldName = 'CodigoBarras'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 116
      end
      object TableViewClaseA: TcxGridDBColumn
        DataBinding.FieldName = 'ClaseA'
        Width = 20
      end
      object TableViewClaseB: TcxGridDBColumn
        DataBinding.FieldName = 'ClaseB'
        Width = 24
      end
      object TableViewClaseC: TcxGridDBColumn
        DataBinding.FieldName = 'ClaseC'
        Width = 20
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 320
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
      'SELECT CodigoBarras.*, Descripcion'
      'FROM  CodigoBarras, Articulo'
      'WHERE Articulo.Codigo=CodigoArticulo'
      ''
      '')
    Left = 212
    Top = 78
    object QueryCodigoBarras: TWideStringField
      FieldName = 'CodigoBarras'
      Origin = 'CodigoBarras.CodigoBarras'
    end
    object QueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object QueryClaseA: TWideStringField
      FieldName = 'ClaseA'
      Size = 3
    end
    object QueryClaseB: TWideStringField
      FieldName = 'ClaseB'
      Size = 3
    end
    object QueryClaseC: TWideStringField
      FieldName = 'ClaseC'
      Size = 3
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
