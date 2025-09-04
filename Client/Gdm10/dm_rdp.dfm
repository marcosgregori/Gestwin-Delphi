object RemesaPagoModule: TRemesaPagoModule
  Tag = 1
  OnCreate = remesaPagoModuleCreate
  OnDestroy = remesaPagoModuleDestroy
  Height = 113
  Width = 185
  object DmRemesaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 62
    Top = 16
  end
end
