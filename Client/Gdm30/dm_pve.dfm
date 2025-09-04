object PreventaModule: TPreventaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 489
  Width = 412
  object ExpClienteTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 73
    Top = 91
  end
  object ExpConsumosClienteTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    Left = 73
    Top = 147
  end
  object ExpRutaTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    Left = 73
    Top = 202
  end
  object ExpLineaRutaTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta;NroOrden'
    Left = 73
    Top = 258
  end
  object ExpEfectoCobrarTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 73
    Top = 329
  end
  object ExpEquipoMovilTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 71
    Top = 24
  end
  object ImpMovimientoTable: TnxeTable
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 245
    Top = 22
  end
  object ImpLineaMovimientoTable: TnxeTable
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 247
    Top = 82
  end
  object ImpFacturaVentasTable: TnxeTable
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 247
    Top = 137
  end
  object ExpVendedorTable: TnxeTable
    Database = SessionDataModule.ExportsDatabase
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 73
    Top = 392
  end
  object ImpEfectoCobrarTable: TnxeTable
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 249
    Top = 193
  end
  object ImpEfectoTable: TnxeTable
    Database = SessionDataModule.ImportsDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 249
    Top = 255
  end
end
