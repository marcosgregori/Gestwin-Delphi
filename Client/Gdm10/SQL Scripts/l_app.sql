
SELECT EfectoPagar.*,       
       ( CAST( ( CAST( ( CASE WHEN EfectoPagar.NroRemesa IS NULL THEN EfectoPagar.FechaPago ELSE RemesaPago.FechaPago END ) AS FLOAT ) - CAST( EfectoPagar.FechaLibramiento AS FLOAT ) ) AS INTEGER ) ) AS Dias
FROM EfectoPagar
     LEFT JOIN RemesaPago ON ( RemesaPago.Ejercicio=EfectoPagar.EjercicioRemesa AND RemesaPago.NroRemesa=EfectoPagar.NroRemesa )
WHERE EfectoPagar.FechaPago BETWEEN DATE '2010-01-01' AND DATE '2010-12-31' AND
      ( NOT EfectoPagar.FechaPago IS NULL OR ( NOT EfectoPagar.NroRemesa IS NULL AND NOT RemesaPago.FechaPago IS NULL ) )
ORDER BY Dias
