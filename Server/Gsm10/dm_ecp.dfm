object EfectoPagarModule: TEfectoPagarModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 345
  Width = 403
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 80
    Top = 104
  end
  object DmApunteTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 82
    Top = 168
  end
  object DmEfectoPagarTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 84
    Top = 32
  end
  object DmFormaPagoTable: TnxeTable
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 252
    Top = 104
  end
  object DmEfectoPagarAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 254
    Top = 28
  end
  object DmApunteAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 82
    Top = 240
  end
  object DmAsientoDocTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 250
    Top = 172
  end
  object DmApunteDocTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 250
    Top = 236
  end
end
