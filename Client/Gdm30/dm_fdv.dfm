object FacturaVentasModule: TFacturaVentasModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 568
  Width = 842
  PixelsPerInch = 120
  object DmEfectoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Efecto'
    IndexFieldNames = 'Ejercicio;Tipo;Propietario;Serie;NroDocumento;NroEfecto'
    Left = 270
    Top = 35
  end
  object DmClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 454
    Top = 98
  end
  object DmClienteDatEconTable: TnxeTable
    Tag = 6000
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ClienteDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 454
    Top = 159
  end
  object DmSerieFacturacionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'SerieFacturacion'
    IndexFieldNames = 'Codigo'
    Left = 454
    Top = 223
  end
  object DmVendedorTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Vendedor'
    IndexFieldNames = 'Codigo'
    Left = 270
    Top = 97
  end
  object DmFormaCobroTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FormaCobro'
    IndexFieldNames = 'Codigo'
    Left = 627
    Top = 35
  end
  object DmVendedorDatEconTable: TnxeTable
    Tag = 6000
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'VendedorDatEcon'
    IndexFieldNames = 'Ejercicio;Codigo'
    Left = 270
    Top = 160
  end
  object DmArticuloDatEconTable: TnxeTable
    Tag = 6000
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 454
    Top = 295
  end
  object DmFacturaVentasAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 627
    Top = 97
  end
  object Report: TgxReportManager
    FileName = 'ffv'
    Title = 'Impresi'#243'n de facturas de venta'
    HideReportList = True
    SQLItems = <>
    ToPrinter = True
    OnSelectPrinter = ReportSelectPrinter
    OnSetReportName = ReportSetReportName
    Left = 89
    Top = 458
  end
  object DmFacturaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'FacturaVentas'
    IndexFieldNames = 'Ejercicio;Serie;NroFactura'
    Left = 88
    Top = 38
  end
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 88
    Top = 97
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 90
    Top = 230
  end
  object AlbaranesFacturaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT * '
      'FROM Movimiento'
      
        'WHERE TipoMovimiento=15 AND EjercicioFactura=:EjercicioFactura A' +
        'ND PropietarioFactura=:Propietario AND SerieFactura=:SerieFactur' +
        'a AND NroFactura=:NroFactura'
      'ORDER BY NroDocumento')
    Left = 627
    Top = 160
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'EjercicioFactura'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'Propietario'
        ParamType = ptUnknown
      end
      item
        DataType = ftWideString
        Name = 'SerieFactura'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'NroFactura'
        ParamType = ptUnknown
      end>
  end
  object DmMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 88
    Top = 160
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 88
    Top = 308
  end
  object DmArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 454
    Top = 35
  end
  object DmTiposIVAArticuloPaisTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TiposIVAArticuloPais'
    IndexFieldNames = 'CodigoArticulo;CodigoPais'
    Left = 455
    Top = 369
  end
end
