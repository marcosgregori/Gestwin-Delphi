object FerroDataModule: TFerroDataModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 253
  Width = 185
  object DmFacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 61
    Top = 24
  end
  object DmEfectoPagarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'EjercicioRemesa;NroRemesa;FechaVencimiento'
    Left = 58
    Top = 166
  end
  object DmAsientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto'
    Left = 59
    Top = 98
  end
end
