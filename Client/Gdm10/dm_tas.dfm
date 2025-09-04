object TipoAsientoModule: TTipoAsientoModule
  Tag = 1
  OnCreate = tipoAsientoModuleCreate
  OnDestroy = tipoAsientoModuleDestroy
  Height = 200
  Width = 220
  object DmTipoAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoAsiento'
    IndexFieldNames = 'NroRegistro'
    Left = 82
    Top = 32
  end
  object DmLineaTipoAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaTipoAsiento'
    IndexFieldNames = 'NroRegistro;NroLinea'
    Left = 82
    Top = 94
  end
end
