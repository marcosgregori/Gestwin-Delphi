/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 21/01/2013 21:24:39
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 21/01/2013 21:24:39
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
    Obsoleto Boolean DEFAULT FALSE,
    NoAfectarStock Boolean DEFAULT FALSE,
    NoCalcularMargen Boolean DEFAULT FALSE,
    NoAfectarCoste Boolean,
    Precio_Compra Double Precision,
    Dto_Compra Double Precision,
    Precio_Venta Double Precision,
    Recargo_Venta Double Precision,
    Dto_Venta Double Precision,
    MargenComercial Double Precision,
    TipoIVA SmallInt,
    PuntoVerde Double Precision,
    FijarMedidas Boolean DEFAULT FALSE,
    Largo Double Precision,
    Ancho Double Precision,
    Alto Double Precision,
    NoAplicarTipoFijo Boolean DEFAULT FALSE,
    NoAplicarRetencion Boolean DEFAULT FALSE,
    Comision Double Precision,
    Stock_Minimo Double Precision,
    Stock_Maximo Double Precision,
    UnidadesPorCaja Double Precision,
    UnidadesPorPallet Double Precision,
    Bultos Double Precision,
    Kilos Double Precision,
    Volumen Double Precision,
    EsListaMateriales Boolean DEFAULT FALSE,
    Desglosar Boolean DEFAULT FALSE,
    CalcularPrecios Boolean DEFAULT FALSE,
    CodigoAlmacen NVarChar(2),
    Ubicacion NVarChar(6),
    CodigoProveedor NVarChar(5),
    LoteOptimo Double Precision,
    UnidadesCarga Double Precision,
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(20),
    CampoLibre4 NVarChar(20),
    CampoLibre5 Double Precision,
    CampoLibre6 Double Precision,
    CampoLibre7 Double Precision,
    CampoLibre8 Double Precision,
    CampoLibre9 Boolean DEFAULT FALSE,
    CampoLibre10 Integer,
    CampoLibre11 Integer,
    CampoLibre12 Integer,
    Oferta Boolean DEFAULT FALSE,
    OfertaPrecioVenta Double Precision,
    OfertaDescuento Double Precision,
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
    UnidComp_Enero Double Precision,
    UnidComp_Febrero Double Precision,
    UnidComp_Marzo Double Precision,
    UnidComp_Abril Double Precision,
    UnidComp_Mayo Double Precision,
    UnidComp_Junio Double Precision,
    UnidComp_Julio Double Precision,
    UnidComp_Agosto Double Precision,
    UnidComp_Septiembre Double Precision,
    UnidComp_Octubre Double Precision,
    UnidComp_Noviembre Double Precision,
    UnidComp_Diciembre Double Precision,
    ImpComp_Enero Double Precision,
    ImpComp_Febrero Double Precision,
    ImpComp_Marzo Double Precision,
    ImpComp_Abril Double Precision,
    ImpComp_Mayo Double Precision,
    ImpComp_Junio Double Precision,
    ImpComp_Julio Double Precision,
    ImpComp_Agosto Double Precision,
    ImpComp_Septiembre Double Precision,
    ImpComp_Octubre Double Precision,
    ImpComp_Noviembre Double Precision,
    ImpComp_Diciembre Double Precision,
    DtosComp_Enero Double Precision,
    DtosComp_Febrero Double Precision,
    DtosComp_Marzo Double Precision,
    DtosComp_Abril Double Precision,
    DtosComp_Mayo Double Precision,
    DtosComp_Junio Double Precision,
    DtosComp_Julio Double Precision,
    DtosComp_Agosto Double Precision,
    DtosComp_Septiembre Double Precision,
    DtosComp_Octubre Double Precision,
    DtosComp_Noviembre Double Precision,
    DtosComp_Diciembre Double Precision,
    UnidVent_Enero Double Precision,
    UnidVent_Febrero Double Precision,
    UnidVent_Marzo Double Precision,
    UnidVent_Abril Double Precision,
    UnidVent_Mayo Double Precision,
    UnidVent_Junio Double Precision,
    UnidVent_Julio Double Precision,
    UnidVent_Agosto Double Precision,
    UnidVent_Septiembre Double Precision,
    UnidVent_octubre Double Precision,
    UnidVent_Noviembre Double Precision,
    UnidVent_Diciembre Double Precision,
    ImpVent_Enero Double Precision,
    ImpVent_Febrero Double Precision,
    ImpVent_Marzo Double Precision,
    ImpVent_Abril Double Precision,
    ImpVent_Mayo Double Precision,
    ImpVent_Junio Double Precision,
    ImpVent_Julio Double Precision,
    ImpVent_Agosto Double Precision,
    ImpVent_Septiembre Double Precision,
    ImpVent_Octubre Double Precision,
    ImpVent_Noviembre Double Precision,
    ImpVent_Diciembre Double Precision,
    DtosVent_Enero Double Precision,
    DtosVent_Febrero Double Precision,
    DtosVent_Marzo Double Precision,
    DtosVent_Abril Double Precision,
    DtosVent_Mayo Double Precision,
    DtosVent_Junio Double Precision,
    DtosVent_Julio Double Precision,
    DtosVent_Agosto Double Precision,
    DtosVent_Septiembre Double Precision,
    DtosVent_Octubre Double Precision,
    DtosVent_Noviembre Double Precision,
    DtosVent_Diciembre Double Precision, 
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
    PorcentajeOperacion Double Precision,
    ImporteOperacion Double Precision,
    MargenOperacion Double Precision,
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
    Peso Double Precision,
    Capacidad Double Precision,
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
    Pendiente Double Precision,
    Descuentos_Enero Double Precision,
    Descuentos_Febrero Double Precision,
    Descuentos_Marzo Double Precision,
    Descuentos_Abril Double Precision,
    Descuentos_Mayo Double Precision,
    Descuentos_Junio Double Precision,
    Descuentos_Julio Double Precision,
    Descuentos_Agosto Double Precision,
    Descuentos_Septiembre Double Precision,
    Descuentos_Octubre Double Precision,
    Descuentos_Noviembre Double Precision,
    Descuentos_Diciembre Double Precision,
    Coste_Enero Double Precision,
    Coste_Febrero Double Precision,
    Coste_Marzo Double Precision,
    Coste_Abril Double Precision,
    Coste_Mayo Double Precision,
    Coste_Junio Double Precision,
    Coste_Julio Double Precision,
    Coste_Agosto Double Precision,
    Coste_Septiembre Double Precision,
    Coste_Octubre Double Precision,
    Coste_Noviembre Double Precision,
    Coste_Diciembre Double Precision,
    Ventas_Enero Double Precision,
    Ventas_Febrero Double Precision,
    Ventas_Marzo Double Precision,
    Ventas_Abril Double Precision,
    Ventas_Mayo Double Precision,
    Ventas_Junio Double Precision,
    Ventas_Julio Double Precision,
    Ventas_Agosto Double Precision,
    Ventas_Septiembre Double Precision,
    Ventas_Octubre Double Precision,
    Ventas_Noviembre Double Precision,
    Ventas_Diciembre Double Precision,
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
    Unidades_Enero Double Precision,
    Unidades_Febrero Double Precision,
    Unidades_Marzo Double Precision,
    Unidades_Abril Double Precision,
    Unidades_Mayo Double Precision,
    Unidades_Junio Double Precision,
    Unidades_Julio Double Precision,
    Unidades_Agosto Double Precision,
    Unidades_Septiembre Double Precision,
    Unidades_Octubre Double Precision,
    Unidades_Noviembre Double Precision,
    Unidades_Diciembre Double Precision,
    Importe_Enero Double Precision,
    Importe_Febrero Double Precision,
    Importe_Marzo Double Precision,
    Importe_Abril Double Precision,
    Importe_Mayo Double Precision,
    Importe_Junio Double Precision,
    Importe_Julio Double Precision,
    Importe_Agosto Double Precision,
    Importe_Septiembre Double Precision,
    Importe_Octubre Double Precision,
    Importe_Noviembre Double Precision,
    Importe_Diciembre Double Precision, 
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
    Cajas Double Precision,
    Cantidad Double Precision,
    Precio Double Precision,
    Recargo Double Precision,
    PuntoVerde Double Precision,
    Descuento Double Precision,
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
    Unidades_Enero Double Precision,
    Unidades_Febrero Double Precision,
    Unidades_Marzo Double Precision,
    Unidades_Abril Double Precision,
    Unidades_Mayo Double Precision,
    Unidades_Junio Double Precision,
    Unidades_Julio Double Precision,
    Unidades_Agosto Double Precision,
    Unidades_Septiembre Double Precision,
    Unidades_Octubre Double Precision,
    Unidades_Noviembre Double Precision,
    Unidades_Diciembre Double Precision,
    Importe_Enero Double Precision,
    Importe_Febrero Double Precision,
    Importe_Marzo Double Precision,
    Importe_Abril Double Precision,
    Importe_Mayo Double Precision,
    Importe_Junio Double Precision,
    Importe_Julio Double Precision,
    Importe_Agosto Double Precision,
    Importe_Septiembre Double Precision,
    Importe_Octubre Double Precision,
    Importe_Noviembre Double Precision,
    Importe_Diciembre Double Precision, 
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
    Importe Double Precision,
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
    NroFactura Integer NOT NULL DESCRIPTION 'Nro_Factura',
    FechaRecepcion Date DESCRIPTION 'Fecha_Recepcion',
    Fecha Date,
    BrutoArticulos Double Precision DESCRIPTION 'Bruto_Articulos',
    DescuentoArticulos Double Precision DESCRIPTION 'Dto_Articulos',
    DescuentoProveedores Double Precision DESCRIPTION 'Dto_Proveedores',
    ImportePuntoVerde Double Precision,
    NetoFactura Double Precision DESCRIPTION 'Neto_Factura',
    NetoFacturaRetencion Double Precision,
    Intracomunitaria Boolean,
    BaseImponible0 Double Precision,
    BaseImponible1 Double Precision,
    BaseImponible2 Double Precision,
    BaseImponible3 Double Precision,
    BaseImponible4 Double Precision,
    BaseImponible5 Double Precision,
    BaseImponible6 Double Precision,
    BaseImponible7 Double Precision,
    BaseImponible8 Double Precision,
    BaseImponible9 Double Precision,
    BaseImponible10 Double Precision,
    BaseImponible11 Double Precision,
    BaseImponible12 Double Precision,
    BaseNoSujetaDto0 Double Precision,
    BaseNoSujetaDto1 Double Precision,
    BaseNoSujetaDto2 Double Precision,
    BaseNoSujetaDto3 Double Precision,
    BaseNoSujetaDto4 Double Precision,
    BaseNoSujetaDto5 Double Precision,
    BaseNoSujetaDto6 Double Precision,
    BaseNoSujetaDto7 Double Precision,
    BaseNoSujetaDto8 Double Precision,
    BaseNoSujetaDto9 Double Precision,
    BaseNoSujetaDto10 Double Precision,
    BaseNoSujetaDto11 Double Precision,
    BaseNoSujetaDto12 Double Precision,
    BaseCalculoRetencion Double Precision,
    TipoRetencion SmallInt,
    ImporteRetencion Double Precision,
    RecargoFinanciero Double Precision,
    ImporteRecFinanciero Double Precision,
    CuotaIVA Double Precision DESCRIPTION 'Cuota_IVA',
    Portes Double Precision,
    TotalFactura Double Precision DESCRIPTION 'Total_Factura',
    DescuentoPP Double Precision DESCRIPTION 'Descuento_PP',
    ImporteDtoPP Double Precision,
    DescuentoES Double Precision DESCRIPTION 'Descuento_ES',
    ImporteDtoES Double Precision,
    CodigoFormaPago NVarChar(2) DESCRIPTION 'Forma_de_Pago',
    DiaPago1 SmallInt DESCRIPTION 'Dia_Pago_1',
    DiaPago2 SmallInt DESCRIPTION 'Dia_Pago_2',
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
    NroFactura Integer NOT NULL DESCRIPTION 'Nro_Factura',
    CodigoCliente NVarChar(5) DESCRIPTION 'Codigo_Cliente',
    Fecha Date,
    GrupoFacturacion NVarChar(3) DESCRIPTION 'Grupo_Facturacion',
    CodigoVendedor NVarChar(2) DESCRIPTION 'Codigo_Vendedor',
    RegistroAuxiliar NVarChar(3),
    CodigoFormaCobro NVarChar(2) DESCRIPTION 'Forma_Cobro',
    DiaCobro1 SmallInt DESCRIPTION 'Dia_Cobro_1',
    DiaCobro2 SmallInt DESCRIPTION 'Dia_Cobro_2',
    DescuentoPP Double Precision DESCRIPTION 'Descuento_PP',
    ImporteDtoPP Double Precision,
    DescuentoES Double Precision DESCRIPTION 'Descuento_ES',
    ImporteDtoES Double Precision,
    TipoComision Double Precision,
    CosteArticulos Double Precision DESCRIPTION 'Coste_Articulos',
    BrutoArticulos Double Precision DESCRIPTION 'Bruto_Articulos',
    DescuentosArticulos Double Precision DESCRIPTION 'Dtos_Articulos',
    DescuentosClientes Double Precision DESCRIPTION 'Dtos_Clientes',
    ImportePuntoVerde Double Precision,
    NetoFactura Double Precision DESCRIPTION 'Neto_Factura',
    NetoFacturaRetencion Double Precision,
    BaseImponible0 Double Precision,
    BaseImponible1 Double Precision,
    BaseImponible2 Double Precision,
    BaseImponible3 Double Precision,
    BaseImponible4 Double Precision,
    BaseImponible5 Double Precision,
    BaseImponible6 Double Precision,
    BaseImponible7 Double Precision,
    BaseImponible8 Double Precision,
    BaseImponible9 Double Precision,
    BaseImponible10 Double Precision,
    BaseImponible11 Double Precision,
    BaseImponible12 Double Precision,
    BaseNoSujetaDto0 Double Precision,
    BaseNoSujetaDto1 Double Precision,
    BaseNoSujetaDto2 Double Precision,
    BaseNoSujetaDto3 Double Precision,
    BaseNoSujetaDto4 Double Precision,
    BaseNoSujetaDto5 Double Precision,
    BaseNoSujetaDto6 Double Precision,
    BaseNoSujetaDto7 Double Precision,
    BaseNoSujetaDto8 Double Precision,
    BaseNoSujetaDto9 Double Precision,
    BaseNoSujetaDto10 Double Precision,
    BaseNoSujetaDto11 Double Precision,
    BaseNoSujetaDto12 Double Precision,
    BaseCalculoRetencion Double Precision,
    TipoRetencion SmallInt,
    ImporteRetencion Double Precision,
    RecargoFinanciero Double Precision,
    ImporteRecFinanciero Double Precision,
    CuotaIVA Double Precision DESCRIPTION 'Cuota_IVA',
    CuotaRE Double Precision DESCRIPTION 'Cuota_RE',
    Comision Double Precision,
    Portes Double Precision,
    TotalFactura Double Precision DESCRIPTION 'Total_Factura',
    TotalACuenta Double Precision DESCRIPTION 'Total_a_Cuenta',
    Traspasada Boolean,
    FechaValor Date DESCRIPTION 'Fecha_Valor',
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
    Cantidad Double Precision DEFAULT EMPTY,
    CantidadProcesada Double Precision DEFAULT EMPTY,
    PrecioDivisa Double Precision DEFAULT EMPTY,
    Precio Double Precision DEFAULT EMPTY,
    Recargo Double Precision DEFAULT EMPTY,
    PuntoVerde Double Precision DEFAULT EMPTY,
    Descuento Double Precision DEFAULT EMPTY,
    NroCajas Double Precision DEFAULT EMPTY,
    Largo Double Precision DEFAULT EMPTY,
    Ancho Double Precision DEFAULT EMPTY,
    Alto Double Precision DEFAULT EMPTY,
    Bultos Double Precision,
    NoCalcularMargen Boolean,
    TipoLinea NVarChar(2),
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
    Cantidad Double Precision,
    Precio Double Precision,
    Recargo Double Precision,
    Descuento Double Precision,
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
    Largo Double Precision,
    Ancho Double Precision,
    Alto Double Precision,
    Cantidad Double Precision,
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
    ImporteNeto Double Precision,
    EntregaACuenta Double Precision,
    EntregaEfectivo Double Precision,
    CodigoTransportista NVarChar(2) DEFAULT EMPTY,
    Portes Double Precision,
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
    Compras_Enero Double Precision,
    Compras_Febrero Double Precision,
    Compras_Marzo Double Precision,
    Compras_Abril Double Precision,
    Compras_Mayo Double Precision,
    Compras_Junio Double Precision,
    Compras_Julio Double Precision,
    Compras_Agosto Double Precision,
    Compras_Septiembre Double Precision,
    Compras_Octubre Double Precision,
    Compras_Noviembre Double Precision,
    Compras_Diciembre Double Precision,
    Descuentos_Enero Double Precision,
    Descuentos_Febrero Double Precision,
    Descuentos_Marzo Double Precision,
    Descuentos_Abril Double Precision,
    Descuentos_Mayo Double Precision,
    Descuentos_Junio Double Precision,
    Descuentos_Julio Double Precision,
    Descuentos_Agosto Double Precision,
    Descuentos_Septiem Double Precision,
    Descuentos_Octubre Double Precision,
    Descuentos_Noviembre Double Precision,
    Descuentos_Diciembre Double Precision,
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
    PrecioUltCompra Double Precision,
    CosteUltEntrada Double Precision,
    Coste_Medio Double Precision,
    PrecioUltVenta Double Precision,
    PrecioUltSalida Double Precision,
    Pendiente_Recibir0 Double Precision,
    Pendiente_Recibir Double Precision,
    Pendiente_Servir0 Double Precision,
    Pendiente_Servir Double Precision,
    Reservado Double Precision,
    Apertura_Entradas Double Precision,
    Apertura_Salidas Double Precision,
    Enero_Entradas Double Precision,
    Enero_Salidas Double Precision,
    Febrero_Entradas Double Precision,
    Febrero_Salidas Double Precision,
    Marzo_Entradas Double Precision,
    Marzo_Salidas Double Precision,
    Abril_Entradas Double Precision,
    Abril_Salidas Double Precision,
    Mayo_Entradas Double Precision,
    Mayo_Salidas Double Precision,
    Junio_Entradas Double Precision,
    Junio_Salidas Double Precision,
    Julio_Entradas Double Precision,
    Julio_Salidas Double Precision,
    Agosto_Entradas Double Precision,
    Agosto_Salidas Double Precision,
    Septiembre_Entradas Double Precision,
    Septiembre_Salidas Double Precision,
    Octubre_Entradas Double Precision,
    Octubre_Salidas Double Precision,
    Noviembre_Entradas Double Precision,
    Noviembre_Salidas Double Precision,
    Diciembre_Entradas Double Precision,
    Diciembre_Salidas Double Precision, 
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
    Tipo Double Precision, 
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
    CantidadMinima Double Precision,
    CantidadMaxima Double Precision,
    Precio Double Precision,
    Descuento Double Precision, 
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
    Precio Double Precision,
    Descuento Double Precision, 
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
    Precio Double Precision,
    Descuento Double Precision, 
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
    Precio Double Precision,
    Recargo Double Precision,
    Descuento Double Precision, 
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
    Comision Double Precision,
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
    Ventas_Enero Double Precision,
    Ventas_Febrero Double Precision,
    Ventas_Marzo Double Precision,
    Ventas_Abril Double Precision,
    Ventas_Mayo Double Precision,
    Ventas_Junio Double Precision,
    Ventas_Julio Double Precision,
    Ventas_Agosto Double Precision,
    Ventas_Septiembre Double Precision,
    Ventas_Octubre Double Precision,
    Ventas_Noviembre Double Precision,
    Ventas_Diciembre Double Precision,
    Comision_Enero Double Precision,
    Comision_Febrero Double Precision,
    Comision_Marzo Double Precision,
    Comision_Abril Double Precision,
    Comision_Mayo Double Precision,
    Comision_Junio Double Precision,
    Comision_Julio Double Precision,
    Comision_Agosto Double Precision,
    Comision_Septiembre Double Precision,
    Comision_Octubre Double Precision,
    Comision_Noviemnre Double Precision,
    Comision_Diciembre Double Precision, 
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
 * Extracted at 21/01/2013 21:24:42
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
 * Extracted at 21/01/2013 21:24:42
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
