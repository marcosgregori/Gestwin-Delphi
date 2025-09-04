object ImportacionFacturasVenta117Module: TImportacionFacturasVenta117Module
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 402
  Width = 645
  PixelsPerInch = 144
  object LineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 287
    Top = 69
  end
  object MovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 102
    Top = 66
  end
  object FacturaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    CreateIfAbsent = False
    Left = 102
    Top = 183
  end
end
