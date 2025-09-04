object ImportacionAlbaranesVenta101Module: TImportacionAlbaranesVenta101Module
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 160
  Width = 345
  object LineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 191
    Top = 46
  end
  object MovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 68
    Top = 44
  end
end
