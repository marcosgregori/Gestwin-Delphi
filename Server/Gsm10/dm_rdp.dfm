object RemesaPagoModule: TRemesaPagoModule
  Tag = 1
  OnCreate = remesaPagoModuleCreate
  OnDestroy = remesaPagoModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 437
  Width = 330
  object DmRemesaPagoTable: TnxeTable
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 78
    Top = 32
  end
  object DmEfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa'
    Left = 76
    Top = 110
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 74
    Top = 182
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 74
    Top = 252
  end
end
