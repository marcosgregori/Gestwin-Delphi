{$ALIGN OFF} {$OPTIMIZATION OFF}

unit dm_suf;

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
  Soap.XSBuiltIns,

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

  SistemaFacturacion,

  Gim00Fields,
  Gim10Fields,
  Gim30Fields,

  FacturaVentasIntf,

  dmi_iva,
  dmi_ast,

  dm_rpf;

type

  // TTipoRegistroFactura = ( trfAlta, trfAnulacion );

  TSuministroFacturasModule = class(TDataModule)
    LineaMovimientoTable: TnxeTable;
    FacturaVentasTable: TnxeTable;
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

    FacturaVentasFields : TFacturaVentasFields;
    LineaMovimientoFields : TLineaMovimientoFields;

    FacturaVentasAnteriorFields,
    FacturaRectificadaFields : TFacturaVentasFields;
    FacturaFields : TFacturaFields;
    ClienteFields : TClienteFields;
    TiposIVAFields : TTiposIVAFields;
    PaisFields : TPaisFields;

    EjercicioPresentacion : Word;
    SuministroConfigurado : Boolean;

    function ObtenClaveTipoFacturaEmitida( Value: SmallInt ) : ClaveTipoFacturaType;
    function ObtenStringTipoFacturaEmitida( Value: SmallInt ) : String;
    function ObtenIDType( Value : SmallInt ): PersonaFisicaJuridicaIDTypeType;
    function ObtenCountryType2(Value: String): CountryType2;
    function ObtenCausaExencionType( Value : SmallInt ): OperacionExentaType;
    function ObtenIdOperacionesTrascendenciaTributariaType( Value : SmallInt ): IdOperacionesTrascendenciaTributariaType;
    procedure CompletaRegistroSistemaInformatico( SistemaInformatico : SistemaInformaticoType );

    function ObtenHuella( IDEmisorFactura          : String;
                          NumSerieFactura          : String;
                          FechaExpedicionFactura   : String;
                          TipoFactura              : SmallInt;
                          CuotaTotal,
                          ImporteTotal,
                          HuellaAnterior           : String;
                          FechaHoraHusoGenRegistro : TXSDateTime ) : String;

    {
    function ObtenHuellaAnulacion( IDEmisorFacturaAnulada        : String;
                                   NumSerieFacturaAnulada        : String;
                                   FechaExpedicionFacturaAnulada : String;
                                   HuellaAnterior                : String;
                                   FechaHoraHusoGenRegistro      : TXSDateTime ) : String;
    }
    function ObtenCalificacionOperacion( FacturaVentasFields : TFacturaVentasFields ) : CalificacionOperacionType;

    function EncodeSHA256(Value: String): String;
    function GetHashVerifactu(Value: String): String;



  public

    procedure ConfiguraSuministro;

    function ObtenRegistroSuministroFactura( Serie                       : String;
                                             NroFactura                  : LongInt;
                                             EstadoPresentacionVerifactu : TEstadoPresentacionVerifactu;
                                             EstadoRegistroVerifactu     : TEstadoRegistroVerifactu ) : RegistroFacturaType;

    procedure SuministraFacturas( ArrayOfRegistroFactura : Array_Of_RegistroFacturaType );

    function SuministroInformacion( // TipoRegistroFactura          : TTipoRegistroFactura;
                                    RelacionFacturasCacheDataset : TnxeCachedDataSet ) : String;

    procedure InvalidaUltimoRegistroPresentacionFactura;

  end;


var SuministroFacturasModule: TSuministroFacturasModule = nil;

function  SuministroFacturas : TSuministroFacturasModule;

implementation

uses Math,
     Variants,
     EnterpriseDataAccess,
     AppManager,
     DateUtils,
     System.TypInfo,

     dxHash,
     clTranslator,

     Gdm00Dm,

     dmi_fac,

     dm_cer,
     dm_pai,
     dm_pga,
     dm_iva,
     dm_sdf,
     dm_fac,
     dm_fdv,

     dm_cli,
     dm_pro,

     f_prg;

{$R *.DFM}

resourceString

     // WSDLSistemaFacturacion = 'https://www2.agenciatributaria.gob.es/static_files/common/internet/dep/aplicaciones/es/aeat/tike/cont/ws/SistemaFacturacion.wsdl';
     URLSistemaFacturacion = 'https://www1.agenciatributaria.gob.es/wlpl/TIKE-CONT/ws/SistemaFacturacion/VerifactuSOAP';
     URLSistemaFacturacionPruebas = 'https://prewww1.aeat.es/wlpl/TIKE-CONT/ws/SistemaFacturacion/VerifactuSOAP';

     RsMsg1 = 'No se ha podido recuperar la ficha del cliente de código %s.';
     RsMsg2 = 'No se ha podido recuperar el registro de la factura nº %s %d.';
     RsMsg3 = 'No se ha seleccionado ningún registro.';
     RsMsg4 = 'La factura %s %d no tiene ninguna base imponible.';
     // RsMsg5 = 'La factura %s %d ha sido seleccionada para su presentación.';
     RsMsg6 = 'No se ha podido recuperar el registro de la factura a rectificar del ejercicio %d nº %s %d.';
     RsMsg7 = 'La factura presentada es la nº %s %d.';
     RsMsg8 = 'No se ha indicado el número de la factura a la que rectifica en la factura nº %s %d.';
     RsMsg9 = 'La factura nº %s %d está exenta del I.V.A. y, sin embargo, las cuotas de IVA/RE no son cero.';

function SuministroFacturas : TSuministroFacturasModule;
begin
     CreateDataModule( TSuministroFacturasModule, SuministroFacturasModule );
     Result := SuministroFacturasModule;
end;

procedure TSuministroFacturasModule.DataModuleCreate(Sender: TObject);
begin

     FacturaVentasFields := TFacturaVentasFields.Create( FacturaVentasTable );
     LineaMovimientoFields := TLineaMovimientoFields.Create( LineaMovimientoTable );

     FacturaVentasAnteriorFields := TFacturaVentasFields.Create( Self );
     FacturaRectificadaFields := TFacturaVentasFields.Create( Self );
     ClienteFields := TClienteFields.Create( Self );
     TiposIVAFields := TTiposIVAFields.Create( Self );

     FacturaFields := TFacturaFields.Create( Self );
     PaisFields := TPaisFields.Create( Self );

     DecimalFormatSettings := TFormatSettings.Create;
     DecimalFormatSettings.DecimalSeparator := '.';

     TimeStampFormatSettings := TFormatSettings.Create;
     TimeStampFormatSettings.ShortDateFormat := 'dd-mm-yyyy';
     TimeStampFormatSettings.DateSeparator := '-';

     EjercicioPresentacion := YearOf( ApplicationContainer.TodayDate );

end;

procedure TSuministroFacturasModule.DataModuleDestroy(Sender: TObject);
begin
     SuministroFacturasModule := nil;
end;

procedure TSuministroFacturasModule.HttpGetCertificate(     Sender       : TObject;
                                                        var ACertificate : TclCertificate;
                                                            AExtraCerts  : TclCertificateList;
                                                        var Handled      : Boolean );
begin
     ACertificate := Certificados.CertificadoUsuario;
     Handled := True;
end;

procedure TSuministroFacturasModule.HttpReceiveResponse(Sender: TObject; const AMethod, AUrl: string; AResponseHeader: TStrings; ACookies: TclCookieList);
begin
     RegistroPresentacion.AddResponseHeader( AMethod, AResponseHeader );
end;

procedure TSuministroFacturasModule.HttpRioBeforeExecute(const MethodName: string; SOAPRequest: TStream);

var sTmp : TStringList;
    sText : String;

begin
     { DEBUG Aqui puedo comprobar el texto XML enviado }
     sTmp := TStringList.Create;
     try
       SOAPRequest.Position := 0;
       sTmp.LoadFromStream( SOAPRequest );
         sText := sTmp.Text;
     finally
       sTmp.Free;
       end;

end;

function TSuministroFacturasModule.EncodeSHA256( Value : String ) : String;

var AAlgorithm: TdxHashAlgorithm;

begin
     Result := '';
     AAlgorithm := TdxSHA256HashAlgorithm.Create;
     try
       Result := StringOf( AAlgorithm.Calculate( Value ) );
    finally
      AAlgorithm.Free;
    end;
end;

function TSuministroFacturasModule.GetHashVerifactu( Value : String ): String;
begin
     Result := StrToHex( EncodeSHA256( TclTranslator.TranslateToUtf8( Value ) ) );
end;

function TSuministroFacturasModule.ObtenIdOperacionesTrascendenciaTributariaType( Value : SmallInt ) : IdOperacionesTrascendenciaTributariaType;
begin
     Result := IdOperacionesTrascendenciaTributariaType( Value );
end;

function TSuministroFacturasModule.ObtenCausaExencionType( Value : SmallInt  ) : OperacionExentaType;
begin
     Result := OperacionExentaType( Value );
end;

function TSuministroFacturasModule.ObtenClaveTipoFacturaEmitida( Value : SmallInt ) : ClaveTipoFacturaType;
begin
     case Value of
       0 : Result := ClaveTipoFacturaType.F1;      // Factura (art. 6, 7.2 y 7.3 del RD 1619/2012)
       1 : Result := ClaveTipoFacturaType.F2;      // Factura Simplificada y Facturas sin identificación del destinatario art. 6.1.d) RD 1619/2012
       2 : Result := ClaveTipoFacturaType.F3;      // Factura emitida en sustitución de facturas simplificadas facturadas y declaradas
       3 : ; // Result := ClaveTipoFacturaType.F4;
       4 : Result := ClaveTipoFacturaType.R1;      // Factura Rectificativa (Error fundado en derecho y Art. 80 Uno Dos y Seis LIVA)
       5 : Result := ClaveTipoFacturaType.R2;      // Factura Rectificativa (Art. 80.3)
       6 : Result := ClaveTipoFacturaType.R3;      // Factura Rectificativa (Art. 80.4)
       7 : Result := ClaveTipoFacturaType.R4;      // Factura Rectificativa (Resto)
       8 : Result := ClaveTipoFacturaType.R5;      // Factura Rectificativa en facturas simplificadas
       end;
end;

function TSuministroFacturasModule.ObtenCountryType2(Value: String): CountryType2;
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

function TSuministroFacturasModule.ObtenIDType( Value : SmallInt ) : PersonaFisicaJuridicaIDTypeType;
begin
     Result := PersonaFisicaJuridicaIDTypeType( Value );
end;

function TSuministroFacturasModule.ObtenStringTipoFacturaEmitida( Value : SmallInt ) : String;
begin
     Result := GetEnumName( TypeInfo( ClaveTipoFacturaType ), Ord( ObtenClaveTipoFacturaEmitida( Value ) ) );
end;

procedure TSuministroFacturasModule.CompletaRegistroSistemaInformatico( SistemaInformatico : SistemaInformaticoType );
begin

     With SistemaInformatico do
       begin
       NombreRazon := 'Winstation, S.L.';
       NIF := 'B12406989';

       {
       IDOtro := IDOtroType.Create;
       IDOtro.IDType := PersonaFisicaJuridicaIDTypeType._02;
       IDOtro.ID := NIF;
       }

       NombreSistemaInformatico := 'Gestwin';
       IdSistemaInformatico := '00';
       Version := IntToStr( VersionInfo.MajorVersion ) + '.' + IntToStr( VersionInfo.MinorVersion );
       NumeroInstalacion := IntToStr( VersionInfo.Release );
       TipoUsoPosibleSoloVerifactu := SiNoType.S;  // Solo funciona como Veri*factu
       end;
end;

function TSuministroFacturasModule.ObtenHuella( IDEmisorFactura          : String;
                                                NumSerieFactura          : String;
                                                FechaExpedicionFactura   : String;
                                                TipoFactura              : SmallInt;
                                                CuotaTotal,
                                                ImporteTotal,
                                                HuellaAnterior           : String;
                                                FechaHoraHusoGenRegistro : TXSDateTime ) : String;
begin

     var Code := 'IDEmisorFactura=' + IdEmisorFactura + '&' +
                 'NumSerieFactura=' + NumSerieFactura + '&' +
                 'FechaExpedicionFactura=' + FechaExpedicionFactura + '&' +
                 'TipoFactura=' + ObtenStringTipoFacturaEmitida( TipoFactura ) + '&' +
                 'CuotaTotal=' + CuotaTotal + '&' +
                 'ImporteTotal=' + ImporteTotal + '&' +
                 'Huella=' + HuellaAnterior + '&' +
                 'FechaHoraHusoGenRegistro=' + FechaHoraHusoGenRegistro.NativeToXS;

     Result := GetHashVerifactu( Code );

end;

{
function TSuministroFacturasModule.ObtenHuellaAnulacion( IDEmisorFacturaAnulada          : String;
                                                         NumSerieFacturaAnulada          : String;
                                                         FechaExpedicionFacturaAnulada   : String;
                                                         HuellaAnterior                  : String;
                                                         FechaHoraHusoGenRegistro        : TXSDateTime ) : String;
begin

     var Code := 'IDEmisorFacturaAnulada=' + IdEmisorFacturaAnulada + '&' +
                 'NumSerieFacturaAnulada=' + NumSerieFacturaAnulada + '&' +
                 'FechaExpedicionFacturaAnulada=' + FechaExpedicionFacturaAnulada + '&' +
                 'Huella=' + HuellaAnterior + '&' +
                 'FechaHoraHusoGenRegistro=' + FechaHoraHusoGenRegistro.NativeToXS;

     Result := GetHashVerifactu( Code );

end;
}

function TSuministroFacturasModule.ObtenCalificacionOperacion( FacturaVentasFields : TFacturaVentasFields ) : CalificacionOperacionType;
begin
     If   FacturaVentasFields.InversionSujetoPasivo.Value
     then Result := CalificacionOperacionType.S2                       // Operación Sujeta y No exenta - Con Inversión del sujeto pasivo
     else If   FacturaFields.RegimenOTrascendencia.Value=rteExportacion
          then Result := CalificacionOperacionType.N2                  // Operación No Sujeta por Reglas de localización
          else If   ClienteFields.Factura_ModeloIVA.Value=micExento
               then Result := CalificacionOperacionType.N1             // Operación No Sujeta artículo 7, 14, otros
               else Result := CalificacionOperacionType.S1;            // Operación Sujeta y No exenta - Sin inversión del sujeto pasivo
end;

procedure TSuministroFacturasModule.ConfiguraSuministro;
begin
     If   not SuministroConfigurado
     then begin

          Certificados.CompruebaCertificadoUsuario;

          // HttpRio.Service := 'sfVerifactu';

          If   EntornoPruebasVerifactu
          then begin
               HttpRio.URL := URLSistemaFacturacionPruebas;
               HttpRio.Port := 'SistemaVerifactuPruebas';
               end
          else begin
               HttpRio.URL := URLSistemaFacturacion;
               HttpRio.Port := 'SistemaVerifactu';
               end;

          SuministroConfigurado := True;
          end;
end;

function TSuministroFacturasModule.ObtenRegistroSuministroFactura( Serie                       : String;
                                                                   NroFactura                  : LongInt;
                                                                   EstadoPresentacionVerifactu : TEstadoPresentacionVerifactu;
                                                                   EstadoRegistroVerifactu     : TEstadoRegistroVerifactu ) : RegistroFacturaType;

var  FacturaExenta : Boolean;
     TasasArray : TTasasArray;
     TotalCuotaIVA,
     TotalCuotaRE : Decimal;

begin

     Result := nil;

     If   FacturaVentasTable.FindKey( [ ApplicationContainer.Ejercicio, Serie, NroFactura ] )
     then begin

          // Hago la comprobación del registro de la factura aparte para poder notificar al usuario su posible ausencia

          If   Factura.ObtenRegistroComercialFactura( tfFacturaVentas,
                                                      FacturaVentasFields.Ejercicio.Value,
                                                      '',
                                                      FacturaVentasFields.Serie.Value,
                                                      FacturaVentasFields.NroFactura.Value,
                                                      FacturaFields )
          then begin

               var HuellaFactura := '';
               var SerieNroFactura := RegistroPresentacion.SerieNroFactura( FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value );
               var FechaHoraPresentacionFactura := Now;

               If   Cliente.Obten( FacturaVentasFields.CodigoCliente.Value, '', ClienteFields )
               then begin

                    // Haciendo todas las comprobaciones posibles para intentar evitar las aceptaciones con errores

                    var CodigoPaisCliente := ClienteFields.CodigoPais.Value;

                    Pais.Obten( CodigoPaisCliente, PaisFields );

                    FacturaExenta := ( FacturaFields.RegimenOTrascendencia.Value=rteExportacion ) or ( ClienteFields.Factura_ModeloIVA.Value=micExento );

                    var RegistroFactura := RegistroFacturaType.Create;

                    RegistroFactura.RegistroAlta := RegistroAltaType.Create;

                    With RegistroFactura.RegistroAlta do
                      begin

                      IDVersion := VersionType._1_0;

                      IDFactura := IDFacturaExpedidaType.Create;
                      IDFactura.IDEmisorFactura := DataModule00.DmEmpresaFields.NIF.Value;
                      IDFactura.NumSerieFactura := SerieNroFactura;
                      IDFactura.FechaExpedicionFactura := FormatDateTime( 'dd-mm-yyyy', FacturaVentasFields.Fecha.Value );

                      NombreRazonEmisor := DataModule00.DmEmpresaFields.Nombre.Value;

                      If   EstadoRegistroVerifactu=ervAceptadoConErrores
                      then begin
                           Subsanacion := SubsanacionType.S;
                           RechazoPrevio := RechazoPrevioType.S;
                           end;

                      TipoFactura := ObtenClaveTipoFacturaEmitida( FacturaFields.TipoFactura.Value );

                      If   FacturaFields.TipoFactura.Value in [ tfeSustitucion, tfeRectificativa80_1_2..tfeRectificativaSimplificada ]   // Factura emitida en sustitución de otra o rectificativa
                      then If   FacturaVentas.Obten( FacturaFields.EjercicioFraRectificada.Value,
                                                     FacturaFields.SerieFraRectificada.Value,
                                                     FacturaFields.NroFacturaRectificada.Value,
                                                     FacturaRectificadaFields )
                           then begin

                                var IDFacturaAR := IDFacturaARType.Create;
                                With IDFacturaAR do
                                  begin
                                  IDEmisorFactura := DataModule00.DmEmpresaFields.NIF.Value;
                                  NumSerieFactura := RegistroPresentacion.SerieNroFactura( FacturaRectificadaFields.Serie.Value, FacturaRectificadaFields.NroFactura.Value );
                                  FechaExpedicionFactura := FormatDateTime( 'dd-mm-yyyy', FacturaRectificadaFields.Fecha.Value );
                                  end;

                                If   FacturaFields.Metodo.Value=2                         // Sustitutiva
                                then begin
                                     TipoRectificativa := ClaveTipoRectificativaType.I;
                                     FacturasSustituidas := FacturasSustituidas + [ IDFacturaAR ];
                                     end
                                else begin
                                     TipoRectificativa := ClaveTipoRectificativaType.S;   // Rectificativa
                                     FacturasRectificadas := FacturasRectificadas + [ IDFacturaAR ];
                                     end;

                                ImporteRectificacion := DesgloseRectificacionType.Create;

                                ImporteRectificacion.BaseRectificada := DecimalString( FacturaRectificadaFields.NetoFactura.Value );
                                ImporteRectificacion.CuotaRectificada := DecimalString( FacturaRectificadaFields.CuotaIVA.Value );
                                ImporteRectificacion.CuotaRecargoRectificado := DecimalString( FacturaRectificadaFields.CuotaRE.Value );

                                end
                           else begin
                                If   FacturaFields.NroFacturaRectificada.Value=0  // No se ha indicado el número de factura a la que rectifica en el registro
                                then ShowNotification( ntStop, Format( RsMsg8, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) )
                                else ShowNotification( ntStop, Format( RsMsg6, [ FacturaFields.EjercicioFraRectificada.Value,
                                                                                 FacturaFields.SerieFraRectificada.Value,
                                                                                 FacturaFields.NroFacturaRectificada.Value ] ),
                                Format( RsMsg7, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
                                Abort;
                                end;

                      DescripcionOperacion := 'Venta';  // O ya veremos

                      If   TipoFactura=ClaveTipoFacturaType.F2  // Factura Simplificada y Facturas sin identificación del destinatario art. 6.1.d) RD 1619/2012 (Tipo F2)
                      then FacturaSinIdentifDestinatarioArt61d := CompletaSinDestinatarioType.S
                      else If   TipoFactura in [ ClaveTipoFacturaType.F1,
                                                 ClaveTipoFacturaType.F3,
                                                 ClaveTipoFacturaType.R1,
                                                 ClaveTipoFacturaType.R2,
                                                 ClaveTipoFacturaType.R3,
                                                 ClaveTipoFacturaType.R4 ]
                           then begin
                                var PersonaFisicaJuridica := PersonaFisicaJuridicaType.Create;
                                PersonaFisicaJuridica.NombreRazon := ClienteFields.Nombre.Value;

                                If   CodigoPaisCliente=CodigoEspaña
                                then PersonaFisicaJuridica.NIF := ClienteFields.NIF.Value
                                else begin
                                     PersonaFisicaJuridica.IDOtro := IDOtroType.Create;
                                     PersonaFisicaJuridica.IDOtro.CodigoPais := ObtenCountryType2( PaisFields.CodigoISO2.Value );
                                     PersonaFisicaJuridica.IDOtro.IDType := PersonaFisicaJuridicaIDTypeType( ClienteFields.TipoIdentificacion.Value );
                                     PersonaFisicaJuridica.IDOtro.ID := ClienteFields.NIF.Value;;
                                     end;

                                Destinatarios := [ PersonaFisicaJuridica ];
                                end;

                      If   FacturaVentasFields.InversionSujetoPasivo.Value
                      then EmitidaPorTerceroODestinatario := TercerosODestinatarioType.D;   // Emitida por el destinatario

                      FacturaVentas.ObtenBasesyCuotasFactura( FacturaVentasFields.Ejercicio.Value,
                                                              FacturaVentasFields.CodigoCliente.Value,
                                                              FacturaVentasFields.Serie.Value,
                                                              FacturaVentasFields.NroFactura.Value,
                                                              TasasArray,
                                                              TotalCuotaIVA,
                                                              TotalCuotaRE,
                                                              { AplicarDtosyPortes } True );

                      var InxDsg := 0;

                      var SumaBaseImponible : Decimal := 0.0;
                      var SumaCuotas : Decimal := 0.0;

                      For var Index := 0 to NroMaximoTiposTasas do
                        If   TasasArray[ Index ].TieneBases
                        then begin

                             DecAdd( SumaBaseImponible, TasasArray[ Index ].BaseImponible );
                             DecAdd( SumaCuotas, TasasArray[ Index ].CuotaIVA + TasasArray[ Index ].CuotaRE );

                             var DetalleDesglose := DetalleType.Create;

                             DetalleDesglose.ClaveRegimen := ObtenIdOperacionesTrascendenciaTributariaType( FacturaFields.RegimenOTrascendencia.Value );

                             If   FacturaExenta
                             then DetalleDesglose.OperacionExenta := ObtenCausaExencionType( FacturaFields.CausaExencion.Value )
                             else begin

                                  DetalleDesglose.CalificacionOperacion := ObtenCalificacionOperacion( FacturaVentasFields );

                                  DetalleDesglose.TipoImpositivo := DecimalString( TasasArray[ Index ].TipoIVA );
                                  DetalleDesglose.CuotaRepercutida := DecimalString( TasasArray[ Index ].CuotaIVA );

                                  If   TasasArray[ Index ].CuotaRE<>0.0 // TieneRE
                                  then begin
                                       DetalleDesglose.TipoRecargoEquivalencia := DecimalString( TasasArray[ Index ].TipoRE );
                                       DetalleDesglose.CuotaRecargoEquivalencia := DecimalString( TasasArray[ Index ].CuotaRE );
                                       end;

                                  end;

                             // DetalleDesglose.BaseImponibleACoste := DecimalString( TasasArray[ Index ].BaseImponible );

                             DetalleDesglose.BaseImponibleOImporteNoSujeto := DecimalString( TasasArray[ Index ].BaseImponible );

                             Desglose := Desglose + [ DetalleDesglose ];
                             Inc( InxDsg ); // Solo admite 12 bases. Habrá que comprobarlo.

                             end;

                      // En las facturas exentas no deben existir cuotas

                      If  FacturaExenta and ( ( FacturaVentasFields.CuotaIVA.Value<>0.0 ) or ( FacturaVentasFields.CuotaRE.Value<>0.0 ) )
                      then begin
                           ShowNotification( ntStop, Format( RsMsg9, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
                           Abort;
                           end;

                      If   Length( Desglose )>0
                      then begin

                           CuotaTotal := DecimalString( FacturaVentasFields.CuotaIVA.Value + FacturaVentasFields.CuotaRe.Value );
                           ImporteTotal := DecimalString( FacturaVentasFields.TotalFactura.Value );

                           Encadenamiento := Encadenamiento3Type.Create;

                           var HuellaAnterior := '';

                           // El NroRegistro de la factura determina el orden de presentación, que se ha asignado en la generación de la factura

                           If   FacturaVentas.ObtenUltimoRegistroPresentacion( FacturaVentasAnteriorFields )
                           then begin
                                Encadenamiento.RegistroAnterior := EncadenamientoFacturaAnteriorType.Create;
                                With Encadenamiento.RegistroAnterior do
                                  begin
                                  IDEmisorFactura := DataModule00.DmEmpresaFields.NIF.Value;
                                  NumSerieFactura := RegistroPresentacion.SerieNroFactura( FacturaVentasAnteriorFields.Serie.Value, FacturaVentasAnteriorFields.NroFactura.Value );
                                  FechaExpedicionFactura := FormatDateTime( 'dd-mm-yyyy', FacturaVentasAnteriorFields.Fecha.Value );
                                  Huella := FacturaVentasAnteriorFields.Huella.Value;
                                  HuellaAnterior := Huella;
                                  end;

                                end
                           else Encadenamiento.PrimerRegistro := PrimerRegistroCadenaType.S;   // He de suponer que no existe registro anterior

                           SistemaInformatico := SistemaInformaticoType.Create;
                           CompletaRegistroSistemaInformatico( SistemaInformatico );

                           FechaHoraHusoGenRegistro := DateTimeToXSDateTime( FechaHoraPresentacionFactura, {ApplyLocalBias} True );
                           FechaHoraHusoGenRegistro.FractionalSeconds := 0;
                           var FechaHora := FechaHoraHusoGenRegistro.AsDateTime;

                           TipoHuella := TipoHuellaType._01;

                           HuellaFactura := ObtenHuella( IDFactura.IDEmisorFactura,
                                                         SerieNroFactura,
                                                         IDFactura.FechaExpedicionFactura,
                                                         FacturaFields.TipoFactura.Value,
                                                         CuotaTotal,
                                                         ImporteTotal,
                                                         HuellaAnterior,
                                                         FechaHoraHusoGenRegistro );

                           Huella := HuellaFactura;
                           end
                      else begin
                           ShowNotification( ntStop, Format( RsMsg4, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );
                           Abort;
                           end;
                      end;

                    Result := RegistroFactura;

                    If   EstadoPresentacionVerifactu=epvPendiente  // Por si es un re-envío de una factura aceptada con errores
                    then begin

                         FacturaVentasTable.Edit;

                         // El NroRegistroPresentacion se genera cada vez que se intenta enviar las facturas a Verifactu. En realidad
                         // solo indica el orden de presentación. Eso es así porque estas facturas no han sido presentadas antes y
                         // podemos reasignar la secuencia cada vez de acuerdo con su Serie+Nrofactura, que es el orden de la consulta.

                         FacturaVentasFields.NroRegistroPresentacion.Value := FacturaVentas.ProximoNroRegistroPresentacion;
                         FacturaVentasFields.Presentada.Value := FechaHoraPresentacionFactura;
                         FacturaVentasFields.Huella.Value := HuellaFactura;

                         FacturaVentasTable.Post;

                         end;

                    // ShowNotification( ntRecordInformation, Format( RsMsg5, [ Serie, NroFactura ] ) );

                    end
               else ShowNotification( ntStop, Format( RsMsg1, [ FacturaVentasFields.CodigoCliente.Value ] ) );

               end
          else ShowNotification( ntStop, Format( RsMsg2, [ Serie, NroFactura ] ) );
          end
     else ShowNotification( ntStop, Format( RsMsg2, [ Serie, NroFactura ] ) );

end;

procedure TSuministroFacturasModule.InvalidaUltimoRegistroPresentacionFactura;
begin

     // Por si acaso

     RegistroPresentacion.SuprimeRegistroPresentacionVerifactu( FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value );

     // Solo se puede llamar después de ObtenRegistroSuministroFactura cuando se ha producido un error grave en la presentación

     FacturaVentasTable.Edit;

     FacturaVentasFields.NroRegistroPresentacion.Clear;
     FacturaVentasFields.Presentada.Clear;
     FacturaVentasFields.Huella.Clear;

     FacturaVentasTable.Post;

end;

procedure TSuministroFacturasModule.SuministraFacturas( ArrayOfRegistroFactura : Array_Of_RegistroFacturaType );

var  NumSerieFactura,
     Serie : String;
     NroFactura : LongInt;
     PortTypeVerifactu : sfPortTypeVerifactu;

begin

     PortTypeVerifactu := ( HttpRio as SistemaFacturacion.sfPortTypeVerifactu );

     var SuministroLRFrasEmitidas := RegFactuSistemaFacturacionType.Create;

     var Cabecera := CabeceraType.Create;

     With Cabecera do
       begin
       ObligadoEmision := PersonaFisicaJuridicaESType.Create;
       ObligadoEmision.NombreRazon := DataModule00.DmEmpresaFields.Nombre.Value;
       ObligadoEmision.NIF := DataModule00.DmEmpresaFields.NIF.Value;
       end;

     SuministroLRFrasEmitidas.Cabecera := Cabecera;
     SuministroLRFrasEmitidas.RegistroFactura  := ArrayOfRegistroFactura;

     var RespuestaSuministro := PortTypeVerifactu.RegFactuSistemaFacturacion( SuministroLRFrasEmitidas );   // RespuestaRegFactuSistemaFacturacionType

     // Por lo visto (al menos con los últimos cambios) si se presenta una factura que ya ha sido presentada se acepta como
     // válida siempre y cuando coincidan los valores del registro. Ese permite repetir el proceso en caso de interrupción a partir
     // de éste punto.

     For var I := 0 to Length( ArrayOfRegistroFactura { RespuestaSuministro } ) - 1 do
       begin

       var RespuestaExpedida := RespuestaSuministro.RespuestaLinea[ I ];

       If   Assigned( RespuestaExpedida.IDFactura )
       then NumSerieFactura := RespuestaExpedida.IDFactura.NumSerieFactura
       else NumSerieFactura := ArrayOfRegistroFactura[ I ].RegistroAlta.IDFactura.NumSerieFactura;

       If   RegistroPresentacion.ExtraeSerieNroFactura( NumSerieFactura, Serie, NroFactura )
       then begin

            // Si la factura ya consta como presentada en Hacienda, pero no estaba correctamente registrada en el fichero de presentación, se anota como presentada
            // y guardamos el error que se ha producido en el registro

            var FacturaDuplicada := ( ( RespuestaExpedida.EstadoRegistro=EstadoRegistroType.Incorrecto ) and ( RespuestaExpedida.CodigoErrorRegistro=3000 ) ); // Factura duplicada. En este caso la marcamos como presentada y a otra cosa

            If   ( RespuestaExpedida.EstadoRegistro in [ EstadoRegistroType.Correcto, EstadoRegistroType.AceptadoConErrores ] ) or FacturaDuplicada
            then begin

                 If   FacturaDuplicada
                 then RespuestaExpedida.EstadoRegistro := EstadoRegistroType.Correcto;

                 RegistroPresentacion.ActualizaRegistroPresentacionVerifactu( ofvAlta,
                                                                              Serie,
                                                                              NroFactura,
                                                                              TEstadoRegistroVerifactu( Ord( RespuestaExpedida.EstadoRegistro ) ),  // Son equivalentes, pero tengo mi propio tipo
                                                                              RespuestaExpedida.CodigoErrorRegistro,
                                                                              RespuestaExpedida.DescripcionErrorRegistro,
                                                                              Now );

                 ProcessFrame.AddMsg( ntInformation, Format( RpfMsg2, [ NumSerieFactura ] ) );
                 end
            else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ NumSerieFactura, IntToStr( RespuestaExpedida.CodigoErrorRegistro ) + ' , ' + RespuestaExpedida.DescripcionErrorRegistro  ] ) );
            end
       else ProcessFrame.AddMsg( ntWarning, Format( RpfMsg18, [ NumSerieFactura ] ) );

       end;
end;

function TSuministroFacturasModule.SuministroInformacion( // TipoRegistroFactura          : TTipoRegistroFactura;
                                                          RelacionFacturasCacheDataset : TnxeCachedDataSet ) : String;

var  RelacionFacturasCacheFields : TRelacionFacturasPresentacionFields;

     RegistroFacturasList : TList< RegistroFacturaType >;

     RegistroFacturacionAlta : RegistroFacturacionAltaType;
     RegistroFacturacionAnulacion : RegistroFacturacionAnulacionType;

     NumSerieFactura,
     Serie : String;
     NroFactura : LongInt;

     TasasArray : TTasasArray;
     TotalCuotaIVA,
     TotalCuotaRE : Decimal;

     FechaPresentacion : TDate;

     NotificationMessage : TNotificationType;
     EstadoRegistro : EstadoRegistroType;

     FacturaExenta : Boolean;

     EstadoPresentacionVerifactu : TEstadoPresentacionVerifactu;
     EstadoRegistroVerifactu : TEstadoRegistroVerifactu;

     PortTypeVerifactu : sfPortTypeVerifactu;

function ObtenCalificacionOperacion : CalificacionOperacionType;
begin
     If   FacturaVentasFields.InversionSujetoPasivo.Value
     then Result := CalificacionOperacionType.S2                       // Operación Sujeta y No exenta - Con Inversión del sujeto pasivo
     else If   FacturaFields.RegimenOTrascendencia.Value=rteExportacion
          then Result := CalificacionOperacionType.N2                  // Operación No Sujeta por Reglas de localización
          else If   ClienteFields.Factura_ModeloIVA.Value=micExento
               then Result := CalificacionOperacionType.N1             // Operación No Sujeta artículo 7, 14, otros
               else Result := CalificacionOperacionType.S1;            // Operación Sujeta y No exenta - Sin inversión del sujeto pasivo
end;

begin

     ConfiguraSuministro;

     try

       try

         RelacionFacturasCacheFields := TRelacionFacturasPresentacionFields.Create( RelacionFacturasCacheDataset );

         {
         case TipoRegistroFactura of

           trfAlta :
             begin
         }

             RegistroFacturasList := TList< RegistroFacturaType >.Create;

             try

               // La relación (RelacionFacturasCacheDataset) está ordenada por el NroRegistro de la factura de ventas, que determina su orden de presentación

               With RelacionFacturasCacheDataset do
                 begin

                 First;
                 While not Eof do
                   begin

                    RegistroPresentacion.ObtenEstadoPresentacionVerifactu( RelacionFacturasCacheFields.Serie.Value,
                                                                           RelacionFacturasCacheFields.NroFactura.Value,
                                                                           EstadoPresentacionVerifactu,
                                                                           EstadoRegistroVerifactu );

                    If  ( EstadoPresentacionVerifactu=epvPendiente ) or
                        ( ( EstadoPresentacionVerifactu in [ epvPresentado, epvAnulado ] ) and ( EstadoRegistroVerifactu=ervAceptadoConErrores ) and ( RelacionFacturasCacheFields.Seleccionada.Value ) )
                    then begin

                         var RegistroFactura := ObtenRegistroSuministroFactura( RelacionFacturasCacheFields.Serie.Value,
                                                                                RelacionFacturasCacheFields.NroFactura.Value,
                                                                                EstadoPresentacionVerifactu,
                                                                                EstadoRegistroVerifactu );

                         // He optado por suministrarlas una a una para que no se presenten más facturas tras un error

                         If   Assigned( RegistroFactura )
                         then try
                                 SuministraFacturas( [ RegistroFactura ] ) // RegistroFacturasList.Add( RegistroFactura )
                               except on E : Exception do
                                 begin
                                 InvalidaUltimoRegistroPresentacionFactura;
                                 raise;
                                 end
                              end
                         else Abort;   // La notificación del error ya se ha producido

                         end;

                   Next;
                   end;

                 end;

               {
               If   RegistroFacturasList.Count=0
               then begin
                    ShowNotification( ntStop, RsMsg3 );
                    Abort;
                    end;

               SuministraFacturas( Array_Of_RegistroFacturaType( RegistroFacturasList.ToArray ) );
               }

             finally
               RegistroFacturasList.Free;
               end;

             // end;


           (*
           trfAnulacion :
             begin

             RegistroFacturasList := TList< RegistroFacturaType >.Create;

             try

                With RelacionFacturasCacheDataset do
                  begin
                  First;
                  While not Eof do
                    begin

                    If   RelacionFacturasCacheFields.Seleccionada.Value
                    then If   FacturaVentasTable.FindKey( [ RelacionFacturasCacheFields.Ejercicio.Value,
                                                            RelacionFacturasCacheFields.Serie.Value,
                                                            RelacionFacturasCacheFields.NroFactura.Value ] )
                         then begin

                              RegistroPresentacion.ObtenEstadoPresentacionVerifactu( FacturaVentasFields.Serie.Value,
                                                                                     FacturaVentasFields.NroFactura.Value,
                                                                                     EstadoPresentacionVerifactu,
                                                                                     EstadoRegistroVerifactu );

                              If   ( EstadoPresentacionVerifactu=epvPresentado ) or
                                   ( ( EstadoPresentacionVerifactu=epvAnulado ) and ( EstadoRegistroVerifactu=ervAceptadoConErrores ) )
                              then begin

                                   If   Factura.ObtenRegistroComercialFactura( tfFacturaVentas,
                                                                               FacturaVentasFields.Ejercicio.Value,
                                                                               '',
                                                                               FacturaVentasFields.Serie.Value,
                                                                               FacturaVentasFields.NroFactura.Value,
                                                                               FacturaFields )
                                   then begin

                                        var HuellaFacturaAnulada := '';
                                        var SerieNroFacturaAnulada := RegistroPresentacion.SerieNroFactura( FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value );
                                        var FechaHoraPresentacionFactura := Now;

                                        If   Cliente.Obten( FacturaVentasFields.CodigoCliente.Value, '', ClienteFields )
                                        then begin

                                             var CodigoPaisIVA := Cliente.ObtenCodigoPaisIVA( ClienteFields );
                                             var RegistroFactura := RegistroFacturaType.Create;

                                             RegistroFactura.RegistroAnulacion := RegistroAnulacionType.Create;

                                             With RegistroFactura.RegistroAnulacion do
                                               begin

                                               IDVersion := VersionType._1_0;

                                               IDFactura := IDFacturaExpedidaBajaType.Create;
                                               IDFactura.IDEmisorFacturaAnulada := DataModule00.DmEmpresaFields.NIF.Value;
                                               IDFactura.NumSerieFacturaAnulada := SerieNroFacturaAnulada;
                                               IDFactura.FechaExpedicionFacturaAnulada := FormatDateTime( 'dd-mm-yyyy', FacturaVentasFields.Fecha.Value );

                                               var HuellaAnterior := '';

                                               Encadenamiento := Encadenamiento2Type.Create;

                                               If   FacturaVentas.ObtenRegistroPresentacionAnterior( FacturaVentasFields.NroRegistroPresentacion.Value, FacturaVentasAnteriorFields )
                                               then begin
                                                    Encadenamiento.RegistroAnterior := EncadenamientoFacturaAnteriorType.Create;
                                                    With Encadenamiento.RegistroAnterior do
                                                      begin
                                                      IDEmisorFactura := DataModule00.DmEmpresaFields.NIF.Value;
                                                      NumSerieFactura := RegistroPresentacion.SerieNroFactura( FacturaVentasAnteriorFields.Serie.Value, FacturaVentasAnteriorFields.NroFactura.Value );
                                                      FechaExpedicionFactura := FormatDateTime( 'dd-mm-yyyy', FacturaVentasAnteriorFields.Fecha.Value );
                                                      Huella := FacturaVentasAnteriorFields.Huella.Value;
                                                      HuellaAnterior := Huella;
                                                      end;

                                                    end
                                               else Encadenamiento.PrimerRegistro := PrimerRegistroCadenaType.S;

                                               SistemaInformatico := SistemaInformaticoType.Create;
                                               CompletaRegistroSistemaInformatico( SistemaInformatico );

                                               // Voy a suponer que es la hora de presentacion actual, y no la de la presentación de la factura original

                                               FechaHoraHusoGenRegistro := DateTimeToXSDateTime( FechaHoraPresentacionFactura, {ApplyLocalBias} True );
                                               FechaHoraHusoGenRegistro.FractionalSeconds := 0;

                                               TipoHuella := TipoHuellaType._01;

                                               HuellaFacturaAnulada := ObtenHuellaAnulacion( IDFactura.IDEmisorFacturaAnulada,
                                                                                             SerieNroFacturaAnulada,
                                                                                             IDFactura.FechaExpedicionFacturaAnulada,
                                                                                             HuellaAnterior,
                                                                                             FechaHoraHusoGenRegistro );

                                               Huella := HuellaFacturaAnulada;

                                               end;


                                             RegistroFacturasList.Add( RegistroFactura );

                                             end
                                        else ShowNotification( ntStop, Format( RsMsg1, [ FacturaVentasFields.CodigoCliente.Value ] ) );

                                        end
                                   else ShowNotification( ntStop, Format( RsMsg2, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );

                                   end;
                              end
                         else ShowNotification( ntStop, Format( RsMsg2, [ FacturaVentasFields.Serie.Value, FacturaVentasFields.NroFactura.Value ] ) );

                    Next;
                    end;

                  end;

                If   RegistroFacturasList.Count=0
                then begin
                     ShowNotification( ntStop, RsMsg3 );
                     Abort;
                     end;

             PortTypeVerifactu := ( HttpRio as SistemaFacturacion.sfPortTypeVerifactu );

             var SuministroLRFrasEmitidas := RegFactuSistemaFacturacionType.Create;
             var Cabecera := CabeceraType.Create;

             With Cabecera do
               begin
               ObligadoEmision := PersonaFisicaJuridicaESType.Create;
               ObligadoEmision.NombreRazon := DataModule00.DmEmpresaFields.Nombre.Value;
               ObligadoEmision.NIF := DataModule00.DmEmpresaFields.NIF.Value;
               end;

             var ArrayOfRegistroFactura := Array_Of_RegistroFacturaType( RegistroFacturasList.ToArray );

             SuministroLRFrasEmitidas.Cabecera := Cabecera;
             SuministroLRFrasEmitidas.RegistroFactura  := ArrayOfRegistroFactura;

             var RespuestaSuministro := PortTypeVerifactu.RegFactuSistemaFacturacion( SuministroLRFrasEmitidas );   // RespuestaRegFactuSistemaFacturacion

             For var I := 0 to Length( ArrayOfRegistroFactura { RespuestaSuministro } ) - 1 do  // RespuestaSuministro contiene más registros de los enviados (creo que es un problema temporal, como el de RespuestaExpedida.IDFactura )
               begin

               var RespuestaExpedida := RespuestaSuministro.RespuestaLinea[ I ];

               If   Assigned( RespuestaExpedida.IDFactura )
               then NumSerieFactura := RespuestaExpedida.IDFactura.NumSerieFactura
               else NumSerieFactura := ArrayOfRegistroFactura[ I ].RegistroAnulacion.IDFactura.NumSerieFacturaAnulada;

               If   RegistroPresentacion.ExtraeSerieNroFactura( NumSerieFactura, Serie, NroFactura )
               then begin

                    RegistroPresentacion.ActualizaRegistroPresentacionVerifactu( ofvAnulacion,
                                                                                 Serie,
                                                                                 NroFactura,
                                                                                 TEstadoRegistroVerifactu( Ord( RespuestaExpedida.EstadoRegistro ) ),
                                                                                 RespuestaExpedida.CodigoErrorRegistro,
                                                                                 RespuestaExpedida.DescripcionErrorRegistro );

                    If   RespuestaExpedida.CodigoErrorRegistro=0
                    then begin
                         ProcessFrame.AddMsg( ntInformation, Format( RpfMsg23, [ NumSerieFactura ] ) );
                         FacturaVentas.AnulaFactura( Serie, NroFactura  );
                         end
                    else ProcessFrame.AddMsg( ntError, Format( RpfMsg3, [ NumSerieFactura, IntToStr( RespuestaExpedida.CodigoErrorRegistro ) + ' , ' + RespuestaExpedida.DescripcionErrorRegistro  ] ) );
                    end
               else ProcessFrame.AddMsg( ntWarning, Format( RpfMsg18, [ NumSerieFactura ] ) );

               end;

             finally
               RegistroFacturasList.Free;
               end;

             end;

           end;
           *)

       finally
         FreeAndNil( RelacionFacturasCacheFields );
         end;

     except on E : Exception do
       begin
       RegistroPresentacion.ShowError( E );
       raise;
       end;
     end;

end;

end.

