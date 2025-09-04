object CxMatForm: TCxMatForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de m'#225'quinas tipo'
  ClientHeight = 272
  ClientWidth = 335
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
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 243
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 335
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 335
    Height = 243
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
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
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
      'SELECT Codigo, Descripcion'
      'FROM   MaquinaTipo'
      'WHERE Codigo LIKE :CodigoOrigen '
      'ORDER BY Codigo')
    Left = 214
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
      FieldName = 'Codigo'
      Size = 5
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
end
