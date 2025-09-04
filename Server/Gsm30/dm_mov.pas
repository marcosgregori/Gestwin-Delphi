unit dm_mov;

interface

uses
  Windows, Messages, Classes,

  DB,
  nxdb,
  nxsdTypes,

  sgcJSON,

  LibUtils,
  DataManager,
  ServerDataModule,
  BaseSessionData,
  SessionIntf,

  dmi_mov,

  Gim10Fields,
  Gim30Fields,

  MovimientoIntf,
  LineaMovimientoIntf,

  Spring;

type

   TMovimientoService = class( TSessionModule, IMovimientoService )

    protected

    procedure AssignSession( const SessionID : Integer ); override;

    procedure ActualizaMovimiento( Movimiento : IMovimiento );
    function  SuprimeMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion: LongInt ) : Boolean; overload;

    procedure ActualizaLineaMovimiento( RemoteCursorID : TnxCursorID; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String; LineaMovimiento : ILineaMovimiento; CompruebaVinculos : Boolean = True );
    procedure SuprimeLineaMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String );

    procedure DesplazaLineaMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; HaciaArriba  : Boolean = False; HastaElFinal : Boolean = False );
    function SuprimeMovimiento( Ejercicio : SmallInt; NroOperacion: LongInt; PreservaCabecera : Boolean = False ) : Boolean; overload;

    function ExportaDocumento( MovimientoOrigen : IMovimiento; TipoMovimientoDestino : TTipoMovimiento; CodigoPropietario, Serie : String; NroDocumento : LongInt; const LineList : TLongIntArray = nil; SoloCantidadesPendientes : Boolean = False; DocumentoAutomatico : Boolean = False; CopiarDatosCabecera : Boolean = False ) : IMovimiento;
    procedure InsertaLineasDocumento( MovimientoOrigen, MovimientoDestino : IMovimiento; const LineList : TLongIntArray; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False );
    function CopiaMovimiento( EjercicioOrigen : SmallInt; NroOperacionOrigen : LongInt; TipoMovimientoDestino : TTipoMovimiento; PropietarioDestino : String; SerieDestino : String; ModificarAlmacen : Boolean; AlmacenDestino : String = ''; AsignarUbicaciones : Boolean = False; InvertirCantidades : Boolean = False; BorrarMovimientoOrigen : Boolean = False; ActualizarPrecios : Boolean = False; NroDocumentoDestino : LongInt = 0   ) : LongInt;

    function DarLineaPorProcesada( NroOperacion : LongInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String; NroPagina, NroLinea : SmallInt ) : Decimal;
    function EntregasACuentaPedidosOrigen( Ejercicio : SmallInt; NroOperacion : LongInt; Serie : String; NroFactura : LongInt ) : Decimal;
    function CambiaSituacionPedido( NroOperacion : LongInt; Procesado : Boolean ) : Decimal;

    function GeneraPedidoCompra( CodigoProveedor, Serie : String; Fecha : TDate; const LineList : TLongIntArray ) : LongInt;
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

  TMovimientoDatasetEvent = procedure ( MovimientoFields: TMovimientoFields ) of object;
  TLineaMovimientoDeleteEvent = procedure ( MovimientoFields: TMovimientoFields; LineaMovimientoFields: TLineaMovimientoFields ) of object;
  TSumatorioLineaEvent = procedure ( LineaMovimientoFields : TLineaMovimientoFields; Sustraer : Boolean = False; ValoresOriginales : Boolean = False ) of object;
  TActualizaCamposCalculadosLineaVentaEvent = procedure( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields; ClienteFields : TClienteFields; ArticuloFields : TArticuloFields; SerieFacturacionFields : TSerieFacturacionFields; TiposIVAFields : TTiposIVAFields ) of object;

  TMovimientoModule = class(TServerDataModule)
    DmMovimientoAuxTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    DmConsumosClienteTable: TnxeTable;
    GrupoLineaMovimientoAuxTable: TnxeTable;
    DmMovimientoQuery: TnxeQuery;
    ExistenciasLoteQuery: TnxeQuery;
    ExistenciasLoteQueryLoteFabricacion: TWideStringField;
    ExistenciasLoteQueryCodigoAlmacen: TWideStringField;
    ExistenciasLoteQueryUbicacion: TWideStringField;
    DmMovimientoTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoOrigenTable: TnxeTable;
    DmLineaMovimientoOrigenTable: TnxeTable;
    DmGrupoLineaMovimientoOrigenTable: TnxeTable;
    DmFacturaComprasTable: TnxeTable;
    DmMovimientoCheckTable: TnxeTable;
    DeMovimientoTable: TnxeTable;
    DeGrupoLineaMovimientoTable: TnxeTable;
    DeLineaMovimientoTable: TnxeTable;
    DmMovimientoQueryEjercicio: TSmallintField;
    DmMovimientoQueryNroOperacion: TIntegerField;
    DmMovimientoQueryTipoMovimiento: TSmallintField;
    DmMovimientoQueryPropietario: TWideStringField;
    DmMovimientoQuerySerie: TWideStringField;
    DmMovimientoQueryNroDocumento: TIntegerField;
    DmMovimientoQueryUUID: TGuidField;
    DmMovimientoQueryFecha: TDateField;
    DmMovimientoQueryFechaAplicacion: TDateField;
    DmMovimientoQueryFechaEmision: TDateField;
    DmMovimientoQueryFechaAuxiliar: TDateField;
    DmMovimientoQueryGrupoFacturacion: TWideStringField;
    DmMovimientoQueryRegistroAuxiliar: TWideStringField;
    DmMovimientoQueryCodigoVendedor: TWideStringField;
    DmMovimientoQueryCodigoOperario: TWideStringField;
    DmMovimientoQueryCentroCoste: TWideStringField;
    DmMovimientoQueryFormaEnvio: TWideStringField;
    DmMovimientoQueryEjercicioFactura: TSmallintField;
    DmMovimientoQueryPropietarioFactura: TWideStringField;
    DmMovimientoQuerySerieFactura: TWideStringField;
    DmMovimientoQueryNroFactura: TIntegerField;
    DmMovimientoQueryNoFacturar: TBooleanField;
    DmMovimientoQueryFacturado: TBooleanField;
    DmMovimientoQueryTraspasado: TBooleanField;
    DmMovimientoQueryAnulado: TBooleanField;
    DmMovimientoQueryOpcion: TSmallintField;
    DmMovimientoQueryOrigen: TSmallintField;
    DmMovimientoQueryEjercicioOrigen: TSmallintField;
    DmMovimientoQueryNroOperacionOrigen: TIntegerField;
    DmMovimientoQueryNroDocumentoPropietario: TWideStringField;
    DmMovimientoQueryEntregaACuenta: TBCDField;
    DmMovimientoQueryEntregaEfectivo: TBCDField;
    DmMovimientoQueryCodigoTransportista: TWideStringField;
    DmMovimientoQueryIVAIncluido: TBooleanField;
    DmMovimientoQueryPortes: TBCDField;
    DmMovimientoQueryCodigoFormaCobro: TWideStringField;
    DmMovimientoQueryOrganismoPublico: TWideStringField;
    DmMovimientoQuerySituacion: TSmallintField;
    DmMovimientoQueryDescripcionMovimiento: TWideStringField;
    DmMovimientoQueryCampoLibre1: TWideStringField;
    DmMovimientoQueryCampoLibre2: TWideStringField;
    DmMovimientoQueryCampoLibre3: TWideStringField;
    DmMovimientoQueryCampoLibre4: TWideStringField;
    DmMovimientoQueryCampoLibre5: TWideStringField;
    DmMovimientoQueryTipoVentaPeriodica: TSmallintField;
    DmMovimientoQueryCreado: TDateTimeField;
    DmMovimientoQueryRevisado: TBooleanField;
    DmMovimientoQuerySuministrado: TBooleanField;
    DmMovimientoQueryFechaEnvioPorCorreo: TDateField;
    DmMovimientoQueryAnotacion: TnxWideMemoField;
    DmMovimientoQueryFirma: TnxGraphicField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private

    ContadorEjercicio : SmallInt;
    ContadorDocumentoCompras : Boolean;
    ContadorTipoMovimiento : TTipoMovimiento;
    ContadorSerie : String;
    ContadorPropietario : String;
    CodigoContador : String;

    DmMovimientoFields,
    DmMovimientoAuxFields,
    DeMovimientoFields,
    DmMovimientoOrigenFields : TMovimientoFields;
    DmLineaMovimientoFields,
    DmLineaMovimientoAuxFields,
    DeLineaMovimientoFields,
    DmLineaMovimientoOrigenFields : TLineaMovimientoFields;
    DmConsumosClienteFields : TConsumosClienteFields;
    DmGrupoLineaMovimientoFields,
    DeGrupoLineaMovimientoFields,
    DmGrupoLineaMovimientoOrigenFields : TGrupoLineaMovimientoFields;
    DmFacturaComprasFields : TFacturaComprasFields;

    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsClienteFields : TClienteFields;
    DsProveedorFields : TProveedorFields;
    DsArticuloFields : TArticuloFields;
    DsTiposIVAFields : TTiposIVAFields;
    DsContenedorFields : TClaseFields;

    FBeforePostMovimiento : Event< TMovimientoDatasetEvent>;
    FBeforeDeleteMovimiento : Event< TMovimientoDatasetEvent>;
    FBeforeDeleteLineaMovimiento : Event< TLineaMovimientoDeleteEvent>;
    FOnActualizaCamposCalculadosLineaVentaEvent : Event<TActualizaCamposCalculadosLineaVentaEvent>;

    FModuloHojasDePedido : Boolean;

    procedure InicializaContadorDocumento( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Propietario, Serie : String );
    function ExisteRegistroContadorEvent( ValorActual : LongInt ) : Boolean;
    procedure SuprimeReferenciasLinea( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields ); overload;
    procedure SuprimeReferenciasLinea( Ejercicio : SmallInt; NroOperacion : LongInt; TipoMovimiento : TTipoMovimiento; LineaMovimientoFields : TLineaMovimientoFields ); overload;

  protected

    // Las funciones de edición están en la sección protected para que no puedan ser accedidas desde otro módulo por error
    // Las versiones accesibles están en la sección public

    procedure ActualizaMovimiento( Movimiento : IMovimiento );
    function SuprimeMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion: LongInt ) : Boolean; overload;

    procedure ActualizaLineaMovimiento( RemoteCursorID : TnxCursorID; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String; LineaMovimiento : ILineaMovimiento; CompruebaVinculos : Boolean = True );
    procedure SuprimeLineaMovimiento( RemoteCursorID : TnxCursorID; Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String ); overload;

    // procedure DesplazaPaginaMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina : SmallInt; HaciaArriba : Boolean = False; HastaElFinal : Boolean = False );

    procedure DesplazaLineaMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; HaciaArriba  : Boolean = False; HastaElFinal : Boolean = False );

    procedure ActualizaEstadoPedido( Procesado : Boolean; Situacion : TSmallIntField; CantidadPedido, CantidadProcesada : Decimal );
    procedure ActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                                   ClienteFields          : TClienteFields;
                                                   ArticuloFields         : TArticuloFields;
                                                   SerieFacturacionFields : TSerieFacturacionFields;
                                                   TiposIVAFields         : TTiposIVAFields );

  public

    function ProximaOperacion( Ejercicio : SmallInt = 0 ) : LongInt;
    function ProximoDocumento( MovimientoFields : TMovimientoFields; RegistrarValor   : Boolean = True ) : LongInt; overload;
    function ProximoDocumento( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Propietario, Serie : String; RegistrarValor : Boolean = True ) : LongInt; overload;
    procedure RetiraDocumento( MovimientoFields : TMovimientoFields; CompruebaEstado : Boolean = True );
    // function ExisteDocumentoContador( MovimientoFields : TMovimientoFields ) : Boolean;

    function Obten( TipoMovimiento : TTipoMovimiento; Ejercicio : Word; CodigoPropietario, Serie : String; NroDocumento : LongWord; MovimientoFields : TMovimientoFields ) : Boolean;
    function ObtenPorUUID( UUID : String; MovimientoFields : TMovimientoFields ) : Boolean;

    function SuprimeMovimiento( Ejercicio : SmallInt; NroOperacion: LongInt; PreservaCabecera : Boolean = False ) : Boolean; overload;
    procedure SuprimeLineaMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina, NroLinea : SmallInt; TipoMovimiento : TTipoMovimiento; Serie, Propietario : String ); overload;
    procedure SuprimeLineasMovimiento( MovimientoFields : TMovimientoFields );
    procedure AnulaLineasMovimiento( MovimientoFields : TMovimientoFields );

    function ExisteNroDocumento( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Propietario : String; Serie : String; NroDocumento : LongInt ) : Boolean;
    procedure CompruebaPrimerNroPagina( MovimientoFields : TMovimientoFields );
    function NumeroReferenciasLinea( LineaMovimientoFields : TLineaMovimientoFields ) : SmallInt;
    procedure LimpiaImportesLinea( LineaMovimientoFields: TLineaMovimientoFields);
    function ObtenFechaAplicacion( TipoMovimiento : TTipoMovimiento; FechaAplicacionMovimiento : TDate; FechaAplicacionLinea : Variant ) : TDate;
    function ObtenEnvaseLinea( LineaMovimientoFields : TLineaMovimientoFields; EnvaseFields : TClaseFields ) : Boolean;
    function ObtenContenedorLinea( LineaMovimientoFields : TLineaMovimientoFields; ContenedorFields : TClaseFields ) : Boolean;

    procedure RecalculaMovimiento( MovimientoFields : TMovimientoFields );

    function ActualizaSituacionPedido( Ejercicio    : SmallInt = 0;
                                       NroOperacion : LongInt = 0 ) : Boolean;

    function RegularizaLineaPedido( MovimientoFields      : TMovimientoFields;
                                    LineaMovimientoFields : TLineaMovimientoFields;
                                    Sustraer              : Boolean = False;
                                    ActualizaSituacion    : Boolean = True ) : Boolean; overload;

    function RegularizaLineaPedido( TipoMovimiento        : TTipoMovimiento;
                                    Serie,
                                    Propietario           : String;
                                    LineaMovimientoFields : TLineaMovimientoFields;
                                    Sustraer              : Boolean = False;
                                    ActualizaSituacion    : Boolean = True ) : Boolean; overload;

    function DarLineaPorProcesada( NroOperacion   : LongInt;
                                   TipoMovimiento : TTipoMovimiento;
                                   Serie,
                                   Propietario    : String;
                                   NroPagina,
                                   NroLinea         : SmallInt ): Decimal;

    function ObtenUltimoNroLinea( Ejercicio    : SmallInt;
                                  NroOperacion : LongInt;
                                  NroPagina    : SmallInt ) : SmallInt;

    function ObtenNroPagina( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
                             OperacionPagina            : TPageOperation ) : SmallInt;

    function  CopiaLineasMovimiento(        MovimientoOrigen          : IMovimiento;
                                            MovimientoDestinoFields   : TMovimientoFields;
                                      const LineList                  : TLongIntArray;
                                            NoVincularDocumentos      : Boolean = False;
                                            ActualizarSituacionPedido : Boolean = True ) : Boolean;

    procedure  InsertaLineasDocumento(       MovimientoOrigen,
                                             MovimientoDestino    : IMovimiento;
                                       const LineList             : TLongIntArray;
                                             CopiarDatosCabecera  : Boolean = False;
                                             NoVincularDocumentos : Boolean = False );

    procedure InsertaVinculosCliente( MovimientoFields : TMovimientoFields;
                                      ClienteFields    : TClienteFields );

    function CopiaMovimiento( EjercicioOrigen        : SmallInt;
                              NroOperacionOrigen     : LongInt;
                              TipoMovimientoDestino  : TTipoMovimiento;
                              PropietarioDestino     : String;
                              SerieDestino           : String;
                              ModificarAlmacen       : Boolean;
                              AlmacenDestino         : String = '';
                              AsignarUbicaciones     : Boolean = False;
                              InvertirCantidades     : Boolean = False;
                              BorrarMovimientoOrigen : Boolean = False;
                              ActualizarPrecios      : Boolean = False;
                              NroDocumentoDestino    : LongInt = 0 ) : LongInt;

    procedure ActivaHojasDePedido;

    procedure ImportaDatosCapturador( Movimiento           : IMovimiento;
                                      ContenidoFichero     : String;
                                      NroPaginaActual,
                                      UltimoNroLinea       : SmallInt;
                                      CodigoAlmacenDestino : String );

    function ObtenImporteMovimiento(     Ejercicio : SmallInt;
                                         NroOperacion : LongInt;
                                     var ImporteBruto : Decimal;
                                     var DescuentosArticulo : Decimal;
                                     var ImporteNeto : Decimal ) : Boolean; overload;

    procedure CalculaImporteMovimiento(     MovimientoFields   : TMovimientoFields;
                                        var ImporteBruto       : Decimal;
                                        var DescuentosArticulo : Decimal;
                                        var ImporteNeto        : Decimal;
                                            OnSumatorioLinea   : TSumatorioLineaEvent = nil );

    function ObtenImporteMovimiento(     TipoMovimiento     : TTipoMovimiento;
                                         Ejercicio          : SmallInt;
                                         Serie              : String;
                                         NroDocumento       : LongInt;
                                     var ImporteBruto       : Decimal;
                                     var DescuentosArticulo : Decimal;
                                     var ImporteNeto        : Decimal ) : Boolean; overload;

    function EntregasACuentaPedidosOrigen( Ejercicio    : SmallInt;
                                           NroOperacion : LongInt;
                                           Serie        : String;
                                           NroFactura   : LongInt ) : Decimal;

    function CambiaSituacionPedido( NroOperacion : LongInt;
                                    Procesado    : Boolean ) : Decimal;

    function ExportaDocumento(       MovimientoOrigen         : IMovimiento;
                                     TipoMovimientoDestino    : TTipoMovimiento;
                                     CodigoPropietario,
                                     Serie                    : String;
                                     NroDocumento             : LongInt;
                               const LineList                 : TLongIntArray = nil;
                                     SoloCantidadesPendientes : Boolean = False;
                                     DocumentoAutomatico      : Boolean = False;
                                     CopiarDatosCabecera      : Boolean = False ) : IMovimiento;

    function GeneraPedidoCompra(       CodigoProveedor,
                                       Serie            : String;
                                       Fecha            : TDate;
                                 const LineList         : TLongIntArray ) : LongInt;

    function VincularAlbaranAPedido( NroOperacionAlbaran : LongInt;
                                     NroPagina           : SmallInt;
                                     EjercicioPedido     : SmallInt;
                                     NroOperacionPedido  : LongInt ) : Boolean;

    function SuprimeVinculosConPedidos( NroOperacion : LongInt;
                                        NroPagina    : SmallInt ) : Boolean;

    function ExisteMovimientoArticulo( TipoMovimiento  : TTipoMovimiento; CodigoArticulo : String; FechaInicial, FechaFinal : TDateTime ) : Boolean;

    procedure ObtenCosteUltimaEntradaPorLote( LineaMovimientoFields : TLineaMovimientoFields ); overload;

    function ObtenCosteUltimaEntradaPorLote(     Fecha             : TDate;
                                                 CodigoArticulo,
                                                 CodigoClaseA,
                                                 CodigoClaseB,
                                                 CodigoClaseC,
                                                 LoteFabricacion   : String;
                                                 NroRegistroLinea  : LongInt;
                                             out Precio            : Decimal;
                                             out NroRegistroOrigen : LongInt ) : Boolean; overload;

    function CalculoEspecial( Seccion  : TSeccionComercial;
                              Largo,
                              Ancho,
                              Alto     : Decimal ) : Decimal;

    // WebService

    class function CreaPedidoTiendaWs( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ) : Boolean;
    class function ObtenPedidosTiendaWs( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ): Boolean;
    class function ObtenDetallePedidoTiendaWs( SessionDataModule : TBaseSessionDataModule; DataIn, DataOut : IsgcJSON ): Boolean;

    function CreaPedidoTienda( DataIn, DataOut : IsgcJSON ) : Boolean;
    function ObtenPedidosTienda( DataIn, DataOut : IsgcJSON ) : Boolean;
    function ObtenDetallePedidoTienda( DataIn, DataOut : IsgcJSON ) : Boolean;
    function EstadoPedidoTienda( Situacion : SmallInt ) : String;

    property ModuloHojasDePedido : Boolean read FModuloHojasDePedido;

    property BeforePostMovimiento : Event<TMovimientoDatasetEvent> read FBeforePostMovimiento write FBeforePostMovimiento;
    property BeforeDeleteMovimiento : Event<TMovimientoDatasetEvent> read FBeforeDeleteMovimiento write FBeforeDeleteMovimiento;
    property BeforeDeleteLineaMovimiento : Event<TLineaMovimientoDeleteEvent> read FBeforeDeleteLineaMovimiento write FBeforeDeleteLineaMovimiento;
    property OnActualizaCamposCalculadosLineaVenta : Event<TActualizaCamposCalculadosLineaVentaEvent> read FOnActualizaCamposCalculadosLineaVentaEvent write FOnActualizaCamposCalculadosLineaVentaEvent;

  end;

  function ObtenTextoTipoMovimiento( TipoMovimiento : TTipoMovimiento;
                                     Plural         : Boolean = True;
                                     Capitalizar    : Boolean = False ) : String;

resourceString
     RsImpresion = 'Impresión de %s.';

     RsInventario = 'inventario%s';
     RsEntrada= 'entrada%s';
     RsSalida = 'salida%s';
     RsFabricacion = 'fabricacion%s';
     RsReubicaciones = 'reubicacion%s por carga';
     RsRegularizacion= 'regularizacion%s';
     RsDespiece = 'despiece%s';
     RsOfertas  = 'oferta%s';
     RsPresupuestos = 'presupuesto%s';
     RsPedidosCompra  = 'pedido%s de compra';
     RsAlbaranesCompra  = 'albaran%s de compra';
     RsPedidosVenta  = 'pedido%s de venta';
     RsAlbaranesVenta = 'albaran%s de venta';
     RsDesconocido = 'desconocido%s';

     RsTituloOferta = 'OFERTA';
     RsTituloPedidoCompra = 'PEDIDO DE COMPRA';
     RsTituloAlbaranCompra = 'ALBARAN DE COMPRA';
     RsTituloPresupuesto = 'PRESUPUESTO';
     RsTituloPedidoVenta = 'PEDIDO DE VENTA';
     RsTituloAlbaranventa = 'ALBARAN DE VENTA';

     RsMsgSituacionOfertas       = '"<Todas>","Pendientes de revisión","Revisadas"';
     RsMsgSituacionPresupuestos  = '"<Todos>","Pendientes","Aceptados","Cancelados"';
     RsMsgSituacionPedidosCompra = '"<Todos>","Pendientes de recibir (totalmente)","Pendientes de recibir (total o parcialmente)","Parcialmente recibidos","Totalmente recibidos"';
     RsMsgSituacionPedidosVenta  = '"<Todos>","Pendientes de servir (totalmente)","Pendientes de servir (total o parcialmente)","Parcialmente servidos","Totalmente servidos"';
     RsMsgSituacionAlbaranes     = '"<Todos>","No facturables","Facturables","Pendientes de facturar (todos)","Pendientes de facturar (facturables)","Facturados","Pendientes de contabilizar","Contabilizados"';
     RsMsgSituacionAlbaranesB    = '"<Todos>","No facturables","Pendientes de facturar"';

     RsIndiceDocumentoExiste = 'Ya existe un documento con el nº %s %d';
     RsActiveContadores = 'Si está utilizando el mantenimiento de documentos de venta desde varios puestos de trabajo es conveniente que active los contadores en la configuración de la aplicación para evitar este tipo de conflictos.';

type

     TSituacionOfertas       = ( sofTodas = 0, sofPendientesRevision = 1, sofRevisadas = 2 );
     TSituacionPresupuestos  = ( sprTodos = 0, sprPendientes = 1, sprAceptados = 2, sprCancelados = 3 );
     TSituacionPedidos       = ( speTodos = 0, spePendienteProcesarCompleto = 1, spePendienteProcesar = 2, speParcialmenteProcesados = 3, speProcesados = 4 );
     TSituacionAlbaranes     = ( saaTodos = 0, saaNoFacturables = 1, saaFacturables = 2, saaPendientesFacturar = 3, saaPendientesFacturarFacturables = 4, saaFacturados = 5, saaPendientesContabilizar = 6, saaContabilizados = 7 );
     TSituacionAlbaranesB    = ( sabTodos = 0, sabNoFacturables = 1, sabPendientesFacturar = 2 );

implementation

{%CLASSGROUP 'VCL.Controls.TControl'}

uses Variants,
     System.Generics.Defaults,
     System.Generics.Collections,
     SysUtils,
     DateUtils,
     ServerUtils,

     nxdbBase,
     nxrdClass,
     nxrbTypes,
     nxllTypes,
     nxllBDE,
     nxsrServerEngine,

     AppManager,
     EnterpriseData,
     BaseServerContainer,
     ServerContainer,
     SessionData,

     dmi_cls,
     dmi_art,
     dmi_cnd,

     dm_art,
     dm_cnd,
     dm_pga,
     dm_pro,
     dm_cli,
     dm_sdf,
     dm_fde,

     dm_cls;

{$R *.DFM}

type  TIDMovimiento = class
      public
        FEjercicio : SmallInt;
        FNroOperacion : LongInt;

        constructor Create( Ejercicio : SmallInt; NroOperacion : LongInt );
        end;

resourceString
     RsMsg1  = 'Este movimiento no puede ser suprimido porque ha sido facturado.';
     RsMsg2  = 'No existe ningún artículo de código [%s].';
     RsMsg3  = 'Ha ocurrido un error durante el proceso de importación de datos %s.';
     RsMsg4  = 'Compruebe que el fichero esté en el directorio adecuado y en buen estado.';
     RsMsg5  = 'La estructura del fichero de datos del capturado es incorrecta.';
     RsMsg6  = 'La fecha de los datos que pretende importar no coincide con la del documento actual.';
     RsMsg7  = 'No será importado.'#13'¿Continúo con el proceso de importación?';
     RsMsg8  = 'Parcialmente %s';
     RsMsg9  = 'Totalmente %s';
     RsMsg10 = 'recibido';
     RsMsg11 = 'servido';
     RsMsg12 = 'Operación nº %d.';
     RsMsg13 = ' Facturado (Factura nº %d).';
     RsMsg14 = ' Contabilizado.';
     RsMsg15 = 'No existe ningún documento con esta serie y número.';
     RsMsg16 = 'Utilice la consulta en línea (tecla [F4]) para ver los documentos existentes.';
     RsMsg17 = 'No se ha podido guardar la fecha de emisión del documento %s %d (propietario %s).';
     RsMsg18 = 'La fecha de emisión no ha podido ser guardada porque otro usuario está editando el registro en este momento.'#13'El proceso de impresión continúa.';
     RsMsg19 = '¿Esta seguro de que desea suprimir la referencia al documento origen de esta línea?';
     RsMsg20 = 'Al suprimir el número de serie o el lote del producto se perderá la referencia al documento origen que estaba guardada en la línea.';
     RsMsg21 = '¿Esta seguro de que desea modificar la referencia al documento origen de esta línea?';
     RsMsg22 = 'Al cambiar el número de serie o el lote del producto se sustituirá la referencia al documento origen que estaba guardada en la línea por el nuevo.';
     RsMsg23 = 'Pendiente';
     RsMsg24 = ' No facturable.';
     RsMsg25 = 'Ya existe un documento con este mismo número.';
     RsMsg26 = 'Cuando se introducen los números de documento de forma manual existe la posibilidad de que otro usuario asigne el mismo número al mismo tiempo.'#13'Active los [B]contadores automáticos[/B] para solventar los problemas de concurrencia.';
     RsMsg27 = 'Ha ocurrido un error durante el proceso de generación del documento. No ha podido ser creado.';
     RsMsg28 = 'La cantidad supera a la unidades totales solicitadas en el pedido.';
     RsMsg29 = 'No puede incluir en esta línea una cantidad mayor de la que hay pendiente en el pedido.'#13'Cree una línea adicional para reflejar la entrada o salida de más unidades.';
     RsMsg33 = 'El pedido origen de esta línea ha sido incluido en más de un albaran.';
     RsMsg34 = 'No puede modificar las clases del artículo de una línea que también ha sido incluido en otros albaranes.';
     RsMsg35 = 'El documento está siendo editado por otro usuario.';
     RsMsg36 = 'Espere a que sea liberado y reintente la operación.';
     RsMsg37 = 'No se ha podido recuperar la cabecera del pedido con nº de operación %d.';
     RsMsg38 = 'Ha ocurrido un error durante el proceso de recálculo del documento. No ha podido ser actualizado.';
     RsMsg39 = 'No se ha podido recuperar la cabecera del movimiento nº %d.';
     RsMsg40 = 'Este pedido ya ha sido completamente %s.';
     RsMsg41 = 'Ya existe un movimiento con el mismo número de documento o de operación.';
     RsMsg42 = 'Si está utilizando la aplicación en un entorno multi-usuario, compruebe si tiene activados los contadores y su estado.';
     RsMsg43 = 'No puede exportar un documento anulado.';
     RsMsg44 = 'No se ha creado ningún documento.';
     RsMsg45 = 'Ha ocurrido un error durante el proceso de generación del documento. No ha podido ser creado.';
     RsMsg46 = 'No puede dar por servida la línea.';
     RsMsg47 = 'Está activada la opción "Regularizar las cantidades solicitadas de los pedidos al marcarlos como servidos" en la configuración y la línea no ha sido parcialmente entregada.';
     RsMsg48 = 'No se ha copiado ninguna línea.';
     RsMsg49 = 'Ninguna linea cumple las condiciones necesarias para ser copiada y no se ha creado ningún registro.';
     RsMsg50 = 'No se ha podido actualizar el registro.';

     RsVentaPeriodica = 'PERIODICO';
     RsCapturador = 'CAPTURADOR';
     RsPreventa = 'PREVENTA';
     RsHojaCarga = 'CARGA';
     RsDocumentoControlMercancias = 'D.C.M.';
     RsTiendaVirtual              = 'TIENDA';

// Funciones

function ObtenTextoTipoMovimiento( TipoMovimiento : TTipoMovimiento;
                                   Plural         : Boolean = True;
                                   Capitalizar    : Boolean = False ) : String;

var  TextoPlural : String;

begin
     case TipoMovimiento of
       tmInventario        : Result := RsInventario;
       tmReubicacionCarga  : Result := RsReubicaciones;
       tmEntrada           : Result := RsEntrada;
       tmSalida            : Result := RsSalida;
       tmFabricacion       : Result := RsFabricacion;
       tmRegularizacion    : Result := RsRegularizacion;
       tmDespiece          : Result := RsDespiece;
       tmOferta            : Result := RsOfertas;
       tmPresupuesto       : Result := RsPresupuestos;
       tmPedidoCompra      : Result := RsPedidosCompra;
       tmPedidoVenta       : Result := RsPedidosVenta;
       tmCompra            : Result := RsAlbaranesCompra;
       tmVenta             : Result := RsAlbaranesVenta;
       else                  Result := RsDesconocido;
       end;
     If   Plural
     then begin
          If   TipoMovimiento in [ tmFabricacion, tmReubicacionCarga, tmRegularizacion, tmDespiece, tmCompra, tmVenta ]
          then TextoPlural := 'es'
          else TextoPlural := 's';
          end
     else TextoPlural := '';
     Result := Format( Result, [ TextoPlural ] );
     If   Capitalizar and ( Result<>'' )
     then Result[ 1 ] := UpCase( Result[ 1 ] );
end;

// TMovimientoModule

procedure TMovimientoModule.DataModuleCreate(Sender: TObject);
begin
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );  // El índice cambia. Debe fijarse cada vez que se utilice la tabla
     DmMovimientoOrigenFields := TMovimientoFields.Create( DmMovimientoOrigenTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoAuxFields := TLineaMovimientoFields.Create( DmLineaMovimientoAuxTable ); // El índice cambia
     DmLineaMovimientoOrigenFields := TLineaMovimientoFields.Create( DmLineaMovimientoOrigenTable ); // El índice cambia
     DmConsumosClienteFields := TConsumosClienteFields.Create( DmConsumosClienteTable );
     DmGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoTable ); // El índice cambia
     DmGrupoLineaMovimientoOrigenFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoOrigenTable );
     DmFacturaComprasFields := TFacturaComprasFields.Create( DmFacturaComprasTable );

     DeMovimientoFields := TMovimientoFields.Create( DeMovimientoTable );
     DeLineaMovimientoFields := TLineaMovimientoFields.Create( DeLineaMovimientoTable );
     DeGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DeGrupoLineaMovimientoTable );

     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsClienteFields := TClienteFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsContenedorFields := TClaseFields.Create( Self );

     // Ajustes para el desplazamiento de líneas

     DmLineaMovimientoTable.AutoIncFieldName := 'NroLinea';
     With DmLineaMovimientoFields.NroLinea do
       begin
       MinValue := 1;
       MaxValue := MaxSmallInt;
       end;

end;

procedure TMovimientoModule.DataModuleDestroy(Sender: TObject);
begin
     SessionDataModule.Dm30.MovimientoModule := nil
end;

function TMovimientoModule.ProximaOperacion( Ejercicio : SmallInt = 0 ) : LongInt;

var  ResetCounter : Boolean;
     ValorActual : LongInt;
     Count : SmallInt;

begin

     ValorActual := 0;
     Count := 0;
     ResetCounter := False;

     If   Ejercicio=0
     then Ejercicio := SessionDataModule.Ejercicio;

     With DmMovimientoAuxTable do
       begin

       IndexFieldNames := 'Ejercicio;NroOperacion';

       repeat

         If   SessionDataModule.Dm00.ContadoresModule.CompruebaContador( cnMovimientoOperacion ) or ResetCounter
         then If   FindEqualLast( [ Ejercicio ] )
              then ValorActual := DmMovimientoAuxFields.NroOperacion.Value + 1
              else ValorActual := 1;

         ValorActual := SessionDataModule.Dm00.ContadoresModule.Incrementa( cnMovimientoOperacion, Ejercicio, '', ValorActual, 1 );
         ResetCounter := FindKey( [ Ejercicio, ValorActual ] );

         Inc( Count );

       until not ResetCounter or ( Count=10 );

       end;

     Result := ValorActual;
end;

{
function TMovimientoModule.ExisteDocumentoContador( MovimientoFields : TMovimientoFields ) : Boolean;
begin
     InicializaContadorDocumento( MovimientoFields );
     Result := SessionDataModule.Dm00.ContadoresModule.ExisteValor( cnMovimientoDocumento, MovimientoFields.Ejercicio.Value, CodigoContador, MovimientoFields.NroDocumento.Value );
end;
}

procedure TMovimientoModule.InicializaContadorDocumento( TipoMovimiento   : TTipoMovimiento;
                                                         Ejercicio        : SmallInt;
                                                         Propietario,
                                                         Serie            : String );
begin

     ContadorDocumentoCompras := TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ];
     ContadorTipoMovimiento := TipoMovimiento;
     ContadorSerie := Serie;
     ContadorPropietario := Propietario;

     With DmMovimientoAuxTable do
       If   ContadorDocumentoCompras
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            CodigoContador := Serie + Propietario;
            end
       else begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            CodigoContador := Serie;
            end;

end;

function TMovimientoModule.ProximoDocumento( MovimientoFields : TMovimientoFields;
                                             RegistrarValor   : Boolean = True ) : LongInt;
begin
     With MovimientoFields do
       Result := ProximoDocumento( TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, RegistrarValor );
end;

function TMovimientoModule.ProximoDocumento( TipoMovimiento   : TTipoMovimiento;
                                             Ejercicio        : SmallInt;
                                             Propietario,
                                             Serie            : String;
                                             RegistrarValor   : Boolean = True ) : LongInt;

var  ValorActual : LongInt;
     RecordFound,
     ExisteContador : Boolean;

begin

     ValorActual := 0;

     // En la función InicializaContadorDocumento se fija el índice de la tabla DmMovimientoAuxTable

     InicializaContadorDocumento( TipoMovimiento, Ejercicio, Propietario, Serie );

     With DmMovimientoAuxTable do
       If   ContadorDocumentoCompras
       then RecordFound := FindEqualLast( [ TipoMovimiento, Ejercicio, Propietario, Serie ] )
       else RecordFound := FindEqualLast( [ TipoMovimiento, Ejercicio, Serie ] );

       If   RecordFound
       then ValorActual := DmMovimientoAuxFields.NroDocumento.Value + 1
       else ValorActual := 1;

       ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ExisteRegistroContadorEvent, cnMovimientoDocumento, Ejercicio, CodigoContador, ValorActual, 1 );
       If   not RegistrarValor
       then SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnMovimientoDocumento, Ejercicio, CodigoContador, ValorActual );

     SessionDataModule.Dm00.ContadoresModule.CompruebaValorMaximo( ValorActual );

     Result := ValorActual;

end;

function TMovimientoModule.ExisteRegistroContadorEvent( ValorActual : LongInt ) : Boolean;
begin
     With DmMovimientoAuxTable do
       If   ContadorDocumentoCompras
       then Result := FindKey( [ ContadorTipoMovimiento, ContadorEjercicio, ContadorPropietario, ContadorSerie, ValorActual ] )
       else Result := FindKey( [ ContadorTipoMovimiento, ContadorEjercicio, ContadorSerie, ValorActual ] );
end;

procedure TMovimientoModule.RetiraDocumento( MovimientoFields : TMovimientoFields;
                                             CompruebaEstado  : Boolean = True );
begin
     If   Assigned( MovimientoFields )
     then With MovimientoFields do
            If   Dataset is TnxeTable
            then With Table do
                   If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                   then begin
                        CodigoContador := Serie.Value;
                        If   TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]   // Movimiento de compras
                        then StrAdd( CodigoContador, Propietario.Value );
                        SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnMovimientoDocumento, Ejercicio.Value, CodigoContador, NroDocumento.Value );
                        end;
end;

function TMovimientoModule.Obten( TipoMovimiento      : TTipoMovimiento;
                                  Ejercicio           : Word;
                                  CodigoPropietario,
                                  Serie               : String;
                                  NroDocumento        : LongWord;
                                  MovimientoFields    : TMovimientoFields ) : Boolean;
begin
     DmMovimientoAuxTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
     Result := DmMovimientoAuxTable.FindKey( [ Ord( TipoMovimiento ), Ejercicio, CodigoPropietario, Serie, NroDocumento] );
     MovimientoFields.Update( DmMovimientoAuxTable );
end;

// Esta función no solo devuelve el contenido del registro en MovimientoFields, sino que posiciona el cursor de su tabla en el registro

function TMovimientoModule.ObtenPorUUID( UUID             : String;
                                         MovimientoFields : TMovimientoFields ) : Boolean;
begin
     DmMovimientoAuxTable.IndexFieldNames := 'UUID';
     Result := DmMovimientoAuxTable.FindKey( [ UUID ] );
     If   Result
     then begin
          If   not ( MovimientoFields.Initialized or MovimientoFields.StaticData )
          then MovimientoFields.Update( DmMovimientoAuxTable )
          else MovimientoFields.Table.GotoCurrent( DmMovimientoAuxTable );
          end
     else MovimientoFields.Clear( DmMovimientoAuxTable );
end;

procedure TMovimientoModule.CompruebaPrimerNroPagina( MovimientoFields : TMovimientoFields );
begin
     DmGrupoLineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';
     If   not DmGrupoLineaMovimientoTable.FindKey( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, 0 ] )
     then begin
          DmGrupoLineaMovimientoTable.Append;

          DmGrupoLineaMovimientoFields.Ejercicio.Value := MovimientoFields.Ejercicio.Value;
          DmGrupoLineaMovimientoFields.NroOperacion.Value := MovimientoFields.NroOperacion.Value;
          DmGrupoLineaMovimientoFields.NroPagina.Value := 0;
          DmGrupoLineaMovimientoFields.Descripcion.Value := 'Página 1';

          DmGrupoLineaMovimientoTable.Post;
          end;
end;

function TMovimientoModule.ObtenFechaAplicacion( TipoMovimiento            : TTipoMovimiento;
                                                 FechaAplicacionMovimiento : TDate;
                                                 FechaAplicacionLinea      : Variant ) : TDate;
begin
     If   ( ( TipoMovimiento=tmPedidoCompra ) and SessionDataModule.EmpresaFields.Compras_FechaRecepcionPorLinea.Value ) or
          ( ( TipoMovimiento=tmPedidoVenta )  and SessionDataModule.EmpresaFields.Ventas_FechaEntregaPorLinea.Value )
     then begin
          If   VarIsNull( FechaAplicacionLinea )
          then Result := FechaAplicacionMovimiento
          else Result := FechaAplicacionLinea;
          end
     else Result := FechaAplicacionMovimiento;
end;

procedure TMovimientoModule.LimpiaImportesLinea( LineaMovimientoFields : TLineaMovimientoFields );
begin
     With LineaMovimientoFields do
       begin
       Precio.Value := 0.0;
       PrecioDivisa.Value := 0.0;
       Descuento.Value := 0.0;
       ImporteBruto.Value := 0.0;
       ImporteDescuento.Value := 0.0;
       ImporteNeto.Value := 0.0;
       CodigoTipoIVA.Value := 0;
       CuotaIVA.Value := 0.0;
       CuotaRE.Value := 0.0;
       PrecioIVA.Value := 0.0;
       ImporteTotal.Value := 0.0;
       end;
end;

procedure TMovimientoModule.SuprimeLineasMovimiento( MovimientoFields : TMovimientoFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable, DmGrupoLineaMovimientoTable ] );

     try

       With DmLineaMovimientoTable do
         try

           Cancel;

           With MovimientoFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

           First;
           While not Eof do
             begin

             SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, DmLineaMovimientoFields, True );
             If   MovimientoFields.TipoMovimiento.Value=tmVenta
             then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( MovimientoFields.Ejercicio.Value, MovimientoFields.Propietario.Value, -DmLineaMovimientoFields.ImporteNeto.Value );
             SuprimeReferenciasLinea( MovimientoFields, DmLineaMovimientoFields );

             // La mitad de las líneas de los movimientos de reubicación no tienen su origen en un pedido, pero el procedimiento
             // de regularización comprueba si el origen es un pedido o no.

             case MovimientoFields.TipoMovimiento.Value of
               tmCompra,
               tmVenta,
               tmReubicacionCarga : RegularizaLineaPedido( MovimientoFields, DmLineaMovimientoFields, True );
               end;

             FBeforeDeleteLineaMovimiento.Invoke( MovimientoFields, DmLineaMovimientoFields );

             Delete;
             end;
         finally
           CancelRange;
           end;

       With DmGrupoLineaMovimientoTable do
         try
           IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';
           With MovimientoFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt ] );
           DeleteRecords;
         finally
           CancelRange;
         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TMovimientoModule.AnulaLineasMovimiento( MovimientoFields : TMovimientoFields );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable, DmGrupoLineaMovimientoTable ] );

     try

       With DmLineaMovimientoTable do
         try

           Cancel;

           With MovimientoFields do
             SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

           First;
           While not Eof do
             begin

             SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoFields, DmLineaMovimientoFields, True );
             If   MovimientoFields.TipoMovimiento.Value=tmVenta
             then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( MovimientoFields.Ejercicio.Value, MovimientoFields.Propietario.Value, -DmLineaMovimientoFields.ImporteNeto.Value );

             case MovimientoFields.TipoMovimiento.Value of
               tmCompra,
               tmVenta,
               tmReubicacionCarga : RegularizaLineaPedido( MovimientoFields, DmLineaMovimientoFields, True );
               end;

             Next;
             end;

         finally
           CancelRange;
           end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

procedure TMovimientoModule.SuprimeReferenciasLinea( MovimientoFields      : TMovimientoFields;
                                                     LineaMovimientoFields : TLineaMovimientoFields );
begin
     With MovimientoFields do
       SuprimeReferenciasLinea( Ejercicio.Value, NroOperacion.Value, TipoMovimiento.Value, LineaMovimientoFields );
end;

procedure TMovimientoModule.SuprimeReferenciasLinea( Ejercicio             : SmallInt;
                                                     NroOperacion          : LongInt;
                                                     TipoMovimiento        : TTipoMovimiento;
                                                     LineaMovimientoFields : TLineaMovimientoFields );
begin

     // Lineas de movimientos que se han exportado desde ésta

     With DmLineaMovimientoAuxTable do
       begin
       IndexFieldNames := 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen';
       SetRange( [ TipoMovimiento, Ejercicio, NroOperacion ] );
       try
         First;
         While not Eof do
           begin
           If   DmLineaMovimientoAuxFields.NroRegistroOrigen.Value=LineaMovimientoFields.NroRegistro.Value
           then try
                  Edit;

                  DmLineaMovimientoAuxFields.TipoMovimientoOrigen.Clear;
                  DmLineaMovimientoAuxFields.EjercicioOrigen.Clear;
                  DmLineaMovimientoAuxFields.NroOperacionOrigen.Clear;
                  DmLineaMovimientoAuxFields.NroRegistroOrigen.Clear;

                  Post;
                except
                  Cancel;
                  raise;
                end;
           Next;
           end;
       finally
         CancelRange;
         end;
       end;

     // Linea de movimientos que es el origen de ésta

     If   FModuloHojasDePedido and ( TipoMovimiento=tmPedidoCompra )
     then With DmLineaMovimientoAuxTable do
            begin

            IndexFieldNames := 'NroRegistro';

            If   FindKey( [ LineaMovimientoFields.NroRegistroOrigen.Value ] )
            then try
                   DmLineaMovimientoAuxTable.Edit;
                   DmLineaMovimientoAuxFields.Parametros.Value := ResetBit( DmLineaMovimientoAuxFields.Parametros.Value, 0 );  // Quito la marca de exportado a pedido de compra
                   DmLineaMovimientoAuxTable.Post;
                 except
                   Cancel;
                   raise;
                   end;

            end;

end;

procedure TMovimientoModule.ActualizaMovimiento( Movimiento : IMovimiento );

var  TableCursor : TnxServerTableCursor;

begin


     If   TnxServerTableCursor.LookupByID( Movimiento.RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DeGrupoLineaMovimientoTable,
                                                                          DeLineaMovimientoTable ] );

          try

            If   Movimiento.State=dsEdit
            then begin
                 If   DeMovimientoTable.FindKey( [ Movimiento.Ejercicio, Movimiento.NroOperacion ] )
                 then begin
                      TableCursor.RecordLockRelease( False );
                      If   ( Movimiento.Fecha<>DeMovimientoFields.Fecha.Value ) or
                           ( ( Movimiento.TipoMovimiento=tmPedidoCompra ) and( Movimiento.FechaAplicacion<>DeMovimientoFields.FechaAplicacion.Value ) and not SessionDataModule.EmpresaFields.Compras_FechaRecepcionPorLinea.Value ) or
                           ( ( Movimiento.TipoMovimiento=tmPedidoVenta ) and( Movimiento.FechaAplicacion<>DeMovimientoFields.FechaAplicacion.Value ) and not SessionDataModule.EmpresaFields.Ventas_FechaEntregaPorLinea.Value ) or
                           ( ( Movimiento.TipoMovimiento=tmVenta ) and ( Movimiento.Propietario<>DeMovimientoFields.Propietario.Value ) )
                      then With DeLineaMovimientoTable do
                             begin
                             SetRange( [ DeMovimientoFields.Ejercicio.Value, DeMovimientoFields.NroOperacion.Value ] );
                             try
                               First;
                               While not Eof do
                                 begin
                                 SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DeMovimientoFields.TipoMovimiento.Value,
                                                                                           DeMovimientoFields.Serie.Value,
                                                                                           DeMovimientoFields.Propietario.Value,
                                                                                           DeLineaMovimientoFields,
                                                                                           { Descontar } True );
                                 Edit;

                                 DeLineaMovimientoFields.Fecha.Value := Movimiento.Fecha;

                                 // La fecha de aplicación (recepción/entrega) de las líneas solo se debe respetar si el usuario tiene activada la inclusión de la fecha por línea

                                 If   ( Movimiento.TipoMovimiento in [ tmPedidoCompra, tmPedidoVenta ] ) and
                                      not ( ( ( Movimiento.TipoMovimiento=tmPedidoCompra ) and SessionDataModule.EmpresaFields.Compras_FechaRecepcionPorLinea.Value ) or
                                            ( ( Movimiento.TipoMovimiento=tmPedidoVenta )  and SessionDataModule.EmpresaFields.Ventas_FechaEntregaPorLinea.Value ) )
                                 then DeLineaMovimientoFields.FechaAplicacion.Value := Movimiento.FechaAplicacion;

                                 // Si ha cambiado el propietario y es un albarán de venta, hay que sustraer los importes del propietario anterior y añadírselos al actual

                                 If   ( Movimiento.TipoMovimiento=tmVenta ) and ( Movimiento.Propietario<>DeMovimientoFields.Propietario.Value )
                                 then begin
                                      SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( DeMovimientoFields.Ejercicio.Value, DeMovimientoFields.Propietario.Value, -DeLineaMovimientoFields.ImporteNeto.Value );
                                      SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( Movimiento.Ejercicio, Movimiento.Propietario, DeLineaMovimientoFields.ImporteNeto.Value );
                                      end;

                                 SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( Movimiento.TipoMovimiento,
                                                                                           Movimiento.Serie,
                                                                                           Movimiento.Propietario,
                                                                                           DeLineaMovimientoFields );
                                 Post;
                                 Next;
                                 end;

                             finally
                               CancelRange;
                               end;
                             end;
                      end
                 else RaiseRecordNotFoundException;
                 end
            else begin

                 // Compruebo, si es un movimiento de ventas, que no existe otro movimiento con el mismo número de documento

                 Movimiento.Creado := Now;
                 If   Movimiento.TipoMovimiento in [ tmPresupuesto, tmPedidoVenta, tmVenta ]
                 then If   DmMovimientoCheckTable.FindKey( [ Movimiento.TipoMovimiento, Movimiento.Ejercicio, Movimiento.Serie, Movimiento.NroDocumento ] )
                      then begin
                           var Msg := Format( RsIndiceDocumentoExiste, [ VarToStr( Movimiento.Serie ), VarToInteger( Movimiento.NroDocumento ) ] );
                           LogMessage( Msg );
                           SessionDataModule.SendNotification( ntStop, Msg, RsActiveContadores );
                           Abort;
                           end;
                 end;

            Movimiento.ToDataset( DeMovimientoFields );

            DeMovimientoTable.Post;

            If   Movimiento.State=dsInsert
            then CompruebaPrimerNroPagina( DeMovimientoFields );

            TransactionTag.Commit;

          except on E : Exception do
            begin
            LogException( E, Self );
            DeMovimientoTable.Cancel;
            TransactionTag.Rollback;
            SessionDataModule.SendNotification( ntStop, RsMsg50, E.Message );
            raise;
            end;

          end;

          end
     else RaiseNoCurrentRecordException;
end;

function TMovimientoModule.SuprimeMovimiento( RemoteCursorID : TnxCursorID;
                                              Ejercicio      : SmallInt;
                                              NroOperacion   : LongInt ) : Boolean;
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          TableCursor.RecordLockRelease( False );
          Result := SuprimeMovimiento( Ejercicio, NroOperacion );
          end
     else RaiseNoCurrentRecordException;
end;

function TMovimientoModule.SuprimeMovimiento( Ejercicio        : SmallInt;
                                              NroOperacion     : LongInt;
                                              PreservaCabecera : Boolean = False ) : Boolean;
begin
     Result := False;

     If   DeMovimientoTable.FindKey( [ Ejercicio, NroOperacion ] )
     then begin

          If   DeMovimientoFields.Facturado.Value
          then begin
               SessionDataModule.SendNotification( ntStop, RsMsg1 );
               Result := False;
               Exit;
               end;

          SuprimeLineasMovimiento( DeMovimientoFields );

          If   not PreservaCabecera
          then DeMovimientoTable.Delete;

          Result := True;

          end
     else RaiseRecordNotFoundException;
end;

procedure TMovimientoModule.ActualizaLineaMovimiento( RemoteCursorID    : TnxCursorID;
                                                      TipoMovimiento    : TTipoMovimiento;
                                                      Serie,
                                                      Propietario       : String;
                                                      LineaMovimiento   : ILineaMovimiento;
                                                      CompruebaVinculos : Boolean = True );
var  TableCursor : TnxServerTableCursor;

begin

     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DeLineaMovimientoTable ] );

          try

            // El motivo del doble proceso (quitar y volver a poner) es porque los valores de la línea de movimiento que determinan el registro de stocks
            // (CodigoArticulo, Clases, LoteFabricacion, Almacen, etc..) pueden variar, por lo que hay que sustraer los valores viejos y añadir los nuevos.

            If   LineaMovimiento.State=dsEdit
            then If   DeLineaMovimientoTable.FindKey( [ LineaMovimiento.Ejercicio, LineaMovimiento.NroOperacion, LineaMovimiento.NroPagina, LineaMovimiento.NroLinea ] )
                 then begin

                      TableCursor.RecordLockRelease( False );

                      If   DeLineaMovimientoFields.Cantidad.Value<>0.0
                      then begin

                           SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields, True );

                           If   TipoMovimiento=tmVenta
                           then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( LineaMovimiento.Ejercicio, Propietario, -DeLineaMovimientoFields.ImporteNeto.Value );

                           If   CompruebaVinculos
                           then If   DeLineaMovimientoFields.TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ]
                                then RegularizaLineaPedido( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields, True );

                           end;
                      end
                 else RaiseRecordNotFoundException;

            LineaMovimiento.ToDataset( DeLineaMovimientoFields );

            SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields );
            If   TipoMovimiento=tmVenta
            then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( LineaMovimiento.Ejercicio, Propietario, DeLineaMovimientoFields.ImporteNeto.Value );
            If   CompruebaVinculos
            then If   DeLineaMovimientoFields.TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ]
                 then RegularizaLineaPedido( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields, False );

            DeLineaMovimientoTable.Post;

            TransactionTag.Commit;

          except
            DeLineaMovimientoTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseNoCurrentRecordException;

end;

procedure TMovimientoModule.SuprimeLineaMovimiento( RemoteCursorID  : TnxCursorID;
                                                    Ejercicio       : SmallInt;
                                                    NroOperacion    : LongInt;
                                                    NroPagina,
                                                    NroLinea        : SmallInt;
                                                    TipoMovimiento  : TTipoMovimiento;
                                                    Serie,
                                                    Propietario     : String );
var  TableCursor : TnxServerTableCursor;

begin
     If   TnxServerTableCursor.LookupByID( RemoteCursorID, TableCursor )=DBIERR_NONE
     then begin
          TableCursor.RecordLockRelease( False );
          SuprimeLineaMovimiento( Ejercicio, NroOperacion, NroPagina, NroLinea, TipoMovimiento, Serie, Propietario  );
          end
     else RaiseNoCurrentRecordException;
end;

procedure TMovimientoModule.SuprimeLineaMovimiento( Ejercicio       : SmallInt;
                                                    NroOperacion    : LongInt;
                                                    NroPagina,
                                                    NroLinea        : SmallInt;
                                                    TipoMovimiento  : TTipoMovimiento;
                                                    Serie,
                                                    Propietario     : String );
begin
     If   DeLineaMovimientoTable.FindKey( [ Ejercicio, NroOperacion, NroPagina, NroLinea ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

          try

            If   DeMovimientoTable.FindKey( [ Ejercicio, NroOperacion ] )
            then FBeforeDeleteLineaMovimiento.Invoke( DeMovimientoFields, DeLineaMovimientoFields );

            SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields, True );
            If   TipoMovimiento=tmVenta
            then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( Ejercicio, Propietario, -DeLineaMovimientoFields.ImporteNeto.Value );
            SuprimeReferenciasLinea( Ejercicio, NroOperacion, TipoMovimiento, DeLineaMovimientoFields );
            If   DeLineaMovimientoFields.TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ]
            then RegularizaLineaPedido( TipoMovimiento, Serie, Propietario, DeLineaMovimientoFields, True );

            DeLineaMovimientoTable.Delete;

            TransactionTag.Commit;
          except
            DeLineaMovimientoTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end
     else RaiseRecordNotFoundException;
end;

function TMovimientoModule.VincularAlbaranAPedido( NroOperacionAlbaran : LongInt;
                                                   NroPagina           : SmallInt;
                                                   EjercicioPedido     : SmallInt;
                                                   NroOperacionPedido  : LongInt ) : Boolean;

var  CantidadPendiente,
     CantidadLineaAlbaran : Decimal;

begin

    Result := False;

    DmMovimientoOrigenTable.CancelRange;
    DmMovimientoTable.CancelRange;

    If   DmMovimientoOrigenTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacionAlbaran ] )
    then If   DmMovimientoTable.FindKey( [ EjercicioPedido, NroOperacionPedido ] )
         then begin

              DmLineaMovimientoOrigenTable.CancelRange;
              DmLineaMovimientoOrigenTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

              // Primero compruebo si el documento está libre

              If   DmMovimientoTable.IsRecordLocked<>lpNotAtAll
              then SessionDataModule.SendNotification( ntWarning, RsMsg35, RsMsg36 )
              else begin

                    With DmMovimientoOrigenFields do
                      DmLineaMovimientoOrigenTable.SetRange( [ Ejercicio.Value, NroOperacion.Value, NroPagina ] );

                    With DmMovimientoFields do   // Es el pedido que acabamos de leer
                      DmLineaMovimientoTable.SetRange( [ Ejercicio.Value, NroOperacion.Value, NroPagina ] );  // No usar en documentos paginados ?

                    try

                        var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoOrigenTable ] );

                        try

                          DmLineaMovimientoOrigenTable.First;
                          While not DmLineaMovimientoOrigenTable.Eof do
                            begin

                            If   DmLineaMovimientoOrigenFields.NroRegistroOrigen.IsNull
                            then begin

                                 DmLineaMovimientoTable.First;
                                 While not DmLineaMovimientoTable.Eof do
                                   begin

                                   CantidadLineaAlbaran := DecSign( DmLineaMovimientoOrigenFields.Cantidad.Value, DmMovimientoOrigenFields.TipoMovimiento.Value=tmCompra );
                                   CantidadPendiente := DmLineaMovimientoFields.Cantidad.Value - DmLineaMovimientoFields.CantidadProcesada.Value;

                                   If   ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value<>ArticuloManual ) and
                                        ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value=DmLineaMovimientoFields.CodigoArticulo.Value ) and
                                        ( DmLineaMovimientoOrigenFields.CodigoClaseA.Value=DmLineaMovimientoFields.CodigoClaseA.Value ) and
                                        ( DmLineaMovimientoOrigenFields.CodigoClaseB.Value=DmLineaMovimientoFields.CodigoClaseB.Value ) and
                                        ( DmLineaMovimientoOrigenFields.CodigoClaseC.Value=DmLineaMovimientoFields.CodigoClaseC.Value ) and
                                        ( CantidadPendiente<>0.0 ) and
                                        ( CantidadLineaAlbaran<>0.0 )
                                     then try

                                            DmLineaMovimientoOrigenTable.Edit;

                                            DmLineaMovimientoOrigenFields.EjercicioOrigen.Value := DmMovimientoFields.Ejercicio.Value;
                                            DmLineaMovimientoOrigenFields.TipoMovimientoOrigen.Value := DmMovimientoFields.TipoMovimiento.Value;
                                            DmLineaMovimientoOrigenFields.NroOperacionOrigen.Value := DmMovimientoFields.NroOperacion.Value;
                                            DmLineaMovimientoOrigenFields.NroRegistroOrigen.Value := DmLineaMovimientoFields.NroRegistro.Value;

                                            RegularizaLineaPedido( DmMovimientoOrigenFields, DmLineaMovimientoOrigenFields, False );

                                            DmLineaMovimientoOrigenTable.Post;

                                          except
                                            DmLineaMovimientoOrigenTable.Cancel;
                                            raise;
                                            end;

                                     DmLineaMovimientoTable.Next;
                                     end;

                                 end;

                            DmLineaMovimientoOrigenTable.Next;
                            end;

                          TransactionTag.Commit;

                        except on E : Exception do
                          begin
                          TransactionTag.Rollback;
                          SessionDataModule.SendDatabaseError( nil, E );
                          SessionDataModule.SendNotification( ntStop, RsMsg3, RsMsg4 );
                          end;
                        end;

                    finally
                      DmLineaMovimientoOrigenTable.CancelRange;
                      DmLineaMovimientoTable.CancelRange;
                    end;

                    Result := True;
                    end;
              end
         else SessionDataModule.SendNotification( ntWarning, Format( RsMsg37, [ NroOperacionPedido ] ) )
    else SessionDataModule.SendNotification( ntWarning, Format( RsMsg37, [ NroOperacionAlbaran] ) );

end;

function TMovimientoModule.SuprimeVinculosConPedidos( NroOperacion : LongInt;
                                                      NroPagina    : SmallInt ) : Boolean;
begin
     Result := False;
     If   DmMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacion ] )
     then If   DmMovimientoFields.TipoMovimiento.Value in [ tmCompra, tmVenta ]
          then With DmLineaMovimientoTable do
                 try

                   With DmMovimientoFields do
                     SetRange( [ Ejercicio.Value, NroOperacion.Value, NroPagina ] );

                   First;
                   While not Eof do
                     begin
                     If   DmLineaMovimientoFields.TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ]
                     then begin

                          RegularizaLineaPedido( DmMovimientoFields, DmLineaMovimientoFields, True );

                          try
                            DmLineaMovimientoFields.Table.Edit;

                            DmLineaMovimientoFields.TipoMovimientoOrigen.Clear;
                            DmLineaMovimientoFields.EjercicioOrigen.Clear;
                            DmLineaMovimientoFields.NroOperacionOrigen.Clear;
                            DmLineaMovimientoFields.NroRegistroOrigen.Clear;

                            DmLineaMovimientoFields.Table.Post;

                          except
                            DmLineaMovimientoFields.Table.Cancel;
                            raise;
                            end;

                          end;

                     Next;
                     end;

                   Result := True;

                 finally
                   DmLineaMovimientoTable.CancelRange;
                   end;
end;

function TMovimientoModule.ExisteMovimientoArticulo( TipoMovimiento : TTipoMovimiento;
                                                     CodigoArticulo : String;
                                                     FechaInicial,
                                                     FechaFinal     : TDateTime  ) : Boolean;
begin
     Result := False;
     With DmLineaMovimientoAuxTable do
       try

         IndexFieldNames := 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';
         DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';

         SetRange( [ CodigoArticulo, FechaInicial ], [ CodigoArticulo, FechaFinal ] );

         First;
         While not Eof do
           begin

           With DmLineaMovimientoAuxFields do
             If   Cantidad.Value<>0.0
             then If   DmMovimientoAuxTable.FindKey( [ Ejercicio.Value, NroOperacion.Value ] )
                  then If   ( DmMovimientoAuxFields.TipoMovimiento.Value=TipoMovimiento ) or ( TipoMovimiento=tmNoDefinido )
                       then begin
                            Result := True;
                            Break;
                            end;

           Next;
           end;

       finally
         CancelRange;
         end;
end;

// ------------------------------------------------------------------------------------------

function TMovimientoModule.ExisteNroDocumento( TipoMovimiento  : TTipoMovimiento;
                                               Ejercicio       : SmallInt;
                                               Propietario     : String;
                                               Serie           : String;
                                               NroDocumento    : LongInt ) : Boolean;
begin
     With DmMovimientoAuxTable do
       If   TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ]
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
            Result := FindKey( [ TipoMovimiento, Ejercicio, Propietario, Serie, NroDocumento ] );
            end
       else begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            Result := FindKey( [ TipoMovimiento, Ejercicio, Serie, NroDocumento ] );
            end;
end;

procedure TMovimientoModule.RecalculaMovimiento( MovimientoFields : TMovimientoFields );

var   Index,
      EjercicioActual,
      SaveEjercicio : SmallInt;
      SerieActual : String;

begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

     try

       If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
       then begin
            SessionDataModule.Dm10.ProveedorModule.Obten( MovimientoFields.Propietario.Value, '', DsProveedorFields );

            // Un caso muy especial. Si el documento está facturado puede que el usuario haya cambiado el origen del mismo, por ejemplo a 'Inversión del sujeto pasivo'
            // Este recálculo solo puede ocurrir cuando se está editando la factura de compra

            // Ejercicio;Proveedor;SerieNroFactura

            If   MovimientoFields.Facturado.Value
            then If   DmFacturaComprasTable.FindKey( [ MovimientoFields.EjercicioFactura.Value,
                                                       MovimientoFields.Propietario.Value,
                                                       MovimientoFields.SerieFactura.Value ] )
                 then DsProveedorFields.Origen.Value := DmFacturaComprasFields.Origen.Value;

            end
       else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
            then begin
                 SessionDataModule.Dm10.ClienteModule.Obten( MovimientoFields.Propietario.Value, '', DsClienteFields );
                 SessionDataModule.Dm10.SerieFacturacionModule.Obten( MovimientoFields.Serie.Value, DsSerieFacturacionFields );
                 end;

       With DmLineaMovimientoTable do
         begin

         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

         First;
         While not Eof do
           begin

           SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

           try

             Edit;

             If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
             then SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, DsTiposIVAFields )
             else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                  then begin
                       If   MovimientoFields.TipoMovimiento.Value=tmVenta
                       then DmLineaMovimientoFields.CantidadAjustada.Value := -DmLineaMovimientoFields.Cantidad.Value
                       else DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;
                       SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                      DsClienteFields,
                                                                                      DsArticuloFields,
                                                                                      DsSerieFacturacionFields,
                                                                                      DsTiposIVAFields,
                                                                                      MovimientoFields.IVAIncluido.Value );
                       end
                  else SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

             Post;

           except
             Cancel;
             raise;
             end;

           Next;
           end;

         end;

       TransactionTag.Commit;

     except
       TransactionTag.Rollback;
       raise;
       end;

end;

// Si no se pasa el ejercicio y el número de operacion, se supone que el registro ya ha sido previamente posicionado

function TMovimientoModule.ActualizaSituacionPedido( Ejercicio    : SmallInt = 0;
                                                     NroOperacion : LongInt = 0 ) : Boolean;

var   ProcesadoTotal : Decimal;

begin
     Result := False;
     If   ( Ejercicio=0 ) or DmMovimientoAuxTable.FindKey( [ Ejercicio, NroOperacion ] )
     then With DmMovimientoAuxTable do
            begin

            var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoAuxTable ] );

            try

              Edit;

              DmMovimientoAuxFields.Situacion.Value := epProcesado;  // Totalmente recibido o servido
              ProcesadoTotal := 0.0;

              With DmLineaMovimientoAuxTable do
                begin
                try
                  IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                  With DmMovimientoAuxFields do
                    SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );
                  First;
                  While not eof do
                    begin

                    If   DmLineaMovimientoAuxFields.Procesada.Value   // La línea ha sido dada por recibida / servida por el usuario
                    then ProcesadoTotal := ProcesadoTotal + DmLineaMovimientoAuxFields.Cantidad.Value
                    else ProcesadoTotal := ProcesadoTotal + Abs( DmLineaMovimientoAuxFields.CantidadProcesada.Value );

                    If   not DmLineaMovimientoAuxFields.Procesada.Value and
                         ( Abs( DmLineaMovimientoAuxFields.Cantidad.Value )>Abs( DmLineaMovimientoAuxFields.CantidadProcesada.Value ) )
                    then begin
                         DmMovimientoAuxFields.Situacion.Value := epParcialmenteProcesado;
                         If   Abs( DmLineaMovimientoAuxFields.CantidadProcesada.Value )<>0.0
                         then Break;
                         end;

                    Next;
                    end;
                finally
                  CancelRange;
                  end;

                If   ProcesadoTotal=0.0
                then DmMovimientoAuxFields.Situacion.Value := epPendiente;

                end;

              Post;
              Result := True;

              TransactionTag.Commit;

            except
              Cancel;
              TransactionTag.Rollback;
              raise;
              end;

            end;

end;

function TMovimientoModule.RegularizaLineaPedido( MovimientoFields      : TMovimientoFields;
                                                  LineaMovimientoFields : TLineaMovimientoFields;
                                                  Sustraer              : Boolean = False;
                                                  ActualizaSituacion    : Boolean = True ) : Boolean;
begin
     With MovimientoFields do
       Result := RegularizaLineaPedido( TipoMovimiento.Value, Serie.Value, Propietario.Value, LineaMovimientoFields, Sustraer, ActualizaSituacion );
end;

function TMovimientoModule.RegularizaLineaPedido( TipoMovimiento        : TTipoMovimiento;
                                                  Serie,
                                                  Propietario           : String;
                                                  LineaMovimientoFields : TLineaMovimientoFields;
                                                  Sustraer              : Boolean = False;
                                                  ActualizaSituacion    : Boolean = True ) : Boolean;

var   Pendiente,
      CantidadAProcesar,
      CantidadProcesadaAnterior,
      ProcesadoTotal : Decimal;

begin

     Result := False;

     DmMovimientoAuxTable.CancelRange;
     DmLineaMovimientoAuxTable.CancelRange;
     DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';

     With LineaMovimientoFields do
       If   ( TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ] ) and not ValueIsEmpty( NroOperacionOrigen.Value )
       then If   DmMovimientoAuxTable.FindKey( [ EjercicioOrigen.Value, NroOperacionOrigen.Value ] )
            then begin

                 var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoAuxTable ] );

                 try

                   DmLineaMovimientoAuxTable.IndexFieldNames := 'NroRegistro';

                   If   DmLineaMovimientoAuxTable.FindKey( [ NroRegistroOrigen.Value ] )
                   then With DmLineaMovimientoAuxFields do
                          begin

                          CantidadAProcesar := LineaMovimientoFields.Cantidad.Value;

                          If   CantidadAProcesar<>0.0
                          then begin

                               If   TipoMovimiento in [ tmReubicacionCarga, tmVenta ]
                               then CantidadAProcesar := -CantidadAProcesar;

                               If   Sustraer
                               then Pendiente := CantidadProcesada.Value
                               else Pendiente := Cantidad.Value - CantidadProcesada.Value;

                               If   Abs( CantidadAProcesar )>Abs( Pendiente )
                               then begin
                                    If   not Sustraer
                                    then If   SessionDataModule.EmpresaFields.Stock_ImpedirPendienteEnExceso.Value
                                         then begin
                                              SessionDataModule.SendNotification( ntStop, RsMsg28, RsMsg29 );
                                              Abort;
                                              end;
                                    CantidadAProcesar := Pendiente;
                                    end;

                               If   CantidadAProcesar<>0.0
                               then begin

                                    DmLineaMovimientoAuxTable.Edit;

                                    CantidadProcesadaAnterior := CantidadProcesada.Value;

                                    If   Sustraer
                                    then CantidadProcesada.Value := CantidadProcesada.Value - CantidadAProcesar
                                    else begin
                                         CantidadProcesada.Value := CantidadProcesada.Value + CantidadAProcesar;

                                         // Al permitir modificar las clases de las líneas de albaranes que provienen de un pedido, tengo que reajustar
                                         // la línea origen para que coincidan las clases y, al mismo tiempo, dejar las cantidades pendientes de servir/recibir
                                         // en un estado consistente.

                                         If   ( DmLineaMovimientoAuxFields.CodigoClaseA.Value<>LineaMovimientoFields.CodigoClaseA.Value ) or
                                              ( DmLineaMovimientoAuxFields.CodigoClaseB.Value<>LineaMovimientoFields.CodigoClaseB.Value ) or
                                              ( DmLineaMovimientoAuxFields.CodigoClaseC.Value<>LineaMovimientoFields.CodigoClaseC.Value )
                                         then If   NumeroReferenciasLinea( DmLineaMovimientoAuxFields )>1
                                              then begin
                                                   SessionDataModule.SendNotification( ntStop, RsMsg33, RsMsg34 );
                                                   Abort; // La transacción activa evitará inconsistencias
                                                   end
                                              else begin

                                                   // Primero hay que eliminar completamente las cantidades registradas como pendientes de servir o recibir de la línea
                                                   // de pedido original.

                                                   SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( TipoMovimiento, Serie, Propietario, DmLineaMovimientoAuxFields, True );

                                                   DmLineaMovimientoAuxFields.CodigoClaseA.Value := LineaMovimientoFields.CodigoClaseA.Value;
                                                   DmLineaMovimientoAuxFields.CodigoClaseB.Value := LineaMovimientoFields.CodigoClaseB.Value;
                                                   DmLineaMovimientoAuxFields.CodigoClaseC.Value := LineaMovimientoFields.CodigoClaseC.Value;

                                                   // Hay que tener en cuenta que no hay un registro anterior de esta línea que haya acumulado la cantidad pendiente de servir de éste artículo,
                                                   // por lo tanto solo debo registrar como pendiente de servir lo que queda (la cantidad de la línea del albarán es negativa, por eso la suma
                                                   // en ese caso).

                                                   If   TipoMovimiento=tmVenta
                                                   then CantidadAProcesar := DmLineaMovimientoAuxFields.Cantidad.Value + LineaMovimientoFields.Cantidad.Value
                                                   else CantidadAProcesar := DmLineaMovimientoAuxFields.Cantidad.Value - LineaMovimientoFields.Cantidad.Value;

                                                   Sustraer := True;
                                                   end;

                                         end;

                                    With DmMovimientoAuxFields do
                                      SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( TipoMovimiento.Value, Serie.Value, Propietario.Value, DmLineaMovimientoAuxFields, not Sustraer, Abs( CantidadAProcesar ) );

                                    // Si se ha reajustado la cantidad procesada de forma automática la línea ya no puede seguir con la marca de regularización manual

                                    DmLineaMovimientoAuxFields.Procesada.Value := False;
                                    DmLineaMovimientoAuxTable.Post;

                                    end;

                               end;

                          // El proceso de reconstruccion de las cantidades pendientes de recibir no debe afectar a la situación del pedido

                          If   ActualizaSituacion
                          then Result := ActualizaSituacionPedido;

                          end;

                   TransactionTag.Commit;

                 except
                   DmLineaMovimientoAuxTable.Cancel;
                   TransactionTag.Rollback;
                   raise;
                   end;

                 end;

end;

function TMovimientoModule.DarLineaPorProcesada( NroOperacion   : LongInt;
                                                 TipoMovimiento : TTipoMovimiento;
                                                 Serie,
                                                 Propietario    : String;
                                                 NroPagina,
                                                 NroLinea         : SmallInt ) : Decimal;

var  CantidadRegularizar : Decimal;

begin

     Result := 0.0;

     If   DmMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacion ] ) and
          DmLineaMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacion, NroPagina, NroLinea ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

          try

            DmLineaMovimientoTable.Edit;

            CantidadRegularizar := DmLineaMovimientoFields.Cantidad.Value - DmLineaMovimientoFields.CantidadProcesada.Value;

            //* 11.06.2015 Teniendo en cuenta el parámetro 'Ventas_RegularizarPedidosServidos', aunque no fuera su cometido original

            If   ( TipoMovimiento=tmPedidoVenta ) and
                 SessionDataModule.EmpresaFields.Ventas_RegularizarPedidosServidos.Value
            then begin

                 If   DmLineaMovimientoFields.CantidadProcesada.Value=0.0
                 then begin
                      SessionDataModule.SendNotification( ntStop, RsMsg46, RsMsg47 );
                      Abort;
                      end;

                 DmLineaMovimientoFields.Cantidad.Value := DmLineaMovimientoFields.CantidadProcesada.Value;
                 DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;

                 If   SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, DsSerieFacturacionFields ) and
                      SessionDataModule.Dm10.ClienteModule.Obten( Propietario, DsClienteFields ) and
                      SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields )
                 then begin
                      SessionDataModule.Dm30.FacturaVentasModule.ObtenTipoIVAArticulo( DmLineaMovimientoFields.Fecha.Value, DsArticuloFields, DsTiposIVAFields, DsSerieFacturacionFields, DsClienteFields );
                      SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                     DsClienteFields,
                                                                                     DsArticuloFields,
                                                                                     DsSerieFacturacionFields,
                                                                                     DsTiposIVAFields,
                                                                                     DmMovimientoFields.IVAIncluido.Value );
                      end;

                 end
            else begin
                 If   DmLineaMovimientoFields.Procesada.Value
                 then CantidadRegularizar := -CantidadRegularizar;
                 DmLineaMovimientoFields.Procesada.Value := not DmLineaMovimientoFields.Procesada.Value;
                 end;

            // Hay que evitar que se intente actualizar la cantidad pendiente de procesar, puesto que no ha habido ningún cambio en la cantidad de la línea
            // y, sin embargo, se puede dejar la cantidad pendiente a cero y desvirtuar el valor

            DmLineaMovimientoTable.Post;

            If   CantidadRegularizar<>0.0
            then SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields, True, CantidadRegularizar );

            Result := CantidadRegularizar;

            TransactionTag.Commit;

          except
            DmLineaMovimientoTable.Cancel;
            TransactionTag.Rollback;
            raise;
            end;

          end;

end;

function TMovimientoModule.NumeroReferenciasLinea( LineaMovimientoFields : TLineaMovimientoFields ) : SmallInt;
begin
     With DmLineaMovimientoOrigenTable do
       begin
       IndexFieldNames := 'NroRegistroOrigen';
       try
         SetRange( [ LineaMovimientoFields.NroRegistro.Value ] );
         Result := RecordCount;
       finally
         CancelRange;
         end;
       end;
end;

function TMovimientoModule.ObtenUltimoNroLinea( Ejercicio    : SmallInt;
                                                NroOperacion : LongInt;
                                                NroPagina    : SmallInt ) : SmallInt;
begin
     With DmLineaMovimientoAuxTable do
       try
         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
         SetRange( [ Ejercicio, NroOperacion, NroPagina, 1 ], [ Ejercicio, NroOperacion, NroPagina, MaxSmallInt ] );
         Last;
         If   DmLineaMovimientoAuxFields.NroLinea.Value>=1
         then Result := DmLineaMovimientoAuxFields.NroLinea.Value + 1
         else Result := 1
       finally
         CancelRange;
         end;
end;

function TMovimientoModule.ObtenNroPagina( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
                                           OperacionPagina            : TPageOperation ) : SmallInt;

var  RecordFound : Boolean;

begin
     Result := -1;
     If   Assigned( GrupoLineaMovimientoFields )
     then With DmGrupoLineaMovimientoTable do
            begin

            IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';

            With GrupoLineaMovimientoFields do
              begin
              RecordFound := False;
              case OperacionPagina of
                poFirst : RecordFound := FindGreaterOrEqual( [ Ejercicio.Value, NroOperacion.Value, 0 ] );
                poPrior : RecordFound := FindSmaller( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] );
                poNext  : RecordFound := FindGreater( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] );
                poLast  : RecordFound := FindSmallerOrEqual( [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt ] );
                end;
              end;

              If   RecordFound
              then With DmGrupoLineaMovimientoFields do
                     If   ( Ejercicio.Value=GrupoLineaMovimientoFields.Ejercicio.Value ) and
                          ( NroOperacion.Value=GrupoLineaMovimientoFields.NroOperacion.Value )
                     then Result := NroPagina.Value;

            end;
end;

procedure TMovimientoModule.DesplazaLineaMovimiento( Ejercicio    : SmallInt;
                                                     NroOperacion : LongInt;
                                                     NroPagina,
                                                     NroLinea     : SmallInt;
                                                     HaciaArriba  : Boolean = False;
                                                     HastaElFinal : Boolean = False );
begin
     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

     try

       try
         DmLineaMovimientoTable.CancelRange;
         With DmLineaMovimientoTable do
           begin
           SetRange( [ Ejercicio, NroOperacion, NroPagina, 1 ], [ Ejercicio, NroOperacion, NroPagina, MaxSmallInt ] );
           // AutoIncFieldName tiene que estar asignado
           If   FindKey( [ Ejercicio, NroOperacion, NroPagina, NroLinea ] )
           then If   HaciaArriba
                then ShiftRecordUp( DmLineaMovimientoTable, HastaElFinal )
                else ShiftRecordDown( DmLineaMovimientoTable, HastaElFinal )
           end;
         TransactionTag.Commit;
       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendDatabaseError( nil, E );
         Abort;
         end;

       end;

     finally
       DmLineaMovimientoTable.CancelRange;
       end;
end;

function TMovimientoModule.CopiaLineasMovimiento(        MovimientoOrigen          : IMovimiento;
                                                         MovimientoDestinoFields   : TMovimientoFields;
                                                   const LineList                  : TLongIntArray;
                                                         NoVincularDocumentos      : Boolean = False;
                                                         ActualizarSituacionPedido : Boolean = True ) : Boolean;  // Si se ha copiado alguna línea devuelve True

var  NroPaginaActual,
     NroPaginaDestino,
     UltimoNroLinea,
     NroLineaActual : SmallInt;
     NroRegistroOrigen : LongInt;
     Index : SmallInt;
     SeHanImportadoDatos : Boolean;
     CantidadACopiar,
     Existencias : Decimal;

begin

     DmLineaMovimientoOrigenTable.CancelRange;
     DmLineaMovimientoOrigenTable.IndexFieldNames := 'NroRegistro';

     NroPaginaActual := -1;
     NroLineaActual := -1;
     UltimoNroLinea := -1;

     SeHanImportadoDatos := False;

     var TransactionTag := SessionDataModule.StartTransactionWith(  [ DmGrupoLineaMovimientoTable, DmLineaMovimientoTable ] );

     try

       SessionDataModule.Dm10.SerieFacturacionModule.Obten( MovimientoDestinoFields.Serie.Value, DsSerieFacturacionFields );

       If   MovimientoDestinoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
       then SessionDataModule.Dm10.ClienteModule.Obten( MovimientoDestinoFields.Propietario.Value, DsClienteFields )
       else SessionDataModule.Dm10.ProveedorModule.Obten( MovimientoDestinoFields.Propietario.Value, DsProveedorFields );

       For Index := 0 to High( LineList ) do
         begin

         NroRegistroOrigen := LineList[ Index ];

         If   DmLineaMovimientoOrigenTable.FindKey( [ NroRegistroOrigen ] )
         then begin

              CantidadACopiar := 0.0;

              SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoOrigenFields.CodigoArticulo.Value, DsArticuloFields );

              case MovimientoDestinoFields.TipoMovimiento.Value of

                tmPresupuesto,
                tmPedidoventa,
                tmVenta  :
                  begin

                  If   not NoVincularDocumentos and ( ( MovimientoDestinoFields.TipoMovimiento.Value=tmVenta ) and ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta ) )
                  then begin
                       If   not DmLineaMovimientoOrigenFields.Procesada.Value
                       then CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value - DmLineaMovimientoOrigenFields.CantidadProcesada.Value;
                       end
                  else CantidadACopiar := DecSign( DmLineaMovimientoOrigenFields.Cantidad.Value, MovimientoOrigen.TipoMovimiento<>tmVenta );

                  If   CantidadACopiar<>0.0
                  then With SessionDataModule.EmpresaFields do
                         If   ( MovimientoDestinoFields.TipoMovimiento.Value=tmVenta ) and
                              Stock_ImpSalidasSinStock.Value
                              and not DsArticuloFields.NoAfectarStock.Value and
                              ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value<>ArticuloManual )
                         then begin
                              Existencias := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock(  DmLineaMovimientoOrigenFields.CodigoArticulo.Value,
                                                                                                    not Articulo_ExisteClase[ tcClaseA ].Value,
                                                                                                    DmLineaMovimientoOrigenFields.CodigoClaseA.Value,
                                                                                                    DmLineaMovimientoOrigenFields.CodigoClaseB.Value,
                                                                                                    DmLineaMovimientoOrigenFields.CodigoClaseC.Value,
                                                                                                    ( DmLineaMovimientoOrigenFields.LoteFabricacion.Value='' ) or not Stock_LotesProductos.Value,
                                                                                                    DmLineaMovimientoOrigenFields.LoteFabricacion.Value,
                                                                                                    not Stock_MultiAlmacen.Value,
                                                                                                    DmLineaMovimientoOrigenFields.CodigoAlmacen.Value,
                                                                                                    not Stock_Ubicaciones.Value,
                                                                                                    DmLineaMovimientoOrigenFields.Ubicacion.Value,
                                                                                                    False,
                                                                                                    SessionDataModule.Ejercicio,
                                                                                                    0,
                                                                                                    12 ).SumaExistencias.Saldo;
                              If   Existencias<CantidadACopiar
                              then CantidadACopiar := Existencias;

                              If   CantidadACopiar<=0.0
                              then CantidadACopiar := 0.0; // A la siguiente línea

                              end;
                  end;

                tmOferta,
                tmPedidoCompra,
                tmCompra :
                  begin

                  If   not NoVincularDocumentos and ( ( MovimientoDestinoFields.TipoMovimiento.Value=tmCompra ) and ( MovimientoOrigen.TipoMovimiento=tmPedidoCompra ) )
                  then CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value - DmLineaMovimientoOrigenFields.CantidadProcesada.Value
                  else CantidadACopiar := DecSign( DmLineaMovimientoOrigenFields.Cantidad.Value, MovimientoOrigen.TipoMovimiento<>tmVenta );

                  If   FModuloHojasDePedido and ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta )
                  then try
                         DmLineaMovimientoOrigenTable.Edit;
                         DmLineaMovimientoOrigenFields.Parametros.Value := SetBit( DmLineaMovimientoOrigenFields.Parametros.Value, 0 );  // Indico que ha sido exportada a un pedido de compras
                         DmLineaMovimientoOrigenTable.Post;
                       except
                         DmLineaMovimientoOrigenTable.Cancel;
                         raise;
                         end;

                  end

                else
                  CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value;

                end;

              If   ( CantidadACopiar<>0.0 ) or
                   ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value=ArticuloManual ) or
                   ( DmLineaMovimientoOrigenFields.Cantidad.Value=0.0 ) or
                   ( DsArticuloFields.NoAfectarStock.Value )
              then begin

                   // Comprobando si existe la página en el documento destino. Si no es así habrá que crearla
                   // Si la página tiene asignado un grupo, se busca por él. En caso contrario por número de página.

                   If   SessionDataModule.EmpresaFields.Ventas_DocumentosPaginados.Value
                   then begin

                        If   DmGrupoLineaMovimientoOrigenTable.FindKey( [ DmLineaMovimientoOrigenFields.Ejercicio.Value,
                                                                          DmLineaMovimientoOrigenFields.NroOperacion.Value,
                                                                          DmLineaMovimientoOrigenFields.NroPagina.Value ] )
                        then begin

                             NroPaginaDestino := -1;

                             If   DmGrupoLineaMovimientoOrigenFields.CodigoGrupo.Value<>''
                             then begin
                                  DmGrupoLineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;CodigoGrupo';
                                  If   DmGrupoLineaMovimientoTable.FindKey( [ MovimientoDestinoFields.Ejercicio.Value,
                                                                              MovimientoDestinoFields.NroOperacion.Value,
                                                                              DmGrupoLineaMovimientoOrigenFields.CodigoGrupo.Value ] )
                                  then NroPaginaDestino := DmGrupoLineaMovimientoFields.NroPagina.Value;
                                  end;

                             If   NroPaginaDestino=-1
                             then begin
                                  If   NroPaginaActual=DmGrupoLineaMovimientoOrigenFields.NroPagina.Value
                                  then NroPaginaDestino := NroPaginaActual
                                  else begin
                                       DmGrupoLineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';
                                       If   DmGrupoLineaMovimientoTable.FindKey( [ MovimientoDestinoFields.Ejercicio.Value,
                                                                                   MovimientoDestinoFields.NroOperacion.Value,
                                                                                   DmLineaMovimientoOrigenFields.NroPagina.Value ] )
                                       then NroPaginaDestino := DmGrupoLineaMovimientoFields.NroPagina.Value;
                                       end;
                                  end;

                             If   NroPaginaDestino=-1
                             then begin

                                  NroPaginaDestino := ObtenNroPagina( DmGrupoLineaMovimientoFields, poLast ) + 1;

                                  DmGrupoLineaMovimientoTable.Append;

                                  DmGrupoLineaMovimientoFields.Ejercicio.Value := MovimientoDestinoFields.Ejercicio.Value;
                                  DmGrupoLineaMovimientoFields.NroOperacion.Value := MovimientoDestinoFields.NroOperacion.Value;
                                  DmGrupoLineaMovimientoFields.NroPagina.Value := NroPaginaDestino;

                                  DmGrupoLineaMovimientoFields.CodigoGrupo.Value := DmGrupoLineaMovimientoOrigenFields.CodigoGrupo.Value;
                                  DmGrupoLineaMovimientoFields.Descripcion.Value := DmGrupoLineaMovimientoOrigenFields.Descripcion.Value;
                                  DmGrupoLineaMovimientoFields.Anotacion.Value := DmGrupoLineaMovimientoOrigenFields.Anotacion.Value;

                                  DmGrupoLineaMovimientoTable.Post;

                                  NroLineaActual := 1;
                                  end
                             else If   NroPaginaActual<>NroPaginaDestino
                                  then NroLineaActual := -1;

                             end;
                        end
                   else NroPaginaDestino := 0;  // No hay paginación

                   NroPaginaActual := NroPaginaDestino;

                   If   NroLineaActual=-1
                   then NroLineaActual := ObtenUltimoNroLinea( MovimientoDestinoFields.Ejercicio.Value, MovimientoDestinoFields.NroOperacion.Value, NroPaginaDestino )
                   else Inc( NroLineaActual );

                   DmLineaMovimientoTable.Append;
                   DmLineaMovimientoTable.CopyFields( DmLineaMovimientoOrigenTable );

                   DmLineaMovimientoFields.Ejercicio.Value := MovimientoDestinoFields.Ejercicio.Value;
                   DmLineaMovimientoFields.NroOperacion.Value := MovimientoDestinoFields.NroOperacion.Value;
                   DmLineaMovimientoFields.NroPagina.Value := NroPaginaActual;
                   DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
                   DmLineaMovimientoFields.NroRegistro.Clear;  // Para que se autoincremente
                   DmLineaMovimientoFields.Fecha.Value := MovimientoDestinoFields.Fecha.Value;

                   If   NoVincularDocumentos
                   then begin
                        DmLineaMovimientoFields.TipoMovimientoOrigen.Clear;
                        DmLineaMovimientoFields.EjercicioOrigen.Clear;
                        DmLineaMovimientoFields.NroOperacionOrigen.Clear;
                        DmLineaMovimientoFields.NroRegistroOrigen.Clear;
                        end
                   else begin
                        DmLineaMovimientoFields.TipoMovimientoOrigen.Value := MovimientoOrigen.TipoMovimiento;
                        DmLineaMovimientoFields.EjercicioOrigen.Value := MovimientoOrigen.Ejercicio;
                        DmLineaMovimientoFields.NroOperacionOrigen.Value := MovimientoOrigen.NroOperacion;
                        DmLineaMovimientoFields.NroRegistroOrigen.Value := NroRegistroOrigen;
                        end;

                   // Si la oferta, presupuesto o pedido que se importa no pertenece al mismo propietario es una simple copia, no una importación

                   If   NoVincularDocumentos or ( VarToInteger( MovimientoOrigen.TipoMovimiento ) in [ tmOferta, tmPedidoCompra, tmPresupuesto, tmPedidoVenta ] ) and ( MovimientoOrigen.Propietario<>MovimientoDestinoFields.Propietario.Value )
                   then DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

                   DmLineaMovimientoFields.Cantidad.Value := DecSign( CantidadACopiar, MovimientoDestinoFields.TipoMovimiento.Value<>tmVenta );
                   DmLineaMovimientoFields.CantidadAjustada.Value := DecSign( DmLineaMovimientoFields.Cantidad.Value, MovimientoDestinoFields.TipoMovimiento.Value<>tmVenta );

                   DmLineaMovimientoFields.CantidadProcesada.Value := 0.0;

                   // Si el tipo de documento destino pertenece a otra sección, hay que recalcular los precios

                   If   ( MovimientoDestinoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ] ) and ( MovimientoOrigen.TipoMovimiento in [ tmPresupuesto..tmVenta ] )
                   then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, True )
                   else If   ( MovimientoOrigen.TipoMovimiento in [ tmOferta..tmCompra ] ) and ( MovimientoDestinoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ] )
                        then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( MovimientoDestinoFields.TipoMovimiento.Value, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields, True );

                   // Y también hay que recalcular los campos internos

                   If   MovimientoDestinoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
                   then SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                        DsProveedorFields,
                                                                                        DsArticuloFields,
                                                                                        DsTiposIVAFields )
                   else If   MovimientoDestinoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                        then SessionDataModule.Dm30.MovimientoModule.ActualizaCamposCalculadosLineaVenta( MovimientoDestinoFields,
                                                                                                          DmLineaMovimientoFields,
                                                                                                          DsClienteFields,
                                                                                                          DsArticuloFields,
                                                                                                          DsSerieFacturacionFields,
                                                                                                          DsTiposIVAFields );

                   SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( MovimientoDestinoFields, DmLineaMovimientoFields );

                   If   ( ( MovimientoDestinoFields.TipoMovimiento.Value=tmCompra ) and ( DmLineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoCompra ) ) or
                        ( ( MovimientoDestinoFields.TipoMovimiento.Value=tmVenta ) and ( DmLineaMovimientoFields.TipoMovimientoOrigen.Value=tmPedidoVenta ) )
                   then RegularizaLineaPedido( MovimientoDestinoFields, DmLineaMovimientoFields, False, ActualizarSituacionPedido );

                   DmLineaMovimientoTable.Post;
                   SeHanImportadoDatos := True;
                   end;

              end;

         end;

        // Si estoy importando un presupuesto he de suponer que es porque ha sido aceptado -aunque solo sea parcialmente-

        If   SeHanImportadoDatos and
             ( MovimientoOrigen.TipoMovimiento=tmPresupuesto ) and
             ( MovimientoDestinoFields.TipoMovimiento.Value in [ tmPedidoVenta, tmVenta ] ) and
             ( MovimientoOrigen.Propietario=MovimientoDestinoFields.Propietario.Value )
        then If   DmMovimientoOrigenTable.FindKey( [ SessionDataModule.Ejercicio, MovimientoOrigen.NroOperacion ] )
             then try
                    DmMovimientoOrigenTable.Edit;
                    DmMovimientoOrigenFields.Situacion.Value := eprAceptado;
                    DmMovimientoOrigenTable.Post;
                  except
                    DmMovimientoOrigenTable.Cancel;
                    raise;
                    end;

       TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       SessionDataModule.SendNotification( ntStop, RsMsg27 );
       Abort;
       end;
     end;

     Result := SeHanImportadoDatos;

end;

procedure  TMovimientoModule.InsertaLineasDocumento(       MovimientoOrigen,
                                                           MovimientoDestino    : IMovimiento;
                                                     const LineList             : TLongIntArray;
                                                           CopiarDatosCabecera  : Boolean = False;
                                                           NoVincularDocumentos : Boolean = False );
begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoOrigenTable, DmMovimientoTable ] );

     try

       DmMovimientoTable.CancelRange;

       If   DmMovimientoTable.FindKey( [ MovimientoDestino.Ejercicio, MovimientoDestino.NroOperacion ] )
       then begin

            If   CopiaLineasMovimiento( MovimientoOrigen, { MovimientoDestinoFields } DmMovimientoFields, LineList, NoVincularDocumentos )
            then begin

                 If   ( MovimientoOrigen.TipoMovimiento=tmPresupuesto ) and ( MovimientoOrigen.TipoMovimiento in [ tmPedidoventa, tmVenta ] )
                 then If   DmMovimientoOrigenTable.FindKey( [ MovimientoOrigen.Ejercicio, MovimientoOrigen.NroOperacion ] )
                      then try
                             DmMovimientoOrigenTable.Edit;
                             DmMovimientoOrigenFields.Situacion.Value := eprAceptado;
                             DmMovimientoOrigenTable.Post;
                           except
                             DmMovimientoOrigenTable.Cancel;
                             raise;
                           end;

                 If   CopiarDatosCabecera
                 then try
                        // Es evidente que no se puede utilizar esta opción si el registro está siendo editado en el cliente, porque tendrá un bloqueo
                        DmMovimientoTable.Edit;
                        DmMovimientoFields.GrupoFacturacion.Value := MovimientoOrigen.GrupoFacturacion;
                        DmMovimientoFields.RegistroAuxiliar.Value := MovimientoOrigen.RegistroAuxiliar;
                        DmMovimientoFields.CodigoVendedor.Value := MovimientoOrigen.CodigoVendedor;
                        DmMovimientoFields.CentroCoste.Value := MovimientoOrigen.CentroCoste;
                        DmMovimientoFields.CodigoTransportista.Value := MovimientoOrigen.CodigoTransportista;
                        DmMovimientoFields.CodigoFormaCobro.Value := MovimientoOrigen.CodigoFormaCobro;

                        For var Inx := Low( DmMovimientoFields.CampoLibre ) to High( DmMovimientoFields.CampoLibre ) do
                          If   not VarIsNull( MovimientoOrigen.CampoLibre[ Inx ] )
                          then DmMovimientoFields.CampoLibre[ Inx ].Value := MovimientoOrigen.CampoLibre[ Inx ];

                        DmMovimientoTable.Post;
                      except
                        DmMovimientoTable.Cancel;
                        raise;
                        end;

                 CompruebaPrimerNroPagina( DmMovimientoFields );

                 end
            else SessionDataModule.SendNotification( ntWarning, RsMsg48, RsMsg49 );

            end
       else begin
            SessionDataModule.SendNotification( ntWarning, Format( RsMsg39, [ MovimientoDestino.NroOperacion ] ) );
            Abort;
            end;

       TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       SessionDataModule.SendNotification( ntStop, RsMsg27 );
       Abort;
       end;
     end;

end;

function TMovimientoModule.CopiaMovimiento( EjercicioOrigen        : SmallInt;
                                            NroOperacionOrigen     : LongInt;
                                            TipoMovimientoDestino  : TTipoMovimiento;
                                            PropietarioDestino     : String;
                                            SerieDestino           : String;
                                            ModificarAlmacen       : Boolean;
                                            AlmacenDestino         : String = '';
                                            AsignarUbicaciones     : Boolean = False;
                                            InvertirCantidades     : Boolean = False;
                                            BorrarMovimientoOrigen : Boolean = False;
                                            ActualizarPrecios      : Boolean = False;
                                            NroDocumentoDestino    : LongInt = 0   ) : LongInt;

var  FieldValuesArray : TFieldValuesArray;
     Bm : TBookmark;

begin
     Result := -1;

     DmMovimientoOrigenTable.CancelRange;

     If   DmMovimientoOrigenTable.FindKey( [ EjercicioOrigen, NroOperacionOrigen ] )
     then begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmGrupoLineaMovimientoTable, DmLineaMovimientoTable ] );

          try

            try

              DmLineaMovimientoOrigenTable.CancelRange;
              DmLineaMovimientoOrigenTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

              DmMovimientoTable.Append;

              DmMovimientoTable.CopyFields( DmMovimientoOrigenTable );

              DmMovimientoFields.TipoMovimiento.Value := TipoMovimientoDestino;
              DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
              DmMovimientoFields.Serie.Value := SerieDestino;
              DmMovimientoFields.Propietario.Value := PropietarioDestino;
              DmMovimientoFields.NroOperacion.Value := ProximaOperacion;

              If   ( NroDocumentoDestino=0 ) and ( TipoMovimientoDestino in [ tmOferta..tmVenta ] )
              then DmMovimientoFields.NroDocumento.Value := ProximoDocumento( DmMovimientoFields )
              else DmMovimientoFields.NroDocumento.Value := NroDocumentoDestino;

              If   not BorrarMovimientoOrigen or not SessionDataModule.IsValidYear( DmMovimientoFields.Fecha.Value )
              then DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;

              DmMovimientoFields.Situacion.Value := epPendiente;

              DmMovimientoFields.EjercicioFactura.Clear;
              DmMovimientoFields.PropietarioFactura.Clear;
              DmMovimientoFields.SerieFactura.Clear;
              DmMovimientoFields.NroFactura.Clear;
              DmMovimientoFields.Facturado.Value := False;
              DmMovimientoFields.Traspasado.Value := False;
              DmMovimientoFields.Anulado.Value := False;
              DmMovimientoFields.Suministrado.Value := False;
              DmMovimientoFields.Origen.Value := omManual;

              If   TipoMovimientoDestino in [ tmOferta..tmCompra ]
              then SessionDataModule.Dm10.ProveedorModule.Obten( DmMovimientoFields.Propietario.Value, DsProveedorFields )
              else If   TipoMovimientoDestino in [ tmPresupuesto..tmVenta ]
                   then begin
                        SessionDataModule.Dm10.ClienteModule.Obten( DmMovimientoFields.Propietario.Value, DsClienteFields );
                        SessionDataModule.Dm10.SerieFacturacionModule.Obten( DmMovimientoFields.Serie.Value, DsSerieFacturacionFields );
                        end;

              // Primero copio -si existen- los registros de grupos de lineas

              DmGrupoLineaMovimientoOrigenTable.SetRange( [ EjercicioOrigen, NroOperacionOrigen ] );
              DmGrupoLineaMovimientoOrigenTable.First;
              While not DmGrupoLineaMovimientoOrigenTable.Eof do
                begin

                DmGrupoLineaMovimientoTable.Append;

                DmGrupoLineaMovimientoTable.CopyFields( DmGrupoLineaMovimientoOrigenTable );

                DmGrupoLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                DmGrupoLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;

                DmGrupoLineaMovimientoTable.Post;

                DmGrupoLineaMovimientoOrigenTable.Next;
                end;

              // Y luego, las líneas

              DmLineaMovimientoOrigenTable.SetRange( [ EjercicioOrigen, NroOperacionOrigen ] );

              DmLineaMovimientoOrigenTable.First;
              While not DmLineaMovimientoOrigenTable.Eof do
                begin

                DmLineaMovimientoTable.Append;

                DmLineaMovimientoTable.CopyFields( DmLineaMovimientoOrigenTable );

                DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                DmLineaMovimientoFields.CantidadProcesada.Value := 0.0;

                If   not BorrarMovimientoOrigen
                then begin
                     DmLineaMovimientoFields.NroRegistro.Clear;
                     DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

                     DmLineaMovimientoFields.TipoMovimientoOrigen.Clear;
                     DmLineaMovimientoFields.EjercicioOrigen.Clear;
                     DmLineaMovimientoFields.NroOperacionOrigen.Clear;
                     DmLineaMovimientoFields.NroRegistroOrigen.Clear;
                     end;

                SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

                If   ModificarAlmacen
                then DmLineaMovimientoFields.CodigoAlmacen.Value := AlmacenDestino;

                If   AsignarUbicaciones
                then DmLineaMovimientoFields.Ubicacion.Value := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( DmLineaMovimientoFields.CodigoAlmacen.Value, DsArticuloFields );

                If   InvertirCantidades
                then DmLineaMovimientoFields.Cantidad.Value := -DmLineaMovimientoFields.Cantidad.Value;

                If   TipoMovimientoDestino=tmVenta
                then DmLineaMovimientoFields.CantidadAjustada.Value := -DmLineaMovimientoFields.Cantidad.Value;

                If   ActualizarPrecios
                then If   SessionDataModule.EmpresaFields.Stock_CosteEntradaPorLote.Value and
                          ( TipoMovimientoDestino in [ tmInventario, tmEntrada, tmRegularizacion, tmCompra, tmMinimoUsuario..tmMaximoUsuario ] ) and
                          ( DmLineaMovimientoFields.Cantidad.Value>0.0 )
                     then ObtenCosteUltimaEntradaPorLote( DmLineaMovimientoFields )
                     else If   TipoMovimientoDestino in [ tmPresupuesto..tmVenta ]
                          then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( TipoMovimientoDestino,
                                                                                           DmLineaMovimientoFields,
                                                                                           DsClienteFields,
                                                                                           DsArticuloFields,
                                                                                           { Inicializar } True )
                          else SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields,
                                                                                            TProveedorFields( IfThen( TipoMovimientoDestino in [ tmOferta..tmCompra ], DsProveedorFields, nil ) ),
                                                                                            DsArticuloFields,
                                                                                            { Inicializar } True );

                If   TipoMovimientoDestino in [ tmOferta..tmCompra ]
                then SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, DsTiposIVAFields )
                else If   DmMovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                     then begin
                          If   DmMovimientoFields.TipoMovimiento.Value=tmVenta
                          then DmLineaMovimientoFields.CantidadAjustada.Value := -DmLineaMovimientoFields.Cantidad.Value
                          else DmLineaMovimientoFields.CantidadAjustada.Value := DmLineaMovimientoFields.Cantidad.Value;
                          SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                         DsClienteFields,
                                                                                         DsArticuloFields,
                                                                                         DsSerieFacturacionFields,
                                                                                         DsTiposIVAFields,
                                                                                         DmMovimientoFields.IVAIncluido.Value );
                          end
                     else SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

                SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

                DmLineaMovimientoTable.Post;

                DmLineaMovimientoOrigenTable.Next;
                end;

              If   NroDocumentoDestino<>0
              then With DmMovimientoFields do
                     If   ExisteNroDocumento( TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value )
                     then begin
                          SessionDataModule.SendNotification( ntError, RsMsg25, RsMsg26 );
                          Abort;
                          end;

              Result := DmMovimientoFields.NroOperacion.Value;

              DmMovimientoTable.Post;

              If   TipoMovimientoDestino in [ tmPresupuesto..tmVenta ]
              then CompruebaPrimerNroPagina( DmMovimientoFields );

              If   NroDocumentoDestino=0
              then RetiraDocumento( DmMovimientoFields, False );

              If   BorrarMovimientoOrigen
              then SuprimeMovimiento( EjercicioOrigen, NroOperacionOrigen );

            finally
              DmGrupoLineaMovimientoOrigenTable.CancelRange;
              DmLineaMovimientoOrigenTable.CancelRange;
              end;

            TransactionTag.Commit;

          except
            TransactionTag.Rollback;
            SessionDataModule.SendNotification( ntStop, RsErrorCopiaRegistro, RsProcesoInterrumpido );
            end;

          end;

end;

procedure TMovimientoModule.ObtenCosteUltimaEntradaPorLote( LineaMovimientoFields : TLineaMovimientoFields );

var  PrecioEntrada : Decimal;
     NroRegistroLineaOrigen : LongInt;

begin
     With LineaMovimientoFields do
       If   LoteFabricacion.Value<>''
       then If   ObtenCosteUltimaEntradaPorLote( Fecha.Value,
                                                 CodigoArticulo.Value,
                                                 CodigoClaseA.Value,
                                                 CodigoClaseB.Value,
                                                 CodigoClaseC.Value,
                                                 LoteFabricacion.Value,
                                                 NroRegistro.Value,
                                                 PrecioEntrada,
                                                 NroRegistroLineaOrigen )
            then begin

                 Precio.Value := PrecioEntrada;
                 NroRegistroOrigen.Value := NroRegistroLineaOrigen;

                 // El registro de DmMovimientoAuxFields se ha leído en la llamada a la función anterior

                 AsignacionOrigen.Value := aomLote;
                 TipoMovimientoOrigen.Value := DmMovimientoAuxFields.TipoMovimiento.Value;
                 EjercicioOrigen.Value := DmMovimientoAuxFields.Ejercicio.Value;
                 NroOperacionOrigen.Value := DmMovimientoAuxFields.NroOperacion.Value;

                 end;
end;

function TMovimientoModule.ObtenCosteUltimaEntradaPorLote(     Fecha             : TDate;
                                                               CodigoArticulo,
                                                               CodigoClaseA,
                                                               CodigoClaseB,
                                                               CodigoClaseC,
                                                               LoteFabricacion   : String;
                                                               NroRegistroLinea  : LongInt;
                                                           out Precio            : Decimal;
                                                           out NroRegistroOrigen : LongInt ) : Boolean;

// La fecha es solo para evitar considerar movimientos posteriores cuando se están haciendo modificaciones

begin
     Result := False;
     Precio := 0.0;
     If   ( LoteFabricacion<>'' ) and
          SessionDataModule.EmpresaFields.Stock_LotesProductos.Value and
          SessionDataModule.EmpresaFields.Stock_CosteEntradaPorLote.Value
     then begin

          DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';
          With DmLineaMovimientoAuxTable do
            begin

            IndexFieldNames := 'CodigoArticulo;LoteFabricacion;Fecha';

            SetRange( [ CodigoArticulo, LoteFabricacion, LowestDateTime ], [ CodigoArticulo, LoteFabricacion, Fecha ] );
            Last;
            While not Bof do
              begin

              // No debería existir un mismo número de lote asignado al mismo artículo con diferentes clases, pero bueno

              If   ( ( NroRegistroLinea=0 ) or ( DmLineaMovimientoFields.NroRegistro.Value<>NroRegistroLinea ) ) and  // Si se está modificando una línea podría ser ésta
                   ( DmLineaMovimientoAuxFields.CodigoClaseA.Value=CodigoClaseA ) and
                   ( DmLineaMovimientoAuxFields.CodigoClaseB.Value=CodigoClaseB ) and
                   ( DmLineaMovimientoAuxFields.CodigoClaseC.Value=CodigoClaseC ) and
                   ( DmLineaMovimientoAuxFields.Cantidad.Value>0.0 )
              then If   DmMovimientoAuxTable.FindKey( [ DmLineaMovimientoAuxFields.Ejercicio.Value, DmLineaMovimientoAuxFields.NroOperacion.Value ] )
                   then If  DmMovimientoAuxFields.TipoMovimiento.Value in [ tmInventario, tmEntrada, tmRegularizacion, tmFabricacion, tmCompra, tmMinimoUsuario..tmMaximoUsuario ]
                        then begin
                             Precio := DmLineaMovimientoAuxFields.Precio.Value;
                             NroRegistroOrigen := DmLineaMovimientoAuxFields.NroRegistro.Value;
                             Result := True;
                             Exit;
                             end;
              Prior;
              end;
            end;
          end;
end;

procedure TMovimientoModule.ActivaHojasDePedido;
begin
     FModuloHojasDePedido := True;
end;

procedure TMovimientoModule.ImportaDatosCapturador( Movimiento           : IMovimiento;
                                                    ContenidoFichero     : String;
                                                    NroPaginaActual,
                                                    UltimoNroLinea       : SmallInt;
                                                    CodigoAlmacenDestino : String );

var   DataList : TStringList;

      LineIndex : SmallInt;

      ExistePrecio,
      ExisteDescuento,
      Error : Boolean;
      NroCampos,
      NroColumna : SmallInt;
      CodigoArticuloEntrada : String;
      CodigoClaseAEntrada,
      CodigoClaseBEntrada,
      CodigoClaseCEntrada : String;
      FijarClases : Boolean;
      DescripcionEntrada : String;
      CantidadEntrada,
      PrecioEntrada,
      DescuentoEntrada : Decimal;
      IncluirLinea : Boolean;

procedure DesglosaLineaEntrada( DataLine : String );

var ListaParametros : TStringList;

begin

     CodigoArticuloEntrada := '';
     CodigoClaseAEntrada := '';
     CodigoClaseBEntrada := '';
     CodigoClaseCEntrada := '';
     DescripcionEntrada := '';
     CantidadEntrada := 0.0;
     PrecioEntrada := 0.0;
     DescuentoEntrada := 0.0;

     ListaParametros := TStringList.Create;
     try
         //  CodigoArticulo, { CodigoClaseA },  { CodigoClaseB },  { CodigoClaseC }, Descripcion, Cantidad, { Precio }

         CSVExtractParameters( DataLine, ListaParametros, ';' );

         Error := False;
         NroCampos := 3;  // Los indispensables : CodigoArticulo, Descripcion, Cantidad

         For var NroClase := tcClaseA to tcClaseC do
           If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( NroClase )
           then Inc( NroCampos )
           else Break;

         If   ListaParametros.Count<NroCampos
         then begin
              SessionDataModule.SendNotification( ntStop, RsMsg5, '' );
              Abort;
              end;

         NroColumna := 0;
         ExistePrecio := False;
         ExisteDescuento := FalsE;

         CodigoArticuloEntrada := ListaParametros.Strings[ NroColumna ];
         Inc( NroColumna );
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( tcClaseA )
         then begin
              CodigoClaseAEntrada := ListaParametros.Strings[ NroColumna ];
              Inc( NroColumna );
              end;
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( tcClaseB )
         then begin
              CodigoClaseBEntrada := ListaParametros.Strings[ NroColumna ];
              Inc( NroColumna );
              end;
         If   SessionDataModule.Dm30.ClaseModule.ClaseActiva( tcClaseC )
         then begin
              CodigoClaseCEntrada := ListaParametros.Strings[ NroColumna ];
              Inc( NroColumna );
              end;
         DescripcionEntrada := ListaParametros.Strings[ NroColumna ];
         Inc( NroColumna );
         CantidadEntrada := CSVFloat( ListaParametros.Strings[ NroColumna ] );
         Inc( NroColumna );

         If   ListaParametros.Count>NroColumna  // Es opcional
         then begin
              PrecioEntrada := CSVFloat( ListaParametros.Strings[ NroColumna ] );
              Inc( NroColumna );
              ExistePrecio := True;
              end;

         If   ListaParametros.Count>NroColumna  // Es opcional
         then begin
              DescuentoEntrada := CSVFloat( ListaParametros.Strings[ NroColumna ] );
              ExisteDescuento := True;
              end;

     finally
       ListaParametros.Free;
       end;
end;

begin

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmLineaMovimientoTable ] );

     try

       DataList := TStringList.Create;
       DataList.Text := ContenidoFichero;

       try

         For var DataLine in DataList do
           If   DataLine<>''
           then begin

               DesglosaLineaEntrada( DataLine );

               With DmLineaMovimientoFields do
                 begin

                 DmLineaMovimientoTable.Append;

                 Ejercicio.Value := Movimiento.Ejercicio;
                 NroOperacion.Value := Movimiento.NroOperacion;
                 NroPagina.Value := NroPaginaActual;
                 NroLinea.Value := UltimoNroLinea + LineIndex;
                 Fecha.Value := Movimiento.Fecha;
                 TipoMovimientoOrigen.Value := tmCapturador;

                 // Primero compruebo el código de barras, si no existe supongo que es un código de artículo normal

                 IncluirLinea := True;

                 If   not SessionDataModule.Dm30.ArticuloModule.CodigoBarras( CodigoArticuloEntrada,
                                                                              CodigoClaseAEntrada,
                                                                              CodigoClaseBEntrada,
                                                                              CodigoClaseCEntrada,
                                                                              FijarClases,
                                                                              DsArticuloFields )
                 then IncluirLinea := SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticuloEntrada, DsArticuloFields );

                 If   IncluirLinea
                 then begin

                      CodigoArticulo.Value := CodigoArticuloEntrada;
                      CodigoClaseA.Value := CodigoClaseAEntrada;
                      CodigoClaseB.Value := CodigoClaseBEntrada;
                      CodigoClaseC.Value := CodigoClaseCEntrada;

                      If   DescripcionEntrada=''
                      then Descripcion.Value := DsArticuloFields.Descripcion.Value
                      else Descripcion.Value := DescripcionEntrada;

                      CodigoAlmacen.Value := CodigoAlmacenDestino;

                      If   Movimiento.TipoMovimiento in [ tmInventario, tmOferta..tmCompra, tmEntrada ]
                      then begin

                           Cantidad.Value := CantidadEntrada;
                           CantidadAjustada.Value := CantidadEntrada;

                           If   ExistePrecio
                           then begin
                                Precio.Value := PrecioEntrada;
                                If   ExisteDescuento
                                then Descuento.Value := DescuentoEntrada;
                                end;

                           If   Movimiento.Propietario<>''
                           then begin
                                SessionDataModule.Dm10.ProveedorModule.Obten( Movimiento.Propietario, '', DsProveedorFields );
                                If   not ExistePrecio
                                then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields );
                                SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                                DsProveedorFields,
                                                                                                DsArticuloFields,
                                                                                                DsTiposIVAFields );
                                end
                           else begin
                                If   not ExistePrecio
                                then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, nil, DsArticuloFields );
                                SessionDataModule.Dm30.FacturaComprasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );
                                end

                           end
                      else begin

                           If   Movimiento.TipoMovimiento=tmVenta
                           then Cantidad.Value := -CantidadEntrada
                           else Cantidad.Value := CantidadEntrada;

                           CantidadAjustada.Value := CantidadEntrada;

                           // Se pueden importar datos del capturador desde albaranes de venta o desde movimientos de almacén

                           If   ExistePrecio
                           then begin
                                Precio.Value := PrecioEntrada;
                                If   ExisteDescuento
                                then Descuento.Value := DescuentoEntrada;
                                end;

                           If   Movimiento.Propietario<>''
                           then begin
                                SessionDataModule.Dm10.SerieFacturacionModule.Obten( Movimiento.Serie, DsSerieFacturacionFields );
                                SessionDataModule.Dm10.ClienteModule.Obten( Movimiento.Propietario, '', DsClienteFields );
                                If   not ExistePrecio
                                then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( Movimiento.TipoMovimiento, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields );
                                SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                               DsClienteFields,
                                                                                               DsArticuloFields,
                                                                                               DsSerieFacturacionFields,
                                                                                               DsTiposIVAFields,
                                                                                               Movimiento.IVAIncluido );
                                end
                           else begin
                                If   not ExistePrecio
                                then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( Movimiento.TipoMovimiento, DmLineaMovimientoFields, nil, DsArticuloFields );
                                SessionDataModule.Dm30.FacturaVentasModule.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );
                                end;

                           end;

                      DmLineaMovimientoTable.Post;

                      SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( Movimiento.TipoMovimiento,
                                                                                Movimiento.Serie,
                                                                                Movimiento.Propietario,
                                                                                DmLineaMovimientoFields,
                                                                                False );
                      Inc( LineIndex );
                      end
                 else DmLineaMovimientoTable.Cancel;

                 end;

               end;

             TransactionTag.Commit;

         except
           TransactionTag.RollBack;
           SessionDataModule.SendNotification( ntStop, Format( RsMsg3, [ 'del capturador' ] ), RsMsg4 );
           end;

     finally
       DmLineaMovimientoTable.Cancel;
       DataList.Free;
       end;

end;


function TMovimientoModule.GeneraPedidoCompra(       CodigoProveedor,
                                                     Serie            : String;
                                                     Fecha            : TDate;
                                               const LineList         : TLongIntArray ) : LongInt;

var   UltimoNroLinea,
      NroLineaActual,
      EjercicioActual : SmallInt;
      Index : SmallInt;
      NroOperacionActual,
      NroRegistroOrigen : LongInt;

begin

     Result := 0;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmLineaMovimientoTable ] );

     try

       DmLineaMovimientoOrigenTable.CancelRange;
       DmLineaMovimientoOrigenTable.IndexFieldNames := 'NroRegistro';

       SessionDataModule.Dm10.ProveedorModule.Obten( CodigoProveedor, DsProveedorFields );

       DmMovimientoTable.Append;

       DmMovimientoFields.TipoMovimiento.Value := tmPedidoCompra;
       DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmMovimientoFields.Serie.Value := Serie;
       DmMovimientoFields.Propietario.Value := CodigoProveedor;
       DmMovimientoFields.NroOperacion.Value := ProximaOperacion;
       DmMovimientoFields.NroDocumento.Value := ProximoDocumento( DmMovimientoFields );
       DmMovimientoFields.Fecha.Value := Fecha;
       DmMovimientoFields.Situacion.Value := epPendiente;
       DmMovimientoFields.Origen.Value := omAprovisionamiento;

       DmMovimientoTable.Post;

       NroLineaActual := 1;
       NroOperacionActual := 0;

       For Index := 0 to High( LineList ) do
         begin

         NroRegistroOrigen := LineList[ Index ];

         If   DmLineaMovimientoOrigenTable.FindKey( [ NroRegistroOrigen ] )
         then begin

              If   ( EjercicioActual<>DmLineaMovimientoOrigenFields.Ejercicio.Value ) or
                   ( NroOperacionActual<>DmLineaMovimientoOrigenFields.NroOperacion.Value )
              then If   DmMovimientoOrigenTable.FindKey( [ DmLineaMovimientoOrigenFields.Ejercicio.Value, DmLineaMovimientoOrigenFields.NroOperacion.Value ] )
                   then begin
                        EjercicioActual := DmMovimientoOrigenFields.Ejercicio.Value;
                        NroOperacionActual := DmMovimientoOrigenFields.NroOperacion.Value;
                        end
                   else begin
                        SessionDataModule.SendNotification( ntError, Format( RsMsg37, [ DmLineaMovimientoOrigenFields.NroOperacion.Value ] ) );
                        Abort;
                        end;

              DmLineaMovimientoTable.Append;

              DmLineaMovimientoTable.CopyFields( DmLineaMovimientoOrigenTable );

              DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
              DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
              DmLineaMovimientoFields.NroPagina.Value := 0;
              DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
              DmLineaMovimientoFields.NroRegistro.Clear;  // Para que se autoincremente
              DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
              DmLineaMovimientoFields.UIDArticulo.Value := DmLineaMovimientoOrigenFields.UIDArticulo.Value;

              DmLineaMovimientoFields.TipoMovimientoOrigen.Value := tmPedidoVenta;
              DmLineaMovimientoFields.EjercicioOrigen.Value := DmMovimientoOrigenFields.Ejercicio.Value;
              DmLineaMovimientoFields.NroOperacionOrigen.Value := DmMovimientoOrigenFields.NroOperacion.Value;
              DmLineaMovimientoFields.NroRegistroOrigen.Value := DmLineaMovimientoOrigenFields.NroRegistro.Value;

              DmLineaMovimientoFields.Cantidad.Value := DmLineaMovimientoOrigenFields.Cantidad.Value;
              DmLineaMovimientoFields.CantidadProcesada.Value := 0.0;

              SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

              SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, True );

              // El registro DsTiposIVAFields se obtiene en la misma función CalculaImportesIVA

              SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, DsTiposIVAFields );

              SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );

              DmLineaMovimientoTable.Post;

              Inc( NroLineaActual );
              end;

         end;

       CompruebaPrimerNroPagina( DmMovimientoFields );

       TransactionTag.Commit;

       Result := DmMovimientoFields.NroDocumento.Value;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       SessionDataModule.SendNotification( ntStop, RsMsg27 );
       Abort;
       end;
     end;

end;

function TMovimientoModule.ObtenImporteMovimiento(     Ejercicio          : SmallInt;
                                                       NroOperacion       : LongInt;
                                                   var ImporteBruto       : Decimal;
                                                   var DescuentosArticulo : Decimal;
                                                   var ImporteNeto        : Decimal ) : Boolean;
begin
     With DmMovimientoAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;NroOperacion';
       ImporteBruto := 0.0;
       DescuentosArticulo := 0.0;
       ImporteNeto := 0.0;
       Result := FindKey( [ Ejercicio, NroOperacion ] );
       If   Result
       then CalculaImporteMovimiento( DmMovimientoAuxFields, ImporteBruto, DescuentosArticulo, ImporteNeto );
       end;
end;

function TMovimientoModule.ObtenImporteMovimiento(     TipoMovimiento     : TTipoMovimiento;
                                                       Ejercicio          : SmallInt;
                                                       Serie              : String;
                                                       NroDocumento       : LongInt;
                                                   var ImporteBruto       : Decimal;
                                                   var DescuentosArticulo : Decimal;
                                                   var ImporteNeto        : Decimal ) : Boolean;
begin
     With DmMovimientoAuxTable do
       begin
       IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
       ImporteBruto := 0.0;
       DescuentosArticulo := 0.0;
       ImporteNeto := 0.0;
       Result := FindKey( [ TipoMovimiento, Ejercicio, Serie, NroDocumento ] );
       If   Result
       then CalculaImporteMovimiento( DmMovimientoAuxFields, ImporteBruto, DescuentosArticulo, ImporteNeto );
       end;
end;

{ TIDMovimiento ---------------------------}

constructor TIDMovimiento.Create( Ejercicio : SmallInt; NroOperacion : LongInt );
begin
     FEjercicio := Ejercicio;
     FNroOperacion := NroOperacion;
end;

// Aunque el procedimiento parece algo más complejo que la función SQL anterior (10.5), la diferencia de velocidad es tan grande
// que merece la pena (Test de ejemplo : 3500ms contra 22ms para 100 llamadas)

function TMovimientoModule.EntregasACuentaPedidosOrigen( Ejercicio    : SmallInt;
                                                         NroOperacion : LongInt;
                                                         Serie        : String;
                                                         NroFactura   : LongInt ) : Decimal;

var   ListaPedidosOrigen : TObjectList< TIDMovimiento >;

function ExisteMovimiento( Ejercicio    : SmallInt;
                           NroOperacion : LongInt ) : Boolean;
begin
     Result := False;
     For var IDMovimiento in ListaPedidosOrigen do
       If   ( IDMovimiento.FEjercicio=Ejercicio ) and
            ( IDMovimiento.FNroOperacion=NroOperacion )
       then begin
            Result := True;
            Break;
            end;
end;

begin

     Result := 0.0;

     If   NroOperacion<>0  // Se puede dar el caso
     then try

            ListaPedidosOrigen := TObjectList< TIDMovimiento >.Create;

            try

              DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';

              With DmLineaMovimientoAuxTable do
                begin
                IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                SetRange( [ Ejercicio, NroOperacion ] );
                try
                  First;
                  While not Eof do
                    begin
                    With DmLineaMovimientoAuxFields do
                      If   TipoMovimientoOrigen.Value=tmPedidoVenta
                      then If   not ExisteMovimiento( EjercicioOrigen.Value, NroOperacionOrigen.Value )
                           then ListaPedidosOrigen.Add( TIDMovimiento.Create( EjercicioOrigen.Value, NroOperacionOrigen.Value ) );
                    Next;
                    end;
                finally
                  CancelRange;
                  end;
                end;

              For var IDMovimiento in ListaPedidosOrigen do
                 If   DmMovimientoAuxTable.FindKey( [ IDMovimiento.FEjercicio, IDMovimiento.FNroOperacion ] )
                 then If   ( DmMovimientoAuxFields.NroFactura.Value=0 ) or ( ( DmMovimientoAuxFields.SerieFactura.Value=Serie ) and ( DmMovimientoAuxFields.NroFactura.Value=NroFactura ) )
                      then Result := Result + DmMovimientoAuxFields.EntregaACuenta.Value;

            finally
              ListaPedidosOrigen.Free;
              end;

          except
            end;

end;

procedure TMovimientoModule.ActualizaEstadoPedido( Procesado         : Boolean;
                                                   Situacion         : TSmallIntField;
                                                   CantidadPedido,
                                                   CantidadProcesada : Decimal );
begin
     If   Procesado
     then Situacion.Value := epProcesado
     else If   CantidadProcesada=0.0
          then Situacion.Value := epPendiente
          else If   CantidadPedido>CantidadProcesada
               then Situacion.Value := epParcialmenteProcesado
               else Situacion.Value := epProcesado;
end;

// Devuelve la cantidad procesada total

function TMovimientoModule.CambiaSituacionPedido( NroOperacion : LongInt;
                                                  Procesado    : Boolean ) : Decimal;

var   CantidadPedido,
      CantidadProcesada,
      CantidadRegularizar : Decimal;

begin

     CantidadPedido := 0.0;
     CantidadProcesada := 0.0;

     If   DmMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, NroOperacion ] )
     then try

            try

              DmMovimientoTable.Edit;  // Al principio, por si está bloqueado

              If   DmMovimientoFields.TipoMovimiento.Value=tmPedidoVenta
              then begin
                   SessionDataModule.Dm10.ClienteModule.Obten( DmMovimientoFields.Propietario.Value, '', DsClienteFields );
                   SessionDataModule.Dm10.SerieFacturacionModule.Obten( DMMovimientoFields.Serie.Value, DsSerieFacturacionFields );
                   end;

              DmLineaMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
              DmLineaMovimientoAuxTable.SetRange( [ SessionDataModule.Ejercicio, DmMovimientoFields.NroOperacion.Value, 0, 1 ], [ SessionDataModule.Ejercicio, DmMovimientoFields.NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

              DmLineaMovimientoAuxTable.First;
              While not DmLineaMovimientoAuxTable.Eof do
                begin

                // No toco las líneas regularizadas manualmente

                If   not DmLineaMovimientoAuxFields.Procesada.Value
                then begin

                     CantidadRegularizar := DmLineaMovimientoAuxFields.Cantidad.Value - DmLineaMovimientoAuxFields.CantidadProcesada.Value;

                     If   ( ( DmMovimientoFields.TipoMovimiento.Value=tmPedidoVenta ) and SessionDataModule.EmpresaFields.Ventas_RegularizarPedidosServidos.Value ) and Procesado
                     then begin

                          // Solo si es un pedido de venta y con Ventas_RegularizarPedidosServidos activado

                          DmLineaMovimientoAuxTable.Edit;
                          DmLineaMovimientoAuxFields.Cantidad.Value := DmLineaMovimientoAuxFields.CantidadProcesada.Value;
                          DmLineaMovimientoAuxFields.CantidadAjustada.Value := DmLineaMovimientoAuxFields.Cantidad.Value;
                          SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoAuxFields.CodigoArticulo.Value, DsArticuloFields );
                          SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( DmLineaMovimientoAuxFields,
                                                                                         DsClienteFields,
                                                                                         DsArticuloFields,
                                                                                         DsSerieFacturacionFields,
                                                                                         DsTiposIVAFields,
                                                                                         DmMovimientoFields.IVAIncluido.Value );
                          SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoAuxFields, True, CantidadRegularizar );
                          DmLineaMovimientoAuxTable.Post;
                          end
                     else begin

                          // Esta comprobación es importante, porque cuando el valor es cero, la función 'ActualizaStock' utiliza la cantidad de la línea

                          If   CantidadRegularizar<>0.0
                          then SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoAuxFields, Procesado, CantidadRegularizar );
                          end;

                      end;

                DecAdd( CantidadPedido, DmLineaMovimientoAuxFields.Cantidad.Value );
                DecAdd( CantidadProcesada, DmLineaMovimientoAuxFields.CantidadProcesada.Value );

                DmLineaMovimientoAuxTable.Next;
                end;

              ActualizaEstadoPedido( Procesado, DmMovimientoFields.Situacion, CantidadPedido, CantidadProcesada );

              DmMovimientoTable.Post;

            except
              DmMovimientoTable.Cancel;
              raise;
              end;

          finally
            DmLineaMovimientoAuxTable.CancelRange;
            Result := CantidadProcesada;
            end

     else begin
          SessionDataModule.SendNotification( ntWarning, Format( RsMsg39, [ NroOperacion ] ) );
          Abort;
          end;

end;

procedure TMovimientoModule.CalculaImporteMovimiento(     MovimientoFields   : TMovimientoFields;
                                                      var ImporteBruto       : Decimal;
                                                      var DescuentosArticulo : Decimal;
                                                      var ImporteNeto        : Decimal;
                                                          OnSumatorioLinea   : TSumatorioLineaEvent = nil );
begin
     With DmLineaMovimientoAuxTable do
       try

         Cancel;

         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallInt, MaxSmallInt ] );

         First;
         While not Eof do
           begin

           If   Assigned( OnSumatorioLinea )
           then OnSumatorioLinea( DmLineaMovimientoAuxFields );

           DecAdd( ImporteBruto, DmLineaMovimientoAuxFields.ImporteBruto.Value );
           DecAdd( DescuentosArticulo, DmLineaMovimientoAuxFields.ImporteDescuento.Value );
           DecAdd( ImporteNeto, DmLineaMovimientoAuxFields.ImporteNeto.Value );

           Next;
           end;

       finally
         CancelRange;
         end;

end;

procedure TMovimientoModule.InsertaVinculosCliente( MovimientoFields : TMovimientoFields;
                                                    ClienteFields    : TClienteFields );

var CodigoVendedor : String;

begin
     With SessionDataModule.EmpresaFields do
       begin

       If   Cliente_GruposFac.Value
       then MovimientoFields.GrupoFacturacion.Value := ClienteFields.Factura_Agrupacion.Value;

       If   Ventas_PagosPedido.Value
       then MovimientoFields.CodigoFormaCobro.Value := ClienteFields.Cobro_FormaCobro.Value;

       CodigoVendedor := SessionDataModule.Dm30.VendedorModule.VendedorPorDefecto( ClienteFields );
       MovimientoFields.CodigoVendedor.Value := CodigoVendedor;

       If   Ventas_Transportista.Value
       then MovimientoFields.CodigoTransportista.Value := ClienteFields.Envios_Transportista.Value;

       If   Ventas_FormaEnvio.Value
       then If   SessionDataModule.Dm30.FormaEnvioModule.Obten( ClienteFields.Envios_CodigoFormaEnvio.Value )
            then begin
                 MovimientoFields.FormaEnvio.Value := ClienteFields.Envios_CodigoFormaEnvio.Value;
                 var ImportePortes := 0.0;
                 If   not ValueIsEmpty( MovimientoFields.FormaEnvio.Value ) and
                      ( SessionDataModule.Dm30.FormaEnvioModule.DmFormaEnvioFields.Portes.Value=Ord( TipoPortes.feDebidos ) )
                 then ImportePortes := SessionDataModule.Dm30.FormaEnvioModule.DmFormaEnvioFields.Importe.Value;
                 MovimientoFields.Portes.Value := ImportePortes;
                 end
            else MovimientoFields.Portes.Value := 0.0;

       end;

end;

function TMovimientoModule.ObtenEnvaseLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                             EnvaseFields          : TClaseFields ) : Boolean;

var  NroClase : TNroClase;
     CodigoClase : String;

begin

     // Se trata de rellenar EnvaseFields con el contenido de la clase que se utiliza como envase

     Result := False;
     With SessionDataModule.EmpresaFields do
       If   Articulo_Envase.Value<>0
       then begin
            NroClase := TNroClase( Articulo_Envase.Value );
            CodigoClase := SessionDataModule.Dm30.ClaseModule.Selecciona( NroClase, LineaMovimientoFields );
            If   CodigoClase<>''
            then Result := SessionDataModule.Dm30.ClaseModule.Obten( NroClase, CodigoClase, EnvaseFields );
            end;

end;

function TMovimientoModule.ObtenContenedorLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                                 ContenedorFields      : TClaseFields ) : Boolean;

var  NroClase : TNroClase;
     CodigoClase : String;

begin
     Result := False;
     With SessionDataModule.EmpresaFields do
       If   Articulo_Envase.Value<>0
       then begin
            NroClase := TNroClase( Articulo_Envase.Value );
            CodigoClase := SessionDataModule.Dm30.ClaseModule.Selecciona( NroClase, LineaMovimientoFields );
            If   CodigoClase<>''
            then Result := SessionDataModule.Dm30.ClaseModule.Obten( NroClase, CodigoClase, ContenedorFields );
            end;
end;

procedure TMovimientoModule.ActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                                 LineaMovimientoFields  : TLineaMovimientoFields;
                                                                 ClienteFields          : TClienteFields;
                                                                 ArticuloFields         : TArticuloFields;
                                                                 SerieFacturacionFields : TSerieFacturacionFields;
                                                                 TiposIVAFields         : TTiposIVAFields );

procedure ActualizaValorCantidadVenta( Valor : Decimal );
begin
     LineaMovimientoFields.Cantidad.Value := -Valor;
     LineaMovimientoFields.CantidadAjustada.Value := Valor;
end;

var  EnvaseoContenedor : Boolean;

begin

     If   MovimientoFields.TipoMovimiento.Value=tmVenta
     then LineaMovimientoFields.CantidadAjustada.Value := -LineaMovimientoFields.Cantidad.Value
     else LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

     EnvaseOContenedor := False;

     LineaMovimientoFields.Peso.Value := 0.0;
     LineaMovimientoFields.Tara.Value := 0.0;

     With SessionDataModule.EmpresaFields do
       If   MovimientoFields.TipoMovimiento.Value=tmVenta
       then begin

            // En las cajas se introduce el número de envases de nivel primario (latas, botellas..)

            If   Articulo_Envase.Value<>0
            then If   ObtenEnvaseLinea( LineaMovimientoFields, DsContenedorFields )
                 then begin
                      EnvaseOContenedor := True;
                      case Articulo_TipoEnvase.Value of
                        tenReutilizable : begin
                                          LineaMovimientoFields.Peso.Value := LineaMovimientoFields.CantidadProcesada.Value;  // En este campo va el peso bruto
                                          LineaMovimientoFields.Tara.Value := LineaMovimientoFields.NroCajas.Value * LineaMovimientoFields.PesoEnvase.Value;   // Envases reutilizables
                                          ActualizaValorCantidadVenta( LineaMovimientoFields.CantidadProcesada.Value - LineaMovimientoFields.Tara.Value );
                                          end;
                        tenDesechable   : begin
                                          var Kilos := 1.0;
                                          If   ArticuloFields.Kilos.Value<>0.0
                                          then Kilos := ArticuloFields.Kilos.Value;
                                          LineaMovimientoFields.Peso.Value := ( LineaMovimientoFields.CantidadAjustada.Value * Kilos ) +
                                                                              ( LineaMovimientoFields.NroCajas.Value * LineaMovimientoFields.PesoEnvase.Value );
                                          end;
                        end;

                      // La contribución RAP es el importe total por línea. Si se desea obtener el importe por unidad hay que dividirlo por el número de cajas.

                      var TarifaRAP := IfThen( ArticuloFields.Peligroso.Value, DsContenedorFields.TarifaRAPPeligroso.Value, DsContenedorFields.TarifaRAPNormal.Value );
                      LineaMovimientoFields.ContribucionRAP.Value := Redondea( DsContenedorFields.Peso.Value * TarifaRAP * LineaMovimientoFields.NroCajas.Value, 4 );

                      end;

            // En los bultos se introduce el número de envases de nivel secundario (pallets, contenedores.. )

            If   Articulo_Contenedor.Value<>0
            then If   ObtenContenedorLinea( LineaMovimientoFields, DsContenedorFields )
                 then begin
                      EnvaseOContenedor := True;
                      case Articulo_TipoContenedor.Value of
                        tenReutilizable : begin
                                          LineaMovimientoFields.Tara.Value := LineaMovimientoFields.Tara.Value + ( LineaMovimientoFields.Bultos.Value * DsContenedorFields.Peso.Value );
                                          ActualizaValorCantidadVenta( LineaMovimientoFields.CantidadProcesada.Value - LineaMovimientoFields.Tara.Value );
                                          end;
                        tenDesechable   : begin
                                          var NroBultos := 1.0;
                                          If   LineaMovimientoFields.Bultos.Value<>0.0
                                          then NroBultos := LineaMovimientoFields.Bultos.Value;
                                          LineaMovimientoFields.Peso.Value := LineaMovimientoFields.Peso.Value + ( NroBultos * DsContenedorFields.Peso.Value );
                                          end;
                        end;
                      end;
            end;

     If   not EnvaseOContenedor
     then LineaMovimientoFields.Peso.Value := LineaMovimientoFields.CantidadAjustada.Value * ArticuloFields.Kilos.Value;

     If   OnActualizaCamposCalculadosLineaVenta.CanInvoke
     then OnActualizaCamposCalculadosLineaVenta.Invoke( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );

     SessionDataModule.Dm30.FacturaVentasModule.CalculaImportesIVA( LineaMovimientoFields,
                                                                    ClienteFields,
                                                                    ArticuloFields,
                                                                    SerieFacturacionFields,
                                                                    TiposIVAFields,
                                                                    MovimientoFields.IVAIncluido.Value );

end;

function TMovimientoModule.ExportaDocumento(       MovimientoOrigen         : IMovimiento;
                                                   TipoMovimientoDestino    : TTipoMovimiento;
                                                   CodigoPropietario,
                                                   Serie                    : String;
                                                   NroDocumento             : LongInt;
                                             const LineList                 : TLongIntArray = nil;   // Si está asignada se copian solo las líneas indicadas, en caso contrario se copian todas
                                                   SoloCantidadesPendientes : Boolean = False;
                                                   DocumentoAutomatico      : Boolean = False;
                                                   CopiarDatosCabecera      : Boolean = False ) : IMovimiento;

var  OrigenEnCompras,
     OrigenEnVentas,
     DestinoEnCompras,
     DestinoEnVentas,

     ExportandoPedidoAAlbaran,
     ExportandoCantidadesPendientes,

     InsertarLinea,
     HayMovimientos : Boolean;
     Existencias,
     CantidadACopiar,
     ImporteBrutoTotal,
     DescuentosArticuloTotal,
     ImporteNetoTotal : Decimal;
     NroLineaActual : SmallInt;
     TextoOperacion : String;

procedure ProcesaPagina( NroPagina : SmallInt );
begin
     With DmLineaMovimientoOrigenTable do
       try
         SetRange( [ MovimientoOrigen.Ejercicio, MovimientoOrigen.NroOperacion, NroPagina ] );
         First;
         While not Eof do
           begin

           {
           If   DmLineaMovimientoOrigenFields.Procesada.Value
           then CantidadACopiar := 0.0
           else CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value - DmLineaMovimientoOrigenFields.CantidadProcesada.Value;

           If   ExportandoPedidoAAlbaran
           then InsertarLinea :=  ( Abs( CantidadACopiar )>0.0 ) or ( DmLineaMovimientoOrigenFields.Cantidad.Value<=0.0 )
           else InsertarLinea := True;
           }

           CantidadACopiar := 0.0;

           SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoOrigenFields.CodigoArticulo.Value, DsArticuloFields );

           case TipoMovimientoDestino of

             tmPresupuesto,
             tmPedidoventa,
             tmVenta  :
               begin

               If   ( TipoMovimientoDestino=tmVenta ) and ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta )
               then begin
                    If   not DmLineaMovimientoOrigenFields.Procesada.Value
                    then CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value - DmLineaMovimientoOrigenFields.CantidadProcesada.Value;
                    end
               else CantidadACopiar := DecSign( DmLineaMovimientoOrigenFields.Cantidad.Value, MovimientoOrigen.TipoMovimiento<>tmVenta );

               If   CantidadACopiar<>0.0
               then With SessionDataModule.EmpresaFields do
                      If   ( TipoMovimientoDestino=tmVenta ) and
                           Stock_ImpSalidasSinStock.Value and
                           not DsArticuloFields.NoAfectarStock.Value and
                           ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value<>ArticuloManual )
                      then begin
                           Existencias := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock(  DmLineaMovimientoOrigenFields.CodigoArticulo.Value,
                                                                                                 not Articulo_ExisteClase[ tcClaseA ].Value,
                                                                                                 DmLineaMovimientoOrigenFields.CodigoClaseA.Value,
                                                                                                 DmLineaMovimientoOrigenFields.CodigoClaseB.Value,
                                                                                                 DmLineaMovimientoOrigenFields.CodigoClaseC.Value,
                                                                                                 ( DmLineaMovimientoOrigenFields.LoteFabricacion.Value='' ) or not Stock_LotesProductos.Value,
                                                                                                 DmLineaMovimientoOrigenFields.LoteFabricacion.Value,
                                                                                                 not Stock_MultiAlmacen.Value,
                                                                                                 DmLineaMovimientoOrigenFields.CodigoAlmacen.Value,
                                                                                                 not Stock_Ubicaciones.Value,
                                                                                                 DmLineaMovimientoOrigenFields.Ubicacion.Value,
                                                                                                 False,
                                                                                                 SessionDataModule.Ejercicio,
                                                                                                 0,
                                                                                                 12 ).SumaExistencias.Saldo;
                           If   Existencias<CantidadACopiar
                           then CantidadACopiar := Existencias;

                           If   CantidadACopiar<=0.0
                           then CantidadACopiar := 0.0;

                           end;

               end;

             tmOferta,
             tmPedidoCompra,
             tmCompra :
               begin

               If   ( TipoMovimientoDestino=tmCompra ) and ( MovimientoOrigen.TipoMovimiento=tmPedidoCompra )
               then begin
                    If   not DmLineaMovimientoOrigenFields.Procesada.Value
                    then CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value - DmLineaMovimientoOrigenFields.CantidadProcesada.Value;
                    end
               else CantidadACopiar := DecSign( DmLineaMovimientoOrigenFields.Cantidad.Value, MovimientoOrigen.TipoMovimiento<>tmVenta );

               If   FModuloHojasDePedido and ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta )
               then try
                      DmLineaMovimientoOrigenTable.Edit;
                      DmLineaMovimientoOrigenFields.Parametros.Value := SetBit( DmLineaMovimientoOrigenFields.Parametros.Value, 0 );  // Indico que ha sido exportada a un pedido de compras
                      DmLineaMovimientoOrigenTable.Post;
                    except
                      DmLineaMovimientoOrigenTable.Cancel;
                      raise;
                      end;

               end

             else CantidadACopiar := DmLineaMovimientoOrigenFields.Cantidad.Value;

             end;

           If   ( CantidadACopiar<>0.0 ) or
                ( DmLineaMovimientoOrigenFields.CodigoArticulo.Value=ArticuloManual ) or
                ( DmLineaMovimientoOrigenFields.Cantidad.Value=0.0 ) or
                ( DsArticuloFields.NoAfectarStock.Value )
           then With DmLineaMovimientoTable do
                  begin

                  Append;

                  CopyFields( DmLineaMovimientoOrigenTable );

                  DmLineaMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                  DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                  DmLineaMovimientoFields.NroRegistro.Clear;  // Para que se autoincremente
                  DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                  DmLineaMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.FechaAplicacion.Value;

                  If   DestinoEnCompras
                  then begin
                       DmLineaMovimientoFields.NroPagina.Value := 0;  // Los documentos de compra no están paginados
                       DmLineaMovimientoFields.NroLinea.Value := NroLineaActual;
                       Inc( NroLineaActual );
                       end;

                  DmLineaMovimientoFields.TipoMovimientoOrigen.Value := MovimientoOrigen.TipoMovimiento;
                  DmLineaMovimientoFields.EjercicioOrigen.Value := MovimientoOrigen.Ejercicio;
                  DmLineaMovimientoFields.NroOperacionOrigen.Value := MovimientoOrigen.NroOperacion;
                  DmLineaMovimientoFields.NroRegistroOrigen.Value := DmLineaMovimientoOrigenFields.NroRegistro.Value;

                  DmLineaMovimientoFields.Cantidad.Value := DecSign( CantidadACopiar, TipoMovimientoDestino<>tmVenta );

                  DmLineaMovimientoFields.CantidadProcesada.Value := 0.0;

                  // Si el documento que se exporta no pertenece al propietario, es también una simple copia, no una exportación

                  If   DmMovimientoFields.Propietario.Value<>MovimientoOrigen.Propietario
                  then DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

                  DmLineaMovimientoFields.CantidadAjustada.Value := DecSign( DmLineaMovimientoFields.Cantidad.Value, { Positive } TipoMovimientoDestino<>tmVenta );

                  // Si el tipo de documento destino es de compra y el origen de ventas, o viceversa, hay que recalcular los precios

                  If   OrigenEnVentas and DestinoEnCompras
                  then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoCompra( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, True )
                  else If   OrigenEnCompras and DestinoEnVentas
                       then SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( TipoMovimientoDestino, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields, True );

                  If   DestinoEnCompras
                  then SessionDataModule.Dm30.FacturaComprasModule.CalculaImportesIVA( DmLineaMovimientoFields,
                                                                                       DsProveedorFields,
                                                                                       DsArticuloFields,
                                                                                       DsTiposIVAFields )

                  // La función ActualizaCamposCalculadosLineaVenta acaba llamando a CalculaImportesIVA

                  else SessionDataModule.Dm30.MovimientoModule.ActualizaCamposCalculadosLineaVenta( DmMovimientoFields,
                                                                                                    DmLineaMovimientoFields,
                                                                                                    DsClienteFields,
                                                                                                    DsArticuloFields,
                                                                                                    DsSerieFacturacionFields,
                                                                                                    DsTiposIVAFields );


                  SessionDataModule.Dm30.StockAlmacenModule.ActualizaStock( DmMovimientoFields, DmLineaMovimientoFields );
                  If   ExportandoPedidoAAlbaran
                  then RegularizaLineaPedido( DmMovimientoFields, DmLineaMovimientoFields, False, False );

                  HayMovimientos := True;
                  Post;

                  end;

           Next;
           end;

       finally
         DmLineaMovimientoOrigenTable.CancelRange;
         end;

end;

begin

     // El documento origen debe estar desbloqueado para que pueda ser editado por Movimiento.RegularizaLineaPedido (puede cambiar la situación del pedido)

     Result := nil;

     If   MovimientoOrigen.Anulado
     then begin
          SessionDataModule.SendNotification( ntStop, RsMsg43 );
          Exit;
          end;

     OrigenEnCompras := MovimientoOrigen.TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ];
     DestinoEnCompras := TipoMovimientoDestino in [ tmOferta, tmPedidoCompra, tmCompra ];
     OrigenEnVentas :=  MovimientoOrigen.TipoMovimiento in [ tmPresupuesto, tmPedidoVenta, tmVenta ];
     DestinoEnVentas := TipoMovimientoDestino in [ tmPresupuesto, tmPedidoVenta, tmVenta ];

     ExportandoPedidoAAlbaran := ( ( MovimientoOrigen.TipoMovimiento=tmPedidoCompra ) and ( TipoMovimientoDestino=tmCompra ) ) or
                                 ( ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta ) and ( TipoMovimientoDestino=tmVenta ) );

     ExportandoCantidadesPendientes := ExportandoPedidoAAlbaran or SoloCantidadesPendientes;

     If   ExportandoPedidoAAlbaran
     then If   MovimientoOrigen.Situacion=epProcesado
          then begin
               If   OrigenEnCompras
               then TextoOperacion := RsMsg10
               else TextoOperacion := RsMsg11;
               SessionDataModule.SendNotification( ntStop, Format( RsMsg40, [ TextoOperacion ] ), RsMsg44 );
               Exit;
               end;

     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmGrupoLineaMovimientoTable, DmLineaMovimientoTable ] );

     try

       DmLineaMovimientoOrigenTable.CancelRange;
       DmLineaMovimientoOrigenTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

       DmMovimientoTable.Cancel;  // Me aseguro de que no está en uso
       MovimientoOrigen.ToDataset( DmMovimientoFields );

       DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmMovimientoFields.TipoMovimiento.Value := TipoMovimientoDestino;
       DmMovimientoFields.NroOperacion.Value := ProximaOperacion;

       If   DestinoEnVentas or ( TipoMovimientoDestino=tmCompra )   // Los albaranes de compra tienen serie diferenciada (en la sección comercial)
       then DmMovimientoFields.Serie.Value := Serie
       else DmMovimientoFields.Serie.Value := '';

       DmMovimientoFields.Fecha.Value := SessionDataModule.FechaHoy;
       DmMovimientoFields.Propietario.Value := CodigoPropietario;
       DmMovimientoFields.Creado.Value := Now;

       If   DocumentoAutomatico
       then DmMovimientoFields.NroDocumento.Value := ProximoDocumento( DmMovimientoFields )
       else DmMovimientoFields.NroDocumento.Value := NroDocumento;

       If   DestinoEnCompras
       then SessionDataModule.Dm10.ProveedorModule.Obten( CodigoPropietario, DsProveedorFields )
       else begin
            SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie, DsSerieFacturacionFields );
            SessionDataModule.Dm10.ClienteModule.Obten( CodigoPropietario, DsClienteFields );
            end;

       If   ( OrigenEncompras and DestinoEnVentas ) or   // Limpiando los campos que no deben copiarse entre secciones
            ( OrigenEnVentas and DestinoEnCompras )
       then begin
            DmMovimientoFields.GrupoFacturacion.Clear;
            DmMovimientoFields.RegistroAuxiliar.Clear;
            DmMovimientoFields.CodigoVendedor.Clear;
            DmMovimientoFields.FormaEnvio.Clear;
            DmMovimientoFields.NroDocumentoPropietario.Clear;
            DmMovimientoFields.CodigoTransportista.Clear;
            DmMovimientoFields.Portes.Clear;
            DmMovimientoFields.CodigoFormaCobro.Clear;
            DmMovimientoFields.OrganismoPublico.Clear;
            DmMovimientoFields.DescripcionMovimiento.Clear;
            For var Icl := 1 to 5 do
               DmMovimientoFields.CampoLibre[ Icl ].Clear;
            DmMovimientoFields.TipoVentaPeriodica.Clear;
            end;

       If   OrigenEnCompras and DestinoEnVentas
       then begin
            // Se mantiene la fecha de recepción como fecha de entrega por petición de los clientes (en concreto empresas hortofrutícolas)
            // Antes : DmMovimientoFields.FechaAplicacion.Value := SessionDataModule.Fecha;
            InsertaVinculosCliente( DmMovimientoFields, DsClienteFields );
            end
       else If   OrigenEnVentas and ( TipoMovimientoDestino=tmPedidoCompra )
            then DmMovimientoFields.FechaAplicacion.Value := SessionDataModule.FechaHoy
            else If   ( MovimientoOrigen.TipoMovimiento=tmPresupuesto ) and ( TipoMovimientoDestino=tmPedidoVenta )
                 then DmMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.Fecha.Value;

       DmMovimientoFields.EjercicioFactura.Clear;
       DmMovimientoFields.PropietarioFactura.Clear;
       DmMovimientoFields.SerieFactura.Clear;
       DmMovimientoFields.NroFactura.Clear;
       DmMovimientoFields.Facturado.Value := False;
       DmMovimientoFields.Traspasado.Value := False;
       DmMovimientoFields.Origen.Value := omManual;
       DmMovimientoFields.Situacion.Value := epPendiente;
       DmMovimientoFields.EntregaACuenta.Value := 0.0;   // Las entregas a cuenta y en efectivo no se pasan de un documento a otro
       DmMovimientoFields.EntregaEfectivo.Value := 0.0;
       DmMovimientoFields.Revisado.Value := False;
       DmMovimientoFields.Suministrado.Value := False;
       DmMovimientoFields.FechaEnvioPorCorreo.Clear;
       DmMovimientoFields.Firma.Clear;

       If   CopiarDatosCabecera and ( MovimientoOrigen.TipoMovimiento=tmPedidoVenta ) and  ( TipoMovimientoDestino=tmPedidoCompra )
       then For var Inx := Low( DmMovimientoFields.CampoLibre ) to High( DmMovimientoFields.CampoLibre ) do
              If   not VarIsNull( MovimientoOrigen.CampoLibre[ Inx ] )
              then DmMovimientoFields.CampoLibre[ Inx ].Value := MovimientoOrigen.CampoLibre[ Inx ];

       HayMovimientos := False;
       NroLineaActual := 1;  // Para la exportación a pedidos de compra (sin páginas)

       If   Assigned( LineList )
       then HayMovimientos := CopiaLineasMovimiento( MovimientoOrigen, DmMovimientoFields, LineList, False, False )
       else If   OrigenEnVentas
            then With DmGrupoLineaMovimientoOrigenTable do
                   try
                     DmGrupoLineaMovimientoTable.Cancel;
                     SetRange( [ MovimientoOrigen.Ejercicio, MovimientoOrigen.NroOperacion ] );
                     First;
                     While not Eof do
                       begin

                       // Ejercicio;NroOperacion;NroPagina

                       If   not DmGrupoLineaMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, DmMovimientoFields.NroOperacion.Value, DmGrupoLineaMovimientoOrigenFields.NroPagina.Value ] )
                       then With DmGrupoLineaMovimientoTable do
                              begin
                              Append;
                              CopyFields( DmGrupoLineaMovimientoOrigenTable );
                              DmGrupoLineaMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                              DmGrupoLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                              Post;
                              end;

                       ProcesaPagina( DmGrupoLineaMovimientoFields.NroPagina.Value );

                       Next;
                       end;
                   finally
                     CancelRange;
                     end
            else ProcesaPagina( 0 );

       If   HayMovimientos
       then begin

            // Para evitar que se actualice la situación del pedido en cada línea se ha desactivado el proceso en las líneas y
            // se realiza ahora, cuando ha finalizado la copia. Eso puede hacerse porque el documento origen es único.

            If   ExportandoPedidoAAlbaran
            then ActualizaSituacionPedido( MovimientoOrigen.Ejercicio, MovimientoOrigen.NroOperacion );

            With DmMovimientoFields do
              begin
              ObtenImporteMovimiento( Ejercicio.Value, NroOperacion.Value, ImporteBrutoTotal, DescuentosArticuloTotal, ImporteNetoTotal );
              If   TipoMovimiento.Value=tmVenta
              then SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( Ejercicio.Value, Propietario.Value, ImporteNetoTotal );

              If   ExisteNroDocumento( TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, NroDocumento.Value )
              then begin
                   SessionDataModule.SendNotification( ntStop, RsMsg41, RsMsg42 );
                   Abort;
                   end
              else begin
                   DmMovimientoTable.Post;
                   If   DocumentoAutomatico
                   then RetiraDocumento( DmMovimientoFields, False );
                   end;

              end;

            If   DestinoEnVentas
            then CompruebaPrimerNroPagina( DmMovimientoFields );

            Result := TMovimiento.FromDataset( DmMovimientoFields );

            // Si estoy exportando un presupuesto he de suponer que es porque ha sido aceptado

            If   ( MovimientoOrigen.TipoMovimiento=tmPresupuesto ) and ( TipoMovimientoDestino in [ tmPedidoVenta, tmVenta ] )
            then If   DmMovimientoTable.FindKey( [ SessionDataModule.Ejercicio, MovimientoOrigen.NroOperacion ] )
                 then try
                        DmMovimientoTable.Edit;
                        DmMovimientoFields.Situacion.Value := eprAceptado;
                        DmMovimientoTable.Post;
                      except
                        DmMovimientoTable.Cancel;
                        raise;
                        end;

            end
       else SessionDataModule.SendNotification( ntWarning, RsMsg48, RsMsg49 );

       TransactionTag.Commit;

     except on E : Exception do
       begin
       TransactionTag.Rollback;
       SessionDataModule.SendDatabaseError( nil, E );
       SessionDataModule.SendNotification( ntStop, RsMsg45 );
       HayMovimientos := False;
       end;

     end;

end;

function TMovimientoModule.CalculoEspecial( Seccion  : TSeccionComercial;
                                            Largo,
                                            Ancho,
                                            Alto     : Decimal ) : Decimal;

var  Calculo,
     Cantidades : SmallInt;

function Multiplo6( Valor : Decimal ) : Decimal;

var   ValorEntero   : LongInt;

begin
     ValorEntero := Trunc( Valor / 6 );
     If   ( ( Valor / 6 ) - ValorEntero )=0
     then Result := Valor
     else begin
          Inc( ValorEntero );
          Result := ValorEntero * 6;
          end;
end;

begin

     Result := 0.0;

     If   Seccion=scCompras
     then begin
          Calculo := SessionDataModule.EmpresaFields.Compras_Calculo.Value;
          Cantidades := SessionDataModule.EmpresaFields.Compras_Cantidades.Value;
          end
     else begin
          Calculo := SessionDataModule.EmpresaFields.Ventas_Calculo.Value;
          Cantidades := SessionDataModule.EmpresaFields.Ventas_Cantidades.Value;
          end;

     case Calculo of
       0 : case Cantidades of                                                                       { Normal  }
             1 : Result := Largo * Ancho;
             2 : Result := Largo * Ancho * Alto;
             end;
       1 : case Cantidades of                                                                       { Cristal }
             1 : Result := Largo * Ancho;
             2 : If   Ancho=0.0
                 then Result := ( Largo * Alto ) * 0.01
                 else Result := ( Multiplo6( Largo ) * Multiplo6( Ancho ) * Alto ) * 0.0001;
             end;
       end;

end;

{ TMovimientoService }

procedure TMovimientoService.ActualizaMovimiento( Movimiento: IMovimiento);
begin
     SessionDataModule.Dm30.MovimientoModule.ActualizaMovimiento( Movimiento );
end;

procedure TMovimientoService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TMovimientoService.CopiaMovimiento( EjercicioOrigen        : SmallInt;
                                             NroOperacionOrigen     : LongInt;
                                             TipoMovimientoDestino  : TTipoMovimiento;
                                             PropietarioDestino     : String;
                                             SerieDestino           : String;
                                             ModificarAlmacen       : Boolean;
                                             AlmacenDestino         : String = '';
                                             AsignarUbicaciones     : Boolean = False;
                                             InvertirCantidades     : Boolean = False;
                                             BorrarMovimientoOrigen : Boolean = False;
                                             ActualizarPrecios      : Boolean = False;
                                             NroDocumentoDestino    : Integer = 0   ) : LongInt;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.CopiaMovimiento( EjercicioOrigen, NroOperacionOrigen, TipoMovimientoDestino, PropietarioDestino, SerieDestino, ModificarAlmacen, AlmacenDestino, AsignarUbicaciones, InvertirCantidades, BorrarMovimientoOrigen, ActualizarPrecios, NroDocumentoDestino );
end;

function TMovimientoService.ObtenCosteUltimaEntradaPorLote(     Fecha             : TDate;
                                                                CodigoArticulo,
                                                                CodigoClaseA,
                                                                CodigoClaseB,
                                                                CodigoClaseC,
                                                                LoteFabricacion   : String;
                                                                NroRegistroLinea  : LongInt;
                                                            out Precio            : Decimal;
                                                            out NroRegistroOrigen : LongInt ) : Boolean;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.ObtenCosteUltimaEntradaPorLote( Fecha, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion, NroRegistroLinea, Precio, NroRegistroOrigen );
end;

procedure TMovimientoService.ActivaHojasDePedido;
begin
     SessionDataModule.Dm30.MovimientoModule.ActivaHojasDePedido;
end;

procedure TMovimientoService.ImportaDatosCapturador( Movimiento           : IMovimiento;
                                                     ContenidoFichero     : String;
                                                     NroPaginaActual,
                                                     UltimoNroLinea       : SmallInt;
                                                     CodigoAlmacenDestino : String );
begin
     SessionDataModule.Dm30.MovimientoModule.ImportaDatosCapturador( Movimiento, ContenidoFichero, NroPaginaActual, UltimoNroLinea, CodigoAlmacenDestino );
end;

function TMovimientoService.DarLineaPorProcesada( NroOperacion   : LongInt;
                                                  TipoMovimiento : TTipoMovimiento;
                                                  Serie,
                                                  Propietario    : String;
                                                  NroPagina,
                                                  NroLinea       : SmallInt ) : Decimal;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.DarLineaPorProcesada( NroOperacion, TipoMovimiento, Serie, Propietario, NroPagina, NroLinea );
end;

procedure TMovimientoService.InsertaLineasDocumento(       MovimientoOrigen,
                                                           MovimientoDestino    : IMovimiento;
                                                     const LineList             : TLongIntArray;
                                                           CopiarDatosCabecera,
                                                           NoVincularDocumentos : Boolean);
begin
     SessionDataModule.Dm30.MovimientoModule.InsertaLineasDocumento( MovimientoOrigen, MovimientoDestino, LineList, CopiarDatosCabecera, NoVincularDocumentos );
end;

function TMovimientoService.ProximaOperacion(Ejercicio: SmallInt): LongInt;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion( Ejercicio );
end;

function TMovimientoService.ProximoDocumento(TipoMovimiento: TTipoMovimiento; Ejercicio: SmallInt; Propietario, Serie: String; RegistrarValor: Boolean ) : LongInt;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( TipoMovimiento, Ejercicio, Propietario, Serie, RegistrarValor );
end;

function TMovimientoService.EntregasACuentaPedidosOrigen( Ejercicio    : SmallInt;
                                                          NroOperacion : LongInt;
                                                          Serie        : String;
                                                          NroFactura   : LongInt ): Decimal;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.EntregasACuentaPedidosOrigen( Ejercicio, NroOperacion, Serie, NroFactura );
end;

function TMovimientoService.CambiaSituacionPedido( NroOperacion : LongInt;
                                                   Procesado    : Boolean ) : Decimal;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.CambiaSituacionPedido( NroOperacion, Procesado );
end;

function TMovimientoService.ExportaDocumento(      MovimientoOrigen         : IMovimiento;
                                                   TipoMovimientoDestino    : TTipoMovimiento;
                                                   CodigoPropietario,
                                                   Serie                    : String;
                                                   NroDocumento             : LongInt;
                                             const LineList                 : TLongIntArray = nil;
                                                   SoloCantidadesPendientes : Boolean = False;
                                                   DocumentoAutomatico      : Boolean = False;
                                                   CopiarDatosCabecera      : Boolean = False ) : IMovimiento;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.ExportaDocumento( MovimientoOrigen, TipoMovimientoDestino, CodigoPropietario, Serie, NroDocumento, LineList, SoloCantidadesPendientes, DocumentoAutomatico, CopiarDatosCabecera );
end;

function TMovimientoService.GeneraPedidoCompra( CodigoProveedor, Serie : String; Fecha: TDate; const LineList: TLongIntArray) : LongInt;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.GeneraPedidoCompra( CodigoProveedor, Serie, Fecha, LineList );
end;

procedure TMovimientoService.ActualizaLineaMovimiento( RemoteCursorID    : TnxCursorID;
                                                       TipoMovimiento    : TTipoMovimiento;
                                                       Serie,
                                                       Propietario       : String;
                                                       LineaMovimiento   : ILineaMovimiento;
                                                       CompruebaVinculos : Boolean = True );
begin
     SessionDataModule.Dm30.MovimientoModule.ActualizaLineaMovimiento( RemoteCursorID, TipoMovimiento, Serie, Propietario, LineaMovimiento, CompruebaVinculos );
end;

procedure TMovimientoService.SuprimeLineaMovimiento( RemoteCursorID : TnxCursorID;
                                                     Ejercicio      : SmallInt;
                                                     NroOperacion   : LongInt;
                                                     NroPagina,
                                                     NroLinea       : SmallInt;
                                                     TipoMovimiento : TTipoMovimiento;
                                                     Serie,
                                                     Propietario    : String );
begin
     SessionDataModule.Dm30.MovimientoModule.SuprimeLineaMovimiento( RemoteCursorID, Ejercicio, NroOperacion, NroPagina, NroLinea, TipoMovimiento, Serie, Propietario );
end;

procedure TMovimientoService.DesplazaLineaMovimiento( Ejercicio    : SmallInt;
                                                      NroOperacion : LongInt;
                                                      NroPagina,
                                                      NroLinea     : SmallInt;
                                                      HaciaArriba  : Boolean = False;
                                                      HastaElFinal : Boolean = False );
begin
     SessionDataModule.Dm30.MovimientoModule.DesplazaLineaMovimiento( Ejercicio, NroOperacion, NroPagina, NroLinea, HaciaArriba, HastaElFinal );
end;

function TMovimientoService.SuprimeMovimiento( Ejercicio: SmallInt; NroOperacion: LongInt; PreservaCabecera : Boolean = False ) : Boolean;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.SuprimeMovimiento( Ejercicio, NroOperacion, PreservaCabecera );
end;

function TMovimientoService.SuprimeVinculosConPedidos( NroOperacion : LongInt;
                                                       NroPagina    : SmallInt ) : Boolean;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.SuprimeVinculosConPedidos( NroOperacion, NroPagina );
end;

function TMovimientoService.VincularAlbaranAPedido( NroOperacionAlbaran : LongInt;
                                                    NroPagina           : SmallInt;
                                                    EjercicioPedido     : SmallInt;
                                                    NroOperacionPedido  : LongInt ) : Boolean;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.VincularAlbaranAPedido( NroOperacionAlbaran, NroPagina, EjercicioPedido, NroOperacionPedido );
end;

function TMovimientoService.SuprimeMovimiento( RemoteCursorID : TnxCursorID;
                                               Ejercicio      : SmallInt;
                                               NroOperacion   : LongInt ): Boolean;
begin
     Result := SessionDataModule.Dm30.MovimientoModule.SuprimeMovimiento( RemoteCursorID, Ejercicio, NroOperacion );
end;

// Servicios Web

class function TMovimientoModule.CreaPedidoTiendaWs( SessionDataModule : TBaseSessionDataModule;
                                                     DataIn,
                                                     DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then Result := TSessionDataModule( SessionDataModule ).Dm30.MovimientoModule.CreaPedidoTienda( DataIn, DataOut )
     else Result := False;
end;

class function TMovimientoModule.ObtenPedidosTiendaWs( SessionDataModule : TBaseSessionDataModule;
                                                       DataIn,
                                                       DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then Result := TSessionDataModule( SessionDataModule ).Dm30.MovimientoModule.ObtenPedidosTienda( DataIn, DataOut )
     else Result := False;
end;

class function TMovimientoModule.ObtenDetallePedidoTiendaWs( SessionDataModule : TBaseSessionDataModule;
                                                             DataIn,
                                                             DataOut           : IsgcJSON ) : Boolean;
begin
     If   Assigned( SessionDataModule )
     then Result := TSessionDataModule( SessionDataModule ).Dm30.MovimientoModule.ObtenDetallePedidoTienda( DataIn, DataOut )
     else Result := False;
end;

function TMovimientoModule.CreaPedidoTienda( DataIn, DataOut : IsgcJSON ) : Boolean;

var  EMailCliente,
     ComentariosPedido : String;
     LineasPedidoArray : IsgcJSON;

begin

     Result := False;

     try

       var LoadoutObject := GetNodeObject( DataIn, 'loadout' );
       If   Assigned( LoadoutObject )
       then begin

            EMailCliente := GetNodeValue( LoadoutObject, 'eMailCliente', '' );
            ComentariosPedido := GetNodeValue( LoadoutObject, 'comentarios', '' );
            LineasPedidoArray := GetNodeObject( LoadoutObject, 'lineasPedido' );

            If   Assigned( LineasPedidoArray )
            then If   SessionDataModule.Dm10.ClienteModule.ObtenPorEMail( EMailCliente, DsClienteFields )
                 then begin

                      var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable, DmLineaMovimientoTable ] );

                      try

                        SessionDataModule.Dm10.SerieFacturacionModule.Obten( DmMovimientoFields.Serie.Value, DsSerieFacturacionFields );

                        DmMovimientoTable.Append;

                        DmMovimientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                        DmMovimientoFields.NroOperacion.Value := SessionDataModule.Dm30.MovimientoModule.ProximaOperacion;
                        DmMovimientoFields.TipoMovimiento.Value := tmPedidoVenta;
                        DmMovimientoFields.Propietario.Value := DsClienteFields.Codigo.Value;
                        DmMovimientoFields.Serie.Value := '';  //?
                        DmMovimientoFields.NroDocumento.Value := SessionDataModule.Dm30.MovimientoModule.ProximoDocumento( DmMovimientoFields );
                        DmMovimientoFields.Fecha.Value := Now;
                        DmMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.Fecha.Value;
                        DmMovimientoFields.Origen.Value := omTiendaVirtual;
                        // DmMovimientoFields.NroDocumentoPropietario.Value := IncrementId;
                        DmMovimientoFields.CodigoTransportista.Value := DsClienteFields.Envios_Transportista.Value;
                        DmMovimientoFields.GrupoFacturacion.Value := DsClienteFields.Factura_Agrupacion.Value;
                        // DmMovimientoFields.CentroCoste.Value := DsSerieFacturacionFields.CentroCoste.Value;
                        DmMovimientoFields.Anotacion.Value := ComentariosPedido;

                        SessionDataModule.Dm30.MovimientoModule.InsertaVinculosCliente( DmMovimientoFields, DsClienteFields );

                        // DmMovimientoFields.Portes.Value := Portes;

                        // Comentarios añadidos por el cliente

                        // var TextoAnotacion := Trim( ExtensionAttributesObject.ValueByName( 'bold_order_comment' ) );

                        DmMovimientoTable.Post;

                        SessionDataModule.Dm30.MovimientoModule.CompruebaPrimerNroPagina( DmMovimientoFields );

                        var ImporteTotal : Decimal := 0.0;
                        var NroLinea := 1;

                        For var J := 0 to LineasPedidoArray.Count - 1 do
                          begin

                          var LineaPedidoObject := LineasPedidoArray.Item[ J ].JSONObject;

                          var CodigoArticulo := GetNodeValue( LineaPedidoObject, 'codigo', '.' );
                          var CodigoClaseA := GetNodeValue( LineaPedidoObject, 'codigoClaseA', '' );
                          var CodigoClaseB := GetNodeValue( LineaPedidoObject, 'codigoClaseB', '' );
                          var Cantidad := GetNodeValue( LineaPedidoObject, 'cantidad', 0.0 );
                          var Precio := GetNodeValue( LineaPedidoObject, 'precio', 0.0 );
                          var Comentario := GetNodeValue( LineaPedidoObject, 'comentarios', '' );

                          SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo, DsArticuloFields );    // Si no existe se utiliza un registro genérico. Antes eso que perder una línea.

                          DmLineaMovimientoTable.Append;

                          DmLineaMovimientoFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                          DmLineaMovimientoFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;
                          DmLineaMovimientoFields.NroPagina.Value := 0;
                          DmLineaMovimientoFields.NroLinea.Value := NroLinea;
                          DmLineaMovimientoFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                          DmLineaMovimientoFields.FechaAplicacion.Value := DmMovimientoFields.FechaAplicacion.Value;
                          DmLineaMovimientoFields.UIDArticulo.AsGuid := SessionDataModule.Dm30.ArticuloModule.Identificador;

                          DmLineaMovimientoFields.CodigoArticulo.Value := CodigoArticulo;
                          DmLineaMovimientoFields.CodigoClaseA.Value := CodigoClaseA;
                          DmLineaMovimientoFields.CodigoClaseB.Value := CodigoClaseB;
                          DmLineaMovimientoFields.Descripcion.Value := DsArticuloFields.Descripcion.Value; // GetNodeValue( LineaPedidoObject, 'name' );
                          DmLineaMovimientoFields.CodigoAlmacen.Value := DsArticuloFields.CodigoAlmacen.Value;
                          DmLineaMovimientoFields.Ubicacion.Value := SessionDataModule.Dm30.AlmacenModule.UbicacionPorDefecto( DmLineaMovimientoFields.CodigoAlmacen.Value, DsArticuloFields );
                          DmLineaMovimientoFields.Anotacion.Value := Comentario;

                          // DmLineaMovimientoFields.NroCajas.Value := NroCajas;
                          DmLineaMovimientoFields.Cantidad.Value := Cantidad;
                          DmLineaMovimientoFields.CantidadAjustada.Value := -DmLineaMovimientoFields.Cantidad.Value;

                          {
                          SessionDataModule.Dm10.TasaModule.TipoIVA( DmLineaMovimientoFields.Fecha.Value,
                                                                     DsClienteFields.CodigoPais.Value,
                                                                     DmLineaMovimientoFields.CodigoTipoIVA.Value,
                                                                     DsTiposIVAFields );
                          }

                          SessionDataModule.Dm30.ArticuloModule.ObtenPrecioyDtoVenta( DmMovimientoFields.TipoMovimiento.Value,
                                                                                      DmLineaMovimientoFields,
                                                                                      DsClienteFields,
                                                                                      DsArticuloFields );

                          SessionDataModule.Dm30.MovimientoModule.ActualizaCamposCalculadosLineaVenta( DmMovimientoFields, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields, DsSerieFacturacionFields, DsTiposIVAFields );

                          DecAdd( ImporteTotal, DmLineaMovimientoFields.ImporteTotal.Value );

                          DmLineaMovimientoTable.Post;

                          Inc( NroLinea );

                          end;


                        // Procesando posibles recargos o descuentos no indicados en el documento (de momento solo recargos por contra reembolsos)

                        {
                        SessionDataModule.Dm30.FacturaVentasModule.ObtenCuotasPortes( DmMovimientoFields.Portes.Value,
                                                                                      DmMovimientoFields.Fecha.Value,
                                                                                      DsClienteFields.Factura_ModeloIVA.Value,
                                                                                      CuotaIVAPortes,
                                                                                      CuotaREPortes );

                        ImporteTotal := ImporteTotal + DmMovimientoFields.Portes.Value + CuotaIVAPortes + CuotaREPortes;

                        }

                        TransactionTag.Commit;

                        Result := True;

                      except on E : Exception do
                        TransactionTag.Rollback;
                        end;

                      end;
            end;

     except
       end;

end;

function TMovimientoModule.EstadoPedidoTienda( Situacion : SmallInt ) : String;
begin
      Result := 'En proceso';
      case Situacion of
        epProcesado :
          Result := 'Procesado';
        epParcialmenteProcesado :
          Result := 'Parcialmente procesado';
          end;
end;


function TMovimientoModule.ObtenPedidosTienda( DataIn, DataOut : IsgcJSON ) : Boolean;

var  EMailCliente : String;

begin

     Result := False;

     try

       var ParametersObject := GetNodeObject( DataIn, 'parameters' );
       If   Assigned( ParametersObject )
       then begin

            EMailCliente := GetNodeValue( ParametersObject, 'eMailCliente', '' );
            If   SessionDataModule.Dm10.ClienteModule.ObtenPorEMail( EMailCliente, DsClienteFields )
            then With DmMovimientoQuery do
                   try

                     var CodigoCliente := DsClienteFields.Codigo.Value;

                     var FechaInicialDefecto := StrFormatDate( IncDay( Now, -30 ), dfSQL );
                     var FechaFinalDefecto := StrFormatDate( Now, dfSQL );

                     var FechaInicial := GetNodeValue( ParametersObject, 'fechaInicial', FechaInicialDefecto );
                     var FechaFinal := GetNodeValue( ParametersObject, 'fechaFinal', FechaFinalDefecto );
                     var NroRegistros := GetNodeValue( ParametersObject, 'pageSize', 10 );

                     Close;
                     SQL.Text := 'SELECT TOP ' + IntToStr( NroRegistros ) + ' * FROM Movimiento ' +
                                 'WHERE Propietario=' + QuotedStr( CodigoCliente ) + ' AND ' +
                                 'Fecha BETWEEN DATE ' + QuotedStr( FechaInicial ) + ' AND DATE ' + QuotedStr( FechaFinal ) + ' ' +
                                ' ORDER BY Fecha DESC';
                     Open;

                     var ArrayIndex := 0;
                     var RecordsRead := 0;

                     var DataArray : IsgcJSON := TsgcJSON.Create( nil );
                     DataArray.IsArray := True;

                     First;
                     While not Eof do
                       begin

                       var ImporteBruto : Decimal := 0.0;
                       var DescuentosArticulo : Decimal := 0.0;
                       var ImporteNeto : Decimal := 0.0;

                       ObtenImporteMovimiento( DmMovimientoQueryEjercicio.Value,
                                               DmMovimientoQueryNroOperacion.Value,
                                               ImporteBruto,
                                               DescuentosArticulo,
                                               ImporteNeto );

                       var PedidoObject := TsgcJSON.Create( nil );

                       PedidoObject.AddPair( 'Id', DmMovimientoQueryNroOperacion.AsInteger );
                       PedidoObject.AddPair( 'Ejercicio', DmMovimientoQueryEjercicio.AsInteger );
                       PedidoObject.AddPair( 'NroOperacion', DmMovimientoQueryNroOperacion.AsInteger );
                       PedidoObject.AddPair( 'TipoMovimiento', tmPedidoVenta );
                       PedidoObject.AddPair( 'Fecha', StrFormatDate( DmMovimientoQueryFecha.Value ) );
                       PedidoObject.AddPair( 'FechaAplicacion', StrFormatDate( DmMovimientoQueryFechaAplicacion.Value ) );
                       PedidoObject.AddPair( 'Propietario', DmMovimientoQueryPropietario.AsString );
                       PedidoObject.AddPair( 'Serie', DmMovimientoQuerySerie.AsString );
                       PedidoObject.AddPair( 'NroDocumento', DmMovimientoQueryNroDocumento.AsInteger );
                       PedidoObject.AddPair( 'Facturado', DmMovimientoQueryFacturado.AsString );
                       PedidoObject.AddPair( 'ImporteNeto', ImporteNeto );
                       PedidoObject.AddPair( 'Estado', EstadoPedidoTienda( DmMovimientoQuerySituacion.Value ) );

                       var Comentarios := DmMovimientoQueryAnotacion.AsString;
                         If   Copy( Comentarios, 1, 5 )= '{\rtf'
                         then Comentarios := SessionDataModule.RTFToPlainText( Comentarios );
                       PedidoObject.AddPair( 'Comentarios', Comentarios );

                       DataArray.AddObject( IntToStr( ArrayIndex ) ).JSONObject := PedidoObject;

                       Inc( ArrayIndex );

                       Next;
                       end;


                   DataOut.AddObject( 'loadout' ).JSONObject := DataArray;

                   DataOut.AddPair( 'recordsRead', RecordCount );

                   Result := True;

                   finally
                     Close
                     end;

            end;

     except
       end;

end;

function TMovimientoModule.ObtenDetallePedidoTienda( DataIn, DataOut : IsgcJSON ) : Boolean;

var  Ejercicio : SmallInt;
     Serie : String;
     NroOperacion : LongInt;

begin

     Result := False;

     try

       var ParametersObject := GetNodeObject( DataIn, 'parameters' );
       If   Assigned( ParametersObject )
       then begin

            Ejercicio := GetNodeValue( ParametersObject, 'ejercicio', SessionDataModule.Ejercicio );
            NroOperacion:= GetNodeValue( ParametersObject, 'nroOperacion', -1 );

            If   DmMovimientoTable.FindKey(  [ Ejercicio, NroOperacion ] )
            then try

                   var ArrayIndex := 0;

                   var DataArray : IsgcJSON := TsgcJSON.Create( nil );
                   DataArray.IsArray := True;

                   With DmLineaMovimientoTable do
                     try

                       // Ejercicio;NroOperacion;NroPagina;NroLinea

                       SetRange( [ DmMovimientoFields.Ejercicio.Value, DmMovimientoFields.NroOperacion.Value ] );

                       First;
                       While not Eof do
                         begin

                         var LineaPedidoObject := TsgcJSON.Create( nil );

                         LineaPedidoObject.AddPair( 'Id', DmLineaMovimientoFields.NroRegistro.Value );
                         LineaPedidoObject.AddPair( 'NroLinea', DmLineaMovimientoFields.NroLinea.Value );
                         LineaPedidoObject.AddPair( 'CodigoArticulo', DmLineaMovimientoFields.CodigoArticulo.Value );
                         LineaPedidoObject.AddPair( 'CodigoClaseA', DmLineaMovimientoFields.CodigoClaseA.Value );
                         LineaPedidoObject.AddPair( 'CodigoClaseB', DmLineaMovimientoFields.CodigoClaseB.Value );
                         LineaPedidoObject.AddPair( 'CodigoClaseC', DmLineaMovimientoFields.CodigoClaseC.Value );
                         LineaPedidoObject.AddPair( 'Descripcion', DmLineaMovimientoFields.Descripcion.Value );
                         LineaPedidoObject.AddPair( 'Cantidad', DmLineaMovimientoFields.CantidadAjustada.Value );
                         LineaPedidoObject.AddPair( 'Precio', DmLineaMovimientoFields.Precio.Value );
                         LineaPedidoObject.AddPair( 'Descuento', DmLineaMovimientoFields.Descuento.Value );
                         LineaPedidoObject.AddPair( 'ImporteNeto', DmLineaMovimientoFields.ImporteNeto.Value );
                         LineaPedidoObject.AddPair( 'ImporteTotal', DmLineaMovimientoFields.ImporteTotal.Value );

                         var Comentarios := DmLineaMovimientoFields.Anotacion.AsString;
                         If   Copy( Comentarios, 1, 5 )= '{\rtf'
                         then Comentarios := SessionDataModule.RTFToPlainText( Comentarios );
                         LineaPedidoObject.AddPair( 'Comentarios', Comentarios );

                         DataArray.AddObject( IntToStr( ArrayIndex ) ).JSONObject := LineaPedidoObject;
                         Inc( ArrayIndex );

                         Next;
                         end;


                     finally
                       CancelRange;
                       end;


                   var loadOutObject := DataOut.AddObject( 'loadout' ).JSONObject;

                   loadOutObject.AddObject( 'lineasMovimiento' ).JSONObject := DataArray;

                   var movimientoObject := loadOutObject.AddObject( 'movimiento' ).JSONObject;

                   movimientoObject.AddPair( 'Ejercicio', DmMovimientoFields.Ejercicio.Value );
                   movimientoObject.AddPair( 'NroOperacion', DmMovimientoFields.NroOperacion.Value );
                   movimientoObject.AddPair( 'TipoMovimiento', DmMovimientoFields.TipoMovimiento.Value );
                   movimientoObject.AddPair( 'Fecha', StrFormatDate( DmMovimientoFields.Fecha.Value ) );
                   movimientoObject.AddPair( 'FechaAplicacion', StrFormatDate( DmMovimientoFields.FechaAplicacion.Value ) );
                   movimientoObject.AddPair( 'Propietario', DmMovimientoFields.Propietario.Value);
                   movimientoObject.AddPair( 'Serie', DmMovimientoFields.Serie.Value );
                   movimientoObject.AddPair( 'NroDocumento', DmMovimientoFields.NroDocumento.Value );
                   movimientoObject.AddPair( 'Facturado', DmMovimientoFields.Facturado.Value );
                   movimientoObject.AddPair( 'Estado', EstadoPedidoTienda( DmMovimientoFields.Situacion.Value ) );

                   var Comentarios := DmMovimientoFields.Anotacion.AsString;
                   If   Copy( Comentarios, 1, 5 )= '{\rtf'
                   then Comentarios := SessionDataModule.RTFToPlainText( Comentarios );
                   movimientoObject.AddPair( 'Comentarios', Comentarios );

                   var ImporteBruto : Decimal := 0.0;
                   var DescuentosArticulo : Decimal := 0.0;
                   var ImporteNeto : Decimal := 0.0;

                   ObtenImporteMovimiento( DmMovimientoFields.Ejercicio.Value,
                                           DmMovimientoFields.NroOperacion.Value,
                                           ImporteBruto,
                                           DescuentosArticulo,
                                           ImporteNeto );

                   movimientoObject.AddPair( 'ImporteBruto', ImporteBruto );
                   movimientoObject.AddPair( 'DescuentosArticulo', DescuentosArticulo );
                   movimientoObject.AddPair( 'ImporteNeto', ImporteNeto );

                   DataOut.AddPair( 'recordsRead', DmLineaMovimientoTable.RecordCount );

                   Result := True;

                 finally

                   end;

            end;

     except
       end;

end;

procedure InitializeWebServices;
begin
     ServerContainerModule.AddWebServiceFunction( 'Movimiento.CreaPedido', TMovimientoModule.CreaPedidoTiendaWs );
     ServerContainerModule.AddWebServiceFunction( 'Movimiento.ObtenPedidos', TMovimientoModule.ObtenPedidosTiendaWs );
     ServerContainerModule.AddWebServiceFunction( 'Movimiento.ObtenDetallePedido', TMovimientoModule.ObtenDetallePedidoTiendaWs );
end;

var MovimientoControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_MovimientoService, TMovimientoService, MovimientoControl );

   AddProcedure( imStartup, 0, InitializeWebServices );
end.


