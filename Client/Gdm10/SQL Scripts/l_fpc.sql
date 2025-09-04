SELECT FacturaPendiente.*,        
       FacturaPendiente.Importe - FacturaPendiente.ImporteCobrado AS ImportePendiente,        
       EfectoCobrar.NroEfecto,        
       EfectoCobrar.Cliente,        
       EfectoCobrar.Entidad,        
       EfectoCobrar.FechaLibramiento,        
       EfectoCobrar.FechaVencimiento,        
       EfectoCobrar.FormaDePago,        
       EfectoCobrar.Concepto,        
       EfectoCobrar.Importe AS ImporteEfecto,        
       CuentaCliente.Descripcion AS NombreCliente,        
       CuentaEntidad.Descripcion AS NombreEntidad 
FROM ( SELECT *        
       FROM ( SELECT Factura.*,                      
                     SUM( CASE WHEN EfectoCobrar.NroRemesa IS NULL THEN CASE WHEN EfectoCobrar.FechaCobro IS NULL THEN 0.0 ELSE EfectoCobrar.ImporteCobrado END                           
                          ELSE CASE WHEN Remesa.Estado<>0 AND NOT EfectoCobrar.Impagado IS NULL THEN 0.0 ELSE EfectoCobrar.Importe END END ) AS ImporteCobrado               
              FROM ( SELECT Asiento.Ejercicio, Asiento.Fecha, Asiento.NroAsiento, Asiento.Serie, Asiento.NroFactura, Debe - Haber AS Importe                      
                     FROM   Apunte                           
                            LEFT JOIN Asiento ON ( Asiento.Ejercicio=Apunte.Ejercicio AND Asiento.NroAsiento=Apunte.NroAsiento )                      
                     WHERE Asiento.TipoAsiento=5 AND  Asiento.Fecha BETWEEN DATE '2011-03-15' AND DATE '2011-03-15' AND                            
                           Asiento.Serie BETWEEN '' AND 'ZZ' AND                            
                           Asiento.Propietario BETWEEN '430000000' AND '430999999' AND                            
                           Apunte.NroApunte=1 ) AS Factura                      
                   LEFT JOIN EfectoCobrar ON ( EfectoCobrar.Ejercicio=Factura.Ejercicio AND EfectoCobrar.Serie=Factura.Serie AND EfectoCobrar.NroFactura=Factura.NroFactura )                      
                   LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa )                      
                   LEFT JOIN Cuenta ON ( EfectoCobrar.Cliente=Cuenta.Codigo )               
              WHERE ( EfectoCobrar.Entidad BETWEEN '570000000' AND '579999999' ) AND                     
                    ( EfectoCobrar.FormaDePago BETWEEN '' AND 'ZZ' )               
              GROUP BY Factura.Ejercicio, Factura.Fecha, Factura.NroAsiento, Factura.Serie, Factura.NroFactura, Factura.Importe ) AS FacturaSeleccionada       
       WHERE FacturaSeleccionada.Importe>0.001 AND            
             FacturaSeleccionada.Importe>FacturaSeleccionada.ImporteCobrado ) AS FacturaPendiente 
       LEFT JOIN EfectoCobrar ON ( EfectoCobrar.Ejercicio=FacturaPendiente.Ejercicio AND EfectoCobrar.Serie=FacturaPendiente.Serie AND EfectoCobrar.NroFactura=FacturaPendiente.NroFactura ) 
       LEFT JOIN Cuenta AS CuentaCliente ON ( CuentaCliente.Codigo=EfectoCobrar.Cliente ) 
       LEFT JOIN Cuenta AS CuentaEntidad ON ( CuentaEntidad.Codigo=EfectoCobrar.Entidad ) 
       LEFT JOIN Remesa ON ( Remesa.Ejercicio=EfectoCobrar.EjercicioRemesa AND Remesa.NroRemesa=EfectoCobrar.NroRemesa ) 
WHERE ( ( EfectoCobrar.NroRemesa IS NULL AND EfectoCobrar.FechaCobro IS NULL ) OR ( NOT EfectoCobrar.NroRemesa IS NULL AND Remesa.Estado=0 ) ) 
ORDER BY FechaLibramiento, Ejercicio, Serie, NroFactura, NroEfecto 
