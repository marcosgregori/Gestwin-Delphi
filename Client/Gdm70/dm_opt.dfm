object OperarioTipoModule: TOperarioTipoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmOperarioTipoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OperarioTipo'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
