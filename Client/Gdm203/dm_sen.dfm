object StockEnvasesModule: TStockEnvasesModule
  Tag = 1
  OnCreate = EnvasesModuleCreate
  OnDestroy = EnvasesModuleDestroy
  Height = 184
  Width = 263
  object DmStockEnvasesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'StockEnvases'
    IndexFieldNames = 'Propietario;TipoEnvase;CodigoEnvase'
    Left = 70
    Top = 22
  end
end
