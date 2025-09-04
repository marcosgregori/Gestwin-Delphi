object MovimientoModule: TMovimientoModule
  Tag = 1
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 974
  Width = 714
  PixelsPerInch = 120
  object DmMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 105
    Top = 58
  end
  object DmLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 105
    Top = 234
  end
  object DmMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 310
    Top = 58
  end
  object DmLineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 310
    Top = 234
  end
  object DmReport: TgxReportManager
    FileName = ' '
    HideReportList = False
    SQLItems = <>
    ToPrinter = False
    OnSelectPrinter = DmReportSelectPrinter
    OnSetReportName = DmReportSetReportName
    Left = 95
    Top = 810
  end
  object DmConsumosClienteTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'ConsumosCliente'
    IndexFieldNames = 'CodigoCliente;NroOrden'
    AutoIncFieldName = 'NroLinea'
    MasterRelation = mrTied
    Left = 310
    Top = 333
  end
  object DmGrupoLineaMovimientoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 105
    Top = 151
  end
  object GrupoLineaMovimientoAuxTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 310
    Top = 151
  end
  object DmMovimientoQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    Left = 310
    Top = 523
  end
  object DesplazaPaginaDocumentoStoredProc: TnxeStoredProc
    Database = EnterpriseDataModule.UserDatabase
    StoredProcName = 'DesplazaPaginaDocumento'
    Left = 524
    Top = 58
    ParamData = <
      item
        DataType = ftSmallint
        Name = '_Ejercicio'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = '_NroOperacion'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = '_NroPaginaOrigen'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = '_NroPaginaDestino'
        ParamType = ptInput
      end>
  end
  object InsertaPaginaDocumentoStoredProc: TnxeStoredProc
    Database = EnterpriseDataModule.UserDatabase
    StoredProcName = 'InsertaPaginaDocumento'
    Left = 524
    Top = 151
    ParamData = <
      item
        DataType = ftSmallint
        Name = '_Ejercicio'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = '_NroOperacion'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = '_NroPagina'
        ParamType = ptInput
      end>
  end
  object ExistenciasLoteQuery: TnxeQuery
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 180000
    ReadOnly = True
    SQL.Strings = (
      '')
    Left = 524
    Top = 423
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
  object DmMovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 105
    Top = 333
  end
  object DmLineaMovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 105
    Top = 523
  end
  object DmGrupoLineaMovimientoDestinoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 105
    Top = 423
  end
  object DmRelacionDocumentosTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'RelacionDocumentos'
    IndexFieldNames = 'Tipo;Ejercicio;NroOperacion'
    AutoIncFieldName = 'NroLinea'
    Left = 310
    Top = 423
  end
  object ListadoSQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT'#13#10#13#10'DocumentoyLineas.*,'#13#10'  '#13#10'CAST( '#39#39' AS NVARCHAR(80) ) AS' +
          ' EstadoDocumento,  '#13#10'CAST( 0.0 AS BCD(16,4) ) AS Pendiente,'#13#10'CAS' +
          'T( 0.0 AS BCD(16,4) ) AS ImportePendiente,    '#13#10'CAST( 0.0 AS BCD' +
          '(16,4) ) AS StockActual,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS EnvasesDep' +
          'osito,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS ContenedoresDeposito,    '#13#10'C' +
          'AST( 0.0 AS BCD(16,4)  ) AS Coste,'#13#10'CAST( 0.0 AS BCD(16,4) ) AS ' +
          'Margen,'#13#10#13#10'False AS RegistroProcesado'#13#10'                         ' +
          '                   '#13#10'<Campos>'#13#10'INTO <TableName>                 ' +
          '                  '#13#10'FROM ( SELECT Documento.*,'#13#10'       <ListaCam' +
          'posLineas>'#13#10'       FROM ( <SelectMovimientos> ) AS Documento'#13#10#9' ' +
          '  <LineasTabla> ) AS DocumentoyLineas'#13#10'       <Tablas>'#13#10'<WhereEx' +
          'terno>                            '#13#10'ORDER BY <Ordenacion>'#13#10'  '#13#10
      end
      item
        Title = 'Rejilla'
        SQLText = 
          'SELECT SYSTEM_ROW# AS NroRegistro,'#13#10'       Ejercicio,'#13#10'       Nr' +
          'oOperacion,                                   '#13#10'       Serie, '#13#10 +
          '       NroDocumento, '#13#10'       Fecha,                  '#13#10'       P' +
          'ropietario,'#13#10'       DescripcionMovimiento                       ' +
          '                            '#13#10'       <Campos>'#13#10'INTO <NombreTabla' +
          '>                                                               ' +
          '                                                                ' +
          '                '#13#10'FROM Movimiento                              '#13 +
          #10'<Tablas>                '#13#10'WHERE <Seleccion>      '#13#10'ORDER BY <Or' +
          'denacion>;'#13#10#13#10'CREATE UNIQUE INDEX Index0 ON <NombreTabla>( NroRe' +
          'gistro );    '#13#10'  '#13#10
      end
      item
        Title = 'ListaCamposMovimiento'
        SQLText = 
          'Movimiento.Ejercicio,   '#13#10'Movimiento.NroOperacion,    '#13#10'Movimien' +
          'to.TipoMovimiento,   '#13#10'Movimiento.Propietario,   '#13#10'Movimiento.Se' +
          'rie,   '#13#10'Movimiento.NroDocumento,    '#13#10'Movimiento.Fecha,   '#13#10'Mov' +
          'imiento.FechaEmision,'#13#10'Movimiento.FechaAuxiliar,'#13#10'Movimiento.Des' +
          'cripcionMovimiento,    '#13#10'Movimiento.GrupoFacturacion,   '#13#10'Movimi' +
          'ento.RegistroAuxiliar,   '#13#10'Movimiento.CodigoVendedor,   '#13#10'Movimi' +
          'ento.CodigoOperario,   '#13#10'Movimiento.CentroCoste,   '#13#10'Movimiento.' +
          'FormaEnvio,   '#13#10'Movimiento.EjercicioFactura,   '#13#10'Movimiento.Prop' +
          'ietarioFactura,   '#13#10'Movimiento.SerieFactura,   '#13#10'Movimiento.NroF' +
          'actura,   '#13#10'Movimiento.NoFacturar,   '#13#10'Movimiento.Facturado,   '#13 +
          #10'Movimiento.Traspasado,   '#13#10'Movimiento.Origen,   '#13#10'Movimiento.Ej' +
          'ercicioOrigen,   '#13#10'Movimiento.NroOperacionOrigen,   '#13#10'Movimiento' +
          '.NroDocumentoPropietario,   '#13#10'Movimiento.EntregaACuenta,   '#13#10'Mov' +
          'imiento.EntregaEfectivo,   '#13#10'Movimiento.CodigoTransportista,   '#13 +
          #10'Movimiento.Portes,'#13#10'Movimiento.CodigoFormaCobro,'#13#10'Movimiento.Or' +
          'ganismoPublico, '#13#10'Movimiento.Situacion,'#13#10'Movimiento.CampoLibre1,' +
          #13#10'Movimiento.CampoLibre2,'#13#10'Movimiento.CampoLibre3,'#13#10'Movimiento.C' +
          'ampoLibre4,'#13#10'Movimiento.CampoLibre5,    '#13#10'Movimiento.Creado,'#13#10'Mo' +
          'vimiento.Revisado,'#13#10'Movimiento.Anotacion  '#13#10
      end
      item
        Title = 'ListaCamposLineas'
        SQLText = 
          'LineaMovimiento.FechaAplicacion AS FechaAplicacion,   '#13#10'LineaMov' +
          'imiento.NroPagina, '#13#10'LineaMovimiento.NroLinea, '#13#10'LineaMovimiento' +
          '.NroRegistro, '#13#10'LineaMovimiento.CodigoArticulo, '#13#10'LineaMovimient' +
          'o.CodigoClaseA, '#13#10'LineaMovimiento.CodigoClaseB, '#13#10'LineaMovimient' +
          'o.CodigoClaseC, '#13#10'LineaMovimiento.LoteFabricacion,'#13#10'LineaMovimie' +
          'nto.NumeroSerie,'#13#10'LineaMovimiento.CampoLibre1,'#13#10'LineaMovimiento.' +
          'CampoLibre2,'#13#10'LineaMovimiento.CampoLibre3,'#13#10'LineaMovimiento.Camp' +
          'oLibre4,    '#13#10'LineaMovimiento.Descripcion,         '#13#10'LineaMovimi' +
          'ento.CodigoAlmacen,'#13#10'LineaMovimiento.Ubicacion, '#13#10'LineaMovimient' +
          'o.Cantidad, '#13#10'LineaMovimiento.CantidadAjustada,'#13#10'LineaMovimiento' +
          '.CantidadProcesada,'#13#10'LineaMovimiento.Procesada,'#13#10'LineaMovimiento' +
          '.PrecioDivisa,'#13#10'LineaMovimiento.Precio,'#13#10'LineaMovimiento.Recargo' +
          ','#13#10'LineaMovimiento.PuntoVerde,'#13#10'LineaMovimiento.Descuento,'#13#10'Line' +
          'aMovimiento.NroCajas,'#13#10'LineaMovimiento.Largo,'#13#10'LineaMovimiento.A' +
          'ncho,'#13#10'LineaMovimiento.Alto,'#13#10'LineaMovimiento.Bultos,'#13#10'LineaMovi' +
          'miento.NoCalcularMargen,'#13#10'LineaMovimiento.TipoLinea,'#13#10'LineaMovim' +
          'iento.Oferta,'#13#10'LineaMovimiento.PesoEnvase,'#13#10'LineaMovimiento.Tara' +
          ','#13#10'LineaMovimiento.Peso,'#13#10'LineaMovimiento.ImporteBruto,'#13#10'LineaMo' +
          'vimiento.ImporteDescuento,'#13#10'LineaMovimiento.ImporteNeto,'#13#10'LineaM' +
          'ovimiento.CodigoTipoIVA,'#13#10'LineaMovimiento.CuotaIVA,'#13#10'LineaMovimi' +
          'ento.CuotaRE,'#13#10'LineaMovimiento.PrecioIVA,'#13#10'LineaMovimiento.Impor' +
          'teTotal,'#13#10'LineaMovimiento.Parametros,'#13#10'LineaMovimiento.Anotacion' +
          '                                                    '#13#10'  '#13#10
      end>
    Left = 310
    Top = 810
  end
  object ImpresosSQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Consulta'
        SQLText = 
          'SELECT'#13#10'        '#13#10'      Documento.*,'#13#10#13#10'      Documento.NroOpera' +
          'cion AS Nro_Operacion,'#13#10'      CAST( 0 AS SMALLINT ) AS NroCopia ' +
          ','#13#10'      Documento.Propietario AS CodigoPropietario,'#13#10'      Docu' +
          'mento.Fecha AS FechaDocumento,'#13#10'      Documento.FechaAplicacion ' +
          'AS Fecha1,'#13#10'      Documento.FechaEmision AS Fecha2,'#13#10'      Docum' +
          'ento.NroDocumentoPropietario AS NroDocPropietario,'#13#10'      Docume' +
          'nto.RegistroAuxiliar AS CodigoRegAuxiliar,'#13#10'      Documento.Grup' +
          'oFacturacion AS CodigoGrupo,'#13#10'      Documento.CodigoFormaCobro A' +
          'S CodigoFormaPago,                                              ' +
          '                                                          '#13#10'    ' +
          '  CAST( '#39#39' AS NVARCHAR(12) ) AS OrganismoPublico,'#13#10'      CAST( '#39 +
          #39' AS NVARCHAR(20) ) AS NumeroExpediente,'#13#10'      CAST( '#39#39' AS NVAR' +
          'CHAR(20) ) AS NumeroContrato,'#13#10'      False AS ServicioPrestadoTe' +
          'mporalmente,'#13#10'      CURRENT_DATE AS InicioPeriodoFacturacion,'#13#10' ' +
          '     CURRENT_DATE AS FinPeriodoFacturacion,'#13#10'      CAST( '#39#39' AS N' +
          'VARCHAR(3) ) AS CodigoDivisa,'#13#10'      CAST( '#39#39' AS NVARCHAR(30) ) ' +
          'AS DescripcionDivisa,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TipoCam' +
          'bio,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS PrecisionDivisa,'#13#10'      ' +
          'CAST( 0.0 AS BCD(16,4) ) AS DescuentoPP,'#13#10'      CAST( 0.0 AS BCD' +
          '(16,4) ) AS ImporteDtoPP,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Des' +
          'cuentoES,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteDtoES,'#13#10'    ' +
          '  CAST( 0.0 AS BCD(16,4) ) AS CosteArticulos,'#13#10'      CAST( 0.0 A' +
          'S BCD(16,4) ) AS BrutoArticulos,'#13#10'      CAST( 0.0 AS BCD(16,4) )' +
          ' AS DescuentoArticulos,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Descu' +
          'entoPropietario,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImportePunto' +
          'Verde,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TotalContribucionRAP, ' +
          '         '#13#10'      CAST( 0.0 AS BCD(16,4) ) AS NetoArticulos,'#13#10'   ' +
          '   CAST( 0.0 AS BCD(16,4) ) AS ImporteNeto,'#13#10'      CAST( 0.0 AS ' +
          'BCD(16,4) ) AS CuotaIVA,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Cuot' +
          'aRE,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteComision,'#13#10'      ' +
          'CAST( 0.0 AS BCD(16,4) ) AS PrimerTipoIVA,'#13#10'      CAST( 0.0 AS B' +
          'CD(16,4) ) AS PrimerTipoRE,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS E' +
          'ntregaACuenta,          '#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Tota' +
          'lACuenta,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TotalACuentaPedidos' +
          ','#13#10'      CAST( '#39#39' AS NVARCHAR(2) ) AS CodigoFormaPago,'#13#10'      CA' +
          'ST( '#39#39' AS NVARCHAR(30) ) AS DescripcionFormaPago,'#13#10'      CAST( '#39 +
          #39' AS NVARCHAR(11) ) AS BIC,'#13#10'      CAST( '#39#39' AS NVARCHAR(34) ) AS' +
          ' IBAN,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS BaseImponible1,'#13#10'     ' +
          ' CAST( 0.0 AS BCD(16,4) ) AS BaseImponible2,'#13#10'      CAST( 0.0 AS' +
          ' BCD(16,4) ) AS BaseImponible3,'#13#10'      CAST( 0.0 AS BCD(16,4) ) ' +
          'AS BaseImponible4,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS BaseImponi' +
          'ble5,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS BaseImponible6,'#13#10'      ' +
          'CAST( 0.0 AS BCD(16,4) ) AS TipoIVA1,'#13#10'      CAST( 0.0 AS BCD(16' +
          ',4) ) AS TipoIVA2,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TipoIVA3,'#13 +
          #10'      CAST( 0.0 AS BCD(16,4) ) AS TipoIVA4,'#13#10'      CAST( 0.0 AS' +
          ' BCD(16,4) ) AS TipoIVA5,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Tip' +
          'oIVA6,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS CuotaIVA1,'#13#10'      CAST' +
          '( 0.0 AS BCD(16,4) ) AS CuotaIVA2,'#13#10'      CAST( 0.0 AS BCD(16,4)' +
          ' ) AS CuotaIVA3,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS CuotaIVA4,'#13#10 +
          '      CAST( 0.0 AS BCD(16,4) ) AS CuotaIVA5,'#13#10'      CAST( 0.0 AS' +
          ' BCD(16,4) ) AS CuotaIVA6,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Ti' +
          'poRE1,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TipoRE2,'#13#10'      CAST( ' +
          '0.0 AS BCD(16,4) ) AS TipoRE3,'#13#10'      CAST( 0.0 AS BCD(16,4) ) A' +
          'S TipoRE4,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS TipoRE5,'#13#10'      CA' +
          'ST( 0.0 AS BCD(16,4) ) AS TipoRE6,'#13#10'      CAST( 0.0 AS BCD(16,4)' +
          ' ) AS CuotaRE1,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS CuotaRE2,'#13#10'  ' +
          '    CAST( 0.0 AS BCD(16,4) ) AS CuotaRE3,'#13#10'      CAST( 0.0 AS BC' +
          'D(16,4) ) AS CuotaRE4,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS CuotaR' +
          'E5,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS CuotaRE6,'#13#10'      CAST( 0.' +
          '0 AS BCD(16,4) ) AS ImporteTotal1,'#13#10'      CAST( 0.0 AS BCD(16,4)' +
          ' ) AS ImporteTotal2,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteT' +
          'otal3,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteTotal4,'#13#10'      ' +
          'CAST( 0.0 AS BCD(16,4) ) AS ImporteTotal5,'#13#10'      CAST( 0.0 AS B' +
          'CD(16,4) ) AS ImporteTotal6,'#13#10'      CAST( 0 AS SMALLINT ) AS Tip' +
          'oRetencion,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS BaseCalculoRetenc' +
          'ion,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteRetencion,'#13#10'     ' +
          ' CAST( 0.0 AS BCD(16,4) ) AS ImporteTotal,'#13#10'      CURRENT_DATE A' +
          'S FechaVencimiento1,'#13#10'      CURRENT_DATE AS FechaVencimiento2,'#13#10 +
          '      CURRENT_DATE AS FechaVencimiento3,'#13#10'      CURRENT_DATE AS ' +
          'FechaVencimiento4,'#13#10'      CURRENT_DATE AS FechaVencimiento5,'#13#10'  ' +
          '    CURRENT_DATE AS FechaVencimiento6,'#13#10'      CAST( 0.0 AS BCD(1' +
          '6,4) ) AS ImporteVencimiento1,'#13#10'      CAST( 0.0 AS BCD(16,4) ) A' +
          'S ImporteVencimiento2,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Import' +
          'eVencimiento3,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteVencimi' +
          'ento4,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS ImporteVencimiento5,'#13#10 +
          '      CAST( 0.0 AS BCD(16,4) ) AS ImporteVencimiento6,'#13#10'      CA' +
          'ST( 0.0 AS BCD(16,4) ) AS SumaIVAyRE,'#13#10'      CAST( 0.0 AS BCD(16' +
          ',4) ) AS SumaBultos,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS SumaKilo' +
          's,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS SumaVolumen,'#13#10'      CAST( ' +
          '0.0 AS BCD(16,4) ) AS SumaCajas,'#13#10'      CAST( 0.0 AS BCD(16,4) )' +
          ' AS SumaPallets,'#13#10'      CAST( '#39#39' AS NVARCHAR(128) ) AS ImporteCi' +
          'fra,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS PorcentajeRetencion,'#13#10'  ' +
          '    CAST( 0.0 AS BCD(16,4) ) AS Portes,'#13#10'      CAST( 0.0 AS BCD(' +
          '16,4) ) AS CuotaIVAPortes,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS Cu' +
          'otaREPortes,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS PorcentajeRecFin' +
          'anc,'#13#10'      CAST( 0.0 AS BCD(16,4) ) AS RecargoFinanciero,'#13#10#13#10'  ' +
          '    CAST( '#39#39' AS NVARCHAR(3) ) AS CodigoEmpresa,'#13#10'      CAST( 0.0' +
          ' AS BCD(16,4) ) AS TotalEntrega,  '#13#10#13#10'      False AS RegistroPro' +
          'cesado'#13#10'  '#13#10'      <Campos>'#13#10#13#10'<Into>          '#13#10'  '#13#10'FROM  ( <Sel' +
          'ectMovimientos> ) AS Documento'#13#10'<Tablas>'#13#10'<WhereExterno>'#13#10'ORDER ' +
          'BY <Ordenacion>;'#13#10'  '#13#10
      end
      item
        Title = 'ListaCamposMovimiento'
        SQLText = 'Movimiento.*'#13#10'  '#13#10
      end>
    Left = 524
    Top = 810
  end
  object DmMovimientoImpresoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'Movimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion'
    Left = 90
    Top = 685
  end
  object DmGrupoLineaMovimientoImpresoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'GrupoLineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina'
    Left = 310
    Top = 685
  end
  object DmLineaMovimientoImpresoTable: TnxeTable
    ActiveRuntime = True
    Database = EnterpriseDataModule.UserDatabase
    Timeout = 6000
    TableName = 'LineaMovimiento'
    IndexFieldNames = 'Ejercicio;NroOperacion;NroPagina;NroLinea'
    Left = 525
    Top = 685
  end
end
