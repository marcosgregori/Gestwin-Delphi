object FacturaComprasModule: TFacturaComprasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 487
  Width = 326
  object DmEfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 210
    Top = 20
  end
  object DmProveedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 66
    Top = 176
  end
  object DmProveedorDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ProveedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 66
    Top = 228
  end
  object DmFormaPagoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaPago'
    IndexFieldNames = 'Codigo'
    Left = 210
    Top = 178
  end
  object DmArticuloDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 66
    Top = 284
  end
  object Report: TgxReportManager
    FileName = 'ffc'
    HideReportList = True
    SQLItems = <>
    ToPrinter = False
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 64
    Top = 422
  end
  object DmFacturaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 64
    Top = 16
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 66
    Top = 66
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 66
    Top = 120
  end
  object DmFacturaComprasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    Left = 208
    Top = 276
  end
end
