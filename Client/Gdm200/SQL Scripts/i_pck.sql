SELECT PackingList.*, Seleccion.Ejercicio AS SeleccionEjercicio, Seleccion.NroOperacion AS SeleccionNroOperacion, Seleccion.NroDocumento 
FROM ( SELECT Ejercicio, NroOperacion, NroDocumento 
        FROM Movimiento 
        WHERE Movimiento.Serie='' AND Movimiento.Ejercicio=2011 AND Movimiento.TipoMovimiento=15 AND Movimiento.NroDocumento BETWEEN 1 AND 2   ) AS Seleccion 
        LEFT JOIN PackingList ON ( PackingList.Ejercicio=Seleccion.Ejercicio AND PackingList.TipoDocumento=0 AND PackingList.NroOperacion=Seleccion.NroOperacion )  
ORDER BY PackingList.Ejercicio, PackingList.NroOperacion