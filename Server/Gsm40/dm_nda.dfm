object AprovisionamientoModule: TAprovisionamientoModule
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 442
  Width = 483
  object DmExistenciasArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'ExistenciasArticulo'
    IndexFieldNames = 'CodigoArticulo;CodigoAlmacen'
    Left = 98
    Top = 42
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 96
    Top = 106
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 96
    Top = 169
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 96
    Top = 231
  end
end
