object TarjetaRegistroModule: TTarjetaRegistroModule
  Tag = 1
  OldCreateOrder = True
  OnCreate = TarjetaRegistroModuleCreate
  OnDestroy = TarjetaRegistroModuleDestroy
  Height = 291
  Width = 444
  object MovimientosQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'Select *'
      'From ClienteDatEcon')
    Left = 174
    Top = 156
  end
  object TarjetaRegistroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarjetaRegistro'
    IndexFieldNames = 'NroRegistro'
    Left = 46
    Top = 22
  end
  object LineaTarjetaRegistroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaTarjetaRegistro'
    IndexFieldNames = 'NroRegistro;NroLinea'
    Left = 176
    Top = 22
  end
  object ClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 46
    Top = 88
  end
  object EfectoCobrarTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'EfectoCobrar'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura;NroEfecto'
    Left = 44
    Top = 154
  end
  object RemesaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Remesa'
    IndexFieldNames = 'Ejercicio;NroRemesa'
    Left = 44
    Top = 212
  end
  object RegistroAplicacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RegistroAplicacion'
    IndexFieldNames = 'NroRegistro'
    Left = 178
    Top = 88
  end
  object VentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'VentaPeriodica'
    IndexFieldNames = 'NroFicha'
    AutoIncFieldName = 'NroFicha'
    Left = 326
    Top = 24
  end
  object LineaVentaPeriodicaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaVentaPeriodica'
    IndexFieldNames = 'NroFicha;NroRegistro'
    AutoIncFieldName = 'NroRegistro'
    Left = 326
    Top = 82
  end
  object TarjetaRegistroAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarjetaRegistro'
    IndexFieldNames = 'CodigoGestion;FechaInstalacion'
    Left = 326
    Top = 152
  end
end
