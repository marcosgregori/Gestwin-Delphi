/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 19:20:52
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 19:20:52
 ******************************************************************************/

CREATE TABLE Almacen
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30),
    RoturaStock Boolean DEFAULT FALSE,
    FechaRotura Date
);

CREATE TABLE Articulo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(20) NOT NULL,
    Descripcion NVarChar(60),
    Familia NVarChar(6) DEFAULT EMPTY,
    CodigoBarras NVarChar(20),
    FechaAlta Date,
    Obsoleto Boolean DEFAULT FALSE,
    NoAfectarStock Boolean DEFAULT FALSE,
    NoCalcularMargen Boolean DEFAULT FALSE,
    NoAfectarCoste Boolean,
    Precio_Compra Double Precision,
    UnidadesPrecioCompra Integer DEFAULT 1,
    Dto_Compra Decimal(16, 4),
    Precio_Venta Double Precision,
    UnidadesPrecioVenta Integer DEFAULT 1,
    Recargo_Venta Decimal(16, 4),
    Dto_Venta Decimal(16, 4),
    CantidadMinimaVenta Decimal(16, 4),
    MargenComercial Decimal(16, 4),
    TipoIVA SmallInt,
    PuntoVerde Decimal(16, 4),
    FijarMedidas Boolean DEFAULT FALSE,
    Largo Decimal(16, 4),
    Ancho Decimal(16, 4),
    Alto Decimal(16, 4),
    NoAplicarTipoFijo Boolean DEFAULT FALSE,
    NoAplicarRetencion Boolean DEFAULT FALSE,
    Comision Decimal(16, 4),
    Stock_Minimo Decimal(16, 4),
    Stock_Maximo Decimal(16, 4),
    UnidadesPorCaja Decimal(16, 4),
    UnidadesPorPallet Decimal(16, 4),
    Bultos Decimal(16, 4),
    Kilos Decimal(16, 4),
    Volumen Decimal(16, 4),
    EsListaMateriales Boolean DEFAULT FALSE,
    Desglosar Boolean DEFAULT FALSE,
    CalcularPrecios Boolean DEFAULT FALSE,
    CodigoAlmacen NVarChar(2),
    Ubicacion NVarChar(6),
    CodigoProveedor NVarChar(5) DEFAULT EMPTY,
    LoteOptimo Decimal(16, 4),
    UnidadesCarga Decimal(16, 4),
    ConEnvase Boolean,
    Peligroso Boolean,
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(40),
    CampoLibre4 NVarChar(40),
    CampoLibre5 Decimal(16, 4),
    CampoLibre6 Decimal(16, 4),
    CampoLibre7 Decimal(16, 4),
    CampoLibre8 Decimal(16, 4),
    CampoLibre9 Boolean DEFAULT FALSE,
    CampoLibre10 Integer,
    CampoLibre11 Integer,
    CampoLibre12 Integer,
    CampoLibre13 NVarChar(40),
    CampoLibre14 NVarChar(40),
    CampoLibre15 NCLOB,
    CampoLibre16 NCLOB,
    Oferta Boolean DEFAULT FALSE,
    OfertaPrecioVenta Double Precision,
    OfertaDescuento Decimal(16, 4),
    OfertaFechaInicial Date,
    OfertaFechaFinal Date,
    Parametros Word,
    VisibleTienda Boolean,
    Tienda_CodigoCategoria NVarChar(80) DESCRIPTION 'CodigoCategoria',
    Tienda_CodigoArticuloAgrupado NVarChar(20) DESCRIPTION 'CodigoArticuloAgrupado',
    Tienda_VisibleIndividualmente Boolean DESCRIPTION 'VisibleIndividualmente',
    Tienda_NoPublicarClases Boolean DESCRIPTION 'IncluirClasesComoOpciones',
    Tienda_ComentariosClientes Boolean,
    Tienda_NombreImagen NVarChar(20) DESCRIPTION 'NombreImagen',
    DocumentosExternos NVarChar(255),
    Anotacion NCLOB,
    Aviso NCLOB,
    MostrarAviso Boolean DEFAULT FALSE,
    Imagen Image
);

CREATE TABLE ArticuloDatEcon
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(20) NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_A',
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_B',
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_C',
    CodigoAlmacen NVarChar(2) DEFAULT EMPTY NOT NULL DESCRIPTION 'Almacen',
    UnidComp_Enero Decimal(16, 4),
    UnidComp_Febrero Decimal(16, 4),
    UnidComp_Marzo Decimal(16, 4),
    UnidComp_Abril Decimal(16, 4),
    UnidComp_Mayo Decimal(16, 4),
    UnidComp_Junio Decimal(16, 4),
    UnidComp_Julio Decimal(16, 4),
    UnidComp_Agosto Decimal(16, 4),
    UnidComp_Septiembre Decimal(16, 4),
    UnidComp_Octubre Decimal(16, 4),
    UnidComp_Noviembre Decimal(16, 4),
    UnidComp_Diciembre Decimal(16, 4),
    ImpComp_Enero Decimal(16, 4),
    ImpComp_Febrero Decimal(16, 4),
    ImpComp_Marzo Decimal(16, 4),
    ImpComp_Abril Decimal(16, 4),
    ImpComp_Mayo Decimal(16, 4),
    ImpComp_Junio Decimal(16, 4),
    ImpComp_Julio Decimal(16, 4),
    ImpComp_Agosto Decimal(16, 4),
    ImpComp_Septiembre Decimal(16, 4),
    ImpComp_Octubre Decimal(16, 4),
    ImpComp_Noviembre Decimal(16, 4),
    ImpComp_Diciembre Decimal(16, 4),
    DtosComp_Enero Decimal(16, 4),
    DtosComp_Febrero Decimal(16, 4),
    DtosComp_Marzo Decimal(16, 4),
    DtosComp_Abril Decimal(16, 4),
    DtosComp_Mayo Decimal(16, 4),
    DtosComp_Junio Decimal(16, 4),
    DtosComp_Julio Decimal(16, 4),
    DtosComp_Agosto Decimal(16, 4),
    DtosComp_Septiembre Decimal(16, 4),
    DtosComp_Octubre Decimal(16, 4),
    DtosComp_Noviembre Decimal(16, 4),
    DtosComp_Diciembre Decimal(16, 4),
    UnidVent_Enero Decimal(16, 4),
    UnidVent_Febrero Decimal(16, 4),
    UnidVent_Marzo Decimal(16, 4),
    UnidVent_Abril Decimal(16, 4),
    UnidVent_Mayo Decimal(16, 4),
    UnidVent_Junio Decimal(16, 4),
    UnidVent_Julio Decimal(16, 4),
    UnidVent_Agosto Decimal(16, 4),
    UnidVent_Septiembre Decimal(16, 4),
    UnidVent_octubre Decimal(16, 4),
    UnidVent_Noviembre Decimal(16, 4),
    UnidVent_Diciembre Decimal(16, 4),
    ImpVent_Enero Decimal(16, 4),
    ImpVent_Febrero Decimal(16, 4),
    ImpVent_Marzo Decimal(16, 4),
    ImpVent_Abril Decimal(16, 4),
    ImpVent_Mayo Decimal(16, 4),
    ImpVent_Junio Decimal(16, 4),
    ImpVent_Julio Decimal(16, 4),
    ImpVent_Agosto Decimal(16, 4),
    ImpVent_Septiembre Decimal(16, 4),
    ImpVent_Octubre Decimal(16, 4),
    ImpVent_Noviembre Decimal(16, 4),
    ImpVent_Diciembre Decimal(16, 4),
    DtosVent_Enero Decimal(16, 4),
    DtosVent_Febrero Decimal(16, 4),
    DtosVent_Marzo Decimal(16, 4),
    DtosVent_Abril Decimal(16, 4),
    DtosVent_Mayo Decimal(16, 4),
    DtosVent_Junio Decimal(16, 4),
    DtosVent_Julio Decimal(16, 4),
    DtosVent_Agosto Decimal(16, 4),
    DtosVent_Septiembre Decimal(16, 4),
    DtosVent_Octubre Decimal(16, 4),
    DtosVent_Noviembre Decimal(16, 4),
    DtosVent_Diciembre Decimal(16, 4)
);

CREATE TABLE ArticulosRelacionados
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(20),
    Tipo SmallInt DEFAULT 0,
    NroOrden SmallInt,
    CodigoArticuloRelacionado NVarChar(20)
);

CREATE TABLE AuxiliarCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    CodigoCliente NVarChar(5) DEFAULT EMPTY,
    Codigo NVarChar(3) NOT NULL,
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(8),
    Campo1 NVarChar(60),
    Campo2 NVarChar(60),
    Campo3 NVarChar(60),
    Campo4 NVarChar(60),
    Campo5 NVarChar(60),
    Campo6 NVarChar(60),
    Campo7 NVarChar(60),
    Campo8 NVarChar(60),
    CampoFecha1 Date DESCRIPTION 'Campo9',
    CampoFecha2 Date DESCRIPTION 'Campo10',
    CodigoEAN NVarChar(13),
    Anotacion NCLOB
);

CREATE TABLE AuxiliarProveedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    CodigoProveedor NVarChar(5) DEFAULT EMPTY,
    Codigo NVarChar(3) NOT NULL,
    Campo1 NVarChar(60),
    Campo2 NVarChar(60),
    Campo3 NVarChar(60),
    Campo4 NVarChar(60),
    Campo5 NVarChar(60),
    Campo6 NVarChar(60),
    Campo7 NVarChar(60),
    Campo8 NVarChar(60),
    CampoFecha1 Date DESCRIPTION 'Campo9',
    CampoFecha2 Date DESCRIPTION 'Campo10'
);

CREATE TABLE CambioPrecios
  DESCRIPTION 'Data/DataDict File'
(
    NroRegistro SmallInt NOT NULL,
    Descripcion NVarChar(30),
    Seleccion SmallInt,
    CodigoInicial NVarChar(13),
    CodigoFinal NVarChar(13),
    Operacion SmallInt,
    PorcentajeOperacion Decimal(16, 4),
    ImporteOperacion Decimal(16, 4),
    MargenOperacion Decimal(16, 4),
    PrecioReferencia SmallInt,
    Origen SmallInt DEFAULT 0,
    ProveedorOrigen NVarChar(5),
    TarifaOrigen NVarChar(2),
    ClienteOrigen NVarChar(5),
    PrecioFinal SmallInt,
    Destino SmallInt DEFAULT 0,
    ProveedorDestino NVarChar(5),
    TarifaDestino NVarChar(2),
    ClienteDestino NVarChar(5),
    AplicarDescuento Boolean,
    "Precision" SmallInt,
    Redondear Boolean,
    Multiplos5 Boolean,
    Borrador Boolean
);

CREATE TABLE Capturador
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroCapturador SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    CodigoAlmacen NVarChar(2)
);

CREATE TABLE Clase
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroClase SmallInt NOT NULL DESCRIPTION 'Nro_Clase',
    Codigo NVarChar(3) NOT NULL,
    NroOrden SmallInt DEFAULT 0,
    Descripcion NVarChar(30),
    Peso Decimal(16, 4),
    Capacidad Decimal(16, 4),
    Tipo SmallInt,
    Material SmallInt,
    TarifaRAPNormal Decimal(16, 4),
    TarifaRAPPeligroso Decimal(16, 4),
    DisponibleTienda Boolean
);

CREATE TABLE ClasesArticulo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(20) NOT NULL,
    NroClase SmallInt DEFAULT 1,
    CodigoClase NVarChar(3) NOT NULL DESCRIPTION 'CodigoClaseA'
);

CREATE TABLE ClienteDatEcon
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(5) NOT NULL,
    Pendiente Decimal(16, 4),
    Descuentos_Enero Decimal(16, 4),
    Descuentos_Febrero Decimal(16, 4),
    Descuentos_Marzo Decimal(16, 4),
    Descuentos_Abril Decimal(16, 4),
    Descuentos_Mayo Decimal(16, 4),
    Descuentos_Junio Decimal(16, 4),
    Descuentos_Julio Decimal(16, 4),
    Descuentos_Agosto Decimal(16, 4),
    Descuentos_Septiembre Decimal(16, 4),
    Descuentos_Octubre Decimal(16, 4),
    Descuentos_Noviembre Decimal(16, 4),
    Descuentos_Diciembre Decimal(16, 4),
    Coste_Enero Decimal(16, 4),
    Coste_Febrero Decimal(16, 4),
    Coste_Marzo Decimal(16, 4),
    Coste_Abril Decimal(16, 4),
    Coste_Mayo Decimal(16, 4),
    Coste_Junio Decimal(16, 4),
    Coste_Julio Decimal(16, 4),
    Coste_Agosto Decimal(16, 4),
    Coste_Septiembre Decimal(16, 4),
    Coste_Octubre Decimal(16, 4),
    Coste_Noviembre Decimal(16, 4),
    Coste_Diciembre Decimal(16, 4),
    Ventas_Enero Decimal(16, 4),
    Ventas_Febrero Decimal(16, 4),
    Ventas_Marzo Decimal(16, 4),
    Ventas_Abril Decimal(16, 4),
    Ventas_Mayo Decimal(16, 4),
    Ventas_Junio Decimal(16, 4),
    Ventas_Julio Decimal(16, 4),
    Ventas_Agosto Decimal(16, 4),
    Ventas_Septiembre Decimal(16, 4),
    Ventas_Octubre Decimal(16, 4),
    Ventas_Noviembre Decimal(16, 4),
    Ventas_Diciembre Decimal(16, 4),
    FechaUltFactura Date
);

CREATE TABLE CodigoBarras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoBarras NVarChar(20) NOT NULL,
    CodigoArticulo NVarChar(20),
    ClaseA NVarChar(3) DEFAULT EMPTY,
    ClaseB NVarChar(3) DEFAULT EMPTY,
    ClaseC NVarChar(3) DEFAULT EMPTY
);

CREATE TABLE CodigoTarifa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30),
    PrecioParametro1 Double Precision,
    PrecioParametro2 Double Precision,
    PrecioParametro3 Double Precision,
    PrecioParametro4 Double Precision,
    PrecioParametro5 Double Precision,
    PrecioParametro6 Double Precision
);

CREATE TABLE ConsumoCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Proveedor NVarChar(5) NOT NULL,
    FamiliaArticulo NVarChar(20) NOT NULL DESCRIPTION 'Familia_Articulo',
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_A',
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_B',
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_C',
    Unidades_Enero Decimal(16, 4),
    Unidades_Febrero Decimal(16, 4),
    Unidades_Marzo Decimal(16, 4),
    Unidades_Abril Decimal(16, 4),
    Unidades_Mayo Decimal(16, 4),
    Unidades_Junio Decimal(16, 4),
    Unidades_Julio Decimal(16, 4),
    Unidades_Agosto Decimal(16, 4),
    Unidades_Septiembre Decimal(16, 4),
    Unidades_Octubre Decimal(16, 4),
    Unidades_Noviembre Decimal(16, 4),
    Unidades_Diciembre Decimal(16, 4),
    Importe_Enero Decimal(16, 4),
    Importe_Febrero Decimal(16, 4),
    Importe_Marzo Decimal(16, 4),
    Importe_Abril Decimal(16, 4),
    Importe_Mayo Decimal(16, 4),
    Importe_Junio Decimal(16, 4),
    Importe_Julio Decimal(16, 4),
    Importe_Agosto Decimal(16, 4),
    Importe_Septiembre Decimal(16, 4),
    Importe_Octubre Decimal(16, 4),
    Importe_Noviembre Decimal(16, 4),
    Importe_Diciembre Decimal(16, 4),
    ImporteDescuentos_Enero Decimal(16, 4),
    ImporteDescuentos_Febrero Decimal(16, 4),
    ImporteDescuentos_Marzo Decimal(16, 4),
    ImporteDescuentos_Abril Decimal(16, 4),
    ImporteDescuentos_Mayo Decimal(16, 4),
    ImporteDescuentos_Junio Decimal(16, 4),
    ImporteDescuentos_Julio Decimal(16, 4),
    ImporteDescuentos_Agosto Decimal(16, 4),
    ImporteDescuentos_Septiembre Decimal(16, 4),
    ImporteDescuentos_Octubre Decimal(16, 4),
    ImporteDescuentos_Noviembre Decimal(16, 4),
    ImporteDescuentos_Diciembre Decimal(16, 4)
);

CREATE TABLE ConsumosCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoCliente NVarChar(5) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Cajas Decimal(16, 4),
    Cantidad Decimal(16, 4),
    CantidadMedia Decimal(16, 0),
    PrecioActual Double Precision,
    UltimoPrecio Double Precision,
    Precio Double Precision,
    PrecioMedio Double Precision,
    UltimoRecargo Decimal(16, 0),
    Recargo Decimal(16, 4),
    RecargoMedio Decimal(14, 0),
    UltimoPuntoVerde Decimal(16, 0),
    PuntoVerde Decimal(16, 4),
    ContribucionRAP Decimal(16, 4),
    DescuentoActual Decimal(16, 4),
    UltimoDescuento Decimal(16, 0),
    Descuento Decimal(16, 4),
    DescuentoMedio Decimal(16, 0),
    Fecha Date
);

CREATE TABLE ConsumoVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Cliente NVarChar(5) NOT NULL,
    FamiliaArticulo NVarChar(20) NOT NULL DESCRIPTION 'Familia_Articulo',
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_A',
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_B',
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_C',
    Unidades_Enero Decimal(16, 4),
    Unidades_Febrero Decimal(16, 4),
    Unidades_Marzo Decimal(16, 4),
    Unidades_Abril Decimal(16, 4),
    Unidades_Mayo Decimal(16, 4),
    Unidades_Junio Decimal(16, 4),
    Unidades_Julio Decimal(16, 4),
    Unidades_Agosto Decimal(16, 4),
    Unidades_Septiembre Decimal(16, 4),
    Unidades_Octubre Decimal(16, 4),
    Unidades_Noviembre Decimal(16, 4),
    Unidades_Diciembre Decimal(16, 4),
    Importe_Enero Decimal(16, 4),
    Importe_Febrero Decimal(16, 4),
    Importe_Marzo Decimal(16, 4),
    Importe_Abril Decimal(16, 4),
    Importe_Mayo Decimal(16, 4),
    Importe_Junio Decimal(16, 4),
    Importe_Julio Decimal(16, 4),
    Importe_Agosto Decimal(16, 4),
    Importe_Septiembre Decimal(16, 4),
    Importe_Octubre Decimal(16, 4),
    Importe_Noviembre Decimal(16, 4),
    Importe_Diciembre Decimal(16, 4),
    ImporteDescuentos_Enero Decimal(16, 4),
    ImporteDescuentos_Febrero Decimal(16, 4),
    ImporteDescuentos_Marzo Decimal(16, 4),
    ImporteDescuentos_Abril Decimal(16, 4),
    ImporteDescuentos_Mayo Decimal(16, 4),
    ImporteDescuentos_Junio Decimal(16, 4),
    ImporteDescuentos_Julio Decimal(16, 4),
    ImporteDescuentos_Agosto Decimal(16, 4),
    ImporteDescuentos_Septiembre Decimal(16, 4),
    ImporteDescuentos_Octubre Decimal(16, 4),
    ImporteDescuentos_Noviembre Decimal(16, 4),
    ImporteDescuentos_Diciembre Decimal(16, 4)
);

CREATE TABLE Efecto
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Propietario NVarChar(5) NOT NULL,
    Serie NVarChar(40) NOT NULL,
    NroDocumento Integer NOT NULL DESCRIPTION 'Nro_Documento',
    NroEfecto SmallInt NOT NULL DESCRIPTION 'Nro_Efecto',
    FechaFactura Date DESCRIPTION 'Fecha_Factura',
    FechaVencimiento Date DESCRIPTION 'Fecha_Vencimiento',
    Importe Decimal(16, 4),
    Emitido Boolean,
    FechaEmision Date DESCRIPTION 'Fecha_Emision'
);

CREATE TABLE EquipoMovil
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(40),
    CodigoVendedor NVarChar(2),
    CodigoUsuario NVarChar(2)
);

CREATE TABLE ExistenciasArticulo
  DESCRIPTION 'Data/DataDict File'
(
    CodigoArticulo NVarChar(20),
    CodigoAlmacen NVarChar(6) DEFAULT EMPTY,
    Ubicacion NVarChar(10),
    StockMinimo Decimal(16, 4),
    StockMaximo Decimal(16, 4)
);

CREATE TABLE FacturaCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
(
    Ejercicio SmallInt NOT NULL,
    Proveedor NVarChar(5) NOT NULL,
    SerieNroFactura NVarChar(40) DEFAULT EMPTY NOT NULL DESCRIPTION 'Serie',
    FechaRecepcion Date,
    Fecha Date,
    BrutoArticulos Decimal(16, 4),
    DescuentoArticulos Decimal(16, 4),
    DescuentoProveedores Decimal(16, 4),
    ImportePuntoVerde Decimal(16, 4),
    NetoFactura Decimal(16, 4),
    NetoFacturaRetencion Decimal(16, 4),
    Origen SmallInt DESCRIPTION 'Intracomunitaria',
    BaseCalculoRetencion Decimal(16, 4),
    TipoRetencion SmallInt,
    ImporteRetencion Decimal(16, 4),
    RecargoFinanciero Decimal(16, 4),
    ImporteRecFinanciero Decimal(16, 4),
    CuotaIVA Decimal(16, 4),
    Portes Decimal(16, 4),
    TotalFactura Decimal(16, 4),
    DescuentoPP Decimal(16, 4),
    ImporteDtoPP Decimal(16, 4),
    DescuentoES Decimal(16, 4),
    ImporteDtoES Decimal(16, 4),
    CodigoFormaPago NVarChar(2),
    DiaPago1 SmallInt,
    DiaPago2 SmallInt,
    NroRegistro Integer,
    Traspasada Boolean DEFAULT FALSE,
    PagoBloqueado Boolean,
    MotivoBloqueoPago NCLOB,
    Anotacion NCLOB
);

CREATE TABLE FacturaVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    Serie NVarChar(2) DEFAULT EMPTY,
    NroFactura Integer NOT NULL,
    CodigoCliente NVarChar(5) DEFAULT EMPTY,
    Fecha Date,
    NroRegistroPresentacion DWord DEFAULT 0 DESCRIPTION 'Nro de orden presentación en Veri*factu',
    GrupoFacturacion NVarChar(3) DEFAULT EMPTY,
    CodigoVendedor NVarChar(2) DEFAULT EMPTY,
    RegistroAuxiliar NVarChar(3) DEFAULT EMPTY,
    CodigoFormaCobro NVarChar(2) DEFAULT EMPTY,
    OrganismoPublico NVarChar(12),
    OrganoProponente NVarChar(12),
    NumeroExpediente NVarChar(20),
    NumeroContrato NVarChar(20),
    ReferenciaOperacion NVarChar(20),
    ServicioPrestadoTemporalmente Boolean,
    InicioPeriodoFacturacion Date,
    FinPeriodoFacturacion Date,
    Subvencionada Boolean,
    ImporteSubvencion Decimal(16, 4),
    DiaCobro1 SmallInt,
    DiaCobro2 SmallInt,
    DescuentoPP Decimal(16, 4),
    ImporteDtoPP Decimal(16, 4),
    DescuentoES Decimal(16, 4),
    ImporteDtoES Decimal(16, 4),
    TipoComision Decimal(16, 4),
    CosteArticulos Decimal(16, 4),
    BrutoArticulos Decimal(16, 4),
    DescuentosArticulos Decimal(16, 4),
    DescuentosClientes Decimal(16, 4),
    ImportePuntoVerde Decimal(16, 4),
    ImporteContribucionRAP Decimal(16, 4),
    NetoFactura Decimal(16, 4),
    NetoFacturaRetencion Decimal(16, 4),
    BaseCalculoRetencion Decimal(16, 4),
    TipoRetencion SmallInt,
    ImporteRetencion Decimal(16, 4),
    RecargoFinanciero Decimal(16, 4),
    ImporteRecFinanciero Decimal(16, 4),
    CuotaIVA Decimal(16, 4),
    CuotaRE Decimal(16, 4),
    Comision Decimal(16, 4),
    Portes Decimal(16, 4),
    TotalFactura Decimal(16, 4),
    InversionSujetoPasivo Boolean,
    TotalACuenta Decimal(16, 4),
    Traspasada Boolean DEFAULT EMPTY,
    FechaValor Date,
    FechaEnvioPorCorreo Date,
    Anotacion NCLOB,
    Presentada Timestamp,
    Huella NVarChar(64),
    Anulada Boolean DEFAULT EMPTY
);

CREATE TABLE Familia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(6) NOT NULL,
    Descripcion NVarChar(60),
    Cta_Compras NVarChar(9),
    Cta_DevCompras NVarChar(9),
    Cta_Ventas NVarChar(9),
    Cta_DevVentas NVarChar(9)
);

CREATE TABLE FormaEnvio
  DESCRIPTION 'Data/DataDict File'
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(40),
    Portes SmallInt,
    Importe Decimal(16, 4)
);

CREATE TABLE GrupoCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    CodigoTarifa NVarChar(2),
    CtaVentas NVarChar(9),
    CtaDevVentas NVarChar(9)
);

CREATE TABLE GrupoDocumento
  DESCRIPTION 'Data/DataDict File'
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30)
);

CREATE TABLE GrupoLineaMovimiento
  DESCRIPTION 'Data/DataDict File'
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroPagina SmallInt NOT NULL,
    CodigoGrupo NVarChar(2) DEFAULT EMPTY,
    Descripcion NVarChar(30),
    Anotacion NCLOB
);

CREATE TABLE GrupoProveedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    CtaCompras NVarChar(9),
    CtaDevCompras NVarChar(9)
);

CREATE TABLE LineaMovimiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroPagina SmallInt DEFAULT EMPTY NOT NULL,
    NroLinea SmallInt NOT NULL,
    Fecha Date,
    FechaAplicacion Date,
    FechaCaducidad Date,
    NroRegistro AutoInc,
    AsignacionOrigen SmallInt DEFAULT 0,
    TipoMovimientoOrigen SmallInt,
    EjercicioOrigen SmallInt,
    NroOperacionOrigen Integer,
    NroRegistroOrigen Integer,
    UIDArticulo GUID,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    LoteFabricacion NVarChar(20) DEFAULT EMPTY,
    NumeroSerie NVarChar(40) DEFAULT EMPTY,
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 Date,
    CampoLibre4 Decimal(16, 4),
    CampoLibre5 NVarChar(40),
    Descripcion NVarChar(60),
    CodigoAlmacen NVarChar(2) DEFAULT EMPTY,
    Ubicacion NVarChar(6) DEFAULT EMPTY,
    Cantidad Decimal(16, 4) DEFAULT EMPTY,
    CantidadAjustada Decimal(16, 4),
    CantidadProcesada Decimal(16, 4) DEFAULT EMPTY,
    Procesada Boolean DEFAULT FALSE,
    PrecioDivisa Decimal(16, 4) DEFAULT EMPTY,
    Precio Double Precision DEFAULT EMPTY,
    Recargo Decimal(16, 4) DEFAULT EMPTY,
    PuntoVerde Decimal(16, 4) DEFAULT EMPTY,
    ContribucionRAP Decimal(16, 4),
    Descuento Decimal(16, 4) DEFAULT EMPTY,
    NroCajas Decimal(16, 4) DEFAULT EMPTY,
    Largo Decimal(16, 4) DEFAULT EMPTY,
    Ancho Decimal(16, 4) DEFAULT EMPTY,
    Alto Decimal(16, 4) DEFAULT EMPTY,
    Bultos Decimal(16, 4),
    ImporteRecargo Decimal(16, 4),
    PorcentajeRecargo Decimal(16, 4),
    NoCalcularMargen Boolean DEFAULT FALSE,
    TipoLinea NVarChar(3),
    Oferta Boolean DEFAULT FALSE,
    PesoEnvase Decimal(16, 4),
    Tara Decimal(16, 4),
    Peso Decimal(16, 4),
    ImporteBruto Decimal(16, 4),
    ImporteDescuento Decimal(16, 4),
    ImporteNeto Decimal(16, 4),
    CodigoTipoIVA SmallInt,
    CuotaIVA Decimal(16, 4),
    CuotaRE Decimal(16, 4),
    PrecioIVA Decimal(16, 4),
    ImporteTotal Decimal(16, 4),
    Parametros Word,
    Anotacion NCLOB
);

CREATE TABLE LineaRuta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoRuta NVarChar(2) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoCliente NVarChar(5)
);

CREATE TABLE LineaRutaDistribucion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroOperacion DWord,
    NroOrden SmallInt NOT NULL,
    CodigoCliente NVarChar(5),
    NroDocumento1 Integer,
    NroDocumento2 Integer,
    NroDocumento3 Integer,
    NroDocumento4 Integer
);

CREATE TABLE LineaVentaPeriodica
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroFicha Integer NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    NumeroSerie NVarChar(40) DEFAULT EMPTY,
    Descripcion NVarChar(60),
    Cantidad Decimal(16, 4),
    Precio Double Precision,
    Recargo Decimal(16, 4),
    Descuento Decimal(16, 4),
    Anotacion NCLOB
);

CREATE TABLE ListaMateriales
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(20) NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    NroLinea SmallInt NOT NULL,
    CodigoComponente NVarChar(20),
    ClaseAComponente NVarChar(3) DEFAULT EMPTY,
    ClaseBComponente NVarChar(3) DEFAULT EMPTY,
    ClaseCComponente NVarChar(3) DEFAULT EMPTY,
    Referencia NVarChar(20) DEFAULT EMPTY,
    Largo Decimal(16, 4),
    Ancho Decimal(16, 4),
    Alto Decimal(16, 4),
    Cantidad Decimal(16, 4),
    Anotacion NCLOB
);

CREATE TABLE Movimiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    TipoMovimiento SmallInt,
    Propietario NVarChar(5) DEFAULT EMPTY,
    Serie NVarChar(2) DEFAULT EMPTY,
    NroDocumento Integer DEFAULT EMPTY,
    UUID GUID,
    Fecha Date,
    FechaAplicacion Date,
    FechaEmision Date,
    FechaAuxiliar Date,
    GrupoFacturacion NVarChar(3) DEFAULT EMPTY,
    RegistroAuxiliar NVarChar(3) DEFAULT EMPTY,
    CodigoVendedor NVarChar(2) DEFAULT EMPTY,
    CodigoOperario NVarChar(5),
    CentroCoste NVarChar(4) DEFAULT EMPTY,
    FormaEnvio NVarChar(2),
    EjercicioFactura SmallInt DEFAULT EMPTY,
    PropietarioFactura NVarChar(5) DEFAULT EMPTY,
    SerieFactura NVarChar(40) DEFAULT EMPTY,
    NroFactura Integer DEFAULT EMPTY,
    NoFacturar Boolean DEFAULT EMPTY,
    Facturado Boolean DEFAULT EMPTY,
    Traspasado Boolean DEFAULT EMPTY,
    Anulado Boolean DEFAULT EMPTY,
    Opcion SmallInt,
    Origen SmallInt DEFAULT EMPTY DESCRIPTION 'Periodico',
    EjercicioOrigen SmallInt,
    NroOperacionOrigen Integer,
    NroDocumentoPropietario NVarChar(15),
    EntregaACuenta Decimal(16, 4),
    EntregaEfectivo Decimal(16, 4),
    CodigoTransportista NVarChar(2) DEFAULT EMPTY,
    IVAIncluido Boolean DEFAULT EMPTY,
    Portes Decimal(16, 4),
    CodigoFormaCobro NVarChar(2) DEFAULT EMPTY,
    OrganismoPublico NVarChar(12),
    Situacion SmallInt DEFAULT EMPTY,
    DescripcionMovimiento NVarChar(60) DESCRIPTION 'Descripcion',
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(40),
    CampoLibre4 NVarChar(40),
    CampoLibre5 NVarChar(40),
    TipoVentaPeriodica SmallInt,
    Creado Timestamp DEFAULT CURRENT_TIMESTAMP,
    Revisado Boolean,
    Suministrado Boolean,
    FechaEnvioPorCorreo Date,
    Anotacion NCLOB,
    Firma Image
);

CREATE TABLE Operario
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    CodigoPropietario NVarChar(5) DEFAULT EMPTY,
    Codigo NVarChar(5) NOT NULL,
    CodigoOperarioTipo NVarChar(5),
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    Telefono NVarChar(20),
    Fax NVarChar(20),
    Movil NVarChar(20),
    NIF NVarChar(20),
    EMail NVarChar(80),
    Campo1 NVarChar(40),
    Campo2 NVarChar(40),
    Campo3 NVarChar(40),
    Campo4 NVarChar(20),
    Campo5 NVarChar(20),
    Campo6 NVarChar(20),
    Campo7 NVarChar(20),
    Campo8 NVarChar(20),
    CampoFecha1 Date,
    CampoFecha2 Date
);

CREATE TABLE OrganismoPublico
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Tipo SmallInt,
    Codigo NVarChar(10) NOT NULL,
    Nombre NVarChar(80),
    Domicilio NVarChar(70),
    Localidad NVarChar(30),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    CodigoCentro NVarChar(12),
    CodigoPaisEnNIF Boolean
);

CREATE TABLE ProveedorDatEcon
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(5) NOT NULL,
    Compras_Enero Decimal(16, 4),
    Compras_Febrero Decimal(16, 4),
    Compras_Marzo Decimal(16, 4),
    Compras_Abril Decimal(16, 4),
    Compras_Mayo Decimal(16, 4),
    Compras_Junio Decimal(16, 4),
    Compras_Julio Decimal(16, 4),
    Compras_Agosto Decimal(16, 4),
    Compras_Septiembre Decimal(16, 4),
    Compras_Octubre Decimal(16, 4),
    Compras_Noviembre Decimal(16, 4),
    Compras_Diciembre Decimal(16, 4),
    Descuentos_Enero Decimal(16, 4),
    Descuentos_Febrero Decimal(16, 4),
    Descuentos_Marzo Decimal(16, 4),
    Descuentos_Abril Decimal(16, 4),
    Descuentos_Mayo Decimal(16, 4),
    Descuentos_Junio Decimal(16, 4),
    Descuentos_Julio Decimal(16, 4),
    Descuentos_Agosto Decimal(16, 4),
    Descuentos_Septiembre Decimal(16, 4) DESCRIPTION 'Descuentos_Septiem',
    Descuentos_Octubre Decimal(16, 4),
    Descuentos_Noviembre Decimal(16, 4),
    Descuentos_Diciembre Decimal(16, 4),
    FechaUltFactura Date
);

CREATE TABLE RegistroActualizacion
  DESCRIPTION 'Data/DataDict File'
(
    TipoRegistro SmallInt,
    Codigo NVarChar(20),
    Id DWord,
    Ejercicio SmallInt,
    Serie NVarChar(2),
    NroDocumento Integer,
    Actualizado Boolean,
    FechaActualizacion Timestamp,
    ImagenActualizada Boolean,
    FechaImagenExterna Timestamp,
    id1 DWord,
    id2 DWord,
    Resultado NCLOB
);

CREATE TABLE RelacionAlbaranes
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroRegistro Integer,
    Ejercicio SmallInt,
    Codigo NVarChar(3),
    Propietario NVarChar(5),
    Fecha Date,
    Serie NVarChar(2),
    NroDocumento Integer,
    NroOperacion Integer,
    Importe Decimal(16, 4)
);

CREATE TABLE RelacionDocumentos
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Tipo SmallInt DEFAULT 0 NOT NULL,
    Ejercicio SmallInt,
    NroOperacion Integer,
    CodigoArticulo NVarChar(20),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    NroProceso SmallInt,
    NroLinea SmallInt,
    Documento NVarChar(255)
);

CREATE TABLE Ruta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30)
);

CREATE TABLE RutaDistribucion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroOperacion AutoInc,
    CodigoRuta NVarChar(2) NOT NULL,
    Fecha Date DEFAULT CURRENT_DATE NOT NULL
);

CREATE TABLE RutasEquipoMovil
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    CodigoEquipoMovil NVarChar(2) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoRuta NVarChar(2) NOT NULL
);

CREATE TABLE Stock
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
(
    Ejercicio SmallInt NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL DESCRIPTION 'Codigo',
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_A',
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_B',
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_C',
    LoteFabricacion NVarChar(20) DEFAULT EMPTY NOT NULL,
    CodigoAlmacen NVarChar(2) DEFAULT EMPTY NOT NULL DESCRIPTION 'Almacen',
    Ubicacion NVarChar(6) DEFAULT EMPTY NOT NULL,
    FechaCaducidad Date,
    UIDArticulo GUID,
    FechaUltCompra Date,
    FechaUltVenta Date,
    FechaUltEntrada Date,
    FechaUltEntradaCoste Date,
    FechaUltSalida Date,
    PrecioUltCompra Decimal(16, 4),
    CosteUltEntrada Decimal(16, 4),
    Coste_Medio Decimal(16, 4),
    PrecioUltVenta Decimal(16, 4),
    PrecioUltSalida Decimal(16, 4),
    Pendiente_Recibir0 Decimal(16, 4),
    Pendiente_Recibir Decimal(16, 4),
    Pendiente_Servir0 Decimal(16, 4),
    Pendiente_Servir Decimal(16, 4),
    Reservado Decimal(16, 4),
    Apertura_Entradas Decimal(16, 4),
    Apertura_Salidas Decimal(16, 4),
    Enero_Entradas Decimal(16, 4),
    Enero_Salidas Decimal(16, 4),
    Febrero_Entradas Decimal(16, 4),
    Febrero_Salidas Decimal(16, 4),
    Marzo_Entradas Decimal(16, 4),
    Marzo_Salidas Decimal(16, 4),
    Abril_Entradas Decimal(16, 4),
    Abril_Salidas Decimal(16, 4),
    Mayo_Entradas Decimal(16, 4),
    Mayo_Salidas Decimal(16, 4),
    Junio_Entradas Decimal(16, 4),
    Junio_Salidas Decimal(16, 4),
    Julio_Entradas Decimal(16, 4),
    Julio_Salidas Decimal(16, 4),
    Agosto_Entradas Decimal(16, 4),
    Agosto_Salidas Decimal(16, 4),
    Septiembre_Entradas Decimal(16, 4),
    Septiembre_Salidas Decimal(16, 4),
    Octubre_Entradas Decimal(16, 4),
    Octubre_Salidas Decimal(16, 4),
    Noviembre_Entradas Decimal(16, 4),
    Noviembre_Salidas Decimal(16, 4),
    Diciembre_Entradas Decimal(16, 4),
    Diciembre_Salidas Decimal(16, 4)
);

CREATE TABLE TablaComision
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Relacion SmallInt NOT NULL,
    CodigoVendedor NVarChar(2) NOT NULL DESCRIPTION 'Codigo_Vendedor',
    CodigoCliente NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL DESCRIPTION 'Codigo_Articulo',
    Tipo Decimal(16, 4)
);

CREATE TABLE TarifaCantidadVenta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoCliente NVarChar(5) DEFAULT EMPTY,
    CodigoArticulo NVarChar(20) DEFAULT EMPTY NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    NroRegistro SmallInt NOT NULL,
    CantidadMinima Decimal(16, 4),
    CantidadMaxima Decimal(16, 4),
    Precio Double Precision,
    Descuento Decimal(16, 4)
);

CREATE TABLE TarifaClase
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Seccion SmallInt NOT NULL,
    CodigoPropietario NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL,
    ClaseA NVarChar(3) DEFAULT EMPTY NOT NULL,
    ClaseB NVarChar(3) DEFAULT EMPTY NOT NULL,
    ClaseC NVarChar(3) DEFAULT EMPTY NOT NULL,
    Precio Double Precision,
    Descuento Decimal(16, 4)
);

CREATE TABLE TarifaCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt DEFAULT 0 NOT NULL,
    CodigoProveedor NVarChar(5) NOT NULL DESCRIPTION 'Proveedor',
    CodigoArticulo NVarChar(20) NOT NULL DESCRIPTION 'Articulo',
    Referencia NVarChar(20) DEFAULT EMPTY,
    Precio Double Precision DEFAULT EMPTY,
    Descuento Decimal(16, 4) DEFAULT EMPTY
);

CREATE TABLE TarifaVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt NOT NULL,
    CodigoTarifa NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(20) NOT NULL,
    Referencia NVarChar(20) DEFAULT EMPTY,
    Disponible Boolean,
    CantidadMinima Decimal(20, 4),
    Precio Double Precision,
    Recargo Decimal(16, 4),
    Descuento Decimal(16, 4),
    PrecioParametro1 Double Precision,
    PrecioParametro2 Double Precision,
    PrecioParametro3 Double Precision,
    PrecioParametro4 Double Precision,
    PrecioParametro5 Double Precision,
    PrecioParametro6 Double Precision
);

CREATE TABLE TipoEnvase
  DESCRIPTION 'Data/DataDict File'
(
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30)
);

CREATE TABLE TipoLineaMovimiento
  DESCRIPTION 'Data/DataDict File'
(
    Codigo NVarChar(3),
    Descripcion NVarChar(30)
);

CREATE TABLE TipoMovAlmacen
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt NOT NULL,
    Descripcion NVarChar(25),
    NoAfectarCoste Boolean DEFAULT FALSE
);

CREATE TABLE TiposIVAArticuloPais
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    CodigoArticulo NVarChar(20),
    CodigoPais NVarChar(3),
    CodigoZona NVarChar(2),
    TipoIVA SmallInt
);

CREATE TABLE TipoVentaPeriodica
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt NOT NULL,
    Descripcion NVarChar(30)
);

CREATE TABLE Transportista
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30),
    Domicilio NVarChar(30),
    Localidad NVarChar(20),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(8),
    Matricula NVarChar(20),
    Semiremolque NVarChar(20),
    NIF NVarChar(15),
    Telefono NVarChar(20),
    Movil NVarChar(20),
    Fax NVarChar(20),
    EMail NVarChar(80),
    CodigoProveedor NVarChar(5),
    Anotacion NCLOB
);

CREATE TABLE Ubicacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoAlmacen NVarChar(2) NOT NULL,
    Codigo NVarChar(6) NOT NULL,
    Descripcion NVarChar(30),
    UbicacionDeCarga Boolean DEFAULT FALSE
);

CREATE TABLE Vendedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(8),
    NIF NVarChar(15),
    Telefono NVarChar(20),
    Movil NVarChar(20),
    Fax NVarChar(20),
    EMail NVarChar(80),
    Comision Decimal(16, 4),
    TipoIVA SmallInt,
    TipoIRPF SmallInt,
    Bloqueado Boolean DEFAULT FALSE,
    Anotacion NCLOB,
    Aviso NCLOB
);

CREATE TABLE VendedorDatEcon
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(2) NOT NULL,
    Ventas_Enero Decimal(16, 4),
    Ventas_Febrero Decimal(16, 4),
    Ventas_Marzo Decimal(16, 4),
    Ventas_Abril Decimal(16, 4),
    Ventas_Mayo Decimal(16, 4),
    Ventas_Junio Decimal(16, 4),
    Ventas_Julio Decimal(16, 4),
    Ventas_Agosto Decimal(16, 4),
    Ventas_Septiembre Decimal(16, 4),
    Ventas_Octubre Decimal(16, 4),
    Ventas_Noviembre Decimal(16, 4),
    Ventas_Diciembre Decimal(16, 4),
    Comision_Enero Decimal(16, 4),
    Comision_Febrero Decimal(16, 4),
    Comision_Marzo Decimal(16, 4),
    Comision_Abril Decimal(16, 4),
    Comision_Mayo Decimal(16, 4),
    Comision_Junio Decimal(16, 4),
    Comision_Julio Decimal(16, 4),
    Comision_Agosto Decimal(16, 4),
    Comision_Septiembre Decimal(16, 4),
    Comision_Octubre Decimal(16, 4),
    Comision_Noviembre Decimal(16, 4) DESCRIPTION 'Comision_Noviemnre',
    Comision_Diciembre Decimal(16, 4)
);

CREATE TABLE VentaPeriodica
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroFicha Integer NOT NULL,
    CodigoCliente NVarChar(5),
    Periodicidad SmallInt,
    MesPago SmallInt,
    NoAplicar Boolean,
    UltimaAplicacion Date,
    Tipo SmallInt DEFAULT 0,
    Serie NVarChar(2) DEFAULT EMPTY,
    RegistroAuxiliar NVarChar(3) DEFAULT EMPTY,
    CentroCoste NVarChar(3),
    Anotacion NCLOB
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 19:20:52
 ******************************************************************************/

CREATE UNIQUE INDEX I_Articulo_1
 ON Articulo(Familia, Codigo);

CREATE INDEX I_Articulo_2
 ON Articulo(CodigoBarras);

CREATE INDEX I_Articulo_3
 ON Articulo(Tienda_CodigoArticuloAgrupado);

CREATE INDEX Index_1
 ON Clase(NroClase, NroOrden);

CREATE INDEX Index_2
 ON Clase(NroClase, Descripcion);

CREATE INDEX I_CodigoBarras_1
 ON CodigoBarras(CodigoArticulo, ClaseA, ClaseB, ClaseC);

CREATE UNIQUE INDEX I_ConsumoCompras_1
 ON ConsumoCompras(Tipo, Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proveedor);

CREATE INDEX I_ConsumoCompras_2
 ON ConsumoCompras(Proveedor, Tipo);

CREATE INDEX I_ConsumosCliente_1
 ON ConsumosCliente(CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC);

CREATE UNIQUE INDEX I_ConsumoVentas_1
 ON ConsumoVentas(Tipo, Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Cliente);

CREATE INDEX I_ConsumoVentas_2
 ON ConsumoVentas(Cliente, Tipo);

CREATE INDEX I_Efecto_1
 ON Efecto(Tipo, Propietario, FechaFactura);

CREATE INDEX I_Efecto_2
 ON Efecto(Tipo, Propietario, FechaVencimiento);

CREATE INDEX Index_1
 ON ExistenciasArticulo(CodigoArticulo, CodigoAlmacen);

CREATE INDEX I_FacturaCompras_1
 ON FacturaCompras(Fecha);

CREATE INDEX I_FacturaCompras_2
 ON FacturaCompras(Proveedor, Fecha);

CREATE INDEX I_FacturaCompras_3
 ON FacturaCompras(FechaRecepcion);

CREATE UNIQUE INDEX I_FacturaVentas_1
 ON FacturaVentas(Serie, Fecha, NroFactura);

CREATE INDEX I_FacturaVentas_2
 ON FacturaVentas(Serie, CodigoCliente, Fecha);

CREATE INDEX I_FacturaVentas_3
 ON FacturaVentas(Serie, GrupoFacturacion, Fecha);

CREATE INDEX I_FacturaVentas_4
 ON FacturaVentas(Serie, CodigoVendedor, Fecha);

CREATE INDEX I_FacturaVentas_5
 ON FacturaVentas(Serie, CodigoFormaCobro, Fecha);

CREATE INDEX I_FacturaVentas_6
 ON FacturaVentas(Serie, RegistroAuxiliar, Fecha);

CREATE INDEX I_FacturaVentas_7
 ON FacturaVentas(CodigoCliente, Fecha);

CREATE INDEX I_FacturaVentas_8
 ON FacturaVentas(NroRegistroPresentacion);

CREATE INDEX Index_1
 ON GrupoCliente(CodigoTarifa);

CREATE INDEX I_GrupoLineaMovimiento_1
 ON GrupoLineaMovimiento(Ejercicio, NroOperacion, CodigoGrupo);

CREATE INDEX I_LineaMovimiento_1
 ON LineaMovimiento(CodigoArticulo, Fecha, NroOperacion, NroPagina, NroLinea);

CREATE INDEX I_LineaMovimiento_2
 ON LineaMovimiento(CodigoAlmacen, Ubicacion, CodigoArticulo, Fecha, NroOperacion, NroPagina, NroLinea);

CREATE INDEX I_LineaMovimiento_3
 ON LineaMovimiento(TipoMovimientoOrigen, EjercicioOrigen, NroOperacionOrigen);

CREATE INDEX I_LineaMovimiento_4
 ON LineaMovimiento(NroRegistro);

CREATE INDEX I_LineaMovimiento_5
 ON LineaMovimiento(UIDArticulo);

CREATE INDEX I_LineaMovimiento_6
 ON LineaMovimiento(CodigoArticulo, LoteFabricacion, Fecha);

CREATE INDEX I_LineaMovimiento_7
 ON LineaMovimiento(CodigoArticulo, NumeroSerie, Fecha);

CREATE INDEX I_LineaMovimiento_8
 ON LineaMovimiento(NroRegistroOrigen);

CREATE INDEX I_LineaRuta_1
 ON LineaRuta(CodigoCliente);

CREATE INDEX I_LineaRutaDistribucion_1
 ON LineaRutaDistribucion(CodigoCliente);

CREATE INDEX Index_1
 ON LineaVentaPeriodica(CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC);

CREATE INDEX I_ListaMateriales_1
 ON ListaMateriales(CodigoComponente, ClaseAComponente, ClaseBComponente, ClaseCComponente);

CREATE INDEX I_Movimiento_1
 ON Movimiento(Fecha);

CREATE INDEX I_Movimiento_10
 ON Movimiento(TipoMovimiento, Serie, FechaAplicacion, NroDocumento);

CREATE INDEX I_Movimiento_2
 ON Movimiento(TipoMovimiento, Ejercicio, Serie, NroDocumento);

CREATE INDEX I_Movimiento_3
 ON Movimiento(TipoMovimiento, Serie, Fecha, NroDocumento);

CREATE INDEX I_Movimiento_4
 ON Movimiento(TipoMovimiento, Ejercicio, Propietario, Serie, NroDocumento);

CREATE INDEX I_Movimiento_5
 ON Movimiento(TipoMovimiento, Fecha);

CREATE INDEX I_Movimiento_6
 ON Movimiento(TipoMovimiento, Propietario, Fecha);

CREATE INDEX I_Movimiento_7
 ON Movimiento(TipoMovimiento, EjercicioFactura, PropietarioFactura, SerieFactura, NroFactura);

CREATE INDEX I_Movimiento_8
 ON Movimiento(TipoMovimiento, Propietario, FechaAplicacion);

CREATE INDEX I_Movimiento_9
 ON Movimiento(UUID);

CREATE UNIQUE INDEX Index_2
 ON Operario(CodigoPropietario, Codigo);

CREATE UNIQUE INDEX Index_2
 ON RegistroActualizacion(TipoRegistro, Id);

CREATE INDEX Index_3
 ON RegistroActualizacion(TipoRegistro, Ejercicio, Serie, NroDocumento);

CREATE INDEX Index_4
 ON RegistroActualizacion(TipoRegistro, Actualizado, Codigo);

CREATE UNIQUE INDEX I_RelacionAlbaranes_1
 ON RelacionAlbaranes(Codigo, Propietario, Fecha, Serie, NroDocumento);

CREATE UNIQUE INDEX I_RelacionAlbaranes_2
 ON RelacionAlbaranes(Ejercicio, Propietario, Serie, NroDocumento);

CREATE INDEX I_RelacionAlbaranes_4
 ON RelacionAlbaranes(Fecha, Serie, NroDocumento);

CREATE INDEX Index_1
 ON RelacionDocumentos(Tipo, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroProceso, NroLinea);

CREATE INDEX Index_2
 ON RelacionDocumentos(Tipo, Ejercicio, NroOperacion);

CREATE INDEX Index_3
 ON RelacionDocumentos(Tipo, NroOperacion);

CREATE INDEX I_RutaDistribucion_0
 ON RutaDistribucion(NroOperacion);

CREATE INDEX I_RutaDistribucion_1
 ON RutaDistribucion(Fecha, CodigoRuta);

CREATE UNIQUE INDEX Index_1
 ON RutasEquipoMovil(CodigoEquipoMovil, NroOrden, CodigoRuta);

CREATE UNIQUE INDEX I_Stock_1
 ON Stock(Ejercicio, CodigoAlmacen, Ubicacion, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion);

CREATE INDEX I_TarifaCantidadVenta_1
 ON TarifaCantidadVenta(CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CantidadMinima);

CREATE INDEX I_TarifaCompras_1
 ON TarifaCompras(Tipo, CodigoProveedor, Referencia);

CREATE UNIQUE INDEX I_TarifaCompras_2
 ON TarifaCompras(Tipo, CodigoArticulo, CodigoProveedor);

CREATE UNIQUE INDEX I_TarifaVentas_1
 ON TarifaVentas(CodigoArticulo, Tipo, CodigoTarifa);

CREATE INDEX Index_1
 ON TiposIVAArticuloPais(CodigoArticulo, CodigoPais, CodigoZona);

CREATE INDEX I_VentaPeriodica_1
 ON VentaPeriodica(Serie, CodigoCliente);

CREATE INDEX I_VentaPeriodica_2
 ON VentaPeriodica(Tipo, Serie, CodigoCliente);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 19:20:52
 ******************************************************************************/

ALTER TABLE Almacen ADD CONSTRAINT PK_Almacen 
  PRIMARY KEY (Codigo);

ALTER TABLE Articulo ADD CONSTRAINT PK_Articulo 
  PRIMARY KEY (Codigo);

ALTER TABLE ArticuloDatEcon ADD CONSTRAINT PK_ArticuloDatEcon 
  PRIMARY KEY (Ejercicio, Codigo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CodigoAlmacen);

ALTER TABLE ArticulosRelacionados ADD CONSTRAINT Index_1 
  PRIMARY KEY (Codigo, Tipo, NroOrden);

ALTER TABLE AuxiliarCliente ADD CONSTRAINT PK_AuxiliarCliente 
  PRIMARY KEY (CodigoCliente, Codigo);

ALTER TABLE AuxiliarProveedor ADD CONSTRAINT PK_AuxiliarCliente 
  PRIMARY KEY (CodigoProveedor, Codigo);

ALTER TABLE CambioPrecios ADD CONSTRAINT PK_CambioPrecios 
  PRIMARY KEY (NroRegistro);

ALTER TABLE Capturador ADD CONSTRAINT PK_ConceptoApte 
  PRIMARY KEY (NroCapturador);

ALTER TABLE Clase ADD CONSTRAINT PK_Clase 
  PRIMARY KEY (NroClase, Codigo);

ALTER TABLE ClasesArticulo ADD 
  PRIMARY KEY (CodigoArticulo, NroClase, CodigoClase);

ALTER TABLE ClienteDatEcon ADD CONSTRAINT PK_ClienteDatEcon 
  PRIMARY KEY (Ejercicio, Codigo);

ALTER TABLE CodigoBarras ADD CONSTRAINT PK_CodigoBarras 
  PRIMARY KEY (CodigoBarras);

ALTER TABLE CodigoTarifa ADD CONSTRAINT PK_CodigoTarifa 
  PRIMARY KEY (Codigo);

ALTER TABLE ConsumoCompras ADD CONSTRAINT PK_ConsumoCompras 
  PRIMARY KEY (Tipo, Ejercicio, Proveedor, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC);

ALTER TABLE ConsumosCliente ADD CONSTRAINT PK_ConsumosCliente 
  PRIMARY KEY (CodigoCliente, NroOrden);

ALTER TABLE ConsumoVentas ADD CONSTRAINT PK_ConsumoVentas 
  PRIMARY KEY (Tipo, Ejercicio, Cliente, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC);

ALTER TABLE Efecto ADD CONSTRAINT PK_Efecto 
  PRIMARY KEY (Ejercicio, Tipo, Propietario, Serie, NroDocumento, NroEfecto);

ALTER TABLE EquipoMovil ADD CONSTRAINT PK_EquipoMovil 
  PRIMARY KEY (Codigo);

ALTER TABLE FacturaCompras ADD CONSTRAINT PK_FacturaCompras 
  PRIMARY KEY (Ejercicio, Proveedor, SerieNroFactura);

ALTER TABLE FacturaVentas ADD CONSTRAINT PK_FacturaVentas 
  PRIMARY KEY (Ejercicio, Serie, NroFactura);

ALTER TABLE Familia ADD CONSTRAINT PK_Familia 
  PRIMARY KEY (Codigo);

ALTER TABLE FormaEnvio ADD CONSTRAINT Index_1 
  PRIMARY KEY (Codigo);

ALTER TABLE GrupoCliente ADD CONSTRAINT PK_GrupoCliente 
  PRIMARY KEY (Codigo);

ALTER TABLE GrupoDocumento ADD CONSTRAINT PK_GrupoDocumento 
  PRIMARY KEY (Codigo);

ALTER TABLE GrupoLineaMovimiento ADD CONSTRAINT PK_GrupoLineaMovimiento 
  PRIMARY KEY (Ejercicio, NroOperacion, NroPagina);

ALTER TABLE GrupoProveedor ADD CONSTRAINT PK_GrupoProveedor 
  PRIMARY KEY (Codigo);

ALTER TABLE LineaMovimiento ADD CONSTRAINT PK_LineaMovimiento 
  PRIMARY KEY (Ejercicio, NroOperacion, NroPagina, NroLinea);

ALTER TABLE LineaRuta ADD CONSTRAINT PK_LineaRuta 
  PRIMARY KEY (CodigoRuta, NroOrden);

ALTER TABLE LineaRutaDistribucion ADD CONSTRAINT PK_LineaRutaDistribucion 
  PRIMARY KEY (NroOperacion, NroOrden);

ALTER TABLE LineaVentaPeriodica ADD CONSTRAINT PK_LineaVentaPeriodica 
  PRIMARY KEY (NroFicha, NroRegistro);

ALTER TABLE ListaMateriales ADD CONSTRAINT PK_ListaMateriales 
  PRIMARY KEY (CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroLinea);

ALTER TABLE Movimiento ADD CONSTRAINT PK_Movimiento 
  PRIMARY KEY (Ejercicio, NroOperacion);

ALTER TABLE Operario ADD CONSTRAINT PK_GrupoCliente 
  PRIMARY KEY (Codigo);

ALTER TABLE OrganismoPublico ADD CONSTRAINT PK_Vendedor 
  PRIMARY KEY (Tipo, Codigo);

ALTER TABLE ProveedorDatEcon ADD CONSTRAINT PK_ProveedorDatEcon 
  PRIMARY KEY (Ejercicio, Codigo);

ALTER TABLE RegistroActualizacion ADD CONSTRAINT Index_1 
  PRIMARY KEY (TipoRegistro, Codigo);

ALTER TABLE RelacionAlbaranes ADD CONSTRAINT PK_RelacionAlbaranes 
  PRIMARY KEY (NroRegistro);

ALTER TABLE Ruta ADD CONSTRAINT PK_Ruta 
  PRIMARY KEY (Codigo);

ALTER TABLE Stock ADD CONSTRAINT PK_Stock 
  PRIMARY KEY (Ejercicio, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion, Ubicacion, CodigoAlmacen);

ALTER TABLE TablaComision ADD CONSTRAINT PK_TablaComision 
  PRIMARY KEY (Relacion, CodigoVendedor, CodigoCliente, CodigoArticulo);

ALTER TABLE TarifaCantidadVenta ADD CONSTRAINT PK_TarifaCantidadVenta 
  PRIMARY KEY (CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroRegistro);

ALTER TABLE TarifaClase ADD CONSTRAINT PK_TarifaClase 
  PRIMARY KEY (Seccion, CodigoPropietario, CodigoArticulo, ClaseA, ClaseB, ClaseC);

ALTER TABLE TarifaCompras ADD CONSTRAINT PK_TarifaCompras 
  PRIMARY KEY (Tipo, CodigoProveedor, CodigoArticulo);

ALTER TABLE TarifaVentas ADD CONSTRAINT PK_TarifaVentas 
  PRIMARY KEY (Tipo, CodigoTarifa, CodigoArticulo);

ALTER TABLE TipoEnvase ADD CONSTRAINT I_TipoEnvase_1 
  PRIMARY KEY (Codigo);

ALTER TABLE TipoLineaMovimiento ADD CONSTRAINT Index_1 
  PRIMARY KEY (Codigo);

ALTER TABLE TipoMovAlmacen ADD CONSTRAINT PK_TipoMovAlmacen 
  PRIMARY KEY (Tipo);

ALTER TABLE TipoVentaPeriodica ADD CONSTRAINT PK_TipoMovAlmacen 
  PRIMARY KEY (Tipo);

ALTER TABLE Transportista ADD CONSTRAINT PK_Transportista 
  PRIMARY KEY (Codigo);

ALTER TABLE Ubicacion ADD CONSTRAINT PK_Ubicacion 
  PRIMARY KEY (CodigoAlmacen, Codigo);

ALTER TABLE Vendedor ADD CONSTRAINT PK_Vendedor 
  PRIMARY KEY (Codigo);

ALTER TABLE VendedorDatEcon ADD CONSTRAINT PK_VendedorDatEcon 
  PRIMARY KEY (Ejercicio, Codigo);

ALTER TABLE VentaPeriodica ADD CONSTRAINT PK_VentaPeriodica 
  PRIMARY KEY (NroFicha);

