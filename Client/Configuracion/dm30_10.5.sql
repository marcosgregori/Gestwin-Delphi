/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 21/01/2013 21:23:27
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 21/01/2013 21:23:27
 ******************************************************************************/

CREATE TABLE Almacen
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30),
    RoturaStock Boolean DEFAULT FALSE,
    FechaRotura Date, 
    CONSTRAINT PK_Almacen PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE Articulo
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(13) NOT NULL,
    Descripcion NVarChar(60),
    Familia NVarChar(3),
    CodigoBarras NVarChar(13),
    FechaAlta Date,
    Obsoleto Boolean DEFAULT FALSE,
    NoAfectarStock Boolean DEFAULT FALSE,
    NoCalcularMargen Boolean DEFAULT FALSE,
    NoAfectarCoste Boolean,
    Precio_Compra Decimal(16, 4),
    Dto_Compra Decimal(16, 4),
    Precio_Venta Double Precision,
    Recargo_Venta Decimal(16, 4),
    Dto_Venta Decimal(16, 4),
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
    CodigoProveedor NVarChar(5),
    LoteOptimo Decimal(16, 4),
    UnidadesCarga Decimal(16, 4),
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(20),
    CampoLibre4 NVarChar(20),
    CampoLibre5 Decimal(16, 4),
    CampoLibre6 Decimal(16, 4),
    CampoLibre7 Decimal(16, 4),
    CampoLibre8 Decimal(16, 4),
    CampoLibre9 Boolean DEFAULT FALSE,
    CampoLibre10 Integer,
    CampoLibre11 Integer,
    CampoLibre12 Integer,
    Oferta Boolean DEFAULT FALSE,
    OfertaPrecioVenta Decimal(16, 4),
    OfertaDescuento Decimal(16, 4),
    OfertaFechaInicial Date,
    OfertaFechaFinal Date,
    Anotacion NCLOB,
    Aviso NCLOB,
    MostrarAviso Boolean DEFAULT FALSE,
    Imagen Image, 
    CONSTRAINT PK_Articulo PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE ArticuloDatEcon
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(13) NOT NULL,
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
    DtosVent_Diciembre Decimal(16, 4), 
    CONSTRAINT PK_ArticuloDatEcon PRIMARY KEY (
      Ejercicio, 
      Codigo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC, 
      CodigoAlmacen
    )
);
CREATE TABLE AuxiliarCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoCliente NVarChar(5) NOT NULL,
    Codigo NVarChar(3) NOT NULL,
    Campo1 NVarChar(40),
    Campo2 NVarChar(40),
    Campo3 NVarChar(20),
    Campo4 NVarChar(20),
    Campo5 NVarChar(20),
    Campo6 NVarChar(20),
    Campo7 NVarChar(20),
    Campo8 NVarChar(20), 
    CONSTRAINT PK_AuxiliarCliente PRIMARY KEY (
      CodigoCliente, 
      Codigo
    )
);
CREATE TABLE AuxiliarProveedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoProveedor NVarChar(5) NOT NULL,
    Codigo NVarChar(3) NOT NULL,
    Campo1 NVarChar(40),
    Campo2 NVarChar(40),
    Campo3 NVarChar(20),
    Campo4 NVarChar(20),
    Campo5 NVarChar(20),
    Campo6 NVarChar(20),
    Campo7 NVarChar(20),
    Campo8 NVarChar(20), 
    CONSTRAINT PK_AuxiliarCliente PRIMARY KEY (
      CodigoProveedor, 
      Codigo
    )
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
    TarifaOrigen NVarChar(2),
    PrecioFinal SmallInt,
    TarifaDestino NVarChar(2),
    Borrador Boolean,
    ProveedorOrigen NVarChar(5),
    ProveedorDestino NVarChar(5),
    "Precision" SmallInt,
    Redondear Boolean,
    Multiplos5 Boolean,
    AplicarDescuento Boolean,
    ClienteOrigen NVarChar(5),
    ClienteDestino NVarChar(5), 
    CONSTRAINT PK_CambioPrecios PRIMARY KEY (
      NroRegistro
    )
);
CREATE TABLE Capturador
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroCapturador SmallInt NOT NULL,
    Descripcion NVarChar(30) NOT NULL,
    CodigoAlmacen NVarChar(2), 
    CONSTRAINT PK_ConceptoApte PRIMARY KEY (
      NroCapturador
    )
);
CREATE TABLE Clase
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroClase SmallInt NOT NULL DESCRIPTION 'Nro_Clase',
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    Peso Decimal(16, 4),
    Capacidad Decimal(16, 4),
    Tipo SmallInt, 
    CONSTRAINT PK_Clase PRIMARY KEY (
      NroClase, 
      Codigo
    )
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
    FechaUltFactura Date, 
    CONSTRAINT PK_ClienteDatEcon PRIMARY KEY (
      Ejercicio, 
      Codigo
    )
);
CREATE TABLE CodigoBarras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoBarras NVarChar(13) NOT NULL,
    CodigoArticulo NVarChar(13),
    ClaseA NVarChar(3),
    ClaseB NVarChar(3),
    ClaseC NVarChar(3), 
    CONSTRAINT PK_CodigoBarras PRIMARY KEY (
      CodigoBarras
    )
);
CREATE TABLE CodigoTarifa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30), 
    CONSTRAINT PK_CodigoTarifa PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE ConsumoCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Proveedor NVarChar(5) NOT NULL,
    FamiliaArticulo NVarChar(13) NOT NULL DESCRIPTION 'Familia_Articulo',
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
    CONSTRAINT PK_ConsumoCompras PRIMARY KEY (
      Tipo, 
      Ejercicio, 
      Proveedor, 
      FamiliaArticulo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC
    )
);
CREATE TABLE ConsumosCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoCliente NVarChar(5) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoArticulo NVarChar(13),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    Cajas Decimal(16, 4),
    Cantidad Decimal(16, 4),
    Precio Double Precision,
    Recargo Decimal(16, 4),
    PuntoVerde Decimal(16, 4),
    Descuento Decimal(16, 4),
    Fecha Date, 
    CONSTRAINT PK_ConsumosCliente PRIMARY KEY (
      CodigoCliente, 
      NroOrden
    )
);
CREATE TABLE ConsumoVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Cliente NVarChar(5) NOT NULL,
    FamiliaArticulo NVarChar(13) NOT NULL DESCRIPTION 'Familia_Articulo',
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
    CONSTRAINT PK_ConsumoVentas PRIMARY KEY (
      Tipo, 
      Ejercicio, 
      Cliente, 
      FamiliaArticulo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC
    )
);
CREATE TABLE Efecto
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Tipo SmallInt NOT NULL,
    Propietario NVarChar(5) NOT NULL,
    Serie NVarChar(2) NOT NULL,
    NroDocumento Integer NOT NULL DESCRIPTION 'Nro_Documento',
    NroEfecto SmallInt NOT NULL DESCRIPTION 'Nro_Efecto',
    FechaFactura Date DESCRIPTION 'Fecha_Factura',
    FechaVencimiento Date DESCRIPTION 'Fecha_Vencimiento',
    Importe Decimal(16, 4),
    Emitido Boolean,
    FechaEmision Date DESCRIPTION 'Fecha_Emision', 
    CONSTRAINT PK_Efecto PRIMARY KEY (
      Ejercicio, 
      Tipo, 
      Propietario, 
      Serie, 
      NroDocumento, 
      NroEfecto
    )
);
CREATE TABLE EquipoMovil
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(40),
    CodigoRuta1 NVarChar(2),
    CodigoRuta2 NVarChar(2),
    CodigoRuta3 NVarChar(2),
    CodigoRuta4 NVarChar(2),
    CodigoRuta5 NVarChar(2),
    CodigoRuta6 NVarChar(2),
    CodigoRuta7 NVarChar(2),
    CodigoRuta8 NVarChar(2),
    CodigoRuta9 NVarChar(2),
    CodigoRuta10 NVarChar(2),
    CodigoRuta11 NVarChar(2),
    CodigoRuta12 NVarChar(2),
    CodigoVendedor NVarChar(2), 
    CONSTRAINT PK_EquipoMovil PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE FacturaCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Proveedor NVarChar(5) NOT NULL,
    Serie NVarChar(2) DEFAULT EMPTY NOT NULL,
    NroFactura Integer NOT NULL,
    FechaRecepcion Date,
    Fecha Date,
    BrutoArticulos Decimal(16, 4),
    DescuentoArticulos Decimal(16, 4),
    DescuentoProveedores Decimal(16, 4),
    ImportePuntoVerde Decimal(16, 4),
    NetoFactura Decimal(16, 4),
    NetoFacturaRetencion Decimal(16, 4),
    Origen SmallInt DESCRIPTION 'Intracomunitaria',
    BaseImponible0 Decimal(16, 4),
    BaseImponible1 Decimal(16, 4),
    BaseImponible2 Decimal(16, 4),
    BaseImponible3 Decimal(16, 4),
    BaseImponible4 Decimal(16, 4),
    BaseImponible5 Decimal(16, 4),
    BaseImponible6 Decimal(16, 4),
    BaseImponible7 Decimal(16, 4),
    BaseImponible8 Decimal(16, 4),
    BaseImponible9 Decimal(16, 4),
    BaseImponible10 Decimal(16, 4),
    BaseImponible11 Decimal(16, 4),
    BaseImponible12 Decimal(16, 4),
    BaseNoSujetaDto0 Decimal(16, 4),
    BaseNoSujetaDto1 Decimal(16, 4),
    BaseNoSujetaDto2 Decimal(16, 4),
    BaseNoSujetaDto3 Decimal(16, 4),
    BaseNoSujetaDto4 Decimal(16, 4),
    BaseNoSujetaDto5 Decimal(16, 4),
    BaseNoSujetaDto6 Decimal(16, 4),
    BaseNoSujetaDto7 Decimal(16, 4),
    BaseNoSujetaDto8 Decimal(16, 4),
    BaseNoSujetaDto9 Decimal(16, 4),
    BaseNoSujetaDto10 Decimal(16, 4),
    BaseNoSujetaDto11 Decimal(16, 4),
    BaseNoSujetaDto12 Decimal(16, 4),
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
    Traspasada Boolean DEFAULT FALSE,
    Anotacion NCLOB, 
    CONSTRAINT PK_FacturaCompras PRIMARY KEY (
      Ejercicio, 
      Proveedor, 
      Serie, 
      NroFactura
    )
);
CREATE TABLE FacturaVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Serie NVarChar(2) DEFAULT EMPTY NOT NULL,
    NroFactura Integer NOT NULL,
    CodigoCliente NVarChar(5),
    Fecha Date,
    GrupoFacturacion NVarChar(3),
    CodigoVendedor NVarChar(2),
    RegistroAuxiliar NVarChar(3),
    CodigoFormaCobro NVarChar(2),
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
    NetoFactura Decimal(16, 4),
    NetoFacturaRetencion Decimal(16, 4),
    BaseImponible0 Decimal(16, 4),
    BaseImponible1 Decimal(16, 4),
    BaseImponible2 Decimal(16, 4),
    BaseImponible3 Decimal(16, 4),
    BaseImponible4 Decimal(16, 4),
    BaseImponible5 Decimal(16, 4),
    BaseImponible6 Decimal(16, 4),
    BaseImponible7 Decimal(16, 4),
    BaseImponible8 Decimal(16, 4),
    BaseImponible9 Decimal(16, 4),
    BaseImponible10 Decimal(16, 4),
    BaseImponible11 Decimal(16, 4),
    BaseImponible12 Decimal(16, 4),
    BaseNoSujetaDto0 Decimal(16, 4),
    BaseNoSujetaDto1 Decimal(16, 4),
    BaseNoSujetaDto2 Decimal(16, 4),
    BaseNoSujetaDto3 Decimal(16, 4),
    BaseNoSujetaDto4 Decimal(16, 4),
    BaseNoSujetaDto5 Decimal(16, 4),
    BaseNoSujetaDto6 Decimal(16, 4),
    BaseNoSujetaDto7 Decimal(16, 4),
    BaseNoSujetaDto8 Decimal(16, 4),
    BaseNoSujetaDto9 Decimal(16, 4),
    BaseNoSujetaDto10 Decimal(16, 4),
    BaseNoSujetaDto11 Decimal(16, 4),
    BaseNoSujetaDto12 Decimal(16, 4),
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
    TotalACuenta Decimal(16, 4),
    Traspasada Boolean,
    FechaValor Date,
    FechaEnvioPorCorreo Date,
    Anotacion NCLOB, 
    CONSTRAINT PK_FacturaVentas PRIMARY KEY (
      Ejercicio, 
      Serie, 
      NroFactura
    )
);
CREATE TABLE Familia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    Cta_Compras NVarChar(9),
    Cta_DevCompras NVarChar(9),
    Cta_Ventas NVarChar(9),
    Cta_DevVentas NVarChar(9), 
    CONSTRAINT PK_Familia PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE GrupoCliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    CtaVentas NVarChar(9),
    CtaDevVentas NVarChar(9), 
    CONSTRAINT PK_GrupoCliente PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE GrupoDocumento
  DESCRIPTION 'Data/DataDict File'
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30), 
    CONSTRAINT PK_GrupoDocumento PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE GrupoLineaMovimiento
  DESCRIPTION 'Data/DataDict File'
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroPagina SmallInt NOT NULL,
    CodigoGrupo NVarChar(2) DEFAULT EMPTY,
    Descripcion NVarChar(30),
    Anotacion NCLOB, 
    CONSTRAINT PK_GrupoLineaMovimiento PRIMARY KEY (
      Ejercicio, 
      NroOperacion, 
      NroPagina
    )
);
CREATE TABLE GrupoProveedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(3) NOT NULL,
    Descripcion NVarChar(30),
    CtaCompras NVarChar(9),
    CtaDevCompras NVarChar(9), 
    CONSTRAINT PK_GrupoProveedor PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE LineaMovimiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    NroPagina SmallInt DEFAULT EMPTY NOT NULL,
    NroLinea SmallInt NOT NULL,
    Fecha Date,
    NroRegistro AutoInc,
    AsignacionOrigen SmallInt DEFAULT 0,
    TipoMovimientoOrigen SmallInt,
    EjercicioOrigen SmallInt,
    NroOperacionOrigen Integer,
    NroRegistroOrigen Integer,
    UIDArticulo GUID,
    CodigoArticulo NVarChar(13),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    LoteFabricacion NVarChar(20) DEFAULT EMPTY,
    NumeroSerie NVarChar(20) DEFAULT EMPTY,
    Descripcion NVarChar(60),
    CodigoAlmacen NVarChar(2) DEFAULT EMPTY,
    Ubicacion NVarChar(6) DEFAULT EMPTY,
    Cantidad Decimal(16, 4) DEFAULT EMPTY,
    CantidadAjustada Decimal(16, 4),
    CantidadProcesada Decimal(16, 4) DEFAULT EMPTY,
    PrecioDivisa Decimal(16, 4) DEFAULT EMPTY,
    Precio Double Precision DEFAULT EMPTY,
    Recargo Decimal(16, 4) DEFAULT EMPTY,
    PuntoVerde Decimal(16, 4) DEFAULT EMPTY,
    Descuento Decimal(16, 4) DEFAULT EMPTY,
    NroCajas Decimal(16, 4) DEFAULT EMPTY,
    Largo Decimal(16, 4) DEFAULT EMPTY,
    Ancho Decimal(16, 4) DEFAULT EMPTY,
    Alto Decimal(16, 4) DEFAULT EMPTY,
    Bultos Decimal(16, 4),
    NoCalcularMargen Boolean,
    TipoLinea NVarChar(2),
    Oferta Boolean,
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
    Anotacion NCLOB, 
    CONSTRAINT PK_LineaMovimiento PRIMARY KEY (
      Ejercicio, 
      NroOperacion, 
      NroPagina, 
      NroLinea
    )
);
CREATE TABLE LineaRuta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoRuta NVarChar(2) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoCliente NVarChar(5), 
    CONSTRAINT PK_LineaRuta PRIMARY KEY (
      CodigoRuta, 
      NroOrden
    )
);
CREATE TABLE LineaRutaDistribucion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoRuta NVarChar(2) NOT NULL,
    NroOrden SmallInt NOT NULL,
    CodigoCliente NVarChar(5),
    NroDocumento1 Integer,
    NroDocumento2 Integer,
    NroDocumento3 Integer,
    NroDocumento4 Integer, 
    CONSTRAINT PK_LineaRutaDistribucion PRIMARY KEY (
      CodigoRuta, 
      NroOrden
    )
);
CREATE TABLE LineaVentaPeriodica
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroFicha Integer NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CodigoArticulo NVarChar(13),
    CodigoClaseA NVarChar(3) DEFAULT EMPTY,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY,
    NumeroSerie NVarChar(20) DEFAULT EMPTY,
    Descripcion NVarChar(60),
    Cantidad Decimal(16, 4),
    Precio Double Precision,
    Recargo Decimal(16, 4),
    Descuento Decimal(16, 4),
    Anotacion NCLOB, 
    CONSTRAINT PK_LineaVentaPeriodica PRIMARY KEY (
      NroFicha, 
      NroRegistro
    )
);
CREATE TABLE ListaMateriales
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoArticulo NVarChar(13) NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL,
    NroLinea SmallInt NOT NULL,
    CodigoComponente NVarChar(13),
    ClaseAComponente NVarChar(3) DEFAULT EMPTY,
    ClaseBComponente NVarChar(3) DEFAULT EMPTY,
    ClaseCComponente NVarChar(3) DEFAULT EMPTY,
    Referencia NVarChar(13) DEFAULT EMPTY,
    Largo Decimal(16, 4),
    Ancho Decimal(16, 4),
    Alto Decimal(16, 4),
    Cantidad Decimal(16, 4),
    Anotacion NCLOB, 
    CONSTRAINT PK_ListaMateriales PRIMARY KEY (
      CodigoArticulo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC, 
      NroLinea
    )
);
CREATE TABLE Movimiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroOperacion Integer NOT NULL,
    TipoMovimiento SmallInt,
    Propietario NVarChar(5) DEFAULT EMPTY,
    Serie NVarChar(2) DEFAULT EMPTY,
    NroDocumento Integer DEFAULT EMPTY,
    Fecha Date,
    FechaAplicacion Date,
    FechaEmision Date,
    FechaAuxiliar Date,
    GrupoFacturacion NVarChar(3) DEFAULT EMPTY,
    RegistroAuxiliar NVarChar(3) DEFAULT EMPTY,
    CodigoVendedor NVarChar(2) DEFAULT EMPTY,
    CodigoOperario NVarChar(2),
    CentroCoste NVarChar(3) DEFAULT EMPTY,
    EjercicioFactura SmallInt DEFAULT EMPTY,
    PropietarioFactura NVarChar(5) DEFAULT EMPTY,
    SerieFactura NVarChar(2) DEFAULT EMPTY,
    NroFactura Integer DEFAULT EMPTY,
    NoFacturar Boolean DEFAULT EMPTY,
    Facturado Boolean DEFAULT EMPTY,
    Traspasado Boolean DEFAULT EMPTY,
    Periodico Boolean DEFAULT EMPTY,
    NroDocumentoPropietario NVarChar(15),
    ImporteNeto Decimal(16, 4),
    EntregaACuenta Decimal(16, 4),
    EntregaEfectivo Decimal(16, 4),
    CodigoTransportista NVarChar(2) DEFAULT EMPTY,
    Portes Decimal(16, 4),
    CodigoFormaCobro NVarChar(2) DEFAULT EMPTY,
    Situacion SmallInt DEFAULT EMPTY,
    Descripcion NVarChar(30),
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    Creado Timestamp DEFAULT CURRENT_TIMESTAMP,
    Revisado Boolean,
    Anotacion NCLOB, 
    CONSTRAINT PK_Movimiento PRIMARY KEY (
      Ejercicio, 
      NroOperacion
    )
);
CREATE TABLE Operario
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30), 
    CONSTRAINT PK_GrupoCliente PRIMARY KEY (
      Codigo
    )
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
    Descuentos_Septiem Decimal(16, 4),
    Descuentos_Octubre Decimal(16, 4),
    Descuentos_Noviembre Decimal(16, 4),
    Descuentos_Diciembre Decimal(16, 4),
    FechaUltFactura Date, 
    CONSTRAINT PK_ProveedorDatEcon PRIMARY KEY (
      Ejercicio, 
      Codigo
    )
);
CREATE TABLE RelacionAlbaranes
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroRegistro SmallInt NOT NULL,
    Ejercicio SmallInt,
    Codigo NVarChar(3),
    Propietario NVarChar(5),
    Fecha Date,
    Serie NVarChar(2),
    NroDocumento Integer,
    NroOperacion Integer, 
    CONSTRAINT PK_RelacionAlbaranes PRIMARY KEY (
      NroRegistro
    )
);
CREATE TABLE Ruta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30), 
    CONSTRAINT PK_Ruta PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE SerieFacturacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(30),
    FormatoAlbaran SmallInt,
    FormatoFactura SmallInt,
    FormatoRecibo SmallInt,
    ExentoIVA Boolean,
    Contabilizar Boolean,
    Empresa_Destino NVarChar(3),
    Afectar_Stock Boolean,
    CentroCoste NVarChar(3),
    Canal NVarChar(9), 
    CONSTRAINT PK_SerieFacturacion PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE Stock
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    CodigoArticulo NVarChar(13) NOT NULL DESCRIPTION 'Codigo',
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_A',
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_B',
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL DESCRIPTION 'Clase_C',
    LoteFabricacion NVarChar(20) DEFAULT EMPTY NOT NULL,
    CodigoAlmacen NVarChar(2) DEFAULT EMPTY NOT NULL DESCRIPTION 'Almacen',
    Ubicacion NVarChar(6) DEFAULT EMPTY NOT NULL,
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
    Diciembre_Salidas Decimal(16, 4), 
    CONSTRAINT PK_Stock PRIMARY KEY (
      Ejercicio, 
      CodigoArticulo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC, 
      LoteFabricacion, 
      Ubicacion, 
      CodigoAlmacen
    )
);
CREATE TABLE TablaComision
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Relacion SmallInt NOT NULL,
    CodigoVendedor NVarChar(2) NOT NULL DESCRIPTION 'Codigo_Vendedor',
    CodigoCliente NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(13) NOT NULL DESCRIPTION 'Codigo_Articulo',
    Tipo Decimal(16, 4), 
    CONSTRAINT PK_TablaComision PRIMARY KEY (
      Relacion, 
      CodigoVendedor, 
      CodigoCliente, 
      CodigoArticulo
    )
);
CREATE TABLE TarifaCantidadVenta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoCliente NVarChar(5) DEFAULT EMPTY NOT NULL,
    CodigoArticulo NVarChar(13) DEFAULT EMPTY NOT NULL,
    CodigoClaseA NVarChar(3) DEFAULT EMPTY NOT NULL,
    CodigoClaseB NVarChar(3) DEFAULT EMPTY NOT NULL,
    CodigoClaseC NVarChar(3) DEFAULT EMPTY NOT NULL,
    NroRegistro SmallInt NOT NULL,
    CantidadMinima Decimal(16, 4),
    CantidadMaxima Decimal(16, 4),
    Precio Decimal(16, 4),
    Descuento Decimal(16, 4), 
    CONSTRAINT PK_TarifaCantidadVenta PRIMARY KEY (
      CodigoCliente, 
      CodigoArticulo, 
      CodigoClaseA, 
      CodigoClaseB, 
      CodigoClaseC, 
      NroRegistro
    )
);
CREATE TABLE TarifaClase
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Seccion SmallInt NOT NULL,
    CodigoPropietario NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(13) NOT NULL,
    ClaseA NVarChar(3) DEFAULT EMPTY NOT NULL,
    ClaseB NVarChar(3) DEFAULT EMPTY NOT NULL,
    ClaseC NVarChar(3) DEFAULT EMPTY NOT NULL,
    Precio Decimal(16, 4),
    Descuento Decimal(16, 4), 
    CONSTRAINT PK_TarifaClase PRIMARY KEY (
      Seccion, 
      CodigoPropietario, 
      CodigoArticulo, 
      ClaseA, 
      ClaseB, 
      ClaseC
    )
);
CREATE TABLE TarifaCompras
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt DEFAULT 0 NOT NULL,
    Proveedor NVarChar(5) NOT NULL,
    Articulo NVarChar(13) NOT NULL,
    Referencia NVarChar(20),
    Precio Decimal(16, 4),
    Descuento Decimal(16, 4), 
    CONSTRAINT PK_TarifaCompras PRIMARY KEY (
      Tipo, 
      Proveedor, 
      Articulo
    )
);
CREATE TABLE TarifaVentas
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt NOT NULL,
    CodigoTarifa NVarChar(5) NOT NULL,
    CodigoArticulo NVarChar(13) NOT NULL,
    Referencia NVarChar(13) DEFAULT EMPTY,
    Precio Decimal(16, 4),
    Recargo Decimal(16, 4),
    Descuento Decimal(16, 4), 
    CONSTRAINT PK_TarifaVentas PRIMARY KEY (
      Tipo, 
      CodigoTarifa, 
      CodigoArticulo
    )
);
CREATE TABLE TipoEnvase
  DESCRIPTION 'Data/DataDict File'
(
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30), 
    CONSTRAINT I_TipoEnvase_1 PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE TipoLineaMovimiento
  DESCRIPTION 'Data/DataDict File'
(
    Codigo NVarChar(2),
    Descripcion NVarChar(30)
);
CREATE TABLE TipoMovAlmacen
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Tipo SmallInt NOT NULL,
    Descripcion NVarChar(25),
    NoAfectarCoste Boolean DEFAULT FALSE, 
    CONSTRAINT PK_TipoMovAlmacen PRIMARY KEY (
      Tipo
    )
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
    CodigoPostal NVarChar(3),
    Matricula NVarChar(20),
    NIF NVarChar(15),
    Telefono NVarChar(20),
    Movil NVarChar(20),
    Fax NVarChar(20),
    EMail NVarChar(80),
    Anotacion NCLOB, 
    CONSTRAINT PK_Transportista PRIMARY KEY (
      Codigo
    )
);
CREATE TABLE Ubicacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoAlmacen NVarChar(2) NOT NULL,
    Codigo NVarChar(6) NOT NULL,
    Descripcion NVarChar(30), 
    CONSTRAINT PK_Ubicacion PRIMARY KEY (
      CodigoAlmacen, 
      Codigo
    )
);
CREATE TABLE Vendedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Nombre NVarChar(30),
    Domicilio NVarChar(30),
    Localidad NVarChar(20),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
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
    Aviso NCLOB, 
    CONSTRAINT PK_Vendedor PRIMARY KEY (
      Codigo
    )
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
    Comision_Noviemnre Decimal(16, 4),
    Comision_Diciembre Decimal(16, 4), 
    CONSTRAINT PK_VendedorDatEcon PRIMARY KEY (
      Ejercicio, 
      Codigo
    )
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
    Serie NVarChar(2) DEFAULT EMPTY,
    RegistroAuxiliar NVarChar(3) DEFAULT EMPTY,
    Anotacion NCLOB, 
    CONSTRAINT PK_VentaPeriodica PRIMARY KEY (
      NroFicha
    )
);
/*******************************************************************************
 * Indices
 * -------
 * Extracted at 21/01/2013 21:23:30
 ******************************************************************************/

CREATE UNIQUE INDEX I_Articulo_1
 ON Articulo(Familia, Codigo);
CREATE INDEX I_Articulo_2
 ON Articulo(CodigoBarras);
CREATE INDEX I_CodigoBarras_1
 ON CodigoBarras(CodigoArticulo, ClaseA, ClaseB, ClaseC);
CREATE UNIQUE INDEX I_ConsumoCompras_1
 ON ConsumoCompras(Tipo, Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Proveedor);
CREATE INDEX I_ConsumosCliente_1
 ON ConsumosCliente(CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC);
CREATE UNIQUE INDEX I_ConsumoVentas_1
 ON ConsumoVentas(Tipo, Ejercicio, FamiliaArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, Cliente);
CREATE INDEX I_Efecto_1
 ON Efecto(Tipo, Propietario, FechaFactura);
CREATE INDEX I_Efecto_2
 ON Efecto(Tipo, Propietario, FechaVencimiento);
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
 ON LineaMovimiento(CodigoArticulo, LoteFabricacion);
CREATE INDEX I_LineaMovimiento_7
 ON LineaMovimiento(CodigoArticulo, NumeroSerie);
CREATE INDEX I_LineaMovimiento_8
 ON LineaMovimiento(NroRegistroOrigen);
CREATE INDEX I_LineaRuta_1
 ON LineaRuta(CodigoCliente);
CREATE INDEX I_LineaRutaDistribucion_1
 ON LineaRutaDistribucion(CodigoCliente);
CREATE INDEX I_ListaMateriales_1
 ON ListaMateriales(CodigoComponente, ClaseAComponente, ClaseBComponente, ClaseCComponente);
CREATE INDEX I_Movimiento_1
 ON Movimiento(Fecha);
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
CREATE UNIQUE INDEX I_RelacionAlbaranes_1
 ON RelacionAlbaranes(Codigo, Propietario, Fecha, Serie, NroDocumento);
CREATE UNIQUE INDEX I_RelacionAlbaranes2
 ON RelacionAlbaranes(Ejercicio, Propietario, Serie, NroDocumento);
CREATE UNIQUE INDEX I_Stock_1
 ON Stock(Ejercicio, CodigoAlmacen, Ubicacion, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion);
CREATE INDEX I_TarifaCantidadVenta_1
 ON TarifaCantidadVenta(CodigoCliente, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, CantidadMinima);
CREATE INDEX I_TarifaCompras_1
 ON TarifaCompras(Tipo, Proveedor, Referencia);
CREATE UNIQUE INDEX I_TarifaCompras_2
 ON TarifaCompras(Tipo, Articulo, Proveedor);
CREATE UNIQUE INDEX I_TarifaVentas_1
 ON TarifaVentas(CodigoArticulo, Tipo, CodigoTarifa);
CREATE UNIQUE INDEX Index_1
 ON TipoLineaMovimiento(Codigo);
CREATE INDEX I_VentaPeriodica_1
 ON VentaPeriodica(Serie, CodigoCliente);
/*******************************************************************************
 * Stored Procedures
 * -----------------
 * Extracted at 21/01/2013 21:23:30
 ******************************************************************************/

CREATE PROCEDURE ConsultaRMV(Tables NVarChar(100), Fields NVarChar(100), InnerSelect NVarChar(300), QueryOrder NVarChar(100))
  READS SQL DATA
BEGIN
  DECLARE Query VARCHAR( 1000 ); 

  SET Query =
  'SELECT  Movimientos.Ejercicio, Movimientos.NroOperacion, Movimientos.TipoMovimiento, Movimientos.Propietario, Movimientos.Serie, Movimientos.NroDocumento, ' +
          'Movimientos.Fecha, Movimientos.FechaAplicacion, Movimientos.Situacion, Movimientos.NoFacturar, Movimientos.Facturado, Movimientos.NroFactura, ' +
          'Movimientos.Traspasado, Movimientos.Anotacion, CAST( '''' AS NVARCHAR(30) ) AS EstadoDocumento, LineaMovimiento.*, Cliente.Nombre AS ClienteNombre, ' +
          Fields +
          ' 0E0 AS Pendiente, 0E0 AS ImporteBruto, 0E0 AS DescuentoArticulo, 0E0 AS ImportePendiente, 0E0 AS ImporteNeto, 0E0 AS CuotaIVA, 0E0 AS CuotaRE, ' + 
          'E0 AS PrecioIVA, 0E0 AS ImporteTotal, 0E0 AS StockActual, 0E0 AS Coste, 0E0 AS Margen ' +
  'FROM ( ' + InnerSelect + ' ) AS Movimientos ' +
  'LEFT JOIN LineaMovimiento ON ( Movimientos.Ejercicio=LineaMovimiento.Ejercicio AND Movimientos.NroOperacion=LineaMovimiento.NroOperacion ) ' +
  ' LEFT JOIN Cliente ON ( Movimientos.Propietario=Cliente.Codigo ) ' +
  Tables +
  'ORDER BY ' + QueryOrder + ' ;';
  
  EXECUTE IMMEDIATE Query;

END
;
