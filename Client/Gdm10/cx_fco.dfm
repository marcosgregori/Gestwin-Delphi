object cxFcoForm: TcxFcoForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de formas de cobro'
  ClientHeight = 290
  ClientWidth = 369
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
  PixelsPerInch = 96
  TextHeight = 17
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 261
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SearchField = QueryDescripcion
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 369
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 369
    Height = 261
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    ExplicitWidth = 340
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 518115240
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewDescripcion
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
      object cxGridDBTableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 35
      end
      object cxGridDBTableViewDescripcion: TcxGridDBColumn
        Caption = 'Descripci'#243'n'
        DataBinding.FieldName = 'Descripcion'
        Width = 258
      end
      object cxGridDBTableViewPlazos: TcxGridDBColumn
        DataBinding.FieldName = 'Plazos'
        Visible = False
      end
      object cxGridDBTableViewPrimerVencimiento: TcxGridDBColumn
        Caption = 'Primer Venc.'
        DataBinding.FieldName = 'PrimerVencimiento'
        Visible = False
      end
      object cxGridDBTableViewIntervalo: TcxGridDBColumn
        DataBinding.FieldName = 'Intervalo'
        Visible = False
      end
      object cxGridDBTableViewDiaCobro1: TcxGridDBColumn
        Caption = 'Dia Cobro 1'
        DataBinding.FieldName = 'DiaCobro1'
        Visible = False
      end
      object cxGridDBTableViewDiaCobro2: TcxGridDBColumn
        Caption = 'Dia Cobro 2'
        DataBinding.FieldName = 'DiaCobro2'
        Visible = False
      end
      object cxGridDBTableViewCanalPreferente: TcxGridDBColumn
        Caption = 'Canal Pref.'
        DataBinding.FieldName = 'CanalPreferente'
        Visible = False
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
      
        'SELECT Codigo, Descripcion, Plazos, PrimerVencimiento, Intervalo' +
        ', DiaCobro1, DiaCobro2, CanalPreferente '
      'FROM   FormaCobro'
      'ORDER BY Codigo')
    Left = 84
    Top = 71
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object QueryPlazos: TSmallintField
      FieldName = 'Plazos'
    end
    object QueryPrimerVencimiento: TSmallintField
      FieldName = 'PrimerVencimiento'
    end
    object QueryIntervalo: TSmallintField
      FieldName = 'Intervalo'
    end
    object QueryDiaCobro1: TSmallintField
      FieldName = 'DiaCobro1'
    end
    object QueryDiaCobro2: TSmallintField
      FieldName = 'DiaCobro2'
    end
    object QueryCanalPreferente: TWideStringField
      FieldName = 'CanalPreferente'
      Size = 9
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 84
    Top = 102
  end
end
