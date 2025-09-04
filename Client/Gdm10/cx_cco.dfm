object cxCcoForm: TcxCcoForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de centros de coste'
  ClientHeight = 278
  ClientWidth = 310
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
    GridTableView = cxGridDBTableView
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 310
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 310
    Height = 249
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 302
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 518112072
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewDescripcion
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
      object cxGridDBTableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 39
      end
      object cxGridDBTableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 271
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select  *'
      'From CentroCoste')
    Left = 84
    Top = 74
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 3
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 84
    Top = 102
  end
end
