object FacturaModule: TFacturaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  Height = 214
  Width = 198
  object DmFacturaContableTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;NroRegistro'
    Left = 72
    Top = 36
  end
  object DmFacturaComercialTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 72
    Top = 110
  end
end
