object EfectoPagarModule: TEfectoPagarModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 154
  Width = 243
  object DmEfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 74
    Top = 20
  end
end
