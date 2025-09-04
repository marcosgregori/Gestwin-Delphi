/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:23:11
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:23:11
 ******************************************************************************/

CREATE TABLE CodigoPostal
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    CodigoPais NVarChar(3) NOT NULL,
    CodigoProvincia NVarChar(2) NOT NULL,
    Codigo NVarChar(3) NOT NULL,
    Nombre NVarChar(200)
);

CREATE TABLE Configuracion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Aplicacion SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Codigo NVarChar(40) NOT NULL,
    Data BLOB
);

CREATE TABLE ConfiguracionCorreo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Id AutoInc DEFAULT EMPTY,
    CodigoEmpresa NVarChar(3) DEFAULT EMPTY,
    CodigoUsuario NVarChar(2) DEFAULT EMPTY DESCRIPTION 'Nro_Usuario',
    ServidorSMTP NVarChar(60),
    PuertoSMTP SmallInt,
    SeguridadSMTP SmallInt DESCRIPTION 'Correo_ConexionSeguraSMTP',
    TipoServidorCorreoEntrante SmallInt,
    ServidorPOP3IMAP NVarChar(60) DESCRIPTION 'Correo_ServidorPOP3',
    PuertoPOP3IMAP SmallInt DESCRIPTION 'Correo_PuertoPOP3',
    SeguridadPOP3IMAP SmallInt DESCRIPTION 'Correo_SeguridadPOP3',
    Usuario NVarChar(40),
    Password NVarChar(20),
    Direccion NVarChar(80),
    Firma NCLOB,
    AccesoOAuthPOP3IMAP Boolean,
    AccesoOAuthSMTP Boolean,
    ProveedorOAuth SmallInt,
    IDCliente NVarChar(128),
    IDInquilino NVarChar(128),
    ClaveSecreta NVarChar(128),
    UsuarioOAuth NVarChar(40),
    RefreshToken NVarChar(128)
);

CREATE TABLE Contadores
(
    Id AutoInc,
    CodigoEmpresa NVarChar(3) DEFAULT EMPTY NOT NULL,
    Tipo SmallInt NOT NULL,
    Ejercicio SmallInt DEFAULT EMPTY NOT NULL,
    Codigo NVarChar(9) DEFAULT EMPTY NOT NULL,
    Valor Integer NOT NULL
);

CREATE TABLE Correo
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    CodigoEmpresa NVarChar(3) NOT NULL,
    CodigoUsuario NVarChar(2) NOT NULL,
    Carpeta SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Asunto NVarChar(128),
    Remitente NVarChar(128),
    Destinatario NVarChar(128),
    Fecha Date NOT NULL,
    Hora Time NOT NULL,
    FechaProceso Date,
    HoraProceso Time,
    Parametros NCLOB,
    Adjunto BLOB
);

CREATE TABLE DiarioProcesos
(
    Id AutoInc,
    CodigoEmpresa NVarChar(3) NOT NULL,
    CodigoUsuario NVarChar(2) NOT NULL,
    Tipo SmallInt DEFAULT EMPTY NOT NULL,
    Opcion SmallInt DEFAULT EMPTY NOT NULL,
    Fecha Date,
    Hora Time,
    Descripcion NVarChar(60),
    Informacion NCLOB
);

CREATE TABLE DireccionCorreo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(40),
    EsUnGrupo Boolean,
    EMail NVarChar(80),
    Grupo NVarChar(2)
);

CREATE TABLE Divisa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    PrecisionRedondeo Double Precision,
    CambioFijo Boolean,
    TipoCambio Double Precision
);

CREATE TABLE Empresa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Id AutoInc,
    Codigo NVarChar(3) NOT NULL,
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    NIF NVarChar(15),
    Telefono NVarChar(20),
    Fax NVarChar(20),
    CodigoEAN NVarChar(13),
    DataPath NVarChar(128),
    RemoteDataPath NVarChar(128),
    ComprobarDatosRemotos Boolean,
    DataServer NVarChar(80),
    FTPPath NVarChar(128),
    DiasLaborables Integer,
    InicioJornadaLaboral Time,
    FinJornadaLaboral Time,
    Registro_Libro NVarChar(20),
    Registro_RegistroMercantil NVarChar(20),
    Registro_Hoja NVarChar(20),
    Registro_Folio NVarChar(20),
    Registro_Seccion NVarChar(20),
    Registro_Tomo NVarChar(20),
    Registro_OtrosDatos NVarChar(20),
    RegimenEspecialCriterioCaja Boolean,
    PersonaConQuienRelacionarse NVarChar(40),
    Compras_UltNroFra Integer,
    Compras_DecCantidad SmallInt,
    Compras_DecPrecio SmallInt,
    Compras_DecDto SmallInt,
    Compras_DecCajas SmallInt,
    Compras_VerStock Boolean,
    Compras_EmitirFras Boolean,
    Compras_Cantidades SmallInt,
    Compras_NombreCajas NVarChar(10),
    Compras_EditarBultosAlbaran Boolean,
    Compras_NombreBultos NVarChar(20),
    Compras_Calculo SmallInt,
    Compras_RedImpNeto Boolean,
    Compras_ActTarifas Boolean,
    Compras_Ubicaciones Boolean,
    Compras_NrosSerie Boolean,
    Compras_Divisas Boolean,
    Compras_AlmacenDefec NVarChar(2),
    Compras_UtilizarPrecioOfertas Boolean,
    Compras_CamposLibres Boolean,
    Compras_CampoLibre1 NVarChar(15),
    Compras_CampoLibre2 NVarChar(15),
    Compras_CampoLibre3 NVarChar(15),
    Compras_CampoLibre4 NVarChar(15),
    Compras_CampoLibre5 NVarChar(15),
    Compras_CampoLibreObligatorio1 Boolean,
    Compras_CampoLibreObligatorio2 Boolean,
    Compras_CampoLibreObligatorio3 Boolean,
    Compras_CampoLibreObligatorio4 Boolean,
    Compras_CampoLibreObligatorio5 Boolean,
    Compras_CamposLibresLineas Boolean,
    Compras_CampoLibreLineas1 NVarChar(15),
    Compras_CampoLibreLineas2 NVarChar(15),
    Compras_CampoLibreLineas3 NVarChar(15),
    Compras_CampoLibreLineas4 NVarChar(15),
    Compras_CampoLibreLineas5 NVarChar(15),
    Compras_CampoLibreLineasOblig1 Boolean,
    Compras_CampoLibreLineasOblig2 Boolean,
    Compras_CampoLibreLineasOblig3 Boolean,
    Compras_CampoLibreLineasOblig4 Boolean,
    Compras_CampoLibreLineasOblig5 Boolean,
    Compras_CampoLibreLineasPos1 SmallInt DEFAULT 5,
    Compras_CampoLibreLineasPos2 SmallInt DEFAULT 5,
    Compras_CampoLibreLineasPos3 SmallInt DEFAULT 5,
    Compras_CampoLibreLineasPos4 SmallInt DEFAULT 5,
    Compras_CampoLibreLineasPos5 SmallInt,
    Compras_Operarios Boolean,
    Compras_FechaRecepcionPorLinea Boolean,
    Compras_FechaCaducidad Boolean,
    Ventas_ContMovCaja Boolean,
    Ventas_DecCantidad SmallInt,
    Ventas_DecPrecio SmallInt,
    Ventas_DecRecargo SmallInt,
    Ventas_DecDto SmallInt,
    Ventas_DecCajas SmallInt,
    Ventas_VerStock Boolean,
    Ventas_DtoPrevio Boolean,
    Ventas_PagosPedido Boolean,
    Ventas_SeriesPedido Boolean,
    Ventas_Cantidades SmallInt,
    Ventas_NombreCajas NVarChar(10),
    Ventas_Calculo SmallInt,
    Ventas_RedImpNeto Boolean,
    Ventas_Ubicaciones Boolean,
    Ventas_NrosSerie Boolean,
    Ventas_SerieDefecto NVarChar(2),
    Ventas_AlmacenDefec NVarChar(2),
    Ventas_RiesgoPedido Boolean,
    Ventas_RiesgoAlbaran Boolean,
    Ventas_Transportista Boolean,
    Ventas_CompCorrDoc Boolean,
    Ventas_Recargos Boolean,
    Ventas_NombreRecargos NVarChar(10),
    Ventas_MostrarRentabilidad Boolean,
    Ventas_PreAutoVenta SmallInt,
    Ventas_CamposLibres Boolean,
    Ventas_CampoLibre1 NVarChar(15),
    Ventas_CampoLibre2 NVarChar(15),
    Ventas_CampoLibre3 NVarChar(15),
    Ventas_CampoLibre4 NVarChar(15),
    Ventas_CampoLibre5 NVarChar(15),
    Ventas_CampoLibreObligatorio1 Boolean,
    Ventas_CampoLibreObligatorio2 Boolean,
    Ventas_CampoLibreObligatorio3 Boolean,
    Ventas_CampoLibreObligatorio4 Boolean,
    Ventas_CampoLibreObligatorio5 Boolean,
    Ventas_CamposLibresLineas Boolean,
    Ventas_CampoLibreLineas1 NVarChar(15),
    Ventas_CampoLibreLineas2 NVarChar(15),
    Ventas_CampoLibreLineas3 NVarChar(15),
    Ventas_CampoLibreLineas4 NVarChar(15),
    Ventas_CampoLibreLineas5 NVarChar(15),
    Ventas_CampoLibreLineasOblig1 Boolean,
    Ventas_CampoLibreLineasOblig2 Boolean,
    Ventas_CampoLibreLineasOblig3 Boolean,
    Ventas_CampoLibreLineasOblig4 Boolean,
    Ventas_CampoLibreLineasOblig5 Boolean,
    Ventas_CampoLibreLineasPos1 SmallInt DEFAULT 5,
    Ventas_CampoLibreLineasPos2 SmallInt DEFAULT 5,
    Ventas_CampoLibreLineasPos3 SmallInt DEFAULT 5,
    Ventas_CampoLibreLineasPos4 SmallInt DEFAULT 5,
    Ventas_CampoLibreLineasPos5 SmallInt,
    Ventas_CampoLibreLineasComp Boolean,
    Ventas_Divisas Boolean,
    Ventas_DocumentosPaginados Boolean,
    Ventas_NombrePaginas NVarChar(20),
    Ventas_EditarBultosAlbaran Boolean,
    Ventas_NombreBultos NVarChar(20),
    Ventas_ContenedoresSonPallets Boolean,
    Ventas_RegularizarPedidosServidos Boolean,
    Ventas_Operarios Boolean,
    Ventas_NombreOperarios NVarChar(15),
    Ventas_MostrarDireccionOperarios Boolean,
    Ventas_CampoOperarios1 NVarChar(15),
    Ventas_CampoOperarios2 NVarChar(15),
    Ventas_CampoOperarios3 NVarChar(15),
    Ventas_CampoOperarios4 NVarChar(15),
    Ventas_CampoOperarios5 NVarChar(15),
    Ventas_CampoOperarios6 NVarChar(15),
    Ventas_CampoOperarios7 NVarChar(15),
    Ventas_CampoOperarios8 NVarChar(15),
    Ventas_CampoOperarios9 NVarChar(15),
    Ventas_CampoOperarios10 NVarChar(15),
    Ventas_FormaEnvio Boolean,
    Ventas_MostrarLotesPedido Boolean,
    Ventas_LotesObligatorios Boolean,
    Ventas_DocumentosSinIVAIncluido Boolean,
    Ventas_FechaEntregaPorLinea Boolean,
    Ventas_FechaCaducidad Boolean,
    Ventas_GestionSubvenciones Boolean,
    Ventas_EntornoPruebasVerifactu Boolean,
    Ventas_TiposIVAModificables Boolean,
    Stock_MultiAlmacen Boolean,
    Stock_AltasFabric Boolean,
    Stock_LotesProductos Boolean,
    Stock_TrazabilidadPorLotes Boolean,
    Stock_CosteEntradaPorLote Boolean,
    Stock_Ubicaciones Boolean,
    Stock_AlmacenDefecto NVarChar(2),
    Stock_AlmacenPrev NVarChar(2),
    Stock_AvisoStock Boolean,
    Stock_ImpSalidasSinStock Boolean,
    Stock_AvisoBajoMinimos Boolean,
    Stock_IncluirPrecioComponentes Boolean,
    Stock_ImpedirPendienteEnExceso Boolean,
    Stock_TiposLineaMovimiento Boolean,
    Stock_Operarios Boolean,
    Contable_MesInicial SmallInt,
    Contable_CtrosCoste Boolean,
    Contable_NroRegistro Boolean,
    Contable_Retenciones Boolean,
    Contable_BloqueoTrim Boolean,
    Contable_Divisas Boolean,
    Contable_NroRegAstos Boolean,
    Contable_NoUsarExistencias Boolean,
    Contable_DesglosarCtasCobros Boolean,
    Contable_VentasOnlineIntracomunitarias Boolean,
    Contable_SII Boolean DESCRIPTION 'Contable_EntornoRealSII',
    Contable_EntornoPruebasSII Boolean,
    Inmovilizado_CamposLibres Boolean,
    Inmovilizado_CampoLibre1 NVarChar(15),
    Inmovilizado_CampoLibre2 NVarChar(15),
    Inmovilizado_CampoLibre3 NVarChar(15),
    Inmovilizado_CampoLibre4 NVarChar(15),
    Inmovilizado_CampoLibOblig1 Boolean,
    Inmovilizado_CampoLibOblig2 Boolean,
    Inmovilizado_CampoLibOblig3 Boolean,
    Inmovilizado_CampoLibOblig4 Boolean,
    Cliente_RegAuxiliar Boolean,
    Cliente_NombreRegAuxiliar NVarChar(15),
    Cliente_DireccionAuxiliar Boolean,
    Cliente_CampoAux1 NVarChar(15),
    Cliente_CampoAux2 NVarChar(15),
    Cliente_CampoAux3 NVarChar(15),
    Cliente_CampoAux4 NVarChar(15),
    Cliente_CampoAux5 NVarChar(15),
    Cliente_CampoAux6 NVarChar(15),
    Cliente_CampoAux7 NVarChar(15),
    Cliente_CampoAux8 NVarChar(15),
    Cliente_CampoAux9 NVarChar(15),
    Cliente_CampoAux10 NVarChar(15),
    Cliente_GruposFac Boolean,
    Cliente_TarCodigo Boolean,
    Cliente_TarCantidadMinima Boolean,
    Cliente_TarConsumo Boolean,
    Cliente_Referencias Boolean,
    Cliente_VenPeriodica Boolean,
    Cliente_CamposLibres Boolean,
    Cliente_CampoLibre1 NVarChar(15),
    Cliente_CampoLibre2 NVarChar(15),
    Cliente_CampoLibre3 NVarChar(15),
    Cliente_CampoLibre4 NVarChar(15),
    Cliente_CampoLibOblig1 Boolean DESCRIPTION 'Cliente_CampoLib1Oblig',
    Cliente_CampoLibOblig2 Boolean DESCRIPTION 'Cliente_CampoLib2Oblig',
    Cliente_CampoLibOblig3 Boolean DESCRIPTION 'Cliente_CampoLib3Oblig',
    Cliente_CampoLibOblig4 Boolean DESCRIPTION 'Cliente_CampoLib4Oblig',
    Cliente_CanalSerie Boolean,
    Cliente_DtosTarifas Boolean,
    Cliente_Localizacion Boolean,
    Proveedor_CampLibre Boolean,
    Proveedor_CampoLib1 NVarChar(15),
    Proveedor_CampoLib2 NVarChar(15),
    Proveedor_CampoLib3 NVarChar(15),
    Proveedor_CampoLib4 NVarChar(15),
    Proveedor_CampoLibOblig1 Boolean DESCRIPTION 'Proveedor_CampoLib1Oblig',
    Proveedor_CampoLibOblig2 Boolean DESCRIPTION 'Proveedor_CampoLib2Oblig',
    Proveedor_CampoLibOblig3 Boolean DESCRIPTION 'Proveedor_CampoLib3Oblig',
    Proveedor_CampoLibOblig4 Boolean DESCRIPTION 'Proveedor_CampoLib4Oblig',
    Proveedor_Grupos Boolean,
    Proveedor_RegAuxiliar Boolean,
    Proveedor_NombreRegAuxiliar NVarChar(15),
    Proveedor_CampoAux1 NVarChar(15),
    Proveedor_CampoAux2 NVarChar(15),
    Proveedor_CampoAux3 NVarChar(15),
    Proveedor_CampoAux4 NVarChar(15),
    Proveedor_CampoAux5 NVarChar(15),
    Proveedor_CampoAux6 NVarChar(15),
    Proveedor_CampoAux7 NVarChar(15),
    Proveedor_CampoAux8 NVarChar(15),
    Proveedor_CampoAux9 NVarChar(15),
    Proveedor_CampoAux10 NVarChar(15),
    Articulo_Cajas Boolean,
    Articulo_Pallets Boolean,
    Articulo_Ubicacion Boolean,
    Articulo_Bultos Boolean,
    Articulo_UnidadesPorPrecio Boolean,
    Articulo_ExisteClase1 Boolean DESCRIPTION 'Articulo_ClaseA',
    Articulo_ExisteClase2 Boolean DESCRIPTION 'Articulo_ClaseB',
    Articulo_ExisteClase3 Boolean DESCRIPTION 'Articulo_ClaseC',
    Articulo_NombreClase1 NVarChar(10) DESCRIPTION 'Articulo_NomClaseA',
    Articulo_NombreClase2 NVarChar(10) DESCRIPTION 'Articulo_NomClaseB',
    Articulo_NombreClase3 NVarChar(10) DESCRIPTION 'Articulo_NomClaseC',
    Articulo_TarifaClase Boolean,
    Articulo_PuntoVerde Boolean,
    Articulo_ContribucionRAPRepercutida Boolean,
    Articulo_PreciosIVA Boolean,
    Articulo_CamposLibres Boolean,
    Articulo_CampoLibre1 NVarChar(15),
    Articulo_CampoLibre2 NVarChar(15),
    Articulo_CampoLibre3 NVarChar(15),
    Articulo_CampoLibre4 NVarChar(15),
    Articulo_CampoLibre5 NVarChar(15),
    Articulo_CampoLibre6 NVarChar(15),
    Articulo_CampoLibre7 NVarChar(15),
    Articulo_CampoLibre8 NVarChar(15),
    Articulo_CampoLibre9 NVarChar(15),
    Articulo_CampoLibre10 NVarChar(15),
    Articulo_CampoLibre11 NVarChar(15),
    Articulo_CampoLibre12 NVarChar(15),
    Articulo_CampoLibre13 NVarChar(15),
    Articulo_CampoLibre14 NVarChar(15),
    Articulo_CampoLibre15 NVarChar(15),
    Articulo_CampoLibre16 NVarChar(15),
    Articulo_CampoLibOblig1 Boolean DESCRIPTION 'Articulo_CampoLib1Oblig',
    Articulo_CampoLibOblig2 Boolean DESCRIPTION 'Articulo_CampoLib2Oblig',
    Articulo_CampoLibOblig3 Boolean DESCRIPTION 'Articulo_CampoLib3Oblig',
    Articulo_CampoLibOblig4 Boolean DESCRIPTION 'Articulo_CampoLib4Oblig',
    Articulo_CampoLibOblig5 Boolean DESCRIPTION 'Articulo_CampoLib5Oblig',
    Articulo_CampoLibOblig6 Boolean DESCRIPTION 'Articulo_CampoLib6Oblig',
    Articulo_CampoLibOblig7 Boolean DESCRIPTION 'Articulo_CampoLib7Oblig',
    Articulo_CampoLibOblig8 Boolean DESCRIPTION 'Articulo_CampoLib8Oblig',
    Articulo_CampoLibOblig9 Boolean DESCRIPTION 'Articulo_CampoLib9Oblig',
    Articulo_CampoLibOblig10 Boolean DESCRIPTION 'Articulo_CampoLib10Oblig',
    Articulo_CampoLibOblig11 Boolean DESCRIPTION 'Articulo_CampoLib11Oblig',
    Articulo_CampoLibOblig12 Boolean DESCRIPTION 'Articulo_CampoLib12Oblig',
    Articulo_CampoLibOblig13 Boolean,
    Articulo_CampoLibOblig14 Boolean,
    Articulo_CampoLibOblig15 Boolean,
    Articulo_CampoLibOblig16 Boolean,
    Articulo_CampoLib9Agrupacion Boolean,
    Articulo_SoloCodificados Boolean,
    Articulo_MargenSobrePrecioCompra Boolean,
    Articulo_DtosCompraEnMargenes Boolean,
    Articulo_EditarMedidas Boolean,
    Articulo_ConsultasPersistentes Boolean,
    Articulo_Envase SmallInt,
    Articulo_TipoEnvase SmallInt,
    Articulo_Contenedor SmallInt,
    Articulo_TipoContenedor SmallInt,
    Articulo_PermitirModificarPeso Boolean,
    Articulo_StockMinMaxPorAlmacen Boolean,
    Articulo_ArticulosRelacionados Boolean,
    Vendedor_ComPorCli Boolean,
    Resultados_ReconstruirPeriodicamente Boolean
);

CREATE TABLE EntidadFinanciera
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    Codigo NVarChar(4) NOT NULL,
    Sucursal NVarChar(4),
    Nombre NVarChar(80) NOT NULL,
    Localidad NVarChar(40),
    BIC NVarChar(11) NOT NULL
);

CREATE TABLE EstructuraFichero
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Fichero SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Descripcion NVarChar(30),
    FicheroExterno NVarChar(80),
    DecimalImplicito Boolean,
    Formato SmallInt,
    Separador NVarChar(1),
    Script NCLOB
);

CREATE TABLE Ficheros
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    CodigoEmpresa NVarChar(3) NOT NULL,
    NombreFichero NVarChar(20) NOT NULL,
    Localizacion SmallInt,
    Comentario NVarChar(40)
);

CREATE TABLE InformeExterno
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    TipoDocumento SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Descripcion NVarChar(60),
    TipoFichero SmallInt,
    Fichero NVarChar(128),
    Empresa NVarChar(3),
    Usuario NVarChar(2),
    Seccion SmallInt,
    Impresora NVarChar(128),
    Pagina NVarChar(64),
    Informacion NCLOB
);

CREATE TABLE LineaEstructFichero
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Fichero SmallInt NOT NULL,
    NroRegistro SmallInt NOT NULL,
    NroLinea SmallInt NOT NULL,
    Campo NVarChar(40),
    Inicio SmallInt,
    Longitud SmallInt,
    Constante NVarChar(80),
    Automatico Boolean,
    Decimales SmallInt,
    Incluir Boolean,
    Prueba NVarChar(80)
);

CREATE TABLE Notificacion
(
    Id AutoInc,
    Grupo SmallInt,
    Texto NVarChar(256)
);

CREATE TABLE Pais
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Codigo NVarChar(3) NOT NULL,
    Nombre NVarChar(40),
    CodigoISO2 NVarChar(2) DESCRIPTION 'CodigoISO',
    CodigoISO3 NVarChar(3),
    Intracomunitario Boolean
);

CREATE TABLE PGC
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    Codigo NVarChar(9) NOT NULL,
    Descripcion NCLOB
);

CREATE TABLE Planificador
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    IdPadre Integer,
    IdRecurso NVarChar(20),
    IdEvento NVarChar(20),
    InicioActual Timestamp,
    FinalActual Timestamp,
    Titulo NVarChar(80),
    TipoDeEvento Integer,
    Inicio Timestamp,
    Final Timestamp,
    ColorEtiqueta Integer,
    Lugar NVarChar(80),
    Mensaje NVarChar(512),
    Opciones Integer,
    IndiceRecurrencia Integer,
    InformacionRecurrencia BLOB,
    FechaRecordatorio Timestamp,
    MinutosAntesEmpezarRecordatorio Integer DESCRIPTION 'MinutosAnterEmpezarRecordatorio',
    DatosRecordatorio BLOB,
    Estado Integer,
    TareaCompletada Integer,
    TareaIndice Integer,
    TareaEnlaces BLOB,
    TareaEstado Integer
);

CREATE TABLE PlantillaGrafico
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Tipo SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Descripcion NVarChar(60),
    Ejercicio SmallInt,
    Codigo1 NVarChar(20),
    Codigo2 NVarChar(20),
    Codigo3 NVarChar(20),
    Codigo4 NVarChar(20),
    Codigo5 NVarChar(20),
    Codigo6 NVarChar(20),
    Codigo7 NVarChar(20),
    Codigo8 NVarChar(255),
    Operacion1 SmallInt DEFAULT 0,
    Operacion2 SmallInt DEFAULT 0,
    Operacion3 SmallInt DEFAULT 0,
    Opcion1 Boolean,
    Opcion2 Boolean,
    Opcion3 Boolean,
    Grafico NCLOB
);

CREATE TABLE Provincia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    CodigoPais NVarChar(3) NOT NULL,
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30)
);

CREATE TABLE RecursosPlanificador
  DESCRIPTION 'Data/DataDict File'
(
    Id Integer NOT NULL,
    Color Integer,
    IndiceImagen Integer,
    Nombre NVarChar(255)
);

CREATE TABLE Registro
  DESCRIPTION 'Data/DataDict File'
(
    Id AutoInc,
    IdPadre DWord,
    Clave NVarChar(50),
    Valor NVarChar(128),
    "Blob" NCLOB
);

CREATE TABLE TipoCambio
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Fecha Date NOT NULL,
    CodigoDivisa NVarChar(3) NOT NULL,
    TipoCambio Double Precision
);

CREATE TABLE Usuario
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    Codigo NVarChar(2) NOT NULL DESCRIPTION 'Nro_Usuario',
    Nombre NVarChar(30),
    Password Integer,
    CodigoEmpresa NVarChar(3),
    NoSuprimir Boolean,
    NoModificarDocumentos Boolean,
    VentanaInicio SmallInt,
    BordesRectos Boolean,
    EstiloPersonalizado Boolean,
    Decoracion SmallInt,
    UsarPieles Boolean,
    NombrePiel NVarChar(40),
    NombrePaleta NVarChar(40),
    SimularTab Boolean,
    GestorVentanasTDI Boolean,
    MaximizarVentanasEdicion Boolean,
    NoCerrarVentanasConEsc Boolean,
    ConsultasIzquierda Boolean,
    TecladoNumerico Boolean,
    AlertasPermanentes Boolean,
    PosicionAlertas SmallInt,
    Planificador Boolean,
    PanelControl Boolean,
    DesactivarNotificaciones Boolean,
    BuzonesCorreo Boolean,
    FuenteAnotaciones NVarChar(30),
    TamanoFuenteAnotaciones SmallInt,
    ModoTactil Boolean,
    TamanoModoTactil SmallInt,
    DisposicionVentanas SmallInt DEFAULT 0,
    ModoRenderizado SmallInt,
    Compras_OcultarPrecios Boolean DESCRIPTION 'OcultarPreciosCompra',
    Compras_MostrarStock Boolean,
    Compras_AlmacenDefecto NVarChar(10),
    Compras_RestringirAlmacen Boolean,
    Ventas_AlmacenDefecto NVarChar(2) DESCRIPTION 'AlmacenDefecto',
    Ventas_RestringirAlmacen Boolean,
    Ventas_SerieDefecto NVarChar(2) DESCRIPTION 'SerieDefecto',
    Ventas_RestringirSerie Boolean,
    Ventas_VendedorDefecto NVarChar(2),
    Ventas_RestringirVendedor Boolean DESCRIPTION 'RestringirUso',
    Ventas_MostrarStock Boolean,
    Ventas_MostrarRiesgoPedidos Boolean,
    Ventas_MostrarRiesgoAlbaranes Boolean,
    Ventas_MostrarRentabilidad Boolean,
    Ventas_DesactivarTabletaFirma Boolean,
    Tienda_Administrador Boolean,
    Tienda_NombreUsuario NVarChar(20),
    Tienda_Password NVarChar(20),
    GestorCredito Boolean,
    AcGC SmallInt,
    AcGCFicheros SmallInt,
    AcGCAsientos SmallInt,
    AcGCListados SmallInt,
    AcGCProcesos SmallInt,
    AcLI SmallInt,
    AcLIFicheros SmallInt,
    AcPC SmallInt,
    AcPCFicheros SmallInt,
    AcEI SmallInt,
    AcEIFicheros SmallInt,
    AcCO SmallInt,
    AcCOFicheros SmallInt,
    AcCOProveedores SmallInt,
    AcCOTarifas SmallInt,
    AcCOFormasPago SmallInt,
    AcCORelaciones SmallInt,
    AcCOMovimientos SmallInt,
    AcCOOfertas SmallInt,
    AcCOPedidos SmallInt,
    AcCOAlbaranes SmallInt,
    AcCOProcesos SmallInt,
    AcVE SmallInt,
    AcVEFicheros SmallInt,
    AcVEClientes SmallInt,
    AcVEVendedores SmallInt,
    AcVESeries SmallInt,
    AcVETarifas SmallInt,
    AcVEFormasCobro SmallInt,
    AcVERelaciones SmallInt,
    AcVEProcesos SmallInt,
    AcVETiendaVirtual SmallInt DEFAULT 1,
    AcAL SmallInt,
    AcALFicheros SmallInt,
    AcALArticulos SmallInt,
    AcALListasMateriales SmallInt,
    AcALAlmacenes SmallInt,
    AcALTiposMovimiento SmallInt,
    AcALFormatos SmallInt,
    AcALProcesos SmallInt,
    AcALCambioPrecios SmallInt,
    AcRE SmallInt,
    AcGP SmallInt,
    AcGPFicheros SmallInt,
    AcGPRelaciones SmallInt,
    AcGPOperarios SmallInt,
    AcGPMaquinas SmallInt,
    AcGPOperaciones SmallInt,
    AcGPTurnos SmallInt,
    AcGPPrevision SmallInt,
    AcGPLanzamiento SmallInt,
    AcGPSeguimiento SmallInt,
    AcGPNotificaciones SmallInt,
    AcGPProcesos SmallInt,
    AcCA SmallInt,
    AcCAFicheros SmallInt,
    AcCACaja SmallInt,
    AcCAListados SmallInt,
    AcCAProcesos SmallInt,
    AcCAArqueo SmallInt,
    AcCAPrecios SmallInt,
    AcCADescuentos SmallInt,
    AcProcesosCriticos SmallInt,
    AcModificacionInformes SmallInt,
    AcEdicionInformes SmallInt,
    AlmacenDocumentosFirmados NVarChar(128)
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:23:12
 ******************************************************************************/

CREATE INDEX I_Correo_1
 ON Correo(CodigoEmpresa, CodigoUsuario, Carpeta, Tipo, Fecha);

CREATE INDEX I_DiarioProcesos_1
 ON DiarioProcesos(CodigoEmpresa, CodigoUsuario, Tipo, Fecha, Hora);

CREATE INDEX I_DiarioProcesos_2
 ON DiarioProcesos(CodigoEmpresa, Tipo, Fecha, Hora);

CREATE INDEX I_DiarioProcesos_3
 ON DiarioProcesos(CodigoEmpresa, CodigoUsuario, Tipo, Opcion, Fecha, Hora);

CREATE INDEX I_DiarioProcesos_4
 ON DiarioProcesos(CodigoEmpresa, Tipo, Opcion, Fecha, Hora);

CREATE INDEX I_DireccionCorreo_1
 ON DireccionCorreo(Grupo, Codigo);

CREATE UNIQUE INDEX I_InformeExterno_1
 ON InformeExterno(Seccion, TipoDocumento, NroRegistro);

CREATE UNIQUE INDEX I_InformeExterno_2
 ON InformeExterno(Empresa, Usuario, TipoDocumento, NroRegistro);

CREATE UNIQUE INDEX I_LineaEstructFichero_1
 ON LineaEstructFichero(Fichero, NroRegistro, Campo);

CREATE INDEX Index_1
 ON Pais(CodigoISO2);

CREATE INDEX I_Planificador_1
 ON Planificador(IdEvento);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:23:12
 ******************************************************************************/

ALTER TABLE CodigoPostal ADD CONSTRAINT PK_CodigoPostal 
  PRIMARY KEY (CodigoPais, CodigoProvincia, Codigo);

ALTER TABLE Configuracion ADD CONSTRAINT PK_Configuracion 
  PRIMARY KEY (Aplicacion, Tipo, Codigo);

ALTER TABLE ConfiguracionCorreo ADD CONSTRAINT PK_Usuario 
  PRIMARY KEY (CodigoEmpresa, CodigoUsuario);

ALTER TABLE Contadores ADD CONSTRAINT PK_Contadores 
  PRIMARY KEY (CodigoEmpresa, Tipo, Ejercicio, Codigo, Valor);

ALTER TABLE Correo ADD CONSTRAINT PK_Correo 
  PRIMARY KEY (Id);

ALTER TABLE DiarioProcesos ADD CONSTRAINT PK_DiarioProcesos 
  PRIMARY KEY (Id);

ALTER TABLE DireccionCorreo ADD CONSTRAINT PK_DireccionCorreo 
  PRIMARY KEY (Codigo);

ALTER TABLE Divisa ADD CONSTRAINT I_Divisa_1 
  PRIMARY KEY (Codigo);

ALTER TABLE Empresa ADD CONSTRAINT PK_Empresa 
  PRIMARY KEY (Codigo);

ALTER TABLE EntidadFinanciera ADD CONSTRAINT Index_1 
  PRIMARY KEY (Codigo, Sucursal);

ALTER TABLE EstructuraFichero ADD CONSTRAINT PK_EstructuraFichero 
  PRIMARY KEY (Fichero, NroRegistro);

ALTER TABLE Ficheros ADD CONSTRAINT PK_Ficheros 
  PRIMARY KEY (CodigoEmpresa, NombreFichero);

ALTER TABLE InformeExterno ADD CONSTRAINT PK_InformeExterno 
  PRIMARY KEY (TipoDocumento, NroRegistro);

ALTER TABLE LineaEstructFichero ADD CONSTRAINT PK_LineaEstructFichero 
  PRIMARY KEY (Fichero, NroRegistro, NroLinea);

ALTER TABLE Notificacion ADD CONSTRAINT Index_1 
  PRIMARY KEY (Grupo);

ALTER TABLE Pais ADD CONSTRAINT PK_Pais 
  PRIMARY KEY (Codigo);

ALTER TABLE PGC ADD CONSTRAINT PK_PGC 
  PRIMARY KEY (Codigo);

ALTER TABLE Planificador ADD CONSTRAINT PK_Planificador 
  PRIMARY KEY (Id);

ALTER TABLE PlantillaGrafico ADD CONSTRAINT PK_PlantillaGrafico 
  PRIMARY KEY (Tipo, NroOperacion, NroRegistro);

ALTER TABLE Provincia ADD CONSTRAINT PK_Provincia 
  PRIMARY KEY (CodigoPais, Codigo);

ALTER TABLE RecursosPlanificador ADD CONSTRAINT PK_RecursosPlanificador 
  PRIMARY KEY (Id);

ALTER TABLE Registro ADD CONSTRAINT I_Registro_1 
  PRIMARY KEY (IdPadre, Clave);

ALTER TABLE TipoCambio ADD CONSTRAINT PK_TipoCambio 
  PRIMARY KEY (Fecha, CodigoDivisa);

ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario 
  PRIMARY KEY (Codigo);

/*******************************************************************************
 * Unique Constraints
 * ------------------
 * Extracted at 29/08/2025 19:23:12
 ******************************************************************************/

ALTER TABLE CodigoPostal ADD CONSTRAINT FK_CodigoPostal_Pais 
  UNIQUE (CodigoPais);

ALTER TABLE CodigoPostal ADD CONSTRAINT FK_CodigoPostal_Provincia 
  UNIQUE (CodigoPais, CodigoProvincia);

ALTER TABLE Correo ADD CONSTRAINT FK_Correo_Empresa 
  UNIQUE (CodigoEmpresa);

ALTER TABLE Correo ADD CONSTRAINT FK_Correo_Usuario 
  UNIQUE (CodigoUsuario);

ALTER TABLE DireccionCorreo ADD CONSTRAINT FK_DireccionCorreo_DireccionCorreo 
  UNIQUE (Grupo);

ALTER TABLE Ficheros ADD CONSTRAINT FK_Ficheros_Empresa 
  UNIQUE (CodigoEmpresa);

ALTER TABLE InformeExterno ADD CONSTRAINT FK_InformeExterno_Empresa 
  UNIQUE (Empresa);

ALTER TABLE InformeExterno ADD CONSTRAINT FK_InformeExterno_Usuario 
  UNIQUE (Usuario);

ALTER TABLE LineaEstructFichero ADD CONSTRAINT FK_LineaEstructFichero_EstructuraFichero 
  UNIQUE (Fichero, NroRegistro);

ALTER TABLE Provincia ADD CONSTRAINT FK_Provincia_Pais 
  UNIQUE (CodigoPais);

ALTER TABLE TipoCambio ADD CONSTRAINT FK_TipoCambio_Divisa 
  UNIQUE (CodigoDivisa);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_Empresa 
  UNIQUE (CodigoEmpresa);

