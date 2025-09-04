object cxEfiForm: TcxEfiForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de estructuras de ficheros'
  ClientHeight = 358
  ClientWidth = 344
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
    Top = 329
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryDescripcion
    SourceField = QueryNroRegistro
    FixedRangeField = QueryNroRegistro
    SourceQuery = Query
    Height = 29
    Width = 344
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 344
    Height = 329
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 326
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 465824504
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewNroRegistro
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
      object cxGridDBTableViewNroRegistro: TcxGridDBColumn
        Caption = 'N'#186' Reg.'
        DataBinding.FieldName = 'NroRegistro'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 54
      end
      object cxGridDBTableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 272
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
      'SELECT  Fichero, NroRegistro, Descripcion'
      'FROM    EstructuraFichero'
      'WHERE Fichero=:Fichero'
      'ORDER BY Fichero, NroRegistro')
    Left = 212
    Top = 78
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Fichero'
        ParamType = ptUnknown
      end>
    object QueryFichero: TSmallintField
      FieldName = 'Fichero'
    end
    object QueryNroRegistro: TSmallintField
      FieldName = 'NroRegistro'
      MaxValue = 999
      MinValue = 1
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 112
  end
end
