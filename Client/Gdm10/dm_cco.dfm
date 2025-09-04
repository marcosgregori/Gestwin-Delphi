object CentroCosteModule: TCentroCosteModule
  Tag = 1
  OnDestroy = CentroCosteModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmCentroCosteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CentroCoste'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
end
