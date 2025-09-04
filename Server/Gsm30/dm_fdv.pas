unit dm_fdv;

interface

uses
  Windows, Messages, SysUtils, Classes,
  System.Generics.Collections,

  DB,
  nxsdTypes,
  nxdb,
  Spring,
  LibUtils,

  Gim10Fields,
  Gim30Fields,

  AppManager,
  BaseServerContainer,
  DataManager,
  ServerDataModule,
  SessionIntf,
  BaseSessionData,

  FacturaVentasIntf,
  ParametrosFacturacionIntf,

  dmi_iva,
  dmi_fdv,
  dmi_fac,

  dm_sdf;

type

  TInsertLineEvent = procedure( ContabilizarPorCliente : Boolean; TipoIVAArticulo, TipoIVADefectoManual : SmallInt; ArticuloFields : TArticuloFields; GrupoClienteFields : TGrupoClienteFields; MovimientoFields : TMovimientoFields;LineaMovimientoFields : TLineaMovimientoFields ) of object;
  TSuprimeRelacionesFacturaEvent = procedure( FacturaVentasFields : TFacturaVentasFields ) of object;
  TCalculaImportes = procedure ( LineaMovimientoFields : TLineaMovimientoFields; ArticuloFields : TArticuloFields ) of object;

  TSubcuentaFamilia = class
     Activo : Boolean;  // Permite saber si se ha intentado guardar al menos un registro. Me permite considerar las bases imponibles 0.0
     Subcuenta : String;
     CentroCoste : String;
     TipoImpositivo : SmallInt;
     BaseImponible,
     CuotaIVA,
     CuotaRE : Decimal;
     end;

  TFacturaVentasService = class( TSessionModule, IFacturaVentasService )
     protected

     procedure AssignSession( const SessionID : Integer ); override;

     function  ProximoNroFactura( Serie : String; RegistrarValor : Boolean = True ) : LongInt;
     function  ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
     function RecalculaFactura( FacturaVentas : IFacturaVentas ) : Boolean;
     function  GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;
     procedure SuprimeFactura( Serie : String; NroFactura : LongInt );
     // procedure AnulaFactura( Serie : String; NroFactura : LongInt );
     procedure SuprimeRelaciones( FacturaVentas : IFacturaVentas; SuprimeRegistroFactura : Boolean = True );
     procedure RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal  : LongInt );
     procedure CierreCicloFacturacion( SerieInicial, SerieFinal : String; FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );
     function  ObtenBasesyCuotasFactura( Ejercicio : SmallInt; CodigoCliente, Serie : String; NroFactura : LongInt; AplicarDtosyPortes : Boolean = False ) : IBasesyCuotasFactura;
     end;

  TFacturaVentasModule = class(TServerDataModule)
    DmFacturaVentasTable: TnxeTable;
    DmFacturaVentasAuxTable: TnxeTable;
    DmFormaCobroTable: TnxeTable;
    DmClienteTable: TnxeTable;
    DmGrupoClienteTable: TnxeTable;
    DmEfectoTable: TnxeTable;
    DmClienteDatEconTable: TnxeTable;
    DmVendedorTable: TnxeTable;
    DmVendedorDatEconTable: TnxeTable;
    DmArticuloDatEconTable: TnxeTable;
    AlbaranesFacturaQuery: TnxeQuery;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    DmMovimientoAuxTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    RelacionAlbaranesTable: TnxeTable;
    DmMovimientoCajaTable: TnxeTable;
    DmEfectoCobrarTable: TnxeTable;
    DmApunteTable: TnxeTable;
    DmAsientoTable: TnxeTable;
    DmFacturaTable: TnxeTable;
    DmAsientoFacturaTable: TnxeTable;
    DmTiposIVAArticuloPaisTable: TnxeTable;
    procedure ServerDataModuleCreate(Sender: TObject);
    procedure ServerDataModuleDestroy(Sender: TObject);

  private

    DmFacturaVentasFields,
    DmFacturaVentasAuxFields : TFacturaVentasFields;
    DmFacturaFields,
    DmAsientoFacturaFields : TFacturaFields;
    DmEfectoFields : TEfectoFields;
    DmMovimientoFields,
    DmMovimientoAuxFields : TMovimientoFields;
    DmGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmGrupoClienteFields : TGrupoClienteFields;
    DmVendedorFields : TVendedorFields;
    DmClienteFields : TClienteFields;
    DmClienteDatEconFields : TClienteDatEconFields;
    DmFormaCobroFields : TFormaCobroFields;
    DmVendedorDatEconFields : TVendedorDatEconFields;
    DmArticuloDatEconFields : TArticuloDatEconFields;
    DmTiposIVAArticuloPaisFields : TTiposIVAArticuloPaisFields;

    DmAsientoFields : TAsientoFields;
    DmApunteFields : TApunteFields;
    DmEfectoCobrarFields : TEfectoCobrarFields;
    DmMovimientoCajaFields : TMovimientoCajaFields;

    DsSerieFacturacionFields : TSerieFacturacionFields;
    DsArticuloFields : TArticuloFields;
    DsFamiliaFields : TFamiliaFields;
    DsTiposIVAFields,
    DsTiposRetencionFields  : TTiposIVAFields;
    DsFacturaVentasFields : TFacturaVentasFields;
    DsEnvaseFields : TClaseFields;

    RptCabeceraTable,
    RptGrupoLineasTable,
    RptLineasTable : TnxeTable;

    RptCabeceraFields : TCabeceraFields;
    RptCabeceraAuxiliarFields : TCabeceraAuxiliarFields;
    RptGrupoLineasFields : TGrupoLineasFields;
    RptLineasFields : TLineasFields;

    AlbaranesFacturaFields : TMovimientoFields;

    NroTotalCopias,
    NroOperacionActual : LongInt;

    CalcularIVA,
    ContabilizarPorCliente : Boolean;
    TipoIVADefectoManual : SmallInt;
    Cycle : TCycle;

    PaisDeudor,
    BICDeudor,
    CodigoIBAN : String;

    CuentaVentas,
    CuentaDevVentas,
    CuentaDtoPC,
    CuentaRecargoFinanciero,
    CuentaPortes : String;

    SerieActualContador : String;
    TipoRegistroActualContador : TTipoRegistroPresentacion;

    PilaSubcuentas : TObjectList< TSubcuentaFamilia >;
    SubcuentaFamilia : TSubcuentaFamilia;
  
    RelacionEfectos : TRelacionEfectos;

    FOnSuprimeRelacionesFactura : TSuprimeRelacionesFacturaEvent;
    FOnGeneraFactura : TSimpleEvent;

    ContabilidadTransactionTag : TTransactionTag;  // Identificador de la transacción de ficheros contables

    FOnCalculaImportes : Event<TCalculaImportes>;

    procedure AbreFicherosContabilidad;
    procedure CierraFicherosContabilidad;
    procedure DoInsertLine(ContabilizarPorCliente: Boolean; TipoIVAArticulo, TipoIVADefectoManual: SmallInt; ArticuloFields: TArticuloFields; GrupoClienteFields: TGrupoClienteFields; MovimientoFields: TMovimientoFields; LineaMovimientoFields: TLineaMovimientoFields );
    procedure InicializaPila;
    procedure InsertarEnPila( Subcuenta, CentroCoste: String;TipoImpositivo: SmallInt; BaseImponible, CuotaIVA, CuotaRE : Decimal );

  public


    function Obten( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt ) : Boolean;

    {
    procedure Suprime( SerieFactura : String; NroFactura : LongInt );
    }

    function ProximoNroFactura( Serie : String; RegistrarValor : Boolean = True ) : LongInt;
    procedure RetiraNroFactura( Serie : String; Nrofactura : LongInt );

    function ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
    procedure RetiraNroRegistroPresentacion( NroRegistroPresentacion : LongWord );
    function ComprobacionRegistroPresentacionEvent( ValorActual : LongInt ) : Boolean;

    procedure ObtenTipoIVAArticulo( Fecha                  : TDateTime;
                                    ArticuloFields         : TArticuloFields;
                                    TiposIVAFields         : TTiposIVAFields;
                                    SerieFacturacionFields : TSerieFacturacionFields = nil;
                                    ClienteFields          : TClienteFields = nil );

    procedure CalculaImportes(     CantidadAjustada  : Decimal;
                                   UnidadesPorPrecio : Integer;
                                   Precio            : Double;
                                   PuntoVerde,
                                   ContribucionRAP,
                                   Recargo,
                                   Descuento         : Decimal;
                               var ImporteBruto      : Decimal;
                               var DescuentoArticulo : Decimal;
                               var ImporteNeto       : Decimal ); overload;

    procedure CalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                               ArticuloFields        : TArticuloFields ); overload;

    procedure CalculaImportes( CantidadAjustadaField   : TBCDField;
                               NroCajasField           : TBCDField;
                               UnidadesPorPrecioField  : TIntegerField;
                               PrecioField             : TFloatField;
                               PuntoVerdeField,
                               ContribucionRAPField,
                               RecargoField,
                               DescuentoField,
                               ImporteBrutoField,
                               ImporteDescuentoField   : TBCDField;
                               ImporteNetoField        : TBCDField ); overload;

    procedure CalculaImportesIVA( LineaMovimientoFields  : TLineaMovimientoFields;
                                  ClienteFields          : TClienteFields;
                                  ArticuloFields         : TArticuloFields;
                                  SerieFacturacionFields : TSerieFacturacionFields;
                                  TiposIVAFields         : TTiposIVAFields;
								                          PreciosIVAIncluido     : Boolean );

    procedure ObtenCuotasPortes(      Importe       : Decimal;
                                      Fecha         : TDate;
                                      ClienteFields : TClienteFields;
                                  var CuotaIVA      : Decimal;
                                  var CuotaRE       : Decimal );

    procedure AcumulaValoresImpositivos( var TasasArray    : TTasasArray;
                                             Fecha         : TDate;
                                             ModeloIVA     : SmallInt;
                                             CalcularIVA   : Boolean;
                                         var Sumas         : TTasaRecord );

    function RecalculaFactura( FacturaVentas : IFacturaVentas ) : Boolean; overload;
    function RecalculaFactura(     FacturaVentasFields : TFacturaVentasFields;
                                    RecuperaCliente     : Boolean;
                                var TasasArray          : TTasasArray ) : Boolean; overload;

    procedure ObtenBasesyCuotasFactura(    Ejercicio          : SmallInt;
                                           CodigoCliente,
                                           Serie              : String;
                                           NroFactura         : LongInt;
                                       var TasasArray         : TTasasArray;
                                       out TotalCuotaIVA      : Decimal;
                                       out TotalCuotaRE       : Decimal;
                                           AplicarDtosyPortes : Boolean = False );

    procedure CompruebaSupresion( FacturaVentasFields : TFacturaVentasFields );
    function GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTableName : String = '' ) : IParametrosFacturacion;
    procedure SuprimeFactura( Serie : String; NroFactura : LongInt );
    // procedure AnulaFactura( Serie : String; NroFactura : LongInt );
    function FacturaPresentada( Serie : String; NroFactura : LongInt ) : Boolean;

    procedure SuprimeRelaciones( FacturaVentasFields : TFacturaVentasFields; SuprimeRegistroFactura : Boolean = True ); overload;
    procedure SuprimeRelaciones( FacturaVentas : IFacturaVentas; SuprimeRegistroFactura : Boolean = True ); overload;

    procedure ActualizaDatosEconomicos( SerieFacturacionFields : TSerieFacturacionFields; FacturaVentasFields : TFacturaVentasFields; OnInsertLine : TInsertLineEvent; Sustraer : Boolean; ActualizarConsumos : Boolean );
    function ExisteNroFactura( ValorActual : LongInt ) : Boolean;
    procedure AplicaCondicionesCobro( FacturaVentasFields : TFacturaVentasFields; AplicarDescuentoyRecargo : Boolean = True );
    procedure RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal  : LongInt );
    procedure CierreCicloFacturacion( SerieInicial, SerieFinal : String; FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );

    property DrFacturaVentasFields : TFacturaVentasFields read DmFacturaVentasFields;

    property OnGeneraFactura : TSimpleEvent read FOnGeneraFactura Write FOnGeneraFactura;
    property OnSuprimeRelacionesFactura : TSuprimeRelacionesFacturaEvent read FOnSuprimeRelacionesFactura Write FOnSuprimeRelacionesFactura;
    property OnCalculaImportes : Event<TCalculaImportes> read FOnCalculaImportes write FOnCalculaImportes;

  end;

implementation

uses Math,
     DateUtils,
     Files,

     nxDBBase,
     nxllBde,
     nxrdClass,
     nxrbTypes,
     nxsrServerEngine,

     SessionData,
     EnterpriseData,

     Gim00Fields,

     Gsm00Dm,

     dmi_art,
     dmi_cnd,
     dmi_ast,
     dmi_mov,
     dmi_sto,

     dm_pai,
     dm_sub,
     dm_ven,
     // dm_emp,
     // dm_efe,
     dm_cli,
     // dm_rcl,
     dm_iva,
     dm_pga,
     dm_tma,
     dm_art,
     dm_sto,
     dm_ecc,
     dm_fco,
     dm_cdi,
     // dm_tca,
     dm_cls,
     // dm_ine,
     // dm_gdc,
     dm_mov,
     // dm_sdf,
     // dm_iex,
     dm_cnd,
     dm_sal,
     dm_rpf;
     // dm_ddc;

{%CLASSGROUP 'VCL.Controls.TControl'}

{$R *.DFM}
resourceString
     RsMsg1  = 'No encuentro la factura a eliminar.';
     RsMsg2  = 'La ficha del cliente %s ha sido dada de baja. El albarán %d no será facturado.';
     RsMsg3  = 'Número de factura duplicado.';
     RsMsg4  = 'El número de factura %d  ya existe. El programa le asignará a la nueva factura el número %d.';
     RsMsg5  = 'Ha desaparecido el albarán nº %d que había seleccionado previamente para facturar.';
     RsMsg6  = 'Se ha interrumpido el proceso de facturación.';
     RsMsg7  = 'La factura que estaba intendo emitir no ha sido generada y los albaranes que incluía siguen pendientes de facturar.';
     RsMsg8  = 'Factura de venta, albarán : %d, %d.';
     RsMsg9  = 'La forma de cobro %s ha sido dada de baja.';
     RsMsg10 = 'No he conseguido recuperar la ficha del cliente %s.';
     RsMsg11 = 'El cliente ha sido dado de baja. Revise el estado de sus ficheros.';
     // RsMsg12 = 'Impresión de facturas de venta.';
     RsMsg13 = 'El cliente de código [%s] ha sido dado de baja. La factura nº %d no será procesada.';
     RsMsg14 = 'El artículo [%s] ha sido dado de baja. Aparece en el albarán %d.';
     RsMsg15 = 'Se procesará como si fuera una línea manual.';
     RsMsg16 = 'La factura nº %d, del cliente %s - %s no ha sido enviada por correo porque no cumple los requisitos indicados.';
     RsMsg17 = 'Seleccionando albaranes a facturar';
     RsMsg18 = 'Generando las facturas ...';
     RsMsg19 = 'Factura de venta nº %d. Albarán nº %d.';
     RsMsg20 = 'El albarán nº %s %d no tiene líneas.';
     RsMsg21 = 'Esto solo puede ser debido a un deterioro grave de los ficheros.' + #13 + 'Regenere todos sus ficheros y revise sus datos.';
     RsMsg22 = 'La fecha de la factura no pertenece al ejercicio activo.';
     RsMsg23 = 'El cliente [%s - %s] no tiene dirección de correo.';
     RsMsg24 = 'Edite su ficha, incluya una dirección de correo válida y reintente el proceso.' + #13 + 'Se cancela el envío de facturas por correo.';
     RsMsg25 = 'Generación y exportación de ficheros de facturación.';
     RsMsg26 = 'Realizando el envío de facturas de venta por correo.';
     RsMsg27 = 'Generando el fichero de exportación de la factura.';
     RsMsg28 = 'Enviando por correo el impreso.';
     RsMsg29 = 'Envío N/Factura nro. %s %d de fecha %s.';
     RsMsg30 = #13'Estimado cliente :'#13#13'Le adjuntamos copia de nuestra factura %s %d del ejercicio %d.'#13#13'Sin otro particular, le saludamos atentamente.'#13#13'%s'#13#13;
     RsMsg31 = 'Cliente %s.';
     RsMsg32 = 'Ha ocurrido un problema al enviar el impreso por E-mail.';
     RsMsg33 = 'Revise la configuración del correo y/o la conexión a Internet y reintente el proceso.';
     RsMsg34 = 'Ha ocurrido un error al intentar recuperar la factura %s %d.';
     RsMsg35 = 'Albarán nº %d.';
     RsMsg37 = 'No se ha podido guardar la fecha de envío de la factura %s %d.';
     RsMsg38 = 'Es posible que esté siendo editada por otro usuario. El proceso de emisión continúa.';
     RsMsg39 = 'Creando el documento y guardando una copia.';
     RsMsg40 = 'Factura enviada por correo a la dirección : %s.';
     RsMsg41 = 'Se ha producido un error al intentar generar el fichero de la factura.';
     RsMsg42 = 'Periodos impositivos distintos.';
     RsMsg43 = 'El albarán %s %d, pertenece a un periodo impositivo distinto al de la fecha de facturación. Inclúyalo en facturas de ese mismo periodo.';
     RsMsg44 = 'Ha ocurrido un error al reconstruir los resultados de la factura %s %d.';
     RsMsg45 = 'Mensaje del sistema : ';
     RsMsg46 = 'Exportando en la carpeta : %s.';
     RsMsg47 = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
     RsMsg48 = 'Se cancela la generación y firma de documentos.'#13'Verifique que tiene acceso al directorio de documentos [B]%s[/B] y reintente el proceso.';
     RsMsg49 = 'Creado el fichero : %s.';
     RsMsg50 = 'Creada la factura nº %s %d del cliente %s, %s.';
     RsMsg51 = 'El %s nº %s %d está siendo editado por otro usuario.';
     RsMsg52 = 'Este documento está relacionado con la factura que pretende suprimir y es necesario que esté libre para poder modificarlo.';
     RsMsg53 = 'Recuperada la factura nº %s %d.';
     RsMsg54 = 'La serie de facturación [%s] no existe.';
     RsMsg55 = 'No he conseguido recuperar la ficha del tipo de retención %d.';
     RsMsg56 = 'La factura %s %d no puede ser elimidada porque ya ha sido presentada (Veri*factu).';
     RsMsg57 = 'La factura %s %d, del cliente %s, %s, no tiene bases imponibles y no puede ser creada.';
     RsMsg58 = 'Revise los albaranes facturables de este cliente para verificar por qué no contienen importes facturables.';
     // RsMsg59 = 'La factura %s %d no puede ser anulada porque no consta como tal en el registro de presentación (Veri*factu).';
     RsMsg60 = 'La factura %s %d no puede ser recuperada porque ya ha sido presentada (Veri*factu).';

     // Cierre del ciclo de facturacion

     RsMsg61  = 'Creando el registro contable';
     RsMsg62  = 'N/Fra. Nº %s %d';
     RsMsg63  = 'La forma de cobro utilizada en la factura %d del cliente %s ha sido dada de baja. Se utilizará la forma de cobro por defecto.';
     RsMsg64  = 'El efecto a cobrar nº %s del cliente %s no ha sido reescrito porque ';
     RsMsg65  = 'constaba como contabilizado.';
     RsMsg66  = 'está incluido en la remesa %d.';
     RsMsg67  = 'Serie %s';
     RsMsg68  = 'La factura %d del cliente %s no ha sido emitida y, por lo tanto, no está presentada. No se ha contabilizado.';
     RsMsg69  = 'Cobro factura nº ';
     RsMsg70 = 'Abono factura nº ';
     //..
     RsMsg73 = 'Se ha interrumpido el proceso de cierre.';
     RsMsg74 = 'El artículo %s ha sido dado de baja. Aparece en el albarán %s.';
     RsMsg75 = 'Las cuotas de I.V.A./R.E. calculadas de la factura nº %s %d no coinciden con las originales.';
     RsMsg76 = 'Compruebe si se han cambiado los tipos impositivos o el modelo de I.V.A. del cliente.';
     RsMsg77 = 'Procesando la factura nº %s %d.';
     RsMsg78 = 'El asiento nº %d tiene el mismo número de documento que la factura que se intenta contabilizar.';
     RsMsg79 = 'La factura nº %s %d ha generado el asiento contable nº %d.';
     RsMsg80 = 'La empresa destino de código [%s] no existe.';
     RsMsg81 = 'Se cancela el proceso de cierre. Los datos quedan tal y como estaban antes de intentar el proceso.';
     RsMsg82 = 'La fecha de la factura nº %d no pertenece al trimestre actual. No se ha contabilizado';
     RsMsg83 = 'El ejercicio contable está cerrado.';
     RsMsg84 = 'Si realiza el proceso de cierre la contabilidad podría quedar en una situación inconsistente.' + #13 +
               '¿Está seguro de que desea contabilizar las facturas?';

procedure TFacturaVentasModule.ServerDataModuleCreate(Sender: TObject);
begin
     DmFacturaVentasFields := TFacturaVentasFields.Create( DmFacturaVentasTable );
     DmFacturaVentasAuxFields := TFacturaVentasFields.Create( DmFacturaVentasAuxTable );
     DmFacturaFields := TFacturaFields.Create( DmFacturaTable );
     // DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
     DmGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmGrupoClienteFields := TGrupoClienteFields.Create( DmGrupoClienteTable );
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmClienteDatEconFields := TClienteDatEconFields.Create( DmClienteDatEconTable );
     DmVendedorFields := TVendedorFields.Create( DmVendedorTable );
     DmFormaCobroFields := TFormaCobroFields.Create( DmFormaCobroTable );
     DmVendedorDatEconFields := TVendedorDatEconFields.Create( DmVendedorDatEconTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );
     DmTiposIVAArticuloPaisFields := TTiposIVAArticuloPaisFields.Create( DmTiposIVAArticuloPaisTable );

     DsSerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     DsArticuloFields := TArticuloFields.Create( Self );
     DsFamiliaFields := TFamiliaFields.Create( Self );
     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsTiposRetencionFields := TTiposIVAFields.Create( Self );
     DsFacturaVentasFields := TFacturaVentasFields.Create( Self );
     DsEnvaseFields := TClaseFields.Create( Self );

     PilaSubcuentas := TObjectList< TSubcuentaFamilia >.Create( { OwnsObjects } True );

     // ExecOnCreateComponentProcedures( idFacturaVentasModule );
end;

procedure TFacturaVentasModule.ServerDataModuleDestroy(Sender: TObject);
begin
     try
       If   Assigned( PilaSubcuentas )
       then PilaSubcuentas.Free;
       PilaSubcuentas := nil;
       SessionDataModule.Dm30.FacturaVentasModule := nil;
     except on E : Exception do
       begin
       LogException( E, Self );
       raise;
       end;
     end;
end;

function TFacturaVentasModule.Obten( Ejercicio    : SmallInt;
                                     Serie        : String;
                                     NroFactura   : LongInt ) : Boolean;

begin
     With DmFacturaVentasTable do
       begin
       IndexFieldNames := 'Ejercicio;Serie;NroFactura';
       Result := FindKey( [ Ejercicio, Serie, NroFactura ] );
       end;
end;

procedure TFacturaVentasModule.ObtenTipoIVAArticulo( Fecha                  : TDateTime;
                                                     ArticuloFields         : TArticuloFields;
                                                     TiposIVAFields         : TTiposIVAFields;
                                                     SerieFacturacionFields : TSerieFacturacionFields = nil;
                                                     ClienteFields          : TClienteFields = nil );
var  TipoDeIVA : SmallInt;
     CodigoPaisIVA : String;

begin
     
	 CodigoPaisIVA := '';
	 If   Assigned( ClienteFields )
     then If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
          then CodigoPaisIVA := ClienteFields.CodigoPais.Value;
		  
     If   ArticuloFields.Codigo.IsNull   // Es un registro de artículo manual o vacío
     then TipoDeIVA := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha, CodigoPaisIVA, rgTipoIVAManual )
     else TipoDeIVA := ArticuloFields.TipoIVA.Value;

     If   Assigned( SerieFacturacionFields ) and SerieFacturacionFields.Initialized and SerieFacturacionFields.ExentoIVA.Value
     then TipoDeIVA := 0  // Exento
     else If   Assigned( ClienteFields )
          then If   ClienteFields.Factura_ModeloIVA.Value=micExento
               then TipoDeIVA := 0  // Exento
               else If   ( ClienteFields.Factura_ModeloIVA.Value=micTipoFijo ) and not ArticuloFields.NoAplicarTipoFijo.Value
                    then TipoDeIVA := ClienteFields.Factura_TipoFijoIVA.Value
                    else If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
                         then If   DmTiposIVAArticuloPaisTable.FindKey( [ ArticuloFields.Codigo.Value, CodigoPaisIVA ] )
                              then TipoDeIVA := DmTiposIVAArticuloPaisFields.TipoIVA.Value;

     SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha, CodigoPaisIVA, TipoDeIVA, TiposIVAFields );
end;

function TFacturaVentasModule.ProximoNroFactura( Serie          : String;
                                                 RegistrarValor : Boolean = True ) : LongInt;

var  ValorActual : LongInt;
     RecordFound : Boolean;

begin

     ValorActual := 0;

     SerieActualContador := Serie;

     With DmFacturaVentasAuxTable do
       begin

       IndexFieldnames := 'Ejercicio;Serie;NroFactura';

       RecordFound := FindEqualLast( [ SessionDataModule.Ejercicio, Serie ] );
       If   RecordFound
       then ValorActual := DmFacturaVentasAuxFields.NroFactura.Value + 1
       else ValorActual := 1;

       ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ExisteNroFactura, cnFacturaVentas, SessionDataModule.Ejercicio, Serie, ValorActual, 1 );
       If   not RegistrarValor
       then SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnFacturaVentas, SessionDataModule.Ejercicio, Serie, ValorActual );

       SessionDataModule.Dm00.ContadoresModule.CompruebaValorMaximo( ValorActual );
       end;

     Result := ValorActual;

end;

procedure TFacturaVentasModule.RetiraNroFactura( Serie      : String;
                                                 Nrofactura : LongInt );
begin
     SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnFacturaVentas, SessionDataModule.Ejercicio, Serie, NroFactura );
end;

function TFacturaVentasModule.ExisteNroFactura( ValorActual : LongInt ) : Boolean;
begin
     Result := DmFacturaVentasAuxTable.FindKey( [ SessionDataModule.Ejercicio, SerieActualContador, ValorActual ] );
end;

procedure TFacturaVentasModule.CalculaImportes(     CantidadAjustada  : Decimal;
                                                    UnidadesPorPrecio : Integer;
                                                    Precio            : Double;
                                                    PuntoVerde,
                                                    ContribucionRAP,
                                                    Recargo,
                                                    Descuento         : Decimal;
                                                var ImporteBruto      : Decimal;
                                                var DescuentoArticulo : Decimal;
                                                var ImporteNeto       : Decimal );

var  BaseDescuentos : Decimal;

begin
     If   CantidadAjustada=0.0
     then begin
          ImporteBruto := 0.0;
          DescuentoArticulo := 0.0;
          ImporteNeto := 0.0;
          end
     else begin

          If   SessionDataModule.EmpresaFields.Articulo_UnidadesPorPrecio.Value and ( UnidadesPorPrecio>0 )
          then CantidadAjustada := CantidadAjustada / UnidadesPorPrecio;

          ImporteBruto := CantidadAjustada * ( Precio + PuntoVerde + Recargo );

          If   SessionDataModule.EmpresaFields.Articulo_ContribucionRAPRepercutida.Value
          then ImporteBruto := ImporteBruto + ContribucionRAP;

          BaseDescuentos := CantidadAjustada * ( Precio + Recargo );
          DescuentoArticulo := ( BaseDescuentos * Descuento ) / 100.0;
          ImporteNeto := ImporteBruto - DescuentoArticulo;

          end;
end;

procedure TFacturaVentasModule.CalculaImportes( LineaMovimientoFields : TLineaMovimientoFields;
                                                ArticuloFields        : TArticuloFields );

var  ImporteBrutoLinea,
     ImporteDescuentoLinea,
     ImporteNetoLinea : Decimal;

begin
     With LineaMovimientoFields do
       begin
       CalculaImportes( CantidadAjustada.Value,
                        ArticuloFields.UnidadesPrecioVenta.Value,
                        Precio.Value,
                        PuntoVerde.Value,
                        ContribucionRAP.Value,
                        Recargo.Value,
                        Descuento.Value,
                        ImporteBrutoLinea,
                        ImporteDescuentoLinea,
                        ImporteNetoLinea );

       ImporteBruto.Value := ImporteBrutoLinea;
       ImporteDescuento.Value := ImporteDescuentoLinea;
       ImporteNeto.Value := ImporteNetoLinea;
       end;

     If   FOnCalculaImportes.CanInvoke
     then FOnCalculaImportes.Invoke( LineaMovimientoFields, ArticuloFields );

end;

procedure TFacturaVentasModule.CalculaImportes( CantidadAjustadaField   : TBCDField;
                                                NroCajasField           : TBCDField;
                                                UnidadesPorPrecioField  : TIntegerField;
                                                PrecioField             : TFloatField;
                                                PuntoVerdeField,
                                                ContribucionRAPField,
                                                RecargoField,
                                                DescuentoField,
                                                ImporteBrutoField,
                                                ImporteDescuentoField   : TBCDField;
                                                ImporteNetoField        : TBCDField );
var  ImporteBrutoLinea,
     ImporteDescuentoLinea,
     ImporteNetoLinea,
     PuntoVerde,
     ContribucionRAP  : Decimal;

begin

     If   Assigned( PuntoVerdeField )
     then PuntoVerde := PuntoVerdeField.Value
     else PuntoVerde := 0.0;

     If   Assigned( ContribucionRAPField )
     then ContribucionRAP := ContribucionRAPField.Value
     else ContribucionRAP := 0.0;

     CalculaImportes( CantidadAjustadaField.Value,
                      UnidadesPorPrecioField.Value,
                      PrecioField.Value,
                      PuntoVerde,
                      ContribucionRAP,
                      RecargoField.Value,
                      DescuentoField.Value,
                      ImporteBrutoLinea,
                      ImporteDescuentoLinea,
                      ImporteNetoLinea );

     If   Assigned( ImporteBrutoField )
     then ImporteBrutoField.Value := ImporteBrutoLinea;
     If   Assigned( ImporteDescuentoField )
     then ImporteDescuentoField.Value := ImporteDescuentoLinea;
     If   Assigned( ImporteNetoField )
     then ImporteNetoField.Value := ImporteNetoLinea;
end;

// Utilizo el parámetro PreciosIVAIncluido en lugar de pasar el campo MovimientoFields porque en algunos casos
// no está disponibles en el servidor (servicios, importaciones de módulos, etc..)

procedure TFacturaVentasModule.CalculaImportesIVA(  LineaMovimientoFields  : TLineaMovimientoFields;
                                                    ClienteFields          : TClienteFields;
                                                    ArticuloFields         : TArticuloFields;
                                                    SerieFacturacionFields : TSerieFacturacionFields;
                                                    TiposIVAFields         : TTiposIVAFields;
													                                       PreciosIVAIncluido     : Boolean );
var  AplicarIVA,
     AplicarRE : Boolean;
     DecimalesImportesCuotas : SmallInt;

begin

     // No redondeo de momento los importes para poder utilizar los valores en el cálculo del I.V.A.

     CalculaImportes( LineaMovimientoFields, ArticuloFields );

     With LineaMovimientoFields do
       begin

       ObtenTipoIVAArticulo( Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );

       PrecioIVA.Value := Redondea( Precio.Value );
       CodigoTipoIVA.Value := 0;
       CuotaIVA.Value := 0.0;
       CuotaRE.Value := 0.0;

       AplicarIVA := not SerieFacturacionFields.ExentoIVA.Value;
       AplicarRE := False;

       If   AplicarIVA
       then If   Assigned( ClienteFields ) and ClienteFields.Initialized
            then begin
                 AplicarIVA := ClienteFields.Factura_ModeloIVA.Value<>micExento;
                 AplicarRE := ClienteFields.Factura_ModeloIVA.Value=micConRE;
                 end;

       If   PreciosIVAIncluido
       then DecimalesImportesCuotas := 2
       else DecimalesImportesCuotas := 4;

       If   AplicarIVA
       then begin
            CodigoTipoIVA.Value := TiposIVAFields.Codigo.Value;
            CuotaIVA.Value := Redondea( ImporteNeto.Value * TiposIVAFields.IVARepercutido.Value / 100.0, DecimalesImportesCuotas );
            PrecioIVA.Value := Redondea( Precio.Value + ( Precio.Value * TiposIVAFields.IVARepercutido.Value / 100.0 ) );
            If   AplicarRE
            then begin
                 CuotaRE.Value := Redondea( ImporteNeto.Value * TiposIVAFields.RERepercutido.Value / 100.0, DecimalesImportesCuotas );
                 PrecioIVA.Value := Redondea( PrecioIVA.Value + ( Precio.Value * TiposIVAFields.RERepercutido.Value / 100.0 ) );
                 end;
            end;

       ImporteBruto.Value := Redondea( ImporteBruto.Value, DecimalesImportesCuotas );
       ImporteNeto.Value := Redondea( ImporteNeto.Value, DecimalesImportesCuotas );
       ImporteTotal.Value := Redondea( ImporteNeto.Value + CuotaIVA.Value + CuotaRE.Value, DecimalesImportesCuotas );

       // Comprobando si hay alguna diferencia entre el importe con IVA incluido de la linea calculado y el obtenido a partir del precio con IVA
       // De momento solo en Empresas que utilizan precios con IVA incluído. Puede que sea interesante ampliarlo a todas.

       {  //** 18.01.2018   Quito el código porque, ahora, el cliente se ha dado cuenta de que no es apropiado (se hizo porque lo pidió él, pero bueno)
                            Dejo el código para recordar el tipo de operación que hice (nunca se sabe)
          //** 17.04.2023   Lo vuelvo a activar. Ahora simplemente impido que se puedan reconstruir los importes desde el proceso de de reconstruccion de resultados
       }

       If   PreciosIVAIncluido and ( CuotaIVA.Value<>0.0 ) and ( CantidadAjustada.Value<>0.0 )
       then begin

            var CantidadAjustadaIVA := CantidadAjustada.Value;

            If   SessionDataModule.EmpresaFields.Articulo_UnidadesPorPrecio.Value and ( ArticuloFields.UnidadesPrecioVenta.Value>0 )
            then CantidadAjustadaIVA := CantidadAjustadaIVA / ArticuloFields.UnidadesPrecioVenta.Value;

            var ImporteBrutoIVA := CantidadAjustadaIVA * ( PrecioIVA.Value + PuntoVerde.Value + Recargo.Value ) ;

            If   SessionDataModule.EmpresaFields.Articulo_ContribucionRAPRepercutida.Value
            then ImporteBrutoIVA := ImporteBrutoIVA + ContribucionRAP.Value;  // No depende de la cantidad, sino del número de cajas y ya está calculado en la línea

            var BaseDescuentosIVA := CantidadAjustadaIVA * ( PrecioIVA.Value + Recargo.Value );
            var DescuentoArticuloIVA := ( BaseDescuentosIVA * Descuento.Value ) / 100.0;
            var ImporteNetoIVA := ImporteBrutoIVA - DescuentoArticuloIVA;

            var Diferencia := ImporteTotal.Value - ImporteNetoIVA;
            If   Diferencia<>0.0
            then begin
                 CuotaIVA.Value := CuotaIVA.Value - Diferencia;
                 ImporteTotal.Value := Redondea( ImporteNeto.Value + CuotaIVA.Value + CuotaRE.Value, DecimalesImportesCuotas );
                 end;

            end;

       end;

end;
procedure TFacturaVentasModule.AplicaCondicionesCobro( FacturaVentasFields      : TFacturaVentasFields;
                                                       AplicarDescuentoyRecargo : Boolean = True );
begin

     // Una comprobación por un error en la edición que permitía introducir plazos negativos (y lo han hecho, oiga)

     If   not DmFormaCobroTable.FindKey( [ FacturaVentasFields.CodigoFormaCobro.Value ] ) or
          ( ( DmFormaCobroFields.Plazos.Value<0 ) or ( DmFormaCobroFields.Plazos.Value>99 ) )
     then begin

          SessionDataModule.SendNotification( ntWarning, Format( RsMsg63, [ FacturaVentasFields.NroFactura.Value, FacturaVentasFields.CodigoCliente.Value ] ) );

          With DmFormaCobroFields do
            begin
            DatasetAppend;
            Plazos.Value := 1;
            PrimerVencimiento.Value := 0;
            Intervalo.Value := 0;
            CrearRegistro.Value := True;
            DatasetBrowse;
            end;

          end;

     If   ValueIsEmpty( DmClienteFields.Cobro_DiaCobro1.Value )
     then FacturaVentasFields.DiaCobro1.Value := DmFormaCobroFields.DiaCobro1.Value
     else FacturaVentasFields.DiaCobro1.Value := DmClienteFields.Cobro_DiaCobro1.Value;

     If   ValueIsEmpty( DmClienteFields.Cobro_DiaCobro2.Value )
     then FacturaVentasFields.DiaCobro2.Value := DmFormaCobroFields.DiaCobro2.Value
     else FacturaVentasFields.DiaCobro2.Value := DmClienteFields.Cobro_DiaCobro2.Value;

     If   AplicarDescuentoyRecargo
     then begin

          If   DmFormaCobroFields.DescuentoPP.Value
          then If   DmClienteFields.Factura_DtoPP.Value=0.0
               then FacturaVentasFields.DescuentoPP.Value := DmFormaCobroFields.TipoDescuentoPP.Value
               else FacturaVentasFields.DescuentoPP.Value := DmClienteFields.Factura_DtoPP.Value;

          If   DmFormaCobroFields.RecargoFinanciero.Value
          then If   DmClienteFields.Factura_RecFinanc.Value=0.0
               then FacturaVentasFields.RecargoFinanciero.Value := DmFormaCobroFields.TipoRecargoFinanc.Value
               else FacturaVentasFields.RecargoFinanciero.Value := DmClienteFields.Factura_RecFinanc.Value;

          end;

end;

procedure TFacturaVentasModule.ObtenBasesyCuotasFactura(     Ejercicio          : SmallInt;
                                                             CodigoCliente,
                                                             Serie              : String;
                                                             NroFactura         : LongInt;
                                                         var TasasArray         : TTasasArray;
                                                         out TotalCuotaIVA      : Decimal;
                                                         out TotalCuotaRE       : Decimal;
                                                             AplicarDtosyPortes : Boolean = False );

begin

     FillChar( TasasArray, SizeOf( TTasasArray ) ,#0 );

     With DmMovimientoTable do
       try

         IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';
         SetRange( [ tmVenta, Ejercicio, CodigoCliente, Serie, NroFactura ] );

         First;
         While not Eof do
           begin

           With DmLineaMovimientoTable do
             begin

             With DmMovimientoFields do
               SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

             First;
             While not Eof do
               begin
               var CodigoTipoIVA := DmLineaMovimientoFields.CodigoTipoIVA.Value;
               If   CodigoTipoIVA in [ 0..NroMaximoTiposTasas ]
               then begin

                    TasasArray[ CodigoTipoIVA ].TieneBases := True;

                    DecAdd( TasasArray[ CodigoTipoIVA ].BaseImponible, DmLineaMovimientoFields.ImporteNeto.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].BaseNoSujetaDto, DmLineaMovimientoFields.CantidadAjustada.Value * DmLineaMovimientoFields.PuntoVerde.Value );

                    If   SessionDataModule.EmpresaFields.Articulo_ContribucionRAPRepercutida.Value
                    then DecAdd( TasasArray[ CodigoTipoIVA ].BaseNoSujetaDto, DmLineaMovimientoFields.ContribucionRAP.Value );

                    DecAdd( TasasArray[ CodigoTipoIVA ].CuotaIVA, DmLineaMovimientoFields.CuotaIVA.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].CuotaRE, DmLineaMovimientoFields.CuotaRE.Value );
                    DecAdd( TasasArray[ CodigoTipoIVA ].Importe, DmLineaMovimientoFields.ImporteTotal.Value );
                    If   ( CodigoTipoIVA<>0 ) and ( TasasArray[ CodigoTipoIVA ].TipoIVA=0.0 )
                    then begin
                         SessionDataModule.Dm10.TasaModule.TipoIVA( DmLineaMovimientoFields.Fecha.Value, CodigoTipoIVA, DsTiposIVAFields );
                         TasasArray[ CodigoTipoIVA ].TipoIVA := DsTiposIVAFields.IVAREpercutido.Value;
                         TasasArray[ CodigoTipoIVA ].TipoRE := DsTiposIVAFields.RERepercutido.Value;
                         end;
                    end;
               Next;
               end;

             end;

           Next;
           end;

         If   AplicarDtosyPortes
         then begin
              DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
              If   DmFacturaVentasTable.FindKey( [ Ejercicio, Serie, NroFactura ] )
              then begin

                   SessionDataModule.Dm10.ClienteModule.Obten( CodigoCliente, DmClienteFields);

                   var CalcularIVA := DmClienteFields.Factura_ModeloIVA.Value<>micExento;
                   If   SessionDataModule.Dm10.SerieFacturacionModule.Obten( DmFacturaVentasFields.Serie.Value, DsSerieFacturacionFields )
                   then CalcularIVA := CalcularIVA and not DsSerieFacturacionFields.ExentoIVA.Value;

                   var CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DmClienteFields );
                   var RecalcularCuotas := ( DmFacturaVentasFields.DescuentoES.Value<>0.0 ) or ( DmFacturaVentasFields.DescuentoPP.Value<>0.0 );
                   var TipoIVAPortes := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, rgTipoIVAPortes );

                   If   DmFacturaVentasFields.Portes.Value<>0.0
                   then TasasArray[ TipoIVAPortes ].BaseImponible := TasasArray[ TipoIVAPortes ].BaseImponible + DmFacturaVentasFields.Portes.Value;

                   For var Index : SmallInt := 0 to NroMaximoTiposTasas do
                     begin

                     If   TasasArray[ Index ].BaseImponible<>0.0
                     then begin

                          var ImporteBaseDescuentos := TasasArray[ Index ].BaseImponible;
                          If   Index=TipoIVAPortes
                          then ImporteBaseDescuentos := ImporteBaseDescuentos - DmFacturaVentasFields.Portes.Value;

                          ImporteBaseDescuentos := ImporteBaseDescuentos - TasasArray[ Index ].BaseNoSujetaDto;

                          var ImporteDescuentos : Decimal := 0.0;

                          If   DmFacturaVentasFields.DescuentoES.Value<>0.0
                          then DecAdd( ImporteDescuentos, Redondea( ( ImporteBaseDescuentos * DmFacturaVentasFields.DescuentoES.Value ) / 100.0 ) );
                          If   DmFacturaVentasFields.DescuentoPP.Value<>0.0
                          then DecAdd( ImporteDescuentos, Redondea( ( ( ImporteBaseDescuentos - ImporteDescuentos ) * DmFacturaVentasFields.DescuentoPP.Value ) / 100.0 ) );

                          DecAdd( TasasArray[ Index ].BaseImponible, -ImporteDescuentos );
                          end;

                     If   Index=0     // Tipo exento
                     then begin

                          If   DmFacturaVentasFields.ImporteRecFinanciero.Value<>0.0
                          then begin
                               DecAdd( TasasArray[ 0 ].BaseImponible, DmFacturaVentasFields.ImporteRecFinanciero.Value );
                               TasasArray[ Index ].TieneBases := True;
                               end;

                          If   DmFacturaVentasFields.ImporteRetencion.Value<>0.0
                          then begin
                               DecAdd( TasasArray[ Index ].BaseImponible, -DmFacturaVentasFields.ImporteRetencion.Value );
                               TasasArray[ Index ].TieneBases := True;
                               end;

                          end;

                      If   CalcularIVA and ( RecalcularCuotas or ( ( DmFacturaVentasFields.Portes.Value<>0.0 ) and ( Index=TipoIVAPortes ) ) )
                     then begin
                          SessionDataModule.Dm10.TasaModule.TipoIVA( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, Index, DsTiposIVAFields );
                          TasasArray[ Index ].TipoIVA := DsTiposIVAFields.IVARepercutido.Value;
                          TasasArray[ Index ].CuotaIVA := ( TasasArray[ Index ].BaseImponible * DsTiposIVAFields.IVARepercutido.Value ) / 100.0;
                          If   DmClienteFields.Factura_ModeloIVA.Value=micConRE
                          then begin
                               TasasArray[ Index ].TipoRE := DsTiposIVAFields.RERepercutido.Value;
                               TasasArray[ Index ].CuotaRE := ( TasasArray[ Index ].BaseImponible * DsTiposIVAFields.RERepercutido.Value ) / 100.0;
                               end;
                          end;

                     TasasArray[ Index ].Importe := Redondea( TasasArray[ Index ].BaseImponible + TasasArray[ Index ].CuotaIVA + TasasArray[ Index ].CuotaRE );

                     end;

                   end;
              end;

         TotalCuotaIVA := 0.0;
         TotalCuotaRE := 0.0;

         For var I := 0 to NroMaximoTiposTasas do
           If   TasasArray[ I ].CuotaIVA<>0.0
           then begin
                DecAdd( TotalCuotaIVA, Redondea( TasasArray[ I ].CuotaIVA ) );
                DecAdd( TotalCuotaRE, Redondea( TasasArray[ I ].CuotaRE ) );
                end;

       finally
         DmMovimientoTable.CancelRange;
         DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';
         DmLineaMovimientoTable.CancelRange;
         end;


end;

function TFacturaVentasModule.RecalculaFactura( FacturaVentas : IFacturaVentas ) : Boolean;

var  TableCursor : TnxServerTableCursor;
     TasasArray : TTasasArray;

begin
     Result := False;
     DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
     If   TnxServerTableCursor.LookupByID( FacturaVentas.RemoteCursorID, TableCursor )=DBIERR_NONE
     then If   DmFacturaVentasTable.FindKey( [ FacturaVentas.Ejercicio, FacturaVentas.Serie, FacturaVentas.NroFactura ] )
          then begin
               TableCursor.RecordLockRelease( False );
               FacturaVentas.ToDataset( DmFacturaVentasFields );
               Result := RecalculaFactura( DmFacturaVentasFields, True, TasasArray );
               DmFacturaVentasTable.Post;
               end;
end;

// Si la factura no tienen bases imponibles devuelve false (no hay nada que facturar)

function TFacturaVentasModule.RecalculaFactura(     FacturaVentasFields : TFacturaVentasFields;
                                                    RecuperaCliente     : Boolean;
                                                var TasasArray          : TTasasArray ) : Boolean;

Var  SumaBaseImponible : Decimal;
     TipoIVAPortes,
     Indice : SmallInt;

     ImporteDescuentos,
     ImporteBaseImp,
     ImporteBaseDescuentos,
     ImporteCuotaIVA,
     ImporteCuotaRE,
     NetoFacturaBaseDtos,
     NetoFraRetencionBaseDtos,
     ImporteDtoESRetencion,
     ImporteDtoPPRetencion,
     CuotaIVAPortes,
     CuotaREPortes,
     ImporteRecFinancRetencion,
     SumaDtosCliente,
     SumaDtosClienteRetencion : Decimal;

     TiposIVAFields : TTiposIVAFields;

     RecalcularIVA : Boolean;
     CodigoPaisIVA : String;

begin

     Result := False;

     SumaBaseImponible := 0.0;

     With FacturaVentasFields do
       begin

       If   RecuperaCliente
       then If   DmClienteTable.FindKey( [ CodigoCliente.Value ] )
            then begin
                 CalcularIVA := DmClienteFields.Factura_ModeloIVA.Value<>micExento;
                 If   SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie.Value, DsSerieFacturacionFields )
                 then CalcularIVA := CalcularIVA and not DsSerieFacturacionFields.ExentoIVA.Value;
                 AplicaCondicionesCobro( FacturaVentasFields, False );
                 end
            else begin
                 SessionDataModule.SendNotification( ntStop, Format( RsMsg10, [ CodigoCliente.Value ] ), RsMsg11 );
                 Abort;
                 end;

        ObtenBasesyCuotasFactura( Ejercicio.Value,
                                  CodigoCliente.Value,
                                  Serie.Value,
                                  NroFactura.Value,
                                  TasasArray,
                                  ImporteCuotaIVA,
                                  ImporteCuotaRE );

       CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DmClienteFields );
       TipoIVAPortes := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha.Value, CodigoPaisIVA, rgTipoIVAPortes );

       If   Portes.Value<>0.0
       then begin
            TasasArray[ TipoIVAPortes ].BaseImponible := TasasArray[ TipoIVAPortes ].BaseImponible + Portes.Value;
            TasasArray[ TipoIVAPortes ].TieneBases := True;
            end;

       { Si la factura tiene descuentos hay que recalcular las cuotas sí o sí }

       RecalcularIVA := ( DescuentoES.Value<>0.0 ) or ( DescuentoPP.Value<>0.0 );

       { Como las cuotas pueden haberse recalculado al modificar los descuentos, es necesario volverlas a obtener
         cada vez desde las líneas. }

       If   RecalcularIVA
       then begin
            CuotaIVA.Value := 0.0;
            CuotaRE.Value := 0.0;
            end
       else begin

            CuotaIVA.Value := ImporteCuotaIVA;
            CuotaRE.Value := ImporteCuotaRE;

            If   Portes.Value<>0.0
            then begin
                 ObtenCuotasPortes( Portes.Value, Fecha.Value, DmClienteFields, CuotaIVAPortes, CuotaREPortes );
                 CuotaIVA.Value := CuotaIVA.Value + CuotaIVAPortes;
                 CuotaRE.Value := CuotaRE.Value + CuotaREPortes;
                 end;

            end;

       For Indice := 0 to NroMaximoTiposTasas do
         If   TasasArray[ Indice ].TieneBases  // No importa que el total sea cero
         then begin

              Result := True;                 // Hay, por lo menos, una base imponible

              TasasArray[ Indice ].BaseImponible := Redondea( TasasArray[ Indice ].BaseImponible );

              ImporteBaseImp := TasasArray[ Indice ].BaseImponible;

              DecAdd( SumaBaseImponible, TasasArray[ Indice ].BaseImponible );

              ImporteBaseDescuentos := ImporteBaseImp;
              If   Indice=TipoIVAPortes
              then ImporteBaseDescuentos := ImporteBaseDescuentos - Portes.Value;

              ImporteBaseDescuentos := ImporteBaseDescuentos - TasasArray[ Indice ].BaseNoSujetaDto;

              ImporteDescuentos := 0.0;

              If   DescuentoES.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ImporteBaseDescuentos * DescuentoES.Value ) / 100.0 ) );
              If   DescuentoPP.Value<>0.0
              then DecAdd( ImporteDescuentos, Redondea( ( ( ImporteBaseDescuentos - ImporteDescuentos ) * DescuentoPP.Value ) / 100.0 ) );

              DecAdd( ImporteBaseImp, -ImporteDescuentos );

              If   RecalcularIVA and
                   CalcularIVA and
                   ( Indice<>0 )
              then begin
                   SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha.Value, CodigoPaisIVA, Indice, DsTiposIVAFields );
                   ImporteCuotaIVA := Redondea( ( ImporteBaseImp * DsTiposIVAFields.IVARepercutido.Value ) / 100.0 );
                   If   DmClienteFields.Factura_ModeloIVA.Value=micConRE
                   then ImporteCuotaRE := Redondea( ( ImporteBaseImp * DsTiposIVAFields.RERepercutido.Value ) / 100.0 )
                   else ImporteCuotaRE := 0;
                   CuotaIVA.Value := CuotaIVA.Value + ImporteCuotaIVA;
                   CuotaRE.Value := CuotaRE.Value + ImporteCuotaRE;
                   end;

              end;

         CuotaIVA.Value := Redondea( CuotaIVA.Value );
         CuotaRE.Value := Redondea( CuotaRE.Value );

         NetoFactura.Value := SumaBaseImponible - Portes.Value;  // Ya está rendondeado

         NetoFacturaBaseDtos := NetoFactura.Value - ImportePuntoVerde.Value;
         NetoFraRetencionBaseDtos := NetoFacturaRetencion.Value - ImportePuntoVerde.Value;

         If   SessionDataModule.EmpresaFields.Articulo_ContribucionRAPRepercutida.Value
         then begin
              NetoFacturaBaseDtos := NetoFactura.Value - ImporteContribucionRAP.Value;
              NetoFraRetencionBaseDtos := NetoFacturaRetencion.Value - ImporteContribucionRAP.Value;
              end;

         If   ValueIsEmpty( DescuentoES.Value )
         then begin
              ImporteDtoES.Value := 0.0;
              ImporteDtoESRetencion := 0.0;
              end
         else begin
              ImporteDtoES.Value := Redondea( ( NetoFacturaBaseDtos * DescuentoES.Value ) / 100.0 );
              ImporteDtoESRetencion := Redondea( ( NetoFraRetencionBaseDtos * DescuentoES.Value ) / 100.0 );
              end;

         If   ValueIsEmpty( DescuentoPP.Value )
         then begin
              ImporteDtoPP.Value := 0.0;
              ImporteDtoPPRetencion := 0.0;
              end
         else begin
              ImporteDtoPP.Value := Redondea( ( ( NetoFacturaBaseDtos - ImporteDtoES.Value ) * DescuentoPP.Value ) / 100.0 );
              ImporteDtoPPRetencion := Redondea( ( ( NetoFraRetencionBaseDtos - ImporteDtoESRetencion ) * DescuentoPP.Value ) / 100.0 );
              end;

         SumaDtosCliente := ImporteDtoPP.Value + ImporteDtoES.Value;
         SumaDtosClienteRetencion := ImporteDtoPPRetencion + ImporteDtoESRetencion;

         If   ValueIsEmpty( RecargoFinanciero.Value )
         then begin
              ImporteRecFinanciero.Value := 0.0;
              ImporteRecFinancRetencion := 0.0;
              end
         else begin
              ImporteRecFinanciero.Value := Redondea( ( ( NetoFactura.Value - SumaDtosCliente ) * RecargoFinanciero.Value ) / 100.0 );
              ImporteRecFinancRetencion := Redondea( ( ( NetoFacturaRetencion.Value - SumaDtosClienteRetencion ) * RecargoFinanciero.Value ) / 100.0 );
              end;

         DescuentosClientes.Value:= Redondea( SumaDtosCliente );
         TotalFactura.Value := NetoFactura.Value - DescuentosClientes.Value + CuotaIVA.Value + CuotaRE.Value + ImporteRecFinanciero.Value + Portes.Value;

         If   SessionDataModule.EmpresaFields.Vendedor_ComPorCli.Value and ( CodigoVendedor.Value<>'' )
         then Comision.Value := ( ( NetoFactura.Value - DescuentosClientes.Value ) * TipoComision.Value ) / 100.0
         else begin
              TipoComision.Value := 0.0;
              Comision.Value := 0.0;
              end;

         If   ValueIsEmpty( TipoRetencion.Value )
         then ImporteRetencion.Value := 0.0
         else If   SessionDataModule.Dm10.TasaModule.TipoRetencion( Fecha.Value, TipoRetencion.Value, DsTiposRetencionFields )
              then begin
                   If   DsTiposRetencionFields.SobreTotal.Value
                   then BaseCalculoRetencion.Value := TotalFactura.Value // No se consideran los artículos no sujetos a retención
                   else BaseCalculoRetencion.Value := NetoFacturaRetencion.Value - SumaDtosClienteRetencion + ImporteRecFinancRetencion;
                   ImporteRetencion.Value := Redondea( BaseCalculoRetencion.Value * DsTiposRetencionFields.Retencion.Value / 100.0 );
                   TotalFactura.Value := TotalFactura.Value - ImporteRetencion.Value;
                   end
              else begin
                   SessionDataModule.SendNotification( ntStop, Format( RsMsg55, [ TipoRetencion.Value ] ) );
                   Abort;
                   end;

       With FacturaVentasFields do
         If   ValueIsEmpty( DmFormaCobroFields.Plazos.Value )
         then SessionDataModule.Dm30.EfectoModule.SuprimeEfectos( scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value )
         else begin
              DesgloseVencimientos( FechaValor.Value,
                                    DmFormaCobroFields.Plazos.Value,
                                    DmFormaCobroFields.PrimerVencimiento.Value,
                                    DmFormaCobroFields.Intervalo.Value,
                                    DiaCobro1.Value,
                                    DiaCobro2.Value,
                                    DmClienteFields.Cobro_MesNoCobro.Value,
                                    DmFormaCobroFields.Meses30Dias.Value,
                                    TotalFactura.Value - TotalACuenta.Value,
                                    RelacionEfectos );

              SessionDataModule.Dm30.EfectoModule.GeneraEfectos( scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value, Fecha.Value, RelacionEfectos );
              end;

       end;

end;

procedure TFacturaVentasModule.ObtenCuotasPortes(     Importe       : Decimal;
                                                      Fecha         : TDate;
                                                      ClienteFields : TClienteFields;
                                                  var CuotaIVA      : Decimal;
                                                  var CuotaRE       : Decimal );

var  PorcentajeIVA : Decimal;
     CodigoPaisIVA : String;

begin
     CuotaIVA := 0.0;
     CuotaRE := 0.0;
     If   not ( ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or ( Importe=0.0 ) )
     then begin
          If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
          then CodigoPaisIVA := ClienteFields.CodigoPais.Value
          else CodigoPaisIVA := CodigoEspaña;
          SessionDataModule.Dm10.TasaModule.TipoIVA( Fecha, CodigoPaisIVA, SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( Fecha, CodigoPaisIVA, rgTipoIVAPortes ), DsTiposIVAFields );
          CuotaIVA := Redondea( ( Importe * DsTiposIVAFields.IVARepercutido.Value ) / 100.0 );
          If   ClienteFields.Factura_ModeloIVA.Value=micConRE
          then CuotaRE := Redondea( ( Importe * DsTiposIVAFields.RERepercutido.Value ) / 100.0 );
          end;
end;

function TFacturaVentasModule.ProximoNroRegistroPresentacion( RegistrarValor   : Boolean = True ) : LongInt;

var  ValorActual : LongInt;
     RecordFound,
     ExisteContador : Boolean;

begin

     ValorActual := 0;

     With DmFacturaVentasAuxTable do
       begin
       IndexFieldnames := 'NroRegistroPresentacion';
       Last;
       RecordFound := DmFacturaVentasAuxFields.NroRegistroPresentacion.Value<>0;    // Podría utilizar tambien Found, pero esto es más seguro
       end;

     If   RecordFound
     then ValorActual := DmFacturaVentasAuxFields.NroRegistroPresentacion.Value + 1
     else ValorActual := 1;

     ValorActual := SessionDataModule.Dm00.ContadoresModule.ProximoValor( ComprobacionRegistroPresentacionEvent,
                                                                          cnNroRegistroPresentacion,
                                                                          0,
                                                                          '',
                                                                          ValorActual,
                                                                          1 );
     If   not RegistrarValor
     then SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnNroRegistroPresentacion, 0, '', ValorActual );

     SessionDataModule.Dm00.ContadoresModule.CompruebaValorMaximo( ValorActual );

     Result := ValorActual;

end;

function TFacturaVentasModule.ComprobacionRegistroPresentacionEvent( ValorActual : LongInt ) : Boolean;
begin
    Result := DmFacturaVentasAuxTable.FindKey( [ ValorActual ] );
end;

procedure TFacturaVentasModule.RetiraNroRegistroPresentacion( NroRegistroPresentacion : LongWord );
begin
     SessionDataModule.Dm00.ContadoresModule.RetiraValor( cnNroRegistroPresentacion, 0, '', NroRegistroPresentacion );
end;

function TFacturaVentasModule.GeneraFacturas( ParametrosFacturacion       : IParametrosFacturacion;
                                              RelacionAlbaranesTableName  : String = '' ) : IParametrosFacturacion;

var   NroFacturaAutomatico,
      Correct : Boolean;
      ImporteAlbaranes : Decimal;
      SerieActual : String;
      NroFacturaActual,
      NroFacturaAnterior : LongInt;
      NroRegistroRelacion : Integer;
      Bm : TBookMark;

      ImporteBruto,
      DescuentosArticulos,
      ImporteNeto,
      EntregasACuentaPedidos : Decimal;

      Canceled,
      ComprobarFormaCobro,
      PrimerAlbaran : Boolean;

      TipoComision,

      SumaCoste,
      SumaDtosArticulo,
      SumaDtosCliente,
      SumaBruto,
      SumaNeto,
      SumaIVAIncluido,
      SumaNetoRetencion,
      SumaComision,

      TotalAlbaran : Decimal;

      ExisteVendedorAlbaran : Boolean;

      CodigoActual,
      CodigoClienteActual,
      CodigoVendedorActual,
      CodigoGrupoClienteActual,
      CodigoRegAuxiliarActual : String;

      RelacionAlbaranesFields : TRelacionAlbaranesFields;

      FechaAplicacion,
      FechaAplicacionFacturacion : TDate;

      TasasArray : TTasasArray;

procedure CalculoLinea;

var  TiposIVAFields : TTiposIVAFields;

     CosteLinea,
     PuntoVerdeLinea : Decimal;

     ExistenciasArticulo : IExistenciasArticulo;

begin

     CosteLinea := 0.0;

     With DmLineaMovimientoFields do
       If   SessionDataModule.Dm30.ArticuloModule.Obten( CodigoArticulo.Value, DsArticuloFields )
       then begin
            ExistenciasArticulo := SessionDataModule.Dm30.StockAlmacenModule.ObtenStock( DsArticuloFields,
                                                                                         False,
                                                                                         CodigoClaseA.Value,
                                                                                         CodigoClaseB.Value,
                                                                                         CodigoClaseC.Value,
                                                                                         False,
                                                                                         LoteFabricacion.Value,
                                                                                         False,
                                                                                         CodigoAlmacen.Value,
                                                                                         False,
                                                                                         Ubicacion.Value,
                                                                                         True,
                                                                                         Ejercicio.Value,
                                                                                         0,
                                                                                         MonthOf( DmMovimientoFields.Fecha.Value ) );

            CosteLinea := ExistenciasArticulo.Coste * -( DmLineaMovimientoFields.Cantidad.Value );
            end
       else begin
            SessionDataModule.SendNotification( ntStop, Format( RsMsg14, [ CodigoArticulo.Value, DmMovimientoFields.NroDocumento.Value ] ) );
            Abort;
            end;

       With DmLineaMovimientoFields do
         begin

         // Comprobando si hay entregas a cuenta en el pedido origen

         If   ( TipoMovimientoOrigen.Value=tmPedidoVenta ) and ( NroOperacionOrigen.Value<>0 )
         then If   DmMovimientoAuxTable.FindKey( [ EjercicioOrigen.Value, NroOperacionOrigen.Value ] )
              then If   ( DmMovimientoAuxFields.TipoMovimiento.Value=tmPedidoVenta ) and   // Por si acaso
                        not DmMovimientoAuxFields.Facturado.Value                          // Solo si no ha sido previamente asignado a una factura podemos utilizar la cantidad entregada a cuenta
                   then begin
                        DecAdd( EntregasACuentaPedidos, DmMovimientoAuxFields.EntregaACuenta.Value );
                        try
                          DmMovimientoAuxTable.Edit;
                          DmMovimientoAuxFields.EjercicioFactura.Value := DmFacturaVentasFields.Ejercicio.Value;
                          DmMovimientoAuxFields.NroFactura.Value := DmFacturaVentasFields.NroFactura.Value;
                          DmMovimientoAuxFields.SerieFactura.Value := DmFacturaVentasFields.Serie.Value;
                          DmMovimientoAuxFields.PropietarioFactura.Value := DmFacturaVentasFields.CodigoCliente.Value;
                          DmMovimientoAuxFields.Facturado.Value := True;
                          DmMovimientoAuxTable.Post;
                        except
                          DmMovimientoAuxTable.Cancel;
                          raise;
                          end;
                        end;

         PuntoVerdeLinea := CantidadAjustada.Value * PuntoVerde.Value;

         DmFacturaVentasFields.ImportePuntoVerde.Value := DmFacturaVentasFields.ImportePuntoVerde.Value + PuntoVerdeLinea;
         DmFacturaVentasFields.ImporteContribucionRAP.Value := DmFacturaVentasFields.ImporteContribucionRAP.Value + DmLineaMovimientoFields.ContribucionRAP.Value;

         DecAdd( SumaCoste, CosteLinea );
         DecAdd( SumaDtosArticulo, ImporteDescuento.Value );
         DecAdd( SumaBruto, ImporteBruto.Value );
         DecAdd( SumaNeto, ImporteNeto.Value );
         DecAdd( SumaIVAIncluido, ImporteTotal.Value );

         If   not ValueIsEmpty( DmFacturaVentasFields.TipoRetencion.Value ) and not DsArticuloFields.NoAplicarRetencion.Value
         then DecAdd( SumaNetoRetencion, ImporteNeto.Value );

         DecAdd( TasasArray[ CodigoTipoIVA.Value ].BaseImponible, ImporteNeto.Value );
         DecAdd( TasasArray[ CodigoTipoIVA.Value ].BaseNoSujetaDto, PuntoVerdeLinea );
         DecAdd( TasasArray[ CodigoTipoIVA.Value ].BaseNoSujetaDto, DmLineaMovimientoFields.ContribucionRAP.Value );

         DecAdd( TotalAlbaran, ImporteNeto.Value );

         If   ExisteVendedorAlbaran
         then begin
              TipoComision := SessionDataModule.Dm30.VendedorModule.ObtenTipoComision( DmVendedorFields.Codigo.Value, DmClienteFields.Codigo.Value, DsArticuloFields );
              DecAdd( SumaComision, ( ( ImporteNeto.Value * TipoComision ) / 100.0 ) * DmVendedorFields.Comision.Value );   // El valor comision de la ficha del vendedor es en realidad el factor de comision
              end;

         end;
end;

begin

     ParametrosFacturacion.Correcto := False;
     Canceled := False;

     //* 16.06.2000 Antes que nada compruebo si la fecha de facturación es correcta
     //             (por si la fecha por defecto no pertenece al ejercicio activo)

     If   not SessionDataModule.IsValidYear( ParametrosFacturacion.FechaFacturacion )
     then begin
          SessionDataModule.SendNotification( ntStop, RsMsg22, RsMsg6 );
          Abort;
          end;

     try

       try

         ParametrosFacturacion.NroFacturaInicial := 0; // para el proceso de impresión únicamente

         FechaAplicacionFacturacion := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( ParametrosFacturacion.FechaFacturacion );

         RelacionAlbaranesTable.PreserveTemporalTableName := RelacionAlbaranesTableName<>'';
         If   RelacionAlbaranesTable.PreserveTemporalTableName
         then RelacionAlbaranesTable.TableName := RelacionAlbaranesTableName;

         RelacionAlbaranesTable.Open;

         RelacionAlbaranesFields := TRelacionAlbaranesFields.Create( RelacionAlbaranesTable );

         If   ParametrosFacturacion.TipoSeleccion<>tsRelacion
         then try

                RelacionAlbaranesTable.DeleteRecords( True );   // Por si acaso

                case ParametrosFacturacion.TipoSeleccion of
                    tsDocumento : begin
                                  DmMovimientoTable.IndexFieldNames := 'TipoMovimiento;Ejercicio;Serie;NroDocumento';
                                  DmMovimientoTable.SetRange( [ tmVenta, SessionDataModule.Ejercicio, ParametrosFacturacion.Serie, ParametrosFacturacion.NroDocumento ],
                                                              [ tmVenta, SessionDataModule.Ejercicio, ParametrosFacturacion.Serie, ParametrosFacturacion.NroDocumento ] );
                                  end;
                    else          begin
                                  DmMovimientoTable.IndexFieldNames := 'TipoMovimiento;Serie;Fecha;NroDocumento';
                                  DmMovimientoTable.SetRange( [ tmVenta, ParametrosFacturacion.Serie, ParametrosFacturacion.FechaInicial, 0 ],
                                                              [ tmVenta, ParametrosFacturacion.Serie, ParametrosFacturacion.FechaFinal, MaxLongint ] );
                                  Canceled := SessionDataModule.SendNotification( ntInformation, RsMsg17 );
                                  end;
                    end;

                NroRegistroRelacion := 1;

                DmMovimientoTable.First;
                While not DmMovimientoTable.Eof do
                  begin

                  If   not DmMovimientoFields.NoFacturar.Value and
                       not DmMovimientoFields.Facturado.Value
                  then begin

                       With ParametrosFacturacion do
                         Correct := ( ( SeleccionPropietario=0 ) or ( ( DmMovimientoFields.Propietario.Value>=PropietarioInicial ) and ( DmMovimientoFields.Propietario.Value<=PropietarioFinal ) ) ) and
                                    ( ( SeleccionGrupoPropietario=0 ) or ( ( DmMovimientoFields.GrupoFacturacion.Value>=GrupoPropietarioInicial ) and ( DmMovimientoFields.GrupoFacturacion.Value<=GrupoPropietarioFinal ) ) ) and
                                    ( ( SeleccionVendedor=0 )    or ( ( DmMovimientoFields.CodigoVendedor.Value>=VendedorInicial ) and ( DmMovimientoFields.CodigoVendedor.Value<=VendedorFinal ) ) ) and
                                    ( ( SeleccionFormaCobro=0 )  or ( ( DmMovimientoFields.CodigoFormaCobro.Value>=FormaCobroInicial ) and ( DmMovimientoFields.CodigoFormaCobro.Value<=FormaCobroFinal ) ) ) and
                                    ( ( SeleccionRegAuxiliar=0 ) or ( ( CodigoPropietario='' ) or ( DmMovimientoFields.Propietario.Value=CodigoPropietario ) ) and
                                                                     ( DmMovimientoFields.RegistroAuxiliar.Value>=RegAuxiliarInicial ) and ( DmMovimientoFields.RegistroAuxiliar.Value<=RegAuxiliarFinal ) );

                       If   Correct
                       then begin

                            RelacionAlbaranesTable.Append;

                            try

                              If   ParametrosFacturacion.SeleccionPropietario=2
                              then begin
                                   If   ParametrosFacturacion.DesglosarRegAuxilar
                                   then RelacionAlbaranesFields.Codigo.Value := DmMovimientoFields.RegistroAuxiliar.Value
                                   else RelacionAlbaranesFields.Codigo.Value := '';
                                   end
                              else If   ParametrosFacturacion.SeleccionGrupoPropietario=2
                                   then RelacionAlbaranesFields.Codigo.Value := DmMovimientoFields.GrupoFacturacion.Value
                                   else If   ParametrosFacturacion.SeleccionVendedor=2
                                        then RelacionAlbaranesFields.Codigo.Value := DmMovimientoFields.CodigoVendedor.Value
                                        else If   ParametrosFacturacion.SeleccionFormaCobro=2
                                             then RelacionAlbaranesFields.Codigo.Value := DmMovimientoFields.CodigoFormaCobro.Value
                                             else If   ParametrosFacturacion.SeleccionRegAuxiliar=2
                                                  then RelacionAlbaranesFields.Codigo.Value := DmMovimientoFields.RegistroAuxiliar.Value;

                              RelacionAlbaranesFields.NroRegistro.Value := NroRegistroRelacion;
                              RelacionAlbaranesFields.Ejercicio.Value := DmMovimientoFields.Ejercicio.Value;
                              RelacionAlbaranesFields.Propietario.Value := DmMovimientoFields.Propietario.Value;
                              RelacionAlbaranesFields.Fecha.Value := DmMovimientoFields.Fecha.Value;
                              RelacionAlbaranesFields.NroDocumento.Value := DmMovimientoFields.NroDocumento.Value;
                              RelacionAlbaranesFields.NroOperacion.Value := DmMovimientoFields.NroOperacion.Value;

                              RelacionAlbaranesTable.Post;

                            except
                              RelacionAlbaranesTable.Cancel;
                              raise;
                              end;

                            Inc( NroRegistroRelacion );

                            Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg35, [ DmMovimientoFields.NroDocumento.Value ] ) );

                            end;

                       end;

                  If   Canceled
                  then Abort;

                  DmMovimientoTable.Next;
                  end;

              finally
                DmMovimientoTable.CancelRange;
                end;

         If   ParametrosFacturacion.TipoSeleccion<>tsDocumento
         then SessionDataModule.SendNotification( ntInformation, RsMsg18 );

         DmMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion';

         // Cuando el usuario tiene activada la preventa o la autoventa, el orden de los albaranes es el del número del documento

         If   ParametrosFacturacion.UnaFacturaPorAlbaran and ( SessionDataModule.EmpresaFields.Ventas_PreAutoVenta.Value<>0 )
         then RelacionAlbaranesTable.IndexFieldNames := 'Fecha;Serie;NroDocumento'
         else RelacionAlbaranesTable.IndexFieldNames := 'Codigo;Propietario;Fecha;Serie;NroDocumento';

         RelacionAlbaranesTable.CancelRange;
         RelacionAlbaranesTable.First;
         While not RelacionAlbaranesTable.Eof do
           begin

           If   DmMovimientoTable.FindKey( [ RelacionAlbaranesFields.Ejercicio.Value, RelacionAlbaranesFields.NroOperacion.Value ] )
           then begin

                Correct := True;

                CodigoActual := RelacionAlbaranesFields.Codigo.Value;
                CodigoClienteActual := RelacionAlbaranesFields.Propietario.Value;

                If   DmClienteTable.FindKey( [ DmMovimientoFields.Propietario.Value ] )
                then begin

                     CalcularIVA := DmClienteFields.Factura_ModeloIVA.Value<>micExento;
                     If   SessionDataModule.Dm10.SerieFacturacionModule.Obten( ParametrosFacturacion.Serie, DsSerieFacturacionFields )
                     then CalcularIVA := CalcularIVA and not DsSerieFacturacionFields.ExentoIVA.Value;

                     If   ParametrosFacturacion.ImporteMinimo>0.0
                     then begin
                          Bm := RelacionAlbaranesTable.GetBookMark;
                          try
                            PrimerAlbaran := True;
                            ImporteAlbaranes := 0.0;
                            While not RelacionAlbaranesTable.Eof and
                                  not ( ParametrosFacturacion.UnaFacturaPorAlbaran and not PrimerAlbaran ) and
                                  ( CodigoClienteActual=RelacionAlbaranesFields.Propietario.Value ) and
                                  ( CodigoActual=RelacionAlbaranesFields.Codigo.Value ) do
                              begin
                              SessionDataModule.Dm30.MovimientoModule.ObtenImporteMovimiento( RelacionAlbaranesFields.Ejercicio.Value,
                                                                                              RelacionAlbaranesFields.NroOperacion.Value,
                                                                                              ImporteBruto,
                                                                                              DescuentosArticulos,
                                                                                              ImporteNeto );

                              ImporteAlbaranes := ImporteAlbaranes + ImporteNeto;
                              PrimerAlbaran := False;
                              RelacionAlbaranesTable.Next;
                              end;
                          finally
                            RelacionAlbaranesTable.GotoBookMark( Bm );
                            RelacionAlbaranesTable.FreeBookMark( Bm );
                            end;

                          Correct := ParametrosFacturacion.ImporteMinimo<=ImporteAlbaranes;
                          end;

                     end
                else begin
                     SessionDataModule.SendNotification( ntStop, Format( RsMsg2, [ DmMovimientoFields.Propietario.Value, DmMovimientoFields.NroDocumento.Value ] ), '' );
                     Correct := False;
                     end;

                If   Correct
                then begin

                     var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable,
                                                                                     DmClienteDatEconTable,
                                                                                     DmFacturaTable,
                                                                                     DmFacturaVentasTable ],

                                                                                     False );   // Sin notificaciones

                     try


                       { Cuando los contadores están incorrectamente asignados puede generarse un nº de factura duplicado.
                         Para prevenir esa situación compruebo siempre que no exista la factura y, si es el caso,
                         reajusto los contadores y aviso al usuario del problema ... }

                       NroFacturaAutomatico := ParametrosFacturacion.PrimerNroFactura=0;

                       If   NroFacturaAutomatico
                       then ParametrosFacturacion.PrimerNroFactura := ProximoNroFactura( ParametrosFacturacion.Serie );

                       DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';

                       If   DmFacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, ParametrosFacturacion.Serie, ParametrosFacturacion.PrimerNroFactura ] )
                       then begin
                            NroFacturaAnterior := ParametrosFacturacion.PrimerNroFactura;
                            ParametrosFacturacion.PrimerNroFactura := ProximoNroFactura( ParametrosFacturacion.Serie, NroFacturaAutomatico );
                            SessionDataModule.SendNotification( ntStop, RsMsg3, Format( RsMsg4, [ NroFacturaAnterior, ParametrosFacturacion.PrimerNroFactura ] ) );
                            end;

                       DmFacturaVentasTable.Append;

                       try

                         EntregasACuentaPedidos := 0.0;

                         DmFacturaVentasFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                         DmFacturaVentasFields.Serie.Value := ParametrosFacturacion.Serie;
                         DmFacturaVentasFields.NroFactura.Value := ParametrosFacturacion.PrimerNroFactura;
                         ParametrosFacturacion.PrimerNroFactura := ParametrosFacturacion.PrimerNroFactura + 1;

                         SerieActual := DmFacturaVentasFields.Serie.Value;
                         NroFacturaActual := DmFacturaVentasFields.NroFactura.Value;

                         DmFacturaVentasFields.Fecha.Value := ParametrosFacturacion.FechaFacturacion;
                         DmFacturaVentasFields.FechaValor.Value := ParametrosFacturacion.FechaFacturacion;
                         DmFacturaVentasFields.CodigoCliente.Value := DmMovimientoFields.Propietario.Value;
                         DmFacturaVentasFields.DescuentoES.Value := DmClienteFields.Factura_DtoES.Value;

                         If   SessionDataModule.EmpresaFields.Contable_Retenciones.Value
                         then DmFacturaVentasFields.TipoRetencion.Value := DmClienteFields.Factura_TipoRet.Value;

                         If   not SessionDataModule.EmpresaFields.Ventas_PagosPedido.Value or ( DmMovimientoFields.CodigoFormaCobro.Value='' )
                         then begin
                              DmFacturaVentasFields.CodigoFormaCobro.Value := DmClienteFields.Cobro_FormaCobro.Value;
                              ComprobarFormaCobro := False;
                              end
                         else begin
                              DmFacturaVentasFields.CodigoFormaCobro.Value := DmMovimientoFields.CodigoFormaCobro.Value;
                              ComprobarFormaCobro := True;
                              end;

                         SumaCoste := 0.0;
                         SumaBruto := 0.0;
                         SumaNeto := 0.0;
                         SumaNetoRetencion := 0.0;
                         SumaDtosArticulo := 0.0;
                         SumaDtosCliente := 0.0;
                         SumaIVAIncluido := 0.0;
                         SumaComision := 0.0;

                         CodigoVendedorActual := '';
                         CodigoGrupoClienteActual := '';
                         PrimerAlbaran := True;

                         FillChar( TasasArray, SizeOf( TasasArray ), #0 );

                         While not RelacionAlbaranesTable.Eof and
                               not ( ParametrosFacturacion.UnaFacturaPorAlbaran and not PrimerAlbaran ) and
                               ( CodigoClienteActual=RelacionAlbaranesFields.Propietario.Value ) and
                               ( CodigoActual=RelacionAlbaranesFields.Codigo.Value ) do
                           begin

                           DmMovimientoTable.Cancel;

                           If   DmMovimientoTable.FindKey( [ RelacionAlbaranesFields.Ejercicio.Value, RelacionAlbaranesFields.NroOperacion.Value ] )
                           then begin

                                // Comprobando que el usuario no mezcle documentos de periodos impositivos distintos en la facturación

                                FechaAplicacion := SessionDataModule.Dm10.TasaModule.UltimaFechaAplicacion( DmMovimientoFields.Fecha.Value );
                                If   FechaAplicacionFacturacion<>FechaAplicacion
                                then With DmMovimientoFields do
                                       begin
                                       SessionDataModule.SendNotification( ntStop, RsMsg42, Format( RsMsg43, [ Serie.Value, NroDocumento.Value ] ) );
                                       Abort;
                                       end;

                                Canceled := SessionDataModule.SendNotification( ntRecord, Format( RsMsg19, [ DmFacturaVentasFields.NroFactura.Value, DmMovimientoFields.NroDocumento.Value ] ) );

                                DmFacturaVentasFields.TotalACuenta.Value := DmFacturaVentasFields.TotalACuenta.Value + DmMovimientoFields.EntregaACuenta.Value;
                                DmFacturaVentasFields.Portes.Value := DmFacturaVentasFields.Portes.Value + DmMovimientoFields.Portes.Value;

                                TotalAlbaran := 0.0;

                                If   ComprobarFormaCobro
                                then If   DmFacturaVentasFields.CodigoFormaCobro.Value<>DmMovimientoFields.CodigoFormaCobro.Value
                                     then begin
                                          DmFacturaVentasFields.CodigoFormaCobro.Value := DmClienteFields.Cobro_FormaCobro.Value;
                                          ComprobarFormaCobro := False;
                                          end;

                                If   PrimerAlbaran
                                then begin
                                     CodigoVendedorActual := DmMovimientoFields.CodigoVendedor.Value;
                                     CodigoGrupoClienteActual  := DmMovimientoFields.GrupoFacturacion.Value;
                                     CodigoRegAuxiliarActual := DmMovimientoFields.RegistroAuxiliar.Value;
                                     PrimerAlbaran := False;
                                     end
                                else begin
                                     If   CodigoVendedorActual<>''
                                     then If   DmMovimientoFields.CodigoVendedor.Value<>CodigoVendedorActual
                                          then CodigoVendedorActual := '';
                                     If   CodigoGrupoClienteActual<>''
                                     then If   DmMovimientoFields.GrupoFacturacion.Value<>CodigoGrupoClienteActual
                                          then CodigoGrupoClienteActual := '';
                                     If   CodigoRegAuxiliarActual<>''
                                     then If   DmMovimientoFields.RegistroAuxiliar.Value<>CodigoRegAuxiliarActual
                                          then CodigoRegAuxiliarActual := '';
                                     end;

                                If   DmFacturaVentasFields.OrganismoPublico.Value=''
                                then DmFacturaVentasFields.OrganismoPublico.Value := DmMovimientoFields.OrganismoPublico.Value;

                                If   not SessionDataModule.EmpresaFields.Vendedor_ComPorCli.Value and ( DmMovimientoFields.CodigoVendedor.Value<>'' )
                                then ExisteVendedorAlbaran := DmVendedorTable.FindKey( [ DmMovimientoFields.CodigoVendedor.Value ] )
                                else ExisteVendedorAlbaran := False;

                                try
                                  DmLineaMovimientoTable.Cancel;
                                  DmLineaMovimientoTable.IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                                  With DmMovimientoFields do
                                    DmLineaMovimientoTable.SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );
                                  DmLineaMovimientoTable.First;
                                  While not DmLineaMovimientoTable.Eof do
                                    begin
                                    CalculoLinea;
                                    DmLineaMovimientoTable.Next;
                                    end;
                                finally
                                  DmLineaMovimientoTable.CancelRange;
                                  end;

                                try
                                  DmMovimientoTable.Edit;

                                  With DmMovimientoFields do
                                    begin
                                    NoFacturar.Value := False;
                                    Facturado.Value := True;
                                    EjercicioFactura.Value := DmFacturaVentasFields.Ejercicio.Value;
                                    SerieFactura.Value := DmFacturaVentasFields.Serie.Value;
                                    NroFactura.Value := DmFacturaVentasFields.NroFactura.Value;
                                    PropietarioFactura.Value := DmFacturaVentasFields.CodigoCliente.Value;
                                    end;

                                  DmMovimientoTable.Post;

                                except
                                  DmMovimientoTable.Cancel;
                                  raise;
                                  end;

                                end;

                           If   Canceled
                           then Abort;

                           RelacionAlbaranesTable.Next;
                           end;

                         DmFacturaVentasFields.TotalACuenta.Value := DmFacturaVentasFields.TotalACuenta.Value + EntregasACuentaPedidos;  // Añadiendo las entregas a cuenta de pedidos
                         DmFacturaVentasFields.NetoFacturaRetencion.Value := Redondea( SumaNetoRetencion );

                         AplicaCondicionesCobro( DmFacturaVentasFields );

                         // Si la función RecalculaFactura devuelve false es porque no hay nada que facturar (no existe ninguna base imponible)

                         If   RecalculaFactura( DmFacturaVentasFields, { RecuperaCliente } False, TasasArray )
                         then begin

                              DmFacturaVentasFields.CosteArticulos.Value := SumaCoste;
                              DmFacturaVentasFields.BrutoArticulos.Value := Redondea( SumaBruto );
                              DmFacturaVentasFields.DescuentosArticulos.Value := Redondea( SumaDtosArticulo );

                              If   SessionDataModule.EmpresaFields.Vendedor_ComPorCli.Value
                              then begin
                                   DmFacturaVentasFields.CodigoVendedor.Value := DmClienteFields.Vendedor.Value;
                                   DmFacturaVentasFields.TipoComision.Value := DmClienteFields.Factura_Comision.Value;
                                   SumaComision := ( ( DmFacturaVentasFields.NetoFactura.Value - DmFacturaVentasFields.DescuentosClientes.Value ) *
                                                       DmClienteFields.Factura_Comision.Value ) / 100.0;
                                   end
                              else If   CodigoVendedorActual<>''
                                   then DmFacturaVentasFields.CodigoVendedor.Value := CodigoVendedorActual;

                              If   not ValueIsEmpty( DmFacturaVentasFields.CodigoVendedor.Value )
                              then DmFacturaVentasFields.Comision.Value := Redondea( SumaComision );

                              If   CodigoGrupoClienteActual=''
                              then DmFacturaVentasFields.GrupoFacturacion.Value := DmClienteFields.Factura_Agrupacion.Value
                              else DmFacturaVentasFields.GrupoFacturacion.Value := CodigoGrupoClienteActual;

                              If   ParametrosFacturacion.DesglosarRegAuxilar or ( ParametrosFacturacion.SeleccionRegAuxiliar=2 )
                              then DmFacturaVentasFields.RegistroAuxiliar.Value := CodigoActual
                              else DmFacturaVentasFields.RegistroAuxiliar.Value := CodigoRegAuxiliarActual;

                              If   ParametrosFacturacion.NroFacturaInicial=0
                              then ParametrosFacturacion.NroFacturaInicial := DmFacturaVentasFields.NroFactura.Value;

                              ParametrosFacturacion.NroFacturaFinal := DmFacturaVentasFields.NroFactura.Value;

                              If   Assigned( FOnGeneraFactura )
                              then FOnGeneraFactura;

                              With DmClienteDatEconTable do
                                If   FindKey( [ DmFacturaVentasFields.Ejercicio.Value, DmFacturaVentasFields.CodigoCliente.Value ] )
                                then try
                                       Edit;
                                       DmClienteDatEconFields.Pendiente.Value := DmClienteDatEconFields.Pendiente.Value - DmFacturaVentasFields.NetoFactura.Value;
                                       Post;
                                     except
                                       Cancel;
                                       raise;
                                       end;

                              // Creando el registro de la factura con los datos fiscales

                              With DmFacturaVentasFields do
                                try

                                  If   DmFacturaTable.FindKey( [ tfFacturaVentas, Ejercicio.Value, '', Serie.Value, NroFactura.Value ] )
                                  then DmFacturaTable.Edit
                                  else begin
                                       DmFacturaTable.Append;

                                       DmFacturaFields.Tipo.Value := tfFacturaVentas;
                                       DmFacturaFields.Ejercicio.Value := Ejercicio.Value;
                                       DmFacturaFields.Propietario.Value := '';
                                       DmFacturaFields.SerieFactura.Value := Serie.Value;
                                       DmFacturaFields.NroRegistro.Value := NroFactura.Value;

                                       end;

                                  SessionDataModule.Dm10.FacturaModule.CompletaRegistroFacturaExpedida( DmClienteFields.CodigoProvincia.Value,
                                                                                                        DmClienteFields.CodigoPais.Value,
                                                                                                        { Rectificativa } DsSerieFacturacionFields.FacturasRectificativas.Value,
                                                                                                        { Simplificada } DmClienteFields.NIF.Value='',
                                                                                                        { VentasOnline } False,
                                                                                                        DmFacturaFields );

                                  DmFacturaTable.Post;

                                except
                                  DmFacturaTable.Cancel;
                                  raise;
                                  end;

                              //

                              DmFacturaVentasTable.Post;

                              end
                         else begin
                              With DmFacturaVentasFields do
                                SessionDataModule.SendNotification( ntWarning, Format( RsMsg57, [ Serie.Value, NroFactura.Value, CodigoCliente.Value, DmClienteFields.Nombre.Value ] ), RsMsg58 );
                              Abort;
                              end;

                       except
                         DmFacturaVentasTable.Cancel;
                         raise;
                         end;

                       RetiraNroFactura( SerieActual, NroFacturaActual );  // Fuerzo la retirada del valor, independientemente del estado de la tabla

                       TransactionTag.Commit;

                       If   not Canceled
                       then With DmFacturaVentasFields do
                              Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg50, [ Serie.Value, NroFactura.Value, CodigoCliente.Value, DmClienteFields.Nombre.Value ] ) );

                       If   Canceled  // Cancelo todo el proceso de facturación para evitar que se queden albaranes marcados incorrectamente como facturados
                       then Abort;

                     except
                       RetiraNroFactura( SerieActual, NroFacturaActual );
                       TransactionTag.Rollback;                             // Los ficheros globales no están incuidos en las transacciones de usuario
                       DmFacturaVentasTable.Cancel;
                       raise;
                       end;

                     end
                else If   not RelacionAlbaranesTable.Eof and ParametrosFacturacion.UnaFacturaPorAlbaran
                     then RelacionAlbaranesTable.Next
                     else While not RelacionAlbaranesTable.Eof and
                                ( CodigoClienteActual=RelacionAlbaranesFields.Propietario.Value ) and
                                ( CodigoActual=RelacionAlbaranesFields.Codigo.Value ) do
                            RelacionAlbaranesTable.Next;

                end
           else begin
                SessionDataModule.SendNotification( ntStop, Format( RsMsg5, [ RelacionAlbaranesFields.NroDocumento.Value ] ), '' );
                Abort;
                end;

           end;

         ParametrosFacturacion.Correcto := True;

     except on E : Exception do
       begin
       SessionDataModule.SendException( E );
       SessionDataModule.SendNotification( ntStop, RsMsg6, RsMsg7 );
       end;
     end;

     finally
       RelacionAlbaranesTable.Close;
       Result := ParametrosFacturacion;
       end;

end;

procedure TFacturaVentasModule.CompruebaSupresion( FacturaVentasFields : TFacturaVentasFields );
begin
     If   not FacturaVentasFields.Huella.IsNull
     then begin
          SessionDataModule.SendNotification( ntStop, Format( RsMsg56, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ), '' );
          Abort;
          end;
end;

procedure TFacturaVentasModule.SuprimeFactura( Serie      : String;
                                               NroFactura : LongInt );
begin
     DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
     If   DmFacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, Serie, NroFactura ] )
     then begin

          // No permito suprimir facturas presentadas a Veri*factu

          If   FacturaPresentada( DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value )
          then begin
               SessionDataModule.SendNotification( ntStop, Format( RsMsg56, [ DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value ] ), '' );
               Abort;
               end;

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmFacturaVentasTable ] );
          try
            DmFacturaVentasTable.Edit;  // Veamos si está libre
            SuprimeRelaciones( DmFacturaVentasFields );
            DmFacturaVentasTable.Delete;
            TransactionTag.Commit;
          except on E : Exception do
            begin
            DmFacturaVentasTable.Cancel;
            TransactionTag.Rollback;
            SessionDataModule.SendException( E );
            Abort;
            end;
          end;

          end
     else RaiseRecordNotFoundException;

end;

{
procedure TFacturaVentasModule.AnulaFactura( Serie      : String;
                                             NroFactura : LongInt );

var EstadoPresentacion : TEstadoPresentacionVerifactu;
    Estadoregistro     : TEstadoregistroVerifactu;

begin

     DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
     If   DmFacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, Serie, NroFactura ] )
     then begin

          // Solo se pueden anular las facturas presentadas y anuladas

          SessionDataModule.Dm10.RegistroPresentacionModule.ObtenEstadoPresentacionVerifactu( DmFacturaVentasFields.Serie.Value,
                                                                                              DmFacturaVentasFields.NroFactura.Value,
                                                                                              EstadoPresentacion,
                                                                                              EstadoRegistro );

          If   EstadoPresentacion<>epvAnulado
          then begin
               SessionDataModule.SendNotification( ntStop, Format( RsMsg59, [ DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value ] ), '' );
               Abort;
               end;

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmFacturaVentasTable ] );

          try

            With DmFacturaVentasFields do
              RecuperaFacturas( Serie.Value, NroFactura.Value, NroFactura.Value );

            // Solo por si acaso se ha perdido el posicionamiento (en realidad es poco probable, porque RecuperaFacturas utiliza la misma tabla e índice, pero vale )

            DmFacturaVentasTable.FindKey( [ SessionDataModule.Ejercicio, Serie, NroFactura ] );

            DmFacturaVentasTable.Edit;  // Veamos si está libre
            DmFacturaVentasFields.Anulada.Value := True;
            DmFacturaVentasTable.Post;

            With DmMovimientoTable do
              begin
              IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

              With DmFacturaVentasFields do
                SetRange( [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );

              First;
              While not Eof do
                begin

                // Recupero las existencias y retiro las cantidades pendientes de facturar del cliente

                SessionDataModule.Dm30.MovimientoModule.AnulaLineasMovimiento( DMMovimientoFields );

                Edit;
                DmMovimientoFields.Anulado.Value := True;
                Post;

                Next;
                end;

              end;

            TransactionTag.Commit;
          except on E : Exception do
            begin
            DmFacturaVentasTable.Cancel;
            TransactionTag.Rollback;
            SessionDataModule.SendException( E );
            Abort;
            end;
          end;

          end
     else RaiseRecordNotFoundException;

end;
}

procedure TFacturaVentasModule.SuprimeRelaciones( FacturaVentas          : IFacturaVentas;
                                                  SuprimeRegistroFactura : Boolean = True );
begin
     DsFacturaVentasFields.Setup( DmFacturaVentasTable, True );
     try
       FacturaVentas.ToDataset( DsFacturaVentasFields );
       SuprimeRelaciones( DsFacturaVentasFields, SuprimeRegistroFactura );
     finally
       DsFacturaVentasFields.DatasetCancel;
       end;
end;

procedure TFacturaVentasModule.SuprimeRelaciones( FacturaVentasFields    : TFacturaVentasFields;
                                                  SuprimeRegistroFactura : Boolean = True );

var  SQLText : String;

begin

     With FacturaVentasFields do
       begin

       var TransactionTag := SessionDataModule.StartTransactionWith( [ DmMovimientoTable ] );

       try

         SessionDataModule.Dm30.RelacionesClienteModule.ActualizaPendiente( Ejercicio.Value, CodigoCliente.Value, NetoFactura.Value );
         SessionDataModule.Dm30.EfectoModule.SuprimeEfectos( scVentas, CodigoCliente.Value, Serie.Value, NroFactura.Value );

         // Se incluyen los pedidos en las relaciones porque se marcan cuando se factura para evitar repetir las anotaciones
         // de las entregas a cuenta (y futuras relaciones)

         {  Sustituido por el método directo anterior porque la sentencia SQL ralentizaba mucho el proceso ...

         SQLText := 'UPDATE Movimiento ' +
                    'SET    EjercicioFactura = NULL, ' +
                    '       PropietarioFactura = NULL, ' +
                    '       SerieFactura = NULL, ' +
                    '       NroFactura = NULL, ' +
                    '       Facturado = NULL ' +
                    'WHERE  TipoMovimiento IN ( 14, 15 ) AND ' + // tmPedidoVenta, tmVenta
                    '       EjercicioFactura = ? AND ' +
                    '       PropietarioFactura = ? AND ' +
                    '       SerieFactura = ? AND ' +
                    '       NroFactura = ?';

         SQLText := SQLFieldsFormat( SQLText, [ Ejercicio, CodigoCliente, Serie, NroFactura ] );

         EnterpriseDataModule.ExecQuery( SQLText, [], True );
         }

         With DmMovimientoTable do
           begin

           IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';

           try

             SetRange( [ tmPedidoVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ],
                       [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );

             First;
             While not Eof do
               begin

               If   IsRecordLocked<>lpNotAtAll
               then begin
                    SessionDataModule.SendNotification( ntWarning, Format( RsMsg51, [ ObtenTextoTipoMovimiento( DmMovimientoFields.TipoMovimiento.Value, False ), DmMovimientoFields.Serie.Value, DmMovimientoFields.NroDocumento.Value ] ), RsMsg52 );
                    Abort;
                    end;

               try

                 Edit;

                 With DmMovimientoFields do
                   begin
                   EjercicioFactura.Clear;
                   PropietarioFactura.Clear;
                   SerieFactura.Clear;
                   NroFactura.Clear;
                   Facturado.Clear;
                   end;

                 Post;

               except
                 Cancel;
                 raise;
                 end;

               end;

           finally
             CancelRange;
             IndexFieldNames := 'Ejercicio;NroOperacion';
             end;

           end;

         If   SuprimeRegistroFactura
         then SessionDataModule.Dm10.FacturaModule.SuprimeRegistroComercialFactura( tfFacturaVentas, '', Serie.Value, NroFactura.Value );

         If   Assigned( FOnSuprimeRelacionesFactura )
         then FOnSuprimeRelacionesFactura( FacturaVentasFields );

         TransactionTag.Commit;

       except on E : Exception do
         begin
         TransactionTag.Rollback;
         SessionDataModule.SendNotification( ntStop, Format( RsMsg34, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
         raise;
         end;
       end;

       end;
end;

procedure TFacturaVentasModule.ActualizaDatosEconomicos( SerieFacturacionFields : TSerieFacturacionFields;
                                                         FacturaVentasFields    : TFacturaVentasFields;
                                                         OnInsertLine           : TInsertLineEvent;
                                                         Sustraer               : Boolean;
                                                         ActualizarConsumos     : Boolean );

var  NroMes : SmallInt;
     SumaNeto,
     SumaDtosArticulo,
     TipoComision : Decimal;
     CodigoPaisIVA : String;

begin

     CalcularIVA := True;
     ContabilizarPorCliente := False;
     NroMes := MonthOf( FacturaVentasFields.Fecha.Value );

     If   not DmClienteTable.FindKey( [ FacturaVentasFields.CodigoCliente.Value ] )
     then begin
          SessionDataModule.SendNotification( ntStop, Format( RsMsg13, [ FacturaVentasFields.CodigoCliente.Value, FacturaVentasFields.NroFactura.Value ] ), '' );
          Abort;
          end
     else begin

          var TransactionTag := SessionDataModule.StartTransactionWith( [ DmClienteDatEconTable,
                                                                          DmVendedorDatEconTable,
                                                                          DmArticuloDatEconTable,
                                                                          DmMovimientoTable ] );

          try

            CalcularIVA := not ( ( DmClienteFields.Factura_ModeloIVA.Value=micExento ) or ( SerieFacturacionFields.ExentoIVA.Value ) );
            CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DmClienteFields );

            If   DmClienteFields.Factura_ModeloIVA.Value=micTipoFijo
            then TipoIVADefectoManual := DmClienteFields.Factura_TipoFijoIVA.Value
            else TipoIVADefectoManual := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( FacturaVentasFields.Fecha.Value, CodigoPaisIVA, rgTipoIVAManual );

            //* 07.11.2000 He ajustado la condicion para que ContabilizarPorCliente sea válido aunque
            //             solo exista una relacion definida

            If   FacturaVentasFields.GrupoFacturacion.Value<>''
            then If   DmGrupoClienteTable.FindKey( [ FacturaVentasFields.GrupoFacturacion.Value ] )
                 then ContabilizarPorCliente := ( DmGrupoClienteFields.CtaVentas.Value<>'' ) or ( DmGrupoClienteFields.CtaDevVentas.Value<>'' );

            With DmClienteDatEconTable do
              begin

              If   not FindKey( [ FacturaVentasFields.Ejercicio, FacturaVentasFields.CodigoCliente.Value ] )
              then SessionDataModule.Dm30.RelacionesClienteModule.AltaDatosEconomicos( FacturaVentasFields.Ejercicio.Value, FacturaVentasFields.CodigoCliente.Value, DmClienteDatEconTable );

              try

                Edit;

                With DmClienteDatEconFields do
                  begin
                  If   FechaUltFactura.Value<FacturaVentasFields.Fecha.Value
                  then FechaUltFactura.Value := FacturaVentasFields.Fecha.Value;
                  Descuentos[ NroMes ].Value := Descuentos[ NroMes ].Value + DecSign( FacturaVentasFields.DescuentosClientes.Value, not Sustraer );
                  Coste[ NroMes ].Value := Coste[ NroMes ].Value + DecSign( FacturaVentasFields.CosteArticulos.Value, not Sustraer );
                  Ventas[ NroMes ].Value := Ventas[ NroMes ].Value + DecSign( FacturaVentasFields.NetoFactura.Value,  not Sustraer );
                  end;

                Post;

              except
                Cancel;
                raise;
                end;

              end;

            If   SessionDataModule.EmpresaFields.Vendedor_ComPorCli.Value and not ValueIsEmpty( FacturaVentasFields.CodigoVendedor.Value )
            then With DmVendedorDatEconTable do
                   begin

                   If   not FindKey( [ FacturaVentasFields.Ejercicio, FacturaVentasFields.CodigoVendedor.Value ] )
                   then SessionDataModule.Dm30.VendedorModule.AltaDatosEconomicos( FacturaVentasFields.Ejercicio.Value, FacturaVentasFields.CodigoVendedor.Value, DmVendedorDatEconTable );

                   try

                     Edit;

                     With DmVendedorDatEconFields do
                       begin
                       Ventas[ NroMes ].Value := Ventas[ NroMes ].Value + DecSign( FacturaVentasFields.NetoFactura.Value - FacturaVentasFields.DescuentosClientes.Value, not Sustraer );
                       Comision[ NroMes ].Value := Comision[ NroMes ].Value + DecSign( FacturaVentasFields.Comision.Value, not Sustraer );
                       end;

                     Post;

                   except
                     Cancel;
                     raise;
                     end;

                   end;

            With DmMovimientoTable do
              try
                IndexFieldNames := 'TipoMovimiento;EjercicioFactura;PropietarioFactura;SerieFactura;NroFactura';
                With FacturaVentasFields do
                  SetRange( [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ],
                            [ tmVenta, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value ] );
                First;
                While not Eof do
                  begin

                  If   Cycle.Filled  // No es necesario inicializarlo explícitamente. Utiliza el valor por defecto de 1 cada 30 veces.
                  then SessionDataModule.SendNotification( ntRecord, Format( RsMsg8, [ FacturaVentasFields.NroFactura.Value, DmMovimientoFields.NroDocumento.Value ] ) );

                  NroMes := MonthOf( DmMovimientoFields.Fecha.Value );
                  SumaNeto := 0.0;
                  SumaDtosArticulo := 0.0;

                  With DmLineaMovimientoTable do
                    try
                      IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                      With DmMovimientoFields do
                        SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );
                      First;
                      If   Eof
                      then begin
                           SessionDataModule.SendNotification( ntStop, Format( RsMsg20, [ DmMovimientoFields.Serie.Value, DmMovimientoFields.NroDocumento.Value ] ), RsMsg21 );
                           Abort;
                           end;

                      While not Eof do
                        begin

                        If   not SessionDataModule.Dm30.ArticuloModule.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DsArticuloFields )
                        then If   DmLineaMovimientoFields.CodigoArticulo.Value<>ArticuloManual
                             then SessionDataModule.SendNotification( ntWarning, Format( RsMsg14, [ DmLineaMovimientoFields.CodigoArticulo.Value, DmMovimientoFields.NroDocumento.Value ] ), RsMsg15 );

                        DecAdd( SumaNeto, DmLineaMovimientoFields.ImporteNeto.Value );
                        DecAdd( SumaDtosArticulo, DmLineaMovimientoFields.ImporteDescuento.Value );

                        If   DmLineaMovimientoFields.CantidadAjustada.Value<>0.0
                        then begin

                             With DmLineaMovimientoFields do
                               If   not DmArticuloDatEconTable.FindKey( [ Ejercicio.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, CodigoAlmacen.Value ] )
                               then SessionDataModule.Dm30.ArticuloModule.AltaDatosEconomicos( Ejercicio.Value, CodigoArticulo.Value, CodigoClaseA.Value, CodigoClaseB.Value, CodigoClaseC.Value, CodigoAlmacen.Value, DmArticuloDatEconTable );

                             try

                               DmArticuloDatEconTable.Edit;

                               With DmArticuloDatEconFields do
                                 begin
                                 UnidadesVentas[ NroMes ].Value := UnidadesVentas[ NroMes ].Value + DecSign( DmLineaMovimientoFields.CantidadAjustada.Value, not Sustraer );
                                 ImporteVentas[ NroMes ].Value := ImporteVentas[ NroMes ].Value + DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer );
                                 ImporteDescuentosVentas[ NroMes ].Value := ImporteDescuentosVentas[ NroMes ].Value + DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer );
                                 end;

                               DmArticuloDatEconTable.Post;

                             except
                               DmArticuloDatEconTable.Cancel;
                               raise;
                               end;

                             If   not SessionDataModule.EmpresaFields.Vendedor_ComPorCli.Value and not ValueIsEmpty( DmMovimientoFields.CodigoVendedor.Value )
                             then If   DmVendedorTable.FindKey( [ DmMovimientoFields.CodigoVendedor.Value ] )
                                  then With DmVendedorDatEconTable do
                                         begin

                                         With DmMovimientoFields do
                                           begin

                                           If   not FindKey( [ Ejercicio.Value, CodigoVendedor.Value ] )
                                           then SessionDataModule.Dm30.VendedorModule.AltaDatosEconomicos( Ejercicio.Value, CodigoVendedor.Value, DmVendedorDatEconTable );

                                           TipoComision := SessionDataModule.Dm30.VendedorModule.ObtenTipoComision( CodigoVendedor.Value, Propietario.Value, DsArticuloFields );
                                           end;

                                         try

                                           Edit;

                                           With DmVendedorDatEconFields do
                                             begin
                                             Ventas[ NroMes ].Value := Ventas[ NroMes ].Value + DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer );
                                             Comision[ NroMes ].Value := Comision[ NroMes ].Value + DecSign( ( ( DmLineaMovimientoFields.ImporteNeto.Value * TipoComision ) / 100 ) * DmVendedorFields.Comision.Value, not Sustraer );
                                             end;

                                           Post;

                                         except
                                           Cancel;
                                           raise;
                                           end;

                                         end;

                             If   ActualizarConsumos
                             then begin
                                  SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoVentas( tcArticulo,
                                                                                                    FacturaVentasFields.CodigoCliente.Value,
                                                                                                    DmLineaMovimientoFields.CodigoArticulo.Value,
                                                                                                    DmLineaMovimientoFields.CodigoClaseA.Value,
                                                                                                    DmLineaMovimientoFields.CodigoClaseB.Value,
                                                                                                    DmLineaMovimientoFields.CodigoClaseC.Value,
                                                                                                    DmLineaMovimientoFields.Fecha.Value,
                                                                                                    DecSign( DmLineaMovimientoFields.CantidadAjustada.Value, not Sustraer ),
                                                                                                    DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer ),
                                                                                                    DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer ) );

                                  If   not ValueIsEmpty( DsArticuloFields.Familia.Value )
                                  then SessionDataModule.Dm30.StockAlmacenModule.ActualizaConsumoVentas( tcFamilia,
                                                                                                         FacturaVentasFields.CodigoCliente.Value,
                                                                                                         DsArticuloFields.Familia.Value,
                                                                                                         DmLineaMovimientoFields.CodigoClaseA.Value,
                                                                                                         DmLineaMovimientoFields.CodigoClaseB.Value,
                                                                                                         DmLineaMovimientoFields.CodigoClaseC.Value,
                                                                                                         DmLineaMovimientoFields.Fecha.Value,
                                                                                                         DecSign( DmLineaMovimientoFields.CantidadAjustada.Value, not Sustraer ),
                                                                                                         DecSign( DmLineaMovimientoFields.ImporteNeto.Value, not Sustraer ),
                                                                                                         DecSign( DmLineaMovimientoFields.ImporteDescuento.Value, not Sustraer ) );
                                  end;

                             end;

                        If   Assigned( OnInsertLine )
                        then OnInsertLine( ContabilizarPorCliente,
                                           DmLineaMovimientoFields.CodigoTipoIVA.Value,
                                           TipoIVADefectoManual,
                                           DsArticuloFields,
                                           DmGrupoClienteFields,
                                           DmMovimientoFields,
                                           DmLineaMovimientoFields );

                        Next;
                        end;

                    finally
                      CancelRange;
                      end;

                  try
                    Edit;
                    DmMovimientoFields.Traspasado.Value := not Sustraer;
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

            //*10.01.2011  Añadido el control de excepciones para evitar que se interrumpa el proceso de reconstrucción por un error en un único documento

            TransactionTag.Commit;

          except on E : Exception do
            begin
            TransactionTag.Rollback;
            SessionDataModule.SendNotification( ntWarning, Format( RsMsg44, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ), RsMsg45 + ExceptionMessage( E, True ) );
            end;
          end;

          end;

end;

procedure TFacturaVentasModule.AcumulaValoresImpositivos( var TasasArray   : TTasasArray;
                                                              Fecha        : TDate;
                                                              ModeloIVA    : SmallInt;
                                                              CalcularIVA  : Boolean;
                                                          var Sumas        : TTasaRecord );

var   Index : SmallInt;

begin

     FillChar( Sumas, SizeOf( Sumas ), #0 );

     For Index := 0 to NroMaximoTiposTasas do
       begin
       DecAdd( Sumas.BaseImponible, TasasArray[ Index ].BaseImponible );
       DecAdd( Sumas.BaseNoSujetaDto, TasasArray[ Index ].BaseNoSujetaDto );  // EcoTasas
       DecAdd( Sumas.CuotaIVA, TasasArray[ Index ].CuotaIVA );
       DecAdd( Sumas.CuotaRE, TasasArray[ Index ].CuotaRE );
       DecAdd( Sumas.Importe, TasasArray[ Index ].Importe );

       If   CalcularIVA and ( Index<>0 )
       then If   TasasArray[ Index ].TieneBases
            then begin
                 If   Sumas.TipoIVA=0.0
                 then Sumas.TipoIVA := TasasArray[ Index ].TipoIVA;
                 If   ModeloIVA=micConRE
                 then If   Sumas.TipoRE=0.0
                      then Sumas.TipoRE := TasasArray[ Index ].TipoRE;
                 end;
       end;

end;

procedure TFacturaVentasModule.RecuperaFacturas( Serie              : String;
                                                 NroFacturaInicial,
                                                 NroFacturaFinal    : LongInt );
var  Canceled : Boolean;
     EstadoPresentacion : TEstadoPresentacionVerifactu;
     EstadoRegistro : TEstadoRegistroVerifactu;

begin

     If   SessionDataModule.Dm10.SerieFacturacionModule.Obten( Serie )
     then try

            AbreFicherosContabilidad;

            var TransactionTag := SessionDataModule.StartTransactionWith( [ DmFacturaVentasTable ] );

            try

             Canceled := False;

             With DmFacturaVentasTable do
               try
                 IndexFieldNames := 'Ejercicio;Serie;NroFactura';
                 SetRange( [ SessionDataModule.Ejercicio, Serie, NroFacturaInicial ], [ SessionDataModule.Ejercicio, Serie, NroFacturaFinal ] );
                 First;
                 While not Eof and not Canceled do
                   begin

                   If   DmFacturaVentasFields.Traspasada.Value
                   then begin

                        If   FacturaPresentada( DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value )
                        then SessionDataModule.SendNotification( ntWarning, Format( RsMsg60, [ DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value ] ) )
                        else If   SessionDataModule.Dm10.EfectoCobrarModule.CompruebaEfectos( DmFacturaVentasFields.Ejercicio.Value, DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value, True )
                             then begin

                                  With DmAsientoTable do
                                    If   FindKey( [ taFraEmitida, SessionDataModule.Ejercicio, DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value, NroEfectoRegistroFactura ] )
                                    then SessionDataModule.Dm10.AsientoModule.SuprimeAsiento( DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, False, DmAsientoFacturaTable );

                                  ActualizaDatosEconomicos( SessionDataModule.Dm10.SerieFacturacionModule.DmSerieFacturacionFields, DmFacturaVentasFields, nil, True, True );

                                  try
                                    Edit;

                                    DmFacturaVentasFields.Traspasada.Value := False;

                                    Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg53, [ DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value ] ) );

                                    Post;

                                  except
                                    Cancel;
                                    raise;
                                    end;

                                  end
                             else Abort;  { El proceso podría simplemente evitar recuperar la factura con efectos cobrados pero seguir con el proceso.
                                            De momento este método de todo o nada parece más conveniente }
                             end;

                   Next;
                   end;

               finally
                 CancelRange;
                 end;

             TransactionTag.Commit;

             except on E : Exception do
               begin
               TransactionTag.Rollback;
               SessionDataModule.SendNotification( ntError, RsProcesoInterrumpido );
               end;
             end;

          finally
            CierraFicherosContabilidad;
            end
     else SessionDataModule.SendNotification( ntError, Format( RsMsg54, [ Serie ] ) );

end;

function TFacturaVentasModule.FacturaPresentada( Serie      : String;
                                                 NroFactura : LongInt ) : Boolean;

var EstadoPresentacion : TEstadoPresentacionVerifactu;
    Estadoregistro     : TEstadoregistroVerifactu;

begin

     // Si no estamos todavía en el entorno Verifactu no puede constar como presentada

     Result := False;
     If   SessionDataModule.Dm10.RegistroPresentacionModule.EntornoVerifactu
     then begin
          SessionDataModule.Dm10.RegistroPresentacionModule.ObtenEstadoPresentacionVerifactu( DmFacturaVentasFields.Serie.Value,
                                                                                              DmFacturaVentasFields.NroFactura.Value,
                                                                                              EstadoPresentacion,
                                                                                              EstadoRegistro );

          Result := EstadoPresentacion=epvPresentado;
          end;

end;

procedure TFacturaVentasModule.CierreCicloFacturacion( SerieInicial,
                                                       SerieFinal    : String;
                                                       FechaInicial,
                                                       FechaFinal    : TDate;
                                                       Contabilizar  : Boolean );

var   Offset,
      Index  : SmallInt;

      TransaccionContableActiva,
      Canceled : Boolean;

      TipoImpositivo,
      TipoIVAPortes : SmallInt;

      BaseImponiblePila,
      BaseCalculoDescuentos,
      ImporteDtoES,
      ImporteDtoPC,
      CuotaIVAPortes,
      CuotaREPortes : Decimal;

      CodigoPaisIVA,
      SerieActual,
      ErrorMessage : String;

      TasasArray : TTasasArray;

procedure GeneraAsiento;

Var  SubcuentaCliente,
     SubcuentaRetPracticada,
     SubcuentaIVARepercutido : String;
     Offset,
     NroApunteActual : Integer;

     DescuadreCuotas,
     DescuadreBases,
     DescuadreImporteTotal : Boolean;

     SumaBaseImponible,
     SumaCuotasLinea,
     SumaImporteTotalLinea,
     CuotasFactura,
     NetoFra : Decimal;

     Diferencia : Decimal;

     ConceptoApunte : String;

     CuotasArray  : Array [ 0..NroMaximoTiposTasas ] of Decimal;

begin

     SubcuentaCliente := DmClienteFields.Subcuenta.Value;

     SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( SubcuentaCliente, DmClienteFields.Nombre.Value );

     // Compruebo si existe un Asiento con el mismo nº de documento

     With DmFacturaVentasFields do
       If   DmAsientoTable.FindKey( [ taFraEmitida, Ejercicio.Value, Serie.Value, NroFactura.Value, NroEfectoRegistroFactura ] )
       then begin
            Canceled := SessionDataModule.SendNotification( ntError, Format( RsMsg78, [ DmAsientoFields.NroAsiento.Value ] ) );
            Abort;
            end;

     DmAsientoTable.Append;

     try

       DmAsientoFields.TipoAsiento.Value := taFraEmitida;
       DmAsientoFields.Ejercicio.Value := SessionDataModule.Ejercicio;
       DmAsientoFields.NroAsiento.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroAsiento;
       DmAsientoFields.Fecha.Value := DmFacturaVentasFields.Fecha.Value;
       DmAsientoFields.FechaDocumento.Value := DmFacturaVentasFields.Fecha.Value;
       DmAsientoFields.Propietario.Value := SubcuentaCliente;
       DmAsientoFields.Nombre.Value := DmClienteFields.Nombre.Value;
       DmAsientoFields.Serie.Value := DmFacturaVentasFields.Serie.Value;
       DmAsientoFields.NroFactura.Value := DmFacturaVentasFields.NroFactura.Value;
       DmAsientoFields.NroEfecto.Value := NroEfectoRegistroFactura;
       DmAsientoFields.NroRegistro.Value := SessionDataModule.Dm10.AsientoModule.ProximoNroRegistro( taFraEmitida );

       If   DmFacturaVentasFields.InversionSujetoPasivo.Value
       then DmAsientoFields.Origen.Value := ofrInversionSP
       else DmAsientoFields.Origen.Value := ofrSujetoPasivo;

       CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DmClienteFields );
       ConceptoApunte := Format( RsMsg62, [ DmAsientoFields.Serie.Value, DmAsientoFields.NroFactura.Value ] );

       SumaBaseImponible := 0.0;
       SumaCuotasLinea := 0.0;
       SumaImporteTotalLinea := 0.0;
       CuotasFactura := 0.0;

       NroApunteActual := 2;
       Offset := 0;

       While ( Offset<PilaSubcuentas.Count ) do
         begin

         PilaSubcuentas[ Offset ].BaseImponible := Redondea( PilaSubcuentas[ Offset ].BaseImponible );
         PilaSubcuentas[ Offset ].CuotaIVA := Redondea( PilaSubcuentas[ Offset ].CuotaIVA );
         PilaSubcuentas[ Offset ].CuotaRE := Redondea( PilaSubcuentas[ Offset ].CuotaRE );

         If   ( PilaSubcuentas[ Offset ].BaseImponible<>0.0 ) or
              ( ( DmFacturaVentasFields.TotalFactura.Value=0.0 ) and PilaSubcuentas[ Offset ].Activo )
         then begin

              DmApunteTable.Append;

              DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
              DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
              DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
              DmApunteFields.Concepto.Value := ConceptoApunte;
              DmApunteFields.Contrapartida.Value := SubcuentaCliente;

              DmApunteFields.NroApunte.Value := NroApunteActual;
              DmApunteFields.Subcuenta.Value := PilaSubcuentas[ Offset ].Subcuenta;
              DmApunteFields.CentroCoste.Value := PilaSubcuentas[ Offset ].CentroCoste;
              DmApunteFields.Concepto.Value := ConceptoApunte;
              SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, PilaSubcuentas[ Offset ].BaseImponible, True );
              DmApunteFields.BaseImponible.Value := PilaSubcuentas[ Offset ].BaseImponible;
              DmApunteFields.TipoApunte.Value := tapManual;

              If   CalcularIVA
              then begin
                   DmApunteFields.Tipo.Value := PilaSubcuentas[ Offset ].TipoImpositivo;
                   DmApunteFields.CuotaIVA.Value := PilaSubcuentas[ Offset ].CuotaIVA;
                   If   DmClienteFields.Factura_ModeloIVA.Value=micConRE
                   then DmApunteFields.CuotaRE.Value := PilaSubcuentas[ Offset ].CuotaRE
                   else DmApunteFields.CuotaRE.Value := 0.0;
                   end
              else begin
                   DmApunteFields.Tipo.Value := 0;
                   DmApunteFields.CuotaIVA.Value := 0.0;
                   DmApunteFields.CuotaRE.Value := 0.0;
                   end;

              DmApunteFields.ImporteTotal.Value := DmApunteFields.BaseImponible.Value + DmApunteFields.CuotaIVA.Value + DmApunteFields.CuotaRE.Value;

              DecAdd( SumaBaseImponible, DmApunteFields.BaseImponible.Value );
              DecAdd( SumaCuotasLinea, DmApunteFields.CuotaIVA.Value + DmApunteFields.CuotaRE.Value );
              DecAdd( SumaImporteTotalLinea, DmApunteFields.ImporteTotal.Value );

              SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );

              DmApunteTable.Post;

              Inc( NroApunteActual );
              end;

         Inc( Offset );
         end;

       If   NroApunteActual>2
       then begin

            DmApunteTable.Append;

            DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
            DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
            DmApunteFields.NroApunte.Value := 1;
            DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
            DmApunteFields.Subcuenta.Value := DmAsientoFields.Propietario.Value;
            DmApunteFields.Concepto.Value := ConceptoApunte;
            SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmFacturaVentasFields.TotalFactura.Value );
            DmApunteFields.BaseImponible.Value := 0.0;
            DmApunteFields.Tipo.Value := 0;
            DmApunteFields.CuotaIVA.Value := 0.0;
            DmApunteFields.ImporteTotal.Value  := 0.0;

            SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );

            DmApunteTable.Post;

            // Tratamiento de las retenciones

            If   DmFacturaVentasFields.ImporteRetencion.Value<>0.0
            then begin

                 DmApunteTable.Append;

                 SessionDataModule.Dm10.TasaModule.TipoRetencion( DmFacturaVentasFields.Fecha.Value, DmFacturaVentasFields.TipoRetencion.Value, DsTiposRetencionFields );

                 If   DsTiposRetencionFields.CtaRetPracticada.Value=''
                 then SubcuentaRetPracticada := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaRetPracticada )
                 else SubcuentaRetPracticada := DsTiposRetencionFields.CtaRetPracticada.Value;

                   DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                   DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                   DmApunteFields.NroApunte.Value := NroApunteActual;
                   DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                   DmApunteFields.Concepto.Value := ConceptoApunte;

                 If   DsTiposRetencionFields.Desglosar.Value
                 then begin
                      DmApunteFields.Subcuenta.Value := Copy( SubcuentaRetPracticada, 1, 4 ) + Copy( DmAsientoFields.Propietario.Value, 5, 5 );
                      SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( DmApunteFields.Subcuenta.Value, DmAsientoFields.Nombre.Value );
                      end
                 else DmApunteFields.Subcuenta.Value := SubcuentaRetPracticada;

                 DmApunteFields.Contrapartida.Value := DmAsientoFields.Propietario.Value;

                 SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, DmFacturaVentasFields.ImporteRetencion.Value );

                 DmApunteFields.BaseImponible.Value := DmFacturaVentasFields.BaseCalculoRetencion.Value;
                 DmApunteFields.Tipo.Value := DmFacturaVentasFields.TipoRetencion.Value;
                 DmApunteFields.CuotaIVA.Value := 0.0;
                 DmApunteFields.CuotaRE.Value := 0.0;
                 DmApunteFields.ImporteTotal.Value := 0.0;
                 DmApunteFields.TipoApunte.Value := tapRetencion;

                 SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );

                 DmApunteTable.Post;

                 DecAdd( SumaImporteTotalLinea, -DmFacturaVentasFields.ImporteRetencion.Value  );

                 Inc( NroApunteActual );
                 end;

            NetoFra  := DmFacturaVentasFields.NetoFactura.Value -
                        DmFacturaVentasFields.DescuentosClientes.Value +
                        DmFacturaVentasFields.ImporteRecFinanciero.Value +
                        DmFacturaVentasFields.Portes.Value;

            DescuadreCuotas := SumaCuotasLinea<>DmFacturaVentasFields.CuotaIVA.Value + DmFacturaVentasFields.CuotaRE.Value;
            DescuadreBases := NetoFra<>SumaBaseImponible;
            DescuadreImporteTotal := DmFacturaVentasFields.TotalFactura.Value<>SumaImporteTotalLinea ;

            If   DescuadreCuotas or
                 DescuadreBases or
                 DescuadreImporteTotal
            then With DmApunteTable do
                   begin
                   CancelRange;

                   If   FindKey( [ DmAsientoFields.Ejercicio.Value, DmAsientoFields.NroAsiento.Value, 2 ] )
                   then try

                          SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields, True );

                          Edit;

                          If   DescuadreBases
                          then begin
                               Diferencia := NetoFra - SumaBaseImponible;
                               DmApunteFields.BaseImponible.Value := DmApunteFields.BaseImponible.Value + Diferencia;

                               // La base imponible tiene signo, pero el Importe es su valor absoluto

                               SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber ) - Diferencia );
                               end;

                          If   DescuadreCuotas
                          then begin
                               Diferencia := ( DmFacturaVentasFields.CuotaIVA.Value  + DmFacturaVentasFields.CuotaRE.Value ) - SumaCuotasLinea;
                               DmApunteFields.CuotaIVA.Value := DmApunteFields.CuotaIVA.Value + Diferencia;
                               end;

                          If   DescuadreImporteTotal
                          then begin

                               Diferencia := DmFacturaVentasFields.TotalFactura.Value - SumaImporteTotalLinea;

                               If   not DescuadreCuotas and
                                    not DescuadreBases
                               then begin
                                    DmApunteFields.BaseImponible.Value := DmApunteFields.BaseImponible.Value + Diferencia;

                                    // Idem que el anterior

                                    If   DmApunteFields.BaseImponible.Value>=0.0
                                    then SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber ) + Diferencia )
                                    else SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, GetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber ) - Diferencia );
                                    end;

                               DmApunteFields.ImporteTotal.Value := DmApunteFields.ImporteTotal.Value + Diferencia;
                               end;

                          If   ( DmApunteFields.Debe.Value=0.0 ) and ( DmApunteFields.Haber.Value=0.0 )
                          then Delete
                          else begin
                               SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                               Post;
                               end;

                        except
                          Cancel;
                          raise;
                          end;

                   end;

            // Completando el Asiento

            If   CalcularIVA
            then begin

                 CuotasFactura := 0.0;

                 FillChar( CuotasArray, SizeOf( CuotasArray ), #0 );
                 With DmApunteTable do
                   try
                     With DmAsientoFields do
                       SetRange( [ Ejercicio.Value, NroAsiento.Value, 2 ], [ Ejercicio.Value, NroAsiento.Value, MaxSmallint ] );
                     First;
                     While not Eof do
                       begin
                       With DmApunteFields do
                         begin
                         DecAdd( CuotasArray[ Tipo.Value ], CuotaIVA.Value + CuotaRE.Value );
                         DecAdd( CuotasFactura, CuotaIVA.Value + CuotaRE.Value );
                         end;
                       Next;
                       end;
                   finally
                     CancelRange;
                     end;

                 If   Redondea( CuotasFactura )<>Redondea( DmFacturaVentasFields.CuotaIVA.Value + DmFacturaVentasFields.CuotaRE.Value )
                 then With DmFacturaVentasFields do
                        begin
                        SessionDataModule.SendNotification( ntError, Format( RsMsg75, [ Serie.Value, NroFactura.Value ] ), RsMsg76 );
                        Abort;
                        end;

                 For Offset := 1 to NroMaximoTiposTasas do
                   If   CuotasArray[ Offset ]<>0.0
                   then begin

                        SessionDataModule.Dm10.TasaModule.TipoIVA( DmAsientoFields.Fecha.Value, CodigoPaisIVA, Offset, DsTiposIVAFields );

                        If   DsTiposIVAFields.CtaRepercutido.Value=''
                        then SubcuentaIVARepercutido := SessionDataModule.Dm10.CuentaModule.CodigoCuentaDefecto( cpCtaIVARepercutido )
                        else SubcuentaIVARepercutido := DsTiposIVAFields.CtaRepercutido.Value;

                        DmApunteTable.Append;

                        DmApunteFields.Ejercicio.Value := DmAsientoFields.Ejercicio.Value;
                        DmApunteFields.NroAsiento.Value := DmAsientoFields.NroAsiento.Value;
                        DmApunteFields.Fecha.Value := DmAsientoFields.Fecha.Value;
                        DmApunteFields.NroApunte.Value := NroApunteActual;
                        DmApunteFields.Subcuenta.Value := SubcuentaIVARepercutido;
                        DmApunteFields.Contrapartida.Value := DmAsientoFields.Propietario.Value;
                        DmApunteFields.Concepto.Value := ConceptoApunte;
                        SetSignedValue( DmApunteFields.Debe, DmApunteFields.Haber, CuotasArray[ Offset ], True );
                        DmApunteFields.TipoApunte.Value := tapCuotaIVA;
                        DmApunteFields.BaseImponible.Value := 0.0;
                        DmApunteFields.Tipo.Value := Offset;
                        DmApunteFields.CuotaIVA.Value := 0.0;
                        DmApunteFields.ImporteTotal.Value := 0.0;

                        SessionDataModule.Dm10.SaldosModule.ActualizaSaldos( DmAsientoFields.TipoAsiento.Value, DmApunteFields );
                        DmApunteTable.Post;

                        Inc( NroApunteActual );
                        end;

                 end;

            DmAsientoTable.Post;

            With DmFacturaVentasFields do
              SessionDataModule.Dm10.FacturaModule.CopiaRegistroFactura( tfFacturaVentas,
                                                                         '',
                                                                         Serie.Value,
                                                                         NroFactura.Value,
                                                                         DmAsientoFields.NroAsiento.Value,
                                                                         DmAsientoFacturaFields );

            With DmFacturaVentasFields do
              Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg79, [ Serie.Value, NroFactura.Value, DmAsientoFields.NroAsiento.Value ] ) );

            end
       else DmAsientoTable.Cancel;

     except
       DmAsientoTable.Cancel;
       raise;
       end;

end;

procedure GeneraEfectos;

var   Offset : SmallInt;
      SubcuentaCliente : String;
      DocumentoMsg : String;

begin

     SubcuentaCliente := DmClienteFields.Subcuenta.Value;

     SessionDataModule.Dm10.CuentaModule.InsertaSubcuenta( SubcuentaCliente, DmClienteFields.Nombre.Value );

     If   not DmFormaCobroTable.FindKey( [ DmFacturaVentasFields.CodigoFormaCobro.Value ] )
     then begin

          Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg63, [ DmFacturaVentasFields.NroFactura.Value, DmFacturaVentasFields.CodigoCliente.Value ] ) );

          With DmFormaCobroFields do
            begin
            DatasetAppend;
            Plazos.Value := 1;
            PrimerVencimiento.Value := 0;
            Intervalo.Value := 0;
            CrearRegistro.Value := True;
            DatasetBrowse;
            end;

          end;

     If   DmFormaCobroFields.CrearRegistro.Value
     then begin

          With DmFacturaVentasFields do
            SessionDataModule.Dm30.EfectoModule.ObtenVencimientos( scVentas, Ejercicio.Value, CodigoCliente.Value, Serie.Value, NroFactura.Value, RelacionEfectos );

          With RelacionEfectos do
            begin

            If   DmFormaCobroFields.Plazos.Value=0
            then begin
                 FechaVencimiento[ 0 ] := DmFacturaVentasFields.Fecha.Value;
                 Importe[ 0 ] := DmFacturaVentasFields.TotalFactura.Value;
                 end
            else If   DmFacturaVentasFields.TotalACuenta.Value<>0.0
                 then begin
                      FechaVencimiento[ 0 ] := DmFacturaVentasFields.Fecha.Value;
                      Importe[ 0 ] := DmFacturaVentasFields.TotalACuenta.Value;
                      end;

            { Suprimo todos los efectos que pudieran existir de esta factura }

            With DmFacturaVentasFields do
              If   not SessionDataModule.Dm10.EfectoCobrarModule.CompruebaEfectos( Ejercicio.Value, Serie.Value, NroFactura.Value, True )   // Si todo va bien, se suprimen los efectos
              then Abort;

            For Offset := 0 to NroEfectos do
              begin

              If   Importe[ Offset ]<>0.0
              then If   not DmEfectoCobrarTable.FindKey( [ DmFacturaVentasFields.Ejercicio.Value,
                                                           DmFacturaVentasFields.Serie.Value,
                                                           DmFacturaVentasFields.NroFactura.Value,
                                                           Offset ] )
                   then begin

                        DmEfectoCobrarTable.Append;

                        try

                          DmEfectoCobrarFields.Ejercicio.Value := SessionDataModule.Ejercicio;
                          DmEfectoCobrarFields.SubcuentaCliente.Value := SubcuentaCliente;
                          DmEfectoCobrarFields.Serie.Value := DmFacturaVentasFields.Serie.Value;
                          DmEfectoCobrarFields.NroFactura.Value := DmFacturaVentasFields.NroFactura.Value;
                          DmEfectoCobrarFields.NroEfecto.Value := Offset;

                          If   FechaLibramiento[ Offset ]=0
                          then DmEfectoCobrarFields.FechaLibramiento.Value := DmFacturaVentasFields.Fecha.Value
                          else DmEfectoCobrarFields.FechaLibramiento.Value := FechaLibramiento[ Offset ];

                          DmEfectoCobrarFields.FechaVencimiento.Value := FechaVencimiento[ Offset ];
                          DmEfectoCobrarFields.Concepto.Value := SessionDataModule.Dm10.EfectoCobrarModule.TextoConcepto( DmEfectoCobrarFields );
                          DmEfectoCobrarFields.SubcuentaEntidad.Value := SessionDataModule.Dm10.EfectoCobrarModule.ObtenCanalPreferente( DmClienteFields, DmFacturaVentasFields.CodigoFormaCobro.Value );
                          DmEfectoCobrarFields.Importe.Value := Importe[ Offset ];
                          DmEfectoCobrarFields.FormaDePago.Value := DmFacturaVentasFields.CodigoFormaCobro.Value;
                          DmEfectoCobrarFields.Vendedor.Value := DmFacturaVentasFields.CodigoVendedor.Value;
                          DmEfectoCobrarFields.GrupoFacturacion.Value := DmFacturaVentasFields.GrupoFacturacion.Value;
                          DmEfectoCobrarFields.CodigoCliente.Value := DmFacturaVentasFields.CodigoCliente.Value;

                          If   Offset=0
                          then With DmEfectoCobrarFields do
                                 begin

                                 ImporteCobrado.Value := Importe.Value;
                                 FechaCobro.Value := FechaVencimiento.Value;

                                 If   ImporteCobrado.Value>=0.0
                                 then ConceptoCobro.Value := RsMsg69
                                 else ConceptoCobro.Value := RsMsg70;

                                 //* 31.08.2003   Añadido el canal en la ficha de series de facturación

                                 If   SessionDataModule.EmpresaFields.Cliente_CanalSerie.Value
                                 then If   DsSerieFacturacionFields.Canal.Value=''
                                      then DmEfectoCobrarFields.SubcuentaEntidad.Value := '57' + LeftPad( DmFacturaVentasFields.Serie.Value, 7 )
                                      else DmEfectoCobrarFields.SubcuentaEntidad.Value := DsSerieFacturacionFields.Canal.Value;

                                 ConceptoCobro.Value := ConceptoCobro.Value + Serie.Value + '-' +  StrInt( NroFactura.Value );

                                 SessionDataModule.Dm10.EfectoCobrarModule.ActualizaAnotacionCobro( DmEfectoCobrarFields );

                                 end
                          else SessionDataModule.Dm10.EfectoCobrarModule.ActualizaEfectoCobrar( DmEfectoCobrarFields );

                        except
                          DmEfectoCobrarTable.Append;
                          raise;
                          end;

                        end;

              end;
            end;

          end;
end;

procedure InicializaFicherosContabilidad;
begin

     //* 29.01.2005 Hay que cerrar cada vez los ficheros del módulo 'AsientoModule' porque cada serie se puede contabilizar en una empresa distinta.

     SessionDataModule.Dm10.AsientoModule := nil;

     SessionDataModule.Dm10.SerieFacturacionModule.Obten( SerieActual, DsSerieFacturacionFields );

     AbreFicherosContabilidad;

     If   SessionDataModule.Dm10.AsientoModule.EjercicioCerrado
     then begin
          SessionDataModule.SendNotification( ntAbort, RsMsg83, RsMsg84 );
          Abort;
          end;

     ContabilidadTransactionTag := SessionDataModule.StartTransactionWith( [ DmAsientoTable,
                                                                             DmApunteTable,
                                                                             DmEfectoCobrarTable ] );
     TransaccionContableActiva := True;

     // Inserción automática de las cuentas genéricas

     CuentaVentas := SessionDataModule.Dm10.TasaModule.ObtenRelacion( srVentas );
     If   CuentaVentas=''
     then CuentaVentas := SessionDataModule.Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaVentas );

     CuentaDevVentas := SessionDataModule.Dm10.TasaModule.ObtenRelacion( srDevolucionesVentas );
     If   CuentaDevVentas=''
     then CuentaDevVentas := SessionDataModule.Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaDevVentas );

     CuentaDtoPC := SessionDataModule.Dm10.TasaModule.ObtenRelacion( srDescuentoPC );
     If   CuentaDtoPC=''
     then CuentaDtoPC := SessionDataModule.Dm10.CuentaModule.CreaSubcuentaDefecto( cpctaDescuentoPC );

     CuentaRecargoFinanciero := SessionDataModule.Dm10.TasaModule.ObtenRelacion( srRecargoFinancieroVentas );
     If   CuentaRecargoFinanciero=''
     then CuentaRecargoFinanciero := SessionDataModule.Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaRecargoFinancieroVentas );

     CuentaPortes := SessionDataModule.Dm10.TasaModule.ObtenRelacion( srPortesVentas );
     If   CuentaPortes=''
     then CuentaPortes := SessionDataModule.Dm10.CuentaModule.CreaSubcuentaDefecto( cpCtaPortesVentas );

end;

begin

     var TransactionTag := SessionDataModule.StartTransactionWith(  [ DmFacturaVentasTable ] );

     try

       try

         Canceled := False;
         SerieActual := #0;   // La serie vacía es la genérica
         CodigoPaisIVA := CodigoEspaña;

         With DmFacturaVentasTable do
           try

             IndexFieldNames := 'Serie;Fecha;NroFactura';

             SetRange( [ SerieInicial, FechaInicial, 0 ], [ SerieFinal, FechaFinal, MaxLongint ] );

             First;
             While not Eof do
               begin

               If   SerieActual<>DmFacturaVentasFields.Serie.Value
               then begin
                    If   SerieActual<>#0
                    then begin
                         If   TransaccionContableActiva
                         then begin
                              ContabilidadTransactionTag.Commit;
                              TransaccionContableActiva := False;
                              end;
                         CierraFicherosContabilidad;
                         end;
                    SerieActual := DmFacturaVentasFields.Serie.Value;
                    InicializaFicherosContabilidad;
                    SessionDataModule.Dm10.SerieFacturacionModule.Obten( SerieActual, DsSerieFacturacionFields );
                    If   SerieActual<>''
                    then Canceled := SessionDataModule.SendNotification( ntInformation, Format( RsMsg67, [ SerieActual ] ) );

                    end;

               If   not DmFacturaVentasFields.Traspasada.Value { and
                    not DmFacturaVentasFields.Anulada.Value }
               then If   not SessionDataModule.Dm10.AsientoModule.TrimestreCorrecto( MonthOf( DmFacturaVentasFields.Fecha.Value ) )
                    then Canceled := SessionDataModule.SendNotification( ntWarning, Format( RsMsg82, [ DmFacturaVentasFields.NroFactura.Value ] ) )
                    else If   SessionDataModule.Dm10.RegistroPresentacionModule.EntornoVerifactu and not FacturaPresentada( DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value )
                         then SessionDataModule.SendNotification( ntWarning, Format( RsMsg68, [ DmFacturaVentasFields.NroFactura.Value, DmFacturaVentasFields.CodigoCliente.Value ] ) )
                         else begin

                              InicializaPila;

                              // En llamada a ActualizaDatosEconomicos se lee el registro del cliente DmClienteFields

                              ActualizaDatosEconomicos( DsSerieFacturacionFields, DmFacturaVentasFields, DoInsertLine, False, True );

                              CodigoPaisIVA := SessionDataModule.Dm10.ClienteModule.ObtenCodigoPaisIVA( DmClienteFields );

                              Offset := 0;
                              While ( Offset<PilaSubcuentas.Count ) do
                                begin

                                If   PilaSubcuentas[ Offset ].BaseImponible<>0.0
                                then begin

                                     // Aprovecho para agrupar las bases imponibles por Tipo impositivo

                                     TipoImpositivo := PilaSubcuentas[ Offset ].TipoImpositivo;
                                     BaseImponiblePila := PilaSubcuentas[ Offset ].BaseImponible;

                                     If   DmFacturaVentasFields.DescuentoES.Value<>0.0
                                     then begin
                                          ImporteDtoES := Redondea( ( BaseImponiblePila * DmFacturaVentasFields.DescuentoES.Value ) / 100 );
                                          PilaSubcuentas[ Offset ].BaseImponible := PilaSubcuentas[ Offset ].BaseImponible - ImporteDtoES;
                                          end;

                                     end;
                                Inc( Offset );
                                end;

                              // Empieza el tratamiento de los Descuentos en factura

                              TipoIVAPortes := SessionDataModule.Dm10.TasaModule.TipoIVAGlobal( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, rgTipoIVAPortes );

                              If   ( DmFacturaVentasFields.DescuentoES.Value<>0.0 ) or
                                   ( DmFacturaVentasFields.DescuentoPP.Value<>0.0 )
                              then begin

                                   // Necesito las bases imponibles de cada tipo para calcular los descuentos aplicados a cada una de ellas

                                   var TotalCuotaIVA : Decimal := 0.0;
                                   var TotalCuotaRE : Decimal := 0.0;

                                   With DmFacturaVentasFields do
                                     ObtenBasesyCuotasFactura( Ejercicio.Value,
                                                               CodigoCliente.Value,
                                                               Serie.Value,
                                                               NroFactura.Value,
                                                               TasasArray,
                                                               TotalCuotaIVA,
                                                               TotalCuotaRE );

                                   For Index := 0 to NroMaximoTiposTasas do
                                     If   TasasArray[ Index ].TieneBases
                                     then begin

                                          BaseCalculoDescuentos := TasasArray[ Index ].BaseImponible - TasasArray[ Index ].BaseNoSujetaDto;

                                          If   Index=TipoIVAPortes
                                          then BaseCalculoDescuentos := BaseCalculoDescuentos - DmFacturaVentasFields.Portes.Value;

                                          If   DmFacturaVentasFields.DescuentoES.Value=0.0
                                          then ImporteDtoES := 0.0
                                          else ImporteDtoES := Redondea( ( BaseCalculoDescuentos * DmFacturaVentasFields.DescuentoES.Value ) / 100 );

                                          If   DmFacturaVentasFields.DescuentoPP.Value=0.0
                                          then ImporteDtoPC := 0.0
                                          else ImporteDtoPC := Redondea( ( ( BaseCalculoDescuentos - ImporteDtoES ) * DmFacturaVentasFields.DescuentoPP.Value ) / 100 );

                                          If   ImporteDtoPC<>0.0
                                          then begin
                                               If   CalcularIVA
                                               then TipoImpositivo := Index
                                               else TipoImpositivo := 0;
                                               InsertarEnPila( CuentaDtoPC, '', TipoImpositivo, -ImporteDtoPC, 0.0, 0.0 );
                                               end;

                                          end;

                                   end;

                              // Recargo financiero

                              With DmFacturaVentasFields do
                                If   ImporteRecFinanciero.Value<>0.0
                                then InsertarEnPila( CuentaRecargoFinanciero, '', 0, ImporteRecFinanciero.Value, 0.0, 0.0 );

                              // Portes

                              If   DmFacturaVentasFields.Portes.Value<>0.0
                              then begin
                                   If   CalcularIVA
                                   then TipoImpositivo := TipoIVAPortes
                                   else TipoImpositivo := 0;
                                   ObtenCuotasPortes( DmFacturaVentasFields.Portes.Value, DmFacturaVentasFields.Fecha.Value, DmClienteFields, CuotaIVAPortes, CuotaREPortes );
                                   InsertarEnPila( CuentaPortes, '', TipoImpositivo, DmFacturaVentasFields.Portes.Value, CuotaIVAPortes, CuotaREPortes );
                                   end;

                              // Si la factura tiene descuentos hay que recalcular las cuotas del I.V.A.

                              If   CalcularIVA and
                                   ( ( DmFacturaVentasFields.DescuentoES.Value<>0.0 ) or ( DmFacturaVentasFields.DescuentoPP.Value<>0.0 ) )
                              then begin
                                   Offset := 0;
                                   While ( Offset<PilaSubcuentas.Count ) do
                                     begin
                                     If   ( PilaSubcuentas[ Offset ].BaseImponible<>0.0 ) and
                                          ( PilaSubcuentas[ Offset ].TipoImpositivo<>0 )
                                     then begin
                                          SessionDataModule.Dm10.TasaModule.TipoIVA( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, PilaSubcuentas[ Offset ].TipoImpositivo, DsTiposIVAFields );
                                          PilaSubcuentas[ Offset ].CuotaIVA := Redondea( PilaSubcuentas[ Offset ].BaseImponible * DsTiposIVAFields.IVARepercutido.Value / 100 );
                                          If   DmClienteFields.Factura_ModeloIVA.Value=micConRE
                                          then PilaSubcuentas[ Offset ].CuotaRE := Redondea( PilaSubcuentas[ Offset ].BaseImponible * DsTiposIVAFields.RERepercutido.Value / 100 )
                                          else PilaSubcuentas[ Offset ].CuotaRE := 0.0;
                                          end;
                                     Inc( Offset );
                                     end;
                                   end;

                              If   Contabilizar
                              then If   DsSerieFacturacionFields.Contabilizar.Value
                                   then begin
                                        GeneraAsiento;
                                        If   DmFacturaVentasFields.TotalFactura.Value<>0.0
                                        then GeneraEfectos;
                                        end;

                              try
                                Edit;
                                DmFacturaVentasFields.Traspasada.Value := True;
                                Post;
                              except
                                Cancel;
                                raise;
                                end;

                              end;

               Next;

               If   Canceled
               then Abort;

               end;

           finally
             CancelRange;
             PilaSubcuentas.Clear;
             end;

           If   SessionDataModule.EmpresaFields.Ventas_ContMovCaja.Value
           then SessionDataModule.Dm10.MovimientoCajaModule.Contabiliza( SerieInicial, SerieFinal, FechaInicial, FechaFinal );

           If   TransaccionContableActiva
           then begin
                ContabilidadTransactionTag.Commit;
                TransaccionContableActiva := False;
                end;

           TransactionTag.Commit;

       except on E : Exception do
         begin
         If   TransaccionContableActiva
         then ContabilidadTransactionTag.RollBack;
         TransactionTag.Rollback;
         ErrorMessage := ExceptionMessage( E ) + HTMLCR;
         Canceled := SessionDataModule.SendNotification( ntError, RsMsg73 + HTMLCR + ErrorMessage + RsProcesoInterrumpido );
         end;
       end;

   finally
     CierraFicherosContabilidad;
     end;

end;

procedure TFacturaVentasModule.DoInsertLine( ContabilizarPorCliente : Boolean;
                                             TipoIVAArticulo,
                                             TipoIVADefectoManual   : SmallInt;
                                             ArticuloFields         : TArticuloFields;
                                             GrupoClienteFields     : TGrupoClienteFields;
                                             MovimientoFields       : TMovimientoFields;
                                             LineaMovimientoFields  : TLineaMovimientoFields );

var  CodigoSubcuenta : String;

begin

     With LineaMovimientoFields do
       begin

       If   ImporteNeto.Value<0.0
       then begin
            CodigoSubcuenta := CuentaDevVentas;
            If   ContabilizarPorCliente
            then If   not ValueIsEmpty( GrupoClienteFields.CtaDevVentas.Value )
                 then CodigoSubcuenta := GrupoClienteFields.CtaDevVentas.Value;
            end
       else begin
            CodigoSubcuenta := CuentaVentas;
            If   ContabilizarPorCliente
            then If   not ValueIsEmpty( GrupoClienteFields.CtaVentas.Value )
                 then CodigoSubcuenta := GrupoClienteFields.CtaVentas.Value;
            end;

            If   not ContabilizarPorCliente
            then If   not ValueIsEmpty( ArticuloFields.Familia.Value )
                 then If   SessionDataModule.Dm30.FamiliaModule.Obten( ArticuloFields.Familia.Value, DsFamiliaFields )
                      then If   ImporteNeto.Value<0.0
                           then begin
                                If   not ValueIsEmpty( DsFamiliaFields.Cta_DevVentas.Value )
                                then CodigoSubcuenta := DsFamiliaFields.Cta_DevVentas.Value;
                                end
                           else If   not ValueIsEmpty( DsFamiliaFields.Cta_Ventas.Value )
                                then CodigoSubcuenta := DsFamiliaFields.Cta_Ventas.Value;

            InsertarEnPila( CodigoSubcuenta, MovimientoFields.CentroCoste.Value, TipoIVAArticulo, ImporteNeto.Value, CuotaIVA.Value, CuotaRE.Value );

       end;
end;

procedure TFacturaVentasModule.AbreFicherosContabilidad;
begin

     SessionDataModule.Dm10.FreeAsientoModule;
     SessionDataModule.Dm10.FreeSaldosModule;
     SessionDataModule.Dm10.FreeEfectoCobrarModule;
     SessionDataModule.Dm10.FreeFacturaModule;

     SessionDataModule.Dm10.SerieFacturacionModule.AbreEmpresaAuxiliar;

     With EnterpriseDataModule do
       begin
       CheckUserAuxDatabase( DmAsientoTable );
       CheckUserAuxDatabase( DmApunteTable );
       CheckUserAuxDatabase( DmEfectoCobrarTable );
       CheckUserAuxDatabase( DmMovimientoCajaTable );
       CheckUserAuxDatabase( DmAsientoFacturaTable );
       end;

     DmAsientoTable.Open;
     DmApunteTable.Open;
     DmEfectoCobrarTable.Open;
     DmMovimientoCajaTable.Open;
     DmAsientoFacturaTable.Open;

     DmAsientoFields := TAsientoFields.Create( DmAsientoTable );
     DmApunteFields := TApunteFields.Create( DmApunteTable );
     DmEfectoCobrarFields := TEfectoCobrarFields.Create( DmEfectoCobrarTable );
     DmMovimientoCajaFields := TMovimientoCajaFields.Create( DmMovimientoCajaTable );
     DmAsientoFacturaFields := TFacturaFields.Create( DmAsientoFacturaTable );

     SessionDataModule.Dm10.SaldosModule;
end;

procedure TFacturaVentasModule.CierraFicherosContabilidad;
begin
     try
       DmAsientoTable.Close;
       DmApunteTable.Close;
       DmEfectoCobrarTable.Close;
       DmMovimientoCajaTable.Close;
       DmAsientoFacturaTable.Close;
     finally
       SessionDataModule.Dm10.SerieFacturacionModule.CierraEmpresaAuxiliar;
       SessionDataModule.Dm10.FreeAllDataModules;  // Algunas tablas siguen abiertas sobre la base de datos auxiliar
       end;
end;

procedure TFacturaVentasModule.InicializaPila;

var   Index  : SmallInt;

begin

     PilaSubcuentas.Clear;

     For Index := 0 to NroMaximoTiposTasas do
       begin

       SubcuentaFamilia := TSubcuentaFamilia.Create;

       SubcuentaFamilia.Activo := False;
       SubcuentaFamilia.Subcuenta := CuentaVentas;
       SubcuentaFamilia.CentroCoste := '';
       SubcuentaFamilia.TipoImpositivo := Index;

       PilaSubcuentas.Add( SubcuentaFamilia );

       end;

end;

procedure TFacturaVentasModule.InsertarEnPila( Subcuenta       : String;
                                               CentroCoste     : String;
                                               TipoImpositivo  : SmallInt;
                                               BaseImponible,
                                               CuotaIVA,
                                               CuotaRE         : Decimal );

var   Encontrado : Boolean;
      Index      : SmallInt;

begin

     Index      := 0;
     Encontrado := False;

     repeat

       If   ( Subcuenta=PilaSubcuentas[ Index ].Subcuenta ) and
            ( CentroCoste=PilaSubcuentas[ Index ].CentroCoste ) and
            ( TipoImpositivo=PilaSubcuentas[ Index ].TipoImpositivo )
       then begin
            PilaSubcuentas[ Index ].Activo := True;
            PilaSubcuentas[ Index ].BaseImponible := PilaSubcuentas[ Index ].BaseImponible + BaseImponible;
            PilaSubcuentas[ Index ].CuotaIVA := PilaSubcuentas[ Index ].CuotaIVA + CuotaIVA;
            PilaSubcuentas[ Index ].CuotaRE := PilaSubcuentas[ Index ].CuotaRE + CuotaRE;
            Encontrado := True;
            end
       else Inc( Index );

     until ( Index>=PilaSubcuentas.Count ) or
           Encontrado;

     If   not Encontrado
     then begin

          SubcuentaFamilia := TSubcuentaFamilia.Create;

          SubcuentaFamilia.Activo := True;
          SubcuentaFamilia.Subcuenta := Subcuenta;
          SubcuentaFamilia.CentroCoste := CentroCoste;
          SubcuentaFamilia.TipoImpositivo := TipoImpositivo;
          SubcuentaFamilia.BaseImponible := BaseImponible;
          SubcuentaFamilia.CuotaIVA := CuotaIVA;
          SubcuentaFamilia.CuotaRE := CuotaRE;

          PilaSubcuentas.Add( SubcuentaFamilia );
          end;

end;

{ TFacturaVentasService }

procedure TFacturaVentasService.AssignSession(const SessionID: Integer);
begin
     FSessionDataModule := GetSessionDataModule( SessionID );
end;

function TFacturaVentasService.ProximoNroFactura( Serie: String; RegistrarValor: Boolean): LongInt;
begin
     Result := SessionDataModule.Dm30.FacturaVentasModule.ProximoNroFactura( Serie, RegistrarValor );
end;

function TFacturaVentasService.ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
begin
     Result := SessionDataModule.Dm30.FacturaVentasModule.ProximoNroRegistroPresentacion( RegistrarValor );
end;

function TFacturaVentasService.RecalculaFactura( FacturaVentas : IFacturaVentas ) : Boolean;
begin
     Result := SessionDataModule.Dm30.FacturaVentasModule.RecalculaFactura( FacturaVentas );
end;

procedure TFacturaVentasService.RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal : LongInt );
begin
     SessionDataModule.Dm30.FacturaVentasModule.RecuperaFacturas( Serie, NroFacturaInicial, NroFacturaFinal );
end;

procedure TFacturaVentasService.SuprimeFactura( Serie : String; NroFactura : LongInt );
begin
     SessionDataModule.Dm30.FacturaVentasModule.SuprimeFactura( Serie, NroFactura );
end;

{
procedure TFacturaVentasService.AnulaFactura( Serie : String; NroFactura : LongInt );
begin
     SessionDataModule.Dm30.FacturaVentasModule.AnulaFactura( Serie, NroFactura );
end;
}

procedure TFacturaVentasService.SuprimeRelaciones( FacturaVentas: IFacturaVentas; SuprimeRegistroFactura: Boolean);
begin
     SessionDataModule.Dm30.FacturaVentasModule.SuprimeRelaciones( FacturaVentas, SuprimeRegistroFactura );
end;

procedure TFacturaVentasService.CierreCicloFacturacion( SerieInicial, SerieFinal: String; FechaInicial, FechaFinal: TDate; Contabilizar: Boolean);
begin
     SessionDataModule.Dm30.FacturaVentasModule.CierreCicloFacturacion( SerieInicial, SerieFinal, FechaInicial, FechaFinal, Contabilizar );
end;

function TFacturaVentasService.GeneraFacturas( ParametrosFacturacion: IParametrosFacturacion; RelacionAlbaranesTableName: String ) : IParametrosFacturacion;
begin
     Result := SessionDataModule.Dm30.FacturaVentasModule.GeneraFacturas( ParametrosFacturacion, RelacionAlbaranesTableName );
end;

function TFacturaVentasService.ObtenBasesyCuotasFactura( Ejercicio          : SmallInt;
                                                         CodigoCliente,
                                                         Serie              : String;
                                                         NroFactura         : LongInt;
                                                         AplicarDtosyPortes : Boolean = False ) : IBasesyCuotasFactura;

var TasasArray : TTasasArray;
    TotalCuotaIVA,
    TotalCuotaRE : Decimal;
    BasesyCuotasFactura : IBasesyCuotasFactura;

begin
     SessionDataModule.Dm30.FacturaVentasModule.ObtenBasesyCuotasFactura( Ejercicio, CodigoCliente, Serie, NroFactura, TasasArray, TotalCuotaIVA, TotalCuotaRE, AplicarDtosyPortes );

     BasesyCuotasFactura := TBasesyCuotasFactura.Create;

     BasesyCuotasFactura.TasasArray := TasasArray;
     BasesyCuotasFactura.TotalCuotaIVA := TotalCuotaIVA;
     BasesyCuotasFactura.TotalCuotaRE := TotalCuotaRE;

     Result := BasesyCuotasFactura;
end;

var  FacturaVentasControl : InxClassFactoryControl;

initialization
   TnxClassFactory.RegisterClass( CLSID_FacturaVentasService, TFacturaVentasService, FacturaVentasControl );
end.
