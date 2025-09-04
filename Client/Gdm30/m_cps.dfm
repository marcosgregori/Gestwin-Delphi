object CpsQueryModule: TCpsQueryModule
  OnInitialize = PersistentQueryModuleInitialize
  OnUpdate = PersistentQueryModuleUpdate
  Height = 216
  Width = 299
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'AcumuladoArticulo'
        SQLText = 
          'SELECT AcumuladoPendiente.*,'#13#10'       Almacen.Nombre AS NombreAlm' +
          'acen,                    '#13#10'       CAST( 0.0 AS BCD(16,4)  ) AS E' +
          'xistencias,'#13#10'       CAST( 0.0 AS BCD(16,4) ) AS ExistenciasVirtu' +
          'ales                                                            ' +
          '       '#13#10'FROM ( SELECT LineaMovimiento.CodigoAlmacen,'#13#10'         ' +
          '     LineaMovimiento.CodigoArticulo,'#13#10'              LineaMovimie' +
          'nto.Descripcion,'#13#10'              LineaMovimiento.CodigoClaseA,'#13#10' ' +
          '             LineaMovimiento.CodigoClaseB,'#13#10'              LineaM' +
          'ovimiento.CodigoClaseC,'#13#10'              LineaMovimiento.Parametro' +
          's,                  '#13#10'              SUM( LineaMovimiento.Cantida' +
          'd ) AS Cantidad,'#13#10'              SUM( CASE WHEN LineaMovimiento.P' +
          'rocesada THEN 0.0 ELSE LineaMovimiento.Cantidad - LineaMovimient' +
          'o.CantidadProcesada END ) AS Pendiente                  '#13#10'      ' +
          'FROM LineaMovimiento LEFT JOIN Movimiento ON ( Movimiento.Ejerci' +
          'cio=LineaMovimiento.Ejercicio AND Movimiento.NroOperacion=LineaM' +
          'ovimiento.NroOperacion )'#13#10'      WHERE ( Movimiento.TipoMovimient' +
          'o=14 ) AND'#13#10'             ( Movimiento.Situacion<>2 ) AND        ' +
          '     '#13#10'             ( Movimiento.Propietario BETWEEN <ClienteIni' +
          'cial> AND <ClienteFinal> ) AND'#13#10'             ( Movimiento.Codigo' +
          'Transportista BETWEEN <TransportistaInicial> AND <TransportistaF' +
          'inal> ) AND                 '#13#10'             ( <Fecha> BETWEEN <Fe' +
          'chaInicial> AND <FechaFinal> ) AND                 '#13#10'           ' +
          '  ( LineaMovimiento.CodigoArticulo<>'#39'.'#39' ) AND               '#13#10'  ' +
          '           ( LineaMovimiento.CodigoArticulo BETWEEN <ArticuloIni' +
          'cial> AND <ArticuloFinal> ) AND'#13#10'             ( LineaMovimiento.' +
          'CodigoAlmacen BETWEEN <AlmacenInicial> AND <AlmacenFinal> ) AND'#13 +
          #10'             ( ( <Parametros>=0 ) OR BITAND( LineaMovimiento.Pa' +
          'rametros, <Parametros> )<>0 ) AND                 '#13#10'            ' +
          ' not LineaMovimiento.Procesada AND'#13#10'             ( LineaMovimien' +
          'to.Cantidad - LineaMovimiento.CantidadProcesada )>0 '#13#10'      GROU' +
          'P BY LineaMovimiento.CodigoAlmacen,'#13#10'                LineaMovimi' +
          'ento.CodigoArticulo,'#13#10'                LineaMovimiento.Descripcio' +
          'n,'#13#10'                LineaMovimiento.CodigoClaseA,'#13#10'             ' +
          '   LineaMovimiento.CodigoClaseB,'#13#10'                LineaMovimient' +
          'o.CodigoClaseC,'#13#10'                LineaMovimiento.Parametros ) AS' +
          ' AcumuladoPendiente'#13#10'      LEFT JOIN Almacen ON ( Almacen.Codigo' +
          '=AcumuladoPendiente.CodigoAlmacen )'#13#10'  '#13#10
      end
      item
        Title = 'Detalle'
        SQLText = 
          'SELECT Cabecera.Fecha AS FechaDocumento,'#13#10'       Cabecera.Propie' +
          'tario AS CodigoPropietario,'#13#10'       Cliente.Nombre AS NombreProp' +
          'ietario,'#13#10'       Cabecera.CodigoTransportista as CodigoTransport' +
          'ista,                                                           ' +
          '                                                        '#13#10'      ' +
          ' Transportista.Nombre AS NombreTransportista,                   ' +
          '                                                                ' +
          '                '#13#10'       Cabecera.NroOperacion,                 ' +
          '                                    '#13#10'       Cabecera.Serie,'#13#10'  ' +
          '     Cabecera.Ejercicio,                                        ' +
          '       '#13#10'       Cabecera.NroDocumento,'#13#10'       Almacen.Nombre AS' +
          ' NombreAlmacen,'#13#10'       LineaMovimiento.*,       '#13#10'       LineaM' +
          'ovimiento.PuntoVerde AS Ecotasa,'#13#10'       CAST( ( CASE WHEN Linea' +
          'Movimiento.Procesada THEN 0.0 ELSE LineaMovimiento.Cantidad - Li' +
          'neaMovimiento.CantidadProcesada END ) AS BCD(16,4) ) AS Pendient' +
          'e,             '#13#10'       CAST( 0.0 AS BCD(16,4) ) AS Existencias,' +
          #13#10'       CAST( 0.0 AS BCD(16,4) ) AS ExistenciasVirtuales'#13#10'FROM ' +
          '( SELECT Ejercicio, NroOperacion, Serie, NroDocumento, Fecha, Fe' +
          'chaAplicacion, Propietario, CodigoTransportista                 ' +
          '                          '#13#10'       FROM   Movimiento'#13#10'       WHE' +
          'RE  ( Movimiento.TipoMovimiento=14 ) AND'#13#10'              ( Movimi' +
          'ento.Situacion<>2 ) AND              '#13#10'              ( Movimient' +
          'o.Propietario BETWEEN <ClienteInicial> AND <ClienteFinal> ) AND'#13 +
          #10'              ( Movimiento.CodigoTransportista BETWEEN <Transpo' +
          'rtistaInicial> AND <TransportistaFinal> )                  '#13#10'   ' +
          '           ) AS Cabecera'#13#10'      LEFT JOIN LineaMovimiento ON ( C' +
          'abecera.Ejercicio=LineaMovimiento.Ejercicio AND Cabecera.NroOper' +
          'acion=LineaMovimiento.NroOperacion )'#13#10'      LEFT JOIN Almacen ON' +
          ' ( Almacen.Codigo=LineaMovimiento.CodigoAlmacen )'#13#10'      LEFT JO' +
          'IN Cliente ON ( Cliente.Codigo=Cabecera.Propietario )'#13#10'      LEF' +
          'T JOIN Transportista ON ( Transportista.Codigo=Cabecera.CodigoTr' +
          'ansportista )          '#13#10'WHERE  ( <Fecha> BETWEEN <FechaInicial>' +
          ' AND <FechaFinal> ) AND'#13#10'       ( LineaMovimiento.CodigoArticulo' +
          '<>'#39'.'#39' ) AND'#13#10'       ( LineaMovimiento.CodigoArticulo BETWEEN <Ar' +
          'ticuloInicial> AND <ArticuloFinal> ) AND'#13#10'       ( LineaMovimien' +
          'to.CodigoAlmacen BETWEEN <AlmacenInicial> AND <AlmacenFinal> ) A' +
          'ND'#13#10'       ( ( <Parametros>=0 ) OR BITAND( LineaMovimiento.Param' +
          'etros, <Parametros> )<>0 ) AND           '#13#10'       NOT LineaMovim' +
          'iento.Procesada AND '#13#10'       ( LineaMovimiento.Cantidad - LineaM' +
          'ovimiento.CantidadProcesada )>0 '#13#10
      end
      item
        Title = 'Detalle_OrdenPropietario'
        SQLText = 
          'ORDER BY Cabecera.Propietario, '#13#10'         LineaMovimiento.Codigo' +
          'Articulo, '#13#10'         LineaMovimiento.CodigoClaseA,'#13#10'         Lin' +
          'eaMovimiento.CodigoClaseB,'#13#10'         LineaMovimiento.CodigoClase' +
          'C  '#13#10
      end
      item
        Title = 'Detalle_OrdenArticulo'
        SQLText = 
          'ORDER BY LineaMovimiento.CodigoArticulo,'#13#10'         LineaMovimien' +
          'to.CodigoClaseA,'#13#10'         LineaMovimiento.CodigoClaseB,'#13#10'      ' +
          '   LineaMovimiento.CodigoClaseC,'#13#10'         Cabecera.Propietario ' +
          '            '#13#10
      end
      item
        Title = 'Detalle_OrdenTransportista'
        SQLText = 
          'ORDER BY Cabecera.CodigoTransportista, '#13#10'         LineaMovimient' +
          'o.CodigoArticulo, '#13#10'         LineaMovimiento.CodigoClaseA,'#13#10'    ' +
          '     LineaMovimiento.CodigoClaseB,'#13#10'         LineaMovimiento.Cod' +
          'igoClaseC                                      '#13#10
      end>
    Left = 55
    Top = 31
  end
end
