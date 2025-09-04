object DataModule30: TDataModule30
  OnCreate = ServerDataModuleCreate
  OnDestroy = ServerDataModuleDestroy
  OpenDatasetsOnCreate = True
  Height = 216
  Width = 433
  object Dictionary: TnxeDatabaseDictionary
    AliasPath = 'F:\Desktop\Gestwin\dm30'
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
          'r, _Serie NVarChar(40), _NroFactura Integer, OUT _Importe BCD(16' +
          ',4))'#13#10'  READS SQL DATA'#13#10#13#10'begin'#13#10'  SET _Importe = ( SELECT SUM( ' +
          'EntregaACuenta )                                                ' +
          '     '#13#10'         FROM( SELECT DISTINCT ( EjercicioOrigen * 100000' +
          '000 ) + NroOperacionOrigen, EjercicioOrigen AS Ejercicio, NroOpe' +
          'racionOrigen AS NroOperacion'#13#10'               FROM LineaMovimient' +
          'o'#13#10'               WHERE Ejercicio=_Ejercicio AND NroOperacion=_N' +
          'roOperacion AND TipoMovimientoOrigen=14 ) AS MovimientoOrigen'#13#10' ' +
          '        LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=Movimient' +
          'oOrigen.Ejercicio AND Movimiento.NroOperacion=MovimientoOrigen.N' +
          'roOperacion ) '#13#10'         WHERE Movimiento.NroFactura IS NULL OR ' +
          'Movimiento.NroFactura=0 OR ( Movimiento.SerieFactura=_Serie AND ' +
          'Movimiento.NroFactura=_NroFactura ) );                 '#13#10'END;'#13#10' ' +
          '   '#13#10'// Bitwise AND'#13#10#13#10'DROP ROUTINE IF EXISTS "BITAND";'#13#10#13#10'CREAT' +
          'E FUNCTION BITAND (N1 INTEGER, N2 INTEGER) RETURNS INTEGER'#13#10'BEGI' +
          'N'#13#10'   DECLARE ReturnValue, S Integer DEFAULT 0;'#13#10#13#10'   WHILE N1 >' +
          ' 0 AND N2 > 0 AND S < 32 DO'#13#10'      SET ReturnValue = ReturnValue' +
          ' + MOD( N1, 2 ) * MOD( N2, 2 ) * POWER( 2, S );'#13#10'       SET N1 =' +
          ' N1 / 2;'#13#10'       SET N2 = N2 / 2;'#13#10'       SET S = S + 1;'#13#10'    EN' +
          'D WHILE;'#13#10#13#10'    RETURN ReturnValue;'#13#10'END;'#13#10#13#10'// Limpieza de func' +
          'iones obsoletas'#13#10#13#10'DROP ROUTINE IF EXISTS "ArticuloKilos";'#13#10'DROP' +
          ' ROUTINE IF EXISTS "ArticuloTipoIVA";'#13#10'  '#13#10#13#10#13#10'  '#13#10
      end>
    OnVerify = DictionaryVerify
    OnBeforeUpdate = DictionaryBeforeUpdate
    OnAfterUpdate = DictionaryAfterUpdate
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Existencias'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'CodigoArticulo NVARCHAR(20),'#13#10'Codigo' +
          'ClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoClaseC NVa' +
          'rChar(3),'#13#10'Descripcion NVARCHAR(60),'#13#10'LoteFabricacion NVARCHAR(2' +
          '0),'#13#10'CodigoAlmacen NVARCHAR(2),'#13#10'CodigoFamilia NVARCHAR(5),'#13#10'Des' +
          'cripcionFamilia NVARCHAR(40),'#13#10'Entradas BCD(16,4),'#13#10'Salidas BCD(' +
          '16,4),'#13#10'Existencias BCD(16,4),'#13#10'PendienteRecibir BCD(16,4),'#13#10'Pen' +
          'dienteServir BCD(16,4),'#13#10'StockMinimo BCD(16,4),'#13#10'StockMaximo BCD' +
          '(16,4),'#13#10'Coste BCD(16,4) );'#13#10#13#10'CREATE INDEX Index1 ON <TableName' +
          '> ( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC );'#13 +
          #10'CREATE INDEX Index2 ON <TableName> ( CodigoFamilia, CodigoArtic' +
          'ulo, CodigoClaseA, CodigoClaseB, CodigoClaseC );'#13#10'CREATE INDEX I' +
          'ndex3 ON <TableName> ( Descripcion );'#13#10'CREATE INDEX Index4 ON <T' +
          'ableName> ( CodigoFamilia, Descripcion );'#13#10
      end
      item
        Title = 'Consumos'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'ID NVARCHAR(30),'#13#10'Tipo SMALLINT,'#13#10'Co' +
          'digoAgrupacion NVARCHAR(20),    '#13#10'Codigo NVARCHAR(20),'#13#10'Descripc' +
          'ion NVARCHAR(60),'#13#10'CodigoFamilia NVARCHAR(5),'#13#10'DescripcionFamili' +
          'a NVARCHAR(30),'#13#10'CodigoPropietario NVARCHAR(5),'#13#10'Nombre NVARCHAR' +
          '(40),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVarChar(3),'#13#10'Cod' +
          'igoClaseC NVARCHAR(3),'#13#10'CodigoGrupo NVARCHAR(3),'#13#10'DescripcionGru' +
          'po NVARCHAR(30),'#13#10'CodigoAlmacen NVARCHAR(2),'#13#10'Periodo SMALLINT,'#13 +
          #10'Unidades1 BCD(16,4),'#13#10'Importe1 BCD(16,4),'#13#10'ImporteCoste1 BCD(16' +
          ',4),'#13#10'PrecioCoste1 BCD(16,4),'#13#10'PrecioMedio1 BCD(16,4),'#13#10'MargenMe' +
          'dio1 BCD(16,4),'#13#10'Porcentaje1 SMALLINT,'#13#10'SumaImporte1 BCD(16,4), ' +
          '   '#13#10'Unidades2 BCD(16,4),'#13#10'Importe2 BCD(16,4),'#13#10'ImporteCoste2 BC' +
          'D(16,4),'#13#10'PrecioCoste2 BCD(16,4),'#13#10'PrecioMedio2 BCD(16,4),'#13#10'Marg' +
          'enMedio2 BCD(16,4),'#13#10'Porcentaje2 SMALLINT,'#13#10'SumaImporte2 BCD(16,' +
          '4) );'#13#10#13#10'CREATE INDEX Index0 ON <TableName> ( ID );'#13#10'CREATE INDE' +
          'X Index1 ON <TableName> ( Importe1 DESC );'#13#10'CREATE INDEX Index2 ' +
          'ON <TableName> ( Importe2 DESC );'#13#10'CREATE INDEX Index3 ON <Table' +
          'Name> ( CodigoAgrupacion, SumaImporte1 DESC, Importe1 DESC );'#13#10'C' +
          'REATE INDEX Index4 ON <TableName> ( CodigoAgrupacion, SumaImport' +
          'e2 DESC, Importe2 DESC );'#13#10'CREATE INDEX Index5 ON <TableName> ( ' +
          'CodigoFamilia, Codigo );    '#13#10'  '#13#10'  '#13#10'  '#13#10
      end
      item
        Title = 'CarteraArticulos'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'NroRegistro INTEGER,'#13#10'CodigoAlmacen ' +
          'NVARCHAR(2),'#13#10'CodigoArticulo NVARCHAR(20),'#13#10'CodigoClaseA NVARCHA' +
          'R(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'Des' +
          'cripcion NVARCHAR(60),'#13#10'NombreAlmacen NVARCHAR(30),'#13#10'Tipo SMALLI' +
          'NT,'#13#10'NroCajas BCD(16,4),'#13#10'Cantidad BCD(16,4),'#13#10'Precio Double Pre' +
          'cision,'#13#10'EcoTasa BCD(16,4),'#13#10'Descuento BCD(16,4),'#13#10'Recargo BCD(1' +
          '6,4),'#13#10'NroCajas2 BCD(16,4) ,'#13#10'Cantidad2 BCD(16,4),'#13#10'Precio2 Doub' +
          'le Precision,'#13#10'Descuento2 BCD(16,4),'#13#10'Recargo2 BCD(16,4),'#13#10'Impor' +
          'teNeto BCD(16,4),'#13#10'Existencias BCD(16,4),'#13#10'ExistenciasVirtuales ' +
          'BCD(16,4),'#13#10'Coste BCD(16,4),'#13#10'Bultos BCD(16,4),'#13#10'Kilos BCD(16,4)' +
          ','#13#10'Volumen BCD(16,4) ,'#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(40),' +
          #13#10'NroDocumento INTEGER,'#13#10'NroOperacion INTEGER,'#13#10'CodigoPropietari' +
          'o NVARCHAR(5),'#13#10'NombrePropietario NVARCHAR(40),'#13#10'Fecha DATE,'#13#10'Fe' +
          'chaAplicacion DATE );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Co' +
          'digoAlmacen, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoC' +
          'laseC, Tipo );'#13#10'CREATE INDEX Index2 ON <TableName> ( Cantidad DE' +
          'SC );'#13#10'CREATE INDEX Index3 ON <TableName> ( CodigoPropietario, E' +
          'jercicio, Serie, NroDocumento );'#13#10'CREATE INDEX Index4 ON <TableN' +
          'ame> ( Descripcion );'#13#10#13#10
      end
      item
        Title = 'CabeceraFactura'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'NroOperacion INTEGER,'#13#10'CodigoPropiet' +
          'ario NVARCHAR(5),'#13#10'Nombre NVARCHAR(40),'#13#10'CodigoGrupo NVARCHAR(5)' +
          ','#13#10'DescripcionGrupo NVARCHAR(40),'#13#10'Fecha DATE,'#13#10'Serie NVARCHAR(4' +
          '0),'#13#10'NroFactura INTEGER,'#13#10'Ejercicio SMALLINT,'#13#10'Traspasada BOOLEA' +
          'N,'#13#10'BrutoArticulos BCD(16,4),'#13#10'DescuentoArticulos BCD(16,4),'#13#10'De' +
          'scuentoPropietario BCD(16,4),'#13#10'NetoFactura BCD(16,4),'#13#10'CuotaIVA ' +
          'BCD(16,4),'#13#10'TotalFactura BCD(16,4) );'#13#10#13#10'CREATE INDEX Index1 ON ' +
          '<TableName> ( Fecha, Serie, NroFactura );'#13#10'CREATE INDEX Index2 O' +
          'N <TableName> ( CodigoPropietario, Fecha, Serie, NroFactura );'#13#10 +
          'CREATE INDEX Index3 ON <TableName> ( CodigoGrupo, Fecha, Serie, ' +
          'NroFactura );'#13#10
      end
      item
        Title = 'LineasFactura'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'NroOperacion INTEGER,'#13#10'Fecha DATE,'#13#10 +
          'Serie NVARCHAR(40),'#13#10'NroDocumento INTEGER,'#13#10'BrutoArticulos BCD(1' +
          '6,4),'#13#10'DescuentoArticulos BCD(16,4),'#13#10'NetoAlbaran BCD(16,4),'#13#10'Cu' +
          'otaIVA BCD(16,4),'#13#10'TotalAlbaran BCD(16,4) );'#13#10#13#10'CREATE INDEX Ind' +
          'ex1 ON <TableName> ( NroOperacion );'#13#10
      end
      item
        Title = 'Cabecera'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    NroOperacion Integer,'#13#10'    Serie' +
          ' NVARCHAR(40),'#13#10'    NroDocumento Integer,'#13#10'    Ejercicio SmallIn' +
          't,'#13#10'    Nro_Operacion Integer,'#13#10'    NroCopia SmallInt,'#13#10'    Codi' +
          'goPropietario NVARCHAR(5),'#13#10'    FechaDocumento Date,'#13#10'    Fecha1' +
          ' Date,'#13#10'    Fecha2 Date,'#13#10'    Creado Date,'#13#10'    NroDocPropietari' +
          'o NVARCHAR(15),'#13#10'    NroDocumentoOrigen Integer,'#13#10'    CodigoVend' +
          'edor NVARCHAR(2),'#13#10'    CodigoRegAuxiliar NVARCHAR(3),'#13#10'    Codig' +
          'oGrupo NVARCHAR(3),'#13#10'    CodigoDivisa NVARCHAR(3),'#13#10'    Descripc' +
          'ionDivisa NVARCHAR(30),'#13#10'    TipoCambio BCD(16,4),'#13#10'    Precisio' +
          'nDivisa BCD(16,4),'#13#10'    DescuentoPP BCD(16,4) ,'#13#10'    ImporteDtoP' +
          'P BCD(16,4),'#13#10'    DescuentoES BCD(16,4),'#13#10'    ImporteDtoES BCD(1' +
          '6,4),'#13#10'    CosteArticulos BCD(16,4),'#13#10'    BrutoArticulos BCD(16,' +
          '4),'#13#10'    DescuentoArticulos BCD(16,4),'#13#10'    DescuentoPropietario' +
          ' BCD(16,4),'#13#10'    ImportePuntoVerde BCD(16,4),'#13#10'    NetoArticulos' +
          ' BCD(16,4),'#13#10'    ImporteNeto BCD(16,4),'#13#10'    CuotaIVA BCD(16,4),' +
          #13#10'    CuotaRE BCD(16,4),'#13#10'    ImporteComision BCD(16,4),'#13#10'    Pr' +
          'imerTipoIVA BCD(16,4),'#13#10'    PrimerTipoRE BCD(16,4),'#13#10'    TotalAC' +
          'uenta BCD(16,4),'#13#10'    TotalACuentaPedidos BCD(16,4),'#13#10'    Codigo' +
          'FormaPago NVARCHAR(2),'#13#10'    DescripcionFormaPago NVARCHAR(30),'#13#10 +
          '    BaseImponible1 BCD(16,4),'#13#10'    BaseImponible2 BCD(16,4),'#13#10'  ' +
          '  BaseImponible3 BCD(16,4),'#13#10'    BaseImponible4 BCD(16,4),'#13#10'    ' +
          'BaseImponible5 BCD(16,4) ,'#13#10'    BaseImponible6 BCD(16,4),'#13#10'    T' +
          'ipoIVA1 BCD(16,4),'#13#10'    TipoIVA2 BCD(16,4),'#13#10'    TipoIVA3 BCD(16' +
          ',4),'#13#10'    TipoIVA4 BCD(16,4),'#13#10'    TipoIVA5 BCD(16,4),'#13#10'    Tipo' +
          'IVA6 BCD(16,4),'#13#10'    CuotaIVA1 BCD(16,4),'#13#10'    CuotaIVA2 BCD(16,' +
          '4),'#13#10'    CuotaIVA3 BCD(16,4),'#13#10'    CuotaIVA4 BCD(16,4),'#13#10'    Cuo' +
          'taIVA5 BCD(16,4),'#13#10'    CuotaIVA6 BCD(16,4),'#13#10'    TipoRE1 BCD(16,' +
          '4),'#13#10'    TipoRE2 BCD(16,4),'#13#10'    TipoRE3 BCD(16,4),'#13#10'    TipoRE4' +
          ' BCD(16,4),'#13#10'    TipoRE5 BCD(16,4),'#13#10'    TipoRE6 BCD(16,4),'#13#10'   ' +
          ' CuotaRE1 BCD(16,4),'#13#10'    CuotaRE2 BCD(16,4),'#13#10'    CuotaRE3 BCD(' +
          '16,4),'#13#10'    CuotaRE4 BCD(16,4),'#13#10'    CuotaRE5 BCD(16,4),'#13#10'    Cu' +
          'otaRE6 BCD(16,4),'#13#10'    ImporteTotal1 BCD(16,4),'#13#10'    ImporteTota' +
          'l2 BCD(16,4),'#13#10'    ImporteTotal3 BCD(16,4),'#13#10'    ImporteTotal4 B' +
          'CD(16,4),'#13#10'    ImporteTotal5 BCD(16,4),'#13#10'    ImporteTotal6 BCD(1' +
          '6,4),'#13#10'    TipoRetencion SmallInt,'#13#10'    BaseCalculoRetencion BCD' +
          '(16,4),'#13#10'    ImporteRetencion BCD(16,4),'#13#10'    ImporteTotal BCD(1' +
          '6,4),'#13#10'    FechaVencimiento1 Date,'#13#10'    FechaVencimiento2 Date,'#13 +
          #10'    FechaVencimiento3 Date,'#13#10'    FechaVencimiento4 Date,'#13#10'    F' +
          'echaVencimiento5 Date,'#13#10'    FechaVencimiento6 Date,'#13#10'    Importe' +
          'Vencimiento1 BCD(16,4),'#13#10'    ImporteVencimiento2 BCD(16,4),'#13#10'   ' +
          ' ImporteVencimiento3 BCD(16,4),'#13#10'    ImporteVencimiento4 BCD(16,' +
          '4),'#13#10'    ImporteVencimiento5 BCD(16,4),'#13#10'    ImporteVencimiento6' +
          ' BCD(16,4),'#13#10'    SumaIVAyRE BCD(16,4),'#13#10'    SumaBultos BCD(16,4)' +
          ','#13#10'    SumaKilos BCD(16,4),'#13#10'    SumaVolumen BCD(16,4),'#13#10'    Sum' +
          'aCajas BCD(16,4),'#13#10'    SumaPallets BCD(16,4),'#13#10'    ImporteCifra ' +
          'NVARCHAR(128),'#13#10'    PorcentajeRetencion BCD(16,4),'#13#10'    Portes B' +
          'CD(16,4) ,'#13#10'    CuotaIVAPortes BCD(16,4),'#13#10'    CuotaREPortes BCD' +
          '(16,4),'#13#10'    PorcentajeRecFinanc BCD(16,4),'#13#10'    RecargoFinancie' +
          'ro BCD(16,4),'#13#10'    CodigoTransportista NVARCHAR(2),'#13#10'    CodigoE' +
          'mpresa NVARCHAR(3),'#13#10'    TotalEntrega BCD(16,4),'#13#10'    CampoLibre' +
          '1 NVARCHAR(40),'#13#10'    CampoLibre2 NVARCHAR(40),'#13#10'    Anotacion NC' +
          'LOB'#13#10');'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( NroOperacion );'#13 +
          #10
      end
      item
        Title = 'Lineas'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    NroOperacion Integer,'#13#10'    NroPa' +
          'gina SmallInt,'#13#10'    NroLinea SmallInt,'#13#10'    NroRegistro SmallInt' +
          ','#13#10'    NroOperacionDoc Integer,'#13#10'    NroRegistroDoc Integer,'#13#10'  ' +
          '  Fecha Date,'#13#10'    AsignacionOrigen SmallInt,'#13#10'    TipoMovimient' +
          'oOrigen SmallInt,'#13#10'    EjercicioOrigen SmallInt,'#13#10'    NroOperaci' +
          'onOrigen Integer,'#13#10'    NroRegistroOrigen Integer,'#13#10'    Ejercicio' +
          'Documento SmallInt,'#13#10'    SerieDocumento NVARCHAR(40),'#13#10'    NroDo' +
          'cumento Integer,'#13#10'    CodigoArticulo NVARCHAR(20),'#13#10'    Referenc' +
          'ia NVARCHAR(20),'#13#10'    CodigoClaseA NVARCHAR(3),'#13#10'    Descripcion' +
          'ClaseA NVARCHAR(30),'#13#10'    CodigoClaseB NVARCHAR(3),'#13#10'    Descrip' +
          'cionClaseB NVARCHAR(30),'#13#10'    CodigoClaseC NVARCHAR(3),'#13#10'    Des' +
          'cripcionClaseC NVarChar(30),'#13#10'    Descripcion NVARCHAR(60),'#13#10'   ' +
          ' Anotacion NCLOB,'#13#10'    LoteFabricacion NVARCHAR(20),'#13#10'    Numero' +
          'Serie NVARCHAR(20),'#13#10'    TipoLinea NVARCHAR(2),'#13#10'    CodigoAlmac' +
          'en NVARCHAR(2),'#13#10'    CodigoUbicacion NVARCHAR(6),'#13#10'    Largo BCD' +
          '(16,4),'#13#10'    Ancho BCD(16,4),'#13#10'    Alto BCD(16,4) ,'#13#10'    Cantida' +
          'd BCD(16,4),'#13#10'    Precio Double Precision,'#13#10'    PrecioDivisa BCD' +
          '(16,4),'#13#10'    ImporteBruto BCD(16,4),'#13#10'    PuntoVerde BCD(16,4),'#13 +
          #10'    Recargo BCD(16,4),'#13#10'    Descuento BCD(16,4),'#13#10'    ImportePu' +
          'ntoVerde BCD(16,4),'#13#10'    ImporteDescuento BCD(16,4),'#13#10'    Import' +
          'eNeto BCD(16,4),'#13#10'    CodigoTipoIVA SmallInt,'#13#10'    TipoIVA BCD(1' +
          '6,4),'#13#10'    CuotaIVA BCD(16,4),'#13#10'    CodigoTipoRE SmallInt,'#13#10'    ' +
          'TipoRE BCD(16,4),'#13#10'    CuotaRE BCD(16,4),'#13#10'    TotalLinea BCD(16' +
          ',4),'#13#10'    PrecioIVAIncluido BCD(16,4),'#13#10'    TotalBultos BCD(16,4' +
          ') ,'#13#10'    TotalKilos BCD(16,4),'#13#10'    TotalVolumen BCD(16,4),'#13#10'   ' +
          ' TotalPallets BCD(16,4),'#13#10'    NroCajas BCD(16,4),'#13#10'    CantidadP' +
          'rocesada BCD(16,4),'#13#10'    Cargado BCD(16,4),'#13#10'    EnvasesDeposito' +
          ' BCD(16,4)'#13#10');'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( NroOperac' +
          'ion );'#13#10'CREATE INDEX Index2 ON <TableName> ( NroOperacion, NroPa' +
          'gina, NroLinea );'#13#10'CREATE INDEX Index3 ON <TableName> ( Ejercici' +
          'oDocumento, NroOperacionDoc, NroRegistro );'#13#10'CREATE INDEX Index4' +
          ' ON <TableName> ( NroRegistroDoc );'#13#10'CREATE INDEX Index5 ON <Tab' +
          'leName> ( NroOperacion, NroOperacionDoc, NroPagina );    '#13#10
      end
      item
        Title = 'EtiquetaArticulo'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    Codigo NVARCHAR(20),'#13#10'    NroReg' +
          'istro Integer,'#13#10'    ReferenciaProveedor NVARCHAR(20),'#13#10'    Refer' +
          'enciaCliente NVARCHAR(20),'#13#10'    CodigoClaseA NVARCHAR(3),'#13#10'    D' +
          'escripcionClaseA NVARCHAR(30),'#13#10'    CodigoClaseB NVARCHAR(3),'#13#10' ' +
          '   DescripcionClaseB NVARCHAR(30),'#13#10'    CodigoClaseC NVARCHAR(3)' +
          ','#13#10'    DescripcionClaseC NVARCHAR(30),'#13#10'    Descripcion NVarChar' +
          '(60),'#13#10'    Anotacion NCLOB,'#13#10'    CodigoBarras NVARCHAR(20),'#13#10'   ' +
          ' LoteFabricacion NVARCHAR(20),'#13#10'    NumeroSerie NVARCHAR(20),'#13#10' ' +
          '   CodigoAlmacen NVARCHAR(2),'#13#10'    Ubicacion NVARCHAR(6),'#13#10'    T' +
          'ipoLinea NVARCHAR(2),'#13#10'    Cantidad BCD(16,4),'#13#10'    PrecioVenta ' +
          'BCD(16,4),'#13#10'    PuntoVerde BCD(16,4),'#13#10'    RecargoVenta BCD(16,4' +
          '),'#13#10'    TipoIVA BCD(16,4),'#13#10'    Descuento BCD(16,4),'#13#10'    Precio' +
          'IVAIncluido BCD(16,4) ,'#13#10'    NroBultoLinea BCD(16,4),'#13#10'    NroBu' +
          'ltoAlbaran BCD(16,4),'#13#10'    Bultos BCD(16,4),'#13#10'    Volumen BCD(16' +
          ',4),'#13#10'    Kilos BCD(16,4),'#13#10'    NroBultosLinea BCD(16,4),'#13#10'    V' +
          'olumenLinea BCD(16,4),'#13#10'    KilosLinea BCD(16,4),'#13#10'    NroBultos' +
          'Albaran BCD(16,4),'#13#10'    VolumenAlbaran BCD(16,4),'#13#10'    KilosAlba' +
          'ran BCD(16,4),'#13#10'    Cliente_Codigo NVARCHAR(5),'#13#10'    Proveedor_C' +
          'odigo NVARCHAR(5),'#13#10'    EjercicioAlbaran SmallInt,'#13#10'    NroOpera' +
          'cionAlbaran Integer,'#13#10'    FechaAlbaran Date,'#13#10'    SerieAlbaran N' +
          'VARCHAR(40),'#13#10'    NroAlbaran Integer,'#13#10'    NroLineaAlbaran Small' +
          'Int,'#13#10'    EjercicioPedido SmallInt,'#13#10'    NroOperacionPedido Inte' +
          'ger,'#13#10'    NroPedido Integer,'#13#10'    NroLineaPedido SmallInt,'#13#10'    ' +
          'CodigoVendedor NVARCHAR(2),'#13#10'    RegistroAuxiliar NVARCHAR(3),'#13#10 +
          '    GrupoCliente NVARCHAR(3)'#13#10');'#13#10
      end
      item
        Title = 'EtiquetaPostal'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    Codigo NVARCHAR(5),'#13#10'    Nombre ' +
          'NVARCHAR(40),'#13#10'    Domicilio NVARCHAR(40),'#13#10'    Localidad NVARCH' +
          'AR(30),'#13#10'    CodigoPais NVARCHAR(3),'#13#10'    NombrePais NVARCHAR(30' +
          '),'#13#10'    CP NVARCHAR(5),'#13#10'    Provincia NVARCHAR(30)'#13#10');'#13#10
      end
      item
        Title = 'Paginas'
        SQLText = 
          'CREATE TABLE <TableName> ('#13#10'    EjercicioDocumento SmallInt,'#13#10'  ' +
          '  NroOperacion Integer,'#13#10'    NroPagina SmallInt,                ' +
          '                           '#13#10'    NroOperacionDoc Integer,'#13#10'    C' +
          'odigoGrupo NVARCHAR(2),'#13#10'    Descripcion NVARCHAR(30),          ' +
          '                                               '#13#10'    Anotacion N' +
          'CLOB                                    '#13#10');'#13#10#13#10'CREATE INDEX Ind' +
          'ex1 ON <TableName> ( NroOperacion );'#13#10'CREATE INDEX Index2 ON <Ta' +
          'bleName> ( NroOperacion, NroPagina );    '#13#10'CREATE INDEX Index3 O' +
          'N <TableName> ( EjercicioDocumento, NroOperacionDoc, NroPagina )' +
          ';'#13#10'  '#13#10
      end>
    Left = 48
    Top = 88
  end
  object DetailSourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 161
    Top = 88
  end
  object MasterSourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 160
    Top = 24
  end
  object SourceTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 269
    Top = 24
  end
  object TargetTable: TnxeTable
    Timeout = 6000
    TableType = ttRecover
    Left = 269
    Top = 86
  end
end
