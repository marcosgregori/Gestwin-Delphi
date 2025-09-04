object CxVpeForm: TCxVpeForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de ventas peri'#243'dicas'
  ClientHeight = 241
  ClientWidth = 503
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
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 205
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryNombre
    SourceField = QueryNroFicha
    FixedRangeField = QueryNroFicha
    SourceQuery = Query
    Height = 36
    Width = 503
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 503
    Height = 205
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 397413584
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewNroFicha
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
      object cxGridDBTableViewNroFicha: TcxGridDBColumn
        Caption = 'N'#186' Ficha'
        DataBinding.FieldName = 'NroFicha'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 50
      end
      object cxGridDBTableViewCodigoCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CodigoCliente'
        Width = 45
      end
      object cxGridDBTableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
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
      
        'SELECT VentaPeriodica.NroFicha, VentaPeriodica.CodigoCliente, Cl' +
        'iente.Nombre'
      
        'FROM   VentaPeriodica LEFT JOIN Cliente On ( Cliente.Codigo=Vent' +
        'aPeriodica.CodigoCliente )'
      'ORDER BY NroFicha')
    Left = 28
    Top = 42
    object QueryNroFicha: TIntegerField
      FieldName = 'NroFicha'
      MaxValue = 999999
      MinValue = 1
    end
    object QueryCodigoCliente: TWideStringField
      FieldName = 'CodigoCliente'
      Size = 5
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 26
    Top = 74
  end
end
