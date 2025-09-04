object CodigoBarrasModule: TCodigoBarrasModule
  Tag = 1
  OnCreate = CodigoBarrasModuleCreate
  OnDestroy = CodigoBarrasModuleDestroy
  Height = 105
  Width = 196
  PixelsPerInch = 96
  object DmCodigoBarrasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 44
    Top = 16
  end
end
