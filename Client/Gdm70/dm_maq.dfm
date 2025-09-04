object MaquinaModule: TMaquinaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 304
  Width = 263
  object DmMaquinaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Maquina'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
  object DmOcupacionMaquinaTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OcupacionMaquina'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno'
    Left = 69
    Top = 98
  end
end
