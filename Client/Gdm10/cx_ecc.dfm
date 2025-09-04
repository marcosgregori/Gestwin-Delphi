object cxEccForm: TcxEccForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de efectos a cobrar '
  ClientHeight = 208
  ClientWidth = 727
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
  object queryPanel: TgQueryPanel
    Left = 0
    Top = 179
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryDescripcion
    SourceField = QueryNroFactura
    FixedRangeField = QueryFechaVencimiento
    SourceQuery = Query
    LockConnectorText = 'de la serie'
    LockEmptyText = 'gen'#233'rica'
    OnUserSelection = queryPanelUserSelection
    Height = 29
    Width = 727
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 727
    Height = 179
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 22774456
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
        Width = 45
      end
      object TableViewFechaVencimiento: TcxGridDBColumn
        Caption = 'Vencimiento'
        DataBinding.FieldName = 'FechaVencimiento'
        Width = 83
      end
      object TableViewSerie: TcxGridDBColumn
        Caption = 'Se.'
        DataBinding.FieldName = 'Serie'
        Width = 27
      end
      object TableViewNroFactura: TcxGridDBColumn
        Caption = 'N'#186' Factura'
        DataBinding.FieldName = 'NroFactura'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 69
      end
      object TableViewNroEfecto: TcxGridDBColumn
        Caption = 'N'#186' Efec.'
        DataBinding.FieldName = 'NroEfecto'
        Width = 61
      end
      object TableViewCliente: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'SubcuentaCliente'
        Width = 67
      end
      object TableViewDescripcion: TcxGridDBColumn
        Caption = 'Nombre'
        DataBinding.FieldName = 'Descripcion'
        Width = 240
      end
      object TableViewImporte: TcxGridDBColumn
        DataBinding.FieldName = 'Importe'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;;#'
        Properties.EditFormat = '0.00;;#'
        Width = 76
      end
      object TableViewFechaCobro: TcxGridDBColumn
        Caption = 'Cobro'
        DataBinding.FieldName = 'FechaCobro'
        Visible = False
      end
      object TableViewCancelado: TcxGridDBColumn
        DataBinding.FieldName = 'Cancelado'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.NullStyle = nssUnchecked
        Visible = False
      end
      object TableViewNroRemesa: TcxGridDBColumn
        Caption = 'Remesa'
        DataBinding.FieldName = 'NroRemesa'
        Width = 73
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
    OnFilterRecord = QueryFilterRecord
    SQL.Strings = (
      'SELECT Ejercicio,'
      '       FechaVencimiento,'
      '       FechaCobro, Serie,'
      '       NroFactura,'
      '       NroEfecto,'
      '       SubcuentaCliente,'
      '       Cuenta.Descripcion,'
      '       SubcuentaEntidad,'
      '       Importe,'
      '       NroRemesa,'
      '       Impagado,'
      '       Cancelado'
      'FROM   EfectoCobrar, Cuenta'
      'WHERE  Cuenta.Codigo=SubcuentaCliente'
      'ORDER BY FechaVencimiento'
      '')
    Left = 282
    Top = 38
    object QueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object QueryFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object QueryFechaCobro: TDateField
      FieldName = 'FechaCobro'
    end
    object QuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object QueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object QueryNroEfecto: TSmallintField
      FieldName = 'NroEfecto'
    end
    object QueryCliente: TWideStringField
      FieldName = 'SubcuentaCliente'
      Size = 9
    end
    object QueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 40
    end
    object QueryImporte: TBCDField
      FieldName = 'Importe'
    end
    object QueryNroRemesa: TIntegerField
      FieldName = 'NroRemesa'
      DisplayFormat = '#'
    end
    object QueryCancelado: TBooleanField
      FieldName = 'Cancelado'
    end
    object QueryEntidad: TWideStringField
      FieldName = 'SubcuentaEntidad'
      Size = 9
    end
    object QueryImpagado: TBooleanField
      FieldName = 'Impagado'
    end
  end
  object dataSource: TDataSource
    DataSet = Query
    Left = 282
    Top = 66
  end
end
