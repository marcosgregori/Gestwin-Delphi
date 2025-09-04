object RemesaModule: TRemesaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 303
  Width = 374
  object DmRemesaTable: TnxeTable
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 48
    Top = 30
  end
  object DmEfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 50
    Top = 84
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 178
    Top = 30
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 178
    Top = 86
  end
end
