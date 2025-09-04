object cxAlmForm: TcxAlmForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de almacenes'
  ClientHeight = 266
  ClientWidth = 369
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
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 230
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryNombre
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    OnSQLSetup = QueryPanelSQLSetup
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    Height = 36
    Width = 369
  end
  object Grid: TcxGrid
    Left = 0
    Top = 35
    Width = 369
    Height = 195
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
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 29
      end
      object TableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
        Width = 242
      end
      object TableViewPendienteRecibir: TcxGridDBColumn
        DataBinding.FieldName = 'PendienteRecibir'
        Visible = False
        Width = 80
      end
      object TableViewPendienteServir: TcxGridDBColumn
        DataBinding.FieldName = 'PendienteServir'
        Visible = False
        Width = 80
      end
      object TableViewExistencias: TcxGridDBColumn
        DataBinding.FieldName = 'Existencias'
        Visible = False
        Width = 80
      end
      object TableViewExistenciasVirtuales: TcxGridDBColumn
        DataBinding.FieldName = 'ExistenciasVirtuales'
        Visible = False
        Width = 80
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object CaptionPanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 2
    Visible = False
    Height = 35
    Width = 369
    object cxLabel1: TcxLabel
      Left = 6
      Top = 5
      Caption = 'Art'#237'culo'
      TabOrder = 0
      Transparent = True
    end
    object CodigoArticuloPanel: TcxLabel
      Left = 61
      Top = 3
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 1
      Transparent = True
      Height = 25
      Width = 121
      AnchorY = 16
    end
    object CodigoClaseAPanel: TcxLabel
      Left = 191
      Top = 3
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 2
      Transparent = True
      Height = 25
      Width = 35
      AnchorY = 16
    end
    object CodigoClaseBPanel: TcxLabel
      Left = 229
      Top = 3
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 3
      Transparent = True
      Height = 25
      Width = 35
      AnchorY = 16
    end
    object CodigoClaseCPanel: TcxLabel
      Left = 267
      Top = 3
      TabStop = False
      AutoSize = False
      Style.BorderColor = clScrollBar
      Style.BorderStyle = ebsSingle
      Style.Edges = [bBottom]
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      Properties.Alignment.Vert = taVCenter
      TabOrder = 4
      Transparent = True
      Height = 25
      Width = 35
      AnchorY = 16
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT Codigo, Nombre'
      'FROM Almacen'
      'ORDER BY Codigo')
    Left = 212
    Top = 78
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 30
    end
    object QueryPendienteRecibir: TBCDField
      DisplayLabel = 'Pend. recibir'
      FieldKind = fkCalculated
      FieldName = 'PendienteRecibir'
      Calculated = True
    end
    object QueryPendienteServir: TBCDField
      DisplayLabel = 'Pend. servir'
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
      DisplayLabel = 'Exist. virtuales'
      FieldKind = fkCalculated
      FieldName = 'ExistenciasVirtuales'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
