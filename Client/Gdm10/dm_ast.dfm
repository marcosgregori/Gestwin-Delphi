object AsientoModule: TAsientoModule
  Tag = 1
  OnCreate = AsientoModuleCreate
  OnDestroy = AsientoModuleDestroy
  Height = 306
  Width = 319
  object DmAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 64
    Top = 22
  end
  object DmAsientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 65
    Top = 94
  end
end
