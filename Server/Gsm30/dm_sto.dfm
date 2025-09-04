object StockAlmacenModule: TStockAlmacenModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 689
  Width = 650
  PixelsPerInch = 120
  object DmStockTable: TnxeTable
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 85
    Top = 135
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 
      'CodigoAlmacen;Ubicacion;CodigoArticulo;Fecha;NroOperacion;NroPag' +
      'ina;NroLinea'
    Left = 250
    Top = 50
  end
  object DmSerieFacturacionTable: TnxeTable
    Timeout = 6000
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    Left = 83
    Top = 223
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 248
    Top = 140
  end
  object DmTarifaComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 83
    Top = 305
  end
  object DmAlmacenTable: TnxeTable
    Timeout = 6000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 250
    Top = 218
  end
  object DmConsumoComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'ConsumoCompras'
    IndexFieldNames = 
      'Tipo;Ejercicio;Proveedor;FamiliaArticulo;CodigoClaseA;CodigoClas' +
      'eB;CodigoClaseC'
    Left = 83
    Top = 390
  end
  object DmConsumoVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'ConsumoVentas'
    IndexFieldNames = 
      'Tipo;Ejercicio;Cliente;FamiliaArticulo;CodigoClaseA;CodigoClaseB' +
      ';CodigoClaseC'
    Left = 248
    Top = 393
  end
  object DmTipoMovAlmacenTable: TnxeTable
    Timeout = 6000
    TableName = 'TipoMovAlmacen'
    IndexFieldNames = 'Tipo'
    Left = 248
    Top = 303
  end
  object DmArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 83
    Top = 53
  end
  object DmStockAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 75
    Top = 475
  end
  object DmArticuloListadoTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 245
    Top = 480
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 
      'CodigoAlmacen;Ubicacion;CodigoArticulo;Fecha;NroOperacion;NroPag' +
      'ina;NroLinea'
    Left = 450
    Top = 50
  end
  object DmMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 443
    Top = 143
  end
end
