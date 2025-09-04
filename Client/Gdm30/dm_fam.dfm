object FamiliaModule: TFamiliaModule
  Tag = 1
  OnCreate = familiaModuleCreate
  OnDestroy = familiaModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmFamiliaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 16
  end
end
