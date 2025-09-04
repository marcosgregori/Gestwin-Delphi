object EquipoMovilModule: TEquipoMovilModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmEquipoMovilTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 44
    Top = 30
  end
end
