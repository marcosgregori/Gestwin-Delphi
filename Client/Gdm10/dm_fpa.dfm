object FormaPagoModule: TFormaPagoModule
  Tag = 1
  OnDestroy = formaPagoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmFormaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 62
    Top = 30
  end
end
