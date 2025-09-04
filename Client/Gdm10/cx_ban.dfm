object cxBanForm: TcxBanForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de cuentas financieras'
  ClientHeight = 192
  ClientWidth = 544
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
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 163
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = cxGridDBTableView
    SourceField = QuerySubcuenta
    FixedRangeField = QuerySubcuenta
    SourceQuery = Query
    OnUserSelection = QueryPanelUserSelection
    Height = 29
    Width = 544
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 544
    Height = 163
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object cxGridDBTableView: TcxGridDBTableView
      Tag = 518114624
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
      OptionsBehavior.IncSearchItem = cxGridDBTableViewNombre
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
      object cxGridDBTableViewSubcuenta: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'Subcuenta'
        Styles.Content = ApplicationForms.QueryContentSourceColumnStyle
        VisibleForCustomization = False
      end
      object cxGridDBTableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
      end
      object cxGridDBTableViewLocalidad: TcxGridDBColumn
        DataBinding.FieldName = 'Localidad'
      end
      object cxGridDBTableViewDomicilio: TcxGridDBColumn
        DataBinding.FieldName = 'Domicilio'
        Visible = False
      end
      object cxGridDBTableViewRiesgo: TcxGridDBColumn
        DataBinding.FieldName = 'Riesgo'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Visible = False
      end
      object cxGridDBTableViewDiasCancelacion: TcxGridDBColumn
        Caption = 'Dias Canc.'
        DataBinding.FieldName = 'DiasCancelacion'
        Visible = False
        Width = 55
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
      
        'Select  Subcuenta, Nombre, Domicilio, Localidad, Riesgo, DiasCan' +
        'celacion'
      'From Banco')
    Left = 282
    Top = 38
    object QuerySubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object QueryNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
    object QueryLocalidad: TWideStringField
      FieldName = 'Localidad'
      Size = 30
    end
    object QueryDomicilio: TWideStringField
      FieldName = 'Domicilio'
      Size = 40
    end
    object QueryRiesgo: TBCDField
      FieldName = 'Riesgo'
    end
    object QueryDiasCancelacion: TSmallintField
      FieldName = 'DiasCancelacion'
      DisplayFormat = '#'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 282
    Top = 66
  end
end
