object HojaCargaModule: THojaCargaModule
  Tag = 1
  OnCreate = HojaCargaModuleCreate
  OnDestroy = HojaCargaModuleDestroy
  Height = 187
  Width = 233
  PixelsPerInch = 96
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 61
    Top = 34
  end
  object DmLineaHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 63
    Top = 102
  end
end
