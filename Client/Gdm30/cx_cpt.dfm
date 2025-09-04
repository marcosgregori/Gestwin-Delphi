object cxCptForm: TcxCptForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de capturadores'
  ClientHeight = 284
  ClientWidth = 381
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryNroCapturador
    FixedRangeField = QueryNroCapturador
    SourceQuery = Query
    Height = 29
    Width = 381
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 381
    Height = 255
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 518111808
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
      object TableViewNroCapturador: TcxGridDBColumn
        DataBinding.FieldName = 'NroCapturador'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 37
      end
      object TableViewDescripcion: TcxGridDBColumn
        DataBinding.FieldName = 'Descripcion'
        Width = 223
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
      'From  Capturador'
      'Order By NroCapturador')
    Left = 212
    Top = 78
    object QueryNroCapturador: TSmallintField
      DisplayLabel = 'N'#186
      FieldName = 'NroCapturador'
      MaxValue = 999
      MinValue = 1
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
