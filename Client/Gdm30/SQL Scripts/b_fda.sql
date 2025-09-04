 SELECT *,
        m.TipoMovimiento,
        m.Serie,
        m.NroDocumento,
        m.Propietario,
        CASE WHEN Cantidad>=0.0 THEN Cantidad ELSE 0.0 END AS Entradas,
        CASE WHEN Cantidad<0.0 THEN 0.0 ELSE ABS( Cantidad ) END AS Salidas,
        CASE WHEN TipoMovimiento BETWEEN 10 AND 12 THEN ( SELECT Proveedor.Nombre FROM Proveedor WHERE Proveedor.Codigo=m.Propietario )
             WHEN TipoMovimiento BETWEEN 13 AND 15 THEN ( SELECT Cliente.Nombre FROM Cliente WHERE Cliente.Codigo=m.Propietario )
             ELSE m.Descripcion END AS Nombre,
       m.TipoMovAlmacen_Descripcion AS DescripcionTipoMovimiento                                                                                             
 FROM ( SELECT Ejercicio,
               NroOperacion,               
               TipoMovimiento,
               Serie,
               NroDocumento,
               Propietario,
               Movimiento.Descripcion,
               TipoMovAlmacen.Descripcion AS TipoMovAlmacen_Descripcion
        FROM   Movimiento
               LEFT JOIN TipoMovAlmacen ON ( TipoMovAlmacen.Tipo=Movimiento.TipoMovimiento )
        WHERE  ( Movimiento.Fecha BETWEEN DATE '2010-01-15' AND DATE '2010-02-15' )  AND 
               Movimiento.TipoMovimiento NOT IN ( 10, 11, 13, 14, 16, 17, 18 ) ) AS m
        LEFT JOIN LineaMovimiento ON ( m.Ejercicio=LineaMovimiento.Ejercicio AND m.NroOperacion=LineaMovimiento.NroOperacion )
                       
 
 ORDER BY Fecha, NroOperacion, NroLinea

