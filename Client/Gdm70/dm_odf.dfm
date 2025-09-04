object OrdenFabricacionModule: TOrdenFabricacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 256
  Width = 265
  object DmOrdenFabricacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 76
    Top = 18
  end
end
