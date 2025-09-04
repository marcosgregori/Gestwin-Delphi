object RutaModule: TRutaModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 195
  Width = 215
  PixelsPerInch = 96
  object DmRutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Ruta'
    IndexFieldNames = 'Codigo'
    Left = 42
    Top = 16
  end
  object DmLineaRutaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaRuta'
    IndexFieldNames = 'CodigoRuta;NroOrden'
    Left = 42
    Top = 80
  end
end
