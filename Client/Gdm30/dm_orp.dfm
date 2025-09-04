object OrganismoPublicoModule: TOrganismoPublicoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 210
  Width = 230
  object DmOrganismoPublicoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'OrganismoPublico'
    IndexFieldNames = 'Tipo;Codigo'
    Left = 76
    Top = 28
  end
end
