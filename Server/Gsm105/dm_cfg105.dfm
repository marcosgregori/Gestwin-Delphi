object Configuracion105Module: TConfiguracion105Module
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 253
  Width = 303
  object VendedoresFacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'VendedoresFactura'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    AutoIncFieldName = 'NroRegistro'
    Left = 76
    Top = 26
  end
  object VendedoresClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'VendedoresCliente'
    IndexFieldNames = 'CodigoCliente;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    Left = 74
    Top = 96
  end
end
