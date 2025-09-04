object CmdMve40Module: TCmdMve40Module
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 297
  Width = 314
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 71
    Top = 101
  end
  object DmHojaCargaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'EjercicioReubicacion;NroOperacionReubicacion'
    Left = 69
    Top = 32
  end
end
