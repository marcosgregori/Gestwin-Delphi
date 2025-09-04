{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_mov;

interface

uses SysUtils,
     Classes,

     LibUtils,
     AppManager,
     DataManager,
     Gim30Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,
     nxsdTypes,

     SessionIntf,

     MovimientoIntf,
     LineaMovimientoIntf;

const

     CLSID_MovimientoService : TGuid = '{BFBB7429-65BC-41FA-9BBD-321689441BFF}';

     // Tipos de movimiento

     tmNoDefinido            = 0;
     tmInventario            = 1;
     tmReubicacionCarga      = 2;   // Hojas de carga
     tmDispFabricacion       = 3;
     tmEntrada               = 4;
     tmSalida                = 5;
     tmFabricacion           = 6;
     tmRegularizacion        = 7;
     tmDespiece              = 8;
     tmFabricacionDefectuosa = 9;

     tmOferta                = 10;  // Compras
     tmPedidoCompra          = 11;
     tmCompra                = 12;

     tmPresupuesto           = 13;  // Ventas
     tmPedidoVenta           = 14;
     tmVenta                 = 15;

     tmCapturador            = 16;
     tmDevolucionEnvases     = 17;
     tmConsumos              = 18;

     tmRecuperado            = 19;  // Movimiento de líneas huérfanas recuperadas

     // 20..99  Definidos por el usuario

     tmMinimoUsuario         = 20;
     tmMaximoUsuario         = 99;

     tmHojaCarga             = 100;  // Las hojas de carga tienen su propio fichero, pero me conviene identificarlo como un tipo de movimiento
                                     // para los procesos de exportación/importación

     // Origen de un movimiento

     omManual                     = 0;
     omVentaPeriodica             = 1;
     omCapturador                 = 2;
     omPreventa                   = 3;
     omHojaCarga                  = 4;
     omDocumentoControlMercancias = 5;
     omTiendaVirtual              = 6;
     omAprovisionamiento          = 7;
     omFacturaElectronica         = 8;

     // Estados de un pedido

     epPendiente             = 0;
     epParcialmenteProcesado = 1;   // Recibido o servido
     epProcesado             = 2;

     // Estados de un presupuesto

     eprPendiente            = 0;
     eprAceptado             = 1;
     eprCancelado            = 2;

     // Estados de un albarán

     epaPendiente            = 0;
     epaEnviado              = 1;

     // Metodo de asignacion del documento origen

     aomExportacion          = 0;   // Valor por defecto
     aomNumeroSerie          = 1;
     aomLote                 = 2;
     aomListaMateriales      = 3;

     ValorMaximoNroDocumento = 99999999;  // 8 dígitos

     TextoTipoMovimiento : array[ tmInventario..tmRecuperado ] of string = ( 'Inventario',
                                                                             'Reubicación',
                                                                             'Dispuesto para fabricac.',
                                                                             'Entrada en almacén',
                                                                             'Salida de almacén',
                                                                             'Fabricación',
                                                                             'Regularización',
                                                                             'Despiece',
                                                                             'Fabricación defectuosa',

                                                                             'Oferta',
                                                                             'Pedido de compra',
                                                                             'Compra',
                                                                             'Presupuesto',
                                                                             'Pedido de venta',
                                                                             'Venta',
                                                                             'Capturador',
                                                                             'Devolución de envases',
                                                                             'Consumos',
                                                                             'Recuperado' );

     // Tipos de relaciones de documentos

     trdListaMateriales = 0;
     //..
     trdLineaMovimiento = 3;

type   TTipoMovimiento = tmNoDefinido..tmHojaCarga;
       TTipoMovimientoCompra = tmOferta..tmCompra;
       TTipoMovimientoVenta = tmPresupuesto..tmVenta;
       TTipoMovimientoCompraVenta = tmOferta..tmVenta;
       TTiposMovimiento = set of TTipoMovimiento;
       TTiposMovimientoCompra = set of TTipoMovimientoCompra;
       TTiposMovimientoVenta = set of TTipoMovimientoVenta;
       TSeleccionDocumento = ( sdTodos, sdPendientes, sdProcesados );
       TSituacionPedido = epPendiente..epProcesado;
       TEstadoPresupuesto = eprPendiente..eprCancelado;
       TTipoRelacionDocumentos = trdListaMateriales..trdLineaMovimiento;

       TPageOperation = ( poFirst, poPrior, poNext, poLast );

       TEstadoPedido = record
        Situacion : TSituacionPedido;
        Procesada : Boolean;
        end;

     IMovimientoService = interface( ISessionModule )
       ['{2E3FFF33-597D-4818-ADCE-806A7C921B99}']

       procedure ActualizaMovimiento( Movimiento : IMovimiento );
       function SuprimeMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion: LongInt ) : Boolean; overload;

       function SuprimeMovimiento( Ejercicio : SmallInt; NroOperacion: LongInt; PreservaCabecera : Boolean = False ) : Boolean; overload;  // No es una supresión de edición

       procedure ActualizaLineaMovimiento( RemoteCursorID : TnxCursorID; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String; LineaMovimiento : ILineaMovimiento; CompruebaVinculos : Boolean = True );
       procedure SuprimeLineaMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String );

       procedure DesplazaLineaMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; HaciaArriba  : Boolean = False; HastaElFinal : Boolean = False );
       function ExportaDocumento( MovimientoOrigen : IMovimiento; TipoMovimientoDestino : TTipoMovimiento; CodigoPropietario, Serie : String; NroDocumento : LongInt; const LineList : TLongIntArray = nil; SoloCantidadesPendientes : Boolean = False; DocumentoAutomatico : Boolean = False; CopiarDatosCabecera : Boolean = False ) : IMovimiento;
       procedure InsertaLineasDocumento( MovimientoOrigen, MovimientoDestino : IMovimiento; const LineList : TLongIntArray; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False );
       function  CopiaMovimiento( EjercicioOrigen : SmallInt; NroOperacionOrigen : LongInt; TipoMovimientoDestino : TTipoMovimiento; PropietarioDestino : String; SerieDestino : String; ModificarAlmacen : Boolean; AlmacenDestino : String = ''; AsignarUbicaciones : Boolean = False; InvertirCantidades : Boolean = False; BorrarMovimientoOrigen : Boolean = False; ActualizarPrecios : Boolean = False; NroDocumentoDestino : LongInt = 0   ) : LongInt;

       function DarLineaPorProcesada( NroOperacion : LongInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String; NroPagina, NroLinea : SmallInt ) : Decimal;
       function EntregasACuentaPedidosOrigen( Ejercicio : SmallInt; NroOperacion : LongInt; Serie : String; NroFactura : LongInt ) : Decimal;
       function CambiaSituacionPedido( NroOperacion : LongInt; Procesado : Boolean ) : Decimal;

       function GeneraPedidoCompra( Serie : String; CodigoProveedor : String; Fecha : TDate; const LineList : TLongIntArray ) : LongInt;
       function VincularAlbaranAPedido( NroOperacionAlbaran : LongInt; NroPagina : SmallInt; EjercicioPedido : SmallInt; NroOperacionPedido : LongInt ) : Boolean;
       function SuprimeVinculosConPedidos( NroOperacion : LongInt; NroPagina : SmallInt ) : Boolean;

       function ProximaOperacion( Ejercicio : SmallInt = 0 ) : LongInt;
       function ProximoDocumento( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Propietario, Serie : String; RegistrarValor : Boolean = True ) : LongInt;

       procedure ImportaDatosCapturador( Movimiento : IMovimiento; ContenidoFichero : String; NroPaginaActual, UltimoNroLinea : SmallInt; CodigoAlmacenDestino : String );

       function ObtenCosteUltimaEntradaPorLote(     Fecha             : TDate;
                                                    CodigoArticulo,
                                                    CodigoClaseA,
                                                    CodigoClaseB,
                                                    CodigoClaseC,
                                                    LoteFabricacion   : String;
                                                    NroRegistroLinea  : LongInt;
                                                out Precio            : Decimal;
                                                out NroRegistroOrigen : LongInt ) : Boolean;

       procedure ActivaHojasDePedido;
       end;

resourceString

       SeleccioneLasLineasHintMsg = 'Seleccione las líneas que desee incluir utilizando el ratón (doble click) o\npulsando la barra espaciadora sobre la línea en cuestión.';
       AccedaAlDocumentoHintMsg = 'Acceda al documento utilizando el ratón (doble click) o\npulsando la barra espaciadora sobre la línea en cuestión.';

implementation

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IMovimientoService ) );

end.


