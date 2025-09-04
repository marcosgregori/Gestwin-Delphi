object TipoEnvaseModule: TTipoEnvaseModule
  Tag = 1
  OnCreate = TipoEnvaseModuleCreate
  OnDestroy = TipoEnvaseModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmTipoEnvaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoEnvase'
    IndexFieldNames = 'Codigo'
    Left = 76
    Top = 18
  end
end
