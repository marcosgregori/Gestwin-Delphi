object ProveedorModule: TProveedorModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 129
  Width = 214
  PixelsPerInch = 96
  object DmProveedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 74
    Top = 28
  end
end
