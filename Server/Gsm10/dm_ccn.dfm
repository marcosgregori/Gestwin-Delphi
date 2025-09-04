object CierreContableModule: TCierreContableModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = False
  Height = 442
  Width = 283
  object Saldos1Table: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 93
    Top = 252
  end
  object Saldos2Table: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 93
    Top = 312
  end
  object ApunteBrowseTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 93
    Top = 190
  end
  object ApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 93
    Top = 130
  end
  object AsientoTable: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 97
    Top = 22
  end
  object AsientoAuxTable: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 95
    Top = 78
  end
end
