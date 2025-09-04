object PaisModule: TPaisModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 263
  object DmPaisTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Pais'
    IndexFieldNames = 'Codigo'
    Left = 50
    Top = 30
  end
end
