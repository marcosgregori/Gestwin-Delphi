object CxRetForm: TCxRetForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de tipos de retenci'#243'n'
  ClientHeight = 291
  ClientWidth = 409
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
    Top = 255
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SourceField = QueryCodigoRetencion
    SourceQuery = Query
    ExplicitTop = 262
    Height = 36
    Width = 409
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 409
    Height = 255
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitHeight = 262
    object TableView: TcxGridDBTableView
      Tag = 518111544
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
      OptionsBehavior.IncSearchItem = TableViewDescripcion
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
        DataBinding.FieldName = 'CodigoRetencion'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 35
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 180
      end
      object TableViewRetencion: TcxGridDBColumn
        Caption = '% Retenc.'
        DataBinding.FieldName = 'IVASoportado'
        PropertiesClassName = 'TcxCurrencyEditProperties'
      end
      object TableViewLiquidable: TcxGridDBColumn
        Caption = 'Desg.'
        DataBinding.FieldName = 'Liquidable'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
      end
      object TableViewSobreTotal: TcxGridDBColumn
        Caption = 'S/Total'
        DataBinding.FieldName = 'SobreTotal'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Width = 40
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
      'SELECT   *, Codigo - 500 AS CodigoRetencion'
      'FROM     TiposIVA'
      
        'WHERE  FechaAplicacion=:FechaAplicacion AND Codigo BETWEEN 501 A' +
        'ND 512'
      'ORDER BY CodigoRetencion')
    Left = 282
    Top = 38
    ParamData = <
      item
        DataType = ftDate
        Name = 'FechaAplicacion'
        ParamType = ptUnknown
        Value = 0d
      end>
    object QueryCodigo: TSmallintField
      FieldName = 'Codigo'
      MaxValue = 512
      MinValue = 501
    end
    object QueryCodigoRetencion: TLargeintField
      FieldName = 'CodigoRetencion'
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
    Top = 66
  end
end
