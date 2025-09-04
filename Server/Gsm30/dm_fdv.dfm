object FacturaVentasModule: TFacturaVentasModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 590
  Width = 934
  PixelsPerInch = 120
  object DmFacturaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    CreateIfAbsent = False
    Left = 88
    Top = 35
  end
  object DmFacturaVentasAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 88
    Top = 115
  end
  object DmFormaCobroTable: TnxeTable
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 272
    Top = 35
  end
  object DmClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 274
    Top = 115
  end
  object DmGrupoClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoCliente'
    IndexFieldNames = 'Codigo'
    Left = 274
    Top = 208
  end
  object DmEfectoTable: TnxeTable
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 435
    Top = 38
  end
  object DmClienteDatEconTable: TnxeTable
    Tag = 6000
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 597
    Top = 38
  end
  object DmVendedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 435
    Top = 118
  end
  object DmVendedorDatEconTable: TnxeTable
    Tag = 6000
    Timeout = 6000
    TableName = 'VendedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 430
    Top = 210
  end
  object DmArticuloDatEconTable: TnxeTable
    Tag = 6000
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 599
    Top = 118
  end
  object AlbaranesFacturaQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      'SELECT * '
      'FROM Movimiento'
      
        'WHERE TipoMovimiento=15 AND EjercicioFactura=:EjercicioFactura A' +
        'ND PropietarioFactura=:Propietario AND SerieFactura=:SerieFactur' +
        'a AND NroFactura=:NroFactura'
      'ORDER BY NroDocumento')
    Left = 599
    Top = 210
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'EjercicioFactura'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'Propietario'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'SerieFactura'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'NroFactura'
        ParamType = ptUnknown
      end>
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    CreateIfAbsent = False
    Left = 88
    Top = 208
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    CreateIfAbsent = False
    Left = 88
    Top = 389
  end
  object DmMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    CreateIfAbsent = False
    Left = 88
    Top = 298
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    CreateIfAbsent = False
    Left = 88
    Top = 473
  end
  object RelacionAlbaranesTable: TnxeTable
    Timeout = 6000
    Filtered = True
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    TableType = ttTemporal
    Left = 593
    Top = 319
  end
  object DmMovimientoCajaTable: TnxeTable
    Timeout = 6000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 785
    Top = 312
  end
  object DmEfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 782
    Top = 210
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 782
    Top = 118
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 783
    Top = 38
  end
  object DmFacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 428
    Top = 308
  end
  object DmAsientoFacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 425
    Top = 400
  end
  object DmTiposIVAArticuloPaisTable: TnxeTable
    Timeout = 6000
    TableName = 'TiposIVAArticuloPais'
    IndexFieldNames = 'CodigoArticulo;CodigoPais'
    Left = 423
    Top = 489
  end
end
