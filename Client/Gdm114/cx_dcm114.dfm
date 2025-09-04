object CxDcmForm: TCxDcmForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de documentos de control de mercanc'#237'as'
  ClientHeight = 195
  ClientWidth = 471
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
    Top = 166
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceField = QueryNroOperacion
    FixedRangeField = QueryFechaCarga
    SourceQuery = Query
    OnUserSelection = QueryPanelUserSelection
    Height = 29
    Width = 471
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 471
    Height = 166
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 221358088
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
      OptionsBehavior.IncSearchItem = TableViewNroOperacion
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
      object TableViewEjercicio: TcxGridDBColumn
        DataBinding.FieldName = 'Ejercicio'
        Visible = False
      end
      object TableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' oper.'
        DataBinding.FieldName = 'NroOperacion'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 74
      end
      object TableViewCodigoNaviera: TcxGridDBColumn
        Caption = 'Naviera'
        DataBinding.FieldName = 'CodigoNaviera'
        Width = 62
      end
      object TableViewDestino: TcxGridDBColumn
        DataBinding.FieldName = 'Destino'
        Width = 240
      end
      object TableViewFechaCarga: TcxGridDBColumn
        Caption = 'Fecha carga'
        DataBinding.FieldName = 'FechaCarga'
        Width = 95
      end
      object TableViewLugarOrigen: TcxGridDBColumn
        Caption = 'Lugar de origen'
        DataBinding.FieldName = 'LugarOrigen'
        Visible = False
        Width = 200
      end
      object TableViewTipo: TcxGridDBColumn
        DataBinding.FieldName = 'Tipo'
        Visible = False
      end
      object TableViewPlataforma: TcxGridDBColumn
        DataBinding.FieldName = 'Plataforma'
        Visible = False
      end
      object TableViewLugarDestino: TcxGridDBColumn
        Caption = 'Lugar de destino'
        DataBinding.FieldName = 'LugarDestino'
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
      'SELECT *'
      'FROM DocumentoControlMercancias'
      'ORDER BY NroOperacion'
      '')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object QueryTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object QueryCodigoNaviera: TWideStringField
      FieldName = 'CodigoNaviera'
      Size = 2
    end
    object QueryDestino: TWideStringField
      FieldName = 'Destino'
      Size = 30
    end
    object QueryFechaCarga: TDateField
      FieldName = 'FechaCarga'
    end
    object QueryLugarOrigen: TWideStringField
      FieldName = 'LugarOrigen'
      Size = 40
    end
    object QueryPlataforma: TSmallintField
      FieldName = 'Plataforma'
    end
    object QueryLugarDestino: TWideStringField
      FieldName = 'LugarDestino'
      Size = 40
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
