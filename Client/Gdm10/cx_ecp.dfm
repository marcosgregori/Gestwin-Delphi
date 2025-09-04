object cxEcpForm: TcxEcpForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de efectos a pagar '
  ClientHeight = 192
  ClientWidth = 850
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
  ShowHint = True
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object QueryPanel: TgQueryPanel
    Left = 0
    Top = 163
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryNroFactura
    FixedRangeField = QueryFechaVencimiento
    SourceQuery = Query
    LockConnectorText = 'del proveedor/acreedor'
    OnUserSelection = QueryPanelUserSelection
    AfterReadQueryState = QueryPanelAfterReadQueryState
    Height = 29
    Width = 850
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 850
    Height = 163
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 431114264
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
      object TableViewEjercicio: TcxGridDBColumn
        Caption = 'Ejerc.'
        DataBinding.FieldName = 'Ejercicio'
        Width = 43
      end
      object TableViewFechaVencimiento: TcxGridDBColumn
        Caption = 'Vencimiento'
        DataBinding.FieldName = 'FechaVencimiento'
        Width = 80
      end
      object TableViewSerieNroFactura: TcxGridDBColumn
        Caption = 'Serie / N'#186' Factura'
        DataBinding.FieldName = 'SerieNroFactura'
        PropertiesClassName = 'TcxTextEditProperties'
        OnGetProperties = TableViewSerieNroFacturaGetProperties
        Width = 120
      end
      object TableViewSerie: TcxGridDBColumn
        DataBinding.FieldName = 'Serie'
        Visible = False
        VisibleForCustomization = False
      end
      object TableViewNroFactura: TcxGridDBColumn
        DataBinding.FieldName = 'NroFactura'
        PropertiesClassName = 'TcxIntegerEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Visible = False
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
      end
      object TableViewNroEfecto: TcxGridDBColumn
        Caption = 'N'#186' Efec.'
        DataBinding.FieldName = 'NroEfecto'
        Width = 68
      end
      object TableViewSubcuentaProveedor: TcxGridDBColumn
        Caption = 'Proveedor'
        DataBinding.FieldName = 'SubcuentaProveedor'
        Width = 72
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Nombre'
        DataBinding.FieldName = 'Descripcion'
        Width = 223
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 62
      end
      object TableViewNroRemesa: TcxGridDBColumn
        Caption = 'Remesa'
        DataBinding.FieldName = 'NroRemesa'
        Width = 63
      end
      object TableViewFechaPago: TcxGridDBColumn
        Caption = 'Pago'
        DataBinding.FieldName = 'FechaPago'
        Width = 64
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Filtered = True
    OnCalcFields = QueryCalcFields
    OnFilterRecord = QueryFilterRecord
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       FechaVencimiento,'
      '       FechaPago,'
      '       Serie,'
      '       NroFactura,       '
      '       NroEfecto,'
      '       SubcuentaProveedor,'
      '       Cuenta.Descripcion,'
      '       SubcuentaEntidad,'
      '       Importe,'
      '       NroRemesa'
      'FROM   EfectoPagar, Cuenta'
      'WHERE  Cuenta.Codigo=SubcuentaProveedor'
      'ORDER BY FechaVencimiento')
    Left = 282
    Top = 38
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object QueryFechaPago: TDateField
      FieldName = 'FechaPago'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 40
    end
    object QueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object QuerySerieNroFactura: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'SerieNroFactura'
      Size = 40
      Calculated = True
    end
    object QueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object QueryProveedor: TWideStringField
      FieldName = 'SubcuentaProveedor'
      Size = 9
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 40
    end
    object QueryEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object QueryImporte: TBCDField
      FieldName = 'Importe'
    end
    object QueryNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 282
    Top = 74
  end
end
