object SuministroStocksModule: TSuministroStocksModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 328
  Width = 393
  object DmSocioAUNATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SocioAUNA'
    IndexFieldNames = 'IdSocio'
    Left = 162
    Top = 104
  end
  object DmAlmacenAUNATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'AlmacenAUNA'
    IndexFieldNames = 'IdSocio;IdAlmacen'
    Left = 160
    Top = 178
  end
  object dmStockTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 160
    Top = 32
  end
end
