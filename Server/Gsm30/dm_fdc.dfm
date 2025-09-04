object FacturaComprasModule: TFacturaComprasModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 590
  Width = 788
  PixelsPerInch = 120
  object DmEfectoTable: TnxeTable
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 270
    Top = 40
  end
  object DmProveedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 90
    Top = 253
  end
  object DmProveedorDatEconTable: TnxeTable
    Timeout = 6000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 90
    Top = 323
  end
  object DmFormaPagoTable: TnxeTable
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 270
    Top = 323
  end
  object DmArticuloDatEconTable: TnxeTable
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 90
    Top = 394
  end
  object DmFacturaComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    CreateIfAbsent = False
    Left = 90
    Top = 40
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    CreateIfAbsent = False
    Left = 90
    Top = 110
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    CreateIfAbsent = False
    Left = 90
    Top = 181
  end
  object DmFacturaComprasAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    CreateIfAbsent = False
    Left = 270
    Top = 394
  end
  object DmMovimientoCajaTable: TnxeTable
    Timeout = 6000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 90
    Top = 465
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 270
    Top = 465
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 444
    Top = 465
  end
  object DmEfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 270
    Top = 110
  end
  object DmFamiliaTable: TnxeTable
    Timeout = 6000
    TableName = 'Familia'
    IndexFieldNames = 'Codigo'
    Left = 270
    Top = 253
  end
  object RelacionAlbaranesTable: TnxeTable
    Session = BaseSessionDataModule.DBSession
    Timeout = 6000
    Filtered = True
    TableName = 'RelacionAlbaranes'
    IndexFieldNames = 'NroRegistro'
    TableType = ttTemporal
    Left = 618
    Top = 466
  end
  object DmFacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 425
    Top = 43
  end
  object ConsultaFacturas: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      '')
    Left = 555
    Top = 45
  end
end
