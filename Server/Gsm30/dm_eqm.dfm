object EquipoMovilModule: TEquipoMovilModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 326
  Width = 544
  object DmEquipoMovilTable: TnxeTable
    Timeout = 15000
    TableName = 'EquipoMovil'
    IndexFieldNames = 'Codigo'
    Left = 75
    Top = 40
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 15000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 186
    Top = 42
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 15000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 184
    Top = 113
  end
end
