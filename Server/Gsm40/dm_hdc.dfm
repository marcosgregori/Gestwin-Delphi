object HojaCargaModule: THojaCargaModule
  Tag = 1
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 506
  Width = 482
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 61
    Top = 98
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 61
    Top = 34
  end
  object DmLineaHojaCargaTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja;NroLinea'
    Left = 227
    Top = 98
  end
  object DmHojaCargaTable: TnxeTable
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 227
    Top = 34
  end
  object HojaCargaQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      ''
      
        '/* La consulta SQL que se utiliza est'#225' en el SQLSet, '#233'sta solo s' +
        'irve para obtener los campos */'
      ''
      'SELECT LineaHojaCarga.*,'
      '       HojaCarga.Fecha,'
      '       HojaCarga.CodigoTransportista,'
      '       HojaCarga.NroOperacionReubicacion,'
      '       HojaCarga.Procesado,'
      '       Movimiento.Propietario,'
      '       Movimiento.CodigoVendedor,'
      '       Movimiento.GrupoFacturacion,'
      '       Movimiento.CodigoFormaCobro,'
      '       LineaMovimiento.NroRegistro,'
      '       LineaMovimiento.CodigoArticulo,'
      '       LineaMovimiento.CodigoClaseA,'
      '       LineaMovimiento.CodigoClaseB,'
      '       LineaMovimiento.CodigoClaseC,'
      '       LineaMovimiento.UIDArticulo,'
      '       LineaMovimiento.NumeroSerie,'
      '       LineaMovimiento.LoteFabricacion,'
      '       LineaMovimiento.Descripcion,'
      '       LineaMovimiento.NroCajas,'
      '       LineaMovimiento.Precio,'
      '       LineaMovimiento.Descuento'
      'FROM LineaHojaCarga'
      
        '     LEFT JOIN HojaCarga ON ( HojaCarga.Ejercicio=LineaHojaCarga' +
        '.Ejercicio AND HojaCarga.NroHoja=LineaHojaCarga.NroHoja )'
      
        '     LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=LineaHojaCar' +
        'ga.EjercicioOrigen AND Movimiento.NroOperacion=LineaHojaCarga.Nr' +
        'oOperacionOrigen )'
      
        '     LEFT JOIN LineaMovimiento ON ( LineaMovimiento.NroRegistro=' +
        'LineaHojaCarga.NroRegistroOrigen )'
      'WHERE NOT HojaCarga.NoProcesar'
      
        'ORDER BY Movimiento.Propietario, HojaCarga.Fecha, LineaHojaCarga' +
        '.NroHoja, LineaHojaCarga.NroLinea')
    Left = 368
    Top = 34
    object HojaCargaQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object HojaCargaQueryNroHoja: TIntegerField
      FieldName = 'NroHoja'
    end
    object HojaCargaQueryProcesado: TBooleanField
      FieldName = 'Procesado'
    end
    object HojaCargaQueryCodigoTransportista: TWideStringField
      FieldName = 'CodigoTransportista'
      Size = 2
    end
    object HojaCargaQueryCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object HojaCargaQueryGrupoFacturacion: TWideStringField
      FieldName = 'GrupoFacturacion'
      Size = 3
    end
    object HojaCargaQueryCodigoFormaCobro: TWideStringField
      FieldName = 'CodigoFormaCobro'
      Size = 2
    end
    object HojaCargaQueryNroLinea: TSmallintField
      FieldName = 'NroLinea'
    end
    object HojaCargaQueryEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object HojaCargaQueryNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object HojaCargaQueryNroRegistroOrigen: TIntegerField
      FieldName = 'NroRegistroOrigen'
    end
    object HojaCargaQueryNroOperacionReubicacion: TIntegerField
      FieldName = 'NroOperacionReubicacion'
    end
    object HojaCargaQueryNroRegistro: TLongWordField
      FieldName = 'NroRegistro'
    end
    object HojaCargaQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object HojaCargaQueryCargado: TBCDField
      FieldName = 'Cargado'
    end
    object HojaCargaQueryNroOperacionDestino: TIntegerField
      FieldName = 'NroOperacionDestino'
    end
    object HojaCargaQueryAnotacion: TWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object HojaCargaQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object HojaCargaQueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object HojaCargaQueryCodigoArticulo: TWideStringField
      FieldName = 'CodigoArticulo'
    end
    object HojaCargaQueryCodigoClaseA: TWideStringField
      FieldName = 'CodigoClaseA'
      Size = 3
    end
    object HojaCargaQueryCodigoClaseB: TWideStringField
      FieldName = 'CodigoClaseB'
      Size = 3
    end
    object HojaCargaQueryCodigoClaseC: TWideStringField
      FieldName = 'CodigoClaseC'
      Size = 3
    end
    object HojaCargaQueryUIDArticulo: TGuidField
      FieldName = 'UIDArticulo'
      Size = 38
    end
    object HojaCargaQueryNumeroSerie: TWideStringField
      FieldName = 'NumeroSerie'
    end
    object HojaCargaQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object HojaCargaQueryDescripcion: TWideStringField
      FieldName = 'Descripcion'
      Size = 60
    end
    object HojaCargaQueryEjercicioDestino: TSmallintField
      FieldName = 'EjercicioDestino'
    end
    object HojaCargaQueryNroRegistroDestino: TIntegerField
      FieldName = 'NroRegistroDestino'
    end
    object HojaCargaQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
    object HojaCargaQueryNroCajas: TBCDField
      FieldName = 'NroCajas'
    end
    object HojaCargaQueryDescuento: TBCDField
      FieldName = 'Descuento'
    end
    object HojaCargaQueryPrecio: TFloatField
      FieldName = 'Precio'
    end
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Seleccion'
        SQLText = 
          'SELECT LineaHojaCarga.*,'#13#10'       HojaCarga.Fecha,'#13#10'       HojaCa' +
          'rga.NroOperacionReubicacion,'#13#10'       HojaCarga.Procesado,'#13#10'     ' +
          '  HojaCarga.CodigoTransportista,    '#13#10'       Movimiento.Propieta' +
          'rio,'#13#10'       Movimiento.CodigoVendedor,'#13#10'       Movimiento.Grupo' +
          'Facturacion,'#13#10'       Movimiento.CodigoFormaCobro,    '#13#10'       Li' +
          'neaMovimiento.NroRegistro,'#13#10'       LineaMovimiento.CodigoArticul' +
          'o,'#13#10'       LineaMovimiento.CodigoClaseA,'#13#10'       LineaMovimiento' +
          '.CodigoClaseB,'#13#10'       LineaMovimiento.CodigoClaseC,'#13#10'       Lin' +
          'eaMovimiento.UIDArticulo,'#13#10'       LineaMovimiento.NumeroSerie,'#13#10 +
          '       LineaMovimiento.LoteFabricacion,'#13#10'       LineaMovimiento.' +
          'Descripcion,'#13#10'       LineaMovimiento.Precio,'#13#10'       LineaMovimi' +
          'ento.Descuento'#13#10'FROM   LineaHojaCarga'#13#10'       LEFT JOIN HojaCarg' +
          'a ON ( HojaCarga.Ejercicio=LineaHojaCarga.Ejercicio AND HojaCarg' +
          'a.NroHoja=LineaHojaCarga.NroHoja )'#13#10'       LEFT JOIN Movimiento ' +
          'ON ( Movimiento.Ejercicio=LineaHojaCarga.EjercicioOrigen AND Mov' +
          'imiento.NroOperacion=LineaHojaCarga.NroOperacionOrigen )'#13#10'      ' +
          ' LEFT JOIN LineaMovimiento ON ( LineaMovimiento.NroRegistro=Line' +
          'aHojaCarga.NroRegistroOrigen )'#13#10'WHERE  NOT HojaCarga.NoProcesar ' +
          'AND <Seleccion>'#13#10'ORDER  BY Movimiento.Propietario, HojaCarga.Fec' +
          'ha, LineaHojaCarga.NroHoja, LineaHojaCarga.NroLinea'#13#10'  '#13#10
      end>
    Left = 371
    Top = 98
  end
  object DmHojaCargaAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'HojaCarga'
    IndexFieldNames = 'Ejercicio;NroHoja'
    Left = 227
    Top = 155
  end
  object DmLineaHojaCargaOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'NroRegistroOrigen'
    Left = 227
    Top = 224
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen'
    Left = 61
    Top = 224
  end
  object DmMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 61
    Top = 155
  end
  object DmLineaHojaCargaRegistroOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'NroRegistroOrigen'
    Left = 226
    Top = 295
  end
  object DmLineaHojaCargaRegistroDestinoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaHojaCarga'
    IndexFieldNames = 'NroRegistroDestino'
    Left = 225
    Top = 362
  end
end
