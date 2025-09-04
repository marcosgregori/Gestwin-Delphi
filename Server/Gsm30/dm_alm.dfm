object AlmacenModule: TAlmacenModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 205
  Width = 222
  object DmAlmacenTable: TnxeTable
    Timeout = 15000
    TableName = 'Almacen'
    IndexFieldNames = 'Codigo'
    Left = 90
    Top = 28
  end
  object DmExistenciasArticuloTable: TnxeTable
    Timeout = 15000
    TableName = 'ExistenciasArticulo'
    IndexFieldNames = 'CodigoArticulo;CodigoAlmacen'
    Left = 86
    Top = 102
  end
end
