object DataModule40: TDataModule40
  OldCreateOrder = False
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 338
  Width = 453
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm40'
    SQLItems = <
      item
        Title = 'Procedures'
        SQLText = 
          #13#10'// DesplazaPaginaDocumento  ----------------------------------' +
          '----------------------------------------------'#13#10'  '#13#10'DROP ROUTINE' +
          ' IF EXISTS "MovePage";  // Es el nombre que ten'#237'a antes         ' +
          '                                                           '#13#10#13#10'D' +
          'ROP ROUTINE IF EXISTS "DesplazaPaginaDocumento";'#13#10#13#10'CREATE PROCE' +
          'DURE DesplazaPaginaDocumento( IN _Ejercicio SMALLINT, IN _NroOpe' +
          'racion INTEGER, IN _NroPaginaOrigen SMALLINT, IN _NroPaginaDesti' +
          'no SMALLINT )'#13#10'READS SQL DATA '#13#10'MODIFIES SQL DATA'#13#10'BEGIN'#13#10#13#10'DECL' +
          'ARE PrimerNroPagina, UltimoNroPagina, Paso SMALLINT;'#13#10'DECLARE Do' +
          'wn BOOLEAN;'#13#10#13#10'SET Down = _NroPaginaOrigen>_NroPaginaDestino;'#13#10'I' +
          'F Down '#13#10'THEN SET PrimerNroPagina = _NroPaginaDestino;  SET Ulti' +
          'moNroPagina = _NroPaginaOrigen; SET Paso = 1;'#13#10'ELSE SET PrimerNr' +
          'oPagina = _NroPaginaOrigen;  SET UltimoNroPagina = _NroPaginaDes' +
          'tino; SET Paso = -1;'#13#10'END IF;'#13#10#13#10'START TRANSACTION;'#13#10'TRY'#13#10#13#10'    ' +
          '                       '#13#10' // Las l'#237'neas de la pagina origen se g' +
          'uardan en un fichero temporal'#13#10#13#10'  SELECT * INTO #TEMP_A FROM Li' +
          'neaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOp' +
          'eracion AND NroPagina=_NroPaginaOrigen;'#13#10'  DELETE FROM LineaMovi' +
          'miento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion' +
          ' AND NroPagina=_NroPaginaOrigen;'#13#10'  '#13#10'  // Las l'#237'neas situadas e' +
          'ntre ambas, se desplazan convenientemente'#13#10'  SELECT * INTO #TEMP' +
          '_B FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperac' +
          'ion=_NroOperacion AND NroPagina BETWEEN PrimerNroPagina AND Ulti' +
          'moNroPagina;'#13#10'  DELETE FROM LineaMovimiento WHERE Ejercicio=_Eje' +
          'rcicio AND NroOperacion=_NroOperacion AND NroPagina BETWEEN Prim' +
          'erNroPagina AND UltimoNroPagina;'#13#10'  UPDATE #TEMP_B SET NroPagina' +
          '=NroPagina + Paso;'#13#10'  INSERT INTO LineaMovimiento SELECT * FROM ' +
          '#TEMP_B;'#13#10'  '#13#10'  // La vuelta de las l'#237'neas origen como l'#237'neas de' +
          'stino'#13#10'  UPDATE #TEMP_A SET NroPagina=_NroPaginaDestino;'#13#10'  INSE' +
          'RT INTO LineaMovimiento SELECT * FROM #TEMP_A;'#13#10'    '#13#10'  // Ahora' +
          ' le toca el turno a las p'#225'ginas'#13#10#13#10'  SELECT * INTO #TEMP_A FROM ' +
          'GrupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion' +
          '=_NroOperacion AND NroPagina=_NroPaginaOrigen;'#13#10'  DELETE FROM Gr' +
          'upoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_' +
          'NroOperacion AND NroPagina=_NroPaginaOrigen;'#13#10#13#10'  // Las p'#225'ginas' +
          ' situadas entre ambas, se desplazan convenientemente'#13#10'  SELECT *' +
          ' INTO #TEMP_B FROM GrupoLineaMovimiento WHERE Ejercicio=_Ejercic' +
          'io AND NroOperacion=_NroOperacion AND NroPagina BETWEEN PrimerNr' +
          'oPagina AND UltimoNroPagina;'#13#10'  DELETE FROM GrupoLineaMovimiento' +
          ' WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND N' +
          'roPagina BETWEEN PrimerNroPagina AND UltimoNroPagina;'#13#10'  UPDATE ' +
          '#TEMP_B SET NroPagina=NroPagina + Paso;'#13#10'  INSERT INTO GrupoLine' +
          'aMovimiento SELECT * FROM #TEMP_B;'#13#10#13#10'  // La vuelta de las p'#225'gi' +
          'nas origen como p'#225'ginas destino'#13#10'  UPDATE #TEMP_A SET NroPagina=' +
          '_NroPaginaDestino;'#13#10'  INSERT INTO GrupoLineaMovimiento SELECT * ' +
          'FROM #TEMP_A;'#13#10#13#10#13#10'  COMMIT;'#13#10' CATCH True'#13#10'   ROLLBACK;'#13#10'   SIGN' +
          'AL ERROR_MESSAGE;'#13#10'   END;'#13#10'   '#13#10'END;'#13#10'  '#13#10'// InsertaPaginaDocum' +
          'ento -----------------------------------------------------------' +
          '----------------------'#13#10#13#10'DROP ROUTINE IF EXISTS "InsertaPaginaD' +
          'ocumento";'#13#10#13#10'CREATE PROCEDURE InsertaPaginaDocumento( IN _Ejerc' +
          'icio SMALLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT ' +
          ')'#13#10'READS SQL DATA '#13#10'MODIFIES SQL DATA'#13#10'BEGIN'#13#10#13#10'START TRANSACTIO' +
          'N;'#13#10'TRY'#13#10#13#10'  // Primero desplazo las l'#237'neas'#13#10#13#10'  SELECT * INTO #' +
          'TEMP FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOper' +
          'acion=_NroOperacion AND NroPagina>=_NroPagina;'#13#10'  DELETE FROM Li' +
          'neaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOp' +
          'eracion AND NroPagina>=_NroPagina;'#13#10'  UPDATE #TEMP SET NroPagina' +
          '=NroPagina + 1;'#13#10'  INSERT INTO LineaMovimiento SELECT * FROM #TE' +
          'MP;'#13#10#13#10'  // Y luego, las p'#225'ginas'#13#10#13#10'  SELECT * INTO #TEMP FROM G' +
          'rupoLineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=' +
          '_NroOperacion AND NroPagina>=_NroPagina;'#13#10'  DELETE FROM GrupoLin' +
          'eaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOpe' +
          'racion AND NroPagina>=_NroPagina;'#13#10'  UPDATE #TEMP SET NroPagina=' +
          'NroPagina + 1;'#13#10'  INSERT INTO GrupoLineaMovimiento SELECT * FROM' +
          ' #TEMP;'#13#10#13#10'  COMMIT;'#13#10' CATCH True'#13#10'   ROLLBACK;'#13#10'   SIGNAL ERROR' +
          '_MESSAGE;'#13#10'   END;'#13#10'   '#13#10'END;'#13#10'  '#13#10'// DesplazaLineaDocumento ---' +
          '----------------------------------------------------------------' +
          '--------------'#13#10#13#10'DROP ROUTINE IF EXISTS "DesplazaLineaDocumento' +
          '";'#13#10#13#10'CREATE PROCEDURE DesplazaLineaDocumento( IN _Ejercicio SMA' +
          'LLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT, IN _Nro' +
          'LineaOrigen SMALLINT, IN _NroLineaDestino SMALLINT )'#13#10'READS SQL ' +
          'DATA '#13#10'MODIFIES SQL DATA'#13#10'BEGIN'#13#10#13#10'DECLARE PrimerNroLinea, Ultim' +
          'oNroLinea, Paso SMALLINT;'#13#10'DECLARE Down BOOLEAN;'#13#10#13#10'SET Down = _' +
          'NroLineaOrigen>_NroLineaDestino;'#13#10'IF Down '#13#10'THEN SET PrimerNroLi' +
          'nea = _NroLineaDestino;  SET UltimoNroLinea = _NroLineaOrigen; S' +
          'ET Paso = 1;'#13#10'ELSE SET PrimerNroLinea = _NroLineaOrigen;  SET Ul' +
          'timoNroLinea = _NroLineaDestino; SET Paso = -1;'#13#10'END IF;'#13#10#13#10'STAR' +
          'T TRANSACTION;'#13#10'TRY'#13#10#13#10'                           '#13#10' // La linea' +
          ' origen se guarda en un fichero temporal'#13#10#13#10'  SELECT * INTO #TEM' +
          'P_A FROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOpera' +
          'cion=_NroOperacion AND NroPagina=_NroPagina AND NroLinea=_NroLin' +
          'eaOrigen;'#13#10'  DELETE FROM LineaMovimiento WHERE Ejercicio=_Ejerci' +
          'cio AND NroOperacion=_NroOperacion AND NroPagina=_NroPagina AND ' +
          'NroLinea=_NroLineaOrigen;'#13#10'  '#13#10'  // Las linea situadas entre amb' +
          'as, se desplazan convenientemente'#13#10'  SELECT * INTO #TEMP_B FROM ' +
          'LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_Nro' +
          'Operacion AND NroPagina=_NroPagina AND NroLinea BETWEEN PrimerNr' +
          'oLinea AND UltimoNroLinea;'#13#10'  DELETE FROM LineaMovimiento WHERE ' +
          'Ejercicio=_Ejercicio AND NroOperacion=_NroOperacion AND NroPagin' +
          'a=_NroPagina AND NroLinea BETWEEN PrimerNroLinea AND UltimoNroLi' +
          'nea;'#13#10'  UPDATE #TEMP_B SET NroLinea=NroLinea + Paso;'#13#10'  INSERT I' +
          'NTO LineaMovimiento SELECT * FROM #TEMP_B;'#13#10'  '#13#10'  // La vuelta d' +
          'e la l'#237'nea origen como l'#237'nea destino'#13#10'  UPDATE #TEMP_A SET NroLi' +
          'nea=_NroLineaDestino;'#13#10'  INSERT INTO LineaMovimiento SELECT * FR' +
          'OM #TEMP_A;'#13#10'    '#13#10'  COMMIT;'#13#10' CATCH True'#13#10'   ROLLBACK;'#13#10'   SIGN' +
          'AL ERROR_MESSAGE;'#13#10'   END;'#13#10'   '#13#10'END;'#13#10#13#10'// InsertaLineaDocument' +
          'o --------------------------------------------------------------' +
          '--------------------'#13#10#13#10'DROP ROUTINE IF EXISTS "InsertaLineaDocu' +
          'mento";'#13#10#13#10'CREATE PROCEDURE InsertaLineaDocumento( IN _Ejercicio' +
          ' SMALLINT, IN _NroOperacion INTEGER, IN _NroPagina SMALLINT, IN ' +
          '_NroLinea SMALLINT )'#13#10'READS SQL DATA '#13#10'MODIFIES SQL DATA'#13#10'BEGIN'#13 +
          #10#13#10'START TRANSACTION;'#13#10'TRY'#13#10#13#10'  SELECT * INTO #TEMP FROM LineaMo' +
          'vimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=_NroOperaci' +
          'on AND NroPagina=_NroPagina AND NroLinea>=_NroLinea;'#13#10'  DELETE F' +
          'ROM LineaMovimiento WHERE Ejercicio=_Ejercicio AND NroOperacion=' +
          '_NroOperacion AND NroPagina=_NroPagina AND NroLinea>=_NroLinea;'#13 +
          #10'  UPDATE #TEMP SET NroLinea=NroLinea + 1;'#13#10'  INSERT INTO LineaM' +
          'ovimiento SELECT * FROM #TEMP;'#13#10'  '#13#10'  COMMIT;'#13#10' CATCH True'#13#10'   R' +
          'OLLBACK;'#13#10'   SIGNAL ERROR_MESSAGE;'#13#10'   END;'#13#10'   '#13#10'END;'#13#10'  '#13#10'// E' +
          'ntregasACuentaPedidosOrigen ------------------------------------' +
          '---------------------------------------'#13#10'  '#13#10'DROP ROUTINE IF EXI' +
          'STS "EntregasACuentaPedidosOrigen";'#13#10'  '#13#10'CREATE PROCEDURE Entreg' +
          'asACuentaPedidosOrigen(_Ejercicio SmallInt, _NroOperacion Intege' +
          'r, _Serie NVarChar(40), _NroFactura Integer, OUT _Importe BCD(16,4)' +
          ')'#13#10'  READS SQL DATA'#13#10#13#10'begin'#13#10'  SET _Importe = ( SELEC' +
          'T SUM( EntregaACuenta )                                         ' +
          '            '#13#10'         FROM( SELECT DISTINCT ( EjercicioOrigen *' +
          ' 100000000 ) + NroOperacionOrigen, EjercicioOrigen AS Ejercicio,' +
          ' NroOperacionOrigen AS NroOperacion'#13#10'               FROM LineaMo' +
          'vimiento'#13#10'               WHERE Ejercicio=_Ejercicio AND NroOpera' +
          'cion=_NroOperacion AND TipoMovimientoOrigen=14 ) AS MovimientoOr' +
          'igen'#13#10'         LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=Mo' +
          'vimientoOrigen.Ejercicio AND Movimiento.NroOperacion=MovimientoO' +
          'rigen.NroOperacion ) '#13#10'         WHERE Movimiento.NroFactura IS N' +
          'ULL OR Movimiento.NroFactura=0 OR ( Movimiento.SerieFactura=_Ser' +
          'ie AND Movimiento.NroFactura=_NroFactura ) );                 '#13#10 +
          'END;'#13#10'    '#13#10'// Limpieza de funciones obsoletas'#13#10#13#10'DROP ROUTINE I' +
          'F EXISTS "ArticuloKilos";'#13#10'DROP ROUTINE IF EXISTS "ArticuloTipoI' +
          'VA";'#13#10'  '#13#10#13#10#13#10'  '#13#10
      end>
    OnVerify = DictionaryVerify
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <>
    Left = 48
    Top = 88
  end
  object DetailSourceTable: TnxeTable
    Timeout = 15000
    TableType = ttRecover
    Left = 161
    Top = 88
  end
  object MasterSourceTable: TnxeTable
    Timeout = 15000
    TableType = ttRecover
    Left = 160
    Top = 24
  end
end
