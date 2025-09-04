object AsientoModule: TAsientoModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 275
  Width = 422
  object DmApunteTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 56
    Top = 102
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 56
    Top = 36
  end
  object DmAsientoAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 189
    Top = 94
  end
  object SQLQuery: TnxeQuery
    Timeout = 180000
    BeforeOpen = TablesBeforeOpen
    ReadOnly = True
    Left = 56
    Top = 174
  end
  object DmApunteAuxTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 189
    Top = 164
  end
  object DmAsientoDocumentoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 189
    Top = 34
  end
  object DeApunteTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 328
    Top = 104
  end
  object DeAsientoTable: TnxeTable
    Timeout = 6000
    BeforeOpen = TablesBeforeOpen
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 328
    Top = 38
  end
end
