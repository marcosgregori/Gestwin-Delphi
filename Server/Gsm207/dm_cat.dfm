object CategoriaModule: TCategoriaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 145
  Width = 244
  object DmCategoriaTable: TnxeTable
    Timeout = 6000
    TableName = 'Categoria'
    IndexFieldNames = 'Codigo'
    Left = 74
    Top = 24
  end
end
