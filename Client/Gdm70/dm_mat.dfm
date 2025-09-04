object MaquinaTipoModule: TMaquinaTipoModule
  Tag = 1
  OnCreate = MaquinaTipoModuleCreate
  OnDestroy = MaquinaTipoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmMaquinaTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'MaquinaTipo'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
