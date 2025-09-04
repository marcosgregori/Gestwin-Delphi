object OperacionModule: TOperacionModule
  Tag = 1
  OnCreate = OperacionModuleCreate
  OnDestroy = OperacionModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmOperacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
