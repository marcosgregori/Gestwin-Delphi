unit dm_mov;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, StdCtrls, Forms, Dialogs, cxEdit, cxLabel,
  System.ImageList, Vcl.ImgList,

  cxImageList, cxGraphics, cxGridCustomTableView,

  DB,
  nxdb,
  nxsdTypes,

  cxGridDBTableView,
  Generics.Collections,

  LibUtils,
  DataManager,
  ReportManager,
  AppForms,
  Spring,
  SQLSet,

  clMailMessage,

  FrxNxComponents,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  dmi_iva,
  dmi_iex,
  dmi_mov,

  dm_sto,
  dm_iva,

  MovimientoIntf,
  LineaMovimientoIntf;

type
  TMuestraMovimientoEvent = procedure( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt ) of object;
  TSumatorioLineaEvent = procedure ( LineaMovimientoFields : TLineaMovimientoFields; Sustraer : Boolean = False; ValoresOriginales : Boolean = False ) of object;

  TMovimientoDatasetEvent = procedure ( MovimientoFields: TMovimientoFields ) of object;
  TObtenArticuloFinalEvent = function ( MovimientoFields: TMovimientoFields; var LineaMovimientoFields: TLineaMovimientoFields ) : Boolean of object;
  TFiltroLineaMovimientoDatasetEvent = procedure ( LineaMovimientoFields: TLineaMovimientoFields; var Accept : Boolean ) of object;
  TFirmaMovimientoEvent = procedure( AFormManager : TgxFormManager; AField : TGraphicField; MessageA, MessageB : String ) of object;
  TUpdateSelectionEvent = procedure( MovimientoOrigenFields : TMovimientoFields; CopiarDatosCabecera : Boolean = False; NoVincularDocumentos : Boolean = False; LineList : TLongIntArray = nil ) of object;
  TBeforeUpdateMovimientoEvent = procedure ( TipoMovimiento : TTipoMovimiento; CodigoPropietario : String ) of object;
  TUpdateEstadoDocumentoLabelEvent = procedure( MovimientoFields : TMovimientoFields; var Caption : String ) of object;
  TAdjuntaFicherosCorreoEvent = procedure( MailMessage : TclMailMessage; NroOperacion : LongInt ) of object;
  TActualizaCamposCalculadosLineaVentaEvent = procedure( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields; ClienteFields : TClienteFields; ArticuloFields : TArticuloFields; SerieFacturacionFields : TSerieFacturacionFields; TiposIVAFields : TTiposIVAFields ) of object;

  TParametrosInforme = record

   Titulo : String;

   TipoMovimientoListado,
   TipoMovimiento : TTipoMovimiento;

   DocumentoVentaConSeries,
   TodasLasSeriesCompras : Boolean;
   Serie,
   SeleccionSerieSQL : String;

   SeleccionNroDocumento : Boolean;
   Ejercicio : SmallInt;
   NroDocumentoInicial,
   NroDocumentoFinal : LongInt;

   SeleccionFecha : Boolean;
   FechaInicial,
   FechaFinal : TDateTime;
   FechaEntrega : Boolean;  // Solo pedidos
   SoloLineasPendientes,
   MostrarImportePendiente : Boolean;

   // Las selecciones de grupo se indican como sigue :   0 - Sin selección (filtro)
   //                                                    1 - Con selección
   //                                                    2 - Con selección y grupo por defecto (ordenado y agrupado por)

   SeleccionPropietario : SmallInt;
   PropietarioInicial,
   PropietarioFinal : String;

   SeleccionVendedor : SmallInt;
   VendedorInicial,
   VendedorFinal : String;

   SeleccionGrupo : SmallInt;
   GrupoInicial : String;
   GrupoFinal : String;

   SeleccionFormaCobro : SmallInt;
   FormaCobroInicial : String;
   FormaCobroFinal : String;

   SeleccionRegistroAuxiliar : SmallInt;
   PropietarioRegistroAuxiliar : String;
   RegistroAuxiliarInicial : String;
   RegistroAuxiliarFinal : String;

   SeleccionTransportista : SmallInt;
   TransportistaInicial : String;
   TransportistaFinal : String;

   Situacion : SmallInt;                  // TSituacionOfertas..TSituacionAlbaranes

   Agrupar,
   Valorar,
   MostrarDescuentos,
   ListadoDetallado : Boolean;

   GenerarFicheroPDF,
   EnviarPorCorreo,
   ExcluirEnviados,
   ExcluirCorreo : Boolean;

   PreseleccionDocumentos : Boolean;      // Solo estamos pre-seleccionando para mostrar una rejilla al usuario
   RelacionDocumentos : Boolean;          // Si se imprime a apartir de una relación prefijada de documentos
   TablaRelacionDocumentos : String;      // Nombre de la tabla con la relación de documentos, si existe.
   Report : TgxReportManager;
   Impreso : Boolean;                     // Estamos generando un impreso, no un listado
   DirectamenteAImpresora : Boolean;
   Formato,                               // El contenido del registro debe estar en InformeExterno.dmInformeExternoRec
   NroCopias : SmallInt;
   NoPedirImpresora,
   CopiaPropietario : Boolean;
   end;

  TMovimientoModule = class(TDataModule)
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoAuxTable: TnxeTable;
    DmLineaMovimientoAuxTable: TnxeTable;
    DmReport: TgxReportManager;
    DmConsumosClienteTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    GrupoLineaMovimientoAuxTable: TnxeTable;
    DmMovimientoQuery: TnxeQuery;
    DesplazaPaginaDocumentoStoredProc: TnxeStoredProc;
    InsertaPaginaDocumentoStoredProc: TnxeStoredProc;
    ExistenciasLoteQuery: TnxeQuery;
    ExistenciasLoteQueryLoteFabricacion: TWideStringField;
    ExistenciasLoteQueryCodigoAlmacen: TWideStringField;
    ExistenciasLoteQueryUbicacion: TWideStringField;
    DmMovimientoDestinoTable: TnxeTable;
    DmLineaMovimientoDestinoTable: TnxeTable;
    DmGrupoLineaMovimientoDestinoTable: TnxeTable;
    DmRelacionDocumentosTable: TnxeTable;
    ListadoSQLSet: TgxSQLSet;
    ImpresosSQLSet: TgxSQLSet;
    DmMovimientoImpresoTable: TnxeTable;
    DmGrupoLineaMovimientoImpresoTable: TnxeTable;
    DmLineaMovimientoImpresoTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DmReportSelectPrinter;
    procedure DmReportSetReportName;

  private

    MovimientoService : IMovimientoService;

    FormatoImpreso : SmallInt;  // Actualizado por InformeMovimientos para que pueda ser utilizado por el report

    EjercicioActualListado : SmallInt;
    NroTotalCopias,
    NroOperacionActual : LongInt;

    FSQLFields,
    FSQLFilter,
    FSQLOuterFilter,
    FSQLTables,
    FSQLOrder,
    FSQLLineFields,
    FSQLLineTable,
    FSQLMovimientosSelect,
    FSQLOuterWhere,
    FSQLString : String;

    FSeleccionPorFechaAplicacionLinea : Boolean;

    FBeforeUpdateMovimiento : Event<TBeforeUpdateMovimientoEvent>;
    FOnUpdateEstadoDocumentoLabel : Event<TUpdateEstadoDocumentoLabelEvent>;
    FOnAdjuntaFicherosCorreo : Event<TAdjuntaFicherosCorreoEvent>;
    FOnObtenArticuloFinal : Event<TObtenArticuloFinalEvent>;
    FOnActualizaCamposCalculadosLineaVentaEvent : Event<TActualizaCamposCalculadosLineaVentaEvent>;

    DsClienteFields,
    DsClienteImpresoFields : TClienteFields;
    DsProveedorFields,
    DsProveedorImpresoFields : TProveedorFields;
    DsSerieFacturacionFields,
    DsSerieFacturacionImpresoFields : TSerieFacturacionFields;
    DsTiposIVAFields : TTiposIVAFields;

    DmMovimientoQueryFields : TMovimientoFields;

    FCalculatingFields,
    FImportandoLineas : Boolean;

    FrxCabeceraTable,
    FrxLineasTable : TfrxNxTable;
    RptCabeceraTable,
    RptLineasTable,
    RptGrupoLineasTable : TnxeTable;
    RptCabeceraFields : TCabeceraFields;
    RptGrupoLineasFields : TGrupoLineasFields;
    RptLineasFields : TLineasFields;

    RptMovimientoTable : TnxeTable;
    RptMovimientoFields : TConsultaMovimientoFields;
    FrxMovimientoTable : TfrxNxTable;

    CalcularIVA : Boolean;

    ImporteBaseImponible,
    ImporteBrutoArticulos,
    ImporteDescuentoArticulos,
    ImporteNetoArticulos,
    ImporteTotalPuntoVerde,
    ImporteTotalContribucionRAP,
    ImporteIVA,
    ImporteRE,
    ImporteIVAIncluido,
    ImporteIVAPortes,
    ImporteREPortes : Decimal;
    TasasArray : TTasasArray;
    Sumas : TTasaRecord;

    CodigoContador : String;

    FModuloHojasDePedido,
    FMovimientoInventarioChecked,
    FExisteMovimientoInventario : Boolean;

    procedure DoOnProcessRecordListado( Sender : TObject );
    procedure DoOnProcessRecordImpreso( Sender : TObject );

    function EsMovimientoCompra: Boolean;
    procedure ExportaFicheroMovimientos;
    procedure CreaFicherosImpreso( SQLCommand : String = '' );

    function GetExisteMovimientoInventario : Boolean;
    procedure ObtenRelacionDocumentosInterna( RelacionList  : TStringList );

  public

    DmMovimientoFields,
    DmMovimientoImpresoFields : TMovimientoFields;
    DmMovimientoAuxFields : TMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmLineaMovimientoAuxFields,
    DmLineaMovimientoImpresoFields : TLineaMovimientoFields;
    DmConsumosClienteFields : TConsumosClienteFields;
    DmGrupoLineaMovimientoFields,
    DmGrupoLineaMovimientoImpresoFields : TGrupoLineaMovimientoFields;
    DmRelacionDocumentosFields : TRelacionDocumentosFields;

    DsEnvaseFields,
    DsContenedorFields : TClaseFields;
    DsArticuloFields,
    DsArticuloImpresoFields : TArticuloFields;
    DsDivisaFields,
    DsDivisaImpresoFields : TDivisaFields;

    ParametrosInforme : TParametrosInforme;

    function ProximaOperacion( Ejercicio : SmallInt = 0 ) : LongInt;
    function ProximoDocumento( MovimientoFields : TMovimientoFields; RegistrarValor : Boolean = True ) : LongInt;
    procedure RetiraDocumento( MovimientoFields : TMovimientoFields; CompruebaEstado : Boolean = True );
    function ExisteDocumentoContador( MovimientoFields : TMovimientoFields ) : Boolean;

    // function  EstadoFacturacionCorrecto( MovimientoFields : TMovimientoFields; Situacion : Integer ) : Boolean; overload;
    function Valida( EditControl : TcxCustomEdit; TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt;var ErrorText : TCaption; var Error : Boolean; IsInfoControl : Boolean = False; MovimientoFields : TMovimientoFields = nil ) : String;

    function  ObtenMovimiento( Ejercicio : SmallInt; NroOperacion : LongInt; MovimientoFields : TMovimientoFields = nil ) : Boolean; overload;
    function  ObtenMovimiento( TipoMovimiento : TTipoMovimiento; Ejercicio : SmallInt; Serie : String; NroDocumento : LongInt; MovimientoFields : TMovimientoFields = nil ) : Boolean; overload;
    function  ObtenRegistro( NroRegistro : LongInt; RecuperaMovimiento : Boolean = False ) : Boolean;
    function  ObtenNroRegistros: LongInt;

    function  DescripcionDocumento( Serie : String; NroDocumento : LongInt; NroEfecto : Integer = 0 ) : String;

    function SeriesEnDocumentosVenta( TipoMovimiento : TTipoMovimiento ) : Boolean;

    function ObtenImporteMovimiento(     Ejercicio : SmallInt;
                                         NroOperacion : LongInt;
                                     var ImporteBruto : Decimal;
                                     var DescuentosArticulo : Decimal;
                                     var ImporteNeto : Decimal ) : Boolean; overload;

    procedure CalculaImporteMovimiento(     MovimientoFields : TMovimientoFields;
                                        var ImporteBruto : Decimal;
                                        var DescuentosArticulo : Decimal;
                                        var ImporteNeto : Decimal;
                                            OnSumatorioLinea : TSumatorioLineaEvent = nil );

    function ObtenImporteMovimiento(     TipoMovimiento     : TTipoMovimiento;
                                         Ejercicio          : SmallInt;
                                         Serie              : String;
                                         NroDocumento       : LongInt;
                                     var ImporteBruto       : Decimal;
                                     var DescuentosArticulo : Decimal;
                                     var ImporteNeto        : Decimal ) : Boolean; overload;

    procedure RecalculaMovimiento( MovimientoFields : TMovimientoFields );

    procedure LimpiaImportesLinea( LineaMovimientoFields : TLineaMovimientoFields );

    procedure ImportaDatosCapturador( MovimientoFields       : TMovimientoFields;
                                      LineaMovimientoFields  : TLineaMovimientoFields;
                                      DataPath,
                                      CodigoAlmacenDestino   : String );

    {
    procedure ImportaDatosBascula( MovimientoFields       : TMovimientoFields;
                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                   CodigoAlmacenDestino   : String;
                                   CodigoTarifa           : String = '';
                                   CompruebaFecha         : Boolean = True );
    }
    function ObtenUltimaOperacion( TipoMovimiento    : SmallInt;
                                   FechaInicial      : TDateTime;
                                   CodigoPropietario : String;
                                   CodigoArticulo    : String;
                                   CodigoClaseA,
                                   CodigoClaseB,
                                   CodigoClaseC      : String ) : Boolean;

    function ExisteMovimientoArticulo( TipoMovimiento  : TTipoMovimiento;
                                       CodigoArticulo : String;
                                       FechaInicial,
                                       FechaFinal     : TDateTime ) : Boolean;

    function ExisteNroDocumento( TipoMovimiento  : TTipoMovimiento;
                                 Ejercicio       : SmallInt;
                                 Propietario     : String;
                                 Serie           : String;
                                 NroDocumento    : LongInt ) : Boolean;

    procedure CompruebaNroDocumento( FormManager : TgxFormManager; MovimientoFields : TMovimientoFields );

    // function CompruebaNroRegistroOrigen( LineaMovimientoFields : TLineaMovimientoFields; ForzarComprobacion : Boolean = False ) : Boolean;

    procedure CompruebaCantidadPendientePedido(     DisplayValue          : Variant;
                                                    LineaMovimientoFields : TLineaMovimientoFields;
                                                var ErrorText             : TCaption;
                                                var Error                 : Boolean );

    procedure CompruebaMovimientoLibre( MovimientoTable : TnxeTable );

    function DarLineaPorProcesada( MovimientoFields : TMovimientoFields;
                                   LineaMovimientoFields : TLineaMovimientoFields ) : Decimal;

    function EstadoPedido( MovimientoFields : TMovimientoFields ) : TEstadoPedido;
    function TextoSituacionPedido( TipoMovimiento : SmallInt; Situacion : TSituacionPedido ) : String;
    function TextoSituacionPresupuesto( Estado : TEstadoPresupuesto ) : String;

    function EstadoDocumento( MovimientoFields : TMovimientoFields;
                              EstadoLabel      : TcxCustomEdit = nil ) : String;

    function OrigenDocumento( MovimientoFields : TMovimientoFields;
                              OrigenLabel      : TcxLabel = nil ) : String;
    procedure MuestraMotivoBloqueo( MovimientoFields : TMovimientoFields );
    procedure InicializaValoresImpositivos( var TasasArray : TTasasArray );
    procedure AcumulaValoresImpositivosLinea(     LineaMovimientoFields : TLineaMovimientoFields;
                                                  CodigoPaisIVA         : String;
                                              var TasasArray            : TTasasArray;
                                                  MovimientoCompra      : Boolean = True );

    procedure ObtenPrecioVentaBase( TiposIVAFields : TTiposIVAFields; Cantidad, PrecioIVA : Decimal; var Precio : Double; ConRecargoEquivalencia : Boolean );
    procedure ObtenPrecioCompraBase( TiposIVAFields : TTiposIVAFields; PrecioIVA : Decimal; var Precio : Double );

    function TextoTipoMovimiento( TipoMovimiento : TTipoMovimiento; Plural : Boolean = True; Capitalizar : Boolean = False ) : String;
    function TextoTituloMovimiento( TipoMovimiento : TTipoMovimientoCompraVenta ) : String;
    function TextoNroDocumento( TipoDocumento : TTipoMovimiento ) : String;

    procedure HintMovimiento(       NroRegistroOrigen : LongInt;
                                    ACellViewInfo     : TcxGridTableDataCellViewInfo;
                              var   AHintText         : TCaption;
                              var   AIsHintMultiLine  : Boolean;
                              var   AHintTextRect     : TRect );

    function EsUnMovimientoDeEntrada( TipoMovimiento : TTipoMovimiento ) : Boolean;

    function ObtenEnvaseLinea( LineaMovimientoFields : TLineaMovimientoFields;
                               EnvaseFields          : TClaseFields ) : Boolean;

    function ObtenContenedorLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                   ContenedorFields      : TClaseFields ) : Boolean;

    procedure ActualizaCamposCalculadosLineaCompra( MovimientoFields       : TMovimientoFields;
                                                    LineaMovimientoFields  : TLineaMovimientoFields;
                                                    ProveedorFields        : TProveedorFields;
                                                    ArticuloFields         : TArticuloFields;
                                                    TiposIVAFields         : TTiposIVAFields = nil );

    procedure ActualizaCamposCalculadosLineaVenta( MovimientoFields       : TMovimientoFields;
                                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                                   ClienteFields          : TClienteFields;
                                                   ArticuloFields         : TArticuloFields;
                                                   SerieFacturacionFields : TSerieFacturacionFields;
                                                   TiposIVAFields         : TTiposIVAFields );

    procedure ActualizaRelacionesLineaEntrada( MovimientoFields      : TMovimientoFields;
                                               LineaMovimientoFields : TLineaMovimientoFields;
                                               ArticuloFields        : TArticuloFields );

    procedure ActualizaRelacionesLineaSalida( MovimientoFields      : TMovimientoFields;
                                              LineaMovimientoFields : TLineaMovimientoFields;
                                              ArticuloFields        : TArticuloFields;
                                              CodigoCliente         : String = '' );

    function CopiaMovimiento( EjercicioDestino       : SmallInt;
                              NroOperacionDestino    : LongInt;
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

    function ObtenUltimoNroLinea( LineaMovimientoFields : TLineaMovimientoFields ) : SmallInt; overload;
    function ObtenUltimoNroLinea( Ejercicio : SmallInt; NroOperacion : LongInt; NroPagina : SmallInt ) : SmallInt; overload;

    function ExistenLineas( MovimientoFields : TMovimientoFields ) : Boolean;
    procedure CompruebaPrimerNroPagina( MovimientoFields : TMovimientoFields; GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields = nil );
    function ObtenNroPagina( GrupoLineaMovimientoFields: TGrupoLineaMovimientoFields; OperacionPagina: TShiftOperation ): SmallInt;
    function ObtenNroLinea( LineaMovimientoFields : TLineaMovimientoFields; OperacionPagina : TShiftOperation ) : SmallInt;

    function ObtenPrimerLoteConExistencias(     CodigoArticulo  : String;
                                            var LoteFabricacion : String;
                                            var CodigoAlmacen   : String;
                                            var Ubicacion       : String ) : Boolean;

    function ExportaDocumento(       MovimientoOrigenFields   : TMovimientoFields;
                                     TipoMovimientoDestino    : TTipoMovimiento;
                                     CodigoPropietario,
                                     Serie                    : String;
                                     NroDocumento             : LongInt;
                               const LineList                 : TLongIntArray = nil;
                                     SoloCantidadesPendientes : Boolean = False;
                                     DocumentoAutomatico      : Boolean = False;
                                     CopiarDatosCabecera      : Boolean = False ) : IMovimiento;

    procedure  InsertaLineasDocumento(       MovimientoOrigenFields,
                                             MovimientoDestinoFields : TMovimientoFields;
                                       const LineList                : TLongIntArray;
                                             CopiarDatosCabecera     : Boolean = False;
                                             NoVincularDocumentos    : Boolean = False );

    function EntregasACuentaPedidosOrigen( MovimientoFields : TMovimientoFields ) : Decimal; overload;
    function EntregasACuentaPedidosOrigen( Ejercicio : SmallInt; NroOperacion : LongInt; Serie : String; NroFactura : LongInt ) : Decimal; overload;

    function CambiaSituacionPedido( NroOperacion : LongInt; Procesado : Boolean ) : Decimal;

    procedure  InsertaLineasConsumo( MovimientoFields       : TMovimientoFields;
                                     LineaMovimientoFields  : TLineaMovimientoFields;
                                     ClienteFields          : TClienteFields;
                                     SerieFacturacionFields : TSerieFacturacionFields;
                                     LineList               : TList<Integer> );

    procedure DesplazaLineaMovimiento( Ejercicio    : SmallInt;
                                       NroOperacion : LongInt;
                                       NroPagina,
                                       NroLinea     : SmallInt;
                                       HaciaArriba  : Boolean = False;
                                       HastaElFinal : Boolean = False );

    procedure DesplazaPaginaDocumento( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
                                       OperacionPagina            : TShiftOperation );

    procedure InsertaPaginaDocumento( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields );
    procedure ActualizaFechaEmision( CabeceraFields : TCabeceraFields );

    procedure SuprimeReferenciasLinea( MovimientoFields      : TMovimientoFields;
                                       LineaMovimientoFields : TLineaMovimientoFields );
    function CantidadProcesadaLinea( NroRegistroOrigen : LongInt ) : Decimal;
    function NumeroReferenciasLinea( NroRegistroOrigen : LongInt ): SmallInt;
    procedure AsignaOrigenPorLoteySerie( LineaMovimientoFields : TLineaMovimientoFields );
    function ObtenCosteUltimaEntradaPorLote( Fecha : TDate; CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion : String; NroRegistroLinea : LongInt; out Precio : Decimal; out NroRegistroOrigen : LongInt ) : Boolean; overload;
    procedure ObtenCosteUltimaEntradaPorLote( LineaMovimientoFields : TLineaMovimientoFields ); overload;
    function ObtenUltimoPrecioComprayDescuento( CodigoArticulo : String; Fecha : TDate; out Precio : Decimal; out Descuento : Decimal ) : Boolean;

    function CosteMovimiento( LineaMovimientoFields : TLineaMovimientoFields; var Coste : Decimal ) : Boolean;
    procedure CotejaFechaLineas( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields );

    procedure LimpiaParametrosInforme;
    procedure ActualizaSeleccionInforme( ConstruyeConsulta : Boolean = True );
    procedure InformeMovimientos; // utiliza ParametrosInforme : TParametrosDocumento
    procedure CreaFicherosListado;

    procedure InsertaVinculosCliente( MovimientoFields : TMovimientoFields; ClienteFields : TClienteFields );
    procedure SetupCamposLibresLineaCompras( TableView : TcxGridDBTableView; CamposLibres : Array of TcxGridDBColumn );
    procedure SetupCamposLibresLineaVentas( TableView : TcxGridDBTableView; CamposLibres : Array of TcxGridDBColumn );
    procedure ObtenRelacionDocumentos( CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC : String; NroProceso : SmallInt; RelacionList : TStringList ); overload;
    procedure ObtenRelacionDocumentos( Tipo : TTipoRelacionDocumentos; Ejercicio : SmallInt; NroOperacion : Integer; RelacionList : TStringList ); overload;

    function CalculoEspecial( Seccion : TSeccionComercial; Largo, Ancho, Alto : Decimal ) : Decimal;

    // Servicios

    procedure ActualizaMovimiento( MovimientoFields : TMovimientoFields );
    function SuprimeMovimiento( MovimientoFields : TMovimientoFields ) : Boolean; overload;
    function SuprimeMovimiento( Ejercicio: SmallInt; NroOperacion: Integer; PreservaCabecera : Boolean = False ) : Boolean; overload;  // No es de edición

    procedure ActualizaLineaMovimiento( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields; CompruebaVinculos : Boolean = True );
    procedure SuprimeLineaMovimiento( MovimientoFields : TMovimientoFields; LineaMovimientoFields : TLineaMovimientoFields );

    function GeneraPedidoCompra( CodigoProveedor, Serie : String; Fecha : TDate; const LineList : TLongIntArray ) : LongInt;
    function VincularAlbaranAPedido( NroOperacionAlbaran : LongInt; NroPagina : SmallInt; EjercicioPedido : SmallInt; NroOperacionPedido : LongInt ) : Boolean;
    function SuprimeVinculosConPedidos( NroOperacion : LongInt; NroPagina : SmallInt ) : Boolean;

    property ExisteMovimientoInventario : Boolean read GetExisteMovimientoInventario;
    property ImportandoLineas : Boolean read FImportandoLineas;
    property ModuloHojasDePedido : Boolean read FModuloHojasDePedido;

    property SQLFields : String read FSQLFields;
    property SQLFilter : String read FSQLFilter;
    property SQLOuterFilter : String read FSQLOuterFilter;
    property SQLTables : String read FSQLTables;
    property SQLOrder : String read FSQLOrder;
    property SQLMovimientosSelect : String read FSQLMovimientosSelect;
    property SQLOuterWhere : String read FSQLOuterWhere;
    property SQLString : String read FSQLString;

    property BeforeUpdateMovimiento : Event<TBeforeUpdateMovimientoEvent> read FBeforeUpdateMovimiento write FBeforeUpdateMovimiento;
    property OnUpdateEstadoDocumentoLabel : Event<TUpdateEstadoDocumentoLabelEvent> read FOnUpdateEstadoDocumentoLabel write FOnUpdateEstadoDocumentoLabel;
    property OnAdjuntaFicherosCorreo : Event<TAdjuntaFicherosCorreoEvent> read FOnAdjuntaFicherosCorreo write FOnAdjuntaFicherosCorreo;
    property OnObtenArticuloFinal : Event<TObtenArticulOFinalEvent> read FOnObtenArticuloFinal write FOnObtenArticuloFinal;
    property OnActualizaCamposCalculadosLineaVenta : Event<TActualizaCamposCalculadosLineaVentaEvent> read FOnActualizaCamposCalculadosLineaVentaEvent write FOnActualizaCamposCalculadosLineaVentaEvent;

  end;

var  MovimientoModule: TMovimientoModule = nil;

function Movimiento : TMovimientoModule;

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
     RsHojasDePedido = 'hoja%s de pedido';
     RsAlbaranesVenta = 'albaran%s de venta';
     RsMovimientosAlmacen = 'movimiento%s de almacén';

     RsTituloOferta = 'OFERTA';
     RsTituloPedidoCompra = 'PEDIDO DE COMPRA';
     RsTituloAlbaranCompra = 'ALBARÁN DE COMPRA';
     RsTituloPresupuesto = 'PRESUPUESTO';
     RsTituloPedidoVenta = 'PEDIDO DE VENTA';
     RsTituloHojaPedido = 'HOJA DE PEDIDO';
     RsTituloAlbaranventa = 'ALBARÁN DE VENTA';

     RsMsgSituacionOfertas       = '"<Todas>","Pendientes de revisión","Revisadas"';
     RsMsgSituacionPresupuestos  = '"<Todos>","Pendientes","Aceptados","Cancelados"';
     RsMsgSituacionPedidosCompra = '"<Todos>","Pendientes de recibir (totalmente)","Pendientes de recibir (total o parcialmente)","Parcialmente recibidos","Totalmente recibidos"';
     RsMsgSituacionPedidosVenta  = '"<Todos>","Pendientes de servir (totalmente)","Pendientes de servir (total o parcialmente)","Parcialmente servidos","Totalmente servidos"';
     RsMsgSituacionAlbaranes     = '"<Todos>","No facturables","Facturables","Pendientes de facturar (todos)","Pendientes de facturar (facturables)","Facturados","Pendientes de contabilizar","Contabilizados"';
     RsMsgSituacionAlbaranesB    = '"<Todos>","No facturables","Pendientes de facturar"';


     RsDocumentoBloqueado = 'Este documento no puede ser editado.';
     RsDocumentoContabilizado = 'Ya ha sido contabilizado.' ;
     RsDocumentoAnulado = 'Ha sido anulado.' ;
     RsDocumentoFacturado = 'Ha sido facturado.' ;
     RsDocumentoOtroEjercicio = 'No pertenece al ejercicio activo.' ;

const
     ncrDocumentosPedido = 'DocumentosPedido';

type

     TSituacionOfertas       = ( sofTodas = 0, sofPendientesRevision = 1, sofRevisadas = 2 );
     TSituacionPresupuestos  = ( sprTodos = 0, sprPendientes = 1, sprAceptados = 2, sprCancelados = 3 );
     TSituacionPedidos       = ( speTodos = 0, spePendienteProcesarCompleto = 1, spePendienteProcesar = 2, speParcialmenteProcesados = 3, speProcesados = 4 );
     TSituacionAlbaranes     = ( saaTodos = 0, saaNoFacturables = 1, saaFacturables = 2, saaPendientesFacturar = 3, saaPendientesFacturarFacturables = 4, saaFacturados = 5, saaPendientesContabilizar = 6, saaContabilizados = 7 );
     TSituacionAlbaranesB    = ( sabTodos = 0, sabNoFacturables = 1, sabPendientesFacturar = 2 );

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses SysUtils,
     DateUtils,
     Variants,
     Files,

     nxllException,
     frxClass,

     AppContainer,
     DataAccess,
     EnterpriseDataAccess,

     AppManager,

     NexusRpcData,

     Gdm00Dm,
     Gdm30Dm,

     dmi_cnd,
     dmi_sto,

     dm_fdv,
     dm_fdc,
     dm_art,
     dm_alm,
     dm_cli,
     dm_gdc,
     dm_pro,
     dm_pga,
     dm_cnd,
     dm_ine,
     dm_fac,
     dm_fde,
     dm_fpa,
     dm_fco,
     dm_sdf,
     dm_cdi,
     dm_tca,
     dm_cls,
     dm_lma,
     dm_rcl,
     dm_tra,
     dm_ven,
     dm_iex,
     dm_ddc,
     dm_dco,

     {
     a_mco,
     a_mve,
     }

     b_msg,
     b_pro,
     f_prg;

{$R *.DFM}

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
     RsMsg13 = ' Facturado (Factura nº %s).';
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
     RsMsg30 = 'La cantidad no puede ser negativa.';
     RsMsg31 = 'No puede indicar cantidades negativas en entradas o salidas vinculadas con un pedido.';
     RsMsg32 = 'Otro usuario ya ha reservado este número de documento.'#13'Introduzca otro número o pulse [B][F12][/B] para generar un número exclusivo automáticamente.';
     RsMsg33 = 'El pedido origen de esta línea ha sido incluido en más de un albaran.';
     RsMsg34 = 'No puede modificar las clases del artículo de una línea que también ha sido incluido en otros albaranes.';
     RsMsg35 = 'El documento está siendo editado por otro usuario.';
     RsMsg36 = 'Espere a que sea liberado y reintente la operación.';
     RsMsg37 = 'Cliente %s.';
     RsMsg38 = 'Generando el fichero de exportación del documento.';
     RsMsg39 = 'Creando el documento y guardando una copia.';
     RsMsg40 = 'Envío %s nro. %s %d de fecha %s.';
     RsMsg41 = 'No se ha podido guardar la fecha de envío del % %s %d.';
     RsMsg42 = 'Documento enviado por correo a la dirección : %s.';
     RsMsg43 = 'Ha ocurrido un problema al enviar el impreso por E-mail.';
     RsMsg44 = 'Revise la configuración del correo y/o la conexión a Internet y reintente el proceso.';
     RsMsg45 = 'Es posible que esté siendo editado por otro usuario. El proceso de emisión continúa.';
     RsMsg46 = 'Se ha producido un error durante el proceso de generación o envío del documento.';
     RsMsg47 = 'El documento nº %d, del propietario %s - %s no ha sido enviado por correo porque no cumple los requisitos indicados.';
     RsMsg48 = 'No he conseguido recuperar la ficha del propietario de código %s.';
     RsMsg49 = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
     RsMsg50 = 'Se cancela la generación y firma de documentos.'#13'Verifique que tiene acceso al directorio de documentos [B]%s[/B] y reintente el proceso.';
     RsMsg51 = 'Creado el fichero [URL=%s]%s[/URL].';
     RsMsg52 = 'Enviando por correo el impreso.';
     RsMsg53 = 'Realizando el envío de documentos de venta por correo.';
     RsMsg54 = 'Generación y exportación de documentos de venta.';
     RsMsg55 = 'Exportando en la carpeta : %s.';

     RsMsg56 = #13'Estimado cliente :'#13#13;
     RsMsg57 = #13'Estimado proveedor :'#13#13;
     RsMsg58 = 'Le adjuntamos copia del documento %s %d del ejercicio %d.'#13#13'Sin otro particular, le saludamos atentamente.'#13#13'%s'#13#13;

     RsVentaPeriodica             = 'PERIODICO';
     RsCapturador                 = 'CAPTURADOR';
     RsPreventa                   = 'PREVENTA';
     RsHojaCarga                  = 'CARGA';
     RsDocumentoControlMercancias = 'D.C.M.';
     RsTiendaVirtual              = 'TIENDA';
     RsAprovisionamiento          = 'APROVISIONAMIENTO';
     RsFacturaElectronica         = 'FACTURAE';

function Movimiento : TMovimientoModule;
begin
     CreateDataModule( TMovimientoModule, MovimientoModule );
     Result := MovimientoModule;
end;

// TMovimientoModule

procedure TMovimientoModule.DataModuleCreate(Sender: TObject);

var  TestMovimiento : IMovimiento;

begin

     NexusRpc.CreateRemoteInstance( CLSID_MovimientoService, IMovimientoService, MovimientoService );

     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
     DmMovimientoImpresoFields := TMovimientoFields.Create( DmMovimientoImpresoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmLineaMovimientoAuxFields := TLineaMovimientoFields.Create( DmLineaMovimientoAuxTable );
     DmLineaMovimientoImpresoFields := TLineaMovimientoFields.Create( DmLineaMovimientoImpresoTable );
     DmConsumosClienteFields := TConsumosClienteFields.Create( DmConsumosClienteTable );
     DmGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoTable );
     DmGrupoLineaMovimientoImpresoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoImpresoTable );
     DmRelacionDocumentosFields := TRelacionDocumentosFields.Create( DmRelacionDocumentosTable );

     DsClienteFields := TClienteFields.Create( Self );
     DsClienteImpresoFields := TClienteFields.Create( Self );
     DsProveedorFields := TProveedorFields.Create( Self );
     DsProveedorImpresoFields := TProveedorFields.Create( Self );
     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsSerieFacturacionImpresoFields := TSerieFacturacionFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsEnvaseFields := TClaseFields.Create( Self );
     DsContenedorFields := TClaseFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsArticuloImpresoFields := TArticuloFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );
     DsDivisaImpresoFields := TDivisaFields.Create( Self );

     FModuloHojasDePedido := ApplicationContainer.IsModuleActive( [ 120 ] );
     If   FModuloHojasDePedido
     then MovimientoService.ActivaHojasDePedido;

     ExecComponentProcedures( idMovimientoModule, imOnCreateComponent );

end;

procedure TMovimientoModule.DataModuleDestroy(Sender: TObject);
begin
     MovimientoModule := nil;
end;

function TMovimientoModule.Valida(     EditControl      : TcxCustomEdit;
                                       TipoMovimiento   : TTipoMovimiento;
                                       Ejercicio        : SmallInt;
                                       Serie            : String;
                                       NroDocumento     : LongInt;
                                   var ErrorText        : TCaption;
                                   var Error            : Boolean;
                                       IsInfoControl    : Boolean = False;
                                       MovimientoFields : TMovimientoFields = nil ) : String;

var  NombrePropietario,
     Descripcion : String;

begin
     Descripcion := '';
     With DmMovimientoTable do
       If   NroDocumento<>0
       then begin
            IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
            If   FindKey( [ TipoMovimiento, Ejercicio, Serie, NroDocumento ] )
            then begin
                 NombrePropietario := '';
                 If   TipoMovimiento in [ tmPresupuesto, tmPedidoventa, tmVenta ]
                 then NombrePropietario := Cliente.Descripcion( DmMovimientoFields.Propietario.Value, { NotificaSiNoExiste } False )
                 else If   TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ]
                      then NombrePropietario := Proveedor.Descripcion( DmMovimientoFields.Propietario.Value, { NotificaSiNoExiste } False );
                 If   NombrePropietario=''
                 then Descripcion := DmMovimientoFields.DescripcionMovimiento.Value
                 else Descripcion := DmMovimientoFields.Propietario.Value + ', ' + NombrePropietario;
                 end
            else If   not IsInfoControl
                 then begin
                      Error := True;
                      ErrorText := JoinMessage( RsMsg15, RsMsg16 );
                      end;
            If   Assigned( MovimientoFields )
            then MovimientoFields.Update( DmMovimientoTable );
            end;
     Result := Descripcion;
end;

function TMovimientoModule.VincularAlbaranAPedido( NroOperacionAlbaran : Integer;
                                                   NroPagina           : SmallInt;
                                                   EjercicioPedido     : SmallInt;
                                                   NroOperacionPedido  : Integer ) : Boolean;
begin
     Result := MovimientoService.VincularAlbaranAPedido( NroOperacionAlbaran, NroPagina, EjercicioPedido, NroOperacionPedido );
end;

function  TMovimientoModule.ObtenMovimiento( Ejercicio        : SmallInt;
                                             NroOperacion     : LongInt;
                                             MovimientoFields : TMovimientoFields = nil ): Boolean;
begin
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'Ejercicio;NroOperacion';
       Result := FindKey( [ Ejercicio, NroOperacion ] );
       If   Assigned( MovimientoFields )
       then MovimientoFields.Update( DmMovimientoTable );
       end;
end;

function TMovimientoModule.ObtenMovimiento( TipoMovimiento   : TTipoMovimiento;
                                            Ejercicio        : SmallInt;
                                            Serie            : String;
                                            NroDocumento     : Integer;
                                            MovimientoFields : TMovimientoFields = nil ): Boolean;
begin
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
       Result := FindKey( [ Ord( TipoMovimiento ), Ejercicio, Serie, NroDocumento ] );
       If   Assigned( MovimientoFields )
       then MovimientoFields.Update( DmMovimientoTable );
       end;
end;

function  TMovimientoModule.ObtenNroRegistros : LongInt;
begin
     With DmMovimientoTable do
       begin
       CancelRange;
       Result := RecordCount;
       end;
end;

function  TMovimientoModule.ObtenRegistro( NroRegistro        : LongInt;
                                           RecuperaMovimiento : Boolean = False  ) : Boolean;
begin
     With DmLineaMovimientoTable do
       begin
       IndexFieldNames := 'NroRegistro';
       Result := FindKey( [ NroRegistro ] );
       If   Result and RecuperaMovimiento
       then With DmLineaMovimientoFields do
              Result := ObtenMovimiento( Ejercicio.Value, NroOperacion.Value );
       end;
end;

function TMovimientoModule.ProximaOperacion( Ejercicio : SmallInt = 0 ) : LongInt;
begin
     Result := MovimientoService.ProximaOperacion( Ejercicio);
end;

procedure TMovimientoModule.RetiraDocumento( MovimientoFields : TMovimientoFields;
                                             CompruebaEstado  : Boolean = True );
begin
     If   Assigned( MovimientoFields )
     then With MovimientoFields do
            If   Dataset is TnxeTable
            then With TnxeTable( Dataset ) do
                   If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                   then begin
                        CodigoContador := Serie.Value;
                        If   TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]   // Movimiento de compras
                        then StrAdd( CodigoContador, Propietario.Value );
                        Contadores.RetiraValor( cnMovimientoDocumento, Ejercicio.Value, CodigoContador, NroDocumento.Value );
                        end;
end;

function TMovimientoModule.ExisteDocumentoContador( MovimientoFields : TMovimientoFields ) : Boolean;
begin
     If   MovimientoFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]
     then CodigoContador := MovimientoFields.Serie.Value + MovimientoFields.Propietario.Value
     else CodigoContador := MovimientoFields.Serie.Value;
     Result := Contadores.ExisteValor( cnMovimientoDocumento, MovimientoFields.Ejercicio.Value, CodigoContador, MovimientoFields.NroDocumento.Value );
end;

function TMovimientoModule.ProximoDocumento( MovimientoFields : TMovimientoFields;
                                             RegistrarValor   : Boolean = True ) : LongInt;
begin
     With MovimientoFields do
       Result := MovimientoService.ProximoDocumento( TipoMovimiento.Value, Ejercicio.Value, Propietario.Value, Serie.Value, RegistrarValor );
end;

{
function  TMovimientoModule.EstadoFacturacionCorrecto( MovimientoFields : TMovimientoFields;
                                                       Estado           : Integer ) : Boolean;

begin
     Result := False;
     With MovimientoFields do
       case Situacion of
         0 : Result := No_Facturar.Value;
         1 : Result := Facturado.Value;
         2 : Result := not Facturado.Value;
         3 : Result := Traspasado.Value;
         4 : Result := not Traspasado.Value;
         5 : Result := True;
       end;
end;
}

function TMovimientoModule.DarLineaPorProcesada( MovimientoFields      : TMovimientoFields;
                                                 LineaMovimientoFields : TLineaMovimientoFields ) : Decimal;
begin
     Result := MovimientoService.DarLineaPorProcesada( MovimientoFields.NroOperacion.Value,
                                                       MovimientoFields.TipoMovimiento.Value,
                                                       MovimientoFields.Serie.Value,
                                                       MovimientoFields.Propietario.Value,
                                                       LineaMovimientoFields.NroPagina.Value,
                                                       LineaMovimientoFields.NroLinea.Value );
end;

function TMovimientoModule.DescripcionDocumento( Serie        : String;
                                                 NroDocumento : LongInt;
                                                 NroEfecto    : Integer = 0 ) : String;
begin
      Result := IntToStr( NroDocumento );
      If   Serie<>''
      then Result := Serie + ' - ' + Result;
      If   NroEfecto<>0
      then Result := Result + '/' + IntToStr( NroDocumento );
end;

function TMovimientoModule.SuprimeMovimiento( MovimientoFields : TMovimientoFields ): Boolean;
begin
     Result := MovimientoService.SuprimeMovimiento( MovimientoFields.GetRemoteCursorID, MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value );
end;

function TMovimientoModule.ObtenImporteMovimiento(     Ejercicio          : SmallInt;
                                                       NroOperacion       : LongInt;
                                                   var ImporteBruto       : Decimal;
                                                   var DescuentosArticulo : Decimal;
                                                   var ImporteNeto        : Decimal ) : Boolean;
begin
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'Ejercicio;NroOperacion';
       ImporteBruto := 0.0;
       DescuentosArticulo := 0.0;
       ImporteNeto := 0.0;
       Result := FindKey( [ Ejercicio, NroOperacion ] );
       If   Result
       then CalculaImporteMovimiento( DmMovimientoFields, ImporteBruto, DescuentosArticulo, ImporteNeto );
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
     With DmMovimientoTable do
       begin
       IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
       ImporteBruto := 0.0;
       DescuentosArticulo := 0.0;
       ImporteNeto := 0.0;
       Result := FindKey( [ TipoMovimiento, Ejercicio, Serie, NroDocumento ] );
       If   Result
       then CalculaImporteMovimiento( DmMovimientoFields, ImporteBruto, DescuentosArticulo, ImporteNeto );
       end;
end;

procedure TMovimientoModule.CalculaImporteMovimiento(     MovimientoFields   : TMovimientoFields;
                                                      var ImporteBruto       : Decimal;
                                                      var DescuentosArticulo : Decimal;
                                                      var ImporteNeto        : Decimal;
                                                          OnSumatorioLinea   : TSumatorioLineaEvent = nil );
begin
     With DmLineaMovimientoTable do
       try

         Cancel;

         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

         First;
         While not Eof do
           begin

           If   Assigned( OnSumatorioLinea )
           then OnSumatorioLinea( DmLineaMovimientoFields );

           DecAdd( ImporteBruto, DmLineaMovimientoFields.ImporteBruto.Value );
           DecAdd( DescuentosArticulo, DmLineaMovimientoFields.ImporteDescuento.Value );
           DecAdd( ImporteNeto, DmLineaMovimientoFields.ImporteNeto.Value );

           Next;
           end;

       finally
         CancelRange;
         end;

end;

{
procedure TMovimientoModule.ImportaDatosBascula( MovimientoFields       : TMovimientoFields;
                                                 LineaMovimientoFields  : TLineaMovimientoFields;
                                                 CodigoAlmacenDestino   : String;
                                                 CodigoTarifa           : String = '';
                                                 CompruebaFecha         : Boolean = True );

var   Fichero : TextFile;
      DataLine : String;
      Index : SmallInt;
      NroPaginaActual,
      UltimoNroLinea : SmallInt;

      TextoImporte : String;

      CodigoBalanza,
      CodigoArticuloEntrada,
      CodigoClaseAEntrada,
      CodigoClaseBEntrada,
      CodigoClaseCEntrada : String;
      FijarClases : Boolean;

      Gramos,
      ImporteTotalIVA : Decimal;

      CantidadEntrada,
      PrecioEntrada : Decimal;

      CodigoBalanzaActual : String;

procedure DesglosaLineaEntrada;
begin
     try

       CodigoBalanza := Trim( Copy( DataLine, 3, 2 ) );
       CodigoArticuloEntrada := Trim( Copy( DataLine, 6, 6 ) );
       Gramos := StrToFloat( Copy( DataLine, 13, 10 ) );

       // El Importe lleva dos decimales implícitos (sin coma decimal)

       TextoImporte    := Copy( DataLine, 24, 10 );
       insert( ',', TextoImporte, length( TextoImporte ) - 1 );
       ImporteTotalIVA := StrToFloat( TextoImporte );

       CantidadEntrada := Gramos / 1000.0;

     except on e : Exception do begin
                                ShowException( e, self );
                                raise;
                                end;
       end;
end;

begin

     try

       EnterpriseDataModule.StartTransaction( [ TnxTable( MovimientoFields.Dataset ),
                                                TnxTable( LineaMovimientoFields.Dataset ) ] );

       // Este proceso debería realizarse en el servidor para incluir en la transaccion a los stocks

       NroPaginaActual := LineaMovimientoFields.NroPagina.Value;
       UltimoNroLinea := ObtenUltimoNroLinea( LineaMovimientoFields );

       SerieFacturacion.Obten( MovimientoFields.Serie.Value );
       Cliente.Obten( MovimientoFields.Propietario.Value, '', DsClienteFields );

       CodigoBalanzaActual := '';
       Index := 0;
       LineaMovimientoFields.Dataset.DisableControls;

       try

         AssignFile( Fichero, Configuracion.ParametrosUsrRec.PathFicheroDatosCapturador );
         Reset( Fichero );
         IoCheck( IoResult );

         try

           While not Eof( Fichero ) do
             begin

             ReadLn( Fichero, DataLine );
             IoCheck( IoResult );

             DataLine := Trim( DataLine );
             If   DataLine<>''
             then begin

                  DesglosaLineaEntrada;

                  If   CodigoBalanzaActual=''
                  then begin
                       MovimientoFields.CodigoVendedor.Value := CodigoBalanza;
                       MovimientoFields.Dataset.Post;
                       end
                  else If   CodigoBalanzaActual<>CodigoBalanza
                       then With MovimientoFields do
                              begin
                              MovimientoFields.Dataset.Append;
                              Ejercicio.Value := ApplicationContainer.Ejercicio;
                              TipoMovimiento.Value := tmVenta;
                              NroOperacion.Value := Movimiento.ProximaOperacion;
                              NroDocumento.Value := Movimiento.ProximoDocumento( MovimientoFields );
                              CodigoVendedor.Value := CodigoBalanza;
                              MovimientoFields.Dataset.Post;
                              UltimoNroLinea := 1;
                              Index := 0;
                              end;

                  CodigoBalanzaActual := CodigoBalanza;

                  With LineaMovimientoFields do
                    begin

                    Dataset.Append;

                    Ejercicio.Value := MovimientoFields.Ejercicio.Value;
                    NroOperacion.Value := MovimientoFields.NroOperacion.Value;
                    NroPagina.Value := NroPaginaActual;
                    NroLinea.Value := UltimoNroLinea + Index;
                    Fecha.Value := MovimientoFields.Fecha.Value;
                    TipoMovimientoOrigen.Value := tmBascula;

                    // Primero compruebo el código de barras, si no existe supongo que es un código de artículo normal

                    If   not Articulo.CodigoBarras( CodigoArticuloEntrada,
                                                    CodigoClaseAEntrada,
                                                    CodigoClaseBEntrada,
                                                    CodigoClaseCEntrada,
                                                    FijarClases,
                                                    DsArticuloFields )
                    then If   not Articulo.Obten( CodigoArticuloEntrada, DsArticuloFields )
                         then begin
                              ShowNotification( ntStop, Format( RsMsg2, [ CodigoArticuloEntrada ] ), '' );
                              DatasetCancel;
                              Abort;
                              end;

                    CodigoArticulo.Value := CodigoArticuloEntrada;
                    If   FijarClases
                    then begin
                         CodigoClaseA.Value := CodigoClaseAEntrada;
                         CodigoClaseB.Value := CodigoClaseBEntrada;
                         CodigoClaseC.Value := CodigoClaseCEntrada;
                         end;

                    // Como el importe leído lleva el IVA incluido hay que calcular el precio de entrada a partir de él

                    Tasa.TipoIVA( DsArticuloFields.TipoIVA.Value, Fecha.Value, DsTiposIVAFields );
                    If   DsClienteFields.Factura_modeloIVA.Value<>micConRE
                    then ImporteTotal.Value := Redondea( ImporteTotalIVA / ( 1 + ( DsTiposIVAFields.IVARepercutido.Value / 100.0 ) ) )
                    else ImporteTotal.Value := Redondea( ImporteTotalIVA / ( 1 + ( DsTiposIVAFields.IVARepercutido.Value / 100.0 ) + ( DsTiposIVAFields.RERepercutido.Value / 100.0 ) ) );

                    If   CantidadEntrada=0.0
                    then PrecioEntrada := 0.0
                    else PrecioEntrada := ImporteTotal.Value / CantidadEntrada;

                    Descripcion.Value := DsArticuloFields.Descripcion.Value;
                    CodigoAlmacen.Value:= CodigoAlmacenDestino;
                    Cantidad.Value := -CantidadEntrada;
                    Precio.Value := PrecioEntrada;

                    FacturaVentas.CalculaImportesIVA( LineaMovimientoFields, DsClienteFields, DsArticuloFields, DsSerieFacturacionFields, DsTiposIVAFields );
                    StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );

                    Dataset.Post;
                    end;

                  end;

             Inc( Index );
             end;

           EnterpriseDataModule.Commit;

         finally
           CloseFile( Fichero );
           end;

       except
         EnterpriseDataModule.RollBack;
         ShowNotification( ntStop, Format( RsMsg3, [ 'de la báscula' ] ), RsMsg4 );
         end;

     finally
       LineaMovimientoFields.Dataset.EnableControls;
       end;

end;
}

function TMovimientoModule.ObtenUltimaOperacion( TipoMovimiento     : SmallInt;
                                                 FechaInicial      : TDateTime;
                                                 CodigoPropietario : String;
                                                 CodigoArticulo    : String;
                                                 CodigoClaseA,
                                                 CodigoClaseB,
                                                 CodigoClaseC      : String ) : Boolean;
begin
     Result := False;
     With DmMovimientoTable do
       try

         IndexFieldNames := 'TipoMovimiento;Propietario;Fecha';

         SetRange( [ TipoMovimiento, CodigoPropietario, LowestDateTime ],
                   [ TipoMovimiento, CodigoPropietario, FechaInicial ] );

         Last;
         While not Bof do
           begin

           With DmLineaMovimientoTable do
             try

               IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

               With DmMovimientoFields do
                 SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

               Last;
               While not Bof do
                 begin

                 If   ( DmLineaMovimientoFields.CodigoArticulo.Value=CodigoArticulo ) and
                      ( DmLineaMovimientoFields.CodigoClaseA.Value=CodigoClaseA ) and
                      ( DmLineaMovimientoFields.CodigoClaseB.Value=CodigoClaseB ) and
                      ( DmLineaMovimientoFields.CodigoClaseC.Value=CodigoClaseC )
                 then begin
                      Result := True;
                      Exit;
                      end;

                 Prior;
                 end;


             finally
               CancelRange;
               end;

           Prior;
           end;

       finally
         CancelRange;
         end;

end;

procedure TMovimientoModule.CompruebaNroDocumento( FormManager      : TgxFormManager;
                                                   MovimientoFields : TMovimientoFields  );
begin

     { Este procedimiento verifica la unicidad del número del documento durante la inserción del registro : si el número se asigna manualmente,
       se comprueba que el número no haya sido reservado por otro usuario (con contadores activos) }

     If   MovimientoFields.Dataset.State=dsSetKey
     then If   not FormManager.InsertingAutoIncRecord and ExisteDocumentoContador( MovimientoFields )
          then begin
               ShowNotification( ntStop, RsMsg25, RsMsg32 );
               MovimientoFields.Dataset.Cancel;
               Abort;
               end;
end;

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

function TMovimientoModule.ExisteMovimientoArticulo( TipoMovimiento : TTipoMovimiento;
                                                     CodigoArticulo : String;
                                                     FechaInicial,
                                                     FechaFinal     : TDateTime  ) : Boolean;
begin
     Result := False;
     With DmLineaMovimientoTable do
       try

         IndexFieldNames := 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';
         DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';

         SetRange( [ CodigoArticulo, FechaInicial ], [ CodigoArticulo, FechaFinal ] );

         First;
         While not Eof do
           begin

           With DmLineaMovimientoFields do
             If   Cantidad.Value<>0.0
             then If   DmMovimientoTable.FindKey( [ Ejercicio.Value, NroOperacion.Value ] )
                  then If   ( DmMovimientoFields.TipoMovimiento.Value=TipoMovimiento ) or ( TipoMovimiento=tmNoDefinido )
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

{
function TMovimientoModule.CompruebaNroRegistroOrigen( LineaMovimientoFields : TLineaMovimientoFields;
                                                       ForzarComprobacion    : Boolean = False ) : Boolean;
begin
     Result := False;
     With LineaMovimientoFields do
       begin

       If   ValueIsEmpty( NroRegistroOrigen.Value ) or ForzarComprobacion
       then With DmLineaMovimientoAuxTable do
              try
                IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                SetRange( [ EjercicioOrigen.Value, NroOperacionOrigen.Value, 0, 1 ], [ EjercicioOrigen.Value, NroOperacionOrigen.Value, MaxSmallint, MaxSmallint ] );
                First;
                While not Eof do
                  begin
                  If   ( DmLineaMovimientoAuxFields.CodigoArticulo.Value=CodigoArticulo.Value ) and
                       ( DmLineaMovimientoAuxFields.CodigoClaseA.Value=CodigoClaseA.Value ) and
                       ( DmLineaMovimientoAuxFields.CodigoClaseB.Value=CodigoClaseB.Value ) and
                       ( DmLineaMovimientoAuxFields.CodigoClaseC.Value=CodigoClaseC.Value )
                  then begin
                       Dataset.Edit;
                       NroRegistroOrigen.Value := DmLineaMovimientoAuxFields.NroRegistro.Value;
                       Result := True;
                       Break;
                       end;
                  Next;
                  end;
              finally
                CancelRange;
                end;
       end;
end;
}

procedure  TMovimientoModule.CompruebaCantidadPendientePedido(     DisplayValue          : Variant;
                                                                   LineaMovimientoFields : TLineaMovimientoFields;
                                                               var ErrorText             : TCaption;
                                                               var Error                 : Boolean );

var   CantidadAProcesar,
      CantidadAProcesarAnterior,
      Pendiente : Decimal;

begin
     DmLineaMovimientoAuxTable.CancelRange;

     With LineaMovimientoFields do
       If   ( TipoMovimientoOrigen.Value in [ tmPedidoCompra, tmPedidoVenta ] ) and not ValueIsEmpty( NroOperacionOrigen.Value )
       then begin

            CantidadAprocesar := VarToDecimal( DisplayValue );

            { //* 14.07.2025 Quitada la comprobación porque, por lo visto, hay usuarios que utilizan los pedidos de venta para registrar devoluciones(!!)
                             y luego necesitan modificar la línea del albarán exportado para indicar el lote del producto

            If   CantidadAprocesar<0.0
            then begin
                 Error := True;
                 ErrorText := JoinMessage( RsMsg30, RsMsg31 );
                 end
            else begin
            }
                 CantidadAprocesarAnterior := VarToDecimal( LineaMovimientoFields.Cantidad.OldValue );

                 If   TipoMovimientoOrigen.Value=tmPedidoVenta
                 then CantidadAprocesarAnterior := -CantidadAprocesarAnterior;

                 If   DataModule00.DmEmpresaFields.Stock_ImpedirPendienteEnExceso.Value
                 then begin
                      DmLineaMovimientoAuxTable.IndexFieldNames := 'NroRegistro';
                      If   DmLineaMovimientoAuxTable.FindKey( [ NroRegistroOrigen.Value ] )
                      then With DmLineaMovimientoAuxFields do
                             If   ( CantidadProcesada.Value - CantidadAProcesarAnterior + CantidadAProcesar ) > Cantidad.Value
                             then begin
                                  Error := True;
                                  ErrorText := JoinMessage( RsMsg28, RsMsg29 );
                                  end;
                      end;

                 end;
            {
            end;
            }
end;

procedure TMovimientoModule.DmReportSelectPrinter;
begin
     DmReport.ReportPrinter := InformeExterno.Impresora;
end;

procedure TMovimientoModule.DmReportSetReportName;
begin
      With DmReport, ParametrosInforme do
       begin
       If   FormatoImpreso=0
       then begin
            case TipoMovimientoListado of
              tmOferta       : FileName := 'fof';
              tmPedidoCompra : FileName := 'fpc';
              tmCompra       : FileName := 'fac';
              tmPresupuesto  : Filename := 'fpr';
              tmPedidoVenta  : FileName := 'fpv';
              tmVenta        : FileName := 'fav';
              else             FileName := 'fma';
              end;
            end
       else FileName := InformeExterno.Fichero;
       If   Titulo=''
       then Title := Format( RsImpresion, [ TextoTipoMovimiento( TipoMovimiento ) ] )
       else Title := Titulo;
       end;
end;

function TMovimientoModule.EstadoPedido( MovimientoFields  : TMovimientoFields ) : TEstadoPedido;

var   Cantidad,
      CantidadProcesada : Decimal;

begin

     Result.Situacion := epPendiente;
     Result.Procesada := False;

     With DmLineaMovimientoAuxTable do
       try

         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

         Cantidad := 0.0;
         CantidadProcesada := 0.0;

         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

         First;
         While not Eof do
           begin
           Result.Procesada := Result.Procesada or DmLineaMovimientoAuxFields.Procesada.Value;
           DecAdd( Cantidad, DmLineaMovimientoAuxFields.Cantidad.Value );
           DecAdd( CantidadProcesada, DmLineaMovimientoAuxFields.CantidadProcesada.Value );
           Next;
           end;

         If   CantidadProcesada=0.0
         then Result.Situacion := epPendiente
         else If   Cantidad<=CantidadProcesada
              then Result.Situacion := epProcesado
              else Result.Situacion := epParcialmenteProcesado;

       finally
         CancelRange;
         end;
end;

function TMovimientoModule.TextoSituacionPedido( TipoMovimiento : SmallInt;
                                                 Situacion      : TSituacionPedido ) : String;

var  CaptionText : String;

begin
     Result := '';
     If   TipoMovimiento=tmPedidoCompra
     then CaptionText := RsMsg10
     else CaptionText := RsMsg11;
     case Situacion of
       epPendiente             : Result := RsMsg23;
       epParcialmenteProcesado : Result := Format( RsMsg8, [ CaptionText ] );
       epProcesado             : Result := Format( RsMsg9, [ CaptionText ] );
       end;
end;

function TMovimientoModule.TextoSituacionPresupuesto( Estado : TEstadoPresupuesto ) : String;

const TEP : Array[ eprPendiente..eprCancelado ] of String = ( RsMsg23, 'Aceptado', 'Cancelado' );

begin
     Result := TEP[ Estado ];
end;

function TMovimientoModule.EstadoDocumento( MovimientoFields : TMovimientoFields;
                                            EstadoLabel      : TcxCustomEdit = nil ) : String;
begin
     With MovimientoFields do
       begin

       If   ValueIsEmpty( NroOperacion.Value )
       then Result := ''
       else begin

            Result := Format( RsMsg12, [ NroOperacion.Value ] );

            case TipoMovimiento.Value of

              tmPresupuesto   : StrAdd( Result, ' ' + TextoSituacionPresupuesto( Situacion.Value ) );

              tmPedidoCompra,
              tmPedidoVenta   : begin
                                StrAdd( Result, ' ' + TextoSituacionPedido( TipoMovimiento.Value, Situacion.Value ) );
                                If   Suministrado.Value  // De momento solo por el módulo 119
                                then StrAdd( Result, ' - Suministrado' );
                                end;

              tmCompra,
              tmVenta         : If   Facturado.Value
                                then begin
                                     StrAdd( Result, ' ' + Format( RsMsg13, [ Factura.TextoSerieNroFactura( SerieFactura.Value, NroFactura.Value ) ] ) );
                                     If   Traspasado.Value
                                     then StrAdd( Result, RsMsg14 );
                                     end
                                else If   NoFacturar.Value
                                     then StrAdd( Result, RsMsg24 );

              end;

            FOnUpdateEstadoDocumentoLabel.Invoke( MovimientoFields, Result );

            end;
       end;

     If   Assigned( EstadoLabel )
     then EstadoLabel.EditValue := Result;

end;


procedure TMovimientoModule.MuestraMotivoBloqueo( MovimientoFields : TMovimientoFields );

var Msg,
    DescMsg : String;

begin
     Msg := RsDocumentoBloqueado;

     If   MovimientoFields.Traspasado.Value
     then DescMsg := RsDocumentoContabilizado
     else If   MovimientoFields.Anulado.Value
          then DescMsg := RsDocumentoAnulado
          else If   MovimientoFields.Facturado.Value
               then DescMsg := RsDocumentoFacturado
               else If   not EjercicioActual( MovimientoFields.Fecha.Value )
                    then DescMsg := RsDocumentoOtroEjercicio;

     ShowHintMsg( Msg, DescMsg);
end;

function TMovimientoModule.OrigenDocumento( MovimientoFields : TMovimientoFields;
                                            OrigenLabel      : TcxLabel = nil ) : String;
begin
       If   ValueIsEmpty( MovimientoFields.Origen.Value )
       then OrigenLabel.Visible := False
       else With OrigenLabel do
              begin
              case MovimientoFields.Origen.Value of

                omVentaPeriodica :
                  begin
                  Caption := RsVentaPeriodica;
                  Style.TextColor := $0016A600;
                  end;

                omCapturador :
                  begin
                  Caption := RsCapturador;
                  Style.TextColor := $00DA6F00;
                  end;

                omHojaCarga :
                  begin
                  Caption := RsHojaCarga;
                  Style.TextColor := $00004AC6;
                  end;

                omPreventa :
                  begin
                  Caption := RsPreventa;
                  Style.TextColor := $00DA006F;
                  end;

                omDocumentoControlMercancias :
                  begin
                  Caption := RsDocumentoControlMercancias + ' ' + IntToStr( MovimientoFields.NroOperacionOrigen.Value );
                  Style.TextColor := $00DA006F;
                  end;

                omTiendaVirtual :
                  begin
                  Caption := RsTiendaVirtual;
                  Style.TextColor := $00DA6F00;
                  end;

                omAprovisionamiento :
                  begin
                  Caption := RsAprovisionamiento;
                  Style.TextColor := $00DA6F00;
                  end;

                omFacturaElectronica :
                  begin
                  Caption := RsFacturaElectronica;
                  Style.TextColor := $0000AAA4;
                  end;

                end;
              OrigenLabel.Visible := True;
              end;

end;

function TMovimientoModule.EsMovimientoCompra : Boolean;
begin
     Result := ParametrosInforme.TipoMovimiento in [ tmOferta, tmPedidoCompra, tmCompra ];
end;

function TMovimientoModule.SeriesEnDocumentosVenta( TipoMovimiento : TTipoMovimiento ) : Boolean;
begin
     Result := ( TipoMovimiento=tmVenta ) or ( ( TipoMovimiento in [ tmPresupuesto, tmPedidoVenta ] ) and DataModule00.DmEmpresaFields.Ventas_SeriesPedido.Value )
end;

procedure TMovimientoModule.LimpiaParametrosInforme;
begin
     FillChar( ParametrosInforme, SizeOf( ParametrosInforme ), #0 );
     ParametrosInforme.Ejercicio := ApplicationContainer.Ejercicio;
end;


procedure TMovimientoModule.ActualizaSeleccionInforme( ConstruyeConsulta : Boolean = True );

var  SQLState,
     NombreCampo,
     NombreTabla : String;
     SQLSet : TgxSQLSet;

procedure SeleccionarPor( TipoSeleccion  : SmallInt;
                          NombreCampo    : String;
                          Valores        : array of Variant;
                          Campos,
                          Tablas         : String;
                          Outer          : Boolean = False );

var  ASQLFilter : String;

procedure AddFilterValue( var Expression : String;
                              Value      : String );
begin
     If   Expression<>''
     then Value := ' AND ' + Value;
     Expression := Expression + Value;
end;

begin
     If   TipoSeleccion<>0
     then begin
          ASQLFilter := SQLVarsFormat( NombreCampo + ' BETWEEN ? AND ?', Valores );
          If   ParametrosInforme.PreseleccionDocumentos
          then AddFilterValue( FSQLFilter, ASQLFilter )
          else begin
               If   Outer
               then AddFilterValue( FSQLOuterFilter, ASQLFilter )
               else AddFilterValue( FSQLFilter, ASQLFilter );
               If   TipoSeleccion=2
               then begin
                    StrAdd( FSQLFields, ' , ' + Campos );
                    StrAdd( FSQLTables, ' ' + Tablas );
                    end;
               end;
          end;
end;

function GetSelectDateFieldName : String;
begin
     If   ParametrosInforme.FechaEntrega
     then begin
          If   not DataModule00.DmEmpresaFields.Ventas_FechaEntregaPorLinea.Value or
               ParametrosInforme.PreseleccionDocumentos or
               ParametrosInforme.Impreso
          then Result := 'Movimiento.FechaAplicacion'
          else begin
               FSeleccionPorFechaAplicacionLinea := True;
               Result := ''; // Result := 'LineaMovimiento.FechaAplicacion';
               end;
          end
     else If   ParametrosInforme.PreseleccionDocumentos
          then Result := 'Fecha'
          else Result := 'Movimiento.Fecha';
end;

function GetOrderDateFieldName : String;
begin
     If   ParametrosInforme.FechaEntrega
     then Result := 'FechaAplicacion'
     else Result := 'Fecha';
end;

function GetEjercicioFieldName : String;
begin
     If   ParametrosInforme.PreseleccionDocumentos
     then Result := 'Ejercicio'
     else Result := 'Movimiento.Ejercicio';
end;

begin

     With ParametrosInforme do
       begin

       If   Impreso
       then SQLSet := ImpresosSQLSet
       else SQLSet := ListadoSQLSet;

       FSQLFields := '';
       FSQLTables := '';

       FSQLOuterFilter := '';
       FSeleccionPorFechaAplicacionLinea := False;

       If   TipoMovimiento=tmNoDefinido
       then FSQLFilter := ''
       else begin

            FSQLFilter := SQLVarsFormat( 'TipoMovimiento=? ', [ TipoMovimiento ] );

            If   EsMovimientoCompra
            then begin
                 If   not TodasLasSeriesCompras
                 then SQLAddCondition( FSQLFilter, ' Serie=? ', [ Serie ] );
                 end
            else begin
                 DocumentoVentaConSeries := Movimiento.SeriesEnDocumentosVenta( TipoMovimiento );
                 If   DocumentoVentaConSeries
                 then If   SeleccionSerieSQL=''
                      then SQLAddCondition( FSQLFilter, ' Serie=? ', [ Serie ] )
                      else SQLAddCondition( FSQLFilter, SeleccionSerieSQL, [] );
                 end;

            end;

       If   SeleccionNroDocumento
       then If   TipoMovimientoListado=tmNoDefinido
            then begin
                 SQLAddCondition( FSQLFilter, GetEjercicioFieldName + '=? AND NroOperacion BETWEEN ? AND ?', [ Ejercicio, NroDocumentoInicial, NroDocumentoFinal ] );
                 If   Agrupar
                 then FSQLOrder := 'TipoMovimiento, NroOperacion'
                 else FSQLOrder := 'NroOperacion';
                 end
            else begin
                 SQLAddCondition( FSQLFilter, GetEjercicioFieldName + '=? AND NroDocumento BETWEEN ? AND ?', [ Ejercicio, NroDocumentoInicial, NroDocumentoFinal ] );
                 FSQLOrder := 'Serie, NroDocumento';
                 end;

       If   SeleccionFecha
       then begin

            var SelectDateFieldName := GetSelectDateFieldName;

            If   FSeleccionPorFechaAplicacionLinea
            then SQLAddCondition( FSQLOuterFilter, 'FechaAplicacion BETWEEN ? AND ?', [ FechaInicial, FechaFinal ] )
            else SQLAddCondition( FSQLFilter, SelectDateFieldName + ' BETWEEN ? AND ?', [ FechaInicial, FechaFinal ] );

            If   TipoMovimientoListado=tmNoDefinido
            then begin
                 FSQLOrder := GetOrderDateFieldName + ', NroOperacion';
                 If   Agrupar
                 then FSQLOrder := 'TipoMovimiento, ' + FSQLOrder;
                 end
            else FSQLOrder := 'Serie, ' + GetOrderDateFieldName + ', NroDocumento';
            end;

       If   SoloLineasPendientes
       then SQLAddCondition( FSQLOuterFilter, ' NOT ( CantidadAjustada - CantidadProcesada<=0.0 OR Procesada ) ', [] );

       NombreCampo := 'Nombre';

       If   PreseleccionDocumentos
       then NombreTabla := 'Movimiento'
       else If   Impreso
            then NombreTabla := 'Documento'
            else NombreTabla := 'DocumentoyLineas';

       If   TipoMovimientoListado=tmNoDefinido
       then begin
            StrAdd( FSQLFields, ', CAST( '''' AS NVARCHAR( 1 ) ) AS Nombre ' );  // Este campo existe en la relación de documentos
            end
       else begin

            If   EsMovimientoCompra
            then begin

                 If   not PreseleccionDocumentos
                 then NombreCampo := 'ProveedorNombre'; // En todos los documentos aparece como ProveedorNombre y hay que respetarlo
                 StrAdd( FSQLFields, ', Proveedor.Nombre AS ' + NombreCampo + ' ' );
                 StrAdd( FSQLTables, ' LEFT JOIN Proveedor ON ( ' + NombreTabla + '.Propietario=Proveedor.Codigo ) ' );

                 SeleccionarPor( SeleccionPropietario, 'Propietario', [ PropietarioInicial, PropietarioFinal ], 'Proveedor.Codigo AS CodigoGrupo, Proveedor.Nombre AS DescripcionGrupo', '' );
                 SeleccionarPor( SeleccionGrupo, 'Proveedor.Factura_CodigoGrupo', [ GrupoInicial, GrupoFinal ], 'GrupoProveedor.Codigo AS CodigoGrupo, GrupoProveedor.Descripcion AS DescripcionGrupo', 'LEFT JOIN GrupoProveedor ON ( GrupoProveedor.Codigo=Proveedor.Factura_CodigoGrupo ) ', True );
                 SeleccionarPor( SeleccionFormaCobro, 'CodigoFormaCobro', [ FormaCobroInicial, FormaCobroFinal ], 'FormaPago.Codigo AS CodigoGrupo, FormaPago.Descripcion AS DescripcionGrupo', 'LEFT JOIN FormaPago ON ( FormaPago.Codigo=' + NombreTabla + '.CodigoFormaCobro ) ' );

                 If   SeleccionRegistroAuxiliar<>0
                 then begin
                      If   PropietarioRegistroAuxiliar=''
                      then SeleccionarPor( SeleccionRegistroAuxiliar, 'RegistroAuxiliar', [ RegistroAuxiliarInicial, RegistroAuxiliarFinal ], 'AuxiliarProveedor.Codigo AS CodigoGrupo, AuxiliarProveedor.Campo1 AS DescripcionGrupo', 'LEFT JOIN AuxiliarProveedor ON ( AuxiliarProveedor.CodigoProveedor='''' AND AuxiliarProveedor.Codigo=' + NombreTabla + '.RegistroAuxiliar ) ' )
                      else begin
                           SQLAddCondition( FSQLFilter, ' Propietario=? ', [ PropietarioRegistroAuxiliar ] );
                           SeleccionarPor( SeleccionRegistroAuxiliar, 'RegistroAuxiliar', [ RegistroAuxiliarInicial, RegistroAuxiliarFinal ], 'AuxiliarProveedor.Codigo AS CodigoGrupo, AuxiliarProveedor.Campo1 AS DescripcionGrupo', 'LEFT JOIN AuxiliarProveedor ON ( AuxiliarProveedor.CodigoProveedor=' + NombreTabla + '.Propietario AND AuxiliarProveedor.Codigo=' + NombreTabla + '.RegistroAuxiliar ) ' );
                           end;
                      end;

                 end
            else begin

                 If   DocumentoVentaConSeries
                 then begin
                      StrAdd( FSQLFields, ', SerieFacturacion.Descripcion AS DescripcionSerie ' );
                      StrAdd( FSQLTables, ' LEFT JOIN SerieFacturacion ON ( ' + NombreTabla + '.Serie=SerieFacturacion.Codigo ) ' );
                      end;

                 If   not PreseleccionDocumentos
                 then NombreCampo := 'ClienteNombre';
                 StrAdd( FSQLFields, ', Cliente.Nombre AS '  + NombreCampo + ' ' );
                 StrAdd( FSQLTables, ' LEFT JOIN Cliente ON ( ' + NombreTabla + '.Propietario=Cliente.Codigo ) ' );

                 SeleccionarPor( SeleccionPropietario, 'Propietario', [ PropietarioInicial, PropietarioFinal ], 'Cliente.Codigo AS CodigoGrupo, Cliente.Nombre AS DescripcionGrupo', '' );
                 SeleccionarPor( SeleccionGrupo, 'GrupoFacturacion', [ GrupoInicial, GrupoFinal ], 'GrupoCliente.Codigo AS CodigoGrupo, GrupoCliente.Descripcion AS DescripcionGrupo', 'LEFT JOIN GrupoCliente On ( GrupoCliente.Codigo=' + NombreTabla + '.GrupoFacturacion ) ' );
                 SeleccionarPor( SeleccionVendedor, 'CodigoVendedor', [ VendedorInicial, VendedorFinal ], 'Vendedor.Codigo AS CodigoGrupo, Vendedor.Nombre AS DescripcionGrupo', 'LEFT JOIN Vendedor On ( Vendedor.Codigo=' + NombreTabla + '.CodigoVendedor ) ' );
                 SeleccionarPor( SeleccionFormaCobro, 'CodigoFormaCobro', [ FormaCobroInicial, FormaCobroFinal ], 'FormaCobro.Codigo AS CodigoGrupo, FormaCobro.Descripcion AS DescripcionGrupo', 'LEFT JOIN FormaCobro On ( FormaCobro.Codigo=' + NombreTabla + '.CodigoFormaCobro ) ' );
                 If   SeleccionRegistroAuxiliar<>0
                 then begin
                      If   PropietarioRegistroAuxiliar=''
                      then SeleccionarPor( SeleccionRegistroAuxiliar, 'RegistroAuxiliar', [ RegistroAuxiliarInicial, RegistroAuxiliarFinal ], 'AuxiliarCliente.Codigo AS CodigoGrupo, AuxiliarCliente.Campo1 AS DescripcionGrupo', 'LEFT JOIN AuxiliarCliente On ( AuxiliarCliente.CodigoCliente='''' AND AuxiliarCliente.Codigo=' + NombreTabla + '.RegistroAuxiliar ) ' )
                      else begin
                           SQLAddCondition( FSQLFilter, ' Propietario=? ', [ PropietarioRegistroAuxiliar ] );
                           SeleccionarPor( SeleccionRegistroAuxiliar, 'RegistroAuxiliar', [ RegistroAuxiliarInicial, RegistroAuxiliarFinal ], 'AuxiliarCliente.Codigo AS CodigoGrupo, AuxiliarCliente.Campo1 AS DescripcionGrupo', 'LEFT JOIN AuxiliarCliente On ( AuxiliarCliente.CodigoCliente=' + NombreTabla + '.Propietario AND AuxiliarCliente.Codigo=' + NombreTabla + '.RegistroAuxiliar ) ' );
                           end;
                      end;
                 SeleccionarPor( SeleccionTransportista, 'CodigoTransportista', [ TransportistaInicial, TransportistaFinal ], 'Transportista.Codigo AS CodigoGrupo, Transportista.Nombre AS DescripcionGrupo', 'LEFT JOIN Transportista On ( Transportista.Codigo=' + NombreTabla + '.CodigoTransportista ) ' );
                 end;

            If   Situacion<>0  // Todos
            then begin

                 case TipoMovimiento of
                   tmOferta       : case TSituacionOfertas( Situacion ) of
                                      sofPendientesRevision : SQLState := 'NOT Revisado';
                                      sofRevisadas          : SQLState := 'Revisado';
                                      end;

                   tmPresupuesto  : case TSituacionPresupuestos( Situacion ) of
                                      sprPendientes : SQLState := 'Situacion=0';
                                      sprAceptados  : SQLState := 'Situacion=1';
                                      sprCancelados : SQLState := 'Situacion=2';
                                      end;

                   tmPedidoCompra,
                   tmPedidoVenta   : case TSituacionPedidos( Situacion ) of
                                      spePendienteProcesarCompleto : SQLState := 'Situacion=0';
                                      spePendienteProcesar         : SQLState := 'Situacion IN (0,1)';
                                      speParcialmenteProcesados    : SQLState := 'Situacion=1';
                                      speProcesados                : SQLState := 'Situacion=2';
                                      end;

                   tmCompra,
                   tmVenta        : case TSituacionAlbaranes( Situacion ) of
                                      saaNoFacturables                 : SQLState := '( NoFacturar OR NoFacturar IS NULL )';
                                      saaFacturables                   : SQLState := 'NOT NoFacturar';
                                      saaPendientesFacturar            : SQLState := '( NOT Facturado OR Facturado IS NULL )';
                                      saaPendientesFacturarFacturables : SQLState := '( ( NOT Facturado OR Facturado IS NULL ) AND NOT NoFacturar )';
                                      saaFacturados                    : SQLState := 'Facturado';
                                      saaPendientesContabilizar        : SQLState := '( NOT Traspasado OR Traspasado IS NULL )';
                                      saaContabilizados                : SQLState := 'Traspasado';
                                      end;

                   end;

                 SQLAddCondition( FSQLFilter, SQLState, [] );
                 end;

            end;

       StrAdd( FSQLFilter, ' AND NOT Anulado ' );

       If   not PreseleccionDocumentos
       then begin
            // En los impresos no se selecciona información de las líneas.
            // Éstas se leen más tarde directamente de la tabla.
            If   not Impreso
            then StrAdd( FSQLOrder, ', NroPagina, NroLinea ' );
            If   TipoMovimientoListado<>tmNoDefinido
            then If   Agrupar
                 then FSQLOrder := 'Serie, CodigoGrupo, ' + FSQLOrder;
            end;

       If   ConstruyeConsulta
       then begin

            FSQLString := SQLSet.GetSQLText( 'Consulta' );
            FSQLLineFields := '';
            FSQLLineTable := '';
            FSQLOuterWhere := '';

            If   not Impreso
            then begin
                 FSQLLineFields := SQLSet.GetSQLText( 'ListaCamposLineas' );
                 FSQLLineTable :=  'LEFT JOIN LineaMovimiento ON ( Documento.Ejercicio=LineaMovimiento.Ejercicio AND Documento.NroOperacion=LineaMovimiento.NroOperacion ) ';
                 end;

            If   RelacionDocumentos
            then begin
                 FSQLMovimientosSelect := 'SELECT Movimiento.* FROM ' + TablaRelacionDocumentos + ' AS Relacion ' +
                                    ' LEFT JOIN Movimiento ON ( Movimiento.Ejercicio=Relacion.Ejercicio AND Movimiento.NroOperacion=Relacion.NroOperacion ) ';
                 SetSQLVar( FSQLString, 'SelectMovimientos', FSQLMovimientosSelect );
                 end
            else begin
                 FSQLMovimientosSelect := 'SELECT  ' + SQLSet.GetSQLText( 'ListaCamposMovimiento' ) + 'FROM Movimiento ';

                 StrAdd( FSQLMovimientosSelect, 'WHERE <Seleccion>' );
                 FSQLOuterWhere := SQLOuterFilter;
                 If   FSQLOuterWhere<>''
                 then FSQLOuterWhere := ' WHERE ' + FSQLOuterWhere;
                 SetSQLVar( FSQLString, 'SelectMovimientos', FSQLMovimientosSelect );
                 SetSQLVar( FSQLString, 'Seleccion', FSQLFilter );
                 end;

            SetSQLVar( FSQLString, 'ListaCamposLineas', FSQLLineFields );
            SetSQLVar( FSQLString, 'LineasTabla', FSQLLineTable );
            SetSQLVar( FSQLString, 'Tablas', FSQLTables );
            SetSQLVar( FSQLString, 'Campos', FSQLFields );
            SetSQLVar( FSQLString, 'WhereExterno', FSQLOuterWhere );
            SetSQLVar( FSQLString, 'Ordenacion', FSQLOrder );

            var SQLInto := '';

            If   Impreso and not GenerarFicheroPDF
            then begin
                 SQLInto := ' INTO <TableName> ';
                 StrAdd( FSQLString, ' CREATE INDEX Index_1 ON <TableName> ( Ejercicio, Nro_Operacion ); '  );
                 end;

            SetSQLVar( FSQLString,'Into', SQLInto );

            // FSQLString := StringReplace( FSQLString, #13#10, ' ', [ rfIgnoreCase, rfReplaceAll ] );  // Para un mejor debugging (luego lo quito)
            end;

       end;
end;

procedure TMovimientoModule.DoOnProcessRecordListado( Sender : TObject );

var   PrimerDocumento : Boolean;
      CodigoClase : String;
      ExistenciasArticulo : IExistenciasArticulo;

begin

     If   RptMovimientoTable.Eof or
          RptMovimientoFields.RegistroProcesado.Value
     then Exit;

     try

       RptMovimientoTable.Edit;

       If   ( EjercicioActualListado<>RptMovimientoFields.Ejercicio.Value ) or
            ( NroOperacionActual<>RptMovimientoFields.NroOperacion.Value )
       then begin
            EjercicioActualListado := RptMovimientoFields.Ejercicio.Value;
            NroOperacionActual := RptMovimientoFields.NroOperacion.Value;
            // Leer el registro del movimiento es sobre todo por la llamada a la función Movimiento.EstadoDocumento
            DmMovimientoImpresoTable.FindKey( [ EjercicioActualListado, NroOperacionActual ] );
            If   not EsMovimientoCompra
            then SerieFacturacion.Obten( DmMovimientoImpresoFields.Serie.Value, DsSerieFacturacionImpresoFields );
            end;

       With RptMovimientoFields do
         begin

         EstadoDocumento.Value := Movimiento.EstadoDocumento( DmMovimientoImpresoFields, nil );
         Pendiente.Value := Cantidad.Value - CantidadProcesada.Value;

         If   TipoMovimiento.Value=tmVenta
         then Cantidad.Value := -Cantidad.Value;

         If   ParametrosInforme.MostrarImportePendiente and ParametrosInforme.Valorar
         then begin
              Articulo.Obten( CodigoArticulo.Value, DsArticuloImpresoFields );
              If   EsMovimientoCompra
              then FacturaCompras.CalculaImportes( Pendiente, DsArticuloImpresoFields.UnidadesPrecioCompra, Precio, PuntoVerde, Descuento, nil, nil, ImportePendiente )
              else FacturaVentas.CalculaImportes( Pendiente, DsArticuloImpresoFields.UnidadesPrecioVenta, Precio, PuntoVerde, ContribucionRAP, Recargo, Descuento, nil, nil, ImportePendiente );
              end;

         If   CodigoArticulo.Value<>ArticuloManual
         then begin

              // En los listados detallados no se muestran los márgenes

              If   not ParametrosInforme.ListadoDetallado
              then begin

                   ExistenciasArticulo := StockAlmacen.ObtenStock( CodigoArticulo.Value,
                                                                   False,
                                                                   CodigoClaseA.Value,
                                                                   CodigoClaseB.Value,
                                                                   CodigoClaseC.Value,
                                                                   True,
                                                                   '', // LoteFabricacion
                                                                   False,
                                                                   CodigoAlmacen.Value,
                                                                   True,
                                                                   '',
                                                                   True,
                                                                   Ejercicio.Value,
                                                                   0,
                                                                   MonthOf( Fecha.Value ) );

                   StockActual.Value := ExistenciasArticulo.SumaExistencias.Saldo;
                   Coste.Value := ExistenciasArticulo.Coste * Cantidad.Value;
                   If   ImporteNeto.Value<>0.0
                   then Margen.Value := ( ( ImporteNeto.Value - Coste.Value ) * 100.0 ) / ImporteNeto.Value;

                   end;

              With DataModule00.DmEmpresaFields do
                If   ( TipoMovimiento.Value in [ tmCompra, tmVenta ] )
                then begin
                     If   ( Articulo_Envase.Value<>0 ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
                     then begin
                          CodigoClase := Clase.Selecciona( Articulo_Envase.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
                          EnvasesDeposito.Value := StockAlmacen.StockEnvases( Propietario.Value, trpEnvase, CodigoClase );
                          end;
                     If   ( Articulo_Contenedor.Value<>0 ) and ( Articulo_TipoContenedor.Value=tenReutilizable )
                     then begin
                          CodigoClase := Clase.Selecciona( Articulo_Contenedor.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
                          ContenedoresDeposito.Value := StockAlmacen.StockEnvases( Propietario.Value, trpContenedor, CodigoClase );
                          end;
                     end;

              end;

         end;

       RptMovimientoFields.RegistroProcesado.Value := True;
       RptMovimientoTable.Post;

     except
       RptMovimientoTable.Cancel;
       raise;
       end;

end;


procedure TMovimientoModule.DoOnProcessRecordImpreso( Sender : TObject );

var   I : SmallInt;
      RecordFieldValues : TFieldValuesArray;
      CodigoClase,
      CodigoISOPais,
      CodigoBIC,
      CodigoIBAN : String;
      TipoDeCambio : Double;
      SaveEof : Boolean;
      Bm : TBookmark;
      CodigoPaisIVA : String;

begin

       try

         If   RptCabeceraTable.Eof or
              RptCabeceraFields.RegistroProcesado.Value
         then Exit;

         Bm := RptCabeceraTable.GetBookmark;

         FCalculatingFields := True;

         CalcularIVA := True;

         RptCabeceraTable.Edit;

         InicializaValoresImpositivos( TasasArray );

         ImporteBrutoArticulos := 0.0;
         ImporteDescuentoArticulos := 0.0;
         ImporteNetoArticulos := 0.0;
         ImporteTotalPuntoVerde := 0.0;
         ImporteTotalContribucionRAP := 0.0;
         ImporteIVAIncluido := 0.0;

         If   ParametrosInforme.NroCopias=0
         then NroTotalCopias := 1
         else NroTotalCopias := ParametrosInforme.NroCopias;

         CodigoPaisIVA := CodigoEspaña;

         If   EsMovimientoCompra
         then begin
              Proveedor.Obten( RptCabeceraFields.CodigoPropietario.Value, '', DsProveedorImpresoFields );
              If   ValueIsEmpty( RptCabeceraFields.CodigoFormaPago.Value )
              then RptCabeceraFields.CodigoFormaPago.Value := DsProveedorImpresoFields.Pago_FormaPago.Value;

              RptCabeceraFields.DescripcionFormaPago.Value := FormaPago.Descripcion( RptCabeceraFields.CodigoFormaPago.Value, True );
              RptCabeceraFields.CodigoDivisa.Value := DsProveedorImpresoFields.CodigoDivisa.Value;
              CalcularIVA := CalcularIVA and ( DsProveedorImpresoFields.Factura_ModeloIVA.Value<>mipExento ) and not( DsProveedorImpresoFields.Origen.Value in [ ofrIntracomunitaria, ofrInversionSP ] );

              Proveedor.ObtenCodigosPaisBICeIBAN( DsProveedorImpresoFields, CodigoISOPais, CodigoBIC, CodigoIBAN );
              RptCabeceraFields.BIC.Value := CodigoBIC;
              RptCabeceraFields.IBAN.Value := CodigoIBAN;
              end
         else begin
              Cliente.Obten( RptCabeceraFields.CodigoPropietario.Value, '', DsClienteImpresoFields );
              CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( DsClienteImpresoFields );

              If   ValueIsEmpty( RptCabeceraFields.CodigoFormaPago.Value )
              then RptCabeceraFields.CodigoFormaPago.Value := DsClienteImpresoFields.Cobro_FormaCobro.Value;

              RptCabeceraFields.DescripcionFormaPago.Value := FormaCobro.Descripcion( RptCabeceraFields.CodigoFormaPago.Value, True );

              If   RptCabeceraFields.TipoMovimiento.Value=tmVenta
              then If   ParametrosInforme.CopiaPropietario and not ValueIsEmpty( DsClienteImpresoFields.Factura_NroCopiasAlbaran.Value ) and ( ParametrosInforme.NroCopias=0 )
                   then NroTotalCopias := DsClienteImpresoFields.Factura_NroCopiasAlbaran.Value;

              RptCabeceraFields.CodigoDivisa.Value := DsClienteImpresoFields.CodigoDivisa.Value;
              CalcularIVA := CalcularIVA and ( DsClienteImpresoFields.Factura_ModeloIVA.Value<>micExento );
              If   SerieFacturacion.Obten(  RptCabeceraFields.Serie.Value, DsSerieFacturacionImpresoFields, True )
              then CalcularIVA := CalcularIVA and not DsSerieFacturacionImpresoFields.ExentoIVA.Value;

              Cliente.ObtenCodigosPaisBICeIBAN( DsClienteImpresoFields, CodigoISOPais, CodigoBIC, CodigoIBAN );
              RptCabeceraFields.BIC.Value := CodigoBIC;
              RptCabeceraFields.IBAN.Value := CodigoIBAN;
              end;

         If   RptCabeceraFields.CodigoDivisa.Value<>''
         then begin
              If   Divisa.Obten( RptCabeceraFields.CodigoDivisa.Value, DsDivisaImpresoFields )
              then begin
                   RptCabeceraFields.DescripcionDivisa.Value := DsDivisaImpresoFields.Descripcion.Value;
                   RptCabeceraFields.PrecisionDivisa.Value := DsDivisaImpresoFields.PrecisionRedondeo.Value;
                   end;
              If   dm_tca.TipoCambio.Obten( RptCabeceraFields.CodigoDivisa.Value, RptCabeceraFields.FechaDocumento.Value, TipoDeCambio )
              then RptCabeceraFields.TipoCambio.Value := TipoDeCambio;
              end;

         RptCabeceraFields.CodigoEmpresa.Value := CodigoEmpresaActual;

         If   ParametrosInforme.Valorar
         then begin

              If   ParametrosInforme.TipoMovimiento=tmVenta
              then With RptCabeceraFields do
                     RptCabeceraFields.TotalACuentaPedidos.Value := EntregasACuentaPedidosOrigen( Ejercicio.Value, NroOperacion.Value, Serie.Value, NroFactura.Value );

              //* 02.07.2010  Incluyo las cuotas de IVA y RE de los portes

              ImporteIVAPortes := 0.0;
              ImporteREPortes := 0.0;

              If   CalcularIVA
              then begin
                   If   EsMovimientoCompra
                   then FacturaCompras.ObtenCuotaPortes( RptCabeceraFields.Portes.Value, RptCabeceraFields.FechaDocumento.Value, DsProveedorImpresoFields.Factura_ModeloIVA.Value, ImporteIVAPortes )
                   else FacturaVentas.ObtenCuotasPortes( RptCabeceraFields.Portes.Value, RptCabeceraFields.FechaDocumento.Value, DsClienteImpresoFields.Factura_ModeloIVA.Value, ImporteIVAPortes, ImporteREPortes );
                   RptCabeceraFields.CuotaIVAPortes.Value := ImporteIVAPortes;
                   RptCabeceraFields.CuotaREPortes.Value := ImporteREPortes;
                   end;

              end;

         // Primero paso las páginas (si están activadas). Hay que tener en cuenta que los informes de versiones anteriores existentes no incluyen la tabla GrupoLinea.

         If   Assigned( RptGrupoLineasTable )
         then With DmGrupoLineaMovimientoImpresoTable do
                try

                  IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';

                  With RptCabeceraFields do
                    SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );

                  First;
                  While not Eof do
                    begin

                    RptGrupoLineasTable.Append;

                    With RptGrupoLineasFields do
                      begin
                       EjercicioDocumento.Value := RptCabeceraFields.Ejercicio.Value;
                       NroOperacionDoc.Value := RptCabeceraFields.NroDocumento.Value;
                       NroPagina.Value := DmGrupoLineaMovimientoImpresoFields.NroPagina.Value;
                       CodigoGrupo.Value := DmGrupoLineaMovimientoImpresoFields.CodigoGrupo.Value;
                       Descripcion.Value := DmGrupoLineaMovimientoImpresoFields.Descripcion.Value;
                       Anotacion.Value := DmGrupoLineaMovimientoImpresoFields.Anotacion.Value;
                      end;

                    With RptGrupoLineasTable do
                      begin
                      RecordFieldValues := GetFieldValues;
                      For I := 1 to NroTotalCopias do
                        begin
                        If   I>1
                        then begin
                             Append;
                             SetFieldValues( RecordFieldValues );
                             end;
                        try
                          Edit;
                          RptGrupoLineasFields.NroOperacion.Value := NroOperacionActual + Pred( I );
                          Post;
                        except
                          Cancel;
                          raise;
                          end;

                        end;
                      end;

                    Next;
                    end;

                finally
                  CancelRange;
                  end;

         // Y luego, las líneas

         With DmLineaMovimientoImpresoTable do
           try

             IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

             With RptCabeceraFields do
               SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

             First;
             While not Eof do
               begin

               Movimiento.AcumulaValoresImpositivosLinea( DmLineaMovimientoImpresoFields, CodigoPaisIVA, TasasArray, EsMovimientoCompra );

               RptLineasTable.Append;

               With RptLineasFields do
                 begin

                 TotalBultos.Value := 0.0;
                 TotalKilos.Value := 0.0;
                 TotalVolumen.Value := 0.0;
                 Largo.Value := DmLineaMovimientoImpresoFields.Largo.Value;
                 Ancho.Value := DmLineaMovimientoImpresoFields.Ancho.Value;
                 Alto.Value := DmLineaMovimientoImpresoFields.Alto.Value;

                 If   ParametrosInforme.TipoMovimiento=tmVenta
                 then Cantidad.Value := -DmLineaMovimientoImpresoFields.Cantidad.Value
                 else Cantidad.Value := DmLineaMovimientoImpresoFields.Cantidad.Value;

                 If   Articulo.Obten( DmLineaMovimientoImpresoFields.CodigoArticulo.Value, DsArticuloImpresoFields )
                 then begin

                      CodigoArticulo.Value := DsArticuloImpresoFields.Codigo.Value;
                      AsignacionOrigen.Value := DmLineaMovimientoImpresoFields.AsignacionOrigen.Value;

                      If   Cantidad.Value>0.0
                      then begin

                           RptCabeceraFields.SumaCajas.Value := RptCabeceraFields.SumaCajas.Value + DmLineaMovimientoImpresoFields.nroCajas.Value;

                           If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value and
                                ( DsArticuloImpresoFields.UnidadesPorPallet.Value<>0.0 )
                           then With TotalPallets do
                                  begin
                                  Value := Cantidad.Value / DsArticuloImpresoFields.UnidadesPorPallet.Value;
                                  If   Value<>Round( Value )
                                  then Value := Int( Value ) + 1;
                                  RptCabeceraFields.SumaPallets.Value := RptCabeceraFields.SumaPallets.Value + Value;
                                  end;

                           If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
                           then begin

                                If   DmLineaMovimientoImpresoFields.Bultos.Value=0.0
                                then TotalBultos.Value := Cantidad.Value * DsArticuloImpresoFields.Bultos.Value
                                else TotalBultos.Value := DmLineaMovimientoImpresoFields.Bultos.Value;

                                TotalKilos.Value   := Cantidad.Value * DsArticuloImpresoFields.Kilos.Value;
                                TotalVolumen.Value := Cantidad.Value * DsArticuloImpresoFields.Volumen.Value;

                                RptCabeceraFields.SumaBultos.Value  := RptCabeceraFields.SumaBultos.Value + TotalBultos.Value;
                                RptCabeceraFields.SumaKilos.Value   := RptCabeceraFields.SumaKilos.Value + TotalKilos.Value;
                                RptCabeceraFields.SumaVolumen.Value := RptCabeceraFields.SumaVolumen.Value + TotalVolumen.Value;
                                end;

                           end;

                      end;

                 If   ParametrosInforme.Valorar
                 then begin

                      Precio.Value := DmLineaMovimientoImpresoFields.Precio.Value;
                      PrecioDivisa.Value := DmLineaMovimientoImpresoFields.PrecioDivisa.Value;
                      PuntoVerde.Value := DmLineaMovimientoImpresoFields.PuntoVerde.Value;
                      Recargo.Value := DmLineaMovimientoImpresoFields.Recargo.Value;
                      If   ParametrosInforme.MostrarDescuentos
                      then Descuento.Value := DmLineaMovimientoImpresoFields.Descuento.Value;

                      CuotaIVA.Value := DmLineaMovimientoImpresoFields.CuotaIVA.Value;
                      CuotaRE.Value := DmLineaMovimientoImpresoFields.CuotaRE.Value;
                      PrecioIVAIncluido.Value := DmLineaMovimientoImpresoFields.PrecioIVA.Value;
                      TotalLinea.Value := DmLineaMovimientoImpresoFields.ImporteTotal.Value;
                      ImportePuntoVerde.Value := Cantidad.Value * DmLineaMovimientoImpresoFields.PuntoVerde.Value;
                      ImporteContribucionRAP.Value := DmLineaMovimientoImpresoFields.ContribucionRAP.Value;
                      ImporteBruto.Value := DmLineaMovimientoImpresoFields.ImporteBruto.Value;
                      ImporteDescuento.Value := DmLineaMovimientoImpresoFields.ImporteDescuento.Value;

                      ImporteNeto.Value := DmLineaMovimientoImpresoFields.ImporteNeto.Value;
                      TotalLinea.Value := DmLineaMovimientoImpresoFields.ImporteTotal.Value;

                      DecAdd( ImporteBrutoArticulos, DmLineaMovimientoImpresoFields.ImporteBruto.Value );
                      DecAdd( ImporteDescuentoArticulos, DmLineaMovimientoImpresoFields.ImporteDescuento.Value );
                      DecAdd( ImporteNetoArticulos, DmLineaMovimientoImpresoFields.ImporteNeto.Value );
                      DecAdd( ImporteTotalPuntoVerde, ImportePuntoVerde.Value );
                      DecAdd( ImporteTotalContribucionRAP, ImporteContribucionRAP.Value );
                      DecAdd( ImporteIVAIncluido, TotalLinea.Value );

                      end;

                 EjercicioDocumento.Value := RptCabeceraFields.Ejercicio.Value;
                 NroOperacionDoc.Value := RptCabeceraFields.NroDocumento.Value;
                 NroRegistroDoc.Value := DmLineaMovimientoImpresoFields.NroRegistro.Value;
                 NroRegistro.Value := DmLineaMovimientoImpresoFields.NroLinea.Value;
                 NroPagina.Value := DmLineaMovimientoImpresoFields.NroPagina.Value;
                 NroLinea.Value := DmLineaMovimientoImpresoFields.NroLinea.Value;
                 TipoMovimientoOrigen.Value := DmLineaMovimientoImpresoFields.TipoMovimientoOrigen.Value;
                 EjercicioOrigen.Value := DmLineaMovimientoImpresoFields.EjercicioOrigen.Value;
                 NroOperacionOrigen.Value := DmLineaMovimientoImpresoFields.NroOperacionOrigen.Value;
                 NroRegistroOrigen.Value := DmLineaMovimientoImpresoFields.NroRegistroOrigen.Value;
                 FechaAplicacion.Value := DmLineaMovimientoImpresoFields.FechaAplicacion.Value;
                 If   EsMovimientoCompra
                 then Referencia.Value := Articulo.ReferenciaProveedor( RptCabeceraFields.CodigoPropietario.Value, DmLineaMovimientoImpresoFields.CodigoArticulo.Value, True ) // Código interno
                 else Referencia.Value := Articulo.ReferenciaCliente( RptCabeceraFields.CodigoPropietario.Value, DmLineaMovimientoImpresoFields.CodigoArticulo.Value );
                 CodigoClaseA.Value := DmLineaMovimientoImpresoFields.CodigoClaseA.Value;
                 DescripcionClaseA.Value := Clase.descripcion( tcClaseA, DmLineaMovimientoImpresoFields.CodigoClaseA.Value, True );
                 CodigoClaseB.Value := DmLineaMovimientoImpresoFields.CodigoClaseB.Value;
                 DescripcionClaseB.Value := Clase.Descripcion( tcClaseB, DmLineaMovimientoImpresoFields.CodigoClaseB.Value, True );
                 CodigoClaseC.Value := DmLineaMovimientoImpresoFields.CodigoClaseC.Value;
                 DescripcionClaseC.Value := Clase.descripcion( tcClaseC, DmLineaMovimientoImpresoFields.CodigoClaseC.Value, True );
                 LoteFabricacion.Value := DmLineaMovimientoImpresoFields.LoteFabricacion.Value;
                 NumeroSerie.Value := DmLineaMovimientoImpresoFields.NumeroSerie.Value;
                 CampoLibre1.Value := DmLineaMovimientoImpresoFields.CampoLibre1.Value;
                 CampoLibre2.Value := DmLineaMovimientoImpresoFields.CampoLibre2.Value;
                 CampoLibre3.Value := DmLineaMovimientoImpresoFields.CampoLibre3.Value;
                 CampoLibre4.Value := DmLineaMovimientoImpresoFields.CampoLibre4.Value;
                 Descripcion.Value := DmLineaMovimientoImpresoFields.Descripcion.Value;
                 Anotacion.Value := DmLineaMovimientoImpresoFields.Anotacion.Value;
                 TipoLinea.Value := DmLineaMovimientoImpresoFields.TipoLinea.Value;
                 CodigoAlmacen.Value := DmLineaMovimientoImpresoFields.CodigoAlmacen.Value;
                 CodigoUbicacion.Value := DmLineaMovimientoImpresoFields.Ubicacion.Value;

                 If   ParametrosInforme.Valorar
                 then begin
                      Precio.Value := DmLineaMovimientoImpresoFields.Precio.Value;
                      PuntoVerde.Value := DmLineaMovimientoImpresoFields.PuntoVerde.Value;
                      ImporteContribucionRAP.Value := DmLineaMovimientoImpresoFields.ContribucionRAP.Value;
                      Recargo.Value := DmLineaMovimientoImpresoFields.Recargo.Value;
                      If   ParametrosInforme.MostrarDescuentos
                      then Descuento.Value := DmLineaMovimientoImpresoFields.Descuento.Value;
                      end;

                 Tasa.TipoIVA( DmLineaMovimientoImpresoFields.Fecha.Value, CodigoPaisIVA, DmLineaMovimientoImpresoFields.CodigoTipoIVA.Value, DsTiposIVAFields );

                 If   EsMovimientoCompra
                 then TipoIVA.Value := DsTiposIVAFields.IVASoportado.Value
                 else begin
                       TipoIVA.Value := DsTiposIVAFields.IVARepercutido.Value;
                       If   DsClienteImpresoFields.Factura_ModeloIVA.Value=micConRE
                       then TipoRE.Value := DsTiposIVAFields.RERepercutido.Value;
                       end;

                 With DataModule00.DmEmpresaFields do
                   begin
                   If   ( Articulo_Envase.Value<>0 ) and ( Articulo_TipoEnvase.Value=tenReutilizable )
                   then begin
                        CodigoClase := Clase.Selecciona( Articulo_Envase.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
                        EnvasesDeposito.Value := StockAlmacen.StockEnvases( RptCabeceraFields.CodigoPropietario.Value, trpEnvase, CodigoClase );
                        end;
                   If   ( Articulo_Contenedor.Value<>0 ) and ( Articulo_TipoContenedor.Value=tenReutilizable )
                   then begin
                        CodigoClase := Clase.Selecciona( Articulo_Contenedor.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value );
                        ContenedoresDeposito.Value := StockAlmacen.StockEnvases( RptCabeceraFields.CodigoPropietario.Value, trpContenedor, CodigoClase );
                        end;
                   end;

                 NroCajas.Value := DmLineaMovimientoImpresoFields.NroCajas.Value;
                 end;

               With RptLineasTable do
                 begin
                 RecordFieldValues := GetFieldValues;
                 For I := 1 to NroTotalCopias do
                   begin
                   try

                     If   I>1
                     then begin
                          Append;
                          SetFieldValues( RecordFieldValues );
                          end;

                     Edit;
                     RptLineasFields.NroOperacion.Value := NroOperacionActual + Pred( I );
                     Post;
                   except
                     Cancel;
                     raise;
                     end;

                   end;
                 end;

               Next;
               end;

           finally
             CancelRange;
             end;

         If   ParametrosInforme.Valorar
         then begin

              If   EsMovimientoCompra
              then FacturaCompras.AcumulaValoresImpositivos( TasasArray, RptCabeceraFields.FechaDocumento.Value, DsProveedorImpresoFields.Factura_ModeloIVA.Value, CalcularIVA, Sumas )
              else FacturaVentas.AcumulaValoresImpositivos( TasasArray, RptCabeceraFields.FechaDocumento.Value, DsClienteImpresoFields.Factura_ModeloIVA.Value, CalcularIVA, Sumas );

              If   RptCabeceraFields.Portes.Value<>0.0
              then begin

                   // La función Tasa.TipoIVAGlobal lee el registro donde se guarda el código del tipo impositivo de los portes, que es lo que devuelve
                   // La llamada posterior a la función Tasa.TipoIVA lee el registro del tipo de IVA correspondiente

                   var Fecha := DmLineaMovimientoImpresoFields.Fecha.Value;
                   var TipoIVAPortes := Tasa.TipoIVAGlobal( Fecha, CodigoPaisIVA, rgTipoIVAPortes );
                   Tasa.TipoIVA( Fecha, TipoIVAPortes, DsTiposIVAFields );

                   TasasArray[ TipoIVAPortes ].TipoIVA := DsTiposIVAFields.IVARepercutido.Value;
                   TasasArray[ TipoIVAPortes ].TipoRE := DsTiposIVAFields.RERepercutido.Value;

                   DecAdd( TasasArray[ TipoIVAPortes ].BaseImponible, RptCabeceraFields.Portes.Value );
                   DecAdd( TasasArray[ TipoIVAPortes ].CuotaIVA, RptCabeceraFields.CuotaIVAPortes.Value );
                   DecAdd( TasasArray[ TipoIVAPortes ].CuotaRE, RptCabeceraFields.CuotaREPortes.Value );
                   DecAdd( TasasArray[ TipoIVAPortes ].Importe, RptCabeceraFields.Portes.Value + RptCabeceraFields.CuotaIVAPortes.Value + RptCabeceraFields.CuotaREPortes.Value );
                   end;

              RptCabeceraFields.PrimerTipoIVA.Value := Sumas.TipoIVA;
              RptCabeceraFields.PrimerTipoRE.Value := Sumas.TipoRE;

              RptCabeceraFields.BrutoArticulos.Value := Redondea( ImporteBrutoArticulos );
              RptCabeceraFields.NetoArticulos.Value := Redondea( ImporteNetoArticulos );
              RptCabeceraFields.DescuentoArticulos.Value := Redondea( ImporteDescuentoArticulos );
              RptCabeceraFields.ImportePuntoVerde.Value := Redondea( ImporteTotalPuntoVerde );
              RptCabeceraFields.TotalContribucionRAP.Value := Redondea( ImporteTotalContribucionRAP, 4 );
              RptCabeceraFields.ImporteNeto.Value := Redondea( Sumas.BaseImponible );
              RptCabeceraFields.TotalCuotaIVA.Value := Redondea( Sumas.CuotaIVA + RptCabeceraFields.CuotaIVAPortes.Value );
              RptCabeceraFields.TotalCuotaRE.Value := Redondea( Sumas.CuotaRE + RptCabeceraFields.CuotaREPortes.Value );

              For I := 1 to 6 do
                begin
                RptCabeceraFields.BaseImponible[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 1, TasasArray ) );
                RptCabeceraFields.TipoIVA[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 2, TasasArray ) );
                RptCabeceraFields.CuotaIVA[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 3, TasasArray ) );
                RptCabeceraFields.TipoRE[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 4, TasasArray ) );
                RptCabeceraFields.CuotaRE[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 5, TasasArray ) );
                RptCabeceraFields.ImporteTotal[ I ].Value := Redondea( FacturaVentas.DesgloseIVA( I, 6, TasasArray ) );
                end;

              RptCabeceraFields.SumaIVAyRE.Value := RptCabeceraFields.TotalCuotaIVA.Value + RptCabeceraFields.TotalCuotaRE.Value;
              RptCabeceraFields.TotalImporte.Value := RptCabeceraFields.ImporteNeto.Value + RptCabeceraFields.Portes.Value + RptCabeceraFields.SumaIVAyRE.Value;

              end;

         RptCabeceraFields.RegistroProcesado.Value := True;

         RptCabeceraTable.Post;

         With RptCabeceraFields, RptCabeceraTable do
           begin
           RecordFieldValues := GetFieldValues;
           For I := 1 to NroTotalCopias do
             begin
             try

               If   I>1
               then begin
                    Append;
                    SetFieldValues( RecordFieldValues );
                    end;
               Edit;

               // Este NroOperacion no es el del documento, sino el registro que me permite generar copias agrupadas y mantener el informe ordenado por el criterio original,
               // porque se ha generado usando una sentencia SQL con ORDER BY pero leído de forma secuencial segun su creación (csSeqAccessIndexName)

               NroOperacion.Value := NroOperacionActual + Pred( I );
               If   ParametrosInforme.CopiaPropietario
               then NroCopia.Value := I
               else NroCopia.Value := 0;
               Post;

             except
               Cancel;
               raise;
               end;

             end;
           end;

         Inc( NroOperacionActual, NroTotalCopias );

         ActualizaFechaEmision( RptCabeceraFields );

         ApplicationContainer.ShowProgression;

       finally
         FCalculatingFields := False;
         RptCabeceraTable.GotoBookmark( Bm );
         end;

  end;

procedure TMovimientoModule.CreaFicherosListado;

var  IndexFldNames : String;

begin

     EjercicioActualListado := 0;
     NroOperacionActual := 0;

     FrxMovimientoTable := ParametrosInforme.Report.CreateQueryIntoReportTable( 'Movimientos', Movimiento.SQLString );
     RptMovimientoTable := FrxMovimientoTable.Table;

     If   Assigned( FrxMovimientoTable.Database )
     then FrxMovimientoTable.Database.DatabaseSource := dsServerTemporal;

     FrxMovimientoTable.OnFirst := DoOnProcessRecordListado;
     FrxMovimientoTable.OnNext := DoOnProcessRecordListado;

     IndexFldNames := StringReplace( Movimiento.SQLOrder, ' ', '', [ rfReplaceAll ] );
     IndexFldNames := StringReplace( IndexFldNames, ',', ';', [ rfReplaceAll ] );

     RptMovimientoTable.AddIndex( 'I1', IndexFldNames, [] );
     RptMovimientoTable.IndexName := 'I1';

     // Cuidado : hay que asignar RptMovimientoFields depués de añadir el índice porque la tabla se cierra y vuelve a abrir en la llamada a AddIndex

     RptMovimientoFields := TConsultaMovimientoFields.Create( RptMovimientoTable );

     ParametrosInforme.Report.MainDataset := RptMovimientoTable;
end;

procedure TMovimientoModule.CreaFicherosImpreso( SQLCommand : String = '' );
begin

     With ParametrosInforme.Report do
       begin

       NroOperacionActual := 1;

       If   SQLCommand=''
       then FrxCabeceraTable := CreateEmptyReportTable( 'Cabecera', DataModule30.SQLSet, tsServerSide, { OpenTable } False )
       else FrxCabeceraTable := CreateQueryIntoReportTable( 'Cabecera', SQLCommand );

       RptCabeceraTable := FrxCabeceraTable.Table;

       // Reasigno el tipo de la base de datos porque ha cambiado de dsTemporal a dsServerTemporal

       If   Assigned( FrxCabeceraTable.Database )
       then FrxCabeceraTable.Database.DatabaseSource := dsServerTemporal;

       FrxCabeceraTable.OnFirst := DoOnProcessRecordImpreso;
       FrxCabeceraTable.OnNext := DoOnProcessRecordImpreso;

       If   SQLCommand=''
       then RptCabeceraTable.IndexFieldNames := ''
       else begin
            RptCabeceraTable.IndexFieldNames := 'Ejercicio;Nro_Operacion';
            RptCabeceraFields := TCabeceraFields.Create( RptCabeceraTable );  // No asigno RptCabeceraFields porque necesito abrir y cerrar la tabla más adelante
            end;

       RptCabeceraTable.Open;

       If   Assigned( GetReportTable( 'Paginas' ) )
       then begin
            RptGrupoLineasTable := CreateEmptyTable( 'Paginas', DataModule30.SQLSet, tsServerSide );
            RptGrupoLineasFields := TGrupoLineasFields.Create( RptGrupoLineasTable );
            end
       else begin
            RptGrupoLineasTable := nil;
            RptGrupoLineasFields := nil;
            end;

       FrxLineasTable := CreateEmptyReportTable( 'Lineas', DataModule30.SQLSet, tsServerSide, { OpenTable } False );
       RptLineasTable := FrxLineasTable.Table;

       // El usuario puede indicar una ordenación diferente para las líneas. En ese caso se crea un índice adicional con los campos indicados.

       If   FrxLineasTable.IndexFieldNames<>'NroOperacion'
       then begin
            var IFN := FrxLineasTable.IndexFieldNames;
            RptLineasTable.IndexFieldNames := '';
            RptLineasTable.AddIndex( 'I1', IFN, [] );
            RptLineasTable.IndexFieldNames := IFN;
            end;

       RptLineasTable.Open;
       RptLineasFields := TLineasFields.Create( RptLineasTable );

       MainDataSet := RptCabeceraTable;
       end;

end;

procedure TMovimientoModule.InformeMovimientos;
begin

     With ParametrosInforme do
       begin

       FormatoImpreso := Formato;

       If   not Assigned( Report )
       then Report := DmReport;

       With Report do
         begin

         If   GenerarFicheroPDF
         then begin
              MainDataSet := nil;
              CreateProcessForm( ExportaFicheroMovimientos, RsMsg54 );
              end
         else try

                Load( False );

                ActualizaSeleccionInforme;
                CreaFicherosImpreso( SQLString );

                ToPrinter := DirectamenteAImpresora;
                ShowDialog := not NoPedirImpresora;

                SetValue( RsPartidasPresupuestarias, DataModule00.PartidasPresupuestarias );

                OpenReportTables;

                If   EsMovimientoCompra
                then FacturaCompras.FijaDecimalesInforme( Report )
                else FacturaVentas.FijaDecimalesInforme( Report );

                Start;

                Detach;

              except on E : Exception do Cancel( E );
                end;

         end;

       end;

end;

function TMovimientoModule.ExportaDocumento(       MovimientoOrigenFields   : TMovimientoFields;
                                                   TipoMovimientoDestino    : TTipoMovimiento;
                                                   CodigoPropietario,
                                                   Serie                    : String;
                                                   NroDocumento             : LongInt;
                                             const LineList                 : TLongIntArray = nil;
                                                   SoloCantidadesPendientes : Boolean = False;
                                                   DocumentoAutomatico      : Boolean = False;
                                                   CopiarDatosCabecera      : Boolean = False ) : IMovimiento;
begin
     FBeforeUpdateMovimiento.Invoke( TipoMovimientoDestino, CodigoPropietario );
     Result := MovimientoService.ExportaDocumento( TMovimiento.FromDataset( MovimientoOrigenFields ), TipoMovimientoDestino, CodigoPropietario, Serie, NroDocumento, LineList, SoloCantidadesPendientes, DocumentoAutomatico, CopiarDatosCabecera );
end;

procedure TMovimientoModule.ExportaFicheroMovimientos;

var  DirectoryName,
     AlmacenDocumentosPath,
     PathFicheroAlmacen,
     ExportFileName : String;
     SubjectStringList : TStringList;
     SubjectTextTemplate,
     SubjectText : String;
     TipoDatoExportado : SmallInt;
     EnviarDocumentoPorCorreo,
     ExisteFichaPropietario : Boolean;
     NombrePropietario,
     EMailPropietario : String;
     DestinatariosArray : TStringArray;
     TipoDocumento : TTipoDocumento;
     TipoPropietario : TTipoPropietario;
     Bm : TBookmark;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsSerie ] := DmMovimientoQueryFields.Serie.Value;
       HeaderList.Values[ RsNroDocumento ] := IntToStr( DmMovimientoQueryFields.NroDocumento.Value );
       HeaderList.Values[ RsFecha ] := StrFormatDate( DmMovimientoQueryFields.Fecha.Value );
       HeaderList.Values[ RsCodigoPropietario ] := DmMovimientoQueryFields.Propietario.Value;
       HeaderList.Values[ RsNombrePropietario ] := NombrePropietario;
       end;
end;

begin

     With ParametrosInforme do
       try

         Report.DoOnSetReportName;

         SubjectTextTemplate := '';
         SubjectStringList := TStringList.Create;
         try
           try
             SubjectStringList.LoadFromFile( AddPathDelim( ApplicationPath ) + 'Reports\' + Report.FileName + '.txt' );
             SubjectTextTemplate := SubjectStringList.Text;
           finally
             SubjectStringList.Free;
             end;
         except
           If   EsMovimientoCompra
           then SubjectTextTemplate := RsMsg57    // Estimado proveedor
           else SubjectTextTemplate := RsMsg56;   // Estimado cliente
           SubjectTextTemplate := SubjectTextTemplate + RsMsg58;
           end;

         ActualizaSeleccionInforme;

         DmMovimientoQuery.SQL.Text := SQLString;
         DmMovimientoQuery.Open;
         // La consulta incluye todos los campos de MovimientoTable
         DmMovimientoQueryFields := TMovimientoFields.Create( DmMovimientoQuery );

         ApplicationContainer.StartProgression( DmMovimientoQuery.RecordCount );

         DmMovimientoQuery.First;
         While not DmMovimientoQuery.Eof and not ProcessFrame.Canceled do
           begin

           try

             try

             ProcessFrame.AddRecordMsg( Format( RsMsg37, [ DmMovimientoQueryFields.Propietario.Value ] ) );

             ExisteFichaPropietario := True;
             EnviarDocumentoPorCorreo := True;

             case DmMovimientoQueryFields.TipoMovimiento.Value of
               tmOferta,
               tmPresupuesto :
                 TipoDocumento := tdmOfertaPresupuesto;
               tmPedidoCompra,
               tmPedidoVenta :
                 TipoDocumento := tdmPedido;
               else
                 TipoDocumento := tdmAlbaran;
               end;

             If   EsMovimientoCompra
             then begin
                  If   Proveedor.Obten( DmMovimientoQueryFields.Propietario.Value, '', DsProveedorFields )
                  then begin
                       NombrePropietario := DsProveedorFields.Nombre.Value;
                       EMailPropietario := DsProveedorFields.Email.Value;
                       end
                  else ExisteFichaPropietario := False;
                  TipoPropietario := tdpProveedor;
                  end
             else begin
                  If   Cliente.Obten( DmMovimientoQueryFields.Propietario.Value, '', DsClienteFields )
                  then begin
                       NombrePropietario := DsClienteFields.Nombre.Value;
                       EMailPropietario := DireccionContacto.ObtenDireccionCorreo( tdpCliente, DsClienteFields.Codigo.Value, TipoDocumento, DsClienteFields.Email.Value );
                       end
                  else ExisteFichaPropietario := False;
                  TipoPropietario := tdpCliente;
                  end;

             If   not ExisteFichaPropietario
             then begin
                  ProcessFrame.AddMsg( ntError, Format( RsMsg48, [ DmMovimientoQueryFields.Propietario.Value ] ) );
                  Abort;
                  end;

             If   EnviarPorCorreo or not ( ExcluirCorreo and EnviarDocumentoPorCorreo )
             then begin

                  ProcessFrame.AddMsg( ntInformation, DmMovimientoQueryFields.Propietario.Value + ' - ' + NombrePropietario );

                  ProcessFrame.AddRecordMsg( RsMsg38 );

                  NroOperacionActual := 1;

                  If   DmMovimientoQueryFields.TipoMovimiento.Value in [ tmOferta, tmPedidoCompra, tmCompra ]
                  then ExportFileName := Report.FileName + IntToStr( ApplicationContainer.Ejercicio ) + '_' + DmMovimientoQueryFields.Propietario.Value + '_' + DmMovimientoQueryFields.Serie.Value + IntToStr( DmMovimientoQueryFields.NroDocumento.Value )
                  else ExportFileName := Report.FileName + IntToStr( ApplicationContainer.Ejercicio ) + '_' + DmMovimientoQueryFields.Serie.Value + IntToStr( DmMovimientoQueryFields.NroDocumento.Value );

                  Report.Load;

                  CreaFicherosImpreso;    // Solo se crean las tablas vacías

                  With RptCabeceraTable do
                    try
                      Edit;
                      CopyFields( DmMovimientoQuery );  // Un solo registro, el actual
                      Post;
                    except
                      Cancel;
                      raise;
                      end;

                  Report.SetValue( RsPartidasPresupuestarias, DataModule00.PartidasPresupuestarias );

                  // Report.OpenReportTables;

                  If   EsMovimientoCompra
                  then FacturaCompras.FijaDecimalesInforme( Report )
                  else FacturaVentas.FijaDecimalesInforme( Report );

                  RptCabeceraFields := TCabeceraFields.Create( RptCabeceraTable );

                  ExportFileName := Report.ExportToPDF( ExportFileName + '.pdf' );    // Ojo :  aqui se cierre y vuelve a abrir la tabla RptCabeceraTable, por lo que no se puede asignar RptCabeceraFields antes de este punto

                  // A partir de este punto RptCabeceraTable está cerrado y RptCabeceraFields no es accesible.

                  case DmMovimientoQueryFields.TipoMovimiento.Value of
                    tmOferta        : begin
                                      DirectoryName := 'Ofertas';
                                      TipoDatoExportado := tdOfertaPDF;
                                      end;
                    tmPedidoCompra  : begin
                                      DirectoryName := 'Pedidos de compra';
                                      TipoDatoExportado := tdPedidoComprasPDF;
                                      end;
                    tmCompra        : begin
                                      DirectoryName := 'Albaranes de compra';
                                      TipoDatoExportado := tdAlbaranComprasPDF;
                                      end;
                    tmPresupuesto   : begin
                                      DirectoryName := 'Presupuestos de venta';
                                      TipoDatoExportado := tdPresupuestoPDF;
                                      end;
                    tmPedidoVenta   : begin
                                      DirectoryName := 'Pedidos de venta';
                                      TipoDatoExportado := tdPedidoVentasPDF;
                                      end;
                    tmVenta         : begin
                                      DirectoryName := 'Albaranes de venta';
                                      TipoDatoExportado := tdAlbaranVentasPDF;
                                      end;
                    end;

                  AlmacenDocumentosPath := ApplicationPath + 'doc_' + CodigoEmpresaActual  + '\' + DirectoryName + '\' + IntToStr( ApplicationContainer.Ejercicio ) + '\PDF\';

                  CreateDirPath( AlmacenDocumentosPath );
                  With ProcessFrame do
                    If   not FlagA
                    then begin
                         ProcessFrame.AddMsg( ntInformation, Format( RsMsg55, [ AlmacenDocumentosPath ] ) );
                         FlagA := True;
                         end;

                  PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( ExportFileName );
                  If   not CopyFile( ExportFileName, PathFicheroAlmacen )
                  then begin
                       ShowNotification( ntError, RsMsg49, Format( RsMsg50, [ AlmacenDocumentosPath ] ) );
                       Abort;
                       end;

                  ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg51, [ PathFicheroAlmacen, ExtractFileName( ExportFileName ) ] ) );

                  ProcessFrame.AddRecordMsg( RsMsg52 );

                  If   EnviarPorCorreo
                  then If   not ( ExcluirEnviados and not ValueIsEmpty( DmMovimientoQueryFields.FechaEnvioPorCorreo.Value ) )
                       then begin

                            DestinatariosArray := DireccionContacto.ObtenDireccionesCorreo( TipoPropietario,
                                                                                            DmMovimientoQueryFields.Propietario.Value,
                                                                                            TipoDocumento,
                                                                                            NombrePropietario,
                                                                                            EMailPropietario );

                            If   High( DestinatariosArray )>0  // Hay, al menos, una dirección disponible (son dos elementos por dirección) [ Nombre, direccion, ... ]
                            then begin

                                 ProcessFrame.AddRecordMsg( RsMsg53 );

                                 // Enviando por correo el fichero

                                 With ExportImport do
                                   begin

                                   try

                                     InsertaParametros;

                                     If   SubjectTextTemplate.Contains( '%s' )
                                     then SubjectText := Format( SubjectTextTemplate, [ DmMovimientoQueryFields.Serie.Value,
                                                                                        DmMovimientoQueryFields.NroDocumento.Value,
                                                                                        DmMovimientoQueryFields.Ejercicio.Value,
                                                                                        DataModule00.DmEmpresaFields.Nombre.Value ] )
                                     else SubjectText := StrSetVars( SubjectTextTemplate,
                                                                     [ 'SerieNroDocumento',
                                                                       'Ejercicio',
                                                                       'Empresa_nombre' ],
                                                                     [ DmMovimientoQueryFields.Serie.Value + ' ' + IntToStr( DmMovimientoQueryFields.NroDocumento.Value ),
                                                                       IntToStr( DmMovimientoQueryFields.Ejercicio.Value ),
                                                                       DataModule00.DmEmpresaFields.Nombre.Value ] );

                                     // Envío N/%s nº %s %d de fecha %s. %s'

                                     SMTPInit( TipoDatoExportado,
                                               DestinatariosArray,
                                               Format( RsMsg40, [ Movimiento.TextoTipoMovimiento( TipoMovimiento, False ),
                                                                  DmMovimientoQueryFields.Serie.Value,
                                                                  DmMovimientoQueryFields.NroDocumento.Value,
                                                                  StrFormatDate( DmMovimientoQueryFields.Fecha.Value ) ] ),
                                               SubjectText,
                                               [ ExportFileName ] );

                                     // Permito que los módulos añadan ficheros adjuntos

                                     FOnAdjuntaFicherosCorreo.Invoke( OutgoingMailMessage, DmMovimientoQueryFields.NroOperacion.Value );

                                     SMTPSend;

                                   except on E : Exception do
                                     begin
                                     ShowNotification( ntExceptionError, RsMsg43, RsMsg44 + #13 + E.Message );
                                     Abort;
                                     end;
                                   end;

                                   try
                                     DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
                                     If   DmMovimientoTable.FindKey(  [ DmMovimientoQueryFields.Ejercicio.Value, DmMovimientoQueryFields.NroOperacion.Value ] )
                                     then begin
                                          DmMovimientoTable.Edit;
                                          DmMovimientoFields.FechaEnvioPorCorreo.Value := ApplicationContainer.TodayDate;
                                          DmMovimientoTable.Post;
                                          ProcessFrame.AddMsg( ntInformation, Format( RsMsg42, [ EMailPropietario ] ) );
                                          end;
                                   except
                                     DmMovimientoTable.Cancel;
                                     With DmMovimientoQueryFields do
                                       ShowNotification( ntWarning, Format( RsMsg41, [ Serie.Value, NroDocumento.Value ] ), RsMsg45 );
                                     end;

                                   EraseFile( ExportFileName, False );
                                   end;

                                 end;

                            end
                       else ProcessFrame.AddMsg( ntWarning, Format( RsMsg47, [ DmMovimientoQueryFields.NroDocumento.Value,
                                                                               DmMovimientoQueryFields.Propietario.Value,
                                                                               NombrePropietario ] ) );
                       end;

             except on E : Exception do
               begin
               ProcessFrame.AddMsg( ntError, RsMsg46 );
               Report.Cancel( E );
               end;
             end;

           finally
             Report.Reset;
             end;

           DmMovimientoQuery.Next;
           end;

       finally
         ApplicationContainer.EndProgression;
         end;

end;

function TMovimientoModule.TextoTipoMovimiento( TipoMovimiento : TTipoMovimiento;
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
       tmPedidoVenta       : If   FModuloHojasDePedido
                             then Result := RsHojasDePedido
                             else Result := RsPedidosVenta;
       tmCompra            : Result := RsAlbaranesCompra;
       tmVenta             : Result := RsAlbaranesVenta;
       else                  Result := RsMovimientosAlmacen;
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

function TMovimientoModule.TextoTituloMovimiento( TipoMovimiento : TTipoMovimientoCompraVenta ) : String;
begin
     case TipoMovimiento of
       tmOferta       : Result := RsTituloOferta;
       tmPresupuesto  : Result := RsTituloPresupuesto;
       tmPedidoCompra : Result := RsTituloPedidoCompra;
       tmPedidoVenta  : If   FModuloHojasDePedido
                        then Result := RsTituloHojaPedido
                        else Result := RsTituloPedidoVenta;
       tmCompra       : Result := RsTituloAlbaranCompra;
       tmVenta        : Result := RsTituloAlbaranVenta;
       end;
end;

procedure TMovimientoModule.HintMovimiento(       NroRegistroOrigen : LongInt;
                                                  ACellViewInfo     : TcxGridTableDataCellViewInfo;
                                            var   AHintText         : TCaption;
                                            var   AIsHintMultiLine  : Boolean;
                                            var   AHintTextRect     : TRect );

begin
     If   NroRegistroOrigen<>0
     then With Movimiento do
            If   ObtenRegistro( NroRegistroOrigen, True )
            then begin
                 var HintString := Movimiento.TextoTipoMovimiento( DmMovimientoFields.TipoMovimiento.Value, False, True ) + ' : ';
                 If   DmMovimientoFields.TipoMovimiento.Value in [ tmOferta..tmVenta ]
                 then StrAdd( HintString, DmMovimientoFields.Serie.Value + ' ' + IntToStr( DmMovimientoFields.NroDocumento.Value ) )
                 else StrAdd( HintString, IntToStr( DmMovimientoFields.NroOperacion.Value ) + ' (Nº op.) ' );
                 AHintText := HintString;
                 AIsHintMultiLine := False;
                 AHintTextRect.Top := AHintTextRect.Top + ACellViewInfo.Height;
                 end;
end;

function TMovimientoModule.EsUnMovimientoDeEntrada( TipoMovimiento : TTipoMovimiento ) : Boolean;
begin
     Result := TipoMovimiento in [ tmInventario, tmEntrada, tmFabricacion, tmRegularizacion, tmDespiece, tmOferta, tmPedidoCompra, tmCompra ];
end;

procedure TMovimientoModule.ActualizaRelacionesLineaEntrada( MovimientoFields      : TMovimientoFields;
                                                             LineaMovimientoFields : TLineaMovimientoFields;
                                                             ArticuloFields        : TArticuloFields );

begin
      With LineaMovimientoFields do
        If   ArticuloFields.EsListaMateriales.Value and
             not ArticuloFields.Desglosar.Value and
             ArticuloFields.CalcularPrecios.Value
        then With LineaMovimientoFields do
               Precio.Value := Articulo.CalculaPrecioDesgloseCompra( MovimientoFields.Propietario.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value )
        else If   LineaMovimientoFields.Cantidad.Value=0.0
             then begin
                  LineaMovimientoFields.Precio.Value := 0.0;
                  LineaMovimientoFields.PuntoVerde.Value := 0.0;
                  LineaMovimientoFields.Recargo.Value := 0.0;
                  LineaMovimientoFields.Descuento.Value := 0.0;
                  end
             else If   DataModule00.DmEmpresaFields.Stock_CosteEntradaPorLote.Value and
                       ( MovimientoFields.TipoMovimiento.Value in [ tmInventario, tmEntrada, tmRegularizacion, tmCompra, tmMinimoUsuario..tmMaximoUsuario ] ) and
                       ( LineaMovimientoFields.Cantidad.Value>0.0 )
                  then ObtenCosteUltimaEntradaPorLote( LineaMovimientoFields )
                  else Articulo.ObtenPrecioyDtoCompra( LineaMovimientoFields, MovimientoFields.Propietario.Value );
end;

procedure TMovimientoModule.ActualizaRelacionesLineaSalida( MovimientoFields      : TMovimientoFields;
                                                            LineaMovimientoFields : TLineaMovimientoFields;
                                                            ArticuloFields        : TArticuloFields;
                                                            CodigoCliente         : String = '' );
var  TipoMovimientoSalida : SmallInt;

begin

     If   CodigoCliente=''
     then CodigoCliente := MovimientoFields.Propietario.Value;

     With LineaMovimientoFields do
       If   Assigned( MovimientoFields ) and
            ArticuloFields.EsListaMateriales.Value and
            ArticuloFields.CalcularPrecios.Value
       then With LineaMovimientoFields do
              Precio.Value := Articulo.CalculaPrecioDesgloseVenta( MovimientoFields.TipoMovimiento.Value,
                                                                   CodigoCliente,
                                                                   CodigoArticulo.Value,
                                                                   CodigoClaseA.Value,
                                                                   CodigoClaseB.Value,
                                                                   CodigoClaseC.Value,
                                                                   MovimientoFields.Fecha.Value )
       else begin

            // MovimientoFields puede estar mapeado sobre otro registro que no tenga alguno de estos datos
            // Como por ejemplo las ventas periódicas.

            TipoMovimientoSalida := tmNoDefinido;

            If   Assigned( MovimientoFields )
            then If   Assigned( MovimientoFields.TipoMovimiento )
                 then TipoMovimientoSalida := MovimientoFields.TipoMovimiento.Value;

            // Esta limpieza es necesaria para evitar que se asignen o mantengan los valores cuando la cantidad es 0.0

            With LineaMovimientoFields do
              If   ( Assigned( NroCajas ) and ( NroCajas.Value=0.0 ) ) and
                   ( Cantidad.Value=0.0 )
              then begin
                   If   Assigned( Precio )
                   then Precio.Value := 0.0;
                   If   Assigned( PuntoVerde )
                   then PuntoVerde.Value := 0.0;
                   If   Assigned( Recargo )
                   then Recargo.Value := 0.0;
                   If   Assigned( Descuento )
                   then Descuento.Value := 0.0;
                   end
              else Articulo.ObtenPrecioyDtoVenta( TipoMovimientoSalida, LineaMovimientoFields, CodigoCliente );

            end;
end;

function TMovimientoModule.CopiaMovimiento( EjercicioDestino       : SmallInt;
                                            NroOperacionDestino    : LongInt;
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
     Result := MovimientoService.CopiaMovimiento( EjercicioDestino, NroOperacionDestino, TipoMovimientoDestino, PropietarioDestino, SerieDestino, ModificarAlmacen, AlmacenDestino, AsignarUbicaciones, InvertirCantidades, BorrarMovimientoOrigen, ActualizarPrecios, NroDocumentoDestino );
end;

procedure TMovimientoModule.ActualizaFechaEmision( CabeceraFields : TCabeceraFields );
begin
     If   ObtenMovimiento( CabeceraFields.Ejercicio.Value, CabeceraFields.Nro_Operacion.Value )
     then With DmMovimientoTable do
              try
                Edit;
                DmMovimientoFields.FechaEmision.Value := ApplicationContainer.TodayDate;
                Post;
              except
                Cancel;
                ShowNotification( ntWarning, Format( RsMsg17, [ CabeceraFields.Serie.Value, CabeceraFields.NroDocumento.Value, CabeceraFields.CodigoPropietario.Value ] ), RsMsg18 );
                end;
end;

procedure TMovimientoModule.ActualizaLineaMovimiento( MovimientoFields      : TMovimientoFields;
                                                      LineaMovimientoFields : TLineaMovimientoFields;
                                                      CompruebaVinculos     : Boolean = True );
begin
     With MovimientoFields do
       MovimientoService.ActualizaLineaMovimiento( LineaMovimientoFields.GetRemoteCursorID, TipoMovimiento.Value, Serie.Value, Propietario.Value, TLineaMovimiento.FromDataSet( LineaMovimientoFields ), CompruebaVinculos );
end;

procedure TMovimientoModule.ActualizaMovimiento( MovimientoFields : TMovimientoFields );
begin
     FBeforeUpdateMovimiento.Invoke( MovimientoFields.TipoMovimiento.Value, MovimientoFields.Propietario.Value );
     MovimientoService.ActualizaMovimiento( TMovimiento.FromDataset( MovimientoFields ) );
end;

procedure TMovimientoModule.SuprimeLineaMovimiento( MovimientoFields      : TMovimientoFields;
                                                    LineaMovimientoFields : TLineaMovimientoFields );
begin
     With MovimientoFields do
       MovimientoService.SuprimeLineaMovimiento( LineaMovimientoFields.GetRemoteCursorID,
                                                 Ejercicio.Value,
                                                 NroOperacion.Value,
                                                 LineaMovimientoFields.NroPagina.Value,
                                                 LineaMovimientoFields.NroLinea.Value,
                                                 TipoMovimiento.Value,
                                                 Serie.Value,
                                                 Propietario.Value  );
end;

function TMovimientoModule.GeneraPedidoCompra( CodigoProveedor, Serie : String; Fecha: TDate; const LineList: TLongIntArray): LongInt;
begin
     Result := MovimientoService.GeneraPedidoCompra( CodigoProveedor, Serie, Fecha, LineList );
end;

function TMovimientoModule.SuprimeMovimiento( Ejercicio : SmallInt; NroOperacion: Integer; PreservaCabecera : Boolean = False ): Boolean;
begin
     Result := MovimientoService.SuprimeMovimiento( Ejercicio, NroOperacion, PreservaCabecera );
end;

procedure TMovimientoModule.SuprimeReferenciasLinea( MovimientoFields      : TMovimientoFields;
                                                     LineaMovimientoFields : TLineaMovimientoFields );
begin
     With DmLineaMovimientoAuxTable do
       begin

       IndexFieldNames := 'TipoMovimientoOrigen;EjercicioOrigen;NroOperacionOrigen';

       With MovimientoFields do
         SetRange( [ TipoMovimiento.Value, Ejercicio.Value, NroOperacion.Value ],
                   [ TipoMovimiento.Value, Ejercicio.Value, NroOperacion.Value ] );

       First;
       While not Eof do
         begin
         If   DmLineaMovimientoAuxFields.NroRegistroOrigen.Value=LineaMovimientoFields.NroRegistro.Value
         then begin
              DmLineaMovimientoAuxTable.Edit;

              DmLineaMovimientoAuxFields.TipoMovimientoOrigen.Clear;
              DmLineaMovimientoAuxFields.EjercicioOrigen.Clear;
              DmLineaMovimientoAuxFields.NroOperacionOrigen.Clear;
              DmLineaMovimientoAuxFields.NroRegistroOrigen.Clear;

              DmLineaMovimientoAuxTable.Post;
              end;
         Next;
         end;
       end;
end;

function TMovimientoModule.CantidadProcesadaLinea( NroRegistroOrigen : LongInt ) : Decimal;
begin
     Result := 0.0;
     With DmLineaMovimientoTable do
       begin
       IndexFieldNames := 'NroRegistroOrigen';
       SetRange( [ NroRegistroOrigen ] );
       First;
       While not Eof do
         begin
         DecAdd( Result, DmLineaMovimientoFields.CantidadAjustada.Value );
         Next;
         end;
       end;
end;

function TMovimientoModule.NumeroReferenciasLinea( NroRegistroOrigen : LongInt ) : SmallInt;
begin
     With DmLineaMovimientoTable do
       begin
       IndexFieldNames := 'NroRegistroOrigen';
       SetRange( [ NroRegistroOrigen ] );
       Result := RecordCount;
       end;
end;

procedure TMovimientoModule.AsignaOrigenPorLoteySerie( LineaMovimientoFields : TLineaMovimientoFields );
begin

     With LineaMovimientoFields do
       begin

       If   ( Cantidad.Value<0.0 ) and not ValueIsEmpty( NumeroSerie.Value ) and ( NumeroSerie.OldValue<>NumeroSerie.Value )
       then begin
            DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
            With DmLineaMovimientoTable do
              begin

              IndexFieldNames := 'CodigoArticulo;NumeroSerie;Fecha';

              SetRange( [ CodigoArticulo.Value, NumeroSerie.Value ], [ CodigoArticulo.Value, NumeroSerie.Value ] );
              First;
              While not Eof do
                begin
                If   DmLineaMovimientoFields.Cantidad.Value>0.0
                then If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
                     then begin

                          If   not LineaMovimientoFields.TipoMovimientoOrigen.IsNull
                          then If   ShowNotification( ntQuestionWarning, RsMsg21, RsMsg22 )<>mrYes
                               then Abort;

                          If   not  DmLineaMovimientoFields.UIDArticulo.isNull
                          then UIDArticulo.Value := DmLineaMovimientoFields.UIDArticulo.Value;

                          // Se puede asignar el origen de ésta línea siempre y cuando no esté ya asignado, por ejemplo por un proceso de exportación

                          If   NroRegistroOrigen.Value=0
                          then begin
                               AsignacionOrigen.Value := aomNumeroSerie;
                               TipoMovimientoOrigen.Value := DmMovimientoFields.TipoMovimiento.Value;
                               EjercicioOrigen.Value := DmMovimientoFields.Ejercicio.Value;
                               NroOperacionOrigen.Value := DmMovimientoFields.NroOperacion.Value;
                               NroRegistroOrigen.Value := DmLineaMovimientoFields.NroRegistro.Value;
                               end;

                          Exit;
                          end;
                Next;
                end;
              end;
            end;

       // La siguiente opción indica que el usuario asigna lotes de productos de forma interna y que tiene
       // la precaución de asignar una única linea entrada a cada lote. Por lo tanto podemos utilizarlo
       // como si fueran series.

       If   DataModule00.DmEmpresaFields.Stock_LotesProductos.Value and
            DataModule00.DmEmpresaFields.Stock_TrazabilidadPorLotes.Value
       then begin

            If   ( Cantidad.Value<0.0 ) and not ValueIsEmpty( LoteFabricacion.Value ) and ( LoteFabricacion.OldValue<>LoteFabricacion.Value )
            then begin
                 DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
                 With DmLineaMovimientoTable do
                   begin

                   IndexFieldNames := 'CodigoArticulo;LoteFabricacion;Fecha';

                   SetRange( [ CodigoArticulo.Value, LoteFabricacion.Value ], [ CodigoArticulo.Value, LoteFabricacion.Value ] );
                   First;
                   While not Eof do
                     begin
                     If   DmLineaMovimientoFields.Cantidad.Value>0.0
                     then If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
                          then begin

                               If   not TipoMovimientoOrigen.IsNull
                               then If   ShowNotification( ntQuestionWarning, RsMsg21, RsMsg22 )<>mrYes
                                    then Abort;

                               If   not  DmLineaMovimientoFields.UIDArticulo.isNull
                               then UIDArticulo.Value := DmLineaMovimientoFields.UIDArticulo.Value;

                               If   FechaCaducidad.IsNull
                               then FechaCaducidad.Value := DmLineaMovimientoFields.FechaCaducidad.Value;

                               If   NroRegistroOrigen.Value=0
                               then begin
                                    AsignacionOrigen.Value := aomLote;
                                    TipoMovimientoOrigen.Value := DmMovimientoFields.TipoMovimiento.Value;
                                    EjercicioOrigen.Value := DmMovimientoFields.Ejercicio.Value;
                                    NroOperacionOrigen.Value := DmMovimientoFields.NroOperacion.Value;
                                    NroRegistroOrigen.Value := DmLineaMovimientoFields.NroRegistro.Value;
                                    end;

                               Exit;
                               end;
                     Next;
                     end;
                   end;
                 end;

            end;

       If   not ValueIsEmpty( TipoMovimientoOrigen.Value ) and
            ( ( AsignacionOrigen.Value=aomNumeroSerie ) and ( NumeroSerie.OldValue<>NumeroSerie.Value ) ) or
            ( ( AsignacionOrigen.Value=aomLote ) and ( LoteFabricacion.OldValue<>LoteFabricacion.Value ) )
       then begin

            If   ShowNotification( ntQuestionWarning, RsMsg19, RsMsg20 )<>mrYes
            then Abort;

            UIDArticulo.Clear;
            AsignacionOrigen.Clear;
            TipoMovimientoOrigen.Clear;
            EjercicioOrigen.Clear;
            NroOperacionOrigen.Clear;
            NroRegistroOrigen.Clear;
            end;

       end;

end;

function TMovimientoModule.GetExisteMovimientoInventario : Boolean;
begin
     If   not FMovimientoInventarioChecked
     then begin
          DmMovimientoAuxTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Propietario;Serie;NroDocumento';
          Result := DmMovimientoAuxTable.FindEqualFirst( [ tmInventario, ApplicationContainer.Ejercicio ] );
          FMovimientoInventarioChecked := True;
          FExisteMovimientoInventario := Result;
          end
     else Result := FExisteMovimientoInventario;
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

                  DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';

                  If   DmMovimientoAuxTable.FindKey( [ Ejercicio.Value, NroOperacion.Value ] )
                  then begin

                       Precio.Value := PrecioEntrada;
                       NroRegistroOrigen.Value := NroRegistroLineaOrigen;

                       AsignacionOrigen.Value := aomLote;
                       TipoMovimientoOrigen.Value := DmMovimientoAuxFields.TipoMovimiento.Value;
                       EjercicioOrigen.Value := DmMovimientoAuxFields.Ejercicio.Value;
                       NroOperacionOrigen.Value := DmMovimientoAuxFields.NroOperacion.Value;
                       end;

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

begin
     Result := MovimientoService.ObtenCosteUltimaEntradaPorLote( Fecha, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, LoteFabricacion, NroRegistroLinea, Precio, NroRegistroOrigen );
end;

function TMovimientoModule.ObtenUltimoPrecioComprayDescuento(     CodigoArticulo : String;
                                                                  Fecha          : TDate;
                                                              out Precio         : Decimal;
                                                              out Descuento      : Decimal ) : Boolean;

begin
     Result := False;
     Precio := 0.0;
     Descuento := 0.0;
     DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
     With DmLineaMovimientoTable do
       begin

       IndexFieldNames := 'CodigoArticulo;Fecha;NroOperacion;NroPagina;NroLinea';

       SetRange( [ CodigoArticulo, LowestDateTime ], [ CodigoArticulo, Fecha ] );
       Last;
       While not Bof do
         begin
         If   DmLineaMovimientoFields.Cantidad.Value>0.0
         then If   DmMovimientoTable.FindKey( [ DmLineaMovimientoFields.Ejercicio.Value, DmLineaMovimientoFields.NroOperacion.Value ] )
              then If   DmMovimientoFields.TipoMovimiento.Value in [ tmInventario, tmCompra ]
                   then begin
                        Precio := DmLineaMovimientoFields.Precio.Value;
                        Descuento := DmLineaMovimientoFields.Descuento.Value;
                        Result := True;
                        Exit;
                        end;
         Prior;
         end;
       end;

end;

function TMovimientoModule.TextoNroDocumento( TipoDocumento : TTipoMovimiento ) : String;

const  TextoDocumento : array[ 1..5 ] of String = ( 'operación', 'oferta', 'pedido', 'presupuesto', 'albarán' );

begin
     case TipoDocumento of
       tmOferta        : Result := TextoDocumento[ 2 ];
       tmPedidoCompra,
       tmPedidoVenta   : Result := TextoDocumento[ 3 ];
       tmPresupuesto   : Result := TextoDocumento[ 4 ];
       tmCompra,
       tmVenta         : Result := TextoDocumento[ 5 ];
       else              Result := TextoDocumento[ 1 ];
       end;
     Result := 'Nº de ' + Result;
end;

function TMovimientoModule.CosteMovimiento(     LineaMovimientoFields : TLineaMovimientoFields;
                                            var Coste                 : Decimal  ) : Boolean;

var ExistenciasArticulo : IExistenciasArticulo;

begin
     Result := False;
     Coste := 0.0;
     If   LineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual
     then begin

          With LineaMovimientoFields, DmLineaMovimientoAuxTable do
            begin
            If   not ValueIsEmpty( UIDArticulo.Value )
            then begin
                 IndexFieldNames := 'UIDArticulo';
                 DmMovimientoAuxTable.IndexFieldNames := 'Ejercicio;NroOperacion';
                 try
                   SetRange( [ UIDArticulo.Value ], [ UIDArticulo.Value ] );
                   First;
                   While not Eof do
                     begin
                     With DmLineaMovimientoAuxFields do
                       If   DmMovimientoAuxTable.Findkey( [ Ejercicio.Value, NroOperacion.Value ] )
                       then If   EsUnMovimientoDeEntrada( DmMovimientoAuxFields.TipoMovimiento.Value )
                            then begin
                                 Coste := Precio.Value - ( ( ( Precio.Value + Recargo.Value ) * Descuento.Value ) / 100.0 );  // Precio neto
                                 Result := True;
                                 Break;
                                 end;
                     Next;
                     end;
                 finally
                   CancelRange;
                   end;
                 end;

            If   Coste=0.0
            then begin
                 Coste := StockAlmacen.ObtenCosteFecha( CodigoArticulo.Value,
                                                        CodigoClaseA.Value='',
                                                        CodigoClaseA.Value,
                                                        CodigoClaseB.Value,
                                                        CodigoClaseC.Value,
                                                        True,
                                                        '',
                                                        True,
                                                        '',
                                                        True,
                                                        '',
                                                        Fecha.Value );
                 Result := False;
                 end;

            end;

          end;
end;

procedure TMovimientoModule.CotejaFechaLineas( MovimientoFields      : TMovimientoFields;
                                               LineaMovimientoFields : TLineaMovimientoFields );
begin
     If   MovimientoFields.Dataset.State=dsEdit
     then If   MovimientoFields.Fecha.Value<>MovimientoFields.Fecha.OldValue
          then With LineaMovimientoFields.Dataset do
                 try
                   DisableControls;
                   First;
                   While not Eof do
                     begin
                     StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, True );
                     Edit;
                     LineaMovimientoFields.Fecha.Value := MovimientoFields.Fecha.Value;
                     StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );
                     Post;
                     Next;
                     end;
                 finally
                   EnableControls;
                   end;
end;

procedure TMovimientoModule.CompruebaPrimerNroPagina( MovimientoFields           : TMovimientoFields;
                                                      GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields = nil );
begin

     If   not Assigned( GrupoLineaMovimientoFields )
     then GrupoLineaMovimientoFields := DmGrupoLineaMovimientoFields;

     With GrupoLineaMovimientoFields do
       begin
       Table.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';
       If   not Table.FindEqualFirst( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value ] )
       then begin
            Table.Append;
            Ejercicio.Value := MovimientoFields.Ejercicio.Value;
            NroOperacion.Value := MovimientoFields.NroOperacion.Value;
            NroPagina.Value := 0;
            Descripcion.Value := 'Página 1';
            Table.Post;
            end;
       end;
end;

function TMovimientoModule.ObtenUltimoNroLinea( LineaMovimientoFields : TLineaMovimientoFields ) : SmallInt;
begin
     With LineaMovimientoFields do
       Result := ObtenUltimoNroLinea( Ejercicio.Value, NroOperacion.Value, NroPagina.Value );
end;

function TMovimientoModule.ObtenUltimoNroLinea( Ejercicio    : SmallInt;
                                                NroOperacion : LongInt;
                                                NroPagina    : SmallInt ) : SmallInt;
begin
     With DmLineaMovimientoAuxTable do
       try
         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
         SetRange( [ Ejercicio, NroOperacion, NroPagina, 1 ], [ Ejercicio, NroOperacion, NroPagina, MaxSmallint ] );
         Last;
         If   DmLineaMovimientoAuxFields.NroLinea.Value>=1
         then Result := DmLineaMovimientoAuxFields.NroLinea.Value + 1
         else Result := 1
       finally
         CancelRange;
         end;
end;

function TMovimientoModule.ExistenLineas( MovimientoFields : TMovimientoFields ) : Boolean;
begin
     With DmLineaMovimientoAuxTable do
       try
         IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
         With MovimientoFields do
           SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );
         Result := RecordCount>0;
       finally
         CancelRange;
         end;
end;

function TMovimientoModule.ObtenEnvaseLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                             EnvaseFields          : TClaseFields ) : Boolean;

var  NroClase : TNroClase;
     CodigoClase : String;

begin

     // Se trata de rellenar EnvaseFields con el contenido de la clase que se utiliza como envase

     Result := False;
     With DataModule00.DmEmpresaFields do
       If   Articulo_Envase.Value<>0
       then begin
            NroClase := TNroClase( Articulo_Envase.Value );
            CodigoClase := Clase.Selecciona( NroClase, LineaMovimientoFields );
            If   CodigoClase<>''
            then Result := Clase.Obten( NroClase, CodigoClase, False, EnvaseFields );
            end;

end;

function TMovimientoModule.ObtenContenedorLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                                 ContenedorFields      : TClaseFields ) : Boolean;

var  NroClase : TNroClase;
     CodigoClase : String;

begin
     Result := False;
     With DataModule00.DmEmpresaFields do
       If   Articulo_Contenedor.Value<>0
       then begin
            NroClase := TNroClase( Articulo_Contenedor.Value );
            CodigoClase := Clase.Selecciona( NroClase, LineaMovimientoFields );
            If   CodigoClase<>''
            then Result := Clase.Obten( NroClase, CodigoClase, False, ContenedorFields );
            end;
end;

procedure TMovimientoModule.ActualizaCamposCalculadosLineaCompra( MovimientoFields       : TMovimientoFields;
                                                                  LineaMovimientoFields  : TLineaMovimientoFields;
                                                                  ProveedorFields        : TProveedorFields;
                                                                  ArticuloFields         : TArticuloFields;
                                                                  TiposIVAFields         : TTiposIVAFields = nil );

procedure ActualizaValorCantidadCompra( Valor : Decimal );
begin
     LineaMovimientoFields.Cantidad.Value := Valor;
     LineaMovimientoFields.CantidadAjustada.Value := Valor;
end;

var  EnvaseOContenedor : Boolean;

begin

     try

       LineaMovimientoFields.Dataset.DisableControls;

       LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

       FacturaCompras.CalculaImportesIVA( LineaMovimientoFields, ProveedorFields, ArticuloFields, TiposIVAFields );

       EnvaseOContenedor := False;

       LineaMovimientoFields.Peso.Value := 0.0;
       LineaMovimientoFields.Tara.Value := 0.0;

       With DataModule00.DmEmpresaFields do
         If   MovimientoFields.TipoMovimiento.Value=tmCompra
         then begin
              If   Articulo_Envase.Value<>0
              then If   ObtenEnvaseLinea( LineaMovimientoFields, DsContenedorFields )
                   then begin
                        EnvaseOContenedor := True;
                        case Articulo_TipoEnvase.Value of
                          tenReutilizable : begin
                                            LineaMovimientoFields.Peso.Value := LineaMovimientoFields.CantidadProcesada.Value;  // En este campo va el peso bruto
                                            LineaMovimientoFields.Tara.Value := LineaMovimientoFields.NroCajas.Value * LineaMovimientoFields.PesoEnvase.Value;   // Envases reutilizables
                                            ActualizaValorCantidadCompra( LineaMovimientoFields.CantidadProcesada.Value - LineaMovimientoFields.Tara.Value );
                                            end;
                          tenDesechable   : begin
                                            var Kilos := 1.0;
                                            If   ArticuloFields.Kilos.Value<>0.0
                                            then Kilos := ArticuloFields.Kilos.Value;
                                            LineaMovimientoFields.Peso.Value := ( LineaMovimientoFields.Cantidad.Value * Kilos ) +
                                                                                ( LineaMovimientoFields.NroCajas.Value * LineaMovimientoFields.PesoEnvase.Value );
                                            end;
                          end;
                        end;

              // En los bultos se introduce el número de pallets

              If   Articulo_Contenedor.Value<>0
              then If   ObtenContenedorLinea( LineaMovimientoFields, DsContenedorFields )
                   then begin
                        EnvaseOContenedor := True;
                        case Articulo_TipoContenedor.Value of
                          tenReutilizable : begin
                                            LineaMovimientoFields.Tara.Value := LineaMovimientoFields.Tara.Value + ( LineaMovimientoFields.Bultos.Value * DsContenedorFields.Peso.Value );
                                            ActualizaValorCantidadCompra( LineaMovimientoFields.CantidadProcesada.Value - LineaMovimientoFields.Tara.Value );
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

     finally
       LineaMovimientoFields.Dataset.EnableControls;
       end;

end;

// CUIDADO: De momento esta función está repetida en GServer
// TODO: Integrar ambas funciones en el servidor

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
     try

       LineaMovimientoFields.Dataset.DisableControls;

       If   MovimientoFields.TipoMovimiento.Value=tmVenta
       then LineaMovimientoFields.CantidadAjustada.Value := -LineaMovimientoFields.Cantidad.Value
       else LineaMovimientoFields.CantidadAjustada.Value := LineaMovimientoFields.Cantidad.Value;

       EnvaseOContenedor := False;

       LineaMovimientoFields.Peso.Value := 0.0;
       LineaMovimientoFields.Tara.Value := 0.0;

       With DataModule00.DmEmpresaFields do
         If   MovimientoFields.TipoMovimiento.Value=tmVenta
         then begin

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

              // En los bultos se introduce el número de pallets

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

       FacturaVentas.CalculaImportesIVA( MovimientoFields, LineaMovimientoFields, ClienteFields, ArticuloFields, SerieFacturacionFields, TiposIVAFields );

     finally
       LineaMovimientoFields.Dataset.EnableControls;
       end;
end;

procedure  TMovimientoModule.InsertaLineasDocumento(       MovimientoOrigenFields,
                                                           MovimientoDestinoFields : TMovimientoFields;
                                                     const LineList                : TLongIntArray;
                                                           CopiarDatosCabecera     : Boolean = False;
                                                           NoVincularDocumentos    : Boolean = False );
begin
     MovimientoService.InsertaLineasDocumento( TMovimiento.FromDataSet( MovimientoOrigenFields ),
                                               TMovimiento.FromDataSet( MovimientoDestinoFields ),
                                               LineList,
                                               CopiarDatosCabecera,
                                               NoVincularDocumentos );
end;

function TMovimientoModule.EntregasACuentaPedidosOrigen( MovimientoFields : TMovimientoFields ) : Decimal;
begin
     With MovimientoFields do
       If   NroOperacion.Value=0  // Si no existe el registro puede ocurrir
       then Result := 0.0
       else Result := MovimientoService.EntregasACuentaPedidosOrigen( Ejercicio.Value, NroOperacion.Value, SerieFactura.Value, NroFactura.Value );
end;

function TMovimientoModule.EntregasACuentaPedidosOrigen( Ejercicio : SmallInt; NroOperacion : LongInt; Serie : String; NroFactura : LongInt ) : Decimal;
begin
     Result := MovimientoService.EntregasACuentaPedidosOrigen( Ejercicio, NroOperacion, Serie, NroFactura );
end;

function TMovimientoModule.CambiaSituacionPedido( NroOperacion : LongInt; Procesado : Boolean ) : Decimal;
begin
     Result := MovimientoService.CambiaSituacionPedido( NroOperacion, Procesado );
end;

procedure  TMovimientoModule.InsertaLineasConsumo( MovimientoFields       : TMovimientoFields;
                                                   LineaMovimientoFields  : TLineaMovimientoFields;
                                                   ClienteFields          : TClienteFields;
                                                   SerieFacturacionFields : TSerieFacturacionFields;
                                                   LineList               : TList<Integer> );

var   NroOrden,
      Index,
      NroPaginaActual,
      UltimoNroLinea : SmallInt;

procedure InsertaLinea( CantidadConsumos : Decimal );
begin
     With LineaMovimientoFields do
       begin

       Dataset.Append;

       Ejercicio.Value := MovimientoFields.Ejercicio.Value;
       NroOperacion.Value := MovimientoFields.NroOperacion.Value;
       Fecha.Value := MovimientoFields.Fecha.Value;
       NroPagina.Value := NroPaginaActual;
       NroLinea.Value := UltimoNroLinea + Index;
       UIDArticulo.AsGuid := Articulo.Identificador;
       TipoMovimientoOrigen.Value := tmConsumos;
       NroRegistroOrigen.Value := DmConsumosClienteFields.NroOrden.Value;

       CodigoArticulo.Value := DmConsumosClienteFields.CodigoArticulo.Value;
       CodigoClaseA.Value := DmConsumosClienteFields.CodigoClaseA.Value;
       CodigoClaseB.Value := DmConsumosClienteFields.CodigoClaseB.Value;
       CodigoClaseC.Value := DmConsumosClienteFields.CodigoClaseC.Value;
       Descripcion.Value := Articulo.Descripcion( CodigoArticulo.Value, True, DsArticuloFields );
       CodigoAlmacen.Value := Almacen.AlmacenPorDefecto( scVentas, DsArticuloFields );
       Ubicacion.Value := Almacen.UbicacionPorDefecto( CodigoAlmacen.Value, DsArticuloFields );

       Cantidad.Value := CantidadConsumos;
       If   MovimientoFields.TipoMovimiento.Value=tmVenta
       then Cantidad.Value := -Cantidad.Value;
       CantidadAjustada.Value := CantidadConsumos;

       Precio.Value := DmConsumosClienteFields.Precio.Value;
       Descuento.Value := DmConsumosClienteFields.Descuento.Value;
       NroCajas.Value := DmConsumosClienteFields.Cajas.Value;

       If   MovimientoFields.TipoMovimiento.Value=tmVenta
       then CantidadAjustada.Value := -Cantidad.Value;

       If   CantidadConsumos<>0.0
       then begin
            FacturaVentas.CalculaImportesIVA( MovimientoFields,
                                              LineaMovimientoFields,
                                              ClienteFields,
                                              DsArticuloFields,
                                              SerieFacturacionFields,
                                              DsTiposIVAFields );
            StockAlmacen.ActualizaStock( MovimientoFields, LineaMovimientoFields, False );
            end;

       Dataset.Post;
       end;
end;

begin
     try

       LineaMovimientoFields.Dataset.DisableControls;

       NroPaginaActual := LineaMovimientoFields.NroPagina.Value;
       UltimoNroLinea := ObtenUltimoNroLinea( LineaMovimientoFields );

       If   Assigned( LineList )
       then With LineList do
              For Index := 0 to Count - 1 do
                begin
                NroOrden := LongInt( Items[ Index ] );
                If   ( NroOrden<>0 ) and DmConsumosClienteTable.FindKey( [ MovimientoFields.Propietario.Value, NroOrden ] )
                then InsertaLinea( DmConsumosClienteFields.Cantidad.Value );
                end
       else  With DmConsumosClienteTable do
              begin
              Index := 0;
              With MovimientoFields do
                SetRange( [ Propietario.Value, 1 ], [ Propietario.Value, MaxSmallint ] );
              First;
              While not Eof do
                begin
                InsertaLinea( 0.0 );
                Inc( Index );
                Next;
                end;
              end;

      finally

        With LineaMovimientoFields.Dataset do
          begin
          EnableControls;
          Last;
          end;

        end;
end;

procedure TMovimientoModule.InicializaValoresImpositivos( var TasasArray : TTasasArray );
begin
     FillChar( TasasArray, SizeOf( TTasasArray ) ,#0 );
end;

procedure TMovimientoModule.AcumulaValoresImpositivosLinea(     LineaMovimientoFields : TLineaMovimientoFields;
                                                                CodigoPaisIVA         : String;
                                                            var TasasArray            : TTasasArray;
                                                                MovimientoCompra      : Boolean = True );

var  CodigoTipoIVA : SmallInt;

begin
     CodigoTipoIVA := LineaMovimientoFields.CodigoTipoIVA.Value;
     If   CodigoTipoIVA in [ 0..NroMaximoTiposTasas ]
     then begin
          DecAdd( TasasArray[ CodigoTipoIVA ].BaseImponible, LineaMovimientoFields.ImporteNeto.Value );
          DecAdd( TasasArray[ CodigoTipoIVA ].BaseNoSujetaDto, LineaMovimientoFields.CantidadAjustada.Value * LineaMovimientoFields.PuntoVerde.Value );
          DecAdd( TasasArray[ CodigoTipoIVA ].CuotaIVA, LineaMovimientoFields.CuotaIVA.Value );
          DecAdd( TasasArray[ CodigoTipoIVA ].CuotaRE, LineaMovimientoFields.CuotaRE.Value );
          DecAdd( TasasArray[ CodigoTipoIVA ].Importe, LineaMovimientoFields.ImporteTotal.Value );
          If   ( CodigoTipoIVA<>0 ) and ( TasasArray[ CodigoTipoIVA ].TipoIVA=0.0 )
          then begin
               Tasa.TipoIVA( LineaMovimientoFields.Fecha.Value, CodigoPaisIVA, CodigoTipoIVA, DsTiposIVAFields );
               If   MovimientoCompra
               then TasasArray[ CodigoTipoIVA ].TipoIVA := DsTiposIVAFields.IVASoportado.Value
               else begin
                    TasasArray[ CodigoTipoIVA ].TipoIVA := DsTiposIVAFields.IVAREpercutido.Value;
                    TasasArray[ CodigoTipoIVA ].TipoRE := DsTiposIVAFields.RERepercutido.Value;
                    end;
               end;
          end;
end;

procedure TMovimientoModule.ObtenPrecioVentaBase(    TiposIVAFields         : TTiposIVAFields;
                                                     Cantidad,
                                                     PrecioIVA              : Decimal;
                                                 var Precio                 : Double;
                                                     ConRecargoEquivalencia : Boolean );

var  PorcentajeIVA,
     CuotaIVA,
     CuotaRE,
     Importe,
     ImporteIVA,
     ImporteIVACalculado : Decimal;
     CountReducido,
     Count : SmallInt;
     Variacion : Extended;
     Cuadra,
     Incrementar : Boolean;
     PrecioOriginal : Double;


begin

     Cantidad := Abs( Cantidad );

     PorcentajeIVA := TiposIVAFields.IVARepercutido.Value;
     If   ConRecargoEquivalencia
     then DecAdd( PorcentajeIVA, TiposIVAFields.RERepercutido.Value );

     Precio := Redondea( PrecioIVA / ( 1 + ( ( PorcentajeIVA ) / 100.0 ) ), DecimalesPrecioBase );

     PrecioOriginal := Precio;
     Variacion := Precision( Decimales( Precio ) );
     ImporteIVA := Redondea( PrecioIVA * Cantidad );

     Count := 0;
     CountReducido := 0;

     repeat

       // No hay que utilizar el redondeo a DecimalesImportesCuotas para las cuotas, porque quiero obtener el mejor ajuste para las cuotas
       // tal y como estarán finalmente, es decir, redondeadas a 2 decimales

       Importe := Cantidad * Precio;
       CuotaIVA := Redondea( Importe * TiposIVAFields.IVARepercutido.Value / 100.0 );
       If   ConRecargoEquivalencia
       then CuotaRE := Redondea( Importe  * TiposIVAFields.RERepercutido.Value / 100.0 )
       else CuotaRE := 0.0;
       ImporteIVACalculado := Redondea( Importe + CuotaIVA + CuotaRE );

       Cuadra := ImporteIVA=ImporteIVACalculado;

       { La idea es decrementar o incrementar el valor del precio para ver si así se puede obtener un valor válido }

       If   not Cuadra
       then begin

            If   Count=0
            then Incrementar := ImporteIVA>ImporteIVACalculado
            else If   ( CountReducido<10 ) and
                      ( ( Incrementar and ( ImporteIVA<ImporteIVACalculado ) ) or    // Si ha cambiado el signo es porque se ha sobrepasado el valor
                        ( not Incrementar and ( ImporteIVA>ImporteIVACalculado ) ) ) // Reduzcamos la variación y volvamos a empezar
                 then begin
                      Inc( CountReducido );
                      Variacion := Variacion / 10.0;
                      Incrementar := not Incrementar;
                      Count := 0;
                      end;

            If   Incrementar
            then Precio := Precio + Variacion
            else Precio := Precio - Variacion;

            Inc( Count );
            end

     until Cuadra or ( Count>10 );

     // Si finalmente no cuadra tampoco es grave, porque existe un proceso de cuadre de las líneas posterior

end;

procedure TMovimientoModule.ObtenPrecioCompraBase(      TiposIVAFields : TTiposIVAFields;
                                                        PrecioIVA      : Decimal;
                                                    var Precio         : Double );

var  PrecioIVACalculado,
     CuotaIVA : Decimal;

begin
     Precio := Redondea( PrecioIVA / ( 1 + ( TiposIVAFields.IVASoportado.Value / 100.0 ) ), DecimalesPrecioBase );
     {
     CuotaIVA := Redondea( Precio * TiposIVAFields.IVASoportado.Value / 100.0 );
     PrecioIVACalculado := Redondea( Precio + CuotaIVA, DecimalesPrecioBase );
     Result := PrecioIVA=PrecioIVACalculado;
     }
end;

function TMovimientoModule.ObtenPrimerLoteConExistencias(     CodigoArticulo  : String;
                                                          var LoteFabricacion : String;
                                                          var CodigoAlmacen   : String;
                                                          var Ubicacion       : String ) : Boolean;

var SQLText : String;

begin
     Result := False;
     With ExistenciasLoteQuery do
       try
         Close;

         SQLText := 'SELECT TOP 1 LoteFabricacion, CodigoAlmacen, Ubicacion ' +
                    'FROM   Stock ' +
                    'WHERE  ( Ejercicio=' + IntToStr( ApplicationContainer.Ejercicio ) + ' ) AND ' +
                    '( CodigoArticulo=' + QuotedStr( CodigoArticulo ) + ') AND ' +
                    '( LoteFabricacion<>'''' ) AND ' +
                    '( Apertura_Entradas + Enero_Entradas + Febrero_Entradas + Marzo_Entradas + Abril_Entradas + Mayo_Entradas + Junio_Entradas + Julio_Entradas + Agosto_Entradas + Septiembre_Entradas + Octubre_Entradas + Noviembre_Entradas + Diciembre_Entradas - ' +
                    'Apertura_Salidas - Enero_Salidas - Febrero_Salidas - Marzo_Salidas - Abril_Salidas - Mayo_Salidas - Junio_Salidas - Julio_Salidas - Agosto_Salidas - Septiembre_Salidas - Octubre_Salidas - Noviembre_Salidas - Diciembre_Salidas )>0.0 ' +
                    'ORDER BY ';

         If   DataModule00.DmEmpresaFields.Ventas_FechaCaducidad.Value
         then StrAdd( SQLText, 'FechaCaducidad' )
         else StrAdd( SQLText, 'FechaUltCompra' );

         SQl.Text := SQLText;

         Open;
         try
           LoteFabricacion := ExistenciasLoteQueryLoteFabricacion.Value;
           CodigoAlmacen := ExistenciasLoteQueryCodigoAlmacen.Value;
           Ubicacion := ExistenciasLoteQueryUbicacion.Value;
           Result := True;
         finally
           Close;
           end;
       except
         end;
end;

function TMovimientoModule.ObtenNroPagina( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
                                           OperacionPagina            : TShiftOperation ) : SmallInt;

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
                soFirst : RecordFound := FindGreaterOrEqual( [ Ejercicio.Value, NroOperacion.Value, 0 ] );
                soPrior : RecordFound := FindSmaller( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] );
                soNext  : RecordFound := FindGreater( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value ] );
                soLast  : RecordFound := FindSmallerOrEqual( [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );
                end;
              end;

              If   RecordFound
              then With DmGrupoLineaMovimientoFields do
                     If   ( Ejercicio.Value=GrupoLineaMovimientoFields.Ejercicio.Value ) and
                          ( NroOperacion.Value=GrupoLineaMovimientoFields.NroOperacion.Value )
                     then Result := NroPagina.Value;

            end;
end;

function TMovimientoModule.ObtenNroLinea( LineaMovimientoFields : TLineaMovimientoFields;
                                          OperacionPagina       : TShiftOperation ) : SmallInt;

var  RecordFound : Boolean;

begin
     Result := -1;
     If   Assigned( LineaMovimientoFields )
     then With DmLineaMovimientoTable do
            begin

            IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

            With LineaMovimientoFields do
              begin
              RecordFound := False;
              case OperacionPagina of
                soFirst : RecordFound := FindGreaterOrEqual( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, 1 ] );
                soPrior : RecordFound := FindSmaller( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value ] );
                soNext  : RecordFound := FindGreater( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, NroLinea.Value ] );
                soLast  : RecordFound := FindSmallerOrEqual( [ Ejercicio.Value, NroOperacion.Value, NroPagina.Value, MaxSmallint ] );
                end;
              end;

              If   RecordFound
              then With DmLineaMovimientoFields do
                     If   ( Ejercicio.Value=LineaMovimientoFields.Ejercicio.Value ) and
                          ( NroOperacion.Value=LineaMovimientoFields.NroOperacion.Value ) and
                          ( NroPagina.Value=LineaMovimientoFields.NroPagina.Value )
                     then Result := NroLinea.Value;

            end;
end;

procedure TMovimientoModule.DesplazaLineaMovimiento( Ejercicio    : SmallInt;
                                                     NroOperacion : LongInt;
                                                     NroPagina,
                                                     NroLinea     : SmallInt;
                                                     HaciaArriba  : Boolean = False;
                                                     HastaElFinal : Boolean = False );
begin
     MovimientoService.DesplazaLineaMovimiento( Ejercicio, NroOperacion, NroPagina, NroLinea, HaciaArriba, HastaElFinal );
end;

procedure TMovimientoModule.DesplazaPaginaDocumento( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
                                                     OperacionPagina            : TShiftOperation );


var NroPaginaDestino : SmallInt;

begin
     NroPaginaDestino := ObtenNroPagina( GrupoLineaMovimientoFields, OperacionPagina );
     If   NroPaginaDestino<>-1
     then With DesplazaPaginaDocumentoStoredProc do
            begin
            Params[ 0 ].Value := GrupoLineaMovimientoFields.Ejercicio.Value;
            Params[ 1 ].Value := GrupoLineaMovimientoFields.NroOperacion.Value;
            Params[ 2 ].Value := GrupoLineaMovimientoFields.NroPagina.Value;
            Params[ 3 ].Value := NroPaginaDestino;
            try
              ExecProc;
            except on E : EnxBaseException do
              begin
              ShowDatabaseError( DesplazaPaginaDocumentoStoredProc, E );
              Abort;
              end;
            else raise;
              end;
            end;
end;

procedure TMovimientoModule.InsertaPaginaDocumento( GrupoLineaMovimientoFields : TGrupoLineaMovimientoFields );
begin
     With InsertaPaginaDocumentoStoredProc do
       begin
       Params[ 0 ].Value := GrupoLineaMovimientoFields.Ejercicio.Value;
       Params[ 1 ].Value := GrupoLineaMovimientoFields.NroOperacion.Value;
       Params[ 2 ].Value := GrupoLineaMovimientoFields.NroPagina.Value;
       try
         ExecProc;
       except on E : EnxBaseException do
         begin
         ShowDatabaseError( InsertaPaginaDocumentoStoredProc, E );
         Abort;
         end;
       else raise;
         end;
       end;
end;

procedure TMovimientoModule.RecalculaMovimiento( MovimientoFields : TMovimientoFields );

var   Index : SmallInt;
      SerieActual : String;

begin

     try

       EnterpriseDataModule.StartTransaction( [ DmLineaMovimientoTable ] );

       If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
       then Proveedor.Obten( MovimientoFields.Propietario.Value, '', DsProveedorFields )
       else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
            then begin
                 Cliente.Obten( MovimientoFields.Propietario.Value, '', DsClienteFields );
                 SerieFacturacion.Obten( MovimientoFields.Serie.Value, DsSerieFacturacionFields );
                 end;

       With DmLineaMovimientoTable do
         try

           DmLineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';

           SetRange( [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, 0, 1 ],
                     [ MovimientoFields.Ejercicio.Value, MovimientoFields.NroOperacion.Value, MaxSmallint, MaxSmallint ] );

           First;
           While not Eof do
             begin

             Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields );

             DmLineaMovimientoTable.Edit;

             If   MovimientoFields.TipoMovimiento.Value in [ tmOferta..tmCompra ]
             then FacturaCompras.CalculaImportesIVA( DmLineaMovimientoFields, DsProveedorFields, DsArticuloFields, DsTiposIVAFields )
             else If   MovimientoFields.TipoMovimiento.Value in [ tmPresupuesto..tmVenta ]
                  then FacturaVentas.CalculaImportesIVA( MovimientoFields, DmLineaMovimientoFields, DsClienteFields, DsArticuloFields, DsSerieFacturacionFields, DsTiposIVAFields )
                  else FacturaCompras.CalculaImportes( DmLineaMovimientoFields, DsArticuloFields );

             DmLineaMovimientoTable.Post;

             Next;
             end;

         finally
           DmLineaMovimientoTable.CancelRange;
           end;

     EnterpriseDataModule.Commit

     except on E : Exception do
       begin
       EnterpriseDataModule.RollBack;
       If   not ( E is EDatabaseError )
       then ShowException( E, Self );
       end;

     end;

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
       CuotaIVA.Value := 0.0;
       CuotaRE.Value := 0.0;
       PrecioIVA.Value := 0.0;
       ImporteTotal.Value := 0.0;
       end;
end;

function TMovimientoModule.SuprimeVinculosConPedidos( NroOperacion : LongInt;
                                                      NroPagina    : SmallInt ) : Boolean;
begin
     Result := MovimientoService.SuprimeVinculosConPedidos( NroOperacion, NroPagina );
end;

procedure TMovimientoModule.ImportaDatosCapturador( MovimientoFields       : TMovimientoFields;
                                                    LineaMovimientoFields  : TLineaMovimientoFields;
                                                    DataPath,
                                                    CodigoAlmacenDestino   : String );
begin
     var NroPaginaActual := LineaMovimientoFields.NroPagina.Value;
     var UltimoNroLinea := ObtenUltimoNroLinea( LineaMovimientoFields );
     MovimientoService.ImportaDatosCapturador( TMovimiento.FromDataset( MovimientoFields ),
                                               LoadFileToString( DataPath ),
                                               NroPaginaActual,
                                               UltimoNroLinea,
                                               CodigoAlmacenDestino );
end;

procedure TMovimientoModule.CompruebaMovimientoLibre( MovimientoTable : TnxeTable );
begin
     If   MovimientoTable.IsRecordLocked<>lpNotAtAll
     then begin
          ShowNotification( ntWarning, RsMsg35, RsMsg36 );
          Abort;
          end;
end;

procedure TMovimientoModule.InsertaVinculosCliente( MovimientoFields : TMovimientoFields;
                                                    ClienteFields    : TClienteFields );

var CodigoVendedor : String;

begin
     With DataModule00.DmEmpresaFields do
       begin

       If   Cliente_GruposFac.Value
       then If   GrupoCliente.Obten( ClienteFields.Factura_Agrupacion.Value )
            then MovimientoFields.GrupoFacturacion.Value := ClienteFields.Factura_Agrupacion.Value;

       If   Ventas_PagosPedido.Value
       then If   FormaCobro.Obten( ClienteFields.Cobro_FormaCobro.Value )
            then MovimientoFields.CodigoFormaCobro.Value := ClienteFields.Cobro_FormaCobro.Value;

       CodigoVendedor := Vendedor.VendedorPorDefecto( ClienteFields );
       If   Vendedor.Obten( CodigoVendedor )
       then MovimientoFields.CodigoVendedor.Value := CodigoVendedor;

       If   Ventas_Transportista.Value
       then If   Transportista.Obten( ClienteFields.Envios_Transportista.Value )
            then MovimientoFields.CodigoTransportista.Value := ClienteFields.Envios_Transportista.Value;

       If   Ventas_FormaEnvio.Value
       then If   FormaEnvio.Obten( ClienteFields.Envios_CodigoFormaEnvio.Value )
            then begin
                 MovimientoFields.FormaEnvio.Value := ClienteFields.Envios_CodigoFormaEnvio.Value;
                 var ImportePortes := 0.0;
                 If   not ValueIsEmpty( MovimientoFields.FormaEnvio.Value ) and
                      ( FormaEnvio.FormaEnvioFields.Portes.Value=Ord( TipoPortes.feDebidos ) )
                 then ImportePortes := FormaEnvio.FormaEnvioFields.Importe.Value;
                 MovimientoFields.Portes.Value := ImportePortes;
                 end
            else MovimientoFields.Portes.Value := 0.0;

         end;
end;

procedure TMovimientoModule.SetupCamposLibresLineaVentas( TableView    : TcxGridDBTableView;
                                                          CamposLibres : Array of TcxGridDBColumn );

var  I : SmallInt;
     Visible : Boolean;
     CampoLibreColumn : TcxGridDBColumn;

begin
     If   DataModule00.DmEmpresaFields.Ventas_CamposLibresLineas.Value
     then begin
          I := 1;
          For CampoLibreColumn in CamposLibres do
            begin
            CampoLibreColumn.Visible := DataModule00.DmEmpresaFields.Ventas_CampoLibreLineas[ I ].Value<>'';
            If   CampoLibreColumn.Visible
            then try
                   CampoLibreColumn.Caption := DataModule00.DmEmpresaFields.Ventas_CampoLibreLineas[ I ].Value;
                   CampoLibreColumn.Properties.Required := DataModule00.DmEmpresaFields.Ventas_CampoLibreLineasOblig[ I ].Value;
                   CampoLibreColumn.Index := GetVisibleColumnIndex( TableView, DataModule00.DmEmpresaFields.Ventas_CampoLibreLineasPos[ I ].Value );
                 except
                   end;
            Inc( I );
            end;
          end;
end;

procedure TMovimientoModule.SetupCamposLibresLineaCompras( TableView    : TcxGridDBTableView;
                                                           CamposLibres : Array of TcxGridDBColumn );

var  I : SmallInt;
     Visible : Boolean;
     CampoLibreColumn : TcxGridDBColumn;

begin
     If   DataModule00.DmEmpresaFields.Compras_CamposLibresLineas.Value
     then begin
          I := 1;
          For CampoLibreColumn in CamposLibres do
            begin
            CampoLibreColumn.Visible := DataModule00.DmEmpresaFields.Compras_CampoLibreLineas[ I ].Value<>'';
            If   CampoLibreColumn.Visible
            then try
                   CampoLibreColumn.Caption := DataModule00.DmEmpresaFields.Compras_CampoLibreLineas[ I ].Value;
                   CampoLibreColumn.Properties.Required := DataModule00.DmEmpresaFields.Compras_CampoLibreLineasOblig[ I ].Value;
                   CampoLibreColumn.Index := GetVisibleColumnIndex( TableView, DataModule00.DmEmpresaFields.Compras_CampoLibreLineasPos[ I ].Value );
                 except
                   end;
            Inc( I );
            end;
          end;
end;

procedure TMovimientoModule.ObtenRelacionDocumentos( CodigoArticulo,
                                                     CodigoClaseA,
                                                     CodigoClaseB,
                                                     CodigoClaseC     : String;
                                                     NroProceso       : SmallInt;
                                                     RelacionList     : TStringList );

begin
     With DmRelacionDocumentosTable do
       try
         IndexFieldNames := 'Tipo;CodigoArticulo;CodigoClaseA;CodigoClaseB;CodigoClaseC;NroProceso;NroLinea';
         SetRange( [ trdListaMateriales, CodigoArticulo, CodigoClaseA, CodigoClaseB, CodigoClaseC, NroProceso ] );
         ObtenRelacionDocumentosInterna( RelacionList );
       finally
         CancelRange;
         end;
end;

procedure TMovimientoModule.ObtenRelacionDocumentos( Tipo         : TTipoRelacionDocumentos;
                                                     Ejercicio    : SmallInt;
                                                     NroOperacion : Integer;
                                                     RelacionList : TStringList );

begin
     With DmRelacionDocumentosTable do
       try
         IndexFieldNames := 'Tipo;Ejercicio;NroOperacion';
         SetRange( [ Tipo, Ejercicio, NroOperacion ] );
         ObtenRelacionDocumentosInterna( RelacionList );
       finally
         CancelRange;
         end;

end;

procedure TMovimientoModule.ObtenRelacionDocumentosInterna( RelacionList  : TStringList );

begin
     With DmRelacionDocumentosTable do
       try
         First;
         While not Eof do
           begin
           RelacionList.Add( DmRelacionDocumentosFields.Documento.Value );
           Next;
           end;
       finally
         CancelRange;
         end;
end;

function TMovimientoModule.CalculoEspecial( Seccion  : TSeccionComercial;
                                            Largo,
                                            Ancho,
                                            Alto     : Decimal ) : Decimal;

var  Calculo,
     Cantidades : SmallInt;

//* 10.09.2002 Los multiplos de 3 ahora son de 6

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
          Calculo := DataModule00.DmEmpresaFields.Compras_Calculo.Value;
          Cantidades := DataModule00.DmEmpresaFields.Compras_Cantidades.Value;
          end
     else begin
          Calculo := DataModule00.DmEmpresaFields.Ventas_Calculo.Value;
          Cantidades := DataModule00.DmEmpresaFields.Ventas_Cantidades.Value;
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

end.

