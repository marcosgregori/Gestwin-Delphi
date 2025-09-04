object ImportacionFacturas121Module: TImportacionFacturas121Module
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 228
  Width = 361
  object DmApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 67
    Top = 114
  end
  object DmAsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 68
    Top = 46
  end
  object DmFacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;Propietario;SerieFactura;NroRegistro'
    Left = 188
    Top = 45
  end
  object DmEfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 188
    Top = 118
  end
end
