object divisaModule: TdivisaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 130
  Width = 187
  PixelsPerInch = 96
  object DmDivisaTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'Divisa'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 22
  end
end
