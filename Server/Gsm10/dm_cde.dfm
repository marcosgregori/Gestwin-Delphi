object ConsolidacionEmpresasModule: TConsolidacionEmpresasModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = False
  Height = 209
  Width = 315
  PixelsPerInch = 96
  object SaldosOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 189
    Top = 104
  end
  object CuentaOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 187
    Top = 40
  end
  object SaldosDestinoTable: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 65
    Top = 104
  end
  object CuentaDestinoTable: TnxeTable
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 69
    Top = 42
  end
end
