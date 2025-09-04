object TipoVentaPeriodicaModule: TTipoVentaPeriodicaModule
  Tag = 1
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  PixelsPerInch = 96
  object DmTipoVentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoVentaPeriodica'
    IndexFieldNames = 'Tipo'
    Left = 76
    Top = 18
    object DmTipoVentaPeriodicaTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DmTipoVentaPeriodicaTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 25
    end
  end
end
