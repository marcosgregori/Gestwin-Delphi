object MaquinaModule: TMaquinaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 477
  Width = 581
  object DmMaquinaTable: TnxeTable
    Timeout = 6000
    TableName = 'Maquina'
    IndexFieldNames = 'Codigo'
    Left = 77
    Top = 34
  end
  object DmMaquinaTipoTable: TnxeTable
    Timeout = 6000
    TableName = 'MaquinaTipo'
    IndexFieldNames = 'Codigo'
    Left = 77
    Top = 96
  end
  object DmOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    Left = 75
    Top = 160
  end
  object DmRelacionOperacionesTable: TnxeTable
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 73
    Top = 228
  end
  object DmOcupacionMaquinaTable: TnxeTable
    Timeout = 6000
    TableName = 'OcupacionMaquina'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno'
    Left = 75
    Top = 298
  end
  object DmSecuenciaAsignacionTable: TnxeTable
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'Ejercicio;NroOrdenFabricacion;NroProceso;Segmento'
    Left = 231
    Top = 36
  end
  object DmSecuenciaAsignacion2Table: TnxeTable
    Timeout = 6000
    TableName = 'SecuenciaAsignacion'
    IndexFieldNames = 'CodigoMaquina;Fecha;Turno;Prioridad;NroOrdenFabricacion'
    Left = 233
    Top = 98
  end
  object DmInformeFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'InformeFabricacion'
    IndexFieldNames = 'Ejercicio;NroOrden;NroProceso;Fecha;Turno'
    Left = 233
    Top = 166
  end
  object DmAsignacionMaquinasTable: TnxeTable
    Timeout = 6000
    TableName = 'AsignacionMaquinas'
    IndexFieldNames = 'CodigoMaquinaTipo'
    Left = 235
    Top = 228
  end
  object DmTurnoTable: TnxeTable
    Timeout = 6000
    TableName = 'Turno'
    IndexFieldNames = 'NroTurno'
    Left = 237
    Top = 298
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 385
    Top = 36
  end
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 387
    Top = 98
  end
  object DmOperariosMaquinaTable: TnxeTable
    Timeout = 6000
    TableName = 'OperariosMaquina'
    IndexFieldNames = 'CodigoMaquina;Turno;NroRegistro'
    Left = 73
    Top = 366
  end
end
