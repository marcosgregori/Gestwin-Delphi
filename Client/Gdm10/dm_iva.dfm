object TasaModule: TTasaModule
  Tag = 1
  OnCreate = TasaModuleCreate
  OnDestroy = TasaModuleDestroy
  Height = 202
  Width = 207
  object DmTiposIVATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'FechaAplicacion;CodigoPais;Codigo'
    Left = 84
    Top = 22
  end
  object DmRelacionesTiposIVATable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVA'
    IndexFieldNames = 'CodigoPais;Codigo'
    Left = 82
    Top = 92
  end
end
