{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dm_sfe;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Generics.Collections,

  LibUtils,
  AppContainer,

  AppForms,
  DB,
  nxdb,
  DataManager,

  cxEdit,
  cxEditRepositoryItems,

  System.Net.HttpClient,
  System.Net.URLClient,

  Soap.SOAPHTTPTrans,
  Soap.SOAPDomConv,
  Soap.InvokeRegistry,
  Soap.Rio,
  Soap.SOAPHTTPClient,
  Soap.OPToSOAPDomConv,

  clCertificate,
  clHttpRequest,
  clHttpRio,
  clTcpClient,
  clTcpClientTls,
  clHttp,
  clSoapMessage,
  clXmlUtils,
  clSOAPSecurity,
  clCookieManager,

  WinInet,

  SuministroFactEmitidas,

  Gim00Fields,
  Gim10Fields,

  AsientoIntf,

  dmi_iva,
  dmi_ast,

  dm_rpf;


type

  TSFEmitidasModule = class(TDataModule)
    ApunteTable: TnxeTable;
    AsientoTable: TnxeTable;
    AsientoFacturaTable: TnxeTable;
    HttpRio: TclHttpRio;
    Http: TclHttp;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HttpGetCertificate(Sender: TObject; var ACertificate: TclCertificate; AExtraCerts: TclCertificateList; var Handled: Boolean);
    procedure HttpRioBeforeExecute(const MethodName: string; SOAPRequest: TStream);
    procedure HttpReceiveResponse(Sender: TObject; const AMethod, AUrl: string; AResponseHeader: TStrings; ACookies: TclCookieList);

  private

    DecimalFormatSettings,
    TimeStampFormatSettings : TFormatSettings;

    AsientoFields : TAsientoFields;
    ApunteFields : TApunteFields;

    FacturaFields : TFacturaFields;
    AsientoFacturaFields : TAsientoFields;
    ClienteFields : TClienteFields;
    ProveedorFields : TProveedorFields;
    TiposIVAFields : TTiposIVAFields;
    // SerieFacturacionFields : TSerieFacturacionFields;
    PaisFields : TPaisFields;

    ListaDesgloseCuotasIVA : TList< TDesgloseCuotasIVA >;
    EjercicioPresentacion : SmallInt;

    CodigoPaisIVA : String;

    function ObtenCountryType2(Value: String): CountryType2;
    function ObtenIdOperacionesTrascendenciaTributariaType(Value: SmallInt; FacturaEmitida : Boolean = True ): IdOperacionesTrascendenciaTributariaType;
    function ObtenIDType(Value: SmallInt): PersonaFisicaJuridicaIDTypeType;
    function ObtenSituacionInmueble(Value: SmallInt): SituacionInmuebleType;
    function ObtenClaveTipoFacturaEmitida(Value: SmallInt): ClaveTipoFacturaType;
    function ObtenClaveTipoFacturaRecibida(Value: SmallInt): ClaveTipoFacturaType;
    function ObtenCausaExencionType(Value: SmallInt): CausaExencionType;
    function ObtenEstadoCuadreType(Value: SmallInt): EstadoCuadreType;

  public

    function SuministroFacturasEmitidas( Operacion : TOperacionFacturasSII; Periodo : SmallInt; FechaPresentacionConsulta : TDate; RelacionFacturasCacheDataset : TnxeCachedDataSet; ActualizarEstadoFacturas : Boolean = False ) : String;

  end;


var SFEmitidasModule: TSFEmitidasModule = nil;

function  SFEmitidas : TSFEmitidasModule;

implementation

uses Math,
     Variants,
     EnterpriseDataAccess,
     AppManager,
     DateUtils,
     WebBrowser,

     SBWinCrypt,

     Gdm00Dm,

     dmi_fac,

     dm_cer,
     dm_sub,
     dm_pai,
     dm_pga,
     dm_iex,
     dm_iva,
     dm_sdf,
     dm_ast,
     dm_fac,

     dm_cli,
     dm_pro,

     f_prg;

{$R *.DFM}

type
     TTipoDesgloseIVA = ( tdFactura, tdPrestacionServicios, tdEntregas );

resourceString
     WSDLSuministroFactEmitidas = 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroFactEmitidas.wsdl';
     URLSuministroFactEmitidas = 'https://www1.agenciatributaria.gob.es/wlpl/SSII-FACT/ws/fe/SiiFactFEV1SOAP';

function SFEmitidas : TSFEmitidasModule;
begin
     CreateDataModule( TSFEmitidasModule, SFEmitidasModule );
     Result := SFEmitidasModule;
end;

procedure TSFEmitidasModule.DataModuleCreate(Sender: TObject);
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     AsientoFacturaFields := TAsientoFields.Create( AsientoFacturaTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     ClienteFields := TClienteFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
     // SerieFacturacionFields := TSerieFacturacionFields.Create( Self );
     FacturaFields := TFacturaFields.Create( Self );
     PaisFields := TPaisFields.Create( Self );

     DecimalFormatSettings := TFormatSettings.Create;
     DecimalFormatSettings.DecimalSeparator := '.';

     TimeStampFormatSettings := TFormatSettings.Create;
     TimeStampFormatSettings.ShortDateFormat := 'dd-mm-yyyy';
     TimeStampFormatSettings.DateSeparator := '-';

     ListaDesgloseCuotasIVA := TList< TDesgloseCuotasIVA >.Create;
     EjercicioPresentacion := YearOf( ApplicationContainer.TodayDate );

end;

procedure TSFEmitidasModule.DataModuleDestroy(Sender: TObject);
begin
     FreeAndNil( ListaDesgloseCuotasIVA );
     SFEmitidasModule := nil;
end;

procedure TSFEmitidasModule.HttpGetCertificate(     Sender       : TObject;
                                                var ACertificate : TclCertificate;
                                                    AExtraCerts  : TclCertificateList;
                                                var Handled      : Boolean );
begin
     ACertificate := Certificados.CertificadoUsuario;
     Handled := True;
end;

procedure TSFEmitidasModule.HttpReceiveResponse(Sender: TObject; const AMethod, AUrl: string; AResponseHeader: TStrings; ACookies: TclCookieList);
begin
     RegistroPresentacion.AddResponseHeader( AMethod, AResponseHeader );
end;

procedure TSFEmitidasModule.HttpRioBeforeExecute(const MethodName: string; SOAPRequest: TStream);

var sTmp : TStringList;
    sText : String;

begin
     { DEBUG Aqui puedo comprobar el texto XML enviado
     sTmp := TStringList.Create;
     try
       SOAPRequest.Position := 0;
       sTmp.LoadFromStream( SOAPRequest );
       sText := sTmp.Text;
     finally
       sTmp.Free;
       end;
     }
end;

function TSFEmitidasModule.ObtenIDType( Value : SmallInt ) : PersonaFisicaJuridicaIDTypeType;
begin
     Result := PersonaFisicaJuridicaIDTypeType( Value );
end;

function TSFEmitidasModule.ObtenCountryType2( Value : String ) : CountryType2;
begin
     If   Value='DO'
     then Result := CountryType2.DO_
     else If   Value='IN'
          then Result := CountryType2.IN_
          else If   Value='IS'
               then Result := CountryType2.IS_
               else If   Value='AS'
                    then Result := CountryType2.AS_
                    else If   Value='TO'
                         then Result := CountryType2.TO_
                         else Result := TEnumUtils.GetAs< CountryType2 >( Value );
end;

function TSFEmitidasModule.ObtenIdOperacionesTrascendenciaTributariaType( Value : SmallInt; FacturaEmitida : Boolean = True ) : IdOperacionesTrascendenciaTributariaType;
begin
     Result := IdOperacionesTrascendenciaTributariaType( Value );     
end;

function TSFEmitidasModule.ObtenCausaExencionType( Value : SmallInt  ) : CausaExencionType;
begin
     Result := CausaExencionType( Value );
end;

function TSFEmitidasModule.ObtenClaveTipoFacturaEmitida( Value : SmallInt ) : ClaveTipoFacturaType;
begin
     case Value of
       0 : Result := ClaveTipoFacturaType.F1;
       1 : Result := ClaveTipoFacturaType.F2;
       2 : Result := ClaveTipoFacturaType.F3;
       3 : Result := ClaveTipoFacturaType.F4;
       4 : Result := ClaveTipoFacturaType.R1;
       5 : Result := ClaveTipoFacturaType.R2;
       6 : Result := ClaveTipoFacturaType.R3;
       7 : Result := ClaveTipoFacturaType.R4;
       8 : Result := ClaveTipoFacturaType.R5;
       end;
end;

function TSFEmitidasModule.ObtenClaveTipoFacturaRecibida( Value : SmallInt ) : ClaveTipoFacturaType;
begin
     case Value of
       0 : Result := ClaveTipoFacturaType.F1;
       1 : Result := ClaveTipoFacturaType.F2;
       2 : Result := ClaveTipoFacturaType.F3;
       3 : Result := ClaveTipoFacturaType.F4;
       4 : Result := ClaveTipoFacturaType.F5;
       5 : Result := ClaveTipoFacturaType.F6;
       6 : Result := ClaveTipoFacturaType.R1;
       7 : Result := ClaveTipoFacturaType.R2;
       8 : Result := ClaveTipoFacturaType.R3;
       9 : Result := ClaveTipoFacturaType.R4;
      10 : Result := ClaveTipoFacturaType.R5;
       end;
end;

function TSFEmitidasModule.ObtenSituacionInmueble( Value : SmallInt ) : SituacionInmuebleType;
begin
     Result := SituacionInmuebleType( Value );
end;

function TSFEmitidasModule.ObtenEstadoCuadreType( Value : SmallInt  ) : EstadoCuadreType;
begin
     Result := EstadoCuadreType( Value );
end;

function TSFEmitidasModule.SuministroFacturasEmitidas( Operacion                    : TOperacionFacturasSII;
                                                       Periodo                      : SmallInt;   // Mes
                                                       FechaPresentacionConsulta    : TDate;
                                                       RelacionFacturasCacheDataset : TnxeCachedDataSet;
                                                       ActualizarEstadoFacturas     : Boolean = False ) : String;

var  siiSOAPFactEmitidas : SuministroFactEmitidas.siiSOAP;

     Cabecera : CabeceraSii;
     CabeceraConsulta : CabeceraConsultaSii;
     CabeceraBaja : CabeceraSiiBaja;
     TitularUnico : PersonaFisicaJuridicaUnicaESType;
     Titular : PersonaFisicaJuridicaESType;
     FiltroEmitidas : LRFiltroEmitidasType;
     PeriodoLiq : PeriodoLiquidacion;

     SuministroLRFrasEmitidas : SuministroLRFacturasEmitidas;
     ConsultaLRFrasEmitidas : ConsultaLRFacturasEmitidas;
     RespuestaConsultaLRFrasEmitidas : RespuestaConsultaLRFacturasEmitidas;
     RespuestaLRFrasEmitidas : RespuestaLRFacturasEmitidas;

     RegistroLRFacturasEmitidas : Array_Of_LRfacturasEmitidasType;
     LRfacturaEmitida : LRfacturasEmitidasType;
     IDFacturaExpedida : IDFacturaExpedidaType;
     IDEmisorFactura3LR : IDEmisorFactura8;
     FacturaExpedida : FacturaExpedidaType;
     Contraparte : PersonaFisicaJuridicaType;
     IDOtro : IDOtroType;
     DatosInmueble : DatosInmuebleType;
     DesgloseRectificacion : DesgloseRectificacionType;
     TipoDesglose : TipoDesglose3;
     DesgloseFactura : TipoSinDesgloseType;
     DesgloseTipoOperacion : TipoConDesgloseType;
     DesglosePrestacionServicios : TipoSinDesglosePrestacionType;
     DesgloseEntregas : TipoSinDesgloseType;
     Sujeta : SujetaType;
     SujetaPrestacion : SujetaPrestacionType;

     I : SmallInt;

     RangoFechaPresentacion : RangoFechaPresentacionType;
     RelacionFacturasQuery : TnxeQuery;
     RegistroLRFacturasEmitidasList : TList<LRfacturasEmitidasType>;
     LRfacturasEmitidas : LRfacturasEmitidasType;
     RespuestaExpedida : RespuestaExpedidaType;
     RespuestaExpedidaBaja : RespuestaExpedidaBajaType;
     RegistroRespuestaConsultaEmitidas : RegistroRespuestaConsultaEmitidasType;
     IDFacturaAR : IDFacturaARType;
     ImporteRectificacion : DesgloseRectificacionType;

     AnulacionLRFacturasEmitidas : BajaLRFacturasEmitidas;
     RegistroLRBajaExpedidasList : TList<LRBajaExpedidasType>;
     RespuestaLRBajaFrasEmitidas : RespuestaLRBajaFacturasEmitidas;
     LRBajaExpedidas : LRBajaExpedidasType;
     IDFacturaExpedidaBC : IDFacturaExpedidaBCType;
     IDEmisorFacturaBC : IDEmisorFactura9;

     RelacionFacturasCacheFields : TRelacionFacturasPresentacionFields;

     VentasOnline,
     FacturaPrimerSemestre : Boolean;
     RegimenOTrascendencia : SmallInt;

     DescripcionOperacion,
     NIFPropietario,
     Serie : String;
     NroFactura : LongInt;
     Asiento : IAsiento;
     BaseImponible,
     BaseImponibleExenta,
     BaseImponibleNoSujeta,
     CuotaIVA,
     CuotaRE,
     ImporteFactura,
     ImportePresentacion,

     BaseImponibleRectificada,
     CuotaIVARectificada,
     ImporteFacturaRectificada : Decimal;

     FechaPresentacion : TDate;
     DesglosePorTipoOperacion : Boolean;

     NotificationMessage : TNotificationType;
     EstadoRegistro : EstadoRegistroType;

function ObtenImportePresentacionFacturaEmitida( DatosFacturaEmitida : FacturaRespuestaExpedidaType ) : Decimal;

var  I : SmallInt;
     NoEx2 : NoExenta2;
     NoEx : NoExenta;

begin
     Result := 0.0;

     If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseFactura )
     then begin
          NoEx2 := DatosFacturaEmitida.TipoDesglose.DesgloseFactura.Sujeta.NoExenta;
          If   Assigned( NoEx2 )
          then For I := 0 to Length( NoEx2.DesgloseIVA ) - 1 do  // DesgloseIVA2 = array of DetalleIVAEmitidaType;
                   With NoEx2.DesgloseIVA[ I ] do
                     Result := Result +
                               StrToCurrDef( BaseImponible, 0.0, DecimalFormatSettings ) +
                               StrToCurrDef( CuotaRepercutida, 0.0, DecimalFormatSettings ) +
                               StrToCurrDef( CuotaRecargoEquivalencia, 0.0, DecimalFormatSettings );

          If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseFactura.Sujeta.Exenta )
          then Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseFactura.Sujeta.Exenta[ 0 ].BaseImponible, 0.0, DecimalFormatSettings );
               
          If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseFactura.NoSujeta )
          then begin
               Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseFactura.NoSujeta.ImportePorArticulos7_14_Otros, 0.0, DecimalFormatSettings );
               Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseFactura.NoSujeta.ImporteTAIReglasLocalizacion, 0.0, DecimalFormatSettings );
               end;

          end
     else If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion )
          then begin

               // Desglose prestacion servicios

               If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios )
               then begin
                    NoEx := DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.Sujeta.NoExenta;
                    If   Assigned( NoEx )
                    then For I := 0 to Length( NoEx.DesgloseIVA ) - 1 do  // DesgloseIVA3 = array of DetalleIVAEmitidaPrestacionType
                             With NoEx.DesgloseIVA[ I ] do
                               Result := Result +
                                         StrToCurrDef( BaseImponible, 0.0, DecimalFormatSettings ) +
                                         StrToCurrDef( CuotaRepercutida, 0.0, DecimalFormatSettings );

                    If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.Sujeta.Exenta )
                    then Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.Sujeta.Exenta[ 0 ].BaseImponible, 0.0, DecimalFormatSettings );

                    If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.NoSujeta )
                    then begin
                         Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.NoSujeta.ImportePorArticulos7_14_Otros, 0.0, DecimalFormatSettings );
                         Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.PrestacionServicios.NoSujeta.ImporteTAIReglasLocalizacion, 0.0, DecimalFormatSettings );
                         end;

                    end;

               // Desglose entregas

               If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega )
               then begin
                    NoEx2 := DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.Sujeta.NoExenta;
                    If   Assigned( NoEx2 )
                    then For I := 0 to Length( NoEx2.DesgloseIVA ) - 1 do  // DesgloseIVA2 = array of DetalleIVAEmitidaType
                             With NoEx2.DesgloseIVA[ I ] do
                               Result := Result +
                                         StrToCurrDef( BaseImponible, 0.0, DecimalFormatSettings ) +
                                         StrToCurrDef( CuotaRepercutida, 0.0, DecimalFormatSettings ) +
                                         StrToCurrDef( CuotaRecargoEquivalencia, 0.0, DecimalFormatSettings );

                    If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.Sujeta.Exenta )
                    then Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.Sujeta.Exenta[ 0 ].BaseImponible, 0.0, DecimalFormatSettings );

                    If   Assigned( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.NoSujeta )
                    then begin
                         Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.NoSujeta.ImportePorArticulos7_14_Otros, 0.0, DecimalFormatSettings );
                         Result := Result + StrToCurrDef( DatosFacturaEmitida.TipoDesglose.DesgloseTipoOperacion.Entrega.NoSujeta.ImporteTAIReglasLocalizacion, 0.0, DecimalFormatSettings );
                         end;

                    end;

               end;


end;

function ObtenDesgloseCuotasIVA : Decimal;  // Devuelve el importe total de la factura

var  Cuenta : String;
     DesgloseCuotasIVA : TDesgloseCuotasIVA;
     PrestacionServicios : Boolean;
     Encontrado : Boolean;

begin

     Result := 0.0;
     ListaDesgloseCuotasIVA.Clear;

     With ApunteTable do
       try
         SetRange( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, 2  ],
                   [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, MaxSmallint  ] );
         First;
         While not Eof and ( ApunteFields.TipoApunte.Value=tapManual ) do
           begin

           PrestacionServicios := Copy( ApunteFields.Subcuenta.Value, 1, 3 )='705';
           Tasa.TipoIVA( ApunteFields.Fecha.Value, CodigoPaisIVA, ApunteFields.Tipo.Value, TiposIVAFields );

           Encontrado := False;
           For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
             If   ( DesgloseCuotasIVA.PrestacionServicios=PrestacionServicios ) and
                  ( DesgloseCuotasIVA.TipoImpositivo=TiposIVAFields.IVARepercutido.Value )  // Ya existe un registro de este tipo impositivo
             then begin
                  DesgloseCuotasIVA.BaseImponible := DesgloseCuotasIVA.BaseImponible + ApunteFields.BaseImponible.Value;
                  DesgloseCuotasIVA.CuotaIVA := DesgloseCuotasIVA.CuotaIVA + ApunteFields.CuotaIVA.Value;
                  DesgloseCuotasIVA.CuotaRE := DesgloseCuotasIVA.CuotaRE + ApunteFields.CuotaRE.Value;
                  Encontrado := True;
                  Break;
                  end;

           If   not Encontrado
           then begin
                DesgloseCuotasIVA := TDesgloseCuotasIVA.Create;
                DesgloseCuotasIVA.PrestacionServicios := PrestacionServicios;
                DesgloseCuotasIVA.TipoImpositivo := TiposIVAFields.IVARepercutido.Value;
                DesgloseCuotasIVA.TipoRecargoEquivalencia := TiposIVAFields.RERepercutido.Value;
                DesgloseCuotasIVA.BaseImponible := ApunteFields.BaseImponible.Value;
                DesgloseCuotasIVA.CuotaIVA := ApunteFields.CuotaIVA.Value;
                DesgloseCuotasIVA.CuotaRE := ApunteFields.CuotaRE.Value;
                ListaDesgloseCuotasIVA.Add( DesgloseCuotasIVA );
                end;

           DecAdd( Result, ApunteFields.ImporteTotal.Value );

           Next;
           end;

       finally
         CancelRange;
         end;

end;

// TTipoDesgloseIVA = tdFactura, tdEntregas

function ObtenDesgloseIVANoEx( TipoDesglose : TTipoDesgloseIVA ) : SujetaType;

var  NoEx2 : NoExenta2;
     DetalleExenta : DetalleExentaType;
     ListaDetalleIVAEmitida : TList<DetalleIVAEmitidaType>;
     DetalleIVAEmitida : DetalleIVAEmitidaType;
     DesgloseCuotasIVA : TDesgloseCuotasIVA;
     ExentaArray : Exenta2;
     TieneBaseExenta : Boolean;

begin

     BaseImponibleExenta := 0.0;
     BaseImponibleNoSujeta := 0.0;
     TieneBaseExenta := False;

     ListaDetalleIVAEmitida :=  TList<DetalleIVAEmitidaType>.Create;

     try

       For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
         If   ( TipoDesglose=tdFactura ) or ( ( TipoDesglose=tdEntregas ) and not DesgloseCuotasIVA.PrestacionServicios )
         then If   ( DesgloseCuotasIVA.TipoImpositivo=0.0 ) and

                   ( ( ClienteFields.Factura_ModeloIVA.Value=micExento ) or       // 02.10.2024 Ahora las bases de los clientes exentos de I.V.A. no se pasan con tipo 0, sino con base exenta

                     ( ( AsientoFields.Origen.Value<>ofrInversionSP ) and

                       ( ( ClienteFields.CodigoPais.Value<>CodigoEspaña ) or      // 08.02.2023 Ahora las bases imponibles sin IVA nacionales ya no son exentas

                         ( ClienteFields.CodigoPais.Value=CodigoEspaña ) and
                         ( ( ClienteFields.CodigoProvincia.Value='35' ) or        // Excepto Canarias, Ceuta y Melilla
                           ( ClienteFields.CodigoProvincia.Value='38' ) or
                           ( ClienteFields.CodigoProvincia.Value='51' ) or
                           ( ClienteFields.CodigoProvincia.Value='52' ) ) ) ) )

              then begin
                    DecAdd( BaseImponibleExenta, DesgloseCuotasIVA.BaseImponible );
                    TieneBaseExenta := True;  // La base exenta puede ser 0.0
                    end
              else If   VentasOnline
                   then DecAdd( BaseImponibleNoSujeta, DesgloseCuotasIVA.BaseImponible )
                   else begin

                        DetalleIVAEmitida := DetalleIVAEmitidaType.Create;
                        DetalleIVAEmitida.BaseImponible := DecimalString( DesgloseCuotasIVA.BaseImponible );

                        If   not FacturaPrimerSemestre
                        then begin

                             DetalleIVAEmitida.TipoImpositivo := DecimalString( DesgloseCuotasIVA.TipoImpositivo );
                             DetalleIVAEmitida.CuotaRepercutida := DecimalString( DesgloseCuotasIVA.CuotaIVA );

                             If   DesgloseCuotasIVA.CuotaRE<>0.0
                             then begin
                                  DetalleIVAEmitida.TipoRecargoEquivalencia := DecimalString( DesgloseCuotasIVA.TipoRecargoEquivalencia );
                                  DetalleIVAEmitida.CuotaRecargoEquivalencia := DecimalString( DesgloseCuotasIVA.CuotaRE );
                                  end;

                             end;

                        ListaDetalleIVAEmitida.Add( DetalleIVAEmitida );
                        end;

       If   ( ListaDetalleIVAEmitida.Count>0 ) or
            TieneBaseExenta
       then begin

            Sujeta := SujetaType.Create;

            If   ListaDetalleIVAEmitida.Count>0
            then begin

                 NoEx2 := NoExenta2.Create;

                 If   AsientoFields.Origen.Value=ofrInversionSP
                 then NoEx2.TipoNoExenta := TipoOperacionSujetaNoExentaType.S2
                 else NoEx2.TipoNoExenta := TipoOperacionSujetaNoExentaType.S1;

                 NoEx2.DesgloseIVA := DesgloseIVA3( ListaDetalleIVAEmitida.ToArray );

                 {
                 S1 Sujeta – No Exenta
                 S2 Sujeta – No Exenta - Inv. Suj. Pasivo
                 }

                 Sujeta.NoExenta := NoEx2;

                 end;

            If   TieneBaseExenta
            then begin

                 DetalleExenta := DetalleExentaType.Create;
                 DetalleExenta.BaseImponible := DecimalString( BaseImponibleExenta );

                 {
                 L9 Causa de exención de operaciones sujetas y exentas

                 E1 Exenta por el artículo 20
                 E2 Exenta por el artículo 21
                 E3 Exenta por el artículo 22
                 E4 Exenta por artículo 23 y 24
                 E5 Exenta por el artículo 25
                 E6 Exenta por Otros
                 }

                 DetalleExenta.CausaExencion := ObtenCausaExencionType( FacturaFields.CausaExencion.Value );

                 ExentaArray :=  Exenta2.Create( DetalleExenta );
                 Sujeta.Exenta := ExentaArray;
                 end;

            end
       else Sujeta := nil;

     finally
       ListaDetalleIVAEmitida.Free;
       end;

     Result := Sujeta;

end;

function ObtenPrestacionDesgloseIVANoEx : SujetaPrestacionType;

var  NoEx2 : NoExenta2;
     NoEx : NoExenta;
     DetalleExenta : DetalleExentaType;
     ListaDetalleIVAEmitidaPrestacion :  TList<DetalleIVAEmitidaPrestacionType>;
     DetalleIVAEmitidaPrestacion : DetalleIVAEmitidaPrestacionType;
     DesgloseCuotasIVA : TDesgloseCuotasIVA;
     ExentaArray : Exenta;

begin

     BaseImponibleExenta := 0.0;
     BaseImponibleNoSujeta := 0.0;

     ListaDetalleIVAEmitidaPrestacion :=  TList<DetalleIVAEmitidaPrestacionType>.Create;

     try

       For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
           If   DesgloseCuotasIVA.PrestacionServicios
           then begin

                If   ( AsientoFields.Origen.Value<>ofrInversionSP ) and
                     ( DesgloseCuotasIVA.TipoImpositivo=0.0 )
                then DecAdd( BaseImponibleExenta, DesgloseCuotasIVA.BaseImponible )
                else If   VentasOnline
                     then DecAdd( BaseImponibleNoSujeta, DesgloseCuotasIVA.BaseImponible )
                     else begin

                          DetalleIVAEmitidaPrestacion := DetalleIVAEmitidaPrestacionType.Create;
                          DetalleIVAEmitidaPrestacion.BaseImponible := DecimalString( DesgloseCuotasIVA.BaseImponible );

                          If   not FacturaPrimerSemestre and
                               not VentasOnline
                          then begin
                               DetalleIVAEmitidaPrestacion.TipoImpositivo := DecimalString( DesgloseCuotasIVA.TipoImpositivo );
                               DetalleIVAEmitidaPrestacion.CuotaRepercutida := DecimalString( DesgloseCuotasIVA.CuotaIVA );
                               end;

                          If   DesgloseCuotasIVA.CuotaRE<>0.0
                          then begin
                               ShowNotification( ntStop, RpfMsg11, Format( RpfMsg6, [ Factura.TextoSerieNroFactura( AsientoFields.Serie.Value, AsientoFields.Nrofactura.Value ) ] ) );
                               Abort;
                               end;

                          ListaDetalleIVAEmitidaPrestacion.Add( DetalleIVAEmitidaPrestacion );
                          end;

                end;

     If   ( ListaDetalleIVAEmitidaPrestacion.Count>0 ) or
          ( BaseImponibleExenta<>0.0 )
     then begin

          SujetaPrestacion := SujetaPrestacionType.Create;

          If   ListaDetalleIVAEmitidaPrestacion.Count>0
          then begin

               NoEx := NoExenta.Create;

               If   AsientoFields.Origen.Value=ofrInversionSP
               then NoEx.TipoNoExenta := TipoOperacionSujetaNoExentaType.S2
               else NoEx.TipoNoExenta := TipoOperacionSujetaNoExentaType.S1;

               NoEx.DesgloseIVA := DesgloseIVA2( ListaDetalleIVAEmitidaPrestacion.ToArray );

               SujetaPrestacion.NoExenta := NoEx;
               end;

          If   BaseImponibleExenta<>0.0
          then begin
               DetalleExenta := DetalleExentaType.Create;
               DetalleExenta.BaseImponible := DecimalString( BaseImponibleExenta );
               DetalleExenta.CausaExencion := ObtenCausaExencionType( FacturaFields.CausaExencion.Value );
               ExentaArray := Exenta.Create( DetalleExenta );
               SujetaPrestacion.Exenta := ExentaArray;
               end;

          end
     else SujetaPrestacion := nil;


     finally
       ListaDetalleIVAEmitidaPrestacion.Free;
       end;

     Result := SujetaPrestacion;

end;

begin

     Certificados.CompruebaCertificadoUsuario;

     RelacionFacturasCacheFields := TRelacionFacturasPresentacionFields.Create( RelacionFacturasCacheDataset );

     // siiSOAPFactEmitidas := GetsiiSOAP( { UseWSDL } True, '', HTTPRIO  );  -- > No lo utilizo porque HTTPRIO es un TclHTTPRIO. Por eso tengo que definir WSDLLocation y demás a mano.

     HttpRio.WSDLLocation := WSDLSuministroFactEmitidas;
     HttpRio.URL := URLSuministroFactEmitidas;
     HttpRio.Service := 'siiService';

     If   DataModule00.DmEmpresaFields.Contable_EntornoPruebasSII.Value
     then HttpRio.Port := 'SuministroFactEmitidasPruebas'
     else HttpRio.Port := 'SuministroFactEmitidas';

     siiSOAPFactEmitidas := ( HttpRio as SuministroFactEmitidas.siiSOAP );

     try

       case Operacion of
         ofAnulacion:
           begin

           AnulacionLRFacturasEmitidas := BajaLRFacturasEmitidas.Create;
           RegistroLRBajaExpedidasList := TList<LRBajaExpedidasType>.Create;

           try

              With RelacionFacturasCacheDataset do
               begin
               First;
               While not Eof do
                 begin

                 If   RelacionFacturasCacheFields.Seleccionada.Value and
                      AsientoTable.FindKey( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value ] ) and
                      ApunteTable.FindGreaterOrEqual( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, 2  ] )
                 then begin

                      LRBajaExpedidas := LRBajaExpedidasType.Create;

                      PeriodoLiq := PeriodoLiquidacion.Create;
                      PeriodoLiq.Ejercicio := IntToStr( EjercicioPresentacion );   // En Empresas con el ejercicio partido ApplicationContainer.Ejercicio es el ejercicio del primer mes, no necesariamente el del mes actual
                      PeriodoLiq.Periodo := TipoPeriodoType( Periodo );

                      IDEmisorFacturaBC := IDEmisorFactura9.Create;
                      IDEmisorFacturaBC.NIF := DataModule00.DmEmpresaFields.NIF.Value;

                      IDFacturaExpedidaBC := IDFacturaExpedidaBCType.Create;
                      IDFacturaExpedidaBC.IDEmisorFactura := IDEmisorFacturaBC;
                      IDFacturaExpedidaBC.NumSerieFacturaEmisor := RegistroPresentacion.SerieNroFactura( AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );
                      IDFacturaExpedidaBC.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFields.FechaDocumento.Value );

                      LRBajaExpedidas.PeriodoLiquidacion := PeriodoLiq;
                      LRBajaExpedidas.IDFactura := IDFacturaExpedidaBC;

                      RegistroLRBajaExpedidasList.Add( LRBajaExpedidas );

                      end;

                 Next;
                 end;
               end;

              If   RegistroLRBajaExpedidasList.Count=0
              then begin
                   ShowNotification( ntStop, RpfMsg1 );
                   Abort;
                   end;

             Titular := PersonaFisicaJuridicaESType.Create;
             Titular.NombreRazon := DataModule00.DmEmpresaFields.Nombre.Value;
             Titular.NIF := DataModule00.DmEmpresaFields.NIF.Value;

             CabeceraBaja := CabeceraSiiBaja.Create;
             CabeceraBaja.IDVersionSii := VersionSiiType._1_1;
             CabeceraBaja.Titular := Titular;

             AnulacionLRFacturasEmitidas.Cabecera := CabeceraBaja;
             AnulacionLRFacturasEmitidas.RegistroLRBajaExpedidas := Array_Of_LRBajaExpedidasType( RegistroLRBajaExpedidasList.ToArray );

             RespuestaLRBajaFrasEmitidas := siiSOAPFactEmitidas.AnulacionLRFacturasEmitidas( AnulacionLRFacturasEmitidas );

             For I := 0 to Length( RespuestaLRBajaFrasEmitidas.RespuestaLinea ) - 1 do
               begin
               RespuestaExpedidaBaja := RespuestaLRBajaFrasEmitidas.RespuestaLinea[ I ];
               If   Assigned( RespuestaExpedidaBaja )
               then begin

                    If   RegistroPresentacion.ExtraeSerieNroFactura( RespuestaExpedidaBaja.IDFactura.NumSerieFacturaEmisor, Serie, NroFactura )
                    then begin
                         RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaEmitida,
                                                                                Operacion,
                                                                                '',
                                                                                Serie,
                                                                                NroFactura,
                                                                                '',
                                                                                erpAnulado,
                                                                                RespuestaExpedidaBaja.CodigoErrorRegistro,
                                                                                RespuestaExpedidaBaja.DescripcionErrorRegistro );

                         If   RespuestaExpedidaBaja.CodigoErrorRegistro=0
                         then ProcessFrame.AddMsg( ntInformation, Format( RpfMsg2, [ Factura.TextoSerieNroFactura( Serie, NroFactura ) ] ) )
                         else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ Factura.TextoSerieNroFactura( Serie, NroFactura ), IntToStr( RespuestaExpedidaBaja.CodigoErrorRegistro ) + ' , ' + RespuestaExpedida.DescripcionErrorRegistro  ] ) );
                         end
                    else ProcessFrame.AddMsg( ntWarning, Format( RpfMsg18, [ RespuestaExpedidaBaja.IDFactura.NumSerieFacturaEmisor ] ) );

                    end;

               end;

           finally
             RegistroLRBajaExpedidasList.Free;
             AnulacionLRFacturasEmitidas.Free;
             end;

           end;

         ofAlta,
         ofModificacion :
           begin

           SuministroLRFrasEmitidas := SuministroLRFacturasEmitidas.Create;

           RegistroLRFacturasEmitidasList := TList<LRfacturasEmitidasType>.Create;

           try

             With RelacionFacturasCacheDataset do
               begin
               First;
               While not Eof do
                 begin

                 If   RelacionFacturasCacheFields.Seleccionada.Value
                 then If   AsientoTable.FindKey( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value ] ) and
                           ApunteTable.FindGreaterOrEqual( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, 2  ] )
                      then begin

                           // Hago la comprobación del registro de la factura aparte para poder notificar al usuario su posible ausencia

                           If   Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields )
                           then begin

                                If   Cliente.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ClienteFields )
                                then begin

                                     CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields );
                                     VentasOnline := False;

                                     If   ( AsientoFields.Fecha.Value>=EncodeDate( 2017, 1, 1 ) ) and
                                          ( AsientoFields.Fecha.Value<=EncodeDate( 2017, 6, 30 ) )
                                     then begin
                                          RegimenOTrascendencia := 15; // IdOperacionesTrascendenciaTributariaType._16;
                                          FacturaPrimerSemestre := True;
                                          end
                                     else begin
                                          RegimenOTrascendencia := FacturaFields.RegimenOTrascendencia.Value;
                                          FacturaPrimerSemestre := False;
                                          VentasOnline := FacturaFields.RegimenOTrascendencia.Value=rteVentasOnline;
                                          end;

                                     If   FacturaPrimerSemestre
                                     then DescripcionOperacion := 'Registro del primer semestre'
                                     else DescripcionOperacion := Cuenta.Descripcion( Copy( ApunteFields.Subcuenta.Value, 1, 3 ) );

                                     LRfacturasEmitidas := LRfacturasEmitidasType.Create;

                                     IDEmisorFactura3LR := IDEmisorFactura8.Create;
                                     IDEmisorFactura3LR.NIF := DataModule00.DmEmpresaFields.NIF.Value;

                                     FacturaExpedida := FacturaExpedidaType.Create;

                                     FacturaExpedida.TipoFactura := ObtenClaveTipoFacturaEmitida( FacturaFields.TipoFactura.Value );

                                     IDFacturaExpedida := IDFacturaExpedidaType.Create;
                                     IDFacturaExpedida.IDEmisorFactura := IDEmisorFactura3LR;
                                     IDFacturaExpedida.NumSerieFacturaEmisor := RegistroPresentacion.SerieNroFactura( AsientoFields.Serie.Value, AsientoFields.NroFactura.Value );

                                     If   FacturaExpedida.TipoFactura=ClaveTipoFacturaType.F2         // F2 Factura Simplificada (ticket) o sin destinatario identificado (ventas a clientes varios)
                                     then FacturaExpedida.FacturaSinIdentifDestinatarioAritculo6_1_d := CompletaSinDestinatarioType.S
                                     else If   FacturaExpedida.TipoFactura=ClaveTipoFacturaType.F4    // Asiento resumen de facturas
                                          then IDFacturaExpedida.NumSerieFacturaEmisorResumenFin := RegistroPresentacion.SerieNroFactura( AsientoFields.Serie.Value, FacturaFields.NroFacturaRectificada.Value );

                                     IDFacturaExpedida.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFields.FechaDocumento.Value );

                                     If   not ( FacturaExpedida.TipoFactura in [ ClaveTipoFacturaType.F4,      // F4 Asiento resumen de facturas
                                                                                 ClaveTipoFacturaType.F2,      // F2 Factura Simplificada (ticket)
                                                                                 ClaveTipoFacturaType.R5 ] )   // R5 Factura Rectificativa en facturas simplificadas
                                     then begin

                                          Contraparte := PersonaFisicaJuridicaType.Create;

                                          Contraparte.NombreRazon := ClienteFields.Nombre.Value;

                                          { Contrapartes de otro pais }

                                          If   ClienteFields.CodigoPais.Value=CodigoEspaña
                                          then Contraparte.NIF := ClienteFields.NIF.Value
                                          else If   Pais.Obten( ClienteFields.CodigoPais.Value, PaisFields, True )
                                               then begin

                                                    {
                                                    02 NIF-IVA
                                                    03 PASAPORTE
                                                    04 DOCUMENTO OFICIAL DE IDENTIFICACIÓN EXPEDIDO POR EL PAIS O TERRITORIO DE RESIDENCIA
                                                    05 CERTIFICADO DE RESIDENCIA
                                                    06 OTRO DOCUMENTO PROBATORIO
                                                    }

                                                    IDOtro := IDOtroType.Create;
                                                    IDOtro.CodigoPais := ObtenCountryType2( PaisFields.CodigoISO2.Value );  // Codigo ISO2 del pais
                                                    IDOtro.ID := ClienteFields.NIF.Value;
                                                    IDOtro.IDType := ObtenIDType( ClienteFields.TipoIdentificacion.Value );
                                                    Contraparte.IDOtro := IDOtro;
                                                    end;

                                          FacturaExpedida.Contraparte := Contraparte;
                                          end;

                                     If   FacturaExpedida.TipoFactura in [ ClaveTipoFacturaType.R1..ClaveTipoFacturaType.R5 ]
                                     then begin

                                          FacturaExpedida.TipoRectificativa := ClaveTipoRectificativaType.I;  // Por diferencia

                                          If   FacturaFields.NroFacturaRectificada.Value<>0
                                          then begin

                                               AsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';

                                               If   not AsientoFacturaTable.FindKey( [ taFraEmitida,
                                                                                       FacturaFields.EjercicioFraRectificada.Value,
                                                                                       FacturaFields.SerieFraRectificada.Value,
                                                                                       FacturaFields.NroFacturaRectificada.Value,
                                                                                       NroEfectoRegistroFactura ] )
                                               then begin
                                                    ShowNotification( ntStop, Format( RpfMsg5, [ Factura.TextoSerieNroFactura( AsientoFields.Serie.Value, AsientoFields.NroFactura.Value ) ] ) );
                                                    Next;
                                                    Continue;
                                                    end;

                                               IDFacturaAR := IDFacturaARType.Create;
                                               IDFacturaAR.NumSerieFacturaEmisor := RegistroPresentacion.SerieNroFactura( FacturaFields.SerieFraRectificada.Value, FacturaFields.NroFacturaRectificada.Value );
                                               IDFacturaAR.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFacturaFields.FechaDocumento.Value );

                                               FacturaExpedida.FacturasRectificadas := [ IDFacturaAR ]; // Solo una factura

                                               {  Si la factura rectificativa no lo es por sustitución, no es necesario indicar ImporteRectificacion (lo dejo por si se necesita en el futuro)

                                               If   Factura.ObtenImportesFacturaEmitida( FacturaFields.EjercicioFraRectificada.Value,
                                                                                         FacturaFields.Propietario.Value,
                                                                                         FacturaFields.SerieFraRectificada.Value,
                                                                                         FacturaFields.NroFacturaRectificada.Value,
                                                                                         BaseImponibleRectificada,
                                                                                         CuotaIVARectificada,
                                                                                         ImporteFacturaRectificada )
                                               then begin
                                                    DesgloseRectificacion := DesgloseRectificacionType.Create;

                                                    DesgloseRectificacion.BaseRectificada := DecimalString( BaseImponibleRectificada );
                                                    DesgloseRectificacion.CuotaRectificada := DecimalString( CuotaIVARectificada );
                                                    DesgloseRectificacion.CuotaRecargoRectificado := DecimalString( 0.0 );

                                                    FacturaExpedida.ImporteRectificacion := DesgloseRectificacion;
                                                    end;

                                               }
                                               end;
                                          end;

                                     FacturaExpedida.ClaveRegimenEspecialOTrascendencia := ObtenIdOperacionesTrascendenciaTributariaType( RegimenOTrascendencia );

                                     // Arrendamiento : Datos del inmueble

                                     If   FacturaExpedida.ClaveRegimenEspecialOTrascendencia in [ IdOperacionesTrascendenciaTributariaType._12, IdOperacionesTrascendenciaTributariaType._13 ]
                                     then begin

                                          DatosInmueble := DatosInmuebleType.Create;
                                          DatosInmueble.SituacionInmueble := ObtenSituacionInmueble( FacturaFields.SituacionInmueble.Value );
                                          DatosInmueble.ReferenciaCatastral := FacturaFields.ReferenciaCatastral.Value;

                                          FacturaExpedida.DatosInmueble := [ DatosInmueble ]
                                          end;

                                     DesglosePorTipoOperacion := ( not( FacturaExpedida.TipoFactura in [ ClaveTipoFacturaType.F2, ClaveTipoFacturaType.F4 ] ) or
                                                                      ( ( ClienteFields.CodigoPais.Value=CodigoEspaña ) and ( Copy ( ClienteFields.NIF.Value, 1, 1 )<>'N' ) ) ) and

                                                                 not ( FacturaExpedida.TipoFactura in [ ClaveTipoFacturaType.R2, ClaveTipoFacturaType.R3 ] );

                                     TipoDesglose := TipoDesglose3.Create;

                                     ImporteFactura := ObtenDesgloseCuotasIVA;

                                     If   DesglosePorTipoOperacion
                                     then begin

                                          // Prestacion de servicios

                                          SujetaPrestacion := ObtenPrestacionDesgloseIVANoEx;

                                          If   Assigned( SujetaPrestacion )
                                          then begin
                                               DesglosePrestacionServicios := TipoSinDesglosePrestacionType.Create;
                                               DesglosePrestacionServicios.Sujeta := SujetaPrestacion;
                                               end
                                          else DesglosePrestacionServicios := nil;

                                          // Entregas

                                          Sujeta := ObtenDesgloseIVANoEx( tdEntregas );

                                          If   Assigned( Sujeta ) or ( BaseImponibleNoSujeta<>0.0 )
                                          then begin
                                               DesgloseEntregas := TipoSinDesgloseType.Create;
                                               If   Assigned( Sujeta )
                                               then DesgloseEntregas.Sujeta := Sujeta
                                               else begin
                                                    DesgloseEntregas.NoSujeta := NoSujetaType.Create;
                                                    DesgloseEntregas.NoSujeta.ImporteTAIReglasLocalizacion := DecimalString( BaseImponibleNoSujeta );
                                                    ImporteFactura := BaseImponibleNoSujeta;
                                                    end;
                                               end
                                          else DesgloseEntregas := nil;

                                          // Desglose

                                          DesgloseTipoOperacion := TipoConDesgloseType.Create;

                                          If   Assigned( DesglosePrestacionServicios )
                                          then DesgloseTipoOperacion.PrestacionServicios := DesglosePrestacionServicios;

                                          If   Assigned( DesgloseEntregas )
                                          then DesgloseTipoOperacion.Entrega := DesgloseEntregas;

                                          TipoDesglose.DesgloseTipoOperacion := DesgloseTipoOperacion;

                                          end
                                     else begin

                                          // Sin desglose

                                          DesgloseFactura := TipoSinDesgloseType.Create;

                                          Sujeta := ObtenDesgloseIVANoEx( tdFactura );
                                          If   Assigned( Sujeta )
                                          then DesgloseFactura.Sujeta := Sujeta
                                          else If   BaseImponibleNoSujeta<>0.0
                                               then begin
                                                    DesgloseFactura.NoSujeta := NoSujetaType.Create;
                                                    DesgloseFactura.NoSujeta.ImporteTAIReglasLocalizacion := DecimalString( BaseImponibleNoSujeta );
                                                    ImporteFactura := BaseImponibleNoSujeta;
                                                    end;

                                          TipoDesglose.DesgloseFactura := DesgloseFactura;
                                          end;

                                     DesgloseFactura := TipoSinDesgloseType.Create;
                                     DesgloseFactura.Sujeta := Sujeta;

                                     // El campo ImporteTotal no es obligatorio y si no se indica el cálculo se realiza en el portal.
                                     // Sin embargo lo dejo como comprobación de que los cálculos estan bien hechos.

                                     FacturaExpedida.ImporteTotal := DecimalString( ImporteFactura );

                                     FacturaExpedida.DescripcionOperacion := DescripcionOperacion;
                                     FacturaExpedida.TipoDesglose := TipoDesglose;

                                     PeriodoLiq := PeriodoLiquidacion.Create;
                                     PeriodoLiq.Ejercicio := IntToStr( EjercicioPresentacion );
                                     PeriodoLiq.Periodo := TipoPeriodoType( Periodo );

                                     LRfacturasEmitidas.IDFactura := IDFacturaExpedida;
                                     LRfacturasEmitidas.FacturaExpedida := FacturaExpedida;
                                     LRfacturasEmitidas.PeriodoLiquidacion := PeriodoLiq;

                                     RegistroLRFacturasEmitidasList.Add( LRfacturasEmitidas );
                                     end
                                else ShowNotification( ntStop, Format( RpfMsg9, [ AsientoFields.Propietario.Value ] ) );

                                end
                           else ShowNotification( ntStop, Format( RpfMsg10, [ AsientoFields.NroAsiento.Value ] ) );

                           end
                      else ShowNotification( ntStop, Format( RpfMsg22, [ AsientoFields.NroAsiento.Value ] ) );

                 Next;
                 end;

               end;

           If   RegistroLRFacturasEmitidasList.Count=0
           then begin
                ShowNotification( ntStop, RpfMsg1 );
                Abort;
                end;

           Titular := PersonaFisicaJuridicaESType.Create;
           Titular.NombreRazon := DataModule00.DmEmpresaFields.Nombre.Value;
           Titular.NIF := DataModule00.DmEmpresaFields.NIF.Value;

           Cabecera := CabeceraSii.Create;
           Cabecera.IDVersionSii := VersionSiiType._1_1;
           Cabecera.Titular := Titular;

           If   Operacion=ofModificacion
           then Cabecera.TipoComunicacion := ClaveTipoComunicacionType.A1   // Modificación de una factura ya presentada
           else Cabecera.TipoComunicacion := ClaveTipoComunicacionType.A0;  // Alta inicial de facturas

           SuministroLRFrasEmitidas.Cabecera := Cabecera;
           SuministroLRFrasEmitidas.RegistroLRFacturasEmitidas := Array_Of_LRfacturasEmitidasType( RegistroLRFacturasEmitidasList.ToArray );

           RespuestaLRFrasEmitidas := siiSOAPFactEmitidas.SuministroLRFacturasEmitidas( SuministroLRFrasEmitidas );

           // RespuestaLRFrasEmitidas.EstadoEnvio=EstadoEnvioTypeCorrecto, ParcialmenteCorrecto Correcto

           For I := 0 to Length( RespuestaLRFrasEmitidas.RespuestaLinea ) - 1 do
             begin
             RespuestaExpedida := RespuestaLRFrasEmitidas.RespuestaLinea[ I ];
             If   Assigned( RespuestaExpedida )
             then begin

                  If   RegistroPresentacion.ExtraeSerieNroFactura( RespuestaExpedida.IDFactura.NumSerieFacturaEmisor, Serie, NroFactura )
                  then begin

                       RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaEmitida,
                                                                              Operacion,
                                                                              '',
                                                                              Serie,
                                                                              NroFactura,
                                                                              '',
                                                                              RegistroPresentacion.EstadoRegistroSii( Ord( RespuestaExpedida.EstadoRegistro ) ),
                                                                              RespuestaExpedida.CodigoErrorRegistro,
                                                                              RespuestaExpedida.DescripcionErrorRegistro,
                                                                              0.0,
                                                                              0.0,
                                                                              Now );

                       If   RespuestaExpedida.CodigoErrorRegistro=0
                       then ProcessFrame.AddMsg( ntInformation, Format( RpfMsg2, [ Factura.TextoSerieNroFactura( Serie, NroFactura ) ] ) )
                       else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ Factura.TextoSerieNroFactura( Serie, NroFactura ), IntToStr( RespuestaExpedida.CodigoErrorRegistro ) + ' , ' + RespuestaExpedida.DescripcionErrorRegistro  ] ) );
                       end
                  else ProcessFrame.AddMsg( ntWarning, Format( RpfMsg18, [ RespuestaExpedida.IDFactura.NumSerieFacturaEmisor ] ) );

                  end;
             end;

           finally
             RegistroLRFacturasEmitidasList.Free;
             SuministroLRFrasEmitidas.Free;
             end;

           end;

         ofConsulta:
           begin

           TitularUnico := PersonaFisicaJuridicaUnicaESType.Create;
           TitularUnico.NombreRazon := DataModule00.DmEmpresaFields.Nombre.Value;
           TitularUnico.NIF := DataModule00.DmEmpresaFields.NIF.Value;

           CabeceraConsulta := CabeceraConsultaSii.Create;
           CabeceraConsulta.IDVersionSii := VersionSiiType._1_1;
           CabeceraConsulta.Titular := TitularUnico;

           PeriodoLiq := PeriodoLiquidacion.Create;
           PeriodoLiq.Ejercicio := IntToStr( EjercicioPresentacion );
           PeriodoLiq.Periodo := TipoPeriodoType( Periodo );

           FiltroEmitidas := LRFiltroEmitidasType.Create;
           FiltroEmitidas.PeriodoLiquidacion := PeriodoLiq;

           If   FechaPresentacionConsulta<>0
           then begin
                RangoFechaPresentacion := RangoFechaPresentacionType.Create;
                RangoFechaPresentacion.Desde := FormatDateTime( 'dd-mm-yyyy', FechaPresentacionConsulta );
                RangoFechaPresentacion.Hasta := FormatDateTime( 'dd-mm-yyyy', FechaPresentacionConsulta );
                FiltroEmitidas.FechaPresentacion := RangoFechaPresentacion;
                end;

           ConsultaLRFrasEmitidas := ConsultaLRFacturasEmitidas.Create;
           ConsultaLRFrasEmitidas.Cabecera := CabeceraConsulta;
           ConsultaLRFrasEmitidas.FiltroConsulta := FiltroEmitidas;

           try

             RespuestaConsultaLRFrasEmitidas := siiSOAPFactEmitidas.ConsultaLRFacturasEmitidas( ConsultaLRFrasEmitidas );

             If   RespuestaConsultaLRFrasEmitidas.ResultadoConsulta=ResultadoConsultaType.ConDatos
             then begin
                  For I := 0 to Length( RespuestaConsultaLRFrasEmitidas.RegistroRespuestaConsultaLRFacturasEmitidas ) - 1 do
                    begin

                    RegistroRespuestaConsultaEmitidas := RespuestaConsultaLRFrasEmitidas.RegistroRespuestaConsultaLRFacturasEmitidas[ I ];

                    If   not RegistroPresentacion.ExtraeSerieNroFactura( RegistroRespuestaConsultaEmitidas.IDFactura.NumSerieFacturaEmisor, Serie, NroFactura )
                    then begin
                         ProcessFrame.AddMsg( ntWarning, Format( RpfMsg18, [ RegistroRespuestaConsultaEmitidas.IDFactura.NumSerieFacturaEmisor ] ) );
                         Continue;
                         end;

                    ImportePresentacion := ObtenImportePresentacionFacturaEmitida( RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida );
                    FechaPresentacion := StrToDateTimeDef( RegistroRespuestaConsultaEmitidas.DatosPresentacion.TimeStampPresentacion, 0, TimeStampFormatSettings );

                    // Obteniendo el importe de la factura para cotejarlo con el presentado

                    If   Factura.ObtenImportesFacturaEmitida( ApplicationContainer.Ejercicio, Serie, NroFactura, Asiento, BaseImponible, CuotaIVA, CuotaRE, ImporteFactura )
                    then begin

                         AsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Serie;NroFactura;NroEfecto';

                         // He comprobado que se puede dar de alta más de una factura con el mismo número. Compruebo los datos de la misma.

                         AsientoFacturaTable.FindKey( [ taFraEmitida, ApplicationContainer.Ejercicio, Serie, NroFactura, NroEfectoRegistroFactura ] );
                         Cliente.ObtenPorSubcuenta( AsientoFacturaFields.Propietario.Value, ClienteFields );
                         CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields );

                         If   Assigned( RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida.Contraparte )  // Puede ser una factura resumen sin propietario
                         then begin

                              If   Assigned( RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida.Contraparte.IDOtro )
                              then NIFPropietario := RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida.Contraparte.IDOtro.ID
                              else NIFPropietario := RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida.Contraparte.NIF;

                              If   NIFPropietario<>ClienteFields.NIF.Value
                              then begin
                                   ProcessFrame.AddMsg( ntError, Format( RpfMsg16, [ Factura.TextoSerieNroFactura( Serie, NroFactura ), NIFPropietario ] ) + ' ' +
                                                                 Format( RpfMsg14, [ StrFormatDate( FechaPresentacion ), ImportePresentacion ] ) );
                                   Continue;
                                   end;

                              end;

                         // Si es una factura del primer trimestre el importe total es la base imponible (no se suben las cuotas)

                         If   RegistroRespuestaConsultaEmitidas.DatosFacturaEmitida.ClaveRegimenEspecialOTrascendencia=IdOperacionesTrascendenciaTributariaType._16  // Primer semestre 2017
                         then ImporteFactura := BaseImponible;

                         RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaEmitida,
                                                                                Operacion,
                                                                                '',
                                                                                Serie,
                                                                                NroFactura,
                                                                                '',
                                                                                RegistroPresentacion.EstadoPresentacionSII( Ord( RegistroRespuestaConsultaEmitidas.EstadoFactura.EstadoRegistro ) ),
                                                                                RegistroRespuestaConsultaEmitidas.EstadoFactura.CodigoErrorRegistro,
                                                                                RegistroRespuestaConsultaEmitidas.EstadoFactura.DescripcionErrorRegistro,
                                                                                ImporteFactura,
                                                                                ImportePresentacion,
                                                                                FechaPresentacion,
                                                                                Ord( RegistroRespuestaConsultaEmitidas.EstadoFactura.EstadoCuadre ) );

                         ProcessFrame.AddMsg( ntInformation, Format( RpfMsg6, [ Factura.TextoSerieNroFactura( Serie, NroFactura ) ] ) );

                         end
                    else ProcessFrame.AddMsg( ntError, Format( RpfMsg15, [ Factura.TextoSerieNroFactura( Serie, NroFactura ) ] ) + ' ' +
                                                       Format( RpfMsg14, [ StrFormatDate( FechaPresentacion ), ImportePresentacion ] ) );

                    end;

                  end;

           finally
             ConsultaLRFrasEmitidas.Free;
             end;

           end;

         end;

     except on E : Exception do
       begin
       RegistroPresentacion.ShowError( E );
       raise;
       end;
     end;

end;

end.

