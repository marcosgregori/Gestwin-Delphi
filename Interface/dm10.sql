/*******************************************************************************
 * Selected metadata objects
 * -------------------------
 * Extracted at 29/08/2025 18:32:55
 ******************************************************************************/

/*******************************************************************************
 * Tables
 * ------
 * Extracted at 29/08/2025 18:32:55
 ******************************************************************************/

CREATE TABLE Apunte
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Ejercicio SmallInt NOT NULL,
    NroAsiento Integer NOT NULL,
    NroApunte SmallInt NOT NULL,
    Fecha Date NOT NULL,
    Subcuenta NVarChar(9) NOT NULL,
    CentroCoste NVarChar(4) DEFAULT EMPTY,
    CuentaAnalitica NVarChar(4),
    Contrapartida NVarChar(9) DEFAULT EMPTY,
    Concepto NVarChar(80) DEFAULT EMPTY,
    Debe Decimal(16, 4) DEFAULT EMPTY,
    Haber Decimal(16, 4) DEFAULT EMPTY,
    TipoApunte SmallInt DEFAULT 0 NOT NULL,
    Punteo Boolean DEFAULT FALSE,
    EjercicioFactura SmallInt,
    Serie NVarChar(40),
    Propietario NVarChar(9),
    NroFactura Integer,
    NroEfecto SmallInt,
    BaseImponible Decimal(16, 4) DEFAULT EMPTY,
    Tipo SmallInt DEFAULT EMPTY,
    CuotaIVA Decimal(16, 4) DEFAULT EMPTY,
    CuotaRE Decimal(16, 4) DEFAULT EMPTY,
    ImporteTotal Decimal(16, 4) DEFAULT EMPTY
);

CREATE TABLE Asiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroAsiento Integer NOT NULL,
    Fecha Date NOT NULL,
    TipoAsiento SmallInt NOT NULL,
    Serie NVarChar(40) DEFAULT EMPTY,
    NroFactura Integer,
    NroEfecto SmallInt,
    FechaDocumento Date,
    Propietario NVarChar(9) DEFAULT EMPTY,
    NroRegistro Integer,
    Nombre NVarChar(40),
    Origen SmallInt DEFAULT 0 DESCRIPTION 'Intracomunitaria',
    Creado Timestamp DEFAULT CURRENT_TIMESTAMP,
    Bloqueado Boolean,
    MotivoBloqueo NCLOB,
    Usuario NVarChar(2),
    Anotacion NCLOB
);

CREATE TABLE Banco
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Subcuenta NVarChar(9) NOT NULL,
    Nombre NVarChar(40) NOT NULL,
    Domicilio NVarChar(40),
    Localidad NVarChar(30),
    CodigoPais NVarChar(3),
    CodigoProvincia NVarChar(2),
    CodigoPostal NVarChar(3),
    Subcuenta_Riesgo NVarChar(9) NOT NULL,
    Subcuenta_Intereses NVarChar(9) NOT NULL,
    Riesgo Decimal(16, 4),
    Formato SmallInt,
    DiasCancelacion SmallInt,
    DiasCancelacion19 SmallInt,
    DiasCancelacion32 SmallInt,
    DiasCancelacion58 SmallInt,
    Adeudos_Presentador NVarChar(30),
    Adeudos_NIF NVarChar(9),
    Adeudos_EntidadRec NVarChar(4),
    Adeudos_OficinaRec NVarChar(4),
    Adeudos_EntidadDep NVarChar(4),
    Adeudos_OficinaDep NVarChar(4),
    Adeudos_DCDeposito NVarChar(2),
    Adeudos_CuentaDep NVarChar(10),
    Adeudos_CodigoINE NVarChar(9),
    Adeudos_SufijoCI NVarChar(3),
    Adeudos_EntidadAde NVarChar(4),
    Adeudos_OficinaAde NVarChar(4),
    Adeudos_DCAdeudos NVarChar(2),
    Adeudos_CuentaAde NVarChar(10),
    Adeudos_EntidadImp NVarChar(4),
    Adeudos_OficinaImp NVarChar(4),
    Adeudos_DCImpagados NVarChar(2),
    Adeudos_CuentaImp NVarChar(10),
    Adeudos_CIC NVarChar(15),
    Abonos_CI NVarChar(4),
    Abonos_DCCI NVarChar(1),
    Abonos_CIC NVarChar(20),
    Anotacion NCLOB
);

CREATE TABLE CentroCoste
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(4) NOT NULL,
    Descripcion NVarChar(30) NOT NULL
);

CREATE TABLE Cliente
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(5) NOT NULL,
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3) NOT NULL,
    CodigoProvincia NVarChar(2) DEFAULT EMPTY,
    CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Telefono NVarChar(20),
    Fax NVarChar(20),
    NIF NVarChar(20),
    TipoIdentificacion SmallInt,
    EMail NVarChar(80),
    DocumentosExternos NVarChar(256),
    Vendedor NVarChar(2) DEFAULT EMPTY,
    Subcuenta NVarChar(9) NOT NULL,
    CodigoDivisa NVarChar(3) DEFAULT EMPTY,
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(20),
    CampoLibre4 NVarChar(20),
    Bloqueado Boolean DEFAULT EMPTY,
    Obsoleto Boolean DEFAULT EMPTY,
    FechaAlta Date,
    PalabraPaso NVarChar(10),
    Latitud Double Precision,
    Longitud Double Precision,
    TiendaVirtual Boolean,
    Envios_Nombre NVarChar(60),
    Envios_Domicilio NVarChar(60),
    Envios_Localidad NVarChar(40),
    Envios_CodigoProv NVarChar(2) DEFAULT EMPTY,
    Envios_CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Envios_FormaEnvio NVarChar(30),
    Envios_Transportista NVarChar(2) DEFAULT EMPTY,
    Envios_CodigoFormaEnvio NVarChar(2),
    Envios_Bloqueado Boolean,
    Envios_MotivoBloqueo NCLOB,
    Factura_DtoPP Decimal(16, 4),
    Factura_DtoES Decimal(16, 4),
    Factura_RecFinanc Decimal(16, 4),
    Factura_ModeloIVA SmallInt NOT NULL,
    Factura_TipoFijoIVA SmallInt,
    Factura_TipoRet SmallInt,
    Factura_Credito Decimal(16, 4),
    Factura_Agrupacion NVarChar(3) DEFAULT EMPTY,
    Factura_Reservado NVarChar(3),
    Factura_Tarifa NVarChar(2) DEFAULT EMPTY,
    Factura_Comision Decimal(16, 4),
    Factura_NroCopias SmallInt,
    Factura_NroCopiasAlbaran SmallInt,
    Factura_Moneda SmallInt,
    Factura_EnviarPorCorreo Boolean,
    Factura_SinDtosConsumo Boolean,
    Factura_NoAplicarOfertas Boolean,
    Factura_CodigoEAN NVarChar(13),
    Cobro_Nombre NVarChar(60),
    Cobro_Domicilio NVarChar(60),
    Cobro_Localidad NVarChar(40),
    Cobro_CodigoProv NVarChar(2) DEFAULT EMPTY,
    Cobro_CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Cobro_FormaCobro NVarChar(2) NOT NULL,
    Cobro_DiaCobro1 SmallInt,
    Cobro_DiaCobro2 SmallInt,
    Cobro_MesNoCobro SmallInt,
    Cobro_CodigoEntidad NVarChar(4),
    Cobro_Entidad NVarChar(30),
    Cobro_CodigoSucursal NVarChar(4),
    Cobro_Sucursal NVarChar(30) DEFAULT EMPTY,
    Cobro_DC NVarChar(2),
    Cobro_Cuenta NVarChar(10),
    Cobro_CtaEntidad NVarChar(9) NOT NULL,
    Cobro_CodigoINEPlaza NVarChar(9) DEFAULT EMPTY,
    Cobro_RiesgoLimite Decimal(16, 4),
    Cobro_ReferenciaMandato NVarChar(35),
    Cobro_FechaMandato Date,
    Cobro_CicloMandato SmallInt,
    Cobro_BIC NVarChar(11),
    Cobro_IBAN NVarChar(34),
    Anotacion NCLOB,
    Aviso NCLOB,
    MostrarAviso Boolean
);

CREATE TABLE ConceptoApte
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    NroConcepto SmallInt NOT NULL,
    Descripcion NVarChar(80) NOT NULL
);

CREATE TABLE Cuenta
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(9) NOT NULL,
    Nivel SmallInt NOT NULL,
    Descripcion NVarChar(125)
);

CREATE TABLE CuentaAnalitica
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CentroCoste NVarChar(4) NOT NULL,
    Codigo NVarChar(4) NOT NULL,
    Descripcion NVarChar(60)
);

CREATE TABLE DireccionContacto
  DESCRIPTION 'Data/DataDict File'
(
    Tipo SmallInt,
    Codigo NVarChar(5),
    NroRegistro SmallInt,
    Nombre NVarChar(60),
    Cargo NVarChar(40),
    Fijo NVarChar(40),
    Movil NVarChar(40),
    Fax NVarChar(40),
    Correo NVarChar(80),
    TipoDocumento SmallInt
);

CREATE TABLE Disponibilidad
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(9) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Subcuenta NVarChar(9) NOT NULL,
    Limite Decimal(16, 4)
);

CREATE TABLE EfectoCobrar
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
(
    Ejercicio SmallInt NOT NULL,
    Serie NVarChar(2) DEFAULT EMPTY,
    NroFactura Integer NOT NULL DESCRIPTION 'Nro_Factura',
    NroEfecto SmallInt DESCRIPTION 'Nro_Efecto',
    SubcuentaCliente NVarChar(9) NOT NULL DESCRIPTION 'Cliente',
    SubcuentaEntidad NVarChar(9) NOT NULL DESCRIPTION 'Entidad',
    FechaVencimiento Date NOT NULL DESCRIPTION 'Fecha_Vencimiento',
    FechaCobro Date,
    Concepto NVarChar(80),
    EjercicioRemesa SmallInt,
    NroRemesa Integer DESCRIPTION 'Nro_Remesa',
    Importe Decimal(16, 4) NOT NULL,
    ImporteCobrado Decimal(16, 4),
    ConceptoCobro NVarChar(80),
    CodigoCliente NVarChar(5),
    Vendedor NVarChar(2) DEFAULT EMPTY,
    GrupoFacturacion NVarChar(3) DEFAULT EMPTY DESCRIPTION 'Grupo_Facturacion',
    Revisado Boolean DEFAULT FALSE,
    Impagado Boolean DEFAULT FALSE,
    Cancelado Boolean DEFAULT FALSE,
    VolverAEmitir Boolean DEFAULT FALSE,
    NroEfectoReemitido SmallInt,
    FechaLibramiento Date,
    FechaEmision Date,
    FormaDePago NVarChar(2),
    DiferenciaCambio Decimal(16, 4),
    GenerarEfectoDiferencia Boolean DEFAULT FALSE,
    SubcuentaDiferencia NVarChar(9),
    NroEfectoDiferencia SmallInt,
    GastosGestion Decimal(16, 4),
    GastosDevolucion Decimal(16, 4),
    SubcuentaGastos NVarChar(9),
    NroAsientoCartera Integer,
    NroAsientoCobro Integer DESCRIPTION 'NroAsiento',
    FechaDescuento Date,
    NroAsientoDescuento Integer,
    FechaCancelacion Date,
    NroAstoCancelacion Integer,
    FechaImpagado Date,
    NroAsientoImpagado Integer,
    Anotacion NCLOB
);

CREATE TABLE EfectoPagar
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
(
    Ejercicio SmallInt NOT NULL,
    SubcuentaProveedor NVarChar(9) NOT NULL DESCRIPTION 'Proveedor',
    Serie NVarChar(40) DEFAULT EMPTY,
    NroFactura Integer DESCRIPTION 'Nro_Factura',
    NroEfecto SmallInt DESCRIPTION 'Nro_Efecto',
    SubcuentaEntidad NVarChar(9) NOT NULL DESCRIPTION 'Entidad',
    FechaVencimiento Date NOT NULL DESCRIPTION 'Fecha_Vencimiento',
    FechaPago Date,
    Concepto NVarChar(80),
    Importe Decimal(16, 4) NOT NULL,
    ImportePagado Decimal(16, 4),
    ConceptoPago NVarChar(80),
    CodigoProveedor NVarChar(5),
    FechaLibramiento Date,
    FechaEmision Date,
    FormaDePago NVarChar(2),
    DiferenciaCambio Decimal(16, 4),
    GenerarEfectoDiferencia Boolean,
    SubcuentaDiferencia NVarChar(9),
    GastosGestion Decimal(16, 4),
    SubcuentaGastos NChar(9),
    NroAsiento Integer,
    EjercicioRemesa SmallInt,
    NroRemesa Integer,
    Revisado Boolean DEFAULT FALSE,
    Anotacion NCLOB
);

CREATE TABLE Existencia
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(9) NOT NULL,
    CentroCoste NVarChar(4) DEFAULT EMPTY DESCRIPTION 'Centro_Coste',
    SaldoApertura Decimal(16, 4),
    SaldoEnero Decimal(16, 4),
    SaldoFebrero Decimal(16, 4),
    SaldoMarzo Decimal(16, 4),
    SaldoAbril Decimal(16, 4),
    SaldoMayo Decimal(16, 4),
    SaldoJunio Decimal(16, 4),
    SaldoJulio Decimal(16, 4),
    SaldoAgosto Decimal(16, 4),
    SaldoSeptiembre Decimal(16, 4),
    SaldoOctubre Decimal(16, 4),
    SaldoNoviembre Decimal(16, 4),
    SaldoDiciembre Decimal(16, 4)
);

CREATE TABLE Factura
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
  STORAGE ENGINE 'Variable'
(
    Tipo SmallInt NOT NULL,
    Ejercicio SmallInt NOT NULL,
    Propietario NVarChar(9) DEFAULT EMPTY,
    SerieFactura NVarChar(40) DEFAULT EMPTY,
    NroRegistro Integer NOT NULL,
    Creado Timestamp,
    EjercicioFraRectificada SmallInt,
    SerieFraRectificada NVarChar(40) DEFAULT EMPTY,
    NroFacturaRectificada Integer,
    Razon SmallInt,
    Metodo SmallInt,
    TipoFactura SmallInt,
    RegimenOTrascendencia SmallInt,
    TipoFacturaRectificativa SmallInt,
    CausaExencion SmallInt,
    TipoOperacionIntracomunitaria SmallInt,
    SituacionInmueble SmallInt,
    ReferenciaCatastral NVarChar(25),
    IdentificacionDescripcionBienes NVarChar(40),
    FechaInicioUtilizacion Date,
    ProrrataAnualDefinitiva Decimal(16, 4),
    Descripcion NCLOB
);

CREATE TABLE FormaCobro
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(60) NOT NULL,
    Plazos SmallInt DEFAULT EMPTY,
    PrimerVencimiento SmallInt,
    Intervalo SmallInt,
    DiaCobro1 SmallInt,
    DiaCobro2 SmallInt,
    DescuentoPP Boolean,
    TipoDescuentoPP Decimal(16, 4),
    RecargoFinanciero Boolean,
    TipoRecargoFinanc Decimal(16, 4),
    Emitir Boolean,
    CrearRegistro Boolean,
    TipoDeDocumento SmallInt,
    Aceptado Boolean,
    Gastos SmallInt,
    NoContabilizar Boolean,
    Meses30Dias Boolean,
    CanalPreferente NVarChar(9),
    CodigoFacturaE SmallInt
);

CREATE TABLE FormaPago
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) NOT NULL,
    Descripcion NVarChar(60) NOT NULL,
    Plazos SmallInt DEFAULT EMPTY,
    PrimerVencimiento SmallInt,
    Intervalo SmallInt,
    DescuentoPP Boolean,
    TipoDescuentoPP Decimal(16, 4),
    RecargoFinanciero Boolean,
    TipoRecargoFinanc Decimal(16, 4),
    Emitir Boolean,
    CrearRegistro Boolean,
    TipoDeDocumento SmallInt,
    Gastos SmallInt,
    NoContabilizar Boolean,
    CanalPreferente NVarChar(9)
);

CREATE TABLE Inmovilizado
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(9) NOT NULL,
    CentroCoste NVarChar(4) DEFAULT EMPTY,
    CodigoProveedor NVarChar(9),
    SerieNroFactura NVarChar(40),
    CuentaAmortizacion NVarChar(9) NOT NULL,
    Tipo Decimal(16, 4) NOT NULL,
    Ubicacion NVarChar(30),
    FechaCompra Date NOT NULL,
    Importe Decimal(16, 4) NOT NULL,
    CampoLibre1 NVarChar(60),
    CampoLibre2 NVarChar(60),
    CampoLibre3 NVarChar(40),
    CampoLibre4 NVarChar(40)
);

CREATE TABLE LineaInmovilizado
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(9) NOT NULL,
    NroRegistro SmallInt NOT NULL,
    Fecha Date NOT NULL,
    CodigoProveedor NVarChar(9),
    SerieNroFactura NVarChar(40),
    Descripcion NVarChar(30),
    Importe Decimal(16, 4) NOT NULL
);

CREATE TABLE LineaTipoAsiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    NroRegistro SmallInt NOT NULL DESCRIPTION 'Nro_Registro',
    NroLinea SmallInt NOT NULL DESCRIPTION 'Nro_Linea',
    Subcuenta NVarChar(9) NOT NULL,
    CtroCoste NVarChar(4) DEFAULT EMPTY,
    Contrapartida NVarChar(9),
    Concepto NVarChar(25),
    DH NVarChar(1),
    Importe Decimal(16, 4)
);

CREATE TABLE MovimientoCaja
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    Serie NVarChar(2) DEFAULT EMPTY,
    NroOperacion Integer NOT NULL,
    Fecha Date NOT NULL,
    TipoOperacion SmallInt NOT NULL,
    Propietario NVarChar(5) NOT NULL,
    FormaCobro NVarChar(2) DEFAULT EMPTY,
    Descripcion NVarChar(80),
    Importe Decimal(16, 4) NOT NULL,
    Contabilizado Boolean DEFAULT FALSE,
    NroAsiento Integer
);

CREATE TABLE Proveedor
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
  STORAGE ENGINE 'Variable'
(
    Codigo NVarChar(5) NOT NULL,
    Nombre NVarChar(60),
    Domicilio NVarChar(60),
    Localidad NVarChar(40),
    CodigoPais NVarChar(3) NOT NULL,
    CodigoProvincia NVarChar(2) DEFAULT EMPTY,
    CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Telefono NVarChar(20),
    Fax NVarChar(20),
    EMail NVarChar(80),
    DocumentosExternos NVarChar(256),
    NIF NVarChar(20),
    TipoIdentificacion SmallInt,
    Subcuenta NVarChar(9) NOT NULL,
    CodigoDivisa NVarChar(3) DEFAULT EMPTY,
    Origen SmallInt DEFAULT 0 DESCRIPTION 'Intracomunitario',
    CampoLibre1 NVarChar(40),
    CampoLibre2 NVarChar(40),
    CampoLibre3 NVarChar(20),
    CampoLibre4 NVarChar(20),
    Bloqueado Boolean DEFAULT FALSE,
    Obsoleto Boolean DEFAULT EMPTY,
    Envios_Nombre NVarChar(60),
    Envios_Domicilio NVarChar(60),
    Envios_Localidad NVarChar(40),
    Envios_CodigoProv NVarChar(2) DEFAULT EMPTY,
    Envios_CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Envios_FormaEnvio NVarChar(30) DEFAULT '',
    Factura_DtoPP Decimal(16, 4),
    Factura_DtoES Decimal(16, 4),
    Factura_RecFinanc Decimal(16, 4),
    Factura_ModeloIVA SmallInt NOT NULL,
    Factura_TipoFijoIVA SmallInt,
    Factura_TipoRet SmallInt,
    Factura_CtaCompras NVarChar(9) DEFAULT '',
    Factura_CodigoGrupo NVarChar(3) DEFAULT EMPTY,
    Factura_RegimenEspecialCC Boolean,
    Pago_Nombre NVarChar(60),
    Pago_Domicilio NVarChar(60),
    Pago_Localidad NVarChar(40),
    Pago_CodigoProv NVarChar(2) DEFAULT EMPTY,
    Pago_CodigoPostal NVarChar(8) DEFAULT EMPTY,
    Pago_FormaPago NVarChar(2) NOT NULL,
    Pago_DiaPago1 SmallInt,
    Pago_DiaPago2 SmallInt,
    Pago_MesNoPago SmallInt,
    Pago_CodigoEntidad NVarChar(4),
    Pago_Entidad NVarChar(30),
    Pago_CodigoSucursal NVarChar(4),
    Pago_Sucursal NVarChar(30),
    Pago_DC NVarChar(2),
    Pago_CuentaCorriente NVarChar(10),
    Pago_Subcuenta NVarChar(9) NOT NULL,
    Pago_BIC NVarChar(11),
    Pago_IBAN NVarChar(34),
    Pago_Bloqueado Boolean,
    Pago_MotivoBloqueo NCLOB,
    Anotacion NCLOB,
    Aviso NCLOB,
    MostrarAviso Boolean DEFAULT FALSE
);

CREATE TABLE RegistroFacturaElectronica
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Id AutoInc,
    Tipo SmallInt NOT NULL,
    Ejercicio SmallInt NOT NULL,
    Propietario NVarChar(9) NOT NULL,
    Serie NVarChar(40) NOT NULL,
    NroFactura Integer NOT NULL,
    NIFPropietario NVarChar(20),
    Fecha Date,
    Importe Decimal(16, 4),
    CodigoUsuario NVarChar(2),
    FechaRegistro Timestamp,
    Firmada Boolean
);

CREATE TABLE RegistroPresentacion
  DESCRIPTION 'Data/DataDict File'
  STORAGE ENGINE 'Variable'
(
    Tipo SmallInt NOT NULL,
    Ejercicio SmallInt NOT NULL,
    Propietario NVarChar(9) DEFAULT EMPTY NOT NULL,
    Serie NVarChar(40) NOT NULL,
    NroFactura Integer NOT NULL,
    NroEfecto SmallInt NOT NULL,
    NIFPropietario NVarChar(20),
    Importe Decimal(16, 4),
    FechaExpedicionFactura Date,
    FechaPresentacion Date,
    HoraPresentacion Time,
    EstadoPresentacion SmallInt DEFAULT 0 NOT NULL,
    EstadoRegistro SmallInt,
    CodigoErrorRegistro BigInt,
    DescripcionErrorRegistro NVarChar(500),
    Contraste SmallInt
);

CREATE TABLE RelacionesDivisa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    CodigoDivisa NVarChar(3) NOT NULL,
    DifPositivasCambio NVarChar(9) NOT NULL,
    DifNegativasCambio NVarChar(9) NOT NULL
);

CREATE TABLE Remesa
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroRemesa Integer NOT NULL,
    Fecha Date NOT NULL,
    SubcuentaEntidad NVarChar(9) NOT NULL DESCRIPTION 'Entidad',
    FechaVtoInicial Date,
    FechaVtoFinal Date,
    ImporteGastos Decimal(16, 4),
    Estado SmallInt DEFAULT EMPTY NOT NULL,
    TipoOrden SmallInt,
    CodigoOrden SmallInt,
    FechaCobro Date,
    NroAsientoCobro Integer,
    FechaAceptacion Date,
    NroAsientoAceptacion Integer,
    FechaDescuento Date,
    NroAstoDescuento1 Integer,
    NroAstoDescuento2 Integer,
    FechaCancelacion Date,
    NroAstoCancelacion Integer
);

CREATE TABLE RemesaPago
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Ejercicio SmallInt NOT NULL,
    NroRemesa Integer NOT NULL,
    Fecha Date NOT NULL,
    SubcuentaEntidad NVarChar(9) NOT NULL DESCRIPTION 'CodigoEntidad',
    SubcuentaProveedor NVarChar(9) DESCRIPTION 'CodigoProveedor',
    FechaVtoInicial Date,
    FechaVtoFinal Date,
    ImporteGastos Decimal(16, 4),
    Estado SmallInt DEFAULT EMPTY NOT NULL,
    TipoOrden SmallInt,
    CodigoOrden SmallInt,
    FechaPago Date,
    NroAsientoPago Integer
);

CREATE TABLE Saldos
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 32
(
    Ejercicio SmallInt NOT NULL,
    Codigo NVarChar(9) NOT NULL,
    CentroCoste NVarChar(4) DEFAULT EMPTY NOT NULL,
    Apertura_Debe Decimal(16, 4),
    Apertura_Haber Decimal(16, 4),
    Enero_Debe Decimal(16, 4),
    Enero_Haber Decimal(16, 4),
    Febrero_Debe Decimal(16, 4),
    Febrero_Haber Decimal(16, 4),
    Marzo_Debe Decimal(16, 4),
    Marzo_Haber Decimal(16, 4),
    Abril_Debe Decimal(16, 4),
    Abril_Haber Decimal(16, 4),
    Mayo_Debe Decimal(16, 4),
    Mayo_Haber Decimal(16, 4),
    Junio_Debe Decimal(16, 4),
    Junio_Haber Decimal(16, 4),
    Julio_Debe Decimal(16, 4),
    Julio_Haber Decimal(16, 4),
    Agosto_Debe Decimal(16, 4),
    Agosto_Haber Decimal(16, 4),
    Septiembre_Debe Decimal(16, 4),
    Septiembre_Haber Decimal(16, 4),
    Octubre_Debe Decimal(16, 4),
    Octubre_Haber Decimal(16, 4),
    Noviembre_Debe Decimal(16, 4),
    Noviembre_Haber Decimal(16, 4),
    Diciembre_Debe Decimal(16, 4),
    Diciembre_Haber Decimal(16, 4),
    Regularizacion_Debe Decimal(16, 4),
    Regularizacion_Haber Decimal(16, 4),
    Cierre_Debe Decimal(16, 4),
    Cierre_Haber Decimal(16, 4)
);

CREATE TABLE SerieFacturacion
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Codigo NVarChar(2) DEFAULT EMPTY,
    Descripcion NVarChar(30),
    FormatoPedido SmallInt,
    FormatoAlbaran SmallInt,
    FormatoFactura SmallInt,
    FormatoRecibo SmallInt,
    ExentoIVA Boolean DEFAULT FALSE,
    Contabilizar Boolean DEFAULT TRUE,
    Empresa_Destino NVarChar(3),
    Afectar_Stock Boolean DEFAULT TRUE,
    CentroCoste NVarChar(4),
    Canal NVarChar(9),
    FacturasRectificativas Boolean DEFAULT FALSE
);

CREATE TABLE TipoAsiento
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    Id AutoInc,
    NroRegistro SmallInt NOT NULL DESCRIPTION 'Nro_Registro',
    Descripcion NVarChar(25) NOT NULL,
    Documento Boolean DEFAULT FALSE,
    Registro Boolean DEFAULT FALSE
);

CREATE TABLE TiposIVA
  DESCRIPTION 'Data/DataDict File'
  BLOCKSIZE 8
(
    FechaAplicacion Date,
    CodigoPais NVarChar(3) DEFAULT EMPTY,
    Codigo SmallInt NOT NULL,
    Descripcion NVarChar(30),
    IVASoportado Decimal(16, 4),
    CtaSoportado NVarChar(9),
    IVAREpercutido Decimal(16, 4),
    RERepercutido Decimal(16, 4),
    CtaRepercutido NVarChar(9),
    Liquidable Boolean DEFAULT TRUE,
    SobreTotal Boolean DEFAULT FALSE
);

/*******************************************************************************
 * Indices
 * -------
 * Extracted at 29/08/2025 18:32:55
 ******************************************************************************/

CREATE INDEX I_Apunte_1
 ON Apunte(Subcuenta, Fecha, NroAsiento, NroApunte);

CREATE INDEX I_Apunte_2
 ON Apunte(Fecha, Subcuenta, NroAsiento, NroApunte);

CREATE INDEX I_Apunte_3
 ON Apunte(Ejercicio, NroAsiento, Subcuenta);

CREATE INDEX I_Apunte_4
 ON Apunte(TipoApunte, EjercicioFactura, Propietario, Serie, NroFactura, NroEfecto);

CREATE INDEX I_Apunte_5
 ON Apunte(TipoApunte, Fecha);

CREATE INDEX I_Asiento_1
 ON Asiento(Fecha);

CREATE INDEX I_Asiento_2
 ON Asiento(TipoAsiento, Ejercicio, Serie, NroFactura, NroEfecto);

CREATE INDEX I_Asiento_3
 ON Asiento(TipoAsiento, Ejercicio, Propietario, Serie, NroFactura, NroEfecto);

CREATE INDEX I_Asiento_4
 ON Asiento(TipoAsiento, Fecha);

CREATE INDEX I_Asiento_5
 ON Asiento(TipoAsiento, Ejercicio, NroRegistro);

CREATE INDEX I_Asiento_6
 ON Asiento(TipoAsiento, FechaDocumento);

CREATE UNIQUE INDEX I_Cliente_1
 ON Cliente(Factura_Agrupacion, Codigo);

CREATE INDEX I_Cliente_2
 ON Cliente(Subcuenta);

CREATE INDEX I_Cliente_3
 ON Cliente(CodigoPais, CodigoProvincia, CodigoPostal);

CREATE UNIQUE INDEX I_Cliente_4
 ON Cliente(Vendedor, Codigo);

CREATE INDEX I_Cliente_5
 ON Cliente(EMail);

CREATE INDEX I_Cliente_6
 ON Cliente(NIF);

CREATE INDEX I_DireccionContacto_2
 ON DireccionContacto(Tipo, Codigo, TipoDocumento);

CREATE INDEX I_EfectoCobrar_1
 ON EfectoCobrar(FechaVencimiento);

CREATE INDEX I_EfectoCobrar_2
 ON EfectoCobrar(EjercicioRemesa, NroRemesa, FechaVencimiento);

CREATE INDEX I_EfectoCobrar_3
 ON EfectoCobrar(SubcuentaCliente, FechaLibramiento);

CREATE INDEX I_EfectoCobrar_4
 ON EfectoCobrar(FechaCobro);

CREATE INDEX I_EfectoPagar_1
 ON EfectoPagar(FechaVencimiento);

CREATE INDEX I_EfectoPagar_2
 ON EfectoPagar(FechaLibramiento);

CREATE INDEX I_EfectoPagar_3
 ON EfectoPagar(EjercicioRemesa, NroRemesa, FechaVencimiento);

CREATE INDEX I_EfectoPagar_4
 ON EfectoPagar(SubcuentaProveedor, FechaLibramiento);

CREATE INDEX I_EfectoPagar_5
 ON EfectoPagar(FechaPago);

CREATE INDEX Index_2
 ON Factura(Tipo, Ejercicio, NroRegistro);

CREATE INDEX I_Inmovilizado_1
 ON Inmovilizado(CodigoProveedor);

CREATE INDEX I_Inmovilizado_2
 ON Inmovilizado(FechaCompra);

CREATE INDEX I_Inmovilizado_3
 ON Inmovilizado(CuentaAmortizacion);

CREATE INDEX I_LineaInmovilizado_1
 ON LineaInmovilizado(Codigo, Fecha);

CREATE INDEX I_MovimientoCaja_1
 ON MovimientoCaja(Serie, Fecha);

CREATE INDEX I_Proveedor_1
 ON Proveedor(Subcuenta);

CREATE INDEX I_Proveedor_2
 ON Proveedor(Factura_CodigoGrupo, Codigo);

CREATE INDEX I_Proveedor_3
 ON Proveedor(NIF);

CREATE UNIQUE INDEX Index_1
 ON RegistroFacturaElectronica(Tipo, Ejercicio, Propietario, Serie, NroFactura);

CREATE UNIQUE INDEX Index_2
 ON RegistroFacturaElectronica(Tipo, Ejercicio, NIFPropietario, Serie, NroFactura);

CREATE INDEX Index_3
 ON RegistroFacturaElectronica(Tipo, Ejercicio, Serie, NroFactura);

CREATE INDEX Index_4
 ON RegistroFacturaElectronica(Tipo, FechaRegistro);

CREATE UNIQUE INDEX Index_1
 ON RegistroPresentacion(Tipo, Ejercicio, Propietario, Serie, NroFactura, NroEfecto);

CREATE INDEX Index_2
 ON RegistroPresentacion(Tipo, Ejercicio, NIFPropietario, Serie, NroFactura, NroEfecto);

CREATE INDEX Index_3
 ON RegistroPresentacion(Tipo, Ejercicio, Serie, NroFactura, NroEfecto);

CREATE INDEX I_Remesa_1
 ON Remesa(Fecha);

CREATE INDEX I_RemesaPago_1
 ON RemesaPago(Fecha);

CREATE INDEX Index_1
 ON TiposIVA(CodigoPais, Codigo);

/*******************************************************************************
 * Primary Key Constraints
 * -----------------------
 * Extracted at 29/08/2025 18:32:55
 ******************************************************************************/

ALTER TABLE Apunte ADD CONSTRAINT PK_Apunte 
  PRIMARY KEY (Ejercicio, NroAsiento, NroApunte);

ALTER TABLE Asiento ADD CONSTRAINT PK_Asiento 
  PRIMARY KEY (Ejercicio, NroAsiento);

ALTER TABLE Banco ADD CONSTRAINT PK_Banco 
  PRIMARY KEY (Subcuenta);

ALTER TABLE CentroCoste ADD CONSTRAINT PK_CentroCoste 
  PRIMARY KEY (Codigo);

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente 
  PRIMARY KEY (Codigo);

ALTER TABLE ConceptoApte ADD CONSTRAINT PK_ConceptoApte 
  PRIMARY KEY (NroConcepto);

ALTER TABLE Cuenta ADD CONSTRAINT PK_Cuenta 
  PRIMARY KEY (Codigo);

ALTER TABLE CuentaAnalitica ADD CONSTRAINT PK_AuxiliarCliente 
  PRIMARY KEY (CentroCoste, Codigo);

ALTER TABLE DireccionContacto ADD CONSTRAINT I_DireccionContacto_1 
  PRIMARY KEY (Tipo, Codigo, NroRegistro);

ALTER TABLE Disponibilidad ADD CONSTRAINT PK_Disponibilidad 
  PRIMARY KEY (Codigo, NroRegistro);

ALTER TABLE EfectoCobrar ADD CONSTRAINT PK_EfectoCobrar 
  PRIMARY KEY (Ejercicio, Serie, NroFactura, NroEfecto);

ALTER TABLE EfectoPagar ADD CONSTRAINT PK_EfectoPagar 
  PRIMARY KEY (Ejercicio, SubcuentaProveedor, Serie, NroFactura, NroEfecto);

ALTER TABLE Existencia ADD CONSTRAINT PK_Existencia 
  PRIMARY KEY (Ejercicio, Codigo, CentroCoste);

ALTER TABLE Factura ADD CONSTRAINT PK_FacturaRectificativa 
  PRIMARY KEY (Tipo, Ejercicio, Propietario, SerieFactura, NroRegistro);

ALTER TABLE FormaCobro ADD CONSTRAINT PK_FormaCobro 
  PRIMARY KEY (Codigo);

ALTER TABLE FormaPago ADD CONSTRAINT PK_FormaPago 
  PRIMARY KEY (Codigo);

ALTER TABLE Inmovilizado ADD CONSTRAINT PK_Inmovilizado 
  PRIMARY KEY (Codigo);

ALTER TABLE LineaInmovilizado ADD CONSTRAINT PK_LineaInmovilizado 
  PRIMARY KEY (Codigo, NroRegistro);

ALTER TABLE LineaTipoAsiento ADD CONSTRAINT PK_LineaTipoAsiento 
  PRIMARY KEY (NroRegistro, NroLinea);

ALTER TABLE MovimientoCaja ADD CONSTRAINT PK_MovimientoCaja 
  PRIMARY KEY (Ejercicio, Serie, NroOperacion);

ALTER TABLE Proveedor ADD CONSTRAINT PK_Proveedor 
  PRIMARY KEY (Codigo);

ALTER TABLE RelacionesDivisa ADD CONSTRAINT PK_RelacionesDivisa 
  PRIMARY KEY (CodigoDivisa);

ALTER TABLE Remesa ADD CONSTRAINT PK_Remesa 
  PRIMARY KEY (Ejercicio, NroRemesa);

ALTER TABLE RemesaPago ADD CONSTRAINT PK_RemesaPago 
  PRIMARY KEY (Ejercicio, NroRemesa);

ALTER TABLE Saldos ADD CONSTRAINT PK_Saldos 
  PRIMARY KEY (Ejercicio, Codigo, CentroCoste);

ALTER TABLE SerieFacturacion ADD CONSTRAINT PK_SerieFacturacion 
  PRIMARY KEY (Codigo);

ALTER TABLE TipoAsiento ADD CONSTRAINT PK_TipoAsiento 
  PRIMARY KEY (NroRegistro);

ALTER TABLE TiposIVA ADD CONSTRAINT PK_TiposIVA 
  PRIMARY KEY (FechaAplicacion, CodigoPais, Codigo);

