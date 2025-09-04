SELECT EfectoPagar.Importe,
       EfectoPagar.FechaLibramiento,
       CASE WHEN  EfectoPagar.NroRemesa=0 THEN EfectoPagar.FechaPago ELSE RemesaPago.FechaPago END,
      ( CAST( EfectoPagar.FechaLibramiento AS INT ) - CAST( EfectoPagar.FechaPago AS INT ) ) AS Dias
FROM   EfectoPagar
       LEFT JOIN RemesaPago ON ( RemesaPago.Ejercicio=EfectoPagar.EjercicioRemesa AND RemesaPago.NroRemesa=EfectoPagar.NroRemesa )
WHERE  ( FechaLibramiento BETWEEN DATE '2011-01-01' AND DATE '2011-12-31' ) AND
       ( EfectoPagar.Importe>0.0 ) AND
       NOT ( ( EfectoPagar.NroRemesa IS NULL AND NOT EfectoPagar.FechaPago IS NULL ) OR ( NOT EfectoPagar.NroRemesa IS NULL AND ( ( RemesaPago.Estado<>0 ) ) ) )
