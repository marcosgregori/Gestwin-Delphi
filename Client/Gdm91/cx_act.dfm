object CxActForm: TCxActForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de actividades'
  ClientHeight = 270
  ClientWidth = 343
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  HelpFile = 'hs00'
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 241
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 343
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 343
    Height = 241
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 349
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 564315064
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewCodigo
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
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 42
      end
      object cxGridDBTableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 250
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
      'From    Actividad'
      'Where Codigo LIKE :CodigoOrigen')
    Left = 84
    Top = 74
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Value = '%'
      end>
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
    Top = 104
  end
end
