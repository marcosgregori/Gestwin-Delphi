object EfectoCobrarModule: TEfectoCobrarModule
  Tag = 1
  OnCreate = EfectoCobrarModuleCreate
  OnDestroy = EfectoCobrarModuleDestroy
  Height = 246
  Width = 206
  object DmEfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 84
    Top = 38
  end
end
