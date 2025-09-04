object GadgetI100Frame: TGadgetI100Frame
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object Grid: TcxGrid
    Left = 0
    Top = 29
    Width = 451
    Height = 275
    Align = alClient
    TabOrder = 0
    object TableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = TableViewCustomDrawCell
      DataController.DataSource = DataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Appending = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      object TableViewFechaVencimento: TcxGridDBColumn
        Caption = 'Vencimiento'
        DataBinding.FieldName = 'FechaVencimiento'
      end
      object TableViewImporteCobros: TcxGridDBColumn
        Caption = 'Cobros'
        DataBinding.FieldName = 'ImporteCobros'
      end
      object TableViewImportePagos: TcxGridDBColumn
        Caption = 'Pagos'
        DataBinding.FieldName = 'ImportePagos'
      end
      object TableViewSaldo: TcxGridDBColumn
        DataBinding.FieldName = 'Saldo'
      end
    end
    object Level: TcxGridLevel
      GridView = TableView
    end
  end
  object Panel1: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    Style.BorderStyle = ebsNone
    TabOrder = 1
    DesignSize = (
      451
      29)
    Height = 29
    Width = 451
    object Label1: TLabel
      Left = 10
      Top = 8
      Width = 85
      Height = 13
      Caption = 'Cuenta financiera'
    end
    object CuentaFinancieraCtrl: TcxDBExtLookupComboBox
      Left = 105
      Top = 4
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'Subcuenta'
      DataBinding.DataSource = LookupDataSource
      Properties.Required = True
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownSizeable = True
      Properties.HideSelection = False
      Properties.ImmediatePost = True
      Properties.View = GridViewRepositoryTableView
      Properties.KeyFieldNames = 'Subcuenta'
      Properties.ListFieldItem = GridViewRepositoryTableViewNombre
      Properties.OnChange = CuentaFinancieraCtrlPropertiesChange
      TabOrder = 0
      Width = 250
    end
  end
  object Consulta: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      
        'SELECT EfectoCobrar.FechaVencimiento AS FechaVencimiento, Import' +
        'e'
      'FROM EfectoCobrar'
      'WHERE 0>0')
    
    Left = 8
    Top = 108
    object ConsultaFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object ConsultaImporte: TBCDField
      FieldName = 'Importe'
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Cobros'
        SQLText = 
          'SELECT EfectoCobrar.FechaVencimiento AS FechaVencimiento, SUM( E' +
          'fectoCobrar.Importe ) AS Importe'#13#10'FROM EfectoCobrar'#13#10'     LEFT J' +
          'OIN Remesa ON ( EfectoCobrar.EjercicioRemesa=Remesa.Ejercicio AN' +
          'D EfectoCobrar.NroRemesa=Remesa.NroRemesa )'#13#10'WHERE ( Entidad=<En' +
          'tidad>) AND '#13#10'      ( FechaVencimiento>=<Fecha> ) AND'#13#10'      ( (' +
          ' FechaCobro IS NULL AND ( ( NroRemesa=0 ) OR NroRemesa IS NULL )' +
          ' ) OR'#13#10'        ( ( NroRemesa<>0 ) and ( Remesa.Estado=0 ) ) ) //' +
          ' Pendiente'#13#10'GROUP BY EfectoCobrar.FechaVencimiento '#13#10'ORDER BY Ef' +
          'ectoCobrar.FechaVencimiento'
      end
      item
        Title = 'Pagos'
        SQLText = 
          'SELECT EfectoPagar.FechaVencimiento AS FechaVencimiento, SUM( Ef' +
          'ectoPagar.Importe ) AS Importe'#13#10'FROM EfectoPagar'#13#10'LEFT JOIN Reme' +
          'sa ON ( EfectoPagar.EjercicioRemesa=Remesa.Ejercicio AND EfectoP' +
          'agar.NroRemesa=Remesa.NroRemesa )'#13#10'WHERE ( Entidad=<Entidad>) AN' +
          'D '#13#10'      ( FechaVencimiento>=<Fecha> ) AND'#13#10'      ( ( FechaPago' +
          ' IS NULL AND ( ( NroRemesa=0 ) OR NroRemesa IS NULL ) ) OR'#13#10'    ' +
          '    ( ( NroRemesa<>0 ) and ( Remesa.Estado=0 ) ) ) // Pendiente'#13 +
          #10'GROUP BY EfectoPagar.FechaVencimiento'#13#10'ORDER BY EfectoPagar.Fec' +
          'haVencimiento'
      end>
    Left = 8
    Top = 140
  end
  object Data: TgxMemData
    Indexes = <
      item
        FieldName = 'FechaVencimiento'
        SortOptions = []
      end>
    SortOptions = []
    Left = 8
    Top = 172
    object DataFechaVencimiento: TDateField
      FieldName = 'FechaVencimiento'
    end
    object DataImporteCobros: TBCDField
      FieldName = 'ImporteCobros'
    end
    object DataImportePagos: TBCDField
      FieldName = 'ImportePagos'
    end
    object DataSaldo: TBCDField
      FieldName = 'Saldo'
    end
  end
  object DataSource: TDataSource
    DataSet = Data
    Left = 8
    Top = 204
  end
  object FrameManager: TgFrameManager
    Dataset = Data
    OnInitialize = FrameManagerInitialize
    OnUpdate = FrameManagerUpdate
    Left = 39
    Top = 106
  end
  object BancoTable: TnxeTable
    ActiveRuntime = True
    ActiveDesigntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Banco'
    IndexFieldNames = 'Subcuenta'
    
    Left = 411
    Top = 88
    object BancoTableSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      Size = 9
    end
    object BancoTableNombre: TWideStringField
      FieldName = 'Nombre'
      Size = 40
    end
  end
  object BancoTableDataSource: TDataSource
    DataSet = BancoTable
    Left = 379
    Top = 88
  end
  object GridViewRepository: TcxGridViewRepository
    Left = 380
    Top = 120
    object GridViewRepositoryTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = BancoTableDataSource
      DataController.KeyFieldNames = 'Subcuenta'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = GridViewRepositoryTableViewNombre
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnHorzSizing = False
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      object GridViewRepositoryTableViewSubcuenta: TcxGridDBColumn
        DataBinding.FieldName = 'Subcuenta'
      end
      object GridViewRepositoryTableViewNombre: TcxGridDBColumn
        DataBinding.FieldName = 'Nombre'
      end
    end
  end
  object LookupData: TgxMemData
    Indexes = <>
    SortOptions = []
    
    Left = 331
    Top = 87
    object LookupDataSubcuenta: TWideStringField
      FieldName = 'Subcuenta'
      LookupDataSet = BancoTable
      LookupKeyFields = 'Subcuenta'
      LookupResultField = 'Subcuenta'
      Size = 9
    end
    object LookupDataTodas: TBooleanField
      FieldName = 'Todas'
    end
    object LookupDataFechaVencimientoInicial: TDateField
      FieldName = 'FechaVencimientoInicial'
    end
  end
  object LookupDataSource: TDataSource
    DataSet = LookupData
    Left = 296
    Top = 87
  end
end
