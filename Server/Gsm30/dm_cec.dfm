object CierreComercialModule: TCierreComercialModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 359
  Width = 430
  object LineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 179
    Top = 28
  end
  object MovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 51
    Top = 30
  end
  object StockTable: TnxeTable
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 53
    Top = 106
  end
  object NuevoStockTable: TnxeTable
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 179
    Top = 108
  end
end
