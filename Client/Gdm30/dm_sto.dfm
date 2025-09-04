object StockAlmacenModule: TStockAlmacenModule
  Tag = 1
  OnCreate = StockDataModuleCreate
  OnDestroy = StockModuleDestroy
  Height = 561
  Width = 380
  object DmStockTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 76
    Top = 92
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 
      'CodigoAlmacen;Ubicacion;CodigoArticulo;Fecha;NroOperacion;NroPag' +
      'ina;NroLinea'
    Left = 230
    Top = 34
  end
  object DmSerieFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    Left = 74
    Top = 162
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 228
    Top = 106
  end
  object DmTarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 74
    Top = 228
  end
  object DmAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 230
    Top = 168
  end
  object DmConsumoComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumoCompras'
    IndexFieldNames = 
      'Tipo;Ejercicio;Proveedor;FamiliaArticulo;CodigoClaseA;CodigoClas' +
      'eB;CodigoClaseC'
    Left = 72
    Top = 354
  end
  object DmConsumoVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumoVentas'
    IndexFieldNames = 
      'Tipo;Ejercicio;Cliente;FamiliaArticulo;CodigoClaseA;CodigoClaseB' +
      ';CodigoClaseC'
    Left = 228
    Top = 302
  end
  object DmTipoMovAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoMovAlmacen'
    IndexFieldNames = 'Tipo'
    Left = 228
    Top = 236
  end
  object DmArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 74
    Top = 26
  end
  object DmTarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 72
    Top = 290
  end
  object DmExistenciasArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ExistenciasArticulo'
    IndexFieldNames = 'CodigoArticulo;CodigoAlmacen'
    Left = 70
    Top = 421
  end
end
