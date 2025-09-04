object IncidenciaModule: TIncidenciaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmIncidenciaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Incidencia'
    IndexFieldNames = 'Codigo'
    Left = 76
    Top = 18
  end
end
