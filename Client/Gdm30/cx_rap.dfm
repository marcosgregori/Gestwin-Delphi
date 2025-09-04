object CxRapForm: TCxRapForm
  Left = 662
  Top = 178
  HelpType = htKeyword
  HelpKeyword = 'consultas'
  BorderStyle = bsDialog
  Caption = 'Consulta de '
  ClientHeight = 300
  ClientWidth = 433
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
    Top = 271
    Align = alBottom
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    GridTableView = TableView
    SearchField = QueryCampo1
    SourceField = QueryCodigo
    FixedRangeField = QueryCodigo
    SourceQuery = Query
    Height = 29
    Width = 433
  end
  object Grid: TcxGrid
    Left = 0
    Top = 0
    Width = 433
    Height = 271
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    TabOrder = 1
    object TableView: TcxGridDBTableView
      Tag = 240419984
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
      OptionsBehavior.IncSearchItem = TableViewCampo1
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
      object TableViewCodigo: TcxGridDBColumn
        Caption = 'C'#243'd.'
        DataBinding.FieldName = 'Codigo'
        Styles.Content = ApplicationContainer.QueryContentSourceColumnStyle
        VisibleForCustomization = False
        Width = 54
      end
      object TableViewCampo1: TcxGridDBColumn
        DataBinding.FieldName = 'Campo1'
        Width = 308
      end
      object TableViewCampo2: TcxGridDBColumn
        DataBinding.FieldName = 'Campo2'
        Visible = False
      end
      object TableViewCampo3: TcxGridDBColumn
        DataBinding.FieldName = 'Campo3'
        Visible = False
      end
      object TableViewCampo4: TcxGridDBColumn
        DataBinding.FieldName = 'Campo4'
        Visible = False
      end
      object TableViewCampo5: TcxGridDBColumn
        DataBinding.FieldName = 'Campo5'
        Visible = False
      end
      object TableViewCampo6: TcxGridDBColumn
        DataBinding.FieldName = 'Campo6'
        Visible = False
      end
      object TableViewCampo7: TcxGridDBColumn
        DataBinding.FieldName = 'Campo7'
        Visible = False
      end
      object TableViewCampo8: TcxGridDBColumn
        DataBinding.FieldName = 'Campo8'
        Visible = False
      end
      object TableViewCampoFecha1: TcxGridDBColumn
        DataBinding.FieldName = 'CampoFecha1'
        Visible = False
      end
      object TableViewCampoFecha2: TcxGridDBColumn
        DataBinding.FieldName = 'CampoFecha2'
        Visible = False
      end
      object TableViewCodigoProveedor: TcxGridDBColumn
        Caption = 'Proveedor'
        DataBinding.FieldName = 'CodigoProveedor'
        OnGetDataText = TableViewCodigoProveedorGetDataText
        Width = 71
      end
    end
    object GridLevel: TcxGridLevel
      GridView = TableView
    end
  end
  object Query: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT AuxiliarProveedor.*, Proveedor.Nombre AS NombreProveedor'
      'FROM   AuxiliarProveedor'
      
        '       LEFT JOIN Proveedor ON AuxiliarProveedor.CodigoProveedor=' +
        'Proveedor.Codigo')
    Left = 212
    Top = 78
    object QueryCodigo: TWideStringField
      FieldName = 'Codigo'
      Origin = 'AuxiliarProveedor.Codigo'
      Size = 3
    end
    object QueryCampo1: TWideStringField
      FieldName = 'Campo1'
      Size = 40
    end
    object QueryNombreProveedor: TWideStringField
      FieldName = 'NombreProveedor'
      Size = 60
    end
    object QueryCodigoProveedor: TWideStringField
      FieldName = 'CodigoProveedor'
      Size = 5
    end
    object QueryCampo2: TWideStringField
      FieldName = 'Campo2'
      Size = 40
    end
    object QueryCampo3: TWideStringField
      FieldName = 'Campo3'
    end
    object QueryCampo4: TWideStringField
      FieldName = 'Campo4'
    end
    object QueryCampo5: TWideStringField
      FieldName = 'Campo5'
    end
    object QueryCampo6: TWideStringField
      FieldName = 'Campo6'
    end
    object QueryCampo7: TWideStringField
      FieldName = 'Campo7'
    end
    object QueryCampo8: TWideStringField
      FieldName = 'Campo8'
    end
    object QueryCampoFecha1: TDateField
      FieldName = 'CampoFecha1'
    end
    object QueryCampoFecha2: TDateField
      FieldName = 'CampoFecha2'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 212
    Top = 110
  end
end
