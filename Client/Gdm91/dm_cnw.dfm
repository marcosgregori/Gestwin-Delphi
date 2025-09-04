object ContactoWebModule: TContactoWebModule
  Tag = 1
  OnCreate = ContactoWebModuleCreate
  OnDestroy = ContactoWebModuleDestroy
  Height = 184
  Width = 263
  object DmContactoWebTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ContactoWeb'
    IndexFieldNames = 'Codigo'
    Left = 54
    Top = 14
  end
end
