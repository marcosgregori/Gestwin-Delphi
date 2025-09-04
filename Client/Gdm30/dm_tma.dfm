object TipoMovAlmacenModule: TTipoMovAlmacenModule
  Tag = 1
  OnCreate = tipoMovAlmacenModuleCreate
  OnDestroy = tipoMovAlmacenModuleDestroy
  Height = 119
  Width = 227
  object DmTipoMovAlmacenTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TipoMovAlmacen'
    IndexFieldNames = 'Tipo'
    Left = 76
    Top = 18
    object DmTipoMovAlmacenTableTipo: TSmallintField
      FieldName = 'Tipo'
    end
    object DmTipoMovAlmacenTableDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 25
    end
  end
end
