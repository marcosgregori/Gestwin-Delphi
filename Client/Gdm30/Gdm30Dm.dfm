object DataModule30: TDataModule30
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 186
  Width = 131
  object Dictionary: TnxeDatabaseDictionary
    Session = DataAccessModule.MainSession
    AliasPath = 'F:\Gestwin\dm30'
    TargetDatabase = EnterpriseDataModule.UserDatabase
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
          '_MESSAGE;'#13#10'   END;'#13#10'   '#13#10'END;'#13#10'  '#13#10'// Bitwise AND'#13#10#13#10'DROP ROUTIN' +
          'E IF EXISTS "BITAND";'#13#10#13#10'CREATE FUNCTION BITAND (N1 INTEGER, N2 ' +
          'INTEGER) RETURNS INTEGER'#13#10'BEGIN'#13#10'   DECLARE ReturnValue, S Integ' +
          'er DEFAULT 0;'#13#10#13#10'   WHILE N1 > 0 AND N2 > 0 AND S < 32 DO'#13#10'     ' +
          ' SET ReturnValue = ReturnValue + MOD( N1, 2 ) * MOD( N2, 2 ) * P' +
          'OWER( 2, S );'#13#10'       SET N1 = N1 / 2;'#13#10'       SET N2 = N2 / 2;'#13 +
          #10'       SET S = S + 1;'#13#10'    END WHILE;'#13#10#13#10'    RETURN ReturnValue' +
          ';'#13#10'END;                                                  '#13#10'    '#13 +
          #10'// Limpieza de funciones obsoletas'#13#10#13#10'DROP ROUTINE IF EXISTS "A' +
          'rticuloKilos";'#13#10'DROP ROUTINE IF EXISTS "ArticuloTipoIVA";'#13#10#13#10#13#10#13 +
          #10'  '#13#10
      end>
    Left = 46
    Top = 25
  end
  object SQLSet: TgxSQLSet
    SQLItems = <
      item
        Title = 'Existencias'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'CodigoArti' +
          'culo NVARCHAR(20),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVAR' +
          'CHAR(3),'#13#10'CodigoClaseC NVarChar(3),'#13#10'Descripcion NVARCHAR(60),'#13#10 +
          'LoteFabricacion NVARCHAR(20),'#13#10'CodigoAlmacen NVARCHAR(2),'#13#10'Codig' +
          'oFamilia NVARCHAR(6),'#13#10'DescripcionFamilia NVARCHAR(40),'#13#10'Entrada' +
          's BCD(16,4),'#13#10'Salidas BCD(16,4),'#13#10'Existencias BCD(16,4),'#13#10'Pendie' +
          'nteRecibir BCD(16,4) ,'#13#10'PendienteServir BCD(16,4),'#13#10'StockMinimo ' +
          'BCD(16,4),'#13#10'StockMaximo BCD(16,4),'#13#10'Coste BCD(16,4) );'#13#10#13#10'CREATE' +
          ' INDEX Index1 ON <TableName> ( CodigoArticulo, CodigoClaseA, Cod' +
          'igoClaseB, CodigoClaseC );'#13#10'CREATE INDEX Index2 ON <TableName> (' +
          ' CodigoFamilia, CodigoArticulo, CodigoClaseA, CodigoClaseB, Codi' +
          'goClaseC );'#13#10'CREATE INDEX Index3 ON <TableName> ( Descripcion );' +
          #13#10'CREATE INDEX Index4 ON <TableName> ( CodigoFamilia, Descripcio' +
          'n );'#13#10
      end
      item
        Title = 'Consumos'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'ID NVARCHA' +
          'R(30),'#13#10'Tipo SMALLINT,'#13#10'CodigoAgrupacion NVARCHAR(20),    '#13#10'Codi' +
          'go NVARCHAR(20),'#13#10'Descripcion NVARCHAR(60),'#13#10'CodigoFamilia NVARC' +
          'HAR(6),'#13#10'DescripcionFamilia NVARCHAR(30),'#13#10'CodigoPropietario NVA' +
          'RCHAR(5),'#13#10'Nombre NVARCHAR(40),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'Codi' +
          'goClaseB NVarChar(3),'#13#10'CodigoClaseC NVARCHAR(3),'#13#10'CodigoGrupo NV' +
          'ARCHAR(3),'#13#10'DescripcionGrupo NVARCHAR(30),'#13#10'CodigoAlmacen NVARCH' +
          'AR(2),'#13#10'Periodo SMALLINT,'#13#10'Unidades1 BCD(16,4),'#13#10'Importe1 BCD(16' +
          ',4),'#13#10'ImporteCoste1 BCD(16,4),'#13#10'ImporteDescuentos1 BCD(16,4),   ' +
          ' '#13#10'PrecioCoste1 BCD(16,4),'#13#10'PrecioMedio1 BCD(16,4),'#13#10'MargenMedio' +
          '1 BCD(16,4),'#13#10'Porcentaje1 SMALLINT,'#13#10'SumaImporte1 BCD(16,4),    ' +
          #13#10'Unidades2 BCD(16,4),'#13#10'Importe2 BCD(16,4),'#13#10'ImporteCoste2 BCD(1' +
          '6,4),'#13#10'ImporteDescuentos2 BCD(16,4),    '#13#10'PrecioCoste2 BCD(16,4)' +
          ','#13#10'PrecioMedio2 BCD(16,4),'#13#10'MargenMedio2 BCD(16,4),'#13#10'Porcentaje2' +
          ' SMALLINT,'#13#10'SumaImporte2 BCD(16,4) );'#13#10#13#10'CREATE INDEX Index0 ON ' +
          '<TableName> ( ID );'#13#10'CREATE INDEX Index1 ON <TableName> ( Import' +
          'e1 DESC );'#13#10'CREATE INDEX Index2 ON <TableName> ( Importe2 DESC )' +
          ';'#13#10'CREATE INDEX Index3 ON <TableName> ( CodigoAgrupacion, SumaIm' +
          'porte1 DESC, Importe1 DESC );'#13#10'CREATE INDEX Index4 ON <TableName' +
          '> ( CodigoAgrupacion, SumaImporte2 DESC, Importe2 DESC );'#13#10'CREAT' +
          'E INDEX Index5 ON <TableName> ( CodigoFamilia, Codigo );    '#13#10'  ' +
          #13#10'  '#13#10'  '#13#10
      end
      item
        Title = 'CarteraArticulos'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'NroRegistr' +
          'o INTEGER,'#13#10'CodigoAlmacen NVARCHAR(2),'#13#10'CodigoArticulo NVARCHAR(' +
          '20),'#13#10'CodigoClaseA NVARCHAR(3),'#13#10'CodigoClaseB NVARCHAR(3),'#13#10'Codi' +
          'goClaseC NVARCHAR(3),'#13#10'CodigoFamilia NVARCHAR(6),    '#13#10'Descripci' +
          'on NVARCHAR(60),'#13#10'NombreAlmacen NVARCHAR(30),'#13#10'Tipo SMALLINT,'#13#10'N' +
          'roCajas BCD(16,4),'#13#10'Cantidad BCD(16,4),'#13#10'Precio Double Precision' +
          ','#13#10'EcoTasa BCD(16,4),'#13#10'ImporteBruto BCD(16,4),    '#13#10'Descuento BC' +
          'D(16,4),'#13#10'Recargo BCD(16,4),'#13#10'ImporteNeto BCD(16,4),'#13#10'Pendiente ' +
          'BCD(16,4) ,    '#13#10'Existencias BCD(16,4),'#13#10'ExistenciasVirtuales BC' +
          'D(16,4),'#13#10'Coste BCD(16,4),'#13#10'Bultos BCD(16,4),'#13#10'Kilos BCD(16,4),'#13 +
          #10'Volumen BCD(16,4),'#13#10'Ejercicio SMALLINT,'#13#10'Serie NVARCHAR(40),'#13#10'N' +
          'roDocumento INTEGER,'#13#10'NroOperacion INTEGER,'#13#10'CodigoPropietario N' +
          'VARCHAR(5),'#13#10'NombrePropietario NVARCHAR(40),'#13#10'Fecha DATE,'#13#10'Fecha' +
          'Aplicacion DATE );'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( Codig' +
          'oAlmacen, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClas' +
          'eC, Tipo );'#13#10'CREATE INDEX Index2 ON <TableName> ( Cantidad DESC ' +
          ');'#13#10'CREATE INDEX Index3 ON <TableName> ( CodigoPropietario, Ejer' +
          'cicio, Serie, NroDocumento );'#13#10'CREATE INDEX Index4 ON <TableName' +
          '> ( CodigoAlmacen, CodigoFamilia, CodigoArticulo, CodigoClaseA, ' +
          'CodigoClaseB, CodigoClaseC, Tipo );  '#13#10
      end
      item
        Title = 'CabeceraFactura'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'NroOperaci' +
          'on INTEGER,'#13#10'CodigoPropietario NVARCHAR(5),'#13#10'Nombre NVARCHAR(40)' +
          ','#13#10'CodigoGrupo NVARCHAR(5),'#13#10'DescripcionGrupo NVARCHAR(40),'#13#10'Fec' +
          'ha DATE,'#13#10'Serie NVARCHAR(40),'#13#10'NroFactura INTEGER,'#13#10'Ejercicio SM' +
          'ALLINT,'#13#10'Traspasada BOOLEAN,'#13#10'BrutoArticulos BCD(16,4),'#13#10'Descuen' +
          'toArticulos BCD(16,4) ,'#13#10'DescuentoPropietario BCD(16,4),'#13#10'TotalE' +
          'coTasa BCD(16,4),    '#13#10'NetoFactura BCD(16,4),'#13#10'CuotaIVA BCD(16,4' +
          '),'#13#10'TotalFactura BCD(16,4) );'#13#10#13#10'CREATE INDEX Index1 ON <TableNa' +
          'me> ( Fecha, Serie, NroFactura );'#13#10'CREATE INDEX Index2 ON <Table' +
          'Name> ( CodigoPropietario, Fecha, Serie, NroFactura );'#13#10'CREATE I' +
          'NDEX Index3 ON <TableName> ( CodigoGrupo, Fecha, Serie, NroFactu' +
          'ra );'#13#10
      end
      item
        Title = 'LineasFactura'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'NroOperaci' +
          'on INTEGER,'#13#10'Ejercicio SMALLINT,                                ' +
          '                 '#13#10'NroOperacionMovimiento INTEGER,    '#13#10'Fecha DA' +
          'TE,'#13#10'Serie NVARCHAR(40),'#13#10'NroDocumento INTEGER,'#13#10'BrutoArticulos ' +
          'BCD(16,4),'#13#10'DescuentoArticulos BCD(16,4),'#13#10'NetoAlbaran BCD(16,4)' +
          ','#13#10'CuotaIVA BCD(16,4) ,'#13#10'TotalAlbaran BCD(16,4) );'#13#10#13#10'CREATE IND' +
          'EX Index1 ON <TableName> ( NroOperacion );'#13#10
      end
      item
        Title = 'Cabecera'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'    Regist' +
          'roProcesado BOOLEAN,'#13#10'    TipoMovimiento SMALLINT,              ' +
          '                                           '#13#10'    NroOperacion IN' +
          'TEGER,'#13#10'    Serie NVARCHAR(40),'#13#10'    NroDocumento INTEGER,'#13#10'    ' +
          'Ejercicio SMALLINT,'#13#10'    Nro_Operacion INTEGER,'#13#10'    NroCopia SM' +
          'ALLINT,'#13#10'    CodigoPropietario NVARCHAR(5),'#13#10'    FechaDocumento ' +
          'DATE,'#13#10'    Fecha1 DATE,'#13#10'    Fecha2 DATE,'#13#10'    Creado DATE,     ' +
          '                                                '#13#10'    NroDocProp' +
          'ietario NVARCHAR(15),'#13#10'    Origen SMALLINT,'#13#10'    EjercicioOrigen' +
          ' SMALLINT,                                                      ' +
          '   '#13#10'    NroOperacionOrigen INTEGER,      '#13#10'    CodigoVendedor N' +
          'VARCHAR(2),'#13#10'    CodigoRegAuxiliar NVARCHAR(3),'#13#10'    CodigoGrupo' +
          ' NVARCHAR(3),'#13#10'    OrganismoPublico NVARCHAR(12),'#13#10'    OrganoPro' +
          'ponente NVARCHAR(12),                                           ' +
          '                 '#13#10'    NumeroExpediente NVARCHAR(20),'#13#10'    Numer' +
          'oContrato NVARCHAR(20),'#13#10'    ReferenciaOperacion NVARCHAR(20),  ' +
          '        '#13#10'    ServicioPrestadoTemporalmente Boolean,            ' +
          '  '#13#10'    InicioPeriodoFacturacion DATE,        '#13#10'    FinPeriodoFa' +
          'cturacion DATE,'#13#10'    Subvencionada BOOLEAN,'#13#10'    ImporteSubvenci' +
          'on BCD(16,4),        '#13#10'    CodigoDivisa NVARCHAR(3),'#13#10'    Descri' +
          'pcionDivisa NVARCHAR(30),'#13#10'    TipoCambio BCD(16,4),'#13#10'    Precis' +
          'ionDivisa BCD(16,4) ,'#13#10'    DescuentoPP BCD(16,4),'#13#10'    ImporteDt' +
          'oPP BCD(16,4),'#13#10'    DescuentoES BCD(16,4),'#13#10'    ImporteDtoES BCD' +
          '(16,4),'#13#10'    CosteArticulos BCD(16,4),'#13#10'    BrutoArticulos BCD(1' +
          '6,4) ,'#13#10'    DescuentoArticulos BCD(16,4),'#13#10'    DescuentoPropieta' +
          'rio BCD(16,4),'#13#10'    ImportePuntoVerde BCD(16,4),        '#13#10'    Ne' +
          'toArticulos BCD(16,4),'#13#10'    ImporteNeto BCD(16,4),'#13#10'    CuotaIVA' +
          ' BCD(16,4),'#13#10'    CuotaRE BCD(16,4),'#13#10'    ImporteComision BCD(16,' +
          '4),'#13#10'    PrimerTipoIVA BCD(16,4),'#13#10'    PrimerTipoRE BCD(16,4),'#13#10 +
          '    EntregaACuenta BCD(16,4),        '#13#10'    TotalACuenta BCD(16,4' +
          '),'#13#10'    TotalACuentaPedidos BCD(16,4),'#13#10'    CodigoFormaPago NVAR' +
          'CHAR(2),'#13#10'    DescripcionFormaPago NVARCHAR(30),'#13#10'    BIC NVARCH' +
          'AR(11),        '#13#10'    IBAN NVARCHAR(34),        '#13#10'    BaseImponib' +
          'le1 BCD(16,4) ,'#13#10'    BaseImponible2 BCD(16,4),'#13#10'    BaseImponibl' +
          'e3 BCD(16,4) ,'#13#10'    BaseImponible4 BCD(16,4),'#13#10'    BaseImponible' +
          '5 BCD(16,4),'#13#10'    BaseImponible6 BCD(16,4),'#13#10'    BaseImponible7 ' +
          'BCD(16,4),'#13#10'    BaseImponible8 BCD(16,4),'#13#10'    BaseImponible9 BC' +
          'D(16,4),'#13#10'    BaseImponible10 BCD(16,4),'#13#10'    BaseImponible11 BC' +
          'D(16,4),'#13#10'    BaseImponible12 BCD(16,4),        '#13#10'    TipoIVA1 B' +
          'CD(16,4),'#13#10'    TipoIVA2 BCD(16,4),'#13#10'    TipoIVA3 BCD(16,4),'#13#10'   ' +
          ' TipoIVA4 BCD(16,4),'#13#10'    TipoIVA5 BCD(16,4),'#13#10'    TipoIVA6 BCD(' +
          '16,4),'#13#10'    TipoIVA7 BCD(16,4),'#13#10'    TipoIVA8 BCD(16,4),'#13#10'    Ti' +
          'poIVA9 BCD(16,4),'#13#10'    TipoIVA10 BCD(16,4),'#13#10'    TipoIVA11 BCD(1' +
          '6,4),'#13#10'    TipoIVA12 BCD(16,4),        '#13#10'    CuotaIVA1 BCD(16,4)' +
          ','#13#10'    CuotaIVA2 BCD(16,4),'#13#10'    CuotaIVA3 BCD(16,4),'#13#10'    Cuota' +
          'IVA4 BCD(16,4),'#13#10'    CuotaIVA5 BCD(16,4),'#13#10'    CuotaIVA6 BCD(16,' +
          '4),'#13#10'    CuotaIVA7 BCD(16,4),'#13#10'    CuotaIVA8 BCD(16,4),'#13#10'    Cuo' +
          'taIVA9 BCD(16,4),'#13#10'    CuotaIVA10 BCD(16,4),'#13#10'    CuotaIVA11 BCD' +
          '(16,4),'#13#10'    CuotaIVA12 BCD(16,4),          '#13#10'    TipoRE1 BCD(16' +
          ',4),'#13#10'    TipoRE2 BCD(16,4),'#13#10'    TipoRE3 BCD(16,4),'#13#10'    TipoRE' +
          '4 BCD(16,4),'#13#10'    TipoRE5 BCD(16,4),'#13#10'    TipoRE6 BCD(16,4),'#13#10'  ' +
          '  TipoRE7 BCD(16,4),'#13#10'    TipoRE8 BCD(16,4),'#13#10'    TipoRE9 BCD(16' +
          ',4),'#13#10'    TipoRE10 BCD(16,4),'#13#10'    TipoRE11 BCD(16,4),'#13#10'    Tipo' +
          'RE12 BCD(16,4),        '#13#10'    CuotaRE1 BCD(16,4),'#13#10'    CuotaRE2 B' +
          'CD(16,4),'#13#10'    CuotaRE3 BCD(16,4),'#13#10'    CuotaRE4 BCD(16,4),'#13#10'   ' +
          ' CuotaRE5 BCD(16,4),'#13#10'    CuotaRE6 BCD(16,4),'#13#10'    CuotaRE7 BCD(' +
          '16,4),'#13#10'    CuotaRE8 BCD(16,4),'#13#10'    CuotaRE9 BCD(16,4),'#13#10'    Cu' +
          'otaRE10 BCD(16,4),'#13#10'    CuotaRE11 BCD(16,4),'#13#10'    CuotaRE12 BCD(' +
          '16,4),        '#13#10'    ImporteTotal1 BCD(16,4),'#13#10'    ImporteTotal2 ' +
          'BCD(16,4),'#13#10'    ImporteTotal3 BCD(16,4),'#13#10'    ImporteTotal4 BCD(' +
          '16,4),'#13#10'    ImporteTotal5 BCD(16,4),'#13#10'    ImporteTotal6 BCD(16,4' +
          '),'#13#10'    ImporteTotal7 BCD(16,4),'#13#10'    ImporteTotal8 BCD(16,4),'#13#10 +
          '    ImporteTotal9 BCD(16,4),'#13#10'    ImporteTotal10 BCD(16,4),'#13#10'   ' +
          ' ImporteTotal11 BCD(16,4),'#13#10'    ImporteTotal12 BCD(16,4),       ' +
          ' '#13#10'    TipoRetencion SMALLINT,'#13#10'    BaseCalculoRetencion BCD(16,' +
          '4),'#13#10'    ImporteRetencion BCD(16,4),'#13#10'    ImporteTotal BCD(16,4)' +
          ','#13#10'    FechaVencimiento1 DATE,'#13#10'    FechaVencimiento2 DATE,'#13#10'   ' +
          ' FechaVencimiento3 DATE,'#13#10'    FechaVencimiento4 DATE,'#13#10'    Fecha' +
          'Vencimiento5 DATE,'#13#10'    FechaVencimiento6 DATE,'#13#10'    ImporteVenc' +
          'imiento1 BCD(16,4),'#13#10'    ImporteVencimiento2 BCD(16,4),'#13#10'    Imp' +
          'orteVencimiento3 BCD(16,4) ,'#13#10'    ImporteVencimiento4 BCD(16,4),' +
          #13#10'    ImporteVencimiento5 BCD(16,4),'#13#10'    ImporteVencimiento6 BC' +
          'D(16,4),'#13#10'    SumaIVAyRE BCD(16,4),'#13#10'    SumaBultos BCD(16,4),'#13#10 +
          '    SumaKilos BCD(16,4),'#13#10'    SumaVolumen BCD(16,4),'#13#10'    SumaCa' +
          'jas BCD(16,4),'#13#10'    SumaPallets BCD(16,4),'#13#10'    ImporteCifra NVA' +
          'RCHAR(128),'#13#10'    PorcentajeRetencion BCD(16,4),'#13#10'    TotalEcoTas' +
          'a BCD(16,4),'#13#10'    TotalContribucionRAP BCD(16,4),          '#13#10'   ' +
          ' Portes BCD(16,4),'#13#10'    CuotaIVAPortes BCD(16,4),'#13#10'    CuotaREPo' +
          'rtes BCD(16,4),'#13#10'    PorcentajeRecFinanc BCD(16,4),'#13#10'    Recargo' +
          'Financiero BCD(16,4),'#13#10'    CodigoTransportista NVARCHAR(2),'#13#10'   ' +
          ' CodigoOperario NVARCHAR(5),        '#13#10'    CodigoEmpresa NVARCHAR' +
          '(3),'#13#10'    TotalEntrega BCD(16,4),    '#13#10'    CampoLibre1 NVARCHAR(' +
          '40),'#13#10'    CampoLibre2 NVARCHAR(40),'#13#10'    CampoLibre3 NVARCHAR(40' +
          '),'#13#10'    CampoLibre4 NVARCHAR(40),'#13#10'    CampoLibre5 NVARCHAR(40),' +
          #13#10'    FechaEnvioPorCorreo DATE,                                 ' +
          '                          '#13#10'    EjercicioFactura INTEGER,'#13#10'    N' +
          'roFactura INTEGER,'#13#10'    Anotacion NCLOB,'#13#10'    Firma IMAGE,'#13#10'    ' +
          'QRVerifactu NVARCHAR(125)                              '#13#10');'#13#10#13#10'C' +
          'REATE INDEX Index1 ON <TableName> ( NroOperacion );'#13#10
      end
      item
        Title = 'Lineas'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'    NroOpe' +
          'racion Integer,'#13#10'    NroPagina SmallInt,'#13#10'    NroLinea SmallInt,' +
          #13#10'    NroRegistro SmallInt,'#13#10'    NroOperacionDoc Integer,'#13#10'    N' +
          'roRegistroDoc Integer,'#13#10'    Fecha Date,'#13#10'    FechaAplicacion Dat' +
          'e,        '#13#10'    AsignacionOrigen SmallInt,'#13#10'    TipoMovimientoOr' +
          'igen SmallInt,'#13#10'    EjercicioOrigen SmallInt,'#13#10'    NroOperacionO' +
          'rigen Integer,'#13#10'    NroRegistroOrigen Integer,'#13#10'    EjercicioDoc' +
          'umento SmallInt,'#13#10'    SerieDocumento NVARCHAR(2),'#13#10'    NroDocume' +
          'nto Integer,'#13#10'    CodigoRegAuxiliar NVARCHAR(3),        '#13#10'    Co' +
          'digoArticulo NVARCHAR(20),'#13#10'    Referencia NVARCHAR(20),'#13#10'    Co' +
          'digoClaseA NVARCHAR(3),'#13#10'    DescripcionClaseA NVARCHAR(30),'#13#10'  ' +
          '  CodigoClaseB NVARCHAR(3),'#13#10'    DescripcionClaseB NVARCHAR(30),' +
          #13#10'    CodigoClaseC NVARCHAR(3),'#13#10'    DescripcionClaseC NVarChar(' +
          '30),'#13#10'    CampoLibre1 NVARCHAR(20),'#13#10'    CampoLibre2 NVARCHAR(20' +
          '),'#13#10'    CampoLibre3 DATE,'#13#10'    CampoLibre4 BCD(16,4),        '#13#10' ' +
          '   Descripcion NVARCHAR(60),'#13#10'    Anotacion NCLOB,'#13#10'    LoteFabr' +
          'icacion NVARCHAR(20),'#13#10'    NumeroSerie NVARCHAR(40),'#13#10'    TipoLi' +
          'nea NVARCHAR(3),'#13#10'    CodigoAlmacen NVARCHAR(2),'#13#10'    CodigoUbic' +
          'acion NVARCHAR(6),'#13#10'    Largo BCD(16,4),'#13#10'    Ancho BCD(16,4),'#13#10 +
          '    Alto BCD(16,4) ,'#13#10'    Cantidad BCD(16,4),'#13#10'    Precio Double' +
          ' Precision,'#13#10'    UnidadesPrecio Integer,                        ' +
          '                             '#13#10'    PrecioDivisa BCD(16,4),'#13#10'    ' +
          'ImporteBruto BCD(16,4),'#13#10'    PuntoVerde BCD(16,4),'#13#10'    Recargo ' +
          'BCD(16,4),'#13#10'    Descuento BCD(16,4),'#13#10'    ImportePuntoVerde BCD(' +
          '16,4),'#13#10'    ImporteContribucionRAP BCD(16,4),          '#13#10'    Imp' +
          'orteDescuento BCD(16,4),'#13#10'    ImporteNeto BCD(16,4),'#13#10'    Codigo' +
          'TipoIVA SmallInt,'#13#10'    TipoIVA BCD(16,4),'#13#10'    CuotaIVA BCD(16,4' +
          '),'#13#10'    CodigoTipoRE SmallInt,'#13#10'    TipoRE BCD(16,4),'#13#10'    Cuota' +
          'RE BCD(16,4),'#13#10'    TotalLinea BCD(16,4),'#13#10'    PrecioIVAIncluido ' +
          'BCD(16,4),'#13#10'    TotalBultos BCD(16,4),'#13#10'    TotalKilos BCD(16,4)' +
          ','#13#10'    TotalVolumen BCD(16,4),'#13#10'    TotalPallets BCD(16,4),'#13#10'   ' +
          ' NroCajas BCD(16,4),'#13#10'    CantidadProcesada BCD(16,4),'#13#10'    Carg' +
          'ado BCD(16,4),'#13#10'    EnvasesDeposito BCD(16,4),'#13#10'    Contenedores' +
          'Deposito BCD(16,4)              '#13#10');'#13#10#13#10'CREATE INDEX Index1 ON <' +
          'TableName> ( NroOperacion );'#13#10'CREATE INDEX Index2 ON <TableName>' +
          ' ( NroOperacion, NroPagina, NroLinea );'#13#10'CREATE INDEX Index3 ON ' +
          '<TableName> ( EjercicioDocumento, NroOperacionDoc, NroRegistro )' +
          ';'#13#10'CREATE INDEX Index4 ON <TableName> ( NroRegistroDoc );'#13#10'CREAT' +
          'E INDEX Index5 ON <TableName> ( NroOperacion, NroOperacionDoc, N' +
          'roPagina );    '#13#10
      end
      item
        Title = 'EtiquetaArticulo'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'    Codigo' +
          ' NVARCHAR(20),'#13#10'    NroRegistro Integer,'#13#10'    ReferenciaProveedo' +
          'r NVARCHAR(20),'#13#10'    ReferenciaCliente NVARCHAR(20),'#13#10'    Codigo' +
          'ClaseA NVARCHAR(3),'#13#10'    DescripcionClaseA NVARCHAR(30),'#13#10'    Co' +
          'digoClaseB NVARCHAR(3),'#13#10'    DescripcionClaseB NVARCHAR(30),'#13#10'  ' +
          '  CodigoClaseC NVARCHAR(3),'#13#10'    DescripcionClaseC NVARCHAR(30),' +
          #13#10'    Descripcion NVarChar(60),'#13#10'    Anotacion NCLOB,'#13#10'    Codig' +
          'oBarras NVARCHAR(20),'#13#10'    LoteFabricacion NVARCHAR(20),'#13#10'    Nu' +
          'meroSerie NVARCHAR(40),'#13#10'    CodigoAlmacen NVARCHAR(2),'#13#10'    Ubi' +
          'cacion NVARCHAR(6),'#13#10'    TipoLinea NVARCHAR(2),'#13#10'    Cantidad BC' +
          'D(16,4),'#13#10'    Precio BCD(16,4),        '#13#10'    PrecioVenta BCD(16,' +
          '4),'#13#10'    PuntoVerde BCD(16,4),'#13#10'    RecargoVenta BCD(16,4),'#13#10'   ' +
          ' TipoIVA BCD(16,4),'#13#10'    Descuento BCD(16,4) ,'#13#10'    PrecioIVAInc' +
          'luido BCD(16,4),'#13#10'    PrecioVentaIVAIncluido BCD(16,4),        '#13 +
          #10'    NroBultoLinea BCD(16,4),'#13#10'    NroBultoAlbaran BCD(16,4),'#13#10' ' +
          '   Bultos BCD(16,4) ,'#13#10'    Volumen BCD(16,4),'#13#10'    Kilos BCD(16,' +
          '4),'#13#10'    NroBultosLinea BCD(16,4),'#13#10'    VolumenLinea BCD(16,4),'#13 +
          #10'    KilosLinea BCD(16,4),'#13#10'    NroBultosAlbaran BCD(16,4),'#13#10'   ' +
          ' VolumenAlbaran BCD(16,4),'#13#10'    KilosAlbaran BCD(16,4) ,   '#13#10'   ' +
          ' CampoLibre1 NVARCHAR(40),'#13#10'    CampoLibre2 NVARCHAR(40),'#13#10'    C' +
          'ampoLibre3 DATE,        '#13#10'    CampoLibre4 BCD(16,4) ,        '#13#10' ' +
          '   Cliente_Codigo NVARCHAR(5),'#13#10'    Proveedor_Codigo NVARCHAR(5)' +
          ','#13#10'    EjercicioAlbaran SmallInt,'#13#10'    NroOperacionAlbaran Integ' +
          'er,'#13#10'    FechaAlbaran Date,'#13#10'    SerieAlbaran NVARCHAR(40),'#13#10'   ' +
          ' NroAlbaran Integer,'#13#10'    NroLineaAlbaran SmallInt,'#13#10'    Ejercic' +
          'ioPedido SmallInt,'#13#10'    NroOperacionPedido Integer,'#13#10'    NroPedi' +
          'do Integer,'#13#10'    NroLineaPedido SmallInt,'#13#10'    CodigoVendedor NV' +
          'ARCHAR(2),'#13#10'    RegistroAuxiliar NVARCHAR(3),'#13#10'    GrupoCliente ' +
          'NVARCHAR(3)'#13#10');'#13#10
      end
      item
        Title = 'EtiquetaPostal'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'    Codigo' +
          ' NVARCHAR(5),'#13#10'    Nombre NVARCHAR(40),'#13#10'    Domicilio NVARCHAR(' +
          '40),'#13#10'    Localidad NVARCHAR(30),'#13#10'    CodigoPais NVARCHAR(3),'#13#10 +
          '    NombrePais NVARCHAR(30),'#13#10'    CP NVARCHAR(5),'#13#10'    Provincia' +
          ' NVARCHAR(30)'#13#10');'#13#10
      end
      item
        Title = 'Paginas'
        SQLText = 
          'CREATE TABLE <TableName> STORAGE ENGINE '#39'variable'#39' ('#13#10'    Ejerci' +
          'cioDocumento SmallInt,'#13#10'    NroOperacion Integer,'#13#10'    NroPagina' +
          ' SmallInt,                                           '#13#10'    NroOp' +
          'eracionDoc Integer,'#13#10'    CodigoGrupo NVARCHAR(2),'#13#10'    Descripci' +
          'on NVARCHAR(30),                                                ' +
          '         '#13#10'    Anotacion NCLOB                                  ' +
          '  '#13#10');'#13#10#13#10'CREATE INDEX Index1 ON <TableName> ( NroOperacion );'#13#10 +
          'CREATE INDEX Index2 ON <TableName> ( NroOperacion, NroPagina ); ' +
          '   '#13#10'CREATE INDEX Index3 ON <TableName> ( EjercicioDocumento, Nr' +
          'oOperacionDoc, NroPagina );'#13#10'  '#13#10
      end>
    Left = 48
    Top = 90
  end
end
