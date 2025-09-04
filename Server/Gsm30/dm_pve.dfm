object PreventaModule: TPreventaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 544
  Width = 487
  object DmEfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'SubcuentaCliente;FechaLibramiento'
    Left = 344
    Top = 40
  end
  object DmConsumosClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    Left = 71
    Top = 102
  end
  object DmVendedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 346
    Top = 100
  end
  object DmEquipoMovilTable: TnxeTable
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 75
    Top = 40
  end
  object DmLineaRutaTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta;NroOrden'
    Left = 346
    Top = 164
  end
  object DmRutaTable: TnxeTable
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    Left = 345
    Top = 226
  end
  object DmClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 73
    Top = 170
  end
  object DmDireccionContactoTable: TnxeTable
    Timeout = 6000
    TableName = 'DireccionContacto'
    IndexFieldNames = 'Tipo;Codigo;NroRegistro'
    Left = 71
    Top = 232
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 66
    Top = 314
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 346
    Top = 314
  end
  object DmFacturaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 66
    Top = 378
  end
  object DmEfectoTable: TnxeTable
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 64
    Top = 450
  end
  object DmRutasEquipoMovilTable: TnxeTable
    Timeout = 6000
    TableName = 'RutasEquipoMovil'
    IndexFieldNames = 'CodigoEquipoMovil;NroOrden;CodigoRuta'
    Left = 203
    Top = 40
  end
end
