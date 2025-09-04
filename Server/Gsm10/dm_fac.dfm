object FacturaModule: TFacturaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 568
  Width = 662
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 58
    Top = 30
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 56
    Top = 104
  end
  object DmEfectoCobrarTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 356
    Top = 108
  end
  object DmFormaCobroTable: TnxeTable
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 358
    Top = 32
  end
  object DmEfectoPagarTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 356
    Top = 179
  end
  object DmApunteCajaTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 
      'TipoApunte;EjercicioFactura;Propietario;Serie;NroFactura;NroEfec' +
      'to'
    Left = 352
    Top = 260
  end
  object DmAsientoFacturaTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 56
    Top = 186
  end
  object DmFacturaContableTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;NroRegistro'
    Left = 64
    Top = 354
  end
  object DmFacturaComercialTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 62
    Top = 418
  end
  object DmFacturaContableAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 228
    Top = 354
  end
  object DmAsientoAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 204
    Top = 38
  end
  object DmApunteAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 202
    Top = 112
  end
end
