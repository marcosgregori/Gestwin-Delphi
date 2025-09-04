object ListaMaterialesModule: TListaMaterialesModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 365
  Width = 365
  PixelsPerInch = 120
  object DmListaMaterialesTable: TnxeTable
    Timeout = 6000
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    Left = 113
    Top = 33
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 113
    Top = 183
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 113
    Top = 113
  end
end
