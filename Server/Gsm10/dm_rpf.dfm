object RegistroPresentacionModule: TRegistroPresentacionModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 358
  Width = 259
  PixelsPerInch = 120
  object DmRegistroPresentacionTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroPresentacion'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 93
    Top = 58
  end
  object DmRegistroPresentacionAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroPresentacion'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 85
    Top = 150
  end
end
