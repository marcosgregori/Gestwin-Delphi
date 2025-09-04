object VendedorModule: TVendedorModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = vendedorModuleCreate
  OnDestroy = vendedorModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 237
  Width = 276
  object DmVendedorDatEconTable: TnxeTable
    Timeout = 6000
    TableName = 'VendedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 78
    Top = 74
  end
  object DmTablaComisionTable: TnxeTable
    Timeout = 6000
    TableName = 'TablaComision'
    IndexFieldNames = 'Relacion;CodigoVendedor;CodigoCliente;CodigoArticulo'
    Left = 78
    Top = 130
  end
  object DmVendedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 82
    Top = 16
  end
end
