object ArticuloModule: TArticuloModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 715
  Width = 608
  PixelsPerInch = 120
  object DmArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'Codigo'
    Left = 93
    Top = 30
  end
  object DmTarifaComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaCompras'
    IndexFieldNames = 'Tipo;CodigoProveedor;CodigoArticulo'
    Left = 253
    Top = 38
  end
  object DmTarifaVentasTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaVentas'
    IndexFieldNames = 'Tipo;CodigoTarifa;CodigoArticulo'
    Left = 253
    Top = 118
  end
  object DmListaMaterialesTable: TnxeTable
    Timeout = 6000
    TableName = 'ListaMateriales'
    IndexFieldNames = 'CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroLinea'
    Left = 440
    Top = 38
  end
  object DmArticuloDatEconTable: TnxeTable
    Timeout = 6000
    TableName = 'ArticuloDatEcon'
    IndexFieldNames = 
      'Ejercicio;Codigo;CodigoClaseA;CodigoClaseB;CodigoClaseC;CodigoAl' +
      'macen'
    Left = 440
    Top = 110
  end
  object DmTarifaClaseTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaClase'
    IndexFieldNames = 'Seccion;CodigoPropietario;CodigoArticulo;ClaseA;ClaseB;ClaseC'
    Left = 253
    Top = 198
  end
  object DmTablaComisionTable: TnxeTable
    Timeout = 6000
    TableName = 'TablaComision'
    IndexFieldNames = 'Relacion;CodigoVendedor;CodigoCliente;CodigoArticulo'
    Left = 253
    Top = 278
  end
  object DmTarifaCantidadVentaTable: TnxeTable
    Timeout = 6000
    TableName = 'TarifaCantidadVenta'
    IndexFieldNames = 
      'CodigoCliente;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoCla' +
      'seC;CantidadMinima'
    Left = 253
    Top = 360
  end
  object DmCodigoBarrasTable: TnxeTable
    Timeout = 6000
    TableName = 'CodigoBarras'
    IndexFieldNames = 'CodigoBarras'
    Left = 440
    Top = 185
  end
  object PrecioOfertaQuery: TnxeQuery
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
    Left = 438
    Top = 363
    object PrecioOfertaQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
    object PrecioOfertaQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
  end
  object DmClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'Cliente'
    IndexFieldNames = 'Codigo'
    Left = 90
    Top = 110
  end
  object DmProveedorTable: TnxeTable
    Timeout = 6000
    TableName = 'Proveedor'
    IndexFieldNames = 'Codigo'
    Left = 90
    Top = 198
  end
  object DmArticuloAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Articulo'
    IndexFieldNames = 'CodigoBarras'
    Left = 438
    Top = 265
  end
  object DmClasesArticuloTable: TnxeTable
    Timeout = 6000
    TableName = 'ClasesArticulo'
    IndexFieldNames = 'CodigoArticulo;NroClase;CodigoClase'
    Left = 250
    Top = 524
  end
  object DmClaseTable: TnxeTable
    Timeout = 6000
    TableName = 'Clase'
    IndexFieldNames = 'NroClase;NroOrden'
    Left = 253
    Top = 445
  end
end
