object ProvinciaModule: TProvinciaModule
  Tag = 1
  OnCreate = provinciaModuleCreate
  OnDestroy = provinciaModuleDestroy
  Height = 184
  Width = 263
  object DmProvinciaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Provincia'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 50
    Top = 20
  end
end
