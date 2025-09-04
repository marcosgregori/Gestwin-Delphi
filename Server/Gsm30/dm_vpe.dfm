object VentasPeriodicasModule: TVentasPeriodicasModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 383
  Width = 557
  object DmLineaVentaPeriodicaTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaVentaPeriodica'
    IndexFieldNames = 'NroFicha;NroRegistro'
    Left = 74
    Top = 104
  end
  object DmVentaPeriodicaTable: TnxeTable
    Timeout = 6000
    TableName = 'VentaPeriodica'
    IndexFieldNames = 'Serie;CodigoCliente'
    Left = 72
    Top = 38
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 210
    Top = 38
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 211
    Top = 104
  end
end
