object UbicacionModule: TUbicacionModule
  Tag = 1
  OnCreate = ubicacionModuleCreate
  OnDestroy = ubicacionModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmUbicacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ubicacion'
    IndexFieldNames = 'CodigoAlmacen;Codigo'
    Left = 42
    Top = 22
  end
end
