object EntidadFinancieraModule: TEntidadFinancieraModule
  Tag = 1
  OnCreate = EntidadFinancieraModuleCreate
  OnDestroy = EntidadFinancieraModuleDestroy
  Height = 184
  Width = 263
  PixelsPerInch = 96
  object DmEntidadFinancieraTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'EntidadFinanciera'
    IndexFieldNames = 'Codigo;Sucursal'
    Left = 108
    Top = 38
  end
end
