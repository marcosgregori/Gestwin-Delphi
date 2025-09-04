object RemesaModule: TRemesaModule
  Tag = 1
  OnCreate = RemesaModuleCreate
  OnDestroy = RemesaModuleDestroy
  Height = 157
  Width = 209
  object DmRemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 68
    Top = 34
  end
end
