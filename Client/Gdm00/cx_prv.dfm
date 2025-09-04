object CxPrvForm: TCxPrvForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de provincias'
  ClientHeight = 376
  ClientWidth = 292
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
    Top = 347
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 292
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 292
    Height = 347
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 253
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 354288680
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewNombre
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
        Caption = 'Cod.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 35
      end
      object cxGridDBTableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 237
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Query: TnxeQuery
    Database = DataAccessModule.AppDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select  CodigoPais, Codigo, Nombre'
      'From    Provincia'
      
        'Where ( CodigoPais=:CodigoPais ) AND ( Codigo LIKE :CodigoOrigen' +
        ' )'
      '')
    Left = 188
    Top = 68
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoPais'
        ParamType = ptInput
        Size = 3
        Value = '011'
      end
      item
        DataType = ftWideString
        Name = 'CodigoOrigen'
        ParamType = ptInput
        Size = 2
        Value = '%'
      end>
    object QueryCodigoPais: TWideStringField
      FieldName = 'CodigoPais'
      Size = 3
    end
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 188
    Top = 96
  end
end
