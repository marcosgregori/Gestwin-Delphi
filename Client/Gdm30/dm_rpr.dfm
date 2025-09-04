object RelacionesProveedorModule: TRelacionesProveedorModule
  Tag = 1
  OnCreate = proveedorModuleCreate
  OnDestroy = proveedorModuleDestroy
  Height = 188
  Width = 197
  object DmProveedorDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 56
    Top = 72
  end
  object DmTarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoArticulo;CodigoProveedor'
    Left = 56
    Top = 16
  end
end
