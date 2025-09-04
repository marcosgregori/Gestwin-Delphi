object CxCopForm: TCxCopForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de c'#243'digos postales'
  ClientHeight = 398
  ClientWidth = 448
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
  Position = poDefault
  Visible = True
  OnCreate = FormCreate
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 362
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 36
    Width = 448
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 448
    Height = 362
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object cxGridDBTableView: TcxGridDBTableView
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
      OptionsBehavior.HotTrack = True
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
      Styles.ContentEven = ApplicationContainer.QueryContentEvenStyle
      object cxGridDBTableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 75
      end
      object cxGridDBTableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 350
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
      'SELECT CodigoPais, CodigoProvincia, Codigo, Nombre'
      'FROM   CodigoPostal'
      
        'WHERE  ( CodigoPais=:CodigoPais ) AND ( CodigoProvincia=:CodigoP' +
        'rovincia ) AND ( Codigo LIKE :CodigoOrigen )'
      '')
    Left = 214
    Top = 78
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
        Name = 'CodigoProvincia'
        ParamType = ptInput
        Size = 2
        Value = '12'
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
    object QueryCodigoProvincia: TWideStringField
      FieldName = 'CodigoProvincia'
      Size = 2
    end
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 8
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
