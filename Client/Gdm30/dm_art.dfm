object ArticuloModule: TArticuloModule
  Tag = 1
  OnCreate = ArticuloModuleCreate
  OnDestroy = ArticuloModuleDestroy
  Height = 507
  Width = 409
  object DmArticuloTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 74
    Top = 24
  end
  object DmTarifaComprasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 74
    Top = 82
  end
  object DmTarifaVentasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 74
    Top = 146
  end
  object DmListaMaterialesTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    Left = 222
    Top = 24
  end
  object DmArticuloDatEconTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 222
    Top = 82
  end
  object DmTarifaClaseTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 74
    Top = 196
  end
  object DmTablaComisionTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TablaComision'
    IndexFieldNames = 'Relacion;CodigoVendedor;CodigoCliente;CodigoArticulo'
    Left = 74
    Top = 260
  end
  object DmTarifaCantidadVentaTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;CantidadMinima'
    Left = 74
    Top = 326
  end
  object DmCodigoBarrasTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 222
    Top = 142
  end
  object PrecioOfertaQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    SQL.Strings = (
      'SELECT TOP 1 *'
      
        'FROM ( SELECT Movimiento.Ejercicio, Movimiento.NroOperacion, Mov' +
        'imiento.Propietario, Lineas.Precio, Lineas.Descuento'
      '       FROM ( SELECT Ejercicio, NroOperacion, Precio, Descuento'
      '              FROM LineaMovimiento'
      '              WHERE LineaMovimiento.CodigoArticulo='#39'C1058'#39' AND'
      '                    ( LineaMovimiento.CodigoClaseA='#39'T1'#39') AND'
      
        '                    ( LineaMovimiento.CodigoClaseB IS NULL OR Li' +
        'neaMovimiento.CodigoClaseB='#39#39' ) AND'
      
        '                    ( LineaMovimiento.CodigoClaseC IS NULL OR Li' +
        'neaMovimiento.CodigoClaseC='#39#39' )'
      
        '                    ORDER BY Fecha DESC, NroOperacion DESC ) AS ' +
        'Lineas LEFT JOIN Movimiento ON ( Lineas.Ejercicio=Movimiento.Eje' +
        'rcicio AND Lineas.NroOperacion=Movimiento.NroOperacion )'
      '              WHERE Movimiento.TipoMovimiento=10 AND'
      '                    Movimiento.Fecha>=DATE '#39'2009-04-25'#39' AND'
      
        '                    ( Movimiento.FechaAplicacion IS NULL OR Movi' +
        'miento.FechaAplicacion<=DATE '#39'2009-04-25'#39' ) ) AS Oferta'
      '                    WHERE Oferta.Propietario='#39'01022'#39)
    Left = 222
    Top = 200
    object PrecioOfertaQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object PrecioOfertaQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object DmArticulosRelacionadosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ArticulosRelacionados'
    IndexFieldNames = 'Codigo;Tipo;NroOrden'
    Left = 74
    Top = 396
  end
end
