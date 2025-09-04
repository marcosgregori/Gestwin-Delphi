{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dmi_fac;

interface

uses SysUtils,
     Classes,
     Generics.Defaults,
     Generics.Collections,

     LibUtils,
     DateUtils,
     AppManager,
     DataManager,

     Gim00Fields,
     Gim10Fields,

     nxllComponent,
     nxllTypes,
     nxivTypes,
     nxrdClass,
     nxrbTypes,

     SessionIntf,

     AsientoIntf,
     FacturaIntf,

     dmi_ast,
     dmi_iva;

const
     CLSID_FacturaService : TGuid = '{B600544B-75BE-4047-A641-6A8856EFCDFB}';
     CLSID_AcumuladoFacturacion : TGuid = '{B75C023D-4DDE-411A-822A-0F7E524FED98}';
     CLSID_AcumuladoOperacionesIntracomunitarias: TGuid = '{FEB891B3-76CC-4CC6-948E-1CA4E4DC452C}';

     { Libro registro : 1 - facturas recibidas
                        2 - bienes de inversión
                        3 - operaciones intracomunitarias
                        4 - facturas expedidas
                        5 - regimen especial de agricultura, ganaderia y pesca
                        9 - ventas online intracomunitarias a particulares (se utiliza el tipo de IVA del pais destino)
                       10 - libros especiales (por tipo impositivo y/o retencion }

     lrFrasRecibidas = 1;
     lrBienesInversion = 2;
     lrAdquisicionesIntracomunitarias = 3;
     lrFrasExpedidas = 4;
     lrEntregasIntracomunitarias = 5;
     lrRegimenEspecial = 6;
     lrInversionSujetoPasivo = 7;
     lrIVADevengado = 8;
     lrVentasOnlineIntracomunitarias = 9;
     lrEspecial = 10;

     // Tipo de facturas (dependiendo del registro maestro)

     tfAsiento = 0;
     tfFacturaVentas = 1;     // Registros de la gestión comercial
     tfFacturaCompras = 2;

     // Origen de las facturas recibidas

     ofrSujetoPasivo = 0;
     ofrIntracomunitaria = 1;
     ofrInversionSP = 2;

     // Tipo en la declaracion de operaciones intracomunitarias

     toAdquisiciones = 0;
     toEntregas = 1;
     toRectificacionAdquisiciones = 2;
     toRectificacionEntregas = 3;

     // Tipo de registro de facturas intracomunitarias

     triNormal = 0;
     triRectificacionFraAnterior = 1;

     // Tipos de factura emitida

     {
     1 : Factura (art. 6, 7.2 y 7.3 del RD 1619/2012)
     2 : Factura Simplificada y Facturas sin identificación del destinatario (art. 6.1 del RD 1619/2012)
     3 : Factura emitida en sustitución de facturas simplificadas facturadas y declaradas
     4 : Asiento resumen de facturas
     5 : Factura Rectificativa (Error fundado en derecho y Art. 80 Uno Dos y Seis LIVA
     6 : Factura Rectificativa (Art. 80.3)
     7 : Factura Rectificativa (Art. 80.4)
     8 : Factura Rectificativa (Resto)
     9 : Factura Rectificativa en facturas simplificadas

     }

     tfeOrdinaria = 0;
     tfeSimplificadaOSinIdentificacion = 1;
     tfeSustitucion = 2;
     tfeResumen = 3;
     tfeRectificativa80_1_2 = 4;
     tfeRectificativa80_3 = 5;
     tfeRectificativa80_4 = 6;
     tfeRectificativaResto = 7;
     tfeRectificativaSimplificada = 8;

     // Facturas emitidas : Régimen o trascendencia

     {
        1 : Operación de régimen general
        2 : Exportación
        3 : Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección
        4 : Régimen especial del oro de inversión
        5 : Régimen especial de las agencias de viajes
        6 : Régimen especial grupo de entidades en IVA (Nivel Avanzado)
        7 : Régimen especial del criterio de caja
        8 : Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Producción, los Servicios y la Importación / Impuesto General Indirecto Canario)
        9 : Facturación de las prestaciones de servicios de agencias de viaje que actúan como mediadoras en nombre y por cuenta ajena (D.A.4ª RD1619/2012)
       10 : Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que realicen estas funciones de cobro
       11 : Operaciones de arrendamiento de local de negocio sujetas a retención
       12 : Operaciones de arrendamiento de local de negocio no sujetos a retención
       13 : Operaciones de arrendamiento de local de negocio sujetas y no sujetas a retención
       14 : Factura con IVA pendiente de devengo en certificaciones de obra cuyo destinatario sea una Administración Pública
       15 : Factura con IVA pendiente de devengo en operaciones de tracto sucesivo
       16 : Primer semestre 2017 y otras facturas anteriores a la inclusión en el SII
       17 : Operación acogida a alguno de los regímenes previstos en el Capítulo XI del Título IX (OSS e IOSS)
            ( Regímenes especiales aplicables a las ventas a distancia y a determinadas entregas interiores de bienes y prestaciones de servicios )
       }

     rteRegimenGeneral = 0;
     rteExportacion = 1;
     rteBienesUsados = 2;
     rteOro = 3;
     rteAgenciasViajes = 4;
     rteEntidadesIVA = 5;
     rteCriterioCaja = 6;
     rteIPSI_IGIC = 7;
     rteAgenciasViaje = 8;
     rteHonorarios = 9;
     rteArrendamientoRetencion = 10;
     rteArrendamientoSinRetencion = 11;
     rteArrendamiento = 12;
     rteCertificacionesObra = 13;
     rteTractoSucesivo = 14;
     rtePrimerSemestre2017 = 15;
     rteVentasOnline = 16;

     // Tipo de factura recibida

     {
      1 : Factura (art. 6, 7.2 y 7.3 del RD 1619/2012)
      2 : Factura Simplificada y Facturas sin identificación del destinatario (art. 6.1 del RD 1619/2012)
      3 : Factura emitida en sustitución de facturas simplificadas facturadas y declaradas
      4 : Asiento resumen de facturas
      5 : Importaciones (DUA)
      6 : Justificantes contables
      7 : Factura Rectificativa (Error fundado en derecho y Art. 80 Uno Dos y Seis LIVA)
      8 : Factura Rectificativa (Art. 80.3)
      9 : Factura Rectificativa (Art. 80.4)
     10 : Factura Rectificativa (Resto)
     11 : Factura Rectificativa en facturas simplificadas
     12 : Aduanas - Liquidación complementaria
     }

     // Los índices, en la aplicación, empiezan en 0, por eso está desplazado una posición

     tfrOrdinaria = 0;
     tfrSimplificada = 1;
     tfrSustitucion = 2;
     tfrResumen = 3;
     tfrImportacionesDUA = 4;
     tfrJustificantes = 5;
     tfrRectificativa_80_1_2 = 6;
     tfrRectificativa_80_3 = 7;
     tfrRectificativa_80_4 = 8;
     tfrRectificativaResto = 9;
     tfrRectificativaSimplificada = 10;
     tfrAduanas = 11;

     // Facturas recibidas : Régimen o trascendencia

     {
        1 : Operación de régimen general
        2 : Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca
        3 : Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección
        4 : Régimen especial del oro de inversión
        5 : Régimen especial de las agencias de viajes
        6 : Régimen especial grupo de entidades en IVA (Nivel Avanzado)
        7 : Régimen especial del criterio de caja
        8 : Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Producción, los Servicios y la Importación / Impuesto General Indirecto Canario)
        9 : Adquisiciones intracomunitarias de bienes y prestaciones de servicios
       10 :
       11 :
       12 : Operaciones de arrendamiento de local de negocio
       13 : Factura correspondiente a una importación (informada sin asociar a un DUA)
       14 : Primer semestre 2017 y otras facturas anteriores a la inclusión en el SII
       }

     rtrRegimenGeneral = 0;
     rtrAgriculturaGanaderiaPesca = 1;
     rtrBienesUsados = 2;
     rtrOro = 3;
     rtrAgenciasViajes = 4;
     rtrEntidadesIVA = 5;
     rtrCriterioCaja = 6;
     rtrIPSI_IGIC = 7;
     rtrIntracomunitarias = 8;
     //
     rtrArrendamiento = 11;
     rtrImportacionSinDUA = 12;
     rtrPrimerSemestre2017 = 13;

     // Facturas : Causas de exención

     {
     0 : Exenta por el artículo 20
     1 : Exenta por el artículo 21
     2 : Exenta por el artículo 22
     3 : Exenta por artículo 23 y 24
     4 : Exenta por el artículo 25
     5 : Exenta por Otros
     }

     fexArticulo20 = 0;
     fexArticulo21 = 1;
     fexArticulo22 = 2;
     fexArticulo23_24 = 3;
     fexArticulo25 = 4;
     fexOtros = 5;

     {
     0 : A : Adquisiciones intracomunitarias sujetas
     1 : I : Adquisiciones intracomunitarias de servicios localizadas en el territorio de aplicación del Impuesto...
     }

     faiSujetas = 0;
     faiServicios = 1;

type

  TLibroRegistro = lrFrasRecibidas..lrEspecial;
  TLibrosRegistro = set of TLibroRegistro;

  TSumasFacturacion = class
      public
      FechaAplicacion : TDate;       // La fecha de aplicación del registro de TiposIVA. Clave : FechaAplicacion / CodigoPais / TipoImpositivo
      CodigoPais : String;
      TipoImpositivo : SmallInt;
      BaseImponibleIVA,
      CuotaIVA,
      BaseImponibleRE,
      CuotaRE,
      Importe : Decimal;
      end;

  TRegistroFacturacion = class
    public
    Libro : TLibroRegistro;
    TipoFactura : SmallInt;
    FechaAplicacion : TDate;
    CodigoPais : String;
    TipoImpositivo : SmallInt;
    Subcuenta : String;
    BaseImponible,
    TipoIVA,
    CuotaIVA,
    TipoRE,
    CuotaRE,
    Importe,
    BaseImponibleCaja,
    CuotaIVACaja,
    ImporteCaja : Decimal;
    FechaCobro : TDate;
    CodigoMedioCobro,
    CCC,
    ConceptoCobro : String;
    end;

  IAcumuladoFacturacion =  interface( InxInvokable )
     ['{C655C620-E6D2-4896-903C-2E3D6D692471}']

      function GetExisteCriterioCaja : Boolean;
      function GetNroRegistrosFacturacion: Integer;
      function GetSumas: TList<TSumasFacturacion>;
      function GetTotalBaseImponibleIVA: Decimal;
      function GetTotalBaseImponibleRE: Decimal;
      function GetTotalCuotaIVA: Decimal;
      function GetTotalCuotaRE: Decimal;
      function GetTotalImporte: Decimal;
      procedure SetExisteCriterioCaja(const Value: Boolean );
      procedure SetNroRegistrosFacturacion(const Value: Integer);
      procedure SetTotalBaseImponibleIVA(const Value: Decimal);
      procedure SetTotalBaseImponibleRE(const Value: Decimal);
      procedure SetTotalCuotaIVA(const Value: Decimal);
      procedure SetTotalCuotaRE(const Value: Decimal);
      procedure SetTotalImporte(const Value: Decimal);

      function Obten( Fecha : TDate; CodigoPais : String; TipoImpositivo : SmallInt ) : TSumasFacturacion;
      procedure Acumula( RegistroFacturacion : TRegistroFacturacion );
      procedure OrdenaSumas;

      property ExisteRegistroCriterioCaja : Boolean read GetExisteCriterioCaja write SetExisteCriterioCaja;
      property NroRegistrosFacturacion : Integer read GetNroRegistrosFacturacion write SetNroRegistrosFacturacion;
      property Sumas : TList<TSumasFacturacion> read GetSumas;
      property TotalBaseImponibleIVA : Decimal read GetTotalBaseImponibleIVA write SetTotalBaseImponibleIVA;
      property TotalCuotaIVA : Decimal read GetTotalCuotaIVA write SetTotalCuotaIVA;
      property TotalBaseImponibleRE : Decimal read GetTotalBaseImponibleRE write SetTotalBaseImponibleRE;
      property TotalCuotaRE : Decimal read GetTotalCuotaRE write SetTotalCuotaRE;
      property TotalImporte : Decimal read GetTotalImporte write SetTotalImporte;
     end;

  IAcumuladoOperacionesIntracomunitarias =  interface( InxInvokable )
    ['{2E865038-AE8E-4C95-92A2-7C541998FA94}']

      function GetNroRegistrosFacturacion: Integer;
      function GetNroRegistrosRectificaciones: Integer;
      function GetTotalBaseImponible: Decimal;
      function GetTotalBaseImponibleRectificaciones: Decimal;
      procedure SetNroRegistrosFacturacion(const Value: Integer);
      procedure SetNroRegistrosRectificaciones(const Value: Integer);
      procedure SetTotalBaseImponible(const Value: Decimal);
      procedure SetTotalBaseImponibleRectificaciones(const Value: Decimal);

      property NroRegistrosFacturacion : Integer read GetNroRegistrosFacturacion write SetNroRegistrosFacturacion;
      property NroRegistrosRectificaciones : Integer read GetNroRegistrosRectificaciones write SetNroRegistrosRectificaciones;
      property TotalBaseImponible : Decimal read GetTotalBaseImponible write SetTotalBaseImponible;
      property TotalBaseImponibleRectificaciones : Decimal read GetTotalBaseImponibleRectificaciones write SetTotalBaseImponibleRectificaciones;
     end;

  IFacturaService = interface( ISessionModule )
    ['{8B3338E1-C7F1-4784-B6B1-580BF5E2792B}']

    function SeleccionaRegistrosFrasExpedidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               SerieInicial,
                                               SerieFinal             : String;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False )  : IAcumuladoFacturacion;

    function SeleccionaRegistrosFrasRecibidas( DiarioTableName        : String;
                                               DeclaracionInformativa : Boolean;
                                               LibrosRegistro         : TLibrosRegistro;
                                               FechaInicial,
                                               FechaFinal             : TDateTime;
                                               PrimerNroOrden         : Integer = 0;
                                               PorTipoIVA             : Boolean = False;
                                               TipoIVA                : SmallInt = 0;
                                               PorTipoRetencion       : Boolean = False;
                                               TipoRetencion          : SmallInt = 0;
                                               SoloTablaResumen       : Boolean = False ) : IAcumuladoFacturacion;

    function ImportePendienteFacturaEmitida(     Ejercicio          : SmallInt;
                                                 Serie              : String;
                                                 NroFactura         : LongInt;
                                             out ImporteEfectos     : Decimal;
                                             out ImportePendiente   : Decimal ) : Boolean;

    function ObtenImportesFacturaEmitida(     Ejercicio     : SmallInt;
                                              Serie         : String;
                                              NroFactura    : Integer;
                                          out Asiento         : IAsiento;
                                          out BaseImponible,
                                              CuotaIVA,
                                              CuotaRE,
                                              ImporteTotal  : Decimal ) : Boolean;

    function ObtenImportesFacturaRecibida(     Ejercicio       : SmallInt;
                                               Propietario,
                                               SerieNroFactura : String;
                                           out Asiento         : IAsiento;
                                           out BaseImponible,
                                               CuotaIVA,
                                               ImporteTotal    : Decimal ) : Boolean;

    function ObtenRelacionOperacionesIntracomunitarias( OperacionesTableName : String;
                                                        Periodicidad         : SmallInt;
                                                        FechaInicial,
                                                        FechaFinal           : TDateTime ) : IAcumuladoOperacionesIntracomunitarias;

    procedure CompletaRegistroFacturaRecibida(     SubcuentaPropietario,
                                                   CodigoPais                    : String;
                                                   ModeloIVA                     : TModeloIVAProveedor;
                                               out TipoFactura                   : SmallInt;
                                               out RegimenOTrascendencia         : SmallInt;
                                               out TipoOperacionIntracomunitaria : SmallInt );

    procedure CompletaRegistroFacturaExpedida(     CodigoProvincia               : String;
                                                   CodigoPais                    : String;
                                                   Rectificativa                 : Boolean;
                                                   Simplificada                  : Boolean;
                                                   VentasOnline                  : Boolean;
                                               out TipoFactura                   : SmallInt;
                                               out RegimenOTrascendencia         : SmallInt;
                                               out CausaExencion                 : SmallInt );

    end;

  TListaRegistroFacturacion = TList<TRegistroFacturacion>;
  TSumasComparer = TComparer<TSumasFacturacion>;

  TAcumuladoFacturacion = class( TnxClass, InxRemoteableClass, IAcumuladoFacturacion )
    private

    FExisteCriterioCaja : Boolean;
    FNroRegistrosFacturacion : Integer;
    FTotalBaseImponibleIVA,
    FTotalCuotaIVA,
    FTotalBaseImponibleRE,
    FTotalCuotaRE,
    FTotalImporte : Decimal;

    FSumas : TList<TSumasFacturacion>;
    FSumasComparer : IComparer<TSumasFacturacion>;

    function GetExisteCriterioCaja : Boolean;
    function GetNroRegistrosFacturacion: Integer;
    function GetSumas: TList<TSumasFacturacion>;
    function GetTotalBaseImponibleIVA: Decimal;
    function GetTotalBaseImponibleRE: Decimal;
    function GetTotalCuotaIVA: Decimal;
    function GetTotalCuotaRE: Decimal;
    function GetTotalImporte: Decimal;
    procedure SetExisteCriterioCaja(const Value: Boolean );
    procedure SetNroRegistrosFacturacion(const Value: Integer);
    procedure SetTotalBaseImponibleIVA(const Value: Decimal);
    procedure SetTotalBaseImponibleRE(const Value: Decimal);
    procedure SetTotalCuotaIVA(const Value: Decimal);
    procedure SetTotalCuotaRE(const Value: Decimal);
    procedure SetTotalImporte(const Value: Decimal);

  public

    constructor Create;
    destructor Destroy; override;

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;
    function GetClassID: TnxGuid;

    function Obten( Fecha : TDate; CodigoPais : String; TipoImpositivo : SmallInt ) : TSumasFacturacion;
    procedure Acumula( RegistroFacturacion : TRegistroFacturacion );
    procedure OrdenaSumas;

    property ExisteRegistroCriterioCaja : Boolean read GetExisteCriterioCaja write SetExisteCriterioCaja;
    property NroRegistrosFacturacion : Integer read GetNroRegistrosFacturacion write SetNroRegistrosFacturacion;
    property Sumas : TList<TSumasFacturacion> read GetSumas;
    property TotalBaseImponibleIVA : Decimal read GetTotalBaseImponibleIVA write SetTotalBaseImponibleIVA;
    property TotalCuotaIVA : Decimal read GetTotalCuotaIVA write SetTotalCuotaIVA;
    property TotalBaseImponibleRE : Decimal read GetTotalBaseImponibleRE write SetTotalBaseImponibleRE;
    property TotalCuotaRE : Decimal read GetTotalCuotaRE write SetTotalCuotaRE;
    property TotalImporte : Decimal read GetTotalImporte write SetTotalImporte;
    end;

  TAcumuladoOperacionesIntracomunitarias = class( TnxClass, InxRemoteableClass, IAcumuladoOperacionesIntracomunitarias )
    private

    FNroRegistrosFacturacion,
    FNroRegistrosRectificaciones : Integer;
    FTotalBaseImponible,
    FTotalBaseImponibleRectificaciones : Decimal;

    function GetNroRegistrosFacturacion: Integer;
    function GetNroRegistrosRectificaciones: Integer;
    function GetTotalBaseImponible : Decimal;
    function GetTotalBaseImponibleRectificaciones: Decimal;
    procedure SetNroRegistrosFacturacion(const Value: Integer);
    procedure SetNroRegistrosRectificaciones(const Value: Integer);
    procedure SetTotalBaseImponible(const Value: Decimal);
    procedure SetTotalBaseImponibleRectificaciones(const Value: Decimal);

  public

    constructor Create;

    function LoadFromReader(aReader: InxReader): HRESULT;
    function SaveToWriter(AWriter: InxWriter): HRESULT;
    function GetClassID: TnxGuid;

    property NroRegistrosFacturacion : Integer read GetNroRegistrosFacturacion write SetNroRegistrosFacturacion;
    property NroRegistrosRectificaciones : Integer read GetNroRegistrosRectificaciones write SetNroRegistrosRectificaciones;
    property TotalBaseImponible : Decimal read GetTotalBaseImponible write SetTotalBaseImponible;
    property TotalBaseImponibleRectificaciones : Decimal read GetTotalBaseImponibleRectificaciones write SetTotalBaseImponibleRectificaciones;
    end;

implementation

{ TAcumuladoFacturacion }

constructor TAcumuladoFacturacion.Create;
begin
     inherited Create( @CLSID_AcumuladoFacturacion, nil, nil, False );

     FSumas := TList<TSumasFacturacion>.Create;

     FSumasComparer := TSumasComparer.Construct(
       function ( const Left, Right: TSumasFacturacion ) : Integer
         begin
         Result := ( Trunc( Left.FechaAplicacion ) + StrToIntDef( Left.CodigoPais, 0 ) + Left.TipoImpositivo ) - ( Trunc( Right.FechaAplicacion ) + StrToIntDef( Right.CodigoPais, 0 ) + Right.TipoImpositivo );
         end
       );
end;

destructor TAcumuladoFacturacion.Destroy;

var  SumasFacturacion : TSumasFacturacion;

begin
     // Cuidado, cuando se descarga como un interface FSumas no está asignado, puesto que no se llama a Create
     If   Assigned( FSumas )
     then begin
          For SumasFacturacion in FSumas do
            SumasFacturacion.Free;
          FSumas.Free;
          end;
     inherited;
end;

function TAcumuladoFacturacion.GetClassID: TnxGuid;
begin
     Result := CLSID_AcumuladoFacturacion;
end;

function TAcumuladoFacturacion.GetExisteCriterioCaja: Boolean;
begin
     Result := FExisteCriterioCaja;
end;

function TAcumuladoFacturacion.GetNroRegistrosFacturacion: Integer;
begin
     Result := FNroRegistrosFacturacion;
end;

function TAcumuladoFacturacion.GetSumas: TList<TSumasFacturacion>;
begin
     Result := FSumas;
end;

function TAcumuladoFacturacion.GetTotalBaseImponibleIVA: Decimal;
begin
     Result := FTotalBaseImponibleIVA;
end;

function TAcumuladoFacturacion.GetTotalBaseImponibleRE: Decimal;
begin
     Result := FTotalBaseImponibleRE;
end;

function TAcumuladoFacturacion.GetTotalCuotaIVA: Decimal;
begin
     Result := FTotalCuotaIVA;
end;

function TAcumuladoFacturacion.GetTotalCuotaRE: Decimal;
begin
     Result := FTotalCuotaRE;
end;

function TAcumuladoFacturacion.GetTotalImporte: Decimal;
begin
     Result := FTotalImporte;
end;

function TAcumuladoFacturacion.LoadFromReader( AReader : InxReader ) : HRESULT;
begin
     With AReader do
       begin
       FNroRegistrosFacturacion := ReadInteger;
       FTotalBaseImponibleIVA := ReadCurrency;
       FTotalCuotaIVA := ReadCurrency;
       FTotalBaseImponibleRE := ReadCurrency;
       FTotalCuotaRE := ReadCurrency;
       FTotalImporte := ReadCurrency;
       end;
end;

function TAcumuladoFacturacion.Obten( Fecha          : TDate;
                                      CodigoPais     : String;
                                      TipoImpositivo : SmallInt ) : TSumasFacturacion;

var  SumasFacturacion : TSumasFacturacion;

begin
     For SumasFacturacion in FSumas do
       If   ( SumasFacturacion.FechaAplicacion=Fecha ) and
            ( SumasFacturacion.CodigoPais=CodigoPais) and
            ( SumasFacturacion.TipoImpositivo=TipoImpositivo )
       then begin
            Result := SumasFacturacion;
            Exit;
            end;
     Result := nil;
end;

procedure TAcumuladoFacturacion.OrdenaSumas;
begin
     FSumas.Sort( FSumasComparer );
end;

function TAcumuladoFacturacion.SaveToWriter(AWriter: InxWriter): HRESULT;
begin
     With AWriter do
       begin
       WriteInteger( FNroRegistrosFacturacion );
       WriteCurrency( FTotalBaseImponibleIVA );
       WriteCurrency( FTotalCuotaIVA );
       WriteCurrency( FTotalBaseImponibleRE );
       WriteCurrency( FTotalCuotaRE );
       WriteCurrency( FTotalImporte );
       end;
     Result := S_OK;
end;

procedure TAcumuladoFacturacion.SetExisteCriterioCaja(const Value: Boolean);
begin
     FExisteCriterioCaja := Value;
end;

procedure TAcumuladoFacturacion.SetNroRegistrosFacturacion(const Value: Integer);
begin
     FNroRegistrosFacturacion := Value;
end;

procedure TAcumuladoFacturacion.SetTotalBaseImponibleIVA(const Value: Decimal);
begin
     FTotalBaseImponibleIVA := Value;
end;

procedure TAcumuladoFacturacion.SetTotalBaseImponibleRE(const Value: Decimal);
begin
     FTotalBaseImponibleRE := Value;
end;

procedure TAcumuladoFacturacion.SetTotalCuotaIVA(const Value: Decimal);
begin
     FTotalCuotaIVA := Value;
end;

procedure TAcumuladoFacturacion.SetTotalCuotaRE(const Value: Decimal);
begin
     FTotalCuotaRE := Value;
end;

procedure TAcumuladoFacturacion.SetTotalImporte(const Value: Decimal);
begin
     FTotalImporte := Value;
end;

procedure TAcumuladoFacturacion.Acumula( RegistroFacturacion : TRegistroFacturacion );

var  SumasFacturacion : TSumasFacturacion;
     FacturaRectificativa : Boolean;

begin

     SumasFacturacion := Obten( RegistroFacturacion.FechaAplicacion, RegistroFacturacion.CodigoPais, RegistroFacturacion.TipoImpositivo );
     If   not Assigned( SumasFacturacion )
     then begin
          SumasFacturacion := TSumasFacturacion.Create;
          SumasFacturacion.FechaAplicacion :=  RegistroFacturacion.FechaAplicacion;
          SumasFacturacion.CodigoPais :=  RegistroFacturacion.CodigoPais;
          SumasFacturacion.TipoImpositivo :=  RegistroFacturacion.TipoImpositivo;
          FSumas.Add( SumasFacturacion );
          end;

     //* 07.04.2000 Modificado para que acumule la base en tipos de I.V.A. al 0%
     //* 10.08.2010 Ahora es el tipo impositivo y no el valor de la cuota lo que determina si una base es exenta o no.
     //             Esta modificación se ha hecho para solucionar un problema con bases imponibles tan pequeñas que no tienen cuota de IVA (por ejemplo 0,02€ con un tipo del 18%)

     DecAdd( FTotalBaseImponibleIVA, RegistroFacturacion.BaseImponible );
     DecAdd( SumasFacturacion.BaseImponibleIVA, RegistroFacturacion.BaseImponible );

     If   not( ( RegistroFacturacion.TipoImpositivo=0 ) or ( RegistroFacturacion.TipoIVA=0.0 ) )
     then begin
          DecAdd( SumasFacturacion.CuotaIVA, RegistroFacturacion.CuotaIVA );
          DecAdd( FTotalCuotaIVA, RegistroFacturacion.CuotaIVA );
          If   RegistroFacturacion.CuotaRE<>0.0
          then begin
               DecAdd( SumasFacturacion.BaseImponibleRE, RegistroFacturacion.BaseImponible );
               DecAdd( SumasFacturacion.CuotaRE, RegistroFacturacion.CuotaRE );

               DecAdd( FTotalBaseImponibleRE, RegistroFacturacion.BaseImponible );
               DecAdd( FTotalCuotaRE, RegistroFacturacion.CuotaRE );
               end;
          end;

     DecAdd( SumasFacturacion.Importe, RegistroFacturacion.Importe );
     DecAdd( FTotalImporte, RegistroFacturacion.Importe );

     Inc( FNroRegistrosFacturacion );

end;

{ TAcumuladoOperacionesIntracomunitarias }

constructor TAcumuladoOperacionesIntracomunitarias.Create;
begin
     inherited Create( @CLSID_AcumuladoOperacionesIntracomunitarias, nil, nil, False );
end;

function TAcumuladoOperacionesIntracomunitarias.GetClassID: TnxGuid;
begin
     Result := CLSID_AcumuladoOperacionesIntracomunitarias;
end;

function TAcumuladoOperacionesIntracomunitarias.GetNroRegistrosFacturacion: Integer;
begin
     Result := FNroRegistrosFacturacion;
end;

function TAcumuladoOperacionesIntracomunitarias.GetNroRegistrosRectificaciones: Integer;
begin
     Result := FNroRegistrosRectificaciones;
end;

function TAcumuladoOperacionesIntracomunitarias.GetTotalBaseImponible : Decimal;
begin
     Result := FTotalBaseImponible;
end;

function TAcumuladoOperacionesIntracomunitarias.GetTotalBaseImponibleRectificaciones : Decimal;
begin
     Result := FTotalBaseImponibleRectificaciones;
end;

function TAcumuladoOperacionesIntracomunitarias.LoadFromReader(aReader: InxReader): HRESULT;
begin
     With AReader do
       begin
       FNroRegistrosFacturacion := ReadInteger;
       FNroRegistrosRectificaciones := ReadInteger;
       FTotalBaseImponible := ReadCurrency;
       FTotalBaseImponibleRectificaciones := ReadCurrency;
       end;
end;

function TAcumuladoOperacionesIntracomunitarias.SaveToWriter(AWriter: InxWriter): HRESULT;
begin
     With AWriter do
       begin
       WriteInteger( FNroRegistrosFacturacion );
       WriteInteger( FNroRegistrosRectificaciones );
       WriteCurrency( FTotalBaseImponible );
       WriteCurrency( FTotalBaseImponibleRectificaciones );
       end;
     Result := S_OK;
end;

procedure TAcumuladoOperacionesIntracomunitarias.SetNroRegistrosFacturacion(const Value: Integer);
begin
     FNroRegistrosFacturacion := Value;
end;

procedure TAcumuladoOperacionesIntracomunitarias.SetNroRegistrosRectificaciones(const Value: Integer);
begin
     FNroRegistrosRectificaciones := Value;
end;

procedure TAcumuladoOperacionesIntracomunitarias.SetTotalBaseImponible(const Value: Decimal);
begin
     FTotalBaseImponible := Value;
end;

procedure TAcumuladoOperacionesIntracomunitarias.SetTotalBaseImponibleRectificaciones(const Value: Decimal);
begin
     FTotalBaseImponibleRectificaciones := Value;
end;

var  AcumuladoFacturacionControl,
     AcumuladoOperacionesIntracomunitariasControl : InxClassFactoryControl;

initialization
     nxInvokeRegistry.RegisterInterface( TypeInfo( IFacturaService ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( IAcumuladoFacturacion ) );
     nxInvokeRegistry.RegisterInterface( TypeInfo( IAcumuladoOperacionesIntracomunitarias) );

     TnxClassFactory.RegisterClass( CLSID_AcumuladoFacturacion, TAcumuladoFacturacion, AcumuladoFacturacionControl );
     TnxClassFactory.RegisterClass( CLSID_AcumuladoOperacionesIntracomunitarias, TAcumuladoOperacionesIntracomunitarias, AcumuladoOperacionesIntracomunitariasControl );

end.


