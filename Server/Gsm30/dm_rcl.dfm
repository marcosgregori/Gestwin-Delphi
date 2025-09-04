object RelacionesClienteModule: TRelacionesClienteModule
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 260
  Width = 219
  PixelsPerInch = 96
  object DmClienteDatEconTable: TnxeTable
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 62
    Top = 40
  end
  object DmConsumosClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC'
    Left = 62
    Top = 110
  end
end
