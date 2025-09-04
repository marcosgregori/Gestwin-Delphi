object Cristaleria116Module: TCristaleria116Module
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 208
  Width = 312
  object MovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 122
    Top = 46
  end
  object LineaValoracionManufacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaValoracionManufactura'
    IndexFieldNames = 'NroRegistroLinea'
    OpenOnMasterActivation = False
    Left = 122
    Top = 118
  end
end
