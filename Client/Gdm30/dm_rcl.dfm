object RelacionesClienteModule: TRelacionesClienteModule
  Tag = 1
  OnCreate = RelacionesClienteModuleCreate
  OnDestroy = RelacionesClienteModuleDestroy
  Height = 164
  Width = 188
  object DmClienteDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 58
    Top = 14
  end
  object DmConsumosClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC'
    Left = 58
    Top = 76
  end
end
