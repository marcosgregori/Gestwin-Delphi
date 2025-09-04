object DireccionContactoModule: TDireccionContactoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 251
  Width = 276
  object DmDireccionContactoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'DireccionContacto'
    IndexFieldNames = 'Tipo;Codigo;TipoDocumento'
    Left = 78
    Top = 26
  end
end
