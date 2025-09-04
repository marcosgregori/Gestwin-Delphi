object CxMovForm: TCxMovForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  ActiveControl = Grid
  BorderStyle = bsDialog
  Caption = 'Consulta de movimientos de almac'#233'n'
  ClientHeight = 185
  ClientWidth = 568
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
    SourceField = QueryNroOperacion
    FixedRangeField = QueryFecha
    SourceQuery = Query
    OnColumVisibilityChanged = QueryPanelColumVisibilityChanged
    OnUserSelection = QueryPanelUserSelection
    Height = 36
    Width = 568
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 568
    Height = 149
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 369598000
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
      object TableViewNroOperacion: TcxGridDBColumn
        Caption = 'N'#186' operac.'
        DataBinding.FieldName = 'NroOperacion'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 45
      end
      object TableViewTipoMovimiento: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'TipoMovimiento'
        Width = 25
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 100
      end
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
      end
      object TableViewNroDocumento: TcxGridDBColumn
        Caption = 'N'#186' Documento'
        DataBinding.FieldName = 'NroDocumento'
        Width = 65
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
        Width = 65
      end
      object TableViewPropietario: TcxGridDBColumn
        Caption = 'Propie.'
        DataBinding.FieldName = 'Propietario'
        Width = 40
      end
      object TableViewImporteNeto: TcxGridDBColumn
        Caption = 'Importe'
        DataBinding.FieldName = 'ImporteNeto'
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
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       NroOperacion,'
      '       TipoMovimiento,'
      '       TipoMovAlmacen.Descripcion,'
      '       Serie,'
      '       NroDocumento,'
      '       Fecha,'
      '       Propietario,'
      '       CAST( 0.0 AS BCD(16,4) ) AS ImporteNeto'
      
        'FROM Movimiento LEFT JOIN TipoMovAlmacen ON ( TipoMovAlmacen.Tip' +
        'o=Movimiento.TipoMovimiento )'
      'WHERE not Movimiento.Anulado'
      'ORDER BY Fecha')
    Left = 468
    Top = 34
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object QueryTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Origin = 'TipoMovAlmacen.Descripcion'
      Size = 25
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object QueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object QueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object QueryImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 438
    Top = 34
  end
end
