object InformeFabricacionModule: TInformeFabricacionModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 534
  Width = 737
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 565
    Top = 118
  end
  object DmRelacionMaterialesTable: TnxeTable
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 73
    Top = 128
  end
  object DmLineaOFComponenteTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    Left = 563
    Top = 60
  end
  object DmRelacionOperacionesTable: TnxeTable
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 73
    Top = 204
  end
  object DmOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'NroOperacion'
    Left = 71
    Top = 276
  end
  object DmArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 75
    Top = 48
  end
  object DmInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    Left = 379
    Top = 54
  end
  object DmMaquinaTable: TnxeTable
    Timeout = 6000
    TableName = 'Maquina'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'NroOperacion'
    Left = 71
    Top = 346
  end
  object DmCosteMaquinaTable: TnxeTable
    Timeout = 6000
    TableName = 'CosteMaquina'
    IndexFieldNames = 'CodigoMaquina;NroRegistro'
    AutoIncFieldName = 'NroOperacion'
    Left = 71
    Top = 410
  end
  object DmCodigoCosteTable: TnxeTable
    Timeout = 6000
    TableName = 'CodigoCoste'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'NroOperacion'
    Left = 219
    Top = 48
  end
  object DmLineaInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaInformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno;NroRegistro'
    Left = 379
    Top = 124
  end
  object DmCosteOperarioTable: TnxeTable
    Timeout = 6000
    TableName = 'CosteOperario'
    IndexFieldNames = 'CodigoOperario;NroRegistro'
    AutoIncFieldName = 'NroOperacion'
    Left = 223
    Top = 134
  end
  object DmNotificacionESTable: TnxeTable
    Timeout = 6000
    TableName = 'NotificacionES'
    IndexFieldNames = 'EjercicioOrden;NroOrden;NroProceso'
    Left = 379
    Top = 190
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 377
    Top = 272
  end
  object DmSecuenciaAsignacionTable: TnxeTable
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento'
    AutoIncFieldName = 'NroProceso'
    Left = 378
    Top = 346
  end
  object DmSecuenciaAsignacionAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento'
    AutoIncFieldName = 'NroProceso'
    Left = 378
    Top = 416
  end
end
