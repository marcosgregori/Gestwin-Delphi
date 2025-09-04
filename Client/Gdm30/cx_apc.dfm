object cxApcForm: TcxApcForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de albaranes pendientes'
  ClientHeight = 183
  ClientWidth = 367
  Color = clBtnFace
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
    Top = 154
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    FixedRangeField = QueryFecha
    SourceQuery = Query
    OnColumVisibilityChanged = queryPanelColumVisibilityChanged
    Height = 29
    Width = 367
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 367
    Height = 154
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 355
    ExplicitHeight = 132
    object TableView: TcxGridDBTableView
      Tag = 431102912
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
      OptionsBehavior.IncSearchItem = TableViewNro_Documento
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
      object TableViewSerie: TcxGridDBColumn
        DataBinding.FieldName = 'Serie'
        Width = 25
      end
      object TableViewNro_Documento: TcxGridDBColumn
        Caption = 'N'#186' albar'#225'n'
        DataBinding.FieldName = 'NroDocumento'
      end
      object TableViewFecha: TcxGridDBColumn
        DataBinding.FieldName = 'Fecha'
      end
      object TableViewImporteNeto: TcxGridDBColumn
        Caption = 'Importe'
        DataBinding.FieldName = 'ImporteNeto'
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = QueryAfterOpen
    OnCalcFields = QueryCalcFields
    SQL.Strings = (
      
        'SELECT Ejercicio, NroOperacion, Serie, NroDocumento, Fecha, CAST' +
        '( 0.0 AS BCD(16,4) ) AS ImporteNeto'
      'FROM Movimiento'
      
        'WHERE ( TipoMovimiento=12 ) AND ( Propietario=:CodigoProveedor )' +
        ' AND ( NOT Facturado OR Facturado IS NULL )'
      'ORDER BY Ejercicio, Serie, NroDocumento')
    Left = 46
    Top = 40
    ParamData = <
      item
        DataType = ftWideString
        Name = 'CodigoProveedor'
        ParamType = ptUnknown
      end>
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
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
    object QueryImporteNeto: TBCDField
      FieldKind = fkCalculated
      FieldName = 'ImporteNeto'
      Calculated = True
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 16
    Top = 40
  end
end
