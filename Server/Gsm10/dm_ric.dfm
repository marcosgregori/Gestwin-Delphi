object RegularizacionIVAModule: TRegularizacionIVAModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 282
  Width = 426
  object ApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 41
    Top = 24
  end
  object AsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;NroRegistro'
    Left = 155
    Top = 26
  end
  object EfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 155
    Top = 96
  end
  object EfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'FechaVencimiento'
    Left = 41
    Top = 94
  end
end
