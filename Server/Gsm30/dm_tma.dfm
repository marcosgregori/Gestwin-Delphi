object TipoMovAlmacenModule: TTipoMovAlmacenModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 150
  Width = 215
  object DmTipoMovAlmacenTable: TnxeTable
    Timeout = 15000
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
