object CodigoTarifaModule: TCodigoTarifaModule
  Tag = 1
  OnCreate = codigoTarifaModuleCreate
  OnDestroy = codigoTarifaModuleDestroy
  Height = 195
  Width = 215
  PixelsPerInch = 96
  object DmCodigoTarifaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoTarifa'
    IndexFieldNames = 'Codigo'
    Left = 70
    Top = 20
  end
  object DmTarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 70
    Top = 84
  end
end
