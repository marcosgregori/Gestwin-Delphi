SELECT Relacion.*, 
       TipoAsiento.Descripcion AS Tipo_Descripcion, 
       Cuenta.Descripcion AS Subcuenta_Descripcion, 
       Asiento.Fecha, 
       Asiento.TipoAsiento, 
       Asiento.NroFactura, 
       Asiento.Serie, 
       Asiento.FechaDocumento, 
       Asiento.NroRegistro, 
       Asiento.Anotacion 
FROM  ( SELECT Ejercicio,     
               NroAsiento,     
               NroApunte,     
               Subcuenta,     
               CentroCoste,     
               Contrapartida,     
               Concepto,     
               Debe,     
               Haber     
               
        FROM  Apunte 
        WHERE Apunte.Ejercicio=2011 AND Apunte.NroAsiento BETWEEN 353 AND 353 AND Asiento.TipoAsiento=1 ) AS Relacion  
        LEFT JOIN Asiento ON Relacion.Ejercicio=Asiento.Ejercicio AND Relacion.NroAsiento=Asiento.NroAsiento  
        LEFT JOIN TipoAsiento ON Asiento.TipoAsiento=TipoAsiento.NroRegistro  
        LEFT JOIN Cuenta ON Relacion.Subcuenta=Cuenta.Codigo

ORDER BY Ejercicio, NroAsiento, NroApunte