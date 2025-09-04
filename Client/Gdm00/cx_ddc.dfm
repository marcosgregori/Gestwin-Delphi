object cxDdcForm: TcxDdcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de direcciones de correo'
  ClientHeight = 162
  ClientWidth = 390
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
    Top = 133
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 390
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 390
    Height = 133
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 378
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 354288768
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
        Width = 34
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
      'SELECT Codigo, EsUnGrupo, Nombre'
      'FROM   DireccionCorreo'
      'WHERE Codigo LIKE :CodigoOrigen')
    Left = 34
    Top = 46
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
      Size = 2
    end
    object QueryEsUnGrupo: TBooleanField
      FieldName = 'EsUnGrupo'
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 34
    Top = 78
  end
end
