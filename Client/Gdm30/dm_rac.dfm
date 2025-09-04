object AuxiliarClienteModule: TAuxiliarClienteModule
  Tag = 1
  OnCreate = auxiliarClienteModuleCreate
  OnDestroy = auxiliarClienteModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmAuxiliarClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'AuxiliarCliente'
    IndexFieldNames = 'CodigoCliente;Codigo'
    Left = 74
    Top = 18
  end
end
