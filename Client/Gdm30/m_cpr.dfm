object CprQueryModule: TCprQueryModule
  OnInitialize = PersistentQueryModuleInitialize
  OnUpdate = PersistentQueryModuleUpdate
  Height = 156
  Width = 167
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'AcumuladoArticulo'
        SQLText = 
          #13#10'SELECT AcumuladoPendiente.*,'#13#10'       Almacen.Nombre AS NombreA' +
          'lmacen,                    '#13#10'       CAST( 0.0 AS BCD(16,4)  ) AS' +
          ' Existencias,'#13#10'       CAST( 0.0 AS BCD(16,4) ) AS ExistenciasVir' +
          'tuales                                                          ' +
          '         '#13#10'FROM ( SELECT LineaMovimiento.CodigoAlmacen,'#13#10'       ' +
          '       LineaMovimiento.CodigoArticulo,'#13#10'              LineaMovim' +
          'iento.Descripcion,'#13#10'              LineaMovimiento.CodigoClaseA,'#13 +
          #10'              LineaMovimiento.CodigoClaseB,'#13#10'              Line' +
          'aMovimiento.CodigoClaseC,                  '#13#10'              SUM( ' +
          'LineaMovimiento.Cantidad ) AS Cantidad,'#13#10'              SUM( CASE' +
          ' WHEN LineaMovimiento.Procesada THEN 0.0 ELSE LineaMovimiento.Ca' +
          'ntidad - LineaMovimiento.CantidadProcesada END ) AS Pendiente   ' +
          '               '#13#10'      FROM LineaMovimiento LEFT JOIN Movimiento' +
          ' ON ( Movimiento.Ejercicio=LineaMovimiento.Ejercicio AND Movimie' +
          'nto.NroOperacion=LineaMovimiento.NroOperacion )'#13#10'      WHERE ( M' +
          'ovimiento.TipoMovimiento=11 ) AND'#13#10'             ( Movimiento.Sit' +
          'uacion<>2 ) AND             '#13#10'             ( Movimiento.Propieta' +
          'rio BETWEEN <ProveedorInicial> AND <ProveedorFinal> ) AND       ' +
          '          '#13#10'             ( <Fecha> BETWEEN <FechaInicial> AND <F' +
          'echaFinal> ) AND                 '#13#10'             ( LineaMovimient' +
          'o.CodigoArticulo<>'#39'.'#39' ) AND               '#13#10'             ( Linea' +
          'Movimiento.CodigoArticulo BETWEEN <ArticuloInicial> AND <Articul' +
          'oFinal> ) AND'#13#10'             ( LineaMovimiento.CodigoAlmacen BETW' +
          'EEN <AlmacenInicial> AND <AlmacenFinal> ) AND                 '#13#10 +
          '             not LineaMovimiento.Procesada AND'#13#10'             ( L' +
          'ineaMovimiento.Cantidad - LineaMovimiento.CantidadProcesada )>0 ' +
          #13#10'      GROUP BY LineaMovimiento.CodigoAlmacen,'#13#10'               ' +
          ' LineaMovimiento.CodigoArticulo,'#13#10'                LineaMovimient' +
          'o.Descripcion,'#13#10'                LineaMovimiento.CodigoClaseA,'#13#10' ' +
          '               LineaMovimiento.CodigoClaseB,'#13#10'                Li' +
          'neaMovimiento.CodigoClaseC,'#13#10'                LineaMovimiento.Par' +
          'ametros ) AS AcumuladoPendiente'#13#10'      LEFT JOIN Almacen ON ( Al' +
          'macen.Codigo=AcumuladoPendiente.CodigoAlmacen )'#13#10'  '#13#10
      end
      item
        Title = 'Detalle'
        SQLText = 
          'SELECT Cabecera.Fecha AS FechaDocumento,'#13#10'       Cabecera.Propie' +
          'tario AS CodigoPropietario,'#13#10'       Proveedor.Nombre AS NombrePr' +
          'opietario,                                                      ' +
          '                                             '#13#10'       Cabecera.N' +
          'roOperacion,                                                    ' +
          ' '#13#10'       Cabecera.Serie,'#13#10'       Cabecera.Ejercicio,           ' +
          '                                    '#13#10'       Cabecera.NroDocumen' +
          'to,'#13#10'       Almacen.Nombre AS NombreAlmacen,'#13#10'       LineaMovimi' +
          'ento.*,       '#13#10'       LineaMovimiento.PuntoVerde AS Ecotasa,'#13#10' ' +
          '      CAST( ( CASE WHEN LineaMovimiento.Procesada THEN 0.0 ELSE ' +
          'LineaMovimiento.Cantidad - LineaMovimiento.CantidadProcesada END' +
          ' ) AS BCD(16,4) ) AS Pendiente,             '#13#10'       CAST( 0.0 A' +
          'S BCD(16,4) ) AS Existencias,'#13#10'       CAST( 0.0 AS BCD(16,4) ) A' +
          'S ExistenciasVirtuales'#13#10'FROM ( SELECT Ejercicio, NroOperacion, S' +
          'erie, NroDocumento, Fecha, FechaAplicacion, Propietario, CodigoT' +
          'ransportista                                           '#13#10'       ' +
          'FROM   Movimiento'#13#10'       WHERE  ( Movimiento.TipoMovimiento=11 ' +
          ') AND'#13#10'              ( Movimiento.Situacion<>2 ) AND            ' +
          '  '#13#10'              ( Movimiento.Propietario BETWEEN <ProveedorIni' +
          'cial> AND <ProveedorFinal> )                  '#13#10'              ) ' +
          'AS Cabecera'#13#10'      LEFT JOIN LineaMovimiento ON ( Cabecera.Ejerc' +
          'icio=LineaMovimiento.Ejercicio AND Cabecera.NroOperacion=LineaMo' +
          'vimiento.NroOperacion )'#13#10'      LEFT JOIN Almacen ON ( Almacen.Co' +
          'digo=LineaMovimiento.CodigoAlmacen )'#13#10'      LEFT JOIN Proveedor ' +
          'ON ( Proveedor.Codigo=Cabecera.Propietario )          '#13#10'WHERE  (' +
          ' <Fecha> BETWEEN <FechaInicial> AND <FechaFinal> ) AND'#13#10'       (' +
          ' LineaMovimiento.CodigoArticulo<>'#39'.'#39' ) AND'#13#10'       ( LineaMovimi' +
          'ento.CodigoArticulo BETWEEN <ArticuloInicial> AND <ArticuloFinal' +
          '> ) AND'#13#10'       ( LineaMovimiento.CodigoAlmacen BETWEEN <Almacen' +
          'Inicial> AND <AlmacenFinal> ) AND           '#13#10'       NOT LineaMo' +
          'vimiento.Procesada AND '#13#10'       ( LineaMovimiento.Cantidad - Lin' +
          'eaMovimiento.CantidadProcesada )>0 '#13#10
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
      end>
    Left = 55
    Top = 31
  end
end
