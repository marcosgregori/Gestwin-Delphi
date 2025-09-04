object ReconstruccionDatosInternosModule: TReconstruccionDatosInternosModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 420
  Width = 521
  object DmNotificacionESTable: TnxeTable
    Timeout = 6000
    TableName = 'NotificacionES'
    IndexFieldNames = 'Ejercicio;NroNotificacion'
    Left = 60
    Top = 98
  end
  object DmSecuenciaAsignacionTable: TnxeTable
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Fecha;Turno'
    Left = 206
    Top = 246
  end
  object DmLineaOFComponenteTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    Left = 204
    Top = 170
  end
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 204
    Top = 98
  end
  object DmOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 59
    Top = 168
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 59
    Top = 26
  end
  object DmInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    Left = 203
    Top = 32
  end
end
