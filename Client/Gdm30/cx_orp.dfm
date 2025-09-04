object CxOrpForm: TCxOrpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de organismos p'#250'blicos'
  ClientHeight = 380
  ClientWidth = 413
  Color = clBtnFace
  DoubleBuffered = True
  DoubleBufferedMode = dbmRequested
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
    Top = 344
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    Height = 36
    Width = 413
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 413
    Height = 344
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 46332352
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
      OptionsBehavior.IncSearchItem = TableViewNombre
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
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 88
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 325
      end
      object TableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object TableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
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
      'SELECT Codigo, Tipo,  Nombre, Domicilio, Localidad'
      'FROM  OrganismoPublico'
      'WHERE Tipo=:Tipo'
      'ORDER BY Codigo')
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
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 12
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 60
    end
    object QueryDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 70
    end
    object QueryLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
