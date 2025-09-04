{$ALIGN OFF} {$OPTIMIZATION OFF}

unit Gim30Fields;

interface

uses  DB,
      LibUtils,
      Datamanager,

      Gim00Fields,
      Gim10Fields;

{$TYPEINFO ON}   // Rtti

resourceString
       RsDecCantidadCompra    = 'DecCantidadCompra';
       RsDecPrecioCompra      = 'DecPrecioCompra';
       RsDecDescuentoCompra   = 'DecDescuentoCompra';
       RsDecCantidadVenta     = 'DecCantidadVenta';
       RsDecPrecioVenta       = 'DecPrecioVenta';
       RsDecDescuentoVenta    = 'DecDescuentoVenta';
       RsDecCajas             = 'DecCajas';
       RsDecComponentes       = 'DecComponentes';
       RsComisionPorCliente   = 'ComisionPorCliente';
       RsNroClase             = 'NroClase';
       RsLotesFabricacion     = 'LotesFabricacion';
       RsUbicaciones          = 'Ubicaciones';
       RsImporteTotal         = 'ImporteTotal';
       RsImporteTotalAnterior = 'ImporteTotalAnterior';
       RsRecargos             = 'Recargos';
       RsNombreRecargos       = 'NombreRecargos';
       RsNombreAlmacen        = 'NombreAlmacen';
       RsNombreRegAuxiliar    = 'NombreRegAuxiliar';
       RsDireccionAuxiliar    = 'DireccionAuxiliar';
       RsPartidasPresupuestarias = 'PartidasPresupuestarias';
       RsRelacionDocumentos   = 'RelacionDocumentos';

       // Seccion del programa  ...

const  scCompras              = 0;
       scVentas               = 1;
       scAmbas                = 2;

       // Identificadores de ventanas

       idMntLmaForm            = 3000;  // Listas de materiales
       idMntCliFrame           = 3001;
       idMntProFrame           = 3002;
       idMntFdvForm            = 3003;
       idFacturaVentasModule   = 3004;
       idLiquidacionComisiones = 3005;
       idFrpFdvForm            = 3006;  // Impresión de facturas de venta
       idBrwRdcForm            = 3007;  // Relación de documentos de clientes
       idMntMveForm            = 3008;  // Mantenimiento de documentos de venta
       idRptCpeForm            = 3009;  // Listado de carga para envíos
       idMntClsForm            = 3010;
       idStockModule           = 3011;
       idMntMovForm            = 3012;
       idRdrModule             = 3013;
       idMntMcoForm            = 3014;
       idMntTckForm            = 3015;
       idMntArtForm            = 3016;
       idRptCpsForm            = 3017;
       idGridCpsForm           = 3018;
       idMntCatForm            = 3019;
       idReconstruccionResultadosModule = 3020;
       idEdcArtForm            = 3021;
       idMovimientoModule      = 3022;
       idGridVpaForm           = 3023;
       idRptCliForm            = 3024;
       idRptTcmForm            = 3025;
       idMntCdtForm            = 3026;
       idMntTvaForm            = 3027;
       idEtqMovForm            = 3028;
       idBrwRlvForm            = 3029;
       idMntTlaForm            = 3030;
       idMntTlfForm            = 3031;
       idMntTctForm            = 3032;
       idMntTvfForm            = 3033;
       idArtModule             = 3034;

       DecimalesPrecioBase     = 6;   // El número de decimales (6) que tienen los precios base que se utilizan para calcular los precios con IVA incluído

       // Tags de alertas (1..254)

       atVendedor              = 3;
       atArticulo              = 4;

       NroMaximoTiposTasasImpreso = 12;

Type   TTasaRecord = record
         TieneBases : Boolean;  // El importe de la base puede ser cero, pero ser el resultado de acumular y sustraer importes
         BaseImponible,
         BaseNoSujetaDto,       // ImporteEcoTasas. A esta parte (incluida en la BaseImponible anterior) no se le pueden aplicar descuentos
         TipoIVA,
         TipoRE,
         CuotaIVA,
         CuotaRE,
         Importe : Decimal;
        end;

       TTasasArray = Array[ 0..NroMaximoTiposTasas ] of TTasaRecord;  // El 0 es para el tipo exento

       TSeccionComercial = scCompras..scAmbas;
       TValoresMensuales = 1..12;
       TPrecioParametrosTarifa = 1..6;

       TListaValoresMensuales = array[ TValoresMensuales ] of Decimal;
       TListaCamposMensuales = array[ TValoresMensuales ] of TBCDField;
       TListaPrecioParametrosTarifa = array[ TPrecioParametrosTarifa ] of TFloatField;

       TParametrosTPVRec = packed record
       case Byte of
         0 : ( Parametros                 : TParametrosRec );
         1 : ( InsAutAlbaranes,
               PuertoCOMVisor,
               ModeloVisor                : SmallInt;
               InicializarPuerto          : Boolean;
               ImpresoraVisor             : String[ 60 ];
               PuertoCOMCajon,
               ModeloCajon,
               DocumentoArqueo            : SmallInt;
               TextoVisor1,
               TextoVisor2                : String[ 20 ];
               UsarVisor                  : Boolean;
               SaldoInicialCaja           : Decimal;
               EdicionPedidos             : Boolean );
               end;

     TAlmacenFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       RoturaStock : TBooleanField;
       FechaRotura : TDateField;
     end;

     TArticuloFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       Familia : TWideStringField;
       CodigoBarras : TWideStringField;
       FechaAlta : TDateField;
       Obsoleto : TBooleanField;
       NoAfectarStock : TBooleanField;
       NoCalcularMargen : TBooleanField;
       NoAfectarCoste : TBooleanField;
       Precio_Compra : TFloatField;
       UnidadesPrecioCompra : TIntegerField;
       Dto_Compra : TBCDField;
       Precio_Venta : TFloatField;         // Junto con el precio de compra, el precio de las líneas de movimientos y las tarifas, los únicos Double
       UnidadesPrecioVenta : TIntegerField;
       Recargo_Venta : TBCDField;
       Dto_Venta : TBCDField;
       CantidadMinimaVenta : TBCDField;
       MargenComercial : TBCDField;
       TipoIVA : TSmallIntField;
       PuntoVerde : TBCDField;
       FijarMedidas : TBooleanField;
       Largo : TBCDField;
       Ancho : TBCDField;
       Alto : TBCDField;
       NoAplicarTipoFijo : TBooleanField;
       NoAplicarRetencion : TBooleanField;
       Comision : TBCDField;
       Stock_Minimo : TBCDField;
       Stock_Maximo : TBCDField;
       UnidadesPorCaja : TBCDField;
       UnidadesPorPallet : TBCDField;
       Bultos : TBCDField;
       Kilos : TBCDField;
       Volumen : TBCDField;
       EsListaMateriales : TBooleanField;
       Desglosar : TBooleanField;
       CalcularPrecios : TBooleanField;
       CodigoAlmacen : TWideStringField;
       Ubicacion : TWideStringField;
       CodigoProveedor : TWideStringField;
       LoteOptimo : TBCDField;
       UnidadesCarga : TBCDField;
       ConEnvase : TBooleanField;
       Peligroso : TBooleanField;
       CampoLibre1 : TWideStringField;
       CampoLibre2 : TWideStringField;
       CampoLibre3 : TWideStringField;
       CampoLibre4 : TWideStringField;
       CampoLibre5 : TBCDField;
       CampoLibre6 : TBCDField;
       CampoLibre7 : TBCDField;
       CampoLibre8 : TBCDField;
       CampoLibre9 : TBooleanField;
       CampoLibre10 : TIntegerField;
       CampoLibre11 : TIntegerField;
       CampoLibre12 : TIntegerField;
       CampoLibre13 : TWideStringField;
       CampoLibre14 : TWideStringField;
       CampoLibre15 : TWideMemoField;
       CampoLibre16 : TWideMemoField;
       Oferta : TBooleanField;
       OfertaPrecioVenta : TFloatField;
       OfertaDescuento : TBCDField;
       OfertaFechaInicial,
       OfertaFechaFinal : TDateField;
       Parametros : TWordField;
       VisibleTienda : TBooleanField;
       // Tienda_CodigoCategoria : TWideStringField;
       Tienda_CodigoArticuloAgrupado : TWideStringField;
       Tienda_VisibleIndividualmente : TBooleanField;
       Tienda_NoPublicarClases : TBooleanField;
       Tienda_ComentariosClientes : TBooleanField;
       Tienda_NombreImagen : TWideStringField;
       DocumentosExternos : TWideStringField;
       Anotacion : TWideMemoField;
       Aviso : TWideMemoField;
       MostrarAviso : TBooleanField;
       Imagen : TGraphicField;
     end;

     TArticulosRelacionadosFields = class( TnxeDatasetFields)
     public
      Tipo : TSmallIntField;    // 0 = Relacionado, 1 = Equivalente
      Codigo : TWideStringField;
      NroOrden : TSmallIntField;
      CodigoArticuloRelacionado : TWideStringField;
      end;

     TArticuloDatEconFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       CodigoAlmacen : TWideStringField;
       [TAttrPeriodicalField( 'UnidComp_' )] UnidadesCompras : TListaCamposMensuales;
       [TAttrPeriodicalField( 'ImpComp_' )] ImporteCompras : TListaCamposMensuales;
       [TAttrPeriodicalField( 'DtosComp_' )] ImporteDescuentosCompras : TListaCamposMensuales;
       [TAttrPeriodicalField( 'UnidVent_' )] UnidadesVentas : TListaCamposMensuales;
       [TAttrPeriodicalField( 'ImpVent_' )] ImporteVentas : TListaCamposMensuales;
       [TAttrPeriodicalField( 'DtosVent_' )] ImporteDescuentosVentas : TListaCamposMensuales;
     end;

     TCampoLibreStringArray = array[ 1..8 ] of TWideStringField;
     TCampoLibreDateArray = array[ 1..2 ] of TDateField;

     TAuxiliarClienteFields = class( TnxeDatasetFields)
     public
       CodigoCliente : TWideStringField;
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Campo  : TCampoLibreStringArray;
       CampoFecha : TCampoLibreDateArray;
       CodigoEAN : TWideStringField;
     end;

     TAuxiliarProveedorFields = class( TnxeDatasetFields)
     public
       CodigoProveedor : TWideStringField;
       Codigo : TWideStringField;
       Campo  : TCampoLibreStringArray;
       CampoFecha : TCampoLibreDateArray;
     end;

     TImportesArray = array[ 1..NroMaximoTiposTasasImpreso ] of TBCDField;
     TFechaVencimientoArray = array[ 1..6 ] of TDateField;
     TImporteVencimientoArray = array[ 1..6 ] of TBCDField;
     TCampoLibreArray = array[ 1..5 ] of TWideStringField;

     TCabeceraFields = class( TnxeDatasetFields)
     public
       RegistroProcesado : TBooleanField;
       TipoMovimiento : TSmallIntField;
       NroOperacion : TIntegerField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       Ejercicio : TSmallIntField;
       Nro_Operacion : TIntegerField;
       NroCopia : TSmallIntField;
       CodigoPropietario : TWideStringField;
       FechaDocumento : TDateField;
       Fecha1 : TDateField;
       Fecha2 : TDateField;
       FechaEnvioPorCorreo : TDateField;
       Creado : TDateTimeField;
       NroDocPropietario : TWideStringField;
       Origen : TSmallIntField;
       EjercicioOrigen : TSmallIntField;
       NroOperacionOrigen : TIntegerField;
       NroFactura : TIntegerField;
       CodigoVendedor : TWideStringField;
       CodigoRegAuxiliar : TWideStringField;
       CodigoGrupo : TWideStringField;
       OrganismoPublico : TWideStringField;
       OrganoProponente : TWideStringField;
       NumeroExpediente : TWideStringField;
       NumeroContrato: TWideStringField;
       ReferenciaOperacion : TWideStringField;
       ServicioPrestadoTemporalmente : TBooleanField;
       InicioPeriodoFacturacion : TDateField;
       FinPeriodoFacturacion : TDateField;
       Subvencionada : TBooleanField;
       ImporteSubvencion : TBCDField;
       CodigoDivisa : TWideStringField;
       DescripcionDivisa : TWideStringField;
       TipoCambio : TBCDField;
       PrecisionDivisa : TBCDField;
       DescuentoPP : TBCDField;
       ImporteDtoPP : TBCDField;
       DescuentoES : TBCDField;
       ImporteDtoES : TBCDField;
       CosteArticulos : TBCDField;
       BrutoArticulos : TBCDField;
       DescuentoArticulos : TBCDField;
       DescuentoPropietario : TBCDField;
       ImportePuntoVerde : TBCDField;
       NetoArticulos : TBCDField;
       ImporteNeto : TBCDField;
       [TAttrFieldName('CuotaIVA')] TotalCuotaIVA : TBCDField;
       [TAttrFieldName('CuotaRE')]  TotalCuotaRE : TBCDField;
       ImporteComision : TBCDField;
       PrimerTipoIVA : TBCDField;
       PrimerTipoRE : TBCDField;
       TotalACuenta : TBCDField;
       TotalACuentaPedidos : TBCDField;
       CodigoFormaPago : TWideStringField;
       DescripcionFormaPago : TWideStringField;
       BIC : TWideStringField;
       IBAN : TWideStringField;
       BaseImponible,
       TipoIVA,
       CuotaIVA,
       TipoRE,
       CuotaRE,
       ImporteTotal : TImportesArray;
       TipoRetencion : TSmallIntField;
       BaseCalculoRetencion : TBCDField;
       ImporteRetencion : TBCDField;
       [TAttrFieldName('ImporteTotal')] TotalImporte : TBCDField;
       FechaVencimiento : TFechaVencimientoArray;
       ImporteVencimiento : TImporteVencimientoArray;
       SumaIVAyRE : TBCDField;
       SumaBultos : TBCDField;
       SumaKilos : TBCDField;
       SumaVolumen : TBCDField;
       SumaCajas : TBCDField;
       SumaPallets : TBCDField;
       ImporteCifra : TWideStringField;
       PorcentajeRetencion : TBCDField;
       Portes : TBCDField;
       CuotaIVAPortes : TBCDField;
       CuotaREPortes : TBCDField;
       PorcentajeRecFinanc : TBCDField;
       RecargoFinanciero : TBCDField;
       CodigoTransportista : TWideStringField;
       CodigoOperario : TWideStringField;
       CodigoEmpresa : TWideStringField;
       TotalEntrega : TBCDField;
       TotalEcotasa : TBCDField;
       TotalContribucionRAP : TBCDField;
       CampoLibre : TCampoLibreArray;
       FacturaRectificativa : TBooleanField;
       EjercicioFacturaRectificada : TSmallIntField;
       SerieFacturaRectificada : TStringField;
       NroFacturaRectificada : TIntegerField;
       Anotacion : TWideMemoField;
       Firma : TGraphicField;
       QRVerifactu : TWideStringField;
     end;

     TCabeceraAuxiliarFields = class( TnxeDatasetFields)
     public
       NroOperacion : TIntegerField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       Fecha : TDateField;
       Anotacion : TWideMemoField;
     end;

     TCarteraFields = class( TnxeDatasetFields)
     public
       CodigoAlmacen : TWideStringField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Tipo : TSmallIntField;
       Descripcion : TWideStringField;
       Cantidad : TBCDField;
       Importe : TBCDField;
       NroOperacion : TIntegerField;
       NroRegistro : TSmallIntField;
     end;

     TCapturadorFields = class( TnxeDatasetFields )
      public
       NroCapturador : TSmallIntField;
       Descripcion : TWideStringField;
       CodigoAlmacen : TWideStringField;
     end;

     TCarteraPedidoFields = class( TnxeDatasetFields)
     public
       CodigoCliente : TWideStringField;
       CodigoAlmacen : TWideStringField;
       EjercicioPedido : TSmallIntField;
       NroPedido : TIntegerField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Descripcion : TWideStringField;
       Cantidad : TBCDField;
       Importe : TBCDField;
     end;

     TClaseFields = class( TnxeDatasetFields)
     public
       NroClase : TSmallIntField;
       Codigo : TWideStringField;
       NroOrden : TSmallIntField;
       Descripcion : TWideStringField;
       Peso : TBCDField;
       Capacidad : TBCDField;
       Tipo : TSmallIntField;
       Material : TSmallIntField;
       TarifaRAPNormal : TBCDField;
       TarifaRAPPeligroso : TBCDField;
       DisponibleTienda : TBooleanField;
     end;

     TClasesArticuloFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       NroClase : TSmallIntField;
       CodigoClase : TWideStringField;
     end;

     TClienteDatEconFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       Pendiente : TBCDField;
       [TAttrPeriodicalField( 'Descuentos_' )] Descuentos : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Coste_'  )] Coste : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Ventas_' )] Ventas : TListaCamposMensuales;
       FechaUltFactura : TDateField;
     end;

     TCodigoBarrasFields = class( TnxeDatasetFields)
     public
       CodigoBarras : TWideStringField;
       CodigoArticulo : TWideStringField;
       ClaseA : TWideStringField;
       ClaseB : TWideStringField;
       ClaseC : TWideStringField;
     end;

     TCodigoTarifaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       PrecioParametro : TListaPrecioParametrosTarifa;
     end;

     TConsumoComprasFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Tipo : TSmallIntField;
       Proveedor : TWideStringField;
       FamiliaArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       [TAttrPeriodicalField( 'Unidades_' )] Unidades : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Importe_' )] Importe : TListaCamposMensuales;
       [TAttrPeriodicalField( 'ImporteDescuentos_' )] ImporteDescuentos: TListaCamposMensuales;
     end;

     TConsumosClienteFields = class( TnxeDatasetFields)
     public
       CodigoCliente : TWideStringField;
       NroOrden : TSmallIntField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Cajas : TBCDField;
       Cantidad : TBCDField;
       CantidadMedia : TBCDField;
       UltimoPrecio : TFloatField;
       Precio : TFloatField;
       PrecioActual : TFloatField;
       PrecioMedio : TFloatField;
       UltimoRecargo : TBCDField;
       Recargo : TBCDField;
       RecargoMedio : TBCDField;
       UltimoPuntoVerde : TBCDField;
       PuntoVerde : TBCDField;
       ContribucionRAP : TBCDField;
       DescuentoActual : TBCDField;
       UltimoDescuento : TBCDField;
       Descuento : TBCDField;
       DescuentoMedio : TBCDField;
       Fecha : TDateField;
     end;

     TConsumoVentasFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Tipo : TSmallIntField;
       Cliente : TWideStringField;
       FamiliaArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       [TAttrPeriodicalField( 'Unidades_' )] Unidades : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Importe_' )] Importe : TListaCamposMensuales;
       [TAttrPeriodicalField( 'ImporteDescuentos_' )] ImporteDescuentos: TListaCamposMensuales;
     end;

     TOrganismoPublicoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Tipo : TSmallIntField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       CodigoCentro : TWideStringField;
       CodigoPaisEnNIF : TBooleanField;
     end;

     TEfectoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Tipo : TSmallIntField;
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       NroEfecto : TSmallIntField;
       FechaFactura : TDateField;
       FechaVencimiento : TDateField;
       Importe : TBCDField;
       Emitido : TBooleanField;
       FechaEmision : TDateField;
     end;

     TEquipoMovilFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       CodigoVendedor : TWideStringField;
       CodigoUsuario : TWideStringField;
     end;

     TEtiquetaArticuloFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       NroRegistro : TIntegerField;
       ReferenciaProveedor : TWideStringField;
       ReferenciaCliente : TWideStringField;
       CodigoClaseA : TWideStringField;
       DescripcionClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       DescripcionClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       DescripcionClaseC : TWideStringField;
       Descripcion : TWideStringField;
       Anotacion : TWideMemoField;
       CodigoBarras : TWideStringField;
       LoteFabricacion : TWideStringField;
       NumeroSerie : TWideStringField;
       CodigoAlmacen : TWideStringField;
       Ubicacion : TWideStringField;
       TipoLinea : TWideStringField;
       Cantidad : TBCDField;
       Precio : TBCDField;
       PrecioVenta : TBCDField;
       PuntoVerde : TBCDField;
       RecargoVenta : TBCDField;
       TipoIVA : TBCDField;
       Descuento : TBCDField;
       PrecioIVAIncluido : TBCDField;
       PrecioVentaIVAIncluido : TBCDField;
       NroBultoLinea : TBCDField;
       NroBultoAlbaran : TBCDField;
       Bultos : TBCDField;
       Volumen : TBCDField;
       Kilos : TBCDField;
       NroBultosLinea : TBCDField;
       VolumenLinea : TBCDField;
       KilosLinea : TBCDField;
       NroBultosAlbaran : TBCDField;
       VolumenAlbaran : TBCDField;
       KilosAlbaran : TBCDField;
       CampoLibre1 : TWideStringField;
       CampoLibre2 : TWideStringField;
       CampoLibre3 : TDateField;
       CampoLibre4 : TBCDField;
       CampoLibre5 : TWideStringField;
       Cliente_Codigo : TWideStringField;
       Proveedor_Codigo : TWideStringField;
       EjercicioAlbaran : TSmallIntField;
       NroOperacionAlbaran : TIntegerField;
       FechaAlbaran : TDateField;
       SerieAlbaran : TWideStringField;
       NroAlbaran : TIntegerField;
       NroLineaAlbaran : TSmallIntField;
       EjercicioPedido : TSmallIntField;
       NroOperacionPedido : TIntegerField;
       NroPedido : TIntegerField;
       NroLineaPedido : TSmallIntField;
       CodigoVendedor : TWideStringField;
       RegistroAuxiliar : TWideStringField;
       GrupoCliente : TWideStringField;
     end;

     TEtiquetaPostalFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       NombrePais : TWideStringField;
       CP : TWideStringField;
       Provincia : TWideStringField;
     end;

     TExistenciasArticuloFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoAlmacen : TWideStringField;
       Ubicacion: TWideStringField;
       StockMinimo : TBCDField;
       StockMaximo : TBCDField;
     end;
     
     TFacturaComprasFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Proveedor : TWideStringField;
       SerieNroFactura : TWideStringField;
       FechaRecepcion : TDateField;
       Fecha : TDateField;
       BrutoArticulos : TBCDField;
       DescuentoArticulos : TBCDField;
       DescuentoProveedores : TBCDField;
       ImportePuntoVerde : TBCDField;
       NetoFactura : TBCDField;
       NetoFacturaRetencion : TBCDField;
       Origen : TSmallIntField;
       BaseCalculoRetencion : TBCDField;
       TipoRetencion : TSmallIntField;
       ImporteRetencion : TBCDField;
       RecargoFinanciero : TBCDField;
       ImporteRecFinanciero : TBCDField;
       CuotaIVA : TBCDField;
       Portes : TBCDField;
       TotalFactura : TBCDField;
       DescuentoPP : TBCDField;
       ImporteDtoPP : TBCDField;
       DescuentoES : TBCDField;
       ImporteDtoES : TBCDField;
       CodigoFormaPago : TWideStringField;
       DiaPago1 : TSmallIntField;
       DiaPago2 : TSmallIntField;
       NroRegistro : TIntegerField;
       Traspasada : TBooleanField;
       PagoBloqueado : TBooleanField;
       MotivoBloqueoPago: TWideMemoField;
       Anotacion : TWideMemoField;
     end;

     TFacturaVentasFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Serie : TWideStringField;
       NroFactura : TIntegerField;
       CodigoCliente : TWideStringField;
       Fecha : TDateField;
       NroRegistroPresentacion : TLongWordField;    // El orden en el que ha sido presentada (Veri*factu)
       GrupoFacturacion : TWideStringField;
       CodigoVendedor : TWideStringField;
       RegistroAuxiliar : TWideStringField;
       CodigoFormaCobro : TWideStringField;
       OrganismoPublico : TWideStringField;
       OrganoProponente : TWideStringField;
       NumeroExpediente : TWideStringField;
       NumeroContrato: TWideStringField;
       ReferenciaOperacion : TWideStringField;
       ServicioPrestadoTemporalmente : TBooleanField;
       InicioPeriodoFacturacion : TDateField;
       FinPeriodoFacturacion : TDateField;
       Subvencionada : TBooleanField;
       ImporteSubvencion : TBCDField;       
       DiaCobro1 : TSmallIntField;
       DiaCobro2 : TSmallIntField;
       DescuentoPP : TBCDField;
       ImporteDtoPP : TBCDField;
       DescuentoES : TBCDField;
       ImporteDtoES : TBCDField;
       TipoComision : TBCDField;
       CosteArticulos : TBCDField;
       BrutoArticulos : TBCDField;
       DescuentosArticulos : TBCDField;
       DescuentosClientes : TBCDField;
       ImportePuntoVerde : TBCDField;
       ImporteContribucionRAP : TBCDField;
       NetoFactura : TBCDField;
       NetoFacturaRetencion : TBCDField;
       BaseCalculoRetencion : TBCDField;
       TipoRetencion : TSmallIntField;
       ImporteRetencion : TBCDField;
       RecargoFinanciero : TBCDField;
       ImporteRecFinanciero : TBCDField;
       CuotaIVA : TBCDField;
       CuotaRE : TBCDField;
       Comision : TBCDField;
       Portes : TBCDField;
       TotalFactura : TBCDField;
       InversionSujetoPasivo : TBooleanField;
       TotalACuenta : TBCDField;       
       Traspasada : TBooleanField;
       FechaValor : TDateField;
       FechaEnvioPorCorreo : TDateField;
       Anotacion : TWideMemoField;
       Presentada : TDateTimeField;  // Timestamp de presentación del registro (Verifactu)
       Anulada : TBooleanField;
       Huella : TWideStringField;
     end;

     TFamiliaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       Cta_Compras : TWideStringField;
       Cta_DevCompras : TWideStringField;
       Cta_Ventas : TWideStringField;
       Cta_DevVentas : TWideStringField;
     end;

     TFormaEnvioFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       Portes : TSmallIntField;
       Importe : TBCDField;
     end;

     TGrupoClienteFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       CodigoTarifa : TWideStringField;
       CtaVentas : TWideStringField;
       CtaDevVentas : TWideStringField;
     end;

     TGrupoProveedorFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       CtaCompras : TWideStringField;
       CtaDevCompras : TWideStringField;
     end;

     TGrupoDocumentoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
     end;

     TLineaRutaFields = class( TnxeDatasetFields)
     public
       CodigoRuta : TWideStringField;
       NroOrden : TSmallIntField;
       CodigoCliente : TWideStringField;
     end;

     TRutaDistribucionFields = class( TnxeDatasetFields)
     public
       NroOperacion : TUnsignedAutoIncField;
       CodigoRuta : TWideStringField;
       Fecha : TDateField;
     end;

     TLineaRutaDistribucionFields = class( TnxeDatasetFields)
     public
       NroOperacion : TLongWordField;
       NroOrden : TSmallIntField;
       CodigoCliente : TWideStringField;
       NroDocumento1 : TIntegerField;
       NroDocumento2 : TIntegerField;
       NroDocumento3 : TIntegerField;
       NroDocumento4 : TIntegerField;
     end;

     TGrupoLineasFields = class( TnxeDatasetFields)
     public
       EjercicioDocumento : TSmallIntField;
       NroOperacion : TIntegerField;
       NroOperacionDoc : TIntegerField;
       NroPagina : TSmallIntField;
       CodigoGrupo : TWideStringField;
       Descripcion : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TLineasFields = class( TnxeDatasetFields)
     public
       NroOperacion : TIntegerField;
       NroOperacionDoc : TIntegerField;
       NroPagina : TSmallIntField;
       NroLinea : TSmallIntField;
       NroRegistro : TSmallIntField;
       NroRegistroDoc : TIntegerField;
       Fecha : TDateField;
       AsignacionOrigen : TSmallIntField;
       TipoMovimientoOrigen : TSmallIntField;
       EjercicioOrigen : TSmallIntField;
       NroOperacionOrigen : TIntegerField;
       NroRegistroOrigen : TIntegerField;
       EjercicioDocumento : TSmallIntField;
       SerieDocumento : TWideStringField;
       NroDocumento : TIntegerField;
       CodigoRegAuxiliar: TWideStringField;
       CodigoArticulo : TWideStringField;
       Referencia : TWideStringField;
       CodigoClaseA : TWideStringField;
       DescripcionClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       DescripcionClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       DescripcionClaseC : TWideStringField;
       Descripcion : TWideStringField;
       FechaAplicacion : TDateField;
       Anotacion : TWideMemoField;
       LoteFabricacion : TWideStringField;
       NumeroSerie : TWideStringField;
       CampoLibre1 : TWideStringField;
       CampoLibre2 : TWideStringField;
       CampoLibre3 : TDateField;
       CampoLibre4 : TBCDField;
       TipoLinea : TWideStringField;
       CodigoAlmacen : TWideStringField;
       CodigoUbicacion : TWideStringField;
       Largo : TBCDField;
       Ancho : TBCDField;
       Alto : TBCDField;
       Cantidad : TBCDField;
       Precio : TFloatField;  //..
       UnidadesPrecio : TIntegerField;
       PrecioDivisa : TBCDField;
       ImporteBruto : TBCDField;
       PuntoVerde : TBCDField;
       Recargo : TBCDField;
       Descuento : TBCDField;
       ImportePuntoVerde : TBCDField;
       ImporteContribucionRAP : TBCDField;
       ImporteDescuento : TBCDField;
       ImporteNeto : TBCDField;
       CodigoTipoIVA : TSmallIntField;
       TipoIVA : TBCDField;
       CuotaIVA : TBCDField;
       CodigoTipoRE : TSmallIntField;
       TipoRE : TBCDField;
       CuotaRE : TBCDField;
       TotalLinea : TBCDField;
       PrecioIVAIncluido : TBCDField;
       TotalBultos : TBCDField;
       TotalKilos : TBCDField;
       TotalVolumen : TBCDField;
       TotalPallets : TBCDField;
       NroCajas : TBCDField;
       CantidadProcesada : TBCDField;
       Cargado : TBCDField;
       EnvasesDeposito : TBCDField;
       ContenedoresDeposito : TBCDField;
     end;

     TLineaVentaPeriodicaFields = class( TnxeDatasetFields)
     public
       NroFicha : TIntegerField;
       NroRegistro : TSmallIntField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       NumeroSerie : TWideStringField;
       Descripcion : TWideStringField;
       Cantidad : TBCDField;
       Precio : TFloatField;
       Recargo : TBCDField;
       Descuento : TBCDField;
       Anotacion : TWideMemoField;
     end;

     TListaMaterialesFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       NroLinea : TSmallIntField;
       CodigoComponente : TWideStringField;
       ClaseAComponente : TWideStringField;
       ClaseBComponente : TWideStringField;
       ClaseCComponente : TWideStringField;
       Referencia : TWideStringField;
       Largo : TBCDField;
       Ancho : TBCDField;
       Alto : TBCDField;
       Cantidad : TBCDField;
       Anotacion : TWideMemoField;
     end;

     TMovimientoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       TipoMovimiento : TSmallIntField;
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       UUID : TGuidField;
       Fecha : TDateField;
       FechaAplicacion : TDateField;
       FechaEmision : TDateField;
       FechaAuxiliar : TDateField;
       GrupoFacturacion : TWideStringField;
       RegistroAuxiliar : TWideStringField;
       CodigoVendedor : TWideStringField;
       CodigoOperario : TWideStringField;
       CentroCoste : TWideStringField;
       FormaEnvio : TWideStringField;
       EjercicioFactura : TSmallIntField;
       PropietarioFactura : TWideStringField;
       SerieFactura : TWideStringField;
       NroFactura : TIntegerField;
       NoFacturar : TBooleanField;
       Facturado : TBooleanField;
       Traspasado : TBooleanField;
       Anulado : TBooleanField;
       Origen : TSmallIntField;
       Opcion : TSmallIntField;
       EjercicioOrigen : TSmallIntField;
       NroOperacionOrigen : TIntegerField;
       NroDocumentoPropietario : TWideStringField;
       EntregaACuenta : TBCDField;
       EntregaEfectivo : TBCDField;
       CodigoTransportista : TWideStringField;
       IVAIncluido : TBooleanField;
       Portes : TBCDField;
       CodigoFormaCobro : TWideStringField;
       OrganismoPublico : TWideStringField;
       Situacion : TSmallIntField;
       DescripcionMovimiento : TWideStringField;
       CampoLibre : TCampoLibreArray;
       TipoVentaPeriodica : TSmallIntField;
       Creado : TDateTimeField;
       Revisado : TBooleanField;
       Suministrado : TBooleanField;
       FechaEnvioPorCorreo : TDateField;
       Anotacion : TWideMemoField;
       Firma : TGraphicField;
     end;

     TGrupoLineaMovimientoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       NroPagina : TSmallIntField;
       CodigoGrupo : TWideStringField;
       Descripcion : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TLineaMovimientoFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       NroPagina : TSmallIntField;
       NroLinea : TSmallIntField;
       Fecha : TDateField;
       FechaAplicacion : TDateField;
       FechaCaducidad : TDateField;
       NroRegistro : TUnsignedAutoIncField;
       AsignacionOrigen : TSmallIntField;
       TipoMovimientoOrigen : TSmallIntField;
       EjercicioOrigen : TSmallIntField;
       NroOperacionOrigen : TIntegerField;
       NroRegistroOrigen : TIntegerField;
       UIDArticulo : TGuidField;
       CampoLibre1 : TWideStringField;
       CampoLibre2 : TWideStringField;
       CampoLibre3 : TDateField;
       CampoLibre4 : TBCDField;
       CampoLibre5 : TWideStringField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       LoteFabricacion : TWideStringField;
       NumeroSerie : TWideStringField;
       Descripcion : TWideStringField;
       CodigoAlmacen : TWideStringField;
       Ubicacion : TWideStringField;
       Cantidad : TBCDField;
       CantidadAjustada,
       CantidadProcesada : TBCDField;
       Procesada : TBooleanField;               // Se ha dado la línea por recibida o servida de forma manual por parte del usuario
       PrecioDivisa : TBCDField;
       Precio : TFloatField;                    // El otro Double existente. Solo sirve para poder almacenar precios base de más de 4 decimales para poder calcular precios con IVA ajustados
       Recargo : TBCDField;
       PuntoVerde : TBCDField;
       ContribucionRAP : TBCDField;
       Descuento : TBCDField;
       NroCajas : TBCDField;
       Largo : TBCDField;
       Ancho : TBCDField;
       Alto : TBCDField;
       Bultos : TBCDField;
       ImporteRecargo :  TBCDField;
       PorcentajeRecargo :  TBCDField;
       NoCalcularMargen : TBooleanField;
       TipoLinea : TWideStringField;
       Oferta : TBooleanField;
       PesoEnvase,
       Tara,
       Peso,
       ImporteBruto,
       ImporteDescuento,
       ImporteNeto : TBCDField;
       CodigoTipoIVA : TSmallIntField;
       CuotaIVA,
       CuotaRE,
       PrecioIVA,
       ImporteTotal : TBCDField;
       Parametros : TWordField;
       Anotacion : TWideMemoField;
     end;

    TOperarioFields = class( TnxeDatasetFields )
    public
      CodigoPropietario,
      Codigo,
      Nombre,
      CodigoOperarioTipo : TWideStringField;
      Domicilio : TWideStringField;
      Localidad : TWideStringField;
      CodigoPais : TWideStringField;
      CodigoProvincia : TWideStringField;
      CodigoPostal : TWideStringField;
      NIF : TWideStringField;
      Telefono : TWideStringField;
      Movil : TWideStringField;
      Fax : TWideStringField;
      EMail : TWideStringField;
      Campo : TCampoLibreStringArray;
      CampoFecha : TCampoLibreDateArray;
      end;

     TProveedorDatEconFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       [TAttrPeriodicalField( 'Compras_' )] Compras : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Descuentos_' )] Descuentos : TListaCamposMensuales;
       FechaUltFactura : TDateField;
     end;

     TRelacionAlbaranesFields = class( TnxeDatasetFields)
     public
       NroRegistro : TIntegerField;
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       Propietario : TWideStringField;
       Fecha : TDateField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       NroOperacion : TIntegerField;
       Importe : TBCDField;
     end;

     TRelacionDocumentosFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       NroProceso : TSmallIntField;
       NroLinea : TSmallIntField;
       Documento : TWideStringField;
     end;

     TRegistroActualizacionFields = class( TnxeDatasetFields)
      public
        TipoRegistro : TSmallIntField;
        Codigo : TWidestringField;
        Id : TLongWordField;
        Ejercicio : TSmallIntField;
        Serie : TWideStringField;
        NroDocumento : TIntegerField;
        Actualizado : TBooleanField;
        FechaActualizacion : TDateTimeField;
        ImagenActualizada : TBooleanField;
        FechaImagenExterna : TDateTimeField;
        Id1 : TLongWordField;
        Id2 : TLongWordField;
        Resultado : TWideMemoField;
      end;

     TRutaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
     end;

     TRutasEquipoMovilFields = class( TnxeDatasetFields)
     public
       NroOrden : TSmallIntField;
       CodigoEquipoMovil : TWideStringField;
       CodigoRuta : TWideStringField;
     end;

     TStockFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       LoteFabricacion : TWideStringField;
       CodigoAlmacen : TWideStringField;
       Ubicacion : TWideStringField;
       FechaCaducidad : TDateField;  // La del lote de fabricación
       UIDArticulo : TGuidField;
       FechaUltCompra : TDateField;
       FechaUltVenta : TDateField;
       FechaUltEntrada : TDateField;
       FechaUltEntradaCoste : TDateField;
       FechaUltSalida : TDateField;
       PrecioUltCompra : TBCDField;
       CosteUltEntrada : TBCDField;
       Coste_Medio : TBCDField;
       PrecioUltVenta : TBCDField;
       PrecioUltSalida : TBCDField;
       PendienteRecibir,
       PendienteServir : array[ 0..1 ] of TBCDField;
       MovimientoMes : array[ 0..12, 0..1 ] of TBCDField;
       procedure SetupFields; override;
     end;

     TTablaComisionFields = class( TnxeDatasetFields)
     public
       Relacion : TSmallIntField;
       CodigoVendedor : TWideStringField;
       CodigoCliente : TWideStringField;
       CodigoArticulo : TWideStringField;
       Tipo : TBCDField;
     end;

     TTarifaCantidadVentaFields = class( TnxeDatasetFields)
     public
       CodigoCliente : TWideStringField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       NroRegistro : TSmallIntField;
       CantidadMinima : TBCDField;
       CantidadMaxima : TBCDField;
       Precio : TFloatField;
       Descuento : TBCDField;
     end;

     TTarifaClaseFields = class( TnxeDatasetFields)
     public
       Seccion : TSmallIntField;
       CodigoPropietario : TWideStringField;
       CodigoArticulo : TWideStringField;
       ClaseA : TWideStringField;
       ClaseB : TWideStringField;
       ClaseC : TWideStringField;
       Precio : TFloatField;
       Descuento : TBCDField;
     end;

     TTarifaComprasFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       CodigoProveedor : TWideStringField;
       CodigoArticulo : TWideStringField;
       Referencia : TWideStringField;
       Precio : TFloatField;
       Descuento : TBCDField;
     end;

     TTarifaVentasFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       CodigoTarifa : TWideStringField;
       CodigoArticulo : TWideStringField;
       Referencia : TWideStringField;
       Disponible : TBooleanField;
       CantidadMinima : TBCDField;
       Precio : TFloatField;
       Recargo : TBCDField;
       Descuento : TBCDField;
       PrecioParametro : TListaPrecioParametrosTarifa;
     end;

     TTipoEnvaseFields = class( TnxeDatasetFields)
     public
       Codigo : TSmallIntField;
       Descripcion : TWideStringField;
     end;

     TTipoLineaMovimientoFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
     end;

     TTipoMovAlmacenFields = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Descripcion : TWideStringField;
       NoAfectarCoste : TBooleanField;
     end;

     TTiposIVAArticuloPaisFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoPais : TWideStringField;
       TipoIVA : TSmallIntField;
     end;

     TTipoVentaPeriodica = class( TnxeDatasetFields)
     public
       Tipo : TSmallIntField;
       Descripcion : TWideStringField;
     end;
     
     TTransportistaFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       Matricula : TWideStringField;
       Semiremolque : TWideStringField;
       NIF : TWideStringField;
       Telefono : TWideStringField;
       Movil : TWideStringField;
       Fax : TWideStringField;
       EMail : TWideStringField;
       CodigoProveedor : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TUbicacionFields = class( TnxeDatasetFields)
     public
       CodigoAlmacen : TWideStringField;
       Codigo : TWideStringField;
       Descripcion : TWideStringField;
       UbicacionDeCarga : TBooleanField;
     end;

     TVendedorFields = class( TnxeDatasetFields)
     public
       Codigo : TWideStringField;
       Nombre : TWideStringField;
       Domicilio : TWideStringField;
       Localidad : TWideStringField;
       CodigoPais : TWideStringField;
       CodigoProvincia : TWideStringField;
       CodigoPostal : TWideStringField;
       NIF : TWideStringField;
       Telefono : TWideStringField;
       Movil : TWideStringField;
       Fax : TWideStringField;
       EMail : TWideStringField;
       Comision : TBCDField;
       TipoIVA : TSmallIntField;
       TipoIRPF : TSmallIntField;
       Bloqueado : TBooleanField;
       Anotacion : TWideMemoField;
       Aviso : TWideMemoField;
     end;

     TVendedorDatEconFields = class( TnxeDatasetFields)
     public
       Ejercicio : TSmallIntField;
       Codigo : TWideStringField;
       [TAttrPeriodicalField( 'Ventas_' )] Ventas : TListaCamposMensuales;
       [TAttrPeriodicalField( 'Comision_' )] Comision : TListaCamposMensuales;
     end;

     TVentaPeriodicaFields = class( TnxeDatasetFields)
     public
       NroFicha : TIntegerField;
       CodigoCliente : TWideStringField;
       Tipo : TSmallIntField;
       Periodicidad : TSmallIntField;
       MesPago : TSmallIntField;
       NoAplicar : TBooleanField;
       UltimaAplicacion : TDateField;       
       Serie : TWideStringField;
       RegistroAuxiliar : TWideStringField;
       CentroCoste : TWideStringField;
       Anotacion : TWideMemoField;
     end;

     TCambioPreciosFields = Class( TnxeDatasetFields )
     public
       NroRegistro : TSmallIntField;
       Descripcion : TWideStringField;
       Seleccion : TSmallIntField;
       CodigoInicial : TWideStringField;
       CodigoFinal : TWideStringField;
       Operacion : TSmallIntField;
       PorcentajeOperacion : TBCDField;
       ImporteOperacion : TBCDField;
       MargenOperacion : TBCDField;
       PrecioReferencia : TSmallIntField;
       Origen : TSmallIntField;
       ProveedorOrigen : TWideStringField;
       TarifaOrigen : TWideStringField;
       ClienteOrigen : TWideStringField;
       PrecioFinal : TSmallIntField;
       Destino : TSmallIntField;
       ProveedorDestino : TWideStringField;
       TarifaDestino : TWideStringField;
       ClienteDestino : TWideStringField;
       AplicarDescuento : TBooleanField;
       Precision : TSmallIntField;
       Redondear : TBooleanField;
       Multiplos5 : TBooleanField;
       Borrador : TBooleanField;
      end;

     // Reports

     TReportExistenciasFields = class( TnxeDatasetFields)
     public
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       Descripcion : TWideStringField;
       CodigoAlmacen : TWideStringField;
       LoteFabricacion : TWideStringField;
       CodigoFamilia : TWideStringField;
       DescripcionFamilia : TWideStringField;
       Entradas : TBCDField;
       Salidas : TBCDField;
       Existencias : TBCDField;
       PendienteRecibir : TBCDField;
       PendienteServir : TBCDField;
       StockMinimo : TBCDField;
       StockMaximo : TBCDField;
       Coste : TBCDField;
       end;

     TReportConsumosFields = class( TnxeDatasetFields )
      Id : TWideStringField;
      Tipo : TSmallIntField;
      CodigoAgrupacion,
      Codigo,
      Descripcion,
      CodigoFamilia,
      DescripcionFamilia,
      CodigoPropietario,
      Nombre,
      CodigoClaseA,
      CodigoClaseB,
      CodigoClaseC,
      CodigoGrupo,
      DescripcionGrupo,
      CodigoAlmacen : TWideStringField;
      Periodo : TSmallIntField;
      Unidades1,
      Importe1,
      ImporteCoste1,
      ImporteDescuentos1,
      PrecioCoste1,
      PrecioMedio1,
      MargenMedio1,
      SumaImporte1 : TBCDField;
      Porcentaje1 : TSmallIntField;
      Unidades2,
      Importe2,
      ImporteCoste2,
      PrecioCoste2,
      ImporteDescuentos2,
      PrecioMedio2,
      MargenMedio2,
      SumaImporte2 : TBCDField;
      Porcentaje2 : TSmallIntField;
      end;

     TCarteraArticulosFields = class( TnxeDatasetFields)
     public
       NroRegistro : TIntegerField;
       CodigoAlmacen : TWideStringField;
       CodigoArticulo : TWideStringField;
       CodigoClaseA : TWideStringField;
       CodigoClaseB : TWideStringField;
       CodigoClaseC : TWideStringField;
       CodigoFamilia : TWideStringField;
       Descripcion : TWideStringField;
       NombreAlmacen : TWideStringField;
       Tipo : TSmallIntField;
       NroCajas : TBCDField;
       Cantidad : TBCDField;
       Precio : TFloatField;
       EcoTasa : TBCDField;
       ImporteBruto : TBCDField;
       Descuento : TBCDField;
       Recargo : TBCDField;
       NroCajas2 : TBCDField;  // Lo utilizo para calcular promedios o segundos valores
       Cantidad2 : TBCDField;
       Precio2 : TFloatField;
       Descuento2 : TBCDField;
       Recargo2 : TBCDField;
       ImporteNeto : TBCDField;
       Pendiente : TBCDField;
       Existencias : TBCDField;
       ExistenciasVirtuales : TBCDField;
       Coste : TBCDField;
       Bultos,
       Kilos,
       Volumen : TBCDField;
       Ejercicio : TSmallIntField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       NroOperacion : TIntegerField;
       CodigoPropietario : TWideStringField;
       NombrePropietario : TWideStringField;
       Fecha : TDateField;
       FechaAplicacion : TDateField;
       end;

     TConsultaMovimientoFields = class( TnxeDatasetFields )
     public
       RegistroProcesado : TBooleanField;
       Ejercicio : TSmallIntField;
       NroOperacion : TIntegerField;
       TipoMovimiento : TSmallIntField;
       Propietario : TWideStringField;
       Serie : TWideStringField;
       NroDocumento : TIntegerField;
       Fecha : TDateField;
       FechaAplicacion : TDateField;
       Situacion : TSmallIntField;
       NoFacturar : TBooleanField;
       Facturado : TBooleanField;
       NroFactura : TIntegerField;
       Traspasado : TBooleanField;
       EstadoDocumento : TWideStringField;
       CodigoArticulo,
       CodigoClaseA,
       CodigoClaseB,
       CodigoClaseC,
       CodigoAlmacen : TWideStringField;
       Cantidad,
       CantidadProcesada,
       Pendiente : TBCDField;
       Procesada : TBooleanField;
       Precio : TFloatField;
       PuntoVerde : TBCDField;
       ContribucionRAP : TBCDField;
       Recargo,
       Descuento,
       ImporteBruto,
       ImporteDescuento,
       ImportePendiente : TBCDField;
       CodigoTipoIVA : TSmallIntField;
       CuotaIVA,
       CuotaRE,
       PrecioIVA,
       ImporteNeto,
       ImporteTotal,
       StockActual,
       EnvasesDeposito,
       ContenedoresDeposito : TBCDField;

       NoCalcularMargen : TBooleanField;
       Coste : TBCDField;
       Margen : TBCDField;
       MargenPorcentual : TBCDField;
       ImporteNetoCalculado : TBCDField;
       EsCosteReal : TBooleanField;

     end;

     TReportTarifaFields = class( TnxeDatasetFields )
       Tipo : TSmallIntField;
       CodigoTarifa,
       Descripcion,
       CodigoArticulo,
       DescripcionArticulo,
       Referencia : TWideStringField;
       Precio : TFloatField;
       Recargo,
       Descuento : TBCDField;
       TipoIVA : TSmallIntField;
       PrecioIVA,
       PorcentajeIVA : TBCDField;
     end;

     TReportCabeceraFacturaFields = class( TnxeDatasetFields )
      NroOperacion : TIntegerField;
      CodigoPropietario : TWideStringField;
      Nombre : TWideStringField;
      CodigoGrupo : TWideStringField;
      DescripcionGrupo : TWideStringField;
      Fecha : TDateField;
      Serie : TWideStringField;
      NroFactura : TIntegerField;
      Ejercicio : TSmallIntField;
      Traspasada : TBooleanField;
      BrutoArticulos : TBCDField;
      DescuentoArticulos : TBCDField;
      DescuentoPropietario : TBCDField;
      NetoFactura : TBCDField;
      CuotaIVA : TBCDField;
      TotalFactura : TBCDField;
      end;

    TReportLineasFacturaFields = class( TnxeDatasetFields )
      NroOperacion : TIntegerField;
      Ejercicio : TSmallIntField;
      NroOperacionMovimiento : TIntegerField;
      Fecha : TDateField;
      Serie : TWideStringField;
      NroDocumento : TIntegerField;
      BrutoArticulos : TBCDField;
      DescuentoArticulos : TBCDField;
      NetoAlbaran : TBCDField;
      CuotaIVA : TBCDField;
      TotalAlbaran : TBCDField;
      end;

    TReportFichaArticuloFields = class( TnxeDatasetFields )
      Ejercicio : TSmallIntField;
      Serie : TWideStringField;
      NroDocumento : TIntegerField;
      NroLinea : TSmallIntField;
      NroRegistro : TIntegerField;
      Fecha : TDateField;
      CodigoPropietario : TWideStringField;
      Nombre : TWideStringField;
      TipoMovimiento : TSmallIntField;
      DescripcionTipoMovimiento : TWideStringField;
      CodigoArticulo : TWideStringField;
      CodigoClaseA : TWideStringField;
      CodigoClaseB : TWideStringField;
      CodigoClaseC : TWideStringField;
      Descripcion : TWideStringField;
      LoteFabricacion : TWideStringField;
      CodigoAlmacen : TWideStringField;
      Ubicacion : TWideStringField;
      Entradas : TBCDField;
      Salidas : TBCDField;
      Precio : TFloatField;
      Descuento : TBCDField;
      Existencias : TBCDField;
      PrecioNeto : TBCDField;
      end;

implementation

procedure TStockFields.SetupFields;
begin
     Ejercicio := SmallIntField( 'Ejercicio' );
     CodigoArticulo := WideStringField( 'CodigoArticulo' );
     CodigoClaseA := WideStringField( 'CodigoClaseA' );
     CodigoClaseB := WideStringField( 'CodigoClaseB' );
     CodigoClaseC := WideStringField( 'CodigoClaseC' );
     LoteFabricacion := WideStringField( 'LoteFabricacion' );
     CodigoAlmacen := WideStringField( 'CodigoAlmacen' );
     Ubicacion := WideStringField( 'Ubicacion' );
     FechaCaducidad := DateField( 'FechaCaducidad' );
     UIDArticulo := GuidField( 'UIDArticulo' );
     FechaUltCompra := DateField( 'FechaUltCompra' );
     FechaUltVenta := DateField( 'FechaUltVenta' );
     FechaUltEntrada := DateField( 'FechaUltEntrada' );
     FechaUltEntradaCoste := DateField( 'FechaUltEntradaCoste' );
     FechaUltSalida := DateField( 'FechaUltSalida' );
     PrecioUltCompra := BCDField( 'PrecioUltCompra' );
     CosteUltEntrada := BCDField( 'CosteUltEntrada' );
     Coste_Medio := BCDField( 'Coste_Medio' );
     PrecioUltVenta := BCDField( 'PrecioUltVenta' );
     PrecioUltSalida := BCDField( 'PrecioUltSalida' );
     PendienteRecibir[ 0 ] := BCDField( 'Pendiente_Recibir0' );
     PendienteRecibir[ 1 ] := BCDField( 'Pendiente_Recibir' );
     PendienteServir[ 0 ] := BCDField( 'Pendiente_Servir0' );
     PendienteServir[ 1 ] := BCDField( 'Pendiente_Servir' );
     MovimientoMes[ 0, 0 ] := BCDField( 'Apertura_Entradas' );
     MovimientoMes[ 0, 1 ] := BCDField( 'Apertura_Salidas' );
     MovimientoMes[ 1, 0 ] := BCDField( 'Enero_Entradas' );
     MovimientoMes[ 1, 1 ] := BCDField( 'Enero_Salidas' );
     MovimientoMes[ 2, 0 ] := BCDField( 'Febrero_Entradas' );
     MovimientoMes[ 2, 1 ] := BCDField( 'Febrero_Salidas' );
     MovimientoMes[ 3, 0 ] := BCDField( 'Marzo_Entradas' );
     MovimientoMes[ 3, 1 ] := BCDField( 'Marzo_Salidas' );
     MovimientoMes[ 4, 0 ] := BCDField( 'Abril_Entradas' );
     MovimientoMes[ 4, 1 ] := BCDField( 'Abril_Salidas' );
     MovimientoMes[ 5, 0 ] := BCDField( 'Mayo_Entradas' );
     MovimientoMes[ 5, 1 ] := BCDField( 'Mayo_Salidas' );
     MovimientoMes[ 6, 0 ] := BCDField( 'Junio_Entradas' );
     MovimientoMes[ 6, 1 ] := BCDField( 'Junio_Salidas' );
     MovimientoMes[ 7, 0 ] := BCDField( 'Julio_Entradas' );
     MovimientoMes[ 7, 1 ] := BCDField( 'Julio_Salidas' );
     MovimientoMes[ 8, 0 ] := BCDField( 'Agosto_Entradas' );
     MovimientoMes[ 8, 1 ] := BCDField( 'Agosto_Salidas' );
     MovimientoMes[ 9, 0 ] := BCDField( 'Septiembre_Entradas' );
     MovimientoMes[ 9, 1 ] := BCDField( 'Septiembre_Salidas' );
     MovimientoMes[ 10, 0 ] := BCDField( 'Octubre_Entradas' );
     MovimientoMes[ 10, 1 ] := BCDField( 'Octubre_Salidas' );
     MovimientoMes[ 11, 0 ] := BCDField( 'Noviembre_Entradas' );
     MovimientoMes[ 11, 1 ] := BCDField( 'Noviembre_Salidas' );
     MovimientoMes[ 12, 0 ] := BCDField( 'Diciembre_Entradas' );
     MovimientoMes[ 12, 1 ] := BCDField( 'Diciembre_Salidas' );
end;

end.



