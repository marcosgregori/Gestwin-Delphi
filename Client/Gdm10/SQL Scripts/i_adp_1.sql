// i_adp_1

SELECT SUM( CASE WHEN Efecto.FechaPago IS NULL
                 THEN 0.0
                 ELSE Efecto.Importe
            END ) AS TotalPagos,
       SUM( CASE WHEN Efecto.Dias<=30
                 THEN Efecto.Importe
                 ELSE 0.0
            END ) AS PagosPlazoLegal,
       SUM( CASE WHEN Efecto.Dias>30
                 THEN Efecto.Importe
                 ELSE 0.0
            END ) AS PagosFueraPlazo,
       ( SUM( Efecto.Importe * Dias ) / SUM( Efecto.Importe ) ) AS PMPE,
       SUM( CASE WHEN Efecto.FechaPago IS NULL
                 THEN CASE WHEN Efecto.Dias>30
                           THEN Efecto.Importe
                           ELSE 0.0
                      END ELSE 0.0
                 END ) AS TotalPendientesExceden
FROM ( SELECT *,
              CASE WHEN FechaPago IS NULL
                   THEN ( CAST( DATE '2011-12-31' AS INT ) - CAST( Seleccion.FechaLibramiento AS INT ) )
                   ELSE ( CAST( Seleccion.FechaPago AS INT ) - CAST( Seleccion.FechaLibramiento AS INT ) )
              END  AS Dias
       FROM ( SELECT EfectoPagar.Importe,
                     EfectoPagar.FechaLibramiento,
                     CASE WHEN EfectoPagar.NroRemesa IS NULL THEN EfectoPagar.FechaPago ELSE RemesaPago.FechaPago END AS FechaPago
              FROM   EfectoPagar
                     LEFT JOIN RemesaPago ON ( RemesaPago.Ejercicio=EfectoPagar.EjercicioRemesa AND RemesaPago.NroRemesa=EfectoPagar.NroRemesa )
              WHERE ( EXTRACT( YEAR FROM EfectoPagar.FechaLibramiento ) )=2011 AND
                    ( EfectoPagar.Importe>0.0 ) ) AS Seleccion ) AS Efecto

