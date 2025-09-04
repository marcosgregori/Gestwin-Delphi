object NavieraModule: TNavieraModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmNavieraTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Naviera'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
