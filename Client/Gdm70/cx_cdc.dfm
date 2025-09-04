object cxCdcForm: TcxCdcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de c'#243'digos de coste'
  ClientHeight = 278
  ClientWidth = 321
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
    Top = 249
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 321
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 321
    Height = 249
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 302
    object TableView: TcxGridDBTableView
      Tag = 518112072
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
      OptionsBehavior.IncSearchItem = TableViewDescripcion
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
        Width = 35
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 258
      end
      object TableViewTipo: TcxGridDBColumn
        DataBinding.FieldName = 'Tipo'
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
    SQL.Strings = (
      'Select  *'
      'From CodigoCoste')
    Left = 84
    Top = 68
    object QueryCodigo: TSmallintField
      FieldName = 'Codigo'
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object QueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 84
    Top = 102
  end
end
