object RenumeracionAsientosModule: TRenumeracionAsientosModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 438
  Width = 384
  object AsientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 58
    Top = 322
  end
  object RemesaPagoTable: TnxeTable
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 190
    Top = 208
  end
  object EfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 190
    Top = 156
  end
  object EfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    IndexFieldNames = 'Ejercicio;SubcuentaProveedor;Serie;NroFactura;NroEfecto'
    Left = 58
    Top = 265
  end
  object RemesaTable: TnxeTable
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 58
    Top = 209
  end
  object MovimientoCajaTable: TnxeTable
    Timeout = 6000
    TableName = 'MovimientoCaja'
    IndexFieldNames = 'Ejercicio;Serie;NroOperacion'
    Left = 58
    Top = 154
  end
  object FacturaTable: TnxeTable
    Timeout = 6000
    TableName = 'Factura'
    IndexFieldNames = 'Tipo;Ejercicio;NroRegistro'
    Left = 190
    Top = 268
  end
  object Asiento1Table: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 58
    Top = 32
  end
  object Asiento2Table: TnxeTable
    Database = EnterpriseDataModule.Database
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 190
    Top = 28
  end
  object ApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 58
    Top = 96
  end
end
