object PaisModule: TPaisModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 184
  Width = 263
  object DmPaisTable: TnxeTable
    Timeout = 6000
    TableName = 'Pais'
    IndexFieldNames = 'Codigo'
    Left = 50
    Top = 30
  end
end
