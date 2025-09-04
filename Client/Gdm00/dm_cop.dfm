object CodigoPostalModule: TCodigoPostalModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 323
  Width = 330
  PixelsPerInch = 144
  object DmCodigoPostalTable: TnxeTable
    ActiveRuntime = True
    Database = DataAccessModule.AppDatabase
    Timeout = 6000
    TableName = 'CodigoPostal'
    IndexFieldNames = 'CodigoPais;CodigoProvincia;Codigo'
    Left = 105
    Top = 30
  end
end
