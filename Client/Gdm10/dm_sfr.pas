
unit dm_sfr;

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

  Xml.xmldom,
  Xml.XMLIntf,
  Xml.XMLDoc,

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

  SuministroFactRecibidas,

  Gim00Fields,
  Gim10Fields,

  AsientoIntf,

  dmi_iva,
  dmi_ast,

  dm_rpf;

type

  TSFRecibidasModule = class(TDataModule)
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
    PaisFields : TPaisFields;

    ListaDesgloseCuotasIVA : TList< TDesgloseCuotasIVA >;
    EjercicioPresentacion : SmallInt;

    function ObtenCountryType2(Value: String): CountryType2;
    function ObtenIdOperacionesTrascendenciaTributariaType(Value: SmallInt ): IdOperacionesTrascendenciaTributariaType;
    function ObtenIDType(Value: SmallInt): PersonaFisicaJuridicaIDTypeType;
    function ObtenSituacionInmueble(Value: SmallInt): SituacionInmuebleType;
    function ObtenClaveTipoFacturaRecibida(Value: SmallInt): ClaveTipoFacturaType;
    function ObtenCausaExencionType(Value: SmallInt): CausaExencionType;
    function ObtenEstadoCuadreType(Value: SmallInt): EstadoCuadreType;

  public

    function SuministroFacturasRecibidas( Operacion : TOperacionFacturasSII; Periodo : SmallInt; FechaPresentacionConsulta : TDate; RelacionFacturasCacheDataset : TnxeCachedDataSet; ActualizarEstadoFacturas : Boolean = False ) : String;

  end;


var SFRecibidasModule: TSFRecibidasModule = nil;

function  SFRecibidas : TSFRecibidasModule;

implementation

uses Variants,
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
     WSDLSuministroFactRecibidas = 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/ssii/fact/ws/SuministroFactRecibidas.wsdl';
     URLSuministroFactRecibidas = 'https://www1.agenciatributaria.gob.es/wlpl/SSII-FACT/ws/fr/SiiFactFRV1SOAP';

function SFRecibidas : TSFRecibidasModule;
begin
     CreateDataModule( TSFRecibidasModule, SFRecibidasModule );
     Result := SFRecibidasModule;
end;

procedure TSFRecibidasModule.DataModuleCreate(Sender: TObject);
begin
     AsientoFields := TAsientoFields.Create( AsientoTable );
     AsientoFacturaFields := TAsientoFields.Create( AsientoFacturaTable );
     ApunteFields := TApunteFields.Create( ApunteTable );

     ClienteFields := TClienteFields.Create( Self );
     ProveedorFields := TProveedorFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );
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

procedure TSFRecibidasModule.DataModuleDestroy(Sender: TObject);
begin
     FreeAndNil( ListaDesgloseCuotasIVA );
     SFRecibidasModule := nil;
end;

procedure TSFRecibidasModule.HttpGetCertificate(     Sender       : TObject;
                                                 var ACertificate : TclCertificate;
                                                     AExtraCerts  : TclCertificateList;
                                                 var Handled      : Boolean );
begin
     ACertificate := Certificados.CertificadoUsuario;
     Handled := True;
end;

procedure TSFRecibidasModule.HttpReceiveResponse(       Sender          : TObject;
                                                  const AMethod,
                                                        AUrl            : string;
                                                        AResponseHeader : TStrings;
                                                        ACookies        : TclCookieList );
begin
     RegistroPresentacion.AddResponseHeader( AMethod, AResponseHeader );
end;

procedure TSFRecibidasModule.HttpRioBeforeExecute(const MethodName: string; SOAPRequest: TStream);

var sTmp : TStringList;
    sText : String;

begin
     { DEBUG
     sTmp := TStringList.Create;
     try
       SOAPRequest.Position := 0;
       sTmp.LoadFromStream( SOAPRequest );
       sText := sTmp.Text;
7     finally
       sTmp.Free;
       end;
     }
end;

function TSFRecibidasModule.ObtenIDType( Value : SmallInt ) : PersonaFisicaJuridicaIDTypeType;
begin
     Result := PersonaFisicaJuridicaIDTypeType( Value );
end;

function TSFRecibidasModule.ObtenCountryType2( Value : String ) : CountryType2;
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

function TSFRecibidasModule.ObtenIdOperacionesTrascendenciaTributariaType( Value : SmallInt ) : IdOperacionesTrascendenciaTributariaType;
begin
     If   Value in [ 0..8 ]
     then Result := IdOperacionesTrascendenciaTributariaType( Value )
     else case Value of
             9 : Result := IdOperacionesTrascendenciaTributariaType._12;
            10 : Result := IdOperacionesTrascendenciaTributariaType._13;
            11 : Result := IdOperacionesTrascendenciaTributariaType._14;
            end;
end;

function TSFRecibidasModule.ObtenCausaExencionType( Value : SmallInt  ) : CausaExencionType;
begin
     Result := CausaExencionType( Value );
end;

function TSFRecibidasModule.ObtenClaveTipoFacturaRecibida( Value : SmallInt ) : ClaveTipoFacturaType;
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
      11 : Result := ClaveTipoFacturaType.LC;
       end;
end;

function TSFRecibidasModule.ObtenSituacionInmueble( Value : SmallInt ) : SituacionInmuebleType;
begin
     Result := SituacionInmuebleType( Value );
end;

function TSFRecibidasModule.ObtenEstadoCuadreType( Value : SmallInt  ) : EstadoCuadreType;
begin
     Result := EstadoCuadreType( Value );
end;

function TSFRecibidasModule.SuministroFacturasRecibidas( Operacion                    : TOperacionFacturasSII;
                                                         Periodo                      : SmallInt;   // Mes
                                                         FechaPresentacionConsulta    : TDate;
                                                         RelacionFacturasCacheDataset : TnxeCachedDataSet;
                                                         ActualizarEstadoFacturas     : Boolean = False ) : String;

var  siiSOAPFactRecibidas : SuministroFactRecibidas.siiSOAP;

     Cabecera : CabeceraSii;
     CabeceraConsulta : CabeceraConsultaSii;
     CabeceraBaja : CabeceraSiiBaja;
     TitularUnico : PersonaFisicaJuridicaUnicaESType;
     Titular : PersonaFisicaJuridicaESType;
     FiltroRecibidas : LRFiltroRecibidasType;
     PeriodoLiq : PeriodoLiquidacion;

     SuministroLRFrasRecibidas : SuministroLRFacturasRecibidas;
     ConsultaLRFrasRecibidas : ConsultaLRFacturasRecibidas;
     RespuestaConsultaLRFrasRecibidas : RespuestaConsultaLRFacturasRecibidas;
     RespuestaLRFrasRecibidas : RespuestaLRFacturasRecibidas;

     RangoFechaPresentacion : RangoFechaPresentacionType;
     RegistroLRFacturasRecibidas : Array_Of_LRfacturasRecibidasType;
     LRfacturaRecibida : LRfacturasRecibidasType;
     IDFacturaRecibida : IDFacturaRecibidaType;
     IDEmisorFactura2LR : IDEmisorFactura2;
     IDEmisorFacturaLR : IDEmisorFactura11;
     FacturaRecibida : FacturaRecibidaType;
     Contraparte : PersonaFisicaJuridicaType;
     IDOtro : IDOtroType;
     TipoDesglose : TipoDesglose2;
     DesgloseInversionSujetoPasivo : InversionSujetoPasivo;
     DesgloseFacturaRecibida : DesgloseFacturaRecibidasType;
     DesgloseTipoOperacion : TipoConDesgloseType;
     {
     Sujeta : SujetaType;
     NoEx : NoExenta2;
     Ex : Exenta;
     }
     DetalleIVARecibida : DetalleIVARecibidaType;
     DetalleIVARecibida2 : DetalleIVARecibida2Type;

     I : SmallInt;

     RelacionPropietarios : TStringList;
     RelacionFacturasQuery : TnxeQuery;
     RegistroLRFacturasRecibidasList : TList<LRfacturasRecibidasType>;
     ListaDetalleIVARecibida : TList<DetalleIVARecibidaType>;
     ListaDetalleIVARecibida2 : TList<DetalleIVARecibida2Type>;
     LRfacturasRecibidas : LRfacturasRecibidasType;
     RespuestaRecibida : RespuestaRecibidaType;
     RespuestaRecibidaBaja : RespuestaRecibidaBajaType;
     RegistroRespuestaConsultaRecibidas : RegistroRespuestaConsultaRecibidasType;
     IDFacturaAR : IDFacturaARType;
     FacturasRectificadas : FacturasRectificadas2;
     DesgloseRectificacion : DesgloseRectificacionType;

     AnulacionLRFacturasRecibidas : BajaLRFacturasRecibidas;   // Hay una clase con el mismo nombre en SuministroFactEmitidas !!
     RegistroLRBajaRecibidasList : TList<LRBajaRecibidasType>;
     RespuestaLRBajaFrasRecibidas : RespuestaLRBajaFacturasRecibidas;
     LRBajaRecibidas : LRBajaRecibidasType;
     IDFacturaRecibidaBC : IDFacturaRecibidaNombreBCType;
     IDEmisorFacturaBC : IDEmisorFactura10;

     RelacionFacturasCacheFields : TRelacionFacturasPresentacionFields;

     FacturaPrimerSemestre : Boolean;
     RegimenOTrascendencia : SmallInt;

     NIFPropietario,
     Propietario,
     Serie,
     DescripcionOperacion : String;
     Asiento : IAsiento;
     BaseImponible,
     BaseImponibleExenta,
     CuotaDeducible,
     CuotaIVA,
     CuotaRE,
     ImporteFactura,
     ImportePresentacion,

     BaseImponibleRectificada,
     CuotaIVARectificada,
     ImporteFacturaRectificada : Decimal;

     FechaPresentacion : TDate;

     NotificationMessage : TNotificationType;
     EstadoRegistro : EstadoRegistroType;

     DesgloseCuotasIVA : TDesgloseCuotasIVA;

function ObtenDesgloseCuotasIVA : Decimal;

var  Cuenta : String;
     DesgloseCuotasIVA : TDesgloseCuotasIVA;
     BienInversion,
     Encontrado : Boolean;

begin

     Result := 0.0;
     ListaDesgloseCuotasIVA.Clear;

     With ApunteTable do
       try

         SetRange( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, 2  ],
                   [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value, MaxSmallint  ] );

         While not Eof and ( ApunteFields.TipoApunte.Value=tapManual ) do
           begin

           var Subgrupo := Copy( ApunteFields.Subcuenta.Value, 1, 2 );
           BienInversion:= ( Subgrupo='20' ) or ( Subgrupo='21' ) or ( Subgrupo='22' );
           Tasa.TipoIVA( AsientoFields.FechaDocumento.Value, ApunteFields.Tipo.Value, TiposIVAFields );

           Encontrado := False;
           For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
             If   ( DesgloseCuotasIVA.BienInversion=BienInversion ) and
                  ( DesgloseCuotasIVA.TipoImpositivo=TiposIVAFields.IVASoportado.Value )
             then begin
                  DesgloseCuotasIVA.BaseImponible := DesgloseCuotasIVA.BaseImponible + ApunteFields.BaseImponible.Value;
                  DesgloseCuotasIVA.CuotaIVA := DesgloseCuotasIVA.CuotaIVA + ApunteFields.CuotaIVA.Value;
                  Encontrado := True;
                  Break;
                  end;

           If   not Encontrado
           then begin
                DesgloseCuotasIVA := TDesgloseCuotasIVA.Create;

                DesgloseCuotasIVA.BienInversion := BienInversion;
                DesgloseCuotasIVA.BaseImponible := ApunteFields.BaseImponible.Value;
                DesgloseCuotasIVA.TipoImpositivo := TiposIVAFields.IVASoportado.Value;
                DesgloseCuotasIVA.CuotaIVA := ApunteFields.CuotaIVA.Value;

                ListaDesgloseCuotasIVA.Add( DesgloseCuotasIVA );
                end;

           DecAdd( Result, ApunteFields.ImporteTotal.Value );

           Next;
           end;

       finally
         CancelRange;
         end;

end;

function ObtenImportePresentacionFacturaRecibida( DatosFacturaRecibida : FacturaRespuestaRecibidaType ) : Decimal;

var  I : SmallInt;
     InvSujetoPasivo : InversionSujetoPasivo;
     DesgloseIVAFactura : DesgloseIVA;
     ImporteCuota : Decimal;

begin
     Result := 0.0;

     If   Assigned( DatosFacturaRecibida.DesgloseFactura.InversionSujetoPasivo )
     then begin
          InvSujetoPasivo := DatosFacturaRecibida.DesgloseFactura.InversionSujetoPasivo;
          If   Assigned( InvSujetoPasivo )
          then For I := 0 to Length( InvSujetoPasivo ) - 1 do     // array of DetalleIVARecibida2Type
                   With InvSujetoPasivo[ I ] do
                     Result := Result +
                               StrToCurrDef( BaseImponible, 0.0, DecimalFormatSettings ) +
                               StrToCurrDef( CuotaSoportada, 0.0, DecimalFormatSettings ) +
                               StrToCurrDef( CuotaRecargoEquivalencia, 0.0, DecimalFormatSettings );
          end;

     If   Assigned( DatosFacturaRecibida.DesgloseFactura.DesgloseIVA )
     then begin
          DesgloseIVAFactura := DatosFacturaRecibida.DesgloseFactura.DesgloseIVA;
          If   Assigned( DesgloseIVAFactura )
          then For I := 0 to Length( DesgloseIVAFactura ) - 1 do  // array of DetalleIVARecibidaType
                   With DesgloseIVAFactura[ I ] do
                     begin

                     If   ImporteCompensacionREAGYP<>''
                     then ImporteCuota := StrToCurrDef( ImporteCompensacionREAGYP, 0.0, DecimalFormatSettings )
                     else ImporteCuota := StrToCurrDef( CuotaSoportada, 0.0, DecimalFormatSettings );

                     Result := Result +
                               StrToCurrDef( BaseImponible, 0.0, DecimalFormatSettings ) +
                               ImporteCuota +
                               StrToCurrDef( CuotaRecargoEquivalencia, 0.0, DecimalFormatSettings );
                     end;

          end;

end;

begin

     Certificados.CompruebaCertificadoUsuario;

     // HTTPReqResp.HTTPSClient.ClientCertStorage := RegistroPresentacion.CustomCertStorage;

     RelacionFacturasCacheFields := TRelacionFacturasPresentacionFields.Create( RelacionFacturasCacheDataset );

     HttpRio.WSDLLocation := WSDLSuministroFactRecibidas;
     HttpRio.URL := URLSuministroFactRecibidas;
     HttpRio.Service := 'siiService';

     If   DataModule00.DmEmpresaFields.Contable_EntornoPruebasSII.Value
     then HttpRio.Port := 'SuministroFactRecibidasPruebas'
     else HttpRio.Port := 'SuministroFactRecibidas';

     siiSOAPFactRecibidas := ( HttpRio as SuministroFactRecibidas.siiSOAP );

     try

       case Operacion of
         ofAnulacion:
           begin

           AnulacionLRFacturasRecibidas := BajaLRFacturasRecibidas.Create;
           RegistroLRBajaRecibidasList := TList<LRBajaRecibidasType>.Create;

           try

              With RelacionFacturasCacheDataset do
               begin
               First;
               While not Eof do
                 begin

                 If   RelacionFacturasCacheFields.Seleccionada.Value and
                      AsientoTable.FindKey( [ RelacionFacturasCacheFields.Ejercicio.Value, RelacionFacturasCacheFields.NroAsiento.Value ] )
                 then If   Proveedor.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ProveedorFields )
                      then begin

                           LRBajaRecibidas := LRBajaRecibidasType.Create;

                           PeriodoLiq := PeriodoLiquidacion.Create;
                           PeriodoLiq.Ejercicio := IntToStr( EjercicioPresentacion );
                           PeriodoLiq.Periodo := TipoPeriodoType( Periodo );

                           IDEmisorFacturaBC := IDEmisorFactura10.Create;
                           IDEmisorFacturaBC.NombreRazon := ProveedorFields.Nombre.Value;
                           IDEmisorFacturaBC.NIF := ProveedorFields.NIF.Value;

                           IDFacturaRecibidaBC := IDFacturaRecibidaNombreBCType.Create;
                           IDFacturaRecibidaBC.IDEmisorFactura := IDEmisorFacturaBC;
                           IDFacturaRecibidaBC.NumSerieFacturaEmisor := AsientoFields.Serie.Value;
                           IDFacturaRecibidaBC.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFields.FechaDocumento.Value );

                           LRBajaRecibidas.PeriodoLiquidacion := PeriodoLiq;
                           LRBajaRecibidas.IDFactura := IDFacturaRecibidaBC;

                           RegistroLRBajaRecibidasList.Add( LRBajaRecibidas );

                           end
                      else ShowNotification( ntStop, Format( RpfMsg9, [ AsientoFields.Propietario.Value ] ) );

                 Next;
                 end;
               end;

              If   RegistroLRBajaRecibidasList.Count=0
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

             AnulacionLRFacturasRecibidas.Cabecera := CabeceraBaja;
             AnulacionLRFacturasRecibidas.RegistroLRBajaRecibidas := Array_Of_LRBajaRecibidasType( RegistroLRBajaRecibidasList.ToArray );

             RespuestaLRBajaFrasRecibidas := siiSOAPFactRecibidas.AnulacionLRFacturasRecibidas( AnulacionLRFacturasRecibidas );

             // RelacionFacturasCacheDataset.IndexFieldNames := 'NIFPropietario;Serie;NroFactura';

             For I := 0 to Length( RespuestaLRBajaFrasRecibidas.RespuestaLinea ) - 1 do
               begin
               RespuestaRecibidaBaja := RespuestaLRBajaFrasRecibidas.RespuestaLinea[ I ];
               If   Assigned( RespuestaRecibidaBaja )
               then begin

                    If   Assigned( RespuestaRecibidaBaja.IDFactura.IDEmisorFactura.IDOtro )
                    then NIFPropietario := RespuestaRecibidaBaja.IDFactura.IDEmisorFactura.IDOtro.ID
                    else NIFPropietario := RespuestaRecibidaBaja.IDFactura.IDEmisorFactura.NIF;

                    RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaRecibida,
                                                                           Operacion,
                                                                           '',
                                                                           RespuestaRecibidaBaja.IDFactura.NumSerieFacturaEmisor,
                                                                           0,
                                                                           NIFPropietario,
                                                                           erpAnulado,
                                                                           RespuestaRecibidaBaja.CodigoErrorRegistro,
                                                                           RespuestaRecibidaBaja.DescripcionErrorRegistro );

                    If   RespuestaRecibidaBaja.CodigoErrorRegistro=0
                    then ProcessFrame.AddMsg( ntInformation, Format( RpfMsg2, [ RespuestaRecibidaBaja.IDFactura.NumSerieFacturaEmisor ] ) )
                    else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ RespuestaRecibidaBaja.IDFactura.NumSerieFacturaEmisor, IntToStr( RespuestaRecibidaBaja.CodigoErrorRegistro ) + ' , ' + RespuestaRecibidaBaja.DescripcionErrorRegistro  ] ) );

                    end;

               end;

           finally
             RegistroLRBajaRecibidasList.Free;
             AnulacionLRFacturasRecibidas.Free;
             end;

           end;

         ofAlta,
         ofModificacion :
           begin

           SuministroLRFrasRecibidas := SuministroLRFacturasRecibidas.Create;

           RegistroLRFacturasRecibidasList := TList<LRfacturasRecibidasType>.Create;
           RelacionPropietarios := TStringList.Create;

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

                           If   Factura.ObtenRegistroContableFactura( tfAsiento, AsientoFields.Ejercicio.Value, AsientoFields.NroAsiento.Value, FacturaFields )
                           then begin

                                If   Proveedor.ObtenPorSubcuenta( AsientoFields.Propietario.Value, ProveedorFields )
                                then begin

                                     If   ( AsientoFields.Fecha.Value>=EncodeDate( 2017, 1, 1 ) ) and
                                          ( AsientoFields.Fecha.Value<=EncodeDate( 2017, 6, 30 ) )
                                     then begin
                                          RegimenOTrascendencia := 11; // IdOperacionesTrascendenciaTributariaType._14
                                          FacturaPrimerSemestre := True;
                                          end
                                     else begin
                                          RegimenOTrascendencia := FacturaFields.RegimenOTrascendencia.Value;
                                          FacturaPrimerSemestre := False;
                                          end;


                                     If   FacturaPrimerSemestre
                                     then DescripcionOperacion := 'Registro del primer semestre'
                                     else DescripcionOperacion := Cuenta.Descripcion( Copy( ApunteFields.Subcuenta.Value, 1, 3 ) );

                                     RelacionPropietarios.Values[ ProveedorFields.NIF.Value ] := AsientoFields.Propietario.Value;

                                     LRfacturasRecibidas := LRfacturasRecibidasType.Create;

                                     IDEmisorFacturaLR := IDEmisorFactura11.Create;
                                     If   ProveedorFields.CodigoPais.Value=CodigoEspaña
                                     then IDEmisorFacturaLR.NIF := ProveedorFields.NIF.Value
                                     else If   Pais.Obten( ProveedorFields.CodigoPais.Value, PaisFields, True )
                                          then begin
                                               IDOtro := IDOtroType.Create;
                                               IDOtro.CodigoPais := ObtenCountryType2( PaisFields.CodigoISO2.Value );  // Codigo ISO2 del pais
                                               IDOtro.ID := ProveedorFields.NIF.Value;
                                               IDOtro.IDType := ObtenIDType( ProveedorFields.TipoIdentificacion.Value );
                                               IDEmisorFacturaLR.IDOtro := IDOtro;
                                               end;

                                     IDFacturaRecibida := IDFacturaRecibidaType.Create;
                                     IDFacturaRecibida.IDEmisorFactura := IDEmisorFacturaLR;
                                     IDFacturaRecibida.NumSerieFacturaEmisor := AsientoFields.Serie.Value;
                                     IDFacturaRecibida.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFields.FechaDocumento.Value );

                                     Contraparte := PersonaFisicaJuridicaType.Create;
                                     Contraparte.NombreRazon := ProveedorFields.Nombre.Value;

                                     If   ProveedorFields.CodigoPais.Value=CodigoEspaña
                                     then Contraparte.NIF := ProveedorFields.NIF.Value
                                     else If   Pais.Obten( ProveedorFields.CodigoPais.Value, PaisFields, True )
                                          then begin
                                               IDOtro := IDOtroType.Create;
                                               IDOtro.CodigoPais := ObtenCountryType2( PaisFields.CodigoISO2.Value );  // Codigo ISO2 del pais
                                               IDOtro.ID := ProveedorFields.NIF.Value;
                                               IDOtro.IDType := ObtenIDType( ProveedorFields.TipoIdentificacion.Value );
                                               Contraparte.IDOtro := IDOtro;
                                               end;

                                     FacturaRecibida := FacturaRecibidaType.Create;
                                     FacturaRecibida.Contraparte := Contraparte;

                                     {
                                     F1 Factura
                                     F2 Factura Simplificada (ticket)
                                     F3 Factura emitida en sustitución de facturas simplificadas facturadas y declaradas
                                     F4 Asiento resumen de facturas
                                     F5 Importaciones (DUA)
                                     F6 Justificantes contables
                                     R1 Factura Rectificativa (Error fundado en derecho y Art. 80 Uno Dos y Seis LIVA)
                                     R2 Factura Rectificativa (Art. 80.3)
                                     R3 Factura Rectificativa (Art. 80.4)
                                     R4 Factura Rectificativa (Resto)
                                     R5 Factura Rectificativa en facturas simplificadas
                                     LC Aduanas - Liquidación complementaria
                                     }

                                     FacturaRecibida.TipoFactura := ObtenClaveTipoFacturaRecibida( FacturaFields.TipoFactura.Value );

                                     If   FacturaRecibida.TipoFactura in [ ClaveTipoFacturaType.R1..ClaveTipoFacturaType.R5 ]
                                     then begin

                                          FacturaRecibida.TipoRectificativa := ClaveTipoRectificativaType.I;  // Por diferencia

                                          If   FacturaFields.SerieFraRectificada.Value<>''
                                          then begin

                                               AsientoFacturaTable.IndexFieldNames := 'TipoAsiento;Ejercicio;Propietario;Serie;NroFactura;NroEfecto';

                                               If   not AsientoFacturaTable.FindKey( [ taFraRecibida,
                                                                                       FacturaFields.EjercicioFraRectificada.Value,
                                                                                       AsientoFields.Propietario.Value,  // Es evidente que tiene que ser el mismo
                                                                                       FacturaFields.SerieFraRectificada.Value,
                                                                                       0,
                                                                                       NroEfectoRegistroFactura ] )
                                               then begin
                                                    ShowNotification( ntStop, Format( RpfMsg5, [ FacturaFields.SerieFraRectificada.Value ] ) );
                                                    Next;
                                                    Continue;
                                                    end;

                                               IDFacturaAR := IDFacturaARType.Create;
                                               IDFacturaAR.NumSerieFacturaEmisor := FacturaFields.SerieFraRectificada.Value;
                                               IDFacturaAR.FechaExpedicionFacturaEmisor := FormatDateTime( 'dd-mm-yyyy', AsientoFacturaFields.FechaDocumento.Value );

                                               FacturaRecibida.FacturasRectificadas := [ IDFacturaAR ];   // Solo una factura

                                               {  Si la factura rectificativa no lo es por sustitución, no es necesario indicar ImporteRectificacion (lo dejo por si se necesita en el futuro)

                                               If   Factura.ObtenImportesFacturaRecibida( FacturaFields.EjercicioFraRectificada.Value,
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

                                                    FacturaRecibida.ImporteRectificacion := DesgloseRectificacion;
                                                    end;
                                               }

                                               end;

                                          end;

                                     {

                                     01 Operación de régimen general.
                                     02 Operaciones por las que los empresarios satisfacen compensaciones en las adquisiciones a personas acogidas al Régimen especial de la agricultura, ganaderia y pesca.
                                     03 Operaciones a las que se aplique el régimen especial de bienes usados, objetos de arte, antigüedades y objetos de colección.
                                     04 Régimen especial del oro de inversión.
                                     05 Régimen especial de las agencias de viajes.
                                     06 Régimen especial grupo de entidades en IVA (Nivel Avanzado).
                                     07 Régimen especial del criterio de caja.
                                     08 Operaciones sujetas al IPSI / IGIC (Impuesto sobre la Producción, los Servicios y la Importación / Impuesto General Indirecto Canario).
                                     09 Adquisiciones intracomunitarias de bienes y prestaciones de servicios.

                                     12 Operaciones de arrendamiento de local de negocio.
                                     13 Factura correspondiente a una importación (informada sin asociar a un DUA).
                                     14 Primer semestre 2017.
                                     }

                                     FacturaRecibida.ClaveRegimenEspecialOTrascendencia := ObtenIdOperacionesTrascendenciaTributariaType( RegimenOTrascendencia );

                                     BaseImponibleExenta := 0.0;
                                     CuotaDeducible := 0.0;

                                     ImporteFactura := ObtenDesgloseCuotasIVA;

                                     DesgloseFacturaRecibida := DesgloseFacturaRecibidasType.Create;

                                     If   AsientoFields.Origen.Value=ofrInversionSP
                                     then begin

                                          ListaDetalleIVARecibida2 :=  TList<DetalleIVARecibida2Type>.Create;

                                          try

                                            For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
                                              begin

                                              DetalleIVARecibida2 := DetalleIVARecibida2Type.Create;
                                              DetalleIVARecibida2.BaseImponible := DecimalString( DesgloseCuotasIVA.BaseImponible );

                                              DetalleIVARecibida2.TipoImpositivo := DecimalString( DesgloseCuotasIVA.TipoImpositivo );
                                              DetalleIVARecibida2.CuotaSoportada := DecimalString( DesgloseCuotasIVA.CuotaIVA );

                                              If   DesgloseCuotasIVA.BienInversion
                                              then DetalleIVARecibida2.BienInversion := BienInversionType.S;

                                              DecAdd( CuotaDeducible, DesgloseCuotasIVA.CuotaIVA );

                                              ListaDetalleIVARecibida2.Add( DetalleIVARecibida2 );
                                              end;

                                            If   ListaDetalleIVARecibida2.Count>0
                                            then DesgloseFacturaRecibida.InversionSujetoPasivo := InversionSujetoPasivo( ListaDetalleIVARecibida2.ToArray );

                                          finally
                                            ListaDetalleIVARecibida2.Free;
                                            end;

                                          end
                                     else begin

                                          ListaDetalleIVARecibida :=  TList<DetalleIVARecibidaType>.Create;

                                          try

                                            For DesgloseCuotasIVA in ListaDesgloseCuotasIVA do
                                              begin

                                              DetalleIVARecibida := DetalleIVARecibidaType.Create;

                                              DetalleIVARecibida.BaseImponible := DecimalString( DesgloseCuotasIVA.BaseImponible );

                                              If   not FacturaPrimerSemestre
                                              then begin

                                                   If   FacturaRecibida.ClaveRegimenEspecialOTrascendencia=IdOperacionesTrascendenciaTributariaType._02
                                                   then begin
                                                        DetalleIVARecibida.PorcentCompensacionREAGYP := DecimalString( DesgloseCuotasIVA.TipoImpositivo );
                                                        DetalleIVARecibida.ImporteCompensacionREAGYP := DecimalString( DesgloseCuotasIVA.CuotaIVA );
                                                        end
                                                   else begin
                                                        DetalleIVARecibida.TipoImpositivo := DecimalString( DesgloseCuotasIVA.TipoImpositivo );
                                                        DetalleIVARecibida.CuotaSoportada := DecimalString( DesgloseCuotasIVA.CuotaIVA );
                                                        end;

                                                   If   DesgloseCuotasIVA.BienInversion
                                                   then DetalleIVARecibida.BienInversion := BienInversionType.S;

                                                   DecAdd( CuotaDeducible, DesgloseCuotasIVA.CuotaIVA );
                                                   end;

                                              ListaDetalleIVARecibida.Add( DetalleIVARecibida );
                                              end;

                                            If   ListaDetalleIVARecibida.Count>0
                                            then DesgloseFacturaRecibida.DesgloseIVA := DesgloseIVA( ListaDetalleIVARecibida.ToArray );

                                          finally
                                            ListaDetalleIVARecibida.Free;
                                            end;

                                          end;

                                     If   FacturaPrimerSemestre
                                     then begin
                                          FacturaRecibida.FechaRegContable := FormatDateTime( 'dd-mm-yyyy', Now );
                                          FacturaRecibida.CuotaDeducible := '0';
                                          end
                                     else begin
                                          FacturaRecibida.FechaRegContable := FormatDateTime( 'dd-mm-yyyy', AsientoFields.Fecha.Value );
                                          FacturaRecibida.CuotaDeducible := DecimalString( CuotaDeducible );
                                          end;

                                     FacturaRecibida.FechaOperacion := FormatDateTime( 'dd-mm-yyyy', AsientoFields.FechaDocumento.Value );

                                     FacturaRecibida.ImporteTotal := DecimalString( ImporteFactura );
                                     FacturaRecibida.DescripcionOperacion := DescripcionOperacion;
                                     FacturaRecibida.DesgloseFactura := DesgloseFacturaRecibida;

                                     PeriodoLiq := PeriodoLiquidacion.Create;
                                     PeriodoLiq.Ejercicio := IntToStr( EjercicioPresentacion );
                                     PeriodoLiq.Periodo := TipoPeriodoType( Periodo );

                                     LRfacturasRecibidas.IDFactura := IDFacturaRecibida;
                                     LRfacturasRecibidas.FacturaRecibida := FacturaRecibida;
                                     LRfacturasRecibidas.PeriodoLiquidacion := PeriodoLiq;

                                     RegistroLRFacturasRecibidasList.Add( LRfacturasRecibidas );
                                     end
                                else ShowNotification( ntStop, Format( RpfMsg9, [ AsientoFields.Propietario.Value ] ) );
                                end
                           else ShowNotification( ntStop, Format( RpfMsg10, [ AsientoFields.NroAsiento.Value ] ) );

                           end
                      else ShowNotification( ntStop, Format( RpfMsg22, [ AsientoFields.NroAsiento.Value ] ) );

                 Next;
                 end;

               end;

           If   RegistroLRFacturasRecibidasList.Count=0
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

           SuministroLRFrasRecibidas.Cabecera := Cabecera;
           SuministroLRFrasRecibidas.RegistroLRFacturasRecibidas := Array_Of_LRfacturasRecibidasType( RegistroLRFacturasRecibidasList.ToArray );

           RespuestaLRFrasRecibidas := siiSOAPFactRecibidas.SuministroLRFacturasRecibidas( SuministroLRFrasRecibidas );

           // RespuestaLRFrasRecibidas.EstadoEnvio=EstadoEnvioTypeCorrecto, ParcialmenteCorrecto Correcto

           For I := 0 to Length( RespuestaLRFrasRecibidas.RespuestaLinea ) - 1 do
             begin
             RespuestaRecibida := RespuestaLRFrasRecibidas.RespuestaLinea[ I ];
             If   Assigned( RespuestaRecibida )
             then begin

                  If   Assigned( RespuestaRecibida.IDFactura.IDEmisorFactura.IDOtro )
                  then NIFPropietario := RespuestaRecibida.IDFactura.IDEmisorFactura.IDOtro.ID
                  else NIFPropietario := RespuestaRecibida.IDFactura.IDEmisorFactura.NIF;

                  RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaRecibida,
                                                                         Operacion,
                                                                         RelacionPropietarios.Values[ NIFPropietario ],
                                                                         RespuestaRecibida.IDFactura.NumSerieFacturaEmisor,
                                                                         0,
                                                                         NIFPropietario,
                                                                         RegistroPresentacion.EstadoRegistroSii( Ord( RespuestaRecibida.EstadoRegistro ) ),
                                                                         RespuestaRecibida.CodigoErrorRegistro,
                                                                         RespuestaRecibida.DescripcionErrorRegistro,
                                                                         0.0,
                                                                         0.0,
                                                                         Now );

                  If   RespuestaRecibida.CodigoErrorRegistro=0
                  then ProcessFrame.AddMsg( ntInformation, Format( RpfMsg2, [ RespuestaRecibida.IDFactura.NumSerieFacturaEmisor ] ) )
                  else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ RespuestaRecibida.IDFactura.NumSerieFacturaEmisor, IntToStr( RespuestaRecibida.CodigoErrorRegistro ) + ' , ' + RespuestaRecibida.DescripcionErrorRegistro  ] ) );

                  end;

             end;

           finally
             RelacionPropietarios.Free;
             RegistroLRFacturasRecibidasList.Free;
             SuministroLRFrasRecibidas.Free;
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

           FiltroRecibidas := LRFiltroRecibidasType.Create;
           FiltroRecibidas.PeriodoLiquidacion := PeriodoLiq;

           If   FechaPresentacionConsulta<>0
           then begin
                RangoFechaPresentacion := RangoFechaPresentacionType.Create;
                RangoFechaPresentacion.Desde := FormatDateTime( 'dd-mm-yyyy', FechaPresentacionConsulta );
                RangoFechaPresentacion.Hasta := FormatDateTime( 'dd-mm-yyyy', FechaPresentacionConsulta );
                FiltroRecibidas.FechaPresentacion := RangoFechaPresentacion;
                end;

           ConsultaLRFrasRecibidas := ConsultaLRFacturasRecibidas.Create;
           ConsultaLRFrasRecibidas.Cabecera := CabeceraConsulta;
           ConsultaLRFrasRecibidas.FiltroConsulta := FiltroRecibidas;

           try

             RespuestaConsultaLRFrasRecibidas := siiSOAPFactRecibidas.ConsultaLRFacturasRecibidas( ConsultaLRFrasRecibidas );

             If   RespuestaConsultaLRFrasRecibidas.ResultadoConsulta=ResultadoConsultaType.ConDatos
             then For I := 0 to Length( RespuestaConsultaLRFrasRecibidas.RegistroRespuestaConsultaLRFacturasRecibidas ) - 1 do
                    begin

                    RegistroRespuestaConsultaRecibidas := RespuestaConsultaLRFrasRecibidas.RegistroRespuestaConsultaLRFacturasRecibidas[ I ];

                    Serie := RegistroRespuestaConsultaRecibidas.IDFactura.NumSerieFacturaEmisor;

                    If   Assigned( RegistroRespuestaConsultaRecibidas.IDFactura.IDEmisorFactura.IDOtro )
                    then NIFPropietario := RegistroRespuestaConsultaRecibidas.IDFactura.IDEmisorFactura.IDOtro.ID
                    else NIFPropietario := RegistroRespuestaConsultaRecibidas.IDFactura.IDEmisorFactura.NIF;

                    ImportePresentacion := ObtenImportePresentacionFacturaRecibida( RegistroRespuestaConsultaRecibidas.DatosFacturaRecibida );
                    FechaPresentacion := StrToDateTimeDef( RegistroRespuestaConsultaRecibidas.DatosPresentacion.TimestampPresentacion, 0, TimeStampFormatSettings );

                    // Obteniendo el importe de la factura para cotejarlo con el presentado

                    Proveedor.ObtenPorNIF( NIFPropietario, ProveedorFields );

                    If   Factura.ObtenImportesFacturaRecibida( ApplicationContainer.Ejercicio, ProveedorFields.Subcuenta.Value, Serie, Asiento, BaseImponible, CuotaIVA, ImporteFactura )
                    then begin

                         // Si es una factura con inversión del sujeto pasivo incluye las cuotas de IVA, pero en GESTWIN, no se acumulan a las bases

                         If   Assigned( RegistroRespuestaConsultaRecibidas.DatosFacturaRecibida.DesgloseFactura.InversionSujetoPasivo )
                         then ImporteFactura := BaseImponible + CuotaIVA
                         else case RegistroRespuestaConsultaRecibidas.DatosFacturaRecibida.ClaveRegimenEspecialOTrascendencia of

                                // Si la factura es intracomunitaria en GESTWIN el ImporteTotal no acumula la cuota de IVA, pero sí que está el valor en el campo CuotaIVA

                                IdOperacionesTrascendenciaTributariaType._09 :   // Adquisiciones intracomunitarias de bienes y prestaciones de servicios
                                ImporteFactura := BaseImponible + CuotaIVA;

                                // Si es una factura del primer trimestre el importe total es la base imponible (no se suben las cuotas)

                                IdOperacionesTrascendenciaTributariaType._14 :   // Primer semestre 2017
                                ImporteFactura := BaseImponible;
                               end;

                         If   NIFPropietario<>ProveedorFields.NIF.Value
                         then ProcessFrame.AddMsg( ntError, Format( RpfMsg17, [ Serie, Propietario, NIFPropietario ] ) + ' ' +
                                                            Format( RpfMsg14, [ StrFormatDate( FechaPresentacion ), ImportePresentacion ] ) )
                         else begin

                              RegistroPresentacion.ActualizaRegistroPresentacionSii( rpFacturaRecibida,
                                                                                     Operacion,
                                                                                     ProveedorFields.Subcuenta.Value,
                                                                                     Serie,
                                                                                     0,
                                                                                     NIFPropietario,
                                                                                     RegistroPresentacion.EstadoPresentacionSii( Ord( RegistroRespuestaConsultaRecibidas.EstadoFactura.EstadoRegistro ) ),
                                                                                     RegistroRespuestaConsultaRecibidas.EstadoFactura.CodigoErrorRegistro,
                                                                                     RegistroRespuestaConsultaRecibidas.EstadoFactura.DescripcionErrorRegistro,
                                                                                     ImporteFactura,
                                                                                     ImportePresentacion,
                                                                                     FechaPresentacion,
                                                                                     Ord( RegistroRespuestaConsultaRecibidas.EstadoFactura.EstadoCuadre ) );

                              ProcessFrame.AddMsg( ntInformation, Format( RpfMsg19, [ Serie, ProveedorFields.Subcuenta.Value, NIFPropietario ] ) )
                              end;

                         end
                    else ProcessFrame.AddMsg( ntError, Format( RpfMsg13, [ Serie, ProveedorFields.Subcuenta.Value, NIFPropietario ] ) + ' ' +
                                                       Format( RpfMsg14, [ StrFormatDate( FechaPresentacion ), ImportePresentacion ] ) );

                    end;

           finally
             ConsultaLRFrasRecibidas.Free;
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

