object GrupoClienteModule: TGrupoClienteModule
  Tag = 1
  OnCreate = grupoClienteModuleCreate
  OnDestroy = grupoClienteModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmGrupoClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoCliente'
    IndexFieldNames = 'Codigo'
    Left = 56
    Top = 20
  end
end
