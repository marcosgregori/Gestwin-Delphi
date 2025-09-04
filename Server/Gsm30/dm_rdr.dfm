object ReconstruccionResultadosModule: TReconstruccionResultadosModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 917
  Width = 690
  PixelsPerInch = 144
  object FacturaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 375
    Top = 138
  end
  object FacturaComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 375
    Top = 48
  end
  object MovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 111
    Top = 39
  end
  object LineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 111
    Top = 230
  end
  object MovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 111
    Top = 317
  end
  object LineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistroOrigen'
    Left = 111
    Top = 407
  end
  object GrupoLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 111
    Top = 143
  end
  object ArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 375
    Top = 246
  end
  object LineaMovimientoAux1Table: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 111
    Top = 503
  end
  object StockTable: TnxeTable
    Timeout = 6000
    TableName = 'Stock'
    IndexFieldNames = 
      'Ejercicio;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;' +
      'LoteFabricacion;Ubicacion;CodigoAlmacen'
    Left = 375
    Top = 345
  end
  object FacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;NroRegistro'
    Left = 369
    Top = 693
  end
  object AsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 369
    Top = 585
  end
  object FacturaComercialTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 369
    Top = 792
  end
end
