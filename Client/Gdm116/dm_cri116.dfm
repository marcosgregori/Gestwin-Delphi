object Cristaleria116Module: TCristaleria116Module
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 256
  Width = 214
  object DmTarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 64
    Top = 94
  end
  object DmCodigoTarifaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoTarifa'
    IndexFieldNames = 'Codigo'
    Left = 64
    Top = 24
  end
  object DmLineaValoracionManufacturaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaValoracionManufactura'
    IndexFieldNames = 'NroRegistroLinea'
    OpenOnMasterActivation = False
    Left = 56
    Top = 174
  end
end
