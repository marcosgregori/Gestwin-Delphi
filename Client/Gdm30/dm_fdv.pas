unit dm_fdv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, nxdb,

  LibUtils,
  AppForms,
  Spring,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  AppManager,
  ReportManager,
  DataManager,

  frxNXComponents,

  f_sfv,

  dmi_iex,
  dmi_fdv,

  FacturaVentasIntf,
  ParametrosFacturacionIntf;

type
  {

  Tipos de seleccion : tsDocumento         solo permite facturar un albarán (nroDocumento)
                       tsPropietarioFecha  por propietario y Fecha
                       tsRelacion          la seleccion de albaranes ya existe en RelacionAlbaranesTable
  }

  TSuprimeRelacionesFacturaEvent = procedure( FacturaVentasFields : TFacturaVentasFields ) of object;
  TInsertLineEvent = procedure( ContabilizarPorCliente : Boolean; TipoIVAArticulo, TipoIVADefectoManual : SmallInt; ArticuloFields : TArticuloFields; GrupoClienteFields : TGrupoClienteFields; MovimientoFields : TMovimientoFields;LineaMovimientoFields : TLineaMovimientoFields ) of object;
  TFirmaFacturaEvent = procedure( TipoFichero : TTipoFicheroExportacion; var PathFichero : String ) of object;
  TRegistroFacturaElectronicaCreadaEvent = procedure( Tipo : TTipoRegistroFacturaElectronica; Propietario, Serie : String; NroFactura : Integer; NIFPropietario : String; FechaDocumento : TDate; Importe : Decimal ) of object;
  TCalculaImportes = procedure ( LineaMovimientoFields : TLineaMovimientoFields; ArticuloFields : TArticuloFields ) of object;

  TOnGeneraRegistroProcedure = reference to procedure( FacturaVentasFields : TFacturaVentasFields );

  TFacturaVentasModule = class(TDataModule)
    DmEfectoTable: TnxeTable;
    DmClienteTable: TnxeTable;
    DmClienteDatEconTable: TnxeTable;
    DmSerieFacturacionTable: TnxeTable;
    DmVendedorTable: TnxeTable;
    DmFormaCobroTable: TnxeTable;
    Report: TgxReportManager;
    DmVendedorDatEconTable: TnxeTable;
    DmArticuloDatEconTable: TnxeTable;
    DmFacturaVentasAuxTable: TnxeTable;
    DmFacturaVentasTable: TnxeTable;
    DmMovimientoTable: TnxeTable;
    DmLineaMovimientoTable: TnxeTable;
    AlbaranesFacturaQuery: TnxeQuery;
    DmMovimientoAuxTable: TnxeTable;
    DmGrupoLineaMovimientoTable: TnxeTable;
    DmArticuloTable: TnxeTable;
    DmTiposIVAArticuloPaisTable: TnxeTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ReportSetReportName;
    procedure ReportSelectPrinter;
  private

    FacturaVentasService : IFacturaVentasService;

    RelacionAlbaranesFields : TRelacionAlbaranesFields;

    SerieActualContador : String;

    ExisteVendedorAlbaran,
    ComprobarFormaCobro       : Boolean;

    ImporteCuotaIVA,
    ImporteCuotaRE,
    ImporteRecFinancRetencion,
    SumaCoste,
    SumaBruto,
    SumaNeto,
    SumaNetoRetencion,
    SumaDtosClienteRetencion,
    SumaIVAIncluido,
    SumaComision,

    ImporteDtoESRetencion,
    ImporteDtoPPRetencion,

    SumaDtosArticulo,
    SumaDtosCliente : Decimal;

    CosteLinea,
    TotalAlbaran : Decimal;

    CodigoActual,
    CodigoClienteActual,
    CodigoGrupoClienteActual,
    CodigoVendedorActual,
    CodigoRegAuxiliarActual : String;

    PrimerAlbaran : Boolean;

    FormatoImpreso : SmallInt;  // Actualizado por Imprimefacturas para que pueda ser utilizado por el Report

    TipoComision : Decimal;

    EMailSubjectTemplate,       // Es global porque se debe intentar generar una única vez
    EMailSubjectText,
    AlmacenDocumentosPath,
    PathFicheroAlmacen : String;

    FUsarCalculoDecimalesMagento : Boolean;   // Solo se usa en el módulo de Magento, evidentemente

    FOnCalculaImportes : Event<TCalculaImportes>;
    FOnFirmaFactura : Event<TFirmaFacturaEvent>;
    FOnRegistroFacturaElectronicaCreada : Event<TRegistroFacturaElectronicaCreadaEvent>;

    procedure AplicaCondicionesCobro( FacturaVentasFields : TFacturaVentasFields; AplicarDescuentoyRecargo : Boolean = True );
    procedure InicializaImpresion;
    procedure GeneraRegistrosImpresion;
    procedure ExportaFichero;
    procedure ImprimeOExportaFicheroFacturas;
    function  ExisteNroFactura( ValorActual : LongInt ) : Boolean;
    function SeleccionFactura( ParametrosFacturacion : IParametrosFacturacion ) : Boolean;

  public

    DmFacturaVentasFields,
    DmFacturaVentasAuxFields : TFacturaVentasFields;
    DmEfectoFields : TEfectoFields;
    DmMovimientoFields,
    DmMovimientoAuxFields : TMovimientoFields;
    DmGrupoLineaMovimientoFields : TGrupoLineaMovimientoFields;
    DmLineaMovimientoFields : TLineaMovimientoFields;
    DmClienteFields : TClienteFields;
    DmVendedorFields : TVendedorFields;
    DmArticuloFields : TArticuloFields;
    DmClienteDatEconFields : TClienteDatEconFields;
    DmFormaCobroFields : TFormaCobroFields;
    DmSerieFacturacionFields : TSerieFacturacionFields;
    DmVendedorDatEconFields : TVendedorDatEconFields;
    DmArticuloDatEconFields : TArticuloDatEconFields;
    DmTiposIVAArticuloPaisFields : TTiposIVAArticuloPaisFields;

    DsTiposIVAFields : TTiposIVAFields;
    DsTiposRetencionFields : TTiposIVAFields;
    DsDivisaFields : TDivisaFields;

    FrxCabeceraTable,
    FrxLineasTable : TfrxNxTable;

    RptCabeceraTable,
    RptGrupoLineasTable,
    RptLineasTable : TnxeTable;

    RptCabeceraFields : TCabeceraFields;
    RptCabeceraAuxiliarFields : TCabeceraAuxiliarFields;
    RptGrupoLineasFields : TGrupoLineasFields;
    RptLineasFields : TLineasFields;

    AlbaranesFacturaFields : TMovimientoFields;

    FParametrosFacturacion : IParametrosFacturacion;
    FSeleccionFacturasFrame : TSfvFrame;

    RelacionEfectos : TRelacionEfectos;

    NroTotalCopias,
    NroOperacionActual : LongInt;

    CalcularIVA,
    ContabilizarPorCliente : Boolean;
    TipoIVADefectoManual : SmallInt;

    PaisDeudor,
    BICDeudor,
    CodigoIBAN : String;

    function Obten( Ejercicio : SmallInt; Serie : String; NroFactura : LongInt; FacturaVentasFields : TFacturaVentasFields = nil ) : Boolean;
    // function ObtenRegistroAnterior( NroRegistro : LongInt; FacturaVentasFields : TFacturaVentasFields ) : Boolean;

    procedure RetiraNroFactura( FacturaVentasFields : TFacturaVentasFields; CompruebaEstado : Boolean = True );

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

    procedure CalculaImportes( CantidadAjustada      : TBCDField;
                               UnidadesPorPrecio     : TIntegerField;
                               PrecioField           : TFloatField;
                               PuntoVerdeField,
                               ContribucionRAPField,
                               RecargoField,
                               DescuentoField,
                               ImporteBrutoField,
                               ImporteDescuentoField : TBCDField;
                               ImporteNetoField      : TBCDField ); overload;

    procedure CalculaImportesIVA( MovimientoFields       : TMovimientoFields;
                                  LineaMovimientoFields  : TLineaMovimientoFields;
                                  ClienteFields          : TClienteFields;
                                  ArticuloFields         : TArticuloFields;
                                  SerieFacturacionFields : TSerieFacturacionFields;
                                  TiposIVAFields         : TTiposIVAFields );

    function  DesgloseIVA( LineaDesglose, Opcion : SmallInt; var TasasArray : TTasasArray ) : Decimal;
    procedure FijaDecimalesInforme( Report : TgxReportManager );
    function  ObtenTipoIVAArticulo( Fecha : TDate; ArticuloFields : TArticuloFields; TiposIVAFields : TTiposIVAFields = nil; SerieFacturacionFields : TSerieFacturacionFields = nil; ClienteFields : TClienteFields = nil ) : SmallInt;
    procedure ObtenCuotasPortes( Importe : Decimal; Fecha : TDate; ModeloIVA : SmallInt; var CuotaIVA : Decimal; var CuotaRE : Decimal );
    procedure AcumulaValoresImpositivos( var TasasArray: TTasasArray; Fecha: TDate; ModeloIVA: SmallInt; CalcularIVA: Boolean; var Sumas: TTasaRecord);

    procedure FijaParametrosFacturacion( ParametrosFacturacion : IParametrosFacturacion );
    procedure ImprimeFacturas( ParametrosFacturacion : IParametrosFacturacion; SeleccionFacturasFrame : TSfvFrame = nil );
    procedure GeneraRelacionFacturas( ParametrosFacturacion : IParametrosFacturacion; OnGeneraRegistro : TOnGeneraRegistroProcedure );
    procedure EnviaFacturaPorCorreo( TipoDatos : TTipoDatosExportados; ExportFileName : String ); overload;

    // FacturaVentasService

    procedure SuprimeFactura( Serie : String; NroFactura : LongInt );
    // procedure AnulaFactura( Serie : String; NroFactura : LongInt );
    function  ProximoNroFactura( Serie : String; RegistrarValor : Boolean = True ) : LongInt;
    function  ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
    function  ObtenUltimoRegistroPresentacion( FacturaVentasFields : TFacturaVentasFields ) : Boolean;

    procedure ObtenBasesyCuotasFactura(    Ejercicio         : SmallInt;
                                           CodigoCliente,
                                           Serie             : String;
                                           NroFactura        : LongInt;
                                       var TasasArray        : TTasasArray;
                                       out TotalCuotaIVA     : Decimal;
                                       out TotalCuotaRE      : Decimal;
                                          AplicarDtosyPortes : Boolean = False );

    procedure SuprimeRelaciones( FacturaVentasFields : TFacturaVentasFields; SuprimeRegistroFactura : Boolean = True );
    procedure CierreCicloFacturacion( SerieInicial, SerieFinal : String; FechaInicial, FechaFinal: TDate; Contabilizar : Boolean );
    procedure RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal  : LongInt );
    function RecalculaFactura( FacturaVentasFields : TFacturaVentasFields; RecuperaCliente : Boolean ) : Boolean;
    function  GeneraFacturas( ParametrosFacturacion : IParametrosFacturacion; RelacionAlbaranesTable : TnxeTable = nil ) : IParametrosFacturacion;

    //

    property UsarCalculoDecimalesMagento : Boolean write FUsarCalculoDecimalesMagento;

    property OnCalculaImportes : Event<TCalculaImportes> read FOnCalculaImportes write FOnCalculaImportes;
    property OnFirmaFactura : Event<TFirmaFacturaEvent> read FOnFirmaFactura write FOnFirmaFactura;
    property OnRegistroFacturaElectronicaCreada : Event<TRegistroFacturaElectronicaCreadaEvent> read FOnRegistroFacturaElectronicaCreada write FOnRegistroFacturaElectronicaCreada;

  end;

var  FacturaVentasModule : TFacturaVentasModule = nil;

function FacturaVentas : TFacturaVentasModule;

const  FmtCantidadVenta   = 'FmtCantidadVenta';
       FmtPrecioVenta     = 'FmtPrecioVenta';
       FmtDescuentoVenta  = 'FmtDescuentoVenta';

       ncrMostrarAnotacionesVentas  = 'MostrarAnotacionesVentas';
       ncrMostrarAnotacionesVentasPeriodicas  = 'MostrarAnotacionesVentasPeriodicas';

implementation

uses cxEdit,

     DateUtils,

     Files,
     AppContainer,
     EnterpriseDataAccess,
     NexusRpcData,

     clTranslator,

     nxsdTypes,
     Gdm00Dm,
     Gdm30Dm,

     SistemaFacturacion,

     dmi_cnd,
     dmi_iva,
     dmi_mov,
     dmi_fac,

     dm_ven,
     dm_emp,
     dm_efe,
     dm_cli,
     dm_rcl,
     dm_iva,
     dm_pga,
     dm_tma,
     dm_art,
     dm_sto,
     dm_ecc,
     dm_fco,
     dm_cdi,
     dm_tca,
     dm_cls,
     dm_ine,
     dm_gdc,
     dm_mov,
     dm_sdf,
     dm_iex,
     dm_cnd,
     dm_fac,
     dm_ddc,
     dm_dco,
     dm_rpf,
     dm_suf,

     b_msg,
     b_pro,
     f_prg;

{$R *.DFM}

resourceString

     RsMsg9  = 'La forma de cobro %s ha sido dada de baja.';
     RsMsg10 = 'No he conseguido recuperar la ficha del cliente %s.';
     //..
     RsMsg12 = 'Impresión de facturas de venta.';
     RsMsg13 = 'No se ha podido presentar en el portal de Veri*factu la factura nº %s %d.';
     RsMsg14 = 'Recuerde que [B][Color=Red]debe realizar la presentación lo antes posible desde el punto de suministro de facturas Veri*factu[/Color][/B] de la aplicación.';

     RsMsg16 = 'La factura nº %d, del cliente %s - %s no ha sido enviada por correo porque no cumple los requisitos indicados.';
     RsMsg17 = 'La numeración de las facturas suministradas no es correlativa.';
     RsMsg18 = 'La factura que pretende emitir es la %s %d y la última era la %d.'#13'Corrija el error y reintente el proceso cuando lo considere oportuno';
     RsMsg23 = 'Factura nº %s %d, del cliente %s - %s.';
     RsMsg24 = 'Generando los registros de impresión de las facturas.';
     RsMsg25 = 'Generación y exportación de ficheros de facturación.';
     // RsMsg26 = 'Realizando el envío de facturas de venta por correo.';
     RsMsg27 = 'Generando el fichero de exportación de la factura.';
     RsMsg28 = 'Enviando la factura por e-mail (correo).';
     RsMsg29 = 'Envío N/Factura nro. %s %d de fecha %s.';
     RsMsg30 = #13'Estimado cliente :'#13#13'Le adjuntamos copia de nuestra factura %s %d del ejercicio %d.'#13#13'Sin otro particular, le saludamos atentamente.'#13#13'%s'#13#13;
     // RsMsg31 = 'Cliente %s.';
     RsMsg32 = 'Ha ocurrido un problema al enviar el impreso por E-mail.';
     RsMsg33 = 'Revise la configuración del correo y/o la conexión a Internet y reintente el proceso.';
     RsMsg34 = 'Ha ocurrido un error al intentar recuperar la factura %s %d.';
     RsMsg35 = 'Albarán nº %d.';
     RsMsg37 = 'No se ha podido guardar la fecha de envío de la factura %s %d.';
     RsMsg38 = 'Es posible que esté siendo editada por otro usuario. El proceso de emisión continúa.';
     RsMsg39 = 'Creando el documento y guardando una copia.';
     RsMsg40 = 'Se ha enviado la factura nº %s %d por correo a su/s destinatario/s.';
     RsMsg41 = 'Se ha producido un error al intentar generar el fichero de la factura.';
     RsMsg42 = 'Periodos impositivos distintos.';
     RsMsg43 = 'El albarán %s %d, pertenece a un periodo impositivo distinto al de la fecha de facturación.'#13'Si ha emitido albaranes mostrando los importes con I.V.A. incluído, éstos no coincidirán con los de la factura.';
     RsMsg44 = 'Ha ocurrido un error al reconstruir los resultados de la factura %s %d.';
     RsMsg45 = 'Mensaje del sistema : ';
     RsMsg46 = 'Exportando en la carpeta : %s.';
     RsMsg47 = 'No se ha podido crear o copiar el fichero al almacén de documentos.';
     RsMsg48 = 'Se cancela la generación y firma de documentos.'#13'Verifique que tiene acceso al directorio de documentos [B]%s[/B] y reintente el proceso.';
     RsMsg49 = 'Creado el fichero [URL=%s]%s[/URL].';
     RsMsg50 = 'Creada la factura nº %s %d del cliente %s, %s.';
     RsMsg51 = 'El %s nº %s %d está siendo editado por otro usuario.';
     RsMsg52 = 'Este documento está relacionado con la factura que pretende suprimir y es necesario que esté libre para poder modificarlo.';

function FacturaVentas : TFacturaVentasModule;
begin
     CreateDataModule( TFacturaVentasModule, FacturaVentasModule );
     Result := FacturaVentasModule;
end;

procedure TFacturaVentasModule.DataModuleCreate(Sender: TObject);
begin

     NexusRpc.CreateRemoteInstance( CLSID_FacturaVentasService, IFacturaVentasService, FacturaVentasService );

     DmFacturaVentasFields := TFacturaVentasFields.Create( DmFacturaVentasTable );
     DmFacturaVentasAuxFields := TFacturaVentasFields.Create( DmFacturaVentasAuxTable );
     DmEfectoFields := TEfectoFields.Create( DmEfectoTable );
     DmMovimientoFields := TMovimientoFields.Create( DmMovimientoTable );
     DmMovimientoAuxFields := TMovimientoFields.Create( DmMovimientoAuxTable );
     DmGrupoLineaMovimientoFields := TGrupoLineaMovimientoFields.Create( DmGrupoLineaMovimientoTable );
     DmLineaMovimientoFields := TLineaMovimientoFields.Create( DmLineaMovimientoTable );
     DmClienteFields := TClienteFields.Create( DmClienteTable );
     DmClienteDatEconFields := TClienteDatEconFields.Create( DmClienteDatEconTable );
     DmVendedorFields := TVendedorFields.Create( DmVendedorTable );
     DmArticuloFields := TArticuloFields.Create( DmArticuloTable, True );
     DmFormaCobroFields := TFormaCobroFields.Create( DmFormaCobroTable );
     DmSerieFacturacionFields := TSerieFacturacionFields.Create( DmSerieFacturacionTable );
     DmVendedorDatEconFields := TVendedorDatEconFields.Create( DmVendedorDatEconTable );
     DmArticuloDatEconFields := TArticuloDatEconFields.Create( DmArticuloDatEconTable );
     DmTiposIVAArticuloPaisFields := TTiposIVAArticuloPaisFields.Create( DmTiposIVAArticuloPaisTable );

     DsTiposIVAFields := TTiposIVAFields.Create( Self );
     DsTiposRetencionFields := TTiposIVAFields.Create( Self );
     DsDivisaFields := TDivisaFields.Create( Self );

     ExecComponentProcedures( idFacturaVentasModule, imOnCreateComponent );

end;

procedure TFacturaVentasModule.DataModuleDestroy(Sender: TObject);
begin
     FacturaVentasModule := nil;
end;

function TFacturaVentasModule.Obten( Ejercicio           : SmallInt;
                                     Serie               : String;
                                     NroFactura          : LongInt;
                                     FacturaVentasFields : TFacturaVentasFields = nil ) : Boolean;

begin
     With DmFacturaVentasAuxTable do
       begin
       IndexFieldNames := 'Ejercicio;Serie;NroFactura';
       Result := FindKey( [ Ejercicio, Serie, NroFactura ] )
       end;
     If   Assigned( FacturaVentasFields )
     then FacturaVentasFields.Update( DmFacturaVentasAuxTable );
end;

{
function TFacturaVentasModule.ObtenRegistroAnterior( NroRegistro         : LongInt;
                                                     FacturaVentasFields : TFacturaVentasFields ) : Boolean;
begin
     With DmFacturaVentasTable do
       begin
       IndexFieldNames := 'Ejercicio;NroRegistro';
       Result := FindSmaller( [ ApplicationContainer.Ejercicio, NroRegistro ] ) and ( DmFacturaVentasFields.NroRegistro.Value<>0 );
       end;
     FacturaVentasFields.Update( DmFacturaVentasTable );
end;
}

function TFacturaVentasModule.ObtenTipoIVAArticulo( Fecha                  : TDate;
                                                    ArticuloFields         : TArticuloFields;
                                                    TiposIVAFields         : TTiposIVAFields = nil;
                                                    SerieFacturacionFields : TSerieFacturacionFields = nil;
                                                    ClienteFields          : TClienteFields = nil ) : SmallInt;
var  CodigoPaisIVA : String;

begin

     CodigoPaisIVA := CodigoEspaña;
	    If   Assigned( ClienteFields )
     then If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
          then CodigoPaisIVA := ClienteFields.CodigoPais.Value;

     If   ArticuloFields.Codigo.IsNull   // Es un registro de artículo manual o vacío
     then Result := Tasa.TipoIVAGlobal( Fecha, CodigoPaisIVA, rgTipoIVAManual )
     else Result := ArticuloFields.TipoIVA.Value;

     If   Assigned( SerieFacturacionFields ) and SerieFacturacionFields.Initialized and SerieFacturacionFields.ExentoIVA.Value
     then Result := 0  // Exento
     else If   Assigned( ClienteFields ) and ClienteFields.Initialized
          then If   ClienteFields.Factura_ModeloIVA.Value=micExento
               then Result := 0  // Exento
               else If   ( ClienteFields.Factura_ModeloIVA.Value=micTipoFijo ) and not ArticuloFields.NoAplicarTipoFijo.Value
                    then Result := ClienteFields.Factura_TipoFijoIVA.Value
                         else If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
                              then If   DmTiposIVAArticuloPaisTable.FindKey( [ ArticuloFields.Codigo.Value, CodigoPaisIVA ] )
                                   then Result := DmTiposIVAArticuloPaisFields.TipoIVA.Value;

     If   Assigned( TiposIVAFields )
     then Tasa.TipoIVA( Fecha, CodigoPaisIVA, Result, TiposIVAFields );

end;

procedure TFacturaVentasModule.RetiraNroFactura( FacturaVentasFields : TFacturaVentasFields;
                                                 CompruebaEstado     : Boolean = True );
begin
     If   Assigned( FacturaVentasFields )
     then With FacturaVentasFields do
            If   Dataset is TnxeTable
            then With TnxeTable( Dataset ) do
                   If   not CompruebaEstado or ( not InternalProcess and not ( State in [ dsEdit, dsInsert ] ) and ( PreviousState in [ dsEdit, dsInsert ] ) )
                   then Contadores.RetiraValor( cnFacturaVentas, ApplicationContainer.Ejercicio, Serie.Value, NroFactura.Value );
end;

function TFacturaVentasModule.ExisteNroFactura( ValorActual : LongInt ) : Boolean;
begin
     DmFacturaVentasAuxTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
     Result := DmFacturaVentasAuxTable.FindKey( [ ApplicationContainer.Ejercicio, SerieActualContador, ValorActual ] );
end;

function TFacturaVentasModule.DesgloseIVA(     LineaDesglose,
                                               Opcion         : SmallInt;
                                           var TasasArray     : TTasasArray ) : Decimal;

var   Index1,
      Index2 : Byte;

begin
     Result := 0.0;
     Index1 := 0;
     Index2 := 1;
     While ( Index1<=NroMaximoTiposTasas ) do
       begin
       If   TasasArray[ Index1 ].BaseImponible<>0.0
       then begin
            If   Index2=LineaDesglose
            then begin
                 case Opcion of
                   1 : Result := TasasArray[ Index1 ].BaseImponible;
                   2 : Result := TasasArray[ Index1 ].TipoIVA;
                   3 : Result := TasasArray[ Index1 ].CuotaIVA;
                   4 : If   TasasArray[ Index1 ].CuotaRE<>0.0
                       then Result := TasasArray[ Index1 ].TipoRE;
                   5 : Result := TasasArray[ Index1 ].CuotaRE;
                   6 : Result := TasasArray[ Index1 ].Importe;
                   end;
                 Exit;
                 end;
            Inc( Index2 );
            end;
       Inc( Index1 );
       end;
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

          If   DataModule00.DmEmpresaFields.Articulo_UnidadesPorPrecio.Value and ( UnidadesPorPrecio>0 )
          then CantidadAjustada := CantidadAjustada / UnidadesPorPrecio;

          ImporteBruto := CantidadAjustada * ( Precio + PuntoVerde + Recargo );

          If   DataModule00.DmEmpresaFields.Articulo_ContribucionRAPRepercutida.Value
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

procedure TFacturaVentasModule.CalculaImportes( CantidadAjustada      : TBCDField;
                                                UnidadesPorPrecio     : TIntegerField;
                                                PrecioField           : TFloatField;
                                                PuntoVerdeField,
                                                ContribucionRAPField,
                                                RecargoField,
                                                DescuentoField,
                                                ImporteBrutoField,
                                                ImporteDescuentoField : TBCDField;
                                                ImporteNetoField      : TBCDField );
var  ImporteBrutoLinea,
     ImporteDescuentoLinea,
     ImporteNetoLinea,
     PuntoVerde,
     ContribucionRAP : Decimal;

begin

     If   Assigned( PuntoVerdeField )
     then PuntoVerde := PuntoVerdeField.Value
     else PuntoVerde := 0.0;

     If   Assigned( ContribucionRAPField )
     then ContribucionRAP := ContribucionRAPField.Value
     else ContribucionRAP := 0.0;

     CalculaImportes( CantidadAjustada.Value,
                      UnidadesPorPrecio.Value,
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

procedure TFacturaVentasModule.CalculaImportesIVA(  MovimientoFields       : TMovimientoFields;
                                                    LineaMovimientoFields  : TLineaMovimientoFields;
                                                    ClienteFields          : TClienteFields;
                                                    ArticuloFields         : TArticuloFields;
                                                    SerieFacturacionFields : TSerieFacturacionFields;
                                                    TiposIVAFields         : TTiposIVAFields );
var  AplicarIVA,
     AplicarRE : Boolean;
     DecimalesImportesCuotas : SmallInt;

begin

     // No redondeo de momento los importes para poder utilizar los valores en el cálculo del I.V.A.

     CalculaImportes( LineaMovimientoFields, ArticuloFields );

     With LineaMovimientoFields do
       begin

       If   DataModule00.DmEmpresaFields.Ventas_TiposIVAModificables.Value and
            not LineaMovimientoFields.CodigoTipoIVA.IsNull  // Todavía no se ha fijado el valor por defecto
       then begin
            var CodigoPaisIVA := CodigoEspaña;
            var NroRegistroIVA := LineaMovimientoFields.CodigoTipoIVA.Value;
	           If   Assigned( ClienteFields ) and ClienteFields.Initialized
            then If   ClienteFields.Factura_ModeloIVA.Value=micVentasOnline
                 then CodigoPaisIVA := ClienteFields.CodigoPais.Value;
            Tasa.TipoIVA( LineaMovimientoFields.Fecha.Value, CodigoPaisIVA, NroRegistroIVA, TiposIVAFields );
            end
       else begin
            ObtenTipoIVAArticulo( Fecha.Value, ArticuloFields, TiposIVAFields, SerieFacturacionFields, ClienteFields );
            CodigoTipoIVA.Value := 0;
            end;

       PrecioIVA.Value := Redondea( Precio.Value );
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

       If   MovimientoFields.IVAIncluido.Value or FUsarCalculoDecimalesMagento
       then DecimalesImportesCuotas := 2
       else DecimalesImportesCuotas := 4;

       If   AplicarIVA
       then begin
            CodigoTipoIVA.Value := TiposIVAFields.Codigo.Value;
            CuotaIVA.Value := Redondea( ImporteNeto.Value * TiposIVAFields.IVARepercutido.Value / 100.0, DecimalesImportesCuotas  );
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

       If   MovimientoFields.IVAIncluido.Value and ( CuotaIVA.Value<>0.0 ) and ( CantidadAjustada.Value<>0.0 )
       then begin

            var CantidadAjustadaIVA := CantidadAjustada.Value;

            If   DataModule00.DmEmpresaFields.Articulo_UnidadesPorPrecio.Value and ( ArticuloFields.UnidadesPrecioVenta.Value>0 )
            then CantidadAjustadaIVA := CantidadAjustadaIVA / ArticuloFields.UnidadesPrecioVenta.Value;

            var ImporteBrutoIVA := CantidadAjustadaIVA * ( PrecioIVA.Value + PuntoVerde.Value + Recargo.Value );

            If   DataModule00.DmEmpresaFields.Articulo_ContribucionRAPRepercutida.Value
            then ImporteBrutoIVA := ImporteBrutoIVA + ContribucionRAP.Value;

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

     If   not DmFormaCobroTable.FindKey( [ FacturaVentasFields.CodigoFormaCobro.Value ] )
     then begin
          ShowNotification( ntStop, Format( RsMsg9, [ FacturaVentasFields.CodigoFormaCobro.Value ] ) );
          Abort;
          end;

     //* 3.12.1999 Añadidos los dias de cobro en el registro de formas de cobro

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

procedure TFacturaVentasModule.ObtenCuotasPortes(     Importe   : Decimal;
                                                      Fecha     : TDate;
                                                      ModeloIVA : SmallInt;
                                                  var CuotaIVA  : Decimal;
                                                  var CuotaRE   : Decimal );

var  PorcentajeIVA : Decimal;

begin
     CuotaIVA := 0.0;
     CuotaRE := 0.0;
     If   not ( ( ModeloIVA=micExento ) or ( Importe=0.0 ) )
     then begin
          Tasa.TipoIVA( Fecha, Tasa.TipoIVAGlobal( Fecha, rgTipoIVAPortes ), DsTiposIVAFields );
          CuotaIVA := Redondea( ( Importe * DsTiposIVAFields.IVARepercutido.Value ) / 100.0 );
          If   ModeloIVA=micConRE
          then CuotaRE := Redondea( ( Importe * DsTiposIVAFields.RERepercutido.Value ) / 100.0 );
          end;
end;

procedure TFacturaVentasModule.InicializaImpresion;
begin
     With Report do
       begin

       FrxCabeceraTable := CreateEmptyReportTable( 'Cabecera', DataModule30.SQLSet, tsServerSide, { OpenTable } False );
       RptCabeceraTable := FrxCabeceraTable.Table;

       // Reasigno el tipo de la base de datos porque ha cambiado de dsTemporal a dsServerTemporal

       If   Assigned( FrxCabeceraTable.Database )
       then FrxCabeceraTable.Database.DatabaseSource := dsServerTemporal;

       RptCabeceraTable.Open;

       RptCabeceraFields := TCabeceraFields.Create( RptCabeceraTable );

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
       // No se puede comprobar la lista de índices existentes porque para eso hay que abrir la tabla y si no existe, error al canto.

       If   ( FrxLineasTable.IndexFieldNames<>'NroOperacion' ) and
            ( FrxLineasTable.IndexFieldNames<>'NroOperacion;NroPagina;NroLinea' ) and
            ( FrxLineasTable.IndexFieldNames<>'EjercicioDocumento;NroOperacion;NroRegistro' ) and
            ( FrxLineasTable.IndexFieldNames<>'NroRegistroDoc' ) and
            ( FrxLineasTable.IndexFieldNames<>'NroOperacion;NroOperacionDoc;NroPagina' )  // Son los índices que ya existen en el impreso
       then begin
            var IFN := FrxLineasTable.IndexFieldNames;
            RptLineasTable.IndexFieldNames := '';
            RptLineasTable.AddIndex( 'I1', IFN, [] );
            RptLineasTable.IndexFieldNames := IFN;
            end;

       RptLineasTable.Open;
       RptLineasFields := TLineasFields.Create( RptLineasTable );

       SetValue( RsPartidasPresupuestarias, DataModule00.PartidasPresupuestarias );

       MainDataSet := RptCabeceraTable;

       OpenReportTables;
       end;
end;

procedure TFacturaVentasModule.GeneraRegistrosImpresion;

var  I,
     Index : SmallInt;
     ImporteDescuentos,
     ImporteBaseDescuentos : Decimal;
     RecordFieldValues : TFieldValuesArray;
     TipoIVAArticulo : SmallInt;
     TasasArray : TTasasArray;
     ImporteIVAPortes,
     ImporteREPortes : Decimal;
     TipoDeCambio : Double;
     CodigoPaisIVA : String;
     EstadoPresentacion : TEstadoPresentacionVerifactu;
     EstadoRegistro : TEstadoRegistroVerifactu;

const PrefijoValidacionQR = 'https://www2.agenciatributaria.gob.es/wlpl/TIKE-CONT/ValidarQR?';
      PrefijoValidacionQRPruebas = 'https://prewww2.aeat.es/wlpl/TIKE-CONT/ValidarQR?';

function CodificarQR( Prefijo, NIF, NumSerie, Fecha, Importe : String ) : String;
begin
     Result := Prefijo +
               'nif=' + StrToHTML( NIF ) + '&' +
               'numserie=' + StrToHTML( NumSerie ) + '&' +
               'fecha=' + StrToHTML( Fecha ) + '&' +
               'importe=' + StrToHTML( Importe );
end;

begin

     try

       // Veri*factu

       If   EntornoVerifactu
       then begin

            RegistroPresentacion.ObtenEstadoPresentacionVerifactu( DmFacturaVentasFields.Serie.Value,
                                                                   DmFacturaVentasFields.NroFactura.Value,
                                                                   EstadoPresentacion,
                                                                   EstadoRegistro );

            If   EstadoPresentacion=epvPendiente
            then With SuministroFacturas do
                   try
                      var UltimoNroFactura : LongInt := 0;
                      If   RegistroPresentacion.ObtenUltimoNroFacturaVerifactu( DmFacturaVentasFields.Serie.Value, UltimoNroFactura )
                      then If   UltimoNroFactura<>DmFacturaVentasFields.NroFactura.Value - 1
                           then begin
                                ShowNotification( ntError,
                                                  RsMsg17,
                                                  Format( RsMsg18, [  DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value, UltimoNroFactura ] ),
                                                  '',
                                                  { ForceBoxMsg } True );
                                If   Assigned( ProcessFrame )
                                then ProcessFrame.Error := True;
                                Exit;
                                end;

                     ConfiguraSuministro;

                     var RegistroSuministroFactura := ObtenRegistroSuministroFactura( DmFacturaVentasFields.Serie.Value,
                                                                                      DmFacturaVentasFields.NroFactura.Value,
                                                                                      EstadoPresentacion,
                                                                                      EstadoRegistro );
                     If   Assigned( RegistroSuministroFactura )
                     then SuministraFacturas( [ RegistroSuministroFactura ] )
                     else Abort;

                   except on E : Exception do
                     begin

                      InvalidaUltimoRegistroPresentacionFactura;

                     // De momento permito que se imprima aunque no se haya podido presentar (siempre que se haya generado correctamente el registro y el problema sea solo de presentación)

                     var ExceptionMessage := '';
                     If   not( E is EAbort )
                     then ExceptionMessage := E.Message;

                     If   not ProcessFrame.Error
                     then ShowNotification( ntWarning,
                                            Format( RsMsg13, [  DmFacturaVentasFields.Serie.Value, DmFacturaVentasFields.NroFactura.Value ] ),
                                            RsMsg14,
                                            ExceptionMessage,
                                            { ForceBoxMsg } True );
                     // Abort;
                     end;

                   end;
            end;

       ProcessFrame.AddMsg( ntInformation, Format( RsMsg23, [ DmFacturaVentasFields.Serie.Value,
                                                              DmFacturaVentasFields.NroFactura.Value,
                                                              DmClienteFields.Codigo.Value,
                                                              DmClienteFields.Nombre.Value ] ) );

       RptCabeceraTable.Append;

       With RptCabeceraFields do
         begin

         Movimiento.InicializaValoresImpositivos( TasasArray );

         Ejercicio.Value := DmFacturaVentasFields.Ejercicio.Value;
         Serie.Value := DmFacturaVentasFields.Serie.Value;
         NroDocumento.Value := DmFacturaVentasFields.NroFactura.Value;
         FechaDocumento.Value := DmFacturaVentasFields.Fecha.Value;
         Fecha1.Value := DmFacturaVentasFields.FechaValor.Value;

         CodigoPropietario.Value := DmFacturaVentasFields.CodigoCliente.Value;
         CodigoVendedor.Value := DmFacturaVentasFields.CodigoVendedor.Value;
         CodigoFormaPago.Value := DmFacturaVentasFields.CodigoFormaCobro.Value;
         CodigoRegAuxiliar.Value := DmFacturaVentasFields.RegistroAuxiliar.Value;
         CodigoGrupo.Value := DmFacturaVentasFields.GrupoFacturacion.Value;

         OrganismoPublico.Value := DmFacturaVentasFields.OrganismoPublico.Value;
         OrganoProponente.Value := DmFacturaVentasFields.OrganoProponente.Value;
         NumeroExpediente.Value := DmFacturaVentasFields.NumeroExpediente.Value;
         NumeroContrato.Value := DmFacturaVentasFields.NumeroContrato.Value;
         ReferenciaOperacion.Value := DmFacturaVentasFields.ReferenciaOperacion.Value;
         ServicioPrestadoTemporalmente.Value := DmFacturaVentasFields.ServicioPrestadoTemporalmente.Value;
         InicioPeriodoFacturacion.Value := DmFacturaVentasFields.InicioPeriodoFacturacion.Value;
         FinPeriodoFacturacion.Value := DmFacturaVentasFields.FinPeriodoFacturacion.Value;

         Subvencionada.Value := DmFacturaVentasFields.Subvencionada.Value;
         ImporteSubvencion.Value := DmFacturaVentasFields.ImporteSubvencion.Value;

         Cliente.ObtenCodigosPaisBICeIBAN( DmClienteFields, PaisDeudor, BICDeudor, CodigoIBAN );
         CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( DmClienteFields );

         If   DmFacturaVentasFields.CodigoFormaCobro.Value<>''
         then FormaCobro.Obten( DmFacturaVentasFields.CodigoFormaCobro.Value, DmFormaCobroFields, True );

         CalcularIVA := DmClienteFields.Factura_ModeloIVA.Value<>micExento;
         If   SerieFacturacion.Obten( DmFacturaVentasFields.Serie.Value, DmSerieFacturacionFields, True )
         then CalcularIVA := CalcularIVA and not DmSerieFacturacionFields.ExentoIVA.Value;
         CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( DmClienteFields );

         DescripcionFormaPago.Value := DmFormaCobroFields.Descripcion.Value;
         BIC.Value := BICDeudor;
         IBAN.Value := CodigoIBAN;

         var PrefijoValidacion := IfThen( EntornoPruebasVerifactu, PrefijoValidacionQRPruebas, PrefijoValidacionQR );

         QRVerifactu.Value := CodificarQR( PrefijoValidacion,
                                           DataModule00.DmEmpresaFields.NIF.Value,
                                           DmFacturaVentasFields.Serie.Value + IntToStr( DmFacturaVentasFields.NroFactura.Value ),
                                           StrFormatDate( DmFacturaVentasFields.Fecha.Value, dfDefault2, '-' ),
                                           StrDecimal( DmFacturaVentasFields.TotalFactura.Value ) );

         CodigoDivisa.Value := DmClienteFields.CodigoDivisa.Value;
         If   not ValueIsEmpty( CodigoDivisa.Value )
         then begin
              If   Divisa.Obten( CodigoDivisa.Value, DsDivisaFields )
              then begin
                   DescripcionDivisa.Value := DsDivisaFields.Descripcion.Value;
                   PrecisionDivisa.Value := DsDivisaFields.PrecisionRedondeo.Value;
                   end;
              If   dm_tca.TipoCambio.Obten( CodigoDivisa.Value, DmFacturaVentasFields.Fecha.Value, TipoDeCambio )
              then TipoCambio.Value := TipoDeCambio;
              end;

         If   not FParametrosFacturacion.GenerarFichero and FParametrosFacturacion.CopiaPropietario and not ValueIsEmpty( DmClienteFields.Factura_NroCopias.Value ) and ( FParametrosFacturacion.NroCopias=0 )
         then NroTotalCopias := DmClienteFields.Factura_NroCopias.Value
         else If   FParametrosFacturacion.NroCopias=0
              then NroTotalCopias := 1
              else NroTotalCopias := FParametrosFacturacion.NroCopias;

         With AlbaranesFacturaQuery do
           try

             With DmFacturaVentasFields do
               begin
               Params[ 0 ].Value := Ejercicio.Value;
               Params[ 1 ].Value := CodigoCliente.Value;
               Params[ 2 ].Value := Serie.Value;
               Params[ 3 ].Value := NroFactura.Value;
               end;

             Open;

             AlbaranesFacturaFields := TMovimientoFields.Create( AlbaranesFacturaQuery );

             First;
             While not Eof do
               begin

               SetFieldValueIfEmpty( RptCabeceraFields.CodigoTransportista, AlbaranesFacturaFields.CodigoTransportista.Value );
               For I := 1 to 5 do
                 SetFieldValueIfEmpty( RptCabeceraFields.CampoLibre[ I ], AlbaranesFacturaFields.CampoLibre[ I ].Value );

               // Páginas (Grupos de líneas)

               If   Assigned( RptGrupoLineasTable )
               then With DmGrupoLineaMovimientoTable do
                      try

                        IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina';

                        With AlbaranesFacturaFields do
                          SetRange( [ Ejercicio.Value, NroOperacion.Value, 0 ],  [ Ejercicio.Value, NroOperacion.Value, MaxSmallint ] );

                        First;
                        While not Eof do
                          begin

                          RptGrupoLineasTable.Append;

                          With RptGrupoLineasFields do
                            begin
                             EjercicioDocumento.Value := AlbaranesFacturaFields.Ejercicio.Value;
                             NroOperacionDoc.Value := AlbaranesFacturaFields.NroOperacion.Value;
                             NroPagina.Value := DmGrupoLineaMovimientoFields.NroPagina.Value;
                             CodigoGrupo.Value := DmGrupoLineaMovimientoFields.CodigoGrupo.Value;
                             Descripcion.Value := DmGrupoLineaMovimientoFields.Descripcion.Value;
                             Anotacion.Value := DmGrupoLineaMovimientoFields.Anotacion.Value;
                            end;

                          With RptGrupoLineasTable do
                            begin
                            RecordFieldValues := GetFieldValues;
                            For Index := 1 to NroTotalCopias do
                              begin

                              try
                                If   Index>1
                                then begin
                                     Append;
                                     SetFieldValues( RecordFieldValues );
                                     end;
                                Edit;
                                RptGrupoLineasFields.NroOperacion.Value := NroOperacionActual + Pred( Index );
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

               // Lineas

               With DmLineaMovimientoTable do
                 try
                   IndexFieldNames := 'Ejercicio;NroOperacion;NroPagina;NroLinea';
                   With AlbaranesFacturaFields do
                     SetRange( [ Ejercicio.Value, NroOperacion.Value, 0, 1 ], [ Ejercicio.Value, NroOperacion.Value, MaxSmallint, MaxSmallint ] );

                   First;
                   While not Eof do
                     begin

                     RptLineasTable.Append;

                     With RptLineasFields do
                       begin

                       TotalBultos.Value := 0.0;
                       TotalKilos.Value := 0.0;
                       TotalVolumen.Value := 0.0;

                       CodigoArticulo.Value := DmLineaMovimientoFields.CodigoArticulo.Value;
                       CodigoRegAuxiliar.Value := AlbaranesFacturaFields.RegistroAuxiliar.Value;
                       Largo.Value := DmLineaMovimientoFields.Largo.Value;
                       Ancho.Value := DmLineaMovimientoFields.Ancho.Value;
                       Alto.Value := DmLineaMovimientoFields.Alto.Value;
                       Cantidad.Value := -DmLineaMovimientoFields.Cantidad.Value;

                       If   Articulo.Obten( DmLineaMovimientoFields.CodigoArticulo.Value, DmArticuloFields )
                       then begin

                            AsignacionOrigen.Value := DmLineaMovimientoFields.AsignacionOrigen.Value;

                            If   Cantidad.Value>0.0
                            then begin

                                 SumaCajas.Value := SumaCajas.Value + DmLineaMovimientoFields.nroCajas.Value;

                                 If   DataModule00.DmEmpresaFields.Articulo_Pallets.Value and
                                      ( DmArticuloFields.UnidadesPorPallet.Value<>0.0 )
                                 then With TotalPallets do
                                        begin
                                        Value := Cantidad.Value / DmArticuloFields.UnidadesPorPallet.Value;
                                        If   Value<>Round( Value )
                                        then Value := Int( Value ) + 1;
                                        SumaPallets.Value := SumaPallets.Value + TotalPallets.Value ;
                                        end;

                                 If   DataModule00.DmEmpresaFields.Articulo_Bultos.Value
                                 then begin

                                      If   DmLineaMovimientoFields.Bultos.Value=0.0
                                      then TotalBultos.Value := Cantidad.Value * DmArticuloFields.Bultos.Value
                                      else TotalBultos.Value := DmLineaMovimientoFields.Bultos.Value;

                                      TotalKilos.Value   := Cantidad.Value * DmArticuloFields.Kilos.Value;
                                      TotalVolumen.Value := Cantidad.Value * DmArticuloFields.Volumen.Value;

                                      SumaBultos.Value  := SumaBultos.Value  + TotalBultos.Value;
                                      SumaKilos.Value   := SumaKilos.Value   + TotalKilos.Value;
                                      SumaVolumen.Value := SumaVolumen.Value + TotalVolumen.Value;
                                      end;
                                 end;
                            UnidadesPrecio.Value := DmArticuloFields.UnidadesPrecioVenta.Value;
                            end;

                       TipoIVAArticulo := DmArticuloFields.TipoIVA.Value;

                       ImporteBruto.Value := DmLineaMovimientoFields.ImporteBruto.Value;
                       ImporteDescuento.Value := DmLineaMovimientoFields.ImporteDescuento.Value;
                       ImporteNeto.Value := DmLineaMovimientoFields.ImporteNeto.Value;
                       CuotaIVA.Value := DmLineaMovimientoFields.CuotaIVA.Value;
                       CuotaRE.Value := DmLineaMovimientoFields.CuotaRE.Value;
                       TotalLinea.Value := DmLineaMovimientoFields.ImporteTotal.Value;

                       PrecioIVAIncluido.Value := DmLineaMovimientoFields.PrecioIVA.Value;
                       NroOperacionDoc.Value := AlbaranesFacturaFields.NroOperacion.Value;
                       NroRegistro.Value := DmLineaMovimientoFields.NroLinea.Value;
                       NroRegistroDoc.Value := DmLineaMovimientoFields.NroRegistro.Value;
                       NroPagina.Value := DmLineaMovimientoFields.NroPagina.Value;
                       NroLinea.Value := DmLineaMovimientoFields.NroLinea.Value;
                       Fecha.Value := AlbaranesFacturaFields.Fecha.Value;
                       TipoMovimientoOrigen.Value := DmLineaMovimientoFields.TipoMovimientoOrigen.Value;
                       EjercicioOrigen.Value := DmLineaMovimientoFields.EjercicioOrigen.Value;
                       NroOperacionOrigen.Value := DmLineaMovimientoFields.NroOperacionOrigen.Value;
                       NroRegistroOrigen.Value := DmLineaMovimientoFields.NroRegistroOrigen.Value;
                       EjercicioDocumento.Value := AlbaranesFacturaFields.Ejercicio.Value;
                       SerieDocumento.Value := AlbaranesFacturaFields.Serie.Value;
                       NroDocumento.Value := AlbaranesFacturaFields.NroDocumento.Value;
                       Referencia.Value := Articulo.ReferenciaCliente( CodigoPropietario.Value, CodigoArticulo.Value );
                       CodigoClaseA.Value := DmLineaMovimientoFields.CodigoClaseA.Value;
                       DescripcionClaseA.Value := Clase.Descripcion( tcClaseA, DmLineaMovimientoFields.CodigoClaseA.Value, True );
                       CodigoClaseB.Value := DmLineaMovimientoFields.CodigoClaseB.Value;
                       DescripcionClaseB.Value := Clase.Descripcion( tcClaseB, DmLineaMovimientoFields.CodigoClaseB.Value, True );
                       CodigoClaseC.Value := DmLineaMovimientoFields.CodigoClaseC.Value;
                       DescripcionClaseC.Value := Clase.Descripcion( tcClaseC, DmLineaMovimientoFields.CodigoClaseC.Value, True );
                       LoteFabricacion.Value := DmLineaMovimientoFields.loteFabricacion.Value;
                       NumeroSerie.Value := DmLineaMovimientoFields.NumeroSerie.Value;
                       CampoLibre1.Value := DmLineaMovimientoFields.CampoLibre1.Value;
                       CampoLibre2.Value := DmLineaMovimientoFields.CampoLibre2.Value;
                       CampoLibre3.Value := DmLineaMovimientoFields.CampoLibre3.Value;
                       CampoLibre4.Value := DmLineaMovimientoFields.CampoLibre4.Value;
                       Descripcion.Value := DmLineaMovimientoFields.Descripcion.Value;
                       Descripcion.Value := DmLineaMovimientoFields.Descripcion.Value;
                       Anotacion.Value := DmLineaMovimientoFields.Anotacion.Value;

                       CodigoAlmacen.Value := DmLineaMovimientoFields.CodigoAlmacen.Value;
                       Precio.Value := DmLineaMovimientoFields.Precio.Value;
                       PrecioDivisa.Value := DmLineaMovimientoFields.PrecioDivisa.Value;
                       PuntoVerde.Value := DmLineaMovimientoFields.PuntoVerde.Value;
                       Recargo.Value := DmLineaMovimientoFields.Recargo.Value;
                       Descuento.Value := DmLineaMovimientoFields.Descuento.Value;
                       ImportePuntoVerde.Value := PuntoVerde.Value * Cantidad.Value;
                       CodigoTipoIVA.Value := DmLineaMovimientoFields.CodigoTipoIVA.Value;

                       TotalEcotasa.Value := TotalEcotasa.Value + ImportePuntoVerde.Value;   // Campo de la cabecera
                       ImporteContribucionRAP.Value := DmLineaMovimientoFields.ContribucionRAP.Value;

                       TotalContribucionRAP.Value := TotalContribucionRAP.Value + ImporteContribucionRAP.Value; // Es el total. Ya está multiplicado por el número de cajas.

                       Movimiento.AcumulaValoresImpositivosLinea( DmLineaMovimientoFields, CodigoPaisIVA, TasasArray, False );

                       If   CalcularIVA
                       then begin
                            Tasa.TipoIVA( Fecha.Value, CodigoPaisIVA, CodigoTipoIVA.Value, DsTiposIVAFields );
                            TipoIVA.Value := DsTiposIVAFields.IVARepercutido.Value;
                            If   DmClienteFields.Factura_ModeloIVA.Value=micConRE
                            then TipoRE.Value := DsTiposIVAFields.RERepercutido.Value;
                            end;

                       NroCajas.Value := DmLineaMovimientoFields.NroCajas.Value;

                       With RptLineasTable do
                         begin
                         RecordFieldValues := GetFieldValues;
                         For Index := 1 to NroTotalCopias do
                           begin
                           try

                             If   Index>1
                             then begin
                                  Append;
                                  SetFieldValues( RecordFieldValues );
                                  end;

                             Edit;
                             NroOperacion.Value := NroOperacionActual + Pred( Index );
                             Post;

                           except
                             Cancel;
                             raise;
                             end;

                           end;
                         end;

                       end;

                     Next;
                     end;

                 finally
                   CancelRange;
                   end;

               Next;
               end;

           finally
             Close;
             end;

         DescuentoES.Value := DmFacturaVentasFields.DescuentoES.Value;
         ImporteDtoES.Value := DmFacturaVentasFields.ImporteDtoES.Value;
         DescuentoPP.Value := DmFacturaVentasFields.DescuentoPP.Value;
         ImporteDtoPP.Value := DmFacturaVentasFields.importeDtoPP.Value;

         ImportePuntoVerde.Value := DmFacturaVentasFields.ImportePuntoVerde.Value;
         CosteArticulos.Value := DmFacturaVentasFields.CosteArticulos.Value;
         BrutoArticulos.Value := DmFacturaVentasFields.BrutoArticulos.Value;
         DescuentoArticulos.Value := DmFacturaVentasFields.DescuentosArticulos.Value;
         DescuentoPropietario.Value := DmFacturaVentasFields.DescuentosClientes.Value;
         NetoArticulos.Value := DmFacturaVentasFields.NetoFactura.Value - DmFacturaVentasFields.ImportePuntoVerde.Value;

         If   DataModule00.DmEmpresaFields.Articulo_ContribucionRAPRepercutida.Value
         then NetoArticulos.Value := NetoArticulos.Value - DmFacturaVentasFields.ImporteContribucionRAP.Value;

         ImporteNeto.Value := DmFacturaVentasFields.NetoFactura.Value - DmFacturaVentasFields.DescuentosClientes.Value + DmFacturaVentasFields.Portes.Value + DmFacturaVentasFields.ImporteRecFinanciero.Value;
         TotalCuotaIVA.Value := DmFacturaVentasFields.CuotaIVA.Value;
         TotalCuotaRE.Value := DmFacturaVentasFields.CuotaRE.Value;
         ImporteComision.Value := DmFacturaVentasFields.Comision.Value;
         TotalACuenta.Value := DmFacturaVentasFields.TotalACuenta.Value;

         var RecalcularCuotas := ( DescuentoES.Value<>0.0 ) or ( DescuentoPP.Value<>0.0 );
         var TipoIVAPortes := Tasa.TipoIVAGlobal( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, rgTipoIVAPortes );

         If   DmFacturaVentasFields.Portes.Value<>0.0
         then TasasArray[ TipoIVAPortes ].BaseImponible := TasasArray[ TipoIVAPortes ].BaseImponible + DmFacturaVentasFields.Portes.Value;

         For Index := 0 to NroMaximoTiposTasas do
           begin

           If   TasasArray[ Index ].BaseImponible<>0.0
           then begin

                ImporteBaseDescuentos := TasasArray[ Index ].BaseImponible;
                If   Index=TipoIVAPortes
                then ImporteBaseDescuentos := ImporteBaseDescuentos - DmFacturaVentasFields.Portes.Value;

                ImporteBaseDescuentos := ImporteBaseDescuentos - TasasArray[ Index ].BaseNoSujetaDto;

                ImporteDescuentos := 0.0;

                If   DescuentoES.Value<>0.0
                then DecAdd( ImporteDescuentos, Redondea( ( ImporteBaseDescuentos * DescuentoES.Value ) / 100.0 ) );
                If   DescuentoPP.Value<>0.0
                then DecAdd( ImporteDescuentos, Redondea( ( ( ImporteBaseDescuentos - ImporteDescuentos ) * DescuentoPP.Value ) / 100.0 ) );

                DecAdd( TasasArray[ Index ].BaseImponible, -ImporteDescuentos );
                end;

           If   ( Index=0 ) and ( DmFacturaVentasFields.ImporteRecFinanciero.Value<>0.0 )
           then DecAdd( TasasArray[ 0 ].BaseImponible, DmFacturaVentasFields.ImporteRecFinanciero.Value );

           If   CalcularIVA and ( RecalcularCuotas or ( ( DmFacturaVentasFields.Portes.Value<>0.0 ) and ( Index=TipoIVAPortes ) ) )
           then begin
                Tasa.TipoIVA( DmFacturaVentasFields.Fecha.Value, CodigoPaisIVA, Index, DsTiposIVAFields );
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

         If   CalcularIVA
         then begin

              For Index := 1 to NroMaximoTiposTasas do
                If   TasasArray[ Index ].BaseImponible<>0.0
                then begin
                     PrimerTipoIVA.Value := TasasArray[ Index ].TipoIVA;
                     PrimerTipoRE.Value  := TasasArray[ Index ].TipoRE;
                     Break;
                     end;

              For Index := 1 to NroMaximoTiposTasasImpreso do
                begin
                BaseImponible[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 1, TasasArray );
                TipoIVA[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 2, TasasArray );
                CuotaIVA[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 3, TasasArray );
                TipoRE[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 4, TasasArray );
                CuotaRE[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 5, TasasArray );
                ImporteTotal[ Index ].Value := FacturaVentas.DesgloseIVA( Index, 6, TasasArray );
                end;

              end
         else begin
              BaseImponible[ 1 ].Value := DmFacturaVentasFields.NetoFactura.Value;
              TipoIVA[ 1 ].Value := 0.0;
              CuotaIVA[ 1 ].Value := 0.0;
              TipoRE[ 1 ].Value := 0.0;
              CuotaRE[ 1 ].Value := 0.0;
              ImporteTotal[ 1 ].Value := DmFacturaVentasFields.NetoFactura.Value;;
              end;

         CosteArticulos.Value := DmFacturaVentasFields.CosteArticulos.Value;

         ObtenCuotasPortes( DmFacturaVentasFields.Portes.Value,
                            DmFacturaVentasFields.Fecha.Value,
                            DmClienteFields.Factura_ModeloIVA.Value,
                            ImporteIVAPortes,
                            ImporteREPortes );

         PorcentajeRecFinanc.Value := DmFacturaVentasFields.RecargoFinanciero.Value;
         RecargoFinanciero.Value := DmFacturaVentasFields.ImporteRecFinanciero.Value;
         TipoRetencion.Value := DmFacturaVentasFields.TipoRetencion.Value;

         Tasa.TipoRetencion( FechaDocumento.Value, TipoRetencion.Value, DsTiposIVAFields );

         PorcentajeRetencion.Value := DsTiposIVAFields.IVASoportado.Value;
         BaseCalculoRetencion.Value := DmFacturaVentasFields.BaseCalculoRetencion.Value;
         ImporteRetencion.Value := -DmFacturaVentasFields.ImporteRetencion.Value;
         Portes.Value := DmFacturaVentasFields.Portes.Value;
         CuotaIVAPortes.Value := ImporteIVAPortes;
         CuotaREPortes.VAlue := ImporteREPortes;
         TotalImporte.Value := DmFacturaVentasFields.TotalFactura.Value;

         Efecto.ObtenVencimientos( scVentas,
                                   DmFacturaVentasFields.Ejercicio.Value,
                                   DmFacturaVentasFields.CodigoCliente.Value,
                                   DmFacturaVentasFields.Serie.Value,
                                   DmFacturaVentasFields.NroFactura.Value,
                                   RelacionEfectos );

         For Index := 1 to RelacionEfectos.NroEfectos do
           If   Index>6  // Aunque se pueden incluir tantos efectos como se desee, sólo se pasan los 6 primeros
           then Break
           else begin
                FechaVencimiento[ Index ].Value := RelacionEfectos.FechaVencimiento[ Index ];
                ImporteVencimiento[ Index ].Value := RelacionEfectos.Importe[ Index ];
                end;

         ImporteCifra.Value := Cifra( DmFacturaVentasFields.TotalFactura.Value );
         SumaIVAyRE.Value := DmFacturaVentasFields.CuotaIVA.Value + DmFacturaVentasFields.CuotaRE.Value;
         Anotacion.Value := DmFacturaVentasFields.Anotacion.Value;

         CodigoEmpresa.Value := CodigoEmpresaActual;

         With RptCabeceraTable do
           begin
           RecordFieldValues := GetFieldValues;
           For Index := 1 to NroTotalCopias do
             begin
             try
               If   Index>1
               then begin
                    Append;
                    SetFieldValues( RecordFieldValues );
                    end;
               Edit;
               NroOperacion.Value := NroOperacionActual + Pred( Index );
               If   FParametrosFacturacion.CopiaPropietario
               then NroCopia.Value := Index
               else NroCopia.Value := 0;
               Post;

             except
               Cancel;
               raise;
               end;

             end;
           end;

         Inc( NroOperacionActual, NroTotalCopias );

         ApplicationContainer.ShowProgression;

         end;

     finally
       end;

end;

procedure TFacturaVentasModule.ExportaFichero;

var  ExportFileName : String;
     TipoDatos : TTipoDatosExportados;

begin

     With DmFacturaVentasTable, FParametrosFacturacion, Report do
       begin

       // ProcessFrame.AddRecordMsg( Format( RsMsg31, [ DmFacturaVentasFields.CodigoCliente.Value ] ) );

       If   EnviarPorCorreo or not ( ExcluirCorreo and DmClienteFields.Factura_EnviarPorCorreo.Value )
       then begin

            {
            With DmClienteFields do
              ProcessFrame.AddMsg( ntInformation, Codigo.Value + ' - ' + Nombre.Value );
            If   FParametrosFacturacion.GenerarFichero
            then ProcessFrame.AddRecordMsg( RsMsg27 );
            }

            NroOperacionActual := 1;
            ExportFileName := 'fv' + IntToStr( YearOf( DmFacturaVentasFields.Fecha.Value ) ) + '_' + DmFacturaVentasFields.Serie.Value + '_' + IntToStr( DmFacturaVentasFields.NroFactura.Value );

            Load;
            InicializaImpresion;
            GeneraRegistrosImpresion;
            FijaDecimalesInforme( Report );

            TipoDatos := tdCualquiera;
            case TipoFichero of
              tfePDF, tfePDFFirma :
                begin
                ExportFileName := ExportToPDF( ExportFileName + '.pdf' );
                TipoDatos := tdFacturaPDF;
                end;
              tfeCamerFactura, tfeFacturaE, tfeFacturaEFirma :
                TipoDatos := tdFacturaXML;
                end;

            If   FOnFirmaFactura.CanInvoke
            then begin
                 ProcessFrame.AddRecordMsg( RsMsg39 );
                 FOnFirmaFactura.Invoke( TipoFichero, ExportFileName );
                 end
            else If   TipoFichero=tfePDF
                 then begin
                      AlmacenDocumentosPath := ApplicationPath + 'doc_' + CodigoEmpresaActual  + '\Facturas de venta\' + IntToStr( ApplicationContainer.Ejercicio ) + '\PDF\';
                      CreateDirPath( AlmacenDocumentosPath );
                      With ProcessFrame do
                        If   not FlagA
                        then begin
                             ProcessFrame.AddMsg( ntInformation, Format( RsMsg46, [ AlmacenDocumentosPath ] ) );
                             FlagA := True;
                             end;
                      PathFicheroAlmacen := AlmacenDocumentosPath + ExtractFileName( ExportFileName );
                      If   not CopyFile( ExportFileName, PathFicheroAlmacen )
                      then begin
                           ShowNotification( ntError, RsMsg47, Format( RsMsg48, [ AlmacenDocumentosPath ] ) );
                           Abort;
                           end;
                      ProcessFrame.AddMsg( ntLinkInformation, Format( RsMsg49, [ PathFicheroAlmacen, ExtractFileName( ExportFileName ) ] ) );
                      end;

            If   FOnRegistroFacturaElectronicaCreada.CanInvoke and ( TipoFichero in [ tfeFacturaE, tfeFacturaEFirma ] )
            then FOnRegistroFacturaElectronicaCreada.Invoke( rfeFacturaEmitida,
                                                             DmFacturaVentasFields.CodigoCliente.Value,
                                                             DmFacturaVentasFields.Serie.Value,
                                                             DmFacturaVentasFields.NroFactura.Value,
                                                             DmClienteFields.NIF.Value,
                                                             DmFacturaVentasFields.Fecha.Value,
                                                             DmFacturaVentasFields.TotalFactura.Value );
            If   EnviarPorCorreo
            then If   DmClienteFields.Factura_EnviarPorCorreo.Value and
                      not ( ExcluirEnviados and not ValueIsEmpty( DmFacturaVentasFields.FechaEnvioPorCorreo.Value ) )
                 then EnviaFacturaPorCorreo( TipoDatos, ExportFileName )
                 else With DmClienteFields do
                        ProcessFrame.AddMsg( ntWarning, Format( RsMsg16, [ DmFacturaVentasFields.NroFactura.Value, Codigo.Value, Nombre.Value ] ) );
            end;

       end;

end;

procedure TFacturaVentasModule.FijaParametrosFacturacion( ParametrosFacturacion : IParametrosFacturacion );
begin

     With ParametrosFacturacion do
       If   EjercicioFactura=0
       then EjercicioFactura := ApplicationContainer.Ejercicio;

     FParametrosFacturacion := ParametrosFacturacion;
     FormatoImpreso := ParametrosFacturacion.Formato;

     With DmFacturaVentasTable, ParametrosFacturacion do
       If   ParametrosFacturacion.TipoSeleccion=tsDocumento
       then begin
            IndexFieldNames := 'Ejercicio;Serie;NroFactura';
            SetRange( [ EjercicioFactura, Serie, NroFacturaInicial ], [ EjercicioFactura, Serie, NroFacturaFinal ] );
            end
       else begin
            IndexFieldNames := 'Serie;Fecha;NroFactura';
            SetRange( [ Serie, FechaInicial, 1 ], [ Serie, FechaFinal, MaxLongint ] );
            end;

end;

function TFacturaVentasModule.SeleccionFactura( ParametrosFacturacion : IParametrosFacturacion ) : Boolean;
begin
     With ParametrosFacturacion do
       Result := ( ( SeleccionPropietario=0 ) or ( ( DmFacturaVentasFields.CodigoCliente.Value>=PropietarioInicial ) and ( DmFacturaVentasFields.CodigoCliente.Value<=PropietarioFinal ) ) ) and
                 ( ( SeleccionGrupoPropietario=0 ) or ( ( DmFacturaVentasFields.GrupoFacturacion.Value>=GrupoPropietarioInicial ) and ( DmFacturaVentasFields.GrupoFacturacion.Value<=GrupoPropietarioFinal ) ) ) and
                 ( ( SeleccionVendedor=0 )    or ( ( DmFacturaVentasFields.CodigoVendedor.Value>=VendedorInicial ) and ( DmFacturaVentasFields.CodigoVendedor.Value<=VendedorFinal ) ) ) and
                 ( ( SeleccionFormaCobro=0 )  or ( ( DmFacturaVentasFields.CodigoFormaCobro.Value>=FormaCobroInicial ) and ( DmFacturaVentasFields.CodigoFormaCobro.Value<=FormaCobroFinal ) ) ) and
                 ( ( SeleccionRegAuxiliar=0 ) or ( ( CodigoPropietario='' ) or ( DmFacturaVentasFields.CodigoCliente.Value=CodigoPropietario) ) and
                                                   ( DmFacturaVentasFields.RegistroAuxiliar.Value>=RegAuxiliarInicial ) and ( DmFacturaVentasFields.RegistroAuxiliar.Value<=RegAuxiliarFinal ) );

end;

procedure TFacturaVentasModule.GeneraRelacionFacturas( ParametrosFacturacion : IParametrosFacturacion;
                                                       OnGeneraRegistro      : TOnGeneraRegistroProcedure );

begin
     FijaParametrosFacturacion( ParametrosFacturacion );
     With DmFacturaVentasTable do
       begin
       First;
       While not Eof do
         begin

         If   SeleccionFactura( ParametrosFacturacion )
         then If   DmClienteTable.FindKey( [ DmFacturaVentasFields.CodigoCliente.Value ] )
              then If   not ( ParametrosFacturacion.ExcluirCorreo and DmClienteFields.Factura_EnviarPorCorreo.Value )
                   then OnGeneraRegistro( DmFacturaVentasFields );

         Next;
         end;
       end;
end;

procedure TFacturaVentasModule.ImprimeFacturas( ParametrosFacturacion  : IParametrosFacturacion;
                                                SeleccionFacturasFrame : TSfvFrame = nil );

var TextoCabecera : String;

begin

     FijaParametrosFacturacion( ParametrosFacturacion );

     If   Assigned( SeleccionFacturasFrame )
     then begin
          FSeleccionFacturasFrame := SeleccionFacturasFrame;
          DmFacturaVentasTable.IndexFieldNames := 'Ejercicio;Serie;NroFactura';
          DmFacturaVentasTable.CancelRange;
          end
     else FSeleccionFacturasFrame := nil;

     If   ParametrosFacturacion.GenerarFichero
     then TextoCabecera := RsMsg25
     else TextoCabecera := RsMsg12;

     var ProcessError := CreateProcessForm( ImprimeOExportaFicheroFacturas, TextoCabecera, { Cancellable } True, { AutoClosing } not ParametrosFacturacion.GenerarFichero );

     // Despues de la generación de los registros de impresión se cierra la ventana de procesos y ya se puede imprimir.
     // En el caso de la generación de ficheros ya está todo hecho y la ventana de procesos se queda abierta.

     If   not ProcessError and
          not ParametrosFacturacion.GenerarFichero
     then begin
          FijaDecimalesInforme( Report );
          Report.Start;
          Report.Detach;
          end;

end;

procedure TFacturaVentasModule.ImprimeOExportaFicheroFacturas;
begin

     With DmFacturaVentasTable, FParametrosFacturacion do
       try

         try

           try

             If   not GenerarFichero
             then begin
                  ProcessFrame.AddMsg( ntInformation, RsMsg24 );
                  Report.Load( False );
                  InicializaImpresion;
                  NroOperacionActual := 1;
                  end;

             If   Assigned( FSeleccionFacturasFrame )
             then begin
                  With FSeleccionFacturasFrame do
                    try
                      RelacionDocumentosTable.DisableControls;
                      ApplicationContainer.StartProgression( RelacionDocumentosTable.RecordCount );
                      RelacionDocumentosTable.First;
                      While not RelacionDocumentosTable.Eof and not ProcessFrame.Canceled do
                        begin
                        If   DmFacturaVentasTable.FindKey( [ RelacionDocumentosTableEjercicio.Value, RelacionDocumentosTableSerie.Value, RelacionDocumentosTableNroFactura.Value] )
                        then If   DmClienteTable.FindKey( [ DmFacturaVentasFields.CodigoCliente.Value ] )
                             then begin
                                  If   GenerarFichero
                                  then ExportaFichero
                                  else GeneraRegistrosImpresion;
                                  end
                             else begin
                                  ProcessFrame.AddMsg( ntError, Format( RsMsg10, [ DmFacturaVentasFields.CodigoCliente.Value ] ) );
                                  Abort;
                                  end;
                        RelacionDocumentosTable.Next;
                        end;
                    finally
                      RelacionDocumentosTable.EnableControls;
                      end;
                  end
             else With DmFacturaVentasTable, FParametrosFacturacion do
                    begin
                    ApplicationContainer.StartProgression( RecordCount );
                    First;
                    While not Eof and
                          not ProcessFrame.Canceled and
                          not ProcessFrame.Error  do
                      begin
                      If   SeleccionFactura( FParametrosFacturacion )
                      then If   DmClienteTable.FindKey( [ DmFacturaVentasFields.CodigoCliente.Value ] )
                           then begin
                                If   not ( ExcluirCorreo and DmClienteFields.Factura_EnviarPorCorreo.Value )
                                then If   GenerarFichero
                                     then ExportaFichero
                                     else GeneraRegistrosImpresion;
                                end
                           else begin
                                ProcessFrame.AddMsg( ntError, Format( RsMsg10, [ DmFacturaVentasFields.CodigoCliente.Value ] ) );
                                Abort;
                                end;
                      Next;
                      end;
                    end;

           finally
             ApplicationContainer.EndProgression;
             end;

           except on E : Exception do
             begin
             ProcessFrame.AddMsg( ntError, RsMsg41 );
             Report.Cancel( E );
             end;
           end;

         finally
           DmFacturaVentasTable.CancelRange;
           If   GenerarFichero
           then Report.Reset;
           end;

end;

procedure TFacturaVentasModule.EnviaFacturaPorCorreo( TipoDatos      : TTipoDatosExportados;
                                                      ExportFileName : String );

var DestinatariosArray : TStringArray;
    SubjectLine,
    SubjectFileName : String;
    SubjectFile : TextFile;
    ErrorText : TCaption;
    Error : Boolean;

procedure InsertaParametros;
begin
     With ExportImport do
       begin
       HeaderList.Values[ RsCodigoEmpresa ] := CodigoEmpresaActual;
       HeaderList.Values[ RsNombreEmpresa ] := ApplicationContainer.Empresa_Nombre;
       HeaderList.Values[ RsSerie ] := DmFacturaVentasFields.Serie.Value;
       HeaderList.Values[ RsNroFactura ] := IntToStr( DmFacturaVentasFields.NroFactura.Value );
       HeaderList.Values[ RsFechaFactura ] := StrFormatDate( DmFacturaVentasFields.Fecha.Value );
       HeaderList.Values[ RsCodigoCliente ] := DmClienteFields.Codigo.Value;
       HeaderList.Values[ RsNombreCliente ] := DmClienteFields.Nombre.Value
       end;
end;

begin

     If   EMailSubjectTemplate=''
     then begin
          SubjectFileName := CheckReportLocation( 'ffv.txt', CodigoEmpresaActual, dtText, ErrorText, Error );
          If   Error
          then EMailSubjectTemplate := RsMsg30
          else begin
               AssignFile( SubjectFile, SubjectFileName );
               try
                 System.Reset( SubjectFile );
                 While not System.Eof( SubjectFile ) do
                   begin
                   ReadLn( SubjectFile, SubjectLine );
                   EMailSubjectTemplate := EMailSubjectTemplate + SubjectLine + CR;
                   end;
                 CloseFile( SubjectFile );
               except
                 EMailSubjectTemplate := RsMsg30;
                 end;
               end;
          end;

     DestinatariosArray := DireccionContacto.ObtenDireccionesCorreo( tdpCliente,
                                                                     DmClienteFields.Codigo.Value,
                                                                     tdmFactura,
                                                                     DmClienteFields.Nombre.Value,
                                                                     DmClienteFields.EMail.Value );

     If   High( DestinatariosArray )>0
     then begin

          If   Assigned( ProcessFrame )
          then ProcessFrame.AddRecordMsg( RsMsg28 );

          try

            InsertaParametros;

            // Envío N/Factura nº %s %d de fecha %s. %s' o variables

            If   EMailSubjectTemplate.Contains( '%s' )
            then EMailSubjectText := Format( EMailSubjectTemplate, [ DmFacturaVentasFields.Serie.Value,
                                                                     DmFacturaVentasFields.NroFactura.Value,
                                                                     DmFacturaVentasFields.Ejercicio.Value,
                                                                     DataModule00.DmEmpresaFields.Nombre.Value ] )
            else EMailSubjectText := StrSetVars( EMailSubjectTemplate,
                                                 [ 'SerieNroFactura',
                                                   'Ejercicio',
                                                   'Empresa_nombre' ],
                                                 [ DmFacturaVentasFields.Serie.Value + ' ' + IntToStr( DmFacturaVentasFields.NroFactura.Value ),
                                                   IntToStr( DmFacturaVentasFields.Ejercicio.Value ),
                                                   DataModule00.DmEmpresaFields.Nombre.Value ] );

            ExportImport.SMTPInit( TipoDatos,
                                   DestinatariosArray,
                                   Format( RsMsg29, [ DmFacturaVentasFields.Serie.Value,
                                                      DmFacturaVentasFields.NroFactura.Value,
                                                      StrFormatDate( DmFacturaVentasFields.Fecha.Value ) ] ),

                                   EMailSubjectText,

                                   [ ExportFileName ] );

            ExportImport.SMTPSend;

            try
              DmFacturaVentasTable.Edit;
              DmFacturaVentasFields.FechaEnvioPorCorreo.Value := ApplicationContainer.TodayDate;
              DmFacturaVentasTable.Post;
              With DmFacturaVentasFields do
                ShowNotification( ntInformation, Format( RsMsg40, [ Serie.Value, NroFactura.Value ] ) );
            except
              DmFacturaVentasTable.Cancel;
              With DmFacturaVentasFields do
                ShowNotification( ntWarning, Format( RsMsg37, [ Serie.Value, NroFactura.Value ] ), RsMsg38 );
              end;

            except on E : Exception do
              begin
              ShowNotification( ntExceptionError, RsMsg32, RsMsg33 + #13 + E.Message );
              // No interrumpo el proceso a petición de los usuarios
              // Abort;
              end;

            end;

          end;

end;

procedure TFacturaVentasModule.ReportSetReportName;
begin
     With Report do
       begin
       If   FormatoImpreso=0
       then FileName := 'ffv'
       else FileName := InformeExterno.Fichero;
       Title := RsMsg12;
       end;
end;

procedure TFacturaVentasModule.ReportSelectPrinter;
begin
     Report.ReportPrinter := InformeExterno.Impresora;
end;

procedure TFacturaVentasModule.FijaDecimalesInforme( Report : TgxReportManager );
begin
     With Report, DataModule00.DmEmpresaFields do
       begin
       SetNumberVarFormat( FmtCantidadVenta, Ventas_DecCantidad.Value  );
       SetNumberVarFormat( FmtPrecioVenta, Ventas_DecPrecio.Value );
       SetNumberVarFormat( FmtDescuentoVenta, Ventas_DecDto.Value );
       end;
end;

procedure TFacturaVentasModule.AcumulaValoresImpositivos( var TasasArray  : TTasasArray;
                                                              Fecha       : TDate;
                                                              ModeloIVA   : SmallInt;
                                                              CalcularIVA : Boolean;
                                                          var Sumas       : TTasaRecord );

var   Index : SmallInt;

begin

     FillChar( Sumas, SizeOf( Sumas ), #0 );

     For Index := 0 to NroMaximoTiposTasas do
       begin

       // Aprovecho para redondear las sumas por tipo impositivo

       With TasasArray[ Index ] do
         begin
         BaseImponible := Redondea( BaseImponible );
         BaseNoSujetaDto := Redondea( BaseNoSujetaDto );
         CuotaIVA := Redondea( CuotaIVA );
         CuotaRE := Redondea( CuotaRE );
         Importe := BaseImponible + BaseNoSujetaDto + CuotaIVA + CuotaRE;
         end;

       DecAdd( Sumas.BaseImponible, TasasArray[ Index ].BaseImponible );
       DecAdd( Sumas.BaseNoSujetaDto, TasasArray[ Index ].BaseNoSujetaDto );
       DecAdd( Sumas.CuotaIVA, TasasArray[ Index ].CuotaIVA );
       DecAdd( Sumas.CuotaRE, TasasArray[ Index ].CuotaRE );
       DecAdd( Sumas.Importe, TasasArray[ Index ].Importe );

       If   CalcularIVA and ( Index<>0 )
       then If   TasasArray[ Index ].BaseImponible<>0.0
            then begin
                 If   Sumas.TipoIVA=0.0
                 then Sumas.TipoIVA := TasasArray[ Index ].TipoIVA;
                 If   ModeloIVA=micConRE
                 then If   Sumas.TipoRE=0.0
                      then Sumas.TipoRE := TasasArray[ Index ].TipoRE;
                 end;
       end;

end;

// FacturaVentasService

procedure TFacturaVentasModule.SuprimeFactura( Serie      : String;
                                               NroFactura : LongInt );

begin
     FacturaVentasService.SuprimeFactura( Serie, NroFactura );
end;

{
procedure TFacturaVentasModule.AnulaFactura( Serie      : String;
                                             NroFactura : LongInt );
begin
     FacturaVentasService.AnulaFactura( Serie, NroFactura );
end;
}

function TFacturaVentasModule.ProximoNroFactura( Serie          : String;
                                                 RegistrarValor : Boolean = True ) : LongInt;
begin
     Result := FacturaVentasService.ProximoNroFactura( Serie, RegistrarValor );
end;

function TFacturaVentasModule.ProximoNroRegistroPresentacion( RegistrarValor : Boolean = True ) : LongInt;
begin
     Result := FacturaVentasService.ProximoNroRegistroPresentacion( RegistrarValor );
end;

procedure TFacturaVentasModule.SuprimeRelaciones( FacturaVentasFields    : TFacturaVentasFields;
                                                  SuprimeRegistroFactura : Boolean = True );

begin
     FacturaVentasService.SuprimeRelaciones( TFacturaVentas.FromDataset( FacturaVentasFields ), SuprimeRegistroFactura );
end;

procedure TFacturaVentasModule.CierreCicloFacturacion(SerieInicial, SerieFinal: String; FechaInicial, FechaFinal: TDate; Contabilizar: Boolean);
begin
     FacturaVentasService.CierreCicloFacturacion( SerieInicial, SerieFinal, FechaInicial, FechaFinal, Contabilizar );
end;

procedure TFacturaVentasModule.RecuperaFacturas( Serie : String; NroFacturaInicial, NroFacturaFinal : LongInt );
begin
     FacturaVentasService.RecuperaFacturas( Serie, NroFacturaInicial, NroFacturaFinal );
end;

function TFacturaVentasModule.RecalculaFactura( FacturaVentasFields : TFacturaVentasFields;
                                                RecuperaCliente     : Boolean ) : Boolean;
begin
     Result := FacturaVentasService.RecalculaFactura( TFacturaVentas.FromDataset( FacturaVentasFields ) );
end;

function TFacturaVentasModule.GeneraFacturas( ParametrosFacturacion  : IParametrosFacturacion;
                                              RelacionAlbaranesTable : TnxeTable = nil ) : IParametrosFacturacion;

var  TableName : String;

begin
     If   Assigned( RelacionAlbaranesTable )
     then TableName := RelacionAlbaranesTable.TableName
     else TableName := '';
     Result := FacturaVentasService.GeneraFacturas( ParametrosFacturacion, TableName );
end;

procedure TFacturaVentasModule.ObtenBasesyCuotasFactura(    Ejercicio          : SmallInt;
                                                            CodigoCliente,
                                                            Serie              : String;
                                                            NroFactura         : LongInt;
                                                        var TasasArray         : TTasasArray;
                                                        out TotalCuotaIVA      : Decimal;
                                                        out TotalCuotaRE       : Decimal;
                                                            AplicarDtosyPortes : Boolean = False );

begin
     var BasesyCuotasFactura := FacturaVentasService.ObtenBasesyCuotasFactura( Ejercicio, CodigoCliente, Serie, NroFactura, AplicarDtosyPortes );

     TasasArray := BasesyCuotasFactura.TasasArray;
     TotalCuotaIVA := BasesyCuotasFactura.TotalCuotaIVA;
     TotalCuotaRE := BasesyCuotasFactura.TotalCuotaRE;
end;

// Solo facturas de venta y solo Veri*factu

function TFacturaVentasModule.ObtenUltimoRegistroPresentacion( FacturaVentasFields : TFacturaVentasFields ) : Boolean;
begin
     With DmFacturaVentasAuxTable do
       begin
       IndexFieldNames := 'NroRegistroPresentacion';
       Last;
       Result := DmFacturaVentasAuxFields.NroRegistroPresentacion.Value<>0;
       end;
     FacturaVentasFields.Update( DmFacturaVentasAuxTable );
end;

end.
