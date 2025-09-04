object ClienteModule: TClienteModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 234
  Width = 198
  object DmClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 60
    Top = 16
  end
  object DmDireccionContactoTable: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    TableName = 'DireccionContacto'
    IndexFieldNames = 'Tipo;Codigo;NroRegistro'
    Left = 59
    Top = 90
  end
end
