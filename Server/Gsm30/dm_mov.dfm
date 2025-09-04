object MovimientoModule: TMovimientoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 850
  Width = 1167
  PixelsPerInch = 120
  object DmMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 418
    Top = 70
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 418
    Top = 237
  end
  object DmConsumosClienteTable: TnxeTable
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 418
    Top = 335
  end
  object GrupoLineaMovimientoAuxTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 418
    Top = 154
  end
  object DmMovimientoQuery: TnxeQuery
    Timeout = 180000
    SQL.Strings = (
      'SELECT *'
      'FROM Movimiento'
      'WHERE 0>0')
    Left = 695
    Top = 425
    object DmMovimientoQueryEjercicio: TSmallintField
      FieldName = 'Ejercicio'
    end
    object DmMovimientoQueryNroOperacion: TIntegerField
      FieldName = 'NroOperacion'
    end
    object DmMovimientoQueryTipoMovimiento: TSmallintField
      FieldName = 'TipoMovimiento'
    end
    object DmMovimientoQueryPropietario: TWideStringField
      FieldName = 'Propietario'
      Size = 5
    end
    object DmMovimientoQuerySerie: TWideStringField
      FieldName = 'Serie'
      Size = 2
    end
    object DmMovimientoQueryNroDocumento: TIntegerField
      FieldName = 'NroDocumento'
    end
    object DmMovimientoQueryUUID: TGuidField
      FieldName = 'UUID'
      Size = 38
    end
    object DmMovimientoQueryFecha: TDateField
      FieldName = 'Fecha'
    end
    object DmMovimientoQueryFechaAplicacion: TDateField
      FieldName = 'FechaAplicacion'
    end
    object DmMovimientoQueryFechaEmision: TDateField
      FieldName = 'FechaEmision'
    end
    object DmMovimientoQueryFechaAuxiliar: TDateField
      FieldName = 'FechaAuxiliar'
    end
    object DmMovimientoQueryGrupoFacturacion: TWideStringField
      FieldName = 'GrupoFacturacion'
      Size = 3
    end
    object DmMovimientoQueryRegistroAuxiliar: TWideStringField
      FieldName = 'RegistroAuxiliar'
      Size = 3
    end
    object DmMovimientoQueryCodigoVendedor: TWideStringField
      FieldName = 'CodigoVendedor'
      Size = 2
    end
    object DmMovimientoQueryCodigoOperario: TWideStringField
      FieldName = 'CodigoOperario'
      Size = 5
    end
    object DmMovimientoQueryCentroCoste: TWideStringField
      FieldName = 'CentroCoste'
      Size = 4
    end
    object DmMovimientoQueryFormaEnvio: TWideStringField
      FieldName = 'FormaEnvio'
      Size = 2
    end
    object DmMovimientoQueryEjercicioFactura: TSmallintField
      FieldName = 'EjercicioFactura'
    end
    object DmMovimientoQueryPropietarioFactura: TWideStringField
      FieldName = 'PropietarioFactura'
      Size = 5
    end
    object DmMovimientoQuerySerieFactura: TWideStringField
      FieldName = 'SerieFactura'
      Size = 40
    end
    object DmMovimientoQueryNroFactura: TIntegerField
      FieldName = 'NroFactura'
    end
    object DmMovimientoQueryNoFacturar: TBooleanField
      FieldName = 'NoFacturar'
    end
    object DmMovimientoQueryFacturado: TBooleanField
      FieldName = 'Facturado'
    end
    object DmMovimientoQueryTraspasado: TBooleanField
      FieldName = 'Traspasado'
    end
    object DmMovimientoQueryAnulado: TBooleanField
      FieldName = 'Anulado'
    end
    object DmMovimientoQueryOpcion: TSmallintField
      FieldName = 'Opcion'
    end
    object DmMovimientoQueryOrigen: TSmallintField
      FieldName = 'Origen'
    end
    object DmMovimientoQueryEjercicioOrigen: TSmallintField
      FieldName = 'EjercicioOrigen'
    end
    object DmMovimientoQueryNroOperacionOrigen: TIntegerField
      FieldName = 'NroOperacionOrigen'
    end
    object DmMovimientoQueryNroDocumentoPropietario: TWideStringField
      FieldName = 'NroDocumentoPropietario'
      Size = 15
    end
    object DmMovimientoQueryEntregaACuenta: TBCDField
      FieldName = 'EntregaACuenta'
      Precision = 16
    end
    object DmMovimientoQueryEntregaEfectivo: TBCDField
      FieldName = 'EntregaEfectivo'
      Precision = 16
    end
    object DmMovimientoQueryCodigoTransportista: TWideStringField
      FieldName = 'CodigoTransportista'
      Size = 2
    end
    object DmMovimientoQueryIVAIncluido: TBooleanField
      FieldName = 'IVAIncluido'
    end
    object DmMovimientoQueryPortes: TBCDField
      FieldName = 'Portes'
      Precision = 16
    end
    object DmMovimientoQueryCodigoFormaCobro: TWideStringField
      FieldName = 'CodigoFormaCobro'
      Size = 2
    end
    object DmMovimientoQueryOrganismoPublico: TWideStringField
      FieldName = 'OrganismoPublico'
      Size = 12
    end
    object DmMovimientoQuerySituacion: TSmallintField
      FieldName = 'Situacion'
    end
    object DmMovimientoQueryDescripcionMovimiento: TWideStringField
      FieldName = 'DescripcionMovimiento'
      Size = 60
    end
    object DmMovimientoQueryCampoLibre1: TWideStringField
      FieldName = 'CampoLibre1'
      Size = 40
    end
    object DmMovimientoQueryCampoLibre2: TWideStringField
      FieldName = 'CampoLibre2'
      Size = 40
    end
    object DmMovimientoQueryCampoLibre3: TWideStringField
      FieldName = 'CampoLibre3'
      Size = 40
    end
    object DmMovimientoQueryCampoLibre4: TWideStringField
      FieldName = 'CampoLibre4'
      Size = 40
    end
    object DmMovimientoQueryCampoLibre5: TWideStringField
      FieldName = 'CampoLibre5'
      Size = 40
    end
    object DmMovimientoQueryTipoVentaPeriodica: TSmallintField
      FieldName = 'TipoVentaPeriodica'
    end
    object DmMovimientoQueryCreado: TDateTimeField
      FieldName = 'Creado'
    end
    object DmMovimientoQueryRevisado: TBooleanField
      FieldName = 'Revisado'
    end
    object DmMovimientoQuerySuministrado: TBooleanField
      FieldName = 'Suministrado'
    end
    object DmMovimientoQueryFechaEnvioPorCorreo: TDateField
      FieldName = 'FechaEnvioPorCorreo'
    end
    object DmMovimientoQueryAnotacion: TnxWideMemoField
      FieldName = 'Anotacion'
      BlobType = ftWideMemo
    end
    object DmMovimientoQueryFirma: TnxGraphicField
      FieldName = 'Firma'
      BlobType = ftGraphic
    end
  end
  object ExistenciasLoteQuery: TnxeQuery
    Timeout = 180000
    ReadOnly = True
    SQL.Strings = (
      'SELECT TOP 1 LoteFabricacion, CodigoAlmacen, Ubicacion'
      'FROM   Stock'
      'WHERE  ( Ejercicio=:Ejercicio ) AND'
      '       ( CodigoArticulo=:CodigoArticulo) AND'
      '       ( LoteFabricacion<>'#39#39' ) AND'
      
        '       ( Apertura_Entradas + Enero_Entradas + Febrero_Entradas +' +
        ' Marzo_Entradas + Abril_Entradas + Mayo_Entradas + Junio_Entrada' +
        's + Julio_Entradas + Agosto_Entradas + Septiembre_Entradas + Oct' +
        'ubre_Entradas + Noviembre_Entradas +Diciembre_Entradas -'
      
        '         Apertura_Salidas - Enero_Salidas - Febrero_Salidas - Ma' +
        'rzo_Salidas - Abril_Salidas - Mayo_Salidas - Junio_Salidas - Jul' +
        'io_Salidas - Agosto_Salidas - Septiembre_Salidas - Octubre_Salid' +
        'as - Noviembre_Salidas - Diciembre_Salidas )>0.0;    ')
    Left = 693
    Top = 520
    ParamData = <
      item
        DataType = ftSmallint
        Name = 'Ejercicio'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'CodigoArticulo'
        ParamType = ptUnknown
      end>
    object ExistenciasLoteQueryLoteFabricacion: TWideStringField
      FieldName = 'LoteFabricacion'
    end
    object ExistenciasLoteQueryCodigoAlmacen: TWideStringField
      FieldName = 'CodigoAlmacen'
      Size = 2
    end
    object ExistenciasLoteQueryUbicacion: TWideStringField
      FieldName = 'Ubicacion'
      Size = 6
    end
  end
  object DmMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 140
    Top = 73
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    AutoIncFieldName = 'NroPagina'
    Left = 140
    Top = 152
  end
  object DmLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 140
    Top = 229
  end
  object DmMovimientoOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 138
    Top = 560
  end
  object DmLineaMovimientoOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 135
    Top = 745
  end
  object DmGrupoLineaMovimientoOrigenTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 138
    Top = 650
  end
  object DmFacturaComprasTable: TnxeTable
    Timeout = 6000
    TableName = 'FacturaCompras'
    IndexFieldNames = 'Ejercicio;Proveedor;SerieNroFactura'
    CreateIfAbsent = False
    Left = 413
    Top = 430
  end
  object DmMovimientoCheckTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'TipoMovimiento;Ejercicio;Serie;NroDocumento'
    Left = 648
    Top = 70
  end
  object DeMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 950
    Top = 70
  end
  object DeGrupoLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    AutoIncFieldName = 'NroPagina'
    Left = 948
    Top = 152
  end
  object DeLineaMovimientoTable: TnxeTable
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 948
    Top = 239
  end
end
