SELECT SUM( Cantidad ) AS Cantidad,
       SUM( CantidadProcesada ) AS CantidadProcesada,
       SUM( Cantidad * ( Precio + PuntoVerde + Recargo ) ) AS ImporteBruto,
       SUM( ( ( Cantidad * ( Precio + Recargo ) ) * Descuento ) / 100.0 ) AS Descuentos
FROM ( SELECT Cantidad, CantidadProcesada, Precio, LineaMovimiento.PuntoVerde, Recargo, Descuento,
             ( CASE WHEN Cliente.Factura_ModeloIVA=0 THEN 0 ELSE CASE WHEN Cliente.Factura_ModeloIVA=3 AND NOT Articulo.NoAplicarTipoFijo THEN Cliente.Factura_TipoFijoIVA ELSE Articulo.TipoIVA END END ) AS TipoIVA
       FROM LineaMovimiento
            LEFT JOIN Articulo ON ( Articulo.Codigo=LineaMovimiento.CodigoArticulo )
            LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=LineaMovimiento.Ejercicio AND Movimiento.NroOperacion=LineaMovimiento.NroOperacion )
            LEFT JOIN Cliente ON ( Cliente.Codigo=Movimiento.Propietario )
       WHERE LineaMovimiento.Ejercicio= 2012 AND LineaMovimiento.NroOperacion=4 ) AS Lineas
	   
	   	  
// DesplazaPaginaDocumento  --------------------------------------------------------------------------------
  
DROP ROUTINE IF EXISTS "MovePage";  // Es el nombre que tenía antes                                                                    

DROP ROUTINE IF EXISTS "DesplazaPaginaDocumento";

CREATE PROCEDURE DesplazaPaginaDocumento( IN _Ejercicio SMALLINT, IN _NroOperacion INTEGER, IN _NroPaginaOrigen SMALLINT, IN _NroPaginaDestino SMALLINT )
READS SQL DATA 
MODIFIES SQL DATA
BEGIN

DECLARE PrimerNroPagina, UltimoNroPagina, Paso SMALLINT;
DECLARE Down BOOLEAN;

SET Down = _NroPaginaOrigen>_NroPaginaDestino;
IF Down 
THEN SET PrimerNroPagina = _NroPaginaDestino;  SET UltimoNroPagina = _NroPaginaOrigen; SET Paso = 1;
ELSE SET PrimerNroPagina = _NroPaginaOrigen;  SET UltimoNroPagina = _NroPaginaDestino; SET Paso = -1;
END IF;

START TRANSACTION;
TRY

                           
 // Las líneas de la pagina origen se guardan en un fichero temporal

  SELECT * INTO #TEMP_A FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPaginaOrigen;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPaginaOrigen;
  
  // Las líneas situadas entre ambas, se desplazan convenientemente
  SELECT * INTO #TEMP_B FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina BETWEEN PrimerNroPagina AND UltimoNroPagina;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina BETWEEN PrimerNroPagina AND UltimoNroPagina;
  UPDATE #TEMP_B SET NroPagina=NroPagina + Paso;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP_B;
  
  // La vuelta de las líneas origen como líneas destino
  UPDATE #TEMP_A SET NroPagina=_NroPaginaDestino;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP_A;
    
  // Ahora le toca el turno a las páginas

  SELECT * INTO #TEMP_A FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPaginaOrigen;
  DELETE FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPaginaOrigen;

  // Las páginas situadas entre ambas, se desplazan convenientemente
  SELECT * INTO #TEMP_B FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina BETWEEN PrimerNroPagina AND UltimoNroPagina;
  DELETE FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina BETWEEN PrimerNroPagina AND UltimoNroPagina;
  UPDATE #TEMP_B SET NroPagina=NroPagina + Paso;
  INSERT INTO GrupoLineaMovimiento SELECT * FROM #TEMP_B;

  // La vuelta de las páginas origen como páginas destino
  UPDATE #TEMP_A SET NroPagina=_NroPaginaDestino;
  INSERT INTO GrupoLineaMovimiento SELECT * FROM #TEMP_A;


  COMMIT;
 CATCH True
   ROLLBACK;
   SIGNAL ERROR_MESSAGE;
   END;
   
END;
  
// InsertaPaginaDocumento ---------------------------------------------------------------------------------

DROP ROUTINE IF EXISTS "InsertaPaginaDocumento";

CREATE PROCEDURE InsertaPaginaDocumento( IN _Ejercicio SMALLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT )
READS SQL DATA 
MODIFIES SQL DATA
BEGIN

START TRANSACTION;
TRY

  // Primero desplazo las líneas

  SELECT * INTO #TEMP FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina>=_NroPagina;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina>=_NroPagina;
  UPDATE #TEMP SET NroPagina=NroPagina + 1;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP;

  // Y luego, las páginas

  SELECT * INTO #TEMP FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina>=_NroPagina;
  DELETE FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina>=_NroPagina;
  UPDATE #TEMP SET NroPagina=NroPagina + 1;
  INSERT INTO GrupoLineaMovimiento SELECT * FROM #TEMP;

  COMMIT;
 CATCH True
   ROLLBACK;
   SIGNAL ERROR_MESSAGE;
   END;
   
END;
  
// DesplazaLineaDocumento ---------------------------------------------------------------------------------

DROP ROUTINE IF EXISTS "DesplazaLineaDocumento";

CREATE PROCEDURE DesplazaLineaDocumento( IN _Ejercicio SMALLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT, IN _NroLineaOrigen SMALLINT, IN _NroLineaDestino SMALLINT )
READS SQL DATA 
MODIFIES SQL DATA
BEGIN

DECLARE PrimerNroLinea, UltimoNroLinea, Paso SMALLINT;
DECLARE Down BOOLEAN;

SET Down = _NroLineaOrigen>_NroLineaDestino;
IF Down 
THEN SET PrimerNroLinea = _NroLineaDestino;  SET UltimoNroLinea = _NroLineaOrigen; SET Paso = 1;
ELSE SET PrimerNroLinea = _NroLineaOrigen;  SET UltimoNroLinea = _NroLineaDestino; SET Paso = -1;
END IF;

START TRANSACTION;
TRY

                           
 // La linea origen se guarda en un fichero temporal

  SELECT * INTO #TEMP_A FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea=_NroLineaOrigen;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea=_NroLineaOrigen;
  
  // Las linea situadas entre ambas, se desplazan convenientemente
  SELECT * INTO #TEMP_B FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea BETWEEN PrimerNroLinea AND UltimoNroLinea;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea BETWEEN PrimerNroLinea AND UltimoNroLinea;
  UPDATE #TEMP_B SET NroLinea=NroLinea + Paso;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP_B;
  
  // La vuelta de la línea origen como línea destino
  UPDATE #TEMP_A SET NroLinea=_NroLineaDestino;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP_A;
    
  COMMIT;
 CATCH True
   ROLLBACK;
   SIGNAL ERROR_MESSAGE;
   END;
   
END;

// InsertaLineaDocumento ----------------------------------------------------------------------------------

DROP ROUTINE IF EXISTS "InsertaLineaDocumento";

CREATE PROCEDURE InsertaLineaDocumento( IN _Ejercicio SMALLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT, IN _NroLinea SMALLINT )
READS SQL DATA 
MODIFIES SQL DATA
BEGIN

START TRANSACTION;
TRY

  SELECT * INTO #TEMP FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea>=_NroLinea;
  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea>=_NroLinea;
  UPDATE #TEMP SET NroLinea=NroLinea + 1;
  INSERT INTO LineaMovimiento SELECT * FROM #TEMP;
  
  COMMIT;
 CATCH True
   ROLLBACK;
   SIGNAL ERROR_MESSAGE;
   END;
   
END;
  
// EntregasACuentaPedidosOrigen ---------------------------------------------------------------------------
  
DROP ROUTINE IF EXISTS "EntregasACuentaPedidosOrigen";
  
CREATE PROCEDURE EntregasACuentaPedidosOrigen(_Ejercicio SmallInt, _NroOperacion Integer, _Serie NVarChar(40), _NroFactura Integer, OUT _Importe Decimal( 16, 4 ))
  READS SQL DATA

begin
  SET _Importe = ( SELECT SUM( EntregaACuenta )                                                     
         FROM( SELECT DISTINCT ( EjercicioOrigen * 100000000 ) + NroOperacionOrigen, EjercicioOrigen AS Ejercicio, NroOperacionOrigen AS NroOperacion
               FROM LineaMovimiento
               WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND TipoMovimientoOrigen=14 ) AS MovimientoOrigen
         LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=MovimientoOrigen.Ejercicio AND Movimiento.NroOperacion=MovimientoOrigen.NroOperacion ) 
         WHERE Movimiento.NroFactura IS NULL OR Movimiento.NroFactura=0 OR ( Movimiento.SerieFactura=_Serie AND Movimiento.NroFactura=_NroFactura ) );                 
END;
    
// Bitwise AND

DROP ROUTINE IF EXISTS "BITAND";

CREATE FUNCTION BITAND (N1 INTEGER, N2 INTEGER) RETURNS INTEGER
BEGIN
   DECLARE ReturnValue, S Integer DEFAULT 0;

   WHILE N1 > 0 AND N2 > 0 AND S < 32 DO
      SET ReturnValue = ReturnValue + MOD( N1, 2 ) * MOD( N2, 2 ) * POWER( 2, S );
       SET N1 = N1 / 2;
       SET N2 = N2 / 2;
       SET S = S + 1;
    END WHILE;

    RETURN ReturnValue;
END;

// Limpieza de funciones obsoletas

DROP ROUTINE IF EXISTS "ArticuloKilos";
DROP ROUTINE IF EXISTS "ArticuloTipoIVA";
  


  
	   