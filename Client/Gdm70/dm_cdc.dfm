object CodigoCosteModule: TCodigoCosteModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 304
  PixelsPerInch = 96
  object DmCodigoCosteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoCoste'
    IndexFieldNames = 'Codigo'
    Left = 68
    Top = 34
  end
end
