object ContactoModule: TContactoModule
  Tag = 1
  OnCreate = ContactoModuleCreate
  OnDestroy = ContactoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmContactoTable: TnxeTable
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Contacto'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 14
  end
end
