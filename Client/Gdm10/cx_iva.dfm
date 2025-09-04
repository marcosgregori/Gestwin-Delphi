object CxIvaForm: TCxIvaForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tipos de I.V.A.'
  ClientHeight = 211
  ClientWidth = 665
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
    Top = 175
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceField = QueryCodigo
    SourceQuery = Query
    Height = 36
    Width = 665
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 665
    Height = 175
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 46330680
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
      OptionsBehavior.IncSearchItem = TableViewCodigo
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
        Caption = 'N'#186
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 25
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 180
      end
      object TableViewIVASoportado: TcxGridDBColumn
        Caption = '% IVA Sop.'
        DataBinding.FieldName = 'IVASoportado'
      end
      object TableViewCtaSoportado: TcxGridDBColumn
        Caption = 'Subcuenta'
        DataBinding.FieldName = 'CtaSoportado'
        Width = 65
      end
      object TableViewIVAREpercutido: TcxGridDBColumn
        Caption = '% IVA Rep.'
        DataBinding.FieldName = 'IVAREpercutido'
      end
      object TableViewRERepercutido: TcxGridDBColumn
        Caption = '% RE'
        DataBinding.FieldName = 'RERepercutido'
        Width = 45
      end
      object TableViewCtaRepercutido: TcxGridDBColumn
        Caption = 'Subcuenta'
        DataBinding.FieldName = 'CtaRepercutido'
        Width = 65
      end
      object TableViewLiquidable: TcxGridDBColumn
        Caption = 'Liquid.'
        DataBinding.FieldName = 'Liquidable'
        Width = 38
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    SQL.Strings = (
      'SELECT *'
      'FROM   TiposIVA'
      'WHERE  FechaAplicacion=:FechaAplicacion AND'
      '       CodigoPais=:CodigoPais AND'
      '       Codigo BETWEEN 1 AND 24'
      'ORDER BY Codigo')
    Left = 282
    Top = 38
    ParamData = <
      item
        DataType = ftDate
        Name = 'FechaAplicacion'
        ParamType = ptUnknown
        Value = 0d
      end
      item
        DataType = ftWideString
        Name = 'CodigoPais'
        ParamType = ptUnknown
      end>
    object QueryCodigo: TSmallintField
      FieldName = 'Codigo'
      MaxValue = 24
      MinValue = 1
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 15
    end
    object QueryIVASoportado: TBCDField
      FieldName = 'IVASoportado'
    end
    object QueryCtaSoportado: TWideStringField
      FieldName = 'CtaSoportado'
      Size = 9
    end
    object QueryIVAREpercutido: TBCDField
      FieldName = 'IVAREpercutido'
    end
    object QueryRERepercutido: TBCDField
      FieldName = 'RERepercutido'
    end
    object QueryCtaRepercutido: TWideStringField
      FieldName = 'CtaRepercutido'
      Size = 9
    end
    object QueryLiquidable: TBooleanField
      FieldName = 'Liquidable'
    end
    object QuerySobreTotal: TBooleanField
      FieldName = 'SobreTotal'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 282
    Top = 76
  end
end
