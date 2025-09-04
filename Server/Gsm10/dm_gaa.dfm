object GeneracionAmortizacionesModule: TGeneracionAmortizacionesModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 462
  Width = 441
  PixelsPerInch = 144
  object AsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Fecha'
    Left = 84
    Top = 48
  end
  object LineaInmovilizadoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaInmovilizado'
    IndexFieldNames = 'Codigo;NroRegistro'
    Left = 264
    Top = 141
  end
  object InmovilizadoTable: TnxeTable
    Timeout = 6000
    TableName = 'Inmovilizado'
    IndexFieldNames = 'Codigo'
    Left = 266
    Top = 48
  end
  object SaldosTable: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 80
    Top = 237
  end
  object ApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 83
    Top = 138
  end
  object ApunteAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Subcuenta;Fecha;NroAsiento;NroApunte'
    Left = 263
    Top = 354
  end
  object AsientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 84
    Top = 348
  end
end
