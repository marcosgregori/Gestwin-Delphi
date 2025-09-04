SELECT FacturaPendiente.*, Cuenta.Descripcion
FROM ( SELECT Factura.*,
              EfectoCobrar.Cliente,  
              SUM( CASE WHEN EfectoCobrar.NroRemesa IS NULL THEN EfectoCobrar.ImporteCobrado ELSE EfectoCobrar.Importe END ) AS ImporteCobrado              
       FROM ( SELECT Asiento.Ejercicio, Asiento.Serie, Asiento.NroFactura, Debe - Haber AS Importe
              FROM Apunte
                   LEFT JOIN Asiento ON ( Asiento.Ejercicio=Apunte.Ejercicio AND Asiento.NroAsiento=Apunte.NroAsiento )
              WHERE Asiento.TipoAsiento=5 AND 
                    Asiento.Fecha BETWEEN DATE '2010-01-01' AND DATE '2011-12-31' AND   
                    Asiento.Serie BETWEEN '' AND 'ZZ' AND
                    Asiento.Propietario BETWEEN '' AND 'ZZZZZ' AND                    
                    Apunte.NroApunte=1 ) AS Factura
              LEFT JOIN EfectoCobrar ON ( EfectoCobrar.Ejercicio=Factura.Ejercicio AND EfectoCobrar.Serie=Factura.Serie AND EfectoCobrar.NroFactura=Factura.NroFactura )
              LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa )
              LEFT JOIN Cuenta ON ( EfectoCobrar.Cliente=Cuenta.Codigo )
       WHERE ( EfectoCobrar.NroRemesa IS NULL AND NOT EfectoCobrar.FechaCobro IS NULL ) OR ( NOT EfectoCobrar.NroRemesa IS NULL AND Remesa.Estado<>0 AND NOT EfectoCobrar.Impagado )
       GROUP BY Factura.Ejercicio, Factura.Serie, Factura.NroFactura, EfectoCobrar.Cliente, Factura.Importe
       HAVING  Factura.Importe>0.0 AND ( Factura.Importe>SUM( CASE WHEN EfectoCobrar.NroRemesa IS NULL THEN EfectoCobrar.ImporteCobrado ELSE EfectoCobrar.Importe END ) )
) AS FacturaPendiente
LEFT JOIN Cuenta ON ( Cuenta.Codigo=FacturaPendiente.Cliente )
