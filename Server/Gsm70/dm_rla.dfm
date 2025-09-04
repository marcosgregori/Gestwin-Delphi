object LanzamientoModule: TLanzamientoModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 447
  Width = 427
  object DmLanzamientoTable: TnxeTable
    Timeout = 15000
    TableName = 'Lanzamiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    Left = 61
    Top = 34
  end
  object DmLineaLanzamientoTable: TnxeTable
    Timeout = 15000
    TableName = 'LineaLanzamiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroRegistro'
    Left = 61
    Top = 180
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 15000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 61
    Top = 256
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 15000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 63
    Top = 334
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 15000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 205
    Top = 32
  end
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 15000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 207
    Top = 104
  end
  object DmLineaOFComponenteTable: TnxeTable
    Timeout = 15000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 207
    Top = 180
  end
  object DmLanzamientoAuxTable: TnxeTable
    Timeout = 15000
    TableName = 'Lanzamiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    Left = 61
    Top = 108
  end
end
