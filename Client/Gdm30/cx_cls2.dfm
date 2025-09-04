object cxCls2Form: TcxCls2Form
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de '
  ClientHeight = 185
  ClientWidth = 419
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 149
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigoClase
    SourceQuery = Query
    OnSQLSetup = QueryPanelSQLSetup
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    ExplicitWidth = 374
    Height = 36
    Width = 419
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 419
    Height = 149
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 374
    object TableView: TcxGridDBTableView
      Tag = 629459424
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
      OptionsBehavior.IncSearchItem = TableViewClase
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
      object TableViewClase: TcxGridDBColumn
        Caption = 'CC'
        DataBinding.FieldName = 'CodigoClase'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 30
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 200
      end
      object TableViewCodigoArticulo: TcxGridDBColumn
        Caption = 'Codigo articulo'
        DataBinding.FieldName = 'CodigoArticulo'
        Width = 90
      end
      object TableViewPendienteRecibir: TcxGridDBColumn
        Caption = 'Pend. recibir'
        DataBinding.FieldName = 'PendienteRecibir'
        Visible = False
        Width = 80
      end
      object TableViewPendienteServir: TcxGridDBColumn
        Caption = 'Pend. servir'
        DataBinding.FieldName = 'PendienteServir'
        Visible = False
        Width = 80
      end
      object TableViewExistencias: TcxGridDBColumn
        DataBinding.FieldName = 'Existencias'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Visible = False
        Width = 80
      end
      object TableViewExistenciasVirtuales: TcxGridDBColumn
        Caption = 'Exist. virtuales'
        DataBinding.FieldName = 'ExistenciasVirtuales'
        Visible = False
        Width = 80
      end
      object TableViewExistenciasEnvases: TcxGridDBColumn
        Caption = 'Env. dep'#243'sito'
        DataBinding.FieldName = 'ExistenciasEnvases'
        Visible = False
        Width = 80
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT CodigoArticulo, CodigoClaseA AS CodigoClase'
      'FROM   Stock '
      'WHERE Ejercicio=2009')
    Left = 176
    Top = 40
    object QueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object QueryCodigoClase: TWideStringField
      FieldName = 'CodigoClase'
      Size = 3
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object QueryPendienteRecibir: TBCDField
      FieldKind = fkCalculated
      FieldName = 'PendienteRecibir'
      Calculated = True
    end
    object QueryPendienteServir: TBCDField
      FieldKind = fkCalculated
      FieldName = 'PendienteServir'
      Calculated = True
    end
    object QueryExistencias: TBCDField
      FieldKind = fkCalculated
      FieldName = 'Existencias'
      Calculated = True
    end
    object QueryExistenciasVirtuales: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ExistenciasVirtuales'
      Calculated = True
    end
    object QueryExistenciasEnvases: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ExistenciasEnvases'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 144
    Top = 38
  end
end
