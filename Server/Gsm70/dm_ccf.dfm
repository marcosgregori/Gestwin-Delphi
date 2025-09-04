object CierreCicloFabricacionModule: TCierreCicloFabricacionModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 420
  Width = 554
  object DmOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 62
    Top = 20
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 314
    Top = 16
  end
  object DmDefectoTable: TnxeTable
    Timeout = 6000
    TableName = 'Defecto'
    IndexFieldNames = 'Codigo'
    Left = 314
    Top = 84
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 432
    Top = 18
  end
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 402
    Top = 254
  end
  object DmInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    Left = 62
    Top = 258
  end
  object DmInformeFabricacionPrevTable: TnxeTable
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    Left = 235
    Top = 256
  end
  object DmDefectoInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'DefectoInformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno;NroRegistro'
    Left = 315
    Top = 154
  end
  object DmMovimientoOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 192
    Top = 18
  end
  object DmHojaCargaTable: TnxeTable
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 193
    Top = 80
  end
  object DmLineaHojaCargaTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 62
    Top = 80
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 437
    Top = 80
  end
  object DmLineaMovimientoOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'NroRegistro'
    Left = 62
    Top = 202
  end
  object DmLineaOFComponenteTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    Left = 62
    Top = 138
  end
end
