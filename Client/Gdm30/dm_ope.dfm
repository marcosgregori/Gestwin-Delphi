object OperarioModule: TOperarioModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmOperarioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Operario'
    IndexFieldNames = 'CodigoPropietario;Codigo'
    Left = 44
    Top = 18
  end
end
