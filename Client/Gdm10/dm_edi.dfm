object InmovilizadoModule: TInmovilizadoModule
  Tag = 1
  OnCreate = inmovilizadoModuleCreate
  OnDestroy = inmovilizadoModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmInmovilizadoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Inmovilizado'
    IndexFieldNames = 'Codigo'
    Left = 46
    Top = 20
  end
end
