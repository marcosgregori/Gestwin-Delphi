object OrdenFabricacionModule: TOrdenFabricacionModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 443
  Width = 879
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 245
    Top = 48
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 243
    Top = 120
  end
  object DmOrdenFabricacionTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 397
    Top = 48
  end
  object DmLineaOFOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 573
    Top = 110
  end
  object DmLineaLanzamientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaLanzamiento'
    IndexFieldNames = 
      'Ejercicio;NroOperacion;CodigoArticulo;CodigoClaseA;CodigoClaseB;' +
      'CodigoClaseC'
    Left = 393
    Top = 264
  end
  object DmLanzamientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Lanzamiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroOperacion'
    Left = 395
    Top = 184
  end
  object DmRelacionMaterialesTable: TnxeTable
    Timeout = 6000
    TableName = 'RelacionMateriales'
    IndexFieldNames = 
      'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso;Nr' +
      'oLinea'
    Left = 73
    Top = 46
  end
  object DmLineaOFComponenteTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    Left = 571
    Top = 52
  end
  object DmOrdenFabricacionAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'OrdenFabricacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden'
    Left = 397
    Top = 116
  end
  object DmRelacionOperacionesTable: TnxeTable
    Timeout = 6000
    TableName = 'RelacionOperaciones'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;Proceso'
    Left = 73
    Top = 122
  end
  object DmLineaOFPedidoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFPedido'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;EjercicioPedido;NroOperacionPedido'
    Left = 575
    Top = 180
  end
  object DmLineaOFOperacionAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFOperacion'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso'
    Left = 735
    Top = 110
  end
  object DmLineaOFComponenteAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaOFComponente'
    IndexFieldNames = 'Ejercicio;Tipo;NroOrden;NroProceso;NroRegistro'
    Left = 733
    Top = 52
  end
  object DmOperacionTable: TnxeTable
    Timeout = 6000
    TableName = 'Operacion'
    IndexFieldNames = 'Codigo'
    AutoIncFieldName = 'NroOperacion'
    Left = 71
    Top = 194
  end
  object DmMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 242
    Top = 190
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 240
    Top = 262
  end
  object OperacionesMemTable: TnxMemTable
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'Index1'
        Fields = 'Prioridad;FechaInicio;NroOrden'
      end
      item
        Name = 'Index2'
        Fields = 'Ejercicio;NroOrden'
      end>
    Left = 400
    Top = 360
    object OperacionesMemTableEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object OperacionesMemTableNroOrden: TLongWordField
      FieldName = 'NroOrden'
    end
    object OperacionesMemTableNroProceso: TSmallintField
      FieldName = 'NroProceso'
    end
    object OperacionesMemTablePrioridad: TSmallintField
      FieldName = 'Prioridad'
    end
    object OperacionesMemTableFechaInicio: TDateField
      FieldName = 'FechaInicio'
    end
    object OperacionesMemTableFechaFinalizacion: TDateField
      FieldName = 'FechaFinalizacion'
    end
  end
end
