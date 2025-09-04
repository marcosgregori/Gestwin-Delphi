object MntArtTvaFrame: TMntArtTvaFrame
  Left = 0
  Top = 0
  Width = 948
  Height = 442
  Anchors = [akTop, akRight]
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object FramePanel: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 0
    Height = 442
    Width = 948
    object TarifaVentasGrid: TcxGrid
      Left = 2
      Top = 2
      Width = 906
      Height = 438
      Align = alClient
      TabOrder = 0
      object TarifaVentasTableView: TcxGridDBTableView
        Tag = 585561968
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataModeController.SmartRefresh = True
        DataController.DataSource = TarifaVentasDataSource
        DataController.KeyFieldNames = 'Codigo'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object TarifaVentasTableViewCodigo: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'Codigo'
          Options.Editing = False
          Width = 35
        end
        object TarifaVentasTableViewDescripcion: TcxGridDBColumn
          Caption = 'Descripci'#243'n'
          DataBinding.FieldName = 'Descripcion'
          Options.Editing = False
        end
        object TarifaVentasTableViewDisponible: TcxGridDBColumn
          DataBinding.FieldName = 'Disponible'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.NullStyle = nssUnchecked
          Visible = False
          Width = 20
        end
        object TarifaVentasTableViewCantidadMinima: TcxGridDBColumn
          Caption = 'Cant. m'#237'nima'
          DataBinding.FieldName = 'CantidadMinima'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 9
          Width = 50
        end
        object TarifaVentasTableViewPrecio: TcxGridDBColumn
          DataBinding.FieldName = 'Precio'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 9
        end
        object TarifaVentasTableViewRecargo: TcxGridDBColumn
          DataBinding.FieldName = 'Recargo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 9
        end
        object TarifaVentasTableViewDescuento: TcxGridDBColumn
          Caption = '% Dto.'
          DataBinding.FieldName = 'Descuento'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.MaxLength = 5
          Width = 50
        end
      end
      object TarifaVentasGridLevel: TcxGridLevel
        GridView = TarifaVentasTableView
      end
    end
    object GridTableViewController1: TGridTableViewController
      Left = 908
      Top = 2
      Align = alRight
      Enabled = False
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      TableView = TarifaVentasTableView
      ShiftRecords = False
      UseGridFilterBox = False
      Height = 438
      Width = 38
    end
  end
  object TarifaVentasDataSource: TDataSource
    DataSet = TarifaVentasCachedDataset
    Enabled = False
    Left = 557
    Top = 143
  end
  object TarifaVentasCachedDataset: TnxeCachedDataSet
    Database = SessionDataModule.TmpDatabase
    Options = [cdsoSetVisibleFields]
    BeforePost = TarifaVentasCachedDatasetBeforePost
    SourceDataSet = TarifaVentasQuery
    Left = 592
    Top = 143
    object TarifaVentasCachedDatasetCodigo: TWideStringField
      FieldName = 'Codigo'
      Size = 2
    end
    object TarifaVentasCachedDatasetDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 30
    end
    object TarifaVentasCachedDatasetTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object TarifaVentasCachedDatasetCodigoTarifa: TWideStringField
      FieldName = 'CodigoTarifa'
      Size = 5
    end
    object TarifaVentasCachedDatasetCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object TarifaVentasCachedDatasetReferencia: TWideStringField
      FieldName = 'Referencia'
    end
    object TarifaVentasCachedDatasetCantidadMinima: TBCDField
      FieldName = 'CantidadMinima'
      Precision = 16
    end
    object TarifaVentasCachedDatasetPrecio: TFloatField
      FieldName = 'Precio'
    end
    object TarifaVentasCachedDatasetRecargo: TBCDField
      FieldName = 'Recargo'
    end
    object TarifaVentasCachedDatasetDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object TarifaVentasCachedDatasetDisponible: TBooleanField
      FieldName = 'Disponible'
    end
  end
  object TarifaVentasQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    AfterOpen = TarifaVentasQueryAfterOpen
    DataSource = MntArtForm.ArticuloDataSource
    SQL.Strings = (
      'SELECT CodigoTarifa.Codigo AS Codigo,'
      '       CodigoTarifa.Descripcion,'
      '       TarifaVentas.*'
      
        'FROM CodigoTarifa LEFT JOIN TarifaVentas ON ( Tipo=0 AND TarifaV' +
        'entas.CodigoTarifa=CodigoTarifa.Codigo AND CodigoArticulo=:Codig' +
        'o )'
      'ORDER BY Codigo')
    OpenOnMasterActivation = False
    Left = 626
    Top = 143
    ParamData = <
      item
        DataType = ftWideString
        Name = 'Codigo'
        ParamType = ptUnknown
        Size = 14
      end>
  end
  object TarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'CodigoArticulo;Tipo;CodigoTarifa'
    Left = 660
    Top = 143
  end
end
