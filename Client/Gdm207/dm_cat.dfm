object CategoriaModule: TCategoriaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 214
  Width = 202
  object DmCategoriaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Categoria'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 18
  end
  object DmCategoriasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CategoriasArticulo'
    IndexFieldNames = 'CodigoArticulo;NroOrden;CodigoCategoria'
    Left = 68
    Top = 98
  end
end
