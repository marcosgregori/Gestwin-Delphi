object FormaEnvioModule: TFormaEnvioModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 132
  Width = 213
  PixelsPerInch = 96
  object DmFormaEnvioTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaEnvio'
    IndexFieldNames = 'Codigo'
    Left = 44
    Top = 22
  end
end
