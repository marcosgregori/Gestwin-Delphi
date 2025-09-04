object SustitucionSubcuentasModule: TSustitucionSubcuentasModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = False
  Height = 482
  Width = 293
  object ProveedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Subcuenta'
    Left = 63
    Top = 36
  end
  object ClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Subcuenta'
    Left = 175
    Top = 36
  end
  object ApunteTable: TnxeTable
    Timeout = 6000
    TableName = 'Apunte'
    IndexFieldNames = 'Ejercicio;NroAsiento;NroApunte'
    Left = 175
    Top = 90
  end
  object AsientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Asiento'
    IndexFieldNames = 'Ejercicio;NroAsiento'
    Left = 175
    Top = 146
  end
  object CuentaTable: TnxeTable
    Timeout = 6000
    TableName = 'Cuenta'
    IndexFieldNames = 'Codigo'
    Left = 175
    Top = 194
  end
  object SaldosTable: TnxeTable
    Timeout = 6000
    TableName = 'Saldos'
    IndexFieldNames = 'Ejercicio;Codigo;CentroCoste'
    Left = 63
    Top = 374
  end
  object EfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 63
    Top = 314
  end
  object EfectoPagarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoPagar'
    Left = 63
    Top = 254
  end
  object ExistenciaTable: TnxeTable
    Timeout = 6000
    TableName = 'Existencia'
    Left = 63
    Top = 196
  end
  object RemesaTable: TnxeTable
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 63
    Top = 142
  end
  object RemesaPagoTable: TnxeTable
    Timeout = 6000
    TableName = 'RemesaPago'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 63
    Top = 88
  end
end
