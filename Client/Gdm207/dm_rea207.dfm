object RegistroActualizacionTiendaModule: TRegistroActualizacionTiendaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 250
  Width = 272
  object DmRegistroActualizacionIDTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;ID'
    Left = 88
    Top = 34
  end
  object DmRegistroActualizacionCodigoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroActualizacion'
    IndexFieldNames = 'TipoRegistro;Codigo'
    Left = 90
    Top = 108
  end
end
