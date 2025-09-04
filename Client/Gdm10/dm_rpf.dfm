object RegistroPresentacionModule: TRegistroPresentacionModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 162
  Width = 255
  PixelsPerInch = 120
  object RegistroPresentacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroPresentacion'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 85
    Top = 40
  end
end
