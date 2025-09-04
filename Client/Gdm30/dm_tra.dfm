object TransportistaModule: TTransportistaModule
  Tag = 1
  OnCreate = TransportistaModuleCreate
  OnDestroy = TransportistaModuleDestroy
  Height = 184
  Width = 263
  object DmTransportistaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Transportista'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
