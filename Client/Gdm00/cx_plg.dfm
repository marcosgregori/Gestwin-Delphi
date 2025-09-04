object CxPlgForm: TCxPlgForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de plantillas de gr'#225'ficos'
  ClientHeight = 261
  ClientWidth = 316
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
    Top = 232
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryNroOperacion
    FixedRangeField = QueryNroOperacion
    SourceQuery = Query
    Height = 29
    Width = 316
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 316
    Height = 232
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 298
    object TableView: TcxGridDBTableView
      Tag = 465824680
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
      OptionsBehavior.IncSearchItem = TableViewNroOperacion
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
      object TableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' plan.'
        DataBinding.FieldName = 'NroOperacion'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 55
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 230
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = DataAccessModule.AppDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT   Tipo, NroOperacion, NroRegistro, Descripcion'
      'FROM     PlantillaGrafico'
      'WHERE  ( Tipo=:Tipo ) AND ( NroRegistro=0 )'
      'ORDER BY NroOperacion')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Tipo'
        ParamType = ptUnknown
      end>
    object QueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
      MaxValue = 999
      MinValue = 1
    end
    object QueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 40
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
