object LicenciasModule: TLicenciasModule
  Tag = 1
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 422
  Width = 538
  object MovimientosQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      'Select *'
      'From ClienteDatEcon')
    Left = 176
    Top = 150
  end
  object TarjetaRegistroTable: TnxeTable
    Timeout = 6000
    TableName = 'TarjetaRegistro'
    IndexFieldNames = 'NroRegistro'
    Left = 48
    Top = 20
  end
  object LineaTarjetaRegistroTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaTarjetaRegistro'
    IndexFieldNames = 'NroRegistro;NroLinea'
    Left = 176
    Top = 20
  end
  object ClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 48
    Top = 86
  end
  object EfectoCobrarTable: TnxeTable
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 48
    Top = 150
  end
  object RemesaTable: TnxeTable
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 48
    Top = 210
  end
  object RegistroAplicacionTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroAplicacion'
    IndexFieldNames = 'NroRegistro'
    Left = 328
    Top = 20
  end
  object TareasQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      'Select *'
      'From Tarea')
    Left = 176
    Top = 210
  end
  object FacturaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 46
    Top = 280
  end
  object RegistroActualizacionesTable: TnxeTable
    Timeout = 6000
    TableName = 'RegistroActualizaciones'
    IndexFieldNames = 'NroRegistroAplicacion'
    Left = 328
    Top = 86
  end
end
