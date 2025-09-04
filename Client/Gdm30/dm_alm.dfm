object AlmacenModule: TAlmacenModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 199
  Width = 204
  PixelsPerInch = 96
  object DmAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 76
    Top = 26
  end
  object DmExistenciasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ExistenciasArticulo'
    IndexFieldNames = 'CodigoArticulo;CodigoAlmacen'
    Left = 74
    Top = 98
  end
end
