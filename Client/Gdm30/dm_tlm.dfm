object TipoLineaMovimientoModule: TTipoLineaMovimientoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 132
  Width = 213
  PixelsPerInch = 96
  object DmTipoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoLineaMovimiento'
    IndexFieldNames = 'Codigo'
    Left = 73
    Top = 18
  end
end
