object EfectoCobrarModule: TEfectoCobrarModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 292
  Width = 330
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 54
    Top = 104
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 56
    Top = 168
  end
  object DmEfectoCobrarTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 56
    Top = 32
  end
  object DmFormaCobroTable: TnxeTable
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 206
    Top = 112
  end
  object DmEfectoCobrarAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 208
    Top = 34
  end
end
