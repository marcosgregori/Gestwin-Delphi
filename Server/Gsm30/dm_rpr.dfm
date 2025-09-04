object RelacionesProveedorModule: TRelacionesProveedorModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 376
  Width = 254
  object DmProveedorDatEconTable: TnxeTable
    Timeout = 15000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 92
    Top = 100
  end
  object DmTarifaComprasTable: TnxeTable
    Timeout = 15000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoArticulo;CodigoProveedor'
    Left = 92
    Top = 34
  end
end
