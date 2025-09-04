{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim10Fields;

interface

uses  DB,
      nxllTypes,
      LibUtils,
      DataManager;

{$TYPEINFO ON}   // Rtti

resourceString
       RsCentrosCoste           = 'CentrosCoste';
       RsCodigoPostal           = 'CodigoPostal';
       RsTipo                   = 'Tipo';
       RsTipoSeleccion          = 'TipoSeleccion';
       RsTipoFormato            = 'TipoFormato';
       RsFecha                  = 'Fecha';
       RsDebeInicial            = 'DebeInicial';
       RsHaberInicial           = 'HaberInicial';
       RsPeriodoInicial         = 'PeriodoInicial';
       RsPeriodoFinal           = 'PeriodoFinal';
       RsTextoPeriodoInicial    = 'TextoPeriodoInicial';
       RsTextoPeriodoFinal      = 'TextoPeriodoFinal';
       RsTextoPeriodo           = 'TextoPeriodo';
       RsCodigoInicial          = 'CodigoInicial';
       RsCodigoFinal            = 'CodigoFinal';
       RsSeleccionCentroCoste   = 'SeleccionCentroCoste';
       RsCentroCoste            = 'CentroCoste';
       RsDescCentroCoste        = 'DescripcionCentroCoste';
       RsFechaInicial           = 'FechaInicial';
       RsFechaFinal             = 'FechaFinal';
       RsNoArrastrarSumas       = 'NoArrastrarSumas';
       RsMesInicial             = 'MesInicial';
       RsMesFinal               = 'MesFinal';
       RsMostrar                = 'Mostrar';
       RsPunteo                 = 'Punteo';
       // RsPeriodoTiposIVA        = 'PeriodoTiposIVA';
       RsIdentificadorAcreedor  = 'IdentificadorAcreedor';
       RsCriterioCaja           = 'CriterioCaja';
       RsSeleccionSeries        = 'SeleccionSeries';
       RsTextoSeleccionSeries   = 'TextoSeleccionSeries';
       RsVentasOnline           = 'VentasOnline';

const  NroMaximoTiposTasas        = 24;
       NroMaximoEfectos           = 99;
       NroEfectoRegistroFactura   = 255;

       // Identificadores de ventanas

       idMntEccForm           = 1000;  // Efectos a cobrar
       idMntCliForm           = 1001;  // Clientes
       idMntMdcForm           = 1002;  // Movimientos de caja
       idMntProForm           = 1003;
       idRptRdrForm           = 1004;
       idMntSdfForm           = 1005;
       idMntFcoForm           = 1006;
       idMntFcgForm           = 1007;
       idMntFviForm           = 1008;
       idMntAstForm           = 1009;
       idRptRrpForm           = 1010;  // Emisión de documentos de pago de una remesa
       idFrpManForm           = 1011;
       idMntApeForm           = 1012;
       idMntParForm           = 1013;
       idMntRdpForm           = 1014;

       // Tags de alertas (1..254)

       atProveedor             = 1;
       atCliente               = 2;

Type TRelacionEfectos = packed record
       NroEfectos : 0..NroMaximoEfectos;
       FechaLibramiento : array[ 0..NroMaximoEfectos ] of TDateTime;
       FechaVencimiento : array[ 0..NroMaximoEfectos ] of TDateTime;
       Importe : array[ 0..NroMaximoEfectos ] of Decimal;
       end;

     TRelacionImportes = Array[ 1..NroMaximoTiposTasas ] of Decimal;

     TAmpliacionProcess = ( amInitialize, amUpdateRecord );
     TAmpliacionEvent = function( const Process : TAmpliacionProcess ) : String of object;

     TApunteFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroAsiento : TIntegerField;
       NroApunte : TSmallIntField;
       Fecha : TDateField;
       Subcuenta : TWideStringField;
       CentroCoste : TWideStringField;
       CuentaAnalitica : TWideStringField;
       Contrapartida : TWideStringField;
       Concepto : TWideStringField;
       Debe : TBCDField;
       Haber : TBCDField;
       TipoApunte : TSmallIntField;
       Punteo : TBooleanField;
       EjercicioFactura : TSmallIntField;   // Estos campos, de momento, solo sirven para identificar los cobros o pagos parciales realizados
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;          // ...
       BaseImponible : TBCDField;
       Tipo : TSmallIntField;
       CuotaIVA : TBCDField;
       CuotaRE : TBCDField;
       ImporteTotal : TBCDField;

     end;

     TAsientoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroAsiento : TIntegerField;
       Fecha : TDateField;
       TipoAsiento : TSmallIntField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;
       FechaDocumento : TDateField;
       Propietario : TWideStringField;
       NroRegistro : TIntegerField;
       Nombre : TWideStringField;
       Origen : TSmallIntField;
       Creado : TDateTimeField;
       Bloqueado : TBooleanField;
       MotivoBloqueo : TWideMemoField;
       Usuario : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TFacturaFields = class( TnxeDatasetFields)
       ['{9BD4D986-4D0E-436B-AF03-C5842D4E526B}']
     public
       Tipo : TSmallIntField;
       Ejercicio : TSmallIntField;
       Propietario: TWideStringField;
       SerieFactura : TWideStringField;
       NroRegistro : TIntegerField;  // NroAsiento o NroFactura
       EjercicioFraRectificada : TSmallIntField;
       Creado : TDateTimeField;
       SerieFraRectificada : TWideStringField;
       NroFacturaRectificada : TIntegerField;
       Razon : TSmallIntField;
       Metodo : TSmallIntField;
       TipoFactura : TSmallIntField;
       RegimenOTrascendencia : TSmallIntField;
       TipoFacturaRectificativa : TSmallIntField;
       CausaExencion : TSmallIntField;
       TipoOperacionIntracomunitaria : TSmallIntField;
       SituacionInmueble : TSmallIntField;
       ReferenciaCatastral : TWideStringField;
       IdentificacionDescripcionBienes : TWideStringField;
       FechaInicioUtilizacion : TDateField;
       ProrrataAnualDefinitiva : TBCDField;
       Descripcion : TWideMemoField;
     end;

     TBancoFields = class( TnxeDatasetFields)
     public
       Subcuenta : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Subcuenta_Riesgo : TWideStringField;
       Subcuenta_Intereses : TWideStringField;
       Riesgo : TBCDField;
       Formato : TSmallIntField;
       DiasCancelacion : TSmallIntField;
       DiasCancelacion19 : TSmallIntField;
       DiasCancelacion32 : TSmallIntField;
       DiasCancelacion58 : TSmallIntField;
       Adeudos_Presentador : TWideStringField;
       Adeudos_NIF : TWideStringField;
       Adeudos_EntidadRec : TWideStringField;
       Adeudos_OficinaRec : TWideStringField;
       Adeudos_EntidadDep : TWideStringField;
       Adeudos_OficinaDep : TWideStringField;
       Adeudos_DCDeposito : TWideStringField;
       Adeudos_CuentaDep : TWideStringField;
       Adeudos_CodigoINE : TWideStringField;
       Adeudos_SufijoCI : TWideStringField;
       Adeudos_EntidadAde : TWideStringField;
       Adeudos_OficinaAde : TWideStringField;
       Adeudos_DCAdeudos : TWideStringField;
       Adeudos_CuentaAde : TWideStringField;
       Adeudos_EntidadImp : TWideStringField;
       Adeudos_OficinaImp : TWideStringField;
       Adeudos_DCImpagados : TWideStringField;
       Adeudos_CuentaImp : TWideStringField;
       Adeudos_CIC : TWideStringField;
       Abonos_CI : TWideStringField;
       Abonos_DCCI : TWideStringField;
       Abonos_CIC : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TCartaRemesaFields = class( TnxeDatasetFields)
     public
       NroRemesa : TIntegerField;
       Fecha : TDateField;
       SubcuentaEntidad : TWideStringField;
       CodigoEntidad : TWideStringField;
       Entidad : TWideStringField;
       Presentador : TWideStringField;
       NIFPresentador : TWideStringField;
       EntidadReceptora : TWideStringField;
       OficinaReceptora : TWideStringField;
       EntidadDeposito : TWideStringField;
       OficinaDeposito : TWideStringField;
       DCDeposito : TWideStringField;
       CuentaDeposito : TWideStringField;
       FechaVtoInicial : TDateField;
       FechaVtoFinal : TDateField;
       ImporteRemesa : TBCDField;
       CodigoIdentificacion : TWideStringField;
       NroOrden : TSmallIntField;
       NroEfectos : TSmallIntField;
       UltimoVencimiento : TDateField;
     end;

     TCentroCosteFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
     end;

     TClienteCampoLibreArray = array[ 1..4 ] of TWideStringField;

     TClienteFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Telefono : TWideStringField;
       Fax : TWideStringField;
       NIF : TWideStringField;
       TipoIdentificacion : TSmallIntField;
       EMail : TWideStringField;
       DocumentosExternos : TWideStringField;
       Vendedor : TWideStringField;
       Subcuenta : TWideStringField;
       CodigoDivisa : TWideStringField;
       CampoLibre : TClienteCampoLibreArray;
       Bloqueado : TBooleanField;
       Obsoleto : TBooleanField;
       FechaAlta : TDateField;
       PalabraPaso : TWideStringField;
       Latitud : TFloatField;
       Longitud : TFloatField;
       TiendaVirtual : TBooleanField;
       Envios_Nombre : TWideStringField;
       Envios_Domicilio : TWideStringField;
       Envios_Localidad : TWideStringField;
       Envios_CodigoProv : TWideStringField;
       Envios_CodigoPostal : TWideStringField;
       Envios_FormaEnvio : TWideStringField;
       Envios_Transportista : TWideStringField;
       Envios_CodigoFormaEnvio : TWideStringField;
       Envios_Bloqueado : TBooleanField;
       Envios_MotivoBloqueo : TWideMemoField;
       Factura_DtoPP : TBCDField;
       Factura_DtoES : TBCDField;
       Factura_RecFinanc : TBCDField;
       Factura_ModeloIVA : TSmallIntField;
       Factura_TipoFijoIVA : TSmallIntField;
       Factura_TipoRet : TSmallIntField;
       Factura_Credito : TBCDField;
       Factura_Agrupacion : TWideStringField;
       Factura_Reservado : TWideStringField;
       Factura_Tarifa : TWideStringField;
       Factura_Comision : TBCDField;
       Factura_NroCopias : TSmallIntField;
       Factura_NroCopiasAlbaran : TSmallIntField;
       Factura_Moneda : TSmallIntField;
       Factura_EnviarPorCorreo : TBooleanField;
       Factura_SinDtosConsumo : TBooleanField;
       Factura_NoAplicarOfertas : TBooleanField;
       Factura_CodigoEAN : TWideStringField;
       Cobro_Nombre : TWideStringField;
       Cobro_Domicilio : TWideStringField;
       Cobro_Localidad : TWideStringField;
       Cobro_CodigoProv : TWideStringField;
       Cobro_CodigoPostal : TWideStringField;
       Cobro_FormaCobro : TWideStringField;
       Cobro_DiaCobro1 : TSmallIntField;
       Cobro_DiaCobro2 : TSmallIntField;
       Cobro_MesNoCobro : TSmallIntField;
       Cobro_CodigoEntidad : TWideStringField;
       Cobro_Entidad : TWideStringField;
       Cobro_CodigoSucursal : TWideStringField;
       Cobro_Sucursal : TWideStringField;
       Cobro_DC : TWideStringField;
       Cobro_Cuenta : TWideStringField;
       Cobro_CtaEntidad : TWideStringField;
       Cobro_CodigoINEPlaza : TWideStringField;
       Cobro_RiesgoLimite : TBCDField;
       Cobro_ReferenciaMandato : TWideStringField;
       Cobro_FechaMandato : TDateField;
       Cobro_CicloMandato : TSmallIntField;
       Cobro_BIC : TWideStringField;
       Cobro_IBAN : TWideStringField;
       Anotacion : TWideMemoField;
       Aviso : TWideMemoField;
       MostrarAviso : TBooleanField;
     end;

     TConceptoApteFields = class( TnxeDatasetFields)
     public
       NroConcepto : TSmallIntField;
       Descripcion : TWideStringField;
     end;

     TCuentaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nivel : TSmallIntField;
       Descripcion : TWideStringField;
     end;

     TCuentaAnaliticaFields = class( TnxeDatasetFields)
     public
       CentroCoste : TWideStringField;
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
     end;

     TDireccionContactoFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Codigo : TWideStringField;
       NroRegistro : TSmallIntField;
       Nombre : TWideStringField;
       Cargo : TWideStringField;
       Fijo : TWideStringField;
       Movil : TWideStringField;
       Fax : TWideStringField;
       Correo : TWideStringField;
       TipoDocumento : TSmallIntField;
     end;

     TDisponibilidadFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       NroRegistro : TSmallIntField;
       Subcuenta : TWideStringField;
       Limite : TBCDField;
     end;

     TImporteTrimestreArray = array[ 1..4 ] of TBCDField;

     TDocumentoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;
       Importe : TBCDField;
       ImporteTrimestre : TImporteTrimestreArray;
       ImporteEfectivo : TBCDField;
       FechaVencimiento : TDateField;
       FechaFactura : TDateField;
       FechaCargo : TDateField;
       CodigoEntidad : TWideStringField;
       Entidad : TWideStringField;
       CodigoSucursal : TWideStringField;
       Sucursal : TWideStringField;
       DC : TWideStringField;
       CuentaCorriente : TWideStringField;
       BIC : TWideStringField;
       IBAN : TWideStringField;
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPostal : TWideStringField;
       Provincia : TWideStringField;
       CodigoAgrupacion : TWideStringField;
       NIF : TWideStringField;
       CodigoSubcuenta : TWideStringField;
       ImporteCifra : TWideStringField;
       CodigoBanco : TWideStringField;
       EjercicioRemesa : TSmallIntField;
       NroRemesa : TIntegerField;
       Concepto : TWideStringField;
       FormaDePago : TWideStringField;
     end;

     TEfectoCobrarFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;
       SubcuentaCliente : TWideStringField;
       SubcuentaEntidad : TWideStringField;
       FechaVencimiento : TDateField;
       FechaCobro : TDateField;
       Concepto : TWideStringField;
       EjercicioRemesa : TSmallIntField;
       NroRemesa : TIntegerField;
       Importe : TBCDField;
       ImporteCobrado : TBCDField;
       ConceptoCobro : TWideStringField;
       CodigoCliente : TWideStringField;
       Vendedor : TWideStringField;
       GrupoFacturacion : TWideStringField;
       Revisado : TBooleanField;
       Impagado : TBooleanField;
       Cancelado : TBooleanField;
       VolverAEmitir : TBooleanField;
       NroEfectoReemitido : TSmallIntField;
       FechaLibramiento : TDateField;
       FechaEmision : TDateField;
       FormaDePago : TWideStringField;
       DiferenciaCambio : TBCDField;
       GenerarEfectoDiferencia : TBooleanField;
       SubcuentaDiferencia : TWideStringField;
       NroEfectoDiferencia : TSmallIntField;
       GastosGestion : TBCDField;
       GastosDevolucion : TBCDField;
       SubcuentaGastos : TWideStringField;
       NroAsientoCartera : TIntegerField;
       NroAsientoCobro : TIntegerField;
       FechaDescuento : TDateField;
       NroAsientoDescuento : TIntegerField;
       FechaCancelacion : TDateField;
       NroAstoCancelacion : TIntegerField;
       FechaImpagado : TDateField;
       NroAsientoImpagado : TIntegerField;
       Anotacion : TWideMemoField;

       [TAttrCalculatedField] FechaCobroRemesa : TDateField;      // Campos calculados
       [TAttrCalculatedField] FechaDescuentoRemesa : TDateField;

     end;

     TEfectoPagarFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       SubcuentaProveedor : TWideStringField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;
       SubcuentaEntidad : TWideStringField;
       FechaVencimiento : TDateField;
       FechaPago : TDateField;
       Concepto : TWideStringField;
       Importe : TBCDField;
       ImportePagado : TBCDField;
       ConceptoPago : TWideStringField;
       FechaLibramiento : TDateField;
       FechaEmision : TDateField;
       FormaDePago : TWideStringField;
       DiferenciaCambio : TBCDField;
       GenerarEfectoDiferencia : TBooleanField;
       SubcuentaDiferencia : TWideStringField;
       GastosGestion : TBCDField;
       SubcuentaGastos : TWideStringField;
       NroAsiento : TIntegerField;
       EjercicioRemesa : TSmallIntField;
       NroRemesa : TIntegerField;
       Revisado : TBooleanField;
       CodigoProveedor : TWideStringField;
       Anotacion : TWideMemoField;

       [TAttrCalculatedField] FechaPagoRemesa : TDateField;      // Campos calculados
     end;

     TValoresSaldo = 0..12;
     TSaldoArray = Array[ TValoresSaldo ] of TBCDField;

     TExistenciaFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       CentroCoste : TWideStringField;
       [TAttrPeriodicalField] Saldo : TSaldoArray;
     end;

     TFormaCobroFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       Plazos : TSmallIntField;
       PrimerVencimiento : TSmallIntField;
       Intervalo : TSmallIntField;
       DiaCobro1 : TSmallIntField;
       DiaCobro2 : TSmallIntField;
       DescuentoPP : TBooleanField;
       TipoDescuentoPP : TBCDField;
       RecargoFinanciero : TBooleanField;
       TipoRecargoFinanc : TBCDField;
       Emitir : TBooleanField;
       CrearRegistro : TBooleanField;
       TipoDeDocumento : TSmallIntField;
       Aceptado : TBooleanField;
       Gastos : TSmallIntField;
       NoContabilizar : TBooleanField;
       Meses30Dias : TBooleanField;
       CanalPreferente : TWideStringField;
       CodigoFacturaE : TSmallIntField;
     end;

     TFormaPagoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       Plazos : TSmallIntField;
       PrimerVencimiento : TSmallIntField;
       Intervalo : TSmallIntField;
       DescuentoPP : TBooleanField;
       TipoDescuentoPP : TBCDField;
       RecargoFinanciero : TBooleanField;
       TipoRecargoFinanc : TBCDField;
       Emitir : TBooleanField;
       CrearRegistro : TBooleanField;
       TipoDeDocumento : TSmallIntField;
       Gastos : TSmallIntField;
       NoContabilizar : TBooleanField;
       CanalPreferente : TWideStringField;
     end;

     TInmovilizadoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       CentroCoste : TWideStringField;
       CodigoProveedor : TWideStringField;
       SerieNroFactura : TWideStringField;
       CuentaAmortizacion : TWideStringField;
       Tipo : TBCDField;
       Ubicacion : TWideStringField;
       FechaCompra : TDateField;
       Importe : TBCDField;
       CampoLibre1 : TWideStringField;
       CampoLibre2 : TWideStringField;
       CampoLibre3 : TWideStringField;
       CampoLibre4 : TWideStringField;
     end;

     TLineaCartaRemesaFields = class( TnxeDatasetFields)
     public
       NroRemesa : TIntegerField;
       FechaVencimiento : TDateField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       NroEfecto : TSmallIntField;
       CodigoCliente : TWideStringField;
       NombreCliente : TWideStringField;
       Plaza : TWideStringField;
       Importe : TBCDField;
     end;

     TLineaInmovilizadoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       NroRegistro : TSmallIntField;
       Fecha : TDateField;
       CodigoProveedor : TWideStringField;
       SerieNroFactura : TWideStringField;
       Descripcion : TWideStringField;
       Importe : TBCDField;
     end;

     TLineaTipoAsientoFields = class( TnxeDatasetFields)
     public
       NroRegistro : TSmallIntField;
       NroLinea : TSmallIntField;
       Subcuenta : TWideStringField;
       CtroCoste : TWideStringField;
       Contrapartida : TWideStringField;
       Concepto : TWideStringField;
       DH : TWideStringField;
       Importe : TBCDField;
     end;

     TMovimientoCajaFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Serie : TWideStringField;
       NroOperacion : TIntegerField;
       Fecha : TDateField;
       TipoOperacion : TSmallIntField;
       Propietario : TWideStringField;
       FormaCobro : TWideStringField;
       Descripcion : TWideStringField;
       Importe : TBCDField;
       Contabilizado : TBooleanField;
       NroAsiento : TIntegerField;
     end;

     TOrdenDomiciliacionFields = class( TnxeDatasetFields)
     public

       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       NombrePais : TWideStringField;
       CP : TWideStringField;
       Provincia : TWideStringField;
       ReferenciaMandato : TWideStringField;
       SwiftBIC : TWideStringField;
       IBAN : TWideStringField;
     end;

     TProveedorCampoLibreArray = array[ 1..4 ] of TWideStringField;

     TProveedorFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Telefono : TWideStringField;
       Fax : TWideStringField;
       EMail : TWideStringField;
       DocumentosExternos : TWideStringField;
       NIF : TWideStringField;
       TipoIdentificacion : TSmallIntField;
       Subcuenta : TWideStringField;
       CodigoDivisa : TWideStringField;
       Origen : TSmallIntField;
       CampoLibre : TProveedorCampoLibreArray;
       Bloqueado : TBooleanField;
       Obsoleto : TBooleanField;
       Envios_Nombre : TWideStringField;
       Envios_Domicilio : TWideStringField;
       Envios_Localidad : TWideStringField;
       Envios_CodigoProv : TWideStringField;
       Envios_CodigoPostal : TWideStringField;
       Envios_FormaEnvio : TWideStringField;
       Factura_DtoPP : TBCDField;
       Factura_DtoES : TBCDField;
       Factura_RecFinanc : TBCDField;
       Factura_ModeloIVA : TSmallIntField;
       Factura_TipoFijoIVA : TSmallIntField;
       Factura_TipoRet : TSmallIntField;
       Factura_CtaCompras : TWideStringField;
       Factura_CodigoGrupo : TWideStringField;
       Factura_RegimenEspecialCC : TBooleanField;
       Pago_Nombre : TWideStringField;
       Pago_Domicilio : TWideStringField;
       Pago_Localidad : TWideStringField;
       Pago_CodigoProv : TWideStringField;
       Pago_CodigoPostal : TWideStringField;
       Pago_FormaPago : TWideStringField;
       Pago_DiaPago1 : TSmallIntField;
       Pago_DiaPago2 : TSmallIntField;
       Pago_MesNoPago : TSmallIntField;
       Pago_CodigoEntidad : TWideStringField;
       Pago_Entidad : TWideStringField;
       Pago_CodigoSucursal : TWideStringField;
       Pago_Sucursal : TWideStringField;
       Pago_DC : TWideStringField;
       Pago_CuentaCorriente : TWideStringField;
       Pago_Subcuenta : TWideStringField;
       Pago_BIC : TWideStringField;
       Pago_IBAN : TWideStringField;
       Pago_Bloqueado : TBooleanField;
       Pago_MotivoBloqueo : TWideMemoField;
       Anotacion : TWideMemoField;
       Aviso : TWideMemoField;
       MostrarAviso : TBooleanField;
     end;

     TRelacionesDivisaFields = class( TnxeDatasetFields)
     public
       CodigoDivisa : TWideStringField;
       DifPositivasCambio : TWideStringField;
       DifNegativasCambio : TWideStringField;
     end;

     TRemesaFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroRemesa : TIntegerField;
       Fecha : TDateField;
       SubcuentaEntidad : TWideStringField;
       FechaVtoInicial : TDateField;
       FechaVtoFinal : TDateField;
       ImporteGastos : TBCDField;
       Estado : TSmallIntField;
       TipoOrden : TSmallIntField;
       CodigoOrden : TSmallIntField;
       FechaCobro : TDateField;
       NroAsientoCobro : TIntegerField;
       FechaAceptacion : TDateField;
       NroAsientoAceptacion : TIntegerField;
       FechaDescuento : TDateField;
       NroAstoDescuento1 : TIntegerField;
       NroAstoDescuento2 : TIntegerField;
       FechaCancelacion : TDateField;
       NroAstoCancelacion : TIntegerField;
     end;

     TRemesaPagoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroRemesa : TIntegerField;
       Fecha : TDateField;
       SubcuentaEntidad : TWideStringField;
       SubcuentaProveedor : TWideStringField;
       FechaVtoInicial : TDateField;
       FechaVtoFinal : TDateField;
       ImporteGastos : TBCDField;
       Estado : TSmallIntField;
       TipoOrden : TSmallIntField;
       CodigoOrden : TSmallIntField;
       FechaPago : TDateField;
       NroAsientoPago : TIntegerField;
     end;

     TMesArray = Array[ 0..14, 1..2 ] of TBCDField;

     TSaldosFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       CentroCoste : TWideStringField;
       Mes : TMesArray;
       procedure SetupFields; override;
     end;

     TTipoAsientoFields = class( TnxeDatasetFields)
     public
       NroRegistro : TSmallIntField;
       Descripcion : TWideStringField;
       Documento : TBooleanField;
       Registro : TBooleanField;
     end;

     TTiposIVAFields = class( TnxeDatasetFields)
     public
       FechaAplicacion : TDateField;
       CodigoPais : TWideStringField;
       Codigo : TSmallIntField;
       Descripcion : TWideStringField;
       IVASoportado : TBCDField;
       [TAttrFieldName('IVASoportado')] Retencion : TBCDField;  // Es el mismo campo con diferente nombre
       CtaSoportado : TWideStringField;
       [TAttrFieldName('CtaSoportado')]  CtaRetACuenta : TWideStringField;
       IVARepercutido,
       RERepercutido : TBCDField;
       CtaRepercutido : TWideStringField;
       [TAttrFieldName('CtaRepercutido')] CtaRetPracticada : TWideStringField;
       Liquidable : TBooleanField;
       [TAttrFieldName('Liquidable') ] Desglosar : TBooleanField;
       SobreTotal : TBooleanField;
     end;

     TSerieFacturacionFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       FormatoPedido : TSmallIntField;
       FormatoAlbaran : TSmallIntField;
       FormatoFactura : TSmallIntField;
       FormatoRecibo : TSmallIntField;
       ExentoIVA : TBooleanField;
       Contabilizar : TBooleanField;
       Empresa_Destino : TWideStringField;
       Afectar_Stock : TBooleanField;
       CentroCoste : TWideStringField;
       Canal : TWideStringField;
       FacturasRectificativas : TBooleanField;
     end;

     TTipoRegistroPresentacion = ( rpFacturaRecibida, rpFacturaEmitida, rpFacturaEmitidaVerifactu );

     TEstadoPresentacionSII = ( erpPendiente, erpPresentado, erpAnulado, erpAceptadoConErrores, erpModificado );

     TEstadoPresentacionVerifactu = ( epvPendiente, epvPresentado, epvAnulado );
     TEstadoRegistroVerifactu = ( ervCorrecto, ervAceptadoConErrores, ervIncorrecto );

     TRegistroPresentacionFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Ejercicio : TSmallintField;
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroFactura: TIntegerField;
       NroEfecto : TSmallIntField;
       NIFPropietario : TWideStringField;
       Importe: TBCDField;
       FechaExpedicionFactura : TDateField;
       FechaPresentacion : TDateField;
       HoraPresentacion : TTimeField;
       EstadoPresentacion : TSmallIntField;
       EstadoRegistro : TSmallIntField;
       CodigoErrorRegistro : TLargeIntField;
       DescripcionErrorRegistro : TWideStringField;
       Contraste : TSmallIntField;
     end;

     TTipoRegistroFacturaElectronica = ( rfeFacturaRecibida, rfeFacturaEmitida );

     TRegistroFacturaElectronicaFields = class( TnxeDatasetFields)
     public
       Id : TUnsignedAutoIncField;
       Tipo : TSmallIntField;
       Ejercicio : TSmallintField;
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroFactura: TIntegerField;
       NIFPropietario : TWideStringField;
       Fecha : TDateField;
       Importe: TBCDField;
       CodigoUsuario : TWideStringField;
       FechaRegistro : TDateTimeField;
       Firmada : Boolean;
     end;

     // Tablas de reports

     TBalanceFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Nivel : TSmallIntField;
       Codigo : TWideStringField;
       Cuenta : TWideStringField;
       Descripcion : TWideStringField;
       Debe,
       Haber : TBCDField;
       [TAttrFieldName('Debe')] EjercicioActual: TBCDField;
       [TAttrFieldName('Haber')] EjercicioAnterior: TBCDField;
     end;

     TDiarioFacturacionFields = class( TnxeDatasetFields)
     public
       Libro : TSmallIntField;
       Ejercicio : TSmallIntField;
       NroAsiento : TIntegerField;
       NroApunte : TSmallIntField;
       NroRegistro : TIntegerField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       Fecha,
       FechaDocumento : TDateField;
       Tipo : TSmallIntField;
       CodigoPais : TWideStringField;
       NombrePais : TWideStringField;
       Propietario : TWideStringField;
       Nombre : TWideStringField;
       NIF : TWideStringField;
       Subcuenta : TWideStringField;
       BaseImponibleIVA,
       TipoIVA,
       CuotaIVA,
       BaseImponibleRE,
       TipoRE,
       CuotaRE,
       Importe : TBCDField;

       BaseImponibleCaja,
       CuotaIVACaja,
       ImporteCaja : TBCDField;
       FechaCobro : TDateField;
       ConceptoCobro : TWideStringField;
       CodigoMedioCobro : TWideStringField;
       CCC : TWideStringField;

       // Información sobre los totales de la factura

       NroBasesImponibles : TSmallIntField;
       TotalCuotas,
       TotalImporte : TBCDField;

     end;

     TOperacionesIntracomunitariasFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       TipoRegistro : TSmallIntField;   // Tipos de registro : 0 = Adquisiciones y rectificaciones en el periodo y 1 = Rectificaciones de facturas de periodos anteriorres
       ClaveOperacion : TWideStringField;
       NIF  : TWideStringField;
       Subcuenta : TWideStringField;
       NombreOperador : TWideStringField;
       BaseImponible : TBCDField;
       EjercicioRectificacion : TSmallIntField;
       FechaRectificacion : TDateField;
       SerieFacturaRectificada : TWideStringField;
       NroFacturaRectificada : TIntegerField;
       BaseImponibleRectificada : TBCDField;
       BaseImponibleAnterior : TBCDField;
       end;


     TCabeceraExtractoFields = class( TnxeDatasetFields)
     public
       Subcuenta : TWideStringField;
       DescripcionSubcuenta : TWideStringField;
       CentroCoste : TWideStringField;
       DescripcionCentroCoste : TWideStringField;
       Debe,
       Haber,
       Saldo : TBCDField;
     end;

     TLineaExtractoFields = class( TnxeDatasetFields)
     public
       Subcuenta : TWideStringField;
       CentroCoste : TWideStringField;
       Contrapartida : TWideStringField;
       DescripcionContrapartida : TWideStringField;
       Ejercicio : TSmallIntField;
       NroAsiento : TIntegerField;
       NroApunte : TSmallIntField;
       Fecha : TDateField;
       Concepto : TWideStringField;
       Debe : TBCDField;
       Haber : TBCDField;
       Saldo : TBCDField;
     end;

     TRelacionSaldosFields = class( TnxeDatasetFields)
     public
       Cuenta : TWideStringField;
       Periodo : TSmallIntField;
       NombrePeriodo : TWideStringField;
       DescripcionCuenta : TWideStringField;
       SaldoInicial,
       DebePeriodo,
       HaberPeriodo : TBCDField;
       Orden : TSmallIntField;
       Debe,
       Haber,
       Saldo : TBCDField;
     end;

     TRelacionRetencionesFields = class( TnxeDatasetFields)
     public
       TipoRegistro : TSmallIntField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       Fecha : TDateField;
       Propietario : TWideStringField;
       Nombre : TWideStringField;
       NIF : TWideStringField;
       BaseImponible : TBCDField;
       Retenedores : TIntegerField;
       TipoRetencion : TSmallIntField;
       Retencion : TBCDField;
       ImporteRetencion : TBCDField;
       ImporteFactura : TBCDField;
     end;

     TDeclaracionOperacionesFields = class( TnxeDatasetFields)
     public
       TipoRegistro : TSmallIntField;
       CodigoAgrupacion : TWideStringField;
       Propietario : TWideStringField;
       Nombre : TWideStringField;
       CriterioCaja : TBooleanField;
       CodigoOrigen : TWideStringField;
       OrigenOperacion : TSmallIntField;
       NIF : TWideStringField;
       ImporteTrimestre : TImporteTrimestreArray;
       ImporteEfectivoCriterioCaja : TBCDField;
       ImporteTotalAnual : TBCDField;
       ImporteTotalCriterioCaja : TBCDField;
     end;

     TRelacionEfectosFields = class( TnxeDatasetFields)
      Ejercicio : TSmallIntField;
      Serie : TWideStringField;
      NroFactura : TIntegerField;
      NroEfecto : TSmallIntField;
      FechaVencimiento : TDateField;
      FechaLibramiento : TDateField;
      FechaCobro : TDateField;
      Propietario : TWideStringField;
      Nombre : TWideStringField;
      Entidad : TWideStringField;
      Descripcion : TWideStringField;
      Concepto : TWideStringField;
      CodigoGrupo : TWideStringField;
      DescripcionGrupo : TWideStringField;
      Importe : TBCDField;
      ImporteCobrado : TBCDField;
      GastosGestion : TBCDField;
      GastosDevolucion : TBCDField;
      CodigoFormaCobro : TWideStringField;
      DescripcionFormaCobro : TWideStringField;
      end;

     TRelacionFacturasFields = class( TnxeDatasetFields)
      Ejercicio : TSmallIntField;
      Serie : TWideStringField;
      NroFactura : TIntegerField;
      NroEfecto : TSmallIntField;
      Fecha : TDateField;
      Propietario,
      NombrePropietario,
      Entidad,
      NombreEntidad,
      Concepto,
      FormaCobro,
      DescripcionFormaCobro : TWideStringField;
      FechaVencimiento : TDateField;
      Importe,
      ImportePendiente : TBCDField;
      end;

   TLibroIVAFields = class( TnxeDatasetFields)
     public
       Modelo : TSmallIntField;
       Tipo : TSmallIntField;
       Nombre : TWideStringField;
       BaseImponibleIVA,
       TipoIVA,
       CuotaIVA : TBCDField;
     end;

     // Tablas Virtuales

     TTablaAmortizacionFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       Importe : TBCDField;
       Amortizacion : TBCDField;
       Valor : TBCDField;
       Adiciones : TBCDField;
       Bajas : TBCDField;
       AplicadoEjercicio : TBCDField;
       Pendiente : TBCDField;
       Tipo : TBCDField;
       Periodo : TBCDField;
       Descripcion : TWideStringField;
       Ubicacion : TWideStringField;
       FechaCompra : TDateField;
       CodigoProveedor : TWideStringField;
       DescripcionProveedor : TWideStringField;
       SerieNroFactura : TWideStringField;
     end;

implementation

procedure TSaldosFields.SetupFields;
begin
     Ejercicio := SmallIntField( 'Ejercicio' );
     Codigo := WideStringField( 'Codigo' );
     CentroCoste := WideStringField( 'CentroCoste' );
     Mes[ 0, 1 ] := BCDField( 'Apertura_Debe' );
     Mes[ 0, 2 ] := BCDField( 'Apertura_Haber' );
     Mes[ 1, 1 ] := BCDField( 'Enero_Debe' );
     Mes[ 1, 2 ] := BCDField( 'Enero_Haber' );
     Mes[ 2, 1 ] := BCDField( 'Febrero_Debe' );
     Mes[ 2, 2 ] := BCDField( 'Febrero_Haber' );
     Mes[ 3, 1 ]:= BCDField( 'Marzo_Debe' );
     Mes[ 3, 2 ] := BCDField( 'Marzo_Haber' );
     Mes[ 4, 1 ] := BCDField( 'Abril_Debe' );
     Mes[ 4, 2 ] := BCDField( 'Abril_Haber' );
     Mes[ 5, 1 ] := BCDField( 'Mayo_Debe' );
     Mes[ 5, 2 ] := BCDField( 'Mayo_Haber' );
     Mes[ 6, 1 ] := BCDField( 'Junio_Debe' );
     Mes[ 6, 2 ] := BCDField( 'Junio_Haber' );
     Mes[ 7, 1 ] := BCDField( 'Julio_Debe' );
     Mes[ 7, 2 ] := BCDField( 'Julio_Haber' );
     Mes[ 8, 1 ] := BCDField( 'Agosto_Debe' );
     Mes[ 8, 2 ] := BCDField( 'Agosto_Haber' );
     Mes[ 9, 1 ] := BCDField( 'Septiembre_Debe' );
     Mes[ 9, 2 ] := BCDField( 'Septiembre_Haber' );
     Mes[ 10, 1 ] := BCDField( 'Octubre_Debe' );
     Mes[ 10, 2 ] := BCDField( 'Octubre_Haber' );
     Mes[ 11, 1 ] := BCDField( 'Noviembre_Debe' );
     Mes[ 11, 2 ] := BCDField( 'Noviembre_Haber' );
     Mes[ 12, 1 ] := BCDField( 'Diciembre_Debe' );
     Mes[ 12, 2 ] := BCDField( 'Diciembre_Haber' );
     Mes[ 13, 1 ] := BCDField( 'Regularizacion_Debe' );
     Mes[ 13, 2 ] := BCDField( 'Regularizacion_Haber' );
     Mes[ 14, 1 ] := BCDField( 'Cierre_Debe' );
     Mes[ 14, 2 ] := BCDField( 'Cierre_Haber' );
end;

end.


